# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'DUNGEON3 for\n\t\t     ZORK III: The Dungeon Master\n\t\t The Great Underground Empire (Part 3)\n\t(c) Copyright 1982 Infocom, Inc.  All Rights Reserved.\n'

DIRECTIONS('NORTH', 'EAST', 'WEST', 'SOUTH', 'NE', 'NW', 'SE', 'SW', 'UP', 'DOWN', 'IN', 'OUT', 'LAND', 'CROSS')

'SUBTITLE GLOBAL OBJECTS'

# zil: 3dungeon.zil:11  <OBJECT RUBBLE>
ZG.world.declare_object('RUBBLE', 'RUBBLE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('ROCK', 'ROCKS', 'BOULDER', 'RUBBLE'),
    'DESC': 'rubble',
    'FLAGS': 'NDESCBIT',
})

# zil: 3dungeon.zil:17  <OBJECT DEBRIS>
ZG.world.declare_object('DEBRIS', 'DEBRIS', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('DUST', 'DEBRIS'),
    'DESC': 'dust and debris',
    'FLAGS': 'NDESCBIT',
})

# zil: 3dungeon.zil:23  <OBJECT CHASM>
ZG.world.declare_object('CHASM', 'CHASM', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('CHASM', 'GORGE', 'RAVINE'),
    'ADJECTIVE': ('ROCKY', 'DEEP'),
    'DESC': 'chasm',
    'ACTION': ZG.CHASM_FCN,
    'FLAGS': 'NDESCBIT',
})

# zil: 3dungeon.zil:31  <OBJECT TUNNEL>
ZG.world.declare_object('TUNNEL', 'TUNNEL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': ('PASSAGE', 'CRAWLWAY'),
    'ADJECTIVE': ('DARK', 'SMOKY'),
    'DESC': 'tunnel',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.TUNNEL_OBJECT,
})

# zil: 3dungeon.zil:39  <OBJECT EAST-WALL>
ZG.world.declare_object('EAST_WALL', 'EAST-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('EAST', 'EASTERN'),
    'DESC': 'eastern wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.RANDOM_WALL,
})

# zil: 3dungeon.zil:47  <OBJECT SOUTH-WALL>
ZG.world.declare_object('SOUTH_WALL', 'SOUTH-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('SOUTH', 'SOUTHE'),
    'DESC': 'southern wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.RANDOM_WALL,
})

# zil: 3dungeon.zil:55  <OBJECT WEST-WALL>
ZG.world.declare_object('WEST_WALL', 'WEST-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('WEST', 'WESTERN'),
    'DESC': 'western wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.RANDOM_WALL,
})

# zil: 3dungeon.zil:63  <OBJECT NORTH-WALL>
ZG.world.declare_object('NORTH_WALL', 'NORTH-WALL', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('NORTH', 'NORTHE'),
    'DESC': 'northern wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.RANDOM_WALL,
})

# zil: 3dungeon.zil:71  <OBJECT GLOBAL-WATER>
ZG.world.declare_object('GLOBAL_WATER', 'GLOBAL-WATER', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': ('WATER', 'QUANTITY'),
    'DESC': 'water',
    'FLAGS': 'DRINKBIT',
    'ACTION': ZG.WATER_FCN,
})

# zil: 3dungeon.zil:78  <OBJECT WATER>
ZG.world.declare_object('WATER', 'WATER', lambda: {
    'SYNONYM': ('WATER', 'QUANTITY', 'LIQUID', 'H2O'),
    'DESC': 'quantity of water',
    'FLAGS': ('TAKEBIT', 'DRINKBIT'),
    'ACTION': ZG.WATER_FCN,
    'LDESC': 'There is some water here.',
    'SIZE': 4,
})

# zil: 3dungeon.zil:86  <OBJECT BROKEN-LAMP>
ZG.world.declare_object('BROKEN_LAMP', 'BROKEN-LAMP', lambda: {
    'SYNONYM': ('LAMP', 'LANTERN'),
    'ADJECTIVE': ('BROKEN', 'BRASS'),
    'DESC': 'broken lantern',
    'FLAGS': 'TAKEBIT',
    'SIZE': 15,
})

# zil: 3dungeon.zil:93  <OBJECT LAMP>
ZG.world.declare_object('LAMP', 'LAMP', lambda: {
    'LOC': ZG.CP_ANTE,
    'SYNONYM': ('LAMP', 'LANTERN'),
    'ADJECTIVE': 'BRASS',
    'DESC': 'lamp',
    'FLAGS': ('TAKEBIT', 'LIGHTBIT'),
    'FDESC': 'Your old friend, the brass lantern, is at your feet.',
    'ACTION': ZG.LANTERN,
    'SIZE': 15,
})

# zil: 3dungeon.zil:103  <OBJECT SWORD>
ZG.world.declare_object('SWORD', 'SWORD', lambda: {
    'LOC': ZG.STONE,
    'SYNONYM': ('SWORD', 'ORCRIST', 'GLAMDRING', 'BLADE'),
    'ADJECTIVE': ('ELVISH', 'OLD', 'ANTIQUE'),
    'DESC': 'sword',
    'FLAGS': ('TAKEBIT', 'WEAPONBIT', 'TRYTAKEBIT'),
    'ACTION': ZG.SWORD_FCN,
    'SIZE': 25,
    'VALUE': 0,
})

'CHINESE PUZZLE ROOMS/OBJECTS'

