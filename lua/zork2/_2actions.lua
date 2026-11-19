-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: 2actions.zil:5  <ROUTINE SWORD-FCN ()>
ZG.actions:register("SWORD_FCN", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SWORD, -1)) end
        do return false end
    else
        do return false end
    end

end, "SWORD-FCN")

ZG.SWORD_FCN = ZG.actions:get("SWORD_FCN")

-- zil: 2actions.zil:13  <GLOBAL SWORD-GLOW>
-- SWORD_GLOW is declared in ZilGlobal.lua

-- zil: 2actions.zil:15  <ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) G P TX L)>
ZG.actions:register("I_SWORD", function()

    local DEM = ZG.INT(ZG.I_SWORD)
    local NG = 0
    local G = 0
    local P = 0
    local TX = 0
    local L = 0
    G = ZG.SWORD_GLOW
    if ZG._T(ZG.IN_p(ZG.SWORD, ZG.ADVENTURER)) then
        if ZG._T(ZG.INFESTED_p(ZG.HERE)) then
            NG = 2
        else
            P = 0
            while true do
                if ZG.ZERO_p((function() P = ZG.NEXTP(ZG.HERE, P); return P end)()) then
                    break
                elseif (not ZG.LT(P, ZG.LOW_DIRECTION)) then
                    TX = ZG.GETPT(ZG.HERE, P)
                    L = ZG.PTSIZE(TX)
                    if ZG.EQUAL_p(L, ZG.UEXIT, ZG.CEXIT, ZG.DEXIT) then
                        if ZG._T(ZG.INFESTED_p(ZG.GETB(TX, 0))) then
                            NG = 1
                            break
                        end
                    end
                end
            end
        end
        if ZG.EQ(NG, G) then
            do return false end
        elseif ZG.EQ(NG, 2) then
            do local _ = ZG.TELL("Your sword has begun to glow very brightly.", ZG._TK.CR) end
        elseif (NG == 1) then
            do local _ = ZG.TELL("Your sword is glowing with a faint blue glow.", ZG._TK.CR) end
        elseif ZG.ZERO_p(NG) then
            do local _ = ZG.TELL("Your sword is no longer glowing.", ZG._TK.CR) end
        end
        ZG._set("SWORD_GLOW", NG)
        do return true end
    else
        do local _ = ZG.PUT(DEM, ZG.C_ENABLED_p, 0) end
        do return false end
    end

end, "I-SWORD")

ZG.I_SWORD = ZG.actions:get("I_SWORD")

-- zil: 2actions.zil:45  <ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))>
ZG.actions:register("INFESTED_p", function(R)

    local F = ZG.FIRST_p(R)
    while true do
        if (not ZG._T(F)) then
            do return false end
        elseif (ZG._T(ZG.FSET_p(F, "ACTORBIT")) and (not ZG._T(ZG.FSET_p(F, "INVISIBLE"))) and (not ZG.EQ(F, ZG.ROBOT))) then
            do return F end
        elseif (not ZG._T((function() F = ZG.NEXT_p(F); return F end)())) then
            do return false end
        end
    end

end, "INFESTED?")

ZG.INFESTED_p = ZG.actions:get("INFESTED_p")

-- zil: 2actions.zil:54  <ROUTINE CAROUSEL-ROOM-FCN (RARG)>
ZG.actions:register("CAROUSEL_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a large circular room whose high ceiling is lost in gloom. Eight\nidentical passages leave the room.", ZG._TK.CR) end
        if (not ZG._T(ZG.CAROUSEL_FLIP_FLAG)) then
            do local _ = ZG.TELL("A loud whirring sound comes from all around, and you feel\nsort of disoriented in here.", ZG._TK.CR) end
        end
        do return true end
    elseif ((not ZG._T(ZG.CAROUSEL_FLIP_FLAG)) and ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("WALK"))) then
        if ZG.EQUAL_p(ZG.PRSO, "UP", "DOWN") then
            do return false end
        end
        if ZG.EQ(ZG.PRSO, "OUT") then
            do local _ = ZG.TELL("Feeling dizzy, you pick a direction at random.", ZG._TK.CR, ZG._TK.CR) end
            ZG._set("PRSO", "EAST")
        else
            do local _ = ZG.TELL("You're not sure which direction is which. This\nroom is very disorienting.", ZG._TK.CR, ZG._TK.CR) end
        end
        if (ZG.EQ(ZG.PRSO, "WEST") or ZG._T(ZG.PROB(80))) then
            ZG._set("PRSO", ZG.GET(ZG.EIGHT_DIRECTIONS, ZG.SUB(ZG.RANDOM(7), 1)))
        end
        do local _ = ZG.V_WALK() end
        do return true end
    else
        do return false end
    end

end, "CAROUSEL-ROOM-FCN")

ZG.CAROUSEL_ROOM_FCN = ZG.actions:get("CAROUSEL_ROOM_FCN")

-- zil: 2actions.zil:82  <ROUTINE VIOLIN-FCN ()>
ZG.actions:register("VIOLIN_FCN", function()

    if (ZG._T(ZG.VERB_p("PLAY")) and ZG.EQ(ZG.PRSO, ZG.VIOLIN)) then
        do return ZG.TELL("An amazingly offensive noise issues from the violin.", ZG._TK.CR) end
    else
        do return false end
    end

end, "VIOLIN-FCN")

ZG.VIOLIN_FCN = ZG.actions:get("VIOLIN_FCN")

-- zil: 2actions.zil:88  <GLOBAL EIGHT-DIRECTIONS>
-- EIGHT_DIRECTIONS is declared in ZilGlobal.lua

-- zil: 2actions.zil:91  <GLOBAL MUNGED-ROOM>
-- MUNGED_ROOM is declared in ZilGlobal.lua

-- zil: 2actions.zil:93  <ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)>
ZG.actions:register("OPEN_CLOSE", function(OBJ, STROPN, STRCLS)

    if ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.FSET_p(OBJ, "OPENBIT")) then
            do local _ = ZG.TELL(ZG.RANDOM_ELEMENT(ZG.DUMMY)) end
        else
            do local _ = ZG.TELL(STROPN) end
            do local _ = ZG.FSET(OBJ, "OPENBIT") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        if ZG._T(ZG.FSET_p(OBJ, "OPENBIT")) then
            do local _ = ZG.TELL(STRCLS) end
            do local _ = ZG.FCLEAR(OBJ, "OPENBIT") end
        else
            do local _ = ZG.TELL(ZG.RANDOM_ELEMENT(ZG.DUMMY), ZG._TK.CR) end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "OPEN-CLOSE")

ZG.OPEN_CLOSE = ZG.actions:get("OPEN_CLOSE")

-- ;"SUBTITLE THE VOLCANO"

-- zil: 2actions.zil:112  <GLOBAL BTIE-FLAG>
-- BTIE_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:113  <GLOBAL BINF-FLAG>
-- BINF_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:114  <GLOBAL BLAB-FLAG>
-- BLAB_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:115  <GLOBAL SAFE-FLAG>
-- SAFE_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:117  <ROUTINE BALLOON-FCN ("OPTIONAL" (RARG <>) "AUX" M R RC)>
ZG.actions:register("BALLOON_FCN", function(RARG)

    local _tmp1, _tmp2
    if RARG == nil then RARG = false end
    local M = 0
    local R = 0
    local RC = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG._T(ZG.BINF_FLAG) then
            do local _ = ZG.TELL("The cloth bag is inflated and ") end
            if ZG._T(ZG.FSET_p(ZG.RECEPTACLE, "OPENBIT")) then
                do local _ = ZG.TELL("there is a ", ZG._TK.D, ZG.BINF_FLAG, " burning in the receptacle.") end
            else
                do local _ = ZG.TELL("some smoke is leaking out of the closed receptacle.") end
            end
        else
            do local _ = ZG.TELL("The cloth bag is draped over the side\nof the basket. Directly in the middle of the basket is a metal receptacle\nwhich is ") end
            if ZG._T(ZG.FSET_p(ZG.RECEPTACLE, "OPENBIT")) then
                do local _ = ZG.TELL("open") end
                RC = ZG.FIRST_p(ZG.RECEPTACLE)
                if ZG._T(RC) then
                    if ZG.EQ(ZG.BINF_FLAG, RC) then
                        _tmp1 = "burning"
                    else
                        _tmp1 = "nestled"
                    end
                    if ZG.EQ(ZG.BINF_FLAG, RC) then
                        _tmp2 = "burning"
                    else
                        _tmp2 = "nestled"
                    end
                    do local _ = ZG.TELL(". A ", ZG._TK.D, RC, " is ", _tmp2, " inside") end
                end
            else
                do local _ = ZG.TELL("closed") end
            end
            do local _ = ZG.TELL(".") end
        end
        if ZG._T(ZG.BTIE_FLAG) then
            do local _ = ZG.TELL(" The balloon is tied to a hook by the braided wire.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL(" A braided wire is dangling over the side of the basket.", ZG._TK.CR) end
        end
        do return true end
    elseif ZG.EQ(RARG, ZG.M_OBJDESC) then
        do local _ = ZG.TELL("There is a large and extremely heavy wicker basket here. An\nenormous cloth bag ") end
        if ZG._T(ZG.BINF_FLAG) then
            do local _ = ZG.TELL("attached to the basket is inflated. A metal receptacle is fastened to\nthe center of the basket. ") end
            if ZG._T(ZG.FSET_p(ZG.RECEPTACLE, "OPENBIT")) then
                do local _ = ZG.TELL("In it is a burning ", ZG._TK.D, ZG.BINF_FLAG) end
            else
                do local _ = ZG.TELL("Some smoke leaks out around its closed lid") end
            end
        else
            do local _ = ZG.TELL("is draped over the side and is firmly attached to the basket. A metal\nreceptacle is fastened to the center of the basket") end
        end
        if ZG._T(ZG.BTIE_FLAG) then
            do return ZG.TELL(". A piece of wire tied to a hook holds the balloon in place.", ZG._TK.CR) end
        else
            do return ZG.TELL(". Dangling from the basket is a piece of braided wire.", ZG._TK.CR) end
        end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if ZG._T(ZG.VERB_p("WALK")) then
            if ZG._T((function() M = ZG.GETPT(ZG.HERE, ZG.PRSO); return M end)()) then
                if ZG._T(ZG.BTIE_FLAG) then
                    do local _ = ZG.TELL("You are tied to the ledge.", ZG._TK.CR) end
                    do return true end
                else
                    do local _ = (ZG.EQ(ZG.PTSIZE(M), 1) and (not ZG._T(ZG.FSET_p((function() R = ZG.GETB(M, 0); return R end)(), "RMUNGBIT"))) and ZG._set("BLOC", R)) end
                    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3)) end
                    do return false end
                end
            else
                do local _ = ZG.TELL("You can't control the balloon this way.", ZG._TK.CR) end
                do return true end
            end
        elseif (ZG._T(ZG.VERB_p("OPEN")) and ZG._T(ZG.BINF_FLAG) and ZG.EQ(ZG.PRSO, ZG.RECEPTACLE) and ZG._T(ZG.FIRST_p(ZG.RECEPTACLE))) then
            do local _ = ZG.TELL("Opening it reveals a burning ", ZG._TK.D, ZG.BINF_FLAG, ".", ZG._TK.CR) end
            do local _ = ZG.FSET(ZG.RECEPTACLE, "OPENBIT") end
            do return true end
        elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.BINF_FLAG, ZG.PRSO)) then
            do local _ = ZG.TELL("You don't really want to hold a burning ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
            do return true end
        elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.RECEPTACLE) and ZG._T(ZG.FIRST_p(ZG.RECEPTACLE))) then
            do local _ = ZG.TELL("The receptacle is already occupied.", ZG._TK.CR) end
            do return true end
        elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.RECEPTACLE)) then
            do local _ = ZG.FSET(ZG.PRSO, "NDESCBIT") end
            do return false end
        elseif ZG._T(ZG.VERB_p("INFLATE")) then
            do return ZG.TELL("It takes more than words to inflate a balloon.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "BALLOON-FCN")

ZG.BALLOON_FCN = ZG.actions:get("BALLOON_FCN")

-- zil: 2actions.zil:219  <ROUTINE I-BALLOON ()>
ZG.actions:register("I_BALLOON", function()

    if (ZG._T(ZG.FSET_p(ZG.RECEPTACLE, "OPENBIT")) and ZG._T(ZG.BINF_FLAG)) then
        do return ZG.RISE_AND_SHINE() end
    elseif ZG.EQUAL_p(ZG.HERE, ZG.LEDGE_1, ZG.LEDGE_2) then
        do return ZG.RISE_AND_SHINE() end
    else
        do return ZG.DECLINE_AND_FALL() end
    end

end, "I-BALLOON")

ZG.I_BALLOON = ZG.actions:get("I_BALLOON")

-- zil: 2actions.zil:227  <ROUTINE BALLOON-BURN ()>
ZG.actions:register("BALLOON_BURN", function()

    do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " burns inside the receptacle.", ZG._TK.CR) end
    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BURNUP, (ZG.GETP(ZG.PRSO, "SIZE") * 20))) end
    do local _ = ZG.FSET(ZG.PRSO, "FLAMEBIT") end
    do local _ = ZG.FSET(ZG.PRSO, "ONBIT") end
    do local _ = ZG.FCLEAR(ZG.PRSO, "TAKEBIT") end
    do local _ = ZG.FCLEAR(ZG.PRSO, "READBIT") end
    if ZG._T(ZG.BINF_FLAG) then
        do return true end
    else
        do local _ = ZG.TELL("The cloth bag inflates as it fills with hot air.", ZG._TK.CR) end
        if (not ZG._T(ZG.BLAB_FLAG)) then
            do local _ = ZG.TELL("A small label drops from the bag into the basket.", ZG._TK.CR) end
            do local _ = ZG.MOVE(ZG.BALLOON_LABEL, ZG.BALLOON) end
        end
        ZG._set("BLAB_FLAG", true)
        ZG._set("BINF_FLAG", ZG.PRSO)
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3)) end
    end

end, "BALLOON-BURN")

ZG.BALLOON_BURN = ZG.actions:get("BALLOON_BURN")

-- zil: 2actions.zil:246  <ROUTINE PUT-BALLOON (THERE STR)>
ZG.actions:register("PUT_BALLOON", function(THERE, STR)

    if ZG.EQUAL_p(ZG.HERE, ZG.LEDGE_1, ZG.LEDGE_2, ZG.VOLCANO_BOTTOM) then
        do local _ = ZG.TELL("You watch as the balloon slowly ", STR, ZG._TK.CR) end
    end
    do local _ = ZG.MOVE(ZG.BALLOON, THERE) end
    ZG._set("BLOC", THERE)
    do return ZG.BLOC end

end, "PUT-BALLOON")

ZG.PUT_BALLOON = ZG.actions:get("PUT_BALLOON")

-- zil: 2actions.zil:253  <GLOBAL BALLOON-UPS>
-- BALLOON_UPS is declared in ZilGlobal.lua

-- zil: 2actions.zil:256  <GLOBAL BALLOON-FLOATS>
-- BALLOON_FLOATS is declared in ZilGlobal.lua

-- zil: 2actions.zil:259  <GLOBAL BALLOON-DOWNS>
-- BALLOON_DOWNS is declared in ZilGlobal.lua

-- zil: 2actions.zil:262  <ROUTINE RISE-AND-SHINE ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)>
ZG.actions:register("RISE_AND_SHINE", function()

    local IN = ZG.IN_p(ZG.WINNER, ZG.BALLOON)
    local R = 0
    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3)) end
    if ZG.EQ(ZG.BLOC, ZG.VAIR_4) then
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_BURNUP)) end
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_BALLOON)) end
        do local _ = ZG.REMOVE(ZG.BALLOON) end
        if ZG._T(IN) then
            do local _ = ZG.JIGS_UP("The balloon floats majestically out of the volcano, revealing a\nbreathtaking view of a wooded river valley surrounded by impassable\nmountains. In a clearing stands a white house. You drift into high winds,\nwhich carry you towards the snow-capped peaks. Oh, no! You crash into the\njagged cliffs of the Flathead Mountains!") end
        elseif ZG.EQUAL_p(ZG.HERE, ZG.LEDGE_1, ZG.LEDGE_2, ZG.VOLCANO_BOTTOM) then
            do local _ = ZG.TELL("You watch the balloon drift out over the rim and away on the wind.", ZG._TK.CR) end
        end
        ZG._set("BLOC", ZG.VOLCANO_BOTTOM)
        do return ZG.BLOC end
    elseif ZG._T((function() R = ZG.LKP(ZG.BLOC, ZG.BALLOON_UPS); return R end)()) then
        if ZG._T(IN) then
            do local _ = ZG.TELL("The balloon ascends.", ZG._TK.CR, ZG._TK.CR) end
            ZG._set("BLOC", R)
            do return ZG.GOTO(R) end
        else
            do return ZG.PUT_BALLOON(R, "ascends.") end
        end
    elseif ZG._T((function() R = ZG.LKP(ZG.BLOC, ZG.BALLOON_FLOATS); return R end)()) then
        if ZG._T(IN) then
            do local _ = ZG.TELL("The balloon leaves the ledge.", ZG._TK.CR, ZG._TK.CR) end
            ZG._set("BLOC", R)
            do return ZG.GOTO(R) end
        else
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_GNOME, 10)) end
            do local _ = ZG.PUT_BALLOON(R, "floats away. It seems to be ascending, due to its light load.") end
            do return ZG.FSET(ZG.RECEPTACLE, "OPENBIT") end
        end
    elseif ZG._T(IN) then
        ZG._set("BLOC", ZG.VAIR_1)
        do local _ = ZG.TELL("The balloon rises slowly from the ground.", ZG._TK.CR, ZG._TK.CR) end
        do return ZG.GOTO(ZG.VAIR_1) end
    else
        do return ZG.PUT_BALLOON(ZG.VAIR_1, "lifts off.") end
    end

end, "RISE-AND-SHINE")

ZG.RISE_AND_SHINE = ZG.actions:get("RISE_AND_SHINE")

-- zil: 2actions.zil:304  <ROUTINE DECLINE-AND-FALL ("AUX" (IN <IN? ,WINNER ,BALLOON>) R)>
ZG.actions:register("DECLINE_AND_FALL", function()

    local IN = ZG.IN_p(ZG.WINNER, ZG.BALLOON)
    local R = 0
    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3)) end
    if ZG.EQ(ZG.BLOC, ZG.VAIR_1) then
        if ZG._T(IN) then
            ZG._set("BLOC", ZG.VOLCANO_BOTTOM)
            if ZG._T(ZG.BINF_FLAG) then
                do local _ = ZG.TELL("The balloon has landed.", ZG._TK.CR, ZG._TK.CR) end
                do return ZG.GOTO(ZG.VOLCANO_BOTTOM) end
            else
                do local _ = ZG.REMOVE(ZG.BALLOON) end
                do local _ = ZG.MOVE(ZG.DEAD_BALLOON, ZG.BLOC) end
                do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
                do local _ = ZG.DISABLE(ZG.INT(ZG.I_BALLOON)) end
                do local _ = ZG.TELL("You have landed, but the balloon did not survive.", ZG._TK.CR, ZG._TK.CR) end
                do return ZG.GOTO(ZG.VOLCANO_BOTTOM) end
            end
        else
            do return ZG.PUT_BALLOON(ZG.VOLCANO_BOTTOM, "lands.") end
        end
    elseif ZG._T((function() R = ZG.LKP(ZG.BLOC, ZG.BALLOON_DOWNS); return R end)()) then
        if ZG._T(IN) then
            do local _ = ZG.TELL("The balloon descends.", ZG._TK.CR, ZG._TK.CR) end
            ZG._set("BLOC", R)
            do return ZG.GOTO(R) end
        else
            do return ZG.PUT_BALLOON(R, "descends.") end
        end
    else
        do return false end
    end

end, "DECLINE-AND-FALL")

ZG.DECLINE_AND_FALL = ZG.actions:get("DECLINE_AND_FALL")

-- zil: 2actions.zil:331  <ROUTINE BCONTENTS ()>
ZG.actions:register("BCONTENTS", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is an integral part of the basket and cannot\nbe removed.") end
        if ZG.EQ(ZG.PRSO, ZG.BRAIDED_WIRE) then
            do local _ = ZG.TELL(" The wire might possibly be tied, though.") end
        end
        do return ZG.CRLF() end
    elseif (ZG.EQ(ZG.PRSO, ZG.CLOTH_BAG) and ZG._T(ZG.VERB_p("LOOK-INSIDE", "OPEN"))) then
        if ZG._T(ZG.VERB_p("OPEN")) then
            do return ZG.TELL("The bag is enormous. The concept of opening it here is ludicrous.", ZG._TK.CR) end
        else
            do return ZG.TELL("It doesn't appear that there's anything inside.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("EXAMINE")) and ZG.EQ(ZG.PRSO, ZG.RECEPTACLE)) then
        do local _ = ZG.TELL("The receptacle is ") end
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do return ZG.TELL("open.", ZG._TK.CR) end
        else
            do return ZG.TELL("closed.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("FIND", "EXAMINE")) then
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is part of the basket. It may be manipulated\nwithin the basket but cannot be removed.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BCONTENTS")

ZG.BCONTENTS = ZG.actions:get("BCONTENTS")

-- zil: 2actions.zil:356  <ROUTINE WIRE-FCN ()>
ZG.actions:register("WIRE_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE", "FIND", "EXAMINE")) then
        do return ZG.BCONTENTS() end
    elseif ZG._T(ZG.VERB_p("TIE")) then
        if (ZG.EQ(ZG.PRSO, ZG.BRAIDED_WIRE) and ZG.EQUAL_p(ZG.PRSI, ZG.HOOK_1, ZG.HOOK_2)) then
            ZG._set("BTIE_FLAG", ZG.PRSI)
            do local _ = ZG.FSET(ZG.PRSI, "NDESCBIT") end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_BALLOON)) end
            do return ZG.TELL("The balloon is fastened to the hook.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("UNTIE")) and ZG.EQ(ZG.PRSO, ZG.BRAIDED_WIRE)) then
        if ZG._T(ZG.BTIE_FLAG) then
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BALLOON, 3)) end
            do local _ = ZG.FCLEAR(ZG.BTIE_FLAG, "NDESCBIT") end
            ZG._set("BTIE_FLAG", false)
            do return ZG.TELL("The wire falls off of the hook.", ZG._TK.CR) end
        else
            do return ZG.TELL("The wire is not tied to anything.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "WIRE-FCN")

ZG.WIRE_FCN = ZG.actions:get("WIRE_FCN")

-- zil: 2actions.zil:375  <ROUTINE I-BURNUP ("AUX" (OBJ <FIRST? ,RECEPTACLE>))>
ZG.actions:register("I_BURNUP", function()

    local OBJ = ZG.FIRST_p(ZG.RECEPTACLE)
    if ZG.EQ(ZG.HERE, ZG.BLOC) then
        do local _ = ZG.TELL("The ", ZG._TK.D, OBJ, " has now burned out, and the cloth bag starts to deflate.", ZG._TK.CR) end
    end
    do local _ = ZG.REMOVE(OBJ) end
    ZG._set("BINF_FLAG", false)
    do return true end

end, "I-BURNUP")

ZG.I_BURNUP = ZG.actions:get("I_BURNUP")

-- zil: 2actions.zil:384  <ROUTINE SAFE-ROOM-FCN (RARG)>
ZG.actions:register("SAFE_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a dusty old room which is featureless, except\nfor an exit on the north side.", ZG._TK.CR) end
        if (not ZG._T(ZG.SAFE_FLAG)) then
            do return ZG.TELL("Imbedded in the far wall is a rusty box. It appears to be somewhat\ndamaged, since an oblong hole has been chipped out of the front of it.", ZG._TK.CR) end
        else
            do return ZG.TELL("On the far wall is a rusty box, whose door has been blown off.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SAFE-ROOM-FCN")

ZG.SAFE_ROOM_FCN = ZG.actions:get("SAFE_ROOM_FCN")

-- zil: 2actions.zil:397  <ROUTINE SAFE-FCN ()>
ZG.actions:register("SAFE_FCN", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.PRSO, ZG.SAFE)) then
        do return ZG.TELL("The box is imbedded in the wall.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.SAFE_FLAG) then
            do return ZG.TELL("The box has no door!", ZG._TK.CR) end
        else
            do return ZG.TELL("The box is rusted and will not open.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        if ZG._T(ZG.SAFE_FLAG) then
            do return ZG.TELL("The box has no door!", ZG._TK.CR) end
        else
            do return ZG.TELL("The box isn't open!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SAFE-FCN")

ZG.SAFE_FCN = ZG.actions:get("SAFE_FCN")

-- zil: 2actions.zil:407  <ROUTINE BRICK-FCN ()>
ZG.actions:register("BRICK_FCN", function()

    if ZG._T(ZG.VERB_p("BURN")) then
        do local _ = ZG.REMOVE(ZG.BRICK) end
        do return ZG.JIGS_UP(ZG.OTHER_PROPERTIES) end
    else
        do return false end
    end

end, "BRICK-FCN")

ZG.BRICK_FCN = ZG.actions:get("BRICK_FCN")

-- zil: 2actions.zil:412  <GLOBAL OTHER-PROPERTIES>
-- OTHER_PROPERTIES is declared in ZilGlobal.lua

-- zil: 2actions.zil:416  <ROUTINE FUSE-FCN ()>
ZG.actions:register("FUSE_FCN", function()

    if (ZG._T(ZG.VERB_p("BURN")) or (ZG._T(ZG.VERB_p("LAMP-ON")) and ZG._T(ZG.IN_p(ZG.MATCH, ZG.WINNER)) and ZG._T(ZG.FSET_p(ZG.MATCH, "ONBIT")))) then
        do local _ = ZG.TELL("The string starts to burn.", ZG._TK.CR) end
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_FUSE, 2)) end
    else
        do return false end
    end

end, "FUSE-FCN")

ZG.FUSE_FCN = ZG.actions:get("FUSE_FCN")

-- zil: 2actions.zil:424  <ROUTINE I-FUSE ("AUX" (BRICK-ROOM <LOC ,BRICK>) F)>
ZG.actions:register("I_FUSE", function()

    local BRICK_ROOM = ZG.LOC(ZG.BRICK)
    local F = 0
    if ZG._T(ZG.IN_p(ZG.FUSE, ZG.BRICK)) then
        while true do
            if (not ZG._T(BRICK_ROOM)) then
                do return false end
            elseif ZG._T(ZG.IN_p(BRICK_ROOM, ZG.ROOMS)) then
                break
            else
                BRICK_ROOM = ZG.LOC(BRICK_ROOM)
            end
        end
        do local _ = ZG.MOVE(ZG.EXPLOSION, BRICK_ROOM) end
        do local _ = ZG.FCLEAR(BRICK_ROOM, "TOUCHBIT") end
        if ZG.EQ(BRICK_ROOM, ZG.HERE) then
            do local _ = ZG.MUNG_ROOM(BRICK_ROOM, "The way is blocked by debris from an explosion.") end
            do local _ = ZG.JIGS_UP(ZG.OTHER_PROPERTIES) end
        elseif ZG.EQ(BRICK_ROOM, ZG.SAFE_ROOM) then
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SAFE, 5)) end
            ZG._set("MUNGED_ROOM", ZG.SAFE_ROOM)
            do local _ = ZG.TELL("There is an explosion nearby.", ZG._TK.CR) end
            if ZG._T(ZG.IN_p(ZG.BRICK, ZG.SLOT)) then
                do local _ = ZG.FSET(ZG.SLOT, "INVISIBLE") end
                do local _ = ZG.FSET(ZG.SAFE, "OPENBIT") end
                do local _ = ZG.FCLEAR(ZG.SAFE_ROOM, "TOUCHBIT") end
                ZG._set("SAFE_FLAG", true)
            end
        else
            do local _ = ZG.TELL("There is an explosion nearby.", ZG._TK.CR) end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SAFE, 5)) end
            ZG._set("MUNGED_ROOM", BRICK_ROOM)
            if ZG._T((function() F = ZG.FIRST_p(BRICK_ROOM); return F end)()) then
                while true do
                    if ZG._T(ZG.FSET_p(F, "TAKEBIT")) then
                        do local _ = ZG.FSET(F, "INVISIBLE") end
                    end
                    if (not ZG._T((function() F = ZG.NEXT_p(F); return F end)())) then
                        break
                    end
                end
            end
        end
        do local _ = ZG.REMOVE(ZG.BRICK) end
    elseif ZG.EQUAL_p(ZG.LOC(ZG.FUSE), ZG.WINNER, ZG.HERE) then
        do local _ = ZG.TELL("The string rapidly burns into nothingness.", ZG._TK.CR) end
    end
    do return ZG.REMOVE(ZG.FUSE) end

end, "I-FUSE")

ZG.I_FUSE = ZG.actions:get("I_FUSE")

-- zil: 2actions.zil:462  <ROUTINE I-SAFE ()>
ZG.actions:register("I_SAFE", function()

    if ZG.EQ(ZG.HERE, ZG.MUNGED_ROOM) then
        do local _ = ZG.JIGS_UP("The room trembles and 5000 tons of rock fall on you, turning you\ninto a pancake.") end
    elseif (not ZG._T(ZG.DEAD)) then
        do local _ = ZG.TELL("You may recall that recent explosion. Probably as a result of it, you\nhear an ominous rumbling, as if a nearby room had collapsed.", ZG._TK.CR) end
        if ZG.EQ(ZG.MUNGED_ROOM, ZG.SAFE_ROOM) then
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_LEDGE, 8)) end
        end
    end
    do return ZG.MUNG_ROOM(ZG.MUNGED_ROOM, "The way is blocked by debris from an explosion.") end

end, "I-SAFE")

ZG.I_SAFE = ZG.actions:get("I_SAFE")

-- zil: 2actions.zil:476  <ROUTINE I-LEDGE ("AUX" (RM ,LEDGE-2))>
ZG.actions:register("I_LEDGE", function()

    local RM = ZG.LEDGE_2
    if ZG.EQ(ZG.HERE, ZG.LEDGE_2) then
        if ZG._T(ZG.IN_p(ZG.WINNER, ZG.BALLOON)) then
            if ZG._T(ZG.BTIE_FLAG) then
                ZG._set("BLOC", ZG.VOLCANO_BOTTOM)
                do local _ = ZG.REMOVE(ZG.BALLOON) end
                do local _ = ZG.MOVE(ZG.DEAD_BALLOON, ZG.VOLCANO_BOTTOM) end
                ZG._set("BTIE_FLAG", false)
                ZG._set("BINF_FLAG", false)
                do local _ = ZG.DISABLE(ZG.INT(ZG.I_BALLOON)) end
                do local _ = ZG.DISABLE(ZG.INT(ZG.I_BURNUP)) end
                do local _ = ZG.JIGS_UP("The ledge collapses, probably as a result of the explosion, and plummets\nto the ground far below. Sadly, you were still attached to the ledge.") end
            else
                do local _ = ZG.TELL("The ledge collapses, leaving you with no place to land.", ZG._TK.CR) end
            end
        else
            do local _ = ZG.JIGS_UP("The force of the recent explosion has caused the ledge to collapse.") end
        end
    elseif (not ZG._T(ZG.DEAD)) then
        do local _ = ZG.TELL("The ledge collapses. (That was a narrow escape!)", ZG._TK.CR) end
    end
    do return ZG.MUNG_ROOM(RM, "The ledge has collapsed and cannot be landed on.") end

end, "I-LEDGE")

ZG.I_LEDGE = ZG.actions:get("I_LEDGE")

-- zil: 2actions.zil:500  <ROUTINE LEDGE-FCN (RARG)>
ZG.actions:register("LEDGE_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are on a wide ledge high in the volcano. The rim of the volcano is\nabout 200 feet above and there is a precipitous drop to the bottom.") end
        if ZG._T(ZG.FSET_p(ZG.SAFE_ROOM, "RMUNGBIT")) then
            do return ZG.TELL(" The way to the south is blocked by rubble.", ZG._TK.CR) end
        else
            do return ZG.TELL(" There is a small door to the south.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "LEDGE-FCN")

ZG.LEDGE_FCN = ZG.actions:get("LEDGE_FCN")

-- ;<ROUTINE BLAST () ;"APPARENTLY UNUSED?"
--     <COND (<EQUAL? ,HERE ,SAFE-ROOM>)
-- 	  (T
-- 	   <TELL "You must explain how to do that." CR>)>>

-- zil: 2actions.zil:514  <ROUTINE I-GNOME ()>
ZG.actions:register("I_GNOME", function()

    if ZG.EQUAL_p(ZG.HERE, ZG.LEDGE_1, ZG.LEDGE_2) then
        do local _ = ZG.TELL("A volcano gnome seems to walk straight out of the wall and ") end
        if ZG._T(ZG.IN_p(ZG.WAND, ZG.WINNER)) then
            do return ZG.TELL("noticing the wand, straight back in.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("says\n\"I have a busy appointment schedule and little time to waste on\ntrespassers, but for a small fee I'll show you the way out.\" You\nnotice the gnome nervously glancing at his watch.", ZG._TK.CR) end
            do return ZG.MOVE(ZG.GNOME, ZG.HERE) end
        end
    else
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_GNOME, 1)) end
        do return false end
    end

