"""ZIL の AST ノードと、ノードに対するヘルパー関数 (識別子への変換を含む)。

refactor-plan.md Phase 1-4 で ZilNodes.py から分けた。
"""

import keyword
from dataclasses import dataclass
from typing import TypeAlias

from zilpy.constants import (
    DECL_TYPE_SUFFIX_RE,
    INTEGER_RE,
    LOOP_FORMS,
    NON_IDENT_CHAR_RE,
    PAGE_BREAKS,
    STATEMENT_FORMS,
)


@dataclass(frozen=True)
class Span:
    """ソースコード上の位置情報。

    Attributes:
        start: 開始インデックス。
        end: 終了インデックス (この位置を含まない)。
        line: 開始行番号 (1 始まり)。
        col: 開始桁番号 (1 始まり)。
    """

    start: int
    end: int
    line: int
    col: int


@dataclass(frozen=True)
class Token:
    """字句解析で得られるトークン。

    Attributes:
        type: トークン種別 ('LT', 'GT', 'LP', 'RP', 'STRING', 'SYMBOL',
            'EXP', 'EOF')。
        value: トークンの文字列値。
        span: ソース上の位置。
    """

    type: str
    value: str
    span: Span


@dataclass
class ZSymbol:
    """ZIL のシンボル (アトム・数値など)。

    Attributes:
        text: シンボルの文字列。
        span: ソース上の位置。
    """

    text: str
    span: Span


@dataclass
class ZString:
    """ZIL の文字列リテラル。

    Attributes:
        text: エスケープ解除済みの文字列。
        span: ソース上の位置。
    """

    text: str
    span: Span


@dataclass
class ZList:
    """ZIL のリスト (`<...>` または `(...)`)。

    Attributes:
        kind: 'angle' (山括弧) または 'paren' (丸括弧)。
        items: 要素ノードのリスト。
        span: ソース上の位置。
    """

    kind: str
    items: list["ZNode"]
    span: Span


@dataclass
class ZExp:
    """修飾子付きの式 (`;`, `%`, `'`, `!`, `#TYPE` など)。

    Attributes:
        kind: 修飾子の種別 ('SEMI', 'EVAL', 'QUOTE', 'LOAD'
            または '#DECL' などの型指定)。
        item: 修飾対象のノード。ファイル末尾の場合は None。
        span: ソース上の位置。
    """

    kind: str
    item: "ZNode | None"
    span: Span


ZNode: TypeAlias = ZSymbol | ZString | ZList | ZExp


def is_comment(node: ZNode) -> bool:
    """ノードが `;` によるコメントかどうかを判定する。

    Args:
        node: 判定対象のノード。

    Returns:
        コメントであれば True。
    """
    return isinstance(node, ZExp) and node.kind == "SEMI"


def is_ignorable(node: ZNode) -> bool:
    """コード生成で無視するノード (コメント・#DECL・改ページ記号 ^L) かどうかを判定する。

    Args:
        node: 判定対象のノード。

    Returns:
        無視すべきノードであれば True。
    """
    if isinstance(node, ZSymbol):
        return node.text in PAGE_BREAKS
    return isinstance(node, ZExp) and node.kind in ("SEMI", "#DECL")


def form_name(node: ZNode) -> str | None:
    """フォーム `<NAME ...>` の名前を大文字で返す。

    Args:
        node: 対象のノード。

    Returns:
        先頭がシンボルの山括弧リストであればその名前、それ以外は None。
    """
    if (
        isinstance(node, ZList)
        and node.kind == "angle"
        and node.items
        and isinstance(node.items[0], ZSymbol)
    ):
        return node.items[0].text.upper()
    return None


def is_false_constant(node: ZNode) -> bool:
    """ノードが偽の定数 (`0` または `<>`) かを判定する。

    Args:
        node: 判定対象のノード。

    Returns:
        `0` または `<>` であれば True。
    """
    if isinstance(node, ZSymbol):
        return node.text == "0"
    return isinstance(node, ZList) and node.kind == "angle" and not node.items


