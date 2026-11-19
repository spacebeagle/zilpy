-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

do local _ = ZG.DIRECTIONS("NORTH", "EAST", "WEST", "SOUTH", "NE", "NW", "SE", "SW", "UP", "DOWN", "IN", "OUT", "LAND", "CROSS") end

-- zil: 3dungeon.zil:11  <OBJECT RUBBLE>
ZG._declare("RUBBLE", function() return ZG._declare_object("RUBBLE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"ROCK", "ROCKS", "BOULDER", "RUBBLE"},
    ["DESC"] = "rubble",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3dungeon.zil:17  <OBJECT DEBRIS>
ZG._declare("DEBRIS", function() return ZG._declare_object("DEBRIS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"DUST", "DEBRIS"},
    ["DESC"] = "dust and debris",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3dungeon.zil:23  <OBJECT CHASM>
ZG._declare("CHASM", function() return ZG._declare_object("CHASM", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"CHASM", "GORGE", "RAVINE"},
    ["ADJECTIVE"] = {"ROCKY", "DEEP"},
    ["DESC"] = "chasm",
    ["ACTION"] = ZG.CHASM_FCN,
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3dungeon.zil:31  <OBJECT TUNNEL>
ZG._declare("TUNNEL", function() return ZG._declare_object("TUNNEL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"PASSAGE", "CRAWLWAY"},
    ["ADJECTIVE"] = {"DARK", "SMOKY"},
    ["DESC"] = "tunnel",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.TUNNEL_OBJECT,
} end) end, true)

-- zil: 3dungeon.zil:39  <OBJECT EAST-WALL>
ZG._declare("EAST_WALL", function() return ZG._declare_object("EAST-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"EAST", "EASTERN"},
    ["DESC"] = "eastern wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.RANDOM_WALL,
} end) end, true)

-- zil: 3dungeon.zil:47  <OBJECT SOUTH-WALL>
ZG._declare("SOUTH_WALL", function() return ZG._declare_object("SOUTH-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"SOUTH", "SOUTHE"},
    ["DESC"] = "southern wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.RANDOM_WALL,
} end) end, true)

-- zil: 3dungeon.zil:55  <OBJECT WEST-WALL>
ZG._declare("WEST_WALL", function() return ZG._declare_object("WEST-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"WEST", "WESTERN"},
    ["DESC"] = "western wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.RANDOM_WALL,
} end) end, true)

-- zil: 3dungeon.zil:63  <OBJECT NORTH-WALL>
ZG._declare("NORTH_WALL", function() return ZG._declare_object("NORTH-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"NORTH", "NORTHE"},
    ["DESC"] = "northern wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.RANDOM_WALL,
} end) end, true)

-- zil: 3dungeon.zil:71  <OBJECT GLOBAL-WATER>
ZG._declare("GLOBAL_WATER", function() return ZG._declare_object("GLOBAL-WATER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"WATER", "QUANTITY"},
    ["DESC"] = "water",
    ["FLAGS"] = "DRINKBIT",
    ["ACTION"] = ZG.WATER_FCN,
} end) end, true)

-- zil: 3dungeon.zil:78  <OBJECT WATER>
ZG._declare("WATER", function() return ZG._declare_object("WATER", function() return {
    ["SYNONYM"] = {"WATER", "QUANTITY", "LIQUID", "H2O"},
    ["DESC"] = "quantity of water",
    ["FLAGS"] = {"TAKEBIT", "DRINKBIT"},
    ["ACTION"] = ZG.WATER_FCN,
    ["LDESC"] = "There is some water here.",
    ["SIZE"] = 4,
} end) end, true)

-- zil: 3dungeon.zil:86  <OBJECT BROKEN-LAMP>
ZG._declare("BROKEN_LAMP", function() return ZG._declare_object("BROKEN-LAMP", function() return {
    ["SYNONYM"] = {"LAMP", "LANTERN"},
    ["ADJECTIVE"] = {"BROKEN", "BRASS"},
    ["DESC"] = "broken lantern",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 15,
} end) end, true)

-- zil: 3dungeon.zil:93  <OBJECT LAMP>
ZG._declare("LAMP", function() return ZG._declare_object("LAMP", function() return {
    ["LOC"] = ZG.CP_ANTE,
    ["SYNONYM"] = {"LAMP", "LANTERN"},
    ["ADJECTIVE"] = "BRASS",
    ["DESC"] = "lamp",
    ["FLAGS"] = {"TAKEBIT", "LIGHTBIT"},
    ["FDESC"] = "Your old friend, the brass lantern, is at your feet.",
    ["ACTION"] = ZG.LANTERN,
    ["SIZE"] = 15,
} end) end, true)

