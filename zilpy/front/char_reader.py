"""ソース文字列の読み出し。"""


class CharReader:
    """行・桁を追跡しながら文字列を 1 文字ずつ読み出すクラス。"""

    def __init__(self, text: str) -> None:
        """CharReader を初期化する。

        Args:
            text: 読み出し対象の文字列。
        """
        self.text: str = text
        self.i: int = 0
        self.line: int = 1
        self.col: int = 1

    def eof(self) -> bool:
        """末尾に到達したかを判定する。

        Returns:
            末尾に到達していれば True。
        """
        return self.i >= len(self.text)

    def peek(self, n: int = 0) -> str | None:
        """位置を進めずに文字を参照する。

        Args:
            n: 現在位置からのオフセット。

        Returns:
            参照した文字。範囲外の場合は None。
        """
        j = self.i + n
        if j >= len(self.text):
            return None
        return self.text[j]

    def get(self) -> str | None:
        """1 文字読み出し、位置を進める。

        Returns:
            読み出した文字。末尾に到達している場合は None。
        """
        if self.eof():
            return None
        ch = self.text[self.i]
        self.i += 1
        if ch == "\n":
            self.line += 1
            self.col = 1
        else:
            self.col += 1
        return ch

    def position(self) -> tuple[int, int, int]:
        """現在位置を返す。

        Returns:
            (index, line, col) のタプル。
        """
        return self.i, self.line, self.col