end, "I-GNOME")

ZG.I_GNOME = ZG.actions:get("I_GNOME")

-- zil: 2actions.zil:532  <GLOBAL GNOME-FLAG>
-- GNOME_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:534  <ROUTINE GNOME-FCN ()>
ZG.actions:register("GNOME_FCN", function()

    if ZG._T(ZG.VERB_p("TELL")) then
        ZG._set("P_CONT", false)
        ZG._set("QUOTE_FLAG", false)
        if (not ZG._T(ZG.GNOME_FLAG)) then
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_NERVOUS, 5)) end
        end
        ZG._set("GNOME_FLAG", true)
        do return ZG.TELL("The gnome appears increasingly nervous.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE", "THROW")) and ZG.EQ(ZG.PRSI, ZG.GNOME)) then
        if ZG._T(ZG.GETPT(ZG.PRSO, "VALUE")) then
            do local _ = ZG.TELL("\"Thank you very much for the ", ZG._TK.D, ZG.PRSO, ". I don't believe\nI've ever seen one as beautiful. Follow me,\" he says, and a door\nappears on the west end of the ledge. Through the door, you can see\na narrow chimney sloping steeply downward. The gnome moves quickly,\nand disappears from sight.", ZG._TK.CR) end
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do local _ = ZG.REMOVE(ZG.GNOME) end
            ZG._set("GNOME_DOOR_FLAG", true)
            do return ZG.GNOME_DOOR_FLAG end
        elseif ZG._T(ZG.BOMB_p(ZG.PRSO)) then
            do local _ = ZG.MOVE(ZG.BRICK, ZG.HERE) end
            do local _ = ZG.REMOVE(ZG.GNOME) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_GNOME)) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_NERVOUS)) end
            do return ZG.TELL("\"That certainly wasn't what I had in mind,\" he says, and disappears.", ZG._TK.CR) end
        else
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            do return ZG.TELL("\"That wasn't quite what I had in mind,\" he says, crunching the\n", ZG._TK.D, ZG.PRSO, " in his rock-hard hands.", ZG._TK.CR) end
        end
    else
        do local _ = ZG.TELL("The gnome appears increasingly nervous.", ZG._TK.CR) end
        if (not ZG._T(ZG.GNOME_FLAG)) then
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_NERVOUS, 5)) end
        end
        ZG._set("GNOME_FLAG", true)
        do return ZG.GNOME_FLAG end
    end

end, "GNOME-FCN")

ZG.GNOME_FCN = ZG.actions:get("GNOME_FCN")

-- zil: 2actions.zil:573  <ROUTINE I-NERVOUS ()>
ZG.actions:register("I_NERVOUS", function()

    if ZG._T(ZG.IN_p(ZG.GNOME, ZG.HERE)) then
        do local _ = ZG.TELL("The gnome glances at his watch. \"Oops. I'm late for an\nappointment!\" He disappears, leaving you alone on the ledge.", ZG._TK.CR) end
    end
    do return ZG.REMOVE(ZG.GNOME) end

end, "I-NERVOUS")

ZG.I_NERVOUS = ZG.actions:get("I_NERVOUS")

-- zil: 2actions.zil:580  <ROUTINE PURPLE-BOOK-FCN ()>
ZG.actions:register("PURPLE_BOOK_FCN", function()

    if (ZG._T(ZG.VERB_p("READ")) and ZG._T(ZG.IN_p(ZG.STAMP, ZG.PURPLE_BOOK)) and (not ZG._T(ZG.FSET_p(ZG.PURPLE_BOOK, "OPENBIT")))) then
        do local _ = ZG.TELL(ZG.GETP(ZG.PURPLE_BOOK, "TEXT"), ZG._TK.CR) end
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?OPEN"), ZG.PURPLE_BOOK) end
        do return true end
    else
        do return ZG.RANDOM_BOOK() end
    end

end, "PURPLE-BOOK-FCN")

ZG.PURPLE_BOOK_FCN = ZG.actions:get("PURPLE_BOOK_FCN")

-- zil: 2actions.zil:589  <ROUTINE RANDOM-BOOK ()>
ZG.actions:register("RANDOM_BOOK", function()

    if ZG._T(ZG.VERB_p("TAKE", "MOVE", "PUT")) then
        do local _ = ZG.FSET(ZG.WHITE_BOOK, "TOUCHBIT") end
        do local _ = ZG.FSET(ZG.PURPLE_BOOK, "TOUCHBIT") end
        do local _ = ZG.FSET(ZG.GREEN_BOOK, "TOUCHBIT") end
        do local _ = ZG.FSET(ZG.BLUE_BOOK, "TOUCHBIT") end
        do return false end
    else
        do return false end
    end

end, "RANDOM-BOOK")

ZG.RANDOM_BOOK = ZG.actions:get("RANDOM_BOOK")

-- ; "SUBTITLE TOMB OF THE FLATHEADS"

-- zil: 2actions.zil:599  <ROUTINE HEAD-FCN ()>
ZG.actions:register("HEAD_FCN", function()

    if ZG._T(ZG.VERB_p("HELLO")) then
        do return ZG.TELL("The Flatheads are dead; therefore they do not respond.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("KICK", "ATTACK", "RUB", "OPEN", "TAKE", "BURN")) then
        do return ZG.JIGS_UP("Although the Flatheads are dead, they foresaw that some cretin\nmight tamper with their remains. Therefore, they took steps to\npunish such actions.") end
    else
        do return false end
    end

end, "HEAD-FCN")

ZG.HEAD_FCN = ZG.actions:get("HEAD_FCN")

-- zil: 2actions.zil:608  <ROUTINE CRYPT-ANTEROOM-FCN (RARG)>
ZG.actions:register("CRYPT_ANTEROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("The anteroom is large and empty. Marble bas reliefs depict the stirring\ntimes and afterlife of the Flatheads (the latter a bit optimistically).\nThe exit is to the west. A huge marble door stands to the south. ") end
        do local _ = ZG.TELL("The door is ") end
        if ZG._T(ZG.FSET_p(ZG.CRYPT_DOOR, "OPENBIT")) then
            do local _ = ZG.TELL("open.") end
        else
            do local _ = ZG.TELL("closed.") end
        end
        do return ZG.TELL(" Above the door is the cryptic inscription: \"Feel Free\".", ZG._TK.CR) end
    else
        do return false end
    end

end, "CRYPT-ANTEROOM-FCN")

ZG.CRYPT_ANTEROOM_FCN = ZG.actions:get("CRYPT_ANTEROOM_FCN")

-- zil: 2actions.zil:621  <ROUTINE CRYPT-ROOM-FCN (RARG "AUX" CLIT?)>
ZG.actions:register("CRYPT_ROOM_FCN", function(RARG)

    local CLIT_p = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.FCLEAR(ZG.HERE, "ONBIT") end
        if ZG._T(ZG.LIT_p(ZG.HERE)) then
            do local _ = ZG.TELL("The room contains the earthly remains of the mighty Flatheads, twelve\nsomewhat flat heads mounted securely on poles. While the room might be\nexpected to contain funerary urns or other evidence of the ritual\npractices of the ancient Zorkers, it is empty of all such objects. There\nis writing carved on the crypt. The only apparent exit is to the north\nthrough the door to the anteroom. The door is ") end
            if ZG._T(ZG.FSET_p(ZG.CRYPT_DOOR, "OPENBIT")) then
                do local _ = ZG.TELL("open.") end
            else
                do local _ = ZG.TELL("closed.") end
            end
            do local _ = ZG.CRLF() end
            if (not ZG._T(ZG.FSET_p(ZG.DIM_DOOR, "INVISIBLE"))) then
                do local _ = ZG.TELL("Looking closely at the south wall, you can see the dim outline of\na secret door labelled with the letter \"F\".", ZG._TK.CR) end
            end
        else
            do local _ = ZG.DIM_DOOR_APPEARS() end
        end
        do local _ = ZG.FSET(ZG.HERE, "ONBIT") end
        do return true end
    elseif ZG.EQ(RARG, ZG.M_END) then
        CLIT_p = ZG.CRYPT_LIT_p
        do local _ = ZG.FCLEAR(ZG.CRYPT_ROOM, "ONBIT") end
        ZG._set("CRYPT_LIT_p", ZG.LIT_p(ZG.CRYPT_ROOM))
        if (ZG._T(CLIT_p) and (not ZG._T(ZG.CRYPT_LIT_p))) then
            do local _ = ZG.DIM_DOOR_APPEARS() end
        end
        do return ZG.FSET(ZG.CRYPT_ROOM, "ONBIT") end
    else
        do return false end
    end

end, "CRYPT-ROOM-FCN")

ZG.CRYPT_ROOM_FCN = ZG.actions:get("CRYPT_ROOM_FCN")

-- zil: 2actions.zil:653  <GLOBAL CRYPT-LIT?>
-- CRYPT_LIT_p is declared in ZilGlobal.lua

-- zil: 2actions.zil:655  <ROUTINE DIM-DOOR-APPEARS ()>
ZG.actions:register("DIM_DOOR_APPEARS", function()

    do local _ = ZG.TELL("It is dark, but on the south wall is a faint outline of a rectangle, as\nthough light were shining around a doorway. You can also make out a faintly\nglowing letter in the center of this area. It might be an \"F\".", ZG._TK.CR) end
    do return ZG.FCLEAR(ZG.DIM_DOOR, "INVISIBLE") end

end, "DIM-DOOR-APPEARS")

ZG.DIM_DOOR_APPEARS = ZG.actions:get("DIM_DOOR_APPEARS")

-- zil: 2actions.zil:662  <ROUTINE CRYPT-OBJECT ()>
ZG.actions:register("CRYPT_OBJECT", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The crypt is sealed for all time.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("RUB")) then
        do return ZG.TELL("The marble is cool.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CRYPT-OBJECT")

ZG.CRYPT_OBJECT = ZG.actions:get("CRYPT_OBJECT")

-- zil: 2actions.zil:666  <ROUTINE CRYPT-DOOR-FCN ()>
ZG.actions:register("CRYPT_DOOR_FCN", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.OPEN_CLOSE(ZG.PRSO, "The crypt door squeaks open.", "The crypt door squeaks closed.") end
    else
        do return false end
    end

end, "CRYPT-DOOR-FCN")

ZG.CRYPT_DOOR_FCN = ZG.actions:get("CRYPT_DOOR_FCN")

-- zil: 2actions.zil:672  <ROUTINE TOMB-PSEUDO ()>
ZG.actions:register("TOMB_PSEUDO", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do local _ = ZG.DO_WALK("EAST") end
        do return true end
    else
        do return false end
    end

end, "TOMB-PSEUDO")

ZG.TOMB_PSEUDO = ZG.actions:get("TOMB_PSEUDO")

-- zil: 2actions.zil:677  <GLOBAL DIM-DOOR-FLAG>
-- DIM_DOOR_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:679  <ROUTINE DIM-DOOR-FCN ()>
ZG.actions:register("DIM_DOOR_FCN", function()

    if ZG._T(ZG.VERB_p("KNOCK")) then
        do return ZG.TELL("A hollow echo responds.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        if ZG._T(ZG.VERB_p("OPEN")) then
            ZG._set("DIM_DOOR_FLAG", true)
        else
            ZG._set("DIM_DOOR_FLAG", false)
        end
        do return ZG.OPEN_CLOSE(ZG.PRSO, "The secret door opens noiselessly.", "The secret door closes noiselessly.") end
    else
        do return false end
    end

end, "DIM-DOOR-FCN")

ZG.DIM_DOOR_FCN = ZG.actions:get("DIM_DOOR_FCN")

-- zil: 2actions.zil:688  <ROUTINE REPELLENT-FCN ()>
ZG.actions:register("REPELLENT_FCN", function()

    if ZG._T(ZG.VERB_p("SHAKE")) then
        if ZG._T(ZG.SPRAY_USED_p) then
            do return ZG.TELL("The can seems empty.", ZG._TK.CR) end
        else
            do return ZG.TELL("There is a sloshing sound from inside.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("SPRAY", "PUT")) and ZG.EQ(ZG.PRSO, ZG.REPELLENT)) then
        if ZG._T(ZG.SPRAY_USED_p) then
            do return ZG.TELL("The repellent is all gone.", ZG._TK.CR) end
        elseif (not ZG._T(ZG.PRSI)) then
            ZG._set("SPRAY_USED_p", true)
            do return ZG.TELL("The spray stinks amazingly for a few moments, then drifts away.", ZG._TK.CR) end
        else
            if ZG.EQ(ZG.PRSI, ZG.ME) then
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SPRAY, 8)) end
                ZG._set("SPRAYED_p", true)
            end
            ZG._set("SPRAY_USED_p", true)
            do return ZG.TELL("The spray smells like a mixture of old socks and burning rubber. If\nI were a grue I'd sure stay clear!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "REPELLENT-FCN")

ZG.REPELLENT_FCN = ZG.actions:get("REPELLENT_FCN")

-- zil: 2actions.zil:709  <GLOBAL SPRAY-USED?>
-- SPRAY_USED_p is declared in ZilGlobal.lua

-- zil: 2actions.zil:711  <ROUTINE I-SPRAY ()>
ZG.actions:register("I_SPRAY", function()

    ZG._set("SPRAYED_p", false)
    do return ZG.TELL("That horrible smell is much less pungent now.", ZG._TK.CR) end

end, "I-SPRAY")

ZG.I_SPRAY = ZG.actions:get("I_SPRAY")

-- zil: 2actions.zil:715  <ROUTINE ZORK3-FCN (RARG)>
ZG.actions:register("ZORK3_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("Beyond the door is a roughly hewn staircase leading down into darkness.\nThe landing on which you stand is covered with carefully drawn magical runes\nlike those sketched upon the workbench of the Wizard of Frobozz.\nThese have been overlaid with sweeping green lines of enormous power, which\nundulate back and forth across the landing. ") end
        if ZG._T(ZG.IN_p(ZG.WAND, ZG.WINNER)) then
            do local _ = ZG.TELL("The wand begins to vibrate in harmony with the motion of the lines.\nYou feel yourself compelled downward, and you yield, stepping onto the\nstaircase. As you pass the green lines, they flare and disappear with a\nburst of light, and you tumble down the staircase!\n\nAt the bottom, a vast red-lit hall stretches off into the distance.\nSinister statues guard the entrance to a dimly visible room far ahead.\nWith courage and cunning you have conquered the Wizard of Frobozz and\nbecome the master of his domain, but the final challenge awaits!\n\n(The ultimate adventure concludes in \"Zork III: The Dungeon Master\".)\n\n", ZG._TK.CR) end
            ZG._set("WON_FLAG", true)
            do return ZG.FINISH() end
        else
            do return ZG.JIGS_UP("The green curves begin to vibrate toward you, as if searching for\nsomething. One by one your possessions glow bright green. Finally, you\nare attacked by these magical wardens, and destroyed!") end
        end
    else
        do return false end
    end

end, "ZORK3-FCN")

ZG.ZORK3_FCN = ZG.actions:get("ZORK3_FCN")

-- ;"SUBTITLE A DROP IN THE BUCKET"

-- zil: 2actions.zil:750  <GLOBAL BUCKET-TOP-FLAG>
-- BUCKET_TOP_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:752  <GLOBAL EVAPORATED>
-- EVAPORATED is declared in ZilGlobal.lua

-- zil: 2actions.zil:754  <ROUTINE I-BUCKET ()>
ZG.actions:register("I_BUCKET", function()

    if ZG._T(ZG.IN_p(ZG.WATER, ZG.BUCKET)) then
        ZG._set("EVAPORATED", true)
        do local _ = ZG.REMOVE(ZG.WATER) end
    end
    do return false end

end, "I-BUCKET")

ZG.I_BUCKET = ZG.actions:get("I_BUCKET")

-- zil: 2actions.zil:760  <ROUTINE WATER-FCN ("AUX" AV W PI?)>
ZG.actions:register("WATER_FCN", function()

    local AV = 0
    local W = 0
    local PI_p = 0
    if ZG._T(ZG.VERB_p("SGIVE")) then
        do return false end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?SWIM"), ZG.PRSO) end
        do return true end
    elseif ZG._T(ZG.VERB_p("FILL")) then
        W = ZG.PRSI
        ZG._set("PRSA", ZG.SYMBOL("V?PUT"))
        ZG._set("PRSI", ZG.PRSO)
        ZG._set("PRSO", W)
        PI_p = false
    elseif ZG.EQUAL_p(ZG.PRSO, ZG.GLOBAL_WATER, ZG.WATER) then
        W = ZG.PRSO
        PI_p = false
    elseif ZG._T(ZG.PRSI) then
        W = ZG.PRSI
        PI_p = true
    end
    if ZG.EQ(W, ZG.GLOBAL_WATER) then
        W = ZG.WATER
        if ZG._T(ZG.VERB_p("TAKE", "PUT")) then
            do local _ = ZG.REMOVE(W) end
        end
    end
    if ZG._T(PI_p) then
        ZG._set("PRSI", W)
    else
        ZG._set("PRSO", W)
    end
    AV = ZG.LOC(ZG.WINNER)
    if (not ZG._T(ZG.FSET_p(AV, "VEHBIT"))) then
        AV = false
    end
    if (ZG._T(ZG.VERB_p("TAKE", "PUT")) and (not ZG._T(PI_p))) then
        if (ZG._T(AV) and ZG.EQ(AV, ZG.PRSI)) then
            do return ZG.PUDDLE(AV) end
        elseif (ZG._T(AV) and (not ZG._T(ZG.PRSI)) and (not ZG._T(ZG.IN_p(W, AV)))) then
            do return ZG.PUDDLE(AV) end
        elseif (ZG._T(ZG.PRSI) and (not ZG.EQ(ZG.PRSI, ZG.TEAPOT))) then
            do local _ = ZG.TELL("The water leaks out of the ", ZG._TK.D, ZG.PRSI, " and evaporates immediately.", ZG._TK.CR) end
            do return ZG.REMOVE(W) end
        elseif ZG._T(ZG.IN_p(ZG.TEAPOT, ZG.WINNER)) then
            if (not ZG._T(ZG.FIRST_p(ZG.TEAPOT))) then
                if ZG.EQ(ZG.HERE, ZG.POOL_ROOM) then
                    do local _ = ZG.MOVE(ZG.SALTY_WATER, ZG.TEAPOT) end
                else
                    do local _ = ZG.MOVE(ZG.WATER, ZG.TEAPOT) end
                end
                do return ZG.TELL("The teapot is now full of water.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The teapot isn't currently empty.", ZG._TK.CR) end
                do return true end
            end
        elseif (ZG._T(ZG.IN_p(ZG.PRSO, ZG.TEAPOT)) and ZG._T(ZG.VERB_p("TAKE")) and (not ZG._T(ZG.PRSI))) then
            ZG._set("PRSO", ZG.TEAPOT)
            do local _ = ZG.ITAKE() end
            ZG._set("PRSO", W)
            do return ZG.PRSO end
        else
            do return ZG.TELL("The water slips through your fingers.", ZG._TK.CR) end
        end
    elseif ZG._T(PI_p) then
        do return ZG.TELL("Nice try.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DROP", "GIVE")) then
        if (ZG.EQ(ZG.PRSO, ZG.WATER) and (not ZG._T(ZG.HELD_p(ZG.WATER)))) then
            do local _ = ZG.TELL("You don't have any water.", ZG._TK.CR) end
            do return true end
        end
        do local _ = ZG.REMOVE(ZG.WATER) end
        if ZG._T(AV) then
            do return ZG.PUDDLE(AV) end
        else
            do local _ = ZG.TELL("The water spills to the floor and evaporates.", ZG._TK.CR) end
            do return ZG.REMOVE(ZG.WATER) end
        end
    elseif ZG._T(ZG.VERB_p("THROW")) then
        do local _ = ZG.TELL("The water splashes on the walls and evaporates.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.WATER) end
    else
        do return false end
    end

end, "WATER-FCN")

ZG.WATER_FCN = ZG.actions:get("WATER_FCN")

-- zil: 2actions.zil:830  <ROUTINE PUDDLE (AV)>
ZG.actions:register("PUDDLE", function(AV)

    do local _ = ZG.TELL("There is now a puddle in the bottom of the ", ZG._TK.D, AV, ".", ZG._TK.CR) end
    do return ZG.MOVE(ZG.PRSO, AV) end

end, "PUDDLE")

ZG.PUDDLE = ZG.actions:get("PUDDLE")

-- zil: 2actions.zil:834  <ROUTINE BUCKET-FCN ("OPTIONAL" (RARG ,M-BEG))>
ZG.actions:register("BUCKET_FCN", function(RARG)

    if RARG == nil then RARG = ZG.M_BEG end
    if ZG.EQ(RARG, ZG.M_BEG) then
        if (ZG._T(ZG.VERB_p("BURN")) and ZG.EQ(ZG.PRSO, ZG.BUCKET)) then
            do return ZG.TELL("The bucket is fireproof, and won't burn.", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("DROP", "PUT")) and ZG.EQ(ZG.PRSO, ZG.WATER) and ZG.EQ(ZG.PRSI, ZG.BUCKET) and ZG._T(ZG.IN_p(ZG.BUCKET, ZG.WELL_BOTTOM)) and (not ZG._T(ZG.IN_p(ZG.WINNER, ZG.BUCKET)))) then
            do local _ = ZG.TELL("The bucket swiftly rises up, and is gone.", ZG._TK.CR) end
            do local _ = ZG.MOVE(ZG.BUCKET, ZG.WELL_TOP) end
            do local _ = ZG.MOVE(ZG.WATER, ZG.BUCKET) end
            ZG._set("BUCKET_TOP_FLAG", true)
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BUCKET, 100)) end
            do return true end
        elseif ZG._T(ZG.VERB_p("KICK")) then
            do return ZG.JIGS_UP("If you insist.") end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_END) then
        if (ZG._T(ZG.IN_p(ZG.WATER, ZG.BUCKET)) and (not ZG._T(ZG.BUCKET_TOP_FLAG))) then
            do local _ = ZG.TELL("The bucket rises and comes to a stop.", ZG._TK.CR, ZG._TK.CR) end
            ZG._set("BUCKET_TOP_FLAG", true)
            ZG._set("EVAPORATED", false)
            do local _ = ZG.PASS_THE_BUCKET(ZG.WELL_TOP) end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BUCKET, 100)) end
            do return true end
        elseif (ZG._T(ZG.BUCKET_TOP_FLAG) and (not ZG._T(ZG.IN_p(ZG.WATER, ZG.BUCKET)))) then
            if ZG._T(ZG.EVAPORATED) then
                do local _ = ZG.TELL("The last of the water evaporates, and the bucket descends.", ZG._TK.CR, ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The bucket descends and comes to a stop.", ZG._TK.CR, ZG._TK.CR) end
            end
            ZG._set("BUCKET_TOP_FLAG", false)
            do return ZG.PASS_THE_BUCKET(ZG.WELL_BOTTOM) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("CLIMB-ON")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?BOARD"), ZG.PRSO) end
        do return true end
    else
        do return false end
    end

end, "BUCKET-FCN")

ZG.BUCKET_FCN = ZG.actions:get("BUCKET_FCN")

-- zil: 2actions.zil:876  <ROUTINE PASS-THE-BUCKET (R)>
ZG.actions:register("PASS_THE_BUCKET", function(R)

    do local _ = ZG.MOVE(ZG.BUCKET, R) end
    if ZG._T(ZG.IN_p(ZG.WINNER, ZG.BUCKET)) then
        do return ZG.GOTO(R) end
    else
        do return false end
    end

end, "PASS-THE-BUCKET")

ZG.PASS_THE_BUCKET = ZG.actions:get("PASS_THE_BUCKET")

-- ;"SUBTITLE CHOMPERS IN WONDERLAND"

-- zil: 2actions.zil:886  <ROUTINE POSTS-ROOM-FCN (RARG)>
ZG.actions:register("POSTS_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_BEG) then
        if (ZG._T(ZG.VERB_p("TAKE")) and ZG._T(ZG.FSET_p(ZG.PRSO, "NONLANDBIT"))) then
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is now much larger than you are. You have no hope of\ntaking it.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "POSTS-ROOM-FCN")

ZG.POSTS_ROOM_FCN = ZG.actions:get("POSTS_ROOM_FCN")

-- zil: 2actions.zil:893  <ROUTINE EATME-FCN ("AUX" F N)>
ZG.actions:register("EATME_FCN", function()

    local F = 0
    local N = 0
    if (ZG._T(ZG.VERB_p("EAT")) and ZG.EQ(ZG.PRSO, ZG.EAT_ME_CAKE) and ZG.EQ(ZG.HERE, ZG.TEA_ROOM)) then
        do local _ = ZG.TELL("Suddenly, the room appears to have become very large (although\neverything you are carrying seems to be its normal size).", ZG._TK.CR, ZG._TK.CR) end
        do local _ = ZG.REMOVE(ZG.EAT_ME_CAKE) end
        do local _ = ZG.FSET(ZG.ROBOT, "INVISIBLE") end
        do local _ = ZG.FSET(ZG.ALICE_TABLE, "INVISIBLE") end
        F = ZG.FIRST_p(ZG.HERE)
        while true do
            if (not ZG._T(F)) then
                break
            else
                N = ZG.NEXT_p(F)
                if ((not ZG.EQ(F, ZG.ADVENTURER)) and ZG._T(ZG.FSET_p(F, "TAKEBIT"))) then
                    do local _ = ZG.FSET(F, "NONLANDBIT") end
                    do local _ = ZG.FSET(F, "TRYTAKEBIT") end
                    do local _ = ZG.MOVE(F, ZG.POSTS_ROOM) end
                end
            end
            F = N
        end
        do return ZG.GOTO(ZG.POSTS_ROOM) end
    else
        do return ZG.CAKE_CRUMBLE() end
    end

end, "EATME-FCN")

ZG.EATME_FCN = ZG.actions:get("EATME_FCN")

-- zil: 2actions.zil:917  <ROUTINE CAKE-CRUMBLE ("AUX" CAKE)>
ZG.actions:register("CAKE_CRUMBLE", function()

    local CAKE = 0
    if ZG._T(ZG.FSET_p(ZG.PRSO, "FOODBIT")) then
        CAKE = ZG.PRSO
    else
        CAKE = ZG.PRSI
    end
    if (ZG.EQUAL_p(ZG.HERE, ZG.TEA_ROOM, ZG.POSTS_ROOM, ZG.POOL_ROOM) or ZG.EQUAL_p(ZG.HERE, ZG.MACHINE_ROOM, ZG.MAGNET_ROOM, ZG.CAGE_ROOM) or ZG.EQUAL_p(ZG.HERE, ZG.WELL_TOP, ZG.IN_CAGE)) then
        do return false end
    else
        do local _ = ZG.REMOVE(CAKE) end
        do return ZG.TELL("The ", ZG._TK.D, CAKE, " has crumbled to dust.", ZG._TK.CR) end
    end

end, "CAKE-CRUMBLE")

ZG.CAKE_CRUMBLE = ZG.actions:get("CAKE_CRUMBLE")

-- zil: 2actions.zil:929  <ROUTINE CAKE-FCN ("AUX" F N)>
ZG.actions:register("CAKE_FCN", function()

    local F = 0
    local N = 0
    if ZG._T(ZG.VERB_p("READ")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "NONLANDBIT")) then
            do return ZG.TELL("The cake is much too tall now for you to read the lettering.", ZG._TK.CR) end
        elseif ZG._T(ZG.PRSI) then
            if ZG.EQUAL_p(ZG.PRSI, ZG.PALANTIR_1, ZG.PALANTIR_2, ZG.PALANTIR_3) then
                do return ZG.PERFORM(ZG.SYMBOL("V?LOOK-INSIDE"), ZG.PRSI) end
            elseif ZG.EQ(ZG.PRSI, ZG.FLASK) then
                do local _ = ZG.TELL("The letters, now visible, say \"") end
                if ZG.EQ(ZG.PRSO, ZG.RED_ICING) then
                    do local _ = ZG.TELL("Evaporate") end
                elseif ZG.EQ(ZG.PRSO, ZG.ORANGE_ICING) then
                    do local _ = ZG.TELL("Explode") end
                else
                    do local _ = ZG.TELL("Enlarge") end
                end
                do return ZG.TELL("\".", ZG._TK.CR) end
            else
                do return ZG.TELL("You can't see through that!", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("The first letter is a capital E. The rest is too small to read.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("EAT")) and ZG.EQUAL_p(ZG.HERE, ZG.TEA_ROOM, ZG.POSTS_ROOM, ZG.POOL_ROOM)) then
        if ZG.EQ(ZG.PRSO, ZG.ORANGE_ICING) then
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do return ZG.ICEBOOM() end
        elseif ZG.EQ(ZG.PRSO, ZG.RED_ICING) then
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do return ZG.JIGS_UP("That was delicious, but your dying memory is of feeling horribly dehydrated\nand thirsty.") end
        elseif ZG.EQ(ZG.PRSO, ZG.BLUE_ICING) then
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do local _ = ZG.TELL("The room around you seems to be getting smaller.", ZG._TK.CR, ZG._TK.CR) end
            if ZG.EQ(ZG.HERE, ZG.POSTS_ROOM) then
                do local _ = ZG.FCLEAR(ZG.ROBOT, "INVISIBLE") end
                do local _ = ZG.FCLEAR(ZG.ALICE_TABLE, "INVISIBLE") end
                do local _ = ZG.FSET(ZG.POSTS, "INVISIBLE") end
                F = ZG.FIRST_p(ZG.HERE)
                while true do
                    if (not ZG._T(F)) then
                        break
                    else
                        N = ZG.NEXT_p(F)
                        if ((not ZG.EQ(F, ZG.ADVENTURER)) and ZG._T(ZG.FSET_p(F, "TAKEBIT"))) then
                            do local _ = ZG.FCLEAR(F, "NONLANDBIT") end
                            do local _ = ZG.FCLEAR(F, "TRYTAKEBIT") end
                            do local _ = ZG.MOVE(F, ZG.TEA_ROOM) end
                        end
                    end
                    F = N
                end
                do return ZG.GOTO(ZG.TEA_ROOM) end
            else
                do return ZG.JIGS_UP("The room seems to have become too small to hold you. The walls are not as\ncompressible as your body, which is demolished.") end
            end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("THROW", "PUT")) and ZG.EQ(ZG.PRSO, ZG.ORANGE_ICING) and ZG.EQUAL_p(ZG.HERE, ZG.TEA_ROOM, ZG.POSTS_ROOM, ZG.POOL_ROOM)) then
        do local _ = ZG.REMOVE(ZG.PRSO) end
        do return ZG.ICEBOOM() end
    elseif (ZG._T(ZG.VERB_p("THROW", "PUT")) and ZG.EQUAL_p(ZG.PRSO, ZG.RED_ICING, ZG.BLUE_ICING, ZG.ORANGE_ICING) and ZG.EQ(ZG.PRSI, ZG.POOL)) then
        if ZG.EQUAL_p(ZG.PRSO, ZG.BLUE_ICING, ZG.ORANGE_ICING) then
            do local _ = ZG.TELL("The cake sinks majestically into the pool.", ZG._TK.CR) end
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do return true end
        end
        do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
        do local _ = ZG.REMOVE(ZG.PRSI) end
        do local _ = ZG.TELL("Most of the pool evaporates, revealing a (slightly damp but\nstill valuable) package of rare candies. The red cake must be\npretty strong stuff, since it remains intact!", ZG._TK.CR) end
        do return ZG.FCLEAR(ZG.CANDY, "INVISIBLE") end
    else
        do return ZG.CAKE_CRUMBLE() end
    end

end, "CAKE-FCN")

ZG.CAKE_FCN = ZG.actions:get("CAKE_FCN")

