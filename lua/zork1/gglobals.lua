-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: gglobals.zil:7  <OBJECT GLOBAL-OBJECTS>
ZG._declare("GLOBAL_OBJECTS", function() return ZG._declare_object("GLOBAL-OBJECTS", function() return {
    ["FLAGS"] = {"RMUNGBIT", "INVISIBLE", "TOUCHBIT", "SURFACEBIT", "TRYTAKEBIT", "OPENBIT", "SEARCHBIT", "TRANSBIT", "ONBIT", "RLANDBIT", "FIGHTBIT", "STAGGERED", "WEARBIT"},
} end) end, true)

-- zil: gglobals.zil:12  <OBJECT LOCAL-GLOBALS>
ZG._declare("LOCAL_GLOBALS", function() return ZG._declare_object("LOCAL-GLOBALS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "ZZMGCK",
    ["DESCFCN"] = ZG.PATH_OBJECT,
    ["GLOBAL"] = ZG.GLOBAL_OBJECTS,
    ["ADVFCN"] = 0,
    ["FDESC"] = "F",
    ["LDESC"] = "F",
    ["PSEUDO"] = {"FOOBAR", ZG.V_WALK},
    ["CONTFCN"] = 0,
    ["VTYPE"] = 1,
    ["SIZE"] = 0,
    ["CAPACITY"] = 0,
} end) end, true)

-- ;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

-- zil: gglobals.zil:28  <OBJECT ROOMS>
ZG._declare("ROOMS", function() return ZG._declare_object("ROOMS") end, true)

-- zil: gglobals.zil:31  <OBJECT INTNUM>
ZG._declare("INTNUM", function() return ZG._declare_object("INTNUM", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "INTNUM",
    ["FLAGS"] = "TOOLBIT",
    ["DESC"] = "number",
} end) end, true)

-- zil: gglobals.zil:37  <OBJECT PSEUDO-OBJECT>
ZG._declare("PSEUDO_OBJECT", function() return ZG._declare_object("PSEUDO-OBJECT", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "pseudo",
    ["ACTION"] = ZG.CRETIN_FCN,
} end) end, true)

-- zil: gglobals.zil:42  <OBJECT IT>
ZG._declare("IT", function() return ZG._declare_object("IT", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"IT", "THEM", "HER", "HIM"},
    ["DESC"] = "random object",
    ["FLAGS"] = {"NDESCBIT", "TOUCHBIT"},
} end) end, true)

-- zil: gglobals.zil:48  <OBJECT NOT-HERE-OBJECT>
ZG._declare("NOT_HERE_OBJECT", function() return ZG._declare_object("NOT-HERE-OBJECT", function() return {
    ["DESC"] = "such thing",
    ["ACTION"] = ZG.NOT_HERE_OBJECT_F,
} end) end, true)

-- zil: gglobals.zil:52  <ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ)>
ZG.actions:register("NOT_HERE_OBJECT_F", function()

    local TBL = 0
    local PRSO_p_l = true
    local OBJ = 0
    -- ;"This COND is game independent (except the TELL)"
    if (ZG.EQ(ZG.PRSO, ZG.NOT_HERE_OBJECT) and ZG.EQ(ZG.PRSI, ZG.NOT_HERE_OBJECT)) then
        do local _ = ZG.TELL("Those things aren't here!", ZG._TK.CR) end
        do return true end
    elseif ZG.EQ(ZG.PRSO, ZG.NOT_HERE_OBJECT) then
        TBL = ZG.P_PRSO
    else
        TBL = ZG.P_PRSI
        PRSO_p_l = false
    end
    -- ;"Here is the default 'cant see any' printer"
    ZG._set("P_CONT", false)
    ZG._set("QUOTE_FLAG", false)
    if ZG.EQ(ZG.WINNER, ZG.PLAYER) then
        do local _ = ZG.TELL("You can't see any ") end
        do local _ = ZG.NOT_HERE_PRINT(PRSO_p_l) end
        do local _ = ZG.TELL(" here!", ZG._TK.CR) end
    else
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.WINNER, " seems confused. \"I don't see any ") end
        do local _ = ZG.NOT_HERE_PRINT(PRSO_p_l) end
        do local _ = ZG.TELL(" here!\"", ZG._TK.CR) end
    end
    do return true end

