"""作品ごとのマクロの登録と、マクロごとの扱いの決定 (refactor-plan.md Phase 3)。

走査の段階で、作品の DEFMAC と DEFINE を評価器 (mdl.py) に登録し、全ファイルを
走査し終えたら (finalize)、マクロごとに扱いを決める。

- EXPAND: 呼び出しの位置で、評価器で展開する
- BUILTIN: 共通マクロ。作品の定義が組み込みと同じ意味なので、ランタイムの組み込みを呼ぶ
  (builtin_macros.py)
- RUNTIME: 展開しない (TELL と、PROB の修正前)。ランタイムの同じ名前の関数を呼ぶ
- GAME: 同じ名前の ROUTINE があるので、マクロは使われない (§1.7)

展開できなかった呼び出しは、警告を出してランタイムの同じ名前の関数に任せる。
"""

from __future__ import annotations

import sys
from collections import Counter
from collections.abc import Iterable
from dataclasses import dataclass, field
from pathlib import Path

from zilpy.compiletime.builtin_macros import BUILTIN_MACROS, check_builtin
from zilpy.constants import DECLARATION_FORMS, INTEGER_RE
from zilpy.compiletime.mdl import FALSE, Atom, MdlError, MdlEvaluator
from zilpy.compiletime.static_eval import zilch_branch
from zilpy.compiletime.macro_functions import MacroFunction, analyze, is_plain_atom
from zilpy.compiletime.purity import is_pure
from zilpy.front.nodes import Span, ZExp, ZList, ZNode, ZSymbol, form_name, is_ignorable, to_identifier, zil_text

EXPAND = "expand"
BUILTIN = "builtin"
RUNTIME = "runtime"
GAME = "game"

# 評価器で展開しないマクロと、その理由
NOT_EXPANDED: dict[str, str] = {
    # §4 の 2: TELL は、出力を TELL(...) の形のまま保つ (書式指定子の対応表だけを使う)
    "TELL": "TELL is kept as TELL(...) (refactor-plan.md §4 #2)",

}


@dataclass
class MacroInfo:
    """作品の DEFMAC 1 つ。"""

    name: str  # ZIL の表記
    file: str  # 定義のあるファイル名
    span: Span
    source: str  # 定義の原文
    decision: str = EXPAND
    reason: str = ""

    @property
    def location(self) -> str:
        return f"{self.file}:{self.span.line}"


