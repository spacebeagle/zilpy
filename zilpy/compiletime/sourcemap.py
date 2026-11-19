"""生成コードの名前と、元の ZIL の名前・位置の対応表 (zilmap.json。refactor-plan.md §2.4)。

ZilPy.py が出力先に zilmap.json として書く。形:

    {
     "target": "python",
     "definitions": {
      "V_VERBOSE": {"zil": "V-VERBOSE", "kind": "ROUTINE", "file": "gverbs.zil", "line": 13, "module": "gverbs"},
      ...
     },
     "locals": {"V_TAKE": {"OBJ": "OBJ_l"}, ...}
    }

- definitions: トップレベルの定義 (ROUTINE・DEFINE・OBJECT・ROOM・GLOBAL・CONSTANT・SETG) と、
  マクロから作った関数 (kind は "DEFMAC"。位置は DEFMAC のもの)。キーは生成コードの名前。
  同じ名前を 2 度定義していれば、2 つ目以降を "redefined" に並べる
- locals: ルーチンごとの、名前が ZIL の名前の機械的な変換と違うローカル変数
  (ランタイムの名前とぶつかって `_l` を付けたものなど)。ZIL の名前 -> 生成コードの名前
"""

from __future__ import annotations

import json
from dataclasses import dataclass, field


@dataclass
class ZilMap:
    target: str
    definitions: dict[str, dict[str, object]] = field(default_factory=dict)
    locals: dict[str, dict[str, str]] = field(default_factory=dict)

    def add_definition(self, ident: str, zil: str, kind: str, file: str, line: int, module: str) -> None:
        entry: dict[str, object] = {"zil": zil, "kind": kind, "file": file, "line": line, "module": module}
        current = self.definitions.get(ident)
        if current is None:
            self.definitions[ident] = entry
        else:
            current.setdefault("redefined", []).append(  # type: ignore[union-attr]
                {k: v for k, v in entry.items() if k != "zil"}
            )

    def add_locals(self, routine: str, mapping: dict[str, str]) -> None:
        if mapping:
            self.locals.setdefault(routine, {}).update(mapping)

    def render(self) -> str:
        data = {
            "target": self.target,
            "definitions": dict(sorted(self.definitions.items())),
            "locals": {k: dict(sorted(v.items())) for k, v in sorted(self.locals.items())},
        }
        return json.dumps(data, ensure_ascii=False, indent=1) + "\n"


def load(text: str) -> ZilMap:
    """zilmap.json の文字列を読む (MCP サーバーのエラー表示などで使う)。"""
    data = json.loads(text)
    return ZilMap(data.get("target", ""), data.get("definitions", {}), data.get("locals", {}))
