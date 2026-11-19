"""画面・出力先の命令 (テキストの入出力では何もしないものが多い)。

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


def DIROUT(stream: int = 0, table: Any = None) -> bool:
    """出力先を切り替える。

    テーブルを指定すると、それ以降の出力をそのテーブルへためる
    (Z-machine の出力ストリーム 3)。0 番目のワードに文字数、2 バイト目から
    文字が入る。出力先 0 または -3 で、ためるのをやめる。
    それ以外 (スクリプトの記録など) は何もしない。

    Args:
        stream: 出力先の番号。
        table: 出力をためるテーブル。

    Returns:
        常に True。
    """
    io_state = get_context().io
    if table is not None and not isinstance(table, bool):
        io_state.capture = (table, [])
    elif stream in (0, -3) and io_state.capture is not None:
        target, chars = io_state.capture
        io_state.capture = None
        text = "".join(chars)
        PUT(target, 0, len(text))
        for pos, ch in enumerate(text):
            PUTB(target, 2 + pos, ord(ch))
    return True


def SCREEN(window: int) -> bool:
    """出力するウィンドウを選ぶ。

    上のウィンドウ (1。ステータス表示) への出力は、テキストで遊ぶ ZilPy では
    捨てる。0 で通常の出力に戻る。

    Args:
        window: ウィンドウの番号。

    Returns:
        常に True。
    """
    get_context().io.upper_window = window == 1
    return True


def _screen_noop(*_args: Any) -> bool:
    """画面の制御 (Python では何もしない)。

    Args:
        _args: 命令の引数。

    Returns:
        常に True。
    """
    return True


# 画面を分割・消去し、カーソルや文字の装飾を変える命令。テキストの入出力では使わない
CLEAR = SPLIT = CURSET = HLIGHT = BUFOUT = ERASE = _screen_noop


def DIRIN(*_args: Any) -> bool:
    """入力元を切り替える (未対応のため何もしない)。

    Args:
        _args: 入力元の指定。

    Returns:
        常に True。
    """
    return True


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    get_context,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    PUT,
    PUTB,
)
