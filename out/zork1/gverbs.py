# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'Generic VERBS file for\n\t\t\t    The ZORK Trilogy\n\t\t       started on 7/25/83 by SEM'

'Verb Functions for Game Commands'

# zil: gverbs.zil:9  <GLOBAL VERBOSE>
# GLOBAL (state) VERBOSE = False  ->  ZilGlobal.py

# zil: gverbs.zil:10  <GLOBAL SUPER-BRIEF>
# GLOBAL (state) SUPER_BRIEF = False  ->  ZilGlobal.py

GDECL(('VERBOSE', 'SUPER-BRIEF'), ('OR', 'ATOM', 'FALSE'))

# zil: gverbs.zil:13  <ROUTINE V-VERBOSE ()>
@ZG.routine('V-VERBOSE')
def V_VERBOSE():
    ZG.VERBOSE = True
    ZG.SUPER_BRIEF = False
    return TELL('Maximum verbosity.', CR)

# zil: gverbs.zil:18  <ROUTINE V-BRIEF ()>
@ZG.routine('V-BRIEF')
def V_BRIEF():
    ZG.VERBOSE = False
    ZG.SUPER_BRIEF = False
    return TELL('Brief descriptions.', CR)

# zil: gverbs.zil:23  <ROUTINE V-SUPER-BRIEF ()>
@ZG.routine('V-SUPER-BRIEF')
def V_SUPER_BRIEF():
    ZG.SUPER_BRIEF = True
    return TELL('Superbrief descriptions.', CR)

# ;"V-DIAGNOSE is in ACTIONS.ZIL"

# zil: gverbs.zil:29  <ROUTINE V-INVENTORY ()>
@ZG.routine('V-INVENTORY')
def V_INVENTORY():
    if FIRST_p(ZG.WINNER):
        return ZG.PRINT_CONT(ZG.WINNER)
    else:
        return TELL('You are empty-handed.', CR)

# zil: gverbs.zil:33  <ROUTINE FINISH ("AUX" WRD)>
@ZG.routine('FINISH')
def FINISH():
    WRD = 0
    ZG.V_SCORE()
    while True:
        CRLF()
        TELL('Would you like to restart the game from the beginning, restore a saved\ngame position, or end this session of the game?\n(Type RESTART, RESTORE, or QUIT):\n>')
        READ(ZG.P_INBUF, ZG.P_LEXV)
        WRD = GET(ZG.P_LEXV, 1)
        if (WRD == WORD('restart')):
            RESTART()
            TELL('Failed.', CR)
        elif (WRD == WORD('restore')):
            if RESTORE():
                TELL('Ok.', CR)
            else:
                TELL('Failed.', CR)
        elif (WRD in (WORD('quit'), WORD('q'))):
            QUIT()

# zil: gverbs.zil:55  <ROUTINE V-QUIT ("AUX" SCOR)>
@ZG.routine('V-QUIT')
def V_QUIT():
    SCOR = 0
    ZG.V_SCORE()
    TELL('Do you wish to leave the game? (Y is affirmative): ')
    if ZG.YES_p():
        return QUIT()
    else:
        return TELL('Ok.', CR)

# zil: gverbs.zil:63  <ROUTINE V-RESTART ()>
@ZG.routine('V-RESTART')
def V_RESTART():
    ZG.V_SCORE(True)
    TELL('Do you wish to restart? (Y is affirmative): ')
    if ZG.YES_p():
        TELL('Restarting.', CR)
        RESTART()
        return TELL('Failed.', CR)
    else:
        return False

# zil: gverbs.zil:71  <ROUTINE V-RESTORE ()>
@ZG.routine('V-RESTORE')
def V_RESTORE():
    if RESTORE():
        TELL('Ok.', CR)
        return ZG.V_FIRST_LOOK()
    else:
        return TELL('Failed.', CR)

# zil: gverbs.zil:78  <ROUTINE V-SAVE ()>
@ZG.routine('V-SAVE')
def V_SAVE():
    if SAVE():
        return TELL('Ok.', CR)
    else:
        return TELL('Failed.', CR)

# ;"V-SCORE is in ACTIONS.ZIL"

# zil: gverbs.zil:86  <ROUTINE V-SCRIPT ()>
@ZG.routine('V-SCRIPT')
def V_SCRIPT():
    PUT(0, 8, (GET(0, 8) | 1))
    TELL('Here begins a transcript of interaction with', CR)
    ZG.V_VERSION()
    return True

# zil: gverbs.zil:92  <ROUTINE V-UNSCRIPT ()>
@ZG.routine('V-UNSCRIPT')
def V_UNSCRIPT():
    TELL('Here ends a transcript of interaction with', CR)
    ZG.V_VERSION()
    PUT(0, 8, (GET(0, 8) & -2))
    return True

# zil: gverbs.zil:98  <ROUTINE V-VERSION ("AUX" (CNT 17))>
@ZG.routine('V-VERSION')
def V_VERSION():
    CNT = 17
    TELL('ZORK I: The Great Underground Empire\nInfocom interactive fiction - a fantasy story\nCopyright (c) 1981, 1982, 1983, 1984, 1985, 1986')
    TELL(' Infocom, Inc. All rights reserved.', CR)
    TELL('ZORK is a registered trademark of Infocom, Inc.\nRelease ')
    PRINTN((GET(0, 1) & 2047))
    TELL(' / Serial number ')
    while True:
        if ((CNT := (CNT + 1)) > 23):
            break
        else:
            PRINTC(GETB(0, CNT))
    return CRLF()

# zil: gverbs.zil:123  <ROUTINE V-VERIFY ()>
@ZG.routine('V-VERIFY')
def V_VERIFY():
    TELL('Verifying disk...', CR)
    if VERIFY():
        return TELL('The disk is correct.', CR)
    else:
        return TELL(CR, '** Disk Failure **', CR)

# zil: gverbs.zil:130  <ROUTINE V-COMMAND-FILE ()>
@ZG.routine('V-COMMAND-FILE')
def V_COMMAND_FILE():
    DIRIN(1)
    return True

# zil: gverbs.zil:134  <ROUTINE V-RANDOM ()>
@ZG.routine('V-RANDOM')
def V_RANDOM():
    if (not (ZG.PRSO == ZG.INTNUM)):
        return TELL('Illegal call to #RND.', CR)
    else:
        RANDOM((0 - ZG.P_NUMBER))
        return True

# zil: gverbs.zil:141  <ROUTINE V-RECORD ()>
@ZG.routine('V-RECORD')
def V_RECORD():
    DIROUT(4)
    return True

# zil: gverbs.zil:145  <ROUTINE V-UNRECORD ()>
@ZG.routine('V-UNRECORD')
def V_UNRECORD():
    DIROUT(-4)
    return True

'Real Verb Functions'

# zil: gverbs.zil:153  <ROUTINE V-ADVENT ()>
@ZG.routine('V-ADVENT')
def V_ADVENT():
    return TELL('A hollow voice says "Fool."', CR)

# zil: gverbs.zil:156  <ROUTINE V-ALARM ()>
@ZG.routine('V-ALARM')
def V_ALARM():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        if (GETP(ZG.PRSO, 'STRENGTH') < 0):
            TELL('The ', D, ZG.PRSO, ' is rudely awakened.', CR)
            return ZG.AWAKEN(ZG.PRSO)
        else:
            return TELL("He's wide awake, or haven't you noticed...", CR)
    else:
        return TELL('The ', D, ZG.PRSO, " isn't sleeping.", CR)

# zil: gverbs.zil:170  <ROUTINE V-ANSWER ()>
@ZG.routine('V-ANSWER')
def V_ANSWER():
    TELL('Nobody seems to be awaiting your answer.', CR)
    ZG.P_CONT = False
    ZG.QUOTE_FLAG = False
    return True

# zil: gverbs.zil:176  <ROUTINE V-ATTACK ()>
@ZG.routine('V-ATTACK')
def V_ATTACK():
    if (not FSET_p(ZG.PRSO, Flag('ACTORBIT'))):
        return TELL("I've known strange people, but fighting a ", D, ZG.PRSO, '?', CR)
    elif ((not ZG.PRSI) or (ZG.PRSI == ZG.HANDS)):
        return TELL('Trying to attack a ', D, ZG.PRSO, ' with your bare hands is suicidal.', CR)
    elif (not IN_p(ZG.PRSI, ZG.WINNER)):
        return TELL("You aren't even holding the ", D, ZG.PRSI, '.', CR)
    elif (not FSET_p(ZG.PRSI, Flag('WEAPONBIT'))):
        return TELL('Trying to attack the ', D, ZG.PRSO, ' with a ', D, ZG.PRSI, ' is suicidal.', CR)
    else:
        return ZG.HERO_BLOW()

# zil: gverbs.zil:195  <ROUTINE V-BACK ()>
@ZG.routine('V-BACK')
def V_BACK():
    return TELL('Sorry, my memory is poor. Please give a direction.', CR)

# zil: gverbs.zil:198  <ROUTINE V-BLAST ()>
@ZG.routine('V-BLAST')
def V_BLAST():
    return TELL("You can't blast anything by using words.", CR)

# zil: gverbs.zil:201  <ROUTINE PRE-BOARD ("AUX" AV)>
@ZG.routine('PRE-BOARD')
def PRE_BOARD():
    AV = 0
    AV = LOC(ZG.WINNER)
    if ZG.NULL_F():
        return True
    elif FSET_p(ZG.PRSO, Flag('VEHBIT')):
        if (not IN_p(ZG.PRSO, ZG.HERE)):
            TELL('The ', D, ZG.PRSO, ' must be on the ground to be boarded.', CR)
        elif FSET_p(AV, Flag('VEHBIT')):
            TELL('You are already in the ', D, AV, '!', CR)
        else:
            return False
    elif (ZG.PRSO in (ZG.WATER, ZG.GLOBAL_WATER)):
        ZG.PERFORM(SYMBOL('V?SWIM'), ZG.PRSO)
        return True
    else:
        TELL('You have a theory on how to board a ', D, ZG.PRSO, ', perhaps?', CR)
    return 2

# zil: gverbs.zil:224  <ROUTINE V-BOARD ("AUX" AV)>
@ZG.routine('V-BOARD')
def V_BOARD():
    AV = 0
    TELL('You are now in the ', D, ZG.PRSO, '.', CR)
    MOVE(ZG.WINNER, ZG.PRSO)
    APPLY(GETP(ZG.PRSO, 'ACTION'), ZG.M_ENTER)
    return True

# zil: gverbs.zil:230  <ROUTINE V-BREATHE ()>
@ZG.routine('V-BREATHE')
def V_BREATHE():
    return ZG.PERFORM(SYMBOL('V?INFLATE'), ZG.PRSO, ZG.LUNGS)

# zil: gverbs.zil:233  <ROUTINE V-BRUSH ()>
@ZG.routine('V-BRUSH')
def V_BRUSH():
    return TELL('If you wish, but heaven only knows why.', CR)

# zil: gverbs.zil:236  <ROUTINE V-BUG ()>
@ZG.routine('V-BUG')
def V_BUG():
    return TELL('Bug? Not in a flawless program like this! (Cough, cough).', CR)

# zil: gverbs.zil:240  <ROUTINE TELL-NO-PRSI ()>
@ZG.routine('TELL-NO-PRSI')
def TELL_NO_PRSI():
    return TELL("You didn't say with what!", CR)

# zil: gverbs.zil:243  <ROUTINE PRE-BURN ()>
@ZG.routine('PRE-BURN')
def PRE_BURN():
    if (not ZG.PRSI):
        return ZG.TELL_NO_PRSI()
    elif FLAMING_p(ZG.PRSI):
        return False
    else:
        return TELL('With a ', D, ZG.PRSI, '??!?', CR)

