"""マクロの関数化 (refactor-plan.md §2.3「マクロの関数化」、Phase 3 手順 7)。

関数にしても動きがまったく同じになるマクロは、作品の定義から関数を作って生成コードに
出力し、呼び出しをその関数の呼び出しにする (生成コードを小さくする)。

マクロごとの判定 (analyze):
- 引数を `.名前` にした呼び出しを評価器で展開し、それを関数の本体にする
- 本体が呼び出し元のルーチンの流れを変える (RETURN・RTRUE など。④)、引数でない
  ローカル変数を読み書きする (`.RARG`。⑤)、スタックを操作する (PUSH・RSTACK。⑦) なら、
  関数にしない
- 本体が、別の命令に引数をそのままの順で渡すだけ (Trinity の MAKE = FSET) なら、関数に
  しない (小さくならず、元の命令の名前が見えるほうが読みやすい)
- 引数がアトムのとき、展開の中で名前が作り変えられるか (③。例: HERE? の `KITCHEN` は
  `,KITCHEN`) を、試しに展開して調べる。呼び出し側で引数を作り変えて渡す
- "ARGS" で引数の数が変わるマクロや、"OPTIONAL" で形が変わるマクロは、ソースに書かれた
  呼び出しの引数の数ごとに関数を作る (名前は `NAME-引数の数`)

呼び出しごとの判定 (macro_registry.MacroRegistry.function_call):
- 実際の呼び出しを展開した式と、関数の本体に (作り変えた) 引数を入れた式が、1 文字も
  違わないときだけ関数を呼ぶ (引数の形で展開が変わるマクロ ⑥ を取り違えないため)
- 引数を 1 回ずつ、条件なしに、左から順に使うマクロなら、いつでも関数を呼ぶ。そうでない
  マクロ (① ②) は、引数がどれも副作用のない式 (purity.py) のときだけ呼ぶ
"""

from __future__ import annotations

from dataclasses import dataclass

from zilpy.constants import INTEGER_RE
from zilpy.compiletime.mdl import Function, MdlError, MdlEvaluator
from zilpy.front.nodes import Span, ZExp, ZList, ZNode, ZString, ZSymbol, form_name, is_ignorable, zil_text

_SPAN = Span(0, 0, 0, 0)
_PROBE = "ZILPY-ATOM-PROBE"
# 呼び出し元のルーチンの流れを変える命令 (④)
_CONTROL_FORMS = frozenset({"RETURN", "RTRUE", "RFALSE", "RFATAL", "AGAIN"})
# スタックを操作する命令 (⑦)
_STACK_FORMS = frozenset({"PUSH", "RSTACK", "POP", "FSTACK"})
# 中の式が条件によって評価されないことがあるフォーム (②)
_CONDITIONAL_FORMS = frozenset({"COND", "AND", "OR"})


@dataclass(frozen=True)
class MacroFunction:
    """マクロから作った関数 (引数の数ごとに 1 つ)。

    Attributes:
        macro: マクロの名前 (大文字)。
        name: 関数の ZIL の名前 (ROUTINE の名前。例: PROB、HERE?-2)。
        params: 仮引数の名前 (本体では `.名前` で参照する)。
        body: 関数の本体 (展開した式)。
        atom_templates: 引数がアトムのときの作り変え (`,{}` など)。作り変えないなら "{}"。
            アトムを渡せない (作り変えの形が分からない) なら None。
        always: 引数を 1 回ずつ、条件なしに、左から順に使うか (いつでも関数を呼べるか)。
    """

    macro: str
    name: str
    params: tuple[str, ...]
    body: ZNode
    atom_templates: tuple[str | None, ...]
    always: bool

    def routine(self, span: Span) -> ZList:
        """`<ROUTINE NAME (PARAMS) BODY>` の AST (変換器のルーチンの変換で出力する)。"""
        params = ZList("paren", [ZSymbol(p, span) for p in self.params], span)
        return ZList("angle", [ZSymbol("ROUTINE", span), ZSymbol(self.name, span), params, self.body], span)

    def instantiate(self, args: list[ZNode]) -> ZNode:
        """本体の `.名前` を引数で置き換えた式。"""
        bound = dict(zip(self.params, args))
        return _substitute(self.body, bound)


def is_plain_atom(node: ZNode) -> bool:
    """接頭辞のないアトム (`KITCHEN`。数値・`,X`・`.X` ではない)。"""
    return (
        isinstance(node, ZSymbol)
        and node.text[:1] not in (",", ".", "\\")
        and not INTEGER_RE.fullmatch(node.text)
    )


def _substitute(node: ZNode, bound: dict[str, ZNode]) -> ZNode:
    if isinstance(node, ZSymbol):
        if node.text.startswith(".") and node.text[1:] in bound:
            return bound[node.text[1:]]
        return node
    if isinstance(node, ZList):
        return ZList(node.kind, [_substitute(item, bound) for item in node.items], node.span)
    if isinstance(node, ZExp) and node.item is not None:
        return ZExp(node.kind, _substitute(node.item, bound), node.span)
    return node


def _walk(node: ZNode, conditional: bool = False):
    """(ノード, 条件付きの位置か) を深さ優先で順に返す。"""
    yield node, conditional
    if isinstance(node, ZList):
        items = [item for item in node.items if not is_ignorable(item)]
        name = form_name(node)
        for index, item in enumerate(items):
            # COND の中、AND / OR の 2 つ目以降の項は、評価されないことがある
            cond = conditional or name == "COND" or (name in ("AND", "OR") and index >= 2)
            yield from _walk(item, cond)
    elif isinstance(node, ZExp) and node.item is not None and not is_ignorable(node):
        yield from _walk(node.item, conditional)


