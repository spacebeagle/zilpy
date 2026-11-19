# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'ACTIONS2 for\n\t\t      Zork II: The Wizard of Frobozz\n\t(c) Copyright 1981, 1983 Infocom, Inc.  All Rights Reserved.'

# zil: 2actions.zil:5  <ROUTINE SWORD-FCN ()>
@ZG.routine('SWORD-FCN')
def SWORD_FCN():
    if (VERB_p('TAKE') and (ZG.WINNER == ZG.ADVENTURER)):
        ENABLE(ZG.QUEUE(ZG.I_SWORD, -1))
        return False
    else:
        return False

'SWORD demon'

# zil: 2actions.zil:13  <GLOBAL SWORD-GLOW>
# GLOBAL (state) SWORD_GLOW = 0  ->  ZilGlobal.py

# zil: 2actions.zil:15  <ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) G P TX L)>
@ZG.routine('I-SWORD')
def I_SWORD():
    DEM = ZG.INT(ZG.I_SWORD)
    NG = 0
    G = 0
    P = 0
    TX = 0
    L = 0
    G = ZG.SWORD_GLOW
    if IN_p(ZG.SWORD, ZG.ADVENTURER):
        if ZG.INFESTED_p(ZG.HERE):
            NG = 2
        else:
            P = 0
            while True:
                if ((P := NEXTP(ZG.HERE, P)) == 0):
                    break
                elif (not (P < LOW_DIRECTION)):
                    TX = GETPT(ZG.HERE, P)
                    L = PTSIZE(TX)
                    if (L in (ZG.UEXIT, ZG.CEXIT, ZG.DEXIT)):
                        if ZG.INFESTED_p(GETB(TX, 0)):
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
        ZG.SWORD_GLOW = NG
        return True
    else:
        PUT(DEM, ZG.C_ENABLED_p, 0)
        return False

# zil: 2actions.zil:45  <ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))>
@ZG.routine('INFESTED?')
def INFESTED_p(R):
    F = FIRST_p(R)
    while True:
        if (not F):
            return False
        elif (FSET_p(F, Flag('ACTORBIT')) and (not FSET_p(F, Flag('INVISIBLE'))) and (not (F == ZG.ROBOT))):
            return F
        elif (not (F := NEXT_p(F))):
            return False

# zil: 2actions.zil:54  <ROUTINE CAROUSEL-ROOM-FCN (RARG)>
@ZG.routine('CAROUSEL-ROOM-FCN')
def CAROUSEL_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a large circular room whose high ceiling is lost in gloom. Eight\nidentical passages leave the room.', CR)
        if (not ZG.CAROUSEL_FLIP_FLAG):
            TELL('A loud whirring sound comes from all around, and you feel\nsort of disoriented in here.', CR)
        return True
    elif ((not ZG.CAROUSEL_FLIP_FLAG) and (RARG == ZG.M_BEG) and VERB_p('WALK')):
        if (ZG.PRSO in ('UP', 'DOWN')):
            return False
        if (ZG.PRSO == 'OUT'):
            TELL('Feeling dizzy, you pick a direction at random.', CR, CR)
            ZG.PRSO = 'EAST'
        else:
            TELL("You're not sure which direction is which. This\nroom is very disorienting.", CR, CR)
        if ((ZG.PRSO == 'WEST') or ZG.PROB(80)):
            ZG.PRSO = GET(ZG.EIGHT_DIRECTIONS, (RANDOM(7) - 1))
        ZG.V_WALK()
        return True
    else:
        return False

# zil: 2actions.zil:82  <ROUTINE VIOLIN-FCN ()>
@ZG.routine('VIOLIN-FCN')
def VIOLIN_FCN():
    if (VERB_p('PLAY') and (ZG.PRSO == ZG.VIOLIN)):
        return TELL('An amazingly offensive noise issues from the violin.', CR)
    else:
        return False

# zil: 2actions.zil:88  <GLOBAL EIGHT-DIRECTIONS>
# GLOBAL (state) EIGHT_DIRECTIONS = TABLE('NORTH', 'EAST', 'SOUTH', 'NE', 'SE', 'SW', 'NW')  ->  ZilGlobal.py

# zil: 2actions.zil:91  <GLOBAL MUNGED-ROOM>
# GLOBAL (state) MUNGED_ROOM = False  ->  ZilGlobal.py

# zil: 2actions.zil:93  <ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)>
@ZG.routine('OPEN-CLOSE')
def OPEN_CLOSE(OBJ_l, STROPN, STRCLS):
    if VERB_p('OPEN'):
        if FSET_p(OBJ_l, Flag('OPENBIT')):
            TELL(ZG.RANDOM_ELEMENT(ZG.DUMMY))
        else:
            TELL(STROPN)
            FSET(OBJ_l, Flag('OPENBIT'))
        return CRLF()
    elif VERB_p('CLOSE'):
        if FSET_p(OBJ_l, Flag('OPENBIT')):
            TELL(STRCLS)
            FCLEAR(OBJ_l, Flag('OPENBIT'))
        else:
            TELL(ZG.RANDOM_ELEMENT(ZG.DUMMY), CR)
        return CRLF()
    else:
        return False

# ;"SUBTITLE THE VOLCANO"

# zil: 2actions.zil:112  <GLOBAL BTIE-FLAG>
# GLOBAL (state) BTIE_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:113  <GLOBAL BINF-FLAG>
# GLOBAL (state) BINF_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:114  <GLOBAL BLAB-FLAG>
# GLOBAL (state) BLAB_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:115  <GLOBAL SAFE-FLAG>
# GLOBAL (state) SAFE_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:117  <ROUTINE BALLOON-FCN ("OPTIONAL" (RARG <>) "AUX" M R RC)>
@ZG.routine('BALLOON-FCN')
def BALLOON_FCN(RARG=None):
    if RARG is None:
        RARG = False
    M = 0
    R = 0
    RC = 0
    if (RARG == ZG.M_LOOK):
        if ZG.BINF_FLAG:
            TELL('The cloth bag is inflated and ')
            if FSET_p(ZG.RECEPTACLE, Flag('OPENBIT')):
                TELL('there is a ', D, ZG.BINF_FLAG, ' burning in the receptacle.')
            else:
                TELL('some smoke is leaking out of the closed receptacle.')
        else:
            TELL('The cloth bag is draped over the side\nof the basket. Directly in the middle of the basket is a metal receptacle\nwhich is ')
            if FSET_p(ZG.RECEPTACLE, Flag('OPENBIT')):
                TELL('open')
                RC = FIRST_p(ZG.RECEPTACLE)
                if RC:
                    if (ZG.BINF_FLAG == RC):
                        _tmp1 = 'burning'
                    else:
                        _tmp1 = 'nestled'
                    if (ZG.BINF_FLAG == RC):
                        _tmp2 = 'burning'
                    else:
                        _tmp2 = 'nestled'
                    TELL('. A ', D, RC, ' is ', _tmp2, ' inside')
            else:
                TELL('closed')
            TELL('.')
        if ZG.BTIE_FLAG:
            TELL(' The balloon is tied to a hook by the braided wire.', CR)
        else:
            TELL(' A braided wire is dangling over the side of the basket.', CR)
        return True
    elif (RARG == ZG.M_OBJDESC):
        TELL('There is a large and extremely heavy wicker basket here. An\nenormous cloth bag ')
        if ZG.BINF_FLAG:
            TELL('attached to the basket is inflated. A metal receptacle is fastened to\nthe center of the basket. ')
            if FSET_p(ZG.RECEPTACLE, Flag('OPENBIT')):
                TELL('In it is a burning ', D, ZG.BINF_FLAG)
            else:
                TELL('Some smoke leaks out around its closed lid')
        else:
            TELL('is draped over the side and is firmly attached to the basket. A metal\nreceptacle is fastened to the center of the basket')
        if ZG.BTIE_FLAG:
            return TELL('. A piece of wire tied to a hook holds the balloon in place.', CR)
        else:
            return TELL('. Dangling from the basket is a piece of braided wire.', CR)
    elif (RARG == ZG.M_BEG):
        if VERB_p('WALK'):
            if (M := GETPT(ZG.HERE, ZG.PRSO)):
                if ZG.BTIE_FLAG:
                    TELL('You are tied to the ledge.', CR)
                    return True
                else:
                    ((PTSIZE(M) == 1) and (not FSET_p((R := GETB(M, 0)), Flag('RMUNGBIT'))) and ZG._set('BLOC', R))
                    ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3))
                    return False
            else:
                TELL("You can't control the balloon this way.", CR)
                return True
        elif (VERB_p('OPEN') and ZG.BINF_FLAG and (ZG.PRSO == ZG.RECEPTACLE) and FIRST_p(ZG.RECEPTACLE)):
            TELL('Opening it reveals a burning ', D, ZG.BINF_FLAG, '.', CR)
            FSET(ZG.RECEPTACLE, Flag('OPENBIT'))
            return True
        elif (VERB_p('TAKE') and (ZG.BINF_FLAG == ZG.PRSO)):
            TELL("You don't really want to hold a burning ", D, ZG.PRSO, '.', CR)
            return True
        elif (VERB_p('PUT') and (ZG.PRSI == ZG.RECEPTACLE) and FIRST_p(ZG.RECEPTACLE)):
            TELL('The receptacle is already occupied.', CR)
            return True
        elif (VERB_p('PUT') and (ZG.PRSI == ZG.RECEPTACLE)):
            FSET(ZG.PRSO, Flag('NDESCBIT'))
            return False
        elif VERB_p('INFLATE'):
            return TELL('It takes more than words to inflate a balloon.', CR)
        else:
            return False
    else:
        return False

# zil: 2actions.zil:219  <ROUTINE I-BALLOON ()>
@ZG.routine('I-BALLOON')
def I_BALLOON():
    if (FSET_p(ZG.RECEPTACLE, Flag('OPENBIT')) and ZG.BINF_FLAG):
        return ZG.RISE_AND_SHINE()
    elif (ZG.HERE in (ZG.LEDGE_1, ZG.LEDGE_2)):
        return ZG.RISE_AND_SHINE()
    else:
        return ZG.DECLINE_AND_FALL()

# zil: 2actions.zil:227  <ROUTINE BALLOON-BURN ()>
@ZG.routine('BALLOON-BURN')
def BALLOON_BURN():
    TELL('The ', D, ZG.PRSO, ' burns inside the receptacle.', CR)
    ENABLE(ZG.QUEUE(ZG.I_BURNUP, (GETP(ZG.PRSO, 'SIZE') * 20)))
    FSET(ZG.PRSO, Flag('FLAMEBIT'))
    FSET(ZG.PRSO, Flag('ONBIT'))
    FCLEAR(ZG.PRSO, Flag('TAKEBIT'))
    FCLEAR(ZG.PRSO, Flag('READBIT'))
    if ZG.BINF_FLAG:
        return True
    else:
        TELL('The cloth bag inflates as it fills with hot air.', CR)
        if (not ZG.BLAB_FLAG):
            TELL('A small label drops from the bag into the basket.', CR)
            MOVE(ZG.BALLOON_LABEL, ZG.BALLOON)
        ZG.BLAB_FLAG = True
        ZG.BINF_FLAG = ZG.PRSO
        return ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3))

# zil: 2actions.zil:246  <ROUTINE PUT-BALLOON (THERE STR)>
@ZG.routine('PUT-BALLOON')
def PUT_BALLOON(THERE, STR):
    if (ZG.HERE in (ZG.LEDGE_1, ZG.LEDGE_2, ZG.VOLCANO_BOTTOM)):
        TELL('You watch as the balloon slowly ', STR, CR)
    MOVE(ZG.BALLOON, THERE)
    ZG.BLOC = THERE
    return ZG.BLOC

# zil: 2actions.zil:253  <GLOBAL BALLOON-UPS>
# GLOBAL (state) BALLOON_UPS = LTABLE(ZG.VAIR_1, ZG.VAIR_2, ZG.VAIR_3, ZG.VAIR_4)  ->  ZilGlobal.py

# zil: 2actions.zil:256  <GLOBAL BALLOON-FLOATS>
# GLOBAL (state) BALLOON_FLOATS = LTABLE(ZG.LEDGE_1, ZG.VAIR_2, ZG.LEDGE_2, ZG.VAIR_4)  ->  ZilGlobal.py

# zil: 2actions.zil:259  <GLOBAL BALLOON-DOWNS>
# GLOBAL (state) BALLOON_DOWNS = LTABLE(ZG.VAIR_4, ZG.VAIR_3, ZG.VAIR_2, ZG.VAIR_1)  ->  ZilGlobal.py

# zil: 2actions.zil:262  <ROUTINE RISE-AND-SHINE ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)>
@ZG.routine('RISE-AND-SHINE')
def RISE_AND_SHINE():
    IN = IN_p(ZG.WINNER, ZG.BALLOON)
    R = 0
    ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3))
    if (ZG.BLOC == ZG.VAIR_4):
        ZG.DISABLE(ZG.INT(ZG.I_BURNUP))
        ZG.DISABLE(ZG.INT(ZG.I_BALLOON))
        REMOVE(ZG.BALLOON)
        if IN:
            ZG.JIGS_UP('The balloon floats majestically out of the volcano, revealing a\nbreathtaking view of a wooded river valley surrounded by impassable\nmountains. In a clearing stands a white house. You drift into high winds,\nwhich carry you towards the snow-capped peaks. Oh, no! You crash into the\njagged cliffs of the Flathead Mountains!')
        elif (ZG.HERE in (ZG.LEDGE_1, ZG.LEDGE_2, ZG.VOLCANO_BOTTOM)):
            TELL('You watch the balloon drift out over the rim and away on the wind.', CR)
        ZG.BLOC = ZG.VOLCANO_BOTTOM
        return ZG.BLOC
    elif (R := ZG.LKP(ZG.BLOC, ZG.BALLOON_UPS)):
        if IN:
            TELL('The balloon ascends.', CR, CR)
            ZG.BLOC = R
            return ZG.GOTO(R)
        else:
            return ZG.PUT_BALLOON(R, 'ascends.')
    elif (R := ZG.LKP(ZG.BLOC, ZG.BALLOON_FLOATS)):
        if IN:
            TELL('The balloon leaves the ledge.', CR, CR)
            ZG.BLOC = R
            return ZG.GOTO(R)
        else:
            ENABLE(ZG.QUEUE(ZG.I_GNOME, 10))
            ZG.PUT_BALLOON(R, 'floats away. It seems to be ascending, due to its light load.')
            return FSET(ZG.RECEPTACLE, Flag('OPENBIT'))
    elif IN:
        ZG.BLOC = ZG.VAIR_1
        TELL('The balloon rises slowly from the ground.', CR, CR)
        return ZG.GOTO(ZG.VAIR_1)
    else:
        return ZG.PUT_BALLOON(ZG.VAIR_1, 'lifts off.')

# zil: 2actions.zil:304  <ROUTINE DECLINE-AND-FALL ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)>
@ZG.routine('DECLINE-AND-FALL')
def DECLINE_AND_FALL():
    IN = IN_p(ZG.WINNER, ZG.BALLOON)
    R = 0
    ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3))
    if (ZG.BLOC == ZG.VAIR_1):
        if IN:
            ZG.BLOC = ZG.VOLCANO_BOTTOM
            if ZG.BINF_FLAG:
                TELL('The balloon has landed.', CR, CR)
                return ZG.GOTO(ZG.VOLCANO_BOTTOM)
            else:
                REMOVE(ZG.BALLOON)
                MOVE(ZG.DEAD_BALLOON, ZG.BLOC)
                MOVE(ZG.WINNER, ZG.HERE)
                ZG.DISABLE(ZG.INT(ZG.I_BALLOON))
                TELL('You have landed, but the balloon did not survive.', CR, CR)
                return ZG.GOTO(ZG.VOLCANO_BOTTOM)
        else:
            return ZG.PUT_BALLOON(ZG.VOLCANO_BOTTOM, 'lands.')
    elif (R := ZG.LKP(ZG.BLOC, ZG.BALLOON_DOWNS)):
        if IN:
            TELL('The balloon descends.', CR, CR)
            ZG.BLOC = R
            return ZG.GOTO(R)
        else:
            return ZG.PUT_BALLOON(R, 'descends.')
    else:
        return False

# zil: 2actions.zil:331  <ROUTINE BCONTENTS ()>
@ZG.routine('BCONTENTS')
def BCONTENTS():
    if VERB_p('TAKE'):
        TELL('The ', D, ZG.PRSO, ' is an integral part of the basket and cannot\nbe removed.')
        if (ZG.PRSO == ZG.BRAIDED_WIRE):
            TELL(' The wire might possibly be tied, though.')
        return CRLF()
    elif ((ZG.PRSO == ZG.CLOTH_BAG) and VERB_p('LOOK-INSIDE', 'OPEN')):
        if VERB_p('OPEN'):
            return TELL('The bag is enormous. The concept of opening it here is ludicrous.', CR)
        else:
            return TELL("It doesn't appear that there's anything inside.", CR)
    elif (VERB_p('EXAMINE') and (ZG.PRSO == ZG.RECEPTACLE)):
        TELL('The receptacle is ')
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            return TELL('open.', CR)
        else:
            return TELL('closed.', CR)
    elif VERB_p('FIND', 'EXAMINE'):
        return TELL('The ', D, ZG.PRSO, ' is part of the basket. It may be manipulated\nwithin the basket but cannot be removed.', CR)
    else:
        return False

# zil: 2actions.zil:356  <ROUTINE WIRE-FCN ()>
@ZG.routine('WIRE-FCN')
def WIRE_FCN():
    if VERB_p('TAKE', 'FIND', 'EXAMINE'):
        return ZG.BCONTENTS()
    elif VERB_p('TIE'):
        if ((ZG.PRSO == ZG.BRAIDED_WIRE) and (ZG.PRSI in (ZG.HOOK_1, ZG.HOOK_2))):
            ZG.BTIE_FLAG = ZG.PRSI
            FSET(ZG.PRSI, Flag('NDESCBIT'))
            ZG.DISABLE(ZG.INT(ZG.I_BALLOON))
            return TELL('The balloon is fastened to the hook.', CR)
        else:
            return False
    elif (VERB_p('UNTIE') and (ZG.PRSO == ZG.BRAIDED_WIRE)):
        if ZG.BTIE_FLAG:
            ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3))
            FCLEAR(ZG.BTIE_FLAG, Flag('NDESCBIT'))
            ZG.BTIE_FLAG = False
            return TELL('The wire falls off of the hook.', CR)
        else:
            return TELL('The wire is not tied to anything.', CR)
    else:
        return False

# zil: 2actions.zil:375  <ROUTINE I-BURNUP ("AUX" (OBJ <FIRST? ,RECEPTACLE>))>
@ZG.routine('I-BURNUP')
def I_BURNUP():
    OBJ_l = FIRST_p(ZG.RECEPTACLE)
    if (ZG.HERE == ZG.BLOC):
        TELL('The ', D, OBJ_l, ' has now burned out, and the cloth bag starts to deflate.', CR)
    REMOVE(OBJ_l)
    ZG.BINF_FLAG = False
    return True

# zil: 2actions.zil:384  <ROUTINE SAFE-ROOM-FCN (RARG)>
@ZG.routine('SAFE-ROOM-FCN')
def SAFE_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a dusty old room which is featureless, except\nfor an exit on the north side.', CR)
        if (not ZG.SAFE_FLAG):
            return TELL('Imbedded in the far wall is a rusty box. It appears to be somewhat\ndamaged, since an oblong hole has been chipped out of the front of it.', CR)
        else:
            return TELL('On the far wall is a rusty box, whose door has been blown off.', CR)
    else:
        return False

# zil: 2actions.zil:397  <ROUTINE SAFE-FCN ()>
@ZG.routine('SAFE-FCN')
def SAFE_FCN():
    if (VERB_p('TAKE') and (ZG.PRSO == ZG.SAFE)):
        return TELL('The box is imbedded in the wall.', CR)
    elif VERB_p('OPEN'):
        if ZG.SAFE_FLAG:
            return TELL('The box has no door!', CR)
        else:
            return TELL('The box is rusted and will not open.', CR)
    elif VERB_p('CLOSE'):
        if ZG.SAFE_FLAG:
            return TELL('The box has no door!', CR)
        else:
            return TELL("The box isn't open!", CR)
    else:
        return False

# zil: 2actions.zil:407  <ROUTINE BRICK-FCN ()>
@ZG.routine('BRICK-FCN')
def BRICK_FCN():
    if VERB_p('BURN'):
        REMOVE(ZG.BRICK)
        return ZG.JIGS_UP(ZG.OTHER_PROPERTIES)
    else:
        return False

# zil: 2actions.zil:412  <GLOBAL OTHER-PROPERTIES>
# GLOBAL (state) OTHER_PROPERTIES = "Now you've done it. It seems that the brick has other properties\nthan weight, namely the ability to blow you to smithereens."  ->  ZilGlobal.py

# zil: 2actions.zil:416  <ROUTINE FUSE-FCN ()>
@ZG.routine('FUSE-FCN')
def FUSE_FCN():
    if (VERB_p('BURN') or (VERB_p('LAMP-ON') and IN_p(ZG.MATCH, ZG.WINNER) and FSET_p(ZG.MATCH, Flag('ONBIT')))):
        TELL('The string starts to burn.', CR)
        return ENABLE(ZG.QUEUE(ZG.I_FUSE, 2))
    else:
        return False

# zil: 2actions.zil:424  <ROUTINE I-FUSE ("AUX" (BRICK-ROOM <LOC ,BRICK>) F)>
@ZG.routine('I-FUSE')
def I_FUSE():
    BRICK_ROOM = LOC(ZG.BRICK)
    F = 0
    if IN_p(ZG.FUSE, ZG.BRICK):
        while True:
            if (not BRICK_ROOM):
                return False
            elif IN_p(BRICK_ROOM, ZG.ROOMS):
                break
            else:
                BRICK_ROOM = LOC(BRICK_ROOM)
        MOVE(ZG.EXPLOSION, BRICK_ROOM)
        FCLEAR(BRICK_ROOM, Flag('TOUCHBIT'))
        if (BRICK_ROOM == ZG.HERE):
            ZG.MUNG_ROOM(BRICK_ROOM, 'The way is blocked by debris from an explosion.')
            ZG.JIGS_UP(ZG.OTHER_PROPERTIES)
        elif (BRICK_ROOM == ZG.SAFE_ROOM):
            ENABLE(ZG.QUEUE(ZG.I_SAFE, 5))
            ZG.MUNGED_ROOM = ZG.SAFE_ROOM
            TELL('There is an explosion nearby.', CR)
            if IN_p(ZG.BRICK, ZG.SLOT):
                FSET(ZG.SLOT, Flag('INVISIBLE'))
                FSET(ZG.SAFE, Flag('OPENBIT'))
                FCLEAR(ZG.SAFE_ROOM, Flag('TOUCHBIT'))
                ZG.SAFE_FLAG = True
        else:
            TELL('There is an explosion nearby.', CR)
            ENABLE(ZG.QUEUE(ZG.I_SAFE, 5))
            ZG.MUNGED_ROOM = BRICK_ROOM
            if (F := FIRST_p(BRICK_ROOM)):
                while True:
                    if FSET_p(F, Flag('TAKEBIT')):
                        FSET(F, Flag('INVISIBLE'))
                    if (not (F := NEXT_p(F))):
                        break
        REMOVE(ZG.BRICK)
    elif (LOC(ZG.FUSE) in (ZG.WINNER, ZG.HERE)):
        TELL('The string rapidly burns into nothingness.', CR)
    return REMOVE(ZG.FUSE)

# zil: 2actions.zil:462  <ROUTINE I-SAFE ()>
@ZG.routine('I-SAFE')
def I_SAFE():
    if (ZG.HERE == ZG.MUNGED_ROOM):
        ZG.JIGS_UP('The room trembles and 5000 tons of rock fall on you, turning you\ninto a pancake.')
    elif (not ZG.DEAD):
        TELL('You may recall that recent explosion. Probably as a result of it, you\nhear an ominous rumbling, as if a nearby room had collapsed.', CR)
        if (ZG.MUNGED_ROOM == ZG.SAFE_ROOM):
            ENABLE(ZG.QUEUE(ZG.I_LEDGE, 8))
    return ZG.MUNG_ROOM(ZG.MUNGED_ROOM, 'The way is blocked by debris from an explosion.')

# zil: 2actions.zil:476  <ROUTINE I-LEDGE ("AUX" (RM ,LEDGE-2))>
@ZG.routine('I-LEDGE')
def I_LEDGE():
    RM = ZG.LEDGE_2
    if (ZG.HERE == ZG.LEDGE_2):
        if IN_p(ZG.WINNER, ZG.BALLOON):
            if ZG.BTIE_FLAG:
                ZG.BLOC = ZG.VOLCANO_BOTTOM
                REMOVE(ZG.BALLOON)
                MOVE(ZG.DEAD_BALLOON, ZG.VOLCANO_BOTTOM)
                ZG.BTIE_FLAG = False
                ZG.BINF_FLAG = False
                ZG.DISABLE(ZG.INT(ZG.I_BALLOON))
                ZG.DISABLE(ZG.INT(ZG.I_BURNUP))
                ZG.JIGS_UP('The ledge collapses, probably as a result of the explosion, and plummets\nto the ground far below. Sadly, you were still attached to the ledge.')
            else:
                TELL('The ledge collapses, leaving you with no place to land.', CR)
        else:
            ZG.JIGS_UP('The force of the recent explosion has caused the ledge to collapse.')
    elif (not ZG.DEAD):
        TELL('The ledge collapses. (That was a narrow escape!)', CR)
    return ZG.MUNG_ROOM(RM, 'The ledge has collapsed and cannot be landed on.')

# zil: 2actions.zil:500  <ROUTINE LEDGE-FCN (RARG)>
@ZG.routine('LEDGE-FCN')
def LEDGE_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are on a wide ledge high in the volcano. The rim of the volcano is\nabout 200 feet above and there is a precipitous drop to the bottom.')
        if FSET_p(ZG.SAFE_ROOM, Flag('RMUNGBIT')):
            return TELL(' The way to the south is blocked by rubble.', CR)
        else:
            return TELL(' There is a small door to the south.', CR)
    else:
        return False

# ;<ROUTINE BLAST () ;"APPARENTLY UNUSED?"
#     <COND (<EQUAL? ,HERE ,SAFE-ROOM>)
# 	  (T
# 	   <TELL "You must explain how to do that." CR>)>>

# zil: 2actions.zil:514  <ROUTINE I-GNOME ()>
@ZG.routine('I-GNOME')
def I_GNOME():
    if (ZG.HERE in (ZG.LEDGE_1, ZG.LEDGE_2)):
        TELL('A volcano gnome seems to walk straight out of the wall and ')
        if IN_p(ZG.WAND, ZG.WINNER):
            return TELL('noticing the wand, straight back in.', CR)
        else:
            TELL('says\n"I have a busy appointment schedule and little time to waste on\ntrespassers, but for a small fee I\'ll show you the way out." You\nnotice the gnome nervously glancing at his watch.', CR)
            return MOVE(ZG.GNOME, ZG.HERE)
    else:
        ENABLE(ZG.QUEUE(ZG.I_GNOME, 1))
        return False

