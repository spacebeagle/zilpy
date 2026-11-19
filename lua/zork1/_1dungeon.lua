-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

do local _ = ZG.DIRECTIONS("NORTH", "EAST", "WEST", "SOUTH", "NE", "NW", "SE", "SW", "UP", "DOWN", "IN", "OUT", "LAND") end

-- zil: 1dungeon.zil:7  <GLOBAL SCORE-MAX>
-- SCORE_MAX is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:9  <GLOBAL FALSE-FLAG>
-- FALSE_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:13  <OBJECT BOARD>
ZG._declare("BOARD", function() return ZG._declare_object("BOARD", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"BOARDS", "BOARD"},
    ["DESC"] = "board",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BOARD_F,
} end) end, true)

-- zil: 1dungeon.zil:20  <OBJECT TEETH>
ZG._declare("TEETH", function() return ZG._declare_object("TEETH", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"OVERBOARD", "TEETH"},
    ["DESC"] = "set of teeth",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.TEETH_F,
} end) end, true)

-- zil: 1dungeon.zil:27  <OBJECT WALL>
ZG._declare("WALL", function() return ZG._declare_object("WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"WALL", "WALLS"},
    ["ADJECTIVE"] = "SURROUNDING",
    ["DESC"] = "surrounding wall",
} end) end, true)

-- zil: 1dungeon.zil:33  <OBJECT GRANITE-WALL>
ZG._declare("GRANITE_WALL", function() return ZG._declare_object("GRANITE-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = "GRANITE",
    ["DESC"] = "granite wall",
    ["ACTION"] = ZG.GRANITE_WALL_F,
} end) end, true)

-- zil: 1dungeon.zil:40  <OBJECT SONGBIRD>
ZG._declare("SONGBIRD", function() return ZG._declare_object("SONGBIRD", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"BIRD", "SONGBIRD"},
    ["ADJECTIVE"] = "SONG",
    ["DESC"] = "songbird",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.SONGBIRD_F,
} end) end, true)

-- zil: 1dungeon.zil:48  <OBJECT WHITE-HOUSE>
ZG._declare("WHITE_HOUSE", function() return ZG._declare_object("WHITE-HOUSE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "HOUSE",
    ["ADJECTIVE"] = {"WHITE", "BEAUTI", "COLONI"},
    ["DESC"] = "white house",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.WHITE_HOUSE_F,
} end) end, true)

-- zil: 1dungeon.zil:56  <OBJECT FOREST>
ZG._declare("FOREST", function() return ZG._declare_object("FOREST", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"FOREST", "TREES", "PINES", "HEMLOCKS"},
    ["DESC"] = "forest",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.FOREST_F,
} end) end, true)

-- zil: 1dungeon.zil:63  <OBJECT TREE>
ZG._declare("TREE", function() return ZG._declare_object("TREE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"TREE", "BRANCH"},
    ["ADJECTIVE"] = {"LARGE", "STORM"},
    ["DESC"] = "tree",
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
} end) end, true)

-- zil: 1dungeon.zil:70  <OBJECT MOUNTAIN-RANGE>
ZG._declare("MOUNTAIN_RANGE", function() return ZG._declare_object("MOUNTAIN-RANGE", function() return {
    ["LOC"] = ZG.MOUNTAINS,
    ["DESC"] = "mountain range",
    ["SYNONYM"] = {"MOUNTAIN", "RANGE"},
    ["ADJECTIVE"] = {"IMPASSABLE", "FLATHEAD"},
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
    ["ACTION"] = ZG.MOUNTAIN_RANGE_F,
} end) end, true)

-- zil: 1dungeon.zil:78  <OBJECT GLOBAL-WATER>
ZG._declare("GLOBAL_WATER", function() return ZG._declare_object("GLOBAL-WATER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"WATER", "QUANTITY"},
    ["DESC"] = "water",
    ["FLAGS"] = "DRINKBIT",
    ["ACTION"] = ZG.WATER_F,
} end) end, true)

-- zil: 1dungeon.zil:85  <OBJECT WATER>
ZG._declare("WATER", function() return ZG._declare_object("WATER", function() return {
    ["LOC"] = ZG.BOTTLE,
    ["SYNONYM"] = {"WATER", "QUANTITY", "LIQUID", "H2O"},
    ["DESC"] = "quantity of water",
    ["FLAGS"] = {"TRYTAKEBIT", "TAKEBIT", "DRINKBIT"},
    ["ACTION"] = ZG.WATER_F,
    ["SIZE"] = 4,
} end) end, true)

-- zil: 1dungeon.zil:93  <OBJECT KITCHEN-WINDOW>
ZG._declare("KITCHEN_WINDOW", function() return ZG._declare_object("KITCHEN-WINDOW", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WINDOW",
    ["ADJECTIVE"] = {"KITCHEN", "SMALL"},
    ["DESC"] = "kitchen window",
    ["FLAGS"] = {"DOORBIT", "NDESCBIT"},
    ["ACTION"] = ZG.KITCHEN_WINDOW_F,
} end) end, true)

-- zil: 1dungeon.zil:101  <OBJECT CHIMNEY>
ZG._declare("CHIMNEY", function() return ZG._declare_object("CHIMNEY", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "CHIMNEY",
    ["ADJECTIVE"] = {"DARK", "NARROW"},
    ["DESC"] = "chimney",
    ["ACTION"] = ZG.CHIMNEY_F,
    ["FLAGS"] = {"CLIMBBIT", "NDESCBIT"},
} end) end, true)

-- zil: 1dungeon.zil:109  <OBJECT GHOSTS>
ZG._declare("GHOSTS", function() return ZG._declare_object("GHOSTS", function() return {
    ["LOC"] = ZG.ENTRANCE_TO_HADES,
    ["SYNONYM"] = {"GHOSTS", "SPIRITS", "FIENDS", "FORCE"},
    ["ADJECTIVE"] = {"INVISIBLE", "EVIL"},
    ["DESC"] = "number of ghosts",
    ["FLAGS"] = {"ACTORBIT", "NDESCBIT"},
    ["ACTION"] = ZG.GHOSTS_F,
} end) end, true)

-- zil: 1dungeon.zil:117  <OBJECT SKULL>
ZG._declare("SKULL", function() return ZG._declare_object("SKULL", function() return {
    ["LOC"] = ZG.LAND_OF_LIVING_DEAD,
    ["SYNONYM"] = {"SKULL", "HEAD", "TREASURE"},
    ["ADJECTIVE"] = "CRYSTAL",
    ["DESC"] = "crystal skull",
    ["FDESC"] = "Lying in one corner of the room is a beautifully carved crystal skull.\nIt appears to be grinning at you rather nastily.",
    ["FLAGS"] = "TAKEBIT",
    ["VALUE"] = 10,
    ["TVALUE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:129  <OBJECT LOWERED-BASKET>
ZG._declare("LOWERED_BASKET", function() return ZG._declare_object("LOWERED-BASKET", function() return {
    ["LOC"] = ZG.LOWER_SHAFT,
    ["SYNONYM"] = {"CAGE", "DUMBWAITER", "BASKET"},
    ["ADJECTIVE"] = "LOWERED",
    ["LDESC"] = "From the chain is suspended a basket.",
    ["DESC"] = "basket",
    ["FLAGS"] = "TRYTAKEBIT",
    ["ACTION"] = ZG.BASKET_F,
} end) end, true)

-- zil: 1dungeon.zil:138  <OBJECT RAISED-BASKET>
ZG._declare("RAISED_BASKET", function() return ZG._declare_object("RAISED-BASKET", function() return {
    ["LOC"] = ZG.SHAFT_ROOM,
    ["SYNONYM"] = {"CAGE", "DUMBWAITER", "BASKET"},
    ["DESC"] = "basket",
    ["FLAGS"] = {"TRANSBIT", "TRYTAKEBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.BASKET_F,
    ["LDESC"] = "At the end of the chain is a basket.",
    ["CAPACITY"] = 50,
} end) end, true)

-- zil: 1dungeon.zil:147  <OBJECT LUNCH>
ZG._declare("LUNCH", function() return ZG._declare_object("LUNCH", function() return {
    ["LOC"] = ZG.SANDWICH_BAG,
    ["SYNONYM"] = {"FOOD", "SANDWICH", "LUNCH", "DINNER"},
    ["ADJECTIVE"] = {"HOT", "PEPPER"},
    ["DESC"] = "lunch",
    ["FLAGS"] = {"TAKEBIT", "FOODBIT"},
    ["LDESC"] = "A hot pepper sandwich is here.",
} end) end, true)

-- zil: 1dungeon.zil:155  <OBJECT BAT>
ZG._declare("BAT", function() return ZG._declare_object("BAT", function() return {
    ["LOC"] = ZG.BAT_ROOM,
    ["SYNONYM"] = {"BAT", "VAMPIRE"},
    ["ADJECTIVE"] = {"VAMPIRE", "DERANGED"},
    ["DESC"] = "bat",
    ["FLAGS"] = {"ACTORBIT", "TRYTAKEBIT"},
    ["DESCFCN"] = ZG.BAT_D,
    ["ACTION"] = ZG.BAT_F,
} end) end, true)

-- zil: 1dungeon.zil:164  <OBJECT BELL>
ZG._declare("BELL", function() return ZG._declare_object("BELL", function() return {
    ["LOC"] = ZG.NORTH_TEMPLE,
    ["SYNONYM"] = "BELL",
    ["ADJECTIVE"] = {"SMALL", "BRASS"},
    ["DESC"] = "brass bell",
    ["FLAGS"] = "TAKEBIT",
    ["ACTION"] = ZG.BELL_F,
} end) end, true)

-- zil: 1dungeon.zil:172  <OBJECT HOT-BELL>
ZG._declare("HOT_BELL", function() return ZG._declare_object("HOT-BELL", function() return {
    ["SYNONYM"] = "BELL",
    ["ADJECTIVE"] = {"BRASS", "HOT", "RED", "SMALL"},
    ["DESC"] = "red hot brass bell",
    ["FLAGS"] = "TRYTAKEBIT",
    ["ACTION"] = ZG.HOT_BELL_F,
    ["LDESC"] = "On the ground is a red hot bell.",
} end) end, true)

-- zil: 1dungeon.zil:180  <OBJECT AXE>
ZG._declare("AXE", function() return ZG._declare_object("AXE", function() return {
    ["LOC"] = ZG.TROLL,
    ["SYNONYM"] = {"AXE", "AX"},
    ["ADJECTIVE"] = "BLOODY",
    ["DESC"] = "bloody axe",
    ["FLAGS"] = {"WEAPONBIT", "TRYTAKEBIT", "TAKEBIT", "NDESCBIT"},
    ["ACTION"] = ZG.AXE_F,
    ["SIZE"] = 25,
} end) end, true)

-- zil: 1dungeon.zil:189  <OBJECT BOLT>
ZG._declare("BOLT", function() return ZG._declare_object("BOLT", function() return {
    ["LOC"] = ZG.DAM_ROOM,
    ["SYNONYM"] = {"BOLT", "NUT"},
    ["ADJECTIVE"] = {"METAL", "LARGE"},
    ["DESC"] = "bolt",
    ["FLAGS"] = {"NDESCBIT", "TURNBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.BOLT_F,
} end) end, true)

-- zil: 1dungeon.zil:197  <OBJECT BUBBLE>
ZG._declare("BUBBLE", function() return ZG._declare_object("BUBBLE", function() return {
    ["LOC"] = ZG.DAM_ROOM,
    ["SYNONYM"] = "BUBBLE",
    ["ADJECTIVE"] = {"SMALL", "GREEN", "PLASTIC"},
    ["DESC"] = "green bubble",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.BUBBLE_F,
} end) end, true)

-- zil: 1dungeon.zil:205  <OBJECT ALTAR>
ZG._declare("ALTAR", function() return ZG._declare_object("ALTAR", function() return {
    ["LOC"] = ZG.SOUTH_TEMPLE,
    ["SYNONYM"] = "ALTAR",
    ["DESC"] = "altar",
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 50,
} end) end, true)

-- zil: 1dungeon.zil:212  <OBJECT BOOK>
ZG._declare("BOOK", function() return ZG._declare_object("BOOK", function() return {
    ["LOC"] = ZG.ALTAR,
    ["SYNONYM"] = {"BOOK", "PRAYER", "PAGE", "BOOKS"},
    ["ADJECTIVE"] = {"LARGE", "BLACK"},
    ["DESC"] = "black book",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "CONTBIT", "BURNBIT", "TURNBIT"},
    ["ACTION"] = ZG.BLACK_BOOK,
    ["FDESC"] = "On the altar is a large black book, open to page 569.",
    ["SIZE"] = 10,
    ["TEXT"] = "Commandment #12592\n\nOh ye who go about saying unto each:  \"Hello sailor\":\nDost thou know the magnitude of thy sin before the gods?\nYea, verily, thou shalt be ground between two stones.\nShall the angry gods cast thy body into the whirlpool?\nSurely, thy eye shall be put out with a sharp stick!\nEven unto the ends of the earth shalt thou wander and\nUnto the land of the dead shalt thou be sent at last.\nSurely thou shalt repent of thy cunning.",
} end) end, true)

-- zil: 1dungeon.zil:233  <OBJECT BROKEN-LAMP>
ZG._declare("BROKEN_LAMP", function() return ZG._declare_object("BROKEN-LAMP", function() return {
    ["SYNONYM"] = {"LAMP", "LANTERN"},
    ["ADJECTIVE"] = "BROKEN",
    ["DESC"] = "broken lantern",
    ["FLAGS"] = "TAKEBIT",
} end) end, true)

-- zil: 1dungeon.zil:239  <OBJECT SCEPTRE>
ZG._declare("SCEPTRE", function() return ZG._declare_object("SCEPTRE", function() return {
    ["LOC"] = ZG.COFFIN,
    ["SYNONYM"] = {"SCEPTRE", "SCEPTER", "TREASURE"},
    ["ADJECTIVE"] = {"SHARP", "EGYPTIAN", "ANCIENT", "ENAMELED"},
    ["DESC"] = "sceptre",
    ["FLAGS"] = {"TAKEBIT", "WEAPONBIT"},
    ["ACTION"] = ZG.SCEPTRE_FUNCTION,
    ["LDESC"] = "An ornamented sceptre, tapering to a sharp point, is here.",
    ["FDESC"] = "A sceptre, possibly that of ancient Egypt itself, is in the coffin. The\nsceptre is ornamented with colored enamel, and tapers to a sharp point.",
    ["SIZE"] = 3,
    ["VALUE"] = 4,
    ["TVALUE"] = 6,
} end) end, true)

-- zil: 1dungeon.zil:255  <OBJECT TIMBERS>
ZG._declare("TIMBERS", function() return ZG._declare_object("TIMBERS", function() return {
    ["LOC"] = ZG.TIMBER_ROOM,
    ["SYNONYM"] = {"TIMBERS", "PILE"},
    ["ADJECTIVE"] = {"WOODEN", "BROKEN"},
    ["DESC"] = "broken timber",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 50,
} end) end, true)

-- zil: 1dungeon.zil:263  <OBJECT SLIDE>
ZG._declare("SLIDE", function() return ZG._declare_object("SLIDE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"CHUTE", "RAMP", "SLIDE"},
    ["ADJECTIVE"] = {"STEEP", "METAL", "TWISTING"},
    ["DESC"] = "chute",
    ["FLAGS"] = "CLIMBBIT",
    ["ACTION"] = ZG.SLIDE_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:271  <OBJECT KITCHEN-TABLE>
ZG._declare("KITCHEN_TABLE", function() return ZG._declare_object("KITCHEN-TABLE", function() return {
    ["LOC"] = ZG.KITCHEN,
    ["SYNONYM"] = "TABLE",
    ["ADJECTIVE"] = "KITCHEN",
    ["DESC"] = "kitchen table",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT", "OPENBIT", "SURFACEBIT"},
    ["CAPACITY"] = 50,
} end) end, true)

-- zil: 1dungeon.zil:279  <OBJECT ATTIC-TABLE>
ZG._declare("ATTIC_TABLE", function() return ZG._declare_object("ATTIC-TABLE", function() return {
    ["LOC"] = ZG.ATTIC,
    ["SYNONYM"] = "TABLE",
    ["DESC"] = "table",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT", "OPENBIT", "SURFACEBIT"},
    ["CAPACITY"] = 40,
} end) end, true)

-- zil: 1dungeon.zil:286  <OBJECT SANDWICH-BAG>
ZG._declare("SANDWICH_BAG", function() return ZG._declare_object("SANDWICH-BAG", function() return {
    ["LOC"] = ZG.KITCHEN_TABLE,
    ["SYNONYM"] = {"BAG", "SACK"},
    ["ADJECTIVE"] = {"BROWN", "ELONGATED", "SMELLY"},
    ["DESC"] = "brown sack",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT", "BURNBIT"},
    ["FDESC"] = "On the table is an elongated brown sack, smelling of hot peppers.",
    ["CAPACITY"] = 9,
    ["SIZE"] = 9,
    ["ACTION"] = ZG.SANDWICH_BAG_FCN,
} end) end, true)

-- zil: 1dungeon.zil:298  <OBJECT TOOL-CHEST>
ZG._declare("TOOL_CHEST", function() return ZG._declare_object("TOOL-CHEST", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"CHEST", "CHESTS", "GROUP", "TOOLCHESTS"},
    ["ADJECTIVE"] = "TOOL",
    ["DESC"] = "group of tool chests",
    ["FLAGS"] = {"CONTBIT", "OPENBIT", "TRYTAKEBIT", "SACREDBIT"},
    ["ACTION"] = ZG.TOOL_CHEST_FCN,
} end) end, true)

-- zil: 1dungeon.zil:306  <OBJECT YELLOW-BUTTON>
ZG._declare("YELLOW_BUTTON", function() return ZG._declare_object("YELLOW-BUTTON", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"BUTTON", "SWITCH"},
    ["ADJECTIVE"] = "YELLOW",
    ["DESC"] = "yellow button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTON_F,
} end) end, true)

-- zil: 1dungeon.zil:314  <OBJECT BROWN-BUTTON>
ZG._declare("BROWN_BUTTON", function() return ZG._declare_object("BROWN-BUTTON", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"BUTTON", "SWITCH"},
    ["ADJECTIVE"] = "BROWN",
    ["DESC"] = "brown button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTON_F,
} end) end, true)

-- zil: 1dungeon.zil:322  <OBJECT RED-BUTTON>
ZG._declare("RED_BUTTON", function() return ZG._declare_object("RED-BUTTON", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"BUTTON", "SWITCH"},
    ["ADJECTIVE"] = "RED",
    ["DESC"] = "red button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTON_F,
} end) end, true)

