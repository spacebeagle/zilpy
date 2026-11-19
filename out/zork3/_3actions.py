# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'ACTIONS3 for\n\t\t     ZORK III: The Dungeon Master\n\t\t The Great Underground Empire (Part 3)\n\t(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.\n'

'SWORD demon'

# zil: 3actions.zil:9  <ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) P T L)>
@ZG.routine('I-SWORD')
def I_SWORD():
    DEM = ZG.INT(ZG.I_SWORD)
    NG = 0
    P = 0
    T = 0
    L = 0
    if IN_p(ZG.SWORD, ZG.ADVENTURER):
        if ((ZG.HERE == ZG.CLIFF) and (not ZG.MAN_GONE)):
            NG = 1
        elif ((ZG.HERE == ZG.CLIFF_LEDGE) and ZG.MAN_FLAG):
            NG = 1
        elif ZG.INFESTED_p(ZG.HERE):
            NG = 2
        elif (((ZG.MLOC == ZG.MRG) and (ZG.HERE == ZG.IN_MIRROR)) or (ZG.HERE in (ZG.MRGE, ZG.MRG, ZG.MRGW))):
            NG = 1
        else:
            P = 0
            while True:
                if ((P := NEXTP(ZG.HERE, P)) == 0):
                    break
                elif (not (P < LOW_DIRECTION)):
                    T = GETPT(ZG.HERE, P)
                    L = PTSIZE(T)
                    if (L in (ZG.UEXIT, ZG.CEXIT, ZG.DEXIT)):
                        if ZG.INFESTED_p(GETB(T, 0)):
                            NG = 1
                            break
        if (NG == ZG.SWORD_STATE):
            return False
        elif (NG == 2):
            TELL('Your sword has begun to glow very brightly.', CR)
        elif (NG == 1):
            TELL('Your sword is glowing with a faint blue glow.', CR)
        elif (NG == 0):
            TELL('Your sword is no longer glowing.', CR)
        ZG.SWORD_STATE = NG
        return True
    else:
        ZG.DISABLE(DEM)
        return False

# zil: 3actions.zil:41  <GLOBAL SWORD-STATE>
# GLOBAL (state) SWORD_STATE = 0  ->  ZilGlobal.py

# zil: 3actions.zil:43  <ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))>
@ZG.routine('INFESTED?')
def INFESTED_p(R):
    F = FIRST_p(R)
    while True:
        if (not F):
            return False
        elif (FSET_p(F, Flag('ACTORBIT')) and (not FSET_p(F, Flag('INVISIBLE')))):
            return F
        elif (not (F := NEXT_p(F))):
            return False

'old ACTIONS.ZIL'

# zil: 3actions.zil:52  <GLOBAL YUKS>
# GLOBAL (state) YUKS = LTABLE('A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!')  ->  ZilGlobal.py

# zil: 3actions.zil:59  <ROUTINE FIND-WEAPON (O "AUX" W)>
@ZG.routine('FIND-WEAPON')
def FIND_WEAPON(O_l):
    W = 0
    W = FIRST_p(O_l)
    if (not W):
        return False
    while True:
        if (W == ZG.SWORD):
            return W
        elif (not (W := NEXT_p(W))):
            return False

# zil: 3actions.zil:68  <ROUTINE SWORD-FCN ()>
@ZG.routine('SWORD-FCN')
def SWORD_FCN():
    if ZG.SWORD_IN_STONE_p:
        if VERB_p('TAKE', 'MOVE'):
            if ZG.PROB(10):
                return TELL('Who do you think you are? Arthur?', CR)
            else:
                return TELL("The sword is deeply imbedded in the rock. You can't budge it.", CR)
        else:
            return False
    elif (VERB_p('TAKE') and (ZG.WINNER == ZG.ADVENTURER)):
        ENABLE(ZG.QUEUE(ZG.I_SWORD, -1))
        return False
    else:
        return False

# zil: 3actions.zil:80  <GLOBAL LAMP-TABLE>
# GLOBAL (state) LAMP_TABLE = TABLE(300, 'The lamp appears a bit dimmer.', 100, 'The lamp is definitely dimmer now.', 50, 'The lamp is nearly out.', 0)  ->  ZilGlobal.py

# zil: 3actions.zil:89  <ROUTINE LANTERN ()>
@ZG.routine('LANTERN')
def LANTERN():
    if VERB_p('THROW'):
        TELL('The lamp smashes. The light is now out.', CR)
        ZG.DISABLE(ZG.INT(ZG.I_LANTERN))
        REMOVE(ZG.LAMP)
        ZG.CURRENT_LAMP = ZG.BROKEN_LAMP
        return MOVE(ZG.BROKEN_LAMP, ZG.HERE)
    elif VERB_p('LAMP-ON'):
        if (not FSET_p(ZG.LAMP, Flag('LIGHTBIT'))):
            return TELL("A burned-out lamp won't light.", CR)
        else:
            ENABLE(ZG.INT(ZG.I_LANTERN))
            return False
    elif VERB_p('LAMP-OFF'):
        if (not FSET_p(ZG.LAMP, Flag('LIGHTBIT'))):
            return TELL('The lamp has already burned out.', CR)
        else:
            ZG.DISABLE(ZG.INT(ZG.I_LANTERN))
            return False
    elif VERB_p('EXAMINE'):
        if (not FSET_p(ZG.LAMP, Flag('LIGHTBIT'))):
            TELL('The lamp has burned out.')
        elif FSET_p(ZG.LAMP, Flag('ONBIT')):
            TELL('The lamp is on.')
        else:
            TELL('The lamp is turned off.')
        return CRLF()
    else:
        return False

# zil: 3actions.zil:117  <ROUTINE LIGHT-INT (OBJ TBL TICK)>
@ZG.routine('LIGHT-INT')
def LIGHT_INT(OBJ_l, TBL, TICK):
    if (TICK == 0):
        FCLEAR(OBJ_l, Flag('ONBIT'))
        FSET(OBJ_l, Flag('RMUNGBIT'))
    if (ZG.HELD_p(OBJ_l) or IN_p(OBJ_l, ZG.HERE)):
        if (TICK == 0):
            return TELL("You'd better have more light than from the ", D, OBJ_l, '.', CR)
        else:
            return TELL(GET(TBL, 1), CR)
    else:
        return False

# zil: 3actions.zil:128  <ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))>
@ZG.routine('I-LANTERN')
def I_LANTERN():
    TICK = 0
    TBL = VALUE(ZG.LAMP_TABLE)
    ENABLE(ZG.QUEUE(ZG.I_LANTERN, (TICK := GET(TBL, 0))))
    ZG.LIGHT_INT(ZG.LAMP, TBL, TICK)
    if (not (TICK == 0)):
        ZG.LAMP_TABLE = REST(TBL, 4)
        return ZG.LAMP_TABLE
    else:
        return False

# ;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
# 	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
# 		(TICK) FIX)
# 	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
# 	 <COND (<0? .TICK>
# 		<FCLEAR .OBJ ,LIGHTBIT>
# 		<FCLEAR .OBJ ,ONBIT>)>
# 	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
# 		<COND (<0? .TICK>
# 		       <TELL
# "I hope you have more light than from the " D .OBJ "." CR>)
# 		      (T
# 		       <TELL <GET .TBL 1> CR>)>)>
# 	 <COND (<NOT <0? .TICK>>
# 		<SETG .TBLNAM <REST .TBL 4>>)>>

# zil: 3actions.zil:150  <ROUTINE CHASM-FCN ()>
@ZG.routine('CHASM-FCN')
def CHASM_FCN():
    if (VERB_p('LEAP') or (VERB_p('PUT') and (ZG.PRSO == ZG.ME))):
        return TELL('You look before leaping and realize you would never survive.', CR)
    elif VERB_p('CROSS'):
        return TELL("You'll have to find a bridge.", CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.PSEUDO_OBJECT)):
        TELL('The ', D, ZG.PRSO, ' drops out of sight into the chasm.', CR)
        return REMOVE(ZG.PRSO)
    else:
        return False

# zil: 3actions.zil:162  <ROUTINE TUNNEL-OBJECT ()>
@ZG.routine('TUNNEL-OBJECT')
def TUNNEL_OBJECT():
    if (VERB_p('THROUGH') and GETP(ZG.HERE, 'IN')):
        ZG.DO_WALK('IN')
        return True
    else:
        return ZG.PATH_OBJECT()

'SUBTITLE CHINESE PUZZLE SECTION (COURTESY OF WILL WENG)'

# zil: 3actions.zil:172  <GLOBAL CPHERE>
# GLOBAL (state) CPHERE = 1  ->  ZilGlobal.py

# zil: 3actions.zil:174  <GLOBAL CPOBJS>
# GLOBAL (state) CPOBJS = ITABLE('NONE', (8 * 2 * 36))  ->  ZilGlobal.py

# zil: 3actions.zil:176  <GLOBAL CPTABLE>
# GLOBAL (state) CPTABLE = TABLE(1, 0, -1, 0, 0, -1, 0, -1, 0, 1, 0, -2, 0, 0, 0, 0, 0, 1, 0, -3, 0, 0, -1, -1, 0, 0, 0, -1, 0, 0, 0, 1, 1, 0, 0, 0, 1)  ->  ZilGlobal.py

# ;" 0 is no wall
#     1 is fixed wall
#    -1 is movable wall (-2 is good ladder, -3 bad ladder)"

# zil: 3actions.zil:219  <GLOBAL CPWALLS>
# GLOBAL (state) CPWALLS = LTABLE(ZG.CPSWL, 6, ZG.CPNWL, -6, ZG.CPEWL, 1, ZG.CPWWL, -1)  ->  ZilGlobal.py

# zil: 3actions.zil:221  <GLOBAL CPEXITS>
# GLOBAL (state) CPEXITS = LTABLE('NORTH', -6, 'SOUTH', 6, 'EAST', 1, 'WEST', -1, 'NE', -5, 'NW', -7, 'SE', 7, 'SW', 5)  ->  ZilGlobal.py

# zil: 3actions.zil:239  <GLOBAL CP-MOVED>
# GLOBAL (state) CP_MOVED = False  ->  ZilGlobal.py

# zil: 3actions.zil:241  <ROUTINE CPEXIT ("AUX" FX NFX)>
@ZG.routine('CPEXIT')
def CPEXIT():
    FX = 0
    NFX = 0
    ZG.CP_MOVED = False
    if (ZG.PRSO == 'UP'):
        if (ZG.CPHERE == 1):
            if (GET(ZG.CPTABLE, 2) == -2):
                TELL('With the help of the ladder, you exit the puzzle.', CR)
                return ZG.CP_ANTE
            else:
                TELL('The exit is too far above your head.', CR)
                return False
        else:
            TELL('There is no way up.', CR)
            return False
    elif ((ZG.CPHERE == 33) and (ZG.PRSO == 'WEST') and ZG.CP_FLAG):
        FCLEAR(ZG.CP, Flag('TOUCHBIT'))
        return ZG.CP_OUT
    elif (ZG.PRSO == 'DOWN'):
        TELL("There's no way down here.", CR)
        return False
    elif ((ZG.CPHERE == 33) and (ZG.PRSO == 'WEST')):
        TELL('The metal door bars the way.', CR)
        return False
    else:
        FX = ZG.LKP(ZG.PRSO, ZG.CPEXITS)
        if (((NFX := (FX + ZG.CPHERE)) > 36) or (NFX < 0) or ZG.ILLCP(ZG.CPHERE, FX)):
            TELL('There is a wall there.', CR)
            return False
        elif (ABS(FX) in (1, 6)):
            ZG.CPMOVE(FX)
        elif ((FX > 0) and (0 in (GET(ZG.CPTABLE, (ZG.CPHERE + 6)), GET(ZG.CPTABLE, (ZG.CPHERE + (FX - 6)))))):
            ZG.CPMOVE(FX)
        elif ((FX < 0) and (0 in (GET(ZG.CPTABLE, (ZG.CPHERE - 6)), GET(ZG.CPTABLE, ((ZG.CPHERE + 6) + FX))))):
            ZG.CPMOVE(FX)
        else:
            TELL('There is a wall there.', CR)
        return False

# zil: 3actions.zil:292  <GLOBAL MINUS-SEVEN>
# GLOBAL (state) MINUS_SEVEN = -7  ->  ZilGlobal.py

# zil: 3actions.zil:293  <GLOBAL MINUS-FIVE>
# GLOBAL (state) MINUS_FIVE = -5  ->  ZilGlobal.py

# zil: 3actions.zil:294  <GLOBAL MINUS-FOUR>
# GLOBAL (state) MINUS_FOUR = -4  ->  ZilGlobal.py

# zil: 3actions.zil:295  <GLOBAL MINUS-ONE>
# GLOBAL (state) MINUS_ONE = -1  ->  ZilGlobal.py

# zil: 3actions.zil:297  <ROUTINE ILLCP (ONE TWO)>
@ZG.routine('ILLCP')
def ILLCP(ONE, TWO):
    if (((ONE % 6) == 0) and (TWO in (ZG.MINUS_FIVE, 1, 7))):
        return True
    elif (((ONE % 6) == 1) and (TWO in (ZG.MINUS_SEVEN, ZG.MINUS_ONE, 5))):
        return True
    elif ((ONE < 7) and (TWO < ZG.MINUS_FOUR)):
        return True
    elif ((ONE > 30) and (TWO > 4)):
        return True
    else:
        return False

# zil: 3actions.zil:305  <ROUTINE CPMOVE (FX)>
@ZG.routine('CPMOVE')
def CPMOVE(FX):
    if (GET(ZG.CPTABLE, (FX := (ZG.CPHERE + FX))) == 0):
        return ZG.CPGOTO(FX)
    else:
        return TELL('There is a wall there.', CR)

# zil: 3actions.zil:311  <ROUTINE CPENTER ()>
@ZG.routine('CPENTER')
def CPENTER():
    if ((not (ZG.YEAR == ZG.YEAR_PRESENT)) or ZG.CPBLOCK_FLAG):
        TELL('The hole is blocked by sandstone.', CR)
        return False
    else:
        ZG.CPHERE = 1
        return ZG.CP

# zil: 3actions.zil:319  <ROUTINE CPANT-ROOM (RARG)>
@ZG.routine('CPANT-ROOM')
def CPANT_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a small square room, in the middle of which is a round hole')
        if (ZG.CPBLOCK_FLAG or (not (ZG.YEAR == ZG.YEAR_PRESENT))):
            return TELL(' which is blocked by smooth sandstone.', CR)
        else:
            return TELL(" through which you can discern the floor some ten feet below.\nThe area under the hole is dark, but it appears to be completely enclosed\nin rock. In any event, it doesn't seem likely that you could climb back up.\nExits are west and, up a few steps, north.", CR)
    else:
        return False

# zil: 3actions.zil:333  <GLOBAL CPPUSH-FLAG>
# GLOBAL (state) CPPUSH_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:335  <GLOBAL CPSOLVE-FLAG>
# GLOBAL (state) CPSOLVE_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:337  <ROUTINE CPLADDER-OBJECT ()>
@ZG.routine('CPLADDER-OBJECT')
def CPLADDER_OBJECT():
    if (GET(ZG.CPTABLE, (ZG.CPHERE - 1)) == -3):
        return ZG.CPLADDER_JUNK(False)
    elif (GET(ZG.CPTABLE, (ZG.CPHERE + 1)) == -2):
        return ZG.CPLADDER_JUNK(True)
    else:
        return TELL("You can't see any ladder here.", CR)

# zil: 3actions.zil:344  <ROUTINE CPLADDER-JUNK (FLG)>
@ZG.routine('CPLADDER-JUNK')
def CPLADDER_JUNK(FLG):
    if VERB_p('CLIMB-UP', 'CLIMB-FOO'):
        if (FLG and (ZG.CPHERE == 1)):
            ZG.CPSOLVE_FLAG = True
            return ZG.GOTO(ZG.CP_ANTE)
        else:
            return TELL('You hit your head on the ceiling and fall off the ladder.', CR)
    else:
        return TELL('Come, come!', CR)

# zil: 3actions.zil:354  <ROUTINE CPWALL-OBJECT ("AUX" WL NWL NXT NNXT CNT TOP (SNAP <>))>
@ZG.routine('CPWALL-OBJECT')
def CPWALL_OBJECT():
    WL = 0
    NWL = 0
    NXT = 0
    NNXT = 0
    CNT = 0
    TOP = 0
    SNAP = False
    if VERB_p('MOVE'):
        return TELL("You can't grab the wall to pull it.", CR)
    elif VERB_p('PUSH'):
        NXT = ZG.CPNEXT(ZG.CPHERE, ZG.PRSO)
        if (NXT == 0):
            TELL("The wall doesn't budge.", CR)
            return True
        WL = GET(ZG.CPTABLE, NXT)
        if (WL == 0):
            return TELL('There is only a passage in that direction.', CR)
        elif (WL == 1):
            return TELL("The wall doesn't budge.", CR)
        elif ((NNXT := ZG.CPNEXT(NXT, ZG.PRSO)) == 0):
            return TELL('The wall barely gives.', CR)
        elif (not ((NWL := GET(ZG.CPTABLE, NNXT)) == 0)):
            return TELL('The wall barely gives.', CR)
        else:
            TELL('The wall slides forward and you follow it')
            if ZG.CPPUSH_FLAG:
                TELL(' to this position:', CR)
            else:
                ZG.SCORE = (ZG.SCORE + 1)
                TELL('....\nThe architecture of this region is getting complex, so that further\ndescriptions will be diagrams of the immediate vicinity in a 3x3\ngrid. The walls here are rock, but of two different types - sandstone\nand marble. The following notations will be used:\n')
                ZG.FIXED_FONT_ON()
                TELL('\n  .. = your position (middle of grid)\n  MM = marble wall\n  SS = sandstone wall\n  ?? = unknown (blocked by walls)\n\n')
                ZG.FIXED_FONT_OFF()
            ZG.CPPUSH_FLAG = True
            PUT(ZG.CPTABLE, NXT, 0)
            PUT(ZG.CPTABLE, NNXT, WL)
            if (not (NNXT == 0)):
                TOP = (8 * (NNXT - 1))
                CNT = GET(ZG.CPOBJS, TOP)
                while True:
                    if (CNT == 0):
                        break
                    else:
                        TOP = (TOP + 1)
                        MOVE(GET(ZG.CPOBJS, TOP), ZG.CP_OUT)
                        if (not SNAP):
                            SNAP = True
                            TELL('You hear a soft "snap" from behind the wall you were pushing.', CR)
                        CNT = (CNT - 1)
            if (NNXT == 1):
                ZG.CPBLOCK_FLAG = True
            return ZG.CPGOTO(NXT)
    else:
        return False

# zil: 3actions.zil:414  <ROUTINE FIXED-FONT-ON ()>
@ZG.routine('FIXED-FONT-ON')
def FIXED_FONT_ON():
    return PUT(0, 8, (GET(0, 8) | 2))

# zil: 3actions.zil:416  <ROUTINE FIXED-FONT-OFF ()>
@ZG.routine('FIXED-FONT-OFF')
def FIXED_FONT_OFF():
    return PUT(0, 8, (GET(0, 8) & -3))

'Flag for blocking of main entrance'

# zil: 3actions.zil:420  <GLOBAL CPBLOCK-FLAG>
# GLOBAL (state) CPBLOCK_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:422  <CONSTANT GCARDLOC>
# CONSTANT (const) GCARDLOC = 168  ->  ZilGlobal.py

# ;"8*(22-1)"

# zil: 3actions.zil:424  <ROUTINE CPGOTO (FX "AUX" F X CNT TOP)>
@ZG.routine('CPGOTO')
def CPGOTO(FX):
    F = 0
    X = 0
    CNT = 0
    TOP = 0
    ZG.CP_MOVED = True
    FCLEAR(ZG.HERE, Flag('TOUCHBIT'))
    TOP = (8 * (ZG.CPHERE - 1))
    CNT = (TOP + 1)
    F = FIRST_p(ZG.CP)
    while True:
        X = NEXT_p(F)
        if (not F):
            break
        elif (F == ZG.ADVENTURER):
            pass
        else:
            PUT(ZG.CPOBJS, CNT, F)
            REMOVE(F)
            CNT = (CNT + 1)
        if (not X):
            break
        else:
            F = X
    PUT(ZG.CPOBJS, TOP, ((CNT - TOP) - 1))
    ZG.CPHERE = FX
    TOP = (8 * (ZG.CPHERE - 1))
    CNT = GET(ZG.CPOBJS, TOP)
    while True:
        if (CNT == 0):
            break
        else:
            TOP = (TOP + 1)
            MOVE(GET(ZG.CPOBJS, TOP), ZG.CP)
            CNT = (CNT - 1)
    ZG.PERFORM(SYMBOL('V?LOOK'))
    return True

# zil: 3actions.zil:454  <ROUTINE CPNEXT (RM OBJ "AUX" FX)>
@ZG.routine('CPNEXT')
def CPNEXT(RM, OBJ_l):
    FX = 0
    FX = ZG.LKP(OBJ_l, ZG.CPWALLS)
    if ZG.ILLCP(RM, FX):
        return 0
    else:
        return (RM + FX)

# zil: 3actions.zil:460  <ROUTINE CPDOOR-F ()>
@ZG.routine('CPDOOR-F')
def CPDOOR_F():
    if ((ZG.HERE == ZG.CP) and (not (ZG.CPHERE == 33))):
        return TELL("You can't see any steel door here.", CR)
    elif VERB_p('OPEN'):
        if ZG.CP_FLAG:
            return TELL('The steel door has already opened.', CR)
        else:
            return TELL("You can't force it open.", CR)
    elif VERB_p('CLOSE'):
        if ZG.CP_FLAG:
            return TELL("There doesn't seem to be any way to close it.", CR)
        else:
            return TELL("Do you think it isn't already?", CR)
    elif VERB_p('MUNG'):
        return TELL('The door is, to a first approximation, indestructible.', CR)
    elif VERB_p('KNOCK'):
        return TELL('Besides a great amount of reverberation, nothing happens.', CR)
    else:
        return False

# zil: 3actions.zil:477  <ROUTINE CP-ROOM (RARG)>
@ZG.routine('CP-ROOM')
def CP_ROOM(RARG):
    if (RARG == ZG.M_ENTER):
        if (ZG.PRSO == 'DOWN'):
            ZG.CPHERE = 1
        else:
            ZG.CPHERE = 33
        return ZG.CPHERE
    elif (RARG == ZG.M_LOOK):
        if ZG.CPPUSH_FLAG:
            return ZG.CPWHERE()
        else:
            return TELL('You are in a small square room bounded to the north and west with\nmarble walls and to the east and south with sandstone walls.', CR)
    else:
        return False

# zil: 3actions.zil:489  <ROUTINE CPNS (NUM)>
@ZG.routine('CPNS')
def CPNS(NUM_l):
    if ((NUM_l > 36) or (NUM_l < 1)):
        return 1
    else:
        return GET(ZG.CPTABLE, NUM_l)

# zil: 3actions.zil:494  <ROUTINE CPEW (NUM FOO)>
@ZG.routine('CPEW')
def CPEW(NUM_l, FOO):
    if ((NUM_l % 6) == FOO):
        return 1
    else:
        return GET(ZG.CPTABLE, NUM_l)

# zil: 3actions.zil:499  <ROUTINE CPWHERE ("AUX" (N <CPNS <+ ,CPHERE -6>>) (S <CPNS <+ ,CPHERE 6>>) (E...
@ZG.routine('CPWHERE')
def CPWHERE():
    N_l = ZG.CPNS((ZG.CPHERE + -6))
    S_l = ZG.CPNS((ZG.CPHERE + 6))
    E = ZG.CPEW((ZG.CPHERE + 1), 1)
    W = ZG.CPEW((ZG.CPHERE + -1), 0)
    ZG.FIXED_FONT_ON()
    TELL('      +')
    # ;"Top Row"
    ZG.CP_CORNER(ZG.MINUS_SEVEN, N_l, W)
    TELL(' ')
    ZG.CP_ORTHO(N_l)
    TELL(' ')
    ZG.CP_CORNER(ZG.MINUS_FIVE, N_l, E)
    TELL('+', CR)
    TELL('West  +')
    # ;"Middle Row"
    ZG.CP_ORTHO(W)
    TELL(' .. ')
    ZG.CP_ORTHO(E)
    TELL('+  East', CR)
    TELL('      +')
    # ;"Bottom Row"
    ZG.CP_CORNER(5, S_l, W)
    TELL(' ')
    ZG.CP_ORTHO(S_l)
    TELL(' ')
    ZG.CP_CORNER(7, S_l, E)
    TELL('+', CR)
    ZG.FIXED_FONT_OFF()
    if (ZG.CPHERE == 1):
        TELL('In the ceiling above you is a large circular opening.', CR)
    elif (ZG.CPHERE == 22):
        TELL('The center of the floor here is noticeably depressed.', CR)
    elif (ZG.CPHERE == 33):
        TELL('In the center of the west wall is a steel door which is ')
        if ZG.CP_FLAG:
            TELL('open')
        else:
            TELL('closed')
        TELL('.\nOn one side of the door is a narrow slot.', CR)
    if (E == -2):
        TELL('There is a ladder here, firmly attached to the east wall.', CR)
    if (W == -3):
        return TELL('There is a ladder here, firmly attached to the west wall.', CR)
    else:
        return False

'Show where the eight nearest neighbors are located'

# zil: 3actions.zil:548  <ROUTINE CP-ORTHO (CONTENTS)>
@ZG.routine('CP-ORTHO')
def CP_ORTHO(CONTENTS):
    if (CONTENTS == 0):
        return TELL('  ')
    elif (CONTENTS == 1):
        return TELL('MM')
    else:
        return TELL('SS')

# ;"Show an orthogonal neighbor"

# zil: 3actions.zil:556  <ROUTINE CP-CORNER (DIR COL ROW "AUX" LOCN)>
@ZG.routine('CP-CORNER')
def CP_CORNER(DIR, COL, ROW):
    LOCN = 0
    LOCN = (ZG.CPHERE + DIR)
    if ((not (COL == 0)) and (not (ROW == 0))):
        return TELL('??')
    elif ZG.ILLCP(ZG.CPHERE, DIR):
        return TELL('MM')
    else:
        if ((LOCN < 1) or (LOCN > 36)):
            COL = 1
        else:
            COL = GET(ZG.CPTABLE, LOCN)
        if (COL == 0):
            return TELL('  ')
        elif (COL == 1):
            return TELL('MM')
        else:
            return TELL('SS')

# zil: 3actions.zil:568  <ROUTINE CP-SLOT-FCN ()>
@ZG.routine('CP-SLOT-FCN')
def CP_SLOT_FCN():
    if VERB_p('PUT'):
        if (GETP(ZG.PRSO, 'SIZE') > 10):
            TELL("It doesn't fit.", CR)
            return True
        REMOVE(ZG.PRSO)
        if (ZG.PRSO == ZG.LORE_BOOK):
            ZG.CP_FLAG = True
            return TELL('The book drops into the slot and vanishes. The metal door slides\nopen, revealing a passageway to the west, and a sign flashes:\n    "Royal Puzzle Exit Fee Paid\n          Item Confiscated"', CR)
        elif FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            return TELL(ZG.PICK_ONE(ZG.YUKS), CR)
        else:
            return TELL('The item vanishes into the slot. A moment later, a previously\nunseen sign flashes "Garbage In, Garbage Out" and spews out\nthe ', D, ZG.PRSO, ' (now atomized).', CR)
    else:
        return False

# zil: 3actions.zil:589  <ROUTINE CPOUT-ROOM (RARG)>
@ZG.routine('CPOUT-ROOM')
def CPOUT_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a narrow room, lit from above. A flight of steps leads up\nto the north, and a ')
        if ZG.CP_FLAG:
            TELL('passage')
        else:
            TELL('metal door')
        return TELL(' leads to the east.', CR)
    else:
        return False

'Old end-game stuff'

# ;"SUBTITLE It's All Done with Mirrors"

# zil: 3actions.zil:602  <GLOBAL MLOC>
# GLOBAL (state) MLOC = False  ->  ZilGlobal.py

# zil: 3actions.zil:604  <GLOBAL MR1-FLAG>
# GLOBAL (state) MR1_FLAG = True  ->  ZilGlobal.py

# zil: 3actions.zil:606  <GLOBAL MR2-FLAG>
# GLOBAL (state) MR2_FLAG = True  ->  ZilGlobal.py

# zil: 3actions.zil:608  <GLOBAL MIRROR-OPEN-FLAG>
# GLOBAL (state) MIRROR_OPEN_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:610  <GLOBAL WOOD-OPEN-FLAG>
# GLOBAL (state) WOOD_OPEN_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:612  <GLOBAL MRSWPUSH-FLAG>
# GLOBAL (state) MRSWPUSH_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:614  <GLOBAL R-SOUTHS>
# GLOBAL (state) R_SOUTHS = LTABLE(ZG.FRONT_DOOR, ZG.MRD, ZG.MRG, ZG.MRC, ZG.MRB, ZG.MRA, ZG.MREYE)  ->  ZilGlobal.py

# zil: 3actions.zil:615  <GLOBAL R-NORTHS>
# GLOBAL (state) R_NORTHS = LTABLE(ZG.MREYE, ZG.MRA, ZG.MRB, ZG.MRC, ZG.MRG, ZG.MRD)  ->  ZilGlobal.py

# zil: 3actions.zil:617  <ROUTINE MRGO ("AUX" TORM)>
@ZG.routine('MRGO')
def MRGO():
    TORM = 0
    if (ZG.PRSO in ('NORTH', 'NW', 'NE')):
        TORM = ZG.LKP(ZG.HERE, ZG.R_NORTHS)
    else:
        TORM = ZG.LKP(ZG.HERE, ZG.R_SOUTHS)
    if (ZG.PRSO in ('NORTH', 'SOUTH')):
        if (ZG.MLOC == TORM):
            if ((ZG.MDIR % 180) == 0):
                TELL('There is a wooden wall blocking your way.', CR)
                return False
            elif ZG.MIRIN(False):
                return ZG.IN_MIRROR
            else:
                ZG.MIRBLOCK()
                return False
        else:
            return TORM
    elif (ZG.MLOC == TORM):
        if ((ZG.MDIR % 180) == 0):
            return ZG.GO_E_W(TORM)
        else:
            ZG.MIRBLOCK()
            return False
    else:
        return TORM

# zil: 3actions.zil:635  <ROUTINE MIRBLOCK ("AUX" MD)>
@ZG.routine('MIRBLOCK')
def MIRBLOCK():
    MD = 0
    MD = ZG.MDIR
    if (ZG.PRSO == 'SOUTH'):
        MD = ((ZG.MDIR + 180) % 360)
    if (((MD == 270) and (not ZG.MR1_FLAG)) or ((MD == 90) and (not ZG.MR2_FLAG))):
        return TELL('There is a large broken mirror blocking your way.', CR)
    else:
        return TELL('There is a large mirror blocking your way.', CR)

# zil: 3actions.zil:645  <ROUTINE GO-E-W (RM)>
@ZG.routine('GO-E-W')
def GO_E_W(RM):
    if (ZG.PRSO in ('NE', 'SE')):
        return ZG.LKP(RM, ZG.R_EASTS)
    else:
        return ZG.LKP(RM, ZG.R_WESTS)

# zil: 3actions.zil:650  <GLOBAL R-EASTS>
# GLOBAL (state) R_EASTS = LTABLE(ZG.MRA, ZG.MRAE, ZG.MRB, ZG.MRBE, ZG.MRC, ZG.MRCE, ZG.MRG, ZG.MRGE, ZG.MRD, ZG.MRDE)  ->  ZilGlobal.py

# zil: 3actions.zil:651  <GLOBAL R-WESTS>
# GLOBAL (state) R_WESTS = LTABLE(ZG.MRA, ZG.MRAW, ZG.MRB, ZG.MRBW, ZG.MRC, ZG.MRCW, ZG.MRG, ZG.MRGW, ZG.MRD, ZG.MRDW)  ->  ZilGlobal.py

# ---- DEFMAC N-S (3actions.zil:653-653) -------------------------------
# このマクロは、どこからも呼ばれていない。
# この定義は実行されない (ZIL の原文を残したもの)。
#
# <DEFMAC N-S () '<0? <MOD ,MDIR 180>>>
# ----------------------------------------------------------------------

# ---- DEFMAC E-W (3actions.zil:655-655) -------------------------------
# このマクロは、どこからも呼ばれていない。
# この定義は実行されない (ZIL の原文を残したもの)。
#
# <DEFMAC E-W ('FX) <FORM OR <FORM ==? .FX 90> <FORM ==? .FX 270>>>
# ----------------------------------------------------------------------

# zil: 3actions.zil:657  <ROUTINE EWTELL (RM "AUX" (EAST? <>) (M1? <>) MWIN)>
@ZG.routine('EWTELL')
def EWTELL(RM):
    EAST_p = False
    M1_p = False
    MWIN = 0
    if ((RM in (ZG.MRAE, ZG.MRBE, ZG.MRCE)) or (RM in (ZG.MRGE, ZG.MRCE))):
        EAST_p = True
    if EAST_p:
        _tmp1 = 0
    else:
        _tmp1 = 180
    if ((ZG.MDIR + _tmp1) == 180):
        M1_p = True
    if M1_p:
        MWIN = ZG.MR1_FLAG
    else:
        MWIN = ZG.MR2_FLAG
    if EAST_p:
        _tmp2 = 'west'
    else:
        _tmp2 = 'east'
    if MWIN:
        _tmp3 = 'mirror.'
    else:
        _tmp3 = 'wooden panel\nwhich once contained a mirror.'
    if EAST_p:
        _tmp4 = 'west'
    else:
        _tmp4 = 'east'
    if MWIN:
        _tmp5 = 'mirror.'
    else:
        _tmp5 = 'wooden panel\nwhich once contained a mirror.'
    TELL('You are in a narrow room, whose ', _tmp4, ' wall is a large ', _tmp5, CR)
    if (M1_p and ZG.MIRROR_OPEN_FLAG):
        if MWIN:
            _tmp6 = 'The mirror is mounted on a panel which has been opened outward.'
        else:
            _tmp6 = 'The panel has been opened outward.'
        if MWIN:
            _tmp7 = 'The mirror is mounted on a panel which has been opened outward.'
        else:
            _tmp7 = 'The panel has been opened outward.'
        TELL(_tmp7, CR)
    return TELL('The opposite wall is solid rock.', CR)

# zil: 3actions.zil:678  <GLOBAL GUARDIANS-SEEN>
# GLOBAL (state) GUARDIANS_SEEN = False  ->  ZilGlobal.py

