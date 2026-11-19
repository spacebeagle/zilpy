# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'Generic MAIN file for\n\t\t\t    The ZORK Trilogy\n\t\t       started on 7/28/83 by MARC'

# zil: gmain.zil:5  <CONSTANT SERIAL>
# CONSTANT (const) SERIAL = 0  ->  ZilGlobal.py

# zil: gmain.zil:7  <GLOBAL PLAYER>
# GLOBAL (state) PLAYER = False  ->  ZilGlobal.py

# zil: gmain.zil:9  <GLOBAL P-WON>
# GLOBAL (scratch) P_WON = False  ->  ZilGlobal.py

# zil: gmain.zil:11  <CONSTANT M-FATAL>
# CONSTANT (const) M_FATAL = 2  ->  ZilGlobal.py

# zil: gmain.zil:13  <CONSTANT M-HANDLED>
# CONSTANT (const) M_HANDLED = 1  ->  ZilGlobal.py

# zil: gmain.zil:15  <CONSTANT M-NOT-HANDLED>
# CONSTANT (const) M_NOT_HANDLED = False  ->  ZilGlobal.py

# zil: gmain.zil:17  <CONSTANT M-OBJECT>
# CONSTANT (const) M_OBJECT = False  ->  ZilGlobal.py

# zil: gmain.zil:19  <CONSTANT M-BEG>
# CONSTANT (const) M_BEG = 1  ->  ZilGlobal.py

# zil: gmain.zil:21  <CONSTANT M-END>
# CONSTANT (const) M_END = 6  ->  ZilGlobal.py

# zil: gmain.zil:23  <CONSTANT M-ENTER>
# CONSTANT (const) M_ENTER = 2  ->  ZilGlobal.py

# zil: gmain.zil:25  <CONSTANT M-LOOK>
# CONSTANT (const) M_LOOK = 3  ->  ZilGlobal.py

# zil: gmain.zil:27  <CONSTANT M-FLASH>
# CONSTANT (const) M_FLASH = 4  ->  ZilGlobal.py

# zil: gmain.zil:29  <CONSTANT M-OBJDESC>
# CONSTANT (const) M_OBJDESC = 5  ->  ZilGlobal.py

# ;"GO now lives in SPECIAL.ZIL"

# zil: gmain.zil:34  <ROUTINE MAIN-LOOP ("AUX" TRASH)>
@ZG.routine('MAIN-LOOP')
def MAIN_LOOP():
    TRASH = 0
    while True:
        TRASH = ZG.MAIN_LOOP_1()

