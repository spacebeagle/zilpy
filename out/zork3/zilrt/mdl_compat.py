"""MDL の互換 (ゲームのコードに残っている MDL の関数。多くは何もしない)。

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


def USL() -> bool:
    """ステータスラインを更新する (Python では何もしない)。

    Returns:
        常に True。
    """
    return True


def BLOAT(*args: Any) -> bool:
    """メモリ領域の大きさを宣言する (Python では何もしない)。

    Args:
        args: 各領域の大きさ。

    Returns:
        常に True。
    """
    return True


def GC(*args: Any) -> bool:
    """コンパイラのメモリ回収の指示 (Python では何もしない)。

    Args:
        args: 指示の引数。

    Returns:
        常に True。
    """
    return True


GC_MON = GC


def IVECTOR(count: int, value: Any = None) -> list[Any]:
    """MDL のベクトルを作る (コンパイル時の作業領域。例: Suspended の STRS)。

    Args:
        count: 要素数。
        value: 各要素の初期値。

    Returns:
        リスト。
    """
    return [value] * count


IUVECTOR = IVECTOR


def SNAME(*args: Any) -> bool:
    """コンパイル結果のファイル名を指定する (Python では何もしない)。

    Args:
        args: ファイル名 (例: 'ZORK3')。

    Returns:
        常に True。
    """
    return True


def ID(*args: Any) -> bool:
    """コンパイラにゲームの識別番号を指定する (Python では何もしない)。

    Args:
        args: 識別番号 (例: 0)。

    Returns:
        常に True。
    """
    return True


def GASSIGNED_p(name: str) -> bool:
    """グローバル値が定義済みかを判定する。

    コンパイラ自身を表すアトム (`<GASSIGNED? ZILCH>`) は、変換器が変換時に真と決める
    (ZilConstants.COMPILER_ATOMS) ので、ここには来ない。実行時に問われるのは、ZILCH 以外の
    コンパイル環境を表すアトム (MUDDLE、PREDGEN など) だけで、どれも定義されていない。

    Args:
        name: アトム名。

    Returns:
        常に False。
    """
    return False


def NTH(seq: Sequence[Any], index: int) -> Any:
    """1 始まりで index 番目の要素を返す (MDL の NTH)。

    Args:
        seq: シーケンス。
        index: 1 始まりの位置。

    Returns:
        要素の値。
    """
    return seq[index - 1]


def LENGTH(seq: Sequence[Any]) -> int:
    """要素数を返す。

    Args:
        seq: シーケンス。

    Returns:
        要素数。
    """
    return len(seq)


def EMPTY_p(seq: Sequence[Any]) -> bool:
    """要素がないかを判定する。

    Args:
        seq: シーケンス。

    Returns:
        空なら True。
    """
    return len(seq) == 0


def STRING(*parts: Any) -> str:
    """値をつなげた文字列を返す。

    Args:
        parts: つなげる値。

    Returns:
        連結した文字列。
    """
    return "".join(str(part) for part in parts)


def SPNAME(atom: Any) -> str:
    """アトムの名前を返す。

    Args:
        atom: アトム。

    Returns:
        名前の文字列。
    """
    return str(atom)


def ERROR(*args: Any) -> None:
    """ZIL のエラーを発生させる。

    Args:
        args: エラーの内容。

    Raises:
        ZilError: 常に発生する。
    """
    raise ZilError(" ".join(str(arg) for arg in args))


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZilError,
)