# zil: 3dungeon.zil:115  <ROOM CP-ANTE>
ZG.world.declare_object('CP_ANTE', 'CP-ANTE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Royal Puzzle Entrance',
    'WEST': ('TO', ZG.CP_OUT),
    'NORTH': ('TO', ZG.MUSEUM_ENTRANCE),
    'UP': ('TO', ZG.MUSEUM_ENTRANCE),
    'DOWN': ('PER', ZG.CPENTER),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.CPANT_ROOM,
    'GLOBAL': ZG.STAIRS,
})

# zil: 3dungeon.zil:126  <ROOM CP-OUT>
ZG.world.declare_object('CP_OUT', 'CP-OUT', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Side Room',
    'NORTH': ('TO', ZG.CP_ANTE),
    'UP': ('TO', ZG.CP_ANTE),
    'EAST': ('TO', ZG.CP, 'IF', 'CP_FLAG', 'ELSE', 'The steel door is closed.'),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'ACTION': ZG.CPOUT_ROOM,
    'GLOBAL': (ZG.CPDOOR, ZG.STAIRS),
})

# zil: 3dungeon.zil:136  <ROOM CP>
ZG.world.declare_object('CP', 'CP', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Room in a Puzzle',
    'NORTH': ('PER', ZG.CPEXIT),
    'SOUTH': ('PER', ZG.CPEXIT),
    'EAST': ('PER', ZG.CPEXIT),
    'WEST': ('PER', ZG.CPEXIT),
    'NE': ('PER', ZG.CPEXIT),
    'NW': ('PER', ZG.CPEXIT),
    'SE': ('PER', ZG.CPEXIT),
    'UP': ('PER', ZG.CPEXIT),
    'SW': ('PER', ZG.CPEXIT),
    'ACTION': ZG.CP_ROOM,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.CPLADDER, ZG.CPDOOR, ZG.CPEWL, ZG.CPWWL, ZG.CPNWL, ZG.CPSWL),
})

# ;"SUBTITLE CHINESE PUZZLE OBJECTS"

# zil: 3dungeon.zil:154  <OBJECT WARNING-NOTE>
ZG.world.declare_object('WARNING_NOTE', 'WARNING-NOTE', lambda: {
    'LOC': ZG.CP_ANTE,
    'DESC': 'warning note',
    'SYNONYM': ('NOTE', 'WARNING', 'TEXT'),
    'ADJECTIVE': ('WARNING', 'SMALL'),
    'FDESC': 'Lying on the ground is a small note of some kind.',
    'FLAGS': ('TAKEBIT', 'READBIT', 'BURNBIT'),
    'SIZE': 2,
    'TEXT': 'Warning:\n    The Royal Puzzle is dangerous and it is possible to become\ntrapped within its confines. Please do not enter the puzzle after hours\nwhen museum personnel are not present.\n              The Management',
})

# zil: 3dungeon.zil:169  <OBJECT CP-SLOT>
ZG.world.declare_object('CP_SLOT', 'CP-SLOT', lambda: {
    'SYNONYM': ('CPSLT', 'SLIT', 'SLOT'),
    'ADJECTIVE': 'SMALL',
    'DESC': 'small slot',
    'FLAGS': ('NDESCBIT', 'OPENBIT'),
    'ACTION': ZG.CP_SLOT_FCN,
    'CAPACITY': 4,
})

# zil: 3dungeon.zil:177  <OBJECT CPDOOR>
ZG.world.declare_object('CPDOOR', 'CPDOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('STEEL', 'METAL'),
    'DESC': 'steel door',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.CPDOOR_F,
})

# zil: 3dungeon.zil:185  <OBJECT LORE-BOOK>
ZG.world.declare_object('LORE_BOOK', 'LORE-BOOK', lambda: {
    'SYNONYM': ('BOOK', 'LORE', 'TEXT'),
    'ADJECTIVE': ('LORE', 'OLD', 'STRANGE'),
    'DESC': 'very ancient book',
    'FLAGS': ('TAKEBIT', 'READBIT'),
    'LDESC': 'There is an old book here.',
    'FDESC': 'Nestled inside the niche is an old and dusty book.',
    'TEXT': 'The book is written in a strong and elegant hand and is full of strange,\nwondrous pictures. The text, penned in many colours, is in a tongue unknown\nto you. The words seem to change colour as you read them.\nThe book itself is very old and the pages dry and brittle.',
    'SIZE': 4,
    'ACTION': ZG.LORE_BOOK_F,
})

# zil: 3dungeon.zil:202  <GLOBAL CP-FLAG>
# GLOBAL (state) CP_FLAG = False  ->  ZilGlobal.py

# zil: 3dungeon.zil:204  <OBJECT CPEWL>
ZG.world.declare_object('CPEWL', 'CPEWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('EAST', 'EASTERN'),
    'DESC': 'eastern wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.CPWALL_OBJECT,
})

# zil: 3dungeon.zil:212  <OBJECT CPWWL>
ZG.world.declare_object('CPWWL', 'CPWWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('WEST', 'WESTERN'),
    'DESC': 'western wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.CPWALL_OBJECT,
})

# zil: 3dungeon.zil:220  <OBJECT CPSWL>
ZG.world.declare_object('CPSWL', 'CPSWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': 'SOUTH',
    'DESC': 'southern wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.CPWALL_OBJECT,
})

# zil: 3dungeon.zil:228  <OBJECT CPNWL>
ZG.world.declare_object('CPNWL', 'CPNWL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'SYNONYM': 'WALL',
    'ADJECTIVE': 'NORTH',
    'DESC': 'northern wall',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.CPWALL_OBJECT,
})

