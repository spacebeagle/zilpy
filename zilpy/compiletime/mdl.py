"""コンパイル時の MDL 評価器 (refactor-plan.md Phase 3、§2.3)。

ゲームの `DEFMAC` と、それが呼ぶ補助の `DEFINE` (`MULTIFROB` など) を、変換時に
ZIL の AST をデータとして実行して展開する。ZILCH が MDL インタプリタの上で
やっていたことと同じ。扱うのは、14 作品のマクロが使う MDL のサブセットだけ。

値の表し方:
- FIX: int / STRING: MString / CHARACTER: Char / ATOM: Atom (名前で同一視する)
- `.X`: LVal、`,X`: GVal (どちらも TYPE? では LVAL・GVAL であり、FORM でもある。
  古い MDL では `.X` は `<LVAL X>` という FORM だったため。Deadline の TELL は
  `<TYPE? .E FORM>` だけで `.X` を受け付ける)
- LIST・FORM: MList。要素はセル (Cell) の連鎖で持ち、REST や CHTYPE は連鎖を共有する
  (PUTREST で後ろをつなぎ替える MULTIFROB が、この共有に頼っている)
- `#FALSE ()` と `<>`: FALSE
- `'X`: Quote (評価すると X)、`!X`: Segment (リストの中で X の要素を展開する)
- 評価器が中身を見ない AST (`%<...>`・`#BYTE` など): Opaque

変換時に値の分からない `,X` (GVAL) は、評価しても `,X` のまま残す (生成コードで
実行時に読む)。ローカル変数は MDL と同じく動的に束縛する (TELL マクロの FUNCTION が、
外側のマクロの `.A` を読むため)。

評価器が対応していない機能に当たると MdlError を投げる。呼び出し側は、そのマクロを
展開せずに警告を出す。
"""

from __future__ import annotations

from collections.abc import Callable, Iterable, Iterator
from dataclasses import dataclass, field

from zilpy.compiletime.static_eval import gassigned
from zilpy.constants import AUX_MARKERS, INTEGER_RE, OPTIONAL_MARKERS
from zilpy.front.nodes import Span, ZExp, ZList, ZNode, ZString, ZSymbol, form_name, is_ignorable

# 1 回の展開で評価する式の数の上限 (無限ループを止める)
MAX_STEPS = 200_000


class MdlError(Exception):
    """評価器が式を評価できなかった (未対応の機能・ERROR の呼び出し・型の誤り)。"""


# ----------------------------------------------------------------------
# 値
# ----------------------------------------------------------------------


@dataclass(frozen=True)
class Atom:
    name: str

    def __repr__(self) -> str:
        return self.name


@dataclass(frozen=True)
class LVal:
    name: str

    def __repr__(self) -> str:
        return "." + self.name


@dataclass(frozen=True)
class GVal:
    name: str

    def __repr__(self) -> str:
        return "," + self.name


@dataclass(frozen=True)
class MString:
    text: str

    def __repr__(self) -> str:
        return repr(self.text)


@dataclass(frozen=True)
class Char:
    ch: str

    def __repr__(self) -> str:
        return "!\\" + self.ch


class _False:
    def __repr__(self) -> str:
        return "<>"


FALSE = _False()


@dataclass(eq=False)
class Cell:
    car: object
    cdr: Cell | None = None


@dataclass(eq=False)
class MList:
    """LIST・FORM。head から始まるセルの連鎖。"""

    kind: str  # "LIST" | "FORM"
    head: Cell | None
    span: Span | None = None

    @staticmethod
    def of(kind: str, items: Iterable[object], span: Span | None = None) -> MList:
        head: Cell | None = None
        tail: Cell | None = None
        for item in items:
            cell = Cell(item)
            if tail is None:
                head = cell
            else:
                tail.cdr = cell
            tail = cell
        return MList(kind, head, span)

    def items(self) -> Iterator[object]:
        cell = self.head
        while cell is not None:
            yield cell.car
            cell = cell.cdr

    def __len__(self) -> int:
        return sum(1 for _ in self.items())

    def __repr__(self) -> str:
        inner = " ".join(repr(item) for item in self.items())
        return f"<{inner}>" if self.kind == "FORM" else f"({inner})"