def needs_statement(node: ZNode) -> bool:
    """ノードを Python の式で表せず、文として生成する必要があるかを判定する。

    Args:
        node: 判定対象のノード。

    Returns:
        文として生成する必要があれば True。
    """
    if isinstance(node, ZExp):
        return (
            node.item is not None
            and not is_ignorable(node)
            and node.kind != "QUOTE"
            and needs_statement(node.item)
        )
    name = form_name(node)
    if name in STATEMENT_FORMS:
        return True
    if name in ("AND", "OR") and isinstance(node, ZList):
        # 短絡評価を保つため、オペランドが文なら AND/OR 全体を文にする
        return any(needs_statement(item) for item in node.items[1:])
    return False


def contains_bare_again(node: ZNode) -> bool:
    """ループの外側にある AGAIN (ルーチンの再実行) を含むか判定する。

    Args:
        node: 判定対象のノード。

    Returns:
        REPEAT/PROG/BIND の外側に AGAIN があれば True。
    """
    name = form_name(node)
    if name == "AGAIN":
        return True
    if name in LOOP_FORMS:
        return False
    if isinstance(node, ZList):
        return any(contains_bare_again(item) for item in node.items)
    if isinstance(node, ZExp) and node.item is not None:
        return not is_ignorable(node) and contains_bare_again(node.item)
    return False


def to_identifier(name: str) -> str:
    """ZIL のシンボル名を Python で有効な識別子へ変換する。
    先頭の `.` / `,` (変数参照) を取り除き、末尾の `?` を `_p` に、
    識別子に使えない文字を `_` に置き換える。整数リテラルはそのまま返す。

    Args:
        name: ZIL のシンボル名。

    Returns:
        Python の識別子、または整数リテラル。
    """
    if name.startswith((".", ",")):
        name = name[1:]
    # 後期の ZIL は宣言の名前に型を付けられる (例: Spellbreaker の
    # <GLOBAL FAKE-CUBE-LIST:TABLE ...>、<GLOBAL TIME-CUBE-SCORE?:FLAG <>>)。
    # 参照する側 (,FAKE-CUBE-LIST) には型が付かないので、型を外して名前を揃える
    name = DECL_TYPE_SUFFIX_RE.sub("", name)
    if INTEGER_RE.fullmatch(name):
        return str(int(name))  # 先頭の 0 は Python では構文エラーになる
    if name.endswith("?"):
        name = name[:-1] + "_p"
    ident = NON_IDENT_CHAR_RE.sub("_", name)
    if not ident or ident[0].isdigit():
        ident = "_" + ident
    if keyword.iskeyword(ident):
        ident += "_"
    return ident


def local_name(name: str, runtime_names: frozenset[str]) -> str:
    """ZIL のローカル変数名を、生成コードのローカル変数名へ変換する。

    ランタイムの関数や定数と同じ名前になる場合は、末尾に `_l` を付けて区別する。
    ローカル変数がランタイムの名前と衝突すると、同名の関数を呼べなくなるため
    (ZIL では変数 .LOC と関数 <LOC> は別の名前空間にある)。

    Args:
        name: ZIL のシンボル名 (`.` 付きでもよい)。
        runtime_names: 出力する言語のランタイムの公開名
            (zilpy/backend/runtime_names_*.py の RUNTIME_NAMES)。

    Returns:
        識別子。
    """
    ident = to_identifier(name)
    return ident + "_l" if ident in runtime_names else ident


_EXP_PREFIX = {"QUOTE": "'", "EVAL": "%", "LOAD": "!", "GVAL": ",", "SEMI": ";"}


def zil_text(node: ZNode) -> str:
    """AST を ZIL の形の 1 行の文字列に戻す (注記・警告・テストの比較に使う)。

    コメントと #DECL は出力しない。文字列の中の `"` と `\\` はエスケープする。
    """
    if isinstance(node, ZSymbol):
        return node.text
    if isinstance(node, ZString):
        escaped = node.text.replace("\\", "\\\\").replace('"', '\\"')
        return f'"{escaped}"'
    if isinstance(node, ZExp):
        prefix = _EXP_PREFIX.get(node.kind, node.kind + " ")
        return prefix + (zil_text(node.item) if node.item is not None else "")
    inner = " ".join(zil_text(item) for item in node.items if not is_ignorable(item))
    return f"<{inner}>" if node.kind == "angle" else f"({inner})"
