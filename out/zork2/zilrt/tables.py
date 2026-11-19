"""テーブル (TABLE・LTABLE・ITABLE、GET・PUT など) とヘッダー、Z 文字。

refactor-plan.md Phase 5 で ZilRuntime.py から分けた。
"""


from __future__ import annotations


# ruff: noqa: F401


import contextlib as _contextlib
import contextvars as _contextvars
import dataclasses as _dataclasses
import io as _io
import keyword as _keyword
import os as _os
import pickle as _pickle
import re as _re
import tempfile as _tempfile
import types as _types
from pathlib import Path as _Path
import random as _random
import sys as _sys
from collections.abc import Callable, Iterator, Sequence
from typing import Any


class TBYTE:
    """テーブルの宣言で `#BYTE` の付いた要素 (その要素だけ 1 バイトで格納する)。

    Attributes:
        value: 値。1 文字の文字列 (!\\x などの文字リテラル) は文字コードにする。
    """

    def __init__(self, value: Any) -> None:
        """TBYTE を初期化する。

        Args:
            value: 要素の値。
        """
        if isinstance(value, str) and len(value) == 1:
            value = ord(value)  # 入力バッファ (READ) と同じく文字コードで持つ
        self.value = value


class Table:
    """バイト単位で位置を指定する ZIL のテーブル。

    ワード (2 バイト) の値はその先頭バイトの位置に格納し、続く 1 バイトは
    None で埋める。REST で作ったテーブルは元のテーブルと内容を共有する。

    Attributes:
        cells: バイト位置ごとの値。
        offset: このテーブルの先頭のバイト位置。
        owner: GETPT で得たプロパティのテーブルなら、その持ち主のオブジェクト。
            先頭より前 (オブジェクトの短い名前) への書き込みを扱うために使う。
    """

    owner: "ZObject | None" = None  # 古いセーブデータ (属性なし) でも読めるように

    def __init__(
        self, cells: list[Any], offset: int = 0, owner: "ZObject | None" = None
    ) -> None:
        """Table を初期化する。

        Args:
            cells: バイト位置ごとの値 (他のテーブルと共有してよい)。
            offset: 先頭のバイト位置。
            owner: プロパティのテーブルなら、その持ち主のオブジェクト。
        """
        self.cells = cells
        self.offset = offset
        self.owner = owner

    def _address(self, other: Any) -> tuple[int, int]:
        """アドレスの大小比較のため、(表の識別, 先頭のバイト位置) の組を返す。

        同じ表を REST で進めたテーブルどうしは、先頭のバイト位置で比べられる
        (例: Spellbreaker の QUEUE の `<G? .INT ,CLOCK-HAND>`)。

        Args:
            other: 比べる相手のテーブル。

        Returns:
            (自分の組, 相手の組)。
        """
        if other is False or (isinstance(other, int) and other == 0):
            # アドレス 0 (または偽) との比較。どのテーブルのアドレスもそれより大きい
            # (例: Trinity の QUEUE は、動作中の割り込みがないとき CLOCK-HAND が偽)
            return (id(self.cells), self.offset), (0, 0)
        if not isinstance(other, Table):
            raise ZilError(f"cannot compare a table with {other!r}")
        return (id(self.cells), self.offset), (id(other.cells), other.offset)

    def __lt__(self, other: Any) -> bool:
        mine, theirs = self._address(other)
        return mine < theirs

    def __le__(self, other: Any) -> bool:
        mine, theirs = self._address(other)
        return mine <= theirs

    def __gt__(self, other: Any) -> bool:
        mine, theirs = self._address(other)
        return mine > theirs

    def __ge__(self, other: Any) -> bool:
        mine, theirs = self._address(other)
        return mine >= theirs

    @classmethod
    def of(cls, items: Sequence[Any], byte: bool = False) -> "Table":
        """値の並びからテーブルを生成する。

        Args:
            items: 要素の値。
            byte: True ならバイト、False ならワードの並びとして格納する。

        Returns:
            生成したテーブル。
        """
        cells: list[Any] = []
        for item in items:
            if isinstance(item, TBYTE):
                cells.append(item.value)  # #BYTE の付いた要素は 1 バイトだけ使う
            else:
                cells += [item] if byte else [item, None]
        return cls(cells)

    def read(self, pos: int) -> Any:
        """バイト位置 pos の値を返す。

        Args:
            pos: テーブル先頭からのバイト位置。

        Returns:
            格納されている値 (未設定なら 0)。

        Raises:
            ZilError: 範囲外の位置を指定した場合。
        """
        try:
            value = self.cells[self.offset + pos]
        except IndexError:
            raise ZilError(f"table index {pos} out of range") from None
        return 0 if value is None else value

    def write(self, pos: int, value: Any, word: bool) -> None:
        """バイト位置 pos に値を書き込む。

        Args:
            pos: テーブル先頭からのバイト位置。
            value: 書き込む値。
            word: True ならワードとして書き込み、次のバイトを None にする。

        末尾を少しだけ越えた書き込み (TABLE_OVERRUN_BYTES まで) は、テーブルを
        広げて受け入れる。元のゲームには要素数を超えて書き込む箇所があり
        (例: Hitchhiker's Guide の 5 要素の FORD-TABLE への <PUT ,FORD-TABLE 5 ...>)、
        Z-machine ではテーブルの直後のメモリに書き込まれ、後で同じ位置を読めば
        値が返る。その動きを再現するため。

        プロパティのテーブルの先頭より前に、辞書の単語の文字 (GET で単語から
        読んだ _WordText) をワードで書き込んだ場合は、オブジェクトの短い名前
        (DESC) の書き換えとして扱う (_write_short_name を参照)。

        Raises:
            ZilError: 先頭より前、または末尾を大きく越えた位置を指定した場合。
        """
        index = self.offset + pos
        end = index + (2 if word else 1)
        if index < 0 and word and self.owner is not None and isinstance(value, _WordText):
            _write_short_name(self.owner, index, value)
            return
        if index < 0 or end > len(self.cells) + TABLE_OVERRUN_BYTES:
            raise ZilError(f"table index {pos} out of range")
        if end > len(self.cells):
            self.cells.extend([None] * (end - len(self.cells)))
        self.cells[index] = value
        if word:
            self.cells[index + 1] = None

    def size(self) -> int:
        """テーブル先頭から末尾までのバイト数を返す。

        Returns:
            バイト数。
        """
        return len(self.cells) - self.offset

    def __eq__(self, other: object) -> bool:
        """同じ内容の同じ位置を指しているかを判定する (ZIL の ==? はアドレスの比較)。

        REST は毎回新しい Table を返すので、同一オブジェクトかどうかではなく、
        内容 (cells) を共有していて先頭位置が等しいかで比較する。

        Args:
            other: 比較対象。

        Returns:
            同じ位置を指していれば True。
        """
        return (
            isinstance(other, Table)
            and self.cells is other.cells
            and self.offset == other.offset
        )

    def __hash__(self) -> int:
        """`__eq__` と整合するハッシュ値を返す。

        Returns:
            内容の同一性と先頭位置から求めたハッシュ値。
        """
        return hash((id(self.cells), self.offset))

    def __repr__(self) -> str:
        """テーブルの内容を表す文字列を返す。

        Returns:
            `Table([...])` 形式の文字列。
        """
        return f"Table({self.cells[self.offset:]!r})"


