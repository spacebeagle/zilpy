"""Python 版と Lua 版の変換器に共通の骨組み (refactor-plan.md Phase 2-3)。

ZIL では全てが式だが、出力する言語には文と式の区別がある。そのため各ノードは
値の扱い方 (Mode) を指定して文の並びとして生成する。式の位置に文が必要な
フォーム (COND など) が現れた場合は、一時変数へ値を求める文を直前に
巻き上げてから、その一時変数を式として使う。

このクラスが持つのは、言語に依存しない部分 (文の振り分け、マクロの展開、
コンパイル時の評価、ループの管理、一時変数の巻き上げ) だけ。出力する文字列は、
サブクラス (python.py・lua.py) が次のフックで決める。

- 定数: TRUE・FALSE・RETURN_CONSTANTS・COMMENT・AGAIN_LINES・PSEUDO_TRIPLES_CALL・
  DROP_EMPTY_LISTS
- 文字列の生成: _str・_tuple・_indent・_new_temp・_finish・_loop_exit・_runtime_fn・
  _plain_ident
- フォームごとの変換: _expr・_call_expr・_test_expr・_cond_chain・_stmt_loop・
  _stmt_set・_logic_chain・_nested_declaration・_toplevel など
"""

import sys
from collections.abc import Callable, Iterable
from typing import TypeVar

from zilpy.compiletime.errors import ConversionError
from zilpy.constants import (
    DECLARATION_FORMS,
    ENTRY_ROUTINE,
    ESCAPE_RE,
    GLOBALS_NAME,
    INTEGER_RE,
    NESTED_DECLARATION_FORMS,
    NOOP_DIRECTIVES,
    RUNTIME_TELL_TOKENS,
    SILENT_ROUTINES,
)
from zilpy.backend.mode import DISCARD_MODE, Mode, RETURN_MODE
from zilpy.compiletime.lowering import (
    expand_inc_dec,
    lower_loop,
    lower_true_test,
    macro_helper_names,
    push_rstack_value,
    param_symbol,
    parse_params,
    referenced_locals,
)
from zilpy.compiletime.lowcore import LOWCORE_FORMS, lower_lowcore_form
from zilpy.compiletime.sourcemap import ZilMap
from zilpy.compiletime.builtin_macros import BUILTIN_MACROS
from zilpy.compiletime.macro_registry import BUILTIN, EXPAND, GAME, MacroInfo, MacroRegistry
from zilpy.compiletime.mdl import MdlError
from zilpy.compiletime.names import NameResolver
from zilpy.compiletime.static_eval import StaticEvaluator, has_vector
from zilpy.front.nodes import (
    ZExp,
    ZList,
    ZNode,
    ZSymbol,
    form_name,
    is_comment,
    is_ignorable,
    needs_statement,
    to_identifier,
    zil_text,
)

T = TypeVar("T")

# マクロがマクロを返すとき、展開を繰り返す上限 (無限に続けない)
MAX_MACRO_EXPANSION = 32
# 名前と位置の対応表 (zilmap.json) に載せる、トップレベルの定義のフォーム
MAPPED_FORMS = frozenset({"ROUTINE", "DEFINE", "OBJECT", "ROOM", "GLOBAL", "CONSTANT", "SETG"})
# 元の ZIL の位置の注記を付ける、トップレベルの定義のフォーム (§2.4)
LOCATED_FORMS = frozenset({"ROUTINE", "DEFINE", "OBJECT", "ROOM", "GLOBAL", "CONSTANT", "SYNTAX"})

# マクロの注記に書く呼び出しの長さの上限 (超えたら末尾を ... にする)
NOTE_WIDTH = 80
# マクロの定義をコメントにしたときの、区切りの線の幅
RULE_WIDTH = 72