# zil: 3dungeon.zil:236  <OBJECT CPLADDER>
ZG.world.declare_object('CPLADDER', 'CPLADDER', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'LADDER',
    'DESC': 'ladder',
    'ACTION': ZG.CPLADDER_OBJECT,
})

# ;"Objects/rooms for old end-game"

# zil: 3dungeon.zil:244  <OBJECT INTDIR>
ZG.world.declare_object('INTDIR', 'INTDIR', lambda: {
    'LOC': ZG.GLOBAL_OBJECTS,
    'SYNONYM': 'INTDIR',
    'FLAGS': 'TOOLBIT',
    'DESC': 'direction',
})

# zil: 3dungeon.zil:250  <OBJECT GUARDIAN>
ZG.world.declare_object('GUARDIAN', 'GUARDIAN', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'Guardians of Zork',
    'SYNONYM': ('STATUE', 'GUARDIAN', 'GUARD', 'GUARDS'),
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.GUARDIANS,
})

# zil: 3dungeon.zil:257  <OBJECT ROSE>
ZG.world.declare_object('ROSE', 'ROSE', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'compass rose',
    'SYNONYM': 'ROSE',
    'ADJECTIVE': 'COMPASS',
    'ACTION': ZG.ROSE_F,
})

# zil: 3dungeon.zil:264  <OBJECT MASTER>
ZG.world.declare_object('MASTER', 'MASTER', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'dungeon master',
    'SYNONYM': ('MASTER', 'MAN'),
    'ADJECTIVE': 'DUNGEON',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.MASTER_F,
})

# zil: 3dungeon.zil:272  <OBJECT DUNGEON-MASTER>
ZG.world.declare_object('DUNGEON_MASTER', 'DUNGEON-MASTER', lambda: {
    'LOC': ZG.BEHIND_DOOR,
    'DESC': 'dungeon master',
    'LDESC': 'The dungeon master is quietly leaning on his staff here.',
    'SYNONYM': ('MASTER', 'DUNGEON', 'MAN'),
    'ADJECTIVE': 'DUNGEON',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.DUNGEON_MASTER_F,
})

# zil: 3dungeon.zil:282  <OBJECT MIRROR>
ZG.world.declare_object('MIRROR', 'MIRROR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'mirror',
    'SYNONYM': ('MIRROR', 'STRUCTURE'),
    'ACTION': ZG.MIRROR_FUNCTION,
})

# zil: 3dungeon.zil:288  <OBJECT PANEL>
ZG.world.declare_object('PANEL', 'PANEL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'panel',
    'SYNONYM': 'PANEL',
    'ACTION': ZG.PANEL_FUNCTION,
})

# zil: 3dungeon.zil:294  <OBJECT CHANNEL>
ZG.world.declare_object('CHANNEL', 'CHANNEL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'stone channel',
    'SYNONYM': ('CHANNEL', 'HOLE'),
    'ADJECTIVE': 'STONE',
})

# zil: 3dungeon.zil:300  <ROOM MRD>
ZG.world.declare_object('MRD', 'MRD', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Hallway',
    'LDESC': ' ',
    'NORTH': ('TO', ZG.FRONT_DOOR),
    'NE': ('TO', ZG.FRONT_DOOR),
    'NW': ('TO', ZG.FRONT_DOOR),
    'SOUTH': ('PER', ZG.MRGO),
    'SE': ('PER', ZG.MRGO),
    'SW': ('PER', ZG.MRGO),
    'ACTION': ZG.MRDF,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.ROSE, ZG.CHANNEL, ZG.GUARDIAN, ZG.WOODEN_WALL),
})

# zil: 3dungeon.zil:314  <ROOM MRG>
ZG.world.declare_object('MRG', 'MRG', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Hallway',
    'LDESC': ' ',
    'NORTH': ('PER', ZG.MRGO),
    'NW': ('PER', ZG.MRGO),
    'NE': ('PER', ZG.MRGO),
    'ENTER': ('PER', ZG.MIRIN),
    'SOUTH': ('PER', ZG.MRGO),
    'SW': ('PER', ZG.MRGO),
    'SE': ('PER', ZG.MRGO),
    'ACTION': ZG.GUARDIANS,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': ZG.GUARDIAN,
})

# zil: 3dungeon.zil:329  <ROOM MRC>
ZG.world.declare_object('MRC', 'MRC', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Hallway',
    'LDESC': ' ',
    'NORTH': ('PER', ZG.MRGO),
    'NW': ('PER', ZG.MRGO),
    'NE': ('PER', ZG.MRGO),
    'ENTER': ('PER', ZG.MIRIN),
    'SOUTH': ('PER', ZG.MRGO),
    'SW': ('PER', ZG.MRGO),
    'SE': ('PER', ZG.MRGO),
    'ACTION': ZG.MRCF,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.ROSE, ZG.CHANNEL, ZG.GUARDIAN, ZG.WOODEN_WALL),
})

# zil: 3dungeon.zil:344  <ROOM MRB>
ZG.world.declare_object('MRB', 'MRB', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Hallway',
    'LDESC': ' ',
    'NORTH': ('PER', ZG.MRGO),
    'NW': ('PER', ZG.MRGO),
    'NE': ('PER', ZG.MRGO),
    'ENTER': ('PER', ZG.MIRIN),
    'SOUTH': ('PER', ZG.MRGO),
    'SW': ('PER', ZG.MRGO),
    'SE': ('PER', ZG.MRGO),
    'ACTION': ZG.MRBF,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.ROSE, ZG.CHANNEL, ZG.WOODEN_WALL),
})