# zil: gverbs.zil:251  <ROUTINE V-BURN ()>
@ZG.routine('V-BURN')
def V_BURN():
    if ZG.NULL_F():
        return False
    elif FSET_p(ZG.PRSO, Flag('BURNBIT')):
        if (IN_p(ZG.PRSO, ZG.WINNER) or IN_p(ZG.WINNER, ZG.PRSO)):
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            TELL('The ', D, ZG.PRSO)
            TELL(' catches fire. Unfortunately, you were ')
            if IN_p(ZG.WINNER, ZG.PRSO):
                TELL('in')
            else:
                TELL('holding')
            return ZG.JIGS_UP(' it at the time.')
        else:
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            return TELL('The ', D, ZG.PRSO, ' catches fire and is consumed.', CR)
    else:
        return TELL("You can't burn a ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:276  <ROUTINE V-CHOMP ()>
@ZG.routine('V-CHOMP')
def V_CHOMP():
    return TELL('Preposterous!', CR)

# zil: gverbs.zil:279  <ROUTINE V-CLIMB-DOWN ()>
@ZG.routine('V-CLIMB-DOWN')
def V_CLIMB_DOWN():
    return ZG.V_CLIMB_UP('DOWN', ZG.PRSO)

# zil: gverbs.zil:281  <ROUTINE V-CLIMB-FOO ()>
@ZG.routine('V-CLIMB-FOO')
def V_CLIMB_FOO():
    return ZG.V_CLIMB_UP('UP', ZG.PRSO)

# zil: gverbs.zil:290  <ROUTINE V-CLIMB-ON ()>
@ZG.routine('V-CLIMB-ON')
def V_CLIMB_ON():
    if FSET_p(ZG.PRSO, Flag('VEHBIT')):
        ZG.PERFORM(SYMBOL('V?BOARD'), ZG.PRSO)
        return True
    else:
        return TELL("You can't climb onto the ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:300  <ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)>
@ZG.routine('V-CLIMB-UP')
def V_CLIMB_UP(DIR=None, OBJ_l=None):
    if DIR is None:
        DIR = 'UP'
    if OBJ_l is None:
        OBJ_l = False
    X = 0
    TX = 0
    if (OBJ_l and (not (ZG.PRSO == ZG.ROOMS))):
        OBJ_l = ZG.PRSO
    if (TX := GETPT(ZG.HERE, DIR)):
        if OBJ_l:
            X = PTSIZE(TX)
            if ((X == ZG.NEXIT) or ((X in (ZG.CEXIT, ZG.DEXIT, ZG.UEXIT)) and (not ZG.GLOBAL_IN_p(ZG.PRSO, GETB(TX, 0))))):
                TELL('The ', D, OBJ_l, ' do')
                if (not (OBJ_l == ZG.STAIRS)):
                    TELL('es')
                TELL("n't lead ")
                if (DIR == 'UP'):
                    TELL('up')
                else:
                    TELL('down')
                TELL('ward.', CR)
                return True
        ZG.DO_WALK(DIR)
        return True
    elif (OBJ_l and ZG.ZMEMQ(WORD('wall'), (X := GETPT(ZG.PRSO, 'SYNONYM')), PTSIZE(X))):
        return TELL('Climbing the walls is to no avail.', CR)
    elif ((not (ZG.HERE == ZG.PATH)) and (OBJ_l in (False, ZG.TREE)) and ZG.GLOBAL_IN_p(ZG.TREE, ZG.HERE)):
        TELL('There are no climbable trees here.', CR)
        return True
    elif (OBJ_l in (False, ZG.ROOMS)):
        return TELL("You can't go that way.", CR)
    else:
        return TELL("You can't do that!", CR)

# zil: gverbs.zil:336  <ROUTINE V-CLOSE ()>
@ZG.routine('V-CLOSE')
def V_CLOSE():
    if ((not FSET_p(ZG.PRSO, Flag('CONTBIT'))) and (not FSET_p(ZG.PRSO, Flag('DOORBIT')))):
        return TELL('You must tell me how to do that to a ', D, ZG.PRSO, '.', CR)
    elif ((not FSET_p(ZG.PRSO, Flag('SURFACEBIT'))) and (not (GETP(ZG.PRSO, 'CAPACITY') == 0))):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            FCLEAR(ZG.PRSO, Flag('OPENBIT'))
            TELL('Closed.', CR)
            if (ZG.LIT and (not ZG._set('LIT', ZG.LIT_p(ZG.HERE)))):
                TELL('It is now pitch black.', CR)
            return True
        else:
            return TELL('It is already closed.', CR)
    elif FSET_p(ZG.PRSO, Flag('DOORBIT')):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            FCLEAR(ZG.PRSO, Flag('OPENBIT'))
            return TELL('The ', D, ZG.PRSO, ' is now closed.', CR)
        else:
            return TELL('It is already closed.', CR)
    else:
        return TELL('You cannot close that.', CR)

# zil: gverbs.zil:359  <ROUTINE V-COMMAND ()>
@ZG.routine('V-COMMAND')
def V_COMMAND():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL('The ', D, ZG.PRSO, ' pays no attention.', CR)
    else:
        return TELL('You cannot talk to that!', CR)

# zil: gverbs.zil:365  <ROUTINE V-COUNT ()>
@ZG.routine('V-COUNT')
def V_COUNT():
    if (ZG.PRSO == ZG.BLESSINGS):
        return TELL('Well, for one, you are playing Zork...', CR)
    else:
        return TELL('You have lost your mind.', CR)

# zil: gverbs.zil:371  <ROUTINE V-CROSS ()>
@ZG.routine('V-CROSS')
def V_CROSS():
    return TELL("You can't cross that!", CR)

# zil: gverbs.zil:374  <ROUTINE V-CURSES ()>
@ZG.routine('V-CURSES')
def V_CURSES():
    if ZG.PRSO:
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            return TELL("Insults of this nature won't help you.", CR)
        else:
            return TELL('What a loony!', CR)
    else:
        return TELL('Such language in a high-class establishment like this!', CR)

# zil: gverbs.zil:384  <ROUTINE V-CUT ()>
@ZG.routine('V-CUT')
def V_CUT():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSO, ZG.PRSI)
    elif (FSET_p(ZG.PRSO, Flag('BURNBIT')) and FSET_p(ZG.PRSI, Flag('WEAPONBIT'))):
        if IN_p(ZG.WINNER, ZG.PRSO):
            TELL("Not a bright idea, especially since you're in it.", CR)
            return True
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        return TELL('Your skillful ', D, ZG.PRSI, 'smanship slices the ', D, ZG.PRSO, ' into innumerable slivers which blow away.', CR)
    elif (not FSET_p(ZG.PRSI, Flag('WEAPONBIT'))):
        return TELL('The "cutting edge" of a ', D, ZG.PRSI, ' is hardly adequate.', CR)
    else:
        return TELL('Strange concept, cutting the ', D, ZG.PRSO, '....', CR)

# zil: gverbs.zil:402  <ROUTINE V-DEFLATE ()>
@ZG.routine('V-DEFLATE')
def V_DEFLATE():
    return TELL('Come on, now!', CR)

# zil: gverbs.zil:405  <ROUTINE V-DIG ()>
@ZG.routine('V-DIG')
def V_DIG():
    if (not ZG.PRSI):
        ZG.PRSI = ZG.HANDS
    if (ZG.PRSI == ZG.SHOVEL):
        TELL("There's no reason to be digging here.", CR)
        return True
    if FSET_p(ZG.PRSI, Flag('TOOLBIT')):
        return TELL('Digging with the ', D, ZG.PRSI, ' is slow and tedious.', CR)
    else:
        return TELL('Digging with a ', D, ZG.PRSI, ' is silly.', CR)

# zil: gverbs.zil:418  <ROUTINE V-DISEMBARK ()>
@ZG.routine('V-DISEMBARK')
def V_DISEMBARK():
    if ((ZG.PRSO == ZG.ROOMS) and FSET_p(LOC(ZG.WINNER), Flag('VEHBIT'))):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), LOC(ZG.WINNER))
        return True
    elif (not (LOC(ZG.WINNER) == ZG.PRSO)):
        TELL("You're not in that!", CR)
        return 2
    elif FSET_p(ZG.HERE, Flag('RLANDBIT')):
        TELL('You are on your own feet again.', CR)
        return MOVE(ZG.WINNER, ZG.HERE)
    else:
        TELL('You realize that getting out here would be fatal.', CR)
        return 2

# zil: gverbs.zil:434  <ROUTINE V-DISENCHANT ()>
@ZG.routine('V-DISENCHANT')
def V_DISENCHANT():
    return TELL('Nothing happens.', CR)

# zil: gverbs.zil:468  <ROUTINE V-DRINK ()>
@ZG.routine('V-DRINK')
def V_DRINK():
    return ZG.V_EAT()

# zil: gverbs.zil:471  <ROUTINE V-DRINK-FROM ()>
@ZG.routine('V-DRINK-FROM')
def V_DRINK_FROM():
    return TELL('How peculiar!', CR)

# zil: gverbs.zil:474  <ROUTINE PRE-DROP ()>
@ZG.routine('PRE-DROP')
def PRE_DROP():
    if (ZG.PRSO == LOC(ZG.WINNER)):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), ZG.PRSO)
        return True
    else:
        return False

# zil: gverbs.zil:479  <ROUTINE V-DROP ()>
@ZG.routine('V-DROP')
def V_DROP():
    if ZG.IDROP():
        return TELL('Dropped.', CR)
    else:
        return False

# zil: gverbs.zil:483  <ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))>
@ZG.routine('V-EAT')
def V_EAT():
    EAT_p = False
    DRINK_p = False
    NOBJ = False
    if (EAT_p := FSET_p(ZG.PRSO, Flag('FOODBIT'))):
        if ((not IN_p(ZG.PRSO, ZG.WINNER)) and (not IN_p(LOC(ZG.PRSO), ZG.WINNER))):
            TELL("You're not holding that.", CR)
        elif VERB_p('DRINK'):
            TELL('How can you drink that?')
        else:
            TELL('Thank you very much. It really hit the spot.')
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
        return CRLF()
    elif FSET_p(ZG.PRSO, Flag('DRINKBIT')):
        DRINK_p = True
        NOBJ = LOC(ZG.PRSO)
        if (IN_p(ZG.PRSO, ZG.GLOBAL_OBJECTS) or ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE) or (ZG.PRSO == ZG.PSEUDO_OBJECT)):
            return ZG.HIT_SPOT()
        elif ((not NOBJ) or (not ZG.ACCESSIBLE_p(NOBJ))):
            return TELL("There isn't any water here.", CR)
        elif (ZG.ACCESSIBLE_p(NOBJ) and (not IN_p(NOBJ, ZG.WINNER))):
            return TELL('You have to be holding the ', D, NOBJ, ' first.', CR)
        elif (not FSET_p(NOBJ, Flag('OPENBIT'))):
            return TELL("You'll have to open the ", D, NOBJ, ' first.', CR)
        else:
            return ZG.HIT_SPOT()
    elif (not (EAT_p or DRINK_p)):
        return TELL("I don't think that the ", D, ZG.PRSO, ' would agree with you.', CR)
    else:
        return False

# zil: gverbs.zil:518  <ROUTINE HIT-SPOT ()>
@ZG.routine('HIT-SPOT')
def HIT_SPOT():
    if ((ZG.PRSO == ZG.WATER) and (not ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE))):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
    return TELL('Thank you very much. I was rather thirsty (from all this talking,\nprobably).', CR)

# zil: gverbs.zil:526  <ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT)>
@ZG.routine('V-ECHO')
def V_ECHO():
    LST = 0
    MAX = 0
    ECH = 0
    CNT = 0
    if (GETB(ZG.P_LEXV, ZG.P_LEXWORDS) > 0):
        LST = REST(ZG.P_LEXV, (GETB(ZG.P_LEXV, ZG.P_LEXWORDS) * ZG.P_WORDLEN))
        MAX = ((GETB(LST, 0) + GETB(LST, 1)) - 1)
        while True:
            if ((ECH := (ECH + 1)) > 2):
                TELL('...', CR)
                return True
            else:
                CNT = (GETB(LST, 1) - 1)
                while True:
                    if ((CNT := (CNT + 1)) > MAX):
                        break
                    else:
                        PRINTC(GETB(ZG.P_INBUF, CNT))
                TELL(' ')
    else:
        return TELL('echo echo ...', CR)

# zil: gverbs.zil:550  <ROUTINE V-ENCHANT ()>
@ZG.routine('V-ENCHANT')
def V_ENCHANT():
    ZG.NULL_F()
    return ZG.V_DISENCHANT()