@dataclass(frozen=True)
class Quote:
    value: object


@dataclass(frozen=True)
class Segment:
    value: object


@dataclass(frozen=True)
class Opaque:
    node: ZNode


@dataclass
class Function:
    """DEFINE・DEFMAC・FUNCTION で作った関数。"""

    name: str
    params: list[Param]
    body: list[object]
    is_macro: bool = False
    span: Span | None = None


@dataclass(frozen=True)
class Param:
    name: str
    section: str  # "req" | "opt" | "aux" | "args" | "tuple"
    quoted: bool
    default: object | None  # 既定値の式 (評価前)。なければ None


@dataclass
class Builtin:
    name: str
    fn: Callable[..., object]
    special: bool = False  # True なら引数を評価せずに渡す (FSUBR)


def truthy(value: object) -> bool:
    return value is not FALSE


# ----------------------------------------------------------------------
# AST との変換
# ----------------------------------------------------------------------


def from_ast(node: ZNode) -> object:
    """AST のノードを MDL の値 (データ) にする。"""
    if isinstance(node, ZSymbol):
        text = node.text
        if INTEGER_RE.fullmatch(text):
            return int(text)
        if len(text) > 1 and text[0] == ".":
            return LVal(text[1:])
        if len(text) > 1 and text[0] == ",":
            return GVal(text[1:])
        return Atom(text)
    if isinstance(node, ZString):
        return MString(node.text)
    if isinstance(node, ZList):
        kind = "FORM" if node.kind == "angle" else "LIST"
        return MList.of(kind, (from_ast(item) for item in node.items if not is_ignorable(item)), node.span)
    if isinstance(node, ZExp):
        if node.kind == "QUOTE" and node.item is not None:
            return Quote(from_ast(node.item))
        if node.kind == "LOAD" and node.item is not None:
            item = node.item
            if isinstance(item, ZSymbol) and len(item.text) == 2 and item.text[0] == "\\":
                return Char(item.text[1])  # !\M は文字
            return Segment(from_ast(item))
    return Opaque(node)


def to_ast(value: object, span: Span) -> ZNode:
    """MDL の値を AST のノードに戻す。span は新しく作るノードに付ける位置。"""
    if isinstance(value, bool):
        raise MdlError(f"not a ZIL value: {value!r}")
    if isinstance(value, int):
        return ZSymbol(str(value), span)
    if isinstance(value, Atom):
        return ZSymbol(value.name, span)
    if isinstance(value, LVal):
        return ZSymbol("." + value.name, span)
    if isinstance(value, GVal):
        return ZSymbol("," + value.name, span)
    if isinstance(value, MString):
        return ZString(value.text, span)
    if isinstance(value, Char):
        return ZExp("LOAD", ZSymbol("\\" + value.ch, span), span)
    if value is FALSE:
        return ZList("angle", [], span)
    if isinstance(value, MList):
        items = list(value.items())
        own = value.span or span
        if (
            value.kind == "FORM"
            and len(items) == 2
            and isinstance(items[0], Atom)
            and items[0].name in ("GVAL", "LVAL")
            and isinstance(items[1], Atom)
        ):
            # <GVAL X> は ,X、<LVAL X> は .X と同じ
            prefix = "," if items[0].name == "GVAL" else "."
            return ZSymbol(prefix + items[1].name, own)
        kind = "angle" if value.kind == "FORM" else "paren"
        return ZList(kind, [to_ast(item, own) for item in items], own)
    if isinstance(value, Quote):
        return ZExp("QUOTE", to_ast(value.value, span), span)
    if isinstance(value, Segment):
        return ZExp("LOAD", to_ast(value.value, span), span)
    if isinstance(value, Opaque):
        return value.node
    raise MdlError(f"cannot turn {type(value).__name__} into ZIL code")


# ----------------------------------------------------------------------
# 制御の脱出
# ----------------------------------------------------------------------


class _Return(Exception):
    def __init__(self, value: object) -> None:
        self.value = value


class _MapRet(Exception):
    def __init__(self, values: list[object]) -> None:
        self.values = values


