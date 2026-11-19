# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'ZORK1 for\n\t        Zork I: The Great Underground Empire\n\t(c) Copyright 1983 Infocom, Inc.  All Rights Reserved.'

VERSION('ZIP')

# SETG (const) ZORK_NUMBER = 1  ->  ZilGlobal.py

REDEFINE = True

PRINC('Renovated ZORK I: The Great Underground Empire\n')

FREQUENT_WORDS_p()

from gmacros import *

from gsyntax import *

from _1dungeon import *

from gglobals import *

PROPDEF('SIZE', 5)

PROPDEF('CAPACITY', 0)

PROPDEF('VALUE', 0)

PROPDEF('TVALUE', 0)

from gclock import *

from gmain import *

from gparser import *

from gverbs import *

from _1actions import *

if __name__ == "__main__":
    ZG._link()
    ZG.GO()
