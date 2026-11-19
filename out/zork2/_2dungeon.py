# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'2DUNGEON for\n\t\t      Zork II: The Wizard of Frobozz\n\t(c) Copyright 1981, 1983 Infocom, Inc.  All Rights Reserved.'

DIRECTIONS('NORTH', 'EAST', 'WEST', 'SOUTH', 'NE', 'NW', 'SE', 'SW', 'UP', 'DOWN', 'IN', 'OUT', 'LAND', 'CROSS')

# zil: 2dungeon.zil:7  <ROUTINE GO ()>
@ZG.routine('GO')
def GO():
    while True:
        PUTB(ZG.P_LEXV, 0, 59)
        # ;"put interrupts on clock chain"
        ENABLE(ZG.QUEUE(ZG.I_WIZARD, 4))
        ZG.QUEUE(ZG.I_LANTERN, 200)
        # ;"clean up junk compiler can't do"
        PUTP(ZG.BALLOON, 'VTYPE', Flag('NONLANDBIT'))
        PUTP(ZG.BUCKET, 'VTYPE', Flag('NONLANDBIT'))
        PUTP(ZG.SEWL, 'SIZE', 'EAST')
        PUTP(ZG.SWWL, 'SIZE', 'WEST')
        PUTP(ZG.SSWL, 'SIZE', 'SOUTH')
        PUTP(ZG.SNWL, 'SIZE', 'NORTH')
        # ;"set up and go"
        ZG.LIT = True
        ZG.WINNER = ZG.ADVENTURER
        ZG.PLAYER = ZG.ADVENTURER
        ZG.HERE = ZG.INSIDE_BARROW
        ZG.P_IT_OBJECT = False
        if (not FSET_p(ZG.HERE, Flag('TOUCHBIT'))):
            ZG.V_VERSION()
            CRLF()
        MOVE(ZG.WINNER, ZG.HERE)
        ZG.V_LOOK()
        ZG.MAIN_LOOP()
        continue
        break

'SUBTITLE CONDITIONAL EXITS'

# zil: 2dungeon.zil:35  <GLOBAL SECRET-DOOR>
# GLOBAL (state) SECRET_DOOR = False  ->  ZilGlobal.py

# zil: 2dungeon.zil:36  <GLOBAL GNOME-DOOR-FLAG>
# GLOBAL (state) GNOME_DOOR_FLAG = False  ->  ZilGlobal.py

'SUBTITLE GLOBAL OBJECTS'

# zil: 2dungeon.zil:40  <OBJECT STREAM>
ZG.world.declare_object('STREAM', 'STREAM', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'STREAM',
    'ADJECTIVE': ('FLOWING', 'SMALL'),
    'DESC': 'stream',
    'ACTION': ZG.STREAM_FCN,
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:48  <OBJECT CHASM>
ZG.world.declare_object('CHASM', 'CHASM', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('CHASM', 'RAVINE'),
    'ADJECTIVE': 'DEEP',
    'DESC': 'chasm',
    'ACTION': ZG.CHASM_FCN,
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:56  <OBJECT MOSS>
ZG.world.declare_object('MOSS', 'MOSS', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('MOSS', 'MOSSES'),
    'ADJECTIVE': ('GLOWING', 'PHOSPHORESCENT'),
    'DESC': 'mosses',
    'ACTION': ZG.MOSS_FCN,
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
})

# zil: 2dungeon.zil:64  <OBJECT ROSE-BUSH>
ZG.world.declare_object('ROSE_BUSH', 'ROSE-BUSH', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('ROSES', 'BUSH', 'ARBOR'),
    'ADJECTIVE': 'ROSE',
    'DESC': 'roses',
    'ACTION': ZG.ROSE_BUSH_FCN,
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
})

# zil: 2dungeon.zil:72  <OBJECT BRIDGE>
ZG.world.declare_object('BRIDGE', 'BRIDGE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'BRIDGE',
    'ADJECTIVE': ('STONE', 'WOODEN', 'RICKETY'),
    'DESC': 'bridge',
    'ACTION': ZG.BRIDGE_FCN,
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:80  <OBJECT TUNNEL>
ZG.world.declare_object('TUNNEL', 'TUNNEL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('PASSAGE', 'TUNNEL', 'CRAWLWAY'),
    'ADJECTIVE': ('DARK', 'SMOKY'),
    'DESC': 'tunnel',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.TUNNEL_OBJECT,
})

# zil: 2dungeon.zil:88  <OBJECT EAST-WALL>
ZG.world.declare_object('EAST_WALL', 'EAST-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('EAST', 'EASTERN'),
    'DESC': 'east wall',
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:95  <OBJECT SOUTH-WALL>
ZG.world.declare_object('SOUTH_WALL', 'SOUTH-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('SOUTH', 'SOUTHE'),
    'DESC': 'south wall',
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:102  <OBJECT WEST-WALL>
ZG.world.declare_object('WEST_WALL', 'WEST-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('WEST', 'WESTERN'),
    'DESC': 'west wall',
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:109  <OBJECT NORTH-WALL>
ZG.world.declare_object('NORTH_WALL', 'NORTH-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('NORTH', 'NORTHE'),
    'DESC': 'north wall',
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:116  <OBJECT GLOBAL-WATER>
ZG.world.declare_object('GLOBAL_WATER', 'GLOBAL-WATER', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('WATER', 'QUANTITY'),
    'DESC': 'water',
    'FLAGS': 'DRINKBIT',
    'ACTION': ZG.WATER_FCN,
})

# zil: 2dungeon.zil:123  <OBJECT WISH>
ZG.world.declare_object('WISH', 'WISH', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('WISH', 'BLESS'),
    'DESC': 'wish',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.WISH_FCN,
})

# zil: 2dungeon.zil:130  <OBJECT WELL>
ZG.world.declare_object('WELL', 'WELL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WELL',
    'ADJECTIVE': 'MAGIC',
    'DESC': 'well',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.WELL_FCN,
})

# zil: 2dungeon.zil:138  <OBJECT SEWL>
ZG.world.declare_object('SEWL', 'SEWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('EAST', 'EASTERN'),
    'DESC': 'east wall',
    'FLAGS': 'NDESCBIT',
    'SIZE': 0,
    'ACTION': ZG.SCOLWALL,
})

# zil: 2dungeon.zil:147  <OBJECT SWWL>
ZG.world.declare_object('SWWL', 'SWWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('WEST', 'WESTERN'),
    'DESC': 'west wall',
    'FLAGS': 'NDESCBIT',
    'SIZE': 0,
    'ACTION': ZG.SCOLWALL,
})

# zil: 2dungeon.zil:156  <OBJECT SSWL>
ZG.world.declare_object('SSWL', 'SSWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('SOUTH', 'SOUTHE'),
    'DESC': 'south wall',
    'FLAGS': 'NDESCBIT',
    'SIZE': 0,
    'ACTION': ZG.SCOLWALL,
})

# zil: 2dungeon.zil:165  <OBJECT SNWL>
ZG.world.declare_object('SNWL', 'SNWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('NORTH', 'NORTHE'),
    'DESC': 'north wall',
    'FLAGS': 'NDESCBIT',
    'SIZE': 0,
    'ACTION': ZG.SCOLWALL,
})

'SUBTITLE ROOMS'

# zil: 2dungeon.zil:178  <ROOM INSIDE-BARROW>
ZG.world.declare_object('INSIDE_BARROW', 'INSIDE-BARROW', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are inside an ancient barrow hidden deep within a dark forest.\nThe barrow opens into a narrow tunnel at its southern end. You can\nsee a faint glow at the far end.',
    'DESC': 'Inside the Barrow',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'SOUTH': ('TO', ZG.NARROW_TUNNEL),
    'OUT': 'You may not recall, but when you entered, the door of the barrow\nshut behind you. There is no way out.',
})

# zil: 2dungeon.zil:191  <ROOM NARROW-TUNNEL>
ZG.world.declare_object('NARROW_TUNNEL', 'NARROW-TUNNEL', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are standing at the southern end of a narrow tunnel where it opens\ninto a wide cavern. The cavern is dimly illuminated by phosphorescent\nmosses clinging to its high ceiling. A deep ravine winds through the\ncavern, with a small stream at the bottom. The walls of the ravine are\nsteep and crumbly. A foot bridge crosses the ravine to the south.',
    'DESC': 'Narrow Tunnel',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'NORTH': ('TO', ZG.INSIDE_BARROW),
    'SOUTH': ('TO', ZG.FOOT_BRIDGE),
    'CROSS': ('TO', ZG.FOOT_BRIDGE),
    'DOWN': 'As you start down, you slip on the crumbling\nrocks and pull back, narrowly averting a fatal fall.',
    'GLOBAL': (ZG.BRIDGE, ZG.CHASM, ZG.STREAM, ZG.MOSS),
})

# zil: 2dungeon.zil:208  <ROOM FOOT-BRIDGE>
ZG.world.declare_object('FOOT_BRIDGE', 'FOOT-BRIDGE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are standing on a crude but sturdy wooden foot bridge crossing a\ndeep ravine. The path runs north and south from here.',
    'DESC': 'Foot Bridge',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'NORTH': ('TO', ZG.NARROW_TUNNEL),
    'SOUTH': ('TO', ZG.GREAT_CAVERN),
    'DOWN': 'The drop would be fatal.',
    'CROSS': "You'll have to specify a direction.",
    'GLOBAL': (ZG.BRIDGE, ZG.CHASM),
})

# zil: 2dungeon.zil:221  <ROOM GREAT-CAVERN>
ZG.world.declare_object('GREAT_CAVERN', 'GREAT-CAVERN', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the center of the great cavern, carved out of the limestone.\nStalactites and stalagmites of many sizes are everywhere. The room glows\nwith dim light provided by phosphorescent moss, and weird shadows move all\naround you. A narrow path winds southwest among the stalagmites, and another\nleads northeast.',
    'DESC': 'Great Cavern',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'NE': ('TO', ZG.FOOT_BRIDGE),
    'SW': ('TO', ZG.SHALLOW_FORD),
    'GLOBAL': ZG.MOSS,
    'PSEUDO': ('STALAGMITE', ZG.STALA_PSEUDO, 'STALACTITE', ZG.STALA_PSEUDO),
})

# zil: 2dungeon.zil:236  <ROOM SHALLOW-FORD>
ZG.world.declare_object('SHALLOW_FORD', 'SHALLOW-FORD', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are at the southern edge of a great cavern. To the south across a\nshallow ford is a dark tunnel which looks like it was once\nenlarged and smoothed. To the north a narrow path winds among\nstalagmites. Dim light illuminates the cavern.',
    'DESC': 'Shallow Ford',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'NORTH': ('TO', ZG.GREAT_CAVERN),
    'SOUTH': ('TO', ZG.DARK_TUNNEL),
    'CROSS': ('TO', ZG.DARK_TUNNEL),
    'GLOBAL': ZG.GLOBAL_WATER,
})

# zil: 2dungeon.zil:250  <ROOM DARK-TUNNEL>
ZG.world.declare_object('DARK_TUNNEL', 'DARK-TUNNEL', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a dark tunnel with dim light to the northeast. The\ntunnel is smooth but dusty and filled with twigs and leaves, debris\nwhich becomes deeper as the tunnel branches into a wide corridor leading\nsouthwest and a narrower one leading southeast.',
    'DESC': 'Dark Tunnel',
    'FLAGS': 'RLANDBIT',
    'NE': ('TO', ZG.SHALLOW_FORD),
    'SE': ('TO', ZG.GARDEN_NORTH),
    'SW': ('TO', ZG.STREAM_PATH),
})

'SUBTITLE GARDEN AREA'

# zil: 2dungeon.zil:265  <OBJECT GLOBAL-UNICORN>
ZG.world.declare_object('GLOBAL_UNICORN', 'GLOBAL-UNICORN', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'UNICORN',
    'DESC': 'unicorn',
    'ADJECTIVE': ('BEAUTIFUL', 'WHITE'),
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.GLOBAL_UNICORN_FCN,
})

# zil: 2dungeon.zil:273  <OBJECT UNICORN>
ZG.world.declare_object('UNICORN', 'UNICORN', lambda: {
    'SYNONYM': ('UNICORN', 'ANIMAL'),
    'ADJECTIVE': ('BEAUTIFUL', 'WHITE'),
    'DESC': 'unicorn',
    'LDESC': 'There is a beautiful unicorn here cropping grass.',
    'FLAGS': ('ACTORBIT', 'TRYTAKEBIT', 'OPENBIT', 'CONTBIT'),
    'ACTION': ZG.UNICORN_FCN,
})

# zil: 2dungeon.zil:281  <ROOM GARDEN-NORTH>
ZG.world.declare_object('GARDEN_NORTH', 'GARDEN-NORTH', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': "This is the northern end of a formal garden. Hedges hide\nthe cavern walls, and if you don't look up, the illusion is of a cloudy\nday outside. The light comes from a large growth of glowing mosses on the\nroof of the cave. A break in the hedge is almost overgrown to the north.\nA carefully manicured path leads south. In the center of a rosebed is a\nsmall open structure, painted white. It appears to be a gazebo.",
    'DESC': 'North End of Garden',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'IN': ('TO', ZG.GAZEBO_ROOM),
    'NORTH': ('TO', ZG.DARK_TUNNEL),
    'SOUTH': ('TO', ZG.FORMAL_GARDEN),
    'ACTION': ZG.GARDEN_ROOM_FCN,
    'GLOBAL': (ZG.GLOBAL_UNICORN, ZG.GAZEBO, ZG.MOSS, ZG.ROSE_BUSH),
})

# zil: 2dungeon.zil:298  <ROOM GAZEBO-ROOM>
ZG.world.declare_object('GAZEBO_ROOM', 'GAZEBO-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a gazebo in the midst of a formal garden. It is cool and\nrestful here. A tea table adorns the center of the gazebo.',
    'DESC': 'Gazebo',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'OUT': ('TO', ZG.GARDEN_NORTH),
    'GLOBAL': (ZG.GLOBAL_UNICORN, ZG.GAZEBO),
})

# zil: 2dungeon.zil:308  <ROOM FORMAL-GARDEN>
ZG.world.declare_object('FORMAL_GARDEN', 'FORMAL-GARDEN', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the middle part of a formal garden. Hedges hide the cavern\nwalls and a dim illumination comes from mosses far above.\nThe path is of small crushed white stones. It winds among bushes and\nflower beds from south to north. To the north a small structure\ncan be seen. To the south are peculiarly shaped bushes.\nThere is a small gap in the hedges to the west.',
    'DESC': 'Formal Garden',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'WEST': ('TO', ZG.STREAM_PATH),
    'NORTH': ('TO', ZG.GARDEN_NORTH),
    'SOUTH': ('TO', ZG.TOPIARY_ROOM),
    'ACTION': ZG.GARDEN_ROOM_FCN,
    'GLOBAL': (ZG.GLOBAL_UNICORN, ZG.MOSS),
})

# zil: 2dungeon.zil:325  <ROOM TOPIARY-ROOM>
ZG.world.declare_object('TOPIARY_ROOM', 'TOPIARY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the southern end of a formal garden. Hedges hide the cavern\nwalls and mosses provide dim illumination. Fantastically shaped hedges\nand bushes are arrayed with geometric precision. They have not recently\nbeen clipped, but you can discern creatures in the shapes of the bushes:\nThere is a dragon, a unicorn, a great serpent, a huge misshapen dog, and\nseveral human figures. On the west side of the garden the path\nleads through a rose arbor into a tunnel.',
    'DESC': 'Topiary',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'WEST': ('TO', ZG.CAROUSEL_ROOM),
    'NORTH': ('TO', ZG.FORMAL_GARDEN),
    'ACTION': ZG.GARDEN_ROOM_FCN,
    'GLOBAL': (ZG.GLOBAL_UNICORN, ZG.MOSS, ZG.ROSE_BUSH),
})

# zil: 2dungeon.zil:342  <OBJECT HEDGES>
ZG.world.declare_object('HEDGES', 'HEDGES', lambda: {
    'LOC': ZG.TOPIARY_ROOM,
    'DESC': 'hedge',
    'SYNONYM': ('HEDGE', 'HEDGES'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.HEDGES_F,
})

# zil: 2dungeon.zil:349  <ROUTINE HEDGES-F ()>
@ZG.routine('HEDGES-F')
def HEDGES_F():
    if VERB_p('EXAMINE'):
        return TELL('The hedges are shaped like various animals: dogs, serpents, dragons, and\nthe like, and they are vaguely troubling to look at.', CR)
    else:
        return False

# zil: 2dungeon.zil:355  <ROOM STREAM-PATH>
ZG.world.declare_object('STREAM_PATH', 'STREAM-PATH', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'The path follows the south edge of a deep ravine and heads northeast.\nA tunnel heads southwest, narrowing to a rather tight crawl. A\nfaint whirring sound can be heard in that direction. On the east is a\nruined archway choked with vegetation.',
    'DESC': 'Path Near Stream',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.FORMAL_GARDEN),
    'NE': ('TO', ZG.DARK_TUNNEL),
    'SW': ('TO', ZG.CAROUSEL_ROOM),
    'WEST': ('TO', ZG.MARBLE_HALL, 'IF', 'SECRET_DOOR'),
    'DOWN': 'The ravine is extremely deep. You would never make it.',
    'GLOBAL': (ZG.BRIDGE, ZG.CHASM, ZG.STREAM),
})