-- zil: 3dungeon.zil:103  <OBJECT SWORD>
ZG._declare("SWORD", function() return ZG._declare_object("SWORD", function() return {
    ["LOC"] = ZG.STONE,
    ["SYNONYM"] = {"SWORD", "ORCRIST", "GLAMDRING", "BLADE"},
    ["ADJECTIVE"] = {"ELVISH", "OLD", "ANTIQUE"},
    ["DESC"] = "sword",
    ["FLAGS"] = {"TAKEBIT", "WEAPONBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.SWORD_FCN,
    ["SIZE"] = 25,
    ["VALUE"] = 0,
} end) end, true)

-- zil: 3dungeon.zil:115  <ROOM CP-ANTE>
ZG._declare("CP_ANTE", function() return ZG._declare_object("CP-ANTE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Royal Puzzle Entrance",
    ["WEST"] = {"TO", ZG.CP_OUT},
    ["NORTH"] = {"TO", ZG.MUSEUM_ENTRANCE},
    ["UP"] = {"TO", ZG.MUSEUM_ENTRANCE},
    ["DOWN"] = {"PER", ZG.CPENTER},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.CPANT_ROOM,
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 3dungeon.zil:126  <ROOM CP-OUT>
ZG._declare("CP_OUT", function() return ZG._declare_object("CP-OUT", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Side Room",
    ["NORTH"] = {"TO", ZG.CP_ANTE},
    ["UP"] = {"TO", ZG.CP_ANTE},
    ["EAST"] = {"TO", ZG.CP, "IF", "CP_FLAG", "ELSE", "The steel door is closed."},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.CPOUT_ROOM,
    ["GLOBAL"] = {ZG.CPDOOR, ZG.STAIRS},
} end) end, true)

-- zil: 3dungeon.zil:136  <ROOM CP>
ZG._declare("CP", function() return ZG._declare_object("CP", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Room in a Puzzle",
    ["NORTH"] = {"PER", ZG.CPEXIT},
    ["SOUTH"] = {"PER", ZG.CPEXIT},
    ["EAST"] = {"PER", ZG.CPEXIT},
    ["WEST"] = {"PER", ZG.CPEXIT},
    ["NE"] = {"PER", ZG.CPEXIT},
    ["NW"] = {"PER", ZG.CPEXIT},
    ["SE"] = {"PER", ZG.CPEXIT},
    ["UP"] = {"PER", ZG.CPEXIT},
    ["SW"] = {"PER", ZG.CPEXIT},
    ["ACTION"] = ZG.CP_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.CPLADDER, ZG.CPDOOR, ZG.CPEWL, ZG.CPWWL, ZG.CPNWL, ZG.CPSWL},
} end) end, true)

-- ;"SUBTITLE CHINESE PUZZLE OBJECTS"

-- zil: 3dungeon.zil:154  <OBJECT WARNING-NOTE>
ZG._declare("WARNING_NOTE", function() return ZG._declare_object("WARNING-NOTE", function() return {
    ["LOC"] = ZG.CP_ANTE,
    ["DESC"] = "warning note",
    ["SYNONYM"] = {"NOTE", "WARNING", "TEXT"},
    ["ADJECTIVE"] = {"WARNING", "SMALL"},
    ["FDESC"] = "Lying on the ground is a small note of some kind.",
    ["FLAGS"] = {"TAKEBIT", "READBIT", "BURNBIT"},
    ["SIZE"] = 2,
    ["TEXT"] = "Warning:\n    The Royal Puzzle is dangerous and it is possible to become\ntrapped within its confines. Please do not enter the puzzle after hours\nwhen museum personnel are not present.\n              The Management",
} end) end, true)

-- zil: 3dungeon.zil:169  <OBJECT CP-SLOT>
ZG._declare("CP_SLOT", function() return ZG._declare_object("CP-SLOT", function() return {
    ["SYNONYM"] = {"CPSLT", "SLIT", "SLOT"},
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "small slot",
    ["FLAGS"] = {"NDESCBIT", "OPENBIT"},
    ["ACTION"] = ZG.CP_SLOT_FCN,
    ["CAPACITY"] = 4,
} end) end, true)

-- zil: 3dungeon.zil:177  <OBJECT CPDOOR>
ZG._declare("CPDOOR", function() return ZG._declare_object("CPDOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"STEEL", "METAL"},
    ["DESC"] = "steel door",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CPDOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:185  <OBJECT LORE-BOOK>
ZG._declare("LORE_BOOK", function() return ZG._declare_object("LORE-BOOK", function() return {
    ["SYNONYM"] = {"BOOK", "LORE", "TEXT"},
    ["ADJECTIVE"] = {"LORE", "OLD", "STRANGE"},
    ["DESC"] = "very ancient book",
    ["FLAGS"] = {"TAKEBIT", "READBIT"},
    ["LDESC"] = "There is an old book here.",
    ["FDESC"] = "Nestled inside the niche is an old and dusty book.",
    ["TEXT"] = "The book is written in a strong and elegant hand and is full of strange,\nwondrous pictures. The text, penned in many colours, is in a tongue unknown\nto you. The words seem to change colour as you read them.\nThe book itself is very old and the pages dry and brittle.",
    ["SIZE"] = 4,
    ["ACTION"] = ZG.LORE_BOOK_F,
} end) end, true)

-- zil: 3dungeon.zil:202  <GLOBAL CP-FLAG>
-- CP_FLAG is declared in ZilGlobal.lua

-- zil: 3dungeon.zil:204  <OBJECT CPEWL>
ZG._declare("CPEWL", function() return ZG._declare_object("CPEWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"EAST", "EASTERN"},
    ["DESC"] = "eastern wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CPWALL_OBJECT,
} end) end, true)

-- zil: 3dungeon.zil:212  <OBJECT CPWWL>
ZG._declare("CPWWL", function() return ZG._declare_object("CPWWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"WEST", "WESTERN"},
    ["DESC"] = "western wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CPWALL_OBJECT,
} end) end, true)

-- zil: 3dungeon.zil:220  <OBJECT CPSWL>
ZG._declare("CPSWL", function() return ZG._declare_object("CPSWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = "SOUTH",
    ["DESC"] = "southern wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CPWALL_OBJECT,
} end) end, true)

-- zil: 3dungeon.zil:228  <OBJECT CPNWL>
ZG._declare("CPNWL", function() return ZG._declare_object("CPNWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = "NORTH",
    ["DESC"] = "northern wall",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CPWALL_OBJECT,
} end) end, true)

-- zil: 3dungeon.zil:236  <OBJECT CPLADDER>
ZG._declare("CPLADDER", function() return ZG._declare_object("CPLADDER", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "LADDER",
    ["DESC"] = "ladder",
    ["ACTION"] = ZG.CPLADDER_OBJECT,
} end) end, true)