# zil: 3dungeon.zil:359  <ROOM MRA>
ZG.world.declare_object('MRA', 'MRA', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Hallway',
    'LDESC': ' ',
    'NORTH': ('PER', ZG.MRGO),
    'NW': ('PER', ZG.MRGO),
    'NE': ('PER', ZG.MRGO),
    'ENTER': ('PER', ZG.MIRIN),
    'SOUTH': ('TO', ZG.MREYE),
    'ACTION': ZG.MRAF,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.ROSE, ZG.CHANNEL, ZG.WOODEN_WALL),
})

# zil: 3dungeon.zil:372  <ROOM MRDE>
ZG.world.declare_object('MRDE', 'MRDE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'WEST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.FRONT_DOOR),
    'SOUTH': ('TO', ZG.MRG),
    'ACTION': ZG.MRDEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:384  <ROOM MRDW>
ZG.world.declare_object('MRDW', 'MRDW', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'WEST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.FRONT_DOOR),
    'SOUTH': ('TO', ZG.MRG),
    'ACTION': ZG.MRDEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:396  <ROOM MRGE>
ZG.world.declare_object('MRGE', 'MRGE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'WEST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRD),
    'SOUTH': ('TO', ZG.MRC),
    'ACTION': ZG.GUARDIANS,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:408  <ROOM MRGW>
ZG.world.declare_object('MRGW', 'MRGW', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'EAST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRD),
    'SOUTH': ('TO', ZG.MRC),
    'ACTION': ZG.GUARDIANS,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:420  <ROOM MRCE>
ZG.world.declare_object('MRCE', 'MRCE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'WEST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRG),
    'SOUTH': ('TO', ZG.MRB),
    'ACTION': ZG.MRCEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:432  <ROOM MRCW>
ZG.world.declare_object('MRCW', 'MRCW', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'EAST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRG),
    'SOUTH': ('TO', ZG.MRB),
    'ACTION': ZG.MRCEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:444  <ROOM MRBE>
ZG.world.declare_object('MRBE', 'MRBE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'WEST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRC),
    'SOUTH': ('TO', ZG.MRA),
    'ACTION': ZG.MRBEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:456  <ROOM MRBW>
ZG.world.declare_object('MRBW', 'MRBW', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'EAST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRC),
    'SOUTH': ('TO', ZG.MRA),
    'ACTION': ZG.MRBEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:468  <ROOM MRAE>
ZG.world.declare_object('MRAE', 'MRAE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'WEST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRB),
    'SOUTH': ('TO', ZG.MREYE),
    'ACTION': ZG.MRAEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:480  <ROOM MRAW>
ZG.world.declare_object('MRAW', 'MRAW', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Room',
    'LDESC': ' ',
    'ENTER': ('PER', ZG.MIRIN),
    'EAST': ('PER', ZG.MIRIN),
    'NORTH': ('TO', ZG.MRB),
    'SOUTH': ('TO', ZG.MREYE),
    'ACTION': ZG.MRAEW,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:492  <ROOM IN-MIRROR>
ZG.world.declare_object('IN_MIRROR', 'IN-MIRROR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Inside Mirror',
    'LDESC': ' ',
    'OUT': ('PER', ZG.MIROUT),
    'NORTH': ('PER', ZG.MIROUT),
    'SOUTH': ('PER', ZG.MIROUT),
    'NW': ('PER', ZG.MIROUT),
    'NE': ('PER', ZG.MIROUT),
    'SE': ('PER', ZG.MIROUT),
    'SW': ('PER', ZG.MIROUT),
    'WEST': ('PER', ZG.MIROUT),
    'EAST': ('PER', ZG.MIROUT),
    'ACTION': ZG.MAGIC_MIRROR,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.ROSE, ZG.CHANNEL, ZG.GUARDIAN),
})

# zil: 3dungeon.zil:509  <ROOM MR-ANTE>
ZG.world.declare_object('MR_ANTE', 'MR-ANTE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Button Room',
    'LDESC': 'You are at the southern end of a long hall. To the south, stairs ascend\ninto darkness. To the north the corridor is illuminated by torches set\nhigh in the walls, out of reach. On one wall is a red button.',
    'SOUTH': ('TO', ZG.MSTAIRS, 'IF', 'SECRET_DOOR', 'IS', 'OPEN'),
    'UP': ('TO', ZG.MSTAIRS, 'IF', 'SECRET_DOOR', 'IS', 'OPEN'),
    'NORTH': ('TO', ZG.MREYE),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.SECRET_DOOR, ZG.STAIRS),
    'PSEUDO': ('TORCH', ZG.TORCH_PSEUDO, 'TORCHE', ZG.TORCH_PSEUDO),
})

# zil: 3dungeon.zil:523  <ROOM MREYE>
ZG.world.declare_object('MREYE', 'MREYE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Beam Room',
    'LDESC': ' ',
    'NORTH': ('PER', ZG.MRGO),
    'NW': ('PER', ZG.MRGO),
    'NE': ('PER', ZG.MRGO),
    'SOUTH': ('TO', ZG.MR_ANTE),
    'ACTION': ZG.MREYE_ROOM,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 3dungeon.zil:534  <ROOM MSTAIRS>
ZG.world.declare_object('MSTAIRS', 'MSTAIRS', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Engravings Room',
    'NORTH': ('TO', ZG.MR_ANTE, 'IF', 'SECRET_DOOR', 'IS', 'OPEN', 'ELSE', "You can't go that way."),
    'DOWN': ('TO', ZG.MR_ANTE, 'IF', 'SECRET_DOOR', 'IS', 'OPEN', 'ELSE', "You can't go that way."),
    'SW': ('TO', ZG.DAMP_PASSAGE),
    'SE': ('TO', ZG.DEAD_END),
    'FLAGS': 'RLANDBIT',
    'ACTION': ZG.MSTAIRS_F,
    'GLOBAL': (ZG.SECRET_DOOR, ZG.STAIRS),
})

# zil: 3dungeon.zil:545  <ROOM DEAD-END>
ZG.world.declare_object('DEAD_END', 'DEAD-END', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Dead End',
    'LDESC': 'You have come to the end of two adjoining passages to the west and the\nnorthwest.',
    'WEST': ('TO', ZG.DAMP_PASSAGE),
    'NW': ('TO', ZG.MSTAIRS),
    'FLAGS': 'RLANDBIT',
})

