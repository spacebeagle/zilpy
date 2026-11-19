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
    TELL('ZORK II: The Wizard of Frobozz\nInfocom interactive fiction - a fantasy story\nCopyright (c) 1981, 1982, 1983, 1986')
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

# ;<ROUTINE V-AGAIN ("AUX" (OBJ <>))
# 	 <COND (<EQUAL? ,L-PRSA ,V?WALK>
# 		<DO-WALK ,L-PRSO>)
# 	       (T
# 		<COND (,L-PRSO
# 		       <COND (<OR <NOT <LOC ,L-PRSO>>
# 				  <FSET? ,L-PRSO ,INVISIBLE>>
# 			      <SET OBJ ,L-PRSO>)>)>
# 		<COND (,L-PRSI
# 		       <COND (<OR <NOT <LOC ,L-PRSI>>
# 				  <FSET? ,L-PRSI ,INVISIBLE>>
# 			      <SET OBJ ,L-PRSI>)>)>
# 		<COND (<AND .OBJ
# 			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
# 		       <TELL "You can't see the " D .OBJ " anymore." CR>
# 		       <RFATAL>)
# 		      (T
# 		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

# zil: gverbs.zil:175  <ROUTINE V-ALARM ()>
@ZG.routine('V-ALARM')
def V_ALARM():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        if ZG.NULL_F():
            return True
        else:
            return TELL("He's wide awake, or haven't you noticed...", CR)
    else:
        return TELL('The ', D, ZG.PRSO, " isn't sleeping.", CR)

# zil: gverbs.zil:189  <ROUTINE V-ANSWER ()>
@ZG.routine('V-ANSWER')
def V_ANSWER():
    TELL('Nobody seems to be awaiting your answer.', CR)
    ZG.P_CONT = False
    ZG.QUOTE_FLAG = False
    return True

# zil: gverbs.zil:195  <ROUTINE V-ATTACK ()>
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
        return TELL("You can't.", CR)

# zil: gverbs.zil:214  <ROUTINE V-BACK ()>
@ZG.routine('V-BACK')
def V_BACK():
    return TELL('Sorry, my memory is poor. Please give a direction.', CR)

# zil: gverbs.zil:217  <ROUTINE V-BLAST ()>
@ZG.routine('V-BLAST')
def V_BLAST():
    return TELL("You can't blast anything by using words.", CR)

# zil: gverbs.zil:220  <ROUTINE PRE-BOARD ("AUX" AV)>
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

# zil: gverbs.zil:243  <ROUTINE V-BOARD ("AUX" AV)>
@ZG.routine('V-BOARD')
def V_BOARD():
    AV = 0
    TELL('You are now in the ', D, ZG.PRSO, '.', CR)
    MOVE(ZG.WINNER, ZG.PRSO)
    APPLY(GETP(ZG.PRSO, 'ACTION'), ZG.M_ENTER)
    return True

# zil: gverbs.zil:249  <ROUTINE V-BREATHE ()>
@ZG.routine('V-BREATHE')
def V_BREATHE():
    return ZG.PERFORM(SYMBOL('V?INFLATE'), ZG.PRSO, ZG.LUNGS)

# zil: gverbs.zil:252  <ROUTINE V-BRUSH ()>
@ZG.routine('V-BRUSH')
def V_BRUSH():
    return TELL('If you wish, but heaven only knows why.', CR)

# zil: gverbs.zil:255  <ROUTINE V-BUG ()>
@ZG.routine('V-BUG')
def V_BUG():
    return TELL('Bug? Not in a flawless program like this! (Cough, cough).', CR)

# zil: gverbs.zil:259  <ROUTINE TELL-NO-PRSI ()>
@ZG.routine('TELL-NO-PRSI')
def TELL_NO_PRSI():
    return TELL("You didn't say with what!", CR)

# zil: gverbs.zil:262  <ROUTINE PRE-BURN ()>
@ZG.routine('PRE-BURN')
def PRE_BURN():
    if (not ZG.PRSI):
        return ZG.TELL_NO_PRSI()
    elif FLAMING_p(ZG.PRSI):
        return False
    else:
        return TELL('With a ', D, ZG.PRSI, '??!?', CR)

# zil: gverbs.zil:270  <ROUTINE V-BURN ()>
@ZG.routine('V-BURN')
def V_BURN():
    if (LOC(ZG.PRSO) == ZG.RECEPTACLE):
        ZG.BALLOON_BURN()
        return True
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

# zil: gverbs.zil:295  <ROUTINE V-CHOMP ()>
@ZG.routine('V-CHOMP')
def V_CHOMP():
    return TELL('Preposterous!', CR)

# zil: gverbs.zil:298  <ROUTINE V-CLIMB-DOWN ()>
@ZG.routine('V-CLIMB-DOWN')
def V_CLIMB_DOWN():
    return ZG.V_CLIMB_UP('DOWN', ZG.PRSO)

# zil: gverbs.zil:300  <ROUTINE V-CLIMB-FOO ()>
@ZG.routine('V-CLIMB-FOO')
def V_CLIMB_FOO():
    return ZG.V_CLIMB_UP('UP', ZG.PRSO)