-- ;"Objects/rooms for old end-game"

-- zil: 3dungeon.zil:244  <OBJECT INTDIR>
ZG._declare("INTDIR", function() return ZG._declare_object("INTDIR", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "INTDIR",
    ["FLAGS"] = "TOOLBIT",
    ["DESC"] = "direction",
} end) end, true)

-- zil: 3dungeon.zil:250  <OBJECT GUARDIAN>
ZG._declare("GUARDIAN", function() return ZG._declare_object("GUARDIAN", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "Guardians of Zork",
    ["SYNONYM"] = {"STATUE", "GUARDIAN", "GUARD", "GUARDS"},
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.GUARDIANS,
} end) end, true)

-- zil: 3dungeon.zil:257  <OBJECT ROSE>
ZG._declare("ROSE", function() return ZG._declare_object("ROSE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "compass rose",
    ["SYNONYM"] = "ROSE",
    ["ADJECTIVE"] = "COMPASS",
    ["ACTION"] = ZG.ROSE_F,
} end) end, true)

-- zil: 3dungeon.zil:264  <OBJECT MASTER>
ZG._declare("MASTER", function() return ZG._declare_object("MASTER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "dungeon master",
    ["SYNONYM"] = {"MASTER", "MAN"},
    ["ADJECTIVE"] = "DUNGEON",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.MASTER_F,
} end) end, true)

-- zil: 3dungeon.zil:272  <OBJECT DUNGEON-MASTER>
ZG._declare("DUNGEON_MASTER", function() return ZG._declare_object("DUNGEON-MASTER", function() return {
    ["LOC"] = ZG.BEHIND_DOOR,
    ["DESC"] = "dungeon master",
    ["LDESC"] = "The dungeon master is quietly leaning on his staff here.",
    ["SYNONYM"] = {"MASTER", "DUNGEON", "MAN"},
    ["ADJECTIVE"] = "DUNGEON",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.DUNGEON_MASTER_F,
} end) end, true)

-- zil: 3dungeon.zil:282  <OBJECT MIRROR>
ZG._declare("MIRROR", function() return ZG._declare_object("MIRROR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "mirror",
    ["SYNONYM"] = {"MIRROR", "STRUCTURE"},
    ["ACTION"] = ZG.MIRROR_FUNCTION,
} end) end, true)

-- zil: 3dungeon.zil:288  <OBJECT PANEL>
ZG._declare("PANEL", function() return ZG._declare_object("PANEL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "panel",
    ["SYNONYM"] = "PANEL",
    ["ACTION"] = ZG.PANEL_FUNCTION,
} end) end, true)

-- zil: 3dungeon.zil:294  <OBJECT CHANNEL>
ZG._declare("CHANNEL", function() return ZG._declare_object("CHANNEL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "stone channel",
    ["SYNONYM"] = {"CHANNEL", "HOLE"},
    ["ADJECTIVE"] = "STONE",
} end) end, true)

-- zil: 3dungeon.zil:300  <ROOM MRD>
ZG._declare("MRD", function() return ZG._declare_object("MRD", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Hallway",
    ["LDESC"] = " ",
    ["NORTH"] = {"TO", ZG.FRONT_DOOR},
    ["NE"] = {"TO", ZG.FRONT_DOOR},
    ["NW"] = {"TO", ZG.FRONT_DOOR},
    ["SOUTH"] = {"PER", ZG.MRGO},
    ["SE"] = {"PER", ZG.MRGO},
    ["SW"] = {"PER", ZG.MRGO},
    ["ACTION"] = ZG.MRDF,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.ROSE, ZG.CHANNEL, ZG.GUARDIAN, ZG.WOODEN_WALL},
} end) end, true)

-- zil: 3dungeon.zil:314  <ROOM MRG>
ZG._declare("MRG", function() return ZG._declare_object("MRG", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Hallway",
    ["LDESC"] = " ",
    ["NORTH"] = {"PER", ZG.MRGO},
    ["NW"] = {"PER", ZG.MRGO},
    ["NE"] = {"PER", ZG.MRGO},
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["SOUTH"] = {"PER", ZG.MRGO},
    ["SW"] = {"PER", ZG.MRGO},
    ["SE"] = {"PER", ZG.MRGO},
    ["ACTION"] = ZG.GUARDIANS,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.GUARDIAN,
} end) end, true)

-- zil: 3dungeon.zil:329  <ROOM MRC>
ZG._declare("MRC", function() return ZG._declare_object("MRC", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Hallway",
    ["LDESC"] = " ",
    ["NORTH"] = {"PER", ZG.MRGO},
    ["NW"] = {"PER", ZG.MRGO},
    ["NE"] = {"PER", ZG.MRGO},
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["SOUTH"] = {"PER", ZG.MRGO},
    ["SW"] = {"PER", ZG.MRGO},
    ["SE"] = {"PER", ZG.MRGO},
    ["ACTION"] = ZG.MRCF,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.ROSE, ZG.CHANNEL, ZG.GUARDIAN, ZG.WOODEN_WALL},
} end) end, true)

-- zil: 3dungeon.zil:344  <ROOM MRB>
ZG._declare("MRB", function() return ZG._declare_object("MRB", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Hallway",
    ["LDESC"] = " ",
    ["NORTH"] = {"PER", ZG.MRGO},
    ["NW"] = {"PER", ZG.MRGO},
    ["NE"] = {"PER", ZG.MRGO},
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["SOUTH"] = {"PER", ZG.MRGO},
    ["SW"] = {"PER", ZG.MRGO},
    ["SE"] = {"PER", ZG.MRGO},
    ["ACTION"] = ZG.MRBF,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.ROSE, ZG.CHANNEL, ZG.WOODEN_WALL},
} end) end, true)

