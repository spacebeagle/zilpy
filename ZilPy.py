"""ZIL ソースファイルを Python コードへ変換するコマンドラインツール。"""

import argparse
import shutil
import sys
from collections.abc import Sequence
from pathlib import Path

from zilpy.front.compiler import ZilCompiler
from zilpy.constants import COMPILER_GLOBALS, GLOBAL_MODULE, GLOBALS_NAME, RUNTIME_MODULE, RUNTIME_TELL_TOKENS
from zilpy.constants import ENTRY_ROUTINE as ZILPY_ENTRY_ROUTINE
from zilpy.backend.global_file import ZilGlobalFile
from zilpy.backend.lua_global_file import ZilLuaGlobalFile
from zilpy.front.nodes import ZString, form_name, is_ignorable, to_identifier
from zilpy.compiletime.project import (
    collect_flag_defaults,
    collect_flag_names,
    collect_replaced_definitions,
    collect_global_names,
    collect_object_names,
    collect_static_values,
    collect_tell_indicators,
    collect_zstart,
)
from zilpy.compiletime.macro_registry import MacroRegistry
from zilpy.compiletime.errors import ConversionError
from zilpy.compiletime.sourcemap import ZilMap
from zilpy.compiletime.tell import tell_expansion_tokens, tell_indicators_from_macro
from zilpy.compiletime.names import name_report
from zilpy.backend import runtime_names_lua, runtime_names_python
from zilpy.backend.lua import ZilToLuaTranscoder
from zilpy.backend.python import ZilToPythonTranscoder

EXIT_OK = 0
EXIT_FAILURE = 1
DEFAULT_OUTDIR = "out"
ZIL_SUFFIX = ".zil"
ENTRY_ROUTINE = ZILPY_ENTRY_ROUTINE  # ZIL のゲームの開始ルーチン (<ZSTART> で指定できるのもこれだけ)
# 起動時に、未評価のグローバル宣言を評価してから開始ルーチンを呼ぶ
LAUNCHER = (
    f'\n\nif __name__ == "__main__":\n'
    f"    {GLOBALS_NAME}._link()\n"
    f"    {GLOBALS_NAME}.{ENTRY_ROUTINE}()"
)
LUA_LAUNCHER = (
    f"\n\n{GLOBALS_NAME}._link()\n"
    f"{GLOBALS_NAME}.{ENTRY_ROUTINE}()"
)
# 生成コードと一緒に出力先へコピーするランタイム。入口のファイル (ZilRuntime.py / .lua) と、
# 中身のパッケージ (zilrt/) の 2 つ (refactor-plan.md Phase 5)
RUNTIME_DIR = Path(__file__).resolve().parent / "runtime"
RUNTIME_FILE = RUNTIME_DIR / "python" / f"{RUNTIME_MODULE}.py"
LUA_RUNTIME_FILE = RUNTIME_DIR / "lua" / f"{RUNTIME_MODULE}.lua"
RUNTIME_PACKAGE = "zilrt"
# 生成コードの名前と、元の ZIL の名前・位置の対応表 (refactor-plan.md §2.4)
ZILMAP_FILE = "zilmap.json"


def copy_runtime(target: str, out_path: Path) -> None:
    """ランタイムの入口のファイルと zilrt/ を、出力先へコピーする。

    出力先の zilrt/ は消してからコピーする (なくなったモジュールを残さないため)。
    """
    runtime_src = LUA_RUNTIME_FILE if target == "lua" else RUNTIME_FILE
    shutil.copy2(runtime_src, out_path / runtime_src.name)
    package_src = runtime_src.parent / RUNTIME_PACKAGE
    package_dst = out_path / RUNTIME_PACKAGE
    if package_dst.exists():
        shutil.rmtree(package_dst)
    if package_src.is_dir():
        shutil.copytree(package_src, package_dst, ignore=shutil.ignore_patterns("__pycache__"))


def find_zil_file(name: str, base_dir: Path) -> Path | None:
    """INSERT-FILE で指定された名前の ZIL ファイルを探す。

    拡張子は省略可能で、大文字・小文字は区別しない。

    Args:
        name: INSERT-FILE に書かれたファイル名 (例: "GMACROS")。
        base_dir: 検索するディレクトリ (取り込み元ファイルの場所)。

    Returns:
        見つかったファイルのパス。見つからない場合は None。
    """
    target = name.lower()
    if not target.endswith(ZIL_SUFFIX):
        target += ZIL_SUFFIX
    for candidate in base_dir.iterdir():
        if candidate.is_file() and candidate.name.lower() == target:
            return candidate
    return None


def module_name(path: Path) -> str:
    """ZIL ファイルに対応する Python モジュール名を求める。

    Args:
        path: ZIL ファイルのパス。

    Returns:
        import 文で使えるモジュール名 (例: 1dungeon.zil -> _1dungeon)。
    """
    return to_identifier(path.stem.lower())