# zil: 2dungeon.zil:371  <ROOM MARBLE-HALL>
ZG.world.declare_object('MARBLE_HALL', 'MARBLE-HALL', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is an arched hall of fine marble. The hall stops abruptly\nto the north at a ford across a stream, where the marble is cracked and\nbroken. Perhaps a flood or collapse of the cave was responsible. To\nthe south the hall opens into a large room. There is rather annoying\nwhirring sound coming from that room.',
    'DESC': 'Marble Hall',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.STREAM_PATH, 'IF', 'SECRET_DOOR', 'ELSE', "That's a wall there."),
    'NORTH': ('TO', ZG.DEEP_FORD),
    'SOUTH': ('TO', ZG.CAROUSEL_ROOM),
    'GLOBAL': ZG.STREAM,
})

# zil: 2dungeon.zil:386  <ROOM DEEP-FORD>
ZG.world.declare_object('DEEP_FORD', 'DEEP-FORD', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are fording the stream at a deep but not impossible spot. The\nwater is very cold. The walls of the ravine rise to east and west.\nThere is a small ledge along the north wall of the ravine. To the south\nis the entrance to a well-constructed but somewhat ruined hall.',
    'DESC': 'Deep Ford',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.RAVINE_LEDGE),
    'UP': ('TO', ZG.RAVINE_LEDGE),
    'SOUTH': ('TO', ZG.MARBLE_HALL),
    'EAST': 'The stream deepens rapidly, and you wisely return before drowning.',
    'WEST': 'You notice that the ledge above would be a drier route west.',
    'GLOBAL': (ZG.GLOBAL_WATER, ZG.CHASM, ZG.STREAM),
})

# zil: 2dungeon.zil:404  <ROOM RAVINE-LEDGE>
ZG.world.declare_object('RAVINE_LEDGE', 'RAVINE-LEDGE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are on a narrow ledge near the bottom of a deep ravine. The ledge\ncontinues to the west. A precarious climb up to another tiny ledge is\npossible. A short scramble down the rock face leads\nto a stream.',
    'DESC': 'Ledge in Ravine',
    'FLAGS': 'RLANDBIT',
    'UP': ('TO', ZG.TINY_ROOM),
    'SOUTH': ('TO', ZG.DEEP_FORD),
    'WEST': ('TO', ZG.LEDGE_TUNNEL),
    'DOWN': ('TO', ZG.DEEP_FORD),
    'GLOBAL': ZG.CHASM,
})

# zil: 2dungeon.zil:419  <ROOM LEDGE-TUNNEL>
ZG.world.declare_object('LEDGE_TUNNEL', 'LEDGE-TUNNEL', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'A ledge from the east ends here, and a tunnel leads north into the wall.\nThere is a rather odd smokey odor in the warm air of the tunnel.',
    'DESC': 'End of Ledge',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.RAVINE_LEDGE),
    'IN': ('TO', ZG.DRAGON_ROOM),
    'NORTH': ('TO', ZG.DRAGON_ROOM),
    'DOWN': 'There are a lot of sharp rocks down there.',
})

# zil: 2dungeon.zil:431  <ROOM DRAGON-ROOM>
ZG.world.declare_object('DRAGON_ROOM', 'DRAGON-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'The room is a large cavern full of broken stone. The walls are\nscorched and there are deep scratches on the floor. A sooty dry smell\nis very strong here. A paved path winds from a large passage to the\nwest, through the room, and across a huge stone bridge\nto the south. To the east a small crack is visible. A dark and\nsmokey tunnel leads north.',
    'DESC': 'Dragon Room',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.LEDGE_TUNNEL),
    'NORTH': ('TO', ZG.DRAGON_LAIR, 'IF', 'ICE_MELTED', 'ELSE', 'The dragon hisses at you and blocks your way.'),
    'IN': ('TO', ZG.DRAGON_LAIR, 'IF', 'ICE_MELTED', 'ELSE', 'The dragon hisses at you and blocks your way.'),
    'WEST': ('TO', ZG.FRESCO_ROOM),
    'SOUTH': ('TO', ZG.STONE_BRIDGE),
    'CROSS': ('TO', ZG.STONE_BRIDGE),
    'GLOBAL': ZG.BRIDGE,
})

# zil: 2dungeon.zil:452  <ROOM DRAGON-LAIR>
ZG.world.declare_object('DRAGON_LAIR', 'DRAGON-LAIR', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': "You are in the dragon's lair, where the rock walls are scarred by flame.\nA blackened doorway leads to the south.",
    'DESC': "Dragon's Lair",
    'FLAGS': 'RLANDBIT',
    'SOUTH': ('TO', ZG.DRAGON_ROOM),
    'OUT': ('TO', ZG.DRAGON_ROOM),
})

# zil: 2dungeon.zil:462  <OBJECT CHEST>
ZG.world.declare_object('CHEST', 'CHEST', lambda: {
    'LOC': ZG.DRAGON_LAIR,
    'SYNONYM': ('CHEST', 'TRUNK'),
    'ADJECTIVE': ('WOODEN', 'OLD', 'ROTTEN'),
    'DESC': 'rotten wooden chest',
    'FDESC': 'A rotten old wooden chest is in one corner among the debris.',
    'FLAGS': ('CONTBIT', 'TAKEBIT'),
    'ACTION': ZG.CHEST_FCN,
    'CAPACITY': 40,
    'SIZE': 40,
})

# zil: 2dungeon.zil:474  <OBJECT STATUETTE>
ZG.world.declare_object('STATUETTE', 'STATUETTE', lambda: {
    'LOC': ZG.CHEST,
    'SYNONYM': ('TREASURE', 'STATUETTE', 'DRAGON'),
    'ADJECTIVE': 'GOLD',
    'DESC': 'golden dragon statuette',
    'FDESC': 'Nestled in the chest is a wrought gold statuette of a dragon.',
    'FLAGS': ('STAGGERED', 'TAKEBIT'),
    'VALUE': 20,
})

# zil: 2dungeon.zil:484  <OBJECT DRAGON>
ZG.world.declare_object('DRAGON', 'DRAGON', lambda: {
    'LOC': ZG.DRAGON_ROOM,
    'SYNONYM': ('DRAGON', 'SMAUG', 'WORM'),
    'ADJECTIVE': ('RED', 'HUGE'),
    'DESC': 'huge red dragon',
    'LDESC': 'A huge red dragon is lying on the rocks here, watching.',
    'FDESC': 'A huge red dragon is lying here, blocking the entrance to a tunnel\nleading north. Smoke curls from his nostrils and out between his\nteeth.',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.DRAGON_FCN,
})

# zil: 2dungeon.zil:498  <OBJECT DEAD-DRAGON>
ZG.world.declare_object('DEAD_DRAGON', 'DEAD-DRAGON', lambda: {
    'SYNONYM': ('DRAGON', 'SMAUG', 'WORM'),
    'ADJECTIVE': ('RED', 'HUGE', 'DEAD'),
    'DESC': 'huge dead dragon',
    'LDESC': 'A huge dead dragon is lying half blocking the stream.',
    'SIZE': 400,
})

# zil: 2dungeon.zil:506  <OBJECT GLOBAL-PRINCESS>
ZG.world.declare_object('GLOBAL_PRINCESS', 'GLOBAL-PRINCESS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('PRINCESS', 'WOMAN', 'LADY'),
    'ADJECTIVE': ('BEAUTIFUL', 'YOUNG'),
    'DESC': 'beautiful princess',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.PRINCESS_FCN,
})

# zil: 2dungeon.zil:514  <OBJECT PRINCESS>
ZG.world.declare_object('PRINCESS', 'PRINCESS', lambda: {
    'LOC': ZG.DRAGON_LAIR,
    'SYNONYM': ('PRINCESS', 'WOMAN', 'LADY'),
    'ADJECTIVE': ('BEAUTIFUL', 'YOUNG'),
    'DESC': 'beautiful princess',
    'LDESC': 'A beautiful young woman, wearing a dirty and bedraggled gown, sits\non a rock in the corner. Her hair is unkempt and she is oblivious to\nyour presence, almost in a trance.',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.PRINCESS_FCN,
})

# zil: 2dungeon.zil:526  <ROOM FRESCO-ROOM>
ZG.world.declare_object('FRESCO_ROOM', 'FRESCO-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'A path leads east-west through a room decorated with beautiful frescoes\nof someone battling dragons and rescuing fair maidens. It is hard\nto tell who is doing this as those parts of the\nfrescoes have been blackened and cracked by intense heat.',
    'DESC': 'Fresco Room',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.DRAGON_ROOM),
    'WEST': ('TO', ZG.BANK_ENTRANCE),
})

# zil: 2dungeon.zil:538  <ROOM STONE-BRIDGE>
ZG.world.declare_object('STONE_BRIDGE', 'STONE-BRIDGE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the middle of a ruined but still impressive stone bridge\nspanning a deep chasm. Water flows far beneath. A paved path leads\nnorth into a large open space. To the south, the path leads into a misty\ntunnel.',
    'DESC': 'Stone Bridge',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.DRAGON_ROOM),
    'SOUTH': ('TO', ZG.COOL_ROOM),
    'DOWN': "It's a long way down.",
    'CROSS': "You'll have to specify a direction.",
    'GLOBAL': (ZG.BRIDGE, ZG.CHASM),
})

# zil: 2dungeon.zil:553  <ROOM COOL-ROOM>
ZG.world.declare_object('COOL_ROOM', 'COOL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'The room is cool and damp. The air is misty. A twisty path from the\nsoutheast splits here toward a wide northerly stone bridge, and a narrow\nwesterly tunnel. It is from the latter\nthat the mist and chill seem to originate.',
    'DESC': 'Cool Room',
    'FLAGS': 'RLANDBIT',
    'SE': ('TO', ZG.CAROUSEL_ROOM),
    'NORTH': ('TO', ZG.STONE_BRIDGE),
    'WEST': ('TO', ZG.GLACIER_ROOM),
    'CROSS': ('TO', ZG.STONE_BRIDGE),
    'GLOBAL': ZG.BRIDGE,
})

# zil: 2dungeon.zil:568  <ROOM GLACIER-ROOM>
ZG.world.declare_object('GLACIER_ROOM', 'GLACIER-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Ice Room',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.COOL_ROOM),
    'WEST': ('TO', ZG.LAVA_ROOM, 'IF', 'ICE_MELTED', 'ELSE', "You don't even have an ice-pick."),
    'UP': ('TO', ZG.LAVA_TUBE),
    'ACTION': ZG.GLACIER_ROOM_FCN,
})

# zil: 2dungeon.zil:579  <ROOM LAVA-TUBE>
ZG.world.declare_object('LAVA_TUBE', 'LAVA-TUBE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are in a tight chimney of solidified lava. It extends up at\nleast another hundred feet and down to a large room far below. A large\ncrack opens to the south, probably the result of a shift\nin the rock strata.',
    'DESC': 'Lava Tube',
    'FLAGS': 'RLANDBIT',
    'DOWN': ('TO', ZG.GLACIER_ROOM),
    'UP': ('TO', ZG.VOLCANO_VIEW),
    'SOUTH': ('TO', ZG.COBWEBBY_CORRIDOR),
    'PSEUDO': ('CRACK', ZG.LT_CRACK_PSEUDO),
})

# zil: 2dungeon.zil:593  <ROUTINE LT-CRACK-PSEUDO ()>
@ZG.routine('LT-CRACK-PSEUDO')
def LT_CRACK_PSEUDO():
    if VERB_p('BOARD', 'THROUGH'):
        ZG.DO_WALK('SOUTH')
        return True
    else:
        return ZG.CC_CRACK_PSEUDO()

# zil: 2dungeon.zil:599  <ROOM COBWEBBY-CORRIDOR>
ZG.world.declare_object('COBWEBBY_CORRIDOR', 'COBWEBBY-CORRIDOR', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'A winding corridor is filled with cobwebs. Some\nare broken and the dust on the floor is disturbed. The trend of the\ntwists and turns is northeast to southwest. On the north side of one\ntwist, high up, is a narrow crack.',
    'DESC': 'Cobwebby Corridor',
    'FLAGS': 'RLANDBIT',
    'IN': ('TO', ZG.LAVA_TUBE),
    'UP': ('TO', ZG.LAVA_TUBE),
    'NORTH': ('TO', ZG.LAVA_TUBE),
    'NE': ('TO', ZG.CAROUSEL_ROOM),
    'SW': ('TO', ZG.GUARDIAN_ROOM),
    'DOWN': ('TO', ZG.GUARDIAN_ROOM),
    'PSEUDO': ('CRACK', ZG.CC_CRACK_PSEUDO),
})

# zil: 2dungeon.zil:616  <ROUTINE CC-CRACK-PSEUDO ()>
@ZG.routine('CC-CRACK-PSEUDO')
def CC_CRACK_PSEUDO():
    if VERB_p('THROUGH', 'BOARD'):
        ZG.DO_WALK('NORTH')
        return True
    else:
        return TELL('The crack is fairly wide. You should be able to get into it.', CR)

# zil: 2dungeon.zil:624  <OBJECT WIZ-DOOR>
ZG.world.declare_object('WIZ_DOOR', 'WIZ-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('COBWEBBED', 'WOODEN', 'OAK'),
    'DESC': 'door partly covered in cobwebs',
    'FLAGS': ('DOORBIT', 'CONTBIT'),
    'ACTION': ZG.WIZ_DOOR_FCN,
})

# zil: 2dungeon.zil:632  <ROOM ROOM-8>
ZG.world.declare_object('ROOM_8', 'ROOM-8', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a small chamber carved out of the rock at the end of a short crawl.\nOn the wall is crudely chiseled the number "8".',
    'DESC': 'Room 8',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.CAROUSEL_ROOM),
})

# zil: 2dungeon.zil:641  <ROOM MENHIR-ROOM>
ZG.world.declare_object('MENHIR_ROOM', 'MENHIR-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Menhir Room',
    'LDESC': ' ',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.CAROUSEL_ROOM),
    'SW': ('TO', ZG.KENNEL, 'IF', 'MENHIR_POSITION', 'ELSE', 'You are trying to walk through an enormous rock.'),
    'SOUTH': ('TO', ZG.STAIRWAY_TOP),
    'ACTION': ZG.MENHIR_ROOM_FCN,
    'GLOBAL': ZG.MENHIR,
})

# zil: 2dungeon.zil:654  <OBJECT GLOBAL-MENHIR>
ZG.world.declare_object('GLOBAL_MENHIR', 'GLOBAL-MENHIR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('MENHIR', 'ROCK', 'STONE'),
    'ADJECTIVE': ('HUGE', 'HEAVY', 'ENORMOUS'),
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'ACTION': ZG.GLOBAL_MENHIR_F,
    'DESC': 'enormous menhir',
})

# zil: 2dungeon.zil:662  <ROUTINE GLOBAL-MENHIR-F ()>
@ZG.routine('GLOBAL-MENHIR-F')
def GLOBAL_MENHIR_F():
    return TELL("It's not here.", CR)

# zil: 2dungeon.zil:665  <OBJECT MENHIR>
ZG.world.declare_object('MENHIR', 'MENHIR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('MENHIR', 'ROCK', 'STONE', 'F'),
    'ADJECTIVE': ('HUGE', 'HEAVY', 'ENORMOUS'),
    'FLAGS': ('NDESCBIT', 'READBIT', 'TURNBIT'),
    'DESC': 'enormous menhir',
    'ACTION': ZG.MENHIR_FCN,
})

# zil: 2dungeon.zil:673  <ROOM KENNEL>
ZG.world.declare_object('KENNEL', 'KENNEL', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': "This room looks like it was once a kennel for a very large dog (some of\nthe bones would fit a dinosaur). It apparently hasn't been used for a\nlong time, as the dust is fairly thick all over. The only\nexit is northeast.",
    'DESC': 'Kennel',
    'FLAGS': 'RLANDBIT',
    'NE': ('TO', ZG.MENHIR_ROOM, 'IF', 'MENHIR_POSITION', 'ELSE', 'You are trying to walk through an enormous rock.'),
    'OUT': ('TO', ZG.MENHIR_ROOM, 'IF', 'MENHIR_POSITION', 'ELSE', 'You are trying to walk through an enormous rock.'),
    'GLOBAL': ZG.MENHIR,
})

# zil: 2dungeon.zil:690  <OBJECT COLLAR>
ZG.world.declare_object('COLLAR', 'COLLAR', lambda: {
    'LOC': ZG.KENNEL,
    'SYNONYM': ('COLLAR', 'TREASURE'),
    'ADJECTIVE': ('HUGE', 'GIANT', 'DOG'),
    'FDESC': 'A gigantic dog collar, large enough for three rhinoceros-sized dogs, is\nlying amidst the debris.',
    'DESC': 'gigantic dog collar',
    'FLAGS': ('STAGGERED', 'TAKEBIT'),
    'ACTION': ZG.COLLAR_FCN,
    'VALUE': 15,
})

'SUBTITLE DIAMOND MAZE'

