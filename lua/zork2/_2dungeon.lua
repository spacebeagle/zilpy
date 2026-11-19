-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

do local _ = ZG.DIRECTIONS("NORTH", "EAST", "WEST", "SOUTH", "NE", "NW", "SE", "SW", "UP", "DOWN", "IN", "OUT", "LAND", "CROSS") end

-- zil: 2dungeon.zil:7  <ROUTINE GO ()>
ZG.actions:register("GO", function()

    while true do
        local _brk1 = true
        repeat
            do local _ = ZG.PUTB(ZG.P_LEXV, 0, 59) end
            -- ;"put interrupts on clock chain"
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_WIZARD, 4)) end
            do local _ = ZG.QUEUE(ZG.I_LANTERN, 200) end
            -- ;"clean up junk compiler can't do"
            do local _ = ZG.PUTP(ZG.BALLOON, "VTYPE", "NONLANDBIT") end
            do local _ = ZG.PUTP(ZG.BUCKET, "VTYPE", "NONLANDBIT") end
            do local _ = ZG.PUTP(ZG.SEWL, "SIZE", "EAST") end
            do local _ = ZG.PUTP(ZG.SWWL, "SIZE", "WEST") end
            do local _ = ZG.PUTP(ZG.SSWL, "SIZE", "SOUTH") end
            do local _ = ZG.PUTP(ZG.SNWL, "SIZE", "NORTH") end
            -- ;"set up and go"
            ZG._set("LIT", true)
            ZG._set("WINNER", ZG.ADVENTURER)
            ZG._set("PLAYER", ZG.ADVENTURER)
            ZG._set("HERE", ZG.INSIDE_BARROW)
            ZG._set("P_IT_OBJECT", false)
            if (not ZG._T(ZG.FSET_p(ZG.HERE, "TOUCHBIT"))) then
                do local _ = ZG.V_VERSION() end
                do local _ = ZG.CRLF() end
            end
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
            do local _ = ZG.V_LOOK() end
            do local _ = ZG.MAIN_LOOP() end
            break
        until true
        if _brk1 then break end
    end

end, "GO")

ZG.GO = ZG.actions:get("GO")

-- zil: 2dungeon.zil:35  <GLOBAL SECRET-DOOR>
-- SECRET_DOOR is declared in ZilGlobal.lua

-- zil: 2dungeon.zil:36  <GLOBAL GNOME-DOOR-FLAG>
-- GNOME_DOOR_FLAG is declared in ZilGlobal.lua

-- zil: 2dungeon.zil:40  <OBJECT STREAM>
ZG._declare("STREAM", function() return ZG._declare_object("STREAM", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "STREAM",
    ["ADJECTIVE"] = {"FLOWING", "SMALL"},
    ["DESC"] = "stream",
    ["ACTION"] = ZG.STREAM_FCN,
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:48  <OBJECT CHASM>
ZG._declare("CHASM", function() return ZG._declare_object("CHASM", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"CHASM", "RAVINE"},
    ["ADJECTIVE"] = "DEEP",
    ["DESC"] = "chasm",
    ["ACTION"] = ZG.CHASM_FCN,
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:56  <OBJECT MOSS>
ZG._declare("MOSS", function() return ZG._declare_object("MOSS", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"MOSS", "MOSSES"},
    ["ADJECTIVE"] = {"GLOWING", "PHOSPHORESCENT"},
    ["DESC"] = "mosses",
    ["ACTION"] = ZG.MOSS_FCN,
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
} end) end, true)

-- zil: 2dungeon.zil:64  <OBJECT ROSE-BUSH>
ZG._declare("ROSE_BUSH", function() return ZG._declare_object("ROSE-BUSH", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"ROSES", "BUSH", "ARBOR"},
    ["ADJECTIVE"] = "ROSE",
    ["DESC"] = "roses",
    ["ACTION"] = ZG.ROSE_BUSH_FCN,
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
} end) end, true)

-- zil: 2dungeon.zil:72  <OBJECT BRIDGE>
ZG._declare("BRIDGE", function() return ZG._declare_object("BRIDGE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "BRIDGE",
    ["ADJECTIVE"] = {"STONE", "WOODEN", "RICKETY"},
    ["DESC"] = "bridge",
    ["ACTION"] = ZG.BRIDGE_FCN,
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:80  <OBJECT TUNNEL>
ZG._declare("TUNNEL", function() return ZG._declare_object("TUNNEL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"PASSAGE", "TUNNEL", "CRAWLWAY"},
    ["ADJECTIVE"] = {"DARK", "SMOKY"},
    ["DESC"] = "tunnel",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.TUNNEL_OBJECT,
} end) end, true)

-- zil: 2dungeon.zil:88  <OBJECT EAST-WALL>
ZG._declare("EAST_WALL", function() return ZG._declare_object("EAST-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"EAST", "EASTERN"},
    ["DESC"] = "east wall",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:95  <OBJECT SOUTH-WALL>
ZG._declare("SOUTH_WALL", function() return ZG._declare_object("SOUTH-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"SOUTH", "SOUTHE"},
    ["DESC"] = "south wall",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:102  <OBJECT WEST-WALL>
ZG._declare("WEST_WALL", function() return ZG._declare_object("WEST-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"WEST", "WESTERN"},
    ["DESC"] = "west wall",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:109  <OBJECT NORTH-WALL>
ZG._declare("NORTH_WALL", function() return ZG._declare_object("NORTH-WALL", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"NORTH", "NORTHE"},
    ["DESC"] = "north wall",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:116  <OBJECT GLOBAL-WATER>
ZG._declare("GLOBAL_WATER", function() return ZG._declare_object("GLOBAL-WATER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"WATER", "QUANTITY"},
    ["DESC"] = "water",
    ["FLAGS"] = "DRINKBIT",
    ["ACTION"] = ZG.WATER_FCN,
} end) end, true)

-- zil: 2dungeon.zil:123  <OBJECT WISH>
ZG._declare("WISH", function() return ZG._declare_object("WISH", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"WISH", "BLESS"},
    ["DESC"] = "wish",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.WISH_FCN,
} end) end, true)

-- zil: 2dungeon.zil:130  <OBJECT WELL>
ZG._declare("WELL", function() return ZG._declare_object("WELL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WELL",
    ["ADJECTIVE"] = "MAGIC",
    ["DESC"] = "well",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.WELL_FCN,
} end) end, true)

-- zil: 2dungeon.zil:138  <OBJECT SEWL>
ZG._declare("SEWL", function() return ZG._declare_object("SEWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"EAST", "EASTERN"},
    ["DESC"] = "east wall",
    ["FLAGS"] = "NDESCBIT",
    ["SIZE"] = 0,
    ["ACTION"] = ZG.SCOLWALL,
} end) end, true)

-- zil: 2dungeon.zil:147  <OBJECT SWWL>
ZG._declare("SWWL", function() return ZG._declare_object("SWWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"WEST", "WESTERN"},
    ["DESC"] = "west wall",
    ["FLAGS"] = "NDESCBIT",
    ["SIZE"] = 0,
    ["ACTION"] = ZG.SCOLWALL,
} end) end, true)

-- zil: 2dungeon.zil:156  <OBJECT SSWL>
ZG._declare("SSWL", function() return ZG._declare_object("SSWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"SOUTH", "SOUTHE"},
    ["DESC"] = "south wall",
    ["FLAGS"] = "NDESCBIT",
    ["SIZE"] = 0,
    ["ACTION"] = ZG.SCOLWALL,
} end) end, true)

-- zil: 2dungeon.zil:165  <OBJECT SNWL>
ZG._declare("SNWL", function() return ZG._declare_object("SNWL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"NORTH", "NORTHE"},
    ["DESC"] = "north wall",
    ["FLAGS"] = "NDESCBIT",
    ["SIZE"] = 0,
    ["ACTION"] = ZG.SCOLWALL,
} end) end, true)

-- zil: 2dungeon.zil:178  <ROOM INSIDE-BARROW>
ZG._declare("INSIDE_BARROW", function() return ZG._declare_object("INSIDE-BARROW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are inside an ancient barrow hidden deep within a dark forest.\nThe barrow opens into a narrow tunnel at its southern end. You can\nsee a faint glow at the far end.",
    ["DESC"] = "Inside the Barrow",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["SOUTH"] = {"TO", ZG.NARROW_TUNNEL},
    ["OUT"] = "You may not recall, but when you entered, the door of the barrow\nshut behind you. There is no way out.",
} end) end, true)

-- zil: 2dungeon.zil:191  <ROOM NARROW-TUNNEL>
ZG._declare("NARROW_TUNNEL", function() return ZG._declare_object("NARROW-TUNNEL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are standing at the southern end of a narrow tunnel where it opens\ninto a wide cavern. The cavern is dimly illuminated by phosphorescent\nmosses clinging to its high ceiling. A deep ravine winds through the\ncavern, with a small stream at the bottom. The walls of the ravine are\nsteep and crumbly. A foot bridge crosses the ravine to the south.",
    ["DESC"] = "Narrow Tunnel",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["NORTH"] = {"TO", ZG.INSIDE_BARROW},
    ["SOUTH"] = {"TO", ZG.FOOT_BRIDGE},
    ["CROSS"] = {"TO", ZG.FOOT_BRIDGE},
    ["DOWN"] = "As you start down, you slip on the crumbling\nrocks and pull back, narrowly averting a fatal fall.",
    ["GLOBAL"] = {ZG.BRIDGE, ZG.CHASM, ZG.STREAM, ZG.MOSS},
} end) end, true)

-- zil: 2dungeon.zil:208  <ROOM FOOT-BRIDGE>
ZG._declare("FOOT_BRIDGE", function() return ZG._declare_object("FOOT-BRIDGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are standing on a crude but sturdy wooden foot bridge crossing a\ndeep ravine. The path runs north and south from here.",
    ["DESC"] = "Foot Bridge",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["NORTH"] = {"TO", ZG.NARROW_TUNNEL},
    ["SOUTH"] = {"TO", ZG.GREAT_CAVERN},
    ["DOWN"] = "The drop would be fatal.",
    ["CROSS"] = "You'll have to specify a direction.",
    ["GLOBAL"] = {ZG.BRIDGE, ZG.CHASM},
} end) end, true)

-- zil: 2dungeon.zil:221  <ROOM GREAT-CAVERN>
ZG._declare("GREAT_CAVERN", function() return ZG._declare_object("GREAT-CAVERN", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the center of the great cavern, carved out of the limestone.\nStalactites and stalagmites of many sizes are everywhere. The room glows\nwith dim light provided by phosphorescent moss, and weird shadows move all\naround you. A narrow path winds southwest among the stalagmites, and another\nleads northeast.",
    ["DESC"] = "Great Cavern",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["NE"] = {"TO", ZG.FOOT_BRIDGE},
    ["SW"] = {"TO", ZG.SHALLOW_FORD},
    ["GLOBAL"] = ZG.MOSS,
    ["PSEUDO"] = {"STALAGMITE", ZG.STALA_PSEUDO, "STALACTITE", ZG.STALA_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:236  <ROOM SHALLOW-FORD>
ZG._declare("SHALLOW_FORD", function() return ZG._declare_object("SHALLOW-FORD", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are at the southern edge of a great cavern. To the south across a\nshallow ford is a dark tunnel which looks like it was once\nenlarged and smoothed. To the north a narrow path winds among\nstalagmites. Dim light illuminates the cavern.",
    ["DESC"] = "Shallow Ford",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["NORTH"] = {"TO", ZG.GREAT_CAVERN},
    ["SOUTH"] = {"TO", ZG.DARK_TUNNEL},
    ["CROSS"] = {"TO", ZG.DARK_TUNNEL},
    ["GLOBAL"] = ZG.GLOBAL_WATER,
} end) end, true)

-- zil: 2dungeon.zil:250  <ROOM DARK-TUNNEL>
ZG._declare("DARK_TUNNEL", function() return ZG._declare_object("DARK-TUNNEL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a dark tunnel with dim light to the northeast. The\ntunnel is smooth but dusty and filled with twigs and leaves, debris\nwhich becomes deeper as the tunnel branches into a wide corridor leading\nsouthwest and a narrower one leading southeast.",
    ["DESC"] = "Dark Tunnel",
    ["FLAGS"] = "RLANDBIT",
    ["NE"] = {"TO", ZG.SHALLOW_FORD},
    ["SE"] = {"TO", ZG.GARDEN_NORTH},
    ["SW"] = {"TO", ZG.STREAM_PATH},
} end) end, true)

-- zil: 2dungeon.zil:265  <OBJECT GLOBAL-UNICORN>
ZG._declare("GLOBAL_UNICORN", function() return ZG._declare_object("GLOBAL-UNICORN", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "UNICORN",
    ["DESC"] = "unicorn",
    ["ADJECTIVE"] = {"BEAUTIFUL", "WHITE"},
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.GLOBAL_UNICORN_FCN,
} end) end, true)

-- zil: 2dungeon.zil:273  <OBJECT UNICORN>
ZG._declare("UNICORN", function() return ZG._declare_object("UNICORN", function() return {
    ["SYNONYM"] = {"UNICORN", "ANIMAL"},
    ["ADJECTIVE"] = {"BEAUTIFUL", "WHITE"},
    ["DESC"] = "unicorn",
    ["LDESC"] = "There is a beautiful unicorn here cropping grass.",
    ["FLAGS"] = {"ACTORBIT", "TRYTAKEBIT", "OPENBIT", "CONTBIT"},
    ["ACTION"] = ZG.UNICORN_FCN,
} end) end, true)

-- zil: 2dungeon.zil:281  <ROOM GARDEN-NORTH>
ZG._declare("GARDEN_NORTH", function() return ZG._declare_object("GARDEN-NORTH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the northern end of a formal garden. Hedges hide\nthe cavern walls, and if you don't look up, the illusion is of a cloudy\nday outside. The light comes from a large growth of glowing mosses on the\nroof of the cave. A break in the hedge is almost overgrown to the north.\nA carefully manicured path leads south. In the center of a rosebed is a\nsmall open structure, painted white. It appears to be a gazebo.",
    ["DESC"] = "North End of Garden",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["IN"] = {"TO", ZG.GAZEBO_ROOM},
    ["NORTH"] = {"TO", ZG.DARK_TUNNEL},
    ["SOUTH"] = {"TO", ZG.FORMAL_GARDEN},
    ["ACTION"] = ZG.GARDEN_ROOM_FCN,
    ["GLOBAL"] = {ZG.GLOBAL_UNICORN, ZG.GAZEBO, ZG.MOSS, ZG.ROSE_BUSH},
} end) end, true)

-- zil: 2dungeon.zil:298  <ROOM GAZEBO-ROOM>
ZG._declare("GAZEBO_ROOM", function() return ZG._declare_object("GAZEBO-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a gazebo in the midst of a formal garden. It is cool and\nrestful here. A tea table adorns the center of the gazebo.",
    ["DESC"] = "Gazebo",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["OUT"] = {"TO", ZG.GARDEN_NORTH},
    ["GLOBAL"] = {ZG.GLOBAL_UNICORN, ZG.GAZEBO},
} end) end, true)

-- zil: 2dungeon.zil:308  <ROOM FORMAL-GARDEN>
ZG._declare("FORMAL_GARDEN", function() return ZG._declare_object("FORMAL-GARDEN", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the middle part of a formal garden. Hedges hide the cavern\nwalls and a dim illumination comes from mosses far above.\nThe path is of small crushed white stones. It winds among bushes and\nflower beds from south to north. To the north a small structure\ncan be seen. To the south are peculiarly shaped bushes.\nThere is a small gap in the hedges to the west.",
    ["DESC"] = "Formal Garden",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["WEST"] = {"TO", ZG.STREAM_PATH},
    ["NORTH"] = {"TO", ZG.GARDEN_NORTH},
    ["SOUTH"] = {"TO", ZG.TOPIARY_ROOM},
    ["ACTION"] = ZG.GARDEN_ROOM_FCN,
    ["GLOBAL"] = {ZG.GLOBAL_UNICORN, ZG.MOSS},
} end) end, true)

-- zil: 2dungeon.zil:325  <ROOM TOPIARY-ROOM>
ZG._declare("TOPIARY_ROOM", function() return ZG._declare_object("TOPIARY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the southern end of a formal garden. Hedges hide the cavern\nwalls and mosses provide dim illumination. Fantastically shaped hedges\nand bushes are arrayed with geometric precision. They have not recently\nbeen clipped, but you can discern creatures in the shapes of the bushes:\nThere is a dragon, a unicorn, a great serpent, a huge misshapen dog, and\nseveral human figures. On the west side of the garden the path\nleads through a rose arbor into a tunnel.",
    ["DESC"] = "Topiary",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["WEST"] = {"TO", ZG.CAROUSEL_ROOM},
    ["NORTH"] = {"TO", ZG.FORMAL_GARDEN},
    ["ACTION"] = ZG.GARDEN_ROOM_FCN,
    ["GLOBAL"] = {ZG.GLOBAL_UNICORN, ZG.MOSS, ZG.ROSE_BUSH},
} end) end, true)

-- zil: 2dungeon.zil:342  <OBJECT HEDGES>
ZG._declare("HEDGES", function() return ZG._declare_object("HEDGES", function() return {
    ["LOC"] = ZG.TOPIARY_ROOM,
    ["DESC"] = "hedge",
    ["SYNONYM"] = {"HEDGE", "HEDGES"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.HEDGES_F,
} end) end, true)

-- zil: 2dungeon.zil:349  <ROUTINE HEDGES-F ()>
ZG.actions:register("HEDGES_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The hedges are shaped like various animals: dogs, serpents, dragons, and\nthe like, and they are vaguely troubling to look at.", ZG._TK.CR) end
    else
        do return false end
    end

end, "HEDGES-F")

ZG.HEDGES_F = ZG.actions:get("HEDGES_F")

