# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'ZORK3 for\n\t\t     Zork III: The Dungeon Master\n\t(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.'

# SETG (const) ZORK_NUMBER = 3  ->  ZilGlobal.py

SNAME('ZORK3')

REDEFINE = True

PRINC('Renovated ZORK III: The Dungeon Master\n')

FREQUENT_WORDS_p()

from gsyntax import *

from gmacros import *

from gclock import *

from gmain import *

from gparser import *

from _3dungeon import *

from gglobals import *

from gverbs import *

from _3actions import *

PROPDEF('SIZE', 5)

PROPDEF('CAPACITY', 0)

PROPDEF('VALUE', 0)

if __name__ == "__main__":
    ZG._link()
    ZG.GO()
