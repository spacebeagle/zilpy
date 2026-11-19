"""ZIL から変換した Python コードが実行時に使うランタイムの入口。

生成コードの先頭で `from ZilRuntime import *` として取り込む。中身は、同じ出力先にある
zilrt/ パッケージに分けてある (refactor-plan.md Phase 5)。ZIL (Z-machine) の命令・宣言を
同名の Python 関数として提供する (名前末尾の `?` は `_p` に置き換える。例: FSET? -> FSET_p)。

`from ZilRuntime import *` で読み込まれる名前は zilrt.__all__ (公開名の分類 PUBLIC_NAMES を
並べたもの)。MCP サーバー (ZilMcp.py) は `import ZilRuntime` して、set_io・snapshot_state・
restore_snapshot・ZilRestart・SAVE_SUFFIX・ZG・ZObject・Table・get_context と、非公開の
_describe (look_state の物の名前) を使う。非公開の名前は `from zilrt import *` では
読み込まれないので、下で明示的に読み込む (tests/test_runtime_package.py が漏れを見つける)。
"""

# ruff: noqa: F401, F403
from zilrt import *
from zilrt import PUBLIC_NAMES, __all__, _describe
