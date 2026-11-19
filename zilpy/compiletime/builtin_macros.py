"""共通マクロ (ランタイムの組み込みとして残すマクロ) の一覧と、作品の定義との比較。

refactor-plan.md §1.8・§2.3。14 作品のどこでも同じ意味に定義されているマクロは、
生成コードでランタイムの組み込み関数 (`VERB_p` など) を呼ぶ。ただし、作品ごとに
その作品の DEFMAC を評価器で展開し、組み込みの「正規の展開」と同じ意味になるかを
確かめてからにする。違えば (作品が違う意味に再定義していれば)、その作品の定義を展開する。

比べ方: マクロごとの試験用の呼び出しを、作品の定義と正規の展開の両方で展開し、
意味の上で同じとみなせる形に正規化 (normalize) してから比べる。
- `<EQUAL? A b c>` は「A が b か c に等しい」。`OR` でつないだ `EQUAL?` は、比べる値の
  集合にまとめる (3 つずつに分ける・並びの順は意味を変えない。どれも副作用のない比較のため)
- `<PROG () s1 s2>` の FSET / FCLEAR の並びは集合にする (別々のフラグを立てるだけなので
  順は意味を変えない)。文が 1 つなら、その文と同じ
- `<PROG () <PUSH X> <RSTACK>>` は `<RETURN X>` と同じ (RFATAL)。`,M-FATAL` は 2
作品の定義の展開が失敗する試験用の呼び出し (例: Deadline の `<VERB? ,X>`。原作でも
展開できない) は、比べる対象から外す。
"""

from __future__ import annotations

from collections.abc import Callable
from dataclasses import dataclass

from zilpy.compiletime.mdl import MdlError, MdlEvaluator
from zilpy.front.nodes import Span, ZExp, ZList, ZNode, ZString, ZSymbol, form_name, is_ignorable, zil_text


def _sym(text: str, span: Span) -> ZSymbol:
    return ZSymbol(text, span)


def _form(span: Span, *items: ZNode) -> ZList:
    return ZList("angle", list(items), span)


def _gval_atom(node: ZNode, prefix: str = "") -> ZNode:
    """アトムなら `,PREFIX名前` に、それ以外 (フォーム・`,X` など) はそのまま。"""
    if isinstance(node, ZSymbol) and node.text[:1] not in (",", "."):
        return _sym("," + prefix + node.text, node.span)
    return node


def _multifrob(var: str, prefix: str = "") -> Callable[[list[ZNode], Span], ZNode]:
    def expand(args: list[ZNode], span: Span) -> ZNode:
        return _form(span, _sym("EQUAL?", span), _sym("," + var, span), *(_gval_atom(a, prefix) for a in args))

    return expand


def _multibits(op: str, joiner: str) -> Callable[[list[ZNode], Span], ZNode]:
    def expand(args: list[ZNode], span: Span) -> ZNode:
        obj, bits = args[0], args[1:]
        parts = [_form(span, _sym(op, span), obj, _gval_atom(b)) for b in bits]
        if joiner == "OR":
            return _form(span, _sym("OR", span), *parts)
        return _form(span, _sym("PROG", span), ZList("paren", [], span), *parts)

    return expand


def _two_bits(op: str, bit1: str, bit2: str) -> Callable[[list[ZNode], Span], ZNode]:
    def expand(args: list[ZNode], span: Span) -> ZNode:
        obj = args[0]
        return _form(
            span,
            _sym(op, span),
            _form(span, _sym("FSET?", span), obj, _sym("," + bit1, span)),
            _form(span, _sym("FSET?", span), obj, _sym("," + bit2, span)),
        )

    return expand


def _abs(args: list[ZNode], span: Span) -> ZNode:
    num = args[0]
    return _form(
        span,
        _sym("COND", span),
        ZList("paren", [_form(span, _sym("L?", span), num, _sym("0", span)), _form(span, _sym("-", span), _sym("0", span), num)], span),
        ZList("paren", [_sym("T", span), num], span),
    )


def _enable(args: list[ZNode], span: Span) -> ZNode:
    return _form(span, _sym("PUT", span), args[0], _sym(",C-ENABLED?", span), _sym("1", span))


def _rfatal(args: list[ZNode], span: Span) -> ZNode:
    return _form(span, _sym("RETURN", span), _sym("2", span))


@dataclass(frozen=True)
class BuiltinMacro:
    """ランタイムの組み込みとして残す共通マクロ。

    Attributes:
        name: マクロの名前。
        runtime: ランタイムの関数名 (RFATAL は変換器が `return 2` にする)。
        expand: 正規の展開 (引数の AST から、展開した式を作る)。
        probes: 試験用の呼び出し (ZIL の形)。
    """

    name: str
    runtime: str
    expand: Callable[[list[ZNode], Span], ZNode]
    probes: tuple[str, ...]


