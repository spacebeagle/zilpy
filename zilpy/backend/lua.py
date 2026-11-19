"""ZIL の AST を Lua 5.1 互換ソースコードへ変換する。"""

from __future__ import annotations

from collections.abc import Callable, Iterable
import re

from zilpy.constants import (
    ATOM_PROPERTIES,
    BUILTIN_TELL_PRINTERS,
    COMPILER_ATOMS,
    DECLARATION_FORMS,
    ESCAPE_RE,
    GLOBALS_NAME,
    INC_TESTS,
    INDENT_UNIT,
    INTEGER_RE,
    OCTAL_RE,
    PART_PREFIXES,
    PROPERTY_PREFIX,
    RUNTIME_TELL_TOKENS,
    SYMBOL_FUNCTION,
    SYMBOLIC_PREFIXES,
    TABLE_FORMS,
    TEMP_PREFIX,
    WORD_FUNCTION,
    WORD_PREFIX,
)
from zilpy.backend.lua_global_file import ZilLuaGlobalFile
from zilpy.backend.mode import DISCARD_MODE, Mode, RETURN_MODE
from zilpy.front.nodes import (
    ZExp,
    ZList,
    ZNode,
    ZString,
    ZSymbol,
    contains_bare_again,
    form_name,
    is_comment,
    is_false_constant,
    is_ignorable,
    needs_statement,
    to_identifier,
)
from zilpy.front.nodes import local_name as _local_name
from zilpy.backend.base import TranscoderBase
from zilpy.compiletime.macro_registry import MacroRegistry
from zilpy.backend.runtime_names_lua import RUNTIME_NAMES
from zilpy.compiletime.lowering import parse_params, referenced_locals
from zilpy.compiletime.names import GAME, RUNTIME


# 一時変数の目印 (_new_temp)。関数を作り終えてから、ローカル変数か _L の要素に置き換える。
# ZIL の文字列には現れない文字で囲む
_TEMP_MARK = "\x00"
_TEMP_RE = re.compile("\x00(\\d+)\x00")
# 関数の中の `local a, b` と `for a, b` (ローカル変数の数を数える)
_LOCAL_DECL_RE = re.compile(r"^\s*(?:local|for)\s+(?!function\b)([A-Za-z_][\w]*(?:\s*,\s*[A-Za-z_][\w]*)*)", re.M)
# 関数のローカル変数のうち、一時変数に名前を付けてよい数。Lua の上限は 200 個 (LUAI_MAXVARS) だが、
# 式の計算に使うレジスター (上限 250 前後) の余裕を残すため、少なめにする
LUA_LOCAL_BUDGET = 150


def local_name(name: str) -> str:
    """ZIL のローカル変数名を、Lua のローカル変数名へ変換する (zilpy.front.nodes.local_name)。

    ランタイムの名前の一覧は Lua 版のもの (zilpy/backend/runtime_names_lua.py) を使う。
    """
    return _local_name(name, RUNTIME_NAMES)

LUA_KEYWORDS: frozenset[str] = frozenset(
    {
        "and",
        "break",
        "do",
        "else",
        "elseif",
        "end",
        "false",
        "for",
        "function",
        "if",
        "in",
        "local",
        "nil",
        "not",
        "or",
        "repeat",
        "return",
        "then",
        "true",
        "until",
        "while",
    }
)

LUA_COMPARE_OPS: dict[str, str] = {
    "==?": "==",
    "EQUAL?": "==",
    "N==?": "~=",
    # 構造の等しさ (文字列の比較など。例: Moonmist の D-APPLY の <=? .STR "Container">)。
    # zilpy.constants.COMPARE_OPS と同じ
    "=?": "==",
    "N=?": "~=",
    "G?": ">",
    "GRTR?": ">",
    "L?": "<",
    "LESS?": "<",
    "G=?": ">=",
    "L=?": "<=",
}

LUA_INFIX_ARITH: dict[str, str] = {
    "+": "+",
    "ADD": "+",
    "-": "-",
    "SUB": "-",
    "*": "*",
    "MUL": "*",
}

LUA_FN_ARITH: dict[str, str] = {
    "/": "DIV",
    "DIV": "DIV",
    "MOD": "MOD",
    "BAND": "BAND",
    "ANDB": "BAND",
    "BOR": "BOR",
    "ORB": "BOR",
}

LUA_ZERO_TESTS: dict[str, str] = {"0?": "0", "ZERO?": "0", "1?": "1"}
# RFATAL は M-FATAL (2) を返す (zilpy.constants.RETURN_CONSTANTS と同じ)。呼び出し側は
# <EQUAL? .X ,M-FATAL> のように 2 と比べるので、true にしてはいけない
# (例: Lurking Horror の HACKER-DESC は、<RFATAL> で「中身を説明しない」と伝える)
LUA_RETURN_CONSTANTS: dict[str, str] = {"RTRUE": "true", "RFALSE": "false", "RFATAL": "2"}


def _lua_str(text: str) -> str:
    """Python 文字列を Lua 5.1 の文字列リテラルへ変換する。"""
    out: list[str] = ['"']
    for ch in text:
        if ch == "\\":
            out.append("\\\\")
        elif ch == '"':
            out.append('\\"')
        elif ch == "\n":
            out.append("\\n")
        elif ch == "\r":
            out.append("\\r")
        elif ch == "\t":
            out.append("\\t")
        elif ord(ch) < 32 or ord(ch) == 127:
            out.append(f"\\{ord(ch):03d}")
        else:
            out.append(ch)
    out.append('"')
    return "".join(out)


def _lua_ident(name: str) -> str:
    """Lua の予約語と衝突しない識別子にする。"""
    return f"{name}_" if name in LUA_KEYWORDS else name