@dataclass
class MacroRegistry:
    """1 作品のマクロ。"""

    evaluator: MdlEvaluator = field(default_factory=MdlEvaluator)
    macros: dict[str, MacroInfo] = field(default_factory=dict)
    routine_names: set[str] = field(default_factory=set)
    not_expanded: dict[str, str] = field(default_factory=lambda: dict(NOT_EXPANDED))
    calls: Counter[str] = field(default_factory=Counter)  # 展開した呼び出しの数
    # ソースに書かれた呼び出しの数 (走査の段階で数える。DEFMAC・DEFINE の本体の中は数えない)
    written_calls: Counter[str] = field(default_factory=Counter)
    # DEFINE の原文 (名前 -> MacroInfo)。マクロの補助の DEFINE をコメントで残すのに使う
    defines: dict[str, MacroInfo] = field(default_factory=dict)
    # DEFMAC・DEFINE の本体に出てくる名前 (別のマクロから呼ばれるマクロを、未使用と言わないため)
    _names_in_definitions: set[str] = field(default_factory=set)
    failures: dict[tuple[str, str], int] = field(default_factory=dict)  # (名前, 理由) -> 数
    # マクロの別名 (<SETG RARG? ,CONTEXT?>): 別名 -> 元のマクロの名前 (大文字)
    aliases: dict[str, str] = field(default_factory=dict)
    # ソースに書かれた呼び出しの、引数の数ごとの数: 名前 -> {引数の数: 数}
    written_arities: dict[str, Counter[int]] = field(default_factory=dict)
    # マクロの関数化 (macro_functions.py)。functions_enabled が偽なら、関数を作らない
    functions_enabled: bool = True
    functions: dict[tuple[str, int], MacroFunction] = field(default_factory=dict)
    no_function: dict[str, str] = field(default_factory=dict)  # 関数にしなかった理由
    # 共通マクロの組み込みを上書きする関数の名前 (識別子。例: 作品の ENABLE が組み込みと違うとき)
    overrides: set[str] = field(default_factory=set)
    function_calls: Counter[str] = field(default_factory=Counter)  # 関数を呼んだ呼び出しの数
    expanded_reasons: Counter[tuple[str, str]] = field(default_factory=Counter)  # 展開した理由
    _finalized: bool = False

    # -------------------------------------------------- 走査

    def scan(self, ast: Iterable[ZNode], path: Path, source: str) -> None:
        """1 ファイルのトップレベルの DEFMAC・DEFINE・ROUTINE を登録する。

        `<COND (<GASSIGNED? ZILCH> ...) (ELSE ...)>` は、コンパイラが選ぶ節だけを読む。
        """
        for node in _top_forms(ast):
            name = form_name(node)
            if not isinstance(node, ZList):
                continue
            items = [item for item in node.items[1:] if not is_ignorable(item)]
            if not items or not isinstance(items[0], ZSymbol):
                continue
            if name == "ROUTINE":
                self.routine_names.add(items[0].text.upper())
            if name in ("DEFINE", "DEFMAC"):
                fn = self.evaluator.define(node)
                if fn is not None:
                    text = source[node.span.start : node.span.end]
                    info = MacroInfo(items[0].text, path.name, node.span, text)
                    if name == "DEFMAC":
                        self.macros[items[0].text.upper()] = info
                    else:
                        self.defines[items[0].text.upper()] = info
                self._names_in_definitions |= _symbol_names(node.items[2:])
            else:
                _count_calls(node, self.written_calls, self.written_arities)
            if name == "SETG" and len(items) == 2:
                self._record_setg(items[0].text, items[1])

    def _record_setg(self, name: str, value: ZNode) -> None:
        """トップレベルの SETG を、評価器のコンパイル時のグローバルとして覚える。

        値が T・<>・数値なら、その値。`,X` (別のグローバルの値) なら、マクロの別名の候補
        (X がマクロなら、finalize で別名にする)。
        """
        if isinstance(value, ZSymbol):
            text = value.text
            if text.upper() == "T":
                self.evaluator.globals[name] = Atom("T")
            elif INTEGER_RE.fullmatch(text):
                self.evaluator.globals[name] = int(text)
            elif text.startswith(",") and len(text) > 1:
                self.aliases[name.upper()] = text[1:].upper()
        elif isinstance(value, ZList) and value.kind == "angle" and not value.items:
            self.evaluator.globals[name] = FALSE

    def finalize(self, global_names: set[str] | None = None, static_values: dict[str, int] | None = None) -> None:
        """全ファイルを走査したあとで、マクロごとの扱いを決める。

        扱いが EXPAND のマクロは、関数にできるかも調べる (functions_enabled のとき)。
        作った関数の名前は global_names (共有名) に足す (呼び出しを ZG.NAME にするため)。

        global_names と static_values は、マクロの中の `<GASSIGNED? X>` の判定にも使う
        (static_eval.gassigned。StaticEvaluator と同じ規則。例: Moonmist の GET/B の PLUS-MODE)。
        """
        if global_names is not None:
            self.evaluator.defined_names = global_names
        if static_values is not None:
            self.evaluator.static_values = static_values
        # 別名は、元の名前がマクロのものだけを残す
        self.aliases = {alias: target for alias, target in self.aliases.items() if target in self.macros}
        for key, info in self.macros.items():
            if key in self.routine_names:
                info.decision, info.reason = GAME, "a ROUTINE with the same name is used (§1.7)"
            elif key in self.not_expanded:
                info.decision, info.reason = RUNTIME, self.not_expanded[key]
            elif key in BUILTIN_MACROS:
                result = check_builtin(self.evaluator, key)
                if result.same:
                    info.decision = BUILTIN
                    info.reason = f"same as the builtin {BUILTIN_MACROS[key].runtime} ({result.compared} test calls)"
                else:
                    info.decision = EXPAND
                    info.reason = f"differs from the builtin: {result.detail}"
            else:
                info.decision, info.reason = EXPAND, ""
        if self.functions_enabled:
            for key, info in self.macros.items():
                if info.decision == EXPAND and not self.is_unused(key):
                    self._make_functions(key, info, global_names if global_names is not None else set())
        self._finalized = True

    def _make_functions(self, key: str, info: MacroInfo, global_names: set[str]) -> None:
        arities = sorted(self.written_arities.get(key, {}))
        if not arities:
            self.no_function[key] = "called only from other macros"
            return
        reasons = []
        fn_def = self.evaluator.functions[key]
        varargs = any(p.section in ("args", "tuple") for p in fn_def.params)
        # 共通マクロの定義が組み込みと違うとき (§4 の 8): 引数の数が決まっているマクロは、
        # 組み込みと同じ名前の関数にして上書きする。引数の数が変わるマクロは、1 つの関数に
        # できないので、引数の数ごとの関数にする (組み込みを、決まった数の引数の関数で隠さない)
        builtin = key in BUILTIN_MACROS
        for arity in arities:
            if builtin and varargs:
                name = f"{info.name}-{arity}"
            else:
                name = info.name if len(arities) == 1 else f"{info.name}-{arity}"
            ident = to_identifier(name)
            if ident in global_names or name.upper() in self.routine_names:
                reasons.append(f"{arity} args: the name {ident} is already used")
                continue
            fn, reason = analyze(self.evaluator, key, arity, name, self._name_forms())
            if fn is None:
                reasons.append(f"{arity} args: {reason}")
                continue
            self.functions[(key, arity)] = fn
            global_names.add(ident)
            if builtin and name == info.name:
                self.overrides.add(ident)
        if reasons:
            self.no_function[key] = "; ".join(reasons)

    def _name_forms(self) -> frozenset[str]:
        """引数を名前として扱うことがあるフォーム (作品のマクロと、VERB? などの宣言フォーム)。"""
        return frozenset(self.macros) | frozenset(self.aliases) | DECLARATION_FORMS

    def functions_of(self, name: str) -> list[MacroFunction]:
        """マクロ name から作った関数 (引数の数の順)。"""
        key = self.resolve(name)
        return [fn for (macro, _), fn in sorted(self.functions.items()) if macro == key]

    def function_call(self, name: str, args: list[ZNode], expanded: ZNode, span: Span) -> tuple[ZNode | None, str]:
        """マクロの呼び出しを、関数の呼び出しにできるなら、その式を返す。

        Args:
            name: マクロの名前。
            args: 呼び出しの引数。
            expanded: 呼び出しを評価器で展開した式。
            span: 呼び出しの位置。

        Returns:
            (関数の呼び出しの式, 展開したときの理由)。関数を呼べないなら式は None。
            関数のないマクロなら理由は空。
        """
        key = self.resolve(name)
        fn = self.functions.get((key, len(args)))
        if fn is None:
            return None, ""
        passed: list[ZNode] = []
        for arg, template in zip(args, fn.atom_templates):
            if is_plain_atom(arg):
                if template is None:
                    return self._expanded(key, "atom argument"), "atom argument"
                passed.append(ZSymbol(template.format(arg.text), arg.span))  # type: ignore[union-attr]
            else:
                passed.append(arg)
        if zil_text(fn.instantiate(passed)) != zil_text(expanded):
            return self._expanded(key, "the expansion has a different shape"), "the expansion has a different shape"
        if not fn.always and not all(is_pure(arg) for arg in passed):
            return self._expanded(key, "副作用のある引数"), "副作用のある引数"
        self.function_calls[key] += 1
        return ZList("angle", [ZSymbol(fn.name, span), *passed], span), ""

    def _expanded(self, key: str, reason: str) -> None:
        self.expanded_reasons[(key, reason)] += 1

    # -------------------------------------------------- 変換

    def resolve(self, name: str) -> str:
        """マクロの別名 (RARG?) を、元のマクロの名前 (CONTEXT?) にする。"""
        return self.aliases.get(name.upper(), name.upper())

    def decision(self, name: str) -> str | None:
        """マクロ name の扱い。作品のマクロでなければ None。"""
        info = self.macros.get(self.resolve(name))
        return None if info is None else info.decision

    def is_alias_setg(self, node: ZList) -> bool:
        """`<SETG RARG? ,CONTEXT?>` のような、マクロの別名を作る SETG か。"""
        items = [item for item in node.items[1:] if not is_ignorable(item)]
        return (
            len(items) == 2
            and isinstance(items[0], ZSymbol)
            and items[0].text.upper() in self.aliases
        )

    def expanded_names(self) -> set[str]:
        return {key for key, info in self.macros.items() if info.decision == EXPAND}

    def expand(self, name: str, args: list[ZNode], span: Span) -> ZNode:
        """マクロを展開する。展開できなければ MdlError。"""
        key = self.resolve(name)
        result = self.evaluator.expand(key, args, span)
        self.calls[key] += 1
        return result

    def warn(self, name: str, call: ZNode, error: MdlError) -> None:
        """展開できなかった呼び出しを数え、マクロと理由ごとに 1 度だけ警告を出す。"""
        key = (name.upper(), str(error))
        self.failures[key] = self.failures.get(key, 0) + 1
        if self.failures[key] == 1:
            info = self.macros[self.resolve(name)]
            print(
                f"Warning: macro {info.name} ({info.location}) not expanded at line {call.span.line}"  # type: ignore[union-attr]
                f": {error}; the runtime function is used ({_shorten(zil_text(call))})",
                file=sys.stderr,
            )


    def report(self) -> str:
        """マクロごとの扱いと、呼び出しの数の一覧 (macro-report.txt)。

        変換し終えてから作る (展開した呼び出しの数は、変換の間に数える)。
        """
        lines = [
            "# 作品のマクロ (DEFMAC) の扱い (refactor-plan.md Phase 3)",
            "# 名前\t扱い\t定義の場所\tソースの呼び出し\t展開した呼び出し\tうち関数の呼び出し\t理由",
            "# 扱い: expand=展開する builtin=ランタイムの組み込み runtime=展開しない game=同じ名前の ROUTINE unused=呼び出しがない",
            "# ソースの呼び出しには、%<COND ...> で変換時に選ばれない節の中のものも入る (展開した呼び出しより多くなる)",
        ]
        for key in sorted(self.macros):
            info = self.macros[key]
            decision = "unused" if self.is_unused(key) else info.decision
            lines.append(
                f"{info.name}\t{decision}\t{info.location}\t{self.written_calls[key]}\t{self.calls[key]}"
                f"\t{self.function_calls[key]}\t{info.reason}"
            )
        lines.append("# マクロの関数化 (関数: 関数の名前 (引数) / 関数にしなかった理由 / 展開した呼び出しの理由と数)")
        for key in sorted(self.macros):
            fns = self.functions_of(key)
            if fns:
                sigs = ", ".join(f"{fn.name} ({' '.join(fn.params)}){'' if fn.always else ' [pure args only]'}" for fn in fns)
                lines.append(f"{self.macros[key].name}\tfunction\t{sigs}")
            if key in self.no_function:
                lines.append(f"{self.macros[key].name}\tno function\t{self.no_function[key]}")
            for (macro, reason), count in sorted(self.expanded_reasons.items()):
                if macro == key:
                    lines.append(f"{self.macros[key].name}\texpanded\t{count}\t{reason}")
        if self.aliases:
            lines.append("# マクロの別名 (<SETG 別名 ,マクロ>)")
            lines += [f"{alias}\t-> {target}" for alias, target in sorted(self.aliases.items())]
        lines.append("# 展開できなかった呼び出し (ランタイムの同じ名前の関数を使った)")
        if self.failures:
            lines += [f"{name}\t{count}\t{reason}" for (name, reason), count in sorted(self.failures.items())]
        else:
            lines.append("(なし)")
        return "\n".join(lines) + "\n"

    def is_unused(self, name: str) -> bool:
        """マクロ name が、ソースのどこからも呼ばれていないか。"""
        key = name.upper()
        return self.written_calls[key] == 0 and key not in self._names_in_definitions