# zil: gverbs.zil:610  <ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)>
@ZG.routine('REMOVE-CAREFULLY')
def REMOVE_CAREFULLY(OBJ_l):
    OLIT = 0
    if (OBJ_l == ZG.P_IT_OBJECT):
        ZG.P_IT_OBJECT = False
    OLIT = ZG.LIT
    REMOVE(OBJ_l)
    ZG.LIT = ZG.LIT_p(ZG.HERE)
    if (OLIT and (not (OLIT == ZG.LIT))):
        TELL('You are left in the dark...', CR)
    return True

# zil: gverbs.zil:620  <ROUTINE V-ENTER ()>
@ZG.routine('V-ENTER')
def V_ENTER():
    return ZG.DO_WALK('IN')

# zil: gverbs.zil:623  <ROUTINE V-EXAMINE ()>
@ZG.routine('V-EXAMINE')
def V_EXAMINE():
    if GETP(ZG.PRSO, 'TEXT'):
        return TELL(GETP(ZG.PRSO, 'TEXT'), CR)
    elif (FSET_p(ZG.PRSO, Flag('CONTBIT')) or FSET_p(ZG.PRSO, Flag('DOORBIT'))):
        return ZG.V_LOOK_INSIDE()
    else:
        return TELL("There's nothing special about the ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:632  <ROUTINE V-EXIT ()>
@ZG.routine('V-EXIT')
def V_EXIT():
    if ((ZG.PRSO in (False, ZG.ROOMS)) and FSET_p(LOC(ZG.WINNER), Flag('VEHBIT'))):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), LOC(ZG.WINNER))
        return True
    elif (ZG.PRSO and IN_p(ZG.WINNER, ZG.PRSO)):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), ZG.PRSO)
        return True
    else:
        return ZG.DO_WALK('OUT')

# zil: gverbs.zil:643  <ROUTINE V-EXORCISE ()>
@ZG.routine('V-EXORCISE')
def V_EXORCISE():
    return TELL('What a bizarre concept!', CR)

# zil: gverbs.zil:646  <ROUTINE PRE-FILL ("AUX" TX)>
@ZG.routine('PRE-FILL')
def PRE_FILL():
    TX = 0
    if (not ZG.PRSI):
        TX = GETPT(ZG.HERE, 'GLOBAL')
        if (TX and ZG.ZMEMQB(ZG.GLOBAL_WATER, TX, (PTSIZE(TX) - 1))):
            ZG.PERFORM(SYMBOL('V?FILL'), ZG.PRSO, ZG.GLOBAL_WATER)
            return True
        elif IN_p(ZG.WATER, LOC(ZG.WINNER)):
            ZG.PERFORM(SYMBOL('V?FILL'), ZG.PRSO, ZG.WATER)
            return True
        else:
            TELL('There is nothing to fill it with.', CR)
            return True
    if (ZG.PRSI == ZG.WATER):
        return False
    elif (not (ZG.PRSI == ZG.GLOBAL_WATER)):
        ZG.PERFORM(SYMBOL('V?PUT'), ZG.PRSI, ZG.PRSO)
        return True
    else:
        return False

# zil: gverbs.zil:664  <ROUTINE V-FILL ()>
@ZG.routine('V-FILL')
def V_FILL():
    if (not ZG.PRSI):
        if ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE):
            ZG.PERFORM(SYMBOL('V?FILL'), ZG.PRSO, ZG.GLOBAL_WATER)
            return True
        elif IN_p(ZG.WATER, LOC(ZG.WINNER)):
            ZG.PERFORM(SYMBOL('V?FILL'), ZG.PRSO, ZG.WATER)
            return True
        else:
            return TELL("There's nothing to fill it with.", CR)
    else:
        return TELL("You may know how to do that, but I don't.", CR)

# zil: gverbs.zil:677  <ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))>
@ZG.routine('V-FIND')
def V_FIND():
    L = LOC(ZG.PRSO)
    if (ZG.PRSO in (ZG.HANDS, ZG.LUNGS)):
        return TELL("Within six feet of your head, assuming you haven't left that\nsomewhere.", CR)
    elif (ZG.PRSO == ZG.ME):
        return TELL("You're around here somewhere...", CR)
    elif (L == ZG.GLOBAL_OBJECTS):
        return TELL('You find it.', CR)
    elif IN_p(ZG.PRSO, ZG.WINNER):
        return TELL('You have it.', CR)
    elif (IN_p(ZG.PRSO, ZG.HERE) or ZG.GLOBAL_IN_p(ZG.PRSO, ZG.HERE) or (ZG.PRSO == ZG.PSEUDO_OBJECT)):
        return TELL("It's right here.", CR)
    elif FSET_p(L, Flag('ACTORBIT')):
        return TELL('The ', D, L, ' has it.', CR)
    elif FSET_p(L, Flag('SURFACEBIT')):
        return TELL("It's on the ", D, L, '.', CR)
    elif FSET_p(L, Flag('CONTBIT')):
        return TELL("It's in the ", D, L, '.', CR)
    else:
        return TELL('Beats me.', CR)

# zil: gverbs.zil:701  <ROUTINE V-FOLLOW ()>
@ZG.routine('V-FOLLOW')
def V_FOLLOW():
    return TELL("You're nuts!", CR)

# zil: gverbs.zil:704  <ROUTINE V-FROBOZZ ()>
@ZG.routine('V-FROBOZZ')
def V_FROBOZZ():
    return TELL('The FROBOZZ Corporation created, owns, and operates this dungeon.', CR)

# zil: gverbs.zil:708  <ROUTINE PRE-GIVE ()>
@ZG.routine('PRE-GIVE')
def PRE_GIVE():
    if (not ZG.HELD_p(ZG.PRSO)):
        return TELL("That's easy for you to say since you don't even have the ", D, ZG.PRSO, '.', CR)
    else:
        return False

# zil: gverbs.zil:713  <ROUTINE V-GIVE ()>
@ZG.routine('V-GIVE')
def V_GIVE():
    if (not FSET_p(ZG.PRSI, Flag('ACTORBIT'))):
        return TELL("You can't give a ", D, ZG.PRSO, ' to a ', D, ZG.PRSI, '!', CR)
    else:
        return TELL('The ', D, ZG.PRSI, ' refuses it politely.', CR)

# zil: gverbs.zil:719  <ROUTINE V-HATCH ()>
@ZG.routine('V-HATCH')
def V_HATCH():
    return TELL('Bizarre!', CR)

# zil: gverbs.zil:722  <GLOBAL HS>
# GLOBAL (state) HS = 0  ->  ZilGlobal.py

# ;"counts occurences of HELLO, SAILOR"

# zil: gverbs.zil:724  <ROUTINE V-HELLO ()>
@ZG.routine('V-HELLO')
def V_HELLO():
    if ZG.PRSO:
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            return TELL('The ', D, ZG.PRSO, ' bows his head to you in greeting.', CR)
        else:
            return TELL('It\'s a well known fact that only schizophrenics say "Hello" to a ', D, ZG.PRSO, '.', CR)
    else:
        return TELL(ZG.PICK_ONE(ZG.HELLOS), CR)

# zil: gverbs.zil:736  <ROUTINE V-INCANT ()>
@ZG.routine('V-INCANT')
def V_INCANT():
    TELL('The incantation echoes back faintly, but nothing else happens.', CR)
    ZG.QUOTE_FLAG = False
    ZG.P_CONT = False
    return True

# zil: gverbs.zil:757  <ROUTINE V-INFLATE ()>
@ZG.routine('V-INFLATE')
def V_INFLATE():
    return TELL('How can you inflate that?', CR)

# zil: gverbs.zil:760  <ROUTINE V-KICK ()>
@ZG.routine('V-KICK')
def V_KICK():
    return ZG.HACK_HACK('Kicking the ')

# zil: gverbs.zil:762  <ROUTINE V-KISS ()>
@ZG.routine('V-KISS')
def V_KISS():
    return TELL("I'd sooner kiss a pig.", CR)

# zil: gverbs.zil:765  <ROUTINE V-KNOCK ()>
@ZG.routine('V-KNOCK')
def V_KNOCK():
    if FSET_p(ZG.PRSO, Flag('DOORBIT')):
        return TELL("Nobody's home.", CR)
    else:
        return TELL('Why knock on a ', D, ZG.PRSO, '?', CR)

# zil: gverbs.zil:771  <ROUTINE V-LAMP-OFF ()>
@ZG.routine('V-LAMP-OFF')
def V_LAMP_OFF():
    if FSET_p(ZG.PRSO, Flag('LIGHTBIT')):
        if (not FSET_p(ZG.PRSO, Flag('ONBIT'))):
            TELL('It is already off.', CR)
        else:
            FCLEAR(ZG.PRSO, Flag('ONBIT'))
            if ZG.LIT:
                ZG.LIT = ZG.LIT_p(ZG.HERE)
            TELL('The ', D, ZG.PRSO, ' is now off.', CR)
            if (not ZG.LIT):
                TELL('It is now pitch black.', CR)
    else:
        TELL("You can't turn that off.", CR)
    return True

# zil: gverbs.zil:786  <ROUTINE V-LAMP-ON ()>
@ZG.routine('V-LAMP-ON')
def V_LAMP_ON():
    if FSET_p(ZG.PRSO, Flag('LIGHTBIT')):
        if FSET_p(ZG.PRSO, Flag('ONBIT')):
            TELL('It is already on.', CR)
        else:
            FSET(ZG.PRSO, Flag('ONBIT'))
            TELL('The ', D, ZG.PRSO, ' is now on.', CR)
            if (not ZG.LIT):
                ZG.LIT = ZG.LIT_p(ZG.HERE)
                CRLF()
                ZG.V_LOOK()
    elif FSET_p(ZG.PRSO, Flag('BURNBIT')):
        TELL('If you wish to burn the ', D, ZG.PRSO, ', you should say so.', CR)
    else:
        TELL("You can't turn that on.", CR)
    return True

# zil: gverbs.zil:804  <ROUTINE V-LAUNCH ()>
@ZG.routine('V-LAUNCH')
def V_LAUNCH():
    if FSET_p(ZG.PRSO, Flag('VEHBIT')):
        return TELL('You can\'t launch that by saying "launch"!', CR)
    else:
        return TELL("That's pretty weird.", CR)

# zil: gverbs.zil:810  <ROUTINE V-LEAN-ON ()>
@ZG.routine('V-LEAN-ON')
def V_LEAN_ON():
    return TELL('Getting tired?', CR)

# zil: gverbs.zil:813  <ROUTINE V-LEAP ("AUX" TX S)>
@ZG.routine('V-LEAP')
def V_LEAP():
    TX = 0
    S_l = 0
    if ZG.PRSO:
        if IN_p(ZG.PRSO, ZG.HERE):
            if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
                return TELL('The ', D, ZG.PRSO, ' is too big to jump over.', CR)
            else:
                return ZG.V_SKIP()
        else:
            return TELL('That would be a good trick.', CR)
    elif (TX := GETPT(ZG.HERE, 'DOWN')):
        S_l = PTSIZE(TX)
        if ((S_l == 2) or ((S_l == 4) and (not VALUE(GETB(TX, 1))))):
            TELL('This was not a very safe place to try jumping.', CR)
            return ZG.JIGS_UP(ZG.PICK_ONE(ZG.JUMPLOSS))
        elif (ZG.HERE == ZG.UP_A_TREE):
            TELL('In a feat of unaccustomed daring, you manage to land on your feet without\nkilling yourself.', CR, CR)
            ZG.DO_WALK('DOWN')
            return True
        else:
            return ZG.V_SKIP()
    else:
        return ZG.V_SKIP()

# zil: gverbs.zil:844  <GLOBAL JUMPLOSS>
# GLOBAL (state) JUMPLOSS = LTABLE(0, 'You should have looked before you leaped.', 'In the movies, your life would be passing before your eyes.', 'Geronimo...')  ->  ZilGlobal.py

# zil: gverbs.zil:850  <ROUTINE V-LEAVE ()>
@ZG.routine('V-LEAVE')
def V_LEAVE():
    return ZG.DO_WALK('OUT')