class TranscoderBase:
    """ZIL の AST を出力する言語のソースへ変換する変換器の共通部分。"""

    # 出力する言語の真・偽のリテラル
    TRUE = "True"
    FALSE = "False"
    # RTRUE などが関数から返す値
    RETURN_CONSTANTS: dict[str, str] = {}
    # 行コメントの開始
    COMMENT = "#"
    # ループの AGAIN (次の回へ進む) の文
    AGAIN_LINES: list[str] = []
    # ゲームが PSEUDO を定義しているときに出力する呼び出し
    PSEUDO_TRIPLES_CALL = ""
    # 値を捨てる位置の空のリスト (`<>`・`()`) を出力しないか
    DROP_EMPTY_LISTS = False

    def __init__(
        self,
        ast: list[ZNode],
        insert_file: Callable[[str], str | None] | None = None,
        global_names: frozenset[str] | set[str] = frozenset(),
        global_file: object | None = None,
        source_name: str = "",
        flag_names: frozenset[str] | set[str] = frozenset(),
        object_names: frozenset[str] | set[str] = frozenset(),
        static_values: dict[str, int] | None = None,
        macros: MacroRegistry | None = None,
        tell_indicators: dict[str, tuple[str, bool]] | None = None,
    ) -> None:
        """変換器を初期化する。

        Args:
            ast: 変換対象のトップレベルノードのリスト。
            insert_file: <INSERT-FILE "NAME"> を処理するコールバック。
                ファイル名を受け取り、変換後のモジュール名 (失敗時は None) を
                返す。None の場合、INSERT-FILE は関数呼び出しとして扱う。
            global_names: 全モジュールで共有される名前 (ROUTINE・GLOBAL・
                OBJECT など)。これらは `ZG.NAME` として参照する。
            global_file: GLOBAL / CONSTANT / トップレベルの SETG の宣言を
                集める出力先。None の場合は宣言をそのモジュール内に出力する。
            source_name: 変換中のモジュール名 (宣言のまとめ見出しに使う)。
            flag_names: オブジェクトの FLAGS に書かれたフラグ名。生成コードでは
                名前そのものを文字列として扱う。
            object_names: OBJECT・ROOM の名前。物体は呼び出せないので、
                呼び出しの先頭にあれば同名の組み込み命令とみなす
                (例: Trinity の <SOUND 1> と物体 SOUND)。
            static_values: コンパイル時に決まる値 (例: ZORK-NUMBER の 1)。
                `%<COND ...>` を変換時に評価するために使う。
            macros: 作品のマクロ (DEFMAC) と、マクロごとの扱い (macro_registry.py)。
                扱いが EXPAND のマクロは、呼び出しを評価器で展開した式に置き換える。
            tell_indicators: ゲームの TELL マクロから読み取った、書式指定子と
                ルーチンの対応 (例: Suspended の D は NDESC)。
        """
        self.ast: list[ZNode] = ast
        self.insert_file = insert_file
        self.global_names = global_names
        self.global_file = global_file
        self.source_name = source_name
        self.flag_names = flag_names
        self.object_names = object_names
        self.static_values: dict[str, int] = static_values or {}
        self._static = StaticEvaluator(self.static_values, global_names)
        # 作品のマクロ。扱いが EXPAND のものを、呼び出しの位置で展開する
        self.macros: MacroRegistry = macros if macros is not None else MacroRegistry()
        # 展開の結果 (同じノードを何度も変換するので、id で覚えておく)
        self._expansions: dict[int, tuple[ZNode, ZNode]] = {}
        # マクロの注記 (refactor-plan.md §2.5)。変換中のファイルのソースの文字列は、
        # 呼び出しの原文を注記に書くのに使う (ProjectBuilder が変換の前に設定する)
        self.macro_comments = True
        self.source_text = ""
        # 定義の位置の注記 (§2.4)。source_file は変換中の ZIL ファイルの名前 (ProjectBuilder が設定する)
        self.zil_locations = True
        self.zil_comments = True  # ZIL のコメントを残すか (トップレベルと、ルーチンの本体の文の間)
        # --annotate=full: 関数にしたマクロと共通マクロの組み込みの呼び出しにも、マクロの注記を付ける
        self.annotate_full = False
        # --zil-source: ルーチンの前に、ZIL の原文をコメントとして入れる (既定はオフ)
        self.zil_source = False
        self.source_file = ""
        # 名前と位置の対応表 (zilmap.json。ProjectBuilder が全モジュールで共有するものを設定する)
        self.zilmap = ZilMap("")
        self._mapped_nodes: set[int] = set()  # 対応表に載せたノード (_record_definition)
        # 変換中の文で展開したマクロの注記 (展開した元のノードの id, 注記)
        self._notes: list[tuple[int, str]] = []
        self._note_of: dict[int, str] = {}  # 展開した元のノードの id -> 注記
        # ゲームの TELL マクロが定める書式指定子 -> (ルーチン名, 直後の引数を取るか)
        self.tell_indicators: dict[str, tuple[str, bool]] = tell_indicators or {}
        # 呼び出しの名前を、ゲームの定義・ランタイムの命令に振り分ける規則
        self._names = NameResolver(
            global_names, object_names, self.macros.expanded_names(), self.macros.overrides
        )
        # 文として生成する必要がある制御構文のハンドラ
        self._stmt_handlers: dict[str, Callable[[ZList, Mode], list[str]]] = {
            "COND": self._stmt_cond,
            "REPEAT": self._stmt_loop,
            "PROG": self._stmt_loop,
            "BIND": self._stmt_loop,
            "DO": self._stmt_do,
            "MAP-CONTENTS": self._stmt_do,
            "MAP-DIRECTIONS": self._stmt_do,
            "RETURN": self._stmt_return,
            "RTRUE": self._stmt_return_constant,
            "RFALSE": self._stmt_return_constant,
            "RFATAL": self._stmt_return_constant,
            "AGAIN": self._stmt_again,
            "SET": self._stmt_set,
            "SETG": self._stmt_set,
        }
        # 生成中の状態
        self._pre: list[str] = []  # 式の直前に巻き上げる文
        # 囲んでいるループの (値の扱い方, 脱出を知らせる変数)。変数は Lua 版の AGAIN 用
        self._loops: list[tuple[Mode, str | None]] = []
        self._in_function = False
        self._helpers: set[str] | None = None  # DEFMAC から呼ばれる名前
        self._temp_count = 0
        # <REPLACE-DEFINITION NAME> で作品が置き換えた名前 (大文字。ProjectBuilder が設定する)
        self.replaced_definitions: set[str] = set()
        # 作品の TELL マクロの指定子のうち、指定子の表で表せないもの (ProjectBuilder が設定する。
        # compiletime/tell.py の tell_expansion_tokens)。これを含む TELL は作品のマクロで展開する
        self.tell_expansion_tokens: frozenset[str] = frozenset()
        self._stmt_handlers["IFFLAG"] = self._stmt_ifflag

    # ------------------------------------------------------------------
    # サブクラスが決める部分
    # ------------------------------------------------------------------

    def _str(self, text: str) -> str:
        """文字列のリテラル。"""
        raise NotImplementedError

    def _tuple(self, values: list[str]) -> str:
        """式の並びを、出力する言語の列 (タプル・テーブル) にする。"""
        raise NotImplementedError

    def _indent(self, lines: list[str]) -> str:
        """ブロック本体を 1 段インデントする。"""
        raise NotImplementedError

    def _new_temp(self) -> str:
        """新しい一時変数名を返す。"""
        raise NotImplementedError

    def _finish(self, expr: str, mode: Mode) -> list[str]:
        """式の値を mode に従って扱う文を生成する。"""
        raise NotImplementedError

    def _loop_exit(self, brk: str | None) -> list[str]:
        """囲んでいるループを抜ける文。"""
        raise NotImplementedError

    def _runtime_fn(self, name: str) -> str:
        """ランタイムの関数を呼ぶときの名前 (例: Python は TBYTE、Lua は ZG.TBYTE)。"""
        raise NotImplementedError

    def _plain_ident(self, text: str) -> str:
        """接頭辞のないアトムを、そのまま識別子にしたときの表記。"""
        raise NotImplementedError

    def _toplevel_lines(self, node: ZNode) -> list[str]:
        raise NotImplementedError

    def _toplevel(self, node: ZNode) -> list[str]:
        """トップレベルの 1 ノードを変換し、定義なら元の ZIL の位置の注記を前に付ける (§2.4)。"""
        if is_comment(node):
            comment = self._zil_comment_lines(node)
            return self._comment_block(comment) if comment else []
        self._record_definition(node)
        lines = self._toplevel_lines(node)
        if not lines:
            return lines
        return self._prefix_lines(self._location_lines(node) + self._source_lines(node), lines)

    def _source_lines(self, node: ZNode) -> list[str]:
        """--zil-source のとき、ルーチンの ZIL の原文をコメントの行にする (refactor-plan.md §2.4)。

        形は `# | <ROUTINE V-VERBOSE ()` のように、原文の 1 行ごとに `# | ` (Lua は `-- | `) を付ける。
        変換しない DEFINE (マクロの補助など) には付けない。
        """
        if not self.zil_source or not self.source_text or not isinstance(node, ZList):
            return []
        if form_name(node) not in ("ROUTINE", "DEFINE"):
            return []
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 3 or not isinstance(items[1], ZSymbol):
            return []
        if self._compile_time_define(node, items) is not None:
            return []
        text = self.source_text[node.span.start : node.span.end].replace("\r\n", "\n").replace("\t", "        ")
        return [f"{self.COMMENT} | {line}".rstrip() for line in text.split("\n")]

    def _record_definition(self, node: ZNode) -> None:
        """定義を、名前と位置の対応表 (zilmap.json) に載せる。

        トップレベルの定義のほか、トップレベルの PROG や %<COND ...> の中のルーチン
        (Zork の PERFORM など) も、ルーチンを変換するときに載せる。同じノードは 1 回だけ載せる。
        """
        name = form_name(node)
        if name not in MAPPED_FORMS or not isinstance(node, ZList) or id(node) in self._mapped_nodes:
            return
        self._mapped_nodes.add(id(node))
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 2:
            return
        head = items[1]
        while isinstance(head, ZExp) and head.item is not None:
            head = head.item
        if not isinstance(head, ZSymbol):
            return
        if name in ("ROUTINE", "DEFINE") and (len(items) < 3 or self._compile_time_define(node, items) is not None):
            return
        if name == "SETG" and self.macros.is_alias_setg(node):
            return
        self.zilmap.add_definition(
            to_identifier(head.text), head.text, name, self.source_file, node.span.line, self.source_name
        )

    def _record_locals(self, routine: str, args_node: ZNode, body: list[ZNode]) -> None:
        """ルーチンのローカル変数のうち、生成コードの名前が ZIL の名前の機械的な変換と違うもの
        (ランタイムの名前とぶつかって `_l` を付けたものなど) を、対応表に載せる。"""
        names: list[str] = []
        for param in parse_params(args_node):
            symbol = param_symbol(param.name)
            if symbol is not None:
                names.append(symbol.text)
        names += [text[1:] for text in referenced_locals(body)]
        mapping: dict[str, str] = {}
        for zil_name in dict.fromkeys(names):
            generated = self._param_name(ZSymbol(zil_name, args_node.span))
            if generated != to_identifier(zil_name):
                mapping[zil_name] = generated
        self.zilmap.add_locals(to_identifier(routine), mapping)

    def _param_name(self, node: ZNode, local: bool = True) -> str:
        raise NotImplementedError

    def _prefix_lines(self, prefix: list[str], lines: list[str]) -> list[str]:
        """コメントの行を、文の行の前に付ける。"""
        return prefix + lines

    def _location_lines(self, node: ZNode) -> list[str]:
        """定義 (ROUTINE・OBJECT・GLOBAL・SYNTAX など) の、元の ZIL の位置の注記。

        形は `# zil: ファイル:行  <ROUTINE NAME (ARGS)>` (Lua は `--`)。DEFMAC と、変換しない
        DEFINE (マクロの補助など) は、原文のコメントに位置を書くので付けない。
        """
        if not self.zil_locations or not self.source_file or not isinstance(node, ZList):
            return []
        name = form_name(node)
        if name not in LOCATED_FORMS:
            return []
        items = [item for item in node.items if not is_ignorable(item)]
        if name in ("ROUTINE", "DEFINE"):
            if len(items) < 3 or not isinstance(items[1], ZSymbol):
                return []
            if self._compile_time_define(node, items) is not None:
                return []
            args = next((i for i in items[2:] if isinstance(i, ZList) and i.kind == "paren"), None)
            summary = zil_text(ZList("angle", [items[0], items[1], *([args] if args else [])], node.span))
        elif name == "SYNTAX":
            summary = zil_text(node)
        else:
            summary = zil_text(ZList("angle", items[:2], node.span))
        if len(summary) > NOTE_WIDTH:
            summary = summary[: NOTE_WIDTH - 3] + "..."
        return [f"{self.COMMENT} zil: {self.source_file}:{node.span.line}  {summary}"]

    def _expr(self, node: ZNode) -> str:
        raise NotImplementedError

    def _call_expr(self, node: ZList) -> str:
        raise NotImplementedError

    def _test_expr(self, node: ZNode) -> str:
        raise NotImplementedError

    def _cond_chain(self, clauses: list[ZList], mode: Mode) -> list[str]:
        raise NotImplementedError

    def _stmt_loop(self, node: ZList, mode: Mode) -> list[str]:
        raise NotImplementedError

    def _stmt_set(self, node: ZList, mode: Mode) -> list[str]:
        raise NotImplementedError

    def _logic_chain(self, operands: list[ZNode], is_and: bool, mode: Mode) -> list[str]:
        raise NotImplementedError

    def _nested_declaration(self, node: ZList, name: str) -> list[str]:
        raise NotImplementedError

    # ------------------------------------------------------------------
    # トップレベル
    # ------------------------------------------------------------------

    def transcode_toplevel_cond(self, node: ZList) -> list[str]:
        """トップレベルの <COND ...> を変換する。

        条件がコンパイル時に決まる場合 (`<GASSIGNED? ZILCH>` など) は、選ばれた節の
        中身だけをトップレベルの宣言として変換する。決まらない場合は通常の文として変換する。

        Args:
            node: COND フォーム。

        Returns:
            生成された行のリスト。
        """
        known, parts = self._static.select_clause(node)
        if not known:
            return self._stmt(node, DISCARD_MODE)
        lines: list[str] = []
        for item in (parts or [])[1:]:
            lines.extend(self._toplevel(item))
        return lines

    def _directive_lines(self, node: ZNode) -> list[str] | None:
        """ZILCH / ZILF のトップレベルの指示を変換する (refactor-ZILFReferenceGuide-plan.md §1.2)。

        - `<ZSTART GO>`: 開始ルーチンの指定。GO 以外はエラー (ZilMcp が GO を決め打ちしているため)
        - NOOP_DIRECTIVES (`<ORDER-OBJECTS? ...>` など): 生成コードでは何もしない
        - `<IFFLAG ...>`: コンパイル時のフラグで選んだ節の中身を、トップレベルの宣言として変換する
        - `<REPLACE-DEFINITION NAME ...>` / `<DEFAULT-DEFINITION NAME ...>`: 中の定義を変換する。
          作品が REPLACE-DEFINITION で置き換えた名前の DEFAULT-DEFINITION は変換しない

        Returns:
            生成した行。指示でなければ None。

        Raises:
            ConversionError: ZSTART の開始ルーチンが GO でない。
        """
        name = form_name(node)
        if name is None or not isinstance(node, ZList):
            return None
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if name == "ZSTART":
            if len(args) != 1 or not isinstance(args[0], ZSymbol):
                raise ConversionError(f"line {node.span.line}: <ZSTART> takes a single routine name")
            target = args[0].text
            if target.upper() == ENTRY_ROUTINE:
                return [f"{self.COMMENT} ZSTART: the start routine is {ENTRY_ROUTINE}"]
            ident = to_identifier(target)
            return [
                f"{self.COMMENT} ZSTART: the start routine is {target}",
                f"{GLOBALS_NAME}._entry = {self._str(ident)}",
            ]
        if name in NOOP_DIRECTIVES:
            return self._noop_directive_lines(name)
        if name == "IFFLAG":
            lines: list[str] = []
            for item in self._static.eval_ifflag(node):
                lines.extend(self._toplevel(item))
            return lines
        if name in ("REPLACE-DEFINITION", "DEFAULT-DEFINITION"):
            if not args or not isinstance(args[0], ZSymbol):
                raise ConversionError(f"line {node.span.line}: <{name}> needs the name of the definition")
            if name == "DEFAULT-DEFINITION" and args[0].text.upper() in self.replaced_definitions:
                return [f"{self.COMMENT} DEFAULT-DEFINITION {args[0].text}: replaced by REPLACE-DEFINITION"]
            lines = []
            for item in args[1:]:
                lines.extend(self._toplevel(item))
            return lines
        return None

    def _noop_directive_lines(self, name: str) -> list[str]:
        """生成コードでは何もしない指示の位置に出力する行 (Python はコメント、Lua は何も出さない)。"""
        return [f"{self.COMMENT} {name}: compiler directive (not transcoded)"]

    def _stmt_ifflag(self, node: ZList, mode: Mode) -> list[str]:
        """ルーチンの中の `<IFFLAG ...>` を、選ばれた節の本体の文の並びに変換する。"""
        return self._block(self._static.eval_ifflag(node), mode)

    def _compile_time_define(self, node: ZList, items: list[ZNode]) -> list[str] | None:
        """変換しない DEFINE (コンパイル時にだけ動く MDL の関数) なら、注記の行を返す。

        - DEFMAC から呼ばれる補助の DEFINE (MULTIFROB など)
        - 宣言のフォームと同じ名前の DEFINE (Spellbreaker の PSEUDO など)。同じ働きを
          ランタイムが持つ

        Args:
            node: ROUTINE または DEFINE フォーム。
            items: node の要素 (コメントを除いたもの)。

        Returns:
            注記の行。変換するルーチンなら None。
        """
        if form_name(node) != "DEFINE":
            return None
        name = items[1].text if isinstance(items[1], ZSymbol) else ""
        if name in self._macro_helpers():
            lines = self._helper_define_lines(name)
            if lines is not None:
                return lines
            return [f"{self.COMMENT} DEFINE {name}: helper of compile-time macros (not transcoded)"]
        if name.upper() in (*DECLARATION_FORMS, "IFSOUND"):
            lines = [f"{self.COMMENT} DEFINE {name}: compile-time function (provided by the runtime)"]
            if name.upper() == "PSEUDO":
                # ゲームが定義する PSEUDO は、(名詞, 形容詞, ルーチン) の 3 つ組の表を作る
                # (Spellbreaker の misc.zil)。定義のないゲームの (形容詞, 名詞) の組とは違う
                lines.append(self.PSEUDO_TRIPLES_CALL)
            return lines
        return None

    def _silenced_body(self, name: str, body: list[ZNode]) -> tuple[list[ZNode], list[str]]:
        """効果音のルーチン (zilpy.constants.SILENT_ROUTINES) なら、本体を T (何もしないで真を返す) にする。

        引数の宣言は残す (呼び出し側の引数の数は変わらない)。

        Returns:
            (本体, ルーチンの前に出力するコメントの行)。
        """
        if name.upper() not in SILENT_ROUTINES or not body:
            return body, []
        span = body[0].span
        comment = [
            f"{self.COMMENT} ROUTINE {name}: 効果音を鳴らすルーチン。ZilPy は効果音を出さないので、",
            f"{self.COMMENT} 本体を何もしない (真を返す) ものにした (zilpy.constants.SILENT_ROUTINES)。",
        ]
        return [ZSymbol("T", span)], self._comment_block(comment)

    def _macro_helpers(self) -> set[str]:
        """DEFMAC の本体から呼ばれている名前 (lowering.macro_helper_names)。"""
        if self._helpers is None:
            self._helpers = macro_helper_names(self.ast)
        return self._helpers

    # ------------------------------------------------------------------
    # 文の生成
    # ------------------------------------------------------------------

    def _expand_macro(self, node: ZNode) -> ZNode:
        """変換時に展開するマクロ (INC/DEC、P?、文脈のフォーム、作品の DEFMAC) を展開する。

        作品の DEFMAC は、扱いが EXPAND のものだけを評価器 (compiletime/mdl.py) で展開する。
        例: Suspended の `<IRIS?>` は `<EQUAL? ,WINNER ,IRIS>` に、
        AMFV の `<DISABLE <INT I-FOO>>` は `<PUT <INT I-FOO> ,C-RTN 0>` になる。
        RFATAL のように、変換器が文として特別に扱うものは展開しない。
        展開した結果がまたマクロなら、それも展開する。展開できなかった呼び出しは、
        警告を出して、そのまま (ランタイムの同じ名前の関数の呼び出しとして) 残す。

        Args:
            node: 対象のノード。

        Returns:
            展開した式。マクロの呼び出しでなければ node そのもの。
        """
        cached = self._expansions.get(id(node))
        if cached is not None and cached[0] is node:
            note = self._note_of.get(id(node))
            if note is not None and (id(node), note) not in self._notes:
                self._notes.append((id(node), note))  # 同じ文を作り直したときも注記を残す
            return cached[1]
        original = node
        chain: list[str] = []  # 展開したマクロの呼び出しと定義の場所 (注記に書く)
        reason = ""  # 関数にしたマクロを、その場で展開した理由
        ending = "expanded"  # 注記の終わり (--annotate=full では builtin・function もある)
        for _ in range(MAX_MACRO_EXPANSION):
            node = expand_inc_dec(node, self.global_names)
            node = self._lower_builtin(node)
            name = form_name(node)
            if name == "TELL" and isinstance(node, ZList) and self._tell_needs_expansion(node):
                # 指定子の表で表せない TELL (Moonmist の CHE・HIS・FN など)。作品の TELL マクロで展開する
                args = [item for item in node.items[1:] if not is_ignorable(item)]
                try:
                    expanded = self.macros.expand(name, args, node.span)
                except MdlError as error:
                    self.macros.warn(name, node, error)
                    break
                info = self.macros.macros[self.macros.resolve(name)]
                chain.append(f"{self._call_text(node, chain)} ({info.location})")
                node = expanded
                continue
            if self.annotate_full and name is not None and isinstance(node, ZList) and self.macros.decision(name) == BUILTIN:
                # 共通マクロの組み込みの呼び出し (VERB_p(...) など)。--annotate=full のときだけ注記する
                info = self.macros.macros[self.macros.resolve(name)]
                chain.append(f"{self._call_text(node, chain)} ({info.location})")
                ending = "builtin"
                break
            if (
                name is None
                or not isinstance(node, ZList)
                or self.macros.decision(name) != EXPAND
                # 変換器が文として扱うもの (RFATAL)。ただし作品の定義が組み込みと違えば展開する
                or (name in self._stmt_handlers and name not in BUILTIN_MACROS)
            ):
                break
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            try:
                expanded = self.macros.expand(name, args, node.span)
            except MdlError as error:
                self.macros.warn(name, node, error)
                break
            info = self.macros.macros[self.macros.resolve(name)]
            call, why = self.macros.function_call(name, args, expanded, node.span)
            if call is not None:
                # 関数にしたマクロ (§2.3)。関数の呼び出しには注記を付けない (--annotate=full を除く)。
                # 関数の名前はマクロと同じことがあるので、この呼び出しをもう一度展開しないように覚えておく
                if self.annotate_full:
                    chain.append(f"{self._call_text(node, chain)} ({info.location})")
                    ending = "function"
                node = call
                self._expansions[id(call)] = (call, call)
                break
            chain.append(f"{self._call_text(node, chain)} ({info.location})")
            node = expanded
            if why:
                reason = why
        if chain:
            note = " -> ".join(chain) + f" -> {ending}" + (f" ({reason})" if reason and ending == "expanded" else "")
            self._note_of[id(original)] = note
            self._notes.append((id(original), note))
        self._expansions[id(original)] = (original, node)
        return node

    def _tell_needs_expansion(self, node: ZList) -> bool:
        """TELL の呼び出しを、`TELL(...)` のままにせず作品の TELL マクロで展開するか。

        作品の TELL マクロに、指定子の表で表せない指定子 (tell_expansion_tokens) があるときだけ
        展開を考える (Moonmist だけ。ほかの作品の TELL は今までどおり TELL(...) のまま)。
        そのうえで、引数に次のアトムがあれば展開する:
        - 表で表せない指定子 (CHE・HIS・FN など)
        - 指定子の表にも、ランタイムの指定子にもなく、作品の定義名でもないむき出しのアトム
          (`<TELL HE ,X is " here">` の動詞 is のように、マクロが文字列にして使うもの)
        """
        if not self.tell_expansion_tokens:
            return False
        for item in node.items[1:]:
            if not isinstance(item, ZSymbol) or is_ignorable(item):
                continue
            text = item.text
            if text[:1] in (",", ".", "\\") or INTEGER_RE.fullmatch(text):
                continue
            upper = text.upper()
            if upper in self.tell_expansion_tokens:
                return True
            if upper in self.tell_indicators or upper in RUNTIME_TELL_TOKENS or upper == "T":
                continue
            if to_identifier(text) not in self.global_names:
                return True
        return False

    def _game_defines(self, name: str) -> bool:
        """作品が name を ROUTINE・DEFMAC などで定義しているか (定義があれば組み込みの書き換えをしない)。"""
        return to_identifier(name) in self.global_names or name.upper() in self.macros.macros

    def _lower_builtin(self, node: ZNode) -> ZNode:
        """コンパイラ (ZILCH) の組み込みのフォームを、変換できるフォームに書き換える。

        - `<LOWCORE ...>` / `<LOWCORE-TABLE ...>`: ヘッダ (アドレス 0) の読み書き (compiletime/lowcore.py)
        - `<T? X>`: `<NOT <ZERO? X>>` (lowering.lower_true_test)

        作品が同じ名前を定義していれば、作品の定義を使う (書き換えない)。
        """
        name = form_name(node)
        if name is None or not isinstance(node, ZList) or self._game_defines(name):
            return node
        if name in LOWCORE_FORMS:
            return lower_lowcore_form(node)
        if name == "T?":
            return lower_true_test(node) or node
        return node

    def _compile_time(self, node: ZExp) -> tuple[bool, ZNode | None]:
        """`%<...>` を変換時に評価する。

        - `%<NAME ...>` の NAME が作品の DEFINE (コンパイル時の関数。例: DEBUG-CODE) なら、
          評価器で呼んだ結果
        - それ以外 (`%<COND ...>`) は StaticEvaluator で評価する

        Returns:
            (評価できたか, 値のノード)。値がなければ (True, None)。
        """
        item = node.item
        name = form_name(item) if node.kind == "EVAL" else None
        if (
            name is not None
            and isinstance(item, ZList)
            and name in self.macros.evaluator.functions
            and not self.macros.evaluator.functions[name].is_macro
            # 引数にベクタ [...] があれば、評価器 (ベクタを知らない) ではなく StaticEvaluator で
            # 評価する (Moonmist の %<DEBUG-CODE [<ROUTINE ...> ...]>)
            and not (name == "DEBUG-CODE" and has_vector(list(item.items[1:])))
        ):
            args = [arg for arg in item.items[1:] if not is_ignorable(arg)]
            try:
                value = self.macros.evaluator.call(name, args, item.span)
            except MdlError as error:
                print(
                    f"Warning: %<{name} ...> at line {item.span.line} could not be evaluated: {error}",
                    file=sys.stderr,
                )
            else:
                if isinstance(value, ZExp) and value.kind == "QUOTE" and value.item is not None:
                    value = value.item
                return True, value
        return self._static.eval_compile_time(node)

    def _call_text(self, node: ZList, chain: list[str]) -> str:
        """注記に書く呼び出しの形。最初の呼び出しはソースの原文を 1 行にしたもの。"""
        text = ""
        if not chain and self.source_text:
            raw = self.source_text[node.span.start : node.span.end]
            name = form_name(node) or ""
            if raw.upper().startswith("<" + name):
                text = " ".join(raw.split())
        if not text:
            text = zil_text(node)
        return text if len(text) <= NOTE_WIDTH else text[: NOTE_WIDTH - 3] + "..."

    def _with_notes(self, build: Callable[[], list[str]]) -> list[str]:
        """文を生成し、その中で展開したマクロの注記を文の直前の行に付ける。

        同じ注記が 1 つの文に何度も出るときは、1 行にまとめて回数を書く。
        """
        lines, notes = self._notes_of(build)
        if not lines:
            return lines
        return self._note_comments(notes) + lines

    def _notes_of(self, build: Callable[[], T]) -> tuple[T, list[tuple[int, str]]]:
        """build を実行し、その中で展開したマクロの注記を、外側に渡さずに取り出す。"""
        saved, self._notes = self._notes, []
        try:
            result = build()
        finally:
            notes, self._notes = self._notes, saved
        return result, notes

    def _note_comments(self, notes: list[tuple[int, str]]) -> list[str]:
        """注記を、コメントの行にする。同じ注記は 1 行にまとめて回数を書く。"""
        if not self.macro_comments:
            return []
        counts: dict[str, int] = {}
        for _, note in notes:
            counts[note] = counts.get(note, 0) + 1
        return [f"{self.COMMENT} macro: {note}" + (f" (x{n})" if n > 1 else "") for note, n in counts.items()]

    def _definition_comment(self, kind: str, info: MacroInfo, explanation: list[str]) -> list[str]:
        """マクロ (または補助の DEFINE) の定義の原文を、コメントにした行を作る (§2.5)。"""
        c = self.COMMENT
        last_line = info.span.line + info.source.count("\n")
        head = f"{c} ---- {kind} {info.name} ({info.file}:{info.span.line}-{last_line}) "
        lines = [head + "-" * max(4, RULE_WIDTH - len(head))]
        lines += [f"{c} {text}" for text in explanation]
        lines.append(f"{c} この定義は実行されない (ZIL の原文を残したもの)。")
        lines.append(c)
        lines += [f"{c} {line}".rstrip() for line in info.source.splitlines()]
        lines.append(f"{c} " + "-" * (RULE_WIDTH - len(c) - 1))
        return self._comment_block(lines)

    def _comment_block(self, lines: list[str]) -> list[str]:
        """続けて出力するコメントの行のまとまり (Lua はトップレベルの行を空行で区切るので、1 つにする)。"""
        return lines

    def _defmac_lines(self, name: str) -> list[str] | None:
        """DEFMAC の位置に出力する行 (原文のコメントと、マクロの扱いの説明)。

        マクロの注記を出さない設定、または登録されていないマクロなら None。
        """
        info = self.macros.macros.get(name.upper())
        if info is None or not self.macro_comments:
            return None
        if self.macros.is_unused(name):
            explanation = ["このマクロは、どこからも呼ばれていない。"]
        elif info.decision == EXPAND and to_identifier(info.name) in self.macros.overrides:
            builtin = BUILTIN_MACROS[name.upper()].runtime
            explanation = [
                f"このマクロは共通マクロ {info.name} と同じ名前だが、定義の意味が組み込みと違うため、",
                f"この作品の定義から下の関数を作り、ランタイムの組み込み {builtin} を上書きする。",
                f"({info.reason})",
            ]
        elif info.decision == EXPAND and self.macros.functions_of(name):
            explanation = [
                "このマクロは、下の関数に変換した。呼び出しは関数の呼び出しになる。ただし、",
                "副作用のある引数を渡す呼び出しなど、関数と同じ動きにならない呼び出しは、その位置に展開する。",
            ]
        elif info.decision == EXPAND:
            explanation = ["このマクロは変換時に展開される (呼び出しの位置に展開した式を出力する)。"]
            if info.reason:
                explanation.append(f"共通マクロと同じ名前だが、定義の意味が違うため、この作品の定義を展開する ({info.reason})。")
        elif info.decision == BUILTIN:
            builtin = BUILTIN_MACROS[name.upper()].runtime
            explanation = [f"このマクロは、ランタイムの組み込み {builtin} を使う (定義を比べて、同じ意味だと確かめた)。"]
        elif info.decision == GAME:
            explanation = ["同じ名前の ROUTINE があるため、このマクロは使われない。"]
        elif name.upper() == "TELL":
            explanation = [
                "このマクロは展開しない。呼び出しは TELL(...) のまま残し、ランタイムの TELL が",
                "書式指定子を解釈する (書式指定子とルーチンの対応は、この定義から読み取る)。",
            ]
        else:
            explanation = [f"このマクロは展開しない。ランタイムの同じ名前の関数を使う ({info.reason})。"]
        return self._definition_comment("DEFMAC", info, explanation)

    def _macro_function_lines(self, name: str) -> list[str]:
        """マクロから作った関数の定義 (ルーチンと同じ形で出力する)。"""
        info = self.macros.macros.get(self.macros.resolve(name))
        if info is None:
            return []
        lines: list[str] = []
        for fn in self.macros.functions_of(name):
            self.zilmap.add_definition(
                to_identifier(fn.name), fn.name, "DEFMAC", info.file, info.span.line, self.source_name
            )
            routine = fn.routine(info.span)
            self._mapped_nodes.add(id(routine))  # 上で DEFMAC として載せた (ROUTINE としては載せない)
            lines += self._function_separator() + self.transcode_routine(routine)
        return lines

    def _function_separator(self) -> list[str]:
        """マクロから作った関数の定義の間に入れる行 (Python は空行。Lua はトップレベルの塊が空行で区切られる)。"""
        return []

    def transcode_routine(self, node: ZList) -> list[str]:
        raise NotImplementedError

    def _helper_define_lines(self, name: str) -> list[str] | None:
        """マクロの補助の DEFINE の位置に出力する行 (原文のコメント)。"""
        info = self.macros.defines.get(name.upper())
        if info is None or not self.macro_comments:
            return None
        explanation = ["このマクロ補助関数は、変換時に評価器が実行する (生成コードでは実行されない)。"]
        return self._definition_comment("DEFINE", info, explanation)

    def _stmt(self, node: ZNode, mode: Mode) -> list[str]:
        """ノードを、値を mode に従って扱う文の並びに変換する。

        Args:
            node: 変換対象のノード。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        if is_ignorable(node):
            return []
        node = self._expand_macro(node)
        if isinstance(node, ZSymbol) and mode.kind == "discard":
            # 値を捨てる位置のアトムや変数参照には副作用がないので出力しない。
            # (例: planetfall の `<SETG LOWER-ELEVATOR-ON T>Y` の `Y` は
            # どこにも定義がないが、ZILCH はこれを無視する。)
            return []
        if isinstance(node, ZExp) and node.kind == "EVAL":
            known, value = self._compile_time(node)
            if known:
                return [] if value is None else self._stmt(value, mode)
        if isinstance(node, ZExp) and node.kind != "QUOTE" and node.item is not None:
            return self._stmt(node.item, mode)  # %<...> などは中身を評価する
        if (
            isinstance(node, ZExp)
            and node.item is not None
            and not self._in_function
            and mode.kind == "discard"
            and form_name(node.item) is not None
        ):
            # %<COND (... '<PROG ...>)> のように、コンパイル時に取り込まれる
            # コードとして書かれたクォート付きフォームは、データではなくコードとして扱う
            return self._stmt(node.item, mode)
        name = form_name(node)
        if name == "PROG" and self._in_function:
            pushed = push_rstack_value(node)
            if pushed is not None:
                # <PROG () <PUSH X> <RSTACK>> (RFATAL の定義) は、X でルーチンから戻る
                return self._stmt(pushed, RETURN_MODE)
        if name is not None and isinstance(node, ZList):
            handler = self._stmt_handlers.get(name)
            if handler is not None:
                return handler(node, mode)
            if name in ("AND", "OR") and needs_statement(node):
                return self._stmt_logic(node, mode)
            if not self._in_function and name in NESTED_DECLARATION_FORMS:
                return self._nested_declaration(node, name)
        if (
            self.DROP_EMPTY_LISTS
            and mode.kind == "discard"
            and isinstance(node, ZList)
            and not node.items
        ):
            return []
        pre, expr = self._capture(lambda: self._expr(node))
        return pre + self._finish(expr, mode)

    def _block(self, items: Iterable[ZNode], mode: Mode) -> list[str]:
        """式の並びを文の並びに変換する。最後の式の値だけを mode で扱う。

        Args:
            items: 式の並び。
            mode: 最後の式の値の扱い方。

        Returns:
            生成された行のリスト。
        """
        items = list(items)
        nodes = [item for item in items if not is_ignorable(item)]
        if not nodes:
            return [] if mode.kind == "discard" else self._finish(self.FALSE, mode)
        lines: list[str] = []
        # ZIL のコメント (;"...") は、次の文の直前に置く。文のないブロックには置かない
        # (Python ではコメントだけのブロックは構文の誤りになる)
        pending: list[str] = []
        index = 0
        for item in items:
            if is_comment(item):
                pending += self._zil_comment_lines(item)
                continue
            if is_ignorable(item):
                continue
            is_last = index == len(nodes) - 1
            index += 1
            item_mode = mode if is_last else DISCARD_MODE
            stmt = self._with_notes(lambda: self._stmt(item, item_mode))
            if stmt:
                lines += pending + stmt
                pending = []
        if pending and lines:
            lines += pending
        return lines

    def _zil_comment_lines(self, node: ZNode) -> list[str]:
        """ZIL のコメント (;"..." や ;<...>) の原文を、出力する言語のコメントの行にする。"""
        if not self.zil_comments or not self.source_text or not isinstance(node, ZExp) or node.item is None:
            return []
        text = self.source_text[node.span.start : node.item.span.end]
        return [f"{self.COMMENT} {line}".rstrip() for line in text.replace("\r\n", "\n").split("\n")]

    def _body_with_comments(self, node: ZList, args_node: ZNode, body: list[ZNode]) -> list[ZNode]:
        """ルーチンの本体を、文の間の ZIL のコメントを含めて返す (_block に渡す)。"""
        if not self.zil_comments:
            return body
        for index, item in enumerate(node.items):
            if item is args_node:
                return [x for x in node.items[index + 1 :] if is_comment(x) or not is_ignorable(x)]
        return body

    def _fallback(self, node: ZList, mode: Mode) -> list[str]:
        """特別扱いできないフォームを関数呼び出しとして生成する。

        Args:
            node: 先頭がシンボルの山括弧リスト。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        pre, expr = self._capture(lambda: self._call_expr(node))
        return pre + self._finish(expr, mode)

    def _stmt_cond(self, node: ZList, mode: Mode) -> list[str]:
        """<COND (TEST BODY...)...> を条件分岐の連鎖に変換する。

        Args:
            node: COND フォーム。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        clauses: list[ZList] = []
        for item in node.items[1:]:
            if isinstance(item, ZExp) and item.kind == "EVAL":
                # <COND %<COND (<==? ,ZORK-NUMBER 1> '(TEST BODY...))> ...> は、
                # コンパイル時に選ばれた節をその場に埋め込む
                _, item = self._compile_time(item)
            if isinstance(item, ZList) and item.kind == "paren":
                clauses.append(item)
        if not clauses:
            return [] if mode.kind == "discard" else self._finish(self.FALSE, mode)
        return self._cond_chain(clauses, mode)

    def _stmt_do(self, node: ZList, mode: Mode) -> list[str]:
        """後期の ZIL のループ DO / MAP-CONTENTS / MAP-DIRECTIONS を変換する。

        lowering.lower_loop で REPEAT に書き換えてから変換する。

        Args:
            node: DO・MAP-CONTENTS・MAP-DIRECTIONS のフォーム。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        loop = lower_loop(node, self._static)
        if loop is None:
            return self._fallback(node, mode)
        return self._stmt_loop(loop, mode)

    def _stmt_return(self, node: ZList, mode: Mode) -> list[str]:
        """<RETURN VALUE> をループの脱出または関数からの return に変換する。

        Args:
            node: RETURN フォーム。
            mode: 値の扱い方 (ループ外で関数呼び出しとして扱う場合に使う)。

        Returns:
            生成された行のリスト。
        """
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        value = args[0] if args else None
        if self._loops:
            loop_mode, brk = self._loops[-1]
            if value is not None:
                lines = self._stmt(value, loop_mode)
            elif loop_mode.kind != "discard":
                lines = self._finish(self.TRUE, loop_mode)
            else:
                lines = []
            if loop_mode.kind != "return":
                lines += self._loop_exit(brk)
            return lines
        if self._in_function:
            if value is None:
                return self._finish(self.TRUE, RETURN_MODE)
            return self._stmt(value, RETURN_MODE)
        return self._fallback(node, mode)

    def _stmt_return_constant(self, node: ZList, mode: Mode) -> list[str]:
        """<RTRUE> / <RFALSE> / <RFATAL> を return 文に変換する。

        Args:
            node: RTRUE、RFALSE または RFATAL フォーム。
            mode: 値の扱い方 (関数外で関数呼び出しとして扱う場合に使う)。

        Returns:
            生成された行のリスト。
        """
        if self._in_function:
            return self._finish(self.RETURN_CONSTANTS[form_name(node) or "RTRUE"], RETURN_MODE)
        return self._fallback(node, mode)

    def _stmt_again(self, node: ZList, mode: Mode) -> list[str]:
        """<AGAIN> をループの次の回へ進む文に変換する。

        Args:
            node: AGAIN フォーム。
            mode: 値の扱い方 (ループ外で関数呼び出しとして扱う場合に使う)。

        Returns:
            生成された行のリスト。
        """
        if self._loops:
            return list(self.AGAIN_LINES)
        return self._fallback(node, mode)

    def _stmt_logic(self, node: ZList, mode: Mode) -> list[str]:
        """演算対象に文が必要な <AND ...> / <OR ...> を if の連鎖に変換する。

        Args:
            node: AND または OR フォーム。
            mode: 値の扱い方。

        Returns:
            生成された行のリスト。
        """
        is_and = form_name(node) == "AND"
        operands = [item for item in node.items[1:] if not is_ignorable(item)]
        if not operands:
            if mode.kind == "discard":
                return []
            return self._finish(self.TRUE if is_and else self.FALSE, mode)
        return self._logic_chain(operands, is_and, mode)

    # ------------------------------------------------------------------
    # 式の生成
    # ------------------------------------------------------------------

    def _capture(self, build: Callable[[], str]) -> tuple[list[str], str]:
        """式を生成し、その際に巻き上げられた文を分けて取り出す。

        Args:
            build: 式を生成する関数。

        Returns:
            (巻き上げられた文のリスト, 生成された式)。
        """
        saved, self._pre = self._pre, []
        try:
            expr = build()
            pre = self._pre
        finally:
            self._pre = saved
        return pre, expr

    def _exprs(self, nodes: Iterable[ZNode]) -> list[str]:
        """複数のノードを式に変換する (コメントや型宣言は除外する)。"""
        return [self._expr(node) for node in nodes if not is_ignorable(node)]

    def _datum(self, node: ZNode) -> str:
        """宣言の引数などをデータとして変換する (アトムは文字列にする)。

        `,X` / `.X` は変数参照、整数は数値、リストは列にする。

        Args:
            node: 変換対象のノード。

        Returns:
            式。
        """
        if isinstance(node, ZSymbol):
            text = node.text
            if len(text) > 1 and text[0] in ",.":
                return self._expr(node)
            if INTEGER_RE.fullmatch(text):
                return str(int(text))
            return self._str(ESCAPE_RE.sub(r"\1", text))
        if isinstance(node, ZList):
            return self._tuple([self._datum(item) for item in node.items if not is_ignorable(item)])
        if isinstance(node, ZExp) and node.kind == "QUOTE" and node.item is not None:
            return self._datum(node.item)
        return self._expr(node)

    def _table_args(self, name: str, args: list[ZNode]) -> list[str]:
        """テーブル宣言の引数を変換する (フラグや種別のアトムは文字列にする)。

        Args:
            name: テーブル宣言のフォーム名。
            args: フォームの引数 (コメント除去済み)。

        Returns:
            引数の式のリスト。
        """
        values: list[str] = []
        for index, arg in enumerate(args):
            is_flags = isinstance(arg, ZList) and arg.kind == "paren"
            # <ITABLE BYTE 10> のような先頭の種別もアトムとして扱う
            is_kind = name == "ITABLE" and index == 0 and isinstance(arg, ZSymbol)
            if is_flags or is_kind:
                values.append(self._datum(arg))
                continue
            if isinstance(arg, ZExp) and arg.kind == "#BYTE" and arg.item is not None:
                # ワードの表の中で 1 要素だけをバイトにする
                # (例: Spellbreaker の P-QBUF `<VOC "AZ" ADJ> 2 #BYTE !\x #BYTE !\1 0 0`)
                values.append(f"{self._runtime_fn('TBYTE')}({self._expr(arg.item)})")
                continue
            element = form_name(arg)
            if element in ("BYTE", "WORD") and isinstance(arg, ZList) and not self._game_defines(element):
                inner = [item for item in arg.items[1:] if not is_ignorable(item)]
                if len(inner) == 1:
                    # 要素の幅の指定 `<BYTE n>` / `<WORD n>` (例: Stationfall の
                    # <ITABLE 60 (LEXV) 0 <BYTE 0> <BYTE 0>>)。<BYTE n> は #BYTE n と同じ
                    value = self._expr(inner[0])
                    values.append(f"{self._runtime_fn('TBYTE')}({value})" if element == "BYTE" else value)
                    continue
            expr = self._expr(arg)
            if (
                isinstance(arg, ZSymbol)
                and arg.text[:1] not in (",", ".")
                and expr == self._plain_ident(arg.text)
                and expr.isidentifier()
            ):
                expr = "0"  # どこにも定義がないアトムは、コンパイラと同様に 0 とする
            values.append(expr)
        return values

    def _prop_value(self, node: ZNode) -> str:
        """オブジェクトのプロパティ値を式に変換する。

        接頭辞のないアトムのうち、全モジュールで共有される名前 (部屋・
        ルーチン・定数など) は ZG の属性として参照し、それ以外 (出口の TO や
        PER などの標識) は文字列にする。

        Args:
            node: プロパティ値のノード。

        Returns:
            式。
        """
        if isinstance(node, ZSymbol):
            text = node.text
            if text[:1] not in (",", ".") and text != "T" and not INTEGER_RE.fullmatch(text):
                if to_identifier(text) not in self.global_names:
                    return self._str(ESCAPE_RE.sub(r"\1", text))
        return self._expr(node)

    def _exit_values(self, items: list[ZNode]) -> list[str]:
        """部屋の出口 (例: `(NORTH TO HOUSE IF FLAG)`) の値を式に変換する。

        IF の直後の条件は、評価時の値ではなく名前 (文字列) にする。出口は
        条件を実行時に調べるので、後で変わる変数の値を固めてはいけない。

        Args:
            items: 方向名を除いた出口の要素 (TO か PER から始まる)。

        Returns:
            要素ごとの式。
        """
        values: list[str] = []
        previous = ""
        for item in items:
            if previous == "IF" and isinstance(item, ZSymbol):
                values.append(self._str(to_identifier(item.text)))
            else:
                values.append(self._prop_value(item))
            previous = item.text.upper() if isinstance(item, ZSymbol) else ""
        return values

