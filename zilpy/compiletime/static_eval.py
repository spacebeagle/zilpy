"""コンパイル時に決まる条件の評価。

- `zilch_branch`: `<COND (<GASSIGNED? ZILCH> ...)>` の節の選択 (名前を集める前の走査で使う)。
- `StaticEvaluator`: `%<COND ...>`、`%<DEBUG-CODE ...>`、トップレベルの `<COND ...>` の
  条件を変換時に評価する。Python 版と Lua 版の変換器が共有する。

refactor-plan.md Phase 1-4 で ZilNodes.py から分け、Phase 2-1 で `StaticEvaluator` を足した。
"""

from zilpy.compiletime.errors import ConversionError
from zilpy.constants import COMPARE_OPS, COMPILER_ATOMS, INTEGER_RE, TRUE_TESTS
from zilpy.front.nodes import ZExp, ZList, ZNode, ZString, ZSymbol, form_name, is_ignorable, to_identifier, zil_text


def gassigned(
    name: str,
    static_values: dict[str, int],
    defined_names: frozenset[str] | set[str] | None,
) -> bool | None:
    """`<GASSIGNED? NAME>` をコンパイル時に評価する (StaticEvaluator と MdlEvaluator が共有する規則)。

    ZilPy はコンパイラ (ZILCH) の役をするので、ZILCH は定義済みとみなす。
    (例: Spellbreaker の `<COND (<GASSIGNED? ZILCH> <DEFMAC ...>) (ELSE <DEFINE ...>)>`
    は、コンパイル時のマクロ定義を選ぶ。ELSE は MDL インタプリタ用の定義。)

    - ZILCH、またはコンパイル時に値の決まる名前 (static_values) なら真
    - ソースのどこにも定義のない名前 (PREDGEN、MUDDLE、V3 の作品の PLUS-MODE など) は偽
    - それ以外 (定義はあるが、値が変換時に決まらない名前) は決まらない (None)

    Args:
        name: 名前 (ZIL の表記)。
        static_values: コンパイル時に決まる値 (識別子 -> 整数)。
        defined_names: ソースのどこかで定義される名前 (識別子)。None なら、偽と決めることはしない。
    """
    if name.upper() in COMPILER_ATOMS or to_identifier(name) in static_values:
        return True
    if defined_names is not None and to_identifier(name) not in defined_names:
        return False
    return None


# group_vectors がまとめた [...] のリストの種別
VECTOR_KIND = "vector"


def has_vector(args: list[ZNode]) -> bool:
    """引数の並びに、MDL のベクタ `[...]` の開き括弧があるか。"""
    return any(isinstance(arg, ZSymbol) and arg.text == "[" for arg in args)


def group_vectors(args: list[ZNode]) -> list[ZNode]:
    """引数の並びの中の `[` ... `]` を、1 つのリスト (種別 VECTOR_KIND) にまとめる。

    構文解析器は MDL のベクタ `[...]` を知らず、`[` と `]` をアトムとして読む。
    `%<DEBUG-CODE [<ROUTINE ...> <SYNTAX ...>]>` (Moonmist) のように、デバッグ版だけの
    定義をベクタで 1 つの引数にまとめた書き方を、正しい引数の数で読むために使う。
    閉じる `]` がなければ、残りをすべてベクタの中身とする。
    """
    result: list[ZNode] = []
    stack: list[list[ZNode]] = []
    spans = []
    for arg in args:
        if isinstance(arg, ZSymbol) and arg.text == "[":
            stack.append([])
            spans.append(arg.span)
            continue
        if isinstance(arg, ZSymbol) and arg.text == "]" and stack:
            items = stack.pop()
            vector = ZList(VECTOR_KIND, items, spans.pop())
            (stack[-1] if stack else result).append(vector)
            continue
        (stack[-1] if stack else result).append(arg)
    while stack:
        items = stack.pop()
        vector = ZList(VECTOR_KIND, items, spans.pop())
        (stack[-1] if stack else result).append(vector)
    return result


def _zilch_test(node: ZNode) -> bool | None:
    """`<GASSIGNED? ZILCH>` なら True、`<NOT <GASSIGNED? ZILCH>>` なら False を返す。

    ZilPy はコンパイラ (ZILCH) の役をするので、ZILCH は定義済みとみなす。

    Args:
        node: COND の節の条件。

    Returns:
        真偽。ZILCH の判定でなければ None。
    """
    if isinstance(node, ZSymbol):
        return True if node.text.upper() in ("T", "ELSE") else None
    name = form_name(node)
    if not isinstance(node, ZList) or name not in ("GASSIGNED?", "NOT"):
        return None
    args = [item for item in node.items[1:] if not is_ignorable(item)]
    if len(args) != 1:
        return None
    if name == "NOT":
        inner = _zilch_test(args[0])
        return None if inner is None else not inner
    if isinstance(args[0], ZSymbol) and args[0].text.upper() == "ZILCH":
        return True
    return None


