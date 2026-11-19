# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'Generic GLOBALS file for\n\t\t\t    The ZORK Trilogy\n\t\t       started on 7/28/83 by MARC'

'SUBTITLE GLOBAL OBJECTS'

# zil: gglobals.zil:7  <OBJECT GLOBAL-OBJECTS>
ZG.world.declare_object('GLOBAL_OBJECTS', 'GLOBAL-OBJECTS', lambda: {
    'FLAGS': ('RMUNGBIT', 'INVISIBLE', 'TOUCHBIT', 'SURFACEBIT', 'TRYTAKEBIT', 'OPENBIT', 'SEARCHBIT', 'TRANSBIT', 'ONBIT', 'RLANDBIT', 'FIGHTBIT', 'STAGGERED', 'WEARBIT'),
})

# zil: gglobals.zil:12  <OBJECT LOCAL-GLOBALS>
ZG.world.declare_object('LOCAL_GLOBALS', 'LOCAL-GLOBALS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'ZZMGCK',
    'DESCFCN': ZG.PATH_OBJECT,
    'GLOBAL': ZG.GLOBAL_OBJECTS,
    'ADVFCN': 0,
    'FDESC': 'F',
    'LDESC': 'F',
    'PSEUDO': ('FOOBAR', ZG.V_WALK),
    'CONTFCN': 0,
    'VTYPE': 1,
    'SIZE': 0,
    'CAPACITY': 0,
})

# ;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

# zil: gglobals.zil:28  <OBJECT ROOMS>
ZG.world.declare_object('ROOMS', 'ROOMS', lambda: {})

# zil: gglobals.zil:31  <OBJECT INTNUM>
ZG.world.declare_object('INTNUM', 'INTNUM', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'INTNUM',
    'FLAGS': 'TOOLBIT',
    'DESC': 'number',
})

# zil: gglobals.zil:37  <OBJECT PSEUDO-OBJECT>
ZG.world.declare_object('PSEUDO_OBJECT', 'PSEUDO-OBJECT', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'pseudo',
    'ACTION': ZG.CRETIN_FCN,
})

# zil: gglobals.zil:42  <OBJECT IT>
ZG.world.declare_object('IT', 'IT', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('IT', 'THEM', 'HER', 'HIM'),
    'DESC': 'random object',
    'FLAGS': ('NDESCBIT', 'TOUCHBIT'),
})

# zil: gglobals.zil:48  <OBJECT NOT-HERE-OBJECT>
ZG.world.declare_object('NOT_HERE_OBJECT', 'NOT-HERE-OBJECT', lambda: {
    'DESC': 'such thing',
    'ACTION': ZG.NOT_HERE_OBJECT_F,
})

# zil: gglobals.zil:52  <ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)>
@ZG.routine('NOT-HERE-OBJECT-F')
def NOT_HERE_OBJECT_F():
    TBL = 0
    PRSO_p_l = True
    OBJ_l = 0
    # ;"This COND is game independent (except the TELL)"
    if ((ZG.PRSO == ZG.NOT_HERE_OBJECT) and (ZG.PRSI == ZG.NOT_HERE_OBJECT)):
        TELL("Those things aren't here!", CR)
        return True
    elif (ZG.PRSO == ZG.NOT_HERE_OBJECT):
        TBL = ZG.P_PRSO
    else:
        TBL = ZG.P_PRSI
        PRSO_p_l = False
    # ;"Here is the default 'cant see any' printer"
    ZG.P_CONT = False
    ZG.QUOTE_FLAG = False
    if (ZG.WINNER == ZG.PLAYER):
        TELL("You can't see any ")
        ZG.NOT_HERE_PRINT(PRSO_p_l)
        TELL(' here!', CR)
    else:
        TELL('The ', D, ZG.WINNER, ' seems confused. "I don\'t see any ')
        ZG.NOT_HERE_PRINT(PRSO_p_l)
        TELL(' here!"', CR)
    return True