-- zil: 3dungeon.zil:359  <ROOM MRA>
ZG._declare("MRA", function() return ZG._declare_object("MRA", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Hallway",
    ["LDESC"] = " ",
    ["NORTH"] = {"PER", ZG.MRGO},
    ["NW"] = {"PER", ZG.MRGO},
    ["NE"] = {"PER", ZG.MRGO},
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["SOUTH"] = {"TO", ZG.MREYE},
    ["ACTION"] = ZG.MRAF,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.ROSE, ZG.CHANNEL, ZG.WOODEN_WALL},
} end) end, true)

-- zil: 3dungeon.zil:372  <ROOM MRDE>
ZG._declare("MRDE", function() return ZG._declare_object("MRDE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["WEST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.FRONT_DOOR},
    ["SOUTH"] = {"TO", ZG.MRG},
    ["ACTION"] = ZG.MRDEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:384  <ROOM MRDW>
ZG._declare("MRDW", function() return ZG._declare_object("MRDW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["WEST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.FRONT_DOOR},
    ["SOUTH"] = {"TO", ZG.MRG},
    ["ACTION"] = ZG.MRDEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:396  <ROOM MRGE>
ZG._declare("MRGE", function() return ZG._declare_object("MRGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["WEST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRD},
    ["SOUTH"] = {"TO", ZG.MRC},
    ["ACTION"] = ZG.GUARDIANS,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:408  <ROOM MRGW>
ZG._declare("MRGW", function() return ZG._declare_object("MRGW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["EAST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRD},
    ["SOUTH"] = {"TO", ZG.MRC},
    ["ACTION"] = ZG.GUARDIANS,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:420  <ROOM MRCE>
ZG._declare("MRCE", function() return ZG._declare_object("MRCE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["WEST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRG},
    ["SOUTH"] = {"TO", ZG.MRB},
    ["ACTION"] = ZG.MRCEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:432  <ROOM MRCW>
ZG._declare("MRCW", function() return ZG._declare_object("MRCW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["EAST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRG},
    ["SOUTH"] = {"TO", ZG.MRB},
    ["ACTION"] = ZG.MRCEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:444  <ROOM MRBE>
ZG._declare("MRBE", function() return ZG._declare_object("MRBE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["WEST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRC},
    ["SOUTH"] = {"TO", ZG.MRA},
    ["ACTION"] = ZG.MRBEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:456  <ROOM MRBW>
ZG._declare("MRBW", function() return ZG._declare_object("MRBW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["EAST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRC},
    ["SOUTH"] = {"TO", ZG.MRA},
    ["ACTION"] = ZG.MRBEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:468  <ROOM MRAE>
ZG._declare("MRAE", function() return ZG._declare_object("MRAE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["WEST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRB},
    ["SOUTH"] = {"TO", ZG.MREYE},
    ["ACTION"] = ZG.MRAEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:480  <ROOM MRAW>
ZG._declare("MRAW", function() return ZG._declare_object("MRAW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Room",
    ["LDESC"] = " ",
    ["ENTER"] = {"PER", ZG.MIRIN},
    ["EAST"] = {"PER", ZG.MIRIN},
    ["NORTH"] = {"TO", ZG.MRB},
    ["SOUTH"] = {"TO", ZG.MREYE},
    ["ACTION"] = ZG.MRAEW,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MIRROR, ZG.PANEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:492  <ROOM IN-MIRROR>
ZG._declare("IN_MIRROR", function() return ZG._declare_object("IN-MIRROR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Inside Mirror",
    ["LDESC"] = " ",
    ["OUT"] = {"PER", ZG.MIROUT},
    ["NORTH"] = {"PER", ZG.MIROUT},
    ["SOUTH"] = {"PER", ZG.MIROUT},
    ["NW"] = {"PER", ZG.MIROUT},
    ["NE"] = {"PER", ZG.MIROUT},
    ["SE"] = {"PER", ZG.MIROUT},
    ["SW"] = {"PER", ZG.MIROUT},
    ["WEST"] = {"PER", ZG.MIROUT},
    ["EAST"] = {"PER", ZG.MIROUT},
    ["ACTION"] = ZG.MAGIC_MIRROR,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.ROSE, ZG.CHANNEL, ZG.GUARDIAN},
} end) end, true)

-- zil: 3dungeon.zil:509  <ROOM MR-ANTE>
ZG._declare("MR_ANTE", function() return ZG._declare_object("MR-ANTE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Button Room",
    ["LDESC"] = "You are at the southern end of a long hall. To the south, stairs ascend\ninto darkness. To the north the corridor is illuminated by torches set\nhigh in the walls, out of reach. On one wall is a red button.",
    ["SOUTH"] = {"TO", ZG.MSTAIRS, "IF", "SECRET_DOOR", "IS", "OPEN"},
    ["UP"] = {"TO", ZG.MSTAIRS, "IF", "SECRET_DOOR", "IS", "OPEN"},
    ["NORTH"] = {"TO", ZG.MREYE},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.SECRET_DOOR, ZG.STAIRS},
    ["PSEUDO"] = {"TORCH", ZG.TORCH_PSEUDO, "TORCHE", ZG.TORCH_PSEUDO},
} end) end, true)

-- zil: 3dungeon.zil:523  <ROOM MREYE>
ZG._declare("MREYE", function() return ZG._declare_object("MREYE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Beam Room",
    ["LDESC"] = " ",
    ["NORTH"] = {"PER", ZG.MRGO},
    ["NW"] = {"PER", ZG.MRGO},
    ["NE"] = {"PER", ZG.MRGO},
    ["SOUTH"] = {"TO", ZG.MR_ANTE},
    ["ACTION"] = ZG.MREYE_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 3dungeon.zil:534  <ROOM MSTAIRS>
ZG._declare("MSTAIRS", function() return ZG._declare_object("MSTAIRS", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Engravings Room",
    ["NORTH"] = {"TO", ZG.MR_ANTE, "IF", "SECRET_DOOR", "IS", "OPEN", "ELSE", "You can't go that way."},
    ["DOWN"] = {"TO", ZG.MR_ANTE, "IF", "SECRET_DOOR", "IS", "OPEN", "ELSE", "You can't go that way."},
    ["SW"] = {"TO", ZG.DAMP_PASSAGE},
    ["SE"] = {"TO", ZG.DEAD_END},
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.MSTAIRS_F,
    ["GLOBAL"] = {ZG.SECRET_DOOR, ZG.STAIRS},
} end) end, true)

-- zil: 3dungeon.zil:545  <ROOM DEAD-END>
ZG._declare("DEAD_END", function() return ZG._declare_object("DEAD-END", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to the end of two adjoining passages to the west and the\nnorthwest.",
    ["WEST"] = {"TO", ZG.DAMP_PASSAGE},
    ["NW"] = {"TO", ZG.MSTAIRS},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3dungeon.zil:555  <ROOM DAMP-PASSAGE>
ZG._declare("DAMP_PASSAGE", function() return ZG._declare_object("DAMP-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Damp Passage",
    ["LDESC"] = "This is a particularly damp spot even by dungeon standards. You can see\nthe junction to the west, and two similar passages to the east and northeast.\nA wide stone channel steeply descends into the room from the south. It is\ncovered with slippery moss and lichen. The channel crosses the room, but the\nopening where it once continued north is now blocked by rubble.",
    ["WEST"] = {"TO", ZG.JUNCTION},
    ["EAST"] = {"TO", ZG.DEAD_END},
    ["NE"] = {"TO", ZG.MSTAIRS},
    ["NORTH"] = "The opening is blocked by tons of debris.",
    ["UP"] = "The channel is too steep and the moss too slippery.",
    ["SOUTH"] = "The channel is too steep and the moss too slippery.",
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.MOSS, ZG.RUBBLE, ZG.WATER_CHANNEL},
} end) end, true)

-- zil: 3dungeon.zil:573  <ROOM EAST-CORRIDOR>
ZG._declare("EAST_CORRIDOR", function() return ZG._declare_object("EAST-CORRIDOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "East Corridor",
    ["LDESC"] = "This is a hall with polished marble walls. It widens slightly as it turns\nwest at its northern and southern ends.",
    ["NORTH"] = {"TO", ZG.NORTH_CORRIDOR},
    ["SOUTH"] = {"TO", ZG.SOUTH_CORRIDOR},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 3dungeon.zil:583  <ROOM WEST-CORRIDOR>
ZG._declare("WEST_CORRIDOR", function() return ZG._declare_object("WEST-CORRIDOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "West Corridor",
    ["LDESC"] = "This is a hall with polished marble walls. It widens slightly as it turns\neast at its northern and southern ends.",
    ["NORTH"] = {"TO", ZG.NORTH_CORRIDOR},
    ["SOUTH"] = {"TO", ZG.SOUTH_CORRIDOR},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 3dungeon.zil:593  <ROOM SOUTH-CORRIDOR>
ZG._declare("SOUTH_CORRIDOR", function() return ZG._declare_object("SOUTH-CORRIDOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "South Corridor",
    ["EAST"] = {"TO", ZG.EAST_CORRIDOR},
    ["WEST"] = {"TO", ZG.WEST_CORRIDOR},
    ["NORTH"] = {"PER", ZG.BRONZE_DOOR_EXIT},
    ["SOUTH"] = {"TO", ZG.BEHIND_DOOR},
    ["ACTION"] = ZG.SOUTH_CORRIDOR_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.BRONZE_DOOR,
} end) end, true)

-- zil: 3dungeon.zil:604  <ROOM BEHIND-DOOR>
ZG._declare("BEHIND_DOOR", function() return ZG._declare_object("BEHIND-DOOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Narrow Corridor",
    ["NORTH"] = {"TO", ZG.SOUTH_CORRIDOR},
    ["SOUTH"] = {"TO", ZG.FRONT_DOOR, "IF", "DUNGEON_DOOR", "IS", "OPEN"},
    ["ACTION"] = ZG.BEHIND_DOOR_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.DUNGEON_DOOR, ZG.DUNGEON_PANEL},
} end) end, true)

-- zil: 3dungeon.zil:613  <ROOM FRONT-DOOR>
ZG._declare("FRONT_DOOR", function() return ZG._declare_object("FRONT-DOOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dungeon Entrance",
    ["LDESC"] = " ",
    ["NORTH"] = {"TO", ZG.BEHIND_DOOR, "IF", "DUNGEON_DOOR", "IS", "OPEN"},
    ["ENTER"] = {"TO", ZG.BEHIND_DOOR, "IF", "DUNGEON_DOOR", "IS", "OPEN"},
    ["SOUTH"] = {"PER", ZG.MRGO},
    ["SE"] = {"TO", ZG.MRDE},
    ["SW"] = {"TO", ZG.MRDW},
    ["ACTION"] = ZG.FRONT_DOOR_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MASTER, ZG.DUNGEON_DOOR, ZG.DUNGEON_PANEL, ZG.WOODEN_WALL},
} end) end, true)

-- zil: 3dungeon.zil:626  <OBJECT WOODEN-WALL>
ZG._declare("WOODEN_WALL", function() return ZG._declare_object("WOODEN-WALL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "wooden wall",
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"WOOD", "WOODEN"},
    ["ACTION"] = ZG.WOODEN_WALL_F,
} end) end, true)

-- zil: 3dungeon.zil:633  <ROOM NORTH-CORRIDOR>
ZG._declare("NORTH_CORRIDOR", function() return ZG._declare_object("NORTH-CORRIDOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "North Corridor",
    ["LDESC"] = " ",
    ["EAST"] = {"TO", ZG.EAST_CORRIDOR},
    ["WEST"] = {"TO", ZG.WEST_CORRIDOR},
    ["NORTH"] = {"TO", ZG.PARAPET},
    ["SOUTH"] = {"TO", ZG.CELL, "IF", "CELL_DOOR", "IS", "OPEN"},
    ["ENTER"] = {"TO", ZG.CELL, "IF", "CELL_DOOR", "IS", "OPEN"},
    ["ACTION"] = ZG.NORTH_CORRIDOR_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MASTER, ZG.CELL_DOOR, ZG.PARAPET_OBJ, ZG.FLAMING_PIT},
} end) end, true)

-- zil: 3dungeon.zil:646  <ROOM PARAPET>
ZG._declare("PARAPET", function() return ZG._declare_object("PARAPET", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Parapet",
    ["LDESC"] = " ",
    ["SOUTH"] = {"TO", ZG.NORTH_CORRIDOR},
    ["NORTH"] = "You would be burned to a crisp in no time.",
    ["ACTION"] = ZG.PARAPET_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MASTER, ZG.PARAPET_OBJ, ZG.FLAMING_PIT},
} end) end, true)

-- zil: 3dungeon.zil:656  <ROOM CELL>
ZG._declare("CELL", function() return ZG._declare_object("CELL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Prison Cell",
    ["LDESC"] = " ",
    ["OUT"] = {"TO", ZG.NORTH_CORRIDOR, "IF", "CELL_DOOR", "IS", "OPEN"},
    ["NORTH"] = {"TO", ZG.NORTH_CORRIDOR, "IF", "CELL_DOOR", "IS", "OPEN"},
    ["ACTION"] = ZG.CELL_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.MASTER, ZG.BRONZE_DOOR, ZG.CELL_DOOR, ZG.PARAPET_OBJ, ZG.FLAMING_PIT},
} end) end, true)