# zil: 2actions.zil:532  <GLOBAL GNOME-FLAG>
# GLOBAL (state) GNOME_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:534  <ROUTINE GNOME-FCN ()>
@ZG.routine('GNOME-FCN')
def GNOME_FCN():
    if VERB_p('TELL'):
        ZG.P_CONT = False
        ZG.QUOTE_FLAG = False
        if (not ZG.GNOME_FLAG):
            ENABLE(ZG.QUEUE(ZG.I_NERVOUS, 5))
        ZG.GNOME_FLAG = True
        return TELL('The gnome appears increasingly nervous.', CR)
    elif (VERB_p('GIVE', 'THROW') and (ZG.PRSI == ZG.GNOME)):
        if GETPT(ZG.PRSO, 'VALUE'):
            TELL('"Thank you very much for the ', D, ZG.PRSO, '. I don\'t believe\nI\'ve ever seen one as beautiful. Follow me," he says, and a door\nappears on the west end of the ledge. Through the door, you can see\na narrow chimney sloping steeply downward. The gnome moves quickly,\nand disappears from sight.', CR)
            REMOVE(ZG.PRSO)
            REMOVE(ZG.GNOME)
            ZG.GNOME_DOOR_FLAG = True
            return ZG.GNOME_DOOR_FLAG
        elif ZG.BOMB_p(ZG.PRSO):
            MOVE(ZG.BRICK, ZG.HERE)
            REMOVE(ZG.GNOME)
            ZG.DISABLE(ZG.INT(ZG.I_GNOME))
            ZG.DISABLE(ZG.INT(ZG.I_NERVOUS))
            return TELL('"That certainly wasn\'t what I had in mind," he says, and disappears.', CR)
        else:
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            return TELL('"That wasn\'t quite what I had in mind," he says, crunching the\n', D, ZG.PRSO, ' in his rock-hard hands.', CR)
    else:
        TELL('The gnome appears increasingly nervous.', CR)
        if (not ZG.GNOME_FLAG):
            ENABLE(ZG.QUEUE(ZG.I_NERVOUS, 5))
        ZG.GNOME_FLAG = True
        return ZG.GNOME_FLAG

# zil: 2actions.zil:573  <ROUTINE I-NERVOUS ()>
@ZG.routine('I-NERVOUS')
def I_NERVOUS():
    if IN_p(ZG.GNOME, ZG.HERE):
        TELL('The gnome glances at his watch. "Oops. I\'m late for an\nappointment!" He disappears, leaving you alone on the ledge.', CR)
    return REMOVE(ZG.GNOME)

# zil: 2actions.zil:580  <ROUTINE PURPLE-BOOK-FCN ()>
@ZG.routine('PURPLE-BOOK-FCN')
def PURPLE_BOOK_FCN():
    if (VERB_p('READ') and IN_p(ZG.STAMP, ZG.PURPLE_BOOK) and (not FSET_p(ZG.PURPLE_BOOK, Flag('OPENBIT')))):
        TELL(GETP(ZG.PURPLE_BOOK, 'TEXT'), CR)
        ZG.PERFORM(SYMBOL('V?OPEN'), ZG.PURPLE_BOOK)
        return True
    else:
        return ZG.RANDOM_BOOK()

# zil: 2actions.zil:589  <ROUTINE RANDOM-BOOK ()>
@ZG.routine('RANDOM-BOOK')
def RANDOM_BOOK():
    if VERB_p('TAKE', 'MOVE', 'PUT'):
        FSET(ZG.WHITE_BOOK, Flag('TOUCHBIT'))
        FSET(ZG.PURPLE_BOOK, Flag('TOUCHBIT'))
        FSET(ZG.GREEN_BOOK, Flag('TOUCHBIT'))
        FSET(ZG.BLUE_BOOK, Flag('TOUCHBIT'))
        return False
    else:
        return False

# ; "SUBTITLE TOMB OF THE FLATHEADS"

# zil: 2actions.zil:599  <ROUTINE HEAD-FCN ()>
@ZG.routine('HEAD-FCN')
def HEAD_FCN():
    if VERB_p('HELLO'):
        return TELL('The Flatheads are dead; therefore they do not respond.', CR)
    elif VERB_p('KICK', 'ATTACK', 'RUB', 'OPEN', 'TAKE', 'BURN'):
        return ZG.JIGS_UP('Although the Flatheads are dead, they foresaw that some cretin\nmight tamper with their remains. Therefore, they took steps to\npunish such actions.')
    else:
        return False

# zil: 2actions.zil:608  <ROUTINE CRYPT-ANTEROOM-FCN (RARG)>
@ZG.routine('CRYPT-ANTEROOM-FCN')
def CRYPT_ANTEROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('The anteroom is large and empty. Marble bas reliefs depict the stirring\ntimes and afterlife of the Flatheads (the latter a bit optimistically).\nThe exit is to the west. A huge marble door stands to the south. ')
        TELL('The door is ')
        if FSET_p(ZG.CRYPT_DOOR, Flag('OPENBIT')):
            TELL('open.')
        else:
            TELL('closed.')
        return TELL(' Above the door is the cryptic inscription: "Feel Free".', CR)
    else:
        return False

# zil: 2actions.zil:621  <ROUTINE CRYPT-ROOM-FCN (RARG "AUX" CLIT?)>
@ZG.routine('CRYPT-ROOM-FCN')
def CRYPT_ROOM_FCN(RARG):
    CLIT_p = 0
    if (RARG == ZG.M_LOOK):
        FCLEAR(ZG.HERE, Flag('ONBIT'))
        if ZG.LIT_p(ZG.HERE):
            TELL('The room contains the earthly remains of the mighty Flatheads, twelve\nsomewhat flat heads mounted securely on poles. While the room might be\nexpected to contain funerary urns or other evidence of the ritual\npractices of the ancient Zorkers, it is empty of all such objects. There\nis writing carved on the crypt. The only apparent exit is to the north\nthrough the door to the anteroom. The door is ')
            if FSET_p(ZG.CRYPT_DOOR, Flag('OPENBIT')):
                TELL('open.')
            else:
                TELL('closed.')
            CRLF()
            if (not FSET_p(ZG.DIM_DOOR, Flag('INVISIBLE'))):
                TELL('Looking closely at the south wall, you can see the dim outline of\na secret door labelled with the letter "F".', CR)
        else:
            ZG.DIM_DOOR_APPEARS()
        FSET(ZG.HERE, Flag('ONBIT'))
        return True
    elif (RARG == ZG.M_END):
        CLIT_p = ZG.CRYPT_LIT_p
        FCLEAR(ZG.CRYPT_ROOM, Flag('ONBIT'))
        ZG.CRYPT_LIT_p = ZG.LIT_p(ZG.CRYPT_ROOM)
        if (CLIT_p and (not ZG.CRYPT_LIT_p)):
            ZG.DIM_DOOR_APPEARS()
        return FSET(ZG.CRYPT_ROOM, Flag('ONBIT'))
    else:
        return False

# zil: 2actions.zil:653  <GLOBAL CRYPT-LIT?>
# GLOBAL (state) CRYPT_LIT_p = True  ->  ZilGlobal.py

# zil: 2actions.zil:655  <ROUTINE DIM-DOOR-APPEARS ()>
@ZG.routine('DIM-DOOR-APPEARS')
def DIM_DOOR_APPEARS():
    TELL('It is dark, but on the south wall is a faint outline of a rectangle, as\nthough light were shining around a doorway. You can also make out a faintly\nglowing letter in the center of this area. It might be an "F".', CR)
    return FCLEAR(ZG.DIM_DOOR, Flag('INVISIBLE'))

# zil: 2actions.zil:662  <ROUTINE CRYPT-OBJECT ()>
@ZG.routine('CRYPT-OBJECT')
def CRYPT_OBJECT():
    if VERB_p('OPEN'):
        return TELL('The crypt is sealed for all time.', CR)
    elif VERB_p('RUB'):
        return TELL('The marble is cool.', CR)
    else:
        return False

# zil: 2actions.zil:666  <ROUTINE CRYPT-DOOR-FCN ()>
@ZG.routine('CRYPT-DOOR-FCN')
def CRYPT_DOOR_FCN():
    if VERB_p('OPEN', 'CLOSE'):
        return ZG.OPEN_CLOSE(ZG.PRSO, 'The crypt door squeaks open.', 'The crypt door squeaks closed.')
    else:
        return False

# zil: 2actions.zil:672  <ROUTINE TOMB-PSEUDO ()>
@ZG.routine('TOMB-PSEUDO')
def TOMB_PSEUDO():
    if VERB_p('THROUGH'):
        ZG.DO_WALK('EAST')
        return True
    else:
        return False

# zil: 2actions.zil:677  <GLOBAL DIM-DOOR-FLAG>
# GLOBAL (state) DIM_DOOR_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:679  <ROUTINE DIM-DOOR-FCN ()>
@ZG.routine('DIM-DOOR-FCN')
def DIM_DOOR_FCN():
    if VERB_p('KNOCK'):
        return TELL('A hollow echo responds.', CR)
    elif VERB_p('OPEN', 'CLOSE'):
        if VERB_p('OPEN'):
            ZG.DIM_DOOR_FLAG = True
        else:
            ZG.DIM_DOOR_FLAG = False
        return ZG.OPEN_CLOSE(ZG.PRSO, 'The secret door opens noiselessly.', 'The secret door closes noiselessly.')
    else:
        return False

# zil: 2actions.zil:688  <ROUTINE REPELLENT-FCN ()>
@ZG.routine('REPELLENT-FCN')
def REPELLENT_FCN():
    if VERB_p('SHAKE'):
        if ZG.SPRAY_USED_p:
            return TELL('The can seems empty.', CR)
        else:
            return TELL('There is a sloshing sound from inside.', CR)
    elif (VERB_p('SPRAY', 'PUT') and (ZG.PRSO == ZG.REPELLENT)):
        if ZG.SPRAY_USED_p:
            return TELL('The repellent is all gone.', CR)
        elif (not ZG.PRSI):
            ZG.SPRAY_USED_p = True
            return TELL('The spray stinks amazingly for a few moments, then drifts away.', CR)
        else:
            if (ZG.PRSI == ZG.ME):
                ENABLE(ZG.QUEUE(ZG.I_SPRAY, 8))
                ZG.SPRAYED_p = True
            ZG.SPRAY_USED_p = True
            return TELL("The spray smells like a mixture of old socks and burning rubber. If\nI were a grue I'd sure stay clear!", CR)
    else:
        return False

# zil: 2actions.zil:709  <GLOBAL SPRAY-USED?>
# GLOBAL (state) SPRAY_USED_p = False  ->  ZilGlobal.py

# zil: 2actions.zil:711  <ROUTINE I-SPRAY ()>
@ZG.routine('I-SPRAY')
def I_SPRAY():
    ZG.SPRAYED_p = False
    return TELL('That horrible smell is much less pungent now.', CR)

# zil: 2actions.zil:715  <ROUTINE ZORK3-FCN (RARG)>
@ZG.routine('ZORK3-FCN')
def ZORK3_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('Beyond the door is a roughly hewn staircase leading down into darkness.\nThe landing on which you stand is covered with carefully drawn magical runes\nlike those sketched upon the workbench of the Wizard of Frobozz.\nThese have been overlaid with sweeping green lines of enormous power, which\nundulate back and forth across the landing. ')
        if IN_p(ZG.WAND, ZG.WINNER):
            TELL('The wand begins to vibrate in harmony with the motion of the lines.\nYou feel yourself compelled downward, and you yield, stepping onto the\nstaircase. As you pass the green lines, they flare and disappear with a\nburst of light, and you tumble down the staircase!\n\nAt the bottom, a vast red-lit hall stretches off into the distance.\nSinister statues guard the entrance to a dimly visible room far ahead.\nWith courage and cunning you have conquered the Wizard of Frobozz and\nbecome the master of his domain, but the final challenge awaits!\n\n(The ultimate adventure concludes in "Zork III: The Dungeon Master".)\n\n', CR)
            ZG.WON_FLAG = True
            return ZG.FINISH()
        else:
            return ZG.JIGS_UP('The green curves begin to vibrate toward you, as if searching for\nsomething. One by one your possessions glow bright green. Finally, you\nare attacked by these magical wardens, and destroyed!')
    else:
        return False

# ;"SUBTITLE A DROP IN THE BUCKET"

# zil: 2actions.zil:750  <GLOBAL BUCKET-TOP-FLAG>
# GLOBAL (state) BUCKET_TOP_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:752  <GLOBAL EVAPORATED>
# GLOBAL (state) EVAPORATED = False  ->  ZilGlobal.py

# zil: 2actions.zil:754  <ROUTINE I-BUCKET ()>
@ZG.routine('I-BUCKET')
def I_BUCKET():
    if IN_p(ZG.WATER, ZG.BUCKET):
        ZG.EVAPORATED = True
        REMOVE(ZG.WATER)
    return False

# zil: 2actions.zil:760  <ROUTINE WATER-FCN ("AUX" AV W PI?)>
@ZG.routine('WATER-FCN')
def WATER_FCN():
    AV = 0
    W = 0
    PI_p = 0
    if VERB_p('SGIVE'):
        return False
    elif VERB_p('THROUGH'):
        ZG.PERFORM(SYMBOL('V?SWIM'), ZG.PRSO)
        return True
    elif VERB_p('FILL'):
        W = ZG.PRSI
        ZG.PRSA = SYMBOL('V?PUT')
        ZG.PRSI = ZG.PRSO
        ZG.PRSO = W
        PI_p = False
    elif (ZG.PRSO in (ZG.GLOBAL_WATER, ZG.WATER)):
        W = ZG.PRSO
        PI_p = False
    elif ZG.PRSI:
        W = ZG.PRSI
        PI_p = True
    if (W == ZG.GLOBAL_WATER):
        W = ZG.WATER
        if VERB_p('TAKE', 'PUT'):
            REMOVE(W)
    if PI_p:
        ZG.PRSI = W
    else:
        ZG.PRSO = W
    AV = LOC(ZG.WINNER)
    if (not FSET_p(AV, Flag('VEHBIT'))):
        AV = False
    if (VERB_p('TAKE', 'PUT') and (not PI_p)):
        if (AV and (AV == ZG.PRSI)):
            return ZG.PUDDLE(AV)
        elif (AV and (not ZG.PRSI) and (not IN_p(W, AV))):
            return ZG.PUDDLE(AV)
        elif (ZG.PRSI and (not (ZG.PRSI == ZG.TEAPOT))):
            TELL('The water leaks out of the ', D, ZG.PRSI, ' and evaporates immediately.', CR)
            return REMOVE(W)
        elif IN_p(ZG.TEAPOT, ZG.WINNER):
            if (not FIRST_p(ZG.TEAPOT)):
                if (ZG.HERE == ZG.POOL_ROOM):
                    MOVE(ZG.SALTY_WATER, ZG.TEAPOT)
                else:
                    MOVE(ZG.WATER, ZG.TEAPOT)
                return TELL('The teapot is now full of water.', CR)
            else:
                TELL("The teapot isn't currently empty.", CR)
                return True
        elif (IN_p(ZG.PRSO, ZG.TEAPOT) and VERB_p('TAKE') and (not ZG.PRSI)):
            ZG.PRSO = ZG.TEAPOT
            ZG.ITAKE()
            ZG.PRSO = W
            return ZG.PRSO
        else:
            return TELL('The water slips through your fingers.', CR)
    elif PI_p:
        return TELL('Nice try.', CR)
    elif VERB_p('DROP', 'GIVE'):
        if ((ZG.PRSO == ZG.WATER) and (not ZG.HELD_p(ZG.WATER))):
            TELL("You don't have any water.", CR)
            return True
        REMOVE(ZG.WATER)
        if AV:
            return ZG.PUDDLE(AV)
        else:
            TELL('The water spills to the floor and evaporates.', CR)
            return REMOVE(ZG.WATER)
    elif VERB_p('THROW'):
        TELL('The water splashes on the walls and evaporates.', CR)
        return REMOVE(ZG.WATER)
    else:
        return False

# zil: 2actions.zil:830  <ROUTINE PUDDLE (AV)>
@ZG.routine('PUDDLE')
def PUDDLE(AV):
    TELL('There is now a puddle in the bottom of the ', D, AV, '.', CR)
    return MOVE(ZG.PRSO, AV)

# zil: 2actions.zil:834  <ROUTINE BUCKET-FCN ("OPTIONAL" (RARG ,M-BEG))>
@ZG.routine('BUCKET-FCN')
def BUCKET_FCN(RARG=None):
    if RARG is None:
        RARG = ZG.M_BEG
    if (RARG == ZG.M_BEG):
        if (VERB_p('BURN') and (ZG.PRSO == ZG.BUCKET)):
            return TELL("The bucket is fireproof, and won't burn.", CR)
        elif (VERB_p('DROP', 'PUT') and (ZG.PRSO == ZG.WATER) and (ZG.PRSI == ZG.BUCKET) and IN_p(ZG.BUCKET, ZG.WELL_BOTTOM) and (not IN_p(ZG.WINNER, ZG.BUCKET))):
            TELL('The bucket swiftly rises up, and is gone.', CR)
            MOVE(ZG.BUCKET, ZG.WELL_TOP)
            MOVE(ZG.WATER, ZG.BUCKET)
            ZG.BUCKET_TOP_FLAG = True
            ENABLE(ZG.QUEUE(ZG.I_BUCKET, 100))
            return True
        elif VERB_p('KICK'):
            return ZG.JIGS_UP('If you insist.')
        else:
            return False
    elif (RARG == ZG.M_END):
        if (IN_p(ZG.WATER, ZG.BUCKET) and (not ZG.BUCKET_TOP_FLAG)):
            TELL('The bucket rises and comes to a stop.', CR, CR)
            ZG.BUCKET_TOP_FLAG = True
            ZG.EVAPORATED = False
            ZG.PASS_THE_BUCKET(ZG.WELL_TOP)
            ENABLE(ZG.QUEUE(ZG.I_BUCKET, 100))
            return True
        elif (ZG.BUCKET_TOP_FLAG and (not IN_p(ZG.WATER, ZG.BUCKET))):
            if ZG.EVAPORATED:
                TELL('The last of the water evaporates, and the bucket descends.', CR, CR)
            else:
                TELL('The bucket descends and comes to a stop.', CR, CR)
            ZG.BUCKET_TOP_FLAG = False
            return ZG.PASS_THE_BUCKET(ZG.WELL_BOTTOM)
        else:
            return False
    elif VERB_p('CLIMB-ON'):
        ZG.PERFORM(SYMBOL('V?BOARD'), ZG.PRSO)
        return True
    else:
        return False

# zil: 2actions.zil:876  <ROUTINE PASS-THE-BUCKET (R)>
@ZG.routine('PASS-THE-BUCKET')
def PASS_THE_BUCKET(R):
    MOVE(ZG.BUCKET, R)
    if IN_p(ZG.WINNER, ZG.BUCKET):
        return ZG.GOTO(R)
    else:
        return False

# ;"SUBTITLE CHOMPERS IN WONDERLAND"

# zil: 2actions.zil:886  <ROUTINE POSTS-ROOM-FCN (RARG)>
@ZG.routine('POSTS-ROOM-FCN')
def POSTS_ROOM_FCN(RARG):
    if (RARG == ZG.M_BEG):
        if (VERB_p('TAKE') and FSET_p(ZG.PRSO, Flag('NONLANDBIT'))):
            return TELL('The ', D, ZG.PRSO, ' is now much larger than you are. You have no hope of\ntaking it.', CR)
        else:
            return False
    else:
        return False

# zil: 2actions.zil:893  <ROUTINE EATME-FCN ("AUX" F N)>
@ZG.routine('EATME-FCN')
def EATME_FCN():
    F = 0
    N_l = 0
    if (VERB_p('EAT') and (ZG.PRSO == ZG.EAT_ME_CAKE) and (ZG.HERE == ZG.TEA_ROOM)):
        TELL('Suddenly, the room appears to have become very large (although\neverything you are carrying seems to be its normal size).', CR, CR)
        REMOVE(ZG.EAT_ME_CAKE)
        FSET(ZG.ROBOT, Flag('INVISIBLE'))
        FSET(ZG.ALICE_TABLE, Flag('INVISIBLE'))
        F = FIRST_p(ZG.HERE)
        while True:
            if (not F):
                break
            else:
                N_l = NEXT_p(F)
                if ((not (F == ZG.ADVENTURER)) and FSET_p(F, Flag('TAKEBIT'))):
                    FSET(F, Flag('NONLANDBIT'))
                    FSET(F, Flag('TRYTAKEBIT'))
                    MOVE(F, ZG.POSTS_ROOM)
            F = N_l
        return ZG.GOTO(ZG.POSTS_ROOM)
    else:
        return ZG.CAKE_CRUMBLE()

# zil: 2actions.zil:917  <ROUTINE CAKE-CRUMBLE ("AUX" CAKE)>
@ZG.routine('CAKE-CRUMBLE')
def CAKE_CRUMBLE():
    CAKE = 0
    if FSET_p(ZG.PRSO, Flag('FOODBIT')):
        CAKE = ZG.PRSO
    else:
        CAKE = ZG.PRSI
    if ((ZG.HERE in (ZG.TEA_ROOM, ZG.POSTS_ROOM, ZG.POOL_ROOM)) or (ZG.HERE in (ZG.MACHINE_ROOM, ZG.MAGNET_ROOM, ZG.CAGE_ROOM)) or (ZG.HERE in (ZG.WELL_TOP, ZG.IN_CAGE))):
        return False
    else:
        REMOVE(CAKE)
        return TELL('The ', D, CAKE, ' has crumbled to dust.', CR)

# zil: 2actions.zil:929  <ROUTINE CAKE-FCN ("AUX" F N)>
@ZG.routine('CAKE-FCN')
def CAKE_FCN():
    F = 0
    N_l = 0
    if VERB_p('READ'):
        if FSET_p(ZG.PRSO, Flag('NONLANDBIT')):
            return TELL('The cake is much too tall now for you to read the lettering.', CR)
        elif ZG.PRSI:
            if (ZG.PRSI in (ZG.PALANTIR_1, ZG.PALANTIR_2, ZG.PALANTIR_3)):
                return ZG.PERFORM(SYMBOL('V?LOOK-INSIDE'), ZG.PRSI)
            elif (ZG.PRSI == ZG.FLASK):
                TELL('The letters, now visible, say "')
                if (ZG.PRSO == ZG.RED_ICING):
                    TELL('Evaporate')
                elif (ZG.PRSO == ZG.ORANGE_ICING):
                    TELL('Explode')
                else:
                    TELL('Enlarge')
                return TELL('".', CR)
            else:
                return TELL("You can't see through that!", CR)
        else:
            return TELL('The first letter is a capital E. The rest is too small to read.', CR)
    elif (VERB_p('EAT') and (ZG.HERE in (ZG.TEA_ROOM, ZG.POSTS_ROOM, ZG.POOL_ROOM))):
        if (ZG.PRSO == ZG.ORANGE_ICING):
            REMOVE(ZG.PRSO)
            return ZG.ICEBOOM()
        elif (ZG.PRSO == ZG.RED_ICING):
            REMOVE(ZG.PRSO)
            return ZG.JIGS_UP('That was delicious, but your dying memory is of feeling horribly dehydrated\nand thirsty.')
        elif (ZG.PRSO == ZG.BLUE_ICING):
            REMOVE(ZG.PRSO)
            TELL('The room around you seems to be getting smaller.', CR, CR)
            if (ZG.HERE == ZG.POSTS_ROOM):
                FCLEAR(ZG.ROBOT, Flag('INVISIBLE'))
                FCLEAR(ZG.ALICE_TABLE, Flag('INVISIBLE'))
                FSET(ZG.POSTS, Flag('INVISIBLE'))
                F = FIRST_p(ZG.HERE)
                while True:
                    if (not F):
                        break
                    else:
                        N_l = NEXT_p(F)
                        if ((not (F == ZG.ADVENTURER)) and FSET_p(F, Flag('TAKEBIT'))):
                            FCLEAR(F, Flag('NONLANDBIT'))
                            FCLEAR(F, Flag('TRYTAKEBIT'))
                            MOVE(F, ZG.TEA_ROOM)
                    F = N_l
                return ZG.GOTO(ZG.TEA_ROOM)
            else:
                return ZG.JIGS_UP('The room seems to have become too small to hold you. The walls are not as\ncompressible as your body, which is demolished.')
        else:
            return False
    elif (VERB_p('THROW', 'PUT') and (ZG.PRSO == ZG.ORANGE_ICING) and (ZG.HERE in (ZG.TEA_ROOM, ZG.POSTS_ROOM, ZG.POOL_ROOM))):
        REMOVE(ZG.PRSO)
        return ZG.ICEBOOM()
    elif (VERB_p('THROW', 'PUT') and (ZG.PRSO in (ZG.RED_ICING, ZG.BLUE_ICING, ZG.ORANGE_ICING)) and (ZG.PRSI == ZG.POOL)):
        if (ZG.PRSO in (ZG.BLUE_ICING, ZG.ORANGE_ICING)):
            TELL('The cake sinks majestically into the pool.', CR)
            REMOVE(ZG.PRSO)
            return True
        MOVE(ZG.PRSO, ZG.HERE)
        REMOVE(ZG.PRSI)
        TELL('Most of the pool evaporates, revealing a (slightly damp but\nstill valuable) package of rare candies. The red cake must be\npretty strong stuff, since it remains intact!', CR)
        return FCLEAR(ZG.CANDY, Flag('INVISIBLE'))
    else:
        return ZG.CAKE_CRUMBLE()

# zil: 2actions.zil:1003  <ROUTINE CANDY-FCN ()>
@ZG.routine('CANDY-FCN')
def CANDY_FCN():
    if VERB_p('EXAMINE', 'READ'):
        ZG.FIXED_FONT_ON()
        TELL('       Frobozz Magic Candy Company\n         >>Special Assortment<<\n          Candied Grasshoppers\n             Chocolated Ants\n              Worms Glacee\n(By Appointment to His Majesty, Dimwit I)\n')
        ZG.FIXED_FONT_OFF()
        return True
    elif VERB_p('EAT', 'OPEN'):
        return TELL('Such rich food would probably not be good for you.', CR)
    else:
        return False

# zil: 2actions.zil:1020  <ROUTINE TOP-ETCHINGS-F ()>
@ZG.routine('TOP-ETCHINGS-F')
def TOP_ETCHINGS_F():
    if VERB_p('EXAMINE', 'READ'):
        ZG.FIXED_FONT_ON()
        TELL('       o  b  o\n   r             z\nf   M  A  G  I  C   z\nc    W  E   L  L    y\n   o             n\n       m  p  a\n')
        ZG.FIXED_FONT_OFF()
        return True
    else:
        return False

