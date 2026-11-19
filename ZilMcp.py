"""ZilPy で変換した Infocom ゲームを、LLM が操作できる MCP サーバーとして公開する。

使い方:
    python ZilMcp.py out/zork1            # out/zork1/zork1.py を起動する
    python ZilMcp.py out/zork2
    python ZilMcp.py out/zork1 --entry zork1

ゲームは別スレッドで通常どおり (ZG.GO()) 動かし、ZilRuntime.set_io で
入出力だけを差し替える。変換したゲームのコードには手を入れない。
MCP の通信は標準入出力の JSON-RPC 2.0 (1 行 1 メッセージ) で、外部の
パッケージには依存しない。

公開するツール:
    send_command  英語のコマンドを 1 つ送り、次の入力待ちまでの出力を返す
    look_state    プレイヤーが今知覚できる範囲の状態 (場所・持ち物・見える物) を返す
    restart_game  ゲームを最初からやり直す
"""

from __future__ import annotations

import argparse
import importlib
import json
import queue
import sys
import threading
import traceback
from pathlib import Path
from typing import Any

SERVER_NAME = "zilpy-infocom"
SERVER_VERSION = "0.1.0"
DEFAULT_PROTOCOL_VERSION = "2025-06-18"
# コマンドを送ってから、次の入力待ちになるまで待つ最大秒数
COMMAND_TIMEOUT = 30.0
# 1 つのコマンドとして受け付ける最大文字数 (ゲームの入力バッファに合わせる)
MAX_COMMAND_LENGTH = 100
# 自動 Undo 履歴の最大保持数
MAX_UNDO_HISTORY = 20

INSTRUCTIONS = """\
This server runs an original Infocom text adventure (transcoded from ZIL to Python by ZilPy).
The game engine is the only authority on the game world: objects can be moved, used or changed
only through send_command. Never narrate an effect that the game output did not report.

- send_command takes ONE English command in classic Infocom style
  (e.g. "open mailbox", "take lamp", "put coin in case", "north", "inventory", "look").
  Each command advances the game clock by a turn, so do not send commands the player did not intend.
- If the game asks a question (e.g. "Which lamp do you mean ...?"), answer it with the next send_command.
- look_state returns only what the player can currently perceive. Use it to ground descriptions,
  not to solve puzzles for the player.
- save_state / restore_state / undo / list_states manage fast in-memory snapshots and turn rollback.
- "save" / "restore" / "restart" / "quit" also work as in-game commands; restart_game starts over.
"""

TOOLS: list[dict[str, Any]] = [
    {
        "name": "send_command",
        "description": (
            "Send one English command to the Infocom game (e.g. 'take lamp', 'north', "
            "'ask george about will'). Returns the game's text output up to the next prompt. "
            "Starts the game automatically on first use (the opening text is included)."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "command": {
                    "type": "string",
                    "description": "One command line in English, as typed at the '>' prompt.",
                }
            },
            "required": ["command"],
        },
    },
    {
        "name": "look_state",
        "description": (
            "Return what the player can currently perceive, as JSON: the current location, "
            "whether it is lit, the inventory, and the visible objects in the location. "
            "Each object lists the nouns/adjectives the parser accepts for it "
            "(truncated to their first 6 letters, which is all the parser compares). "
            "Does not reveal hidden objects, other rooms or puzzle solutions."
        ),
        "inputSchema": {"type": "object", "properties": {}},
    },
    {
        "name": "restart_game",
        "description": "Restart the game from the beginning and return the opening text.",
        "inputSchema": {"type": "object", "properties": {}},
    },
    {
        "name": "save_state",
        "description": (
            "Save the current game state into an in-memory named slot "
            "(does not advance the game clock or require disk writes)."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "slot": {
                    "type": "string",
                    "description": "Slot name (defaults to 'default').",
                }
            },
        },
    },
    {
        "name": "restore_state",
        "description": (
            "Restore a previously saved game state from an in-memory named slot "
            "and return the restored perceptible state."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "slot": {
                    "type": "string",
                    "description": "Slot name to restore (defaults to 'default').",
                }
            },
        },
    },
    {
        "name": "undo",
        "description": (
            "Roll back the game state by one or more recent send_command calls "
            "using automatic in-memory snapshots."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "steps": {
                    "type": "integer",
                    "description": "Number of commands to undo (defaults to 1).",
                    "minimum": 1,
                }
            },
        },
    },
    {
        "name": "list_states",
        "description": "List saved in-memory snapshot slots and the available undo history.",
        "inputSchema": {"type": "object", "properties": {}},
    },
]