# zil: 3actions.zil:680  <ROUTINE MRDEW ("OPTIONAL" (RARG <>))>
@ZG.routine('MRDEW')
def MRDEW(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        ZG.EWTELL(ZG.HERE)
        ZG.GUARDIANS_SEEN = True
        return TELL('Somewhat to the south', ZG.GUARDSTR, CR)
    else:
        return False

# zil: 3actions.zil:686  <ROUTINE MRCEW ("OPTIONAL" (RARG <>))>
@ZG.routine('MRCEW')
def MRCEW(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        ZG.EWTELL(ZG.HERE)
        ZG.GUARDIANS_SEEN = True
        return TELL('Somewhat to the north', ZG.GUARDSTR, CR)
    else:
        return False

# zil: 3actions.zil:692  <ROUTINE MRBEW ("OPTIONAL" (RARG <>))>
@ZG.routine('MRBEW')
def MRBEW(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        ZG.EWTELL(ZG.HERE)
        return TELL('To the north and south are large hallways.', CR)
    else:
        return False

# zil: 3actions.zil:697  <ROUTINE MRAEW ("OPTIONAL" (RARG <>))>
@ZG.routine('MRAEW')
def MRAEW(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        ZG.EWTELL(ZG.HERE)
        return TELL('To the north is a large hallway.', CR)
    else:
        return False

# zil: 3actions.zil:702  <GLOBAL GUARDSTR>
# GLOBAL (state) GUARDSTR = ', identical stone statues face each other from\npedestals on opposite sides of the corridor. The statues represent\nGuardians of Zork, a military order of ancient lineage. They are\nportrayed as heavily armored warriors clasping formidable bludgeons.'  ->  ZilGlobal.py

# zil: 3actions.zil:708  <ROUTINE LOOK-TO (RMN RMS "AUX" (NORTH? <>) (NTELL <>) (STELL <>) MIR? (M1? <...
@ZG.routine('LOOK-TO')
def LOOK_TO(RMN, RMS):
    NORTH_p = False
    NTELL = False
    STELL = False
    MIR_p = 0
    M1_p = False
    DIR = 0
    if (not (ZG.HERE in (ZG.MREYE, ZG.FRONT_DOOR))):
        TELL('This is a part of the long hallway. The east and west walls are\ndressed stone. In the center of the hall is a shallow stone channel.\nIn the center of the room the channel widens into a large hole around\nwhich is engraved a compass rose.', CR)
    if (ZG.HERE == ZG.MRG):
        ZG.GUARDIANS_SEEN = True
        TELL('On either side of you are identical stone statues holding bludgeons. They\nappear ready to strike, though, for the moment, they remain impassive.', CR)
    elif (ZG.HERE == ZG.MRC):
        ZG.GUARDIANS_SEEN = True
        TELL('Somewhat to the north', ZG.GUARDSTR, CR)
        NTELL = True
    elif (ZG.HERE == ZG.FRONT_DOOR):
        TELL('You are in a north-south hallway which ends, to the north, at a large wooden\ndoor.', CR)
        NTELL = True
    elif (ZG.HERE == ZG.MRD):
        ZG.GUARDIANS_SEEN = True
        TELL('Somewhat to the south', ZG.GUARDSTR, CR)
        STELL = True
    elif (ZG.HERE == ZG.MRA):
        TELL('The hallway continues to the south.', CR)
        STELL = True
    if (ZG.MLOC in (RMN, RMS)):
        if (ZG.MLOC == RMN):
            NORTH_p = True
            NTELL = True
            DIR = 'nor'
        else:
            STELL = True
            DIR = 'sou'
        if (NORTH_p and (ZG.MDIR > 180) and (ZG.MDIR < 359)):
            M1_p = True
            MIR_p = ZG.MR1_FLAG
        elif ((not NORTH_p) and (ZG.MDIR > 0) and (ZG.MDIR < 179)):
            M1_p = True
            MIR_p = ZG.MR1_FLAG
        else:
            MIR_p = ZG.MR2_FLAG
        if ((ZG.MDIR % 180) == 0):
            TELL('The ', DIR, 'th side of the room is divided by a wooden wall into small\nhallways to the ')
            TELL(DIR, 'theast and ')
            TELL(DIR, 'thwest.', CR)
        else:
            if MIR_p:
                _tmp1 = 'A large mirror fills the '
            else:
                _tmp1 = 'A large panel fills the '
            if MIR_p:
                _tmp2 = 'A large mirror fills the '
            else:
                _tmp2 = 'A large panel fills the '
            TELL(_tmp2, DIR, 'th side of the hallway.', CR)
            if (M1_p and ZG.MIRROR_OPEN_FLAG):
                if MIR_p:
                    _tmp3 = 'The mirror is mounted on a panel which has been opened outward.'
                else:
                    _tmp3 = 'The panel has been opened outward.'
                if MIR_p:
                    _tmp4 = 'The mirror is mounted on a panel which has been opened outward.'
                else:
                    _tmp4 = 'The panel has been opened outward.'
                TELL(_tmp4, CR)
    if ((not NTELL) and (not STELL)):
        TELL('The corridor continues north and south.', CR)
    elif (not NTELL):
        TELL('The corridor continues north.', CR)
    elif (not STELL):
        TELL('The corridor continues south.', CR)
    return True

# zil: 3actions.zil:778  <ROUTINE MRDF ("OPTIONAL" (RARG <>))>
@ZG.routine('MRDF')
def MRDF(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        return ZG.LOOK_TO(ZG.FRONT_DOOR, ZG.MRG)
    else:
        return False

# zil: 3actions.zil:782  <ROUTINE MRCF ("OPTIONAL" (RARG <>))>
@ZG.routine('MRCF')
def MRCF(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        return ZG.LOOK_TO(ZG.MRG, ZG.MRB)
    else:
        return False

# zil: 3actions.zil:786  <ROUTINE MRBF ("OPTIONAL" (RARG <>))>
@ZG.routine('MRBF')
def MRBF(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        return ZG.LOOK_TO(ZG.MRC, ZG.MRA)
    else:
        return False

# zil: 3actions.zil:790  <ROUTINE MRAF ("OPTIONAL" (RARG <>))>
@ZG.routine('MRAF')
def MRAF(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        return ZG.LOOK_TO(ZG.MRB, False)
    else:
        return False

# zil: 3actions.zil:794  <ROUTINE GUARDIANS ("OPTIONAL" (RARG <>))>
@ZG.routine('GUARDIANS')
def GUARDIANS(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        if (ZG.HERE == ZG.MRG):
            return ZG.LOOK_TO(ZG.MRD, ZG.MRC)
        else:
            ZG.EWTELL(ZG.HERE)
            return TELL("To the east and west are the Guardians of Zork, in perfect symmetry.\nFrom here, it's hard to tell which of the two is a reflection!", CR)
    elif ((RARG == ZG.M_ENTER) and (not ZG.INVIS)):
        return ZG.JIGS_UP('The Guardians awake, and in perfect unison, pulverize you with\ntheir bludgeons. Satisfied, they resume their posts.')
    elif (not (RARG == ZG.M_END)):
        return False
    elif VERB_p('EXAMINE'):
        if (ZG.HERE == ZG.IN_MIRROR):
            return TELL("You can't see them from here.", CR)
        else:
            return TELL("The Guardians are quite impressive. I wouldn't get in their way if\nI were you!", CR)
    elif (VERB_p('THROW') and (ZG.PRSI == ZG.GUARDIAN)):
        if (ZG.PRSO == ZG.ME):
            TELL('You step')
        else:
            TELL('The ', D, ZG.PRSO, ' falls')
            REMOVE(ZG.PRSO)
        TELL(' in front of the Guardians, who ')
        if (ZG.PRSO == ZG.ME):
            TELL('decimate you')
        else:
            TELL('destroy it')
        return TELL(' in perfect\nunison. Satisfied, they resume their posts.', CR)
    elif VERB_p('ATTACK'):
        return TELL("You aren't close enough, and even if you were, the fight\nwould be a bit one-sided.", CR)
    elif VERB_p('HELLO'):
        return TELL('The statues are impassive.', CR)
    else:
        return False

# zil: 3actions.zil:834  <ROUTINE MIRROR-DIR? (DIR RM "AUX" TBL)>
@ZG.routine('MIRROR-DIR?')
def MIRROR_DIR_p(DIR, RM):
    TBL = 0
    if (DIR == 'NORTH'):
        TBL = ZG.R_NORTHS
    else:
        TBL = ZG.R_SOUTHS
    if (GETPT(RM, DIR) and (ZG.MLOC == ZG.LKP(RM, TBL))):
        if ((DIR == 'NORTH') and (ZG.MDIR > 180) and (ZG.MDIR < 360)):
            return 1
        elif ((DIR == 'SOUTH') and (ZG.MDIR > 0) and (ZG.MDIR < 180)):
            return 1
        else:
            return 2
    else:
        return False

# zil: 3actions.zil:848  <ROUTINE WOODEN-WALL-F ()>
@ZG.routine('WOODEN-WALL-F')
def WOODEN_WALL_F():
    if (((ZG.MDIR % 180) == 0) and (ZG.MIRROR_DIR_p('NORTH', ZG.HERE) or ZG.MIRROR_DIR_p('SOUTH', ZG.HERE))):
        if VERB_p('PUSH'):
            return TELL("The structure won't budge.", CR)
        else:
            return False
    else:
        return TELL("You can't see any wooden wall here.", CR)

# zil: 3actions.zil:856  <ROUTINE MIRROR-HERE? (RM "AUX" TMP)>
@ZG.routine('MIRROR-HERE?')
def MIRROR_HERE_p(RM):
    TMP = 0
    if ((ZG.HERE in (ZG.MRAE, ZG.MRAW, ZG.MRBE)) or (ZG.HERE in (ZG.MRBW, ZG.MRCE, ZG.MRCW)) or (ZG.HERE in (ZG.MRGE, ZG.MRGW, ZG.MRDE)) or (ZG.HERE == ZG.MRDW)):
        if ((RM in (ZG.MRAE, ZG.MRBE, ZG.MRCE)) or (RM in (ZG.MRGE, ZG.MRDE))):
            _tmp1 = 0
        else:
            _tmp1 = 180
        if (180 == (ZG.MDIR + _tmp1)):
            return 1
        else:
            return 2
    elif ((ZG.MDIR % 180) == 0):
        return False
    elif (TMP := ZG.MIRROR_DIR_p('NORTH', RM)):
        return TMP
    elif (TMP := ZG.MIRROR_DIR_p('SOUTH', RM)):
        return TMP
    else:
        return False

# zil: 3actions.zil:872  <ROUTINE MIRROR-FUNCTION ("AUX" MIRROR)>
@ZG.routine('MIRROR-FUNCTION')
def MIRROR_FUNCTION():
    MIRROR = 0
    if (not (MIRROR := ZG.MIRROR_HERE_p(ZG.HERE))):
        return TELL("You can't see any mirror here.", CR)
    elif VERB_p('OPEN', 'MOVE'):
        return TELL("You don't see a way to open the mirror here.", CR)
    elif VERB_p('LOOK-INSIDE'):
        if (((MIRROR == 1) and ZG.MR1_FLAG) or ZG.MR2_FLAG):
            if ZG.INVIS:
                return TELL('Amazingly, you have no reflection!', CR)
            else:
                return TELL('A disheveled adventurer stares back at you.', CR)
        else:
            return TELL('You have destroyed the mirror, or have you forgotten?', CR)
    elif VERB_p('MUNG'):
        if (MIRROR == 1):
            if ZG.MR1_FLAG:
                ZG.MR1_FLAG = False
                return TELL('The mirror breaks, revealing a wooden panel behind it. The glistening\nfragments of mirror quietly sparkle into nonexistance.', CR)
            else:
                return TELL('The mirror has already been broken.', CR)
        elif ZG.MR2_FLAG:
            ZG.MR2_FLAG = False
            return TELL('The mirror breaks, revealing a wooden panel behind it. The glistening\nfragments of mirror quietly sparkle into nonexistance.', CR)
        else:
            return TELL('The mirror has already been broken.', CR)
    elif (((MIRROR == 1) and (not ZG.MR1_FLAG)) or (not ZG.MR2_FLAG)):
        return TELL("There's no mirror left.", CR)
    elif VERB_p('PUSH'):
        if (MIRROR == 1):
            _tmp1 = 'The mirror is mounted on a wooden panel which moves slightly inward\nas you push, and back out when you let go. It feels fragile.'
        else:
            _tmp1 = 'The mirror is unyielding, but seems fragile.'
        if (MIRROR == 1):
            _tmp2 = 'The mirror is mounted on a wooden panel which moves slightly inward\nas you push, and back out when you let go. It feels fragile.'
        else:
            _tmp2 = 'The mirror is unyielding, but seems fragile.'
        return TELL(_tmp2, CR)
    else:
        return False

# zil: 3actions.zil:914  <ROUTINE PANEL-FUNCTION ("AUX" MIRROR)>
@ZG.routine('PANEL-FUNCTION')
def PANEL_FUNCTION():
    MIRROR = 0
    if (not (MIRROR := ZG.MIRROR_HERE_p(ZG.HERE))):
        return TELL("You can't see any panel here.", CR)
    elif VERB_p('OPEN', 'MOVE'):
        return TELL("You don't see a way to open the panel here.", CR)
    elif VERB_p('MUNG'):
        if (MIRROR == 1):
            if ZG.MR1_FLAG:
                return TELL(ZG.MIRROR_FIRST, CR)
            else:
                return TELL('The panel is not that easily destroyed.', CR)
        elif ZG.MR2_FLAG:
            return TELL(ZG.MIRROR_FIRST, CR)
        else:
            return TELL('The panel is not that easily destroyed.', CR)
    elif VERB_p('PUSH'):
        if (MIRROR == 1):
            _tmp1 = 'The wooden panel moves slightly inward as you push, and back out\nwhen you let go.'
        else:
            _tmp1 = 'The panel is unyielding.'
        if (MIRROR == 1):
            _tmp2 = 'The wooden panel moves slightly inward as you push, and back out\nwhen you let go.'
        else:
            _tmp2 = 'The panel is unyielding.'
        return TELL(_tmp2, CR)
    else:
        return False

# zil: 3actions.zil:935  <GLOBAL MIRROR-FIRST>
# GLOBAL (state) MIRROR_FIRST = 'To break the panel you would have to break the mirror first.'  ->  ZilGlobal.py

# zil: 3actions.zil:938  <GLOBAL DIRVEC>
# GLOBAL (state) DIRVEC = LTABLE('NORTH', 0, 'NE', 45, 'EAST', 90, 'SE', 135, 'SOUTH', 180, 'SW', 225, 'WEST', 270, 'NW', 315)  ->  ZilGlobal.py

# zil: 3actions.zil:941  <ROUTINE MIROUT ("AUX" DIR RM)>
@ZG.routine('MIROUT')
def MIROUT():
    DIR = 0
    RM = 0
    if (ZG.PRSO == 'OUT'):
        DIR = 1
    else:
        DIR = ZG.LKP(ZG.PRSO, ZG.DIRVEC)
    if ZG.MIRROR_OPEN_FLAG:
        if ((DIR == 1) or (((ZG.MDIR + 270) % 360) == DIR)):
            if ((ZG.MDIR % 180) == 0):
                return ZG.MIREW()
            else:
                return ZG.MIRNS((ZG.MDIR < 180), True)
        else:
            TELL("There's a wall there.", CR)
            return False
    elif ZG.WOOD_OPEN_FLAG:
        if ((DIR == 1) or (((ZG.MDIR + 180) % 360) == DIR)):
            if (ZG.MDIR == 0):
                RM = False
            else:
                RM = True
            if (RM := ZG.MIRNS(RM, True)):
                TELL('As you leave, the door swings shut.', CR)
                ZG.WOOD_OPEN_FLAG = False
                return RM
            else:
                TELL("You can't go that way.", CR)
                return False
        else:
            TELL('You would hit one of the panels.', CR)
            return False
    else:
        TELL('You are inside a closed box!', CR)
        return False

"MIRNS -- returns room in a given direction from the mirror (north or\nsouth as indicated by first argument).  If second arg is T, then we\nare exiting, not moving the mirror, so don't worry about ends."

# zil: 3actions.zil:975  <ROUTINE MIRNS (NORTH? "OPTIONAL" (EXIT? <>) "AUX" S T)>
@ZG.routine('MIRNS')
def MIRNS(NORTH_p, EXIT_p=None):
    if EXIT_p is None:
        EXIT_p = False
    S_l = 0
    T = 0
    if (not EXIT_p):
        if (NORTH_p and (ZG.MLOC == ZG.MRD)):
            return False
        elif ((not NORTH_p) and (ZG.MLOC == ZG.MRA)):
            return False
    if NORTH_p:
        _tmp1 = 'NORTH'
    else:
        _tmp1 = 'SOUTH'
    if NORTH_p:
        _tmp2 = 'NORTH'
    else:
        _tmp2 = 'SOUTH'
    if (T := GETPT(ZG.MLOC, _tmp2)):
        if ((S_l := PTSIZE(T)) == ZG.UEXIT):
            return GETB(T, 0)
        elif NORTH_p:
            return ZG.LKP(ZG.MLOC, ZG.R_NORTHS)
        else:
            return ZG.LKP(ZG.MLOC, ZG.R_SOUTHS)
    else:
        return False

# zil: 3actions.zil:990  <ROUTINE MIREW ()>
@ZG.routine('MIREW')
def MIREW():
    if (ZG.MDIR == 0):
        return ZG.LKP(ZG.MLOC, ZG.R_WESTS)
    else:
        return ZG.LKP(ZG.MLOC, ZG.R_EASTS)

# zil: 3actions.zil:994  <ROUTINE MIRIN ("OPTIONAL" (VRB T))>
@ZG.routine('MIRIN')
def MIRIN(VRB=None):
    if VRB is None:
        VRB = True
    if ((ZG.MIRROR_HERE_p(ZG.HERE) == 1) and ZG.MIRROR_OPEN_FLAG):
        return ZG.IN_MIRROR
    elif (not VRB):
        return False
    elif (ZG.MIRROR_HERE_p(ZG.HERE) == 1):
        if ((not ZG.MIRROR_OPENED) and ZG.MR1_FLAG):
            TELL('A mirror blocks your way.', CR)
            return False
        else:
            TELL('The panel is closed.', CR)
            return False
    else:
        TELL('The structure blocks your way.', CR)
        return False

# zil: 3actions.zil:1005  <ROUTINE MREYE-ROOM ("OPTIONAL" (RARG <>) "AUX" O)>
@ZG.routine('MREYE-ROOM')
def MREYE_ROOM(RARG=None):
    if RARG is None:
        RARG = False
    O_l = 0
    if ((RARG == ZG.M_BEG) and VERB_p('DROP') and IN_p(ZG.PRSO, ZG.WINNER) and (not ZG.BEAM_STOPPED_p())):
        MOVE(ZG.PRSO, ZG.HERE)
        return TELL('You conveniently drop the ', D, ZG.PRSO, ' in position to block the\nbeam of light.', CR)
    elif (RARG == ZG.M_LOOK):
        TELL('You are in the middle of a long north-south corridor whose walls are\npolished stone. A narrow red beam of light crosses the room at the north\nend, inches above the floor.', CR)
        if (O_l := ZG.BEAM_STOPPED_p()):
            TELL('The beam is blocked by a ', D, O_l, ' lying on the floor.', CR)
        return ZG.LOOK_TO(ZG.MRA, False)
    else:
        return False

# zil: 3actions.zil:1024  <ROUTINE BEAM-STOPPED? ("AUX" N)>
@ZG.routine('BEAM-STOPPED?')
def BEAM_STOPPED_p():
    N_l = 0
    N_l = FIRST_p(ZG.MREYE)
    while True:
        if (not (N_l in (ZG.PLAYER, ZG.BEAM))):
            ZG.BEAM_BREAKER = N_l
            return N_l
        elif (not (N_l := NEXT_p(N_l))):
            return False

# ; "This function cannot have its .PRSI and .PRSO's changed to ,PRSI etc!!"

# zil: 3actions.zil:1034  <GLOBAL BEAM-BREAKER>
# GLOBAL (state) BEAM_BREAKER = False  ->  ZilGlobal.py

# zil: 3actions.zil:1036  <ROUTINE BEAM-FUNCTION ("AUX" PRO PRI)>
@ZG.routine('BEAM-FUNCTION')
def BEAM_FUNCTION():
    PRO = 0
    PRI = 0
    if VERB_p('LEAP'):
        TELL('You jump over the beam and into the hallway.', CR)
        ZG.GOTO(ZG.MRA)
        return True
    elif VERB_p('FOLLOW'):
        return TELL("It simply crosses the northern end of the room, so there's nowhere to\nfollow it.", CR)
    elif VERB_p('EXAMINE'):
        TELL('The red beam of light crosses the north end of the room only an inch or so\nabove the floor.')
        if ZG.BEAM_STOPPED_p():
            TELL(' The beam is broken by a ', D, ZG.BEAM_BREAKER, ' lying on the ground.')
        return CRLF()
    elif VERB_p('PUT', 'MUNG'):
        if VERB_p('PUT'):
            PRI = ZG.PRSO
            PRO = ZG.PRSI
        else:
            PRI = ZG.PRSI
            PRO = ZG.PRSO
        if ((not PRI) or (not (PRO == ZG.BEAM))):
            return False
        elif IN_p(PRI, ZG.WINNER):
            MOVE(PRI, ZG.HERE)
            ZG.BEAM_BREAKER = PRI
            return TELL('The beam is now interrupted by a ', D, PRI, ' lying on the floor.', CR)
        elif IN_p(PRI, ZG.HERE):
            return TELL('The ', D, PRI, ' already breaks the beam.', CR)
        elif (PRI == ZG.HANDS):
            return TELL('The beam is broken briefly as it passes through.', CR)
        else:
            return TELL("You're not holding the ", D, PRI, '.', CR)
    elif (VERB_p('TAKE') and (ZG.PRSO == ZG.BEAM)):
        return TELL('No doubt you have a bottle of moonbeams as well.', CR)
    else:
        return False

# zil: 3actions.zil:1079  <GLOBAL MIRROR-OPENED>
# GLOBAL (state) MIRROR_OPENED = False  ->  ZilGlobal.py

# zil: 3actions.zil:1081  <ROUTINE MRSWITCH ()>
@ZG.routine('MRSWITCH')
def MRSWITCH():
    if VERB_p('PUSH'):
        if ZG.MRSWPUSH_FLAG:
            return TELL('Click.', CR)
        else:
            if ZG.BEAM_STOPPED_p():
                TELL('Click. Snap!', CR)
                ENABLE(ZG.QUEUE(ZG.I_MRINT, 7))
                ZG.MRSWPUSH_FLAG = True
                ZG.MIRROR_OPEN_FLAG = True
                ZG.MIRROR_OPENED = True
                return FCLEAR(ZG.MRA, Flag('TOUCHBIT'))
            else:
                return TELL('Click.', CR)
    else:
        return False

# zil: 3actions.zil:1095  <ROUTINE I-MRINT ()>
@ZG.routine('I-MRINT')
def I_MRINT():
    ZG.MRSWPUSH_FLAG = False
    ZG.MIRROR_OPEN_FLAG = False
    if ((ZG.MIRROR_HERE_p(ZG.HERE) == 1) or (ZG.HERE == ZG.IN_MIRROR)):
        return TELL('The mirror quietly swings shut.', CR)
    elif (ZG.HERE == ZG.MR_ANTE):
        return TELL('The button pops back to its original position.', CR)
    else:
        return False

# zil: 3actions.zil:1104  <GLOBAL MDIR>
# GLOBAL (state) MDIR = 270  ->  ZilGlobal.py

# ;"mirror points... 0 = north"

# zil: 3actions.zil:1108  <GLOBAL POLEUP-FLAG>
# GLOBAL (state) POLEUP_FLAG = 0  ->  ZilGlobal.py

# ;"pole raised?: 0 -- in hole or channel, 1 -- foor level, 2 -- in air"

# zil: 3actions.zil:1112  <ROUTINE MAGIC-MIRROR ("OPTIONAL" (RARG <>))>
@ZG.routine('MAGIC-MIRROR')
def MAGIC_MIRROR(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_LOOK):
        TELL('You are inside a rectangular box of wood whose structure is rather\ncomplicated. Four sides and the roof are filled in, and the floor is\nopen.\n\nAs you face the side opposite the entrance, two short sides of\ncarved and polished wood are to your left and right. The left panel\nis mahogany, the right pine. The wall you face is red on its left\nhalf and black on its right. On the entrance side, the wall is white\nopposite the red part of the wall it faces, and yellow opposite the\nblack section. The painted walls are at least twice the length of\nthe unpainted ones. The ceiling is painted blue.\n\nIn the floor is a stone channel about six inches wide and a foot\ndeep. The channel is oriented in a north-south direction. In the\nexact center of the room the channel widens into a circular\ndepression perhaps two feet wide. Incised in the stone around this\narea is a compass rose.\n\nRunning from one short wall to the other at about waist height\nis a wooden bar, carefully carved and drilled. This bar is pierced\nin two places. The first hole is in the center of the bar (and thus\nthe center of the room). The second is at the left end of the room\n(as you face opposite the entrance). Through each hole runs a wooden\npole.\n\nThe pole at the left end of the bar is short, extending about a foot\nabove the bar, and ends in a hand grip. The pole ')
        if ((ZG.MLOC == ZG.MRB) and (ZG.MDIR == 270)):
            if (not (ZG.POLEUP_FLAG == 0)):
                TELL('has been lifted out\nof a hole carved in the stone floor. There is evidently enough\nfriction to keep the pole from dropping back down.')
            else:
                TELL('has been dropped\ninto a hole carved in the stone floor.')
        elif (ZG.MDIR in (0, 180)):
            if (not (ZG.POLEUP_FLAG == 0)):
                TELL('is positioned above\nthe stone channel in the floor.')
            else:
                TELL('has been dropped\ninto the stone channel incised in the floor.')
        else:
            TELL('is resting on the\nstone floor.')
        TELL('\n\nThe long pole at the center of the bar extends from the ceiling\nthrough the bar to the circular area in the stone channel. This\nbottom end of the pole has a T-bar a bit less than two feet long\nattached to it, and on the T-bar is carved an arrow. The arrow and\nT-bar are pointing ', GET(ZG.LONGDIRS, (ZG.MDIR // 45)), '.')
        if ZG.WOOD_OPEN_FLAG:
            TELL('\nThe pine panel has been opened outward.')
        return CRLF()
    else:
        return False

# zil: 3actions.zil:1177  <GLOBAL LONGDIRS>
# GLOBAL (state) LONGDIRS = TABLE('north', 'northeast', 'east', 'southeast', 'south', 'southwest', 'west', 'northwest')  ->  ZilGlobal.py

# ;"MOVEMENT"

# zil: 3actions.zil:1182  <ROUTINE MPANELS ("AUX" MD)>
@ZG.routine('MPANELS')
def MPANELS():
    MD = 0
    if VERB_p('PUSH'):
        if (not (ZG.POLEUP_FLAG == 0)):
            if (ZG.MLOC == ZG.MRG):
                if ZG.GUARDIANS_SEEN:
                    ZG.JIGS_UP('The Guardians awake, and in perfect unison, utterly destroy you with\ntheir stone bludgeons. Satisfied, they resume their posts.')
                    return True
                else:
                    ZG.JIGS_UP('All at once, two immense stone bludgeons come through the top of the\nstructure, crushing you.')
                    return True
            if (ZG.PRSO in (ZG.RED_PANEL, ZG.YELLOW_PANEL)):
                MD = ((ZG.MDIR + 45) % 360)
                TELL('The structure rotates clockwise.', CR)
            else:
                MD = ((ZG.MDIR + 315) % 360)
                TELL('The structure rotates counterclockwise.', CR)
            TELL('The arrow on the compass rose now indicates ', GET(ZG.LONGDIRS, (MD // 45)), '.', CR)
            if ZG.WOOD_OPEN_FLAG:
                ZG.WOOD_OPEN_FLAG = False
                TELL('The pine wall closes quietly.', CR)
            ZG.MDIR = MD
            return True
        elif ((ZG.MDIR % 180) == 0):
            return TELL('The short pole prevents the structure from rotating.', CR)
        else:
            return TELL("The structure shakes slightly but doesn't move.", CR)
    else:
        return False

# zil: 3actions.zil:1218  <ROUTINE MENDS ("AUX" RM)>
@ZG.routine('MENDS')
def MENDS():
    RM = 0
    if VERB_p('CLOSE'):
        return TELL("You can't do that to the panel.", CR)
    elif (VERB_p('PUSH') or (VERB_p('OPEN') and (ZG.PRSO == ZG.PINE_PANEL))):
        if (not ((ZG.MDIR % 180) == 0)):
            return TELL("The structure rocks back and forth slightly but doesn't move.", CR)
        elif (ZG.PRSO == ZG.MAHOGANY_PANEL):
            if (RM := ZG.MIRNS((ZG.MDIR < 180))):
                return ZG.MIRMOVE((ZG.MDIR == 0), RM)
            else:
                return TELL("The structure has reached the end of the stone channel and won't\nbudge.", CR)
        else:
            TELL('The pine wall swings open.', CR)
            if (((ZG.MLOC == ZG.MRD) and (ZG.MDIR == 0)) or ((ZG.MLOC == ZG.MRC) and (ZG.MDIR == 180)) or (ZG.MLOC == ZG.MRG)):
                if ZG.GUARDIANS_SEEN:
                    TELL('The pine door opens into the field of view of the Guardians.', CR)
                else:
                    TELL('The pine door opens into the field of view of the Guardians of\nZork, represented by two identical stone statues carrying bludgeons.', CR)
                ZG.JIGS_UP('The Guardians awake, and in perfect unison, utterly destroy you with\ntheir stone bludgeons. Satisfied, they resume their posts.')
                return True
            ZG.WOOD_OPEN_FLAG = True
            return ENABLE(ZG.QUEUE(ZG.I_PININ, 5))
    else:
        return False

# zil: 3actions.zil:1253  <ROUTINE I-PININ ()>
@ZG.routine('I-PININ')
def I_PININ():
    if ZG.WOOD_OPEN_FLAG:
        ZG.WOOD_OPEN_FLAG = False
        return TELL('The pine wall closes quietly.', CR)
    else:
        return False

# zil: 3actions.zil:1258  <ROUTINE MIRMOVE (NORTH? RM "AUX" (PU? <>) (LOSE <>))>
@ZG.routine('MIRMOVE')
def MIRMOVE(NORTH_p, RM):
    PU_p = False
    LOSE = False
    if (not (ZG.POLEUP_FLAG == 0)):
        PU_p = True
    if PU_p:
        _tmp1 = 'The structure sways unsteadily '
    else:
        _tmp1 = 'The structure slides '
    if NORTH_p:
        _tmp2 = 'north'
    else:
        _tmp2 = 'south'
    if PU_p:
        _tmp3 = 'The structure sways unsteadily '
    else:
        _tmp3 = 'The structure slides '
    if NORTH_p:
        _tmp4 = 'north'
    else:
        _tmp4 = 'south'
    TELL(_tmp3, _tmp4, ' and stops over another compass rose.', CR)
    ZG.MLOC = RM
    if ((RM == ZG.MRG) and (ZG.HERE == ZG.IN_MIRROR)):
        if PU_p:
            LOSE = True
        elif ((not ZG.MR1_FLAG) or (not ZG.MR2_FLAG)):
            LOSE = True
        elif (ZG.MIRROR_OPEN_FLAG or ZG.WOOD_OPEN_FLAG):
            LOSE = True
        if LOSE:
            if ZG.GUARDIANS_SEEN:
                ZG.JIGS_UP('Suddenly the Guardians realize someone is trying to sneak by them in\nthe structure. They awake and, in perfect unison, hammer the contents\nof the box (in other words you) to pulp. They then resume their posts,\nsatisfied.')
            else:
                ZG.JIGS_UP('Suddenly, two identical stone bludgeons come through the roof and\nhammer the contents of the box to pulp. That includes you.')
        return True
    return True

# zil: 3actions.zil:1286  <ROUTINE SHORT-POLE-F ()>
@ZG.routine('SHORT-POLE-F')
def SHORT_POLE_F():
    if VERB_p('RAISE', 'MOVE'):
        if (ZG.POLEUP_FLAG == 2):
            return TELL('The pole cannot be raised further.', CR)
        else:
            ZG.POLEUP_FLAG = 2
            return TELL('The pole is now slightly above the floor.', CR)
    elif ((VERB_p('PUT') and (ZG.PRSI == ZG.CHANNEL)) or VERB_p('PUSH', 'LOWER')):
        if (ZG.POLEUP_FLAG == 0):
            return TELL('The pole cannot be lowered further.', CR)
        elif ((ZG.MDIR % 180) == 0):
            TELL('The pole is lowered into the channel.', CR)
            ZG.POLEUP_FLAG = 0
            return True
        elif ((ZG.MDIR == 270) and (ZG.MLOC == ZG.MRB)):
            ZG.POLEUP_FLAG = 0
            return TELL('The pole is lowered into the stone hole.', CR)
        elif (ZG.POLEUP_FLAG == 1):
            return TELL('The pole is already resting on the floor.', CR)
        else:
            ZG.POLEUP_FLAG = 1
            return TELL('The pole now rests on the stone floor.', CR)
    else:
        return False

# zil: 3actions.zil:1312  <ROUTINE DUNGEON-MASTER-F ("OPTIONAL" (RARG <>))>
@ZG.routine('DUNGEON-MASTER-F')
def DUNGEON_MASTER_F(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_OBJDESC):
        return False
    elif (ZG.WINNER == ZG.DUNGEON_MASTER):
        if VERB_p('FOLLOW'):
            if IN_p(ZG.DUNGEON_MASTER, LOC(ZG.PLAYER)):
                ENABLE(ZG.QUEUE(ZG.I_FOLIN, -1))
                return TELL('The dungeon master answers, "I will follow."', CR)
            else:
                return TELL('The dungeon master\'s voice replies, "You must come here first!"', CR)
        elif VERB_p('STAY', 'WAIT'):
            ZG.QUEUE(ZG.I_FOLIN, 0)
            return TELL('The dungeon master answers, "I will stay."', CR)
        elif VERB_p('WALK'):
            if ((ZG.PRSO in ('SOUTH', 'ENTER')) and (ZG.HERE == ZG.NORTH_CORRIDOR)):
                return TELL('"I am not permitted to enter the prison cell."', CR)
            elif ((ZG.PRSO == 'NORTH') and (ZG.HERE == ZG.NORTH_CORRIDOR)):
                MOVE(ZG.DUNGEON_MASTER, ZG.PARAPET)
                ZG.HERE = ZG.PARAPET
                TELL('"Very well. I am at the parapet!"', CR)
                return ZG.QUEUE(ZG.I_FOLIN, 0)
            elif ((ZG.PRSO in ('NORTH', 'ENTER')) and (ZG.HERE == ZG.SOUTH_CORRIDOR)):
                return TELL('"I am not permitted to enter the prison cell."', CR)
            else:
                return TELL('"I prefer to stay where I am, thank you."', CR)
        elif (VERB_p('WALK-TO') and (ZG.PRSO == ZG.PARAPET_OBJ)):
            MOVE(ZG.DUNGEON_MASTER, ZG.PARAPET)
            ZG.HERE = ZG.PARAPET
            ZG.QUEUE(ZG.I_FOLIN, 0)
            return TELL('"Very well!"', CR)
        elif VERB_p('TAKE'):
            return TELL('"I will have no use for that, I am afraid."', CR)
        elif (VERB_p('OPEN') and (ZG.PRSO == ZG.DUNGEON_DOOR) and ZG.IN_DUNGEON):
            return TELL('The dungeon master appears angered. "Do not run from your quest: you are\nnearing the end!"', CR)
        elif VERB_p('PUSH', 'TURN', 'SPIN', 'FOLLOW', 'STAY', 'OPEN', 'CLOSE', 'WAIT', 'ATTACK', 'WALK-TO'):
            if VERB_p('STAY', 'FOLLOW', 'WAIT'):
                pass
            else:
                TELL('"If you wish," he replies.', CR)
            return False
        else:
            return TELL('"Do not be foolish! Consider the end of your quest!"', CR)
    elif VERB_p('EXAMINE'):
        return TELL('He is dressed simply in a hood and cloak, wearing an amulet and ring,\ncarrying an old book under one arm, and leaning on a wooden staff. A single\nkey, as if to a prison cell, hangs from his belt.', CR)
    elif VERB_p('ATTACK', 'MUNG'):
        return ZG.REALLY_DEAD('The dungeon master is taken by surprise. He dodges your blow, and\nwith a disappointed expression on his face, traces a complicated\npattern in the air with his staff. You crumble into dust.')
    elif VERB_p('TAKE'):
        return TELL('"I\'m willing to accompany you, but not ride in your pocket!"', CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.DUNGEON_MASTER)):
        return TELL('"I have no need for those things."', CR)
    else:
        return False

# zil: 3actions.zil:1385  <ROUTINE MASTER-F ()>
@ZG.routine('MASTER-F')
def MASTER_F():
    if (ZG.HERE in (ZG.PRISON_CELL, ZG.GOOD_CELL)):
        if ZG.HELLO_p(ZG.MASTER):
            return TELL("He can't hear you.", CR)
        else:
            return TELL('He is not here.', CR)
    elif VERB_p('TELL'):
        if ZG.IN_DUNGEON:
            ZG.PRSO = ZG.DUNGEON_MASTER
            return False
        else:
            ZG.P_CONT = False
            ZG.QUOTE_FLAG = False
            return TELL("The dungeon master isn't here.", CR)
    elif (VERB_p('GIVE', 'SGIVE') and IN_p(ZG.DUNGEON_MASTER, ZG.HERE)):
        return TELL('He politely refuses your offer.', CR)
    elif (VERB_p('EXAMINE') and (ZG.HERE in (ZG.CELL, ZG.NORTH_CORRIDOR)) and IN_p(ZG.DUNGEON_MASTER, ZG.PARAPET)):
        return TELL('The dungeon master is standing on the parapet.', CR)
    else:
        return TELL("The dungeon master isn't here.", CR)

# zil: 3actions.zil:1407  <GLOBAL DM-SEEN>
# GLOBAL (state) DM_SEEN = False  ->  ZilGlobal.py

# zil: 3actions.zil:1409  <ROUTINE BEHIND-DOOR-F ("OPTIONAL" (RARG <>))>
@ZG.routine('BEHIND-DOOR-F')
def BEHIND_DOOR_F(RARG=None):
    if RARG is None:
        RARG = False
    if ((RARG == ZG.M_ENTER) and (not ZG.DM_SEEN)):
        ENABLE(ZG.QUEUE(ZG.I_FOLIN, -1))
        ZG.DM_SEEN = True
        return ZG.DM_SEEN
    elif (RARG == ZG.M_LOOK):
        TELL('You are in a narrow north-south corridor. At the south end is a door\nand at the north end is an east-west corridor. The door is ')
        return ZG.DPR(ZG.DUNGEON_DOOR)
    else:
        return False

# zil: 3actions.zil:1419  <ROUTINE FRONT-DOOR-F ("OPTIONAL" (RARG <>))>
@ZG.routine('FRONT-DOOR-F')
def FRONT_DOOR_F(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_ENTER):
        return ZG.QUEUE(ZG.I_FOLIN, 0)
    elif (RARG == ZG.M_LOOK):
        ZG.LOOK_TO(False, ZG.MRD)
        TELL('The wooden door has a barred panel in it at about head height. The\ndoor itself is ')
        return ZG.DPR(ZG.DUNGEON_DOOR)
    else:
        return False

# zil: 3actions.zil:1429  <ROUTINE LOOK-LIKE-DM? ()>
@ZG.routine('LOOK-LIKE-DM?')
def LOOK_LIKE_DM_p():
    return (IN_p(ZG.CLOAK, ZG.WINNER) and IN_p(ZG.HOOD, ZG.WINNER) and IN_p(ZG.AMULET, ZG.WINNER) and IN_p(ZG.STAFF, ZG.WINNER) and IN_p(ZG.RING, ZG.WINNER) and IN_p(ZG.LORE_BOOK, ZG.WINNER) and IN_p(ZG.KEY, ZG.WINNER))

# zil: 3actions.zil:1438  <ROUTINE DUNGEON-PANEL-F ()>
@ZG.routine('DUNGEON-PANEL-F')
def DUNGEON_PANEL_F():
    if VERB_p('OPEN'):
        return TELL("You can't open the panel. It's set into the door.", CR)
    elif VERB_p('LOOK-INSIDE'):
        return TELL("There's not much to be seen.", CR)
    else:
        return False

# zil: 3actions.zil:1444  <ROUTINE DUNGEON-DOOR-F ()>
@ZG.routine('DUNGEON-DOOR-F')
def DUNGEON_DOOR_F():
    if VERB_p('OPEN', 'CLOSE'):
        return TELL("The door won't budge.", CR)
    elif (VERB_p('KNOCK') and (ZG.HERE == ZG.FRONT_DOOR)):
        TELL('The knock reverberates along the hall. For a time it seems there\nwill be no answer. Then you hear someone unlatching the small\npanel. Through the bars of the great door, the wrinkled\nface of an old man appears.')
        if ZG.INVIS:
            TELL(' He seems not to notice you\nfor a brief moment, then recovers.')
        if ZG.LOOK_LIKE_DM_p():
            TELL(' He starts to smile broadly and opens the\nmassive door without a sound. The old man motions and you feel yourself\ndrawn toward him.\n"I am the Master of the Dungeon!" he booms. "I have been watching\nyou closely during your journey through the Great Underground Empire.\nYes!," he says, as if recalling some almost forgotten time, "we have\nmet before, although I may not appear as I did then." You look\nclosely into his deeply lined face and see the faces of the old man by the\nsecret door, your "friend" at the cliff, and the hooded figure. "You have\nshown kindness to the old man, and compassion toward the hooded one. You\ndisplayed patience in the puzzle and trust at the cliff. You have\ndemonstrated strength, ingenuity, and valor. However, one final test awaits\nyou. Now! Command me as you will, and complete your quest!"\n', CR)
            ZG.GOTO(ZG.BEHIND_DOOR)
            ZG.IN_DUNGEON = True
            return ZG.IN_DUNGEON
        else:
            TELL(' He looks you over with a piercing gaze\nand then speaks gravely. "I have been waiting a long time for you, ')
            TELL(GET(ZG.DM_REASONS, ZG.DMISH()))
            TELL('\nI will remain here. When you feel you are ready, go to the\nsecret door and \'SAY "FROTZ OZMOO"\'! Go, now!" He wags his finger\nin warning. "Do not forget the double\nquotes!" A moment later, you find yourself in the Button Room.', CR)
            ZG.GOTO(ZG.MR_ANTE, False)
            return True
    else:
        return False

# zil: 3actions.zil:1484  <GLOBAL IN-DUNGEON>
# GLOBAL (state) IN_DUNGEON = False  ->  ZilGlobal.py

# zil: 3actions.zil:1486  <GLOBAL DM-REASONS>
# GLOBAL (state) DM_REASONS = TABLE('but I fear my waiting may be in vain.', 'but you have far to go before you are ready.', 'and you seem to have made slight some progress.', 'and your journey is half complete. Be of good cheer!', 'and you are nearing the end of your long quest!', 'and it will not be long before you are ready!', 'and you are nearly ready for the last test!')  ->  ZilGlobal.py

# zil: 3actions.zil:1495  <ROUTINE DMISH ("AUX" (CNT 0))>
@ZG.routine('DMISH')
def DMISH():
    CNT = 0
    if IN_p(ZG.AMULET, ZG.WINNER):
        CNT = (CNT + 1)
    if IN_p(ZG.LORE_BOOK, ZG.WINNER):
        CNT = (CNT + 1)
    if IN_p(ZG.HOOD, ZG.WINNER):
        CNT = (CNT + 1)
    if IN_p(ZG.CLOAK, ZG.WINNER):
        CNT = (CNT + 1)
    if IN_p(ZG.RING, ZG.WINNER):
        CNT = (CNT + 1)
    if IN_p(ZG.KEY, ZG.WINNER):
        CNT = (CNT + 1)
    if IN_p(ZG.STAFF, ZG.WINNER):
        CNT = (CNT + 1)
    return CNT

# zil: 3actions.zil:1505  <GLOBAL FOLFLAG>
# GLOBAL (state) FOLFLAG = True  ->  ZilGlobal.py

# ;"Following?"

# zil: 3actions.zil:1507  <ROUTINE I-FOLIN ()>
@ZG.routine('I-FOLIN')
def I_FOLIN():
    if IN_p(ZG.DUNGEON_MASTER, ZG.HERE):
        return False
    elif ((ZG.HERE in (ZG.PRISON_CELL, ZG.CELL)) and ZG.FOLFLAG):
        TELL("You notice that the dungeon master doesn't follow you.", CR)
        ZG.FOLFLAG = False
        return True
    elif (LOC(ZG.PLAYER) in (ZG.PRISON_CELL, ZG.CELL)):
        return False
    elif (not ZG.FOLFLAG):
        ZG.FOLFLAG = True
        TELL('The dungeon master rejoins you.', CR)
        MOVE(ZG.DUNGEON_MASTER, ZG.HERE)
        return True
    else:
        TELL('The dungeon master follows you.', CR)
        MOVE(ZG.DUNGEON_MASTER, ZG.HERE)
        return True

# ;"SUBTITLE
#  'The end had come, and this was it; he dropped her in the Flaming Pit.'"

# zil: 3actions.zil:1530  <GLOBAL LCELL>
# GLOBAL (state) LCELL = 1  ->  ZilGlobal.py

# ;"cell in slot"

# zil: 3actions.zil:1532  <GLOBAL PNUMB>
# GLOBAL (state) PNUMB = 1  ->  ZilGlobal.py

# ;"cell pointed at"

# zil: 3actions.zil:1534  <GLOBAL CELLOBJS>
# GLOBAL (state) CELLOBJS = ITABLE('NONE', (8 * 2 * 8))  ->  ZilGlobal.py

# zil: 3actions.zil:1536  <ROUTINE MOVE-CELL-OBJECTS ("AUX" TOP CNT F X)>
@ZG.routine('MOVE-CELL-OBJECTS')
def MOVE_CELL_OBJECTS():
    TOP = 0
    CNT = 0
    F = 0
    X = 0
    TOP = (8 * (ZG.LCELL - 1))
    CNT = (TOP + 1)
    F = FIRST_p(ZG.CELL)
    if F:
        while True:
            X = NEXT_p(F)
            if (not F):
                break
            else:
                PUT(ZG.CELLOBJS, CNT, F)
                REMOVE(F)
                CNT = (CNT + 1)
            if (not X):
                break
            else:
                F = X
    PUT(ZG.CELLOBJS, TOP, ((CNT - TOP) - 1))
    TOP = (8 * (ZG.PNUMB - 1))
    CNT = GET(ZG.CELLOBJS, TOP)
    while True:
        if (CNT == 0):
            return True
        else:
            TOP = (TOP + 1)
            MOVE(GET(ZG.CELLOBJS, TOP), ZG.CELL)
            CNT = (CNT - 1)

# zil: 3actions.zil:1560  <ROUTINE CELL-MOVE ("AUX" F X)>
@ZG.routine('CELL-MOVE')
def CELL_MOVE():
    F = 0
    X = 0
    FCLEAR(ZG.CELL_DOOR, Flag('OPENBIT'))
    FCLEAR(ZG.BRONZE_DOOR, Flag('OPENBIT'))
    if (not (ZG.PNUMB == ZG.LCELL)):
        if (ZG.PNUMB == 4):
            FCLEAR(ZG.BRONZE_DOOR, Flag('INVISIBLE'))
        else:
            FSET(ZG.BRONZE_DOOR, Flag('INVISIBLE'))
        if IN_p(ZG.PLAYER, ZG.CELL):
            ZG.WINNER = ZG.PLAYER
            FCLEAR(ZG.GOOD_CELL, Flag('TOUCHBIT'))
            FCLEAR(ZG.PRISON_CELL, Flag('TOUCHBIT'))
            if (ZG.LCELL == 4):
                FCLEAR(ZG.BRONZE_DOOR, Flag('INVISIBLE'))
                _tmp1 = ZG.GOOD_CELL
            else:
                _tmp1 = ZG.PRISON_CELL
            if (ZG.LCELL == 4):
                FCLEAR(ZG.BRONZE_DOOR, Flag('INVISIBLE'))
                _tmp2 = ZG.GOOD_CELL
            else:
                _tmp2 = ZG.PRISON_CELL
            ZG.GOTO(_tmp2)
            F = FIRST_p(ZG.CELL)
            if F:
                while True:
                    X = NEXT_p(F)
                    if (not F):
                        break
                    else:
                        MOVE(F, ZG.HERE)
                    if (not X):
                        break
                    else:
                        F = X
        else:
            ZG.MOVE_CELL_OBJECTS()
        ZG.LCELL = ZG.PNUMB
        return ZG.LCELL
    else:
        return False

# zil: 3actions.zil:1585  <ROUTINE PARAPET-F (RARG)>
@ZG.routine('PARAPET-F')
def PARAPET_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are standing behind a stone retaining wall which rims a parapet\noverlooking a fiery pit. It is difficult to see through the\nsmoke and flame which fills the pit, but it seems to be bottomless.\nThe pit itself is circular, about two hundred feet in diameter,\nand is fashioned of roughly hewn stone. The flames generate considerable\nheat, so it is rather uncomfortable standing here.\nThere is an object here which looks like a sundial. On it are an\nindicator arrow surrounding a large button. On the face of\nthe dial are numbers 1 through 8. The indicator points to the number ', N, ZG.PNUMB, '.', CR)
        return TELL('To the south, across a narrow corridor, is a prison cell.', CR)
    else:
        return False

# zil: 3actions.zil:1601  <ROUTINE DIAL ("AUX" N)>
@ZG.routine('DIAL')
def DIAL():
    N_l = 0
    if VERB_p('EXAMINE'):
        return TELL('The dial points to ', N, ZG.PNUMB, '.', CR)
    elif VERB_p('TURN'):
        if (ZG.PRSI == ZG.INTNUM):
            if ((ZG.P_NUMBER == 0) or (ZG.P_NUMBER > 8)):
                TELL('There is no such setting.', CR)
                return True
            ZG.PNUMB = ZG.P_NUMBER
            if (ZG.WINNER == ZG.PLAYER):
                TELL('The dial now points to ', N, ZG.PNUMB, '.', CR)
            return True
        elif (not ZG.PRSI):
            return TELL('You must specify what to set the dial to.', CR)
        else:
            return TELL('The dial face only contains numbers.', CR)
    elif VERB_p('SPIN'):
        ZG.PNUMB = RANDOM(8)
        if (ZG.WINNER == ZG.PLAYER):
            TELL('The dial spins and comes to a stop pointing at ', N, ZG.PNUMB, '.')
        return True
    else:
        return False

# zil: 3actions.zil:1625  <ROUTINE DIALBUTTON ("AUX" C)>
@ZG.routine('DIALBUTTON')
def DIALBUTTON():
    C_l = 0
    C_l = FSET_p(ZG.CELL_DOOR, Flag('OPENBIT'))
    FCLEAR(ZG.CELL, Flag('TOUCHBIT'))
    if VERB_p('PUSH'):
        if (ZG.WINNER == ZG.PLAYER):
            TELL('The button depresses with a slight click, and pops back.', CR)
        ZG.CELL_MOVE()
        if C_l:
            TELL('You notice that the cell door is now closed.', CR)
        return True
    else:
        return False

# zil: 3actions.zil:1637  <ROUTINE CELL-ROOM (RARG)>
@ZG.routine('CELL-ROOM')
def CELL_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a featureless prison cell. You can see ')
        if FSET_p(ZG.CELL_DOOR, Flag('OPENBIT')):
            TELL('an east-west\ncorridor outside the cell door. Your view also takes in the parapet and\na large, fiery pit.', CR)
        else:
            TELL('through the small window\nin the closed door the parapet, and, behind that,\nsmoke and flames rising from a fiery pit.', CR)
        if IN_p(ZG.DUNGEON_MASTER, ZG.PARAPET):
            TELL('The dungeon master is at the parapet, leaning on his\nstaff. His keen gaze is fixed on you and he looks tense,\nas if waiting for something to happen.', CR)
        if (ZG.LCELL == 4):
            TELL('Behind you, to the south, is a bronze door which is ')
            ZG.DPR(ZG.BRONZE_DOOR)
        return True
    else:
        return False

# zil: 3actions.zil:1660  <ROUTINE NCELL-ROOM (RARG)>
@ZG.routine('NCELL-ROOM')
def NCELL_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a bare prison cell. Its wooden door is securely fastened,\nand you can see only flames and smoke through its small window. On the\nsouth wall is a bronze door which seems to be ')
        return ZG.DPR(ZG.BRONZE_DOOR)
    else:
        return False

# zil: 3actions.zil:1668  <ROUTINE DPR (OBJ)>
@ZG.routine('DPR')
def DPR(OBJ_l):
    if FSET_p(OBJ_l, Flag('OPENBIT')):
        return TELL('open.', CR)
    else:
        return TELL('closed.', CR)

# zil: 3actions.zil:1672  <ROUTINE NORTH-CORRIDOR-F (RARG)>
@ZG.routine('NORTH-CORRIDOR-F')
def NORTH_CORRIDOR_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a wide east-west corridor which opens onto a northern\nparapet at its center. You can see flames and smoke as you peer\ntowards the parapet. The corridor turns south at either end, and in\nthe center of the south wall is a heavy wooden door with a small\nbarred window. The door is ')
        return ZG.DPR(ZG.CELL_DOOR)
    else:
        return False

# zil: 3actions.zil:1682  <ROUTINE SOUTH-CORRIDOR-F (RARG)>
@ZG.routine('SOUTH-CORRIDOR-F')
def SOUTH_CORRIDOR_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in an east-west corridor which turns north at its eastern\nand western ends. The walls are made of the finest marble. Another\nhall leads south at the center of the corridor.', CR)
        if (ZG.LCELL == 4):
            TELL('In the center of the north wall is a bronze door which is ')
            ZG.DPR(ZG.BRONZE_DOOR)
        return True
    else:
        return False

# zil: 3actions.zil:1694  <GLOBAL BRONZE-DOOR-LOCKED>
# GLOBAL (state) BRONZE_DOOR_LOCKED = True  ->  ZilGlobal.py

# zil: 3actions.zil:1696  <ROUTINE BRONZE-DOOR-F ()>
@ZG.routine('BRONZE-DOOR-F')
def BRONZE_DOOR_F():
    if (VERB_p('OPEN') and (not FSET_p(ZG.BRONZE_DOOR, Flag('OPENBIT'))) and (ZG.HERE == ZG.GOOD_CELL) and (not ZG.BRONZE_DOOR_LOCKED)):
        TELL('On the other side of the bronze door is a narrow passage which opens out\ninto a larger area.', CR)
        return FSET(ZG.BRONZE_DOOR, Flag('OPENBIT'))
    elif (VERB_p('OPEN') and ZG.BRONZE_DOOR_LOCKED):
        return TELL('The bronze door is locked.', CR)
    else:
        return False

# zil: 3actions.zil:1709  <ROUTINE LOCKED-DOOR-F ()>
@ZG.routine('LOCKED-DOOR-F')
def LOCKED_DOOR_F():
    if VERB_p('OPEN', 'UNLOCK'):
        return TELL('The door is securely fastened.', CR)
    else:
        return False

'========== The Ultimate Winnage =========='

# zil: 3actions.zil:1717  <ROUTINE NIRVANA-F (RARG)>
@ZG.routine('NIRVANA-F')
def NIRVANA_F(RARG):
    if (RARG == ZG.M_END):
        TELL('As you examine your new-found riches, the Dungeon Master\nmaterializes beside you, and says, "Now that you have solved all the\nmysteries of the Dungeon, it is time for you to assume your rightly earned\nplace in the scheme of things. Long have I waited for one capable of\nreleasing me from my burden!" He taps you lightly on the head with his\nstaff, mumbling a few well-chosen spells, and you feel yourself changing,\ngrowing older and more stooped. For a moment there are two identical mages\nstanding among the treasure, then your counterpart dissolves into a\nmist and disappears, a sardonic grin on his face.\n\nFor a moment you are relieved, safe in the knowledge that you have\nat last completed your quest in ZORK. You begin to feel the vast powers\nand lore at your command and thirst for an opportunity to use them.\n\n')
        return ZG.FINISH()
    else:
        return False

# zil: 3actions.zil:1737  <ROUTINE BRONZE-DOOR-EXIT ()>
@ZG.routine('BRONZE-DOOR-EXIT')
def BRONZE_DOOR_EXIT():
    if FSET_p(ZG.BRONZE_DOOR, Flag('INVISIBLE')):
        TELL("You can't go that way.", CR)
        return False
    elif FSET_p(ZG.BRONZE_DOOR, Flag('OPENBIT')):
        return ZG.CELL
    else:
        TELL('The bronze door is closed.', CR)
        return False

# ;<ROUTINE MASTER-F ()
# 	 <PERFORM ,PRSA ,DUNGEON-MASTER>
# 	 <RTRUE>>

# zil: 3actions.zil:1751  <GLOBAL OLD-MAN-GONE>
# GLOBAL (state) OLD_MAN_GONE = False  ->  ZilGlobal.py

# zil: 3actions.zil:1752  <GLOBAL OLD-MAN-FED>
# GLOBAL (state) OLD_MAN_FED = False  ->  ZilGlobal.py

# zil: 3actions.zil:1754  <GLOBAL SECRET-DOOR-DESC>
# GLOBAL (state) SECRET_DOOR_DESC = 'Beyond the secret door are dark, forbidding stairs leading down to\na passage below. Flickering torchlight illuminates the passage.'  ->  ZilGlobal.py

# zil: 3actions.zil:1758  <ROUTINE SECRET-DOOR-F ()>
@ZG.routine('SECRET-DOOR-F')
def SECRET_DOOR_F():
    if (VERB_p('OPEN') and (not FSET_p(ZG.SECRET_DOOR, Flag('OPENBIT')))):
        TELL('The massive stone door opens noiselessly. ', ZG.SECRET_DOOR_DESC, CR)
        return FSET(ZG.SECRET_DOOR, Flag('OPENBIT'))
    else:
        return False

# zil: 3actions.zil:1764  <ROUTINE MSTAIRS-F (RARG)>
@ZG.routine('MSTAIRS-F')
def MSTAIRS_F(RARG):
    if ((RARG == ZG.M_ENTER) and ZG.PROB(30) and (not ZG.OLD_MAN_FED) and (not ZG.OLD_MAN_GONE)):
        return MOVE(ZG.OLD_MAN, ZG.HERE)
    elif (RARG == ZG.M_LOOK):
        TELL('You are in a room with passages heading southwest and southeast. The\nnorth wall is ornately carved, filled with strange runes and writing in\nan unfamiliar language.', CR)
        if FSET_p(ZG.SECRET_DOOR, Flag('OPENBIT')):
            return TELL(ZG.SECRET_DOOR_DESC, CR)
        elif (not FSET_p(ZG.SECRET_DOOR, Flag('INVISIBLE'))):
            return TELL('The outline of a door is barely visible among the runes.', CR)
        else:
            return False
    else:
        return False

# zil: 3actions.zil:1781  <ROUTINE HELLO? (WHO)>
@ZG.routine('HELLO?')
def HELLO_p(WHO):
    if ((ZG.WINNER == WHO) or VERB_p('TELL', 'ANSWER', 'REPLY', 'SAY', 'HELLO', 'INCANT')):
        if VERB_p('TELL', 'ANSWER', 'SAY', 'INCANT', 'REPLY'):
            ZG.P_CONT = False
            ZG.QUOTE_FLAG = False
        return True
    else:
        return False

# zil: 3actions.zil:1789  <ROUTINE OLD-MAN-F ("OPTIONAL" (RARG <>))>
@ZG.routine('OLD-MAN-F')
def OLD_MAN_F(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_OBJDESC):
        if ZG.OLD_MAN_AWAKE:
            return TELL('There is an old man huddled in the corner, eyeing you cautiously.\nHe looks weak and tired.', CR)
        else:
            return TELL('An old and wizened man is huddled, asleep, in the corner. He is snoring\nloudly, and looks quite weak and frail.', CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.OLD_MAN)):
        if ZG.OLD_MAN_AWAKE:
            if (ZG.PRSO == ZG.WAYBREAD):
                REMOVE(ZG.WAYBREAD)
                TELL('He looks up at you and takes the waybread. Slowly, he eats the\nbread and pauses when he is finished. He starts to speak: "Perhaps what you\nseek is through there!" He points at the carved wall to the north, where you\nnow notice the bare outline of a secret door. When you turn back, the old\nman is gone!', CR)
                FCLEAR(ZG.SECRET_DOOR, Flag('INVISIBLE'))
                ZG.OLD_MAN_GONE = True
                return REMOVE(ZG.OLD_MAN)
            elif IN_p(ZG.WAYBREAD, ZG.WINNER):
                return TELL('He refuses your offer but motions with his arm to the waybread in your\nhand.', CR)
            else:
                return TELL('The old man refuses the ', D, ZG.PRSO, ' with a wave of his hand.', CR)
        else:
            return TELL('He is asleep!', CR)
    elif VERB_p('EXAMINE'):
        if ZG.OLD_MAN_AWAKE:
            return TELL('The old man is barely awake and appears to nod off every few moments.\nHe has bright eyes, which appear to see right through your body.', CR)
        else:
            return TELL('The man is very, very old and wizened. He has a long, stringy\nbeard and is snoring quite loudly.', CR)
    elif VERB_p('LISTEN'):
        if ZG.OLD_MAN_AWAKE:
            return TELL("He isn't talking.", CR)
        else:
            return TELL('He is snoring like a buzz saw.', CR)
    elif ZG.HELLO_p(ZG.OLD_MAN):
        if ZG.OLD_MAN_AWAKE:
            return TELL('He nods at you without seeming to have understood.', CR)
        else:
            return TELL('He is sleeping soundly and does not respond.', CR)
    elif VERB_p('SHAKE', 'ALARM'):
        TELL('The old man is roused to consciousness. He peers at you through eyes which\nappear much younger and stronger than his frail body and waits, as if expecting\nsomething to happen.', CR)
        ZG.OLD_MAN_AWAKE = True
        return ENABLE(ZG.QUEUE(ZG.I_OLD_MAN_SLEEPS, 3))
    elif VERB_p('ATTACK', 'MUNG'):
        TELL('The attack seems to have left the old man unharmed! You watch in awe as he\nrises to his feet and seems to tower above you. He peers down menacingly,\nthen sadly and wearily. "Not yet," he mourns, and vanishes in a puff of\nsmoke.', CR)
        ZG.OLD_MAN_GONE = True
        return REMOVE(ZG.OLD_MAN)
    else:
        return False

# zil: 3actions.zil:1857  <GLOBAL OLD-MAN-AWAKE>
# GLOBAL (state) OLD_MAN_AWAKE = False  ->  ZilGlobal.py

# zil: 3actions.zil:1859  <ROUTINE I-OLD-MAN-SLEEPS ()>
@ZG.routine('I-OLD-MAN-SLEEPS')
def I_OLD_MAN_SLEEPS():
    ZG.OLD_MAN_AWAKE = False
    if IN_p(ZG.OLD_MAN, ZG.HERE):
        return TELL('You notice that the old man has fallen asleep.', CR)
    else:
        return False

# zil: 3actions.zil:1864  <ROUTINE RUNES-F ()>
@ZG.routine('RUNES-F')
def RUNES_F():
    if VERB_p('EXAMINE', 'READ'):
        return TELL('The runes are in an ancient language. Some pictures among the runes depict\nflames, stone statues, and an old man.', CR)
    else:
        return False

# zil: 3actions.zil:1870  <ROUTINE T-BAR-F ()>
@ZG.routine('T-BAR-F')
def T_BAR_F():
    if VERB_p('TURN'):
        return TELL("You don't have enough leverage to turn the T-bar. You might be able\nto turn the whole structure, however.", CR)
    else:
        return False

# zil: 3actions.zil:1876  <ROUTINE FLAMING-PIT-F ()>
@ZG.routine('FLAMING-PIT-F')
def FLAMING_PIT_F():
    if VERB_p('EXAMINE'):
        return TELL('The flaming pit is a seemingly bottomless abyss filled with smoke and\nflame.', CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.FLAMING_PIT)):
        if (ZG.HERE in (ZG.PARAPET, ZG.NORTH_CORRIDOR)):
            if (ZG.PRSO == ZG.ME):
                return TELL('It would be a pity to end your life so near the end of your quest!', CR)
            else:
                TELL('You cast the ', D, ZG.PRSO, ' into the pit, where it is lost forever.', CR)
                return REMOVE(ZG.PRSO)
        else:
            return TELL("You're not close enough.", CR)
    else:
        return False

# zil: 3actions.zil:1892  <ROUTINE PARAPET-OBJ-F ()>
@ZG.routine('PARAPET-OBJ-F')
def PARAPET_OBJ_F():
    if VERB_p('EXAMINE'):
        if (ZG.HERE in (ZG.CELL, ZG.NORTH_CORRIDOR)):
            TELL('You can see the parapet and sundial from here.')
            if IN_p(ZG.DUNGEON_MASTER, ZG.PARAPET):
                TELL(' The dungeon master is there\nalso, leaning on his staff.')
            return CRLF()
        else:
            return ZG.V_LOOK()
    else:
        return False

# zil: 3actions.zil:1903  <ROUTINE ROSE-F ()>
@ZG.routine('ROSE-F')
def ROSE_F():
    if VERB_p('TURN', 'MOVE'):
        return TELL('The compass rose is made of stone and is imbedded in the ground.\nYou could not possibly turn it or move it.', CR)
    else:
        return False

# zil: 3actions.zil:1909  <ROUTINE CELL-DOOR-F ()>
@ZG.routine('CELL-DOOR-F')
def CELL_DOOR_F():
    if (VERB_p('PUT') and (ZG.PRSI == ZG.CELL_DOOR)):
        return TELL('You will have to enter the cell first.', CR)
    elif VERB_p('THROUGH'):
        if (ZG.HERE == ZG.CELL):
            return TELL('Look around.', CR)
        else:
            ZG.DO_WALK('SOUTH')
            return True
    else:
        return False

# zil: 3actions.zil:1919  <ROUTINE LORE-BOOK-F ()>
@ZG.routine('LORE-BOOK-F')
def LORE_BOOK_F():
    if (VERB_p('BURN') and (not IN_p(ZG.LORE_BOOK, ZG.WINNER))):
        TELL('The book is consumed in a dazzling display of color.', CR)
        REMOVE(ZG.PRSO)
        return True
    elif (ZG.IN_DUNGEON and VERB_p('OPEN', 'EXAMINE', 'READ')):
        return TELL('The book seems to will itself open to a specific page. It shows a picture of\neight small rooms located around a great circle of flame. All are identical\nsave one, which has a bronze door leading to a room bathed in golden light.\nA legend beneath the picture says "The Dungeon and Treasury of Zork."', CR)
    elif VERB_p('OPEN'):
        return TELL('The book can be perused but not left open.', CR)
    else:
        return False

# zil: 3actions.zil:1935  <ROUTINE CP-HOLE-F ()>
@ZG.routine('CP-HOLE-F')
def CP_HOLE_F():
    if VERB_p('THROUGH'):
        ZG.DO_WALK('DOWN')
        return True
    else:
        return False

# zil: 3actions.zil:1940  <ROUTINE TORCH-PSEUDO ()>
@ZG.routine('TORCH-PSEUDO')
def TORCH_PSEUDO():
    return TELL('The torches are out of reach.', CR)

# zil: 3actions.zil:1943  <ROUTINE WATER-FCN ("AUX" AV PI?)>
@ZG.routine('WATER-FCN')
def WATER_FCN():
    AV = 0
    PI_p = 0
    if VERB_p('SGIVE'):
        return False
    elif VERB_p('THROUGH'):
        ZG.PERFORM(SYMBOL('V?SWIM'), ZG.PRSO)
        return True
    elif VERB_p('FILL'):
        ZG.PRSA = SYMBOL('V?PUT')
        ZG.PRSI = ZG.PRSO
        ZG.PRSO = ZG.GLOBAL_WATER
        PI_p = False
    elif (ZG.PRSO == ZG.GLOBAL_WATER):
        PI_p = False
    elif ZG.PRSI:
        PI_p = True
    if PI_p:
        ZG.PRSI = ZG.GLOBAL_WATER
    else:
        ZG.PRSO = ZG.GLOBAL_WATER
    if (VERB_p('TAKE', 'PUT') and (not PI_p)):
        return TELL('The water slips through your fingers.', CR)
    elif PI_p:
        return TELL("You can't do that.", CR)
    elif VERB_p('DROP', 'GIVE', 'THROW'):
        return TELL("You don't have any water.", CR)
    else:
        return False

# zil: 3actions.zil:1966  <ROUTINE RANDOM-WALL ()>
@ZG.routine('RANDOM-WALL')
def RANDOM_WALL():
    if VERB_p('PUSH'):
        if (ZG.HERE == ZG.IN_MIRROR):
            return TELL('You should specify which panel you want to push.', CR)
        else:
            return TELL("You can't budge it; at least from here.", CR)
    else:
        return False

# ^/L: top-level atom (no effect)

# ;"special-cased routines"

# ;"put GO here, eventually"

# zil: 3actions.zil:1980  <ROUTINE V-DIAGNOSE ()>
@ZG.routine('V-DIAGNOSE')
def V_DIAGNOSE():
    return TELL(GET(ZG.DIAG, ZG.P_STRENGTH), CR)

# zil: 3actions.zil:1983  <GLOBAL DIAG>
# GLOBAL (state) DIAG = TABLE('You are dead.', 'You are very seriously wounded. One more wound would very likely do you in.', 'You are hurt quite badly. One major wound would probably kill you.', 'You have a few wounds, which do not seriously impair your strength.', 'You are wounded lightly. You have a good deal of strength in reserve.', 'You are in perfect health.')  ->  ZilGlobal.py

# zil: 3actions.zil:1991  <ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))>
@ZG.routine('JIGS-UP')
def JIGS_UP(DESC_l, PLAYER_p=None):
    if PLAYER_p is None:
        PLAYER_p = False
    ZG.SWORD_STATE = 0
    ZG.P_STRENGTH = 5
    ZG.S_STRENGTH = 5
    TELL(DESC_l, CR)
    if (not (ZG.YEAR == ZG.YEAR_PRESENT)):
        QUIT()
    if (not (ZG.ADVENTURER == ZG.WINNER)):
        TELL('\n\n    ****  The ', D, ZG.WINNER, ' has died  ****\n\n\n')
        REMOVE(ZG.WINNER)
        ZG.WINNER = ZG.ADVENTURER
        ZG.HERE = LOC(ZG.WINNER)
        return 2
    TELL('\n    ****  You have died  ****\n\n')
    if (ZG._set('DEATHS', (ZG.DEATHS + 1)) > 3):
        TELL('You feel yourself disembodied in a deep blackness. A voice from the void\nspeaks:  "I have waited a long age for you, my friend, but perhaps it has been\nanother that I have been seeking. Good night, oh worthy adventurer!" It is\nthe last you hear.', CR)
        QUIT()
    else:
        TELL('You find yourself deep within the earth in a barren prison cell.\nOutside the iron-barred window, you can see a great, fiery pit. Flames\nleap up and very nearly sear your flesh. After a while, footfalls can\nbe heard in the distance, then closer and closer.... The door swings\nopen, and in walks an old man.\n\nHe is dressed simply in a hood and cloak, wearing an amulet and ring,\ncarrying an old book under one arm, and leaning on a wooden staff. A single\nkey, as if to a massive prison cell, hangs from his belt.\n\nHe raises the staff toward you and you hear\nhim speak, as if in a dream: "I await you, though your journey be long\nand full of peril. Go then, and let me not wait long!" You feel some\ngreat power well up inside you and you fall to the floor. The next\nmoment, you are awakening, as if from a deep slumber.', CR)
    MOVE(ZG.CURRENT_LAMP, ZG.ZORK2_STAIR)
    if (IN_p(ZG.KEY, ZG.WINNER) and ((ZG.HERE in (ZG.DARK_1, ZG.DARK_2, ZG.KEY_ROOM)) or (ZG.HERE in (ZG.AQ_1, ZG.AQ_2)))):
        MOVE(ZG.KEY, ZG.KEY_ROOM)
    CRLF()
    ZG.GOTO(ZG.ZORK2_STAIR)
    ZG.P_CONT = False
    ZG.RANDOMIZE_OBJECTS()
    ZG.KILL_INTERRUPTS()
    return 2

# zil: 3actions.zil:2047  <ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)>
@ZG.routine('RANDOMIZE-OBJECTS')
def RANDOMIZE_OBJECTS():
    R = False
    F = 0
    N_l = 0
    L = 0
    N_l = FIRST_p(ZG.WINNER)
    while True:
        F = N_l
        if (not F):
            return True
        N_l = NEXT_p(F)
        MOVE(F, ZG.RANDOM_ELEMENT(ZG.DEAD_OBJ_LOCS))

# zil: 3actions.zil:2055  <GLOBAL DEAD-OBJ-LOCS>
# GLOBAL (state) DEAD_OBJ_LOCS = LTABLE(ZG.JUNCTION, ZG.CLEARING, ZG.DAMP_PASSAGE, ZG.CREEPY_CRAWL, ZG.TIGHT_SQUEEZE, ZG.FOGGY_ROOM, ZG.DEAD_END)  ->  ZilGlobal.py

# zil: 3actions.zil:2059  <ROUTINE KILL-INTERRUPTS ()>
@ZG.routine('KILL-INTERRUPTS')
def KILL_INTERRUPTS():
    ZG.DISABLE(ZG.INT(ZG.I_MAN_LEAVES))
    ZG.DISABLE(ZG.INT(ZG.I_MAN_RETURNS))
    ZG.DISABLE(ZG.INT(ZG.I_VIEW_SNAP))
    ZG.DISABLE(ZG.INT(ZG.I_FOLIN))
    return True

# zil: 3actions.zil:2066  <GLOBAL SCORE-MAX>
# GLOBAL (state) SCORE_MAX = 7  ->  ZilGlobal.py

# zil: 3actions.zil:2068  <ROUTINE V-SCORE ("OPTIONAL" (ASK? T))>
@ZG.routine('V-SCORE')
def V_SCORE(ASK_p=None):
    if ASK_p is None:
        ASK_p = True
    TELL('Your potential is ', N, ZG.SCORE)
    TELL(' of a possible ', N, ZG.SCORE_MAX, ', in ')
    TELL(N, ZG.MOVES)
    if (ZG.MOVES == 1):
        TELL(' move.')
    else:
        TELL(' moves.')
    CRLF()
    return ZG.SCORE

'old TM.ZIL'

'Incredibly bizarre Time Machine Problem'

# zil: 3actions.zil:2083  <OBJECT VOICES>
ZG.world.declare_object('VOICES', 'VOICES', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'DESC': 'voices',
    'SYNONYM': ('VOICE', 'VOICES', 'GUARDS', 'OFFICI'),
    'ADJECTIVE': 'ARMED',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.VOICES_F,
})

# zil: 3actions.zil:2091  <ROOM TIGHT-SQUEEZE>
ZG.world.declare_object('TIGHT_SQUEEZE', 'TIGHT-SQUEEZE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Tight Squeeze',
    'LDESC': 'This is a very low and narrow passage leading east to west.',
    'WEST': ('TO', ZG.CREEPY_CRAWL),
    'EAST': ('TO', ZG.ROCKY_ROOM),
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:2100  <ROOM ROCKY-ROOM>
ZG.world.declare_object('ROCKY_ROOM', 'ROCKY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Crystal Grotto',
    'LDESC': 'This is a chamber of breathtaking beauty. Mighty stalagmites form\ncrystalline-encrusted rock formations. Phosphorescent mosses, fed by\na trickle of water from above, make the crystals glow and sparkle with\nevery color of the rainbow. There is an opening to the west, and a\nman-made passage heads south.',
    'SOUTH': ('TO', ZG.WIDE_HALL),
    'WEST': ('TO', ZG.TIGHT_SQUEEZE),
    'GLOBAL': (ZG.MOSS, ZG.CRYSTALS),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
})

# zil: 3actions.zil:2114  <OBJECT CRYSTALS>
ZG.world.declare_object('CRYSTALS', 'CRYSTALS', lambda: {
    'LOC': ZG.ROCKY_ROOM,
    'DESC': 'rock structure',
    'SYNONYM': ('CRYSTAL', 'STALAG'),
    'FLAGS': 'NDESCBIT',
})

# zil: 3actions.zil:2120  <ROOM WIDE-HALL>
ZG.world.declare_object('WIDE_HALL', 'WIDE-HALL', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Royal Hall',
    'LDESC': 'This is the north end of a large hall with a vaulted ceiling. A long, tiled\nhallway leads north through a tall arch. Although the purpose of\nthis room is unclear, there is a large rendering of the Royal Seal of Lord\nDimwit Flathead carved on the wall.',
    'NORTH': ('TO', ZG.ROCKY_ROOM),
    'SOUTH': ('TO', ZG.MUSEUM_ANTE),
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:2132  <OBJECT ROYAL-SEAL>
ZG.world.declare_object('ROYAL_SEAL', 'ROYAL-SEAL', lambda: {
    'LOC': ZG.WIDE_HALL,
    'DESC': 'Royal Seal of Dimwit Flathead',
    'SYNONYM': ('SEAL', 'CARVIN', 'RENDER'),
    'ADJECTIVE': ('LARGE', 'ROYAL'),
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'TEXT': 'The Seal is vintage Flathead, with signs of excess nearly everywhere.\nIt shows a curiously flat-headed figure wearing a gaudy crown,\nsurrounded by the Crown Jewels of the Empire.',
})

# zil: 3actions.zil:2143  <ROOM MUSEUM-ANTE>
ZG.world.declare_object('MUSEUM_ANTE', 'MUSEUM-ANTE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Great Door',
    'NORTH': ('TO', ZG.WIDE_HALL),
    'EAST': ('TO', ZG.MUSEUM_ENTRANCE, 'IF', 'CLEFT_FLAG', 'ELSE', 'The great iron door is rusted shut.'),
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.MUSEUM_ANTE_F,
    'GLOBAL': (ZG.IRON_DOOR, ZG.CLEFT),
})

# zil: 3actions.zil:2153  <ROOM MUSEUM-ENTRANCE>
ZG.world.declare_object('MUSEUM_ENTRANCE', 'MUSEUM-ENTRANCE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Museum Entrance',
    'EAST': ('TO', ZG.JEWEL_ROOM, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'WEST': ('TO', ZG.MUSEUM_ANTE, 'IF', 'CLEFT_FLAG', 'ELSE', 'The iron door is rusted shut.'),
    'SOUTH': ('TO', ZG.CP_ANTE),
    'DOWN': ('TO', ZG.CP_ANTE),
    'NORTH': ('TO', ZG.TECH_MUSEUM, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.MUSEUM_ENTRANCE_F,
    'GLOBAL': (ZG.IRON_DOOR, ZG.JEWEL_DOOR, ZG.WOODEN_DOOR, ZG.STAIRS, ZG.CLEFT),
})

# zil: 3actions.zil:2165  <OBJECT CLEFT>
ZG.world.declare_object('CLEFT', 'CLEFT', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'cleft',
    'SYNONYM': 'CLEFT',
    'ACTION': ZG.CLEFT_F,
    'FLAGS': ('DOORBIT', 'OPENBIT', 'INVISIBLE'),
})

# zil: 3actions.zil:2172  <ROOM JEWEL-ROOM>
ZG.world.declare_object('JEWEL_ROOM', 'JEWEL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Jewel Room',
    'WEST': ('TO', ZG.MUSEUM_ENTRANCE, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.MUSEUM_ENTRANCE, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.JEWEL_ROOM_F,
    'GLOBAL': ZG.JEWEL_DOOR,
})

# zil: 3actions.zil:2181  <ROOM TECH-MUSEUM>
ZG.world.declare_object('TECH_MUSEUM', 'TECH-MUSEUM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Technology Museum',
    'SOUTH': ('TO', ZG.MUSEUM_ENTRANCE, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.MUSEUM_ENTRANCE, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.TECH_MUSEUM_F,
    'GLOBAL': ZG.WOODEN_DOOR,
})

# zil: 3actions.zil:2190  <ROOM MID-CP-ANTE>
ZG.world.declare_object('MID_CP_ANTE', 'MID-CP-ANTE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Royal Puzzle Entrance',
    'WEST': ('TO', ZG.MID_CP_OUT),
    'NORTH': ('TO', ZG.MID_MUSEUM_ENTRANCE),
    'UP': ('TO', ZG.MID_MUSEUM_ENTRANCE),
    'DOWN': ('PER', ZG.CPENTER),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.CPANT_ROOM,
    'GLOBAL': ZG.STAIRS,
})

# zil: 3actions.zil:2201  <ROOM MID-CP-OUT>
ZG.world.declare_object('MID_CP_OUT', 'MID-CP-OUT', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Side Room',
    'NORTH': ('TO', ZG.MID_CP_ANTE),
    'EAST': 'The steel door is closed.',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.CPOUT_ROOM,
    'GLOBAL': (ZG.CPDOOR, ZG.STAIRS),
})

# zil: 3actions.zil:2210  <ROOM MID-MUSEUM-ENTRANCE>
ZG.world.declare_object('MID_MUSEUM_ENTRANCE', 'MID-MUSEUM-ENTRANCE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Museum Entrance',
    'EAST': ('TO', ZG.MID_JEWEL_ROOM, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'WEST': 'The iron door is rusted shut.',
    'SOUTH': ('TO', ZG.MID_CP_ANTE),
    'DOWN': ('TO', ZG.MID_CP_ANTE),
    'NORTH': ('TO', ZG.MID_TECH_MUSEUM, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.MUSEUM_ENTRANCE_F,
    'GLOBAL': (ZG.IRON_DOOR, ZG.JEWEL_DOOR, ZG.WOODEN_DOOR, ZG.STAIRS),
})

# zil: 3actions.zil:2222  <ROOM MID-JEWEL-ROOM>
ZG.world.declare_object('MID_JEWEL_ROOM', 'MID-JEWEL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Jewel Room',
    'WEST': ('TO', ZG.MID_MUSEUM_ENTRANCE, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.MID_MUSEUM_ENTRANCE, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.JEWEL_ROOM_F,
    'GLOBAL': ZG.JEWEL_DOOR,
})

# zil: 3actions.zil:2231  <ROOM MID-TECH-MUSEUM>
ZG.world.declare_object('MID_TECH_MUSEUM', 'MID-TECH-MUSEUM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Technology Museum',
    'SOUTH': ('TO', ZG.MID_MUSEUM_ENTRANCE, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.MID_MUSEUM_ENTRANCE, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.TECH_MUSEUM_F,
    'GLOBAL': ZG.WOODEN_DOOR,
})

# zil: 3actions.zil:2240  <ROOM OLD-TECH-MUSEUM>
ZG.world.declare_object('OLD_TECH_MUSEUM', 'OLD-TECH-MUSEUM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Technology Museum',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.OLD_TECH_MUSEUM_F,
    'SOUTH': ('TO', ZG.OLD_MUSEUM_ENTRANCE, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.OLD_MUSEUM_ENTRANCE, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'GLOBAL': (ZG.WOODEN_DOOR, ZG.ROBOT),
})

# zil: 3actions.zil:2249  <ROOM OLD-JEWEL-ROOM>
ZG.world.declare_object('OLD_JEWEL_ROOM', 'OLD-JEWEL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Jewel Room',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.OLD_TECH_MUSEUM_F,
    'WEST': ('TO', ZG.OLD_MUSEUM_ENTRANCE, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.OLD_MUSEUM_ENTRANCE, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'GLOBAL': (ZG.JEWEL_DOOR, ZG.ROBOT),
})

# zil: 3actions.zil:2258  <ROOM OLD-MUSEUM-ENTRANCE>
ZG.world.declare_object('OLD_MUSEUM_ENTRANCE', 'OLD-MUSEUM-ENTRANCE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Museum Entrance',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.OLD_TECH_MUSEUM_F,
    'EAST': ('TO', ZG.OLD_JEWEL_ROOM, 'IF', 'JEWEL_DOOR', 'IS', 'OPEN'),
    'WEST': 'The guards locked the iron door behind them.',
    'NORTH': ('TO', ZG.OLD_TECH_MUSEUM, 'IF', 'WOODEN_DOOR', 'IS', 'OPEN'),
    'SOUTH': 'The stairs end blindly to the south.',
    'GLOBAL': (ZG.WOODEN_DOOR, ZG.JEWEL_DOOR, ZG.IRON_DOOR, ZG.ROBOT),
})

# zil: 3actions.zil:2269  <OBJECT TIME-MACHINE>
ZG.world.declare_object('TIME_MACHINE', 'TIME-MACHINE', lambda: {
    'LOC': ZG.TECH_MUSEUM,
    'DESC': 'gold machine',
    'SYNONYM': ('MACHINE', 'TEMPORIZER'),
    'ADJECTIVE': ('TIME', 'GOLD', 'GOLDEN'),
    'FLAGS': ('VEHBIT', 'OPENBIT', 'CONTBIT'),
    'CAPACITY': 100,
    'DESCFCN': ZG.TIME_MACHINE_F,
    'ACTION': ZG.TIME_MACHINE_F,
})

# zil: 3actions.zil:2279  <OBJECT PRESSURIZER>
ZG.world.declare_object('PRESSURIZER', 'PRESSURIZER', lambda: {
    'LOC': ZG.TECH_MUSEUM,
    'DESC': 'grey machine',
    'SYNONYM': ('MACHINE', 'DRYER', 'PRESSURIZER'),
    'ADJECTIVE': ('GRAY', 'GREY', 'WASHING'),
    'ACTION': ZG.MUSEUM_PIECES,
    'DESCFCN': ZG.MUSEUM_PIECES,
})

# zil: 3actions.zil:2287  <OBJECT SPINNER>
ZG.world.declare_object('SPINNER', 'SPINNER', lambda: {
    'LOC': ZG.TECH_MUSEUM,
    'DESC': 'black machine',
    'SYNONYM': ('MACHINE', 'PIPES', 'WIRES', 'MOTORS'),
    'ADJECTIVE': 'BLACK',
    'DESCFCN': ZG.MUSEUM_PIECES,
    'ACTION': ZG.MUSEUM_PIECES,
})

# zil: 3actions.zil:2295  <OBJECT TM-BUTTON>
ZG.world.declare_object('TM_BUTTON', 'TM-BUTTON', lambda: {
    'LOC': ZG.TIME_MACHINE,
    'DESC': 'button',
    'SYNONYM': 'BUTTON',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.TM_BUTTON_F,
})

# zil: 3actions.zil:2302  <OBJECT TM-HOLLOW>
ZG.world.declare_object('TM_HOLLOW', 'TM-HOLLOW', lambda: {
    'LOC': ZG.TIME_MACHINE,
    'DESC': 'seat',
    'SYNONYM': 'AREA',
    'ADJECTIVE': ('SMALL', 'HOLLOW'),
    'FLAGS': ('NDESCBIT', 'OPENBIT', 'CONTBIT'),
    'CAPACITY': 20,
    'ACTION': ZG.TM_HOLLOW_F,
})

# zil: 3actions.zil:2311  <ROUTINE TM-HOLLOW-F ()>
@ZG.routine('TM-HOLLOW-F')
def TM_HOLLOW_F():
    if (VERB_p('PUT') and (ZG.PRSI == ZG.TM_HOLLOW)):
        ZG.PERFORM(SYMBOL('V?PUT-UNDER'), ZG.PRSO, ZG.TM_SEAT)
        return True
    elif VERB_p('LOOK-INSIDE'):
        ZG.PERFORM(SYMBOL('V?LOOK-UNDER'), ZG.TM_SEAT)
        return True
    elif (ZG.PRSO == ZG.TM_HOLLOW):
        ZG.PERFORM(ZG.PRSA, ZG.TM_SEAT, ZG.PRSI)
        return True
    elif (ZG.PRSI == ZG.TM_HOLLOW):
        ZG.PERFORM(ZG.PRSA, ZG.PRSO, ZG.TM_SEAT)
        return True
    else:
        return False

# zil: 3actions.zil:2326  <OBJECT TM-SEAT>
ZG.world.declare_object('TM_SEAT', 'TM-SEAT', lambda: {
    'LOC': ZG.TIME_MACHINE,
    'DESC': 'seat',
    'SYNONYM': ('SEAT', 'CHAIR'),
    'FLAGS': ('NDESCBIT', 'OPENBIT', 'CONTBIT', 'SURFACEBIT'),
    'CAPACITY': 20,
    'ACTION': ZG.TM_SEAT_F,
})

# zil: 3actions.zil:2334  <OBJECT TM-DIAL>
ZG.world.declare_object('TM_DIAL', 'TM-DIAL', lambda: {
    'LOC': ZG.TIME_MACHINE,
    'DESC': 'dial',
    'SYNONYM': ('DIAL', 'CONSOLE', 'DISPLAY'),
    'FLAGS': ('NDESCBIT', 'TURNBIT'),
    'ACTION': ZG.TM_DIAL_F,
})

# zil: 3actions.zil:2341  <OBJECT IRON-DOOR>
ZG.world.declare_object('IRON_DOOR', 'IRON-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'iron door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': 'IRON',
    'FLAGS': ('DOORBIT', 'CONTBIT'),
    'ACTION': ZG.IRON_DOOR_F,
})

# zil: 3actions.zil:2349  <OBJECT JEWEL-DOOR>
ZG.world.declare_object('JEWEL_DOOR', 'JEWEL-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'stone door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('STONE', 'EAST'),
    'ACTION': ZG.JEWEL_DOOR_F,
    'FLAGS': ('DOORBIT', 'CONTBIT'),
})

# zil: 3actions.zil:2357  <OBJECT WOODEN-DOOR>
ZG.world.declare_object('WOODEN_DOOR', 'WOODEN-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'wooden door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('WOODEN', 'WOOD', 'NORTH'),
    'FLAGS': ('DOORBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.WOODEN_DOOR_F,
})

# zil: 3actions.zil:2365  <OBJECT SCEPTRE>
ZG.world.declare_object('SCEPTRE', 'SCEPTRE', lambda: {
    'LOC': ZG.PEDESTAL,
    'DESC': 'sceptre',
    'SYNONYM': ('SCEPTRE', 'JEWELS'),
    'ADJECTIVE': 'CROWN',
    'FLAGS': ('TAKEBIT', 'NDESCBIT', 'TRYTAKEBIT'),
    'SIZE': 30,
    'ACTION': ZG.CROWN_JEWELS_F,
})

# zil: 3actions.zil:2374  <OBJECT JEWELLED-KNIFE>
ZG.world.declare_object('JEWELLED_KNIFE', 'JEWELLED-KNIFE', lambda: {
    'LOC': ZG.PEDESTAL,
    'DESC': 'jewelled knife',
    'SYNONYM': ('KNIFE', 'JEWELS'),
    'ADJECTIVE': ('JEWELLED', 'CROWN'),
    'FLAGS': ('TAKEBIT', 'NDESCBIT', 'TRYTAKEBIT'),
    'SIZE': 20,
    'ACTION': ZG.CROWN_JEWELS_F,
})

# zil: 3actions.zil:2383  <OBJECT RING>
ZG.world.declare_object('RING', 'RING', lambda: {
    'LOC': ZG.PEDESTAL,
    'DESC': 'golden ring',
    'SYNONYM': ('RING', 'JEWELS'),
    'ADJECTIVE': ('GOLDEN', 'CROWN'),
    'FLAGS': ('TAKEBIT', 'NDESCBIT', 'TRYTAKEBIT', 'WEARBIT'),
    'SIZE': 5,
    'ACTION': ZG.CROWN_JEWELS_F,
})

# zil: 3actions.zil:2392  <OBJECT PEDESTAL>
ZG.world.declare_object('PEDESTAL', 'PEDESTAL', lambda: {
    'LOC': ZG.JEWEL_ROOM,
    'DESC': 'pedestal',
    'SYNONYM': 'PEDESTAL',
    'FLAGS': ('NDESCBIT', 'OPENBIT', 'CONTBIT', 'SURFACEBIT'),
    'CAPACITY': 50,
    'ACTION': ZG.PEDESTAL_F,
})

# zil: 3actions.zil:2400  <OBJECT CAGE>
ZG.world.declare_object('CAGE', 'CAGE', lambda: {
    'LOC': ZG.JEWEL_ROOM,
    'DESC': 'steel cage',
    'SYNONYM': 'CAGE',
    'ADJECTIVE': 'STEEL',
    'FLAGS': ('NDESCBIT', 'CONTBIT', 'OPENBIT', 'SURFACEBIT'),
    'CAPACITY': 5,
    'ACTION': ZG.CAGE_F,
})

# zil: 3actions.zil:2409  <OBJECT TECH-PLAQUE>
ZG.world.declare_object('TECH_PLAQUE', 'TECH-PLAQUE', lambda: {
    'LOC': ZG.TECH_MUSEUM,
    'DESC': 'plaque',
    'SYNONYM': ('PLAQUE', 'TEXT'),
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'ACTION': ZG.TECH_PLAQUE_F,
})

# zil: 3actions.zil:2416  <OBJECT PLAQUE>
ZG.world.declare_object('PLAQUE', 'PLAQUE', lambda: {
    'LOC': ZG.CAGE,
    'DESC': 'bronze plaque',
    'SYNONYM': ('PLAQUE', 'TEXT'),
    'ADJECTIVE': 'BRONZE',
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'ACTION': ZG.PLAQUE_F,
})

# ;"The present year using the GUE calendar."

# zil: 3actions.zil:2426  <GLOBAL MACHINE-DAMAGED>
# GLOBAL (state) MACHINE_DAMAGED = False  ->  ZilGlobal.py

# zil: 3actions.zil:2428  <GLOBAL YEAR>
# GLOBAL (state) YEAR = 948  ->  ZilGlobal.py

# zil: 3actions.zil:2430  <CONSTANT YEAR-BUILT>
# CONSTANT (const) YEAR_BUILT = 776  ->  ZilGlobal.py

# zil: 3actions.zil:2432  <CONSTANT YEAR-CAGED>
# CONSTANT (const) YEAR_CAGED = 777  ->  ZilGlobal.py

# zil: 3actions.zil:2434  <GLOBAL YEAR-CLOSED>
# GLOBAL (state) YEAR_CLOSED = 883  ->  ZilGlobal.py

# zil: 3actions.zil:2436  <CONSTANT REAL-YEAR-CLOSED>
# CONSTANT (const) REAL_YEAR_CLOSED = 883  ->  ZilGlobal.py

# zil: 3actions.zil:2438  <CONSTANT YEAR-PRESENT>
# CONSTANT (const) YEAR_PRESENT = 948  ->  ZilGlobal.py

# zil: 3actions.zil:2440  <ROUTINE IRON-DOOR-F ()>
@ZG.routine('IRON-DOOR-F')
def IRON_DOOR_F():
    if VERB_p('OPEN', 'UNLOCK', 'THROUGH'):
        if (ZG.YEAR < ZG.YEAR_PRESENT):
            return TELL('The iron door is locked from the outside.', CR)
        else:
            return TELL('The iron door is rusted shut and cannot be opened.', CR)
    else:
        return False

# zil: 3actions.zil:2449  <GLOBAL CLEFT-FLAG>
# GLOBAL (state) CLEFT_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:2451  <ROUTINE I-CLEFT ()>
@ZG.routine('I-CLEFT')
def I_CLEFT():
    if ((ZG.HERE in (ZG.ZORK_IV, ZG.ROOM_8, ZG.TIMBER_ROOM)) or (ZG.HERE in (ZG.LOWER_SHAFT, ZG.LADDER_BOTTOM, ZG.LADDER_TOP))):
        TELL('You feel a mild tremor from within the earth which passes quickly.', CR)
    else:
        TELL('There is a great tremor from within the earth. The entire dungeon shakes\nviolently and loose debris falls from above you.', CR)
    if (ZG.HERE == ZG.MUSEUM_ANTE):
        TELL('To the east, next to the great iron door, a cleft opens up,\nrevealing an open area behind!', CR)
    elif (ZG.HERE == ZG.AQ_VIEW):
        TELL('One of the giant pillars supporting the aqueduct collapses in a pile\nof smoke and rubble!', CR)
    elif (ZG.HERE in (ZG.AQ_2, ZG.AQ_3)):
        TELL('The channel beneath your feet trembles. Then the channel just to the ')
        if (ZG.HERE == ZG.AQ_2):
            TELL('north')
        else:
            TELL('south')
        TELL(' collapses and falls into the chasm!', CR)
    ZG.CLEFT_FLAG = True
    FCLEAR(ZG.CLEFT, Flag('INVISIBLE'))
    ZG.AQ_FLAG = False
    return True

# zil: 3actions.zil:2479  <ROUTINE CLEFT-F ()>
@ZG.routine('CLEFT-F')
def CLEFT_F():
    if (not (ZG.YEAR == ZG.YEAR_PRESENT)):
        return TELL('There is no cleft here.', CR)
    else:
        return False

# zil: 3actions.zil:2483  <ROUTINE MUSEUM-ANTE-F (RARG)>
@ZG.routine('MUSEUM-ANTE-F')
def MUSEUM_ANTE_F(RARG):
    if (RARG == ZG.M_LOOK):
        if ZG.CLEFT_FLAG:
            return TELL('This is the south end of a monumental hall, full of debris from\na recent earthquake. To the east is a great iron door, rusted shut. To its\nright, however, is a gaping cleft in the rock and behind, a cleared area.', CR)
        else:
            return TELL('You are in the southern half of a monumental hall. To the east lies\na tremendous iron door which appears to be rusted shut.', CR)
    else:
        return False

# zil: 3actions.zil:2495  <ROUTINE DDESC (STR1 DOOR STR2)>
@ZG.routine('DDESC')
def DDESC(STR1, DOOR, STR2):
    TELL(STR1)
    if FSET_p(DOOR, Flag('OPENBIT')):
        TELL('open')
    else:
        TELL('closed')
    return TELL(STR2, CR)

# zil: 3actions.zil:2502  <ROUTINE MUSEUM-ENTRANCE-F (RARG)>
@ZG.routine('MUSEUM-ENTRANCE-F')
def MUSEUM_ENTRANCE_F(RARG):
    if (RARG == ZG.M_LOOK):
        if FSET_p(ZG.CAGE, Flag('INVISIBLE')):
            return TELL('This is an entrance hall of some sort, judging by the grand iron\ndoor to the west, and the ornate stone and wooden doors which lead to the east\nand north, respectively. A few wide steps lead south.', CR)
        else:
            TELL('This is the entrance to the Royal Museum, the finest and grandest in the\nGreat Underground Empire. To the south, down a few steps, is the entrance\nto the Royal Puzzle and to the east, through a stone door, is the Royal\nJewel Collection. A wooden door to the north is ')
            if FSET_p(ZG.WOODEN_DOOR, Flag('OPENBIT')):
                _tmp1 = 'open'
            else:
                _tmp1 = 'closed'
            if FSET_p(ZG.WOODEN_DOOR, Flag('OPENBIT')):
                _tmp2 = 'open'
            else:
                _tmp2 = 'closed'
            TELL(_tmp2, '\nand leads to the Museum of Technology. ')
            if (ZG.YEAR == ZG.YEAR_PRESENT):
                return TELL('To the west is a great iron door, rusted shut. To its left, however, is a\ncleft in the rock providing an exit from the museum.', CR)
            elif (ZG.YEAR < ZG.YEAR_PRESENT):
                return TELL('To the west is a great iron door, rusted shut.', CR)
            else:
                return TELL('To the west is a great iron door, rusted shut. The cleft in the rock,\npresent when you started, has filled in with rubble.', CR)
    else:
        return False

# zil: 3actions.zil:2530  <GLOBAL TM-YEAR>
# GLOBAL (state) TM_YEAR = 948  ->  ZilGlobal.py

# zil: 3actions.zil:2532  <ROUTINE TIME-MACHINE-F ("OPTIONAL" (RARG <>))>
@ZG.routine('TIME-MACHINE-F')
def TIME_MACHINE_F(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_OBJDESC):
        return TELL('Directly in front of you is a large golden machine, which has a seat with a\nconsole in front. On the console is a single button and a dial connected to\na three-digit display which reads ', N, ZG.TM_YEAR, '. The machine is surprisingly shiny and shows few signs of age.', CR)
    elif (RARG == ZG.M_BEG):
        if VERB_p('MOVE'):
            return TELL('You might be able to move the machine by pushing it.', CR)
        elif (VERB_p('PUSH-TO') and (ZG.PRSO == ZG.TIME_MACHINE)):
            return TELL('That would be a good trick from inside it.', CR)
        elif VERB_p('WALK'):
            return TELL("You're not going anywhere in this heap.", CR)
        elif (VERB_p('TAKE', 'PUT', 'MOVE', 'PUSH', 'OPEN', 'CLOSE') and (not ZG.HELD_p(ZG.PRSO)) and (not IN_p(ZG.PRSO, ZG.TIME_MACHINE))):
            return TELL("You can't do that from inside the machine.", CR)
        else:
            return False
    elif (not RARG):
        if (VERB_p('PUT') and (ZG.PRSI == ZG.TIME_MACHINE)):
            return TELL("You can't put anything on or inside the machine itself.", CR)
        elif (ZG.PRSO == ZG.TIME_MACHINE):
            if VERB_p('OPEN', 'CLOSE'):
                return TELL('This is a machine, not a box.', CR)
            elif VERB_p('EXAMINE'):
                return TELL('The machine consists of a seat and a console containing one small button\nand a dial connected to a display which reads ', N, ZG.TM_YEAR, '.', CR)
            elif (VERB_p('BOARD') and FIRST_p(ZG.TM_SEAT)):
                return TELL('That will be somewhat uncomfortable!', CR)
            elif VERB_p('TAKE', 'RAISE'):
                return TELL('The machine must weigh hundreds of pounds and cannot be carried.', CR)
            elif VERB_p('PUSH', 'MOVE'):
                return TELL('You should specify in which direction to push the machine.', CR)
            elif VERB_p('PUSH-TO'):
                if (not (ZG.DO_WALK(ZG.P_DIRECTION) == ZG.M_FATAL)):
                    TELL('With some effort, you push the machine into the room with you.', CR)
                    if (ZG.HERE in (ZG.CP_ANTE, ZG.MID_CP_ANTE)):
                        TELL('However, the machine seems to have sustained some damage as a result\nof going over the stairs.', CR)
                        ZG.MACHINE_DAMAGED = True
                    elif (ZG.HERE == ZG.MUSEUM_ANTE):
                        TELL('Pushing the machine through the cleft seems to have damaged it.', CR)
                        ZG.MACHINE_DAMAGED = True
                    MOVE(ZG.TIME_MACHINE, ZG.HERE)
                return True
            else:
                return False
        else:
            return False
    else:
        return False

# zil: 3actions.zil:2593  <GLOBAL RING-CONCEALED>
# GLOBAL (state) RING_CONCEALED = False  ->  ZilGlobal.py

# zil: 3actions.zil:2595  <ROUTINE TM-SEAT-F ()>
@ZG.routine('TM-SEAT-F')
def TM_SEAT_F():
    if VERB_p('CLIMB-ON', 'BOARD'):
        ZG.PERFORM(SYMBOL('V?BOARD'), ZG.TIME_MACHINE)
        return True
    elif (VERB_p('PUT-UNDER', 'PUT-BEHIND') and (ZG.PRSI == ZG.TM_SEAT)):
        if (ZG.PRSO == ZG.RING):
            TELL('The ring is concealed underneath the seat.', CR)
            ZG.RING_CONCEALED = True
            return REMOVE(ZG.RING)
        else:
            return TELL("It's too big to hide under the seat.", CR)
    elif VERB_p('RUB'):
        return TELL("There's nothing odd about the feel of the seat.", CR)
    elif VERB_p('LOOK-UNDER', 'RAISE', 'MOVE'):
        if ZG.RING_CONCEALED:
            TELL('You find the ring under the seat and put it on your finger.', CR)
            MOVE(ZG.RING, ZG.WINNER)
            ZG.RING_CONCEALED = False
            return True
        else:
            return TELL('You notice a small hollow area under the seat.', CR)
    else:
        return False

# zil: 3actions.zil:2619  <ROUTINE TM-DIAL-F ()>
@ZG.routine('TM-DIAL-F')
def TM_DIAL_F():
    if VERB_p('EXAMINE'):
        return TELL('The dial is set to ', N, ZG.TM_YEAR, '.', CR)
    elif VERB_p('TURN'):
        if (ZG.PRSI == ZG.INTNUM):
            if (ZG.P_NUMBER > 999):
                return TELL("You can't set it beyond 999.", CR)
            else:
                ZG.TM_YEAR = ZG.P_NUMBER
                return TELL('The dial is set to ', N, ZG.TM_YEAR, '.', CR)
        elif (not ZG.PRSI):
            return TELL('You have to say what to turn it to!', CR)
        else:
            return TELL("You can't do that!", CR)
    else:
        return False

# zil: 3actions.zil:2633  <GLOBAL TM-POINT>
# GLOBAL (state) TM_POINT = False  ->  ZilGlobal.py

# zil: 3actions.zil:2635  <ROUTINE TM-BUTTON-F ()>
@ZG.routine('TM-BUTTON-F')
def TM_BUTTON_F():
    if VERB_p('PUSH'):
        if ((ZG.TM_YEAR == ZG.YEAR_BUILT) and (not ZG.TM_POINT)):
            ZG.SCORE = (ZG.SCORE + 1)
            ZG.TM_POINT = True
        if (ZG.MACHINE_DAMAGED or (not IN_p(ZG.WINNER, ZG.TIME_MACHINE))):
            return TELL('Nothing seems to have happened.', CR)
        elif (ZG.TM_YEAR < ZG.YEAR_BUILT):
            return ZG.REALLY_DEAD('You experience a period of disorientation. The area around you seems\nto be solidifying! Rock formations close in on you and you become\nengulfed in stone!')
        elif (ZG.YEAR == ZG.TM_YEAR):
            return TELL('Nothing seems to have happened.', CR)
        elif (ZG.TM_YEAR < ZG.YEAR_CLOSED):
            TELL('You experience a brief period of disorientation. When your vision returns, ')
            if (ZG.HERE in (ZG.MUSEUM_ENTRANCE, ZG.MID_MUSEUM_ENTRANCE, ZG.OLD_MUSEUM_ENTRANCE)):
                if (ZG.TM_YEAR == ZG.YEAR_CAGED):
                    TELL('you are surrounded by a number of heavily armed guards, the dress and\nspeech of which seem strange and unfamiliar. A commotion starts at a door\nto the east and a person with a flat head, wearing a gaudy crown and a purple\nrobe, bursts into the room.', CR)
                    return ZG.FLATHEAD_SENTENCE()
                else:
                    return ZG.GUARDS_KILL()
            elif (ZG.HERE in (ZG.JEWEL_ROOM, ZG.MID_JEWEL_ROOM, ZG.OLD_JEWEL_ROOM)):
                if (ZG.TM_YEAR == ZG.YEAR_CAGED):
                    TELL('you find yourself in the middle of some kind of ceremony, with a strange\nflat-headed man wearing royal vestments about to break a bottle on the bars\nof an iron cage containing magnificent jewels. He appears pleased\nby your presence. ')
                    return ZG.FLATHEAD_SENTENCE()
                elif (ZG.TM_YEAR > ZG.YEAR_CAGED):
                    return ZG.GUARDS_KILL()
                else:
                    TELL(ZG.SURROUNDINGS_CHANGED, CR)
                    return ZG.TGOTO(ZG.OLD_JEWEL_ROOM)
            elif (ZG.HERE in (ZG.TECH_MUSEUM, ZG.MID_TECH_MUSEUM, ZG.OLD_TECH_MUSEUM)):
                if (not (ZG.TM_YEAR == ZG.YEAR_BUILT)):
                    return ZG.GUARDS_KILL()
                else:
                    TELL(ZG.SURROUNDINGS_CHANGED, CR)
                    return ZG.TGOTO(ZG.OLD_TECH_MUSEUM)
            else:
                return False
        else:
            return ZG.HAPPY_NEW_YEAR()
    else:
        return False

# zil: 3actions.zil:2689  <GLOBAL SURROUNDINGS-CHANGED>
# GLOBAL (state) SURROUNDINGS_CHANGED = 'your surroundings appear to have changed. From outside the door\nyou hear the sounds of guards talking.'  ->  ZilGlobal.py

# zil: 3actions.zil:2693  <ROUTINE HAPPY-NEW-YEAR ()>
@ZG.routine('HAPPY-NEW-YEAR')
def HAPPY_NEW_YEAR():
    TELL('You experience a brief period of disorientation. When your vision returns,\nyour surroundings appear somewhat altered.', CR)
    if (ZG.HERE in (ZG.OLD_JEWEL_ROOM, ZG.MID_JEWEL_ROOM, ZG.JEWEL_ROOM)):
        if (ZG.TM_YEAR < ZG.YEAR_PRESENT):
            return ZG.TGOTO(ZG.MID_JEWEL_ROOM)
        else:
            return ZG.TGOTO(ZG.JEWEL_ROOM)
    elif (ZG.HERE in (ZG.OLD_TECH_MUSEUM, ZG.MID_TECH_MUSEUM, ZG.TECH_MUSEUM)):
        if (ZG.TM_YEAR < ZG.YEAR_PRESENT):
            return ZG.TGOTO(ZG.MID_TECH_MUSEUM)
        else:
            return ZG.TGOTO(ZG.TECH_MUSEUM)
    elif (ZG.TM_YEAR < ZG.YEAR_PRESENT):
        return ZG.TGOTO(ZG.MID_MUSEUM_ENTRANCE)
    else:
        return ZG.TGOTO(ZG.MUSEUM_ENTRANCE)

# zil: 3actions.zil:2707  <GLOBAL SNAP-LOC>
# GLOBAL (state) SNAP_LOC = False  ->  ZilGlobal.py

# zil: 3actions.zil:2709  <ROUTINE I-SNAP ()>
@ZG.routine('I-SNAP')
def I_SNAP():
    if (ZG.YEAR == ZG.YEAR_PRESENT):
        return False
    ZG.TM_YEAR = ZG.YEAR_PRESENT
    TELL('You start to feel light-headed and quickly become completely disoriented.\nWhen your head clears, you realize that your surroundings have changed.', CR)
    return ZG.TGOTO(ZG.SNAP_LOC, True)

# zil: 3actions.zil:2718  <ROUTINE MOVE-JEWELS ()>
@ZG.routine('MOVE-JEWELS')
def MOVE_JEWELS():
    if (ZG.TM_YEAR == ZG.YEAR_BUILT):
        MOVE(ZG.PEDESTAL, ZG.OLD_JEWEL_ROOM)
    elif (ZG.TM_YEAR < ZG.YEAR_PRESENT):
        MOVE(ZG.PEDESTAL, ZG.MID_JEWEL_ROOM)
    else:
        MOVE(ZG.PEDESTAL, ZG.JEWEL_ROOM)
    if ZG.RING_STOLEN:
        return True
    MOVE(ZG.SCEPTRE, ZG.PEDESTAL)
    FSET(ZG.SCEPTRE, Flag('NDESCBIT'))
    MOVE(ZG.JEWELLED_KNIFE, ZG.PEDESTAL)
    FSET(ZG.JEWELLED_KNIFE, Flag('NDESCBIT'))
    if (not ZG.RING_CONCEALED):
        MOVE(ZG.RING, ZG.PEDESTAL)
        return FSET(ZG.RING, Flag('NDESCBIT'))
    else:
        return False

# zil: 3actions.zil:2734  <ROUTINE TGOTO ("OPTIONAL" (RM <>) (SNAP <>))>
@ZG.routine('TGOTO')
def TGOTO(RM=None, SNAP=None):
    if RM is None:
        RM = False
    if SNAP is None:
        SNAP = False
    ZG.MOVES = (ZG.MOVES + 1)
    ZG.QUEUE(ZG.I_GUARDS_LEAVE, 0)
    ZG.INVIS = False
    if (ZG.YEAR > ZG.YEAR_BUILT):
        ZG.GUARDS_PRESENT = True
    if (ZG.YEAR == ZG.YEAR_PRESENT):
        ZG.SNAP_LOC = ZG.HERE
        ENABLE(ZG.QUEUE(ZG.I_SNAP, 40))
    if (ZG.TM_YEAR == ZG.YEAR_PRESENT):
        ZG.CLEFT_FLAG = True
    else:
        ZG.CLEFT_FLAG = False
    FCLEAR(ZG.JEWEL_DOOR, Flag('OPENBIT'))
    FCLEAR(ZG.WOODEN_DOOR, Flag('OPENBIT'))
    FCLEAR(ZG.IRON_DOOR, Flag('OPENBIT'))
    if (ZG.YEAR == ZG.YEAR_BUILT):
        if (ZG.RING_CONCEALED and IN_p(ZG.TIME_MACHINE, ZG.OLD_TECH_MUSEUM) and IN_p(ZG.SCEPTRE, ZG.PEDESTAL) and IN_p(ZG.JEWELLED_KNIFE, ZG.PEDESTAL)):
            ZG.RING_STOLEN = True
            FSET(ZG.CAGE, Flag('INVISIBLE'))
            REMOVE(ZG.SCEPTRE)
            REMOVE(ZG.JEWELLED_KNIFE)
        elif ((not IN_p(ZG.TIME_MACHINE, ZG.OLD_TECH_MUSEUM)) or ZG.RING_CONCEALED):
            ZG.CLUMSY_ROBBERY = True
            REMOVE(ZG.TIME_MACHINE)
        elif ((not IN_p(ZG.RING, ZG.PEDESTAL)) or (not IN_p(ZG.SCEPTRE, ZG.PEDESTAL)) or (not IN_p(ZG.JEWELLED_KNIFE, ZG.PEDESTAL))):
            ZG.MYSTERY = True
    if (ZG.TM_YEAR == ZG.YEAR_BUILT):
        ZG.MYSTERY = False
        ZG.CLUMSY_ROBBERY = False
    ZG.YEAR = ZG.TM_YEAR
    ZG.MOVE_TM_OBJECTS()
    ZG.MOVE_JEWELS()
    MOVE(ZG.WINNER, ZG.HERE)
    ZG.GOTO(RM, False)
    if (ZG.YEAR == ZG.YEAR_BUILT):
        MOVE(ZG.TIME_MACHINE, ZG.OLD_TECH_MUSEUM)
        MOVE(ZG.SPINNER, ZG.OLD_TECH_MUSEUM)
        MOVE(ZG.PRESSURIZER, ZG.OLD_TECH_MUSEUM)
        MOVE(ZG.TECH_PLAQUE, ZG.OLD_TECH_MUSEUM)
    elif (ZG.YEAR < ZG.YEAR_PRESENT):
        if (not ZG.CLUMSY_ROBBERY):
            MOVE(ZG.TIME_MACHINE, ZG.MID_TECH_MUSEUM)
        MOVE(ZG.SPINNER, ZG.MID_TECH_MUSEUM)
        MOVE(ZG.PRESSURIZER, ZG.MID_TECH_MUSEUM)
        MOVE(ZG.TECH_PLAQUE, ZG.MID_TECH_MUSEUM)
        MOVE(ZG.CAGE, ZG.MID_JEWEL_ROOM)
    else:
        MOVE(ZG.TIME_MACHINE, ZG.TECH_MUSEUM)
        MOVE(ZG.SPINNER, ZG.TECH_MUSEUM)
        MOVE(ZG.PRESSURIZER, ZG.TECH_MUSEUM)
        MOVE(ZG.TECH_PLAQUE, ZG.TECH_MUSEUM)
        MOVE(ZG.CAGE, ZG.JEWEL_ROOM)
    if (ZG.CLUMSY_ROBBERY or (not (ZG.HERE in (ZG.TECH_MUSEUM, ZG.MID_TECH_MUSEUM, ZG.OLD_TECH_MUSEUM)))):
        if (not SNAP):
            TELL('You notice that the golden machine has disappeared!', CR)
    else:
        MOVE(ZG.WINNER, ZG.TIME_MACHINE)
    if ZG.CLUMSY_ROBBERY:
        REMOVE(ZG.TIME_MACHINE)
    return True

# zil: 3actions.zil:2804  <ROUTINE MOVE-TM-OBJECTS ("AUX" F (MFLG <>) (WFLG <>) N)>
@ZG.routine('MOVE-TM-OBJECTS')
def MOVE_TM_OBJECTS():
    F = 0
    MFLG = False
    WFLG = False
    N_l = 0
    F = FIRST_p(ZG.TIME_MACHINE)
    if F:
        while True:
            if ((F in (ZG.TM_DIAL, ZG.TM_SEAT, ZG.TM_BUTTON)) or (F == ZG.PLAYER)):
                pass
            elif (not MFLG):
                MFLG = True
                TELL('You notice that everything in the machine is gone')
            N_l = NEXT_p(F)
            if (not (F in (ZG.TM_DIAL, ZG.TM_SEAT, ZG.TM_BUTTON))):
                MOVE(F, ZG.HERE)
            F = N_l
            if (not F):
                break
    F = FIRST_p(ZG.WINNER)
    if F:
        while True:
            if (not WFLG):
                WFLG = True
                if MFLG:
                    TELL(': come to mention\nit, everything you were holding has vanished too')
                else:
                    TELL('You notice that everything you were holding is gone')
            N_l = NEXT_p(F)
            MOVE(F, ZG.HERE)
            F = N_l
            if (not F):
                break
    if (MFLG or WFLG):
        return TELL('!', CR)
    else:
        return False

# zil: 3actions.zil:2835  <ROUTINE GUARDS-KILL ()>
@ZG.routine('GUARDS-KILL')
def GUARDS_KILL():
    TELL(ZG.PICK_ONE(ZG.GUARD_KILLERS), CR)
    return ZG.REALLY_DEAD(' ')

# zil: 3actions.zil:2839  <GLOBAL GUARD-KILLERS>
# GLOBAL (state) GUARD_KILLERS = LTABLE(0, 'you are surrounded by heavily armed guards who seem awed by your presence.\nOne, whose IQ might be 15, aims a strange waffle-like\ninstrument in your direction and all goes black.', 'you are confronted with many particularly stupid-looking\npeople dressed in peculiar uniforms and pointing waffle-like objects in\nyour direction. One twists his waffle and you slump\nto the ground, dead.', 'you see a row of military people who, if appearances do not\ndeceive, have the cumulative intelligence of an unripe grapefruit. One\nof them aims a waffle-shaped implement in your direction and you become numb\nand then paralyzed and then dead.')  ->  ZilGlobal.py

# zil: 3actions.zil:2852  <ROUTINE FLATHEAD-SENTENCE ()>
@ZG.routine('FLATHEAD-SENTENCE')
def FLATHEAD_SENTENCE():
    return ZG.REALLY_DEAD('He speaks loudly, nearly deafening the poor civil\nservant whose duty it is to see that his wishes are carried out. "Aha! A\nthief! Didn\'t I tell you that we needed more security! But, no! You all\nsaid my idea to build the museum under two miles of mountain and surrounded\nby five hundred feet of steel was impractical! Now, what to do with this ...\nintruder? I have it! We\'ll build a tremendous fortress on the highest mountain\npeak, with one narrow ladder stretching thousands of feet to the pinnacle.\nThere he will stay for the rest of his life!" His brow-beaten assistant\nhesitates. "Don\'t you think, Your Lordship, that your plan is a bit, well,\na bit much?" Flathead gives it a second\'s thought. "No, not really." he\nsays, and you are led away. A few years later, your prison is finished. You\nare taken there, and spend the rest of your life in misery.')

# zil: 3actions.zil:2866  <ROUTINE REALLY-DEAD (STR)>
@ZG.routine('REALLY-DEAD')
def REALLY_DEAD(STR):
    TELL(STR, '\n\n****  You have died  ****\n\n')
    return ZG.FINISH()

# zil: 3actions.zil:2874  <GLOBAL FLATHEAD-HEARD>
# GLOBAL (state) FLATHEAD_HEARD = False  ->  ZilGlobal.py

# zil: 3actions.zil:2876  <GLOBAL RING-STOLEN>
# GLOBAL (state) RING_STOLEN = False  ->  ZilGlobal.py

# zil: 3actions.zil:2877  <GLOBAL CLUMSY-ROBBERY>
# GLOBAL (state) CLUMSY_ROBBERY = False  ->  ZilGlobal.py

# zil: 3actions.zil:2878  <GLOBAL MYSTERY>
# GLOBAL (state) MYSTERY = False  ->  ZilGlobal.py

# zil: 3actions.zil:2880  <GLOBAL GUARDS-PRESENT>
# GLOBAL (state) GUARDS_PRESENT = True  ->  ZilGlobal.py

# zil: 3actions.zil:2882  <ROUTINE HEAR-FLATHEAD ()>
@ZG.routine('HEAR-FLATHEAD')
def HEAR_FLATHEAD():
    ZG.FLATHEAD_HEARD = True
    return TELL('One particularly loud and grating voice can be heard above the\nothers outside the room. "Very nice! Very nice! Not enough security, but\nvery nice! Now, Lord Feepness, pay attention! I\'ve been thinking that what\nwe need is a dam, a tremendous dam to control the Frigid River, with\nthousands of gates. We shall call it ... Flood Control Dam #2. No, not\nquite right. Aha! Flood Control Dam #3." "Pardon me, my Lord, but wouldn\'t\nthat be just a tad excessive?" "Nonsense! Now, let me tell you my idea for\nhollowing out volcanoes..." With that, the voices trail out nothingness.', CR)

# zil: 3actions.zil:2894  <ROUTINE OLD-TECH-MUSEUM-F (RARG)>
@ZG.routine('OLD-TECH-MUSEUM-F')
def OLD_TECH_MUSEUM_F(RARG):
    if ((RARG == ZG.M_LOOK) and (ZG.HERE == ZG.OLD_JEWEL_ROOM)):
        TELL('You are in a high-ceilinged chamber, in the center of which\nis a pedestal which ')
        if (not ZG.RING_STOLEN):
            TELL('is the intended home of the Crown\nJewels of the Great Underground Empire: a jewelled knife, a golden ring, and\nthe royal sceptre.')
            if ((not IN_p(ZG.SCEPTRE, ZG.PEDESTAL)) or (not IN_p(ZG.RING, ZG.PEDESTAL)) or (not IN_p(ZG.JEWELLED_KNIFE, ZG.PEDESTAL))):
                TELL(' Not all of the jewels are in place, however.')
        else:
            TELL('is bare.')
        TELL('\nThe room is, by appearances, unfinished.', CR)
        if ZG.GUARDS_PRESENT:
            TELL(ZG.HEAR_VOICES, CR)
        return True
    elif (RARG == ZG.M_LOOK):
        if (ZG.HERE == ZG.OLD_TECH_MUSEUM):
            TELL('You are in a large, unfinished room, probably intended to be a\npart of the Royal Museum.', CR)
        else:
            TELL('This appears to be an unfinished entranceway to the Royal Museum. There are\ndoors to the east and north, and a blind stairway to the south. A heavy iron\ndoor to the west is closed and locked.', CR)
        if ZG.GUARDS_PRESENT:
            TELL(ZG.HEAR_VOICES, CR)
        return True
    elif ((RARG == ZG.M_END) and (not ZG.FLATHEAD_HEARD) and ZG.GUARDS_PRESENT and ZG.PROB(6)):
        return ZG.HEAR_FLATHEAD()
    elif ((RARG == ZG.M_ENTER) and ZG.GUARDS_PRESENT):
        return ENABLE(ZG.QUEUE(ZG.I_GUARDS_LEAVE, (3 + RANDOM(12))))
    elif ((RARG == ZG.M_BEG) and VERB_p('OPEN') and (ZG.PRSO in (ZG.WOODEN_DOOR, ZG.JEWEL_DOOR)) and ZG.GUARDS_PRESENT):
        return TELL('You open the door ever so slightly and see dozens of armed officials.\nYou shut the door quickly, realizing that you would be killed\nin an instant if you left the room.', CR)
    elif ((RARG == ZG.M_BEG) and ZG.GUARDS_PRESENT and ZG.PROB(3)):
        return ZG.GUARD_CAUGHT()
    else:
        return False

# zil: 3actions.zil:2945  <GLOBAL HEAR-VOICES>
# GLOBAL (state) HEAR_VOICES = 'Through the door you can hear voices which, from their\nsound, belong to military or police personnel.'  ->  ZilGlobal.py

# zil: 3actions.zil:2949  <ROUTINE I-GUARDS-LEAVE ()>
@ZG.routine('I-GUARDS-LEAVE')
def I_GUARDS_LEAVE():
    ZG.GUARDS_PRESENT = False
    return TELL('You hear, from outside the door, guards marching away, their voices fading.\nAfter a few moments, a booming crash signals the close of what must be a\ntremendous door. Then there is silence.', CR)

# zil: 3actions.zil:2956  <ROUTINE GUARD-CAUGHT ()>
@ZG.routine('GUARD-CAUGHT')
def GUARD_CAUGHT():
    return ZG.REALLY_DEAD('A particularly vicious-looking guard enters the room and sees you.\nHe grinds his teeth unpleasantly, pulls a waffle out of his\ngarment, and vaporizes you with a flick of his finger.')

# zil: 3actions.zil:2962  <OBJECT ROBOT>
ZG.world.declare_object('ROBOT', 'ROBOT', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'robot',
    'SYNONYM': ('ROBOT', 'DEVICE'),
    'ACTION': ZG.ROBOT_F,
})

# zil: 3actions.zil:2968  <ROUTINE ROBOT-F ()>
@ZG.routine('ROBOT-F')
def ROBOT_F():
    if VERB_p('FOLLOW'):
        return TELL('It moved quickly and left the door closed.', CR)
    else:
        return TELL('There is no robot here.', CR)

# zil: 3actions.zil:2973  <ROUTINE JEWEL-ROOM-F (RARG)>
@ZG.routine('JEWEL-ROOM-F')
def JEWEL_ROOM_F(RARG):
    if ((RARG == ZG.M_END) and IN_p(ZG.TIME_MACHINE, ZG.HERE) and ZG.PROB(4)):
        TELL('An odd robot-like device glides in, dusting the floor as it moves. Its\nhead gyrates briefly as it scans the machine. "Shame. Shame,"\nit says, rather tinnily. "Someone has been tampering with the machines\nagain." Six beady mechanical eyes focus on you as the robot picks up the\ngold machine. "Hands off, adventurer!" it says as it leaves the\nroom, closing the door behind it.', CR)
        FCLEAR(ZG.JEWEL_DOOR, Flag('OPENBIT'))
        FCLEAR(ZG.WOODEN_DOOR, Flag('OPENBIT'))
        return MOVE(ZG.TIME_MACHINE, ZG.TECH_MUSEUM)
    elif (RARG == ZG.M_LOOK):
        TELL('You are in a high-ceilinged chamber')
        if (not FSET_p(ZG.CAGE, Flag('INVISIBLE'))):
            return TELL(' in the middle of which\nsits a tall, round steel cage, which is securely locked. In the\nmiddle of the cage is a pedestal on which sit the Crown Jewels\nof the Great Underground Empire: a sceptre, a jewelled knife, and a golden\nring. A small bronze plaque, now tarnished, is on the cage.', CR)
        else:
            return TELL(' in the middle of which is a bare\npedestal. The room is unfinished with no\nindication of its purpose. A small plaque is fastened to a wall.', CR)
    else:
        return False

# ;"You can take the jewels in YEAR-BUILT; otherwise, it is enclosed.
#   If you take it, YEAR-CLOSED is updated to YEAR-CAGED (history changes)"

# zil: 3actions.zil:3004  <ROUTINE CROWN-JEWELS-F ()>
@ZG.routine('CROWN-JEWELS-F')
def CROWN_JEWELS_F():
    if VERB_p('TAKE'):
        if ZG.HELD_p(ZG.PRSO):
            return False
        elif ((ZG.YEAR == ZG.YEAR_BUILT) or FSET_p(ZG.CAGE, Flag('INVISIBLE'))):
            FCLEAR(ZG.PRSO, Flag('NDESCBIT'))
            return False
        else:
            return TELL('The jewels are inside a locked cage.', CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.PEDESTAL) and IN_p(ZG.PRSO, ZG.WINNER)):
        TELL('The ', D, ZG.PRSO, ' is now resting on the pedestal.', CR)
        MOVE(ZG.PRSO, ZG.PEDESTAL)
        FSET(ZG.PRSO, Flag('NDESCBIT'))
        return True
    elif (VERB_p('PUT') and (not ZG.HELD_p(ZG.PRSO))):
        return TELL("You don't have the ", D, ZG.PRSO, '.', CR)
    else:
        return False

# zil: 3actions.zil:3024  <ROUTINE TECH-MUSEUM-F (RARG)>
@ZG.routine('TECH-MUSEUM-F')
def TECH_MUSEUM_F(RARG):
    if (RARG == ZG.M_LOOK):
        if FSET_p(ZG.CAGE, Flag('INVISIBLE')):
            return ZG.DDESC('This is an exhibit of Empire technology. A wooden door to the\nsouth is ', ZG.WOODEN_DOOR, '.')
        else:
            return ZG.DDESC('This is a large hall which hosted the technological exhibits of the\nGreat Underground Empire. A door to the south is ', ZG.WOODEN_DOOR, '.')
    else:
        return False

# zil: 3actions.zil:3036  <ROUTINE PLAQUE-F ()>
@ZG.routine('PLAQUE-F')
def PLAQUE_F():
    if VERB_p('EXAMINE', 'READ'):
        if ZG.RING_STOLEN:
            TELL('The plaque explains that this room was to be the home of the Crown Jewels\nof the Empire. However, following the unexplained disappearance of a\npriceless ring during the final stages of construction, Lord Flathead\ndecided to place the remaining jewels in a safer location.\nInterestingly, he placed his most prized possesion, an incredibly gaudy\ncrown, in a locked safe in a volcano specifically hollowed out for that\npurpose.', CR)
            return True
        ZG.FIXED_FONT_ON()
        TELL('\n         Crown Jewels\n\n  Presented To The Royal Museum\n      By His Gracious Lord\n\n        DIMWIT FLATHEAD\n\n          Dedicated\n         * 777 GUE *')
        ZG.FIXED_FONT_OFF()
        if ZG.CLUMSY_ROBBERY:
            TELL(CR, CR, 'Underneath the plaque, in small lettering, is a description of a clumsy\nattempt to steal the jewels using a time machine from the Technological\nMuseum which the curators were surprised to discover was not a nonworking\nmodel. After the attempt, the machine was removed from the exhibit.')
        elif ZG.MYSTERY:
            TELL(CR, CR, 'Underneath the plaque, in small lettering, is a description of\na mysterious happening during the final stages of construction of\nthe Museum, in which some of the crown jewels were found displaced\nfrom their proper positions. Fortunately, nothing was missing.\nThe mystery was never solved and the museum was opened despite the objections\nof Lord Flathead that security was too lax.')
        CRLF()
        return True
    else:
        return False

# zil: 3actions.zil:3078  <ROUTINE WOODEN-DOOR-F ()>
@ZG.routine('WOODEN-DOOR-F')
def WOODEN_DOOR_F():
    if (VERB_p('LISTEN') and ZG.GUARDS_PRESENT):
        ZG.PERFORM(SYMBOL('V?LISTEN'), ZG.VOICES)
        return True
    elif (VERB_p('KNOCK') and ZG.GUARDS_PRESENT):
        return TELL('You realize that calling attention to yourself would be fatal.', CR)
    else:
        return False

# zil: 3actions.zil:3086  <ROUTINE JEWEL-DOOR-F ()>
@ZG.routine('JEWEL-DOOR-F')
def JEWEL_DOOR_F():
    if (VERB_p('KNOCK') and ZG.GUARDS_PRESENT):
        ZG.PERFORM(SYMBOL('V?KNOCK'), ZG.WOODEN_DOOR)
        return True
    elif VERB_p('OPEN', 'UNLOCK'):
        if FSET_p(ZG.JEWEL_DOOR, Flag('OPENBIT')):
            return TELL('It is already open.', CR)
        elif ((ZG.YEAR == ZG.YEAR_BUILT) and (ZG.HERE == ZG.OLD_MUSEUM_ENTRANCE)):
            return TELL('The door is locked, probably by the guards on their way out.', CR)
        else:
            TELL('The door is now open.', CR)
            return FSET(ZG.JEWEL_DOOR, Flag('OPENBIT'))
    else:
        return False

# zil: 3actions.zil:3102  <ROUTINE CAGE-F ()>
@ZG.routine('CAGE-F')
def CAGE_F():
    if VERB_p('OPEN'):
        return TELL('The cage is locked.', CR)
    elif VERB_p('CLOSE'):
        return TELL('The cage is already closed.', CR)
    else:
        return False

# zil: 3actions.zil:3106  <ROUTINE VOICES-F ()>
@ZG.routine('VOICES-F')
def VOICES_F():
    if (ZG.GUARDS_PRESENT and (ZG.YEAR == ZG.YEAR_BUILT)):
        TELL('The voices are muffled by the door which (fortunately for you) separates\nyou. They seem to be in heated debate on the topic of\n')
        return TELL(ZG.PICK_ONE(ZG.BLATHER), '.', CR)
    else:
        return TELL('Are you hearing things now?', CR)

# zil: 3actions.zil:3115  <GLOBAL BLATHER>
# GLOBAL (state) BLATHER = LTABLE(0, 'wage scales for guards', 'the excessive nature of the Royal Government', 'the soon to be constructed Royal Puzzle', 'the proper way to execute trespassers', 'torturing thieves', 'the banishment of the Wizard of Frobozz')  ->  ZilGlobal.py

# zil: 3actions.zil:3124  <ROUTINE MUSEUM-PIECES ("OPTIONAL" (RARG <>))>
@ZG.routine('MUSEUM-PIECES')
def MUSEUM_PIECES(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_OBJDESC):
        if (ZG.DESC_OBJECT == ZG.SPINNER):
            return True
        TELL('A strange grey machine, shaped somewhat like a clothes dryer, is on one side\nof the room. On the other side of the hall is a powerful-looking black\nmachine, a tight tangle of wires, pipes, and motors.\nA plaque is mounted near the door.')
        if (ZG.YEAR < ZG.YEAR_CLOSED):
            return TELL(' The grey machine, it turns out, is a Frobozz\nMagic Pressurizer, used in the coal mines of the Empire. The black machine is\na Frobozz Magic Room Spinner. The golden machine is referred to as a\nTemporizer. All are nonworking models donated by Frobozzco president John\nD. Flathead.', CR)
        else:
            return TELL(' The writing is faded, however, and cannot be\nmade out clearly. The two machines seem to be in bad shape, rusting in many\nspots.', CR)
    elif VERB_p('TAKE', 'MOVE'):
        return TELL("It's massive and cannot even be moved.", CR)
    elif VERB_p('PUSH', 'PUSH-TO'):
        return TELL("It's too heavy to be pushed.", CR)
    elif VERB_p('MUNG'):
        return TELL('It seems quite indestructible.', CR)
    elif (VERB_p('PUT') and (ZG.PRSI in (ZG.SPINNER, ZG.PRESSURIZER))):
        return TELL("There's no good place to put anything there.", CR)
    else:
        return False

# zil: 3actions.zil:3154  <ROUTINE TECH-PLAQUE-F ()>
@ZG.routine('TECH-PLAQUE-F')
def TECH_PLAQUE_F():
    if VERB_p('TAKE'):
        return TELL("It's bolted to the wall.", CR)
    elif VERB_p('EXAMINE', 'READ'):
        if (ZG.YEAR < ZG.YEAR_CLOSED):
            return TELL('The plaque merely identifies the machines and names their donor. They are\nnonworking models of existing state-of-the-art machinery.', CR)
        else:
            return TELL('The words cannot be made out.', CR)
    else:
        return False

# zil: 3actions.zil:3164  <ROUTINE PEDESTAL-F ()>
@ZG.routine('PEDESTAL-F')
def PEDESTAL_F():
    if VERB_p('EXAMINE', 'LOOK-ON'):
        if FIRST_p(ZG.PEDESTAL):
            return TELL('The Royal Jewels are on the pedestal.', CR)
        else:
            return False
    elif (VERB_p('PUT', 'PUT-ON', 'TAKE') and (not FSET_p(ZG.CAGE, Flag('INVISIBLE')))):
        return TELL("You can't reach it through the cage.", CR)
    else:
        return False

'old SHADOW.ZIL'

# zil: 3actions.zil:3176  <ROOM CREEPY-CRAWL>
ZG.world.declare_object('CREEPY_CRAWL', 'CREEPY-CRAWL', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Creepy Crawl',
    'LDESC': 'You are in a dark and quite creepy crawlway with passages leaving to the\nnorth, east, south, and southwest.',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.JUNCTION),
    'SOUTH': ('TO', ZG.FOGGY_ROOM),
    'SW': ('TO', ZG.SHADOW_1),
    'EAST': ('TO', ZG.TIGHT_SQUEEZE),
    'ACTION': ZG.CREEPY_CRAWL_F,
})

# zil: 3actions.zil:3189  <ROOM SHADOW-1>
ZG.world.declare_object('SHADOW_1', 'SHADOW-1', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are at the eastern end of a dark, featureless landscape of shallow\nhills. Paths to the east and southeast reenter the rock.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'NE': 'Towering walls of rock bar your way.',
    'NORTH': 'Towering walls of rock bar your way.',
    'SOUTH': ('TO', ZG.SHADOW_5),
    'EAST': ('TO', ZG.CREEPY_CRAWL),
    'NW': ('TO', ZG.SHADOW_2),
    'WEST': ('TO', ZG.SHADOW_3),
    'SW': ('TO', ZG.SHADOW_4),
    'SE': ('TO', ZG.FOGGY_ROOM),
})

# zil: 3actions.zil:3206  <ROOM SHADOW-2>
ZG.world.declare_object('SHADOW_2', 'SHADOW-2', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are in a shadowy land of low, rolling hills stretching out to the west\nand south. The land is bordered to the north by a massive stone wall.\nAncient and weathered, the wall has crumbled enough at one point to permit\npassage.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'NE': 'A stone wall blocks the way.',
    'NORTH': ('TO', ZG.CLEARING),
    'NW': 'A stone wall blocks the way.',
    'SE': ('TO', ZG.SHADOW_1),
    'SW': ('TO', ZG.SHADOW_7),
    'SOUTH': ('TO', ZG.SHADOW_3),
    'WEST': ('TO', ZG.SHADOW_8),
    'EAST': ('TO', ZG.SHADOW_1),
    'GLOBAL': (ZG.RUBBLE, ZG.STONE_WALL),
})

# zil: 3actions.zil:3226  <ROOM SHADOW-3>
ZG.world.declare_object('SHADOW_3', 'SHADOW-3', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are in a dark and shadowy land. All around you are gentle hills and\neerie shadows. Far above, shrouded in mist, you can barely make out the\nceiling of the enormous cavern that spans this entire land.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'PSEUDO': ('MIST', ZG.MIST_PSEUDO),
    'NW': ('TO', ZG.SHADOW_8),
    'NE': ('TO', ZG.SHADOW_1),
    'SE': ('TO', ZG.SHADOW_1),
    'SW': ('TO', ZG.SHADOW_6),
    'NORTH': ('TO', ZG.SHADOW_2),
    'SOUTH': ('TO', ZG.SHADOW_4),
    'WEST': ('TO', ZG.SHADOW_7),
    'EAST': ('TO', ZG.SHADOW_1),
})