-- zil: 2actions.zil:1003  <ROUTINE CANDY-FCN ()>
ZG.actions:register("CANDY_FCN", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        do local _ = ZG.FIXED_FONT_ON() end
        do local _ = ZG.TELL("       Frobozz Magic Candy Company\n         >>Special Assortment<<\n          Candied Grasshoppers\n             Chocolated Ants\n              Worms Glacee\n(By Appointment to His Majesty, Dimwit I)\n") end
        do local _ = ZG.FIXED_FONT_OFF() end
        do return true end
    elseif ZG._T(ZG.VERB_p("EAT", "OPEN")) then
        do return ZG.TELL("Such rich food would probably not be good for you.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CANDY-FCN")

ZG.CANDY_FCN = ZG.actions:get("CANDY_FCN")

-- zil: 2actions.zil:1020  <ROUTINE TOP-ETCHINGS-F ()>
ZG.actions:register("TOP_ETCHINGS_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        do local _ = ZG.FIXED_FONT_ON() end
        do local _ = ZG.TELL("       o  b  o\n   r             z\nf   M  A  G  I  C   z\nc    W  E   L  L    y\n   o             n\n       m  p  a\n") end
        do local _ = ZG.FIXED_FONT_OFF() end
        do return true end
    else
        do return false end
    end

end, "TOP-ETCHINGS-F")

ZG.TOP_ETCHINGS_F = ZG.actions:get("TOP_ETCHINGS_F")

-- zil: 2actions.zil:1034  <ROUTINE BOTTOM-ETCHINGS-F ()>
ZG.actions:register("BOTTOM_ETCHINGS_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        do local _ = ZG.FIXED_FONT_ON() end
        do local _ = ZG.TELL("       o  b  o\n\n       A  G  I\n        E   L\n\n       m  p  a\n") end
        do local _ = ZG.FIXED_FONT_OFF() end
        do return true end
    else
        do return false end
    end

end, "BOTTOM-ETCHINGS-F")

ZG.BOTTOM_ETCHINGS_F = ZG.actions:get("BOTTOM_ETCHINGS_F")

-- zil: 2actions.zil:1048  <ROUTINE CUBE-F ()>
ZG.actions:register("CUBE_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        do local _ = ZG.FIXED_FONT_ON() end
        do local _ = ZG.TELL("              Bank of Zork\n                   VAULT\n                 *722 GUE*\n        Frobozz Magic Vault Company\n") end
        do local _ = ZG.FIXED_FONT_OFF() end
        do return true end
    else
        do return false end
    end

end, "CUBE-F")

ZG.CUBE_F = ZG.actions:get("CUBE_F")

-- zil: 2actions.zil:1060  <ROUTINE FIXED-FONT-ON ()>
ZG.actions:register("FIXED_FONT_ON", function()

    do return ZG.PUT(0, 8, ZG.BOR(ZG.GET(0, 8), 2)) end

end, "FIXED-FONT-ON")

ZG.FIXED_FONT_ON = ZG.actions:get("FIXED_FONT_ON")

-- zil: 2actions.zil:1062  <ROUTINE FIXED-FONT-OFF ()>
ZG.actions:register("FIXED_FONT_OFF", function()

    do return ZG.PUT(0, 8, ZG.BAND(ZG.GET(0, 8), -3)) end

end, "FIXED-FONT-OFF")

ZG.FIXED_FONT_OFF = ZG.actions:get("FIXED_FONT_OFF")

-- zil: 2actions.zil:1064  <ROUTINE POOL-FCN ()>
ZG.actions:register("POOL_FCN", function()

    if ZG._T(ZG.VERB_p("DRINK")) then
        do return ZG.TELL("The water is extremely salty.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-UNDER")) then
        do return ZG.TELL("You'd probably have to enter the pool to see what's below the surface.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.JIGS_UP("You enter the pool, thrash around for a good while, and then drown.\nSad, but true.") end
    else
        do return false end
    end

end, "POOL-FCN")

ZG.POOL_FCN = ZG.actions:get("POOL_FCN")

-- zil: 2actions.zil:1076  <ROUTINE FLASK-FCN ()>
ZG.actions:register("FLASK_FCN", function()

    if ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do return ZG.TELL("You notice that objects behind the flask appear to be magnified.\nYou might try looking at something through the flask.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("READ")) and ZG.EQ(ZG.PRSI, ZG.FLASK)) then
        do local _ = ZG.TELL("The flask distorts and magnifies the ", ZG._TK.D, ZG.PRSO, ", showing details\nnot noticed earlier.", ZG._TK.CR) end
        do return false end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        do local _ = ZG.MUNG_ROOM(ZG.HERE, "Noxious vapors prevent your entry.") end
        do return ZG.JIGS_UP(ZG.FATAL_VAPORS) end
    elseif ZG._T(ZG.VERB_p("MUNG", "THROW")) then
        do local _ = ZG.TELL("The flask breaks into pieces.", ZG._TK.CR) end
        do local _ = ZG.REMOVE(ZG.PRSO) end
        do return ZG.JIGS_UP(ZG.FATAL_VAPORS) end
    else
        do return false end
    end

end, "FLASK-FCN")

ZG.FLASK_FCN = ZG.actions:get("FLASK_FCN")

-- zil: 2actions.zil:1094  <GLOBAL FATAL-VAPORS>
-- FATAL_VAPORS is declared in ZilGlobal.lua

-- zil: 2actions.zil:1098  <ROUTINE PLEAK ()>
ZG.actions:register("PLEAK", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL(ZG.PICK_ONE(ZG.YUKS), ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PLUG")) then
        do return ZG.TELL("The leak is too high above you to reach.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PLEAK")

ZG.PLEAK = ZG.actions:get("PLEAK")

-- zil: 2actions.zil:1104  <ROUTINE ICEBOOM ()>
ZG.actions:register("ICEBOOM", function()

    do local _ = ZG.MUNG_ROOM(ZG.HERE, "The entrance is blocked by sticky orange rubble. Probably some careless\nadventurer was playing with blasting cakes.") end
    do return ZG.JIGS_UP("You have been blasted to smithereens (wherever they are).") end

end, "ICEBOOM")

ZG.ICEBOOM = ZG.actions:get("ICEBOOM")

-- zil: 2actions.zil:1111  <ROUTINE MAGNET-ROOM-FCN (RARG)>
ZG.actions:register("MAGNET_ROOM_FCN", function(RARG)

    local _tmp1, _tmp2
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.TELL("You are in a circular room with a low ceiling. There are exits to\nthe east and southeast.", ZG._TK.CR) end
    elseif (ZG.EQ(RARG, ZG.M_ENTER) and ZG._T(ZG.CAROUSEL_FLIP_FLAG)) then
        if ZG._T(ZG.CAROUSEL_ZOOM_FLAG) then
            if ZG.EQ(ZG.ADVENTURER, ZG.WINNER) then
                _tmp1 = "According to Prof. TAA of GUE Tech, the rapidly changing magnetic\nfields in the room are intense enough to electrocute you.\nI really don't know, but in any event, something just killed you."
            else
                _tmp1 = "According to Prof. TAA of GUE Tech, the magnetic fields in the room are\nintense enough to fry the delicate innards of the robot. I really don't\nknow, but in any event, smoke pours from its ears and it has stopped moving."
            end
            if ZG.EQ(ZG.ADVENTURER, ZG.WINNER) then
                _tmp2 = "According to Prof. TAA of GUE Tech, the rapidly changing magnetic\nfields in the room are intense enough to electrocute you.\nI really don't know, but in any event, something just killed you."
            else
                _tmp2 = "According to Prof. TAA of GUE Tech, the magnetic fields in the room are\nintense enough to fry the delicate innards of the robot. I really don't\nknow, but in any event, smoke pours from its ears and it has stopped moving."
            end
            do return ZG.JIGS_UP(_tmp2) end
        elseif ZG.EQ(ZG.WINNER, ZG.ADVENTURER) then
            do local _ = ZG.TELL("As you enter, your compass starts spinning wildly.", ZG._TK.CR) end
            if (not ZG._T(ZG.COMPASS_KLUDGE)) then
                do local _ = ZG.TELL("What compass, you ask? The one which allows you to specify compass directions\nfor movement.") end
                ZG._set("COMPASS_KLUDGE", true)
            end
            do return ZG.CRLF() end
        else
            do return false end
        end
    else
        do return false end
    end

end, "MAGNET-ROOM-FCN")

ZG.MAGNET_ROOM_FCN = ZG.actions:get("MAGNET_ROOM_FCN")

-- zil: 2actions.zil:1137  <GLOBAL COMPASS-KLUDGE>
-- COMPASS_KLUDGE is declared in ZilGlobal.lua

-- zil: 2actions.zil:1139  <ROUTINE MAGNET-ROOM-EXIT ()>
ZG.actions:register("MAGNET_ROOM_EXIT", function()

    if (ZG._T(ZG.CAROUSEL_FLIP_FLAG) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
        do local _ = ZG.TELL("You cannot get your bearings...", ZG._TK.CR, ZG._TK.CR) end
        if ZG._T(ZG.PROB(50)) then
            do return ZG.MACHINE_ROOM end
        else
            do return ZG.TEA_ROOM end
        end
    elseif ZG.EQ(ZG.PRSO, "EAST") then
        do return ZG.MACHINE_ROOM end
    elseif (ZG.EQ(ZG.PRSO, "SE") or ZG.EQ(ZG.PRSO, "OUT")) then
        do return ZG.TEA_ROOM end
    else
        do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
        do return false end
    end

end, "MAGNET-ROOM-EXIT")

ZG.MAGNET_ROOM_EXIT = ZG.actions:get("MAGNET_ROOM_EXIT")

-- zil: 2actions.zil:1155  <GLOBAL CAROUSEL-ZOOM-FLAG>
-- CAROUSEL_ZOOM_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1157  <GLOBAL CAROUSEL-FLIP-FLAG>
-- CAROUSEL_FLIP_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1159  <ROUTINE BUTTONS ()>
ZG.actions:register("BUTTONS", function()

    if ZG._T(ZG.VERB_p("PUSH")) then
        if ZG.EQ(ZG.WINNER, ZG.ADVENTURER) then
            do return ZG.JIGS_UP("There is a giant spark and you are fried to a crisp.") end
        elseif ZG.EQ(ZG.PRSO, ZG.SQUARE_BUTTON) then
            if ZG._T(ZG.CAROUSEL_ZOOM_FLAG) then
                do return ZG.TELL("Nothing seems to happen.", ZG._TK.CR) end
            else
                ZG._set("CAROUSEL_ZOOM_FLAG", true)
                do return ZG.TELL("The whirring increases in intensity.", ZG._TK.CR) end
            end
        elseif ZG.EQ(ZG.PRSO, ZG.ROUND_BUTTON) then
            if ZG._T(ZG.CAROUSEL_ZOOM_FLAG) then
                ZG._set("CAROUSEL_ZOOM_FLAG", false)
                do return ZG.TELL("The whirring decreases in intensity.", ZG._TK.CR) end
            else
                do return ZG.TELL("Nothing seems to happen.", ZG._TK.CR) end
            end
        elseif ZG.EQ(ZG.PRSO, ZG.TRIANGULAR_BUTTON) then
            ZG._set("CAROUSEL_FLIP_FLAG", (not ZG._T(ZG.CAROUSEL_FLIP_FLAG)))
            if ZG._T(ZG.IN_p(ZG.IRON_BOX, ZG.CAROUSEL_ROOM)) then
                do local _ = ZG.TELL("A dull thump is heard in the distance.", ZG._TK.CR) end
                if ZG._T(ZG.FSET_p(ZG.IRON_BOX, "INVISIBLE")) then
                    do local _ = ZG.FCLEAR(ZG.IRON_BOX, "INVISIBLE") end
                else
                    do local _ = ZG.FSET(ZG.IRON_BOX, "INVISIBLE") end
                end
                if (not ZG._T(ZG.FSET_p(ZG.IRON_BOX, "INVISIBLE"))) then
                    do local _ = ZG.FCLEAR(ZG.CAROUSEL_ROOM, "TOUCHBIT") end
                end
                do return true end
            else
                do return ZG.TELL("Click.", ZG._TK.CR) end
            end
        else
            do return false end
        end
    else
        do return false end
    end

end, "BUTTONS")

ZG.BUTTONS = ZG.actions:get("BUTTONS")

-- zil: 2actions.zil:1190  <GLOBAL CAGE-SOLVE-FLAG>
-- CAGE_SOLVE_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1192  <ROUTINE SPHERE-FCN ("AUX" FL)>
ZG.actions:register("SPHERE_FCN", function()

    local FL = 0
    if ((not ZG._T(ZG.CAGE_SOLVE_FLAG)) and ZG._T(ZG.VERB_p("TAKE", "MOVE", "PUT"))) then
        FL = true
    else
        FL = false
    end
    if (ZG._T(FL) and ZG.EQ(ZG.ADVENTURER, ZG.WINNER)) then
        do local _ = ZG.TELL("As you reach for the sphere, a solid steel cage falls from the ceiling\nto entrap you. To make matters worse, poisonous gas starts coming\ninto the room.", ZG._TK.CR, ZG._TK.CR) end
        if ZG._T(ZG.IN_p(ZG.ROBOT, ZG.HERE)) then
            do local _ = ZG.MOVE(ZG.ROBOT, ZG.IN_CAGE) end
            do local _ = ZG.FSET(ZG.ROBOT, "NDESCBIT") end
        end
        do local _ = ZG.GOTO(ZG.IN_CAGE) end
        do local _ = ZG.MOVE(ZG.CAGE, ZG.HERE) end
        do local _ = ZG.FSET(ZG.CAGE, "NDESCBIT") end
        do local _ = ZG.FCLEAR(ZG.CAGE, "INVISIBLE") end
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SPHERE, 6)) end
        do return true end
    elseif ZG._T(FL) then
        do local _ = ZG.FSET(ZG.PALANTIR_1, "INVISIBLE") end
        do local _ = ZG.REMOVE(ZG.ROBOT) end
        do local _ = ZG.FSET(ZG.PRSO, "INVISIBLE") end
        do local _ = ZG.MOVE(ZG.CAGE, ZG.CAGE_ROOM) end
        do local _ = ZG.FCLEAR(ZG.CAGE, "INVISIBLE") end
        do local _ = ZG.JIGS_UP("As the robot reaches for the sphere, a solid steel cage falls from the\nceiling, trapping him. You can faintly hear his last words: \"Whirr,\nbuzz, click!\" A cloud of smoke rising from beneath the cage confirms\nyour fears about the fate of your brave mechanical friend.") end
        do return true end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE", "EXAMINE")) then
        do return ZG.PALANTIR() end
    else
        do return false end
    end

end, "SPHERE-FCN")

ZG.SPHERE_FCN = ZG.actions:get("SPHERE_FCN")

-- zil: 2actions.zil:1226  <ROUTINE I-SPHERE ()>
ZG.actions:register("I_SPHERE", function()

    if ZG.EQUAL_p(ZG.HERE, ZG.CAGE_ROOM, ZG.IN_CAGE) then
        do local _ = ZG.FSET(ZG.PALANTIR_1, "INVISIBLE") end
        do local _ = ZG.MUNG_ROOM(ZG.CAGE_ROOM, "You are stopped by a cloud of poisonous gas.") end
        do return ZG.JIGS_UP("Time passes...and you die from some obscure poisoning.") end
    else
        do return false end
    end

end, "I-SPHERE")

ZG.I_SPHERE = ZG.actions:get("I_SPHERE")

-- zil: 2actions.zil:1234  <ROUTINE IN-CAGE-FCN (RARG)>
ZG.actions:register("IN_CAGE_FCN", function(RARG)

    if ZG._T(ZG.CAGE_SOLVE_FLAG) then
        ZG._set("HERE", ZG.CAGE_ROOM)
        do return ZG.HERE end
    else
        do return false end
    end

end, "IN-CAGE-FCN")

ZG.IN_CAGE_FCN = ZG.actions:get("IN_CAGE_FCN")

-- zil: 2actions.zil:1237  <ROUTINE ROBOT-FCN ("OPTIONAL" (RARG ,M-OBJECT))>
ZG.actions:register("ROBOT_FCN", function(RARG)

    local _tmp1, _tmp2
    if RARG == nil then RARG = ZG.M_OBJECT end
    if ZG.EQ(ZG.WINNER, ZG.ROBOT) then
        if ZG._T(ZG.VERB_p("SGIVE")) then
            do return false end
        elseif ZG._T(ZG.VERB_p("FOLLOW")) then
            do return ZG.TELL("\"My memory circuits are not that advanced. I can move as directed,\nthough.\"", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("RAISE", "TAKE", "MOVE")) and ZG.EQ(ZG.PRSO, ZG.CAGE)) then
            do local _ = ZG.TELL("The cage shakes and is hurled across the room. It's hard to\nsay, but the robot appears to be smiling.", ZG._TK.CR, ZG._TK.CR) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_SPHERE)) end
            ZG._set("WINNER", ZG.ADVENTURER)
            do local _ = ZG.GOTO(ZG.CAGE_ROOM) end
            do local _ = ZG.MOVE(ZG.MANGLED_CAGE, ZG.CAGE_ROOM) end
            do local _ = ZG.FCLEAR(ZG.ROBOT, "NDESCBIT") end
            do local _ = ZG.FSET(ZG.PALANTIR_1, "TAKEBIT") end
            do local _ = ZG.MOVE(ZG.ROBOT, ZG.CAGE_ROOM) end
            ZG._set("CAGE_SOLVE_FLAG", true)
            do return ZG.CAGE_SOLVE_FLAG end
        elseif ZG._T(ZG.VERB_p("EAT", "DRINK")) then
            if ZG._T(ZG.IN_p(ZG.ADVENTURER, ZG.HERE)) then
                do local _ = ZG.TELL("\"I am sorry but that is difficult for a being with no mouth.\"", ZG._TK.CR) end
            end
            do return true end
        elseif (ZG._T(ZG.PROB(2)) and ZG.EQ(ZG.META_LOC(ZG.ADVENTURER), ZG.HERE)) then
            do return ZG.TELL("\"Buzz! Buzz! Buzz! My circuits are getting rusty. Try again.\"", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("READ", "EXAMINE")) then
            if ZG.EQ(ZG.META_LOC(ZG.ADVENTURER), ZG.HERE) then
                do local _ = ZG.TELL("\"My vision is not sufficiently acute to do that.\"", ZG._TK.CR) end
            end
            do return true end
        elseif ZG._T(ZG.VERB_p("DROP", "PUT", "THROW")) then
            if (not ZG.EQ(ZG.META_LOC(ZG.ADVENTURER), ZG.HERE)) then
                do return false end
            elseif ZG._T(ZG.IN_p(ZG.PRSO, ZG.ROBOT)) then
                do local _ = ZG.TELL("\"Whirr, buzz, click!\"", ZG._TK.CR) end
                do return false end
            else
                do return ZG.TELL("\"Click! I don't have that. Buzz! Whirr!\"", ZG._TK.CR) end
            end
        elseif (ZG._T(ZG.VERB_p("WALK")) or (ZG._T(ZG.VERB_p("TAKE", "PUSH", "TURN")) and (not ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT"))))) then
            if (not ZG.EQ(ZG.META_LOC(ZG.ADVENTURER), ZG.HERE)) then
                do return false end
            elseif ZG._T(ZG.PROB(80)) then
                do local _ = ZG.TELL("\"Whirr, buzz, click!\"", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("\"Buzz, click, whirr!\"", ZG._TK.CR) end
            end
            do return false end
        else
            if ZG.EQ(ZG.META_LOC(ZG.ADVENTURER), ZG.HERE) then
                do local _ = ZG.TELL("\"My programming is insufficient to allow me to perform that task.\"", ZG._TK.CR) end
            end
            do return true end
        end
    elseif ZG._T(ZG.VERB_p("OPEN", "LOOK-INSIDE", "CLOSE")) then
        do return ZG.TELL("There's no access panel or door on the robot.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.ROBOT)) then
        do local _ = ZG.MOVE(ZG.PRSO, ZG.ROBOT) end
        do return ZG.TELL("The robot gladly takes the ", ZG._TK.D, ZG.PRSO, " and nods his head-like appendage in thanks.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROW", "MUNG")) then
        do local _ = ZG.TELL("The robot falls to the ground and (being of shoddy construction)\ndisintegrates before your eyes.", ZG._TK.CR) end
        if ZG._T(ZG.VERB_p("THROW")) then
            _tmp1 = ZG.PRSI
        elseif ZG._T(ZG.PRSO) then
            _tmp1 = true
        else
            _tmp1 = false
        end
        if ZG._T(ZG.VERB_p("THROW")) then
            _tmp2 = ZG.PRSI
        elseif ZG._T(ZG.PRSO) then
            _tmp2 = true
        else
            _tmp2 = false
        end
        do return ZG.REMOVE(_tmp2) end
    else
        do return false end
    end

end, "ROBOT-FCN")

ZG.ROBOT_FCN = ZG.actions:get("ROBOT_FCN")

-- ;"SUBTITLE BANK OF ZORK"

-- zil: 2actions.zil:1312  <GLOBAL BANK-SOLVE-FLAG>
-- BANK_SOLVE_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1314  <ROUTINE BILLS-OBJECT ()>
ZG.actions:register("BILLS_OBJECT", function()

    ZG._set("BANK_SOLVE_FLAG", true)
    if ZG._T(ZG.VERB_p("BURN")) then
        do local _ = ZG.TELL("Nothing like having money to burn!", ZG._TK.CR) end
        do return false end
    elseif ZG._T(ZG.VERB_p("EAT")) then
        do return ZG.TELL("Talk about eating rich foods!", ZG._TK.CR) end
    else
        do return false end
    end

end, "BILLS-OBJECT")

ZG.BILLS_OBJECT = ZG.actions:get("BILLS_OBJECT")

-- zil: 2actions.zil:1322  <ROUTINE BKLEAVEE ("OPTIONAL" (RM ,TELLER-EAST))>
ZG.actions:register("BKLEAVEE", function(RM)

    if RM == nil then RM = ZG.TELLER_EAST end
    if (ZG._T(ZG.HELD_p(ZG.BILLS)) or ZG._T(ZG.HELD_p(ZG.PORTRAIT))) then
        do local _ = ZG.TELL("An alarm rings briefly, and an invisible force bars your way.", ZG._TK.CR) end
        do return false end
    else
        do return RM end
    end

end, "BKLEAVEE")

ZG.BKLEAVEE = ZG.actions:get("BKLEAVEE")

-- zil: 2actions.zil:1330  <ROUTINE BKLEAVEW ()>
ZG.actions:register("BKLEAVEW", function()

    do return ZG.BKLEAVEE(ZG.TELLER_WEST) end

end, "BKLEAVEW")

ZG.BKLEAVEW = ZG.actions:get("BKLEAVEW")

-- zil: 2actions.zil:1333  <GLOBAL SCOL-ROOMS>
-- SCOL_ROOMS is declared in ZilGlobal.lua

-- zil: 2actions.zil:1343  <GLOBAL SCOL-WALLS>
-- SCOL_WALLS is declared in ZilGlobal.lua

-- zil: 2actions.zil:1357  <GLOBAL SCOL-ROOM>
-- SCOL_ROOM is declared in ZilGlobal.lua

-- zil: 2actions.zil:1359  <ROUTINE DEPOSITORY-FCN (RARG)>
ZG.actions:register("DEPOSITORY_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        ZG._set("SCOL_ROOM", ZG.LKP(ZG.PRSO, ZG.SCOL_ROOMS))
        do return ZG.SCOL_ROOM end
    else
        do return false end
    end

end, "DEPOSITORY-FCN")

ZG.DEPOSITORY_FCN = ZG.actions:get("DEPOSITORY_FCN")

-- zil: 2actions.zil:1363  <ROUTINE TELLER-ROOM (RARG)>
ZG.actions:register("TELLER_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a small room, which was used by a bank officer who retrieved\nsafety deposit boxes for the customer. On the north side of the room is a\nsign which reads  \"Viewing Room\". On the ") end
        if ZG.EQ(ZG.HERE, ZG.TELLER_WEST) then
            do local _ = ZG.TELL("west") end
        else
            do local _ = ZG.TELL("east") end
        end
        do return ZG.TELL(" side of the room, above an open door, is a sign reading:\n\n          BANK PERSONNEL ONLY\n", ZG._TK.CR) end
    else
        do return false end
    end

end, "TELLER-ROOM")

ZG.TELLER_ROOM = ZG.actions:get("TELLER_ROOM")

-- zil: 2actions.zil:1376  <ROUTINE SCOL-OBJECT ("OPTIONAL" (OBJ <>))>
ZG.actions:register("SCOL_OBJECT", function(OBJ)

    if OBJ == nil then OBJ = false end
    if ZG._T(ZG.VERB_p("PUSH", "MOVE", "TAKE", "RUB")) then
        do return ZG.TELL("As you try, your hand seems to go through it.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("ATTACK")) and ZG._T(ZG.PRSI)) then
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSI, " goes through it.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("THROW", "OVERBOARD")) and ZG.EQUAL_p(ZG.PRSI, ZG.CURTAIN, OBJ)) then
        if ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER)) then
            do return ZG.V_THROUGH(ZG.PRSO) end
        else
            do return ZG.TELL("You don't have that!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SCOL-OBJECT")

ZG.SCOL_OBJECT = ZG.actions:get("SCOL_OBJECT")

-- zil: 2actions.zil:1386  <ROUTINE GET-WALL (RM "AUX" W)>
ZG.actions:register("GET_WALL", function(RM)

    local W = 0
    W = ZG.SCOL_WALLS
    while true do
        if ZG.EQ(ZG.GET(W, 0), RM) then
            do return W end
        else
            W = ZG.REST(W, 6)
        end
    end

end, "GET-WALL")

ZG.GET_WALL = ZG.actions:get("GET_WALL")

-- zil: 2actions.zil:1394  <ROUTINE SCOLWALL ()>
ZG.actions:register("SCOLWALL", function()

    if (ZG._T(ZG.VERB_p("THROW", "OVERBOARD", "PUT")) and ZG.EQ(ZG.HERE, ZG.SCOL_ACTIVE) and ZG.EQ(ZG.PRSI, ZG.GET(ZG.GET_WALL(ZG.HERE), 1))) then
        do return ZG.SCOL_OBJECT(ZG.PRSI) end
    else
        do return false end
    end

end, "SCOLWALL")

ZG.SCOLWALL = ZG.actions:get("SCOLWALL")

-- zil: 2actions.zil:1400  <ROUTINE SCOL-GO (OBJ)>
ZG.actions:register("SCOL_GO", function(OBJ)

    ZG._set("SCOL_ACTIVE", ZG.SCOL_ROOM)
    if ZG._T(OBJ) then
        do return ZG.SCOL_OBJ(OBJ, 0, ZG.SCOL_ROOM) end
    else
        do return ZG.SCOL_THROUGH(12, ZG.SCOL_ROOM) end
    end

end, "SCOL-GO")

ZG.SCOL_GO = ZG.actions:get("SCOL_GO")

-- zil: 2actions.zil:1407  <ROUTINE SCOL-OBJ (OBJ CINT RM)>
ZG.actions:register("SCOL_OBJ", function(OBJ, CINT, RM)

    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CURTAIN, CINT)) end
    do local _ = ZG.MOVE(OBJ, RM) end
    if ZG.EQ(RM, ZG.DEPOSITORY) then
        do return ZG.TELL("The ", ZG._TK.D, OBJ, " passes through the wall and vanishes.", ZG._TK.CR) end
    else
        do local _ = ZG.TELL("The curtain dims slightly as the ", ZG._TK.D, OBJ, " passes through.", ZG._TK.CR) end
        ZG._set("SCOL_ROOM", false)
        do return true end
    end

end, "SCOL-OBJ")

ZG.SCOL_OBJ = ZG.actions:get("SCOL_OBJ")

-- zil: 2actions.zil:1419  <ROUTINE SCOL-THROUGH (CINT RM)>
ZG.actions:register("SCOL_THROUGH", function(CINT, RM)

    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CURTAIN, CINT)) end
    do local _ = ZG.TELL("You feel somewhat disoriented as you pass through...", ZG._TK.CR, ZG._TK.CR) end
    do return ZG.GOTO(RM) end

end, "SCOL-THROUGH")

ZG.SCOL_THROUGH = ZG.actions:get("SCOL_THROUGH")

-- zil: 2actions.zil:1425  <GLOBAL SCOL-ACTIVE>
-- SCOL_ACTIVE is declared in ZilGlobal.lua

-- zil: 2actions.zil:1427  <ROUTINE I-CURTAIN ()>
ZG.actions:register("I_CURTAIN", function()

    ZG._set("SCOL_ACTIVE", false)
    if ZG.EQ(ZG.HERE, ZG.VAULT) then
        do return ZG.JIGS_UP("A metallic voice says \"Hello, Intruder! Your unauthorized presence\nin the vault of the Bank of Zork has set off all sorts of nasty surprises,\nmost of which are fatal. This message brought to you by the Frobozz Magic\nVault Company.\"") end
    elseif ZG.EQUAL_p(ZG.HERE, ZG.VIEWING_EAST, ZG.VIEWING_WEST, ZG.SMALL_ROOM) then
        do local _ = ZG.TELL("You hear a faint voice say \"Curtain Door Closed.\"", ZG._TK.CR) end
        if ZG.EQ(ZG.HERE, ZG.SMALL_ROOM) then
            if ZG._T(ZG.ZGNOME_FLAG) then
                do return true end
            else
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_ZGNOME, 3)) end
                ZG._set("ZGNOME_FLAG", true)
                do return ZG.ZGNOME_FLAG end
            end
        else
            do return false end
        end
    else
        do return false end
    end

end, "I-CURTAIN")

ZG.I_CURTAIN = ZG.actions:get("I_CURTAIN")

-- zil: 2actions.zil:1443  <GLOBAL ZGNOME-FLAG>
-- ZGNOME_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1445  <ROUTINE I-ZGNOME ()>
ZG.actions:register("I_ZGNOME", function()

    if ZG.EQ(ZG.HERE, ZG.SMALL_ROOM) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_ZGNOME_OUT, 12)) end
        do local _ = ZG.TELL("An epicene gnome of Zurich wearing a three-piece suit and carrying a\nsafety deposit box materializes in the room.") end
        if ZG._T(ZG.IN_p(ZG.WAND, ZG.WINNER)) then
            do return ZG.TELL(" He notices the wand and dematerializes speedily.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL(" \"You seem to have\nforgotten to deposit your valuables,\" he says, tapping the lid of the\nbox impatiently. \"We don't usually allow customers to use the boxes\nhere, but we can make this ONE exception, I suppose...\" He looks\naskance at you over his wire-rimmed bifocals.", ZG._TK.CR) end
            do return ZG.MOVE(ZG.GNOME_OF_ZURICH, ZG.HERE) end
        end
    else
        do return false end
    end

end, "I-ZGNOME")

ZG.I_ZGNOME = ZG.actions:get("I_ZGNOME")

-- zil: 2actions.zil:1462  <ROUTINE BOX-F ()>
ZG.actions:register("BOX_F", function()

    do return ZG.TELL("The gnome clutches it possessively.", ZG._TK.CR) end

end, "BOX-F")

ZG.BOX_F = ZG.actions:get("BOX_F")

-- zil: 2actions.zil:1465  <ROUTINE ZGNOME-FCN ()>
ZG.actions:register("ZGNOME_FCN", function()

    if ZG._T(ZG.VERB_p("TELL")) then
        ZG._set("P_CONT", false)
        ZG._set("QUOTE_FLAG", false)
        do return ZG.TELL("The gnome appears increasingly impatient.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE", "THROW")) and ZG.EQ(ZG.PRSI, ZG.GNOME_OF_ZURICH)) then
        if ZG._T(ZG.GETPT(ZG.PRSO, "VALUE")) then
            do local _ = ZG.TELL("The gnome carefully places the ", ZG._TK.D, ZG.PRSO, " in the\ndeposit box. \"Let me show you the way out,\" he says, making it clear\nhe will be pleased to see the last of you. Then, you are momentarily\ndisoriented, and when you recover you are back at the Bank Entrance.", ZG._TK.CR) end
            do local _ = ZG.REMOVE(ZG.GNOME_OF_ZURICH) end
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT)) end
            do local _ = ZG.GOTO(ZG.BANK_ENTRANCE) end
            do return true end
        elseif ZG._T(ZG.BOMB_p(ZG.PRSO)) then
            do local _ = ZG.REMOVE(ZG.GNOME_OF_ZURICH) end
            do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_ZGNOME)) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT)) end
            do return ZG.TELL("\"You are so very gracious. I really cannot accept.\" he says. He\ndisappears, a wry smile on his lips.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("\"I wouldn't put THAT in a safety deposit box,\" remarks the gnome with\ndisdain, tossing it over his shoulder, where it disappears with an\nunderstated \"pop\".", ZG._TK.CR) end
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            do return true end
        end
    elseif ZG._T(ZG.VERB_p("ATTACK")) then
        do local _ = ZG.TELL("The gnome says \"Well, I never...\" and disappears with a snap of his\nfingers, leaving you alone.", ZG._TK.CR) end
        do local _ = ZG.REMOVE(ZG.GNOME_OF_ZURICH) end
        do return ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT)) end
    else
        do return ZG.TELL("The gnome appears increasingly impatient.", ZG._TK.CR) end
    end