def _count_calls(node: ZNode, counter: Counter[str], arities: dict[str, Counter[int]]) -> None:
    """フォームの先頭の名前と、その引数の数を数える。"""
    if isinstance(node, ZList):
        name = form_name(node)
        if name is not None:
            counter[name] += 1
            nargs = sum(1 for item in node.items[1:] if not is_ignorable(item))
            arities.setdefault(name, Counter())[nargs] += 1
        for item in node.items:
            _count_calls(item, counter, arities)
    elif isinstance(node, ZExp) and node.item is not None and not is_ignorable(node):
        _count_calls(node.item, counter, arities)  # コメント (;) の中は数えない


def _symbol_names(nodes: Iterable[ZNode]) -> set[str]:
    """ノードの中に出てくるアトムの名前 (大文字)。"""
    names: set[str] = set()

    def walk(node: ZNode) -> None:
        if isinstance(node, ZSymbol):
            names.add(node.text.lstrip(",.'").upper())
        elif isinstance(node, ZList):
            for item in node.items:
                walk(item)
        elif isinstance(node, ZExp) and node.item is not None:
            walk(node.item)

    for node in nodes:
        walk(node)
    return names


def _shorten(text: str, limit: int = 80) -> str:
    return text if len(text) <= limit else text[: limit - 3] + "..."


def _top_forms(nodes: Iterable[ZNode]) -> Iterable[ZNode]:
    for node in nodes:
        branch = zilch_branch(node)
        if branch is not None:
            yield from _top_forms(branch)
        else:
            yield node
