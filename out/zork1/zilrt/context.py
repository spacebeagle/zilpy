"""ゲームの状態 (GameContext・ZG)、入出力の差し込み口、定数と例外。

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


WORD_SIGNIFICANT_CHARS = 6
WORD_SIGNIFICANT_CHARS_V4 = 9
# 1 つの単語として切り出す区切り文字
WORD_SEPARATORS = frozenset('.,"')
# 区切り文字の単語を指す ZIL の記号定数の名前 (W?PERIOD / W?COMMA / W?QUOTE)。
# ゲームによっては W?\. のように文字そのものでも参照するので、両方と等しく扱う
SEPARATOR_WORD_NAMES = {".": "period", ",": "comma", '"': "quote"}
# コードオブジェクトのフラグ: 可変長の位置引数 (*args) を受け取る
_CO_VARARGS = 0x04
# テーブル宣言の先頭に置かれるフラグ
TABLE_FLAGS = frozenset({"PURE", "BYTE", "WORD", "LENGTH", "LEXV", "STRING", "KERNEL"})
# LEXV テーブルの 1 エントリ (単語, 文字数, 位置) のバイト数
LEXV_ENTRY_SIZE = 4
# Z-machine (V3) のプロパティ番号の最大値。方向は最初に宣言したものからこの番号が振られる
MAX_PROPERTY_NUMBER = 31
VOWELS = frozenset("aeiouAEIOU")
# ヘッダーに格納する、V-VERSION が表示するリリース番号とシリアル番号
# 保存ファイルの拡張子 (ゲームの名前に付ける)
SAVE_SUFFIX = ".sav"
# テーブルの末尾を越えて書き込めるバイト数 (Table.write を参照)
TABLE_OVERRUN_BYTES = 16
RELEASE_NUMBER = 88
SERIAL_NUMBER = "840726"
# ヘッダーに載せる画面の大きさ (文字数)
SCREEN_WIDTH = 80
SCREEN_HEIGHT = 25


class ZilError(Exception):
    """ZIL プログラムの実行時エラー。"""


class ZilQuit(SystemExit):
    """QUIT でゲームが終了したことを表す (SystemExit なので通常の起動では終了する)。"""


class ZilRestart(Exception):
    """組み込みモードで RESTART が実行されたことを表す。

    ゲームを組み込んだ側 (MCP サーバーなど) が捕まえ、開始時の状態に戻して
    GO をやり直す。
    """



@_dataclasses.dataclass
class IOState:
    """ゲームの入出力・画面・保存先の設定。"""

    output_hook: Callable[[str], None] | None = None
    input_hook: Callable[[], str] | None = None
    embedded: bool = False
    save_file: _Path | None = None
    last_save_paths: dict[str, _Path] = _dataclasses.field(default_factory=dict)
    capture: tuple[Any, list[str]] | None = None
    upper_window: bool = False
    # 通常の起動で RESTART したときに戻る、開始時の状態 (GameContext._link が保存する)
    initial_snapshot: bytes | None = None


def set_io(
    output: Callable[[str], None] | None = None,
    input_line: Callable[[], str] | None = None,
    *,
    embedded: bool = False,
    save_file: str | _Path | None = None,
) -> None:
    """現在のゲームコンテキストの入出力を差し替える。

    何も指定しなければ通常の起動と同じ (標準入出力、RESTART でプロセスを再起動)。

    Args:
        output: 出力された文字列を受け取る関数。
        input_line: コマンドを 1 行返す関数。EOFError を投げると QUIT と同じになる。
        embedded: True なら RESTART で ZilRestart を投げる。
        save_file: SAVE / RESTORE で使うファイルのパス。
    """
    io_state = get_context().io
    io_state.output_hook = output
    io_state.input_hook = input_line
    io_state.embedded = embedded
    io_state.save_file = _Path(save_file) if save_file is not None else None


class _ScopeView:
    """GameContext 上の変数を分類 (const / state / scratch) ごとに扱うビュー。"""

    def __init__(self, ctx: "GameContext", category: str) -> None:
        object.__setattr__(self, "_ctx", ctx)
        object.__setattr__(self, "_category", category)

    def _declare(self, name: str, thunk: Callable[[], Any]) -> None:
        """この分類に属するグローバル宣言を登録する。"""
        self._ctx._declare(name, thunk, category=self._category)

    def _set(self, name: str, value: Any) -> Any:
        """この分類に属する変数へ代入する。"""
        return self._ctx._set(name, value, category=self._category)

    def __getattr__(self, name: str) -> Any:
        return getattr(self._ctx, name)

    def __setattr__(self, name: str, value: Any) -> None:
        self._ctx._set(name, value, category=self._category)


class ConstStore(_ScopeView):
    """不変の定数 (`CONSTANT`・トップレベル `SETG`) を管理するビュー。"""

    def __init__(self, ctx: "GameContext") -> None:
        super().__init__(ctx, "const")


class StateStore(_ScopeView):
    """セーブ対象になるゲーム状態 (`GLOBAL`) を管理するビュー。"""

    def __init__(self, ctx: "GameContext") -> None:
        super().__init__(ctx, "state")


class ScratchStore(_ScopeView):
    """パーサー用ワーク変数 (`P-*` / parser 由来 `GLOBAL`) を管理するビュー。"""

    def __init__(self, ctx: "GameContext") -> None:
        super().__init__(ctx, "scratch")


class WorldState:
    """ゲーム世界の状態 (オブジェクト木・プロパティ既定値・ヘッダー等) を管理する。"""

    def __init__(self, ctx: "GameContext") -> None:
        self._ctx = ctx
        self.objects: list["ZObject"] = []
        self.property_defaults: dict[str, Any] = {}
        self._header: "Table | None" = None
        self.game_info: dict[str, Any] = {}
        self.applied_source_fixes: list[str] = []

    @property
    def header(self) -> "Table":
        """Z-machine ヘッダーのテーブルを返す (初回参照時に生成)。"""
        if self._header is None:
            self._header = _make_header(self.game_info.get("VERSION", ()))
        return self._header

    def declare_object(
        self, name: str, zil_name: str, props: Callable[[], dict[str, Any]]
    ) -> None:
        """OBJECT / ROOM を遅延初期化として登録する。"""
        self._ctx._declare_object(name, zil_name, props)


class Dictionary:
    """辞書・構文テーブル・単語登録を管理する。"""

    def __init__(self) -> None:
        self.words: dict[str, "Word"] = {}
        self.syntaxes: list[tuple[Any, ...]] = []
        self.synonym_groups: list[tuple[str, ...]] = []
        self.buzz_words: list[str] = []
        self.direction_names: list[str] = []
        self.verb_names: list[str] = []
        self.verb_index: dict[str, int] = {}
        self.prep_words: list[str] = []
        self.prep_numbers: dict[str, int] = {}
        self.adjective_ids: dict[str, int] = {}
        self.vocabulary_ready: bool = False
        self.significant_cache: int | None = None
        # PSEUDO が作る THINGS の表の形。ゲームが <DEFINE PSEUDO> を持てば
        # (名詞, 形容詞, ルーチン) の 3 つ組 (Spellbreaker)、なければ (形容詞, 名詞) の組
        # (Lurking Horror のパーサーが読む形)
        self.pseudo_triples: bool = False

    def use_pseudo_triples(self) -> None:
        """PSEUDO の表を (名詞, 形容詞, ルーチン) の 3 つ組にする (ゲームの DEFINE PSEUDO と同じ形)。"""
        self.pseudo_triples = True

    def invalidate(self) -> None:
        """宣言が増えたため語彙テーブルの再構築が必要であることを記録する。"""
        self.vocabulary_ready = False

    def syntax(self, *parts: Any) -> bool:
        """構文 (SYNTAX) を登録する。"""
        self.syntaxes.append(parts)
        self.invalidate()
        return True

    def synonym(self, *words: Any) -> bool:
        """同義語 (SYNONYM) を登録する。"""
        self.synonym_groups.append(tuple(str(word) for word in words))
        self.invalidate()
        return True

    def buzz(self, *words: Any) -> bool:
        """無視する単語 (BUZZ) を登録する。"""
        self.buzz_words.extend(str(word) for word in words)
        self.invalidate()
        return True

    def directions(self, *names: Any) -> bool:
        """方向 (DIRECTIONS) を登録する。"""
        self.direction_names.extend(str(name) for name in names)
        self.invalidate()
        return True


class ActionRegistry:
    """ルーチン登録とアクション番号・事前アクション表を管理する。"""

    def __init__(self, ctx: "GameContext") -> None:
        self._ctx = ctx
        self.routine_names: set[str] = set()
        # ルーチンの生成コードの名前 -> ZIL の名前 (V_VERBOSE -> V-VERBOSE)。エラーの表示などに使う
        self.zil_names: dict[str, str] = {}
        self.action_names: list[str] = [""]  # 0 は動詞なし
        self.action_ids: dict[str, int] = {}
        self.preaction_names: dict[int, str] = {}

    def register(self, func: Callable[..., Any]) -> Callable[..., Any]:
        """ROUTINE を関数名で登録するデコレータ (ZIL の名前を記録しない、前からの形)。"""
        return self._ctx._routine(func)

    def zil_name(self, name: str) -> str:
        """ルーチンの ZIL の名前 (記録がなければ name のまま)。"""
        return self.zil_names.get(name, name)

    def action_id(self, name: str) -> int:
        """アクション (V-NAME) の番号を返す。なければ割り当てる。"""
        if name not in self.action_ids:
            self.action_ids[name] = len(self.action_names)
            self.action_names.append(name)
        return self.action_ids[name]


class _TestRandom:
    """Python 版と Lua 版で同じ乱数列を出す、テスト用の乱数生成器 (Park–Miller 法)。

    環境変数 ZILPY_RNG_SEED があるときだけ使う (refactor-plan.md の Phase 0 のリプレイ用)。
    ZilRuntime.lua の同名の仕組みと、同じ種から同じ値の並びを返す。
    """

    _MODULUS = 2147483647
    _MULTIPLIER = 16807

    def __init__(self, seed: int) -> None:
        self.seed(seed)

    def seed(self, value: Any = None) -> None:
        """種を設定する (0 や None は 1 にする)。"""
        state = int(value or 1) % self._MODULUS
        self._state = state if state > 0 else 1

    def randint(self, low: int, high: int) -> int:
        """low から high までの整数を返す。"""
        self._state = self._state * self._MULTIPLIER % self._MODULUS
        return low + self._state % (high - low + 1)

    def getstate(self) -> int:
        return self._state

    def setstate(self, state: int) -> None:
        self._state = state


def _new_random() -> "_random.Random | _TestRandom":
    """ゲームコンテキストの乱数生成器を作る。"""
    seed = _os.environ.get("ZILPY_RNG_SEED")
    if seed:
        return _TestRandom(int(seed))
    return _random.Random()


class GameContext:
    """1 ゲームセッション分の状態・世界・辞書・アクション・入出力を保持するコンテキスト。"""

    def __init__(self) -> None:
        """空のゲームコンテキストを作る。"""
        # 名前 -> (値を求める関数, オブジェクトの ZIL 名)。宣言順に保持する。
        self._pending: dict[str, tuple[Callable[[], Any], str | None]] = {}
        self._resolving: set[str] = set()
        self._categories: dict[str, str] = {}
        self._entry: str = "GO"
        self.io = IOState()
        self.random = _new_random()
        self.const = ConstStore(self)
        self.state = StateStore(self)
        self.scratch = ScratchStore(self)
        self.world = WorldState(self)
        self.dictionary = Dictionary()
        self.actions = ActionRegistry(self)

    @property
    def _routine_names(self) -> set[str]:
        """互換用: ActionRegistry.routine_names を返す。"""
        return self.actions.routine_names

    @_contextlib.contextmanager
    def activate(self) -> Iterator["GameContext"]:
        """このコンテキストを現在のスレッド/タスクで有効化する。"""
        token = set_context(self)
        try:
            yield self
        finally:
            _current_context.reset(token)

    def _declare(
        self, name: str, thunk: Callable[[], Any], category: str = "state"
    ) -> None:
        """GLOBAL / CONSTANT の名前を宣言する。値は最初に参照された時に評価する。"""
        self.__dict__.pop(name, None)
        self._pending[name] = (thunk, None)
        self._categories[name] = category

    def _declare_object(
        self, name: str, zil_name: str, props: Callable[[], dict[str, Any]]
    ) -> None:
        """OBJECT / ROOM の名前を宣言する。"""
        self.__dict__.pop(name, None)
        self._pending[name] = (props, zil_name)
        self._categories[name] = "object"

    def routine(self, zil_name: str) -> Callable[[Callable[..., Any]], Callable[..., Any]]:
        """ROUTINE を、関数名と ZIL の名前で登録するデコレータ (`@ZG.routine("V-VERBOSE")`)。

        生成コードはこれを使う (refactor-plan.md Phase 6)。ZIL の名前は actions.zil_names に
        記録し、実行時エラーの表示などで使う。
        """

        def register(func: Callable[..., Any]) -> Callable[..., Any]:
            self.actions.zil_names[func.__name__] = zil_name
            return self._routine(func)

        return register

    def _routine(self, func: Callable[..., Any]) -> Callable[..., Any]:
        """ROUTINE を関数名で登録するデコレータ。"""
        self.__dict__[func.__name__] = func
        self.actions.routine_names.add(func.__name__)
        return func

    def _set(self, name: str, value: Any, category: str | None = None) -> Any:
        """グローバル変数へ代入する (式として使える SETG)。"""
        if category is not None and name not in self._categories:
            self._categories[name] = category
        self.__dict__[name] = value
        return value

    def __getattr__(self, name: str) -> Any:
        """未評価の宣言があれば評価して値を返す。"""
        pending = self.__dict__.get("_pending", {})
        if name not in pending:
            if name in _PROVIDERS:  # VERBS など、コンパイラが生成するテーブル
                value = _PROVIDERS[name]()
                self.__dict__[name] = value
                return value
            raise AttributeError(f"ZIL global {name!r} is not defined")
        if name in self._resolving:
            raise ZilError(f"circular definition of {name}")
        thunk, zil_name = pending[name]
        if zil_name is not None:
            obj = ZObject(zil_name, {})
            del pending[name]
            self.__dict__[name] = obj  # プロパティの評価より先に登録する
            _init_object(obj, thunk())
            return obj
        self._resolving.add(name)
        try:
            value = thunk()
        finally:
            self._resolving.discard(name)
        del pending[name]
        value = _apply_source_fixes(name, value)
        self.__dict__[name] = value
        return value

    def _link(self) -> None:
        """未評価の宣言をすべて評価する。"""
        for objects_first in (True, False):
            for name, (_, zil_name) in list(self._pending.items()):
                is_object = zil_name is not None
                if is_object == objects_first and name in self._pending:
                    getattr(self, name)
        if not self.io.embedded and self.io.initial_snapshot is None:
            # 通常の起動で RESTART したときに戻る状態を保存する (組み込む側は自分で保存する)
            with self.activate():
                self.io.initial_snapshot = snapshot_state()


# 互換性のための別名
ZilGlobals = GameContext

_default_context = GameContext()
_current_context: _contextvars.ContextVar[GameContext | None] = (
    _contextvars.ContextVar("zil_context", default=None)
)


def get_context() -> GameContext:
    """現在アクティブな GameContext を返す。"""
    ctx = _current_context.get()
    return _default_context if ctx is None else ctx


def set_context(ctx: GameContext | None) -> _contextvars.Token[GameContext | None]:
    """現在のタスクで使う GameContext を切り替える。"""
    return _current_context.set(ctx)


class _ContextProxy:
    """現在アクティブな GameContext へ委譲するプロキシ (`ZG`)。"""

    @property
    def __dict__(self) -> dict[str, Any]:
        return get_context().__dict__

    def __getattr__(self, name: str) -> Any:
        return getattr(get_context(), name)

    def __setattr__(self, name: str, value: Any) -> None:
        setattr(get_context(), name, value)


ZG = _ContextProxy()


# ほかのモジュールの名前 (関数の中からだけ使う)。循環 import を避けるため末尾で読む
from .objects import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    ZObject,
    _init_object,
)
from .saves import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    snapshot_state,
)
from .source_fixes import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _apply_source_fixes,
)
from .tables import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _make_header,
)
from .vocab import (  # noqa: E402  (呼ぶときにだけ要る名前。循環 import を避けるため末尾で読む)
    _PROVIDERS,
)