# zil: 2actions.zil:1034  <ROUTINE BOTTOM-ETCHINGS-F ()>
@ZG.routine('BOTTOM-ETCHINGS-F')
def BOTTOM_ETCHINGS_F():
    if VERB_p('EXAMINE', 'READ'):
        ZG.FIXED_FONT_ON()
        TELL('       o  b  o\n\n       A  G  I\n        E   L\n\n       m  p  a\n')
        ZG.FIXED_FONT_OFF()
        return True
    else:
        return False

# zil: 2actions.zil:1048  <ROUTINE CUBE-F ()>
@ZG.routine('CUBE-F')
def CUBE_F():
    if VERB_p('EXAMINE', 'READ'):
        ZG.FIXED_FONT_ON()
        TELL('              Bank of Zork\n                   VAULT\n                 *722 GUE*\n        Frobozz Magic Vault Company\n')
        ZG.FIXED_FONT_OFF()
        return True
    else:
        return False

# zil: 2actions.zil:1060  <ROUTINE FIXED-FONT-ON ()>
@ZG.routine('FIXED-FONT-ON')
def FIXED_FONT_ON():
    return PUT(0, 8, (GET(0, 8) | 2))

# zil: 2actions.zil:1062  <ROUTINE FIXED-FONT-OFF ()>
@ZG.routine('FIXED-FONT-OFF')
def FIXED_FONT_OFF():
    return PUT(0, 8, (GET(0, 8) & -3))

# zil: 2actions.zil:1064  <ROUTINE POOL-FCN ()>
@ZG.routine('POOL-FCN')
def POOL_FCN():
    if VERB_p('DRINK'):
        return TELL('The water is extremely salty.', CR)
    elif VERB_p('LOOK-UNDER'):
        return TELL("You'd probably have to enter the pool to see what's below the surface.", CR)
    elif VERB_p('THROUGH'):
        return ZG.JIGS_UP('You enter the pool, thrash around for a good while, and then drown.\nSad, but true.')
    else:
        return False

# zil: 2actions.zil:1076  <ROUTINE FLASK-FCN ()>
@ZG.routine('FLASK-FCN')
def FLASK_FCN():
    if VERB_p('LOOK-INSIDE'):
        return TELL('You notice that objects behind the flask appear to be magnified.\nYou might try looking at something through the flask.', CR)
    elif (VERB_p('READ') and (ZG.PRSI == ZG.FLASK)):
        TELL('The flask distorts and magnifies the ', D, ZG.PRSO, ', showing details\nnot noticed earlier.', CR)
        return False
    elif VERB_p('OPEN'):
        ZG.MUNG_ROOM(ZG.HERE, 'Noxious vapors prevent your entry.')
        return ZG.JIGS_UP(ZG.FATAL_VAPORS)
    elif VERB_p('MUNG', 'THROW'):
        TELL('The flask breaks into pieces.', CR)
        REMOVE(ZG.PRSO)
        return ZG.JIGS_UP(ZG.FATAL_VAPORS)
    else:
        return False

# zil: 2actions.zil:1094  <GLOBAL FATAL-VAPORS>
# GLOBAL (state) FATAL_VAPORS = "As you pass out, you realize that the vapors from the\nflask's contents are fatal."  ->  ZilGlobal.py

# zil: 2actions.zil:1098  <ROUTINE PLEAK ()>
@ZG.routine('PLEAK')
def PLEAK():
    if VERB_p('TAKE'):
        return TELL(ZG.PICK_ONE(ZG.YUKS), CR)
    elif VERB_p('PLUG'):
        return TELL('The leak is too high above you to reach.', CR)
    else:
        return False

# zil: 2actions.zil:1104  <ROUTINE ICEBOOM ()>
@ZG.routine('ICEBOOM')
def ICEBOOM():
    ZG.MUNG_ROOM(ZG.HERE, 'The entrance is blocked by sticky orange rubble. Probably some careless\nadventurer was playing with blasting cakes.')
    return ZG.JIGS_UP('You have been blasted to smithereens (wherever they are).')

# zil: 2actions.zil:1111  <ROUTINE MAGNET-ROOM-FCN (RARG)>
@ZG.routine('MAGNET-ROOM-FCN')
def MAGNET_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        return TELL('You are in a circular room with a low ceiling. There are exits to\nthe east and southeast.', CR)
    elif ((RARG == ZG.M_ENTER) and ZG.CAROUSEL_FLIP_FLAG):
        if ZG.CAROUSEL_ZOOM_FLAG:
            if (ZG.ADVENTURER == ZG.WINNER):
                _tmp1 = "According to Prof. TAA of GUE Tech, the rapidly changing magnetic\nfields in the room are intense enough to electrocute you.\nI really don't know, but in any event, something just killed you."
            else:
                _tmp1 = "According to Prof. TAA of GUE Tech, the magnetic fields in the room are\nintense enough to fry the delicate innards of the robot. I really don't\nknow, but in any event, smoke pours from its ears and it has stopped moving."
            if (ZG.ADVENTURER == ZG.WINNER):
                _tmp2 = "According to Prof. TAA of GUE Tech, the rapidly changing magnetic\nfields in the room are intense enough to electrocute you.\nI really don't know, but in any event, something just killed you."
            else:
                _tmp2 = "According to Prof. TAA of GUE Tech, the magnetic fields in the room are\nintense enough to fry the delicate innards of the robot. I really don't\nknow, but in any event, smoke pours from its ears and it has stopped moving."
            return ZG.JIGS_UP(_tmp2)
        elif (ZG.WINNER == ZG.ADVENTURER):
            TELL('As you enter, your compass starts spinning wildly.', CR)
            if (not ZG.COMPASS_KLUDGE):
                TELL('What compass, you ask? The one which allows you to specify compass directions\nfor movement.')
                ZG.COMPASS_KLUDGE = True
            return CRLF()
        else:
            return False
    else:
        return False

# zil: 2actions.zil:1137  <GLOBAL COMPASS-KLUDGE>
# GLOBAL (state) COMPASS_KLUDGE = False  ->  ZilGlobal.py

# zil: 2actions.zil:1139  <ROUTINE MAGNET-ROOM-EXIT ()>
@ZG.routine('MAGNET-ROOM-EXIT')
def MAGNET_ROOM_EXIT():
    if (ZG.CAROUSEL_FLIP_FLAG and (ZG.WINNER == ZG.ADVENTURER)):
        TELL('You cannot get your bearings...', CR, CR)
        if ZG.PROB(50):
            return ZG.MACHINE_ROOM
        else:
            return ZG.TEA_ROOM
    elif (ZG.PRSO == 'EAST'):
        return ZG.MACHINE_ROOM
    elif ((ZG.PRSO == 'SE') or (ZG.PRSO == 'OUT')):
        return ZG.TEA_ROOM
    else:
        TELL("You can't go that way.", CR)
        return False

# zil: 2actions.zil:1155  <GLOBAL CAROUSEL-ZOOM-FLAG>
# GLOBAL (state) CAROUSEL_ZOOM_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1157  <GLOBAL CAROUSEL-FLIP-FLAG>
# GLOBAL (state) CAROUSEL_FLIP_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1159  <ROUTINE BUTTONS ()>
@ZG.routine('BUTTONS')
def BUTTONS():
    if VERB_p('PUSH'):
        if (ZG.WINNER == ZG.ADVENTURER):
            return ZG.JIGS_UP('There is a giant spark and you are fried to a crisp.')
        elif (ZG.PRSO == ZG.SQUARE_BUTTON):
            if ZG.CAROUSEL_ZOOM_FLAG:
                return TELL('Nothing seems to happen.', CR)
            else:
                ZG.CAROUSEL_ZOOM_FLAG = True
                return TELL('The whirring increases in intensity.', CR)
        elif (ZG.PRSO == ZG.ROUND_BUTTON):
            if ZG.CAROUSEL_ZOOM_FLAG:
                ZG.CAROUSEL_ZOOM_FLAG = False
                return TELL('The whirring decreases in intensity.', CR)
            else:
                return TELL('Nothing seems to happen.', CR)
        elif (ZG.PRSO == ZG.TRIANGULAR_BUTTON):
            ZG.CAROUSEL_FLIP_FLAG = (not ZG.CAROUSEL_FLIP_FLAG)
            if IN_p(ZG.IRON_BOX, ZG.CAROUSEL_ROOM):
                TELL('A dull thump is heard in the distance.', CR)
                if FSET_p(ZG.IRON_BOX, Flag('INVISIBLE')):
                    FCLEAR(ZG.IRON_BOX, Flag('INVISIBLE'))
                else:
                    FSET(ZG.IRON_BOX, Flag('INVISIBLE'))
                if (not FSET_p(ZG.IRON_BOX, Flag('INVISIBLE'))):
                    FCLEAR(ZG.CAROUSEL_ROOM, Flag('TOUCHBIT'))
                return True
            else:
                return TELL('Click.', CR)
        else:
            return False
    else:
        return False

# zil: 2actions.zil:1190  <GLOBAL CAGE-SOLVE-FLAG>
# GLOBAL (state) CAGE_SOLVE_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1192  <ROUTINE SPHERE-FCN ("AUX" FL)>
@ZG.routine('SPHERE-FCN')
def SPHERE_FCN():
    FL = 0
    if ((not ZG.CAGE_SOLVE_FLAG) and VERB_p('TAKE', 'MOVE', 'PUT')):
        FL = True
    else:
        FL = False
    if (FL and (ZG.ADVENTURER == ZG.WINNER)):
        TELL('As you reach for the sphere, a solid steel cage falls from the ceiling\nto entrap you. To make matters worse, poisonous gas starts coming\ninto the room.', CR, CR)
        if IN_p(ZG.ROBOT, ZG.HERE):
            MOVE(ZG.ROBOT, ZG.IN_CAGE)
            FSET(ZG.ROBOT, Flag('NDESCBIT'))
        ZG.GOTO(ZG.IN_CAGE)
        MOVE(ZG.CAGE, ZG.HERE)
        FSET(ZG.CAGE, Flag('NDESCBIT'))
        FCLEAR(ZG.CAGE, Flag('INVISIBLE'))
        ENABLE(ZG.QUEUE(ZG.I_SPHERE, 6))
        return True
    elif FL:
        FSET(ZG.PALANTIR_1, Flag('INVISIBLE'))
        REMOVE(ZG.ROBOT)
        FSET(ZG.PRSO, Flag('INVISIBLE'))
        MOVE(ZG.CAGE, ZG.CAGE_ROOM)
        FCLEAR(ZG.CAGE, Flag('INVISIBLE'))
        ZG.JIGS_UP('As the robot reaches for the sphere, a solid steel cage falls from the\nceiling, trapping him. You can faintly hear his last words: "Whirr,\nbuzz, click!" A cloud of smoke rising from beneath the cage confirms\nyour fears about the fate of your brave mechanical friend.')
        return True
    elif VERB_p('LOOK-INSIDE', 'EXAMINE'):
        return ZG.PALANTIR()
    else:
        return False

# zil: 2actions.zil:1226  <ROUTINE I-SPHERE ()>
@ZG.routine('I-SPHERE')
def I_SPHERE():
    if (ZG.HERE in (ZG.CAGE_ROOM, ZG.IN_CAGE)):
        FSET(ZG.PALANTIR_1, Flag('INVISIBLE'))
        ZG.MUNG_ROOM(ZG.CAGE_ROOM, 'You are stopped by a cloud of poisonous gas.')
        return ZG.JIGS_UP('Time passes...and you die from some obscure poisoning.')
    else:
        return False

# zil: 2actions.zil:1234  <ROUTINE IN-CAGE-FCN (RARG)>
@ZG.routine('IN-CAGE-FCN')
def IN_CAGE_FCN(RARG):
    if ZG.CAGE_SOLVE_FLAG:
        ZG.HERE = ZG.CAGE_ROOM
        return ZG.HERE
    else:
        return False

# zil: 2actions.zil:1237  <ROUTINE ROBOT-FCN ("OPTIONAL" (RARG ,M-OBJECT))>
@ZG.routine('ROBOT-FCN')
def ROBOT_FCN(RARG=None):
    if RARG is None:
        RARG = ZG.M_OBJECT
    if (ZG.WINNER == ZG.ROBOT):
        if VERB_p('SGIVE'):
            return False
        elif VERB_p('FOLLOW'):
            return TELL('"My memory circuits are not that advanced. I can move as directed,\nthough."', CR)
        elif (VERB_p('RAISE', 'TAKE', 'MOVE') and (ZG.PRSO == ZG.CAGE)):
            TELL("The cage shakes and is hurled across the room. It's hard to\nsay, but the robot appears to be smiling.", CR, CR)
            ZG.DISABLE(ZG.INT(ZG.I_SPHERE))
            ZG.WINNER = ZG.ADVENTURER
            ZG.GOTO(ZG.CAGE_ROOM)
            MOVE(ZG.MANGLED_CAGE, ZG.CAGE_ROOM)
            FCLEAR(ZG.ROBOT, Flag('NDESCBIT'))
            FSET(ZG.PALANTIR_1, Flag('TAKEBIT'))
            MOVE(ZG.ROBOT, ZG.CAGE_ROOM)
            ZG.CAGE_SOLVE_FLAG = True
            return ZG.CAGE_SOLVE_FLAG
        elif VERB_p('EAT', 'DRINK'):
            if IN_p(ZG.ADVENTURER, ZG.HERE):
                TELL('"I am sorry but that is difficult for a being with no mouth."', CR)
            return True
        elif (ZG.PROB(2) and (ZG.META_LOC(ZG.ADVENTURER) == ZG.HERE)):
            return TELL('"Buzz! Buzz! Buzz! My circuits are getting rusty. Try again."', CR)
        elif VERB_p('READ', 'EXAMINE'):
            if (ZG.META_LOC(ZG.ADVENTURER) == ZG.HERE):
                TELL('"My vision is not sufficiently acute to do that."', CR)
            return True
        elif VERB_p('DROP', 'PUT', 'THROW'):
            if (not (ZG.META_LOC(ZG.ADVENTURER) == ZG.HERE)):
                return False
            elif IN_p(ZG.PRSO, ZG.ROBOT):
                TELL('"Whirr, buzz, click!"', CR)
                return False
            else:
                return TELL('"Click! I don\'t have that. Buzz! Whirr!"', CR)
        elif (VERB_p('WALK') or (VERB_p('TAKE', 'PUSH', 'TURN') and (not FSET_p(ZG.PRSO, Flag('ACTORBIT'))))):
            if (not (ZG.META_LOC(ZG.ADVENTURER) == ZG.HERE)):
                return False
            elif ZG.PROB(80):
                TELL('"Whirr, buzz, click!"', CR)
            else:
                TELL('"Buzz, click, whirr!"', CR)
            return False
        else:
            if (ZG.META_LOC(ZG.ADVENTURER) == ZG.HERE):
                TELL('"My programming is insufficient to allow me to perform that task."', CR)
            return True
    elif VERB_p('OPEN', 'LOOK-INSIDE', 'CLOSE'):
        return TELL("There's no access panel or door on the robot.", CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.ROBOT)):
        MOVE(ZG.PRSO, ZG.ROBOT)
        return TELL('The robot gladly takes the ', D, ZG.PRSO, ' and nods his head-like appendage in thanks.', CR)
    elif VERB_p('THROW', 'MUNG'):
        TELL('The robot falls to the ground and (being of shoddy construction)\ndisintegrates before your eyes.', CR)
        if VERB_p('THROW'):
            _tmp1 = ZG.PRSI
        elif (_tmp1 := ZG.PRSO):
            pass
        else:
            _tmp1 = False
        if VERB_p('THROW'):
            _tmp2 = ZG.PRSI
        elif (_tmp2 := ZG.PRSO):
            pass
        else:
            _tmp2 = False
        return REMOVE(_tmp2)
    else:
        return False

# ;"SUBTITLE BANK OF ZORK"

# zil: 2actions.zil:1312  <GLOBAL BANK-SOLVE-FLAG>
# GLOBAL (state) BANK_SOLVE_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1314  <ROUTINE BILLS-OBJECT ()>
@ZG.routine('BILLS-OBJECT')
def BILLS_OBJECT():
    ZG.BANK_SOLVE_FLAG = True
    if VERB_p('BURN'):
        TELL('Nothing like having money to burn!', CR)
        return False
    elif VERB_p('EAT'):
        return TELL('Talk about eating rich foods!', CR)
    else:
        return False

# zil: 2actions.zil:1322  <ROUTINE BKLEAVEE ("OPTIONAL" (RM ,TELLER-EAST))>
@ZG.routine('BKLEAVEE')
def BKLEAVEE(RM=None):
    if RM is None:
        RM = ZG.TELLER_EAST
    if (ZG.HELD_p(ZG.BILLS) or ZG.HELD_p(ZG.PORTRAIT)):
        TELL('An alarm rings briefly, and an invisible force bars your way.', CR)
        return False
    else:
        return RM

# zil: 2actions.zil:1330  <ROUTINE BKLEAVEW ()>
@ZG.routine('BKLEAVEW')
def BKLEAVEW():
    return ZG.BKLEAVEE(ZG.TELLER_WEST)

# zil: 2actions.zil:1333  <GLOBAL SCOL-ROOMS>
# GLOBAL (state) SCOL_ROOMS = LTABLE('EAST', ZG.VIEWING_EAST, 'WEST', ZG.VIEWING_WEST, 'NORTH', ZG.SMALL_ROOM, 'SOUTH', ZG.VAULT)  ->  ZilGlobal.py

# zil: 2actions.zil:1343  <GLOBAL SCOL-WALLS>
# GLOBAL (state) SCOL_WALLS = TABLE(ZG.VIEWING_WEST, ZG.SEWL, ZG.VIEWING_WEST, ZG.VIEWING_EAST, ZG.SWWL, ZG.VIEWING_EAST, ZG.SMALL_ROOM, ZG.SSWL, ZG.VAULT, ZG.VAULT, ZG.SNWL, ZG.SMALL_ROOM)  ->  ZilGlobal.py

# zil: 2actions.zil:1357  <GLOBAL SCOL-ROOM>
# GLOBAL (state) SCOL_ROOM = ZG.VIEWING_WEST  ->  ZilGlobal.py

# zil: 2actions.zil:1359  <ROUTINE DEPOSITORY-FCN (RARG)>
@ZG.routine('DEPOSITORY-FCN')
def DEPOSITORY_FCN(RARG):
    if (RARG == ZG.M_ENTER):
        ZG.SCOL_ROOM = ZG.LKP(ZG.PRSO, ZG.SCOL_ROOMS)
        return ZG.SCOL_ROOM
    else:
        return False

# zil: 2actions.zil:1363  <ROUTINE TELLER-ROOM (RARG)>
@ZG.routine('TELLER-ROOM')
def TELLER_ROOM(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('You are in a small room, which was used by a bank officer who retrieved\nsafety deposit boxes for the customer. On the north side of the room is a\nsign which reads  "Viewing Room". On the ')
        if (ZG.HERE == ZG.TELLER_WEST):
            TELL('west')
        else:
            TELL('east')
        return TELL(' side of the room, above an open door, is a sign reading:\n\n          BANK PERSONNEL ONLY\n', CR)
    else:
        return False

# zil: 2actions.zil:1376  <ROUTINE SCOL-OBJECT ("OPTIONAL" (OBJ <>))>
@ZG.routine('SCOL-OBJECT')
def SCOL_OBJECT(OBJ_l=None):
    if OBJ_l is None:
        OBJ_l = False
    if VERB_p('PUSH', 'MOVE', 'TAKE', 'RUB'):
        return TELL('As you try, your hand seems to go through it.', CR)
    elif (VERB_p('ATTACK') and ZG.PRSI):
        return TELL('The ', D, ZG.PRSI, ' goes through it.', CR)
    elif (VERB_p('THROW', 'OVERBOARD') and (ZG.PRSI in (ZG.CURTAIN, OBJ_l))):
        if IN_p(ZG.PRSO, ZG.WINNER):
            return ZG.V_THROUGH(ZG.PRSO)
        else:
            return TELL("You don't have that!", CR)
    else:
        return False

# zil: 2actions.zil:1386  <ROUTINE GET-WALL (RM "AUX" W)>
@ZG.routine('GET-WALL')
def GET_WALL(RM):
    W = 0
    W = ZG.SCOL_WALLS
    while True:
        if (GET(W, 0) == RM):
            return W
        else:
            W = REST(W, 6)

# zil: 2actions.zil:1394  <ROUTINE SCOLWALL ()>
@ZG.routine('SCOLWALL')
def SCOLWALL():
    if (VERB_p('THROW', 'OVERBOARD', 'PUT') and (ZG.HERE == ZG.SCOL_ACTIVE) and (ZG.PRSI == GET(ZG.GET_WALL(ZG.HERE), 1))):
        return ZG.SCOL_OBJECT(ZG.PRSI)
    else:
        return False

# zil: 2actions.zil:1400  <ROUTINE SCOL-GO (OBJ)>
@ZG.routine('SCOL-GO')
def SCOL_GO(OBJ_l):
    ZG.SCOL_ACTIVE = ZG.SCOL_ROOM
    if OBJ_l:
        return ZG.SCOL_OBJ(OBJ_l, 0, ZG.SCOL_ROOM)
    else:
        return ZG.SCOL_THROUGH(12, ZG.SCOL_ROOM)

# zil: 2actions.zil:1407  <ROUTINE SCOL-OBJ (OBJ CINT RM)>
@ZG.routine('SCOL-OBJ')
def SCOL_OBJ(OBJ_l, CINT, RM):
    ENABLE(ZG.QUEUE(ZG.I_CURTAIN, CINT))
    MOVE(OBJ_l, RM)
    if (RM == ZG.DEPOSITORY):
        return TELL('The ', D, OBJ_l, ' passes through the wall and vanishes.', CR)
    else:
        TELL('The curtain dims slightly as the ', D, OBJ_l, ' passes through.', CR)
        ZG.SCOL_ROOM = False
        return True

# zil: 2actions.zil:1419  <ROUTINE SCOL-THROUGH (CINT RM)>
@ZG.routine('SCOL-THROUGH')
def SCOL_THROUGH(CINT, RM):
    ENABLE(ZG.QUEUE(ZG.I_CURTAIN, CINT))
    TELL('You feel somewhat disoriented as you pass through...', CR, CR)
    return ZG.GOTO(RM)

# zil: 2actions.zil:1425  <GLOBAL SCOL-ACTIVE>
# GLOBAL (state) SCOL_ACTIVE = False  ->  ZilGlobal.py

# zil: 2actions.zil:1427  <ROUTINE I-CURTAIN ()>
@ZG.routine('I-CURTAIN')
def I_CURTAIN():
    ZG.SCOL_ACTIVE = False
    if (ZG.HERE == ZG.VAULT):
        return ZG.JIGS_UP('A metallic voice says "Hello, Intruder! Your unauthorized presence\nin the vault of the Bank of Zork has set off all sorts of nasty surprises,\nmost of which are fatal. This message brought to you by the Frobozz Magic\nVault Company."')
    elif (ZG.HERE in (ZG.VIEWING_EAST, ZG.VIEWING_WEST, ZG.SMALL_ROOM)):
        TELL('You hear a faint voice say "Curtain Door Closed."', CR)
        if (ZG.HERE == ZG.SMALL_ROOM):
            if ZG.ZGNOME_FLAG:
                return True
            else:
                ENABLE(ZG.QUEUE(ZG.I_ZGNOME, 3))
                ZG.ZGNOME_FLAG = True
                return ZG.ZGNOME_FLAG
        else:
            return False
    else:
        return False

# zil: 2actions.zil:1443  <GLOBAL ZGNOME-FLAG>
# GLOBAL (state) ZGNOME_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1445  <ROUTINE I-ZGNOME ()>
@ZG.routine('I-ZGNOME')
def I_ZGNOME():
    if (ZG.HERE == ZG.SMALL_ROOM):
        ENABLE(ZG.QUEUE(ZG.I_ZGNOME_OUT, 12))
        TELL('An epicene gnome of Zurich wearing a three-piece suit and carrying a\nsafety deposit box materializes in the room.')
        if IN_p(ZG.WAND, ZG.WINNER):
            return TELL(' He notices the wand and dematerializes speedily.', CR)
        else:
            TELL(' "You seem to have\nforgotten to deposit your valuables," he says, tapping the lid of the\nbox impatiently. "We don\'t usually allow customers to use the boxes\nhere, but we can make this ONE exception, I suppose..." He looks\naskance at you over his wire-rimmed bifocals.', CR)
            return MOVE(ZG.GNOME_OF_ZURICH, ZG.HERE)
    else:
        return False

# zil: 2actions.zil:1462  <ROUTINE BOX-F ()>
@ZG.routine('BOX-F')
def BOX_F():
    return TELL('The gnome clutches it possessively.', CR)

# zil: 2actions.zil:1465  <ROUTINE ZGNOME-FCN ()>
@ZG.routine('ZGNOME-FCN')
def ZGNOME_FCN():
    if VERB_p('TELL'):
        ZG.P_CONT = False
        ZG.QUOTE_FLAG = False
        return TELL('The gnome appears increasingly impatient.', CR)
    elif (VERB_p('GIVE', 'THROW') and (ZG.PRSI == ZG.GNOME_OF_ZURICH)):
        if GETPT(ZG.PRSO, 'VALUE'):
            TELL('The gnome carefully places the ', D, ZG.PRSO, ' in the\ndeposit box. "Let me show you the way out," he says, making it clear\nhe will be pleased to see the last of you. Then, you are momentarily\ndisoriented, and when you recover you are back at the Bank Entrance.', CR)
            REMOVE(ZG.GNOME_OF_ZURICH)
            REMOVE(ZG.PRSO)
            ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT))
            ZG.GOTO(ZG.BANK_ENTRANCE)
            return True
        elif ZG.BOMB_p(ZG.PRSO):
            REMOVE(ZG.GNOME_OF_ZURICH)
            MOVE(ZG.PRSO, ZG.HERE)
            ZG.DISABLE(ZG.INT(ZG.I_ZGNOME))
            ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT))
            return TELL('"You are so very gracious. I really cannot accept." he says. He\ndisappears, a wry smile on his lips.', CR)
        else:
            TELL('"I wouldn\'t put THAT in a safety deposit box," remarks the gnome with\ndisdain, tossing it over his shoulder, where it disappears with an\nunderstated "pop".', CR)
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            return True
    elif VERB_p('ATTACK'):
        TELL('The gnome says "Well, I never..." and disappears with a snap of his\nfingers, leaving you alone.', CR)
        REMOVE(ZG.GNOME_OF_ZURICH)
        return ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT))
    else:
        return TELL('The gnome appears increasingly impatient.', CR)

# zil: 2actions.zil:1508  <ROUTINE I-ZGNOME-OUT ()>
@ZG.routine('I-ZGNOME-OUT')
def I_ZGNOME_OUT():
    REMOVE(ZG.GNOME_OF_ZURICH)
    if (ZG.HERE == ZG.SMALL_ROOM):
        return TELL('The gnome looks impatient: "I may have another customer waiting;\nyou\'ll just have to fend for yourself, I\'m afraid." He disappears,\nleaving you alone.', CR)
    else:
        return False