# zil: gverbs.zil:852  <ROUTINE V-LISTEN ()>
@ZG.routine('V-LISTEN')
def V_LISTEN():
    return TELL('The ', D, ZG.PRSO, ' makes no sound.', CR)

# zil: gverbs.zil:855  <ROUTINE V-LOCK ()>
@ZG.routine('V-LOCK')
def V_LOCK():
    return TELL("It doesn't seem to work.", CR)

# zil: gverbs.zil:858  <ROUTINE V-LOOK ()>
@ZG.routine('V-LOOK')
def V_LOOK():
    if ZG.DESCRIBE_ROOM(True):
        return ZG.DESCRIBE_OBJECTS(True)
    else:
        return False

# zil: gverbs.zil:862  <ROUTINE V-LOOK-BEHIND ()>
@ZG.routine('V-LOOK-BEHIND')
def V_LOOK_BEHIND():
    return TELL('There is nothing behind the ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:865  <ROUTINE V-LOOK-INSIDE ()>
@ZG.routine('V-LOOK-INSIDE')
def V_LOOK_INSIDE():
    if FSET_p(ZG.PRSO, Flag('DOORBIT')):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            TELL('The ', D, ZG.PRSO, " is open, but I can't tell what's beyond it.")
        else:
            TELL('The ', D, ZG.PRSO, ' is closed.')
        return CRLF()
    elif FSET_p(ZG.PRSO, Flag('CONTBIT')):
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            return TELL('There is nothing special to be seen.', CR)
        elif ZG.SEE_INSIDE_p(ZG.PRSO):
            if (FIRST_p(ZG.PRSO) and ZG.PRINT_CONT(ZG.PRSO)):
                return True
            elif ZG.NULL_F():
                return True
            else:
                return TELL('The ', D, ZG.PRSO, ' is empty.', CR)
        else:
            return TELL('The ', D, ZG.PRSO, ' is closed.', CR)
    else:
        return TELL("You can't look inside a ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:892  <ROUTINE V-LOOK-ON ()>
@ZG.routine('V-LOOK-ON')
def V_LOOK_ON():
    if FSET_p(ZG.PRSO, Flag('SURFACEBIT')):
        ZG.PERFORM(SYMBOL('V?LOOK-INSIDE'), ZG.PRSO)
        return True
    else:
        return TELL('Look on a ', D, ZG.PRSO, '???', CR)

# zil: gverbs.zil:899  <ROUTINE V-LOOK-UNDER ()>
@ZG.routine('V-LOOK-UNDER')
def V_LOOK_UNDER():
    return TELL('There is nothing but dust there.', CR)

# zil: gverbs.zil:902  <ROUTINE V-LOWER ()>
@ZG.routine('V-LOWER')
def V_LOWER():
    return ZG.HACK_HACK('Playing in this way with the ')

# zil: gverbs.zil:904  <ROUTINE V-MAKE ()>
@ZG.routine('V-MAKE')
def V_MAKE():
    return TELL("You can't do that.", CR)

# zil: gverbs.zil:907  <ROUTINE V-MELT ()>
@ZG.routine('V-MELT')
def V_MELT():
    return TELL("It's not clear that a ", D, ZG.PRSO, ' can be melted.', CR)

# zil: gverbs.zil:910  <ROUTINE PRE-MOVE ()>
@ZG.routine('PRE-MOVE')
def PRE_MOVE():
    if ZG.HELD_p(ZG.PRSO):
        return TELL("You aren't an accomplished enough juggler.", CR)
    else:
        return False

# zil: gverbs.zil:914  <ROUTINE V-MOVE ()>
@ZG.routine('V-MOVE')
def V_MOVE():
    if FSET_p(ZG.PRSO, Flag('TAKEBIT')):
        return TELL('Moving the ', D, ZG.PRSO, ' reveals nothing.', CR)
    else:
        return TELL("You can't move the ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:920  <ROUTINE V-MUMBLE ()>
@ZG.routine('V-MUMBLE')
def V_MUMBLE():
    return TELL("You'll have to speak up if you expect me to hear you!", CR)

# zil: gverbs.zil:923  <ROUTINE PRE-MUNG ()>
@ZG.routine('PRE-MUNG')
def PRE_MUNG():
    if ZG.NULL_F():
        return True
    elif ((not ZG.PRSI) or (not FSET_p(ZG.PRSI, Flag('WEAPONBIT')))):
        TELL('Trying to destroy the ', D, ZG.PRSO, ' with ')
        if (not ZG.PRSI):
            TELL('your bare hands')
        else:
            TELL('a ', D, ZG.PRSI)
        return TELL(' is futile.', CR)
    else:
        return False

# zil: gverbs.zil:938  <ROUTINE V-MUNG ()>
@ZG.routine('V-MUNG')
def V_MUNG():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSO)
        return True
    else:
        return TELL('Nice try.', CR)

# zil: gverbs.zil:945  <ROUTINE V-ODYSSEUS ()>
@ZG.routine('V-ODYSSEUS')
def V_ODYSSEUS():
    if ((ZG.HERE == ZG.CYCLOPS_ROOM) and IN_p(ZG.CYCLOPS, ZG.HERE) and (not ZG.CYCLOPS_FLAG)):
        ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS))
        ZG.CYCLOPS_FLAG = True
        TELL("The cyclops, hearing the name of his father's deadly nemesis, flees the room\nby knocking down the wall on the east of the room.", CR)
        ZG.MAGIC_FLAG = True
        FCLEAR(ZG.CYCLOPS, Flag('FIGHTBIT'))
        return ZG.REMOVE_CAREFULLY(ZG.CYCLOPS)
    else:
        return TELL("Wasn't he a sailor?", CR)

# zil: gverbs.zil:963  <ROUTINE V-OIL ()>
@ZG.routine('V-OIL')
def V_OIL():
    return TELL('You probably put spinach in your gas tank, too.', CR)