class ProjectBuilder:
    """ZIL ファイルを INSERT-FILE をたどりながら Python モジュールへ変換する。"""

    def __init__(
        self,
        outdir: Path,
        print_ast: bool = False,
        target: str = "python",
        macro_comments: bool = True,
    ) -> None:
        """ProjectBuilder を初期化する。

        Args:
            outdir: 生成したファイルの出力先ディレクトリ。
            print_ast: True の場合、変換前に AST を標準出力へ表示する。
            target: 出力言語 ("python" または "lua")。
            macro_comments: マクロを展開した場所の注記と、マクロの定義の原文のコメントを出力するか。
        """
        self.outdir = outdir
        self.print_ast = print_ast
        self.target = target
        self.macro_comments = macro_comments
        # 定義の前に元の ZIL の位置 (# zil: ファイル:行) を書くか (refactor-plan.md §2.4)
        self.zil_locations = True
        # ZIL のコメント (;"...") を残すか (トップレベルと、ルーチンの本体の文の間)
        self.zil_comments = True
        # マクロの注記の量: normal (展開した所だけ) / full (関数・組み込みの呼び出しにも)
        self.annotate = "normal"
        # ルーチンの前に ZIL の原文をコメントとして入れるか (--zil-source)
        self.zil_source = False
        # 生成コードの名前と、元の ZIL の名前・位置の対応表 (出力先の zilmap.json)
        self.zilmap = ZilMap(target)
        self.failed = 0
        # 変換済み (または変換中) のファイルとモジュール名。循環参照を防ぐ
        self._modules: dict[Path, str] = {}
        # 全ファイルで共有される名前 (ROUTINE・GLOBAL・OBJECT など)
        self.global_names: set[str] = set(COMPILER_GLOBALS)
        # オブジェクトの FLAGS に書かれたフラグ名
        self.flag_names: set[str] = set()
        # OBJECT・ROOM の名前 (呼び出しの先頭なら組み込み命令とみなす)
        self.object_names: set[str] = set()
        # コンパイル時に決まる値 (例: <SETG ZORK-NUMBER 1>)
        self.static_values: dict[str, int] = {}
        # <COMPILATION-FLAG-DEFAULT> の既定値 (全ファイルを走査してから static_values に足す)
        self.flag_defaults: dict[str, int] = {}
        # <REPLACE-DEFINITION NAME> で作品が置き換えた名前 (同名の DEFAULT-DEFINITION は変換しない)
        self.replaced_definitions: set[str] = set()
        # 指定子の表で表せない TELL の指定子 (compiletime/tell.py の tell_expansion_tokens)
        self.tell_expansion_tokens: frozenset[str] = frozenset()
        # 作品のマクロ (DEFMAC) と、評価器に登録した DEFINE。走査し終えたら扱いを決める
        self.macros = MacroRegistry()
        # ゲームの TELL マクロが定める書式指定子 (例: Suspended の D は NDESC)
        self.tell_indicators: dict[str, tuple[str, bool]] = {}
        # GLOBAL / CONSTANT の宣言を集めて ZilGlobal.py / ZilGlobal.lua に出力する
        self.global_file: ZilGlobalFile | ZilLuaGlobalFile = (
            ZilLuaGlobalFile() if target == "lua" else ZilGlobalFile()
        )
        self._scanned: set[Path] = set()
        self.entry_routine: str = ENTRY_ROUTINE

    def scan(self, path: Path) -> None:
        """INSERT-FILE をたどり、全ファイルで共有される名前を集める。

        あるファイルが後で変換されるファイルのルーチンなどを参照できるよう、
        変換の前に全ファイルを走査しておく。読み込みに失敗したファイルは
        ここでは無視する (変換時にエラーとして報告する)。

        Args:
            path: 走査する ZIL ファイルのパス。
        """
        key = path.resolve()
        if key in self._scanned:
            return
        self._scanned.add(key)
        compiler = ZilCompiler(str(path))
        try:
            ast = compiler.read_zil_file()
        except (SyntaxError, OSError):
            return
        self.global_names |= collect_global_names(ast)
        self.flag_names |= collect_flag_names(ast)
        self.object_names |= collect_object_names(ast)
        self.static_values |= collect_static_values(ast)
        for name, value in collect_flag_defaults(ast).items():
            self.flag_defaults.setdefault(name, value)
        self.replaced_definitions |= collect_replaced_definitions(ast)
        zstart = collect_zstart(ast)
        if zstart is not None:
            self.entry_routine = zstart
        self.macros.scan(ast, path, compiler.source)
        self.tell_indicators |= collect_tell_indicators(ast)
        for node in ast:
            if form_name(node) != "INSERT-FILE" or not hasattr(node, "items"):
                continue
            args = [item for item in node.items[1:] if not is_ignorable(item)]
            if args and isinstance(args[0], ZString):
                found = find_zil_file(args[0].text, path.parent)
                if found is not None:
                    self.scan(found)

    def build(self, path: Path, is_main: bool = False) -> str | None:
        """ZIL ファイルを変換して outdir に書き出す。

        INSERT-FILE で参照されたファイルも再帰的に変換し、参照箇所は
        `from モジュール import *` に置き換える。

        Args:
            path: 変換対象の ZIL ファイルのパス。
            is_main: True の場合、ゲームを起動するコードを末尾に追加する。

        Returns:
            生成したモジュール名。読み込みまたは構文解析に失敗した場合は None。
        """
        key = path.resolve()
        if key in self._modules:
            return self._modules[key]
        module = module_name(path)
        self._modules[key] = module

        compiler = ZilCompiler(str(path))
        try:
            ast = compiler.read_zil_file()
        except (SyntaxError, OSError) as e:
            print(f"Error reading {path}: {e}", file=sys.stderr)
            self.failed += 1
            return None
        if self.print_ast:
            compiler.print_ast(ast)

        def include(name: str) -> str | None:
            """INSERT-FILE の参照先を探して変換する。

            Args:
                name: INSERT-FILE に書かれたファイル名。

            Returns:
                生成したモジュール名。失敗した場合は None。
            """
            found = find_zil_file(name, path.parent)
            if found is None:
                print(
                    f"Error: INSERT-FILE {name!r} not found in {path.parent}",
                    file=sys.stderr,
                )
                self.failed += 1
                return None
            return self.build(found)

        transcoder_cls = (
            ZilToLuaTranscoder if self.target == "lua" else ZilToPythonTranscoder
        )
        transcoder = transcoder_cls(
            ast,
            insert_file=include,
            global_names=self.global_names,
            global_file=self.global_file,  # type: ignore[arg-type]
            source_name=module,
            flag_names=self.flag_names,
            object_names=self.object_names,
            static_values=self.static_values,
            macros=self.macros,
            tell_indicators=self.tell_indicators,
        )
        # マクロの注記に、呼び出しの原文を書くため (refactor-plan.md §2.5)
        transcoder.source_text = compiler.source
        transcoder.macro_comments = self.macro_comments
        transcoder.zil_locations = self.zil_locations
        transcoder.zil_comments = self.zil_comments
        transcoder.annotate_full = self.annotate == "full"
        transcoder.zil_source = self.zil_source
        transcoder.source_file = path.name
        transcoder.zilmap = self.zilmap
        transcoder.replaced_definitions = self.replaced_definitions
        transcoder.tell_expansion_tokens = self.tell_expansion_tokens
        try:
            code = transcoder.transcode()
        except ConversionError as e:
            print(f"Error: {path.name}: {e}", file=sys.stderr)
            self.failed += 1
            return None
        if is_main:
            entry = self.entry_routine
            if self.target == "lua":
                code += f"\n\n{GLOBALS_NAME}._link()\n{GLOBALS_NAME}.{entry}()"
            else:
                code += f'\n\nif __name__ == "__main__":\n    {GLOBALS_NAME}._link()\n    {GLOBALS_NAME}.{entry}()'
        ext = ".lua" if self.target == "lua" else ".py"
        out_path = self.outdir / f"{module}{ext}"
        out_path.write_text(code + "\n", encoding="utf-8")
        print(f"Written to {out_path}")
        return module