# zil: gverbs.zil:309  <ROUTINE V-CLIMB-ON ()>
@ZG.routine('V-CLIMB-ON')
def V_CLIMB_ON():
    if FSET_p(ZG.PRSO, Flag('VEHBIT')):
        ZG.PERFORM(SYMBOL('V?BOARD'), ZG.PRSO)
        return True
    else:
        return TELL("You can't climb onto the ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:319  <ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)>
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
    elif ZG.NULL_F():
        TELL('There are no climbable trees here.', CR)
        return True
    elif (OBJ_l in (False, ZG.ROOMS)):
        return TELL("You can't go that way.", CR)
    else:
        return TELL("You can't do that!", CR)

# zil: gverbs.zil:355  <ROUTINE V-CLOSE ()>
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

# zil: gverbs.zil:378  <ROUTINE V-COMMAND ()>
@ZG.routine('V-COMMAND')
def V_COMMAND():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL('The ', D, ZG.PRSO, ' pays no attention.', CR)
    else:
        return TELL('You cannot talk to that!', CR)

# zil: gverbs.zil:384  <ROUTINE V-COUNT ()>
@ZG.routine('V-COUNT')
def V_COUNT():
    if (ZG.PRSO == ZG.BLESSINGS):
        return TELL('Well, for one, you are playing Zork...', CR)
    else:
        return TELL('You have lost your mind.', CR)

# zil: gverbs.zil:390  <ROUTINE V-CROSS ()>
@ZG.routine('V-CROSS')
def V_CROSS():
    return TELL("You can't cross that!", CR)

# zil: gverbs.zil:393  <ROUTINE V-CURSES ()>
@ZG.routine('V-CURSES')
def V_CURSES():
    if ZG.PRSO:
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            return TELL("Insults of this nature won't help you.", CR)
        else:
            return TELL('What a loony!', CR)
    else:
        return TELL('Such language in a high-class establishment like this!', CR)

# zil: gverbs.zil:403  <ROUTINE V-CUT ()>
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

# zil: gverbs.zil:421  <ROUTINE V-DEFLATE ()>
@ZG.routine('V-DEFLATE')
def V_DEFLATE():
    return TELL('Come on, now!', CR)

# zil: gverbs.zil:424  <ROUTINE V-DIG ()>
@ZG.routine('V-DIG')
def V_DIG():
    if (not ZG.PRSI):
        ZG.PRSI = ZG.HANDS
    if FSET_p(ZG.PRSI, Flag('TOOLBIT')):
        return TELL('Digging with the ', D, ZG.PRSI, ' is slow and tedious.', CR)
    else:
        return TELL('Digging with a ', D, ZG.PRSI, ' is silly.', CR)

# zil: gverbs.zil:437  <ROUTINE V-DISEMBARK ()>
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

# zil: gverbs.zil:453  <ROUTINE V-DISENCHANT ()>
@ZG.routine('V-DISENCHANT')
def V_DISENCHANT():
    if (not IN_p(ZG.PRSO, ZG.HERE)):
        return True
    elif ((ZG.SPELL_USED in (WORD('feeble'), WORD('fumble'), WORD('fear'))) or (ZG.SPELL_USED in (WORD('freeze'), WORD('fall'), WORD('ferment'))) or (ZG.SPELL_USED in (WORD('fierce'), WORD('fence'), WORD('fantasize')))):
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            if (ZG.SPELL_USED == WORD('feeble')):
                return TELL('The ', D, ZG.PRSO, ' seems stronger now.', CR)
            elif (ZG.SPELL_USED == WORD('fumble')):
                return TELL('The ', D, ZG.PRSO, ' no longer appears clumsy.', CR)
            elif (ZG.SPELL_USED == WORD('fear')):
                return TELL('The ', D, ZG.PRSO, ' no longer appears afraid.', CR)
            elif (ZG.SPELL_USED == WORD('freeze')):
                return TELL('The ', D, ZG.PRSO, ' moves again.', CR)
            elif (ZG.SPELL_USED == WORD('ferment')):
                return TELL('The ', D, ZG.PRSO, ' stops swaying.', CR)
            elif (ZG.SPELL_USED == WORD('fierce')):
                return TELL('The ', D, ZG.PRSO, ' appears more peaceful.', CR)
            else:
                return False
        else:
            return False
    elif (ZG.SPELL_USED == WORD('float')):
        return TELL('The ', D, ZG.PRSO, ' sinks to the ground.', CR)
    elif (ZG.SPELL_USED == WORD('fudge')):
        return TELL('The sweet smell has dispersed.', CR)
    else:
        return False

# zil: gverbs.zil:487  <ROUTINE V-DRINK ()>
@ZG.routine('V-DRINK')
def V_DRINK():
    return ZG.V_EAT()

# zil: gverbs.zil:490  <ROUTINE V-DRINK-FROM ()>
@ZG.routine('V-DRINK-FROM')
def V_DRINK_FROM():
    return TELL('How peculiar!', CR)

# zil: gverbs.zil:493  <ROUTINE PRE-DROP ()>
@ZG.routine('PRE-DROP')
def PRE_DROP():
    if (ZG.PRSO == LOC(ZG.WINNER)):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), ZG.PRSO)
        return True
    else:
        return False

# zil: gverbs.zil:498  <ROUTINE V-DROP ()>
@ZG.routine('V-DROP')
def V_DROP():
    if ZG.IDROP():
        return TELL('Dropped.', CR)
    else:
        return False

# zil: gverbs.zil:502  <ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))>
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

# zil: gverbs.zil:537  <ROUTINE HIT-SPOT ()>
@ZG.routine('HIT-SPOT')
def HIT_SPOT():
    if ((ZG.PRSO == ZG.WATER) and (not ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE))):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
    return TELL('Thank you very much. I was rather thirsty (from all this talking,\nprobably).', CR)

# zil: gverbs.zil:545  <ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT)>
@ZG.routine('V-ECHO')
def V_ECHO():
    LST = 0
    MAX = 0
    ECH = 0
    CNT = 0
    return TELL('echo echo ...', CR)

# zil: gverbs.zil:569  <ROUTINE V-ENCHANT ()>
@ZG.routine('V-ENCHANT')
def V_ENCHANT():
    if ZG.WAND_ON:
        ZG.SPELL_VICTIM = ZG.WAND_ON
    if ZG.SPELL_VICTIM:
        if (not ZG.SPELL_USED):
            TELL('You must be more specific.', CR)
            return True
        if ((ZG.SPELL_USED in (WORD('feeble'), WORD('fumble'), WORD('fear'))) or (ZG.SPELL_USED in (WORD('freeze'), WORD('fall'), WORD('ferment'))) or (ZG.SPELL_USED in (WORD('fierce'), WORD('fence'), WORD('fantasize')))):
            if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
                return TELL('The wand stops glowing, but there is no other obvious effect.', CR)
            else:
                return TELL("That might have done something, but it's hard to tell with a ", D, ZG.PRSO, '.', CR)
        elif (ZG.SPELL_USED == WORD('fudge')):
            return TELL('A strong odor of chocolate permeates the room.', CR)
        elif (ZG.SPELL_USED == WORD('fluoresce')):
            FSET(ZG.PRSO, Flag('LIGHTBIT'))
            FSET(ZG.PRSO, Flag('ONBIT'))
            ZG.LIT = True
            return TELL('The ', D, ZG.PRSO, ' begins to glow.', CR)
        elif (ZG.SPELL_USED == WORD('filch')):
            ZG.SPELL_HANDLED_p = True
            if FSET_p(ZG.PRSO, Flag('TAKEBIT')):
                MOVE(ZG.PRSO, ZG.WINNER)
                ZG.SCORE_OBJ(ZG.PRSO)
                return TELL('Filched!', CR)
            else:
                return TELL("You can't filch the ", D, ZG.PRSO, '!', CR)
        elif ((ZG.SPELL_USED == WORD('float')) and FSET_p(ZG.PRSO, Flag('TAKEBIT'))):
            if ((ZG.SPELL_VICTIM == ZG.COLLAR) and IN_p(ZG.COLLAR, ZG.CERBERUS)):
                ZG.SPELL_VICTIM = ZG.CERBERUS
            return TELL('The ', D, ZG.PRSO, ' floats serenely in midair.', CR)
        elif ((ZG.SPELL_USED == WORD('fry')) and FSET_p(ZG.PRSO, Flag('TAKEBIT'))):
            ZG.SPELL_HANDLED_p = True
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            return TELL('The ', D, ZG.PRSO, ' goes up in a puff of smoke.', CR)
        else:
            ZG.SPELL_VICTIM = False
            return TELL('The wand stops glowing, but there is no other apparent effect.', CR)
    else:
        ZG.SPELL_VICTIM = False
        return TELL('Nothing happens.', CR)

# zil: gverbs.zil:629  <ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)>
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

# zil: gverbs.zil:639  <ROUTINE V-ENTER ()>
@ZG.routine('V-ENTER')
def V_ENTER():
    return ZG.DO_WALK('IN')

