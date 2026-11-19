# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'GCLOCK for\n\t\t\t    The Zork Trilogy\n\t (c) Copyright 1983 Infocom, Inc.  All Rights Reserved'

# zil: gclock.zil:5  <CONSTANT C-TABLELEN>
# CONSTANT (const) C_TABLELEN = 180  ->  ZilGlobal.py

# zil: gclock.zil:7  <GLOBAL C-TABLE>
# GLOBAL (state) C_TABLE = ITABLE('NONE', 180)  ->  ZilGlobal.py

# zil: gclock.zil:9  <GLOBAL C-DEMONS>
# GLOBAL (state) C_DEMONS = 180  ->  ZilGlobal.py

# zil: gclock.zil:11  <GLOBAL C-INTS>
# GLOBAL (state) C_INTS = 180  ->  ZilGlobal.py

# zil: gclock.zil:13  <CONSTANT C-INTLEN>
# CONSTANT (const) C_INTLEN = 6  ->  ZilGlobal.py

# zil: gclock.zil:15  <CONSTANT C-ENABLED?>
# CONSTANT (const) C_ENABLED_p = 0  ->  ZilGlobal.py

# zil: gclock.zil:17  <CONSTANT C-TICK>
# CONSTANT (const) C_TICK = 1  ->  ZilGlobal.py

# zil: gclock.zil:19  <CONSTANT C-RTN>
# CONSTANT (const) C_RTN = 2  ->  ZilGlobal.py

# zil: gclock.zil:21  <ROUTINE QUEUE (RTN TICK "AUX" CINT)>
@ZG.routine('QUEUE')
def QUEUE(RTN, TICK):
    CINT = 0
    PUT((CINT := ZG.INT(RTN)), ZG.C_TICK, TICK)
    return CINT

# zil: gclock.zil:26  <ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)>
@ZG.routine('INT')
def INT(RTN, DEMON=None, E=None, C_l=None, INT=None):
    if DEMON is None:
        DEMON = False
    E = REST(ZG.C_TABLE, ZG.C_TABLELEN)
    C_l = REST(ZG.C_TABLE, ZG.C_INTS)
    while True:
        if (C_l == E):
            ZG.C_INTS = (ZG.C_INTS - ZG.C_INTLEN)
            (DEMON and ZG._set('C_DEMONS', (ZG.C_DEMONS - ZG.C_INTLEN)))
            INT = REST(ZG.C_TABLE, ZG.C_INTS)
            PUT(INT, ZG.C_RTN, RTN)
            return INT
        elif (GET(C_l, ZG.C_RTN) == RTN):
            return C_l
        C_l = REST(C_l, ZG.C_INTLEN)

# zil: gclock.zil:41  <GLOBAL CLOCK-WAIT>
# GLOBAL (state) CLOCK_WAIT = False  ->  ZilGlobal.py

# zil: gclock.zil:43  <ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))>
@ZG.routine('CLOCKER')
def CLOCKER():
    C_l = 0
    E = 0
    TICK = 0
    FLG = False
    if ZG.CLOCK_WAIT:
        ZG.CLOCK_WAIT = False
        return False
    if ZG.P_WON:
        _tmp1 = ZG.C_INTS
    else:
        _tmp1 = ZG.C_DEMONS
    if ZG.P_WON:
        _tmp2 = ZG.C_INTS
    else:
        _tmp2 = ZG.C_DEMONS
    C_l = REST(ZG.C_TABLE, _tmp2)
    E = REST(ZG.C_TABLE, ZG.C_TABLELEN)
    while True:
        if (C_l == E):
            ZG.MOVES = (ZG.MOVES + 1)
            return FLG
        elif (not (GET(C_l, ZG.C_ENABLED_p) == 0)):
            TICK = GET(C_l, ZG.C_TICK)
            if (TICK == 0):
                pass
            else:
                PUT(C_l, ZG.C_TICK, (TICK - 1))
                if ((not (TICK > 1)) and APPLY(GET(C_l, ZG.C_RTN))):
                    FLG = True
        C_l = REST(C_l, ZG.C_INTLEN)