# zil: 2actions.zil:1516  <ROUTINE BOMB? (O)>
@ZG.routine('BOMB?')
def BOMB_p(O_l):
    if ((O_l == ZG.BRICK) and IN_p(ZG.FUSE, ZG.BRICK) and (not (GET(ZG.INT(ZG.I_FUSE), ZG.C_ENABLED_p) == 0))):
        return True
    else:
        return False

'PALANTIRS, ETC.'

# zil: 2actions.zil:1527  <ROUTINE GO&LOOK (RM "AUX" OHERE OLIT (OSEEN <>))>
@ZG.routine('GO&LOOK')
def GO_LOOK(RM):
    OHERE = 0
    OLIT = 0
    OSEEN = False
    OHERE = ZG.HERE
    if FSET_p(OHERE, Flag('TOUCHBIT')):
        OSEEN = True
    OLIT = ZG.LIT
    ZG.HERE = RM
    ZG.LIT = ZG.LIT_p(RM)
    ZG.PERFORM(SYMBOL('V?LOOK'))
    if (not OSEEN):
        FCLEAR(OHERE, Flag('TOUCHBIT'))
    ZG.HERE = OHERE
    ZG.LIT = OLIT
    return True

# zil: 2actions.zil:1541  <ROUTINE TINY-ROOM-FCN (RARG)>
@ZG.routine('TINY-ROOM-FCN')
def TINY_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a tiny room carved out of the wall of the ravine. There is\nan exit down a precarious climb. ')
        ZG.P_DOOR('north', ZG.LID_1, ZG.KEYHOLE_1)
        return True
    elif (not VERB_p('LOOK')):
        ZG.PCHECK()
        return False
    else:
        return False

# zil: 2actions.zil:1551  <ROUTINE DREARY-ROOM-FCN (RARG)>
@ZG.routine('DREARY-ROOM-FCN')
def DREARY_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a small and rather dreary room, eerily illuminated by a red glow\nemanating from a crack in one wall. The light falls upon a dusty wooden table\nin the center of the room. ')
        ZG.P_DOOR('south', ZG.LID_2, ZG.KEYHOLE_2)
        return True
    return False
    return (True, ZG.PCHECK(), _tmp1)

# zil: 2actions.zil:1562  <ROUTINE PCHECK ("AUX" (LID <PLID>))>
@ZG.routine('PCHECK')
def PCHECK():
    LID = ZG.PLID()
    ZG.PLOOK_FLAG = False
    if (IN_p(ZG.KEY, ZG.KEYHOLE_1) or IN_p(ZG.KEY, ZG.KEYHOLE_2)):
        FSET(ZG.KEY, Flag('NDESCBIT'))
    else:
        FCLEAR(ZG.KEY, Flag('NDESCBIT'))
    if ZG.HELD_p(ZG.PLACE_MAT):
        ZG.MUD_FLAG = False
    # ;"HUH?"
    if ZG.MUD_FLAG:
        MOVE(ZG.PLACE_MAT, ZG.HERE)
        return FSET(ZG.PLACE_MAT, Flag('NDESCBIT'))
    else:
        return FCLEAR(ZG.PLACE_MAT, Flag('NDESCBIT'))

# zil: 2actions.zil:1578  <ROUTINE P-DOOR (STR LID KEYHOLE "AUX" F)>
@ZG.routine('P-DOOR')
def P_DOOR(STR, LID, KEYHOLE):
    F = 0
    if ZG.PLOOK_FLAG:
        ZG.PLOOK_FLAG = False
        return False
    TELL('On the ', STR, ' side of the room is a massive wooden door, which has a\nsmall window barred with iron. A formidable bolt lock is set within the\ndoor frame. A keyhole ')
    if (not FSET_p(LID, Flag('OPENBIT'))):
        TELL('covered by a thin metal lid ')
    TELL('lies within the lock.')
    if (F := FIRST_p(KEYHOLE)):
        TELL(' A ', D, F, ' is in place within the keyhole.')
    if ZG.MUD_FLAG:
        TELL(' The edge of a place mat is visible under the door.')
        if ZG.MATOBJ:
            TELL(' Lying on the place mat is a ', D, ZG.MATOBJ, '.')
    return CRLF()

# zil: 2actions.zil:1598  <ROUTINE PLID ("OPTIONAL" (OBJ1 ,LID-1) (OBJ2 ,LID-2))>
@ZG.routine('PLID')
def PLID(OBJ1=None, OBJ2=None):
    if OBJ1 is None:
        OBJ1 = ZG.LID_1
    if OBJ2 is None:
        OBJ2 = ZG.LID_2
    if IN_p(OBJ1, ZG.HERE):
        return OBJ1
    else:
        return OBJ2

# zil: 2actions.zil:1604  <ROUTINE PKH (KEYHOLE "OPTIONAL" (THIS <>))>
@ZG.routine('PKH')
def PKH(KEYHOLE, THIS=None):
    if THIS is None:
        THIS = False
    if ((KEYHOLE == ZG.KEYHOLE_1) and (not THIS)):
        return ZG.KEYHOLE_2
    elif ((not (KEYHOLE == ZG.KEYHOLE_1)) and THIS):
        return ZG.KEYHOLE_2
    else:
        return ZG.KEYHOLE_1

# zil: 2actions.zil:1612  <ROUTINE PKH-FCN ("AUX" OBJ KH)>
@ZG.routine('PKH-FCN')
def PKH_FCN():
    OBJ_l = 0
    KH = 0
    if VERB_p('LOOK-INSIDE'):
        if (ZG.HERE == ZG.DREARY_ROOM):
            _tmp1 = ZG.TINY_ROOM
        else:
            _tmp1 = ZG.DREARY_ROOM
        if (ZG.HERE == ZG.DREARY_ROOM):
            _tmp2 = ZG.TINY_ROOM
        else:
            _tmp2 = ZG.DREARY_ROOM
        if (FSET_p(ZG.LID_1, Flag('OPENBIT')) and FSET_p(ZG.LID_2, Flag('OPENBIT')) and (not FIRST_p(ZG.KEYHOLE_1)) and (not FIRST_p(ZG.KEYHOLE_2)) and ZG.LIT_p(_tmp2)):
            return TELL('You can see a lighted room at the other end.', CR)
        else:
            return TELL('No light can be seen through the keyhole.', CR)
    elif VERB_p('PUT'):
        if FSET_p(ZG.PLID(), Flag('OPENBIT')):
            if FIRST_p(ZG.PKH(ZG.PRSI, True)):
                return TELL('The keyhole is blocked.', CR)
            elif (ZG.PRSO in (ZG.LETTER_OPENER, ZG.KEY)):
                if FIRST_p((KH := ZG.PKH(ZG.PRSI))):
                    TELL('There is a faint noise from behind the door and a small cloud of\ndust rises from beneath it.', CR)
                    OBJ_l = FIRST_p(KH)
                    REMOVE(OBJ_l)
                    if ZG.MUD_FLAG:
                        ZG.MATOBJ = OBJ_l
                    return False
                else:
                    return False
            else:
                return TELL('The ', D, ZG.PRSO, " doesn't fit.", CR)
        else:
            return TELL('The lid is in the way.', CR)
    else:
        return False

# zil: 2actions.zil:1644  <ROUTINE PLID-FCN ()>
@ZG.routine('PLID-FCN')
def PLID_FCN():
    if VERB_p('OPEN', 'RAISE', 'MOVE'):
        if FSET_p(ZG.PRSO, Flag('OPENBIT')):
            TELL(ZG.RANDOM_ELEMENT(ZG.DUMMY), CR)
        else:
            TELL('The lid is now open.', CR)
        return FSET(ZG.PRSO, Flag('OPENBIT'))
    elif VERB_p('CLOSE', 'LOWER'):
        if (ZG.HERE == ZG.DREARY_ROOM):
            _tmp1 = ZG.KEYHOLE_2
        else:
            _tmp1 = ZG.KEYHOLE_1
        if (ZG.HERE == ZG.DREARY_ROOM):
            _tmp2 = ZG.KEYHOLE_2
        else:
            _tmp2 = ZG.KEYHOLE_1
        if FIRST_p(_tmp2):
            return TELL('The keyhole is occupied.', CR)
        else:
            TELL('The lid covers the keyhole.', CR)
            return FCLEAR(ZG.PRSO, Flag('OPENBIT'))
    elif VERB_p('LOOK-BEHIND'):
        return TELL("There's a keyhole behind the lid.", CR)
    else:
        return False

# zil: 2actions.zil:1661  <GLOBAL MUD-FLAG>
# GLOBAL (state) MUD_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1663  <GLOBAL MATOBJ>
# GLOBAL (state) MATOBJ = False  ->  ZilGlobal.py

# zil: 2actions.zil:1665  <GLOBAL PUNLOCK-FLAG>
# GLOBAL (state) PUNLOCK_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1667  <GLOBAL PLOOK-FLAG>
# GLOBAL (state) PLOOK_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:1669  <ROUTINE ROOM? (OBJ "AUX" NOBJ)>
@ZG.routine('ROOM?')
def ROOM_p(OBJ_l):
    NOBJ = 0
    while True:
        NOBJ = LOC(OBJ_l)
        if (not NOBJ):
            return False
        elif (NOBJ == ZG.WINNER):
            return False
        elif (NOBJ == ZG.ROOMS):
            return OBJ_l
        OBJ_l = NOBJ

# zil: 2actions.zil:1677  <ROUTINE PALANTIR ()>
@ZG.routine('PALANTIR')
def PALANTIR():
    if VERB_p('LOOK-INSIDE'):
        if (ZG.PRSO == ZG.PALANTIR_1):
            _tmp1 = ZG.PALANTIR_2
        elif (ZG.PRSO == ZG.PALANTIR_2):
            _tmp1 = ZG.PALANTIR_3
        elif (ZG.PRSO == ZG.PALANTIR_3):
            _tmp1 = ZG.PALANTIR_1
        else:
            _tmp1 = ZG.PALANTIR_4
        if (ZG.PRSO == ZG.PALANTIR_1):
            _tmp2 = ZG.PALANTIR_2
        elif (ZG.PRSO == ZG.PALANTIR_2):
            _tmp2 = ZG.PALANTIR_3
        elif (ZG.PRSO == ZG.PALANTIR_3):
            _tmp2 = ZG.PALANTIR_1
        else:
            _tmp2 = ZG.PALANTIR_4
        return ZG.PALANTIR_LOOK(_tmp2)
    elif VERB_p('EXAMINE'):
        return TELL('There is something misty in the sphere. Perhaps if you were to look\ninto it...', CR)
    elif (VERB_p('TAKE') and (ZG.PRSO == ZG.PALANTIR_3)):
        PUTP(ZG.PRSO, 'LDESC', False)
        return False
    else:
        return False

# zil: 2actions.zil:1694  <ROUTINE DEAD-PALANTIR (RARG "AUX" P)>
@ZG.routine('DEAD-PALANTIR')
def DEAD_PALANTIR(RARG):
    P = 0
    if (RARG == ZG.M_LOOK):
        if (ZG.HERE == ZG.DEAD_PALANTIR_1):
            P = ZG.PALANTIR_1
            _tmp1 = 'red'
        elif (ZG.HERE == ZG.DEAD_PALANTIR_2):
            P = ZG.PALANTIR_2
            _tmp1 = 'blue'
        else:
            P = ZG.PALANTIR_3
            _tmp1 = 'white'
        if (ZG.HERE == ZG.DEAD_PALANTIR_1):
            _tmp2 = 'blue'
        elif (ZG.HERE == ZG.DEAD_PALANTIR_2):
            _tmp2 = 'white'
        else:
            _tmp2 = 'black'
        if (ZG.HERE == ZG.DEAD_PALANTIR_1):
            P = ZG.PALANTIR_1
            _tmp3 = 'red'
        elif (ZG.HERE == ZG.DEAD_PALANTIR_2):
            P = ZG.PALANTIR_2
            _tmp3 = 'blue'
        else:
            P = ZG.PALANTIR_3
            _tmp3 = 'white'
        if (ZG.HERE == ZG.DEAD_PALANTIR_1):
            _tmp4 = 'blue'
        elif (ZG.HERE == ZG.DEAD_PALANTIR_2):
            _tmp4 = 'white'
        else:
            _tmp4 = 'black'
        TELL('You are inside a huge crystalline sphere filled with thin ', _tmp3, ' mist. The mist becomes ', _tmp4, ' to the west.', CR)
        TELL('You strain to look out through the mist... ', CR)
        if FSET_p(P, Flag('TOUCHBIT')):
            ZG.PALANTIR_LOOK(P, True)
        elif (P == ZG.PALANTIR_1):
            TELL('You see a small room with a sign on the wall, but it is too blurry to\nread.', CR)
        elif (P == ZG.PALANTIR_2):
            TELL('You look out into a large, dreary room with a great door and a huge table.\nThere is an odd glow to the mist.', CR)
        elif (P == ZG.PALANTIR_3):
            TELL('A strange blurry room is barely visible.')
            if (IN_p(ZG.SERPENT, ZG.AQUARIUM) and ZG.PROB(25)):
                TELL(' An odd sinuous shadow crosses the mist as you look.')
            CRLF()
        return True
    elif ((RARG == ZG.M_ENTER) and (ZG.HERE == ZG.DEAD_PALANTIR_4)):
        TELL('You follow a corridor of black mist into a black walled spherical\nroom.')
        if IN_p(ZG.GENIE, ZG.PENTAGRAM_ROOM):
            TELL(" The room is empty. A huge face looks down on you from outside and\nlaughs sardonically. It doesn't look like you're getting out of this\npredicament!", CR)
            ZG.FINISH()
        TELL(' As you enter, a huge and horrible face materializes out of the\nmist.\n\n"What brings you here to trouble my imprisonment, wanderer?"\nit asks. Hearing no immediate answer, it studies you for a moment.', CR)
        if (not (ZG.DEATHS < 3)):
            TELL('"Not you again! This is getting tedious. You\'ll obviously never\nbe much help to me. Better luck next time, oh wondrous\nadventurer." The face disappears and everything goes black.', CR)
            return ZG.FINISH()
        else:
            TELL('"Perhaps you may be of some use to me in gaining my freedom from\nthis place. Return to your foolish quest! I shall not destroy you\nthis time. Mayhap you will repay this favor in kind someday." The\nface vanishes and the mist begins to swirl. When it clears you are\nreturned to the world of life.', CR)
            ZG.DEAD = False
            ZG.GOTO(ZG.INSIDE_BARROW)
            return True
    else:
        return False

# zil: 2actions.zil:1765  <ROUTINE GLOBAL-PALANTIRS ()>
@ZG.routine('GLOBAL-PALANTIRS')
def GLOBAL_PALANTIRS():
    if VERB_p('LOOK-INSIDE', 'EXAMINE'):
        return ZG.DEAD_PALANTIR(ZG.M_LOOK)
    elif VERB_p('MUNG'):
        return TELL('The sphere is unbreakable.', CR)
    else:
        return False

# zil: 2actions.zil:1770  <ROUTINE PALANTIR-LOOK (OBJ "OPTIONAL" (INSIDE? <>) "AUX" RM OHERE)>
@ZG.routine('PALANTIR-LOOK')
def PALANTIR_LOOK(OBJ_l, INSIDE_p=None):
    if INSIDE_p is None:
        INSIDE_p = False
    RM = 0
    OHERE = 0
    if (OBJ_l == ZG.PALANTIR_4):
        TELL('As you peer into the sphere, a strange vision takes shape...a huge and\nfearful face with yellow eyes. The face peers out at you expectantly.', CR)
        return True
    RM = ZG.ROOM_p(OBJ_l)
    if ((not RM) or (not ZG.LIT_p(RM))):
        TELL('You see only darkness.', CR)
    elif (IN_p(OBJ_l, RM) or ZG.SEE_INSIDE_p(LOC(OBJ_l))):
        OHERE = ZG.HERE
        if INSIDE_p:
            TELL('As you peer through the mist, a strangely colored vision of a\nhuge room takes shape...', CR, CR)
        else:
            TELL('As you peer into the sphere, a strange vision takes shape of\na distant room, which can be described clearly....', CR, CR)
        FSET(OBJ_l, Flag('INVISIBLE'))
        ZG.GO_LOOK(RM)
        if (OHERE == RM):
            TELL('An astonished adventurer is staring into a crystal sphere.', CR)
        FCLEAR(OBJ_l, Flag('INVISIBLE'))
        if (not INSIDE_p):
            TELL('The vision fades, revealing only an ordinary crystal sphere.', CR)
    else:
        TELL('You see only darkness.', CR)
    return True

# zil: 2actions.zil:1802  <ROUTINE PWINDOW-FCN ()>
@ZG.routine('PWINDOW-FCN')
def PWINDOW_FCN():
    if VERB_p('LOOK-INSIDE'):
        ZG.PLOOK_FLAG = True
        if FSET_p(ZG.PDOOR, Flag('OPENBIT')):
            return TELL('The door is open, dummy.', CR)
        elif (ZG.HERE == ZG.DREARY_ROOM):
            return ZG.GO_LOOK(ZG.TINY_ROOM)
        else:
            return ZG.GO_LOOK(ZG.DREARY_ROOM)
    elif VERB_p('THROUGH'):
        return TELL('Perhaps if you were diced....', CR)
    else:
        return False

# zil: 2actions.zil:1813  <ROUTINE PDOOR-FCN ("AUX" K)>
@ZG.routine('PDOOR-FCN')
def PDOOR_FCN():
    K = 0
    if (VERB_p('LOOK-UNDER') and ZG.MUD_FLAG):
        return TELL('The place mat is under the door.', CR)
    elif VERB_p('UNLOCK'):
        if (ZG.PRSI == ZG.KEY):
            if ((K := FIRST_p(ZG.PLID(ZG.KEYHOLE_1, ZG.KEYHOLE_2))) and (not (K == ZG.KEY))):
                return TELL('The keyhole is blocked.', CR)
            else:
                TELL('The door is now unlocked.', CR)
                ZG.PUNLOCK_FLAG = True
                return ZG.PUNLOCK_FLAG
        elif (ZG.PRSI == ZG.GOLD_KEY):
            return TELL("It doesn't fit the lock.", CR)
        else:
            return TELL("It can't be unlocked with that.", CR)
    elif VERB_p('LOCK'):
        if (ZG.PRSI == ZG.KEY):
            TELL('The door is locked.', CR)
            ZG.PUNLOCK_FLAG = False
            return True
        elif (ZG.PRSI == ZG.GOLD_KEY):
            return TELL("It doesn't fit the lock.", CR)
        else:
            return TELL("It can't be locked with that.", CR)
    elif VERB_p('PUT-UNDER'):
        if (ZG.PRSO == ZG.ROBOT_LABEL):
            TELL('The paper is very small and vanishes under the door.', CR)
            if (ZG.HERE == ZG.TINY_ROOM):
                _tmp1 = ZG.DREARY_ROOM
            else:
                _tmp1 = ZG.TINY_ROOM
            if (ZG.HERE == ZG.TINY_ROOM):
                _tmp2 = ZG.DREARY_ROOM
            else:
                _tmp2 = ZG.TINY_ROOM
            return MOVE(ZG.PRSO, _tmp2)
        elif (ZG.PRSO == ZG.NEWSPAPER):
            return TELL("The newspaper crumples up and won't go under the door.", CR)
        else:
            return False
    elif VERB_p('OPEN', 'CLOSE'):
        if ZG.PUNLOCK_FLAG:
            return ZG.OPEN_CLOSE(ZG.PRSO, 'The door is now open.', 'The door is now closed.')
        else:
            return TELL('The door is locked.', CR)
    else:
        return False

# zil: 2actions.zil:1851  <ROUTINE PKEY-FCN ()>
@ZG.routine('PKEY-FCN')
def PKEY_FCN():
    if VERB_p('TURN'):
        if ZG.PUNLOCK_FLAG:
            return ZG.PERFORM(SYMBOL('V?LOCK'), ZG.PDOOR, ZG.PRSO)
        else:
            return ZG.PERFORM(SYMBOL('V?UNLOCK'), ZG.PDOOR, ZG.PRSO)
    else:
        return False

# zil: 2actions.zil:1858  <ROUTINE PLACE-MAT-FCN ()>
@ZG.routine('PLACE-MAT-FCN')
def PLACE_MAT_FCN():
    if VERB_p('PUT-UNDER'):
        if (ZG.PRSI == ZG.PDOOR):
            TELL('The place mat fits easily under the door.', CR)
            MOVE(ZG.PRSO, ZG.HERE)
            ZG.MUD_FLAG = True
            return ZG.MUD_FLAG
        elif (ZG.PRSI in (ZG.WIZ_DOOR, ZG.RIDDLE_DOOR, ZG.CRYPT_DOOR)):
            return TELL("There's not enough room under this door.", CR)
        else:
            return False
    elif (VERB_p('TAKE', 'MOVE') and ZG.MATOBJ):
        MOVE(ZG.MATOBJ, ZG.HERE)
        TELL('As the place mat is moved, a ', D, ZG.MATOBJ, ' falls from it and onto the floor.', CR)
        ZG.MATOBJ = False
        ZG.MUD_FLAG = False
        return True
    else:
        return False

# zil: 2actions.zil:1876  <ROUTINE WISH-FCN ()>
@ZG.routine('WISH-FCN')
def WISH_FCN():
    if VERB_p('MAKE'):
        if ((ZG.HERE == ZG.WELL_BOTTOM) and IN_p(ZG.COIN, ZG.HERE)):
            TELL('A whispering voice replies: "Water makes the bucket go."\nUnfortunately, wishing makes the coin go....', CR)
            return REMOVE(ZG.COIN)
        else:
            return TELL('No one is listening.', CR)
    else:
        return False

# zil: 2actions.zil:1887  <ROUTINE WELL-FCN ()>
@ZG.routine('WELL-FCN')
def WELL_FCN():
    if (FSET_p(ZG.PRSO, Flag('TAKEBIT')) and VERB_p('THROW', 'PUT', 'DROP')):
        TELL('The ', D, ZG.PRSO, ' is now sitting at the bottom of the well.', CR)
        return MOVE(ZG.PRSO, ZG.WELL_BOTTOM)
    elif VERB_p('CLIMB-UP', 'CLIMB-DOWN', 'CLIMB-FOO'):
        return TELL("You can't climb the well.", CR)
    else:
        return False

# zil: 2actions.zil:1895  <GLOBAL MATCH-COUNT>
# GLOBAL (state) MATCH_COUNT = 6  ->  ZilGlobal.py

# zil: 2actions.zil:1897  <ROUTINE MATCH-FCN ("AUX" CNT)>
@ZG.routine('MATCH-FCN')
def MATCH_FCN():
    CNT = 0
    if (VERB_p('LAMP-ON', 'BURN') and (ZG.PRSO == ZG.MATCH)):
        if (ZG.MATCH_COUNT > 0):
            ZG.MATCH_COUNT = (ZG.MATCH_COUNT - 1)
        if (not (ZG.MATCH_COUNT > 0)):
            return TELL("I'm afraid you have run out of matches.", CR)
        else:
            FSET(ZG.MATCH, Flag('FLAMEBIT'))
            FSET(ZG.MATCH, Flag('ONBIT'))
            ENABLE(ZG.QUEUE(ZG.I_MATCH, 2))
            return TELL('One of the matches starts to burn.', CR)
    elif (VERB_p('LAMP-OFF') and FSET_p(ZG.MATCH, Flag('FLAMEBIT'))):
        TELL('The match is out.', CR)
        FCLEAR(ZG.MATCH, Flag('FLAMEBIT'))
        FCLEAR(ZG.MATCH, Flag('ONBIT'))
        ZG.QUEUE(ZG.I_MATCH, 0)
        return True
    elif VERB_p('COUNT'):
        TELL('You have ')
        CNT = (ZG.MATCH_COUNT - 1)
        TELL(N, CNT, ' match')
        if (not (CNT == 1)):
            TELL('es.')
        else:
            TELL('.')
        return CRLF()
    elif VERB_p('EXAMINE'):
        if FSET_p(ZG.MATCH, Flag('ONBIT')):
            TELL('A match is burning.')
        else:
            TELL('No match is burning.')
        return CRLF()
    else:
        return False

# zil: 2actions.zil:1928  <ROUTINE I-MATCH ()>
@ZG.routine('I-MATCH')
def I_MATCH():
    TELL('The match has gone out.', CR)
    FCLEAR(ZG.MATCH, Flag('FLAMEBIT'))
    return FCLEAR(ZG.MATCH, Flag('ONBIT'))

# zil: 2actions.zil:1934  <GLOBAL LAMP-TABLE>
# GLOBAL (state) LAMP_TABLE = TABLE(300, 'The lamp appears a bit dimmer.', 100, 'The lamp is definitely dimmer now.', 50, 'The lamp is nearly out.', 0)  ->  ZilGlobal.py

# zil: 2actions.zil:1943  <ROUTINE LANTERN ()>
@ZG.routine('LANTERN')
def LANTERN():
    if (VERB_p('THROW') and (ZG.PRSO == ZG.LAMP)):
        TELL('The lamp has smashed into the floor, and the light has gone out.', CR)
        ZG.DISABLE(ZG.INT(ZG.I_LANTERN))
        REMOVE(ZG.LAMP)
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
        if FSET_p(ZG.LAMP, Flag('RMUNGBIT')):
            TELL('The lamp has burned out.')
        elif FSET_p(ZG.LAMP, Flag('ONBIT')):
            TELL('The lamp is on.')
        else:
            TELL('The lamp is turned off.')
        return CRLF()
    else:
        return False

# zil: 2actions.zil:1971  <ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))>
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

# zil: 2actions.zil:1977  <ROUTINE LIGHT-INT (OBJ TBL TICK)>
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

# ;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
# 	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
# 		(TICK) FIX)
# 	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
# 	 <COND (<0? .TICK>
# 		<FSET .OBJ ,RMUNGBIT>
# 		<FCLEAR .OBJ ,ONBIT>)>
# 	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
# 		<COND (<0? .TICK>
# 		       <TELL
# "I hope you have more light than from the " D .OBJ "." CR>)
# 		      (T
# 		       <TELL <GET .TBL 1> CR>)>)>
# 	 <COND (<NOT <0? .TICK>>
# 		<SETG .TBLNAM <REST .TBL 4>>)>
# 	 <RTRUE>>

# ;"Riddles"

# zil: 2actions.zil:2007  <ROUTINE RIDDLE-ROOM-FCN (RARG)>
@ZG.routine('RIDDLE-ROOM-FCN')
def RIDDLE_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a room which is bare on all sides. There is an exit down in\nthe northwest corner of the room. To the east is a great ')
        if FSET_p(ZG.RIDDLE_DOOR, Flag('OPENBIT')):
            TELL('open')
        else:
            TELL('closed')
        return TELL(' door made of\nstone. Above the stone, the following words are written: "No man shall\npass this door without solving this riddle:\n\n  What is tall as a house,\n    round as a cup,\n      and all the king\'s horses\n        can\'t draw it up?"\n')
    elif (RARG == ZG.M_BEG):
        if VERB_p('ANSWER', 'SAY'):
            if FSET_p(ZG.RIDDLE_DOOR, Flag('OPENBIT')):
                return False
            elif ((GET(ZG.P_LEXV, ZG.P_CONT) == WORD('well')) or (GET(ZG.P_LEXV, (ZG.P_CONT + 2)) == WORD('well'))):
                TELL('There is a deafening clap of thunder and the stone door\nquietly swings open to reveal a passageway beyond.', CR)
                ZG.SCORE_UPD(5)
                FSET(ZG.RIDDLE_DOOR, Flag('OPENBIT'))
            else:
                TELL('A hollow laugh seems to come from the stone door.', CR)
            ZG.P_CONT = False
            ZG.QUOTE_FLAG = False
            return True
        else:
            return False
    else:
        return False