# zil: 3actions.zil:3245  <ROOM SHADOW-4>
ZG.world.declare_object('SHADOW_4', 'SHADOW-4', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are in an ominously dark land of rolling hills. The ground becomes\nsofter to the south.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'NORTH': ('TO', ZG.SHADOW_3),
    'EAST': ('TO', ZG.SHADOW_1),
    'NE': ('TO', ZG.SHADOW_1),
    'SE': ('TO', ZG.SHADOW_5),
    'SOUTH': ('TO', ZG.SHADOW_5),
    'SW': 'The ground becomes too soft to walk on in that direction.',
    'WEST': ('TO', ZG.SHADOW_6),
    'NW': ('TO', ZG.SHADOW_7),
})

# zil: 3actions.zil:3262  <ROOM SHADOW-5>
ZG.world.declare_object('SHADOW_5', 'SHADOW-5', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are at the southern end of a shadowy land. The ground here is quite\nsoft, and the area is surrounded by quicksand on most sides. North of here\nis a terrain of shallow hills.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'PSEUDO': ('QUICKS', ZG.QUICKSAND_PSEUDO),
    'NORTH': ('TO', ZG.SHADOW_4),
    'NW': ('TO', ZG.SHADOW_6),
    'NE': ('TO', ZG.SHADOW_1),
    'SE': 'The quicksand prevents movement in that direction.',
    'WEST': 'The quicksand prevents movement in that direction.',
    'SOUTH': 'The quicksand prevents movement in that direction.',
    'SW': 'The quicksand prevents movement in that direction.',
    'EAST': 'The quicksand prevents movement in that direction.',
})