# zil: gverbs.zil:966  <ROUTINE V-OPEN ("AUX" F STR)>
@ZG.routine('V-OPEN')
def V_OPEN():
    F = 0
    STR = 0
    if (FSET_p(ZG.PRSO, Flag('CONTBIT')) and (not (GETP(ZG.PRSO, 'CAPACITY') == 0))):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            return TELL('It is already open.', CR)
        else:
            FSET(ZG.PRSO, Flag('OPENBIT'))
            FSET(ZG.PRSO, Flag('TOUCHBIT'))
            if ((not FIRST_p(ZG.PRSO)) or FSET_p(ZG.PRSO, Flag('TRANSBIT'))):
                return TELL('Opened.', CR)
            elif ((F := FIRST_p(ZG.PRSO)) and (not NEXT_p(F)) and (not FSET_p(F, Flag('TOUCHBIT'))) and (STR := GETP(F, 'FDESC'))):
                TELL('The ', D, ZG.PRSO, ' opens.', CR)
                return TELL(STR, CR)
            else:
                TELL('Opening the ', D, ZG.PRSO, ' reveals ')
                ZG.PRINT_CONTENTS(ZG.PRSO)
                return TELL('.', CR)
    elif FSET_p(ZG.PRSO, Flag('DOORBIT')):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            return TELL('It is already open.', CR)
        else:
            TELL('The ', D, ZG.PRSO, ' opens.', CR)
            return FSET(ZG.PRSO, Flag('OPENBIT'))
    else:
        return TELL('You must tell me how to do that to a ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:996  <ROUTINE V-OVERBOARD ("AUX" LOCN)>
@ZG.routine('V-OVERBOARD')
def V_OVERBOARD():
    LOCN = 0
    if (ZG.PRSI == ZG.TEETH):
        if FSET_p((LOCN := LOC(ZG.WINNER)), Flag('VEHBIT')):
            MOVE(ZG.PRSO, LOC(LOCN))
            return TELL('Ahoy -- ', D, ZG.PRSO, ' overboard!', CR)
        else:
            return TELL("You're not in anything!", CR)
    elif FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
        ZG.PERFORM(SYMBOL('V?THROW'), ZG.PRSO)
        return True
    else:
        return TELL('Huh?', CR)

# zil: gverbs.zil:1011  <ROUTINE V-PICK ()>
@ZG.routine('V-PICK')
def V_PICK():
    return TELL("You can't pick that.", CR)

# zil: gverbs.zil:1013  <ROUTINE V-PLAY ()>
@ZG.routine('V-PLAY')
def V_PLAY():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        TELL('You become so engrossed in the role of the ', D, ZG.PRSO, ' that\nyou kill yourself, just as he might have done!', CR)
        return ZG.JIGS_UP('')
    else:
        return TELL("That's silly!", CR)

# zil: gverbs.zil:1021  <ROUTINE V-PLUG ()>
@ZG.routine('V-PLUG')
def V_PLUG():
    return TELL('This has no effect.', CR)

# zil: gverbs.zil:1024  <ROUTINE V-POUR-ON ()>
@ZG.routine('V-POUR-ON')
def V_POUR_ON():
    if (ZG.PRSO == ZG.WATER):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        if FLAMING_p(ZG.PRSI):
            TELL('The ', D, ZG.PRSI, ' is extinguished.', CR)
            ZG.NULL_F()
            FCLEAR(ZG.PRSI, Flag('ONBIT'))
            return FCLEAR(ZG.PRSI, Flag('FLAMEBIT'))
        else:
            return TELL('The water spills over the ', D, ZG.PRSI, ', to the floor, and evaporates.', CR)
    elif (ZG.PRSO == ZG.PUTTY):
        return ZG.PERFORM(SYMBOL('V?PUT'), ZG.PUTTY, ZG.PRSI)
    else:
        return TELL("You can't pour that.", CR)

# zil: gverbs.zil:1046  <ROUTINE V-PRAY ()>
@ZG.routine('V-PRAY')
def V_PRAY():
    if (ZG.HERE == ZG.SOUTH_TEMPLE):
        return ZG.GOTO(ZG.FOREST_1)
    else:
        return TELL('If you pray enough, your prayers may be answered.', CR)

# zil: gverbs.zil:1056  <ROUTINE V-PUMP ()>
@ZG.routine('V-PUMP')
def V_PUMP():
    if (ZG.PRSI and (not (ZG.PRSI == ZG.PUMP))):
        return TELL('Pump it up with a ', D, ZG.PRSI, '?', CR)
    elif IN_p(ZG.PUMP, ZG.WINNER):
        return ZG.PERFORM(SYMBOL('V?INFLATE'), ZG.PRSO, ZG.PUMP)
    else:
        return TELL("It's really not clear how.", CR)

# zil: gverbs.zil:1070  <ROUTINE V-PUSH ()>
@ZG.routine('V-PUSH')
def V_PUSH():
    return ZG.HACK_HACK('Pushing the ')

# zil: gverbs.zil:1072  <ROUTINE V-PUSH-TO ()>
@ZG.routine('V-PUSH-TO')
def V_PUSH_TO():
    return TELL("You can't push things to that.", CR)

# zil: gverbs.zil:1075  <ROUTINE PRE-PUT ()>
@ZG.routine('PRE-PUT')
def PRE_PUT():
    if ZG.NULL_F():
        return False
    else:
        return ZG.PRE_GIVE()

# ;"That's easy for you to say..."

# zil: gverbs.zil:1085  <ROUTINE V-PUT ()>
@ZG.routine('V-PUT')
def V_PUT():
    if (FSET_p(ZG.PRSI, Flag('OPENBIT')) or OPENABLE_p(ZG.PRSI) or FSET_p(ZG.PRSI, Flag('VEHBIT'))):
        pass
    else:
        TELL("You can't do that.", CR)
        return True
    if (not FSET_p(ZG.PRSI, Flag('OPENBIT'))):
        TELL('The ', D, ZG.PRSI, " isn't open.", CR)
        return ZG.THIS_IS_IT(ZG.PRSI)
    elif (ZG.PRSI == ZG.PRSO):
        return TELL('How can you do that?', CR)
    elif IN_p(ZG.PRSO, ZG.PRSI):
        return TELL('The ', D, ZG.PRSO, ' is already in the ', D, ZG.PRSI, '.', CR)
    elif (((ZG.WEIGHT(ZG.PRSI) + ZG.WEIGHT(ZG.PRSO)) - GETP(ZG.PRSI, 'SIZE')) > GETP(ZG.PRSI, 'CAPACITY')):
        return TELL("There's no room.", CR)
    elif ((not ZG.HELD_p(ZG.PRSO)) and FSET_p(ZG.PRSO, Flag('TRYTAKEBIT'))):
        TELL("You don't have the ", D, ZG.PRSO, '.', CR)
        return True
    elif ((not ZG.HELD_p(ZG.PRSO)) and (not ZG.ITAKE())):
        return True
    else:
        MOVE(ZG.PRSO, ZG.PRSI)
        FSET(ZG.PRSO, Flag('TOUCHBIT'))
        ZG.SCORE_OBJ(ZG.PRSO)
        return TELL('Done.', CR)

# zil: gverbs.zil:1116  <ROUTINE V-PUT-BEHIND ()>
@ZG.routine('V-PUT-BEHIND')
def V_PUT_BEHIND():
    return TELL('That hiding place is too obvious.', CR)

# zil: gverbs.zil:1119  <ROUTINE V-PUT-ON ()>
@ZG.routine('V-PUT-ON')
def V_PUT_ON():
    if (ZG.PRSI == ZG.GROUND):
        ZG.PERFORM(SYMBOL('V?DROP'), ZG.PRSO)
        return True
    elif FSET_p(ZG.PRSI, Flag('SURFACEBIT')):
        return ZG.V_PUT()
    else:
        return TELL("There's no good surface on the ", D, ZG.PRSI, '.', CR)

# zil: gverbs.zil:1128  <ROUTINE V-PUT-UNDER ()>
@ZG.routine('V-PUT-UNDER')
def V_PUT_UNDER():
    return TELL("You can't do that.", CR)

# zil: gverbs.zil:1131  <ROUTINE V-RAISE ()>
@ZG.routine('V-RAISE')
def V_RAISE():
    return ZG.V_LOWER()

# zil: gverbs.zil:1134  <ROUTINE V-RAPE ()>
@ZG.routine('V-RAPE')
def V_RAPE():
    return TELL('What a (ahem!) strange idea.', CR)

# zil: gverbs.zil:1137  <ROUTINE PRE-READ ()>
@ZG.routine('PRE-READ')
def PRE_READ():
    if (not ZG.LIT):
        return TELL('It is impossible to read in the dark.', CR)
    elif (ZG.PRSI and (not FSET_p(ZG.PRSI, Flag('TRANSBIT')))):
        return TELL('How does one look through a ', D, ZG.PRSI, '?', CR)
    else:
        return False

# zil: gverbs.zil:1143  <ROUTINE V-READ ()>
@ZG.routine('V-READ')
def V_READ():
    if (not FSET_p(ZG.PRSO, Flag('READBIT'))):
        return TELL('How does one read a ', D, ZG.PRSO, '?', CR)
    else:
        return TELL(GETP(ZG.PRSO, 'TEXT'), CR)

# zil: gverbs.zil:1149  <ROUTINE V-READ-PAGE ()>
@ZG.routine('V-READ-PAGE')
def V_READ_PAGE():
    ZG.PERFORM(SYMBOL('V?READ'), ZG.PRSO)
    return True

# zil: gverbs.zil:1153  <ROUTINE V-REPENT ()>
@ZG.routine('V-REPENT')
def V_REPENT():
    return TELL('It could very well be too late!', CR)

# zil: gverbs.zil:1156  <ROUTINE V-REPLY ()>
@ZG.routine('V-REPLY')
def V_REPLY():
    TELL('It is hardly likely that the ', D, ZG.PRSO, ' is interested.', CR)
    ZG.P_CONT = False
    ZG.QUOTE_FLAG = False
    return True

# zil: gverbs.zil:1162  <ROUTINE V-RING ()>
@ZG.routine('V-RING')
def V_RING():
    return TELL('How, exactly, can you ring that?', CR)

# zil: gverbs.zil:1165  <ROUTINE V-RUB ()>
@ZG.routine('V-RUB')
def V_RUB():
    return ZG.HACK_HACK('Fiddling with the ')

# zil: gverbs.zil:1167  <ROUTINE V-SAY ("AUX" V)>
@ZG.routine('V-SAY')
def V_SAY():
    V = 0
    if (not ZG.P_CONT):
        TELL('Say what?', CR)
        return True
    ZG.QUOTE_FLAG = False
    if (V := ZG.FIND_IN(ZG.HERE, Flag('ACTORBIT'))):
        TELL('You must address the ', D, V, ' directly.', CR)
        ZG.P_CONT = False
    elif (not (GET(ZG.P_LEXV, ZG.P_CONT) == WORD('hello'))):
        ZG.P_CONT = False
        TELL('Talking to yourself is a sign of impending mental collapse.', CR)
    return True

# zil: gverbs.zil:1197  <ROUTINE V-SEARCH ()>
@ZG.routine('V-SEARCH')
def V_SEARCH():
    return TELL('You find nothing unusual.', CR)

# zil: gverbs.zil:1200  <ROUTINE V-SEND ()>
@ZG.routine('V-SEND')
def V_SEND():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL('Why would you send for the ', D, ZG.PRSO, '?', CR)
    else:
        return TELL("That doesn't make sends.", CR)

# zil: gverbs.zil:1206  <ROUTINE PRE-SGIVE ()>
@ZG.routine('PRE-SGIVE')
def PRE_SGIVE():
    ZG.PERFORM(SYMBOL('V?GIVE'), ZG.PRSI, ZG.PRSO)
    return True

# zil: gverbs.zil:1210  <ROUTINE V-SGIVE ()>
@ZG.routine('V-SGIVE')
def V_SGIVE():
    return TELL('Foo!', CR)

# zil: gverbs.zil:1213  <ROUTINE V-SHAKE ()>
@ZG.routine('V-SHAKE')
def V_SHAKE():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL('This seems to have no effect.', CR)
    elif (not FSET_p(ZG.PRSO, Flag('TAKEBIT'))):
        return TELL("You can't take it; thus, you can't shake it!", CR)
    elif FSET_p(ZG.PRSO, Flag('CONTBIT')):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            if FIRST_p(ZG.PRSO):
                ZG.SHAKE_LOOP()
                TELL('The contents of the ', D, ZG.PRSO, ' spill ')
                if (not FSET_p(ZG.HERE, Flag('RLANDBIT'))):
                    TELL('out and disappears')
                else:
                    TELL('to the ground')
                return TELL('.', CR)
            else:
                return TELL('Shaken.', CR)
        else:
            if FIRST_p(ZG.PRSO):
                return TELL('It sounds like there is something inside the ', D, ZG.PRSO, '.', CR)
            else:
                return TELL('The ', D, ZG.PRSO, ' sounds empty.', CR)
    else:
        return TELL('Shaken.', CR)

# zil: gverbs.zil:1242  <ROUTINE SHAKE-LOOP ("AUX" X)>
@ZG.routine('SHAKE-LOOP')
def SHAKE_LOOP():
    X = 0
    while True:
        if (X := FIRST_p(ZG.PRSO)):
            FSET(X, Flag('TOUCHBIT'))
            if (ZG.HERE == ZG.UP_A_TREE):
                _tmp1 = ZG.PATH
            elif (not FSET_p(ZG.HERE, Flag('RLANDBIT'))):
                _tmp1 = ZG.PSEUDO_OBJECT
            else:
                _tmp1 = ZG.HERE
            if (ZG.HERE == ZG.UP_A_TREE):
                _tmp2 = ZG.PATH
            elif (not FSET_p(ZG.HERE, Flag('RLANDBIT'))):
                _tmp2 = ZG.PSEUDO_OBJECT
            else:
                _tmp2 = ZG.HERE
            MOVE(X, _tmp2)
        else:
            return True

# zil: gverbs.zil:1269  <ROUTINE V-SKIP ()>
@ZG.routine('V-SKIP')
def V_SKIP():
    return TELL(ZG.PICK_ONE(ZG.WHEEEEE), CR)

# zil: gverbs.zil:1272  <GLOBAL WHEEEEE>
# GLOBAL (state) WHEEEEE = LTABLE(0, 'Very good. Now you can go to the second grade.', 'Are you enjoying yourself?', 'Wheeeeeeeeee!!!!!', 'Do you expect me to applaud?')  ->  ZilGlobal.py

# zil: gverbs.zil:1278  <ROUTINE V-SMELL ()>
@ZG.routine('V-SMELL')
def V_SMELL():
    return TELL('It smells like a ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:1281  <ROUTINE V-SPIN ()>
@ZG.routine('V-SPIN')
def V_SPIN():
    return TELL("You can't spin that!", CR)

# zil: gverbs.zil:1284  <ROUTINE V-SPRAY ()>
@ZG.routine('V-SPRAY')
def V_SPRAY():
    return ZG.V_SQUEEZE()

# zil: gverbs.zil:1287  <ROUTINE V-SQUEEZE ()>
@ZG.routine('V-SQUEEZE')
def V_SQUEEZE():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        TELL('The ', D, ZG.PRSO, ' does not understand this.')
    else:
        TELL('How singularly useless.')
    return CRLF()

# zil: gverbs.zil:1294  <ROUTINE V-SSPRAY ()>
@ZG.routine('V-SSPRAY')
def V_SSPRAY():
    return ZG.PERFORM(SYMBOL('V?SPRAY'), ZG.PRSI, ZG.PRSO)

# zil: gverbs.zil:1297  <ROUTINE V-STAB ("AUX" W)>
@ZG.routine('V-STAB')
def V_STAB():
    W = 0
    if (W := ZG.FIND_WEAPON(ZG.WINNER)):
        ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSO, W)
        return True
    else:
        return TELL('No doubt you propose to stab the ', D, ZG.PRSO, ' with your pinky?', CR)

# zil: gverbs.zil:1305  <ROUTINE V-STAND ()>
@ZG.routine('V-STAND')
def V_STAND():
    if FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), LOC(ZG.WINNER))
        return True
    else:
        return TELL('You are already standing, I think.', CR)

# zil: gverbs.zil:1312  <ROUTINE V-STAY ()>
@ZG.routine('V-STAY')
def V_STAY():
    return TELL('You will be lost without me!', CR)

# zil: gverbs.zil:1315  <ROUTINE V-STRIKE ()>
@ZG.routine('V-STRIKE')
def V_STRIKE():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL("Since you aren't versed in hand-to-hand combat, you'd better attack the ", D, ZG.PRSO, ' with a weapon.', CR)
    else:
        ZG.PERFORM(SYMBOL('V?LAMP-ON'), ZG.PRSO)
        return True

# zil: gverbs.zil:1324  <ROUTINE V-SWIM ()>
@ZG.routine('V-SWIM')
def V_SWIM():
    if ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE):
        TELL("Swimming isn't usually allowed in the ")
        if (not (ZG.PRSO in (ZG.WATER, ZG.GLOBAL_WATER))):
            TELL(D, ZG.PRSO, '.')
        else:
            TELL('dungeon.')
        return CRLF()
    elif ZG.NULL_F():
        return False
    else:
        return TELL('Go jump in a lake!', CR)

# zil: gverbs.zil:1347  <ROUTINE V-SWING ()>
@ZG.routine('V-SWING')
def V_SWING():
    if (not ZG.PRSI):
        return TELL('Whoosh!', CR)
    else:
        return ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSI, ZG.PRSO)

# zil: gverbs.zil:1353  <ROUTINE PRE-TAKE ()>
@ZG.routine('PRE-TAKE')
def PRE_TAKE():
    if IN_p(ZG.PRSO, ZG.WINNER):
        if FSET_p(ZG.PRSO, Flag('WEARBIT')):
            return TELL('You are already wearing it.', CR)
        else:
            return TELL('You already have that!', CR)
    elif (FSET_p(LOC(ZG.PRSO), Flag('CONTBIT')) and (not FSET_p(LOC(ZG.PRSO), Flag('OPENBIT')))):
        TELL("You can't reach something that's inside a closed container.", CR)
        return True
    elif ZG.PRSI:
        if (ZG.PRSI == ZG.GROUND):
            ZG.PRSI = False
            return False
        ZG.NULL_F()
        if (not (ZG.PRSI == LOC(ZG.PRSO))):
            return TELL('The ', D, ZG.PRSO, " isn't in the ", D, ZG.PRSI, '.', CR)
        else:
            ZG.PRSI = False
            return False
    elif (ZG.PRSO == LOC(ZG.WINNER)):
        return TELL("You're inside of it!", CR)
    else:
        return False