# zil: 2actions.zil:2043  <ROUTINE RIDDLE-DOOR-FCN ()>
@ZG.routine('RIDDLE-DOOR-FCN')
def RIDDLE_DOOR_FCN():
    if VERB_p('OPEN'):
        if FSET_p(ZG.RIDDLE_DOOR, Flag('OPENBIT')):
            return TELL('It is open!', CR)
        else:
            return TELL('The door can only be opened by answering the riddle.', CR)
    elif VERB_p('CLOSE'):
        if FSET_p(ZG.RIDDLE_DOOR, Flag('OPENBIT')):
            return TELL('Not a chance. The door weighs many tons.', CR)
        else:
            return TELL('It is closed!', CR)
    else:
        return False

# zil: 2actions.zil:2056  <GLOBAL DUMMY>
# GLOBAL (state) DUMMY = LTABLE('Look around.', "You think it isn't?", "I think you've already done that.")  ->  ZilGlobal.py

# zil: 2actions.zil:2061  <ROUTINE RIDDLE-PSEUDO ()>
@ZG.routine('RIDDLE-PSEUDO')
def RIDDLE_PSEUDO():
    if VERB_p('EXAMINE'):
        return TELL('Use the "Look" command.', CR)
    else:
        return False

# zil: 2actions.zil:2065  <ROUTINE MAGIC-ACTOR ("AUX" V)>
@ZG.routine('MAGIC-ACTOR')
def MAGIC_ACTOR():
    V = 0
    if ZG.SPELL_p:
        if (ZG.SPELL_p == ZG.S_FALL):
            if (VERB_p('CLIMB-UP', 'CLIMB-DOWN', 'CROSS') or (VERB_p('WALK') and GETPT(ZG.HERE, 'DOWN'))):
                V = GETPT(ZG.HERE, 'GLOBAL')
                if ZG.ZMEMQB(ZG.BRIDGE, V, PTSIZE(V)):
                    return ZG.JIGS_UP('You find yourself drawn toward the edge of the bridge. You peer over\nthe side. Oops, that was clumsy of you! You tripped on something and\nfell in. Too bad.')
                elif ZG.PROB(25):
                    return ZG.JIGS_UP('For some odd reason you have tripped on your own feet, or perhaps an\ninvisible cord stretched across the path. The resulting fall seems to\nhave done you in.')
                else:
                    return TELL('You just tripped on an invisible cord, or perhaps your own feet. But\nthis must be your lucky day, as you managed to regain your balance\nbefore what could have been a fatal fall.', CR)
            elif VERB_p('BOARD'):
                return TELL('You get in the ', D, ZG.PRSO, ' but you fall out again, almost as though\nan invisible hand had tipped it over.', CR)
            else:
                return False
        elif (ZG.SPELL_p == ZG.S_FLOAT):
            if VERB_p('DIAGNOSE', 'WAIT'):
                return False
            elif VERB_p('WALK'):
                return TELL('I suppose you plan to do that by flapping your arms?', CR)
            elif VERB_p('DROP'):
                MOVE(ZG.PRSO, ZG.HERE)
                return TELL('The ', D, ZG.PRSO, ' drops to the ground.', CR)
            elif (VERB_p('TAKE') and IN_p(ZG.PRSO, ZG.HERE)):
                return TELL("You can't reach that! It's on the ground.", CR)
            else:
                return False
        elif (ZG.SPELL_p == ZG.S_FREEZE):
            if VERB_p('DIAGNOSE', 'WAIT'):
                return False
            else:
                return TELL("You are frozen solid. You might as well wait it out, because you\ncan't do anything else in this state.", CR)
        elif ((ZG.SPELL_p == ZG.S_FENCE) and VERB_p('WALK')):
            TELL('An invisible fence of magical force bars your way.', CR)
            return True
        elif ((ZG.SPELL_p == ZG.S_FIERCE) and (V := ZG.INFESTED_p(ZG.HERE))):
            if VERB_p('ATTACK', 'MUNG'):
                return False
            else:
                ZG.FORCE_FIGHT(V)
                return True
        elif ((ZG.SPELL_p == ZG.S_FERMENT) and VERB_p('WALK') and IN_p(ZG.WINNER, ZG.HERE)):
            TELL("Oops, you seem a little unsteady... I'm not sure you got where\nyou intended going.", CR, CR)
            return ZG.RANDOM_WALK()
        elif ((ZG.SPELL_p == ZG.S_FEAR) and (V := ZG.INFESTED_p(ZG.HERE))):
            TELL("All at once, you are overcome by fear! There's is a ", D, V, " in here!\nMaybe it's after you! ")
            if FSET_p(LOC(ZG.WINNER), Flag('VEHBIT')):
                return TELL('You huddle in the corner, terrified.', CR)
            else:
                TELL('You run from the room screaming in terror!', CR, CR)
                return ZG.RANDOM_WALK()
        else:
            return False
    else:
        return False

# zil: 2actions.zil:2139  <ROUTINE RANDOM-WALK ("AUX" P TX L S (D <>))>
@ZG.routine('RANDOM-WALK')
def RANDOM_WALK():
    P = 0
    TX = 0
    L = 0
    S_l = 0
    D_l = False
    P = 0
    while True:
        if ((P := NEXTP(ZG.HERE, P)) < LOW_DIRECTION):
            if D_l:
                S_l = ZG.SPELL_p
                ZG.SPELL_p = False
                ZG.WINNER = ZG.ADVENTURER
                MOVE(ZG.WINNER, ZG.HERE)
                ZG.DO_WALK(D_l)
                ZG.SPELL_p = S_l
            return True
        else:
            TX = GETPT(ZG.HERE, P)
            L = PTSIZE(TX)
            if ((L == ZG.UEXIT) or ((L == ZG.CEXIT) and VALUE(GETB(TX, ZG.CEXITFLAG))) or ((L == ZG.DEXIT) and FSET_p(GETB(TX, ZG.DEXITOBJ), Flag('OPENBIT')))):
                if (not D_l):
                    D_l = P
                elif ZG.PROB(50):
                    D_l = P

# zil: 2actions.zil:2162  <ROUTINE FORCE-FIGHT (V "AUX" W)>
@ZG.routine('FORCE-FIGHT')
def FORCE_FIGHT(V):
    W = 0
    if (not (W := ZG.FIND_IN(ZG.ADVENTURER, Flag('WEAPONBIT')))):
        W = ZG.HANDS
    TELL('You are maddened by an overwhelming ferocity, and attack the ', D, V, ' instead.', CR)
    return ZG.PERFORM(SYMBOL('V?ATTACK'), V, W)

'SUBTITLE DIAMOND MAZE'

# zil: 2actions.zil:2174  <GLOBAL DIAMOND-SOLVE>
# GLOBAL (state) DIAMOND_SOLVE = False  ->  ZilGlobal.py

# ;"T if solved"

# zil: 2actions.zil:2176  <GLOBAL DIAMOND-COUNT>
# GLOBAL (state) DIAMOND_COUNT = 0  ->  ZilGlobal.py

# ;"count of current progress"

# zil: 2actions.zil:2177  <GLOBAL DIAMOND-MOVES>
# GLOBAL (state) DIAMOND_MOVES = 0  ->  ZilGlobal.py

# ;"count of moves since progressed"

# zil: 2actions.zil:2178  <GLOBAL DIAMOND-BASE>
# GLOBAL (state) DIAMOND_BASE = 0  ->  ZilGlobal.py

# ;"count of maximum progress ever"

# zil: 2actions.zil:2180  <GLOBAL DWDESCS>
# GLOBAL (state) DWDESCS = TABLE('dark', 'flickering dimly', 'dimly glowing', 'glowing', 'glowing brightly')  ->  ZilGlobal.py

# zil: 2actions.zil:2187  <ROUTINE DWINDOW-DESC ()>
@ZG.routine('DWINDOW-DESC')
def DWINDOW_DESC():
    TELL('On the floor is a very small diamond shaped window which is ')
    if ZG.DIAMOND_SOLVE:
        TELL('glowing serenely')
    else:
        TELL(GET(ZG.DWDESCS, ZG.DIAMOND_COUNT))
    return TELL('.', CR)

# zil: 2actions.zil:2194  <ROUTINE DWINDOW-FCN ()>
@ZG.routine('DWINDOW-FCN')
def DWINDOW_FCN():
    if VERB_p('TAKE'):
        return TELL('The window is an integral part of the floor.', CR)
    elif VERB_p('MUNG'):
        return TELL('The window is diamond-hard and cannot be broken.', CR)
    elif VERB_p('EXAMINE', 'LOOK-INSIDE'):
        return ZG.DWINDOW_DESC()
    else:
        return False

# zil: 2actions.zil:2204  <ROUTINE DIAMOND-MOTION (RARG "AUX" DC DIR RM)>
@ZG.routine('DIAMOND-MOTION')
def DIAMOND_MOTION(RARG):
    DC = 0
    DIR = 0
    RM = 0
    if (RARG == ZG.M_LOOK):
        TELL('This is a room with oddly angled walls and passages in all directions.\nThe walls are made of some glassy substance.', CR)
        if (ZG.HERE == ZG.DIAMOND_5):
            TELL('A marble stairway leads upward.')
            if ZG.DIAMOND_SOLVE:
                TELL(' The floor has swung down at the end of the stairway to reveal a secret\npassage leading down into unrelieved darkness.')
            CRLF()
        else:
            ZG.DWINDOW_DESC()
        return True
    elif (RARG == ZG.M_FLASH):
        ZG.DWINDOW_DESC()
        return True
    elif ((RARG == ZG.M_BEG) and VERB_p('WALK') and (not ZG.DIAMOND_SOLVE)):
        if ((ZG.HERE in (ZG.DIAMOND_2, ZG.DIAMOND_4)) or (ZG.HERE in (ZG.DIAMOND_6, ZG.DIAMOND_8))):
            DIR = GET(ZG.DIDIRS, (ZG.DIAMOND_COUNT - 1))
            if (ZG.PRSO == DIR):
                ZG.DIAMOND_COUNT = (ZG.DIAMOND_COUNT + 1)
                if (ZG.DIAMOND_COUNT > ZG.DIAMOND_BASE):
                    ZG.DIAMOND_BASE = ZG.DIAMOND_COUNT
                    ZG.DIAMOND_MOVES = 0
                if (ZG.DIAMOND_COUNT == 5):
                    TELL('You hear a strange rusty squeal echoing in the distance.', CR)
                    FCLEAR(ZG.DIAMOND_5, Flag('TOUCHBIT'))
                    ZG.SCORE_UPD(5)
                    ZG.DIAMOND_SOLVE = True
                if (ZG.HERE == ZG.DIAMOND_2):
                    DIR = ZG.DIAMOND_4
                elif (ZG.HERE == ZG.DIAMOND_4):
                    DIR = ZG.DIAMOND_8
                elif (ZG.HERE == ZG.DIAMOND_8):
                    DIR = ZG.DIAMOND_6
                elif (ZG.HERE == ZG.DIAMOND_6):
                    DIR = ZG.DIAMOND_2
                ZG.GOTO(DIR)
            else:
                ZG.DIAMOND_LOSS()
            return True
        elif ((ZG.HERE == ZG.DIAMOND_5) and (ZG.PRSO == 'UP')):
            return False
        else:
            ZG.DIAMOND_COUNT = 0
            if ZG.PROB(33):
                TELL('There is no way to go in that direction.', CR)
                return True
            elif ZG.PROB(25):
                ZG.DIAMOND_LOSS()
                return True
            else:
                ZG.DIAMOND_COUNT = 1
                if (ZG.DIAMOND_COUNT > ZG.DIAMOND_BASE):
                    ZG.DIAMOND_BASE = ZG.DIAMOND_COUNT
                    ZG.DIAMOND_MOVES = 0
                RM = GET(ZG.DIAMOND_ROOMS, (RANDOM(4) - 1))
                if FSET_p(ZG.BAT, Flag('INVISIBLE')):
                    FCLEAR(ZG.BAT, Flag('INVISIBLE'))
                    MOVE(ZG.BAT, RM)
                ZG.GOTO(RM)
                return True
    else:
        return False

# zil: 2actions.zil:2274  <ROUTINE DIAMOND-LOSS ()>
@ZG.routine('DIAMOND-LOSS')
def DIAMOND_LOSS():
    ZG.DIAMOND_MOVES = (ZG.DIAMOND_MOVES + 1)
    if (ZG.DIAMOND_MOVES == 20):
        TELL('As you thrash about in the maze, the mirthful voice of the Wizard\ntaunts you: "Fool! You\'ll never get past ')
        TELL(GET(ZG.BASES, ZG.DIAMOND_BASE))
        TELL(' base at this rate!"', CR)
    return ZG.GOTO(GET(ZG.DIAMOND_ROOMS, (3 + RANDOM(5))))

# zil: 2actions.zil:2284  <GLOBAL BASES>
# GLOBAL (state) BASES = TABLE('first', 'first', 'first', 'second', 'third', 'home')  ->  ZilGlobal.py

# zil: 2actions.zil:2286  <GLOBAL DIAMOND-ROOMS>
# GLOBAL (state) DIAMOND_ROOMS = TABLE(ZG.DIAMOND_2, ZG.DIAMOND_4, ZG.DIAMOND_6, ZG.DIAMOND_8, ZG.DIAMOND_1, ZG.DIAMOND_3, ZG.DIAMOND_5, ZG.DIAMOND_7, ZG.DIAMOND_9)  ->  ZilGlobal.py

# zil: 2actions.zil:2290  <GLOBAL DIDIRS>
# GLOBAL (state) DIDIRS = TABLE('SE', 'NE', 'NW', 'SW')  ->  ZilGlobal.py

'SUBTITLE CERBERUS'

# zil: 2actions.zil:2296  <GLOBAL CERBERUS-LEASHED>
# GLOBAL (state) CERBERUS_LEASHED = False  ->  ZilGlobal.py

# zil: 2actions.zil:2298  <ROUTINE CERBERUS-FCN ()>
@ZG.routine('CERBERUS-FCN')
def CERBERUS_FCN():
    if (VERB_p('WAVE', 'RUB', 'RAISE') and (ZG.PRSO == ZG.WAND)):
        TELL('The dog looks puzzled.', CR)
        return False
    elif (ZG.WAND_ON and VERB_p('SAY', 'INCANT')):
        return False
    elif ZG.HELLO_p(ZG.CERBERUS):
        if ZG.CERBERUS_LEASHED:
            return TELL('"Arf! Arf! Arf!"', CR)
        else:
            return TELL('"Grrrr!"', CR)
    elif VERB_p('ATTACK', 'MUNG', 'STAB'):
        if ZG.CERBERUS_LEASHED:
            REMOVE(ZG.CERBERUS)
            return TELL('With a quiet bark of disappointment, the creature expires.\nIts six eyes look at you reproachfully. As it dies, it collapses\ninto a small pile of dust which blows away into nothing.', CR)
        elif ZG.PROB(50):
            return ZG.JIGS_UP('The dog-thing snaps at you viciously, and succeeds. Your head, it seems,\nis only a small mouthful for the poor animal, who is just as hungry\nafterward.')
        else:
            return TELL('The maddened dog-thing snaps viciously at you.', CR)
    elif (VERB_p('PUT', 'PUT-ON') and (ZG.PRSO == ZG.COLLAR)):
        MOVE(ZG.COLLAR, ZG.CERBERUS)
        FSET(ZG.COLLAR, Flag('NDESCBIT'))
        FSET(ZG.COLLAR, Flag('TRYTAKEBIT'))
        PUTP(ZG.CERBERUS, 'LDESC', 'An insipidly grinning three-headed dog is wagging its tail here.\nIt is wearing a huge dog collar.')
        ZG.CERBERUS_LEASHED = True
        return TELL('The creature whines happily, then the center head\nlicks your face (which is roughly like experiencing a sandpaper\nwashcloth). The other two heads look about, as though the\nmonster felt a sudden need to find a pair of slippers somewhere.\nIts huge tail wags enthusiastically, knocking small rocks\naround and almost blowing you over from the breeze it creates.', CR)
    elif VERB_p('ENCHANT'):
        if (ZG.SPELL_USED == WORD('float')):
            ZG.SPELL_HANDLED_p = True
            return TELL('The huge dog rises about an inch off the ground, for a moment.', CR)
        elif (ZG.SPELL_USED == WORD('fierce')):
            ZG.SPELL_HANDLED_p = True
            return ZG.JIGS_UP('Cerberus tears you limb from limb! What ferocity!')
        elif (ZG.SPELL_USED == WORD('feeble')):
            return TELL('What an effect! He now has the strength of just one elephant, rather\nthan ten!', CR)
        else:
            return False
    elif (not ZG.CERBERUS_LEASHED):
        return TELL('The three-headed dog snaps at you viciously!', CR)
    elif (ZG.CERBERUS_LEASHED and VERB_p('RUB')):
        return TELL('The dog is now insanely happy, slobbering all over the place and\nwhining with uncontained doggish joy.', CR)
    else:
        return False

# zil: 2actions.zil:2356  <ROUTINE COLLAR-FCN ()>
@ZG.routine('COLLAR-FCN')
def COLLAR_FCN():
    if (VERB_p('TAKE') and ZG.CERBERUS_LEASHED):
        return ZG.JIGS_UP("That wasn't such a good idea. The creature was enjoying being your pet.\nAs you unfasten the collar, the disappointed monster hound begins to growl,\nand then its three fang-crammed mouths rend you into little doggy biscuits.")
    elif (VERB_p('ENCHANT') and (ZG.SPELL_USED == WORD('float'))):
        ZG.PERFORM(SYMBOL('V?ENCHANT'), ZG.CERBERUS)
        return True
    else:
        return False

'SUBTITLE DRAGON AND GLACIER'

# zil: 2actions.zil:2370  <GLOBAL ICE-MELTED>
# GLOBAL (state) ICE_MELTED = False  ->  ZilGlobal.py

# zil: 2actions.zil:2372  <ROUTINE GLACIER-FCN ()>
@ZG.routine('GLACIER-FCN')
def GLACIER_FCN():
    if VERB_p('MELT'):
        return TELL("This is a big glacier; you'll need a lot of heat.", CR)
    else:
        return False

# zil: 2actions.zil:2377  <ROUTINE GLACIER-ROOM-FCN (RARG)>
@ZG.routine('GLACIER-ROOM-FCN')
def GLACIER_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This is a large hall of ancient lava, since worn smooth by the movement\nof a glacier. A large passage exits to the east and an upward lava tube\nis at the top of a jumble of fallen rocks.', CR)
        if ZG.ICE_MELTED:
            TELL('A damp and scorched passage leads west. It is still partly full of\nsteam.', CR)
        return True
    else:
        return False

# zil: 2actions.zil:2389  <ROUTINE DRAGON-FCN ()>
@ZG.routine('DRAGON-FCN')
def DRAGON_FCN():
    ENABLE(ZG.QUEUE(ZG.I_DRAGON, -1))
    if ZG.HELLO_p(ZG.DRAGON):
        TELL('The dragon looks amused. He speaks in a voice so deep you feel it\nrather than hear it, but the tongue is unknown to you. You find\nyourself almost hypnotized.', CR)
        ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER + 2)
        return ZG.DRAGON_ANGER
    elif VERB_p('EXAMINE'):
        TELL("He turns and looks back at you, his cat's eyes yellow in the gloom.\nYou start to feel weak, and quickly turn away.", CR)
        ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER + 1)
        return ZG.DRAGON_ANGER
    elif VERB_p('ATTACK', 'MUNG', 'KICK', 'LAMP-ON'):
        if (VERB_p('LAMP-ON') or (VERB_p('ATTACK') and (not ZG.PRSI))):
            TELL('With your bare hands? I doubt the dragon even noticed.', CR)
        else:
            TELL(ZG.RANDOM_ELEMENT(ZG.DRAGON_ATTACKS), CR)
        ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER + 4)
        return ZG.DRAGON_ANGER
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.DRAGON)):
        ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER + 1)
        if GETPT(ZG.PRSO, 'VALUE'):
            MOVE(ZG.PRSO, ZG.CHEST)
            return TELL('The dragon is pleased by your gift, excuses himself for a moment,\nand returns without it.', CR)
        elif ZG.BOMB_p(ZG.PRSO):
            ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER + 2)
            REMOVE(ZG.BRICK)
            return TELL('The dragon snakes his long red tongue around the bomb and politely\nswallows it. A few moments later he belches and smoke curls out of\nhis nostrils.', CR)
        else:
            return TELL('The dragon refuses your gift.', CR)
    elif (VERB_p('WALK') and (ZG.HERE == ZG.DRAGON_ROOM) and (ZG.PRSO == 'NORTH')):
        ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER + 3)
        return TELL('The dragon puts out a claw, grins (all of his sword-sharp teeth\nglinting in the light), and blocks your way.', CR)
    else:
        return False

# zil: 2actions.zil:2434  <GLOBAL DRAGON-ANGER>
# GLOBAL (state) DRAGON_ANGER = 0  ->  ZilGlobal.py

# zil: 2actions.zil:2436  <GLOBAL DRAGON-ATTACKS>
# GLOBAL (state) DRAGON_ATTACKS = LTABLE('Dragon hide is tough as steel, but you have succeeded in annoying him\na bit. He looks at you as if deciding whether or not to eat you.', 'That captured his interest. He stares at you balefully.', 'The dragon is surprised and interested (for the moment).', "You've made him rather angry. You had better be very careful now.", 'That did no damage, but he turns his smoky yellow eyes in your direction\nand sighs.')  ->  ZilGlobal.py

# zil: 2actions.zil:2446  <ROUTINE HELLO? (WHO)>
@ZG.routine('HELLO?')
def HELLO_p(WHO):
    if ((ZG.WINNER == WHO) or VERB_p('TELL', 'ANSWER', 'REPLY', 'SAY', 'HELLO', 'INCANT')):
        if VERB_p('TELL', 'ANSWER', 'SAY', 'INCANT', 'REPLY'):
            ZG.P_CONT = False
            ZG.QUOTE_FLAG = False
        return True
    else:
        return False

# zil: 2actions.zil:2454  <ROUTINE FIND-TARGET (TARGET "AUX" P TX L ROOM)>
@ZG.routine('FIND-TARGET')
def FIND_TARGET(TARGET):
    P = 0
    TX = 0
    L = 0
    ROOM_l = 0
    if IN_p(TARGET, ZG.HERE):
        return ZG.HERE
    else:
        P = 0
        while True:
            if ((P := NEXTP(ZG.HERE, P)) == 0):
                return False
            elif (not (P < LOW_DIRECTION)):
                TX = GETPT(ZG.HERE, P)
                L = PTSIZE(TX)
                if (L in (ZG.UEXIT, ZG.CEXIT, ZG.DEXIT)):
                    ROOM_l = GETB(TX, 0)
                    if IN_p(TARGET, ROOM_l):
                        return ROOM_l

# zil: 2actions.zil:2469  <GLOBAL OLD-HERE>
# GLOBAL (state) OLD_HERE = ZG.DRAGON_ROOM  ->  ZilGlobal.py

# zil: 2actions.zil:2471  <ROUTINE I-DRAGON ("AUX" ROOM)>
@ZG.routine('I-DRAGON')
def I_DRAGON():
    ROOM_l = 0
    if (ZG.DRAGON_ANGER > 6):
        TELL('The dragon tires of this game. With an almost bored yawn, he opens his\nmouth and ')
        if (ZG.SPELL_p == ZG.S_FIREPROOF):
            TELL('blasts you with a great gout of fire, but it washes over you\nharmlessly.', CR)
        else:
            ZG.DRAGON_LEAVES()
            ZG.JIGS_UP('incinerates you in a blast of white-hot dragon fire.')
    elif (IN_p(ZG.WINNER, ZG.DRAGON_ROOM) and (not IN_p(ZG.DRAGON, ZG.DRAGON_ROOM))):
        MOVE(ZG.DRAGON, ZG.DRAGON_ROOM)
        TELL('The dragon doubles back and charges into the room, maddened by your\nattempt to sneak past him. His eyes glow with a white heat of anger.', CR)
        if (ZG.SPELL_p == ZG.S_FIREPROOF):
            ZG.JIGS_UP("A huge ball of flame envelops you, but you don't even feel the heat.\nThe dragon is puzzled, but not too puzzled to crush you in his jaws.")
        else:
            ZG.JIGS_UP('Worse for you, his mouth opens and a great gout of flame puffs out\nand consumes you on the spot.')
    elif (not (ZG.DRAGON_ANGER > 0)):
        if (ZG.PROB(50) and IN_p(ZG.DRAGON, ZG.HERE)):
            TELL('The dragon looks bored.', CR)
        else:
            ZG.DRAGON_LEAVES()
            if (ZG.HERE == ZG.GLACIER_ROOM):
                TELL('The dragon is no longer around. He must have become bored with you.', CR)
            elif (ZG.HERE == ZG.OLD_HERE):
                TELL('The dragon seems to have lost interest in you.')
                if (ZG.OLD_HERE == ZG.DRAGON_ROOM):
                    CRLF()
                else:
                    TELL(' He wanders off.', CR)
    else:
        ROOM_l = ZG.FIND_TARGET(ZG.WINNER)
        if (not ROOM_l):
            if ZG.PROB(25):
                ZG.DRAGON_LEAVES()
        elif ((ROOM_l in (ZG.CAROUSEL_ROOM, ZG.TINY_ROOM)) or (ROOM_l in (ZG.RAVINE_LEDGE, ZG.FRESCO_ROOM))):
            if ZG.PROB(25):
                ZG.DRAGON_LEAVES()
            TELL('The dragon will follow no further.', CR)
        elif (ROOM_l == ZG.GLACIER_ROOM):
            TELL(CR, 'As the dragon enters, he sees his reflection on the icy surface of the\nglacier at its western end. He becomes enraged: There is another dragon here,\nbehind that glass, he thinks! Dragons are smart, but sometimes naive, and\nthis one has never seen ice before. He rears up to his full height to\nchallenge this intruder into his territory. He roars a challenge! The\nintruder responds! The dragon takes a deep breath, and out of his mouth\npours a massive gout of flame. It washes over the ice, which melts rapidly,\nsending out torrents of water and a huge cloud of steam! You manage to clamber\nup to a small shelf, but the dragon is terrified! A huge splash goes down his\nthroat! There is a muffled explosion and the dragon, a puzzled expression on\nhis face, dies. He is carried away by the water.\n\nWhen the flood recedes you climb gingerly down. While no trace of\nthe dragon can be found, the melting of the ice has revealed a passage\nleading west.', CR)
            REMOVE(ZG.DRAGON)
            REMOVE(ZG.ICE)
            MOVE(ZG.DEAD_DRAGON, ZG.DEEP_FORD)
            ZG.DISABLE(ZG.INT(ZG.I_DRAGON))
            ZG.SCORE_UPD(5)
            ZG.ICE_MELTED = True
        else:
            if (not (ROOM_l == ZG.OLD_HERE)):
                MOVE(ZG.DRAGON, ROOM_l)
                TELL('The dragon follows you, out of mingled curiosity and anger.', CR)
            else:
                TELL('The dragon continues to watch you carefully.', CR)
            if (not (ZG.DRAGON_ANGER > 0)):
                ZG.DRAGON_ANGER = 0
                ZG.DISABLE(ZG.INT(ZG.I_DRAGON))
    ZG.OLD_HERE = LOC(ZG.DRAGON)
    ZG.DRAGON_ANGER = (ZG.DRAGON_ANGER - 2)
    if (ZG.DRAGON_ANGER < 0):
        ZG.DRAGON_ANGER = 0
    return True