-- zil: 1dungeon.zil:330  <OBJECT BLUE-BUTTON>
ZG._declare("BLUE_BUTTON", function() return ZG._declare_object("BLUE-BUTTON", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"BUTTON", "SWITCH"},
    ["ADJECTIVE"] = "BLUE",
    ["DESC"] = "blue button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTON_F,
} end) end, true)

-- zil: 1dungeon.zil:338  <OBJECT TROPHY-CASE>
ZG._declare("TROPHY_CASE", function() return ZG._declare_object("TROPHY-CASE", function() return {
    ["LOC"] = ZG.LIVING_ROOM,
    ["SYNONYM"] = "CASE",
    ["ADJECTIVE"] = "TROPHY",
    ["DESC"] = "trophy case",
    ["FLAGS"] = {"TRANSBIT", "CONTBIT", "NDESCBIT", "TRYTAKEBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.TROPHY_CASE_FCN,
    ["CAPACITY"] = 10000,
} end) end, true)

-- zil: 1dungeon.zil:347  <OBJECT RUG>
ZG._declare("RUG", function() return ZG._declare_object("RUG", function() return {
    ["LOC"] = ZG.LIVING_ROOM,
    ["SYNONYM"] = {"RUG", "CARPET"},
    ["ADJECTIVE"] = {"LARGE", "ORIENTAL"},
    ["DESC"] = "carpet",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.RUG_FCN,
} end) end, true)

-- zil: 1dungeon.zil:355  <OBJECT CHALICE>
ZG._declare("CHALICE", function() return ZG._declare_object("CHALICE", function() return {
    ["LOC"] = ZG.TREASURE_ROOM,
    ["SYNONYM"] = {"CHALICE", "CUP", "SILVER", "TREASURE"},
    ["ADJECTIVE"] = {"SILVER", "ENGRAVINGS"},
    ["DESC"] = "chalice",
    ["FLAGS"] = {"TAKEBIT", "TRYTAKEBIT", "CONTBIT"},
    ["ACTION"] = ZG.CHALICE_FCN,
    ["LDESC"] = "There is a silver chalice, intricately engraved, here.",
    ["CAPACITY"] = 5,
    ["SIZE"] = 10,
    ["VALUE"] = 10,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:368  <OBJECT GARLIC>
ZG._declare("GARLIC", function() return ZG._declare_object("GARLIC", function() return {
    ["LOC"] = ZG.SANDWICH_BAG,
    ["SYNONYM"] = {"GARLIC", "CLOVE"},
    ["DESC"] = "clove of garlic",
    ["FLAGS"] = {"TAKEBIT", "FOODBIT"},
    ["ACTION"] = ZG.GARLIC_F,
    ["SIZE"] = 4,
} end) end, true)

-- zil: 1dungeon.zil:376  <OBJECT TRIDENT>
ZG._declare("TRIDENT", function() return ZG._declare_object("TRIDENT", function() return {
    ["LOC"] = ZG.ATLANTIS_ROOM,
    ["SYNONYM"] = {"TRIDENT", "FORK", "TREASURE"},
    ["ADJECTIVE"] = {"POSEIDON", "OWN", "CRYSTAL"},
    ["DESC"] = "crystal trident",
    ["FLAGS"] = "TAKEBIT",
    ["FDESC"] = "On the shore lies Poseidon's own crystal trident.",
    ["SIZE"] = 20,
    ["VALUE"] = 4,
    ["TVALUE"] = 11,
} end) end, true)

-- zil: 1dungeon.zil:387  <OBJECT CYCLOPS>
ZG._declare("CYCLOPS", function() return ZG._declare_object("CYCLOPS", function() return {
    ["LOC"] = ZG.CYCLOPS_ROOM,
    ["SYNONYM"] = {"CYCLOPS", "MONSTER", "EYE"},
    ["ADJECTIVE"] = {"HUNGRY", "GIANT"},
    ["DESC"] = "cyclops",
    ["FLAGS"] = {"ACTORBIT", "NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.CYCLOPS_FCN,
    ["STRENGTH"] = 10000,
} end) end, true)

-- zil: 1dungeon.zil:396  <OBJECT DAM>
ZG._declare("DAM", function() return ZG._declare_object("DAM", function() return {
    ["LOC"] = ZG.DAM_ROOM,
    ["SYNONYM"] = {"DAM", "GATE", "GATES", "FCD#3"},
    ["DESC"] = "dam",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.DAM_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:403  <OBJECT TRAP-DOOR>
ZG._declare("TRAP_DOOR", function() return ZG._declare_object("TRAP-DOOR", function() return {
    ["LOC"] = ZG.LIVING_ROOM,
    ["SYNONYM"] = {"DOOR", "TRAPDOOR", "TRAP-DOOR", "COVER"},
    ["ADJECTIVE"] = {"TRAP", "DUSTY"},
    ["DESC"] = "trap door",
    ["FLAGS"] = {"DOORBIT", "NDESCBIT", "INVISIBLE"},
    ["ACTION"] = ZG.TRAP_DOOR_FCN,
} end) end, true)

-- zil: 1dungeon.zil:411  <OBJECT BOARDED-WINDOW>
ZG._declare("BOARDED_WINDOW", function() return ZG._declare_object("BOARDED-WINDOW", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WINDOW",
    ["ADJECTIVE"] = "BOARDED",
    ["DESC"] = "boarded window",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BOARDED_WINDOW_FCN,
} end) end, true)

-- zil: 1dungeon.zil:419  <OBJECT FRONT-DOOR>
ZG._declare("FRONT_DOOR", function() return ZG._declare_object("FRONT-DOOR", function() return {
    ["LOC"] = ZG.WEST_OF_HOUSE,
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"FRONT", "BOARDED"},
    ["DESC"] = "door",
    ["FLAGS"] = {"DOORBIT", "NDESCBIT"},
    ["ACTION"] = ZG.FRONT_DOOR_FCN,
} end) end, true)

-- zil: 1dungeon.zil:427  <OBJECT BARROW-DOOR>
ZG._declare("BARROW_DOOR", function() return ZG._declare_object("BARROW-DOOR", function() return {
    ["LOC"] = ZG.STONE_BARROW,
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"HUGE", "STONE"},
    ["DESC"] = "stone door",
    ["FLAGS"] = {"DOORBIT", "NDESCBIT", "OPENBIT"},
    ["ACTION"] = ZG.BARROW_DOOR_FCN,
} end) end, true)

-- zil: 1dungeon.zil:435  <OBJECT BARROW>
ZG._declare("BARROW", function() return ZG._declare_object("BARROW", function() return {
    ["LOC"] = ZG.STONE_BARROW,
    ["SYNONYM"] = {"BARROW", "TOMB"},
    ["ADJECTIVE"] = {"MASSIVE", "STONE"},
    ["DESC"] = "stone barrow",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BARROW_FCN,
} end) end, true)

-- zil: 1dungeon.zil:443  <OBJECT BOTTLE>
ZG._declare("BOTTLE", function() return ZG._declare_object("BOTTLE", function() return {
    ["LOC"] = ZG.KITCHEN_TABLE,
    ["SYNONYM"] = {"BOTTLE", "CONTAINER"},
    ["ADJECTIVE"] = {"CLEAR", "GLASS"},
    ["DESC"] = "glass bottle",
    ["FLAGS"] = {"TAKEBIT", "TRANSBIT", "CONTBIT"},
    ["ACTION"] = ZG.BOTTLE_FUNCTION,
    ["FDESC"] = "A bottle is sitting on the table.",
    ["CAPACITY"] = 4,
} end) end, true)

-- zil: 1dungeon.zil:453  <OBJECT CRACK>
ZG._declare("CRACK", function() return ZG._declare_object("CRACK", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "CRACK",
    ["ADJECTIVE"] = "NARROW",
    ["DESC"] = "crack",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.CRACK_FCN,
} end) end, true)

-- zil: 1dungeon.zil:461  <OBJECT COFFIN>
ZG._declare("COFFIN", function() return ZG._declare_object("COFFIN", function() return {
    ["LOC"] = ZG.EGYPT_ROOM,
    ["SYNONYM"] = {"COFFIN", "CASKET", "TREASURE"},
    ["ADJECTIVE"] = {"SOLID", "GOLD"},
    ["DESC"] = "gold coffin",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT", "SACREDBIT", "SEARCHBIT"},
    ["LDESC"] = "The solid-gold coffin used for the burial of Ramses II is here.",
    ["CAPACITY"] = 35,
    ["SIZE"] = 55,
    ["VALUE"] = 10,
    ["TVALUE"] = 15,
} end) end, true)

-- zil: 1dungeon.zil:474  <OBJECT GRATE>
ZG._declare("GRATE", function() return ZG._declare_object("GRATE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"GRATE", "GRATING"},
    ["DESC"] = "grating",
    ["FLAGS"] = {"DOORBIT", "NDESCBIT", "INVISIBLE"},
    ["ACTION"] = ZG.GRATE_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:481  <OBJECT PUMP>
ZG._declare("PUMP", function() return ZG._declare_object("PUMP", function() return {
    ["LOC"] = ZG.RESERVOIR_NORTH,
    ["SYNONYM"] = {"PUMP", "AIR-PUMP", "TOOL", "TOOLS"},
    ["ADJECTIVE"] = {"SMALL", "HAND-HELD"},
    ["DESC"] = "hand-held air pump",
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
} end) end, true)

-- zil: 1dungeon.zil:488  <OBJECT DIAMOND>
ZG._declare("DIAMOND", function() return ZG._declare_object("DIAMOND", function() return {
    ["SYNONYM"] = {"DIAMOND", "TREASURE"},
    ["ADJECTIVE"] = {"HUGE", "ENORMOUS"},
    ["DESC"] = "huge diamond",
    ["FLAGS"] = "TAKEBIT",
    ["LDESC"] = "There is an enormous diamond (perfectly cut) here.",
    ["VALUE"] = 10,
    ["TVALUE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:497  <OBJECT JADE>
ZG._declare("JADE", function() return ZG._declare_object("JADE", function() return {
    ["LOC"] = ZG.BAT_ROOM,
    ["SYNONYM"] = {"FIGURINE", "TREASURE"},
    ["ADJECTIVE"] = {"EXQUISITE", "JADE"},
    ["DESC"] = "jade figurine",
    ["FLAGS"] = "TAKEBIT",
    ["LDESC"] = "There is an exquisite jade figurine here.",
    ["SIZE"] = 10,
    ["VALUE"] = 5,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:508  <OBJECT KNIFE>
ZG._declare("KNIFE", function() return ZG._declare_object("KNIFE", function() return {
    ["LOC"] = ZG.ATTIC_TABLE,
    ["SYNONYM"] = {"KNIVES", "KNIFE", "BLADE"},
    ["ADJECTIVE"] = {"NASTY", "UNRUSTY"},
    ["DESC"] = "nasty knife",
    ["FLAGS"] = {"TAKEBIT", "WEAPONBIT", "TRYTAKEBIT"},
    ["FDESC"] = "On a table is a nasty-looking knife.",
    ["ACTION"] = ZG.KNIFE_F,
} end) end, true)

-- zil: 1dungeon.zil:517  <OBJECT BONES>
ZG._declare("BONES", function() return ZG._declare_object("BONES", function() return {
    ["LOC"] = ZG.MAZE_5,
    ["SYNONYM"] = {"BONES", "SKELETON", "BODY"},
    ["DESC"] = "skeleton",
    ["FLAGS"] = {"TRYTAKEBIT", "NDESCBIT"},
    ["ACTION"] = ZG.SKELETON,
} end) end, true)

-- zil: 1dungeon.zil:524  <OBJECT BURNED-OUT-LANTERN>
ZG._declare("BURNED_OUT_LANTERN", function() return ZG._declare_object("BURNED-OUT-LANTERN", function() return {
    ["LOC"] = ZG.MAZE_5,
    ["SYNONYM"] = {"LANTERN", "LAMP"},
    ["ADJECTIVE"] = {"RUSTY", "BURNED", "DEAD", "USELESS"},
    ["DESC"] = "burned-out lantern",
    ["FLAGS"] = "TAKEBIT",
    ["FDESC"] = "The deceased adventurer's useless lantern is here.",
    ["SIZE"] = 20,
} end) end, true)

-- zil: 1dungeon.zil:533  <OBJECT BAG-OF-COINS>
ZG._declare("BAG_OF_COINS", function() return ZG._declare_object("BAG-OF-COINS", function() return {
    ["LOC"] = ZG.MAZE_5,
    ["SYNONYM"] = {"BAG", "COINS", "TREASURE"},
    ["ADJECTIVE"] = {"OLD", "LEATHER"},
    ["DESC"] = "leather bag of coins",
    ["FLAGS"] = "TAKEBIT",
    ["LDESC"] = "An old leather bag, bulging with coins, is here.",
    ["ACTION"] = ZG.BAG_OF_COINS_F,
    ["SIZE"] = 15,
    ["VALUE"] = 10,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:545  <OBJECT LAMP>
ZG._declare("LAMP", function() return ZG._declare_object("LAMP", function() return {
    ["LOC"] = ZG.LIVING_ROOM,
    ["SYNONYM"] = {"LAMP", "LANTERN", "LIGHT"},
    ["ADJECTIVE"] = "BRASS",
    ["DESC"] = "brass lantern",
    ["FLAGS"] = {"TAKEBIT", "LIGHTBIT"},
    ["ACTION"] = ZG.LANTERN,
    ["FDESC"] = "A battery-powered brass lantern is on the trophy case.",
    ["LDESC"] = "There is a brass lantern (battery-powered) here.",
    ["SIZE"] = 15,
} end) end, true)

-- zil: 1dungeon.zil:556  <OBJECT EMERALD>
ZG._declare("EMERALD", function() return ZG._declare_object("EMERALD", function() return {
    ["LOC"] = ZG.BUOY,
    ["SYNONYM"] = {"EMERALD", "TREASURE"},
    ["ADJECTIVE"] = "LARGE",
    ["DESC"] = "large emerald",
    ["FLAGS"] = "TAKEBIT",
    ["VALUE"] = 5,
    ["TVALUE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:565  <OBJECT ADVERTISEMENT>
ZG._declare("ADVERTISEMENT", function() return ZG._declare_object("ADVERTISEMENT", function() return {
    ["LOC"] = ZG.MAILBOX,
    ["SYNONYM"] = {"ADVERTISEMENT", "LEAFLET", "BOOKLET", "MAIL"},
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "leaflet",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["LDESC"] = "A small leaflet is on the ground.",
    ["TEXT"] = "\"WELCOME TO ZORK!\n\nZORK is a game of adventure, danger, and low cunning. In it you\nwill explore some of the most amazing territory ever seen by mortals.\nNo computer should be without one!\"",
    ["SIZE"] = 2,
} end) end, true)

-- zil: 1dungeon.zil:580  <OBJECT LEAK>
ZG._declare("LEAK", function() return ZG._declare_object("LEAK", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"LEAK", "DRIP", "PIPE"},
    ["DESC"] = "leak",
    ["FLAGS"] = {"NDESCBIT", "INVISIBLE"},
    ["ACTION"] = ZG.LEAK_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:587  <OBJECT MACHINE>
ZG._declare("MACHINE", function() return ZG._declare_object("MACHINE", function() return {
    ["LOC"] = ZG.MACHINE_ROOM,
    ["SYNONYM"] = {"MACHINE", "PDP10", "DRYER", "LID"},
    ["DESC"] = "machine",
    ["FLAGS"] = {"CONTBIT", "NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.MACHINE_F,
    ["CAPACITY"] = 50,
} end) end, true)

-- zil: 1dungeon.zil:595  <OBJECT INFLATED-BOAT>
ZG._declare("INFLATED_BOAT", function() return ZG._declare_object("INFLATED-BOAT", function() return {
    ["SYNONYM"] = {"BOAT", "RAFT"},
    ["ADJECTIVE"] = {"INFLAT", "MAGIC", "PLASTIC", "SEAWORTHY"},
    ["DESC"] = "magic boat",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT", "VEHBIT", "OPENBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.RBOAT_FUNCTION,
    ["CAPACITY"] = 100,
    ["SIZE"] = 20,
    ["VTYPE"] = "NONLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:605  <OBJECT MAILBOX>
ZG._declare("MAILBOX", function() return ZG._declare_object("MAILBOX", function() return {
    ["LOC"] = ZG.WEST_OF_HOUSE,
    ["SYNONYM"] = {"MAILBOX", "BOX"},
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "small mailbox",
    ["FLAGS"] = {"CONTBIT", "TRYTAKEBIT"},
    ["CAPACITY"] = 10,
    ["ACTION"] = ZG.MAILBOX_F,
} end) end, true)

-- zil: 1dungeon.zil:614  <OBJECT MATCH>
ZG._declare("MATCH", function() return ZG._declare_object("MATCH", function() return {
    ["LOC"] = ZG.DAM_LOBBY,
    ["SYNONYM"] = {"MATCH", "MATCHES", "MATCHBOOK"},
    ["ADJECTIVE"] = "MATCH",
    ["DESC"] = "matchbook",
    ["FLAGS"] = {"READBIT", "TAKEBIT"},
    ["ACTION"] = ZG.MATCH_FUNCTION,
    ["LDESC"] = "There is a matchbook whose cover says \"Visit Beautiful FCD#3\" here.",
    ["SIZE"] = 2,
    ["TEXT"] = "\n(Close cover before striking)\n\nYOU too can make BIG MONEY in the exciting field of PAPER SHUFFLING!\n\nMr. Anderson of Muddle, Mass. says: \"Before I took this course I\nwas a lowly bit twiddler. Now with what I learned at GUE Tech\nI feel really important and can obfuscate and confuse with the best.\"\n\nDr. Blank had this to say: \"Ten short days ago all I could look\nforward to was a dead-end job as a doctor. Now I have a promising\nfuture and make really big Zorkmids.\"\n\nGUE Tech can't promise these fantastic results to everyone. But when\nyou earn your degree from GUE Tech, your future will be brighter.",
} end) end, true)

-- zil: 1dungeon.zil:641  <OBJECT MIRROR-2>
ZG._declare("MIRROR_2", function() return ZG._declare_object("MIRROR-2", function() return {
    ["LOC"] = ZG.MIRROR_ROOM_2,
    ["SYNONYM"] = {"REFLECTION", "MIRROR", "ENORMOUS"},
    ["DESC"] = "mirror",
    ["FLAGS"] = {"TRYTAKEBIT", "NDESCBIT"},
    ["ACTION"] = ZG.MIRROR_MIRROR,
} end) end, true)

-- zil: 1dungeon.zil:648  <OBJECT MIRROR-1>
ZG._declare("MIRROR_1", function() return ZG._declare_object("MIRROR-1", function() return {
    ["LOC"] = ZG.MIRROR_ROOM_1,
    ["SYNONYM"] = {"REFLECTION", "MIRROR", "ENORMOUS"},
    ["DESC"] = "mirror",
    ["FLAGS"] = {"TRYTAKEBIT", "NDESCBIT"},
    ["ACTION"] = ZG.MIRROR_MIRROR,
} end) end, true)

-- zil: 1dungeon.zil:655  <OBJECT PAINTING>
ZG._declare("PAINTING", function() return ZG._declare_object("PAINTING", function() return {
    ["LOC"] = ZG.GALLERY,
    ["SYNONYM"] = {"PAINTING", "ART", "CANVAS", "TREASURE"},
    ["ADJECTIVE"] = "BEAUTI",
    ["DESC"] = "painting",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT"},
    ["ACTION"] = ZG.PAINTING_FCN,
    ["FDESC"] = "Fortunately, there is still one chance for you to be a vandal, for on\nthe far wall is a painting of unparalleled beauty.",
    ["LDESC"] = "A painting by a neglected genius is here.",
    ["SIZE"] = 15,
    ["VALUE"] = 4,
    ["TVALUE"] = 6,
} end) end, true)

-- zil: 1dungeon.zil:670  <OBJECT CANDLES>
ZG._declare("CANDLES", function() return ZG._declare_object("CANDLES", function() return {
    ["LOC"] = ZG.SOUTH_TEMPLE,
    ["SYNONYM"] = {"CANDLES", "PAIR"},
    ["ADJECTIVE"] = "BURNING",
    ["DESC"] = "pair of candles",
    ["FLAGS"] = {"TAKEBIT", "FLAMEBIT", "ONBIT", "LIGHTBIT"},
    ["ACTION"] = ZG.CANDLES_FCN,
    ["FDESC"] = "On the two ends of the altar are burning candles.",
    ["SIZE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:680  <OBJECT GUNK>
ZG._declare("GUNK", function() return ZG._declare_object("GUNK", function() return {
    ["SYNONYM"] = {"GUNK", "PIECE", "SLAG"},
    ["ADJECTIVE"] = {"SMALL", "VITREOUS"},
    ["DESC"] = "small piece of vitreous slag",
    ["FLAGS"] = {"TAKEBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.GUNK_FUNCTION,
    ["SIZE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:688  <OBJECT BODIES>
ZG._declare("BODIES", function() return ZG._declare_object("BODIES", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"BODIES", "BODY", "REMAINS", "PILE"},
    ["ADJECTIVE"] = "MANGLED",
    ["DESC"] = "pile of bodies",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.BODY_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:696  <OBJECT LEAVES>
ZG._declare("LEAVES", function() return ZG._declare_object("LEAVES", function() return {
    ["LOC"] = ZG.GRATING_CLEARING,
    ["SYNONYM"] = {"LEAVES", "LEAF", "PILE"},
    ["DESC"] = "pile of leaves",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.LEAF_PILE,
    ["LDESC"] = "On the ground is a pile of leaves.",
    ["SIZE"] = 25,
} end) end, true)

-- zil: 1dungeon.zil:705  <OBJECT PUNCTURED-BOAT>
ZG._declare("PUNCTURED_BOAT", function() return ZG._declare_object("PUNCTURED-BOAT", function() return {
    ["SYNONYM"] = {"BOAT", "PILE", "PLASTIC"},
    ["ADJECTIVE"] = {"PLASTIC", "PUNCTURE", "LARGE"},
    ["DESC"] = "punctured boat",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT"},
    ["ACTION"] = ZG.DBOAT_FUNCTION,
    ["SIZE"] = 20,
} end) end, true)

-- zil: 1dungeon.zil:713  <OBJECT INFLATABLE-BOAT>
ZG._declare("INFLATABLE_BOAT", function() return ZG._declare_object("INFLATABLE-BOAT", function() return {
    ["LOC"] = ZG.DAM_BASE,
    ["SYNONYM"] = {"BOAT", "PILE", "PLASTIC", "VALVE"},
    ["ADJECTIVE"] = {"PLASTIC", "INFLAT"},
    ["DESC"] = "pile of plastic",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT"},
    ["ACTION"] = ZG.IBOAT_FUNCTION,
    ["LDESC"] = "There is a folded pile of plastic here which has a small valve\nattached.",
    ["SIZE"] = 20,
} end) end, true)

-- zil: 1dungeon.zil:725  <OBJECT BAR>
ZG._declare("BAR", function() return ZG._declare_object("BAR", function() return {
    ["LOC"] = ZG.LOUD_ROOM,
    ["SYNONYM"] = {"BAR", "PLATINUM", "TREASURE"},
    ["ADJECTIVE"] = {"PLATINUM", "LARGE"},
    ["DESC"] = "platinum bar",
    ["FLAGS"] = {"TAKEBIT", "SACREDBIT"},
    ["LDESC"] = "On the ground is a large platinum bar.",
    ["SIZE"] = 20,
    ["VALUE"] = 10,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:736  <OBJECT POT-OF-GOLD>
ZG._declare("POT_OF_GOLD", function() return ZG._declare_object("POT-OF-GOLD", function() return {
    ["LOC"] = ZG.END_OF_RAINBOW,
    ["SYNONYM"] = {"POT", "GOLD", "TREASURE"},
    ["ADJECTIVE"] = "GOLD",
    ["DESC"] = "pot of gold",
    ["FLAGS"] = {"TAKEBIT", "INVISIBLE"},
    ["FDESC"] = "At the end of the rainbow is a pot of gold.",
    ["SIZE"] = 15,
    ["VALUE"] = 10,
    ["TVALUE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:747  <OBJECT PRAYER>
ZG._declare("PRAYER", function() return ZG._declare_object("PRAYER", function() return {
    ["LOC"] = ZG.NORTH_TEMPLE,
    ["SYNONYM"] = {"PRAYER", "INSCRIPTION"},
    ["ADJECTIVE"] = {"ANCIENT", "OLD"},
    ["DESC"] = "prayer",
    ["FLAGS"] = {"READBIT", "SACREDBIT", "NDESCBIT"},
    ["TEXT"] = "The prayer is inscribed in an ancient script, rarely used today. It seems\nto be a philippic against small insects, absent-mindedness, and the picking\nup and dropping of small objects. The final verse consigns trespassers to\nthe land of the dead. All evidence indicates that the beliefs of the ancient\nZorkers were obscure.",
} end) end, true)

-- zil: 1dungeon.zil:760  <OBJECT RAILING>
ZG._declare("RAILING", function() return ZG._declare_object("RAILING", function() return {
    ["LOC"] = ZG.DOME_ROOM,
    ["SYNONYM"] = {"RAILING", "RAIL"},
    ["ADJECTIVE"] = "WOODEN",
    ["DESC"] = "wooden railing",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 1dungeon.zil:767  <OBJECT RAINBOW>
ZG._declare("RAINBOW", function() return ZG._declare_object("RAINBOW", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "RAINBOW",
    ["DESC"] = "rainbow",
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
    ["ACTION"] = ZG.RAINBOW_FCN,
} end) end, true)

-- zil: 1dungeon.zil:774  <OBJECT RIVER>
ZG._declare("RIVER", function() return ZG._declare_object("RIVER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "river",
    ["SYNONYM"] = "RIVER",
    ["ADJECTIVE"] = "FRIGID",
    ["ACTION"] = ZG.RIVER_FUNCTION,
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 1dungeon.zil:782  <OBJECT BUOY>
ZG._declare("BUOY", function() return ZG._declare_object("BUOY", function() return {
    ["LOC"] = ZG.RIVER_4,
    ["SYNONYM"] = "BUOY",
    ["ADJECTIVE"] = "RED",
    ["DESC"] = "red buoy",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT"},
    ["FDESC"] = "There is a red buoy here (probably a warning).",
    ["CAPACITY"] = 20,
    ["SIZE"] = 10,
    ["ACTION"] = ZG.TREASURE_INSIDE,
} end) end, true)

-- zil: 1dungeon.zil:793  <ROUTINE TREASURE-INSIDE ()>
ZG.actions:register("TREASURE_INSIDE", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do local _ = ZG.SCORE_OBJ(ZG.EMERALD) end
        do return false end
    else
        do return false end
    end

end, "TREASURE-INSIDE")

ZG.TREASURE_INSIDE = ZG.actions:get("TREASURE_INSIDE")

-- zil: 1dungeon.zil:797  <OBJECT ROPE>
ZG._declare("ROPE", function() return ZG._declare_object("ROPE", function() return {
    ["LOC"] = ZG.ATTIC,
    ["SYNONYM"] = {"ROPE", "HEMP", "COIL"},
    ["ADJECTIVE"] = "LARGE",
    ["DESC"] = "rope",
    ["FLAGS"] = {"TAKEBIT", "SACREDBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.ROPE_FUNCTION,
    ["FDESC"] = "A large coil of rope is lying in the corner.",
    ["SIZE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:807  <OBJECT RUSTY-KNIFE>
ZG._declare("RUSTY_KNIFE", function() return ZG._declare_object("RUSTY-KNIFE", function() return {
    ["LOC"] = ZG.MAZE_5,
    ["SYNONYM"] = {"KNIVES", "KNIFE"},
    ["ADJECTIVE"] = "RUSTY",
    ["DESC"] = "rusty knife",
    ["FLAGS"] = {"TAKEBIT", "TRYTAKEBIT", "WEAPONBIT", "TOOLBIT"},
    ["ACTION"] = ZG.RUSTY_KNIFE_FCN,
    ["FDESC"] = "Beside the skeleton is a rusty knife.",
    ["SIZE"] = 20,
} end) end, true)

-- zil: 1dungeon.zil:817  <OBJECT SAND>
ZG._declare("SAND", function() return ZG._declare_object("SAND", function() return {
    ["LOC"] = ZG.SANDY_CAVE,
    ["SYNONYM"] = "SAND",
    ["DESC"] = "sand",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.SAND_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:824  <OBJECT BRACELET>
ZG._declare("BRACELET", function() return ZG._declare_object("BRACELET", function() return {
    ["LOC"] = ZG.GAS_ROOM,
    ["SYNONYM"] = {"BRACELET", "JEWEL", "SAPPHIRE", "TREASURE"},
    ["ADJECTIVE"] = "SAPPHIRE",
    ["DESC"] = "sapphire-encrusted bracelet",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 10,
    ["VALUE"] = 5,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:834  <OBJECT SCREWDRIVER>
ZG._declare("SCREWDRIVER", function() return ZG._declare_object("SCREWDRIVER", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"SCREWDRIVER", "TOOL", "TOOLS", "DRIVER"},
    ["ADJECTIVE"] = "SCREW",
    ["DESC"] = "screwdriver",
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
} end) end, true)

-- zil: 1dungeon.zil:841  <OBJECT KEYS>
ZG._declare("KEYS", function() return ZG._declare_object("KEYS", function() return {
    ["LOC"] = ZG.MAZE_5,
    ["SYNONYM"] = "KEY",
    ["ADJECTIVE"] = "SKELETON",
    ["DESC"] = "skeleton key",
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
    ["SIZE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:849  <OBJECT SHOVEL>
ZG._declare("SHOVEL", function() return ZG._declare_object("SHOVEL", function() return {
    ["LOC"] = ZG.SANDY_BEACH,
    ["SYNONYM"] = {"SHOVEL", "TOOL", "TOOLS"},
    ["DESC"] = "shovel",
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
    ["SIZE"] = 15,
} end) end, true)

-- zil: 1dungeon.zil:856  <OBJECT COAL>
ZG._declare("COAL", function() return ZG._declare_object("COAL", function() return {
    ["LOC"] = ZG.DEAD_END_5,
    ["SYNONYM"] = {"COAL", "PILE", "HEAP"},
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "small pile of coal",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT"},
    ["SIZE"] = 20,
} end) end, true)

-- zil: 1dungeon.zil:864  <OBJECT LADDER>
ZG._declare("LADDER", function() return ZG._declare_object("LADDER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "LADDER",
    ["ADJECTIVE"] = {"WOODEN", "RICKETY", "NARROW"},
    ["DESC"] = "wooden ladder",
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
} end) end, true)

-- zil: 1dungeon.zil:871  <OBJECT SCARAB>
ZG._declare("SCARAB", function() return ZG._declare_object("SCARAB", function() return {
    ["LOC"] = ZG.SANDY_CAVE,
    ["SYNONYM"] = {"SCARAB", "BUG", "BEETLE", "TREASURE"},
    ["ADJECTIVE"] = {"BEAUTI", "CARVED", "JEWELED"},
    ["DESC"] = "beautiful jeweled scarab",
    ["FLAGS"] = {"TAKEBIT", "INVISIBLE"},
    ["SIZE"] = 8,
    ["VALUE"] = 5,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:881  <OBJECT LARGE-BAG>
ZG._declare("LARGE_BAG", function() return ZG._declare_object("LARGE-BAG", function() return {
    ["LOC"] = ZG.THIEF,
    ["SYNONYM"] = "BAG",
    ["ADJECTIVE"] = {"LARGE", "THIEFS"},
    ["DESC"] = "large bag",
    ["ACTION"] = ZG.LARGE_BAG_F,
    ["FLAGS"] = {"TRYTAKEBIT", "NDESCBIT"},
} end) end, true)

-- zil: 1dungeon.zil:889  <OBJECT STILETTO>
ZG._declare("STILETTO", function() return ZG._declare_object("STILETTO", function() return {
    ["LOC"] = ZG.THIEF,
    ["SYNONYM"] = "STILETTO",
    ["ADJECTIVE"] = "VICIOUS",
    ["DESC"] = "stiletto",
    ["ACTION"] = ZG.STILETTO_FUNCTION,
    ["FLAGS"] = {"WEAPONBIT", "TRYTAKEBIT", "TAKEBIT", "NDESCBIT"},
    ["SIZE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:898  <OBJECT MACHINE-SWITCH>
ZG._declare("MACHINE_SWITCH", function() return ZG._declare_object("MACHINE-SWITCH", function() return {
    ["LOC"] = ZG.MACHINE_ROOM,
    ["SYNONYM"] = "SWITCH",
    ["DESC"] = "switch",
    ["FLAGS"] = {"NDESCBIT", "TURNBIT"},
    ["ACTION"] = ZG.MSWITCH_FUNCTION,
} end) end, true)

-- zil: 1dungeon.zil:905  <OBJECT WOODEN-DOOR>
ZG._declare("WOODEN_DOOR", function() return ZG._declare_object("WOODEN-DOOR", function() return {
    ["LOC"] = ZG.LIVING_ROOM,
    ["SYNONYM"] = {"DOOR", "LETTERING", "WRITING"},
    ["ADJECTIVE"] = {"WOODEN", "GOTHIC", "STRANGE", "WEST"},
    ["DESC"] = "wooden door",
    ["FLAGS"] = {"READBIT", "DOORBIT", "NDESCBIT", "TRANSBIT"},
    ["ACTION"] = ZG.FRONT_DOOR_FCN,
    ["TEXT"] = "The engravings translate to \"This space intentionally left blank.\"",
} end) end, true)

-- zil: 1dungeon.zil:915  <OBJECT SWORD>
ZG._declare("SWORD", function() return ZG._declare_object("SWORD", function() return {
    ["LOC"] = ZG.LIVING_ROOM,
    ["SYNONYM"] = {"SWORD", "ORCRIST", "GLAMDRING", "BLADE"},
    ["ADJECTIVE"] = {"ELVISH", "OLD", "ANTIQUE"},
    ["DESC"] = "sword",
    ["FLAGS"] = {"TAKEBIT", "WEAPONBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.SWORD_FCN,
    ["FDESC"] = "Above the trophy case hangs an elvish sword of great antiquity.",
    ["SIZE"] = 30,
    ["TVALUE"] = 0,
} end) end, true)

-- zil: 1dungeon.zil:927  <OBJECT MAP>
ZG._declare("MAP", function() return ZG._declare_object("MAP", function() return {
    ["LOC"] = ZG.TROPHY_CASE,
    ["SYNONYM"] = {"PARCHMENT", "MAP"},
    ["ADJECTIVE"] = {"ANTIQUE", "OLD", "ANCIENT"},
    ["DESC"] = "ancient map",
    ["FLAGS"] = {"INVISIBLE", "READBIT", "TAKEBIT"},
    ["FDESC"] = "In the trophy case is an ancient parchment which appears to be a map.",
    ["SIZE"] = 2,
    ["TEXT"] = "The map shows a forest with three clearings. The largest clearing contains\na house. Three paths leave the large clearing. One of these paths, leading\nsouthwest, is marked \"To Stone Barrow\".",
} end) end, true)

-- zil: 1dungeon.zil:941  <OBJECT BOAT-LABEL>
ZG._declare("BOAT_LABEL", function() return ZG._declare_object("BOAT-LABEL", function() return {
    ["LOC"] = ZG.INFLATED_BOAT,
    ["SYNONYM"] = {"LABEL", "FINEPRINT", "PRINT"},
    ["ADJECTIVE"] = {"TAN", "FINE"},
    ["DESC"] = "tan label",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["SIZE"] = 2,
    ["TEXT"] = "  !!!!FROBOZZ MAGIC BOAT COMPANY!!!!\n\nHello, Sailor!\n\nInstructions for use:\n\n   To get into a body of water, say \"Launch\".\n   To get to shore, say \"Land\" or the direction in which you want\nto maneuver the boat.\n\nWarranty:\n\n  This boat is guaranteed against all defects for a period of 76\nmilliseconds from date of purchase or until first used, whichever comes first.\n\nWarning:\n   This boat is made of thin plastic.\n   Good Luck!",
} end) end, true)

-- zil: 1dungeon.zil:968  <OBJECT THIEF>
ZG._declare("THIEF", function() return ZG._declare_object("THIEF", function() return {
    ["LOC"] = ZG.ROUND_ROOM,
    ["SYNONYM"] = {"THIEF", "ROBBER", "MAN", "PERSON"},
    ["ADJECTIVE"] = {"SHADY", "SUSPICIOUS", "SEEDY"},
    ["DESC"] = "thief",
    ["FLAGS"] = {"ACTORBIT", "INVISIBLE", "CONTBIT", "OPENBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.ROBBER_FUNCTION,
    ["LDESC"] = "There is a suspicious-looking individual, holding a large bag, leaning\nagainst one wall. He is armed with a deadly stiletto.",
    ["STRENGTH"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:980  <OBJECT PEDESTAL>
ZG._declare("PEDESTAL", function() return ZG._declare_object("PEDESTAL", function() return {
    ["LOC"] = ZG.TORCH_ROOM,
    ["SYNONYM"] = "PEDESTAL",
    ["ADJECTIVE"] = {"WHITE", "MARBLE"},
    ["DESC"] = "pedestal",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT", "OPENBIT", "SURFACEBIT"},
    ["ACTION"] = ZG.DUMB_CONTAINER,
    ["CAPACITY"] = 30,
} end) end, true)

-- zil: 1dungeon.zil:989  <OBJECT TORCH>
ZG._declare("TORCH", function() return ZG._declare_object("TORCH", function() return {
    ["LOC"] = ZG.PEDESTAL,
    ["SYNONYM"] = {"TORCH", "IVORY", "TREASURE"},
    ["ADJECTIVE"] = {"FLAMING", "IVORY"},
    ["DESC"] = "torch",
    ["FLAGS"] = {"TAKEBIT", "FLAMEBIT", "ONBIT", "LIGHTBIT"},
    ["ACTION"] = ZG.TORCH_OBJECT,
    ["FDESC"] = "Sitting on the pedestal is a flaming torch, made of ivory.",
    ["SIZE"] = 20,
    ["VALUE"] = 14,
    ["TVALUE"] = 6,
} end) end, true)

-- zil: 1dungeon.zil:1001  <OBJECT GUIDE>
ZG._declare("GUIDE", function() return ZG._declare_object("GUIDE", function() return {
    ["LOC"] = ZG.DAM_LOBBY,
    ["SYNONYM"] = {"GUIDE", "BOOK", "BOOKS", "GUIDEBOOKS"},
    ["ADJECTIVE"] = {"TOUR", "GUIDE"},
    ["DESC"] = "tour guidebook",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["FDESC"] = "Some guidebooks entitled \"Flood Control Dam #3\" are on the reception\ndesk.",
    ["TEXT"] = "\"\tFlood Control Dam #3\n\nFCD#3 was constructed in year 783 of the Great Underground Empire to\nharness the mighty Frigid River. This work was supported by a grant of\n37 million zorkmids from your omnipotent local tyrant Lord Dimwit\nFlathead the Excessive. This impressive structure is composed of\n370,000 cubic feet of concrete, is 256 feet tall at the center, and 193\nfeet wide at the top. The lake created behind the dam has a volume\nof 1.7 billion cubic feet, an area of 12 million square feet, and a\nshore line of 36 thousand feet.\n\nThe construction of FCD#3 took 112 days from ground breaking to\nthe dedication. It required a work force of 384 slaves, 34 slave\ndrivers, 12 engineers, 2 turtle doves, and a partridge in a pear\ntree. The work was managed by a command team composed of 2345\nbureaucrats, 2347 secretaries (at least two of whom could type),\n12,256 paper shufflers, 52,469 rubber stampers, 245,193 red tape\nprocessors, and nearly one million dead trees.\n\nWe will now point out some of the more interesting features\nof FCD#3 as we conduct you on a guided tour of the facilities:\n\n        1) You start your tour here in the Dam Lobby. You will notice\non your right that....",
} end) end, true)

-- zil: 1dungeon.zil:1036  <OBJECT TROLL>
ZG._declare("TROLL", function() return ZG._declare_object("TROLL", function() return {
    ["LOC"] = ZG.TROLL_ROOM,
    ["SYNONYM"] = "TROLL",
    ["ADJECTIVE"] = "NASTY",
    ["DESC"] = "troll",
    ["FLAGS"] = {"ACTORBIT", "OPENBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.TROLL_FCN,
    ["LDESC"] = "A nasty-looking troll, brandishing a bloody axe, blocks all passages\nout of the room.",
    ["STRENGTH"] = 2,
} end) end, true)

-- zil: 1dungeon.zil:1048  <OBJECT TRUNK>
ZG._declare("TRUNK", function() return ZG._declare_object("TRUNK", function() return {
    ["LOC"] = ZG.RESERVOIR,
    ["SYNONYM"] = {"TRUNK", "CHEST", "JEWELS", "TREASURE"},
    ["ADJECTIVE"] = "OLD",
    ["DESC"] = "trunk of jewels",
    ["FLAGS"] = {"TAKEBIT", "INVISIBLE"},
    ["FDESC"] = "Lying half buried in the mud is an old trunk, bulging with jewels.",
    ["LDESC"] = "There is an old trunk here, bulging with assorted jewels.",
    ["ACTION"] = ZG.TRUNK_F,
    ["SIZE"] = 35,
    ["VALUE"] = 15,
    ["TVALUE"] = 5,
} end) end, true)

-- zil: 1dungeon.zil:1062  <OBJECT TUBE>
ZG._declare("TUBE", function() return ZG._declare_object("TUBE", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"TUBE", "TOOTH", "PASTE"},
    ["DESC"] = "tube",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT", "READBIT"},
    ["ACTION"] = ZG.TUBE_FUNCTION,
    ["LDESC"] = "There is an object which looks like a tube of toothpaste here.",
    ["CAPACITY"] = 7,
    ["SIZE"] = 5,
    ["TEXT"] = "---> Frobozz Magic Gunk Company <---\n\t  All-Purpose Gunk",
} end) end, true)

-- zil: 1dungeon.zil:1076  <OBJECT PUTTY>
ZG._declare("PUTTY", function() return ZG._declare_object("PUTTY", function() return {
    ["LOC"] = ZG.TUBE,
    ["SYNONYM"] = {"MATERIAL", "GUNK"},
    ["ADJECTIVE"] = "VISCOUS",
    ["DESC"] = "viscous material",
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
    ["SIZE"] = 6,
    ["ACTION"] = ZG.PUTTY_FCN,
} end) end, true)

-- zil: 1dungeon.zil:1085  <OBJECT ENGRAVINGS>
ZG._declare("ENGRAVINGS", function() return ZG._declare_object("ENGRAVINGS", function() return {
    ["LOC"] = ZG.ENGRAVINGS_CAVE,
    ["SYNONYM"] = {"WALL", "ENGRAVINGS", "INSCRIPTION"},
    ["ADJECTIVE"] = {"OLD", "ANCIENT"},
    ["DESC"] = "wall with engravings",
    ["FLAGS"] = {"READBIT", "SACREDBIT"},
    ["LDESC"] = "There are old engravings on the walls here.",
    ["TEXT"] = "The engravings were incised in the living rock of the cave wall by\nan unknown hand. They depict, in symbolic form, the beliefs of the\nancient Zorkers. Skillfully interwoven with the bas reliefs are excerpts\nillustrating the major religious tenets of that time. Unfortunately, a\nlater age seems to have considered them blasphemous and just as skillfully\nexcised them.",
} end) end, true)

-- zil: 1dungeon.zil:1100  <OBJECT OWNERS-MANUAL>
ZG._declare("OWNERS_MANUAL", function() return ZG._declare_object("OWNERS-MANUAL", function() return {
    ["LOC"] = ZG.STUDIO,
    ["SYNONYM"] = {"MANUAL", "PIECE", "PAPER"},
    ["ADJECTIVE"] = {"ZORK", "OWNERS", "SMALL"},
    ["DESC"] = "ZORK owner's manual",
    ["FLAGS"] = {"READBIT", "TAKEBIT"},
    ["FDESC"] = "Loosely attached to a wall is a small piece of paper.",
    ["TEXT"] = "Congratulations!\n\nYou are the privileged owner of ZORK I: The Great Underground Empire,\na self-contained and self-maintaining universe. If used and maintained\nin accordance with normal operating practices for small universes, ZORK\nwill provide many months of trouble-free operation.",
} end) end, true)

-- zil: 1dungeon.zil:1115  <OBJECT CLIMBABLE-CLIFF>
ZG._declare("CLIMBABLE_CLIFF", function() return ZG._declare_object("CLIMBABLE-CLIFF", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"WALL", "CLIFF", "WALLS", "LEDGE"},
    ["ADJECTIVE"] = {"ROCKY", "SHEER"},
    ["DESC"] = "cliff",
    ["ACTION"] = ZG.CLIFF_OBJECT,
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1123  <OBJECT WHITE-CLIFF>
ZG._declare("WHITE_CLIFF", function() return ZG._declare_object("WHITE-CLIFF", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"CLIFF", "CLIFFS"},
    ["ADJECTIVE"] = "WHITE",
    ["DESC"] = "white cliffs",
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
    ["ACTION"] = ZG.WCLIF_OBJECT,
} end) end, true)

-- zil: 1dungeon.zil:1131  <OBJECT WRENCH>
ZG._declare("WRENCH", function() return ZG._declare_object("WRENCH", function() return {
    ["LOC"] = ZG.MAINTENANCE_ROOM,
    ["SYNONYM"] = {"WRENCH", "TOOL", "TOOLS"},
    ["DESC"] = "wrench",
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
    ["SIZE"] = 10,
} end) end, true)

-- zil: 1dungeon.zil:1138  <OBJECT CONTROL-PANEL>
ZG._declare("CONTROL_PANEL", function() return ZG._declare_object("CONTROL-PANEL", function() return {
    ["LOC"] = ZG.DAM_ROOM,
    ["SYNONYM"] = "PANEL",
    ["ADJECTIVE"] = "CONTROL",
    ["DESC"] = "control panel",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 1dungeon.zil:1145  <OBJECT NEST>
ZG._declare("NEST", function() return ZG._declare_object("NEST", function() return {
    ["LOC"] = ZG.UP_A_TREE,
    ["SYNONYM"] = "NEST",
    ["ADJECTIVE"] = "BIRDS",
    ["DESC"] = "bird's nest",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT", "CONTBIT", "OPENBIT", "SEARCHBIT"},
    ["FDESC"] = "Beside you on the branch is a small bird's nest.",
    ["CAPACITY"] = 20,
} end) end, true)

-- zil: 1dungeon.zil:1154  <OBJECT EGG>
ZG._declare("EGG", function() return ZG._declare_object("EGG", function() return {
    ["LOC"] = ZG.NEST,
    ["SYNONYM"] = {"EGG", "TREASURE"},
    ["ADJECTIVE"] = {"BIRDS", "ENCRUSTED", "JEWELED"},
    ["DESC"] = "jewel-encrusted egg",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.EGG_OBJECT,
    ["VALUE"] = 5,
    ["TVALUE"] = 5,
    ["CAPACITY"] = 6,
    ["FDESC"] = "In the bird's nest is a large egg encrusted with precious jewels,\napparently scavenged by a childless songbird. The egg is covered with\nfine gold inlay, and ornamented in lapis lazuli and mother-of-pearl.\nUnlike most eggs, this one is hinged and closed with a delicate looking\nclasp. The egg appears extremely fragile.",
} end) end, true)

-- zil: 1dungeon.zil:1171  <OBJECT BROKEN-EGG>
ZG._declare("BROKEN_EGG", function() return ZG._declare_object("BROKEN-EGG", function() return {
    ["SYNONYM"] = {"EGG", "TREASURE"},
    ["ADJECTIVE"] = {"BROKEN", "BIRDS", "ENCRUSTED", "JEWEL"},
    ["DESC"] = "broken jewel-encrusted egg",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 6,
    ["TVALUE"] = 2,
    ["LDESC"] = "There is a somewhat ruined egg here.",
} end) end, true)

-- zil: 1dungeon.zil:1180  <OBJECT BAUBLE>
ZG._declare("BAUBLE", function() return ZG._declare_object("BAUBLE", function() return {
    ["SYNONYM"] = {"BAUBLE", "TREASURE"},
    ["ADJECTIVE"] = {"BRASS", "BEAUTI"},
    ["DESC"] = "beautiful brass bauble",
    ["FLAGS"] = "TAKEBIT",
    ["VALUE"] = 1,
    ["TVALUE"] = 1,
} end) end, true)

-- zil: 1dungeon.zil:1188  <OBJECT CANARY>
ZG._declare("CANARY", function() return ZG._declare_object("CANARY", function() return {
    ["LOC"] = ZG.EGG,
    ["SYNONYM"] = {"CANARY", "TREASURE"},
    ["ADJECTIVE"] = {"CLOCKWORK", "GOLD", "GOLDEN"},
    ["DESC"] = "golden clockwork canary",
    ["FLAGS"] = {"TAKEBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.CANARY_OBJECT,
    ["VALUE"] = 6,
    ["TVALUE"] = 4,
    ["FDESC"] = "There is a golden clockwork canary nestled in the egg. It has ruby\neyes and a silver beak. Through a crystal window below its left\nwing you can see intricate machinery inside. It appears to have\nwound down.",
} end) end, true)

-- zil: 1dungeon.zil:1203  <OBJECT BROKEN-CANARY>
ZG._declare("BROKEN_CANARY", function() return ZG._declare_object("BROKEN-CANARY", function() return {
    ["LOC"] = ZG.BROKEN_EGG,
    ["SYNONYM"] = {"CANARY", "TREASURE"},
    ["ADJECTIVE"] = {"BROKEN", "CLOCKWORK", "GOLD", "GOLDEN"},
    ["DESC"] = "broken clockwork canary",
    ["FLAGS"] = "TAKEBIT",
    ["ACTION"] = ZG.CANARY_OBJECT,
    ["TVALUE"] = 1,
    ["FDESC"] = "There is a golden clockwork canary nestled in the egg. It seems to\nhave recently had a bad experience. The mountings for its jewel-like\neyes are empty, and its silver beak is crumpled. Through a cracked\ncrystal window below its left wing you can see the remains of\nintricate machinery. It is not clear what result winding it would\nhave, as the mainspring seems sprung.",
} end) end, true)

-- zil: 1dungeon.zil:1225  <GLOBAL CYCLOPS-FLAG>
-- CYCLOPS_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1226  <GLOBAL DEFLATE>
-- DEFLATE is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1227  <GLOBAL DOME-FLAG>
-- DOME_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1228  <GLOBAL EMPTY-HANDED>
-- EMPTY_HANDED is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1229  <GLOBAL LLD-FLAG>
-- LLD_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1230  <GLOBAL LOW-TIDE>
-- LOW_TIDE is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1231  <GLOBAL MAGIC-FLAG>
-- MAGIC_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1232  <GLOBAL RAINBOW-FLAG>
-- RAINBOW_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1233  <GLOBAL TROLL-FLAG>
-- TROLL_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1234  <GLOBAL WON-FLAG>
-- WON_FLAG is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1235  <GLOBAL COFFIN-CURE>
-- COFFIN_CURE is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:1239  <ROOM WEST-OF-HOUSE>
ZG._declare("WEST_OF_HOUSE", function() return ZG._declare_object("WEST-OF-HOUSE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "West of House",
    ["NORTH"] = {"TO", ZG.NORTH_OF_HOUSE},
    ["SOUTH"] = {"TO", ZG.SOUTH_OF_HOUSE},
    ["NE"] = {"TO", ZG.NORTH_OF_HOUSE},
    ["SE"] = {"TO", ZG.SOUTH_OF_HOUSE},
    ["WEST"] = {"TO", ZG.FOREST_1},
    ["EAST"] = "The door is boarded and you can't remove the boards.",
    ["SW"] = {"TO", ZG.STONE_BARROW, "IF", "WON_FLAG"},
    ["IN"] = {"TO", ZG.STONE_BARROW, "IF", "WON_FLAG"},
    ["ACTION"] = ZG.WEST_HOUSE,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.WHITE_HOUSE, ZG.BOARD, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1254  <ROOM STONE-BARROW>
ZG._declare("STONE_BARROW", function() return ZG._declare_object("STONE-BARROW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are standing in front of a massive barrow of stone. In the east face\nis a huge stone door which is open. You cannot see into the dark of the tomb.",
    ["DESC"] = "Stone Barrow",
    ["NE"] = {"TO", ZG.WEST_OF_HOUSE},
    ["ACTION"] = ZG.STONE_BARROW_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1264  <ROOM NORTH-OF-HOUSE>
ZG._declare("NORTH_OF_HOUSE", function() return ZG._declare_object("NORTH-OF-HOUSE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are facing the north side of a white house. There is no door here,\nand all the windows are boarded up. To the north a narrow path winds through\nthe trees.",
    ["DESC"] = "North of House",
    ["SW"] = {"TO", ZG.WEST_OF_HOUSE},
    ["SE"] = {"TO", ZG.EAST_OF_HOUSE},
    ["WEST"] = {"TO", ZG.WEST_OF_HOUSE},
    ["EAST"] = {"TO", ZG.EAST_OF_HOUSE},
    ["NORTH"] = {"TO", ZG.PATH},
    ["SOUTH"] = "The windows are all boarded.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.BOARDED_WINDOW, ZG.BOARD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1280  <ROOM SOUTH-OF-HOUSE>
ZG._declare("SOUTH_OF_HOUSE", function() return ZG._declare_object("SOUTH-OF-HOUSE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are facing the south side of a white house. There is no door here,\nand all the windows are boarded.",
    ["DESC"] = "South of House",
    ["WEST"] = {"TO", ZG.WEST_OF_HOUSE},
    ["EAST"] = {"TO", ZG.EAST_OF_HOUSE},
    ["NE"] = {"TO", ZG.EAST_OF_HOUSE},
    ["NW"] = {"TO", ZG.WEST_OF_HOUSE},
    ["SOUTH"] = {"TO", ZG.FOREST_3},
    ["NORTH"] = "The windows are all boarded.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.BOARDED_WINDOW, ZG.BOARD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1295  <ROOM EAST-OF-HOUSE>
ZG._declare("EAST_OF_HOUSE", function() return ZG._declare_object("EAST-OF-HOUSE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Behind House",
    ["NORTH"] = {"TO", ZG.NORTH_OF_HOUSE},
    ["SOUTH"] = {"TO", ZG.SOUTH_OF_HOUSE},
    ["SW"] = {"TO", ZG.SOUTH_OF_HOUSE},
    ["NW"] = {"TO", ZG.NORTH_OF_HOUSE},
    ["EAST"] = {"TO", ZG.CLEARING},
    ["WEST"] = {"TO", ZG.KITCHEN, "IF", "KITCHEN_WINDOW", "IS", "OPEN"},
    ["IN"] = {"TO", ZG.KITCHEN, "IF", "KITCHEN_WINDOW", "IS", "OPEN"},
    ["ACTION"] = ZG.EAST_HOUSE,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.WHITE_HOUSE, ZG.KITCHEN_WINDOW, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1309  <ROOM FOREST-1>
ZG._declare("FOREST_1", function() return ZG._declare_object("FOREST-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a forest, with trees in all directions. To the east,\nthere appears to be sunlight.",
    ["DESC"] = "Forest",
    ["UP"] = "There is no tree here suitable for climbing.",
    ["NORTH"] = {"TO", ZG.GRATING_CLEARING},
    ["EAST"] = {"TO", ZG.PATH},
    ["SOUTH"] = {"TO", ZG.FOREST_3},
    ["WEST"] = "You would need a machete to go further west.",
    ["ACTION"] = ZG.FOREST_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.SONGBIRD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1324  <ROOM FOREST-2>
ZG._declare("FOREST_2", function() return ZG._declare_object("FOREST-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a dimly lit forest, with large trees all around.",
    ["DESC"] = "Forest",
    ["UP"] = "There is no tree here suitable for climbing.",
    ["NORTH"] = "The forest becomes impenetrable to the north.",
    ["EAST"] = {"TO", ZG.MOUNTAINS},
    ["SOUTH"] = {"TO", ZG.CLEARING},
    ["WEST"] = {"TO", ZG.PATH},
    ["ACTION"] = ZG.FOREST_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.SONGBIRD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1337  <ROOM MOUNTAINS>
ZG._declare("MOUNTAINS", function() return ZG._declare_object("MOUNTAINS", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The forest thins out, revealing impassable mountains.",
    ["DESC"] = "Forest",
    ["UP"] = "The mountains are impassable.",
    ["NORTH"] = {"TO", ZG.FOREST_2},
    ["EAST"] = "The mountains are impassable.",
    ["SOUTH"] = {"TO", ZG.FOREST_2},
    ["WEST"] = {"TO", ZG.FOREST_2},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.WHITE_HOUSE},
} end) end, true)

-- zil: 1dungeon.zil:1349  <ROOM FOREST-3>
ZG._declare("FOREST_3", function() return ZG._declare_object("FOREST-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a dimly lit forest, with large trees all around.",
    ["DESC"] = "Forest",
    ["UP"] = "There is no tree here suitable for climbing.",
    ["NORTH"] = {"TO", ZG.CLEARING},
    ["EAST"] = "The rank undergrowth prevents eastward movement.",
    ["SOUTH"] = "Storm-tossed trees block your way.",
    ["WEST"] = {"TO", ZG.FOREST_1},
    ["NW"] = {"TO", ZG.SOUTH_OF_HOUSE},
    ["ACTION"] = ZG.FOREST_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.SONGBIRD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1363  <ROOM PATH>
ZG._declare("PATH", function() return ZG._declare_object("PATH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a path winding through a dimly lit forest. The path heads\nnorth-south here. One particularly large tree with some low branches\nstands at the edge of the path.",
    ["DESC"] = "Forest Path",
    ["UP"] = {"TO", ZG.UP_A_TREE},
    ["NORTH"] = {"TO", ZG.GRATING_CLEARING},
    ["EAST"] = {"TO", ZG.FOREST_2},
    ["SOUTH"] = {"TO", ZG.NORTH_OF_HOUSE},
    ["WEST"] = {"TO", ZG.FOREST_1},
    ["ACTION"] = ZG.FOREST_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.SONGBIRD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1379  <ROOM UP-A-TREE>
ZG._declare("UP_A_TREE", function() return ZG._declare_object("UP-A-TREE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Up a Tree",
    ["DOWN"] = {"TO", ZG.PATH},
    ["UP"] = "You cannot climb any higher.",
    ["ACTION"] = ZG.TREE_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.FOREST, ZG.SONGBIRD, ZG.WHITE_HOUSE},
} end) end, true)

-- zil: 1dungeon.zil:1388  <ROOM GRATING-CLEARING>
ZG._declare("GRATING_CLEARING", function() return ZG._declare_object("GRATING-CLEARING", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Clearing",
    ["NORTH"] = "The forest becomes impenetrable to the north.",
    ["EAST"] = {"TO", ZG.FOREST_2},
    ["WEST"] = {"TO", ZG.FOREST_1},
    ["SOUTH"] = {"TO", ZG.PATH},
    ["DOWN"] = {"PER", ZG.GRATING_EXIT},
    ["ACTION"] = ZG.CLEARING_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.WHITE_HOUSE, ZG.GRATE},
} end) end, true)

-- zil: 1dungeon.zil:1400  <ROUTINE GRATING-EXIT ()>
ZG.actions:register("GRATING_EXIT", function()

    if ZG._T(ZG.GRATE_REVEALED) then
        if ZG._T(ZG.FSET_p(ZG.GRATE, "OPENBIT")) then
            do return ZG.GRATING_ROOM end
        else
            do local _ = ZG.TELL("The grating is closed!", ZG._TK.CR) end
            do local _ = ZG.THIS_IS_IT(ZG.GRATE) end
            do return false end
        end
    else
        do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
        do return false end
    end

end, "GRATING-EXIT")

ZG.GRATING_EXIT = ZG.actions:get("GRATING_EXIT")

-- zil: 1dungeon.zil:1410  <ROOM CLEARING>
ZG._declare("CLEARING", function() return ZG._declare_object("CLEARING", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are in a small clearing in a well marked forest path that\nextends to the east and west.",
    ["DESC"] = "Clearing",
    ["UP"] = "There is no tree here suitable for climbing.",
    ["EAST"] = {"TO", ZG.CANYON_VIEW},
    ["NORTH"] = {"TO", ZG.FOREST_2},
    ["SOUTH"] = {"TO", ZG.FOREST_3},
    ["WEST"] = {"TO", ZG.EAST_OF_HOUSE},
    ["ACTION"] = ZG.FOREST_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.TREE, ZG.SONGBIRD, ZG.WHITE_HOUSE, ZG.FOREST},
} end) end, true)

-- zil: 1dungeon.zil:1429  <ROOM KITCHEN>
ZG._declare("KITCHEN", function() return ZG._declare_object("KITCHEN", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Kitchen",
    ["EAST"] = {"TO", ZG.EAST_OF_HOUSE, "IF", "KITCHEN_WINDOW", "IS", "OPEN"},
    ["WEST"] = {"TO", ZG.LIVING_ROOM},
    ["OUT"] = {"TO", ZG.EAST_OF_HOUSE, "IF", "KITCHEN_WINDOW", "IS", "OPEN"},
    ["UP"] = {"TO", ZG.ATTIC},
    ["DOWN"] = {"TO", ZG.STUDIO, "IF", "FALSE_FLAG", "ELSE", "Only Santa Claus climbs down chimneys."},
    ["ACTION"] = ZG.KITCHEN_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["VALUE"] = 10,
    ["GLOBAL"] = {ZG.KITCHEN_WINDOW, ZG.CHIMNEY, ZG.STAIRS},
} end) end, true)

-- zil: 1dungeon.zil:1443  <ROOM ATTIC>
ZG._declare("ATTIC", function() return ZG._declare_object("ATTIC", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the attic. The only exit is a stairway leading down.",
    ["DESC"] = "Attic",
    ["DOWN"] = {"TO", ZG.KITCHEN},
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1451  <ROOM LIVING-ROOM>
ZG._declare("LIVING_ROOM", function() return ZG._declare_object("LIVING-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Living Room",
    ["EAST"] = {"TO", ZG.KITCHEN},
    ["WEST"] = {"TO", ZG.STRANGE_PASSAGE, "IF", "MAGIC_FLAG", "ELSE", "The door is nailed shut."},
    ["DOWN"] = {"PER", ZG.TRAP_DOOR_EXIT},
    ["ACTION"] = ZG.LIVING_ROOM_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = ZG.STAIRS,
    ["PSEUDO"] = {"NAILS", ZG.NAILS_PSEUDO, "NAIL", ZG.NAILS_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1466  <ROOM CELLAR>
ZG._declare("CELLAR", function() return ZG._declare_object("CELLAR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Cellar",
    ["NORTH"] = {"TO", ZG.TROLL_ROOM},
    ["SOUTH"] = {"TO", ZG.EAST_OF_CHASM},
    ["UP"] = {"TO", ZG.LIVING_ROOM, "IF", "TRAP_DOOR", "IS", "OPEN"},
    ["WEST"] = "You try to ascend the ramp, but it is impossible, and you slide back down.",
    ["ACTION"] = ZG.CELLAR_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["VALUE"] = 25,
    ["GLOBAL"] = {ZG.TRAP_DOOR, ZG.SLIDE, ZG.STAIRS},
} end) end, true)

-- zil: 1dungeon.zil:1479  <ROOM TROLL-ROOM>
ZG._declare("TROLL_ROOM", function() return ZG._declare_object("TROLL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small room with passages to the east and south and a\nforbidding hole leading west. Bloodstains and deep scratches\n(perhaps made by an axe) mar the walls.",
    ["DESC"] = "The Troll Room",
    ["SOUTH"] = {"TO", ZG.CELLAR},
    ["EAST"] = {"TO", ZG.EW_PASSAGE, "IF", "TROLL_FLAG", "ELSE", "The troll fends you off with a menacing gesture."},
    ["WEST"] = {"TO", ZG.MAZE_1, "IF", "TROLL_FLAG", "ELSE", "The troll fends you off with a menacing gesture."},
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.TROLL_ROOM_F,
} end) end, true)

-- zil: 1dungeon.zil:1494  <ROOM EAST-OF-CHASM>
ZG._declare("EAST_OF_CHASM", function() return ZG._declare_object("EAST-OF-CHASM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on the east edge of a chasm, the bottom of which cannot be\nseen. A narrow passage goes north, and the path you are on continues\nto the east.",
    ["DESC"] = "East of Chasm",
    ["NORTH"] = {"TO", ZG.CELLAR},
    ["EAST"] = {"TO", ZG.GALLERY},
    ["DOWN"] = "The chasm probably leads straight to the infernal regions.",
    ["FLAGS"] = "RLANDBIT",
    ["PSEUDO"] = {"CHASM", ZG.CHASM_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1507  <ROOM GALLERY>
ZG._declare("GALLERY", function() return ZG._declare_object("GALLERY", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is an art gallery. Most of the paintings have been stolen by\nvandals with exceptional taste. The vandals left through either the\nnorth or west exits.",
    ["DESC"] = "Gallery",
    ["WEST"] = {"TO", ZG.EAST_OF_CHASM},
    ["NORTH"] = {"TO", ZG.STUDIO},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1518  <ROOM STUDIO>
ZG._declare("STUDIO", function() return ZG._declare_object("STUDIO", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This appears to have been an artist's studio. The walls and floors are\nsplattered with paints of 69 different colors. Strangely enough, nothing\nof value is hanging here. At the south end of the room is an open door\n(also covered with paint). A dark and narrow chimney leads up from a\nfireplace; although you might be able to get up it, it seems unlikely\nyou could get back down.",
    ["DESC"] = "Studio",
    ["SOUTH"] = {"TO", ZG.GALLERY},
    ["UP"] = {"PER", ZG.UP_CHIMNEY_FUNCTION},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.CHIMNEY,
    ["PSEUDO"] = {"DOOR", ZG.DOOR_PSEUDO, "PAINT", ZG.PAINT_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1538  <ROOM MAZE-1>
ZG._declare("MAZE_1", function() return ZG._declare_object("MAZE-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["EAST"] = {"TO", ZG.TROLL_ROOM},
    ["NORTH"] = {"TO", ZG.MAZE_1},
    ["SOUTH"] = {"TO", ZG.MAZE_2},
    ["WEST"] = {"TO", ZG.MAZE_4},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1548  <ROOM MAZE-2>
ZG._declare("MAZE_2", function() return ZG._declare_object("MAZE-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["SOUTH"] = {"TO", ZG.MAZE_1},
    ["DOWN"] = {"PER", ZG.MAZE_DIODES},
    ["EAST"] = {"TO", ZG.MAZE_3},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1557  <ROOM MAZE-3>
ZG._declare("MAZE_3", function() return ZG._declare_object("MAZE-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["WEST"] = {"TO", ZG.MAZE_2},
    ["NORTH"] = {"TO", ZG.MAZE_4},
    ["UP"] = {"TO", ZG.MAZE_5},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1566  <ROOM MAZE-4>
ZG._declare("MAZE_4", function() return ZG._declare_object("MAZE-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["WEST"] = {"TO", ZG.MAZE_3},
    ["NORTH"] = {"TO", ZG.MAZE_1},
    ["EAST"] = {"TO", ZG.DEAD_END_1},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1575  <ROOM DEAD-END-1>
ZG._declare("DEAD_END_1", function() return ZG._declare_object("DEAD-END-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to a dead end in the maze.",
    ["SOUTH"] = {"TO", ZG.MAZE_4},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1582  <ROOM MAZE-5>
ZG._declare("MAZE_5", function() return ZG._declare_object("MAZE-5", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.\nA skeleton, probably the remains of a luckless adventurer, lies here.",
    ["DESC"] = "Maze",
    ["EAST"] = {"TO", ZG.DEAD_END_2},
    ["NORTH"] = {"TO", ZG.MAZE_3},
    ["SW"] = {"TO", ZG.MAZE_6},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1592  <ROOM DEAD-END-2>
ZG._declare("DEAD_END_2", function() return ZG._declare_object("DEAD-END-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to a dead end in the maze.",
    ["WEST"] = {"TO", ZG.MAZE_5},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1599  <ROOM MAZE-6>
ZG._declare("MAZE_6", function() return ZG._declare_object("MAZE-6", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["DOWN"] = {"TO", ZG.MAZE_5},
    ["EAST"] = {"TO", ZG.MAZE_7},
    ["WEST"] = {"TO", ZG.MAZE_6},
    ["UP"] = {"TO", ZG.MAZE_9},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1609  <ROOM MAZE-7>
ZG._declare("MAZE_7", function() return ZG._declare_object("MAZE-7", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["UP"] = {"TO", ZG.MAZE_14},
    ["WEST"] = {"TO", ZG.MAZE_6},
    ["DOWN"] = {"PER", ZG.MAZE_DIODES},
    ["EAST"] = {"TO", ZG.MAZE_8},
    ["SOUTH"] = {"TO", ZG.MAZE_15},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1620  <ROOM MAZE-8>
ZG._declare("MAZE_8", function() return ZG._declare_object("MAZE-8", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["NE"] = {"TO", ZG.MAZE_7},
    ["WEST"] = {"TO", ZG.MAZE_8},
    ["SE"] = {"TO", ZG.DEAD_END_3},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1629  <ROOM DEAD-END-3>
ZG._declare("DEAD_END_3", function() return ZG._declare_object("DEAD-END-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to a dead end in the maze.",
    ["NORTH"] = {"TO", ZG.MAZE_8},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1636  <ROOM MAZE-9>
ZG._declare("MAZE_9", function() return ZG._declare_object("MAZE-9", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["NORTH"] = {"TO", ZG.MAZE_6},
    ["DOWN"] = {"PER", ZG.MAZE_DIODES},
    ["EAST"] = {"TO", ZG.MAZE_10},
    ["SOUTH"] = {"TO", ZG.MAZE_13},
    ["WEST"] = {"TO", ZG.MAZE_12},
    ["NW"] = {"TO", ZG.MAZE_9},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1648  <ROOM MAZE-10>
ZG._declare("MAZE_10", function() return ZG._declare_object("MAZE-10", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["EAST"] = {"TO", ZG.MAZE_9},
    ["WEST"] = {"TO", ZG.MAZE_13},
    ["UP"] = {"TO", ZG.MAZE_11},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1657  <ROOM MAZE-11>
ZG._declare("MAZE_11", function() return ZG._declare_object("MAZE-11", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["NE"] = {"TO", ZG.GRATING_ROOM},
    ["DOWN"] = {"TO", ZG.MAZE_10},
    ["NW"] = {"TO", ZG.MAZE_13},
    ["SW"] = {"TO", ZG.MAZE_12},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1667  <ROOM GRATING-ROOM>
ZG._declare("GRATING_ROOM", function() return ZG._declare_object("GRATING-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Grating Room",
    ["SW"] = {"TO", ZG.MAZE_11},
    ["UP"] = {"TO", ZG.GRATING_CLEARING, "IF", "GRATE", "IS", "OPEN", "ELSE", "The grating is closed."},
    ["ACTION"] = ZG.MAZE_11_FCN,
    ["GLOBAL"] = ZG.GRATE,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1677  <ROOM MAZE-12>
ZG._declare("MAZE_12", function() return ZG._declare_object("MAZE-12", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["DOWN"] = {"PER", ZG.MAZE_DIODES},
    ["SW"] = {"TO", ZG.MAZE_11},
    ["EAST"] = {"TO", ZG.MAZE_13},
    ["UP"] = {"TO", ZG.MAZE_9},
    ["NORTH"] = {"TO", ZG.DEAD_END_4},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1688  <ROOM DEAD-END-4>
ZG._declare("DEAD_END_4", function() return ZG._declare_object("DEAD-END-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to a dead end in the maze.",
    ["SOUTH"] = {"TO", ZG.MAZE_12},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1695  <ROOM MAZE-13>
ZG._declare("MAZE_13", function() return ZG._declare_object("MAZE-13", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["EAST"] = {"TO", ZG.MAZE_9},
    ["DOWN"] = {"TO", ZG.MAZE_12},
    ["SOUTH"] = {"TO", ZG.MAZE_10},
    ["WEST"] = {"TO", ZG.MAZE_11},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1705  <ROOM MAZE-14>
ZG._declare("MAZE_14", function() return ZG._declare_object("MAZE-14", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["WEST"] = {"TO", ZG.MAZE_15},
    ["NW"] = {"TO", ZG.MAZE_14},
    ["NE"] = {"TO", ZG.MAZE_7},
    ["SOUTH"] = {"TO", ZG.MAZE_7},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1715  <ROOM MAZE-15>
ZG._declare("MAZE_15", function() return ZG._declare_object("MAZE-15", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is part of a maze of twisty little passages, all alike.",
    ["DESC"] = "Maze",
    ["WEST"] = {"TO", ZG.MAZE_14},
    ["SOUTH"] = {"TO", ZG.MAZE_7},
    ["SE"] = {"TO", ZG.CYCLOPS_ROOM},
    ["FLAGS"] = {"RLANDBIT", "MAZEBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1728  <ROOM CYCLOPS-ROOM>
ZG._declare("CYCLOPS_ROOM", function() return ZG._declare_object("CYCLOPS-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Cyclops Room",
    ["NW"] = {"TO", ZG.MAZE_15},
    ["EAST"] = {"TO", ZG.STRANGE_PASSAGE, "IF", "MAGIC_FLAG", "ELSE", "The east wall is solid rock."},
    ["UP"] = {"TO", ZG.TREASURE_ROOM, "IF", "CYCLOPS_FLAG", "ELSE", "The cyclops doesn't look like he'll let you past."},
    ["ACTION"] = ZG.CYCLOPS_ROOM_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1740  <ROOM STRANGE-PASSAGE>
ZG._declare("STRANGE_PASSAGE", function() return ZG._declare_object("STRANGE-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a long passage. To the west is one entrance. On the\neast there is an old wooden door, with a large opening in it (about\ncyclops sized).",
    ["DESC"] = "Strange Passage",
    ["WEST"] = {"TO", ZG.CYCLOPS_ROOM},
    ["IN"] = {"TO", ZG.CYCLOPS_ROOM},
    ["EAST"] = {"TO", ZG.LIVING_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1752  <ROOM TREASURE-ROOM>
ZG._declare("TREASURE_ROOM", function() return ZG._declare_object("TREASURE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a large room, whose east wall is solid granite. A number\nof discarded bags, which crumble at your touch, are scattered about\non the floor. There is an exit down a staircase.",
    ["DESC"] = "Treasure Room",
    ["DOWN"] = {"TO", ZG.CYCLOPS_ROOM},
    ["ACTION"] = ZG.TREASURE_ROOM_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["VALUE"] = 25,
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1769  <ROOM RESERVOIR-SOUTH>
ZG._declare("RESERVOIR_SOUTH", function() return ZG._declare_object("RESERVOIR-SOUTH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Reservoir South",
    ["SE"] = {"TO", ZG.DEEP_CANYON},
    ["SW"] = {"TO", ZG.CHASM_ROOM},
    ["EAST"] = {"TO", ZG.DAM_ROOM},
    ["WEST"] = {"TO", ZG.STREAM_VIEW},
    ["NORTH"] = {"TO", ZG.RESERVOIR, "IF", "LOW_TIDE", "ELSE", "You would drown."},
    ["ACTION"] = ZG.RESERVOIR_SOUTH_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.GLOBAL_WATER,
    ["PSEUDO"] = {"LAKE", ZG.LAKE_PSEUDO, "CHASM", ZG.CHASM_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1783  <ROOM RESERVOIR>
ZG._declare("RESERVOIR", function() return ZG._declare_object("RESERVOIR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Reservoir",
    ["NORTH"] = {"TO", ZG.RESERVOIR_NORTH},
    ["SOUTH"] = {"TO", ZG.RESERVOIR_SOUTH},
    ["UP"] = {"TO", ZG.IN_STREAM},
    ["WEST"] = {"TO", ZG.IN_STREAM},
    ["DOWN"] = "The dam blocks your way.",
    ["ACTION"] = ZG.RESERVOIR_FCN,
    ["FLAGS"] = "NONLANDBIT",
    ["PSEUDO"] = {"STREAM", ZG.STREAM_PSEUDO},
    ["GLOBAL"] = ZG.GLOBAL_WATER,
} end) end, true)

-- zil: 1dungeon.zil:1796  <ROOM RESERVOIR-NORTH>
ZG._declare("RESERVOIR_NORTH", function() return ZG._declare_object("RESERVOIR-NORTH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Reservoir North",
    ["NORTH"] = {"TO", ZG.ATLANTIS_ROOM},
    ["SOUTH"] = {"TO", ZG.RESERVOIR, "IF", "LOW_TIDE", "ELSE", "You would drown."},
    ["ACTION"] = ZG.RESERVOIR_NORTH_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.STAIRS},
    ["PSEUDO"] = {"LAKE", ZG.LAKE_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1807  <ROOM STREAM-VIEW>
ZG._declare("STREAM_VIEW", function() return ZG._declare_object("STREAM-VIEW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are standing on a path beside a gently flowing stream. The path\nfollows the stream, which flows from west to east.",
    ["DESC"] = "Stream View",
    ["EAST"] = {"TO", ZG.RESERVOIR_SOUTH},
    ["WEST"] = "The stream emerges from a spot too small for you to enter.",
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.GLOBAL_WATER,
    ["PSEUDO"] = {"STREAM", ZG.STREAM_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1819  <ROOM IN-STREAM>
ZG._declare("IN_STREAM", function() return ZG._declare_object("IN-STREAM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on the gently flowing stream. The upstream route is too narrow\nto navigate, and the downstream route is invisible due to twisting\nwalls. There is a narrow beach to land on.",
    ["DESC"] = "Stream",
    ["UP"] = "The channel is too narrow.",
    ["WEST"] = "The channel is too narrow.",
    ["LAND"] = {"TO", ZG.STREAM_VIEW},
    ["DOWN"] = {"TO", ZG.RESERVOIR},
    ["EAST"] = {"TO", ZG.RESERVOIR},
    ["FLAGS"] = "NONLANDBIT",
    ["GLOBAL"] = ZG.GLOBAL_WATER,
    ["PSEUDO"] = {"STREAM", ZG.STREAM_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:1839  <ROOM MIRROR-ROOM-1>
ZG._declare("MIRROR_ROOM_1", function() return ZG._declare_object("MIRROR-ROOM-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Mirror Room",
    ["NORTH"] = {"TO", ZG.COLD_PASSAGE},
    ["WEST"] = {"TO", ZG.TWISTING_PASSAGE},
    ["EAST"] = {"TO", ZG.SMALL_CAVE},
    ["ACTION"] = ZG.MIRROR_ROOM,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1848  <ROOM MIRROR-ROOM-2>
ZG._declare("MIRROR_ROOM_2", function() return ZG._declare_object("MIRROR-ROOM-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Mirror Room",
    ["WEST"] = {"TO", ZG.WINDING_PASSAGE},
    ["NORTH"] = {"TO", ZG.NARROW_PASSAGE},
    ["EAST"] = {"TO", ZG.TINY_CAVE},
    ["ACTION"] = ZG.MIRROR_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 1dungeon.zil:1857  <ROOM SMALL-CAVE>
ZG._declare("SMALL_CAVE", function() return ZG._declare_object("SMALL-CAVE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a tiny cave with entrances west and north, and a staircase\nleading down.",
    ["DESC"] = "Cave",
    ["NORTH"] = {"TO", ZG.MIRROR_ROOM_1},
    ["DOWN"] = {"TO", ZG.ATLANTIS_ROOM},
    ["SOUTH"] = {"TO", ZG.ATLANTIS_ROOM},
    ["WEST"] = {"TO", ZG.TWISTING_PASSAGE},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1870  <ROOM TINY-CAVE>
ZG._declare("TINY_CAVE", function() return ZG._declare_object("TINY-CAVE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a tiny cave with entrances west and north, and a dark,\nforbidding staircase leading down.",
    ["DESC"] = "Cave",
    ["NORTH"] = {"TO", ZG.MIRROR_ROOM_2},
    ["WEST"] = {"TO", ZG.WINDING_PASSAGE},
    ["DOWN"] = {"TO", ZG.ENTRANCE_TO_HADES},
    ["ACTION"] = ZG.CAVE2_ROOM,
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1883  <ROOM COLD-PASSAGE>
ZG._declare("COLD_PASSAGE", function() return ZG._declare_object("COLD-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a cold and damp corridor where a long east-west passageway\nturns into a southward path.",
    ["DESC"] = "Cold Passage",
    ["SOUTH"] = {"TO", ZG.MIRROR_ROOM_1},
    ["WEST"] = {"TO", ZG.SLIDE_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1893  <ROOM NARROW-PASSAGE>
ZG._declare("NARROW_PASSAGE", function() return ZG._declare_object("NARROW-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a long and narrow corridor where a long north-south passageway\nbriefly narrows even further.",
    ["DESC"] = "Narrow Passage",
    ["NORTH"] = {"TO", ZG.ROUND_ROOM},
    ["SOUTH"] = {"TO", ZG.MIRROR_ROOM_2},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1903  <ROOM WINDING-PASSAGE>
ZG._declare("WINDING_PASSAGE", function() return ZG._declare_object("WINDING-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a winding passage. It seems that there are only exits\non the east and north.",
    ["DESC"] = "Winding Passage",
    ["NORTH"] = {"TO", ZG.MIRROR_ROOM_2},
    ["EAST"] = {"TO", ZG.TINY_CAVE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1913  <ROOM TWISTING-PASSAGE>
ZG._declare("TWISTING_PASSAGE", function() return ZG._declare_object("TWISTING-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a winding passage. It seems that there are only exits\non the east and north.",
    ["DESC"] = "Twisting Passage",
    ["NORTH"] = {"TO", ZG.MIRROR_ROOM_1},
    ["EAST"] = {"TO", ZG.SMALL_CAVE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1923  <ROOM ATLANTIS-ROOM>
ZG._declare("ATLANTIS_ROOM", function() return ZG._declare_object("ATLANTIS-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is an ancient room, long under water. There is an exit to\nthe south and a staircase leading up.",
    ["DESC"] = "Atlantis Room",
    ["UP"] = {"TO", ZG.SMALL_CAVE},
    ["SOUTH"] = {"TO", ZG.RESERVOIR_NORTH},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1938  <ROOM EW-PASSAGE>
ZG._declare("EW_PASSAGE", function() return ZG._declare_object("EW-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a narrow east-west passageway. There is a narrow stairway\nleading down at the north end of the room.",
    ["DESC"] = "East-West Passage",
    ["EAST"] = {"TO", ZG.ROUND_ROOM},
    ["WEST"] = {"TO", ZG.TROLL_ROOM},
    ["DOWN"] = {"TO", ZG.CHASM_ROOM},
    ["NORTH"] = {"TO", ZG.CHASM_ROOM},
    ["FLAGS"] = "RLANDBIT",
    ["VALUE"] = 5,
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1952  <ROOM ROUND-ROOM>
ZG._declare("ROUND_ROOM", function() return ZG._declare_object("ROUND-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a circular stone room with passages in all directions. Several\nof them have unfortunately been blocked by cave-ins.",
    ["DESC"] = "Round Room",
    ["EAST"] = {"TO", ZG.LOUD_ROOM},
    ["WEST"] = {"TO", ZG.EW_PASSAGE},
    ["NORTH"] = {"TO", ZG.NS_PASSAGE},
    ["SOUTH"] = {"TO", ZG.NARROW_PASSAGE},
    ["SE"] = {"TO", ZG.ENGRAVINGS_CAVE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:1965  <ROOM DEEP-CANYON>
ZG._declare("DEEP_CANYON", function() return ZG._declare_object("DEEP-CANYON", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Deep Canyon",
    ["NW"] = {"TO", ZG.RESERVOIR_SOUTH},
    ["EAST"] = {"TO", ZG.DAM_ROOM},
    ["SW"] = {"TO", ZG.NS_PASSAGE},
    ["DOWN"] = {"TO", ZG.LOUD_ROOM},
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.DEEP_CANYON_F,
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1976  <ROOM DAMP-CAVE>
ZG._declare("DAMP_CAVE", function() return ZG._declare_object("DAMP-CAVE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This cave has exits to the west and east, and narrows to a crack toward\nthe south. The earth is particularly damp here.",
    ["DESC"] = "Damp Cave",
    ["WEST"] = {"TO", ZG.LOUD_ROOM},
    ["EAST"] = {"TO", ZG.WHITE_CLIFFS_NORTH},
    ["SOUTH"] = "It is too narrow for most insects.",
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.CRACK,
} end) end, true)

-- zil: 1dungeon.zil:1988  <ROOM LOUD-ROOM>
ZG._declare("LOUD_ROOM", function() return ZG._declare_object("LOUD-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Loud Room",
    ["EAST"] = {"TO", ZG.DAMP_CAVE},
    ["WEST"] = {"TO", ZG.ROUND_ROOM},
    ["UP"] = {"TO", ZG.DEEP_CANYON},
    ["ACTION"] = ZG.LOUD_ROOM_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:1998  <ROOM NS-PASSAGE>
ZG._declare("NS_PASSAGE", function() return ZG._declare_object("NS-PASSAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a high north-south passage, which forks to the northeast.",
    ["DESC"] = "North-South Passage",
    ["NORTH"] = {"TO", ZG.CHASM_ROOM},
    ["NE"] = {"TO", ZG.DEEP_CANYON},
    ["SOUTH"] = {"TO", ZG.ROUND_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2008  <ROOM CHASM-ROOM>
ZG._declare("CHASM_ROOM", function() return ZG._declare_object("CHASM-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "A chasm runs southwest to northeast and the path follows it. You are\non the south side of the chasm, where a crack opens into a passage.",
    ["DESC"] = "Chasm",
    ["NE"] = {"TO", ZG.RESERVOIR_SOUTH},
    ["SW"] = {"TO", ZG.EW_PASSAGE},
    ["UP"] = {"TO", ZG.EW_PASSAGE},
    ["SOUTH"] = {"TO", ZG.NS_PASSAGE},
    ["DOWN"] = "Are you out of your mind?",
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.CRACK, ZG.STAIRS},
    ["PSEUDO"] = {"CHASM", ZG.CHASM_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2027  <ROOM ENTRANCE-TO-HADES>
ZG._declare("ENTRANCE_TO_HADES", function() return ZG._declare_object("ENTRANCE-TO-HADES", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Entrance to Hades",
    ["UP"] = {"TO", ZG.TINY_CAVE},
    ["IN"] = {"TO", ZG.LAND_OF_LIVING_DEAD, "IF", "LLD_FLAG", "ELSE", "Some invisible force prevents you from passing through the gate."},
    ["SOUTH"] = {"TO", ZG.LAND_OF_LIVING_DEAD, "IF", "LLD_FLAG", "ELSE", "Some invisible force prevents you from passing through the gate."},
    ["ACTION"] = ZG.LLD_ROOM,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.BODIES,
    ["PSEUDO"] = {"GATE", ZG.GATE_PSEUDO, "GATES", ZG.GATE_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2040  <ROOM LAND-OF-LIVING-DEAD>
ZG._declare("LAND_OF_LIVING_DEAD", function() return ZG._declare_object("LAND-OF-LIVING-DEAD", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You have entered the Land of the Living Dead. Thousands of lost souls\ncan be heard weeping and moaning. In the corner are stacked the remains\nof dozens of previous adventurers less fortunate than yourself.\nA passage exits to the north.",
    ["DESC"] = "Land of the Dead",
    ["OUT"] = {"TO", ZG.ENTRANCE_TO_HADES},
    ["NORTH"] = {"TO", ZG.ENTRANCE_TO_HADES},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.BODIES,
} end) end, true)

-- zil: 1dungeon.zil:2057  <ROOM ENGRAVINGS-CAVE>
ZG._declare("ENGRAVINGS_CAVE", function() return ZG._declare_object("ENGRAVINGS-CAVE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You have entered a low cave with passages leading northwest and east.",
    ["DESC"] = "Engravings Cave",
    ["NW"] = {"TO", ZG.ROUND_ROOM},
    ["EAST"] = {"TO", ZG.DOME_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2066  <ROOM EGYPT-ROOM>
ZG._declare("EGYPT_ROOM", function() return ZG._declare_object("EGYPT-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a room which looks like an Egyptian tomb. There is an\nascending staircase to the west.",
    ["DESC"] = "Egyptian Room",
    ["WEST"] = {"TO", ZG.NORTH_TEMPLE},
    ["UP"] = {"TO", ZG.NORTH_TEMPLE},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:2077  <ROOM DOME-ROOM>
ZG._declare("DOME_ROOM", function() return ZG._declare_object("DOME-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dome Room",
    ["WEST"] = {"TO", ZG.ENGRAVINGS_CAVE},
    ["DOWN"] = {"TO", ZG.TORCH_ROOM, "IF", "DOME_FLAG", "ELSE", "You cannot go down without fracturing many bones."},
    ["ACTION"] = ZG.DOME_ROOM_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["PSEUDO"] = {"DOME", ZG.DOME_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2087  <ROOM TORCH-ROOM>
ZG._declare("TORCH_ROOM", function() return ZG._declare_object("TORCH-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Torch Room",
    ["UP"] = "You cannot reach the rope.",
    ["SOUTH"] = {"TO", ZG.NORTH_TEMPLE},
    ["DOWN"] = {"TO", ZG.NORTH_TEMPLE},
    ["ACTION"] = ZG.TORCH_ROOM_FCN,
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
    ["PSEUDO"] = {"DOME", ZG.DOME_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2098  <ROOM NORTH-TEMPLE>
ZG._declare("NORTH_TEMPLE", function() return ZG._declare_object("NORTH-TEMPLE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the north end of a large temple. On the east wall is an\nancient inscription, probably a prayer in a long-forgotten language.\nBelow the prayer is a staircase leading down. The west wall is solid\ngranite. The exit to the north end of the room is through huge\nmarble pillars.",
    ["DESC"] = "Temple",
    ["DOWN"] = {"TO", ZG.EGYPT_ROOM},
    ["EAST"] = {"TO", ZG.EGYPT_ROOM},
    ["NORTH"] = {"TO", ZG.TORCH_ROOM},
    ["OUT"] = {"TO", ZG.TORCH_ROOM},
    ["UP"] = {"TO", ZG.TORCH_ROOM},
    ["SOUTH"] = {"TO", ZG.SOUTH_TEMPLE},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 1dungeon.zil:2116  <ROOM SOUTH-TEMPLE>
ZG._declare("SOUTH_TEMPLE", function() return ZG._declare_object("SOUTH-TEMPLE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the south end of a large temple. In front of you is what\nappears to be an altar. In one corner is a small hole in the floor\nwhich leads into darkness. You probably could not get back up it.",
    ["DESC"] = "Altar",
    ["NORTH"] = {"TO", ZG.NORTH_TEMPLE},
    ["DOWN"] = {"TO", ZG.TINY_CAVE, "IF", "COFFIN_CURE", "ELSE", "You haven't a prayer of getting the coffin down there."},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["ACTION"] = ZG.SOUTH_TEMPLE_FCN,
} end) end, true)

-- zil: 1dungeon.zil:2135  <ROOM DAM-ROOM>
ZG._declare("DAM_ROOM", function() return ZG._declare_object("DAM-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dam",
    ["SOUTH"] = {"TO", ZG.DEEP_CANYON},
    ["DOWN"] = {"TO", ZG.DAM_BASE},
    ["EAST"] = {"TO", ZG.DAM_BASE},
    ["NORTH"] = {"TO", ZG.DAM_LOBBY},
    ["WEST"] = {"TO", ZG.RESERVOIR_SOUTH},
    ["ACTION"] = ZG.DAM_ROOM_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.GLOBAL_WATER,
} end) end, true)

-- zil: 1dungeon.zil:2147  <ROOM DAM-LOBBY>
ZG._declare("DAM_LOBBY", function() return ZG._declare_object("DAM-LOBBY", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This room appears to have been the waiting room for groups touring\nthe dam. There are open doorways here to the north and east marked\n\"Private\", and there is a path leading south over the top of the dam.",
    ["DESC"] = "Dam Lobby",
    ["SOUTH"] = {"TO", ZG.DAM_ROOM},
    ["NORTH"] = {"TO", ZG.MAINTENANCE_ROOM},
    ["EAST"] = {"TO", ZG.MAINTENANCE_ROOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 1dungeon.zil:2159  <ROOM MAINTENANCE-ROOM>
ZG._declare("MAINTENANCE_ROOM", function() return ZG._declare_object("MAINTENANCE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is what appears to have been the maintenance room for Flood\nControl Dam #3. Apparently, this room has been ransacked recently, for\nmost of the valuable equipment is gone. On the wall in front of you is a\ngroup of buttons colored blue, yellow, brown, and red. There are doorways to\nthe west and south.",
    ["DESC"] = "Maintenance Room",
    ["SOUTH"] = {"TO", ZG.DAM_LOBBY},
    ["WEST"] = {"TO", ZG.DAM_LOBBY},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2176  <ROOM DAM-BASE>
ZG._declare("DAM_BASE", function() return ZG._declare_object("DAM-BASE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are at the base of Flood Control Dam #3, which looms above you\nand to the north. The river Frigid is flowing by here. Along the\nriver are the White Cliffs which seem to form giant walls stretching\nfrom north to south along the shores of the river as it winds its\nway downstream.",
    ["DESC"] = "Dam Base",
    ["NORTH"] = {"TO", ZG.DAM_ROOM},
    ["UP"] = {"TO", ZG.DAM_ROOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2190  <ROOM RIVER-1>
ZG._declare("RIVER_1", function() return ZG._declare_object("RIVER-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on the Frigid River in the vicinity of the Dam. The river\nflows quietly here. There is a landing on the west shore.",
    ["DESC"] = "Frigid River",
    ["UP"] = "You cannot go upstream due to strong currents.",
    ["WEST"] = {"TO", ZG.DAM_BASE},
    ["LAND"] = {"TO", ZG.DAM_BASE},
    ["DOWN"] = {"TO", ZG.RIVER_2},
    ["EAST"] = "The White Cliffs prevent your landing here.",
    ["FLAGS"] = {"NONLANDBIT", "SACREDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2204  <ROOM RIVER-2>
ZG._declare("RIVER_2", function() return ZG._declare_object("RIVER-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The river turns a corner here making it impossible to see the\nDam. The White Cliffs loom on the east bank and large rocks prevent\nlanding on the west.",
    ["DESC"] = "Frigid River",
    ["UP"] = "You cannot go upstream due to strong currents.",
    ["DOWN"] = {"TO", ZG.RIVER_3},
    ["LAND"] = "There is no safe landing spot here.",
    ["EAST"] = "The White Cliffs prevent your landing here.",
    ["WEST"] = "Just in time you steer away from the rocks.",
    ["FLAGS"] = {"NONLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2219  <ROOM RIVER-3>
ZG._declare("RIVER_3", function() return ZG._declare_object("RIVER-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The river descends here into a valley. There is a narrow beach on the\nwest shore below the cliffs. In the distance a faint rumbling can be\nheard.",
    ["DESC"] = "Frigid River",
    ["UP"] = "You cannot go upstream due to strong currents.",
    ["DOWN"] = {"TO", ZG.RIVER_4},
    ["LAND"] = {"TO", ZG.WHITE_CLIFFS_NORTH},
    ["WEST"] = {"TO", ZG.WHITE_CLIFFS_NORTH},
    ["FLAGS"] = {"NONLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2233  <ROOM WHITE-CLIFFS-NORTH>
ZG._declare("WHITE_CLIFFS_NORTH", function() return ZG._declare_object("WHITE-CLIFFS-NORTH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a narrow strip of beach which runs along the base of the\nWhite Cliffs. There is a narrow path heading south along the Cliffs\nand a tight passage leading west into the cliffs themselves.",
    ["DESC"] = "White Cliffs Beach",
    ["SOUTH"] = {"TO", ZG.WHITE_CLIFFS_SOUTH, "IF", "DEFLATE", "ELSE", "The path is too narrow."},
    ["WEST"] = {"TO", ZG.DAMP_CAVE, "IF", "DEFLATE", "ELSE", "The path is too narrow."},
    ["ACTION"] = ZG.WHITE_CLIFFS_FUNCTION,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.WHITE_CLIFF, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2246  <ROOM WHITE-CLIFFS-SOUTH>
ZG._declare("WHITE_CLIFFS_SOUTH", function() return ZG._declare_object("WHITE-CLIFFS-SOUTH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a rocky, narrow strip of beach beside the Cliffs. A\nnarrow path leads north along the shore.",
    ["DESC"] = "White Cliffs Beach",
    ["NORTH"] = {"TO", ZG.WHITE_CLIFFS_NORTH, "IF", "DEFLATE", "ELSE", "The path is too narrow."},
    ["ACTION"] = ZG.WHITE_CLIFFS_FUNCTION,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.WHITE_CLIFF, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2258  <ROOM RIVER-4>
ZG._declare("RIVER_4", function() return ZG._declare_object("RIVER-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The river is running faster here and the sound ahead appears to be\nthat of rushing water. On the east shore is a sandy beach. A small\narea of beach can also be seen below the cliffs on the west shore.",
    ["DESC"] = "Frigid River",
    ["UP"] = "You cannot go upstream due to strong currents.",
    ["DOWN"] = {"TO", ZG.RIVER_5},
    ["LAND"] = "You can land either to the east or the west.",
    ["WEST"] = {"TO", ZG.WHITE_CLIFFS_SOUTH},
    ["EAST"] = {"TO", ZG.SANDY_BEACH},
    ["ACTION"] = ZG.RIVR4_ROOM,
    ["FLAGS"] = {"NONLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2274  <ROOM RIVER-5>
ZG._declare("RIVER_5", function() return ZG._declare_object("RIVER-5", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The sound of rushing water is nearly unbearable here. On the east\nshore is a large landing area.",
    ["DESC"] = "Frigid River",
    ["UP"] = "You cannot go upstream due to strong currents.",
    ["EAST"] = {"TO", ZG.SHORE},
    ["LAND"] = {"TO", ZG.SHORE},
    ["FLAGS"] = {"NONLANDBIT", "SACREDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2286  <ROOM SHORE>
ZG._declare("SHORE", function() return ZG._declare_object("SHORE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on the east shore of the river. The water here seems somewhat\ntreacherous. A path travels from north to south here, the south end\nquickly turning around a sharp corner.",
    ["DESC"] = "Shore",
    ["NORTH"] = {"TO", ZG.SANDY_BEACH},
    ["SOUTH"] = {"TO", ZG.ARAGAIN_FALLS},
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2298  <ROOM SANDY-BEACH>
ZG._declare("SANDY_BEACH", function() return ZG._declare_object("SANDY-BEACH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a large sandy beach on the east shore of the river, which is\nflowing quickly by. A path runs beside the river to the south here, and\na passage is partially buried in sand to the northeast.",
    ["DESC"] = "Sandy Beach",
    ["NE"] = {"TO", ZG.SANDY_CAVE},
    ["SOUTH"] = {"TO", ZG.SHORE},
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2311  <ROOM SANDY-CAVE>
ZG._declare("SANDY_CAVE", function() return ZG._declare_object("SANDY-CAVE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a sand-filled cave whose exit is to the southwest.",
    ["DESC"] = "Sandy Cave",
    ["SW"] = {"TO", ZG.SANDY_BEACH},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2319  <ROOM ARAGAIN-FALLS>
ZG._declare("ARAGAIN_FALLS", function() return ZG._declare_object("ARAGAIN-FALLS", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Aragain Falls",
    ["WEST"] = {"TO", ZG.ON_RAINBOW, "IF", "RAINBOW_FLAG"},
    ["DOWN"] = "It's a long way...",
    ["NORTH"] = {"TO", ZG.SHORE},
    ["UP"] = {"TO", ZG.ON_RAINBOW, "IF", "RAINBOW_FLAG"},
    ["ACTION"] = ZG.FALLS_ROOM,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RIVER, ZG.RAINBOW},
} end) end, true)

-- zil: 1dungeon.zil:2330  <ROOM ON-RAINBOW>
ZG._declare("ON_RAINBOW", function() return ZG._declare_object("ON-RAINBOW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on top of a rainbow (I bet you never thought you would walk\non a rainbow), with a magnificent view of the Falls. The rainbow\ntravels east-west here.",
    ["DESC"] = "On the Rainbow",
    ["WEST"] = {"TO", ZG.END_OF_RAINBOW},
    ["EAST"] = {"TO", ZG.ARAGAIN_FALLS},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = ZG.RAINBOW,
} end) end, true)

-- zil: 1dungeon.zil:2342  <ROOM END-OF-RAINBOW>
ZG._declare("END_OF_RAINBOW", function() return ZG._declare_object("END-OF-RAINBOW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a small, rocky beach on the continuation of the Frigid\nRiver past the Falls. The beach is narrow due to the presence of the\nWhite Cliffs. The river canyon opens here and sunlight shines in\nfrom above. A rainbow crosses over the falls to the east and a narrow\npath continues to the southwest.",
    ["DESC"] = "End of Rainbow",
    ["UP"] = {"TO", ZG.ON_RAINBOW, "IF", "RAINBOW_FLAG"},
    ["NE"] = {"TO", ZG.ON_RAINBOW, "IF", "RAINBOW_FLAG"},
    ["EAST"] = {"TO", ZG.ON_RAINBOW, "IF", "RAINBOW_FLAG"},
    ["SW"] = {"TO", ZG.CANYON_BOTTOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.RAINBOW, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2358  <ROOM CANYON-BOTTOM>
ZG._declare("CANYON_BOTTOM", function() return ZG._declare_object("CANYON-BOTTOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are beneath the walls of the river canyon which may be climbable\nhere. The lesser part of the runoff of Aragain Falls flows by below.\nTo the north is a narrow path.",
    ["DESC"] = "Canyon Bottom",
    ["UP"] = {"TO", ZG.CLIFF_MIDDLE},
    ["NORTH"] = {"TO", ZG.END_OF_RAINBOW},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.CLIMBABLE_CLIFF, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2370  <ROOM CLIFF-MIDDLE>
ZG._declare("CLIFF_MIDDLE", function() return ZG._declare_object("CLIFF-MIDDLE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a ledge about halfway up the wall of the river canyon.\nYou can see from here that the main flow from Aragain Falls twists\nalong a passage which it is impossible for you to enter. Below you is the\ncanyon bottom. Above you is more cliff, which appears\nclimbable.",
    ["DESC"] = "Rocky Ledge",
    ["UP"] = {"TO", ZG.CANYON_VIEW},
    ["DOWN"] = {"TO", ZG.CANYON_BOTTOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.CLIMBABLE_CLIFF, ZG.RIVER},
} end) end, true)

-- zil: 1dungeon.zil:2384  <ROOM CANYON-VIEW>
ZG._declare("CANYON_VIEW", function() return ZG._declare_object("CANYON-VIEW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are at the top of the Great Canyon on its west wall. From here\nthere is a marvelous view of the canyon and parts of the Frigid River\nupstream. Across the canyon, the walls of the White Cliffs join the\nmighty ramparts of the Flathead Mountains to the east. Following the\nCanyon upstream to the north, Aragain Falls may be seen, complete with\nrainbow. The mighty Frigid River flows out from a great dark cavern. To\nthe west and south can be seen an immense forest, stretching for miles\naround. A path leads northwest. It is possible to climb down into\nthe canyon from here.",
    ["DESC"] = "Canyon View",
    ["EAST"] = {"TO", ZG.CLIFF_MIDDLE},
    ["DOWN"] = {"TO", ZG.CLIFF_MIDDLE},
    ["NW"] = {"TO", ZG.CLEARING},
    ["WEST"] = {"TO", ZG.FOREST_3},
    ["SOUTH"] = "Storm-tossed trees block your way.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT", "SACREDBIT"},
    ["GLOBAL"] = {ZG.CLIMBABLE_CLIFF, ZG.RIVER, ZG.RAINBOW},
    ["ACTION"] = ZG.CANYON_VIEW_F,
} end) end, true)

-- zil: 1dungeon.zil:2406  <ROUTINE CANYON-VIEW-F (RARG)>
ZG.actions:register("CANYON_VIEW_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("LEAP")) and (not ZG._T(ZG.PRSO))) then
        do local _ = ZG.JIGS_UP("Nice view, lousy place to jump.") end
        do return true end
    else
        do return false end
    end

end, "CANYON-VIEW-F")

ZG.CANYON_VIEW_F = ZG.actions:get("CANYON_VIEW_F")

-- zil: 1dungeon.zil:2418  <ROOM MINE-ENTRANCE>
ZG._declare("MINE_ENTRANCE", function() return ZG._declare_object("MINE-ENTRANCE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are standing at the entrance of what might have been a coal mine.\nThe shaft enters the west wall, and there is another exit on the south\nend of the room.",
    ["DESC"] = "Mine Entrance",
    ["SOUTH"] = {"TO", ZG.SLIDE_ROOM},
    ["IN"] = {"TO", ZG.SQUEEKY_ROOM},
    ["WEST"] = {"TO", ZG.SQUEEKY_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2431  <ROOM SQUEEKY-ROOM>
ZG._declare("SQUEEKY_ROOM", function() return ZG._declare_object("SQUEEKY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are in a small room. Strange squeaky sounds may be heard coming\nfrom the passage at the north end. You may also escape to the east.",
    ["DESC"] = "Squeaky Room",
    ["NORTH"] = {"TO", ZG.BAT_ROOM},
    ["EAST"] = {"TO", ZG.MINE_ENTRANCE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2441  <ROOM BAT-ROOM>
ZG._declare("BAT_ROOM", function() return ZG._declare_object("BAT-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Bat Room",
    ["SOUTH"] = {"TO", ZG.SQUEEKY_ROOM},
    ["EAST"] = {"TO", ZG.SHAFT_ROOM},
    ["ACTION"] = ZG.BATS_ROOM,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
} end) end, true)

-- zil: 1dungeon.zil:2449  <ROOM SHAFT-ROOM>
ZG._declare("SHAFT_ROOM", function() return ZG._declare_object("SHAFT-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a large room, in the middle of which is a small shaft\ndescending through the floor into darkness below. To the west and\nthe north are exits from this room. Constructed over the top of the\nshaft is a metal framework to which a heavy iron chain is attached.",
    ["DESC"] = "Shaft Room",
    ["DOWN"] = "You wouldn't fit and would die if you could.",
    ["WEST"] = {"TO", ZG.BAT_ROOM},
    ["NORTH"] = {"TO", ZG.SMELLY_ROOM},
    ["FLAGS"] = "RLANDBIT",
    ["PSEUDO"] = {"CHAIN", ZG.CHAIN_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2463  <ROOM SMELLY-ROOM>
ZG._declare("SMELLY_ROOM", function() return ZG._declare_object("SMELLY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small nondescript room. However, from the direction\nof a small descending staircase a foul odor can be detected. To the\nsouth is a narrow tunnel.",
    ["DESC"] = "Smelly Room",
    ["DOWN"] = {"TO", ZG.GAS_ROOM},
    ["SOUTH"] = {"TO", ZG.SHAFT_ROOM},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.STAIRS,
    ["PSEUDO"] = {"ODOR", ZG.GAS_PSEUDO, "GAS", ZG.GAS_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2476  <ROOM GAS-ROOM>
ZG._declare("GAS_ROOM", function() return ZG._declare_object("GAS-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small room which smells strongly of coal gas. There is a\nshort climb up some stairs and a narrow tunnel leading east.",
    ["DESC"] = "Gas Room",
    ["UP"] = {"TO", ZG.SMELLY_ROOM},
    ["EAST"] = {"TO", ZG.MINE_1},
    ["ACTION"] = ZG.BOOM_ROOM,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
    ["GLOBAL"] = ZG.STAIRS,
    ["PSEUDO"] = {"GAS", ZG.GAS_PSEUDO, "ODOR", ZG.GAS_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2489  <ROOM LADDER-TOP>
ZG._declare("LADDER_TOP", function() return ZG._declare_object("LADDER-TOP", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a very small room. In the corner is a rickety wooden\nladder, leading downward. It might be safe to descend. There is\nalso a staircase leading upward.",
    ["DESC"] = "Ladder Top",
    ["DOWN"] = {"TO", ZG.LADDER_BOTTOM},
    ["UP"] = {"TO", ZG.MINE_4},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.LADDER, ZG.STAIRS},
} end) end, true)

-- zil: 1dungeon.zil:2501  <ROOM LADDER-BOTTOM>
ZG._declare("LADDER_BOTTOM", function() return ZG._declare_object("LADDER-BOTTOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a rather wide room. On one side is the bottom of a\nnarrow wooden ladder. To the west and the south are passages\nleaving the room.",
    ["DESC"] = "Ladder Bottom",
    ["SOUTH"] = {"TO", ZG.DEAD_END_5},
    ["WEST"] = {"TO", ZG.TIMBER_ROOM},
    ["UP"] = {"TO", ZG.LADDER_TOP},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.LADDER,
} end) end, true)

-- zil: 1dungeon.zil:2514  <ROOM DEAD-END-5>
ZG._declare("DEAD_END_5", function() return ZG._declare_object("DEAD-END-5", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to a dead end in the mine.",
    ["NORTH"] = {"TO", ZG.LADDER_BOTTOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2521  <ROOM TIMBER-ROOM>
ZG._declare("TIMBER_ROOM", function() return ZG._declare_object("TIMBER-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a long and narrow passage, which is cluttered with broken\ntimbers. A wide passage comes from the east and turns at the\nwest end of the room into a very narrow passageway. From the west\ncomes a strong draft.",
    ["DESC"] = "Timber Room",
    ["EAST"] = {"TO", ZG.LADDER_BOTTOM},
    ["WEST"] = {"TO", ZG.LOWER_SHAFT, "IF", "EMPTY_HANDED", "ELSE", "You cannot fit through this passage with that load."},
    ["ACTION"] = ZG.NO_OBJS,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
} end) end, true)

-- zil: 1dungeon.zil:2536  <ROOM LOWER-SHAFT>
ZG._declare("LOWER_SHAFT", function() return ZG._declare_object("LOWER-SHAFT", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small drafty room in which is the bottom of a long\nshaft. To the south is a passageway and to the east a very narrow\npassage. In the shaft can be seen a heavy iron chain.",
    ["DESC"] = "Drafty Room",
    ["SOUTH"] = {"TO", ZG.MACHINE_ROOM},
    ["OUT"] = {"TO", ZG.TIMBER_ROOM, "IF", "EMPTY_HANDED", "ELSE", "You cannot fit through this passage with that load."},
    ["EAST"] = {"TO", ZG.TIMBER_ROOM, "IF", "EMPTY_HANDED", "ELSE", "You cannot fit through this passage with that load."},
    ["ACTION"] = ZG.NO_OBJS,
    ["FLAGS"] = {"RLANDBIT", "SACREDBIT"},
    ["PSEUDO"] = {"CHAIN", ZG.CHAIN_PSEUDO},
} end) end, true)

-- zil: 1dungeon.zil:2554  <ROOM MACHINE-ROOM>
ZG._declare("MACHINE_ROOM", function() return ZG._declare_object("MACHINE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Machine Room",
    ["NORTH"] = {"TO", ZG.LOWER_SHAFT},
    ["ACTION"] = ZG.MACHINE_ROOM_FCN,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2565  <ROOM MINE-1>
ZG._declare("MINE_1", function() return ZG._declare_object("MINE-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a nondescript part of a coal mine.",
    ["DESC"] = "Coal Mine",
    ["NORTH"] = {"TO", ZG.GAS_ROOM},
    ["EAST"] = {"TO", ZG.MINE_1},
    ["NE"] = {"TO", ZG.MINE_2},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2574  <ROOM MINE-2>
ZG._declare("MINE_2", function() return ZG._declare_object("MINE-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a nondescript part of a coal mine.",
    ["DESC"] = "Coal Mine",
    ["NORTH"] = {"TO", ZG.MINE_2},
    ["SOUTH"] = {"TO", ZG.MINE_1},
    ["SE"] = {"TO", ZG.MINE_3},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2583  <ROOM MINE-3>
ZG._declare("MINE_3", function() return ZG._declare_object("MINE-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a nondescript part of a coal mine.",
    ["DESC"] = "Coal Mine",
    ["SOUTH"] = {"TO", ZG.MINE_3},
    ["SW"] = {"TO", ZG.MINE_4},
    ["EAST"] = {"TO", ZG.MINE_2},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2592  <ROOM MINE-4>
ZG._declare("MINE_4", function() return ZG._declare_object("MINE-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a nondescript part of a coal mine.",
    ["DESC"] = "Coal Mine",
    ["NORTH"] = {"TO", ZG.MINE_3},
    ["WEST"] = {"TO", ZG.MINE_4},
    ["DOWN"] = {"TO", ZG.LADDER_TOP},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 1dungeon.zil:2601  <ROOM SLIDE-ROOM>
ZG._declare("SLIDE_ROOM", function() return ZG._declare_object("SLIDE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small chamber, which appears to have been part of a\ncoal mine. On the south wall of the chamber the letters \"Granite\nWall\" are etched in the rock. To the east is a long passage, and\nthere is a steep metal slide twisting downward. To the north is\na small opening.",
    ["DESC"] = "Slide Room",
    ["EAST"] = {"TO", ZG.COLD_PASSAGE},
    ["NORTH"] = {"TO", ZG.MINE_ENTRANCE},
    ["DOWN"] = {"TO", ZG.CELLAR},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = ZG.SLIDE,
} end) end, true)

-- ;"RANDOM TABLES FOR WALK-AROUND"

-- zil: 1dungeon.zil:2620  <GLOBAL HOUSE-AROUND>
-- HOUSE_AROUND is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:2624  <GLOBAL FOREST-AROUND>
-- FOREST_AROUND is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:2627  <GLOBAL IN-HOUSE-AROUND>
-- IN_HOUSE_AROUND is declared in ZilGlobal.lua

-- zil: 1dungeon.zil:2630  <GLOBAL ABOVE-GROUND>
-- ABOVE_GROUND is declared in ZilGlobal.lua

-- ;"The GO routine must live here."

-- zil: 1dungeon.zil:2637  <ROUTINE GO ()>
ZG.actions:register("GO", function()

    while true do
        local _brk1 = true
        repeat
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_FIGHT, -1)) end
            do local _ = ZG.QUEUE(ZG.I_SWORD, -1) end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_THIEF, -1)) end
            do local _ = ZG.QUEUE(ZG.I_CANDLES, 40) end
            do local _ = ZG.QUEUE(ZG.I_LANTERN, 200) end
            do local _ = ZG.PUTP(ZG.INFLATED_BOAT, "VTYPE", "NONLANDBIT") end
            do local _ = ZG.PUT(ZG.DEF1_RES, 1, ZG.REST(ZG.DEF1, 2)) end
            do local _ = ZG.PUT(ZG.DEF1_RES, 2, ZG.REST(ZG.DEF1, 4)) end
            do local _ = ZG.PUT(ZG.DEF2_RES, 2, ZG.REST(ZG.DEF2B, 2)) end
            do local _ = ZG.PUT(ZG.DEF2_RES, 3, ZG.REST(ZG.DEF2B, 4)) end
            do local _ = ZG.PUT(ZG.DEF3_RES, 1, ZG.REST(ZG.DEF3A, 2)) end
            do local _ = ZG.PUT(ZG.DEF3_RES, 3, ZG.REST(ZG.DEF3B, 2)) end
            ZG._set("HERE", ZG.WEST_OF_HOUSE)
            do local _ = ZG.THIS_IS_IT(ZG.MAILBOX) end
            if (not ZG._T(ZG.FSET_p(ZG.HERE, "TOUCHBIT"))) then
                do local _ = ZG.V_VERSION() end
                do local _ = ZG.CRLF() end
            end
            ZG._set("LIT", true)
            ZG._set("WINNER", ZG.ADVENTURER)
            ZG._set("PLAYER", ZG.WINNER)
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
            do local _ = ZG.V_LOOK() end
            do local _ = ZG.MAIN_LOOP() end
            break
        until true
        if _brk1 then break end
    end

end, "GO")

ZG.GO = ZG.actions:get("GO")