class ZilToLuaTranscoder(TranscoderBase):
    """ZIL の AST を Lua 5.1 互換ソースコードへ変換するクラス。

    文の振り分けや一時変数の巻き上げなど、言語に依存しない部分は TranscoderBase。
    このクラスは Lua の文字列を生成する部分だけを持つ。

    演算子は、ランタイムの関数 (`ZG.ADD`・`ZG.EQ`・`ZG.LT` など) を呼ぶ形で出力する
    (refactor-plan.md §4 の 7)。Lua 5.1 には整数とビット演算がなく、ZIL の 16 ビットの
    符号付き整数の演算を、ランタイムが揃えるため。
    """

    TRUE = "true"
    FALSE = "false"
    RETURN_CONSTANTS = LUA_RETURN_CONSTANTS
    COMMENT = "--"
    # AGAIN は、囲んでいる `repeat ... until true` を抜けて、外側の while の次の回へ進む
    AGAIN_LINES = ["break"]
    PSEUDO_TRIPLES_CALL = f"{GLOBALS_NAME}._use_pseudo_triples()"
    DROP_EMPTY_LISTS = True

    def __init__(
        self,
        ast: list[ZNode],
        insert_file: Callable[[str], str | None] | None = None,
        global_names: frozenset[str] | set[str] = frozenset(),
        global_file: ZilLuaGlobalFile | None = None,
        source_name: str = "",
        flag_names: frozenset[str] | set[str] = frozenset(),
        object_names: frozenset[str] | set[str] = frozenset(),
        static_values: dict[str, int] | None = None,
        macros: MacroRegistry | None = None,
        tell_indicators: dict[str, tuple[str, bool]] | None = None,
    ) -> None:
        """ZilToLuaTranscoder を初期化する (引数は TranscoderBase と同じ)。"""
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
        self.global_file: ZilLuaGlobalFile | None = global_file
        self._seen_globals: set[str] = set()
        self._brk_depth = 0

    # ------------------------------------------------------------------
    # TranscoderBase のフック
    # ------------------------------------------------------------------

    def _str(self, text: str) -> str:
        """Lua の文字列リテラル。"""
        return _lua_str(text)

    def _loop_exit(self, brk: str | None) -> list[str]:
        """囲んでいるループを抜ける文。AGAIN のあるループは、脱出を変数で知らせる。"""
        return [f"{brk} = true", "break"] if brk is not None else ["break"]

    def _runtime_fn(self, name: str) -> str:
        """ランタイムの関数は ZG テーブルから呼ぶ。"""
        return f"{GLOBALS_NAME}.{name}"

    def _plain_ident(self, text: str) -> str:
        """接頭辞のないアトムを、そのまま識別子にしたときの表記。"""
        return _lua_ident(to_identifier(text))

    def transcode(self) -> str:
        """AST 全体を Lua 5.1 ソースコードに変換する。"""
        header = (
            f"-- ZIL から自動生成した Lua 5.1 コード\n\n"
            f'local {GLOBALS_NAME} = require("{ZilLuaGlobalFile.module_name()}")'
        )
        chunks: list[str] = []
        for node in self.ast:
            if is_ignorable(node) and not is_comment(node):
                continue
            lines = self._with_notes(lambda: self._toplevel(node))
            # 注記の行は、次の行と同じ塊にする (トップレベルの塊は空行で区切られる)
            while len(lines) > 1 and lines[0].startswith("-- macro: "):
                lines = [lines[0] + "\n" + lines[1], *lines[2:]]
            chunks.extend(lines)
        # トップレベルの文の一時変数は、モジュールの配列 _L の要素にする
        # (モジュールのローカル変数も 200 個までなので、名前の付いた変数にはしない)
        body = _TEMP_RE.sub(lambda m: f"_L[{m.group(1)}]", "\n\n".join(chunks))
        if "_L[" in body:
            header += "\nlocal _L = {}"
        return "\n\n".join([header, body]) if body else header

    def _toplevel_lines(self, node: ZNode) -> list[str]:
        """トップレベルの 1 ノードを Lua の文の並びに変換する (位置の注記は TranscoderBase._toplevel)。"""
        if isinstance(node, ZString):
            return []
        name = form_name(node)
        if name == "INSERT-FILE":
            return self.transcode_insert_file(node)  # type: ignore[arg-type]
        if name in ("ROUTINE", "DEFINE"):
            return self.transcode_routine(node)  # type: ignore[arg-type]
        if name in ("GLOBAL", "GDECL"):
            return self.transcode_global(node)  # type: ignore[arg-type]
        if name == "CONSTANT":
            return self.transcode_constant(node)  # type: ignore[arg-type]
        if name == "SETG":
            return self.transcode_setg(node)  # type: ignore[arg-type]
        if name in ("OBJECT", "ROOM"):
            return self.transcode_object(node)  # type: ignore[arg-type]
        if name == "DEFMAC":
            return self.transcode_defmac(node)  # type: ignore[arg-type]
        if name == "COND":
            return self.transcode_toplevel_cond(node)  # type: ignore[arg-type]
        if name == "ENDLOAD":
            return []
        directive = self._directive_lines(node)
        if directive is not None:
            return directive
        if name == "PROPDEF":
            return self._transcode_propdef(node)  # type: ignore[arg-type]
        if name in DECLARATION_FORMS:
            return self._stmt(node, DISCARD_MODE)
        return self._stmt(node, DISCARD_MODE)

    def _noop_directive_lines(self, name: str) -> list[str]:
        """生成コードでは何もしない指示 (NOOP_DIRECTIVES) は、Lua では何も出力しない。"""
        return []

    def transcode_insert_file(self, node: ZList) -> list[str]:
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if not args or not isinstance(args[0], ZString):
            return self._fallback(node, DISCARD_MODE)
        if self.insert_file is None:
            return [f"{GLOBALS_NAME}.INSERT_FILE({_lua_str(args[0].text)})"]
        module = self.insert_file(args[0].text)
        if module is None:
            return [f"-- INSERT-FILE {_lua_str(args[0].text)} failed"]
        return [f'require("{module}")']

    def _transcode_propdef(self, node: ZList) -> list[str]:
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if len(args) >= 2 and isinstance(args[0], ZSymbol):
            prop_name = _lua_str(args[0].text)
            default_expr = self._prop_value(args[1])
            return [f"{GLOBALS_NAME}.PROPDEF({prop_name}, {default_expr})"]
        return [f"-- PROPDEF skipped"]

    def transcode_routine(self, node: ZList) -> list[str]:
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 3 or not isinstance(items[1], ZSymbol):
            return self._fallback(node, DISCARD_MODE)
        skipped = self._compile_time_define(node, items)
        if skipped is not None:
            return skipped
        rest = items[2:]
        if isinstance(rest[0], ZSymbol) and len(rest) > 1:
            rest = rest[1:]
        args_node, body = rest[0], rest[1:]
        body, silenced = self._silenced_body(items[1].text, body)
        block_body = body if silenced else self._body_with_comments(node, args_node, body)

        saved = (self._in_function, self._loops, self._temp_count, self._brk_depth)
        self._in_function, self._loops = True, []
        self._temp_count = 0
        self._brk_depth = 0
        try:
            params, prologue, bound = self._routine_params(args_node)
            self._record_definition(node)  # トップレベルの PROG などの中のルーチンも載せる
            self._record_locals(items[1].text, args_node, body)
            if any(contains_bare_again(item) for item in body):
                brk_var = self._new_brk()
                self._loops.append((RETURN_MODE, brk_var))
                loop_body = self._block(block_body, RETURN_MODE)
                body_lines = [
                    "while true do",
                    self._indent([f"local {brk_var} = true", "repeat", self._indent(loop_body), "until true", f"if {brk_var} then break end"]),
                    "end",
                ]
            else:
                body_lines = self._block(block_body, RETURN_MODE)
        finally:
            self._in_function, self._loops, self._temp_count, self._brk_depth = saved

        undeclared = self._undeclared_locals(body, bound, body_lines)
        temps, code = self._bind_temps(prologue + undeclared + body_lines, params)
        full_prologue: list[str] = temps + code
        name = to_identifier(items[1].text)
        return silenced + [
            f"{GLOBALS_NAME}.actions:register({_lua_str(name)}, function({', '.join(params)})",
            self._indent(full_prologue),
            f"end, {_lua_str(items[1].text)})",
            f"{GLOBALS_NAME}.{name} = {GLOBALS_NAME}.actions:get({_lua_str(name)})",
        ]

    def _new_brk(self) -> str:
        self._brk_depth += 1
        return f"_brk{self._brk_depth}"

    def _undeclared_locals(
        self, body: list[ZNode], bound: set[str], body_lines: list[str]
    ) -> list[str]:
        """宣言も代入もないのに参照されるローカル変数を 0 で宣言する (値は ZIL と同じく 0)。"""
        referenced = {
            _lua_ident(to_identifier(local_name(text))) for text in referenced_locals(body)
        }
        assigned: set[str] = set()
        for line in body_lines:
            for m in re.finditer(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*=", line):
                assigned.add(m.group(1))
        missing = sorted(referenced - bound - assigned)
        if not missing:
            return []
        return [f"local {', '.join(missing)} = {', '.join(['0'] * len(missing))}"]

    def _routine_params(self, node: ZNode) -> tuple[list[str], list[str], set[str]]:
        """ROUTINE の引数リストを Lua の仮引数と初期化文に変換する (解釈は lowering.parse_params)。"""
        params: list[str] = []
        prologue: list[str] = []
        bound: set[str] = set()
        for param in parse_params(node):
            pname = self._param_name(param.name)
            bound.add(pname)
            if param.section == "aux":
                default_expr = "0" if param.default is None else self._expr(param.default)
                prologue.append(f"local {pname} = {default_expr}")
            elif param.section == "opt":
                params.append(pname)
                if param.listed:
                    default_expr = "0" if param.default is None else self._expr(param.default)
                    prologue.append(f"if {pname} == nil then {pname} = {default_expr} end")
            elif param.section == "rest":
                params.append("...")
                prologue.append(f"local {pname} = {{...}}")
            else:
                params.append(pname)
        return params, prologue, bound

    def _param_name(self, node: ZNode, local: bool = True) -> str:
        """仮引数・束縛・宣言のノードから名前を取り出す (ZilToPythonTranscoder と同じ規則)。

        ローカル変数だけ、ランタイムの関数と同じ名前なら末尾に `_l` を付ける (local_name)。
        GLOBAL・OBJECT などの宣言の名前 (local=False) には付けない。付けると、参照
        (`ZG.SOUND`) と宣言 (`SOUND_l`) の名前がずれる (例: Trinity の物体 SOUND)。
        """
        while isinstance(node, ZExp) and node.item is not None:
            node = node.item
        if isinstance(node, ZSymbol):
            if local:
                return _lua_ident(to_identifier(local_name(node.text) or node.text))
            return to_identifier(node.text)
        return "_arg"

    def _lazy_declaration(
        self,
        name: str,
        build_expr: Callable[[], str],
        value_key: str,
        category: str = "state",
        is_object: bool = False,
        location: list[str] | None = None,
    ) -> tuple[list[str], str]:
        expr = _TEMP_RE.sub(lambda m: f"_L[{m.group(1)}]", build_expr())
        is_redef = name in self._seen_globals
        self._seen_globals.add(name)
        # OBJECT / ROOM は 3 番目の引数で示す。ランタイムの _link が、Python 版と同じく
        # オブジェクトを先に宣言順で初期化するため
        object_arg = ", true" if is_object else ""
        decl = f"{GLOBALS_NAME}._declare({_lua_str(name)}, function() return {expr} end{object_arg})"
        # OBJECT / ROOM は、Python 版と同じく元のモジュールに出力する (ZilGlobal.lua には
        # 集めない)。宣言の順序は、モジュールを require する順 (INSERT-FILE の順) で決まる
        if self.global_file is not None and not is_redef and not is_object:
            self.global_file.add(self.source_name, [*(location or []), decl], name=name, value=value_key, category=category)
            return [f"-- {name} is declared in ZilGlobal.lua"], expr
        return [decl], expr

    def _global_category(self, name: str, kind: str) -> str:
        return "const" if kind == "CONSTANT" else "state"

    def _transcode_global_declaration(self, node: ZList, kind: str) -> list[str]:
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if len(args) < 2:
            return [f"-- {kind} skipped"]
        name = self._param_name(args[0], local=False)
        val_node = args[1]
        if kind == "GDECL":
            return [f"-- GDECL {name}"]
        cat = self._global_category(name, kind)
        lines, _ = self._lazy_declaration(
            name, lambda: self._expr(val_node), repr(val_node), category=cat, location=self._location_lines(node)
        )
        return lines

    def transcode_global(self, node: ZList) -> list[str]:
        return self._transcode_global_declaration(node, form_name(node) or "GLOBAL")

    def transcode_constant(self, node: ZList) -> list[str]:
        return self._transcode_global_declaration(node, "CONSTANT")

    def transcode_setg(self, node: ZList) -> list[str]:
        if self.macros.is_alias_setg(node):
            return ["-- SETG: compile-time macro alias (not transcoded)"]
        return self._transcode_global_declaration(node, "SETG")

    def transcode_object(self, node: ZList) -> list[str]:
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 2:
            return self._fallback(node, DISCARD_MODE)
        name = self._param_name(items[1], local=False)
        head = items[1]
        while isinstance(head, ZExp) and head.item is not None:
            head = head.item
        zil_name = head.text if isinstance(head, ZSymbol) else name
        lines, _ = self._lazy_declaration(
            name, lambda: self._object_expr(zil_name, items[2:]), repr(zil_name), is_object=True
        )
        return lines

    def _object_expr(self, zil_name: str, prop_nodes: list[ZNode]) -> str:
        def _build_props() -> str:
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
                    if getattr(parts[2], "text", None) == zil_name:
                        continue
                    if head.text.upper() == "LOC":
                        parts = [head, parts[2]]
                key = _lua_str(head.text) if isinstance(head, ZSymbol) else self._expr(head)
                if (
                    isinstance(head, ZSymbol)
                    and head.text.upper() == "IN"
                    and len(parts) == 2
                    and isinstance(parts[1], ZSymbol)
                ):
                    key = _lua_str("LOC")
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
                    value = "true"
                elif len(values) == 1:
                    value = values[0]
                else:
                    value = self._tuple(values)
                properties.append(f"[{key}] = {value}")
            if not properties:
                return ""
            return f",\n{INDENT_UNIT}".join(properties)

        saved_temp = self._temp_count
        self._temp_count = 0
        try:
            pre, body = self._capture(_build_props)
        finally:
            self._temp_count = saved_temp
        if not body:
            return f"{GLOBALS_NAME}._declare_object({_lua_str(zil_name)})"
        if pre:
            temps, code = self._bind_temps([*pre, body], [])
            pre, body = code[:-1], code[-1]
            pre_block = self._indent([*temps, *pre])
            return (
                f"{GLOBALS_NAME}._declare_object({_lua_str(zil_name)}, function()\n"
                f"{pre_block}\n"
                f"{INDENT_UNIT}return {{\n{INDENT_UNIT}{body},\n{INDENT_UNIT}}}\n"
                f"end)"
            )
        return f"{GLOBALS_NAME}._declare_object({_lua_str(zil_name)}, function() return {{\n{INDENT_UNIT}{body},\n}} end)"

    def transcode_defmac(self, node: ZList) -> list[str]:
        items = [item for item in node.items[1:] if not is_ignorable(item)]
        name = items[0].text if items and isinstance(items[0], ZSymbol) else "?"
        lines = self._defmac_lines(name)
        if lines is not None:
            return lines + self._macro_function_lines(name)
        return [f"-- DEFMAC {name}"]

    def _comment_block(self, lines: list[str]) -> list[str]:
        """トップレベルの塊は空行で区切られるので、コメントのまとまりを 1 つの塊にする。"""
        return ["\n".join(lines)]

    def _prefix_lines(self, prefix: list[str], lines: list[str]) -> list[str]:
        """コメントの行を、次の行と同じ塊にする (トップレベルの塊は空行で区切られる)。"""
        if not prefix or not lines:
            return prefix + lines
        return ["\n".join([*prefix, lines[0]]), *lines[1:]]

    def _nested_declaration(self, node: ZList, name: str) -> list[str]:
        if name in ("ROUTINE", "DEFINE"):
            return self.transcode_routine(node)
        if name == "INSERT-FILE":
            return self.transcode_insert_file(node)
        if name == "DEFMAC":
            return self.transcode_defmac(node)
        if name == "GLOBAL":
            return self.transcode_global(node)
        if name == "CONSTANT":
            return self.transcode_constant(node)
        if name == "SETG":
            return self.transcode_setg(node)
        if name in ("OBJECT", "ROOM"):
            return self.transcode_object(node)
        return []

    def _finish(self, expr: str, mode: Mode) -> list[str]:
        if mode.kind == "discard":
            if expr in ("true", "false", "0", "nil") or expr.isidentifier():
                return []
            return [f"do local _ = {expr} end"]
        if mode.kind == "return":
            return [f"do return {expr} end"]
        if mode.kind == "assign":
            return [f"{mode.target} = {expr}"]
        return []

    def _cond_chain(self, clauses: list[ZList], mode: Mode) -> list[str]:
        lines: list[str] = []
        for idx, clause in enumerate(clauses):
            items = [item for item in clause.items if not is_ignorable(item)]
            if not items:
                continue
            cond, body = items[0], items[1:]
            is_else = isinstance(cond, ZSymbol) and cond.text.upper() in ("T", "ELSE")
            if is_else:
                body_lines = self._block(body, mode) if body else self._finish("true", mode)
                if idx == 0:
                    return body_lines
                lines.append("else")
                lines.append(self._indent(body_lines))
                lines.append("end")
                return lines
            # 条件の中で展開したマクロの注記は、その節の if / elseif の直前に付ける
            (pre, test_expr), notes = self._notes_of(lambda c=cond: self._capture(lambda: self._test_expr(c)))
            if pre:
                if idx == 0:
                    lines.extend(self._note_comments(notes))
                    notes = []
                    lines.extend(pre)
                else:
                    lines.append("else")
                    inner = pre + self._cond_chain(clauses[idx:], mode)
                    lines.append(self._indent(inner))
                    lines.append("end")
                    return lines
            kw = "if" if idx == 0 else "elseif"
            lines.extend(self._note_comments(notes))
            lines.append(f"{kw} {test_expr} then")
            if body:
                lines.append(self._indent(self._block(body, mode)))
            else:
                # 節の本体が空なら、条件式の値そのものを返す
                lines.append(self._indent(self._finish("true", mode)))
        if mode.kind != "discard":
            lines.append("else")
            lines.append(self._indent(self._finish("false", mode)))
        lines.append("end")
        return lines

    def _stmt_loop(self, node: ZList, mode: Mode) -> list[str]:
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if args and isinstance(args[0], ZSymbol):
            args = args[1:]
        lines: list[str] = []
        if args and isinstance(args[0], ZList) and args[0].kind == "paren":
            lines.extend(self._bindings(args[0].items))
            args = args[1:]

        is_repeat = form_name(node) == "REPEAT"
        has_again = any(contains_bare_again(item) for item in args)
        brk_var = self._new_brk() if has_again else None
        self._loops.append((mode, brk_var))
        try:
            if has_again:
                assert brk_var is not None
                if is_repeat:
                    body = self._block(args, DISCARD_MODE)
                else:
                    body = self._block(args, mode) + [f"{brk_var} = true", "break"]
                loop_lines = [
                    "while true do",
                    self._indent([f"local {brk_var} = false", "repeat", self._indent(body), "until true", f"if {brk_var} then break end"]),
                    "end",
                ]
            else:
                if is_repeat:
                    body = self._block(args, DISCARD_MODE)
                else:
                    body = self._block(args, mode) + ["break"]
                loop_lines = ["while true do", self._indent(body), "end"]
        finally:
            self._loops.pop()
        return lines + loop_lines

    def _bindings(self, items: Iterable[ZNode]) -> list[str]:
        lines: list[str] = []
        for item in items:
            if is_ignorable(item):
                continue
            if isinstance(item, ZList) and item.kind == "paren":
                parts = [p for p in item.items if not is_ignorable(p)]
                if not parts:
                    continue
                name = self._param_name(parts[0])
                val = parts[1] if len(parts) > 1 else None
                if val is not None:
                    pre, expr = self._capture(lambda v=val: self._expr(v))
                    lines.extend(pre)
                    lines.append(f"local {name} = {expr}")
                    continue
            else:
                name = self._param_name(item)
            lines.append(f"local {name} = 0")
        return lines

    def _stmt_set(self, node: ZList, mode: Mode) -> list[str]:
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        target = self._set_target(node, args)
        if target is None:
            return self._fallback(node, mode)
        pre, value = self._capture(lambda: self._expr(args[1]))
        if target.startswith(f"{GLOBALS_NAME}."):
            attr = target.split(".", 1)[1]
            assign = f"{GLOBALS_NAME}._set({_lua_str(attr)}, {value})"
        else:
            assign = f"{target} = {value}"
        if mode.kind == "discard":
            return pre + [assign]
        return pre + [assign] + self._finish(target, mode)

    def _set_target(self, node: ZList, args: list[ZNode]) -> str | None:
        if len(args) != 2 or not isinstance(args[0], ZSymbol):
            return None
        if form_name(node) == "SETG":
            return f"{GLOBALS_NAME}.{to_identifier(args[0].text)}"
        return _lua_ident(local_name(args[0].text))

    def _logic_chain(self, operands: list[ZNode], is_and: bool, mode: Mode) -> list[str]:
        if len(operands) == 1:
            return self._stmt(operands[0], mode)
        first, rest = operands[0], operands[1:]
        if mode.kind == "discard":
            pre, test = self._capture(lambda: self._test_expr(first))
            cond = test if is_and else f"(not {test})"
            return pre + [f"if {cond} then", self._indent(self._logic_chain(rest, is_and, mode)), "end"]
        temp = self._new_temp()
        pre, expr = self._capture(lambda: self._expr(first))
        cond = f"{GLOBALS_NAME}._T({temp})" if is_and else f"(not {GLOBALS_NAME}._T({temp}))"
        lines = pre + [f"{temp} = {expr}", f"if {cond} then"]
        lines.append(self._indent(self._logic_chain(rest, is_and, Mode("assign", temp))))
        if mode.kind == "assign":
            lines.append("end")
            if temp != mode.target:
                lines.append(f"{mode.target} = {temp}")
        else:
            lines.append("end")
            lines.extend(self._finish(temp, mode))
        return lines

    def _new_temp(self) -> str:
        """新しい一時変数。名前は関数を作り終えてから決める (_bind_temps) ので、ここでは目印を返す。"""
        self._temp_count += 1
        return f"{_TEMP_MARK}{self._temp_count}{_TEMP_MARK}"

    @staticmethod
    def _bind_temps(lines: list[str], params: list[str]) -> tuple[list[str], list[str]]:
        """関数の中の一時変数の目印を、Lua のローカル変数か、配列 _L の要素にする。

        Lua の関数のローカル変数は 200 個まで (LUAI_MAXVARS)。引数と、関数の中で `local` や
        `for` で宣言する変数を数え、合わせて LUA_LOCAL_BUDGET 個に収まる分の一時変数は、
        Python 版と同じく名前の付いたローカル変数 (_tmp1 など) にする。収まらない分だけ、
        今までどおり配列 _L の要素 (_L[31] など) にする。

        Returns:
            (関数の先頭に置く宣言の行, 目印を置き換えた lines)
        """
        text = "\n".join(lines)
        used = sorted({int(n) for n in _TEMP_RE.findall(text)})
        if not used:
            return [], lines
        declared = len(params)
        for m in _LOCAL_DECL_RE.finditer(text):
            declared += len([n for n in m.group(1).split(",") if n.strip()])
        budget = max(0, LUA_LOCAL_BUDGET - declared)
        named = used[:budget]
        names = {n: f"{TEMP_PREFIX}{n}" for n in named}

        def replace(m: re.Match[str]) -> str:
            n = int(m.group(1))
            return names.get(n, f"_L[{n}]")

        decl: list[str] = []
        if named:
            decl.append(f"local {', '.join(names.values())}")
        if len(named) < len(used):
            decl.append("local _L = {}")
        return decl, [_TEMP_RE.sub(replace, line) for line in lines]

    def _indent(self, lines: list[str]) -> str:
        return "\n".join(f"{INDENT_UNIT}{sub}" for line in lines for sub in line.splitlines())

    def _tuple(self, values: list[str]) -> str:
        return "{" + ", ".join(values) + "}"

    def _expr(self, node: ZNode) -> str:
        node = self._expand_macro(node)
        if isinstance(node, ZSymbol):
            return self._symbol(node.text)
        if isinstance(node, ZString):
            return _lua_str(node.text)
        if isinstance(node, ZExp):
            if node.kind == "EVAL":
                ok, res = self._compile_time(node)
                if ok:
                    return self._expr(res) if res is not None else "false"
            if node.kind == "#CHAR" and isinstance(node.item, ZSymbol):
                ch = ESCAPE_RE.sub(r"\1", node.item.text)
                return str(ord(ch[0])) if ch else "0"
            if node.kind == "QUOTE" and node.item is not None:
                return self._datum(node.item)
            if node.item is not None:
                return self._expr(node.item)
            return "false"
        if isinstance(node, ZList):
            if node.kind == "paren":
                return self._tuple(self._exprs(node.items))
            return self._form_expr(node)
        return "false"

    def _symbol(self, text: str) -> str:
        if INTEGER_RE.fullmatch(text):
            return str(int(text))
        if OCTAL_RE.fullmatch(text):
            return str(int(text[1:-1], 8))
        if text == "T":
            return "true"
        if text == "<>":
            return "false"
        if len(text) == 2 and text.startswith("\\"):
            return _lua_str(text[1])
        if text.startswith("."):
            return _lua_ident(local_name(text))
        symbolic = self._symbolic_constant(text[1:] if text.startswith(",") else text)
        if symbolic is not None:
            return symbolic
        if len(text) > 1 and text[0] == ",":
            return f"{GLOBALS_NAME}.{to_identifier(text[1:])}"
        ident = to_identifier(text)
        if ident in self.global_names or ident in COMPILER_ATOMS:
            return f"{GLOBALS_NAME}.{ident}"
        return _lua_ident(ident)

    def _symbolic_constant(self, name: str) -> str | None:
        if name.startswith(PROPERTY_PREFIX):
            return _lua_str(name[len(PROPERTY_PREFIX):])
        if name.startswith(WORD_PREFIX):
            return f"{GLOBALS_NAME}.{WORD_FUNCTION}({_lua_str(name[len(WORD_PREFIX):].lower())})"
        if name.startswith(PART_PREFIXES):
            return f"{GLOBALS_NAME}.{to_identifier(name)}"
        if name.startswith(SYMBOLIC_PREFIXES):
            return f"{GLOBALS_NAME}.{SYMBOL_FUNCTION}({_lua_str(name)})"
        if name in self.flag_names:
            return _lua_str(name)
        return None

    def _form_expr(self, node: ZList) -> str:
        if not node.items:
            return "false"
        name = form_name(node)
        if name is None:
            return self._tuple(self._exprs(node.items))
        if needs_statement(node):
            temp = self._new_temp()
            self._pre.extend(self._stmt(node, Mode("assign", temp)))
            return temp

        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if name == "ASCII" and len(args) == 1 and isinstance(args[0], ZExp) and args[0].kind == "#CHAR":
            return self._expr(args[0])
        if name in ("SET", "SETG"):
            return self._set_expr(node, args)
        head = to_identifier(name)
        # 宣言のフォーム (VERB? など)。作品の定義で組み込みを上書きした関数なら、ふつうの呼び出し
        if name in DECLARATION_FORMS and self._names.call(head) != GAME:
            return f"{GLOBALS_NAME}.{head}({', '.join(self._datum(arg) for arg in args)})"
        if name in TABLE_FORMS:
            return f"{GLOBALS_NAME}.{head}({', '.join(self._table_args(name, args))})"
        if name in INC_TESTS and len(args) == 2:
            step, op = INC_TESTS[name]
            fn = "ADD" if step == "+" else "SUB"
            var = self._param_name(args[0])
            limit = self._expr(args[1])
            first = args[0]
            if isinstance(first, ZSymbol) and first.text.startswith(","):
                gname = self._param_name(first, local=False)
                ref = f"{GLOBALS_NAME}.{gname}"
                return f"({GLOBALS_NAME}._set({_lua_str(gname)}, {GLOBALS_NAME}.{fn}({ref}, 1)) {op} {limit})"
            return f"(function() {var} = {GLOBALS_NAME}.{fn}({var}, 1); return {var} {op} {limit} end)()"

        if name == "ASSIGNED?" and len(args) == 1 and isinstance(args[0], ZSymbol):
            return f"({self._param_name(args[0])} ~= nil)"

        if name in ("AND", "OR"):
            if not args:
                return "true" if name == "AND" else "false"
            if name == "AND":
                values = [self._test_expr(arg) for arg in args[:-1]] + [self._expr(args[-1])]
                return f"({' and '.join(values)})"
            # OR は最初の truthy な値を返す
            cur = self._expr(args[-1])
            for arg in reversed(args[:-1]):
                a_expr = self._expr(arg)
                cur = f"(function() local _v = {a_expr}; if {GLOBALS_NAME}._T(_v) then return _v end; return {cur} end)()"
            return cur

        values = self._exprs(args)
        if name == "NOT" and len(values) == 1:
            return f"(not {GLOBALS_NAME}._T({values[0]}))"
        if name in LUA_COMPARE_OPS and len(values) >= 2:
            op = LUA_COMPARE_OPS[name]
            if len(values) > 2:
                if op == "==":
                    return f"{GLOBALS_NAME}.EQUAL_p({', '.join(values)})"
                if op == "~=":
                    return f"(not {GLOBALS_NAME}.EQUAL_p({', '.join(values)}))"
            if op in ("<", "<=", ">", ">="):
                def _cmp_pair(a: str, b: str) -> str:
                    if op == "<":
                        return f"{GLOBALS_NAME}.LT({a}, {b})"
                    if op == "<=":
                        return f"{GLOBALS_NAME}.LE({a}, {b})"
                    if op == ">":
                        return f"{GLOBALS_NAME}.LT({b}, {a})"
                    return f"{GLOBALS_NAME}.LE({b}, {a})"
                if len(values) == 2:
                    return _cmp_pair(values[0], values[1])
                checks = [_cmp_pair(values[i], values[i + 1]) for i in range(len(values) - 1)]
                return f"({' and '.join(checks)})"
            if len(values) == 2:
                if op == "==":
                    return f"{GLOBALS_NAME}.EQ({values[0]}, {values[1]})"
                if op == "~=":
                    return f"(not {GLOBALS_NAME}.EQ({values[0]}, {values[1]}))"
                return f"({values[0]} {op} {values[1]})"
            # 3 つ以上の比較
            checks = [f"({values[i]} {op} {values[i + 1]})" for i in range(len(values) - 1)]
            return f"({' and '.join(checks)})"
        if name in LUA_ZERO_TESTS and len(values) == 1:
            if LUA_ZERO_TESTS[name] == "0":
                return f"{GLOBALS_NAME}.ZERO_p({values[0]})"
            return f"({values[0]} == {LUA_ZERO_TESTS[name]})"
        if name in LUA_INFIX_ARITH:
            op = LUA_INFIX_ARITH[name]
            if not values:
                return "0"
            if len(values) == 1:
                return f"{GLOBALS_NAME}.NEG({values[0]})" if op == "-" else values[0]
            if op in ("+", "-"):
                fn = "ADD" if op == "+" else "SUB"
                cur = f"{GLOBALS_NAME}.{fn}({values[0]}, {values[1]})"
                for v in values[2:]:
                    cur = f"{GLOBALS_NAME}.{fn}({cur}, {v})"
                return cur
            return f"({f' {op} '.join(values)})"
        if name in LUA_FN_ARITH:
            fn = LUA_FN_ARITH[name]
            if not values:
                return "0"
            if len(values) == 1:
                return values[0]
            acc = values[0]
            for v in values[1:]:
                acc = f"{GLOBALS_NAME}.{fn}({acc}, {v})"
            return acc
        if INTEGER_RE.fullmatch(name) and len(values) in (1, 2):
            if len(values) == 1:
                return f"{GLOBALS_NAME}.GET({values[0]}, {int(name)})"
            return f"{GLOBALS_NAME}.PUT({values[0]}, {int(name)}, {values[1]})"
        return self._call_expr(node)

    def _test_expr(self, node: ZNode) -> str:
        node = self._expand_macro(node)
        name = form_name(node)
        if isinstance(node, ZList) and not needs_statement(node):
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            if name in ("SET", "SETG") and len(args) == 2 and is_false_constant(args[1]):
                return f"(function() local _ = {self._expr(node)}; return true end)()"
            if name in ("AND", "OR") and args:
                values = [self._test_expr(arg) for arg in args]
                return f"({f' {name.lower()} '.join(values)})"
            if name == "NOT" and len(args) == 1:
                return f"(not {self._test_expr(args[0])})"
            if name in LUA_COMPARE_OPS or name in LUA_ZERO_TESTS or name in INC_TESTS or name == "ASSIGNED?":
                return self._expr(node)
        expr = self._expr(node)
        if expr in ("true", "false"):
            return expr
        return f"{GLOBALS_NAME}._T({expr})"

    def _set_expr(self, node: ZList, args: list[ZNode]) -> str:
        target = self._set_target(node, args)
        if target is None:
            return self._call_expr(node)
        value = self._expr(args[1])
        if target.startswith(f"{GLOBALS_NAME}."):
            attr = target.split(".", 1)[1]
            return f"{GLOBALS_NAME}._set({_lua_str(attr)}, {value})"
        return f"(function() {target} = {value}; return {target} end)()"

    def _call_expr(self, node: ZList) -> str:
        items = [item for item in node.items if not is_ignorable(item)]
        if not items:
            return "false"
        head, args = items[0], items[1:]
        if isinstance(head, ZSymbol):
            upper = head.text.upper()
            if upper in ("TELL", "PRINT"):
                call_args: list[str] = []
                for arg in args:
                    if isinstance(arg, ZExp) and arg.kind == "QUOTE" and isinstance(arg.item, ZSymbol):
                        # 'PRSO は物の短い名前をそのまま表示する (PRINTD 命令)。ゲームの
                        # TELL-TOKENS の D は通さない (ZilToPythonTranscoder と同じ)
                        call_args += [
                            f"{GLOBALS_NAME}._TK.D",
                            self._expr(ZSymbol("," + arg.item.text, arg.span)),
                        ]
                    else:
                        call_args.append(self._tell_arg(arg))
                return f"{GLOBALS_NAME}.{to_identifier(head.text)}({', '.join(call_args)})"
            if upper == "APPLY":
                call_args = self._exprs(args)
                return f"{GLOBALS_NAME}.APPLY({', '.join(call_args)})"
            if head.text.startswith((".", ",")):
                fn = self._symbol(head.text)
                return f"{GLOBALS_NAME}._call({fn}, {', '.join(self._exprs(args))})" if args else f"{GLOBALS_NAME}._call({fn})"
            ident = to_identifier(head.text)
            if self._names.call(ident) == RUNTIME and self._names.shadows_runtime(ident):
                # 物体は呼び出せないので、物体と同じ名前のフォームはランタイムの命令
                # (例: Trinity の <SOUND 1> は効果音)。ZilToPythonTranscoder と同じ扱い
                return f"{GLOBALS_NAME}._rt.{ident}({', '.join(self._exprs(args))})"
            return f"{GLOBALS_NAME}.{ident}({', '.join(self._exprs(args))})"
        fn_expr = self._expr(head)
        if args:
            return f"{GLOBALS_NAME}._call({fn_expr}, {', '.join(self._exprs(args))})"
        return f"{GLOBALS_NAME}._call({fn_expr})"

    def _tell_arg(self, node: ZNode) -> str:
        """TELL の引数を Lua の式に変換する (ZilToPythonTranscoder._tell_arg と同じ規則)。

        ゲームの TELL マクロが定める書式指定子を、ランタイムの標準の指定子 (D など)
        より先に調べる (例: Suspended の D は NDESC)。Deadline の TELL マクロのように、
        コンマの付かない PRSO / PRSI を PRSO-PRINT / PRSI-PRINT の呼び出しにする。
        """
        if isinstance(node, ZSymbol):
            text = node.text
            if not text.startswith((",", ".")):
                custom = self._tell_indicator(text.upper())
                if custom is not None:
                    return custom
                if text.upper() in RUNTIME_TELL_TOKENS:
                    # 書式指定子は ZG._TK のテーブルで渡す (ゲームの文字列 "A" と区別する)
                    return f"{GLOBALS_NAME}._TK.{text.upper()}"
                if text.upper() == "S":
                    return '""'  # ZilRuntime.py の S と同じ (何も出力しない)
            if text.upper() in ("PRSO", "PRSI"):
                printer = f"{text.upper()}_PRINT"
                if printer in self.global_names:
                    return f"{GLOBALS_NAME}._TELL_FN({GLOBALS_NAME}.{printer}, false)"
            if text[:1] not in (",", ".") and not INTEGER_RE.fullmatch(text):
                if to_identifier(text) not in self.global_names:
                    return _lua_str(text)
        return self._expr(node)

    def _tell_indicator(self, name: str) -> str | None:
        """ゲームの TELL マクロが定める書式指定子を、ランタイムの TELL 向けの式にする。

        ZilToPythonTranscoder._tell_indicator と同じ規則:
        - 組み込みの命令 (PRINTD など) で、ゲームに同名のルーチンがなければ、
          ランタイムの指定子 (D など) にする
        - ゲームのルーチンなら、`ZG._TELL_FN(ルーチン, 直後の引数を取るか)` にする
        """
        entry = self.tell_indicators.get(name.upper())
        if entry is None:
            return None
        routine, takes_arg = entry
        ident = to_identifier(routine)
        if routine in BUILTIN_TELL_PRINTERS and ident not in self.global_names:
            if name.upper() in RUNTIME_TELL_TOKENS:
                return None  # ランタイムの指定子と同じなので、そのまま変換する
            return f"{GLOBALS_NAME}._TK.{BUILTIN_TELL_PRINTERS[routine]}"
        if ident not in self.global_names:
            return None
        return (
            f"{GLOBALS_NAME}._TELL_FN({GLOBALS_NAME}.{ident}, "
            f"{'true' if takes_arg else 'false'})"
        )