# zil: 2actions.zil:2559  <ROUTINE DRAGON-LEAVES ()>
@ZG.routine('DRAGON-LEAVES')
def DRAGON_LEAVES():
    if (not LOC(ZG.DEAD_DRAGON)):
        MOVE(ZG.DRAGON, ZG.DRAGON_ROOM)
        ZG.DRAGON_ANGER = 0
        return ZG.DISABLE(ZG.INT(ZG.I_DRAGON))
    else:
        return False

# zil: 2actions.zil:2565  <ROUTINE I-GARDEN ()>
@ZG.routine('I-GARDEN')
def I_GARDEN():
    if ((ZG.HERE in (ZG.GARDEN_NORTH, ZG.GAZEBO_ROOM)) or (ZG.HERE in (ZG.TOPIARY_ROOM, ZG.FORMAL_GARDEN))):
        if (IN_p(ZG.UNICORN, ZG.GARDEN_NORTH) and ZG.PROB(33)):
            REMOVE(ZG.UNICORN)
            if (not (ZG.HERE == ZG.TOPIARY_ROOM)):
                return TELL('The unicorn bounds lightly away.', CR)
            else:
                return False
        elif (IN_p(ZG.PRINCESS, ZG.DRAGON_LAIR) and (not IN_p(ZG.UNICORN, ZG.GARDEN_NORTH)) and ZG.PROB(25) and (not (ZG.HERE == ZG.TOPIARY_ROOM))):
            if ZG.UNICORN_FRIGHTENED:
                ZG.UNICORN_FRIGHTENED = False
                return False
            MOVE(ZG.UNICORN, ZG.GARDEN_NORTH)
            if (ZG.HERE == ZG.GARDEN_NORTH):
                return TELL(ZG.RANDOM_ELEMENT(ZG.UNICORN_MSGS), CR)
            else:
                return TELL('A unicorn is peacefully cropping grass at the north end of the garden.\nThere is something hanging around its neck.', CR)
        elif (ZG.HERE == ZG.TOPIARY_ROOM):
            if ((not ZG.TOPIARY_MOVED) and ZG.PROB(12)):
                ZG.TOPIARY_MOVED = True
                return TELL('You look around, and strangely, the topiary animals seem to have\nchanged position slightly.', CR)
            elif (ZG.TOPIARY_MOVED and (not ZG.TOPIARY_NEAR) and ZG.PROB(8)):
                ZG.TOPIARY_NEAR = True
                return TELL('The topiary animals seem to close in on you. You turn and they are\nvery close. They seem to be leering at you.', CR)
            elif (ZG.TOPIARY_NEAR and ZG.PROB(4)):
                ZG.TOPIARY_MOVED = False
                ZG.TOPIARY_NEAR = False
                return ZG.JIGS_UP('The topiary animals attack! You are crushed by their branches and\nclawed by their thorns.')
            else:
                return False
        else:
            return False
    else:
        REMOVE(ZG.UNICORN)
        ZG.DISABLE(ZG.INT(ZG.I_GARDEN))
        return False

# zil: 2actions.zil:2610  <GLOBAL TOPIARY-MOVED>
# GLOBAL (state) TOPIARY_MOVED = False  ->  ZilGlobal.py

# zil: 2actions.zil:2611  <GLOBAL TOPIARY-NEAR>
# GLOBAL (state) TOPIARY_NEAR = False  ->  ZilGlobal.py

# zil: 2actions.zil:2613  <GLOBAL UNICORN-MSGS>
# GLOBAL (state) UNICORN_MSGS = LTABLE('There is a large, white animal partly hidden behind some trees.', 'You catch a glimpse of something white between two hedges.', 'A unicorn is cropping grass on the other side of the room.\nA gold key hangs from a ribbon around its neck.', 'There is a beautiful unicorn eating roses here. Around his\nneck is a red satin ribbon on which is strung a tiny key.')  ->  ZilGlobal.py

# zil: 2actions.zil:2622  <ROUTINE GARDEN-ROOM-FCN (RARG)>
@ZG.routine('GARDEN-ROOM-FCN')
def GARDEN_ROOM_FCN(RARG):
    if (RARG == ZG.M_ENTER):
        return ENABLE(ZG.QUEUE(ZG.I_GARDEN, -1))
    else:
        return False

# zil: 2actions.zil:2626  <ROUTINE GLOBAL-UNICORN-FCN ()>
@ZG.routine('GLOBAL-UNICORN-FCN')
def GLOBAL_UNICORN_FCN():
    if IN_p(ZG.UNICORN, ZG.GARDEN_NORTH):
        return TELL('The unicorn is way up at the north end of the garden.', CR)
    elif VERB_p('FIND', 'FOLLOW'):
        if FSET_p(ZG.UNICORN, Flag('TOUCHBIT')):
            return TELL("I don't know where it is now.", CR)
        else:
            return TELL('The unicorn is a mythical beast.', CR)
    else:
        return TELL('Unicorn? What unicorn?', CR)

# zil: 2actions.zil:2639  <ROUTINE UNICORN-FCN ()>
@ZG.routine('UNICORN-FCN')
def UNICORN_FCN():
    if ZG.HELLO_p(ZG.UNICORN):
        return TELL('The unicorn listens distractedly, then goes back to cropping grass.', CR)
    elif VERB_p('FOLLOW'):
        return TELL('The unicorn shies away as you approach.', CR)
    elif (VERB_p('EXAMINE') and (ZG.PRSO == ZG.UNICORN)):
        return TELL("The unicorn shies away as you approach for a closer look, but you do\nnotice a tiny gold key hanging from a red satin ribbon looped around\nthe animal's neck.", CR)
    elif VERB_p('EXAMINE'):
        return TELL('The unicorn shies away as you approach.', CR)
    elif VERB_p('TAKE', 'PUT', 'RUB', 'MUNG', 'ATTACK'):
        REMOVE(ZG.UNICORN)
        ZG.UNICORN_FRIGHTENED = True
        return TELL('The unicorn, unsurprised by this evidence that you are indeed the\nuncouth sort of vagabond it suspected you were, melts into the hedges\nand is gone.', CR)
    else:
        return False

# zil: 2actions.zil:2661  <GLOBAL UNICORN-FRIGHTENED>
# GLOBAL (state) UNICORN_FRIGHTENED = False  ->  ZilGlobal.py

# zil: 2actions.zil:2663  <ROUTINE GAZEBO-FCN ()>
@ZG.routine('GAZEBO-FCN')
def GAZEBO_FCN():
    if ((ZG.HERE == ZG.GARDEN_NORTH) and VERB_p('THROUGH')):
        ZG.DO_WALK('IN')
        return True
    elif ((ZG.HERE == ZG.GAZEBO_ROOM) and VERB_p('THROUGH')):
        return TELL("You're already in it.", CR)
    elif ((ZG.HERE == ZG.GAZEBO_ROOM) and VERB_p('LEAVE', 'EXIT')):
        ZG.DO_WALK('OUT')
        return True
    else:
        return False

# zil: 2actions.zil:2672  <ROUTINE CHEST-FCN ()>
@ZG.routine('CHEST-FCN')
def CHEST_FCN():
    if VERB_p('OPEN'):
        if ZG.PROB(25):
            ZG.V_OPEN()
            if (IN_p(ZG.PRINCESS, ZG.HERE) and (not ZG.PRINCESS_AWAKE)):
                TELL('The opening of the squeaky lid startles the young woman.', CR)
        else:
            TELL('The hinges are very rusty, but they seem to be starting to give.\nYou can probably open it if you try again. There is something\nbumping around inside.')
            if (IN_p(ZG.PRINCESS, ZG.HERE) and (not ZG.PRINCESS_AWAKE)):
                TELL(' All this rummaging around has startled\nthe young woman.')
            CRLF()
        PUTP(ZG.CHEST, 'ACTION', 0)
        if (IN_p(ZG.PRINCESS, ZG.HERE) and (not ZG.PRINCESS_AWAKE)):
            ZG.PERFORM(SYMBOL('V?ALARM'), ZG.PRINCESS)
        return True
    else:
        return False

# zil: 2actions.zil:2697  <GLOBAL PRINCESS-AWAKE>
# GLOBAL (state) PRINCESS_AWAKE = False  ->  ZilGlobal.py

# zil: 2actions.zil:2699  <ROUTINE PRINCESS-FCN ("AUX" (DEM <INT I-PRINCESS>))>
@ZG.routine('PRINCESS-FCN')
def PRINCESS_FCN():
    DEM = ZG.INT(ZG.I_PRINCESS)
    if VERB_p('FOLLOW'):
        if IN_p(ZG.PRINCESS, ZG.HERE):
            TELL("You can't follow her until she leaves...", CR)
        elif ZG.PRFOLLOW:
            ZG.DO_WALK(ZG.PRFOLLOW)
        else:
            TELL('I seem to have lost track of her.', CR)
        return True
    elif (not IN_p(ZG.PRINCESS, ZG.HERE)):
        return TELL('There is no princess here.', CR)
    elif VERB_p('ATTACK', 'MUNG', 'RAPE'):
        REMOVE(ZG.PRINCESS)
        TELL('The princess screams as you approach. "Won\'t someone deliver\nme from this awful fate?" she cries. ')
        if IN_p(ZG.WIZARD, ZG.HERE):
            TELL('Shocked, the Wizard of Frobozz turns toward you.')
        else:
            TELL('Just in time, the Wizard of Frobozz\nappears, seeming to unroll himself out of nothing like a window shade.')
        TELL(' "Fry!" he intones, and a massive bolt of lightning reduces you to a pile\nof smoking ashes. (Serves you right, too, if you ask me.)')
        return ZG.JIGS_UP()
    elif (ZG.HELLO_p(ZG.PRINCESS) or VERB_p('ALARM', 'KISS', 'EXAMINE', 'RUB')):
        if (IN_p(ZG.PRINCESS, ZG.DRAGON_LAIR) and (GET(DEM, ZG.C_ENABLED_p) == 0)):
            PUTP(ZG.PRINCESS, 'LDESC', 'There is a dishevelled and slightly unkempt princess here.')
            ENABLE(ZG.QUEUE(ZG.I_PRINCESS, 2))
            ZG.PRINCESS_AWAKE = True
            return TELL('The princess (for she is obviously one) shakes herself awake, then\nnotices you for the first time. She smiles. "Thank you for rescuing\nme from that horrid worm," she says. "I must depart. My parents will\nbe worried about me." With that, she arises, looking purposefully out\nof the lair.', CR)
        else:
            TELL('The princess ignores you. She looks about the room, but her eyes\nfix on the ')
            if (ZG.HERE == ZG.GAZEBO_ROOM):
                TELL('garden outside')
            elif (ZG.HERE == ZG.GARDEN_NORTH):
                TELL('gazebo')
            elif (ZG.HERE == ZG.RAVINE_LEDGE):
                TELL('ledge')
            else:
                TELL(GET(ZG.PRDIRS, (ZG.PRCOUNT * 4)))
            return TELL('.', CR)
    elif (not ZG.PRINCESS_AWAKE):
        return TELL("She's in a trance!", CR)
    else:
        return False

# zil: 2actions.zil:2755  <GLOBAL PRCOUNT>
# GLOBAL (state) PRCOUNT = 0  ->  ZilGlobal.py

# zil: 2actions.zil:2757  <GLOBAL PRFOLLOW>
# GLOBAL (state) PRFOLLOW = False  ->  ZilGlobal.py

# zil: 2actions.zil:2759  <GLOBAL PRDIRS>
# GLOBAL (state) PRDIRS = TABLE('south', ZG.DRAGON_ROOM, 'north', 'SOUTH', 'east', ZG.LEDGE_TUNNEL, 'west', 'EAST', 'east', ZG.RAVINE_LEDGE, 'west', 'EAST', 'down', ZG.DEEP_FORD, 'up', 'DOWN', 'south', ZG.MARBLE_HALL, 'north', 'SOUTH', 'east', ZG.STREAM_PATH, 'west', 'EAST', 'east', ZG.FORMAL_GARDEN, 'west', 'EAST', 'north', ZG.GARDEN_NORTH, 'south', 'NORTH', 'in', ZG.GAZEBO_ROOM, 'out', 'IN')  ->  ZilGlobal.py

# zil: 2actions.zil:2770  <ROUTINE I-PRINCESS ("AUX" (DEM <INT I-PRINCESS>) (OLDP <LOC ,PRINCESS>) (PC ...
@ZG.routine('I-PRINCESS')
def I_PRINCESS():
    DEM = ZG.INT(ZG.I_PRINCESS)
    OLDP = LOC(ZG.PRINCESS)
    PC = (ZG.PRCOUNT * 4)
    MOVE(ZG.PRINCESS, GET(ZG.PRDIRS, (PC + 1)))
    ZG.PRFOLLOW = False
    if (IN_p(ZG.PRINCESS, ZG.STREAM_PATH) and IN_p(ZG.WINNER, ZG.MARBLE_HALL)):
        TELL('The princess presses a loose piece of marble in the wall and a large\nsection of the wall slides away, revealing a passage to the east. She\nenters it.', CR)
        if IN_p(ZG.WINNER, OLDP):
            ZG.PRFOLLOW = GET(ZG.PRDIRS, (PC + 3))
        ZG.SECRET_DOOR = True
    elif (IN_p(ZG.PRINCESS, ZG.STREAM_PATH) and IN_p(ZG.WINNER, ZG.STREAM_PATH)):
        ZG.SECRET_DOOR = True
        TELL('The princess appears from behind some rocks, as though she had walked\nthrough a wall.', CR)
    elif IN_p(ZG.WINNER, OLDP):
        ZG.PRFOLLOW = GET(ZG.PRDIRS, (PC + 3))
        if (OLDP == ZG.GARDEN_NORTH):
            TELL('The princess enters the gazebo')
            if FSET_p(ZG.GAZEBO_ROOM, Flag('RMUNGBIT')):
                TELL(', although you would never get past\nthe debris. She must be magically protected.')
            TELL('.', CR)
        elif (OLDP == ZG.RAVINE_LEDGE):
            TELL('The princess climbs daintily down the rock face.', CR)
        else:
            TELL('The princess walks ')
            TELL(GET(ZG.PRDIRS, PC))
            TELL('. She glances back at you as she goes.', CR)
    elif IN_p(ZG.PRINCESS, ZG.HERE):
        if (ZG.HERE == ZG.GAZEBO_ROOM):
            TELL('The princess joins you in the gazebo.', CR)
        elif (ZG.HERE == ZG.DEEP_FORD):
            TELL('The princess climbs down the rock wall onto the beach.', CR)
        else:
            TELL('The princess enters from the ')
            TELL(GET(ZG.PRDIRS, (2 + PC)))
            TELL('. She seems surprised to see you.', CR)
    if IN_p(ZG.PRINCESS, ZG.GAZEBO_ROOM):
        ZG.DISABLE(DEM)
        ENABLE(ZG.QUEUE(ZG.I_UNICORN, 6))
    else:
        ZG.PRCOUNT = (ZG.PRCOUNT + 1)
        if ZG.PROB(75):
            _tmp1 = 1
        else:
            _tmp1 = 2
        if ZG.PROB(75):
            _tmp2 = 1
        else:
            _tmp2 = 2
        if ZG.PROB(75):
            _tmp3 = 1
        else:
            _tmp3 = 2
        if ZG.PROB(75):
            _tmp4 = 1
        else:
            _tmp4 = 2
        ENABLE(ZG.QUEUE(ZG.I_PRINCESS, _tmp4))
    return True

# zil: 2actions.zil:2822  <ROUTINE I-UNICORN ()>
@ZG.routine('I-UNICORN')
def I_UNICORN():
    if (ZG.HERE in (ZG.GAZEBO_ROOM, ZG.GARDEN_NORTH)):
        MOVE(ZG.ROSE, ZG.WINNER)
        FCLEAR(ZG.GOLD_KEY, Flag('NDESCBIT'))
        MOVE(ZG.GOLD_KEY, ZG.WINNER)
        ZG.SCORE_OBJ(ZG.GOLD_KEY)
        PUTP(ZG.GOLD_KEY, 'ACTION', 0)
        TELL('Shyly, a unicorn peeks out of the hedges. It notices the princess and\nseems captivated. It approaches her and bows its head as though curtseying\nto her. Around its neck is a red satin ribbon on which is strung a delicate\ngold key. The princess takes the ribbon and uses it to tie up her hair. She\nlooks at you and then, smiling, hands you the key and a fresh rose which she\nplucks from the arbor. "You may have use of such a thing," she says. "It\nis the least I can do for one who rescued me from a fate I dare not\ncontemplate." With that, she mounts the unicorn (side-saddle, of course)\nand rides off into the gloom.', CR)
        return REMOVE(ZG.PRINCESS)
    else:
        REMOVE(ZG.PRINCESS)
        MOVE(ZG.ROSE, ZG.GAZEBO_ROOM)
        return False

'SUBTITLE WIZARD WORKSHOP AND ENVIRONS'

# zil: 2actions.zil:2849  <ROUTINE MENHIR-ROOM-FCN (RARG)>
@ZG.routine('MENHIR-ROOM-FCN')
def MENHIR_ROOM_FCN(RARG):
    if ((RARG == ZG.M_FLASH) and ZG.MENHIR_POSITION):
        return ZG.DESCRIBE_MENHIR()
    elif (RARG == ZG.M_LOOK):
        TELL('This is a large room which was evidently used once as a quarry. Many\nlarge limestone chunks lie helter-skelter around the room. Some are\nrough-hewn and unworked, others smooth and well-finished. One side of\nthe room appears to have been used to quarry building blocks, the other\nto produce menhirs (standing stones). Obvious passages lead north and\nsouth.', CR)
        if IN_p(ZG.MENHIR, ZG.LOCAL_GLOBALS):
            ZG.DESCRIBE_MENHIR()
        return True
    else:
        return False

# zil: 2actions.zil:2864  <ROUTINE DESCRIBE-MENHIR ()>
@ZG.routine('DESCRIBE-MENHIR')
def DESCRIBE_MENHIR():
    if (ZG.HERE == ZG.MENHIR_ROOM):
        if (ZG.MENHIR_POSITION == False):
            TELL('One particularly large menhir, at least twenty feet tall and eight feet\nthick, is leaning against the wall blocking a dark opening leading\nsouthwest. On this side of the menhir is carved an ornate letter "F".', CR)
        elif (ZG.MENHIR_POSITION == 1):
            TELL('There is a huge menhir lying on the floor near a southwest passage.', CR)
        elif (ZG.MENHIR_POSITION == 2):
            TELL('A dark opening leads southwest.', CR)
        elif (ZG.MENHIR_POSITION == 3):
            TELL('There is a huge menhir here.', CR)
        else:
            TELL('There is a huge menhir floating like a feather in midair here. A\npassage to the southwest opens beneath it.', CR)
        if (ZG.HERE == ZG.MUNGED_ROOM):
            TELL('The explosion appears to have had no effect on the menhir.', CR)
        return True
    else:
        return TELL('A dark opening leads southwest.', CR)

# zil: 2actions.zil:2889  <GLOBAL MENHIR-POSITION>
# GLOBAL (state) MENHIR_POSITION = False  ->  ZilGlobal.py

# zil: 2actions.zil:2891  <ROUTINE MENHIR-FCN ()>
@ZG.routine('MENHIR-FCN')
def MENHIR_FCN():
    if VERB_p('LOOK-UNDER', 'LOOK-BEHIND'):
        if ZG.MENHIR_POSITION:
            return TELL('Behind the menhir is some air and then a wall.', CR)
        else:
            return TELL('The gap between the menhir and the wall is very narrow, but it is clear\nthat there is a sizeable room in there. Your light only reveals a part of\nthe far wall.', CR)
    elif VERB_p('TAKE', 'MOVE', 'TURN'):
        return TELL("The menhir weighs many tons and is eight feet wide. You can't even get\na grip on it, much less move it.", CR)
    elif VERB_p('READ'):
        return TELL('"F"', CR)
    elif VERB_p('EXAMINE'):
        return TELL('It is nicely finished, and the letter "F" on it is particularly well\ncarved.', CR)
    elif (VERB_p('ENCHANT') and (ZG.SPELL_USED == WORD('float'))):
        TELL('The menhir floats majestically into the air, rising about ten feet.\nThe passage beneath it beckons invitingly.', CR)
        ZG.MENHIR_POSITION = 3
        return ZG.MENHIR_POSITION
    elif (VERB_p('DISENCHANT') and (ZG.SPELL_USED == WORD('float'))):
        ZG.MENHIR_POSITION = False
        if (ZG.HERE in (ZG.MENHIR_ROOM, ZG.KENNEL)):
            return TELL('The menhir sinks to the ground.', CR)
        else:
            return False
    else:
        return False

# zil: 2actions.zil:2922  <GLOBAL GUARDIAN-FED>
# GLOBAL (state) GUARDIAN_FED = False  ->  ZilGlobal.py

# zil: 2actions.zil:2924  <ROUTINE DOOR-KEEPER-FCN ()>
@ZG.routine('DOOR-KEEPER-FCN')
def DOOR_KEEPER_FCN():
    if (VERB_p('ALARM') and ZG.GUARDIAN_FED):
        return TELL("Try as you may, you can't wake it.", CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.DOOR_KEEPER)):
        if ZG.GUARDIAN_FED:
            return TELL('He is asleep, at least for the moment.', CR)
        elif (ZG.PRSO == ZG.CANDY):
            ZG.GUARDIAN_FED = True
            REMOVE(ZG.CANDY)
            return TELL('The guardian greedily wolfs down the candy, including the package. (It\nseemed to enjoy the grasshoppers particularly.) It then becomes\nquiet and its eyes close. (Lizards are known to sleep a long time while\ndigesting their meals.)', CR)
        elif (ZG.PRSO == ZG.FLASK):
            return TELL('The lizard sniffs it experimentally, then looks at you angrily, hissing\nand snapping.', CR)
        elif ZG.BOMB_p(ZG.PRSO):
            REMOVE(ZG.PRSO)
            return TELL("The guardian greedily wolfs it down. After a while, you hear a\nvery small pop and the guardian's eyes bulge out. It hisses nastily\nat you.", CR)
        elif (ZG.PRSO in (ZG.PALANTIR_1, ZG.PALANTIR_2, ZG.PALANTIR_3)):
            TELL('The guardian greedily gobbles the sphere, but finds it unchewable. He\nthen tries repeatedly to swallow it whole, with disappointing results.\nFinally, he spits it on the ground.', CR)
            return MOVE(ZG.PRSO, ZG.HERE)
        else:
            REMOVE(ZG.PRSO)
            return TELL('The lizard wolfs down the ', D, ZG.PRSO, ', crunching greedily.', CR)
    elif VERB_p('ATTACK', 'MUNG'):
        return TELL("The guardian seems impervious to your attack. In fact, your blows\ndon't even seem to be landing.", CR)
    else:
        return False

# zil: 2actions.zil:2964  <GLOBAL WIZ-DOOR-FLAG>
# GLOBAL (state) WIZ_DOOR_FLAG = False  ->  ZilGlobal.py

# zil: 2actions.zil:2966  <ROUTINE WIZ-DOOR-FCN ()>
@ZG.routine('WIZ-DOOR-FCN')
def WIZ_DOOR_FCN():
    if (not ZG.GUARDIAN_FED):
        if VERB_p('OPEN'):
            return TELL('The lizard comes to life and snaps at you as you reach for the\nhandle.', CR)
        elif VERB_p('UNLOCK'):
            TELL('The lizard door keeper comes awake and bites at your hand. You\njerk away just in time.')
            if ((ZG.PRSI == ZG.GOLD_KEY) and ZG.PROB(5)):
                REMOVE(ZG.GOLD_KEY)
                return TELL(' The guardian does get the\nkey, though. It grins maniacally.', CR)
            elif ZG.PROB(20):
                MOVE(ZG.GOLD_KEY, ZG.HERE)
                return TELL(' You drop the key, though.', CR)
            else:
                return CRLF()
        else:
            return False
    elif VERB_p('UNLOCK'):
        if ZG.WIZ_DOOR_FLAG:
            return TELL('It is already!', CR)
        elif (ZG.PRSI == ZG.GOLD_KEY):
            ZG.WIZ_DOOR_FLAG = True
            return TELL('The key turns and the bolt clicks. The door is unlocked.', CR)
        else:
            ZG.WIZ_DOOR_FLAG = False
            return TELL("That won't unlock it.", CR)
    elif VERB_p('LOCK'):
        if (not ZG.WIZ_DOOR_FLAG):
            return TELL('It is locked already.', CR)
        elif (ZG.PRSI == ZG.GOLD_KEY):
            TELL('The door is now locked.', CR)
            ZG.WIZ_DOOR_FLAG = False
            return True
        else:
            return TELL("That won't lock it.", CR)
    elif VERB_p('OPEN', 'CLOSE'):
        if ZG.WIZ_DOOR_FLAG:
            return ZG.OPEN_CLOSE(ZG.PRSO, 'The door creaks open.', 'The door reluctantly closes.')
        elif VERB_p('OPEN'):
            return TELL('The door is locked!', CR)
        else:
            return False
    else:
        return False

# zil: 2actions.zil:3010  <ROUTINE GUARDIAN-ROOM-FCN (RARG)>
@ZG.routine('GUARDIAN-ROOM-FCN')
def GUARDIAN_ROOM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('This room is cobwebby and musty, but tracks in the dust show that it has\nseen visitors recently. At the south end of the room is a stained and\nbattered (but very strong-looking) door. To the north, a corridor exits.', CR)
        if FSET_p(ZG.WIZ_DOOR, Flag('OPENBIT')):
            TELL('The door is open.', CR)
        if (not ZG.GUARDIAN_FED):
            TELL('Imbedded in the door is a nasty-looking lizard head, with sharp\nteeth and beady eyes. ')
            if IN_p(ZG.CANDY, ZG.WINNER):
                return TELL('The lizard is sniffing at you.', CR)
            else:
                return TELL('The eyes move to watch you approach.', CR)
        else:
            return TELL('A sleepy-looking lizard head is mounted on the door.', CR)
    else:
        return False