# zil: gverbs.zil:642  <ROUTINE V-EXAMINE ()>
@ZG.routine('V-EXAMINE')
def V_EXAMINE():
    if GETP(ZG.PRSO, 'TEXT'):
        return TELL(GETP(ZG.PRSO, 'TEXT'), CR)
    elif (FSET_p(ZG.PRSO, Flag('CONTBIT')) or FSET_p(ZG.PRSO, Flag('DOORBIT'))):
        return ZG.V_LOOK_INSIDE()
    else:
        return TELL("There's nothing special about the ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:651  <ROUTINE V-EXIT ()>
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

# zil: gverbs.zil:662  <ROUTINE V-EXORCISE ()>
@ZG.routine('V-EXORCISE')
def V_EXORCISE():
    return TELL('What a bizarre concept!', CR)

# zil: gverbs.zil:665  <ROUTINE PRE-FILL ("AUX" TX)>
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

# ;"OLD ZORK1 PRE-FILL"

# ;<ROUTINE PRE-FILL ("AUX" TX)
# 	 <COND (<NOT ,PRSI>
# 		<COND (<AND <SET TX <GETPT ,HERE ,P?GLOBAL>>
# 			    <ZMEMQB ,GLOBAL-WATER .TX <- <PTSIZE .TX> 1>>>
# 		       <SETG PRSI ,GLOBAL-WATER>
# 		       <RFALSE>)
# 		      (T
# 		       <TELL "There is nothing to fill it with." CR>
# 		       <RTRUE>)>)
# 	       (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
# 		<PERFORM ,V?PUT ,PRSI ,PRSO>
# 		<RTRUE>)>>

# zil: gverbs.zil:697  <ROUTINE V-FILL ()>
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

# zil: gverbs.zil:710  <ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))>
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

# zil: gverbs.zil:734  <ROUTINE V-FOLLOW ()>
@ZG.routine('V-FOLLOW')
def V_FOLLOW():
    return TELL("You're nuts!", CR)

# zil: gverbs.zil:737  <ROUTINE V-FROBOZZ ()>
@ZG.routine('V-FROBOZZ')
def V_FROBOZZ():
    return TELL('The FROBOZZ Corporation created, owns, and operates this dungeon.', CR)

# zil: gverbs.zil:741  <ROUTINE PRE-GIVE ()>
@ZG.routine('PRE-GIVE')
def PRE_GIVE():
    if (not ZG.HELD_p(ZG.PRSO)):
        return TELL("That's easy for you to say since you don't even have the ", D, ZG.PRSO, '.', CR)
    else:
        return False

# zil: gverbs.zil:746  <ROUTINE V-GIVE ()>
@ZG.routine('V-GIVE')
def V_GIVE():
    if (not FSET_p(ZG.PRSI, Flag('ACTORBIT'))):
        return TELL("You can't give a ", D, ZG.PRSO, ' to a ', D, ZG.PRSI, '!', CR)
    else:
        return TELL('The ', D, ZG.PRSI, ' refuses it politely.', CR)

# zil: gverbs.zil:752  <ROUTINE V-HATCH ()>
@ZG.routine('V-HATCH')
def V_HATCH():
    return TELL('Bizarre!', CR)

# zil: gverbs.zil:755  <GLOBAL HS>
# GLOBAL (state) HS = 0  ->  ZilGlobal.py

# ;"counts occurences of HELLO, SAILOR"

# zil: gverbs.zil:757  <ROUTINE V-HELLO ()>
@ZG.routine('V-HELLO')
def V_HELLO():
    if ZG.PRSO:
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            return TELL('The ', D, ZG.PRSO, ' bows his head to you in greeting.', CR)
        else:
            return TELL('It\'s a well known fact that only schizophrenics say "Hello" to a ', D, ZG.PRSO, '.', CR)
    else:
        return TELL(ZG.PICK_ONE(ZG.HELLOS), CR)

# zil: gverbs.zil:769  <ROUTINE V-INCANT ()>
@ZG.routine('V-INCANT')
def V_INCANT():
    if ZG.SPELL_USED:
        TELL('Nothing happens.', CR)
    elif ZG.WAND_ON:
        ZG.SPELL_VICTIM = ZG.WAND_ON
        ZG.SPELL_USED = GET(ZG.P_LEXV, ZG.P_CONT)
        TELL('The wand glows very brightly for a moment.', CR)
        ENABLE(ZG.QUEUE(ZG.I_SPELL, (10 + RANDOM(10))))
        ZG.WAND_ON = False
        ZG.PERFORM(SYMBOL('V?ENCHANT'), ZG.SPELL_VICTIM)
    else:
        TELL('The incantation echoes back faintly, but nothing else happens.', CR)
    ZG.QUOTE_FLAG = False
    ZG.P_CONT = False
    return True

# zil: gverbs.zil:790  <ROUTINE V-INFLATE ()>
@ZG.routine('V-INFLATE')
def V_INFLATE():
    return TELL('How can you inflate that?', CR)

# ;<ROUTINE V-IS-IN ()
# 	 <COND (<IN? ,PRSO ,PRSI>
# 		<TELL "Yes, it is ">
# 		<COND (<FSET? ,PRSI ,SURFACEBIT>
# 		       <TELL "on">)
# 		      (T
# 		       <TELL "in">)>
# 		<TELL " the " D ,PRSI "." CR>)
# 	       (T
# 		<TELL "No, it isn't." CR>)>>

# zil: gverbs.zil:804  <ROUTINE V-KICK ()>
@ZG.routine('V-KICK')
def V_KICK():
    return ZG.HACK_HACK('Kicking the ')

# zil: gverbs.zil:806  <ROUTINE V-KISS ()>
@ZG.routine('V-KISS')
def V_KISS():
    return TELL("I'd sooner kiss a pig.", CR)

# zil: gverbs.zil:809  <ROUTINE V-KNOCK ()>
@ZG.routine('V-KNOCK')
def V_KNOCK():
    if FSET_p(ZG.PRSO, Flag('DOORBIT')):
        return TELL("Nobody's home.", CR)
    else:
        return TELL('Why knock on a ', D, ZG.PRSO, '?', CR)

# zil: gverbs.zil:815  <ROUTINE V-LAMP-OFF ()>
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

# zil: gverbs.zil:830  <ROUTINE V-LAMP-ON ()>
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

# zil: gverbs.zil:848  <ROUTINE V-LAUNCH ()>
@ZG.routine('V-LAUNCH')
def V_LAUNCH():
    if FSET_p(ZG.PRSO, Flag('VEHBIT')):
        return TELL('You can\'t launch that by saying "launch"!', CR)
    else:
        return TELL("That's pretty weird.", CR)

# zil: gverbs.zil:854  <ROUTINE V-LEAN-ON ()>
@ZG.routine('V-LEAN-ON')
def V_LEAN_ON():
    return TELL('Getting tired?', CR)

# zil: gverbs.zil:857  <ROUTINE V-LEAP ("AUX" TX S)>
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
        elif ZG.NULL_F():
            return True
        else:
            return ZG.V_SKIP()
    else:
        return ZG.V_SKIP()

# zil: gverbs.zil:888  <GLOBAL JUMPLOSS>
# GLOBAL (state) JUMPLOSS = LTABLE(0, 'You should have looked before you leaped.', 'In the movies, your life would be passing before your eyes.', 'Geronimo...')  ->  ZilGlobal.py

# zil: gverbs.zil:894  <ROUTINE V-LEAVE ()>
@ZG.routine('V-LEAVE')
def V_LEAVE():
    return ZG.DO_WALK('OUT')

# zil: gverbs.zil:896  <ROUTINE V-LISTEN ()>
@ZG.routine('V-LISTEN')
def V_LISTEN():
    return TELL('The ', D, ZG.PRSO, ' makes no sound.', CR)

# zil: gverbs.zil:899  <ROUTINE V-LOCK ()>
@ZG.routine('V-LOCK')
def V_LOCK():
    return TELL("It doesn't seem to work.", CR)

# zil: gverbs.zil:902  <ROUTINE V-LOOK ()>
@ZG.routine('V-LOOK')
def V_LOOK():
    if ZG.DESCRIBE_ROOM(True):
        return ZG.DESCRIBE_OBJECTS(True)
    else:
        return False

# zil: gverbs.zil:906  <ROUTINE V-LOOK-BEHIND ()>
@ZG.routine('V-LOOK-BEHIND')
def V_LOOK_BEHIND():
    return TELL('There is nothing behind the ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:909  <ROUTINE V-LOOK-INSIDE ()>
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

# zil: gverbs.zil:936  <ROUTINE V-LOOK-ON ()>
@ZG.routine('V-LOOK-ON')
def V_LOOK_ON():
    if FSET_p(ZG.PRSO, Flag('SURFACEBIT')):
        ZG.PERFORM(SYMBOL('V?LOOK-INSIDE'), ZG.PRSO)
        return True
    else:
        return TELL('Look on a ', D, ZG.PRSO, '???', CR)

# zil: gverbs.zil:943  <ROUTINE V-LOOK-UNDER ()>
@ZG.routine('V-LOOK-UNDER')
def V_LOOK_UNDER():
    return TELL('There is nothing but dust there.', CR)

# zil: gverbs.zil:946  <ROUTINE V-LOWER ()>
@ZG.routine('V-LOWER')
def V_LOWER():
    return ZG.HACK_HACK('Playing in this way with the ')

# zil: gverbs.zil:948  <ROUTINE V-MAKE ()>
@ZG.routine('V-MAKE')
def V_MAKE():
    return TELL("You can't do that.", CR)

# zil: gverbs.zil:951  <ROUTINE V-MELT ()>
@ZG.routine('V-MELT')
def V_MELT():
    return TELL("It's not clear that a ", D, ZG.PRSO, ' can be melted.', CR)

# zil: gverbs.zil:954  <ROUTINE PRE-MOVE ()>
@ZG.routine('PRE-MOVE')
def PRE_MOVE():
    if ZG.HELD_p(ZG.PRSO):
        return TELL("You aren't an accomplished enough juggler.", CR)
    else:
        return False

# zil: gverbs.zil:958  <ROUTINE V-MOVE ()>
@ZG.routine('V-MOVE')
def V_MOVE():
    if FSET_p(ZG.PRSO, Flag('TAKEBIT')):
        return TELL('Moving the ', D, ZG.PRSO, ' reveals nothing.', CR)
    else:
        return TELL("You can't move the ", D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:964  <ROUTINE V-MUMBLE ()>
@ZG.routine('V-MUMBLE')
def V_MUMBLE():
    return TELL("You'll have to speak up if you expect me to hear you!", CR)

# zil: gverbs.zil:967  <ROUTINE PRE-MUNG ()>
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

# zil: gverbs.zil:982  <ROUTINE V-MUNG ()>
@ZG.routine('V-MUNG')
def V_MUNG():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSO)
        return True
    else:
        return TELL('Nice try.', CR)

# zil: gverbs.zil:989  <ROUTINE V-ODYSSEUS ()>
@ZG.routine('V-ODYSSEUS')
def V_ODYSSEUS():
    if ZG.NULL_F():
        return True
    else:
        return TELL("Wasn't he a sailor?", CR)

# zil: gverbs.zil:1007  <ROUTINE V-OIL ()>
@ZG.routine('V-OIL')
def V_OIL():
    return TELL('You probably put spinach in your gas tank, too.', CR)

# zil: gverbs.zil:1010  <ROUTINE V-OPEN ("AUX" F STR)>
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

# zil: gverbs.zil:1040  <ROUTINE V-OVERBOARD ("AUX" LOCN)>
@ZG.routine('V-OVERBOARD')
def V_OVERBOARD():
    LOCN = 0
    if ZG.NULL_F():
        return True
    elif FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
        ZG.PERFORM(SYMBOL('V?THROW'), ZG.PRSO)
        return True
    else:
        return TELL('Huh?', CR)

# zil: gverbs.zil:1055  <ROUTINE V-PICK ()>
@ZG.routine('V-PICK')
def V_PICK():
    return TELL("You can't pick that.", CR)

# zil: gverbs.zil:1057  <ROUTINE V-PLAY ()>
@ZG.routine('V-PLAY')
def V_PLAY():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        TELL('You become so engrossed in the role of the ', D, ZG.PRSO, ' that\nyou kill yourself, just as he might have done!', CR)
        return ZG.JIGS_UP('')
    else:
        return TELL("That's silly!", CR)

# zil: gverbs.zil:1065  <ROUTINE V-PLUG ()>
@ZG.routine('V-PLUG')
def V_PLUG():
    return TELL('This has no effect.', CR)

# zil: gverbs.zil:1068  <ROUTINE V-POUR-ON ()>
@ZG.routine('V-POUR-ON')
def V_POUR_ON():
    if (ZG.PRSO == ZG.WATER):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        if FLAMING_p(ZG.PRSI):
            TELL('The ', D, ZG.PRSI, ' is extinguished.', CR)
            if (ZG.PRSI == ZG.BINF_FLAG):
                ZG.BINF_FLAG = False
            FCLEAR(ZG.PRSI, Flag('ONBIT'))
            return FCLEAR(ZG.PRSI, Flag('FLAMEBIT'))
        else:
            return TELL('The water spills over the ', D, ZG.PRSI, ', to the floor, and evaporates.', CR)
    elif ZG.NULL_F():
        return True
    else:
        return TELL("You can't pour that.", CR)

# zil: gverbs.zil:1090  <ROUTINE V-PRAY ()>
@ZG.routine('V-PRAY')
def V_PRAY():
    if ZG.NULL_F():
        return True
    else:
        return TELL('If you pray enough, your prayers may be answered.', CR)

# zil: gverbs.zil:1100  <ROUTINE V-PUMP ()>
@ZG.routine('V-PUMP')
def V_PUMP():
    if ZG.NULL_F():
        return True
    elif ZG.NULL_F():
        return True
    else:
        return TELL("It's really not clear how.", CR)

# zil: gverbs.zil:1114  <ROUTINE V-PUSH ()>
@ZG.routine('V-PUSH')
def V_PUSH():
    return ZG.HACK_HACK('Pushing the ')

# zil: gverbs.zil:1116  <ROUTINE V-PUSH-TO ()>
@ZG.routine('V-PUSH-TO')
def V_PUSH_TO():
    return TELL("You can't push things to that.", CR)

# zil: gverbs.zil:1119  <ROUTINE PRE-PUT ()>
@ZG.routine('PRE-PUT')
def PRE_PUT():
    if ZG.NULL_F():
        return False
    else:
        return ZG.PRE_GIVE()

# ;"That's easy for you to say..."

# zil: gverbs.zil:1129  <ROUTINE V-PUT ()>
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

# zil: gverbs.zil:1160  <ROUTINE V-PUT-BEHIND ()>
@ZG.routine('V-PUT-BEHIND')
def V_PUT_BEHIND():
    return TELL('That hiding place is too obvious.', CR)

# zil: gverbs.zil:1163  <ROUTINE V-PUT-ON ()>
@ZG.routine('V-PUT-ON')
def V_PUT_ON():
    if (ZG.PRSI == ZG.GROUND):
        ZG.PERFORM(SYMBOL('V?DROP'), ZG.PRSO)
        return True
    elif FSET_p(ZG.PRSI, Flag('SURFACEBIT')):
        return ZG.V_PUT()
    else:
        return TELL("There's no good surface on the ", D, ZG.PRSI, '.', CR)

# zil: gverbs.zil:1172  <ROUTINE V-PUT-UNDER ()>
@ZG.routine('V-PUT-UNDER')
def V_PUT_UNDER():
    return TELL("You can't do that.", CR)

# zil: gverbs.zil:1175  <ROUTINE V-RAISE ()>
@ZG.routine('V-RAISE')
def V_RAISE():
    return ZG.V_LOWER()

# zil: gverbs.zil:1178  <ROUTINE V-RAPE ()>
@ZG.routine('V-RAPE')
def V_RAPE():
    return TELL('What a (ahem!) strange idea.', CR)

# zil: gverbs.zil:1181  <ROUTINE PRE-READ ()>
@ZG.routine('PRE-READ')
def PRE_READ():
    if (not ZG.LIT):
        return TELL('It is impossible to read in the dark.', CR)
    elif (ZG.PRSI and (not FSET_p(ZG.PRSI, Flag('TRANSBIT')))):
        return TELL('How does one look through a ', D, ZG.PRSI, '?', CR)
    else:
        return False

# zil: gverbs.zil:1187  <ROUTINE V-READ ()>
@ZG.routine('V-READ')
def V_READ():
    if (not FSET_p(ZG.PRSO, Flag('READBIT'))):
        return TELL('How does one read a ', D, ZG.PRSO, '?', CR)
    else:
        return TELL(GETP(ZG.PRSO, 'TEXT'), CR)

# zil: gverbs.zil:1193  <ROUTINE V-READ-PAGE ()>
@ZG.routine('V-READ-PAGE')
def V_READ_PAGE():
    ZG.PERFORM(SYMBOL('V?READ'), ZG.PRSO)
    return True

# zil: gverbs.zil:1197  <ROUTINE V-REPENT ()>
@ZG.routine('V-REPENT')
def V_REPENT():
    return TELL('It could very well be too late!', CR)

# zil: gverbs.zil:1200  <ROUTINE V-REPLY ()>
@ZG.routine('V-REPLY')
def V_REPLY():
    TELL('It is hardly likely that the ', D, ZG.PRSO, ' is interested.', CR)
    ZG.P_CONT = False
    ZG.QUOTE_FLAG = False
    return True

# zil: gverbs.zil:1206  <ROUTINE V-RING ()>
@ZG.routine('V-RING')
def V_RING():
    return TELL('How, exactly, can you ring that?', CR)

# zil: gverbs.zil:1209  <ROUTINE V-RUB ()>
@ZG.routine('V-RUB')
def V_RUB():
    return ZG.HACK_HACK('Fiddling with the ')

# zil: gverbs.zil:1211  <ROUTINE V-SAY ("AUX" V)>
@ZG.routine('V-SAY')
def V_SAY():
    V = 0
    if (ZG.SPELL_USED or ZG.WAND_ON):
        ZG.PERFORM(SYMBOL('V?INCANT'))
        return True
    ZG.QUOTE_FLAG = False
    if (V := ZG.FIND_IN(ZG.HERE, Flag('ACTORBIT'))):
        TELL('You must address the ', D, V, ' directly.', CR)
        ZG.P_CONT = False
    elif (not (GET(ZG.P_LEXV, ZG.P_CONT) == WORD('hello'))):
        ZG.P_CONT = False
        TELL('Talking to yourself is a sign of impending mental collapse.', CR)
    return True

# zil: gverbs.zil:1241  <ROUTINE V-SEARCH ()>
@ZG.routine('V-SEARCH')
def V_SEARCH():
    return TELL('You find nothing unusual.', CR)

# zil: gverbs.zil:1244  <ROUTINE V-SEND ()>
@ZG.routine('V-SEND')
def V_SEND():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL('Why would you send for the ', D, ZG.PRSO, '?', CR)
    else:
        return TELL("That doesn't make sends.", CR)

# zil: gverbs.zil:1250  <ROUTINE PRE-SGIVE ()>
@ZG.routine('PRE-SGIVE')
def PRE_SGIVE():
    ZG.PERFORM(SYMBOL('V?GIVE'), ZG.PRSI, ZG.PRSO)
    return True

# zil: gverbs.zil:1254  <ROUTINE V-SGIVE ()>
@ZG.routine('V-SGIVE')
def V_SGIVE():
    return TELL('Foo!', CR)

# zil: gverbs.zil:1257  <ROUTINE V-SHAKE ()>
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

# zil: gverbs.zil:1286  <ROUTINE SHAKE-LOOP ("AUX" X)>
@ZG.routine('SHAKE-LOOP')
def SHAKE_LOOP():
    X = 0
    while True:
        if (X := FIRST_p(ZG.PRSO)):
            FSET(X, Flag('TOUCHBIT'))
            if (X == ZG.WATER):
                _tmp1 = ZG.PSEUDO_OBJECT
            elif (not FSET_p(ZG.HERE, Flag('RLANDBIT'))):
                _tmp1 = ZG.PSEUDO_OBJECT
            else:
                _tmp1 = ZG.HERE
            if (X == ZG.WATER):
                _tmp2 = ZG.PSEUDO_OBJECT
            elif (not FSET_p(ZG.HERE, Flag('RLANDBIT'))):
                _tmp2 = ZG.PSEUDO_OBJECT
            else:
                _tmp2 = ZG.HERE
            MOVE(X, _tmp2)
        else:
            return True

# zil: gverbs.zil:1313  <ROUTINE V-SKIP ()>
@ZG.routine('V-SKIP')
def V_SKIP():
    return TELL(ZG.PICK_ONE(ZG.WHEEEEE), CR)

# zil: gverbs.zil:1316  <GLOBAL WHEEEEE>
# GLOBAL (state) WHEEEEE = LTABLE(0, 'Very good. Now you can go to the second grade.', 'Are you enjoying yourself?', 'Wheeeeeeeeee!!!!!', 'Do you expect me to applaud?')  ->  ZilGlobal.py

# zil: gverbs.zil:1322  <ROUTINE V-SMELL ()>
@ZG.routine('V-SMELL')
def V_SMELL():
    return TELL('It smells like a ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:1325  <ROUTINE V-SPIN ()>
@ZG.routine('V-SPIN')
def V_SPIN():
    return TELL("You can't spin that!", CR)

# zil: gverbs.zil:1328  <ROUTINE V-SPRAY ()>
@ZG.routine('V-SPRAY')
def V_SPRAY():
    return ZG.V_SQUEEZE()

# zil: gverbs.zil:1331  <ROUTINE V-SQUEEZE ()>
@ZG.routine('V-SQUEEZE')
def V_SQUEEZE():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        TELL('The ', D, ZG.PRSO, ' does not understand this.')
    else:
        TELL('How singularly useless.')
    return CRLF()

# zil: gverbs.zil:1338  <ROUTINE V-SSPRAY ()>
@ZG.routine('V-SSPRAY')
def V_SSPRAY():
    return ZG.PERFORM(SYMBOL('V?SPRAY'), ZG.PRSI, ZG.PRSO)

# zil: gverbs.zil:1341  <ROUTINE V-STAB ("AUX" W)>
@ZG.routine('V-STAB')
def V_STAB():
    W = 0
    if (W := ZG.FIND_WEAPON(ZG.WINNER)):
        ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSO, W)
        return True
    else:
        return TELL('No doubt you propose to stab the ', D, ZG.PRSO, ' with your pinky?', CR)

# zil: gverbs.zil:1349  <ROUTINE V-STAND ()>
@ZG.routine('V-STAND')
def V_STAND():
    if FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
        ZG.PERFORM(SYMBOL('V?DISEMBARK'), LOC(ZG.WINNER))
        return True
    else:
        return TELL('You are already standing, I think.', CR)

# zil: gverbs.zil:1356  <ROUTINE V-STAY ()>
@ZG.routine('V-STAY')
def V_STAY():
    return TELL('You will be lost without me!', CR)

# zil: gverbs.zil:1359  <ROUTINE V-STRIKE ()>
@ZG.routine('V-STRIKE')
def V_STRIKE():
    if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
        return TELL("Since you aren't versed in hand-to-hand combat, you'd better attack the ", D, ZG.PRSO, ' with a weapon.', CR)
    else:
        ZG.PERFORM(SYMBOL('V?LAMP-ON'), ZG.PRSO)
        return True

# zil: gverbs.zil:1368  <ROUTINE V-SWIM ()>
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

# zil: gverbs.zil:1391  <ROUTINE V-SWING ()>
@ZG.routine('V-SWING')
def V_SWING():
    if (not ZG.PRSI):
        return TELL('Whoosh!', CR)
    else:
        return ZG.PERFORM(SYMBOL('V?ATTACK'), ZG.PRSI, ZG.PRSO)

# zil: gverbs.zil:1397  <ROUTINE PRE-TAKE ()>
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
        if (ZG.PRSO == ZG.DOOR_KEEPER):
            ZG.PRSI = False
            return False
        if (not (ZG.PRSI == LOC(ZG.PRSO))):
            return TELL('The ', D, ZG.PRSO, " isn't in the ", D, ZG.PRSI, '.', CR)
        else:
            ZG.PRSI = False
            return False
    elif (ZG.PRSO == LOC(ZG.WINNER)):
        return TELL("You're inside of it!", CR)
    else:
        return False

# zil: gverbs.zil:1426  <ROUTINE V-TAKE ()>
@ZG.routine('V-TAKE')
def V_TAKE():
    if (ZG.ITAKE() == True):
        if FSET_p(ZG.PRSO, Flag('WEARBIT')):
            return TELL('You are now wearing the ', D, ZG.PRSO, '.', CR)
        else:
            return TELL('Taken.', CR)
    else:
        return False

# zil: gverbs.zil:1433  <ROUTINE V-TELL ()>
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

# zil: gverbs.zil:1448  <ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)>
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
        if (ZG.SCOL_ROOM and (OBJ_l or (ZG.PRSO == ZG.CURTAIN))):
            ZG.SCOL_GO(OBJ_l)
            return True
        elif ((ZG.HERE == ZG.DEPOSITORY) and (ZG.PRSO == ZG.SNWL) and ZG.SCOL_ROOM):
            ZG.SCOL_GO(OBJ_l)
            return True
        elif ((ZG.HERE == ZG.SCOL_ACTIVE) and (ZG.PRSO == GET((M := ZG.GET_WALL(ZG.HERE)), 1))):
            ZG.SCOL_ROOM = GET(M, 2)
            ZG.PRSO = GETP(ZG.PRSO, 'SIZE')
            if OBJ_l:
                ZG.SCOL_OBJ(OBJ_l, 0, ZG.DEPOSITORY)
            else:
                ZG.SCOL_THROUGH(0, ZG.DEPOSITORY)
            return True
        elif (ZG.PRSO == ZG.CURTAIN):
            TELL("You can't go more than part way through the curtain.", CR)
            return True
        return TELL('You hit your head against the ', D, ZG.PRSO, ' as you attempt this feat.', CR)
    elif IN_p(ZG.PRSO, ZG.WINNER):
        return TELL('That would involve quite a contortion!', CR)
    else:
        return TELL(ZG.PICK_ONE(ZG.YUKS), CR)

# zil: gverbs.zil:1489  <ROUTINE V-THROW ()>
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

# zil: gverbs.zil:1506  <ROUTINE V-THROW-OFF ()>
@ZG.routine('V-THROW-OFF')
def V_THROW_OFF():
    return TELL("You can't throw anything off of that!", CR)

# zil: gverbs.zil:1509  <ROUTINE V-TIE ()>
@ZG.routine('V-TIE')
def V_TIE():
    if (ZG.PRSI == ZG.WINNER):
        return TELL("You can't tie anything to yourself.", CR)
    else:
        return TELL("You can't tie the ", D, ZG.PRSO, ' to that.', CR)

# zil: gverbs.zil:1515  <ROUTINE V-TIE-UP ()>
@ZG.routine('V-TIE-UP')
def V_TIE_UP():
    return TELL('You could certainly never tie it with that!', CR)

# zil: gverbs.zil:1518  <ROUTINE V-TREASURE ()>
@ZG.routine('V-TREASURE')
def V_TREASURE():
    if ZG.NULL_F():
        return True
    elif ZG.NULL_F():
        return True
    else:
        return TELL('Nothing happens.', CR)

# zil: gverbs.zil:1532  <ROUTINE PRE-TURN ()>
@ZG.routine('PRE-TURN')
def PRE_TURN():
    if (ZG.PRSI in (False, ZG.ROOMS)):
        return TELL("Your bare hands don't appear to be enough.", CR)
    elif (not FSET_p(ZG.PRSO, Flag('TURNBIT'))):
        return TELL("You can't turn that!", CR)
    else:
        return False

# zil: gverbs.zil:1549  <ROUTINE V-TURN ()>
@ZG.routine('V-TURN')
def V_TURN():
    return TELL('This has no effect.', CR)

# zil: gverbs.zil:1552  <ROUTINE V-UNLOCK ()>
@ZG.routine('V-UNLOCK')
def V_UNLOCK():
    return ZG.V_LOCK()

# zil: gverbs.zil:1555  <ROUTINE V-UNTIE ()>
@ZG.routine('V-UNTIE')
def V_UNTIE():
    return TELL('This cannot be tied, so it cannot be untied!', CR)

# zil: gverbs.zil:1558  <ROUTINE V-WAIT ("OPTIONAL" (NUM 3))>
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

# zil: gverbs.zil:1565  <ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)>
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
    elif ((not ZG.LIT) and ZG.PROB(80) and (ZG.WINNER == ZG.ADVENTURER) and (not FSET_p(ZG.HERE, Flag('NONLANDBIT')))):
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

# zil: gverbs.zil:1627  <ROUTINE V-WALK-AROUND ()>
@ZG.routine('V-WALK-AROUND')
def V_WALK_AROUND():
    return TELL('Use compass directions for movement.', CR)

# zil: gverbs.zil:1630  <ROUTINE V-WALK-TO ()>
@ZG.routine('V-WALK-TO')
def V_WALK_TO():
    if (ZG.PRSO and (IN_p(ZG.PRSO, ZG.HERE) or ZG.GLOBAL_IN_p(ZG.PRSO, ZG.HERE))):
        return TELL("It's here!", CR)
    else:
        return TELL('You should supply a direction!', CR)

# zil: gverbs.zil:1638  <ROUTINE V-WAVE ()>
@ZG.routine('V-WAVE')
def V_WAVE():
    return ZG.HACK_HACK('Waving the ')

# zil: gverbs.zil:1641  <ROUTINE V-WEAR ()>
@ZG.routine('V-WEAR')
def V_WEAR():
    if (not FSET_p(ZG.PRSO, Flag('WEARBIT'))):
        return TELL("You can't wear the ", D, ZG.PRSO, '.', CR)
    else:
        ZG.PERFORM(SYMBOL('V?TAKE'), ZG.PRSO)
        return True

# zil: gverbs.zil:1648  <ROUTINE V-WIN ()>
@ZG.routine('V-WIN')
def V_WIN():
    return TELL('Naturally!', CR)

# zil: gverbs.zil:1651  <ROUTINE V-WIND ()>
@ZG.routine('V-WIND')
def V_WIND():
    return TELL('You cannot wind up a ', D, ZG.PRSO, '.', CR)

# zil: gverbs.zil:1654  <ROUTINE V-WISH ()>
@ZG.routine('V-WISH')
def V_WISH():
    return ZG.PERFORM(SYMBOL('V?MAKE'), ZG.WISH)

# zil: gverbs.zil:1660  <ROUTINE V-YELL ()>
@ZG.routine('V-YELL')
def V_YELL():
    return TELL('Aaaarrrrgggghhhh!', CR)

# zil: gverbs.zil:1662  <ROUTINE V-ZORK ()>
@ZG.routine('V-ZORK')
def V_ZORK():
    return TELL('At your service!', CR)

'Verb-Associated Routines'

'Descriptions'

# zil: gverbs.zil:1670  <GLOBAL LIT>
# GLOBAL (state) LIT = False  ->  ZilGlobal.py

# zil: gverbs.zil:1672  <GLOBAL SPRAYED?>
# GLOBAL (state) SPRAYED_p = False  ->  ZilGlobal.py

# zil: gverbs.zil:1674  <ROUTINE V-FIRST-LOOK ()>
@ZG.routine('V-FIRST-LOOK')
def V_FIRST_LOOK():
    if ZG.DESCRIBE_ROOM():
        if (not ZG.SUPER_BRIEF):
            return ZG.DESCRIBE_OBJECTS()
        else:
            return False
    else:
        return False

# zil: gverbs.zil:1679  <ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)>
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
    ZG.NULL_F()
    if IN_p(ZG.HERE, ZG.ROOMS):
        TELL(D, ZG.HERE)
        if FSET_p((AV := LOC(ZG.WINNER)), Flag('VEHBIT')):
            TELL(', in the ', D, AV)
        CRLF()
    if (LOOK_p or (not ZG.SUPER_BRIEF) or (ZG.HERE == ZG.ZORK3)):
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

# zil: gverbs.zil:1725  <ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))>
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

# zil: gverbs.zil:1735  <GLOBAL DESC-OBJECT>
# GLOBAL (state) DESC_OBJECT = False  ->  ZilGlobal.py

# zil: gverbs.zil:1737  <ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)>
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
    if ((OBJ_l == ZG.SPELL_VICTIM) and (ZG.SPELL_USED == WORD('float'))):
        TELL(' (floating in midair)')
    if ((LEVEL == 0) and (AV := LOC(ZG.WINNER)) and FSET_p(AV, Flag('VEHBIT'))):
        TELL(' (outside the ', D, AV, ')')
    CRLF()
    if (ZG.SEE_INSIDE_p(OBJ_l) and FIRST_p(OBJ_l)):
        return ZG.PRINT_CONT(OBJ_l, V_p, LEVEL)
    else:
        return False

# zil: gverbs.zil:1774  <ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))>
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

# zil: gverbs.zil:1794  <ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0) "AUX" Y 1ST? SHIT AV ST...
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
                if ((LEVEL == 0) and (ZG.SPELL_p == ZG.S_FANTASIZE) and ZG.PROB(20)):
                    TELL('There is a ', ZG.PICK_ONE(ZG.FANTASIES), ' here.', CR)
                    _1ST_p = False
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

# zil: gverbs.zil:1862  <ROUTINE FIRSTER (OBJ LEVEL)>
@ZG.routine('FIRSTER')
def FIRSTER(OBJ_l, LEVEL):
    if ZG.NULL_F():
        return True
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

# zil: gverbs.zil:1881  <ROUTINE SEE-INSIDE? (OBJ)>
@ZG.routine('SEE-INSIDE?')
def SEE_INSIDE_p(OBJ_l):
    return ((not FSET_p(OBJ_l, Flag('INVISIBLE'))) and (FSET_p(OBJ_l, Flag('TRANSBIT')) or FSET_p(OBJ_l, Flag('OPENBIT'))))

'Scoring'

# zil: gverbs.zil:1887  <GLOBAL MOVES>
# GLOBAL (state) MOVES = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1889  <GLOBAL SCORE>
# GLOBAL (state) SCORE = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1891  <GLOBAL BASE-SCORE>
# GLOBAL (state) BASE_SCORE = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1893  <GLOBAL WON-FLAG>
# GLOBAL (state) WON_FLAG = False  ->  ZilGlobal.py

# zil: gverbs.zil:1895  <ROUTINE SCORE-UPD (NUM)>
@ZG.routine('SCORE-UPD')
def SCORE_UPD(NUM_l):
    ZG.BASE_SCORE = (ZG.BASE_SCORE + NUM_l)
    ZG.SCORE = (ZG.SCORE + NUM_l)
    ZG.NULL_F()
    return True

# zil: gverbs.zil:1911  <ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)>
@ZG.routine('SCORE-OBJ')
def SCORE_OBJ(OBJ_l):
    TEMP = 0
    if ((TEMP := GETP(OBJ_l, 'VALUE')) > 0):
        ZG.SCORE_UPD(TEMP)
        return PUTP(OBJ_l, 'VALUE', 0)
    else:
        return False

# zil: gverbs.zil:1916  <ROUTINE YES? ()>
@ZG.routine('YES?')
def YES_p():
    PRINTI('>')
    READ(ZG.P_INBUF, ZG.P_LEXV)
    if (GET(ZG.P_LEXV, 1) in (WORD('yes'), WORD('y'))):
        return True
    else:
        return False

'Death'

# zil: gverbs.zil:1926  <GLOBAL DEAD>
# GLOBAL (state) DEAD = False  ->  ZilGlobal.py

# zil: gverbs.zil:1928  <GLOBAL DEATHS>
# GLOBAL (state) DEATHS = 0  ->  ZilGlobal.py

# zil: gverbs.zil:1930  <GLOBAL LUCKY>
# GLOBAL (state) LUCKY = 1  ->  ZilGlobal.py

# ;"JIGS-UP is in ACTIONS.ZIL"

# ;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

# ;"KILL-INTERRUPTS is in ACTIONS.ZIL"

'Object Manipulation'

# zil: gverbs.zil:1940  <GLOBAL FUMBLE-NUMBER>
# GLOBAL (state) FUMBLE_NUMBER = 7  ->  ZilGlobal.py

# zil: gverbs.zil:1942  <GLOBAL FUMBLE-PROB>
# GLOBAL (state) FUMBLE_PROB = 8  ->  ZilGlobal.py

# zil: gverbs.zil:1944  <ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)>
@ZG.routine('ITAKE')
def ITAKE(VB=None):
    if VB is None:
        VB = True
    CNT = 0
    OBJ_l = 0
    if ZG.NULL_F():
        return False
    elif (not FSET_p(ZG.PRSO, Flag('TAKEBIT'))):
        if VB:
            TELL(ZG.PICK_ONE(ZG.YUKS), CR)
        return False
    elif ((ZG.PRSO == ZG.SPELL_VICTIM) and (ZG.SPELL_USED in (WORD('float'), WORD('freeze')))):
        if (ZG.SPELL_USED == WORD('float')):
            TELL("You can't reach that. It's floating above your head.", CR)
        else:
            TELL('It seems rooted to the spot.', CR)
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
    elif (VERB_p('TAKE') and ((CNT := ZG.CCOUNT(ZG.WINNER)) > ZG.FUMBLE_NUMBER) and ZG.PROB((CNT * ZG.FUMBLE_PROB))):
        TELL("You're holding too many things already!", CR)
        return False
    else:
        MOVE(ZG.PRSO, ZG.WINNER)
        FCLEAR(ZG.PRSO, Flag('NDESCBIT'))
        FSET(ZG.PRSO, Flag('TOUCHBIT'))
        if (ZG.SPELL_p == ZG.S_FILCH):
            if ZG.RIPOFF(ZG.PRSO, ZG.WIZARD_CASE):
                TELL('When you touch the ', D, ZG.PRSO, ' it immediately disappears!', CR)
                return False
        ZG.SCORE_OBJ(ZG.PRSO)
        return True

# zil: gverbs.zil:2010  <ROUTINE IDROP ()>
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

# zil: gverbs.zil:2023  <ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)>
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

# zil: gverbs.zil:2032  <ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))>
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

# zil: gverbs.zil:2045  <CONSTANT REXIT>
# CONSTANT (const) REXIT = 0  ->  ZilGlobal.py

# zil: gverbs.zil:2046  <CONSTANT UEXIT>
# CONSTANT (const) UEXIT = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2047  <CONSTANT NEXIT>
# CONSTANT (const) NEXIT = 2  ->  ZilGlobal.py

# zil: gverbs.zil:2048  <CONSTANT FEXIT>
# CONSTANT (const) FEXIT = 3  ->  ZilGlobal.py

# zil: gverbs.zil:2049  <CONSTANT CEXIT>
# CONSTANT (const) CEXIT = 4  ->  ZilGlobal.py

# zil: gverbs.zil:2050  <CONSTANT DEXIT>
# CONSTANT (const) DEXIT = 5  ->  ZilGlobal.py

# zil: gverbs.zil:2052  <CONSTANT NEXITSTR>
# CONSTANT (const) NEXITSTR = 0  ->  ZilGlobal.py

# zil: gverbs.zil:2053  <CONSTANT FEXITFCN>
# CONSTANT (const) FEXITFCN = 0  ->  ZilGlobal.py

# zil: gverbs.zil:2054  <CONSTANT CEXITFLAG>
# CONSTANT (const) CEXITFLAG = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2055  <CONSTANT CEXITSTR>
# CONSTANT (const) CEXITSTR = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2056  <CONSTANT DEXITOBJ>
# CONSTANT (const) DEXITOBJ = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2057  <CONSTANT DEXITSTR>
# CONSTANT (const) DEXITSTR = 1  ->  ZilGlobal.py

# zil: gverbs.zil:2059  <GLOBAL INDENTS>
# GLOBAL (state) INDENTS = TABLE(('PURE',), '', '  ', '    ', '      ', '        ', '          ')  ->  ZilGlobal.py

# zil: gverbs.zil:2068  <ROUTINE HACK-HACK (STR)>
@ZG.routine('HACK-HACK')
def HACK_HACK(STR):
    if (IN_p(ZG.PRSO, ZG.GLOBAL_OBJECTS) and VERB_p('WAVE', 'RAISE', 'LOWER')):
        return TELL('The ', D, ZG.PRSO, " isn't here!", CR)
    else:
        return TELL(STR, D, ZG.PRSO, ZG.PICK_ONE(ZG.HO_HUM), CR)

# zil: gverbs.zil:2075  <GLOBAL HO-HUM>
# GLOBAL (state) HO_HUM = LTABLE(0, " doesn't seem to work.", " isn't notably helpful.", ' has no effect.')  ->  ZilGlobal.py

# zil: gverbs.zil:2082  <ROUTINE NO-GO-TELL (AV WLOC)>
@ZG.routine('NO-GO-TELL')
def NO_GO_TELL(AV, WLOC):
    if AV:
        TELL("You can't go there in a ", D, WLOC, '.')
    else:
        TELL("You can't go there without a vehicle.")
    return CRLF()

# zil: gverbs.zil:2089  <ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <L...
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
            if (WLOC == ZG.BALLOON):
                TELL('The balloon lands.', CR)
            elif FSET_p(WLOC, Flag('VEHBIT')):
                TELL('The ', D, WLOC, ' comes to a stop.', CR, CR)
        if AV:
            MOVE(WLOC, RM)
        else:
            MOVE(ZG.WINNER, RM)
        ZG.HERE = RM
        ZG.LIT = ZG.LIT_p(ZG.HERE)
        if ((not OLIT) and (not ZG.LIT) and ZG.PROB(80)):
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
        elif ZG.NULL_F():
            return True
        elif (V_p and (ZG.WINNER == ZG.ADVENTURER)):
            ZG.V_FIRST_LOOK()
        return True

# zil: gverbs.zil:2183  <ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))>
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

# zil: gverbs.zil:2192  <ROUTINE DO-WALK (DIR)>
@ZG.routine('DO-WALK')
def DO_WALK(DIR):
    ZG.P_WALK_DIR = DIR
    return ZG.PERFORM(SYMBOL('V?WALK'), DIR)

# ;<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
# 	 <ZMEMQ .WORD
# 		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
# 		<- </ <PTSIZE .SYNS> 2> 1>>>

# zil: gverbs.zil:2201  <ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)>
@ZG.routine('GLOBAL-IN?')
def GLOBAL_IN_p(OBJ1, OBJ2):
    TX = 0
    if (TX := GETPT(OBJ2, 'GLOBAL')):
        return ZG.ZMEMQB(OBJ1, TX, (PTSIZE(TX) - 1))
    else:
        return False

# zil: gverbs.zil:2205  <ROUTINE FIND-IN (WHERE WHAT "AUX" W)>
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

# ;<ROUTINE IN-HERE? (OBJ)
# 	 <OR <IN? .OBJ ,HERE>
# 	     <GLOBAL-IN? .OBJ ,HERE>>>

# zil: gverbs.zil:2221  <ROUTINE HELD? (CAN)>
@ZG.routine('HELD?')
def HELD_p(CAN):
    while True:
        CAN = LOC(CAN)
        if (not CAN):
            return False
        elif (CAN == ZG.WINNER):
            return True

# zil: gverbs.zil:2227  <ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX)>
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

# zil: gverbs.zil:2237  <ROUTINE MUNG-ROOM (RM STR)>
@ZG.routine('MUNG-ROOM')
def MUNG_ROOM(RM, STR):
    if (RM == ZG.INSIDE_BARROW):
        return False
    FSET(RM, Flag('RMUNGBIT'))
    return PUTP(RM, 'LDESC', STR)

# zil: gverbs.zil:2245  <ROUTINE THIS-IS-IT (OBJ)>
@ZG.routine('THIS-IS-IT')
def THIS_IS_IT(OBJ_l):
    ZG.P_IT_OBJECT = OBJ_l
    return ZG.P_IT_OBJECT

# zil: gverbs.zil:2249  <GLOBAL SWIMYUKS>
# GLOBAL (state) SWIMYUKS = LTABLE(0, "You can't swim in the dungeon.")  ->  ZilGlobal.py

# zil: gverbs.zil:2252  <GLOBAL HELLOS>
# GLOBAL (state) HELLOS = LTABLE(0, 'Hello.', 'Good day.', "Nice weather we've been having lately.", 'Goodbye.')  ->  ZilGlobal.py

# zil: gverbs.zil:2258  <GLOBAL YUKS>
# GLOBAL (state) YUKS = LTABLE(0, 'A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!')  ->  ZilGlobal.py

# zil: gverbs.zil:2267  <GLOBAL DUMMY>
# GLOBAL (state) DUMMY = LTABLE(0, 'Look around.', 'Too late for that.', 'Have your eyes checked.')  ->  ZilGlobal.py