# zil: 2dungeon.zil:706  <OBJECT BAT>
ZG.world.declare_object('BAT', 'BAT', lambda: {
    'SYNONYM': ('CLUB', 'BAT'),
    'ADJECTIVE': ('WOODEN', 'BASEBALL'),
    'FDESC': 'A long wooden club lies on the ground near the diamond-shaped window.\nThe club is curiously burned at the thick end.',
    'DESC': 'wooden club',
    'FLAGS': ('INVISIBLE', 'TAKEBIT', 'WEAPONBIT', 'READBIT', 'BURNBIT'),
    'TEXT': 'The words "Babe Flathead" are burned into the wood.',
})

# zil: 2dungeon.zil:717  <ROOM STAIRWAY-TOP>
ZG.world.declare_object('STAIRWAY_TOP', 'STAIRWAY-TOP', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'A marble stairway leads down into the gloom and a passage leads north.',
    'DESC': 'Stairway',
    'FLAGS': 'RLANDBIT',
    'DOWN': ('TO', ZG.DIAMOND_5),
    'NORTH': ('TO', ZG.MENHIR_ROOM),
    'GLOBAL': ZG.STAIRS,
})

# zil: 2dungeon.zil:727  <ROOM DIAMOND-1>
ZG.world.declare_object('DIAMOND_1', 'DIAMOND-1', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'SE': ('TO', ZG.DIAMOND_5),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:738  <ROOM DIAMOND-2>
ZG.world.declare_object('DIAMOND_2', 'DIAMOND-2', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'SOUTH': ('TO', ZG.DIAMOND_5),
    'SE': ('TO', ZG.DIAMOND_6),
    'SW': ('TO', ZG.DIAMOND_4),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:751  <ROOM DIAMOND-3>
ZG.world.declare_object('DIAMOND_3', 'DIAMOND-3', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'SW': ('TO', ZG.DIAMOND_5),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:762  <ROOM DIAMOND-4>
ZG.world.declare_object('DIAMOND_4', 'DIAMOND-4', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'NE': ('TO', ZG.DIAMOND_2),
    'SE': ('TO', ZG.DIAMOND_8),
    'EAST': ('TO', ZG.DIAMOND_5),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:775  <ROOM DIAMOND-5>
ZG.world.declare_object('DIAMOND_5', 'DIAMOND-5', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'NW': ('TO', ZG.DIAMOND_1),
    'NORTH': ('TO', ZG.DIAMOND_2),
    'NE': ('TO', ZG.DIAMOND_3),
    'WEST': ('TO', ZG.DIAMOND_4),
    'EAST': ('TO', ZG.DIAMOND_6),
    'SW': ('TO', ZG.DIAMOND_7),
    'SOUTH': ('TO', ZG.DIAMOND_8),
    'SE': ('TO', ZG.DIAMOND_9),
    'DOWN': ('TO', ZG.CERBERUS_ROOM),
    'UP': ('TO', ZG.STAIRWAY_TOP),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': (ZG.STAIRS, ZG.DWINDOW),
})

# zil: 2dungeon.zil:795  <ROOM DIAMOND-6>
ZG.world.declare_object('DIAMOND_6', 'DIAMOND-6', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'WEST': ('TO', ZG.DIAMOND_5),
    'NW': ('TO', ZG.DIAMOND_2),
    'SW': ('TO', ZG.DIAMOND_8),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:808  <ROOM DIAMOND-7>
ZG.world.declare_object('DIAMOND_7', 'DIAMOND-7', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'NE': ('TO', ZG.DIAMOND_5),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:819  <ROOM DIAMOND-8>
ZG.world.declare_object('DIAMOND_8', 'DIAMOND-8', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.DIAMOND_5),
    'NW': ('TO', ZG.DIAMOND_4),
    'NE': ('TO', ZG.DIAMOND_6),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:832  <ROOM DIAMOND-9>
ZG.world.declare_object('DIAMOND_9', 'DIAMOND-9', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Oddly-angled Room',
    'LDESC': 'A small room with oddly angled walls and passages in all directions.',
    'FLAGS': 'RLANDBIT',
    'NW': ('TO', ZG.DIAMOND_5),
    'ACTION': ZG.DIAMOND_MOTION,
    'GLOBAL': ZG.DWINDOW,
})

# zil: 2dungeon.zil:843  <OBJECT DWINDOW>
ZG.world.declare_object('DWINDOW', 'DWINDOW', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WINDOW',
    'ADJECTIVE': ('GLOWING', 'DIAMOND'),
    'DESC': 'diamond shaped window',
    'ACTION': ZG.DWINDOW_FCN,
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
})

# zil: 2dungeon.zil:851  <ROOM CERBERUS-ROOM>
ZG.world.declare_object('CERBERUS_ROOM', 'CERBERUS-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the entrance to a huge crypt or tomb. A marble stairway leads\nup from a gateway arch.',
    'DESC': 'Cerberus Room',
    'FLAGS': 'RLANDBIT',
    'EAST': ('TO', ZG.CRYPT_ANTEROOM, 'IF', 'CERBERUS_LEASHED', 'ELSE', 'The huge dog snaps nastily at you.'),
    'IN': ('TO', ZG.CRYPT_ANTEROOM, 'IF', 'CERBERUS_LEASHED', 'ELSE', 'The huge dog snaps nastily at you.'),
    'UP': ('TO', ZG.DIAMOND_5),
    'VALUE': 10,
    'GLOBAL': ZG.STAIRS,
    'PSEUDO': ('TOMB', ZG.TOMB_PSEUDO, 'CRYPT', ZG.TOMB_PSEUDO),
})

# zil: 2dungeon.zil:867  <OBJECT GLOBAL-CERBERUS>
ZG.world.declare_object('GLOBAL_CERBERUS', 'GLOBAL-CERBERUS', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('CERBERUS', 'DOG', 'HOUND', 'MONSTER'),
    'ADJECTIVE': ('HUGE', 'GIANT', 'THREE', 'HEADED'),
    'ACTION': ZG.GLOBAL_CERBERUS_F,
    'DESC': 'three-headed dog',
})

# zil: 2dungeon.zil:874  <ROUTINE GLOBAL-CERBERUS-F ()>
@ZG.routine('GLOBAL-CERBERUS-F')
def GLOBAL_CERBERUS_F():
    return TELL("He's not here.", CR)

# zil: 2dungeon.zil:877  <OBJECT CERBERUS>
ZG.world.declare_object('CERBERUS', 'CERBERUS', lambda: {
    'LOC': ZG.CERBERUS_ROOM,
    'SYNONYM': ('CERBERUS', 'DOG', 'HOUND', 'MONSTER'),
    'ADJECTIVE': ('HUGE', 'GIANT', 'THREE', 'HEADED'),
    'DESC': 'three-headed dog',
    'LDESC': 'There is a vicious-looking dog guarding the entrance. It is more or\nless your usual dog, except that it has three heads and is the size of\nan elephant.',
    'FLAGS': ('ACTORBIT', 'OPENBIT', 'CONTBIT'),
    'ACTION': ZG.CERBERUS_FCN,
})

# zil: 2dungeon.zil:889  <ROOM CRYPT-ANTEROOM>
ZG.world.declare_object('CRYPT_ANTEROOM', 'CRYPT-ANTEROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Crypt Anteroom',
    'FLAGS': 'RLANDBIT',
    'IN': ('TO', ZG.CRYPT_ROOM, 'IF', 'CRYPT_DOOR', 'IS', 'OPEN'),
    'SOUTH': ('TO', ZG.CRYPT_ROOM, 'IF', 'CRYPT_DOOR', 'IS', 'OPEN'),
    'WEST': ('TO', ZG.CERBERUS_ROOM),
    'ACTION': ZG.CRYPT_ANTEROOM_FCN,
    'GLOBAL': ZG.CRYPT_DOOR,
    'VALUE': 3,
})

# zil: 2dungeon.zil:901  <ROOM CRYPT-ROOM>
ZG.world.declare_object('CRYPT_ROOM', 'CRYPT-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Crypt',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.CRYPT_ANTEROOM, 'IF', 'CRYPT_DOOR', 'IS', 'OPEN'),
    'SOUTH': ('TO', ZG.ZORK3, 'IF', 'DIM_DOOR_FLAG'),
    'GLOBAL': (ZG.CRYPT_DOOR, ZG.DIM_DOOR),
    'ACTION': ZG.CRYPT_ROOM_FCN,
    'VALUE': 2,
})

# zil: 2dungeon.zil:912  <OBJECT HEADS>
ZG.world.declare_object('HEADS', 'HEADS', lambda: {
    'LOC': ZG.CRYPT_ROOM,
    'SYNONYM': ('HEADS', 'HEAD', 'POLE', 'POLES'),
    'DESC': 'set of poled heads',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.HEAD_FCN,
})

# zil: 2dungeon.zil:919  <OBJECT CRYPT>
ZG.world.declare_object('CRYPT', 'CRYPT', lambda: {
    'LOC': ZG.CRYPT_ROOM,
    'SYNONYM': ('TOMB', 'CRYPT', 'GRAVE'),
    'ADJECTIVE': 'MARBLE',
    'DESC': 'marble crypt',
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'ACTION': ZG.CRYPT_OBJECT,
    'TEXT': '"Here lie the Flatheads, whose heads were placed on poles by the\nKeeper of the Dungeon for amazing untastefulness."',
})

# zil: 2dungeon.zil:930  <OBJECT CRYPT-DOOR>
ZG.world.declare_object('CRYPT_DOOR', 'CRYPT-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('CRYPT', 'NORTH'),
    'DESC': 'crypt door',
    'FLAGS': ('DOORBIT', 'CONTBIT'),
    'ACTION': ZG.CRYPT_DOOR_FCN,
})

# zil: 2dungeon.zil:938  <OBJECT DIM-DOOR>
ZG.world.declare_object('DIM_DOOR', 'DIM-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('DOOR', 'LETTER'),
    'ADJECTIVE': ('F', 'DIMLY', 'SOUTH', 'SECRET'),
    'DESC': 'secret door',
    'FLAGS': ('DOORBIT', 'CONTBIT', 'INVISIBLE'),
    'ACTION': ZG.DIM_DOOR_FCN,
})

# zil: 2dungeon.zil:946  <ROOM ZORK3>
ZG.world.declare_object('ZORK3', 'ZORK3', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Landing',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.ZORK3_FCN,
})

"SUBTITLE WIZARD'S WORKSHOP"

# zil: 2dungeon.zil:957  <ROOM GUARDIAN-ROOM>
ZG.world.declare_object('GUARDIAN_ROOM', 'GUARDIAN-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Guarded Room',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.COBWEBBY_CORRIDOR),
    'SOUTH': ('TO', ZG.WIZARDS_WORKSHOP, 'IF', 'WIZ_DOOR', 'IS', 'OPEN'),
    'IN': ('TO', ZG.WIZARDS_WORKSHOP, 'IF', 'WIZ_DOOR', 'IS', 'OPEN'),
    'ACTION': ZG.GUARDIAN_ROOM_FCN,
    'GLOBAL': ZG.WIZ_DOOR,
})

# zil: 2dungeon.zil:970  <OBJECT DOOR-KEEPER>
ZG.world.declare_object('DOOR_KEEPER', 'DOOR-KEEPER', lambda: {
    'LOC': ZG.GUARDIAN_ROOM,
    'SYNONYM': ('KEEPER', 'GUARDIAN', 'LIZARD', 'HEAD'),
    'ADJECTIVE': 'NASTY',
    'DESC': 'lizard',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.DOOR_KEEPER_FCN,
})

# zil: 2dungeon.zil:978  <ROOM WIZARDS-WORKSHOP>
ZG.world.declare_object('WIZARDS_WORKSHOP', 'WIZARDS-WORKSHOP', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the workshop of the Wizard of Frobozz.',
    'DESC': "Wizard's Workshop",
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.GUARDIAN_ROOM, 'IF', 'WIZ_DOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.GUARDIAN_ROOM, 'IF', 'WIZ_DOOR', 'IS', 'OPEN'),
    'WEST': ('TO', ZG.WORKBENCH_ROOM),
    'SOUTH': ('TO', ZG.TROPHY_ROOM),
    'ACTION': ZG.WORKSHOP_FCN,
    'VALUE': 10,
    'GLOBAL': ZG.WIZ_DOOR,
})

# zil: 2dungeon.zil:992  <ROOM WORKBENCH-ROOM>
ZG.world.declare_object('WORKBENCH_ROOM', 'WORKBENCH-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': "This room is the Wizard's workroom. A hall continues east and west,\nand a larger room lies to the south. There are many shelves and racks\non the walls, but the Wizard's workbench dominates the room. It is made\nof dark, heavy wood bound with iron. The workbench is stained from many\nyears of use, and is deeply gouged as though some huge clawed animal was\nimprisoned on it. There are burn marks and even notes written in a crabbed\nhand. Many arcane items are scattered about the bench; alembics, mortar\nand pestle, small knives of various sizes, odd scraps of vellum, wax\ncandles, and much more. In the center of a relatively clear area of the\nbench are affixed three stands - ruby, sapphire, and diamond - which form\na triangle.",
    'DESC': "Wizard's Workroom",
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'EAST': ('TO', ZG.WIZARDS_WORKSHOP),
    'SOUTH': ('TO', ZG.PENTAGRAM_ROOM),
    'WEST': ('TO', ZG.AQUARIUM_ROOM),
    'PSEUDO': ('MORTAR', ZG.ARCANA_PSEUDO, 'PESTLE', ZG.ARCANA_PSEUDO),
})

# zil: 2dungeon.zil:1013  <OBJECT ARCANA>
ZG.world.declare_object('ARCANA', 'ARCANA', lambda: {
    'LOC': ZG.WORKBENCH_ROOM,
    'SYNONYM': ('ALEMBIC', 'VELLUM', 'CANDLES', 'KNIVES'),
    'ADJECTIVE': ('WAX', 'SMALL'),
    'DESC': 'arcane item',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.ARCANA_PSEUDO,
})

# zil: 2dungeon.zil:1021  <OBJECT WORKBENCH>
ZG.world.declare_object('WORKBENCH', 'WORKBENCH', lambda: {
    'LOC': ZG.WORKBENCH_ROOM,
    'SYNONYM': ('WORKBENCH', 'BENCH', 'TABLE'),
    'ADJECTIVE': ('WORK', 'HEAVY', 'WOODEN', 'WIZARD'),
    'DESC': "Wizard's workbench",
    'CAPACITY': 200,
    'FLAGS': ('NDESCBIT', 'SURFACEBIT', 'CONTBIT', 'OPENBIT'),
})

# zil: 2dungeon.zil:1029  <OBJECT STAND-1>
ZG.world.declare_object('STAND_1', 'STAND-1', lambda: {
    'LOC': ZG.WORKBENCH,
    'SYNONYM': ('STAND', 'STANDS'),
    'ADJECTIVE': ('CRYSTAL', 'RUBY'),
    'DESC': 'ruby stand',
    'FLAGS': ('NDESCBIT', 'SURFACEBIT', 'CONTBIT', 'OPENBIT'),
    'CAPACITY': 10,
    'ACTION': ZG.STAND_FCN,
})

# zil: 2dungeon.zil:1038  <OBJECT STAND-2>
ZG.world.declare_object('STAND_2', 'STAND-2', lambda: {
    'LOC': ZG.WORKBENCH,
    'SYNONYM': ('STAND', 'STANDS'),
    'ADJECTIVE': ('CRYSTAL', 'SAPPHIRE'),
    'DESC': 'sapphire stand',
    'FLAGS': ('NDESCBIT', 'SURFACEBIT', 'OPENBIT', 'CONTBIT'),
    'CAPACITY': 10,
    'ACTION': ZG.STAND_FCN,
})

# zil: 2dungeon.zil:1047  <OBJECT STAND-3>
ZG.world.declare_object('STAND_3', 'STAND-3', lambda: {
    'LOC': ZG.WORKBENCH,
    'SYNONYM': ('STAND', 'STANDS'),
    'ADJECTIVE': ('DIAMOND', 'CRYSTAL'),
    'DESC': 'diamond stand',
    'FLAGS': ('NDESCBIT', 'SURFACEBIT', 'OPENBIT', 'CONTBIT'),
    'CAPACITY': 10,
    'ACTION': ZG.STAND_FCN,
})

# zil: 2dungeon.zil:1056  <OBJECT STAND-4>
ZG.world.declare_object('STAND_4', 'STAND-4', lambda: {
    'SYNONYM': ('STAND', 'STANDS'),
    'ADJECTIVE': ('OBSIDIAN', 'BLACK', 'CRYSTAL', 'STRANGE'),
    'DESC': 'black obsidian stand',
    'FLAGS': ('SURFACEBIT', 'CONTBIT', 'OPENBIT'),
    'SIZE': 5,
    'CAPACITY': 10,
    'ACTION': ZG.STAND_FCN,
})

# zil: 2dungeon.zil:1065  <OBJECT PALANTIR-4>
ZG.world.declare_object('PALANTIR_4', 'PALANTIR-4', lambda: {
    'LOC': ZG.STAND_4,
    'SYNONYM': ('SPHERE', 'BALL', 'PALANTIR'),
    'ADJECTIVE': ('CRYSTAL', 'STRANGE', 'BLACK'),
    'DESC': 'black crystal sphere',
    'FLAGS': ('STAGGERED', 'TAKEBIT', 'TRANSBIT'),
    'ACTION': ZG.PALANTIR,
    'LDESC': 'There is a strange black sphere here.',
    'VALUE': 30,
    'SIZE': 10,
})