# zil: 3dungeon.zil:555  <ROOM DAMP-PASSAGE>
ZG.world.declare_object('DAMP_PASSAGE', 'DAMP-PASSAGE', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Damp Passage',
    'LDESC': 'This is a particularly damp spot even by dungeon standards. You can see\nthe junction to the west, and two similar passages to the east and northeast.\nA wide stone channel steeply descends into the room from the south. It is\ncovered with slippery moss and lichen. The channel crosses the room, but the\nopening where it once continued north is now blocked by rubble.',
    'WEST': ('TO', ZG.JUNCTION),
    'EAST': ('TO', ZG.DEAD_END),
    'NE': ('TO', ZG.MSTAIRS),
    'NORTH': 'The opening is blocked by tons of debris.',
    'UP': 'The channel is too steep and the moss too slippery.',
    'SOUTH': 'The channel is too steep and the moss too slippery.',
    'FLAGS': 'RLANDBIT',
    'GLOBAL': (ZG.MOSS, ZG.RUBBLE, ZG.WATER_CHANNEL),
})

# zil: 3dungeon.zil:573  <ROOM EAST-CORRIDOR>
ZG.world.declare_object('EAST_CORRIDOR', 'EAST-CORRIDOR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'East Corridor',
    'LDESC': 'This is a hall with polished marble walls. It widens slightly as it turns\nwest at its northern and southern ends.',
    'NORTH': ('TO', ZG.NORTH_CORRIDOR),
    'SOUTH': ('TO', ZG.SOUTH_CORRIDOR),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 3dungeon.zil:583  <ROOM WEST-CORRIDOR>
ZG.world.declare_object('WEST_CORRIDOR', 'WEST-CORRIDOR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'West Corridor',
    'LDESC': 'This is a hall with polished marble walls. It widens slightly as it turns\neast at its northern and southern ends.',
    'NORTH': ('TO', ZG.NORTH_CORRIDOR),
    'SOUTH': ('TO', ZG.SOUTH_CORRIDOR),
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 3dungeon.zil:593  <ROOM SOUTH-CORRIDOR>
ZG.world.declare_object('SOUTH_CORRIDOR', 'SOUTH-CORRIDOR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'South Corridor',
    'EAST': ('TO', ZG.EAST_CORRIDOR),
    'WEST': ('TO', ZG.WEST_CORRIDOR),
    'NORTH': ('PER', ZG.BRONZE_DOOR_EXIT),
    'SOUTH': ('TO', ZG.BEHIND_DOOR),
    'ACTION': ZG.SOUTH_CORRIDOR_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': ZG.BRONZE_DOOR,
})

# zil: 3dungeon.zil:604  <ROOM BEHIND-DOOR>
ZG.world.declare_object('BEHIND_DOOR', 'BEHIND-DOOR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Narrow Corridor',
    'NORTH': ('TO', ZG.SOUTH_CORRIDOR),
    'SOUTH': ('TO', ZG.FRONT_DOOR, 'IF', 'DUNGEON_DOOR', 'IS', 'OPEN'),
    'ACTION': ZG.BEHIND_DOOR_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.DUNGEON_DOOR, ZG.DUNGEON_PANEL),
})

# zil: 3dungeon.zil:613  <ROOM FRONT-DOOR>
ZG.world.declare_object('FRONT_DOOR', 'FRONT-DOOR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Dungeon Entrance',
    'LDESC': ' ',
    'NORTH': ('TO', ZG.BEHIND_DOOR, 'IF', 'DUNGEON_DOOR', 'IS', 'OPEN'),
    'ENTER': ('TO', ZG.BEHIND_DOOR, 'IF', 'DUNGEON_DOOR', 'IS', 'OPEN'),
    'SOUTH': ('PER', ZG.MRGO),
    'SE': ('TO', ZG.MRDE),
    'SW': ('TO', ZG.MRDW),
    'ACTION': ZG.FRONT_DOOR_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MASTER, ZG.DUNGEON_DOOR, ZG.DUNGEON_PANEL, ZG.WOODEN_WALL),
})

# zil: 3dungeon.zil:626  <OBJECT WOODEN-WALL>
ZG.world.declare_object('WOODEN_WALL', 'WOODEN-WALL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'wooden wall',
    'SYNONYM': 'WALL',
    'ADJECTIVE': ('WOOD', 'WOODEN'),
    'ACTION': ZG.WOODEN_WALL_F,
})

