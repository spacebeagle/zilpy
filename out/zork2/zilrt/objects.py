"""オブジェクト・フラグ・プロパティ・方向。

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


class ZObject(dict):
    """ZIL のオブジェクト (部屋を含む)。プロパティを辞書として保持する。

    Attributes:
        name: ZIL 上のオブジェクト名。
        parent: 親 (含まれている場所) のオブジェクト。ない場合は None。
        children: 子オブジェクトのリスト (先頭が FIRST? で得られる)。
    """

    def __init__(self, name: str, props: dict[str, Any]) -> None:
        """ZObject を初期化する。

        Args:
            name: ZIL 上のオブジェクト名。
            props: プロパティ名と値の辞書。
        """
        super().__init__(props)
        self.name = name
        self.parent: ZObject | None = None
        self.children: list[ZObject] = []

    # 内容ではなく同一性で比較する (EQUAL? はオブジェクト番号の比較)
    __eq__ = object.__eq__
    __ne__ = object.__ne__
    __hash__ = object.__hash__

    def __bool__(self) -> bool:
        """プロパティがなくても真として扱う。

        Returns:
            常に True。
        """
        return True

    def __repr__(self) -> str:
        """オブジェクト名を返す。

        Returns:
            `<NAME>` 形式の文字列。
        """
        return f"<{self.name}>"


def _init_object(obj: ZObject, props: dict[str, Any]) -> None:
    """生成済みのオブジェクトにプロパティを設定して登録する。

    Args:
        obj: 対象のオブジェクト。
        props: プロパティ名と値の辞書。IN (または LOC) は親、FLAGS はフラグ。
    """
    obj.update(props)
    for name, value in props.items():
        if isinstance(value, Table):
            # (OBJDESCS <PLTABLE ...>) のように値がテーブルのプロパティは、Z-machine では
            # テーブルの番地を 1 ワードで持つ。GETP がテーブルそのものを返すよう、
            # 「テーブルを指す 1 ワード」のプロパティにする (例: Suspended の OBJDESCS)
            obj[name] = Table.of((value,))
    if "SYNONYM" in obj or "ADJECTIVE" in obj:
        # 名詞と形容詞を辞書に登録し、プロパティを単語・番号のテーブルにする
        names = obj.get("SYNONYM", ())
        adjectives = obj.get("ADJECTIVE", ())
        nouns, numbers = _register_object_words(
            names if isinstance(names, tuple) else (names,),
            adjectives if isinstance(adjectives, tuple) else (adjectives,),
        )
        if "SYNONYM" in obj:
            obj["SYNONYM"] = nouns
        if "ADJECTIVE" in obj:
            obj["ADJECTIVE"] = numbers
    if "PSEUDO" in obj:
        # PSEUDO は「単語, ルーチン」の組の並び。ZILCH は文字列を名詞として辞書に
        # 登録し、プロパティには単語を置く (GLOBAL-CHECK が P-NAM と比べる)
        pairs = obj["PSEUDO"]
        pairs = list(pairs if isinstance(pairs, tuple) else (pairs,))
        for index in range(0, len(pairs), 2):
            if isinstance(pairs[index], str) and not isinstance(pairs[index], Word):
                word = _word(pairs[index])
                word.parts.setdefault(PS_OBJECT, 0)
                pairs[index] = word
        obj["PSEUDO"] = tuple(pairs)
    if "GLOBAL" in obj:
        # GLOBAL は共有オブジェクトを 1 バイトずつ並べたテーブル。ただしオブジェクトを
        # ワードで持つ配置 (UEXIT = 2。Trinity・AMFV) では、パーサーが GET/B (= GET) と
        # PTSIZE / 2 で読むので、1 ワードずつ並べる
        shared = obj["GLOBAL"]
        obj["GLOBAL"] = Table.of(
            shared if isinstance(shared, tuple) else (shared,), byte=not _wide_exits()
        )
    flags = obj.get("FLAGS", ())
    obj["FLAGS"] = set(flags if isinstance(flags, tuple) else (flags,))
    # IN は親でもあり方向でもある。オブジェクトなら親、それ以外なら出口
    parent = obj.pop("LOC", None)
    if isinstance(obj.get("IN"), ZObject):
        parent = obj.pop("IN")
    ctx = get_context()
    for name in ctx.dictionary.direction_names:
        if name in obj:
            obj[name] = _encode_exit(obj[name])
    if isinstance(parent, ZObject):
        MOVE(obj, parent)
    ctx.world.objects.append(obj)


def OBJECT(name: str, props: dict[str, Any]) -> ZObject:
    """オブジェクトを生成して登録する (<OBJECT ...> / <ROOM ...>)。

    Args:
        name: ZIL 上のオブジェクト名。
        props: プロパティ名と値の辞書。IN (または LOC) は親、FLAGS はフラグ。

    Returns:
        生成したオブジェクト。
    """
    obj = ZObject(name, {})
    _init_object(obj, props)
    return obj


ROOM = OBJECT


def LOC(obj: ZObject) -> ZObject | bool:
    """オブジェクトの親 (場所) を返す。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        親のオブジェクト。ない場合と、obj がオブジェクト 0 (<> や 0) の場合は False。
        obj がオブジェクトでない場合 (方向など) も False。
    """
    if obj is None or (isinstance(obj, int) and obj == 0):
        # Z-machine のインタプリタはオブジェクト 0 の親を 0 として返す
        # (例: Enchanter で「it」がまだ何も指していないときの `examine it`)
        return False
    if not isinstance(obj, ZObject):
        # ZIL では方向も番号なので LOC をかけても落ちない。Trinity の PERFORM は
        # 泡や膜をまとったときの判定で、歩く方向 (PRSO) に LOC をかける
        return False
    return obj.parent or False


# 物体でない値 (偽、0、物体の番号など) を物体として渡されたことを知らせた命令の名前
_warned_not_object: set[str] = set()


def _not_object(value: Any, op: str) -> bool:
    """value が物体でなければ True を返す (初回だけ標準エラー出力に知らせる)。

    Z-machine のインタプリタは、物体 0 などへの命令を止めずに 0 や偽として扱う
    (ZilRuntime.lua も同じ)。元のゲームにも、何も指していない変数 (偽) や物体の番号
    (例: Trinity の MOBY-FIND は物体を 1 から LAST-OBJECT まで番号で数える) を
    物体の命令に渡す所があるので、止めずに「物体 0」として扱う。ゲームの出力には
    混ぜず、変換のバグを見落とさないよう標準エラー出力にだけ知らせる。

    Args:
        value: 物体として渡された値。
        op: 命令の名前。

    Returns:
        物体でなければ True。
    """
    if isinstance(value, ZObject):
        return False
    if op not in _warned_not_object:
        _warned_not_object.add(op)
        print(f"ZilPy: {op} on a non-object {value!r} (treated as object 0)", file=_sys.stderr)
    return True


def IN_p(obj: ZObject, container: ZObject) -> bool:
    """オブジェクトが直接 container の中にあるかを判定する。

    Args:
        obj: 対象のオブジェクト。
        container: 親として調べるオブジェクト。

    Returns:
        直接含まれていれば True。
    """
    return isinstance(obj, ZObject) and obj.parent is container


def FIRST_p(obj: ZObject) -> ZObject | bool:
    """最初の子オブジェクトを返す。

    Args:
        obj: 親のオブジェクト。

    Returns:
        最初の子。子がない場合と、obj が物体でない場合は False。
    """
    if _not_object(obj, "FIRST?"):
        return False
    return obj.children[0] if obj.children else False


def NEXT_p(obj: ZObject) -> ZObject | bool:
    """次の兄弟オブジェクトを返す。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        次の兄弟。ない場合と、obj が物体でない場合は False。
    """
    if _not_object(obj, "NEXT?") or obj.parent is None:
        return False
    siblings = obj.parent.children
    index = siblings.index(obj) + 1
    return siblings[index] if index < len(siblings) else False


def REMOVE(obj: ZObject) -> bool:
    """オブジェクトを親から取り除く。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        常に True。obj が物体でない場合は、何もせず False。
    """
    if _not_object(obj, "REMOVE"):
        return False
    if obj.parent is not None:
        obj.parent.children.remove(obj)
        obj.parent = None
    return True


def MOVE(obj: ZObject, dest: ZObject) -> bool:
    """オブジェクトを dest の最初の子として移動する。

    Args:
        obj: 移動するオブジェクト。
        dest: 移動先のオブジェクト。

    Returns:
        常に True。obj が物体でない場合は、何もせず False。dest が物体でない
        場合は、obj を親から取り除くだけ (ZilRuntime.lua と同じ)。
    """
    if _not_object(obj, "MOVE"):
        return False
    REMOVE(obj)
    if _not_object(dest, "MOVE"):
        return True
    dest.children.insert(0, obj)
    obj.parent = dest
    return True


def FSET(obj: ZObject, flag: Any) -> bool:
    """フラグを立てる。

    Args:
        obj: 対象のオブジェクト。
        flag: フラグ。

    Returns:
        常に True。obj が物体でない場合は、何もせず False。
    """
    if _not_object(obj, "FSET"):
        return False
    obj["FLAGS"].add(flag)
    return True


def FCLEAR(obj: ZObject, flag: Any) -> bool:
    """フラグを下ろす。

    Args:
        obj: 対象のオブジェクト。
        flag: フラグ。

    Returns:
        常に True。obj が物体でない場合は、何もせず False。
    """
    if _not_object(obj, "FCLEAR"):
        return False
    obj["FLAGS"].discard(flag)
    return True


def FSET_p(obj: ZObject, flag: Any) -> bool:
    """フラグが立っているかを判定する。

    Args:
        obj: 対象のオブジェクト。
        flag: フラグ。

    Returns:
        フラグが立っていれば True。
    """
    return isinstance(obj, ZObject) and flag in obj["FLAGS"]


def PROPDEF(prop: str, default: Any) -> bool:
    """プロパティの既定値を宣言する。

    Args:
        prop: プロパティ名。
        default: プロパティがない場合に GETP が返す値。

    Returns:
        常に True。
    """
    get_context().world.property_defaults[prop] = default
    return True


def GETP(obj: ZObject, prop: str) -> Any:
    """プロパティの値を返す。

    Args:
        obj: 対象のオブジェクト。
        prop: プロパティ名。

    Returns:
        プロパティの値。ない場合は PROPDEF の既定値 (未宣言なら 0)。
        obj が物体でない場合は 0。
    """
    if _not_object(obj, "GETP"):
        return 0
    if prop not in obj:
        return get_context().world.property_defaults.get(prop, 0)
    value = obj[prop]
    if isinstance(value, Table):
        return GET(value, 0)
    if isinstance(value, tuple):
        return value[0]
    return value


def PUTP(obj: ZObject, prop: str, value: Any) -> bool:
    """プロパティの値を書き換える。

    Args:
        obj: 対象のオブジェクト。
        prop: プロパティ名。
        value: 新しい値。

    Returns:
        常に True。obj が物体でない場合は、何もせず False。
    """
    if _not_object(obj, "PUTP"):
        return False
    if isinstance(obj.get(prop), Table):
        PUT(obj[prop], 0, value)
    elif isinstance(value, Table):
        # テーブルを指す値は、それを 1 ワードで持つプロパティのテーブルにする
        # (_init_object と同じ形。そのまま入れると、プロパティのテーブル自体と区別できず、
        # GETP がテーブルの先頭のワードを返してしまう。例: Spellbreaker のキューブの NAME)
        obj[prop] = Table.of((value,))
    else:
        obj[prop] = value
    return True


def GETPT(obj: ZObject, prop: str) -> "Table | bool":
    """プロパティの値をテーブルとして返す (書き換えはオブジェクトに反映される)。

    Args:
        obj: 対象のオブジェクト。
        prop: プロパティ名。

    Returns:
        プロパティのテーブル。プロパティがない場合と、obj が物体でない場合は False。
    """
    if _not_object(obj, "GETPT") or prop not in obj:
        return False
    value = obj[prop]
    if not isinstance(value, Table):
        value = Table.of(value if isinstance(value, tuple) else (value,))
        obj[prop] = value
    value.owner = obj
    return value


def PTSIZE(table: "Table") -> int:
    """プロパティテーブルのバイト数を返す。

    Args:
        table: GETPT で得たテーブル。

    Returns:
        バイト数。
    """
    return table.size()


class _LowDirection:
    """最小の方向プロパティ番号 (LOW-DIRECTION)。

    プロパティ名を文字列で扱うので、番号との大小比較は「方向のプロパティか」
    に置き換える。方向は最大の番号を持つプロパティなので、`P >= LOW-DIRECTION`
    は P が方向であることを表す。
    """

    @staticmethod
    def _is_direction(prop: Any) -> bool:
        """プロパティが方向かを判定する。

        Args:
            prop: プロパティ名。

        Returns:
            方向であれば True。
        """
        return isinstance(prop, str) and prop in get_context().dictionary.direction_names

    def __gt__(self, prop: Any) -> bool:
        """`LOW-DIRECTION > prop`、つまり prop が方向でないかを返す。"""
        return not self._is_direction(prop)

    def __ge__(self, prop: Any) -> bool:
        """`LOW-DIRECTION >= prop`、つまり prop が方向でないかを返す。"""
        return not self._is_direction(prop)

    def __lt__(self, prop: Any) -> bool:
        """`LOW-DIRECTION < prop`、つまり prop が方向かを返す。"""
        return self._is_direction(prop)

    def __le__(self, prop: Any) -> bool:
        """`LOW-DIRECTION <= prop`、つまり prop が方向かを返す。"""
        return self._is_direction(prop)

    def __rsub__(self, prop: Any) -> int:
        """`<- 方向 ,LOW-DIRECTION>`、つまり方向ごとの表の添字を返す。

        Z-machine では、DIRECTIONS で最初に宣言した方向に最大のプロパティ番号が
        振られ、最後の方向が LOW-DIRECTION になる。そのため最後の方向が 0、
        最初の方向が「方向の数 - 1」になる (例: Planetfall の C-MOVE の表は
        OUT, IN, DOWN, UP, ... NORTH の順に並んでいる)。

        Args:
            prop: 方向のプロパティ名。

        Returns:
            表の添字。

        Raises:
            ZilError: 方向でない場合。
        """
        if not self._is_direction(prop):
            raise ZilError(f"{prop!r} is not a direction")
        dir_names = get_context().dictionary.direction_names
        return len(dir_names) - 1 - dir_names.index(prop)


LOW_DIRECTION = _LowDirection()


def _direction_number(prop: Any) -> int | None:
    """方向のプロパティ番号を返す (Z-machine と同じく、最初に宣言した方向が最大)。

    Args:
        prop: 方向のプロパティ名 (例: 'NORTH')。

    Returns:
        番号。方向でなければ None。
    """
    dir_names = get_context().dictionary.direction_names
    if isinstance(prop, str) and prop in dir_names:
        return MAX_PROPERTY_NUMBER - dir_names.index(prop)
    return None


class Direction(str):
    """パーサーが PRSO に入れる方向 (プロパティ名の文字列)。

    文字列としてはプロパティ名と等しい (GETP や == はそのまま使える) が、大小比較と
    引き算は方向のプロパティ番号で行う。ZIL では方向は番号なので、
    `<G? ,PRSO ,P?UP>` や `<- ,PRSO ,P?UP>` で方向ごとの表を引くことがある
    (例: Enchanter の半透明の迷路 TMAZE-F。NW - UP = 1、NORTH - UP = 8)。
    """

    def _numbers(self, other: Any) -> tuple[int, int] | None:
        mine = _direction_number(str.__str__(self))
        theirs = other if isinstance(other, int) else _direction_number(other)
        if mine is None or theirs is None:
            return None
        return mine, theirs

    def __lt__(self, other: Any) -> bool:
        pair = self._numbers(other)
        return str.__lt__(self, other) if pair is None else pair[0] < pair[1]

    def __le__(self, other: Any) -> bool:
        pair = self._numbers(other)
        return str.__le__(self, other) if pair is None else pair[0] <= pair[1]

    def __gt__(self, other: Any) -> bool:
        pair = self._numbers(other)
        return str.__gt__(self, other) if pair is None else pair[0] > pair[1]

    def __ge__(self, other: Any) -> bool:
        pair = self._numbers(other)
        return str.__ge__(self, other) if pair is None else pair[0] >= pair[1]

    def __sub__(self, other: Any) -> Any:
        pair = self._numbers(other)
        if pair is None:
            return NotImplemented  # LOW-DIRECTION などは相手側 (__rsub__) で扱う
        return pair[0] - pair[1]

    __hash__ = str.__hash__
    __eq__ = str.__eq__


class Flag(str):
    """フラグ名を表す文字列。`<- ,WEARBIT>` のような負符号や `> 0` 比較に対応する。"""

    def __neg__(self) -> "Flag":
        return Flag(self[1:] if self.startswith("-") else f"-{self}")

    def __gt__(self, other: Any) -> bool:
        if other == 0:
            return not self.startswith("-")
        return super().__gt__(other)

    def __lt__(self, other: Any) -> bool:
        if other == 0:
            return self.startswith("-")
        return super().__lt__(other)

    __hash__ = str.__hash__
    __eq__ = str.__eq__


def NEXTP(obj: ZObject, prop: str | int) -> str | int:
    """次のプロパティ名を返す。

    Args:
        obj: 対象のオブジェクト。
        prop: 現在のプロパティ名。0 の場合は最初のプロパティを返す。

    Returns:
        次のプロパティ名。ない場合は 0。
    """
    # Z-machine はプロパティを番号の大きい順に並べる。方向は最大の番号を持つので先頭に、
    # 最初に宣言した方向から順に来る (例: Enchanter の ADVENTURER-DECIDE は、方向でない
    # プロパティが出たところで出口を探すのをやめる)。LOC (オブジェクトの木)、DESC (短い名前)、
    # FLAGS (属性) はプロパティではないので含めない
    dir_names = get_context().dictionary.direction_names
    props = [name for name in obj if name not in ("FLAGS", "LOC", "DESC")]
    directions = sorted(
        (name for name in props if name in dir_names), key=dir_names.index
    )
    names = directions + [name for name in props if name not in dir_names]
    if prop == 0:
        return names[0] if names else 0
    index = names.index(prop) + 1 if prop in names else len(names)
    return names[index] if index < len(names) else 0


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    MAX_PROPERTY_NUMBER,
    ZilError,
    get_context,
)
from .exits import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _encode_exit,
    _wide_exits,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    GET,
    PUT,
    Table,
)
from .vocab import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    PS_OBJECT,
    Word,
    _register_object_words,
    _word,
)