# ;<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
# 	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
# 	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
# 	   the 0 and >1 cases alike or different. It doesn't matter. Always
# 	   return RFALSE (not handled) if you have resolved the problem."
# 	<SET M-F <MOBY-FIND .TBL>>
# 	;<COND (,DEBUG
# 	       <TELL "[Moby-found " N .M-F " objects" "]" CR>)>
# 	<COND (<AND <G? .M-F 1>
# 		    <SET OBJ <GETP <GET .TBL 1> ,P?GLOBAL>>>
# 	       <SET M-F 1>
# 	       <SETG P-MOBY-FOUND .OBJ>)>
# 	<COND (<==? 1 .M-F>
# 	       ;<COND (,DEBUG <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
# 	       <COND (.PRSO? <SETG PRSO ,P-MOBY-FOUND>)
# 		     (T <SETG PRSI ,P-MOBY-FOUND>)>
# 	       <RFALSE>)
# 	      (<NOT .PRSO?>
# 	       <TELL "You wouldn't find any ">
# 	       <NOT-HERE-PRINT .PRSO?>
# 	       <TELL " there." CR>
# 	       <RTRUE>)
# 	      (T ,NOT-HERE-OBJECT)>>

# ;<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ)
# 	 ;<COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)>
# 	 <SETG P-CONT <>>
# 	 <SETG QUOTE-FLAG <>>
# 	 <TELL "You can't see any">
# 	 <COND (<EQUAL? .OBJ ,PRSO> <PRSO-PRINT>)
# 	       (T <PRSI-PRINT>)>
# 	 <TELL " here." CR>>

# zil: gglobals.zil:109  <ROUTINE NOT-HERE-PRINT (PRSO?)>
@ZG.routine('NOT-HERE-PRINT')
def NOT_HERE_PRINT(PRSO_p_l):
    if ZG.P_OFLAG:
        if ZG.P_XADJ:
            PRINTB(ZG.P_XADJN)
        if ZG.P_XNAM:
            return PRINTB(ZG.P_XNAM)
        else:
            return False
    elif PRSO_p_l:
        return ZG.BUFFER_PRINT(GET(ZG.P_ITBL, ZG.P_NC1), GET(ZG.P_ITBL, ZG.P_NC1L), False)
    else:
        return ZG.BUFFER_PRINT(GET(ZG.P_ITBL, ZG.P_NC2), GET(ZG.P_ITBL, ZG.P_NC2L), False)

# zil: gglobals.zil:118  <ROUTINE NULL-F ("OPTIONAL" A1 A2)>
@ZG.routine('NULL-F')
def NULL_F(A1=None, A2=None):
    return False

'Objects shared by all three Zorks go here'

# zil: gglobals.zil:125  <GLOBAL LOAD-MAX>
# GLOBAL (state) LOAD_MAX = 100  ->  ZilGlobal.py

# zil: gglobals.zil:127  <GLOBAL LOAD-ALLOWED>
# GLOBAL (state) LOAD_ALLOWED = 100  ->  ZilGlobal.py

# zil: gglobals.zil:129  <OBJECT BLESSINGS>
ZG.world.declare_object('BLESSINGS', 'BLESSINGS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('BLESSINGS', 'GRACES'),
    'DESC': 'blessings',
    'FLAGS': 'NDESCBIT',
})

# zil: gglobals.zil:135  <OBJECT STAIRS>
ZG.world.declare_object('STAIRS', 'STAIRS', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('STAIRS', 'STEPS', 'STAIRCASE', 'STAIRWAY'),
    'ADJECTIVE': ('STONE', 'DARK', 'MARBLE', 'FORBIDDING', 'STEEP'),
    'DESC': 'stairs',
    'FLAGS': ('NDESCBIT', 'CLIMBBIT'),
    'ACTION': ZG.STAIRS_F,
})

# zil: gglobals.zil:143  <ROUTINE STAIRS-F ()>
@ZG.routine('STAIRS-F')
def STAIRS_F():
    if VERB_p('THROUGH'):
        return TELL('You should say whether you want to go up or down.', CR)
    else:
        return False

# zil: gglobals.zil:148  <OBJECT SAILOR>
ZG.world.declare_object('SAILOR', 'SAILOR', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('SAILOR', 'FOOTPAD', 'AVIATOR'),
    'DESC': 'sailor',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.SAILOR_FCN,
})