end, "NOT-HERE-OBJECT-F")

ZG.NOT_HERE_OBJECT_F = ZG.actions:get("NOT_HERE_OBJECT_F")

-- zil: gglobals.zil:76  <ROUTINE NOT-HERE-PRINT (PRSO?)>
ZG.actions:register("NOT_HERE_PRINT", function(PRSO_p_l)

    if ZG._T(ZG.P_OFLAG) then
        if ZG._T(ZG.P_XADJ) then
            do local _ = ZG.PRINTB(ZG.P_XADJN) end
        end
        if ZG._T(ZG.P_XNAM) then
            do return ZG.PRINTB(ZG.P_XNAM) end
        else
            do return false end
        end
    elseif ZG._T(PRSO_p_l) then
        do return ZG.BUFFER_PRINT(ZG.GET(ZG.P_ITBL, ZG.P_NC1), ZG.GET(ZG.P_ITBL, ZG.P_NC1L), false) end
    else
        do return ZG.BUFFER_PRINT(ZG.GET(ZG.P_ITBL, ZG.P_NC2), ZG.GET(ZG.P_ITBL, ZG.P_NC2L), false) end
    end

end, "NOT-HERE-PRINT")

ZG.NOT_HERE_PRINT = ZG.actions:get("NOT_HERE_PRINT")

-- zil: gglobals.zil:85  <ROUTINE NULL-F ("OPTIONAL" A1 A2)>
ZG.actions:register("NULL_F", function(A1, A2)

    do return false end

end, "NULL-F")

ZG.NULL_F = ZG.actions:get("NULL_F")

-- zil: gglobals.zil:92  <GLOBAL LOAD-MAX>
-- LOAD_MAX is declared in ZilGlobal.lua

-- zil: gglobals.zil:94  <GLOBAL LOAD-ALLOWED>
-- LOAD_ALLOWED is declared in ZilGlobal.lua

-- zil: gglobals.zil:96  <OBJECT BLESSINGS>
ZG._declare("BLESSINGS", function() return ZG._declare_object("BLESSINGS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"BLESSINGS", "GRACES"},
    ["DESC"] = "blessings",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: gglobals.zil:102  <OBJECT STAIRS>
ZG._declare("STAIRS", function() return ZG._declare_object("STAIRS", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = {"STAIRS", "STEPS", "STAIRCASE", "STAIRWAY"},
    ["ADJECTIVE"] = {"STONE", "DARK", "MARBLE", "FORBIDDING", "STEEP"},
    ["DESC"] = "stairs",
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
    ["ACTION"] = ZG.STAIRS_F,
} end) end, true)

-- zil: gglobals.zil:110  <ROUTINE STAIRS-F ()>
ZG.actions:register("STAIRS_F", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.TELL("You should say whether you want to go up or down.", ZG._TK.CR) end
    else
        do return false end
    end

end, "STAIRS-F")

ZG.STAIRS_F = ZG.actions:get("STAIRS_F")

-- zil: gglobals.zil:115  <OBJECT SAILOR>
ZG._declare("SAILOR", function() return ZG._declare_object("SAILOR", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"SAILOR", "FOOTPAD", "AVIATOR"},
    ["DESC"] = "sailor",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.SAILOR_FCN,
} end) end, true)