# zil: gmain.zil:38  <ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP O I)>
@ZG.routine('MAIN-LOOP-1')
def MAIN_LOOP_1():
    ICNT = 0
    OCNT = 0
    NUM_l = 0
    CNT = 0
    OBJ_l = 0
    TBL = 0
    V = 0
    PTBL = 0
    OBJ1 = 0
    TMP = 0
    O_l = 0
    I = 0
    CNT = 0
    OBJ_l = False
    PTBL = True
    if ZG._set('P_WON', ZG.PARSER()):
        ICNT = GET(ZG.P_PRSI, ZG.P_MATCHLEN)
        OCNT = GET(ZG.P_PRSO, ZG.P_MATCHLEN)
        if (ZG.P_IT_OBJECT and ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT)):
            TMP = False
            while True:
                if ((CNT := (CNT + 1)) > ICNT):
                    break
                else:
                    if (GET(ZG.P_PRSI, CNT) == ZG.IT):
                        PUT(ZG.P_PRSI, CNT, ZG.P_IT_OBJECT)
                        TMP = True
                        break
            if (not TMP):
                CNT = 0
                while True:
                    if ((CNT := (CNT + 1)) > OCNT):
                        break
                    else:
                        if (GET(ZG.P_PRSO, CNT) == ZG.IT):
                            PUT(ZG.P_PRSO, CNT, ZG.P_IT_OBJECT)
                            break
            CNT = 0
        if (OCNT == 0):
            NUM_l = OCNT
        elif (OCNT > 1):
            TBL = ZG.P_PRSO
            if (ICNT == 0):
                OBJ_l = False
            else:
                OBJ_l = GET(ZG.P_PRSI, 1)
            NUM_l = OCNT
        elif (ICNT > 1):
            PTBL = False
            TBL = ZG.P_PRSI
            OBJ_l = GET(ZG.P_PRSO, 1)
            NUM_l = ICNT
        else:
            NUM_l = 1
        if ((not OBJ_l) and (ICNT == 1)):
            OBJ_l = GET(ZG.P_PRSI, 1)
        if ((ZG.PRSA == SYMBOL('V?WALK')) and (not (ZG.P_WALK_DIR == 0))):
            V = ZG.PERFORM(ZG.PRSA, ZG.PRSO)
        elif (NUM_l == 0):
            if ((GETB(ZG.P_SYNTAX, ZG.P_SBITS) & ZG.P_SONUMS) == 0):
                V = ZG.PERFORM(ZG.PRSA)
                ZG.PRSO = False
            elif (not ZG.LIT):
                TELL("It's too dark to see.", CR)
            else:
                TELL("It's not clear what you're referring to.", CR)
                V = False
        else:
            ZG.P_NOT_HERE = 0
            ZG.P_MULT = False
            if (NUM_l > 1):
                ZG.P_MULT = True
            TMP = False
            while True:
                if ((CNT := (CNT + 1)) > NUM_l):
                    if (ZG.P_NOT_HERE > 0):
                        TELL('The ')
                        if (not (ZG.P_NOT_HERE == NUM_l)):
                            TELL('other ')
                        TELL('object')
                        if (not (ZG.P_NOT_HERE == 1)):
                            TELL('s')
                        TELL(' that you mentioned ')
                        if (not (ZG.P_NOT_HERE == 1)):
                            TELL('are')
                        else:
                            TELL('is')
                        TELL("n't here.", CR)
                    elif (not TMP):
                        TELL("There's nothing here you can take.", CR)
                    break
                else:
                    if PTBL:
                        OBJ1 = GET(ZG.P_PRSO, CNT)
                    else:
                        OBJ1 = GET(ZG.P_PRSI, CNT)
                    if PTBL:
                        O_l = OBJ1
                    else:
                        O_l = OBJ_l
                    if PTBL:
                        I = OBJ_l
                    else:
                        I = OBJ1
                    if ((NUM_l > 1) or (GET(GET(ZG.P_ITBL, ZG.P_NC1), 0) == WORD('all'))):
                        V = LOC(ZG.WINNER)
                        if (O_l == ZG.NOT_HERE_OBJECT):
                            ZG.P_NOT_HERE = (ZG.P_NOT_HERE + 1)
                            continue
                        elif (VERB_p('TAKE') and I and (GET(GET(ZG.P_ITBL, ZG.P_NC1), 0) == WORD('all')) and (not IN_p(O_l, I))):
                            continue
                        elif ((ZG.P_GETFLAGS == ZG.P_ALL) and VERB_p('TAKE') and (((not (LOC(O_l) in (ZG.WINNER, ZG.HERE, V))) and (not (LOC(O_l) == I)) and (not FSET_p(LOC(O_l), Flag('SURFACEBIT')))) or (not (FSET_p(O_l, Flag('TAKEBIT')) or FSET_p(O_l, Flag('TRYTAKEBIT')))))):
                            continue
                        else:
                            if (OBJ1 == ZG.IT):
                                PRINTD(ZG.P_IT_OBJECT)
                            else:
                                PRINTD(OBJ1)
                            TELL(': ')
                    ZG.PRSO = O_l
                    ZG.PRSI = I
                    TMP = True
                    V = ZG.PERFORM(ZG.PRSA, ZG.PRSO, ZG.PRSI)
                    if (V == ZG.M_FATAL):
                        break
        if (not (V == ZG.M_FATAL)):
            V = APPLY(GETP(LOC(ZG.WINNER), 'ACTION'), ZG.M_END)
        if (V == ZG.M_FATAL):
            ZG.P_CONT = False
    else:
        ZG.P_CONT = False
    ZG.NULL_F()
    if ZG.P_WON:
        if VERB_p('TELL', 'BRIEF', 'SUPER-BRIEF', 'VERBOSE', 'SAVE', 'VERSION', 'QUIT', 'RESTART', 'SCORE', 'SCRIPT', 'UNSCRIPT', 'RESTORE'):
            return True
        else:
            V = ZG.CLOCKER()
            return V
    else:
        return False