end, "ZGNOME-FCN")

ZG.ZGNOME_FCN = ZG.actions:get("ZGNOME_FCN")

-- zil: 2actions.zil:1508  <ROUTINE I-ZGNOME-OUT ()>
ZG.actions:register("I_ZGNOME_OUT", function()

    do local _ = ZG.REMOVE(ZG.GNOME_OF_ZURICH) end
    if ZG.EQ(ZG.HERE, ZG.SMALL_ROOM) then
        do return ZG.TELL("The gnome looks impatient: \"I may have another customer waiting;\nyou'll just have to fend for yourself, I'm afraid.\" He disappears,\nleaving you alone.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-ZGNOME-OUT")

ZG.I_ZGNOME_OUT = ZG.actions:get("I_ZGNOME_OUT")

-- zil: 2actions.zil:1516  <ROUTINE BOMB? (O)>
ZG.actions:register("BOMB_p", function(O)

    if (ZG.EQ(O, ZG.BRICK) and ZG._T(ZG.IN_p(ZG.FUSE, ZG.BRICK)) and (not ZG.ZERO_p(ZG.GET(ZG.INT(ZG.I_FUSE), ZG.C_ENABLED_p)))) then
        do return true end
    else
        do return false end
    end

end, "BOMB?")

ZG.BOMB_p = ZG.actions:get("BOMB_p")

-- zil: 2actions.zil:1527  <ROUTINE GO&LOOK (RM "AUX" OHERE OLIT (OSEEN <>))>
ZG.actions:register("GO_LOOK", function(RM)

    local OHERE = 0
    local OLIT = 0
    local OSEEN = false
    OHERE = ZG.HERE
    if ZG._T(ZG.FSET_p(OHERE, "TOUCHBIT")) then
        OSEEN = true
    end
    OLIT = ZG.LIT
    ZG._set("HERE", RM)
    ZG._set("LIT", ZG.LIT_p(RM))
    do local _ = ZG.PERFORM(ZG.SYMBOL("V?LOOK")) end
    if (not ZG._T(OSEEN)) then
        do local _ = ZG.FCLEAR(OHERE, "TOUCHBIT") end
    end
    ZG._set("HERE", OHERE)
    ZG._set("LIT", OLIT)
    do return true end

end, "GO&LOOK")

ZG.GO_LOOK = ZG.actions:get("GO_LOOK")

-- zil: 2actions.zil:1541  <ROUTINE TINY-ROOM-FCN (RARG)>
ZG.actions:register("TINY_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a tiny room carved out of the wall of the ravine. There is\nan exit down a precarious climb. ") end
        do local _ = ZG.P_DOOR("north", ZG.LID_1, ZG.KEYHOLE_1) end
        do return true end
    elseif (not ZG._T(ZG.VERB_p("LOOK"))) then
        do local _ = ZG.PCHECK() end
        do return false end
    else
        do return false end
    end

end, "TINY-ROOM-FCN")

ZG.TINY_ROOM_FCN = ZG.actions:get("TINY_ROOM_FCN")

-- zil: 2actions.zil:1551  <ROUTINE DREARY-ROOM-FCN (RARG)>
ZG.actions:register("DREARY_ROOM_FCN", function(RARG)

    local _tmp1
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a small and rather dreary room, eerily illuminated by a red glow\nemanating from a crack in one wall. The light falls upon a dusty wooden table\nin the center of the room. ") end
        do local _ = ZG.P_DOOR("south", ZG.LID_2, ZG.KEYHOLE_2) end
        do return true end
    end
    do return false end
    do return {true, ZG.PCHECK(), _tmp1} end

end, "DREARY-ROOM-FCN")

ZG.DREARY_ROOM_FCN = ZG.actions:get("DREARY_ROOM_FCN")

-- zil: 2actions.zil:1562  <ROUTINE PCHECK ("AUX" (LID <PLID>))>
ZG.actions:register("PCHECK", function()

    local LID = ZG.PLID()
    ZG._set("PLOOK_FLAG", false)
    if (ZG._T(ZG.IN_p(ZG.KEY, ZG.KEYHOLE_1)) or ZG._T(ZG.IN_p(ZG.KEY, ZG.KEYHOLE_2))) then
        do local _ = ZG.FSET(ZG.KEY, "NDESCBIT") end
    else
        do local _ = ZG.FCLEAR(ZG.KEY, "NDESCBIT") end
    end
    if ZG._T(ZG.HELD_p(ZG.PLACE_MAT)) then
        ZG._set("MUD_FLAG", false)
    end
    -- ;"HUH?"
    if ZG._T(ZG.MUD_FLAG) then
        do local _ = ZG.MOVE(ZG.PLACE_MAT, ZG.HERE) end
        do return ZG.FSET(ZG.PLACE_MAT, "NDESCBIT") end
    else
        do return ZG.FCLEAR(ZG.PLACE_MAT, "NDESCBIT") end
    end

end, "PCHECK")

ZG.PCHECK = ZG.actions:get("PCHECK")

-- zil: 2actions.zil:1578  <ROUTINE P-DOOR (STR LID KEYHOLE "AUX" F)>
ZG.actions:register("P_DOOR", function(STR, LID, KEYHOLE)

    local F = 0
    if ZG._T(ZG.PLOOK_FLAG) then
        ZG._set("PLOOK_FLAG", false)
        do return false end
    end
    do local _ = ZG.TELL("On the ", STR, " side of the room is a massive wooden door, which has a\nsmall window barred with iron. A formidable bolt lock is set within the\ndoor frame. A keyhole ") end
    if (not ZG._T(ZG.FSET_p(LID, "OPENBIT"))) then
        do local _ = ZG.TELL("covered by a thin metal lid ") end
    end
    do local _ = ZG.TELL("lies within the lock.") end
    if ZG._T((function() F = ZG.FIRST_p(KEYHOLE); return F end)()) then
        do local _ = ZG.TELL(" A ", ZG._TK.D, F, " is in place within the keyhole.") end
    end
    if ZG._T(ZG.MUD_FLAG) then
        do local _ = ZG.TELL(" The edge of a place mat is visible under the door.") end
        if ZG._T(ZG.MATOBJ) then
            do local _ = ZG.TELL(" Lying on the place mat is a ", ZG._TK.D, ZG.MATOBJ, ".") end
        end
    end
    do return ZG.CRLF() end

end, "P-DOOR")

ZG.P_DOOR = ZG.actions:get("P_DOOR")

-- zil: 2actions.zil:1598  <ROUTINE PLID ("OPTIONAL" (OBJ1 ,LID-1) (OBJ2 ,LID-2))>
ZG.actions:register("PLID", function(OBJ1, OBJ2)

    if OBJ1 == nil then OBJ1 = ZG.LID_1 end
    if OBJ2 == nil then OBJ2 = ZG.LID_2 end
    if ZG._T(ZG.IN_p(OBJ1, ZG.HERE)) then
        do return OBJ1 end
    else
        do return OBJ2 end
    end

end, "PLID")

ZG.PLID = ZG.actions:get("PLID")

-- zil: 2actions.zil:1604  <ROUTINE PKH (KEYHOLE "OPTIONAL" (THIS <>))>
ZG.actions:register("PKH", function(KEYHOLE, THIS)

    if THIS == nil then THIS = false end
    if (ZG.EQ(KEYHOLE, ZG.KEYHOLE_1) and (not ZG._T(THIS))) then
        do return ZG.KEYHOLE_2 end
    elseif ((not ZG.EQ(KEYHOLE, ZG.KEYHOLE_1)) and ZG._T(THIS)) then
        do return ZG.KEYHOLE_2 end
    else
        do return ZG.KEYHOLE_1 end
    end

end, "PKH")

ZG.PKH = ZG.actions:get("PKH")

-- zil: 2actions.zil:1612  <ROUTINE PKH-FCN ("AUX" OBJ KH)>
ZG.actions:register("PKH_FCN", function()

    local _tmp1, _tmp2
    local OBJ = 0
    local KH = 0
    if ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        if ZG.EQ(ZG.HERE, ZG.DREARY_ROOM) then
            _tmp1 = ZG.TINY_ROOM
        else
            _tmp1 = ZG.DREARY_ROOM
        end
        if ZG.EQ(ZG.HERE, ZG.DREARY_ROOM) then
            _tmp2 = ZG.TINY_ROOM
        else
            _tmp2 = ZG.DREARY_ROOM
        end
        if (ZG._T(ZG.FSET_p(ZG.LID_1, "OPENBIT")) and ZG._T(ZG.FSET_p(ZG.LID_2, "OPENBIT")) and (not ZG._T(ZG.FIRST_p(ZG.KEYHOLE_1))) and (not ZG._T(ZG.FIRST_p(ZG.KEYHOLE_2))) and ZG._T(ZG.LIT_p(_tmp2))) then
            do return ZG.TELL("You can see a lighted room at the other end.", ZG._TK.CR) end
        else
            do return ZG.TELL("No light can be seen through the keyhole.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("PUT")) then
        if ZG._T(ZG.FSET_p(ZG.PLID(), "OPENBIT")) then
            if ZG._T(ZG.FIRST_p(ZG.PKH(ZG.PRSI, true))) then
                do return ZG.TELL("The keyhole is blocked.", ZG._TK.CR) end
            elseif ZG.EQUAL_p(ZG.PRSO, ZG.LETTER_OPENER, ZG.KEY) then
                if ZG._T(ZG.FIRST_p((function() KH = ZG.PKH(ZG.PRSI); return KH end)())) then
                    do local _ = ZG.TELL("There is a faint noise from behind the door and a small cloud of\ndust rises from beneath it.", ZG._TK.CR) end
                    OBJ = ZG.FIRST_p(KH)
                    do local _ = ZG.REMOVE(OBJ) end
                    if ZG._T(ZG.MUD_FLAG) then
                        ZG._set("MATOBJ", OBJ)
                    end
                    do return false end
                else
                    do return false end
                end
            else
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " doesn't fit.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("The lid is in the way.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "PKH-FCN")

ZG.PKH_FCN = ZG.actions:get("PKH_FCN")

-- zil: 2actions.zil:1644  <ROUTINE PLID-FCN ()>
ZG.actions:register("PLID_FCN", function()

    local _tmp1, _tmp2
    if ZG._T(ZG.VERB_p("OPEN", "RAISE", "MOVE")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do local _ = ZG.TELL(ZG.RANDOM_ELEMENT(ZG.DUMMY), ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The lid is now open.", ZG._TK.CR) end
        end
        do return ZG.FSET(ZG.PRSO, "OPENBIT") end
    elseif ZG._T(ZG.VERB_p("CLOSE", "LOWER")) then
        if ZG.EQ(ZG.HERE, ZG.DREARY_ROOM) then
            _tmp1 = ZG.KEYHOLE_2
        else
            _tmp1 = ZG.KEYHOLE_1
        end
        if ZG.EQ(ZG.HERE, ZG.DREARY_ROOM) then
            _tmp2 = ZG.KEYHOLE_2
        else
            _tmp2 = ZG.KEYHOLE_1
        end
        if ZG._T(ZG.FIRST_p(_tmp2)) then
            do return ZG.TELL("The keyhole is occupied.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The lid covers the keyhole.", ZG._TK.CR) end
            do return ZG.FCLEAR(ZG.PRSO, "OPENBIT") end
        end
    elseif ZG._T(ZG.VERB_p("LOOK-BEHIND")) then
        do return ZG.TELL("There's a keyhole behind the lid.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PLID-FCN")

ZG.PLID_FCN = ZG.actions:get("PLID_FCN")

-- zil: 2actions.zil:1661  <GLOBAL MUD-FLAG>
-- MUD_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1663  <GLOBAL MATOBJ>
-- MATOBJ is declared in ZilGlobal.lua

-- zil: 2actions.zil:1665  <GLOBAL PUNLOCK-FLAG>
-- PUNLOCK_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1667  <GLOBAL PLOOK-FLAG>
-- PLOOK_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:1669  <ROUTINE ROOM? (OBJ "AUX" NOBJ)>
ZG.actions:register("ROOM_p", function(OBJ)

    local NOBJ = 0
    while true do
        NOBJ = ZG.LOC(OBJ)
        if (not ZG._T(NOBJ)) then
            do return false end
        elseif ZG.EQ(NOBJ, ZG.WINNER) then
            do return false end
        elseif ZG.EQ(NOBJ, ZG.ROOMS) then
            do return OBJ end
        end
        OBJ = NOBJ
    end

end, "ROOM?")

ZG.ROOM_p = ZG.actions:get("ROOM_p")

-- zil: 2actions.zil:1677  <ROUTINE PALANTIR ()>
ZG.actions:register("PALANTIR", function()

    local _tmp1, _tmp2
    if ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        if ZG.EQ(ZG.PRSO, ZG.PALANTIR_1) then
            _tmp1 = ZG.PALANTIR_2
        elseif ZG.EQ(ZG.PRSO, ZG.PALANTIR_2) then
            _tmp1 = ZG.PALANTIR_3
        elseif ZG.EQ(ZG.PRSO, ZG.PALANTIR_3) then
            _tmp1 = ZG.PALANTIR_1
        else
            _tmp1 = ZG.PALANTIR_4
        end
        if ZG.EQ(ZG.PRSO, ZG.PALANTIR_1) then
            _tmp2 = ZG.PALANTIR_2
        elseif ZG.EQ(ZG.PRSO, ZG.PALANTIR_2) then
            _tmp2 = ZG.PALANTIR_3
        elseif ZG.EQ(ZG.PRSO, ZG.PALANTIR_3) then
            _tmp2 = ZG.PALANTIR_1
        else
            _tmp2 = ZG.PALANTIR_4
        end
        do return ZG.PALANTIR_LOOK(_tmp2) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("There is something misty in the sphere. Perhaps if you were to look\ninto it...", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.PRSO, ZG.PALANTIR_3)) then
        do local _ = ZG.PUTP(ZG.PRSO, "LDESC", false) end
        do return false end
    else
        do return false end
    end

end, "PALANTIR")

ZG.PALANTIR = ZG.actions:get("PALANTIR")

-- zil: 2actions.zil:1694  <ROUTINE DEAD-PALANTIR (RARG "AUX" P)>
ZG.actions:register("DEAD_PALANTIR", function(RARG)

    local _tmp1, _tmp2, _tmp3, _tmp4
    local P = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_1) then
            P = ZG.PALANTIR_1
            _tmp1 = "red"
        elseif ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_2) then
            P = ZG.PALANTIR_2
            _tmp1 = "blue"
        else
            P = ZG.PALANTIR_3
            _tmp1 = "white"
        end
        if ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_1) then
            _tmp2 = "blue"
        elseif ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_2) then
            _tmp2 = "white"
        else
            _tmp2 = "black"
        end
        if ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_1) then
            P = ZG.PALANTIR_1
            _tmp3 = "red"
        elseif ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_2) then
            P = ZG.PALANTIR_2
            _tmp3 = "blue"
        else
            P = ZG.PALANTIR_3
            _tmp3 = "white"
        end
        if ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_1) then
            _tmp4 = "blue"
        elseif ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_2) then
            _tmp4 = "white"
        else
            _tmp4 = "black"
        end
        do local _ = ZG.TELL("You are inside a huge crystalline sphere filled with thin ", _tmp3, " mist. The mist becomes ", _tmp4, " to the west.", ZG._TK.CR) end
        do local _ = ZG.TELL("You strain to look out through the mist... ", ZG._TK.CR) end
        if ZG._T(ZG.FSET_p(P, "TOUCHBIT")) then
            do local _ = ZG.PALANTIR_LOOK(P, true) end
        elseif ZG.EQ(P, ZG.PALANTIR_1) then
            do local _ = ZG.TELL("You see a small room with a sign on the wall, but it is too blurry to\nread.", ZG._TK.CR) end
        elseif ZG.EQ(P, ZG.PALANTIR_2) then
            do local _ = ZG.TELL("You look out into a large, dreary room with a great door and a huge table.\nThere is an odd glow to the mist.", ZG._TK.CR) end
        elseif ZG.EQ(P, ZG.PALANTIR_3) then
            do local _ = ZG.TELL("A strange blurry room is barely visible.") end
            if (ZG._T(ZG.IN_p(ZG.SERPENT, ZG.AQUARIUM)) and ZG._T(ZG.PROB(25))) then
                do local _ = ZG.TELL(" An odd sinuous shadow crosses the mist as you look.") end
            end
            do local _ = ZG.CRLF() end
        end
        do return true end
    elseif (ZG.EQ(RARG, ZG.M_ENTER) and ZG.EQ(ZG.HERE, ZG.DEAD_PALANTIR_4)) then
        do local _ = ZG.TELL("You follow a corridor of black mist into a black walled spherical\nroom.") end
        if ZG._T(ZG.IN_p(ZG.GENIE, ZG.PENTAGRAM_ROOM)) then
            do local _ = ZG.TELL(" The room is empty. A huge face looks down on you from outside and\nlaughs sardonically. It doesn't look like you're getting out of this\npredicament!", ZG._TK.CR) end
            do local _ = ZG.FINISH() end
        end
        do local _ = ZG.TELL(" As you enter, a huge and horrible face materializes out of the\nmist.\n\n\"What brings you here to trouble my imprisonment, wanderer?\"\nit asks. Hearing no immediate answer, it studies you for a moment.", ZG._TK.CR) end
        if (not ZG.LT(ZG.DEATHS, 3)) then
            do local _ = ZG.TELL("\"Not you again! This is getting tedious. You'll obviously never\nbe much help to me. Better luck next time, oh wondrous\nadventurer.\" The face disappears and everything goes black.", ZG._TK.CR) end
            do return ZG.FINISH() end
        else
            do local _ = ZG.TELL("\"Perhaps you may be of some use to me in gaining my freedom from\nthis place. Return to your foolish quest! I shall not destroy you\nthis time. Mayhap you will repay this favor in kind someday.\" The\nface vanishes and the mist begins to swirl. When it clears you are\nreturned to the world of life.", ZG._TK.CR) end
            ZG._set("DEAD", false)
            do local _ = ZG.GOTO(ZG.INSIDE_BARROW) end
            do return true end
        end
    else
        do return false end
    end

end, "DEAD-PALANTIR")

ZG.DEAD_PALANTIR = ZG.actions:get("DEAD_PALANTIR")

-- zil: 2actions.zil:1765  <ROUTINE GLOBAL-PALANTIRS ()>
ZG.actions:register("GLOBAL_PALANTIRS", function()

    if ZG._T(ZG.VERB_p("LOOK-INSIDE", "EXAMINE")) then
        do return ZG.DEAD_PALANTIR(ZG.M_LOOK) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("The sphere is unbreakable.", ZG._TK.CR) end
    else
        do return false end
    end

end, "GLOBAL-PALANTIRS")

ZG.GLOBAL_PALANTIRS = ZG.actions:get("GLOBAL_PALANTIRS")

-- zil: 2actions.zil:1770  <ROUTINE PALANTIR-LOOK (OBJ "OPTIONAL" (INSIDE? <>) "AUX" RM OHERE)>
ZG.actions:register("PALANTIR_LOOK", function(OBJ, INSIDE_p)

    if INSIDE_p == nil then INSIDE_p = false end
    local RM = 0
    local OHERE = 0
    if ZG.EQ(OBJ, ZG.PALANTIR_4) then
        do local _ = ZG.TELL("As you peer into the sphere, a strange vision takes shape...a huge and\nfearful face with yellow eyes. The face peers out at you expectantly.", ZG._TK.CR) end
        do return true end
    end
    RM = ZG.ROOM_p(OBJ)
    if ((not ZG._T(RM)) or (not ZG._T(ZG.LIT_p(RM)))) then
        do local _ = ZG.TELL("You see only darkness.", ZG._TK.CR) end
    elseif (ZG._T(ZG.IN_p(OBJ, RM)) or ZG._T(ZG.SEE_INSIDE_p(ZG.LOC(OBJ)))) then
        OHERE = ZG.HERE
        if ZG._T(INSIDE_p) then
            do local _ = ZG.TELL("As you peer through the mist, a strangely colored vision of a\nhuge room takes shape...", ZG._TK.CR, ZG._TK.CR) end
        else
            do local _ = ZG.TELL("As you peer into the sphere, a strange vision takes shape of\na distant room, which can be described clearly....", ZG._TK.CR, ZG._TK.CR) end
        end
        do local _ = ZG.FSET(OBJ, "INVISIBLE") end
        do local _ = ZG.GO_LOOK(RM) end
        if ZG.EQ(OHERE, RM) then
            do local _ = ZG.TELL("An astonished adventurer is staring into a crystal sphere.", ZG._TK.CR) end
        end
        do local _ = ZG.FCLEAR(OBJ, "INVISIBLE") end
        if (not ZG._T(INSIDE_p)) then
            do local _ = ZG.TELL("The vision fades, revealing only an ordinary crystal sphere.", ZG._TK.CR) end
        end
    else
        do local _ = ZG.TELL("You see only darkness.", ZG._TK.CR) end
    end
    do return true end

end, "PALANTIR-LOOK")

ZG.PALANTIR_LOOK = ZG.actions:get("PALANTIR_LOOK")

-- zil: 2actions.zil:1802  <ROUTINE PWINDOW-FCN ()>
ZG.actions:register("PWINDOW_FCN", function()

    if ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        ZG._set("PLOOK_FLAG", true)
        if ZG._T(ZG.FSET_p(ZG.PDOOR, "OPENBIT")) then
            do return ZG.TELL("The door is open, dummy.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.HERE, ZG.DREARY_ROOM) then
            do return ZG.GO_LOOK(ZG.TINY_ROOM) end
        else
            do return ZG.GO_LOOK(ZG.DREARY_ROOM) end
        end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.TELL("Perhaps if you were diced....", ZG._TK.CR) end
    else
        do return false end
    end

end, "PWINDOW-FCN")

ZG.PWINDOW_FCN = ZG.actions:get("PWINDOW_FCN")

-- zil: 2actions.zil:1813  <ROUTINE PDOOR-FCN ("AUX" K)>
ZG.actions:register("PDOOR_FCN", function()

    local _tmp1, _tmp2
    local K = 0
    if (ZG._T(ZG.VERB_p("LOOK-UNDER")) and ZG._T(ZG.MUD_FLAG)) then
        do return ZG.TELL("The place mat is under the door.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("UNLOCK")) then
        if ZG.EQ(ZG.PRSI, ZG.KEY) then
            if (ZG._T((function() K = ZG.FIRST_p(ZG.PLID(ZG.KEYHOLE_1, ZG.KEYHOLE_2)); return K end)()) and (not ZG.EQ(K, ZG.KEY))) then
                do return ZG.TELL("The keyhole is blocked.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The door is now unlocked.", ZG._TK.CR) end
                ZG._set("PUNLOCK_FLAG", true)
                do return ZG.PUNLOCK_FLAG end
            end
        elseif ZG.EQ(ZG.PRSI, ZG.GOLD_KEY) then
            do return ZG.TELL("It doesn't fit the lock.", ZG._TK.CR) end
        else
            do return ZG.TELL("It can't be unlocked with that.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LOCK")) then
        if ZG.EQ(ZG.PRSI, ZG.KEY) then
            do local _ = ZG.TELL("The door is locked.", ZG._TK.CR) end
            ZG._set("PUNLOCK_FLAG", false)
            do return true end
        elseif ZG.EQ(ZG.PRSI, ZG.GOLD_KEY) then
            do return ZG.TELL("It doesn't fit the lock.", ZG._TK.CR) end
        else
            do return ZG.TELL("It can't be locked with that.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("PUT-UNDER")) then
        if ZG.EQ(ZG.PRSO, ZG.ROBOT_LABEL) then
            do local _ = ZG.TELL("The paper is very small and vanishes under the door.", ZG._TK.CR) end
            if ZG.EQ(ZG.HERE, ZG.TINY_ROOM) then
                _tmp1 = ZG.DREARY_ROOM
            else
                _tmp1 = ZG.TINY_ROOM
            end
            if ZG.EQ(ZG.HERE, ZG.TINY_ROOM) then
                _tmp2 = ZG.DREARY_ROOM
            else
                _tmp2 = ZG.TINY_ROOM
            end
            do return ZG.MOVE(ZG.PRSO, _tmp2) end
        elseif ZG.EQ(ZG.PRSO, ZG.NEWSPAPER) then
            do return ZG.TELL("The newspaper crumples up and won't go under the door.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        if ZG._T(ZG.PUNLOCK_FLAG) then
            do return ZG.OPEN_CLOSE(ZG.PRSO, "The door is now open.", "The door is now closed.") end
        else
            do return ZG.TELL("The door is locked.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "PDOOR-FCN")

ZG.PDOOR_FCN = ZG.actions:get("PDOOR_FCN")

-- zil: 2actions.zil:1851  <ROUTINE PKEY-FCN ()>
ZG.actions:register("PKEY_FCN", function()

    if ZG._T(ZG.VERB_p("TURN")) then
        if ZG._T(ZG.PUNLOCK_FLAG) then
            do return ZG.PERFORM(ZG.SYMBOL("V?LOCK"), ZG.PDOOR, ZG.PRSO) end
        else
            do return ZG.PERFORM(ZG.SYMBOL("V?UNLOCK"), ZG.PDOOR, ZG.PRSO) end
        end
    else
        do return false end
    end

end, "PKEY-FCN")

ZG.PKEY_FCN = ZG.actions:get("PKEY_FCN")

-- zil: 2actions.zil:1858  <ROUTINE PLACE-MAT-FCN ()>
ZG.actions:register("PLACE_MAT_FCN", function()

    if ZG._T(ZG.VERB_p("PUT-UNDER")) then
        if ZG.EQ(ZG.PRSI, ZG.PDOOR) then
            do local _ = ZG.TELL("The place mat fits easily under the door.", ZG._TK.CR) end
            do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
            ZG._set("MUD_FLAG", true)
            do return ZG.MUD_FLAG end
        elseif ZG.EQUAL_p(ZG.PRSI, ZG.WIZ_DOOR, ZG.RIDDLE_DOOR, ZG.CRYPT_DOOR) then
            do return ZG.TELL("There's not enough room under this door.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("TAKE", "MOVE")) and ZG._T(ZG.MATOBJ)) then
        do local _ = ZG.MOVE(ZG.MATOBJ, ZG.HERE) end
        do local _ = ZG.TELL("As the place mat is moved, a ", ZG._TK.D, ZG.MATOBJ, " falls from it and onto the floor.", ZG._TK.CR) end
        ZG._set("MATOBJ", false)
        ZG._set("MUD_FLAG", false)
        do return true end
    else
        do return false end
    end

end, "PLACE-MAT-FCN")

ZG.PLACE_MAT_FCN = ZG.actions:get("PLACE_MAT_FCN")

-- zil: 2actions.zil:1876  <ROUTINE WISH-FCN ()>
ZG.actions:register("WISH_FCN", function()

    if ZG._T(ZG.VERB_p("MAKE")) then
        if (ZG.EQ(ZG.HERE, ZG.WELL_BOTTOM) and ZG._T(ZG.IN_p(ZG.COIN, ZG.HERE))) then
            do local _ = ZG.TELL("A whispering voice replies: \"Water makes the bucket go.\"\nUnfortunately, wishing makes the coin go....", ZG._TK.CR) end
            do return ZG.REMOVE(ZG.COIN) end
        else
            do return ZG.TELL("No one is listening.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "WISH-FCN")

ZG.WISH_FCN = ZG.actions:get("WISH_FCN")

-- zil: 2actions.zil:1887  <ROUTINE WELL-FCN ()>
ZG.actions:register("WELL_FCN", function()

    if (ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT")) and ZG._T(ZG.VERB_p("THROW", "PUT", "DROP"))) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is now sitting at the bottom of the well.", ZG._TK.CR) end
        do return ZG.MOVE(ZG.PRSO, ZG.WELL_BOTTOM) end
    elseif ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-DOWN", "CLIMB-FOO")) then
        do return ZG.TELL("You can't climb the well.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WELL-FCN")

ZG.WELL_FCN = ZG.actions:get("WELL_FCN")

-- zil: 2actions.zil:1895  <GLOBAL MATCH-COUNT>
-- MATCH_COUNT is declared in ZilGlobal.lua

-- zil: 2actions.zil:1897  <ROUTINE MATCH-FCN ("AUX" CNT)>
ZG.actions:register("MATCH_FCN", function()

    local CNT = 0
    if (ZG._T(ZG.VERB_p("LAMP-ON", "BURN")) and ZG.EQ(ZG.PRSO, ZG.MATCH)) then
        if ZG.LT(0, ZG.MATCH_COUNT) then
            ZG._set("MATCH_COUNT", ZG.SUB(ZG.MATCH_COUNT, 1))
        end
        if (not ZG.LT(0, ZG.MATCH_COUNT)) then
            do return ZG.TELL("I'm afraid you have run out of matches.", ZG._TK.CR) end
        else
            do local _ = ZG.FSET(ZG.MATCH, "FLAMEBIT") end
            do local _ = ZG.FSET(ZG.MATCH, "ONBIT") end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MATCH, 2)) end
            do return ZG.TELL("One of the matches starts to burn.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("LAMP-OFF")) and ZG._T(ZG.FSET_p(ZG.MATCH, "FLAMEBIT"))) then
        do local _ = ZG.TELL("The match is out.", ZG._TK.CR) end
        do local _ = ZG.FCLEAR(ZG.MATCH, "FLAMEBIT") end
        do local _ = ZG.FCLEAR(ZG.MATCH, "ONBIT") end
        do local _ = ZG.QUEUE(ZG.I_MATCH, 0) end
        do return true end
    elseif ZG._T(ZG.VERB_p("COUNT")) then
        do local _ = ZG.TELL("You have ") end
        CNT = ZG.SUB(ZG.MATCH_COUNT, 1)
        do local _ = ZG.TELL(ZG._TK.N, CNT, " match") end
        if (not (CNT == 1)) then
            do local _ = ZG.TELL("es.") end
        else
            do local _ = ZG.TELL(".") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG._T(ZG.FSET_p(ZG.MATCH, "ONBIT")) then
            do local _ = ZG.TELL("A match is burning.") end
        else
            do local _ = ZG.TELL("No match is burning.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "MATCH-FCN")

ZG.MATCH_FCN = ZG.actions:get("MATCH_FCN")

-- zil: 2actions.zil:1928  <ROUTINE I-MATCH ()>
ZG.actions:register("I_MATCH", function()

    do local _ = ZG.TELL("The match has gone out.", ZG._TK.CR) end
    do local _ = ZG.FCLEAR(ZG.MATCH, "FLAMEBIT") end
    do return ZG.FCLEAR(ZG.MATCH, "ONBIT") end

end, "I-MATCH")

ZG.I_MATCH = ZG.actions:get("I_MATCH")

-- zil: 2actions.zil:1934  <GLOBAL LAMP-TABLE>
-- LAMP_TABLE is declared in ZilGlobal.lua

-- zil: 2actions.zil:1943  <ROUTINE LANTERN ()>
ZG.actions:register("LANTERN", function()

    if (ZG._T(ZG.VERB_p("THROW")) and ZG.EQ(ZG.PRSO, ZG.LAMP)) then
        do local _ = ZG.TELL("The lamp has smashed into the floor, and the light has gone out.", ZG._TK.CR) end
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_LANTERN)) end
        do local _ = ZG.REMOVE(ZG.LAMP) end
        do return ZG.MOVE(ZG.BROKEN_LAMP, ZG.HERE) end
    elseif ZG._T(ZG.VERB_p("LAMP-ON")) then
        if ZG._T(ZG.FSET_p(ZG.LAMP, "RMUNGBIT")) then
            do return ZG.TELL("A burned-out lamp won't light.", ZG._TK.CR) end
        else
            do local _ = ZG.ENABLE(ZG.INT(ZG.I_LANTERN)) end
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("LAMP-OFF")) then
        if ZG._T(ZG.FSET_p(ZG.LAMP, "RMUNGBIT")) then
            do return ZG.TELL("The lamp has already burned out.", ZG._TK.CR) end
        else
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_LANTERN)) end
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG._T(ZG.FSET_p(ZG.LAMP, "RMUNGBIT")) then
            do local _ = ZG.TELL("The lamp has burned out.") end
        elseif ZG._T(ZG.FSET_p(ZG.LAMP, "ONBIT")) then
            do local _ = ZG.TELL("The lamp is on.") end
        else
            do local _ = ZG.TELL("The lamp is turned off.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "LANTERN")

ZG.LANTERN = ZG.actions:get("LANTERN")

-- zil: 2actions.zil:1971  <ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))>
ZG.actions:register("I_LANTERN", function()

    local TICK = 0
    local TBL = ZG.VALUE(ZG.LAMP_TABLE)
    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_LANTERN, (function() TICK = ZG.GET(TBL, 0); return TICK end)())) end
    do local _ = ZG.LIGHT_INT(ZG.LAMP, TBL, TICK) end
    if (not ZG.ZERO_p(TICK)) then
        ZG._set("LAMP_TABLE", ZG.REST(TBL, 4))
        do return ZG.LAMP_TABLE end
    else
        do return false end
    end

end, "I-LANTERN")

ZG.I_LANTERN = ZG.actions:get("I_LANTERN")

-- zil: 2actions.zil:1977  <ROUTINE LIGHT-INT (OBJ TBL TICK)>
ZG.actions:register("LIGHT_INT", function(OBJ, TBL, TICK)

    if ZG.ZERO_p(TICK) then
        do local _ = ZG.FCLEAR(OBJ, "ONBIT") end
        do local _ = ZG.FSET(OBJ, "RMUNGBIT") end
    end
    if (ZG._T(ZG.HELD_p(OBJ)) or ZG._T(ZG.IN_p(OBJ, ZG.HERE))) then
        if ZG.ZERO_p(TICK) then
            do return ZG.TELL("You'd better have more light than from the ", ZG._TK.D, OBJ, ".", ZG._TK.CR) end
        else
            do return ZG.TELL(ZG.GET(TBL, 1), ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "LIGHT-INT")

ZG.LIGHT_INT = ZG.actions:get("LIGHT_INT")

-- ;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
-- 	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
-- 		(TICK) FIX)
-- 	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
-- 	 <COND (<0? .TICK>
-- 		<FSET .OBJ ,RMUNGBIT>
-- 		<FCLEAR .OBJ ,ONBIT>)>
-- 	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
-- 		<COND (<0? .TICK>
-- 		       <TELL
-- "I hope you have more light than from the " D .OBJ "." CR>)
-- 		      (T
-- 		       <TELL <GET .TBL 1> CR>)>)>
-- 	 <COND (<NOT <0? .TICK>>
-- 		<SETG .TBLNAM <REST .TBL 4>>)>
-- 	 <RTRUE>>

-- ;"Riddles"

-- zil: 2actions.zil:2007  <ROUTINE RIDDLE-ROOM-FCN (RARG)>
ZG.actions:register("RIDDLE_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a room which is bare on all sides. There is an exit down in\nthe northwest corner of the room. To the east is a great ") end
        if ZG._T(ZG.FSET_p(ZG.RIDDLE_DOOR, "OPENBIT")) then
            do local _ = ZG.TELL("open") end
        else
            do local _ = ZG.TELL("closed") end
        end
        do return ZG.TELL(" door made of\nstone. Above the stone, the following words are written: \"No man shall\npass this door without solving this riddle:\n\n  What is tall as a house,\n    round as a cup,\n      and all the king's horses\n        can't draw it up?\"\n") end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if ZG._T(ZG.VERB_p("ANSWER", "SAY")) then
            if ZG._T(ZG.FSET_p(ZG.RIDDLE_DOOR, "OPENBIT")) then
                do return false end
            elseif (ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.P_CONT), ZG.WORD("well")) or ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.ADD(ZG.P_CONT, 2)), ZG.WORD("well"))) then
                do local _ = ZG.TELL("There is a deafening clap of thunder and the stone door\nquietly swings open to reveal a passageway beyond.", ZG._TK.CR) end
                do local _ = ZG.SCORE_UPD(5) end
                do local _ = ZG.FSET(ZG.RIDDLE_DOOR, "OPENBIT") end
            else
                do local _ = ZG.TELL("A hollow laugh seems to come from the stone door.", ZG._TK.CR) end
            end
            ZG._set("P_CONT", false)
            ZG._set("QUOTE_FLAG", false)
            do return true end
        else
            do return false end
        end
    else
        do return false end
    end