# zil: 3actions.zil:3281  <ROOM SHADOW-6>
ZG.world.declare_object('SHADOW_6', 'SHADOW-6', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are near the southern end of the land of shadow. The ground here is\nsoft and spongy, and it becomes quicksand to the south. North and east of here\nare gentle, rolling hills. A gentle sea breeze wafts over a steeply sloping\npath to the west.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'NORTH': ('TO', ZG.SHADOW_7),
    'NW': ('TO', ZG.FLATHEAD_OCEAN),
    'WEST': ('TO', ZG.FLATHEAD_OCEAN),
    'DOWN': ('TO', ZG.FLATHEAD_OCEAN),
    'SE': ('TO', ZG.SHADOW_5),
    'EAST': ('TO', ZG.SHADOW_4),
    'NE': ('TO', ZG.SHADOW_3),
    'SOUTH': 'The quicksand prevents movement in that direction.',
    'SW': 'The quicksand prevents movement in that direction.',
    'PSEUDO': ('QUICKS', ZG.QUICKSAND_PSEUDO),
})

# zil: 3actions.zil:3302  <ROOM SHADOW-7>
ZG.world.declare_object('SHADOW_7', 'SHADOW-7', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are in a land of dark shadows and shallow hills, which stretch out in all\ndirections. To the west, the land dips sharply.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'NE': ('TO', ZG.SHADOW_2),
    'EAST': ('TO', ZG.SHADOW_3),
    'SE': ('TO', ZG.SHADOW_4),
    'SOUTH': ('TO', ZG.SHADOW_6),
    'NORTH': ('TO', ZG.SHADOW_8),
    'DOWN': ('TO', ZG.FLATHEAD_OCEAN),
    'NW': ('TO', ZG.FLATHEAD_OCEAN),
    'WEST': ('TO', ZG.FLATHEAD_OCEAN),
    'SW': ('TO', ZG.FLATHEAD_OCEAN),
})