# zil: 3dungeon.zil:633  <ROOM NORTH-CORRIDOR>
ZG.world.declare_object('NORTH_CORRIDOR', 'NORTH-CORRIDOR', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'North Corridor',
    'LDESC': ' ',
    'EAST': ('TO', ZG.EAST_CORRIDOR),
    'WEST': ('TO', ZG.WEST_CORRIDOR),
    'NORTH': ('TO', ZG.PARAPET),
    'SOUTH': ('TO', ZG.CELL, 'IF', 'CELL_DOOR', 'IS', 'OPEN'),
    'ENTER': ('TO', ZG.CELL, 'IF', 'CELL_DOOR', 'IS', 'OPEN'),
    'ACTION': ZG.NORTH_CORRIDOR_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MASTER, ZG.CELL_DOOR, ZG.PARAPET_OBJ, ZG.FLAMING_PIT),
})

# zil: 3dungeon.zil:646  <ROOM PARAPET>
ZG.world.declare_object('PARAPET', 'PARAPET', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Parapet',
    'LDESC': ' ',
    'SOUTH': ('TO', ZG.NORTH_CORRIDOR),
    'NORTH': 'You would be burned to a crisp in no time.',
    'ACTION': ZG.PARAPET_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MASTER, ZG.PARAPET_OBJ, ZG.FLAMING_PIT),
})

# zil: 3dungeon.zil:656  <ROOM CELL>
ZG.world.declare_object('CELL', 'CELL', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Prison Cell',
    'LDESC': ' ',
    'OUT': ('TO', ZG.NORTH_CORRIDOR, 'IF', 'CELL_DOOR', 'IS', 'OPEN'),
    'NORTH': ('TO', ZG.NORTH_CORRIDOR, 'IF', 'CELL_DOOR', 'IS', 'OPEN'),
    'ACTION': ZG.CELL_ROOM,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.MASTER, ZG.BRONZE_DOOR, ZG.CELL_DOOR, ZG.PARAPET_OBJ, ZG.FLAMING_PIT),
})

# zil: 3dungeon.zil:666  <ROOM PRISON-CELL>
ZG.world.declare_object('PRISON_CELL', 'PRISON-CELL', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Prison Cell',
    'LDESC': 'You are in a bare prison cell. Its wooden door is securely fastened, and\nyou can see only flames and smoke through its small window.',
    'OUT': 'The door is securely fastened.',
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.LOCKED_DOOR, ZG.MASTER, ZG.FLAMING_PIT),
})

# zil: 3dungeon.zil:676  <ROOM GOOD-CELL>
ZG.world.declare_object('GOOD_CELL', 'GOOD-CELL', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Prison Cell',
    'LDESC': ' ',
    'OUT': ('TO', ZG.NIRVANA, 'IF', 'BRONZE_DOOR', 'IS', 'OPEN'),
    'SOUTH': ('TO', ZG.NIRVANA, 'IF', 'BRONZE_DOOR', 'IS', 'OPEN'),
    'ACTION': ZG.NCELL_ROOM,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
    'GLOBAL': (ZG.GOOD_LOCKED_DOOR, ZG.MASTER, ZG.BRONZE_DOOR, ZG.FLAMING_PIT),
})

# zil: 3dungeon.zil:686  <ROOM NIRVANA>
ZG.world.declare_object('NIRVANA', 'NIRVANA', lambda: {
    'LOC': ZG.ROOMS,
    'DESC': 'Treasury of Zork',
    'LDESC': 'This is a large room, richly appointed in a style that bespeaks exquisite\ntaste. To judge from its contents, it is the ultimate storehouse of the\nwealth of the Great Underground Empire.\n\nThere are chests containing precious jewels, mountains of\nzorkmids, rare paintings, ancient statuary, and beguiling curios.\n\nOn one wall is an annotated map of the Empire, showing the locations of\nvarious troves of treasure, and of many superior scenic views.\n\nOn a desk at the far end of the room are stock certificates\nrepresenting a controlling interest in FrobozzCo International, the\nmultinational conglomerate and parent company of\nthe Frobozz Magic Boat Co., etc.\n',
    'ACTION': ZG.NIRVANA_F,
    'FLAGS': ('RLANDBIT', 'ONBIT'),
})

# zil: 3dungeon.zil:710  <OBJECT RUNES>
ZG.world.declare_object('RUNES', 'RUNES', lambda: {
    'LOC': ZG.MSTAIRS,
    'DESC': 'runes',
    'SYNONYM': ('ENGRAV', 'TEXT', 'WALL', 'RUNES'),
    'ADJECTIVE': 'CARVED',
    'FLAGS': ('NDESCBIT', 'READBIT'),
    'ACTION': ZG.RUNES_F,
})

# zil: 3dungeon.zil:718  <OBJECT T-BAR>
ZG.world.declare_object('T_BAR', 'T-BAR', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'T-bar',
    'SYNONYM': ('T-BAR', 'BAR'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.T_BAR_F,
})

# zil: 3dungeon.zil:725  <OBJECT BLACK-PANEL>
ZG.world.declare_object('BLACK_PANEL', 'BLACK-PANEL', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'black panel',
    'SYNONYM': ('WALL', 'PANEL'),
    'ADJECTIVE': 'BLACK',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MPANELS,
})

# zil: 3dungeon.zil:733  <OBJECT BRONZE-DOOR>
ZG.world.declare_object('BRONZE_DOOR', 'BRONZE-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'bronze door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': 'BRONZE',
    'FLAGS': ('CONTBIT', 'DOORBIT', 'INVISIBLE'),
    'ACTION': ZG.BRONZE_DOOR_F,
})

