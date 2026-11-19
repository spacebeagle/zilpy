"""副作用のない式の判定 (refactor-plan.md §2.3「マクロの関数化」の呼び出しごとの判定)。

マクロを関数にすると、引数はいつも 1 回だけ、呼び出しの前に評価される。展開した式では
引数が 2 回評価されたり、条件によっては評価されなかったりするマクロ (① ②) では、
引数に副作用がないときだけ、関数を呼んでも動きが同じになる。

副作用のない式: 変数・定数・文字列と、読み出しだけの命令 (下の PURE_FORMS) でできた式。
ルーチンの呼び出し・RANDOM・代入を含む式は、副作用ありとみなす。
"""

from zilpy.front.nodes import ZExp, ZList, ZNode, ZString, ZSymbol, form_name, is_ignorable

PURE_FORMS: frozenset[str] = frozenset(
    {
        # 読み出し
        "GET", "GETB", "GETP", "GETPT", "PTSIZE", "LOC", "FIRST?", "NEXT?", "IN?", "FSET?",
        # 算術・ビット演算
        "+", "-", "*", "/", "MOD", "ADD", "SUB", "MUL", "DIV", "BAND", "BOR", "ANDB", "ORB", "BCOM",
        "MIN", "MAX", "ABS",
        # 比較
        "==?", "=?", "N==?", "N=?", "EQUAL?", "G?", "L?", "G=?", "L=?", "GRTR?", "LESS?",
        "ZERO?", "0?", "1?", "BTST",
        # 論理
        "AND", "OR", "NOT",
    }
)


def is_pure(node: ZNode) -> bool:
    """node が副作用のない式か。"""
    if isinstance(node, (ZSymbol, ZString)):
        return True
    if isinstance(node, ZExp):
        if is_ignorable(node):
            return True
        if node.kind == "QUOTE":
            return True
        if node.kind == "LOAD" and isinstance(node.item, ZSymbol) and node.item.text.startswith("\\"):
            return True  # 文字 !\X
        return False
    if node.kind == "paren":
        return False
    if not node.items:
        return True  # <> は偽
    name = form_name(node)
    if name not in PURE_FORMS:
        return False
    return all(is_pure(item) for item in node.items[1:] if not is_ignorable(item))