def _split_table_flags(items: tuple[Any, ...]) -> tuple[set[str], tuple[Any, ...]]:
    """テーブル宣言の先頭にあるフラグ (例: ('PURE',)) を取り出す。

    Args:
        items: テーブル宣言の引数。

    Returns:
        (フラグの集合, 残りの引数)。
    """
    if (
        items
        and isinstance(items[0], tuple)
        and items[0]
        and all(flag in TABLE_FLAGS for flag in items[0])
    ):
        return set(items[0]), items[1:]
    return set(), items


def _expand_string_table(values: tuple[Any, ...]) -> tuple[Any, ...]:
    """STRING フラグ付きテーブルの文字列要素を ASCII バイト列へ展開する。"""
    expanded: list[Any] = []
    for item in values:
        if isinstance(item, str):
            expanded.extend(ord(ch) for ch in item)
        else:
            expanded.append(item)
    return tuple(expanded)


def TABLE(*items: Any) -> Table:
    """テーブルを生成する (<TABLE (flags) values...>)。

    Args:
        items: 要素の値。先頭にフラグのタプルを置ける ('BYTE' でバイト単位)。

    Returns:
        生成したテーブル。
    """
    flags, values = _split_table_flags(items)
    is_string = "STRING" in flags
    if is_string:
        values = _expand_string_table(values)
    if "LENGTH" in flags:
        values = (len(values), *values)
    return Table.of(values, byte=("BYTE" in flags or is_string))