class _Stop(Exception):
    """ゲームのスレッドを止めるために、入力待ちの中から投げる例外。"""


# 入力キューに入れる、コマンド以外の指示
_RESTART = object()
_STOP = object()


class GameSession:
    """1 つのゲームを別スレッドで動かし、コマンド単位でやりとりする。

    ゲームのスレッドは READ (入力待ち) で止まり、コマンドを受け取ると次の
    入力待ちまで進む。状態の照会はゲームが入力待ちで止まっている間だけ行うので、
    スレッド間で状態が食い違うことはない。
    """

    def __init__(self, game_dir: Path, entry: str) -> None:
        """セッションを作る (ゲームはまだ読み込まない)。

        Args:
            game_dir: 変換したゲームのディレクトリ (out/zork1 など)。
            entry: 起動するモジュール名 (zork1 など)。
        """
        self.game_dir = game_dir
        self.entry = entry
        self._commands: queue.Queue[Any] = queue.Queue()
        self._output: list[str] = []
        self._lock = threading.Lock()
        # ゲームが入力待ちになったか、終了したときに立つ
        self._idle = threading.Event()
        self._thread: threading.Thread | None = None
        self._runtime: Any = None
        self._snapshot: bytes | None = None
        self._history: list[str] = []
        self._slots: dict[str, tuple[bytes, list[str], tuple[tuple[str, str, int], ...] | None]] = {}
        self._undo_stack: list[
            tuple[str, bytes, int, tuple[tuple[str, str, int], ...] | None]
        ] = []
        self.end_reason: str | None = None

    # ------------------------------------------------------------------
    # ゲームの読み込みと実行
    # ------------------------------------------------------------------

    def _load(self) -> None:
        """ゲームのモジュールを読み込み、開始時の状態を保存する。"""
        # ゲームのディレクトリを先頭にして、そこにコピーされた ZilRuntime と
        # ZilGlobal を使う (変換したコードと同じものを読み込むため)
        sys.path.insert(0, str(self.game_dir))
        runtime = importlib.import_module("ZilRuntime")
        runtime.set_io(
            output=self._write,
            input_line=self._read_line,
            embedded=True,
            save_file=self.game_dir / f"{self.entry}-mcp{runtime.SAVE_SUFFIX}",
        )
        importlib.import_module(self.entry)
        runtime.ZG._link()
        self._runtime = runtime
        # RESTART のために、GO を始める前の状態を保存しておく
        self._snapshot = runtime.snapshot_state()

    def _write(self, text: str) -> None:
        """ゲームの出力を溜める (ZilRuntime の出力の差し込み口)。

        Args:
            text: 出力された文字列。
        """
        with self._lock:
            self._output.append(text)

    def _read_line(self) -> str:
        """次のコマンドを待って返す (ZilRuntime の入力の差し込み口)。

        Returns:
            コマンドの文字列。

        Raises:
            ZilRestart: restart_game が呼ばれた場合。
            _Stop: サーバーが終了する場合。
        """
        self._idle.set()
        command = self._commands.get()
        if command is _RESTART:
            raise self._runtime.ZilRestart()
        if command is _STOP:
            raise _Stop()
        return command

    def _run(self) -> None:
        """ゲームのスレッドの本体。RESTART なら開始時の状態に戻して GO をやり直す。"""
        runtime = self._runtime
        try:
            while True:
                try:
                    entry_fn = getattr(runtime.ZG, getattr(runtime.ZG, "_entry", "GO"))
                    entry_fn()
                    self.end_reason = "The game has ended."
                    return
                except runtime.ZilRestart:
                    runtime.restore_snapshot(self._snapshot)
                    continue
                except SystemExit:  # QUIT (ZilQuit) や、ゲームの終了
                    self.end_reason = "The game has ended (quit)."
                    return
                except _Stop:
                    return
                except Exception:  # noqa: BLE001  ゲーム側のエラーも利用者に返す
                    self._write(
                        "\n[ZilPy runtime error]\n" + traceback.format_exc() + self._zil_stack(sys.exc_info()[2])
                    )
                    self.end_reason = "The game stopped because of a runtime error."
                    return
        finally:
            self._idle.set()

    def _zil_stack(self, tb: Any) -> str:
        """traceback のうちゲームのモジュールのフレームを、元の ZIL のルーチンと位置にする。

        出力先の zilmap.json (ZilPy.py が書く対応表) で、フレームの関数名 (生成コードの
        ルーチンの名前) から ZIL の名前・ファイル・行を引く (refactor-plan.md Phase 6)。
        ランタイム (zilrt) のフレームは載せない。
        """
        definitions: dict[str, Any] = {}
        map_path = self.game_dir / "zilmap.json"
        if map_path.exists():
            try:
                definitions = json.loads(map_path.read_text(encoding="utf-8")).get("definitions", {})
            except (OSError, ValueError):
                definitions = {}
        game_dir = self.game_dir.resolve()
        lines = []
        for frame in traceback.extract_tb(tb):
            path = Path(frame.filename)
            if path.parent.resolve() != game_dir or path.name == "ZilRuntime.py":
                continue
            entry = definitions.get(frame.name)
            if entry:
                where = f"{entry['kind']} {entry['zil']} ({entry['file']}:{entry['line']})"
            else:
                where = frame.name
            lines.append(f"  {where}  [{path.name} line {frame.lineno}]")
        if not lines:
            return ""
        return "ZIL call stack (most recent call last):\n" + "\n".join(lines) + "\n"

    def _start_thread(self) -> None:
        """ゲームのスレッドを開始し、最初の入力待ちまで進める。"""
        self.end_reason = None
        self._idle.clear()
        self._thread = threading.Thread(target=self._run, name="zil-game", daemon=True)
        self._thread.start()
        self._idle.wait(COMMAND_TIMEOUT)

    @property
    def running(self) -> bool:
        """ゲームのスレッドが動いているか。"""
        return self._thread is not None and self._thread.is_alive()

    def _take_output(self) -> str:
        """溜まった出力を取り出して空にする。

        Returns:
            出力の文字列。
        """
        with self._lock:
            text = "".join(self._output)
            self._output.clear()
        return text

    def _finish_reply(self, completed: bool) -> str:
        """コマンドへの返答を組み立てる。

        Args:
            completed: 時間内に次の入力待ちになったか。

        Returns:
            返答の文字列。
        """
        text = self._take_output()
        if not completed:
            text += f"\n[The game did not return to the prompt within {COMMAND_TIMEOUT:.0f}s.]"
        elif not self.running and self.end_reason:
            text += f"\n[{self.end_reason} Use restart_game to play again.]"
        return text

    # ------------------------------------------------------------------
    # ツールの処理
    # ------------------------------------------------------------------

    def ensure_started(self) -> None:
        """ゲームがまだ始まっていなければ読み込んで開始する。"""
        if self._runtime is None:
            self._load()
            self._start_thread()

    def _stack_sig(self) -> tuple[tuple[str, str, int], ...] | None:
        """ゲームスレッドの現在のコールスタック署名を返す。"""
        if not self.running or self._thread is None or self._thread.ident is None:
            return None
        frame = sys._current_frames().get(self._thread.ident)
        if frame is None:
            return None
        sig: list[tuple[str, str, int]] = []
        while frame is not None:
            sig.append((frame.f_code.co_filename, frame.f_code.co_name, frame.f_lineno))
            frame = frame.f_back
        return tuple(sig)

    def _restore_snapshot_entry(
        self,
        snap: bytes,
        history: list[str],
        saved_sig: tuple[tuple[str, str, int], ...] | None,
    ) -> None:
        """スナップショットを復元する。コールスタックが異なる場合や終了後は再実行で巻き戻す。"""
        if self.running and saved_sig is not None and self._stack_sig() == saved_sig:
            if not self._runtime.restore_snapshot(snap):
                raise RuntimeError("Failed to restore snapshot")
            self._history = list(history)
            self._take_output()
            return
        # コールスタックが異なる (死亡・Y/N・別モード等) か終了済みの場合は最初から巻き戻す
        self._take_output()
        if self.running:
            self._idle.clear()
            self._commands.put(_RESTART)
            if not self._idle.wait(COMMAND_TIMEOUT):
                raise RuntimeError("Timed out restarting game for restore")
        else:
            self._runtime.restore_snapshot(self._snapshot)
            self._start_thread()
        for cmd in history:
            if not self.running:
                break
            self._idle.clear()
            self._commands.put(cmd)
            if not self._idle.wait(COMMAND_TIMEOUT):
                raise RuntimeError(f"Timed out replaying command {cmd!r} during restore")
        if not self._runtime.restore_snapshot(snap):
            raise RuntimeError("Failed to restore snapshot after replay")
        self._history = list(history)
        self._take_output()

    def send_command(self, command: str) -> str:
        """コマンドを 1 つ送り、次の入力待ちまでの出力を返す。

        Args:
            command: 英語のコマンド。

        Returns:
            ゲームの出力 (初回は開始時の文章を含む)。
        """
        self.ensure_started()
        if not self.running:
            return self._finish_reply(True) or f"[{self.end_reason} Use restart_game to play again.]"
        line = " ".join(command.split())[:MAX_COMMAND_LENGTH]
        snap = self._runtime.snapshot_state()
        self._undo_stack.append((line, snap, len(self._history), self._stack_sig()))
        if len(self._undo_stack) > MAX_UNDO_HISTORY:
            del self._undo_stack[0]
        self._history.append(line)
        self._idle.clear()
        self._commands.put(line)
        return self._finish_reply(self._idle.wait(COMMAND_TIMEOUT))

    def restart(self) -> str:
        """ゲームを最初からやり直し、開始時の文章を返す。

        Returns:
            開始時の文章。
        """
        self._undo_stack.clear()
        self._history.clear()
        if self._runtime is None:
            self.ensure_started()
            return self._finish_reply(True)
        self._take_output()
        if self.running:
            self._idle.clear()
            self._commands.put(_RESTART)
            return self._finish_reply(self._idle.wait(COMMAND_TIMEOUT))
        self._runtime.restore_snapshot(self._snapshot)
        self._start_thread()
        return self._finish_reply(True)

    def save_state(self, slot: str = "default") -> dict[str, Any]:
        """現在のゲーム状態をメモリ上の指定スロットへ保存する。"""
        self.ensure_started()
        if not self.running:
            raise RuntimeError(f"Cannot save state: {self.end_reason or 'game is not running'}")
        slot_name = slot.strip() or "default"
        self._slots[slot_name] = (
            self._runtime.snapshot_state(),
            list(self._history),
            self._stack_sig(),
        )
        return {
            "saved": True,
            "slot": slot_name,
            "slots": sorted(self._slots),
            "location": self.look_state().get("location"),
        }

    def restore_state(self, slot: str = "default") -> dict[str, Any]:
        """メモリ上の指定スロットからゲーム状態を復元する。"""
        self.ensure_started()
        slot_name = slot.strip() or "default"
        entry = self._slots.get(slot_name)
        if entry is None:
            raise ValueError(f"No saved state in slot {slot_name!r}. Available: {sorted(self._slots)}")
        snap, history, saved_sig = entry
        self._restore_snapshot_entry(snap, history, saved_sig)
        return {"restored": True, "slot": slot_name, "state": self.look_state()}

    def undo(self, steps: int = 1) -> dict[str, Any]:
        """直近の send_command 実行前の状態へ巻き戻す。"""
        self.ensure_started()
        if steps < 1:
            raise ValueError("steps must be >= 1")
        if len(self._undo_stack) < steps:
            raise ValueError(
                f"Cannot undo {steps} step(s); only {len(self._undo_stack)} snapshot(s) in history"
            )
        undone_commands: list[str] = []
        target_snap = b""
        target_hist_len = 0
        target_sig = None
        for _ in range(steps):
            cmd, target_snap, target_hist_len, target_sig = self._undo_stack.pop()
            undone_commands.append(cmd)
        self._restore_snapshot_entry(
            target_snap, self._history[:target_hist_len], target_sig
        )
        return {
            "undone": undone_commands,
            "remaining_undo": len(self._undo_stack),
            "state": self.look_state(),
        }

    def list_states(self) -> dict[str, Any]:
        """保存済みメモリスロットと Undo 履歴を返す。"""
        return {
            "slots": sorted(self._slots),
            # undo の履歴の要素は (コマンド, スナップショット, 履歴の長さ, コールスタック)
            "undo_history": [entry[0] for entry in self._undo_stack],
        }

    def stop(self) -> None:
        """ゲームのスレッドを止める (サーバーの終了時)。"""
        if self.running:
            self._commands.put(_STOP)

    def look_state(self) -> dict[str, Any]:
        """プレイヤーが今知覚できる範囲の状態を返す。

        暗い場所では持ち物だけを返す。見える物は、場所に直接ある物と、
        開いている・透明な入れ物や台の上にある物に限る (隠れた物は含めない)。

        Returns:
            状態を表す辞書。
        """
        self.ensure_started()
        if not self.running:
            return {"game": self.game_dir.name, "status": self.end_reason}
        rt = self._runtime
        zg = rt.ZG
        winner = getattr(zg, "WINNER", None)
        here = getattr(zg, "HERE", None)
        lit = bool(getattr(zg, "LIT", True))
        # ゲーム名はディレクトリ名 (起動するモジュールが s4 や z6 の作品もあるため)
        state: dict[str, Any] = {"game": self.game_dir.name}
        if isinstance(here, rt.ZObject):
            state["location"] = rt._describe(here) if lit else "(darkness)"
        state["lit"] = lit
        if isinstance(winner, rt.ZObject):
            state["inventory"] = self._contents(winner, set())
        if lit and isinstance(here, rt.ZObject):
            skip = {id(winner)} if isinstance(winner, rt.ZObject) else set()
            state["visible"] = self._contents(here, skip)
        return state

    def _vocabulary(self, obj: Any) -> tuple[list[str], list[str]]:
        """オブジェクトを指すのに使える名詞と形容詞を返す。

        パーサーは単語の先頭 6 文字だけを区別するので、辞書の単語も
        6 文字に切り詰められている (例: screwdriver は "screwd")。

        Args:
            obj: 対象のオブジェクト。

        Returns:
            (名詞のリスト, 形容詞のリスト)。
        """
        rt = self._runtime
        nouns: list[str] = []
        synonyms = obj.get("SYNONYM")
        if isinstance(synonyms, rt.Table):
            nouns = [str(cell) for cell in synonyms.cells if isinstance(cell, str)]
        adjectives: list[str] = []
        numbers = obj.get("ADJECTIVE")
        if isinstance(numbers, rt.Table):
            names = {
                number: word
                for word, number in rt.get_context().dictionary.adjective_ids.items()
            }
            for cell in numbers.cells:
                if isinstance(cell, str):  # V4 以降は単語のワードの並び
                    adjectives.append(str(cell))
                elif isinstance(cell, int) and cell in names:  # V3 は形容詞番号
                    adjectives.append(names[cell])
        return nouns, adjectives

    def _contents(self, container: Any, skip: set[int]) -> list[dict[str, Any]]:
        """入れ物の中で見える物の一覧を返す。

        Args:
            container: 調べるオブジェクト。
            skip: 除外するオブジェクトの id (プレイヤー自身など)。

        Returns:
            物ごとの辞書のリスト。中身が見える物は "contains" を持つ。
        """
        rt = self._runtime
        items: list[dict[str, Any]] = []
        for child in container.children:
            flags = child.get("FLAGS", set())
            if id(child) in skip or "INVISIBLE" in flags:
                continue
            item: dict[str, Any] = {"name": rt._describe(child)}
            # 表示名だけでは何の物か分からないことがある (Hitchhiker's Guide の
            # 背景の物は DESC が "it")。コマンドで使える名詞と形容詞も返す
            nouns, adjectives = self._vocabulary(child)
            if nouns:
                item["nouns"] = nouns
            if adjectives:
                item["adjectives"] = adjectives
            notes = [
                label
                for flag, label in (
                    ("PERSON", "person"),
                    ("ACTORBIT", "person"),
                    ("OPENBIT", "open"),
                    ("ONBIT", "lit"),
                    ("NDESCBIT", "scenery"),
                )
                if flag in flags
            ]
            if notes:
                item["notes"] = sorted(set(notes))
            see_inside = flags & {"OPENBIT", "TRANSBIT", "SURFACEBIT"}
            if child.children and see_inside:
                inner = self._contents(child, skip)
                if inner:
                    item["contains"] = inner
            items.append(item)
        return items


