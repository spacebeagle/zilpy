"""ZIL のコンパイルで共通して使う定数。"""

import re


INDENT_UNIT = "    "
STRING_PREVIEW_LEN = 80
TEMP_PREFIX = "_tmp"
# 整数のリテラル。符号の + も付けられる (例: Moonmist の <EQUAL? ,DRAGON-EYE-COLOR +1>)
INTEGER_RE = re.compile(r"[-+]?\d+")
# 8 進数のリテラル (例: *3777*)
OCTAL_RE = re.compile(r"\*([0-7]+)\*")
# ソース中に文字として書かれた改ページ記号
PAGE_BREAK = "^L"
# gglobals.zil には誤記の "/^L" も 1 箇所ある
PAGE_BREAKS: frozenset[str] = frozenset({PAGE_BREAK, "/" + PAGE_BREAK})
# アトム中のエスケープ (例: \. \,)
ESCAPE_RE = re.compile(r"\\(.)")
NON_IDENT_CHAR_RE = re.compile(r"[^0-9A-Za-z_]")
# 宣言の名前に付く型 (例: FAKE-CUBE-LIST:TABLE の :TABLE)
DECL_TYPE_SUFFIX_RE = re.compile(
    r":(?:NUMBER|FIX|FLAG|BOOLEAN|STRING|TABLE|OBJECT|ROUTINE|VERB|ATOM|ANY)$",
    re.IGNORECASE,
)
# ROUTINE の引数リストで区切りとして使われる文字列
OPTIONAL_MARKERS: frozenset[str] = frozenset({"OPTIONAL", "OPT"})
AUX_MARKERS: frozenset[str] = frozenset({"AUX", "EXTRA"})
REST_MARKERS: frozenset[str] = frozenset({"ARGS", "TUPLE"})

