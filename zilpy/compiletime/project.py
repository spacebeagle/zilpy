"""変換の前に全ファイルを走査して集める情報 (共有名・オブジェクト名・フラグ名・
コンパイル時の値・TELL の書式指定子)。

refactor-plan.md Phase 1-4 で ZilNodes.py から分けた。
"""

from collections.abc import Iterable

from zilpy.constants import (
    GLOBAL_DEFINING_FORMS,
    INTEGER_RE,
)
from zilpy.compiletime.static_eval import zilch_branch
from zilpy.front.nodes import (
    ZExp,
    ZList,
    ZNode,
    ZString,
    ZSymbol,
    form_name,
    is_false_constant,
    is_ignorable,
    to_identifier,
)


def collect_global_names(nodes: Iterable[ZNode]) -> set[str]:
    """AST から、全モジュールで共有される名前 (グローバル) を集める。
    ROUTINE・GLOBAL・CONSTANT・OBJECT などの定義名と、SETG の代入先が対象。

    Args:
        nodes: 走査するノードの並び。

    Returns:
        Python の識別子に変換した名前の集合。
    """
    names: set[str] = set()

    def walk(node: ZNode) -> None:
        if isinstance(node, ZExp):
            if node.item is not None:
                walk(node.item)
            return
        if not isinstance(node, ZList):
            return
        branch = zilch_branch(node)
        if branch is not None:
            for item in branch:  # コンパイラ (ZILCH) が選ぶ節だけを読む
                walk(item)
            return
        if form_name(node) in GLOBAL_DEFINING_FORMS | {"SETG"}:
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            while args and isinstance(args[0], ZExp) and args[0].item is not None:
                args[0] = args[0].item
            if args and isinstance(args[0], ZSymbol):
                names.add(to_identifier(args[0].text))
        for item in node.items:
            walk(item)

    for node in nodes:
        walk(node)
    return names


def collect_object_names(nodes: Iterable[ZNode]) -> set[str]:
    """AST から、OBJECT・ROOM の定義名を集める。

    物体は呼び出せないので、物体と同じ名前のフォームは組み込み命令の呼び出しになる
    (例: Trinity の UPDATE-SCORE の <SOUND 1> は効果音命令で、物体 SOUND ではない)。

    Args:
        nodes: 走査するノードの並び。

    Returns:
        Python の識別子に変換した名前の集合。
    """
    names: set[str] = set()

    def walk(node: ZNode) -> None:
        if isinstance(node, ZExp):
            if node.item is not None:
                walk(node.item)
            return
        if not isinstance(node, ZList):
            return
        branch = zilch_branch(node)
        if branch is not None:
            for item in branch:
                walk(item)
            return
        if form_name(node) in ("OBJECT", "ROOM"):
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            if args and isinstance(args[0], ZSymbol):
                names.add(to_identifier(args[0].text))
            return
        for item in node.items:
            walk(item)

    for node in nodes:
        walk(node)
    return names


def collect_flag_names(nodes: Iterable[ZNode]) -> set[str]:
    """AST から、オブジェクトの FLAGS と SYNTAX の (FIND ...) に書かれたフラグ名を集める。
    フラグ (例: OPENBIT) はコンパイラが定義する定数で、変数ではない。
    生成コードでは名前そのものを文字列として扱うため、事前に集めておく。
    どのオブジェクトにも付かず、SYNTAX の FIND にだけ現れるフラグもある
    (例: Deadline の RMUNGBIT)。

    Args:
        nodes: 走査するノードの並び。

    Returns:
        フラグ名 (大文字) の集合。
    """
    names: set[str] = set()

    def walk(node: ZNode) -> None:
        if isinstance(node, ZExp):
            if node.item is not None:
                walk(node.item)
            return
        if not isinstance(node, ZList):
            return
        if node.kind == "paren" and node.items:
            head = node.items[0]
            if isinstance(head, ZSymbol) and head.text.upper() == "FLAGS":
                names.update(
                    item.text for item in node.items[1:] if isinstance(item, ZSymbol)
                )
            elif (
                isinstance(head, ZSymbol)
                and head.text.upper() == "FIND"
                and len(node.items) == 2
                and isinstance(node.items[1], ZSymbol)
            ):
                names.add(node.items[1].text)
        for item in node.items:
            walk(item)

    for node in nodes:
        walk(node)
    return names


def collect_tell_indicators(nodes: Iterable[ZNode]) -> dict[str, tuple[str, bool]]:
    """後期の作品の `<TELL-TOKENS ...>` の宣言から、書式指定子とルーチンの対応を読み取る。

    例: `<TELL-TOKENS (CRLF CR) <CRLF> D * <DPRINT .X> ...>` (Spellbreaker では D が DPRINT、
    THE が THE-PRINT)。`DEFMAC TELL` で指定子を定める作品の対応は、評価器でマクロを
    展開して作る (compiletime/tell.py。refactor-plan.md Phase 3-4 でパターン読みから置き換えた)。

    Args:
        nodes: トップレベルのノード。

    Returns:
        指定子 (大文字) と、(ルーチン名 (大文字), 直後の引数を取るか) の対応。
    """
    indicators: dict[str, tuple[str, bool]] = {}
    def read_tell_tokens(node: ZList) -> None:
        # <TELL-TOKENS 名前 [引数の型...] <ルーチン ...> ...> の並び。名前は 1 つのアトムか、
        # (CRLF CR) のような別名の並び。引数の型の * は「直後の引数を 1 つ取る」。
        # `D ,PRSO <DPRINT-PRSO>` のように特定の引数に限った指定は、* の指定
        # (`D * <DPRINT .X>`) の特殊化なので読み飛ばす。
        names: list[str] = []
        args: list[ZNode] = []
        for item in node.items[1:]:
            if is_ignorable(item):
                continue
            routine = form_name(item)
            if not names:
                names = token_names(item)  # 名前 (フォームになることはない)
            elif routine is None:
                args.append(item)  # 引数の型 (* や ,PRSO)
            else:
                if all(isinstance(arg, ZSymbol) and arg.text == "*" for arg in args):
                    for name in names:
                        indicators.setdefault(name, (routine, bool(args)))
                names, args = [], []

    def token_names(item: ZNode) -> list[str]:
        if isinstance(item, ZSymbol):
            return [item.text.upper()]
        if isinstance(item, ZList) and item.kind == "paren":
            return [part.text.upper() for part in item.items if isinstance(part, ZSymbol)]
        return []

    for node in nodes:
        if isinstance(node, ZList) and form_name(node) == "TELL-TOKENS":
            read_tell_tokens(node)
    return indicators