-- zil: 3dungeon.zil:666  <ROOM PRISON-CELL>
ZG._declare("PRISON_CELL", function() return ZG._declare_object("PRISON-CELL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Prison Cell",
    ["LDESC"] = "You are in a bare prison cell. Its wooden door is securely fastened, and\nyou can see only flames and smoke through its small window.",
    ["OUT"] = "The door is securely fastened.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.LOCKED_DOOR, ZG.MASTER, ZG.FLAMING_PIT},
} end) end, true)

-- zil: 3dungeon.zil:676  <ROOM GOOD-CELL>
ZG._declare("GOOD_CELL", function() return ZG._declare_object("GOOD-CELL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Prison Cell",
    ["LDESC"] = " ",
    ["OUT"] = {"TO", ZG.NIRVANA, "IF", "BRONZE_DOOR", "IS", "OPEN"},
    ["SOUTH"] = {"TO", ZG.NIRVANA, "IF", "BRONZE_DOOR", "IS", "OPEN"},
    ["ACTION"] = ZG.NCELL_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.GOOD_LOCKED_DOOR, ZG.MASTER, ZG.BRONZE_DOOR, ZG.FLAMING_PIT},
} end) end, true)

-- zil: 3dungeon.zil:686  <ROOM NIRVANA>
ZG._declare("NIRVANA", function() return ZG._declare_object("NIRVANA", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Treasury of Zork",
    ["LDESC"] = "This is a large room, richly appointed in a style that bespeaks exquisite\ntaste. To judge from its contents, it is the ultimate storehouse of the\nwealth of the Great Underground Empire.\n\nThere are chests containing precious jewels, mountains of\nzorkmids, rare paintings, ancient statuary, and beguiling curios.\n\nOn one wall is an annotated map of the Empire, showing the locations of\nvarious troves of treasure, and of many superior scenic views.\n\nOn a desk at the far end of the room are stock certificates\nrepresenting a controlling interest in FrobozzCo International, the\nmultinational conglomerate and parent company of\nthe Frobozz Magic Boat Co., etc.\n",
    ["ACTION"] = ZG.NIRVANA_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 3dungeon.zil:710  <OBJECT RUNES>
ZG._declare("RUNES", function() return ZG._declare_object("RUNES", function() return {
    ["LOC"] = ZG.MSTAIRS,
    ["DESC"] = "runes",
    ["SYNONYM"] = {"ENGRAV", "TEXT", "WALL", "RUNES"},
    ["ADJECTIVE"] = "CARVED",
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["ACTION"] = ZG.RUNES_F,
} end) end, true)

-- zil: 3dungeon.zil:718  <OBJECT T-BAR>
ZG._declare("T_BAR", function() return ZG._declare_object("T-BAR", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "T-bar",
    ["SYNONYM"] = {"T-BAR", "BAR"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.T_BAR_F,
} end) end, true)

-- zil: 3dungeon.zil:725  <OBJECT BLACK-PANEL>
ZG._declare("BLACK_PANEL", function() return ZG._declare_object("BLACK-PANEL", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "black panel",
    ["SYNONYM"] = {"WALL", "PANEL"},
    ["ADJECTIVE"] = "BLACK",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MPANELS,
} end) end, true)

-- zil: 3dungeon.zil:733  <OBJECT BRONZE-DOOR>
ZG._declare("BRONZE_DOOR", function() return ZG._declare_object("BRONZE-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "bronze door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = "BRONZE",
    ["FLAGS"] = {"CONTBIT", "DOORBIT", "INVISIBLE"},
    ["ACTION"] = ZG.BRONZE_DOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:741  <OBJECT CELL-DOOR>
ZG._declare("CELL_DOOR", function() return ZG._declare_object("CELL-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "cell door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"WOOD", "WOODEN", "CELL"},
    ["FLAGS"] = {"CONTBIT", "DOORBIT"},
    ["ACTION"] = ZG.CELL_DOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:749  <OBJECT COMPASS-ARROW>
ZG._declare("COMPASS_ARROW", function() return ZG._declare_object("COMPASS-ARROW", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "compass arrow",
    ["SYNONYM"] = "ARROW",
    ["ADJECTIVE"] = "COMPASS",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3dungeon.zil:756  <OBJECT DIAL-BUTTON>
ZG._declare("DIAL_BUTTON", function() return ZG._declare_object("DIAL-BUTTON", function() return {
    ["LOC"] = ZG.PARAPET,
    ["DESC"] = "large button",
    ["SYNONYM"] = "BUTTON",
    ["ADJECTIVE"] = "LARGE",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.DIALBUTTON,
} end) end, true)

-- zil: 3dungeon.zil:764  <OBJECT GOOD-LOCKED-DOOR>
ZG._declare("GOOD_LOCKED_DOOR", function() return ZG._declare_object("GOOD-LOCKED-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "cell door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"LOCKED", "WOOD", "WOODEN", "CELL"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.LOCKED_DOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:772  <OBJECT LOCKED-DOOR>
ZG._declare("LOCKED_DOOR", function() return ZG._declare_object("LOCKED-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "cell door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"LOCKED", "WOOD", "WOODEN", "CELL"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.LOCKED_DOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:780  <OBJECT LONG-POLE>
ZG._declare("LONG_POLE", function() return ZG._declare_object("LONG-POLE", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "long pole",
    ["SYNONYM"] = "POLE",
    ["ADJECTIVE"] = {"LONG", "CENTER"},
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3dungeon.zil:787  <OBJECT MAHOGANY-PANEL>
ZG._declare("MAHOGANY_PANEL", function() return ZG._declare_object("MAHOGANY-PANEL", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "mahogany panel",
    ["SYNONYM"] = {"WALL", "PANEL"},
    ["ADJECTIVE"] = "MAHOGANY",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MENDS,
} end) end, true)

-- zil: 3dungeon.zil:795  <OBJECT FLAMING-PIT>
ZG._declare("FLAMING_PIT", function() return ZG._declare_object("FLAMING-PIT", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "flaming pit",
    ["SYNONYM"] = {"PIT", "ABYSS"},
    ["ADJECTIVE"] = {"FIERY", "FLAMING"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.FLAMING_PIT_F,
} end) end, true)

-- zil: 3dungeon.zil:803  <OBJECT PARAPET-OBJ>
ZG._declare("PARAPET_OBJ", function() return ZG._declare_object("PARAPET-OBJ", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "parapet",
    ["SYNONYM"] = "PARAPET",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.PARAPET_OBJ_F,
} end) end, true)

-- zil: 3dungeon.zil:810  <OBJECT PINE-PANEL>
ZG._declare("PINE_PANEL", function() return ZG._declare_object("PINE-PANEL", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "pine panel",
    ["SYNONYM"] = {"PANEL", "WALL"},
    ["ADJECTIVE"] = "PINE",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MENDS,
} end) end, true)

-- zil: 3dungeon.zil:818  <OBJECT BEAM>
ZG._declare("BEAM", function() return ZG._declare_object("BEAM", function() return {
    ["LOC"] = ZG.MREYE,
    ["DESC"] = "red beam of light",
    ["SYNONYM"] = {"BEAM", "LIGHT"},
    ["ADJECTIVE"] = "RED",
    ["FLAGS"] = {"NDESCBIT", "OPENBIT", "CONTBIT"},
    ["CAPACITY"] = 100,
    ["ACTION"] = ZG.BEAM_FUNCTION,
} end) end, true)

-- zil: 3dungeon.zil:827  <OBJECT RED-BUTTON>
ZG._declare("RED_BUTTON", function() return ZG._declare_object("RED-BUTTON", function() return {
    ["LOC"] = ZG.MR_ANTE,
    ["DESC"] = "red button",
    ["SYNONYM"] = "BUTTON",
    ["ADJECTIVE"] = "RED",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MRSWITCH,
} end) end, true)

-- zil: 3dungeon.zil:835  <OBJECT RED-PANEL>
ZG._declare("RED_PANEL", function() return ZG._declare_object("RED-PANEL", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "red panel",
    ["SYNONYM"] = {"PANEL", "WALL"},
    ["ADJECTIVE"] = "RED",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MPANELS,
} end) end, true)

-- zil: 3dungeon.zil:843  <OBJECT SHORT-POLE>
ZG._declare("SHORT_POLE", function() return ZG._declare_object("SHORT-POLE", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "short pole",
    ["SYNONYM"] = {"POLE", "POST", "HANDGRIP", "GRIP"},
    ["ADJECTIVE"] = {"SHORT", "SMALL", "HAND"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.SHORT_POLE_F,
} end) end, true)

-- zil: 3dungeon.zil:851  <OBJECT SUNDIAL>
ZG._declare("SUNDIAL", function() return ZG._declare_object("SUNDIAL", function() return {
    ["LOC"] = ZG.PARAPET,
    ["DESC"] = "sundial",
    ["SYNONYM"] = {"DIAL", "INDICATOR", "ARROW", "SUNDIAL"},
    ["ADJECTIVE"] = {"INDICATOR", "SUN"},
    ["FLAGS"] = {"NDESCBIT", "TURNBIT"},
    ["ACTION"] = ZG.DIAL,
} end) end, true)

-- zil: 3dungeon.zil:859  <OBJECT YELLOW-PANEL>
ZG._declare("YELLOW_PANEL", function() return ZG._declare_object("YELLOW-PANEL", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "yellow panel",
    ["SYNONYM"] = {"PANEL", "WALL"},
    ["ADJECTIVE"] = "YELLOW",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MPANELS,
} end) end, true)

-- zil: 3dungeon.zil:867  <OBJECT WHITE-PANEL>
ZG._declare("WHITE_PANEL", function() return ZG._declare_object("WHITE-PANEL", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "white panel",
    ["SYNONYM"] = {"PANEL", "WALL"},
    ["ADJECTIVE"] = "WHITE",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.MPANELS,
} end) end, true)

-- zil: 3dungeon.zil:875  <OBJECT WOODEN-BAR>
ZG._declare("WOODEN_BAR", function() return ZG._declare_object("WOODEN-BAR", function() return {
    ["LOC"] = ZG.IN_MIRROR,
    ["DESC"] = "wooden bar",
    ["SYNONYM"] = "BAR",
    ["ADJECTIVE"] = {"WOOD", "WOODEN"},
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3dungeon.zil:882  <OBJECT DUNGEON-PANEL>
ZG._declare("DUNGEON_PANEL", function() return ZG._declare_object("DUNGEON-PANEL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "panel",
    ["SYNONYM"] = "PANEL",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.DUNGEON_PANEL_F,
} end) end, true)

-- zil: 3dungeon.zil:889  <OBJECT DUNGEON-DOOR>
ZG._declare("DUNGEON_DOOR", function() return ZG._declare_object("DUNGEON-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "wooden door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"WOOD", "WOODEN"},
    ["FLAGS"] = {"NDESCBIT", "DOORBIT", "CONTBIT"},
    ["ACTION"] = ZG.DUNGEON_DOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:897  <OBJECT SECRET-DOOR>
ZG._declare("SECRET_DOOR", function() return ZG._declare_object("SECRET-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "secret door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = "SECRET",
    ["FLAGS"] = {"DOORBIT", "CONTBIT", "INVISIBLE"},
    ["ACTION"] = ZG.SECRET_DOOR_F,
} end) end, true)

-- zil: 3dungeon.zil:905  <OBJECT OLD-MAN>
ZG._declare("OLD_MAN", function() return ZG._declare_object("OLD-MAN", function() return {
    ["DESC"] = "old man",
    ["SYNONYM"] = "MAN",
    ["ADJECTIVE"] = "OLD",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.OLD_MAN_F,
    ["DESCFCN"] = ZG.OLD_MAN_F,
} end) end, true)

-- zil: 3dungeon.zil:913  <OBJECT CP-HOLE>
ZG._declare("CP_HOLE", function() return ZG._declare_object("CP-HOLE", function() return {
    ["LOC"] = ZG.CP_ANTE,
    ["DESC"] = "hole",
    ["SYNONYM"] = "HOLE",
    ["ADJECTIVE"] = "ROUND",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CP_HOLE_F,
} end) end, true)

-- zil: 3dungeon.zil:921  <ROUTINE GO ()>
ZG.actions:register("GO", function()

    while true do
        local _brk1 = true
        repeat
            -- ;"put interrupts on clock chain"
            do local _ = ZG.QUEUE(ZG.I_LANTERN, 200) end
            -- ;"clean up junk compiler can't do"
            ZG._set("CURRENT_LAMP", ZG.LAMP)
            do local _ = ZG.PUT(ZG.CPOBJS, (8 * 21), 1) end
            do local _ = ZG.PUT(ZG.CPOBJS, ZG.ADD((8 * 21), 1), ZG.LORE_BOOK) end
            do local _ = ZG.PUT(ZG.CPOBJS, (8 * 32), 1) end
            do local _ = ZG.PUT(ZG.CPOBJS, ZG.ADD((8 * 32), 1), ZG.CP_SLOT) end
            -- ;"set up and go"
            ZG._set("LIT", true)
            ZG._set("WINNER", ZG.ADVENTURER)
            ZG._set("PLAYER", ZG.WINNER)
            ZG._set("MLOC", ZG.MRB)
            ZG._set("HERE", ZG.ZORK2_STAIR)
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
            -- ;<ENABLE <QUEUE I-CLEFT <+ 70 <RANDOM 70>>>>
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_VIEW_CHANGE, 4)) end
            ZG._set("P_IT_OBJECT", false)
            if (not ZG._T(ZG.FSET_p(ZG.HERE, "TOUCHBIT"))) then
                do local _ = ZG.TELL("As in a dream, you see yourself tumbling down a great, dark staircase.\nAll about you are shadowy images of struggles against fierce opponents\nand diabolical traps. These give way to another round of images: of\nimposing stone figures, a cool, clear lake, and, now, of an old, yet\noddly youthful man. He turns toward you slowly, his long, silver hair\ndancing about him in a fresh breeze. \"You have reached the final test,\nmy friend! You are proved clever and powerful, but this is not yet\nenough! Seek me when you feel yourself worthy!\" The dream dissolves\naround you as his last words echo through the void....", ZG._TK.CR) end
                do local _ = ZG.CRLF() end
                do local _ = ZG.V_VERSION() end
                do local _ = ZG.CRLF() end
            end
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
            do local _ = ZG.MOVE(ZG.LAMP, ZG.HERE) end
            do local _ = ZG.V_LOOK() end
            do local _ = ZG.MAIN_LOOP() end
            break
        until true
        if _brk1 then break end
    end

end, "GO")

ZG.GO = ZG.actions:get("GO")

-- zil: 3dungeon.zil:960  <GLOBAL CLEFT-QUEUED?>
-- CLEFT_QUEUED_p is declared in ZilGlobal.lua