-- zil: gglobals.zil:122  <ROUTINE SAILOR-FCN ()>
ZG.actions:register("SAILOR_FCN", function()

    if ZG._T(ZG.VERB_p("TELL")) then
        ZG._set("P_CONT", false)
        ZG._set("QUOTE_FLAG", false)
        do return ZG.TELL("You can't talk to the sailor that way.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("There is no sailor to be seen.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("HELLO")) then
        ZG._set("HS", ZG.ADD(ZG.HS, 1))
        if ZG.ZERO_p(ZG.MOD(ZG.HS, 20)) then
            do return ZG.TELL("You seem to be repeating yourself.", ZG._TK.CR) end
        elseif ZG.ZERO_p(ZG.MOD(ZG.HS, 10)) then
            do return ZG.TELL("I think that phrase is getting a bit worn out.", ZG._TK.CR) end
        else
            do return ZG.TELL("Nothing happens here.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SAILOR-FCN")

ZG.SAILOR_FCN = ZG.actions:get("SAILOR_FCN")

-- zil: gglobals.zil:164  <OBJECT GROUND>
ZG._declare("GROUND", function() return ZG._declare_object("GROUND", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"GROUND", "SAND", "DIRT", "FLOOR"},
    ["DESC"] = "ground",
    ["ACTION"] = ZG.GROUND_FUNCTION,
} end) end, true)

-- zil: gglobals.zil:170  <ROUTINE GROUND-FUNCTION ()>
ZG.actions:register("GROUND_FUNCTION", function()

    if (ZG._T(ZG.VERB_p("PUT", "PUT-ON")) and ZG.EQ(ZG.PRSI, ZG.GROUND)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DROP"), ZG.PRSO) end
        do return true end
    elseif ZG.EQ(ZG.HERE, ZG.SANDY_CAVE) then
        do return ZG.SAND_FUNCTION() end
    elseif ZG._T(ZG.VERB_p("DIG")) then
        do return ZG.TELL("The ground is too hard for digging here.", ZG._TK.CR) end
    else
        do return false end
    end

end, "GROUND-FUNCTION")

ZG.GROUND_FUNCTION = ZG.actions:get("GROUND_FUNCTION")

-- zil: gglobals.zil:184  <OBJECT GRUE>
ZG._declare("GRUE", function() return ZG._declare_object("GRUE", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "GRUE",
    ["ADJECTIVE"] = {"LURKING", "SINISTER", "HUNGRY", "SILENT"},
    ["DESC"] = "lurking grue",
    ["ACTION"] = ZG.GRUE_FUNCTION,
} end) end, true)