# zil: 3actions.zil:3320  <ROOM SHADOW-8>
ZG.world.declare_object('SHADOW_8', 'SHADOW-8', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Land of Shadow',
    'LDESC': 'You are standing atop a steep cliff, looking west over a vast ocean.\nFar below, the surf pounds at a sandy beach. To the south and east are\nrolling hills filled with eerie shadows. A path cut into the face of the\ncliff descends toward the beach. To the north is a tall stone wall,\nwhich ends at the cliff edge. It was obviously built long ago, and\ndirectly north is a spot where you could climb over the rubble of the\ndecaying wall.',
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.SHADOW_ROOMS,
    'SOUTH': ('TO', ZG.SHADOW_7),
    'EAST': ('TO', ZG.SHADOW_2),
    'SE': ('TO', ZG.SHADOW_3),
    'SW': ('TO', ZG.FLATHEAD_OCEAN),
    'WEST': ('TO', ZG.FLATHEAD_OCEAN),
    'NE': 'A stone wall blocks the way.',
    'NW': 'A stone wall blocks the way.',
    'DOWN': ('TO', ZG.FLATHEAD_OCEAN),
    'NORTH': ('TO', ZG.CLIFF),
    'GLOBAL': (ZG.RUBBLE, ZG.STONE_WALL),
})

# zil: 3actions.zil:3344  <ROOM FLATHEAD-OCEAN>
ZG.world.declare_object('FLATHEAD_OCEAN', 'FLATHEAD-OCEAN', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Flathead Ocean',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'NORTH': ('TO', ZG.CLIFF_BASE),
    'ENTER': "Between the rocks, wind, and waves, you wouldn't last a minute.",
    'WEST': "Between the rocks, wind, and waves, you wouldn't last a minute.",
    'SW': "Between the rocks, wind, and waves, you wouldn't last a minute.",
    'NW': "Between the rocks, wind, and waves, you wouldn't last a minute.",
    'ACTION': ZG.FLATHEAD_OCEAN_F,
    'SE': ('TO', ZG.SHADOW_6),
    'NE': ('TO', ZG.SHADOW_8),
    'EAST': ('TO', ZG.SHADOW_7),
    'SOUTH': 'The quicksand prevents movement here.',
    'PSEUDO': ('QUICKS', ZG.QUICKSAND_PSEUDO, 'MIST', ZG.MIST_PSEUDO),
})

