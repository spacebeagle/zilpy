"""ZIL ファイルを読み込んで AST を生成する。"""

from pathlib import Path

from zilpy.front.char_reader import CharReader
from zilpy.constants import STRING_PREVIEW_LEN
from zilpy.front.lexer import Lexer
from zilpy.compiletime.loader import expand_load_macros
from zilpy.front.nodes import ZExp, ZList, ZNode, ZString, ZSymbol
from zilpy.front.parser import Parser


def parse_source(text: str, comment_char: str = ";") -> list[ZNode]:
    """ZIL のソースの文字列を AST にする (ZilCompiler.read_zil_file の中身)。

    Args:
        text: ZIL のソース。
        comment_char: コメント開始文字。

    Returns:
        トップレベルノードのリスト。
    """
    lexer = Lexer(CharReader(text), comment_char)
    return expand_load_macros(Parser(lexer).parse_all())


class ZilCompiler:
    """ZIL ファイルを読み込み、AST を生成するクラス。"""

    def __init__(self, fname: str) -> None:
        """ZilCompiler を初期化する。

        Args:
            fname: 読み込む ZIL ファイルのパス。
        """
        self.path: str = fname
        self.source: str = ""  # read_zil_file で読んだソースの文字列

    def read_zil_file(
        self, encoding: str = "utf-8", comment_char: str = ";"
    ) -> list[ZNode]:
        """ZIL ファイルを読み込み、AST に変換する。

        Args:
            encoding: ファイルの文字エンコーディング。
            comment_char: コメント開始文字。

        Returns:
            トップレベルノードのリスト。

        Raises:
            OSError: ファイルを読み込めない場合。
            SyntaxError: ZIL の構文が不正な場合。
        """
        text = Path(self.path).read_text(encoding=encoding, errors="replace")
        # ソースの文字列は、マクロの定義の原文をコメントにして残すのに使う (Span で切り出す)
        self.source: str = text
        return parse_source(text, comment_char)

    def print_ast(self, node: ZNode | list[ZNode], indent: int = 0) -> None:
        """AST を見やすく表示する (単一ノードでもリストでも対応)。

        Args:
            node: 表示対象のノード、またはトップレベルノードのリスト。
            indent: インデントの深さ。

        Returns:
            None
        """
        prefix = "  " * indent

        # リストが渡された場合（トップレベル）
        if isinstance(node, list):
            print(f"{prefix}=== ZIL File: {self.path} ===")
            print(f"{prefix}Top-level nodes: {len(node)}\n")
            for i, child in enumerate(node):
                print(f"{prefix}[{i:03d}] ", end="")
                self.print_ast(child, indent)
            return

        if isinstance(node, ZSymbol):
            print(f"{prefix}SYMBOL: {node.text}")
        elif isinstance(node, ZString):
            text = node.text
            if len(text) > STRING_PREVIEW_LEN:
                text = text[:STRING_PREVIEW_LEN] + "..."
            print(f'{prefix}STRING: "{text}"')
        elif isinstance(node, ZExp):
            print(f"{prefix}EXP({node.kind}):")
            if node.item is not None:
                self.print_ast(node.item, indent + 1)
            else:
                print(f"{prefix}  (empty)")
        elif isinstance(node, ZList):
            kind = "ANGLE" if node.kind == "angle" else "PAREN"
            print(f"{prefix}{kind} LIST ({len(node.items)} items):")
            for item in node.items:
                self.print_ast(item, indent + 1)
        else:
            print(f"{prefix}UNKNOWN NODE: {type(node).__name__}")

    def dump(self) -> list[ZNode] | None:
        """ファイル全体を読み込んで AST を表示する。

        Returns:
            読み込んだ AST。読み込みに失敗した場合は None。
        """
        try:
            ast = self.read_zil_file()
        except Exception as e:
            print(f"Error reading {self.path}: {e}")
            return None
        self.print_ast(ast)
        return ast