PTABLE = TABLE


def LTABLE(*items: Any) -> Table:
    """先頭に要素数を持つテーブルを生成する (<LTABLE (flags) values...>)。

    Args:
        items: 要素の値。先頭にフラグのタプルを置ける。

    Returns:
        生成したテーブル。
    """
    flags, values = _split_table_flags(items)
    is_string = "STRING" in flags
    if is_string:
        values = _expand_string_table(values)
    return Table.of((len(values), *values), byte=("BYTE" in flags or is_string))


PLTABLE = LTABLE


def ITABLE(*items: Any) -> Table:
    """指定した数だけ初期値を繰り返したテーブルを生成する。

    例: ITABLE(59, ('LEXV',), 0, 0, 0)、ITABLE(120, ('BYTE', 'LENGTH'), 0)。

    Args:
        items: 要素数 (前に 'BYTE' などの種別を置ける)、フラグのタプル、
            繰り返す初期値の並び。

    Returns:
        生成したテーブル。
    """
    rest = list(items)
    flags: set[str] = set()
    specifier = rest.pop(0) if rest and isinstance(rest[0], str) else None
    count = rest.pop(0) if rest else 0
    extra, pattern = _split_table_flags(tuple(rest))
    flags |= extra
    cells: list[Any] = []
    if specifier in ("BYTE", "WORD"):
        # <ITABLE BYTE n> / <ITABLE WORD n>: 先頭に要素数を持ち、要素はワード。
        # (READ のバッファ用で、先頭バイトが最大の文字数・単語数になる)
        cells += [count] if specifier == "BYTE" else [count, None]
        cells += Table.of(pattern or (0,), byte=False).cells * count
        return Table(cells)
    if specifier is not None:
        flags.add(specifier)  # <ITABLE NONE 10> など
    byte = "BYTE" in flags
    if "LENGTH" in flags:
        cells += [count] if byte else [count, None]
    if "LEXV" in flags:
        # 1 エントリ = 単語 (ワード) + 文字数 (バイト) + 位置 (バイト)
        cells += [0, None, 0, 0] * count
    else:
        unit = Table.of(pattern or (0,), byte=byte).cells
        cells += unit * count
    return Table(cells)


# FLAGS1 (バイト 1) の bit 1: ステータス行にスコアではなく時刻を出す (V3。<VERSION ZIP TIME>)
_FLAGS1_TIME_GAME = 2


def _flags1(version: Sequence[Any]) -> int:
    """<VERSION ...> の引数から、ヘッダーのバイト 1 (FLAGS1) の値を求める。

    `('ZIP', 'TIME')` なら 2 (bit 1)。bit 1 が時刻の意味なのは V3 (ZIP) だけ。
    bit 4 (ステータス行を出せない) は 0 にする (ZilPy はステータス行を出す)。
    """
    names = {str(arg).upper() for arg in version}
    v3 = not names & {"EZIP", "XZIP", "YZIP", "4", "5", "6"}
    return _FLAGS1_TIME_GAME if v3 and "TIME" in names else 0


