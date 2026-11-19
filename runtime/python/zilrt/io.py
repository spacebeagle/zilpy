"""出力 (PRINT 系の命令・TELL と書式指定子) と、1 文字の入力 (INPUT)。

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


def _write(text: str) -> None:
    """標準出力へ文字列を書き出す (改行は付けない)。

    Args:
        text: 出力する文字列。
    """
    io_state = get_context().io
    if io_state.capture is not None:
        io_state.capture[1].append(text)  # DIROUT でテーブルへためている
        return
    if io_state.upper_window:
        return  # 上のウィンドウ (ステータス表示) への出力は捨てる
    if io_state.output_hook is not None:
        io_state.output_hook(text)
        return
    _sys.stdout.write(text)


def PRINTI(text: str) -> bool:
    """文字列をそのまま出力する。

    Args:
        text: 出力する文字列。

    Returns:
        常に True。
    """
    _write(text)
    return True


def PRINT(value: Any) -> bool:
    """値を文字列として出力する (ZIL では文字列アドレスの出力)。

    Args:
        value: 出力する値。

    Returns:
        常に True。
    """
    _write(value if isinstance(value, str) else str(value))
    return True


def PRINTB(word: Any) -> bool:
    """辞書の単語を出力する。

    Args:
        word: 単語 (READ が LEXV に格納した値)。

    Returns:
        常に True。
    """
    _write(str(word).lower())
    return True


def PRINTN(number: int) -> bool:
    """数値を 10 進数で出力する。

    Args:
        number: 出力する数値。

    Returns:
        常に True。
    """
    _write(str(number))
    return True


def PRINTC(char: int | str) -> bool:
    """1 文字を出力する。

    Args:
        char: 文字コード、または文字。

    Returns:
        常に True。
    """
    _write(chr(char) if isinstance(char, int) else str(char))
    return True


def PRINTD(obj: "ZObject") -> bool:
    """オブジェクトの短い名前 (DESC) を出力する。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        常に True。
    """
    _write(_describe(obj))
    return True


def PRINTA(obj: "ZObject") -> bool:
    """不定冠詞付きでオブジェクトの名前を出力する。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        常に True。
    """
    desc = _describe(obj)
    article = "an" if desc[:1] in VOWELS else "a"
    _write(f"{article} {desc}")
    return True


def CRLF() -> bool:
    """改行を出力する。

    Returns:
        常に True。
    """
    _write("\n")
    return True


def PRINC(value: Any) -> bool:
    """値を出力する (MDL の PRINC)。

    Args:
        value: 出力する値。

    Returns:
        常に True。
    """
    return PRINT(value)


def _describe(obj: Any) -> str:
    """オブジェクトの表示名を求める。

    Args:
        obj: 対象のオブジェクト。

    Returns:
        DESC プロパティ、なければオブジェクト名。
    """
    if isinstance(obj, ZObject):
        return str(obj.get("DESC", obj.name))
    return str(obj)


class TellToken:
    """TELL の書式指定子 (D, A, N, C など)。直後の引数の出力方法を表す。"""

    def __init__(self, name: str, printer: Callable[[Any], bool]) -> None:
        """TellToken を初期化する。

        Args:
            name: 指定子の名前。
            printer: 直後の引数を出力する関数。
        """
        self.name = name
        self.printer = printer

    def __repr__(self) -> str:
        """指定子の名前を返す。

        Returns:
            指定子の名前。
        """
        return self.name


def _routine_or(name: str, builtin: Callable[..., bool]) -> Callable[..., bool]:
    """ゲームが name のルーチンを定義していればそれを、なければ builtin を返す。

    名前の解決の規則 (zilpy/compiletime/names.py、refactor-plan.md §4 の 6): ゲームの
    定義がランタイムの関数と同じ名前なら、ランタイムの内部からの呼び出しにもゲームの
    定義を使う。TELL の書式指定子 (CR・D・A・N・C) が呼ぶ CRLF・PRINTD・PRINTA・
    PRINTN・PRINTC がこれに当たる (Lua 版のランタイムは ZG.PRINTA などを呼ぶので同じになる)。
    """
    ctx = get_context()
    if name in ctx.actions.routine_names:
        return ctx.__dict__.get(name, builtin)
    return builtin


def _tell_printer(name: str, builtin: Callable[[Any], bool]) -> Callable[[Any], bool]:
    """TELL の書式指定子が直後の引数に使う関数 (呼ぶたびに _routine_or で選ぶ)。"""

    def printer(value: Any) -> bool:
        return _routine_or(name, builtin)(value)

    printer.__name__ = f"_tell_{name}"
    return printer


CR = TellToken("CR", lambda _value: _routine_or("CRLF", CRLF)())
S = ""
D = DESC = OBJ = O = TellToken("D", _tell_printer("PRINTD", PRINTD))
A = AN = TellToken("A", _tell_printer("PRINTA", PRINTA))
N = NUM = TellToken("N", _tell_printer("PRINTN", PRINTN))
C = CHR = CHAR = TellToken("C", _tell_printer("PRINTC", PRINTC))


def TELL(*args: Any) -> bool:
    """文字列や値を続けて出力する (例: TELL('You see ', D, OBJ, '.', CR))。

    Args:
        args: 出力する文字列・値、および書式指定子 (CR, D, A, N, C)。
            書式指定子は直後の引数の出力方法を指定する。ルーチン (関数) は
            その位置で呼び出す (Deadline の TELL マクロの PRSO / PRSI)。

    Returns:
        常に True。
    """
    items = iter(args)
    for item in items:
        if item is CR or item is CRLF:
            _routine_or("CRLF", CRLF)()
        elif isinstance(item, TellToken):
            item.printer(next(items, ""))
        elif isinstance(item, _types.FunctionType):
            item()  # 出力の順序を保つため、引数としてではなくここで呼ぶ
        else:
            PRINT(item)
    return True


def INPUT(_device: int = 1) -> int:
    """1 文字の入力を待つ。1 行を読み、先頭の文字のコードを返す。

    Args:
        _device: 入力装置の番号 (使わない)。

    Returns:
        先頭の文字のコード。空行なら改行 (13)。
    """
    _sys.stdout.flush()
    input_hook = get_context().io.input_hook
    try:
        line = input_hook() if input_hook is not None else input()
    except EOFError:
        QUIT()
    return ord(line[0]) if line else 13


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    VOWELS,
    get_context,
)
from .objects import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZObject,
)
from .saves import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    QUIT,
)