# zil: 3actions.zil:3360  <OBJECT SHADOW>
ZG.world.declare_object('SHADOW', 'SHADOW', lambda: {
    'DESC': 'hooded figure',
    'SYNONYM': ('SHADOW', 'FIGURE', 'MAN', 'WOMAN'),
    'ADJECTIVE': ('HOODED', 'CLOAKED'),
    'FLAGS': ('ACTORBIT', 'TRANSBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.SHADOW_F,
    'DESCFCN': ZG.SHADOW_F,
})

# zil: 3actions.zil:3368  <OBJECT HOOD>
ZG.world.declare_object('HOOD', 'HOOD', lambda: {
    'LOC': ZG.SHADOW,
    'DESC': 'hood',
    'SYNONYM': 'HOOD',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT', 'TAKEBIT', 'WEARBIT'),
    'ACTION': ZG.HOOD_F,
})

# zil: 3actions.zil:3375  <OBJECT CLOAK>
ZG.world.declare_object('CLOAK', 'CLOAK', lambda: {
    'LOC': ZG.SHADOW,
    'DESC': 'cloak',
    'SYNONYM': 'CLOAK',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT', 'TAKEBIT', 'WEARBIT'),
    'ACTION': ZG.CLOAK_F,
})

# zil: 3actions.zil:3382  <GLOBAL DIRS>
# GLOBAL (state) DIRS = LTABLE('NORTH', 'north', 'SOUTH', 'south', 'EAST', 'east', 'WEST', 'west', 'NW', 'northwest', 'NE', 'northeast', 'SE', 'southeast', 'SW', 'southwest', 'UP', 'stairs', 'DOWN', 'stairs')  ->  ZilGlobal.py

# zil: 3actions.zil:3387  <GLOBAL DIR-TBL>
# GLOBAL (state) DIR_TBL = TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)  ->  ZilGlobal.py

# zil: 3actions.zil:3389  <ROUTINE PICK-DIRECTION (RM "AUX" (NXT 0) (CNT 0) (OFFS 0))>
@ZG.routine('PICK-DIRECTION')
def PICK_DIRECTION(RM):
    NXT = 0
    CNT = 0
    OFFS = 0
    while True:
        if ((NXT := NEXTP(RM, NXT)) == 0):
            break
        elif (not (NXT < LOW_DIRECTION)):
            if (not (NXT in ('UP', 'DOWN'))):
                OFFS = (OFFS + 1)
                PUT(ZG.DIR_TBL, OFFS, NXT)
                CNT = (CNT + 1)
    return GET(ZG.DIR_TBL, RANDOM(CNT))

# zil: 3actions.zil:3400  <ROUTINE SHADOW-F ("OPTIONAL" (RARG <>))>
@ZG.routine('SHADOW-F')
def SHADOW_F(RARG=None):
    if RARG is None:
        RARG = False
    if (RARG == ZG.M_OBJDESC):
        if (not ZG.BLOCKED_DIR):
            ZG.BLOCKED_DIR = ZG.PICK_DIRECTION(ZG.HERE)
        TELL('A cloaked and hooded person, carrying a sword not unlike your own,')
        if (ZG.S_STRENGTH > 3):
            TELL('\nis standing blocking the way to the ')
            TELL(ZG.LKP(ZG.BLOCKED_DIR, ZG.DIRS), '.', CR)
        else:
            TELL('\nis here.', CR)
        return TELL('The hooded figure', GET(ZG.SHADOW_DIAG, ZG.S_STRENGTH), CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.SHADOW)):
        return TELL("The hooded figure isn't interested in your gifts.", CR)
    elif ZG.HELLO_p(ZG.SHADOW):
        return TELL('The hooded figure does not respond to your words.', CR)
    elif (VERB_p('ATTACK') and (ZG.PRSI == ZG.SWORD)):
        if (not ZG.SHADOW_POINT_2):
            ZG.SCORE = (ZG.SCORE + 1)
            ZG.SHADOW_POINT_2 = True
        return ZG.SHADOW_ATTACK()
    elif VERB_p('ATTACK'):
        TELL('The hooded figure ignores your feeble attack.', CR)
        ZG.ATTACK_MODE = True
        ENABLE(ZG.QUEUE(ZG.I_CURE, 10))
        return ENABLE(ZG.QUEUE(ZG.I_SHADOW_REPLY, -1))
    else:
        return False

# zil: 3actions.zil:3431  <GLOBAL SHADOW-DIAG>
# GLOBAL (state) SHADOW_DIAG = TABLE('?', ' appears to be badly hurt and defenseless.', ' is hurt, and its strength appears to be fading.', ' has some wounds and is probably not capable of hindering your movement.', " has a light wound which hasn't affected its seemingly great strength.", ' has a great deal of strength, perhaps matching your own.')  ->  ZilGlobal.py

# zil: 3actions.zil:3440  <GLOBAL P-STRENGTH>
# GLOBAL (scratch) P_STRENGTH = 5  ->  ZilGlobal.py

# zil: 3actions.zil:3441  <GLOBAL S-STRENGTH>
# GLOBAL (state) S_STRENGTH = 5  ->  ZilGlobal.py

# zil: 3actions.zil:3443  <GLOBAL ATTACK-MODE>
# GLOBAL (state) ATTACK_MODE = False  ->  ZilGlobal.py

# zil: 3actions.zil:3444  <GLOBAL SHADOW-GONE>
# GLOBAL (state) SHADOW_GONE = False  ->  ZilGlobal.py

# zil: 3actions.zil:3446  <ROUTINE I-CURE ()>
@ZG.routine('I-CURE')
def I_CURE():
    if (not (ZG.P_STRENGTH == 5)):
        ZG.P_STRENGTH = (ZG.P_STRENGTH + 1)
    if (not (ZG.S_STRENGTH == 5)):
        ZG.S_STRENGTH = (ZG.S_STRENGTH + 1)
    if (not ((ZG.P_STRENGTH + ZG.S_STRENGTH) == 10)):
        ZG.QUEUE(ZG.I_CURE, 10)
    return False

# zil: 3actions.zil:3455  <ROUTINE SHADOW-ATTACK ()>
@ZG.routine('SHADOW-ATTACK')
def SHADOW_ATTACK():
    if (not ZG.ATTACK_MODE):
        ENABLE(ZG.QUEUE(ZG.I_CURE, 10))
        ZG.ATTACK_MODE = True
        ENABLE(ZG.QUEUE(ZG.I_SHADOW_REPLY, -1))
    if ZG.PROB(((ZG.P_STRENGTH * 10) + 10)):
        if ZG.PROB(85):
            ZG.S_STRENGTH = (ZG.S_STRENGTH - 1)
            if (ZG.S_STRENGTH == 0):
                ZG.SHADOW_DIES()
                return True
            TELL(ZG.PICK_ONE(ZG.P_HITS), CR)
            return TELL('The figure', GET(ZG.SHADOW_DIAG, ZG.S_STRENGTH), CR)
        else:
            ZG.S_STRENGTH = (ZG.S_STRENGTH - 2)
            if (ZG.S_STRENGTH == 0):
                ZG.S_STRENGTH = 1
            elif (ZG.S_STRENGTH < 1):
                ZG.SHADOW_DIES()
                return True
            TELL('A sharp thrust and the hooded figure is badly wounded!', CR)
            return TELL('The figure', GET(ZG.SHADOW_DIAG, ZG.S_STRENGTH), CR)
    else:
        if (ZG.S_STRENGTH < 2):
            return TELL('Your opponent blocks your attack with its sword.', CR)
        else:
            return TELL(ZG.PICK_ONE(ZG.P_MISSES), CR)

# zil: 3actions.zil:3483  <GLOBAL P-HITS>
# GLOBAL (scratch) P_HITS = LTABLE(0, 'A good parry! Your sword wounds the hooded figure!', "A quick stroke catches the hooded figure off guard! Blood trickles\ndown the figure's arm!", 'The hooded figure is hit with a quick slash!')  ->  ZilGlobal.py

# zil: 3actions.zil:3489  <GLOBAL P-MISSES>
# GLOBAL (scratch) P_MISSES = LTABLE(0, 'Your move was not quick enough and misses the mark.', 'A quick stroke, but the hooded figure is on guard.', "A good stroke, but it's too slow.", 'A good slash, but it misses by a mile.', 'You charge, but the hooded figure jumps nimbly aside.')  ->  ZilGlobal.py

# zil: 3actions.zil:3496  <GLOBAL S-HITS>
# GLOBAL (state) S_HITS = LTABLE(0, 'The hooded figure catches you off guard and wounds you!', 'You are wounded by a lightning thrust!', "Your quick reflexes cannot stop the hooded figure's stroke! You are hit!")  ->  ZilGlobal.py

# zil: 3actions.zil:3501  <ROUTINE I-SHADOW-REPLY ()>
@ZG.routine('I-SHADOW-REPLY')
def I_SHADOW_REPLY():
    if ((not ZG.ATTACK_MODE) or (not IN_p(ZG.SHADOW, ZG.HERE))):
        ZG.QUEUE(ZG.I_SHADOW_REPLY, 0)
        ZG.ATTACK_MODE = False
        return False
    if (not IN_p(ZG.SWORD, ZG.WINNER)):
        MOVE(ZG.SWORD, ZG.WINNER)
        TELL('Your sword, glowing wildly, leaps into your hand!', CR)
    if (ZG.PROB(((ZG.S_STRENGTH * 10) + 10)) and (ZG.S_STRENGTH > 1)):
        if ZG.PROB(90):
            if (ZG._set('P_STRENGTH', (ZG.P_STRENGTH - 1)) < 1):
                ZG.P_STRENGTH = 1
                return TELL('The hooded figure swings its sword and sends yours flying to the ground.\nAlthough you are defenseless, the figure reaches for your sword and hands it\nback to you, nodding grimly.', CR)
            else:
                return TELL(ZG.PICK_ONE(ZG.S_HITS), CR)
        else:
            if (ZG._set('P_STRENGTH', (ZG.P_STRENGTH - 2)) < 1):
                return ZG.JIGS_UP('In your wounded state, you cannot defend yourself against your still-quick\nopponent. Slowly and carefully, the figure starts to remove its hood as you\nfall to the ground, dead.')
            else:
                return TELL('A brilliant feint puts you off guard, and the hooded figure slips its\nsword between your ribs. You are hurt very badly.', CR)
    elif (ZG.S_STRENGTH < 3):
        return TELL('The hooded figure attempts a thrust, but its weakened state prevents\nhitting you.', CR)
    else:
        return TELL(ZG.PICK_ONE(ZG.S_MISSES), CR)

# zil: 3actions.zil:3537  <GLOBAL S-MISSES>
# GLOBAL (state) S_MISSES = LTABLE(0, 'The hooded figure stabs nonchalantly with its sword and misses.', 'You dodge as the hooded figure comes in low.', 'The hooded figure tries to sneak past your guard, but you twist away.', 'The hooded figure thrusts, but you fight back and send it\nflying to the ground!')  ->  ZilGlobal.py

# zil: 3actions.zil:3544  <ROUTINE SHADOW-DIES ()>
@ZG.routine('SHADOW-DIES')
def SHADOW_DIES():
    TELL('The hooded figure, fatally wounded, slumps to the ground. It gazes up at\nyou once, and you catch a brief glimpse of deep and sorrowful eyes. Before\nyou can react, the figure vanishes in a cloud of fetid vapor.', CR)
    REMOVE(ZG.SHADOW)
    ZG.SHADOW_GONE = True
    ZG.BLOCKED_DIR = False
    return ZG.BLOCKED_DIR

# zil: 3actions.zil:3553  <ROUTINE HOOD-F ()>
@ZG.routine('HOOD-F')
def HOOD_F():
    if (VERB_p('LOOK-UNDER') and IN_p(ZG.HOOD, ZG.SHADOW)):
        return TELL("The figure's hood casts a dark shadow over its face. There is no way from\nwhere you stand to look beneath it.", CR)
    elif (VERB_p('TAKE', 'PUT') and IN_p(ZG.HOOD, ZG.SHADOW)):
        if (ZG.S_STRENGTH == 1):
            TELL('You slowly remove the hood from your badly wounded opponent and recoil\nin horror at the sight of your own face, weary and wounded. A faint\nsmile comes to the lips and then the face starts to change, very slowly,\ninto that of an old, wizened person. The image fades and with it the body\nof your hooded opponent. The cloak remains on the ground.', CR)
            REMOVE(ZG.SHADOW)
            ZG.SHADOW_GONE = True
            MOVE(ZG.HOOD, ZG.WINNER)
            FCLEAR(ZG.HOOD, Flag('NDESCBIT'))
            MOVE(ZG.CLOAK, ZG.HERE)
            return FCLEAR(ZG.CLOAK, Flag('NDESCBIT'))
        elif (ZG.S_STRENGTH == 2):
            return TELL('The hooded figure, though recovering from wounds, is strong enough to\nforce you back.', CR)
        else:
            return TELL('You cannot get close enough to the hooded figure to remove the hood.', CR)
    else:
        return False

# zil: 3actions.zil:3580  <ROUTINE CLOAK-F ()>
@ZG.routine('CLOAK-F')
def CLOAK_F():
    if (VERB_p('LOOK-UNDER') and IN_p(ZG.CLOAK, ZG.SHADOW)):
        return TELL('You cannot get close enough to look underneath the cloak.', CR)
    elif (VERB_p('TAKE') and IN_p(ZG.CLOAK, ZG.SHADOW)):
        return TELL('The cloak is fastened around the neck of the hooded figure. It would be\ndifficult to remove.', CR)
    else:
        return False

# zil: 3actions.zil:3589  <GLOBAL BLOCKED-DIR>
# GLOBAL (state) BLOCKED_DIR = False  ->  ZilGlobal.py

# zil: 3actions.zil:3591  <ROUTINE SHADOW-ROOMS (RARG)>
@ZG.routine('SHADOW-ROOMS')
def SHADOW_ROOMS(RARG):
    if ((RARG == ZG.M_BEG) and VERB_p('WALK') and (ZG.PRSO == ZG.BLOCKED_DIR)):
        return TELL('Your way is blocked by the hooded figure.', CR)
    elif (RARG == ZG.M_END):
        if (not IN_p(ZG.SHADOW, ZG.HERE)):
            ZG.BLOCKED_DIR = False
            REMOVE(ZG.SHADOW)
        if ZG.SHADOW_GONE:
            return False
        elif IN_p(ZG.SHADOW, ZG.HERE):
            if (ZG.PROB(30) and (not ZG.ATTACK_MODE)):
                ZG.ATTACK_MODE = True
                ENABLE(ZG.QUEUE(ZG.I_CURE, 10))
                return ENABLE(ZG.QUEUE(ZG.I_SHADOW_REPLY, -1))
            else:
                return False
        elif ZG.PROB(30):
            return TELL('You can hear quiet footsteps nearby.', CR)
        elif (ZG.PROB(30) and ZG.LIT and (ZG.S_STRENGTH > 3)):
            ZG.BLOCKED_DIR = ZG.PICK_DIRECTION(ZG.HERE)
            TELL('Through the shadows, a cloaked and hooded figure appears before you,\nblocking the ')
            TELL(ZG.LKP(ZG.BLOCKED_DIR, ZG.DIRS), 'ern exit from the room and carrying a\nbrightly glowing sword.', CR)
            ZG.SHADOW_ARRIVAL()
            return True
        else:
            return False
    else:
        return False

# zil: 3actions.zil:3620  <ROUTINE SHADOW-ARRIVAL ()>
@ZG.routine('SHADOW-ARRIVAL')
def SHADOW_ARRIVAL():
    MOVE(ZG.SHADOW, ZG.HERE)
    if (not ZG.SHADOW_POINT_1):
        ZG.SCORE = (ZG.SCORE + 1)
        ZG.SHADOW_POINT_1 = True
    if (not IN_p(ZG.SWORD, ZG.WINNER)):
        MOVE(ZG.SWORD, ZG.WINNER)
        if ZG.SWORD_IN_STONE_p:
            TELL('From nowhere, the sword from the junction appears in your hand, wildly\nglowing!', CR)
        else:
            TELL('Your sword, glowing wildly, appears in your hand!', CR)
        ZG.SWORD_IN_STONE_p = False
        return ZG.SWORD_IN_STONE_p
    else:
        return False

# zil: 3actions.zil:3636  <GLOBAL SHADOW-POINT-1>
# GLOBAL (state) SHADOW_POINT_1 = False  ->  ZilGlobal.py

# zil: 3actions.zil:3637  <GLOBAL SHADOW-POINT-2>
# GLOBAL (state) SHADOW_POINT_2 = False  ->  ZilGlobal.py

# zil: 3actions.zil:3639  <ROUTINE CREEPY-CRAWL-F (RARG)>
@ZG.routine('CREEPY-CRAWL-F')
def CREEPY_CRAWL_F(RARG):
    if (RARG == ZG.M_END):
        ZG.BLOCKED_DIR = False
        return True
    else:
        return False

# ;" Cooperative Problem"

# zil: 3actions.zil:3646  <ROOM ZORK2-STAIR>
ZG.world.declare_object('ZORK2_STAIR', 'ZORK2-STAIR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Endless Stair',
    'LDESC': 'You are at the bottom of a seemingly endless stair, winding its way\nupward beyond your vision. An eerie light, coming from all around you,\ncasts strange shadows on the walls. To the south is a dark and winding\ntrail.',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'NORTH': 'The stairs are endless.',
    'UP': 'The stairs are endless.',
    'SOUTH': ('TO', ZG.JUNCTION),
    'GLOBAL': ZG.STAIRS,
})

# zil: 3actions.zil:3660  <ROOM JUNCTION>
ZG.world.declare_object('JUNCTION', 'JUNCTION', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Junction',
    'LDESC': 'You are at the junction of a north-south passage and an east-west\npassage. To the north, you can make out the bottom of a stairway. The\nways to the east and south are relatively cramped, but a wider trail\nleads to the west.',
    'FLAGS': 'RLANDBIT',
    'WEST': ('TO', ZG.CLEARING),
    'NORTH': ('TO', ZG.ZORK2_STAIR),
    'SOUTH': ('TO', ZG.CREEPY_CRAWL),
    'EAST': ('TO', ZG.DAMP_PASSAGE),
})

# zil: 3actions.zil:3674  <ROOM CLEARING>
ZG.world.declare_object('CLEARING', 'CLEARING', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Barren Area',
    'LDESC': 'You are west of the junction, where the rock-bound passage widens out\ninto a large, flat area. Although the land here is barren, you can see\nvegetation to the west. South of here is a mighty wall of stone, ancient\nand crumbling. To the southwest the wall has decayed enough to form an\nopening, through which seeps a thin mist. A trail dips sharply into\nrocky terrain to the northwest.',
    'FLAGS': 'RLANDBIT',
    'SW': ('TO', ZG.SHADOW_2),
    'NW': ('TO', ZG.SLOPE),
    'SOUTH': 'A stone wall blocks your way.',
    'SE': 'A stone wall blocks your way.',
    'WEST': ('TO', ZG.CLIFF),
    'EAST': ('TO', ZG.JUNCTION),
    'GLOBAL': (ZG.RUBBLE, ZG.STONE_WALL),
    'PSEUDO': ('MIST', ZG.MIST_PSEUDO),
})

# zil: 3actions.zil:3694  <ROOM SLOPE>
ZG.world.declare_object('SLOPE', 'SLOPE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Hairpin Loop',
    'LDESC': 'You are at a sharp turn on a narrow and steeply sloping path, strewn\nwith boulders of various sizes. The path climbs sharply toward a\ndesolate plain to the southeast. Southwest of here the path winds down\nto the base of a cliff.',
    'SE': ('TO', ZG.CLEARING),
    'UP': ('TO', ZG.CLEARING),
    'SW': ('TO', ZG.CLIFF_BASE),
    'DOWN': ('TO', ZG.CLIFF_BASE),
    'GLOBAL': ZG.RUBBLE,
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:3709  <ROOM CLIFF-BASE>
ZG.world.declare_object('CLIFF_BASE', 'CLIFF-BASE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Cliff Base',
    'LDESC': 'You are at the base of a steep cliff. Directly above you is a wide\nledge and far above that some natural sunlight can be seen. To the\nnortheast is a steeply climbing path and the ground becomes sandy toward\nthe south.',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'UP': "You can't get up the rock face.",
    'SOUTH': ('TO', ZG.FLATHEAD_OCEAN),
    'NE': ('TO', ZG.SLOPE),
    'ACTION': ZG.CLIFF_BASE_F,
    'GLOBAL': ZG.LEDGE,
})

# zil: 3actions.zil:3724  <ROOM CLIFF>
ZG.world.declare_object('CLIFF', 'CLIFF', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Cliff',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'DOWN': ('TO', ZG.CLIFF_LEDGE, 'IF', 'ROPE_FLAG', 'ELSE', 'The drop would kill you.'),
    'UP': "There's no tree here suitable for climbing.",
    'SW': ('TO', ZG.SHADOW_8),
    'EAST': ('TO', ZG.CLEARING),
    'ACTION': ZG.CLIFF_F,
    'GLOBAL': (ZG.GLOBAL_MAN, ZG.RUBBLE, ZG.STONE_WALL, ZG.CLIFF_OBJECT),
    'PSEUDO': ('MIST', ZG.MIST_PSEUDO),
})

# zil: 3actions.zil:3736  <ROOM CLIFF-LEDGE>
ZG.world.declare_object('CLIFF_LEDGE', 'CLIFF-LEDGE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Cliff Ledge',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'UP': 'You attempt the climb but slide back down.',
    'DOWN': ('TO', ZG.CLIFF_BASE),
    'ACTION': ZG.CLIFF_LEDGE_F,
    'GLOBAL': (ZG.RUBBLE, ZG.GLOBAL_ROPE, ZG.GLOBAL_MAN, ZG.LEDGE, ZG.CLIFF_OBJECT),
})

# zil: 3actions.zil:3745  <ROOM FOGGY-ROOM>
ZG.world.declare_object('FOGGY_ROOM', 'FOGGY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Foggy Room',
    'LDESC': 'You are in a dank passage filled with a wispy fog. A spooky passageway\nleads north and a wider path heads off to the south. To the west, the\npath leaves the rock and enters an eerie, shadowy land.',
    'NORTH': ('TO', ZG.CREEPY_CRAWL),
    'SOUTH': ('TO', ZG.LAKE_SHORE),
    'WEST': ('TO', ZG.SHADOW_1),
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:3757  <ROOM LAKE-SHORE>
ZG.world.declare_object('LAKE_SHORE', 'LAKE-SHORE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Lake Shore',
    'LDESC': 'You are in a wide cavern on the north shore of a small lake. Some\npolished stone steps lead to the southeast and a sheer rock face\nprevents any movement around the lake to the southwest. The cavern is\ndimly lit from above.',
    'SE': ('TO', ZG.AQ_VIEW),
    'DOWN': ('TO', ZG.AQ_VIEW),
    'SOUTH': 'If you really want to enter the lake, you should say so.',
    'SW': 'The sheer rock face prevents movement along the lake shore.',
    'NORTH': ('TO', ZG.FOGGY_ROOM),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'GLOBAL': (ZG.LAKE, ZG.STAIRS),
    'PSEUDO': ('SHORE', ZG.SHORE_PSEUDO, 'BEACH', ZG.SHORE_PSEUDO),
})

# zil: 3actions.zil:3774  <ROOM AQ-VIEW>
ZG.world.declare_object('AQ_VIEW', 'AQ-VIEW', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Aqueduct View',
    'LDESC': 'This is a small balcony carved into a near-vertical cliff. To the east,\nstretching from north to south, stands a monumental aqueduct supported by\nmighty stone pillars, some of which are starting to crumble from age. You\nfeel a sense of loss and sadness as you ponder this once-proud structure and\nthe failure of the Empire which created this and other engineering marvels.\nSome stone steps lead up to the northwest.',
    'NW': ('TO', ZG.LAKE_SHORE),
    'UP': ('TO', ZG.LAKE_SHORE),
    'DOWN': 'The drop would be fatal.',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.AQUEDUCT, ZG.STAIRS),
})

# zil: 3actions.zil:3790  <ROOM ON-LAKE>
ZG.world.declare_object('ON_LAKE', 'ON-LAKE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'On the Lake',
    'LDESC': 'You are floating on the surface of the lake. The water is ice cold and\nyour ability to survive here for long is very questionable. A swim north\nputs you at your starting point. Conditions to the east are poor where\nthe lake turns into swamp. The west and south shores are suitable for\nwalking, however.',
    'NORTH': ('TO', ZG.LAKE_SHORE),
    'SOUTH': ('TO', ZG.SOUTH_SHORE),
    'PSEUDO': ('SWAMP', ZG.SWAMP_PSEUDO),
    'SE': 'The swamp is impassable.',
    'EAST': 'The swamp is impassable.',
    'NE': 'The swamp is impassable.',
    'WEST': ('TO', ZG.FAR_SHORE),
    'NW': ('TO', ZG.FAR_SHORE),
    'SW': ('TO', ZG.SOUTH_SHORE),
    'DOWN': ('TO', ZG.IN_LAKE),
    'FLAGS': ('RLANDBIT', 'NONLANDBIT', 'ONBIT'),
    'ACTION': ZG.ON_LAKE_F,
    'GLOBAL': (ZG.LAKE, ZG.FISH),
})

# zil: 3actions.zil:3813  <ROOM IN-LAKE>
ZG.world.declare_object('IN_LAKE', 'IN-LAKE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Underwater',
    'LDESC': 'You are below the surface of the lake. It turns out that the lake is quite\nshallow and the bottom is only a few feet below you. Considering the frigid\ntemperature of the water, you should probably not plan an extended stay.\nThe lake bottom is sandy and a few hearty plants and algae live there.',
    'UP': ('TO', ZG.ON_LAKE),
    'DOWN': 'You are already at the bottom of the lake.',
    'NORTH': ('TO', ZG.IN_LAKE),
    'SOUTH': ('TO', ZG.IN_LAKE),
    'EAST': ('TO', ZG.IN_LAKE),
    'WEST': ('TO', ZG.IN_LAKE),
    'NE': ('TO', ZG.IN_LAKE),
    'NW': ('TO', ZG.IN_LAKE),
    'SE': ('TO', ZG.IN_LAKE),
    'SW': ('TO', ZG.IN_LAKE),
    'FLAGS': ('RLANDBIT', 'NONLANDBIT', 'ONBIT'),
    'ACTION': ZG.IN_LAKE_F,
    'GLOBAL': (ZG.LAKE, ZG.FISH),
})

# zil: 3actions.zil:3835  <ROOM FAR-SHORE>
ZG.world.declare_object('FAR_SHORE', 'FAR-SHORE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Western Shore',
    'LDESC': "You are on the western shore of the lake. The ground here is quite\nhard, but a few sickly reeds manage to grow near the water's edge. The\nonly path leads into the rock to the south.",
    'EAST': 'If you want to enter the lake, you should say so.',
    'SOUTH': ('TO', ZG.VIEW_ROOM),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': ZG.LAKE,
    'PSEUDO': ('SHORE', ZG.SHORE_PSEUDO, 'BEACH', ZG.SHORE_PSEUDO),
})

# zil: 3actions.zil:3848  <OBJECT REEDS>
ZG.world.declare_object('REEDS', 'REEDS', lambda: {
    'LOC': ZG.FAR_SHORE,
    'SYNONYM': 'REEDS',
    'ADJECTIVE': 'SICKLY',
    'DESC': 'reeds',
    'FLAGS': 'NDESCBIT',
})

# zil: 3actions.zil:3855  <ROOM VIEW-ROOM>
ZG.world.declare_object('VIEW_ROOM', 'VIEW-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Scenic Vista',
    'LDESC': '',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'NORTH': ('TO', ZG.FAR_SHORE),
    'ACTION': ZG.VIEW_ROOM_F,
})

# zil: 3actions.zil:3863  <OBJECT VIEWING-TABLE>
ZG.world.declare_object('VIEWING_TABLE', 'VIEWING-TABLE', lambda: {
    'LOC': ZG.VIEW_ROOM,
    'DESC': 'viewing table',
    'SYNONYM': ('TABLE', 'SURFACE'),
    'ADJECTIVE': 'VIEWING',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.VIEWING_TABLE_F,
})

# zil: 3actions.zil:3871  <OBJECT TORCH>
ZG.world.declare_object('TORCH', 'TORCH', lambda: {
    'LOC': ZG.VIEW_ROOM,
    'DESC': 'torch',
    'FDESC': 'Mounted on one wall is a flaming torch, which fills the room with a flickering\nlight.',
    'SYNONYM': 'TORCH',
    'FLAGS': ('LIGHTBIT', 'TAKEBIT', 'ONBIT', 'FLAMEBIT'),
    'ACTION': ZG.TORCH_F,
})

# zil: 3actions.zil:3881  <OBJECT FRIED-TORCH>
ZG.world.declare_object('FRIED_TORCH', 'FRIED-TORCH', lambda: {
    'DESC': 'burned-out torch',
    'SYNONYM': 'TORCH',
    'ADJECTIVE': ('BURNED', 'DEAD'),
    'FLAGS': 'TAKEBIT',
    'ACTION': ZG.FRIED_TORCH_F,
})

# zil: 3actions.zil:3888  <OBJECT CLIFF-OBJECT>
ZG.world.declare_object('CLIFF_OBJECT', 'CLIFF-OBJECT', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'cliff',
    'SYNONYM': 'CLIFF',
    'ACTION': ZG.CLIFF_OBJECT_F,
})

# zil: 3actions.zil:3894  <OBJECT STONE-WALL>
ZG.world.declare_object('STONE_WALL', 'STONE-WALL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'stone wall',
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('STONE', 'MASSIVE'),
    'FLAGS': 'NDESCBIT',
})

# zil: 3actions.zil:3901  <OBJECT LAKE>
ZG.world.declare_object('LAKE', 'LAKE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'lake',
    'SYNONYM': ('LAKE', 'WATER', 'SURFACE'),
    'ACTION': ZG.LAKE_F,
})

# zil: 3actions.zil:3907  <OBJECT AMULET>
ZG.world.declare_object('AMULET', 'AMULET', lambda: {
    'DESC': 'golden amulet',
    'SYNONYM': ('AMULET', 'OBJECT'),
    'ADJECTIVE': ('GOLD', 'GOLDEN', 'SHINY'),
    'FLAGS': ('TAKEBIT', 'WEARBIT', 'NDESCBIT'),
})

# zil: 3actions.zil:3913  <OBJECT SAND>
ZG.world.declare_object('SAND', 'SAND', lambda: {
    'LOC': ZG.IN_LAKE,
    'DESC': 'sand',
    'SYNONYM': ('SAND', 'FLOOR', 'BOTTOM'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.SAND_F,
})

# zil: 3actions.zil:3920  <OBJECT FRIED-LAMP>
ZG.world.declare_object('FRIED_LAMP', 'FRIED-LAMP', lambda: {
    'DESC': 'lamp',
    'SYNONYM': ('LAMP', 'LANTERN'),
    'ADJECTIVE': 'BRASS',
    'FLAGS': 'TAKEBIT',
    'SIZE': 10,
    'ACTION': ZG.FRIED_LAMP_F,
})

# zil: 3actions.zil:3928  <OBJECT ALGAE>
ZG.world.declare_object('ALGAE', 'ALGAE', lambda: {
    'LOC': ZG.IN_LAKE,
    'DESC': 'plants and algae',
    'SYNONYM': ('PLANT', 'PLANTS', 'ALGAE'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.ALGAE_F,
})

# zil: 3actions.zil:3935  <OBJECT SHINY-OBJECT>
ZG.world.declare_object('SHINY_OBJECT', 'SHINY-OBJECT', lambda: {
    'LOC': ZG.IN_LAKE,
    'DESC': 'shiny object',
    'SYNONYM': ('OBJECT', 'AMULET'),
    'ADJECTIVE': 'SHINY',
    'FLAGS': ('TRYTAKEBIT', 'NDESCBIT'),
    'ACTION': ZG.SHINY_OBJECT_F,
})

# zil: 3actions.zil:3943  <OBJECT LEDGE>
ZG.world.declare_object('LEDGE', 'LEDGE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'ledge',
    'SYNONYM': 'LEDGE',
    'ADJECTIVE': 'WIDE',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.LEDGE_F,
})

# zil: 3actions.zil:3951  <ROUTINE LEDGE-F ()>
@ZG.routine('LEDGE-F')
def LEDGE_F():
    if ((ZG.HERE == ZG.CLIFF_LEDGE) and VERB_p('THROW-OFF') and (ZG.PRSI == ZG.LEDGE)):
        if (not IN_p(ZG.PRSO, ZG.WINNER)):
            TELL("You're not holding that!", CR)
            return True
        MOVE(ZG.PRSO, ZG.CLIFF_BASE)
        return TELL('The ', D, ZG.PRSO, ' falls to the base of the cliff below.', CR)
    else:
        return False

# zil: 3actions.zil:3962  <OBJECT WAYBREAD>
ZG.world.declare_object('WAYBREAD', 'WAYBREAD', lambda: {
    'LOC': ZG.CLIFF,
    'DESC': 'piece of waybread',
    'LDESC': 'A piece of bread is on the ground here.',
    'FDESC': 'It seems as if somebody has been here recently, as there is some fresh\nbread lying beneath one of the other trees.',
    'SYNONYM': ('BREAD', 'WAYBREAD', 'PIECE'),
    'ADJECTIVE': ('WAY', 'FRESH'),
    'FLAGS': ('TAKEBIT', 'FOODBIT'),
    'SIZE': 3,
    'ACTION': ZG.WAYBREAD_F,
})

# zil: 3actions.zil:3975  <ROUTINE WAYBREAD-F ()>
@ZG.routine('WAYBREAD-F')
def WAYBREAD_F():
    if (VERB_p('CUT') and (ZG.PRSI == ZG.SWORD)):
        TELL('The bread is crushed rather than cut by your sword, and the crumbs scatter to\nthe wind.', CR)
        return REMOVE(ZG.WAYBREAD)
    else:
        return False

# zil: 3actions.zil:3982  <OBJECT ROPE>
ZG.world.declare_object('ROPE', 'ROPE', lambda: {
    'LOC': ZG.CLIFF,
    'DESC': 'rope',
    'SYNONYM': 'ROPE',
    'ADJECTIVE': 'LONG',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.ROPE_F,
})

# zil: 3actions.zil:3990  <OBJECT GLOBAL-ROPE>
ZG.world.declare_object('GLOBAL_ROPE', 'GLOBAL-ROPE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'rope',
    'SYNONYM': 'ROPE',
    'ADJECTIVE': 'DANGLING',
    'ACTION': ZG.GLOBAL_ROPE_F,
})

# zil: 3actions.zil:3997  <OBJECT TREE>
ZG.world.declare_object('TREE', 'TREE', lambda: {
    'LOC': ZG.CLIFF,
    'DESC': 'tree',
    'SYNONYM': ('TREE', 'TREES'),
    'ADJECTIVE': ('LARGE', 'TALL'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.TREE_F,
})

# zil: 3actions.zil:4005  <OBJECT STAFF>
ZG.world.declare_object('STAFF', 'STAFF', lambda: {
    'DESC': 'wooden staff',
    'SYNONYM': 'STAFF',
    'ADJECTIVE': 'WOODEN',
    'FLAGS': 'TAKEBIT',
    'SIZE': 10,
    'ACTION': ZG.STAFF_F,
})

# zil: 3actions.zil:4013  <OBJECT BROKEN-STAFF>
ZG.world.declare_object('BROKEN_STAFF', 'BROKEN-STAFF', lambda: {
    'DESC': 'broken staff',
    'SYNONYM': 'STAFF',
    'ADJECTIVE': 'BROKEN',
    'FLAGS': 'TAKEBIT',
    'SIZE': 10,
    'ACTION': ZG.STAFF_F,
})

# zil: 3actions.zil:4021  <ROUTINE STAFF-F ()>
@ZG.routine('STAFF-F')
def STAFF_F():
    if (VERB_p('BURN') and (ZG.PRSI == ZG.TORCH)):
        REMOVE(ZG.PRSO)
        return ZG.JIGS_UP('The staff is instantly consumed in a ball of flame. You along with it.')
    else:
        return False

# zil: 3actions.zil:4027  <OBJECT CHEST>
ZG.world.declare_object('CHEST', 'CHEST', lambda: {
    'LOC': ZG.CLIFF_LEDGE,
    'DESC': 'chest',
    'FDESC': 'A large chest, closed and locked, is lying among the boulders.',
    'SYNONYM': 'CHEST',
    'ADJECTIVE': 'LOCKED',
    'FLAGS': ('TAKEBIT', 'CONTBIT'),
    'SIZE': 40,
    'CAPACITY': 20,
    'ACTION': ZG.CHEST_F,
})

# zil: 3actions.zil:4039  <OBJECT GLOBAL-MAN>
ZG.world.declare_object('GLOBAL_MAN', 'GLOBAL-MAN', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'man',
    'SYNONYM': ('MAN', 'FRIEND'),
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.GLOBAL_MAN_F,
})