def _make_header(version: Sequence[Any] = ()) -> Table:
    """Z-machine のヘッダー (メモリのアドレス 0) を模したテーブルを作る。

    バイト 1 に FLAGS1、ワード 1 にリリース番号、バイト 18〜23 にシリアル番号 (ASCII) を格納する。

    バイト 0 (バージョン番号) は 0 のままにする。ヘッダーはセルの並びなので、`<GET 0 0>` は
    バイト 0 の値をそのまま返す。Planetfall などのパーサーは、空のポインタ (0) から `<GET 0 0>` で
    単語を読み、その値をまたアドレスとして使う。ZilPy は 0 以外の数値のアドレスを扱えないので、
    ここに版番号を入れると、その読み取りが失敗する (refactor-ZILFReferenceGuide-plan.md §1.1)。

    Args:
        version: 作品の <VERSION ...> の引数 (例: ('ZIP', 'TIME'))。

    Returns:
        ヘッダーのテーブル。
    """
    table = Table([0] * 64)
    table.write(1, _flags1(version), word=False)
    table.write(2, RELEASE_NUMBER, word=True)
    for pos, ch in enumerate(SERIAL_NUMBER):
        table.write(18 + pos, ord(ch), word=False)
    # バイト 32 が画面の行数、33 が桁数 (Trinity のように画面幅を調べるゲームがある)
    table.write(32, SCREEN_HEIGHT, word=False)
    table.write(33, SCREEN_WIDTH, word=False)
    return table


def _address(table: Any) -> Any:
    """テーブルとして渡された値が数値なら、対応するメモリに置き換える。

    ZIL では <GET 0 8> のようにアドレス 0 で Z-machine のヘッダーを指す。
    ZilPy が再現しているのはヘッダーだけなので、0 以外の数値はエラーにする
    (変数の初期化漏れなどで数値が渡されたとき、黙ってヘッダーを読み書き
    しないようにするため)。

    Args:
        table: GET / PUT / GETB / PUTB に渡されたテーブル。

    Returns:
        数値 0 (False を含む) ならヘッダー、それ以外はそのままの値。

    Raises:
        ZilError: 0 以外の数値の場合。
    """
    if isinstance(table, int):
        if table == 0:
            return get_context().world.header  # アドレス 0 は Z-machine のヘッダー
        raise ZilError(f"memory address {table} is not supported (only 0: the header)")
    return table


def GET(table: Table | Sequence[Any], index: int) -> Any:
    """ワード単位で index 番目の要素を返す。

    Args:
        table: テーブル (またはシーケンス)。
        index: 0 始まりのワード位置。

    Returns:
        要素の値。
    """
    if isinstance(table, Word):
        return _WordText(table, index)  # 辞書エントリの符号化された文字
    table = _address(table)
    if isinstance(table, Table):
        return table.read(index * 2)
    return table[index]


def PUT(table: Table, index: int, value: Any) -> bool:
    """ワード単位で index 番目の要素を書き換える。

    Args:
        table: テーブル。
        index: 0 始まりのワード位置。
        value: 新しい値。

    Returns:
        常に True。
    """
    table = _address(table)
    table.write(index * 2, value, word=True)
    return True


def GETB(table: Table | Sequence[Any], index: int) -> Any:
    """バイト単位で index 番目の要素を返す。

    Args:
        table: テーブル (またはシーケンス)。
        index: 0 始まりのバイト位置。

    Returns:
        要素の値。
    """
    if isinstance(table, Word):
        return table.getb(index)  # 辞書エントリの品詞と値
    table = _address(table)
    if isinstance(table, Table):
        return table.read(index)
    return table[index]


def PUTB(table: Table, index: int, value: Any) -> bool:
    """バイト単位で index 番目の要素を書き換える。

    Args:
        table: テーブル。
        index: 0 始まりのバイト位置。
        value: 新しい値。

    Returns:
        常に True。
    """
    table = _address(table)
    table.write(index, value, word=False)
    return True


def REST(table: Table | Sequence[Any], count: int = 1) -> Any:
    """先頭から count バイト (シーケンスなら count 要素) 進めたものを返す。

    Args:
        table: テーブル (またはシーケンス)。
        count: 進める量。

    Returns:
        内容を共有するテーブル (またはスライス)。
    """
    if isinstance(table, Table):
        return Table(table.cells, table.offset + count, table.owner)
    return table[count:]