# zil: 2actions.zil:3031  <ROUTINE WORKSHOP-FCN (RARG)>
@ZG.routine('WORKSHOP-FCN')
def WORKSHOP_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL("You are standing in the entry hall of the Wizard's Workshop. Dark\ncorridors lead west and south from here. The corridor to the west\nsmells slightly of incense or candle smoke.")
        if FSET_p(ZG.WIZ_DOOR, Flag('OPENBIT')):
            TELL(' The workshop door is open.')
        CRLF()
        return True
    else:
        return False

# zil: 2actions.zil:3042  <ROUTINE ARCANA-PSEUDO ()>
@ZG.routine('ARCANA-PSEUDO')
def ARCANA_PSEUDO():
    if VERB_p('TAKE'):
        return TELL('The stuff on the bench appears to be so much junk, and you decide that\nit would only get in your way if you took it.', CR)
    else:
        return False

# zil: 2actions.zil:3048  <ROUTINE TROPHY-PSEUDO ()>
@ZG.routine('TROPHY-PSEUDO')
def TROPHY_PSEUDO():
    if VERB_p('READ'):
        return False
    elif VERB_p('TAKE', 'RUB'):
        return TELL('As your fingers near it, you get a nasty shock (but fortunately not a fatal\none).', CR)
    else:
        return False

# zil: 2actions.zil:3055  <ROUTINE STAND-FCN ()>
@ZG.routine('STAND-FCN')
def STAND_FCN():
    if VERB_p('TAKE'):
        return TELL('The ', D, ZG.PRSO, ' is firmly attached to the bench.', CR)
    elif (VERB_p('PUT', 'PUT-ON') and (ZG.PRSO in (ZG.PALANTIR_1, ZG.PALANTIR_2, ZG.PALANTIR_3)) and (ZG.PRSI in (ZG.STAND_1, ZG.STAND_2, ZG.STAND_3))):
        ZG.V_PUT()
        if (IN_p(ZG.PALANTIR_1, ZG.STAND_1) and IN_p(ZG.PALANTIR_2, ZG.STAND_2) and IN_p(ZG.PALANTIR_3, ZG.STAND_3)):
            REMOVE(ZG.PALANTIR_1)
            REMOVE(ZG.PALANTIR_2)
            REMOVE(ZG.PALANTIR_3)
            MOVE(ZG.STAND_4, ZG.WORKBENCH)
            TELL('As you place the ', D, ZG.PRSO, ' in the ', D, ZG.PRSI, ', a low humming noise\nbegins, and you can feel the hairs on the back of your neck begin to\nstand up. The three spheres begin to vibrate, faster and faster, as\nthe noise becomes higher and higher pitched. Three puffs of smoke, one\nred, one blue, one white, rise up from empty stands. The spheres are gone!\nBut in the center of the triangle formed by the stands is now a black stand\nof obsidian in which rests a strange black sphere.', CR)
        return True
    else:
        return False

# zil: 2actions.zil:3079  <ROUTINE IN-AQUARIUM-FCN (RARG)>
@ZG.routine('IN-AQUARIUM-FCN')
def IN_AQUARIUM_FCN(RARG):
    if (RARG == ZG.M_LOOK):
        TELL('There is a sandy floor here, and your vision seems murky and blurred.\nThe wall you are looking at is nicely dressed stone.', CR)
        if IN_p(ZG.SERPENT, ZG.AQUARIUM):
            if ZG.PROB(25):
                TELL('While you watch a shadow seems to pass overhead.', CR)
            elif ZG.PROB(5):
                TELL('The head of some horrible serpent pokes into view, its beady green eyes\nalmost seeming to see you.', CR)
        return True
    elif (RARG == ZG.M_ENTER):
        if IN_p(ZG.SERPENT, ZG.AQUARIUM):
            return ZG.JIGS_UP("You drop into the aquarium with a splash (which attracts the serpent).\nHe greedily eats you. He's just a baby, after all, and needs all the\nfood he can get.")
        else:
            return ZG.JIGS_UP("Oh dear, you have cut yourself severely on the broken glass. I'm afraid\nyou've bled to death.")
    else:
        return False

# zil: 2actions.zil:3103  <ROUTINE AQUARIUM-FCN ("AUX" OBJ)>
@ZG.routine('AQUARIUM-FCN')
def AQUARIUM_FCN():
    OBJ_l = 0
    if VERB_p('BOARD', 'THROUGH'):
        ZG.DO_WALK('IN')
        return True
    elif (VERB_p('LOOK-INSIDE') and IN_p(ZG.SERPENT, ZG.AQUARIUM)):
        return TELL('In the aquarium is a baby sea-serpent who eyes you suspiciously. His\nscaly body writhes about in the huge tank.', CR)
    elif ((VERB_p('MUNG', 'ATTACK') and (ZG.PRSO == ZG.AQUARIUM)) or (VERB_p('THROW') and (ZG.PRSI == ZG.AQUARIUM))):
        if (ZG.PRSO == ZG.AQUARIUM):
            if (not ZG.PRSI):
                return False
            else:
                OBJ_l = ZG.PRSI
        else:
            OBJ_l = ZG.PRSO
        MOVE(OBJ_l, ZG.HERE)
        if IN_p(ZG.DEAD_SERPENT, ZG.HERE):
            TELL('The aquarium is already broken!', CR)
            return True
        elif (OBJ_l == ZG.FLASK):
            ZG.JIGS_UP('The flask shatters, and poison gas fills the room!')
            return True
        elif ZG.BOMB_p(OBJ_l):
            return ZG.DISABLE(ZG.INT(ZG.I_FUSE))
        elif (FSET_p(OBJ_l, Flag('WEAPONBIT')) or (GETP(OBJ_l, 'SIZE') > 10)):
            REMOVE(ZG.SERPENT)
            MOVE(ZG.PALANTIR_3, ZG.AQUARIUM)
            FCLEAR(ZG.PALANTIR_3, Flag('NDESCBIT'))
            PUTP(ZG.AQUARIUM, 'LDESC', 'A shattered aquarium fills the northern half of the room.')
            MOVE(ZG.DEAD_SERPENT, ZG.HERE)
            TELL('The ', D, OBJ_l, ' shatters the glass wall of the aquarium, spilling out\nan impressive amount of salt water and wet sand. It also spills out an\nextremely annoyed sea serpent who bites angrily at the ', D, OBJ_l, ', and\nthen at you. He is having difficulty breathing, and he seems to hold you\nresponsible for his current problem.')
            if VERB_p('MUNG'):
                TELL(' He manages to rend you limb from limb before he drowns in the\nair.', CR)
                return ZG.JIGS_UP('I guess you were too careless.')
            else:
                return TELL(' He tries to slither across the stone floor towards you. Fortunately,\nhe expires mere inches away from biting off your foot. A clear crystal\nsphere sits amid the sand and broken glass on the bottom of the\naquarium.', CR)
        else:
            return TELL('The ', D, OBJ_l, ' bounces harmlessly off the glass.', CR)
    else:
        return False

# zil: 2actions.zil:3156  <ROUTINE SERPENT-FCN ()>
@ZG.routine('SERPENT-FCN')
def SERPENT_FCN():
    if (ZG.SERPENT == ZG.WINNER):
        return TELL('The serpent only stares hungrily at you.', CR)
    elif VERB_p('ATTACK', 'MUNG'):
        return TELL("He swims towards you with a powerful stroke of his flippers, dagger-like\nteeth dripping. Fortunately, he doesn't want to crash into the aquarium\nwall, and contents himself with splashing you with water.", CR)
    elif (VERB_p('PUT') and (ZG.PRSO == ZG.SERPENT)):
        return TELL('Impossible for many reasons.', CR)
    elif VERB_p('TAKE', 'GIVE'):
        return ZG.JIGS_UP('He takes you instead. *Uurrp!*')
    else:
        return False

# zil: 2actions.zil:3172  <ROUTINE DEAD-SERPENT-FCN ()>
@ZG.routine('DEAD-SERPENT-FCN')
def DEAD_SERPENT_FCN():
    if VERB_p('TAKE'):
        return TELL("This may only be a baby sea serpent, but it's as big as a small whale.", CR)
    else:
        return False

# zil: 2actions.zil:3177  <ROUTINE GENIE-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" V HOARD)>
@ZG.routine('GENIE-FCN')
def GENIE_FCN(RARG=None):
    if RARG is None:
        RARG = ZG.M_OBJECT
    V = 0
    HOARD = 0
    if VERB_p('HELLO'):
        return TELL('The genie grins demonically, but says nothing.', CR)
    elif (ZG.WINNER == ZG.GENIE):
        if (not ZG.GENIE_READY_p):
            TELL('"My fee is not paid! I perform no tasks for free! We demons have a\nstrong union these days."', CR)
            return 2
        elif VERB_p('SGIVE'):
            return False
        elif ((GET(ZG.P_PRSO, 0) > 1) or (GET(ZG.P_PRSI, 0) > 1)):
            TELL('"I will do one thing only, oh gracious master!"', CR)
            return 2
        elif (VERB_p('MOVE') and (ZG.PRSO == ZG.GLOBAL_MENHIR)):
            ZG.MENHIR_POSITION = 1
            TELL('The demon is gone for a moment. "A trifle... My little finger alone\nwas enough."', CR)
            return ZG.GENIE_LEAVES()
        elif VERB_p('TAKE'):
            if (ZG.PRSO == ZG.GLOBAL_MENHIR):
                REMOVE(ZG.MENHIR)
                ZG.MENHIR_POSITION = 2
                TELL('The demon flashes away for a second. "I have little use for such a\nthing, but perhaps as a doorstop..."', CR)
                return ZG.GENIE_LEAVES()
            elif (ZG.PRSO == ZG.WAND):
                TELL('"This I do gladly, oh fool!" cackles the demon gleefully. He stretches\nout an enormous hand towards the wand and taking it like a toothpick (this\nis a large demon), points it at himself. "Free!" he commands, and the\ndemon and his wand vanish forever.', CR)
                ZG.GENIE_LEAVES(False)
                return REMOVE(ZG.WAND)
            elif FSET_p(ZG.PRSO, Flag('TAKEBIT')):
                ZG.GENIE_LEAVES(False)
                REMOVE(ZG.PRSO)
                return TELL('The demon snaps his fingers, the ', D, ZG.PRSO, ' spins wildly in the air in\nfront of him, then he and it depart.', CR)
            else:
                return TELL('"I fear that I cannot take such a thing."', CR)
        elif (VERB_p('GIVE') and (ZG.PRSI == ZG.ME)):
            if (ZG.PRSO == ZG.WAND):
                TELL('"I hear and obey!" says the demon. He stretches out an enormous hand\ntowards the wand. The Wizard is unsure what to do, pointing it threateningly\nat the demon, then at you. "Fudge!" he cries, but aside from a strong\nodor of chocolate in the air, there is no effect. The demon plucks the\nwand out of his hand (it\'s about toothpick-size to him) and gingerly lays\nit before you. He fades into the smoke, which disperses.\nThe wizard runs from the room in terror.', CR)
                REMOVE(ZG.WIZARD)
                ZG.GENIE_LEAVES(False)
                FCLEAR(ZG.WAND, Flag('NDESCBIT'))
                return MOVE(ZG.WAND, ZG.HERE)
            elif (ZG.PRSO == ZG.GLOBAL_MENHIR):
                MOVE(ZG.MENHIR, ZG.PENTAGRAM_ROOM)
                FCLEAR(ZG.MENHIR, Flag('NDESCBIT'))
                FCLEAR(ZG.MENHIR, Flag('TAKEBIT'))
                ZG.MENHIR_POSITION = 3
                TELL('He waves his hands, and the menhir drops softly at your feet.', CR)
                return ZG.GENIE_LEAVES()
            elif FSET_p(ZG.PRSO, Flag('TAKEBIT')):
                MOVE(ZG.PRSO, ZG.PENTAGRAM_ROOM)
                TELL('The ', D, ZG.PRSO, ' appears before you and settles to the ground.', CR)
                return ZG.GENIE_LEAVES()
            else:
                return TELL('"Were it possible, this would be my fondest wish, but alas..."', CR)
        elif VERB_p('ATTACK'):
            if (ZG.PRSO == ZG.GLOBAL_CERBERUS):
                return TELL('"This may prove taxing, but we\'ll see. Perhaps I\'ll tame him for a\npup instead." The demon disappears for an instant, then reappears. He\nlooks rather gnawed and scratched. He winces. "Too much for me. Puppy\ndog, indeed. You\'re welcome to him. Never did like dogs anyway... Any\nother orders, oh beneficent one?"', CR)
            elif (ZG.PRSO == ZG.WIZARD):
                TELL('The demon grins hideously. "This has been my desire e\'er since this\ncharlatan bent me to his service. I perform this deed with pleasure!"\nThe demon forms himself back into a cloud of greasy smoke. The cloud\nenvelops the Wizard, who waves his wand fruitlessly, mumbling various\nphrases which begin with "F". A horrible scream is heard, and the smoke\nbegins to clear. Nothing remains of the Wizard but his wand.', CR)
                REMOVE(ZG.WIZARD)
                FCLEAR(ZG.WAND, Flag('NDESCBIT'))
                MOVE(ZG.WAND, ZG.HERE)
                return ZG.GENIE_LEAVES()
            elif (ZG.PRSO == ZG.ME):
                ZG.GENIE_LEAVES(False)
                ZG.WINNER = ZG.ADVENTURER
                return ZG.JIGS_UP('"Foolish mortal, if you insist..." The demon crushes you with one\nblow of his enormous hand.')
            else:
                return TELL('"I know no way to kill a ', D, ZG.PRSO, '."', CR)
        elif VERB_p('FIND', 'EXAMINE'):
            TELL('"I am not permitted to ')
            if VERB_p('FIND'):
                TELL('answer questions')
            else:
                TELL('perform such menial tasks')
            return TELL('. The terms of my contract\nare explicit on this matter, learned one. Surely you would not wish to\nviolate my contract?" He licks his lips with a forked tongue like a\nsnake\'s. "The penalty clauses are ... hmm ... devilish."', CR)
        else:
            TELL('"Apologies, oh master, but even for such a one as I this is not possible."\nHe seems somewhat chagrined to have to admit this.', CR)
            return True
    elif VERB_p('EXORCISE', 'ATTACK', 'MUNG'):
        return TELL('The demon laughs uproariously.', CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.GENIE)):
        if ((ZG.PRSO == ZG.IRON_BOX) and IN_p(ZG.VIOLIN, ZG.PRSO)):
            TELL('The genie frowns briefly, then ')
            if FSET_p(ZG.PRSO, Flag('OPENBIT')):
                TELL('looks inside')
            else:
                TELL('opens')
            TELL(' the box. He smiles horribly.', CR)
            ZG.REMOVE_CAREFULLY(ZG.IRON_BOX)
            ZG.PRSO = ZG.VIOLIN
        if (GETPT(ZG.PRSO, 'VALUE') and (not (ZG.PRSO == ZG.SWORD))):
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            ZG.GENIE_HOARD = (ZG.GENIE_HOARD + 1)
            ZG.SCORE_UPD(2)
            HOARD = (ZG.GENIE_HOARD + ZG.CASE_WORTH())
            if (not (HOARD < ZG.TREASURES_MAX)):
                ZG.GENIE_READY_p = True
                PUTP(ZG.WIZARD, 'LDESC', 'A dejected and fearful Wizard watches from the corner.')
                return TELL('"This will do for my fee. \'Tis a paltry hoard, but as you have done\nme a small service by loosing me from this wizard, it will suffice."', CR)
            else:
                TELL('"', GET(ZG.GENIE_THANKS, HOARD), '"', CR)
                if (HOARD == 8):
                    TELL('The Wizard looks at you as if you are a madman. He tears his beard and\nstares at you fearfully.', CR)
                return True
        elif ZG.BOMB_p(ZG.PRSO):
            ZG.GENIE_LEAVES(False)
            return TELL('"I fear that this violates my contract, oh foolish one. Thus, I am\nfree to depart."', CR)
        else:
            ZG.REMOVE_CAREFULLY(ZG.PRSO)
            return TELL('The demon gladly takes the ', D, ZG.PRSO, ' and smiles balefully,\nrevealing enormous fangs.', CR)
    else:
        return False

# zil: 2actions.zil:3343  <ROUTINE GENIE-LEAVES ("OPTIONAL" (NOISY? T))>
@ZG.routine('GENIE-LEAVES')
def GENIE_LEAVES(NOISY_p=None):
    if NOISY_p is None:
        NOISY_p = True
    FSET(ZG.GENIE, Flag('INVISIBLE'))
    if NOISY_p:
        TELL('The genie departs, his agreement fulfilled.', CR)
    ZG.P_CONT = False
    return 2

# zil: 2actions.zil:3350  <GLOBAL GENIE-READY?>
# GLOBAL (state) GENIE_READY_p = False  ->  ZilGlobal.py

# zil: 2actions.zil:3351  <GLOBAL GENIE-HOARD>
# GLOBAL (state) GENIE_HOARD = 0  ->  ZilGlobal.py

# zil: 2actions.zil:3352  <CONSTANT TREASURES-MAX>
# CONSTANT (const) TREASURES_MAX = 10  ->  ZilGlobal.py

# ;"all treasures but palantirs(4),
# 				  candy, collar, wand."

# zil: 2actions.zil:3355  <GLOBAL GENIE-THANKS>
# GLOBAL (state) GENIE_THANKS = LTABLE("Most fine, master! But 'tis not enough. I will do a great service,\nand are not great services bought at great price?", 'Very nice, but not enough!', 'Ah, truly magnificent! Keep them coming.', 'Almost halfway there, oh worthy one!', 'Oh, such beauty! Your generosity almost overwhelms me!', 'Truly I shall do thee a wonderful service when thou hast finished!', 'Truly you are most generous! But still, this is yet not enough.', 'A fine gift, mighty one, you have almost reached my fee.', 'Wondrous fine, master! But one treasure is yet to be given!')  ->  ZilGlobal.py

# zil: 2actions.zil:3367  <ROUTINE CASE-WORTH ("AUX" F (W 0))>
@ZG.routine('CASE-WORTH')
def CASE_WORTH():
    F = 0
    W = 0
    F = FIRST_p(ZG.WIZARD_CASE)
    while True:
        if (not F):
            return W
        if GETPT(F, 'VALUE'):
            W = (W + 1)
        F = NEXT_p(F)

# zil: 2actions.zil:3375  <ROUTINE PENTAGRAM-FCN ("OPTIONAL" (RARG ,M-BEG))>
@ZG.routine('PENTAGRAM-FCN')
def PENTAGRAM_FCN(RARG=None):
    if RARG is None:
        RARG = ZG.M_BEG
    if (RARG == ZG.M_BEG):
        if VERB_p('THROUGH', 'BOARD'):
            return TELL('You try to enter the pentagram, but are forced back by an invisible\npower.', CR)
        elif (VERB_p('PUT', 'PUT-ON') and (ZG.PRSO == ZG.PALANTIR_4)):
            REMOVE(ZG.PALANTIR_4)
            FCLEAR(ZG.GENIE, Flag('INVISIBLE'))
            MOVE(ZG.GENIE, ZG.PENTAGRAM_ROOM)
            return TELL('A cold wind blows outward from the sphere. The candles flicker, and a\nlow moan, almost inaudible, is heard. It rises in volume and pitch\nuntil it becomes a high-pitched keening. A dim shape becomes visible in\nthe air above the sphere. The shape resolves into a large and somewhat\nformidable looking demon. He looks around, tests the walls of the\npentagram experimentally, then sees you! "Hmm, a new master..." he\nsays under his breath. "Greetings, oh master! Wouldst desire a\nservice, as our contract stateth? For some pittance of wealth, some\ntrifle, I will gratify thy desires to the utmost limit of my powers, and\nthey are not inconsiderable." He makes a pass with his massive arms and\nthe walls begin to shake a little. Another pass and the shaking stops.\n"A nice effect... I find it makes for a better relationship to give\nsuch a demonstration early on." He grins vilely.', CR)
        else:
            return False
    else:
        return False

# zil: 2actions.zil:3400  <ROUTINE WIZARD-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" OLIT)>
@ZG.routine('WIZARD-FCN')
def WIZARD_FCN(RARG=None):
    if RARG is None:
        RARG = ZG.M_OBJECT
    OLIT = 0
    if (ZG.WINNER == ZG.WIZARD):
        if VERB_p('GIVE'):
            return TELL('The Wizard replies "Foolishment!"', CR)
        else:
            return TELL('The Wizard considers your statement carefully. His expression indicates\nhe regards it as fanciful.', CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.WIZARD)):
        OLIT = ZG.LIT
        ZG.REMOVE_CAREFULLY(ZG.PRSO)
        if ZG.BOMB_p(ZG.PRSO):
            if IN_p(ZG.GENIE, ZG.PENTAGRAM_ROOM):
                MOVE(ZG.PRSO, ZG.HERE)
                return TELL('The wizard accepts this final folly resignedly.', CR)
            else:
                REMOVE(ZG.WIZARD)
                return TELL('"Hmm..." The Wizard mutters something, then waves his wand over the\nbomb. It transforms into a bouquet of flowers. Both Wizard and\nflowers disappear.', CR)
        elif (OLIT and (not ZG.LIT)):
            return TELL('"Thank you." As the Wizard places the ', D, ZG.PRSO, ' under his robe, the\nroom becomes dark.', CR)
        else:
            return TELL('"Thank you."', CR)
    elif ZG.HELLO_p(ZG.WIZARD):
        return TELL('The Wizard seems surprised, much as you might be if a dog talked.', CR)
    elif VERB_p('ATTACK', 'MUNG'):
        REMOVE(ZG.WIZARD)
        if IN_p(ZG.WAND, ZG.WIZARD):
            TELL('The Wizard retreats, waving his wand and chanting. He says "Fear!"\n')
        else:
            TELL('The Wizard tries to cast the "Fear!" spell, but without his wand!\n')
        if (not FSET_p(ZG.GENIE, Flag('INVISIBLE'))):
            return TELL('Nothing happens! With a terrified glance at the demon, the wizard\nruns past you and out of the room.', CR)
        else:
            TELL('You are suddenly terrified. The Wizard seems huge and terrible,\nlooming over you. You flee, terrified. He chuckles, snaps his fingers, and\ndisappears.', CR, CR)
            ZG.SPELL_p = ZG.S_FEAR
            PUTP(ZG.ADVENTURER, 'ACTION', ZG.MAGIC_ACTOR)
            ENABLE(ZG.QUEUE(ZG.I_WIZARD, 10))
            return ZG.RANDOM_WALK()
    else:
        return False