# zil: 3actions.zil:4046  <OBJECT VALUABLES>
ZG.world.declare_object('VALUABLES', 'VALUABLES', lambda: {
    'LOC': ZG.MAN,
    'DESC': 'pile of assorted valuables',
    'SYNONYM': ('VALUABLES', 'TREASURE', 'PILE'),
    'ADJECTIVE': 'ASSORTED',
    'FLAGS': ('NDESCBIT', 'TAKEBIT'),
    'ACTION': ZG.VALUABLES_F,
})

# zil: 3actions.zil:4054  <OBJECT MAN>
ZG.world.declare_object('MAN', 'MAN', lambda: {
    'SYNONYM': ('MAN', 'FRIEND'),
    'DESC': 'man',
    'FLAGS': ('ACTORBIT', 'OPENBIT', 'CONTBIT'),
    'ACTION': ZG.MAN_F,
})

# zil: 3actions.zil:4060  <GLOBAL CHEST-LIFTED>
# GLOBAL (state) CHEST_LIFTED = False  ->  ZilGlobal.py

# zil: 3actions.zil:4062  <ROUTINE I-MAN-APPEARS ()>
@ZG.routine('I-MAN-APPEARS')
def I_MAN_APPEARS():
    if ((not (ZG.HERE == ZG.CLIFF_LEDGE)) or (not (LOC(ZG.CHEST) in (ZG.CLIFF_LEDGE, ZG.WINNER)))):
        return False
    elif ZG.CHEST_TIED:
        ZG.MAN_SEEN = True
        TELL('All at once, the chest is lifted from you. Looking up, you see a\nman at the top of the cliff, pulling intently at the rope. "That is\nuncommonly good of you, I do say!" He chuckles unpleasantly. "Oh,\nyou are stuck, aren\'t you. Well, I\'ll be right back to get you!"\nHe leaves your sight.', CR)
        ZG.CHEST_LIFTED = True
        MOVE(ZG.CHEST, ZG.MAN)
        FSET(ZG.CHEST, Flag('TOUCHBIT'))
        ZG.ROPE_FLAG = False
        ZG.CHEST_TIED = False
        ENABLE(ZG.QUEUE(ZG.I_MAN_RETURNS, 10))
        return True
    else:
        TELL('At the edge of the cliff above you, a man appears. He looks down at\nyou and speaks. "Hello, down there! You seem to have a problem. Maybe I\ncan help you." He chuckles in an unsettling sort of way. "Perhaps if you\ntied that chest to the end of the rope I might be able to drag it up for you.\nThen, I\'ll be more than happy to help you up!" He laughs again.', CR)
        ZG.MAN_FLAG = True
        ZG.MAN_SEEN = True
        return ENABLE(ZG.QUEUE(ZG.I_MAN_PRESENT, -1))

# zil: 3actions.zil:4092  <GLOBAL MAN-SEEN>
# GLOBAL (state) MAN_SEEN = False  ->  ZilGlobal.py

# zil: 3actions.zil:4094  <ROUTINE I-MAN-PRESENT ()>
@ZG.routine('I-MAN-PRESENT')
def I_MAN_PRESENT():
    if ((not (ZG.HERE == ZG.CLIFF_LEDGE)) or (not ZG.MAN_FLAG) or IN_p(ZG.CHEST, ZG.MAN)):
        ZG.QUEUE(ZG.I_MAN_PRESENT, 0)
        ZG.MAN_FLAG = False
        return False
    elif (ZG._set('MAN_WAITING', (ZG.MAN_WAITING + 1)) > 10):
        TELL('The man looks quite displeased. "All right, then. I guess someone else\ncan always help me! See you around, sport!" He disappears.', CR)
        ZG.QUEUE(ZG.I_MAN_PRESENT, 0)
        ZG.MAN_FLAG = False
        return True
    else:
        return TELL(ZG.PICK_ONE(ZG.MAN_WAITS), CR)

# zil: 3actions.zil:4110  <ROUTINE CLIFF-BASE-F (RARG)>
@ZG.routine('CLIFF-BASE-F')
def CLIFF_BASE_F(RARG):
    if ((RARG == ZG.M_ENTER) and ZG.CHEST_TIED):
        ZG.CHEST_TIED = False
        ZG.ROPE_FLAG = False
        return ZG.QUEUE(ZG.I_MAN_APPEARS, 0)
    else:
        return False

# zil: 3actions.zil:4117  <GLOBAL MAN-WAITS>
# GLOBAL (state) MAN_WAITS = LTABLE(0, 'The man appears to be getting somewhat impatient.', 'Your friend at the cliff top has started pacing nervously around.', '"Yoo hoo!" calls the man at the brink of the cliff. "Remember me?"', 'The man on the cliff waves at you. "It would just take a moment to tie that\nrope to the chest. I\'d be much obliged, and there might even be something in\nit for you!"', 'A few small stones fall near your feet. You look up and see your friend\nwaving. "I haven\'t got all day, fella. Be a pal and pass up the chest!"', 'The man on the cliff clears his throat loudly. "I don\'t mean to be rushing\nyou, but I do have some pressing engagements...."')  ->  ZilGlobal.py

# zil: 3actions.zil:4129  <GLOBAL MAN-WAITING>
# GLOBAL (state) MAN_WAITING = 0  ->  ZilGlobal.py

# zil: 3actions.zil:4130  <GLOBAL MAN-FLAG>
# GLOBAL (state) MAN_FLAG = False  ->  ZilGlobal.py

# zil: 3actions.zil:4131  <GLOBAL MAN-POINT>
# GLOBAL (state) MAN_POINT = False  ->  ZilGlobal.py

# zil: 3actions.zil:4132  <GLOBAL MAN-GONE>
# GLOBAL (state) MAN_GONE = False  ->  ZilGlobal.py

# zil: 3actions.zil:4134  <ROUTINE CLIFF-LEDGE-F (RARG)>
@ZG.routine('CLIFF-LEDGE-F')
def CLIFF_LEDGE_F(RARG):
    if ((RARG == ZG.M_BEG) and VERB_p('WALK') and IN_p(ZG.CHEST, ZG.WINNER) and ZG.CHEST_TIED):
        return TELL("You can't go anywhere holding that chest. The rope is tied around it!", CR)
    elif ((RARG == ZG.M_ENTER) and (not ZG.MAN_SEEN) and (not ZG.MAN_FLAG) and (not ZG.MAN_GONE)):
        if (not ZG.MAN_POINT):
            ZG.SCORE = (ZG.SCORE + 1)
            ZG.MAN_POINT = True
        return ENABLE(ZG.QUEUE(ZG.I_MAN_APPEARS, 5))
    elif (RARG == ZG.M_LOOK):
        TELL("This is a rock-strewn ledge near the base of a tall cliff. The bottom of the\ncliff is another fifteen feet below. You have little hope of climbing up the\ncliff face, but you might be able to scramble down from here (though it's\ndoubtful you could return).", CR)
        if ZG.ROPE_FLAG:
            TELL('A long piece of rope is dangling down from the top of the cliff and\nis within your reach.', CR)
        return True
    else:
        return False

# zil: 3actions.zil:4161  <ROUTINE CLIFF-F (RARG)>
@ZG.routine('CLIFF-F')
def CLIFF_F(RARG):
    if ((RARG == ZG.M_ENTER) and IN_p(ZG.CHEST, ZG.MAN)):
        ZG.QUEUE(ZG.I_MAN_RETURNS, 0)
        MOVE(ZG.CHEST, ZG.HERE)
        FSET(ZG.CHEST, Flag('OPENBIT'))
        ZG.ROPE_FLAG = True
        ZG.CHEST_TIED = False
        ZG.CHEST_OPENED = True
        return False
    elif (RARG == ZG.M_LOOK):
        TELL("This is a remarkable spot in the dungeon. Perhaps two hundred feet above\nyou is a gaping hole in the earth's surface through which pours bright\nsunshine! A few seedlings from the world above, nurtured by the sunlight\nand occasional rains, have grown into giant trees, making this a virtual oasis\nin the desert of the Underground Empire. To the west is a sheer precipice,\ndropping nearly fifty feet to jagged rocks below. The way south is barred by\na forbidding stone wall, crumbling from age. There is a jagged opening in the\nwall to the southwest, through which leaks a fine mist. The land to the east\nlooks lifeless and barren.", CR)
        if ZG.ROPE_FLAG:
            TELL('A rope is tied to one of the large trees here and is dangling over\nthe side of the cliff, reaching down to the shelf below.', CR)
        return True
    elif ((RARG == ZG.M_END) and ZG.PROB(15) and (not FSET_p(ZG.CLIFF_LEDGE, Flag('TOUCHBIT')))):
        return TELL('You catch, out of the corner of your eye, some movement among the\ntrees.', CR)
    elif ((RARG == ZG.M_END) and ZG.PROB(20)):
        return TELL('You seem to hear, from the southwest, the sounds of the sea.', CR)
    else:
        return False

# zil: 3actions.zil:4197  <ROUTINE GLOBAL-ROPE-F ()>
@ZG.routine('GLOBAL-ROPE-F')
def GLOBAL_ROPE_F():
    if (not ZG.ROPE_FLAG):
        return TELL("You can't see any rope here.", CR)
    elif VERB_p('CLIMB-FOO'):
        return ZG.V_CLIMB_UP('DOWN', True)
    elif VERB_p('TAKE', 'MOVE', 'CLIMB-ON'):
        if (not ZG.MAN_FLAG):
            return TELL('A short tug on the rope convinces you that it is securely fastened\nfrom above.', CR)
        elif IN_p(ZG.CHEST, ZG.MAN):
            ZG.HOLDING_ROPE = True
            return TELL('You grab securely on to the rope.', CR)
        else:
            return TELL('The man scowls. "I may help you up, but not before I have that chest." He\npoints to the chest near you on the ledge.', CR)
    elif VERB_p('CLIMB-UP'):
        return TELL('You try to climb the rope, but you cannot reach the top even with your best\neffort.', CR)
    elif VERB_p('TIE'):
        if (ZG.CHEST in (ZG.PRSO, ZG.PRSI)):
            TELL('The chest is now tied to the rope.', CR)
            ZG.CHEST_TIED = True
            if (ZG.MAN_FLAG and (not ZG.MAN_GONE)):
                TELL('The man above you looks pleased. "Now there\'s a good friend! Thank\nyou very much, indeed!" He pulls on the rope and the chest is lifted\nto the top of the cliff and out of sight. With a short laugh, he\ndisappears. "I\'ll be back in a short while!" are his last words.', CR)
                MOVE(ZG.CHEST, ZG.MAN)
                FSET(ZG.CHEST, Flag('TOUCHBIT'))
                ZG.CHEST_TIED = False
                ZG.ROPE_FLAG = False
                ENABLE(ZG.QUEUE(ZG.I_MAN_RETURNS, 10))
                ZG.MAN_FLAG = False
                return True
            return True
        elif (ZG.ME in (ZG.PRSI, ZG.PRSO)):
            if (ZG.MAN_FLAG and IN_p(ZG.CHEST, ZG.MAN)):
                return TELL('"Just grab onto it!", the man bellows.', CR)
            elif ZG.MAN_FLAG:
                return TELL('The man looks cross. "I want the chest, not you!" he snaps. "Now stop\nfooling around and pass it up!"', CR)
            else:
                return TELL("You're unable to tie the rope around yourself.", CR)
        else:
            return TELL("You're unable to tie the rope to that.", CR)
    elif VERB_p('UNTIE'):
        if ZG.CHEST_TIED:
            ZG.CHEST_TIED = False
            return TELL('The chest is now disconnected from the rope.', CR)
        else:
            return TELL("The rope isn't tied to anything.", CR)
    else:
        return False

# zil: 3actions.zil:4261  <GLOBAL CHEST-TIED>
# GLOBAL (state) CHEST_TIED = False  ->  ZilGlobal.py

# zil: 3actions.zil:4262  <GLOBAL HOLDING-ROPE>
# GLOBAL (state) HOLDING_ROPE = False  ->  ZilGlobal.py

# zil: 3actions.zil:4264  <ROUTINE I-MAN-RETURNS ()>
@ZG.routine('I-MAN-RETURNS')
def I_MAN_RETURNS():
    ZG.ROPE_FLAG = True
    if (ZG.HERE == ZG.CLIFF_LEDGE):
        TELL('A familiar voice calls down to you. "Are you still there?" he bellows with a\ncoarse laugh. "Well, then, grab onto the rope and we\'ll see what we can do."\nThe rope drops to within your reach.', CR)
        ZG.MAN_FLAG = True
        ENABLE(ZG.QUEUE(ZG.I_MAN_LIFT, -1))
        return True
    else:
        return False

# zil: 3actions.zil:4275  <GLOBAL LIFT-WAIT>
# GLOBAL (state) LIFT_WAIT = 0  ->  ZilGlobal.py

# zil: 3actions.zil:4277  <ROUTINE I-MAN-LIFT ()>
@ZG.routine('I-MAN-LIFT')
def I_MAN_LIFT():
    if (not (ZG.HERE == ZG.CLIFF_LEDGE)):
        ZG.QUEUE(ZG.I_MAN_LIFT, 0)
        MOVE(ZG.CHEST, ZG.CLIFF)
        FSET(ZG.CHEST, Flag('OPENBIT'))
        ZG.CHEST_OPENED = True
        REMOVE(ZG.MAN)
        return False
    elif ZG.HOLDING_ROPE:
        TELL('The man starts to heave on the rope and within a few moments you arrive at\nthe top of the cliff. The man removes the last few valuables from the chest\nand prepares to leave. "You\'ve been a good sport! Here, take this, for\nwhatever good it is! I can\'t see that I\'ll be needing one!" He hands you a\nplain wooden staff from the bottom of the chest and begins examining his\nvaluables.', CR)
        ZG.QUEUE(ZG.I_MAN_LIFT, 0)
        MOVE(ZG.STAFF, ZG.WINNER)
        ZG.HOLDING_ROPE = False
        ZG.ROPE_FLAG = True
        MOVE(ZG.WINNER, ZG.CLIFF)
        MOVE(ZG.CHEST, ZG.CLIFF)
        FSET(ZG.CHEST, Flag('OPENBIT'))
        TELL('The chest, open and empty, is at your feet.', CR)
        ZG.CHEST_OPENED = True
        MOVE(ZG.MAN, ZG.CLIFF)
        ENABLE(ZG.QUEUE(ZG.I_MAN_LEAVES, -1))
        return True
    elif (ZG._set('LIFT_WAIT', (ZG.LIFT_WAIT + 1)) > 4):
        TELL('"Well, I don\'t have all day. See you around sometime." Showering you with\ngravel, he disappears from sight.', CR)
        ZG.MAN_FLAG = False
        MOVE(ZG.CHEST, ZG.CLIFF)
        FSET(ZG.CHEST, Flag('OPENBIT'))
        ZG.CHEST_OPENED = True
        return ZG.QUEUE(ZG.I_MAN_LIFT, 0)
    else:
        return TELL('The man appears impatient. "Are you coming up then, or not?"', CR)

# zil: 3actions.zil:4319  <GLOBAL CHEST-OPENED>
# GLOBAL (state) CHEST_OPENED = False  ->  ZilGlobal.py

# zil: 3actions.zil:4321  <ROUTINE CHEST-F ()>
@ZG.routine('CHEST-F')
def CHEST_F():
    if ZG.CHEST_OPENED:
        if (VERB_p('TIE') and (ZG.ROPE in (ZG.PRSO, ZG.PRSI))):
            return TELL("What's the point?", CR)
        elif (VERB_p('PUT') and (ZG.PRSO in (ZG.STAFF, ZG.LAMP, ZG.TORCH))):
            TELL("It doesn't fit.")
            if (ZG.PRSO == ZG.STAFF):
                TELL(" Awfully peculiar, though, since it's where the staff came from.")
            return CRLF()
        else:
            return False
    elif VERB_p('OPEN', 'UNLOCK'):
        if ZG.MAN_FLAG:
            return TELL('The man calls down to you. "Is this what you\'re looking for?" he cackles,\nwaving a small key over his head. You try to open the chest, but it is\nlocked.', CR)
        else:
            return TELL('The chest is locked and cannot be opened.', CR)
    else:
        return False

# zil: 3actions.zil:4342  <GLOBAL ROPE-FLAG>
# GLOBAL (state) ROPE_FLAG = True  ->  ZilGlobal.py

# zil: 3actions.zil:4344  <ROUTINE I-MAN-LEAVES ()>
@ZG.routine('I-MAN-LEAVES')
def I_MAN_LEAVES():
    if (not (ZG.HERE == ZG.CLIFF)):
        REMOVE(ZG.MAN)
        ZG.MAN_GONE = True
        ZG.MAN_FLAG = False
        ZG.ROPE_FLAG = True
        ZG.QUEUE(ZG.I_MAN_LEAVES, 0)
        return False
    elif ZG.PROB(40):
        TELL('Your "friend", moving quickly, dodges behind some trees and is lost from\nsight.', CR)
        REMOVE(ZG.MAN)
        ZG.MAN_FLAG = False
        ZG.MAN_GONE = True
        ZG.ROPE_FLAG = True
        ZG.QUEUE(ZG.I_MAN_LEAVES, 0)
        return True
    else:
        return TELL('Your "friend" examines his valuables with great pride.', CR)

# zil: 3actions.zil:4366  <ROUTINE MAN-F ()>
@ZG.routine('MAN-F')
def MAN_F():
    if VERB_p('HELLO'):
        return TELL('He responds cheerfully. "It is a wonderful day, isn\'t it?"', CR)
    elif ZG.HELLO_p(ZG.MAN):
        return TELL("The man is thoroughly engrossed in the examination of his booty and\ndoesn't seem to hear you.", CR)
    elif VERB_p('EXAMINE'):
        return TELL("The man is stocky and of medium height, with several days' growth of stubble\non his face. He is carrying a number of valuables under his arm, presumably\nfrom the now-open chest.", CR)
    elif VERB_p('ATTACK'):
        if (ZG.PRSI == ZG.SWORD):
            TELL('The man is taken by surprise and is hit with the sword. He grabs you\nand throws you to the ground')
            if (LOC(ZG.STAFF) in (ZG.WINNER, ZG.HERE)):
                TELL(', breaking the staff in the process')
                REMOVE(ZG.STAFF)
                MOVE(ZG.BROKEN_STAFF, ZG.HERE)
            TELL(', but you\nfinish him off with a quick thrust to the chest. He dies, and disappears\nwithout ceremony in the usual style of the Great Underground Empire.\nHis assorted valuables remain behind.', CR)
            REMOVE(ZG.MAN)
            MOVE(ZG.VALUABLES, ZG.HERE)
            FCLEAR(ZG.VALUABLES, Flag('NDESCBIT'))
            ZG.QUEUE(ZG.I_MAN_LEAVES, 0)
            ZG.MAN_GONE = True
            return ZG.MAN_GONE
        else:
            return TELL("You wouldn't hurt him with that!", CR)
    else:
        return False

# zil: 3actions.zil:4399  <ROUTINE VALUABLES-F ()>
@ZG.routine('VALUABLES-F')
def VALUABLES_F():
    if (VERB_p('TAKE', 'PUT', 'MOVE') and IN_p(ZG.MAN, ZG.CLIFF)):
        return TELL('The man recoils sharply. "These here things are mine. It\'s my chest and\nthey\'re my valuables. You\'ve a lot of nerve trying to take them from me\nafter me saving you like that!"', CR)
    elif (ZG.MAN_GONE and IN_p(ZG.VALUABLES, ZG.MAN)):
        return TELL('What valuables?', CR)
    else:
        return False

# zil: 3actions.zil:4409  <ROUTINE ROPE-F ()>
@ZG.routine('ROPE-F')
def ROPE_F():
    if VERB_p('TAKE', 'MOVE'):
        if ZG.ROPE_FLAG:
            return TELL('The rope is tied to a tree.', CR)
        else:
            return False
    elif VERB_p('CLIMB-FOO'):
        return ZG.V_CLIMB_UP('DOWN', True)
    elif VERB_p('BURN'):
        return TELL("The rope won't catch fire.", CR)
    elif VERB_p('UNTIE'):
        return TELL('The rope is very securely tied and cannot be undone.', CR)
    elif (VERB_p('CUT') and (ZG.PRSI == ZG.SWORD)):
        return TELL("The rope is made of pretty tough stuff and won't cut.", CR)
    else:
        return False

# zil: 3actions.zil:4426  <ROUTINE GLOBAL-MAN-F ()>
@ZG.routine('GLOBAL-MAN-F')
def GLOBAL_MAN_F():
    if (ZG.HERE == ZG.CLIFF):
        if ZG.MAN_GONE:
            return TELL("You've lost him among the trees.", CR)
        else:
            return TELL("You can't see any man here.", CR)
    elif (not ZG.MAN_FLAG):
        return TELL("You can't see any man here.", CR)
    elif VERB_p('GIVE'):
        return TELL("You aren't even close to him!", CR)
    elif VERB_p('HELLO'):
        return TELL('The man waves back in a friendly way.', CR)
    elif ZG.HELLO_p(ZG.GLOBAL_MAN):
        TELL('He yells back, "What\'s that you say? I can\'t hear you very well.')
        if (not ZG.CHEST_LIFTED):
            TELL(' Just tie the rope to the chest and we can chat afterwards!" He smiles\nbroadly.')
        else:
            TELL('"')
        return CRLF()
    elif VERB_p('ATTACK', 'MUNG'):
        return TELL("It's unlikely you'll succeed at this distance.", CR)
    elif (VERB_p('THROW') and (ZG.PRSI == ZG.GLOBAL_MAN) and IN_p(ZG.PRSO, ZG.WINNER)):
        TELL('The ', D, ZG.PRSO, ' flies upward, but not nearly far enough to hit the man. It\ndoes seem to amuse him, however, especially as it passes within inches of\nyour head. "We\'re wasting time now. Be a good fellow and tie the rope!"', CR)
        return MOVE(ZG.PRSO, ZG.HERE)
    else:
        return False

# zil: 3actions.zil:4462  <ROUTINE LAKE-F ()>
@ZG.routine('LAKE-F')
def LAKE_F():
    if VERB_p('THROUGH', 'LEAP', 'BOARD'):
        if (ZG.HERE in (ZG.LAKE_SHORE, ZG.FAR_SHORE, ZG.SOUTH_SHORE)):
            return ZG.GO_ON_LAKE()
        elif (ZG.HERE == ZG.ON_LAKE):
            return ZG.GOTO(ZG.IN_LAKE)
        else:
            return TELL('Just where do you think you are?', CR)
    elif VERB_p('LOOK-UNDER'):
        if (ZG.HERE == ZG.ON_LAKE):
            return TELL("You can't quite make out the bottom of the lake from here...", CR)
        else:
            return TELL("You can't see under the surface from here.", CR)
    else:
        return False

# zil: 3actions.zil:4477  <ROUTINE IN-LAKE-F (RARG)>
@ZG.routine('IN-LAKE-F')
def IN_LAKE_F(RARG):
    if (RARG == ZG.M_ENTER):
        return ENABLE(ZG.QUEUE(ZG.I_IN_LAKE, 3))
    elif ((RARG == ZG.M_BEG) and VERB_p('TAKE') and (not (ZG.PRSO == ZG.SHINY_OBJECT))):
        if (ZG.WEIGHT(ZG.WINNER) > 25):
            return TELL("You can't carry that much underwater.", CR)
        elif (not FSET_p(ZG.PRSO, Flag('TAKEBIT'))):
            return TELL("You can't take that!", CR)
        elif ZG.PROB(30):
            return TELL('The ', D, ZG.PRSO, ' is yours for a moment, but drops from your grasp.', CR)
        else:
            return False
    elif (RARG == ZG.M_END):
        if ZG.PROB(10):
            return TELL('A large and hungry-looking fish is swimming in the neighborhood.', CR)
        elif (ZG.PROB(4) and (not ZG.INVIS)):
            ZG.QUEUE(ZG.I_ROC, 0)
            ZG.QUEUE(ZG.I_ON_LAKE, 0)
            return ZG.JIGS_UP('Oh, no! A tremendous fish just swallowed you whole!')
        elif IN_p(ZG.SHINY_OBJECT, ZG.HERE):
            if (ZG.MOVES == ZG.LAST_MOVES):
                return True
            elif ZG.PROB(40):
                TELL('Out of the corner of your eye, a small, shiny object appears in the\nsand. A moment later, it is gone!', CR)
            elif ZG.PROB(70):
                TELL('You catch a brief glimpse of something shiny in the sand.', CR)
            else:
                TELL('Something sparkling in the sand catches your eye for a moment.', CR)
            ZG.LAST_MOVES = ZG.MOVES
            return ZG.LAST_MOVES
        else:
            return False
    else:
        return False

# zil: 3actions.zil:4513  <GLOBAL LAST-MOVES>
# GLOBAL (state) LAST_MOVES = 0  ->  ZilGlobal.py

# zil: 3actions.zil:4515  <ROUTINE I-IN-LAKE ()>
@ZG.routine('I-IN-LAKE')
def I_IN_LAKE():
    if (ZG.HERE == ZG.IN_LAKE):
        TELL('You run out of air and return to the surface.', CR)
        return ZG.GOTO(ZG.ON_LAKE)
    else:
        return False

# zil: 3actions.zil:4521  <GLOBAL LAKE-POINT>
# GLOBAL (state) LAKE_POINT = False  ->  ZilGlobal.py

# zil: 3actions.zil:4523  <ROUTINE ON-LAKE-F (RARG)>
@ZG.routine('ON-LAKE-F')
def ON_LAKE_F(RARG):
    if (RARG == ZG.M_ENTER):
        ZG.QUEUE(ZG.I_IN_LAKE, 0)
        if (not ZG.LAKE_POINT):
            ZG.SCORE = (ZG.SCORE + 1)
            ZG.LAKE_POINT = True
            return ZG.LAKE_POINT
        else:
            return False
    elif ((RARG == ZG.M_BEG) and VERB_p('LEAP') and (not ZG.PRSO)):
        ZG.DO_WALK('DOWN')
        return True
    else:
        return False

# zil: 3actions.zil:4533  <GLOBAL CURRENT-LAMP>
# GLOBAL (state) CURRENT_LAMP = ZG.LAMP  ->  ZilGlobal.py

# zil: 3actions.zil:4535  <ROUTINE GO-ON-LAKE ("AUX" F N (TOLD <>))>
@ZG.routine('GO-ON-LAKE')
def GO_ON_LAKE():
    F = 0
    N_l = 0
    TOLD = False
    if (F := FIRST_p(ZG.WINNER)):
        while True:
            N_l = NEXT_p(F)
            if (not FSET_p(F, Flag('WEARBIT'))):
                MOVE(F, ZG.IN_LAKE)
                if (F == ZG.TORCH):
                    REMOVE(ZG.TORCH)
                    MOVE(ZG.FRIED_TORCH, ZG.IN_LAKE)
                elif (F == ZG.LAMP):
                    MOVE(ZG.LAMP, ZG.LOCAL_GLOBALS)
                    MOVE(ZG.FRIED_LAMP, ZG.IN_LAKE)
                    ZG.CURRENT_LAMP = ZG.FRIED_LAMP
                elif (F == ZG.WAYBREAD):
                    REMOVE(ZG.WAYBREAD)
                if (not TOLD):
                    TOLD = True
                    TELL('The shock of entering the frigid water has made you drop all your\npossessions into the lake!', CR)
            if (not N_l):
                break
            else:
                F = N_l
    if (not TOLD):
        TELL('You are nearly paralyzed by the icy waters as you swim into the\ncenter of the lake.', CR)
    CRLF()
    ZG.GOTO(ZG.ON_LAKE)
    ZG.LAKE_TIME = 0
    return ENABLE(ZG.QUEUE(ZG.I_ON_LAKE, -1))

# zil: 3actions.zil:4566  <GLOBAL LAKE-TIME>
# GLOBAL (state) LAKE_TIME = False  ->  ZilGlobal.py

# zil: 3actions.zil:4568  <ROUTINE I-ON-LAKE ()>
@ZG.routine('I-ON-LAKE')
def I_ON_LAKE():
    ZG.LAKE_TIME = (ZG.LAKE_TIME + 1)
    if (ZG.PROB(10) and (ZG.HERE == ZG.ON_LAKE) and (not ZG.INVIS)):
        TELL('A giant roc, previously hidden among the rocks, is heading right toward you,\nits mouth gaping wide!', CR)
        return ENABLE(ZG.QUEUE(ZG.I_ROC, 2))
    elif (not (ZG.HERE in (ZG.ON_LAKE, ZG.IN_LAKE))):
        ZG.QUEUE(ZG.I_ON_LAKE, 0)
        ZG.QUEUE(ZG.I_IN_LAKE, 0)
        ZG.QUEUE(ZG.I_ROC, 0)
        return False
    elif (ZG.LAKE_TIME == 4):
        return TELL('The icy waters are taking their toll. You will not be able to hold out\nmuch longer.', CR)
    elif (ZG.LAKE_TIME == 6):
        return TELL('You are becoming very weak. You had better leave the water before you\ndrown!', CR)
    elif (ZG.LAKE_TIME == 8):
        ZG.QUEUE(ZG.I_ON_LAKE, 0)
        ZG.QUEUE(ZG.I_IN_LAKE, 0)
        ZG.QUEUE(ZG.I_ROC, 0)
        return ZG.JIGS_UP('Your strength gives out, and you drown in the frigid waters.')
    else:
        return False

# zil: 3actions.zil:4595  <ROUTINE I-ROC ()>
@ZG.routine('I-ROC')
def I_ROC():
    if ((ZG.HERE == ZG.ON_LAKE) and (not ZG.INVIS)):
        ZG.QUEUE(ZG.I_ON_LAKE, 0)
        ZG.QUEUE(ZG.I_IN_LAKE, 0)
        return ZG.JIGS_UP('The roc snatches you in its jaws and has you for lunch.')
    else:
        return False

# zil: 3actions.zil:4602  <ROUTINE SHINY-OBJECT-F ()>
@ZG.routine('SHINY-OBJECT-F')
def SHINY_OBJECT_F():
    if (VERB_p('TAKE', 'FIND') and (not IN_p(ZG.AMULET, ZG.WINNER))):
        if ZG.PROB(50):
            REMOVE(ZG.SHINY_OBJECT)
            MOVE(ZG.AMULET, ZG.WINNER)
            ZG.THIS_IS_IT(ZG.AMULET)
            FCLEAR(ZG.AMULET, Flag('NDESCBIT'))
            return TELL('You reach the shiny object. It is a simple golden amulet!', CR)
        else:
            return TELL('The shiny object slips from your grasp and back onto the floor of\nthe lake, where it is covered in sand.', CR)
    else:
        return False

# zil: 3actions.zil:4616  <ROUTINE SAND-F ()>
@ZG.routine('SAND-F')
def SAND_F():
    if VERB_p('DIG'):
        return TELL("You don't come across anything unusual.", CR)
    elif VERB_p('EXAMINE'):
        return TELL('There is nothing notable on the floor of the lake, except some plants\nand algae.', CR)
    elif VERB_p('TAKE'):
        return TELL('It slips through your fingers.', CR)
    else:
        return False

# zil: 3actions.zil:4626  <ROUTINE ALGAE-F ()>
@ZG.routine('ALGAE-F')
def ALGAE_F():
    if VERB_p('EAT'):
        return TELL('Yeecchhhh!', CR)
    else:
        return False

# zil: 3actions.zil:4629  <ROUTINE FRIED-LAMP-F ()>
@ZG.routine('FRIED-LAMP-F')
def FRIED_LAMP_F():
    if VERB_p('LAMP-ON'):
        return TELL("The lamp isn't functioning (probably from having gotten wet).", CR)
    else:
        return False

# zil: 3actions.zil:4634  <GLOBAL VIEW-POINT>
# GLOBAL (state) VIEW_POINT = 1  ->  ZilGlobal.py

# zil: 3actions.zil:4636  <ROUTINE I-VIEW-SNAP ()>
@ZG.routine('I-VIEW-SNAP')
def I_VIEW_SNAP():
    TELL('You suddenly find yourself back in the viewing room!', CR)
    ZG.GOTO(ZG.VIEW_ROOM, False)
    return True

# zil: 3actions.zil:4641  <ROUTINE VIEWING-TABLE-F ("AUX" L)>
@ZG.routine('VIEWING-TABLE-F')
def VIEWING_TABLE_F():
    L = 0
    if VERB_p('RUB'):
        ZG.SCORE = (ZG.SCORE + ZG.VIEW_POINT)
        ZG.VIEW_POINT = 0
        TELL('You touch the table and are instantly transported to another place!', CR)
        CRLF()
        ENABLE(ZG.QUEUE(ZG.I_VIEW_SNAP, 3))
        ZG.GOTO(GET(ZG.VIEW_ROOMS, ZG.ACTIVE_VIEW))
        return True
    elif VERB_p('EXAMINE', 'LOOK-INSIDE'):
        TELL('The surface is pale and featureless, but slowly, an image takes shape!', CR)
        TELL(GET(ZG.VIEWS, ZG.ACTIVE_VIEW), CR)
        return TELL('The image slowly fades.', CR)
    else:
        return False

# zil: 3actions.zil:4658  <ROUTINE I-VIEW-CHANGE ()>
@ZG.routine('I-VIEW-CHANGE')
def I_VIEW_CHANGE():
    ZG.ACTIVE_VIEW = (ZG.ACTIVE_VIEW + 1)
    if (ZG.ACTIVE_VIEW == 5):
        ZG.ACTIVE_VIEW = 1
    ZG.QUEUE(ZG.I_VIEW_CHANGE, 4)
    if (ZG.HERE == ZG.VIEW_ROOM):
        TELL('The indicator above the table flickers briefly, then changes to "')
        return TELL(GET(ZG.VIEW_ROMANS, ZG.ACTIVE_VIEW), '".', CR)
    else:
        return False

# zil: 3actions.zil:4667  <ROUTINE VIEW-ROOM-F (RARG)>
@ZG.routine('VIEW-ROOM-F')
def VIEW_ROOM_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a small chamber carved in the rock, with the sole exit to the\nnorth. Mounted on one wall is a table labelled "Scenic Vista," whose\nfeatureless surface is angled toward you. One might believe that the table\nwas used to indicate points of interest in the view from this spot, like those\nfound in many parks. On the other hand, your surroundings are far from\nspacious and by no stretch of the imagination could this spot be considered\nscenic. An indicator above the table reads "')
        return TELL(GET(ZG.VIEW_ROMANS, ZG.ACTIVE_VIEW), '".', CR)
    else:
        return False

# zil: 3actions.zil:4679  <GLOBAL VIEW-ROMANS>
# GLOBAL (state) VIEW_ROMANS = TABLE(0, 'I', 'II', 'III', 'IV')  ->  ZilGlobal.py

# zil: 3actions.zil:4681  <GLOBAL ACTIVE-VIEW>
# GLOBAL (state) ACTIVE_VIEW = 1  ->  ZilGlobal.py

# zil: 3actions.zil:4683  <GLOBAL VIEW-ROOMS>
# GLOBAL (state) VIEW_ROOMS = LTABLE(ZG.TIMBER_ROOM, ZG.ROOM_8, ZG.DAMP_PASSAGE, ZG.ZORK_IV)  ->  ZilGlobal.py

# zil: 3actions.zil:4685  <GLOBAL VIEWS>
# GLOBAL (state) VIEWS = LTABLE('You see a passage cluttered with broken timbers. An extremely narrow opening\ncan be seen at the end of the room.', 'You see a tiny room with rough walls. Chiseled crudely on one wall is the\nnumber "8". The only apparent exit seems to be a blur.', 'You see a wide room with two nearly identical passages leading east and\nnortheast. A wide channel descends steeply into the room and seems to be\nblocked by rubble.', 'You see the interior of a huge temple rudely constructed of basalt blocks.\nFlickering torches cast a sallow illumination over an altar still wet with the\nblood of human sacrifice, its velvet covers stained and encrusted with gore.')  ->  ZilGlobal.py