# zil: 2dungeon.zil:1076  <ROOM TROPHY-ROOM>
ZG.world.declare_object('TROPHY_ROOM', 'TROPHY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': "This is the Wizard's trophy room, filled with memorabilia of various\nsorts. On one wall is the Wizard's D. T. (Doctor of Thaumaturgy) degree\nfrom GUE Tech. Several old magic wands are mounted on a wand rack. A\ncollection of dull and nicked swords testify to the fate of many\nfoolhardy adventurers. Small bottles contain discarded homunculi (a few\npreserved in alcohol). There is a stuffed owl on a perch.",
    'DESC': 'Trophy Room',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.WIZARDS_WORKSHOP),
    'PSEUDO': ('OWL', ZG.TROPHY_PSEUDO, 'HOMUNCULI', ZG.TROPHY_PSEUDO),
})

# zil: 2dungeon.zil:1092  <OBJECT DEGREE>
ZG.world.declare_object('DEGREE', 'DEGREE', lambda: {
    'LOC': ZG.TROPHY_ROOM,
    'SYNONYM': ('DEGREE', 'DIPLOMA'),
    'DESC': 'degree',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT', 'READBIT'),
    'ACTION': ZG.TROPHY_PSEUDO,
    'TEXT': 'The text is in some obscure tongue. All that can be made out is\na reference to "sending in a matchbook cover."',
})

# zil: 2dungeon.zil:1102  <OBJECT WANDS>
ZG.world.declare_object('WANDS', 'WANDS', lambda: {
    'LOC': ZG.TROPHY_ROOM,
    'SYNONYM': ('WANDS', 'WAND', 'RACK', 'SET'),
    'ADJECTIVE': ('WORN', 'USED'),
    'DESC': 'set of used wands',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.TROPHY_PSEUDO,
})

# zil: 2dungeon.zil:1110  <OBJECT TROPHY-SWORD>
ZG.world.declare_object('TROPHY_SWORD', 'TROPHY-SWORD', lambda: {
    'LOC': ZG.TROPHY_ROOM,
    'SYNONYM': ('SWORD', 'SWORDS'),
    'ADJECTIVE': ('DULL', 'NICKED'),
    'DESC': 'nicked swords',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.TROPHY_PSEUDO,
})

# zil: 2dungeon.zil:1118  <OBJECT TROPHY-BOTTLES>
ZG.world.declare_object('TROPHY_BOTTLES', 'TROPHY-BOTTLES', lambda: {
    'LOC': ZG.TROPHY_ROOM,
    'SYNONYM': 'BOTTLE',
    'ADJECTIVE': 'SMALL',
    'DESC': 'small bottles',
    'FLAGS': ('NDESCBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.TROPHY_PSEUDO,
})

# zil: 2dungeon.zil:1126  <OBJECT WARNING-LABEL>
ZG.world.declare_object('WARNING_LABEL', 'WARNING-LABEL', lambda: {
    'LOC': ZG.TROPHY_ROOM,
    'SYNONYM': 'LABEL',
    'ADJECTIVE': 'WARNING',
    'DESC': 'warning label',
    'LDESC': 'A hand-lettered label is affixed to the wall.',
    'FLAGS': 'READBIT',
    'TEXT': 'Warning!\n\nThe exhibits in this room are the property of the mighty Wizard of\nFrobozz (me), and are the fruits of diligent labor and study over\nmany years. He who touches anything will regret it.\n\n(signed)\nFrobozz\n',
})

# zil: 2dungeon.zil:1143  <OBJECT GLOBAL-WIZARD-CASE>
ZG.world.declare_object('GLOBAL_WIZARD_CASE', 'GLOBAL-WIZARD-CASE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('CASE', 'CABINET'),
    'ADJECTIVE': ('TROPHY', 'WIZARD'),
    'DESC': "Wizard's trophy cabinet",
    'ACTION': ZG.WIZARD_CASE_FCN,
})

# zil: 2dungeon.zil:1150  <OBJECT WIZARD-CASE>
ZG.world.declare_object('WIZARD_CASE', 'WIZARD-CASE', lambda: {
    'LOC': ZG.TROPHY_ROOM,
    'SYNONYM': ('CASE', 'CABINET'),
    'ADJECTIVE': ('TROPHY', 'WIZARD'),
    'DESC': "Wizard's trophy cabinet",
    'FLAGS': ('CONTBIT', 'TRANSBIT'),
    'LDESC': 'Imbedded in the wall is an ornate trophy cabinet.',
    'ACTION': ZG.WIZARD_CASE_FCN,
    'CAPACITY': 1000,
})

# zil: 2dungeon.zil:1160  <OBJECT BROKEN-CASE>
ZG.world.declare_object('BROKEN_CASE', 'BROKEN-CASE', lambda: {
    'SYNONYM': ('CASE', 'CABINET'),
    'ADJECTIVE': ('BROKEN', 'TROPHY', 'WIZARD'),
    'DESC': 'smashed trophy cabinet',
    'FLAGS': ('CONTBIT', 'OPENBIT'),
    'LDESC': 'Shards of a smashed trophy case litter the room.',
})

# zil: 2dungeon.zil:1167  <ROOM PENTAGRAM-ROOM>
ZG.world.declare_object('PENTAGRAM_ROOM', 'PENTAGRAM-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'In this room, inscribed on the floor, is a great pentagram drawn with\nblack chalk. In its center is a black circle.',
    'DESC': 'Pentagram Room',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'NORTH': ('TO', ZG.WORKBENCH_ROOM),
    'GLOBAL': (ZG.GLOBAL_MENHIR, ZG.GLOBAL_CERBERUS, ZG.GLOBAL_WIZARD_CASE),
})

# zil: 2dungeon.zil:1177  <OBJECT PENTAGRAM>
ZG.world.declare_object('PENTAGRAM', 'PENTAGRAM', lambda: {
    'LOC': ZG.PENTAGRAM_ROOM,
    'SYNONYM': ('PENTAGRAM', 'STAR', 'CIRCLE'),
    'ADJECTIVE': ('GREAT', 'CHALK', 'BLACK'),
    'DESC': 'pentagram',
    'FLAGS': ('NDESCBIT', 'SURFACEBIT', 'CONTBIT', 'OPENBIT'),
    'CAPACITY': 200,
    'ACTION': ZG.PENTAGRAM_FCN,
})

# zil: 2dungeon.zil:1186  <ROOM AQUARIUM-ROOM>
ZG.world.declare_object('AQUARIUM_ROOM', 'AQUARIUM-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'Here a dark hallway turns a corner. To the south is a dark room, to\nthe east is fitful light.',
    'DESC': 'Aquarium Room',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'EAST': ('TO', ZG.WORKBENCH_ROOM),
    'IN': ('TO', ZG.IN_AQUARIUM),
    'SOUTH': ('TO', ZG.WIZARDS_QUARTERS),
})

# zil: 2dungeon.zil:1197  <OBJECT AQUARIUM>
ZG.world.declare_object('AQUARIUM', 'AQUARIUM', lambda: {
    'LOC': ZG.AQUARIUM_ROOM,
    'SYNONYM': ('AQUARIUM', 'GLASS'),
    'ADJECTIVE': 'HUGE',
    'DESC': 'aquarium',
    'LDESC': 'Filling the northern half of the room is a huge aquarium.',
    'FLAGS': ('OPENBIT', 'CONTBIT'),
    'CAPACITY': 200,
    'ACTION': ZG.AQUARIUM_FCN,
})

# zil: 2dungeon.zil:1207  <OBJECT PALANTIR-3>
ZG.world.declare_object('PALANTIR_3', 'PALANTIR-3', lambda: {
    'LOC': ZG.IN_AQUARIUM,
    'SYNONYM': ('PALANTIR', 'SPHERE'),
    'ADJECTIVE': ('CRYSTAL', 'WHITE', 'CLEAR'),
    'DESC': 'clear crystal sphere',
    'LDESC': 'There is a clear crystal sphere lying in the sand.',
    'FLAGS': ('STAGGERED', 'TAKEBIT', 'NDESCBIT', 'TRANSBIT'),
    'ACTION': ZG.PALANTIR,
    'VALUE': 20,
})

# zil: 2dungeon.zil:1217  <OBJECT SERPENT>
ZG.world.declare_object('SERPENT', 'SERPENT', lambda: {
    'LOC': ZG.AQUARIUM,
    'SYNONYM': ('SERPENT', 'SNAKE'),
    'ADJECTIVE': ('BABY', 'SEA'),
    'DESC': 'baby sea serpent',
    'LDESC': 'There is a baby sea serpent swimming in the aquarium.',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.SERPENT_FCN,
})

# zil: 2dungeon.zil:1226  <OBJECT DEAD-SERPENT>
ZG.world.declare_object('DEAD_SERPENT', 'DEAD-SERPENT', lambda: {
    'SYNONYM': ('SERPENT', 'SNAKE'),
    'ADJECTIVE': ('DEAD', 'BABY', 'SEA'),
    'DESC': 'dead sea serpent',
    'LDESC': 'There is a dead sea serpent in a heap here.',
    'FLAGS': 'TAKEBIT',
    'ACTION': ZG.DEAD_SERPENT_FCN,
    'SIZE': 400,
})

# zil: 2dungeon.zil:1235  <ROOM IN-AQUARIUM>
ZG.world.declare_object('IN_AQUARIUM', 'IN-AQUARIUM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'The floor here seems to be made of sand, but it is hard to see anything\nelse.',
    'DESC': 'Murky Room',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'OUT': ('TO', ZG.AQUARIUM_ROOM),
    'ACTION': ZG.IN_AQUARIUM_FCN,
})

# zil: 2dungeon.zil:1245  <ROOM WIZARDS-QUARTERS>
ZG.world.declare_object('WIZARDS_QUARTERS', 'WIZARDS-QUARTERS', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': "Wizard's Quarters",
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.AQUARIUM_ROOM),
    'ACTION': ZG.WIZARD_QUARTERS_FCN,
})

# zil: 2dungeon.zil:1253  <ROOM CAROUSEL-ROOM>
ZG.world.declare_object('CAROUSEL_ROOM', 'CAROUSEL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Carousel Room',
    'FLAGS': 'RLANDBIT',
    'NORTH': ('TO', ZG.MARBLE_HALL),
    'NE': ('TO', ZG.STREAM_PATH),
    'EAST': ('TO', ZG.TOPIARY_ROOM),
    'SE': ('TO', ZG.RIDDLE_ROOM),
    'SOUTH': ('TO', ZG.MENHIR_ROOM),
    'SW': ('TO', ZG.COBWEBBY_CORRIDOR),
    'WEST': ('TO', ZG.ROOM_8),
    'NW': ('TO', ZG.COOL_ROOM),
    'ACTION': ZG.CAROUSEL_ROOM_FCN,
})

# ; "SUBTITLE ROOMS FROM OLD ZORK"

# zil: 2dungeon.zil:1270  <ROOM RIDDLE-ROOM>
ZG.world.declare_object('RIDDLE_ROOM', 'RIDDLE-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Riddle Room',
    'DOWN': ('TO', ZG.CAROUSEL_ROOM),
    'NW': ('TO', ZG.CAROUSEL_ROOM),
    'EAST': ('TO', ZG.PEARL_ROOM, 'IF', 'RIDDLE_DOOR', 'IS', 'OPEN'),
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.RIDDLE_ROOM_FCN,
    'PSEUDO': ('RIDDLE', ZG.RIDDLE_PSEUDO),
})

# zil: 2dungeon.zil:1281  <OBJECT RIDDLE-DOOR>
ZG.world.declare_object('RIDDLE_DOOR', 'RIDDLE-DOOR', lambda: {
    'LOC': ZG.RIDDLE_ROOM,
    'DESC': 'stone door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('GREAT', 'STONE'),
    'FLAGS': ('DOORBIT', 'CONTBIT', 'NDESCBIT'),
    'ACTION': ZG.RIDDLE_DOOR_FCN,
})

# zil: 2dungeon.zil:1289  <ROOM PEARL-ROOM>
ZG.world.declare_object('PEARL_ROOM', 'PEARL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a former broom closet. The exits are to the east and west.',
    'DESC': 'Pearl Room',
    'EAST': ('TO', ZG.WELL_BOTTOM),
    'WEST': ('TO', ZG.RIDDLE_ROOM),
    'FLAGS': 'RLANDBIT',
})

# ;"SUBTITLE VOLCANO AREA"

# zil: 2dungeon.zil:1302  <ROOM VOLCANO-BOTTOM>
ZG.world.declare_object('VOLCANO_BOTTOM', 'VOLCANO-BOTTOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are at the bottom of a large dormant volcano. High above you\nlight enters from the cone of the volcano. The only exit is to the north.',
    'DESC': 'Volcano Bottom',
    'NORTH': ('TO', ZG.LAVA_ROOM),
    'FLAGS': ('RLANDBIT', 'NONLANDBIT'),
})

# zil: 2dungeon.zil:1311  <ROOM VAIR-1>
ZG.world.declare_object('VAIR_1', 'VAIR-1', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are about one hundred feet above the bottom of the volcano. The\ntop of the volcano is clearly visible here.',
    'DESC': 'Volcano Core',
    'FLAGS': ('NONLANDBIT', 'NWALLBIT'),
})

# zil: 2dungeon.zil:1319  <ROOM VAIR-2>
ZG.world.declare_object('VAIR_2', 'VAIR-2', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are about two hundred feet above the volcano floor. Looming\nabove is the rim of the volcano. There is a small ledge on the west\nside.',
    'DESC': 'Volcano Near Small Ledge',
    'WEST': ('TO', ZG.LEDGE_1),
    'LAND': ('TO', ZG.LEDGE_1),
    'FLAGS': ('NONLANDBIT', 'NWALLBIT'),
})

# zil: 2dungeon.zil:1330  <ROOM VAIR-3>
ZG.world.declare_object('VAIR_3', 'VAIR-3', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are high above the floor of the volcano. The rim of the volcano\nlooks very narrow and you are very near it. To the\neast is what appears to be a viewing ledge, too thin to land on.',
    'DESC': 'Volcano by Viewing Ledge',
    'FLAGS': ('NONLANDBIT', 'NWALLBIT'),
})

# zil: 2dungeon.zil:1339  <ROOM VAIR-4>
ZG.world.declare_object('VAIR_4', 'VAIR-4', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are near the rim of the volcano. Above you it is open to the sky.\nTo the west, there is a place to land on a wide ledge.',
    'DESC': 'Volcano Near Wide Ledge',
    'LAND': ('TO', ZG.LEDGE_2),
    'WEST': ('TO', ZG.LEDGE_2),
    'FLAGS': ('NONLANDBIT', 'NWALLBIT'),
})

# zil: 2dungeon.zil:1349  <ROOM LEDGE-1>
ZG.world.declare_object('LEDGE_1', 'LEDGE-1', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are on a narrow ledge within an old dormant volcano. This ledge is\nabout halfway between the floor below and the rim above. There is an exit\nto the south.',
    'DESC': 'Narrow Ledge',
    'DOWN': "I wouldn't jump from here.",
    'WEST': ('TO', ZG.VOLCANO_BOTTOM, 'IF', 'GNOME_DOOR_FLAG'),
    'SOUTH': ('TO', ZG.LIBRARY),
    'FLAGS': ('RLANDBIT', 'NONLANDBIT'),
})