# zil: gglobals.zil:155  <ROUTINE SAILOR-FCN ()>
@ZG.routine('SAILOR-FCN')
def SAILOR_FCN():
    if VERB_p('TELL'):
        ZG.P_CONT = False
        ZG.QUOTE_FLAG = False
        return TELL("You can't talk to the sailor that way.", CR)
    elif VERB_p('EXAMINE'):
        if (not FSET_p(ZG.VIKING_SHIP, Flag('INVISIBLE'))):
            TELL('He looks like a sailor.', CR)
            return True
        return TELL('There is no sailor to be seen.', CR)
    elif VERB_p('HELLO'):
        ZG.HS = (ZG.HS + 1)
        if (not FSET_p(ZG.VIKING_SHIP, Flag('INVISIBLE'))):
            TELL('The seaman looks up and maneuvers the boat toward shore. He cries out "I\nhave waited three ages for someone to say those words and save me from\nsailing this endless ocean. Please accept this gift. You may find it\nuseful!" He throws something which falls near you in the sand, then sails\noff toward the west, singing a lively, but somewhat uncouth, sailor song.', CR)
            FSET(ZG.VIKING_SHIP, Flag('INVISIBLE'))
            return MOVE(ZG.VIAL, ZG.HERE)
        elif (ZG.HERE == ZG.FLATHEAD_OCEAN):
            if ZG.SHIP_GONE:
                return TELL('Nothing happens anymore.', CR)
            else:
                return TELL('Nothing happens yet.', CR)
        else:
            return TELL('Nothing happens here.', CR)
    else:
        return False

# zil: gglobals.zil:197  <OBJECT GROUND>
ZG.world.declare_object('GROUND', 'GROUND', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('GROUND', 'SAND', 'DIRT', 'FLOOR'),
    'DESC': 'ground',
    'ACTION': ZG.GROUND_FUNCTION,
})

# zil: gglobals.zil:203  <ROUTINE GROUND-FUNCTION ()>
@ZG.routine('GROUND-FUNCTION')
def GROUND_FUNCTION():
    if (VERB_p('PUT', 'PUT-ON') and (ZG.PRSI == ZG.GROUND)):
        ZG.PERFORM(SYMBOL('V?DROP'), ZG.PRSO)
        return True
    elif ZG.NULL_F():
        return False
    elif VERB_p('DIG'):
        return TELL('The ground is too hard for digging here.', CR)
    else:
        return False

# zil: gglobals.zil:217  <OBJECT GRUE>
ZG.world.declare_object('GRUE', 'GRUE', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'GRUE',
    'ADJECTIVE': ('LURKING', 'SINISTER', 'HUNGRY', 'SILENT'),
    'DESC': 'lurking grue',
    'ACTION': ZG.GRUE_FUNCTION,
})

# zil: gglobals.zil:224  <ROUTINE GRUE-FUNCTION ()>
@ZG.routine('GRUE-FUNCTION')
def GRUE_FUNCTION():
    if VERB_p('EXAMINE'):
        return TELL('The grue is a sinister, lurking presence in the dark places of the\nearth. Its favorite diet is adventurers, but its insatiable\nappetite is tempered by its fear of light. No grue has ever been\nseen by the light of day, and few have survived its fearsome jaws\nto tell the tale.', CR)
    elif VERB_p('FIND'):
        return TELL("There is no grue here, but I'm sure there is at least one lurking\nin the darkness nearby. I wouldn't let my light go out if I were\nyou!", CR)
    elif VERB_p('LISTEN'):
        return TELL('It makes no sound but is always lurking in the darkness nearby.', CR)
    else:
        return False

# zil: gglobals.zil:241  <OBJECT LUNGS>
ZG.world.declare_object('LUNGS', 'LUNGS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('LUNGS', 'AIR', 'MOUTH', 'BREATH'),
    'DESC': 'blast of air',
    'FLAGS': 'NDESCBIT',
})

