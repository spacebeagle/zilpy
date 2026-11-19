"""AST から AST への変形と、ルーチンの解析 (言語に依存しない部分)。

Python 版と Lua 版の変換器が共有する (refactor-plan.md Phase 2-2)。

- `expand_inc_dec`: `<INC X>` / `<DEC X>` → `<SET X <+ .X 1>>` など
- `lower_loop`: `DO` / `MAP-CONTENTS` / `MAP-DIRECTIONS` → `REPEAT`
- `referenced_locals`: ルーチン本体で参照されるローカル変数 (`.X`)
- `macro_helper_names`: DEFMAC の本体から呼ばれる名前 (変換しない補助の DEFINE)
- `parse_params`: ルーチンの引数リストの解釈
"""

from collections.abc import Iterable
from dataclasses import dataclass

from zilpy.constants import AUX_MARKERS, OPTIONAL_MARKERS, REST_MARKERS
from zilpy.compiletime.static_eval import StaticEvaluator
from zilpy.front.nodes import (
    ZExp,
    ZList,
    ZNode,
    ZString,
    ZSymbol,
    form_name,
    is_ignorable,
    to_identifier,
)

# lower_loop が REPEAT に書き換えるフォーム
LOWERED_LOOP_FORMS: frozenset[str] = frozenset({"DO", "MAP-CONTENTS", "MAP-DIRECTIONS"})


def expand_inc_dec(node: ZNode, global_names: frozenset[str] | set[str]) -> ZNode:
    """<INC X> / <DEC X> を <SET X <+ .X 1>> / <SET X <- .X 1>> に書き換える。

    `,X` ならグローバル (SETG)、`.X` ならローカル (SET)。接頭辞がなければ、
    X がグローバル宣言された名前なら SETG と ,X を、そうでなければ SET と .X を使う。
    <INC X 5> のように増減量が指定された場合はその値を使う。

    Args:
        node: 対象のノード。
        global_names: 全モジュールで共有される名前 (識別子)。

    Returns:
        書き換えたフォーム。INC / DEC の呼び出しでなければ node そのもの。
    """
    name = form_name(node)
    if name not in ("INC", "DEC") or not isinstance(node, ZList):
        return node
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if not args or len(args) > 2 or not isinstance(args[0], ZSymbol):
        return node
    raw = args[0].text
    if raw.startswith((",", ".")):
        var = raw[1:]
        is_global = raw.startswith(",")
    else:
        var = raw
        is_global = to_identifier(var) in global_names
    span = node.span
    setter = "SETG" if is_global else "SET"
    ref = ZSymbol(("," if is_global else ".") + var, span)
    step = args[1] if len(args) == 2 else ZSymbol("1", span)
    op = "+" if name == "INC" else "-"
    value = ZList("angle", [ZSymbol(op, span), ref, step], span)
    return ZList("angle", [ZSymbol(setter, span), ZSymbol(var, span), value], span)


