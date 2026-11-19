"""GLOBAL・CONSTANT などの宣言を 1 つの Lua モジュール (ZilGlobal.lua) にまとめる。"""

from __future__ import annotations

import sys

from zilpy.constants import GLOBAL_MODULE, RUNTIME_MODULE

_SHORTEN_LENGTH = 80


def _shorten(text: str) -> str:
    """コメント用に、1 行で長すぎない文字列にする。"""
    text = " ".join(text.split())
    return text if len(text) <= _SHORTEN_LENGTH else text[: _SHORTEN_LENGTH - 3] + "..."


class ZilLuaGlobalFile:
    """全 ZIL ファイルのグローバル宣言を集めて ZilGlobal.lua の内容を作るクラス。"""

    def __init__(self) -> None:
        self._sections: list[tuple[str, list[str]]] = []
        self._values: dict[str, tuple[str, str, str]] = {}
        self.redefinitions: list[tuple[str, str, str, str, str]] = []

    def add(
        self,
        source: str,
        lines: list[str],
        name: str | None = None,
        value: str | None = None,
        category: str = "state",
    ) -> None:
        """宣言を 1 つ追加する。"""
        text = "\n".join(lines)
        if name is not None and value is not None:
            previous = self._values.get(name)
            if previous is not None and previous[1] != value:
                self.redefinitions.append((name, previous[0], previous[1], source, value))
                print(
                    f"Warning: {name} is redefined with a different value in {source}"
                    f" (first defined in {previous[0]}); the later definition is used",
                    file=sys.stderr,
                )
                text = (
                    f"-- 注意: {name} は {previous[0]} で別の値で宣言済み"
                    f" (後の宣言が使われる。前の値: {_shorten(previous[1])})\n{text}"
                )
            self._values[name] = (source, value, category)
        if not self._sections or self._sections[-1][0] != source:
            self._sections.append((source, []))
        self._sections[-1][1].append(text)

    def render(self) -> str:
        """ZilGlobal.lua のソースコードを作る。"""
        chunks = [
            f"-- ZIL のグローバル変数・定数の宣言 (自動生成・Lua 5.1 対応)\n"
            f'local ZG = require("{RUNTIME_MODULE}")'
        ]
        for source, declarations in self._sections:
            chunks.append(f"-- {'-' * 60}\n-- {source}\n-- {'-' * 60}")
            chunks += declarations
        chunks.append("return ZG")
        return "\n\n".join(chunks) + "\n"

    @staticmethod
    def module_name() -> str:
        """出力するモジュール名を返す。"""
        return GLOBAL_MODULE