# zil: 2actions.zil:3455  <ROUTINE I-WIZARD ("AUX" CAST-PROB (PCNT 0) F (WLOC <LOC ,WINNER>))>
@ZG.routine('I-WIZARD')
def I_WIZARD():
    CAST_PROB = 0
    PCNT = 0
    F = 0
    WLOC = LOC(ZG.WINNER)
    ENABLE(ZG.QUEUE(ZG.I_WIZARD, 4))
    if ZG.DEAD:
        return False
    elif ZG.SPELL_p:
        if (ZG.SPELL_p == ZG.S_FLOAT):
            if (ZG.HERE == ZG.WELL_TOP):
                ZG.JIGS_UP('You plunge to the bottom of the shaft as the spell wears off.')
                return True
            elif (FSET_p(ZG.HERE, Flag('NONLANDBIT')) and (not (ZG.HERE in (ZG.WELL_BOTTOM, ZG.VOLCANO_BOTTOM)))):
                ZG.JIGS_UP('As the spell wears off, you find yourself making a half-gainer\ntowards the bottom of the volcano.')
                return True
        elif (ZG.SPELL_p == ZG.S_FEEBLE):
            ZG.LOAD_ALLOWED = ZG.LOAD_MAX
        elif (ZG.SPELL_p == ZG.S_FIERCE):
            ZG.SWORD_GLOW = 0
        elif (ZG.SPELL_p == ZG.S_FUMBLE):
            ZG.FUMBLE_NUMBER = 7
            ZG.FUMBLE_PROB = 8
        if GET(ZG.SPELL_STOPS, ZG.SPELL_p):
            TELL(GET(ZG.SPELL_STOPS, ZG.SPELL_p), CR)
        PUTP(ZG.ADVENTURER, 'ACTION', 0)
        ZG.SPELL_p = False
        return True
    if IN_p(ZG.GENIE, ZG.PENTAGRAM_ROOM):
        ZG.DISABLE(ZG.INT(ZG.I_WIZARD))
        if (not IN_p(ZG.WIZARD, ZG.PENTAGRAM_ROOM)):
            MOVE(ZG.WIZARD, ZG.PENTAGRAM_ROOM)
            if IN_p(ZG.WINNER, ZG.PENTAGRAM_ROOM):
                TELL('Suddenly the Wizard materializes in the room. He is astonished by what\nhe sees: his servant in deep conversation with a common adventurer! He\ndraws forth his wand, waves it frantically, and incants "Frobizz!\nFrobozzle! Frobnoid!" The demon laughs heartily. "You no longer\ncontrol the Black Crystal, hedge-wizard! Your wand is powerless! Your\ndoom is sealed!" The demon turns to you, expectantly.', CR)
        return True
    if ((not ZG.LIT) and FSET_p(ZG.LAMP, Flag('RMUNGBIT')) and (ZG.SCORE > 200)):
        ZG.ALWAYS_LIT = True
        ZG.LIT = True
        TELL('In the darkness you hear the voice of the Wizard. "Dear me, you seem\nto have gotten into quite a pickle." He chuckles. "Fluoresce!" he\nincants. It is no longer dark.', CR)
        return True
    if (LOC(ZG.WIZARD) and ZG.PROB(80)):
        if (ZG.LIT and IN_p(ZG.WIZARD, ZG.HERE)):
            TELL('The Wizard vanishes.', CR)
        REMOVE(ZG.WIZARD)
        return True
    if ZG.PROB(10):
        if (not ZG.LIT):
            TELL('You feel a slight outrush of air as something moves nearby.', CR)
        elif (ZG.HERE in (ZG.POSTS_ROOM, ZG.POOL_ROOM)):
            TELL('A huge and terrible wizard appears before you, as large as the largest\ntree! He looks down on you as you would look upon a gnat!', CR)
        elif FSET_p(ZG.HERE, Flag('NONLANDBIT')):
            TELL('The Wizard appears, floating nonchalantly in the air beside you. He\ngrins sideways at you.', CR)
        else:
            TELL('A strange little man in a long cloak appears suddenly in the room.\nHe is wearing a high pointed hat embroidered with astrological signs.\nHe has a long, stringy, and unkempt beard.', CR)
        if IN_p(ZG.PALANTIR_4, ZG.ADVENTURER):
            if ZG.LIT:
                TELL('The Wizard notices that you carry the Black Crystal, and with an\nunseemly haste, he disappears.', CR)
            else:
                TELL('You feel a sudden inrush of air as though something disappeared.', CR)
            REMOVE(ZG.WIZARD)
            return True
        elif ZG.PROB(20):
            if ZG.LIT:
                TELL('He mutters something (muffled by his beard) and disappears as suddenly\nas he came.', CR)
            else:
                TELL('You hear low, confused muttering.', CR)
            REMOVE(ZG.WIZARD)
            return True
        if IN_p(ZG.PALANTIR_1, ZG.ADVENTURER):
            PCNT = (PCNT + 1)
        if IN_p(ZG.PALANTIR_2, ZG.ADVENTURER):
            PCNT = (PCNT + 1)
        if IN_p(ZG.PALANTIR_3, ZG.ADVENTURER):
            PCNT = (PCNT + 1)
        CAST_PROB = (80 - (PCNT * 20))
        if ZG.LIT:
            TELL('The Wizard draws forth his wand and waves it in your direction. It\nbegins to glow with a faint blue glow.', CR)
        else:
            TELL('Suddenly, illuminated by the faint blue glow of a magic wand pointed\nin your direction, you see the Wizard!', CR)
        if ZG.PROB(CAST_PROB):
            MOVE(ZG.WIZARD, ZG.HERE)
            ZG.SPELL_p = RANDOM(ZG.SPELLS)
            PUTP(ZG.ADVENTURER, 'ACTION', ZG.MAGIC_ACTOR)
            ENABLE(ZG.QUEUE(ZG.I_WIZARD, (5 + RANDOM((30 - (5 * PCNT))))))
            if ZG.PROB(75):
                TELL('The Wizard, in a deep and resonant voice, speaks the word "', GET(ZG.SPELL_NAMES, ZG.SPELL_p), '!" He then vanishes, cackling gleefully.', CR)
            else:
                TELL('The Wizard, almost inaudibly, whispers a word beginning with "F,"\nand then disappears, chuckling nastily.', CR)
            REMOVE(ZG.WIZARD)
            if GET(ZG.SPELL_HINTS, ZG.SPELL_p):
                TELL(GET(ZG.SPELL_HINTS, ZG.SPELL_p), CR)
            if (ZG.SPELL_p == ZG.S_FALL):
                if FSET_p(WLOC, Flag('VEHBIT')):
                    TELL('You suddenly fall headlong out of the ', D, WLOC, ' as though\nsomeone had flipped it over.', CR)
                    if (ZG.HERE == ZG.WELL_TOP):
                        ZG.JIGS_UP('You plummet to the bottom of the shaft.')
                    elif (FSET_p(ZG.HERE, Flag('NONLANDBIT')) and (not (ZG.HERE in (ZG.VOLCANO_BOTTOM, ZG.WELL_BOTTOM)))):
                        ZG.JIGS_UP('You make a rather messy swan dive to the bottom of the volcano.')
                    else:
                        MOVE(ZG.WINNER, ZG.HERE)
            elif (ZG.SPELL_p == ZG.S_FLOAT):
                if FSET_p(WLOC, Flag('VEHBIT')):
                    TELL(' You rise majestically out of the ', D, WLOC, ', coming to a stop about five\nfeet above it and to one side.', CR)
                    MOVE(ZG.WINNER, ZG.HERE)
                else:
                    TELL('Slowly, you and all your belongings rise into the air, stopping after\nabout five feet.', CR)
            elif (ZG.SPELL_p == ZG.S_FEEBLE):
                ZG.LOAD_ALLOWED = 50
                if (F := FIRST_p(ZG.WINNER)):
                    TELL('In fact, you feel so weak that you drop the ', D, F, '.', CR)
                    MOVE(F, WLOC)
            elif (ZG.SPELL_p == ZG.S_FEAR):
                if FSET_p(WLOC, Flag('VEHBIT')):
                    TELL('You cower in the corner of the ', D, WLOC, ", hoping the wizard\nwon't see you.", CR)
                else:
                    CRLF()
                    ZG.RANDOM_WALK()
            elif (ZG.SPELL_p == ZG.S_FUMBLE):
                ZG.FUMBLE_NUMBER = 3
                ZG.FUMBLE_PROB = 25
                if (F := FIRST_p(ZG.ADVENTURER)):
                    TELL('Ooops! You dropped the ', D, F, '.', CR)
                    MOVE(F, WLOC)
            elif (ZG.SPELL_p == ZG.S_FILCH):
                if ZG.ROB(ZG.WINNER, ZG.WIZARD_CASE):
                    TELL('Something you are carrying has disappeared!', CR)
            elif (ZG.SPELL_p == ZG.S_FIERCE):
                TELL('The Wizard mumbles something under his breath, and just before you\nreach him, he vanishes.', CR)
            return True
        elif ZG.PROB(50):
            REMOVE(ZG.WIZARD)
            return TELL("There is a loud crackling noise. Blue smoke rises from out of the\nWizard's sleeve. He sighs and disappears.", CR)
        elif ZG.PROB(50):
            REMOVE(ZG.WIZARD)
            return TELL('The Wizard incants "', ZG.RANDOM_ELEMENT(ZG.SPELL_NAMES), '!" but nothing\nhappens. He shakes the wand. Nothing happens. With a slightly\nembarrassed glance in your direction, he vanishes.', CR)
        else:
            MOVE(ZG.WIZARD, ZG.HERE)
            return TELL('The Wizard seems about to say something, but thinks better of it,\nand peers at you from under his bushy eyebrows.', CR)
    else:
        return False

# zil: 2actions.zil:3654  <GLOBAL SPELL?>
# GLOBAL (state) SPELL_p = False  ->  ZilGlobal.py

# zil: 2actions.zil:3656  <CONSTANT SPELLS>
# CONSTANT (const) SPELLS = 12  ->  ZilGlobal.py

# zil: 2actions.zil:3657  <CONSTANT S-FEEBLE>
# CONSTANT (const) S_FEEBLE = 1  ->  ZilGlobal.py

# zil: 2actions.zil:3658  <CONSTANT S-FUMBLE>
# CONSTANT (const) S_FUMBLE = 2  ->  ZilGlobal.py

# zil: 2actions.zil:3659  <CONSTANT S-FEAR>
# CONSTANT (const) S_FEAR = 3  ->  ZilGlobal.py

# zil: 2actions.zil:3660  <CONSTANT S-FILCH>
# CONSTANT (const) S_FILCH = 4  ->  ZilGlobal.py

# zil: 2actions.zil:3661  <CONSTANT S-FREEZE>
# CONSTANT (const) S_FREEZE = 5  ->  ZilGlobal.py

# zil: 2actions.zil:3662  <CONSTANT S-FALL>
# CONSTANT (const) S_FALL = 6  ->  ZilGlobal.py

# zil: 2actions.zil:3663  <CONSTANT S-FERMENT>
# CONSTANT (const) S_FERMENT = 7  ->  ZilGlobal.py

# zil: 2actions.zil:3664  <CONSTANT S-FIERCE>
# CONSTANT (const) S_FIERCE = 8  ->  ZilGlobal.py

# zil: 2actions.zil:3665  <CONSTANT S-FLOAT>
# CONSTANT (const) S_FLOAT = 9  ->  ZilGlobal.py

# zil: 2actions.zil:3666  <CONSTANT S-FIREPROOF>
# CONSTANT (const) S_FIREPROOF = 10  ->  ZilGlobal.py

# zil: 2actions.zil:3667  <CONSTANT S-FENCE>
# CONSTANT (const) S_FENCE = 11  ->  ZilGlobal.py

# zil: 2actions.zil:3668  <CONSTANT S-FANTASIZE>
# CONSTANT (const) S_FANTASIZE = 12  ->  ZilGlobal.py

# zil: 2actions.zil:3670  <GLOBAL SPELL-NAMES>
# GLOBAL (state) SPELL_NAMES = LTABLE('Feeble', 'Fumble', 'Fear', 'Filch', 'Freeze', 'Fall', 'Ferment', 'Fierce', 'Float', 'Fireproof', 'Fence', 'Fantasize')  ->  ZilGlobal.py

# zil: 2actions.zil:3675  <GLOBAL SPELL-HINTS>
# GLOBAL (state) SPELL_HINTS = LTABLE('All at once you feel very tired.', False, 'You look at the Wizard in terror. You scramble away,\ntrying to get as far as possible from him.', False, "Your limbs suddenly feel like they have turned to stone. You can't\nmove a muscle.", False, 'You begin to feel lightheaded.', 'You rush at the Wizard, intending to tear him limb from limb.', False, False, False, False)  ->  ZilGlobal.py

# zil: 2actions.zil:3692  <GLOBAL SPELL-STOPS>
# GLOBAL (state) SPELL_STOPS = LTABLE('You feel more energetic now.', False, "You suddenly decide that the Wizard isn't that terrifying...", False, 'Your little finger begins to twitch, and then your whole body is free\nagain.', False, 'Your head is clearer now.', 'You feel cooler and less angry now.', 'You sink quietly down again.', False, False, False)  ->  ZilGlobal.py

# zil: 2actions.zil:3708  <ROUTINE ROB (WHO WHERE "AUX" N X (ROBBED? <>))>
@ZG.routine('ROB')
def ROB(WHO, WHERE):
    N_l = 0
    X = 0
    ROBBED_p = False
    X = FIRST_p(WHO)
    while True:
        if (not X):
            return ROBBED_p
        N_l = NEXT_p(X)
        if ZG.RIPOFF(X, WHERE):
            ROBBED_p = True
        X = N_l

# zil: 2actions.zil:3716  <ROUTINE RIPOFF (X WHERE)>
@ZG.routine('RIPOFF')
def RIPOFF(X, WHERE):
    if ((not FSET_p(X, Flag('INVISIBLE'))) and GETPT(X, 'VALUE') and (not (X == ZG.PALANTIR_1)) and (not (X == ZG.PALANTIR_2)) and (not (X == ZG.PALANTIR_3)) and (not (X == ZG.GOLD_KEY)) and (not (X == ZG.CANDY))):
        MOVE(X, WHERE)
        FSET(X, Flag('TOUCHBIT'))
        return True
    else:
        return False

# zil: 2actions.zil:3728  <ROUTINE WIZARD-CASE-FCN ()>
@ZG.routine('WIZARD-CASE-FCN')
def WIZARD_CASE_FCN():
    if (ZG.WINNER == ZG.GENIE):
        if VERB_p('MUNG', 'OPEN'):
            REMOVE(ZG.WIZARD_CASE)
            MOVE(ZG.BROKEN_CASE, ZG.TROPHY_ROOM)
            return TELL('The demon smashes the case into smithereens. Everything in it smashes\nas well.', CR)
        else:
            return False
    elif (VERB_p('ENCHANT') and (ZG.SPELL_USED == WORD('filch'))):
        ZG.ROB(ZG.WIZARD_CASE, ZG.HERE)
        ZG.SPELL_HANDLED_p = True
        return TELL('The contents of the case are arrayed at your feet.', CR)
    elif VERB_p('OPEN', 'MUNG', 'CLOSE', 'TAKE'):
        return TELL('The case is protected by a fearful spell. You cannot touch it in any\nway.', CR)
    else:
        return False

# zil: 2actions.zil:3746  <GLOBAL SPELL-HANDLED?>
# GLOBAL (state) SPELL_HANDLED_p = False  ->  ZilGlobal.py

# ;"T if handled before I-SPELL runs"

# zil: 2actions.zil:3747  <GLOBAL WAND-ON>
# GLOBAL (state) WAND_ON = False  ->  ZilGlobal.py

# zil: 2actions.zil:3748  <GLOBAL SPELL-USED>
# GLOBAL (state) SPELL_USED = False  ->  ZilGlobal.py

# zil: 2actions.zil:3749  <GLOBAL SPELL-VICTIM>
# GLOBAL (state) SPELL_VICTIM = False  ->  ZilGlobal.py

# zil: 2actions.zil:3751  <ROUTINE WAND-FCN ()>
@ZG.routine('WAND-FCN')
def WAND_FCN():
    if (VERB_p('TAKE', 'PUT', 'GIVE') and IN_p(ZG.WAND, ZG.WIZARD)):
        if (ZG.WINNER == ZG.ADVENTURER):
            return TELL('The Wizard snatches it away.', CR)
        elif (ZG.WINNER == ZG.ROBOT):
            return ZG.JIGS_UP('The Wizard snatches the wand away, muttering the word "Float" at the\nrobot. Unfortunately he has no floating-point processor and dies in a\nvain attempt to divide 4.85 by 3.62.')
        else:
            return False
    elif (VERB_p('WAVE') and (ZG.PRSI == ZG.GRUE)):
        return TELL('There is no grue in sight, but a hissing sound issues forth from the\ndarkness.', CR)
    elif VERB_p('WAVE', 'RUB', 'RAISE'):
        if ((ZG.PRSO == ZG.WAND) and (not IN_p(ZG.WAND, ZG.WINNER))):
            TELL("You don't have the wand!", CR)
            return True
        elif (ZG.WAND_ON or ZG.SPELL_USED or ZG.SPELL_VICTIM):
            if ZG.PROB(5):
                ZG.JIGS_UP('The wand was still recharging from its last use. It discharges magic all\nover everything. You turn into a toad, the room fills with a fetid smell,\nand all sorts of other grubby things happen. Then the wand explodes!')
            else:
                TELL('A lot you know about magic! A magic wand takes a while to recharge\nafter use! You might cause it to short-circuit!', CR)
            return True
        elif VERB_p('WAVE'):
            if ((ZG.PRSO == ZG.WAND) and ZG.PRSI):
                ZG.WAND_ON = ZG.PRSI
                ZG.WAND_ON_LOC = ZG.HERE
            else:
                TELL('At what?', CR)
                return True
        elif VERB_p('RUB'):
            if ((ZG.PRSI == ZG.WAND) and ZG.PRSO):
                ZG.WAND_ON = ZG.PRSO
            else:
                TELL('Touch what?', CR)
                return True
        elif VERB_p('RAISE'):
            TELL('The wand grows warm and seems to vibrate.', CR)
            return True
        if ZG.WAND_ON:
            ZG.SPELL_USED = False
            ZG.SPELL_VICTIM = False
            if (ZG.WAND_ON in (ZG.ME, ZG.WAND)):
                ZG.WAND_ON = False
                TELL('Fortunately a safety interlock prevents the fatal feedback loop that\nthis would cause.', CR)
            else:
                TELL('The wand grows warm, the ', D, ZG.WAND_ON, ' seems to glow dimly with\nmagical essences, and you feel suffused with power.', CR)
            ENABLE(ZG.QUEUE(ZG.I_WAND, 2))
        return True
    else:
        return False

# zil: 2actions.zil:3808  <GLOBAL WAND-ON-LOC>
# GLOBAL (state) WAND_ON_LOC = False  ->  ZilGlobal.py

# zil: 2actions.zil:3810  <ROUTINE I-WAND ()>
@ZG.routine('I-WAND')
def I_WAND():
    if (ZG.WAND_ON and ((ZG.WAND_ON_LOC == ZG.HERE) or IN_p(ZG.WAND_ON, ZG.WINNER))):
        TELL('The ', D, ZG.WAND_ON, ' stops glowing and the power within you weakens.', CR)
        ZG.WAND_ON = False
        return True
    else:
        ZG.WAND_ON = False
        return False

# zil: 2actions.zil:3822  <ROUTINE WIZARD-QUARTERS-FCN (RARG "AUX" PICK L)>
@ZG.routine('WIZARD-QUARTERS-FCN')
def WIZARD_QUARTERS_FCN(RARG):
    PICK = 0
    L = 0
    if (RARG in (ZG.M_LOOK, ZG.M_FLASH)):
        TELL('This is where the Wizard of Frobozz lives. The room is ')
        L = GET(ZG.WIZQDESCS, 0)
        PICK = RANDOM(L)
        if (PICK == ZG.WIZQLAST):
            if (PICK == L):
                PICK = (PICK - 1)
            else:
                PICK = (PICK + 1)
        ZG.WIZQLAST = PICK
        return TELL(GET(ZG.WIZQDESCS, PICK), CR)
    else:
        return False

# zil: 2actions.zil:3836  <GLOBAL WIZQLAST>
# GLOBAL (state) WIZQLAST = 0  ->  ZilGlobal.py

# zil: 2actions.zil:3838  <GLOBAL WIZQDESCS>
# GLOBAL (state) WIZQDESCS = LTABLE('sparsely furnished and almost monkish in its austerity.', 'an opulently furnished seraglio out of an Arabian folktale.', 'decorated in the Louis XIV style.', 'overhung with palm-trees and lianas. The only furniture is a hammock.', 'constructed of delicate and wispy cloud-stuffs.', 'furnished in plastic and metal and looks like the control deck of a\nspaceship.', "a suburban bedroom out of the 1950's, complete with bunk beds.", 'a dank and dimly lighted cave, its floor piled with furs and old bones.')  ->  ZilGlobal.py

# zil: 2actions.zil:3850  <ROUTINE BRIDGE-FCN ()>
@ZG.routine('BRIDGE-FCN')
def BRIDGE_FCN():
    if VERB_p('CROSS'):
        return ZG.DO_WALK('CROSS')
    elif VERB_p('LEAP'):
        return ZG.JIGS_UP('You execute a perfect swan-dive into the depths below.')
    else:
        return False

# ;"misc. routines"

# zil: 2actions.zil:3859  <ROUTINE STREAM-FCN ()>
@ZG.routine('STREAM-FCN')
def STREAM_FCN():
    if VERB_p('SWIM', 'THROUGH'):
        return TELL("You can't swim in the stream.", CR)
    elif VERB_p('CROSS'):
        return TELL("You'll have to find a ford or a bridge.", CR)
    else:
        return False

# zil: 2actions.zil:3865  <ROUTINE CHASM-FCN ()>
@ZG.routine('CHASM-FCN')
def CHASM_FCN():
    if (VERB_p('LEAP') or (VERB_p('PUT') and (ZG.PRSO == ZG.ME))):
        return TELL('For a change, you look before leaping. You realize you would\nnever survive.', CR)
    elif VERB_p('CROSS'):
        return TELL("You'll have to find a bridge.", CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.PSEUDO_OBJECT)):
        TELL('The ', D, ZG.PRSO, ' drops out of sight into the chasm.', CR)
        return REMOVE(ZG.PRSO)
    else:
        return False

# zil: 2actions.zil:3878  <ROUTINE TUNNEL-OBJECT ()>
@ZG.routine('TUNNEL-OBJECT')
def TUNNEL_OBJECT():
    if (VERB_p('THROUGH') and GETPT(ZG.HERE, 'IN')):
        ZG.DO_WALK('IN')
        return True
    else:
        return ZG.PATH_OBJECT()

# zil: 2actions.zil:3883  <ROUTINE STALA-PSEUDO ()>
@ZG.routine('STALA-PSEUDO')
def STALA_PSEUDO():
    if VERB_p('TAKE', 'MUNG'):
        return TELL('The only ones you can reach are too large to successfully break off.', CR)
    else:
        return False

# zil: 2actions.zil:3888  <ROUTINE MOSS-FCN ()>
@ZG.routine('MOSS-FCN')
def MOSS_FCN():
    if VERB_p('TAKE', 'RUB'):
        return TELL('Some of the moss rubs off on you, but it stops glowing very quickly\nonce plucked from its environment.', CR)
    else:
        return False

# zil: 2actions.zil:3894  <ROUTINE ROSE-BUSH-FCN ()>
@ZG.routine('ROSE-BUSH-FCN')
def ROSE_BUSH_FCN():
    if VERB_p('TAKE'):
        return TELL('You prick your finger trying to take a rose, and jump back annoyed.\nThe rose almost seemed to move its thorns into your path.', CR)
    else:
        return False

# zil: 2actions.zil:3900  <ROUTINE I-SPELL ()>
@ZG.routine('I-SPELL')
def I_SPELL():
    if ((not ZG.SPELL_HANDLED_p) and ZG.SPELL_VICTIM):
        ZG.PERFORM(SYMBOL('V?DISENCHANT'), ZG.SPELL_VICTIM)
    ZG.SPELL_HANDLED_p = False
    ZG.WAND_ON = False
    ZG.SPELL_USED = False
    ZG.SPELL_VICTIM = False
    return ZG.SPELL_VICTIM

# zil: 2actions.zil:3908  <GLOBAL FANTASIES>
# GLOBAL (state) FANTASIES = LTABLE('pile of jewels', 'gold ingot', 'basilisk', 'bulging chest', 'yellow sphere', 'grue', 'convention of wizards', 'copy of ZORK I')  ->  ZilGlobal.py

# ^/L: top-level atom (no effect)

# ;"special-cased routines"

# zil: 2actions.zil:3917  <ROUTINE V-DIAGNOSE ()>
@ZG.routine('V-DIAGNOSE')
def V_DIAGNOSE():
    if ZG.DEAD:
        TELL('You are dead.')
    elif (ZG.SPELL_p == ZG.S_FERMENT):
        TELL('You are drunk.')
    elif (ZG.SPELL_p == ZG.S_FEEBLE):
        TELL('You seem unusually weak right now.')
    elif (ZG.SPELL_p == ZG.S_FLOAT):
        TELL('You seem somewhat light.')
    elif (ZG.SPELL_p == ZG.S_FREEZE):
        TELL('You are frozen stiff.')
    else:
        TELL('You are in perfect health.')
    CRLF()
    if (not (ZG.DEATHS == 0)):
        TELL('You have been killed ')
        if (ZG.DEATHS == 1):
            TELL('once.')
        elif (ZG.DEATHS == 2):
            TELL('twice.')
        else:
            TELL('an awful lot.')
        return CRLF()
    else:
        return False

# zil: 2actions.zil:3936  <ROUTINE V-SCORE ("OPTIONAL" (ASK? T))>
@ZG.routine('V-SCORE')
def V_SCORE(ASK_p=None):
    if ASK_p is None:
        ASK_p = True
    TELL('Your score ')
    if ASK_p:
        TELL('would be ')
    else:
        TELL('is ')
    TELL(N, ZG.SCORE)
    TELL(' (total of 400 points), in ')
    TELL(N, ZG.MOVES)
    if (ZG.MOVES == 1):
        TELL(' move.')
    else:
        TELL(' moves.')
    CRLF()
    TELL('This score gives you the rank of ')
    if (ZG.SCORE == 400):
        TELL('Master Adventurer')
        if (not ZG.WON_FLAG):
            TELL(", but somehow you don't feel done")
    elif (ZG.SCORE > 360):
        TELL('Wizard')
    elif (ZG.SCORE > 320):
        TELL('Master')
    elif (ZG.SCORE > 240):
        TELL('Adventurer')
    elif (ZG.SCORE > 160):
        TELL('Junior Adventurer')
    elif (ZG.SCORE > 80):
        TELL('Novice Adventurer')
    elif (ZG.SCORE > 40):
        TELL('Amateur Adventurer')
    else:
        TELL('Beginner')
    TELL('.', CR)
    return ZG.SCORE

# zil: 2actions.zil:3959  <ROUTINE JIGS-UP ("OPTIONAL" (DESC <>) (PLAYER? <>))>
@ZG.routine('JIGS-UP')
def JIGS_UP(DESC_l=None, PLAYER_p=None):
    if DESC_l is None:
        DESC_l = False
    if PLAYER_p is None:
        PLAYER_p = False
    if DESC_l:
        TELL(DESC_l, CR)
    if (not (ZG.ADVENTURER == ZG.WINNER)):
        TELL('\n\n    ****  The ', D, ZG.WINNER, ' has died  ****\n\n\n')
        REMOVE(ZG.WINNER)
        ZG.WINNER = ZG.ADVENTURER
        ZG.HERE = LOC(ZG.WINNER)
        return 2
    while True:
        ZG.SCORE_UPD(-10)
        TELL('\n\n    ****  You have died  ****\n\n\n')
        ZG.DEAD = True
        ZG.SPELL_p = False
        PUTP(ZG.ADVENTURER, 'ACTION', 0)
        ZG.DEATHS = (ZG.DEATHS + 1)
        MOVE(ZG.WINNER, ZG.HERE)
        TELL("Now, let's take a look here...\nWell, you probably deserve another chance. I can't quite fix you\nup completely, but you can't have everything.", CR, CR)
        FCLEAR(ZG.DEAD_PALANTIR_1, Flag('TOUCHBIT'))
        FCLEAR(ZG.DEAD_PALANTIR_2, Flag('TOUCHBIT'))
        FCLEAR(ZG.DEAD_PALANTIR_3, Flag('TOUCHBIT'))
        ZG.RANDOMIZE_OBJECTS()
        ZG.GOTO(ZG.DEAD_PALANTIR_1)
        ZG.P_CONT = False
        ZG.KILL_INTERRUPTS()
        return 2
        break

# zil: 2actions.zil:3995  <ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)>
@ZG.routine('RANDOMIZE-OBJECTS')
def RANDOMIZE_OBJECTS():
    R = False
    F = 0
    N_l = 0
    L = 0
    if IN_p(ZG.LAMP, ZG.WINNER):
        MOVE(ZG.LAMP, ZG.INSIDE_BARROW)
    N_l = FIRST_p(ZG.WINNER)
    while True:
        F = N_l
        if (not F):
            return True
        N_l = NEXT_p(F)
        if ((F in (ZG.BILLS, ZG.PORTRAIT)) and ((ZG.HERE in (ZG.VAULT, ZG.DEPOSITORY, ZG.OFFICE)) or (ZG.HERE == ZG.SMALL_ROOM))):
            MOVE(F, ZG.HERE)
        elif ((F == ZG.GOLD_KEY) or (F == ZG.CANDY) or (F == ZG.PALANTIR_1) or (F == ZG.PALANTIR_2) or (F == ZG.PALANTIR_3)):
            MOVE(F, ZG.CAROUSEL_ROOM)
        elif FSET_p(F, Flag('STAGGERED')):
            MOVE(F, ZG.WIZARD_CASE)
        else:
            MOVE(F, ZG.GAZEBO_ROOM)

# zil: 2actions.zil:4018  <ROUTINE KILL-INTERRUPTS ()>
@ZG.routine('KILL-INTERRUPTS')
def KILL_INTERRUPTS():
    ZG.DISABLE(ZG.INT(ZG.I_GNOME))
    ZG.DISABLE(ZG.INT(ZG.I_LEDGE))
    ZG.DISABLE(ZG.INT(ZG.I_NERVOUS))
    ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT))
    ZG.DISABLE(ZG.INT(ZG.I_ZGNOME))
    ZG.DRAGON_LEAVES()
    ZG.DISABLE(ZG.INT(ZG.I_MATCH))
    return True

# zil: 2actions.zil:4028  <ROUTINE FIND-WEAPON (O "AUX" W)>
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

# zil: 2actions.zil:4037  <ROUTINE BUCKET-CONT ()>
@ZG.routine('BUCKET-CONT')
def BUCKET_CONT():
    if (VERB_p('TAKE') and (not IN_p(ZG.WINNER, ZG.BUCKET))):
        return TELL("You'll need to get in the bucket to reach it.", CR)
    else:
        return False