# zil: 3dungeon.zil:741  <OBJECT CELL-DOOR>
ZG.world.declare_object('CELL_DOOR', 'CELL-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'cell door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('WOOD', 'WOODEN', 'CELL'),
    'FLAGS': ('CONTBIT', 'DOORBIT'),
    'ACTION': ZG.CELL_DOOR_F,
})

# zil: 3dungeon.zil:749  <OBJECT COMPASS-ARROW>
ZG.world.declare_object('COMPASS_ARROW', 'COMPASS-ARROW', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'compass arrow',
    'SYNONYM': 'ARROW',
    'ADJECTIVE': 'COMPASS',
    'FLAGS': 'NDESCBIT',
})

# zil: 3dungeon.zil:756  <OBJECT DIAL-BUTTON>
ZG.world.declare_object('DIAL_BUTTON', 'DIAL-BUTTON', lambda: {
    'LOC': ZG.PARAPET,
    'DESC': 'large button',
    'SYNONYM': 'BUTTON',
    'ADJECTIVE': 'LARGE',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.DIALBUTTON,
})

# zil: 3dungeon.zil:764  <OBJECT GOOD-LOCKED-DOOR>
ZG.world.declare_object('GOOD_LOCKED_DOOR', 'GOOD-LOCKED-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'cell door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('LOCKED', 'WOOD', 'WOODEN', 'CELL'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.LOCKED_DOOR_F,
})

# zil: 3dungeon.zil:772  <OBJECT LOCKED-DOOR>
ZG.world.declare_object('LOCKED_DOOR', 'LOCKED-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'cell door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('LOCKED', 'WOOD', 'WOODEN', 'CELL'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.LOCKED_DOOR_F,
})

# zil: 3dungeon.zil:780  <OBJECT LONG-POLE>
ZG.world.declare_object('LONG_POLE', 'LONG-POLE', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'long pole',
    'SYNONYM': 'POLE',
    'ADJECTIVE': ('LONG', 'CENTER'),
    'FLAGS': 'NDESCBIT',
})

# zil: 3dungeon.zil:787  <OBJECT MAHOGANY-PANEL>
ZG.world.declare_object('MAHOGANY_PANEL', 'MAHOGANY-PANEL', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'mahogany panel',
    'SYNONYM': ('WALL', 'PANEL'),
    'ADJECTIVE': 'MAHOGANY',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MENDS,
})

# zil: 3dungeon.zil:795  <OBJECT FLAMING-PIT>
ZG.world.declare_object('FLAMING_PIT', 'FLAMING-PIT', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'flaming pit',
    'SYNONYM': ('PIT', 'ABYSS'),
    'ADJECTIVE': ('FIERY', 'FLAMING'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.FLAMING_PIT_F,
})

# zil: 3dungeon.zil:803  <OBJECT PARAPET-OBJ>
ZG.world.declare_object('PARAPET_OBJ', 'PARAPET-OBJ', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'parapet',
    'SYNONYM': 'PARAPET',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.PARAPET_OBJ_F,
})

# zil: 3dungeon.zil:810  <OBJECT PINE-PANEL>
ZG.world.declare_object('PINE_PANEL', 'PINE-PANEL', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'pine panel',
    'SYNONYM': ('PANEL', 'WALL'),
    'ADJECTIVE': 'PINE',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MENDS,
})

# zil: 3dungeon.zil:818  <OBJECT BEAM>
ZG.world.declare_object('BEAM', 'BEAM', lambda: {
    'LOC': ZG.MREYE,
    'DESC': 'red beam of light',
    'SYNONYM': ('BEAM', 'LIGHT'),
    'ADJECTIVE': 'RED',
    'FLAGS': ('NDESCBIT', 'OPENBIT', 'CONTBIT'),
    'CAPACITY': 100,
    'ACTION': ZG.BEAM_FUNCTION,
})

# zil: 3dungeon.zil:827  <OBJECT RED-BUTTON>
ZG.world.declare_object('RED_BUTTON', 'RED-BUTTON', lambda: {
    'LOC': ZG.MR_ANTE,
    'DESC': 'red button',
    'SYNONYM': 'BUTTON',
    'ADJECTIVE': 'RED',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MRSWITCH,
})

# zil: 3dungeon.zil:835  <OBJECT RED-PANEL>
ZG.world.declare_object('RED_PANEL', 'RED-PANEL', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'red panel',
    'SYNONYM': ('PANEL', 'WALL'),
    'ADJECTIVE': 'RED',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MPANELS,
})

# zil: 3dungeon.zil:843  <OBJECT SHORT-POLE>
ZG.world.declare_object('SHORT_POLE', 'SHORT-POLE', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'short pole',
    'SYNONYM': ('POLE', 'POST', 'HANDGRIP', 'GRIP'),
    'ADJECTIVE': ('SHORT', 'SMALL', 'HAND'),
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.SHORT_POLE_F,
})

# zil: 3dungeon.zil:851  <OBJECT SUNDIAL>
ZG.world.declare_object('SUNDIAL', 'SUNDIAL', lambda: {
    'LOC': ZG.PARAPET,
    'DESC': 'sundial',
    'SYNONYM': ('DIAL', 'INDICATOR', 'ARROW', 'SUNDIAL'),
    'ADJECTIVE': ('INDICATOR', 'SUN'),
    'FLAGS': ('NDESCBIT', 'TURNBIT'),
    'ACTION': ZG.DIAL,
})