class McpServer:
    """標準入出力で JSON-RPC 2.0 を話す、最小限の MCP サーバー。"""

    def __init__(self, session: GameSession, out: Any) -> None:
        """サーバーを作る。

        Args:
            session: 操作するゲームのセッション。
            out: 応答を書き出すバイナリストリーム (本来の標準出力)。
        """
        self.session = session
        self._out = out

    def _send(self, message: dict[str, Any]) -> None:
        """メッセージを 1 行の JSON として書き出す。

        Args:
            message: 送るメッセージ。
        """
        data = json.dumps(message, ensure_ascii=False) + "\n"
        self._out.write(data.encode("utf-8"))
        self._out.flush()

    def _result(self, request_id: Any, result: dict[str, Any]) -> None:
        """成功の応答を送る。"""
        self._send({"jsonrpc": "2.0", "id": request_id, "result": result})

    def _error(self, request_id: Any, code: int, message: str) -> None:
        """エラーの応答を送る。"""
        self._send(
            {"jsonrpc": "2.0", "id": request_id, "error": {"code": code, "message": message}}
        )

    def handle(self, message: dict[str, Any]) -> None:
        """1 つのメッセージを処理する。

        Args:
            message: 受け取った JSON-RPC のメッセージ。
        """
        method = message.get("method")
        request_id = message.get("id")
        params = message.get("params") or {}
        if request_id is None:
            return  # 通知 (notifications/initialized など) には応答しない
        if method == "initialize":
            self._result(
                request_id,
                {
                    "protocolVersion": params.get("protocolVersion", DEFAULT_PROTOCOL_VERSION),
                    "capabilities": {"tools": {}},
                    "serverInfo": {"name": SERVER_NAME, "version": SERVER_VERSION},
                    "instructions": INSTRUCTIONS
                    + f"\nGame: {self.session.game_dir.name} ({self.session.game_dir})",
                },
            )
        elif method == "ping":
            self._result(request_id, {})
        elif method == "tools/list":
            self._result(request_id, {"tools": TOOLS})
        elif method == "tools/call":
            self._call_tool(request_id, params)
        else:
            self._error(request_id, -32601, f"Method not found: {method}")

    def _call_tool(self, request_id: Any, params: dict[str, Any]) -> None:
        """tools/call を処理する。

        Args:
            request_id: 要求の id。
            params: ツール名と引数。
        """
        name = params.get("name")
        args = params.get("arguments") or {}
        try:
            if name == "send_command":
                command = args.get("command")
                if not isinstance(command, str) or not command.strip():
                    raise ValueError("command must be a non-empty string")
                text = self.session.send_command(command)
            elif name == "look_state":
                text = json.dumps(self.session.look_state(), ensure_ascii=False, indent=2)
            elif name == "restart_game":
                text = self.session.restart()
            elif name == "save_state":
                slot = args.get("slot", "default")
                if not isinstance(slot, str):
                    raise ValueError("slot must be a string")
                text = json.dumps(self.session.save_state(slot), ensure_ascii=False, indent=2)
            elif name == "restore_state":
                slot = args.get("slot", "default")
                if not isinstance(slot, str):
                    raise ValueError("slot must be a string")
                text = json.dumps(self.session.restore_state(slot), ensure_ascii=False, indent=2)
            elif name == "undo":
                steps = args.get("steps", 1)
                if isinstance(steps, bool) or not isinstance(steps, int):
                    raise ValueError("steps must be an integer")
                text = json.dumps(self.session.undo(steps), ensure_ascii=False, indent=2)
            elif name == "list_states":
                text = json.dumps(self.session.list_states(), ensure_ascii=False, indent=2)
            else:
                self._error(request_id, -32602, f"Unknown tool: {name}")
                return
        except Exception as error:  # noqa: BLE001  ツールの失敗として返す
            self._result(
                request_id,
                {"content": [{"type": "text", "text": f"Error: {error}"}], "isError": True},
            )
            return
        self._result(request_id, {"content": [{"type": "text", "text": text}], "isError": False})

    def serve(self, stream: Any) -> None:
        """入力が閉じられるまでメッセージを処理する。

        Args:
            stream: 要求を読み込むバイナリストリーム (標準入力)。
        """
        for raw in stream:
            line = raw.decode("utf-8", errors="replace").strip()
            if not line:
                continue
            try:
                message = json.loads(line)
            except json.JSONDecodeError:
                self._error(None, -32700, "Parse error")
                continue
            if isinstance(message, dict):
                self.handle(message)