def zilch_branch(node: ZNode) -> list[ZNode] | None:
    """`<COND (<GASSIGNED? ZILCH> ...) (ELSE ...)>` で、コンパイラが選ぶ節の中身を返す。

    例: Spellbreaker は、ZILCH ならマクロ (DEFMAC PROB)、MDL インタプリタなら
    関数 (DEFINE PROB) を定義する。ZILCH 側だけを読めば、ランタイムの PROB が使われる。

    Args:
        node: COND フォーム (% 付きでもよい)。

    Returns:
        選ばれた節の中身 (どの節も選ばれなければ空)。ZILCH で決まらない COND なら None。
    """
    if isinstance(node, ZExp) and node.kind == "EVAL" and node.item is not None:
        node = node.item
    if form_name(node) != "COND" or not isinstance(node, ZList):
        return None
    for clause in node.items[1:]:
        if not isinstance(clause, ZList):
            continue
        parts = [item for item in clause.items if not is_ignorable(item)]
        if not parts:
            continue
        passed = _zilch_test(parts[0])
        if passed is None:
            return None
        if passed:
            return parts[1:]
    return []


# 比較のフォームを、2 つの整数の比較にしたもの
_COMPARE_FUNCS = {
    "==": lambda a, b: a == b,
    "!=": lambda a, b: a != b,
    ">": lambda a, b: a > b,
    "<": lambda a, b: a < b,
    ">=": lambda a, b: a >= b,
    "<=": lambda a, b: a <= b,
}