end, "RIDDLE-ROOM-FCN")

ZG.RIDDLE_ROOM_FCN = ZG.actions:get("RIDDLE_ROOM_FCN")

-- zil: 2actions.zil:2043  <ROUTINE RIDDLE-DOOR-FCN ()>
ZG.actions:register("RIDDLE_DOOR_FCN", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.FSET_p(ZG.RIDDLE_DOOR, "OPENBIT")) then
            do return ZG.TELL("It is open!", ZG._TK.CR) end
        else
            do return ZG.TELL("The door can only be opened by answering the riddle.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        if ZG._T(ZG.FSET_p(ZG.RIDDLE_DOOR, "OPENBIT")) then
            do return ZG.TELL("Not a chance. The door weighs many tons.", ZG._TK.CR) end
        else
            do return ZG.TELL("It is closed!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "RIDDLE-DOOR-FCN")

ZG.RIDDLE_DOOR_FCN = ZG.actions:get("RIDDLE_DOOR_FCN")

-- zil: 2actions.zil:2056  <GLOBAL DUMMY>
-- DUMMY is declared in ZilGlobal.lua

-- zil: 2actions.zil:2061  <ROUTINE RIDDLE-PSEUDO ()>
ZG.actions:register("RIDDLE_PSEUDO", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("Use the \"Look\" command.", ZG._TK.CR) end
    else
        do return false end
    end

end, "RIDDLE-PSEUDO")

ZG.RIDDLE_PSEUDO = ZG.actions:get("RIDDLE_PSEUDO")

-- zil: 2actions.zil:2065  <ROUTINE MAGIC-ACTOR ("AUX" V)>
ZG.actions:register("MAGIC_ACTOR", function()

    local V = 0
    if ZG._T(ZG.SPELL_p) then
        if ZG.EQ(ZG.SPELL_p, ZG.S_FALL) then
            if (ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-DOWN", "CROSS")) or (ZG._T(ZG.VERB_p("WALK")) and ZG._T(ZG.GETPT(ZG.HERE, "DOWN")))) then
                V = ZG.GETPT(ZG.HERE, "GLOBAL")
                if ZG._T(ZG.ZMEMQB(ZG.BRIDGE, V, ZG.PTSIZE(V))) then
                    do return ZG.JIGS_UP("You find yourself drawn toward the edge of the bridge. You peer over\nthe side. Oops, that was clumsy of you! You tripped on something and\nfell in. Too bad.") end
                elseif ZG._T(ZG.PROB(25)) then
                    do return ZG.JIGS_UP("For some odd reason you have tripped on your own feet, or perhaps an\ninvisible cord stretched across the path. The resulting fall seems to\nhave done you in.") end
                else
                    do return ZG.TELL("You just tripped on an invisible cord, or perhaps your own feet. But\nthis must be your lucky day, as you managed to regain your balance\nbefore what could have been a fatal fall.", ZG._TK.CR) end
                end
            elseif ZG._T(ZG.VERB_p("BOARD")) then
                do return ZG.TELL("You get in the ", ZG._TK.D, ZG.PRSO, " but you fall out again, almost as though\nan invisible hand had tipped it over.", ZG._TK.CR) end
            else
                do return false end
            end
        elseif ZG.EQ(ZG.SPELL_p, ZG.S_FLOAT) then
            if ZG._T(ZG.VERB_p("DIAGNOSE", "WAIT")) then
                do return false end
            elseif ZG._T(ZG.VERB_p("WALK")) then
                do return ZG.TELL("I suppose you plan to do that by flapping your arms?", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("DROP")) then
                do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " drops to the ground.", ZG._TK.CR) end
            elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG._T(ZG.IN_p(ZG.PRSO, ZG.HERE))) then
                do return ZG.TELL("You can't reach that! It's on the ground.", ZG._TK.CR) end
            else
                do return false end
            end
        elseif ZG.EQ(ZG.SPELL_p, ZG.S_FREEZE) then
            if ZG._T(ZG.VERB_p("DIAGNOSE", "WAIT")) then
                do return false end
            else
                do return ZG.TELL("You are frozen solid. You might as well wait it out, because you\ncan't do anything else in this state.", ZG._TK.CR) end
            end
        elseif (ZG.EQ(ZG.SPELL_p, ZG.S_FENCE) and ZG._T(ZG.VERB_p("WALK"))) then
            do local _ = ZG.TELL("An invisible fence of magical force bars your way.", ZG._TK.CR) end
            do return true end
        elseif (ZG.EQ(ZG.SPELL_p, ZG.S_FIERCE) and ZG._T((function() V = ZG.INFESTED_p(ZG.HERE); return V end)())) then
            if ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
                do return false end
            else
                do local _ = ZG.FORCE_FIGHT(V) end
                do return true end
            end
        elseif (ZG.EQ(ZG.SPELL_p, ZG.S_FERMENT) and ZG._T(ZG.VERB_p("WALK")) and ZG._T(ZG.IN_p(ZG.WINNER, ZG.HERE))) then
            do local _ = ZG.TELL("Oops, you seem a little unsteady... I'm not sure you got where\nyou intended going.", ZG._TK.CR, ZG._TK.CR) end
            do return ZG.RANDOM_WALK() end
        elseif (ZG.EQ(ZG.SPELL_p, ZG.S_FEAR) and ZG._T((function() V = ZG.INFESTED_p(ZG.HERE); return V end)())) then
            do local _ = ZG.TELL("All at once, you are overcome by fear! There's is a ", ZG._TK.D, V, " in here!\nMaybe it's after you! ") end
            if ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT")) then
                do return ZG.TELL("You huddle in the corner, terrified.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("You run from the room screaming in terror!", ZG._TK.CR, ZG._TK.CR) end
                do return ZG.RANDOM_WALK() end
            end
        else
            do return false end
        end
    else
        do return false end
    end

end, "MAGIC-ACTOR")

ZG.MAGIC_ACTOR = ZG.actions:get("MAGIC_ACTOR")

-- zil: 2actions.zil:2139  <ROUTINE RANDOM-WALK ("AUX" P TX L S (D <>))>
ZG.actions:register("RANDOM_WALK", function()

    local P = 0
    local TX = 0
    local L = 0
    local S = 0
    local D = false
    P = 0
    while true do
        if ZG.LT((function() P = ZG.NEXTP(ZG.HERE, P); return P end)(), ZG.LOW_DIRECTION) then
            if ZG._T(D) then
                S = ZG.SPELL_p
                ZG._set("SPELL_p", false)
                ZG._set("WINNER", ZG.ADVENTURER)
                do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
                do local _ = ZG.DO_WALK(D) end
                ZG._set("SPELL_p", S)
            end
            do return true end
        else
            TX = ZG.GETPT(ZG.HERE, P)
            L = ZG.PTSIZE(TX)
            if (ZG.EQ(L, ZG.UEXIT) or (ZG.EQ(L, ZG.CEXIT) and ZG._T(ZG.VALUE(ZG.GETB(TX, ZG.CEXITFLAG)))) or (ZG.EQ(L, ZG.DEXIT) and ZG._T(ZG.FSET_p(ZG.GETB(TX, ZG.DEXITOBJ), "OPENBIT")))) then
                if (not ZG._T(D)) then
                    D = P
                elseif ZG._T(ZG.PROB(50)) then
                    D = P
                end
            end
        end
    end

end, "RANDOM-WALK")

ZG.RANDOM_WALK = ZG.actions:get("RANDOM_WALK")

-- zil: 2actions.zil:2162  <ROUTINE FORCE-FIGHT (V "AUX" W)>
ZG.actions:register("FORCE_FIGHT", function(V)

    local W = 0
    if (not ZG._T((function() W = ZG.FIND_IN(ZG.ADVENTURER, "WEAPONBIT"); return W end)())) then
        W = ZG.HANDS
    end
    do local _ = ZG.TELL("You are maddened by an overwhelming ferocity, and attack the ", ZG._TK.D, V, " instead.", ZG._TK.CR) end
    do return ZG.PERFORM(ZG.SYMBOL("V?ATTACK"), V, W) end

end, "FORCE-FIGHT")

ZG.FORCE_FIGHT = ZG.actions:get("FORCE_FIGHT")

-- zil: 2actions.zil:2174  <GLOBAL DIAMOND-SOLVE>
-- DIAMOND_SOLVE is declared in ZilGlobal.lua

-- ;"T if solved"

-- zil: 2actions.zil:2176  <GLOBAL DIAMOND-COUNT>
-- DIAMOND_COUNT is declared in ZilGlobal.lua

-- ;"count of current progress"

-- zil: 2actions.zil:2177  <GLOBAL DIAMOND-MOVES>
-- DIAMOND_MOVES is declared in ZilGlobal.lua

-- ;"count of moves since progressed"

-- zil: 2actions.zil:2178  <GLOBAL DIAMOND-BASE>
-- DIAMOND_BASE is declared in ZilGlobal.lua

-- ;"count of maximum progress ever"

-- zil: 2actions.zil:2180  <GLOBAL DWDESCS>
-- DWDESCS is declared in ZilGlobal.lua

-- zil: 2actions.zil:2187  <ROUTINE DWINDOW-DESC ()>
ZG.actions:register("DWINDOW_DESC", function()

    do local _ = ZG.TELL("On the floor is a very small diamond shaped window which is ") end
    if ZG._T(ZG.DIAMOND_SOLVE) then
        do local _ = ZG.TELL("glowing serenely") end
    else
        do local _ = ZG.TELL(ZG.GET(ZG.DWDESCS, ZG.DIAMOND_COUNT)) end
    end
    do return ZG.TELL(".", ZG._TK.CR) end

end, "DWINDOW-DESC")

ZG.DWINDOW_DESC = ZG.actions:get("DWINDOW_DESC")

-- zil: 2actions.zil:2194  <ROUTINE DWINDOW-FCN ()>
ZG.actions:register("DWINDOW_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The window is an integral part of the floor.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("The window is diamond-hard and cannot be broken.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE", "LOOK-INSIDE")) then
        do return ZG.DWINDOW_DESC() end
    else
        do return false end
    end

end, "DWINDOW-FCN")

ZG.DWINDOW_FCN = ZG.actions:get("DWINDOW_FCN")

-- zil: 2actions.zil:2204  <ROUTINE DIAMOND-MOTION (RARG "AUX" DC DIR RM)>
ZG.actions:register("DIAMOND_MOTION", function(RARG)

    local DC = 0
    local DIR = 0
    local RM = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a room with oddly angled walls and passages in all directions.\nThe walls are made of some glassy substance.", ZG._TK.CR) end
        if ZG.EQ(ZG.HERE, ZG.DIAMOND_5) then
            do local _ = ZG.TELL("A marble stairway leads upward.") end
            if ZG._T(ZG.DIAMOND_SOLVE) then
                do local _ = ZG.TELL(" The floor has swung down at the end of the stairway to reveal a secret\npassage leading down into unrelieved darkness.") end
            end
            do local _ = ZG.CRLF() end
        else
            do local _ = ZG.DWINDOW_DESC() end
        end
        do return true end
    elseif ZG.EQ(RARG, ZG.M_FLASH) then
        do local _ = ZG.DWINDOW_DESC() end
        do return true end
    elseif (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("WALK")) and (not ZG._T(ZG.DIAMOND_SOLVE))) then
        if (ZG.EQUAL_p(ZG.HERE, ZG.DIAMOND_2, ZG.DIAMOND_4) or ZG.EQUAL_p(ZG.HERE, ZG.DIAMOND_6, ZG.DIAMOND_8)) then
            DIR = ZG.GET(ZG.DIDIRS, ZG.SUB(ZG.DIAMOND_COUNT, 1))
            if ZG.EQ(ZG.PRSO, DIR) then
                ZG._set("DIAMOND_COUNT", ZG.ADD(ZG.DIAMOND_COUNT, 1))
                if ZG.LT(ZG.DIAMOND_BASE, ZG.DIAMOND_COUNT) then
                    ZG._set("DIAMOND_BASE", ZG.DIAMOND_COUNT)
                    ZG._set("DIAMOND_MOVES", 0)
                end
                if ZG.EQ(ZG.DIAMOND_COUNT, 5) then
                    do local _ = ZG.TELL("You hear a strange rusty squeal echoing in the distance.", ZG._TK.CR) end
                    do local _ = ZG.FCLEAR(ZG.DIAMOND_5, "TOUCHBIT") end
                    do local _ = ZG.SCORE_UPD(5) end
                    ZG._set("DIAMOND_SOLVE", true)
                end
                if ZG.EQ(ZG.HERE, ZG.DIAMOND_2) then
                    DIR = ZG.DIAMOND_4
                elseif ZG.EQ(ZG.HERE, ZG.DIAMOND_4) then
                    DIR = ZG.DIAMOND_8
                elseif ZG.EQ(ZG.HERE, ZG.DIAMOND_8) then
                    DIR = ZG.DIAMOND_6
                elseif ZG.EQ(ZG.HERE, ZG.DIAMOND_6) then
                    DIR = ZG.DIAMOND_2
                end
                do local _ = ZG.GOTO(DIR) end
            else
                do local _ = ZG.DIAMOND_LOSS() end
            end
            do return true end
        elseif (ZG.EQ(ZG.HERE, ZG.DIAMOND_5) and ZG.EQ(ZG.PRSO, "UP")) then
            do return false end
        else
            ZG._set("DIAMOND_COUNT", 0)
            if ZG._T(ZG.PROB(33)) then
                do local _ = ZG.TELL("There is no way to go in that direction.", ZG._TK.CR) end
                do return true end
            elseif ZG._T(ZG.PROB(25)) then
                do local _ = ZG.DIAMOND_LOSS() end
                do return true end
            else
                ZG._set("DIAMOND_COUNT", 1)
                if ZG.LT(ZG.DIAMOND_BASE, ZG.DIAMOND_COUNT) then
                    ZG._set("DIAMOND_BASE", ZG.DIAMOND_COUNT)
                    ZG._set("DIAMOND_MOVES", 0)
                end
                RM = ZG.GET(ZG.DIAMOND_ROOMS, ZG.SUB(ZG.RANDOM(4), 1))
                if ZG._T(ZG.FSET_p(ZG.BAT, "INVISIBLE")) then
                    do local _ = ZG.FCLEAR(ZG.BAT, "INVISIBLE") end
                    do local _ = ZG.MOVE(ZG.BAT, RM) end
                end
                do local _ = ZG.GOTO(RM) end
                do return true end
            end
        end
    else
        do return false end
    end

end, "DIAMOND-MOTION")

ZG.DIAMOND_MOTION = ZG.actions:get("DIAMOND_MOTION")

-- zil: 2actions.zil:2274  <ROUTINE DIAMOND-LOSS ()>
ZG.actions:register("DIAMOND_LOSS", function()

    ZG._set("DIAMOND_MOVES", ZG.ADD(ZG.DIAMOND_MOVES, 1))
    if ZG.EQ(ZG.DIAMOND_MOVES, 20) then
        do local _ = ZG.TELL("As you thrash about in the maze, the mirthful voice of the Wizard\ntaunts you: \"Fool! You'll never get past ") end
        do local _ = ZG.TELL(ZG.GET(ZG.BASES, ZG.DIAMOND_BASE)) end
        do local _ = ZG.TELL(" base at this rate!\"", ZG._TK.CR) end
    end
    do return ZG.GOTO(ZG.GET(ZG.DIAMOND_ROOMS, ZG.ADD(3, ZG.RANDOM(5)))) end

end, "DIAMOND-LOSS")

ZG.DIAMOND_LOSS = ZG.actions:get("DIAMOND_LOSS")

-- zil: 2actions.zil:2284  <GLOBAL BASES>
-- BASES is declared in ZilGlobal.lua

-- zil: 2actions.zil:2286  <GLOBAL DIAMOND-ROOMS>
-- DIAMOND_ROOMS is declared in ZilGlobal.lua

-- zil: 2actions.zil:2290  <GLOBAL DIDIRS>
-- DIDIRS is declared in ZilGlobal.lua

-- zil: 2actions.zil:2296  <GLOBAL CERBERUS-LEASHED>
-- CERBERUS_LEASHED is declared in ZilGlobal.lua

-- zil: 2actions.zil:2298  <ROUTINE CERBERUS-FCN ()>
ZG.actions:register("CERBERUS_FCN", function()

    if (ZG._T(ZG.VERB_p("WAVE", "RUB", "RAISE")) and ZG.EQ(ZG.PRSO, ZG.WAND)) then
        do local _ = ZG.TELL("The dog looks puzzled.", ZG._TK.CR) end
        do return false end
    elseif (ZG._T(ZG.WAND_ON) and ZG._T(ZG.VERB_p("SAY", "INCANT"))) then
        do return false end
    elseif ZG._T(ZG.HELLO_p(ZG.CERBERUS)) then
        if ZG._T(ZG.CERBERUS_LEASHED) then
            do return ZG.TELL("\"Arf! Arf! Arf!\"", ZG._TK.CR) end
        else
            do return ZG.TELL("\"Grrrr!\"", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG", "STAB")) then
        if ZG._T(ZG.CERBERUS_LEASHED) then
            do local _ = ZG.REMOVE(ZG.CERBERUS) end
            do return ZG.TELL("With a quiet bark of disappointment, the creature expires.\nIts six eyes look at you reproachfully. As it dies, it collapses\ninto a small pile of dust which blows away into nothing.", ZG._TK.CR) end
        elseif ZG._T(ZG.PROB(50)) then
            do return ZG.JIGS_UP("The dog-thing snaps at you viciously, and succeeds. Your head, it seems,\nis only a small mouthful for the poor animal, who is just as hungry\nafterward.") end
        else
            do return ZG.TELL("The maddened dog-thing snaps viciously at you.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("PUT", "PUT-ON")) and ZG.EQ(ZG.PRSO, ZG.COLLAR)) then
        do local _ = ZG.MOVE(ZG.COLLAR, ZG.CERBERUS) end
        do local _ = ZG.FSET(ZG.COLLAR, "NDESCBIT") end
        do local _ = ZG.FSET(ZG.COLLAR, "TRYTAKEBIT") end
        do local _ = ZG.PUTP(ZG.CERBERUS, "LDESC", "An insipidly grinning three-headed dog is wagging its tail here.\nIt is wearing a huge dog collar.") end
        ZG._set("CERBERUS_LEASHED", true)
        do return ZG.TELL("The creature whines happily, then the center head\nlicks your face (which is roughly like experiencing a sandpaper\nwashcloth). The other two heads look about, as though the\nmonster felt a sudden need to find a pair of slippers somewhere.\nIts huge tail wags enthusiastically, knocking small rocks\naround and almost blowing you over from the breeze it creates.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ENCHANT")) then
        if ZG.EQ(ZG.SPELL_USED, ZG.WORD("float")) then
            ZG._set("SPELL_HANDLED_p", true)
            do return ZG.TELL("The huge dog rises about an inch off the ground, for a moment.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.SPELL_USED, ZG.WORD("fierce")) then
            ZG._set("SPELL_HANDLED_p", true)
            do return ZG.JIGS_UP("Cerberus tears you limb from limb! What ferocity!") end
        elseif ZG.EQ(ZG.SPELL_USED, ZG.WORD("feeble")) then
            do return ZG.TELL("What an effect! He now has the strength of just one elephant, rather\nthan ten!", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (not ZG._T(ZG.CERBERUS_LEASHED)) then
        do return ZG.TELL("The three-headed dog snaps at you viciously!", ZG._TK.CR) end
    elseif (ZG._T(ZG.CERBERUS_LEASHED) and ZG._T(ZG.VERB_p("RUB"))) then
        do return ZG.TELL("The dog is now insanely happy, slobbering all over the place and\nwhining with uncontained doggish joy.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CERBERUS-FCN")

ZG.CERBERUS_FCN = ZG.actions:get("CERBERUS_FCN")

-- zil: 2actions.zil:2356  <ROUTINE COLLAR-FCN ()>
ZG.actions:register("COLLAR_FCN", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and ZG._T(ZG.CERBERUS_LEASHED)) then
        do return ZG.JIGS_UP("That wasn't such a good idea. The creature was enjoying being your pet.\nAs you unfasten the collar, the disappointed monster hound begins to growl,\nand then its three fang-crammed mouths rend you into little doggy biscuits.") end
    elseif (ZG._T(ZG.VERB_p("ENCHANT")) and ZG.EQ(ZG.SPELL_USED, ZG.WORD("float"))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?ENCHANT"), ZG.CERBERUS) end
        do return true end
    else
        do return false end
    end

end, "COLLAR-FCN")

ZG.COLLAR_FCN = ZG.actions:get("COLLAR_FCN")

-- zil: 2actions.zil:2370  <GLOBAL ICE-MELTED>
-- ICE_MELTED is declared in ZilGlobal.lua

-- zil: 2actions.zil:2372  <ROUTINE GLACIER-FCN ()>
ZG.actions:register("GLACIER_FCN", function()

    if ZG._T(ZG.VERB_p("MELT")) then
        do return ZG.TELL("This is a big glacier; you'll need a lot of heat.", ZG._TK.CR) end
    else
        do return false end
    end

end, "GLACIER-FCN")

ZG.GLACIER_FCN = ZG.actions:get("GLACIER_FCN")

-- zil: 2actions.zil:2377  <ROUTINE GLACIER-ROOM-FCN (RARG)>
ZG.actions:register("GLACIER_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a large hall of ancient lava, since worn smooth by the movement\nof a glacier. A large passage exits to the east and an upward lava tube\nis at the top of a jumble of fallen rocks.", ZG._TK.CR) end
        if ZG._T(ZG.ICE_MELTED) then
            do local _ = ZG.TELL("A damp and scorched passage leads west. It is still partly full of\nsteam.", ZG._TK.CR) end
        end
        do return true end
    else
        do return false end
    end

end, "GLACIER-ROOM-FCN")

ZG.GLACIER_ROOM_FCN = ZG.actions:get("GLACIER_ROOM_FCN")

-- zil: 2actions.zil:2389  <ROUTINE DRAGON-FCN ()>
ZG.actions:register("DRAGON_FCN", function()

    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_DRAGON, -1)) end
    if ZG._T(ZG.HELLO_p(ZG.DRAGON)) then
        do local _ = ZG.TELL("The dragon looks amused. He speaks in a voice so deep you feel it\nrather than hear it, but the tongue is unknown to you. You find\nyourself almost hypnotized.", ZG._TK.CR) end
        ZG._set("DRAGON_ANGER", ZG.ADD(ZG.DRAGON_ANGER, 2))
        do return ZG.DRAGON_ANGER end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do local _ = ZG.TELL("He turns and looks back at you, his cat's eyes yellow in the gloom.\nYou start to feel weak, and quickly turn away.", ZG._TK.CR) end
        ZG._set("DRAGON_ANGER", ZG.ADD(ZG.DRAGON_ANGER, 1))
        do return ZG.DRAGON_ANGER end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG", "KICK", "LAMP-ON")) then
        if (ZG._T(ZG.VERB_p("LAMP-ON")) or (ZG._T(ZG.VERB_p("ATTACK")) and (not ZG._T(ZG.PRSI)))) then
            do local _ = ZG.TELL("With your bare hands? I doubt the dragon even noticed.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL(ZG.RANDOM_ELEMENT(ZG.DRAGON_ATTACKS), ZG._TK.CR) end
        end
        ZG._set("DRAGON_ANGER", ZG.ADD(ZG.DRAGON_ANGER, 4))
        do return ZG.DRAGON_ANGER end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.DRAGON)) then
        ZG._set("DRAGON_ANGER", ZG.ADD(ZG.DRAGON_ANGER, 1))
        if ZG._T(ZG.GETPT(ZG.PRSO, "VALUE")) then
            do local _ = ZG.MOVE(ZG.PRSO, ZG.CHEST) end
            do return ZG.TELL("The dragon is pleased by your gift, excuses himself for a moment,\nand returns without it.", ZG._TK.CR) end
        elseif ZG._T(ZG.BOMB_p(ZG.PRSO)) then
            ZG._set("DRAGON_ANGER", ZG.ADD(ZG.DRAGON_ANGER, 2))
            do local _ = ZG.REMOVE(ZG.BRICK) end
            do return ZG.TELL("The dragon snakes his long red tongue around the bomb and politely\nswallows it. A few moments later he belches and smoke curls out of\nhis nostrils.", ZG._TK.CR) end
        else
            do return ZG.TELL("The dragon refuses your gift.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("WALK")) and ZG.EQ(ZG.HERE, ZG.DRAGON_ROOM) and ZG.EQ(ZG.PRSO, "NORTH")) then
        ZG._set("DRAGON_ANGER", ZG.ADD(ZG.DRAGON_ANGER, 3))
        do return ZG.TELL("The dragon puts out a claw, grins (all of his sword-sharp teeth\nglinting in the light), and blocks your way.", ZG._TK.CR) end
    else
        do return false end
    end

end, "DRAGON-FCN")

ZG.DRAGON_FCN = ZG.actions:get("DRAGON_FCN")

-- zil: 2actions.zil:2434  <GLOBAL DRAGON-ANGER>
-- DRAGON_ANGER is declared in ZilGlobal.lua

-- zil: 2actions.zil:2436  <GLOBAL DRAGON-ATTACKS>
-- DRAGON_ATTACKS is declared in ZilGlobal.lua

-- zil: 2actions.zil:2446  <ROUTINE HELLO? (WHO)>
ZG.actions:register("HELLO_p", function(WHO)

    if (ZG.EQ(ZG.WINNER, WHO) or ZG._T(ZG.VERB_p("TELL", "ANSWER", "REPLY", "SAY", "HELLO", "INCANT"))) then
        if ZG._T(ZG.VERB_p("TELL", "ANSWER", "SAY", "INCANT", "REPLY")) then
            ZG._set("P_CONT", false)
            ZG._set("QUOTE_FLAG", false)
        end
        do return true end
    else
        do return false end
    end

end, "HELLO?")

ZG.HELLO_p = ZG.actions:get("HELLO_p")

-- zil: 2actions.zil:2454  <ROUTINE FIND-TARGET (TARGET "AUX" P TX L ROOM)>
ZG.actions:register("FIND_TARGET", function(TARGET)

    local P = 0
    local TX = 0
    local L = 0
    local ROOM = 0
    if ZG._T(ZG.IN_p(TARGET, ZG.HERE)) then
        do return ZG.HERE end
    else
        P = 0
        while true do
            if ZG.ZERO_p((function() P = ZG.NEXTP(ZG.HERE, P); return P end)()) then
                do return false end
            elseif (not ZG.LT(P, ZG.LOW_DIRECTION)) then
                TX = ZG.GETPT(ZG.HERE, P)
                L = ZG.PTSIZE(TX)
                if ZG.EQUAL_p(L, ZG.UEXIT, ZG.CEXIT, ZG.DEXIT) then
                    ROOM = ZG.GETB(TX, 0)
                    if ZG._T(ZG.IN_p(TARGET, ROOM)) then
                        do return ROOM end
                    end
                end
            end
        end
    end

end, "FIND-TARGET")

ZG.FIND_TARGET = ZG.actions:get("FIND_TARGET")

-- zil: 2actions.zil:2469  <GLOBAL OLD-HERE>
-- OLD_HERE is declared in ZilGlobal.lua

-- zil: 2actions.zil:2471  <ROUTINE I-DRAGON ("AUX" ROOM)>
ZG.actions:register("I_DRAGON", function()

    local ROOM = 0
    if ZG.LT(6, ZG.DRAGON_ANGER) then
        do local _ = ZG.TELL("The dragon tires of this game. With an almost bored yawn, he opens his\nmouth and ") end
        if ZG.EQ(ZG.SPELL_p, ZG.S_FIREPROOF) then
            do local _ = ZG.TELL("blasts you with a great gout of fire, but it washes over you\nharmlessly.", ZG._TK.CR) end
        else
            do local _ = ZG.DRAGON_LEAVES() end
            do local _ = ZG.JIGS_UP("incinerates you in a blast of white-hot dragon fire.") end
        end
    elseif (ZG._T(ZG.IN_p(ZG.WINNER, ZG.DRAGON_ROOM)) and (not ZG._T(ZG.IN_p(ZG.DRAGON, ZG.DRAGON_ROOM)))) then
        do local _ = ZG.MOVE(ZG.DRAGON, ZG.DRAGON_ROOM) end
        do local _ = ZG.TELL("The dragon doubles back and charges into the room, maddened by your\nattempt to sneak past him. His eyes glow with a white heat of anger.", ZG._TK.CR) end
        if ZG.EQ(ZG.SPELL_p, ZG.S_FIREPROOF) then
            do local _ = ZG.JIGS_UP("A huge ball of flame envelops you, but you don't even feel the heat.\nThe dragon is puzzled, but not too puzzled to crush you in his jaws.") end
        else
            do local _ = ZG.JIGS_UP("Worse for you, his mouth opens and a great gout of flame puffs out\nand consumes you on the spot.") end
        end
    elseif (not ZG.LT(0, ZG.DRAGON_ANGER)) then
        if (ZG._T(ZG.PROB(50)) and ZG._T(ZG.IN_p(ZG.DRAGON, ZG.HERE))) then
            do local _ = ZG.TELL("The dragon looks bored.", ZG._TK.CR) end
        else
            do local _ = ZG.DRAGON_LEAVES() end
            if ZG.EQ(ZG.HERE, ZG.GLACIER_ROOM) then
                do local _ = ZG.TELL("The dragon is no longer around. He must have become bored with you.", ZG._TK.CR) end
            elseif ZG.EQ(ZG.HERE, ZG.OLD_HERE) then
                do local _ = ZG.TELL("The dragon seems to have lost interest in you.") end
                if ZG.EQ(ZG.OLD_HERE, ZG.DRAGON_ROOM) then
                    do local _ = ZG.CRLF() end
                else
                    do local _ = ZG.TELL(" He wanders off.", ZG._TK.CR) end
                end
            end
        end
    else
        ROOM = ZG.FIND_TARGET(ZG.WINNER)
        if (not ZG._T(ROOM)) then
            if ZG._T(ZG.PROB(25)) then
                do local _ = ZG.DRAGON_LEAVES() end
            end
        elseif (ZG.EQUAL_p(ROOM, ZG.CAROUSEL_ROOM, ZG.TINY_ROOM) or ZG.EQUAL_p(ROOM, ZG.RAVINE_LEDGE, ZG.FRESCO_ROOM)) then
            if ZG._T(ZG.PROB(25)) then
                do local _ = ZG.DRAGON_LEAVES() end
            end
            do local _ = ZG.TELL("The dragon will follow no further.", ZG._TK.CR) end
        elseif ZG.EQ(ROOM, ZG.GLACIER_ROOM) then
            do local _ = ZG.TELL(ZG._TK.CR, "As the dragon enters, he sees his reflection on the icy surface of the\nglacier at its western end. He becomes enraged: There is another dragon here,\nbehind that glass, he thinks! Dragons are smart, but sometimes naive, and\nthis one has never seen ice before. He rears up to his full height to\nchallenge this intruder into his territory. He roars a challenge! The\nintruder responds! The dragon takes a deep breath, and out of his mouth\npours a massive gout of flame. It washes over the ice, which melts rapidly,\nsending out torrents of water and a huge cloud of steam! You manage to clamber\nup to a small shelf, but the dragon is terrified! A huge splash goes down his\nthroat! There is a muffled explosion and the dragon, a puzzled expression on\nhis face, dies. He is carried away by the water.\n\nWhen the flood recedes you climb gingerly down. While no trace of\nthe dragon can be found, the melting of the ice has revealed a passage\nleading west.", ZG._TK.CR) end
            do local _ = ZG.REMOVE(ZG.DRAGON) end
            do local _ = ZG.REMOVE(ZG.ICE) end
            do local _ = ZG.MOVE(ZG.DEAD_DRAGON, ZG.DEEP_FORD) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_DRAGON)) end
            do local _ = ZG.SCORE_UPD(5) end
            ZG._set("ICE_MELTED", true)
        else
            if (not ZG.EQ(ROOM, ZG.OLD_HERE)) then
                do local _ = ZG.MOVE(ZG.DRAGON, ROOM) end
                do local _ = ZG.TELL("The dragon follows you, out of mingled curiosity and anger.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The dragon continues to watch you carefully.", ZG._TK.CR) end
            end
            if (not ZG.LT(0, ZG.DRAGON_ANGER)) then
                ZG._set("DRAGON_ANGER", 0)
                do local _ = ZG.DISABLE(ZG.INT(ZG.I_DRAGON)) end
            end
        end
    end
    ZG._set("OLD_HERE", ZG.LOC(ZG.DRAGON))
    ZG._set("DRAGON_ANGER", ZG.SUB(ZG.DRAGON_ANGER, 2))
    if ZG.LT(ZG.DRAGON_ANGER, 0) then
        ZG._set("DRAGON_ANGER", 0)
    end
    do return true end

end, "I-DRAGON")