def collect_static_values(nodes: Iterable[ZNode]) -> dict[str, int]:
    """トップレベルの `<SETG NAME 整数>` から、コンパイル時に決まる値を集める。
    `<SETG ZORK-NUMBER 1>` のような値は、`%<COND (<==? ,ZORK-NUMBER 1> ...)>` の
    ようにコンパイル時の条件分岐で使われるため、変換時に評価できるようにする。

    Args:
        nodes: トップレベルのノードの並び。

    真偽値の `<SETG NAME T>` / `<SETG NAME <>>` は 1 / 0 として集める。
    ZilPy はコンパイラ (ZILCH) の役をするので、トップレベルの
    `<COND (<GASSIGNED? ZILCH> ...) (ELSE ...)>` の中は ZILCH 側の節だけを読む
    (例: Spellbreaker の `<SETG ZDEBUGGING? <>>` は、デバッグ用のコードを外す)。

    Returns:
        Python の識別子に変換した名前から整数値への辞書。
    """
    values: dict[str, int] = {}

    def static_int(node: ZNode) -> int | None:
        if isinstance(node, ZSymbol):
            if INTEGER_RE.fullmatch(node.text):
                return int(node.text)
            if node.text.upper() == "T":
                return 1
            return None
        return 0 if is_false_constant(node) else None

    def visit(items: Iterable[ZNode]) -> None:
        for node in items:
            if not isinstance(node, ZList):
                continue
            branch = zilch_branch(node)
            if branch is not None:
                visit(branch)  # コンパイラ (ZILCH) が選ぶ節だけを読む
                continue
            name = form_name(node)
            if name == "COMPILATION-FLAG":
                flag = compilation_flag(node)
                if flag is not None:
                    values[flag[0]] = flag[1]
                continue
            if name != "SETG":
                continue
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            if len(args) == 2 and isinstance(args[0], ZSymbol):
                value = static_int(args[1])
                if value is not None:
                    values[to_identifier(args[0].text)] = value

    visit(nodes)
    return values


def compilation_flag(node: ZList) -> tuple[str, int] | None:
    """`<COMPILATION-FLAG NAME [VALUE]>` (または `-DEFAULT`) から (識別子, 値) を返す。

    NAME はアトムか文字列。VALUE を省くと真 (1)。`<>` は偽 (0)、T は真、整数はその値。
    値が変換時に決まらなければ None。
    """
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if not args or not isinstance(args[0], (ZSymbol, ZString)):
        return None
    if len(args) == 1:
        return to_identifier(args[0].text), 1
    value = args[1]
    if isinstance(value, ZSymbol):
        if INTEGER_RE.fullmatch(value.text):
            return to_identifier(args[0].text), int(value.text)
        if value.text.upper() == "T":
            return to_identifier(args[0].text), 1
        return None
    if is_false_constant(value):
        return to_identifier(args[0].text), 0
    return None


def collect_flag_defaults(nodes: Iterable[ZNode]) -> dict[str, int]:
    """トップレベルの `<COMPILATION-FLAG-DEFAULT NAME VALUE>` の既定値を集める。

    既定値は、どのファイルでも `<COMPILATION-FLAG NAME ...>` が定義していないときだけ使う。
    ファイルの読み込み順に関係なくそうなるよう、ProjectBuilder は全ファイルを走査し終えてから
    static_values に足す (setdefault)。
    """
    defaults: dict[str, int] = {}

    def visit(items: Iterable[ZNode]) -> None:
        for node in items:
            if not isinstance(node, ZList):
                continue
            branch = zilch_branch(node)
            if branch is not None:
                visit(branch)
                continue
            if form_name(node) == "COMPILATION-FLAG-DEFAULT":
                flag = compilation_flag(node)
                if flag is not None:
                    defaults.setdefault(flag[0], flag[1])

    visit(nodes)
    return defaults


def collect_replaced_definitions(nodes: Iterable[ZNode]) -> set[str]:
    """`<REPLACE-DEFINITION NAME ...>` で置き換えられる名前 (大文字) を集める。

    同じ名前の `<DEFAULT-DEFINITION NAME ...>` は変換しない (作品が置き換えたため)。
    """
    names: set[str] = set()
    for node in nodes:
        if isinstance(node, ZList) and form_name(node) == "REPLACE-DEFINITION":
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            if args and isinstance(args[0], ZSymbol):
                names.add(args[0].text.upper())
    return names


def collect_zstart(nodes: Iterable[ZNode]) -> str | None:
    """`<ZSTART NAME>` で指定された開始ルーチンの識別子名を返す (なければ None)。"""
    result: str | None = None
    for node in nodes:
        if isinstance(node, ZList) and form_name(node) == "ZSTART":
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            if len(args) == 1 and isinstance(args[0], ZSymbol):
                result = to_identifier(args[0].text)
    return result
