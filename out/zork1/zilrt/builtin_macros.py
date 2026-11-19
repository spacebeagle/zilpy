"""共通マクロ (refactor-plan.md §1.8・§2.3。14 作品で同じ意味の DEFMAC だけ)。

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


#
# 14 作品のどこでも同じ意味に定義されている DEFMAC だけを、ランタイムの組み込みとして
# 持つ。変換器 (zilpy/compiletime/builtin_macros.py) は、作品ごとにその作品の DEFMAC を
# 評価器で展開して「正規の展開」と同じ意味かを確かめ、同じときだけこれらを呼ぶ
# (違えば作品の定義を展開する。tests/test_mdl.py の test_builtin_table)。
# 作品ごとに意味の違うマクロ (PROB・DISABLE・TELL など) と、1 作品だけのマクロは、
# 変換器が作品の定義から展開するか関数を作るので、ランタイムには置かない (Phase 4 で削除)。
# RFATAL も共通マクロだが、呼び出し元から return するので、変換器が `return 2` にする。
#
# 引数の扱い: アトムで書かれた引数は、変換器が値 (`,X`) にして渡す。VERB? だけは
# 動詞の名前の文字列で渡り、ここで V?名前 の値にする。名前でない引数 (`<VERB? ,X>`) は、
# MULTIFROB と同じく値のまま比べる。


def VERB_p(*verbs: Any) -> bool:
    """現在の動詞 (PRSA) が、指定した動詞のどれかに等しいか (共通マクロ VERB?)。

    元にした定義: `<DEFMAC VERB? ("ARGS" ATMS) <MULTIFROB PRSA .ATMS>>` (Zork I などの
    gmacros.zil)。正規の展開は「`<EQUAL? ,PRSA ,V?A ,V?B ...>` を 3 つずつ OR でつなぐ」。
    同じ意味と確かめた作品: 14 作品すべて (Deadline・Planetfall・Suspended・Witness は
    "TUPLE" で直接展開する定義、Lurking Horror は `',PRSA` の MULTIFROB)。

    Args:
        verbs: 動詞名の文字列 (例: 'TAKE')、または比べる値そのもの。

    Returns:
        どれかに等しければ True。
    """
    return ZG.PRSA in {SYMBOL(f"V?{verb}") if isinstance(verb, str) else verb for verb in verbs}


def PRSO_p(*objects: Any) -> bool:
    """直接目的語 (PRSO) が、指定した値のどれかに等しいか (共通マクロ PRSO?)。

    元にした定義: `<DEFMAC PRSO? ("ARGS" ATMS) <MULTIFROB PRSO .ATMS>>`。
    同じ意味と確かめた作品: AMFV・Enchanter・HHGG・Lurking Horror・Sorcerer・Spellbreaker・
    Trinity・Zork I・II・III。

    Args:
        objects: 比べる値 (オブジェクトなど)。

    Returns:
        どれかに等しければ True。
    """
    return ZG.PRSO in objects


def PRSI_p(*objects: Any) -> bool:
    """間接目的語 (PRSI) が、指定した値のどれかに等しいか (共通マクロ PRSI?)。

    元にした定義: `<DEFMAC PRSI? ("ARGS" ATMS) <MULTIFROB PRSI .ATMS>>`。
    同じ意味と確かめた作品: PRSO? と同じ 10 作品。

    Args:
        objects: 比べる値。

    Returns:
        どれかに等しければ True。
    """
    return ZG.PRSI in objects


def ROOM_p(*rooms: Any) -> bool:
    """現在の部屋 (HERE) が、指定した部屋のどれかに等しいか (共通マクロ ROOM?)。

    元にした定義: `<DEFMAC ROOM? ("ARGS" ATMS) <MULTIFROB HERE .ATMS>>`。
    同じ意味と確かめた作品: AMFV・Enchanter・HHGG・Sorcerer・Spellbreaker・Zork I・III
    (Zork II は同じ名前の ROUTINE があり、そちらが使われる)。

    Args:
        rooms: 部屋。

    Returns:
        どれかに等しければ True。
    """
    return ZG.HERE in rooms


def BSET(obj: ZObject, *flags: Any) -> bool:
    """複数のフラグをまとめて立てる (共通マクロ BSET)。

    元にした定義: `<DEFMAC BSET ('OBJ "ARGS" BITS) <MULTIBITS FSET .OBJ .BITS>>`。
    正規の展開は `<PROG () <FSET .OBJ ,B1> <FSET .OBJ ,B2> ...>`。
    同じ意味と確かめた作品: AMFV・Enchanter・HHGG・Lurking Horror・Sorcerer・Spellbreaker・
    Zork I・II・III。

    Args:
        obj: 対象のオブジェクト。
        flags: フラグ。

    Returns:
        常に True。
    """
    for flag in flags:
        FSET(obj, flag)
    return True


def BCLEAR(obj: ZObject, *flags: Any) -> bool:
    """複数のフラグをまとめて下ろす (共通マクロ BCLEAR)。

    元にした定義: `<DEFMAC BCLEAR ('OBJ "ARGS" BITS) <MULTIBITS FCLEAR .OBJ .BITS>>`。
    同じ意味と確かめた作品: BSET と同じ 9 作品。

    Args:
        obj: 対象のオブジェクト。
        flags: フラグ。

    Returns:
        常に True。
    """
    for flag in flags:
        FCLEAR(obj, flag)
    return True


def BSET_p(obj: ZObject, *flags: Any) -> bool:
    """フラグのどれかが立っているか (共通マクロ BSET?)。

    元にした定義: `<DEFMAC BSET? ('OBJ "ARGS" BITS) <MULTIBITS FSET? .OBJ .BITS>>`。
    正規の展開は `<OR <FSET? .OBJ ,B1> <FSET? .OBJ ,B2> ...>`。
    同じ意味と確かめた作品: BSET と同じ 9 作品。

    Args:
        obj: 対象のオブジェクト。
        flags: フラグ。

    Returns:
        どれかが立っていれば True。
    """
    return any(FSET_p(obj, flag) for flag in flags)


def FLAMING_p(obj: ZObject) -> bool:
    """オブジェクトが燃えているか (共通マクロ FLAMING?)。

    元にした定義: `<DEFMAC FLAMING? ('OBJ) <FORM AND <FORM FSET? .OBJ ',FLAMEBIT>
    <FORM FSET? .OBJ ',ONBIT>>>`。
    同じ意味と確かめた作品: Deadline・Enchanter・Witness・Zork I・II・III。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        FLAMEBIT と ONBIT が立っていれば True。
    """
    return FSET_p(obj, "FLAMEBIT") and FSET_p(obj, "ONBIT")


def OPENABLE_p(obj: ZObject) -> bool:
    """オブジェクトが開閉できるか (共通マクロ OPENABLE?)。

    元にした定義: `<DEFMAC OPENABLE? ('OBJ) <FORM OR <FORM FSET? .OBJ ',DOORBIT>
    <FORM FSET? .OBJ ',CONTBIT>>>`。
    同じ意味と確かめた作品: Deadline・Enchanter・Planetfall・Sorcerer・Suspended・Witness・
    Zork I・II・III。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        DOORBIT か CONTBIT が立っていれば True。
    """
    return FSET_p(obj, "DOORBIT") or FSET_p(obj, "CONTBIT")


def ENABLE(interrupt: Any) -> bool:
    """割り込み (QUEUE の戻り値) を有効にする (共通マクロ ENABLE)。

    元にした定義: `<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>`。
    同じ意味と確かめた作品: Deadline・Enchanter・HHGG・Planetfall・Sorcerer・Suspended・
    Trinity・Witness・Zork I・II・III。

    Args:
        interrupt: 割り込みのエントリ。

    Returns:
        常に True。
    """
    return PUT(interrupt, ZG.C_ENABLED_p, 1)


def ABS(number: int) -> int:
    """絶対値を返す (共通マクロ ABS)。

    元にした定義: `<DEFMAC ABS ('NUM) <FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>) (T .NUM)>>`。
    同じ意味と確かめた作品: Deadline・Enchanter・Planetfall・Sorcerer・Suspended・Trinity・
    Witness・Zork I・II・III。

    Args:
        number: 数値。

    Returns:
        絶対値。
    """
    return abs(number)


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZG,
)
from .objects import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    FCLEAR,
    FSET,
    FSET_p,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    PUT,
)
from .vocab import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    SYMBOL,
)
