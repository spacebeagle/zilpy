"""読み込み時に展開するマクロ (ロード用の別名・ガード付きのフォーム)。

refactor-plan.md Phase 1-4 で ZilNodes.py から分けた。
"""

from zilpy.constants import (
    BUILD_ONLY_FORMS,
)
from zilpy.front.nodes import ZList, ZNode, ZSymbol, form_name, is_ignorable


def _alias_target(node: ZNode, aliases: set[str]) -> str | None:
    """`<DEFINE NAME (args) <ALIAS ...>>` なら NAME を返す。
    本体が INSERT-FILE (または、そのラッパーとして定義済みのマクロ) の呼び出し
    だけの DEFINE は、ファイルを取り込むためのコンパイル時マクロである。

    Args:
        node: 調べるノード。
        aliases: INSERT-FILE として扱うマクロ名の集合。

    Returns:
        マクロ名。該当しなければ None。
    """
    if form_name(node) != "DEFINE" or not isinstance(node, ZList):
        return None
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(args) != 3 or not isinstance(args[0], ZSymbol):
        return None
    return args[0].text if form_name(args[2]) in aliases else None


def _guarded_form(node: ZNode) -> ZNode | None:
    """`<OR <GASSIGNED? X> FORM>` なら FORM を返す (未定義の時だけ実行する宣言)。

    Args:
        node: 調べるノード。

    Returns:
        FORM のノード。該当しなければ None。
    """
    if form_name(node) != "OR" or not isinstance(node, ZList):
        return None
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(args) == 2 and form_name(args[0]) in ("GASSIGNED?", "GASSIGNED"):
        return args[1]
    return None


def expand_load_macros(nodes: list[ZNode]) -> list[ZNode]:
    """ファイルの取り込みと、コンパイル時だけの指示を展開する。
    ゲームのコンパイル用ファイルは、`<DEFINE IFILE (STR) <INSERT-FILE .STR T>>`
    のようなマクロで INSERT-FILE を包み、`<IFILE "PARSER" T>` と書くことがある。
    これらの呼び出しを INSERT-FILE に置き換え、マクロの定義と、
    `<OR <GASSIGNED? X> ...>` の形のコンパイル時の分岐、ビルド用の指示
    (ENDLOAD、GC、GC-MON) を取り除く。

    Args:
        nodes: トップレベルのノードの並び。

    Returns:
        展開後のノードの並び。
    """
    aliases = {"INSERT-FILE"}
    changed = True
    while changed:
        changed = False
        for node in nodes:
            name = _alias_target(_guarded_form(node) or node, aliases)
            if name is not None and name not in aliases:
                aliases.add(name)
                changed = True
    result: list[ZNode] = []
    for node in nodes:
        name = form_name(node)
        if _guarded_form(node) is not None or _alias_target(node, aliases):
            continue
        if name in BUILD_ONLY_FORMS:
            continue
        if name in aliases and name != "INSERT-FILE" and isinstance(node, ZList):
            head = node.items[0]
            if isinstance(head, ZSymbol):
                node = ZList(
                    node.kind,
                    [ZSymbol("INSERT-FILE", head.span), *node.items[1:]],
                    node.span,
                )
        result.append(node)
    return result
