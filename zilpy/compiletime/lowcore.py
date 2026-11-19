"""`<LOWCORE ...>` / `<LOWCORE-TABLE ...>` を、ヘッダ (アドレス 0) の GET / GETB / PUT / PUTB に書き換える。

refactor-ZILFReferenceGuide-plan.md §1.1。フィールド名とバイト位置は Z-Machine Standards Document の
ヘッダの表 (V3/V4) と、ZILF の LowCore の名前に従う。

ランタイムのヘッダは、バイト列ではなくセルの並び (`Table`) で値を持つ。ワードで書いた値の上位・下位の
バイトを GETB で読むことはできず、逆にバイト 0 と 1 を GET 0 0 で 1 つのワードとして読むこともできない。
そのため、バイト 0 (版番号) と 1 (FLAGS1) からなる ZVERSION だけは、2 つの GETB を組み合わせて読む。

- 読み取り `<LOWCORE F>`: BYTE は `<GETB 0 位置>`、WORD は `<GET 0 位置/2>`、
  ZVERSION は `<BOR <* <GETB 0 0> 256> <GETB 0 1>>`
- 書き込み `<LOWCORE F V>`: BYTE は `<PUTB 0 位置 V>`、WORD は `<PUT 0 位置/2 V>`、
  ZVERSION は `<PROG () <PUTB 0 0 </ V 256>> <PUTB 0 1 <BAND V 255>>>`
- `<LOWCORE-TABLE F N PROC>`: F の位置から N バイトを 1 つずつ PROC に渡す
  (N が整数リテラルなら `<PROG () <PROC <GETB 0 位置>> ...>`、変数や式なら `REPEAT` ループに展開)
"""

from zilpy.compiletime.errors import ConversionError
from zilpy.constants import INTEGER_RE
from zilpy.front.nodes import Span, ZList, ZNode, ZSymbol, form_name, is_ignorable

BYTE = "BYTE"
WORD = "WORD"
BYTEPAIR = "BYTEPAIR"  # バイト 0 と 1 をワードとして読む (ZVERSION)
BYTES = "BYTES"  # 複数バイトの並び (SERIAL)。LOWCORE-TABLE でだけ扱う

# フィールド名 -> (バイト位置, 幅)
LOWCORE_FIELDS: dict[str, tuple[int, str]] = {
    "ZVERSION": (0, BYTEPAIR),
    "MODEBITS": (1, BYTE),
    "FLAGS1": (1, BYTE),
    "ZORKID": (2, WORD),
    "RELEASEID": (2, WORD),
    "ENDLOD": (4, WORD),
    "START": (6, WORD),
    "VOCAB": (8, WORD),
    "OBJECT": (10, WORD),
    "GLOBALS": (12, WORD),
    "PURBOT": (14, WORD),
    "FLAGS": (16, WORD),
    "FLAGS2": (16, WORD),
    "SERIAL": (18, BYTES),
    "FWORDS": (24, WORD),
    "PLENTH": (26, WORD),
    "PCHKSM": (28, WORD),
    "INTID": (30, BYTE),
    "INTVR": (31, BYTE),
    "SCRV": (32, BYTE),
    "SCRH": (33, BYTE),
    # V5 以降のフィールド。V3/V4 の作品では使われないが、名前の表としては載せておく
    "HWRD": (34, WORD),
    "VWRD": (36, WORD),
    "FWRD": (38, BYTE),
    "FHGT": (39, BYTE),
    "FOFF": (40, WORD),
    "SOFF": (42, WORD),
    "CLRWRD": (44, WORD),
    "TCHARS": (46, WORD),
    "CRCNT": (48, WORD),
    "STDREV": (50, WORD),
    "CHRSET": (52, WORD),
    "EXTAB": (54, WORD),
}

LOWCORE_FORMS: frozenset[str] = frozenset({"LOWCORE", "LOWCORE-TABLE"})


def _sym(text: str, span: Span) -> ZSymbol:
    return ZSymbol(text, span)


def _form(span: Span, *items: ZNode) -> ZList:
    return ZList("angle", list(items), span)


def _num(value: int, span: Span) -> ZSymbol:
    return ZSymbol(str(value), span)


def _field(node: ZNode, form: str, span: Span) -> tuple[str, int, str]:
    """フィールド名のノードから (名前, バイト位置, 幅) を返す。表にない名前はエラー。"""
    if not isinstance(node, ZSymbol):
        raise ConversionError(f"line {span.line}: <{form}> needs a field name")
    name = node.text.upper()
    if name not in LOWCORE_FIELDS:
        raise ConversionError(f"line {span.line}: <{form} {node.text}>: unknown LOWCORE field")
    offset, width = LOWCORE_FIELDS[name]
    return name, offset, width