-- zil: 2dungeon.zil:355  <ROOM STREAM-PATH>
ZG._declare("STREAM_PATH", function() return ZG._declare_object("STREAM-PATH", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The path follows the south edge of a deep ravine and heads northeast.\nA tunnel heads southwest, narrowing to a rather tight crawl. A\nfaint whirring sound can be heard in that direction. On the east is a\nruined archway choked with vegetation.",
    ["DESC"] = "Path Near Stream",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.FORMAL_GARDEN},
    ["NE"] = {"TO", ZG.DARK_TUNNEL},
    ["SW"] = {"TO", ZG.CAROUSEL_ROOM},
    ["WEST"] = {"TO", ZG.MARBLE_HALL, "IF", "SECRET_DOOR"},
    ["DOWN"] = "The ravine is extremely deep. You would never make it.",
    ["GLOBAL"] = {ZG.BRIDGE, ZG.CHASM, ZG.STREAM},
} end) end, true)

-- zil: 2dungeon.zil:371  <ROOM MARBLE-HALL>
ZG._declare("MARBLE_HALL", function() return ZG._declare_object("MARBLE-HALL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is an arched hall of fine marble. The hall stops abruptly\nto the north at a ford across a stream, where the marble is cracked and\nbroken. Perhaps a flood or collapse of the cave was responsible. To\nthe south the hall opens into a large room. There is rather annoying\nwhirring sound coming from that room.",
    ["DESC"] = "Marble Hall",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.STREAM_PATH, "IF", "SECRET_DOOR", "ELSE", "That's a wall there."},
    ["NORTH"] = {"TO", ZG.DEEP_FORD},
    ["SOUTH"] = {"TO", ZG.CAROUSEL_ROOM},
    ["GLOBAL"] = ZG.STREAM,
} end) end, true)

-- zil: 2dungeon.zil:386  <ROOM DEEP-FORD>
ZG._declare("DEEP_FORD", function() return ZG._declare_object("DEEP-FORD", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are fording the stream at a deep but not impossible spot. The\nwater is very cold. The walls of the ravine rise to east and west.\nThere is a small ledge along the north wall of the ravine. To the south\nis the entrance to a well-constructed but somewhat ruined hall.",
    ["DESC"] = "Deep Ford",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.RAVINE_LEDGE},
    ["UP"] = {"TO", ZG.RAVINE_LEDGE},
    ["SOUTH"] = {"TO", ZG.MARBLE_HALL},
    ["EAST"] = "The stream deepens rapidly, and you wisely return before drowning.",
    ["WEST"] = "You notice that the ledge above would be a drier route west.",
    ["GLOBAL"] = {ZG.GLOBAL_WATER, ZG.CHASM, ZG.STREAM},
} end) end, true)

-- zil: 2dungeon.zil:404  <ROOM RAVINE-LEDGE>
ZG._declare("RAVINE_LEDGE", function() return ZG._declare_object("RAVINE-LEDGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a narrow ledge near the bottom of a deep ravine. The ledge\ncontinues to the west. A precarious climb up to another tiny ledge is\npossible. A short scramble down the rock face leads\nto a stream.",
    ["DESC"] = "Ledge in Ravine",
    ["FLAGS"] = "RLANDBIT",
    ["UP"] = {"TO", ZG.TINY_ROOM},
    ["SOUTH"] = {"TO", ZG.DEEP_FORD},
    ["WEST"] = {"TO", ZG.LEDGE_TUNNEL},
    ["DOWN"] = {"TO", ZG.DEEP_FORD},
    ["GLOBAL"] = ZG.CHASM,
} end) end, true)

-- zil: 2dungeon.zil:419  <ROOM LEDGE-TUNNEL>
ZG._declare("LEDGE_TUNNEL", function() return ZG._declare_object("LEDGE-TUNNEL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "A ledge from the east ends here, and a tunnel leads north into the wall.\nThere is a rather odd smokey odor in the warm air of the tunnel.",
    ["DESC"] = "End of Ledge",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.RAVINE_LEDGE},
    ["IN"] = {"TO", ZG.DRAGON_ROOM},
    ["NORTH"] = {"TO", ZG.DRAGON_ROOM},
    ["DOWN"] = "There are a lot of sharp rocks down there.",
} end) end, true)

-- zil: 2dungeon.zil:431  <ROOM DRAGON-ROOM>
ZG._declare("DRAGON_ROOM", function() return ZG._declare_object("DRAGON-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The room is a large cavern full of broken stone. The walls are\nscorched and there are deep scratches on the floor. A sooty dry smell\nis very strong here. A paved path winds from a large passage to the\nwest, through the room, and across a huge stone bridge\nto the south. To the east a small crack is visible. A dark and\nsmokey tunnel leads north.",
    ["DESC"] = "Dragon Room",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.LEDGE_TUNNEL},
    ["NORTH"] = {"TO", ZG.DRAGON_LAIR, "IF", "ICE_MELTED", "ELSE", "The dragon hisses at you and blocks your way."},
    ["IN"] = {"TO", ZG.DRAGON_LAIR, "IF", "ICE_MELTED", "ELSE", "The dragon hisses at you and blocks your way."},
    ["WEST"] = {"TO", ZG.FRESCO_ROOM},
    ["SOUTH"] = {"TO", ZG.STONE_BRIDGE},
    ["CROSS"] = {"TO", ZG.STONE_BRIDGE},
    ["GLOBAL"] = ZG.BRIDGE,
} end) end, true)

-- zil: 2dungeon.zil:452  <ROOM DRAGON-LAIR>
ZG._declare("DRAGON_LAIR", function() return ZG._declare_object("DRAGON-LAIR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are in the dragon's lair, where the rock walls are scarred by flame.\nA blackened doorway leads to the south.",
    ["DESC"] = "Dragon's Lair",
    ["FLAGS"] = "RLANDBIT",
    ["SOUTH"] = {"TO", ZG.DRAGON_ROOM},
    ["OUT"] = {"TO", ZG.DRAGON_ROOM},
} end) end, true)

-- zil: 2dungeon.zil:462  <OBJECT CHEST>
ZG._declare("CHEST", function() return ZG._declare_object("CHEST", function() return {
    ["LOC"] = ZG.DRAGON_LAIR,
    ["SYNONYM"] = {"CHEST", "TRUNK"},
    ["ADJECTIVE"] = {"WOODEN", "OLD", "ROTTEN"},
    ["DESC"] = "rotten wooden chest",
    ["FDESC"] = "A rotten old wooden chest is in one corner among the debris.",
    ["FLAGS"] = {"CONTBIT", "TAKEBIT"},
    ["ACTION"] = ZG.CHEST_FCN,
    ["CAPACITY"] = 40,
    ["SIZE"] = 40,
} end) end, true)

-- zil: 2dungeon.zil:474  <OBJECT STATUETTE>
ZG._declare("STATUETTE", function() return ZG._declare_object("STATUETTE", function() return {
    ["LOC"] = ZG.CHEST,
    ["SYNONYM"] = {"TREASURE", "STATUETTE", "DRAGON"},
    ["ADJECTIVE"] = "GOLD",
    ["DESC"] = "golden dragon statuette",
    ["FDESC"] = "Nestled in the chest is a wrought gold statuette of a dragon.",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT"},
    ["VALUE"] = 20,
} end) end, true)

-- zil: 2dungeon.zil:484  <OBJECT DRAGON>
ZG._declare("DRAGON", function() return ZG._declare_object("DRAGON", function() return {
    ["LOC"] = ZG.DRAGON_ROOM,
    ["SYNONYM"] = {"DRAGON", "SMAUG", "WORM"},
    ["ADJECTIVE"] = {"RED", "HUGE"},
    ["DESC"] = "huge red dragon",
    ["LDESC"] = "A huge red dragon is lying on the rocks here, watching.",
    ["FDESC"] = "A huge red dragon is lying here, blocking the entrance to a tunnel\nleading north. Smoke curls from his nostrils and out between his\nteeth.",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.DRAGON_FCN,
} end) end, true)

-- zil: 2dungeon.zil:498  <OBJECT DEAD-DRAGON>
ZG._declare("DEAD_DRAGON", function() return ZG._declare_object("DEAD-DRAGON", function() return {
    ["SYNONYM"] = {"DRAGON", "SMAUG", "WORM"},
    ["ADJECTIVE"] = {"RED", "HUGE", "DEAD"},
    ["DESC"] = "huge dead dragon",
    ["LDESC"] = "A huge dead dragon is lying half blocking the stream.",
    ["SIZE"] = 400,
} end) end, true)

-- zil: 2dungeon.zil:506  <OBJECT GLOBAL-PRINCESS>
ZG._declare("GLOBAL_PRINCESS", function() return ZG._declare_object("GLOBAL-PRINCESS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"PRINCESS", "WOMAN", "LADY"},
    ["ADJECTIVE"] = {"BEAUTIFUL", "YOUNG"},
    ["DESC"] = "beautiful princess",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.PRINCESS_FCN,
} end) end, true)

-- zil: 2dungeon.zil:514  <OBJECT PRINCESS>
ZG._declare("PRINCESS", function() return ZG._declare_object("PRINCESS", function() return {
    ["LOC"] = ZG.DRAGON_LAIR,
    ["SYNONYM"] = {"PRINCESS", "WOMAN", "LADY"},
    ["ADJECTIVE"] = {"BEAUTIFUL", "YOUNG"},
    ["DESC"] = "beautiful princess",
    ["LDESC"] = "A beautiful young woman, wearing a dirty and bedraggled gown, sits\non a rock in the corner. Her hair is unkempt and she is oblivious to\nyour presence, almost in a trance.",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.PRINCESS_FCN,
} end) end, true)

-- zil: 2dungeon.zil:526  <ROOM FRESCO-ROOM>
ZG._declare("FRESCO_ROOM", function() return ZG._declare_object("FRESCO-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "A path leads east-west through a room decorated with beautiful frescoes\nof someone battling dragons and rescuing fair maidens. It is hard\nto tell who is doing this as those parts of the\nfrescoes have been blackened and cracked by intense heat.",
    ["DESC"] = "Fresco Room",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.DRAGON_ROOM},
    ["WEST"] = {"TO", ZG.BANK_ENTRANCE},
} end) end, true)

-- zil: 2dungeon.zil:538  <ROOM STONE-BRIDGE>
ZG._declare("STONE_BRIDGE", function() return ZG._declare_object("STONE-BRIDGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the middle of a ruined but still impressive stone bridge\nspanning a deep chasm. Water flows far beneath. A paved path leads\nnorth into a large open space. To the south, the path leads into a misty\ntunnel.",
    ["DESC"] = "Stone Bridge",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.DRAGON_ROOM},
    ["SOUTH"] = {"TO", ZG.COOL_ROOM},
    ["DOWN"] = "It's a long way down.",
    ["CROSS"] = "You'll have to specify a direction.",
    ["GLOBAL"] = {ZG.BRIDGE, ZG.CHASM},
} end) end, true)

-- zil: 2dungeon.zil:553  <ROOM COOL-ROOM>
ZG._declare("COOL_ROOM", function() return ZG._declare_object("COOL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The room is cool and damp. The air is misty. A twisty path from the\nsoutheast splits here toward a wide northerly stone bridge, and a narrow\nwesterly tunnel. It is from the latter\nthat the mist and chill seem to originate.",
    ["DESC"] = "Cool Room",
    ["FLAGS"] = "RLANDBIT",
    ["SE"] = {"TO", ZG.CAROUSEL_ROOM},
    ["NORTH"] = {"TO", ZG.STONE_BRIDGE},
    ["WEST"] = {"TO", ZG.GLACIER_ROOM},
    ["CROSS"] = {"TO", ZG.STONE_BRIDGE},
    ["GLOBAL"] = ZG.BRIDGE,
} end) end, true)

-- zil: 2dungeon.zil:568  <ROOM GLACIER-ROOM>
ZG._declare("GLACIER_ROOM", function() return ZG._declare_object("GLACIER-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Ice Room",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.COOL_ROOM},
    ["WEST"] = {"TO", ZG.LAVA_ROOM, "IF", "ICE_MELTED", "ELSE", "You don't even have an ice-pick."},
    ["UP"] = {"TO", ZG.LAVA_TUBE},
    ["ACTION"] = ZG.GLACIER_ROOM_FCN,
} end) end, true)

-- zil: 2dungeon.zil:579  <ROOM LAVA-TUBE>
ZG._declare("LAVA_TUBE", function() return ZG._declare_object("LAVA-TUBE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are in a tight chimney of solidified lava. It extends up at\nleast another hundred feet and down to a large room far below. A large\ncrack opens to the south, probably the result of a shift\nin the rock strata.",
    ["DESC"] = "Lava Tube",
    ["FLAGS"] = "RLANDBIT",
    ["DOWN"] = {"TO", ZG.GLACIER_ROOM},
    ["UP"] = {"TO", ZG.VOLCANO_VIEW},
    ["SOUTH"] = {"TO", ZG.COBWEBBY_CORRIDOR},
    ["PSEUDO"] = {"CRACK", ZG.LT_CRACK_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:593  <ROUTINE LT-CRACK-PSEUDO ()>
ZG.actions:register("LT_CRACK_PSEUDO", function()

    if ZG._T(ZG.VERB_p("BOARD", "THROUGH")) then
        do local _ = ZG.DO_WALK("SOUTH") end
        do return true end
    else
        do return ZG.CC_CRACK_PSEUDO() end
    end

end, "LT-CRACK-PSEUDO")

ZG.LT_CRACK_PSEUDO = ZG.actions:get("LT_CRACK_PSEUDO")

-- zil: 2dungeon.zil:599  <ROOM COBWEBBY-CORRIDOR>
ZG._declare("COBWEBBY_CORRIDOR", function() return ZG._declare_object("COBWEBBY-CORRIDOR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "A winding corridor is filled with cobwebs. Some\nare broken and the dust on the floor is disturbed. The trend of the\ntwists and turns is northeast to southwest. On the north side of one\ntwist, high up, is a narrow crack.",
    ["DESC"] = "Cobwebby Corridor",
    ["FLAGS"] = "RLANDBIT",
    ["IN"] = {"TO", ZG.LAVA_TUBE},
    ["UP"] = {"TO", ZG.LAVA_TUBE},
    ["NORTH"] = {"TO", ZG.LAVA_TUBE},
    ["NE"] = {"TO", ZG.CAROUSEL_ROOM},
    ["SW"] = {"TO", ZG.GUARDIAN_ROOM},
    ["DOWN"] = {"TO", ZG.GUARDIAN_ROOM},
    ["PSEUDO"] = {"CRACK", ZG.CC_CRACK_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:616  <ROUTINE CC-CRACK-PSEUDO ()>
ZG.actions:register("CC_CRACK_PSEUDO", function()

    if ZG._T(ZG.VERB_p("THROUGH", "BOARD")) then
        do local _ = ZG.DO_WALK("NORTH") end
        do return true end
    else
        do return ZG.TELL("The crack is fairly wide. You should be able to get into it.", ZG._TK.CR) end
    end

end, "CC-CRACK-PSEUDO")

ZG.CC_CRACK_PSEUDO = ZG.actions:get("CC_CRACK_PSEUDO")

-- zil: 2dungeon.zil:624  <OBJECT WIZ-DOOR>
ZG._declare("WIZ_DOOR", function() return ZG._declare_object("WIZ-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"COBWEBBED", "WOODEN", "OAK"},
    ["DESC"] = "door partly covered in cobwebs",
    ["FLAGS"] = {"DOORBIT", "CONTBIT"},
    ["ACTION"] = ZG.WIZ_DOOR_FCN,
} end) end, true)

-- zil: 2dungeon.zil:632  <ROOM ROOM-8>
ZG._declare("ROOM_8", function() return ZG._declare_object("ROOM-8", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small chamber carved out of the rock at the end of a short crawl.\nOn the wall is crudely chiseled the number \"8\".",
    ["DESC"] = "Room 8",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.CAROUSEL_ROOM},
} end) end, true)

-- zil: 2dungeon.zil:641  <ROOM MENHIR-ROOM>
ZG._declare("MENHIR_ROOM", function() return ZG._declare_object("MENHIR-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Menhir Room",
    ["LDESC"] = " ",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.CAROUSEL_ROOM},
    ["SW"] = {"TO", ZG.KENNEL, "IF", "MENHIR_POSITION", "ELSE", "You are trying to walk through an enormous rock."},
    ["SOUTH"] = {"TO", ZG.STAIRWAY_TOP},
    ["ACTION"] = ZG.MENHIR_ROOM_FCN,
    ["GLOBAL"] = ZG.MENHIR,
} end) end, true)

-- zil: 2dungeon.zil:654  <OBJECT GLOBAL-MENHIR>
ZG._declare("GLOBAL_MENHIR", function() return ZG._declare_object("GLOBAL-MENHIR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"MENHIR", "ROCK", "STONE"},
    ["ADJECTIVE"] = {"HUGE", "HEAVY", "ENORMOUS"},
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["ACTION"] = ZG.GLOBAL_MENHIR_F,
    ["DESC"] = "enormous menhir",
} end) end, true)

-- zil: 2dungeon.zil:662  <ROUTINE GLOBAL-MENHIR-F ()>
ZG.actions:register("GLOBAL_MENHIR_F", function()

    do return ZG.TELL("It's not here.", ZG._TK.CR) end

end, "GLOBAL-MENHIR-F")

ZG.GLOBAL_MENHIR_F = ZG.actions:get("GLOBAL_MENHIR_F")

-- zil: 2dungeon.zil:665  <OBJECT MENHIR>
ZG._declare("MENHIR", function() return ZG._declare_object("MENHIR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"MENHIR", "ROCK", "STONE", "F"},
    ["ADJECTIVE"] = {"HUGE", "HEAVY", "ENORMOUS"},
    ["FLAGS"] = {"NDESCBIT", "READBIT", "TURNBIT"},
    ["DESC"] = "enormous menhir",
    ["ACTION"] = ZG.MENHIR_FCN,
} end) end, true)