ZG.I_DRAGON = ZG.actions:get("I_DRAGON")

-- zil: 2actions.zil:2559  <ROUTINE DRAGON-LEAVES ()>
ZG.actions:register("DRAGON_LEAVES", function()

    if (not ZG._T(ZG.LOC(ZG.DEAD_DRAGON))) then
        do local _ = ZG.MOVE(ZG.DRAGON, ZG.DRAGON_ROOM) end
        ZG._set("DRAGON_ANGER", 0)
        do return ZG.DISABLE(ZG.INT(ZG.I_DRAGON)) end
    else
        do return false end
    end

end, "DRAGON-LEAVES")

ZG.DRAGON_LEAVES = ZG.actions:get("DRAGON_LEAVES")

-- zil: 2actions.zil:2565  <ROUTINE I-GARDEN ()>
ZG.actions:register("I_GARDEN", function()

    if (ZG.EQUAL_p(ZG.HERE, ZG.GARDEN_NORTH, ZG.GAZEBO_ROOM) or ZG.EQUAL_p(ZG.HERE, ZG.TOPIARY_ROOM, ZG.FORMAL_GARDEN)) then
        if (ZG._T(ZG.IN_p(ZG.UNICORN, ZG.GARDEN_NORTH)) and ZG._T(ZG.PROB(33))) then
            do local _ = ZG.REMOVE(ZG.UNICORN) end
            if (not ZG.EQ(ZG.HERE, ZG.TOPIARY_ROOM)) then
                do return ZG.TELL("The unicorn bounds lightly away.", ZG._TK.CR) end
            else
                do return false end
            end
        elseif (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.DRAGON_LAIR)) and (not ZG._T(ZG.IN_p(ZG.UNICORN, ZG.GARDEN_NORTH))) and ZG._T(ZG.PROB(25)) and (not ZG.EQ(ZG.HERE, ZG.TOPIARY_ROOM))) then
            if ZG._T(ZG.UNICORN_FRIGHTENED) then
                ZG._set("UNICORN_FRIGHTENED", false)
                do return false end
            end
            do local _ = ZG.MOVE(ZG.UNICORN, ZG.GARDEN_NORTH) end
            if ZG.EQ(ZG.HERE, ZG.GARDEN_NORTH) then
                do return ZG.TELL(ZG.RANDOM_ELEMENT(ZG.UNICORN_MSGS), ZG._TK.CR) end
            else
                do return ZG.TELL("A unicorn is peacefully cropping grass at the north end of the garden.\nThere is something hanging around its neck.", ZG._TK.CR) end
            end
        elseif ZG.EQ(ZG.HERE, ZG.TOPIARY_ROOM) then
            if ((not ZG._T(ZG.TOPIARY_MOVED)) and ZG._T(ZG.PROB(12))) then
                ZG._set("TOPIARY_MOVED", true)
                do return ZG.TELL("You look around, and strangely, the topiary animals seem to have\nchanged position slightly.", ZG._TK.CR) end
            elseif (ZG._T(ZG.TOPIARY_MOVED) and (not ZG._T(ZG.TOPIARY_NEAR)) and ZG._T(ZG.PROB(8))) then
                ZG._set("TOPIARY_NEAR", true)
                do return ZG.TELL("The topiary animals seem to close in on you. You turn and they are\nvery close. They seem to be leering at you.", ZG._TK.CR) end
            elseif (ZG._T(ZG.TOPIARY_NEAR) and ZG._T(ZG.PROB(4))) then
                ZG._set("TOPIARY_MOVED", false)
                ZG._set("TOPIARY_NEAR", false)
                do return ZG.JIGS_UP("The topiary animals attack! You are crushed by their branches and\nclawed by their thorns.") end
            else
                do return false end
            end
        else
            do return false end
        end
    else
        do local _ = ZG.REMOVE(ZG.UNICORN) end
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_GARDEN)) end
        do return false end
    end

end, "I-GARDEN")

ZG.I_GARDEN = ZG.actions:get("I_GARDEN")

-- zil: 2actions.zil:2610  <GLOBAL TOPIARY-MOVED>
-- TOPIARY_MOVED is declared in ZilGlobal.lua

-- zil: 2actions.zil:2611  <GLOBAL TOPIARY-NEAR>
-- TOPIARY_NEAR is declared in ZilGlobal.lua

-- zil: 2actions.zil:2613  <GLOBAL UNICORN-MSGS>
-- UNICORN_MSGS is declared in ZilGlobal.lua

-- zil: 2actions.zil:2622  <ROUTINE GARDEN-ROOM-FCN (RARG)>
ZG.actions:register("GARDEN_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_GARDEN, -1)) end
    else
        do return false end
    end

end, "GARDEN-ROOM-FCN")

ZG.GARDEN_ROOM_FCN = ZG.actions:get("GARDEN_ROOM_FCN")

-- zil: 2actions.zil:2626  <ROUTINE GLOBAL-UNICORN-FCN ()>
ZG.actions:register("GLOBAL_UNICORN_FCN", function()

    if ZG._T(ZG.IN_p(ZG.UNICORN, ZG.GARDEN_NORTH)) then
        do return ZG.TELL("The unicorn is way up at the north end of the garden.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FIND", "FOLLOW")) then
        if ZG._T(ZG.FSET_p(ZG.UNICORN, "TOUCHBIT")) then
            do return ZG.TELL("I don't know where it is now.", ZG._TK.CR) end
        else
            do return ZG.TELL("The unicorn is a mythical beast.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("Unicorn? What unicorn?", ZG._TK.CR) end
    end

end, "GLOBAL-UNICORN-FCN")

ZG.GLOBAL_UNICORN_FCN = ZG.actions:get("GLOBAL_UNICORN_FCN")

-- zil: 2actions.zil:2639  <ROUTINE UNICORN-FCN ()>
ZG.actions:register("UNICORN_FCN", function()

    if ZG._T(ZG.HELLO_p(ZG.UNICORN)) then
        do return ZG.TELL("The unicorn listens distractedly, then goes back to cropping grass.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FOLLOW")) then
        do return ZG.TELL("The unicorn shies away as you approach.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("EXAMINE")) and ZG.EQ(ZG.PRSO, ZG.UNICORN)) then
        do return ZG.TELL("The unicorn shies away as you approach for a closer look, but you do\nnotice a tiny gold key hanging from a red satin ribbon looped around\nthe animal's neck.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The unicorn shies away as you approach.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TAKE", "PUT", "RUB", "MUNG", "ATTACK")) then
        do local _ = ZG.REMOVE(ZG.UNICORN) end
        ZG._set("UNICORN_FRIGHTENED", true)
        do return ZG.TELL("The unicorn, unsurprised by this evidence that you are indeed the\nuncouth sort of vagabond it suspected you were, melts into the hedges\nand is gone.", ZG._TK.CR) end
    else
        do return false end
    end

end, "UNICORN-FCN")

ZG.UNICORN_FCN = ZG.actions:get("UNICORN_FCN")

-- zil: 2actions.zil:2661  <GLOBAL UNICORN-FRIGHTENED>
-- UNICORN_FRIGHTENED is declared in ZilGlobal.lua

-- zil: 2actions.zil:2663  <ROUTINE GAZEBO-FCN ()>
ZG.actions:register("GAZEBO_FCN", function()

    if (ZG.EQ(ZG.HERE, ZG.GARDEN_NORTH) and ZG._T(ZG.VERB_p("THROUGH"))) then
        do local _ = ZG.DO_WALK("IN") end
        do return true end
    elseif (ZG.EQ(ZG.HERE, ZG.GAZEBO_ROOM) and ZG._T(ZG.VERB_p("THROUGH"))) then
        do return ZG.TELL("You're already in it.", ZG._TK.CR) end
    elseif (ZG.EQ(ZG.HERE, ZG.GAZEBO_ROOM) and ZG._T(ZG.VERB_p("LEAVE", "EXIT"))) then
        do local _ = ZG.DO_WALK("OUT") end
        do return true end
    else
        do return false end
    end

end, "GAZEBO-FCN")

ZG.GAZEBO_FCN = ZG.actions:get("GAZEBO_FCN")

-- zil: 2actions.zil:2672  <ROUTINE CHEST-FCN ()>
ZG.actions:register("CHEST_FCN", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.PROB(25)) then
            do local _ = ZG.V_OPEN() end
            if (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.HERE)) and (not ZG._T(ZG.PRINCESS_AWAKE))) then
                do local _ = ZG.TELL("The opening of the squeaky lid startles the young woman.", ZG._TK.CR) end
            end
        else
            do local _ = ZG.TELL("The hinges are very rusty, but they seem to be starting to give.\nYou can probably open it if you try again. There is something\nbumping around inside.") end
            if (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.HERE)) and (not ZG._T(ZG.PRINCESS_AWAKE))) then
                do local _ = ZG.TELL(" All this rummaging around has startled\nthe young woman.") end
            end
            do local _ = ZG.CRLF() end
        end
        do local _ = ZG.PUTP(ZG.CHEST, "ACTION", 0) end
        if (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.HERE)) and (not ZG._T(ZG.PRINCESS_AWAKE))) then
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?ALARM"), ZG.PRINCESS) end
        end
        do return true end
    else
        do return false end
    end

end, "CHEST-FCN")

ZG.CHEST_FCN = ZG.actions:get("CHEST_FCN")

-- zil: 2actions.zil:2697  <GLOBAL PRINCESS-AWAKE>
-- PRINCESS_AWAKE is declared in ZilGlobal.lua

-- zil: 2actions.zil:2699  <ROUTINE PRINCESS-FCN ("AUX" (DEM <INT I-PRINCESS>))>
ZG.actions:register("PRINCESS_FCN", function()

    local DEM = ZG.INT(ZG.I_PRINCESS)
    if ZG._T(ZG.VERB_p("FOLLOW")) then
        if ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.HERE)) then
            do local _ = ZG.TELL("You can't follow her until she leaves...", ZG._TK.CR) end
        elseif ZG._T(ZG.PRFOLLOW) then
            do local _ = ZG.DO_WALK(ZG.PRFOLLOW) end
        else
            do local _ = ZG.TELL("I seem to have lost track of her.", ZG._TK.CR) end
        end
        do return true end
    elseif (not ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.HERE))) then
        do return ZG.TELL("There is no princess here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG", "RAPE")) then
        do local _ = ZG.REMOVE(ZG.PRINCESS) end
        do local _ = ZG.TELL("The princess screams as you approach. \"Won't someone deliver\nme from this awful fate?\" she cries. ") end
        if ZG._T(ZG.IN_p(ZG.WIZARD, ZG.HERE)) then
            do local _ = ZG.TELL("Shocked, the Wizard of Frobozz turns toward you.") end
        else
            do local _ = ZG.TELL("Just in time, the Wizard of Frobozz\nappears, seeming to unroll himself out of nothing like a window shade.") end
        end
        do local _ = ZG.TELL(" \"Fry!\" he intones, and a massive bolt of lightning reduces you to a pile\nof smoking ashes. (Serves you right, too, if you ask me.)") end
        do return ZG.JIGS_UP() end
    elseif (ZG._T(ZG.HELLO_p(ZG.PRINCESS)) or ZG._T(ZG.VERB_p("ALARM", "KISS", "EXAMINE", "RUB"))) then
        if (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.DRAGON_LAIR)) and ZG.EQ(ZG.GET(DEM, ZG.C_ENABLED_p), 0)) then
            do local _ = ZG.PUTP(ZG.PRINCESS, "LDESC", "There is a dishevelled and slightly unkempt princess here.") end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_PRINCESS, 2)) end
            ZG._set("PRINCESS_AWAKE", true)
            do return ZG.TELL("The princess (for she is obviously one) shakes herself awake, then\nnotices you for the first time. She smiles. \"Thank you for rescuing\nme from that horrid worm,\" she says. \"I must depart. My parents will\nbe worried about me.\" With that, she arises, looking purposefully out\nof the lair.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The princess ignores you. She looks about the room, but her eyes\nfix on the ") end
            if ZG.EQ(ZG.HERE, ZG.GAZEBO_ROOM) then
                do local _ = ZG.TELL("garden outside") end
            elseif ZG.EQ(ZG.HERE, ZG.GARDEN_NORTH) then
                do local _ = ZG.TELL("gazebo") end
            elseif ZG.EQ(ZG.HERE, ZG.RAVINE_LEDGE) then
                do local _ = ZG.TELL("ledge") end
            else
                do local _ = ZG.TELL(ZG.GET(ZG.PRDIRS, (ZG.PRCOUNT * 4))) end
            end
            do return ZG.TELL(".", ZG._TK.CR) end
        end
    elseif (not ZG._T(ZG.PRINCESS_AWAKE)) then
        do return ZG.TELL("She's in a trance!", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRINCESS-FCN")

ZG.PRINCESS_FCN = ZG.actions:get("PRINCESS_FCN")

-- zil: 2actions.zil:2755  <GLOBAL PRCOUNT>
-- PRCOUNT is declared in ZilGlobal.lua

-- zil: 2actions.zil:2757  <GLOBAL PRFOLLOW>
-- PRFOLLOW is declared in ZilGlobal.lua

-- zil: 2actions.zil:2759  <GLOBAL PRDIRS>
-- PRDIRS is declared in ZilGlobal.lua

-- zil: 2actions.zil:2770  <ROUTINE I-PRINCESS ("AUX" (DEM <INT I-PRINCESS>) (OLDP <LOC ,PRINCESS>) (PC ...
ZG.actions:register("I_PRINCESS", function()

    local _tmp1, _tmp2, _tmp3, _tmp4
    local DEM = ZG.INT(ZG.I_PRINCESS)
    local OLDP = ZG.LOC(ZG.PRINCESS)
    local PC = (ZG.PRCOUNT * 4)
    do local _ = ZG.MOVE(ZG.PRINCESS, ZG.GET(ZG.PRDIRS, ZG.ADD(PC, 1))) end
    ZG._set("PRFOLLOW", false)
    if (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.STREAM_PATH)) and ZG._T(ZG.IN_p(ZG.WINNER, ZG.MARBLE_HALL))) then
        do local _ = ZG.TELL("The princess presses a loose piece of marble in the wall and a large\nsection of the wall slides away, revealing a passage to the east. She\nenters it.", ZG._TK.CR) end
        if ZG._T(ZG.IN_p(ZG.WINNER, OLDP)) then
            ZG._set("PRFOLLOW", ZG.GET(ZG.PRDIRS, ZG.ADD(PC, 3)))
        end
        ZG._set("SECRET_DOOR", true)
    elseif (ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.STREAM_PATH)) and ZG._T(ZG.IN_p(ZG.WINNER, ZG.STREAM_PATH))) then
        ZG._set("SECRET_DOOR", true)
        do local _ = ZG.TELL("The princess appears from behind some rocks, as though she had walked\nthrough a wall.", ZG._TK.CR) end
    elseif ZG._T(ZG.IN_p(ZG.WINNER, OLDP)) then
        ZG._set("PRFOLLOW", ZG.GET(ZG.PRDIRS, ZG.ADD(PC, 3)))
        if ZG.EQ(OLDP, ZG.GARDEN_NORTH) then
            do local _ = ZG.TELL("The princess enters the gazebo") end
            if ZG._T(ZG.FSET_p(ZG.GAZEBO_ROOM, "RMUNGBIT")) then
                do local _ = ZG.TELL(", although you would never get past\nthe debris. She must be magically protected.") end
            end
            do local _ = ZG.TELL(".", ZG._TK.CR) end
        elseif ZG.EQ(OLDP, ZG.RAVINE_LEDGE) then
            do local _ = ZG.TELL("The princess climbs daintily down the rock face.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The princess walks ") end
            do local _ = ZG.TELL(ZG.GET(ZG.PRDIRS, PC)) end
            do local _ = ZG.TELL(". She glances back at you as she goes.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.HERE)) then
        if ZG.EQ(ZG.HERE, ZG.GAZEBO_ROOM) then
            do local _ = ZG.TELL("The princess joins you in the gazebo.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.HERE, ZG.DEEP_FORD) then
            do local _ = ZG.TELL("The princess climbs down the rock wall onto the beach.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The princess enters from the ") end
            do local _ = ZG.TELL(ZG.GET(ZG.PRDIRS, ZG.ADD(2, PC))) end
            do local _ = ZG.TELL(". She seems surprised to see you.", ZG._TK.CR) end
        end
    end
    if ZG._T(ZG.IN_p(ZG.PRINCESS, ZG.GAZEBO_ROOM)) then
        do local _ = ZG.DISABLE(DEM) end
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_UNICORN, 6)) end
    else
        ZG._set("PRCOUNT", ZG.ADD(ZG.PRCOUNT, 1))
        if ZG._T(ZG.PROB(75)) then
            _tmp1 = 1
        else
            _tmp1 = 2
        end
        if ZG._T(ZG.PROB(75)) then
            _tmp2 = 1
        else
            _tmp2 = 2
        end
        if ZG._T(ZG.PROB(75)) then
            _tmp3 = 1
        else
            _tmp3 = 2
        end
        if ZG._T(ZG.PROB(75)) then
            _tmp4 = 1
        else
            _tmp4 = 2
        end
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_PRINCESS, _tmp4)) end
    end
    do return true end

end, "I-PRINCESS")

ZG.I_PRINCESS = ZG.actions:get("I_PRINCESS")