# zil: gmain.zil:174  <GLOBAL P-MULT>
# GLOBAL (scratch) P_MULT = False  ->  ZilGlobal.py

# zil: gmain.zil:176  <GLOBAL P-NOT-HERE>
# GLOBAL (scratch) P_NOT_HERE = 0  ->  ZilGlobal.py

while True:
    ZG.DEBUG = False
    @ZG.routine('PERFORM')
    def PERFORM(A_l, O_l=None, I=None):
        if O_l is None:
            O_l = False
        if I is None:
            I = False
        V = 0
        OA = 0
        OO = 0
        OI = 0
        if ZG.DEBUG:
            TELL('** PERFORM: PRSA = ')
            PRINC(NTH(ZG.ACTIONS, ((A_l * 2) + 1)))
            if (O_l and (not (A_l == SYMBOL('V?WALK')))):
                TELL(' \n PRSO = ', D, O_l)
            if I:
                TELL(' \n PRSI = ', D, I)
        OA = ZG.PRSA
        OO = ZG.PRSO
        OI = ZG.PRSI
        if ((ZG.IT in (I, O_l)) and (not ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT))):
            TELL("I don't see what you are referring to.", CR)
            return 2
        if (O_l == ZG.IT):
            O_l = ZG.P_IT_OBJECT
        if (I == ZG.IT):
            I = ZG.P_IT_OBJECT
        ZG.PRSA = A_l
        ZG.PRSO = O_l
        if (ZG.PRSO and (not VERB_p('WALK'))):
            ZG.P_IT_OBJECT = ZG.PRSO
        ZG.PRSI = I
        if ((ZG.NOT_HERE_OBJECT in (ZG.PRSO, ZG.PRSI)) and (V := ZG.D_APPLY('Not Here', ZG.NOT_HERE_OBJECT_F))):
            pass
        else:
            O_l = ZG.PRSO
            I = ZG.PRSI
            if (V := ZG.DD_APPLY('Actor', ZG.WINNER, GETP(ZG.WINNER, 'ACTION'))):
                pass
            elif (V := ZG.D_APPLY('Room (M-BEG)', GETP(LOC(ZG.WINNER), 'ACTION'), ZG.M_BEG)):
                pass
            elif (V := ZG.D_APPLY('Preaction', GET(ZG.PREACTIONS, A_l))):
                pass
            elif (I and (V := ZG.D_APPLY('PRSI', GETP(I, 'ACTION')))):
                pass
            elif (O_l and (not (A_l == SYMBOL('V?WALK'))) and LOC(O_l) and GETP(LOC(O_l), 'CONTFCN') and (V := ZG.DD_APPLY('Container', LOC(O_l), GETP(LOC(O_l), 'CONTFCN')))):
                pass
            elif (O_l and (not (A_l == SYMBOL('V?WALK'))) and (V := ZG.D_APPLY('PRSO', GETP(O_l, 'ACTION')))):
                pass
            elif (V := ZG.D_APPLY(False, GET(ZG.ACTIONS, A_l))):
                pass
        ZG.PRSA = OA
        ZG.PRSO = OO
        ZG.PRSI = OI
        return V
    @ZG.routine('D-APPLY')
    def D_APPLY(STR, FCN, FOO=None):
        RES = 0
        if (not FCN):
            return False
        else:
            if ZG.DEBUG:
                if (not STR):
                    TELL(CR, '  Default ->', CR)
                else:
                    TELL(CR, '  ', STR, ' -> ')
            if (FOO is not None):
                RES = APPLY(FCN, FOO)
            else:
                RES = APPLY(FCN)
            if (ZG.DEBUG and STR):
                if (RES == 2):
                    TELL('Fatal', CR)
                elif (not RES):
                    TELL('Not handled')
                else:
                    TELL('Handled', CR)
            return RES
    @ZG.routine('DD-APPLY')
    def DD_APPLY(STR, OBJ_l, FCN, FOO=None):
        if FOO is None:
            FOO = False
        if ZG.DEBUG:
            TELL('[', D, OBJ_l, '=]')
        return ZG.D_APPLY(STR, FCN, FOO)
    break