def lower_loop(node: ZList, static: StaticEvaluator) -> ZList | None:
    """後期の ZIL のループ DO / MAP-CONTENTS / MAP-DIRECTIONS を REPEAT に書き換える。

    - `<DO (I START END [STEP]) [(END ...)] BODY...>` は I を START から END まで
      STEP ずつ変える。STEP を省くと、START と END が整数で END < START なら -1、
      それ以外は 1。
    - `<MAP-CONTENTS (X [NEXT] OBJ) [(END ...)] BODY...>` は OBJ の中身を順にたどる。
      NEXT があれば、本体の前に次の物を NEXT に取っておく (本体が X を動かしてよい)。
    - `<MAP-DIRECTIONS (DIR PT ROOM) [(END ...)] BODY...>` は ROOM の出口を順にたどる。

    (END ...) の中身は、ループが最後まで回り終えたときに実行する。
    END を省いて `(<...> ...)` と書いた終了節も同じに扱う (例: Spellbreaker の
    MEASURE・TELL-WALLS)。どれも
    `<REPEAT ((I START)) <COND (終わり? END... <RETURN>)> BODY... <SET I 次>>` の形にする。

    Args:
        node: DO・MAP-CONTENTS・MAP-DIRECTIONS のフォーム。
        static: STEP の符号を決めるのに使う。

    Returns:
        REPEAT のフォーム。形が合わなければ None (呼び出し側は関数呼び出しとして変換する)。
    """
    span = node.span
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    spec = args[0] if args else None
    if not (isinstance(spec, ZList) and spec.kind == "paren"):
        return None
    parts = [item for item in spec.items if not is_ignorable(item)]
    body = args[1:]
    end_body: list[ZNode] = []
    if body and isinstance(body[0], ZList) and body[0].kind == "paren":
        items = [item for item in body[0].items if not is_ignorable(item)]
        head = items[0] if items else None
        if isinstance(head, ZSymbol) and head.text.upper() == "END":
            end_body = items[1:]
            body = body[1:]
        elif isinstance(head, ZList) and head.kind == "angle":
            # 丸括弧のリストは本体の文にはならないので、先頭がフォームなら終了節
            end_body = items
            body = body[1:]

    def sym(text: str) -> ZSymbol:
        return ZSymbol(text, span)

    def form(*items: ZNode) -> ZList:
        return ZList("angle", list(items), span)

    def paren(*items: ZNode) -> ZList:
        return ZList("paren", list(items), span)

    if not parts or not isinstance(parts[0], ZSymbol):
        return None
    var = parts[0].text
    local = sym("." + var)
    bindings: list[ZNode] = []
    before: list[ZNode] = []
    kind = form_name(node)
    if kind == "DO":
        if len(parts) < 3:
            return None
        start, end = parts[1], parts[2]
        if len(parts) > 3:
            step = parts[3]
        else:
            values = [static.value(start), static.value(end)]
            down = values[0] is not None and values[1] is not None and values[1] < values[0]
            step = sym("-1" if down else "1")
        step_value = static.value(step)
        beyond = "L?" if step_value is not None and step_value < 0 else "G?"
        bindings.append(paren(sym(var), start))
        done = form(sym(beyond), local, end)
        advance = form(sym("SET"), sym(var), form(sym("+"), local, step))
    elif kind == "MAP-DIRECTIONS":
        if len(parts) != 3 or not isinstance(parts[1], ZSymbol):
            return None
        pt_var = parts[1].text
        room = parts[2]
        bindings.append(paren(sym(var), form(sym("NEXTP"), room, sym("0"))))
        bindings.append(paren(sym(pt_var), sym("0")))
        done = form(
            sym("OR"),
            form(sym("NOT"), local),
            form(sym("L?"), local, sym(",LOW-DIRECTION")),
        )
        before.append(form(sym("SET"), sym(pt_var), form(sym("GETPT"), room, local)))
        advance = form(sym("SET"), sym(var), form(sym("NEXTP"), room, local))
    elif kind == "MAP-CONTENTS":
        if len(parts) not in (2, 3):
            return None
        container = parts[-1]
        bindings.append(paren(sym(var), form(sym("FIRST?"), container)))
        done = form(sym("NOT"), local)
        if len(parts) == 3 and isinstance(parts[1], ZSymbol):
            following = parts[1].text
            bindings.append(paren(sym(following), sym("0")))
            before.append(form(sym("SET"), sym(following), form(sym("NEXT?"), local)))
            advance = form(sym("SET"), sym(var), sym("." + following))
        else:
            advance = form(sym("SET"), sym(var), form(sym("NEXT?"), local))
    else:
        return None
    finish = form(sym("COND"), paren(done, *end_body, form(sym("RETURN"))))
    return form(sym("REPEAT"), paren(*bindings), finish, *before, *body, advance)


def push_rstack_value(node: ZNode) -> ZNode | None:
    """`<PROG () <PUSH X> <RSTACK>>` なら X を返す。

    X をスタックに積んで、スタックの値でルーチンから戻る (RFATAL の定義。M-FATAL が X)。
    ループの中にあっても、ループではなくルーチンから戻る。
    例: Stationfall の `<DEFMAC RFATAL () '<PROG () <PUSH 8> <RSTACK>>>` (M-FATAL は 8)。

    Returns:
        積む値のノード。その形でなければ None。
    """
    if form_name(node) != "PROG" or not isinstance(node, ZList):
        return None
    items = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(items) != 3 or not (isinstance(items[0], ZList) and items[0].kind == "paren" and not items[0].items):
        return None
    push, rstack = items[1], items[2]
    if form_name(push) != "PUSH" or form_name(rstack) != "RSTACK" or not isinstance(push, ZList):
        return None
    pushed = [item for item in push.items[1:] if not is_ignorable(item)]
    rest = [item for item in rstack.items[1:] if not is_ignorable(item)] if isinstance(rstack, ZList) else []
    if len(pushed) != 1 or rest:
        return None
    return pushed[0]


def lower_true_test(node: ZList) -> ZNode | None:
    """ZILCH の組み込みの `<T? X>` (X が 0 でなければ真) を `<NOT <ZERO? X>>` にする。

    作品が DEFMAC T? を定義していれば、その定義を使う (呼び出し側が確かめる)。
    Moonmist・Trinity の定義 `<DEFMAC T? ('TERM) <FORM NOT <FORM ZERO? .TERM>>>` と同じ意味。

    Returns:
        書き換えた式。引数が 1 つでなければ None。
    """
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(args) != 1:
        return None
    span = node.span
    zero = ZList("angle", [ZSymbol("ZERO?", span), args[0]], span)
    return ZList("angle", [ZSymbol("NOT", span), zero], span)