# zil: 2dungeon.zil:1361  <ROOM LIBRARY>
ZG.world.declare_object('LIBRARY', 'LIBRARY', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This must have been a large library, probably for the royal family. All\nof the shelves have been gnawed to pieces by unfriendly gnomes. To the\nnorth is an exit.',
    'DESC': 'Library',
    'NORTH': ('TO', ZG.LEDGE_1),
    'OUT': ('TO', ZG.LEDGE_1),
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1372  <ROOM VOLCANO-VIEW>
ZG.world.declare_object('VOLCANO_VIEW', 'VOLCANO-VIEW', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are on a ledge in the middle of a large volcano. Below you\nthe volcano bottom can be seen and above is the rim of the volcano.\nA couple of ledges can be seen on the other side of the volcano;\nit appears that this ledge is intermediate in elevation between\nthose on the other side. The exit from this room is to the east.',
    'DESC': 'Volcano View',
    'DOWN': "I wouldn't try that.",
    'CROSS': 'It is impossible to cross this distance.',
    'EAST': ('TO', ZG.LAVA_TUBE),
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1386  <ROOM LEDGE-2>
ZG.world.declare_object('LEDGE_2', 'LEDGE-2', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Wide Ledge',
    'DOWN': "It's a long way down.",
    'WEST': ('TO', ZG.VOLCANO_BOTTOM, 'IF', 'GNOME_DOOR_FLAG'),
    'SOUTH': ('TO', ZG.SAFE_ROOM),
    'ACTION': ZG.LEDGE_FCN,
    'FLAGS': ('RLANDBIT', 'NONLANDBIT'),
})

# zil: 2dungeon.zil:1396  <ROOM SAFE-ROOM>
ZG.world.declare_object('SAFE_ROOM', 'SAFE-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Dusty Room',
    'NORTH': ('TO', ZG.LEDGE_2),
    'ACTION': ZG.SAFE_ROOM_FCN,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 2dungeon.zil:1404  <ROOM LAVA-ROOM>
ZG.world.declare_object('LAVA_ROOM', 'LAVA-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a small room, whose walls are formed by an old lava flow.\nThere are exits here to the east and the south.',
    'DESC': 'Lava Room',
    'SOUTH': ('TO', ZG.VOLCANO_BOTTOM),
    'EAST': ('TO', ZG.GLACIER_ROOM),
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1414  <GLOBAL BLOC>
# GLOBAL (state) BLOC = ZG.VOLCANO_BOTTOM  ->  ZilGlobal.py

'SUBTITLE ALICE IN WONDERLAND'

# zil: 2dungeon.zil:1420  <ROOM MAGNET-ROOM>
ZG.world.declare_object('MAGNET_ROOM', 'MAGNET-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Low Room',
    'NORTH': ('PER', ZG.MAGNET_ROOM_EXIT),
    'SOUTH': ('PER', ZG.MAGNET_ROOM_EXIT),
    'WEST': ('PER', ZG.MAGNET_ROOM_EXIT),
    'NE': ('PER', ZG.MAGNET_ROOM_EXIT),
    'NW': ('PER', ZG.MAGNET_ROOM_EXIT),
    'SW': ('PER', ZG.MAGNET_ROOM_EXIT),
    'SE': ('PER', ZG.MAGNET_ROOM_EXIT),
    'EAST': ('PER', ZG.MAGNET_ROOM_EXIT),
    'OUT': ('PER', ZG.MAGNET_ROOM_EXIT),
    'ACTION': ZG.MAGNET_ROOM_FCN,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 2dungeon.zil:1436  <ROOM MACHINE-ROOM>
ZG.world.declare_object('MACHINE_ROOM', 'MACHINE-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a large room full of assorted heavy machinery, whirring noisily.\nThe room smells of burned resistors. Along one wall are three buttons\nwhich are, respectively, round, triangular, and square. Naturally,\nabove these buttons are instructions written in EBCDIC. A large sign\nin English above all the buttons says\n       "DANGER -- HIGH VOLTAGE"\nThere are exits to the west and the south.',
    'DESC': 'Machine Room',
    'WEST': ('TO', ZG.MAGNET_ROOM),
    'SOUTH': ('TO', ZG.CAGE_ROOM),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 2dungeon.zil:1451  <ROOM CAGE-ROOM>
ZG.world.declare_object('CAGE_ROOM', 'CAGE-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': "This is a dingy closet adjacent to a larger room to the north.\nChiselled into a wall are these words:\n\n     Protected by\n       FROBOZZ\n Magic Alarm Company\n  (Hello, footpad!)\n\nThere doesn't seem to be any footpad here, however.",
    'DESC': 'Dingy Closet',
    'OUT': ('TO', ZG.MACHINE_ROOM),
    'NORTH': ('TO', ZG.MACHINE_ROOM),
    'FLAGS': ('ONBIT', 'RLANDBIT'),
})

# zil: 2dungeon.zil:1467  <ROOM IN-CAGE>
ZG.world.declare_object('IN_CAGE', 'IN-CAGE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are trapped inside a solid steel cage.',
    'DESC': 'Cage',
    'ACTION': ZG.IN_CAGE_FCN,
    'FLAGS': ('RLANDBIT', 'NWALLBIT', 'ONBIT'),
})

# zil: 2dungeon.zil:1474  <ROOM WELL-TOP>
ZG.world.declare_object('WELL_TOP', 'WELL-TOP', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'You are at the top of the well. Well done. There are etchings on\nthe side of the well. There is a small crack across the floor at the\nentrance to a room on the east, but it can be crossed easily.',
    'DESC': 'Top of Well',
    'EAST': ('TO', ZG.TEA_ROOM),
    'DOWN': "It's a long way down!",
    'FLAGS': ('RLANDBIT', 'NONLANDBIT'),
    'VALUE': 10,
    'GLOBAL': ZG.WELL,
    'PSEUDO': ('CRACK', ZG.CRACK_PSEUDO),
})

# zil: 2dungeon.zil:1488  <ROUTINE CRACK-PSEUDO ()>
@ZG.routine('CRACK-PSEUDO')
def CRACK_PSEUDO():
    if VERB_p('EXAMINE'):
        return TELL('It is a small crack (as advertised) with no redeeming value.', CR)
    else:
        return False

# zil: 2dungeon.zil:1493  <ROOM WELL-BOTTOM>
ZG.world.declare_object('WELL_BOTTOM', 'WELL-BOTTOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a damp circular room, whose walls are made of brick and\nmortar. The roof of this room is not visible, but there appear to be\nsome etchings on the walls. There is a passageway to the west.',
    'DESC': 'Circular Room',
    'WEST': ('TO', ZG.PEARL_ROOM),
    'UP': 'The walls cannot be climbed.',
    'FLAGS': ('RLANDBIT', 'NONLANDBIT'),
    'GLOBAL': ZG.WELL,
})

# zil: 2dungeon.zil:1505  <ROOM TEA-ROOM>
ZG.world.declare_object('TEA_ROOM', 'TEA-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a small room containing a large oblong table, no doubt set\nfor afternoon tea. It is clear from the\nobjects on the table that the users were indeed mad. In the eastern\ncorner of the room is a small hole (no more than four inches high).\nThere are passageways leading away to the west and the northwest.',
    'DESC': 'Tea Room',
    'EAST': 'Only a mouse could get in there.',
    'WEST': ('TO', ZG.WELL_TOP),
    'NW': ('TO', ZG.MAGNET_ROOM),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'PSEUDO': ('HOLE', ZG.ALICE_HOLE),
})

# zil: 2dungeon.zil:1520  <ROUTINE ALICE-HOLE ()>
@ZG.routine('ALICE-HOLE')
def ALICE_HOLE():
    if VERB_p('EXAMINE'):
        return TELL('The hole is very small. You could never enter it.', CR)
    elif VERB_p('LOOK-INSIDE'):
        return TELL("You can't see what's beyond the hole from here.", CR)
    elif (VERB_p('PUT') and (ZG.PRSI == ZG.PSEUDO_OBJECT)):
        return TELL("It doesn't fit through the hole.", CR)
    else:
        return False

# zil: 2dungeon.zil:1528  <ROOM POSTS-ROOM>
ZG.world.declare_object('POSTS_ROOM', 'POSTS-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is an enormous room, in the center of which are four wooden\nposts delineating a rectangular area, above which is what appears to\nbe a wooden roof. In fact, all objects in this room appear to be\nabnormally large. To the east is a passageway. There are large gaping\nchasms to the west and northwest.',
    'DESC': 'Posts Room',
    'NW': 'A great chasm blocks your way.',
    'EAST': ('TO', ZG.POOL_ROOM),
    'WEST': 'A great chasm blocks your way.',
    'DOWN': 'A great chasm blocks your way.',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.POSTS_ROOM_FCN,
    'GLOBAL': ZG.CHASM,
})

# zil: 2dungeon.zil:1545  <ROOM POOL-ROOM>
ZG.world.declare_object('POOL_ROOM', 'POOL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a large room, one half of which is depressed. Salty water flows\nfrom a large leak in the ceiling. The only exit is to the west.',
    'DESC': 'Pool Room',
    'OUT': ('TO', ZG.POSTS_ROOM),
    'WEST': ('TO', ZG.POSTS_ROOM),
    'FLAGS': 'RLANDBIT',
})

# ; "SUBTITLE BANK OF ZORK"

# zil: 2dungeon.zil:1559  <ROOM BANK-ENTRANCE>
ZG.world.declare_object('BANK_ENTRANCE', 'BANK-ENTRANCE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the entrance hall of the Bank of Zork, the largest\nbanking institution of the Great Underground Empire. A partial\naccount of its history is in "The Lives of the Twelve Flatheads," in\nthe chapter on J. Pierpont Flathead. A more detailed history (albeit\nless objective) may be found in Flathead\'s outrageous autobiography\n"I\'m Rich and You Aren\'t - So There!".\nMost of the furniture has been ravaged by passing scavengers. All\nthat remains are two signs at the northwest and northeast corners of\nthe room, which say:\n\n    <--  VIEWING ROOMS  -->\n\nThe way out (ornate but tasteful) is to the east.\n',
    'DESC': 'Bank Entrance',
    'NW': ('TO', ZG.TELLER_WEST),
    'NE': ('TO', ZG.TELLER_EAST),
    'EAST': ('TO', ZG.FRESCO_ROOM),
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1582  <ROOM TELLER-WEST>
ZG.world.declare_object('TELLER_WEST', 'TELLER-WEST', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': "West Teller's Room",
    'NORTH': ('TO', ZG.VIEWING_WEST),
    'SOUTH': ('TO', ZG.BANK_ENTRANCE),
    'WEST': ('TO', ZG.DEPOSITORY),
    'ACTION': ZG.TELLER_ROOM,
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1592  <ROOM TELLER-EAST>
ZG.world.declare_object('TELLER_EAST', 'TELLER-EAST', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': "East Teller's Room",
    'NORTH': ('TO', ZG.VIEWING_EAST),
    'SOUTH': ('TO', ZG.BANK_ENTRANCE),
    'EAST': ('TO', ZG.DEPOSITORY),
    'ACTION': ZG.TELLER_ROOM,
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1602  <ROOM VIEWING-WEST>
ZG.world.declare_object('VIEWING_WEST', 'VIEWING-WEST', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This room was used by holders of safety deposit boxes to view\ntheir contents. On the north side of the room is a sign which says:\n\n"Remain here while the teller retrieves your safety deposit box.\nWhen you are finished, leave the box, and exit to the south.\nSafety deposit boxes cannot be removed from this room!\n\nThank You for Banking at the Zork!"\n',
    'DESC': 'West Viewing Room',
    'SOUTH': ('TO', ZG.BANK_ENTRANCE),
    'FLAGS': 'RLANDBIT',
    'GLOBAL': (ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL),
})

# zil: 2dungeon.zil:1619  <ROOM VIEWING-EAST>
ZG.world.declare_object('VIEWING_EAST', 'VIEWING-EAST', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This room was used by holders of safety deposit boxes to view\ntheir contents. On the north side of the room is a sign which says\n\n"Remain here while the teller retrieves your safety deposit box.\nWhen you are finished, leave the box, and exit to the south.\nSafety deposit boxes cannot be removed from this room!\n\nThank You for Banking at the Zork!"\n',
    'DESC': 'East Viewing Room',
    'SOUTH': ('TO', ZG.BANK_ENTRANCE),
    'FLAGS': 'RLANDBIT',
    'GLOBAL': (ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL),
})

# zil: 2dungeon.zil:1636  <ROOM SMALL-ROOM>
ZG.world.declare_object('SMALL_ROOM', 'SMALL-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a small, bare room with no distinguishing features. There\nare no exits from this room.',
    'DESC': 'Small Room',
    'FLAGS': 'RLANDBIT',
    'GLOBAL': (ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL),
})

# zil: 2dungeon.zil:1645  <ROOM VAULT>
ZG.world.declare_object('VAULT', 'VAULT', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is the Vault of the Bank of Zork, in which there are no doors.',
    'DESC': 'Vault',
    'FLAGS': 'RLANDBIT',
    'GLOBAL': (ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL),
})

# zil: 2dungeon.zil:1653  <ROOM DEPOSITORY>
ZG.world.declare_object('DEPOSITORY', 'DEPOSITORY', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This is a large rectangular room. The east and west walls were used\nfor storing safety deposit boxes, but all have been carefully removed\nby evil persons. To the east, west, and south of the room are large\ndoorways. The northern "wall" of the room is a shimmering curtain of\nlight. In the center of the room is a large stone cube, about 10 feet\non a side. Engraved on the side of the cube is some lettering.',
    'DESC': 'Safety Depository',
    'NORTH': 'There is a curtain of light there.',
    'WEST': ('PER', ZG.BKLEAVEW),
    'EAST': ('PER', ZG.BKLEAVEE),
    'SOUTH': ('TO', ZG.OFFICE),
    'ACTION': ZG.DEPOSITORY_FCN,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': ZG.SNWL,
})

# zil: 2dungeon.zil:1671  <ROOM OFFICE>
ZG.world.declare_object('OFFICE', 'OFFICE', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': 'This room was the office of the Chairman of the Bank of Zork.\nLike the other rooms here, it has been extensively vandalized.\nThe lone exit is to the north.',
    'DESC': "Chairman's Office",
    'NORTH': ('TO', ZG.DEPOSITORY),
    'FLAGS': 'RLANDBIT',
})

# zil: 2dungeon.zil:1681  <OBJECT MATCH>
ZG.world.declare_object('MATCH', 'MATCH', lambda: {
    'LOC': ZG.GAZEBO_TABLE,
    'SYNONYM': ('MATCH', 'MATCHES', 'MATCHBOOK'),
    'ADJECTIVE': 'ZORK',
    'DESC': 'matchbook',
    'FLAGS': ('READBIT', 'TAKEBIT'),
    'ACTION': ZG.MATCH_FCN,
    'LDESC': 'There is a matchbook saying "Visit ZORK I" here.',
    'TEXT': '">> Visit Exotic ZORK I <<\n\nConsult the Frobozz Magic Travel Agency, or visit your local\ncomputer store for more details."',
    'SIZE': 2,
})

'SUBTITLE PALANTIR ROOMS'

# zil: 2dungeon.zil:1702  <ROOM DREARY-ROOM>
ZG.world.declare_object('DREARY_ROOM', 'DREARY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Dreary Room',
    'SOUTH': ('TO', ZG.TINY_ROOM, 'IF', 'PDOOR', 'IS', 'OPEN'),
    'OUT': ('TO', ZG.TINY_ROOM, 'IF', 'PDOOR', 'IS', 'OPEN'),
    'ACTION': ZG.DREARY_ROOM_FCN,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.PDOOR, ZG.PWINDOW),
})

# zil: 2dungeon.zil:1712  <ROOM TINY-ROOM>
ZG.world.declare_object('TINY_ROOM', 'TINY-ROOM', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Tiny Room',
    'NORTH': ('TO', ZG.DREARY_ROOM, 'IF', 'PDOOR', 'IS', 'OPEN'),
    'IN': ('TO', ZG.DREARY_ROOM, 'IF', 'PDOOR', 'IS', 'OPEN'),
    'DOWN': ('TO', ZG.RAVINE_LEDGE),
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.TINY_ROOM_FCN,
    'GLOBAL': (ZG.PDOOR, ZG.PWINDOW, ZG.CHASM),
})

# ; "SUBTITLE OBJECTS"

# zil: 2dungeon.zil:1727  <OBJECT GNOME>
ZG.world.declare_object('GNOME', 'GNOME', lambda: {
    'SYNONYM': 'GNOME',
    'ADJECTIVE': 'VOLCANO',
    'DESC': 'Volcano Gnome',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.GNOME_FCN,
    'LDESC': 'There is a nervous Volcano Gnome here.',
})

# zil: 2dungeon.zil:1735  <OBJECT BALLOON>
ZG.world.declare_object('BALLOON', 'BALLOON', lambda: {
    'LOC': ZG.VOLCANO_BOTTOM,
    'SYNONYM': ('BALLOON', 'BASKET'),
    'ADJECTIVE': 'WICKER',
    'DESC': 'basket',
    'FLAGS': ('VEHBIT', 'OPENBIT'),
    'ACTION': ZG.BALLOON_FCN,
    'DESCFCN': ZG.BALLOON_FCN,
    'CAPACITY': 100,
    'SIZE': 70,
    'VTYPE': 0,
})

# zil: 2dungeon.zil:1747  <OBJECT BALLOON-LABEL>
ZG.world.declare_object('BALLOON_LABEL', 'BALLOON-LABEL', lambda: {
    'SYNONYM': 'LABEL',
    'ADJECTIVE': 'BLUE',
    'DESC': 'blue label',
    'FLAGS': ('READBIT', 'TAKEBIT', 'BURNBIT'),
    'LDESC': 'There is a blue label here.',
    'SIZE': 1,
    'TEXT': "\n!! FROBOZZ MAGIC BALLOON COMPANY !!\n\nHello, Aviator!\n\nTo land your balloon, say LAND\nOtherwise, you're on your own!\n\nNo warranty expressed or implied.",
})

# zil: 2dungeon.zil:1765  <OBJECT SAFE>
ZG.world.declare_object('SAFE', 'SAFE', lambda: {
    'LOC': ZG.SAFE_ROOM,
    'SYNONYM': ('SAFE', 'BOX'),
    'ADJECTIVE': ('STEEL', 'RUSTY'),
    'DESC': 'box',
    'FLAGS': ('CONTBIT', 'NDESCBIT'),
    'ACTION': ZG.SAFE_FCN,
    'CAPACITY': 15,
})

# zil: 2dungeon.zil:1774  <OBJECT BRAIDED-WIRE>
ZG.world.declare_object('BRAIDED_WIRE', 'BRAIDED-WIRE', lambda: {
    'FLAGS': 'NDESCBIT',
    'LOC': ZG.BALLOON,
    'SYNONYM': ('ROPE', 'WIRE'),
    'ADJECTIVE': 'BRAIDED',
    'DESC': 'braided wire',
    'ACTION': ZG.WIRE_FCN,
})

