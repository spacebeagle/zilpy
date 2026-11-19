"""ZIL から変換した Python コードが実行時に使うランタイム (zilrt パッケージ)。

生成コードは、出力先にコピーされる ZilRuntime.py を `from ZilRuntime import *` で取り込み、
ZilRuntime.py がこのパッケージを読み込む (refactor-plan.md Phase 5)。
"""


# ruff: noqa: F401, F403


from .builtin_macros import *
from .context import *
from .exits import *
from .instructions import *
from .io import *
from .mdl_compat import *
from .objects import *
from .saves import *
from .screen import *
from .source_fixes import *
from .tables import *
from .vocab import *


# 非公開の名前 (先頭が _) も、ZilRuntime の属性として見えるようにする (古い保存ファイルの読み替えなど)
from . import builtin_macros
from . import context
from . import exits
from . import instructions
from . import io
from . import mdl_compat
from . import objects
from . import saves
from . import screen
from . import source_fixes
from . import tables
from . import vocab
from .io import _describe


#
# 生成コードは `from ZilRuntime import *` で、ここに挙げた名前だけを読み込む。
# 名前を足したら、どれかの分類に入れる (tests/test_builtin_runtime.py が、分類のない公開名を見つける)。

# ZIL の命令 (Z-machine の命令に当たるもの)
_INSTRUCTIONS = (
    "APPLY", "BACK", "BTST", "BUFOUT", "CLEAR", "CRLF", "CURSET", "DIRIN", "DIROUT", "ERASE",
    "FCLEAR", "FIRST_p", "FSET", "FSET_p", "GET", "GETB", "GETP", "GETPT", "HLIGHT", "INPUT",
    "INTBL_p", "IN_p", "LOC", "MOVE", "NEXTP", "NEXT_p", "PRINT", "PRINTB", "PRINTC", "PRINTD",
    "PRINTI", "PRINTN", "PTSIZE", "PUT", "PUTB", "PUTP", "QUIT", "RANDOM", "READ", "REMOVE",
    "REST", "RESTART", "RESTORE", "SAVE", "SCREEN", "SOUND", "SPLIT", "USL", "VALUE", "VERIFY",
)
# ZILCH (コンパイラ) の組み込み: 宣言のフォーム、テーブル、語彙、TELL と書式指定子、品詞の定数
_ZILCH_BUILTINS = (
    "TELL", "TellToken", "CR", "S", "D", "DESC", "OBJ", "O", "A", "AN", "N", "NUM", "C", "CHR", "CHAR",
    "PRINTA", "TABLE", "PTABLE", "LTABLE", "PLTABLE", "ITABLE", "TBYTE", "Table",
    "SYNTAX", "SYNONYM", "VERB_SYNONYM", "PREP_SYNONYM", "ADJ_SYNONYM", "DIR_SYNONYM", "BUZZ",
    "DIRECTIONS", "VOC", "WORD", "Word", "PSEUDO", "SYMBOL", "OBJECT", "ROOM", "PROPDEF", "VERSION",
    "FREQUENT_WORDS_p", "GDECL", "LOW_DIRECTION", "Direction", "Flag", "GlobalRef",
    "PS_OBJECT", "PS_VERB", "PS_ADJECTIVE", "PS_DIRECTION", "PS_PREPOSITION", "PS_BUZZ_WORD",
    "P1_OBJECT", "P1_VERB", "P1_ADJECTIVE", "P1_DIRECTION", "P1_PREPOSITION", "P1_BUZZ_WORD",
)
# 共通マクロ (zilpy/compiletime/builtin_macros.py の一覧と同じ。RFATAL は変換器が return 2 にする)
_BUILTIN_MACROS = (
    "VERB_p", "PRSO_p", "PRSI_p", "ROOM_p", "BSET", "BCLEAR", "BSET_p", "OPENABLE_p", "FLAMING_p",
    "ABS", "ENABLE",
)
# MDL の互換 (ゲームのコードに残っている MDL の関数。多くは何もしない)
_MDL_COMPAT = (
    "ASCII", "BLOAT", "EMPTY_p", "ERROR", "GASSIGNED_p", "GC", "GC_MON", "ID", "IUVECTOR", "IVECTOR",
    "LENGTH", "NTH", "PRINC", "SNAME", "SPNAME", "STRING",
)
# ランタイムの仕組み (ZG とゲームの状態、入出力、保存。ZilMcp.py などが使う) と定数
_RUNTIME = (
    "ZG", "GameContext", "ActionRegistry", "ConstStore", "StateStore", "ScratchStore", "WorldState",
    "Dictionary", "IOState", "ZObject", "ZilGlobals", "ZilError", "ZilQuit", "ZilRestart",
    "get_context", "set_context", "set_io", "snapshot_state", "restore_snapshot", "LIST_SAVES",
    "SAVE_SUFFIX", "LEXV_ENTRY_SIZE", "MAX_PROPERTY_NUMBER", "RELEASE_NUMBER", "SERIAL_NUMBER",
    "SCREEN_WIDTH", "SCREEN_HEIGHT", "SEPARATOR_WORD_NAMES", "TABLE_FLAGS", "TABLE_OVERRUN_BYTES",
    "VOWELS", "WORD_SEPARATORS", "WORD_SIGNIFICANT_CHARS", "WORD_SIGNIFICANT_CHARS_V4",
)
PUBLIC_NAMES: dict[str, tuple[str, ...]] = {
    "instruction": _INSTRUCTIONS,
    "zilch": _ZILCH_BUILTINS,
    "builtin_macro": _BUILTIN_MACROS,
    "mdl": _MDL_COMPAT,
    "runtime": _RUNTIME,
}
__all__ = [name for names in PUBLIC_NAMES.values() for name in names]
