"""ZIL の字句解析。"""

from zilpy.front.char_reader import CharReader
from zilpy.front.nodes import Span, Token


class Lexer:
    """ZIL ソースをトークン列に分割する字句解析器。"""

    DELIMS: dict[str, str] = {"<": "LT", ">": "GT", "(": "LP", ")": "RP"}
    MODIFIER: dict[str, str] = {
        ";": "SEMI",
        "%": "EVAL",
        "'": "QUOTE",
        "!": "LOAD",
    }
    ESCAPES: dict[str, str] = {"n": "\n", "t": "\t", '"': '"', "\\": "\\"}

    def __init__(self, reader: CharReader, comment: str = ";") -> None:
        """Lexer を初期化する。

        Args:
            reader: 文字の読み出し元。
            comment: コメント開始文字 (シンボルの終端として扱う)。
        """
        self.r: CharReader = reader
        self.comment: str = comment

    def _span_from(self, start_i: int, start_line: int, start_col: int) -> Span:
        """開始位置から現在位置までの Span を生成する。

        Args:
            start_i: 開始インデックス。
            start_line: 開始行番号。
            start_col: 開始桁番号。

        Returns:
            生成した Span。
        """
        end_i, _, _ = self.r.position()
        return Span(start=start_i, end=end_i, line=start_line, col=start_col)

    def _skip_whitespace(self) -> None:
        """現在位置から連続する空白文字を読み飛ばす。

        Returns:
            None
        """
        while (ch := self.r.peek()) is not None and ch.isspace():
            self.r.get()

    def next_token(self) -> Token:
        """次のトークンを読み出す。

        Returns:
            読み出したトークン。末尾の場合は種別 'EOF' のトークン。

        Raises:
            SyntaxError: 文字列リテラルが不正な場合。
        """
        self._skip_whitespace()

        start_i, start_line, start_col = self.r.position()
        ch = self.r.peek()

        if ch is None:
            span = Span(start_i, start_i, start_line, start_col)
            return Token("EOF", "", span)

        if ch in self.DELIMS:
            self.r.get()
            span = self._span_from(start_i, start_line, start_col)
            return Token(self.DELIMS[ch], ch, span)

        if ch in self.MODIFIER:
            self.r.get()
            span = self._span_from(start_i, start_line, start_col)
            return Token("EXP", self.MODIFIER[ch], span)

        if ch == '"':
            token_type = "STRING"
            text = self._read_string(start_line, start_col)
        else:
            token_type = "SYMBOL"
            text = self._read_symbol()

        span = self._span_from(start_i, start_line, start_col)
        return Token(token_type, text, span)

    def _read_string(self, start_line: int, start_col: int) -> str:
        """文字列リテラルを読み出し、エスケープを解除する。

        ZIL の文字列では `|` が改行を表す。`|` の直後にあるソース上の改行は
        読み飛ばす (`"DEADLINE|` のように `|` で行を終える書き方で、空行が
        入らないようにするため)。`\\|` と書いた場合は `|` そのものになる。

        Args:
            start_line: 開始引用符の行番号 (エラー表示用)。
            start_col: 開始引用符の桁番号 (エラー表示用)。

        Returns:
            エスケープ解除済みの文字列。

        Raises:
            SyntaxError: 文字列が閉じられていない、またはエスケープが不正な場合。
        """
        self.r.get()  # 開始引用符を消費
        buf: list[str] = []
        while True:
            c = self.r.get()
            if c is None:
                raise SyntaxError(
                    f"Unterminated string at {start_line}:{start_col}"
                )
            if c == '"':
                return "".join(buf)
            if c == "\\":
                nxt = self.r.get()
                if nxt is None:
                    raise SyntaxError(
                        f"Bad escape at {self.r.line}:{self.r.col}"
                    )
                buf.append(self.ESCAPES.get(nxt, nxt))
            elif c == "|":
                buf.append("\n")
                # `|` の直後のソース上の改行は、`|` の改行と重ねない
                if self.r.peek() == "\r":
                    self.r.get()
                if self.r.peek() == "\n":
                    self.r.get()
            else:
                buf.append(c)

    def _read_symbol(self) -> str:
        """空白・区切り文字・コメント文字の手前までをシンボルとして読む。

        Returns:
            読み出したシンボル (数値を含む) の文字列。
        """
        buf: list[str] = []
        while (c := self.r.peek()) is not None:
            if c.isspace() and buf == [","]:
                # `, PRSO` のように `,` と名前の間に空白があっても、`,PRSO` と同じ
                # (MDL の `,` は次の要素にかかる。例: Zork の <TELL "The " D, PRSO>)
                self._skip_whitespace()
                continue
            if c.isspace() or c in self.DELIMS or c in (self.comment, '"'):
                break  # <TELL", ...> のように、文字列の直前でシンボルを終える
            if c == "," and buf:
                # MDL では `,` が名前の区切りになる (例: Hitchhiker's Guide の
                # <PRSO?,GOWN> は PRSO? と ,GOWN の 2 つ)。先頭の `,` は GVAL の印
                break
            self.r.get()
            buf.append(c)
            if c == "\\":
                # `\` は次の 1 文字をそのままシンボルに含める (例: !\")
                escaped = self.r.get()
                if escaped is not None:
                    buf.append(escaped)
        return "".join(buf)
