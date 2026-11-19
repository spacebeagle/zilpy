"""ZIL の AST を Python ソースコードへ変換する。"""

from collections.abc import Callable
from collections.abc import Iterable
import keyword
import re
import textwrap

from zilpy.constants import (
    ARITH_OPS,
    ATOM_PROPERTIES,
    BUILTIN_TELL_PRINTERS,
    COMPARE_OPS,
    DECLARATION_FORMS,
    GLOBAL_MODULE,
    GLOBALS_NAME,
    INC_TESTS,
    INDENT_UNIT,
    INTEGER_RE,
    OCTAL_RE,
    PROPERTY_PREFIX,
    RETURN_CONSTANTS,
    RUNTIME_MODULE,
    RUNTIME_TELL_TOKENS,
    PART_PREFIXES,
    SYMBOL_FUNCTION,
    SYMBOLIC_PREFIXES,
    TABLE_FORMS,
    TEMP_PREFIX,
    TRUE_TESTS,
    WORD_FUNCTION,
    WORD_PREFIX,
    ZERO_TESTS,
)
from zilpy.backend.global_file import ZilGlobalFile
from zilpy.backend.mode import DISCARD_MODE, Mode, RETURN_MODE
from zilpy.front.nodes import (
    ZExp,
    ZList,
    ZNode,
    ZString,
    ZSymbol,
    contains_bare_again,
    form_name,
    is_false_constant,
    is_ignorable,
    needs_statement,
    to_identifier,
)
from zilpy.front.nodes import local_name as _local_name
from zilpy.backend.base import TranscoderBase
from zilpy.compiletime.macro_registry import MacroRegistry
from zilpy.backend.runtime_names_python import RUNTIME_NAMES
from zilpy.compiletime.lowering import parse_params, referenced_locals
from zilpy.compiletime.names import GAME


def local_name(name: str) -> str:
    """ZIL のローカル変数名を、Python のローカル変数名へ変換する (zilpy.front.nodes.local_name)。"""
    return _local_name(name, RUNTIME_NAMES)