def _collect_at(body: ZNode, other: ZNode, target: str) -> list[ZNode] | None:
    """body で `.target` の位置にある other の部分木を集める。ほかの所が違えば None。"""
    found: list[ZNode] = []

    def same(a: ZNode, b: ZNode) -> bool:
        if isinstance(a, ZSymbol) and a.text == "." + target:
            found.append(b)
            return True
        if type(a) is not type(b):
            return False
        if isinstance(a, ZSymbol):
            return a.text == b.text  # type: ignore[union-attr]
        if isinstance(a, ZString):
            return a.text == b.text  # type: ignore[union-attr]
        if isinstance(a, ZExp):
            return a.kind == b.kind and (  # type: ignore[union-attr]
                (a.item is None and b.item is None)  # type: ignore[union-attr]
                or (a.item is not None and b.item is not None and same(a.item, b.item))  # type: ignore[union-attr]
            )
        xs = [i for i in a.items if not is_ignorable(i)]  # type: ignore[union-attr]
        ys = [i for i in b.items if not is_ignorable(i)]  # type: ignore[union-attr]
        return a.kind == b.kind and len(xs) == len(ys) and all(same(x, y) for x, y in zip(xs, ys))  # type: ignore[union-attr]

    return found if same(body, other) else None


def _mentions(node: ZNode, params: tuple[str, ...]) -> bool:
    """node の中に、仮引数の参照 (`.名前`) があるか。"""
    for sub, _ in _walk(node):
        if isinstance(sub, ZSymbol) and sub.text.startswith(".") and sub.text[1:] in params:
            return True
    return False


def _param_names(fn: Function, arity: int) -> tuple[str, ...] | None:
    """引数の数 arity の呼び出しに使う仮引数の名前。マクロがその数の引数を取れなければ None。"""
    names: list[str] = []
    for param in fn.params:
        if param.section in ("req", "opt"):
            if len(names) < arity:
                names.append(param.name)
            elif param.section == "req":
                return None
        elif param.section in ("args", "tuple"):
            rest = arity - len(names)
            names += [f"{param.name}{i}" for i in range(1, rest + 1)]
    if len(names) != arity:
        return None
    if len(set(names)) != len(names):
        return None
    return tuple(names)


def analyze(
    evaluator: MdlEvaluator, macro: str, arity: int, name: str, name_forms: frozenset[str] = frozenset()
) -> tuple[MacroFunction | None, str]:
    """マクロ macro の、引数の数 arity の呼び出しを、関数 name にできるかを調べる。

    Args:
        name_forms: 引数を値ではなく名前として扱うことがあるフォーム (作品のマクロと、
            VERB? などの宣言フォーム)。本体がこれに引数を渡すなら、関数にしない
            (例: Lurking Horror の P? は <VERB? .V> を作る。<P? SMELL> の SMELL は
            V?SMELL に作り変えられるが、関数にすると SMELL を値として渡してしまう)。

    Returns:
        (関数, 理由)。関数にできなければ関数は None で、理由に ④ などを書く。
    """
    fn = evaluator.functions.get(macro)
    if fn is None or not fn.is_macro:
        return None, "not a macro"
    params = _param_names(fn, arity)
    if params is None:
        return None, f"the macro does not take {arity} arguments"
    lvals = [ZSymbol("." + p, _SPAN) for p in params]
    try:
        body = evaluator.expand(macro, lvals, _SPAN)
    except MdlError as error:
        return None, f"cannot expand with variables as arguments ({error})"
    used: list[str] = []
    always = True
    for node, conditional in _walk(body):
        name_ = form_name(node)
        if name_ in _CONTROL_FORMS:
            return None, f"changes the flow of the calling routine ({name_}) [4]"
        if name_ in _STACK_FORMS:
            return None, f"uses the stack ({name_}) [7]"
        if name_ in ("SET", "SETG") and isinstance(node, ZList):
            return None, "assigns a variable [5]"
        if name_ in name_forms and isinstance(node, ZList) and _mentions(node, params):
            return None, f"passes an argument to {name_}, which may use it as a name [3]"
        if isinstance(node, ZSymbol) and node.text.startswith(".") and len(node.text) > 1:
            local = node.text[1:]
            if local not in params:
                return None, f"reads the local variable .{local} of the calling routine [5]"
            used.append(local)
            if conditional:
                always = False
    if used != list(params):
        always = False  # 使わない引数・2 回以上使う引数・順の違う引数がある (①)
    if (
        isinstance(body, ZList)
        and body.kind == "angle"
        and [zil_text(item) for item in body.items[1:] if not is_ignorable(item)] == ["." + p for p in params]
    ):
        return None, f"only passes its arguments to {zil_text(body.items[0])} (expanding is as short)"
    templates: list[str | None] = []
    for index, param in enumerate(params):
        if param not in used:
            templates.append("{}")
            continue
        args = list(lvals)
        args[index] = ZSymbol(_PROBE, _SPAN)
        try:
            probe = evaluator.expand(macro, args, _SPAN)
        except MdlError:
            templates.append(None)
            continue
        found = _collect_at(body, probe, param)
        texts = {zil_text(n) for n in found} if found else set()
        if (
            found is None
            or len(texts) != 1
            or not isinstance(found[0], ZSymbol)
            or _PROBE not in found[0].text
            or not found[0].text.startswith(",")
        ):
            # アトムは、`,X` (グローバルの値) に作り変えられるときだけ値として渡せる
            templates.append(None)
        else:
            templates.append(found[0].text.replace(_PROBE, "{}"))
    return MacroFunction(macro, name, params, body, tuple(templates), always), ""