class _MapStop(Exception):
    def __init__(self, values: list[object]) -> None:
        self.values = values


_UNASSIGNED = object()  # "AUX" で初期値のない変数など (ASSIGNED? が偽)


def _base_name(name: str) -> str:
    """`RETURN!-` のような、OBLIST の指定の付いた名前から本体を取り出す。"""
    return name[:-2] if name.endswith("!-") and len(name) > 2 else name


# ----------------------------------------------------------------------
# 評価器
# ----------------------------------------------------------------------


@dataclass
class MdlEvaluator:
    """MDL のサブセットの評価器。関数 (DEFINE・DEFMAC) を登録して、マクロを展開する。"""

    functions: dict[str, Function] = field(default_factory=dict)
    # コンパイル時に値の決まるグローバル (トップレベルの <SETG X T>・<SETG X <>>・<SETG X 3>)。
    # `%<...>` で DEFINE を呼ぶとき (call) だけ使う。マクロの展開 (expand) では `,X` のまま
    # 残す (例: Zork の <SETG C-ENABLED? 0> を ENABLE の展開に 0 として埋め込まない。
    # 生成コードが実行時に同じグローバルを読むので、意味は同じ)
    globals: dict[str, object] = field(default_factory=dict)
    # <GASSIGNED? X> の判定に使う (static_eval.gassigned。StaticEvaluator と同じ規則)。
    # static_values はコンパイル時に決まる値 (識別子 -> 整数)、defined_names はソースのどこかで
    # 定義される名前 (識別子)。ProjectBuilder が全ファイルを走査したあとで設定する
    static_values: dict[str, int] = field(default_factory=dict)
    defined_names: set[str] | None = None
    _use_globals: bool = False
    _frames: list[dict[str, object]] = field(default_factory=list)
    _steps: int = 0

    def __post_init__(self) -> None:
        self._builtins: dict[str, Builtin] = {}
        self._install_builtins()

    # -------------------------------------------------- 登録

    def define(self, node: ZList) -> Function | None:
        """`<DEFINE NAME (ARGS) BODY...>` / `<DEFMAC ...>` を登録する。"""
        items = [item for item in node.items if not is_ignorable(item)]
        if len(items) < 3 or not isinstance(items[1], ZSymbol):
            return None
        rest = items[2:]
        if isinstance(rest[0], ZSymbol) and len(rest) > 1:
            rest = rest[1:]  # 活性化名
        if not (isinstance(rest[0], ZList) and rest[0].kind == "paren"):
            return None
        fn = Function(
            items[1].text,
            _parse_params(from_ast(rest[0])),
            [from_ast(item) for item in rest[1:]],
            is_macro=form_name(node) == "DEFMAC",
            span=node.span,
        )
        self.functions[items[1].text.upper()] = fn
        return fn

    # -------------------------------------------------- 展開

    def expand(self, name: str, args: list[ZNode], span: Span) -> ZNode:
        """マクロ name を、引数 args (評価前の AST) で展開した AST を返す。

        Raises:
            MdlError: 展開できなかった。
        """
        fn = self.functions.get(name.upper())
        if fn is None or not fn.is_macro:
            raise MdlError(f"{name} is not a macro")
        self._frames = []
        self._steps = 0
        try:
            value = self._apply(fn, [from_ast(arg) for arg in args], evaluated=False)
        except (_Return, _MapRet, _MapStop) as e:
            raise MdlError(f"{type(e).__name__[1:]} outside of its form") from None
        except RecursionError:
            raise MdlError("recursion too deep") from None
        return to_ast(value, span)

    def call(self, name: str, args: list[ZNode], span: Span) -> ZNode:
        """コンパイル時の関数 (DEFINE) を呼んだ結果を AST で返す (`%<DEBUG-CODE ...>` など)。

        Raises:
            MdlError: 呼べなかった。
        """
        fn = self.functions.get(name.upper())
        if fn is None or fn.is_macro:
            raise MdlError(f"{name} is not a compile-time function")
        self._frames = []
        self._steps = 0
        self._use_globals = True
        try:
            value = self._apply(fn, [from_ast(arg) for arg in args], evaluated=False)
        except (_Return, _MapRet, _MapStop) as e:
            raise MdlError(f"{type(e).__name__[1:]} outside of its form") from None
        except RecursionError:
            raise MdlError("recursion too deep") from None
        finally:
            self._use_globals = False
        return to_ast(value, span)

    # -------------------------------------------------- 評価

    def eval(self, value: object) -> object:
        self._steps += 1
        if self._steps > MAX_STEPS:
            raise MdlError("too many steps (infinite loop?)")
        if isinstance(value, (int, MString, Char, Atom, Function, Builtin, Opaque)) or value is FALSE:
            return value
        if isinstance(value, LVal):
            return self._lval(value.name)
        if isinstance(value, GVal):
            return self._gval(value.name)
        if isinstance(value, Quote):
            return value.value
        if isinstance(value, Segment):
            raise MdlError("segment (!) outside of a structure")
        if isinstance(value, MList):
            if value.kind == "LIST":
                return MList.of("LIST", self._eval_items(value.items()))
            return self._eval_form(value)
        raise MdlError(f"cannot evaluate {value!r}")

    def _eval_items(self, items: Iterable[object]) -> list[object]:
        """要素を評価する。`!X` は X の要素を展開する。"""
        out: list[object] = []
        for item in items:
            if isinstance(item, Segment):
                seg = self.eval(item.value)
                if isinstance(seg, MList):
                    out.extend(seg.items())
                elif seg is FALSE:
                    pass
                else:
                    raise MdlError(f"cannot splice {seg!r}")
            else:
                out.append(self.eval(item))
        return out

    def _eval_form(self, form: MList) -> object:
        items = list(form.items())
        if not items:
            return FALSE
        head, args = items[0], items[1:]
        if isinstance(head, int):
            # <1 .L> は <NTH .L 1>、<1 .L X> は <PUT .L 1 X>
            values = self._eval_items(args)
            if len(values) == 1:
                return _nth(values[0], head)
            raise MdlError("<N struct value> (PUT) is not supported")
        if isinstance(head, Atom):
            name = _base_name(head.name).upper()
            builtin = self._builtins.get(name)
            if builtin is not None:
                if builtin.special:
                    return builtin.fn(args)
                return builtin.fn(*self._eval_items(args))
            fn = self.functions.get(name)
            if fn is not None:
                return self._apply(fn, args, evaluated=False)
            raise MdlError(f"{head.name} is not supported at compile time")
        if isinstance(head, (Function, Builtin)):
            return self._call_value(head, self._eval_items(args))
        raise MdlError(f"cannot apply {head!r}")

    def _call_value(self, fn: object, values: list[object]) -> object:
        if isinstance(fn, Builtin):
            return fn.fn(*values)
        if isinstance(fn, Function):
            return self._apply(fn, values, evaluated=True)
        raise MdlError(f"cannot apply {fn!r}")

    def _apply(self, fn: Function, args: list[object], evaluated: bool) -> object:
        """関数を呼ぶ。

        evaluated=False なら args は評価前の式で、クォートした引数と "ARGS" は評価せず、
        それ以外の引数は評価する (マクロでも同じ。MDL の DEFMAC は、引数の宣言どおりに
        束縛してから本体を実行する)。evaluated=True なら args は評価済みの値 (MAPF など)。
        """
        frame: dict[str, object] = {}
        pending = list(args)

        def take(param: Param) -> object:
            arg = pending.pop(0)
            return arg if param.quoted or evaluated else self.eval(arg)

        self._frames.append(frame)
        try:
            for param in fn.params:
                if param.section == "req":
                    if not pending:
                        raise MdlError(f"{fn.name}: too few arguments")
                    frame[param.name] = take(param)
                elif param.section == "opt":
                    if pending:
                        frame[param.name] = take(param)
                    elif param.default is not None:
                        frame[param.name] = self.eval(param.default)
                    else:
                        frame[param.name] = _UNASSIGNED
                elif param.section == "args":
                    frame[param.name] = MList.of("LIST", pending)
                    pending = []
                elif param.section == "tuple":
                    frame[param.name] = MList.of("LIST", pending if evaluated else [self.eval(a) for a in pending])
                    pending = []
                else:  # aux
                    frame[param.name] = _UNASSIGNED if param.default is None else self.eval(param.default)
            if pending:
                raise MdlError(f"{fn.name}: too many arguments")
            result: object = FALSE
            for expr in fn.body:
                result = self.eval(expr)
            return result
        except _Return as ret:
            # 関数の本体で直接 RETURN したとき (MDL では関数も活性化を持つ)
            return ret.value
        finally:
            self._frames.pop()

    # -------------------------------------------------- 変数

    def _lval(self, name: str) -> object:
        for frame in reversed(self._frames):
            if name in frame:
                value = frame[name]
                if value is _UNASSIGNED:
                    raise MdlError(f".{name} is unassigned")
                return value
        raise MdlError(f".{name} is unbound")

    def _set(self, name: str, value: object) -> object:
        for frame in reversed(self._frames):
            if name in frame:
                frame[name] = value
                return value
        if not self._frames:
            raise MdlError(f"SET {name} outside of a function")
        self._frames[0][name] = value  # 束縛のない変数は、いちばん外側に作る
        return value

    def _gval(self, name: str) -> object:
        builtin = self._builtins.get(name.upper())
        if builtin is not None:
            return builtin
        if self._use_globals and name in self.globals:
            return self.globals[name]
        fn = self.functions.get(name.upper())
        if fn is not None and not fn.is_macro:
            return fn
        return GVal(name)  # 変換時に値の分からないグローバルは、そのまま残す

    # -------------------------------------------------- 組み込み

    def _install_builtins(self) -> None:
        b = self._builtins

        def sub(name: str, *aliases: str) -> Callable[[Callable[..., object]], Callable[..., object]]:
            def deco(fn: Callable[..., object]) -> Callable[..., object]:
                for n in (name, *aliases):
                    b[n] = Builtin(n, fn)
                return fn

            return deco

        def fsub(name: str, *aliases: str) -> Callable[[Callable[..., object]], Callable[..., object]]:
            def deco(fn: Callable[..., object]) -> Callable[..., object]:
                for n in (name, *aliases):
                    b[n] = Builtin(n, fn, special=True)
                return fn

            return deco

        @fsub("QUOTE")
        def _quote(args: list[object]) -> object:
            return args[0] if args else FALSE

        @fsub("COND")
        def _cond(clauses: list[object]) -> object:
            for clause in clauses:
                if not (isinstance(clause, MList) and clause.kind == "LIST"):
                    raise MdlError("COND clause is not a list")
                parts = list(clause.items())
                if not parts:
                    continue
                test = self.eval(parts[0])
                if truthy(test):
                    result = test
                    for expr in parts[1:]:
                        result = self.eval(expr)
                    return result
            return FALSE

        @fsub("AND")
        def _and(args: list[object]) -> object:
            result: object = Atom("T")
            for arg in args:
                result = self.eval(arg)
                if not truthy(result):
                    return result
            return result

        @fsub("OR")
        def _or(args: list[object]) -> object:
            result: object = FALSE
            for arg in args:
                result = self.eval(arg)
                if truthy(result):
                    return result
            return result

        def loop(args: list[object], repeat: bool) -> object:
            if args and isinstance(args[0], Atom):
                args = args[1:]  # 活性化名
            frame: dict[str, object] = {}
            if args and isinstance(args[0], MList) and args[0].kind == "LIST":
                for binding in args[0].items():
                    if isinstance(binding, Atom):
                        frame[binding.name] = _UNASSIGNED
                    elif isinstance(binding, MList) and binding.kind == "LIST":
                        parts = list(binding.items())
                        if not parts or not isinstance(parts[0], Atom):
                            raise MdlError("bad binding")
                        # 初期値は順に評価する (後の束縛は前の束縛を読める。BIND と同じ)
                        self._frames.append(frame)
                        try:
                            value = self.eval(parts[1]) if len(parts) > 1 else _UNASSIGNED
                        finally:
                            self._frames.pop()
                        frame[parts[0].name] = value
                    elif isinstance(binding, MString):
                        continue
                    else:
                        raise MdlError("bad binding")
                args = args[1:]
            self._frames.append(frame)
            try:
                while True:
                    result: object = FALSE
                    try:
                        for expr in args:
                            result = self.eval(expr)
                    except _Return as ret:
                        return ret.value
                    if not repeat:
                        return result
            finally:
                self._frames.pop()

        @fsub("PROG", "BIND")
        def _prog(args: list[object]) -> object:
            return loop(args, repeat=False)

        @fsub("REPEAT")
        def _repeat(args: list[object]) -> object:
            return loop(args, repeat=True)

        @sub("RETURN")
        def _return(*values: object) -> object:
            raise _Return(values[0] if values else Atom("T"))

        @fsub("FUNCTION")
        def _function(args: list[object]) -> object:
            if not args or not isinstance(args[0], MList):
                raise MdlError("bad FUNCTION")
            return Function("FUNCTION", _parse_params(args[0]), list(args[1:]))

        @sub("MAPF", "MAPR")
        def _mapf(final: object, fn: object, *structs: object) -> object:
            collected: list[object] = []
            seqs = [list(s.items()) if isinstance(s, MList) else _seq(s) for s in structs]
            index = 0
            while True:
                if seqs and any(index >= len(s) for s in seqs):
                    break
                call_args = [s[index] for s in seqs]
                index += 1
                try:
                    collected.append(self._call_value(fn, call_args))
                except _MapRet as e:
                    collected.extend(e.values)
                except _MapStop as e:
                    collected.extend(e.values)
                    break
            if final is FALSE:
                return collected[-1] if collected else FALSE
            return self._call_value(final, collected)

        @sub("MAPRET")
        def _mapret(*values: object) -> object:
            raise _MapRet(list(values))

        @sub("MAPSTOP")
        def _mapstop(*values: object) -> object:
            raise _MapStop(list(values))

        @sub("SET")
        def _set(atom: object, value: object) -> object:
            if not isinstance(atom, Atom):
                raise MdlError("SET of a non-atom")
            return self._set(atom.name, value)

        @sub("ASSIGNED?")
        def _assigned(atom: object) -> object:
            if not isinstance(atom, Atom):
                raise MdlError("ASSIGNED? of a non-atom")
            for frame in reversed(self._frames):
                if atom.name in frame:
                    return Atom("T") if frame[atom.name] is not _UNASSIGNED else FALSE
            return FALSE

        @sub("BOUND?")
        def _bound(atom: object) -> object:
            if not isinstance(atom, Atom):
                raise MdlError("BOUND? of a non-atom")
            return Atom("T") if any(atom.name in frame for frame in self._frames) else FALSE

        @sub("GASSIGNED?")
        def _gassigned(atom: object) -> object:
            if not isinstance(atom, Atom):
                raise MdlError("GASSIGNED? of a non-atom")
            # 例: Moonmist の <DEFMAC GET/B> の <AND <GASSIGNED? PLUS-MODE> ,PLUS-MODE> は、
            # V3 の作品では PLUS-MODE がどこにも定義されないので偽になり、GETB の側に展開される
            result = gassigned(atom.name, self.static_values, self.defined_names)
            if result is None:
                raise MdlError(f"GASSIGNED? {atom.name}: not known at compile time")
            return Atom("T") if result else FALSE

        @sub("FORM")
        def _form(*values: object) -> object:
            return MList.of("FORM", values)

        @sub("LIST")
        def _list(*values: object) -> object:
            return MList.of("LIST", values)

        @sub("NTH")
        def _nth_(struct: object, n: object = 1) -> object:
            if not isinstance(n, int):
                raise MdlError("NTH index is not a number")
            return _nth(struct, n)

        @sub("REST")
        def _rest(struct: object, n: object = 1) -> object:
            if not isinstance(n, int):
                raise MdlError("REST count is not a number")
            if isinstance(struct, MList):
                cell = struct.head
                for _ in range(n):
                    if cell is None:
                        raise MdlError("REST past the end")
                    cell = cell.cdr
                return MList(struct.kind if struct.kind == "LIST" else "FORM", cell)
            if isinstance(struct, MString):
                return MString(struct.text[n:])
            raise MdlError(f"REST of {struct!r}")

        @sub("EMPTY?")
        def _empty(struct: object) -> object:
            return Atom("T") if len(_seq(struct)) == 0 else FALSE

        @sub("LENGTH")
        def _length(struct: object) -> object:
            return len(_seq(struct))

        @sub("LENGTH?")
        def _length_p(struct: object, n: object) -> object:
            length = len(_seq(struct))
            return length if isinstance(n, int) and length <= n else FALSE

        @sub("PUTREST")
        def _putrest(target: object, rest: object) -> object:
            if not (isinstance(target, MList) and target.head is not None):
                raise MdlError("PUTREST of an empty list")
            if not isinstance(rest, MList):
                raise MdlError("PUTREST with a non-list")
            target.head.cdr = rest.head
            return target

        @sub("CHTYPE")
        def _chtype(value: object, kind: object) -> object:
            if not isinstance(kind, Atom):
                raise MdlError("CHTYPE to a non-atom")
            t = kind.name.upper()
            if t in ("GVAL", "LVAL") and isinstance(value, Atom):
                return GVal(value.name) if t == "GVAL" else LVal(value.name)
            if t in ("FORM", "LIST") and isinstance(value, MList):
                return MList(t, value.head, value.span)
            raise MdlError(f"CHTYPE {value!r} {t}")

        @sub("MAKE-GVAL")
        def _make_gval(value: object) -> object:
            if isinstance(value, Atom):
                return GVal(value.name)
            raise MdlError("MAKE-GVAL of a non-atom")

        @sub("SPNAME")
        def _spname(atom: object) -> object:
            if isinstance(atom, Atom):
                return MString(atom.name)
            raise MdlError(f"SPNAME of {atom!r}")

        @sub("PARSE")
        def _parse(text: object) -> object:
            if not isinstance(text, MString):
                raise MdlError("PARSE of a non-string")
            parsed = from_ast(ZSymbol(text.text, Span(0, 0, 0, 0)))
            return parsed

        @sub("ASCII")
        def _ascii(value: object) -> object:
            # 文字なら文字コード、数なら文字 (例: Moonmist の TELL の <PRINTC <ASCII .E>>)
            if isinstance(value, Char):
                return ord(value.ch)
            if isinstance(value, int) and 0 <= value < 0x110000:
                return Char(chr(value))
            raise MdlError(f"ASCII of {value!r}")

        @sub("STRING")
        def _string(*parts: object) -> object:
            out = []
            for part in parts:
                if isinstance(part, MString):
                    out.append(part.text)
                elif isinstance(part, Char):
                    out.append(part.ch)
                else:
                    raise MdlError(f"STRING of {part!r}")
            return MString("".join(out))

        def same(a: object, b: object) -> bool:
            if isinstance(a, MList) and isinstance(b, MList):
                return a.head is b.head and a.kind == b.kind
            return a == b and type(a) is type(b)

        def equal(a: object, b: object) -> bool:
            if isinstance(a, MList) and isinstance(b, MList):
                return a.kind == b.kind and len(a) == len(b) and all(
                    equal(x, y) for x, y in zip(a.items(), b.items())
                )
            return same(a, b)

        @sub("==?")
        def _eq(a: object, b: object) -> object:
            return Atom("T") if same(a, b) else FALSE

        @sub("N==?")
        def _neq(a: object, b: object) -> object:
            return FALSE if same(a, b) else Atom("T")

        @sub("=?", "EQUAL?")
        def _equal(a: object, *others: object) -> object:
            return Atom("T") if any(equal(a, b) for b in others) else FALSE

        @sub("N=?")
        def _nequal(a: object, b: object) -> object:
            return FALSE if equal(a, b) else Atom("T")

        @sub("NOT")
        def _not(value: object) -> object:
            return FALSE if truthy(value) else Atom("T")

        def numbers(*values: object) -> list[int]:
            if not all(isinstance(v, int) for v in values):
                raise MdlError("arithmetic on a non-number")
            return list(values)  # type: ignore[arg-type]

        @sub("L?")
        def _lt(a: object, b: object) -> object:
            x, y = numbers(a, b)
            return Atom("T") if x < y else FALSE

        @sub("G?")
        def _gt(a: object, b: object) -> object:
            x, y = numbers(a, b)
            return Atom("T") if x > y else FALSE

        @sub("+")
        def _add(*values: object) -> object:
            return sum(numbers(*values))

        @sub("-")
        def _sub(first: object, *rest: object) -> object:
            values = numbers(first, *rest)
            return -values[0] if not rest else values[0] - sum(values[1:])

        type_names = {
            "ATOM": lambda v: isinstance(v, Atom),
            "FIX": lambda v: isinstance(v, int),
            "STRING": lambda v: isinstance(v, MString),
            "ZSTRING": lambda v: False,
            "CHARACTER": lambda v: isinstance(v, Char),
            "LIST": lambda v: isinstance(v, MList) and v.kind == "LIST",
            # MDL では ,X・.X・'X もフォーム (<GVAL X>・<LVAL X>・<QUOTE X>)
            "FORM": lambda v: (isinstance(v, MList) and v.kind == "FORM") or isinstance(v, (LVal, GVal, Quote)),
            "LVAL": lambda v: isinstance(v, LVal),
            "GVAL": lambda v: isinstance(v, GVal),
            "FALSE": lambda v: v is FALSE,
        }

        @sub("TYPE?")
        def _type_p(value: object, *kinds: object) -> object:
            if isinstance(value, Opaque):
                raise MdlError("TYPE? of a value the evaluator does not know")
            for kind in kinds:
                if not isinstance(kind, Atom):
                    raise MdlError("TYPE? with a non-atom")
                test = type_names.get(kind.name.upper())
                if test is None:
                    raise MdlError(f"TYPE? {kind.name} is not supported")
                if test(value):
                    return kind
            return FALSE

        @sub("ERROR")
        def _error(*values: object) -> object:
            raise MdlError("ERROR " + " ".join(repr(v) for v in values))


