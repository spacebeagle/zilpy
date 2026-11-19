"""GLOBAL・CONSTANT などの宣言を 1 つのモジュール (ZilGlobal.py) にまとめる。"""

import sys

from zilpy.constants import GLOBAL_MODULE, RUNTIME_MODULE


class ZilGlobalFile:
    """全 ZIL ファイルのグローバル宣言を集めて ZilGlobal.py の内容を作るクラス。

    同じ名前が別の値で宣言し直された場合は、警告を標準エラー出力に出し、
    ZilGlobal.py にもコメントで残す。ZILCH は後の宣言を黙って採用するが、
    原作ソースのバグ (例: Zork III の YUKS) のことがあるため。
    """

    def __init__(self) -> None:
        """空の宣言ファイルを作る。"""
        self._sections: list[tuple[str, list[str]]] = []
        # 名前 -> (取り込み元のモジュール名, 値を表す式, 分類)
        self._values: dict[str, tuple[str, str, str]] = {}
        # 別の値での宣言し直し (名前, 前の取り込み元, 前の値, 後の取り込み元, 後の値)
        self.redefinitions: list[tuple[str, str, str, str, str]] = []

    def add(
        self,
        source: str,
        lines: list[str],
        name: str | None = None,
        value: str | None = None,
        category: str = "state",
    ) -> None:
        """宣言を 1 つ追加する。

        直前の宣言と取り込み元が同じなら、同じ見出しの下にまとめる。

        Args:
            source: 宣言の取り込み元のモジュール名。
            lines: 宣言を表す Python の行のリスト。
            name: 宣言する名前 (宣言し直しの検出に使う)。
            value: 値を表す式 (宣言し直しの検出に使う)。
            category: 宣言の分類 ('const', 'state', 'scratch')。
        """
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
                    f"# 注意: {name} は {previous[0]} で別の値で宣言済み"
                    f" (後の宣言が使われる。前の値: {_shorten(previous[1])})\n{text}"
                )
            self._values[name] = (source, value, category)
        if not self._sections or self._sections[-1][0] != source:
            self._sections.append((source, []))
        self._sections[-1][1].append(text)

    def render(self) -> str:
        """ZilGlobal.py のソースコードを作る。

        Returns:
            Python ソースコード。
        """
        chunks = [
            f'"""ZIL のグローバル変数・定数の宣言 (自動生成)。\n\n'
            f"全 ZIL ファイルの GLOBAL / CONSTANT をここに集める。元のファイルには\n"
            f"コメントとして残してある。値は最初に参照された時に評価する。\n"
            f'"""\n\n'
            f"from {RUNTIME_MODULE} import *"
        ]
        for source, declarations in self._sections:
            chunks.append(f"# {'-' * 60}\n# {source}\n# {'-' * 60}")
            chunks += declarations
        return "\n\n".join(chunks) + "\n"

    @staticmethod
    def module_name() -> str:
        """出力するモジュール名を返す。

        Returns:
            import 文で使えるモジュール名。
        """
        return GLOBAL_MODULE


# コメントに載せる前の値の最大文字数
_SHORTEN_LENGTH = 80


def _shorten(text: str) -> str:
    """コメント用に、1 行で長すぎない文字列にする。

    Args:
        text: 元の文字列。

    Returns:
        改行を空白にし、長ければ末尾を省略した文字列。
    """
    text = " ".join(text.split())
    return text if len(text) <= _SHORTEN_LENGTH else text[: _SHORTEN_LENGTH - 3] + "..."