# zil: 3actions.zil:4697  <ROUTINE CLIFF-OBJECT-F ()>
@ZG.routine('CLIFF-OBJECT-F')
def CLIFF_OBJECT_F():
    if (ZG.HERE == ZG.CLIFF):
        if VERB_p('LEAP'):
            return ZG.JIGS_UP('You should have looked before you leaped.')
        elif VERB_p('CLIMB-DOWN'):
            if ZG.ROPE_FLAG:
                ZG.GOTO(ZG.CLIFF_LEDGE)
                return True
            else:
                return TELL('The fall would kill you.', CR)
        elif (VERB_p('THROW-OFF') and (ZG.PRSI == ZG.CLIFF_OBJECT)):
            if (ZG.PRSO == ZG.ROPE):
                TELL('The rope is dangling over the side of the cliff already.', CR)
                return True
            elif (not IN_p(ZG.PRSO, ZG.WINNER)):
                TELL("You aren't holding the ", D, ZG.PRSO, '.', CR)
                return True
            MOVE(ZG.PRSO, ZG.CLIFF_LEDGE)
            TELL('The ', D, ZG.PRSO, ' goes over the cliff and lands among the rocks below.', CR)
            if (ZG.PRSO == ZG.LAMP):
                REMOVE(ZG.PRSO)
                MOVE(ZG.BROKEN_LAMP, ZG.CLIFF_LEDGE)
                ZG.CURRENT_LAMP = ZG.BROKEN_LAMP
            elif (ZG.PRSO == ZG.STAFF):
                REMOVE(ZG.PRSO)
                MOVE(ZG.BROKEN_STAFF, ZG.CLIFF_LEDGE)
            return True
        else:
            return False
    elif VERB_p('CLIMB-UP'):
        return TELL("You haven't enough strength to climb the cliff.", CR)
    else:
        return TELL('The cliff is above you!', CR)

# zil: 3actions.zil:4731  <ROUTINE TREE-F ()>
@ZG.routine('TREE-F')
def TREE_F():
    if VERB_p('CLIMB-UP', 'CLIMB-FOO'):
        return TELL('The trunks are too large for you to climb them.', CR)
    elif (VERB_p('EXAMINE', 'LOOK-INSIDE') and (not ZG.MAN_SEEN)):
        return TELL("There seems to be nobody there, but it's hard to tell.", CR)
    elif VERB_p('BURN'):
        return ZG.JIGS_UP('Smokey the Bear puts out both the fire and you.')
    else:
        return False

# zil: 3actions.zil:4741  <ROUTINE FRIED-TORCH-F ()>
@ZG.routine('FRIED-TORCH-F')
def FRIED_TORCH_F():
    if VERB_p('LAMP-ON'):
        return TELL("It's hopeless. The torch is wet.", CR)
    else:
        return False

# zil: 3actions.zil:4745  <ROUTINE TORCH-F ()>
@ZG.routine('TORCH-F')
def TORCH_F():
    if VERB_p('LAMP-ON'):
        if FSET_p(ZG.TORCH, Flag('ONBIT')):
            return TELL("It's already lit.", CR)
        else:
            return TELL('You have nothing to light it with.', CR)
    elif VERB_p('LAMP-OFF'):
        if FSET_p(ZG.TORCH, Flag('ONBIT')):
            TELL('You manage to extinguish the flame.', CR)
            return FCLEAR(ZG.TORCH, Flag('ONBIT'))
        else:
            return TELL('It has already been extinguished.', CR)
    else:
        return False

# ;"Here's some ZORK I"

# zil: 3actions.zil:4757  <OBJECT TIMBERS>
ZG.world.declare_object('TIMBERS', 'TIMBERS', lambda: {
    'LOC': ZG.TIMBER_ROOM,
    'SYNONYM': ('TIMBERS', 'PILE'),
    'ADJECTIVE': ('WOODEN', 'BROKEN'),
    'DESC': 'broken timber',
    'FLAGS': 'TAKEBIT',
    'SIZE': 50,
})

# zil: 3actions.zil:4765  <ROOM LADDER-TOP>
ZG.world.declare_object('LADDER_TOP', 'LADDER-TOP', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a very small room. In the corner is a rickety wooden\nladder, leading downward. It might be safe to descend. There is\nalso a staircase leading upward.',
    'DESC': 'Ladder Top',
    'DOWN': ('TO', ZG.LADDER_BOTTOM),
    'FLAGS': 'RLANDBIT',
    'GLOBAL': (ZG.LADDER, ZG.STAIRS),
})

# zil: 3actions.zil:4776  <OBJECT LADDER>
ZG.world.declare_object('LADDER', 'LADDER', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'LADDER',
    'ADJECTIVE': ('WOODEN', 'RICKETY', 'NARROW'),
    'DESC': 'wooden ladder',
    'FLAGS': ('NDESCBIT', 'CLIMBBIT'),
})

# zil: 3actions.zil:4783  <ROOM LADDER-BOTTOM>
ZG.world.declare_object('LADDER_BOTTOM', 'LADDER-BOTTOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a rather wide room. On one side is the bottom of a\nnarrow wooden ladder. To the west and the south are passages\nleaving the room.',
    'DESC': 'Ladder Bottom',
    'SOUTH': ('TO', ZG.DEAD_END_5),
    'WEST': ('TO', ZG.TIMBER_ROOM),
    'UP': ('TO', ZG.LADDER_TOP),
    'FLAGS': 'RLANDBIT',
    'GLOBAL': ZG.LADDER,
})

# zil: 3actions.zil:4796  <ROOM DEAD-END-5>
ZG.world.declare_object('DEAD_END_5', 'DEAD-END-5', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Dead End',
    'LDESC': 'You have come to a dead end in the mine.\nThere is a small pile of coal here.',
    'NORTH': ('TO', ZG.LADDER_BOTTOM),
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:4804  <ROOM TIMBER-ROOM>
ZG.world.declare_object('TIMBER_ROOM', 'TIMBER-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a long and narrow passage, which is cluttered with broken\ntimbers. A wide passage comes from the east and turns at the\nwest end of the room into a very narrow passageway. From the west\ncomes a strong draft.',
    'DESC': 'Timber Room',
    'EAST': ('TO', ZG.LADDER_BOTTOM),
    'WEST': ('TO', ZG.LOWER_SHAFT, 'IF', 'EMPTY_HANDED', 'ELSE', 'You cannot fit through this passage with that load.'),
    'ACTION': ZG.NO_OBJS,
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:4819  <ROOM LOWER-SHAFT>
ZG.world.declare_object('LOWER_SHAFT', 'LOWER-SHAFT', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Drafty Room',
    'SOUTH': ('TO', ZG.MACHINE_ROOM),
    'OUT': ('TO', ZG.TIMBER_ROOM),
    'EAST': ('TO', ZG.TIMBER_ROOM),
    'ACTION': ZG.NO_OBJS,
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:4828  <ROOM MACHINE-ROOM>
ZG.world.declare_object('MACHINE_ROOM', 'MACHINE-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Machine Room',
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:4833  <GLOBAL EMPTY-HANDED>
# GLOBAL (state) EMPTY_HANDED = False  ->  ZilGlobal.py

# zil: 3actions.zil:4835  <ROUTINE NO-OBJS (RARG "AUX" F)>
@ZG.routine('NO-OBJS')
def NO_OBJS(RARG):
    F = 0
    if (RARG == ZG.M_BEG):
        F = FIRST_p(ZG.WINNER)
        ZG.EMPTY_HANDED = True
        while True:
            if (not F):
                break
            elif (ZG.WEIGHT(F) > 4):
                ZG.EMPTY_HANDED = False
                break
            F = NEXT_p(F)
        return False
    else:
        return False

# ;"Stuff from ZORK II"

# zil: 3actions.zil:4849  <ROOM ROOM-8>
ZG.world.declare_object('ROOM_8', 'ROOM-8', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a small chamber carved out of the rock at the end of a short crawl.\nOn the wall is crudely chiseled the number "8". The only apparent exit,\nto the east, seems to be a blur and a loud, whirring sound resounds through\nthe rock.',
    'DESC': 'Room 8',
    'FLAGS': 'RLANDBIT',
    'EAST': 'You are repelled from the exit by a fierce wind.',
})

# zil: 3actions.zil:4860  <OBJECT REPELLENT>
ZG.world.declare_object('REPELLENT', 'REPELLENT', lambda: {
    'LOC': ZG.ROOM_8,
    'SYNONYM': ('REPELLENT', 'CAN'),
    'ADJECTIVE': ('GRUE', 'MAGIC'),
    'DESC': 'Frobozz Magic Grue Repellent',
    'FLAGS': ('TAKEBIT', 'READBIT'),
    'ACTION': ZG.REPELLENT_FCN,
    'FDESC': 'A spray can is in the corner. In large type is the legend "Frobozz Magic\nGrue Repellent."',
    'TEXT': '!!! FROBOZZ MAGIC GRUE REPELLENT !!!\n\nInstructions for use: Apply liberally to creature to be protected.\nDuration of effect is unpredictable. Use only in place of death!\n\n(No warranty expressed or implied)',
})

# zil: 3actions.zil:4878  <ROUTINE REPELLENT-FCN ()>
@ZG.routine('REPELLENT-FCN')
def REPELLENT_FCN():
    if VERB_p('SHAKE'):
        if ZG.SPRAY_USED_p:
            return TELL('The can seems empty.', CR)
        else:
            return TELL('There is a sloshing sound from inside.', CR)
    elif VERB_p('BURN'):
        return ZG.JIGS_UP('The can explodes and you die a horribly smelly death.')
    elif (VERB_p('SPRAY', 'PUT-ON') and (ZG.PRSO == ZG.REPELLENT)):
        if ZG.SPRAY_USED_p:
            return TELL('The repellent is all gone.', CR)
        elif (not ZG.PRSI):
            ZG.SPRAY_USED_p = True
            return TELL('The spray stinks amazingly for a few moments, then drifts away.', CR)
        else:
            if (ZG.PRSI == ZG.ME):
                ENABLE(ZG.QUEUE(ZG.I_SPRAY, 5))
                ZG.SPRAYED_p = True
            ZG.SPRAY_USED_p = True
            return TELL("The spray smells like a mixture of old socks and burning rubber. If\nI were a grue I'd sure stay clear!", CR)
    else:
        return False

# zil: 3actions.zil:4902  <GLOBAL SPRAY-USED?>
# GLOBAL (state) SPRAY_USED_p = False  ->  ZilGlobal.py

# zil: 3actions.zil:4904  <ROUTINE I-SPRAY ()>
@ZG.routine('I-SPRAY')
def I_SPRAY():
    ZG.SPRAYED_p = False
    return TELL('That horrible smell is much less pungent now.', CR)

# ;"Stuff from ZORK IV"

# zil: 3actions.zil:4910  <ROOM ZORK-IV>
ZG.world.declare_object('ZORK_IV', 'ZORK-IV', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Sacrificial Altar',
    'FLAGS': ('ONBIT', 'RLANDBIT'),
    'ACTION': ZG.ZORK_IV_F,
})

# zil: 3actions.zil:4916  <ROUTINE ZORK-IV-F (RARG)>
@ZG.routine('ZORK-IV-F')
def ZORK_IV_F(RARG):
    if (RARG == ZG.M_ENTER):
        return ZG.JIGS_UP('Sacrificial Altar\nThis is the interior of a huge temple of primitive construction. A few\nflickering torches cast a sallow illumination over the altar, which is\nstill drenched with the blood of human sacrifice. Behind the altar is an\nenormous statue of a demon which seems to reach towards you with\ndripping fangs and razor-sharp talons. A low noise begins behind you,\nand you turn to see hundreds of hunched and hairy shapes. A guttural\nchant issues from their throats. Near you stands a figure draped in a\nrobe of deepest black, brandishing a huge sword. The chant grows louder\nas the robed figure approaches the altar. The large figure spots you and\napproaches menacingly. It reaches into its cloak and pulls out a great,\nglowing dagger. It pulls you onto the altar and, with a murmur of\napproval from the throng, slices you neatly across your abdomen.')
    else:
        return False

# ;"Last Section"

# zil: 3actions.zil:4935  <ROOM SOUTH-SHORE>
ZG.world.declare_object('SOUTH_SHORE', 'SOUTH-SHORE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Southern Shore',
    'LDESC': 'You are on the south shore of the lake. Rock formations prevent\nmovement to the west and thickening swamp to the east makes the going\nall but impossible. To the south, where the beach meets a rock\nformation, you can make out a dark passage sloping steeply upward into the\nrock.',
    'EAST': 'The swamp is too thick.',
    'UP': ('TO', ZG.DARK_1),
    'NORTH': 'If you want to go into the lake, you should say so.',
    'SOUTH': ('TO', ZG.DARK_1),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': ZG.LAKE,
    'PSEUDO': ('BEACH', ZG.SHORE_PSEUDO, 'SWAMP', ZG.SWAMP_PSEUDO),
})

# zil: 3actions.zil:4952  <ROOM DARK-1>
ZG.world.declare_object('DARK_1', 'DARK-1', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Dark Place',
    'NORTH': ('TO', ZG.SOUTH_SHORE),
    'SOUTH': ('TO', ZG.DARK_2),
    'UP': ('TO', ZG.DARK_2),
    'DOWN': ('TO', ZG.SOUTH_SHORE),
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:4961  <ROOM DARK-2>
ZG.world.declare_object('DARK_2', 'DARK-2', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Dark Place',
    'NORTH': ('TO', ZG.DARK_1),
    'EAST': ('TO', ZG.KEY_ROOM),
    'UP': ('TO', ZG.KEY_ROOM),
    'DOWN': ('TO', ZG.DARK_1),
    'FLAGS': 'RLANDBIT',
})

# zil: 3actions.zil:4970  <ROOM KEY-ROOM>
ZG.world.declare_object('KEY_ROOM', 'KEY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Key Room',
    'WEST': ('TO', ZG.DARK_2),
    'DOWN': ('TO', ZG.AQ_1, 'IF', 'COVER_MOVED', 'ELSE', "You can't walk through a piece of metal."),
    'ACTION': ZG.KEY_ROOM_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 3actions.zil:4979  <ROOM AQ-1>
ZG.world.declare_object('AQ_1', 'AQ-1', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Aqueduct',
    'UP': 'The hole is too far above your head.',
    'LDESC': 'You are in a wide stone channel, part of the water supply system for the\nGreat Underground Empire. The source of water was a waterfall to the south,\nwhich has long since dried up. Water flowed along the aqueduct to the north.\nThis region is lit from above, although the source of light is not apparent.',
    'SOUTH': "You can't climb the dried-up waterfall.",
    'NORTH': ('TO', ZG.AQ_2),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.AQUEDUCT, ZG.WATER_CHANNEL, ZG.MOSS),
    'PSEUDO': ('WATERF', ZG.WATERFALL_PSEUDO),
})

# zil: 3actions.zil:4994  <ROOM AQ-2>
ZG.world.declare_object('AQ_2', 'AQ-2', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'High Arch',
    'NORTH': ('TO', ZG.AQ_3, 'IF', 'AQ_FLAG', 'ELSE', 'The arch before you is broken.'),
    'SOUTH': ('TO', ZG.AQ_1),
    'DOWN': "It's a long way down....",
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.AQ_2_F,
    'GLOBAL': (ZG.AQUEDUCT, ZG.WATER_CHANNEL, ZG.MOSS),
    'PSEUDO': ('ARCH', ZG.ARCH_PSEUDO),
})

# zil: 3actions.zil:5005  <ROOM AQ-3>
ZG.world.declare_object('AQ_3', 'AQ-3', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Water Slide',
    'NORTH': ('TO', ZG.DAMP_PASSAGE),
    'DOWN': ('TO', ZG.DAMP_PASSAGE),
    'SOUTH': ('TO', ZG.AQ_2, 'IF', 'AQ_FLAG', 'ELSE', 'The arch to the south is broken.'),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.AQ_3_F,
    'GLOBAL': (ZG.AQUEDUCT, ZG.WATER_CHANNEL, ZG.MOSS),
    'PSEUDO': ('ARCH', ZG.ARCH_PSEUDO),
})

# zil: 3actions.zil:5016  <OBJECT AQUEDUCT>
ZG.world.declare_object('AQUEDUCT', 'AQUEDUCT', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'aqueduct',
    'SYNONYM': ('AQUEDUCT', 'DUCT', 'CHASM'),
    'ADJECTIVE': 'STONE',
    'ACTION': ZG.AQUEDUCT_F,
})

# zil: 3actions.zil:5023  <OBJECT WATER-CHANNEL>
ZG.world.declare_object('WATER_CHANNEL', 'WATER-CHANNEL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'channel',
    'SYNONYM': 'CHANNEL',
    'ADJECTIVE': 'WATER',
    'ACTION': ZG.WATER_CHANNEL_F,
})

# zil: 3actions.zil:5030  <OBJECT MOSS>
ZG.world.declare_object('MOSS', 'MOSS', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'moss and lichen',
    'SYNONYM': ('MOSS', 'LICHEN'),
    'ACTION': ZG.MOSS_F,
})

# zil: 3actions.zil:5036  <ROUTINE AQUEDUCT-F ()>
@ZG.routine('AQUEDUCT-F')
def AQUEDUCT_F():
    if VERB_p('EXAMINE'):
        return TELL('The aqueduct is large and impressive. It was probably the major method\nof water transport in the Empire.', CR)
    elif VERB_p('LEAP'):
        return ZG.JIGS_UP('You execute a perfect swan dive into the rocks below!')
    else:
        return False

# zil: 3actions.zil:5045  <ROUTINE WATER-CHANNEL-F ()>
@ZG.routine('WATER-CHANNEL-F')
def WATER_CHANNEL_F():
    if VERB_p('EXAMINE'):
        return TELL('The channel is a few feet deep and ten feet wide, rounded on the bottom.', CR)
    elif VERB_p('BOARD'):
        if (ZG.HERE == ZG.DAMP_PASSAGE):
            return TELL("Getting into the channel wouldn't be of much use.", CR)
        else:
            return TELL("You're standing in it. Otherwise, you would be floating in midair above some\nvery nasty rocks.", CR)
    else:
        return False

# zil: 3actions.zil:5058  <ROUTINE MOSS-F ()>
@ZG.routine('MOSS-F')
def MOSS_F():
    if VERB_p('TAKE', 'MOVE'):
        return TELL("Don't be silly.", CR)
    else:
        return False

# zil: 3actions.zil:5062  <ROUTINE AQ-2-F (RARG)>
@ZG.routine('AQ-2-F')
def AQ_2_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are now on one of the tallest arches of the aqueduct, hundreds of feet\nabove a rocky chasm. The immensity of the aqueduct project is apparent from\nhere. Stone supports rise from the rock floor to form massive arches, which\ntraverse the region from north to south. The water-carrying channel here is\nwide and deep. To the west and far below, you can make out a balcony which\nmust command a wide view of the aqueduct.', CR)
        if (not ZG.AQ_FLAG):
            return TELL('The channel ends abruptly to your north where a supporting pillar has\ncrumbled, casting the arch into the chasm.', CR)
        else:
            return False
    else:
        return False

# zil: 3actions.zil:5076  <ROUTINE AQ-3-F (RARG)>
@ZG.routine('AQ-3-F')
def AQ_3_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are near the northern end of this segment of the aqueduct system. To the\nsouth and slightly uphill, the bulk of the aqueduct looms ominously, towering\nabove a gorge. To the north, the water channel drops precipitously and enters\na rocky hole. The damp moss and lichen would certainly make that a one-way\ntrip.', CR)
        if (not ZG.AQ_FLAG):
            return TELL('The southern part of the aqueduct system is inaccessable due to the\ncollapse of one of the water-bearing arches.', CR)
        else:
            return False
    else:
        return False

# zil: 3actions.zil:5089  <GLOBAL AQ-FLAG>
# GLOBAL (state) AQ_FLAG = True  ->  ZilGlobal.py

# zil: 3actions.zil:5091  <GLOBAL COVER-MOVED>
# GLOBAL (state) COVER_MOVED = False  ->  ZilGlobal.py

# zil: 3actions.zil:5093  <OBJECT COVER>
ZG.world.declare_object('COVER', 'COVER', lambda: {
    'LOC': ZG.KEY_ROOM,
    'DESC': 'manhole cover',
    'SYNONYM': 'COVER',
    'ADJECTIVE': ('MANHOLE', 'LARGE'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.COVER_F,
})

# zil: 3actions.zil:5101  <ROUTINE COVER-F ()>
@ZG.routine('COVER-F')
def COVER_F():
    if VERB_p('MOVE', 'RAISE', 'OPEN'):
        TELL('The cover is moved a bit to one side, revealing a small hole leading into\ndarkness.', CR)
        ZG.COVER_MOVED = True
        return ZG.COVER_MOVED
    elif VERB_p('TAKE'):
        return TELL('The cover is far too heavy to take.', CR)
    else:
        return False

# zil: 3actions.zil:5111  <ROUTINE KEY-ROOM-F (RARG)>
@ZG.routine('KEY-ROOM-F')
def KEY_ROOM_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are between some rock and a dark place. The room is lit dimly from\nabove, revealing a lone, dark path sloping down to the west.', CR)
        if ZG.COVER_MOVED:
            return TELL('A heavy manhole cover has been moved to reveal a dark passage below.', CR)
        else:
            return TELL('To one side of the room is a large manhole cover.', CR)
    else:
        return False

# zil: 3actions.zil:5123  <OBJECT KEY>
ZG.world.declare_object('KEY', 'KEY', lambda: {
    'LOC': ZG.KEY_ROOM,
    'DESC': 'strange key',
    'FDESC': 'The light from above seems to be focused in the center of the room, where\na single key is lying in the dust.',
    'SYNONYM': 'KEY',
    'ADJECTIVE': ('STRANGE', 'RUSTY', 'LONG', 'SHORT', 'HEAVY', 'THIN', 'SHARP', 'POINTED'),
    'FLAGS': 'TAKEBIT',
    'SIZE': 10,
    'ACTION': ZG.KEY_F,
})

# zil: 3actions.zil:5135  <ROUTINE KEY-F ()>
@ZG.routine('KEY-F')
def KEY_F():
    if (VERB_p('UNLOCK') and (ZG.PRSI == ZG.KEY)):
        if ((ZG.PRSO == ZG.BRONZE_DOOR) and (ZG.HERE == ZG.GOOD_CELL)):
            if ZG.BRONZE_DOOR_LOCKED:
                TELL('The key seems to mold itself to the shape of the lock. With a mere\ntwist of your hand, the massive bolt gives way.', CR)
            else:
                TELL('It already is.', CR)
            ZG.BRONZE_DOOR_LOCKED = False
            return True
        elif (ZG.PRSO == ZG.BRONZE_DOOR):
            return TELL('The key molds itself to the lock but will not turn.', CR)
        elif ((ZG.PRSO == ZG.CHEST) or FSET_p(ZG.PRSO, Flag('DOORBIT'))):
            return TELL('The key, which initially seemed certain to fit the lock, seems to change\nshape and will not enter the keyhole.', CR)
        else:
            return False
    elif VERB_p('EXAMINE'):
        TELL(ZG.PICK_ONE(ZG.KEY_DESCS), CR)
        return TELL('Strange, though. The key seems to change shape constantly.', CR)
    else:
        return False

# zil: 3actions.zil:5158  <GLOBAL KEY-DESCS>
# GLOBAL (state) KEY_DESCS = LTABLE(0, 'The key is a long and heavy skeleton key.', 'The key is short and stubby, shaped like no lock you have ever seen.', 'The key is round and thin, more like a pencil than a key.', 'The key is shiny with many prongs.', 'The key is sharp as an awl, and rusted badly.')  ->  ZilGlobal.py

# zil: 3actions.zil:5165  <OBJECT VIEW-INDICATOR>
ZG.world.declare_object('VIEW_INDICATOR', 'VIEW-INDICATOR', lambda: {
    'LOC': ZG.VIEW_ROOM,
    'DESC': 'indicator',
    'SYNONYM': ('INDICATOR', 'DIAL'),
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'ACTION': ZG.VIEW_INDICATOR_F,
})

# zil: 3actions.zil:5172  <ROUTINE VIEW-INDICATOR-F ()>
@ZG.routine('VIEW-INDICATOR-F')
def VIEW_INDICATOR_F():
    if VERB_p('EXAMINE', 'READ'):
        return TELL('The indicator reads "', GET(ZG.VIEW_ROMANS, ZG.ACTIVE_VIEW), '".', CR)
    else:
        return False

# zil: 3actions.zil:5178  <GLOBAL BOAT-SEEN>
# GLOBAL (state) BOAT_SEEN = False  ->  ZilGlobal.py

# zil: 3actions.zil:5180  <ROUTINE FLATHEAD-OCEAN-F (RARG)>
@ZG.routine('FLATHEAD-OCEAN-F')
def FLATHEAD_OCEAN_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are at the shore of an amazing underground sea, the topic of many a\nlegend among adventurers. Few were known to have arrived at this spot, and\nfewer to return. There is a heavy surf and a breeze is blowing onshore.\nThe land rises steeply to the east and quicksand prevents movement to the\nsouth. A thick mist covers the ocean and extends over the hills to the east.\nA path heads north along the beach.', CR)
        if (not FSET_p(ZG.VIKING_SHIP, Flag('INVISIBLE'))):
            TELL('An ancient Viking ship is passing along the shore, an old and crusty\nsailor at the helm.', CR)
        return True
    elif ((RARG == ZG.M_END) and ZG.PROB(20) and (not ZG.BOAT_SEEN) and ZG.LIT):
        ZG.BOAT_SEEN = True
        ENABLE(ZG.QUEUE(ZG.I_BOAT_DISAPPEAR, 2))
        TELL('Passing alongside the shore now is an old boat, reminiscent of an ancient\nViking ship. Standing on the prow of the ship is an old and crusty sailor,\npeering out over the misty ocean.', CR)
        return FCLEAR(ZG.VIKING_SHIP, Flag('INVISIBLE'))
    else:
        return False

# zil: 3actions.zil:5206  <GLOBAL SHIP-GONE>
# GLOBAL (state) SHIP_GONE = False  ->  ZilGlobal.py

# zil: 3actions.zil:5208  <ROUTINE I-BOAT-DISAPPEAR ()>
@ZG.routine('I-BOAT-DISAPPEAR')
def I_BOAT_DISAPPEAR():
    FSET(ZG.VIKING_SHIP, Flag('INVISIBLE'))
    ZG.SHIP_GONE = True
    if (ZG.HERE == ZG.FLATHEAD_OCEAN):
        return TELL('The boat sails silently through the mist and out of sight.', CR)
    else:
        return False

# zil: 3actions.zil:5215  <OBJECT VIKING-SHIP>
ZG.world.declare_object('VIKING_SHIP', 'VIKING-SHIP', lambda: {
    'LOC': ZG.FLATHEAD_OCEAN,
    'DESC': 'Viking Ship',
    'FLAGS': ('NDESCBIT', 'INVISIBLE'),
    'ADJECTIVE': 'VIKING',
    'SYNONYM': ('BOAT', 'SHIP', 'CRAFT'),
})

# zil: 3actions.zil:5222  <OBJECT VIAL>
ZG.world.declare_object('VIAL', 'VIAL', lambda: {
    'DESC': 'vial',
    'SYNONYM': ('VIAL', 'ODOR', 'GIFT'),
    'FLAGS': ('TAKEBIT', 'CONTBIT'),
    'SIZE': 3,
    'CAPACITY': 3,
    'ACTION': ZG.VIAL_F,
})

# zil: 3actions.zil:5230  <OBJECT POTION>
ZG.world.declare_object('POTION', 'POTION', lambda: {
    'LOC': ZG.VIAL,
    'DESC': 'heavy but invisible liquid',
    'SYNONYM': ('POTION', 'LIQUID', 'CONTENTS', 'FLUID'),
    'ADJECTIVE': ('HEAVY', 'SWEET', 'INVISIBLE', 'SMELLING'),
    'SIZE': 2,
    'FLAGS': True,
    'ACTION': ZG.POTION_F,
})

# zil: 3actions.zil:5239  <ROUTINE I-VISIBLE ()>
@ZG.routine('I-VISIBLE')
def I_VISIBLE():
    ZG.INVIS = False
    if (ZG.HERE in (ZG.MRG, ZG.MRGE, ZG.MRGW)):
        ZG.JIGS_UP("One of the stone figures (or maybe both, it's hard to tell) suddenly springs\nto life and crushes you with his stone bludgeon.")
    return False

# zil: 3actions.zil:5247  <ROUTINE POTION-F ()>
@ZG.routine('POTION-F')
def POTION_F():
    if VERB_p('DRINK'):
        REMOVE(ZG.POTION)
        ZG.INVIS = True
        ENABLE(ZG.QUEUE(ZG.I_VISIBLE, 3))
        return TELL('You "drink" the contents in one gulp, but nothing unusual seems to have\nhappened as a result.', CR)
    elif (VERB_p('POUR-ON') and (ZG.PRSO == ZG.POTION)):
        REMOVE(ZG.POTION)
        return TELL('It spills onto the ', D, ZG.PRSI, ' and vanishes.', CR)
    elif VERB_p('EXAMINE'):
        return TELL("It feels like there's something inside, but you can't see anything even\nthough the vial is transparent.", CR)
    elif VERB_p('SMELL'):
        return TELL('The vial (or something in it) smells sweet.', CR)
    elif VERB_p('DROP', 'TAKE'):
        TELL('Nothing seems to come out, although the sweet smell disappears from\nthe vial, seeming to permeate the air briefly before fading entirely.', CR)
        return REMOVE(ZG.POTION)
    else:
        return False

# zil: 3actions.zil:5271  <GLOBAL INVIS>
# GLOBAL (state) INVIS = False  ->  ZilGlobal.py

# zil: 3actions.zil:5273  <ROUTINE VIAL-F ()>
@ZG.routine('VIAL-F')
def VIAL_F():
    if VERB_p('FILL'):
        return TELL("You can't seem to put anything in it.", CR)
    elif (VERB_p('DRINK-FROM') and IN_p(ZG.POTION, ZG.VIAL)):
        ZG.PERFORM(SYMBOL('V?DRINK'), ZG.POTION)
        return True
    elif (VERB_p('SMELL') and IN_p(ZG.POTION, ZG.VIAL)):
        ZG.PERFORM(SYMBOL('V?SMELL'), ZG.POTION)
        return True
    elif (VERB_p('SHAKE') and IN_p(ZG.POTION, ZG.VIAL) and FSET_p(ZG.VIAL, Flag('OPENBIT'))):
        TELL('Nothing seems to come out, although the vial is lighter now.', CR)
        return REMOVE(ZG.POTION)
    elif VERB_p('OPEN'):
        FSET(ZG.VIAL, Flag('OPENBIT'))
        TELL('The vial is open.')
        if IN_p(ZG.POTION, ZG.VIAL):
            TELL(' There is a sweet odor from within the vial, apparently coming from a heavy\nbut invisible liquid.')
        return CRLF()
    elif VERB_p('EXAMINE'):
        TELL('It is a small, transparent vial ')
        if IN_p(ZG.POTION, ZG.VIAL):
            return TELL('which looks empty but is strangely heavy.', CR)
        else:
            return TELL('which is light and empty.', CR)
    else:
        return False

# zil: 3actions.zil:5303  <OBJECT OCEAN>
ZG.world.declare_object('OCEAN', 'OCEAN', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'DESC': 'Flathead Ocean',
    'SYNONYM': ('OCEAN', 'WATER'),
    'ADJECTIVE': 'FLATHEAD',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.OCEAN_F,
})

# zil: 3actions.zil:5311  <ROUTINE OCEAN-F ()>
@ZG.routine('OCEAN-F')
def OCEAN_F():
    if (not (ZG.HERE == ZG.FLATHEAD_OCEAN)):
        return TELL('There is no ocean here.', CR)
    elif VERB_p('THROUGH', 'BOARD'):
        return TELL('You would be killed by the pounding surf!', CR)
    elif (VERB_p('PUT', 'THROW') and (ZG.PRSI == ZG.OCEAN)):
        TELL('The ', D, ZG.PRSO, ' falls into the ocean and is lost forever.', CR)
        return REMOVE(ZG.PRSO)
    else:
        return False

# zil: 3actions.zil:5321  <OBJECT STONE>
ZG.world.declare_object('STONE', 'STONE', lambda: {
    'DESC': 'great rock',
    'SYNONYM': ('ROCK', 'STONE'),
    'ADJECTIVE': 'GREAT',
    'LOC': ZG.JUNCTION,
    'DESCFCN': ZG.STONE_DESC,
    'FLAGS': ('CONTBIT', 'OPENBIT'),
    'CAPACITY': 30,
    'ACTION': ZG.STONE_F,
})

# zil: 3actions.zil:5331  <GLOBAL SWORD-IN-STONE?>
# GLOBAL (state) SWORD_IN_STONE_p = True  ->  ZilGlobal.py

# zil: 3actions.zil:5333  <ROUTINE STONE-DESC (FOO)>
@ZG.routine('STONE-DESC')
def STONE_DESC(FOO):
    TELL('Standing before you is a great rock.')
    if ZG.SWORD_IN_STONE_p:
        TELL(' Imbedded within it is an Elvish sword.')
    return CRLF()

# zil: 3actions.zil:5340  <ROUTINE STONE-F ()>
@ZG.routine('STONE-F')
def STONE_F():
    if VERB_p('OPEN', 'CLOSE'):
        return TELL("You can't be serious.", CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.STONE)):
        return TELL("You can't force anything into the stone.", CR)
    elif (VERB_p('MOVE', 'TAKE', 'PUSH') and (ZG.PRSO == ZG.STONE)):
        return TELL('The stone is far too massive to be moved.', CR)
    elif VERB_p('LOOK-UNDER'):
        return TELL("Since it can't be moved, it's hard to know what's there.", CR)
    else:
        return False

# zil: 3actions.zil:5352  <OBJECT FISH>
ZG.world.declare_object('FISH', 'FISH', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'fish',
    'SYNONYM': 'FISH',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.FISH_F,
})

# zil: 3actions.zil:5359  <ROUTINE FISH-F ()>
@ZG.routine('FISH-F')
def FISH_F():
    return TELL('There is no fish visible now.', CR)

# zil: 3actions.zil:5362  <ROUTINE QUICKSAND-PSEUDO ()>
@ZG.routine('QUICKSAND-PSEUDO')
def QUICKSAND_PSEUDO():
    if VERB_p('THROUGH', 'LEAP'):
        return ZG.JIGS_UP('You enter the quicksand and slowly sink to a new low in adventuring.')
    elif VERB_p('RUB'):
        return TELL("It's quicksand all right!", CR)
    elif VERB_p('LOOK-INSIDE'):
        return TELL("It's hard to tell what's in there.", CR)
    else:
        return False

# zil: 3actions.zil:5371  <ROUTINE SWAMP-PSEUDO ()>
@ZG.routine('SWAMP-PSEUDO')
def SWAMP_PSEUDO():
    if VERB_p('THROUGH'):
        return TELL('Yucko.', CR)
    else:
        return False

# zil: 3actions.zil:5375  <ROUTINE MIST-PSEUDO ()>
@ZG.routine('MIST-PSEUDO')
def MIST_PSEUDO():
    if VERB_p('LOOK-INSIDE'):
        return TELL("You can't make anything out through the mist.", CR)
    elif VERB_p('SMELL'):
        return TELL('It smells vaguely salty.', CR)
    else:
        return False

# zil: 3actions.zil:5381  <ROUTINE SHORE-PSEUDO ()>
@ZG.routine('SHORE-PSEUDO')
def SHORE_PSEUDO():
    if VERB_p('DIG'):
        return TELL("There's nothing there.", CR)
    else:
        return False

# zil: 3actions.zil:5386  <ROUTINE WATERFALL-PSEUDO ()>
@ZG.routine('WATERFALL-PSEUDO')
def WATERFALL_PSEUDO():
    if VERB_p('CLIMB-UP'):
        return TELL("It's much too slippery.", CR)
    else:
        return False

# zil: 3actions.zil:5390  <ROUTINE ARCH-PSEUDO ()>
@ZG.routine('ARCH-PSEUDO')
def ARCH_PSEUDO():
    if VERB_p('EXAMINE'):
        if ZG.AQ_FLAG:
            return TELL('The arches all show some signs of decay.', CR)
        else:
            return TELL('The arch before you is broken. The others show signs of decay.', CR)
    else:
        return False
