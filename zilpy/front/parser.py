"""ZIL の構文解析。"""

import sys

from zilpy.front.lexer import Lexer
from zilpy.front.nodes import Span, Token, ZExp, ZList, ZNode, ZString, ZSymbol


class Parser:
    """トークン列から ZIL の AST を構築する構文解析器。"""

    def __init__(self, lexer: Lexer) -> None:
        """Parser を初期化し、最初のトークンを読み込む。

        Args:
            lexer: トークンの供給元。
        """
        self.lx: Lexer = lexer
        self.cur: Token = self.lx.next_token()

    def _error_at(self, message: str, span: Span) -> SyntaxError:
        """位置情報付きの SyntaxError を生成する。

        Args:
            message: エラーメッセージ。
            span: エラー位置。

        Returns:
            生成した SyntaxError。
        """
        return SyntaxError(f"{message} at {span.line}:{span.col}")

    def _eat(self, typ: str) -> Token:
        """現在のトークンが指定種別であることを確認して消費する。

        Args:
            typ: 期待するトークン種別。

        Returns:
            消費したトークン。

        Raises:
            SyntaxError: トークン種別が一致しない場合。
        """
        if self.cur.type != typ:
            raise self._error_at(
                f"Expected {typ}, got {self.cur.type}", self.cur.span
            )
        token = self.cur
        self.cur = self.lx.next_token()
        return token

    def parse_all(self) -> list[ZNode]:
        """入力末尾まですべての式を解析する。

        Returns:
            トップレベルノードのリスト。

        Raises:
            SyntaxError: 構文が不正な場合。
        """
        nodes: list[ZNode] = []
        while self.cur.type != "EOF":
            if self.cur.type in ("GT", "RP"):
                # トップレベルに余った閉じ括弧は読み飛ばす (元のコンパイラと同じ扱い。
                # 例: Suspended の people.zil の ENOUGH-TRADING の末尾の `>>>`)
                span = self.cur.span
                print(
                    f"Warning: ignored unmatched {self.cur.value!r} at {span.line}:{span.col}",
                    file=sys.stderr,
                )
                self.cur = self.lx.next_token()
                continue
            nodes.append(self.parse_expr())
        return nodes

    def parse_expr(self) -> ZNode:
        """1 つの式を解析する。

        Returns:
            解析したノード。

        Raises:
            SyntaxError: 予期しないトークンが現れた場合。
        """
        typ = self.cur.type
        if typ == "LT":
            return self.parse_list("LT", "GT", "angle")
        if typ == "LP":
            return self.parse_list("LP", "RP", "paren")
        if typ == "STRING":
            token = self._eat("STRING")
            return ZString(token.value, token.span)
        if typ == "SYMBOL":
            token = self._eat("SYMBOL")
            if token.value == "," and self.cur.type == "LT":
                # `,<式>` は式が返す名前のグローバル値 (例: Suspended の
                # <SET LOC ,<GETP .HERE ,P?STATION>>)。ZilPy ではプロパティに
                # オブジェクトそのものが入っているので、式の値をそのまま使う
                return ZExp("GVAL", self.parse_expr(), token.span)
            if (
                token.value.startswith("#")
                and len(token.value) > 1
                and self.cur.type not in ("EOF", "GT", "RP")
            ):
                # `#TYPE expr` (例: #DECL ((X) FIX)) は直後の式と組にする
                item = self.parse_expr()
                return ZExp(token.value.upper(), item, token.span)
            return ZSymbol(token.value, token.span)
        if typ == "EXP":
            token = self._eat("EXP")
            item = self.parse_expr() if self.cur.type != "EOF" else None
            return ZExp(token.value, item, token.span)
        raise self._error_at(f"Unexpected token {typ}", self.cur.span)

    def parse_list(self, open_t: str, close_t: str, kind: str) -> ZList:
        """開き括弧から対応する閉じ括弧までのリストを解析する。

        Args:
            open_t: 開き括弧のトークン種別。
            close_t: 閉じ括弧のトークン種別。
            kind: 生成する ZList の種別 ('angle' または 'paren')。

        Returns:
            解析したリストノード。

        Raises:
            SyntaxError: リストが閉じられていない場合。
        """
        open_tok = self._eat(open_t)
        items: list[ZNode] = []
        while self.cur.type != close_t:
            if self.cur.type == "EOF":
                raise self._error_at(
                    f"Unterminated {kind} list opened", open_tok.span
                )
            items.append(self.parse_expr())
        close_tok = self._eat(close_t)
        # span は開き括弧から閉じ括弧までを覆う
        span = Span(
            open_tok.span.start,
            close_tok.span.end,
            open_tok.span.line,
            open_tok.span.col,
        )
        return ZList(kind, items, span)
