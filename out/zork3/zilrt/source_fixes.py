"""原作ソースのバグの補正 (GLOBAL の値を、ゲームと元の値が一致したときだけ直す)。

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
# 元の ZIL ソースそのものにバグがあり、Z-machine では意味のない値を読んで
# 動き続けるが、ZilPy では型の不一致などで止まってしまう箇所を補正する。
#
# 方針 (ほかのゲームのバグを見落とさないため):
# - 補正は GLOBAL の名前ごとに個別に登録し、ゲームと元の値が完全に一致した時だけ
#   適用する。一致しなければ何もしない (値はそのまま使われ、問題があれば従来どおり
#   エラーで止まる)。
# - 適用した時は標準エラー出力に知らせる (ゲームの出力には混ぜない)。
# - 似た症状を一般的に受け流す仕組み (文字列を数として扱う等) は作らない。


def _global_value(name: str) -> Any:
    """宣言されていれば GLOBAL / CONSTANT の値を、なければ None を返す。

    Args:
        name: Python の識別子に変換済みの名前。

    Returns:
        値。宣言されていない場合は None。
    """
    if name in ZG.__dict__ or name in ZG.__dict__.get("_pending", {}):
        return getattr(ZG, name)
    return None


# Zork III の YUKS の元の中身 (3actions.zil)
_ZORK3_YUKS_MESSAGES = (
    "A valiant attempt.",
    "You can't be serious.",
    "An interesting idea...",
    "What a concept!",
)


def _fix_zork3_yuks(value: Any) -> Any:
    """Zork III の YUKS に、PICK-ONE が使う「使用済みの数」のワードを足す。

    zork3.zil は GVERBS と 3ACTIONS をこの順で取り込み、どちらも <GLOBAL YUKS> を
    定義している。後に読まれる 3actions.zil 版 (先頭に 0 がない) が残るが
    (当時のコンパイル結果 zork3dat.zap の T?25 も同じ)、gmacros.zil の PICK-ONE は
    ワード 1 を使用済みの数として読む。そのため文字列のアドレスを数として計算し、
    取れない物を TAKE するたびにでたらめな場所を読み書きしていた。gverbs.zil 版と
    同じ <LTABLE 0 ...> の形に直す。

    Args:
        value: YUKS の元の値。

    Returns:
        補正した値。Zork III の元の値と一致しなければ None。
    """
    if _global_value("ZORK_NUMBER") != 3 or not isinstance(value, Table):
        return None
    count = len(_ZORK3_YUKS_MESSAGES)
    if value.size() != (count + 1) * 2 or GET(value, 0) != count:
        return None
    if tuple(GET(value, i + 1) for i in range(count)) != _ZORK3_YUKS_MESSAGES:
        return None
    return LTABLE(0, *_ZORK3_YUKS_MESSAGES)


# GLOBAL の名前 -> [(補正の名前, 補正する関数)]。関数は補正した値か、対象外なら None を返す
_SOURCE_FIXES: dict[str, list[tuple[str, Callable[[Any], Any]]]] = {
    "YUKS": [("zork3-yuks-pick-one", _fix_zork3_yuks)],
}


def _apply_source_fixes(name: str, value: Any) -> Any:
    """GLOBAL の初期値に、登録された原作ソースのバグの補正を適用する。

    Args:
        name: Python の識別子に変換済みの名前。
        value: 宣言の初期値。

    Returns:
        補正した値。対象の補正がなければ元の値。
    """
    applied = get_context().world.applied_source_fixes
    for fix_name, fix in _SOURCE_FIXES.get(name, ()):
        fixed = fix(value)
        if fixed is not None:
            if fix_name not in applied:
                applied.append(fix_name)
                print(f"ZilPy: applied source fix {fix_name} to {name}", file=_sys.stderr)
            return fixed
    return value


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZG,
    get_context,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    GET,
    LTABLE,
    Table,
)