def referenced_locals(body: Iterable[ZNode]) -> list[str]:
    """ルーチン本体で参照されるローカル変数 (`.X`) の名前を、最初に現れた順に返す。

    宣言のないローカル変数 (例: Zork I の VILLAIN-BLOW の `.HERO?`) を見つけるのに使う。
    ZIL のコンパイラはこれをそのまま通し、値は 0 になる。

    Args:
        body: ルーチン本体のノード。

    Returns:
        `.` を付けたままの ZIL の名前のリスト (重複なし)。
    """
    used: dict[str, None] = {}

    def walk(node: ZNode) -> None:
        if isinstance(node, ZSymbol):
            if len(node.text) > 1 and node.text.startswith("."):
                used.setdefault(node.text)
        elif isinstance(node, ZExp):
            if node.item is not None:
                walk(node.item)
        elif isinstance(node, ZList):
            for item in node.items:
                walk(item)

    for item in body:
        walk(item)
    return list(used)


def macro_helper_names(ast: Iterable[ZNode]) -> set[str]:
    """DEFMAC の本体から呼ばれている名前を返す。

    同じファイルの DEFINE のうち、ここに入るものは MDL (コンパイル時) でしか動かない
    補助関数なので、変換しない。

    Args:
        ast: モジュールのトップレベルのノード。

    Returns:
        呼ばれている名前 (ZIL の表記のまま) の集合。
    """
    called: set[str] = set()

    def walk(node: ZNode) -> None:
        if isinstance(node, ZExp):
            if node.item is not None:
                walk(node.item)
        elif isinstance(node, ZList):
            if form_name(node) is not None and isinstance(node.items[0], ZSymbol):
                called.add(node.items[0].text)
            for item in node.items:
                walk(item)

    for node in ast:
        if form_name(node) == "DEFMAC":
            walk(node)
    return called


@dataclass(frozen=True)
class Param:
    """ルーチンの引数リストの 1 項目。

    Attributes:
        section: "req" (必須)、"opt" ("OPTIONAL" 以降)、"aux" ("AUX" 以降)、
            "rest" ("ARGS" / "TUPLE" の直後の 1 つ)。
        name: 名前のノード (クォートなどで修飾されていることがある)。
        default: `(NAME VALUE)` の VALUE。なければ None。
        listed: `(NAME ...)` の形で書かれていたか。
    """

    section: str
    name: ZNode
    default: ZNode | None
    listed: bool


def param_symbol(node: ZNode) -> ZSymbol | None:
    """仮引数や束縛のノードから、修飾 (クォートなど) を外した名前のシンボルを返す。"""
    while isinstance(node, ZExp) and node.item is not None:
        node = node.item
    return node if isinstance(node, ZSymbol) else None


def parse_params(args_node: ZNode) -> list[Param]:
    """ROUTINE の引数リストを解釈する。

    `"OPTIONAL"` 以降は省略可能引数、`"AUX"` 以降はローカル変数、`"ARGS"` / `"TUPLE"` の
    直後の 1 つは可変長引数。同じ名前が 2 度現れたら、2 度目以降は捨てる。

    Args:
        args_node: ROUTINE の引数リスト。

    Returns:
        引数の並び。丸括弧のリストでなければ空。
    """
    params: list[Param] = []
    if not (isinstance(args_node, ZList) and args_node.kind == "paren"):
        return params
    section = "req"
    seen: set[str] = set()
    for arg in args_node.items:
        if is_ignorable(arg):
            continue
        if isinstance(arg, ZString):
            marker = arg.text.upper()
            if marker in AUX_MARKERS:
                section = "aux"
            elif marker in OPTIONAL_MARKERS:
                section = "opt"
            elif marker in REST_MARKERS and not any(p.section == "rest" for p in params):
                section = "rest"
            else:
                section = "req"
            continue
        listed = isinstance(arg, ZList)
        default: ZNode | None = None
        if isinstance(arg, ZList):
            if not arg.items:
                continue
            name = arg.items[0]
            if len(arg.items) > 1:
                default = arg.items[1]
        else:
            name = arg
        symbol = param_symbol(name)
        key = symbol.text if symbol is not None else ""
        if key in seen:
            continue  # 重複した仮引数は Python では構文エラーになる
        seen.add(key)
        current = section
        if section == "rest":
            section = "req"  # 可変長引数は 1 つだけ。あとは通常の引数として扱う
        params.append(Param(current, name, default, listed))
    return params
