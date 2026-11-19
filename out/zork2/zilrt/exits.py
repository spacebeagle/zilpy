"""部屋の出口 (条件付きの出口の値と、出口のテーブルの符号化)。

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


class GlobalRef(str):
    """グローバル変数の名前。VALUE で現在の値を取り出せる (出口の条件に使う)。"""


def VALUE(value: Any) -> Any:
    """変数の値を取り出す (ZIL の VALUE)。

    Args:
        value: 値。GlobalRef ならその名前のグローバル変数の現在の値を返す。

    Returns:
        変数の値、または渡された値そのもの。
    """
    if isinstance(value, GlobalRef):
        return getattr(ZG, str(value))
    return value


def _encode_exit(value: Any) -> Table:
    """部屋の出口のプロパティを、Z-machine の出口テーブルに変換する。

    表のサイズ (PTSIZE) が出口の種類を表す: 1 は通常の出口 (UEXIT)、
    2 はメッセージだけの出口 (NEXIT)、3 は関数で決まる出口 (FEXIT)、
    4 は条件付きの出口 (CEXIT)、5 は扉の出口 (DEXIT)。

    Args:
        value: プロパティの値。文字列 (または ('SORRY', 文字列)) なら NEXIT、
            ('PER', 関数) なら FEXIT、
            ('TO', 部屋, 'IF', 条件 [, 'IS', 'OPEN'] [, 'ELSE', メッセージ]) など。

    Returns:
        出口のテーブル。
    """
    wide = _wide_exits()
    if isinstance(value, tuple) and len(value) == 2 and value[0] == "SORRY":
        # (NE SORRY "...") は NEXIT の別表記 (Trinity)。メッセージだけの出口
        value = value[1]
    if isinstance(value, str):
        return Table([value, None, 0] if wide else [value, None])
    if value[0] == "PER":
        return Table([value[1], None, 0, 0] if wide else [value[1], None, 0])
    room, rest = value[1], tuple(value[2:])
    if not rest:
        return Table([room, None] if wide else [room])
    message = rest[rest.index("ELSE") + 1] if "ELSE" in rest else 0
    condition = rest[rest.index("IF") + 1]
    if "IS" in rest:
        if wide:
            return Table([room, None, getattr(ZG, condition), None, message, None])
        return Table([room, getattr(ZG, condition), message, None, 0])
    if wide:
        return Table([room, None, message, None, GlobalRef(condition)])
    return Table([room, GlobalRef(condition), message, None])


def _wide_exits() -> bool:
    """出口のテーブルが、部屋をワードで持つ配置 (Trinity など) かを判定する。

    ゲームが UEXIT (通常の出口のバイト数) を 2 と定義していれば、部屋はワードで、
    NEXIT 3、FEXIT 4、CEXIT 5、DEXIT 6 の配置になる。1 なら部屋はバイト。

    Returns:
        ワードの配置なら True。
    """
    try:
        return int(ZG.UEXIT) == 2
    except (ZilError, AttributeError, TypeError):
        return False


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZG,
    ZilError,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    Table,
)
