"""TELL の書式指定子とルーチンの対応表 (refactor-plan.md §2.3「TELL の扱い」の第 1 段階)。

作品の `DEFMAC TELL` を評価器で展開して、書式指定子 (D・A・CR など) ごとに、
どのルーチンに変わるかを調べる。出力は今の `TELL(...)` の形のまま、ランタイムの
TELL がこの表を使う (§4 の 2)。

調べ方: TELL マクロの中の文字列 (`<=? .P "D">` の "D" など) を候補にして、
`<TELL D .ARG>` を展開する。
- `<PROG () <R .ARG>>` なら、D は直後の引数を取るルーチン R
- `<PROG () <R> <PRINT .ARG>>` なら、D は引数を取らないルーチン R
- `<PROG () <PRINT <GETP .ARG D>>>` (プロパティの表示) は、書式指定子ではない
直後の引数がないと展開できない指定子 (`<TELL V>` で `<VPRINT>`) は、`<TELL V>` でも試す。
"""

from __future__ import annotations

from collections.abc import Iterable, Iterator

from zilpy.compiletime.mdl import Function, MdlError, MdlEvaluator, MList, MString, Quote, Segment
from zilpy.constants import AUX_MARKERS, OPTIONAL_MARKERS, REST_MARKERS
from zilpy.front.nodes import Span, ZList, ZNode, ZSymbol, form_name, is_ignorable

_SPAN = Span(0, 0, 0, 0)
_ARG = ".TELL-ARG"


def _strings(value: object) -> Iterator[str]:
    if isinstance(value, MString):
        yield value.text
    elif isinstance(value, MList):
        for item in value.items():
            yield from _strings(item)
    elif isinstance(value, (Quote, Segment)):
        yield from _strings(value.value)
    elif isinstance(value, Function):
        for expr in value.body:
            yield from _strings(expr)


def _statements(node: ZNode) -> list[ZNode] | None:
    """`<PROG () s1 s2 ...>` の s1 s2 ...。"""
    if form_name(node) != "PROG" or not isinstance(node, ZList):
        return None
    items = [item for item in node.items[1:] if not is_ignorable(item)]
    if not items or not (isinstance(items[0], ZList) and items[0].kind == "paren"):
        return None
    return items[1:]


def _routine(stmt: ZNode) -> tuple[str, list[ZNode]] | None:
    name = form_name(stmt)
    if name is None or not isinstance(stmt, ZList):
        return None
    return name, [item for item in stmt.items[1:] if not is_ignorable(item)]


def tell_indicators_from_macro(evaluator: MdlEvaluator) -> dict[str, tuple[str, bool]]:
    """作品の DEFMAC TELL から、書式指定子と (ルーチン名, 直後の引数を取るか) の対応を作る。

    TELL マクロがなければ空。
    """
    fn = evaluator.functions.get("TELL")
    if fn is None or not fn.is_macro:
        return {}
    candidates = sorted({text.upper() for text in _strings(fn) if text and text.replace("-", "").isalnum()})
    table: dict[str, tuple[str, bool]] = {}
    for name in candidates:
        found = _probe(evaluator, name)
        if found is not None:
            table[name] = found
    return table


def tell_expansion_tokens(
    evaluator: MdlEvaluator,
    indicators: dict[str, tuple[str, bool]],
    runtime_tokens: Iterable[str],
) -> frozenset[str]:
    """作品の DEFMAC TELL の書式指定子のうち、指定子の表 (indicators) で表せないものを返す
    (refactor-ZILFReferenceGuide-plan.md Phase 3.6)。

    表の項目は「1 つのルーチンに直後の引数を 0 個か 1 個渡す」形だけを表せる。Moonmist の
    `CHE obj [verb]` (`<HE-SHE-IT obj T "verb">`)、`HIS obj` (`<HIM-HER-IT obj <> T>`)、
    `FN` (`<PRINT-NAME ,FIRST-NAME>`) のように、決まった引数を足したり、後ろのアトムを
    文字列にして渡したりする指定子は表せない。これらを含む TELL の呼び出しは、変換器が
    作品の TELL マクロで展開する (base.TranscoderBase._expand_macro)。

    ランタイムの TELL が知っている指定子 (runtime_tokens。D・A・N・C・CR など) は除く。

    Returns:
        指定子の名前 (大文字) の集合。TELL マクロがなければ空。
    """
    fn = evaluator.functions.get("TELL")
    if fn is None or not fn.is_macro:
        return frozenset()
    runtime = {token.upper() for token in runtime_tokens}
    # 引数リストの区切り ("AUX" など。マクロの中の FUNCTION の引数リストにある) は指定子ではない
    markers = {*OPTIONAL_MARKERS, *AUX_MARKERS, *REST_MARKERS}
    candidates = {text.upper() for text in _strings(fn) if text and text.replace("-", "").isalnum()}
    return frozenset(
        name for name in candidates if name not in indicators and name not in runtime and name not in markers
    )


def _probe(evaluator: MdlEvaluator, name: str) -> tuple[str, bool] | None:
    try:
        stmts = _statements(evaluator.expand("TELL", [ZSymbol(name, _SPAN), ZSymbol(_ARG, _SPAN)], _SPAN))
    except MdlError:
        stmts = None
    if stmts:
        first = _routine(stmts[0])
        if first is not None:
            routine, args = first
            if len(stmts) == 1 and len(args) == 1 and isinstance(args[0], ZSymbol) and args[0].text == _ARG:
                return routine, True
            if not args and len(stmts) == 2:
                return routine, False
        return None
    try:
        stmts = _statements(evaluator.expand("TELL", [ZSymbol(name, _SPAN)], _SPAN))
    except MdlError:
        return None
    if stmts and len(stmts) == 1:
        first = _routine(stmts[0])
        if first is not None and not first[1]:
            return first[0], False
    return None