def _detect_entry(game_dir: Path) -> str:
    """起動するエントリモジュール名をディレクトリから自動判定する。"""
    default_name = game_dir.name
    if (game_dir / f"{default_name}.py").exists():
        return default_name
    for py_file in sorted(game_dir.glob("*.py")):
        if py_file.name in ("ZilRuntime.py", "ZilGlobal.py"):
            continue
        text = py_file.read_text(encoding="utf-8", errors="ignore")
        if 'if __name__ == "__main__":' in text and "ZG._link()" in text:
            return py_file.stem
    return default_name


def main() -> None:
    """コマンドライン引数を読み、MCP サーバーを起動する。"""
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("game_dir", help="変換したゲームのディレクトリ (例: out/zork1)")
    parser.add_argument("--entry", help="起動するモジュール名 (省略時は自動判定)")
    args = parser.parse_args()

    game_dir = Path(args.game_dir)
    if not game_dir.is_absolute():
        # Claude Code などがどのディレクトリから起動しても動くように、
        # このファイルの場所を基準にする
        game_dir = Path(__file__).resolve().parent / game_dir
    entry = args.entry or _detect_entry(game_dir)
    if not (game_dir / f"{entry}.py").exists():
        sys.exit(f"{game_dir / (entry + '.py')} が見つかりません")

    # 標準出力は MCP の通信に使うので、ゲームなどの print が混ざらないよう
    # 通常の出力は標準エラーへ回す
    protocol_out = sys.stdout.buffer
    sys.stdout = sys.stderr
    session = GameSession(game_dir, entry)
    server = McpServer(session, protocol_out)
    try:
        server.serve(sys.stdin.buffer)
    finally:
        session.stop()


if __name__ == "__main__":
    main()