class ZilToPythonTranscoder(TranscoderBase):
    """ZIL の AST を Python ソースコードへ変換するクラス。

    文の振り分けや一時変数の巻き上げなど、言語に依存しない部分は TranscoderBase。
    このクラスは Python の文字列を生成する部分だけを持つ。
    """

    TRUE = "True"
    FALSE = "False"
    RETURN_CONSTANTS = RETURN_CONSTANTS
    COMMENT = "#"
    AGAIN_LINES = ["continue"]
    PSEUDO_TRIPLES_CALL = f"{GLOBALS_NAME}.dictionary.use_pseudo_triples()"

    def __init__(
        self,
        ast: list[ZNode],
        insert_file: Callable[[str], str | None] | None = None,
        global_names: frozenset[str] | set[str] = frozenset(),
        global_file: ZilGlobalFile | None = None,
        source_name: str = "",
        flag_names: frozenset[str] | set[str] = frozenset(),
        object_names: frozenset[str] | set[str] = frozenset(),
        static_values: dict[str, int] | None = None,
        macros: MacroRegistry | None = None,
        tell_indicators: dict[str, tuple[str, bool]] | None = None,
    ) -> None:
        """ZilToPythonTranscoder を初期化する (引数は TranscoderBase と同じ)。"""
        super().__init__(
            ast,
            insert_file=insert_file,
            global_names=global_names,
            global_file=global_file,
            source_name=source_name,
            flag_names=flag_names,
            object_names=object_names,
            static_values=static_values,
            macros=macros,
            tell_indicators=tell_indicators,
        )
        self.global_file: ZilGlobalFile | None = global_file
        # トップレベル宣言の変換ハンドラ
        self._toplevel_handlers: dict[str, Callable[[ZList], list[str]]] = {
            "INSERT-FILE": self.transcode_insert_file,
            "ROUTINE": self.transcode_routine,
            "DEFINE": self.transcode_routine,
            "GLOBAL": self.transcode_global,
            "CONSTANT": self.transcode_constant,
            "SETG": self.transcode_setg,
            "OBJECT": self.transcode_object,
            "ROOM": self.transcode_object,
            "DEFMAC": self.transcode_defmac,
            "COND": self.transcode_toplevel_cond,
            # 文字列の圧縮を切り替えるコンパイル時の指示 (AMFV)。Python では何もしない
            "ZSTR-ON": lambda node: ["# ZSTR-ON: string compression switch (not transcoded)"],
            "ZSTR-OFF": lambda node: ["# ZSTR-OFF: string compression switch (not transcoded)"],
            # TELL の書式指定子の宣言。ProjectBuilder が読んで tell_indicators に渡す
            "TELL-TOKENS": lambda node: ["# TELL-TOKENS: TELL indicators (read at transcode time)"],
        }

    # ------------------------------------------------------------------
    # TranscoderBase のフック
    # ------------------------------------------------------------------

    def _str(self, text: str) -> str:
        """Python の文字列リテラル。"""
        return repr(text)

    def _loop_exit(self, brk: str | None) -> list[str]:
        """囲んでいるループを抜ける文。"""
        return ["break"]

    def _function_separator(self) -> list[str]:
        """マクロから作った関数の定義の前に入れる空行。"""
        return [""]

    def _runtime_fn(self, name: str) -> str:
        """ランタイムの関数は `from ZilRuntime import *` で見えている。"""
        return name

    def _plain_ident(self, text: str) -> str:
        """接頭辞のないアトムを、そのまま識別子にしたときの表記。"""
        return to_identifier(text)

    def transcode(self) -> str:
        """AST 全体を走査して Python コードを生成する。

        Returns:
            生成された Python ソースコード。
        """
        header = (
            "# --- Auto-generated Python code from ZIL ---\n"
            "import sys\n\n"
            f"from {RUNTIME_MODULE} import *"
        )
        if self.global_file is not None:
            header += f"\nimport {GLOBAL_MODULE}  # noqa: F401  (グローバル宣言を登録する)"
        chunks = [header]
        for node in self.ast:
            lines = self._with_notes(lambda: self._toplevel(node))
            if lines:
                chunks.append("\n".join(lines))
        return "\n\n".join(chunks)

    def _toplevel_lines(self, node: ZNode) -> list[str]:
        """トップレベルの 1 ノードを Python の文の並びに変換する (位置の注記は TranscoderBase._toplevel)。

        Args:
            node: トップレベルのノード。

        Returns:
            生成された行のリスト。
        """
        if (
            isinstance(node, ZSymbol)
            and not is_ignorable(node)
            and node.text.isprintable()
            and not node.text.startswith(("\\", ",", "."))
        ):
            # トップレベルにアトムだけを書いても何も起きない
            # (例: Zork II の ON!-INITIAL。MDL のアトムを作るだけ)。
            # 改ページ・文字リテラル・変数参照は従来どおりに扱う
            return [f"# {node.text}: top-level atom (no effect)"]
        saved, self._pre = self._pre, []
        try:
            handler = self._toplevel_handlers.get(form_name(node) or "")
            if handler is not None and isinstance(node, ZList):
                lines = handler(node)
            else:
                directive = self._directive_lines(node)
                lines = directive if directive is not None else self._stmt(node, DISCARD_MODE)
            return self._pre + lines
        finally:
            self._pre = saved

    def transcode_insert_file(self, node: ZList) -> list[str]:
        """<INSERT-FILE "NAME"> を変換済みモジュールの import 文に変換する。

        参照先ファイルの変換と出力は insert_file コールバックが行う。

        Args:
            node: INSERT-FILE フォーム。

        Returns:
            import 文 (失敗時はコメント) の行のリスト。
        """
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if self.insert_file is None or not (args and isinstance(args[0], ZString)):
            return self._fallback(node, DISCARD_MODE)
        file_name = args[0].text
        module = self.insert_file(file_name)
        if module is None:
            return [f"# INSERT-FILE {file_name!r}: not transcoded"]
        return [f"from {module} import *"]

    def transcode_routine(self, node: ZList) -> list[str]:
        """<ROUTINE NAME (ARGS) BODY...> を def NAME(args): に変換する。

        本体の最後の式の値を関数の戻り値とする (ZIL の暗黙の戻り値)。

        Args:
            node: ROUTINE または DEFINE フォーム。

        Returns:
            関数定義の行のリスト。
        """
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 3 or not isinstance(items[1], ZSymbol):
            return self._fallback(node, DISCARD_MODE)
        skipped = self._compile_time_define(node, items)
        if skipped is not None:
            return skipped
        rest = items[2:]
        if isinstance(rest[0], ZSymbol) and len(rest) > 1:
            rest = rest[1:]  # 活性化名 (activation) は無視する
        args_node, body = rest[0], rest[1:]
        body, silenced = self._silenced_body(items[1].text, body)
        block_body = body if silenced else self._body_with_comments(node, args_node, body)

        saved = (self._in_function, self._loops, self._temp_count)
        self._in_function, self._loops = True, []
        self._temp_count = 0
        try:
            params, prologue, bound = self._routine_params(args_node)
            self._record_definition(node)  # トップレベルの PROG などの中のルーチンも載せる
            self._record_locals(items[1].text, args_node, body)
            if any(contains_bare_again(item) for item in body):
                # ルーチン直下の AGAIN は本体の先頭からやり直す
                self._loops.append((RETURN_MODE, None))
                loop_body = self._block(block_body, RETURN_MODE) + ["break"]
                body_lines = ["while True:", self._indent(loop_body)]
            else:
                body_lines = self._block(block_body, RETURN_MODE)
        finally:
            self._in_function, self._loops, self._temp_count = saved
        prologue = prologue + self._undeclared_locals(body, bound, body_lines)

        name = to_identifier(items[1].text)
        return silenced + [
            f"@{GLOBALS_NAME}.routine({items[1].text!r})",
            f"def {name}({', '.join(params)}):",
            self._indent(prologue + body_lines),
        ]

    def _undeclared_locals(
        self, body: list[ZNode], bound: set[str], body_lines: list[str]
    ) -> list[str]:
        """どこにも宣言・代入がないのに参照されるローカル変数の初期化文を作る。

        ZIL のコンパイラは、宣言のないローカル変数 (例: VILLAIN-BLOW の
        `.HERO?`) をそのまま通し、値は 0 になる。Python では NameError に
        なるため、先頭で 0 に初期化する。

        Args:
            body: ルーチン本体のノード。
            bound: 仮引数と AUX で宣言された変数名。
            body_lines: 生成した本体のコード。代入されている変数を調べるのに使う。

        Returns:
            `NAME = 0` の文のリスト。
        """
        used = dict.fromkeys(local_name(text) for text in referenced_locals(body))
        code = "\n".join(body_lines)
        return [
            f"{name} = 0"
            for name in used
            if name not in bound
            and not re.search(rf"(?<![\w.]){re.escape(name)}\s*:?=(?!=)", code)
            and not re.search(rf"\bfor {re.escape(name)}\b", code)
        ]

    def _routine_params(
        self, args_node: ZNode
    ) -> tuple[list[str], list[str], set[str]]:
        """ROUTINE の引数リストを Python の仮引数と初期化文に変換する。

        引数リストの解釈は lowering.parse_params。省略可能引数は既定値 None、
        `"AUX"` 以降はローカル変数、可変長引数は `*NAME` にする。
        `(NAME VALUE)` の初期値は関数本体の先頭で評価する。

        Args:
            args_node: ROUTINE の引数リスト。

        Returns:
            (仮引数のリスト, 初期化文のリスト, 引数・ローカル変数名の集合)。
        """
        params: list[str] = []
        prologue: list[str] = []
        names: set[str] = set()
        for param in parse_params(args_node):
            name = self._param_name(param.name)
            names.add(name)
            if param.section == "aux":
                if param.default is None:
                    prologue.append(f"{name} = 0")
                else:
                    prologue += self._stmt(param.default, Mode("assign", name))
            elif param.section == "opt":
                params.append(f"{name}=None")
                if param.default is not None:
                    init = self._stmt(param.default, Mode("assign", name))
                    prologue += [f"if {name} is None:", self._indent(init)]
            elif param.section == "rest":
                params.append(f"*{name}")
            else:
                params.append(name)
        return params, prologue, names

    def _param_name(self, node: ZNode, local: bool = True) -> str:
        """仮引数や束縛のノードから変数名を取り出す。

        Args:
            node: シンボル、またはクオートなどで修飾されたシンボル。

        Returns:
            Python の識別子。
        """
        while isinstance(node, ZExp) and node.item is not None:
            node = node.item
        if not isinstance(node, ZSymbol):
            return "_"
        return local_name(node.text) if local else to_identifier(node.text)

    def _lazy_declaration(
        self,
        name: str,
        build: Callable[[], str],
        zil_name: str | None = None,
        category: str = "state",
    ) -> tuple[list[str], str]:
        """値を最初の参照時に評価する宣言 (ZG.const/state/scratch._declare, world.declare_object) の行を作る。

        値の式の前に文を巻き上げる必要がある場合は、関数定義として出力する。

        Args:
            name: Python の識別子に変換済みの名前。
            build: 値の式を生成する関数。オブジェクトの場合はプロパティの辞書。
            zil_name: オブジェクトの宣言の場合、ZIL 上の名前 (Python のリテラル
                表記)。GLOBAL / CONSTANT の場合は None。
            category: GLOBAL / CONSTANT / SETG の分類 ('const', 'state', 'scratch')。

        Returns:
            (宣言の行のリスト, 値を表す式)。
        """
        pre, value = self._capture(build)
        if zil_name is None:
            declare = f"{GLOBALS_NAME}.{category}._declare({name!r}, "
        else:
            declare = f"{GLOBALS_NAME}.world.declare_object({name!r}, {zil_name}, "
        if not pre:
            return [f"{declare}lambda: {value})"], value
        func = f"_init_{name}"
        body = self._indent(pre + [f"return {value}"])
        return [f"def {func}():", body, f"{declare}{func})"], value

    def _global_category(self, name: str, kind: str) -> str:
        """GLOBAL / CONSTANT / SETG を 'const'・'state'・'scratch' に分類する。"""
        if kind in ("CONSTANT", "SETG"):
            return "const"
        if self.source_name in ("gparser", "parser") or name.startswith("P_"):
            return "scratch"
        return "state"

    def _transcode_global_declaration(self, node: ZList, kind: str) -> list[str]:
        """<GLOBAL|CONSTANT NAME VALUE> を ZilGlobal.py への宣言に変換する。

        元の宣言は、取り除かずにコメントとして元のモジュールに残す。

        Args:
            node: GLOBAL、CONSTANT または SETG フォーム。
            kind: コメントに書くフォーム名。

        Returns:
            元のモジュールに出力する行のリスト (宣言そのもののコメント)。
        """
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 2 or not isinstance(items[1], ZSymbol):
            return self._fallback(node, DISCARD_MODE)
        name = to_identifier(items[1].text)
        init = items[2] if len(items) > 2 else None
        category = self._global_category(name, kind)
        declaration, value = self._lazy_declaration(
            name,
            lambda: "None" if init is None else self._expr(init),
            category=category,
        )
        if self.global_file is None:
            return declaration
        self.global_file.add(
            self.source_name, self._location_lines(node) + declaration, name=name, value=value, category=category
        )
        return [f"# {kind} ({category}) {name} = {value}  ->  {GLOBAL_MODULE}.py"]

    def transcode_global(self, node: ZList) -> list[str]:
        """<GLOBAL NAME VALUE> を ZilGlobal.py への宣言に変換する。

        Args:
            node: GLOBAL フォーム。

        Returns:
            元のモジュールに残すコメントの行のリスト。
        """
        return self._transcode_global_declaration(node, "GLOBAL")

    def transcode_constant(self, node: ZList) -> list[str]:
        """<CONSTANT NAME VALUE> を ZilGlobal.py への宣言に変換する。

        Args:
            node: CONSTANT フォーム。

        Returns:
            元のモジュールに残すコメントの行のリスト。
        """
        return self._transcode_global_declaration(node, "CONSTANT")

    def transcode_setg(self, node: ZList) -> list[str]:
        """トップレベルの <SETG NAME VALUE> を ZilGlobal.py への宣言に変換する。

        トップレベルの SETG はコンパイル時の定義 (例: ZORK-NUMBER) なので、
        GLOBAL と同じく宣言として扱う。

        Args:
            node: SETG フォーム。

        Returns:
            元のモジュールに残すコメントの行のリスト。
        """
        if self.macros.is_alias_setg(node):
            return ["# SETG: compile-time macro alias (not transcoded)"]
        return self._transcode_global_declaration(node, "SETG")

    def transcode_object(self, node: ZList) -> list[str]:
        """<OBJECT NAME (PROP VAL...)...> を ZG._declare_object(...) に変換する。

        プロパティは辞書として渡し、ランタイムが OBJECT として登録する。
        他のオブジェクトやルーチンを前方参照できるよう、生成は最初の参照時
        (または ZG._link) まで遅らせる。

        Args:
            node: OBJECT または ROOM フォーム。

        Returns:
            オブジェクト宣言の行のリスト。
        """
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 2:
            return self._fallback(node, DISCARD_MODE)
        name = self._param_name(items[1], local=False)
        head = items[1]
        while isinstance(head, ZExp) and head.item is not None:
            head = head.item
        zil_name = repr(head.text) if isinstance(head, ZSymbol) else repr(name)
        lines, _ = self._lazy_declaration(
            name, lambda: self._object_expr(zil_name, items[2:]), zil_name
        )
        return lines

    def _object_expr(self, zil_name: str, prop_nodes: list[ZNode]) -> str:
        """オブジェクトのプロパティをプロパティ辞書の式に変換する。

        Args:
            zil_name: ZIL 上のオブジェクト名 (Python のリテラル表記)。
            prop_nodes: プロパティのノードの並び。

        Returns:
            プロパティ名と値の辞書を表す Python の式。
        """
        properties: list[str] = []
        for prop_node in prop_nodes:
            if not isinstance(prop_node, ZList):
                continue
            parts = [item for item in prop_node.items if not is_ignorable(item)]
            if not parts:
                continue
            head = parts[0]
            if (
                isinstance(head, ZSymbol)
                and head.text.upper() in ("IN", "LOC")
                and len(parts) == 3
                and isinstance(parts[1], ZSymbol)
                and parts[1].text.upper() == "TO"
            ):
                # 自分自身を指す (IN TO ROOMS) は、親を持たない最上位のオブジェクト
                # を表す。(LOC TO X) は (LOC X) と同じ。(IN TO X) は方向 IN の出口
                if repr(getattr(parts[2], "text", None)) == zil_name:
                    continue
                if head.text.upper() == "LOC":
                    parts = [head, parts[2]]
            key = repr(head.text) if isinstance(head, ZSymbol) else self._expr(head)
            if (
                isinstance(head, ZSymbol)
                and head.text.upper() == "IN"
                and len(parts) == 2
                and isinstance(parts[1], ZSymbol)
            ):
                key = repr("LOC")  # (IN X) は親。方向 IN の出口と区別する
            if isinstance(head, ZSymbol) and head.text.upper() in ATOM_PROPERTIES:
                values = [self._datum(part) for part in parts[1:]]
            elif (
                len(parts) >= 3
                and isinstance(parts[1], ZSymbol)
                and parts[1].text.upper() in ("TO", "PER")
            ):
                values = self._exit_values(parts[1:])
            else:
                values = [self._prop_value(part) for part in parts[1:]]
            if not values:
                value = "True"  # (ONBIT) のように値がない場合はフラグ
            elif len(values) == 1:
                value = values[0]
            else:
                value = self._tuple(values)
            properties.append(f"{key}: {value}")

        if not properties:
            return "{}"
        body = f",\n{INDENT_UNIT}".join(properties)
        return f"{{\n{INDENT_UNIT}{body},\n}}"

    def transcode_defmac(self, node: ZList) -> list[str]:
        """<DEFMAC NAME ...> はコンパイル時マクロのため注釈のみ出力する。

        Args:
            node: DEFMAC フォーム。

        Returns:
            コメント行のリスト。
        """
        items = [item for item in node.items if not is_ignorable(item)]
        name = items[1].text if len(items) > 1 and isinstance(items[1], ZSymbol) else "?"
        lines = self._defmac_lines(name)
        if lines is not None:
            return lines + self._macro_function_lines(name)
        return [f"# DEFMAC {name}: compile-time macro (not transcoded)"]

    # ------------------------------------------------------------------
    # 文の生成
    # ------------------------------------------------------------------

    def _nested_declaration(self, node: ZList, name: str) -> list[str]:
        """条件分岐の中にある定義フォーム (ROUTINE・GLOBAL など) を変換する。

        `%<COND (<==? ,ZORK-NUMBER 2> <ROUTINE ...>) ...>` のように、
        コンパイル時の条件で定義を切り替える場合に使う。条件を保つため、
        GLOBAL / CONSTANT も ZilGlobal.py へ移さず、その場に宣言を出力する。

        Args:
            node: 定義フォーム。
            name: フォーム名 (大文字)。

        Returns:
            生成された行のリスト。
        """
        handler = self._toplevel_handlers[name]
        saved, self.global_file = self.global_file, None
        try:
            return handler(node)
        finally:
            self.global_file = saved

    def _finish(self, expr: str, mode: Mode) -> list[str]:
        """式の値を mode に従って扱う文を生成する。

        Args:
            expr: Python の式。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        if mode.kind == "return":
            return [f"return {expr}"]
        if mode.kind == "assign":
            return [] if expr == mode.target else [f"{mode.target} = {expr}"]
        return [expr] if expr else []

    def _cond_chain(self, clauses: list[ZList], mode: Mode) -> list[str]:
        """COND の節の並びを if/elif/else の連鎖に変換する。

        Args:
            clauses: COND の節のリスト。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        lines: list[str] = []
        for index, clause in enumerate(clauses):
            parts = [item for item in clause.items if not is_ignorable(item)]
            if not parts:
                continue
            test, body = parts[0], parts[1:]
            if isinstance(test, ZSymbol) and test.text.upper() in TRUE_TESTS:
                block = self._block(body, mode) if body else self._finish("True", mode)
                if not lines:
                    return block  # 最初の節が T なら無条件に実行する
                return lines + ["else:", self._indent(block)]

            # 条件の中で展開したマクロの注記は、その節の if / elif の直前に付ける
            if body or mode.kind == "discard":
                (pre, cond), notes = self._notes_of(lambda: self._capture(lambda: self._test_expr(test)))
            else:
                # 本体のない節は条件の値が COND の値になるので、値をそのまま使う
                (pre, cond), notes = self._notes_of(lambda: self._capture(lambda: self._expr(test)))
            if lines and pre:
                # elif の条件の前に文が必要なので、else の中へ入れ子にする
                nested = self._cond_chain(clauses[index:], mode)
                return lines + ["else:", self._indent(nested)]

            keyword = "elif" if lines else "if"
            if not body and mode.kind != "discard":
                # 本体のない節は条件の値そのものが COND の値になる
                # 属性 (ZG.X) には := で代入できないので、そのときは一時変数を介す
                # (例: Spellbreaker の `<SETG PSEUDO-PRSO <COND (<EQUAL? ...>)>>`)
                if mode.kind == "assign" and mode.target is not None and "." not in mode.target:
                    holder = mode.target
                else:
                    holder = self._new_temp()
                cond = f"({holder} := {cond})"
                block = self._finish(holder, mode)
            else:
                block = self._block(body, mode)
            lines += self._note_comments(notes) + pre + [f"{keyword} {cond}:", self._indent(block)]

        if not lines:
            return self._finish("False", mode) if mode.kind != "discard" else []
        if mode.kind != "discard":
            lines += ["else:", self._indent(self._finish("False", mode))]
        return lines

    def _stmt_loop(self, node: ZList, mode: Mode) -> list[str]:
        """<REPEAT|PROG|BIND (BINDINGS) BODY...> を while ループに変換する。

        REPEAT は RETURN されるまで繰り返し、PROG / BIND は 1 回だけ実行する。

        Args:
            node: REPEAT、PROG または BIND フォーム。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if args and isinstance(args[0], ZSymbol):
            args = args[1:]  # 活性化名 (activation) は無視する
        lines: list[str] = []
        if args and isinstance(args[0], ZList) and args[0].kind == "paren":
            lines += self._bindings(args[0].items)
            args = args[1:]

        self._loops.append((mode, None))
        try:
            if form_name(node) == "REPEAT":
                body = self._block(args, DISCARD_MODE)
            else:
                body = self._block(args, mode) + ["break"]
        finally:
            self._loops.pop()
        return lines + ["while True:", self._indent(body)]

    def _bindings(self, items: Iterable[ZNode]) -> list[str]:
        """ループの束縛リストを初期化文に変換する。

        Args:
            items: 束縛リストの要素。

        Returns:
            生成された行のリスト。
        """
        lines: list[str] = []
        for item in items:
            if is_ignorable(item) or isinstance(item, ZString):
                continue
            if isinstance(item, ZList) and item.items:
                name = self._param_name(item.items[0])
                if len(item.items) > 1:
                    lines += self._stmt(item.items[1], Mode("assign", name))
                    continue
            else:
                name = self._param_name(item)
            lines.append(f"{name} = 0")
        return lines

    def _stmt_set(self, node: ZList, mode: Mode) -> list[str]:
        """<SET X VALUE> / <SETG X VALUE> を代入文に変換する。

        Args:
            node: SET または SETG フォーム。
            mode: 代入した値の扱い方。

        Returns:
            生成された行のリスト。
        """
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        target = self._set_target(node, args)
        if target is None:
            return self._fallback(node, mode)
        if len(args) > 1:
            lines = self._stmt(args[1], Mode("assign", target))
        else:
            lines = [f"{target} = False"]
        if mode.kind != "discard":
            lines += self._finish(target, mode)
        return lines

    def _set_target(self, node: ZList, args: list[ZNode]) -> str | None:
        """SET / SETG の代入先の変数名を求める。

        SETG の代入先は共有のグローバル名前空間 (ZG.NAME) になる。

        Args:
            node: SET または SETG フォーム。
            args: フォームの引数 (コメント除去済み)。

        Returns:
            代入先の Python の式。求められない場合は None。
        """
        if not (args and isinstance(args[0], ZSymbol)):
            return None
        if form_name(node) == "SETG":
            return f"{GLOBALS_NAME}.{to_identifier(args[0].text)}"
        return local_name(args[0].text)

    def _logic_chain(
        self, operands: list[ZNode], is_and: bool, mode: Mode
    ) -> list[str]:
        """AND / OR の短絡評価を if の入れ子で表現する。

        Args:
            operands: 演算対象のノード。
            is_and: AND なら True、OR なら False。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        if len(operands) == 1:
            return self._stmt(operands[0], mode)
        # 最後以外の演算対象は真偽として評価される
        pre, cond = self._capture(lambda: self._test_expr(operands[0]))
        rest = self._indent(self._logic_chain(operands[1:], is_and, mode))
        if mode.kind == "discard":
            test = cond if is_and else f"not {cond}"
            return pre + [f"if {test}:", rest]

        holder = mode.target if mode.kind == "assign" else self._new_temp()
        test = holder if is_and else f"not {holder}"
        lines = pre + [f"{holder} = {cond}", f"if {test}:", rest]
        if mode.kind == "return":
            lines += ["else:", self._indent([f"return {holder}"])]
        return lines

    # ------------------------------------------------------------------
    # 式の生成
    # ------------------------------------------------------------------

    def _new_temp(self) -> str:
        """新しい一時変数名を返す。

        Returns:
            一時変数名。
        """
        self._temp_count += 1
        return f"{TEMP_PREFIX}{self._temp_count}"

    def _indent(self, lines: list[str]) -> str:
        """ブロック本体を 1 段インデントする (空なら pass を返す)。

        Args:
            lines: 列 0 基準で生成されたブロック本体の行。

        Returns:
            インデントされたブロック本体。
        """
        return textwrap.indent("\n".join(lines) or "pass", INDENT_UNIT)

    def _tuple(self, values: list[str]) -> str:
        """式のリストを Python のタプル表記にする。

        Args:
            values: 要素の式。

        Returns:
            タプル表記の Python コード。
        """
        if len(values) == 1:
            return f"({values[0]},)"
        return f"({', '.join(values)})"

    def _expr(self, node: ZNode) -> str:
        """ノードを Python の式に変換する。

        文が必要な場合は self._pre へ文を巻き上げ、一時変数を式として返す。

        Args:
            node: 変換対象のノード。

        Returns:
            Python の式。
        """
        node = self._expand_macro(node)
        if isinstance(node, ZString):
            return repr(node.text)
        if isinstance(node, ZSymbol):
            return self._symbol(node.text)
        if isinstance(node, ZExp):
            if node.kind == "EVAL":
                known, value = self._compile_time(node)
                if known:
                    return "False" if value is None else self._expr(value)
            if node.item is None or is_ignorable(node):
                return "None"
            if node.kind == "QUOTE" and isinstance(node.item, ZSymbol):
                return repr(node.item.text)
            return self._expr(node.item)
        if node.kind == "paren":
            return self._tuple(self._exprs(node.items))
        return self._form_expr(node)

    def _symbol(self, text: str) -> str:
        """シンボルを Python の式に変換する。

        Args:
            text: シンボルの文字列。

        Returns:
            Python の式。
        """
        if text == "T":
            return "True"
        if len(text) == 2 and text.startswith("\\"):
            return repr(text[1])  # !\X は文字リテラル
        octal = OCTAL_RE.fullmatch(text)
        if octal:
            return str(int(octal.group(1), 8))  # *3777* は 8 進数
        ident = to_identifier(text)
        if text.startswith("."):
            return local_name(text)  # `.X` はルーチン内のローカル変数
        constant = self._symbolic_constant(text.removeprefix(","))
        if constant is not None:
            return constant
        # 全モジュールで共有される名前 (GLOBAL・ROUTINE・OBJECT など) は
        # ZG の属性として参照する
        if ident in self.global_names:
            return f"{GLOBALS_NAME}.{ident}"
        return ident

    def _symbolic_constant(self, name: str) -> str | None:
        """コンパイラが定義する記号定数を Python の式に変換する。

        プロパティ名 (P?ACTION)、単語 (W?NORTH)、フラグ (OPENBIT) は文字列にする。
        品詞 (PS?VERB、P1?VERB) はランタイムの定数 (PS_VERB など)、
        構文の宣言で番号が決まる定数 (V?TAKE、ACT?WALK、PR?THROUGH、A?RED) は
        ランタイムの SYMBOL 関数の呼び出しにする。

        Args:
            name: 接頭辞 (`,` や `.`) を除いたシンボル名。

        Returns:
            Python の式。記号定数でなければ None。
        """
        if name.startswith(PROPERTY_PREFIX):
            return repr(name[len(PROPERTY_PREFIX) :])
        if name.startswith(WORD_PREFIX):
            return f"{WORD_FUNCTION}({name[len(WORD_PREFIX) :].lower()!r})"
        if name.startswith(PART_PREFIXES):
            return to_identifier(name)  # PS_VERB など。値はランタイムが定義する
        if name.startswith(SYMBOLIC_PREFIXES):
            return f"{SYMBOL_FUNCTION}({name!r})"
        if name in self.flag_names:
            return f"Flag({name!r})"
        return None

    def _form_expr(self, node: ZList) -> str:
        """山括弧リスト (フォーム) を Python の式に変換する。

        Args:
            node: kind が 'angle' のリストノード。

        Returns:
            Python の式。
        """
        if not node.items:
            return "False"  # <> は ZIL の偽
        name = form_name(node)
        if name is None:
            return self._tuple(self._exprs(node.items))
        if needs_statement(node):
            temp = self._new_temp()
            self._pre.extend(self._stmt(node, Mode("assign", temp)))
            return temp

        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if name in ("SET", "SETG"):
            return self._set_expr(node, args)
        head = to_identifier(name)
        # 宣言のフォーム (VERB? など)。作品の定義で組み込みを上書きした関数なら、ふつうの呼び出し
        if name in DECLARATION_FORMS and self._names.call(head) != GAME:
            return f"{head}({', '.join(self._datum(arg) for arg in args)})"
        if name in TABLE_FORMS:
            return f"{head}({', '.join(self._table_args(name, args))})"
        if name in INC_TESTS and len(args) == 2:
            # <IGRTR? X N> は X を 1 増やしてから N より大きいかを調べる
            step, op = INC_TESTS[name]
            var = self._param_name(args[0])
            limit = self._expr(args[1])
            first = args[0]
            if isinstance(first, ZSymbol) and first.text.startswith(","):
                ref = f"{GLOBALS_NAME}.{var}"
                new = f"{GLOBALS_NAME}._set({var!r}, {ref} {step} 1)"
                return f"({new} {op} {limit})"
            return f"(({var} := {var} {step} 1) {op} {limit})"

        if name == "ASSIGNED?" and len(args) == 1 and isinstance(args[0], ZSymbol):
            # 省略可能な引数は、渡されなければ None になる
            return f"({self._param_name(args[0])} is not None)"

        if name in ("AND", "OR"):
            if not args:
                return "True" if name == "AND" else "False"
            # 最後以外の演算対象は真偽として評価され、最後の値が全体の値になる
            values = [self._test_expr(arg) for arg in args[:-1]]
            values.append(self._expr(args[-1]))
            return f"({f' {name.lower()} '.join(values)})"
        values = self._exprs(args)
        if name == "NOT" and len(values) == 1:
            return f"(not {values[0]})"
        if name in COMPARE_OPS and len(values) >= 2:
            op = COMPARE_OPS[name]
            if len(values) > 2 and op in ("==", "!="):
                # <EQUAL? A B C> は A が B または C に等しいかを調べる
                in_op = "in" if op == "==" else "not in"
                return f"({values[0]} {in_op} {self._tuple(values[1:])})"
            return f"({f' {op} '.join(values)})"
        if name in ZERO_TESTS and len(values) == 1:
            return f"({values[0]} == {ZERO_TESTS[name]})"
        if name in ARITH_OPS:
            op = ARITH_OPS[name]
            if not values:
                return "0"
            if len(values) == 1:
                return f"(-{values[0]})" if op == "-" else values[0]
            return f"({f' {op} '.join(values)})"
        if INTEGER_RE.fullmatch(name) and len(values) in (1, 2):
            # ZIL のコンパイラは <N X> を <GET X N>、<N X V> を <PUT X N V> とする
            # (例: Deadline の <1 ,P-PRSO> は P-PRSO の 1 番目のワード = 1 つ目の
            # オブジェクト。0 番目のワードは件数)
            if len(values) == 1:
                return f"GET({values[0]}, {int(name)})"
            return f"PUT({values[0]}, {int(name)}, {values[1]})"
        return self._call_expr(node)

    def _test_expr(self, node: ZNode) -> str:
        """条件 (真偽) として評価される位置のノードを Python の式に変換する。

        Infocom の ZIL コンパイラは、定数を代入するだけの <SET X 0> / <SET X <>> を
        値を持たない Z-machine の SET 命令にするため、条件の位置では常に真になる。
        (例: Deadline の PARSER の `<AND <OR ...> <SET VAL 0>>`。)
        Python の代入式 `(X := 0)` は偽になるので、`((X := 0) or True)` に変換する。
        AND / OR / NOT の演算対象も条件として評価されるので、同じ規則を再帰的に適用する。

        Args:
            node: 変換対象のノード。

        Returns:
            Python の式。
        """
        node = self._expand_macro(node)
        name = form_name(node)
        if not isinstance(node, ZList) or needs_statement(node):
            return self._expr(node)
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if name in ("SET", "SETG") and len(args) == 2 and is_false_constant(args[1]):
            return f"({self._expr(node)} or True)"
        if name in ("AND", "OR") and args:
            values = [self._test_expr(arg) for arg in args]
            return f"({f' {name.lower()} '.join(values)})"
        if name == "NOT" and len(args) == 1:
            return f"(not {self._test_expr(args[0])})"
        return self._expr(node)

    def _set_expr(self, node: ZList, args: list[ZNode]) -> str:
        """式の位置にある SET / SETG を代入式 (:=) に変換する。

        Args:
            node: SET または SETG フォーム。
            args: フォームの引数 (コメント除去済み)。

        Returns:
            Python の式。
        """
        target = self._set_target(node, args)
        if target is None:
            return self._call_expr(node)
        is_global = target.startswith(f"{GLOBALS_NAME}.")
        value = args[1] if len(args) > 1 else None
        if value is not None and needs_statement(value):
            self._pre.extend(self._stmt(value, Mode("assign", target)))
            return target
        text = "False" if value is None else self._expr(value)
        if is_global:
            # 属性には := で代入できないため、ZG._set を使う
            name = target.split(".", 1)[1]
            return f"{GLOBALS_NAME}._set({name!r}, {text})"
        return f"({target} := {text})"

    def _call_expr(self, node: ZList) -> str:
        """フォームを関数呼び出しの式に変換する (<PRINTI "Hi"> -> PRINTI('Hi'))。

        組み込み命令はランタイム (ZilRuntime) の同名の関数を呼び出す。

        Args:
            node: 先頭がシンボルの山括弧リスト。

        Returns:
            関数呼び出しの Python の式。
        """
        head = node.items[0]
        name = head.text if isinstance(head, ZSymbol) else ""
        # ROUTINE 定義側と同じ規則で名前を変換し、呼び出しと定義を一致させる
        func = to_identifier(name)
        # ゲームの定義なら ZG から、ランタイムの命令ならランタイムの関数を呼ぶ
        # (compiletime/names.py。物体と同名のフォームは組み込み命令。例: Trinity の <SOUND 1>)
        if self._names.call(func) == GAME:
            func = f"{GLOBALS_NAME}.{func}"
        if name.upper() == "TELL":
            args = []
            for item in node.items[1:]:
                if is_ignorable(item):
                    continue
                if isinstance(item, ZExp) and item.kind == "QUOTE" and isinstance(item.item, ZSymbol):
                    # 後期の TELL では 'PRSO は「物の短い名前をそのまま表示する」(PRINTD 命令)
                    # の略記。ゲームの TELL-TOKENS の D (Spellbreaker では、THE の付いた物に
                    # "the " を付ける DPRINT) は通さない。原文の <TELL "room, a " 'SHADOW> や
                    # <TELL " learn the " 'PRSO> が "a the ..." にならないのはこのため
                    args += ["D", self._expr(ZSymbol("," + item.item.text, item.span))]
                else:
                    args.append(self._tell_arg(item))
        else:
            args = self._exprs(node.items[1:])
        return f"{func}({', '.join(args)})"

    def _tell_arg(self, node: ZNode) -> str:
        """TELL の引数を Python の式に変換する。

        Deadline の TELL マクロは、コンマの付かない `PRSO` / `PRSI` を
        `<PRSO-PRINT>` / `<PRSI-PRINT>` に展開する (プレイヤーが入力した名詞句を
        表示する)。ゲームに PRSO-PRINT / PRSI-PRINT ルーチンがあれば、その
        ルーチン自体を渡し、ランタイムの TELL が順番どおりの位置で呼び出す。

        Args:
            node: TELL の引数のノード。

        Returns:
            Python の式。
        """
        if isinstance(node, ZSymbol) and not node.text.startswith((",", ".")):
            mapped = self._tell_indicator(node.text.upper())
            if mapped is not None:
                return mapped
        if isinstance(node, ZSymbol) and node.text.upper() in ("PRSO", "PRSI"):
            printer = f"{node.text.upper()}_PRINT"
            if printer in self.global_names:
                return f"{GLOBALS_NAME}.{printer}"
        return self._expr(node)

    def _tell_indicator(self, name: str) -> str | None:
        """ゲームの TELL マクロが定める書式指定子を、ランタイムの TELL 向けの式にする。

        - 組み込みの命令 (PRINTD など) なら、ランタイムの指定子 (D など) にする
        - ゲームのルーチンで、直後の引数を取るもの (Suspended の D = NDESC) は
          `TellToken('D', ZG.NDESC)` にする
        - 引数を取らないもの (Suspended の V = VPRINT、Deadline の PRSO = PRSO-PRINT) は
          ルーチンそのものを渡し、ランタイムの TELL がその位置で呼ぶ

        Args:
            name: 指定子の名前 (大文字)。

        Returns:
            Python の式。TELL マクロに定めのない名前なら None。
        """
        entry = self.tell_indicators.get(name)
        if entry is None:
            return None
        routine, takes_arg = entry
        ident = to_identifier(routine)
        # ゲームが同名のルーチンを定義していれば、そちらを優先する
        # (例: Spellbreaker の PRINTA は、名前を書いたキューブを `"foo" cube` と表示する)
        if routine in BUILTIN_TELL_PRINTERS and ident not in self.global_names:
            if name in RUNTIME_TELL_TOKENS:
                return None  # ランタイムの指定子 (D など) と同じなので、そのまま変換する
            return BUILTIN_TELL_PRINTERS[routine]
        if ident not in self.global_names:
            return None
        if takes_arg:
            return f"TellToken({name!r}, {GLOBALS_NAME}.{ident})"
        return f"{GLOBALS_NAME}.{ident}"