BUILTIN_MACROS: dict[str, BuiltinMacro] = {
    m.name: m
    for m in (
        BuiltinMacro("VERB?", "VERB_p", _multifrob("PRSA", "V?"), ("<VERB? TAKE>", "<VERB? TAKE DROP PUT OPEN>", "<VERB? ,X>")),
        BuiltinMacro("PRSO?", "PRSO_p", _multifrob("PRSO"), ("<PRSO? KNIFE>", "<PRSO? A B C D>", "<PRSO? <LOC ,X>>")),
        BuiltinMacro("PRSI?", "PRSI_p", _multifrob("PRSI"), ("<PRSI? KNIFE>", "<PRSI? A B C D>", "<PRSI? <LOC ,X>>")),
        BuiltinMacro("ROOM?", "ROOM_p", _multifrob("HERE"), ("<ROOM? KITCHEN>", "<ROOM? A B C D>")),
        BuiltinMacro("BSET", "BSET", _multibits("FSET", "PROG"), ("<BSET .X ONBIT>", "<BSET .X ONBIT LIGHTBIT ,FOOBIT>")),
        BuiltinMacro("BCLEAR", "BCLEAR", _multibits("FCLEAR", "PROG"), ("<BCLEAR .X ONBIT>", "<BCLEAR .X ONBIT LIGHTBIT>")),
        BuiltinMacro("BSET?", "BSET_p", _multibits("FSET?", "OR"), ("<BSET? .X ONBIT>", "<BSET? .X ONBIT LIGHTBIT ,FOOBIT>")),
        BuiltinMacro("OPENABLE?", "OPENABLE_p", _two_bits("OR", "DOORBIT", "CONTBIT"), ("<OPENABLE? .OBJ>",)),
        BuiltinMacro("FLAMING?", "FLAMING_p", _two_bits("AND", "FLAMEBIT", "ONBIT"), ("<FLAMING? .OBJ>",)),
        BuiltinMacro("ABS", "ABS", _abs, ("<ABS .N>", "<ABS <- .X .Y>>")),
        BuiltinMacro("ENABLE", "ENABLE", _enable, ("<ENABLE <QUEUE I-FOO 3>>",)),
        BuiltinMacro("RFATAL", "RFATAL", _rfatal, ("<RFATAL>",)),
    )
}


def normalize(node: ZNode) -> object:
    """展開した式を、意味の上で同じとみなせる形にする (モジュールの説明を参照)。"""
    if isinstance(node, ZSymbol):
        text = node.text.upper()
        return ("S", "2" if text == ",M-FATAL" else text)
    if isinstance(node, ZString):
        return ("STR", node.text)
    if isinstance(node, ZExp):
        return ("X", node.kind, normalize(node.item) if node.item is not None else None)
    items = [item for item in node.items if not is_ignorable(item)]
    if node.kind == "paren":
        return ("L", tuple(normalize(item) for item in items))
    name = form_name(node)
    args = items[1:]
    if name in ("EQUAL?", "==?", "=?") and len(args) >= 2:
        first = normalize(args[0])
        return _collapse("OR", {("EQ", first, normalize(arg)) for arg in args[1:]})
    if name == "OR":
        members: set[object] = set()
        for arg in args:
            n = normalize(arg)
            if isinstance(n, tuple) and n[0] == "OR":
                members |= n[1]
            else:
                members.add(n)
        return _collapse("OR", members)
    if name == "PROG" and args and isinstance(args[0], ZList) and args[0].kind == "paren" and not args[0].items:
        body = args[1:]
        if len(body) == 2 and form_name(body[0]) == "PUSH" and form_name(body[1]) == "RSTACK":
            pushed = [i for i in body[0].items[1:] if not is_ignorable(i)]  # type: ignore[union-attr]
            return ("F", (("S", "RETURN"), *(normalize(p) for p in pushed)))
        return _collapse("PROG", {normalize(stmt) for stmt in body})
    return ("F", tuple(normalize(item) for item in items))


def _collapse(kind: str, members: set[object]) -> object:
    if len(members) == 1:
        return next(iter(members))
    return (kind, frozenset(members))


def _parse_call(text: str) -> ZList:
    from zilpy.front.compiler import parse_source  # 遅延 import (ZilCompiler は front の層)

    (node,) = [n for n in parse_source(text) if not is_ignorable(n)]
    assert isinstance(node, ZList)
    return node


@dataclass(frozen=True)
class BuiltinCheck:
    """作品の定義と、組み込みの正規の展開を比べた結果。"""

    same: bool
    compared: int  # 比べた試験用の呼び出しの数
    detail: str  # 違ったときの、試験用の呼び出しと両方の展開


def check_builtin(evaluator: MdlEvaluator, name: str) -> BuiltinCheck:
    """作品の DEFMAC name が、組み込みの正規の展開と同じ意味かを確かめる。

    Args:
        evaluator: 作品の DEFMAC・DEFINE を登録した評価器。
        name: 共通マクロの名前 (BUILTIN_MACROS のキー)。

    Returns:
        比べた結果。作品の定義が展開できる試験用の呼び出しが 1 つもなければ、同じとしない。
    """
    builtin = BUILTIN_MACROS[name]
    compared = 0
    for probe in builtin.probes:
        call = _parse_call(probe)
        args = [item for item in call.items[1:] if not is_ignorable(item)]
        try:
            game = evaluator.expand(name, args, call.span)
        except MdlError:
            continue  # 作品の定義で展開できない呼び出しは、作品では書けない
        canonical = builtin.expand(args, call.span)
        compared += 1
        if normalize(game) != normalize(canonical):
            return BuiltinCheck(False, compared, f"{probe}: {zil_text(game)} / builtin: {zil_text(canonical)}")
    if compared == 0:
        return BuiltinCheck(False, 0, "no test call could be expanded with the game's definition")
    return BuiltinCheck(True, compared, "")