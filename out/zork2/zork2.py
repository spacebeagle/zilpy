# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'ZORK2 for\n\t        Zork II: The Wizard of Frobozz\n\t(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.'

# ON!-INITIAL: top-level atom (no effect)

# OFF!-INITIAL: top-level atom (no effect)

# SETG (const) ZORK_NUMBER = 2  ->  ZilGlobal.py

REDEFINE = True

PRINC('Renovated ZORK II: The Wizard of Frobozz\n')

FREQUENT_WORDS_p()

from gmacros import *

from gsyntax import *

from _2dungeon import *

from gglobals import *

PROPDEF('SIZE', 5)

PROPDEF('CAPACITY', 0)

PROPDEF('VALUE', 0)

from gclock import *

from gmain import *

from gparser import *

from gverbs import *

from _2actions import *

if __name__ == "__main__":
    ZG._link()
    ZG.GO()