def do_program(
    source_files: Sequence[str],
    outdir: str = DEFAULT_OUTDIR,
    print_ast: bool = False,
    target: str = "python",
    name_report_path: str | None = None,
    macro_comments: bool = True,
    macro_report_path: str | None = None,
    macro_functions: bool = True,
    zil_locations: bool = True,
    zil_comments: bool = True,
    annotate: str = "normal",
    zil_source: bool = False,
) -> int:
    """ZIL ファイルと INSERT-FILE の参照先を Python または Lua モジュールへ変換する。

    name_report_path を渡すと、ゲームの定義とランタイムの公開名が重なる名前と、
    呼び出しにどちらを使うかの一覧 (compiletime/names.py) をそのファイルに書く。
    macro_report_path を渡すと、作品のマクロの扱いと呼び出しの数の一覧を書く。
    macro_functions が偽なら、マクロを関数にせず、すべての呼び出しをその場で展開する。
    """
    out_path = Path(outdir)
    out_path.mkdir(parents=True, exist_ok=True)
    copy_runtime(target, out_path)
    builder = ProjectBuilder(out_path, print_ast=print_ast, target=target, macro_comments=macro_comments)
    builder.zil_locations = zil_locations
    builder.zil_comments = zil_comments
    builder.annotate = annotate
    builder.zil_source = zil_source
    for path in source_files:
        builder.scan(Path(path))
    for name, value in builder.flag_defaults.items():
        builder.static_values.setdefault(name, value)
    builder.macros.functions_enabled = macro_functions
    # static_values は、マクロの中の <GASSIGNED? X> を StaticEvaluator と同じ規則で決めるのにも使う
    builder.macros.finalize(builder.global_names, builder.static_values)
    # DEFMAC TELL の書式指定子は、評価器でマクロを展開して読み取る (TELL-TOKENS の宣言を優先する)
    for name, entry in tell_indicators_from_macro(builder.macros.evaluator).items():
        builder.tell_indicators.setdefault(name, entry)
    # 指定子の表で表せない指定子 (Moonmist の CHE・HIS・FN など)。これを含む TELL はマクロで展開する
    builder.tell_expansion_tokens = tell_expansion_tokens(
        builder.macros.evaluator, builder.tell_indicators, RUNTIME_TELL_TOKENS
    )
    for path in source_files:
        builder.build(Path(path), is_main=True)
    ext = ".lua" if target == "lua" else ".py"
    global_path = out_path / f"{GLOBAL_MODULE}{ext}"
    global_path.write_text(builder.global_file.render(), encoding="utf-8")
    print(f"Written to {global_path}")
    map_path = out_path / ZILMAP_FILE
    map_path.write_text(builder.zilmap.render(), encoding="utf-8", newline="\n")
    print(f"Written to {map_path}")
    if name_report_path is not None:
        runtime_names = (
            runtime_names_lua if target == "lua" else runtime_names_python
        ).RUNTIME_NAMES
        report = name_report(
            builder.global_names,
            builder.object_names,
            runtime_names,
            {to_identifier(info.name): info.decision for info in builder.macros.macros.values()},
        )
        Path(name_report_path).write_text(report, encoding="utf-8", newline="\n")
    if macro_report_path is not None:
        Path(macro_report_path).write_text(builder.macros.report(), encoding="utf-8", newline="\n")
    return EXIT_FAILURE if builder.failed else EXIT_OK


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    """コマンドライン引数を解析する。"""
    ap = argparse.ArgumentParser(description="Convert ZIL to Python or Lua")
    ap.add_argument("zilfile", nargs="+", help="main zil file name(s)")
    ap.add_argument(
        "-d",
        "--outdir",
        metavar="DIR",
        default=DEFAULT_OUTDIR,
        help=f"output directory (default: {DEFAULT_OUTDIR})",
    )
    ap.add_argument(
        "--target",
        choices=("python", "lua"),
        default="python",
        help="target language (default: python)",
    )
    ap.add_argument(
        "--print-ast", action="store_true", help="print AST before transcoding"
    )
    ap.add_argument(
        "--no-macro-comments",
        dest="macro_comments",
        action="store_false",
        help="do not write comments where macros are expanded and where they are defined",
    )
    ap.add_argument(
        "--no-zil-locations",
        dest="zil_locations",
        action="store_false",
        help="do not write the ZIL file and line (# zil: FILE:LINE) before each definition",
    )
    ap.add_argument(
        "--zil-source",
        action="store_true",
        help="put the ZIL source of each routine before it as comments",
    )
    ap.add_argument(
        "--annotate",
        choices=("normal", "full"),
        default="normal",
        help="full: also annotate calls of macros turned into functions and of builtin macros (default: normal)",
    )
    ap.add_argument(
        "--no-zil-comments",
        dest="zil_comments",
        action="store_false",
        help="do not keep the ZIL comments (;\"...\") at the top level and between the statements of routines",
    )
    ap.add_argument(
        "--no-macro-functions",
        dest="macro_functions",
        action="store_false",
        help="do not turn macros into functions; expand every macro call in place",
    )
    ap.add_argument(
        "--macro-report",
        metavar="FILE",
        help="write how each macro of the game is handled, and how many calls were expanded",
    )
    ap.add_argument(
        "--name-report",
        metavar="FILE",
        help="write the names shared by the game and the runtime, and which one is called",
    )
    return ap.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    """コマンドライン引数を解析し、ZIL から Python/Lua への変換を実行する。"""
    args = parse_args(argv)
    return do_program(
        args.zilfile,
        outdir=args.outdir,
        print_ast=args.print_ast,
        target=args.target,
        name_report_path=args.name_report,
        macro_comments=args.macro_comments,
        macro_report_path=args.macro_report,
        macro_functions=args.macro_functions,
        zil_locations=args.zil_locations,
        zil_comments=args.zil_comments,
        annotate=args.annotate,
        zil_source=args.zil_source,
    )


if __name__ == "__main__":
    sys.exit(main())