# zil: 2dungeon.zil:1782  <OBJECT BRICK>
ZG.world.declare_object('BRICK', 'BRICK', lambda: {
    'LOC': ZG.MARBLE_HALL,
    'SYNONYM': 'BRICK',
    'ADJECTIVE': ('SQUARE', 'CLAY'),
    'DESC': 'brick',
    'FLAGS': ('TAKEBIT', 'BURNBIT', 'OPENBIT', 'SEARCHBIT'),
    'ACTION': ZG.BRICK_FCN,
    'LDESC': 'There is a square brick here which feels like clay.',
    'CAPACITY': 2,
    'SIZE': 9,
})

# zil: 2dungeon.zil:1793  <OBJECT EXPLOSION>
ZG.world.declare_object('EXPLOSION', 'EXPLOSION', lambda: {
    'SYNONYM': 'KREBF',
    'DESC': 'debris from an explosion',
    'LDESC': 'The room is cluttered with debris from an explosion. The walls seem ready\nto collapse.',
    'FLAGS': True,
})

# zil: 2dungeon.zil:1801  <OBJECT DEAD-BALLOON>
ZG.world.declare_object('DEAD_BALLOON', 'DEAD-BALLOON', lambda: {
    'SYNONYM': ('BALLOON', 'BASKET'),
    'ADJECTIVE': 'BROKEN',
    'DESC': 'broken balloon',
    'LDESC': 'There is a balloon here, broken into pieces.',
    'SIZE': 40,
})

# zil: 2dungeon.zil:1808  <OBJECT ROUND-BUTTON>
ZG.world.declare_object('ROUND_BUTTON', 'ROUND-BUTTON', lambda: {
    'LOC': ZG.MACHINE_ROOM,
    'SYNONYM': 'BUTTON',
    'ADJECTIVE': 'ROUND',
    'DESC': 'round button',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.BUTTONS,
})

# zil: 2dungeon.zil:1816  <OBJECT SQUARE-BUTTON>
ZG.world.declare_object('SQUARE_BUTTON', 'SQUARE-BUTTON', lambda: {
    'LOC': ZG.MACHINE_ROOM,
    'SYNONYM': 'BUTTON',
    'ADJECTIVE': 'SQUARE',
    'DESC': 'square button',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.BUTTONS,
})

# zil: 2dungeon.zil:1824  <OBJECT TRIANGULAR-BUTTON>
ZG.world.declare_object('TRIANGULAR_BUTTON', 'TRIANGULAR-BUTTON', lambda: {
    'LOC': ZG.MACHINE_ROOM,
    'SYNONYM': 'BUTTON',
    'ADJECTIVE': 'TRIANGULAR',
    'DESC': 'triangular button',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.BUTTONS,
})

# zil: 2dungeon.zil:1832  <OBJECT CARD>
ZG.world.declare_object('CARD', 'CARD', lambda: {
    'LOC': ZG.SAFE,
    'SYNONYM': ('CARD', 'NOTE'),
    'DESC': 'card',
    'FLAGS': ('READBIT', 'TAKEBIT', 'BURNBIT'),
    'LDESC': 'There is a card with writing on it here.',
    'SIZE': 1,
    'TEXT': '\nWarning:\n    This room was constructed over very weak rock strata. Detonation\nof explosives in this room is strictly prohibited!\n         Frobozz Magic Cave Company\n         per M. Agrippa, foreman\n',
})

# zil: 2dungeon.zil:1848  <OBJECT CLOTH-BAG>
ZG.world.declare_object('CLOTH_BAG', 'CLOTH-BAG', lambda: {
    'LOC': ZG.BALLOON,
    'SYNONYM': 'BAG',
    'ADJECTIVE': 'CLOTH',
    'FLAGS': 'NDESCBIT',
    'DESC': 'cloth bag',
    'ACTION': ZG.BCONTENTS,
})

# zil: 2dungeon.zil:1856  <OBJECT CROWN>
ZG.world.declare_object('CROWN', 'CROWN', lambda: {
    'LOC': ZG.SAFE,
    'SYNONYM': ('CROWN', 'TREASURE'),
    'ADJECTIVE': 'GAUDY',
    'DESC': 'gaudy crown',
    'FLAGS': ('STAGGERED', 'TAKEBIT', 'WEARBIT'),
    'FDESC': 'The excessively gaudy crown of Lord Dimwit Flathead sits in the safe.',
    'LDESC': "Lord Dimwit's crown is here.",
    'SIZE': 10,
    'VALUE': 20,
})