-- zil: 2actions.zil:2822  <ROUTINE I-UNICORN ()>
ZG.actions:register("I_UNICORN", function()

    if ZG.EQUAL_p(ZG.HERE, ZG.GAZEBO_ROOM, ZG.GARDEN_NORTH) then
        do local _ = ZG.MOVE(ZG.ROSE, ZG.WINNER) end
        do local _ = ZG.FCLEAR(ZG.GOLD_KEY, "NDESCBIT") end
        do local _ = ZG.MOVE(ZG.GOLD_KEY, ZG.WINNER) end
        do local _ = ZG.SCORE_OBJ(ZG.GOLD_KEY) end
        do local _ = ZG.PUTP(ZG.GOLD_KEY, "ACTION", 0) end
        do local _ = ZG.TELL("Shyly, a unicorn peeks out of the hedges. It notices the princess and\nseems captivated. It approaches her and bows its head as though curtseying\nto her. Around its neck is a red satin ribbon on which is strung a delicate\ngold key. The princess takes the ribbon and uses it to tie up her hair. She\nlooks at you and then, smiling, hands you the key and a fresh rose which she\nplucks from the arbor. \"You may have use of such a thing,\" she says. \"It\nis the least I can do for one who rescued me from a fate I dare not\ncontemplate.\" With that, she mounts the unicorn (side-saddle, of course)\nand rides off into the gloom.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.PRINCESS) end
    else
        do local _ = ZG.REMOVE(ZG.PRINCESS) end
        do local _ = ZG.MOVE(ZG.ROSE, ZG.GAZEBO_ROOM) end
        do return false end
    end

end, "I-UNICORN")

ZG.I_UNICORN = ZG.actions:get("I_UNICORN")

-- zil: 2actions.zil:2849  <ROUTINE MENHIR-ROOM-FCN (RARG)>
ZG.actions:register("MENHIR_ROOM_FCN", function(RARG)

    if (ZG.EQ(RARG, ZG.M_FLASH) and ZG._T(ZG.MENHIR_POSITION)) then
        do return ZG.DESCRIBE_MENHIR() end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a large room which was evidently used once as a quarry. Many\nlarge limestone chunks lie helter-skelter around the room. Some are\nrough-hewn and unworked, others smooth and well-finished. One side of\nthe room appears to have been used to quarry building blocks, the other\nto produce menhirs (standing stones). Obvious passages lead north and\nsouth.", ZG._TK.CR) end
        if ZG._T(ZG.IN_p(ZG.MENHIR, ZG.LOCAL_GLOBALS)) then
            do local _ = ZG.DESCRIBE_MENHIR() end
        end
        do return true end
    else
        do return false end
    end

end, "MENHIR-ROOM-FCN")

ZG.MENHIR_ROOM_FCN = ZG.actions:get("MENHIR_ROOM_FCN")

-- zil: 2actions.zil:2864  <ROUTINE DESCRIBE-MENHIR ()>
ZG.actions:register("DESCRIBE_MENHIR", function()

    if ZG.EQ(ZG.HERE, ZG.MENHIR_ROOM) then
        if ZG.EQ(ZG.MENHIR_POSITION, false) then
            do local _ = ZG.TELL("One particularly large menhir, at least twenty feet tall and eight feet\nthick, is leaning against the wall blocking a dark opening leading\nsouthwest. On this side of the menhir is carved an ornate letter \"F\".", ZG._TK.CR) end
        elseif ZG.EQ(ZG.MENHIR_POSITION, 1) then
            do local _ = ZG.TELL("There is a huge menhir lying on the floor near a southwest passage.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.MENHIR_POSITION, 2) then
            do local _ = ZG.TELL("A dark opening leads southwest.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.MENHIR_POSITION, 3) then
            do local _ = ZG.TELL("There is a huge menhir here.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("There is a huge menhir floating like a feather in midair here. A\npassage to the southwest opens beneath it.", ZG._TK.CR) end
        end
        if ZG.EQ(ZG.HERE, ZG.MUNGED_ROOM) then
            do local _ = ZG.TELL("The explosion appears to have had no effect on the menhir.", ZG._TK.CR) end
        end
        do return true end
    else
        do return ZG.TELL("A dark opening leads southwest.", ZG._TK.CR) end
    end

end, "DESCRIBE-MENHIR")

ZG.DESCRIBE_MENHIR = ZG.actions:get("DESCRIBE_MENHIR")

-- zil: 2actions.zil:2889  <GLOBAL MENHIR-POSITION>
-- MENHIR_POSITION is declared in ZilGlobal.lua

-- zil: 2actions.zil:2891  <ROUTINE MENHIR-FCN ()>
ZG.actions:register("MENHIR_FCN", function()

    if ZG._T(ZG.VERB_p("LOOK-UNDER", "LOOK-BEHIND")) then
        if ZG._T(ZG.MENHIR_POSITION) then
            do return ZG.TELL("Behind the menhir is some air and then a wall.", ZG._TK.CR) end
        else
            do return ZG.TELL("The gap between the menhir and the wall is very narrow, but it is clear\nthat there is a sizeable room in there. Your light only reveals a part of\nthe far wall.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("TAKE", "MOVE", "TURN")) then
        do return ZG.TELL("The menhir weighs many tons and is eight feet wide. You can't even get\na grip on it, much less move it.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("READ")) then
        do return ZG.TELL("\"F\"", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("It is nicely finished, and the letter \"F\" on it is particularly well\ncarved.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("ENCHANT")) and ZG.EQ(ZG.SPELL_USED, ZG.WORD("float"))) then
        do local _ = ZG.TELL("The menhir floats majestically into the air, rising about ten feet.\nThe passage beneath it beckons invitingly.", ZG._TK.CR) end
        ZG._set("MENHIR_POSITION", 3)
        do return ZG.MENHIR_POSITION end
    elseif (ZG._T(ZG.VERB_p("DISENCHANT")) and ZG.EQ(ZG.SPELL_USED, ZG.WORD("float"))) then
        ZG._set("MENHIR_POSITION", false)
        if ZG.EQUAL_p(ZG.HERE, ZG.MENHIR_ROOM, ZG.KENNEL) then
            do return ZG.TELL("The menhir sinks to the ground.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "MENHIR-FCN")

ZG.MENHIR_FCN = ZG.actions:get("MENHIR_FCN")

-- zil: 2actions.zil:2922  <GLOBAL GUARDIAN-FED>
-- GUARDIAN_FED is declared in ZilGlobal.lua

-- zil: 2actions.zil:2924  <ROUTINE DOOR-KEEPER-FCN ()>
ZG.actions:register("DOOR_KEEPER_FCN", function()

    if (ZG._T(ZG.VERB_p("ALARM")) and ZG._T(ZG.GUARDIAN_FED)) then
        do return ZG.TELL("Try as you may, you can't wake it.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.DOOR_KEEPER)) then
        if ZG._T(ZG.GUARDIAN_FED) then
            do return ZG.TELL("He is asleep, at least for the moment.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSO, ZG.CANDY) then
            ZG._set("GUARDIAN_FED", true)
            do local _ = ZG.REMOVE(ZG.CANDY) end
            do return ZG.TELL("The guardian greedily wolfs down the candy, including the package. (It\nseemed to enjoy the grasshoppers particularly.) It then becomes\nquiet and its eyes close. (Lizards are known to sleep a long time while\ndigesting their meals.)", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSO, ZG.FLASK) then
            do return ZG.TELL("The lizard sniffs it experimentally, then looks at you angrily, hissing\nand snapping.", ZG._TK.CR) end
        elseif ZG._T(ZG.BOMB_p(ZG.PRSO)) then
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do return ZG.TELL("The guardian greedily wolfs it down. After a while, you hear a\nvery small pop and the guardian's eyes bulge out. It hisses nastily\nat you.", ZG._TK.CR) end
        elseif ZG.EQUAL_p(ZG.PRSO, ZG.PALANTIR_1, ZG.PALANTIR_2, ZG.PALANTIR_3) then
            do local _ = ZG.TELL("The guardian greedily gobbles the sphere, but finds it unchewable. He\nthen tries repeatedly to swallow it whole, with disappointing results.\nFinally, he spits it on the ground.", ZG._TK.CR) end
            do return ZG.MOVE(ZG.PRSO, ZG.HERE) end
        else
            do local _ = ZG.REMOVE(ZG.PRSO) end
            do return ZG.TELL("The lizard wolfs down the ", ZG._TK.D, ZG.PRSO, ", crunching greedily.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        do return ZG.TELL("The guardian seems impervious to your attack. In fact, your blows\ndon't even seem to be landing.", ZG._TK.CR) end
    else
        do return false end
    end

end, "DOOR-KEEPER-FCN")

ZG.DOOR_KEEPER_FCN = ZG.actions:get("DOOR_KEEPER_FCN")

-- zil: 2actions.zil:2964  <GLOBAL WIZ-DOOR-FLAG>
-- WIZ_DOOR_FLAG is declared in ZilGlobal.lua

-- zil: 2actions.zil:2966  <ROUTINE WIZ-DOOR-FCN ()>
ZG.actions:register("WIZ_DOOR_FCN", function()

    if (not ZG._T(ZG.GUARDIAN_FED)) then
        if ZG._T(ZG.VERB_p("OPEN")) then
            do return ZG.TELL("The lizard comes to life and snaps at you as you reach for the\nhandle.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("UNLOCK")) then
            do local _ = ZG.TELL("The lizard door keeper comes awake and bites at your hand. You\njerk away just in time.") end
            if (ZG.EQ(ZG.PRSI, ZG.GOLD_KEY) and ZG._T(ZG.PROB(5))) then
                do local _ = ZG.REMOVE(ZG.GOLD_KEY) end
                do return ZG.TELL(" The guardian does get the\nkey, though. It grins maniacally.", ZG._TK.CR) end
            elseif ZG._T(ZG.PROB(20)) then
                do local _ = ZG.MOVE(ZG.GOLD_KEY, ZG.HERE) end
                do return ZG.TELL(" You drop the key, though.", ZG._TK.CR) end
            else
                do return ZG.CRLF() end
            end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("UNLOCK")) then
        if ZG._T(ZG.WIZ_DOOR_FLAG) then
            do return ZG.TELL("It is already!", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSI, ZG.GOLD_KEY) then
            ZG._set("WIZ_DOOR_FLAG", true)
            do return ZG.TELL("The key turns and the bolt clicks. The door is unlocked.", ZG._TK.CR) end
        else
            ZG._set("WIZ_DOOR_FLAG", false)
            do return ZG.TELL("That won't unlock it.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LOCK")) then
        if (not ZG._T(ZG.WIZ_DOOR_FLAG)) then
            do return ZG.TELL("It is locked already.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSI, ZG.GOLD_KEY) then
            do local _ = ZG.TELL("The door is now locked.", ZG._TK.CR) end
            ZG._set("WIZ_DOOR_FLAG", false)
            do return true end
        else
            do return ZG.TELL("That won't lock it.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        if ZG._T(ZG.WIZ_DOOR_FLAG) then
            do return ZG.OPEN_CLOSE(ZG.PRSO, "The door creaks open.", "The door reluctantly closes.") end
        elseif ZG._T(ZG.VERB_p("OPEN")) then
            do return ZG.TELL("The door is locked!", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "WIZ-DOOR-FCN")

ZG.WIZ_DOOR_FCN = ZG.actions:get("WIZ_DOOR_FCN")

-- zil: 2actions.zil:3010  <ROUTINE GUARDIAN-ROOM-FCN (RARG)>
ZG.actions:register("GUARDIAN_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This room is cobwebby and musty, but tracks in the dust show that it has\nseen visitors recently. At the south end of the room is a stained and\nbattered (but very strong-looking) door. To the north, a corridor exits.", ZG._TK.CR) end
        if ZG._T(ZG.FSET_p(ZG.WIZ_DOOR, "OPENBIT")) then
            do local _ = ZG.TELL("The door is open.", ZG._TK.CR) end
        end
        if (not ZG._T(ZG.GUARDIAN_FED)) then
            do local _ = ZG.TELL("Imbedded in the door is a nasty-looking lizard head, with sharp\nteeth and beady eyes. ") end
            if ZG._T(ZG.IN_p(ZG.CANDY, ZG.WINNER)) then
                do return ZG.TELL("The lizard is sniffing at you.", ZG._TK.CR) end
            else
                do return ZG.TELL("The eyes move to watch you approach.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("A sleepy-looking lizard head is mounted on the door.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "GUARDIAN-ROOM-FCN")

ZG.GUARDIAN_ROOM_FCN = ZG.actions:get("GUARDIAN_ROOM_FCN")

-- zil: 2actions.zil:3031  <ROUTINE WORKSHOP-FCN (RARG)>
ZG.actions:register("WORKSHOP_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are standing in the entry hall of the Wizard's Workshop. Dark\ncorridors lead west and south from here. The corridor to the west\nsmells slightly of incense or candle smoke.") end
        if ZG._T(ZG.FSET_p(ZG.WIZ_DOOR, "OPENBIT")) then
            do local _ = ZG.TELL(" The workshop door is open.") end
        end
        do local _ = ZG.CRLF() end
        do return true end
    else
        do return false end
    end

end, "WORKSHOP-FCN")

ZG.WORKSHOP_FCN = ZG.actions:get("WORKSHOP_FCN")

-- zil: 2actions.zil:3042  <ROUTINE ARCANA-PSEUDO ()>
ZG.actions:register("ARCANA_PSEUDO", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The stuff on the bench appears to be so much junk, and you decide that\nit would only get in your way if you took it.", ZG._TK.CR) end
    else
        do return false end
    end

end, "ARCANA-PSEUDO")

ZG.ARCANA_PSEUDO = ZG.actions:get("ARCANA_PSEUDO")

-- zil: 2actions.zil:3048  <ROUTINE TROPHY-PSEUDO ()>
ZG.actions:register("TROPHY_PSEUDO", function()

    if ZG._T(ZG.VERB_p("READ")) then
        do return false end
    elseif ZG._T(ZG.VERB_p("TAKE", "RUB")) then
        do return ZG.TELL("As your fingers near it, you get a nasty shock (but fortunately not a fatal\none).", ZG._TK.CR) end
    else
        do return false end
    end

end, "TROPHY-PSEUDO")

ZG.TROPHY_PSEUDO = ZG.actions:get("TROPHY_PSEUDO")

-- zil: 2actions.zil:3055  <ROUTINE STAND-FCN ()>
ZG.actions:register("STAND_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is firmly attached to the bench.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT", "PUT-ON")) and ZG.EQUAL_p(ZG.PRSO, ZG.PALANTIR_1, ZG.PALANTIR_2, ZG.PALANTIR_3) and ZG.EQUAL_p(ZG.PRSI, ZG.STAND_1, ZG.STAND_2, ZG.STAND_3)) then
        do local _ = ZG.V_PUT() end
        if (ZG._T(ZG.IN_p(ZG.PALANTIR_1, ZG.STAND_1)) and ZG._T(ZG.IN_p(ZG.PALANTIR_2, ZG.STAND_2)) and ZG._T(ZG.IN_p(ZG.PALANTIR_3, ZG.STAND_3))) then
            do local _ = ZG.REMOVE(ZG.PALANTIR_1) end
            do local _ = ZG.REMOVE(ZG.PALANTIR_2) end
            do local _ = ZG.REMOVE(ZG.PALANTIR_3) end
            do local _ = ZG.MOVE(ZG.STAND_4, ZG.WORKBENCH) end
            do local _ = ZG.TELL("As you place the ", ZG._TK.D, ZG.PRSO, " in the ", ZG._TK.D, ZG.PRSI, ", a low humming noise\nbegins, and you can feel the hairs on the back of your neck begin to\nstand up. The three spheres begin to vibrate, faster and faster, as\nthe noise becomes higher and higher pitched. Three puffs of smoke, one\nred, one blue, one white, rise up from empty stands. The spheres are gone!\nBut in the center of the triangle formed by the stands is now a black stand\nof obsidian in which rests a strange black sphere.", ZG._TK.CR) end
        end
        do return true end
    else
        do return false end
    end

end, "STAND-FCN")

ZG.STAND_FCN = ZG.actions:get("STAND_FCN")

-- zil: 2actions.zil:3079  <ROUTINE IN-AQUARIUM-FCN (RARG)>
ZG.actions:register("IN_AQUARIUM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("There is a sandy floor here, and your vision seems murky and blurred.\nThe wall you are looking at is nicely dressed stone.", ZG._TK.CR) end
        if ZG._T(ZG.IN_p(ZG.SERPENT, ZG.AQUARIUM)) then
            if ZG._T(ZG.PROB(25)) then
                do local _ = ZG.TELL("While you watch a shadow seems to pass overhead.", ZG._TK.CR) end
            elseif ZG._T(ZG.PROB(5)) then
                do local _ = ZG.TELL("The head of some horrible serpent pokes into view, its beady green eyes\nalmost seeming to see you.", ZG._TK.CR) end
            end
        end
        do return true end
    elseif ZG.EQ(RARG, ZG.M_ENTER) then
        if ZG._T(ZG.IN_p(ZG.SERPENT, ZG.AQUARIUM)) then
            do return ZG.JIGS_UP("You drop into the aquarium with a splash (which attracts the serpent).\nHe greedily eats you. He's just a baby, after all, and needs all the\nfood he can get.") end
        else
            do return ZG.JIGS_UP("Oh dear, you have cut yourself severely on the broken glass. I'm afraid\nyou've bled to death.") end
        end
    else
        do return false end
    end

end, "IN-AQUARIUM-FCN")

ZG.IN_AQUARIUM_FCN = ZG.actions:get("IN_AQUARIUM_FCN")

-- zil: 2actions.zil:3103  <ROUTINE AQUARIUM-FCN ("AUX" OBJ)>
ZG.actions:register("AQUARIUM_FCN", function()

    local OBJ = 0
    if ZG._T(ZG.VERB_p("BOARD", "THROUGH")) then
        do local _ = ZG.DO_WALK("IN") end
        do return true end
    elseif (ZG._T(ZG.VERB_p("LOOK-INSIDE")) and ZG._T(ZG.IN_p(ZG.SERPENT, ZG.AQUARIUM))) then
        do return ZG.TELL("In the aquarium is a baby sea-serpent who eyes you suspiciously. His\nscaly body writhes about in the huge tank.", ZG._TK.CR) end
    elseif ((ZG._T(ZG.VERB_p("MUNG", "ATTACK")) and ZG.EQ(ZG.PRSO, ZG.AQUARIUM)) or (ZG._T(ZG.VERB_p("THROW")) and ZG.EQ(ZG.PRSI, ZG.AQUARIUM))) then
        if ZG.EQ(ZG.PRSO, ZG.AQUARIUM) then
            if (not ZG._T(ZG.PRSI)) then
                do return false end
            else
                OBJ = ZG.PRSI
            end
        else
            OBJ = ZG.PRSO
        end
        do local _ = ZG.MOVE(OBJ, ZG.HERE) end
        if ZG._T(ZG.IN_p(ZG.DEAD_SERPENT, ZG.HERE)) then
            do local _ = ZG.TELL("The aquarium is already broken!", ZG._TK.CR) end
            do return true end
        elseif ZG.EQ(OBJ, ZG.FLASK) then
            do local _ = ZG.JIGS_UP("The flask shatters, and poison gas fills the room!") end
            do return true end
        elseif ZG._T(ZG.BOMB_p(OBJ)) then
            do return ZG.DISABLE(ZG.INT(ZG.I_FUSE)) end
        elseif (ZG._T(ZG.FSET_p(OBJ, "WEAPONBIT")) or ZG.LT(10, ZG.GETP(OBJ, "SIZE"))) then
            do local _ = ZG.REMOVE(ZG.SERPENT) end
            do local _ = ZG.MOVE(ZG.PALANTIR_3, ZG.AQUARIUM) end
            do local _ = ZG.FCLEAR(ZG.PALANTIR_3, "NDESCBIT") end
            do local _ = ZG.PUTP(ZG.AQUARIUM, "LDESC", "A shattered aquarium fills the northern half of the room.") end
            do local _ = ZG.MOVE(ZG.DEAD_SERPENT, ZG.HERE) end
            do local _ = ZG.TELL("The ", ZG._TK.D, OBJ, " shatters the glass wall of the aquarium, spilling out\nan impressive amount of salt water and wet sand. It also spills out an\nextremely annoyed sea serpent who bites angrily at the ", ZG._TK.D, OBJ, ", and\nthen at you. He is having difficulty breathing, and he seems to hold you\nresponsible for his current problem.") end
            if ZG._T(ZG.VERB_p("MUNG")) then
                do local _ = ZG.TELL(" He manages to rend you limb from limb before he drowns in the\nair.", ZG._TK.CR) end
                do return ZG.JIGS_UP("I guess you were too careless.") end
            else
                do return ZG.TELL(" He tries to slither across the stone floor towards you. Fortunately,\nhe expires mere inches away from biting off your foot. A clear crystal\nsphere sits amid the sand and broken glass on the bottom of the\naquarium.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("The ", ZG._TK.D, OBJ, " bounces harmlessly off the glass.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "AQUARIUM-FCN")

ZG.AQUARIUM_FCN = ZG.actions:get("AQUARIUM_FCN")

-- zil: 2actions.zil:3156  <ROUTINE SERPENT-FCN ()>
ZG.actions:register("SERPENT_FCN", function()

    if ZG.EQ(ZG.SERPENT, ZG.WINNER) then
        do return ZG.TELL("The serpent only stares hungrily at you.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        do return ZG.TELL("He swims towards you with a powerful stroke of his flippers, dagger-like\nteeth dripping. Fortunately, he doesn't want to crash into the aquarium\nwall, and contents himself with splashing you with water.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.SERPENT)) then
        do return ZG.TELL("Impossible for many reasons.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TAKE", "GIVE")) then
        do return ZG.JIGS_UP("He takes you instead. *Uurrp!*") end
    else
        do return false end
    end

end, "SERPENT-FCN")

ZG.SERPENT_FCN = ZG.actions:get("SERPENT_FCN")

-- zil: 2actions.zil:3172  <ROUTINE DEAD-SERPENT-FCN ()>
ZG.actions:register("DEAD_SERPENT_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("This may only be a baby sea serpent, but it's as big as a small whale.", ZG._TK.CR) end
    else
        do return false end
    end

end, "DEAD-SERPENT-FCN")

ZG.DEAD_SERPENT_FCN = ZG.actions:get("DEAD_SERPENT_FCN")

-- zil: 2actions.zil:3177  <ROUTINE GENIE-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" V HOARD)>
ZG.actions:register("GENIE_FCN", function(RARG)

    if RARG == nil then RARG = ZG.M_OBJECT end
    local V = 0
    local HOARD = 0
    if ZG._T(ZG.VERB_p("HELLO")) then
        do return ZG.TELL("The genie grins demonically, but says nothing.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.WINNER, ZG.GENIE) then
        if (not ZG._T(ZG.GENIE_READY_p)) then
            do local _ = ZG.TELL("\"My fee is not paid! I perform no tasks for free! We demons have a\nstrong union these days.\"", ZG._TK.CR) end
            do return 2 end
        elseif ZG._T(ZG.VERB_p("SGIVE")) then
            do return false end
        elseif (ZG.LT(1, ZG.GET(ZG.P_PRSO, 0)) or ZG.LT(1, ZG.GET(ZG.P_PRSI, 0))) then
            do local _ = ZG.TELL("\"I will do one thing only, oh gracious master!\"", ZG._TK.CR) end
            do return 2 end
        elseif (ZG._T(ZG.VERB_p("MOVE")) and ZG.EQ(ZG.PRSO, ZG.GLOBAL_MENHIR)) then
            ZG._set("MENHIR_POSITION", 1)
            do local _ = ZG.TELL("The demon is gone for a moment. \"A trifle... My little finger alone\nwas enough.\"", ZG._TK.CR) end
            do return ZG.GENIE_LEAVES() end
        elseif ZG._T(ZG.VERB_p("TAKE")) then
            if ZG.EQ(ZG.PRSO, ZG.GLOBAL_MENHIR) then
                do local _ = ZG.REMOVE(ZG.MENHIR) end
                ZG._set("MENHIR_POSITION", 2)
                do local _ = ZG.TELL("The demon flashes away for a second. \"I have little use for such a\nthing, but perhaps as a doorstop...\"", ZG._TK.CR) end
                do return ZG.GENIE_LEAVES() end
            elseif ZG.EQ(ZG.PRSO, ZG.WAND) then
                do local _ = ZG.TELL("\"This I do gladly, oh fool!\" cackles the demon gleefully. He stretches\nout an enormous hand towards the wand and taking it like a toothpick (this\nis a large demon), points it at himself. \"Free!\" he commands, and the\ndemon and his wand vanish forever.", ZG._TK.CR) end
                do local _ = ZG.GENIE_LEAVES(false) end
                do return ZG.REMOVE(ZG.WAND) end
            elseif ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT")) then
                do local _ = ZG.GENIE_LEAVES(false) end
                do local _ = ZG.REMOVE(ZG.PRSO) end
                do return ZG.TELL("The demon snaps his fingers, the ", ZG._TK.D, ZG.PRSO, " spins wildly in the air in\nfront of him, then he and it depart.", ZG._TK.CR) end
            else
                do return ZG.TELL("\"I fear that I cannot take such a thing.\"", ZG._TK.CR) end
            end
        elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.ME)) then
            if ZG.EQ(ZG.PRSO, ZG.WAND) then
                do local _ = ZG.TELL("\"I hear and obey!\" says the demon. He stretches out an enormous hand\ntowards the wand. The Wizard is unsure what to do, pointing it threateningly\nat the demon, then at you. \"Fudge!\" he cries, but aside from a strong\nodor of chocolate in the air, there is no effect. The demon plucks the\nwand out of his hand (it's about toothpick-size to him) and gingerly lays\nit before you. He fades into the smoke, which disperses.\nThe wizard runs from the room in terror.", ZG._TK.CR) end
                do local _ = ZG.REMOVE(ZG.WIZARD) end
                do local _ = ZG.GENIE_LEAVES(false) end
                do local _ = ZG.FCLEAR(ZG.WAND, "NDESCBIT") end
                do return ZG.MOVE(ZG.WAND, ZG.HERE) end
            elseif ZG.EQ(ZG.PRSO, ZG.GLOBAL_MENHIR) then
                do local _ = ZG.MOVE(ZG.MENHIR, ZG.PENTAGRAM_ROOM) end
                do local _ = ZG.FCLEAR(ZG.MENHIR, "NDESCBIT") end
                do local _ = ZG.FCLEAR(ZG.MENHIR, "TAKEBIT") end
                ZG._set("MENHIR_POSITION", 3)
                do local _ = ZG.TELL("He waves his hands, and the menhir drops softly at your feet.", ZG._TK.CR) end
                do return ZG.GENIE_LEAVES() end
            elseif ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT")) then
                do local _ = ZG.MOVE(ZG.PRSO, ZG.PENTAGRAM_ROOM) end
                do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " appears before you and settles to the ground.", ZG._TK.CR) end
                do return ZG.GENIE_LEAVES() end
            else
                do return ZG.TELL("\"Were it possible, this would be my fondest wish, but alas...\"", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.VERB_p("ATTACK")) then
            if ZG.EQ(ZG.PRSO, ZG.GLOBAL_CERBERUS) then
                do return ZG.TELL("\"This may prove taxing, but we'll see. Perhaps I'll tame him for a\npup instead.\" The demon disappears for an instant, then reappears. He\nlooks rather gnawed and scratched. He winces. \"Too much for me. Puppy\ndog, indeed. You're welcome to him. Never did like dogs anyway... Any\nother orders, oh beneficent one?\"", ZG._TK.CR) end
            elseif ZG.EQ(ZG.PRSO, ZG.WIZARD) then
                do local _ = ZG.TELL("The demon grins hideously. \"This has been my desire e'er since this\ncharlatan bent me to his service. I perform this deed with pleasure!\"\nThe demon forms himself back into a cloud of greasy smoke. The cloud\nenvelops the Wizard, who waves his wand fruitlessly, mumbling various\nphrases which begin with \"F\". A horrible scream is heard, and the smoke\nbegins to clear. Nothing remains of the Wizard but his wand.", ZG._TK.CR) end
                do local _ = ZG.REMOVE(ZG.WIZARD) end
                do local _ = ZG.FCLEAR(ZG.WAND, "NDESCBIT") end
                do local _ = ZG.MOVE(ZG.WAND, ZG.HERE) end
                do return ZG.GENIE_LEAVES() end
            elseif ZG.EQ(ZG.PRSO, ZG.ME) then
                do local _ = ZG.GENIE_LEAVES(false) end
                ZG._set("WINNER", ZG.ADVENTURER)
                do return ZG.JIGS_UP("\"Foolish mortal, if you insist...\" The demon crushes you with one\nblow of his enormous hand.") end
            else
                do return ZG.TELL("\"I know no way to kill a ", ZG._TK.D, ZG.PRSO, ".\"", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.VERB_p("FIND", "EXAMINE")) then
            do local _ = ZG.TELL("\"I am not permitted to ") end
            if ZG._T(ZG.VERB_p("FIND")) then
                do local _ = ZG.TELL("answer questions") end
            else
                do local _ = ZG.TELL("perform such menial tasks") end
            end
            do return ZG.TELL(". The terms of my contract\nare explicit on this matter, learned one. Surely you would not wish to\nviolate my contract?\" He licks his lips with a forked tongue like a\nsnake's. \"The penalty clauses are ... hmm ... devilish.\"", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("\"Apologies, oh master, but even for such a one as I this is not possible.\"\nHe seems somewhat chagrined to have to admit this.", ZG._TK.CR) end
            do return true end
        end
    elseif ZG._T(ZG.VERB_p("EXORCISE", "ATTACK", "MUNG")) then
        do return ZG.TELL("The demon laughs uproariously.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.GENIE)) then
        if (ZG.EQ(ZG.PRSO, ZG.IRON_BOX) and ZG._T(ZG.IN_p(ZG.VIOLIN, ZG.PRSO))) then
            do local _ = ZG.TELL("The genie frowns briefly, then ") end
            if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
                do local _ = ZG.TELL("looks inside") end
            else
                do local _ = ZG.TELL("opens") end
            end
            do local _ = ZG.TELL(" the box. He smiles horribly.", ZG._TK.CR) end
            do local _ = ZG.REMOVE_CAREFULLY(ZG.IRON_BOX) end
            ZG._set("PRSO", ZG.VIOLIN)
        end
        if (ZG._T(ZG.GETPT(ZG.PRSO, "VALUE")) and (not ZG.EQ(ZG.PRSO, ZG.SWORD))) then
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            ZG._set("GENIE_HOARD", ZG.ADD(ZG.GENIE_HOARD, 1))
            do local _ = ZG.SCORE_UPD(2) end
            HOARD = ZG.ADD(ZG.GENIE_HOARD, ZG.CASE_WORTH())
            if (not ZG.LT(HOARD, ZG.TREASURES_MAX)) then
                ZG._set("GENIE_READY_p", true)
                do local _ = ZG.PUTP(ZG.WIZARD, "LDESC", "A dejected and fearful Wizard watches from the corner.") end
                do return ZG.TELL("\"This will do for my fee. 'Tis a paltry hoard, but as you have done\nme a small service by loosing me from this wizard, it will suffice.\"", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("\"", ZG.GET(ZG.GENIE_THANKS, HOARD), "\"", ZG._TK.CR) end
                if ZG.EQ(HOARD, 8) then
                    do local _ = ZG.TELL("The Wizard looks at you as if you are a madman. He tears his beard and\nstares at you fearfully.", ZG._TK.CR) end
                end
                do return true end
            end
        elseif ZG._T(ZG.BOMB_p(ZG.PRSO)) then
            do local _ = ZG.GENIE_LEAVES(false) end
            do return ZG.TELL("\"I fear that this violates my contract, oh foolish one. Thus, I am\nfree to depart.\"", ZG._TK.CR) end
        else
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            do return ZG.TELL("The demon gladly takes the ", ZG._TK.D, ZG.PRSO, " and smiles balefully,\nrevealing enormous fangs.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "GENIE-FCN")

ZG.GENIE_FCN = ZG.actions:get("GENIE_FCN")

-- zil: 2actions.zil:3343  <ROUTINE GENIE-LEAVES ("OPTIONAL" (NOISY? T))>
ZG.actions:register("GENIE_LEAVES", function(NOISY_p)

    if NOISY_p == nil then NOISY_p = true end
    do local _ = ZG.FSET(ZG.GENIE, "INVISIBLE") end
    if ZG._T(NOISY_p) then
        do local _ = ZG.TELL("The genie departs, his agreement fulfilled.", ZG._TK.CR) end
    end
    ZG._set("P_CONT", false)
    do return 2 end

end, "GENIE-LEAVES")

ZG.GENIE_LEAVES = ZG.actions:get("GENIE_LEAVES")

-- zil: 2actions.zil:3350  <GLOBAL GENIE-READY?>
-- GENIE_READY_p is declared in ZilGlobal.lua

-- zil: 2actions.zil:3351  <GLOBAL GENIE-HOARD>
-- GENIE_HOARD is declared in ZilGlobal.lua

-- zil: 2actions.zil:3352  <CONSTANT TREASURES-MAX>
-- TREASURES_MAX is declared in ZilGlobal.lua

-- ;"all treasures but palantirs(4),
-- 				  candy, collar, wand."

-- zil: 2actions.zil:3355  <GLOBAL GENIE-THANKS>
-- GENIE_THANKS is declared in ZilGlobal.lua

-- zil: 2actions.zil:3367  <ROUTINE CASE-WORTH ("AUX" F (W 0))>
ZG.actions:register("CASE_WORTH", function()

    local F = 0
    local W = 0
    F = ZG.FIRST_p(ZG.WIZARD_CASE)
    while true do
        if (not ZG._T(F)) then
            do return W end
        end
        if ZG._T(ZG.GETPT(F, "VALUE")) then
            W = ZG.ADD(W, 1)
        end
        F = ZG.NEXT_p(F)
    end

end, "CASE-WORTH")

ZG.CASE_WORTH = ZG.actions:get("CASE_WORTH")

-- zil: 2actions.zil:3375  <ROUTINE PENTAGRAM-FCN ("OPTIONAL" (RARG ,M-BEG))>
ZG.actions:register("PENTAGRAM_FCN", function(RARG)

    if RARG == nil then RARG = ZG.M_BEG end
    if ZG.EQ(RARG, ZG.M_BEG) then
        if ZG._T(ZG.VERB_p("THROUGH", "BOARD")) then
            do return ZG.TELL("You try to enter the pentagram, but are forced back by an invisible\npower.", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("PUT", "PUT-ON")) and ZG.EQ(ZG.PRSO, ZG.PALANTIR_4)) then
            do local _ = ZG.REMOVE(ZG.PALANTIR_4) end
            do local _ = ZG.FCLEAR(ZG.GENIE, "INVISIBLE") end
            do local _ = ZG.MOVE(ZG.GENIE, ZG.PENTAGRAM_ROOM) end
            do return ZG.TELL("A cold wind blows outward from the sphere. The candles flicker, and a\nlow moan, almost inaudible, is heard. It rises in volume and pitch\nuntil it becomes a high-pitched keening. A dim shape becomes visible in\nthe air above the sphere. The shape resolves into a large and somewhat\nformidable looking demon. He looks around, tests the walls of the\npentagram experimentally, then sees you! \"Hmm, a new master...\" he\nsays under his breath. \"Greetings, oh master! Wouldst desire a\nservice, as our contract stateth? For some pittance of wealth, some\ntrifle, I will gratify thy desires to the utmost limit of my powers, and\nthey are not inconsiderable.\" He makes a pass with his massive arms and\nthe walls begin to shake a little. Another pass and the shaking stops.\n\"A nice effect... I find it makes for a better relationship to give\nsuch a demonstration early on.\" He grins vilely.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "PENTAGRAM-FCN")

ZG.PENTAGRAM_FCN = ZG.actions:get("PENTAGRAM_FCN")

-- zil: 2actions.zil:3400  <ROUTINE WIZARD-FCN ("OPTIONAL" (RARG ,M-OBJECT) "AUX" OLIT)>
ZG.actions:register("WIZARD_FCN", function(RARG)

    if RARG == nil then RARG = ZG.M_OBJECT end
    local OLIT = 0
    if ZG.EQ(ZG.WINNER, ZG.WIZARD) then
        if ZG._T(ZG.VERB_p("GIVE")) then
            do return ZG.TELL("The Wizard replies \"Foolishment!\"", ZG._TK.CR) end
        else
            do return ZG.TELL("The Wizard considers your statement carefully. His expression indicates\nhe regards it as fanciful.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.WIZARD)) then
        OLIT = ZG.LIT
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        if ZG._T(ZG.BOMB_p(ZG.PRSO)) then
            if ZG._T(ZG.IN_p(ZG.GENIE, ZG.PENTAGRAM_ROOM)) then
                do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
                do return ZG.TELL("The wizard accepts this final folly resignedly.", ZG._TK.CR) end
            else
                do local _ = ZG.REMOVE(ZG.WIZARD) end
                do return ZG.TELL("\"Hmm...\" The Wizard mutters something, then waves his wand over the\nbomb. It transforms into a bouquet of flowers. Both Wizard and\nflowers disappear.", ZG._TK.CR) end
            end
        elseif (ZG._T(OLIT) and (not ZG._T(ZG.LIT))) then
            do return ZG.TELL("\"Thank you.\" As the Wizard places the ", ZG._TK.D, ZG.PRSO, " under his robe, the\nroom becomes dark.", ZG._TK.CR) end
        else
            do return ZG.TELL("\"Thank you.\"", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.HELLO_p(ZG.WIZARD)) then
        do return ZG.TELL("The Wizard seems surprised, much as you might be if a dog talked.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        do local _ = ZG.REMOVE(ZG.WIZARD) end
        if ZG._T(ZG.IN_p(ZG.WAND, ZG.WIZARD)) then
            do local _ = ZG.TELL("The Wizard retreats, waving his wand and chanting. He says \"Fear!\"\n") end
        else
            do local _ = ZG.TELL("The Wizard tries to cast the \"Fear!\" spell, but without his wand!\n") end
        end
        if (not ZG._T(ZG.FSET_p(ZG.GENIE, "INVISIBLE"))) then
            do return ZG.TELL("Nothing happens! With a terrified glance at the demon, the wizard\nruns past you and out of the room.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("You are suddenly terrified. The Wizard seems huge and terrible,\nlooming over you. You flee, terrified. He chuckles, snaps his fingers, and\ndisappears.", ZG._TK.CR, ZG._TK.CR) end
            ZG._set("SPELL_p", ZG.S_FEAR)
            do local _ = ZG.PUTP(ZG.ADVENTURER, "ACTION", ZG.MAGIC_ACTOR) end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_WIZARD, 10)) end
            do return ZG.RANDOM_WALK() end
        end
    else
        do return false end
    end

end, "WIZARD-FCN")

ZG.WIZARD_FCN = ZG.actions:get("WIZARD_FCN")

-- zil: 2actions.zil:3455  <ROUTINE I-WIZARD ("AUX" CAST-PROB (PCNT 0) F (WLOC <LOC ,WINNER>))>
ZG.actions:register("I_WIZARD", function()

    local CAST_PROB = 0
    local PCNT = 0
    local F = 0
    local WLOC = ZG.LOC(ZG.WINNER)
    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_WIZARD, 4)) end
    if ZG._T(ZG.DEAD) then
        do return false end
    elseif ZG._T(ZG.SPELL_p) then
        if ZG.EQ(ZG.SPELL_p, ZG.S_FLOAT) then
            if ZG.EQ(ZG.HERE, ZG.WELL_TOP) then
                do local _ = ZG.JIGS_UP("You plunge to the bottom of the shaft as the spell wears off.") end
                do return true end
            elseif (ZG._T(ZG.FSET_p(ZG.HERE, "NONLANDBIT")) and (not ZG.EQUAL_p(ZG.HERE, ZG.WELL_BOTTOM, ZG.VOLCANO_BOTTOM))) then
                do local _ = ZG.JIGS_UP("As the spell wears off, you find yourself making a half-gainer\ntowards the bottom of the volcano.") end
                do return true end
            end
        elseif ZG.EQ(ZG.SPELL_p, ZG.S_FEEBLE) then
            ZG._set("LOAD_ALLOWED", ZG.LOAD_MAX)
        elseif ZG.EQ(ZG.SPELL_p, ZG.S_FIERCE) then
            ZG._set("SWORD_GLOW", 0)
        elseif ZG.EQ(ZG.SPELL_p, ZG.S_FUMBLE) then
            ZG._set("FUMBLE_NUMBER", 7)
            ZG._set("FUMBLE_PROB", 8)
        end
        if ZG._T(ZG.GET(ZG.SPELL_STOPS, ZG.SPELL_p)) then
            do local _ = ZG.TELL(ZG.GET(ZG.SPELL_STOPS, ZG.SPELL_p), ZG._TK.CR) end
        end
        do local _ = ZG.PUTP(ZG.ADVENTURER, "ACTION", 0) end
        ZG._set("SPELL_p", false)
        do return true end
    end
    if ZG._T(ZG.IN_p(ZG.GENIE, ZG.PENTAGRAM_ROOM)) then
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_WIZARD)) end
        if (not ZG._T(ZG.IN_p(ZG.WIZARD, ZG.PENTAGRAM_ROOM))) then
            do local _ = ZG.MOVE(ZG.WIZARD, ZG.PENTAGRAM_ROOM) end
            if ZG._T(ZG.IN_p(ZG.WINNER, ZG.PENTAGRAM_ROOM)) then
                do local _ = ZG.TELL("Suddenly the Wizard materializes in the room. He is astonished by what\nhe sees: his servant in deep conversation with a common adventurer! He\ndraws forth his wand, waves it frantically, and incants \"Frobizz!\nFrobozzle! Frobnoid!\" The demon laughs heartily. \"You no longer\ncontrol the Black Crystal, hedge-wizard! Your wand is powerless! Your\ndoom is sealed!\" The demon turns to you, expectantly.", ZG._TK.CR) end
            end
        end
        do return true end
    end
    if ((not ZG._T(ZG.LIT)) and ZG._T(ZG.FSET_p(ZG.LAMP, "RMUNGBIT")) and ZG.LT(200, ZG.SCORE)) then
        ZG._set("ALWAYS_LIT", true)
        ZG._set("LIT", true)
        do local _ = ZG.TELL("In the darkness you hear the voice of the Wizard. \"Dear me, you seem\nto have gotten into quite a pickle.\" He chuckles. \"Fluoresce!\" he\nincants. It is no longer dark.", ZG._TK.CR) end
        do return true end
    end
    if (ZG._T(ZG.LOC(ZG.WIZARD)) and ZG._T(ZG.PROB(80))) then
        if (ZG._T(ZG.LIT) and ZG._T(ZG.IN_p(ZG.WIZARD, ZG.HERE))) then
            do local _ = ZG.TELL("The Wizard vanishes.", ZG._TK.CR) end
        end
        do local _ = ZG.REMOVE(ZG.WIZARD) end
        do return true end
    end
    if ZG._T(ZG.PROB(10)) then
        if (not ZG._T(ZG.LIT)) then
            do local _ = ZG.TELL("You feel a slight outrush of air as something moves nearby.", ZG._TK.CR) end
        elseif ZG.EQUAL_p(ZG.HERE, ZG.POSTS_ROOM, ZG.POOL_ROOM) then
            do local _ = ZG.TELL("A huge and terrible wizard appears before you, as large as the largest\ntree! He looks down on you as you would look upon a gnat!", ZG._TK.CR) end
        elseif ZG._T(ZG.FSET_p(ZG.HERE, "NONLANDBIT")) then
            do local _ = ZG.TELL("The Wizard appears, floating nonchalantly in the air beside you. He\ngrins sideways at you.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("A strange little man in a long cloak appears suddenly in the room.\nHe is wearing a high pointed hat embroidered with astrological signs.\nHe has a long, stringy, and unkempt beard.", ZG._TK.CR) end
        end
        if ZG._T(ZG.IN_p(ZG.PALANTIR_4, ZG.ADVENTURER)) then
            if ZG._T(ZG.LIT) then
                do local _ = ZG.TELL("The Wizard notices that you carry the Black Crystal, and with an\nunseemly haste, he disappears.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("You feel a sudden inrush of air as though something disappeared.", ZG._TK.CR) end
            end
            do local _ = ZG.REMOVE(ZG.WIZARD) end
            do return true end
        elseif ZG._T(ZG.PROB(20)) then
            if ZG._T(ZG.LIT) then
                do local _ = ZG.TELL("He mutters something (muffled by his beard) and disappears as suddenly\nas he came.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("You hear low, confused muttering.", ZG._TK.CR) end
            end
            do local _ = ZG.REMOVE(ZG.WIZARD) end
            do return true end
        end
        if ZG._T(ZG.IN_p(ZG.PALANTIR_1, ZG.ADVENTURER)) then
            PCNT = ZG.ADD(PCNT, 1)
        end
        if ZG._T(ZG.IN_p(ZG.PALANTIR_2, ZG.ADVENTURER)) then
            PCNT = ZG.ADD(PCNT, 1)
        end
        if ZG._T(ZG.IN_p(ZG.PALANTIR_3, ZG.ADVENTURER)) then
            PCNT = ZG.ADD(PCNT, 1)
        end
        CAST_PROB = ZG.SUB(80, (PCNT * 20))
        if ZG._T(ZG.LIT) then
            do local _ = ZG.TELL("The Wizard draws forth his wand and waves it in your direction. It\nbegins to glow with a faint blue glow.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("Suddenly, illuminated by the faint blue glow of a magic wand pointed\nin your direction, you see the Wizard!", ZG._TK.CR) end
        end
        if ZG._T(ZG.PROB(CAST_PROB)) then
            do local _ = ZG.MOVE(ZG.WIZARD, ZG.HERE) end
            ZG._set("SPELL_p", ZG.RANDOM(ZG.SPELLS))
            do local _ = ZG.PUTP(ZG.ADVENTURER, "ACTION", ZG.MAGIC_ACTOR) end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_WIZARD, ZG.ADD(5, ZG.RANDOM(ZG.SUB(30, (5 * PCNT)))))) end
            if ZG._T(ZG.PROB(75)) then
                do local _ = ZG.TELL("The Wizard, in a deep and resonant voice, speaks the word \"", ZG.GET(ZG.SPELL_NAMES, ZG.SPELL_p), "!\" He then vanishes, cackling gleefully.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The Wizard, almost inaudibly, whispers a word beginning with \"F,\"\nand then disappears, chuckling nastily.", ZG._TK.CR) end
            end
            do local _ = ZG.REMOVE(ZG.WIZARD) end
            if ZG._T(ZG.GET(ZG.SPELL_HINTS, ZG.SPELL_p)) then
                do local _ = ZG.TELL(ZG.GET(ZG.SPELL_HINTS, ZG.SPELL_p), ZG._TK.CR) end
            end
            if ZG.EQ(ZG.SPELL_p, ZG.S_FALL) then
                if ZG._T(ZG.FSET_p(WLOC, "VEHBIT")) then
                    do local _ = ZG.TELL("You suddenly fall headlong out of the ", ZG._TK.D, WLOC, " as though\nsomeone had flipped it over.", ZG._TK.CR) end
                    if ZG.EQ(ZG.HERE, ZG.WELL_TOP) then
                        do local _ = ZG.JIGS_UP("You plummet to the bottom of the shaft.") end
                    elseif (ZG._T(ZG.FSET_p(ZG.HERE, "NONLANDBIT")) and (not ZG.EQUAL_p(ZG.HERE, ZG.VOLCANO_BOTTOM, ZG.WELL_BOTTOM))) then
                        do local _ = ZG.JIGS_UP("You make a rather messy swan dive to the bottom of the volcano.") end
                    else
                        do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
                    end
                end
            elseif ZG.EQ(ZG.SPELL_p, ZG.S_FLOAT) then
                if ZG._T(ZG.FSET_p(WLOC, "VEHBIT")) then
                    do local _ = ZG.TELL(" You rise majestically out of the ", ZG._TK.D, WLOC, ", coming to a stop about five\nfeet above it and to one side.", ZG._TK.CR) end
                    do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
                else
                    do local _ = ZG.TELL("Slowly, you and all your belongings rise into the air, stopping after\nabout five feet.", ZG._TK.CR) end
                end
            elseif ZG.EQ(ZG.SPELL_p, ZG.S_FEEBLE) then
                ZG._set("LOAD_ALLOWED", 50)
                if ZG._T((function() F = ZG.FIRST_p(ZG.WINNER); return F end)()) then
                    do local _ = ZG.TELL("In fact, you feel so weak that you drop the ", ZG._TK.D, F, ".", ZG._TK.CR) end
                    do local _ = ZG.MOVE(F, WLOC) end
                end
            elseif ZG.EQ(ZG.SPELL_p, ZG.S_FEAR) then
                if ZG._T(ZG.FSET_p(WLOC, "VEHBIT")) then
                    do local _ = ZG.TELL("You cower in the corner of the ", ZG._TK.D, WLOC, ", hoping the wizard\nwon't see you.", ZG._TK.CR) end
                else
                    do local _ = ZG.CRLF() end
                    do local _ = ZG.RANDOM_WALK() end
                end
            elseif ZG.EQ(ZG.SPELL_p, ZG.S_FUMBLE) then
                ZG._set("FUMBLE_NUMBER", 3)
                ZG._set("FUMBLE_PROB", 25)
                if ZG._T((function() F = ZG.FIRST_p(ZG.ADVENTURER); return F end)()) then
                    do local _ = ZG.TELL("Ooops! You dropped the ", ZG._TK.D, F, ".", ZG._TK.CR) end
                    do local _ = ZG.MOVE(F, WLOC) end
                end
            elseif ZG.EQ(ZG.SPELL_p, ZG.S_FILCH) then
                if ZG._T(ZG.ROB(ZG.WINNER, ZG.WIZARD_CASE)) then
                    do local _ = ZG.TELL("Something you are carrying has disappeared!", ZG._TK.CR) end
                end
            elseif ZG.EQ(ZG.SPELL_p, ZG.S_FIERCE) then
                do local _ = ZG.TELL("The Wizard mumbles something under his breath, and just before you\nreach him, he vanishes.", ZG._TK.CR) end
            end
            do return true end
        elseif ZG._T(ZG.PROB(50)) then
            do local _ = ZG.REMOVE(ZG.WIZARD) end
            do return ZG.TELL("There is a loud crackling noise. Blue smoke rises from out of the\nWizard's sleeve. He sighs and disappears.", ZG._TK.CR) end
        elseif ZG._T(ZG.PROB(50)) then
            do local _ = ZG.REMOVE(ZG.WIZARD) end
            do return ZG.TELL("The Wizard incants \"", ZG.RANDOM_ELEMENT(ZG.SPELL_NAMES), "!\" but nothing\nhappens. He shakes the wand. Nothing happens. With a slightly\nembarrassed glance in your direction, he vanishes.", ZG._TK.CR) end
        else
            do local _ = ZG.MOVE(ZG.WIZARD, ZG.HERE) end
            do return ZG.TELL("The Wizard seems about to say something, but thinks better of it,\nand peers at you from under his bushy eyebrows.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "I-WIZARD")

ZG.I_WIZARD = ZG.actions:get("I_WIZARD")

-- zil: 2actions.zil:3654  <GLOBAL SPELL?>
-- SPELL_p is declared in ZilGlobal.lua

-- zil: 2actions.zil:3656  <CONSTANT SPELLS>
-- SPELLS is declared in ZilGlobal.lua

-- zil: 2actions.zil:3657  <CONSTANT S-FEEBLE>
-- S_FEEBLE is declared in ZilGlobal.lua

-- zil: 2actions.zil:3658  <CONSTANT S-FUMBLE>
-- S_FUMBLE is declared in ZilGlobal.lua

-- zil: 2actions.zil:3659  <CONSTANT S-FEAR>
-- S_FEAR is declared in ZilGlobal.lua

-- zil: 2actions.zil:3660  <CONSTANT S-FILCH>
-- S_FILCH is declared in ZilGlobal.lua

-- zil: 2actions.zil:3661  <CONSTANT S-FREEZE>
-- S_FREEZE is declared in ZilGlobal.lua

-- zil: 2actions.zil:3662  <CONSTANT S-FALL>
-- S_FALL is declared in ZilGlobal.lua

-- zil: 2actions.zil:3663  <CONSTANT S-FERMENT>
-- S_FERMENT is declared in ZilGlobal.lua

-- zil: 2actions.zil:3664  <CONSTANT S-FIERCE>
-- S_FIERCE is declared in ZilGlobal.lua

-- zil: 2actions.zil:3665  <CONSTANT S-FLOAT>
-- S_FLOAT is declared in ZilGlobal.lua

-- zil: 2actions.zil:3666  <CONSTANT S-FIREPROOF>
-- S_FIREPROOF is declared in ZilGlobal.lua

-- zil: 2actions.zil:3667  <CONSTANT S-FENCE>
-- S_FENCE is declared in ZilGlobal.lua

-- zil: 2actions.zil:3668  <CONSTANT S-FANTASIZE>
-- S_FANTASIZE is declared in ZilGlobal.lua

-- zil: 2actions.zil:3670  <GLOBAL SPELL-NAMES>
-- SPELL_NAMES is declared in ZilGlobal.lua

-- zil: 2actions.zil:3675  <GLOBAL SPELL-HINTS>
-- SPELL_HINTS is declared in ZilGlobal.lua

-- zil: 2actions.zil:3692  <GLOBAL SPELL-STOPS>
-- SPELL_STOPS is declared in ZilGlobal.lua

-- zil: 2actions.zil:3708  <ROUTINE ROB (WHO WHERE "AUX" N X (ROBBED? <>))>
ZG.actions:register("ROB", function(WHO, WHERE)

    local N = 0
    local X = 0
    local ROBBED_p = false
    X = ZG.FIRST_p(WHO)
    while true do
        if (not ZG._T(X)) then
            do return ROBBED_p end
        end
        N = ZG.NEXT_p(X)
        if ZG._T(ZG.RIPOFF(X, WHERE)) then
            ROBBED_p = true
        end
        X = N
    end

end, "ROB")

ZG.ROB = ZG.actions:get("ROB")

-- zil: 2actions.zil:3716  <ROUTINE RIPOFF (X WHERE)>
ZG.actions:register("RIPOFF", function(X, WHERE)

    if ((not ZG._T(ZG.FSET_p(X, "INVISIBLE"))) and ZG._T(ZG.GETPT(X, "VALUE")) and (not ZG.EQ(X, ZG.PALANTIR_1)) and (not ZG.EQ(X, ZG.PALANTIR_2)) and (not ZG.EQ(X, ZG.PALANTIR_3)) and (not ZG.EQ(X, ZG.GOLD_KEY)) and (not ZG.EQ(X, ZG.CANDY))) then
        do local _ = ZG.MOVE(X, WHERE) end
        do local _ = ZG.FSET(X, "TOUCHBIT") end
        do return true end
    else
        do return false end
    end

end, "RIPOFF")

ZG.RIPOFF = ZG.actions:get("RIPOFF")

-- zil: 2actions.zil:3728  <ROUTINE WIZARD-CASE-FCN ()>
ZG.actions:register("WIZARD_CASE_FCN", function()

    if ZG.EQ(ZG.WINNER, ZG.GENIE) then
        if ZG._T(ZG.VERB_p("MUNG", "OPEN")) then
            do local _ = ZG.REMOVE(ZG.WIZARD_CASE) end
            do local _ = ZG.MOVE(ZG.BROKEN_CASE, ZG.TROPHY_ROOM) end
            do return ZG.TELL("The demon smashes the case into smithereens. Everything in it smashes\nas well.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("ENCHANT")) and ZG.EQ(ZG.SPELL_USED, ZG.WORD("filch"))) then
        do local _ = ZG.ROB(ZG.WIZARD_CASE, ZG.HERE) end
        ZG._set("SPELL_HANDLED_p", true)
        do return ZG.TELL("The contents of the case are arrayed at your feet.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "MUNG", "CLOSE", "TAKE")) then
        do return ZG.TELL("The case is protected by a fearful spell. You cannot touch it in any\nway.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WIZARD-CASE-FCN")

ZG.WIZARD_CASE_FCN = ZG.actions:get("WIZARD_CASE_FCN")

-- zil: 2actions.zil:3746  <GLOBAL SPELL-HANDLED?>
-- SPELL_HANDLED_p is declared in ZilGlobal.lua

-- ;"T if handled before I-SPELL runs"

-- zil: 2actions.zil:3747  <GLOBAL WAND-ON>
-- WAND_ON is declared in ZilGlobal.lua

-- zil: 2actions.zil:3748  <GLOBAL SPELL-USED>
-- SPELL_USED is declared in ZilGlobal.lua

-- zil: 2actions.zil:3749  <GLOBAL SPELL-VICTIM>
-- SPELL_VICTIM is declared in ZilGlobal.lua

-- zil: 2actions.zil:3751  <ROUTINE WAND-FCN ()>
ZG.actions:register("WAND_FCN", function()

    if (ZG._T(ZG.VERB_p("TAKE", "PUT", "GIVE")) and ZG._T(ZG.IN_p(ZG.WAND, ZG.WIZARD))) then
        if ZG.EQ(ZG.WINNER, ZG.ADVENTURER) then
            do return ZG.TELL("The Wizard snatches it away.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.WINNER, ZG.ROBOT) then
            do return ZG.JIGS_UP("The Wizard snatches the wand away, muttering the word \"Float\" at the\nrobot. Unfortunately he has no floating-point processor and dies in a\nvain attempt to divide 4.85 by 3.62.") end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("WAVE")) and ZG.EQ(ZG.PRSI, ZG.GRUE)) then
        do return ZG.TELL("There is no grue in sight, but a hissing sound issues forth from the\ndarkness.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("WAVE", "RUB", "RAISE")) then
        if (ZG.EQ(ZG.PRSO, ZG.WAND) and (not ZG._T(ZG.IN_p(ZG.WAND, ZG.WINNER)))) then
            do local _ = ZG.TELL("You don't have the wand!", ZG._TK.CR) end
            do return true end
        elseif (ZG._T(ZG.WAND_ON) or ZG._T(ZG.SPELL_USED) or ZG._T(ZG.SPELL_VICTIM)) then
            if ZG._T(ZG.PROB(5)) then
                do local _ = ZG.JIGS_UP("The wand was still recharging from its last use. It discharges magic all\nover everything. You turn into a toad, the room fills with a fetid smell,\nand all sorts of other grubby things happen. Then the wand explodes!") end
            else
                do local _ = ZG.TELL("A lot you know about magic! A magic wand takes a while to recharge\nafter use! You might cause it to short-circuit!", ZG._TK.CR) end
            end
            do return true end
        elseif ZG._T(ZG.VERB_p("WAVE")) then
            if (ZG.EQ(ZG.PRSO, ZG.WAND) and ZG._T(ZG.PRSI)) then
                ZG._set("WAND_ON", ZG.PRSI)
                ZG._set("WAND_ON_LOC", ZG.HERE)
            else
                do local _ = ZG.TELL("At what?", ZG._TK.CR) end
                do return true end
            end
        elseif ZG._T(ZG.VERB_p("RUB")) then
            if (ZG.EQ(ZG.PRSI, ZG.WAND) and ZG._T(ZG.PRSO)) then
                ZG._set("WAND_ON", ZG.PRSO)
            else
                do local _ = ZG.TELL("Touch what?", ZG._TK.CR) end
                do return true end
            end
        elseif ZG._T(ZG.VERB_p("RAISE")) then
            do local _ = ZG.TELL("The wand grows warm and seems to vibrate.", ZG._TK.CR) end
            do return true end
        end
        if ZG._T(ZG.WAND_ON) then
            ZG._set("SPELL_USED", false)
            ZG._set("SPELL_VICTIM", false)
            if ZG.EQUAL_p(ZG.WAND_ON, ZG.ME, ZG.WAND) then
                ZG._set("WAND_ON", false)
                do local _ = ZG.TELL("Fortunately a safety interlock prevents the fatal feedback loop that\nthis would cause.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The wand grows warm, the ", ZG._TK.D, ZG.WAND_ON, " seems to glow dimly with\nmagical essences, and you feel suffused with power.", ZG._TK.CR) end
            end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_WAND, 2)) end
        end
        do return true end
    else
        do return false end
    end

end, "WAND-FCN")

ZG.WAND_FCN = ZG.actions:get("WAND_FCN")

-- zil: 2actions.zil:3808  <GLOBAL WAND-ON-LOC>
-- WAND_ON_LOC is declared in ZilGlobal.lua

-- zil: 2actions.zil:3810  <ROUTINE I-WAND ()>
ZG.actions:register("I_WAND", function()

    if (ZG._T(ZG.WAND_ON) and (ZG.EQ(ZG.WAND_ON_LOC, ZG.HERE) or ZG._T(ZG.IN_p(ZG.WAND_ON, ZG.WINNER)))) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.WAND_ON, " stops glowing and the power within you weakens.", ZG._TK.CR) end
        ZG._set("WAND_ON", false)
        do return true end
    else
        ZG._set("WAND_ON", false)
        do return false end
    end

end, "I-WAND")

ZG.I_WAND = ZG.actions:get("I_WAND")

-- zil: 2actions.zil:3822  <ROUTINE WIZARD-QUARTERS-FCN (RARG "AUX" PICK L)>
ZG.actions:register("WIZARD_QUARTERS_FCN", function(RARG)

    local PICK = 0
    local L = 0
    if ZG.EQUAL_p(RARG, ZG.M_LOOK, ZG.M_FLASH) then
        do local _ = ZG.TELL("This is where the Wizard of Frobozz lives. The room is ") end
        L = ZG.GET(ZG.WIZQDESCS, 0)
        PICK = ZG.RANDOM(L)
        if ZG.EQ(PICK, ZG.WIZQLAST) then
            if ZG.EQ(PICK, L) then
                PICK = ZG.SUB(PICK, 1)
            else
                PICK = ZG.ADD(PICK, 1)
            end
        end
        ZG._set("WIZQLAST", PICK)
        do return ZG.TELL(ZG.GET(ZG.WIZQDESCS, PICK), ZG._TK.CR) end
    else
        do return false end
    end

end, "WIZARD-QUARTERS-FCN")

ZG.WIZARD_QUARTERS_FCN = ZG.actions:get("WIZARD_QUARTERS_FCN")

-- zil: 2actions.zil:3836  <GLOBAL WIZQLAST>
-- WIZQLAST is declared in ZilGlobal.lua

-- zil: 2actions.zil:3838  <GLOBAL WIZQDESCS>
-- WIZQDESCS is declared in ZilGlobal.lua

-- zil: 2actions.zil:3850  <ROUTINE BRIDGE-FCN ()>
ZG.actions:register("BRIDGE_FCN", function()

    if ZG._T(ZG.VERB_p("CROSS")) then
        do return ZG.DO_WALK("CROSS") end
    elseif ZG._T(ZG.VERB_p("LEAP")) then
        do return ZG.JIGS_UP("You execute a perfect swan-dive into the depths below.") end
    else
        do return false end
    end

end, "BRIDGE-FCN")

ZG.BRIDGE_FCN = ZG.actions:get("BRIDGE_FCN")

-- ;"misc. routines"

-- zil: 2actions.zil:3859  <ROUTINE STREAM-FCN ()>
ZG.actions:register("STREAM_FCN", function()

    if ZG._T(ZG.VERB_p("SWIM", "THROUGH")) then
        do return ZG.TELL("You can't swim in the stream.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CROSS")) then
        do return ZG.TELL("You'll have to find a ford or a bridge.", ZG._TK.CR) end
    else
        do return false end
    end

end, "STREAM-FCN")

ZG.STREAM_FCN = ZG.actions:get("STREAM_FCN")

-- zil: 2actions.zil:3865  <ROUTINE CHASM-FCN ()>
ZG.actions:register("CHASM_FCN", function()

    if (ZG._T(ZG.VERB_p("LEAP")) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.ME))) then
        do return ZG.TELL("For a change, you look before leaping. You realize you would\nnever survive.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CROSS")) then
        do return ZG.TELL("You'll have to find a bridge.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.PSEUDO_OBJECT)) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " drops out of sight into the chasm.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.PRSO) end
    else
        do return false end
    end

end, "CHASM-FCN")

ZG.CHASM_FCN = ZG.actions:get("CHASM_FCN")

-- zil: 2actions.zil:3878  <ROUTINE TUNNEL-OBJECT ()>
ZG.actions:register("TUNNEL_OBJECT", function()

    if (ZG._T(ZG.VERB_p("THROUGH")) and ZG._T(ZG.GETPT(ZG.HERE, "IN"))) then
        do local _ = ZG.DO_WALK("IN") end
        do return true end
    else
        do return ZG.PATH_OBJECT() end
    end

end, "TUNNEL-OBJECT")

ZG.TUNNEL_OBJECT = ZG.actions:get("TUNNEL_OBJECT")

-- zil: 2actions.zil:3883  <ROUTINE STALA-PSEUDO ()>
ZG.actions:register("STALA_PSEUDO", function()

    if ZG._T(ZG.VERB_p("TAKE", "MUNG")) then
        do return ZG.TELL("The only ones you can reach are too large to successfully break off.", ZG._TK.CR) end
    else
        do return false end
    end

end, "STALA-PSEUDO")

ZG.STALA_PSEUDO = ZG.actions:get("STALA_PSEUDO")

-- zil: 2actions.zil:3888  <ROUTINE MOSS-FCN ()>
ZG.actions:register("MOSS_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE", "RUB")) then
        do return ZG.TELL("Some of the moss rubs off on you, but it stops glowing very quickly\nonce plucked from its environment.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MOSS-FCN")

ZG.MOSS_FCN = ZG.actions:get("MOSS_FCN")

-- zil: 2actions.zil:3894  <ROUTINE ROSE-BUSH-FCN ()>
ZG.actions:register("ROSE_BUSH_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("You prick your finger trying to take a rose, and jump back annoyed.\nThe rose almost seemed to move its thorns into your path.", ZG._TK.CR) end
    else
        do return false end
    end

end, "ROSE-BUSH-FCN")

ZG.ROSE_BUSH_FCN = ZG.actions:get("ROSE_BUSH_FCN")

-- zil: 2actions.zil:3900  <ROUTINE I-SPELL ()>
ZG.actions:register("I_SPELL", function()

    if ((not ZG._T(ZG.SPELL_HANDLED_p)) and ZG._T(ZG.SPELL_VICTIM)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DISENCHANT"), ZG.SPELL_VICTIM) end
    end
    ZG._set("SPELL_HANDLED_p", false)
    ZG._set("WAND_ON", false)
    ZG._set("SPELL_USED", false)
    ZG._set("SPELL_VICTIM", false)
    do return ZG.SPELL_VICTIM end

end, "I-SPELL")

ZG.I_SPELL = ZG.actions:get("I_SPELL")

-- zil: 2actions.zil:3908  <GLOBAL FANTASIES>
-- FANTASIES is declared in ZilGlobal.lua

-- ;"special-cased routines"

-- zil: 2actions.zil:3917  <ROUTINE V-DIAGNOSE ()>
ZG.actions:register("V_DIAGNOSE", function()

    if ZG._T(ZG.DEAD) then
        do local _ = ZG.TELL("You are dead.") end
    elseif ZG.EQ(ZG.SPELL_p, ZG.S_FERMENT) then
        do local _ = ZG.TELL("You are drunk.") end
    elseif ZG.EQ(ZG.SPELL_p, ZG.S_FEEBLE) then
        do local _ = ZG.TELL("You seem unusually weak right now.") end
    elseif ZG.EQ(ZG.SPELL_p, ZG.S_FLOAT) then
        do local _ = ZG.TELL("You seem somewhat light.") end
    elseif ZG.EQ(ZG.SPELL_p, ZG.S_FREEZE) then
        do local _ = ZG.TELL("You are frozen stiff.") end
    else
        do local _ = ZG.TELL("You are in perfect health.") end
    end
    do local _ = ZG.CRLF() end
    if (not ZG.ZERO_p(ZG.DEATHS)) then
        do local _ = ZG.TELL("You have been killed ") end
        if (ZG.DEATHS == 1) then
            do local _ = ZG.TELL("once.") end
        elseif ZG.EQ(ZG.DEATHS, 2) then
            do local _ = ZG.TELL("twice.") end
        else
            do local _ = ZG.TELL("an awful lot.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "V-DIAGNOSE")

ZG.V_DIAGNOSE = ZG.actions:get("V_DIAGNOSE")

-- zil: 2actions.zil:3936  <ROUTINE V-SCORE ("OPTIONAL" (ASK? T))>
ZG.actions:register("V_SCORE", function(ASK_p)

    if ASK_p == nil then ASK_p = true end
    do local _ = ZG.TELL("Your score ") end
    if ZG._T(ASK_p) then
        do local _ = ZG.TELL("would be ") end
    else
        do local _ = ZG.TELL("is ") end
    end
    do local _ = ZG.TELL(ZG._TK.N, ZG.SCORE) end
    do local _ = ZG.TELL(" (total of 400 points), in ") end
    do local _ = ZG.TELL(ZG._TK.N, ZG.MOVES) end
    if (ZG.MOVES == 1) then
        do local _ = ZG.TELL(" move.") end
    else
        do local _ = ZG.TELL(" moves.") end
    end
    do local _ = ZG.CRLF() end
    do local _ = ZG.TELL("This score gives you the rank of ") end
    if ZG.EQ(ZG.SCORE, 400) then
        do local _ = ZG.TELL("Master Adventurer") end
        if (not ZG._T(ZG.WON_FLAG)) then
            do local _ = ZG.TELL(", but somehow you don't feel done") end
        end
    elseif ZG.LT(360, ZG.SCORE) then
        do local _ = ZG.TELL("Wizard") end
    elseif ZG.LT(320, ZG.SCORE) then
        do local _ = ZG.TELL("Master") end
    elseif ZG.LT(240, ZG.SCORE) then
        do local _ = ZG.TELL("Adventurer") end
    elseif ZG.LT(160, ZG.SCORE) then
        do local _ = ZG.TELL("Junior Adventurer") end
    elseif ZG.LT(80, ZG.SCORE) then
        do local _ = ZG.TELL("Novice Adventurer") end
    elseif ZG.LT(40, ZG.SCORE) then
        do local _ = ZG.TELL("Amateur Adventurer") end
    else
        do local _ = ZG.TELL("Beginner") end
    end
    do local _ = ZG.TELL(".", ZG._TK.CR) end
    do return ZG.SCORE end

end, "V-SCORE")

ZG.V_SCORE = ZG.actions:get("V_SCORE")

-- zil: 2actions.zil:3959  <ROUTINE JIGS-UP ("OPTIONAL" (DESC <>) (PLAYER? <>))>
ZG.actions:register("JIGS_UP", function(DESC, PLAYER_p)

    if DESC == nil then DESC = false end
    if PLAYER_p == nil then PLAYER_p = false end
    if ZG._T(DESC) then
        do local _ = ZG.TELL(DESC, ZG._TK.CR) end
    end
    if (not ZG.EQ(ZG.ADVENTURER, ZG.WINNER)) then
        do local _ = ZG.TELL("\n\n    ****  The ", ZG._TK.D, ZG.WINNER, " has died  ****\n\n\n") end
        do local _ = ZG.REMOVE(ZG.WINNER) end
        ZG._set("WINNER", ZG.ADVENTURER)
        ZG._set("HERE", ZG.LOC(ZG.WINNER))
        do return 2 end
    end
    while true do
        do local _ = ZG.SCORE_UPD(-10) end
        do local _ = ZG.TELL("\n\n    ****  You have died  ****\n\n\n") end
        ZG._set("DEAD", true)
        ZG._set("SPELL_p", false)
        do local _ = ZG.PUTP(ZG.ADVENTURER, "ACTION", 0) end
        ZG._set("DEATHS", ZG.ADD(ZG.DEATHS, 1))
        do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
        do local _ = ZG.TELL("Now, let's take a look here...\nWell, you probably deserve another chance. I can't quite fix you\nup completely, but you can't have everything.", ZG._TK.CR, ZG._TK.CR) end
        do local _ = ZG.FCLEAR(ZG.DEAD_PALANTIR_1, "TOUCHBIT") end
        do local _ = ZG.FCLEAR(ZG.DEAD_PALANTIR_2, "TOUCHBIT") end
        do local _ = ZG.FCLEAR(ZG.DEAD_PALANTIR_3, "TOUCHBIT") end
        do local _ = ZG.RANDOMIZE_OBJECTS() end
        do local _ = ZG.GOTO(ZG.DEAD_PALANTIR_1) end
        ZG._set("P_CONT", false)
        do local _ = ZG.KILL_INTERRUPTS() end
        do return 2 end
        break
    end

end, "JIGS-UP")

ZG.JIGS_UP = ZG.actions:get("JIGS_UP")

-- zil: 2actions.zil:3995  <ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)>
ZG.actions:register("RANDOMIZE_OBJECTS", function()

    local R = false
    local F = 0
    local N = 0
    local L = 0
    if ZG._T(ZG.IN_p(ZG.LAMP, ZG.WINNER)) then
        do local _ = ZG.MOVE(ZG.LAMP, ZG.INSIDE_BARROW) end
    end
    N = ZG.FIRST_p(ZG.WINNER)
    while true do
        F = N
        if (not ZG._T(F)) then
            do return true end
        end
        N = ZG.NEXT_p(F)
        if (ZG.EQUAL_p(F, ZG.BILLS, ZG.PORTRAIT) and (ZG.EQUAL_p(ZG.HERE, ZG.VAULT, ZG.DEPOSITORY, ZG.OFFICE) or ZG.EQ(ZG.HERE, ZG.SMALL_ROOM))) then
            do local _ = ZG.MOVE(F, ZG.HERE) end
        elseif (ZG.EQ(F, ZG.GOLD_KEY) or ZG.EQ(F, ZG.CANDY) or ZG.EQ(F, ZG.PALANTIR_1) or ZG.EQ(F, ZG.PALANTIR_2) or ZG.EQ(F, ZG.PALANTIR_3)) then
            do local _ = ZG.MOVE(F, ZG.CAROUSEL_ROOM) end
        elseif ZG._T(ZG.FSET_p(F, "STAGGERED")) then
            do local _ = ZG.MOVE(F, ZG.WIZARD_CASE) end
        else
            do local _ = ZG.MOVE(F, ZG.GAZEBO_ROOM) end
        end
    end

end, "RANDOMIZE-OBJECTS")

ZG.RANDOMIZE_OBJECTS = ZG.actions:get("RANDOMIZE_OBJECTS")

-- zil: 2actions.zil:4018  <ROUTINE KILL-INTERRUPTS ()>
ZG.actions:register("KILL_INTERRUPTS", function()

    do local _ = ZG.DISABLE(ZG.INT(ZG.I_GNOME)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_LEDGE)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_NERVOUS)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_ZGNOME_OUT)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_ZGNOME)) end
    do local _ = ZG.DRAGON_LEAVES() end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_MATCH)) end
    do return true end

end, "KILL-INTERRUPTS")

ZG.KILL_INTERRUPTS = ZG.actions:get("KILL_INTERRUPTS")

-- zil: 2actions.zil:4028  <ROUTINE FIND-WEAPON (O "AUX" W)>
ZG.actions:register("FIND_WEAPON", function(O)

    local W = 0
    W = ZG.FIRST_p(O)
    if (not ZG._T(W)) then
        do return false end
    end
    while true do
        if ZG.EQ(W, ZG.SWORD) then
            do return W end
        elseif (not ZG._T((function() W = ZG.NEXT_p(W); return W end)())) then
            do return false end
        end
    end

end, "FIND-WEAPON")

ZG.FIND_WEAPON = ZG.actions:get("FIND_WEAPON")

-- zil: 2actions.zil:4037  <ROUTINE BUCKET-CONT ()>
ZG.actions:register("BUCKET_CONT", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and (not ZG._T(ZG.IN_p(ZG.WINNER, ZG.BUCKET)))) then
        do return ZG.TELL("You'll need to get in the bucket to reach it.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BUCKET-CONT")

ZG.BUCKET_CONT = ZG.actions:get("BUCKET_CONT")