# zil: 3dungeon.zil:859  <OBJECT YELLOW-PANEL>
ZG.world.declare_object('YELLOW_PANEL', 'YELLOW-PANEL', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'yellow panel',
    'SYNONYM': ('PANEL', 'WALL'),
    'ADJECTIVE': 'YELLOW',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MPANELS,
})

# zil: 3dungeon.zil:867  <OBJECT WHITE-PANEL>
ZG.world.declare_object('WHITE_PANEL', 'WHITE-PANEL', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'white panel',
    'SYNONYM': ('PANEL', 'WALL'),
    'ADJECTIVE': 'WHITE',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.MPANELS,
})

# zil: 3dungeon.zil:875  <OBJECT WOODEN-BAR>
ZG.world.declare_object('WOODEN_BAR', 'WOODEN-BAR', lambda: {
    'LOC': ZG.IN_MIRROR,
    'DESC': 'wooden bar',
    'SYNONYM': 'BAR',
    'ADJECTIVE': ('WOOD', 'WOODEN'),
    'FLAGS': 'NDESCBIT',
})

# zil: 3dungeon.zil:882  <OBJECT DUNGEON-PANEL>
ZG.world.declare_object('DUNGEON_PANEL', 'DUNGEON-PANEL', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'panel',
    'SYNONYM': 'PANEL',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.DUNGEON_PANEL_F,
})

# zil: 3dungeon.zil:889  <OBJECT DUNGEON-DOOR>
ZG.world.declare_object('DUNGEON_DOOR', 'DUNGEON-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'wooden door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': ('WOOD', 'WOODEN'),
    'FLAGS': ('NDESCBIT', 'DOORBIT', 'CONTBIT'),
    'ACTION': ZG.DUNGEON_DOOR_F,
})

# zil: 3dungeon.zil:897  <OBJECT SECRET-DOOR>
ZG.world.declare_object('SECRET_DOOR', 'SECRET-DOOR', lambda: {
    'LOC': ZG.LOCAL_GLOBALS,
    'DESC': 'secret door',
    'SYNONYM': 'DOOR',
    'ADJECTIVE': 'SECRET',
    'FLAGS': ('DOORBIT', 'CONTBIT', 'INVISIBLE'),
    'ACTION': ZG.SECRET_DOOR_F,
})

# zil: 3dungeon.zil:905  <OBJECT OLD-MAN>
ZG.world.declare_object('OLD_MAN', 'OLD-MAN', lambda: {
    'DESC': 'old man',
    'SYNONYM': 'MAN',
    'ADJECTIVE': 'OLD',
    'FLAGS': 'ACTORBIT',
    'ACTION': ZG.OLD_MAN_F,
    'DESCFCN': ZG.OLD_MAN_F,
})

# zil: 3dungeon.zil:913  <OBJECT CP-HOLE>
ZG.world.declare_object('CP_HOLE', 'CP-HOLE', lambda: {
    'LOC': ZG.CP_ANTE,
    'DESC': 'hole',
    'SYNONYM': 'HOLE',
    'ADJECTIVE': 'ROUND',
    'FLAGS': 'NDESCBIT',
    'ACTION': ZG.CP_HOLE_F,
})

# zil: 3dungeon.zil:921  <ROUTINE GO ()>
@ZG.routine('GO')
def GO():
    while True:
        # ;"put interrupts on clock chain"
        ZG.QUEUE(ZG.I_LANTERN, 200)
        # ;"clean up junk compiler can't do"
        ZG.CURRENT_LAMP = ZG.LAMP
        PUT(ZG.CPOBJS, (8 * 21), 1)
        PUT(ZG.CPOBJS, ((8 * 21) + 1), ZG.LORE_BOOK)
        PUT(ZG.CPOBJS, (8 * 32), 1)
        PUT(ZG.CPOBJS, ((8 * 32) + 1), ZG.CP_SLOT)
        # ;"set up and go"
        ZG.LIT = True
        ZG.WINNER = ZG.ADVENTURER
        ZG.PLAYER = ZG.WINNER
        ZG.MLOC = ZG.MRB
        ZG.HERE = ZG.ZORK2_STAIR
        MOVE(ZG.WINNER, ZG.HERE)
        # ;<ENABLE <QUEUE I-CLEFT <+ 70 <RANDOM 70>>>>
        ENABLE(ZG.QUEUE(ZG.I_VIEW_CHANGE, 4))
        ZG.P_IT_OBJECT = False
        if (not FSET_p(ZG.HERE, Flag('TOUCHBIT'))):
            TELL('As in a dream, you see yourself tumbling down a great, dark staircase.\nAll about you are shadowy images of struggles against fierce opponents\nand diabolical traps. These give way to another round of images: of\nimposing stone figures, a cool, clear lake, and, now, of an old, yet\noddly youthful man. He turns toward you slowly, his long, silver hair\ndancing about him in a fresh breeze. "You have reached the final test,\nmy friend! You are proved clever and powerful, but this is not yet\nenough! Seek me when you feel yourself worthy!" The dream dissolves\naround you as his last words echo through the void....', CR)
            CRLF()
            ZG.V_VERSION()
            CRLF()
        MOVE(ZG.WINNER, ZG.HERE)
        MOVE(ZG.LAMP, ZG.HERE)
        ZG.V_LOOK()
        ZG.MAIN_LOOP()
        continue
        break

# zil: 3dungeon.zil:960  <GLOBAL CLEFT-QUEUED?>
# GLOBAL (state) CLEFT_QUEUED_p = False  ->  ZilGlobal.py