# zil: gglobals.zil:247  <OBJECT ME>
ZG.world.declare_object('ME', 'ME', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('ME', 'MYSELF', 'SELF', 'CRETIN'),
    'DESC': 'you',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.CRETIN_FCN,
})

# zil: gglobals.zil:254  <ROUTINE CRETIN-FCN ()>
@ZG.routine('CRETIN-FCN')
def CRETIN_FCN():
    if VERB_p('TELL'):
        ZG.P_CONT = False
        ZG.QUOTE_FLAG = False
        return TELL('Talking to yourself is said to be a sign of impending mental collapse.', CR)
    elif (VERB_p('GIVE') and (ZG.PRSI == ZG.ME)):
        ZG.PERFORM(SYMBOL('V?TAKE'), ZG.PRSO)
        return True
    elif VERB_p('MAKE'):
        return TELL('Only you can do that.', CR)
    elif VERB_p('DISEMBARK'):
        return TELL("You'll have to do that on your own.", CR)
    elif VERB_p('EAT'):
        return TELL('Auto-cannibalism is not the answer.', CR)
    elif VERB_p('ATTACK', 'MUNG'):
        if (ZG.PRSI and FSET_p(ZG.PRSI, Flag('WEAPONBIT'))):
            return ZG.JIGS_UP("If you insist.... Poof, you're dead!")
        else:
            return TELL('Suicide is not the answer.', CR)
    elif VERB_p('THROW'):
        if (ZG.PRSO == ZG.ME):
            return TELL("Why don't you just walk like normal people?", CR)
        else:
            return False
    elif VERB_p('TAKE'):
        return TELL('How romantic!', CR)
    elif VERB_p('EXAMINE'):
        if ZG.INVIS:
            return TELL('A good trick, as you are currently invisible.', CR)
        else:
            return TELL('What you can see looks pretty much as usual, sorry to say.', CR)
    else:
        return False

# zil: gglobals.zil:300  <OBJECT ADVENTURER>
ZG.world.declare_object('ADVENTURER', 'ADVENTURER', lambda: {
    'SYNONYM': 'ADVENTURER',
    'DESC': 'cretin',
    'FLAGS': ('NDESCBIT', 'INVISIBLE', 'SACREDBIT', 'ACTORBIT'),
    'STRENGTH': 0,
    'ACTION': 0,
})

# zil: gglobals.zil:307  <OBJECT PATHOBJ>
ZG.world.declare_object('PATHOBJ', 'PATHOBJ', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('TRAIL', 'PATH'),
    'ADJECTIVE': ('FOREST', 'NARROW', 'LONG', 'WINDING'),
    'DESC': 'passage',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.PATH_OBJECT,
})

# zil: gglobals.zil:315  <ROUTINE PATH-OBJECT ()>
@ZG.routine('PATH-OBJECT')
def PATH_OBJECT():
    if VERB_p('TAKE', 'FOLLOW'):
        return TELL('You must specify a direction to go.', CR)
    elif VERB_p('FIND'):
        return TELL("I can't help you there....", CR)
    elif VERB_p('DIG'):
        return TELL('Not a chance.', CR)
    else:
        return False

# zil: gglobals.zil:323  <OBJECT ZORKMID>
ZG.world.declare_object('ZORKMID', 'ZORKMID', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'ZORKMID',
    'DESC': 'zorkmid',
    'ACTION': ZG.ZORKMID_FUNCTION,
})

# zil: gglobals.zil:329  <ROUTINE ZORKMID-FUNCTION ()>
@ZG.routine('ZORKMID-FUNCTION')
def ZORKMID_FUNCTION():
    if VERB_p('EXAMINE'):
        return TELL('The zorkmid is the unit of currency of the Great Underground Empire.', CR)
    elif VERB_p('FIND'):
        return TELL('The best way to find zorkmids is to go out and look for them.', CR)
    else:
        return False

# zil: gglobals.zil:337  <OBJECT HANDS>
ZG.world.declare_object('HANDS', 'HANDS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('PAIR', 'HANDS', 'HAND'),
    'ADJECTIVE': 'BARE',
    'DESC': 'pair of hands',
    'FLAGS': ('NDESCBIT', 'TOOLBIT'),
})