def BACK(table: Table, count: int = 1) -> Table:
    """先頭を count バイト戻したテーブルを返す。

    Args:
        table: テーブル。
        count: 戻すバイト数。

    Returns:
        内容を共有するテーブル。
    """
    return Table(table.cells, table.offset - count, table.owner)


class _WordText:
    """辞書の単語の、符号化された文字のワード (<GET 単語 n>) を表す。

    Z-machine の辞書エントリの先頭 4 バイトは、単語の文字を Z 文字で符号化した
    2 ワードで、1 ワードに 3 文字が入る。パーサーはこれをオブジェクトの短い名前へ
    書き写して、擬似オブジェクトの名前を入力した名詞にする (GLOBAL-CHECK の
    <PUT <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5> 0 <GET ,P-NAM 0>>)。

    Attributes:
        word: 元の単語。
        index: 何番目のワードか (0 始まり)。
    """

    def __init__(self, word: "Word", index: int) -> None:
        """_WordText を初期化する。

        Args:
            word: 元の単語。
            index: 何番目のワードか。
        """
        self.word = word
        self.index = index

    def text(self) -> str:
        """このワードに入っている 3 文字を返す (単語が短ければ短くなる)。

        Returns:
            文字列。
        """
        start = self.index * _ZTEXT_CHARS_PER_WORD
        return str.__str__(self.word)[start:start + _ZTEXT_CHARS_PER_WORD]

    def __eq__(self, other: object) -> bool:
        """同じ単語の同じワードと等しいとみなす。

        Args:
            other: 比較対象。

        Returns:
            等しければ True。
        """
        return isinstance(other, _WordText) and self.text() == other.text()

    def __hash__(self) -> int:
        """`__eq__` と整合するハッシュ値を返す。

        Returns:
            文字列から求めたハッシュ値。
        """
        return hash(self.text())


# Z 文字の 1 ワードに入る文字数
_ZTEXT_CHARS_PER_WORD = 3


def _write_short_name(obj: "ZObject", index: int, value: _WordText) -> None:
    """オブジェクトの短い名前 (DESC) の文字のワードを書き換える。

    Z-machine では、プロパティのテーブルの前にオブジェクトの短い名前が
    Z 文字で置かれ、その直後 (最初のプロパティの大きさのバイトの前) で終わる。
    プロパティのデータの先頭を 0 とすると、n ワードの名前の k ワード目は
    バイト位置 -1 - 2n + 2k にある。n は元の DESC の長さで決まり、書き換えても
    変わらない (名前の長さのバイトは書き換えられないため)。

    Args:
        obj: 対象のオブジェクト。
        index: プロパティのデータの先頭からのバイト位置 (負の値)。
        value: 書き込む文字のワード。

    Raises:
        ZilError: 名前の範囲の外を指定した場合。
    """
    chunks: list[str] | None = obj.__dict__.get("short_name_words")
    if chunks is None:
        desc = _describe(obj)
        count = max(1, -(-len(desc) // _ZTEXT_CHARS_PER_WORD))
        chunks = [
            desc[i * _ZTEXT_CHARS_PER_WORD:(i + 1) * _ZTEXT_CHARS_PER_WORD]
            for i in range(count)
        ]
        obj.short_name_words = chunks
    offset = index + 1 + 2 * len(chunks)
    if offset < 0 or offset % 2 or offset // 2 >= len(chunks):
        raise ZilError(f"table index {index} out of range")
    chunks[offset // 2] = value.text()
    obj["DESC"] = "".join(chunks)


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    RELEASE_NUMBER,
    SCREEN_HEIGHT,
    SCREEN_WIDTH,
    SERIAL_NUMBER,
    TABLE_FLAGS,
    TABLE_OVERRUN_BYTES,
    ZilError,
    get_context,
)
from .io import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _describe,
)
from .vocab import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    Word,
)