# ループ (活性化ブロック) を作るフォーム
LOOP_FORMS: frozenset[str] = frozenset(
    # DO と MAP-CONTENTS は後期の作品のループ (例: Spellbreaker)。REPEAT に書き換えて変換する
    {"REPEAT", "PROG", "BIND", "DO", "MAP-CONTENTS"}
)
# Python の式では表せず、文として生成する必要があるフォーム
STATEMENT_FORMS: frozenset[str] = LOOP_FORMS | {
    "COND",
    "RETURN",
    "RTRUE",
    "RFALSE",
    "RFATAL",
    "AGAIN",
    # コンパイル時のフラグで節を選ぶ (選んだ節の中身を文の並びとして変換する)
    "IFFLAG",
}
# COND の節で常に真となる条件
TRUE_TESTS: frozenset[str] = frozenset({"T", "ELSE"})
# コンパイラ自身を表すアトム。<GASSIGNED? ZILCH> はコンパイル時に真と決まる
# (変換器が変換時に決めるので、ランタイムはこの一覧を持たない)
COMPILER_ATOMS: frozenset[str] = frozenset({"ZILCH"})
# RTRUE などが関数から返す値
RETURN_CONSTANTS: dict[str, str] = {
    "RTRUE": "True",
    "RFALSE": "False",
    "RFATAL": "2",  # M-FATAL
}
COMPARE_OPS: dict[str, str] = {
    "EQUAL?": "==",
    "=?": "==",
    "==?": "==",
    "N=?": "!=",
    "N==?": "!=",
    "G?": ">",
    "GRTR?": ">",
    "L?": "<",
    "LESS?": "<",
    "G=?": ">=",
    "L=?": "<=",
}
ARITH_OPS: dict[str, str] = {
    "+": "+",
    "ADD": "+",
    "-": "-",
    "SUB": "-",
    "*": "*",
    "MUL": "*",
    "/": "//",
    "DIV": "//",
    "MOD": "%",
    "BAND": "&",
    "ANDB": "&",
    "BOR": "|",
    "ORB": "|",
}
ZERO_TESTS: dict[str, str] = {"0?": "0", "ZERO?": "0", "1?": "1"}
# 変数を増減してから比較するフォーム: (増減の演算子, 比較演算子)
INC_TESTS: dict[str, tuple[str, str]] = {"IGRTR?": ("+", ">"), "DLESS?": ("-", "<")}
# 引数のアトムを変数ではなくデータ (文字列) として扱う宣言フォーム
DECLARATION_FORMS: frozenset[str] = frozenset(
    {
        "VERSION",
        "VERB?",
        "SYNTAX",
        "SYNONYM",
        "VERB-SYNONYM",
        "PREP-SYNONYM",
        "ADJ-SYNONYM",
        "DIR-SYNONYM",
        # Spellbreaker の THINGS プロパティを作る (ランタイムの PSEUDO)
        "PSEUDO",
        "VOC",
        "BUZZ",
        "DIRECTIONS",
        "PROPDEF",
        "GDECL",
        "GASSIGNED?",
    }
)
# 丸括弧の引数をフラグ (例: (PURE)) として扱うテーブル宣言
TABLE_FORMS: frozenset[str] = frozenset(
    {"TABLE", "LTABLE", "ITABLE", "PTABLE", "PLTABLE"}
)
# 値がアトムの並びであるオブジェクトのプロパティ
ATOM_PROPERTIES: frozenset[str] = frozenset({"FLAGS", "SYNONYM", "ADJECTIVE"})
# 生成コードが取り込むランタイムモジュール
RUNTIME_MODULE = "ZilRuntime"
# 全モジュールで共有するグローバル名前空間 (ランタイムの ZilGlobals インスタンス)
GLOBALS_NAME = "ZG"
# GLOBAL / CONSTANT などの宣言を集めて出力するモジュール
GLOBAL_MODULE = "ZilGlobal"
# コンパイラが定義する記号定数の接頭辞
# P?NAME: プロパティ名 -> 'NAME'、W?NAME: 単語 -> 'name' (小文字)
PROPERTY_PREFIX = "P?"
WORD_PREFIX = "W?"
# ソースには定義がなく、コンパイラが生成するグローバル (ランタイムが提供する)
COMPILER_GLOBALS: frozenset[str] = frozenset(
    {"VERBS", "ACTIONS", "PREACTIONS", "PREPOSITIONS"}
)
PART_PREFIXES: tuple[str, ...] = ("PS?", "P1?")
# 辞書や構文の宣言から実行時に番号が決まる記号定数 (ランタイムの SYMBOL で求める)
# V?: 動詞のアクション、ACT?: 動詞の単語の番号、PR?: 前置詞、A?: 形容詞
SYMBOLIC_PREFIXES: tuple[str, ...] = ("V?", "ACT?", "PR?", "A?")
SYMBOL_FUNCTION = "SYMBOL"
# W?NAME はランタイムの WORD('name') (辞書の Word オブジェクト) にする。
# 素の文字列だと <GETB ,W?INTNUM 4> のような品詞の参照ができない
WORD_FUNCTION = "WORD"
# 条件分岐の中に現れても、式ではなく定義として変換するフォーム
# 効果音を鳴らす作品のルーチン。ZilPy は効果音を出さないので、本体を何もしない (真を返す)
# 関数にする (Lurking Horror の SOUNDS は、最初の効果音のときに "[Use $SOUND ...]" と表示し、
# 効果音の状態を SOUND-FLAG に書く。どちらも効果音がなければ要らない)
SILENT_ROUTINES: frozenset[str] = frozenset({"SOUNDS"})
NESTED_DECLARATION_FORMS: frozenset[str] = frozenset(
    {
        "ROUTINE",
        "DEFINE",
        "GLOBAL",
        "CONSTANT",
        "OBJECT",
        "ROOM",
        "DEFMAC",
        "INSERT-FILE",
    }
)
# 名前が全モジュールで共有される (グローバルになる) 定義フォーム
GLOBAL_DEFINING_FORMS: frozenset[str] = frozenset(
    {"ROUTINE", "DEFINE", "GLOBAL", "CONSTANT", "OBJECT", "ROOM"}
)
# ビルド用の指示。変換後のコードには不要なので取り除く
BUILD_ONLY_FORMS: frozenset[str] = frozenset({"ENDLOAD", "GC", "GC-MON"})
# ZILCH / ZILF のトップレベルの指示のうち、生成コードでは何もしないもの
# (refactor-ZILFReferenceGuide-plan.md §1.2)。オブジェクトやフラグの番号の割り当て順、
# 辞書の作り方、ファイル単位のコンパイラの設定、インタプリタに求める機能の宣言など。
# 変換時にはコメント (Lua は何も出さない) にする
NOOP_DIRECTIVES: frozenset[str] = frozenset(
    {
        "ORDER-OBJECTS?",
        "ORDER-TREE?",
        "ORDER-FLAGS?",
        "LONG-WORDS?",
        "NEW-ADD-VOC?",
        "FILE-FLAGS",
        "ZIP-OPTIONS",
        "TIME-GAME",
        "SCORE-GAME",
        "DELAY-DEFINITION",
        # コンパイル時のフラグの定義。値は走査のときに static_values へ登録する (project.py)
        "COMPILATION-FLAG",
        "COMPILATION-FLAG-DEFAULT",
        # 文字列の圧縮の切り替えと、TELL の書式指定子の宣言 (ProjectBuilder が読む)
        "ZSTR-ON",
        "ZSTR-OFF",
        "TELL-TOKENS",
    }
)
# 作品の開始ルーチン。ZilMcp.py / ZilMcp.lua はこの名前を決め打ちしている
ENTRY_ROUTINE = "GO"
# TELL マクロが使う組み込みの出力命令と、ランタイムの TELL の書式指定子
BUILTIN_TELL_PRINTERS: dict[str, str] = {
    "PRINTD": "D",
    "PRINTA": "A",
    "PRINTN": "N",
    "PRINTC": "C",
    "CRLF": "CR",
}
# ランタイム (ZilRuntime.py) が書式指定子として定義している名前
RUNTIME_TELL_TOKENS: frozenset[str] = frozenset(
    {"CR", "CRLF", "D", "DESC", "OBJ", "O", "A", "AN", "N", "NUM", "C", "CHR", "CHAR"}
)
