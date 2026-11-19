"""演算と、ほかに分類しない ZIL の命令 (RANDOM・BTST・INTBL?・SOUND・APPLY など)。

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


def RANDOM(limit: int) -> int:
    """1 から limit までの乱数を返す。limit が負なら乱数の種を設定する。

    Args:
        limit: 上限 (負の場合は乱数の種)。

    Returns:
        乱数。種を設定した場合は 0。
    """
    rng = get_context().random
    if limit <= 0:
        rng.seed(-limit or None)
        return 0
    return rng.randint(1, limit)


def ASCII(value: int | str) -> int | str:
    """文字と ASCII コードを相互に変換する。

    Args:
        value: 文字列なら先頭文字のコード、整数ならそのコードの文字へ変換する。

    Returns:
        整数 (文字列を渡した場合) または 1 文字の文字列 (整数を渡した場合)。
    """
    if isinstance(value, str):
        return ord(value[0]) if value else 0
    return chr(value)


def BTST(value: int, mask: int) -> bool:
    """mask のビットがすべて value に立っているかを判定する。

    Args:
        value: 調べる値。
        mask: ビットマスク。

    Returns:
        すべて立っていれば True。
    """
    return (value & mask) == mask




def INTBL_p(value: Any, table: Any, count: int) -> bool:
    """テーブルの先頭 count 個のワードに value があるかを調べる。

    Args:
        value: 探す値。
        table: 探すテーブル。
        count: 調べるワード数。

    Returns:
        あれば True。
    """
    return any(GET(table, i) == value for i in range(count))


def SOUND(*_args: Any) -> bool:
    """効果音を鳴らす (Python では何もしない)。

    Args:
        _args: 効果音の番号など (使わない)。

    Returns:
        常に True。
    """
    return True


def APPLY(func: Any, *args: Any) -> Any:
    """ルーチンを呼び出す。

    Z-machine と同じく、ルーチンが受け取れる数を超えた引数は捨てる
    (例: 引数を取らない ACTION ルーチンを、引数付きで呼ぶ PERFORM)。
    足りない必須引数は 0 で補う (Z-machine では渡されなかった引数は 0 になる。
    例: AMFV の NEWSPAPER-DISPENSER-F (RARG) を引数なしで呼ぶ物体の ACTION)。

    Args:
        func: ルーチン (呼び出せない値の場合は何もしない)。
        args: ルーチンへの引数。

    Returns:
        ルーチンの戻り値。呼び出せない場合は False。
    """
    if not callable(func):
        return False
    code = getattr(func, "__code__", None)
    if code is not None:
        if not code.co_flags & _CO_VARARGS and len(args) > code.co_argcount:
            args = args[: code.co_argcount]
        required = code.co_argcount - len(getattr(func, "__defaults__", None) or ())
        if len(args) < required:
            args = args + (0,) * (required - len(args))
    return func(*args)


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _CO_VARARGS,
    get_context,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    GET,
)