-- zil: 2dungeon.zil:673  <ROOM KENNEL>
ZG._declare("KENNEL", function() return ZG._declare_object("KENNEL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This room looks like it was once a kennel for a very large dog (some of\nthe bones would fit a dinosaur). It apparently hasn't been used for a\nlong time, as the dust is fairly thick all over. The only\nexit is northeast.",
    ["DESC"] = "Kennel",
    ["FLAGS"] = "RLANDBIT",
    ["NE"] = {"TO", ZG.MENHIR_ROOM, "IF", "MENHIR_POSITION", "ELSE", "You are trying to walk through an enormous rock."},
    ["OUT"] = {"TO", ZG.MENHIR_ROOM, "IF", "MENHIR_POSITION", "ELSE", "You are trying to walk through an enormous rock."},
    ["GLOBAL"] = ZG.MENHIR,
} end) end, true)

-- zil: 2dungeon.zil:690  <OBJECT COLLAR>
ZG._declare("COLLAR", function() return ZG._declare_object("COLLAR", function() return {
    ["LOC"] = ZG.KENNEL,
    ["SYNONYM"] = {"COLLAR", "TREASURE"},
    ["ADJECTIVE"] = {"HUGE", "GIANT", "DOG"},
    ["FDESC"] = "A gigantic dog collar, large enough for three rhinoceros-sized dogs, is\nlying amidst the debris.",
    ["DESC"] = "gigantic dog collar",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT"},
    ["ACTION"] = ZG.COLLAR_FCN,
    ["VALUE"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:706  <OBJECT BAT>
ZG._declare("BAT", function() return ZG._declare_object("BAT", function() return {
    ["SYNONYM"] = {"CLUB", "BAT"},
    ["ADJECTIVE"] = {"WOODEN", "BASEBALL"},
    ["FDESC"] = "A long wooden club lies on the ground near the diamond-shaped window.\nThe club is curiously burned at the thick end.",
    ["DESC"] = "wooden club",
    ["FLAGS"] = {"INVISIBLE", "TAKEBIT", "WEAPONBIT", "READBIT", "BURNBIT"},
    ["TEXT"] = "The words \"Babe Flathead\" are burned into the wood.",
} end) end, true)

-- zil: 2dungeon.zil:717  <ROOM STAIRWAY-TOP>
ZG._declare("STAIRWAY_TOP", function() return ZG._declare_object("STAIRWAY-TOP", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "A marble stairway leads down into the gloom and a passage leads north.",
    ["DESC"] = "Stairway",
    ["FLAGS"] = "RLANDBIT",
    ["DOWN"] = {"TO", ZG.DIAMOND_5},
    ["NORTH"] = {"TO", ZG.MENHIR_ROOM},
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 2dungeon.zil:727  <ROOM DIAMOND-1>
ZG._declare("DIAMOND_1", function() return ZG._declare_object("DIAMOND-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["SE"] = {"TO", ZG.DIAMOND_5},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:738  <ROOM DIAMOND-2>
ZG._declare("DIAMOND_2", function() return ZG._declare_object("DIAMOND-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["SOUTH"] = {"TO", ZG.DIAMOND_5},
    ["SE"] = {"TO", ZG.DIAMOND_6},
    ["SW"] = {"TO", ZG.DIAMOND_4},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:751  <ROOM DIAMOND-3>
ZG._declare("DIAMOND_3", function() return ZG._declare_object("DIAMOND-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["SW"] = {"TO", ZG.DIAMOND_5},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:762  <ROOM DIAMOND-4>
ZG._declare("DIAMOND_4", function() return ZG._declare_object("DIAMOND-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["NE"] = {"TO", ZG.DIAMOND_2},
    ["SE"] = {"TO", ZG.DIAMOND_8},
    ["EAST"] = {"TO", ZG.DIAMOND_5},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:775  <ROOM DIAMOND-5>
ZG._declare("DIAMOND_5", function() return ZG._declare_object("DIAMOND-5", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["NW"] = {"TO", ZG.DIAMOND_1},
    ["NORTH"] = {"TO", ZG.DIAMOND_2},
    ["NE"] = {"TO", ZG.DIAMOND_3},
    ["WEST"] = {"TO", ZG.DIAMOND_4},
    ["EAST"] = {"TO", ZG.DIAMOND_6},
    ["SW"] = {"TO", ZG.DIAMOND_7},
    ["SOUTH"] = {"TO", ZG.DIAMOND_8},
    ["SE"] = {"TO", ZG.DIAMOND_9},
    ["DOWN"] = {"TO", ZG.CERBERUS_ROOM},
    ["UP"] = {"TO", ZG.STAIRWAY_TOP},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = {ZG.STAIRS, ZG.DWINDOW},
} end) end, true)

-- zil: 2dungeon.zil:795  <ROOM DIAMOND-6>
ZG._declare("DIAMOND_6", function() return ZG._declare_object("DIAMOND-6", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["WEST"] = {"TO", ZG.DIAMOND_5},
    ["NW"] = {"TO", ZG.DIAMOND_2},
    ["SW"] = {"TO", ZG.DIAMOND_8},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:808  <ROOM DIAMOND-7>
ZG._declare("DIAMOND_7", function() return ZG._declare_object("DIAMOND-7", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["NE"] = {"TO", ZG.DIAMOND_5},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:819  <ROOM DIAMOND-8>
ZG._declare("DIAMOND_8", function() return ZG._declare_object("DIAMOND-8", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.DIAMOND_5},
    ["NW"] = {"TO", ZG.DIAMOND_4},
    ["NE"] = {"TO", ZG.DIAMOND_6},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:832  <ROOM DIAMOND-9>
ZG._declare("DIAMOND_9", function() return ZG._declare_object("DIAMOND-9", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Oddly-angled Room",
    ["LDESC"] = "A small room with oddly angled walls and passages in all directions.",
    ["FLAGS"] = "RLANDBIT",
    ["NW"] = {"TO", ZG.DIAMOND_5},
    ["ACTION"] = ZG.DIAMOND_MOTION,
    ["GLOBAL"] = ZG.DWINDOW,
} end) end, true)

-- zil: 2dungeon.zil:843  <OBJECT DWINDOW>
ZG._declare("DWINDOW", function() return ZG._declare_object("DWINDOW", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WINDOW",
    ["ADJECTIVE"] = {"GLOWING", "DIAMOND"},
    ["DESC"] = "diamond shaped window",
    ["ACTION"] = ZG.DWINDOW_FCN,
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
} end) end, true)

-- zil: 2dungeon.zil:851  <ROOM CERBERUS-ROOM>
ZG._declare("CERBERUS_ROOM", function() return ZG._declare_object("CERBERUS-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the entrance to a huge crypt or tomb. A marble stairway leads\nup from a gateway arch.",
    ["DESC"] = "Cerberus Room",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = {"TO", ZG.CRYPT_ANTEROOM, "IF", "CERBERUS_LEASHED", "ELSE", "The huge dog snaps nastily at you."},
    ["IN"] = {"TO", ZG.CRYPT_ANTEROOM, "IF", "CERBERUS_LEASHED", "ELSE", "The huge dog snaps nastily at you."},
    ["UP"] = {"TO", ZG.DIAMOND_5},
    ["VALUE"] = 10,
    ["GLOBAL"] = ZG.STAIRS,
    ["PSEUDO"] = {"TOMB", ZG.TOMB_PSEUDO, "CRYPT", ZG.TOMB_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:867  <OBJECT GLOBAL-CERBERUS>
ZG._declare("GLOBAL_CERBERUS", function() return ZG._declare_object("GLOBAL-CERBERUS", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"CERBERUS", "DOG", "HOUND", "MONSTER"},
    ["ADJECTIVE"] = {"HUGE", "GIANT", "THREE", "HEADED"},
    ["ACTION"] = ZG.GLOBAL_CERBERUS_F,
    ["DESC"] = "three-headed dog",
} end) end, true)

-- zil: 2dungeon.zil:874  <ROUTINE GLOBAL-CERBERUS-F ()>
ZG.actions:register("GLOBAL_CERBERUS_F", function()

    do return ZG.TELL("He's not here.", ZG._TK.CR) end

end, "GLOBAL-CERBERUS-F")

ZG.GLOBAL_CERBERUS_F = ZG.actions:get("GLOBAL_CERBERUS_F")

-- zil: 2dungeon.zil:877  <OBJECT CERBERUS>
ZG._declare("CERBERUS", function() return ZG._declare_object("CERBERUS", function() return {
    ["LOC"] = ZG.CERBERUS_ROOM,
    ["SYNONYM"] = {"CERBERUS", "DOG", "HOUND", "MONSTER"},
    ["ADJECTIVE"] = {"HUGE", "GIANT", "THREE", "HEADED"},
    ["DESC"] = "three-headed dog",
    ["LDESC"] = "There is a vicious-looking dog guarding the entrance. It is more or\nless your usual dog, except that it has three heads and is the size of\nan elephant.",
    ["FLAGS"] = {"ACTORBIT", "OPENBIT", "CONTBIT"},
    ["ACTION"] = ZG.CERBERUS_FCN,
} end) end, true)

-- zil: 2dungeon.zil:889  <ROOM CRYPT-ANTEROOM>
ZG._declare("CRYPT_ANTEROOM", function() return ZG._declare_object("CRYPT-ANTEROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Crypt Anteroom",
    ["FLAGS"] = "RLANDBIT",
    ["IN"] = {"TO", ZG.CRYPT_ROOM, "IF", "CRYPT_DOOR", "IS", "OPEN"},
    ["SOUTH"] = {"TO", ZG.CRYPT_ROOM, "IF", "CRYPT_DOOR", "IS", "OPEN"},
    ["WEST"] = {"TO", ZG.CERBERUS_ROOM},
    ["ACTION"] = ZG.CRYPT_ANTEROOM_FCN,
    ["GLOBAL"] = ZG.CRYPT_DOOR,
    ["VALUE"] = 3,
} end) end, true)

-- zil: 2dungeon.zil:901  <ROOM CRYPT-ROOM>
ZG._declare("CRYPT_ROOM", function() return ZG._declare_object("CRYPT-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Crypt",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.CRYPT_ANTEROOM, "IF", "CRYPT_DOOR", "IS", "OPEN"},
    ["SOUTH"] = {"TO", ZG.ZORK3, "IF", "DIM_DOOR_FLAG"},
    ["GLOBAL"] = {ZG.CRYPT_DOOR, ZG.DIM_DOOR},
    ["ACTION"] = ZG.CRYPT_ROOM_FCN,
    ["VALUE"] = 2,
} end) end, true)

-- zil: 2dungeon.zil:912  <OBJECT HEADS>
ZG._declare("HEADS", function() return ZG._declare_object("HEADS", function() return {
    ["LOC"] = ZG.CRYPT_ROOM,
    ["SYNONYM"] = {"HEADS", "HEAD", "POLE", "POLES"},
    ["DESC"] = "set of poled heads",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.HEAD_FCN,
} end) end, true)

-- zil: 2dungeon.zil:919  <OBJECT CRYPT>
ZG._declare("CRYPT", function() return ZG._declare_object("CRYPT", function() return {
    ["LOC"] = ZG.CRYPT_ROOM,
    ["SYNONYM"] = {"TOMB", "CRYPT", "GRAVE"},
    ["ADJECTIVE"] = "MARBLE",
    ["DESC"] = "marble crypt",
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["ACTION"] = ZG.CRYPT_OBJECT,
    ["TEXT"] = "\"Here lie the Flatheads, whose heads were placed on poles by the\nKeeper of the Dungeon for amazing untastefulness.\"",
} end) end, true)

-- zil: 2dungeon.zil:930  <OBJECT CRYPT-DOOR>
ZG._declare("CRYPT_DOOR", function() return ZG._declare_object("CRYPT-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"CRYPT", "NORTH"},
    ["DESC"] = "crypt door",
    ["FLAGS"] = {"DOORBIT", "CONTBIT"},
    ["ACTION"] = ZG.CRYPT_DOOR_FCN,
} end) end, true)

-- zil: 2dungeon.zil:938  <OBJECT DIM-DOOR>
ZG._declare("DIM_DOOR", function() return ZG._declare_object("DIM-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"DOOR", "LETTER"},
    ["ADJECTIVE"] = {"F", "DIMLY", "SOUTH", "SECRET"},
    ["DESC"] = "secret door",
    ["FLAGS"] = {"DOORBIT", "CONTBIT", "INVISIBLE"},
    ["ACTION"] = ZG.DIM_DOOR_FCN,
} end) end, true)

-- zil: 2dungeon.zil:946  <ROOM ZORK3>
ZG._declare("ZORK3", function() return ZG._declare_object("ZORK3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Landing",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.ZORK3_FCN,
} end) end, true)

-- zil: 2dungeon.zil:957  <ROOM GUARDIAN-ROOM>
ZG._declare("GUARDIAN_ROOM", function() return ZG._declare_object("GUARDIAN-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Guarded Room",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.COBWEBBY_CORRIDOR},
    ["SOUTH"] = {"TO", ZG.WIZARDS_WORKSHOP, "IF", "WIZ_DOOR", "IS", "OPEN"},
    ["IN"] = {"TO", ZG.WIZARDS_WORKSHOP, "IF", "WIZ_DOOR", "IS", "OPEN"},
    ["ACTION"] = ZG.GUARDIAN_ROOM_FCN,
    ["GLOBAL"] = ZG.WIZ_DOOR,
} end) end, true)

-- zil: 2dungeon.zil:970  <OBJECT DOOR-KEEPER>
ZG._declare("DOOR_KEEPER", function() return ZG._declare_object("DOOR-KEEPER", function() return {
    ["LOC"] = ZG.GUARDIAN_ROOM,
    ["SYNONYM"] = {"KEEPER", "GUARDIAN", "LIZARD", "HEAD"},
    ["ADJECTIVE"] = "NASTY",
    ["DESC"] = "lizard",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.DOOR_KEEPER_FCN,
} end) end, true)

-- zil: 2dungeon.zil:978  <ROOM WIZARDS-WORKSHOP>
ZG._declare("WIZARDS_WORKSHOP", function() return ZG._declare_object("WIZARDS-WORKSHOP", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the workshop of the Wizard of Frobozz.",
    ["DESC"] = "Wizard's Workshop",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.GUARDIAN_ROOM, "IF", "WIZ_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.GUARDIAN_ROOM, "IF", "WIZ_DOOR", "IS", "OPEN"},
    ["WEST"] = {"TO", ZG.WORKBENCH_ROOM},
    ["SOUTH"] = {"TO", ZG.TROPHY_ROOM},
    ["ACTION"] = ZG.WORKSHOP_FCN,
    ["VALUE"] = 10,
    ["GLOBAL"] = ZG.WIZ_DOOR,
} end) end, true)

-- zil: 2dungeon.zil:992  <ROOM WORKBENCH-ROOM>
ZG._declare("WORKBENCH_ROOM", function() return ZG._declare_object("WORKBENCH-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This room is the Wizard's workroom. A hall continues east and west,\nand a larger room lies to the south. There are many shelves and racks\non the walls, but the Wizard's workbench dominates the room. It is made\nof dark, heavy wood bound with iron. The workbench is stained from many\nyears of use, and is deeply gouged as though some huge clawed animal was\nimprisoned on it. There are burn marks and even notes written in a crabbed\nhand. Many arcane items are scattered about the bench; alembics, mortar\nand pestle, small knives of various sizes, odd scraps of vellum, wax\ncandles, and much more. In the center of a relatively clear area of the\nbench are affixed three stands - ruby, sapphire, and diamond - which form\na triangle.",
    ["DESC"] = "Wizard's Workroom",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["EAST"] = {"TO", ZG.WIZARDS_WORKSHOP},
    ["SOUTH"] = {"TO", ZG.PENTAGRAM_ROOM},
    ["WEST"] = {"TO", ZG.AQUARIUM_ROOM},
    ["PSEUDO"] = {"MORTAR", ZG.ARCANA_PSEUDO, "PESTLE", ZG.ARCANA_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:1013  <OBJECT ARCANA>
ZG._declare("ARCANA", function() return ZG._declare_object("ARCANA", function() return {
    ["LOC"] = ZG.WORKBENCH_ROOM,
    ["SYNONYM"] = {"ALEMBIC", "VELLUM", "CANDLES", "KNIVES"},
    ["ADJECTIVE"] = {"WAX", "SMALL"},
    ["DESC"] = "arcane item",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.ARCANA_PSEUDO,
} end) end, true)

-- zil: 2dungeon.zil:1021  <OBJECT WORKBENCH>
ZG._declare("WORKBENCH", function() return ZG._declare_object("WORKBENCH", function() return {
    ["LOC"] = ZG.WORKBENCH_ROOM,
    ["SYNONYM"] = {"WORKBENCH", "BENCH", "TABLE"},
    ["ADJECTIVE"] = {"WORK", "HEAVY", "WOODEN", "WIZARD"},
    ["DESC"] = "Wizard's workbench",
    ["CAPACITY"] = 200,
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "CONTBIT", "OPENBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1029  <OBJECT STAND-1>
ZG._declare("STAND_1", function() return ZG._declare_object("STAND-1", function() return {
    ["LOC"] = ZG.WORKBENCH,
    ["SYNONYM"] = {"STAND", "STANDS"},
    ["ADJECTIVE"] = {"CRYSTAL", "RUBY"},
    ["DESC"] = "ruby stand",
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 10,
    ["ACTION"] = ZG.STAND_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1038  <OBJECT STAND-2>
ZG._declare("STAND_2", function() return ZG._declare_object("STAND-2", function() return {
    ["LOC"] = ZG.WORKBENCH,
    ["SYNONYM"] = {"STAND", "STANDS"},
    ["ADJECTIVE"] = {"CRYSTAL", "SAPPHIRE"},
    ["DESC"] = "sapphire stand",
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "OPENBIT", "CONTBIT"},
    ["CAPACITY"] = 10,
    ["ACTION"] = ZG.STAND_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1047  <OBJECT STAND-3>
ZG._declare("STAND_3", function() return ZG._declare_object("STAND-3", function() return {
    ["LOC"] = ZG.WORKBENCH,
    ["SYNONYM"] = {"STAND", "STANDS"},
    ["ADJECTIVE"] = {"DIAMOND", "CRYSTAL"},
    ["DESC"] = "diamond stand",
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "OPENBIT", "CONTBIT"},
    ["CAPACITY"] = 10,
    ["ACTION"] = ZG.STAND_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1056  <OBJECT STAND-4>
ZG._declare("STAND_4", function() return ZG._declare_object("STAND-4", function() return {
    ["SYNONYM"] = {"STAND", "STANDS"},
    ["ADJECTIVE"] = {"OBSIDIAN", "BLACK", "CRYSTAL", "STRANGE"},
    ["DESC"] = "black obsidian stand",
    ["FLAGS"] = {"SURFACEBIT", "CONTBIT", "OPENBIT"},
    ["SIZE"] = 5,
    ["CAPACITY"] = 10,
    ["ACTION"] = ZG.STAND_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1065  <OBJECT PALANTIR-4>
ZG._declare("PALANTIR_4", function() return ZG._declare_object("PALANTIR-4", function() return {
    ["LOC"] = ZG.STAND_4,
    ["SYNONYM"] = {"SPHERE", "BALL", "PALANTIR"},
    ["ADJECTIVE"] = {"CRYSTAL", "STRANGE", "BLACK"},
    ["DESC"] = "black crystal sphere",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT", "TRANSBIT"},
    ["ACTION"] = ZG.PALANTIR,
    ["LDESC"] = "There is a strange black sphere here.",
    ["VALUE"] = 30,
    ["SIZE"] = 10,
} end) end, true)

-- zil: 2dungeon.zil:1076  <ROOM TROPHY-ROOM>
ZG._declare("TROPHY_ROOM", function() return ZG._declare_object("TROPHY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the Wizard's trophy room, filled with memorabilia of various\nsorts. On one wall is the Wizard's D. T. (Doctor of Thaumaturgy) degree\nfrom GUE Tech. Several old magic wands are mounted on a wand rack. A\ncollection of dull and nicked swords testify to the fate of many\nfoolhardy adventurers. Small bottles contain discarded homunculi (a few\npreserved in alcohol). There is a stuffed owl on a perch.",
    ["DESC"] = "Trophy Room",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.WIZARDS_WORKSHOP},
    ["PSEUDO"] = {"OWL", ZG.TROPHY_PSEUDO, "HOMUNCULI", ZG.TROPHY_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:1092  <OBJECT DEGREE>
ZG._declare("DEGREE", function() return ZG._declare_object("DEGREE", function() return {
    ["LOC"] = ZG.TROPHY_ROOM,
    ["SYNONYM"] = {"DEGREE", "DIPLOMA"},
    ["DESC"] = "degree",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT", "READBIT"},
    ["ACTION"] = ZG.TROPHY_PSEUDO,
    ["TEXT"] = "The text is in some obscure tongue. All that can be made out is\na reference to \"sending in a matchbook cover.\"",
} end) end, true)

-- zil: 2dungeon.zil:1102  <OBJECT WANDS>
ZG._declare("WANDS", function() return ZG._declare_object("WANDS", function() return {
    ["LOC"] = ZG.TROPHY_ROOM,
    ["SYNONYM"] = {"WANDS", "WAND", "RACK", "SET"},
    ["ADJECTIVE"] = {"WORN", "USED"},
    ["DESC"] = "set of used wands",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.TROPHY_PSEUDO,
} end) end, true)

-- zil: 2dungeon.zil:1110  <OBJECT TROPHY-SWORD>
ZG._declare("TROPHY_SWORD", function() return ZG._declare_object("TROPHY-SWORD", function() return {
    ["LOC"] = ZG.TROPHY_ROOM,
    ["SYNONYM"] = {"SWORD", "SWORDS"},
    ["ADJECTIVE"] = {"DULL", "NICKED"},
    ["DESC"] = "nicked swords",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.TROPHY_PSEUDO,
} end) end, true)

-- zil: 2dungeon.zil:1118  <OBJECT TROPHY-BOTTLES>
ZG._declare("TROPHY_BOTTLES", function() return ZG._declare_object("TROPHY-BOTTLES", function() return {
    ["LOC"] = ZG.TROPHY_ROOM,
    ["SYNONYM"] = "BOTTLE",
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "small bottles",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.TROPHY_PSEUDO,
} end) end, true)

-- zil: 2dungeon.zil:1126  <OBJECT WARNING-LABEL>
ZG._declare("WARNING_LABEL", function() return ZG._declare_object("WARNING-LABEL", function() return {
    ["LOC"] = ZG.TROPHY_ROOM,
    ["SYNONYM"] = "LABEL",
    ["ADJECTIVE"] = "WARNING",
    ["DESC"] = "warning label",
    ["LDESC"] = "A hand-lettered label is affixed to the wall.",
    ["FLAGS"] = "READBIT",
    ["TEXT"] = "Warning!\n\nThe exhibits in this room are the property of the mighty Wizard of\nFrobozz (me), and are the fruits of diligent labor and study over\nmany years. He who touches anything will regret it.\n\n(signed)\nFrobozz\n",
} end) end, true)

-- zil: 2dungeon.zil:1143  <OBJECT GLOBAL-WIZARD-CASE>
ZG._declare("GLOBAL_WIZARD_CASE", function() return ZG._declare_object("GLOBAL-WIZARD-CASE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"CASE", "CABINET"},
    ["ADJECTIVE"] = {"TROPHY", "WIZARD"},
    ["DESC"] = "Wizard's trophy cabinet",
    ["ACTION"] = ZG.WIZARD_CASE_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1150  <OBJECT WIZARD-CASE>
ZG._declare("WIZARD_CASE", function() return ZG._declare_object("WIZARD-CASE", function() return {
    ["LOC"] = ZG.TROPHY_ROOM,
    ["SYNONYM"] = {"CASE", "CABINET"},
    ["ADJECTIVE"] = {"TROPHY", "WIZARD"},
    ["DESC"] = "Wizard's trophy cabinet",
    ["FLAGS"] = {"CONTBIT", "TRANSBIT"},
    ["LDESC"] = "Imbedded in the wall is an ornate trophy cabinet.",
    ["ACTION"] = ZG.WIZARD_CASE_FCN,
    ["CAPACITY"] = 1000,
} end) end, true)

-- zil: 2dungeon.zil:1160  <OBJECT BROKEN-CASE>
ZG._declare("BROKEN_CASE", function() return ZG._declare_object("BROKEN-CASE", function() return {
    ["SYNONYM"] = {"CASE", "CABINET"},
    ["ADJECTIVE"] = {"BROKEN", "TROPHY", "WIZARD"},
    ["DESC"] = "smashed trophy cabinet",
    ["FLAGS"] = {"CONTBIT", "OPENBIT"},
    ["LDESC"] = "Shards of a smashed trophy case litter the room.",
} end) end, true)

-- zil: 2dungeon.zil:1167  <ROOM PENTAGRAM-ROOM>
ZG._declare("PENTAGRAM_ROOM", function() return ZG._declare_object("PENTAGRAM-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "In this room, inscribed on the floor, is a great pentagram drawn with\nblack chalk. In its center is a black circle.",
    ["DESC"] = "Pentagram Room",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["NORTH"] = {"TO", ZG.WORKBENCH_ROOM},
    ["GLOBAL"] = {ZG.GLOBAL_MENHIR, ZG.GLOBAL_CERBERUS, ZG.GLOBAL_WIZARD_CASE},
} end) end, true)

-- zil: 2dungeon.zil:1177  <OBJECT PENTAGRAM>
ZG._declare("PENTAGRAM", function() return ZG._declare_object("PENTAGRAM", function() return {
    ["LOC"] = ZG.PENTAGRAM_ROOM,
    ["SYNONYM"] = {"PENTAGRAM", "STAR", "CIRCLE"},
    ["ADJECTIVE"] = {"GREAT", "CHALK", "BLACK"},
    ["DESC"] = "pentagram",
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 200,
    ["ACTION"] = ZG.PENTAGRAM_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1186  <ROOM AQUARIUM-ROOM>
ZG._declare("AQUARIUM_ROOM", function() return ZG._declare_object("AQUARIUM-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "Here a dark hallway turns a corner. To the south is a dark room, to\nthe east is fitful light.",
    ["DESC"] = "Aquarium Room",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["EAST"] = {"TO", ZG.WORKBENCH_ROOM},
    ["IN"] = {"TO", ZG.IN_AQUARIUM},
    ["SOUTH"] = {"TO", ZG.WIZARDS_QUARTERS},
} end) end, true)

-- zil: 2dungeon.zil:1197  <OBJECT AQUARIUM>
ZG._declare("AQUARIUM", function() return ZG._declare_object("AQUARIUM", function() return {
    ["LOC"] = ZG.AQUARIUM_ROOM,
    ["SYNONYM"] = {"AQUARIUM", "GLASS"},
    ["ADJECTIVE"] = "HUGE",
    ["DESC"] = "aquarium",
    ["LDESC"] = "Filling the northern half of the room is a huge aquarium.",
    ["FLAGS"] = {"OPENBIT", "CONTBIT"},
    ["CAPACITY"] = 200,
    ["ACTION"] = ZG.AQUARIUM_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1207  <OBJECT PALANTIR-3>
ZG._declare("PALANTIR_3", function() return ZG._declare_object("PALANTIR-3", function() return {
    ["LOC"] = ZG.IN_AQUARIUM,
    ["SYNONYM"] = {"PALANTIR", "SPHERE"},
    ["ADJECTIVE"] = {"CRYSTAL", "WHITE", "CLEAR"},
    ["DESC"] = "clear crystal sphere",
    ["LDESC"] = "There is a clear crystal sphere lying in the sand.",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT", "NDESCBIT", "TRANSBIT"},
    ["ACTION"] = ZG.PALANTIR,
    ["VALUE"] = 20,
} end) end, true)

-- zil: 2dungeon.zil:1217  <OBJECT SERPENT>
ZG._declare("SERPENT", function() return ZG._declare_object("SERPENT", function() return {
    ["LOC"] = ZG.AQUARIUM,
    ["SYNONYM"] = {"SERPENT", "SNAKE"},
    ["ADJECTIVE"] = {"BABY", "SEA"},
    ["DESC"] = "baby sea serpent",
    ["LDESC"] = "There is a baby sea serpent swimming in the aquarium.",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.SERPENT_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1226  <OBJECT DEAD-SERPENT>
ZG._declare("DEAD_SERPENT", function() return ZG._declare_object("DEAD-SERPENT", function() return {
    ["SYNONYM"] = {"SERPENT", "SNAKE"},
    ["ADJECTIVE"] = {"DEAD", "BABY", "SEA"},
    ["DESC"] = "dead sea serpent",
    ["LDESC"] = "There is a dead sea serpent in a heap here.",
    ["FLAGS"] = "TAKEBIT",
    ["ACTION"] = ZG.DEAD_SERPENT_FCN,
    ["SIZE"] = 400,
} end) end, true)

-- zil: 2dungeon.zil:1235  <ROOM IN-AQUARIUM>
ZG._declare("IN_AQUARIUM", function() return ZG._declare_object("IN-AQUARIUM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "The floor here seems to be made of sand, but it is hard to see anything\nelse.",
    ["DESC"] = "Murky Room",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["OUT"] = {"TO", ZG.AQUARIUM_ROOM},
    ["ACTION"] = ZG.IN_AQUARIUM_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1245  <ROOM WIZARDS-QUARTERS>
ZG._declare("WIZARDS_QUARTERS", function() return ZG._declare_object("WIZARDS-QUARTERS", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Wizard's Quarters",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.AQUARIUM_ROOM},
    ["ACTION"] = ZG.WIZARD_QUARTERS_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1253  <ROOM CAROUSEL-ROOM>
ZG._declare("CAROUSEL_ROOM", function() return ZG._declare_object("CAROUSEL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Carousel Room",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.MARBLE_HALL},
    ["NE"] = {"TO", ZG.STREAM_PATH},
    ["EAST"] = {"TO", ZG.TOPIARY_ROOM},
    ["SE"] = {"TO", ZG.RIDDLE_ROOM},
    ["SOUTH"] = {"TO", ZG.MENHIR_ROOM},
    ["SW"] = {"TO", ZG.COBWEBBY_CORRIDOR},
    ["WEST"] = {"TO", ZG.ROOM_8},
    ["NW"] = {"TO", ZG.COOL_ROOM},
    ["ACTION"] = ZG.CAROUSEL_ROOM_FCN,
} end) end, true)

-- ; "SUBTITLE ROOMS FROM OLD ZORK"

-- zil: 2dungeon.zil:1270  <ROOM RIDDLE-ROOM>
ZG._declare("RIDDLE_ROOM", function() return ZG._declare_object("RIDDLE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Riddle Room",
    ["DOWN"] = {"TO", ZG.CAROUSEL_ROOM},
    ["NW"] = {"TO", ZG.CAROUSEL_ROOM},
    ["EAST"] = {"TO", ZG.PEARL_ROOM, "IF", "RIDDLE_DOOR", "IS", "OPEN"},
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.RIDDLE_ROOM_FCN,
    ["PSEUDO"] = {"RIDDLE", ZG.RIDDLE_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:1281  <OBJECT RIDDLE-DOOR>
ZG._declare("RIDDLE_DOOR", function() return ZG._declare_object("RIDDLE-DOOR", function() return {
    ["LOC"] = ZG.RIDDLE_ROOM,
    ["DESC"] = "stone door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"GREAT", "STONE"},
    ["FLAGS"] = {"DOORBIT", "CONTBIT", "NDESCBIT"},
    ["ACTION"] = ZG.RIDDLE_DOOR_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1289  <ROOM PEARL-ROOM>
ZG._declare("PEARL_ROOM", function() return ZG._declare_object("PEARL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a former broom closet. The exits are to the east and west.",
    ["DESC"] = "Pearl Room",
    ["EAST"] = {"TO", ZG.WELL_BOTTOM},
    ["WEST"] = {"TO", ZG.RIDDLE_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- ;"SUBTITLE VOLCANO AREA"

-- zil: 2dungeon.zil:1302  <ROOM VOLCANO-BOTTOM>
ZG._declare("VOLCANO_BOTTOM", function() return ZG._declare_object("VOLCANO-BOTTOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are at the bottom of a large dormant volcano. High above you\nlight enters from the cone of the volcano. The only exit is to the north.",
    ["DESC"] = "Volcano Bottom",
    ["NORTH"] = {"TO", ZG.LAVA_ROOM},
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1311  <ROOM VAIR-1>
ZG._declare("VAIR_1", function() return ZG._declare_object("VAIR-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are about one hundred feet above the bottom of the volcano. The\ntop of the volcano is clearly visible here.",
    ["DESC"] = "Volcano Core",
    ["FLAGS"] = {"NONLANDBIT", "NWALLBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1319  <ROOM VAIR-2>
ZG._declare("VAIR_2", function() return ZG._declare_object("VAIR-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are about two hundred feet above the volcano floor. Looming\nabove is the rim of the volcano. There is a small ledge on the west\nside.",
    ["DESC"] = "Volcano Near Small Ledge",
    ["WEST"] = {"TO", ZG.LEDGE_1},
    ["LAND"] = {"TO", ZG.LEDGE_1},
    ["FLAGS"] = {"NONLANDBIT", "NWALLBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1330  <ROOM VAIR-3>
ZG._declare("VAIR_3", function() return ZG._declare_object("VAIR-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are high above the floor of the volcano. The rim of the volcano\nlooks very narrow and you are very near it. To the\neast is what appears to be a viewing ledge, too thin to land on.",
    ["DESC"] = "Volcano by Viewing Ledge",
    ["FLAGS"] = {"NONLANDBIT", "NWALLBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1339  <ROOM VAIR-4>
ZG._declare("VAIR_4", function() return ZG._declare_object("VAIR-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are near the rim of the volcano. Above you it is open to the sky.\nTo the west, there is a place to land on a wide ledge.",
    ["DESC"] = "Volcano Near Wide Ledge",
    ["LAND"] = {"TO", ZG.LEDGE_2},
    ["WEST"] = {"TO", ZG.LEDGE_2},
    ["FLAGS"] = {"NONLANDBIT", "NWALLBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1349  <ROOM LEDGE-1>
ZG._declare("LEDGE_1", function() return ZG._declare_object("LEDGE-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a narrow ledge within an old dormant volcano. This ledge is\nabout halfway between the floor below and the rim above. There is an exit\nto the south.",
    ["DESC"] = "Narrow Ledge",
    ["DOWN"] = "I wouldn't jump from here.",
    ["WEST"] = {"TO", ZG.VOLCANO_BOTTOM, "IF", "GNOME_DOOR_FLAG"},
    ["SOUTH"] = {"TO", ZG.LIBRARY},
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1361  <ROOM LIBRARY>
ZG._declare("LIBRARY", function() return ZG._declare_object("LIBRARY", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This must have been a large library, probably for the royal family. All\nof the shelves have been gnawed to pieces by unfriendly gnomes. To the\nnorth is an exit.",
    ["DESC"] = "Library",
    ["NORTH"] = {"TO", ZG.LEDGE_1},
    ["OUT"] = {"TO", ZG.LEDGE_1},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1372  <ROOM VOLCANO-VIEW>
ZG._declare("VOLCANO_VIEW", function() return ZG._declare_object("VOLCANO-VIEW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are on a ledge in the middle of a large volcano. Below you\nthe volcano bottom can be seen and above is the rim of the volcano.\nA couple of ledges can be seen on the other side of the volcano;\nit appears that this ledge is intermediate in elevation between\nthose on the other side. The exit from this room is to the east.",
    ["DESC"] = "Volcano View",
    ["DOWN"] = "I wouldn't try that.",
    ["CROSS"] = "It is impossible to cross this distance.",
    ["EAST"] = {"TO", ZG.LAVA_TUBE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1386  <ROOM LEDGE-2>
ZG._declare("LEDGE_2", function() return ZG._declare_object("LEDGE-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Wide Ledge",
    ["DOWN"] = "It's a long way down.",
    ["WEST"] = {"TO", ZG.VOLCANO_BOTTOM, "IF", "GNOME_DOOR_FLAG"},
    ["SOUTH"] = {"TO", ZG.SAFE_ROOM},
    ["ACTION"] = ZG.LEDGE_FCN,
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1396  <ROOM SAFE-ROOM>
ZG._declare("SAFE_ROOM", function() return ZG._declare_object("SAFE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Dusty Room",
    ["NORTH"] = {"TO", ZG.LEDGE_2},
    ["ACTION"] = ZG.SAFE_ROOM_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1404  <ROOM LAVA-ROOM>
ZG._declare("LAVA_ROOM", function() return ZG._declare_object("LAVA-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small room, whose walls are formed by an old lava flow.\nThere are exits here to the east and the south.",
    ["DESC"] = "Lava Room",
    ["SOUTH"] = {"TO", ZG.VOLCANO_BOTTOM},
    ["EAST"] = {"TO", ZG.GLACIER_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1414  <GLOBAL BLOC>
-- BLOC is declared in ZilGlobal.lua

-- zil: 2dungeon.zil:1420  <ROOM MAGNET-ROOM>
ZG._declare("MAGNET_ROOM", function() return ZG._declare_object("MAGNET-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Low Room",
    ["NORTH"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["SOUTH"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["WEST"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["NE"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["NW"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["SW"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["SE"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["EAST"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["OUT"] = {"PER", ZG.MAGNET_ROOM_EXIT},
    ["ACTION"] = ZG.MAGNET_ROOM_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1436  <ROOM MACHINE-ROOM>
ZG._declare("MACHINE_ROOM", function() return ZG._declare_object("MACHINE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a large room full of assorted heavy machinery, whirring noisily.\nThe room smells of burned resistors. Along one wall are three buttons\nwhich are, respectively, round, triangular, and square. Naturally,\nabove these buttons are instructions written in EBCDIC. A large sign\nin English above all the buttons says\n       \"DANGER -- HIGH VOLTAGE\"\nThere are exits to the west and the south.",
    ["DESC"] = "Machine Room",
    ["WEST"] = {"TO", ZG.MAGNET_ROOM},
    ["SOUTH"] = {"TO", ZG.CAGE_ROOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1451  <ROOM CAGE-ROOM>
ZG._declare("CAGE_ROOM", function() return ZG._declare_object("CAGE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a dingy closet adjacent to a larger room to the north.\nChiselled into a wall are these words:\n\n     Protected by\n       FROBOZZ\n Magic Alarm Company\n  (Hello, footpad!)\n\nThere doesn't seem to be any footpad here, however.",
    ["DESC"] = "Dingy Closet",
    ["OUT"] = {"TO", ZG.MACHINE_ROOM},
    ["NORTH"] = {"TO", ZG.MACHINE_ROOM},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1467  <ROOM IN-CAGE>
ZG._declare("IN_CAGE", function() return ZG._declare_object("IN-CAGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are trapped inside a solid steel cage.",
    ["DESC"] = "Cage",
    ["ACTION"] = ZG.IN_CAGE_FCN,
    ["FLAGS"] = {"RLANDBIT", "NWALLBIT", "ONBIT"},
} end) end, true)

-- zil: 2dungeon.zil:1474  <ROOM WELL-TOP>
ZG._declare("WELL_TOP", function() return ZG._declare_object("WELL-TOP", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "You are at the top of the well. Well done. There are etchings on\nthe side of the well. There is a small crack across the floor at the\nentrance to a room on the east, but it can be crossed easily.",
    ["DESC"] = "Top of Well",
    ["EAST"] = {"TO", ZG.TEA_ROOM},
    ["DOWN"] = "It's a long way down!",
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT"},
    ["VALUE"] = 10,
    ["GLOBAL"] = ZG.WELL,
    ["PSEUDO"] = {"CRACK", ZG.CRACK_PSEUDO},
} end) end, true)

-- zil: 2dungeon.zil:1488  <ROUTINE CRACK-PSEUDO ()>
ZG.actions:register("CRACK_PSEUDO", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("It is a small crack (as advertised) with no redeeming value.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CRACK-PSEUDO")

ZG.CRACK_PSEUDO = ZG.actions:get("CRACK_PSEUDO")

-- zil: 2dungeon.zil:1493  <ROOM WELL-BOTTOM>
ZG._declare("WELL_BOTTOM", function() return ZG._declare_object("WELL-BOTTOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a damp circular room, whose walls are made of brick and\nmortar. The roof of this room is not visible, but there appear to be\nsome etchings on the walls. There is a passageway to the west.",
    ["DESC"] = "Circular Room",
    ["WEST"] = {"TO", ZG.PEARL_ROOM},
    ["UP"] = "The walls cannot be climbed.",
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT"},
    ["GLOBAL"] = ZG.WELL,
} end) end, true)

-- zil: 2dungeon.zil:1505  <ROOM TEA-ROOM>
ZG._declare("TEA_ROOM", function() return ZG._declare_object("TEA-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small room containing a large oblong table, no doubt set\nfor afternoon tea. It is clear from the\nobjects on the table that the users were indeed mad. In the eastern\ncorner of the room is a small hole (no more than four inches high).\nThere are passageways leading away to the west and the northwest.",
    ["DESC"] = "Tea Room",
    ["EAST"] = "Only a mouse could get in there.",
    ["WEST"] = {"TO", ZG.WELL_TOP},
    ["NW"] = {"TO", ZG.MAGNET_ROOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["PSEUDO"] = {"HOLE", ZG.ALICE_HOLE},
} end) end, true)

-- zil: 2dungeon.zil:1520  <ROUTINE ALICE-HOLE ()>
ZG.actions:register("ALICE_HOLE", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The hole is very small. You could never enter it.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do return ZG.TELL("You can't see what's beyond the hole from here.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.PSEUDO_OBJECT)) then
        do return ZG.TELL("It doesn't fit through the hole.", ZG._TK.CR) end
    else
        do return false end
    end

end, "ALICE-HOLE")

ZG.ALICE_HOLE = ZG.actions:get("ALICE_HOLE")

-- zil: 2dungeon.zil:1528  <ROOM POSTS-ROOM>
ZG._declare("POSTS_ROOM", function() return ZG._declare_object("POSTS-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is an enormous room, in the center of which are four wooden\nposts delineating a rectangular area, above which is what appears to\nbe a wooden roof. In fact, all objects in this room appear to be\nabnormally large. To the east is a passageway. There are large gaping\nchasms to the west and northwest.",
    ["DESC"] = "Posts Room",
    ["NW"] = "A great chasm blocks your way.",
    ["EAST"] = {"TO", ZG.POOL_ROOM},
    ["WEST"] = "A great chasm blocks your way.",
    ["DOWN"] = "A great chasm blocks your way.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.POSTS_ROOM_FCN,
    ["GLOBAL"] = ZG.CHASM,
} end) end, true)

-- zil: 2dungeon.zil:1545  <ROOM POOL-ROOM>
ZG._declare("POOL_ROOM", function() return ZG._declare_object("POOL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a large room, one half of which is depressed. Salty water flows\nfrom a large leak in the ceiling. The only exit is to the west.",
    ["DESC"] = "Pool Room",
    ["OUT"] = {"TO", ZG.POSTS_ROOM},
    ["WEST"] = {"TO", ZG.POSTS_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- ; "SUBTITLE BANK OF ZORK"

-- zil: 2dungeon.zil:1559  <ROOM BANK-ENTRANCE>
ZG._declare("BANK_ENTRANCE", function() return ZG._declare_object("BANK-ENTRANCE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the entrance hall of the Bank of Zork, the largest\nbanking institution of the Great Underground Empire. A partial\naccount of its history is in \"The Lives of the Twelve Flatheads,\" in\nthe chapter on J. Pierpont Flathead. A more detailed history (albeit\nless objective) may be found in Flathead's outrageous autobiography\n\"I'm Rich and You Aren't - So There!\".\nMost of the furniture has been ravaged by passing scavengers. All\nthat remains are two signs at the northwest and northeast corners of\nthe room, which say:\n\n    <--  VIEWING ROOMS  -->\n\nThe way out (ornate but tasteful) is to the east.\n",
    ["DESC"] = "Bank Entrance",
    ["NW"] = {"TO", ZG.TELLER_WEST},
    ["NE"] = {"TO", ZG.TELLER_EAST},
    ["EAST"] = {"TO", ZG.FRESCO_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1582  <ROOM TELLER-WEST>
ZG._declare("TELLER_WEST", function() return ZG._declare_object("TELLER-WEST", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "West Teller's Room",
    ["NORTH"] = {"TO", ZG.VIEWING_WEST},
    ["SOUTH"] = {"TO", ZG.BANK_ENTRANCE},
    ["WEST"] = {"TO", ZG.DEPOSITORY},
    ["ACTION"] = ZG.TELLER_ROOM,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1592  <ROOM TELLER-EAST>
ZG._declare("TELLER_EAST", function() return ZG._declare_object("TELLER-EAST", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "East Teller's Room",
    ["NORTH"] = {"TO", ZG.VIEWING_EAST},
    ["SOUTH"] = {"TO", ZG.BANK_ENTRANCE},
    ["EAST"] = {"TO", ZG.DEPOSITORY},
    ["ACTION"] = ZG.TELLER_ROOM,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1602  <ROOM VIEWING-WEST>
ZG._declare("VIEWING_WEST", function() return ZG._declare_object("VIEWING-WEST", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This room was used by holders of safety deposit boxes to view\ntheir contents. On the north side of the room is a sign which says:\n\n\"Remain here while the teller retrieves your safety deposit box.\nWhen you are finished, leave the box, and exit to the south.\nSafety deposit boxes cannot be removed from this room!\n\nThank You for Banking at the Zork!\"\n",
    ["DESC"] = "West Viewing Room",
    ["SOUTH"] = {"TO", ZG.BANK_ENTRANCE},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL},
} end) end, true)

-- zil: 2dungeon.zil:1619  <ROOM VIEWING-EAST>
ZG._declare("VIEWING_EAST", function() return ZG._declare_object("VIEWING-EAST", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This room was used by holders of safety deposit boxes to view\ntheir contents. On the north side of the room is a sign which says\n\n\"Remain here while the teller retrieves your safety deposit box.\nWhen you are finished, leave the box, and exit to the south.\nSafety deposit boxes cannot be removed from this room!\n\nThank You for Banking at the Zork!\"\n",
    ["DESC"] = "East Viewing Room",
    ["SOUTH"] = {"TO", ZG.BANK_ENTRANCE},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL},
} end) end, true)

-- zil: 2dungeon.zil:1636  <ROOM SMALL-ROOM>
ZG._declare("SMALL_ROOM", function() return ZG._declare_object("SMALL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small, bare room with no distinguishing features. There\nare no exits from this room.",
    ["DESC"] = "Small Room",
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL},
} end) end, true)

-- zil: 2dungeon.zil:1645  <ROOM VAULT>
ZG._declare("VAULT", function() return ZG._declare_object("VAULT", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is the Vault of the Bank of Zork, in which there are no doors.",
    ["DESC"] = "Vault",
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.SEWL, ZG.SWWL, ZG.SNWL, ZG.SSWL},
} end) end, true)

-- zil: 2dungeon.zil:1653  <ROOM DEPOSITORY>
ZG._declare("DEPOSITORY", function() return ZG._declare_object("DEPOSITORY", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a large rectangular room. The east and west walls were used\nfor storing safety deposit boxes, but all have been carefully removed\nby evil persons. To the east, west, and south of the room are large\ndoorways. The northern \"wall\" of the room is a shimmering curtain of\nlight. In the center of the room is a large stone cube, about 10 feet\non a side. Engraved on the side of the cube is some lettering.",
    ["DESC"] = "Safety Depository",
    ["NORTH"] = "There is a curtain of light there.",
    ["WEST"] = {"PER", ZG.BKLEAVEW},
    ["EAST"] = {"PER", ZG.BKLEAVEE},
    ["SOUTH"] = {"TO", ZG.OFFICE},
    ["ACTION"] = ZG.DEPOSITORY_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.SNWL,
} end) end, true)

-- zil: 2dungeon.zil:1671  <ROOM OFFICE>
ZG._declare("OFFICE", function() return ZG._declare_object("OFFICE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This room was the office of the Chairman of the Bank of Zork.\nLike the other rooms here, it has been extensively vandalized.\nThe lone exit is to the north.",
    ["DESC"] = "Chairman's Office",
    ["NORTH"] = {"TO", ZG.DEPOSITORY},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 2dungeon.zil:1681  <OBJECT MATCH>
ZG._declare("MATCH", function() return ZG._declare_object("MATCH", function() return {
    ["LOC"] = ZG.GAZEBO_TABLE,
    ["SYNONYM"] = {"MATCH", "MATCHES", "MATCHBOOK"},
    ["ADJECTIVE"] = "ZORK",
    ["DESC"] = "matchbook",
    ["FLAGS"] = {"READBIT", "TAKEBIT"},
    ["ACTION"] = ZG.MATCH_FCN,
    ["LDESC"] = "There is a matchbook saying \"Visit ZORK I\" here.",
    ["TEXT"] = "\">> Visit Exotic ZORK I <<\n\nConsult the Frobozz Magic Travel Agency, or visit your local\ncomputer store for more details.\"",
    ["SIZE"] = 2,
} end) end, true)

-- zil: 2dungeon.zil:1702  <ROOM DREARY-ROOM>
ZG._declare("DREARY_ROOM", function() return ZG._declare_object("DREARY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Dreary Room",
    ["SOUTH"] = {"TO", ZG.TINY_ROOM, "IF", "PDOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.TINY_ROOM, "IF", "PDOOR", "IS", "OPEN"},
    ["ACTION"] = ZG.DREARY_ROOM_FCN,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.PDOOR, ZG.PWINDOW},
} end) end, true)

-- zil: 2dungeon.zil:1712  <ROOM TINY-ROOM>
ZG._declare("TINY_ROOM", function() return ZG._declare_object("TINY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Tiny Room",
    ["NORTH"] = {"TO", ZG.DREARY_ROOM, "IF", "PDOOR", "IS", "OPEN"},
    ["IN"] = {"TO", ZG.DREARY_ROOM, "IF", "PDOOR", "IS", "OPEN"},
    ["DOWN"] = {"TO", ZG.RAVINE_LEDGE},
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.TINY_ROOM_FCN,
    ["GLOBAL"] = {ZG.PDOOR, ZG.PWINDOW, ZG.CHASM},
} end) end, true)

-- ; "SUBTITLE OBJECTS"

-- zil: 2dungeon.zil:1727  <OBJECT GNOME>
ZG._declare("GNOME", function() return ZG._declare_object("GNOME", function() return {
    ["SYNONYM"] = "GNOME",
    ["ADJECTIVE"] = "VOLCANO",
    ["DESC"] = "Volcano Gnome",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.GNOME_FCN,
    ["LDESC"] = "There is a nervous Volcano Gnome here.",
} end) end, true)

-- zil: 2dungeon.zil:1735  <OBJECT BALLOON>
ZG._declare("BALLOON", function() return ZG._declare_object("BALLOON", function() return {
    ["LOC"] = ZG.VOLCANO_BOTTOM,
    ["SYNONYM"] = {"BALLOON", "BASKET"},
    ["ADJECTIVE"] = "WICKER",
    ["DESC"] = "basket",
    ["FLAGS"] = {"VEHBIT", "OPENBIT"},
    ["ACTION"] = ZG.BALLOON_FCN,
    ["DESCFCN"] = ZG.BALLOON_FCN,
    ["CAPACITY"] = 100,
    ["SIZE"] = 70,
    ["VTYPE"] = 0,
} end) end, true)

-- zil: 2dungeon.zil:1747  <OBJECT BALLOON-LABEL>
ZG._declare("BALLOON_LABEL", function() return ZG._declare_object("BALLOON-LABEL", function() return {
    ["SYNONYM"] = "LABEL",
    ["ADJECTIVE"] = "BLUE",
    ["DESC"] = "blue label",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["LDESC"] = "There is a blue label here.",
    ["SIZE"] = 1,
    ["TEXT"] = "\n!! FROBOZZ MAGIC BALLOON COMPANY !!\n\nHello, Aviator!\n\nTo land your balloon, say LAND\nOtherwise, you're on your own!\n\nNo warranty expressed or implied.",
} end) end, true)

-- zil: 2dungeon.zil:1765  <OBJECT SAFE>
ZG._declare("SAFE", function() return ZG._declare_object("SAFE", function() return {
    ["LOC"] = ZG.SAFE_ROOM,
    ["SYNONYM"] = {"SAFE", "BOX"},
    ["ADJECTIVE"] = {"STEEL", "RUSTY"},
    ["DESC"] = "box",
    ["FLAGS"] = {"CONTBIT", "NDESCBIT"},
    ["ACTION"] = ZG.SAFE_FCN,
    ["CAPACITY"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:1774  <OBJECT BRAIDED-WIRE>
ZG._declare("BRAIDED_WIRE", function() return ZG._declare_object("BRAIDED-WIRE", function() return {
    ["FLAGS"] = "NDESCBIT",
    ["LOC"] = ZG.BALLOON,
    ["SYNONYM"] = {"ROPE", "WIRE"},
    ["ADJECTIVE"] = "BRAIDED",
    ["DESC"] = "braided wire",
    ["ACTION"] = ZG.WIRE_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1782  <OBJECT BRICK>
ZG._declare("BRICK", function() return ZG._declare_object("BRICK", function() return {
    ["LOC"] = ZG.MARBLE_HALL,
    ["SYNONYM"] = "BRICK",
    ["ADJECTIVE"] = {"SQUARE", "CLAY"},
    ["DESC"] = "brick",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT", "OPENBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.BRICK_FCN,
    ["LDESC"] = "There is a square brick here which feels like clay.",
    ["CAPACITY"] = 2,
    ["SIZE"] = 9,
} end) end, true)

-- zil: 2dungeon.zil:1793  <OBJECT EXPLOSION>
ZG._declare("EXPLOSION", function() return ZG._declare_object("EXPLOSION", function() return {
    ["SYNONYM"] = "KREBF",
    ["DESC"] = "debris from an explosion",
    ["LDESC"] = "The room is cluttered with debris from an explosion. The walls seem ready\nto collapse.",
    ["FLAGS"] = true,
} end) end, true)

-- zil: 2dungeon.zil:1801  <OBJECT DEAD-BALLOON>
ZG._declare("DEAD_BALLOON", function() return ZG._declare_object("DEAD-BALLOON", function() return {
    ["SYNONYM"] = {"BALLOON", "BASKET"},
    ["ADJECTIVE"] = "BROKEN",
    ["DESC"] = "broken balloon",
    ["LDESC"] = "There is a balloon here, broken into pieces.",
    ["SIZE"] = 40,
} end) end, true)

-- zil: 2dungeon.zil:1808  <OBJECT ROUND-BUTTON>
ZG._declare("ROUND_BUTTON", function() return ZG._declare_object("ROUND-BUTTON", function() return {
    ["LOC"] = ZG.MACHINE_ROOM,
    ["SYNONYM"] = "BUTTON",
    ["ADJECTIVE"] = "ROUND",
    ["DESC"] = "round button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTONS,
} end) end, true)

-- zil: 2dungeon.zil:1816  <OBJECT SQUARE-BUTTON>
ZG._declare("SQUARE_BUTTON", function() return ZG._declare_object("SQUARE-BUTTON", function() return {
    ["LOC"] = ZG.MACHINE_ROOM,
    ["SYNONYM"] = "BUTTON",
    ["ADJECTIVE"] = "SQUARE",
    ["DESC"] = "square button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTONS,
} end) end, true)

-- zil: 2dungeon.zil:1824  <OBJECT TRIANGULAR-BUTTON>
ZG._declare("TRIANGULAR_BUTTON", function() return ZG._declare_object("TRIANGULAR-BUTTON", function() return {
    ["LOC"] = ZG.MACHINE_ROOM,
    ["SYNONYM"] = "BUTTON",
    ["ADJECTIVE"] = "TRIANGULAR",
    ["DESC"] = "triangular button",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.BUTTONS,
} end) end, true)

-- zil: 2dungeon.zil:1832  <OBJECT CARD>
ZG._declare("CARD", function() return ZG._declare_object("CARD", function() return {
    ["LOC"] = ZG.SAFE,
    ["SYNONYM"] = {"CARD", "NOTE"},
    ["DESC"] = "card",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["LDESC"] = "There is a card with writing on it here.",
    ["SIZE"] = 1,
    ["TEXT"] = "\nWarning:\n    This room was constructed over very weak rock strata. Detonation\nof explosives in this room is strictly prohibited!\n         Frobozz Magic Cave Company\n         per M. Agrippa, foreman\n",
} end) end, true)

-- zil: 2dungeon.zil:1848  <OBJECT CLOTH-BAG>
ZG._declare("CLOTH_BAG", function() return ZG._declare_object("CLOTH-BAG", function() return {
    ["LOC"] = ZG.BALLOON,
    ["SYNONYM"] = "BAG",
    ["ADJECTIVE"] = "CLOTH",
    ["FLAGS"] = "NDESCBIT",
    ["DESC"] = "cloth bag",
    ["ACTION"] = ZG.BCONTENTS,
} end) end, true)

-- zil: 2dungeon.zil:1856  <OBJECT CROWN>
ZG._declare("CROWN", function() return ZG._declare_object("CROWN", function() return {
    ["LOC"] = ZG.SAFE,
    ["SYNONYM"] = {"CROWN", "TREASURE"},
    ["ADJECTIVE"] = "GAUDY",
    ["DESC"] = "gaudy crown",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT", "WEARBIT"},
    ["FDESC"] = "The excessively gaudy crown of Lord Dimwit Flathead sits in the safe.",
    ["LDESC"] = "Lord Dimwit's crown is here.",
    ["SIZE"] = 10,
    ["VALUE"] = 20,
} end) end, true)

-- zil: 2dungeon.zil:1868  <OBJECT PALANTIR-1>
ZG._declare("PALANTIR_1", function() return ZG._declare_object("PALANTIR-1", function() return {
    ["LOC"] = ZG.CAGE_ROOM,
    ["SYNONYM"] = {"SPHERE", "BALL", "PALANTIR"},
    ["ADJECTIVE"] = {"CRYSTAL", "RED"},
    ["DESC"] = "red crystal sphere",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT", "TRANSBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.SPHERE_FCN,
    ["LDESC"] = "There is a beautiful red crystal sphere here.",
    ["SIZE"] = 10,
    ["VALUE"] = 20,
} end) end, true)

-- zil: 2dungeon.zil:1879  <OBJECT VIOLIN>
ZG._declare("VIOLIN", function() return ZG._declare_object("VIOLIN", function() return {
    ["LOC"] = ZG.IRON_BOX,
    ["SYNONYM"] = {"STRADIVARIUS", "VIOLIN", "TREASURE"},
    ["ADJECTIVE"] = "FANCY",
    ["DESC"] = "fancy violin",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT"},
    ["LDESC"] = "There is a Stradivarius here.",
    ["SIZE"] = 10,
    ["VALUE"] = 20,
    ["ACTION"] = ZG.VIOLIN_FCN,
} end) end, true)

-- zil: 2dungeon.zil:1890  <OBJECT ICE>
ZG._declare("ICE", function() return ZG._declare_object("ICE", function() return {
    ["LOC"] = ZG.GLACIER_ROOM,
    ["SYNONYM"] = {"ICE", "MASS", "GLACIER"},
    ["ADJECTIVE"] = {"COLD", "ICY"},
    ["DESC"] = "glacier",
    ["ACTION"] = ZG.GLACIER_FCN,
    ["LDESC"] = "A mass of ice fills the western half of the room.",
} end) end, true)

-- zil: 2dungeon.zil:1898  <OBJECT FLASK>
ZG._declare("FLASK", function() return ZG._declare_object("FLASK", function() return {
    ["LOC"] = ZG.POOL_ROOM,
    ["SYNONYM"] = "FLASK",
    ["ADJECTIVE"] = "GLASS",
    ["DESC"] = "stoppered glass flask filled with liquid",
    ["FLAGS"] = {"TAKEBIT", "TRANSBIT", "READBIT"},
    ["ACTION"] = ZG.FLASK_FCN,
    ["LDESC"] = "A stoppered glass flask with a skull-and-crossbones marking is here.\nThe flask is filled with some clear liquid.",
    ["CAPACITY"] = 5,
    ["TEXT"] = "There is a skull-and-crossbones engraved on the glass.",
    ["SIZE"] = 10,
} end) end, true)

-- zil: 2dungeon.zil:1912  <OBJECT ROBOT-LABEL>
ZG._declare("ROBOT_LABEL", function() return ZG._declare_object("ROBOT-LABEL", function() return {
    ["LOC"] = ZG.MAGNET_ROOM,
    ["SYNONYM"] = {"PAPER", "PIECE", "INSTRUCTIONS"},
    ["ADJECTIVE"] = "GREEN",
    ["DESC"] = "green piece of paper",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["LDESC"] = "There is a green piece of paper here.",
    ["SIZE"] = 3,
    ["TEXT"] = "!!  FROBOZZ MAGIC ROBOT COMPANY  !!\n\n\nHello, Master!\n\n   I am a late-model robot, trained at GUE Tech to perform various\nsimple household functions.\n\n   To activate me, say the following:\n\n        >ROBOT, <things to do>\n\nAt your service!",
} end) end, true)

-- zil: 2dungeon.zil:1934  <OBJECT SLOT>
ZG._declare("SLOT", function() return ZG._declare_object("SLOT", function() return {
    ["LOC"] = ZG.SAFE_ROOM,
    ["SYNONYM"] = {"SLOT", "HOLE"},
    ["DESC"] = "hole",
    ["FLAGS"] = {"OPENBIT", "NDESCBIT"},
    ["CAPACITY"] = 10,
    ["ACTION"] = ZG.SLOT_F,
} end) end, true)

-- zil: 2dungeon.zil:1942  <ROUTINE SLOT-F ()>
ZG.actions:register("SLOT_F", function()

    if (ZG._T(ZG.VERB_p("LOOK-INSIDE")) and (not ZG._T(ZG.FIRST_p(ZG.SLOT)))) then
        do return ZG.TELL("There's nothing in the hole.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The oblong hole has been chipped out of the box, probably by someone\nwanting whatever is inside the box. The attempt was a pathetic failure,\nhowever.", ZG._TK.CR) end
    else
        do return false end
    end

end, "SLOT-F")

ZG.SLOT_F = ZG.actions:get("SLOT_F")

-- zil: 2dungeon.zil:1951  <OBJECT HOOK-2>
ZG._declare("HOOK_2", function() return ZG._declare_object("HOOK-2", function() return {
    ["LOC"] = ZG.LEDGE_2,
    ["SYNONYM"] = "HOOK",
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "hook",
    ["LDESC"] = "There is a small hook attached to the rock here.",
} end) end, true)

-- zil: 2dungeon.zil:1958  <OBJECT HOOK-1>
ZG._declare("HOOK_1", function() return ZG._declare_object("HOOK-1", function() return {
    ["LOC"] = ZG.LEDGE_1,
    ["SYNONYM"] = "HOOK",
    ["ADJECTIVE"] = "SMALL",
    ["DESC"] = "hook",
    ["LDESC"] = "There is a small hook attached to the rock here.",
} end) end, true)

-- zil: 2dungeon.zil:1965  <OBJECT LAMP>
ZG._declare("LAMP", function() return ZG._declare_object("LAMP", function() return {
    ["LOC"] = ZG.INSIDE_BARROW,
    ["SYNONYM"] = {"LAMP", "LANTERN", "LIGHT"},
    ["ADJECTIVE"] = "BRASS",
    ["DESC"] = "lamp",
    ["FLAGS"] = {"TAKEBIT", "LIGHTBIT"},
    ["FDESC"] = "A strangely familiar brass lantern is lying on the ground.",
    ["ACTION"] = ZG.LANTERN,
    ["SIZE"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:1975  <OBJECT BROKEN-LAMP>
ZG._declare("BROKEN_LAMP", function() return ZG._declare_object("BROKEN-LAMP", function() return {
    ["SYNONYM"] = {"LAMP", "LANTERN", "LIGHT"},
    ["ADJECTIVE"] = {"BROKEN", "BRASS"},
    ["DESC"] = "broken brass lantern",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:1982  <OBJECT ALICE-TABLE>
ZG._declare("ALICE_TABLE", function() return ZG._declare_object("ALICE-TABLE", function() return {
    ["LOC"] = ZG.TEA_ROOM,
    ["SYNONYM"] = "TABLE",
    ["ADJECTIVE"] = {"LARGE", "OBLONG"},
    ["FLAGS"] = {"CONTBIT", "SURFACEBIT", "OPENBIT"},
    ["DESC"] = "large oblong table",
    ["CAPACITY"] = 50,
} end) end, true)

-- zil: 2dungeon.zil:1990  <OBJECT MANGLED-CAGE>
ZG._declare("MANGLED_CAGE", function() return ZG._declare_object("MANGLED-CAGE", function() return {
    ["SYNONYM"] = "CAGE",
    ["ADJECTIVE"] = {"MANGLED", "STEEL"},
    ["DESC"] = "mangled cage",
    ["FLAGS"] = "TAKEBIT",
    ["LDESC"] = "There is a mangled steel cage here.",
    ["SIZE"] = 60,
} end) end, true)

-- zil: 2dungeon.zil:1998  <OBJECT PEARL>
ZG._declare("PEARL", function() return ZG._declare_object("PEARL", function() return {
    ["LOC"] = ZG.PEARL_ROOM,
    ["SYNONYM"] = {"NECKLACE", "PEARLS", "TREASURE"},
    ["ADJECTIVE"] = "PEARL",
    ["DESC"] = "pearl necklace",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT"},
    ["LDESC"] = "There is a pearl necklace here with hundreds of large pearls.",
    ["SIZE"] = 10,
    ["VALUE"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:2008  <OBJECT EAT-ME-CAKE>
ZG._declare("EAT_ME_CAKE", function() return ZG._declare_object("EAT-ME-CAKE", function() return {
    ["LOC"] = ZG.ALICE_TABLE,
    ["SYNONYM"] = {"CAKE", "ICING", "CAKES", "LETTER"},
    ["ADJECTIVE"] = {"GREEN", "FROSTED"},
    ["DESC"] = "cake frosted with green letters",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "FOODBIT"},
    ["ACTION"] = ZG.EATME_FCN,
    ["TEXT"] = "The icing spells out \"Eat Me.\"",
    ["SIZE"] = 4,
} end) end, true)

-- zil: 2dungeon.zil:2018  <OBJECT BLUE-ICING>
ZG._declare("BLUE_ICING", function() return ZG._declare_object("BLUE-ICING", function() return {
    ["LOC"] = ZG.ALICE_TABLE,
    ["SYNONYM"] = {"CAKE", "ICING", "CAKES", "LETTER"},
    ["ADJECTIVE"] = {"BLUE", "FROSTED"},
    ["DESC"] = "cake frosted with blue letters",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "FOODBIT"},
    ["ACTION"] = ZG.CAKE_FCN,
    ["SIZE"] = 4,
} end) end, true)

-- zil: 2dungeon.zil:2027  <OBJECT ORANGE-ICING>
ZG._declare("ORANGE_ICING", function() return ZG._declare_object("ORANGE-ICING", function() return {
    ["LOC"] = ZG.ALICE_TABLE,
    ["SYNONYM"] = {"CAKE", "CAKES", "ICING", "LETTER"},
    ["ADJECTIVE"] = {"ORANGE", "FROSTED"},
    ["DESC"] = "cake frosted with orange letters",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "FOODBIT"},
    ["ACTION"] = ZG.CAKE_FCN,
    ["SIZE"] = 4,
} end) end, true)

-- zil: 2dungeon.zil:2036  <OBJECT RED-ICING>
ZG._declare("RED_ICING", function() return ZG._declare_object("RED-ICING", function() return {
    ["LOC"] = ZG.ALICE_TABLE,
    ["SYNONYM"] = {"CAKE", "CAKES", "ICING", "LETTER"},
    ["ADJECTIVE"] = {"RED", "FROSTED"},
    ["DESC"] = "cake frosted with red letters",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "FOODBIT"},
    ["ACTION"] = ZG.CAKE_FCN,
    ["SIZE"] = 4,
} end) end, true)

-- zil: 2dungeon.zil:2045  <OBJECT LEAK>
ZG._declare("LEAK", function() return ZG._declare_object("LEAK", function() return {
    ["LOC"] = ZG.POOL_ROOM,
    ["SYNONYM"] = "LEAK",
    ["ADJECTIVE"] = "LARGE",
    ["DESC"] = "leak",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.PLEAK,
} end) end, true)

-- zil: 2dungeon.zil:2053  <OBJECT POOL>
ZG._declare("POOL", function() return ZG._declare_object("POOL", function() return {
    ["LOC"] = ZG.POOL_ROOM,
    ["SYNONYM"] = {"POOL", "TEARS"},
    ["ADJECTIVE"] = "LARGE",
    ["DESC"] = "pool of tears",
    ["LDESC"] = "The leak has submerged the depressed area in a pool of tears. There is\na hazy something at the deepest part of the pool.",
    ["ACTION"] = ZG.POOL_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2063  <OBJECT COIN>
ZG._declare("COIN", function() return ZG._declare_object("COIN", function() return {
    ["LOC"] = ZG.LEDGE_1,
    ["SYNONYM"] = {"COIN", "ZORKMID", "GOLD", "TREASURE"},
    ["ADJECTIVE"] = {"GOLD", "PRICELESS"},
    ["DESC"] = "priceless zorkmid",
    ["FLAGS"] = {"STAGGERED", "READBIT", "TAKEBIT"},
    ["FDESC"] = "On the floor is a priceless gold zorkmid (a valuable collector's item).",
    ["LDESC"] = "There is an engraved zorkmid here.",
    ["SIZE"] = 10,
    ["VALUE"] = 20,
    ["TEXT"] = "This is a beautiful octagonal coin bearing the legends \"Ten Thousand\nZorkmids\" and \"In Frobs We Trust\".",
} end) end, true)

-- ;"      -------------------------|
--       /      Gold Zorkmid        \\|
--      /  T e n   T h o u s a n d   \\|
--     /        Z O R K M I D S       \\|
--    /                                \\|
--   /        !!!!!!!!!!!!!!!!!!        \\|
--  /        !!!!!          !!!!!        \\|
-- !           !!!  ^^  ^^  !!!           !|
-- !           !!!  OO  OO  !!!           !|
-- ! In Frobs  !!!    <<    !!!  We Trust !|
-- !            !! (______) !!            !|
-- !             !          !             !|
-- !             !__________!             !|
--  \\                                    /|
--   \\     -- Lord Dimwit Flathead --   /|
--    \\     -- Beloved of Zorkers --   /|
--     \\                              /|
--      \\       * 722 G.U.E. *       /|
--       \\                          /|
--        --------------------------|
-- "

-- zil: 2dungeon.zil:2100  <OBJECT STAMP>
ZG._declare("STAMP", function() return ZG._declare_object("STAMP", function() return {
    ["LOC"] = ZG.PURPLE_BOOK,
    ["SYNONYM"] = {"STAMP", "TREASURE"},
    ["ADJECTIVE"] = "FLATHEAD",
    ["DESC"] = "Flathead stamp",
    ["FLAGS"] = {"STAGGERED", "READBIT", "TAKEBIT", "BURNBIT"},
    ["LDESC"] = "There is a Flathead stamp here.",
    ["SIZE"] = 1,
    ["VALUE"] = 10,
    ["TEXT"] = "This three zorkmid stamp bears a portrait of Lord\nDimwit Flathead, \"Our Excessive Leader\".",
} end) end, true)

-- ;"|
-- ---v----v----v----v----v---|
-- !   !!!!!!!!!!     LORD   !|
-- > !!!!!       !   DIMWIT  <|
-- !  !!!!    ---!  FLATHEAD !|
-- !  !!!C    CC \\           !|
-- >   !!        _\\          <|
-- !    !!! (____!           !|
-- !     !!      !    Our    !|
-- >      !______! Excessive <|
-- !        /   \\   Leader   !|
-- !                         !|
-- >    G.U.E.       Three   <|
-- !   POSTAGE      Zorkmids !|
-- ---^----^----^----^----^---|
-- "

-- zil: 2dungeon.zil:2129  <OBJECT GREEN-BOOK>
ZG._declare("GREEN_BOOK", function() return ZG._declare_object("GREEN-BOOK", function() return {
    ["LOC"] = ZG.LIBRARY,
    ["SYNONYM"] = {"BOOK", "COVER", "BOOKS"},
    ["ADJECTIVE"] = {"HANDSOME", "GREEN", "LEATHER"},
    ["DESC"] = "green book",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "CONTBIT", "BURNBIT"},
    ["FDESC"] = "A handsome book, bound in green leather, sits in the center of the room.",
    ["CAPACITY"] = 2,
    ["SIZE"] = 10,
    ["TEXT"] = "This book is written in a tongue with which I am unfamiliar.",
    ["ACTION"] = ZG.RANDOM_BOOK,
} end) end, true)

-- zil: 2dungeon.zil:2142  <OBJECT BLUE-BOOK>
ZG._declare("BLUE_BOOK", function() return ZG._declare_object("BLUE-BOOK", function() return {
    ["LOC"] = ZG.LIBRARY,
    ["SYNONYM"] = {"BOOK", "COVER", "BOOKS"},
    ["ADJECTIVE"] = "BLUE",
    ["DESC"] = "blue book",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "CONTBIT", "BURNBIT"},
    ["FDESC"] = "Worn and battered in one corner of the room is a blue book.",
    ["CAPACITY"] = 2,
    ["SIZE"] = 10,
    ["TEXT"] = "This book is written in a tongue with which I am unfamiliar.",
    ["ACTION"] = ZG.RANDOM_BOOK,
} end) end, true)

-- zil: 2dungeon.zil:2154  <OBJECT WHITE-BOOK>
ZG._declare("WHITE_BOOK", function() return ZG._declare_object("WHITE-BOOK", function() return {
    ["LOC"] = ZG.LIBRARY,
    ["SYNONYM"] = {"BOOK", "COVER", "BOOKS"},
    ["ADJECTIVE"] = {"WHITE", "GLOSSY"},
    ["DESC"] = "white book",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "CONTBIT", "BURNBIT"},
    ["FDESC"] = "Right beside the purple book sits a white one.",
    ["CAPACITY"] = 2,
    ["SIZE"] = 5,
    ["TEXT"] = "It is written in an unfamiliar tongue and details the use of various\nmagical objects, chiefly the so-called \"magic wand\". Apparently these\ndevices work by pointing them at the object to be ensorcelled, and then\nchanting the appropriate magic words. (It's truly amazing how credulous\nthese ancients were, isn't it?)",
    ["ACTION"] = ZG.RANDOM_BOOK,
} end) end, true)

-- zil: 2dungeon.zil:2172  <OBJECT PURPLE-BOOK>
ZG._declare("PURPLE_BOOK", function() return ZG._declare_object("PURPLE-BOOK", function() return {
    ["LOC"] = ZG.LIBRARY,
    ["SYNONYM"] = {"BOOK", "BOOKS"},
    ["ADJECTIVE"] = "PURPLE",
    ["DESC"] = "purple book",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "CONTBIT", "SEARCHBIT", "BURNBIT"},
    ["LDESC"] = "Lying in the dust, and covered with mold, is a purple book.",
    ["CAPACITY"] = 2,
    ["SIZE"] = 10,
    ["ACTION"] = ZG.PURPLE_BOOK_FCN,
    ["TEXT"] = "This book is written in a tongue with which I am unfamiliar. Assuming that\none can indeed tell a book by its cover, it is likely filled with purple prose,\nthe like of which is rarely seen outside the Great Underground Empire.",
} end) end, true)

-- zil: 2dungeon.zil:2188  <OBJECT RECEPTACLE>
ZG._declare("RECEPTACLE", function() return ZG._declare_object("RECEPTACLE", function() return {
    ["LOC"] = ZG.BALLOON,
    ["SYNONYM"] = "RECEPTACLE",
    ["ADJECTIVE"] = "METAL",
    ["DESC"] = "receptacle",
    ["FLAGS"] = {"CONTBIT", "SEARCHBIT", "NDESCBIT"},
    ["ACTION"] = ZG.BCONTENTS,
    ["CAPACITY"] = 6,
} end) end, true)

-- zil: 2dungeon.zil:2197  <OBJECT ROBOT>
ZG._declare("ROBOT", function() return ZG._declare_object("ROBOT", function() return {
    ["LOC"] = ZG.MAGNET_ROOM,
    ["SYNONYM"] = {"ROBOT", "R2D2", "C3PO", "ROBBY"},
    ["DESC"] = "robot",
    ["FLAGS"] = {"ACTORBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.ROBOT_FCN,
    ["LDESC"] = "There is a robot here.",
} end) end, true)

-- zil: 2dungeon.zil:2205  <OBJECT RUBY>
ZG._declare("RUBY", function() return ZG._declare_object("RUBY", function() return {
    ["LOC"] = ZG.LAVA_ROOM,
    ["SYNONYM"] = {"RUBY", "TREASURE"},
    ["ADJECTIVE"] = "MOBY",
    ["DESC"] = "ruby",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT"},
    ["FDESC"] = "On the floor lies a moby ruby.",
    ["LDESC"] = "There is a moby ruby lying here.",
    ["VALUE"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:2215  <OBJECT IRON-BOX>
ZG._declare("IRON_BOX", function() return ZG._declare_object("IRON-BOX", function() return {
    ["LOC"] = ZG.CAROUSEL_ROOM,
    ["SYNONYM"] = "BOX",
    ["ADJECTIVE"] = {"STEEL", "DENTED"},
    ["DESC"] = "steel box",
    ["FLAGS"] = {"CONTBIT", "TAKEBIT", "INVISIBLE"},
    ["LDESC"] = "There is a dented steel box here.",
    ["CAPACITY"] = 20,
    ["SIZE"] = 40,
} end) end, true)

-- zil: 2dungeon.zil:2225  <OBJECT CAGE>
ZG._declare("CAGE", function() return ZG._declare_object("CAGE", function() return {
    ["LOC"] = ZG.CAGE_ROOM,
    ["FLAGS"] = "INVISIBLE",
    ["SYNONYM"] = "CAGE",
    ["ADJECTIVE"] = {"STEEL", "SOLID"},
    ["DESC"] = "solid steel cage",
    ["LDESC"] = "There is a solid steel cage in the middle of the room.",
} end) end, true)

-- zil: 2dungeon.zil:2233  <OBJECT CANDY>
ZG._declare("CANDY", function() return ZG._declare_object("CANDY", function() return {
    ["LOC"] = ZG.POOL_ROOM,
    ["SYNONYM"] = {"PACKAGE", "CANDY", "TREASURE", "GRASSHOPPERS"},
    ["ADJECTIVE"] = {"CANDIED", "RARE"},
    ["DESC"] = "package of candy",
    ["FLAGS"] = {"STAGGERED", "FOODBIT", "TAKEBIT", "INVISIBLE", "READBIT"},
    ["LDESC"] = "There is a package of candied goodies here.",
    ["ACTION"] = ZG.CANDY_FCN,
    ["SIZE"] = 8,
    ["VALUE"] = 15,
} end) end, true)

-- zil: 2dungeon.zil:2244  <OBJECT TOP-ETCHINGS>
ZG._declare("TOP_ETCHINGS", function() return ZG._declare_object("TOP-ETCHINGS", function() return {
    ["LOC"] = ZG.WELL_TOP,
    ["SYNONYM"] = {"ETCHINGS", "WALL"},
    ["DESC"] = "wall with etchings",
    ["FLAGS"] = {"READBIT", "NDESCBIT"},
    ["ACTION"] = ZG.TOP_ETCHINGS_F,
} end) end, true)

-- zil: 2dungeon.zil:2251  <OBJECT BOTTOM-ETCHINGS>
ZG._declare("BOTTOM_ETCHINGS", function() return ZG._declare_object("BOTTOM-ETCHINGS", function() return {
    ["LOC"] = ZG.WELL_BOTTOM,
    ["SYNONYM"] = {"ETCHINGS", "WALL"},
    ["DESC"] = "wall with etchings",
    ["FLAGS"] = {"READBIT", "NDESCBIT"},
    ["ACTION"] = ZG.BOTTOM_ETCHINGS_F,
} end) end, true)

-- zil: 2dungeon.zil:2258  <OBJECT FUSE>
ZG._declare("FUSE", function() return ZG._declare_object("FUSE", function() return {
    ["LOC"] = ZG.COBWEBBY_CORRIDOR,
    ["SYNONYM"] = {"FUSE", "STRING", "COIL"},
    ["ADJECTIVE"] = {"BLACK", "THIN"},
    ["DESC"] = "black string",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT"},
    ["ACTION"] = ZG.FUSE_FCN,
    ["LDESC"] = "There is a coil of black, braided string here.",
    ["SIZE"] = 1,
} end) end, true)

-- zil: 2dungeon.zil:2268  <OBJECT BUCKET>
ZG._declare("BUCKET", function() return ZG._declare_object("BUCKET", function() return {
    ["LOC"] = ZG.WELL_BOTTOM,
    ["SYNONYM"] = "BUCKET",
    ["ADJECTIVE"] = "WOODEN",
    ["DESC"] = "wooden bucket",
    ["FLAGS"] = {"VEHBIT", "OPENBIT", "CONTBIT"},
    ["ACTION"] = ZG.BUCKET_FCN,
    ["CONTFCN"] = ZG.BUCKET_CONT,
    ["LDESC"] = "There is a wooden bucket here, 3 feet in diameter and 3 feet high.",
    ["CAPACITY"] = 100,
    ["SIZE"] = 100,
    ["VTYPE"] = 0,
} end) end, true)

-- zil: 2dungeon.zil:2282  <OBJECT POSTS>
ZG._declare("POSTS", function() return ZG._declare_object("POSTS", function() return {
    ["LOC"] = ZG.POSTS_ROOM,
    ["SYNONYM"] = {"POSTS", "POST"},
    ["ADJECTIVE"] = "WOODEN",
    ["FLAGS"] = "NDESCBIT",
    ["DESC"] = "group of wooden posts",
} end) end, true)

-- zil: 2dungeon.zil:2291  <OBJECT BILLS>
ZG._declare("BILLS", function() return ZG._declare_object("BILLS", function() return {
    ["LOC"] = ZG.VAULT,
    ["SYNONYM"] = {"BILLS", "STACK", "MONEY", "TREASURE"},
    ["ADJECTIVE"] = {"NEAT", "MANY", "ZORKMID"},
    ["DESC"] = "stack of zorkmid bills",
    ["FLAGS"] = {"STAGGERED", "READBIT", "TAKEBIT", "BURNBIT"},
    ["ACTION"] = ZG.BILLS_OBJECT,
    ["LDESC"] = "200 neatly stacked zorkmid bills are here.",
    ["FDESC"] = "On the floor sit 200 neatly stacked zorkmid bills.",
    ["SIZE"] = 10,
    ["VALUE"] = 25,
    ["TEXT"] = "Each bill is worth 100 zorkmids, and bears the legend\n\"In Frobs We Trust\".",
} end) end, true)

-- ;"
-- ______________________________________________________________
-- + 1  0   0          GREAT UNDERGROUND EMPIRE         1  0   0 +|
-- + 1 0 0 0 0					     1 0 0 0 0+|
-- + 1 0 0 0 0					     1 0 0 0 0+|
-- + 1  0   0		    DIMWIT		     1  0   0 +|
-- +	               ++++++++++++++++	  		      +|
-- +		       ++   __  __   ++		   B30332744D +|
-- +		       ++  -OO  OO-  ++	  		      +|
-- +	IN  FROBS      \\++    >>    ++/	    WE  TRUST         +|
-- +		        ++  ______  ++	       		      +|
-- + B30332744D	         +  ------  +	       		      +|
-- +                        \\\\________//	       		      +|
-- + 1  0   0    Series	   FLATHEAD	LD Flathead  1  0   0 +|
-- + 1 0 0 0 0   719GUE	   		 Treasurer   1 0 0 0 0+|
-- + 1 0 0 0 0 					     1 0 0 0 0+|
-- + 1  0   0	  One Hundred Royal Zorkmids	     1  0   0 +|
-- +_____________________________________________________________+|
--
-- "

-- zil: 2dungeon.zil:2328  <OBJECT PORTRAIT>
ZG._declare("PORTRAIT", function() return ZG._declare_object("PORTRAIT", function() return {
    ["LOC"] = ZG.OFFICE,
    ["SYNONYM"] = {"PORTRAIT", "PAINTING", "ART", "TREASURE"},
    ["ADJECTIVE"] = "FLATHEAD",
    ["DESC"] = "portrait of J. Pierpont Flathead",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT", "BURNBIT"},
    ["LDESC"] = "The portrait of J. Pierpont Flathead is here.",
    ["FDESC"] = "A portrait of J. Pierpont Flathead hangs on the wall.",
    ["SIZE"] = 25,
    ["VALUE"] = 20,
} end) end, true)

-- ;"|
--         !!!!!!!!!!!!!!|
--        !!   __  __   !!|
--        !!   $$  $$   !!|
--        \\!!    >>    !!/|
--         !!  ______  !!|
--          !  -//--   !|
--          \\\\_//_____//|
--         ___//!  !|
--         \\_// !  !|
--   __________//  \\\\__________|
--  / $ /       *ZZ*       \\ $ \\|
-- |
--      J.  PIERPONT  FLATHEAD|
--           CHAIRMAN|
-- "

-- zil: 2dungeon.zil:2358  <OBJECT BANK-BROCHURE>
ZG._declare("BANK_BROCHURE", function() return ZG._declare_object("BANK-BROCHURE", function() return {
    ["LOC"] = ZG.DEPOSITORY,
    ["SYNONYM"] = {"BROCHURE", "PAPER", "PIECE"},
    ["ADJECTIVE"] = {"BANK", "SMALL", "WORN"},
    ["DESC"] = "bank brochure",
    ["FDESC"] = "On the ground is a small, worn piece of paper.",
    ["FLAGS"] = {"READBIT", "TAKEBIT", "BURNBIT"},
    ["SIZE"] = 2,
    ["TEXT"] = "The paper is barely readable. You can only make out \"... valuables\nare completely safe ... advanced\nmagic technology ... impossible to take valuables from the depository\n... either teller's ... Many customers faint ... teller pops in ...\nseems to walk through ... walls ...\"",
} end) end, true)

-- zil: 2dungeon.zil:2373  <OBJECT CUBE>
ZG._declare("CUBE", function() return ZG._declare_object("CUBE", function() return {
    ["LOC"] = ZG.DEPOSITORY,
    ["SYNONYM"] = {"VAULT", "CUBE", "LETTER"},
    ["ADJECTIVE"] = {"STONE", "LARGE"},
    ["DESC"] = "large stone cube",
    ["FLAGS"] = {"READBIT", "NDESCBIT"},
    ["ACTION"] = ZG.CUBE_F,
} end) end, true)

-- zil: 2dungeon.zil:2381  <OBJECT CURTAIN>
ZG._declare("CURTAIN", function() return ZG._declare_object("CURTAIN", function() return {
    ["LOC"] = ZG.DEPOSITORY,
    ["SYNONYM"] = {"CURTAIN", "LIGHT"},
    ["ADJECTIVE"] = "SHIMMERING",
    ["DESC"] = "shimmering curtain of light",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.SCOL_OBJECT,
} end) end, true)

-- zil: 2dungeon.zil:2389  <OBJECT GNOME-OF-ZURICH>
ZG._declare("GNOME_OF_ZURICH", function() return ZG._declare_object("GNOME-OF-ZURICH", function() return {
    ["SYNONYM"] = {"GNOME", "ZURICH"},
    ["ADJECTIVE"] = "ZURICH",
    ["DESC"] = "Gnome of Zurich",
    ["FLAGS"] = {"ACTORBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.ZGNOME_FCN,
    ["LDESC"] = "There is a Gnome of Zurich here.",
} end) end, true)

-- zil: 2dungeon.zil:2397  <OBJECT DEPOSIT-BOX>
ZG._declare("DEPOSIT_BOX", function() return ZG._declare_object("DEPOSIT-BOX", function() return {
    ["LOC"] = ZG.GNOME_OF_ZURICH,
    ["SYNONYM"] = "BOX",
    ["ADJECTIVE"] = {"DEPOSIT", "SAFETY"},
    ["DESC"] = "safety deposit box",
    ["FLAGS"] = {"NDESCBIT", "TAKEBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.BOX_F,
} end) end, true)

-- ;"PALANTIR SECTION"

-- zil: 2dungeon.zil:2407  <OBJECT PDOOR>
ZG._declare("PDOOR", function() return ZG._declare_object("PDOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"WOODEN", "OAK"},
    ["DESC"] = "door made of oak",
    ["FLAGS"] = {"DOORBIT", "CONTBIT"},
    ["ACTION"] = ZG.PDOOR_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2415  <OBJECT PWINDOW>
ZG._declare("PWINDOW", function() return ZG._declare_object("PWINDOW", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "WINDOW",
    ["ADJECTIVE"] = "BARRED",
    ["DESC"] = "barred window",
    ["FLAGS"] = "DOORBIT",
    ["ACTION"] = ZG.PWINDOW_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2423  <OBJECT LID-1>
ZG._declare("LID_1", function() return ZG._declare_object("LID-1", function() return {
    ["LOC"] = ZG.TINY_ROOM,
    ["SYNONYM"] = "LID",
    ["ADJECTIVE"] = "METAL",
    ["DESC"] = "metal lid",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT"},
    ["ACTION"] = ZG.PLID_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2431  <OBJECT LID-2>
ZG._declare("LID_2", function() return ZG._declare_object("LID-2", function() return {
    ["LOC"] = ZG.DREARY_ROOM,
    ["SYNONYM"] = "LID",
    ["ADJECTIVE"] = "METAL",
    ["DESC"] = "metal lid",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.PLID_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2439  <OBJECT PTABLE>
ZG._declare("PTABLE", function() return ZG._declare_object("PTABLE", function() return {
    ["LOC"] = ZG.DREARY_ROOM,
    ["SYNONYM"] = "TABLE",
    ["ADJECTIVE"] = {"DUSTY", "WOODEN"},
    ["DESC"] = "table",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT", "SURFACEBIT", "OPENBIT"},
    ["CAPACITY"] = 40,
} end) end, true)

-- zil: 2dungeon.zil:2447  <OBJECT PCRACK>
ZG._declare("PCRACK", function() return ZG._declare_object("PCRACK", function() return {
    ["LOC"] = ZG.DREARY_ROOM,
    ["SYNONYM"] = "CRACK",
    ["ADJECTIVE"] = "NARROW",
    ["DESC"] = "narrow crack",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:2454  <OBJECT KEYHOLE-1>
ZG._declare("KEYHOLE_1", function() return ZG._declare_object("KEYHOLE-1", function() return {
    ["LOC"] = ZG.TINY_ROOM,
    ["SYNONYM"] = {"KEYHOLE", "HOLE"},
    ["DESC"] = "keyhole",
    ["FLAGS"] = {"NDESCBIT", "OPENBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.PKH_FCN,
    ["CAPACITY"] = 2,
} end) end, true)

-- zil: 2dungeon.zil:2462  <OBJECT KEYHOLE-2>
ZG._declare("KEYHOLE_2", function() return ZG._declare_object("KEYHOLE-2", function() return {
    ["LOC"] = ZG.DREARY_ROOM,
    ["SYNONYM"] = {"KEYHOLE", "HOLE"},
    ["DESC"] = "keyhole",
    ["FLAGS"] = {"NDESCBIT", "OPENBIT", "SEARCHBIT"},
    ["ACTION"] = ZG.PKH_FCN,
    ["CAPACITY"] = 2,
} end) end, true)

-- zil: 2dungeon.zil:2470  <OBJECT LETTER-OPENER>
ZG._declare("LETTER_OPENER", function() return ZG._declare_object("LETTER-OPENER", function() return {
    ["LOC"] = ZG.GAZEBO_TABLE,
    ["SYNONYM"] = "OPENER",
    ["ADJECTIVE"] = "LETTER",
    ["DESC"] = "letter opener",
    ["SIZE"] = 2,
    ["FLAGS"] = {"TAKEBIT", "TOOLBIT"},
} end) end, true)

-- zil: 2dungeon.zil:2478  <OBJECT KEY>
ZG._declare("KEY", function() return ZG._declare_object("KEY", function() return {
    ["LOC"] = ZG.KEYHOLE_2,
    ["SYNONYM"] = "KEY",
    ["ADJECTIVE"] = {"IRON", "RUSTY"},
    ["DESC"] = "rusty iron key",
    ["FLAGS"] = {"TAKEBIT", "NDESCBIT", "TURNBIT", "TOOLBIT"},
    ["ACTION"] = ZG.PKEY_FCN,
    ["SIZE"] = 2,
} end) end, true)

-- zil: 2dungeon.zil:2487  <OBJECT PALANTIR-2>
ZG._declare("PALANTIR_2", function() return ZG._declare_object("PALANTIR-2", function() return {
    ["LOC"] = ZG.DREARY_ROOM,
    ["SYNONYM"] = {"PALANTIR", "SPHERE"},
    ["ADJECTIVE"] = {"CRYSTAL", "BLUE"},
    ["DESC"] = "blue crystal sphere",
    ["FLAGS"] = {"STAGGERED", "TAKEBIT", "TRANSBIT"},
    ["ACTION"] = ZG.PALANTIR,
    ["VALUE"] = 20,
    ["FDESC"] = "In the center of the table sits a blue crystal sphere.",
} end) end, true)

-- zil: 2dungeon.zil:2497  <OBJECT GAZEBO>
ZG._declare("GAZEBO", function() return ZG._declare_object("GAZEBO", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"GAZEBO", "STRUCTURE"},
    ["ADJECTIVE"] = "WOODEN",
    ["DESC"] = "gazebo",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.GAZEBO_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2505  <OBJECT GAZEBO-TABLE>
ZG._declare("GAZEBO_TABLE", function() return ZG._declare_object("GAZEBO-TABLE", function() return {
    ["LOC"] = ZG.GAZEBO_ROOM,
    ["SYNONYM"] = "TABLE",
    ["ADJECTIVE"] = "TEA",
    ["DESC"] = "table",
    ["FLAGS"] = {"NDESCBIT", "SURFACEBIT", "CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 100,
} end) end, true)

-- zil: 2dungeon.zil:2513  <OBJECT NEWSPAPER>
ZG._declare("NEWSPAPER", function() return ZG._declare_object("NEWSPAPER", function() return {
    ["LOC"] = ZG.GAZEBO_TABLE,
    ["SYNONYM"] = {"PAPER", "NEWSPAPER"},
    ["ADJECTIVE"] = {"NEWS", "NEWSPAPER"},
    ["DESC"] = "newspaper",
    ["FLAGS"] = {"TAKEBIT", "BURNBIT", "READBIT"},
    ["TEXT"] = "** U.S. News and Dungeon Report **\n\nFAMED ADVENTURER TO EXPLORE GREAT UNDERGROUND EMPIRE\n\nOur correspondents report that a world-famous and battle-hardened\nadventurer has been seen in the vicinity of the Great Underground\nEmpire. Local grues have been reported sharpening their (slavering)\nfangs....\n\n\"Zork II: The Wizard of Frobozz\" was written by Dave Lebling and Marc\nBlank, and is (c) Copyright 1981, 1982, 1983 by Infocom, Inc.",
} end) end, true)

-- zil: 2dungeon.zil:2532  <OBJECT PLACE-MAT>
ZG._declare("PLACE_MAT", function() return ZG._declare_object("PLACE-MAT", function() return {
    ["LOC"] = ZG.GAZEBO_TABLE,
    ["SYNONYM"] = {"MAT", "PLACEM"},
    ["ADJECTIVE"] = "PLACE",
    ["DESC"] = "place mat",
    ["FLAGS"] = {"TAKEBIT", "SURFACEBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.PLACE_MAT_FCN,
    ["SIZE"] = 12,
    ["CAPACITY"] = 20,
} end) end, true)

-- zil: 2dungeon.zil:2542  <OBJECT TEAPOT>
ZG._declare("TEAPOT", function() return ZG._declare_object("TEAPOT", function() return {
    ["LOC"] = ZG.GAZEBO_TABLE,
    ["SYNONYM"] = {"TEAPOT", "POT"},
    ["ADJECTIVE"] = {"CHINA", "TEA"},
    ["DESC"] = "china teapot",
    ["FLAGS"] = {"TAKEBIT", "TRANSBIT", "CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 4,
    ["ACTION"] = ZG.TEAPOT_F,
} end) end, true)

-- zil: 2dungeon.zil:2551  <ROUTINE TEAPOT-F ()>
ZG.actions:register("TEAPOT_F", function()

    if ZG._T(ZG.VERB_p("CLOSE")) then
        do return ZG.TELL("The teapot has no lid.", ZG._TK.CR) end
    else
        do return false end
    end

end, "TEAPOT-F")

ZG.TEAPOT_F = ZG.actions:get("TEAPOT_F")

-- zil: 2dungeon.zil:2555  <OBJECT WATER>
ZG._declare("WATER", function() return ZG._declare_object("WATER", function() return {
    ["SYNONYM"] = {"WATER", "QUANTITY", "LIQUID", "H2O"},
    ["DESC"] = "quantity of water",
    ["FLAGS"] = {"TAKEBIT", "DRINKBIT"},
    ["ACTION"] = ZG.WATER_FCN,
    ["LDESC"] = "There is some water here.",
    ["SIZE"] = 4,
} end) end, true)

-- zil: 2dungeon.zil:2563  <OBJECT SALTY-WATER>
ZG._declare("SALTY_WATER", function() return ZG._declare_object("SALTY-WATER", function() return {
    ["SYNONYM"] = {"WATER", "QUANTITY", "LIQUID", "H2O"},
    ["DESC"] = "quantity of salty water",
    ["FLAGS"] = {"TAKEBIT", "DRINKBIT"},
    ["ACTION"] = ZG.WATER_FCN,
    ["LDESC"] = "There is some water here.",
    ["SIZE"] = 4,
} end) end, true)

-- zil: 2dungeon.zil:2571  <OBJECT GOLD-KEY>
ZG._declare("GOLD_KEY", function() return ZG._declare_object("GOLD-KEY", function() return {
    ["LOC"] = ZG.UNICORN,
    ["SYNONYM"] = {"KEY", "TREASURE"},
    ["ADJECTIVE"] = {"DELICATE", "GOLD"},
    ["DESC"] = "delicate gold key",
    ["FLAGS"] = {"STAGGERED", "NDESCBIT", "TAKEBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.UNICORN_FCN,
    ["VALUE"] = 15,
    ["SIZE"] = 3,
} end) end, true)

-- zil: 2dungeon.zil:2581  <OBJECT RIBBON>
ZG._declare("RIBBON", function() return ZG._declare_object("RIBBON", function() return {
    ["LOC"] = ZG.UNICORN,
    ["SYNONYM"] = "RIBBON",
    ["ADJECTIVE"] = {"VELVET", "SATIN"},
    ["DESC"] = "ribbon",
    ["ACTION"] = ZG.UNICORN_FCN,
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 2dungeon.zil:2589  <OBJECT ROSE>
ZG._declare("ROSE", function() return ZG._declare_object("ROSE", function() return {
    ["SYNONYM"] = "ROSE",
    ["ADJECTIVE"] = {"BEAUTIFUL", "RED", "PERFECT"},
    ["DESC"] = "perfect rose",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 1,
    ["ACTION"] = ZG.ROSE_F,
} end) end, true)

-- zil: 2dungeon.zil:2597  <ROUTINE ROSE-F ()>
ZG.actions:register("ROSE_F", function()

    if ZG._T(ZG.VERB_p("SMELL")) then
        do return ZG.TELL("Unlike your efforts here, it comes out smelling like a rose.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("A rose is a rose is a rose....", ZG._TK.CR) end
    else
        do return false end
    end

end, "ROSE-F")

ZG.ROSE_F = ZG.actions:get("ROSE_F")

-- zil: 2dungeon.zil:2604  <OBJECT GENIE>
ZG._declare("GENIE", function() return ZG._declare_object("GENIE", function() return {
    ["SYNONYM"] = {"DEVIL", "DEMON", "GENIE", "DJINN"},
    ["DESC"] = "demon",
    ["FLAGS"] = {"ACTORBIT", "INVISIBLE"},
    ["ACTION"] = ZG.GENIE_FCN,
    ["LDESC"] = "There is a demon floating in midair here.",
} end) end, true)

-- zil: 2dungeon.zil:2611  <OBJECT WIZARD>
ZG._declare("WIZARD", function() return ZG._declare_object("WIZARD", function() return {
    ["SYNONYM"] = {"WIZARD", "MAGICIAN", "SORCEROR", "MAN"},
    ["ADJECTIVE"] = {"STRANGE", "LITTLE", "FROBOZZ", "OLD"},
    ["DESC"] = "Wizard of Frobozz",
    ["LDESC"] = "The Wizard of Frobozz is here, eyeing you warily.",
    ["FLAGS"] = {"ACTORBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.WIZARD_FCN,
} end) end, true)

-- zil: 2dungeon.zil:2620  <OBJECT WAND>
ZG._declare("WAND", function() return ZG._declare_object("WAND", function() return {
    ["LOC"] = ZG.WIZARD,
    ["SYNONYM"] = "WAND",
    ["ADJECTIVE"] = "MAGIC",
    ["DESC"] = "Wizard's magic wand",
    ["FLAGS"] = {"STAGGERED", "NDESCBIT", "TAKEBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.WAND_FCN,
    ["VALUE"] = 30,
} end) end, true)

-- zil: 2dungeon.zil:2629  <OBJECT SWORD>
ZG._declare("SWORD", function() return ZG._declare_object("SWORD", function() return {
    ["LOC"] = ZG.INSIDE_BARROW,
    ["SYNONYM"] = {"SWORD", "ORCRIST", "GLAMDRING", "BLADE"},
    ["ADJECTIVE"] = {"ELVISH", "OLD", "ANTIQUE"},
    ["DESC"] = "elvish sword",
    ["FLAGS"] = {"TAKEBIT", "WEAPONBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.SWORD_FCN,
    ["LDESC"] = "An Elvish sword of great antiquity is here.",
    ["FDESC"] = "A sword of Elvish workmanship is on the ground.",
    ["SIZE"] = 30,
} end) end, true)

-- zil: 2dungeon.zil:2640  <OBJECT REPELLENT>
ZG._declare("REPELLENT", function() return ZG._declare_object("REPELLENT", function() return {
    ["LOC"] = ZG.ROOM_8,
    ["SYNONYM"] = {"REPELLENT", "CAN"},
    ["ADJECTIVE"] = {"GRUE", "MAGIC"},
    ["DESC"] = "Frobozz Magic Grue Repellent",
    ["FLAGS"] = {"TAKEBIT", "READBIT"},
    ["ACTION"] = ZG.REPELLENT_FCN,
    ["FDESC"] = "A spray can is in the corner. In large type is the legend \"Frobozz Magic\nGrue Repellent\".",
    ["TEXT"] = "!!! FROBOZZ MAGIC GRUE REPELLENT !!!\n\nInstructions for use: Apply liberally to creature to be protected.\nDuration of effect is unpredictable. Use only in place of death!\n\n(No warranty expressed or implied)",
} end) end, true)

-- zil: 2dungeon.zil:2658  <ROOM DEAD-PALANTIR-1>
ZG._declare("DEAD_PALANTIR_1", function() return ZG._declare_object("DEAD-PALANTIR-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Room of Red Mist",
    ["WEST"] = {"TO", ZG.DEAD_PALANTIR_2},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.DEAD_PALANTIR,
    ["GLOBAL"] = ZG.GLOBAL_PALANTIR,
} end) end, true)

-- zil: 2dungeon.zil:2667  <ROOM DEAD-PALANTIR-2>
ZG._declare("DEAD_PALANTIR_2", function() return ZG._declare_object("DEAD-PALANTIR-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Room of Blue Mist",
    ["WEST"] = {"TO", ZG.DEAD_PALANTIR_3},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.DEAD_PALANTIR,
    ["GLOBAL"] = ZG.GLOBAL_PALANTIR,
} end) end, true)

-- zil: 2dungeon.zil:2676  <ROOM DEAD-PALANTIR-3>
ZG._declare("DEAD_PALANTIR_3", function() return ZG._declare_object("DEAD-PALANTIR-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = " ",
    ["DESC"] = "Room of White Mist",
    ["WEST"] = {"TO", ZG.DEAD_PALANTIR_4},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.DEAD_PALANTIR,
    ["GLOBAL"] = ZG.GLOBAL_PALANTIR,
} end) end, true)

-- zil: 2dungeon.zil:2685  <ROOM DEAD-PALANTIR-4>
ZG._declare("DEAD_PALANTIR_4", function() return ZG._declare_object("DEAD-PALANTIR-4", function() return {
    ["LDESC"] = " ",
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Room of Black Mist",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.DEAD_PALANTIR,
} end) end, true)

-- zil: 2dungeon.zil:2692  <OBJECT GLOBAL-PALANTIR>
ZG._declare("GLOBAL_PALANTIR", function() return ZG._declare_object("GLOBAL-PALANTIR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "SPHERE",
    ["ADJECTIVE"] = {"RED", "BLUE", "WHITE", "CRYSTAL"},
    ["DESC"] = "sphere",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.GLOBAL_PALANTIRS,
} end) end, true)

-- zil: 2dungeon.zil:2700  <OBJECT FOOTPAD>
ZG._declare("FOOTPAD", function() return ZG._declare_object("FOOTPAD", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "FOOTPAD",
    ["DESC"] = "footpad",
    ["ACTION"] = ZG.FOOTPAD_F,
} end) end, true)

-- zil: 2dungeon.zil:2706  <ROUTINE FOOTPAD-F ()>
ZG.actions:register("FOOTPAD_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("A footpad is a thief.", ZG._TK.CR) end
    else
        do return false end
    end

end, "FOOTPAD-F")

ZG.FOOTPAD_F = ZG.actions:get("FOOTPAD_F")

-- zil: 2dungeon.zil:2710  <OBJECT COMPASS>
ZG._declare("COMPASS", function() return ZG._declare_object("COMPASS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["DESC"] = "compass",
    ["SYNONYM"] = "COMPASS",
    ["ACTION"] = ZG.COMPASS_F,
} end) end, true)

-- zil: 2dungeon.zil:2716  <ROUTINE COMPASS-F ()>
ZG.actions:register("COMPASS_F", function()

    if ZG._T(ZG.VERB_p("FIND")) then
        do return ZG.TELL("It's on your person. And lucky for you, or you would become hopelessly\nlost.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DROP", "THROW", "OVERBOARD")) then
        do return ZG.TELL("You can't get rid of it. It is an extension of yourself.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("It's one of those gizmos with a needle and a card with the eight major\ncompass directions. Simple, but effective.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("READ")) then
        do return ZG.TELL("It doesn't make very interesting reading - just the compass directions.", ZG._TK.CR) end
    else
        do return ZG.TELL("You can't do that. And don't bother to ask why.", ZG._TK.CR) end
    end

end, "COMPASS-F")

ZG.COMPASS_F = ZG.actions:get("COMPASS_F")
