"""QUIT・RESTART・SAVE・RESTORE と、状態のスナップショット (MCP の save_state・undo)。

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


def QUIT() -> None:
    """ゲームを終了する。

    Raises:
        ZilQuit: 常に発生する (SystemExit の派生クラス)。
    """
    _sys.stdout.flush()
    raise ZilQuit(0)


def RESTART() -> None:
    """ゲームを最初からやり直す。

    通常の起動では、_link が保存した開始時の状態に戻し、乱数を新しいプロセスと同じに
    作り直して、GO をやり直す。同じ標準入力から読み続けるので、パイプやリダイレクトで
    渡した残りのコマンドも読まれる (以前の os.execv での再起動では、読み込み済みの
    入力が失われていた)。ZilRuntime.lua も同じ方法でやり直す。
    組み込みモードでは ZilRestart を投げ、組み込んだ側に開始時の状態への巻き戻しを任せる。

    Raises:
        ZilRestart: 組み込みモードの場合。
        ZilQuit: やり直したゲームが終わった場合。
    """
    _sys.stdout.flush()
    ctx = get_context()
    if ctx.io.embedded:
        raise ZilRestart()
    if ctx.io.initial_snapshot is None:
        # _link を通らずに起動された場合は、プロセスを再起動する
        _os.execv(_sys.executable, [_sys.executable, *_sys.argv])
    restore_snapshot(ctx.io.initial_snapshot)
    ctx.random = _new_random()
    ctx.io.upper_window = False
    ZG.GO()
    QUIT()


class _SavePickler(_pickle.Pickler):
    """ゲームの状態を保存する Pickler。

    オブジェクトとルーチンは、コピーせず番号や名前で参照する。復元後も
    既存のオブジェクトを使い続けるためで、実行中のルーチンが持っている
    参照を古いままにしないためでもある。
    """

    def __init__(self, file: Any, index: dict[int, int], ctx: GameContext) -> None:
        """Pickler を初期化する。

        Args:
            file: 書き込み先のバイナリファイル。
            index: オブジェクトの id -> world.objects 内の番号。
            ctx: 対象の GameContext。
        """
        super().__init__(file)
        self._index = index
        self._ctx = ctx

    def persistent_id(self, obj: Any) -> Any:
        """オブジェクトとルーチンを、保存せず参照に置き換える。

        Args:
            obj: 保存しようとしている値。

        Returns:
            参照を表すタプル。置き換えない値は None。
        """
        if isinstance(obj, ZObject):
            return ("O", self._index[id(obj)])
        name = getattr(obj, "__name__", None)
        if (
            isinstance(obj, _types.FunctionType)
            and name in self._ctx.actions.routine_names
            and self._ctx.__dict__.get(name) is obj
        ):
            return ("F", name)
        return None


class _SaveUnpickler(_pickle.Unpickler):
    """`_SavePickler` で保存した状態を読み込む Unpickler。"""

    def __init__(self, file: Any, ctx: GameContext) -> None:
        super().__init__(file)
        self._ctx = ctx

    def persistent_load(self, pid: Any) -> Any:
        """参照を、実行中のオブジェクトやルーチンに戻す。

        Args:
            pid: `persistent_id` が返したタプル。

        Returns:
            対応するオブジェクトまたはルーチン。

        Raises:
            _pickle.UnpicklingError: 不明な参照の場合。
        """
        kind, key = pid
        if kind == "O":
            return self._ctx.world.objects[key]
        if kind == "F":
            return self._ctx.__dict__[key]
        raise _pickle.UnpicklingError(f"unknown reference {pid!r}")

    def find_class(self, module: str, name: str) -> Any:
        """クラスを探す。ランタイムを zilrt/ に分ける前の保存ファイルも読めるようにする。

        分ける前は、クラス (Table・Word・Direction など) は ZilRuntime モジュールにあり、
        保存ファイルには `ZilRuntime.Table` のように記録されている (refactor-plan.md Phase 5)。
        その名前を、今のクラスのあるモジュール (zilrt.tables など) から探す。

        Args:
            module: 保存ファイルに記録されたモジュールの名前。
            name: クラスの名前。

        Returns:
            クラス (または関数などの値)。
        """
        if module == "ZilRuntime":
            package = _sys.modules[__package__]
            for value in vars(package).values():
                if isinstance(value, _types.ModuleType) and value.__name__.startswith(__package__ + "."):
                    if name in vars(value):
                        return vars(value)[name]
        return super().find_class(module, name)


def _normalize_slot(slot: str | None) -> str | None:
    """スロット名をファイル名に安全な形式へ正規化する。"""
    if slot is None:
        return None
    cleaned = _re.sub(r"[^A-Za-z0-9_-]+", "_", slot.strip()).strip("_")
    return cleaned or None


def _base_save_path() -> _Path:
    """保存ファイルのベースパスを返す。"""
    save_file = get_context().io.save_file
    if save_file is not None:
        return save_file
    return _Path(_Path(_sys.argv[0]).stem + SAVE_SUFFIX)


def _save_path(slot: str | None = None) -> _Path:
    """保存ファイルのパスを返す (起動したゲームの名前に .sav を付けたもの)。

    Args:
        slot: スロット名 (省略時はデフォルトの単一ファイル)。

    Returns:
        set_io で指定したパス (またはカレントディレクトリの `<ゲーム名>.sav`)。
    """
    base = _base_save_path()
    clean = _normalize_slot(slot)
    if clean is None:
        return base
    suffix = base.suffix or SAVE_SUFFIX
    return base.with_name(f"{base.stem}.{clean}{suffix}")


def _fallback_save_path(primary: _Path) -> _Path:
    """通常の保存先へ書き込めない場合に使う一時ディレクトリのパスを返す。"""
    try:
        parent_tag = _re.sub(r"[^A-Za-z0-9_-]+", "_", primary.resolve().parent.name) or "game"
    except OSError:
        parent_tag = "game"
    return _Path(_tempfile.gettempdir()) / "zilpy_saves" / f"{parent_tag}_{primary.name}"


def _provided_names() -> set[str]:
    """ZG のうち、保存しない名前 (ルーチン・定数・実行時に作る表) を返す。

    Returns:
        名前の集合。
    """
    ctx = get_context()
    consts = {name for name, cat in ctx._categories.items() if cat == "const"}
    return set(ctx.actions.routine_names) | set(_PROVIDERS) | consts


def _is_internal_name(name: str) -> bool:
    """ZG の属性名が、ゲームの変数ではなく GameContext 自身の内部データかを判定する。

    ZIL の名前が数字で始まると、Python では先頭に `_` を付ける
    (例: AMFV の 2051-SCORE は `_2051_SCORE`)。これはゲームの変数なので保存する。

    Args:
        name: GameContext の属性名。

    Returns:
        内部データ (`_pending` や `const`/`state`/`world` 等) なら True。
    """
    if name in (
        "io",
        "random",
        "const",
        "state",
        "scratch",
        "world",
        "dictionary",
        "actions",
    ):
        return True
    return name.startswith("_") and not name[1:2].isdigit()


def _collect_state() -> dict[str, Any]:
    """保存するゲームの状態をまとめる。

    Returns:
        グローバル変数、全オブジェクト (プロパティ・フラグ・親子関係)、乱数の状態。
    """
    ctx = get_context()
    objects = ctx.world.objects
    skip = _provided_names()
    return {
        "count": len(objects),
        "globals": {
            name: value
            for name, value in ctx.__dict__.items()
            if not _is_internal_name(name) and name not in skip
        },
        "objects": [
            (dict(obj), obj.parent, list(obj.children)) for obj in objects
        ],
        "random": ctx.random.getstate(),
    }


def _dump_state(file: Any) -> None:
    """ゲームの状態を pickle で書き出す。

    Args:
        file: 書き込み先のバイナリファイル。
    """
    ctx = get_context()
    objects = ctx.world.objects
    index = {id(obj): number for number, obj in enumerate(objects)}
    _SavePickler(file, index, ctx).dump(_collect_state())


def _load_state(file: Any) -> bool:
    """pickle で書き出したゲームの状態を読み込んで反映する。

    オブジェクトは既存のものの内容を書き換える (参照を保つため)。

    Args:
        file: 読み込み元のバイナリファイル。

    Returns:
        反映できれば True。壊れている、またはゲームが違う場合は False。
    """
    ctx = get_context()
    try:
        state = _SaveUnpickler(file, ctx).load()
    except (_pickle.UnpicklingError, EOFError, KeyError, IndexError):
        return False
    if not isinstance(state, dict) or state.get("count") != len(ctx.world.objects):
        return False
    _apply_state(state)
    return True


def snapshot_state() -> bytes:
    """ゲームの状態をメモリ上に保存する (組み込む側が RESTART に使う)。

    Returns:
        状態を pickle したバイト列。
    """
    buffer = _io.BytesIO()
    _dump_state(buffer)
    return buffer.getvalue()


def restore_snapshot(data: bytes) -> bool:
    """snapshot_state で保存した状態に戻す。

    Args:
        data: snapshot_state が返したバイト列。

    Returns:
        戻せれば True。
    """
    return _load_state(_io.BytesIO(data))


def SAVE(slot: str | None = None) -> bool:
    """ゲームの状態を `<ゲーム名>.sav` (またはスロット付きファイル) に保存する。

    グローバル変数、全オブジェクト (プロパティ・フラグ・親子関係)、乱数の
    状態を pickle で書き出す。通常の保存先へ書き込めない場合は一時ディレクトリへ
    フォールバックする。

    Args:
        slot: 任意のスロット名。省略時はデフォルトの保存先を使う。

    Returns:
        成功すれば True、書き込みに失敗すれば False。
    """
    clean = _normalize_slot(slot)
    slot_key = clean or ""
    primary = _save_path(clean)
    fallback = _fallback_save_path(primary)
    candidates = [primary] if fallback == primary else [primary, fallback]

    for idx, path in enumerate(candidates):
        try:
            path.parent.mkdir(parents=True, exist_ok=True)
            with path.open("wb") as file:
                _dump_state(file)
        except OSError as exc:
            print(f"[ZilRuntime] SAVE write failed ({path}): {exc}", file=_sys.stderr)
            if idx + 1 < len(candidates):
                continue
            return False
        except (_pickle.PicklingError, TypeError, AttributeError) as exc:
            print(f"[ZilRuntime] SAVE serialization failed ({path}): {exc}", file=_sys.stderr)
            return False
        get_context().io.last_save_paths[slot_key] = path
        return True
    return False


def RESTORE(slot: str | None = None) -> bool:
    """`<ゲーム名>.sav` (またはスロット付きファイル) からゲームの状態を復元する。

    Args:
        slot: 任意のスロット名。省略時はデフォルトの保存先を使う。

    Returns:
        成功すれば True。ファイルがない、または壊れている場合は False。
    """
    clean = _normalize_slot(slot)
    slot_key = clean or ""
    primary = _save_path(clean)
    fallback = _fallback_save_path(primary)
    last_path = get_context().io.last_save_paths.get(slot_key)

    candidates: list[_Path] = []
    for cand in (last_path, primary, fallback):
        if cand is not None and cand not in candidates:
            candidates.append(cand)

    for path in candidates:
        if not path.exists():
            continue
        try:
            with path.open("rb") as file:
                if _load_state(file):
                    get_context().io.last_save_paths[slot_key] = path
                    return True
                print(f"[ZilRuntime] RESTORE invalid save data ({path})", file=_sys.stderr)
        except OSError as exc:
            print(f"[ZilRuntime] RESTORE read failed ({path}): {exc}", file=_sys.stderr)
    return False


def LIST_SAVES() -> list[str]:
    """現在利用可能なセーブスロット名の一覧を返す。

    Returns:
        スロット名のリスト (デフォルトスロットが存在する場合は `"default"` を含む)。
    """
    base = _base_save_path()
    suffix = base.suffix or SAVE_SUFFIX
    stem = base.stem
    slots: set[str] = set()

    dirs_and_prefixes: list[tuple[_Path, str]] = [(base.parent, stem)]
    fb_base = _fallback_save_path(base)
    if fb_base.parent != base.parent or fb_base.stem != stem:
        dirs_and_prefixes.append((fb_base.parent, fb_base.stem))

    for directory, prefix in dirs_and_prefixes:
        if not directory.exists():
            continue
        default_file = directory / f"{prefix}{suffix}"
        if default_file.is_file():
            slots.add("default")
        for entry in directory.glob(f"{prefix}.*{suffix}"):
            if not entry.is_file():
                continue
            slot_part = entry.name[len(prefix) + 1 : -len(suffix)]
            if slot_part:
                slots.add(slot_part)
    return sorted(slots)


def _apply_state(state: dict[str, Any]) -> None:
    """_collect_state でまとめた状態を、実行中のゲームに反映する。

    Args:
        state: 読み込んだ状態。
    """
    ctx = get_context()
    for obj, (props, parent, children) in zip(ctx.world.objects, state["objects"]):
        obj.clear()
        obj.update(props)
        obj.parent = parent
        obj.children = children
    ctx.__dict__.update(state["globals"])
    ctx.random.setstate(state["random"])


def VERIFY() -> bool:
    """ゲームファイルを検証する (Python では常に成功)。

    Returns:
        常に True。
    """
    return True


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .context import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    SAVE_SUFFIX,
    ZG,
    ZilQuit,
    ZilRestart,
    _new_random,
    get_context,
)
from .objects import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZObject,
)
from .vocab import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _PROVIDERS,
)