class StaticEvaluator:
    """変換時に値の決まる式・条件を評価する。

    値が決まるのは、整数のリテラルと、トップレベルで整数 (または T / <>) を
    SETG された名前 (`collect_static_values` が集めたもの。例: ZORK-NUMBER) だけ。
    評価できない式には None を返し、呼び出し側は実行時のコードとして変換する。

    Python 版と Lua 版で違っていた規則は、次のものに揃えた (refactor-plan.md §1.5):
    - 比較は `COMPARE_OPS` の全部 (`==?`・`N==?`・`=?`・`G?`・`L?` など)。
    - `AND`・`OR` は左から短絡評価する。決まらない項に当たったら、そこで決まらない。
    - `<GASSIGNED? X>` は、X が ZILCH か、コンパイル時に値の決まる名前なら真。
      ソースのどこにも定義のない名前 (PREDGEN、MUDDLE など。ZILCH では定義されない) は偽。
      それ以外 (定義はあるが、値が変換時に決まらない名前) は決まらない。
    - 値は `,X` とむき出しの `X` の両方を受け付ける。
    """

    def __init__(
        self,
        static_values: dict[str, int],
        defined_names: frozenset[str] | set[str] | None = None,
    ) -> None:
        """
        Args:
            static_values: コンパイル時に決まる値 (識別子に変換した名前 -> 整数)。
            defined_names: ソースのどこかで定義される名前 (識別子。collect_global_names)。
                None なら、`<GASSIGNED? X>` を偽と決めることはしない。
        """
        self.static_values = static_values
        self.defined_names = defined_names

    def value(self, node: ZNode) -> int | None:
        """コンパイル時に決まる値 (整数リテラル、または SETG された整数) を返す。

        Args:
            node: 対象のノード。

        Returns:
            整数値。決まらない場合は None。
        """
        if not isinstance(node, ZSymbol):
            return None
        text = node.text.removeprefix(",")
        if INTEGER_RE.fullmatch(text):
            return int(text)
        return self.static_values.get(to_identifier(text))

    def test(self, node: ZNode) -> bool | None:
        """コンパイル時に決まる条件を評価する。

        Args:
            node: 条件のノード (T / ELSE、`,X`、比較、AND、OR、NOT、GASSIGNED?)。

        Returns:
            真偽。コンパイル時に決まらない場合は None。
        """
        if isinstance(node, ZSymbol):
            if node.text.upper() in TRUE_TESTS:
                return True
            if node.text.startswith(","):
                # ,ZDEBUGGING? のように、コンパイル時に値の決まるグローバル
                value = self.value(node)
                return None if value is None else value != 0
            return None
        name = form_name(node)
        if name is None or not isinstance(node, ZList):
            return None
        args = [item for item in node.items[1:] if not is_ignorable(item)]
        if name == "NOT":
            if len(args) != 1:
                return None
            inner = self.test(args[0])
            return None if inner is None else not inner
        if name in ("AND", "OR"):
            stop = name == "OR"  # OR は真で、AND は偽で止まる
            for arg in args:
                result = self.test(arg)
                if result is None:
                    return None
                if result is stop:
                    return stop
            return not stop
        if name in COMPARE_OPS and len(args) >= 2:
            values = [self.value(arg) for arg in args]
            if None in values:
                return None
            op = COMPARE_OPS[name]
            if op == "==":
                return values[0] in values[1:]  # <EQUAL? A B C> は A が B か C に等しいか
            if op == "!=":
                return values[0] not in values[1:]
            compare = _COMPARE_FUNCS[op]
            return all(compare(a, b) for a, b in zip(values, values[1:]))
        if name == "GASSIGNED?" and len(args) == 1 and isinstance(args[0], ZSymbol):
            return gassigned(args[0].text, self.static_values, self.defined_names)
        return None

    def eval_ifflag(self, node: ZList) -> list[ZNode]:
        """`<IFFLAG (FLAG BODY...) ... (ELSE BODY...)>` で、コンパイル時に選ばれる節の本体を返す。

        節の条件は、コンパイル時のフラグの名前 (アトムか文字列。`<COMPILATION-FLAG NAME VAL>` で
        定義したもの)、`T` / `ELSE`、または `<NOT 条件>`。最初に真になった節の本体を返す。
        どの節も選ばれなければ空。

        Raises:
            ConversionError: 定義されていないフラグの名前、または解釈できない条件。
        """
        for clause in node.items[1:]:
            if not (isinstance(clause, ZList) and clause.kind == "paren"):
                continue
            parts = [item for item in clause.items if not is_ignorable(item)]
            if parts and self._ifflag_test(parts[0], node):
                return parts[1:]
        return []

    def _ifflag_test(self, cond: ZNode, node: ZList) -> bool:
        if isinstance(cond, (ZSymbol, ZString)):
            text = cond.text
            if isinstance(cond, ZSymbol) and text.upper() in TRUE_TESTS:
                return True
            key = to_identifier(text.removeprefix(","))
            if key not in self.static_values:
                raise ConversionError(f"line {node.span.line}: <IFFLAG>: compilation flag {text} is not defined")
            return self.static_values[key] != 0
        if form_name(cond) == "NOT" and isinstance(cond, ZList):
            args = [item for item in cond.items[1:] if not is_ignorable(item)]
            if len(args) == 1:
                return not self._ifflag_test(args[0], node)
        raise ConversionError(f"line {node.span.line}: <IFFLAG>: cannot evaluate the condition {zil_text(cond)}")

    def select_clause(self, cond: ZList) -> tuple[bool, list[ZNode] | None]:
        """COND の節のうち、コンパイル時に選ばれる節を求める。

        Args:
            cond: COND フォーム。

        Returns:
            (評価できたか, 選ばれた節の要素 (条件を含む))。最初に決まらない条件に
            当たれば (False, None)。どの節も選ばれなければ (True, None)。
        """
        for clause in cond.items[1:]:
            if not isinstance(clause, ZList):
                continue
            parts = [item for item in clause.items if not is_ignorable(item)]
            if not parts:
                continue
            passed = self.test(parts[0])
            if passed is None:
                return False, None
            if passed:
                return True, parts
        return True, None

    def eval_compile_time(self, node: ZExp) -> tuple[bool, ZNode | None]:
        """`%<COND ...>` / `%<DEBUG-CODE ...>` をコンパイル時に評価して、値を返す。

        COND は選ばれた節の最後の要素を値にする。値がクォートされている場合は、
        クォートを外した中身を返す。
        (例: `%<COND (<==? ,ZORK-NUMBER 1> '(<NOT .Y> <RETURN>))>` は節
        `(<NOT .Y> <RETURN>)` になる。)

        Args:
            node: `%` で修飾されたノード。

        Returns:
            (評価できたか, 値のノード)。評価できない場合は (False, None)。
            該当する節がないか、節に条件しかない場合は (True, None)。
        """
        cond = node.item
        if node.kind == "EVAL" and form_name(cond) == "DEBUG-CODE" and isinstance(cond, ZList):
            return self.debug_code(cond)
        if node.kind != "EVAL" or form_name(cond) != "COND" or not isinstance(cond, ZList):
            return False, None
        known, parts = self.select_clause(cond)
        if not known:
            return False, None
        if parts is None or len(parts) == 1:
            return True, None
        value = parts[-1]
        if isinstance(value, ZExp) and value.kind == "QUOTE" and value.item:
            value = value.item
        return True, value

    def debug_code(self, node: ZList) -> tuple[bool, ZNode | None]:
        """`%<DEBUG-CODE X Y>` をコンパイル時に評価する。

        Spellbreaker の DEBUG-CODE は MDL で書かれたコンパイル時の関数
        `<DEFINE DEBUG-CODE ('X "OPTIONAL" ('Y T)) <COND (,ZDEBUGGING? .X) (ELSE .Y)>>`
        で、デバッグ版なら X、製品版なら Y (省略時は T) を取り込む。
        ZDEBUGGING? はコンパイラ (ZILCH) では偽に設定されるので、製品版の Y を選ぶ。

        Args:
            node: DEBUG-CODE フォーム。

        Returns:
            (評価できたか, 値のノード)。Y が省略されていれば値は T。
        """
        args = group_vectors([item for item in node.items[1:] if not is_ignorable(item)])
        debugging = self.static_values.get(to_identifier("ZDEBUGGING?"), 0) != 0
        if debugging:
            first = args[0] if args else None
            if isinstance(first, ZList) and first.kind == VECTOR_KIND:
                # デバッグ版の [...] の中身は、並べて取り込む
                return True, ZList("angle", [ZSymbol("PROG", first.span), ZList("paren", [], first.span), *first.items], first.span)
            return True, first
        if len(args) > 1:
            return True, args[1]
        return True, ZSymbol("T", node.span)