# zil: gverbs.zil:1382  <ROUTINE V-TAKE ()>
@ZG.routine('V-TAKE')
def V_TAKE():
    if (ZG.ITAKE() == True):
        if FSET_p(ZG.PRSO, Flag('WEARBIT')):
            return TELL('You are now wearing the ', D, ZG.PRSO, '.', CR)
        else:
            return TELL('Taken.', CR)
    else:
        return False

# zil: gverbs.zil:1389  <ROUTINE V-TELL ()>
@ZG.routine('V-TELL')
def V_TELL():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        if ZG.P_CONT:
            ZG.WINNER = ZG.PRSO
            ZG.HERE = LOC(ZG.WINNER)
            return ZG.HERE
        else:
            return TELL('The ', D, ZG.PRSO, ' pauses for a moment, perhaps thinking that you should reread\nthe manual.', CR)
    else:
        TELL("You can't talk to the ", D, ZG.PRSO, '!', CR)
        ZG.QUOTE_FLAG = False
        ZG.P_CONT = False
        return 2

# zil: gverbs.zil:1404  <ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)>
@ZG.routine('V-THROUGH')
def V_THROUGH(OBJ_l=None):
    if OBJ_l is None:
        OBJ_l = False
    M = 0
    if (FSET_p(ZG.PRSO, Flag('DOORBIT')) and (M := ZG.OTHER_SIDE(ZG.PRSO))):
        ZG.DO_WALK(M)
        return True
    elif ((not OBJ_l) and FSET_p(ZG.PRSO, Flag('VEHBIT'))):
        ZG.PERFORM(SYMBOL('V?BOARD'), ZG.PRSO)
        return True
    elif (OBJ_l or (not FSET_p(ZG.PRSO, Flag('TAKEBIT')))):
        ZG.NULL_F()
        return TELL('You hit your head against the ', D, ZG.PRSO, ' as you attempt this feat.', CR)
    elif IN_p(ZG.PRSO, ZG.WINNER):
        return TELL('That would involve quite a contortion!', CR)
    else:
        return TELL(ZG.PICK_ONE(ZG.YUKS), CR)

# zil: gverbs.zil:1445  <ROUTINE V-THROW ()>
@ZG.routine('V-THROW')
def V_THROW():
    if ZG.IDROP():
        if (ZG.PRSI == ZG.ME):
            TELL('A terrific throw! The ', D, ZG.PRSO)
            ZG.WINNER = ZG.PLAYER
            return ZG.JIGS_UP(" hits you squarely in the head. Normally,\nthis wouldn't do much damage, but by incredible mischance, you fall over\nbackwards trying to duck, and break your neck, justice being swift and\nmerciful in the Great Underground Empire.")
        elif (ZG.PRSI and FSET_p(ZG.PRSI, Flag('ACTORBIT'))):
            return TELL('The ', D, ZG.PRSI, ' ducks as the ', D, ZG.PRSO, ' flies by and crashes to the ground.', CR)
        else:
            return TELL('Thrown.', CR)
    else:
        return TELL('Huh?', CR)

# zil: gverbs.zil:1462  <ROUTINE V-THROW-OFF ()>
@ZG.routine('V-THROW-OFF')
def V_THROW_OFF():
    return TELL("You can't throw anything off of that!", CR)

# zil: gverbs.zil:1465  <ROUTINE V-TIE ()>
@ZG.routine('V-TIE')
def V_TIE():
    if (ZG.PRSI == ZG.WINNER):
        return TELL("You can't tie anything to yourself.", CR)
    else:
        return TELL("You can't tie the ", D, ZG.PRSO, ' to that.', CR)

# zil: gverbs.zil:1471  <ROUTINE V-TIE-UP ()>
@ZG.routine('V-TIE-UP')
def V_TIE_UP():
    return TELL('You could certainly never tie it with that!', CR)

# zil: gverbs.zil:1474  <ROUTINE V-TREASURE ()>
@ZG.routine('V-TREASURE')
def V_TREASURE():
    if (ZG.HERE == ZG.NORTH_TEMPLE):
        return ZG.GOTO(ZG.TREASURE_ROOM)
    elif (ZG.HERE == ZG.TREASURE_ROOM):
        return ZG.GOTO(ZG.NORTH_TEMPLE)
    else:
        return TELL('Nothing happens.', CR)

# zil: gverbs.zil:1488  <ROUTINE PRE-TURN ()>
@ZG.routine('PRE-TURN')
def PRE_TURN():
    if ((ZG.PRSI in (False, ZG.ROOMS)) and (not (ZG.PRSO == ZG.BOOK))):
        return TELL("Your bare hands don't appear to be enough.", CR)
    elif (not FSET_p(ZG.PRSO, Flag('TURNBIT'))):
        return TELL("You can't turn that!", CR)
    else:
        return False

# zil: gverbs.zil:1505  <ROUTINE V-TURN ()>
@ZG.routine('V-TURN')
def V_TURN():
    return TELL('This has no effect.', CR)

# zil: gverbs.zil:1508  <ROUTINE V-UNLOCK ()>
@ZG.routine('V-UNLOCK')
def V_UNLOCK():
    return ZG.V_LOCK()

# zil: gverbs.zil:1511  <ROUTINE V-UNTIE ()>
@ZG.routine('V-UNTIE')
def V_UNTIE():
    return TELL('This cannot be tied, so it cannot be untied!', CR)

# zil: gverbs.zil:1514  <ROUTINE V-WAIT ("OPTIONAL" (NUM 3))>
@ZG.routine('V-WAIT')
def V_WAIT(NUM_l=None):
    if NUM_l is None:
        NUM_l = 3
    TELL('Time passes...', CR)
    while True:
        if ((NUM_l := (NUM_l - 1)) < 0):
            break
        elif ZG.CLOCKER():
            break
    ZG.CLOCK_WAIT = True
    return ZG.CLOCK_WAIT

# zil: gverbs.zil:1521  <ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)>
@ZG.routine('V-WALK')
def V_WALK():
    PT = 0
    PTS = 0
    STR = 0
    OBJ_l = 0
    RM = 0
    if (not ZG.P_WALK_DIR):
        ZG.PERFORM(SYMBOL('V?WALK-TO'), ZG.PRSO)
        return True
    elif (PT := GETPT(ZG.HERE, ZG.PRSO)):
        if ((PTS := PTSIZE(PT)) == ZG.UEXIT):
            return ZG.GOTO(GETB(PT, ZG.REXIT))
        elif (PTS == ZG.NEXIT):
            TELL(GET(PT, ZG.NEXITSTR), CR)
            return 2
        elif (PTS == ZG.FEXIT):
            if (RM := APPLY(GET(PT, ZG.FEXITFCN))):
                return ZG.GOTO(RM)
            elif ZG.NULL_F():
                return False
            else:
                return 2
        elif (PTS == ZG.CEXIT):
            if VALUE(GETB(PT, ZG.CEXITFLAG)):
                return ZG.GOTO(GETB(PT, ZG.REXIT))
            elif (STR := GET(PT, ZG.CEXITSTR)):
                TELL(STR, CR)
                return 2
            else:
                TELL("You can't go that way.", CR)
                return 2
        elif (PTS == ZG.DEXIT):
            if FSET_p((OBJ_l := GETB(PT, ZG.DEXITOBJ)), Flag('OPENBIT')):
                return ZG.GOTO(GETB(PT, ZG.REXIT))
            elif (STR := GET(PT, ZG.DEXITSTR)):
                TELL(STR, CR)
                return 2
            else:
                TELL('The ', D, OBJ_l, ' is closed.', CR)
                ZG.THIS_IS_IT(OBJ_l)
                return 2
        else:
            return False
    elif ((not ZG.LIT) and ZG.PROB_1(80) and (ZG.WINNER == ZG.ADVENTURER) and (not FSET_p(ZG.HERE, Flag('NONLANDBIT')))):
        if ZG.SPRAYED_p:
            TELL('There are odd noises in the darkness, and there is no exit in that\ndirection.', CR)
            return 2
        elif ZG.NULL_F():
            return False
        else:
            return ZG.JIGS_UP('Oh, no! You have walked into the slavering fangs of a lurking grue!')
    else:
        TELL("You can't go that way.", CR)
        return 2

# zil: gverbs.zil:1583  <ROUTINE V-WALK-AROUND ()>
@ZG.routine('V-WALK-AROUND')
def V_WALK_AROUND():
    return TELL('Use compass directions for movement.', CR)

# zil: gverbs.zil:1586  <ROUTINE V-WALK-TO ()>
@ZG.routine('V-WALK-TO')
def V_WALK_TO():
    if (ZG.PRSO and (IN_p(ZG.PRSO, ZG.HERE) or ZG.GLOBAL_IN_p(ZG.PRSO, ZG.HERE))):
        return TELL("It's here!", CR)
    else:
        return TELL('You should supply a direction!', CR)

# zil: gverbs.zil:1594  <ROUTINE V-WAVE ()>
@ZG.routine('V-WAVE')
def V_WAVE():
    return ZG.HACK_HACK('Waving the ')

# zil: gverbs.zil:1597  <ROUTINE V-WEAR ()>
@ZG.routine('V-WEAR')
def V_WEAR():
    if (not FSET_p(ZG.PRSO, Flag('WEARBIT'))):
        return TELL("You can't wear the ", D, ZG.PRSO, '.', CR)
    else:
        ZG.PERFORM(SYMBOL('V?TAKE'), ZG.PRSO)
        return True

# zil: gverbs.zil:1604  <ROUTINE V-WIN ()>
@ZG.routine('V-WIN')
def V_WIN():
    return TELL('Naturally!', CR)