-- zil: gglobals.zil:191  <ROUTINE GRUE-FUNCTION ()>
ZG.actions:register("GRUE_FUNCTION", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The grue is a sinister, lurking presence in the dark places of the\nearth. Its favorite diet is adventurers, but its insatiable\nappetite is tempered by its fear of light. No grue has ever been\nseen by the light of day, and few have survived its fearsome jaws\nto tell the tale.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FIND")) then
        do return ZG.TELL("There is no grue here, but I'm sure there is at least one lurking\nin the darkness nearby. I wouldn't let my light go out if I were\nyou!", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LISTEN")) then
        do return ZG.TELL("It makes no sound but is always lurking in the darkness nearby.", ZG._TK.CR) end
    else
        do return false end
    end

end, "GRUE-FUNCTION")

ZG.GRUE_FUNCTION = ZG.actions:get("GRUE_FUNCTION")

-- zil: gglobals.zil:208  <OBJECT LUNGS>
ZG._declare("LUNGS", function() return ZG._declare_object("LUNGS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"LUNGS", "AIR", "MOUTH", "BREATH"},
    ["DESC"] = "blast of air",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: gglobals.zil:214  <OBJECT ME>
ZG._declare("ME", function() return ZG._declare_object("ME", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"ME", "MYSELF", "SELF", "CRETIN"},
    ["DESC"] = "you",
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.CRETIN_FCN,
} end) end, true)

-- zil: gglobals.zil:221  <ROUTINE CRETIN-FCN ()>
ZG.actions:register("CRETIN_FCN", function()

    if ZG._T(ZG.VERB_p("TELL")) then
        ZG._set("P_CONT", false)
        ZG._set("QUOTE_FLAG", false)
        do return ZG.TELL("Talking to yourself is said to be a sign of impending mental collapse.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.ME)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?TAKE"), ZG.PRSO) end
        do return true end
    elseif ZG._T(ZG.VERB_p("MAKE")) then
        do return ZG.TELL("Only you can do that.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DISEMBARK")) then
        do return ZG.TELL("You'll have to do that on your own.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EAT")) then
        do return ZG.TELL("Auto-cannibalism is not the answer.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        if (ZG._T(ZG.PRSI) and ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT"))) then
            do return ZG.JIGS_UP("If you insist.... Poof, you're dead!") end
        else
            do return ZG.TELL("Suicide is not the answer.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("THROW")) then
        if ZG.EQ(ZG.PRSO, ZG.ME) then
            do return ZG.TELL("Why don't you just walk like normal people?", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("How romantic!", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG.EQUAL_p(ZG.HERE, ZG.LOC(ZG.MIRROR_1), ZG.LOC(ZG.MIRROR_2)) then
            do return ZG.TELL("Your image in the mirror looks tired.", ZG._TK.CR) end
        else
            do return ZG.TELL("That's difficult unless your eyes are prehensile.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "CRETIN-FCN")

ZG.CRETIN_FCN = ZG.actions:get("CRETIN_FCN")

-- zil: gglobals.zil:267  <OBJECT ADVENTURER>
ZG._declare("ADVENTURER", function() return ZG._declare_object("ADVENTURER", function() return {
    ["SYNONYM"] = "ADVENTURER",
    ["DESC"] = "cretin",
    ["FLAGS"] = {"NDESCBIT", "INVISIBLE", "SACREDBIT", "ACTORBIT"},
    ["STRENGTH"] = 0,
    ["ACTION"] = 0,
} end) end, true)

-- zil: gglobals.zil:274  <OBJECT PATHOBJ>
ZG._declare("PATHOBJ", function() return ZG._declare_object("PATHOBJ", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"TRAIL", "PATH"},
    ["ADJECTIVE"] = {"FOREST", "NARROW", "LONG", "WINDING"},
    ["DESC"] = "passage",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.PATH_OBJECT,
} end) end, true)

-- zil: gglobals.zil:282  <ROUTINE PATH-OBJECT ()>
ZG.actions:register("PATH_OBJECT", function()

    if ZG._T(ZG.VERB_p("TAKE", "FOLLOW")) then
        do return ZG.TELL("You must specify a direction to go.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FIND")) then
        do return ZG.TELL("I can't help you there....", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DIG")) then
        do return ZG.TELL("Not a chance.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PATH-OBJECT")

ZG.PATH_OBJECT = ZG.actions:get("PATH_OBJECT")

-- zil: gglobals.zil:290  <OBJECT ZORKMID>
ZG._declare("ZORKMID", function() return ZG._declare_object("ZORKMID", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = "ZORKMID",
    ["DESC"] = "zorkmid",
    ["ACTION"] = ZG.ZORKMID_FUNCTION,
} end) end, true)

-- zil: gglobals.zil:296  <ROUTINE ZORKMID-FUNCTION ()>
ZG.actions:register("ZORKMID_FUNCTION", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The zorkmid is the unit of currency of the Great Underground Empire.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FIND")) then
        do return ZG.TELL("The best way to find zorkmids is to go out and look for them.", ZG._TK.CR) end
    else
        do return false end
    end

end, "ZORKMID-FUNCTION")

ZG.ZORKMID_FUNCTION = ZG.actions:get("ZORKMID_FUNCTION")

-- zil: gglobals.zil:304  <OBJECT HANDS>
ZG._declare("HANDS", function() return ZG._declare_object("HANDS", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["SYNONYM"] = {"PAIR", "HANDS", "HAND"},
    ["ADJECTIVE"] = "BARE",
    ["DESC"] = "pair of hands",
    ["FLAGS"] = {"NDESCBIT", "TOOLBIT"},
} end) end, true)