# zil: 2dungeon.zil:1868  <OBJECT PALANTIR-1>
ZG.world.declare_object('PALANTIR_1', 'PALANTIR-1', lambda: {
    'LOC': ZG.CAGE_ROOM,
    'SYNONYM': ('SPHERE', 'BALL', 'PALANTIR'),
    'ADJECTIVE': ('CRYSTAL', 'RED'),
    'DESC': 'red crystal sphere',
    'FLAGS': ('STAGGERED', 'TAKEBIT', 'TRANSBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.SPHERE_FCN,
    'LDESC': 'There is a beautiful red crystal sphere here.',
    'SIZE': 10,
    'VALUE': 20,
})

# zil: 2dungeon.zil:1879  <OBJECT VIOLIN>
ZG.world.declare_object('VIOLIN', 'VIOLIN', lambda: {
    'LOC': ZG.IRON_BOX,
    'SYNONYM': ('STRADIVARIUS', 'VIOLIN', 'TREASURE'),
    'ADJECTIVE': 'FANCY',
    'DESC': 'fancy violin',
    'FLAGS': ('STAGGERED', 'TAKEBIT'),
    'LDESC': 'There is a Stradivarius here.',
    'SIZE': 10,
    'VALUE': 20,
    'ACTION': ZG.VIOLIN_FCN,
})

# zil: 2dungeon.zil:1890  <OBJECT ICE>
ZG.world.declare_object('ICE', 'ICE', lambda: {
    'LOC': ZG.GLACIER_ROOM,
    'SYNONYM': ('ICE', 'MASS', 'GLACIER'),
    'ADJECTIVE': ('COLD', 'ICY'),
    'DESC': 'glacier',
    'ACTION': ZG.GLACIER_FCN,
    'LDESC': 'A mass of ice fills the western half of the room.',
})

# zil: 2dungeon.zil:1898  <OBJECT FLASK>
ZG.world.declare_object('FLASK', 'FLASK', lambda: {
    'LOC': ZG.POOL_ROOM,
    'SYNONYM': 'FLASK',
    'ADJECTIVE': 'GLASS',
    'DESC': 'stoppered glass flask filled with liquid',
    'FLAGS': ('TAKEBIT', 'TRANSBIT', 'READBIT'),
    'ACTION': ZG.FLASK_FCN,
    'LDESC': 'A stoppered glass flask with a skull-and-crossbones marking is here.\nThe flask is filled with some clear liquid.',
    'CAPACITY': 5,
    'TEXT': 'There is a skull-and-crossbones engraved on the glass.',
    'SIZE': 10,
})

# zil: 2dungeon.zil:1912  <OBJECT ROBOT-LABEL>
ZG.world.declare_object('ROBOT_LABEL', 'ROBOT-LABEL', lambda: {
    'LOC': ZG.MAGNET_ROOM,
    'SYNONYM': ('PAPER', 'PIECE', 'INSTRUCTIONS'),
    'ADJECTIVE': 'GREEN',
    'DESC': 'green piece of paper',
    'FLAGS': ('READBIT', 'TAKEBIT', 'BURNBIT'),
    'LDESC': 'There is a green piece of paper here.',
    'SIZE': 3,
    'TEXT': '!!  FROBOZZ MAGIC ROBOT COMPANY  !!\n\n\nHello, Master!\n\n   I am a late-model robot, trained at GUE Tech to perform various\nsimple household functions.\n\n   To activate me, say the following:\n\n        >ROBOT, <things to do>\n\nAt your service!',
})

# zil: 2dungeon.zil:1934  <OBJECT SLOT>
ZG.world.declare_object('SLOT', 'SLOT', lambda: {
    'LOC': ZG.SAFE_ROOM,
    'SYNONYM': ('SLOT', 'HOLE'),
    'DESC': 'hole',
    'FLAGS': ('OPENBIT', 'NDESCBIT'),
    'CAPACITY': 10,
    'ACTION': ZG.SLOT_F,
})

# zil: 2dungeon.zil:1942  <ROUTINE SLOT-F ()>
@ZG.routine('SLOT-F')
def SLOT_F():
    if (VERB_p('LOOK-INSIDE') and (not FIRST_p(ZG.SLOT))):
        return TELL("There's nothing in the hole.", CR)
    elif VERB_p('EXAMINE'):
        return TELL('The oblong hole has been chipped out of the box, probably by someone\nwanting whatever is inside the box. The attempt was a pathetic failure,\nhowever.', CR)
    else:
        return False

# zil: 2dungeon.zil:1951  <OBJECT HOOK-2>
ZG.world.declare_object('HOOK_2', 'HOOK-2', lambda: {
    'LOC': ZG.LEDGE_2,
    'SYNONYM': 'HOOK',
    'ADJECTIVE': 'SMALL',
    'DESC': 'hook',
    'LDESC': 'There is a small hook attached to the rock here.',
})

# zil: 2dungeon.zil:1958  <OBJECT HOOK-1>
ZG.world.declare_object('HOOK_1', 'HOOK-1', lambda: {
    'LOC': ZG.LEDGE_1,
    'SYNONYM': 'HOOK',
    'ADJECTIVE': 'SMALL',
    'DESC': 'hook',
    'LDESC': 'There is a small hook attached to the rock here.',
})

# zil: 2dungeon.zil:1965  <OBJECT LAMP>
ZG.world.declare_object('LAMP', 'LAMP', lambda: {
    'LOC': ZG.INSIDE_BARROW,
    'SYNONYM': ('LAMP', 'LANTERN', 'LIGHT'),
    'ADJECTIVE': 'BRASS',
    'DESC': 'lamp',
    'FLAGS': ('TAKEBIT', 'LIGHTBIT'),
    'FDESC': 'A strangely familiar brass lantern is lying on the ground.',
    'ACTION': ZG.LANTERN,
    'SIZE': 15,
})

# zil: 2dungeon.zil:1975  <OBJECT BROKEN-LAMP>
ZG.world.declare_object('BROKEN_LAMP', 'BROKEN-LAMP', lambda: {
    'SYNONYM': ('LAMP', 'LANTERN', 'LIGHT'),
    'ADJECTIVE': ('BROKEN', 'BRASS'),
    'DESC': 'broken brass lantern',
    'FLAGS': 'TAKEBIT',
    'SIZE': 15,
})

# zil: 2dungeon.zil:1982  <OBJECT ALICE-TABLE>
ZG.world.declare_object('ALICE_TABLE', 'ALICE-TABLE', lambda: {
    'LOC': ZG.TEA_ROOM,
    'SYNONYM': 'TABLE',
    'ADJECTIVE': ('LARGE', 'OBLONG'),
    'FLAGS': ('CONTBIT', 'SURFACEBIT', 'OPENBIT'),
    'DESC': 'large oblong table',
    'CAPACITY': 50,
})

# zil: 2dungeon.zil:1990  <OBJECT MANGLED-CAGE>
ZG.world.declare_object('MANGLED_CAGE', 'MANGLED-CAGE', lambda: {
    'SYNONYM': 'CAGE',
    'ADJECTIVE': ('MANGLED', 'STEEL'),
    'DESC': 'mangled cage',
    'FLAGS': 'TAKEBIT',
    'LDESC': 'There is a mangled steel cage here.',
    'SIZE': 60,
})

# zil: 2dungeon.zil:1998  <OBJECT PEARL>
ZG.world.declare_object('PEARL', 'PEARL', lambda: {
    'LOC': ZG.PEARL_ROOM,
    'SYNONYM': ('NECKLACE', 'PEARLS', 'TREASURE'),
    'ADJECTIVE': 'PEARL',
    'DESC': 'pearl necklace',
    'FLAGS': ('STAGGERED', 'TAKEBIT'),
    'LDESC': 'There is a pearl necklace here with hundreds of large pearls.',
    'SIZE': 10,
    'VALUE': 15,
})

# zil: 2dungeon.zil:2008  <OBJECT EAT-ME-CAKE>
ZG.world.declare_object('EAT_ME_CAKE', 'EAT-ME-CAKE', lambda: {
    'LOC': ZG.ALICE_TABLE,
    'SYNONYM': ('CAKE', 'ICING', 'CAKES', 'LETTER'),
    'ADJECTIVE': ('GREEN', 'FROSTED'),
    'DESC': 'cake frosted with green letters',
    'FLAGS': ('READBIT', 'TAKEBIT', 'FOODBIT'),
    'ACTION': ZG.EATME_FCN,
    'TEXT': 'The icing spells out "Eat Me."',
    'SIZE': 4,
})

# zil: 2dungeon.zil:2018  <OBJECT BLUE-ICING>
ZG.world.declare_object('BLUE_ICING', 'BLUE-ICING', lambda: {
    'LOC': ZG.ALICE_TABLE,
    'SYNONYM': ('CAKE', 'ICING', 'CAKES', 'LETTER'),
    'ADJECTIVE': ('BLUE', 'FROSTED'),
    'DESC': 'cake frosted with blue letters',
    'FLAGS': ('READBIT', 'TAKEBIT', 'FOODBIT'),
    'ACTION': ZG.CAKE_FCN,
    'SIZE': 4,
})

# zil: 2dungeon.zil:2027  <OBJECT ORANGE-ICING>
ZG.world.declare_object('ORANGE_ICING', 'ORANGE-ICING', lambda: {
    'LOC': ZG.ALICE_TABLE,
    'SYNONYM': ('CAKE', 'CAKES', 'ICING', 'LETTER'),
    'ADJECTIVE': ('ORANGE', 'FROSTED'),
    'DESC': 'cake frosted with orange letters',
    'FLAGS': ('READBIT', 'TAKEBIT', 'FOODBIT'),
    'ACTION': ZG.CAKE_FCN,
    'SIZE': 4,
})

# zil: 2dungeon.zil:2036  <OBJECT RED-ICING>
ZG.world.declare_object('RED_ICING', 'RED-ICING', lambda: {
    'LOC': ZG.ALICE_TABLE,
    'SYNONYM': ('CAKE', 'CAKES', 'ICING', 'LETTER'),
    'ADJECTIVE': ('RED', 'FROSTED'),
    'DESC': 'cake frosted with red letters',
    'FLAGS': ('READBIT', 'TAKEBIT', 'FOODBIT'),
    'ACTION': ZG.CAKE_FCN,
    'SIZE': 4,
})

# zil: 2dungeon.zil:2045  <OBJECT LEAK>
ZG.world.declare_object('LEAK', 'LEAK', lambda: {
    'LOC': ZG.POOL_ROOM,
    'SYNONYM': 'LEAK',
    'ADJECTIVE': 'LARGE',
    'DESC': 'leak',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.PLEAK,
})

# zil: 2dungeon.zil:2053  <OBJECT POOL>
ZG.world.declare_object('POOL', 'POOL', lambda: {
    'LOC': ZG.POOL_ROOM,
    'SYNONYM': ('POOL', 'TEARS'),
    'ADJECTIVE': 'LARGE',
    'DESC': 'pool of tears',
    'LDESC': 'The leak has submerged the depressed area in a pool of tears. There is\na hazy something at the deepest part of the pool.',
    'ACTION': ZG.POOL_FCN,
})

# zil: 2dungeon.zil:2063  <OBJECT COIN>
ZG.world.declare_object('COIN', 'COIN', lambda: {
    'LOC': ZG.LEDGE_1,
    'SYNONYM': ('COIN', 'ZORKMID', 'GOLD', 'TREASURE'),
    'ADJECTIVE': ('GOLD', 'PRICELESS'),
    'DESC': 'priceless zorkmid',
    'FLAGS': ('STAGGERED', 'READBIT', 'TAKEBIT'),
    'FDESC': "On the floor is a priceless gold zorkmid (a valuable collector's item).",
    'LDESC': 'There is an engraved zorkmid here.',
    'SIZE': 10,
    'VALUE': 20,
    'TEXT': 'This is a beautiful octagonal coin bearing the legends "Ten Thousand\nZorkmids" and "In Frobs We Trust".',
})

# ;"      -------------------------|
#       /      Gold Zorkmid        \\|
#      /  T e n   T h o u s a n d   \\|
#     /        Z O R K M I D S       \\|
#    /                                \\|
#   /        !!!!!!!!!!!!!!!!!!        \\|
#  /        !!!!!          !!!!!        \\|
# !           !!!  ^^  ^^  !!!           !|
# !           !!!  OO  OO  !!!           !|
# ! In Frobs  !!!    <<    !!!  We Trust !|
# !            !! (______) !!            !|
# !             !          !             !|
# !             !__________!             !|
#  \\                                    /|
#   \\     -- Lord Dimwit Flathead --   /|
#    \\     -- Beloved of Zorkers --   /|
#     \\                              /|
#      \\       * 722 G.U.E. *       /|
#       \\                          /|
#        --------------------------|
# "

# zil: 2dungeon.zil:2100  <OBJECT STAMP>
ZG.world.declare_object('STAMP', 'STAMP', lambda: {
    'LOC': ZG.PURPLE_BOOK,
    'SYNONYM': ('STAMP', 'TREASURE'),
    'ADJECTIVE': 'FLATHEAD',
    'DESC': 'Flathead stamp',
    'FLAGS': ('STAGGERED', 'READBIT', 'TAKEBIT', 'BURNBIT'),
    'LDESC': 'There is a Flathead stamp here.',
    'SIZE': 1,
    'VALUE': 10,
    'TEXT': 'This three zorkmid stamp bears a portrait of Lord\nDimwit Flathead, "Our Excessive Leader".',
})

# ;"|
# ---v----v----v----v----v---|
# !   !!!!!!!!!!     LORD   !|
# > !!!!!       !   DIMWIT  <|
# !  !!!!    ---!  FLATHEAD !|
# !  !!!C    CC \\           !|
# >   !!        _\\          <|
# !    !!! (____!           !|
# !     !!      !    Our    !|
# >      !______! Excessive <|
# !        /   \\   Leader   !|
# !                         !|
# >    G.U.E.       Three   <|
# !   POSTAGE      Zorkmids !|
# ---^----^----^----^----^---|
# "

# zil: 2dungeon.zil:2129  <OBJECT GREEN-BOOK>
ZG.world.declare_object('GREEN_BOOK', 'GREEN-BOOK', lambda: {
    'LOC': ZG.LIBRARY,
    'SYNONYM': ('BOOK', 'COVER', 'BOOKS'),
    'ADJECTIVE': ('HANDSOME', 'GREEN', 'LEATHER'),
    'DESC': 'green book',
    'FLAGS': ('READBIT', 'TAKEBIT', 'CONTBIT', 'BURNBIT'),
    'FDESC': 'A handsome book, bound in green leather, sits in the center of the room.',
    'CAPACITY': 2,
    'SIZE': 10,
    'TEXT': 'This book is written in a tongue with which I am unfamiliar.',
    'ACTION': ZG.RANDOM_BOOK,
})

# zil: 2dungeon.zil:2142  <OBJECT BLUE-BOOK>
ZG.world.declare_object('BLUE_BOOK', 'BLUE-BOOK', lambda: {
    'LOC': ZG.LIBRARY,
    'SYNONYM': ('BOOK', 'COVER', 'BOOKS'),
    'ADJECTIVE': 'BLUE',
    'DESC': 'blue book',
    'FLAGS': ('READBIT', 'TAKEBIT', 'CONTBIT', 'BURNBIT'),
    'FDESC': 'Worn and battered in one corner of the room is a blue book.',
    'CAPACITY': 2,
    'SIZE': 10,
    'TEXT': 'This book is written in a tongue with which I am unfamiliar.',
    'ACTION': ZG.RANDOM_BOOK,
})

# zil: 2dungeon.zil:2154  <OBJECT WHITE-BOOK>
ZG.world.declare_object('WHITE_BOOK', 'WHITE-BOOK', lambda: {
    'LOC': ZG.LIBRARY,
    'SYNONYM': ('BOOK', 'COVER', 'BOOKS'),
    'ADJECTIVE': ('WHITE', 'GLOSSY'),
    'DESC': 'white book',
    'FLAGS': ('READBIT', 'TAKEBIT', 'CONTBIT', 'BURNBIT'),
    'FDESC': 'Right beside the purple book sits a white one.',
    'CAPACITY': 2,
    'SIZE': 5,
    'TEXT': 'It is written in an unfamiliar tongue and details the use of various\nmagical objects, chiefly the so-called "magic wand". Apparently these\ndevices work by pointing them at the object to be ensorcelled, and then\nchanting the appropriate magic words. (It\'s truly amazing how credulous\nthese ancients were, isn\'t it?)',
    'ACTION': ZG.RANDOM_BOOK,
})

# zil: 2dungeon.zil:2172  <OBJECT PURPLE-BOOK>
ZG.world.declare_object('PURPLE_BOOK', 'PURPLE-BOOK', lambda: {
    'LOC': ZG.LIBRARY,
    'SYNONYM': ('BOOK', 'BOOKS'),
    'ADJECTIVE': 'PURPLE',
    'DESC': 'purple book',
    'FLAGS': ('READBIT', 'TAKEBIT', 'CONTBIT', 'SEARCHBIT', 'BURNBIT'),
    'LDESC': 'Lying in the dust, and covered with mold, is a purple book.',
    'CAPACITY': 2,
    'SIZE': 10,
    'ACTION': ZG.PURPLE_BOOK_FCN,
    'TEXT': 'This book is written in a tongue with which I am unfamiliar. Assuming that\none can indeed tell a book by its cover, it is likely filled with purple prose,\nthe like of which is rarely seen outside the Great Underground Empire.',
})

# zil: 2dungeon.zil:2188  <OBJECT RECEPTACLE>
ZG.world.declare_object('RECEPTACLE', 'RECEPTACLE', lambda: {
    'LOC': ZG.BALLOON,
    'SYNONYM': 'RECEPTACLE',
    'ADJECTIVE': 'METAL',
    'DESC': 'receptacle',
    'FLAGS': ('CONTBIT', 'SEARCHBIT', 'NDESCBIT'),
    'ACTION': ZG.BCONTENTS,
    'CAPACITY': 6,
})

# zil: 2dungeon.zil:2197  <OBJECT ROBOT>
ZG.world.declare_object('ROBOT', 'ROBOT', lambda: {
    'LOC': ZG.MAGNET_ROOM,
    'SYNONYM': ('ROBOT', 'R2D2', 'C3PO', 'ROBBY'),
    'DESC': 'robot',
    'FLAGS': ('ACTORBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.ROBOT_FCN,
    'LDESC': 'There is a robot here.',
})

# zil: 2dungeon.zil:2205  <OBJECT RUBY>
ZG.world.declare_object('RUBY', 'RUBY', lambda: {
    'LOC': ZG.LAVA_ROOM,
    'SYNONYM': ('RUBY', 'TREASURE'),
    'ADJECTIVE': 'MOBY',
    'DESC': 'ruby',
    'FLAGS': ('STAGGERED', 'TAKEBIT'),
    'FDESC': 'On the floor lies a moby ruby.',
    'LDESC': 'There is a moby ruby lying here.',
    'VALUE': 15,
})

# zil: 2dungeon.zil:2215  <OBJECT IRON-BOX>
ZG.world.declare_object('IRON_BOX', 'IRON-BOX', lambda: {
    'LOC': ZG.CAROUSEL_ROOM,
    'SYNONYM': 'BOX',
    'ADJECTIVE': ('STEEL', 'DENTED'),
    'DESC': 'steel box',
    'FLAGS': ('CONTBIT', 'TAKEBIT', 'INVISIBLE'),
    'LDESC': 'There is a dented steel box here.',
    'CAPACITY': 20,
    'SIZE': 40,
})

# zil: 2dungeon.zil:2225  <OBJECT CAGE>
ZG.world.declare_object('CAGE', 'CAGE', lambda: {
    'LOC': ZG.CAGE_ROOM,
    'FLAGS': 'INVISIBLE',
    'SYNONYM': 'CAGE',
    'ADJECTIVE': ('STEEL', 'SOLID'),
    'DESC': 'solid steel cage',
    'LDESC': 'There is a solid steel cage in the middle of the room.',
})

# zil: 2dungeon.zil:2233  <OBJECT CANDY>
ZG.world.declare_object('CANDY', 'CANDY', lambda: {
    'LOC': ZG.POOL_ROOM,
    'SYNONYM': ('PACKAGE', 'CANDY', 'TREASURE', 'GRASSHOPPERS'),
    'ADJECTIVE': ('CANDIED', 'RARE'),
    'DESC': 'package of candy',
    'FLAGS': ('STAGGERED', 'FOODBIT', 'TAKEBIT', 'INVISIBLE', 'READBIT'),
    'LDESC': 'There is a package of candied goodies here.',
    'ACTION': ZG.CANDY_FCN,
    'SIZE': 8,
    'VALUE': 15,
})

# zil: 2dungeon.zil:2244  <OBJECT TOP-ETCHINGS>
ZG.world.declare_object('TOP_ETCHINGS', 'TOP-ETCHINGS', lambda: {
    'LOC': ZG.WELL_TOP,
    'SYNONYM': ('ETCHINGS', 'WALL'),
    'DESC': 'wall with etchings',
    'FLAGS': ('READBIT', 'NDESCBIT'),
    'ACTION': ZG.TOP_ETCHINGS_F,
})

# zil: 2dungeon.zil:2251  <OBJECT BOTTOM-ETCHINGS>
ZG.world.declare_object('BOTTOM_ETCHINGS', 'BOTTOM-ETCHINGS', lambda: {
    'LOC': ZG.WELL_BOTTOM,
    'SYNONYM': ('ETCHINGS', 'WALL'),
    'DESC': 'wall with etchings',
    'FLAGS': ('READBIT', 'NDESCBIT'),
    'ACTION': ZG.BOTTOM_ETCHINGS_F,
})

# zil: 2dungeon.zil:2258  <OBJECT FUSE>
ZG.world.declare_object('FUSE', 'FUSE', lambda: {
    'LOC': ZG.COBWEBBY_CORRIDOR,
    'SYNONYM': ('FUSE', 'STRING', 'COIL'),
    'ADJECTIVE': ('BLACK', 'THIN'),
    'DESC': 'black string',
    'FLAGS': ('TAKEBIT', 'BURNBIT'),
    'ACTION': ZG.FUSE_FCN,
    'LDESC': 'There is a coil of black, braided string here.',
    'SIZE': 1,
})

# zil: 2dungeon.zil:2268  <OBJECT BUCKET>
ZG.world.declare_object('BUCKET', 'BUCKET', lambda: {
    'LOC': ZG.WELL_BOTTOM,
    'SYNONYM': 'BUCKET',
    'ADJECTIVE': 'WOODEN',
    'DESC': 'wooden bucket',
    'FLAGS': ('VEHBIT', 'OPENBIT', 'CONTBIT'),
    'ACTION': ZG.BUCKET_FCN,
    'CONTFCN': ZG.BUCKET_CONT,
    'LDESC': 'There is a wooden bucket here, 3 feet in diameter and 3 feet high.',
    'CAPACITY': 100,
    'SIZE': 100,
    'VTYPE': 0,
})

# zil: 2dungeon.zil:2282  <OBJECT POSTS>
ZG.world.declare_object('POSTS', 'POSTS', lambda: {
    'LOC': ZG.POSTS_ROOM,
    'SYNONYM': ('POSTS', 'POST'),
    'ADJECTIVE': 'WOODEN',
    'FLAGS': 'NDESCBIT',
    'DESC': 'group of wooden posts',
})

'SUBTITLE BANK OBJECTS'

# zil: 2dungeon.zil:2291  <OBJECT BILLS>
ZG.world.declare_object('BILLS', 'BILLS', lambda: {
    'LOC': ZG.VAULT,
    'SYNONYM': ('BILLS', 'STACK', 'MONEY', 'TREASURE'),
    'ADJECTIVE': ('NEAT', 'MANY', 'ZORKMID'),
    'DESC': 'stack of zorkmid bills',
    'FLAGS': ('STAGGERED', 'READBIT', 'TAKEBIT', 'BURNBIT'),
    'ACTION': ZG.BILLS_OBJECT,
    'LDESC': '200 neatly stacked zorkmid bills are here.',
    'FDESC': 'On the floor sit 200 neatly stacked zorkmid bills.',
    'SIZE': 10,
    'VALUE': 25,
    'TEXT': 'Each bill is worth 100 zorkmids, and bears the legend\n"In Frobs We Trust".',
})

# ;"
# ______________________________________________________________
# + 1  0   0          GREAT UNDERGROUND EMPIRE         1  0   0 +|
# + 1 0 0 0 0					     1 0 0 0 0+|
# + 1 0 0 0 0					     1 0 0 0 0+|
# + 1  0   0		    DIMWIT		     1  0   0 +|
# +	               ++++++++++++++++	  		      +|
# +		       ++   __  __   ++		   B30332744D +|
# +		       ++  -OO  OO-  ++	  		      +|
# +	IN  FROBS      \\++    >>    ++/	    WE  TRUST         +|
# +		        ++  ______  ++	       		      +|
# + B30332744D	         +  ------  +	       		      +|
# +                        \\\\________//	       		      +|
# + 1  0   0    Series	   FLATHEAD	LD Flathead  1  0   0 +|
# + 1 0 0 0 0   719GUE	   		 Treasurer   1 0 0 0 0+|
# + 1 0 0 0 0 					     1 0 0 0 0+|
# + 1  0   0	  One Hundred Royal Zorkmids	     1  0   0 +|
# +_____________________________________________________________+|
#
# "

# zil: 2dungeon.zil:2328  <OBJECT PORTRAIT>
ZG.world.declare_object('PORTRAIT', 'PORTRAIT', lambda: {
    'LOC': ZG.OFFICE,
    'SYNONYM': ('PORTRAIT', 'PAINTING', 'ART', 'TREASURE'),
    'ADJECTIVE': 'FLATHEAD',
    'DESC': 'portrait of J. Pierpont Flathead',
    'FLAGS': ('STAGGERED', 'TAKEBIT', 'BURNBIT'),
    'LDESC': 'The portrait of J. Pierpont Flathead is here.',
    'FDESC': 'A portrait of J. Pierpont Flathead hangs on the wall.',
    'SIZE': 25,
    'VALUE': 20,
})

# ;"|
#         !!!!!!!!!!!!!!|
#        !!   __  __   !!|
#        !!   $$  $$   !!|
#        \\!!    >>    !!/|
#         !!  ______  !!|
#          !  -//--   !|
#          \\\\_//_____//|
#         ___//!  !|
#         \\_// !  !|
#   __________//  \\\\__________|
#  / $ /       *ZZ*       \\ $ \\|
# |
#      J.  PIERPONT  FLATHEAD|
#           CHAIRMAN|
# "

# zil: 2dungeon.zil:2358  <OBJECT BANK-BROCHURE>
ZG.world.declare_object('BANK_BROCHURE', 'BANK-BROCHURE', lambda: {
    'LOC': ZG.DEPOSITORY,
    'SYNONYM': ('BROCHURE', 'PAPER', 'PIECE'),
    'ADJECTIVE': ('BANK', 'SMALL', 'WORN'),
    'DESC': 'bank brochure',
    'FDESC': 'On the ground is a small, worn piece of paper.',
    'FLAGS': ('READBIT', 'TAKEBIT', 'BURNBIT'),
    'SIZE': 2,
    'TEXT': 'The paper is barely readable. You can only make out "... valuables\nare completely safe ... advanced\nmagic technology ... impossible to take valuables from the depository\n... either teller\'s ... Many customers faint ... teller pops in ...\nseems to walk through ... walls ..."',
})

# zil: 2dungeon.zil:2373  <OBJECT CUBE>
ZG.world.declare_object('CUBE', 'CUBE', lambda: {
    'LOC': ZG.DEPOSITORY,
    'SYNONYM': ('VAULT', 'CUBE', 'LETTER'),
    'ADJECTIVE': ('STONE', 'LARGE'),
    'DESC': 'large stone cube',
    'FLAGS': ('READBIT', 'NDESCBIT'),
    'ACTION': ZG.CUBE_F,
})

# zil: 2dungeon.zil:2381  <OBJECT CURTAIN>
ZG.world.declare_object('CURTAIN', 'CURTAIN', lambda: {
    'LOC': ZG.DEPOSITORY,
    'SYNONYM': ('CURTAIN', 'LIGHT'),
    'ADJECTIVE': 'SHIMMERING',
    'DESC': 'shimmering curtain of light',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.SCOL_OBJECT,
})

# zil: 2dungeon.zil:2389  <OBJECT GNOME-OF-ZURICH>
ZG.world.declare_object('GNOME_OF_ZURICH', 'GNOME-OF-ZURICH', lambda: {
    'SYNONYM': ('GNOME', 'ZURICH'),
    'ADJECTIVE': 'ZURICH',
    'DESC': 'Gnome of Zurich',
    'FLAGS': ('ACTORBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.ZGNOME_FCN,
    'LDESC': 'There is a Gnome of Zurich here.',
})

# zil: 2dungeon.zil:2397  <OBJECT DEPOSIT-BOX>
ZG.world.declare_object('DEPOSIT_BOX', 'DEPOSIT-BOX', lambda: {
    'LOC': ZG.GNOME_OF_ZURICH,
    'SYNONYM': 'BOX',
    'ADJECTIVE': ('DEPOSIT', 'SAFETY'),
    'DESC': 'safety deposit box',
    'FLAGS': ('NDESCBIT', 'TAKEBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.BOX_F,
})

# ;"PALANTIR SECTION"

# zil: 2dungeon.zil:2407  <OBJECT PDOOR>
ZG.world.declare_object('PDOOR', 'PDOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('WOODEN', 'OAK'),
    'DESC': 'door made of oak',
    'FLAGS': ('DOORBIT', 'CONTBIT'),
    'ACTION': ZG.PDOOR_FCN,
})

# zil: 2dungeon.zil:2415  <OBJECT PWINDOW>
ZG.world.declare_object('PWINDOW', 'PWINDOW', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WINDOW',
    'ADJECTIVE': 'BARRED',
    'DESC': 'barred window',
    'FLAGS': 'DOORBIT',
    'ACTION': ZG.PWINDOW_FCN,
})

# zil: 2dungeon.zil:2423  <OBJECT LID-1>
ZG.world.declare_object('LID_1', 'LID-1', lambda: {
    'LOC': ZG.TINY_ROOM,
    'SYNONYM': 'LID',
    'ADJECTIVE': 'METAL',
    'DESC': 'metal lid',
    'FLAGS': ('NDESCBIT', 'CONTBIT'),
    'ACTION': ZG.PLID_FCN,
})

# zil: 2dungeon.zil:2431  <OBJECT LID-2>
ZG.world.declare_object('LID_2', 'LID-2', lambda: {
    'LOC': ZG.DREARY_ROOM,
    'SYNONYM': 'LID',
    'ADJECTIVE': 'METAL',
    'DESC': 'metal lid',
    'FLAGS': ('NDESCBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.PLID_FCN,
})

# zil: 2dungeon.zil:2439  <OBJECT PTABLE>
ZG.world.declare_object('PTABLE', 'PTABLE', lambda: {
    'LOC': ZG.DREARY_ROOM,
    'SYNONYM': 'TABLE',
    'ADJECTIVE': ('DUSTY', 'WOODEN'),
    'DESC': 'table',
    'FLAGS': ('NDESCBIT', 'CONTBIT', 'SURFACEBIT', 'OPENBIT'),
    'CAPACITY': 40,
})

# zil: 2dungeon.zil:2447  <OBJECT PCRACK>
ZG.world.declare_object('PCRACK', 'PCRACK', lambda: {
    'LOC': ZG.DREARY_ROOM,
    'SYNONYM': 'CRACK',
    'ADJECTIVE': 'NARROW',
    'DESC': 'narrow crack',
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:2454  <OBJECT KEYHOLE-1>
ZG.world.declare_object('KEYHOLE_1', 'KEYHOLE-1', lambda: {
    'LOC': ZG.TINY_ROOM,
    'SYNONYM': ('KEYHOLE', 'HOLE'),
    'DESC': 'keyhole',
    'FLAGS': ('NDESCBIT', 'OPENBIT', 'SEARCHBIT'),
    'ACTION': ZG.PKH_FCN,
    'CAPACITY': 2,
})

# zil: 2dungeon.zil:2462  <OBJECT KEYHOLE-2>
ZG.world.declare_object('KEYHOLE_2', 'KEYHOLE-2', lambda: {
    'LOC': ZG.DREARY_ROOM,
    'SYNONYM': ('KEYHOLE', 'HOLE'),
    'DESC': 'keyhole',
    'FLAGS': ('NDESCBIT', 'OPENBIT', 'SEARCHBIT'),
    'ACTION': ZG.PKH_FCN,
    'CAPACITY': 2,
})

# zil: 2dungeon.zil:2470  <OBJECT LETTER-OPENER>
ZG.world.declare_object('LETTER_OPENER', 'LETTER-OPENER', lambda: {
    'LOC': ZG.GAZEBO_TABLE,
    'SYNONYM': 'OPENER',
    'ADJECTIVE': 'LETTER',
    'DESC': 'letter opener',
    'SIZE': 2,
    'FLAGS': ('TAKEBIT', 'TOOLBIT'),
})

# zil: 2dungeon.zil:2478  <OBJECT KEY>
ZG.world.declare_object('KEY', 'KEY', lambda: {
    'LOC': ZG.KEYHOLE_2,
    'SYNONYM': 'KEY',
    'ADJECTIVE': ('IRON', 'RUSTY'),
    'DESC': 'rusty iron key',
    'FLAGS': ('TAKEBIT', 'NDESCBIT', 'TURNBIT', 'TOOLBIT'),
    'ACTION': ZG.PKEY_FCN,
    'SIZE': 2,
})

# zil: 2dungeon.zil:2487  <OBJECT PALANTIR-2>
ZG.world.declare_object('PALANTIR_2', 'PALANTIR-2', lambda: {
    'LOC': ZG.DREARY_ROOM,
    'SYNONYM': ('PALANTIR', 'SPHERE'),
    'ADJECTIVE': ('CRYSTAL', 'BLUE'),
    'DESC': 'blue crystal sphere',
    'FLAGS': ('STAGGERED', 'TAKEBIT', 'TRANSBIT'),
    'ACTION': ZG.PALANTIR,
    'VALUE': 20,
    'FDESC': 'In the center of the table sits a blue crystal sphere.',
})

# zil: 2dungeon.zil:2497  <OBJECT GAZEBO>
ZG.world.declare_object('GAZEBO', 'GAZEBO', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('GAZEBO', 'STRUCTURE'),
    'ADJECTIVE': 'WOODEN',
    'DESC': 'gazebo',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.GAZEBO_FCN,
})

# zil: 2dungeon.zil:2505  <OBJECT GAZEBO-TABLE>
ZG.world.declare_object('GAZEBO_TABLE', 'GAZEBO-TABLE', lambda: {
    'LOC': ZG.GAZEBO_ROOM,
    'SYNONYM': 'TABLE',
    'ADJECTIVE': 'TEA',
    'DESC': 'table',
    'FLAGS': ('NDESCBIT', 'SURFACEBIT', 'CONTBIT', 'OPENBIT'),
    'CAPACITY': 100,
})

# zil: 2dungeon.zil:2513  <OBJECT NEWSPAPER>
ZG.world.declare_object('NEWSPAPER', 'NEWSPAPER', lambda: {
    'LOC': ZG.GAZEBO_TABLE,
    'SYNONYM': ('PAPER', 'NEWSPAPER'),
    'ADJECTIVE': ('NEWS', 'NEWSPAPER'),
    'DESC': 'newspaper',
    'FLAGS': ('TAKEBIT', 'BURNBIT', 'READBIT'),
    'TEXT': '** U.S. News and Dungeon Report **\n\nFAMED ADVENTURER TO EXPLORE GREAT UNDERGROUND EMPIRE\n\nOur correspondents report that a world-famous and battle-hardened\nadventurer has been seen in the vicinity of the Great Underground\nEmpire. Local grues have been reported sharpening their (slavering)\nfangs....\n\n"Zork II: The Wizard of Frobozz" was written by Dave Lebling and Marc\nBlank, and is (c) Copyright 1981, 1982, 1983 by Infocom, Inc.',
})

# zil: 2dungeon.zil:2532  <OBJECT PLACE-MAT>
ZG.world.declare_object('PLACE_MAT', 'PLACE-MAT', lambda: {
    'LOC': ZG.GAZEBO_TABLE,
    'SYNONYM': ('MAT', 'PLACEM'),
    'ADJECTIVE': 'PLACE',
    'DESC': 'place mat',
    'FLAGS': ('TAKEBIT', 'SURFACEBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.PLACE_MAT_FCN,
    'SIZE': 12,
    'CAPACITY': 20,
})

# zil: 2dungeon.zil:2542  <OBJECT TEAPOT>
ZG.world.declare_object('TEAPOT', 'TEAPOT', lambda: {
    'LOC': ZG.GAZEBO_TABLE,
    'SYNONYM': ('TEAPOT', 'POT'),
    'ADJECTIVE': ('CHINA', 'TEA'),
    'DESC': 'china teapot',
    'FLAGS': ('TAKEBIT', 'TRANSBIT', 'CONTBIT', 'OPENBIT'),
    'CAPACITY': 4,
    'ACTION': ZG.TEAPOT_F,
})

# zil: 2dungeon.zil:2551  <ROUTINE TEAPOT-F ()>
@ZG.routine('TEAPOT-F')
def TEAPOT_F():
    if VERB_p('CLOSE'):
        return TELL('The teapot has no lid.', CR)
    else:
        return False

# zil: 2dungeon.zil:2555  <OBJECT WATER>
ZG.world.declare_object('WATER', 'WATER', lambda: {
    'SYNONYM': ('WATER', 'QUANTITY', 'LIQUID', 'H2O'),
    'DESC': 'quantity of water',
    'FLAGS': ('TAKEBIT', 'DRINKBIT'),
    'ACTION': ZG.WATER_FCN,
    'LDESC': 'There is some water here.',
    'SIZE': 4,
})

# zil: 2dungeon.zil:2563  <OBJECT SALTY-WATER>
ZG.world.declare_object('SALTY_WATER', 'SALTY-WATER', lambda: {
    'SYNONYM': ('WATER', 'QUANTITY', 'LIQUID', 'H2O'),
    'DESC': 'quantity of salty water',
    'FLAGS': ('TAKEBIT', 'DRINKBIT'),
    'ACTION': ZG.WATER_FCN,
    'LDESC': 'There is some water here.',
    'SIZE': 4,
})

# zil: 2dungeon.zil:2571  <OBJECT GOLD-KEY>
ZG.world.declare_object('GOLD_KEY', 'GOLD-KEY', lambda: {
    'LOC': ZG.UNICORN,
    'SYNONYM': ('KEY', 'TREASURE'),
    'ADJECTIVE': ('DELICATE', 'GOLD'),
    'DESC': 'delicate gold key',
    'FLAGS': ('STAGGERED', 'NDESCBIT', 'TAKEBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.UNICORN_FCN,
    'VALUE': 15,
    'SIZE': 3,
})

# zil: 2dungeon.zil:2581  <OBJECT RIBBON>
ZG.world.declare_object('RIBBON', 'RIBBON', lambda: {
    'LOC': ZG.UNICORN,
    'SYNONYM': 'RIBBON',
    'ADJECTIVE': ('VELVET', 'SATIN'),
    'DESC': 'ribbon',
    'ACTION': ZG.UNICORN_FCN,
    'FLAGS': 'NDESCBIT',
})

# zil: 2dungeon.zil:2589  <OBJECT ROSE>
ZG.world.declare_object('ROSE', 'ROSE', lambda: {
    'SYNONYM': 'ROSE',
    'ADJECTIVE': ('BEAUTIFUL', 'RED', 'PERFECT'),
    'DESC': 'perfect rose',
    'FLAGS': 'TAKEBIT',
    'SIZE': 1,
    'ACTION': ZG.ROSE_F,
})

# zil: 2dungeon.zil:2597  <ROUTINE ROSE-F ()>
@ZG.routine('ROSE-F')
def ROSE_F():
    if VERB_p('SMELL'):
        return TELL('Unlike your efforts here, it comes out smelling like a rose.', CR)
    elif VERB_p('EXAMINE'):
        return TELL('A rose is a rose is a rose....', CR)
    else:
        return False

# zil: 2dungeon.zil:2604  <OBJECT GENIE>
ZG.world.declare_object('GENIE', 'GENIE', lambda: {
    'SYNONYM': ('DEVIL', 'DEMON', 'GENIE', 'DJINN'),
    'DESC': 'demon',
    'FLAGS': ('ACTORBIT', 'INVISIBLE'),
    'ACTION': ZG.GENIE_FCN,
    'LDESC': 'There is a demon floating in midair here.',
})

# zil: 2dungeon.zil:2611  <OBJECT WIZARD>
ZG.world.declare_object('WIZARD', 'WIZARD', lambda: {
    'SYNONYM': ('WIZARD', 'MAGICIAN', 'SORCEROR', 'MAN'),
    'ADJECTIVE': ('STRANGE', 'LITTLE', 'FROBOZZ', 'OLD'),
    'DESC': 'Wizard of Frobozz',
    'LDESC': 'The Wizard of Frobozz is here, eyeing you warily.',
    'FLAGS': ('ACTORBIT', 'CONTBIT', 'OPENBIT'),
    'ACTION': ZG.WIZARD_FCN,
})

# zil: 2dungeon.zil:2620  <OBJECT WAND>
ZG.world.declare_object('WAND', 'WAND', lambda: {
    'LOC': ZG.WIZARD,
    'SYNONYM': 'WAND',
    'ADJECTIVE': 'MAGIC',
    'DESC': "Wizard's magic wand",
    'FLAGS': ('STAGGERED', 'NDESCBIT', 'TAKEBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.WAND_FCN,
    'VALUE': 30,
})

# zil: 2dungeon.zil:2629  <OBJECT SWORD>
ZG.world.declare_object('SWORD', 'SWORD', lambda: {
    'LOC': ZG.INSIDE_BARROW,
    'SYNONYM': ('SWORD', 'ORCRIST', 'GLAMDRING', 'BLADE'),
    'ADJECTIVE': ('ELVISH', 'OLD', 'ANTIQUE'),
    'DESC': 'elvish sword',
    'FLAGS': ('TAKEBIT', 'WEAPONBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.SWORD_FCN,
    'LDESC': 'An Elvish sword of great antiquity is here.',
    'FDESC': 'A sword of Elvish workmanship is on the ground.',
    'SIZE': 30,
})

# zil: 2dungeon.zil:2640  <OBJECT REPELLENT>
ZG.world.declare_object('REPELLENT', 'REPELLENT', lambda: {
    'LOC': ZG.ROOM_8,
    'SYNONYM': ('REPELLENT', 'CAN'),
    'ADJECTIVE': ('GRUE', 'MAGIC'),
    'DESC': 'Frobozz Magic Grue Repellent',
    'FLAGS': ('TAKEBIT', 'READBIT'),
    'ACTION': ZG.REPELLENT_FCN,
    'FDESC': 'A spray can is in the corner. In large type is the legend "Frobozz Magic\nGrue Repellent".',
    'TEXT': '!!! FROBOZZ MAGIC GRUE REPELLENT !!!\n\nInstructions for use: Apply liberally to creature to be protected.\nDuration of effect is unpredictable. Use only in place of death!\n\n(No warranty expressed or implied)',
})

# zil: 2dungeon.zil:2658  <ROOM DEAD-PALANTIR-1>
ZG.world.declare_object('DEAD_PALANTIR_1', 'DEAD-PALANTIR-1', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Room of Red Mist',
    'WEST': ('TO', ZG.DEAD_PALANTIR_2),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.DEAD_PALANTIR,
    'GLOBAL': ZG.GLOBAL_PALANTIR,
})

# zil: 2dungeon.zil:2667  <ROOM DEAD-PALANTIR-2>
ZG.world.declare_object('DEAD_PALANTIR_2', 'DEAD-PALANTIR-2', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Room of Blue Mist',
    'WEST': ('TO', ZG.DEAD_PALANTIR_3),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.DEAD_PALANTIR,
    'GLOBAL': ZG.GLOBAL_PALANTIR,
})

# zil: 2dungeon.zil:2676  <ROOM DEAD-PALANTIR-3>
ZG.world.declare_object('DEAD_PALANTIR_3', 'DEAD-PALANTIR-3', lambda: {
    'LOC': ZG.ROOMS,
    'LDESC': ' ',
    'DESC': 'Room of White Mist',
    'WEST': ('TO', ZG.DEAD_PALANTIR_4),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.DEAD_PALANTIR,
    'GLOBAL': ZG.GLOBAL_PALANTIR,
})

# zil: 2dungeon.zil:2685  <ROOM DEAD-PALANTIR-4>
ZG.world.declare_object('DEAD_PALANTIR_4', 'DEAD-PALANTIR-4', lambda: {
    'LDESC': ' ',
    'LOC': ZG.ROOMS,
    'DESC': 'Room of Black Mist',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.DEAD_PALANTIR,
})

# zil: 2dungeon.zil:2692  <OBJECT GLOBAL-PALANTIR>
ZG.world.declare_object('GLOBAL_PALANTIR', 'GLOBAL-PALANTIR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'SPHERE',
    'ADJECTIVE': ('RED', 'BLUE', 'WHITE', 'CRYSTAL'),
    'DESC': 'sphere',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.GLOBAL_PALANTIRS,
})

# zil: 2dungeon.zil:2700  <OBJECT FOOTPAD>
ZG.world.declare_object('FOOTPAD', 'FOOTPAD', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'FOOTPAD',
    'DESC': 'footpad',
    'ACTION': ZG.FOOTPAD_F,
})

# zil: 2dungeon.zil:2706  <ROUTINE FOOTPAD-F ()>
@ZG.routine('FOOTPAD-F')
def FOOTPAD_F():
    if VERB_p('EXAMINE'):
        return TELL('A footpad is a thief.', CR)
    else:
        return False

# zil: 2dungeon.zil:2710  <OBJECT COMPASS>
ZG.world.declare_object('COMPASS', 'COMPASS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'DESC': 'compass',
    'SYNONYM': 'COMPASS',
    'ACTION': ZG.COMPASS_F,
})

# zil: 2dungeon.zil:2716  <ROUTINE COMPASS-F ()>
@ZG.routine('COMPASS-F')
def COMPASS_F():
    if VERB_p('FIND'):
        return TELL("It's on your person. And lucky for you, or you would become hopelessly\nlost.", CR)
    elif VERB_p('DROP', 'THROW', 'OVERBOARD'):
        return TELL("You can't get rid of it. It is an extension of yourself.", CR)
    elif VERB_p('EXAMINE'):
        return TELL("It's one of those gizmos with a needle and a card with the eight major\ncompass directions. Simple, but effective.", CR)
    elif VERB_p('READ'):
        return TELL("It doesn't make very interesting reading - just the compass directions.", CR)
    else:
        return TELL("You can't do that. And don't bother to ask why.", CR)