# zil: gverbs.zil:1607  <ROUTINE V-WIND ()>
@ZG.routine('V-WIND')
def V_WIND():
    return TELL('You cannot wind up a ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:1610  <ROUTINE V-WISH ()>
@ZG.routine('V-WISH')
def V_WISH():
    return TELL('With luck, your wish will come true.', CR)

# zil: gverbs.zil:1616  <ROUTINE V-YELL ()>
@ZG.routine('V-YELL')
def V_YELL():
    return TELL('Aaaarrrrgggghhhh!', CR)

# zil: gverbs.zil:1618  <ROUTINE V-ZORK ()>
@ZG.routine('V-ZORK')
def V_ZORK():
    return TELL('At your service!', CR)

'Verb-Associated Routines'

'Descriptions'

# zil: gverbs.zil:1626  <GLOBAL LIT>
# GLOBAL (state) LIT = False  ->  ZilGlobal.py

# zil: gverbs.zil:1628  <GLOBAL SPRAYED?>
# GLOBAL (state) SPRAYED_p = False  ->  ZilGlobal.py

# zil: gverbs.zil:1630  <ROUTINE V-FIRST-LOOK ()>
@ZG.routine('V-FIRST-LOOK')
def V_FIRST_LOOK():
    if ZG.DESCRIBE_ROOM():
        if (not ZG.SUPER_BRIEF):
            return ZG.DESCRIBE_OBJECTS()
        else:
            return False
    else:
        return False

# zil: gverbs.zil:1635  <ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)>
@ZG.routine('DESCRIBE-ROOM')
def DESCRIBE_ROOM(LOOK_p=None):
    if LOOK_p is None:
        LOOK_p = False
    V_p = 0
    STR = 0
    AV = 0
    V_p = (LOOK_p or ZG.VERBOSE)
    if (not ZG.LIT):
        TELL('It is pitch black.')
        if (not ZG.SPRAYED_p):
            TELL(' You are likely to be eaten by a grue.')
        CRLF()
        ZG.NULL_F()
        return False
    if (not FSET_p(ZG.HERE, Flag('TOUCHBIT'))):
        FSET(ZG.HERE, Flag('TOUCHBIT'))
        V_p = True
    if FSET_p(ZG.HERE, Flag('MAZEBIT')):
        FCLEAR(ZG.HERE, Flag('TOUCHBIT'))
    if IN_p(ZG.HERE, ZG.ROOMS):
        TELL(D, ZG.HERE)
        if FSET_p((AV := LOC(ZG.WINNER)), Flag('VEHBIT')):
            TELL(', in the ', D, AV)
        CRLF()
    if (LOOK_p or (not ZG.SUPER_BRIEF)):
        AV = LOC(ZG.WINNER)
        if (V_p and APPLY(GETP(ZG.HERE, 'ACTION'), ZG.M_LOOK)):
            return True
        elif (V_p and (STR := GETP(ZG.HERE, 'LDESC'))):
            TELL(STR, CR)
        else:
            APPLY(GETP(ZG.HERE, 'ACTION'), ZG.M_FLASH)
        if ((not (ZG.HERE == AV)) and FSET_p(AV, Flag('VEHBIT'))):
            APPLY(GETP(AV, 'ACTION'), ZG.M_LOOK)
    return True

# zil: gverbs.zil:1681  <ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))>
@ZG.routine('DESCRIBE-OBJECTS')
def DESCRIBE_OBJECTS(V_p=None):
    if V_p is None:
        V_p = False
    if ZG.LIT:
        if FIRST_p(ZG.HERE):
            return ZG.PRINT_CONT(ZG.HERE, (V_p := (V_p or ZG.VERBOSE)), -1)
        else:
            return False
    else:
        return TELL("Only bats can see in the dark. And you're not one.", CR)

'DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a\nlong description (fdesc or ldesc), otherwise will print short.'

# zil: gverbs.zil:1691  <GLOBAL DESC-OBJECT>
# GLOBAL (state) DESC_OBJECT = False  ->  ZilGlobal.py

# zil: gverbs.zil:1693  <ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)>
@ZG.routine('DESCRIBE-OBJECT')
def DESCRIBE_OBJECT(OBJ_l, V_p, LEVEL):
    STR = False
    AV = 0
    ZG.DESC_OBJECT = OBJ_l
    if ((LEVEL == 0) and APPLY(GETP(OBJ_l, 'DESCFCN'), ZG.M_OBJDESC)):
        return True
    elif ((LEVEL == 0) and (((not FSET_p(OBJ_l, Flag('TOUCHBIT'))) and (STR := GETP(OBJ_l, 'FDESC'))) or (STR := GETP(OBJ_l, 'LDESC')))):
        TELL(STR)
    elif (LEVEL == 0):
        TELL('There is a ', D, OBJ_l, ' here')
        if FSET_p(OBJ_l, Flag('ONBIT')):
            TELL(' (providing light)')
        TELL('.')
    else:
        TELL(GET(ZG.INDENTS, LEVEL))
        TELL('A ', D, OBJ_l)
        if FSET_p(OBJ_l, Flag('ONBIT')):
            TELL(' (providing light)')
        elif (FSET_p(OBJ_l, Flag('WEARBIT')) and IN_p(OBJ_l, ZG.WINNER)):
            TELL(' (being worn)')
    ZG.NULL_F()
    if ((LEVEL == 0) and (AV := LOC(ZG.WINNER)) and FSET_p(AV, Flag('VEHBIT'))):
        TELL(' (outside the ', D, AV, ')')
    CRLF()
    if (ZG.SEE_INSIDE_p(OBJ_l) and FIRST_p(OBJ_l)):
        return ZG.PRINT_CONT(OBJ_l, V_p, LEVEL)
    else:
        return False

# zil: gverbs.zil:1730  <ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))>
@ZG.routine('PRINT-CONTENTS')
def PRINT_CONTENTS(OBJ_l):
    F = 0
    N_l = 0
    _1ST_p = True
    IT_p = False
    TWO_p = False
    if (F := FIRST_p(OBJ_l)):
        while True:
            N_l = NEXT_p(F)
            if _1ST_p:
                _1ST_p = False
            else:
                TELL(', ')
                if (not N_l):
                    TELL('and ')
            TELL('a ', D, F)
            if ((not IT_p) and (not TWO_p)):
                IT_p = F
            else:
                TWO_p = True
                IT_p = False
            F = N_l
            if (not F):
                if (IT_p and (not TWO_p)):
                    ZG.THIS_IS_IT(IT_p)
                return True
    else:
        return False

# zil: gverbs.zil:1750  <ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0) "AUX" Y 1ST? SHIT AV ST...
@ZG.routine('PRINT-CONT')
def PRINT_CONT(OBJ_l, V_p=None, LEVEL=None):
    if V_p is None:
        V_p = False
    if LEVEL is None:
        LEVEL = 0
    Y = 0
    _1ST_p = 0
    SHIT = 0
    AV = 0
    STR = 0
    PV_p = False
    INV_p = False
    if (not (Y := FIRST_p(OBJ_l))):
        return True
    if ((AV := LOC(ZG.WINNER)) and FSET_p(AV, Flag('VEHBIT'))):
        pass
    else:
        AV = False
    _1ST_p = True
    SHIT = True
    if (ZG.WINNER in (OBJ_l, LOC(OBJ_l))):
        INV_p = True
    else:
        while True:
            if (not Y):
                break
            elif (Y == AV):
                PV_p = True
            elif (Y == ZG.WINNER):
                pass
            elif ((not FSET_p(Y, Flag('INVISIBLE'))) and (not FSET_p(Y, Flag('TOUCHBIT'))) and (STR := GETP(Y, 'FDESC'))):
                if (not FSET_p(Y, Flag('NDESCBIT'))):
                    TELL(STR, CR)
                    SHIT = False
                if (ZG.SEE_INSIDE_p(Y) and (not GETP(LOC(Y), 'DESCFCN')) and FIRST_p(Y)):
                    if ZG.PRINT_CONT(Y, V_p, 0):
                        _1ST_p = False
            Y = NEXT_p(Y)
    Y = FIRST_p(OBJ_l)
    while True:
        if (not Y):
            if (PV_p and AV and FIRST_p(AV)):
                LEVEL = (LEVEL + 1)
                ZG.PRINT_CONT(AV, V_p, LEVEL)
            break
        elif (Y in (AV, ZG.ADVENTURER)):
            pass
        elif ((not FSET_p(Y, Flag('INVISIBLE'))) and (INV_p or FSET_p(Y, Flag('TOUCHBIT')) or (not GETP(Y, 'FDESC')))):
            if (not FSET_p(Y, Flag('NDESCBIT'))):
                if _1ST_p:
                    if ZG.FIRSTER(OBJ_l, LEVEL):
                        if (LEVEL < 0):
                            LEVEL = 0
                    LEVEL = (1 + LEVEL)
                    _1ST_p = False
                if (LEVEL < 0):
                    LEVEL = 0
                ZG.DESCRIBE_OBJECT(Y, V_p, LEVEL)
            elif (FIRST_p(Y) and ZG.SEE_INSIDE_p(Y)):
                LEVEL = (LEVEL + 1)
                ZG.PRINT_CONT(Y, V_p, LEVEL)
                LEVEL = (LEVEL - 1)
        Y = NEXT_p(Y)
    if (_1ST_p and SHIT):
        return False
    else:
        return True

# zil: gverbs.zil:1818  <ROUTINE FIRSTER (OBJ LEVEL)>
@ZG.routine('FIRSTER')
def FIRSTER(OBJ_l, LEVEL):
    if (OBJ_l == ZG.TROPHY_CASE):
        return TELL('Your collection of treasures consists of:', CR)
    elif (OBJ_l == ZG.WINNER):
        return TELL('You are carrying:', CR)
    elif (not IN_p(OBJ_l, ZG.ROOMS)):
        if (LEVEL > 0):
            TELL(GET(ZG.INDENTS, LEVEL))
        if FSET_p(OBJ_l, Flag('SURFACEBIT')):
            return TELL('Sitting on the ', D, OBJ_l, ' is: ', CR)
        elif FSET_p(OBJ_l, Flag('ACTORBIT')):
            return TELL('The ', D, OBJ_l, ' is holding: ', CR)
        else:
            return TELL('The ', D, OBJ_l, ' contains:', CR)
    else:
        return False

# zil: gverbs.zil:1837  <ROUTINE SEE-INSIDE? (OBJ)>
@ZG.routine('SEE-INSIDE?')
def SEE_INSIDE_p(OBJ_l):
    return ((not FSET_p(OBJ_l, Flag('INVISIBLE'))) and (FSET_p(OBJ_l, Flag('TRANSBIT')) or FSET_p(OBJ_l, Flag('OPENBIT'))))

'Scoring'

# zil: gverbs.zil:1843  <GLOBAL MOVES>
# GLOBAL (state) MOVES = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1845  <GLOBAL SCORE>
# GLOBAL (state) SCORE = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1847  <GLOBAL BASE-SCORE>
# GLOBAL (state) BASE_SCORE = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1849  <GLOBAL WON-FLAG>
# GLOBAL (state) WON_FLAG = False  ->  ZilGlobal.py

# zil: gverbs.zil:1851  <ROUTINE SCORE-UPD (NUM)>
@ZG.routine('SCORE-UPD')
def SCORE_UPD(NUM_l):
    ZG.BASE_SCORE = (ZG.BASE_SCORE + NUM_l)
    ZG.SCORE = (ZG.SCORE + NUM_l)
    if ((ZG.SCORE == 350) and (not ZG.WON_FLAG)):
        ZG.WON_FLAG = True
        FCLEAR(ZG.MAP, Flag('INVISIBLE'))
        FCLEAR(ZG.WEST_OF_HOUSE, Flag('TOUCHBIT'))
        TELL('An almost inaudible voice whispers in your ear, "Look to your treasures\nfor the final secret."', CR)
    return True

# zil: gverbs.zil:1867  <ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)>
@ZG.routine('SCORE-OBJ')
def SCORE_OBJ(OBJ_l):
    TEMP = 0
    if ((TEMP := GETP(OBJ_l, 'VALUE')) > 0):
        ZG.SCORE_UPD(TEMP)
        return PUTP(OBJ_l, 'VALUE', 0)
    else:
        return False

# zil: gverbs.zil:1872  <ROUTINE YES? ()>
@ZG.routine('YES?')
def YES_p():
    PRINTI('>')
    READ(ZG.P_INBUF, ZG.P_LEXV)
    if (GET(ZG.P_LEXV, 1) in (WORD('yes'), WORD('y'))):
        return True
    else:
        return False

'Death'

# zil: gverbs.zil:1882  <GLOBAL DEAD>
# GLOBAL (state) DEAD = False  ->  ZilGlobal.py

# zil: gverbs.zil:1884  <GLOBAL DEATHS>
# GLOBAL (state) DEATHS = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1886  <GLOBAL LUCKY>
# GLOBAL (state) LUCKY = 1  ->  ZilGlobal.py

# ;"JIGS-UP is in ACTIONS.ZIL"

# ;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

# ;"KILL-INTERRUPTS is in ACTIONS.ZIL"

'Object Manipulation'

# zil: gverbs.zil:1896  <GLOBAL FUMBLE-NUMBER>
# GLOBAL (state) FUMBLE_NUMBER = 7  ->  ZilGlobal.py

# zil: gverbs.zil:1898  <GLOBAL FUMBLE-PROB>
# GLOBAL (state) FUMBLE_PROB = 8  ->  ZilGlobal.py

# zil: gverbs.zil:1900  <ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)>
@ZG.routine('ITAKE')
def ITAKE(VB=None):
    if VB is None:
        VB = True
    CNT = 0
    OBJ_l = 0
    if ZG.DEAD:
        if VB:
            TELL('Your hand passes through its object.', CR)
        return False
    elif (not FSET_p(ZG.PRSO, Flag('TAKEBIT'))):
        if VB:
            TELL(ZG.PICK_ONE(ZG.YUKS), CR)
        return False
    elif ZG.NULL_F():
        return False
    elif (FSET_p(LOC(ZG.PRSO), Flag('CONTBIT')) and (not FSET_p(LOC(ZG.PRSO), Flag('OPENBIT')))):
        return False
    elif ((not IN_p(LOC(ZG.PRSO), ZG.WINNER)) and ((ZG.WEIGHT(ZG.PRSO) + ZG.WEIGHT(ZG.WINNER)) > ZG.LOAD_ALLOWED)):
        if VB:
            TELL('Your load is too heavy')
            if (ZG.LOAD_ALLOWED < ZG.LOAD_MAX):
                TELL(', especially in light of your condition.')
            else:
                TELL('.')
            CRLF()
        return 2
    elif (VERB_p('TAKE') and ((CNT := ZG.CCOUNT(ZG.WINNER)) > ZG.FUMBLE_NUMBER) and ZG.PROB_1((CNT * ZG.FUMBLE_PROB))):
        TELL("You're holding too many things already!", CR)
        return False
    else:
        MOVE(ZG.PRSO, ZG.WINNER)
        FCLEAR(ZG.PRSO, Flag('NDESCBIT'))
        FSET(ZG.PRSO, Flag('TOUCHBIT'))
        ZG.NULL_F()
        ZG.SCORE_OBJ(ZG.PRSO)
        return True

# zil: gverbs.zil:1966  <ROUTINE IDROP ()>
@ZG.routine('IDROP')
def IDROP():
    if ((not IN_p(ZG.PRSO, ZG.WINNER)) and (not IN_p(LOC(ZG.PRSO), ZG.WINNER))):
        TELL("You're not carrying the ", D, ZG.PRSO, '.', CR)
        return False
    elif ((not IN_p(ZG.PRSO, ZG.WINNER)) and (not FSET_p(LOC(ZG.PRSO), Flag('OPENBIT')))):
        TELL('The ', D, ZG.PRSO, ' is closed.', CR)
        return False
    else:
        MOVE(ZG.PRSO, LOC(ZG.WINNER))
        return True

# zil: gverbs.zil:1979  <ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)>
@ZG.routine('CCOUNT')
def CCOUNT(OBJ_l):
    CNT = 0
    X = 0
    if (X := FIRST_p(OBJ_l)):
        while True:
            if (not FSET_p(X, Flag('WEARBIT'))):
                CNT = (CNT + 1)
            if (not (X := NEXT_p(X))):
                break
    return CNT

# zil: gverbs.zil:1988  <ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))>
@ZG.routine('WEIGHT')
def WEIGHT(OBJ_l):
    CONT = 0
    WT = 0
    if (CONT := FIRST_p(OBJ_l)):
        while True:
            if ((OBJ_l == ZG.PLAYER) and FSET_p(CONT, Flag('WEARBIT'))):
                WT = (WT + 1)
            else:
                WT = (WT + ZG.WEIGHT(CONT))
            if (not (CONT := NEXT_p(CONT))):
                break
    return (WT + GETP(OBJ_l, 'SIZE'))

'Miscellaneous'

# zil: gverbs.zil:2001  <CONSTANT REXIT>
# CONSTANT (const) REXIT = 0  ->  ZilGlobal.py

# zil: gverbs.zil:2002  <CONSTANT UEXIT>
# CONSTANT (const) UEXIT = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2003  <CONSTANT NEXIT>
# CONSTANT (const) NEXIT = 2  ->  ZilGlobal.py

# zil: gverbs.zil:2004  <CONSTANT FEXIT>
# CONSTANT (const) FEXIT = 3  ->  ZilGlobal.py

# zil: gverbs.zil:2005  <CONSTANT CEXIT>
# CONSTANT (const) CEXIT = 4  ->  ZilGlobal.py

# zil: gverbs.zil:2006  <CONSTANT DEXIT>
# CONSTANT (const) DEXIT = 5  ->  ZilGlobal.py

# zil: gverbs.zil:2008  <CONSTANT NEXITSTR>
# CONSTANT (const) NEXITSTR = 0  ->  ZilGlobal.py

# zil: gverbs.zil:2009  <CONSTANT FEXITFCN>
# CONSTANT (const) FEXITFCN = 0  ->  ZilGlobal.py

# zil: gverbs.zil:2010  <CONSTANT CEXITFLAG>
# CONSTANT (const) CEXITFLAG = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2011  <CONSTANT CEXITSTR>
# CONSTANT (const) CEXITSTR = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2012  <CONSTANT DEXITOBJ>
# CONSTANT (const) DEXITOBJ = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2013  <CONSTANT DEXITSTR>
# CONSTANT (const) DEXITSTR = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2015  <GLOBAL INDENTS>
# GLOBAL (state) INDENTS = TABLE(('PURE',), '', '  ', '    ', '      ', '        ', '          ')  ->  ZilGlobal.py

# zil: gverbs.zil:2024  <ROUTINE HACK-HACK (STR)>
@ZG.routine('HACK-HACK')
def HACK_HACK(STR):
    if (IN_p(ZG.PRSO, ZG.GLOBAL_OBJECTS) and VERB_p('WAVE', 'RAISE', 'LOWER')):
        return TELL('The ', D, ZG.PRSO, " isn't here!", CR)
    else:
        return TELL(STR, D, ZG.PRSO, ZG.PICK_ONE(ZG.HO_HUM), CR)

# zil: gverbs.zil:2031  <GLOBAL HO-HUM>
# GLOBAL (state) HO_HUM = LTABLE(0, " doesn't seem to work.", " isn't notably helpful.", ' has no effect.')  ->  ZilGlobal.py

# zil: gverbs.zil:2038  <ROUTINE NO-GO-TELL (AV WLOC)>
@ZG.routine('NO-GO-TELL')
def NO_GO_TELL(AV, WLOC):
    if AV:
        TELL("You can't go there in a ", D, WLOC, '.')
    else:
        TELL("You can't go there without a vehicle.")
    return CRLF()

# zil: gverbs.zil:2045  <ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <L...
@ZG.routine('GOTO')
def GOTO(RM, V_p=None):
    if V_p is None:
        V_p = True
    LB = FSET_p(RM, Flag('RLANDBIT'))
    WLOC = LOC(ZG.WINNER)
    AV = False
    OLIT = 0
    OHERE = 0
    OLIT = ZG.LIT
    OHERE = ZG.HERE
    if FSET_p(WLOC, Flag('VEHBIT')):
        AV = GETP(WLOC, 'VTYPE')
    if ((not LB) and (not AV)):
        ZG.NO_GO_TELL(AV, WLOC)
        return False
    elif ((not LB) and (not FSET_p(RM, AV))):
        ZG.NO_GO_TELL(AV, WLOC)
        return False
    elif (FSET_p(ZG.HERE, Flag('RLANDBIT')) and LB and AV and (not (AV == Flag('RLANDBIT'))) and (not FSET_p(RM, AV))):
        ZG.NO_GO_TELL(AV, WLOC)
        return False
    elif FSET_p(RM, Flag('RMUNGBIT')):
        TELL(GETP(RM, 'LDESC'), CR)
        return False
    else:
        if (LB and (not FSET_p(ZG.HERE, Flag('RLANDBIT'))) and (not ZG.DEAD) and FSET_p(WLOC, Flag('VEHBIT'))):
            TELL('The ', D, WLOC, ' comes to a rest on the shore.', CR, CR)
        if AV:
            MOVE(WLOC, RM)
        else:
            MOVE(ZG.WINNER, RM)
        ZG.HERE = RM
        ZG.LIT = ZG.LIT_p(ZG.HERE)
        if ((not OLIT) and (not ZG.LIT) and ZG.PROB_1(80)):
            if ZG.SPRAYED_p:
                TELL('There are sinister gurgling noises in the darkness all around you!', CR)
            elif ZG.NULL_F():
                return False
            else:
                TELL('Oh, no! A lurking grue slithered into the ')
                if FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
                    TELL(D, LOC(ZG.WINNER))
                else:
                    TELL('room')
                ZG.JIGS_UP(' and devoured you!')
                return True
        if ((not ZG.LIT) and (ZG.WINNER == ZG.ADVENTURER)):
            TELL('You have moved into a dark place.', CR)
            ZG.P_CONT = False
        APPLY(GETP(ZG.HERE, 'ACTION'), ZG.M_ENTER)
        ZG.SCORE_OBJ(RM)
        if (not (ZG.HERE == RM)):
            return True
        elif ((not (ZG.ADVENTURER == ZG.WINNER)) and IN_p(ZG.ADVENTURER, OHERE)):
            TELL('The ', D, ZG.WINNER, ' leaves the room.', CR)
        elif ((ZG.HERE == OHERE) and (ZG.HERE == ZG.ENTRANCE_TO_HADES)):
            return True
        elif (V_p and (ZG.WINNER == ZG.ADVENTURER)):
            ZG.V_FIRST_LOOK()
        return True

# zil: gverbs.zil:2139  <ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))>
@ZG.routine('LKP')
def LKP(ITM, TBL):
    CNT = 0
    LEN = GET(TBL, 0)
    while True:
        if ((CNT := (CNT + 1)) > LEN):
            return False
        elif (GET(TBL, CNT) == ITM):
            if (CNT == LEN):
                return False
            else:
                return GET(TBL, (CNT + 1))

# zil: gverbs.zil:2148  <ROUTINE DO-WALK (DIR)>
@ZG.routine('DO-WALK')
def DO_WALK(DIR):
    ZG.P_WALK_DIR = DIR
    return ZG.PERFORM(SYMBOL('V?WALK'), DIR)

# zil: gverbs.zil:2152  <ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)>
@ZG.routine('GLOBAL-IN?')
def GLOBAL_IN_p(OBJ1, OBJ2):
    TX = 0
    if (TX := GETPT(OBJ2, 'GLOBAL')):
        return ZG.ZMEMQB(OBJ1, TX, (PTSIZE(TX) - 1))
    else:
        return False

# zil: gverbs.zil:2156  <ROUTINE FIND-IN (WHERE WHAT "AUX" W)>
@ZG.routine('FIND-IN')
def FIND_IN(WHERE, WHAT):
    W = 0
    W = FIRST_p(WHERE)
    if (not W):
        return False
    while True:
        if (FSET_p(W, WHAT) and (not (W == ZG.ADVENTURER))):
            return W
        elif (not (W := NEXT_p(W))):
            return False

# zil: gverbs.zil:2167  <ROUTINE HELD? (CAN)>
@ZG.routine('HELD?')
def HELD_p(CAN):
    while True:
        CAN = LOC(CAN)
        if (not CAN):
            return False
        elif (CAN == ZG.WINNER):
            return True

# zil: gverbs.zil:2173  <ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX)>
@ZG.routine('OTHER-SIDE')
def OTHER_SIDE(DOBJ):
    P = 0
    TX = 0
    # ;"finds room beyond given door"
    while True:
        if ((P := NEXTP(ZG.HERE, P)) < LOW_DIRECTION):
            return False
        else:
            TX = GETPT(ZG.HERE, P)
            if ((PTSIZE(TX) == ZG.DEXIT) and (GETB(TX, ZG.DEXITOBJ) == DOBJ)):
                return P

# zil: gverbs.zil:2183  <ROUTINE MUNG-ROOM (RM STR)>
@ZG.routine('MUNG-ROOM')
def MUNG_ROOM(RM, STR):
    FSET(RM, Flag('RMUNGBIT'))
    return PUTP(RM, 'LDESC', STR)

# zil: gverbs.zil:2191  <ROUTINE THIS-IS-IT (OBJ)>
@ZG.routine('THIS-IS-IT')
def THIS_IS_IT(OBJ_l):
    ZG.P_IT_OBJECT = OBJ_l
    return ZG.P_IT_OBJECT

# zil: gverbs.zil:2195  <GLOBAL SWIMYUKS>
# GLOBAL (state) SWIMYUKS = LTABLE(0, "You can't swim in the dungeon.")  ->  ZilGlobal.py

# zil: gverbs.zil:2198  <GLOBAL HELLOS>
# GLOBAL (state) HELLOS = LTABLE(0, 'Hello.', 'Good day.', "Nice weather we've been having lately.", 'Goodbye.')  ->  ZilGlobal.py

# zil: gverbs.zil:2204  <GLOBAL YUKS>
# GLOBAL (state) YUKS = LTABLE(0, 'A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!')  ->  ZilGlobal.py

# zil: gverbs.zil:2213  <GLOBAL DUMMY>
# GLOBAL (state) DUMMY = LTABLE(0, 'Look around.', 'Too late for that.', 'Have your eyes checked.')  ->  ZilGlobal.py