def lower_lowcore(node: ZList) -> ZNode:
    """`<LOWCORE F>` / `<LOWCORE F V>` をヘッダの読み書きに書き換える。

    Raises:
        ConversionError: フィールド名が表にない、SERIAL を LOWCORE で読み書きする、引数の数が違う。
    """
    span = node.span
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(args) not in (1, 2):
        raise ConversionError(f"line {span.line}: <LOWCORE> takes a field and an optional value")
    name, offset, width = _field(args[0], "LOWCORE", span)
    zero = _num(0, span)
    if width == BYTES:
        raise ConversionError(f"line {span.line}: <LOWCORE {name}> is a byte string; use <LOWCORE-TABLE {name} ...>")
    if len(args) == 1:
        if width == BYTE:
            return _form(span, _sym("GETB", span), zero, _num(offset, span))
        if width == WORD:
            return _form(span, _sym("GET", span), zero, _num(offset // 2, span))
        high = _form(span, _sym("GETB", span), zero, _num(offset, span))
        low = _form(span, _sym("GETB", span), zero, _num(offset + 1, span))
        return _form(span, _sym("BOR", span), _form(span, _sym("*", span), high, _num(256, span)), low)
    value = args[1]
    if width == BYTE:
        return _form(span, _sym("PUTB", span), zero, _num(offset, span), value)
    if width == WORD:
        return _form(span, _sym("PUT", span), zero, _num(offset // 2, span), value)
    # ZVERSION への書き込み。V は 2 度使うので、副作用のない式に限る (アトム・数・変数参照)
    if not isinstance(value, ZSymbol):
        raise ConversionError(f"line {span.line}: <LOWCORE {name} value>: the value must be a number or a variable")
    return _form(
        span,
        _sym("PROG", span),
        ZList("paren", [], span),
        _form(span, _sym("PUTB", span), zero, _num(offset, span), _form(span, _sym("/", span), value, _num(256, span))),
        _form(span, _sym("PUTB", span), zero, _num(offset + 1, span), _form(span, _sym("BAND", span), value, _num(255, span))),
    )


def lower_lowcore_table(node: ZList) -> ZNode:
    """`<LOWCORE-TABLE F N PROC>` を、F の位置から N バイトを PROC に渡す文の並びに書き換える。

    - N が整数リテラルのとき: `<PROG () <PROC <GETB 0 位置>> ...>` に展開する。
    - N が変数や式のとき: `<PROG ((_LC-I 0) (_LC-N N)) <REPEAT () ...>>` に展開する。

    Raises:
        ConversionError: フィールド名が表にない、PROC が名前でない、引数の数が違う。
    """
    span = node.span
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(args) != 3:
        raise ConversionError(f"line {span.line}: <LOWCORE-TABLE> takes a field, a length and a routine")
    _, offset, _ = _field(args[0], "LOWCORE-TABLE", span)
    length, proc = args[1], args[2]
    if not isinstance(proc, ZSymbol):
        raise ConversionError(f"line {span.line}: <LOWCORE-TABLE>: the routine must be a name")
    zero = _num(0, span)
    if isinstance(length, ZSymbol) and INTEGER_RE.fullmatch(length.text):
        calls = [
            _form(span, _sym(proc.text, span), _form(span, _sym("GETB", span), zero, _num(offset + i, span)))
            for i in range(int(length.text))
        ]
        return _form(span, _sym("PROG", span), ZList("paren", [], span), *calls)
    # 動的長さのときはループに展開する
    idx_sym = _sym("_LC-I", span)
    idx_ref = _sym("._LC-I", span)
    lim_sym = _sym("_LC-N", span)
    lim_ref = _sym("._LC-N", span)
    bindings = ZList(
        "paren",
        [
            ZList("paren", [idx_sym, _num(0, span)], span),
            ZList("paren", [lim_sym, length], span),
        ],
        span,
    )
    exit_cond = _form(
        span,
        _sym("COND", span),
        ZList(
            "paren",
            [
                _form(span, _sym("G=?", span), idx_ref, lim_ref),
                _form(span, _sym("RETURN", span)),
            ],
            span,
        ),
    )
    byte_idx = idx_ref if offset == 0 else _form(span, _sym("+", span), _num(offset, span), idx_ref)
    call_proc = _form(span, _sym(proc.text, span), _form(span, _sym("GETB", span), zero, byte_idx))
    inc_idx = _form(span, _sym("SET", span), idx_sym, _form(span, _sym("+", span), idx_ref, _num(1, span)))
    loop = _form(span, _sym("REPEAT", span), ZList("paren", [], span), exit_cond, call_proc, inc_idx)
    return _form(span, _sym("PROG", span), bindings, loop)


def lower_lowcore_form(node: ZNode) -> ZNode:
    """LOWCORE / LOWCORE-TABLE なら書き換えた式を、そうでなければ node をそのまま返す。"""
    name = form_name(node)
    if name == "LOWCORE" and isinstance(node, ZList):
        return lower_lowcore(node)
    if name == "LOWCORE-TABLE" and isinstance(node, ZList):
        return lower_lowcore_table(node)
    return node
