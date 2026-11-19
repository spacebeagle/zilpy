# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'1ACTIONS for\n\t        Zork I: The Great Underground Empire\n\t(c) Copyright 1983 Infocom, Inc. All Rights Reserved.'

'SUBTITLE THE WHITE HOUSE'

# zil: 1actions.zil:7  <ROUTINE WEST-HOUSE (RARG)>
@ZG.routine('WEST-HOUSE')
def WEST_HOUSE(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are standing in an open field west of a white house, with a boarded\nfront door.')
        if ZG.WON_FLAG:
            TELL(' A secret path leads southwest into the forest.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:17  <ROUTINE EAST-HOUSE (RARG)>
@ZG.routine('EAST-HOUSE')
def EAST_HOUSE(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are behind the white house. A path leads into the forest\nto the east. In one corner of the house there is a small window\nwhich is ')
        if FSET_p(ZG.KITCHEN_WINDOW, Flag('OPENBIT')):
            TELL('open.')
        else:
            TELL('slightly ajar.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:28  <ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)>
@ZG.routine('OPEN-CLOSE')
def OPEN_CLOSE(OBJ_l, STROPN, STRCLS):
    if VERB_p('OPEN'):
        if FSET_p(OBJ_l, Flag('OPENBIT')):
            TELL(ZG.PICK_ONE(ZG.DUMMY))
        else:
            TELL(STROPN)
            FSET(OBJ_l, Flag('OPENBIT'))
        return CRLF()
    elif VERB_p('CLOSE'):
        if FSET_p(OBJ_l, Flag('OPENBIT')):
            TELL(STRCLS)
            FCLEAR(OBJ_l, Flag('OPENBIT'))
        else:
            TELL(ZG.PICK_ONE(ZG.DUMMY))
        return CRLF()
    else:
        return False

# zil: 1actions.zil:44  <ROUTINE BOARD-F ()>
@ZG.routine('BOARD-F')
def BOARD_F():
    if VERB_p('TAKE', 'EXAMINE'):
        return TELL('The boards are securely fastened.', CR)
    else:
        return False

# zil: 1actions.zil:48  <ROUTINE TEETH-F ()>
@ZG.routine('TEETH-F')
def TEETH_F():
    if (VERB_p('BRUSH') and (ZG.PRSO == ZG.TEETH)):
        if ((ZG.PRSI == ZG.PUTTY) and IN_p(ZG.PRSI, ZG.WINNER)):
            return ZG.JIGS_UP('Well, you seem to have been brushing your teeth with some sort of\nglue. As a result, your mouth gets glued together (with your nose)\nand you die of respiratory failure.')
        elif (not ZG.PRSI):
            return TELL("Dental hygiene is highly recommended, but I'm not sure what you want\nto brush them with.", CR)
        else:
            return TELL('A nice idea, but with a ', D, ZG.PRSI, '?', CR)
    else:
        return False

# zil: 1actions.zil:64  <ROUTINE GRANITE-WALL-F ()>
@ZG.routine('GRANITE-WALL-F')
def GRANITE_WALL_F():
    if (ZG.HERE == ZG.NORTH_TEMPLE):
        if VERB_p('FIND'):
            return TELL('The west wall is solid granite here.', CR)
        elif VERB_p('TAKE', 'RAISE', 'LOWER'):
            return TELL("It's solid granite.", CR)
        else:
            return False
    elif (ZG.HERE == ZG.TREASURE_ROOM):
        if VERB_p('FIND'):
            return TELL('The east wall is solid granite here.', CR)
        elif VERB_p('TAKE', 'RAISE', 'LOWER'):
            return TELL("It's solid granite.", CR)
        else:
            return False
    elif (ZG.HERE == ZG.SLIDE_ROOM):
        if VERB_p('FIND', 'READ'):
            return TELL('It only SAYS "Granite Wall".', CR)
        else:
            return TELL("The wall isn't granite.", CR)
    else:
        return TELL('There is no granite wall here.', CR)

# zil: 1actions.zil:82  <ROUTINE SONGBIRD-F ()>
@ZG.routine('SONGBIRD-F')
def SONGBIRD_F():
    if VERB_p('FIND', 'TAKE'):
        return TELL('The songbird is not here but is probably nearby.', CR)
    elif VERB_p('LISTEN'):
        return TELL("You can't hear the songbird now.", CR)
    elif VERB_p('FOLLOW'):
        return TELL("It can't be followed.", CR)
    else:
        return TELL("You can't see any songbird here.", CR)

# zil: 1actions.zil:92  <ROUTINE WHITE-HOUSE-F ()>
@ZG.routine('WHITE-HOUSE-F')
def WHITE_HOUSE_F():
    if (ZG.HERE in (ZG.KITCHEN, ZG.LIVING_ROOM, ZG.ATTIC)):
        if VERB_p('FIND'):
            return TELL('Why not find your brains?', CR)
        elif VERB_p('WALK-AROUND'):
            ZG.GO_NEXT(ZG.IN_HOUSE_AROUND)
            return True
        else:
            return False
    elif (not ((ZG.HERE in (ZG.EAST_OF_HOUSE, ZG.WEST_OF_HOUSE)) or (ZG.HERE in (ZG.NORTH_OF_HOUSE, ZG.SOUTH_OF_HOUSE)))):
        if VERB_p('FIND'):
            if (ZG.HERE == ZG.CLEARING):
                return TELL('It seems to be to the west.', CR)
            else:
                return TELL('It was here just a minute ago....', CR)
        else:
            return TELL("You're not at the house.", CR)
    elif VERB_p('FIND'):
        return TELL("It's right here! Are you blind or something?", CR)
    elif VERB_p('WALK-AROUND'):
        ZG.GO_NEXT(ZG.HOUSE_AROUND)
        return True
    elif VERB_p('EXAMINE'):
        return TELL('The house is a beautiful colonial house which is painted white.\nIt is clear that the owners must have been extremely wealthy.', CR)
    elif VERB_p('THROUGH', 'OPEN'):
        if (ZG.HERE == ZG.EAST_OF_HOUSE):
            if FSET_p(ZG.KITCHEN_WINDOW, Flag('OPENBIT')):
                return ZG.GOTO(ZG.KITCHEN)
            else:
                TELL('The window is closed.', CR)
                return ZG.THIS_IS_IT(ZG.KITCHEN_WINDOW)
        else:
            return TELL("I can't see how to get in from here.", CR)
    elif VERB_p('BURN'):
        return TELL('You must be joking.', CR)
    else:
        return False

# ;"0 -> no next, 1 -> success, 2 -> failed move"

# zil: 1actions.zil:131  <ROUTINE GO-NEXT (TBL "AUX" VAL)>
@ZG.routine('GO-NEXT')
def GO_NEXT(TBL):
    VAL = 0
    if (VAL := ZG.LKP(ZG.HERE, TBL)):
        if (not ZG.GOTO(VAL)):
            return 2
        else:
            return 1
    else:
        return False

# zil: 1actions.zil:136  <ROUTINE FOREST-F ()>
@ZG.routine('FOREST-F')
def FOREST_F():
    if VERB_p('WALK-AROUND'):
        if ((ZG.HERE in (ZG.WEST_OF_HOUSE, ZG.NORTH_OF_HOUSE, ZG.SOUTH_OF_HOUSE)) or (ZG.HERE == ZG.EAST_OF_HOUSE)):
            TELL("You aren't even in the forest.", CR)
        return ZG.GO_NEXT(ZG.FOREST_AROUND)
    elif VERB_p('DISEMBARK'):
        return TELL('You will have to specify a direction.', CR)
    elif VERB_p('FIND'):
        return TELL('You cannot see the forest for the trees.', CR)
    elif VERB_p('LISTEN'):
        return TELL('The pines and the hemlocks seem to be murmuring.', CR)
    else:
        return False

# zil: 1actions.zil:152  <ROUTINE MOUNTAIN-RANGE-F ()>
@ZG.routine('MOUNTAIN-RANGE-F')
def MOUNTAIN_RANGE_F():
    if VERB_p('CLIMB-UP', 'CLIMB-DOWN', 'CLIMB-FOO'):
        return TELL("Don't you believe me? The mountains are impassable!", CR)
    else:
        return False

# zil: 1actions.zil:157  <ROUTINE WATER-F ("AUX" AV W PI?)>
@ZG.routine('WATER-F')
def WATER_F():
    AV = 0
    W = 0
    PI_p = 0
    if VERB_p('SGIVE'):
        return False
    elif VERB_p('THROUGH', 'BOARD'):
        TELL(ZG.PICK_ONE(ZG.SWIMYUKS), CR)
        return True
    elif VERB_p('FILL'):
        W = ZG.PRSI
        ZG.PRSA = SYMBOL('V?PUT')
        ZG.PRSI = ZG.PRSO
        ZG.PRSO = W
        PI_p = False
    elif ((ZG.PRSO == ZG.GLOBAL_WATER) or (ZG.PRSO == ZG.WATER)):
        W = ZG.PRSO
        PI_p = False
    else:
        W = ZG.PRSI
        if W:
            PI_p = True
    if (W == ZG.GLOBAL_WATER):
        W = ZG.WATER
        if VERB_p('TAKE', 'PUT'):
            ZG.REMOVE_CAREFULLY(W)
    if PI_p:
        ZG.PRSI = W
    else:
        ZG.PRSO = W
    AV = LOC(ZG.WINNER)
    if (not FSET_p(AV, Flag('VEHBIT'))):
        AV = False
    if (VERB_p('TAKE', 'PUT') and (not PI_p)):
        if (AV and ((AV == ZG.PRSI) or ((not ZG.PRSI) and (not IN_p(W, AV))))):
            TELL('There is now a puddle in the bottom of the ', D, AV, '.', CR)
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            return MOVE(ZG.PRSO, AV)
        elif (ZG.PRSI and (not (ZG.PRSI == ZG.BOTTLE))):
            TELL('The water leaks out of the ', D, ZG.PRSI, ' and evaporates immediately.', CR)
            return ZG.REMOVE_CAREFULLY(W)
        elif IN_p(ZG.BOTTLE, ZG.WINNER):
            if (not FSET_p(ZG.BOTTLE, Flag('OPENBIT'))):
                TELL('The bottle is closed.', CR)
                return ZG.THIS_IS_IT(ZG.BOTTLE)
            elif (not FIRST_p(ZG.BOTTLE)):
                MOVE(ZG.WATER, ZG.BOTTLE)
                return TELL('The bottle is now full of water.', CR)
            else:
                TELL('The water slips through your fingers.', CR)
                return True
        elif (IN_p(ZG.PRSO, ZG.BOTTLE) and VERB_p('TAKE') and (not ZG.PRSI)):
            return TELL("It's in the bottle. Perhaps you should take that instead.", CR)
        else:
            return TELL('The water slips through your fingers.', CR)
    elif PI_p:
        if (VERB_p('PUT') and ZG.GLOBAL_IN_p(ZG.RIVER, ZG.HERE)):
            ZG.PERFORM(SYMBOL('V?PUT'), ZG.PRSO, ZG.RIVER)
        else:
            TELL('Nice try.', CR)
        return True
    elif VERB_p('DROP', 'GIVE'):
        if (VERB_p('DROP') and IN_p(ZG.WATER, ZG.BOTTLE) and (not FSET_p(ZG.BOTTLE, Flag('OPENBIT')))):
            TELL('The bottle is closed.', CR)
            return True
        ZG.REMOVE_CAREFULLY(ZG.WATER)
        if AV:
            TELL('There is now a puddle in the bottom of the ', D, AV, '.', CR)
            return MOVE(ZG.WATER, AV)
        else:
            TELL('The water spills to the floor and evaporates immediately.', CR)
            return ZG.REMOVE_CAREFULLY(ZG.WATER)
    elif VERB_p('THROW'):
        TELL('The water splashes on the walls and evaporates immediately.', CR)
        return ZG.REMOVE_CAREFULLY(ZG.WATER)
    else:
        return False

# zil: 1actions.zil:239  <GLOBAL KITCHEN-WINDOW-FLAG>
# GLOBAL (state) KITCHEN_WINDOW_FLAG = False  ->  ZilGlobal.py

# zil: 1actions.zil:241  <ROUTINE KITCHEN-WINDOW-F ()>
@ZG.routine('KITCHEN-WINDOW-F')
def KITCHEN_WINDOW_F():
    if VERB_p('OPEN', 'CLOSE'):
        ZG.KITCHEN_WINDOW_FLAG = True
        return ZG.OPEN_CLOSE(ZG.KITCHEN_WINDOW, 'With great effort, you open the window far enough to allow entry.', 'The window closes (more easily than it opened).')
    elif (VERB_p('EXAMINE') and (not ZG.KITCHEN_WINDOW_FLAG)):
        return TELL('The window is slightly ajar, but not enough to allow entry.', CR)
    elif VERB_p('WALK', 'BOARD', 'THROUGH'):
        if (ZG.HERE == ZG.KITCHEN):
            ZG.DO_WALK('EAST')
        else:
            ZG.DO_WALK('WEST')
        return True
    elif VERB_p('LOOK-INSIDE'):
        TELL('You can see ')
        if (ZG.HERE == ZG.KITCHEN):
            return TELL('a clear area leading towards a forest.', CR)
        else:
            return TELL('what appears to be a kitchen.', CR)
    else:
        return False

# zil: 1actions.zil:264  <ROUTINE GHOSTS-F ()>
@ZG.routine('GHOSTS-F')
def GHOSTS_F():
    if VERB_p('TELL'):
        TELL('The spirits jeer loudly and ignore you.', CR)
        ZG.P_CONT = False
        return ZG.P_CONT
    elif VERB_p('EXORCISE'):
        return TELL('Only the ceremony itself has any effect.', CR)
    elif (VERB_p('ATTACK', 'MUNG') and (ZG.PRSO == ZG.GHOSTS)):
        return TELL('How can you attack a spirit with material objects?', CR)
    else:
        return TELL('You seem unable to interact with these spirits.', CR)

# zil: 1actions.zil:275  <GLOBAL CAGE-TOP>
# GLOBAL (state) CAGE_TOP = True  ->  ZilGlobal.py

# zil: 1actions.zil:277  <ROUTINE BASKET-F ()>
@ZG.routine('BASKET-F')
def BASKET_F():
    if VERB_p('RAISE'):
        if ZG.CAGE_TOP:
            return TELL(ZG.PICK_ONE(ZG.DUMMY), CR)
        else:
            MOVE(ZG.RAISED_BASKET, ZG.SHAFT_ROOM)
            MOVE(ZG.LOWERED_BASKET, ZG.LOWER_SHAFT)
            ZG.CAGE_TOP = True
            ZG.THIS_IS_IT(ZG.RAISED_BASKET)
            return TELL('The basket is raised to the top of the shaft.', CR)
    elif VERB_p('LOWER'):
        if (not ZG.CAGE_TOP):
            return TELL(ZG.PICK_ONE(ZG.DUMMY), CR)
        else:
            MOVE(ZG.RAISED_BASKET, ZG.LOWER_SHAFT)
            MOVE(ZG.LOWERED_BASKET, ZG.SHAFT_ROOM)
            ZG.THIS_IS_IT(ZG.LOWERED_BASKET)
            TELL('The basket is lowered to the bottom of the shaft.', CR)
            ZG.CAGE_TOP = False
            if (ZG.LIT and (not ZG._set('LIT', ZG.LIT_p(ZG.HERE)))):
                TELL('It is now pitch black.', CR)
            return True
    elif ((ZG.PRSO == ZG.LOWERED_BASKET) or (ZG.PRSI == ZG.LOWERED_BASKET)):
        return TELL('The basket is at the other end of the chain.', CR)
    elif (VERB_p('TAKE') and (ZG.PRSO in (ZG.RAISED_BASKET, ZG.LOWERED_BASKET))):
        return TELL('The cage is securely fastened to the iron chain.', CR)
    else:
        return False

# zil: 1actions.zil:308  <ROUTINE BAT-F ()>
@ZG.routine('BAT-F')
def BAT_F():
    if VERB_p('TELL'):
        ZG.FWEEP(6)
        ZG.P_CONT = False
        return ZG.P_CONT
    elif VERB_p('TAKE', 'ATTACK', 'MUNG'):
        if (LOC(ZG.GARLIC) in (ZG.WINNER, ZG.HERE)):
            return TELL("You can't reach him; he's on the ceiling.", CR)
        else:
            return ZG.FLY_ME()
    else:
        return False

# zil: 1actions.zil:317  <ROUTINE FLY-ME ()>
@ZG.routine('FLY-ME')
def FLY_ME():
    ZG.FWEEP(4)
    TELL('The bat grabs you by the scruff of your neck and lifts you away....', CR, CR)
    ZG.GOTO(ZG.PICK_ONE(ZG.BAT_DROPS), False)
    if (not (ZG.HERE == ZG.ENTRANCE_TO_HADES)):
        ZG.V_FIRST_LOOK()
    return True

# zil: 1actions.zil:326  <ROUTINE FWEEP (N)>
@ZG.routine('FWEEP')
def FWEEP(N_l):
    while True:
        if ((N_l := (N_l - 1)) < 1):
            break
        else:
            TELL('    Fweep!', CR)
    return CRLF()

# zil: 1actions.zil:332  <GLOBAL BAT-DROPS>
# GLOBAL (state) BAT_DROPS = LTABLE(0, ZG.MINE_1, ZG.MINE_2, ZG.MINE_3, ZG.MINE_4, ZG.LADDER_TOP, ZG.LADDER_BOTTOM, ZG.SQUEEKY_ROOM, ZG.MINE_ENTRANCE)  ->  ZilGlobal.py

# zil: 1actions.zil:343  <ROUTINE BELL-F ()>
@ZG.routine('BELL-F')
def BELL_F():
    if VERB_p('RING'):
        if ((ZG.HERE == ZG.LLD_ROOM) and (not ZG.LLD_FLAG)):
            return False
        else:
            return TELL('Ding, dong.', CR)
    else:
        return False

# zil: 1actions.zil:351  <ROUTINE HOT-BELL-F ()>
@ZG.routine('HOT-BELL-F')
def HOT_BELL_F():
    if VERB_p('TAKE'):
        return TELL('The bell is very hot and cannot be taken.', CR)
    elif (VERB_p('RUB') or (VERB_p('RING') and ZG.PRSI)):
        if FSET_p(ZG.PRSI, Flag('BURNBIT')):
            TELL('The ', D, ZG.PRSI, ' burns and is consumed.', CR)
            return ZG.REMOVE_CAREFULLY(ZG.PRSI)
        elif (ZG.PRSI == ZG.HANDS):
            return TELL('The bell is too hot to touch.', CR)
        else:
            return TELL('The heat from the bell is too intense.', CR)
    elif VERB_p('POUR-ON'):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        TELL('The water cools the bell and is evaporated.', CR)
        ZG.QUEUE(ZG.I_XBH, 0)
        return ZG.I_XBH()
    elif VERB_p('RING'):
        return TELL('The bell is too hot to reach.', CR)
    else:
        return False

# zil: 1actions.zil:370  <ROUTINE BOARDED-WINDOW-FCN ()>
@ZG.routine('BOARDED-WINDOW-FCN')
def BOARDED_WINDOW_FCN():
    if VERB_p('OPEN'):
        return TELL("The windows are boarded and can't be opened.", CR)
    elif VERB_p('MUNG'):
        return TELL("You can't break the windows open.", CR)
    else:
        return False

# zil: 1actions.zil:376  <ROUTINE NAILS-PSEUDO ()>
@ZG.routine('NAILS-PSEUDO')
def NAILS_PSEUDO():
    if VERB_p('TAKE'):
        return TELL('The nails, deeply imbedded in the door, cannot be removed.', CR)
    else:
        return False

# zil: 1actions.zil:381  <ROUTINE CRACK-FCN ()>
@ZG.routine('CRACK-FCN')
def CRACK_FCN():
    if VERB_p('THROUGH'):
        return TELL("You can't fit through the crack.", CR)
    else:
        return False

# zil: 1actions.zil:385  <ROUTINE KITCHEN-FCN (RARG)>
@ZG.routine('KITCHEN-FCN')
def KITCHEN_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in the kitchen of the white house. A table seems to\nhave been used recently for the preparation of food. A passage\nleads to the west and a dark staircase can be seen leading\nupward. A dark chimney leads down and to the east is a small\nwindow which is ')
        if FSET_p(ZG.KITCHEN_WINDOW, Flag('OPENBIT')):
            return TELL('open.', CR)
        else:
            return TELL('slightly ajar.', CR)
    elif (RARG == ZG.M_BEG):
        if (VERB_p('CLIMB-UP') and (ZG.PRSO == ZG.STAIRS)):
            return ZG.DO_WALK('UP')
        elif (VERB_p('CLIMB-UP') and (ZG.PRSO == ZG.STAIRS)):
            return TELL('There are no stairs leading down.', CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:403  <ROUTINE STONE-BARROW-FCN (RARG)>
@ZG.routine('STONE-BARROW-FCN')
def STONE_BARROW_FCN(RARG):
    if ((RARG == ZG.M_BEG) and (VERB_p('ENTER') or (VERB_p('WALK') and (ZG.PRSO in ('WEST', 'IN'))) or (VERB_p('THROUGH') and (ZG.PRSO == ZG.BARROW)))):
        TELL('Inside the Barrow\nAs you enter the barrow, the door closes inexorably behind you. Around\nyou it is dark, but ahead is an enormous cavern, brightly lit. Through\nits center runs a wide stream. Spanning the stream is a small wooden\nfootbridge, and beyond a path leads into a dark tunnel. Above the\nbridge, floating in the air, is a large sign. It reads:  All ye who\nstand before this bridge have completed a great and perilous adventure\nwhich has tested your wit and courage. You have mastered')
        if ((GETB(0, 1) & 8) == 0):
            TELL('\nthe first part of the ZORK trilogy. Those who pass over this bridge must be\nprepared to undertake an even greater adventure that will severely test your\nskill and bravery!\n\nThe ZORK trilogy continues with "ZORK II: The Wizard of Frobozz" and\nis completed in "ZORK III: The Dungeon Master."', CR)
        else:
            TELL('\nZORK: The Great Underground Empire.\n', CR)
        return ZG.FINISH()
    else:
        return False

# zil: 1actions.zil:432  <ROUTINE BARROW-DOOR-FCN ()>
@ZG.routine('BARROW-DOOR-FCN')
def BARROW_DOOR_FCN():
    if VERB_p('OPEN', 'CLOSE'):
        return TELL('The door is too heavy.', CR)
    else:
        return False

# zil: 1actions.zil:436  <ROUTINE BARROW-FCN ()>
@ZG.routine('BARROW-FCN')
def BARROW_FCN():
    if VERB_p('THROUGH'):
        return ZG.DO_WALK('WEST')
    else:
        return False

# zil: 1actions.zil:442  <ROUTINE TROPHY-CASE-FCN ()>
@ZG.routine('TROPHY-CASE-FCN')
def TROPHY_CASE_FCN():
    if (VERB_p('TAKE') and (ZG.PRSO == ZG.TROPHY_CASE)):
        return TELL('The trophy case is securely fastened to the wall.', CR)
    else:
        return False

# zil: 1actions.zil:447  <GLOBAL RUG-MOVED>
# GLOBAL (state) RUG_MOVED = False  ->  ZilGlobal.py

# zil: 1actions.zil:449  <ROUTINE LIVING-ROOM-FCN (RARG "AUX" RUG? TC)>
@ZG.routine('LIVING-ROOM-FCN')
def LIVING_ROOM_FCN(RARG):
    RUG_p = 0
    TC = 0
    if (RARG == ZG.M_LOOK):
        TELL('You are in the living room. There is a doorway to the east')
        if ZG.MAGIC_FLAG:
            TELL('. To the\nwest is a cyclops-shaped opening in an old wooden door, above which is\nsome strange gothic lettering, ')
        else:
            TELL(', a wooden\ndoor with strange gothic lettering to the west, which appears to be\nnailed shut, ')
        TELL('a trophy case, ')
        RUG_p = ZG.RUG_MOVED
        if (RUG_p and FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT'))):
            TELL('and a rug lying beside an open trap door.')
        elif RUG_p:
            TELL('and a closed trap door at your feet.')
        elif FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')):
            TELL('and an open trap door at your feet.')
        else:
            TELL('and a large oriental rug in the center of the room.')
        CRLF()
        return True
    elif (RARG == ZG.M_END):
        if (VERB_p('TAKE') or (VERB_p('PUT') and (ZG.PRSI == ZG.TROPHY_CASE))):
            if IN_p(ZG.PRSO, ZG.TROPHY_CASE):
                ZG.TOUCH_ALL(ZG.PRSO)
            ZG.SCORE = (ZG.BASE_SCORE + ZG.OTVAL_FROB())
            ZG.SCORE_UPD(0)
            return False
        else:
            return False
    else:
        return False

# zil: 1actions.zil:487  <ROUTINE TOUCH-ALL (OBJ "AUX" F)>
@ZG.routine('TOUCH-ALL')
def TOUCH_ALL(OBJ_l):
    F = 0
    F = FIRST_p(OBJ_l)
    while True:
        if (not F):
            return True
        else:
            FSET(F, Flag('TOUCHBIT'))
            if FIRST_p(F):
                ZG.TOUCH_ALL(F)
        F = NEXT_p(F)

# zil: 1actions.zil:496  <ROUTINE OTVAL-FROB ("OPTIONAL" (O ,TROPHY-CASE) "AUX" F (SCORE 0))>
@ZG.routine('OTVAL-FROB')
def OTVAL_FROB(O_l=None):
    if O_l is None:
        O_l = ZG.TROPHY_CASE
    F = 0
    SCORE = 0
    F = FIRST_p(O_l)
    while True:
        if (not F):
            return SCORE
        SCORE = (SCORE + GETP(F, 'TVALUE'))
        if FIRST_p(F):
            ZG.OTVAL_FROB(F)
        F = NEXT_p(F)

# zil: 1actions.zil:504  <ROUTINE TRAP-DOOR-FCN ()>
@ZG.routine('TRAP-DOOR-FCN')
def TRAP_DOOR_FCN():
    if VERB_p('RAISE'):
        ZG.PERFORM(SYMBOL('V?OPEN'), ZG.TRAP_DOOR)
        return True
    elif (VERB_p('OPEN', 'CLOSE') and (ZG.HERE == ZG.LIVING_ROOM)):
        return ZG.OPEN_CLOSE(ZG.PRSO, 'The door reluctantly opens to reveal a rickety staircase descending into\ndarkness.', 'The door swings shut and closes.')
    elif (VERB_p('LOOK-UNDER') and (ZG.HERE == ZG.LIVING_ROOM)):
        if FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')):
            return TELL('You see a rickety staircase descending into darkness.', CR)
        else:
            return TELL("It's closed.", CR)
    elif (ZG.HERE == ZG.CELLAR):
        if (VERB_p('OPEN', 'UNLOCK') and (not FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')))):
            return TELL('The door is locked from above.', CR)
        elif (VERB_p('CLOSE') and (not FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')))):
            FCLEAR(ZG.TRAP_DOOR, Flag('TOUCHBIT'))
            FCLEAR(ZG.TRAP_DOOR, Flag('OPENBIT'))
            return TELL('The door closes and locks.', CR)
        elif VERB_p('OPEN', 'CLOSE'):
            return TELL(ZG.PICK_ONE(ZG.DUMMY), CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:531  <ROUTINE CELLAR-FCN (RARG)>
@ZG.routine('CELLAR-FCN')
def CELLAR_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        return TELL('You are in a dark and damp cellar with a narrow passageway leading\nnorth, and a crawlway to the south. On the west is the bottom of a\nsteep metal ramp which is unclimbable.', CR)
    elif (RARG == ZG.M_ENTER):
        if (FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')) and (not FSET_p(ZG.TRAP_DOOR, Flag('TOUCHBIT')))):
            FCLEAR(ZG.TRAP_DOOR, Flag('OPENBIT'))
            FSET(ZG.TRAP_DOOR, Flag('TOUCHBIT'))
            return TELL('The trap door crashes shut, and you hear someone barring it.', CR, CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:545  <ROUTINE CHIMNEY-F ()>
@ZG.routine('CHIMNEY-F')
def CHIMNEY_F():
    if VERB_p('EXAMINE'):
        TELL('The chimney leads ')
        if (ZG.HERE == ZG.KITCHEN):
            TELL('down')
        else:
            TELL('up')
        return TELL('ward, and looks climbable.', CR)
    else:
        return False

# zil: 1actions.zil:553  <ROUTINE UP-CHIMNEY-FUNCTION ("AUX" F)>
@ZG.routine('UP-CHIMNEY-FUNCTION')
def UP_CHIMNEY_FUNCTION():
    F = 0
    if (not (F := FIRST_p(ZG.WINNER))):
        TELL('Going up empty-handed is a bad idea.', CR)
        return False
    elif (((not (F := NEXT_p(F))) or (not NEXT_p(F))) and IN_p(ZG.LAMP, ZG.WINNER)):
        if (not FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT'))):
            FCLEAR(ZG.TRAP_DOOR, Flag('TOUCHBIT'))
        return ZG.KITCHEN
    else:
        TELL("You can't get up there with what you're carrying.", CR)
        return False

# zil: 1actions.zil:567  <ROUTINE TRAP-DOOR-EXIT ()>
@ZG.routine('TRAP-DOOR-EXIT')
def TRAP_DOOR_EXIT():
    if ZG.RUG_MOVED:
        if FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')):
            return ZG.CELLAR
        else:
            TELL('The trap door is closed.', CR)
            ZG.THIS_IS_IT(ZG.TRAP_DOOR)
            return False
    else:
        TELL("You can't go that way.", CR)
        return False

# zil: 1actions.zil:579  <ROUTINE RUG-FCN ()>
@ZG.routine('RUG-FCN')
def RUG_FCN():
    if VERB_p('RAISE'):
        TELL('The rug is too heavy to lift')
        if ZG.RUG_MOVED:
            return TELL('.', CR)
        else:
            return TELL(', but in trying to take it you have\nnoticed an irregularity beneath it.', CR)
    elif VERB_p('MOVE', 'PUSH'):
        if ZG.RUG_MOVED:
            return TELL('Having moved the carpet previously, you find it impossible to move\nit again.', CR)
        else:
            TELL('With a great effort, the rug is moved to one side of the room, revealing\nthe dusty cover of a closed trap door.', CR)
            FCLEAR(ZG.TRAP_DOOR, Flag('INVISIBLE'))
            ZG.THIS_IS_IT(ZG.TRAP_DOOR)
            ZG.RUG_MOVED = True
            return ZG.RUG_MOVED
    elif VERB_p('TAKE'):
        return TELL('The rug is extremely heavy and cannot be carried.', CR)
    elif (VERB_p('LOOK-UNDER') and (not ZG.RUG_MOVED) and (not FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')))):
        return TELL('Underneath the rug is a closed trap door. As you drop the corner of the\nrug, the trap door is once again concealed from view.', CR)
    elif VERB_p('CLIMB-ON'):
        if ((not ZG.RUG_MOVED) and (not FSET_p(ZG.TRAP_DOOR, Flag('OPENBIT')))):
            return TELL('As you sit, you notice an irregularity underneath it. Rather than be\nuncomfortable, you stand up again.', CR)
        else:
            return TELL("I suppose you think it's a magic carpet?", CR)
    else:
        return False

'SUBTITLE TROLL'

# zil: 1actions.zil:622  <ROUTINE AXE-F ()>
@ZG.routine('AXE-F')
def AXE_F():
    if ZG.TROLL_FLAG:
        return False
    else:
        return ZG.WEAPON_FUNCTION(ZG.AXE, ZG.TROLL)

# zil: 1actions.zil:626  <ROUTINE STILETTO-FUNCTION ()>
@ZG.routine('STILETTO-FUNCTION')
def STILETTO_FUNCTION():
    return ZG.WEAPON_FUNCTION(ZG.STILETTO, ZG.THIEF)

# zil: 1actions.zil:629  <ROUTINE WEAPON-FUNCTION (W V)>
@ZG.routine('WEAPON-FUNCTION')
def WEAPON_FUNCTION(W, V):
    if (not IN_p(V, ZG.HERE)):
        return False
    elif VERB_p('TAKE'):
        if IN_p(W, V):
            TELL('The ', D, V, ' swings it out of your reach.', CR)
        else:
            TELL('The ', D, W, " seems white-hot. You can't hold on to it.", CR)
        return True
    else:
        return False

# zil: 1actions.zil:640  <ROUTINE TROLL-FCN ("OPTIONAL" (MODE <>))>
@ZG.routine('TROLL-FCN')
def TROLL_FCN(MODE=None):
    if MODE is None:
        MODE = False
    if VERB_p('TELL'):
        ZG.P_CONT = False
        return TELL("The troll isn't much of a conversationalist.", CR)
    elif (MODE == ZG.F_BUSY_p):
        if IN_p(ZG.AXE, ZG.TROLL):
            return False
        elif (IN_p(ZG.AXE, ZG.HERE) and ZG.PROB_2(75, 90)):
            FSET(ZG.AXE, Flag('NDESCBIT'))
            FCLEAR(ZG.AXE, Flag('WEAPONBIT'))
            MOVE(ZG.AXE, ZG.TROLL)
            PUTP(ZG.TROLL, 'LDESC', 'A nasty-looking troll, brandishing a bloody axe, blocks all passages out\nof the room.')
            (IN_p(ZG.TROLL, ZG.HERE) and TELL('The troll, angered and humiliated, recovers his weapon. He appears to have\nan axe to grind with you.', CR))
            return True
        elif IN_p(ZG.TROLL, ZG.HERE):
            PUTP(ZG.TROLL, 'LDESC', 'A pathetically babbling troll is here.')
            TELL('The troll, disarmed, cowers in terror, pleading for his life in\nthe guttural tongue of the trolls.', CR)
            return True
        else:
            return False
    elif (MODE == ZG.F_DEAD):
        if IN_p(ZG.AXE, ZG.TROLL):
            MOVE(ZG.AXE, ZG.HERE)
            FCLEAR(ZG.AXE, Flag('NDESCBIT'))
            FSET(ZG.AXE, Flag('WEAPONBIT'))
        ZG.TROLL_FLAG = True
        return ZG.TROLL_FLAG
    elif (MODE == ZG.F_UNCONSCIOUS):
        FCLEAR(ZG.TROLL, Flag('FIGHTBIT'))
        if IN_p(ZG.AXE, ZG.TROLL):
            MOVE(ZG.AXE, ZG.HERE)
            FCLEAR(ZG.AXE, Flag('NDESCBIT'))
            FSET(ZG.AXE, Flag('WEAPONBIT'))
        PUTP(ZG.TROLL, 'LDESC', 'An unconscious troll is sprawled on the floor. All passages\nout of the room are open.')
        ZG.TROLL_FLAG = True
        return ZG.TROLL_FLAG
    elif (MODE == ZG.F_CONSCIOUS):
        if IN_p(ZG.TROLL, ZG.HERE):
            FSET(ZG.TROLL, Flag('FIGHTBIT'))
            TELL('The troll stirs, quickly resuming a fighting stance.', CR)
        if IN_p(ZG.AXE, ZG.TROLL):
            PUTP(ZG.TROLL, 'LDESC', 'A nasty-looking troll, brandishing a bloody axe, blocks\nall passages out of the room.')
        elif IN_p(ZG.AXE, ZG.TROLL_ROOM):
            FSET(ZG.AXE, Flag('NDESCBIT'))
            FCLEAR(ZG.AXE, Flag('WEAPONBIT'))
            MOVE(ZG.AXE, ZG.TROLL)
            PUTP(ZG.TROLL, 'LDESC', 'A nasty-looking troll, brandishing a bloody axe, blocks\nall passages out of the room.')
        else:
            PUTP(ZG.TROLL, 'LDESC', 'A troll is here.')
        ZG.TROLL_FLAG = False
        return ZG.TROLL_FLAG
    elif (MODE == ZG.F_FIRST_p):
        if ZG.PROB_1(33):
            FSET(ZG.TROLL, Flag('FIGHTBIT'))
            ZG.P_CONT = False
            return True
        else:
            return False
    elif (not MODE):
        if VERB_p('EXAMINE'):
            return TELL(GETP(ZG.TROLL, 'LDESC'), CR)
        elif ((VERB_p('THROW', 'GIVE') and ZG.PRSO and (ZG.PRSI == ZG.TROLL)) or VERB_p('TAKE', 'MOVE', 'MUNG')):
            ZG.AWAKEN(ZG.TROLL)
            if VERB_p('THROW', 'GIVE'):
                if ((ZG.PRSO == ZG.AXE) and IN_p(ZG.AXE, ZG.WINNER)):
                    TELL('The troll scratches his head in confusion, then takes the axe.', CR)
                    FSET(ZG.TROLL, Flag('FIGHTBIT'))
                    MOVE(ZG.AXE, ZG.TROLL)
                    return True
                elif (ZG.PRSO in (ZG.TROLL, ZG.AXE)):
                    TELL('You would have to get the ', D, ZG.PRSO, ' first, and that seems unlikely.', CR)
                    return True
                if VERB_p('THROW'):
                    TELL('The troll, who is remarkably coordinated, catches the ', D, ZG.PRSO)
                else:
                    TELL('The troll, who is not overly proud, graciously accepts the gift')
                if (ZG.PROB_1(20) and (ZG.PRSO in (ZG.KNIFE, ZG.SWORD, ZG.AXE))):
                    ZG.REMOVE_CAREFULLY(ZG.PRSO)
                    TELL(' and eats it hungrily. Poor troll, he dies from an internal hemorrhage\nand his carcass disappears in a sinister black fog.', CR)
                    ZG.REMOVE_CAREFULLY(ZG.TROLL)
                    APPLY(GETP(ZG.TROLL, 'ACTION'), ZG.F_DEAD)
                    ZG.TROLL_FLAG = True
                    return ZG.TROLL_FLAG
                elif (ZG.PRSO in (ZG.KNIFE, ZG.SWORD, ZG.AXE)):
                    MOVE(ZG.PRSO, ZG.HERE)
                    TELL(' and, being for the moment sated, throws it back. Fortunately, the\ntroll has poor control, and the ', D, ZG.PRSO, ' falls to the floor. He does\nnot look pleased.', CR)
                    return FSET(ZG.TROLL, Flag('FIGHTBIT'))
                else:
                    TELL(' and not having the most discriminating tastes, gleefully eats it.', CR)
                    return ZG.REMOVE_CAREFULLY(ZG.PRSO)
            elif VERB_p('TAKE', 'MOVE'):
                return TELL('The troll spits in your face, grunting "Better luck next time" in a\nrather barbarous accent.', CR)
            elif VERB_p('MUNG'):
                return TELL('The troll laughs at your puny gesture.', CR)
            else:
                return False
        elif VERB_p('LISTEN'):
            return TELL('Every so often the troll says something, probably uncomplimentary, in\nhis guttural tongue.', CR)
        elif (ZG.TROLL_FLAG and VERB_p('HELLO')):
            return TELL("Unfortunately, the troll can't hear you.", CR)
        else:
            return False
    else:
        return False

'SUBTITLE GRATING/MAZE'

# ;<GLOBAL LEAVES-GONE <>>

# ;"no longer used?"

# zil: 1actions.zil:771  <GLOBAL GRATE-REVEALED>
# GLOBAL (state) GRATE_REVEALED = False  ->  ZilGlobal.py

# zil: 1actions.zil:772  <GLOBAL GRUNLOCK>
# GLOBAL (state) GRUNLOCK = False  ->  ZilGlobal.py

# zil: 1actions.zil:774  <ROUTINE LEAVES-APPEAR ()>
@ZG.routine('LEAVES-APPEAR')
def LEAVES_APPEAR():
    if ((not FSET_p(ZG.GRATE, Flag('OPENBIT'))) and (not ZG.GRATE_REVEALED)):
        if VERB_p('MOVE', 'TAKE'):
            TELL('In disturbing the pile of leaves, a grating is revealed.', CR)
        else:
            TELL('With the leaves moved, a grating is revealed.', CR)
        FCLEAR(ZG.GRATE, Flag('INVISIBLE'))
        ZG.GRATE_REVEALED = True
    return False

# zil: 1actions.zil:786  <ROUTINE LEAF-PILE ()>
@ZG.routine('LEAF-PILE')
def LEAF_PILE():
    if VERB_p('COUNT'):
        return TELL('There are 69,105 leaves here.', CR)
    elif VERB_p('BURN'):
        ZG.LEAVES_APPEAR()
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        if IN_p(ZG.PRSO, ZG.HERE):
            return TELL('The leaves burn.', CR)
        else:
            return ZG.JIGS_UP('The leaves burn, and so do you.')
    elif VERB_p('CUT'):
        TELL('You rustle the leaves around, making quite a mess.', CR)
        ZG.LEAVES_APPEAR()
        return True
    elif VERB_p('MOVE', 'TAKE'):
        if VERB_p('MOVE'):
            TELL('Done.', CR)
        if ZG.GRATE_REVEALED:
            return False
        ZG.LEAVES_APPEAR()
        if VERB_p('TAKE'):
            return False
        else:
            return True
    elif (VERB_p('LOOK-UNDER') and (not ZG.GRATE_REVEALED)):
        return TELL('Underneath the pile of leaves is a grating. As you release the leaves,\nthe grating is once again concealed from view.', CR)
    else:
        return False

# zil: 1actions.zil:815  <ROUTINE CLEARING-FCN (RARG)>
@ZG.routine('CLEARING-FCN')
def CLEARING_FCN(RARG):
    if (RARG == ZG.M_ENTER):
        if (not ZG.GRATE_REVEALED):
            return FSET(ZG.GRATE, Flag('INVISIBLE'))
        else:
            return False
    elif (RARG == ZG.M_LOOK):
        TELL('You are in a clearing, with a forest surrounding you on all sides. A\npath leads south.')
        if FSET_p(ZG.GRATE, Flag('OPENBIT')):
            CRLF()
            TELL('There is an open grating, descending into darkness.')
        elif ZG.GRATE_REVEALED:
            CRLF()
            TELL('There is a grating securely fastened into the ground.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:833  <ROUTINE MAZE-11-FCN (RARG)>
@ZG.routine('MAZE-11-FCN')
def MAZE_11_FCN(RARG):
    if (RARG == ZG.M_ENTER):
        return FCLEAR(ZG.GRATE, Flag('INVISIBLE'))
    elif (RARG == ZG.M_LOOK):
        TELL('You are in a small room near the maze. There are twisty passages\nin the immediate vicinity.', CR)
        if FSET_p(ZG.GRATE, Flag('OPENBIT')):
            TELL('Above you is an open grating with sunlight pouring in.')
        elif ZG.GRUNLOCK:
            TELL('Above you is a grating.')
        else:
            TELL('Above you is a grating locked with a skull-and-crossbones lock.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:850  <ROUTINE GRATE-FUNCTION ()>
@ZG.routine('GRATE-FUNCTION')
def GRATE_FUNCTION():
    if (VERB_p('OPEN') and (ZG.PRSI == ZG.KEYS)):
        ZG.PERFORM(SYMBOL('V?UNLOCK'), ZG.GRATE, ZG.KEYS)
        return True
    elif VERB_p('LOCK'):
        if (ZG.HERE == ZG.GRATING_ROOM):
            ZG.GRUNLOCK = False
            return TELL('The grate is locked.', CR)
        elif (ZG.HERE == ZG.GRATING_CLEARING):
            return TELL("You can't lock it from this side.", CR)
        else:
            return False
    elif (VERB_p('UNLOCK') and (ZG.PRSO == ZG.GRATE)):
        if ((ZG.HERE == ZG.GRATING_ROOM) and (ZG.PRSI == ZG.KEYS)):
            ZG.GRUNLOCK = True
            return TELL('The grate is unlocked.', CR)
        elif ((ZG.HERE == ZG.GRATING_CLEARING) and (ZG.PRSI == ZG.KEYS)):
            return TELL("You can't reach the lock from here.", CR)
        else:
            return TELL('Can you unlock a grating with a ', D, ZG.PRSI, '?', CR)
    elif VERB_p('PICK'):
        return TELL("You can't pick the lock.", CR)
    elif VERB_p('OPEN', 'CLOSE'):
        if ZG.GRUNLOCK:
            if (ZG.HERE == ZG.CLEARING):
                _tmp1 = 'The grating opens.'
            else:
                _tmp1 = 'The grating opens to reveal trees above you.'
            if (ZG.HERE == ZG.CLEARING):
                _tmp2 = 'The grating opens.'
            else:
                _tmp2 = 'The grating opens to reveal trees above you.'
            ZG.OPEN_CLOSE(ZG.GRATE, _tmp2, 'The grating is closed.')
            if FSET_p(ZG.GRATE, Flag('OPENBIT')):
                if ((not (ZG.HERE == ZG.CLEARING)) and (not ZG.GRATE_REVEALED)):
                    TELL('A pile of leaves falls onto your head and to the ground.', CR)
                    ZG.GRATE_REVEALED = True
                    MOVE(ZG.LEAVES, ZG.HERE)
                return FSET(ZG.GRATING_ROOM, Flag('ONBIT'))
            else:
                return FCLEAR(ZG.GRATING_ROOM, Flag('ONBIT'))
        else:
            return TELL('The grating is locked.', CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.GRATE)):
        if (GETP(ZG.PRSO, 'SIZE') > 20):
            return TELL("It won't fit through the grating.", CR)
        else:
            MOVE(ZG.PRSO, ZG.GRATING_ROOM)
            return TELL('The ', D, ZG.PRSO, ' goes through the grating into the darkness below.', CR)
    else:
        return False

# zil: 1actions.zil:898  <ROUTINE MAZE-DIODES ()>
@ZG.routine('MAZE-DIODES')
def MAZE_DIODES():
    TELL("You won't be able to get back up to the tunnel you are going through\nwhen it gets to the next room.", CR, CR)
    if (ZG.HERE == ZG.MAZE_2):
        return ZG.MAZE_4
    elif (ZG.HERE == ZG.MAZE_7):
        return ZG.DEAD_END_1
    elif (ZG.HERE == ZG.MAZE_9):
        return ZG.MAZE_11
    elif (ZG.HERE == ZG.MAZE_12):
        return ZG.MAZE_5
    else:
        return False

# zil: 1actions.zil:907  <ROUTINE RUSTY-KNIFE-FCN ()>
@ZG.routine('RUSTY-KNIFE-FCN')
def RUSTY_KNIFE_FCN():
    if VERB_p('TAKE'):
        (IN_p(ZG.SWORD, ZG.WINNER) and TELL('As you touch the rusty knife, your sword gives a single pulse of blinding\nblue light.', CR))
        return False
    elif (((ZG.PRSI == ZG.RUSTY_KNIFE) and VERB_p('ATTACK')) or (VERB_p('SWING') and (ZG.PRSO == ZG.RUSTY_KNIFE) and ZG.PRSI)):
        ZG.REMOVE_CAREFULLY(ZG.RUSTY_KNIFE)
        return ZG.JIGS_UP('As the knife approaches its victim, your mind is submerged by an\novermastering will. Slowly, your hand turns, until the rusty blade\nis an inch from your neck. The knife seems to sing as it savagely\nslits your throat.')
    else:
        return False

# zil: 1actions.zil:926  <ROUTINE KNIFE-F ()>
@ZG.routine('KNIFE-F')
def KNIFE_F():
    if VERB_p('TAKE'):
        FCLEAR(ZG.ATTIC_TABLE, Flag('NDESCBIT'))
        return False
    else:
        return False

# zil: 1actions.zil:931  <ROUTINE SKELETON ()>
@ZG.routine('SKELETON')
def SKELETON():
    if VERB_p('TAKE', 'RUB', 'MOVE', 'PUSH', 'RAISE', 'LOWER', 'ATTACK', 'KICK', 'KISS'):
        TELL('A ghost appears in the room and is appalled at your desecration of\nthe remains of a fellow adventurer. He casts a curse on your valuables\nand banishes them to the Land of the Living Dead. The ghost leaves,\nmuttering obscenities.', CR)
        ZG.ROB(ZG.HERE, ZG.LAND_OF_LIVING_DEAD, 100)
        ZG.ROB(ZG.ADVENTURER, ZG.LAND_OF_LIVING_DEAD)
        return True
    else:
        return False

# zil: 1actions.zil:944  <ROUTINE TORCH-OBJECT ()>
@ZG.routine('TORCH-OBJECT')
def TORCH_OBJECT():
    if VERB_p('EXAMINE'):
        return TELL('The torch is burning.', CR)
    elif (VERB_p('POUR-ON') and (ZG.PRSI == ZG.TORCH)):
        return TELL('The water evaporates before it gets close.', CR)
    elif (VERB_p('LAMP-OFF') and FSET_p(ZG.PRSO, Flag('ONBIT'))):
        return TELL('You nearly burn your hand trying to extinguish the flame.', CR)
    else:
        return False

'SUBTITLE MIRROR, MIRROR, ON THE WALL'

# zil: 1actions.zil:958  <ROUTINE MIRROR-ROOM (RARG)>
@ZG.routine('MIRROR-ROOM')
def MIRROR_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a large square room with tall ceilings. On the south wall\nis an enormous mirror which fills the entire wall. There are exits\non the other three sides of the room.', CR)
        if ZG.MIRROR_MUNG:
            return TELL('Unfortunately, the mirror has been destroyed by your recklessness.', CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:968  <GLOBAL MIRROR-MUNG>
# GLOBAL (state) MIRROR_MUNG = False  ->  ZilGlobal.py

# zil: 1actions.zil:969  <GLOBAL LUCKY>
# GLOBAL (state) LUCKY = True  ->  ZilGlobal.py

# zil: 1actions.zil:971  <ROUTINE MIRROR-MIRROR ("AUX" (RM2 ,MIRROR-ROOM-2) L1 L2 N)>
@ZG.routine('MIRROR-MIRROR')
def MIRROR_MIRROR():
    RM2 = ZG.MIRROR_ROOM_2
    L1 = 0
    L2 = 0
    N_l = 0
    if ((not ZG.MIRROR_MUNG) and VERB_p('RUB')):
        if (ZG.PRSI and (not (ZG.PRSI == ZG.HANDS))):
            TELL('You feel a faint tingling transmitted through the ', D, ZG.PRSI, '.', CR)
            return True
        if (ZG.HERE == RM2):
            RM2 = ZG.MIRROR_ROOM_1
        L1 = FIRST_p(ZG.HERE)
        L2 = FIRST_p(RM2)
        while True:
            if (not L1):
                break
            N_l = NEXT_p(L1)
            MOVE(L1, RM2)
            L1 = N_l
        while True:
            if (not L2):
                break
            N_l = NEXT_p(L2)
            MOVE(L2, ZG.HERE)
            L2 = N_l
        ZG.GOTO(RM2, False)
        return TELL('There is a rumble from deep within the earth and the room shakes.', CR)
    elif VERB_p('LOOK-INSIDE', 'EXAMINE'):
        if ZG.MIRROR_MUNG:
            TELL('The mirror is broken into many pieces.')
        else:
            TELL('There is an ugly person staring back at you.')
        return CRLF()
    elif VERB_p('TAKE'):
        return TELL('The mirror is many times your size. Give up.', CR)
    elif VERB_p('MUNG', 'THROW', 'ATTACK'):
        if ZG.MIRROR_MUNG:
            return TELL("Haven't you done enough damage already?", CR)
        else:
            ZG.MIRROR_MUNG = True
            ZG.LUCKY = False
            return TELL("You have broken the mirror. I hope you have a seven years' supply of\ngood luck handy.", CR)
    else:
        return False

'SUBTITLE THE DOME'

# zil: 1actions.zil:1018  <ROUTINE TORCH-ROOM-FCN (RARG)>
@ZG.routine('TORCH-ROOM-FCN')
def TORCH_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a large room with a prominent doorway leading to a down\nstaircase. Above you is a large dome. Up around the edge of the\ndome (20 feet up) is a wooden railing. In the center of the room\nsits a white marble pedestal.', CR)
        if ZG.DOME_FLAG:
            return TELL('A piece of rope descends from the railing above, ending some\nfive feet above your head.', CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:1030  <ROUTINE DOME-ROOM-FCN (RARG)>
@ZG.routine('DOME-ROOM-FCN')
def DOME_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are at the periphery of a large dome, which forms the ceiling\nof another room below. Protecting you from a precipitous drop is a\nwooden railing which circles the dome.', CR)
        if ZG.DOME_FLAG:
            return TELL('Hanging down from the railing is a rope which ends about ten feet\nfrom the floor below.', CR)
        else:
            return False
    elif (RARG == ZG.M_ENTER):
        if ZG.DEAD:
            TELL('As you enter the dome you feel a strong pull as if from a wind\ndrawing you over the railing and down.', CR)
            MOVE(ZG.WINNER, ZG.TORCH_ROOM)
            ZG.HERE = ZG.TORCH_ROOM
            return True
        elif VERB_p('LEAP'):
            return ZG.JIGS_UP("I'm afraid that the leap you attempted has done you in.")
        else:
            return False
    else:
        return False

# ;<GLOBAL EGYPT-FLAG <>>

# ;"no longer used?"

'SUBTITLE LAND OF THE DEAD'

# zil: 1actions.zil:1058  <ROUTINE LLD-ROOM (RARG)>
@ZG.routine('LLD-ROOM')
def LLD_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are outside a large gateway, on which is inscribed\n\n  Abandon every hope\nall ye who enter here!\n\nThe gate is open; through it you can see a desolation, with a pile of\nmangled bodies in one corner. Thousands of voices, lamenting some\nhideous fate, can be heard.', CR)
        if ((not ZG.LLD_FLAG) and (not ZG.DEAD)):
            return TELL('The way through the gate is barred by evil spirits, who jeer at your\nattempts to pass.', CR)
        else:
            return False
    elif (RARG == ZG.M_BEG):
        if VERB_p('EXORCISE'):
            if (not ZG.LLD_FLAG):
                if (IN_p(ZG.BELL, ZG.WINNER) and IN_p(ZG.BOOK, ZG.WINNER) and IN_p(ZG.CANDLES, ZG.WINNER)):
                    return TELL('You must perform the ceremony.', CR)
                else:
                    return TELL("You aren't equipped for an exorcism.", CR)
            else:
                return False
        elif ((not ZG.LLD_FLAG) and VERB_p('RING') and (ZG.PRSO == ZG.BELL)):
            ZG.XB = True
            ZG.REMOVE_CAREFULLY(ZG.BELL)
            ZG.THIS_IS_IT(ZG.HOT_BELL)
            MOVE(ZG.HOT_BELL, ZG.HERE)
            TELL('The bell suddenly becomes red hot and falls to the ground. The\nwraiths, as if paralyzed, stop their jeering and slowly turn to face\nyou. On their ashen faces, the expression of a long-forgotten terror\ntakes shape.', CR)
            if IN_p(ZG.CANDLES, ZG.WINNER):
                TELL('In your confusion, the candles drop to the ground (and they are out).', CR)
                MOVE(ZG.CANDLES, ZG.HERE)
                FCLEAR(ZG.CANDLES, Flag('ONBIT'))
                ZG.DISABLE(ZG.INT(ZG.I_CANDLES))
            ENABLE(ZG.QUEUE(ZG.I_XB, 6))
            return ENABLE(ZG.QUEUE(ZG.I_XBH, 20))
        elif (ZG.XC and VERB_p('READ') and (ZG.PRSO == ZG.BOOK) and (not ZG.LLD_FLAG)):
            TELL('Each word of the prayer reverberates through the hall in a deafening\nconfusion. As the last word fades, a voice, loud and commanding,\nspeaks: "Begone, fiends!" A heart-stopping scream fills the cavern,\nand the spirits, sensing a greater power, flee through the walls.', CR)
            ZG.REMOVE_CAREFULLY(ZG.GHOSTS)
            ZG.LLD_FLAG = True
            return ZG.DISABLE(ZG.INT(ZG.I_XC))
        else:
            return False
    elif (RARG == ZG.M_END):
        if (ZG.XB and IN_p(ZG.CANDLES, ZG.WINNER) and FSET_p(ZG.CANDLES, Flag('ONBIT')) and (not ZG.XC)):
            ZG.XC = True
            TELL('The flames flicker wildly and appear to dance. The earth beneath\nyour feet trembles, and your legs nearly buckle beneath you.\nThe spirits cower at your unearthly power.', CR)
            ZG.DISABLE(ZG.INT(ZG.I_XB))
            return ENABLE(ZG.QUEUE(ZG.I_XC, 3))
        else:
            return False
    else:
        return False

# zil: 1actions.zil:1127  <GLOBAL XB>
# GLOBAL (state) XB = False  ->  ZilGlobal.py

# zil: 1actions.zil:1129  <GLOBAL XC>
# GLOBAL (state) XC = False  ->  ZilGlobal.py

# zil: 1actions.zil:1131  <ROUTINE I-XB ()>
@ZG.routine('I-XB')
def I_XB():
    (ZG.XC or ((ZG.HERE == ZG.ENTRANCE_TO_HADES) and TELL('The tension of this ceremony is broken, and the wraiths, amused but\nshaken at your clumsy attempt, resume their hideous jeering.', CR)))
    ZG.XB = False
    return ZG.XB

# zil: 1actions.zil:1139  <ROUTINE I-XC ()>
@ZG.routine('I-XC')
def I_XC():
    ZG.XC = False
    return ZG.I_XB()

# zil: 1actions.zil:1143  <ROUTINE I-XBH ()>
@ZG.routine('I-XBH')
def I_XBH():
    ZG.REMOVE_CAREFULLY(ZG.HOT_BELL)
    MOVE(ZG.BELL, ZG.ENTRANCE_TO_HADES)
    if (ZG.HERE == ZG.ENTRANCE_TO_HADES):
        return TELL('The bell appears to have cooled down.', CR)
    else:
        return False

'SUBTITLE FLOOD CONTROL DAM #3'

# zil: 1actions.zil:1153  <GLOBAL GATE-FLAG>
# GLOBAL (state) GATE_FLAG = False  ->  ZilGlobal.py

# zil: 1actions.zil:1154  <GLOBAL GATES-OPEN>
# GLOBAL (state) GATES_OPEN = False  ->  ZilGlobal.py

# zil: 1actions.zil:1156  <ROUTINE DAM-ROOM-FCN (RARG)>
@ZG.routine('DAM-ROOM-FCN')
def DAM_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are standing on the top of the Flood Control Dam #3, which was\nquite a tourist attraction in times far distant. There are paths to\nthe north, south, and west, and a scramble down.', CR)
        if (ZG.LOW_TIDE and ZG.GATES_OPEN):
            TELL('The water level behind the dam is low: The sluice gates have been\nopened. Water rushes through the dam and downstream.', CR)
        elif ZG.GATES_OPEN:
            TELL('The sluice gates are open, and water rushes through the dam. The\nwater level behind the dam is still high.', CR)
        elif ZG.LOW_TIDE:
            TELL('The sluice gates are closed. The water level in the reservoir is\nquite low, but the level is rising quickly.', CR)
        else:
            TELL('The sluice gates on the dam are closed. Behind the dam, there can be\nseen a wide reservoir. Water is pouring over the top of the now\nabandoned dam.', CR)
        TELL('There is a control panel here, on which a large metal bolt is mounted.\nDirectly above the bolt is a small green plastic bubble')
        if ZG.GATE_FLAG:
            TELL(' which is\nglowing serenely')
        return TELL('.', CR)
    else:
        return False

# zil: 1actions.zil:1187  <ROUTINE BOLT-F ()>
@ZG.routine('BOLT-F')
def BOLT_F():
    if VERB_p('TURN'):
        if (ZG.PRSI == ZG.WRENCH):
            if ZG.GATE_FLAG:
                FCLEAR(ZG.RESERVOIR_SOUTH, Flag('TOUCHBIT'))
                if ZG.GATES_OPEN:
                    ZG.GATES_OPEN = False
                    FCLEAR(ZG.LOUD_ROOM, Flag('TOUCHBIT'))
                    TELL('The sluice gates close and water starts to collect behind the dam.', CR)
                    ENABLE(ZG.QUEUE(ZG.I_RFILL, 8))
                    ZG.QUEUE(ZG.I_REMPTY, 0)
                    return True
                else:
                    ZG.GATES_OPEN = True
                    TELL('The sluice gates open and water pours through the dam.', CR)
                    ENABLE(ZG.QUEUE(ZG.I_REMPTY, 8))
                    ZG.QUEUE(ZG.I_RFILL, 0)
                    return True
            else:
                return TELL("The bolt won't turn with your best effort.", CR)
        else:
            return TELL("The bolt won't turn using the ", D, ZG.PRSI, '.', CR)
    elif VERB_p('TAKE'):
        return ZG.INTEGRAL_PART()
    elif VERB_p('OIL'):
        return TELL("Hmm. It appears the tube contained glue, not oil. Turning the bolt\nwon't get any easier....", CR)
    else:
        return False

# zil: 1actions.zil:1219  <ROUTINE BUBBLE-F ()>
@ZG.routine('BUBBLE-F')
def BUBBLE_F():
    if VERB_p('TAKE'):
        return ZG.INTEGRAL_PART()
    else:
        return False

# zil: 1actions.zil:1223  <ROUTINE INTEGRAL-PART ()>
@ZG.routine('INTEGRAL-PART')
def INTEGRAL_PART():
    return TELL('It is an integral part of the control panel.', CR)

# zil: 1actions.zil:1226  <ROUTINE I-RFILL ()>
@ZG.routine('I-RFILL')
def I_RFILL():
    FSET(ZG.RESERVOIR, Flag('NONLANDBIT'))
    FCLEAR(ZG.RESERVOIR, Flag('RLANDBIT'))
    FCLEAR(ZG.DEEP_CANYON, Flag('TOUCHBIT'))
    FCLEAR(ZG.LOUD_ROOM, Flag('TOUCHBIT'))
    (IN_p(ZG.TRUNK, ZG.RESERVOIR) and FSET(ZG.TRUNK, Flag('INVISIBLE')))
    ZG.LOW_TIDE = False
    if (ZG.HERE == ZG.RESERVOIR):
        if FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
            TELL('The boat lifts gently out of the mud and is now floating on\nthe reservoir.', CR)
        else:
            ZG.JIGS_UP('You are lifted up by the rising river! You try to swim, but the\ncurrents are too strong. You come closer, closer to the awesome\nstructure of Flood Control Dam #3. The dam beckons to you.\nThe roar of the water nearly deafens you, but you remain conscious\nas you tumble over the dam toward your certain doom among the rocks\nat its base.')
    elif (ZG.HERE == ZG.DEEP_CANYON):
        TELL('A sound, like that of flowing water, starts to come from below.', CR)
    elif (ZG.HERE == ZG.LOUD_ROOM):
        TELL('All of a sudden, an alarmingly loud roaring sound fills the room.\nFilled with fear, you scramble away.', CR)
        ZG.GOTO(ZG.PICK_ONE(ZG.LOUD_RUNS))
    elif (ZG.HERE in (ZG.RESERVOIR_NORTH, ZG.RESERVOIR_SOUTH)):
        TELL('You notice that the water level has risen to the point that it\nis impossible to cross.', CR)
    return True

# zil: 1actions.zil:1261  <GLOBAL LOUD-RUNS>
# GLOBAL (state) LOUD_RUNS = LTABLE(0, ZG.DAMP_CAVE, ZG.ROUND_ROOM, ZG.DEEP_CANYON)  ->  ZilGlobal.py

# zil: 1actions.zil:1263  <ROUTINE I-REMPTY ()>
@ZG.routine('I-REMPTY')
def I_REMPTY():
    FSET(ZG.RESERVOIR, Flag('RLANDBIT'))
    FCLEAR(ZG.RESERVOIR, Flag('NONLANDBIT'))
    FCLEAR(ZG.DEEP_CANYON, Flag('TOUCHBIT'))
    FCLEAR(ZG.LOUD_ROOM, Flag('TOUCHBIT'))
    FCLEAR(ZG.TRUNK, Flag('INVISIBLE'))
    ZG.LOW_TIDE = True
    if ((ZG.HERE == ZG.RESERVOIR) and FSET_p(LOC(ZG.WINNER), Flag('VEHBIT'))):
        TELL('The water level has dropped to the point at which the boat can no\nlonger stay afloat. It sinks into the mud.', CR)
    elif (ZG.HERE == ZG.DEEP_CANYON):
        TELL('The roar of rushing water is quieter now.', CR)
    elif (ZG.HERE in (ZG.RESERVOIR_NORTH, ZG.RESERVOIR_SOUTH)):
        TELL('The water level is now quite low here and you could easily cross over\nto the other side.', CR)
    return True

# zil: 1actions.zil:1284  <GLOBAL DROWNINGS>
# GLOBAL (state) DROWNINGS = TABLE(('PURE',), 'up to your ankles.', 'up to your shin.', 'up to your knees.', 'up to your hips.', 'up to your waist.', 'up to your chest.', 'up to your neck.', 'over your head.', 'high in your lungs.')  ->  ZilGlobal.py

# zil: 1actions.zil:1295  <GLOBAL WATER-LEVEL>
# GLOBAL (state) WATER_LEVEL = 0  ->  ZilGlobal.py

GDECL(('WATER-LEVEL',), 'FIX')

# zil: 1actions.zil:1298  <ROUTINE BUTTON-F ()>
@ZG.routine('BUTTON-F')
def BUTTON_F():
    if VERB_p('READ'):
        return TELL("They're greek to you.", CR)
    elif VERB_p('PUSH'):
        if (ZG.PRSO == ZG.BLUE_BUTTON):
            if (ZG.WATER_LEVEL == 0):
                FCLEAR(ZG.LEAK, Flag('INVISIBLE'))
                TELL('There is a rumbling sound and a stream of water appears to burst\nfrom the east wall of the room (apparently, a leak has occurred in a\npipe).', CR)
                ZG.WATER_LEVEL = 1
                ENABLE(ZG.QUEUE(ZG.I_MAINT_ROOM, -1))
                return True
            else:
                return TELL('The blue button appears to be jammed.', CR)
        elif (ZG.PRSO == ZG.RED_BUTTON):
            TELL('The lights within the room ')
            if FSET_p(ZG.HERE, Flag('ONBIT')):
                FCLEAR(ZG.HERE, Flag('ONBIT'))
                return TELL('shut off.', CR)
            else:
                FSET(ZG.HERE, Flag('ONBIT'))
                return TELL('come on.', CR)
        elif (ZG.PRSO == ZG.BROWN_BUTTON):
            FCLEAR(ZG.DAM_ROOM, Flag('TOUCHBIT'))
            ZG.GATE_FLAG = False
            return TELL('Click.', CR)
        elif (ZG.PRSO == ZG.YELLOW_BUTTON):
            FCLEAR(ZG.DAM_ROOM, Flag('TOUCHBIT'))
            ZG.GATE_FLAG = True
            return TELL('Click.', CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:1332  <ROUTINE TOOL-CHEST-FCN ()>
@ZG.routine('TOOL-CHEST-FCN')
def TOOL_CHEST_FCN():
    if VERB_p('EXAMINE'):
        return TELL('The chests are all empty.', CR)
    elif VERB_p('TAKE', 'OPEN', 'PUT'):
        ZG.REMOVE_CAREFULLY(ZG.TOOL_CHEST)
        return TELL('The chests are so rusty and corroded that they crumble when you\ntouch them.', CR)
    elif VERB_p('OPEN'):
        return TELL('The chests are already open.', CR)
    else:
        return False

# zil: 1actions.zil:1343  <ROUTINE I-MAINT-ROOM ("AUX" HERE?)>
@ZG.routine('I-MAINT-ROOM')
def I_MAINT_ROOM():
    HERE_p = 0
    HERE_p = (ZG.HERE == ZG.MAINTENANCE_ROOM)
    if HERE_p:
        TELL('The water level here is now ')
        TELL(GET(ZG.DROWNINGS, (ZG.WATER_LEVEL // 2)))
        CRLF()
    ZG.WATER_LEVEL = (1 + ZG.WATER_LEVEL)
    if (not (ZG.WATER_LEVEL < 14)):
        ZG.MUNG_ROOM(ZG.MAINTENANCE_ROOM, 'The room is full of water and cannot be entered.')
        ZG.QUEUE(ZG.I_MAINT_ROOM, 0)
        if HERE_p:
            ZG.JIGS_UP("I'm afraid you have done drowned yourself.")
    elif (IN_p(ZG.WINNER, ZG.INFLATED_BOAT) and (ZG.HERE in (ZG.MAINTENANCE_ROOM, ZG.DAM_ROOM, ZG.DAM_LOBBY))):
        ZG.JIGS_UP('The rising water carries the boat over the dam, down the river, and over\nthe falls. Tsk, tsk.')
    return True

# zil: 1actions.zil:1362  <ROUTINE LEAK-FUNCTION ()>
@ZG.routine('LEAK-FUNCTION')
def LEAK_FUNCTION():
    if (ZG.WATER_LEVEL > 0):
        if (VERB_p('PUT', 'PUT-ON') and (ZG.PRSO == ZG.PUTTY)):
            return ZG.FIX_MAINT_LEAK()
        elif VERB_p('PLUG'):
            if (ZG.PRSI == ZG.PUTTY):
                return ZG.FIX_MAINT_LEAK()
            else:
                return ZG.WITH_TELL(ZG.PRSI)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:1372  <ROUTINE FIX-MAINT-LEAK ()>
@ZG.routine('FIX-MAINT-LEAK')
def FIX_MAINT_LEAK():
    ZG.WATER_LEVEL = -1
    ZG.QUEUE(ZG.I_MAINT_ROOM, 0)
    return TELL('By some miracle of Zorkian technology, you have managed to stop the\nleak in the dam.', CR)

# zil: 1actions.zil:1379  <ROUTINE PUTTY-FCN ()>
@ZG.routine('PUTTY-FCN')
def PUTTY_FCN():
    if ((VERB_p('OIL') and (ZG.PRSI == ZG.PUTTY)) or (VERB_p('PUT') and (ZG.PRSO == ZG.PUTTY))):
        return TELL("The all-purpose gunk isn't a lubricant.", CR)
    else:
        return False

# zil: 1actions.zil:1386  <ROUTINE TUBE-FUNCTION ()>
@ZG.routine('TUBE-FUNCTION')
def TUBE_FUNCTION():
    if (VERB_p('PUT') and (ZG.PRSI == ZG.TUBE)):
        return TELL('The tube refuses to accept anything.', CR)
    elif VERB_p('SQUEEZE'):
        if (FSET_p(ZG.PRSO, Flag('OPENBIT')) and IN_p(ZG.PUTTY, ZG.PRSO)):
            MOVE(ZG.PUTTY, ZG.WINNER)
            return TELL('The viscous material oozes into your hand.', CR)
        elif FSET_p(ZG.PRSO, Flag('OPENBIT')):
            return TELL('The tube is apparently empty.', CR)
        else:
            return TELL('The tube is closed.', CR)
    else:
        return False

# zil: 1actions.zil:1400  <ROUTINE DAM-FUNCTION ()>
@ZG.routine('DAM-FUNCTION')
def DAM_FUNCTION():
    if VERB_p('OPEN', 'CLOSE'):
        return TELL("Sounds reasonable, but this isn't how.", CR)
    elif VERB_p('PLUG'):
        if (ZG.PRSI == ZG.HANDS):
            return TELL('Are you the little Dutch boy, then? Sorry, this is a big dam.', CR)
        else:
            return TELL('With a ', D, ZG.PRSI, '? Do you know how big this dam is? You could only\nstop a tiny leak with that.', CR)
    else:
        return False

# zil: 1actions.zil:1412  <ROUTINE WITH-TELL (OBJ)>
@ZG.routine('WITH-TELL')
def WITH_TELL(OBJ_l):
    return TELL('With a ', D, OBJ_l, '?', CR)

# zil: 1actions.zil:1415  <ROUTINE RESERVOIR-SOUTH-FCN (RARG)>
@ZG.routine('RESERVOIR-SOUTH-FCN')
def RESERVOIR_SOUTH_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        if (ZG.LOW_TIDE and ZG.GATES_OPEN):
            TELL('You are in a long room, to the north of which was formerly a lake.\nHowever, with the water level lowered, there is merely a wide stream\nrunning through the center of the room.')
        elif ZG.GATES_OPEN:
            TELL('You are in a long room. To the north is a large lake, too deep\nto cross. You notice, however, that the water level appears to be\ndropping at a rapid rate. Before long, it might be possible to cross\nto the other side from here.')
        elif ZG.LOW_TIDE:
            TELL('You are in a long room, to the north of which is a wide area which\nwas formerly a reservoir, but now is merely a stream. You notice,\nhowever, that the level of the stream is rising quickly and that\nbefore long it will be impossible to cross here.')
        else:
            TELL('You are in a long room on the south shore of a large lake, far\ntoo deep and wide for crossing.')
        CRLF()
        return TELL('There is a path along the stream to the east or west, a steep pathway\nclimbing southwest along the edge of a chasm, and a path leading into a\ncanyon to the southeast.', CR)
    else:
        return False

# zil: 1actions.zil:1444  <ROUTINE RESERVOIR-FCN (RARG)>
@ZG.routine('RESERVOIR-FCN')
def RESERVOIR_FCN(RARG):
    if ((RARG == ZG.M_END) and (not FSET_p(LOC(ZG.WINNER), Flag('VEHBIT'))) and (not ZG.GATES_OPEN) and ZG.LOW_TIDE):
        return TELL('You notice that the water level here is rising rapidly. The currents\nare also becoming stronger. Staying here seems quite perilous!', CR)
    elif (RARG == ZG.M_LOOK):
        if ZG.LOW_TIDE:
            TELL('You are on what used to be a large lake, but which is now a large\nmud pile. There are "shores" to the north and south.')
        else:
            TELL('You are on the lake. Beaches can be seen north and south.\nUpstream a small stream enters the lake through a narrow cleft\nin the rocks. The dam can be seen downstream.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:1464  <ROUTINE RESERVOIR-NORTH-FCN (RARG)>
@ZG.routine('RESERVOIR-NORTH-FCN')
def RESERVOIR_NORTH_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        if (ZG.LOW_TIDE and ZG.GATES_OPEN):
            TELL('You are in a large cavernous room, the south of which was formerly\na lake. However, with the water level lowered, there is merely\na wide stream running through there.')
        elif ZG.GATES_OPEN:
            TELL('You are in a large cavernous area. To the south is a wide lake,\nwhose water level appears to be falling rapidly.')
        elif ZG.LOW_TIDE:
            TELL('You are in a cavernous area, to the south of which is a very wide\nstream. The level of the stream is rising rapidly, and it appears\nthat before long it will be impossible to cross to the other side.')
        else:
            TELL('You are in a large cavernous room, north of a large lake.')
        CRLF()
        return TELL('There is a slimy stairway leaving the room to the north.', CR)
    else:
        return False

'SUBTITLE WATER, WATER EVERYWHERE...'

# zil: 1actions.zil:1491  <ROUTINE BOTTLE-FUNCTION ("AUX" (E? <>))>
@ZG.routine('BOTTLE-FUNCTION')
def BOTTLE_FUNCTION():
    E_p = False
    if (VERB_p('THROW') and (ZG.PRSO == ZG.BOTTLE)):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        E_p = True
        TELL('The bottle hits the far wall and shatters.', CR)
    elif VERB_p('MUNG'):
        E_p = True
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        TELL('A brilliant maneuver destroys the bottle.', CR)
    elif VERB_p('SHAKE'):
        if (FSET_p(ZG.PRSO, Flag('OPENBIT')) and IN_p(ZG.WATER, ZG.PRSO)):
            E_p = True
    if (E_p and IN_p(ZG.WATER, ZG.PRSO)):
        TELL('The water spills to the floor and evaporates.', CR)
        ZG.REMOVE_CAREFULLY(ZG.WATER)
        return True
    elif E_p:
        return True
    else:
        return False

'SUBTITLE CYCLOPS'

# zil: 1actions.zil:1513  <GLOBAL CYCLOWRATH>
# GLOBAL (state) CYCLOWRATH = 0  ->  ZilGlobal.py

# zil: 1actions.zil:1515  <ROUTINE CYCLOPS-FCN ("AUX" COUNT)>
@ZG.routine('CYCLOPS-FCN')
def CYCLOPS_FCN():
    COUNT = 0
    COUNT = ZG.CYCLOWRATH
    if (ZG.WINNER == ZG.CYCLOPS):
        if ZG.CYCLOPS_FLAG:
            return TELL("No use talking to him. He's fast asleep.", CR)
        elif VERB_p('ODYSSEUS'):
            ZG.WINNER = ZG.ADVENTURER
            ZG.PERFORM(SYMBOL('V?ODYSSEUS'))
            return True
        else:
            return TELL('The cyclops prefers eating to making conversation.', CR)
    elif ZG.CYCLOPS_FLAG:
        if VERB_p('EXAMINE'):
            return TELL('The cyclops is sleeping like a baby, albeit a very ugly one.', CR)
        elif VERB_p('ALARM', 'KICK', 'ATTACK', 'BURN', 'MUNG'):
            TELL('The cyclops yawns and stares at the thing that woke him up.', CR)
            ZG.CYCLOPS_FLAG = False
            FSET(ZG.CYCLOPS, Flag('FIGHTBIT'))
            if (COUNT < 0):
                ZG.CYCLOWRATH = (-COUNT)
                return ZG.CYCLOWRATH
            else:
                ZG.CYCLOWRATH = COUNT
                return ZG.CYCLOWRATH
        else:
            return False
    elif VERB_p('EXAMINE'):
        return TELL('A hungry cyclops is standing at the foot of the stairs.', CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.CYCLOPS)):
        if (ZG.PRSO == ZG.LUNCH):
            if (not (COUNT < 0)):
                ZG.REMOVE_CAREFULLY(ZG.LUNCH)
                TELL('The cyclops says "Mmm Mmm. I love hot peppers! But oh, could I use\na drink. Perhaps I could drink the blood of that thing."  From the\ngleam in his eye, it could be surmised that you are "that thing".', CR)
                ZG.CYCLOWRATH = ZG.MIN(-1, (-COUNT))
            return ENABLE(ZG.QUEUE(ZG.I_CYCLOPS, -1))
        elif ((ZG.PRSO == ZG.WATER) or ((ZG.PRSO == ZG.BOTTLE) and IN_p(ZG.WATER, ZG.BOTTLE))):
            if (COUNT < 0):
                ZG.REMOVE_CAREFULLY(ZG.WATER)
                MOVE(ZG.BOTTLE, ZG.HERE)
                FSET(ZG.BOTTLE, Flag('OPENBIT'))
                FCLEAR(ZG.CYCLOPS, Flag('FIGHTBIT'))
                TELL("The cyclops takes the bottle, checks that it's open, and drinks the water.\nA moment later, he lets out a yawn that nearly blows you over, and then\nfalls fast asleep (what did you put in that drink, anyway?).", CR)
                ZG.CYCLOPS_FLAG = True
                return ZG.CYCLOPS_FLAG
            else:
                return TELL('The cyclops apparently is not thirsty and refuses your generous offer.', CR)
        elif (ZG.PRSO == ZG.GARLIC):
            return TELL('The cyclops may be hungry, but there is a limit.', CR)
        else:
            return TELL('The cyclops is not so stupid as to eat THAT!', CR)
    elif VERB_p('THROW', 'ATTACK', 'MUNG'):
        ENABLE(ZG.QUEUE(ZG.I_CYCLOPS, -1))
        if VERB_p('MUNG'):
            return TELL('"Do you think I\'m as stupid as my father was?", he says, dodging.', CR)
        else:
            TELL('The cyclops shrugs but otherwise ignores your pitiful attempt.', CR)
            if VERB_p('THROW'):
                MOVE(ZG.PRSO, ZG.HERE)
            return True
    elif VERB_p('TAKE'):
        return TELL("The cyclops doesn't take kindly to being grabbed.", CR)
    elif VERB_p('TIE'):
        return TELL('You cannot tie the cyclops, though he is fit to be tied.', CR)
    elif VERB_p('LISTEN'):
        return TELL('You can hear his stomach rumbling.', CR)
    else:
        return False

# zil: 1actions.zil:1596  <ROUTINE I-CYCLOPS ()>
@ZG.routine('I-CYCLOPS')
def I_CYCLOPS():
    if (ZG.CYCLOPS_FLAG or ZG.DEAD):
        return True
    elif (not (ZG.HERE == ZG.CYCLOPS_ROOM)):
        return ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS))
    else:
        if (ABS(ZG.CYCLOWRATH) > 5):
            ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS))
            return ZG.JIGS_UP('The cyclops, tired of all of your games and trickery, grabs you firmly.\nAs he licks his chops, he says "Mmm. Just like Mom used to make \'em."\nIt\'s nice to be appreciated.')
        else:
            if (ZG.CYCLOWRATH < 0):
                ZG.CYCLOWRATH = (ZG.CYCLOWRATH - 1)
            else:
                ZG.CYCLOWRATH = (ZG.CYCLOWRATH + 1)
            if (not ZG.CYCLOPS_FLAG):
                return TELL(NTH(ZG.CYCLOMAD, (ABS(ZG.CYCLOWRATH) - 1)), CR)
            else:
                return False

# zil: 1actions.zil:1616  <ROUTINE CYCLOPS-ROOM-FCN (RARG)>
@ZG.routine('CYCLOPS-ROOM-FCN')
def CYCLOPS_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This room has an exit on the northwest, and a staircase leading up.', CR)
        if (ZG.CYCLOPS_FLAG and (not ZG.MAGIC_FLAG)):
            return TELL('The cyclops is sleeping blissfully at the foot of the stairs.', CR)
        elif ZG.MAGIC_FLAG:
            return TELL('The east wall, previously solid, now has a cyclops-sized opening in it.', CR)
        elif (ZG.CYCLOWRATH == 0):
            return TELL('A cyclops, who looks prepared to eat horses (much less mere\nadventurers), blocks the staircase. From his state of health, and\nthe bloodstains on the walls, you gather that he is not very\nfriendly, though he likes people.', CR)
        elif (ZG.CYCLOWRATH > 0):
            return TELL("The cyclops is standing in the corner, eyeing you closely. I don't\nthink he likes you very much. He looks extremely hungry, even for a\ncyclops.", CR)
        elif (ZG.CYCLOWRATH < 0):
            return TELL('The cyclops, having eaten the hot peppers, appears to be gasping.\nHis enflamed tongue protrudes from his man-sized mouth.', CR)
        else:
            return False
    elif (RARG == ZG.M_ENTER):
        return ((ZG.CYCLOWRATH == 0) or ENABLE(ZG.INT(ZG.I_CYCLOPS)))
    else:
        return False

# zil: 1actions.zil:1644  <GLOBAL CYCLOMAD>
# GLOBAL (state) CYCLOMAD = TABLE(('PURE',), 'The cyclops seems somewhat agitated.', 'The cyclops appears to be getting more agitated.', 'The cyclops is moving about the room, looking for something.', 'The cyclops was looking for salt and pepper. No doubt they are\ncondiments for his upcoming snack.', 'The cyclops is moving toward you in an unfriendly manner.', 'You have two choices: 1. Leave  2. Become dinner.')  ->  ZilGlobal.py

'SUBTITLE LOUD LOUD LOUD'

# zil: 1actions.zil:1658  <GLOBAL LOUD-FLAG>
# GLOBAL (state) LOUD_FLAG = False  ->  ZilGlobal.py

# zil: 1actions.zil:1660  <ROUTINE LOUD-ROOM-FCN (RARG "AUX" WRD)>
@ZG.routine('LOUD-ROOM-FCN')
def LOUD_ROOM_FCN(RARG):
    WRD = 0
    if (RARG == ZG.M_LOOK):
        TELL('This is a large room with a ceiling which cannot be detected from\nthe ground. There is a narrow passage from east to west and a stone\nstairway leading upward.')
        if (ZG.LOUD_FLAG or ((not ZG.GATES_OPEN) and ZG.LOW_TIDE)):
            TELL(' The room is eerie in its quietness.')
        else:
            TELL(' The room is deafeningly loud with an\nundetermined rushing sound. The sound seems to reverberate from all\nof the walls, making it difficult even to think.')
        return CRLF()
    elif ((RARG == ZG.M_END) and ZG.GATES_OPEN and (not ZG.LOW_TIDE)):
        TELL("It is unbearably loud here, with an ear-splitting roar seeming to\ncome from all around you. There is a pounding in your head which won't\nstop. With a tremendous effort, you scramble out of the room.", CR, CR)
        ZG.GOTO(ZG.PICK_ONE(ZG.LOUD_RUNS))
        return False
    elif (RARG == ZG.M_ENTER):
        if (ZG.LOUD_FLAG or ((not ZG.GATES_OPEN) and ZG.LOW_TIDE)):
            return False
        elif (ZG.GATES_OPEN and (not ZG.LOW_TIDE)):
            return False
        else:
            ZG.V_FIRST_LOOK()
            if ZG.P_CONT:
                TELL('The rest of your commands have been lost in the noise.', CR)
                ZG.P_CONT = False
            while True:
                if (not ZG.SUPER_BRIEF):
                    CRLF()
                TELL('>')
                READ(ZG.P_INBUF, ZG.P_LEXV)
                if (GETB(ZG.P_LEXV, ZG.P_LEXWORDS) == 0):
                    TELL('I beg your pardon?', CR)
                    continue
                WRD = GET(ZG.P_LEXV, 1)
                if (WRD in (WORD('go'), WORD('walk'), WORD('run'))):
                    WRD = GET(ZG.P_LEXV, 3)
                elif (WRD == WORD('say')):
                    WRD = GET(ZG.P_LEXV, 5)
                if (WRD == WORD('save')):
                    ZG.V_SAVE()
                elif (WRD == WORD('restore')):
                    ZG.V_RESTORE()
                elif (WRD in (WORD('q'), WORD('quit'))):
                    ZG.V_QUIT()
                elif (WRD in (WORD('w'), WORD('west'))):
                    return ZG.GOTO(ZG.ROUND_ROOM)
                elif (WRD in (WORD('e'), WORD('east'))):
                    return ZG.GOTO(ZG.DAMP_CAVE)
                elif (WRD in (WORD('u'), WORD('up'))):
                    return ZG.GOTO(ZG.DEEP_CANYON)
                elif (WRD == WORD('bug')):
                    TELL("That's only your opinion.", CR)
                elif (WRD == WORD('echo')):
                    ZG.LOUD_FLAG = True
                    FCLEAR(ZG.BAR, Flag('SACREDBIT'))
                    TELL('The acoustics of the room change subtly.', CR)
                    if (not ZG.SUPER_BRIEF):
                        CRLF()
                    return True
                else:
                    ZG.V_ECHO()
    else:
        return False

# zil: 1actions.zil:1730  <ROUTINE DEEP-CANYON-F (RARG)>
@ZG.routine('DEEP-CANYON-F')
def DEEP_CANYON_F(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are on the south edge of a deep canyon. Passages lead off to the\neast, northwest and southwest. A stairway leads down.')
        if (ZG.GATES_OPEN and (not ZG.LOW_TIDE)):
            TELL(' You can hear a loud roaring sound, like that of rushing water, from\nbelow.')
        elif ((not ZG.GATES_OPEN) and ZG.LOW_TIDE):
            CRLF()
            return True
        else:
            TELL(' You can hear the sound of flowing water from below.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:1748  <GLOBAL EGG-SOLVE>
# GLOBAL (state) EGG_SOLVE = False  ->  ZilGlobal.py

'SUBTITLE A SEEDY LOOKING GENTLEMAN...'

# zil: 1actions.zil:1754  <GLOBAL THIEF-HERE>
# GLOBAL (state) THIEF_HERE = False  ->  ZilGlobal.py

# ;"I-THIEF moved to DEMONS"

'SUBTITLE THINGS THIEF MIGHT DO'

'INTERACTION WITH ADVENTURER -- RETURNS T IF THIEF FINISHED.'

# zil: 1actions.zil:1764  <ROUTINE THIEF-VS-ADVENTURER (HERE? "AUX" ROBBED? (WINNER-ROBBED? <>))>
@ZG.routine('THIEF-VS-ADVENTURER')
def THIEF_VS_ADVENTURER(HERE_p):
    ROBBED_p = 0
    WINNER_ROBBED_p = False
    if ((not ZG.DEAD) and (ZG.HERE == ZG.TREASURE_ROOM)):
        pass
    elif (not ZG.THIEF_HERE):
        if ((not ZG.DEAD) and (not HERE_p) and ZG.PROB_1(30)):
            if IN_p(ZG.STILETTO, ZG.THIEF):
                FCLEAR(ZG.THIEF, Flag('INVISIBLE'))
                TELL('Someone carrying a large bag is casually leaning against one of the\nwalls here. He does not speak, but it is clear from his aspect that\nthe bag will be taken only over his dead body.', CR)
                ZG.THIEF_HERE = True
                return True
        elif (HERE_p and FSET_p(ZG.THIEF, Flag('FIGHTBIT')) and (not ZG.WINNING_p(ZG.THIEF))):
            TELL('Your opponent, determining discretion to be the better part of\nvalor, decides to terminate this little contretemps. With a rueful\nnod of his head, he steps backward into the gloom and disappears.', CR)
            FSET(ZG.THIEF, Flag('INVISIBLE'))
            FCLEAR(ZG.THIEF, Flag('FIGHTBIT'))
            ZG.RECOVER_STILETTO()
            return True
        elif (HERE_p and FSET_p(ZG.THIEF, Flag('FIGHTBIT')) and ZG.PROB_1(90)):
            return False
        elif (HERE_p and ZG.PROB_1(30)):
            TELL('The holder of the large bag just left, looking disgusted.\nFortunately, he took nothing.', CR)
            FSET(ZG.THIEF, Flag('INVISIBLE'))
            ZG.RECOVER_STILETTO()
            return True
        elif ZG.PROB_1(70):
            return False
        elif (not ZG.DEAD):
            if ZG.ROB(ZG.HERE, ZG.THIEF, 100):
                ROBBED_p = ZG.HERE
            elif ZG.ROB(ZG.WINNER, ZG.THIEF):
                ROBBED_p = ZG.PLAYER
            ZG.THIEF_HERE = True
            if (ROBBED_p and (not HERE_p)):
                TELL('A seedy-looking individual with a large bag just wandered through\nthe room. On the way through, he quietly abstracted some valuables from ')
                if (ROBBED_p == ZG.HERE):
                    TELL('the room')
                else:
                    TELL('your possession')
                TELL(', mumbling something about\n"Doing unto others before..."', CR)
                ZG.STOLE_LIGHT_p()
            elif HERE_p:
                ZG.RECOVER_STILETTO()
                if ROBBED_p:
                    TELL('The thief just left, still carrying his large bag. You may\nnot have noticed that he ')
                    if (ROBBED_p == ZG.PLAYER):
                        TELL('robbed you blind first.')
                    else:
                        TELL('appropriated the valuables in the room.')
                    CRLF()
                    ZG.STOLE_LIGHT_p()
                else:
                    TELL('The thief, finding nothing of value, left disgusted.', CR)
                FSET(ZG.THIEF, Flag('INVISIBLE'))
                HERE_p = False
                return True
            else:
                TELL('A "lean and hungry" gentleman just wandered through, carrying a\nlarge bag. Finding nothing of value, he left disgruntled.', CR)
                return True
    else:
        if HERE_p:
            if ZG.PROB_1(30):
                if ZG.ROB(ZG.HERE, ZG.THIEF, 100):
                    ROBBED_p = ZG.HERE
                elif ZG.ROB(ZG.WINNER, ZG.THIEF):
                    ROBBED_p = ZG.PLAYER
                if ROBBED_p:
                    TELL('The thief just left, still carrying his large bag. You may\nnot have noticed that he ')
                    if (ROBBED_p == ZG.PLAYER):
                        TELL('robbed you blind first.')
                    else:
                        TELL('appropriated the valuables in the room.')
                    CRLF()
                    ZG.STOLE_LIGHT_p()
                else:
                    TELL('The thief, finding nothing of value, left disgusted.', CR)
                FSET(ZG.THIEF, Flag('INVISIBLE'))
                HERE_p = False
                ZG.RECOVER_STILETTO()
    return False

# zil: 1actions.zil:1875  <ROUTINE STOLE-LIGHT? ("AUX" OLD-LIT)>
@ZG.routine('STOLE-LIGHT?')
def STOLE_LIGHT_p():
    OLD_LIT = 0
    OLD_LIT = ZG.LIT
    ZG.LIT = ZG.LIT_p(ZG.HERE)
    if ((not ZG.LIT) and OLD_LIT):
        TELL('The thief seems to have left you in the dark.', CR)
    return True

'SNARF STILETTO IF DROPPED IT'

# ;"RECOVER-STILETTO moved to DEMONS"

'PUT HIS BOOTY IN TREASURE ROOM'

# zil: 1actions.zil:1888  <ROUTINE HACK-TREASURES ("AUX" X)>
@ZG.routine('HACK-TREASURES')
def HACK_TREASURES():
    X = 0
    ZG.RECOVER_STILETTO()
    FSET(ZG.THIEF, Flag('INVISIBLE'))
    X = FIRST_p(ZG.TREASURE_ROOM)
    while True:
        if (not X):
            return True
        else:
            FCLEAR(X, Flag('INVISIBLE'))
        X = NEXT_p(X)

# zil: 1actions.zil:1897  <ROUTINE DEPOSIT-BOOTY (RM "AUX" X N (FLG <>))>
@ZG.routine('DEPOSIT-BOOTY')
def DEPOSIT_BOOTY(RM):
    X = 0
    N_l = 0
    FLG = False
    X = FIRST_p(ZG.THIEF)
    while True:
        if (not X):
            return FLG
        N_l = NEXT_p(X)
        if (X in (ZG.STILETTO, ZG.LARGE_BAG)):
            pass
        elif (GETP(X, 'TVALUE') > 0):
            MOVE(X, RM)
            FLG = True
            if (X == ZG.EGG):
                ZG.EGG_SOLVE = True
                FSET(ZG.EGG, Flag('OPENBIT'))
        X = N_l

'TAKE ALL OF THE VALUABLES SOMEWHERE AND PUT THEM SOMEWHERE ELSE'

'MOVED TO DEMONS'

'ROB MAZE'

# zil: 1actions.zil:1917  <ROUTINE ROB-MAZE (RM "AUX" X N)>
@ZG.routine('ROB-MAZE')
def ROB_MAZE(RM):
    X = 0
    N_l = 0
    X = FIRST_p(RM)
    while True:
        if (not X):
            return False
        N_l = NEXT_p(X)
        if (FSET_p(X, Flag('TAKEBIT')) and (not FSET_p(X, Flag('INVISIBLE'))) and ZG.PROB_1(40)):
            TELL('You hear, off in the distance, someone saying "My, I wonder what\nthis fine ', D, X, ' is doing here."', CR)
            if ZG.PROB_2(60, 80):
                MOVE(X, ZG.THIEF)
                FSET(X, Flag('TOUCHBIT'))
                FSET(X, Flag('INVISIBLE'))
            return True
        X = N_l

'STEAL SOME JUNK - moved to DEMONS'

'DROP SOME JUNK - moved to DEMONS'

'ROBBER-FUNCTION -- more prosaic thiefly occupations'

# zil: 1actions.zil:1945  <GLOBAL THIEF-ENGROSSED>
# GLOBAL (state) THIEF_ENGROSSED = False  ->  ZilGlobal.py

# zil: 1actions.zil:1947  <ROUTINE ROBBER-FUNCTION ("OPTIONAL" (MODE <>) "AUX" (FLG <>) X N)>
@ZG.routine('ROBBER-FUNCTION')
def ROBBER_FUNCTION(MODE=None):
    if MODE is None:
        MODE = False
    FLG = False
    X = 0
    N_l = 0
    if VERB_p('TELL'):
        TELL('The thief is a strong, silent type.', CR)
        ZG.P_CONT = False
        return ZG.P_CONT
    elif (not MODE):
        if (VERB_p('HELLO') and (GETP(ZG.THIEF, 'LDESC') == ZG.ROBBER_U_DESC)):
            return TELL('The thief, being temporarily incapacitated, is unable to acknowledge\nyour greeting with his usual graciousness.', CR)
        elif ((ZG.PRSO == ZG.KNIFE) and VERB_p('THROW') and (not FSET_p(ZG.THIEF, Flag('FIGHTBIT')))):
            MOVE(ZG.PRSO, ZG.HERE)
            if ZG.PROB_2(10, 0):
                TELL("You evidently frightened the robber, though you didn't hit him. He\nflees")
                REMOVE(ZG.LARGE_BAG)
                X = False
                if IN_p(ZG.STILETTO, ZG.THIEF):
                    REMOVE(ZG.STILETTO)
                    X = True
                if FIRST_p(ZG.THIEF):
                    ZG.MOVE_ALL(ZG.THIEF, ZG.HERE)
                    TELL(', but the contents of his bag fall on the floor.')
                else:
                    TELL('.')
                MOVE(ZG.LARGE_BAG, ZG.THIEF)
                if X:
                    MOVE(ZG.STILETTO, ZG.THIEF)
                CRLF()
                return FSET(ZG.THIEF, Flag('INVISIBLE'))
            else:
                TELL('You missed. The thief makes no attempt to take the knife, though it\nwould be a fine addition to the collection in his bag. He does seem\nangered by your attempt.', CR)
                return FSET(ZG.THIEF, Flag('FIGHTBIT'))
        elif (VERB_p('THROW', 'GIVE') and ZG.PRSO and (not (ZG.PRSO == ZG.THIEF)) and (ZG.PRSI == ZG.THIEF)):
            if (GETP(ZG.THIEF, 'STRENGTH') < 0):
                PUTP(ZG.THIEF, 'STRENGTH', (-GETP(ZG.THIEF, 'STRENGTH')))
                ENABLE(ZG.INT(ZG.I_THIEF))
                ZG.RECOVER_STILETTO()
                PUTP(ZG.THIEF, 'LDESC', ZG.ROBBER_C_DESC)
                TELL('Your proposed victim suddenly recovers consciousness.', CR)
            MOVE(ZG.PRSO, ZG.THIEF)
            if (GETP(ZG.PRSO, 'TVALUE') > 0):
                ZG.THIEF_ENGROSSED = True
                return TELL('The thief is taken aback by your unexpected generosity, but accepts\nthe ', D, ZG.PRSO, ' and stops to admire its beauty.', CR)
            else:
                return TELL('The thief places the ', D, ZG.PRSO, ' in his bag and thanks\nyou politely.', CR)
        elif VERB_p('TAKE'):
            return TELL('Once you got him, what would you do with him?', CR)
        elif VERB_p('EXAMINE', 'LOOK-INSIDE'):
            return TELL("The thief is a slippery character with beady eyes that flit back\nand forth. He carries, along with an unmistakable arrogance, a large bag\nover his shoulder and a vicious stiletto, whose blade is aimed\nmenacingly in your direction. I'd watch out if I were you.", CR)
        elif VERB_p('LISTEN'):
            return TELL('The thief says nothing, as you have not been formally introduced.', CR)
        else:
            return False
    elif (MODE == ZG.F_BUSY_p):
        if IN_p(ZG.STILETTO, ZG.THIEF):
            return False
        elif IN_p(ZG.STILETTO, LOC(ZG.THIEF)):
            MOVE(ZG.STILETTO, ZG.THIEF)
            FSET(ZG.STILETTO, Flag('NDESCBIT'))
            if IN_p(ZG.THIEF, ZG.HERE):
                TELL('The robber, somewhat surprised at this turn of events, nimbly\nretrieves his stiletto.', CR)
            return True
        else:
            return False
    elif (MODE == ZG.F_DEAD):
        MOVE(ZG.STILETTO, ZG.HERE)
        FCLEAR(ZG.STILETTO, Flag('NDESCBIT'))
        X = ZG.DEPOSIT_BOOTY(ZG.HERE)
        if (ZG.HERE == ZG.TREASURE_ROOM):
            X = FIRST_p(ZG.HERE)
            while True:
                if (not X):
                    TELL('The chalice is now safe to take.', CR)
                    break
                elif (not (X in (ZG.CHALICE, ZG.THIEF, ZG.ADVENTURER))):
                    FCLEAR(X, Flag('INVISIBLE'))
                    if (not FLG):
                        FLG = True
                        TELL('As the thief dies, the power of his magic decreases, and his\ntreasures reappear:', CR)
                    TELL('  A ', D, X)
                    if (FIRST_p(X) and ZG.SEE_INSIDE_p(X)):
                        TELL(', with ')
                        ZG.PRINT_CONTENTS(X)
                    CRLF()
                X = NEXT_p(X)
        elif X:
            TELL('His booty remains.', CR)
        return ZG.DISABLE(ZG.INT(ZG.I_THIEF))
    elif (MODE == ZG.F_FIRST_p):
        if (ZG.THIEF_HERE and (not FSET_p(ZG.THIEF, Flag('INVISIBLE'))) and ZG.PROB_1(20)):
            FSET(ZG.THIEF, Flag('FIGHTBIT'))
            ZG.P_CONT = False
            return True
        else:
            return False
    elif (MODE == ZG.F_UNCONSCIOUS):
        ZG.DISABLE(ZG.INT(ZG.I_THIEF))
        FCLEAR(ZG.THIEF, Flag('FIGHTBIT'))
        MOVE(ZG.STILETTO, ZG.HERE)
        FCLEAR(ZG.STILETTO, Flag('NDESCBIT'))
        return PUTP(ZG.THIEF, 'LDESC', ZG.ROBBER_U_DESC)
    elif (MODE == ZG.F_CONSCIOUS):
        if (LOC(ZG.THIEF) == ZG.HERE):
            FSET(ZG.THIEF, Flag('FIGHTBIT'))
            TELL('The robber revives, briefly feigning continued unconsciousness, and,\nwhen he sees his moment, scrambles away from you.', CR)
        ENABLE(ZG.INT(ZG.I_THIEF))
        PUTP(ZG.THIEF, 'LDESC', ZG.ROBBER_C_DESC)
        return ZG.RECOVER_STILETTO()
    else:
        return False

# zil: 1actions.zil:2086  <GLOBAL ROBBER-C-DESC>
# GLOBAL (state) ROBBER_C_DESC = 'There is a suspicious-looking individual, holding a bag, leaning\nagainst one wall. He is armed with a vicious-looking stiletto.'  ->  ZilGlobal.py

# zil: 1actions.zil:2090  <GLOBAL ROBBER-U-DESC>
# GLOBAL (state) ROBBER_U_DESC = 'There is a suspicious-looking individual lying unconscious on the\nground.'  ->  ZilGlobal.py

# zil: 1actions.zil:2094  <ROUTINE LARGE-BAG-F ()>
@ZG.routine('LARGE-BAG-F')
def LARGE_BAG_F():
    if VERB_p('TAKE'):
        if (GETP(ZG.THIEF, 'LDESC') == ZG.ROBBER_U_DESC):
            return TELL('Sadly for you, the robber collapsed on top of the bag. Trying to take\nit would wake him.', CR)
        else:
            return TELL('The bag will be taken over his dead body.', CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.LARGE_BAG)):
        return TELL('It would be a good trick.', CR)
    elif VERB_p('OPEN', 'CLOSE'):
        return TELL('Getting close enough would be a good trick.', CR)
    elif VERB_p('EXAMINE', 'LOOK-INSIDE'):
        return TELL("The bag is underneath the thief, so one can't say what, if anything, is\ninside.", CR)
    else:
        return False

# zil: 1actions.zil:2114  <ROUTINE MOVE-ALL (FROM TO "AUX" X N)>
@ZG.routine('MOVE-ALL')
def MOVE_ALL(FROM, TO):
    X = 0
    N_l = 0
    if (X := FIRST_p(FROM)):
        while True:
            if (not X):
                return True
            N_l = NEXT_p(X)
            FCLEAR(X, Flag('INVISIBLE'))
            MOVE(X, TO)
            X = N_l
    else:
        return False

# zil: 1actions.zil:2123  <ROUTINE CHALICE-FCN ()>
@ZG.routine('CHALICE-FCN')
def CHALICE_FCN():
    if VERB_p('TAKE'):
        if (IN_p(ZG.PRSO, ZG.TREASURE_ROOM) and IN_p(ZG.THIEF, ZG.TREASURE_ROOM) and FSET_p(ZG.THIEF, Flag('FIGHTBIT')) and (not FSET_p(ZG.THIEF, Flag('INVISIBLE'))) and (not (GETP(ZG.THIEF, 'LDESC') == ZG.ROBBER_U_DESC))):
            return TELL("You'd be stabbed in the back first.", CR)
        else:
            return False
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.CHALICE)):
        return TELL("You can't. It's not a very good chalice, is it?", CR)
    else:
        return ZG.DUMB_CONTAINER()

# zil: 1actions.zil:2138  <ROUTINE TREASURE-ROOM-FCN (RARG "AUX" TL)>
@ZG.routine('TREASURE-ROOM-FCN')
def TREASURE_ROOM_FCN(RARG):
    TL = 0
    if ((RARG == ZG.M_ENTER) and (GET(ZG.INT(ZG.I_THIEF), ZG.C_ENABLED_p) == 1) and (not ZG.DEAD)):
        if (not IN_p(ZG.THIEF, ZG.HERE)):
            TELL("You hear a scream of anguish as you violate the robber's hideaway.\nUsing passages unknown to you, he rushes to its defense.", CR)
            MOVE(ZG.THIEF, ZG.HERE)
        FSET(ZG.THIEF, Flag('FIGHTBIT'))
        FCLEAR(ZG.THIEF, Flag('INVISIBLE'))
        return ZG.THIEF_IN_TREASURE()
    else:
        return False

# zil: 1actions.zil:2151  <ROUTINE THIEF-IN-TREASURE ("AUX" F N)>
@ZG.routine('THIEF-IN-TREASURE')
def THIEF_IN_TREASURE():
    F = 0
    N_l = 0
    F = FIRST_p(ZG.HERE)
    if (F and NEXT_p(F)):
        TELL('The thief gestures mysteriously, and the treasures in the room\nsuddenly vanish.', CR, CR)
    while True:
        if (not F):
            return True
        elif (not (F in (ZG.CHALICE, ZG.THIEF))):
            FSET(F, Flag('INVISIBLE'))
        F = NEXT_p(F)

# zil: 1actions.zil:2163  <ROUTINE FRONT-DOOR-FCN ()>
@ZG.routine('FRONT-DOOR-FCN')
def FRONT_DOOR_FCN():
    if VERB_p('OPEN'):
        return TELL('The door cannot be opened.', CR)
    elif VERB_p('BURN'):
        return TELL('You cannot burn this door.', CR)
    elif VERB_p('MUNG'):
        return TELL("You can't seem to damage the door.", CR)
    elif VERB_p('LOOK-BEHIND'):
        return TELL("It won't open.", CR)
    else:
        return False

'SUBTITLE RANDOM FUNCTIONS'

# zil: 1actions.zil:2178  <ROUTINE BODY-FUNCTION ()>
@ZG.routine('BODY-FUNCTION')
def BODY_FUNCTION():
    if VERB_p('TAKE'):
        return TELL('A force keeps you from taking the bodies.', CR)
    elif VERB_p('MUNG', 'BURN'):
        return ZG.JIGS_UP('The voice of the guardian of the dungeon booms out from the darkness,\n"Your disrespect costs you your life!" and places your head on a sharp\npole.')
    else:
        return False

# zil: 1actions.zil:2187  <ROUTINE BLACK-BOOK ()>
@ZG.routine('BLACK-BOOK')
def BLACK_BOOK():
    if VERB_p('OPEN'):
        return TELL('The book is already open to page 569.', CR)
    elif VERB_p('CLOSE'):
        return TELL('As hard as you try, the book cannot be closed.', CR)
    elif (VERB_p('TURN') or (VERB_p('READ-PAGE') and (ZG.PRSI == ZG.INTNUM) and (not (ZG.P_NUMBER == 569)))):
        return TELL('Beside page 569, there is only one other page with any legible printing on\nit. Most of it is unreadable, but the subject seems to be the banishment of\nevil. Apparently, certain noises, lights, and prayers are efficacious in this\nregard.', CR)
    elif VERB_p('BURN'):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        return ZG.JIGS_UP('A booming voice says "Wrong, cretin!" and you notice that you have\nturned into a pile of dust. How, I can\'t imagine.')
    else:
        return False

# zil: 1actions.zil:2207  <ROUTINE PAINTING-FCN ()>
@ZG.routine('PAINTING-FCN')
def PAINTING_FCN():
    if VERB_p('MUNG'):
        PUTP(ZG.PRSO, 'TVALUE', 0)
        PUTP(ZG.PRSO, 'LDESC', 'There is a worthless piece of canvas here.')
        return TELL("Congratulations! Unlike the other vandals, who merely stole the\nartist's masterpieces, you have destroyed one.", CR)
    else:
        return False

'SUBTITLE LET THERE BE LIGHT SOURCES'

# zil: 1actions.zil:2220  <GLOBAL LAMP-TABLE>
# GLOBAL (state) LAMP_TABLE = TABLE(('PURE',), 100, 'The lamp appears a bit dimmer.', 70, 'The lamp is definitely dimmer now.', 15, 'The lamp is nearly out.', 0)  ->  ZilGlobal.py

# zil: 1actions.zil:2230  <ROUTINE LANTERN ()>
@ZG.routine('LANTERN')
def LANTERN():
    if VERB_p('THROW'):
        TELL('The lamp has smashed into the floor, and the light has gone out.', CR)
        ZG.DISABLE(ZG.INT(ZG.I_LANTERN))
        ZG.REMOVE_CAREFULLY(ZG.LAMP)
        return MOVE(ZG.BROKEN_LAMP, ZG.HERE)
    elif VERB_p('LAMP-ON'):
        if FSET_p(ZG.LAMP, Flag('RMUNGBIT')):
            return TELL("A burned-out lamp won't light.", CR)
        else:
            ENABLE(ZG.INT(ZG.I_LANTERN))
            return False
    elif VERB_p('LAMP-OFF'):
        if FSET_p(ZG.LAMP, Flag('RMUNGBIT')):
            return TELL('The lamp has already burned out.', CR)
        else:
            ZG.DISABLE(ZG.INT(ZG.I_LANTERN))
            return False
    elif VERB_p('EXAMINE'):
        TELL('The lamp ')
        if FSET_p(ZG.LAMP, Flag('RMUNGBIT')):
            TELL('has burned out.')
        elif FSET_p(ZG.LAMP, Flag('ONBIT')):
            TELL('is on.')
        else:
            TELL('is turned off.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:2259  <ROUTINE MAILBOX-F ()>
@ZG.routine('MAILBOX-F')
def MAILBOX_F():
    if (VERB_p('TAKE') and (ZG.PRSO == ZG.MAILBOX)):
        return TELL('It is securely anchored.', CR)
    else:
        return False

# zil: 1actions.zil:2263  <GLOBAL MATCH-COUNT>
# GLOBAL (state) MATCH_COUNT = 6  ->  ZilGlobal.py

# zil: 1actions.zil:2265  <ROUTINE MATCH-FUNCTION ("AUX" CNT)>
@ZG.routine('MATCH-FUNCTION')
def MATCH_FUNCTION():
    CNT = 0
    if (VERB_p('LAMP-ON', 'BURN') and (ZG.PRSO == ZG.MATCH)):
        if (ZG.MATCH_COUNT > 0):
            ZG.MATCH_COUNT = (ZG.MATCH_COUNT - 1)
        if (not (ZG.MATCH_COUNT > 0)):
            return TELL("I'm afraid that you have run out of matches.", CR)
        elif (ZG.HERE in (ZG.LOWER_SHAFT, ZG.TIMBER_ROOM)):
            return TELL('This room is drafty, and the match goes out instantly.', CR)
        else:
            FSET(ZG.MATCH, Flag('FLAMEBIT'))
            FSET(ZG.MATCH, Flag('ONBIT'))
            ENABLE(ZG.QUEUE(ZG.I_MATCH, 2))
            TELL('One of the matches starts to burn.', CR)
            if (not ZG.LIT):
                ZG.LIT = True
                ZG.V_LOOK()
            return True
    elif (VERB_p('LAMP-OFF') and FSET_p(ZG.MATCH, Flag('FLAMEBIT'))):
        TELL('The match is out.', CR)
        FCLEAR(ZG.MATCH, Flag('FLAMEBIT'))
        FCLEAR(ZG.MATCH, Flag('ONBIT'))
        ZG.LIT = ZG.LIT_p(ZG.HERE)
        if (not ZG.LIT):
            TELL("It's pitch black in here!", CR)
        ZG.QUEUE(ZG.I_MATCH, 0)
        return True
    elif VERB_p('COUNT', 'OPEN'):
        TELL('You have ')
        CNT = (ZG.MATCH_COUNT - 1)
        if (not (CNT > 0)):
            TELL('no')
        else:
            TELL(N, CNT)
        TELL(' match')
        if (not (CNT == 1)):
            TELL('es.')
        else:
            TELL('.')
        return CRLF()
    elif VERB_p('EXAMINE'):
        if FSET_p(ZG.MATCH, Flag('ONBIT')):
            TELL('The match is burning.')
        else:
            TELL("The matchbook isn't very interesting, except for what's written on it.")
        return CRLF()
    else:
        return False

# zil: 1actions.zil:2308  <ROUTINE I-MATCH ()>
@ZG.routine('I-MATCH')
def I_MATCH():
    TELL('The match has gone out.', CR)
    FCLEAR(ZG.MATCH, Flag('FLAMEBIT'))
    FCLEAR(ZG.MATCH, Flag('ONBIT'))
    ZG.LIT = ZG.LIT_p(ZG.HERE)
    return True

# zil: 1actions.zil:2315  <ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))>
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

# zil: 1actions.zil:2321  <ROUTINE I-CANDLES ("AUX" TICK (TBL <VALUE CANDLE-TABLE>))>
@ZG.routine('I-CANDLES')
def I_CANDLES():
    TICK = 0
    TBL = VALUE(ZG.CANDLE_TABLE)
    FSET(ZG.CANDLES, Flag('TOUCHBIT'))
    ENABLE(ZG.QUEUE(ZG.I_CANDLES, (TICK := GET(TBL, 0))))
    ZG.LIGHT_INT(ZG.CANDLES, TBL, TICK)
    if (not (TICK == 0)):
        ZG.CANDLE_TABLE = REST(TBL, 4)
        return ZG.CANDLE_TABLE
    else:
        return False

# zil: 1actions.zil:2328  <ROUTINE LIGHT-INT (OBJ TBL TICK)>
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

# zil: 1actions.zil:2339  <ROUTINE MIN (N1 N2)>
@ZG.routine('MIN')
def MIN(N1, N2):
    if (N1 < N2):
        return N1
    else:
        return N2

# zil: 1actions.zil:2343  <ROUTINE CANDLES-FCN ()>
@ZG.routine('CANDLES-FCN')
def CANDLES_FCN():
    if (not FSET_p(ZG.CANDLES, Flag('TOUCHBIT'))):
        ENABLE(ZG.INT(ZG.I_CANDLES))
    if (ZG.CANDLES == ZG.PRSI):
        return False
    else:
        if VERB_p('LAMP-ON', 'BURN'):
            if FSET_p(ZG.CANDLES, Flag('RMUNGBIT')):
                return TELL("Alas, there's not much left of the candles. Certainly not enough to\nburn.", CR)
            elif (not ZG.PRSI):
                if FSET_p(ZG.MATCH, Flag('FLAMEBIT')):
                    TELL('(with the match)', CR)
                    ZG.PERFORM(SYMBOL('V?LAMP-ON'), ZG.CANDLES, ZG.MATCH)
                    return True
                else:
                    TELL('You should say what to light them with.', CR)
                    return 2
            elif ((ZG.PRSI == ZG.MATCH) and FSET_p(ZG.MATCH, Flag('ONBIT'))):
                TELL('The candles are ')
                if FSET_p(ZG.CANDLES, Flag('ONBIT')):
                    return TELL('already lit.', CR)
                else:
                    FSET(ZG.CANDLES, Flag('ONBIT'))
                    TELL('lit.', CR)
                    return ENABLE(ZG.INT(ZG.I_CANDLES))
            elif (ZG.PRSI == ZG.TORCH):
                if FSET_p(ZG.CANDLES, Flag('ONBIT')):
                    return TELL('You realize, just in time, that the candles are already lighted.', CR)
                else:
                    TELL('The heat from the torch is so intense that the candles are vaporized.', CR)
                    return ZG.REMOVE_CAREFULLY(ZG.CANDLES)
            else:
                return TELL("You have to light them with something that's burning, you know.", CR)
        elif VERB_p('COUNT'):
            return TELL("Let's see, how many objects in a pair? Don't tell me, I'll get it.", CR)
        elif VERB_p('LAMP-OFF'):
            ZG.DISABLE(ZG.INT(ZG.I_CANDLES))
            if FSET_p(ZG.CANDLES, Flag('ONBIT')):
                TELL('The flame is extinguished.')
                FCLEAR(ZG.CANDLES, Flag('ONBIT'))
                FSET(ZG.CANDLES, Flag('TOUCHBIT'))
                ZG.LIT = ZG.LIT_p(ZG.HERE)
                if (not ZG.LIT):
                    TELL(" It's really dark in here....")
                CRLF()
                return True
            else:
                return TELL('The candles are not lighted.', CR)
        elif (VERB_p('PUT') and FSET_p(ZG.PRSI, Flag('BURNBIT'))):
            return TELL("That wouldn't be smart.", CR)
        elif VERB_p('EXAMINE'):
            TELL('The candles are ')
            if FSET_p(ZG.CANDLES, Flag('ONBIT')):
                TELL('burning.')
            else:
                TELL('out.')
            return CRLF()
        else:
            return False

# zil: 1actions.zil:2406  <GLOBAL CANDLE-TABLE>
# GLOBAL (state) CANDLE_TABLE = TABLE(('PURE',), 20, 'The candles grow shorter.', 10, 'The candles are becoming quite short.', 5, "The candles won't last long now.", 0)  ->  ZilGlobal.py

# zil: 1actions.zil:2416  <ROUTINE CAVE2-ROOM (RARG)>
@ZG.routine('CAVE2-ROOM')
def CAVE2_ROOM(RARG):
    if (RARG == ZG.M_END):
        if (IN_p(ZG.CANDLES, ZG.WINNER) and ZG.PROB_2(50, 80) and FSET_p(ZG.CANDLES, Flag('ONBIT'))):
            ZG.DISABLE(ZG.INT(ZG.I_CANDLES))
            FCLEAR(ZG.CANDLES, Flag('ONBIT'))
            TELL('A gust of wind blows out your candles!', CR)
            if (not ZG._set('LIT', ZG.LIT_p(ZG.HERE))):
                return TELL('It is now completely dark.', CR)
            else:
                return False
        else:
            return False
    else:
        return False

'SUBTITLE ASSORTED WEAPONS'

# zil: 1actions.zil:2432  <ROUTINE SWORD-FCN ("AUX" G)>
@ZG.routine('SWORD-FCN')
def SWORD_FCN():
    G = 0
    if (VERB_p('TAKE') and (ZG.WINNER == ZG.ADVENTURER)):
        ENABLE(ZG.QUEUE(ZG.I_SWORD, -1))
        return False
    elif VERB_p('EXAMINE'):
        if ((G := GETP(ZG.SWORD, 'TVALUE')) == 1):
            return TELL('Your sword is glowing with a faint blue glow.', CR)
        elif (G == 2):
            return TELL('Your sword is glowing very brightly.', CR)
        else:
            return False
    else:
        return False

'SUBTITLE COAL MINE'

# zil: 1actions.zil:2446  <ROUTINE BOOM-ROOM (RARG "AUX" (DUMMY? <>) FLAME)>
@ZG.routine('BOOM-ROOM')
def BOOM_ROOM(RARG):
    DUMMY_p = False
    FLAME = 0
    if (RARG == ZG.M_END):
        if ((RARG == ZG.M_END) and VERB_p('LAMP-ON', 'BURN') and (ZG.PRSO in (ZG.CANDLES, ZG.TORCH, ZG.MATCH))):
            DUMMY_p = True
        if ((ZG.HELD_p(ZG.CANDLES) and FSET_p(ZG.CANDLES, Flag('ONBIT'))) or (ZG.HELD_p(ZG.TORCH) and FSET_p(ZG.TORCH, Flag('ONBIT'))) or (ZG.HELD_p(ZG.MATCH) and FSET_p(ZG.MATCH, Flag('ONBIT')))):
            if DUMMY_p:
                TELL('How sad for an aspiring adventurer to light a ', D, ZG.PRSO, ' in a room which\nreeks of gas. Fortunately, there is justice in the world.', CR)
            else:
                TELL('Oh dear. It appears that the smell coming from this room was coal gas.\nI would have thought twice about carrying flaming objects in here.', CR)
            return ZG.JIGS_UP('\n      ** BOOOOOOOOOOOM **')
        else:
            return False
    else:
        return False

# zil: 1actions.zil:2469  <ROUTINE BAT-D ("OPTIONAL" FOO)>
@ZG.routine('BAT-D')
def BAT_D(FOO=None):
    if (LOC(ZG.GARLIC) in (ZG.WINNER, ZG.HERE)):
        return TELL('In the corner of the room on the ceiling is a large vampire bat who\nis obviously deranged and holding his nose.', CR)
    else:
        return TELL('A large vampire bat, hanging from the ceiling, swoops down at you!', CR)

# zil: 1actions.zil:2478  <ROUTINE BATS-ROOM (RARG)>
@ZG.routine('BATS-ROOM')
def BATS_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        return TELL('You are in a small room which has doors only to the east and south.', CR)
    elif ((RARG == ZG.M_ENTER) and (not ZG.DEAD)):
        if (not (LOC(ZG.GARLIC) in (ZG.WINNER, ZG.HERE))):
            ZG.V_LOOK()
            CRLF()
            return ZG.FLY_ME()
        else:
            return False
    else:
        return False

# zil: 1actions.zil:2488  <ROUTINE MACHINE-ROOM-FCN (RARG)>
@ZG.routine('MACHINE-ROOM-FCN')
def MACHINE_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a large, cold room whose sole exit is to the north. In one\ncorner there is a machine which is reminiscent of a clothes\ndryer. On its face is a switch which is labelled "START".\nThe switch does not appear to be manipulable by any human hand (unless the\nfingers are about 1/16 by 1/4 inch). On the front of the machine is a large\nlid, which is ')
        if FSET_p(ZG.MACHINE, Flag('OPENBIT')):
            TELL('open.')
        else:
            TELL('closed.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:2502  <ROUTINE MACHINE-F ()>
@ZG.routine('MACHINE-F')
def MACHINE_F():
    if (VERB_p('TAKE') and (ZG.PRSO == ZG.MACHINE)):
        return TELL('It is far too large to carry.', CR)
    elif VERB_p('OPEN'):
        if FSET_p(ZG.MACHINE, Flag('OPENBIT')):
            return TELL(ZG.PICK_ONE(ZG.DUMMY), CR)
        elif FIRST_p(ZG.MACHINE):
            TELL('The lid opens, revealing ')
            ZG.PRINT_CONTENTS(ZG.MACHINE)
            TELL('.', CR)
            return FSET(ZG.MACHINE, Flag('OPENBIT'))
        else:
            TELL('The lid opens.', CR)
            return FSET(ZG.MACHINE, Flag('OPENBIT'))
    elif VERB_p('CLOSE'):
        if FSET_p(ZG.MACHINE, Flag('OPENBIT')):
            TELL('The lid closes.', CR)
            FCLEAR(ZG.MACHINE, Flag('OPENBIT'))
            return True
        else:
            return TELL(ZG.PICK_ONE(ZG.DUMMY), CR)
    elif VERB_p('LAMP-ON'):
        if (not ZG.PRSI):
            return TELL("It's not clear how to turn it on with your bare hands.", CR)
        else:
            ZG.PERFORM(SYMBOL('V?TURN'), ZG.MACHINE_SWITCH, ZG.PRSI)
            return True
    else:
        return False

# zil: 1actions.zil:2531  <ROUTINE MSWITCH-FUNCTION ("AUX" O)>
@ZG.routine('MSWITCH-FUNCTION')
def MSWITCH_FUNCTION():
    O_l = 0
    if VERB_p('TURN'):
        if (ZG.PRSI == ZG.SCREWDRIVER):
            if FSET_p(ZG.MACHINE, Flag('OPENBIT')):
                return TELL("The machine doesn't seem to want to do anything.", CR)
            else:
                TELL('The machine comes to life (figuratively) with a dazzling display of\ncolored lights and bizarre noises. After a few moments, the\nexcitement abates.', CR)
                if IN_p(ZG.COAL, ZG.MACHINE):
                    ZG.REMOVE_CAREFULLY(ZG.COAL)
                    return MOVE(ZG.DIAMOND, ZG.MACHINE)
                else:
                    while True:
                        if (O_l := FIRST_p(ZG.MACHINE)):
                            ZG.REMOVE_CAREFULLY(O_l)
                        else:
                            break
                    return MOVE(ZG.GUNK, ZG.MACHINE)
        else:
            return TELL('It seems that a ', D, ZG.PRSI, " won't do.", CR)
    else:
        return False

# zil: 1actions.zil:2553  <ROUTINE GUNK-FUNCTION ()>
@ZG.routine('GUNK-FUNCTION')
def GUNK_FUNCTION():
    ZG.REMOVE_CAREFULLY(ZG.GUNK)
    return TELL('The slag was rather insubstantial, and crumbles into dust at your touch.', CR)

# zil: 1actions.zil:2558  <ROUTINE NO-OBJS (RARG "AUX" F)>
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
        if ((ZG.HERE == ZG.LOWER_SHAFT) and ZG.LIT):
            ZG.SCORE_UPD(ZG.LIGHT_SHAFT)
            ZG.LIGHT_SHAFT = 0
        return False
    else:
        return False

# zil: 1actions.zil:2573  <ROUTINE SOUTH-TEMPLE-FCN (RARG)>
@ZG.routine('SOUTH-TEMPLE-FCN')
def SOUTH_TEMPLE_FCN(RARG):
    if (RARG == ZG.M_BEG):
        ZG.COFFIN_CURE = (not IN_p(ZG.COFFIN, ZG.WINNER))
        return False
    else:
        return False

# zil: 1actions.zil:2578  <GLOBAL LIGHT-SHAFT>
# GLOBAL (state) LIGHT_SHAFT = 13  ->  ZilGlobal.py

GDECL(('LIGHT-SHAFT',), 'FIX')

'SUBTITLE OLD MAN RIVER, THAT OLD MAN RIVER...'

# zil: 1actions.zil:2585  <ROUTINE WHITE-CLIFFS-FUNCTION (RARG)>
@ZG.routine('WHITE-CLIFFS-FUNCTION')
def WHITE_CLIFFS_FUNCTION(RARG):
    if (RARG == ZG.M_END):
        if IN_p(ZG.INFLATED_BOAT, ZG.WINNER):
            ZG.DEFLATE = False
            return ZG.DEFLATE
        else:
            ZG.DEFLATE = True
            return ZG.DEFLATE
    else:
        return False

# zil: 1actions.zil:2592  <ROUTINE SCEPTRE-FUNCTION ()>
@ZG.routine('SCEPTRE-FUNCTION')
def SCEPTRE_FUNCTION():
    if VERB_p('WAVE', 'RAISE'):
        if ((ZG.HERE == ZG.ARAGAIN_FALLS) or (ZG.HERE == ZG.END_OF_RAINBOW)):
            if (not ZG.RAINBOW_FLAG):
                FCLEAR(ZG.POT_OF_GOLD, Flag('INVISIBLE'))
                TELL('Suddenly, the rainbow appears to become solid and, I venture,\nwalkable (I think the giveaway was the stairs and bannister).', CR)
                if ((ZG.HERE == ZG.END_OF_RAINBOW) and IN_p(ZG.POT_OF_GOLD, ZG.END_OF_RAINBOW)):
                    TELL('A shimmering pot of gold appears at the end of the rainbow.', CR)
                ZG.RAINBOW_FLAG = True
                return ZG.RAINBOW_FLAG
            else:
                ZG.ROB(ZG.ON_RAINBOW, ZG.WALL)
                TELL('The rainbow seems to have become somewhat run-of-the-mill.', CR)
                ZG.RAINBOW_FLAG = False
                return True
        elif (ZG.HERE == ZG.ON_RAINBOW):
            ZG.RAINBOW_FLAG = False
            return ZG.JIGS_UP('The structural integrity of the rainbow is severely compromised,\nleaving you hanging in midair, supported only by water vapor. Bye.')
        else:
            return TELL('A dazzling display of color briefly emanates from the sceptre.', CR)
    else:
        return False

# zil: 1actions.zil:2621  <ROUTINE FALLS-ROOM (RARG)>
@ZG.routine('FALLS-ROOM')
def FALLS_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are at the top of Aragain Falls, an enormous waterfall with a\ndrop of about 450 feet. The only path here is on the north end.', CR)
        if ZG.RAINBOW_FLAG:
            TELL('A solid rainbow spans the falls.')
        else:
            TELL('A beautiful rainbow can be seen over the falls and to the west.')
        return CRLF()
    else:
        return False

# zil: 1actions.zil:2634  <ROUTINE RAINBOW-FCN ()>
@ZG.routine('RAINBOW-FCN')
def RAINBOW_FCN():
    if VERB_p('CROSS', 'THROUGH'):
        if (ZG.HERE == ZG.CANYON_VIEW):
            TELL('From here?!?', CR)
            return True
        if ZG.RAINBOW_FLAG:
            if (ZG.HERE == ZG.ARAGAIN_FALLS):
                return ZG.GOTO(ZG.END_OF_RAINBOW)
            elif (ZG.HERE == ZG.END_OF_RAINBOW):
                return ZG.GOTO(ZG.ARAGAIN_FALLS)
            else:
                return TELL("You'll have to say which way...", CR)
        else:
            return TELL('Can you walk on water vapor?', CR)
    elif VERB_p('LOOK-UNDER'):
        return TELL('The Frigid River flows under the rainbow.', CR)
    else:
        return False

# zil: 1actions.zil:2652  <ROUTINE DBOAT-FUNCTION ("AUX")>
@ZG.routine('DBOAT-FUNCTION')
def DBOAT_FUNCTION():
    if (VERB_p('PUT', 'PUT-ON') and (ZG.PRSO == ZG.PUTTY)):
        return ZG.FIX_BOAT()
    elif VERB_p('INFLATE', 'FILL'):
        return TELL('No chance. Some moron punctured it.', CR)
    elif VERB_p('PLUG'):
        if (ZG.PRSI == ZG.PUTTY):
            return ZG.FIX_BOAT()
        else:
            return ZG.WITH_TELL(ZG.PRSI)
    else:
        return False

# zil: 1actions.zil:2664  <ROUTINE FIX-BOAT ()>
@ZG.routine('FIX-BOAT')
def FIX_BOAT():
    TELL('Well done. The boat is repaired.', CR)
    MOVE(ZG.INFLATABLE_BOAT, LOC(ZG.PUNCTURED_BOAT))
    return ZG.REMOVE_CAREFULLY(ZG.PUNCTURED_BOAT)

# zil: 1actions.zil:2669  <ROUTINE RIVER-FUNCTION ()>
@ZG.routine('RIVER-FUNCTION')
def RIVER_FUNCTION():
    if VERB_p('PUT'):
        if (ZG.PRSI == ZG.RIVER):
            if (ZG.PRSO == ZG.ME):
                return ZG.JIGS_UP('You splash around for a while, fighting the current, then you drown.')
            elif (ZG.PRSO == ZG.INFLATED_BOAT):
                return TELL('You should get in the boat then launch it.', CR)
            elif FSET_p(ZG.PRSO, Flag('BURNBIT')):
                ZG.REMOVE_CAREFULLY(ZG.PRSO)
                return TELL('The ', D, ZG.PRSO, ' floats for a moment, then sinks.', CR)
            else:
                ZG.REMOVE_CAREFULLY(ZG.PRSO)
                return TELL('The ', D, ZG.PRSO, ' splashes into the water and is gone forever.', CR)
        else:
            return False
    elif VERB_p('LEAP', 'THROUGH'):
        return TELL('A look before leaping reveals that the river is wide and dangerous,\nwith swift currents and large, half-hidden rocks. You decide to forgo your\nswim.', CR)
    else:
        return False

# zil: 1actions.zil:2692  <GLOBAL RIVER-SPEEDS>
# GLOBAL (state) RIVER_SPEEDS = LTABLE(('PURE',), ZG.RIVER_1, 4, ZG.RIVER_2, 4, ZG.RIVER_3, 3, ZG.RIVER_4, 2, ZG.RIVER_5, 1)  ->  ZilGlobal.py

# zil: 1actions.zil:2695  <GLOBAL RIVER-NEXT>
# GLOBAL (state) RIVER_NEXT = LTABLE(('PURE',), ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3, ZG.RIVER_4, ZG.RIVER_5)  ->  ZilGlobal.py

# zil: 1actions.zil:2698  <GLOBAL RIVER-LAUNCH>
# GLOBAL (state) RIVER_LAUNCH = LTABLE(('PURE',), ZG.DAM_BASE, ZG.RIVER_1, ZG.WHITE_CLIFFS_NORTH, ZG.RIVER_3, ZG.WHITE_CLIFFS_SOUTH, ZG.RIVER_4, ZG.SHORE, ZG.RIVER_5, ZG.SANDY_BEACH, ZG.RIVER_4, ZG.RESERVOIR_SOUTH, ZG.RESERVOIR, ZG.RESERVOIR_NORTH, ZG.RESERVOIR, ZG.STREAM_VIEW, ZG.IN_STREAM)  ->  ZilGlobal.py

# zil: 1actions.zil:2708  <ROUTINE I-RIVER ("AUX" RM)>
@ZG.routine('I-RIVER')
def I_RIVER():
    RM = 0
    if ((not (ZG.HERE in (ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3))) and (not (ZG.HERE in (ZG.RIVER_4, ZG.RIVER_5)))):
        return ZG.DISABLE(ZG.INT(ZG.I_RIVER))
    elif (RM := ZG.LKP(ZG.HERE, ZG.RIVER_NEXT)):
        TELL('The flow of the river carries you downstream.', CR, CR)
        ZG.GOTO(RM)
        return ENABLE(ZG.QUEUE(ZG.I_RIVER, ZG.LKP(ZG.HERE, ZG.RIVER_SPEEDS)))
    else:
        return ZG.JIGS_UP("Unfortunately, the magic boat doesn't provide protection from\nthe rocks and boulders one meets at the bottom of waterfalls.\nIncluding this one.")

# zil: 1actions.zil:2722  <ROUTINE RBOAT-FUNCTION ("OPTIONAL" (RARG <>) "AUX" TMP)>
@ZG.routine('RBOAT-FUNCTION')
def RBOAT_FUNCTION(RARG=None):
    if RARG is None:
        RARG = False
    TMP = 0
    if (RARG in (ZG.M_ENTER, ZG.M_END, ZG.M_LOOK)):
        return False
    elif (RARG == ZG.M_BEG):
        if VERB_p('WALK'):
            if (ZG.PRSO in ('LAND', 'EAST', 'WEST')):
                return False
            elif ((ZG.HERE == ZG.RESERVOIR) and (ZG.PRSO in ('NORTH', 'SOUTH'))):
                return False
            elif ((ZG.HERE == ZG.IN_STREAM) and (ZG.PRSO == 'SOUTH')):
                return False
            else:
                TELL("Read the label for the boat's instructions.", CR)
                return True
        elif VERB_p('LAUNCH'):
            if ((ZG.HERE in (ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3)) or (ZG.HERE in (ZG.RIVER_4, ZG.RESERVOIR, ZG.IN_STREAM))):
                TELL('You are on the ')
                if (ZG.HERE == ZG.RESERVOIR):
                    TELL('reservoir')
                elif (ZG.HERE == ZG.IN_STREAM):
                    TELL('stream')
                else:
                    TELL('river')
                return TELL(', or have you forgotten?', CR)
            elif ((TMP := ZG.GO_NEXT(ZG.RIVER_LAUNCH)) == 1):
                ENABLE(ZG.QUEUE(ZG.I_RIVER, ZG.LKP(ZG.HERE, ZG.RIVER_SPEEDS)))
                return True
            elif (not (TMP == 2)):
                TELL("You can't launch it here.", CR)
                return True
            else:
                return True
        elif ((VERB_p('DROP') and FSET_p(ZG.PRSO, Flag('WEAPONBIT'))) or (VERB_p('PUT') and FSET_p(ZG.PRSO, Flag('WEAPONBIT')) and (ZG.PRSI == ZG.INFLATED_BOAT)) or (VERB_p('ATTACK', 'MUNG') and FSET_p(ZG.PRSI, Flag('WEAPONBIT')))):
            ZG.REMOVE_CAREFULLY(ZG.INFLATED_BOAT)
            MOVE(ZG.PUNCTURED_BOAT, ZG.HERE)
            ZG.ROB(ZG.INFLATED_BOAT, ZG.HERE)
            MOVE(ZG.WINNER, ZG.HERE)
            TELL('It seems that the ')
            if VERB_p('DROP', 'PUT'):
                TELL(D, ZG.PRSO)
            else:
                TELL(D, ZG.PRSI)
            TELL(" didn't agree with the boat, as evidenced\nby the loud hissing noise issuing therefrom. With a pathetic sputter, the\nboat deflates, leaving you without.", CR)
            if FSET_p(ZG.HERE, Flag('NONLANDBIT')):
                CRLF()
                if (ZG.HERE in (ZG.RESERVOIR, ZG.IN_STREAM)):
                    ZG.JIGS_UP('Another pathetic sputter, this time from you, heralds your drowning.')
                else:
                    ZG.JIGS_UP('In other words, fighting the fierce currents of the Frigid River. You\nmanage to hold your own for a bit, but then you are carried over a\nwaterfall and into some nasty rocks. Ouch!')
            return True
        elif VERB_p('LAUNCH'):
            return TELL("You're not in the boat!", CR)
        else:
            return False
    elif VERB_p('BOARD'):
        if (IN_p(ZG.SCEPTRE, ZG.WINNER) or IN_p(ZG.KNIFE, ZG.WINNER) or IN_p(ZG.SWORD, ZG.WINNER) or IN_p(ZG.RUSTY_KNIFE, ZG.WINNER) or IN_p(ZG.AXE, ZG.WINNER) or IN_p(ZG.STILETTO, ZG.WINNER)):
            TELL('Oops! Something sharp seems to have slipped and punctured the boat.\nThe boat deflates to the sounds of hissing, sputtering, and cursing.', CR)
            ZG.REMOVE_CAREFULLY(ZG.INFLATED_BOAT)
            MOVE(ZG.PUNCTURED_BOAT, ZG.HERE)
            ZG.THIS_IS_IT(ZG.PUNCTURED_BOAT)
            return True
        else:
            return False
    elif VERB_p('INFLATE', 'FILL'):
        return TELL('Inflating it further would probably burst it.', CR)
    elif VERB_p('DEFLATE'):
        if (LOC(ZG.WINNER) == ZG.INFLATED_BOAT):
            return TELL("You can't deflate the boat while you're in it.", CR)
        elif (not IN_p(ZG.INFLATED_BOAT, ZG.HERE)):
            return TELL('The boat must be on the ground to be deflated.', CR)
        else:
            TELL('The boat deflates.', CR)
            ZG.DEFLATE = True
            ZG.REMOVE_CAREFULLY(ZG.INFLATED_BOAT)
            MOVE(ZG.INFLATABLE_BOAT, ZG.HERE)
            return ZG.THIS_IS_IT(ZG.INFLATABLE_BOAT)
    else:
        return False

# zil: 1actions.zil:2817  <ROUTINE BREATHE ()>
@ZG.routine('BREATHE')
def BREATHE():
    return ZG.PERFORM(SYMBOL('V?INFLATE'), ZG.PRSO, ZG.LUNGS)

# zil: 1actions.zil:2820  <ROUTINE IBOAT-FUNCTION ()>
@ZG.routine('IBOAT-FUNCTION')
def IBOAT_FUNCTION():
    if VERB_p('INFLATE', 'FILL'):
        if (not IN_p(ZG.INFLATABLE_BOAT, ZG.HERE)):
            return TELL('The boat must be on the ground to be inflated.', CR)
        elif (ZG.PRSI == ZG.PUMP):
            TELL('The boat inflates and appears seaworthy.', CR)
            if (not FSET_p(ZG.BOAT_LABEL, Flag('TOUCHBIT'))):
                TELL('A tan label is lying inside the boat.', CR)
            ZG.DEFLATE = False
            ZG.REMOVE_CAREFULLY(ZG.INFLATABLE_BOAT)
            MOVE(ZG.INFLATED_BOAT, ZG.HERE)
            return ZG.THIS_IS_IT(ZG.INFLATED_BOAT)
        elif (ZG.PRSI == ZG.LUNGS):
            return TELL("You don't have enough lung power to inflate it.", CR)
        else:
            return TELL('With a ', D, ZG.PRSI, '? Surely you jest!', CR)
    else:
        return False

# zil: 1actions.zil:2842  <GLOBAL BUOY-FLAG>
# GLOBAL (state) BUOY_FLAG = True  ->  ZilGlobal.py

# zil: 1actions.zil:2844  <ROUTINE RIVR4-ROOM (RARG)>
@ZG.routine('RIVR4-ROOM')
def RIVR4_ROOM(RARG):
    if (RARG == ZG.M_END):
        if (IN_p(ZG.BUOY, ZG.WINNER) and ZG.BUOY_FLAG):
            TELL('You notice something funny about the feel of the buoy.', CR)
            ZG.BUOY_FLAG = False
            return ZG.BUOY_FLAG
        else:
            return False
    else:
        return False

# zil: 1actions.zil:2851  <GLOBAL BEACH-DIG>
# GLOBAL (state) BEACH_DIG = -1  ->  ZilGlobal.py

GDECL(('BEACH-DIG',), 'FIX')

# zil: 1actions.zil:2855  <ROUTINE SAND-FUNCTION ()>
@ZG.routine('SAND-FUNCTION')
def SAND_FUNCTION():
    if (VERB_p('DIG') and (ZG.PRSI == ZG.SHOVEL)):
        ZG.BEACH_DIG = (1 + ZG.BEACH_DIG)
        if (ZG.BEACH_DIG > 3):
            ZG.BEACH_DIG = -1
            (IN_p(ZG.SCARAB, ZG.HERE) and FSET(ZG.SCARAB, Flag('INVISIBLE')))
            return ZG.JIGS_UP('The hole collapses, smothering you.')
        elif (ZG.BEACH_DIG == 3):
            if FSET_p(ZG.SCARAB, Flag('INVISIBLE')):
                TELL('You can see a scarab here in the sand.', CR)
                ZG.THIS_IS_IT(ZG.SCARAB)
                return FCLEAR(ZG.SCARAB, Flag('INVISIBLE'))
            else:
                return False
        else:
            return TELL(GET(ZG.BDIGS, ZG.BEACH_DIG), CR)
    else:
        return False

# zil: 1actions.zil:2871  <GLOBAL BDIGS>
# GLOBAL (state) BDIGS = TABLE(('PURE',), 'You seem to be digging a hole here.', "The hole is getting deeper, but that's about it.", 'You are surrounded by a wall of sand on all sides.')  ->  ZilGlobal.py

"SUBTITLE TOITY POIPLE BOIDS A CHOIPIN' AN' A BOIPIN' ... "

# zil: 1actions.zil:2880  <ROUTINE TREE-ROOM (RARG "AUX" F)>
@ZG.routine('TREE-ROOM')
def TREE_ROOM(RARG):
    F = 0
    if (RARG == ZG.M_LOOK):
        TELL('You are about 10 feet above the ground nestled among some large\nbranches. The nearest branch above you is above your reach.', CR)
        if ((F := FIRST_p(ZG.PATH)) and NEXT_p(F)):
            TELL('On the ground below you can see:  ')
            ZG.PRINT_CONTENTS(ZG.PATH)
            return TELL('.', CR)
        else:
            return False
    elif (RARG == ZG.M_BEG):
        if (VERB_p('CLIMB-DOWN') and (ZG.PRSO in (ZG.TREE, ZG.ROOMS))):
            return ZG.DO_WALK('DOWN')
        elif (VERB_p('CLIMB-UP', 'CLIMB-FOO') and (ZG.PRSO == ZG.TREE)):
            return ZG.DO_WALK('UP')
        elif VERB_p('DROP'):
            if (not ZG.IDROP()):
                return True
            elif ((ZG.PRSO == ZG.NEST) and IN_p(ZG.EGG, ZG.NEST)):
                TELL('The nest falls to the ground, and the egg spills out of it, seriously\ndamaged.', CR)
                ZG.REMOVE_CAREFULLY(ZG.EGG)
                return MOVE(ZG.BROKEN_EGG, ZG.PATH)
            elif (ZG.PRSO == ZG.EGG):
                TELL('The egg falls to the ground and springs open, seriously damaged.')
                MOVE(ZG.EGG, ZG.PATH)
                ZG.BAD_EGG()
                return CRLF()
            elif (not (ZG.PRSO in (ZG.WINNER, ZG.TREE))):
                MOVE(ZG.PRSO, ZG.PATH)
                return TELL('The ', D, ZG.PRSO, ' falls to the ground.', CR)
            elif VERB_p('LEAP'):
                return ZG.JIGS_UP('That was just a bit too far down.')
            else:
                return False
        else:
            return False
    elif (RARG == ZG.M_ENTER):
        return ENABLE(ZG.QUEUE(ZG.I_FOREST_ROOM, -1))
    else:
        return False

# zil: 1actions.zil:2919  <ROUTINE EGG-OBJECT ()>
@ZG.routine('EGG-OBJECT')
def EGG_OBJECT():
    if (VERB_p('OPEN', 'MUNG') and (ZG.PRSO == ZG.EGG)):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            return TELL('The egg is already open.', CR)
        elif (not ZG.PRSI):
            return TELL('You have neither the tools nor the expertise.', CR)
        elif (ZG.PRSI == ZG.HANDS):
            return TELL('I doubt you could do that without damaging it.', CR)
        elif (FSET_p(ZG.PRSI, Flag('WEAPONBIT')) or FSET_p(ZG.PRSI, Flag('TOOLBIT')) or VERB_p('MUNG')):
            TELL('The egg is now open, but the clumsiness of your attempt has seriously\ncompromised its esthetic appeal.')
            ZG.BAD_EGG()
            return CRLF()
        elif FSET_p(ZG.PRSO, Flag('FIGHTBIT')):
            return TELL('Not to say that using the ', D, ZG.PRSI, " isn't original too...", CR)
        else:
            TELL('The concept of using a ', D, ZG.PRSI, ' is certainly original.', CR)
            return FSET(ZG.PRSO, Flag('FIGHTBIT'))
    elif VERB_p('CLIMB-ON', 'HATCH'):
        TELL('There is a noticeable crunch from beneath you, and inspection reveals\nthat the egg is lying open, badly damaged.')
        ZG.BAD_EGG()
        return CRLF()
    elif VERB_p('OPEN', 'MUNG', 'THROW'):
        if VERB_p('THROW'):
            MOVE(ZG.PRSO, ZG.HERE)
        TELL('Your rather indelicate handling of the egg has caused it some damage,\nalthough you have succeeded in opening it.')
        ZG.BAD_EGG()
        return CRLF()
    else:
        return False

# zil: 1actions.zil:2960  <ROUTINE BAD-EGG ("AUX" L)>
@ZG.routine('BAD-EGG')
def BAD_EGG():
    L = 0
    if IN_p(ZG.CANARY, ZG.EGG):
        TELL(' ', GETP(ZG.BROKEN_CANARY, 'FDESC'))
    else:
        ZG.REMOVE_CAREFULLY(ZG.BROKEN_CANARY)
    MOVE(ZG.BROKEN_EGG, LOC(ZG.EGG))
    ZG.REMOVE_CAREFULLY(ZG.EGG)
    return True

# zil: 1actions.zil:2968  <GLOBAL SING-SONG>
# GLOBAL (state) SING_SONG = False  ->  ZilGlobal.py

# zil: 1actions.zil:2970  <ROUTINE CANARY-OBJECT ()>
@ZG.routine('CANARY-OBJECT')
def CANARY_OBJECT():
    if VERB_p('WIND'):
        if (ZG.PRSO == ZG.CANARY):
            if ((not ZG.SING_SONG) and ZG.FOREST_ROOM_p()):
                TELL('The canary chirps, slightly off-key, an aria from a forgotten opera.\nFrom out of the greenery flies a lovely songbird. It perches on a\nlimb just over your head and opens its beak to sing. As it does so\na beautiful brass bauble drops from its mouth, bounces off the top of\nyour head, and lands glimmering in the grass. As the canary winds\ndown, the songbird flies away.', CR)
                ZG.SING_SONG = True
                if (ZG.HERE == ZG.UP_A_TREE):
                    _tmp1 = ZG.PATH
                else:
                    _tmp1 = ZG.HERE
                if (ZG.HERE == ZG.UP_A_TREE):
                    _tmp2 = ZG.PATH
                else:
                    _tmp2 = ZG.HERE
                return MOVE(ZG.BAUBLE, _tmp2)
            else:
                return TELL('The canary chirps blithely, if somewhat tinnily, for a short time.', CR)
        else:
            return TELL('There is an unpleasant grinding noise from inside the canary.', CR)
    else:
        return False

# zil: 1actions.zil:2992  <ROUTINE FOREST-ROOM? ()>
@ZG.routine('FOREST-ROOM?')
def FOREST_ROOM_p():
    return ((ZG.HERE in (ZG.FOREST_1, ZG.FOREST_2, ZG.FOREST_3)) or (ZG.HERE in (ZG.PATH, ZG.UP_A_TREE)))

# zil: 1actions.zil:2996  <ROUTINE I-FOREST-ROOM ()>
@ZG.routine('I-FOREST-ROOM')
def I_FOREST_ROOM():
    if (not ZG.FOREST_ROOM_p()):
        ZG.DISABLE(ZG.INT(ZG.I_FOREST_ROOM))
        return False
    elif ZG.PROB_1(15):
        return TELL('You hear in the distance the chirping of a song bird.', CR)
    else:
        return False

# zil: 1actions.zil:3004  <ROUTINE FOREST-ROOM (RARG)>
@ZG.routine('FOREST-ROOM')
def FOREST_ROOM(RARG):
    if (RARG == ZG.M_ENTER):
        return ENABLE(ZG.QUEUE(ZG.I_FOREST_ROOM, -1))
    elif (RARG == ZG.M_BEG):
        if (VERB_p('CLIMB-FOO', 'CLIMB-UP') and (ZG.PRSO == ZG.TREE)):
            return ZG.DO_WALK('UP')
        else:
            return False
    else:
        return False

# zil: 1actions.zil:3011  <ROUTINE WCLIF-OBJECT ()>
@ZG.routine('WCLIF-OBJECT')
def WCLIF_OBJECT():
    if VERB_p('CLIMB-UP', 'CLIMB-DOWN', 'CLIMB-FOO'):
        return TELL('The cliff is too steep for climbing.', CR)
    else:
        return False

# zil: 1actions.zil:3015  <ROUTINE CLIFF-OBJECT ()>
@ZG.routine('CLIFF-OBJECT')
def CLIFF_OBJECT():
    if (VERB_p('LEAP') or (VERB_p('PUT') and (ZG.PRSO == ZG.ME))):
        return TELL('That would be very unwise. Perhaps even fatal.', CR)
    elif (ZG.PRSI == ZG.CLIMBABLE_CLIFF):
        if VERB_p('PUT', 'THROW-OFF'):
            TELL('The ', D, ZG.PRSO, ' tumbles into the river and is seen no more.', CR)
            return ZG.REMOVE_CAREFULLY(ZG.PRSO)
        else:
            return False
    else:
        return False

'SUBTITLE CHUTES AND LADDERS'

# zil: 1actions.zil:3030  <ROUTINE ROPE-FUNCTION ("AUX" RLOC)>
@ZG.routine('ROPE-FUNCTION')
def ROPE_FUNCTION():
    RLOC = 0
    if (not (ZG.HERE == ZG.DOME_ROOM)):
        ZG.DOME_FLAG = False
        if VERB_p('TIE'):
            return TELL("You can't tie the rope to that.", CR)
        else:
            return False
    elif VERB_p('TIE'):
        if (ZG.PRSI == ZG.RAILING):
            if ZG.DOME_FLAG:
                return TELL('The rope is already tied to it.', CR)
            else:
                TELL('The rope drops over the side and comes within ten feet of the floor.', CR)
                ZG.DOME_FLAG = True
                FSET(ZG.ROPE, Flag('NDESCBIT'))
                RLOC = LOC(ZG.ROPE)
                if ((not RLOC) or (not IN_p(RLOC, ZG.ROOMS))):
                    MOVE(ZG.ROPE, ZG.HERE)
                return True
        else:
            return False
    elif (VERB_p('CLIMB-DOWN') and (ZG.PRSO in (ZG.ROPE, ZG.ROOMS)) and ZG.DOME_FLAG):
        return ZG.DO_WALK('DOWN')
    elif (VERB_p('TIE-UP') and (ZG.ROPE == ZG.PRSI)):
        if FSET_p(ZG.PRSO, Flag('ACTORBIT')):
            if (GETP(ZG.PRSO, 'STRENGTH') < 0):
                TELL('Your attempt to tie up the ', D, ZG.PRSO, ' awakens him.')
                return ZG.AWAKEN(ZG.PRSO)
            else:
                return TELL('The ', D, ZG.PRSO, ' struggles and you cannot tie him up.', CR)
        else:
            return TELL('Why would you tie up a ', D, ZG.PRSO, '?', CR)
    elif VERB_p('UNTIE'):
        if ZG.DOME_FLAG:
            ZG.DOME_FLAG = False
            FCLEAR(ZG.ROPE, Flag('NDESCBIT'))
            return TELL('The rope is now untied.', CR)
        else:
            return TELL('It is not tied to anything.', CR)
    elif (VERB_p('DROP') and (ZG.HERE == ZG.DOME_ROOM) and (not ZG.DOME_FLAG)):
        MOVE(ZG.ROPE, ZG.TORCH_ROOM)
        return TELL('The rope drops gently to the floor below.', CR)
    elif VERB_p('TAKE'):
        if ZG.DOME_FLAG:
            return TELL('The rope is tied to the railing.', CR)
        else:
            return False
    else:
        return False

# zil: 1actions.zil:3080  <ROUTINE UNTIE-FROM ()>
@ZG.routine('UNTIE-FROM')
def UNTIE_FROM():
    if ((ZG.PRSO == ZG.ROPE) and (ZG.DOME_FLAG and (ZG.PRSI == ZG.RAILING))):
        return ZG.PERFORM(SYMBOL('V?UNTIE'), ZG.PRSO)
    else:
        return TELL("It's not attached to that!", CR)

# zil: 1actions.zil:3086  <ROUTINE SLIDE-FUNCTION ()>
@ZG.routine('SLIDE-FUNCTION')
def SLIDE_FUNCTION():
    if (VERB_p('THROUGH', 'CLIMB-UP', 'CLIMB-DOWN', 'CLIMB-FOO') or (VERB_p('PUT') and (ZG.PRSO == ZG.ME))):
        if (ZG.HERE == ZG.CELLAR):
            ZG.DO_WALK('WEST')
            return True
        else:
            TELL('You tumble down the slide....', CR)
            return ZG.GOTO(ZG.CELLAR)
    elif VERB_p('PUT'):
        return ZG.SLIDER(ZG.PRSO)
    else:
        return False

# zil: 1actions.zil:3098  <ROUTINE SLIDER (OBJ)>
@ZG.routine('SLIDER')
def SLIDER(OBJ_l):
    if FSET_p(OBJ_l, Flag('TAKEBIT')):
        TELL('The ', D, OBJ_l, ' falls into the slide and is gone.', CR)
        if (OBJ_l == ZG.WATER):
            return ZG.REMOVE_CAREFULLY(OBJ_l)
        else:
            return MOVE(OBJ_l, ZG.CELLAR)
    else:
        return TELL(ZG.PICK_ONE(ZG.YUKS), CR)

# zil: 1actions.zil:3106  <ROUTINE SANDWICH-BAG-FCN ()>
@ZG.routine('SANDWICH-BAG-FCN')
def SANDWICH_BAG_FCN():
    if (VERB_p('SMELL') and IN_p(ZG.LUNCH, ZG.PRSO)):
        return TELL('It smells of hot peppers.', CR)
    else:
        return False

'MORE RANDOMNESS'

# zil: 1actions.zil:3113  <ROUTINE DEAD-FUNCTION ("OPTIONAL" (FOO <>) "AUX" M)>
@ZG.routine('DEAD-FUNCTION')
def DEAD_FUNCTION(FOO=None):
    if FOO is None:
        FOO = False
    M = 0
    if VERB_p('WALK'):
        if ((ZG.HERE == ZG.TIMBER_ROOM) and (ZG.PRSO == 'WEST')):
            return TELL('You cannot enter in your condition.', CR)
        else:
            return False
    elif VERB_p('BRIEF', 'VERBOSE', 'SUPER-BRIEF', 'VERSION', 'SAVE', 'RESTORE', 'QUIT', 'RESTART'):
        return False
    elif VERB_p('ATTACK', 'MUNG', 'ALARM', 'SWING'):
        return TELL('All such attacks are vain in your condition.', CR)
    elif VERB_p('OPEN', 'CLOSE', 'EAT', 'DRINK', 'INFLATE', 'DEFLATE', 'TURN', 'BURN', 'TIE', 'UNTIE', 'RUB'):
        return TELL('Even such an action is beyond your capabilities.', CR)
    elif VERB_p('WAIT'):
        return TELL("Might as well. You've got an eternity.", CR)
    elif VERB_p('LAMP-ON'):
        return TELL('You need no light to guide you.', CR)
    elif VERB_p('SCORE'):
        return TELL("You're dead! How can you think of your score?", CR)
    elif VERB_p('TAKE', 'RUB'):
        return TELL('Your hand passes through its object.', CR)
    elif VERB_p('DROP', 'THROW', 'INVENTORY'):
        return TELL('You have no possessions.', CR)
    elif VERB_p('DIAGNOSE'):
        return TELL('You are dead.', CR)
    elif VERB_p('LOOK'):
        TELL('The room looks strange and unearthly')
        if (not FIRST_p(ZG.HERE)):
            TELL('.')
        else:
            TELL(' and objects appear indistinct.')
        CRLF()
        if (not FSET_p(ZG.HERE, Flag('ONBIT'))):
            TELL('Although there is no light, the room seems dimly illuminated.', CR)
        CRLF()
        return False
    elif VERB_p('PRAY'):
        if (ZG.HERE == ZG.SOUTH_TEMPLE):
            FCLEAR(ZG.LAMP, Flag('INVISIBLE'))
            PUTP(ZG.WINNER, 'ACTION', 0)
            ZG.ALWAYS_LIT = False
            ZG.DEAD = False
            if IN_p(ZG.TROLL, ZG.TROLL_ROOM):
                ZG.TROLL_FLAG = False
            TELL('From the distance the sound of a lone trumpet is heard. The room\nbecomes very bright and you feel disembodied. In a moment, the\nbrightness fades and you find yourself rising as if from a long\nsleep, deep in the woods. In the distance you can faintly hear a\nsongbird and the sounds of the forest.', CR, CR)
            return ZG.GOTO(ZG.FOREST_1)
        else:
            return TELL('Your prayers are not heard.', CR)
    else:
        TELL("You can't even do that.", CR)
        ZG.P_CONT = False
        return 2

# ;"Pseudo-object routines"

# zil: 1actions.zil:3177  <ROUTINE LAKE-PSEUDO ()>
@ZG.routine('LAKE-PSEUDO')
def LAKE_PSEUDO():
    if ZG.LOW_TIDE:
        return TELL("There's not much lake left....", CR)
    elif VERB_p('CROSS'):
        return TELL("It's too wide to cross.", CR)
    elif VERB_p('THROUGH'):
        return TELL("You can't swim in this lake.", CR)
    else:
        return False

# zil: 1actions.zil:3185  <ROUTINE STREAM-PSEUDO ()>
@ZG.routine('STREAM-PSEUDO')
def STREAM_PSEUDO():
    if VERB_p('SWIM', 'THROUGH'):
        return TELL("You can't swim in the stream.", CR)
    elif VERB_p('CROSS'):
        return TELL('The other side is a sheer rock cliff.', CR)
    else:
        return False

# zil: 1actions.zil:3191  <ROUTINE CHASM-PSEUDO ()>
@ZG.routine('CHASM-PSEUDO')
def CHASM_PSEUDO():
    if (VERB_p('LEAP') or (VERB_p('PUT') and (ZG.PRSO == ZG.ME))):
        return TELL('You look before leaping, and realize that you would never survive.', CR)
    elif VERB_p('CROSS'):
        return TELL("It's too far to jump, and there's no bridge.", CR)
    elif (VERB_p('PUT', 'THROW-OFF') and (ZG.PRSI == ZG.PSEUDO_OBJECT)):
        TELL('The ', D, ZG.PRSO, ' drops out of sight into the chasm.', CR)
        return ZG.REMOVE_CAREFULLY(ZG.PRSO)
    else:
        return False

# zil: 1actions.zil:3203  <ROUTINE DOME-PSEUDO ()>
@ZG.routine('DOME-PSEUDO')
def DOME_PSEUDO():
    if VERB_p('KISS'):
        return TELL('No.', CR)
    else:
        return False

# zil: 1actions.zil:3207  <ROUTINE GATE-PSEUDO ()>
@ZG.routine('GATE-PSEUDO')
def GATE_PSEUDO():
    if VERB_p('THROUGH'):
        ZG.DO_WALK('IN')
        return True
    else:
        return TELL('The gate is protected by an invisible force. It makes your\nteeth ache to touch it.', CR)

# zil: 1actions.zil:3216  <ROUTINE DOOR-PSEUDO ()>
@ZG.routine('DOOR-PSEUDO')
def DOOR_PSEUDO():
    # ;"in Studio"
    if VERB_p('OPEN', 'CLOSE'):
        return TELL("The door won't budge.", CR)
    elif VERB_p('THROUGH'):
        return ZG.DO_WALK('SOUTH')
    else:
        return False

# zil: 1actions.zil:3222  <ROUTINE PAINT-PSEUDO ()>
@ZG.routine('PAINT-PSEUDO')
def PAINT_PSEUDO():
    if VERB_p('MUNG'):
        return TELL('Some paint chips away, revealing more paint.', CR)
    else:
        return False

# zil: 1actions.zil:3226  <ROUTINE GAS-PSEUDO ()>
@ZG.routine('GAS-PSEUDO')
def GAS_PSEUDO():
    if VERB_p('BREATHE'):
        return TELL('There is too much gas to blow away.', CR)
    elif VERB_p('SMELL'):
        return TELL('It smells like coal gas in here.', CR)
    else:
        return False

'SUBTITLE MELEE'

'melee actions (object functions for villains called with these'

# zil: 1actions.zil:3236  <CONSTANT F-BUSY?>
# CONSTANT (const) F_BUSY_p = 1  ->  ZilGlobal.py

# ;"busy recovering weapon?"

# zil: 1actions.zil:3237  <CONSTANT F-DEAD>
# CONSTANT (const) F_DEAD = 2  ->  ZilGlobal.py

# ;"mistah kurtz, he dead."

# zil: 1actions.zil:3238  <CONSTANT F-UNCONSCIOUS>
# CONSTANT (const) F_UNCONSCIOUS = 3  ->  ZilGlobal.py

# ;"into dreamland"

# zil: 1actions.zil:3239  <CONSTANT F-CONSCIOUS>
# CONSTANT (const) F_CONSCIOUS = 4  ->  ZilGlobal.py

# ;"rise and shine"

# zil: 1actions.zil:3240  <CONSTANT F-FIRST?>
# CONSTANT (const) F_FIRST_p = 5  ->  ZilGlobal.py

# ;"strike first?"

'blow results'

# zil: 1actions.zil:3246  <CONSTANT MISSED>
# CONSTANT (const) MISSED = 1  ->  ZilGlobal.py

# ;"attacker misses"

# zil: 1actions.zil:3247  <CONSTANT UNCONSCIOUS>
# CONSTANT (const) UNCONSCIOUS = 2  ->  ZilGlobal.py

# ;"defender unconscious"

# zil: 1actions.zil:3248  <CONSTANT KILLED>
# CONSTANT (const) KILLED = 3  ->  ZilGlobal.py

# ;"defender dead"

# zil: 1actions.zil:3249  <CONSTANT LIGHT-WOUND>
# CONSTANT (const) LIGHT_WOUND = 4  ->  ZilGlobal.py

# ;"defender lightly wounded"

# zil: 1actions.zil:3250  <CONSTANT SERIOUS-WOUND>
# CONSTANT (const) SERIOUS_WOUND = 5  ->  ZilGlobal.py

# ;"defender seriously wounded"

# zil: 1actions.zil:3251  <CONSTANT STAGGER>
# CONSTANT (const) STAGGER = 6  ->  ZilGlobal.py

# ;"defender staggered (miss turn)"

# zil: 1actions.zil:3252  <CONSTANT LOSE-WEAPON>
# CONSTANT (const) LOSE_WEAPON = 7  ->  ZilGlobal.py

# ;"defender loses weapon"

# zil: 1actions.zil:3253  <CONSTANT HESITATE>
# CONSTANT (const) HESITATE = 8  ->  ZilGlobal.py

# ;"hesitates (miss on free swing)"

# zil: 1actions.zil:3254  <CONSTANT SITTING-DUCK>
# CONSTANT (const) SITTING_DUCK = 9  ->  ZilGlobal.py

# ;"sitting duck (crunch!)"

'tables of melee results'

# zil: 1actions.zil:3258  <GLOBAL DEF1>
# GLOBAL (state) DEF1 = TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.UNCONSCIOUS, ZG.UNCONSCIOUS, ZG.KILLED, ZG.KILLED, ZG.KILLED, ZG.KILLED, ZG.KILLED)  ->  ZilGlobal.py

# zil: 1actions.zil:3265  <GLOBAL DEF2A>
# GLOBAL (state) DEF2A = TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.UNCONSCIOUS)  ->  ZilGlobal.py

# zil: 1actions.zil:3272  <GLOBAL DEF2B>
# GLOBAL (state) DEF2B = TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.UNCONSCIOUS, ZG.KILLED, ZG.KILLED, ZG.KILLED)  ->  ZilGlobal.py

# zil: 1actions.zil:3280  <GLOBAL DEF3A>
# GLOBAL (state) DEF3A = TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND)  ->  ZilGlobal.py

# zil: 1actions.zil:3287  <GLOBAL DEF3B>
# GLOBAL (state) DEF3B = TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND)  ->  ZilGlobal.py

# zil: 1actions.zil:3294  <GLOBAL DEF3C>
# GLOBAL (state) DEF3C = TABLE(('PURE',), ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND)  ->  ZilGlobal.py

# zil: 1actions.zil:3301  <GLOBAL DEF1-RES>
# GLOBAL (state) DEF1_RES = TABLE(ZG.DEF1, 0, 0)  ->  ZilGlobal.py

# zil: 1actions.zil:3306  <GLOBAL DEF2-RES>
# GLOBAL (state) DEF2_RES = TABLE(ZG.DEF2A, ZG.DEF2B, 0, 0)  ->  ZilGlobal.py

# zil: 1actions.zil:3312  <GLOBAL DEF3-RES>
# GLOBAL (state) DEF3_RES = TABLE(ZG.DEF3A, 0, ZG.DEF3B, 0, ZG.DEF3C)  ->  ZilGlobal.py

'useful constants'

# zil: 1actions.zil:3323  <CONSTANT STRENGTH-MAX>
# CONSTANT (const) STRENGTH_MAX = 7  ->  ZilGlobal.py

# zil: 1actions.zil:3324  <CONSTANT STRENGTH-MIN>
# CONSTANT (const) STRENGTH_MIN = 2  ->  ZilGlobal.py

# zil: 1actions.zil:3325  <CONSTANT CURE-WAIT>
# CONSTANT (const) CURE_WAIT = 30  ->  ZilGlobal.py

'I-FIGHT moved to DEMONS'

# zil: 1actions.zil:3331  <ROUTINE DO-FIGHT (LEN "AUX" CNT RES O OO (OUT <>))>
@ZG.routine('DO-FIGHT')
def DO_FIGHT(LEN):
    CNT = 0
    RES = 0
    O_l = 0
    OO = 0
    OUT = False
    while True:
        CNT = 0
        while True:
            CNT = (CNT + 1)
            if (CNT == LEN):
                RES = True
                break
            OO = GET(ZG.VILLAINS, CNT)
            O_l = GET(OO, ZG.V_VILLAIN)
            if (not FSET_p(O_l, Flag('FIGHTBIT'))):
                pass
            elif APPLY(GETP(O_l, 'ACTION'), ZG.F_BUSY_p):
                pass
            elif (not (RES := ZG.VILLAIN_BLOW(OO, OUT))):
                RES = False
                break
            elif (RES == ZG.UNCONSCIOUS):
                OUT = (1 + RANDOM(3))
        if RES:
            if (not OUT):
                return True
            else:
                OUT = (OUT - 1)
                if (OUT == 0):
                    return True
        else:
            return True

"takes a remark, defender, and good-guy's weapon"

# zil: 1actions.zil:3363  <ROUTINE REMARK (REMARK D W "AUX" (LEN <GET .REMARK 0>) (CNT 0) STR)>
@ZG.routine('REMARK')
def REMARK(REMARK, D_l, W):
    LEN = GET(REMARK, 0)
    CNT = 0
    STR = 0
    while True:
        if ((CNT := (CNT + 1)) > LEN):
            break
        STR = GET(REMARK, CNT)
        if (STR == ZG.F_WEP):
            PRINTD(W)
        elif (STR == ZG.F_DEF):
            PRINTD(D_l)
        else:
            PRINT(STR)
    return CRLF()

'Strength of the player is a basic value (S) adjusted by his P?STRENGTH\nproperty, which is normally 0'

# zil: 1actions.zil:3375  <ROUTINE FIGHT-STRENGTH ("OPTIONAL" (ADJUST? T) "AUX" S)>
@ZG.routine('FIGHT-STRENGTH')
def FIGHT_STRENGTH(ADJUST_p=None):
    if ADJUST_p is None:
        ADJUST_p = True
    S_l = 0
    S_l = (ZG.STRENGTH_MIN + (ZG.SCORE // (ZG.SCORE_MAX // (ZG.STRENGTH_MAX - ZG.STRENGTH_MIN))))
    if ADJUST_p:
        return (S_l + GETP(ZG.WINNER, 'STRENGTH'))
    else:
        return S_l

# zil: 1actions.zil:3383  <ROUTINE VILLAIN-STRENGTH (OO "AUX" (VILLAIN <GET .OO ,V-VILLAIN>) OD TMP)>
@ZG.routine('VILLAIN-STRENGTH')
def VILLAIN_STRENGTH(OO):
    VILLAIN = GET(OO, ZG.V_VILLAIN)
    OD = 0
    TMP = 0
    OD = GETP(VILLAIN, 'STRENGTH')
    if (not (OD < 0)):
        if ((VILLAIN == ZG.THIEF) and ZG.THIEF_ENGROSSED):
            if (OD > 2):
                OD = 2
            ZG.THIEF_ENGROSSED = False
        if (ZG.PRSI and FSET_p(ZG.PRSI, Flag('WEAPONBIT')) and (GET(OO, ZG.V_BEST) == ZG.PRSI)):
            TMP = (OD - GET(OO, ZG.V_BEST_ADV))
            if (TMP < 1):
                TMP = 1
            OD = TMP
    return OD

'find a weapon (if any) in possession of argument'

# zil: 1actions.zil:3401  <ROUTINE FIND-WEAPON (O "AUX" W)>
@ZG.routine('FIND-WEAPON')
def FIND_WEAPON(O_l):
    W = 0
    W = FIRST_p(O_l)
    if (not W):
        return False
    while True:
        if ((W in (ZG.STILETTO, ZG.AXE, ZG.SWORD)) or (W in (ZG.KNIFE, ZG.RUSTY_KNIFE))):
            return W
        elif (not (W := NEXT_p(W))):
            return False

# zil: 1actions.zil:3413  <ROUTINE VILLAIN-BLOW (OO OUT? "AUX" (VILLAIN <GET .OO ,V-VILLAIN>) (REMARKS ...
@ZG.routine('VILLAIN-BLOW')
def VILLAIN_BLOW(OO, OUT_p):
    VILLAIN = GET(OO, ZG.V_VILLAIN)
    REMARKS = GET(OO, ZG.V_MSGS)
    DWEAPON = 0
    ATT = 0
    DEF = 0
    OA = 0
    OD = 0
    TBL = 0
    RES = 0
    NWEAPON = 0
    HERO_p = 0
    FCLEAR(ZG.WINNER, Flag('STAGGERED'))
    if FSET_p(VILLAIN, Flag('STAGGERED')):
        TELL('The ', D, VILLAIN, ' slowly regains his feet.', CR)
        FCLEAR(VILLAIN, Flag('STAGGERED'))
        return True
    ATT = ZG.VILLAIN_STRENGTH(OO)
    OA = ATT
    if (not ((DEF := ZG.FIGHT_STRENGTH()) > 0)):
        return True
    OD = ZG.FIGHT_STRENGTH(False)
    DWEAPON = ZG.FIND_WEAPON(ZG.WINNER)
    if (DEF < 0):
        RES = ZG.KILLED
    else:
        if (DEF == 1):
            if (ATT > 2):
                ATT = 3
            TBL = GET(ZG.DEF1_RES, (ATT - 1))
        elif (DEF == 2):
            if (ATT > 3):
                ATT = 4
            TBL = GET(ZG.DEF2_RES, (ATT - 1))
        elif (DEF > 2):
            ATT = (ATT - DEF)
            if (ATT < -1):
                ATT = -2
            elif (ATT > 1):
                ATT = 2
            TBL = GET(ZG.DEF3_RES, (ATT + 2))
        RES = GET(TBL, (RANDOM(9) - 1))
        if OUT_p:
            if (RES == ZG.STAGGER):
                RES = ZG.HESITATE
            else:
                RES = ZG.SITTING_DUCK
        # macro: <PROB 25 <COND (.HERO? 10)(T 50)>> (gmacros.zil:115) -> expanded (副作用のある引数)
        if ((RES == ZG.STAGGER) and DWEAPON and ZG.ZPROB(25)):
            RES = ZG.LOSE_WEAPON
        ZG.REMARK(ZG.RANDOM_ELEMENT(GET(REMARKS, (RES - 1))), ZG.WINNER, DWEAPON)
    if ((RES == ZG.MISSED) or (RES == ZG.HESITATE)):
        pass
    elif (RES == ZG.UNCONSCIOUS):
        pass
    elif ((RES == ZG.KILLED) or (RES == ZG.SITTING_DUCK)):
        DEF = 0
    elif (RES == ZG.LIGHT_WOUND):
        DEF = (DEF - 1)
        if (DEF < 0):
            DEF = 0
        if (ZG.LOAD_ALLOWED > 50):
            ZG.LOAD_ALLOWED = (ZG.LOAD_ALLOWED - 10)
    elif (RES == ZG.SERIOUS_WOUND):
        DEF = (DEF - 2)
        if (DEF < 0):
            DEF = 0
        if (ZG.LOAD_ALLOWED > 50):
            ZG.LOAD_ALLOWED = (ZG.LOAD_ALLOWED - 20)
    elif (RES == ZG.STAGGER):
        FSET(ZG.WINNER, Flag('STAGGERED'))
    else:
        MOVE(DWEAPON, ZG.HERE)
        if (NWEAPON := ZG.FIND_WEAPON(ZG.WINNER)):
            TELL('Fortunately, you still have a ', D, NWEAPON, '.', CR)
    return ZG.WINNER_RESULT(DEF, RES, OD)

# zil: 1actions.zil:3476  <ROUTINE HERO-BLOW ("AUX" OO VILLAIN (OUT? <>) DWEAPON ATT DEF (CNT 0) OA OD ...
@ZG.routine('HERO-BLOW')
def HERO_BLOW():
    OO = 0
    VILLAIN = 0
    OUT_p = False
    DWEAPON = 0
    ATT = 0
    DEF = 0
    CNT = 0
    OA = 0
    OD = 0
    TBL = 0
    RES = 0
    NWEAPON = 0
    LEN = GET(ZG.VILLAINS, 0)
    while True:
        CNT = (CNT + 1)
        if (CNT == LEN):
            break
        OO = GET(ZG.VILLAINS, CNT)
        if (GET(OO, ZG.V_VILLAIN) == ZG.PRSO):
            break
    FSET(ZG.PRSO, Flag('FIGHTBIT'))
    if FSET_p(ZG.WINNER, Flag('STAGGERED')):
        TELL('You are still recovering from that last blow, so your attack is\nineffective.', CR)
        FCLEAR(ZG.WINNER, Flag('STAGGERED'))
        return True
    ATT = ZG.FIGHT_STRENGTH()
    if (ATT < 1):
        ATT = 1
    OA = ATT
    VILLAIN = GET(OO, ZG.V_VILLAIN)
    if ((OD := (DEF := ZG.VILLAIN_STRENGTH(OO))) == 0):
        if (ZG.PRSO == ZG.WINNER):
            return ZG.JIGS_UP('Well, you really did it that time. Is suicide painless?')
        TELL('Attacking the ', D, VILLAIN, ' is pointless.', CR)
        return True
    DWEAPON = ZG.FIND_WEAPON(VILLAIN)
    if ((not DWEAPON) or (DEF < 0)):
        TELL('The ')
        if (DEF < 0):
            TELL('unconscious')
        else:
            TELL('unarmed')
        TELL(' ', D, VILLAIN, ' cannot defend himself: He dies.', CR)
        RES = ZG.KILLED
    else:
        if (DEF == 1):
            if (ATT > 2):
                ATT = 3
            TBL = GET(ZG.DEF1_RES, (ATT - 1))
        elif (DEF == 2):
            if (ATT > 3):
                ATT = 4
            TBL = GET(ZG.DEF2_RES, (ATT - 1))
        elif (DEF > 2):
            ATT = (ATT - DEF)
            if (ATT < -1):
                ATT = -2
            elif (ATT > 1):
                ATT = 2
            TBL = GET(ZG.DEF3_RES, (ATT + 2))
        RES = GET(TBL, (RANDOM(9) - 1))
        if OUT_p:
            if (RES == ZG.STAGGER):
                RES = ZG.HESITATE
            else:
                RES = ZG.SITTING_DUCK
        if ((RES == ZG.STAGGER) and DWEAPON and ZG.PROB_1(25)):
            RES = ZG.LOSE_WEAPON
        ZG.REMARK(ZG.RANDOM_ELEMENT(GET(ZG.HERO_MELEE, (RES - 1))), ZG.PRSO, ZG.PRSI)
    if ((RES == ZG.MISSED) or (RES == ZG.HESITATE)):
        pass
    elif (RES == ZG.UNCONSCIOUS):
        DEF = (-DEF)
    elif ((RES == ZG.KILLED) or (RES == ZG.SITTING_DUCK)):
        DEF = 0
    elif (RES == ZG.LIGHT_WOUND):
        DEF = (DEF - 1)
        if (DEF < 0):
            DEF = 0
    elif (RES == ZG.SERIOUS_WOUND):
        DEF = (DEF - 2)
        if (DEF < 0):
            DEF = 0
    elif (RES == ZG.STAGGER):
        FSET(ZG.PRSO, Flag('STAGGERED'))
    else:
        FCLEAR(DWEAPON, Flag('NDESCBIT'))
        FSET(DWEAPON, Flag('WEAPONBIT'))
        MOVE(DWEAPON, ZG.HERE)
        ZG.THIS_IS_IT(DWEAPON)
    return ZG.VILLAIN_RESULT(ZG.PRSO, DEF, RES)

# zil: 1actions.zil:3552  <ROUTINE WINNER-RESULT (DEF RES OD)>
@ZG.routine('WINNER-RESULT')
def WINNER_RESULT(DEF, RES, OD):
    if (DEF == 0):
        _tmp1 = -10000
    else:
        _tmp1 = (DEF - OD)
    if (DEF == 0):
        _tmp2 = -10000
    else:
        _tmp2 = (DEF - OD)
    PUTP(ZG.WINNER, 'STRENGTH', _tmp2)
    if ((DEF - OD) < 0):
        ENABLE(ZG.QUEUE(ZG.I_CURE, ZG.CURE_WAIT))
    if (not (ZG.FIGHT_STRENGTH() > 0)):
        PUTP(ZG.WINNER, 'STRENGTH', (1 + (-ZG.FIGHT_STRENGTH(False))))
        ZG.JIGS_UP("It appears that that last blow was too much for you. I'm afraid you\nare dead.")
        return False
    else:
        return RES

# zil: 1actions.zil:3566  <ROUTINE VILLAIN-RESULT (VILLAIN DEF RES)>
@ZG.routine('VILLAIN-RESULT')
def VILLAIN_RESULT(VILLAIN, DEF, RES):
    PUTP(VILLAIN, 'STRENGTH', DEF)
    if (DEF == 0):
        FCLEAR(VILLAIN, Flag('FIGHTBIT'))
        TELL('Almost as soon as the ', D, VILLAIN, ' breathes his last breath, a cloud\nof sinister black fog envelops him, and when the fog lifts, the\ncarcass has disappeared.', CR)
        ZG.REMOVE_CAREFULLY(VILLAIN)
        APPLY(GETP(VILLAIN, 'ACTION'), ZG.F_DEAD)
        return RES
    elif (RES == ZG.UNCONSCIOUS):
        APPLY(GETP(VILLAIN, 'ACTION'), ZG.F_UNCONSCIOUS)
        return RES
    else:
        return RES

# zil: 1actions.zil:3584  <ROUTINE WINNING? (V "AUX" VS PS)>
@ZG.routine('WINNING?')
def WINNING_p(V):
    VS = 0
    PS = 0
    VS = GETP(V, 'STRENGTH')
    PS = (VS - ZG.FIGHT_STRENGTH())
    if (PS > 3):
        return ZG.PROB_1(90)
    elif (PS > 0):
        return ZG.PROB_1(75)
    elif (PS == 0):
        return ZG.PROB_1(50)
    elif (VS > 1):
        return ZG.PROB_1(25)
    else:
        return ZG.PROB_1(10)

# zil: 1actions.zil:3593  <ROUTINE I-CURE ("AUX" (S <GETP ,WINNER ,P?STRENGTH>))>
@ZG.routine('I-CURE')
def I_CURE():
    S_l = GETP(ZG.WINNER, 'STRENGTH')
    if (S_l > 0):
        S_l = 0
        PUTP(ZG.WINNER, 'STRENGTH', S_l)
    elif (S_l < 0):
        S_l = (S_l + 1)
        PUTP(ZG.WINNER, 'STRENGTH', S_l)
    if (S_l < 0):
        if (ZG.LOAD_ALLOWED < ZG.LOAD_MAX):
            ZG.LOAD_ALLOWED = (ZG.LOAD_ALLOWED + 10)
        return ENABLE(ZG.QUEUE(ZG.I_CURE, ZG.CURE_WAIT))
    else:
        ZG.LOAD_ALLOWED = ZG.LOAD_MAX
        return ZG.DISABLE(ZG.INT(ZG.I_CURE))

'FIGHTS'

'messages for winner'

# zil: 1actions.zil:3608  <CONSTANT F-WEP>
# CONSTANT (const) F_WEP = 0  ->  ZilGlobal.py

# ;"means print weapon name"

# zil: 1actions.zil:3609  <CONSTANT F-DEF>
# CONSTANT (const) F_DEF = 1  ->  ZilGlobal.py

# ;"means print defender name (villain, e.g.)"

# zil: 1actions.zil:3611  <GLOBAL HERO-MELEE>
# GLOBAL (state) HERO_MELEE = TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'Your ', ZG.F_WEP, ' misses the ', ZG.F_DEF, ' by an inch.'), LTABLE(('PURE',), 'A good slash, but it misses the ', ZG.F_DEF, ' by a mile.'), LTABLE(('PURE',), 'You charge, but the ', ZG.F_DEF, ' jumps nimbly aside.'), LTABLE(('PURE',), 'Clang! Crash! The ', ZG.F_DEF, ' parries.'), LTABLE(('PURE',), 'A quick stroke, but the ', ZG.F_DEF, ' is on guard.'), LTABLE(('PURE',), "A good stroke, but it's too slow; the ", ZG.F_DEF, ' dodges.')), LTABLE(('PURE',), LTABLE(('PURE',), 'Your ', ZG.F_WEP, ' crashes down, knocking the ', ZG.F_DEF, ' into dreamland.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is battered into unconsciousness.'), LTABLE(('PURE',), 'A furious exchange, and the ', ZG.F_DEF, ' is knocked out!'), LTABLE(('PURE',), 'The haft of your ', ZG.F_WEP, ' knocks out the ', ZG.F_DEF, '.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is knocked out!')), LTABLE(('PURE',), LTABLE(('PURE',), "It's curtains for the ", ZG.F_DEF, ' as your ', ZG.F_WEP, ' removes his head.'), LTABLE(('PURE',), 'The fatal blow strikes the ', ZG.F_DEF, ' square in the heart: He dies.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' takes a fatal blow and slumps to the floor dead.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is struck on the arm; blood begins to trickle down.'), LTABLE(('PURE',), 'Your ', ZG.F_WEP, ' pinks the ', ZG.F_DEF, " on the wrist, but it's not serious."), LTABLE(('PURE',), 'Your stroke lands, but it was only the flat of the blade.'), LTABLE(('PURE',), 'The blow lands, making a shallow gash in the ', ZG.F_DEF, "'s arm!")), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' receives a deep gash in his side.'), LTABLE(('PURE',), 'A savage blow on the thigh! The ', ZG.F_DEF, ' is stunned but can still fight!'), LTABLE(('PURE',), 'Slash! Your blow lands! That one hit an artery, it could be serious!'), LTABLE(('PURE',), 'Slash! Your stroke connects! This could be serious!')), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is staggered, and drops to his knees.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, " is momentarily disoriented and can't fight back."), LTABLE(('PURE',), 'The force of your blow knocks the ', ZG.F_DEF, ' back, stunned.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, " is confused and can't fight back."), LTABLE(('PURE',), 'The quickness of your thrust knocks the ', ZG.F_DEF, ' back, stunned.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, "'s weapon is knocked to the floor, leaving him unarmed."), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is disarmed by a subtle feint past his guard.')))  ->  ZilGlobal.py

'messages for cyclops (note that he has no weapon'

# zil: 1actions.zil:3654  <GLOBAL CYCLOPS-MELEE>
# GLOBAL (state) CYCLOPS_MELEE = TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops misses, but the backwash almost knocks you over.'), LTABLE(('PURE',), 'The Cyclops rushes you, but runs into the wall.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops sends you crashing to the floor, unconscious.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops breaks your neck with a massive smash.')), LTABLE(('PURE',), LTABLE(('PURE',), 'A quick punch, but it was only a glancing blow.'), LTABLE(('PURE',), "A glancing blow from the Cyclops' fist.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The monster smashes his huge fist into your chest, breaking several\nribs.'), LTABLE(('PURE',), 'The Cyclops almost knocks the wind out of you with a quick punch.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops lands a punch that knocks the wind out of you.'), LTABLE(('PURE',), 'Heedless of your weapons, the Cyclops tosses you against the rock\nwall of the room.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops grabs your ', ZG.F_WEP, ', tastes it, and throws it to the\nground in disgust.'), LTABLE(('PURE',), 'The monster grabs you on the wrist, squeezes, and you drop your\n', ZG.F_WEP, ' in pain.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops seems unable to decide whether to broil or stew his\ndinner.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops, no sportsman, dispatches his unconscious victim.')))  ->  ZilGlobal.py

'messages for troll'

# zil: 1actions.zil:3689  <GLOBAL TROLL-MELEE>
# GLOBAL (state) TROLL_MELEE = TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll swings his axe, but it misses.'), LTABLE(('PURE',), "The troll's axe barely misses your ear."), LTABLE(('PURE',), 'The axe sweeps past as you jump aside.'), LTABLE(('PURE',), 'The axe crashes against the rock, throwing sparks!')), LTABLE(('PURE',), LTABLE(('PURE',), "The flat of the troll's axe hits you delicately on the head, knocking\nyou out.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll neatly removes your head.'), LTABLE(('PURE',), "The troll's axe stroke cleaves you from the nave to the chops."), LTABLE(('PURE',), "The troll's axe removes your head.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The axe gets you right in the side. Ouch!'), LTABLE(('PURE',), "The flat of the troll's axe skins across your forearm."), LTABLE(('PURE',), "The troll's swing almost knocks you over as you barely parry\nin time."), LTABLE(('PURE',), 'The troll swings his axe, and it nicks your arm as you dodge.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll charges, and his axe slashes you on your ', ZG.F_WEP, ' arm.'), LTABLE(('PURE',), 'An axe stroke makes a deep wound in your leg.'), LTABLE(('PURE',), "The troll's axe swings down, gashing your shoulder.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll hits you with a glancing blow, and you are momentarily\nstunned.'), LTABLE(('PURE',), 'The troll swings; the blade turns on your armor but crashes\nbroadside into your head.'), LTABLE(('PURE',), 'You stagger back under a hail of axe strokes.'), LTABLE(('PURE',), "The troll's mighty blow drops you to your knees.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The axe hits your ', ZG.F_WEP, ' and knocks it spinning.'), LTABLE(('PURE',), 'The troll swings, you parry, but the force of his blow knocks your ', ZG.F_WEP, ' away.'), LTABLE(('PURE',), 'The axe knocks your ', ZG.F_WEP, ' out of your hand. It falls to the floor.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll hesitates, fingering his axe.'), LTABLE(('PURE',), 'The troll scratches his head ruminatively:  Might you be magically\nprotected, he wonders?')), LTABLE(('PURE',), LTABLE(('PURE',), 'Conquering his fears, the troll puts you to death.')))  ->  ZilGlobal.py

'messages for thief'

# zil: 1actions.zil:3735  <GLOBAL THIEF-MELEE>
# GLOBAL (state) THIEF_MELEE = TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief stabs nonchalantly with his stiletto and misses.'), LTABLE(('PURE',), 'You dodge as the thief comes in low.'), LTABLE(('PURE',), 'You parry a lightning thrust, and the thief salutes you with\na grim nod.'), LTABLE(('PURE',), 'The thief tries to sneak past your guard, but you twist away.')), LTABLE(('PURE',), LTABLE(('PURE',), 'Shifting in the midst of a thrust, the thief knocks you unconscious\nwith the haft of his stiletto.'), LTABLE(('PURE',), 'The thief knocks you out.')), LTABLE(('PURE',), LTABLE(('PURE',), 'Finishing you off, the thief inserts his blade into your heart.'), LTABLE(('PURE',), 'The thief comes in from the side, feints, and inserts the blade\ninto your ribs.'), LTABLE(('PURE',), 'The thief bows formally, raises his stiletto, and with a wry grin,\nends the battle and your life.')), LTABLE(('PURE',), LTABLE(('PURE',), 'A quick thrust pinks your left arm, and blood starts to\ntrickle down.'), LTABLE(('PURE',), 'The thief draws blood, raking his stiletto across your arm.'), LTABLE(('PURE',), 'The stiletto flashes faster than you can follow, and blood wells\nfrom your leg.'), LTABLE(('PURE',), 'The thief slowly approaches, strikes like a snake, and leaves\nyou wounded.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief strikes like a snake! The resulting wound is serious.'), LTABLE(('PURE',), 'The thief stabs a deep cut in your upper arm.'), LTABLE(('PURE',), 'The stiletto touches your forehead, and the blood obscures your\nvision.'), LTABLE(('PURE',), 'The thief strikes at your wrist, and suddenly your grip is slippery\nwith blood.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The butt of his stiletto cracks you on the skull, and you stagger\nback.'), LTABLE(('PURE',), 'The thief rams the haft of his blade into your stomach, leaving\nyou out of breath.'), LTABLE(('PURE',), 'The thief attacks, and you fall back desperately.')), LTABLE(('PURE',), LTABLE(('PURE',), 'A long, theatrical slash. You catch it on your ', ZG.F_WEP, ', but the\nthief twists his knife, and the ', ZG.F_WEP, ' goes flying.'), LTABLE(('PURE',), 'The thief neatly flips your ', ZG.F_WEP, ' out of your hands, and it drops\nto the floor.'), LTABLE(('PURE',), 'You parry a low thrust, and your ', ZG.F_WEP, ' slips out of your hand.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off.'), LTABLE(('PURE',), 'The thief amuses himself by searching your pockets.'), LTABLE(('PURE',), 'The thief entertains himself by rifling your pack.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief, forgetting his essentially genteel upbringing, cuts your\nthroat.'), LTABLE(('PURE',), 'The thief, a pragmatist, dispatches you as a threat to his\nlivelihood.')))  ->  ZilGlobal.py

'each table entry is:'

# zil: 1actions.zil:3793  <CONSTANT V-VILLAIN>
# CONSTANT (const) V_VILLAIN = 0  ->  ZilGlobal.py

# ;"villain"

# zil: 1actions.zil:3794  <CONSTANT V-BEST>
# CONSTANT (const) V_BEST = 1  ->  ZilGlobal.py

# ;"best weapon"

# zil: 1actions.zil:3795  <CONSTANT V-BEST-ADV>
# CONSTANT (const) V_BEST_ADV = 2  ->  ZilGlobal.py

# ;"advantage it confers"

# zil: 1actions.zil:3796  <CONSTANT V-PROB>
# CONSTANT (const) V_PROB = 3  ->  ZilGlobal.py

# ;"prob of waking if unconscious"

# zil: 1actions.zil:3797  <CONSTANT V-MSGS>
# CONSTANT (const) V_MSGS = 4  ->  ZilGlobal.py

# ;"messages for that villain"

'This table must be after TROLL-MELEE, THIEF-MELEE, CYCLOPS-MELEE defined!'

# zil: 1actions.zil:3801  <GLOBAL VILLAINS>
# GLOBAL (state) VILLAINS = LTABLE(TABLE(ZG.TROLL, ZG.SWORD, 1, 0, ZG.TROLL_MELEE), TABLE(ZG.THIEF, ZG.KNIFE, 1, 0, ZG.THIEF_MELEE), TABLE(ZG.CYCLOPS, False, 0, 0, ZG.CYCLOPS_MELEE))  ->  ZilGlobal.py

'DEMONS'

'Fighting demon'

# zil: 1actions.zil:3810  <ROUTINE I-FIGHT ("AUX" (FIGHT? <>) (LEN <GET ,VILLAINS 0>) CNT OO O P)>
@ZG.routine('I-FIGHT')
def I_FIGHT():
    FIGHT_p = False
    LEN = GET(ZG.VILLAINS, 0)
    CNT = 0
    OO = 0
    O_l = 0
    P = 0
    if ZG.DEAD:
        return False
    CNT = 0
    while True:
        CNT = (CNT + 1)
        if (CNT == LEN):
            break
        OO = GET(ZG.VILLAINS, CNT)
        if (IN_p((O_l := GET(OO, ZG.V_VILLAIN)), ZG.HERE) and (not FSET_p(O_l, Flag('INVISIBLE')))):
            if ((O_l == ZG.THIEF) and ZG.THIEF_ENGROSSED):
                ZG.THIEF_ENGROSSED = False
            elif (GETP(O_l, 'STRENGTH') < 0):
                P = GET(OO, ZG.V_PROB)
                if ((not (P == 0)) and ZG.PROB_1(P)):
                    PUT(OO, ZG.V_PROB, 0)
                    ZG.AWAKEN(O_l)
                else:
                    PUT(OO, ZG.V_PROB, (P + 25))
            elif (FSET_p(O_l, Flag('FIGHTBIT')) or APPLY(GETP(O_l, 'ACTION'), ZG.F_FIRST_p)):
                FIGHT_p = True
        else:
            if FSET_p(O_l, Flag('FIGHTBIT')):
                APPLY(GETP(O_l, 'ACTION'), ZG.F_BUSY_p)
            if (O_l == ZG.THIEF):
                ZG.THIEF_ENGROSSED = False
            FCLEAR(ZG.WINNER, Flag('STAGGERED'))
            FCLEAR(O_l, Flag('STAGGERED'))
            FCLEAR(O_l, Flag('FIGHTBIT'))
            ZG.AWAKEN(O_l)
    if (not FIGHT_p):
        return False
    return ZG.DO_FIGHT(LEN)

# zil: 1actions.zil:3843  <ROUTINE AWAKEN (O "AUX" (S <GETP .O ,P?STRENGTH>))>
@ZG.routine('AWAKEN')
def AWAKEN(O_l):
    S_l = GETP(O_l, 'STRENGTH')
    if (S_l < 0):
        PUTP(O_l, 'STRENGTH', (0 - S_l))
        APPLY(GETP(O_l, 'ACTION'), ZG.F_CONSCIOUS)
    return True

'SWORD demon'

# zil: 1actions.zil:3851  <ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (G <GETP ,SWORD ,P?TVALUE>) (NG 0...
@ZG.routine('I-SWORD')
def I_SWORD():
    DEM = ZG.INT(ZG.I_SWORD)
    G = GETP(ZG.SWORD, 'TVALUE')
    NG = 0
    P = 0
    T = 0
    L = 0
    if IN_p(ZG.SWORD, ZG.ADVENTURER):
        if ZG.INFESTED_p(ZG.HERE):
            NG = 2
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
        if (NG == G):
            return False
        elif (NG == 2):
            TELL('Your sword has begun to glow very brightly.', CR)
        elif (NG == 1):
            TELL('Your sword is glowing with a faint blue glow.', CR)
        elif (NG == 0):
            TELL('Your sword is no longer glowing.', CR)
        PUTP(ZG.SWORD, 'TVALUE', NG)
        return True
    else:
        PUT(DEM, ZG.C_ENABLED_p, 0)
        return False

# zil: 1actions.zil:3881  <ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))>
@ZG.routine('INFESTED?')
def INFESTED_p(R):
    F = FIRST_p(R)
    while True:
        if (not F):
            return False
        elif (FSET_p(F, Flag('ACTORBIT')) and (not FSET_p(F, Flag('INVISIBLE')))):
            return True
        elif (not (F := NEXT_p(F))):
            return False

'THIEF demon'

# zil: 1actions.zil:3890  <ROUTINE I-THIEF ("AUX" (RM <LOC ,THIEF>) ROBJ HERE? (ONCE <>) (FLG <>))>
@ZG.routine('I-THIEF')
def I_THIEF():
    RM = LOC(ZG.THIEF)
    ROBJ = 0
    HERE_p = 0
    ONCE = False
    FLG = False
    while True:
        if (HERE_p := (not FSET_p(ZG.THIEF, Flag('INVISIBLE')))):
            RM = LOC(ZG.THIEF)
        if ((RM == ZG.TREASURE_ROOM) and (not (RM == ZG.HERE))):
            if HERE_p:
                ZG.HACK_TREASURES()
                HERE_p = False
            ZG.DEPOSIT_BOOTY(ZG.TREASURE_ROOM)
        elif ((RM == ZG.HERE) and (not FSET_p(RM, Flag('ONBIT'))) and (not IN_p(ZG.TROLL, ZG.HERE))):
            if ZG.THIEF_VS_ADVENTURER(HERE_p):
                return True
            if FSET_p(ZG.THIEF, Flag('INVISIBLE')):
                HERE_p = False
        else:
            if (IN_p(ZG.THIEF, RM) and (not FSET_p(ZG.THIEF, Flag('INVISIBLE')))):
                FSET(ZG.THIEF, Flag('INVISIBLE'))
                HERE_p = False
            if FSET_p(RM, Flag('TOUCHBIT')):
                ZG.ROB(RM, ZG.THIEF, 75)
                if (FSET_p(RM, Flag('MAZEBIT')) and FSET_p(ZG.HERE, Flag('MAZEBIT'))):
                    FLG = ZG.ROB_MAZE(RM)
                else:
                    FLG = ZG.STEAL_JUNK(RM)
        if ((ONCE := (not ONCE)) and (not HERE_p)):
            ZG.RECOVER_STILETTO()
            while True:
                if (RM and (RM := NEXT_p(RM))):
                    pass
                else:
                    RM = FIRST_p(ZG.ROOMS)
                if ((not FSET_p(RM, Flag('SACREDBIT'))) and FSET_p(RM, Flag('RLANDBIT'))):
                    MOVE(ZG.THIEF, RM)
                    FCLEAR(ZG.THIEF, Flag('FIGHTBIT'))
                    FSET(ZG.THIEF, Flag('INVISIBLE'))
                    ZG.THIEF_HERE = False
                    break
            continue
        break
    if (not (RM == ZG.TREASURE_ROOM)):
        ZG.DROP_JUNK(RM)
    return FLG

# zil: 1actions.zil:3933  <ROUTINE DROP-JUNK (RM "AUX" X N (FLG <>))>
@ZG.routine('DROP-JUNK')
def DROP_JUNK(RM):
    X = 0
    N_l = 0
    FLG = False
    X = FIRST_p(ZG.THIEF)
    while True:
        if (not X):
            return FLG
        N_l = NEXT_p(X)
        if (X in (ZG.STILETTO, ZG.LARGE_BAG)):
            pass
        elif ((GETP(X, 'TVALUE') == 0) and ZG.PROB_2(30, True)):
            FCLEAR(X, Flag('INVISIBLE'))
            MOVE(X, RM)
            if ((not FLG) and (RM == ZG.HERE)):
                TELL('The robber, rummaging through his bag, dropped a few items he found\nvalueless.', CR)
                FLG = True
        X = N_l

# zil: 1actions.zil:3949  <ROUTINE RECOVER-STILETTO ()>
@ZG.routine('RECOVER-STILETTO')
def RECOVER_STILETTO():
    if IN_p(ZG.STILETTO, LOC(ZG.THIEF)):
        FSET(ZG.STILETTO, Flag('NDESCBIT'))
        return MOVE(ZG.STILETTO, ZG.THIEF)
    else:
        return False

# zil: 1actions.zil:3954  <ROUTINE STEAL-JUNK (RM "AUX" X N)>
@ZG.routine('STEAL-JUNK')
def STEAL_JUNK(RM):
    X = 0
    N_l = 0
    X = FIRST_p(RM)
    while True:
        if (not X):
            return False
        N_l = NEXT_p(X)
        if ((GETP(X, 'TVALUE') == 0) and FSET_p(X, Flag('TAKEBIT')) and (not FSET_p(X, Flag('SACREDBIT'))) and (not FSET_p(X, Flag('INVISIBLE'))) and ((X == ZG.STILETTO) or ZG.PROB_2(10, True))):
            MOVE(X, ZG.THIEF)
            FSET(X, Flag('TOUCHBIT'))
            FSET(X, Flag('INVISIBLE'))
            if (X == ZG.ROPE):
                ZG.DOME_FLAG = False
            if (RM == ZG.HERE):
                TELL('You suddenly notice that the ', D, X, ' vanished.', CR)
                return True
            else:
                return False
        X = N_l

# zil: 1actions.zil:3976  <ROUTINE ROB (WHAT WHERE "OPTIONAL" (PROB <>) "AUX" N X (ROBBED? <>))>
@ZG.routine('ROB')
def ROB(WHAT, WHERE, PROB=None):
    if PROB is None:
        PROB = False
    N_l = 0
    X = 0
    ROBBED_p = False
    X = FIRST_p(WHAT)
    while True:
        if (not X):
            return ROBBED_p
        N_l = NEXT_p(X)
        if ((not FSET_p(X, Flag('INVISIBLE'))) and (not FSET_p(X, Flag('SACREDBIT'))) and (GETP(X, 'TVALUE') > 0) and ((not PROB) or ZG.PROB_1(PROB))):
            MOVE(X, WHERE)
            FSET(X, Flag('TOUCHBIT'))
            if (WHERE == ZG.THIEF):
                FSET(X, Flag('INVISIBLE'))
            ROBBED_p = True
        X = N_l

# ;"special-cased routines"

# zil: 1actions.zil:3993  <ROUTINE V-DIAGNOSE ("AUX" (MS <FIGHT-STRENGTH <>>) (WD <GETP ,WINNER ,P?STRE...
@ZG.routine('V-DIAGNOSE')
def V_DIAGNOSE():
    MS = ZG.FIGHT_STRENGTH(False)
    WD = GETP(ZG.WINNER, 'STRENGTH')
    RS = (MS + WD)
    if (GET(ZG.INT(ZG.I_CURE), ZG.C_ENABLED_p) == 0):
        WD = 0
    else:
        WD = (-WD)
    if (WD == 0):
        TELL('You are in perfect health.')
    else:
        TELL('You have ')
        if (WD == 1):
            TELL('a light wound,')
        elif (WD == 2):
            TELL('a serious wound,')
        elif (WD == 3):
            TELL('several wounds,')
        elif (WD > 3):
            TELL('serious wounds,')
    if (not (WD == 0)):
        TELL(' which will be cured after ')
        PRINTN(((ZG.CURE_WAIT * (WD - 1)) + GET(ZG.INT(ZG.I_CURE), ZG.C_TICK)))
        TELL(' moves.')
    CRLF()
    TELL('You can ')
    if (RS == 0):
        TELL('expect death soon')
    elif (RS == 1):
        TELL('be killed by one more light wound')
    elif (RS == 2):
        TELL('be killed by a serious wound')
    elif (RS == 3):
        TELL('survive one serious wound')
    elif (RS > 3):
        TELL('survive several wounds')
    TELL('.', CR)
    if (not (ZG.DEATHS == 0)):
        TELL('You have been killed ')
        if (ZG.DEATHS == 1):
            TELL('once')
        else:
            TELL('twice')
        return TELL('.', CR)
    else:
        return False

# zil: 1actions.zil:4026  <ROUTINE V-SCORE ("OPTIONAL" (ASK? T))>
@ZG.routine('V-SCORE')
def V_SCORE(ASK_p=None):
    if ASK_p is None:
        ASK_p = True
    TELL('Your score is ')
    TELL(N, ZG.SCORE)
    TELL(' (total of 350 points), in ')
    TELL(N, ZG.MOVES)
    if (ZG.MOVES == 1):
        TELL(' move.')
    else:
        TELL(' moves.')
    CRLF()
    TELL('This gives you the rank of ')
    if (ZG.SCORE == 350):
        TELL('Master Adventurer')
    elif (ZG.SCORE > 330):
        TELL('Wizard')
    elif (ZG.SCORE > 300):
        TELL('Master')
    elif (ZG.SCORE > 200):
        TELL('Adventurer')
    elif (ZG.SCORE > 100):
        TELL('Junior Adventurer')
    elif (ZG.SCORE > 50):
        TELL('Novice Adventurer')
    elif (ZG.SCORE > 25):
        TELL('Amateur Adventurer')
    else:
        TELL('Beginner')
    TELL('.', CR)
    return ZG.SCORE

# zil: 1actions.zil:4046  <ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))>
@ZG.routine('JIGS-UP')
def JIGS_UP(DESC_l, PLAYER_p=None):
    if PLAYER_p is None:
        PLAYER_p = False
    ZG.WINNER = ZG.ADVENTURER
    if ZG.DEAD:
        TELL('\nIt takes a talented person to be killed while already dead. YOU are such\na talent. Unfortunately, it takes a talented person to deal with it.\nI am not such a talent. Sorry.', CR)
        ZG.FINISH()
    TELL(DESC_l, CR)
    if (not ZG.LUCKY):
        TELL('Bad luck, huh?', CR)
    while True:
        ZG.SCORE_UPD(-10)
        TELL('\n\n    ****  You have died  ****\n\n\n')
        if FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
            MOVE(ZG.WINNER, ZG.HERE)
        if (not (ZG.DEATHS < 2)):
            TELL("You clearly are a suicidal maniac.  We don't allow psychotics in the\ncave, since they may harm other adventurers.  Your remains will be\ninstalled in the Land of the Living Dead, where your fellow\nadventurers may gloat over them.", CR)
            return ZG.FINISH()
        else:
            ZG.DEATHS = (ZG.DEATHS + 1)
            MOVE(ZG.WINNER, ZG.HERE)
            if FSET_p(ZG.SOUTH_TEMPLE, Flag('TOUCHBIT')):
                TELL('As you take your last breath, you feel relieved of your burdens. The\nfeeling passes as you find yourself before the gates of Hell, where\nthe spirits jeer at you and deny you entry.  Your senses are\ndisturbed.  The objects in the dungeon appear indistinct, bleached of\ncolor, even unreal.', CR, CR)
                ZG.DEAD = True
                ZG.TROLL_FLAG = True
                ZG.ALWAYS_LIT = True
                PUTP(ZG.WINNER, 'ACTION', ZG.DEAD_FUNCTION)
                ZG.GOTO(ZG.ENTRANCE_TO_HADES)
            else:
                TELL("Now, let's take a look here...\nWell, you probably deserve another chance.  I can't quite fix you\nup completely, but you can't have everything.", CR, CR)
                ZG.GOTO(ZG.FOREST_1)
            FCLEAR(ZG.TRAP_DOOR, Flag('TOUCHBIT'))
            ZG.P_CONT = False
            ZG.RANDOMIZE_OBJECTS()
            ZG.KILL_INTERRUPTS()
            return 2
        break

# zil: 1actions.zil:4101  <ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)>
@ZG.routine('RANDOMIZE-OBJECTS')
def RANDOMIZE_OBJECTS():
    R = False
    F = 0
    N_l = 0
    L = 0
    if IN_p(ZG.LAMP, ZG.WINNER):
        MOVE(ZG.LAMP, ZG.LIVING_ROOM)
    if IN_p(ZG.COFFIN, ZG.WINNER):
        MOVE(ZG.COFFIN, ZG.EGYPT_ROOM)
    PUTP(ZG.SWORD, 'TVALUE', 0)
    N_l = FIRST_p(ZG.WINNER)
    L = GET(ZG.ABOVE_GROUND, 0)
    while True:
        F = N_l
        if (not F):
            return True
        N_l = NEXT_p(F)
        if (GETP(F, 'TVALUE') > 0):
            while True:
                if (not R):
                    R = FIRST_p(ZG.ROOMS)
                if (FSET_p(R, Flag('RLANDBIT')) and (not FSET_p(R, Flag('ONBIT'))) and ZG.PROB_1(50)):
                    MOVE(F, R)
                    break
                else:
                    R = NEXT_p(R)
        else:
            MOVE(F, GET(ZG.ABOVE_GROUND, RANDOM(L)))

# zil: 1actions.zil:4125  <ROUTINE KILL-INTERRUPTS ()>
@ZG.routine('KILL-INTERRUPTS')
def KILL_INTERRUPTS():
    ZG.DISABLE(ZG.INT(ZG.I_XB))
    ZG.DISABLE(ZG.INT(ZG.I_XC))
    ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS))
    ZG.DISABLE(ZG.INT(ZG.I_LANTERN))
    ZG.DISABLE(ZG.INT(ZG.I_CANDLES))
    ZG.DISABLE(ZG.INT(ZG.I_SWORD))
    ZG.DISABLE(ZG.INT(ZG.I_FOREST_ROOM))
    ZG.DISABLE(ZG.INT(ZG.I_MATCH))
    FCLEAR(ZG.MATCH, Flag('ONBIT'))
    return True

# zil: 1actions.zil:4137  <ROUTINE BAG-OF-COINS-F ()>
@ZG.routine('BAG-OF-COINS-F')
def BAG_OF_COINS_F():
    return ZG.STUPID_CONTAINER(ZG.BAG_OF_COINS, 'coins')

# zil: 1actions.zil:4140  <ROUTINE TRUNK-F ()>
@ZG.routine('TRUNK-F')
def TRUNK_F():
    return ZG.STUPID_CONTAINER(ZG.TRUNK, 'jewels')

# zil: 1actions.zil:4143  <ROUTINE STUPID-CONTAINER (OBJ STR)>
@ZG.routine('STUPID-CONTAINER')
def STUPID_CONTAINER(OBJ_l, STR):
    if VERB_p('OPEN', 'CLOSE'):
        return TELL('The ', STR, " are safely inside; there's no need to do that.", CR)
    elif VERB_p('LOOK-INSIDE', 'EXAMINE'):
        return TELL('There are lots of ', STR, ' in there.', CR)
    elif (VERB_p('PUT') and (ZG.PRSI == OBJ_l)):
        return TELL("Don't be silly. It wouldn't be a ", D, OBJ_l, ' anymore.', CR)
    else:
        return False

# zil: 1actions.zil:4154  <ROUTINE DUMB-CONTAINER ()>
@ZG.routine('DUMB-CONTAINER')
def DUMB_CONTAINER():
    if VERB_p('OPEN', 'CLOSE', 'LOOK-INSIDE'):
        return TELL("You can't do that.", CR)
    elif VERB_p('EXAMINE'):
        return TELL('It looks pretty much like a ', D, ZG.PRSO, '.', CR)
    else:
        return False

# zil: 1actions.zil:4160  <ROUTINE GARLIC-F ()>
@ZG.routine('GARLIC-F')
def GARLIC_F():
    if VERB_p('EAT'):
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        return TELL("What the heck! You won't make friends this way, but nobody around\nhere is too friendly anyhow. Gulp!", CR)
    else:
        return False

# zil: 1actions.zil:4167  <ROUTINE CHAIN-PSEUDO ()>
@ZG.routine('CHAIN-PSEUDO')
def CHAIN_PSEUDO():
    if VERB_p('TAKE', 'MOVE'):
        return TELL('The chain is secure.', CR)
    elif VERB_p('RAISE', 'LOWER'):
        return TELL('Perhaps you should do that to the basket.', CR)
    elif VERB_p('EXAMINE'):
        return TELL('The chain secures a basket within the shaft.', CR)
    else:
        return False

# zil: 1actions.zil:4175  <ROUTINE TROLL-ROOM-F (RARG)>
@ZG.routine('TROLL-ROOM-F')
def TROLL_ROOM_F(RARG):
    if ((RARG == ZG.M_ENTER) and IN_p(ZG.TROLL, ZG.HERE)):
        return ZG.THIS_IS_IT(ZG.TROLL)
    else:
        return False