def _seq(struct: object) -> list[object]:
    if isinstance(struct, MList):
        return list(struct.items())
    if isinstance(struct, MString):
        return [Char(c) for c in struct.text]
    if struct is FALSE:
        return []
    if isinstance(struct, (GVal, LVal)):
        # MDL では ,X は <GVAL X>、.X は <LVAL X> のフォーム (TYPE? の FORM も真になる)。
        # 例: Moonmist の TELL マクロは <NTH .E 1> で、引数が 'X (QUOTE) かを調べる
        return [Atom("GVAL" if isinstance(struct, GVal) else "LVAL"), Atom(struct.name)]
    if isinstance(struct, Quote):
        return [Atom("QUOTE"), struct.value]  # 'X は <QUOTE X>
    raise MdlError(f"{struct!r} is not a structure")


def _nth(struct: object, n: int) -> object:
    items = _seq(struct)
    if not 1 <= n <= len(items):
        raise MdlError(f"NTH {n} out of range")
    return items[n - 1]


def _parse_params(params: object) -> list[Param]:
    """関数の引数リスト (評価前の LIST) を解釈する。"""
    if not (isinstance(params, MList) and params.kind == "LIST"):
        raise MdlError("argument list is not a list")
    out: list[Param] = []
    section = "req"
    for item in params.items():
        if isinstance(item, MString):
            marker = item.text.upper()
            if marker in AUX_MARKERS:
                section = "aux"
            elif marker in OPTIONAL_MARKERS:
                section = "opt"
            elif marker == "ARGS":
                section = "args"
            elif marker == "TUPLE":
                section = "tuple"
            else:
                raise MdlError(f'"{item.text}" in an argument list is not supported')
            continue
        default: object | None = None
        target = item
        if isinstance(item, MList) and item.kind == "LIST":
            parts = list(item.items())
            if not parts:
                raise MdlError("empty argument")
            target = parts[0]
            if len(parts) > 1:
                default = parts[1]
        quoted = isinstance(target, Quote)
        if quoted:
            target = target.value  # type: ignore[union-attr]
        if not isinstance(target, Atom):
            raise MdlError(f"bad argument {target!r}")
        out.append(Param(target.name, section, quoted, default))
    return out
