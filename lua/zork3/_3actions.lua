-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: 3actions.zil:9  <ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (NG 0) P T L)>
ZG.actions:register("I_SWORD", function()

    local DEM = ZG.INT(ZG.I_SWORD)
    local NG = 0
    local P = 0
    local T = 0
    local L = 0
    if ZG._T(ZG.IN_p(ZG.SWORD, ZG.ADVENTURER)) then
        if (ZG.EQ(ZG.HERE, ZG.CLIFF) and (not ZG._T(ZG.MAN_GONE))) then
            NG = 1
        elseif (ZG.EQ(ZG.HERE, ZG.CLIFF_LEDGE) and ZG._T(ZG.MAN_FLAG)) then
            NG = 1
        elseif ZG._T(ZG.INFESTED_p(ZG.HERE)) then
            NG = 2
        elseif ((ZG.EQ(ZG.MLOC, ZG.MRG) and ZG.EQ(ZG.HERE, ZG.IN_MIRROR)) or ZG.EQUAL_p(ZG.HERE, ZG.MRGE, ZG.MRG, ZG.MRGW)) then
            NG = 1
        else
            P = 0
            while true do
                if ZG.ZERO_p((function() P = ZG.NEXTP(ZG.HERE, P); return P end)()) then
                    break
                elseif (not ZG.LT(P, ZG.LOW_DIRECTION)) then
                    T = ZG.GETPT(ZG.HERE, P)
                    L = ZG.PTSIZE(T)
                    if ZG.EQUAL_p(L, ZG.UEXIT, ZG.CEXIT, ZG.DEXIT) then
                        if ZG._T(ZG.INFESTED_p(ZG.GETB(T, 0))) then
                            NG = 1
                            break
                        end
                    end
                end
            end
        end
        if ZG.EQ(NG, ZG.SWORD_STATE) then
            do return false end
        elseif ZG.EQ(NG, 2) then
            do local _ = ZG.TELL("Your sword has begun to glow very brightly.", ZG._TK.CR) end
        elseif (NG == 1) then
            do local _ = ZG.TELL("Your sword is glowing with a faint blue glow.", ZG._TK.CR) end
        elseif ZG.ZERO_p(NG) then
            do local _ = ZG.TELL("Your sword is no longer glowing.", ZG._TK.CR) end
        end
        ZG._set("SWORD_STATE", NG)
        do return true end
    else
        do local _ = ZG.DISABLE(DEM) end
        do return false end
    end

end, "I-SWORD")

ZG.I_SWORD = ZG.actions:get("I_SWORD")

-- zil: 3actions.zil:41  <GLOBAL SWORD-STATE>
-- SWORD_STATE is declared in ZilGlobal.lua

-- zil: 3actions.zil:43  <ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))>
ZG.actions:register("INFESTED_p", function(R)

    local F = ZG.FIRST_p(R)
    while true do
        if (not ZG._T(F)) then
            do return false end
        elseif (ZG._T(ZG.FSET_p(F, "ACTORBIT")) and (not ZG._T(ZG.FSET_p(F, "INVISIBLE")))) then
            do return F end
        elseif (not ZG._T((function() F = ZG.NEXT_p(F); return F end)())) then
            do return false end
        end
    end

end, "INFESTED?")

ZG.INFESTED_p = ZG.actions:get("INFESTED_p")

-- zil: 3actions.zil:52  <GLOBAL YUKS>
-- YUKS is declared in ZilGlobal.lua

-- zil: 3actions.zil:59  <ROUTINE FIND-WEAPON (O "AUX" W)>
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

-- zil: 3actions.zil:68  <ROUTINE SWORD-FCN ()>
ZG.actions:register("SWORD_FCN", function()

    if ZG._T(ZG.SWORD_IN_STONE_p) then
        if ZG._T(ZG.VERB_p("TAKE", "MOVE")) then
            if ZG._T(ZG.PROB(10)) then
                do return ZG.TELL("Who do you think you are? Arthur?", ZG._TK.CR) end
            else
                do return ZG.TELL("The sword is deeply imbedded in the rock. You can't budge it.", ZG._TK.CR) end
            end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SWORD, -1)) end
        do return false end
    else
        do return false end
    end

end, "SWORD-FCN")

ZG.SWORD_FCN = ZG.actions:get("SWORD_FCN")

-- zil: 3actions.zil:80  <GLOBAL LAMP-TABLE>
-- LAMP_TABLE is declared in ZilGlobal.lua

-- zil: 3actions.zil:89  <ROUTINE LANTERN ()>
ZG.actions:register("LANTERN", function()

    if ZG._T(ZG.VERB_p("THROW")) then
        do local _ = ZG.TELL("The lamp smashes. The light is now out.", ZG._TK.CR) end
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_LANTERN)) end
        do local _ = ZG.REMOVE(ZG.LAMP) end
        ZG._set("CURRENT_LAMP", ZG.BROKEN_LAMP)
        do return ZG.MOVE(ZG.BROKEN_LAMP, ZG.HERE) end
    elseif ZG._T(ZG.VERB_p("LAMP-ON")) then
        if (not ZG._T(ZG.FSET_p(ZG.LAMP, "LIGHTBIT"))) then
            do return ZG.TELL("A burned-out lamp won't light.", ZG._TK.CR) end
        else
            do local _ = ZG.ENABLE(ZG.INT(ZG.I_LANTERN)) end
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("LAMP-OFF")) then
        if (not ZG._T(ZG.FSET_p(ZG.LAMP, "LIGHTBIT"))) then
            do return ZG.TELL("The lamp has already burned out.", ZG._TK.CR) end
        else
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_LANTERN)) end
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if (not ZG._T(ZG.FSET_p(ZG.LAMP, "LIGHTBIT"))) then
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

-- zil: 3actions.zil:117  <ROUTINE LIGHT-INT (OBJ TBL TICK)>
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

-- zil: 3actions.zil:128  <ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))>
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

-- ;<ROUTINE LIGHT-INT (OBJ INTNAM TBLNAM "AUX" (TBL <VALUE .TBLNAM>) TICK)
-- 	 #DECL ((OBJ) OBJECT (TBLNAM INTNAM) ATOM (TBL) <PRIMTYPE VECTOR>
-- 		(TICK) FIX)
-- 	 <ENABLE <QUEUE .INTNAM <SET TICK <GET .TBL 0>>>>
-- 	 <COND (<0? .TICK>
-- 		<FCLEAR .OBJ ,LIGHTBIT>
-- 		<FCLEAR .OBJ ,ONBIT>)>
-- 	 <COND (<OR <HELD? .OBJ> <IN? .OBJ ,HERE>>
-- 		<COND (<0? .TICK>
-- 		       <TELL
-- "I hope you have more light than from the " D .OBJ "." CR>)
-- 		      (T
-- 		       <TELL <GET .TBL 1> CR>)>)>
-- 	 <COND (<NOT <0? .TICK>>
-- 		<SETG .TBLNAM <REST .TBL 4>>)>>

-- zil: 3actions.zil:150  <ROUTINE CHASM-FCN ()>
ZG.actions:register("CHASM_FCN", function()

    if (ZG._T(ZG.VERB_p("LEAP")) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.ME))) then
        do return ZG.TELL("You look before leaping and realize you would never survive.", ZG._TK.CR) end
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

-- zil: 3actions.zil:162  <ROUTINE TUNNEL-OBJECT ()>
ZG.actions:register("TUNNEL_OBJECT", function()

    if (ZG._T(ZG.VERB_p("THROUGH")) and ZG._T(ZG.GETP(ZG.HERE, "IN"))) then
        do local _ = ZG.DO_WALK("IN") end
        do return true end
    else
        do return ZG.PATH_OBJECT() end
    end

end, "TUNNEL-OBJECT")

ZG.TUNNEL_OBJECT = ZG.actions:get("TUNNEL_OBJECT")

-- zil: 3actions.zil:172  <GLOBAL CPHERE>
-- CPHERE is declared in ZilGlobal.lua

-- zil: 3actions.zil:174  <GLOBAL CPOBJS>
-- CPOBJS is declared in ZilGlobal.lua

-- zil: 3actions.zil:176  <GLOBAL CPTABLE>
-- CPTABLE is declared in ZilGlobal.lua

-- ;" 0 is no wall
--     1 is fixed wall
--    -1 is movable wall (-2 is good ladder, -3 bad ladder)"

-- zil: 3actions.zil:219  <GLOBAL CPWALLS>
-- CPWALLS is declared in ZilGlobal.lua

-- zil: 3actions.zil:221  <GLOBAL CPEXITS>
-- CPEXITS is declared in ZilGlobal.lua

-- zil: 3actions.zil:239  <GLOBAL CP-MOVED>
-- CP_MOVED is declared in ZilGlobal.lua

-- zil: 3actions.zil:241  <ROUTINE CPEXIT ("AUX" FX NFX)>
ZG.actions:register("CPEXIT", function()

    local FX = 0
    local NFX = 0
    ZG._set("CP_MOVED", false)
    if ZG.EQ(ZG.PRSO, "UP") then
        if ZG.EQ(ZG.CPHERE, 1) then
            if ZG.EQ(ZG.GET(ZG.CPTABLE, 2), -2) then
                do local _ = ZG.TELL("With the help of the ladder, you exit the puzzle.", ZG._TK.CR) end
                do return ZG.CP_ANTE end
            else
                do local _ = ZG.TELL("The exit is too far above your head.", ZG._TK.CR) end
                do return false end
            end
        else
            do local _ = ZG.TELL("There is no way up.", ZG._TK.CR) end
            do return false end
        end
    elseif (ZG.EQ(ZG.CPHERE, 33) and ZG.EQ(ZG.PRSO, "WEST") and ZG._T(ZG.CP_FLAG)) then
        do local _ = ZG.FCLEAR(ZG.CP, "TOUCHBIT") end
        do return ZG.CP_OUT end
    elseif ZG.EQ(ZG.PRSO, "DOWN") then
        do local _ = ZG.TELL("There's no way down here.", ZG._TK.CR) end
        do return false end
    elseif (ZG.EQ(ZG.CPHERE, 33) and ZG.EQ(ZG.PRSO, "WEST")) then
        do local _ = ZG.TELL("The metal door bars the way.", ZG._TK.CR) end
        do return false end
    else
        FX = ZG.LKP(ZG.PRSO, ZG.CPEXITS)
        if (ZG.LT(36, (function() NFX = ZG.ADD(FX, ZG.CPHERE); return NFX end)()) or ZG.LT(NFX, 0) or ZG._T(ZG.ILLCP(ZG.CPHERE, FX))) then
            do local _ = ZG.TELL("There is a wall there.", ZG._TK.CR) end
            do return false end
        elseif ZG.EQUAL_p(ZG.ABS(FX), 1, 6) then
            do local _ = ZG.CPMOVE(FX) end
        elseif (ZG.LT(0, FX) and ZG.EQUAL_p(0, ZG.GET(ZG.CPTABLE, ZG.ADD(ZG.CPHERE, 6)), ZG.GET(ZG.CPTABLE, ZG.ADD(ZG.CPHERE, ZG.SUB(FX, 6))))) then
            do local _ = ZG.CPMOVE(FX) end
        elseif (ZG.LT(FX, 0) and ZG.EQUAL_p(0, ZG.GET(ZG.CPTABLE, ZG.SUB(ZG.CPHERE, 6)), ZG.GET(ZG.CPTABLE, ZG.ADD(ZG.ADD(ZG.CPHERE, 6), FX)))) then
            do local _ = ZG.CPMOVE(FX) end
        else
            do local _ = ZG.TELL("There is a wall there.", ZG._TK.CR) end
        end
        do return false end
    end

end, "CPEXIT")

ZG.CPEXIT = ZG.actions:get("CPEXIT")

-- zil: 3actions.zil:292  <GLOBAL MINUS-SEVEN>
-- MINUS_SEVEN is declared in ZilGlobal.lua

-- zil: 3actions.zil:293  <GLOBAL MINUS-FIVE>
-- MINUS_FIVE is declared in ZilGlobal.lua

-- zil: 3actions.zil:294  <GLOBAL MINUS-FOUR>
-- MINUS_FOUR is declared in ZilGlobal.lua

-- zil: 3actions.zil:295  <GLOBAL MINUS-ONE>
-- MINUS_ONE is declared in ZilGlobal.lua

-- zil: 3actions.zil:297  <ROUTINE ILLCP (ONE TWO)>
ZG.actions:register("ILLCP", function(ONE, TWO)

    if (ZG.EQ(ZG.MOD(ONE, 6), 0) and ZG.EQUAL_p(TWO, ZG.MINUS_FIVE, 1, 7)) then
        do return true end
    elseif (ZG.EQ(ZG.MOD(ONE, 6), 1) and ZG.EQUAL_p(TWO, ZG.MINUS_SEVEN, ZG.MINUS_ONE, 5)) then
        do return true end
    elseif (ZG.LT(ONE, 7) and ZG.LT(TWO, ZG.MINUS_FOUR)) then
        do return true end
    elseif (ZG.LT(30, ONE) and ZG.LT(4, TWO)) then
        do return true end
    else
        do return false end
    end

end, "ILLCP")

ZG.ILLCP = ZG.actions:get("ILLCP")

-- zil: 3actions.zil:305  <ROUTINE CPMOVE (FX)>
ZG.actions:register("CPMOVE", function(FX)

    if ZG.ZERO_p(ZG.GET(ZG.CPTABLE, (function() FX = ZG.ADD(ZG.CPHERE, FX); return FX end)())) then
        do return ZG.CPGOTO(FX) end
    else
        do return ZG.TELL("There is a wall there.", ZG._TK.CR) end
    end

end, "CPMOVE")

ZG.CPMOVE = ZG.actions:get("CPMOVE")

-- zil: 3actions.zil:311  <ROUTINE CPENTER ()>
ZG.actions:register("CPENTER", function()

    if ((not ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT)) or ZG._T(ZG.CPBLOCK_FLAG)) then
        do local _ = ZG.TELL("The hole is blocked by sandstone.", ZG._TK.CR) end
        do return false end
    else
        ZG._set("CPHERE", 1)
        do return ZG.CP end
    end

end, "CPENTER")

ZG.CPENTER = ZG.actions:get("CPENTER")

-- zil: 3actions.zil:319  <ROUTINE CPANT-ROOM (RARG)>
ZG.actions:register("CPANT_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a small square room, in the middle of which is a round hole") end
        if (ZG._T(ZG.CPBLOCK_FLAG) or (not ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT))) then
            do return ZG.TELL(" which is blocked by smooth sandstone.", ZG._TK.CR) end
        else
            do return ZG.TELL(" through which you can discern the floor some ten feet below.\nThe area under the hole is dark, but it appears to be completely enclosed\nin rock. In any event, it doesn't seem likely that you could climb back up.\nExits are west and, up a few steps, north.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "CPANT-ROOM")

ZG.CPANT_ROOM = ZG.actions:get("CPANT_ROOM")

-- zil: 3actions.zil:333  <GLOBAL CPPUSH-FLAG>
-- CPPUSH_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:335  <GLOBAL CPSOLVE-FLAG>
-- CPSOLVE_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:337  <ROUTINE CPLADDER-OBJECT ()>
ZG.actions:register("CPLADDER_OBJECT", function()

    if ZG.EQ(ZG.GET(ZG.CPTABLE, ZG.SUB(ZG.CPHERE, 1)), -3) then
        do return ZG.CPLADDER_JUNK(false) end
    elseif ZG.EQ(ZG.GET(ZG.CPTABLE, ZG.ADD(ZG.CPHERE, 1)), -2) then
        do return ZG.CPLADDER_JUNK(true) end
    else
        do return ZG.TELL("You can't see any ladder here.", ZG._TK.CR) end
    end

end, "CPLADDER-OBJECT")

ZG.CPLADDER_OBJECT = ZG.actions:get("CPLADDER_OBJECT")

-- zil: 3actions.zil:344  <ROUTINE CPLADDER-JUNK (FLG)>
ZG.actions:register("CPLADDER_JUNK", function(FLG)

    if ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-FOO")) then
        if (ZG._T(FLG) and ZG.EQ(ZG.CPHERE, 1)) then
            ZG._set("CPSOLVE_FLAG", true)
            do return ZG.GOTO(ZG.CP_ANTE) end
        else
            do return ZG.TELL("You hit your head on the ceiling and fall off the ladder.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("Come, come!", ZG._TK.CR) end
    end

end, "CPLADDER-JUNK")

ZG.CPLADDER_JUNK = ZG.actions:get("CPLADDER_JUNK")

-- zil: 3actions.zil:354  <ROUTINE CPWALL-OBJECT ("AUX" WL NWL NXT NNXT CNT TOP (SNAP <>))>
ZG.actions:register("CPWALL_OBJECT", function()

    local WL = 0
    local NWL = 0
    local NXT = 0
    local NNXT = 0
    local CNT = 0
    local TOP = 0
    local SNAP = false
    if ZG._T(ZG.VERB_p("MOVE")) then
        do return ZG.TELL("You can't grab the wall to pull it.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PUSH")) then
        NXT = ZG.CPNEXT(ZG.CPHERE, ZG.PRSO)
        if ZG.ZERO_p(NXT) then
            do local _ = ZG.TELL("The wall doesn't budge.", ZG._TK.CR) end
            do return true end
        end
        WL = ZG.GET(ZG.CPTABLE, NXT)
        if ZG.ZERO_p(WL) then
            do return ZG.TELL("There is only a passage in that direction.", ZG._TK.CR) end
        elseif (WL == 1) then
            do return ZG.TELL("The wall doesn't budge.", ZG._TK.CR) end
        elseif ZG.ZERO_p((function() NNXT = ZG.CPNEXT(NXT, ZG.PRSO); return NNXT end)()) then
            do return ZG.TELL("The wall barely gives.", ZG._TK.CR) end
        elseif (not ZG.ZERO_p((function() NWL = ZG.GET(ZG.CPTABLE, NNXT); return NWL end)())) then
            do return ZG.TELL("The wall barely gives.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The wall slides forward and you follow it") end
            if ZG._T(ZG.CPPUSH_FLAG) then
                do local _ = ZG.TELL(" to this position:", ZG._TK.CR) end
            else
                ZG._set("SCORE", ZG.ADD(ZG.SCORE, 1))
                do local _ = ZG.TELL("....\nThe architecture of this region is getting complex, so that further\ndescriptions will be diagrams of the immediate vicinity in a 3x3\ngrid. The walls here are rock, but of two different types - sandstone\nand marble. The following notations will be used:\n") end
                do local _ = ZG.FIXED_FONT_ON() end
                do local _ = ZG.TELL("\n  .. = your position (middle of grid)\n  MM = marble wall\n  SS = sandstone wall\n  ?? = unknown (blocked by walls)\n\n") end
                do local _ = ZG.FIXED_FONT_OFF() end
            end
            ZG._set("CPPUSH_FLAG", true)
            do local _ = ZG.PUT(ZG.CPTABLE, NXT, 0) end
            do local _ = ZG.PUT(ZG.CPTABLE, NNXT, WL) end
            if (not ZG.EQ(NNXT, 0)) then
                TOP = (8 * ZG.SUB(NNXT, 1))
                CNT = ZG.GET(ZG.CPOBJS, TOP)
                while true do
                    if ZG.ZERO_p(CNT) then
                        break
                    else
                        TOP = ZG.ADD(TOP, 1)
                        do local _ = ZG.MOVE(ZG.GET(ZG.CPOBJS, TOP), ZG.CP_OUT) end
                        if (not ZG._T(SNAP)) then
                            SNAP = true
                            do local _ = ZG.TELL("You hear a soft \"snap\" from behind the wall you were pushing.", ZG._TK.CR) end
                        end
                        CNT = ZG.SUB(CNT, 1)
                    end
                end
            end
            if ZG.EQ(NNXT, 1) then
                ZG._set("CPBLOCK_FLAG", true)
            end
            do return ZG.CPGOTO(NXT) end
        end
    else
        do return false end
    end

end, "CPWALL-OBJECT")

ZG.CPWALL_OBJECT = ZG.actions:get("CPWALL_OBJECT")

-- zil: 3actions.zil:414  <ROUTINE FIXED-FONT-ON ()>
ZG.actions:register("FIXED_FONT_ON", function()

    do return ZG.PUT(0, 8, ZG.BOR(ZG.GET(0, 8), 2)) end

end, "FIXED-FONT-ON")

ZG.FIXED_FONT_ON = ZG.actions:get("FIXED_FONT_ON")

-- zil: 3actions.zil:416  <ROUTINE FIXED-FONT-OFF ()>
ZG.actions:register("FIXED_FONT_OFF", function()

    do return ZG.PUT(0, 8, ZG.BAND(ZG.GET(0, 8), -3)) end

end, "FIXED-FONT-OFF")

ZG.FIXED_FONT_OFF = ZG.actions:get("FIXED_FONT_OFF")

-- zil: 3actions.zil:420  <GLOBAL CPBLOCK-FLAG>
-- CPBLOCK_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:422  <CONSTANT GCARDLOC>
-- GCARDLOC is declared in ZilGlobal.lua

-- ;"8*(22-1)"

-- zil: 3actions.zil:424  <ROUTINE CPGOTO (FX "AUX" F X CNT TOP)>
ZG.actions:register("CPGOTO", function(FX)

    local F = 0
    local X = 0
    local CNT = 0
    local TOP = 0
    ZG._set("CP_MOVED", true)
    do local _ = ZG.FCLEAR(ZG.HERE, "TOUCHBIT") end
    TOP = (8 * ZG.SUB(ZG.CPHERE, 1))
    CNT = ZG.ADD(TOP, 1)
    F = ZG.FIRST_p(ZG.CP)
    while true do
        X = ZG.NEXT_p(F)
        if (not ZG._T(F)) then
            break
        elseif ZG.EQ(F, ZG.ADVENTURER) then
        else
            do local _ = ZG.PUT(ZG.CPOBJS, CNT, F) end
            do local _ = ZG.REMOVE(F) end
            CNT = ZG.ADD(CNT, 1)
        end
        if (not ZG._T(X)) then
            break
        else
            F = X
        end
    end
    do local _ = ZG.PUT(ZG.CPOBJS, TOP, ZG.SUB(ZG.SUB(CNT, TOP), 1)) end
    ZG._set("CPHERE", FX)
    TOP = (8 * ZG.SUB(ZG.CPHERE, 1))
    CNT = ZG.GET(ZG.CPOBJS, TOP)
    while true do
        if ZG.ZERO_p(CNT) then
            break
        else
            TOP = ZG.ADD(TOP, 1)
            do local _ = ZG.MOVE(ZG.GET(ZG.CPOBJS, TOP), ZG.CP) end
            CNT = ZG.SUB(CNT, 1)
        end
    end
    do local _ = ZG.PERFORM(ZG.SYMBOL("V?LOOK")) end
    do return true end

end, "CPGOTO")

ZG.CPGOTO = ZG.actions:get("CPGOTO")

-- zil: 3actions.zil:454  <ROUTINE CPNEXT (RM OBJ "AUX" FX)>
ZG.actions:register("CPNEXT", function(RM, OBJ)

    local FX = 0
    FX = ZG.LKP(OBJ, ZG.CPWALLS)
    if ZG._T(ZG.ILLCP(RM, FX)) then
        do return 0 end
    else
        do return ZG.ADD(RM, FX) end
    end

end, "CPNEXT")

ZG.CPNEXT = ZG.actions:get("CPNEXT")

-- zil: 3actions.zil:460  <ROUTINE CPDOOR-F ()>
ZG.actions:register("CPDOOR_F", function()

    if (ZG.EQ(ZG.HERE, ZG.CP) and (not ZG.EQ(ZG.CPHERE, 33))) then
        do return ZG.TELL("You can't see any steel door here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.CP_FLAG) then
            do return ZG.TELL("The steel door has already opened.", ZG._TK.CR) end
        else
            do return ZG.TELL("You can't force it open.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        if ZG._T(ZG.CP_FLAG) then
            do return ZG.TELL("There doesn't seem to be any way to close it.", ZG._TK.CR) end
        else
            do return ZG.TELL("Do you think it isn't already?", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("The door is, to a first approximation, indestructible.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("KNOCK")) then
        do return ZG.TELL("Besides a great amount of reverberation, nothing happens.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CPDOOR-F")

ZG.CPDOOR_F = ZG.actions:get("CPDOOR_F")

-- zil: 3actions.zil:477  <ROUTINE CP-ROOM (RARG)>
ZG.actions:register("CP_ROOM", function(RARG)

    local _tmp1
    if ZG.EQ(RARG, ZG.M_ENTER) then
        if ZG.EQ(ZG.PRSO, "DOWN") then
            _tmp1 = 1
        else
            _tmp1 = 33
        end
        ZG._set("CPHERE", _tmp1)
        do return ZG.CPHERE end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG._T(ZG.CPPUSH_FLAG) then
            do return ZG.CPWHERE() end
        else
            do return ZG.TELL("You are in a small square room bounded to the north and west with\nmarble walls and to the east and south with sandstone walls.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "CP-ROOM")

ZG.CP_ROOM = ZG.actions:get("CP_ROOM")

-- zil: 3actions.zil:489  <ROUTINE CPNS (NUM)>
ZG.actions:register("CPNS", function(NUM)

    if (ZG.LT(36, NUM) or ZG.LT(NUM, 1)) then
        do return 1 end
    else
        do return ZG.GET(ZG.CPTABLE, NUM) end
    end

end, "CPNS")

ZG.CPNS = ZG.actions:get("CPNS")

-- zil: 3actions.zil:494  <ROUTINE CPEW (NUM FOO)>
ZG.actions:register("CPEW", function(NUM, FOO)

    if ZG.EQ(ZG.MOD(NUM, 6), FOO) then
        do return 1 end
    else
        do return ZG.GET(ZG.CPTABLE, NUM) end
    end

end, "CPEW")

ZG.CPEW = ZG.actions:get("CPEW")

-- zil: 3actions.zil:499  <ROUTINE CPWHERE ("AUX" (N <CPNS <+ ,CPHERE -6>>) (S <CPNS <+ ,CPHERE 6>>) (E...
ZG.actions:register("CPWHERE", function()

    local N = ZG.CPNS(ZG.ADD(ZG.CPHERE, -6))
    local S = ZG.CPNS(ZG.ADD(ZG.CPHERE, 6))
    local E = ZG.CPEW(ZG.ADD(ZG.CPHERE, 1), 1)
    local W = ZG.CPEW(ZG.ADD(ZG.CPHERE, -1), 0)
    do local _ = ZG.FIXED_FONT_ON() end
    do local _ = ZG.TELL("      +") end
    -- ;"Top Row"
    do local _ = ZG.CP_CORNER(ZG.MINUS_SEVEN, N, W) end
    do local _ = ZG.TELL(" ") end
    do local _ = ZG.CP_ORTHO(N) end
    do local _ = ZG.TELL(" ") end
    do local _ = ZG.CP_CORNER(ZG.MINUS_FIVE, N, E) end
    do local _ = ZG.TELL("+", ZG._TK.CR) end
    do local _ = ZG.TELL("West  +") end
    -- ;"Middle Row"
    do local _ = ZG.CP_ORTHO(W) end
    do local _ = ZG.TELL(" .. ") end
    do local _ = ZG.CP_ORTHO(E) end
    do local _ = ZG.TELL("+  East", ZG._TK.CR) end
    do local _ = ZG.TELL("      +") end
    -- ;"Bottom Row"
    do local _ = ZG.CP_CORNER(5, S, W) end
    do local _ = ZG.TELL(" ") end
    do local _ = ZG.CP_ORTHO(S) end
    do local _ = ZG.TELL(" ") end
    do local _ = ZG.CP_CORNER(7, S, E) end
    do local _ = ZG.TELL("+", ZG._TK.CR) end
    do local _ = ZG.FIXED_FONT_OFF() end
    if ZG.EQ(ZG.CPHERE, 1) then
        do local _ = ZG.TELL("In the ceiling above you is a large circular opening.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.CPHERE, 22) then
        do local _ = ZG.TELL("The center of the floor here is noticeably depressed.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.CPHERE, 33) then
        do local _ = ZG.TELL("In the center of the west wall is a steel door which is ") end
        if ZG._T(ZG.CP_FLAG) then
            do local _ = ZG.TELL("open") end
        else
            do local _ = ZG.TELL("closed") end
        end
        do local _ = ZG.TELL(".\nOn one side of the door is a narrow slot.", ZG._TK.CR) end
    end
    if ZG.EQ(E, -2) then
        do local _ = ZG.TELL("There is a ladder here, firmly attached to the east wall.", ZG._TK.CR) end
    end
    if ZG.EQ(W, -3) then
        do return ZG.TELL("There is a ladder here, firmly attached to the west wall.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CPWHERE")

ZG.CPWHERE = ZG.actions:get("CPWHERE")

-- zil: 3actions.zil:548  <ROUTINE CP-ORTHO (CONTENTS)>
ZG.actions:register("CP_ORTHO", function(CONTENTS)

    if ZG.ZERO_p(CONTENTS) then
        do return ZG.TELL("  ") end
    elseif (CONTENTS == 1) then
        do return ZG.TELL("MM") end
    else
        do return ZG.TELL("SS") end
    end

end, "CP-ORTHO")

ZG.CP_ORTHO = ZG.actions:get("CP_ORTHO")

-- ;"Show an orthogonal neighbor"

-- zil: 3actions.zil:556  <ROUTINE CP-CORNER (DIR COL ROW "AUX" LOCN)>
ZG.actions:register("CP_CORNER", function(DIR, COL, ROW)

    local _tmp1, _tmp2
    local LOCN = 0
    LOCN = ZG.ADD(ZG.CPHERE, DIR)
    if ((not ZG.EQ(COL, 0)) and (not ZG.EQ(ROW, 0))) then
        do return ZG.TELL("??") end
    elseif ZG._T(ZG.ILLCP(ZG.CPHERE, DIR)) then
        do return ZG.TELL("MM") end
    else
        if (ZG.LT(LOCN, 1) or ZG.LT(36, LOCN)) then
            _tmp1 = 1
        else
            _tmp1 = ZG.GET(ZG.CPTABLE, LOCN)
        end
        if (ZG.LT(LOCN, 1) or ZG.LT(36, LOCN)) then
            _tmp2 = 1
        else
            _tmp2 = ZG.GET(ZG.CPTABLE, LOCN)
        end
        if ZG.ZERO_p((function() COL = _tmp2; return COL end)()) then
            do return ZG.TELL("  ") end
        elseif (COL == 1) then
            do return ZG.TELL("MM") end
        else
            do return ZG.TELL("SS") end
        end
    end

end, "CP-CORNER")

ZG.CP_CORNER = ZG.actions:get("CP_CORNER")

-- zil: 3actions.zil:568  <ROUTINE CP-SLOT-FCN ()>
ZG.actions:register("CP_SLOT_FCN", function()

    if ZG._T(ZG.VERB_p("PUT")) then
        if ZG.LT(10, ZG.GETP(ZG.PRSO, "SIZE")) then
            do local _ = ZG.TELL("It doesn't fit.", ZG._TK.CR) end
            do return true end
        end
        do local _ = ZG.REMOVE(ZG.PRSO) end
        if ZG.EQ(ZG.PRSO, ZG.LORE_BOOK) then
            ZG._set("CP_FLAG", true)
            do return ZG.TELL("The book drops into the slot and vanishes. The metal door slides\nopen, revealing a passageway to the west, and a sign flashes:\n    \"Royal Puzzle Exit Fee Paid\n          Item Confiscated\"", ZG._TK.CR) end
        elseif ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
            do return ZG.TELL(ZG.PICK_ONE(ZG.YUKS), ZG._TK.CR) end
        else
            do return ZG.TELL("The item vanishes into the slot. A moment later, a previously\nunseen sign flashes \"Garbage In, Garbage Out\" and spews out\nthe ", ZG._TK.D, ZG.PRSO, " (now atomized).", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "CP-SLOT-FCN")

ZG.CP_SLOT_FCN = ZG.actions:get("CP_SLOT_FCN")

-- zil: 3actions.zil:589  <ROUTINE CPOUT-ROOM (RARG)>
ZG.actions:register("CPOUT_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a narrow room, lit from above. A flight of steps leads up\nto the north, and a ") end
        if ZG._T(ZG.CP_FLAG) then
            do local _ = ZG.TELL("passage") end
        else
            do local _ = ZG.TELL("metal door") end
        end
        do return ZG.TELL(" leads to the east.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CPOUT-ROOM")

ZG.CPOUT_ROOM = ZG.actions:get("CPOUT_ROOM")

-- ;"SUBTITLE It's All Done with Mirrors"

-- zil: 3actions.zil:602  <GLOBAL MLOC>
-- MLOC is declared in ZilGlobal.lua

-- zil: 3actions.zil:604  <GLOBAL MR1-FLAG>
-- MR1_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:606  <GLOBAL MR2-FLAG>
-- MR2_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:608  <GLOBAL MIRROR-OPEN-FLAG>
-- MIRROR_OPEN_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:610  <GLOBAL WOOD-OPEN-FLAG>
-- WOOD_OPEN_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:612  <GLOBAL MRSWPUSH-FLAG>
-- MRSWPUSH_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:614  <GLOBAL R-SOUTHS>
-- R_SOUTHS is declared in ZilGlobal.lua

-- zil: 3actions.zil:615  <GLOBAL R-NORTHS>
-- R_NORTHS is declared in ZilGlobal.lua

-- zil: 3actions.zil:617  <ROUTINE MRGO ("AUX" TORM)>
ZG.actions:register("MRGO", function()

    local TORM = 0
    if ZG.EQUAL_p(ZG.PRSO, "NORTH", "NW", "NE") then
        TORM = ZG.LKP(ZG.HERE, ZG.R_NORTHS)
    else
        TORM = ZG.LKP(ZG.HERE, ZG.R_SOUTHS)
    end
    if ZG.EQUAL_p(ZG.PRSO, "NORTH", "SOUTH") then
        if ZG.EQ(ZG.MLOC, TORM) then
            if ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
                do local _ = ZG.TELL("There is a wooden wall blocking your way.", ZG._TK.CR) end
                do return false end
            elseif ZG._T(ZG.MIRIN(false)) then
                do return ZG.IN_MIRROR end
            else
                do local _ = ZG.MIRBLOCK() end
                do return false end
            end
        else
            do return TORM end
        end
    elseif ZG.EQ(ZG.MLOC, TORM) then
        if ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
            do return ZG.GO_E_W(TORM) end
        else
            do local _ = ZG.MIRBLOCK() end
            do return false end
        end
    else
        do return TORM end
    end

end, "MRGO")

ZG.MRGO = ZG.actions:get("MRGO")

-- zil: 3actions.zil:635  <ROUTINE MIRBLOCK ("AUX" MD)>
ZG.actions:register("MIRBLOCK", function()

    local MD = 0
    MD = ZG.MDIR
    if ZG.EQ(ZG.PRSO, "SOUTH") then
        MD = ZG.MOD(ZG.ADD(ZG.MDIR, 180), 360)
    end
    if ((ZG.EQ(MD, 270) and (not ZG._T(ZG.MR1_FLAG))) or (ZG.EQ(MD, 90) and (not ZG._T(ZG.MR2_FLAG)))) then
        do return ZG.TELL("There is a large broken mirror blocking your way.", ZG._TK.CR) end
    else
        do return ZG.TELL("There is a large mirror blocking your way.", ZG._TK.CR) end
    end

end, "MIRBLOCK")

ZG.MIRBLOCK = ZG.actions:get("MIRBLOCK")

-- zil: 3actions.zil:645  <ROUTINE GO-E-W (RM)>
ZG.actions:register("GO_E_W", function(RM)

    if ZG.EQUAL_p(ZG.PRSO, "NE", "SE") then
        do return ZG.LKP(RM, ZG.R_EASTS) end
    else
        do return ZG.LKP(RM, ZG.R_WESTS) end
    end

end, "GO-E-W")

ZG.GO_E_W = ZG.actions:get("GO_E_W")

-- zil: 3actions.zil:650  <GLOBAL R-EASTS>
-- R_EASTS is declared in ZilGlobal.lua

-- zil: 3actions.zil:651  <GLOBAL R-WESTS>
-- R_WESTS is declared in ZilGlobal.lua

-- ---- DEFMAC N-S (3actions.zil:653-653) ------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC N-S () '<0? <MOD ,MDIR 180>>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC E-W (3actions.zil:655-655) ------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC E-W ('FX) <FORM OR <FORM ==? .FX 90> <FORM ==? .FX 270>>>
-- ---------------------------------------------------------------------

-- zil: 3actions.zil:657  <ROUTINE EWTELL (RM "AUX" (EAST? <>) (M1? <>) MWIN)>
ZG.actions:register("EWTELL", function(RM)

    local _tmp1, _tmp2, _tmp3, _tmp4, _tmp5, _tmp6, _tmp7
    local EAST_p = false
    local M1_p = false
    local MWIN = 0
    if (ZG.EQUAL_p(RM, ZG.MRAE, ZG.MRBE, ZG.MRCE) or ZG.EQUAL_p(RM, ZG.MRGE, ZG.MRCE)) then
        EAST_p = true
    end
    if ZG._T(EAST_p) then
        _tmp1 = 0
    else
        _tmp1 = 180
    end
    if ZG.EQ(ZG.ADD(ZG.MDIR, _tmp1), 180) then
        M1_p = true
    end
    if ZG._T(M1_p) then
        MWIN = ZG.MR1_FLAG
    else
        MWIN = ZG.MR2_FLAG
    end
    if ZG._T(EAST_p) then
        _tmp2 = "west"
    else
        _tmp2 = "east"
    end
    if ZG._T(MWIN) then
        _tmp3 = "mirror."
    else
        _tmp3 = "wooden panel\nwhich once contained a mirror."
    end
    if ZG._T(EAST_p) then
        _tmp4 = "west"
    else
        _tmp4 = "east"
    end
    if ZG._T(MWIN) then
        _tmp5 = "mirror."
    else
        _tmp5 = "wooden panel\nwhich once contained a mirror."
    end
    do local _ = ZG.TELL("You are in a narrow room, whose ", _tmp4, " wall is a large ", _tmp5, ZG._TK.CR) end
    if (ZG._T(M1_p) and ZG._T(ZG.MIRROR_OPEN_FLAG)) then
        if ZG._T(MWIN) then
            _tmp6 = "The mirror is mounted on a panel which has been opened outward."
        else
            _tmp6 = "The panel has been opened outward."
        end
        if ZG._T(MWIN) then
            _tmp7 = "The mirror is mounted on a panel which has been opened outward."
        else
            _tmp7 = "The panel has been opened outward."
        end
        do local _ = ZG.TELL(_tmp7, ZG._TK.CR) end
    end
    do return ZG.TELL("The opposite wall is solid rock.", ZG._TK.CR) end

end, "EWTELL")

ZG.EWTELL = ZG.actions:get("EWTELL")

-- zil: 3actions.zil:678  <GLOBAL GUARDIANS-SEEN>
-- GUARDIANS_SEEN is declared in ZilGlobal.lua

-- zil: 3actions.zil:680  <ROUTINE MRDEW ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRDEW", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.EWTELL(ZG.HERE) end
        ZG._set("GUARDIANS_SEEN", true)
        do return ZG.TELL("Somewhat to the south", ZG.GUARDSTR, ZG._TK.CR) end
    else
        do return false end
    end

end, "MRDEW")

ZG.MRDEW = ZG.actions:get("MRDEW")

-- zil: 3actions.zil:686  <ROUTINE MRCEW ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRCEW", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.EWTELL(ZG.HERE) end
        ZG._set("GUARDIANS_SEEN", true)
        do return ZG.TELL("Somewhat to the north", ZG.GUARDSTR, ZG._TK.CR) end
    else
        do return false end
    end

end, "MRCEW")

ZG.MRCEW = ZG.actions:get("MRCEW")

-- zil: 3actions.zil:692  <ROUTINE MRBEW ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRBEW", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.EWTELL(ZG.HERE) end
        do return ZG.TELL("To the north and south are large hallways.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MRBEW")

ZG.MRBEW = ZG.actions:get("MRBEW")

-- zil: 3actions.zil:697  <ROUTINE MRAEW ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRAEW", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.EWTELL(ZG.HERE) end
        do return ZG.TELL("To the north is a large hallway.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MRAEW")

ZG.MRAEW = ZG.actions:get("MRAEW")

-- zil: 3actions.zil:702  <GLOBAL GUARDSTR>
-- GUARDSTR is declared in ZilGlobal.lua

-- zil: 3actions.zil:708  <ROUTINE LOOK-TO (RMN RMS "AUX" (NORTH? <>) (NTELL <>) (STELL <>) MIR? (M1? <...
ZG.actions:register("LOOK_TO", function(RMN, RMS)

    local _tmp1, _tmp2, _tmp3, _tmp4, _tmp5
    local NORTH_p = false
    local NTELL = false
    local STELL = false
    local MIR_p = 0
    local M1_p = false
    local DIR = 0
    if (not ZG.EQUAL_p(ZG.HERE, ZG.MREYE, ZG.FRONT_DOOR)) then
        do local _ = ZG.TELL("This is a part of the long hallway. The east and west walls are\ndressed stone. In the center of the hall is a shallow stone channel.\nIn the center of the room the channel widens into a large hole around\nwhich is engraved a compass rose.", ZG._TK.CR) end
    end
    if ZG.EQ(ZG.HERE, ZG.MRG) then
        ZG._set("GUARDIANS_SEEN", true)
        do local _ = ZG.TELL("On either side of you are identical stone statues holding bludgeons. They\nappear ready to strike, though, for the moment, they remain impassive.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.HERE, ZG.MRC) then
        ZG._set("GUARDIANS_SEEN", true)
        do local _ = ZG.TELL("Somewhat to the north", ZG.GUARDSTR, ZG._TK.CR) end
        NTELL = true
    elseif ZG.EQ(ZG.HERE, ZG.FRONT_DOOR) then
        do local _ = ZG.TELL("You are in a north-south hallway which ends, to the north, at a large wooden\ndoor.", ZG._TK.CR) end
        NTELL = true
    elseif ZG.EQ(ZG.HERE, ZG.MRD) then
        ZG._set("GUARDIANS_SEEN", true)
        do local _ = ZG.TELL("Somewhat to the south", ZG.GUARDSTR, ZG._TK.CR) end
        STELL = true
    elseif ZG.EQ(ZG.HERE, ZG.MRA) then
        do local _ = ZG.TELL("The hallway continues to the south.", ZG._TK.CR) end
        STELL = true
    end
    if ZG.EQUAL_p(ZG.MLOC, RMN, RMS) then
        if ZG.EQ(ZG.MLOC, RMN) then
            NORTH_p = true
            NTELL = true
            DIR = "nor"
        else
            STELL = true
            DIR = "sou"
        end
        if (ZG._T(NORTH_p) and ZG.LT(180, ZG.MDIR) and ZG.LT(ZG.MDIR, 359)) then
            M1_p = true
            _tmp1 = ZG.MR1_FLAG
        elseif ((not ZG._T(NORTH_p)) and ZG.LT(0, ZG.MDIR) and ZG.LT(ZG.MDIR, 179)) then
            M1_p = true
            _tmp1 = ZG.MR1_FLAG
        else
            _tmp1 = ZG.MR2_FLAG
        end
        MIR_p = _tmp1
        if ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
            do local _ = ZG.TELL("The ", DIR, "th side of the room is divided by a wooden wall into small\nhallways to the ") end
            do local _ = ZG.TELL(DIR, "theast and ") end
            do local _ = ZG.TELL(DIR, "thwest.", ZG._TK.CR) end
        else
            if ZG._T(MIR_p) then
                _tmp2 = "A large mirror fills the "
            else
                _tmp2 = "A large panel fills the "
            end
            if ZG._T(MIR_p) then
                _tmp3 = "A large mirror fills the "
            else
                _tmp3 = "A large panel fills the "
            end
            do local _ = ZG.TELL(_tmp3, DIR, "th side of the hallway.", ZG._TK.CR) end
            if (ZG._T(M1_p) and ZG._T(ZG.MIRROR_OPEN_FLAG)) then
                if ZG._T(MIR_p) then
                    _tmp4 = "The mirror is mounted on a panel which has been opened outward."
                else
                    _tmp4 = "The panel has been opened outward."
                end
                if ZG._T(MIR_p) then
                    _tmp5 = "The mirror is mounted on a panel which has been opened outward."
                else
                    _tmp5 = "The panel has been opened outward."
                end
                do local _ = ZG.TELL(_tmp5, ZG._TK.CR) end
            end
        end
    end
    if ((not ZG._T(NTELL)) and (not ZG._T(STELL))) then
        do local _ = ZG.TELL("The corridor continues north and south.", ZG._TK.CR) end
    elseif (not ZG._T(NTELL)) then
        do local _ = ZG.TELL("The corridor continues north.", ZG._TK.CR) end
    elseif (not ZG._T(STELL)) then
        do local _ = ZG.TELL("The corridor continues south.", ZG._TK.CR) end
    end
    do return true end

end, "LOOK-TO")

ZG.LOOK_TO = ZG.actions:get("LOOK_TO")

-- zil: 3actions.zil:778  <ROUTINE MRDF ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRDF", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.LOOK_TO(ZG.FRONT_DOOR, ZG.MRG) end
    else
        do return false end
    end

end, "MRDF")

ZG.MRDF = ZG.actions:get("MRDF")

-- zil: 3actions.zil:782  <ROUTINE MRCF ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRCF", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.LOOK_TO(ZG.MRG, ZG.MRB) end
    else
        do return false end
    end

end, "MRCF")

ZG.MRCF = ZG.actions:get("MRCF")

-- zil: 3actions.zil:786  <ROUTINE MRBF ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRBF", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.LOOK_TO(ZG.MRC, ZG.MRA) end
    else
        do return false end
    end

end, "MRBF")

ZG.MRBF = ZG.actions:get("MRBF")

-- zil: 3actions.zil:790  <ROUTINE MRAF ("OPTIONAL" (RARG <>))>
ZG.actions:register("MRAF", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.LOOK_TO(ZG.MRB, false) end
    else
        do return false end
    end

end, "MRAF")

ZG.MRAF = ZG.actions:get("MRAF")

-- zil: 3actions.zil:794  <ROUTINE GUARDIANS ("OPTIONAL" (RARG <>))>
ZG.actions:register("GUARDIANS", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG.EQ(ZG.HERE, ZG.MRG) then
            do return ZG.LOOK_TO(ZG.MRD, ZG.MRC) end
        else
            do local _ = ZG.EWTELL(ZG.HERE) end
            do return ZG.TELL("To the east and west are the Guardians of Zork, in perfect symmetry.\nFrom here, it's hard to tell which of the two is a reflection!", ZG._TK.CR) end
        end
    elseif (ZG.EQ(RARG, ZG.M_ENTER) and (not ZG._T(ZG.INVIS))) then
        do return ZG.JIGS_UP("The Guardians awake, and in perfect unison, pulverize you with\ntheir bludgeons. Satisfied, they resume their posts.") end
    elseif (not ZG.EQ(RARG, ZG.M_END)) then
        do return false end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG.EQ(ZG.HERE, ZG.IN_MIRROR) then
            do return ZG.TELL("You can't see them from here.", ZG._TK.CR) end
        else
            do return ZG.TELL("The Guardians are quite impressive. I wouldn't get in their way if\nI were you!", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("THROW")) and ZG.EQ(ZG.PRSI, ZG.GUARDIAN)) then
        if ZG.EQ(ZG.PRSO, ZG.ME) then
            do local _ = ZG.TELL("You step") end
        else
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " falls") end
            do local _ = ZG.REMOVE(ZG.PRSO) end
        end
        do local _ = ZG.TELL(" in front of the Guardians, who ") end
        if ZG.EQ(ZG.PRSO, ZG.ME) then
            do local _ = ZG.TELL("decimate you") end
        else
            do local _ = ZG.TELL("destroy it") end
        end
        do return ZG.TELL(" in perfect\nunison. Satisfied, they resume their posts.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK")) then
        do return ZG.TELL("You aren't close enough, and even if you were, the fight\nwould be a bit one-sided.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("HELLO")) then
        do return ZG.TELL("The statues are impassive.", ZG._TK.CR) end
    else
        do return false end
    end

end, "GUARDIANS")

ZG.GUARDIANS = ZG.actions:get("GUARDIANS")

-- zil: 3actions.zil:834  <ROUTINE MIRROR-DIR? (DIR RM "AUX" TBL)>
ZG.actions:register("MIRROR_DIR_p", function(DIR, RM)

    local _tmp1
    local TBL = 0
    if ZG.EQ(DIR, "NORTH") then
        _tmp1 = ZG.R_NORTHS
    else
        _tmp1 = ZG.R_SOUTHS
    end
    TBL = _tmp1
    if (ZG._T(ZG.GETPT(RM, DIR)) and ZG.EQ(ZG.MLOC, ZG.LKP(RM, TBL))) then
        if (ZG.EQ(DIR, "NORTH") and ZG.LT(180, ZG.MDIR) and ZG.LT(ZG.MDIR, 360)) then
            do return 1 end
        elseif (ZG.EQ(DIR, "SOUTH") and ZG.LT(0, ZG.MDIR) and ZG.LT(ZG.MDIR, 180)) then
            do return 1 end
        else
            do return 2 end
        end
    else
        do return false end
    end

end, "MIRROR-DIR?")

ZG.MIRROR_DIR_p = ZG.actions:get("MIRROR_DIR_p")

-- zil: 3actions.zil:848  <ROUTINE WOODEN-WALL-F ()>
ZG.actions:register("WOODEN_WALL_F", function()

    if (ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) and (ZG._T(ZG.MIRROR_DIR_p("NORTH", ZG.HERE)) or ZG._T(ZG.MIRROR_DIR_p("SOUTH", ZG.HERE)))) then
        if ZG._T(ZG.VERB_p("PUSH")) then
            do return ZG.TELL("The structure won't budge.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return ZG.TELL("You can't see any wooden wall here.", ZG._TK.CR) end
    end

end, "WOODEN-WALL-F")

ZG.WOODEN_WALL_F = ZG.actions:get("WOODEN_WALL_F")

-- zil: 3actions.zil:856  <ROUTINE MIRROR-HERE? (RM "AUX" TMP)>
ZG.actions:register("MIRROR_HERE_p", function(RM)

    local _tmp1
    local TMP = 0
    if (ZG.EQUAL_p(ZG.HERE, ZG.MRAE, ZG.MRAW, ZG.MRBE) or ZG.EQUAL_p(ZG.HERE, ZG.MRBW, ZG.MRCE, ZG.MRCW) or ZG.EQUAL_p(ZG.HERE, ZG.MRGE, ZG.MRGW, ZG.MRDE) or ZG.EQ(ZG.HERE, ZG.MRDW)) then
        if (ZG.EQUAL_p(RM, ZG.MRAE, ZG.MRBE, ZG.MRCE) or ZG.EQUAL_p(RM, ZG.MRGE, ZG.MRDE)) then
            _tmp1 = 0
        else
            _tmp1 = 180
        end
        if ZG.EQ(180, ZG.ADD(ZG.MDIR, _tmp1)) then
            do return 1 end
        else
            do return 2 end
        end
    elseif ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
        do return false end
    elseif ZG._T((function() TMP = ZG.MIRROR_DIR_p("NORTH", RM); return TMP end)()) then
        do return TMP end
    elseif ZG._T((function() TMP = ZG.MIRROR_DIR_p("SOUTH", RM); return TMP end)()) then
        do return TMP end
    else
        do return false end
    end

end, "MIRROR-HERE?")

ZG.MIRROR_HERE_p = ZG.actions:get("MIRROR_HERE_p")

-- zil: 3actions.zil:872  <ROUTINE MIRROR-FUNCTION ("AUX" MIRROR)>
ZG.actions:register("MIRROR_FUNCTION", function()

    local _tmp1, _tmp2
    local MIRROR = 0
    if (not ZG._T((function() MIRROR = ZG.MIRROR_HERE_p(ZG.HERE); return MIRROR end)())) then
        do return ZG.TELL("You can't see any mirror here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "MOVE")) then
        do return ZG.TELL("You don't see a way to open the mirror here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        if ((ZG.EQ(MIRROR, 1) and ZG._T(ZG.MR1_FLAG)) or ZG._T(ZG.MR2_FLAG)) then
            if ZG._T(ZG.INVIS) then
                do return ZG.TELL("Amazingly, you have no reflection!", ZG._TK.CR) end
            else
                do return ZG.TELL("A disheveled adventurer stares back at you.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("You have destroyed the mirror, or have you forgotten?", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        if (MIRROR == 1) then
            if ZG._T(ZG.MR1_FLAG) then
                ZG._set("MR1_FLAG", false)
                do return ZG.TELL("The mirror breaks, revealing a wooden panel behind it. The glistening\nfragments of mirror quietly sparkle into nonexistance.", ZG._TK.CR) end
            else
                do return ZG.TELL("The mirror has already been broken.", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.MR2_FLAG) then
            ZG._set("MR2_FLAG", false)
            do return ZG.TELL("The mirror breaks, revealing a wooden panel behind it. The glistening\nfragments of mirror quietly sparkle into nonexistance.", ZG._TK.CR) end
        else
            do return ZG.TELL("The mirror has already been broken.", ZG._TK.CR) end
        end
    elseif ((ZG.EQ(MIRROR, 1) and (not ZG._T(ZG.MR1_FLAG))) or (not ZG._T(ZG.MR2_FLAG))) then
        do return ZG.TELL("There's no mirror left.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PUSH")) then
        if ZG.EQ(MIRROR, 1) then
            _tmp1 = "The mirror is mounted on a wooden panel which moves slightly inward\nas you push, and back out when you let go. It feels fragile."
        else
            _tmp1 = "The mirror is unyielding, but seems fragile."
        end
        if ZG.EQ(MIRROR, 1) then
            _tmp2 = "The mirror is mounted on a wooden panel which moves slightly inward\nas you push, and back out when you let go. It feels fragile."
        else
            _tmp2 = "The mirror is unyielding, but seems fragile."
        end
        do return ZG.TELL(_tmp2, ZG._TK.CR) end
    else
        do return false end
    end

end, "MIRROR-FUNCTION")

ZG.MIRROR_FUNCTION = ZG.actions:get("MIRROR_FUNCTION")

-- zil: 3actions.zil:914  <ROUTINE PANEL-FUNCTION ("AUX" MIRROR)>
ZG.actions:register("PANEL_FUNCTION", function()

    local _tmp1, _tmp2
    local MIRROR = 0
    if (not ZG._T((function() MIRROR = ZG.MIRROR_HERE_p(ZG.HERE); return MIRROR end)())) then
        do return ZG.TELL("You can't see any panel here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "MOVE")) then
        do return ZG.TELL("You don't see a way to open the panel here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        if ZG.EQ(MIRROR, 1) then
            if ZG._T(ZG.MR1_FLAG) then
                do return ZG.TELL(ZG.MIRROR_FIRST, ZG._TK.CR) end
            else
                do return ZG.TELL("The panel is not that easily destroyed.", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.MR2_FLAG) then
            do return ZG.TELL(ZG.MIRROR_FIRST, ZG._TK.CR) end
        else
            do return ZG.TELL("The panel is not that easily destroyed.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("PUSH")) then
        if ZG.EQ(MIRROR, 1) then
            _tmp1 = "The wooden panel moves slightly inward as you push, and back out\nwhen you let go."
        else
            _tmp1 = "The panel is unyielding."
        end
        if ZG.EQ(MIRROR, 1) then
            _tmp2 = "The wooden panel moves slightly inward as you push, and back out\nwhen you let go."
        else
            _tmp2 = "The panel is unyielding."
        end
        do return ZG.TELL(_tmp2, ZG._TK.CR) end
    else
        do return false end
    end

end, "PANEL-FUNCTION")

ZG.PANEL_FUNCTION = ZG.actions:get("PANEL_FUNCTION")

-- zil: 3actions.zil:935  <GLOBAL MIRROR-FIRST>
-- MIRROR_FIRST is declared in ZilGlobal.lua

-- zil: 3actions.zil:938  <GLOBAL DIRVEC>
-- DIRVEC is declared in ZilGlobal.lua

-- zil: 3actions.zil:941  <ROUTINE MIROUT ("AUX" DIR RM)>
ZG.actions:register("MIROUT", function()

    local DIR = 0
    local RM = 0
    if ZG.EQ(ZG.PRSO, "OUT") then
        DIR = 1
    else
        DIR = ZG.LKP(ZG.PRSO, ZG.DIRVEC)
    end
    if ZG._T(ZG.MIRROR_OPEN_FLAG) then
        if (ZG.EQ(DIR, 1) or ZG.EQ(ZG.MOD(ZG.ADD(ZG.MDIR, 270), 360), DIR)) then
            if ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
                do return ZG.MIREW() end
            else
                do return ZG.MIRNS(ZG.LT(ZG.MDIR, 180), true) end
            end
        else
            do local _ = ZG.TELL("There's a wall there.", ZG._TK.CR) end
            do return false end
        end
    elseif ZG._T(ZG.WOOD_OPEN_FLAG) then
        if (ZG.EQ(DIR, 1) or ZG.EQ(ZG.MOD(ZG.ADD(ZG.MDIR, 180), 360), DIR)) then
            if ZG.ZERO_p(ZG.MDIR) then
                RM = false
            else
                RM = true
            end
            if ZG._T((function() RM = ZG.MIRNS(RM, true); return RM end)()) then
                do local _ = ZG.TELL("As you leave, the door swings shut.", ZG._TK.CR) end
                ZG._set("WOOD_OPEN_FLAG", false)
                do return RM end
            else
                do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
                do return false end
            end
        else
            do local _ = ZG.TELL("You would hit one of the panels.", ZG._TK.CR) end
            do return false end
        end
    else
        do local _ = ZG.TELL("You are inside a closed box!", ZG._TK.CR) end
        do return false end
    end

end, "MIROUT")

ZG.MIROUT = ZG.actions:get("MIROUT")

-- zil: 3actions.zil:975  <ROUTINE MIRNS (NORTH? "OPTIONAL" (EXIT? <>) "AUX" S T)>
ZG.actions:register("MIRNS", function(NORTH_p, EXIT_p)

    local _tmp1, _tmp2
    if EXIT_p == nil then EXIT_p = false end
    local S = 0
    local T = 0
    if (not ZG._T(EXIT_p)) then
        if (ZG._T(NORTH_p) and ZG.EQ(ZG.MLOC, ZG.MRD)) then
            do return false end
        elseif ((not ZG._T(NORTH_p)) and ZG.EQ(ZG.MLOC, ZG.MRA)) then
            do return false end
        end
    end
    if ZG._T(NORTH_p) then
        _tmp1 = "NORTH"
    else
        _tmp1 = "SOUTH"
    end
    if ZG._T(NORTH_p) then
        _tmp2 = "NORTH"
    else
        _tmp2 = "SOUTH"
    end
    if ZG._T((function() T = ZG.GETPT(ZG.MLOC, _tmp2); return T end)()) then
        if ZG.EQ((function() S = ZG.PTSIZE(T); return S end)(), ZG.UEXIT) then
            do return ZG.GETB(T, 0) end
        elseif ZG._T(NORTH_p) then
            do return ZG.LKP(ZG.MLOC, ZG.R_NORTHS) end
        else
            do return ZG.LKP(ZG.MLOC, ZG.R_SOUTHS) end
        end
    else
        do return false end
    end

end, "MIRNS")

ZG.MIRNS = ZG.actions:get("MIRNS")

-- zil: 3actions.zil:990  <ROUTINE MIREW ()>
ZG.actions:register("MIREW", function()

    if ZG.ZERO_p(ZG.MDIR) then
        do return ZG.LKP(ZG.MLOC, ZG.R_WESTS) end
    else
        do return ZG.LKP(ZG.MLOC, ZG.R_EASTS) end
    end

end, "MIREW")

ZG.MIREW = ZG.actions:get("MIREW")

-- zil: 3actions.zil:994  <ROUTINE MIRIN ("OPTIONAL" (VRB T))>
ZG.actions:register("MIRIN", function(VRB)

    if VRB == nil then VRB = true end
    if (ZG.EQ(ZG.MIRROR_HERE_p(ZG.HERE), 1) and ZG._T(ZG.MIRROR_OPEN_FLAG)) then
        do return ZG.IN_MIRROR end
    elseif (not ZG._T(VRB)) then
        do return false end
    elseif ZG.EQ(ZG.MIRROR_HERE_p(ZG.HERE), 1) then
        if ((not ZG._T(ZG.MIRROR_OPENED)) and ZG._T(ZG.MR1_FLAG)) then
            do local _ = ZG.TELL("A mirror blocks your way.", ZG._TK.CR) end
            do return false end
        else
            do local _ = ZG.TELL("The panel is closed.", ZG._TK.CR) end
            do return false end
        end
    else
        do local _ = ZG.TELL("The structure blocks your way.", ZG._TK.CR) end
        do return false end
    end

end, "MIRIN")

ZG.MIRIN = ZG.actions:get("MIRIN")

-- zil: 3actions.zil:1005  <ROUTINE MREYE-ROOM ("OPTIONAL" (RARG <>) "AUX" O)>
ZG.actions:register("MREYE_ROOM", function(RARG)

    if RARG == nil then RARG = false end
    local O = 0
    if (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("DROP")) and ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER)) and (not ZG._T(ZG.BEAM_STOPPED_p()))) then
        do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
        do return ZG.TELL("You conveniently drop the ", ZG._TK.D, ZG.PRSO, " in position to block the\nbeam of light.", ZG._TK.CR) end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in the middle of a long north-south corridor whose walls are\npolished stone. A narrow red beam of light crosses the room at the north\nend, inches above the floor.", ZG._TK.CR) end
        if ZG._T((function() O = ZG.BEAM_STOPPED_p(); return O end)()) then
            do local _ = ZG.TELL("The beam is blocked by a ", ZG._TK.D, O, " lying on the floor.", ZG._TK.CR) end
        end
        do return ZG.LOOK_TO(ZG.MRA, false) end
    else
        do return false end
    end

end, "MREYE-ROOM")

ZG.MREYE_ROOM = ZG.actions:get("MREYE_ROOM")

-- zil: 3actions.zil:1024  <ROUTINE BEAM-STOPPED? ("AUX" N)>
ZG.actions:register("BEAM_STOPPED_p", function()

    local N = 0
    N = ZG.FIRST_p(ZG.MREYE)
    while true do
        if (not ZG.EQUAL_p(N, ZG.PLAYER, ZG.BEAM)) then
            ZG._set("BEAM_BREAKER", N)
            do return N end
        elseif (not ZG._T((function() N = ZG.NEXT_p(N); return N end)())) then
            do return false end
        end
    end

end, "BEAM-STOPPED?")

ZG.BEAM_STOPPED_p = ZG.actions:get("BEAM_STOPPED_p")

-- ; "This function cannot have its .PRSI and .PRSO's changed to ,PRSI etc!!"

-- zil: 3actions.zil:1034  <GLOBAL BEAM-BREAKER>
-- BEAM_BREAKER is declared in ZilGlobal.lua

-- zil: 3actions.zil:1036  <ROUTINE BEAM-FUNCTION ("AUX" PRO PRI)>
ZG.actions:register("BEAM_FUNCTION", function()

    local PRO = 0
    local PRI = 0
    if ZG._T(ZG.VERB_p("LEAP")) then
        do local _ = ZG.TELL("You jump over the beam and into the hallway.", ZG._TK.CR) end
        do local _ = ZG.GOTO(ZG.MRA) end
        do return true end
    elseif ZG._T(ZG.VERB_p("FOLLOW")) then
        do return ZG.TELL("It simply crosses the northern end of the room, so there's nowhere to\nfollow it.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do local _ = ZG.TELL("The red beam of light crosses the north end of the room only an inch or so\nabove the floor.") end
        if ZG._T(ZG.BEAM_STOPPED_p()) then
            do local _ = ZG.TELL(" The beam is broken by a ", ZG._TK.D, ZG.BEAM_BREAKER, " lying on the ground.") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("PUT", "MUNG")) then
        if ZG._T(ZG.VERB_p("PUT")) then
            PRI = ZG.PRSO
            PRO = ZG.PRSI
        else
            PRI = ZG.PRSI
            PRO = ZG.PRSO
        end
        if ((not ZG._T(PRI)) or (not ZG.EQ(PRO, ZG.BEAM))) then
            do return false end
        elseif ZG._T(ZG.IN_p(PRI, ZG.WINNER)) then
            do local _ = ZG.MOVE(PRI, ZG.HERE) end
            ZG._set("BEAM_BREAKER", PRI)
            do return ZG.TELL("The beam is now interrupted by a ", ZG._TK.D, PRI, " lying on the floor.", ZG._TK.CR) end
        elseif ZG._T(ZG.IN_p(PRI, ZG.HERE)) then
            do return ZG.TELL("The ", ZG._TK.D, PRI, " already breaks the beam.", ZG._TK.CR) end
        elseif ZG.EQ(PRI, ZG.HANDS) then
            do return ZG.TELL("The beam is broken briefly as it passes through.", ZG._TK.CR) end
        else
            do return ZG.TELL("You're not holding the ", ZG._TK.D, PRI, ".", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.PRSO, ZG.BEAM)) then
        do return ZG.TELL("No doubt you have a bottle of moonbeams as well.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BEAM-FUNCTION")

ZG.BEAM_FUNCTION = ZG.actions:get("BEAM_FUNCTION")

-- zil: 3actions.zil:1079  <GLOBAL MIRROR-OPENED>
-- MIRROR_OPENED is declared in ZilGlobal.lua

-- zil: 3actions.zil:1081  <ROUTINE MRSWITCH ()>
ZG.actions:register("MRSWITCH", function()

    if ZG._T(ZG.VERB_p("PUSH")) then
        if ZG._T(ZG.MRSWPUSH_FLAG) then
            do return ZG.TELL("Click.", ZG._TK.CR) end
        else
            if ZG._T(ZG.BEAM_STOPPED_p()) then
                do local _ = ZG.TELL("Click. Snap!", ZG._TK.CR) end
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MRINT, 7)) end
                ZG._set("MRSWPUSH_FLAG", true)
                ZG._set("MIRROR_OPEN_FLAG", true)
                ZG._set("MIRROR_OPENED", true)
                do return ZG.FCLEAR(ZG.MRA, "TOUCHBIT") end
            else
                do return ZG.TELL("Click.", ZG._TK.CR) end
            end
        end
    else
        do return false end
    end

end, "MRSWITCH")

ZG.MRSWITCH = ZG.actions:get("MRSWITCH")

-- zil: 3actions.zil:1095  <ROUTINE I-MRINT ()>
ZG.actions:register("I_MRINT", function()

    ZG._set("MRSWPUSH_FLAG", false)
    ZG._set("MIRROR_OPEN_FLAG", false)
    if (ZG.EQ(ZG.MIRROR_HERE_p(ZG.HERE), 1) or ZG.EQ(ZG.HERE, ZG.IN_MIRROR)) then
        do return ZG.TELL("The mirror quietly swings shut.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.HERE, ZG.MR_ANTE) then
        do return ZG.TELL("The button pops back to its original position.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-MRINT")

ZG.I_MRINT = ZG.actions:get("I_MRINT")

-- zil: 3actions.zil:1104  <GLOBAL MDIR>
-- MDIR is declared in ZilGlobal.lua

-- ;"mirror points... 0 = north"

-- zil: 3actions.zil:1108  <GLOBAL POLEUP-FLAG>
-- POLEUP_FLAG is declared in ZilGlobal.lua

-- ;"pole raised?: 0 -- in hole or channel, 1 -- foor level, 2 -- in air"

-- zil: 3actions.zil:1112  <ROUTINE MAGIC-MIRROR ("OPTIONAL" (RARG <>))>
ZG.actions:register("MAGIC_MIRROR", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are inside a rectangular box of wood whose structure is rather\ncomplicated. Four sides and the roof are filled in, and the floor is\nopen.\n\nAs you face the side opposite the entrance, two short sides of\ncarved and polished wood are to your left and right. The left panel\nis mahogany, the right pine. The wall you face is red on its left\nhalf and black on its right. On the entrance side, the wall is white\nopposite the red part of the wall it faces, and yellow opposite the\nblack section. The painted walls are at least twice the length of\nthe unpainted ones. The ceiling is painted blue.\n\nIn the floor is a stone channel about six inches wide and a foot\ndeep. The channel is oriented in a north-south direction. In the\nexact center of the room the channel widens into a circular\ndepression perhaps two feet wide. Incised in the stone around this\narea is a compass rose.\n\nRunning from one short wall to the other at about waist height\nis a wooden bar, carefully carved and drilled. This bar is pierced\nin two places. The first hole is in the center of the bar (and thus\nthe center of the room). The second is at the left end of the room\n(as you face opposite the entrance). Through each hole runs a wooden\npole.\n\nThe pole at the left end of the bar is short, extending about a foot\nabove the bar, and ends in a hand grip. The pole ") end
        if (ZG.EQ(ZG.MLOC, ZG.MRB) and ZG.EQ(ZG.MDIR, 270)) then
            if (not ZG.ZERO_p(ZG.POLEUP_FLAG)) then
                do local _ = ZG.TELL("has been lifted out\nof a hole carved in the stone floor. There is evidently enough\nfriction to keep the pole from dropping back down.") end
            else
                do local _ = ZG.TELL("has been dropped\ninto a hole carved in the stone floor.") end
            end
        elseif ZG.EQUAL_p(ZG.MDIR, 0, 180) then
            if (not ZG.ZERO_p(ZG.POLEUP_FLAG)) then
                do local _ = ZG.TELL("is positioned above\nthe stone channel in the floor.") end
            else
                do local _ = ZG.TELL("has been dropped\ninto the stone channel incised in the floor.") end
            end
        else
            do local _ = ZG.TELL("is resting on the\nstone floor.") end
        end
        do local _ = ZG.TELL("\n\nThe long pole at the center of the bar extends from the ceiling\nthrough the bar to the circular area in the stone channel. This\nbottom end of the pole has a T-bar a bit less than two feet long\nattached to it, and on the T-bar is carved an arrow. The arrow and\nT-bar are pointing ", ZG.GET(ZG.LONGDIRS, ZG.DIV(ZG.MDIR, 45)), ".") end
        if ZG._T(ZG.WOOD_OPEN_FLAG) then
            do local _ = ZG.TELL("\nThe pine panel has been opened outward.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "MAGIC-MIRROR")

ZG.MAGIC_MIRROR = ZG.actions:get("MAGIC_MIRROR")

-- zil: 3actions.zil:1177  <GLOBAL LONGDIRS>
-- LONGDIRS is declared in ZilGlobal.lua

-- ;"MOVEMENT"

-- zil: 3actions.zil:1182  <ROUTINE MPANELS ("AUX" MD)>
ZG.actions:register("MPANELS", function()

    local MD = 0
    if ZG._T(ZG.VERB_p("PUSH")) then
        if (not ZG.ZERO_p(ZG.POLEUP_FLAG)) then
            if ZG.EQ(ZG.MLOC, ZG.MRG) then
                if ZG._T(ZG.GUARDIANS_SEEN) then
                    do local _ = ZG.JIGS_UP("The Guardians awake, and in perfect unison, utterly destroy you with\ntheir stone bludgeons. Satisfied, they resume their posts.") end
                    do return true end
                else
                    do local _ = ZG.JIGS_UP("All at once, two immense stone bludgeons come through the top of the\nstructure, crushing you.") end
                    do return true end
                end
            end
            if ZG.EQUAL_p(ZG.PRSO, ZG.RED_PANEL, ZG.YELLOW_PANEL) then
                MD = ZG.MOD(ZG.ADD(ZG.MDIR, 45), 360)
                do local _ = ZG.TELL("The structure rotates clockwise.", ZG._TK.CR) end
            else
                MD = ZG.MOD(ZG.ADD(ZG.MDIR, 315), 360)
                do local _ = ZG.TELL("The structure rotates counterclockwise.", ZG._TK.CR) end
            end
            do local _ = ZG.TELL("The arrow on the compass rose now indicates ", ZG.GET(ZG.LONGDIRS, ZG.DIV(MD, 45)), ".", ZG._TK.CR) end
            if ZG._T(ZG.WOOD_OPEN_FLAG) then
                ZG._set("WOOD_OPEN_FLAG", false)
                do local _ = ZG.TELL("The pine wall closes quietly.", ZG._TK.CR) end
            end
            ZG._set("MDIR", MD)
            do return true end
        elseif ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
            do return ZG.TELL("The short pole prevents the structure from rotating.", ZG._TK.CR) end
        else
            do return ZG.TELL("The structure shakes slightly but doesn't move.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "MPANELS")

ZG.MPANELS = ZG.actions:get("MPANELS")

-- zil: 3actions.zil:1218  <ROUTINE MENDS ("AUX" RM)>
ZG.actions:register("MENDS", function()

    local RM = 0
    if ZG._T(ZG.VERB_p("CLOSE")) then
        do return ZG.TELL("You can't do that to the panel.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUSH")) or (ZG._T(ZG.VERB_p("OPEN")) and ZG.EQ(ZG.PRSO, ZG.PINE_PANEL))) then
        if (not ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180))) then
            do return ZG.TELL("The structure rocks back and forth slightly but doesn't move.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSO, ZG.MAHOGANY_PANEL) then
            if ZG._T((function() RM = ZG.MIRNS(ZG.LT(ZG.MDIR, 180)); return RM end)()) then
                do return ZG.MIRMOVE(ZG.ZERO_p(ZG.MDIR), RM) end
            else
                do return ZG.TELL("The structure has reached the end of the stone channel and won't\nbudge.", ZG._TK.CR) end
            end
        else
            do local _ = ZG.TELL("The pine wall swings open.", ZG._TK.CR) end
            if ((ZG.EQ(ZG.MLOC, ZG.MRD) and ZG.EQ(ZG.MDIR, 0)) or (ZG.EQ(ZG.MLOC, ZG.MRC) and ZG.EQ(ZG.MDIR, 180)) or ZG.EQ(ZG.MLOC, ZG.MRG)) then
                if ZG._T(ZG.GUARDIANS_SEEN) then
                    do local _ = ZG.TELL("The pine door opens into the field of view of the Guardians.", ZG._TK.CR) end
                else
                    do local _ = ZG.TELL("The pine door opens into the field of view of the Guardians of\nZork, represented by two identical stone statues carrying bludgeons.", ZG._TK.CR) end
                end
                do local _ = ZG.JIGS_UP("The Guardians awake, and in perfect unison, utterly destroy you with\ntheir stone bludgeons. Satisfied, they resume their posts.") end
                do return true end
            end
            ZG._set("WOOD_OPEN_FLAG", true)
            do return ZG.ENABLE(ZG.QUEUE(ZG.I_PININ, 5)) end
        end
    else
        do return false end
    end

end, "MENDS")

ZG.MENDS = ZG.actions:get("MENDS")

-- zil: 3actions.zil:1253  <ROUTINE I-PININ ()>
ZG.actions:register("I_PININ", function()

    if ZG._T(ZG.WOOD_OPEN_FLAG) then
        ZG._set("WOOD_OPEN_FLAG", false)
        do return ZG.TELL("The pine wall closes quietly.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-PININ")

ZG.I_PININ = ZG.actions:get("I_PININ")

-- zil: 3actions.zil:1258  <ROUTINE MIRMOVE (NORTH? RM "AUX" (PU? <>) (LOSE <>))>
ZG.actions:register("MIRMOVE", function(NORTH_p, RM)

    local _tmp1, _tmp2, _tmp3, _tmp4
    local PU_p = false
    local LOSE = false
    if (not ZG.ZERO_p(ZG.POLEUP_FLAG)) then
        PU_p = true
    end
    if ZG._T(PU_p) then
        _tmp1 = "The structure sways unsteadily "
    else
        _tmp1 = "The structure slides "
    end
    if ZG._T(NORTH_p) then
        _tmp2 = "north"
    else
        _tmp2 = "south"
    end
    if ZG._T(PU_p) then
        _tmp3 = "The structure sways unsteadily "
    else
        _tmp3 = "The structure slides "
    end
    if ZG._T(NORTH_p) then
        _tmp4 = "north"
    else
        _tmp4 = "south"
    end
    do local _ = ZG.TELL(_tmp3, _tmp4, " and stops over another compass rose.", ZG._TK.CR) end
    ZG._set("MLOC", RM)
    if (ZG.EQ(RM, ZG.MRG) and ZG.EQ(ZG.HERE, ZG.IN_MIRROR)) then
        if ZG._T(PU_p) then
            LOSE = true
        elseif ((not ZG._T(ZG.MR1_FLAG)) or (not ZG._T(ZG.MR2_FLAG))) then
            LOSE = true
        elseif (ZG._T(ZG.MIRROR_OPEN_FLAG) or ZG._T(ZG.WOOD_OPEN_FLAG)) then
            LOSE = true
        end
        if ZG._T(LOSE) then
            if ZG._T(ZG.GUARDIANS_SEEN) then
                do local _ = ZG.JIGS_UP("Suddenly the Guardians realize someone is trying to sneak by them in\nthe structure. They awake and, in perfect unison, hammer the contents\nof the box (in other words you) to pulp. They then resume their posts,\nsatisfied.") end
            else
                do local _ = ZG.JIGS_UP("Suddenly, two identical stone bludgeons come through the roof and\nhammer the contents of the box to pulp. That includes you.") end
            end
        end
        do return true end
    end
    do return true end

end, "MIRMOVE")

ZG.MIRMOVE = ZG.actions:get("MIRMOVE")

-- zil: 3actions.zil:1286  <ROUTINE SHORT-POLE-F ()>
ZG.actions:register("SHORT_POLE_F", function()

    if ZG._T(ZG.VERB_p("RAISE", "MOVE")) then
        if ZG.EQ(ZG.POLEUP_FLAG, 2) then
            do return ZG.TELL("The pole cannot be raised further.", ZG._TK.CR) end
        else
            ZG._set("POLEUP_FLAG", 2)
            do return ZG.TELL("The pole is now slightly above the floor.", ZG._TK.CR) end
        end
    elseif ((ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.CHANNEL)) or ZG._T(ZG.VERB_p("PUSH", "LOWER"))) then
        if ZG.ZERO_p(ZG.POLEUP_FLAG) then
            do return ZG.TELL("The pole cannot be lowered further.", ZG._TK.CR) end
        elseif ZG.ZERO_p(ZG.MOD(ZG.MDIR, 180)) then
            do local _ = ZG.TELL("The pole is lowered into the channel.", ZG._TK.CR) end
            ZG._set("POLEUP_FLAG", 0)
            do return true end
        elseif (ZG.EQ(ZG.MDIR, 270) and ZG.EQ(ZG.MLOC, ZG.MRB)) then
            ZG._set("POLEUP_FLAG", 0)
            do return ZG.TELL("The pole is lowered into the stone hole.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.POLEUP_FLAG, 1) then
            do return ZG.TELL("The pole is already resting on the floor.", ZG._TK.CR) end
        else
            ZG._set("POLEUP_FLAG", 1)
            do return ZG.TELL("The pole now rests on the stone floor.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SHORT-POLE-F")

ZG.SHORT_POLE_F = ZG.actions:get("SHORT_POLE_F")

-- zil: 3actions.zil:1312  <ROUTINE DUNGEON-MASTER-F ("OPTIONAL" (RARG <>))>
ZG.actions:register("DUNGEON_MASTER_F", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_OBJDESC) then
        do return false end
    elseif ZG.EQ(ZG.WINNER, ZG.DUNGEON_MASTER) then
        if ZG._T(ZG.VERB_p("FOLLOW")) then
            if ZG._T(ZG.IN_p(ZG.DUNGEON_MASTER, ZG.LOC(ZG.PLAYER))) then
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_FOLIN, -1)) end
                do return ZG.TELL("The dungeon master answers, \"I will follow.\"", ZG._TK.CR) end
            else
                do return ZG.TELL("The dungeon master's voice replies, \"You must come here first!\"", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.VERB_p("STAY", "WAIT")) then
            do local _ = ZG.QUEUE(ZG.I_FOLIN, 0) end
            do return ZG.TELL("The dungeon master answers, \"I will stay.\"", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("WALK")) then
            if (ZG.EQUAL_p(ZG.PRSO, "SOUTH", "ENTER") and ZG.EQ(ZG.HERE, ZG.NORTH_CORRIDOR)) then
                do return ZG.TELL("\"I am not permitted to enter the prison cell.\"", ZG._TK.CR) end
            elseif (ZG.EQ(ZG.PRSO, "NORTH") and ZG.EQ(ZG.HERE, ZG.NORTH_CORRIDOR)) then
                do local _ = ZG.MOVE(ZG.DUNGEON_MASTER, ZG.PARAPET) end
                ZG._set("HERE", ZG.PARAPET)
                do local _ = ZG.TELL("\"Very well. I am at the parapet!\"", ZG._TK.CR) end
                do return ZG.QUEUE(ZG.I_FOLIN, 0) end
            elseif (ZG.EQUAL_p(ZG.PRSO, "NORTH", "ENTER") and ZG.EQ(ZG.HERE, ZG.SOUTH_CORRIDOR)) then
                do return ZG.TELL("\"I am not permitted to enter the prison cell.\"", ZG._TK.CR) end
            else
                do return ZG.TELL("\"I prefer to stay where I am, thank you.\"", ZG._TK.CR) end
            end
        elseif (ZG._T(ZG.VERB_p("WALK-TO")) and ZG.EQ(ZG.PRSO, ZG.PARAPET_OBJ)) then
            do local _ = ZG.MOVE(ZG.DUNGEON_MASTER, ZG.PARAPET) end
            ZG._set("HERE", ZG.PARAPET)
            do local _ = ZG.QUEUE(ZG.I_FOLIN, 0) end
            do return ZG.TELL("\"Very well!\"", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("TAKE")) then
            do return ZG.TELL("\"I will have no use for that, I am afraid.\"", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("OPEN")) and ZG.EQ(ZG.PRSO, ZG.DUNGEON_DOOR) and ZG._T(ZG.IN_DUNGEON)) then
            do return ZG.TELL("The dungeon master appears angered. \"Do not run from your quest: you are\nnearing the end!\"", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("PUSH", "TURN", "SPIN", "FOLLOW", "STAY", "OPEN", "CLOSE", "WAIT", "ATTACK", "WALK-TO")) then
            if ZG._T(ZG.VERB_p("STAY", "FOLLOW", "WAIT")) then
            else
                do local _ = ZG.TELL("\"If you wish,\" he replies.", ZG._TK.CR) end
            end
            do return false end
        else
            do return ZG.TELL("\"Do not be foolish! Consider the end of your quest!\"", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("He is dressed simply in a hood and cloak, wearing an amulet and ring,\ncarrying an old book under one arm, and leaning on a wooden staff. A single\nkey, as if to a prison cell, hangs from his belt.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        do return ZG.REALLY_DEAD("The dungeon master is taken by surprise. He dodges your blow, and\nwith a disappointed expression on his face, traces a complicated\npattern in the air with his staff. You crumble into dust.") end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("\"I'm willing to accompany you, but not ride in your pocket!\"", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.DUNGEON_MASTER)) then
        do return ZG.TELL("\"I have no need for those things.\"", ZG._TK.CR) end
    else
        do return false end
    end

end, "DUNGEON-MASTER-F")

ZG.DUNGEON_MASTER_F = ZG.actions:get("DUNGEON_MASTER_F")

-- zil: 3actions.zil:1385  <ROUTINE MASTER-F ()>
ZG.actions:register("MASTER_F", function()

    if ZG.EQUAL_p(ZG.HERE, ZG.PRISON_CELL, ZG.GOOD_CELL) then
        if ZG._T(ZG.HELLO_p(ZG.MASTER)) then
            do return ZG.TELL("He can't hear you.", ZG._TK.CR) end
        else
            do return ZG.TELL("He is not here.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("TELL")) then
        if ZG._T(ZG.IN_DUNGEON) then
            ZG._set("PRSO", ZG.DUNGEON_MASTER)
            do return false end
        else
            ZG._set("P_CONT", false)
            ZG._set("QUOTE_FLAG", false)
            do return ZG.TELL("The dungeon master isn't here.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("GIVE", "SGIVE")) and ZG._T(ZG.IN_p(ZG.DUNGEON_MASTER, ZG.HERE))) then
        do return ZG.TELL("He politely refuses your offer.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("EXAMINE")) and ZG.EQUAL_p(ZG.HERE, ZG.CELL, ZG.NORTH_CORRIDOR) and ZG._T(ZG.IN_p(ZG.DUNGEON_MASTER, ZG.PARAPET))) then
        do return ZG.TELL("The dungeon master is standing on the parapet.", ZG._TK.CR) end
    else
        do return ZG.TELL("The dungeon master isn't here.", ZG._TK.CR) end
    end

end, "MASTER-F")

ZG.MASTER_F = ZG.actions:get("MASTER_F")

-- zil: 3actions.zil:1407  <GLOBAL DM-SEEN>
-- DM_SEEN is declared in ZilGlobal.lua

-- zil: 3actions.zil:1409  <ROUTINE BEHIND-DOOR-F ("OPTIONAL" (RARG <>))>
ZG.actions:register("BEHIND_DOOR_F", function(RARG)

    if RARG == nil then RARG = false end
    if (ZG.EQ(RARG, ZG.M_ENTER) and (not ZG._T(ZG.DM_SEEN))) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_FOLIN, -1)) end
        ZG._set("DM_SEEN", true)
        do return ZG.DM_SEEN end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a narrow north-south corridor. At the south end is a door\nand at the north end is an east-west corridor. The door is ") end
        do return ZG.DPR(ZG.DUNGEON_DOOR) end
    else
        do return false end
    end

end, "BEHIND-DOOR-F")

ZG.BEHIND_DOOR_F = ZG.actions:get("BEHIND_DOOR_F")

-- zil: 3actions.zil:1419  <ROUTINE FRONT-DOOR-F ("OPTIONAL" (RARG <>))>
ZG.actions:register("FRONT_DOOR_F", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.QUEUE(ZG.I_FOLIN, 0) end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.LOOK_TO(false, ZG.MRD) end
        do local _ = ZG.TELL("The wooden door has a barred panel in it at about head height. The\ndoor itself is ") end
        do return ZG.DPR(ZG.DUNGEON_DOOR) end
    else
        do return false end
    end

end, "FRONT-DOOR-F")

ZG.FRONT_DOOR_F = ZG.actions:get("FRONT_DOOR_F")

-- zil: 3actions.zil:1429  <ROUTINE LOOK-LIKE-DM? ()>
ZG.actions:register("LOOK_LIKE_DM_p", function()

    do return (ZG._T(ZG.IN_p(ZG.CLOAK, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.HOOD, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.AMULET, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.STAFF, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.RING, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.LORE_BOOK, ZG.WINNER)) and ZG.IN_p(ZG.KEY, ZG.WINNER)) end

end, "LOOK-LIKE-DM?")

ZG.LOOK_LIKE_DM_p = ZG.actions:get("LOOK_LIKE_DM_p")

-- zil: 3actions.zil:1438  <ROUTINE DUNGEON-PANEL-F ()>
ZG.actions:register("DUNGEON_PANEL_F", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("You can't open the panel. It's set into the door.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do return ZG.TELL("There's not much to be seen.", ZG._TK.CR) end
    else
        do return false end
    end

end, "DUNGEON-PANEL-F")

ZG.DUNGEON_PANEL_F = ZG.actions:get("DUNGEON_PANEL_F")

-- zil: 3actions.zil:1444  <ROUTINE DUNGEON-DOOR-F ()>
ZG.actions:register("DUNGEON_DOOR_F", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("The door won't budge.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("KNOCK")) and ZG.EQ(ZG.HERE, ZG.FRONT_DOOR)) then
        do local _ = ZG.TELL("The knock reverberates along the hall. For a time it seems there\nwill be no answer. Then you hear someone unlatching the small\npanel. Through the bars of the great door, the wrinkled\nface of an old man appears.") end
        if ZG._T(ZG.INVIS) then
            do local _ = ZG.TELL(" He seems not to notice you\nfor a brief moment, then recovers.") end
        end
        if ZG._T(ZG.LOOK_LIKE_DM_p()) then
            do local _ = ZG.TELL(" He starts to smile broadly and opens the\nmassive door without a sound. The old man motions and you feel yourself\ndrawn toward him.\n\"I am the Master of the Dungeon!\" he booms. \"I have been watching\nyou closely during your journey through the Great Underground Empire.\nYes!,\" he says, as if recalling some almost forgotten time, \"we have\nmet before, although I may not appear as I did then.\" You look\nclosely into his deeply lined face and see the faces of the old man by the\nsecret door, your \"friend\" at the cliff, and the hooded figure. \"You have\nshown kindness to the old man, and compassion toward the hooded one. You\ndisplayed patience in the puzzle and trust at the cliff. You have\ndemonstrated strength, ingenuity, and valor. However, one final test awaits\nyou. Now! Command me as you will, and complete your quest!\"\n", ZG._TK.CR) end
            do local _ = ZG.GOTO(ZG.BEHIND_DOOR) end
            ZG._set("IN_DUNGEON", true)
            do return ZG.IN_DUNGEON end
        else
            do local _ = ZG.TELL(" He looks you over with a piercing gaze\nand then speaks gravely. \"I have been waiting a long time for you, ") end
            do local _ = ZG.TELL(ZG.GET(ZG.DM_REASONS, ZG.DMISH())) end
            do local _ = ZG.TELL("\nI will remain here. When you feel you are ready, go to the\nsecret door and 'SAY \"FROTZ OZMOO\"'! Go, now!\" He wags his finger\nin warning. \"Do not forget the double\nquotes!\" A moment later, you find yourself in the Button Room.", ZG._TK.CR) end
            do local _ = ZG.GOTO(ZG.MR_ANTE, false) end
            do return true end
        end
    else
        do return false end
    end

end, "DUNGEON-DOOR-F")

ZG.DUNGEON_DOOR_F = ZG.actions:get("DUNGEON_DOOR_F")

-- zil: 3actions.zil:1484  <GLOBAL IN-DUNGEON>
-- IN_DUNGEON is declared in ZilGlobal.lua

-- zil: 3actions.zil:1486  <GLOBAL DM-REASONS>
-- DM_REASONS is declared in ZilGlobal.lua

-- zil: 3actions.zil:1495  <ROUTINE DMISH ("AUX" (CNT 0))>
ZG.actions:register("DMISH", function()

    local CNT = 0
    if ZG._T(ZG.IN_p(ZG.AMULET, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    if ZG._T(ZG.IN_p(ZG.LORE_BOOK, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    if ZG._T(ZG.IN_p(ZG.HOOD, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    if ZG._T(ZG.IN_p(ZG.CLOAK, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    if ZG._T(ZG.IN_p(ZG.RING, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    if ZG._T(ZG.IN_p(ZG.KEY, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    if ZG._T(ZG.IN_p(ZG.STAFF, ZG.WINNER)) then
        CNT = ZG.ADD(CNT, 1)
    end
    do return CNT end

end, "DMISH")

ZG.DMISH = ZG.actions:get("DMISH")

-- zil: 3actions.zil:1505  <GLOBAL FOLFLAG>
-- FOLFLAG is declared in ZilGlobal.lua

-- ;"Following?"

-- zil: 3actions.zil:1507  <ROUTINE I-FOLIN ()>
ZG.actions:register("I_FOLIN", function()

    if ZG._T(ZG.IN_p(ZG.DUNGEON_MASTER, ZG.HERE)) then
        do return false end
    elseif (ZG.EQUAL_p(ZG.HERE, ZG.PRISON_CELL, ZG.CELL) and ZG._T(ZG.FOLFLAG)) then
        do local _ = ZG.TELL("You notice that the dungeon master doesn't follow you.", ZG._TK.CR) end
        ZG._set("FOLFLAG", false)
        do return true end
    elseif ZG.EQUAL_p(ZG.LOC(ZG.PLAYER), ZG.PRISON_CELL, ZG.CELL) then
        do return false end
    elseif (not ZG._T(ZG.FOLFLAG)) then
        ZG._set("FOLFLAG", true)
        do local _ = ZG.TELL("The dungeon master rejoins you.", ZG._TK.CR) end
        do local _ = ZG.MOVE(ZG.DUNGEON_MASTER, ZG.HERE) end
        do return true end
    else
        do local _ = ZG.TELL("The dungeon master follows you.", ZG._TK.CR) end
        do local _ = ZG.MOVE(ZG.DUNGEON_MASTER, ZG.HERE) end
        do return true end
    end

end, "I-FOLIN")

ZG.I_FOLIN = ZG.actions:get("I_FOLIN")

-- ;"SUBTITLE
--  'The end had come, and this was it; he dropped her in the Flaming Pit.'"

-- zil: 3actions.zil:1530  <GLOBAL LCELL>
-- LCELL is declared in ZilGlobal.lua

-- ;"cell in slot"

-- zil: 3actions.zil:1532  <GLOBAL PNUMB>
-- PNUMB is declared in ZilGlobal.lua

-- ;"cell pointed at"

-- zil: 3actions.zil:1534  <GLOBAL CELLOBJS>
-- CELLOBJS is declared in ZilGlobal.lua

-- zil: 3actions.zil:1536  <ROUTINE MOVE-CELL-OBJECTS ("AUX" TOP CNT F X)>
ZG.actions:register("MOVE_CELL_OBJECTS", function()

    local TOP = 0
    local CNT = 0
    local F = 0
    local X = 0
    TOP = (8 * ZG.SUB(ZG.LCELL, 1))
    CNT = ZG.ADD(TOP, 1)
    F = ZG.FIRST_p(ZG.CELL)
    if ZG._T(F) then
        while true do
            X = ZG.NEXT_p(F)
            if (not ZG._T(F)) then
                break
            else
                do local _ = ZG.PUT(ZG.CELLOBJS, CNT, F) end
                do local _ = ZG.REMOVE(F) end
                CNT = ZG.ADD(CNT, 1)
            end
            if (not ZG._T(X)) then
                break
            else
                F = X
            end
        end
    end
    do local _ = ZG.PUT(ZG.CELLOBJS, TOP, ZG.SUB(ZG.SUB(CNT, TOP), 1)) end
    TOP = (8 * ZG.SUB(ZG.PNUMB, 1))
    CNT = ZG.GET(ZG.CELLOBJS, TOP)
    while true do
        if ZG.ZERO_p(CNT) then
            do return true end
        else
            TOP = ZG.ADD(TOP, 1)
            do local _ = ZG.MOVE(ZG.GET(ZG.CELLOBJS, TOP), ZG.CELL) end
            CNT = ZG.SUB(CNT, 1)
        end
    end

end, "MOVE-CELL-OBJECTS")

ZG.MOVE_CELL_OBJECTS = ZG.actions:get("MOVE_CELL_OBJECTS")

-- zil: 3actions.zil:1560  <ROUTINE CELL-MOVE ("AUX" F X)>
ZG.actions:register("CELL_MOVE", function()

    local _tmp1, _tmp2
    local F = 0
    local X = 0
    do local _ = ZG.FCLEAR(ZG.CELL_DOOR, "OPENBIT") end
    do local _ = ZG.FCLEAR(ZG.BRONZE_DOOR, "OPENBIT") end
    if (not ZG.EQ(ZG.PNUMB, ZG.LCELL)) then
        if ZG.EQ(ZG.PNUMB, 4) then
            do local _ = ZG.FCLEAR(ZG.BRONZE_DOOR, "INVISIBLE") end
        else
            do local _ = ZG.FSET(ZG.BRONZE_DOOR, "INVISIBLE") end
        end
        if ZG._T(ZG.IN_p(ZG.PLAYER, ZG.CELL)) then
            ZG._set("WINNER", ZG.PLAYER)
            do local _ = ZG.FCLEAR(ZG.GOOD_CELL, "TOUCHBIT") end
            do local _ = ZG.FCLEAR(ZG.PRISON_CELL, "TOUCHBIT") end
            if ZG.EQ(ZG.LCELL, 4) then
                do local _ = ZG.FCLEAR(ZG.BRONZE_DOOR, "INVISIBLE") end
                _tmp1 = ZG.GOOD_CELL
            else
                _tmp1 = ZG.PRISON_CELL
            end
            if ZG.EQ(ZG.LCELL, 4) then
                do local _ = ZG.FCLEAR(ZG.BRONZE_DOOR, "INVISIBLE") end
                _tmp2 = ZG.GOOD_CELL
            else
                _tmp2 = ZG.PRISON_CELL
            end
            do local _ = ZG.GOTO(_tmp2) end
            F = ZG.FIRST_p(ZG.CELL)
            if ZG._T(F) then
                while true do
                    X = ZG.NEXT_p(F)
                    if (not ZG._T(F)) then
                        break
                    else
                        do local _ = ZG.MOVE(F, ZG.HERE) end
                    end
                    if (not ZG._T(X)) then
                        break
                    else
                        F = X
                    end
                end
            end
        else
            do local _ = ZG.MOVE_CELL_OBJECTS() end
        end
        ZG._set("LCELL", ZG.PNUMB)
        do return ZG.LCELL end
    else
        do return false end
    end

end, "CELL-MOVE")

ZG.CELL_MOVE = ZG.actions:get("CELL_MOVE")

-- zil: 3actions.zil:1585  <ROUTINE PARAPET-F (RARG)>
ZG.actions:register("PARAPET_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are standing behind a stone retaining wall which rims a parapet\noverlooking a fiery pit. It is difficult to see through the\nsmoke and flame which fills the pit, but it seems to be bottomless.\nThe pit itself is circular, about two hundred feet in diameter,\nand is fashioned of roughly hewn stone. The flames generate considerable\nheat, so it is rather uncomfortable standing here.\nThere is an object here which looks like a sundial. On it are an\nindicator arrow surrounding a large button. On the face of\nthe dial are numbers 1 through 8. The indicator points to the number ", ZG._TK.N, ZG.PNUMB, ".", ZG._TK.CR) end
        do return ZG.TELL("To the south, across a narrow corridor, is a prison cell.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PARAPET-F")

ZG.PARAPET_F = ZG.actions:get("PARAPET_F")

-- zil: 3actions.zil:1601  <ROUTINE DIAL ("AUX" N)>
ZG.actions:register("DIAL", function()

    local N = 0
    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The dial points to ", ZG._TK.N, ZG.PNUMB, ".", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TURN")) then
        if ZG.EQ(ZG.PRSI, ZG.INTNUM) then
            if (ZG.ZERO_p(ZG.P_NUMBER) or ZG.LT(8, ZG.P_NUMBER)) then
                do local _ = ZG.TELL("There is no such setting.", ZG._TK.CR) end
                do return true end
            end
            ZG._set("PNUMB", ZG.P_NUMBER)
            if ZG.EQ(ZG.WINNER, ZG.PLAYER) then
                do local _ = ZG.TELL("The dial now points to ", ZG._TK.N, ZG.PNUMB, ".", ZG._TK.CR) end
            end
            do return true end
        elseif (not ZG._T(ZG.PRSI)) then
            do return ZG.TELL("You must specify what to set the dial to.", ZG._TK.CR) end
        else
            do return ZG.TELL("The dial face only contains numbers.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("SPIN")) then
        ZG._set("PNUMB", ZG.RANDOM(8))
        if ZG.EQ(ZG.WINNER, ZG.PLAYER) then
            do local _ = ZG.TELL("The dial spins and comes to a stop pointing at ", ZG._TK.N, ZG.PNUMB, ".") end
        end
        do return true end
    else
        do return false end
    end

end, "DIAL")

ZG.DIAL = ZG.actions:get("DIAL")

-- zil: 3actions.zil:1625  <ROUTINE DIALBUTTON ("AUX" C)>
ZG.actions:register("DIALBUTTON", function()

    local C = 0
    C = ZG.FSET_p(ZG.CELL_DOOR, "OPENBIT")
    do local _ = ZG.FCLEAR(ZG.CELL, "TOUCHBIT") end
    if ZG._T(ZG.VERB_p("PUSH")) then
        if ZG.EQ(ZG.WINNER, ZG.PLAYER) then
            do local _ = ZG.TELL("The button depresses with a slight click, and pops back.", ZG._TK.CR) end
        end
        do local _ = ZG.CELL_MOVE() end
        if ZG._T(C) then
            do local _ = ZG.TELL("You notice that the cell door is now closed.", ZG._TK.CR) end
        end
        do return true end
    else
        do return false end
    end

end, "DIALBUTTON")

ZG.DIALBUTTON = ZG.actions:get("DIALBUTTON")

-- zil: 3actions.zil:1637  <ROUTINE CELL-ROOM (RARG)>
ZG.actions:register("CELL_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a featureless prison cell. You can see ") end
        if ZG._T(ZG.FSET_p(ZG.CELL_DOOR, "OPENBIT")) then
            do local _ = ZG.TELL("an east-west\ncorridor outside the cell door. Your view also takes in the parapet and\na large, fiery pit.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("through the small window\nin the closed door the parapet, and, behind that,\nsmoke and flames rising from a fiery pit.", ZG._TK.CR) end
        end
        if ZG._T(ZG.IN_p(ZG.DUNGEON_MASTER, ZG.PARAPET)) then
            do local _ = ZG.TELL("The dungeon master is at the parapet, leaning on his\nstaff. His keen gaze is fixed on you and he looks tense,\nas if waiting for something to happen.", ZG._TK.CR) end
        end
        if ZG.EQ(ZG.LCELL, 4) then
            do local _ = ZG.TELL("Behind you, to the south, is a bronze door which is ") end
            do local _ = ZG.DPR(ZG.BRONZE_DOOR) end
        end
        do return true end
    else
        do return false end
    end

end, "CELL-ROOM")

ZG.CELL_ROOM = ZG.actions:get("CELL_ROOM")

-- zil: 3actions.zil:1660  <ROUTINE NCELL-ROOM (RARG)>
ZG.actions:register("NCELL_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a bare prison cell. Its wooden door is securely fastened,\nand you can see only flames and smoke through its small window. On the\nsouth wall is a bronze door which seems to be ") end
        do return ZG.DPR(ZG.BRONZE_DOOR) end
    else
        do return false end
    end

end, "NCELL-ROOM")

ZG.NCELL_ROOM = ZG.actions:get("NCELL_ROOM")

-- zil: 3actions.zil:1668  <ROUTINE DPR (OBJ)>
ZG.actions:register("DPR", function(OBJ)

    if ZG._T(ZG.FSET_p(OBJ, "OPENBIT")) then
        do return ZG.TELL("open.", ZG._TK.CR) end
    else
        do return ZG.TELL("closed.", ZG._TK.CR) end
    end

end, "DPR")

ZG.DPR = ZG.actions:get("DPR")

-- zil: 3actions.zil:1672  <ROUTINE NORTH-CORRIDOR-F (RARG)>
ZG.actions:register("NORTH_CORRIDOR_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a wide east-west corridor which opens onto a northern\nparapet at its center. You can see flames and smoke as you peer\ntowards the parapet. The corridor turns south at either end, and in\nthe center of the south wall is a heavy wooden door with a small\nbarred window. The door is ") end
        do return ZG.DPR(ZG.CELL_DOOR) end
    else
        do return false end
    end

end, "NORTH-CORRIDOR-F")

ZG.NORTH_CORRIDOR_F = ZG.actions:get("NORTH_CORRIDOR_F")

-- zil: 3actions.zil:1682  <ROUTINE SOUTH-CORRIDOR-F (RARG)>
ZG.actions:register("SOUTH_CORRIDOR_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in an east-west corridor which turns north at its eastern\nand western ends. The walls are made of the finest marble. Another\nhall leads south at the center of the corridor.", ZG._TK.CR) end
        if ZG.EQ(ZG.LCELL, 4) then
            do local _ = ZG.TELL("In the center of the north wall is a bronze door which is ") end
            do local _ = ZG.DPR(ZG.BRONZE_DOOR) end
        end
        do return true end
    else
        do return false end
    end

end, "SOUTH-CORRIDOR-F")

ZG.SOUTH_CORRIDOR_F = ZG.actions:get("SOUTH_CORRIDOR_F")

-- zil: 3actions.zil:1694  <GLOBAL BRONZE-DOOR-LOCKED>
-- BRONZE_DOOR_LOCKED is declared in ZilGlobal.lua

-- zil: 3actions.zil:1696  <ROUTINE BRONZE-DOOR-F ()>
ZG.actions:register("BRONZE_DOOR_F", function()

    if (ZG._T(ZG.VERB_p("OPEN")) and (not ZG._T(ZG.FSET_p(ZG.BRONZE_DOOR, "OPENBIT"))) and ZG.EQ(ZG.HERE, ZG.GOOD_CELL) and (not ZG._T(ZG.BRONZE_DOOR_LOCKED))) then
        do local _ = ZG.TELL("On the other side of the bronze door is a narrow passage which opens out\ninto a larger area.", ZG._TK.CR) end
        do return ZG.FSET(ZG.BRONZE_DOOR, "OPENBIT") end
    elseif (ZG._T(ZG.VERB_p("OPEN")) and ZG._T(ZG.BRONZE_DOOR_LOCKED)) then
        do return ZG.TELL("The bronze door is locked.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BRONZE-DOOR-F")

ZG.BRONZE_DOOR_F = ZG.actions:get("BRONZE_DOOR_F")

-- zil: 3actions.zil:1709  <ROUTINE LOCKED-DOOR-F ()>
ZG.actions:register("LOCKED_DOOR_F", function()

    if ZG._T(ZG.VERB_p("OPEN", "UNLOCK")) then
        do return ZG.TELL("The door is securely fastened.", ZG._TK.CR) end
    else
        do return false end
    end

end, "LOCKED-DOOR-F")

ZG.LOCKED_DOOR_F = ZG.actions:get("LOCKED_DOOR_F")

-- zil: 3actions.zil:1717  <ROUTINE NIRVANA-F (RARG)>
ZG.actions:register("NIRVANA_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_END) then
        do local _ = ZG.TELL("As you examine your new-found riches, the Dungeon Master\nmaterializes beside you, and says, \"Now that you have solved all the\nmysteries of the Dungeon, it is time for you to assume your rightly earned\nplace in the scheme of things. Long have I waited for one capable of\nreleasing me from my burden!\" He taps you lightly on the head with his\nstaff, mumbling a few well-chosen spells, and you feel yourself changing,\ngrowing older and more stooped. For a moment there are two identical mages\nstanding among the treasure, then your counterpart dissolves into a\nmist and disappears, a sardonic grin on his face.\n\nFor a moment you are relieved, safe in the knowledge that you have\nat last completed your quest in ZORK. You begin to feel the vast powers\nand lore at your command and thirst for an opportunity to use them.\n\n") end
        do return ZG.FINISH() end
    else
        do return false end
    end

end, "NIRVANA-F")

ZG.NIRVANA_F = ZG.actions:get("NIRVANA_F")

-- zil: 3actions.zil:1737  <ROUTINE BRONZE-DOOR-EXIT ()>
ZG.actions:register("BRONZE_DOOR_EXIT", function()

    if ZG._T(ZG.FSET_p(ZG.BRONZE_DOOR, "INVISIBLE")) then
        do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
        do return false end
    elseif ZG._T(ZG.FSET_p(ZG.BRONZE_DOOR, "OPENBIT")) then
        do return ZG.CELL end
    else
        do local _ = ZG.TELL("The bronze door is closed.", ZG._TK.CR) end
        do return false end
    end

end, "BRONZE-DOOR-EXIT")

ZG.BRONZE_DOOR_EXIT = ZG.actions:get("BRONZE_DOOR_EXIT")

-- ;<ROUTINE MASTER-F ()
-- 	 <PERFORM ,PRSA ,DUNGEON-MASTER>
-- 	 <RTRUE>>

-- zil: 3actions.zil:1751  <GLOBAL OLD-MAN-GONE>
-- OLD_MAN_GONE is declared in ZilGlobal.lua

-- zil: 3actions.zil:1752  <GLOBAL OLD-MAN-FED>
-- OLD_MAN_FED is declared in ZilGlobal.lua

-- zil: 3actions.zil:1754  <GLOBAL SECRET-DOOR-DESC>
-- SECRET_DOOR_DESC is declared in ZilGlobal.lua

-- zil: 3actions.zil:1758  <ROUTINE SECRET-DOOR-F ()>
ZG.actions:register("SECRET_DOOR_F", function()

    if (ZG._T(ZG.VERB_p("OPEN")) and (not ZG._T(ZG.FSET_p(ZG.SECRET_DOOR, "OPENBIT")))) then
        do local _ = ZG.TELL("The massive stone door opens noiselessly. ", ZG.SECRET_DOOR_DESC, ZG._TK.CR) end
        do return ZG.FSET(ZG.SECRET_DOOR, "OPENBIT") end
    else
        do return false end
    end

end, "SECRET-DOOR-F")

ZG.SECRET_DOOR_F = ZG.actions:get("SECRET_DOOR_F")

-- zil: 3actions.zil:1764  <ROUTINE MSTAIRS-F (RARG)>
ZG.actions:register("MSTAIRS_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_ENTER) and ZG._T(ZG.PROB(30)) and (not ZG._T(ZG.OLD_MAN_FED)) and (not ZG._T(ZG.OLD_MAN_GONE))) then
        do return ZG.MOVE(ZG.OLD_MAN, ZG.HERE) end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a room with passages heading southwest and southeast. The\nnorth wall is ornately carved, filled with strange runes and writing in\nan unfamiliar language.", ZG._TK.CR) end
        if ZG._T(ZG.FSET_p(ZG.SECRET_DOOR, "OPENBIT")) then
            do return ZG.TELL(ZG.SECRET_DOOR_DESC, ZG._TK.CR) end
        elseif (not ZG._T(ZG.FSET_p(ZG.SECRET_DOOR, "INVISIBLE"))) then
            do return ZG.TELL("The outline of a door is barely visible among the runes.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "MSTAIRS-F")

ZG.MSTAIRS_F = ZG.actions:get("MSTAIRS_F")

-- zil: 3actions.zil:1781  <ROUTINE HELLO? (WHO)>
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

-- zil: 3actions.zil:1789  <ROUTINE OLD-MAN-F ("OPTIONAL" (RARG <>))>
ZG.actions:register("OLD_MAN_F", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_OBJDESC) then
        if ZG._T(ZG.OLD_MAN_AWAKE) then
            do return ZG.TELL("There is an old man huddled in the corner, eyeing you cautiously.\nHe looks weak and tired.", ZG._TK.CR) end
        else
            do return ZG.TELL("An old and wizened man is huddled, asleep, in the corner. He is snoring\nloudly, and looks quite weak and frail.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.OLD_MAN)) then
        if ZG._T(ZG.OLD_MAN_AWAKE) then
            if ZG.EQ(ZG.PRSO, ZG.WAYBREAD) then
                do local _ = ZG.REMOVE(ZG.WAYBREAD) end
                do local _ = ZG.TELL("He looks up at you and takes the waybread. Slowly, he eats the\nbread and pauses when he is finished. He starts to speak: \"Perhaps what you\nseek is through there!\" He points at the carved wall to the north, where you\nnow notice the bare outline of a secret door. When you turn back, the old\nman is gone!", ZG._TK.CR) end
                do local _ = ZG.FCLEAR(ZG.SECRET_DOOR, "INVISIBLE") end
                ZG._set("OLD_MAN_GONE", true)
                do return ZG.REMOVE(ZG.OLD_MAN) end
            elseif ZG._T(ZG.IN_p(ZG.WAYBREAD, ZG.WINNER)) then
                do return ZG.TELL("He refuses your offer but motions with his arm to the waybread in your\nhand.", ZG._TK.CR) end
            else
                do return ZG.TELL("The old man refuses the ", ZG._TK.D, ZG.PRSO, " with a wave of his hand.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("He is asleep!", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG._T(ZG.OLD_MAN_AWAKE) then
            do return ZG.TELL("The old man is barely awake and appears to nod off every few moments.\nHe has bright eyes, which appear to see right through your body.", ZG._TK.CR) end
        else
            do return ZG.TELL("The man is very, very old and wizened. He has a long, stringy\nbeard and is snoring quite loudly.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LISTEN")) then
        if ZG._T(ZG.OLD_MAN_AWAKE) then
            do return ZG.TELL("He isn't talking.", ZG._TK.CR) end
        else
            do return ZG.TELL("He is snoring like a buzz saw.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.HELLO_p(ZG.OLD_MAN)) then
        if ZG._T(ZG.OLD_MAN_AWAKE) then
            do return ZG.TELL("He nods at you without seeming to have understood.", ZG._TK.CR) end
        else
            do return ZG.TELL("He is sleeping soundly and does not respond.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("SHAKE", "ALARM")) then
        do local _ = ZG.TELL("The old man is roused to consciousness. He peers at you through eyes which\nappear much younger and stronger than his frail body and waits, as if expecting\nsomething to happen.", ZG._TK.CR) end
        ZG._set("OLD_MAN_AWAKE", true)
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_OLD_MAN_SLEEPS, 3)) end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        do local _ = ZG.TELL("The attack seems to have left the old man unharmed! You watch in awe as he\nrises to his feet and seems to tower above you. He peers down menacingly,\nthen sadly and wearily. \"Not yet,\" he mourns, and vanishes in a puff of\nsmoke.", ZG._TK.CR) end
        ZG._set("OLD_MAN_GONE", true)
        do return ZG.REMOVE(ZG.OLD_MAN) end
    else
        do return false end
    end

end, "OLD-MAN-F")

ZG.OLD_MAN_F = ZG.actions:get("OLD_MAN_F")

-- zil: 3actions.zil:1857  <GLOBAL OLD-MAN-AWAKE>
-- OLD_MAN_AWAKE is declared in ZilGlobal.lua

-- zil: 3actions.zil:1859  <ROUTINE I-OLD-MAN-SLEEPS ()>
ZG.actions:register("I_OLD_MAN_SLEEPS", function()

    ZG._set("OLD_MAN_AWAKE", false)
    if ZG._T(ZG.IN_p(ZG.OLD_MAN, ZG.HERE)) then
        do return ZG.TELL("You notice that the old man has fallen asleep.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-OLD-MAN-SLEEPS")

ZG.I_OLD_MAN_SLEEPS = ZG.actions:get("I_OLD_MAN_SLEEPS")

-- zil: 3actions.zil:1864  <ROUTINE RUNES-F ()>
ZG.actions:register("RUNES_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        do return ZG.TELL("The runes are in an ancient language. Some pictures among the runes depict\nflames, stone statues, and an old man.", ZG._TK.CR) end
    else
        do return false end
    end

end, "RUNES-F")

ZG.RUNES_F = ZG.actions:get("RUNES_F")

-- zil: 3actions.zil:1870  <ROUTINE T-BAR-F ()>
ZG.actions:register("T_BAR_F", function()

    if ZG._T(ZG.VERB_p("TURN")) then
        do return ZG.TELL("You don't have enough leverage to turn the T-bar. You might be able\nto turn the whole structure, however.", ZG._TK.CR) end
    else
        do return false end
    end

end, "T-BAR-F")

ZG.T_BAR_F = ZG.actions:get("T_BAR_F")

-- zil: 3actions.zil:1876  <ROUTINE FLAMING-PIT-F ()>
ZG.actions:register("FLAMING_PIT_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The flaming pit is a seemingly bottomless abyss filled with smoke and\nflame.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.FLAMING_PIT)) then
        if ZG.EQUAL_p(ZG.HERE, ZG.PARAPET, ZG.NORTH_CORRIDOR) then
            if ZG.EQ(ZG.PRSO, ZG.ME) then
                do return ZG.TELL("It would be a pity to end your life so near the end of your quest!", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("You cast the ", ZG._TK.D, ZG.PRSO, " into the pit, where it is lost forever.", ZG._TK.CR) end
                do return ZG.REMOVE(ZG.PRSO) end
            end
        else
            do return ZG.TELL("You're not close enough.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "FLAMING-PIT-F")

ZG.FLAMING_PIT_F = ZG.actions:get("FLAMING_PIT_F")

-- zil: 3actions.zil:1892  <ROUTINE PARAPET-OBJ-F ()>
ZG.actions:register("PARAPET_OBJ_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG.EQUAL_p(ZG.HERE, ZG.CELL, ZG.NORTH_CORRIDOR) then
            do local _ = ZG.TELL("You can see the parapet and sundial from here.") end
            if ZG._T(ZG.IN_p(ZG.DUNGEON_MASTER, ZG.PARAPET)) then
                do local _ = ZG.TELL(" The dungeon master is there\nalso, leaning on his staff.") end
            end
            do return ZG.CRLF() end
        else
            do return ZG.V_LOOK() end
        end
    else
        do return false end
    end

end, "PARAPET-OBJ-F")

ZG.PARAPET_OBJ_F = ZG.actions:get("PARAPET_OBJ_F")

-- zil: 3actions.zil:1903  <ROUTINE ROSE-F ()>
ZG.actions:register("ROSE_F", function()

    if ZG._T(ZG.VERB_p("TURN", "MOVE")) then
        do return ZG.TELL("The compass rose is made of stone and is imbedded in the ground.\nYou could not possibly turn it or move it.", ZG._TK.CR) end
    else
        do return false end
    end

end, "ROSE-F")

ZG.ROSE_F = ZG.actions:get("ROSE_F")

-- zil: 3actions.zil:1909  <ROUTINE CELL-DOOR-F ()>
ZG.actions:register("CELL_DOOR_F", function()

    if (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.CELL_DOOR)) then
        do return ZG.TELL("You will have to enter the cell first.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        if ZG.EQ(ZG.HERE, ZG.CELL) then
            do return ZG.TELL("Look around.", ZG._TK.CR) end
        else
            do local _ = ZG.DO_WALK("SOUTH") end
            do return true end
        end
    else
        do return false end
    end

end, "CELL-DOOR-F")

ZG.CELL_DOOR_F = ZG.actions:get("CELL_DOOR_F")

-- zil: 3actions.zil:1919  <ROUTINE LORE-BOOK-F ()>
ZG.actions:register("LORE_BOOK_F", function()

    if (ZG._T(ZG.VERB_p("BURN")) and (not ZG._T(ZG.IN_p(ZG.LORE_BOOK, ZG.WINNER)))) then
        do local _ = ZG.TELL("The book is consumed in a dazzling display of color.", ZG._TK.CR) end
        do local _ = ZG.REMOVE(ZG.PRSO) end
        do return true end
    elseif (ZG._T(ZG.IN_DUNGEON) and ZG._T(ZG.VERB_p("OPEN", "EXAMINE", "READ"))) then
        do return ZG.TELL("The book seems to will itself open to a specific page. It shows a picture of\neight small rooms located around a great circle of flame. All are identical\nsave one, which has a bronze door leading to a room bathed in golden light.\nA legend beneath the picture says \"The Dungeon and Treasury of Zork.\"", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The book can be perused but not left open.", ZG._TK.CR) end
    else
        do return false end
    end

end, "LORE-BOOK-F")

ZG.LORE_BOOK_F = ZG.actions:get("LORE_BOOK_F")

-- zil: 3actions.zil:1935  <ROUTINE CP-HOLE-F ()>
ZG.actions:register("CP_HOLE_F", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do local _ = ZG.DO_WALK("DOWN") end
        do return true end
    else
        do return false end
    end

end, "CP-HOLE-F")

ZG.CP_HOLE_F = ZG.actions:get("CP_HOLE_F")

-- zil: 3actions.zil:1940  <ROUTINE TORCH-PSEUDO ()>
ZG.actions:register("TORCH_PSEUDO", function()

    do return ZG.TELL("The torches are out of reach.", ZG._TK.CR) end

end, "TORCH-PSEUDO")

ZG.TORCH_PSEUDO = ZG.actions:get("TORCH_PSEUDO")

-- zil: 3actions.zil:1943  <ROUTINE WATER-FCN ("AUX" AV PI?)>
ZG.actions:register("WATER_FCN", function()

    local AV = 0
    local PI_p = 0
    if ZG._T(ZG.VERB_p("SGIVE")) then
        do return false end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?SWIM"), ZG.PRSO) end
        do return true end
    elseif ZG._T(ZG.VERB_p("FILL")) then
        ZG._set("PRSA", ZG.SYMBOL("V?PUT"))
        ZG._set("PRSI", ZG.PRSO)
        ZG._set("PRSO", ZG.GLOBAL_WATER)
        PI_p = false
    elseif ZG.EQ(ZG.PRSO, ZG.GLOBAL_WATER) then
        PI_p = false
    elseif ZG._T(ZG.PRSI) then
        PI_p = true
    end
    if ZG._T(PI_p) then
        ZG._set("PRSI", ZG.GLOBAL_WATER)
    else
        ZG._set("PRSO", ZG.GLOBAL_WATER)
    end
    if (ZG._T(ZG.VERB_p("TAKE", "PUT")) and (not ZG._T(PI_p))) then
        do return ZG.TELL("The water slips through your fingers.", ZG._TK.CR) end
    elseif ZG._T(PI_p) then
        do return ZG.TELL("You can't do that.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DROP", "GIVE", "THROW")) then
        do return ZG.TELL("You don't have any water.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WATER-FCN")

ZG.WATER_FCN = ZG.actions:get("WATER_FCN")

-- zil: 3actions.zil:1966  <ROUTINE RANDOM-WALL ()>
ZG.actions:register("RANDOM_WALL", function()

    if ZG._T(ZG.VERB_p("PUSH")) then
        if ZG.EQ(ZG.HERE, ZG.IN_MIRROR) then
            do return ZG.TELL("You should specify which panel you want to push.", ZG._TK.CR) end
        else
            do return ZG.TELL("You can't budge it; at least from here.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "RANDOM-WALL")

ZG.RANDOM_WALL = ZG.actions:get("RANDOM_WALL")

-- ;"special-cased routines"

-- ;"put GO here, eventually"

-- zil: 3actions.zil:1980  <ROUTINE V-DIAGNOSE ()>
ZG.actions:register("V_DIAGNOSE", function()

    do return ZG.TELL(ZG.GET(ZG.DIAG, ZG.P_STRENGTH), ZG._TK.CR) end

end, "V-DIAGNOSE")

ZG.V_DIAGNOSE = ZG.actions:get("V_DIAGNOSE")

-- zil: 3actions.zil:1983  <GLOBAL DIAG>
-- DIAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:1991  <ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))>
ZG.actions:register("JIGS_UP", function(DESC, PLAYER_p)

    if PLAYER_p == nil then PLAYER_p = false end
    ZG._set("SWORD_STATE", 0)
    ZG._set("P_STRENGTH", 5)
    ZG._set("S_STRENGTH", 5)
    do local _ = ZG.TELL(DESC, ZG._TK.CR) end
    if (not ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT)) then
        do local _ = ZG.QUIT() end
    end
    if (not ZG.EQ(ZG.ADVENTURER, ZG.WINNER)) then
        do local _ = ZG.TELL("\n\n    ****  The ", ZG._TK.D, ZG.WINNER, " has died  ****\n\n\n") end
        do local _ = ZG.REMOVE(ZG.WINNER) end
        ZG._set("WINNER", ZG.ADVENTURER)
        ZG._set("HERE", ZG.LOC(ZG.WINNER))
        do return 2 end
    end
    do local _ = ZG.TELL("\n    ****  You have died  ****\n\n") end
    if ZG.LT(3, ZG._set("DEATHS", ZG.ADD(ZG.DEATHS, 1))) then
        do local _ = ZG.TELL("You feel yourself disembodied in a deep blackness. A voice from the void\nspeaks:  \"I have waited a long age for you, my friend, but perhaps it has been\nanother that I have been seeking. Good night, oh worthy adventurer!\" It is\nthe last you hear.", ZG._TK.CR) end
        do local _ = ZG.QUIT() end
    else
        do local _ = ZG.TELL("You find yourself deep within the earth in a barren prison cell.\nOutside the iron-barred window, you can see a great, fiery pit. Flames\nleap up and very nearly sear your flesh. After a while, footfalls can\nbe heard in the distance, then closer and closer.... The door swings\nopen, and in walks an old man.\n\nHe is dressed simply in a hood and cloak, wearing an amulet and ring,\ncarrying an old book under one arm, and leaning on a wooden staff. A single\nkey, as if to a massive prison cell, hangs from his belt.\n\nHe raises the staff toward you and you hear\nhim speak, as if in a dream: \"I await you, though your journey be long\nand full of peril. Go then, and let me not wait long!\" You feel some\ngreat power well up inside you and you fall to the floor. The next\nmoment, you are awakening, as if from a deep slumber.", ZG._TK.CR) end
    end
    do local _ = ZG.MOVE(ZG.CURRENT_LAMP, ZG.ZORK2_STAIR) end
    if (ZG._T(ZG.IN_p(ZG.KEY, ZG.WINNER)) and (ZG.EQUAL_p(ZG.HERE, ZG.DARK_1, ZG.DARK_2, ZG.KEY_ROOM) or ZG.EQUAL_p(ZG.HERE, ZG.AQ_1, ZG.AQ_2))) then
        do local _ = ZG.MOVE(ZG.KEY, ZG.KEY_ROOM) end
    end
    do local _ = ZG.CRLF() end
    do local _ = ZG.GOTO(ZG.ZORK2_STAIR) end
    ZG._set("P_CONT", false)
    do local _ = ZG.RANDOMIZE_OBJECTS() end
    do local _ = ZG.KILL_INTERRUPTS() end
    do return 2 end

end, "JIGS-UP")

ZG.JIGS_UP = ZG.actions:get("JIGS_UP")

-- zil: 3actions.zil:2047  <ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)>
ZG.actions:register("RANDOMIZE_OBJECTS", function()

    local R = false
    local F = 0
    local N = 0
    local L = 0
    N = ZG.FIRST_p(ZG.WINNER)
    while true do
        F = N
        if (not ZG._T(F)) then
            do return true end
        end
        N = ZG.NEXT_p(F)
        do local _ = ZG.MOVE(F, ZG.RANDOM_ELEMENT(ZG.DEAD_OBJ_LOCS)) end
    end

end, "RANDOMIZE-OBJECTS")

ZG.RANDOMIZE_OBJECTS = ZG.actions:get("RANDOMIZE_OBJECTS")

-- zil: 3actions.zil:2055  <GLOBAL DEAD-OBJ-LOCS>
-- DEAD_OBJ_LOCS is declared in ZilGlobal.lua

-- zil: 3actions.zil:2059  <ROUTINE KILL-INTERRUPTS ()>
ZG.actions:register("KILL_INTERRUPTS", function()

    do local _ = ZG.DISABLE(ZG.INT(ZG.I_MAN_LEAVES)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_MAN_RETURNS)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_VIEW_SNAP)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_FOLIN)) end
    do return true end

end, "KILL-INTERRUPTS")

ZG.KILL_INTERRUPTS = ZG.actions:get("KILL_INTERRUPTS")

-- zil: 3actions.zil:2066  <GLOBAL SCORE-MAX>
-- SCORE_MAX is declared in ZilGlobal.lua

-- zil: 3actions.zil:2068  <ROUTINE V-SCORE ("OPTIONAL" (ASK? T))>
ZG.actions:register("V_SCORE", function(ASK_p)

    if ASK_p == nil then ASK_p = true end
    do local _ = ZG.TELL("Your potential is ", ZG._TK.N, ZG.SCORE) end
    do local _ = ZG.TELL(" of a possible ", ZG._TK.N, ZG.SCORE_MAX, ", in ") end
    do local _ = ZG.TELL(ZG._TK.N, ZG.MOVES) end
    if (ZG.MOVES == 1) then
        do local _ = ZG.TELL(" move.") end
    else
        do local _ = ZG.TELL(" moves.") end
    end
    do local _ = ZG.CRLF() end
    do return ZG.SCORE end

end, "V-SCORE")

ZG.V_SCORE = ZG.actions:get("V_SCORE")

-- zil: 3actions.zil:2083  <OBJECT VOICES>
ZG._declare("VOICES", function() return ZG._declare_object("VOICES", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["DESC"] = "voices",
    ["SYNONYM"] = {"VOICE", "VOICES", "GUARDS", "OFFICI"},
    ["ADJECTIVE"] = "ARMED",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.VOICES_F,
} end) end, true)

-- zil: 3actions.zil:2091  <ROOM TIGHT-SQUEEZE>
ZG._declare("TIGHT_SQUEEZE", function() return ZG._declare_object("TIGHT-SQUEEZE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Tight Squeeze",
    ["LDESC"] = "This is a very low and narrow passage leading east to west.",
    ["WEST"] = {"TO", ZG.CREEPY_CRAWL},
    ["EAST"] = {"TO", ZG.ROCKY_ROOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:2100  <ROOM ROCKY-ROOM>
ZG._declare("ROCKY_ROOM", function() return ZG._declare_object("ROCKY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Crystal Grotto",
    ["LDESC"] = "This is a chamber of breathtaking beauty. Mighty stalagmites form\ncrystalline-encrusted rock formations. Phosphorescent mosses, fed by\na trickle of water from above, make the crystals glow and sparkle with\nevery color of the rainbow. There is an opening to the west, and a\nman-made passage heads south.",
    ["SOUTH"] = {"TO", ZG.WIDE_HALL},
    ["WEST"] = {"TO", ZG.TIGHT_SQUEEZE},
    ["GLOBAL"] = {ZG.MOSS, ZG.CRYSTALS},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
} end) end, true)

-- zil: 3actions.zil:2114  <OBJECT CRYSTALS>
ZG._declare("CRYSTALS", function() return ZG._declare_object("CRYSTALS", function() return {
    ["LOC"] = ZG.ROCKY_ROOM,
    ["DESC"] = "rock structure",
    ["SYNONYM"] = {"CRYSTAL", "STALAG"},
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3actions.zil:2120  <ROOM WIDE-HALL>
ZG._declare("WIDE_HALL", function() return ZG._declare_object("WIDE-HALL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Royal Hall",
    ["LDESC"] = "This is the north end of a large hall with a vaulted ceiling. A long, tiled\nhallway leads north through a tall arch. Although the purpose of\nthis room is unclear, there is a large rendering of the Royal Seal of Lord\nDimwit Flathead carved on the wall.",
    ["NORTH"] = {"TO", ZG.ROCKY_ROOM},
    ["SOUTH"] = {"TO", ZG.MUSEUM_ANTE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:2132  <OBJECT ROYAL-SEAL>
ZG._declare("ROYAL_SEAL", function() return ZG._declare_object("ROYAL-SEAL", function() return {
    ["LOC"] = ZG.WIDE_HALL,
    ["DESC"] = "Royal Seal of Dimwit Flathead",
    ["SYNONYM"] = {"SEAL", "CARVIN", "RENDER"},
    ["ADJECTIVE"] = {"LARGE", "ROYAL"},
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["TEXT"] = "The Seal is vintage Flathead, with signs of excess nearly everywhere.\nIt shows a curiously flat-headed figure wearing a gaudy crown,\nsurrounded by the Crown Jewels of the Empire.",
} end) end, true)

-- zil: 3actions.zil:2143  <ROOM MUSEUM-ANTE>
ZG._declare("MUSEUM_ANTE", function() return ZG._declare_object("MUSEUM-ANTE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Great Door",
    ["NORTH"] = {"TO", ZG.WIDE_HALL},
    ["EAST"] = {"TO", ZG.MUSEUM_ENTRANCE, "IF", "CLEFT_FLAG", "ELSE", "The great iron door is rusted shut."},
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.MUSEUM_ANTE_F,
    ["GLOBAL"] = {ZG.IRON_DOOR, ZG.CLEFT},
} end) end, true)

-- zil: 3actions.zil:2153  <ROOM MUSEUM-ENTRANCE>
ZG._declare("MUSEUM_ENTRANCE", function() return ZG._declare_object("MUSEUM-ENTRANCE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Museum Entrance",
    ["EAST"] = {"TO", ZG.JEWEL_ROOM, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["WEST"] = {"TO", ZG.MUSEUM_ANTE, "IF", "CLEFT_FLAG", "ELSE", "The iron door is rusted shut."},
    ["SOUTH"] = {"TO", ZG.CP_ANTE},
    ["DOWN"] = {"TO", ZG.CP_ANTE},
    ["NORTH"] = {"TO", ZG.TECH_MUSEUM, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.MUSEUM_ENTRANCE_F,
    ["GLOBAL"] = {ZG.IRON_DOOR, ZG.JEWEL_DOOR, ZG.WOODEN_DOOR, ZG.STAIRS, ZG.CLEFT},
} end) end, true)

-- zil: 3actions.zil:2165  <OBJECT CLEFT>
ZG._declare("CLEFT", function() return ZG._declare_object("CLEFT", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "cleft",
    ["SYNONYM"] = "CLEFT",
    ["ACTION"] = ZG.CLEFT_F,
    ["FLAGS"] = {"DOORBIT", "OPENBIT", "INVISIBLE"},
} end) end, true)

-- zil: 3actions.zil:2172  <ROOM JEWEL-ROOM>
ZG._declare("JEWEL_ROOM", function() return ZG._declare_object("JEWEL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Jewel Room",
    ["WEST"] = {"TO", ZG.MUSEUM_ENTRANCE, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.MUSEUM_ENTRANCE, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.JEWEL_ROOM_F,
    ["GLOBAL"] = ZG.JEWEL_DOOR,
} end) end, true)

-- zil: 3actions.zil:2181  <ROOM TECH-MUSEUM>
ZG._declare("TECH_MUSEUM", function() return ZG._declare_object("TECH-MUSEUM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Technology Museum",
    ["SOUTH"] = {"TO", ZG.MUSEUM_ENTRANCE, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.MUSEUM_ENTRANCE, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.TECH_MUSEUM_F,
    ["GLOBAL"] = ZG.WOODEN_DOOR,
} end) end, true)

-- zil: 3actions.zil:2190  <ROOM MID-CP-ANTE>
ZG._declare("MID_CP_ANTE", function() return ZG._declare_object("MID-CP-ANTE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Royal Puzzle Entrance",
    ["WEST"] = {"TO", ZG.MID_CP_OUT},
    ["NORTH"] = {"TO", ZG.MID_MUSEUM_ENTRANCE},
    ["UP"] = {"TO", ZG.MID_MUSEUM_ENTRANCE},
    ["DOWN"] = {"PER", ZG.CPENTER},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.CPANT_ROOM,
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 3actions.zil:2201  <ROOM MID-CP-OUT>
ZG._declare("MID_CP_OUT", function() return ZG._declare_object("MID-CP-OUT", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Side Room",
    ["NORTH"] = {"TO", ZG.MID_CP_ANTE},
    ["EAST"] = "The steel door is closed.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.CPOUT_ROOM,
    ["GLOBAL"] = {ZG.CPDOOR, ZG.STAIRS},
} end) end, true)

-- zil: 3actions.zil:2210  <ROOM MID-MUSEUM-ENTRANCE>
ZG._declare("MID_MUSEUM_ENTRANCE", function() return ZG._declare_object("MID-MUSEUM-ENTRANCE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Museum Entrance",
    ["EAST"] = {"TO", ZG.MID_JEWEL_ROOM, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["WEST"] = "The iron door is rusted shut.",
    ["SOUTH"] = {"TO", ZG.MID_CP_ANTE},
    ["DOWN"] = {"TO", ZG.MID_CP_ANTE},
    ["NORTH"] = {"TO", ZG.MID_TECH_MUSEUM, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.MUSEUM_ENTRANCE_F,
    ["GLOBAL"] = {ZG.IRON_DOOR, ZG.JEWEL_DOOR, ZG.WOODEN_DOOR, ZG.STAIRS},
} end) end, true)

-- zil: 3actions.zil:2222  <ROOM MID-JEWEL-ROOM>
ZG._declare("MID_JEWEL_ROOM", function() return ZG._declare_object("MID-JEWEL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Jewel Room",
    ["WEST"] = {"TO", ZG.MID_MUSEUM_ENTRANCE, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.MID_MUSEUM_ENTRANCE, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.JEWEL_ROOM_F,
    ["GLOBAL"] = ZG.JEWEL_DOOR,
} end) end, true)

-- zil: 3actions.zil:2231  <ROOM MID-TECH-MUSEUM>
ZG._declare("MID_TECH_MUSEUM", function() return ZG._declare_object("MID-TECH-MUSEUM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Technology Museum",
    ["SOUTH"] = {"TO", ZG.MID_MUSEUM_ENTRANCE, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.MID_MUSEUM_ENTRANCE, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.TECH_MUSEUM_F,
    ["GLOBAL"] = ZG.WOODEN_DOOR,
} end) end, true)

-- zil: 3actions.zil:2240  <ROOM OLD-TECH-MUSEUM>
ZG._declare("OLD_TECH_MUSEUM", function() return ZG._declare_object("OLD-TECH-MUSEUM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Technology Museum",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.OLD_TECH_MUSEUM_F,
    ["SOUTH"] = {"TO", ZG.OLD_MUSEUM_ENTRANCE, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.OLD_MUSEUM_ENTRANCE, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["GLOBAL"] = {ZG.WOODEN_DOOR, ZG.ROBOT},
} end) end, true)

-- zil: 3actions.zil:2249  <ROOM OLD-JEWEL-ROOM>
ZG._declare("OLD_JEWEL_ROOM", function() return ZG._declare_object("OLD-JEWEL-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Jewel Room",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.OLD_TECH_MUSEUM_F,
    ["WEST"] = {"TO", ZG.OLD_MUSEUM_ENTRANCE, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["OUT"] = {"TO", ZG.OLD_MUSEUM_ENTRANCE, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["GLOBAL"] = {ZG.JEWEL_DOOR, ZG.ROBOT},
} end) end, true)

-- zil: 3actions.zil:2258  <ROOM OLD-MUSEUM-ENTRANCE>
ZG._declare("OLD_MUSEUM_ENTRANCE", function() return ZG._declare_object("OLD-MUSEUM-ENTRANCE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Museum Entrance",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.OLD_TECH_MUSEUM_F,
    ["EAST"] = {"TO", ZG.OLD_JEWEL_ROOM, "IF", "JEWEL_DOOR", "IS", "OPEN"},
    ["WEST"] = "The guards locked the iron door behind them.",
    ["NORTH"] = {"TO", ZG.OLD_TECH_MUSEUM, "IF", "WOODEN_DOOR", "IS", "OPEN"},
    ["SOUTH"] = "The stairs end blindly to the south.",
    ["GLOBAL"] = {ZG.WOODEN_DOOR, ZG.JEWEL_DOOR, ZG.IRON_DOOR, ZG.ROBOT},
} end) end, true)

-- zil: 3actions.zil:2269  <OBJECT TIME-MACHINE>
ZG._declare("TIME_MACHINE", function() return ZG._declare_object("TIME-MACHINE", function() return {
    ["LOC"] = ZG.TECH_MUSEUM,
    ["DESC"] = "gold machine",
    ["SYNONYM"] = {"MACHINE", "TEMPORIZER"},
    ["ADJECTIVE"] = {"TIME", "GOLD", "GOLDEN"},
    ["FLAGS"] = {"VEHBIT", "OPENBIT", "CONTBIT"},
    ["CAPACITY"] = 100,
    ["DESCFCN"] = ZG.TIME_MACHINE_F,
    ["ACTION"] = ZG.TIME_MACHINE_F,
} end) end, true)

-- zil: 3actions.zil:2279  <OBJECT PRESSURIZER>
ZG._declare("PRESSURIZER", function() return ZG._declare_object("PRESSURIZER", function() return {
    ["LOC"] = ZG.TECH_MUSEUM,
    ["DESC"] = "grey machine",
    ["SYNONYM"] = {"MACHINE", "DRYER", "PRESSURIZER"},
    ["ADJECTIVE"] = {"GRAY", "GREY", "WASHING"},
    ["ACTION"] = ZG.MUSEUM_PIECES,
    ["DESCFCN"] = ZG.MUSEUM_PIECES,
} end) end, true)

-- zil: 3actions.zil:2287  <OBJECT SPINNER>
ZG._declare("SPINNER", function() return ZG._declare_object("SPINNER", function() return {
    ["LOC"] = ZG.TECH_MUSEUM,
    ["DESC"] = "black machine",
    ["SYNONYM"] = {"MACHINE", "PIPES", "WIRES", "MOTORS"},
    ["ADJECTIVE"] = "BLACK",
    ["DESCFCN"] = ZG.MUSEUM_PIECES,
    ["ACTION"] = ZG.MUSEUM_PIECES,
} end) end, true)

-- zil: 3actions.zil:2295  <OBJECT TM-BUTTON>
ZG._declare("TM_BUTTON", function() return ZG._declare_object("TM-BUTTON", function() return {
    ["LOC"] = ZG.TIME_MACHINE,
    ["DESC"] = "button",
    ["SYNONYM"] = "BUTTON",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.TM_BUTTON_F,
} end) end, true)

-- zil: 3actions.zil:2302  <OBJECT TM-HOLLOW>
ZG._declare("TM_HOLLOW", function() return ZG._declare_object("TM-HOLLOW", function() return {
    ["LOC"] = ZG.TIME_MACHINE,
    ["DESC"] = "seat",
    ["SYNONYM"] = "AREA",
    ["ADJECTIVE"] = {"SMALL", "HOLLOW"},
    ["FLAGS"] = {"NDESCBIT", "OPENBIT", "CONTBIT"},
    ["CAPACITY"] = 20,
    ["ACTION"] = ZG.TM_HOLLOW_F,
} end) end, true)

-- zil: 3actions.zil:2311  <ROUTINE TM-HOLLOW-F ()>
ZG.actions:register("TM_HOLLOW_F", function()

    if (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.TM_HOLLOW)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?PUT-UNDER"), ZG.PRSO, ZG.TM_SEAT) end
        do return true end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?LOOK-UNDER"), ZG.TM_SEAT) end
        do return true end
    elseif ZG.EQ(ZG.PRSO, ZG.TM_HOLLOW) then
        do local _ = ZG.PERFORM(ZG.PRSA, ZG.TM_SEAT, ZG.PRSI) end
        do return true end
    elseif ZG.EQ(ZG.PRSI, ZG.TM_HOLLOW) then
        do local _ = ZG.PERFORM(ZG.PRSA, ZG.PRSO, ZG.TM_SEAT) end
        do return true end
    else
        do return false end
    end

end, "TM-HOLLOW-F")

ZG.TM_HOLLOW_F = ZG.actions:get("TM_HOLLOW_F")

-- zil: 3actions.zil:2326  <OBJECT TM-SEAT>
ZG._declare("TM_SEAT", function() return ZG._declare_object("TM-SEAT", function() return {
    ["LOC"] = ZG.TIME_MACHINE,
    ["DESC"] = "seat",
    ["SYNONYM"] = {"SEAT", "CHAIR"},
    ["FLAGS"] = {"NDESCBIT", "OPENBIT", "CONTBIT", "SURFACEBIT"},
    ["CAPACITY"] = 20,
    ["ACTION"] = ZG.TM_SEAT_F,
} end) end, true)

-- zil: 3actions.zil:2334  <OBJECT TM-DIAL>
ZG._declare("TM_DIAL", function() return ZG._declare_object("TM-DIAL", function() return {
    ["LOC"] = ZG.TIME_MACHINE,
    ["DESC"] = "dial",
    ["SYNONYM"] = {"DIAL", "CONSOLE", "DISPLAY"},
    ["FLAGS"] = {"NDESCBIT", "TURNBIT"},
    ["ACTION"] = ZG.TM_DIAL_F,
} end) end, true)

-- zil: 3actions.zil:2341  <OBJECT IRON-DOOR>
ZG._declare("IRON_DOOR", function() return ZG._declare_object("IRON-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "iron door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = "IRON",
    ["FLAGS"] = {"DOORBIT", "CONTBIT"},
    ["ACTION"] = ZG.IRON_DOOR_F,
} end) end, true)

-- zil: 3actions.zil:2349  <OBJECT JEWEL-DOOR>
ZG._declare("JEWEL_DOOR", function() return ZG._declare_object("JEWEL-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "stone door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"STONE", "EAST"},
    ["ACTION"] = ZG.JEWEL_DOOR_F,
    ["FLAGS"] = {"DOORBIT", "CONTBIT"},
} end) end, true)

-- zil: 3actions.zil:2357  <OBJECT WOODEN-DOOR>
ZG._declare("WOODEN_DOOR", function() return ZG._declare_object("WOODEN-DOOR", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "wooden door",
    ["SYNONYM"] = "DOOR",
    ["ADJECTIVE"] = {"WOODEN", "WOOD", "NORTH"},
    ["FLAGS"] = {"DOORBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.WOODEN_DOOR_F,
} end) end, true)

-- zil: 3actions.zil:2365  <OBJECT SCEPTRE>
ZG._declare("SCEPTRE", function() return ZG._declare_object("SCEPTRE", function() return {
    ["LOC"] = ZG.PEDESTAL,
    ["DESC"] = "sceptre",
    ["SYNONYM"] = {"SCEPTRE", "JEWELS"},
    ["ADJECTIVE"] = "CROWN",
    ["FLAGS"] = {"TAKEBIT", "NDESCBIT", "TRYTAKEBIT"},
    ["SIZE"] = 30,
    ["ACTION"] = ZG.CROWN_JEWELS_F,
} end) end, true)

-- zil: 3actions.zil:2374  <OBJECT JEWELLED-KNIFE>
ZG._declare("JEWELLED_KNIFE", function() return ZG._declare_object("JEWELLED-KNIFE", function() return {
    ["LOC"] = ZG.PEDESTAL,
    ["DESC"] = "jewelled knife",
    ["SYNONYM"] = {"KNIFE", "JEWELS"},
    ["ADJECTIVE"] = {"JEWELLED", "CROWN"},
    ["FLAGS"] = {"TAKEBIT", "NDESCBIT", "TRYTAKEBIT"},
    ["SIZE"] = 20,
    ["ACTION"] = ZG.CROWN_JEWELS_F,
} end) end, true)

-- zil: 3actions.zil:2383  <OBJECT RING>
ZG._declare("RING", function() return ZG._declare_object("RING", function() return {
    ["LOC"] = ZG.PEDESTAL,
    ["DESC"] = "golden ring",
    ["SYNONYM"] = {"RING", "JEWELS"},
    ["ADJECTIVE"] = {"GOLDEN", "CROWN"},
    ["FLAGS"] = {"TAKEBIT", "NDESCBIT", "TRYTAKEBIT", "WEARBIT"},
    ["SIZE"] = 5,
    ["ACTION"] = ZG.CROWN_JEWELS_F,
} end) end, true)

-- zil: 3actions.zil:2392  <OBJECT PEDESTAL>
ZG._declare("PEDESTAL", function() return ZG._declare_object("PEDESTAL", function() return {
    ["LOC"] = ZG.JEWEL_ROOM,
    ["DESC"] = "pedestal",
    ["SYNONYM"] = "PEDESTAL",
    ["FLAGS"] = {"NDESCBIT", "OPENBIT", "CONTBIT", "SURFACEBIT"},
    ["CAPACITY"] = 50,
    ["ACTION"] = ZG.PEDESTAL_F,
} end) end, true)

-- zil: 3actions.zil:2400  <OBJECT CAGE>
ZG._declare("CAGE", function() return ZG._declare_object("CAGE", function() return {
    ["LOC"] = ZG.JEWEL_ROOM,
    ["DESC"] = "steel cage",
    ["SYNONYM"] = "CAGE",
    ["ADJECTIVE"] = "STEEL",
    ["FLAGS"] = {"NDESCBIT", "CONTBIT", "OPENBIT", "SURFACEBIT"},
    ["CAPACITY"] = 5,
    ["ACTION"] = ZG.CAGE_F,
} end) end, true)

-- zil: 3actions.zil:2409  <OBJECT TECH-PLAQUE>
ZG._declare("TECH_PLAQUE", function() return ZG._declare_object("TECH-PLAQUE", function() return {
    ["LOC"] = ZG.TECH_MUSEUM,
    ["DESC"] = "plaque",
    ["SYNONYM"] = {"PLAQUE", "TEXT"},
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["ACTION"] = ZG.TECH_PLAQUE_F,
} end) end, true)

-- zil: 3actions.zil:2416  <OBJECT PLAQUE>
ZG._declare("PLAQUE", function() return ZG._declare_object("PLAQUE", function() return {
    ["LOC"] = ZG.CAGE,
    ["DESC"] = "bronze plaque",
    ["SYNONYM"] = {"PLAQUE", "TEXT"},
    ["ADJECTIVE"] = "BRONZE",
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["ACTION"] = ZG.PLAQUE_F,
} end) end, true)

-- ;"The present year using the GUE calendar."

-- zil: 3actions.zil:2426  <GLOBAL MACHINE-DAMAGED>
-- MACHINE_DAMAGED is declared in ZilGlobal.lua

-- zil: 3actions.zil:2428  <GLOBAL YEAR>
-- YEAR is declared in ZilGlobal.lua

-- zil: 3actions.zil:2430  <CONSTANT YEAR-BUILT>
-- YEAR_BUILT is declared in ZilGlobal.lua

-- zil: 3actions.zil:2432  <CONSTANT YEAR-CAGED>
-- YEAR_CAGED is declared in ZilGlobal.lua

-- zil: 3actions.zil:2434  <GLOBAL YEAR-CLOSED>
-- YEAR_CLOSED is declared in ZilGlobal.lua

-- zil: 3actions.zil:2436  <CONSTANT REAL-YEAR-CLOSED>
-- REAL_YEAR_CLOSED is declared in ZilGlobal.lua

-- zil: 3actions.zil:2438  <CONSTANT YEAR-PRESENT>
-- YEAR_PRESENT is declared in ZilGlobal.lua

-- zil: 3actions.zil:2440  <ROUTINE IRON-DOOR-F ()>
ZG.actions:register("IRON_DOOR_F", function()

    if ZG._T(ZG.VERB_p("OPEN", "UNLOCK", "THROUGH")) then
        if ZG.LT(ZG.YEAR, ZG.YEAR_PRESENT) then
            do return ZG.TELL("The iron door is locked from the outside.", ZG._TK.CR) end
        else
            do return ZG.TELL("The iron door is rusted shut and cannot be opened.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "IRON-DOOR-F")

ZG.IRON_DOOR_F = ZG.actions:get("IRON_DOOR_F")

-- zil: 3actions.zil:2449  <GLOBAL CLEFT-FLAG>
-- CLEFT_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:2451  <ROUTINE I-CLEFT ()>
ZG.actions:register("I_CLEFT", function()

    if (ZG.EQUAL_p(ZG.HERE, ZG.ZORK_IV, ZG.ROOM_8, ZG.TIMBER_ROOM) or ZG.EQUAL_p(ZG.HERE, ZG.LOWER_SHAFT, ZG.LADDER_BOTTOM, ZG.LADDER_TOP)) then
        do local _ = ZG.TELL("You feel a mild tremor from within the earth which passes quickly.", ZG._TK.CR) end
    else
        do local _ = ZG.TELL("There is a great tremor from within the earth. The entire dungeon shakes\nviolently and loose debris falls from above you.", ZG._TK.CR) end
    end
    if ZG.EQ(ZG.HERE, ZG.MUSEUM_ANTE) then
        do local _ = ZG.TELL("To the east, next to the great iron door, a cleft opens up,\nrevealing an open area behind!", ZG._TK.CR) end
    elseif ZG.EQ(ZG.HERE, ZG.AQ_VIEW) then
        do local _ = ZG.TELL("One of the giant pillars supporting the aqueduct collapses in a pile\nof smoke and rubble!", ZG._TK.CR) end
    elseif ZG.EQUAL_p(ZG.HERE, ZG.AQ_2, ZG.AQ_3) then
        do local _ = ZG.TELL("The channel beneath your feet trembles. Then the channel just to the ") end
        if ZG.EQ(ZG.HERE, ZG.AQ_2) then
            do local _ = ZG.TELL("north") end
        else
            do local _ = ZG.TELL("south") end
        end
        do local _ = ZG.TELL(" collapses and falls into the chasm!", ZG._TK.CR) end
    end
    ZG._set("CLEFT_FLAG", true)
    do local _ = ZG.FCLEAR(ZG.CLEFT, "INVISIBLE") end
    ZG._set("AQ_FLAG", false)
    do return true end

end, "I-CLEFT")

ZG.I_CLEFT = ZG.actions:get("I_CLEFT")

-- zil: 3actions.zil:2479  <ROUTINE CLEFT-F ()>
ZG.actions:register("CLEFT_F", function()

    if (not ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT)) then
        do return ZG.TELL("There is no cleft here.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CLEFT-F")

ZG.CLEFT_F = ZG.actions:get("CLEFT_F")

-- zil: 3actions.zil:2483  <ROUTINE MUSEUM-ANTE-F (RARG)>
ZG.actions:register("MUSEUM_ANTE_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG._T(ZG.CLEFT_FLAG) then
            do return ZG.TELL("This is the south end of a monumental hall, full of debris from\na recent earthquake. To the east is a great iron door, rusted shut. To its\nright, however, is a gaping cleft in the rock and behind, a cleared area.", ZG._TK.CR) end
        else
            do return ZG.TELL("You are in the southern half of a monumental hall. To the east lies\na tremendous iron door which appears to be rusted shut.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "MUSEUM-ANTE-F")

ZG.MUSEUM_ANTE_F = ZG.actions:get("MUSEUM_ANTE_F")

-- zil: 3actions.zil:2495  <ROUTINE DDESC (STR1 DOOR STR2)>
ZG.actions:register("DDESC", function(STR1, DOOR, STR2)

    do local _ = ZG.TELL(STR1) end
    if ZG._T(ZG.FSET_p(DOOR, "OPENBIT")) then
        do local _ = ZG.TELL("open") end
    else
        do local _ = ZG.TELL("closed") end
    end
    do return ZG.TELL(STR2, ZG._TK.CR) end

end, "DDESC")

ZG.DDESC = ZG.actions:get("DDESC")

-- zil: 3actions.zil:2502  <ROUTINE MUSEUM-ENTRANCE-F (RARG)>
ZG.actions:register("MUSEUM_ENTRANCE_F", function(RARG)

    local _tmp1, _tmp2
    if ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG._T(ZG.FSET_p(ZG.CAGE, "INVISIBLE")) then
            do return ZG.TELL("This is an entrance hall of some sort, judging by the grand iron\ndoor to the west, and the ornate stone and wooden doors which lead to the east\nand north, respectively. A few wide steps lead south.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("This is the entrance to the Royal Museum, the finest and grandest in the\nGreat Underground Empire. To the south, down a few steps, is the entrance\nto the Royal Puzzle and to the east, through a stone door, is the Royal\nJewel Collection. A wooden door to the north is ") end
            if ZG._T(ZG.FSET_p(ZG.WOODEN_DOOR, "OPENBIT")) then
                _tmp1 = "open"
            else
                _tmp1 = "closed"
            end
            if ZG._T(ZG.FSET_p(ZG.WOODEN_DOOR, "OPENBIT")) then
                _tmp2 = "open"
            else
                _tmp2 = "closed"
            end
            do local _ = ZG.TELL(_tmp2, "\nand leads to the Museum of Technology. ") end
            if ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT) then
                do return ZG.TELL("To the west is a great iron door, rusted shut. To its left, however, is a\ncleft in the rock providing an exit from the museum.", ZG._TK.CR) end
            elseif ZG.LT(ZG.YEAR, ZG.YEAR_PRESENT) then
                do return ZG.TELL("To the west is a great iron door, rusted shut.", ZG._TK.CR) end
            else
                do return ZG.TELL("To the west is a great iron door, rusted shut. The cleft in the rock,\npresent when you started, has filled in with rubble.", ZG._TK.CR) end
            end
        end
    else
        do return false end
    end

end, "MUSEUM-ENTRANCE-F")

ZG.MUSEUM_ENTRANCE_F = ZG.actions:get("MUSEUM_ENTRANCE_F")

-- zil: 3actions.zil:2530  <GLOBAL TM-YEAR>
-- TM_YEAR is declared in ZilGlobal.lua

-- zil: 3actions.zil:2532  <ROUTINE TIME-MACHINE-F ("OPTIONAL" (RARG <>))>
ZG.actions:register("TIME_MACHINE_F", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_OBJDESC) then
        do return ZG.TELL("Directly in front of you is a large golden machine, which has a seat with a\nconsole in front. On the console is a single button and a dial connected to\na three-digit display which reads ", ZG._TK.N, ZG.TM_YEAR, ". The machine is surprisingly shiny and shows few signs of age.", ZG._TK.CR) end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if ZG._T(ZG.VERB_p("MOVE")) then
            do return ZG.TELL("You might be able to move the machine by pushing it.", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("PUSH-TO")) and ZG.EQ(ZG.PRSO, ZG.TIME_MACHINE)) then
            do return ZG.TELL("That would be a good trick from inside it.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("WALK")) then
            do return ZG.TELL("You're not going anywhere in this heap.", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("TAKE", "PUT", "MOVE", "PUSH", "OPEN", "CLOSE")) and (not ZG._T(ZG.HELD_p(ZG.PRSO))) and (not ZG._T(ZG.IN_p(ZG.PRSO, ZG.TIME_MACHINE)))) then
            do return ZG.TELL("You can't do that from inside the machine.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (not ZG._T(RARG)) then
        if (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.TIME_MACHINE)) then
            do return ZG.TELL("You can't put anything on or inside the machine itself.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSO, ZG.TIME_MACHINE) then
            if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
                do return ZG.TELL("This is a machine, not a box.", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("EXAMINE")) then
                do return ZG.TELL("The machine consists of a seat and a console containing one small button\nand a dial connected to a display which reads ", ZG._TK.N, ZG.TM_YEAR, ".", ZG._TK.CR) end
            elseif (ZG._T(ZG.VERB_p("BOARD")) and ZG._T(ZG.FIRST_p(ZG.TM_SEAT))) then
                do return ZG.TELL("That will be somewhat uncomfortable!", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("TAKE", "RAISE")) then
                do return ZG.TELL("The machine must weigh hundreds of pounds and cannot be carried.", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("PUSH", "MOVE")) then
                do return ZG.TELL("You should specify in which direction to push the machine.", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("PUSH-TO")) then
                if (not ZG.EQ(ZG.DO_WALK(ZG.P_DIRECTION), ZG.M_FATAL)) then
                    do local _ = ZG.TELL("With some effort, you push the machine into the room with you.", ZG._TK.CR) end
                    if ZG.EQUAL_p(ZG.HERE, ZG.CP_ANTE, ZG.MID_CP_ANTE) then
                        do local _ = ZG.TELL("However, the machine seems to have sustained some damage as a result\nof going over the stairs.", ZG._TK.CR) end
                        ZG._set("MACHINE_DAMAGED", true)
                    elseif ZG.EQ(ZG.HERE, ZG.MUSEUM_ANTE) then
                        do local _ = ZG.TELL("Pushing the machine through the cleft seems to have damaged it.", ZG._TK.CR) end
                        ZG._set("MACHINE_DAMAGED", true)
                    end
                    do local _ = ZG.MOVE(ZG.TIME_MACHINE, ZG.HERE) end
                end
                do return true end
            else
                do return false end
            end
        else
            do return false end
        end
    else
        do return false end
    end

end, "TIME-MACHINE-F")

ZG.TIME_MACHINE_F = ZG.actions:get("TIME_MACHINE_F")

-- zil: 3actions.zil:2593  <GLOBAL RING-CONCEALED>
-- RING_CONCEALED is declared in ZilGlobal.lua

-- zil: 3actions.zil:2595  <ROUTINE TM-SEAT-F ()>
ZG.actions:register("TM_SEAT_F", function()

    if ZG._T(ZG.VERB_p("CLIMB-ON", "BOARD")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?BOARD"), ZG.TIME_MACHINE) end
        do return true end
    elseif (ZG._T(ZG.VERB_p("PUT-UNDER", "PUT-BEHIND")) and ZG.EQ(ZG.PRSI, ZG.TM_SEAT)) then
        if ZG.EQ(ZG.PRSO, ZG.RING) then
            do local _ = ZG.TELL("The ring is concealed underneath the seat.", ZG._TK.CR) end
            ZG._set("RING_CONCEALED", true)
            do return ZG.REMOVE(ZG.RING) end
        else
            do return ZG.TELL("It's too big to hide under the seat.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("RUB")) then
        do return ZG.TELL("There's nothing odd about the feel of the seat.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-UNDER", "RAISE", "MOVE")) then
        if ZG._T(ZG.RING_CONCEALED) then
            do local _ = ZG.TELL("You find the ring under the seat and put it on your finger.", ZG._TK.CR) end
            do local _ = ZG.MOVE(ZG.RING, ZG.WINNER) end
            ZG._set("RING_CONCEALED", false)
            do return true end
        else
            do return ZG.TELL("You notice a small hollow area under the seat.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "TM-SEAT-F")

ZG.TM_SEAT_F = ZG.actions:get("TM_SEAT_F")

-- zil: 3actions.zil:2619  <ROUTINE TM-DIAL-F ()>
ZG.actions:register("TM_DIAL_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The dial is set to ", ZG._TK.N, ZG.TM_YEAR, ".", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TURN")) then
        if ZG.EQ(ZG.PRSI, ZG.INTNUM) then
            if ZG.LT(999, ZG.P_NUMBER) then
                do return ZG.TELL("You can't set it beyond 999.", ZG._TK.CR) end
            else
                ZG._set("TM_YEAR", ZG.P_NUMBER)
                do return ZG.TELL("The dial is set to ", ZG._TK.N, ZG.TM_YEAR, ".", ZG._TK.CR) end
            end
        elseif (not ZG._T(ZG.PRSI)) then
            do return ZG.TELL("You have to say what to turn it to!", ZG._TK.CR) end
        else
            do return ZG.TELL("You can't do that!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "TM-DIAL-F")

ZG.TM_DIAL_F = ZG.actions:get("TM_DIAL_F")

-- zil: 3actions.zil:2633  <GLOBAL TM-POINT>
-- TM_POINT is declared in ZilGlobal.lua

-- zil: 3actions.zil:2635  <ROUTINE TM-BUTTON-F ()>
ZG.actions:register("TM_BUTTON_F", function()

    if ZG._T(ZG.VERB_p("PUSH")) then
        if (ZG.EQ(ZG.TM_YEAR, ZG.YEAR_BUILT) and (not ZG._T(ZG.TM_POINT))) then
            ZG._set("SCORE", ZG.ADD(ZG.SCORE, 1))
            ZG._set("TM_POINT", true)
        end
        if (ZG._T(ZG.MACHINE_DAMAGED) or (not ZG._T(ZG.IN_p(ZG.WINNER, ZG.TIME_MACHINE)))) then
            do return ZG.TELL("Nothing seems to have happened.", ZG._TK.CR) end
        elseif ZG.LT(ZG.TM_YEAR, ZG.YEAR_BUILT) then
            do return ZG.REALLY_DEAD("You experience a period of disorientation. The area around you seems\nto be solidifying! Rock formations close in on you and you become\nengulfed in stone!") end
        elseif ZG.EQ(ZG.YEAR, ZG.TM_YEAR) then
            do return ZG.TELL("Nothing seems to have happened.", ZG._TK.CR) end
        elseif ZG.LT(ZG.TM_YEAR, ZG.YEAR_CLOSED) then
            do local _ = ZG.TELL("You experience a brief period of disorientation. When your vision returns, ") end
            if ZG.EQUAL_p(ZG.HERE, ZG.MUSEUM_ENTRANCE, ZG.MID_MUSEUM_ENTRANCE, ZG.OLD_MUSEUM_ENTRANCE) then
                if ZG.EQ(ZG.TM_YEAR, ZG.YEAR_CAGED) then
                    do local _ = ZG.TELL("you are surrounded by a number of heavily armed guards, the dress and\nspeech of which seem strange and unfamiliar. A commotion starts at a door\nto the east and a person with a flat head, wearing a gaudy crown and a purple\nrobe, bursts into the room.", ZG._TK.CR) end
                    do return ZG.FLATHEAD_SENTENCE() end
                else
                    do return ZG.GUARDS_KILL() end
                end
            elseif ZG.EQUAL_p(ZG.HERE, ZG.JEWEL_ROOM, ZG.MID_JEWEL_ROOM, ZG.OLD_JEWEL_ROOM) then
                if ZG.EQ(ZG.TM_YEAR, ZG.YEAR_CAGED) then
                    do local _ = ZG.TELL("you find yourself in the middle of some kind of ceremony, with a strange\nflat-headed man wearing royal vestments about to break a bottle on the bars\nof an iron cage containing magnificent jewels. He appears pleased\nby your presence. ") end
                    do return ZG.FLATHEAD_SENTENCE() end
                elseif ZG.LT(ZG.YEAR_CAGED, ZG.TM_YEAR) then
                    do return ZG.GUARDS_KILL() end
                else
                    do local _ = ZG.TELL(ZG.SURROUNDINGS_CHANGED, ZG._TK.CR) end
                    do return ZG.TGOTO(ZG.OLD_JEWEL_ROOM) end
                end
            elseif ZG.EQUAL_p(ZG.HERE, ZG.TECH_MUSEUM, ZG.MID_TECH_MUSEUM, ZG.OLD_TECH_MUSEUM) then
                if (not ZG.EQ(ZG.TM_YEAR, ZG.YEAR_BUILT)) then
                    do return ZG.GUARDS_KILL() end
                else
                    do local _ = ZG.TELL(ZG.SURROUNDINGS_CHANGED, ZG._TK.CR) end
                    do return ZG.TGOTO(ZG.OLD_TECH_MUSEUM) end
                end
            else
                do return false end
            end
        else
            do return ZG.HAPPY_NEW_YEAR() end
        end
    else
        do return false end
    end

end, "TM-BUTTON-F")

ZG.TM_BUTTON_F = ZG.actions:get("TM_BUTTON_F")

-- zil: 3actions.zil:2689  <GLOBAL SURROUNDINGS-CHANGED>
-- SURROUNDINGS_CHANGED is declared in ZilGlobal.lua

-- zil: 3actions.zil:2693  <ROUTINE HAPPY-NEW-YEAR ()>
ZG.actions:register("HAPPY_NEW_YEAR", function()

    do local _ = ZG.TELL("You experience a brief period of disorientation. When your vision returns,\nyour surroundings appear somewhat altered.", ZG._TK.CR) end
    if ZG.EQUAL_p(ZG.HERE, ZG.OLD_JEWEL_ROOM, ZG.MID_JEWEL_ROOM, ZG.JEWEL_ROOM) then
        if ZG.LT(ZG.TM_YEAR, ZG.YEAR_PRESENT) then
            do return ZG.TGOTO(ZG.MID_JEWEL_ROOM) end
        else
            do return ZG.TGOTO(ZG.JEWEL_ROOM) end
        end
    elseif ZG.EQUAL_p(ZG.HERE, ZG.OLD_TECH_MUSEUM, ZG.MID_TECH_MUSEUM, ZG.TECH_MUSEUM) then
        if ZG.LT(ZG.TM_YEAR, ZG.YEAR_PRESENT) then
            do return ZG.TGOTO(ZG.MID_TECH_MUSEUM) end
        else
            do return ZG.TGOTO(ZG.TECH_MUSEUM) end
        end
    elseif ZG.LT(ZG.TM_YEAR, ZG.YEAR_PRESENT) then
        do return ZG.TGOTO(ZG.MID_MUSEUM_ENTRANCE) end
    else
        do return ZG.TGOTO(ZG.MUSEUM_ENTRANCE) end
    end

end, "HAPPY-NEW-YEAR")

ZG.HAPPY_NEW_YEAR = ZG.actions:get("HAPPY_NEW_YEAR")

-- zil: 3actions.zil:2707  <GLOBAL SNAP-LOC>
-- SNAP_LOC is declared in ZilGlobal.lua

-- zil: 3actions.zil:2709  <ROUTINE I-SNAP ()>
ZG.actions:register("I_SNAP", function()

    if ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT) then
        do return false end
    end
    ZG._set("TM_YEAR", ZG.YEAR_PRESENT)
    do local _ = ZG.TELL("You start to feel light-headed and quickly become completely disoriented.\nWhen your head clears, you realize that your surroundings have changed.", ZG._TK.CR) end
    do return ZG.TGOTO(ZG.SNAP_LOC, true) end

end, "I-SNAP")

ZG.I_SNAP = ZG.actions:get("I_SNAP")

-- zil: 3actions.zil:2718  <ROUTINE MOVE-JEWELS ()>
ZG.actions:register("MOVE_JEWELS", function()

    if ZG.EQ(ZG.TM_YEAR, ZG.YEAR_BUILT) then
        do local _ = ZG.MOVE(ZG.PEDESTAL, ZG.OLD_JEWEL_ROOM) end
    elseif ZG.LT(ZG.TM_YEAR, ZG.YEAR_PRESENT) then
        do local _ = ZG.MOVE(ZG.PEDESTAL, ZG.MID_JEWEL_ROOM) end
    else
        do local _ = ZG.MOVE(ZG.PEDESTAL, ZG.JEWEL_ROOM) end
    end
    if ZG._T(ZG.RING_STOLEN) then
        do return true end
    end
    do local _ = ZG.MOVE(ZG.SCEPTRE, ZG.PEDESTAL) end
    do local _ = ZG.FSET(ZG.SCEPTRE, "NDESCBIT") end
    do local _ = ZG.MOVE(ZG.JEWELLED_KNIFE, ZG.PEDESTAL) end
    do local _ = ZG.FSET(ZG.JEWELLED_KNIFE, "NDESCBIT") end
    if (not ZG._T(ZG.RING_CONCEALED)) then
        do local _ = ZG.MOVE(ZG.RING, ZG.PEDESTAL) end
        do return ZG.FSET(ZG.RING, "NDESCBIT") end
    else
        do return false end
    end

end, "MOVE-JEWELS")

ZG.MOVE_JEWELS = ZG.actions:get("MOVE_JEWELS")

-- zil: 3actions.zil:2734  <ROUTINE TGOTO ("OPTIONAL" (RM <>) (SNAP <>))>
ZG.actions:register("TGOTO", function(RM, SNAP)

    if RM == nil then RM = false end
    if SNAP == nil then SNAP = false end
    ZG._set("MOVES", ZG.ADD(ZG.MOVES, 1))
    do local _ = ZG.QUEUE(ZG.I_GUARDS_LEAVE, 0) end
    ZG._set("INVIS", false)
    if ZG.LT(ZG.YEAR_BUILT, ZG.YEAR) then
        ZG._set("GUARDS_PRESENT", true)
    end
    if ZG.EQ(ZG.YEAR, ZG.YEAR_PRESENT) then
        ZG._set("SNAP_LOC", ZG.HERE)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SNAP, 40)) end
    end
    if ZG.EQ(ZG.TM_YEAR, ZG.YEAR_PRESENT) then
        ZG._set("CLEFT_FLAG", true)
    else
        ZG._set("CLEFT_FLAG", false)
    end
    do local _ = ZG.FCLEAR(ZG.JEWEL_DOOR, "OPENBIT") end
    do local _ = ZG.FCLEAR(ZG.WOODEN_DOOR, "OPENBIT") end
    do local _ = ZG.FCLEAR(ZG.IRON_DOOR, "OPENBIT") end
    if ZG.EQ(ZG.YEAR, ZG.YEAR_BUILT) then
        if (ZG._T(ZG.RING_CONCEALED) and ZG._T(ZG.IN_p(ZG.TIME_MACHINE, ZG.OLD_TECH_MUSEUM)) and ZG._T(ZG.IN_p(ZG.SCEPTRE, ZG.PEDESTAL)) and ZG._T(ZG.IN_p(ZG.JEWELLED_KNIFE, ZG.PEDESTAL))) then
            ZG._set("RING_STOLEN", true)
            do local _ = ZG.FSET(ZG.CAGE, "INVISIBLE") end
            do local _ = ZG.REMOVE(ZG.SCEPTRE) end
            do local _ = ZG.REMOVE(ZG.JEWELLED_KNIFE) end
        elseif ((not ZG._T(ZG.IN_p(ZG.TIME_MACHINE, ZG.OLD_TECH_MUSEUM))) or ZG._T(ZG.RING_CONCEALED)) then
            ZG._set("CLUMSY_ROBBERY", true)
            do local _ = ZG.REMOVE(ZG.TIME_MACHINE) end
        elseif ((not ZG._T(ZG.IN_p(ZG.RING, ZG.PEDESTAL))) or (not ZG._T(ZG.IN_p(ZG.SCEPTRE, ZG.PEDESTAL))) or (not ZG._T(ZG.IN_p(ZG.JEWELLED_KNIFE, ZG.PEDESTAL)))) then
            ZG._set("MYSTERY", true)
        end
    end
    if ZG.EQ(ZG.TM_YEAR, ZG.YEAR_BUILT) then
        ZG._set("MYSTERY", false)
        ZG._set("CLUMSY_ROBBERY", false)
    end
    ZG._set("YEAR", ZG.TM_YEAR)
    do local _ = ZG.MOVE_TM_OBJECTS() end
    do local _ = ZG.MOVE_JEWELS() end
    do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
    do local _ = ZG.GOTO(RM, false) end
    if ZG.EQ(ZG.YEAR, ZG.YEAR_BUILT) then
        do local _ = ZG.MOVE(ZG.TIME_MACHINE, ZG.OLD_TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.SPINNER, ZG.OLD_TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.PRESSURIZER, ZG.OLD_TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.TECH_PLAQUE, ZG.OLD_TECH_MUSEUM) end
    elseif ZG.LT(ZG.YEAR, ZG.YEAR_PRESENT) then
        if (not ZG._T(ZG.CLUMSY_ROBBERY)) then
            do local _ = ZG.MOVE(ZG.TIME_MACHINE, ZG.MID_TECH_MUSEUM) end
        end
        do local _ = ZG.MOVE(ZG.SPINNER, ZG.MID_TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.PRESSURIZER, ZG.MID_TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.TECH_PLAQUE, ZG.MID_TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.CAGE, ZG.MID_JEWEL_ROOM) end
    else
        do local _ = ZG.MOVE(ZG.TIME_MACHINE, ZG.TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.SPINNER, ZG.TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.PRESSURIZER, ZG.TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.TECH_PLAQUE, ZG.TECH_MUSEUM) end
        do local _ = ZG.MOVE(ZG.CAGE, ZG.JEWEL_ROOM) end
    end
    if (ZG._T(ZG.CLUMSY_ROBBERY) or (not ZG.EQUAL_p(ZG.HERE, ZG.TECH_MUSEUM, ZG.MID_TECH_MUSEUM, ZG.OLD_TECH_MUSEUM))) then
        if (not ZG._T(SNAP)) then
            do local _ = ZG.TELL("You notice that the golden machine has disappeared!", ZG._TK.CR) end
        end
    else
        do local _ = ZG.MOVE(ZG.WINNER, ZG.TIME_MACHINE) end
    end
    if ZG._T(ZG.CLUMSY_ROBBERY) then
        do local _ = ZG.REMOVE(ZG.TIME_MACHINE) end
    end
    do return true end

end, "TGOTO")

ZG.TGOTO = ZG.actions:get("TGOTO")

-- zil: 3actions.zil:2804  <ROUTINE MOVE-TM-OBJECTS ("AUX" F (MFLG <>) (WFLG <>) N)>
ZG.actions:register("MOVE_TM_OBJECTS", function()

    local F = 0
    local MFLG = false
    local WFLG = false
    local N = 0
    F = ZG.FIRST_p(ZG.TIME_MACHINE)
    if ZG._T(F) then
        while true do
            if (ZG.EQUAL_p(F, ZG.TM_DIAL, ZG.TM_SEAT, ZG.TM_BUTTON) or ZG.EQ(F, ZG.PLAYER)) then
            elseif (not ZG._T(MFLG)) then
                MFLG = true
                do local _ = ZG.TELL("You notice that everything in the machine is gone") end
            end
            N = ZG.NEXT_p(F)
            if (not ZG.EQUAL_p(F, ZG.TM_DIAL, ZG.TM_SEAT, ZG.TM_BUTTON)) then
                do local _ = ZG.MOVE(F, ZG.HERE) end
            end
            F = N
            if (not ZG._T(F)) then
                break
            end
        end
    end
    F = ZG.FIRST_p(ZG.WINNER)
    if ZG._T(F) then
        while true do
            if (not ZG._T(WFLG)) then
                WFLG = true
                if ZG._T(MFLG) then
                    do local _ = ZG.TELL(": come to mention\nit, everything you were holding has vanished too") end
                else
                    do local _ = ZG.TELL("You notice that everything you were holding is gone") end
                end
            end
            N = ZG.NEXT_p(F)
            do local _ = ZG.MOVE(F, ZG.HERE) end
            F = N
            if (not ZG._T(F)) then
                break
            end
        end
    end
    if (ZG._T(MFLG) or ZG._T(WFLG)) then
        do return ZG.TELL("!", ZG._TK.CR) end
    else
        do return false end
    end

end, "MOVE-TM-OBJECTS")

ZG.MOVE_TM_OBJECTS = ZG.actions:get("MOVE_TM_OBJECTS")

-- zil: 3actions.zil:2835  <ROUTINE GUARDS-KILL ()>
ZG.actions:register("GUARDS_KILL", function()

    do local _ = ZG.TELL(ZG.PICK_ONE(ZG.GUARD_KILLERS), ZG._TK.CR) end
    do return ZG.REALLY_DEAD(" ") end

end, "GUARDS-KILL")

ZG.GUARDS_KILL = ZG.actions:get("GUARDS_KILL")

-- zil: 3actions.zil:2839  <GLOBAL GUARD-KILLERS>
-- GUARD_KILLERS is declared in ZilGlobal.lua

-- zil: 3actions.zil:2852  <ROUTINE FLATHEAD-SENTENCE ()>
ZG.actions:register("FLATHEAD_SENTENCE", function()

    do return ZG.REALLY_DEAD("He speaks loudly, nearly deafening the poor civil\nservant whose duty it is to see that his wishes are carried out. \"Aha! A\nthief! Didn't I tell you that we needed more security! But, no! You all\nsaid my idea to build the museum under two miles of mountain and surrounded\nby five hundred feet of steel was impractical! Now, what to do with this ...\nintruder? I have it! We'll build a tremendous fortress on the highest mountain\npeak, with one narrow ladder stretching thousands of feet to the pinnacle.\nThere he will stay for the rest of his life!\" His brow-beaten assistant\nhesitates. \"Don't you think, Your Lordship, that your plan is a bit, well,\na bit much?\" Flathead gives it a second's thought. \"No, not really.\" he\nsays, and you are led away. A few years later, your prison is finished. You\nare taken there, and spend the rest of your life in misery.") end

end, "FLATHEAD-SENTENCE")

ZG.FLATHEAD_SENTENCE = ZG.actions:get("FLATHEAD_SENTENCE")

-- zil: 3actions.zil:2866  <ROUTINE REALLY-DEAD (STR)>
ZG.actions:register("REALLY_DEAD", function(STR)

    do local _ = ZG.TELL(STR, "\n\n****  You have died  ****\n\n") end
    do return ZG.FINISH() end

end, "REALLY-DEAD")

ZG.REALLY_DEAD = ZG.actions:get("REALLY_DEAD")

-- zil: 3actions.zil:2874  <GLOBAL FLATHEAD-HEARD>
-- FLATHEAD_HEARD is declared in ZilGlobal.lua

-- zil: 3actions.zil:2876  <GLOBAL RING-STOLEN>
-- RING_STOLEN is declared in ZilGlobal.lua

-- zil: 3actions.zil:2877  <GLOBAL CLUMSY-ROBBERY>
-- CLUMSY_ROBBERY is declared in ZilGlobal.lua

-- zil: 3actions.zil:2878  <GLOBAL MYSTERY>
-- MYSTERY is declared in ZilGlobal.lua

-- zil: 3actions.zil:2880  <GLOBAL GUARDS-PRESENT>
-- GUARDS_PRESENT is declared in ZilGlobal.lua

-- zil: 3actions.zil:2882  <ROUTINE HEAR-FLATHEAD ()>
ZG.actions:register("HEAR_FLATHEAD", function()

    ZG._set("FLATHEAD_HEARD", true)
    do return ZG.TELL("One particularly loud and grating voice can be heard above the\nothers outside the room. \"Very nice! Very nice! Not enough security, but\nvery nice! Now, Lord Feepness, pay attention! I've been thinking that what\nwe need is a dam, a tremendous dam to control the Frigid River, with\nthousands of gates. We shall call it ... Flood Control Dam #2. No, not\nquite right. Aha! Flood Control Dam #3.\" \"Pardon me, my Lord, but wouldn't\nthat be just a tad excessive?\" \"Nonsense! Now, let me tell you my idea for\nhollowing out volcanoes...\" With that, the voices trail out nothingness.", ZG._TK.CR) end

end, "HEAR-FLATHEAD")

ZG.HEAR_FLATHEAD = ZG.actions:get("HEAR_FLATHEAD")

-- zil: 3actions.zil:2894  <ROUTINE OLD-TECH-MUSEUM-F (RARG)>
ZG.actions:register("OLD_TECH_MUSEUM_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_LOOK) and ZG.EQ(ZG.HERE, ZG.OLD_JEWEL_ROOM)) then
        do local _ = ZG.TELL("You are in a high-ceilinged chamber, in the center of which\nis a pedestal which ") end
        if (not ZG._T(ZG.RING_STOLEN)) then
            do local _ = ZG.TELL("is the intended home of the Crown\nJewels of the Great Underground Empire: a jewelled knife, a golden ring, and\nthe royal sceptre.") end
            if ((not ZG._T(ZG.IN_p(ZG.SCEPTRE, ZG.PEDESTAL))) or (not ZG._T(ZG.IN_p(ZG.RING, ZG.PEDESTAL))) or (not ZG._T(ZG.IN_p(ZG.JEWELLED_KNIFE, ZG.PEDESTAL)))) then
                do local _ = ZG.TELL(" Not all of the jewels are in place, however.") end
            end
        else
            do local _ = ZG.TELL("is bare.") end
        end
        do local _ = ZG.TELL("\nThe room is, by appearances, unfinished.", ZG._TK.CR) end
        if ZG._T(ZG.GUARDS_PRESENT) then
            do local _ = ZG.TELL(ZG.HEAR_VOICES, ZG._TK.CR) end
        end
        do return true end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG.EQ(ZG.HERE, ZG.OLD_TECH_MUSEUM) then
            do local _ = ZG.TELL("You are in a large, unfinished room, probably intended to be a\npart of the Royal Museum.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("This appears to be an unfinished entranceway to the Royal Museum. There are\ndoors to the east and north, and a blind stairway to the south. A heavy iron\ndoor to the west is closed and locked.", ZG._TK.CR) end
        end
        if ZG._T(ZG.GUARDS_PRESENT) then
            do local _ = ZG.TELL(ZG.HEAR_VOICES, ZG._TK.CR) end
        end
        do return true end
    elseif (ZG.EQ(RARG, ZG.M_END) and (not ZG._T(ZG.FLATHEAD_HEARD)) and ZG._T(ZG.GUARDS_PRESENT) and ZG._T(ZG.PROB(6))) then
        do return ZG.HEAR_FLATHEAD() end
    elseif (ZG.EQ(RARG, ZG.M_ENTER) and ZG._T(ZG.GUARDS_PRESENT)) then
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_GUARDS_LEAVE, ZG.ADD(3, ZG.RANDOM(12)))) end
    elseif (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("OPEN")) and ZG.EQUAL_p(ZG.PRSO, ZG.WOODEN_DOOR, ZG.JEWEL_DOOR) and ZG._T(ZG.GUARDS_PRESENT)) then
        do return ZG.TELL("You open the door ever so slightly and see dozens of armed officials.\nYou shut the door quickly, realizing that you would be killed\nin an instant if you left the room.", ZG._TK.CR) end
    elseif (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.GUARDS_PRESENT) and ZG._T(ZG.PROB(3))) then
        do return ZG.GUARD_CAUGHT() end
    else
        do return false end
    end

end, "OLD-TECH-MUSEUM-F")

ZG.OLD_TECH_MUSEUM_F = ZG.actions:get("OLD_TECH_MUSEUM_F")

-- zil: 3actions.zil:2945  <GLOBAL HEAR-VOICES>
-- HEAR_VOICES is declared in ZilGlobal.lua

-- zil: 3actions.zil:2949  <ROUTINE I-GUARDS-LEAVE ()>
ZG.actions:register("I_GUARDS_LEAVE", function()

    ZG._set("GUARDS_PRESENT", false)
    do return ZG.TELL("You hear, from outside the door, guards marching away, their voices fading.\nAfter a few moments, a booming crash signals the close of what must be a\ntremendous door. Then there is silence.", ZG._TK.CR) end

end, "I-GUARDS-LEAVE")

ZG.I_GUARDS_LEAVE = ZG.actions:get("I_GUARDS_LEAVE")

-- zil: 3actions.zil:2956  <ROUTINE GUARD-CAUGHT ()>
ZG.actions:register("GUARD_CAUGHT", function()

    do return ZG.REALLY_DEAD("A particularly vicious-looking guard enters the room and sees you.\nHe grinds his teeth unpleasantly, pulls a waffle out of his\ngarment, and vaporizes you with a flick of his finger.") end

end, "GUARD-CAUGHT")

ZG.GUARD_CAUGHT = ZG.actions:get("GUARD_CAUGHT")

-- zil: 3actions.zil:2962  <OBJECT ROBOT>
ZG._declare("ROBOT", function() return ZG._declare_object("ROBOT", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "robot",
    ["SYNONYM"] = {"ROBOT", "DEVICE"},
    ["ACTION"] = ZG.ROBOT_F,
} end) end, true)

-- zil: 3actions.zil:2968  <ROUTINE ROBOT-F ()>
ZG.actions:register("ROBOT_F", function()

    if ZG._T(ZG.VERB_p("FOLLOW")) then
        do return ZG.TELL("It moved quickly and left the door closed.", ZG._TK.CR) end
    else
        do return ZG.TELL("There is no robot here.", ZG._TK.CR) end
    end

end, "ROBOT-F")

ZG.ROBOT_F = ZG.actions:get("ROBOT_F")

-- zil: 3actions.zil:2973  <ROUTINE JEWEL-ROOM-F (RARG)>
ZG.actions:register("JEWEL_ROOM_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_END) and ZG._T(ZG.IN_p(ZG.TIME_MACHINE, ZG.HERE)) and ZG._T(ZG.PROB(4))) then
        do local _ = ZG.TELL("An odd robot-like device glides in, dusting the floor as it moves. Its\nhead gyrates briefly as it scans the machine. \"Shame. Shame,\"\nit says, rather tinnily. \"Someone has been tampering with the machines\nagain.\" Six beady mechanical eyes focus on you as the robot picks up the\ngold machine. \"Hands off, adventurer!\" it says as it leaves the\nroom, closing the door behind it.", ZG._TK.CR) end
        do local _ = ZG.FCLEAR(ZG.JEWEL_DOOR, "OPENBIT") end
        do local _ = ZG.FCLEAR(ZG.WOODEN_DOOR, "OPENBIT") end
        do return ZG.MOVE(ZG.TIME_MACHINE, ZG.TECH_MUSEUM) end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a high-ceilinged chamber") end
        if (not ZG._T(ZG.FSET_p(ZG.CAGE, "INVISIBLE"))) then
            do return ZG.TELL(" in the middle of which\nsits a tall, round steel cage, which is securely locked. In the\nmiddle of the cage is a pedestal on which sit the Crown Jewels\nof the Great Underground Empire: a sceptre, a jewelled knife, and a golden\nring. A small bronze plaque, now tarnished, is on the cage.", ZG._TK.CR) end
        else
            do return ZG.TELL(" in the middle of which is a bare\npedestal. The room is unfinished with no\nindication of its purpose. A small plaque is fastened to a wall.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "JEWEL-ROOM-F")

ZG.JEWEL_ROOM_F = ZG.actions:get("JEWEL_ROOM_F")

-- ;"You can take the jewels in YEAR-BUILT; otherwise, it is enclosed.
--   If you take it, YEAR-CLOSED is updated to YEAR-CAGED (history changes)"

-- zil: 3actions.zil:3004  <ROUTINE CROWN-JEWELS-F ()>
ZG.actions:register("CROWN_JEWELS_F", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        if ZG._T(ZG.HELD_p(ZG.PRSO)) then
            do return false end
        elseif (ZG.EQ(ZG.YEAR, ZG.YEAR_BUILT) or ZG._T(ZG.FSET_p(ZG.CAGE, "INVISIBLE"))) then
            do local _ = ZG.FCLEAR(ZG.PRSO, "NDESCBIT") end
            do return false end
        else
            do return ZG.TELL("The jewels are inside a locked cage.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.PEDESTAL) and ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is now resting on the pedestal.", ZG._TK.CR) end
        do local _ = ZG.MOVE(ZG.PRSO, ZG.PEDESTAL) end
        do local _ = ZG.FSET(ZG.PRSO, "NDESCBIT") end
        do return true end
    elseif (ZG._T(ZG.VERB_p("PUT")) and (not ZG._T(ZG.HELD_p(ZG.PRSO)))) then
        do return ZG.TELL("You don't have the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    else
        do return false end
    end

end, "CROWN-JEWELS-F")

ZG.CROWN_JEWELS_F = ZG.actions:get("CROWN_JEWELS_F")

-- zil: 3actions.zil:3024  <ROUTINE TECH-MUSEUM-F (RARG)>
ZG.actions:register("TECH_MUSEUM_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG._T(ZG.FSET_p(ZG.CAGE, "INVISIBLE")) then
            do return ZG.DDESC("This is an exhibit of Empire technology. A wooden door to the\nsouth is ", ZG.WOODEN_DOOR, ".") end
        else
            do return ZG.DDESC("This is a large hall which hosted the technological exhibits of the\nGreat Underground Empire. A door to the south is ", ZG.WOODEN_DOOR, ".") end
        end
    else
        do return false end
    end

end, "TECH-MUSEUM-F")

ZG.TECH_MUSEUM_F = ZG.actions:get("TECH_MUSEUM_F")

-- zil: 3actions.zil:3036  <ROUTINE PLAQUE-F ()>
ZG.actions:register("PLAQUE_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        if ZG._T(ZG.RING_STOLEN) then
            do local _ = ZG.TELL("The plaque explains that this room was to be the home of the Crown Jewels\nof the Empire. However, following the unexplained disappearance of a\npriceless ring during the final stages of construction, Lord Flathead\ndecided to place the remaining jewels in a safer location.\nInterestingly, he placed his most prized possesion, an incredibly gaudy\ncrown, in a locked safe in a volcano specifically hollowed out for that\npurpose.", ZG._TK.CR) end
            do return true end
        end
        do local _ = ZG.FIXED_FONT_ON() end
        do local _ = ZG.TELL("\n         Crown Jewels\n\n  Presented To The Royal Museum\n      By His Gracious Lord\n\n        DIMWIT FLATHEAD\n\n          Dedicated\n         * 777 GUE *") end
        do local _ = ZG.FIXED_FONT_OFF() end
        if ZG._T(ZG.CLUMSY_ROBBERY) then
            do local _ = ZG.TELL(ZG._TK.CR, ZG._TK.CR, "Underneath the plaque, in small lettering, is a description of a clumsy\nattempt to steal the jewels using a time machine from the Technological\nMuseum which the curators were surprised to discover was not a nonworking\nmodel. After the attempt, the machine was removed from the exhibit.") end
        elseif ZG._T(ZG.MYSTERY) then
            do local _ = ZG.TELL(ZG._TK.CR, ZG._TK.CR, "Underneath the plaque, in small lettering, is a description of\na mysterious happening during the final stages of construction of\nthe Museum, in which some of the crown jewels were found displaced\nfrom their proper positions. Fortunately, nothing was missing.\nThe mystery was never solved and the museum was opened despite the objections\nof Lord Flathead that security was too lax.") end
        end
        do local _ = ZG.CRLF() end
        do return true end
    else
        do return false end
    end

end, "PLAQUE-F")

ZG.PLAQUE_F = ZG.actions:get("PLAQUE_F")

-- zil: 3actions.zil:3078  <ROUTINE WOODEN-DOOR-F ()>
ZG.actions:register("WOODEN_DOOR_F", function()

    if (ZG._T(ZG.VERB_p("LISTEN")) and ZG._T(ZG.GUARDS_PRESENT)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?LISTEN"), ZG.VOICES) end
        do return true end
    elseif (ZG._T(ZG.VERB_p("KNOCK")) and ZG._T(ZG.GUARDS_PRESENT)) then
        do return ZG.TELL("You realize that calling attention to yourself would be fatal.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WOODEN-DOOR-F")

ZG.WOODEN_DOOR_F = ZG.actions:get("WOODEN_DOOR_F")

-- zil: 3actions.zil:3086  <ROUTINE JEWEL-DOOR-F ()>
ZG.actions:register("JEWEL_DOOR_F", function()

    if (ZG._T(ZG.VERB_p("KNOCK")) and ZG._T(ZG.GUARDS_PRESENT)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?KNOCK"), ZG.WOODEN_DOOR) end
        do return true end
    elseif ZG._T(ZG.VERB_p("OPEN", "UNLOCK")) then
        if ZG._T(ZG.FSET_p(ZG.JEWEL_DOOR, "OPENBIT")) then
            do return ZG.TELL("It is already open.", ZG._TK.CR) end
        elseif (ZG.EQ(ZG.YEAR, ZG.YEAR_BUILT) and ZG.EQ(ZG.HERE, ZG.OLD_MUSEUM_ENTRANCE)) then
            do return ZG.TELL("The door is locked, probably by the guards on their way out.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The door is now open.", ZG._TK.CR) end
            do return ZG.FSET(ZG.JEWEL_DOOR, "OPENBIT") end
        end
    else
        do return false end
    end

end, "JEWEL-DOOR-F")

ZG.JEWEL_DOOR_F = ZG.actions:get("JEWEL_DOOR_F")

-- zil: 3actions.zil:3102  <ROUTINE CAGE-F ()>
ZG.actions:register("CAGE_F", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The cage is locked.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        do return ZG.TELL("The cage is already closed.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CAGE-F")

ZG.CAGE_F = ZG.actions:get("CAGE_F")

-- zil: 3actions.zil:3106  <ROUTINE VOICES-F ()>
ZG.actions:register("VOICES_F", function()

    if (ZG._T(ZG.GUARDS_PRESENT) and ZG.EQ(ZG.YEAR, ZG.YEAR_BUILT)) then
        do local _ = ZG.TELL("The voices are muffled by the door which (fortunately for you) separates\nyou. They seem to be in heated debate on the topic of\n") end
        do return ZG.TELL(ZG.PICK_ONE(ZG.BLATHER), ".", ZG._TK.CR) end
    else
        do return ZG.TELL("Are you hearing things now?", ZG._TK.CR) end
    end

end, "VOICES-F")

ZG.VOICES_F = ZG.actions:get("VOICES_F")

-- zil: 3actions.zil:3115  <GLOBAL BLATHER>
-- BLATHER is declared in ZilGlobal.lua

-- zil: 3actions.zil:3124  <ROUTINE MUSEUM-PIECES ("OPTIONAL" (RARG <>))>
ZG.actions:register("MUSEUM_PIECES", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_OBJDESC) then
        if ZG.EQ(ZG.DESC_OBJECT, ZG.SPINNER) then
            do return true end
        end
        do local _ = ZG.TELL("A strange grey machine, shaped somewhat like a clothes dryer, is on one side\nof the room. On the other side of the hall is a powerful-looking black\nmachine, a tight tangle of wires, pipes, and motors.\nA plaque is mounted near the door.") end
        if ZG.LT(ZG.YEAR, ZG.YEAR_CLOSED) then
            do return ZG.TELL(" The grey machine, it turns out, is a Frobozz\nMagic Pressurizer, used in the coal mines of the Empire. The black machine is\na Frobozz Magic Room Spinner. The golden machine is referred to as a\nTemporizer. All are nonworking models donated by Frobozzco president John\nD. Flathead.", ZG._TK.CR) end
        else
            do return ZG.TELL(" The writing is faded, however, and cannot be\nmade out clearly. The two machines seem to be in bad shape, rusting in many\nspots.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("TAKE", "MOVE")) then
        do return ZG.TELL("It's massive and cannot even be moved.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PUSH", "PUSH-TO")) then
        do return ZG.TELL("It's too heavy to be pushed.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("It seems quite indestructible.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQUAL_p(ZG.PRSI, ZG.SPINNER, ZG.PRESSURIZER)) then
        do return ZG.TELL("There's no good place to put anything there.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MUSEUM-PIECES")

ZG.MUSEUM_PIECES = ZG.actions:get("MUSEUM_PIECES")

-- zil: 3actions.zil:3154  <ROUTINE TECH-PLAQUE-F ()>
ZG.actions:register("TECH_PLAQUE_F", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("It's bolted to the wall.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        if ZG.LT(ZG.YEAR, ZG.YEAR_CLOSED) then
            do return ZG.TELL("The plaque merely identifies the machines and names their donor. They are\nnonworking models of existing state-of-the-art machinery.", ZG._TK.CR) end
        else
            do return ZG.TELL("The words cannot be made out.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "TECH-PLAQUE-F")

ZG.TECH_PLAQUE_F = ZG.actions:get("TECH_PLAQUE_F")

-- zil: 3actions.zil:3164  <ROUTINE PEDESTAL-F ()>
ZG.actions:register("PEDESTAL_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "LOOK-ON")) then
        if ZG._T(ZG.FIRST_p(ZG.PEDESTAL)) then
            do return ZG.TELL("The Royal Jewels are on the pedestal.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("PUT", "PUT-ON", "TAKE")) and (not ZG._T(ZG.FSET_p(ZG.CAGE, "INVISIBLE")))) then
        do return ZG.TELL("You can't reach it through the cage.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PEDESTAL-F")

ZG.PEDESTAL_F = ZG.actions:get("PEDESTAL_F")

-- zil: 3actions.zil:3176  <ROOM CREEPY-CRAWL>
ZG._declare("CREEPY_CRAWL", function() return ZG._declare_object("CREEPY-CRAWL", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Creepy Crawl",
    ["LDESC"] = "You are in a dark and quite creepy crawlway with passages leaving to the\nnorth, east, south, and southwest.",
    ["FLAGS"] = "RLANDBIT",
    ["NORTH"] = {"TO", ZG.JUNCTION},
    ["SOUTH"] = {"TO", ZG.FOGGY_ROOM},
    ["SW"] = {"TO", ZG.SHADOW_1},
    ["EAST"] = {"TO", ZG.TIGHT_SQUEEZE},
    ["ACTION"] = ZG.CREEPY_CRAWL_F,
} end) end, true)

-- zil: 3actions.zil:3189  <ROOM SHADOW-1>
ZG._declare("SHADOW_1", function() return ZG._declare_object("SHADOW-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are at the eastern end of a dark, featureless landscape of shallow\nhills. Paths to the east and southeast reenter the rock.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["NE"] = "Towering walls of rock bar your way.",
    ["NORTH"] = "Towering walls of rock bar your way.",
    ["SOUTH"] = {"TO", ZG.SHADOW_5},
    ["EAST"] = {"TO", ZG.CREEPY_CRAWL},
    ["NW"] = {"TO", ZG.SHADOW_2},
    ["WEST"] = {"TO", ZG.SHADOW_3},
    ["SW"] = {"TO", ZG.SHADOW_4},
    ["SE"] = {"TO", ZG.FOGGY_ROOM},
} end) end, true)

-- zil: 3actions.zil:3206  <ROOM SHADOW-2>
ZG._declare("SHADOW_2", function() return ZG._declare_object("SHADOW-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are in a shadowy land of low, rolling hills stretching out to the west\nand south. The land is bordered to the north by a massive stone wall.\nAncient and weathered, the wall has crumbled enough at one point to permit\npassage.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["NE"] = "A stone wall blocks the way.",
    ["NORTH"] = {"TO", ZG.CLEARING},
    ["NW"] = "A stone wall blocks the way.",
    ["SE"] = {"TO", ZG.SHADOW_1},
    ["SW"] = {"TO", ZG.SHADOW_7},
    ["SOUTH"] = {"TO", ZG.SHADOW_3},
    ["WEST"] = {"TO", ZG.SHADOW_8},
    ["EAST"] = {"TO", ZG.SHADOW_1},
    ["GLOBAL"] = {ZG.RUBBLE, ZG.STONE_WALL},
} end) end, true)

-- zil: 3actions.zil:3226  <ROOM SHADOW-3>
ZG._declare("SHADOW_3", function() return ZG._declare_object("SHADOW-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are in a dark and shadowy land. All around you are gentle hills and\neerie shadows. Far above, shrouded in mist, you can barely make out the\nceiling of the enormous cavern that spans this entire land.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["PSEUDO"] = {"MIST", ZG.MIST_PSEUDO},
    ["NW"] = {"TO", ZG.SHADOW_8},
    ["NE"] = {"TO", ZG.SHADOW_1},
    ["SE"] = {"TO", ZG.SHADOW_1},
    ["SW"] = {"TO", ZG.SHADOW_6},
    ["NORTH"] = {"TO", ZG.SHADOW_2},
    ["SOUTH"] = {"TO", ZG.SHADOW_4},
    ["WEST"] = {"TO", ZG.SHADOW_7},
    ["EAST"] = {"TO", ZG.SHADOW_1},
} end) end, true)

-- zil: 3actions.zil:3245  <ROOM SHADOW-4>
ZG._declare("SHADOW_4", function() return ZG._declare_object("SHADOW-4", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are in an ominously dark land of rolling hills. The ground becomes\nsofter to the south.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["NORTH"] = {"TO", ZG.SHADOW_3},
    ["EAST"] = {"TO", ZG.SHADOW_1},
    ["NE"] = {"TO", ZG.SHADOW_1},
    ["SE"] = {"TO", ZG.SHADOW_5},
    ["SOUTH"] = {"TO", ZG.SHADOW_5},
    ["SW"] = "The ground becomes too soft to walk on in that direction.",
    ["WEST"] = {"TO", ZG.SHADOW_6},
    ["NW"] = {"TO", ZG.SHADOW_7},
} end) end, true)

-- zil: 3actions.zil:3262  <ROOM SHADOW-5>
ZG._declare("SHADOW_5", function() return ZG._declare_object("SHADOW-5", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are at the southern end of a shadowy land. The ground here is quite\nsoft, and the area is surrounded by quicksand on most sides. North of here\nis a terrain of shallow hills.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["PSEUDO"] = {"QUICKS", ZG.QUICKSAND_PSEUDO},
    ["NORTH"] = {"TO", ZG.SHADOW_4},
    ["NW"] = {"TO", ZG.SHADOW_6},
    ["NE"] = {"TO", ZG.SHADOW_1},
    ["SE"] = "The quicksand prevents movement in that direction.",
    ["WEST"] = "The quicksand prevents movement in that direction.",
    ["SOUTH"] = "The quicksand prevents movement in that direction.",
    ["SW"] = "The quicksand prevents movement in that direction.",
    ["EAST"] = "The quicksand prevents movement in that direction.",
} end) end, true)

-- zil: 3actions.zil:3281  <ROOM SHADOW-6>
ZG._declare("SHADOW_6", function() return ZG._declare_object("SHADOW-6", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are near the southern end of the land of shadow. The ground here is\nsoft and spongy, and it becomes quicksand to the south. North and east of here\nare gentle, rolling hills. A gentle sea breeze wafts over a steeply sloping\npath to the west.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["NORTH"] = {"TO", ZG.SHADOW_7},
    ["NW"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["WEST"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["DOWN"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["SE"] = {"TO", ZG.SHADOW_5},
    ["EAST"] = {"TO", ZG.SHADOW_4},
    ["NE"] = {"TO", ZG.SHADOW_3},
    ["SOUTH"] = "The quicksand prevents movement in that direction.",
    ["SW"] = "The quicksand prevents movement in that direction.",
    ["PSEUDO"] = {"QUICKS", ZG.QUICKSAND_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:3302  <ROOM SHADOW-7>
ZG._declare("SHADOW_7", function() return ZG._declare_object("SHADOW-7", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are in a land of dark shadows and shallow hills, which stretch out in all\ndirections. To the west, the land dips sharply.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["NE"] = {"TO", ZG.SHADOW_2},
    ["EAST"] = {"TO", ZG.SHADOW_3},
    ["SE"] = {"TO", ZG.SHADOW_4},
    ["SOUTH"] = {"TO", ZG.SHADOW_6},
    ["NORTH"] = {"TO", ZG.SHADOW_8},
    ["DOWN"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["NW"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["WEST"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["SW"] = {"TO", ZG.FLATHEAD_OCEAN},
} end) end, true)

-- zil: 3actions.zil:3320  <ROOM SHADOW-8>
ZG._declare("SHADOW_8", function() return ZG._declare_object("SHADOW-8", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Land of Shadow",
    ["LDESC"] = "You are standing atop a steep cliff, looking west over a vast ocean.\nFar below, the surf pounds at a sandy beach. To the south and east are\nrolling hills filled with eerie shadows. A path cut into the face of the\ncliff descends toward the beach. To the north is a tall stone wall,\nwhich ends at the cliff edge. It was obviously built long ago, and\ndirectly north is a spot where you could climb over the rubble of the\ndecaying wall.",
    ["FLAGS"] = "RLANDBIT",
    ["ACTION"] = ZG.SHADOW_ROOMS,
    ["SOUTH"] = {"TO", ZG.SHADOW_7},
    ["EAST"] = {"TO", ZG.SHADOW_2},
    ["SE"] = {"TO", ZG.SHADOW_3},
    ["SW"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["WEST"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["NE"] = "A stone wall blocks the way.",
    ["NW"] = "A stone wall blocks the way.",
    ["DOWN"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["NORTH"] = {"TO", ZG.CLIFF},
    ["GLOBAL"] = {ZG.RUBBLE, ZG.STONE_WALL},
} end) end, true)

-- zil: 3actions.zil:3344  <ROOM FLATHEAD-OCEAN>
ZG._declare("FLATHEAD_OCEAN", function() return ZG._declare_object("FLATHEAD-OCEAN", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Flathead Ocean",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["NORTH"] = {"TO", ZG.CLIFF_BASE},
    ["ENTER"] = "Between the rocks, wind, and waves, you wouldn't last a minute.",
    ["WEST"] = "Between the rocks, wind, and waves, you wouldn't last a minute.",
    ["SW"] = "Between the rocks, wind, and waves, you wouldn't last a minute.",
    ["NW"] = "Between the rocks, wind, and waves, you wouldn't last a minute.",
    ["ACTION"] = ZG.FLATHEAD_OCEAN_F,
    ["SE"] = {"TO", ZG.SHADOW_6},
    ["NE"] = {"TO", ZG.SHADOW_8},
    ["EAST"] = {"TO", ZG.SHADOW_7},
    ["SOUTH"] = "The quicksand prevents movement here.",
    ["PSEUDO"] = {"QUICKS", ZG.QUICKSAND_PSEUDO, "MIST", ZG.MIST_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:3360  <OBJECT SHADOW>
ZG._declare("SHADOW", function() return ZG._declare_object("SHADOW", function() return {
    ["DESC"] = "hooded figure",
    ["SYNONYM"] = {"SHADOW", "FIGURE", "MAN", "WOMAN"},
    ["ADJECTIVE"] = {"HOODED", "CLOAKED"},
    ["FLAGS"] = {"ACTORBIT", "TRANSBIT", "CONTBIT", "OPENBIT"},
    ["ACTION"] = ZG.SHADOW_F,
    ["DESCFCN"] = ZG.SHADOW_F,
} end) end, true)

-- zil: 3actions.zil:3368  <OBJECT HOOD>
ZG._declare("HOOD", function() return ZG._declare_object("HOOD", function() return {
    ["LOC"] = ZG.SHADOW,
    ["DESC"] = "hood",
    ["SYNONYM"] = "HOOD",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT", "TAKEBIT", "WEARBIT"},
    ["ACTION"] = ZG.HOOD_F,
} end) end, true)

-- zil: 3actions.zil:3375  <OBJECT CLOAK>
ZG._declare("CLOAK", function() return ZG._declare_object("CLOAK", function() return {
    ["LOC"] = ZG.SHADOW,
    ["DESC"] = "cloak",
    ["SYNONYM"] = "CLOAK",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT", "TAKEBIT", "WEARBIT"},
    ["ACTION"] = ZG.CLOAK_F,
} end) end, true)

-- zil: 3actions.zil:3382  <GLOBAL DIRS>
-- DIRS is declared in ZilGlobal.lua

-- zil: 3actions.zil:3387  <GLOBAL DIR-TBL>
-- DIR_TBL is declared in ZilGlobal.lua

-- zil: 3actions.zil:3389  <ROUTINE PICK-DIRECTION (RM "AUX" (NXT 0) (CNT 0) (OFFS 0))>
ZG.actions:register("PICK_DIRECTION", function(RM)

    local NXT = 0
    local CNT = 0
    local OFFS = 0
    while true do
        if ZG.EQ((function() NXT = ZG.NEXTP(RM, NXT); return NXT end)(), 0) then
            break
        elseif (not ZG.LT(NXT, ZG.LOW_DIRECTION)) then
            if (not ZG.EQUAL_p(NXT, "UP", "DOWN")) then
                OFFS = ZG.ADD(OFFS, 1)
                do local _ = ZG.PUT(ZG.DIR_TBL, OFFS, NXT) end
                CNT = ZG.ADD(CNT, 1)
            end
        end
    end
    do return ZG.GET(ZG.DIR_TBL, ZG.RANDOM(CNT)) end

end, "PICK-DIRECTION")

ZG.PICK_DIRECTION = ZG.actions:get("PICK_DIRECTION")

-- zil: 3actions.zil:3400  <ROUTINE SHADOW-F ("OPTIONAL" (RARG <>))>
ZG.actions:register("SHADOW_F", function(RARG)

    if RARG == nil then RARG = false end
    if ZG.EQ(RARG, ZG.M_OBJDESC) then
        if (not ZG._T(ZG.BLOCKED_DIR)) then
            ZG._set("BLOCKED_DIR", ZG.PICK_DIRECTION(ZG.HERE))
        end
        do local _ = ZG.TELL("A cloaked and hooded person, carrying a sword not unlike your own,") end
        if ZG.LT(3, ZG.S_STRENGTH) then
            do local _ = ZG.TELL("\nis standing blocking the way to the ") end
            do local _ = ZG.TELL(ZG.LKP(ZG.BLOCKED_DIR, ZG.DIRS), ".", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("\nis here.", ZG._TK.CR) end
        end
        do return ZG.TELL("The hooded figure", ZG.GET(ZG.SHADOW_DIAG, ZG.S_STRENGTH), ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.SHADOW)) then
        do return ZG.TELL("The hooded figure isn't interested in your gifts.", ZG._TK.CR) end
    elseif ZG._T(ZG.HELLO_p(ZG.SHADOW)) then
        do return ZG.TELL("The hooded figure does not respond to your words.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("ATTACK")) and ZG.EQ(ZG.PRSI, ZG.SWORD)) then
        if (not ZG._T(ZG.SHADOW_POINT_2)) then
            ZG._set("SCORE", ZG.ADD(ZG.SCORE, 1))
            ZG._set("SHADOW_POINT_2", true)
        end
        do return ZG.SHADOW_ATTACK() end
    elseif ZG._T(ZG.VERB_p("ATTACK")) then
        do local _ = ZG.TELL("The hooded figure ignores your feeble attack.", ZG._TK.CR) end
        ZG._set("ATTACK_MODE", true)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CURE, 10)) end
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_SHADOW_REPLY, -1)) end
    else
        do return false end
    end

end, "SHADOW-F")

ZG.SHADOW_F = ZG.actions:get("SHADOW_F")

-- zil: 3actions.zil:3431  <GLOBAL SHADOW-DIAG>
-- SHADOW_DIAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:3440  <GLOBAL P-STRENGTH>
-- P_STRENGTH is declared in ZilGlobal.lua

-- zil: 3actions.zil:3441  <GLOBAL S-STRENGTH>
-- S_STRENGTH is declared in ZilGlobal.lua

-- zil: 3actions.zil:3443  <GLOBAL ATTACK-MODE>
-- ATTACK_MODE is declared in ZilGlobal.lua

-- zil: 3actions.zil:3444  <GLOBAL SHADOW-GONE>
-- SHADOW_GONE is declared in ZilGlobal.lua

-- zil: 3actions.zil:3446  <ROUTINE I-CURE ()>
ZG.actions:register("I_CURE", function()

    if (not ZG.EQ(ZG.P_STRENGTH, 5)) then
        ZG._set("P_STRENGTH", ZG.ADD(ZG.P_STRENGTH, 1))
    end
    if (not ZG.EQ(ZG.S_STRENGTH, 5)) then
        ZG._set("S_STRENGTH", ZG.ADD(ZG.S_STRENGTH, 1))
    end
    if (not ZG.EQ(ZG.ADD(ZG.P_STRENGTH, ZG.S_STRENGTH), 10)) then
        do local _ = ZG.QUEUE(ZG.I_CURE, 10) end
    end
    do return false end

end, "I-CURE")

ZG.I_CURE = ZG.actions:get("I_CURE")

-- zil: 3actions.zil:3455  <ROUTINE SHADOW-ATTACK ()>
ZG.actions:register("SHADOW_ATTACK", function()

    if (not ZG._T(ZG.ATTACK_MODE)) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CURE, 10)) end
        ZG._set("ATTACK_MODE", true)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SHADOW_REPLY, -1)) end
    end
    if ZG._T(ZG.PROB(ZG.ADD((ZG.P_STRENGTH * 10), 10))) then
        if ZG._T(ZG.PROB(85)) then
            ZG._set("S_STRENGTH", ZG.SUB(ZG.S_STRENGTH, 1))
            if ZG.ZERO_p(ZG.S_STRENGTH) then
                do local _ = ZG.SHADOW_DIES() end
                do return true end
            end
            do local _ = ZG.TELL(ZG.PICK_ONE(ZG.P_HITS), ZG._TK.CR) end
            do return ZG.TELL("The figure", ZG.GET(ZG.SHADOW_DIAG, ZG.S_STRENGTH), ZG._TK.CR) end
        else
            ZG._set("S_STRENGTH", ZG.SUB(ZG.S_STRENGTH, 2))
            if ZG.ZERO_p(ZG.S_STRENGTH) then
                ZG._set("S_STRENGTH", 1)
            elseif ZG.LT(ZG.S_STRENGTH, 1) then
                do local _ = ZG.SHADOW_DIES() end
                do return true end
            end
            do local _ = ZG.TELL("A sharp thrust and the hooded figure is badly wounded!", ZG._TK.CR) end
            do return ZG.TELL("The figure", ZG.GET(ZG.SHADOW_DIAG, ZG.S_STRENGTH), ZG._TK.CR) end
        end
    else
        if ZG.LT(ZG.S_STRENGTH, 2) then
            do return ZG.TELL("Your opponent blocks your attack with its sword.", ZG._TK.CR) end
        else
            do return ZG.TELL(ZG.PICK_ONE(ZG.P_MISSES), ZG._TK.CR) end
        end
    end

end, "SHADOW-ATTACK")

ZG.SHADOW_ATTACK = ZG.actions:get("SHADOW_ATTACK")

-- zil: 3actions.zil:3483  <GLOBAL P-HITS>
-- P_HITS is declared in ZilGlobal.lua

-- zil: 3actions.zil:3489  <GLOBAL P-MISSES>
-- P_MISSES is declared in ZilGlobal.lua

-- zil: 3actions.zil:3496  <GLOBAL S-HITS>
-- S_HITS is declared in ZilGlobal.lua

-- zil: 3actions.zil:3501  <ROUTINE I-SHADOW-REPLY ()>
ZG.actions:register("I_SHADOW_REPLY", function()

    if ((not ZG._T(ZG.ATTACK_MODE)) or (not ZG._T(ZG.IN_p(ZG.SHADOW, ZG.HERE)))) then
        do local _ = ZG.QUEUE(ZG.I_SHADOW_REPLY, 0) end
        ZG._set("ATTACK_MODE", false)
        do return false end
    end
    if (not ZG._T(ZG.IN_p(ZG.SWORD, ZG.WINNER))) then
        do local _ = ZG.MOVE(ZG.SWORD, ZG.WINNER) end
        do local _ = ZG.TELL("Your sword, glowing wildly, leaps into your hand!", ZG._TK.CR) end
    end
    if (ZG._T(ZG.PROB(ZG.ADD((ZG.S_STRENGTH * 10), 10))) and ZG.LT(1, ZG.S_STRENGTH)) then
        if ZG._T(ZG.PROB(90)) then
            if ZG.LT(ZG._set("P_STRENGTH", ZG.SUB(ZG.P_STRENGTH, 1)), 1) then
                ZG._set("P_STRENGTH", 1)
                do return ZG.TELL("The hooded figure swings its sword and sends yours flying to the ground.\nAlthough you are defenseless, the figure reaches for your sword and hands it\nback to you, nodding grimly.", ZG._TK.CR) end
            else
                do return ZG.TELL(ZG.PICK_ONE(ZG.S_HITS), ZG._TK.CR) end
            end
        else
            if ZG.LT(ZG._set("P_STRENGTH", ZG.SUB(ZG.P_STRENGTH, 2)), 1) then
                do return ZG.JIGS_UP("In your wounded state, you cannot defend yourself against your still-quick\nopponent. Slowly and carefully, the figure starts to remove its hood as you\nfall to the ground, dead.") end
            else
                do return ZG.TELL("A brilliant feint puts you off guard, and the hooded figure slips its\nsword between your ribs. You are hurt very badly.", ZG._TK.CR) end
            end
        end
    elseif ZG.LT(ZG.S_STRENGTH, 3) then
        do return ZG.TELL("The hooded figure attempts a thrust, but its weakened state prevents\nhitting you.", ZG._TK.CR) end
    else
        do return ZG.TELL(ZG.PICK_ONE(ZG.S_MISSES), ZG._TK.CR) end
    end

end, "I-SHADOW-REPLY")

ZG.I_SHADOW_REPLY = ZG.actions:get("I_SHADOW_REPLY")

-- zil: 3actions.zil:3537  <GLOBAL S-MISSES>
-- S_MISSES is declared in ZilGlobal.lua

-- zil: 3actions.zil:3544  <ROUTINE SHADOW-DIES ()>
ZG.actions:register("SHADOW_DIES", function()

    do local _ = ZG.TELL("The hooded figure, fatally wounded, slumps to the ground. It gazes up at\nyou once, and you catch a brief glimpse of deep and sorrowful eyes. Before\nyou can react, the figure vanishes in a cloud of fetid vapor.", ZG._TK.CR) end
    do local _ = ZG.REMOVE(ZG.SHADOW) end
    ZG._set("SHADOW_GONE", true)
    ZG._set("BLOCKED_DIR", false)
    do return ZG.BLOCKED_DIR end

end, "SHADOW-DIES")

ZG.SHADOW_DIES = ZG.actions:get("SHADOW_DIES")

-- zil: 3actions.zil:3553  <ROUTINE HOOD-F ()>
ZG.actions:register("HOOD_F", function()

    if (ZG._T(ZG.VERB_p("LOOK-UNDER")) and ZG._T(ZG.IN_p(ZG.HOOD, ZG.SHADOW))) then
        do return ZG.TELL("The figure's hood casts a dark shadow over its face. There is no way from\nwhere you stand to look beneath it.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("TAKE", "PUT")) and ZG._T(ZG.IN_p(ZG.HOOD, ZG.SHADOW))) then
        if ZG.EQ(ZG.S_STRENGTH, 1) then
            do local _ = ZG.TELL("You slowly remove the hood from your badly wounded opponent and recoil\nin horror at the sight of your own face, weary and wounded. A faint\nsmile comes to the lips and then the face starts to change, very slowly,\ninto that of an old, wizened person. The image fades and with it the body\nof your hooded opponent. The cloak remains on the ground.", ZG._TK.CR) end
            do local _ = ZG.REMOVE(ZG.SHADOW) end
            ZG._set("SHADOW_GONE", true)
            do local _ = ZG.MOVE(ZG.HOOD, ZG.WINNER) end
            do local _ = ZG.FCLEAR(ZG.HOOD, "NDESCBIT") end
            do local _ = ZG.MOVE(ZG.CLOAK, ZG.HERE) end
            do return ZG.FCLEAR(ZG.CLOAK, "NDESCBIT") end
        elseif ZG.EQ(ZG.S_STRENGTH, 2) then
            do return ZG.TELL("The hooded figure, though recovering from wounds, is strong enough to\nforce you back.", ZG._TK.CR) end
        else
            do return ZG.TELL("You cannot get close enough to the hooded figure to remove the hood.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "HOOD-F")

ZG.HOOD_F = ZG.actions:get("HOOD_F")

-- zil: 3actions.zil:3580  <ROUTINE CLOAK-F ()>
ZG.actions:register("CLOAK_F", function()

    if (ZG._T(ZG.VERB_p("LOOK-UNDER")) and ZG._T(ZG.IN_p(ZG.CLOAK, ZG.SHADOW))) then
        do return ZG.TELL("You cannot get close enough to look underneath the cloak.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG._T(ZG.IN_p(ZG.CLOAK, ZG.SHADOW))) then
        do return ZG.TELL("The cloak is fastened around the neck of the hooded figure. It would be\ndifficult to remove.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CLOAK-F")

ZG.CLOAK_F = ZG.actions:get("CLOAK_F")

-- zil: 3actions.zil:3589  <GLOBAL BLOCKED-DIR>
-- BLOCKED_DIR is declared in ZilGlobal.lua

-- zil: 3actions.zil:3591  <ROUTINE SHADOW-ROOMS (RARG)>
ZG.actions:register("SHADOW_ROOMS", function(RARG)

    if (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("WALK")) and ZG.EQ(ZG.PRSO, ZG.BLOCKED_DIR)) then
        do return ZG.TELL("Your way is blocked by the hooded figure.", ZG._TK.CR) end
    elseif ZG.EQ(RARG, ZG.M_END) then
        if (not ZG._T(ZG.IN_p(ZG.SHADOW, ZG.HERE))) then
            ZG._set("BLOCKED_DIR", false)
            do local _ = ZG.REMOVE(ZG.SHADOW) end
        end
        if ZG._T(ZG.SHADOW_GONE) then
            do return false end
        elseif ZG._T(ZG.IN_p(ZG.SHADOW, ZG.HERE)) then
            if (ZG._T(ZG.PROB(30)) and (not ZG._T(ZG.ATTACK_MODE))) then
                ZG._set("ATTACK_MODE", true)
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CURE, 10)) end
                do return ZG.ENABLE(ZG.QUEUE(ZG.I_SHADOW_REPLY, -1)) end
            else
                do return false end
            end
        elseif ZG._T(ZG.PROB(30)) then
            do return ZG.TELL("You can hear quiet footsteps nearby.", ZG._TK.CR) end
        elseif (ZG._T(ZG.PROB(30)) and ZG._T(ZG.LIT) and ZG.LT(3, ZG.S_STRENGTH)) then
            ZG._set("BLOCKED_DIR", ZG.PICK_DIRECTION(ZG.HERE))
            do local _ = ZG.TELL("Through the shadows, a cloaked and hooded figure appears before you,\nblocking the ") end
            do local _ = ZG.TELL(ZG.LKP(ZG.BLOCKED_DIR, ZG.DIRS), "ern exit from the room and carrying a\nbrightly glowing sword.", ZG._TK.CR) end
            do local _ = ZG.SHADOW_ARRIVAL() end
            do return true end
        else
            do return false end
        end
    else
        do return false end
    end

end, "SHADOW-ROOMS")

ZG.SHADOW_ROOMS = ZG.actions:get("SHADOW_ROOMS")

-- zil: 3actions.zil:3620  <ROUTINE SHADOW-ARRIVAL ()>
ZG.actions:register("SHADOW_ARRIVAL", function()

    do local _ = ZG.MOVE(ZG.SHADOW, ZG.HERE) end
    if (not ZG._T(ZG.SHADOW_POINT_1)) then
        ZG._set("SCORE", ZG.ADD(ZG.SCORE, 1))
        ZG._set("SHADOW_POINT_1", true)
    end
    if (not ZG._T(ZG.IN_p(ZG.SWORD, ZG.WINNER))) then
        do local _ = ZG.MOVE(ZG.SWORD, ZG.WINNER) end
        if ZG._T(ZG.SWORD_IN_STONE_p) then
            do local _ = ZG.TELL("From nowhere, the sword from the junction appears in your hand, wildly\nglowing!", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("Your sword, glowing wildly, appears in your hand!", ZG._TK.CR) end
        end
        ZG._set("SWORD_IN_STONE_p", false)
        do return ZG.SWORD_IN_STONE_p end
    else
        do return false end
    end

end, "SHADOW-ARRIVAL")

ZG.SHADOW_ARRIVAL = ZG.actions:get("SHADOW_ARRIVAL")

-- zil: 3actions.zil:3636  <GLOBAL SHADOW-POINT-1>
-- SHADOW_POINT_1 is declared in ZilGlobal.lua

-- zil: 3actions.zil:3637  <GLOBAL SHADOW-POINT-2>
-- SHADOW_POINT_2 is declared in ZilGlobal.lua

-- zil: 3actions.zil:3639  <ROUTINE CREEPY-CRAWL-F (RARG)>
ZG.actions:register("CREEPY_CRAWL_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_END) then
        ZG._set("BLOCKED_DIR", false)
        do return true end
    else
        do return false end
    end

end, "CREEPY-CRAWL-F")

ZG.CREEPY_CRAWL_F = ZG.actions:get("CREEPY_CRAWL_F")

-- ;" Cooperative Problem"

-- zil: 3actions.zil:3646  <ROOM ZORK2-STAIR>
ZG._declare("ZORK2_STAIR", function() return ZG._declare_object("ZORK2-STAIR", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Endless Stair",
    ["LDESC"] = "You are at the bottom of a seemingly endless stair, winding its way\nupward beyond your vision. An eerie light, coming from all around you,\ncasts strange shadows on the walls. To the south is a dark and winding\ntrail.",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["NORTH"] = "The stairs are endless.",
    ["UP"] = "The stairs are endless.",
    ["SOUTH"] = {"TO", ZG.JUNCTION},
    ["GLOBAL"] = ZG.STAIRS,
} end) end, true)

-- zil: 3actions.zil:3660  <ROOM JUNCTION>
ZG._declare("JUNCTION", function() return ZG._declare_object("JUNCTION", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Junction",
    ["LDESC"] = "You are at the junction of a north-south passage and an east-west\npassage. To the north, you can make out the bottom of a stairway. The\nways to the east and south are relatively cramped, but a wider trail\nleads to the west.",
    ["FLAGS"] = "RLANDBIT",
    ["WEST"] = {"TO", ZG.CLEARING},
    ["NORTH"] = {"TO", ZG.ZORK2_STAIR},
    ["SOUTH"] = {"TO", ZG.CREEPY_CRAWL},
    ["EAST"] = {"TO", ZG.DAMP_PASSAGE},
} end) end, true)

-- zil: 3actions.zil:3674  <ROOM CLEARING>
ZG._declare("CLEARING", function() return ZG._declare_object("CLEARING", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Barren Area",
    ["LDESC"] = "You are west of the junction, where the rock-bound passage widens out\ninto a large, flat area. Although the land here is barren, you can see\nvegetation to the west. South of here is a mighty wall of stone, ancient\nand crumbling. To the southwest the wall has decayed enough to form an\nopening, through which seeps a thin mist. A trail dips sharply into\nrocky terrain to the northwest.",
    ["FLAGS"] = "RLANDBIT",
    ["SW"] = {"TO", ZG.SHADOW_2},
    ["NW"] = {"TO", ZG.SLOPE},
    ["SOUTH"] = "A stone wall blocks your way.",
    ["SE"] = "A stone wall blocks your way.",
    ["WEST"] = {"TO", ZG.CLIFF},
    ["EAST"] = {"TO", ZG.JUNCTION},
    ["GLOBAL"] = {ZG.RUBBLE, ZG.STONE_WALL},
    ["PSEUDO"] = {"MIST", ZG.MIST_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:3694  <ROOM SLOPE>
ZG._declare("SLOPE", function() return ZG._declare_object("SLOPE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Hairpin Loop",
    ["LDESC"] = "You are at a sharp turn on a narrow and steeply sloping path, strewn\nwith boulders of various sizes. The path climbs sharply toward a\ndesolate plain to the southeast. Southwest of here the path winds down\nto the base of a cliff.",
    ["SE"] = {"TO", ZG.CLEARING},
    ["UP"] = {"TO", ZG.CLEARING},
    ["SW"] = {"TO", ZG.CLIFF_BASE},
    ["DOWN"] = {"TO", ZG.CLIFF_BASE},
    ["GLOBAL"] = ZG.RUBBLE,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:3709  <ROOM CLIFF-BASE>
ZG._declare("CLIFF_BASE", function() return ZG._declare_object("CLIFF-BASE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Cliff Base",
    ["LDESC"] = "You are at the base of a steep cliff. Directly above you is a wide\nledge and far above that some natural sunlight can be seen. To the\nnortheast is a steeply climbing path and the ground becomes sandy toward\nthe south.",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["UP"] = "You can't get up the rock face.",
    ["SOUTH"] = {"TO", ZG.FLATHEAD_OCEAN},
    ["NE"] = {"TO", ZG.SLOPE},
    ["ACTION"] = ZG.CLIFF_BASE_F,
    ["GLOBAL"] = ZG.LEDGE,
} end) end, true)

-- zil: 3actions.zil:3724  <ROOM CLIFF>
ZG._declare("CLIFF", function() return ZG._declare_object("CLIFF", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Cliff",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["DOWN"] = {"TO", ZG.CLIFF_LEDGE, "IF", "ROPE_FLAG", "ELSE", "The drop would kill you."},
    ["UP"] = "There's no tree here suitable for climbing.",
    ["SW"] = {"TO", ZG.SHADOW_8},
    ["EAST"] = {"TO", ZG.CLEARING},
    ["ACTION"] = ZG.CLIFF_F,
    ["GLOBAL"] = {ZG.GLOBAL_MAN, ZG.RUBBLE, ZG.STONE_WALL, ZG.CLIFF_OBJECT},
    ["PSEUDO"] = {"MIST", ZG.MIST_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:3736  <ROOM CLIFF-LEDGE>
ZG._declare("CLIFF_LEDGE", function() return ZG._declare_object("CLIFF-LEDGE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Cliff Ledge",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["UP"] = "You attempt the climb but slide back down.",
    ["DOWN"] = {"TO", ZG.CLIFF_BASE},
    ["ACTION"] = ZG.CLIFF_LEDGE_F,
    ["GLOBAL"] = {ZG.RUBBLE, ZG.GLOBAL_ROPE, ZG.GLOBAL_MAN, ZG.LEDGE, ZG.CLIFF_OBJECT},
} end) end, true)

-- zil: 3actions.zil:3745  <ROOM FOGGY-ROOM>
ZG._declare("FOGGY_ROOM", function() return ZG._declare_object("FOGGY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Foggy Room",
    ["LDESC"] = "You are in a dank passage filled with a wispy fog. A spooky passageway\nleads north and a wider path heads off to the south. To the west, the\npath leaves the rock and enters an eerie, shadowy land.",
    ["NORTH"] = {"TO", ZG.CREEPY_CRAWL},
    ["SOUTH"] = {"TO", ZG.LAKE_SHORE},
    ["WEST"] = {"TO", ZG.SHADOW_1},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:3757  <ROOM LAKE-SHORE>
ZG._declare("LAKE_SHORE", function() return ZG._declare_object("LAKE-SHORE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Lake Shore",
    ["LDESC"] = "You are in a wide cavern on the north shore of a small lake. Some\npolished stone steps lead to the southeast and a sheer rock face\nprevents any movement around the lake to the southwest. The cavern is\ndimly lit from above.",
    ["SE"] = {"TO", ZG.AQ_VIEW},
    ["DOWN"] = {"TO", ZG.AQ_VIEW},
    ["SOUTH"] = "If you really want to enter the lake, you should say so.",
    ["SW"] = "The sheer rock face prevents movement along the lake shore.",
    ["NORTH"] = {"TO", ZG.FOGGY_ROOM},
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["GLOBAL"] = {ZG.LAKE, ZG.STAIRS},
    ["PSEUDO"] = {"SHORE", ZG.SHORE_PSEUDO, "BEACH", ZG.SHORE_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:3774  <ROOM AQ-VIEW>
ZG._declare("AQ_VIEW", function() return ZG._declare_object("AQ-VIEW", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Aqueduct View",
    ["LDESC"] = "This is a small balcony carved into a near-vertical cliff. To the east,\nstretching from north to south, stands a monumental aqueduct supported by\nmighty stone pillars, some of which are starting to crumble from age. You\nfeel a sense of loss and sadness as you ponder this once-proud structure and\nthe failure of the Empire which created this and other engineering marvels.\nSome stone steps lead up to the northwest.",
    ["NW"] = {"TO", ZG.LAKE_SHORE},
    ["UP"] = {"TO", ZG.LAKE_SHORE},
    ["DOWN"] = "The drop would be fatal.",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.AQUEDUCT, ZG.STAIRS},
} end) end, true)

-- zil: 3actions.zil:3790  <ROOM ON-LAKE>
ZG._declare("ON_LAKE", function() return ZG._declare_object("ON-LAKE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "On the Lake",
    ["LDESC"] = "You are floating on the surface of the lake. The water is ice cold and\nyour ability to survive here for long is very questionable. A swim north\nputs you at your starting point. Conditions to the east are poor where\nthe lake turns into swamp. The west and south shores are suitable for\nwalking, however.",
    ["NORTH"] = {"TO", ZG.LAKE_SHORE},
    ["SOUTH"] = {"TO", ZG.SOUTH_SHORE},
    ["PSEUDO"] = {"SWAMP", ZG.SWAMP_PSEUDO},
    ["SE"] = "The swamp is impassable.",
    ["EAST"] = "The swamp is impassable.",
    ["NE"] = "The swamp is impassable.",
    ["WEST"] = {"TO", ZG.FAR_SHORE},
    ["NW"] = {"TO", ZG.FAR_SHORE},
    ["SW"] = {"TO", ZG.SOUTH_SHORE},
    ["DOWN"] = {"TO", ZG.IN_LAKE},
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.ON_LAKE_F,
    ["GLOBAL"] = {ZG.LAKE, ZG.FISH},
} end) end, true)

-- zil: 3actions.zil:3813  <ROOM IN-LAKE>
ZG._declare("IN_LAKE", function() return ZG._declare_object("IN-LAKE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Underwater",
    ["LDESC"] = "You are below the surface of the lake. It turns out that the lake is quite\nshallow and the bottom is only a few feet below you. Considering the frigid\ntemperature of the water, you should probably not plan an extended stay.\nThe lake bottom is sandy and a few hearty plants and algae live there.",
    ["UP"] = {"TO", ZG.ON_LAKE},
    ["DOWN"] = "You are already at the bottom of the lake.",
    ["NORTH"] = {"TO", ZG.IN_LAKE},
    ["SOUTH"] = {"TO", ZG.IN_LAKE},
    ["EAST"] = {"TO", ZG.IN_LAKE},
    ["WEST"] = {"TO", ZG.IN_LAKE},
    ["NE"] = {"TO", ZG.IN_LAKE},
    ["NW"] = {"TO", ZG.IN_LAKE},
    ["SE"] = {"TO", ZG.IN_LAKE},
    ["SW"] = {"TO", ZG.IN_LAKE},
    ["FLAGS"] = {"RLANDBIT", "NONLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.IN_LAKE_F,
    ["GLOBAL"] = {ZG.LAKE, ZG.FISH},
} end) end, true)

-- zil: 3actions.zil:3835  <ROOM FAR-SHORE>
ZG._declare("FAR_SHORE", function() return ZG._declare_object("FAR-SHORE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Western Shore",
    ["LDESC"] = "You are on the western shore of the lake. The ground here is quite\nhard, but a few sickly reeds manage to grow near the water's edge. The\nonly path leads into the rock to the south.",
    ["EAST"] = "If you want to enter the lake, you should say so.",
    ["SOUTH"] = {"TO", ZG.VIEW_ROOM},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.LAKE,
    ["PSEUDO"] = {"SHORE", ZG.SHORE_PSEUDO, "BEACH", ZG.SHORE_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:3848  <OBJECT REEDS>
ZG._declare("REEDS", function() return ZG._declare_object("REEDS", function() return {
    ["LOC"] = ZG.FAR_SHORE,
    ["SYNONYM"] = "REEDS",
    ["ADJECTIVE"] = "SICKLY",
    ["DESC"] = "reeds",
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3actions.zil:3855  <ROOM VIEW-ROOM>
ZG._declare("VIEW_ROOM", function() return ZG._declare_object("VIEW-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Scenic Vista",
    ["LDESC"] = "",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["NORTH"] = {"TO", ZG.FAR_SHORE},
    ["ACTION"] = ZG.VIEW_ROOM_F,
} end) end, true)

-- zil: 3actions.zil:3863  <OBJECT VIEWING-TABLE>
ZG._declare("VIEWING_TABLE", function() return ZG._declare_object("VIEWING-TABLE", function() return {
    ["LOC"] = ZG.VIEW_ROOM,
    ["DESC"] = "viewing table",
    ["SYNONYM"] = {"TABLE", "SURFACE"},
    ["ADJECTIVE"] = "VIEWING",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.VIEWING_TABLE_F,
} end) end, true)

-- zil: 3actions.zil:3871  <OBJECT TORCH>
ZG._declare("TORCH", function() return ZG._declare_object("TORCH", function() return {
    ["LOC"] = ZG.VIEW_ROOM,
    ["DESC"] = "torch",
    ["FDESC"] = "Mounted on one wall is a flaming torch, which fills the room with a flickering\nlight.",
    ["SYNONYM"] = "TORCH",
    ["FLAGS"] = {"LIGHTBIT", "TAKEBIT", "ONBIT", "FLAMEBIT"},
    ["ACTION"] = ZG.TORCH_F,
} end) end, true)

-- zil: 3actions.zil:3881  <OBJECT FRIED-TORCH>
ZG._declare("FRIED_TORCH", function() return ZG._declare_object("FRIED-TORCH", function() return {
    ["DESC"] = "burned-out torch",
    ["SYNONYM"] = "TORCH",
    ["ADJECTIVE"] = {"BURNED", "DEAD"},
    ["FLAGS"] = "TAKEBIT",
    ["ACTION"] = ZG.FRIED_TORCH_F,
} end) end, true)

-- zil: 3actions.zil:3888  <OBJECT CLIFF-OBJECT>
ZG._declare("CLIFF_OBJECT", function() return ZG._declare_object("CLIFF-OBJECT", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "cliff",
    ["SYNONYM"] = "CLIFF",
    ["ACTION"] = ZG.CLIFF_OBJECT_F,
} end) end, true)

-- zil: 3actions.zil:3894  <OBJECT STONE-WALL>
ZG._declare("STONE_WALL", function() return ZG._declare_object("STONE-WALL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "stone wall",
    ["SYNONYM"] = "WALL",
    ["ADJECTIVE"] = {"STONE", "MASSIVE"},
    ["FLAGS"] = "NDESCBIT",
} end) end, true)

-- zil: 3actions.zil:3901  <OBJECT LAKE>
ZG._declare("LAKE", function() return ZG._declare_object("LAKE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "lake",
    ["SYNONYM"] = {"LAKE", "WATER", "SURFACE"},
    ["ACTION"] = ZG.LAKE_F,
} end) end, true)

-- zil: 3actions.zil:3907  <OBJECT AMULET>
ZG._declare("AMULET", function() return ZG._declare_object("AMULET", function() return {
    ["DESC"] = "golden amulet",
    ["SYNONYM"] = {"AMULET", "OBJECT"},
    ["ADJECTIVE"] = {"GOLD", "GOLDEN", "SHINY"},
    ["FLAGS"] = {"TAKEBIT", "WEARBIT", "NDESCBIT"},
} end) end, true)

-- zil: 3actions.zil:3913  <OBJECT SAND>
ZG._declare("SAND", function() return ZG._declare_object("SAND", function() return {
    ["LOC"] = ZG.IN_LAKE,
    ["DESC"] = "sand",
    ["SYNONYM"] = {"SAND", "FLOOR", "BOTTOM"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.SAND_F,
} end) end, true)

-- zil: 3actions.zil:3920  <OBJECT FRIED-LAMP>
ZG._declare("FRIED_LAMP", function() return ZG._declare_object("FRIED-LAMP", function() return {
    ["DESC"] = "lamp",
    ["SYNONYM"] = {"LAMP", "LANTERN"},
    ["ADJECTIVE"] = "BRASS",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 10,
    ["ACTION"] = ZG.FRIED_LAMP_F,
} end) end, true)

-- zil: 3actions.zil:3928  <OBJECT ALGAE>
ZG._declare("ALGAE", function() return ZG._declare_object("ALGAE", function() return {
    ["LOC"] = ZG.IN_LAKE,
    ["DESC"] = "plants and algae",
    ["SYNONYM"] = {"PLANT", "PLANTS", "ALGAE"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.ALGAE_F,
} end) end, true)

-- zil: 3actions.zil:3935  <OBJECT SHINY-OBJECT>
ZG._declare("SHINY_OBJECT", function() return ZG._declare_object("SHINY-OBJECT", function() return {
    ["LOC"] = ZG.IN_LAKE,
    ["DESC"] = "shiny object",
    ["SYNONYM"] = {"OBJECT", "AMULET"},
    ["ADJECTIVE"] = "SHINY",
    ["FLAGS"] = {"TRYTAKEBIT", "NDESCBIT"},
    ["ACTION"] = ZG.SHINY_OBJECT_F,
} end) end, true)

-- zil: 3actions.zil:3943  <OBJECT LEDGE>
ZG._declare("LEDGE", function() return ZG._declare_object("LEDGE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "ledge",
    ["SYNONYM"] = "LEDGE",
    ["ADJECTIVE"] = "WIDE",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.LEDGE_F,
} end) end, true)

-- zil: 3actions.zil:3951  <ROUTINE LEDGE-F ()>
ZG.actions:register("LEDGE_F", function()

    if (ZG.EQ(ZG.HERE, ZG.CLIFF_LEDGE) and ZG._T(ZG.VERB_p("THROW-OFF")) and ZG.EQ(ZG.PRSI, ZG.LEDGE)) then
        if (not ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) then
            do local _ = ZG.TELL("You're not holding that!", ZG._TK.CR) end
            do return true end
        end
        do local _ = ZG.MOVE(ZG.PRSO, ZG.CLIFF_BASE) end
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " falls to the base of the cliff below.", ZG._TK.CR) end
    else
        do return false end
    end

end, "LEDGE-F")

ZG.LEDGE_F = ZG.actions:get("LEDGE_F")

-- zil: 3actions.zil:3962  <OBJECT WAYBREAD>
ZG._declare("WAYBREAD", function() return ZG._declare_object("WAYBREAD", function() return {
    ["LOC"] = ZG.CLIFF,
    ["DESC"] = "piece of waybread",
    ["LDESC"] = "A piece of bread is on the ground here.",
    ["FDESC"] = "It seems as if somebody has been here recently, as there is some fresh\nbread lying beneath one of the other trees.",
    ["SYNONYM"] = {"BREAD", "WAYBREAD", "PIECE"},
    ["ADJECTIVE"] = {"WAY", "FRESH"},
    ["FLAGS"] = {"TAKEBIT", "FOODBIT"},
    ["SIZE"] = 3,
    ["ACTION"] = ZG.WAYBREAD_F,
} end) end, true)

-- zil: 3actions.zil:3975  <ROUTINE WAYBREAD-F ()>
ZG.actions:register("WAYBREAD_F", function()

    if (ZG._T(ZG.VERB_p("CUT")) and ZG.EQ(ZG.PRSI, ZG.SWORD)) then
        do local _ = ZG.TELL("The bread is crushed rather than cut by your sword, and the crumbs scatter to\nthe wind.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.WAYBREAD) end
    else
        do return false end
    end

end, "WAYBREAD-F")

ZG.WAYBREAD_F = ZG.actions:get("WAYBREAD_F")

-- zil: 3actions.zil:3982  <OBJECT ROPE>
ZG._declare("ROPE", function() return ZG._declare_object("ROPE", function() return {
    ["LOC"] = ZG.CLIFF,
    ["DESC"] = "rope",
    ["SYNONYM"] = "ROPE",
    ["ADJECTIVE"] = "LONG",
    ["FLAGS"] = {"NDESCBIT", "TRYTAKEBIT"},
    ["ACTION"] = ZG.ROPE_F,
} end) end, true)

-- zil: 3actions.zil:3990  <OBJECT GLOBAL-ROPE>
ZG._declare("GLOBAL_ROPE", function() return ZG._declare_object("GLOBAL-ROPE", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "rope",
    ["SYNONYM"] = "ROPE",
    ["ADJECTIVE"] = "DANGLING",
    ["ACTION"] = ZG.GLOBAL_ROPE_F,
} end) end, true)

-- zil: 3actions.zil:3997  <OBJECT TREE>
ZG._declare("TREE", function() return ZG._declare_object("TREE", function() return {
    ["LOC"] = ZG.CLIFF,
    ["DESC"] = "tree",
    ["SYNONYM"] = {"TREE", "TREES"},
    ["ADJECTIVE"] = {"LARGE", "TALL"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.TREE_F,
} end) end, true)

-- zil: 3actions.zil:4005  <OBJECT STAFF>
ZG._declare("STAFF", function() return ZG._declare_object("STAFF", function() return {
    ["DESC"] = "wooden staff",
    ["SYNONYM"] = "STAFF",
    ["ADJECTIVE"] = "WOODEN",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 10,
    ["ACTION"] = ZG.STAFF_F,
} end) end, true)

-- zil: 3actions.zil:4013  <OBJECT BROKEN-STAFF>
ZG._declare("BROKEN_STAFF", function() return ZG._declare_object("BROKEN-STAFF", function() return {
    ["DESC"] = "broken staff",
    ["SYNONYM"] = "STAFF",
    ["ADJECTIVE"] = "BROKEN",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 10,
    ["ACTION"] = ZG.STAFF_F,
} end) end, true)

-- zil: 3actions.zil:4021  <ROUTINE STAFF-F ()>
ZG.actions:register("STAFF_F", function()

    if (ZG._T(ZG.VERB_p("BURN")) and ZG.EQ(ZG.PRSI, ZG.TORCH)) then
        do local _ = ZG.REMOVE(ZG.PRSO) end
        do return ZG.JIGS_UP("The staff is instantly consumed in a ball of flame. You along with it.") end
    else
        do return false end
    end

end, "STAFF-F")

ZG.STAFF_F = ZG.actions:get("STAFF_F")

-- zil: 3actions.zil:4027  <OBJECT CHEST>
ZG._declare("CHEST", function() return ZG._declare_object("CHEST", function() return {
    ["LOC"] = ZG.CLIFF_LEDGE,
    ["DESC"] = "chest",
    ["FDESC"] = "A large chest, closed and locked, is lying among the boulders.",
    ["SYNONYM"] = "CHEST",
    ["ADJECTIVE"] = "LOCKED",
    ["FLAGS"] = {"TAKEBIT", "CONTBIT"},
    ["SIZE"] = 40,
    ["CAPACITY"] = 20,
    ["ACTION"] = ZG.CHEST_F,
} end) end, true)

-- zil: 3actions.zil:4039  <OBJECT GLOBAL-MAN>
ZG._declare("GLOBAL_MAN", function() return ZG._declare_object("GLOBAL-MAN", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "man",
    ["SYNONYM"] = {"MAN", "FRIEND"},
    ["FLAGS"] = "ACTORBIT",
    ["ACTION"] = ZG.GLOBAL_MAN_F,
} end) end, true)

-- zil: 3actions.zil:4046  <OBJECT VALUABLES>
ZG._declare("VALUABLES", function() return ZG._declare_object("VALUABLES", function() return {
    ["LOC"] = ZG.MAN,
    ["DESC"] = "pile of assorted valuables",
    ["SYNONYM"] = {"VALUABLES", "TREASURE", "PILE"},
    ["ADJECTIVE"] = "ASSORTED",
    ["FLAGS"] = {"NDESCBIT", "TAKEBIT"},
    ["ACTION"] = ZG.VALUABLES_F,
} end) end, true)

-- zil: 3actions.zil:4054  <OBJECT MAN>
ZG._declare("MAN", function() return ZG._declare_object("MAN", function() return {
    ["SYNONYM"] = {"MAN", "FRIEND"},
    ["DESC"] = "man",
    ["FLAGS"] = {"ACTORBIT", "OPENBIT", "CONTBIT"},
    ["ACTION"] = ZG.MAN_F,
} end) end, true)

-- zil: 3actions.zil:4060  <GLOBAL CHEST-LIFTED>
-- CHEST_LIFTED is declared in ZilGlobal.lua

-- zil: 3actions.zil:4062  <ROUTINE I-MAN-APPEARS ()>
ZG.actions:register("I_MAN_APPEARS", function()

    if ((not ZG.EQ(ZG.HERE, ZG.CLIFF_LEDGE)) or (not ZG.EQUAL_p(ZG.LOC(ZG.CHEST), ZG.CLIFF_LEDGE, ZG.WINNER))) then
        do return false end
    elseif ZG._T(ZG.CHEST_TIED) then
        ZG._set("MAN_SEEN", true)
        do local _ = ZG.TELL("All at once, the chest is lifted from you. Looking up, you see a\nman at the top of the cliff, pulling intently at the rope. \"That is\nuncommonly good of you, I do say!\" He chuckles unpleasantly. \"Oh,\nyou are stuck, aren't you. Well, I'll be right back to get you!\"\nHe leaves your sight.", ZG._TK.CR) end
        ZG._set("CHEST_LIFTED", true)
        do local _ = ZG.MOVE(ZG.CHEST, ZG.MAN) end
        do local _ = ZG.FSET(ZG.CHEST, "TOUCHBIT") end
        ZG._set("ROPE_FLAG", false)
        ZG._set("CHEST_TIED", false)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MAN_RETURNS, 10)) end
        do return true end
    else
        do local _ = ZG.TELL("At the edge of the cliff above you, a man appears. He looks down at\nyou and speaks. \"Hello, down there! You seem to have a problem. Maybe I\ncan help you.\" He chuckles in an unsettling sort of way. \"Perhaps if you\ntied that chest to the end of the rope I might be able to drag it up for you.\nThen, I'll be more than happy to help you up!\" He laughs again.", ZG._TK.CR) end
        ZG._set("MAN_FLAG", true)
        ZG._set("MAN_SEEN", true)
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_MAN_PRESENT, -1)) end
    end

end, "I-MAN-APPEARS")

ZG.I_MAN_APPEARS = ZG.actions:get("I_MAN_APPEARS")

-- zil: 3actions.zil:4092  <GLOBAL MAN-SEEN>
-- MAN_SEEN is declared in ZilGlobal.lua

-- zil: 3actions.zil:4094  <ROUTINE I-MAN-PRESENT ()>
ZG.actions:register("I_MAN_PRESENT", function()

    if ((not ZG.EQ(ZG.HERE, ZG.CLIFF_LEDGE)) or (not ZG._T(ZG.MAN_FLAG)) or ZG._T(ZG.IN_p(ZG.CHEST, ZG.MAN))) then
        do local _ = ZG.QUEUE(ZG.I_MAN_PRESENT, 0) end
        ZG._set("MAN_FLAG", false)
        do return false end
    elseif ZG.LT(10, ZG._set("MAN_WAITING", ZG.ADD(ZG.MAN_WAITING, 1))) then
        do local _ = ZG.TELL("The man looks quite displeased. \"All right, then. I guess someone else\ncan always help me! See you around, sport!\" He disappears.", ZG._TK.CR) end
        do local _ = ZG.QUEUE(ZG.I_MAN_PRESENT, 0) end
        ZG._set("MAN_FLAG", false)
        do return true end
    else
        do return ZG.TELL(ZG.PICK_ONE(ZG.MAN_WAITS), ZG._TK.CR) end
    end

end, "I-MAN-PRESENT")

ZG.I_MAN_PRESENT = ZG.actions:get("I_MAN_PRESENT")

-- zil: 3actions.zil:4110  <ROUTINE CLIFF-BASE-F (RARG)>
ZG.actions:register("CLIFF_BASE_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_ENTER) and ZG._T(ZG.CHEST_TIED)) then
        ZG._set("CHEST_TIED", false)
        ZG._set("ROPE_FLAG", false)
        do return ZG.QUEUE(ZG.I_MAN_APPEARS, 0) end
    else
        do return false end
    end

end, "CLIFF-BASE-F")

ZG.CLIFF_BASE_F = ZG.actions:get("CLIFF_BASE_F")

-- zil: 3actions.zil:4117  <GLOBAL MAN-WAITS>
-- MAN_WAITS is declared in ZilGlobal.lua

-- zil: 3actions.zil:4129  <GLOBAL MAN-WAITING>
-- MAN_WAITING is declared in ZilGlobal.lua

-- zil: 3actions.zil:4130  <GLOBAL MAN-FLAG>
-- MAN_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:4131  <GLOBAL MAN-POINT>
-- MAN_POINT is declared in ZilGlobal.lua

-- zil: 3actions.zil:4132  <GLOBAL MAN-GONE>
-- MAN_GONE is declared in ZilGlobal.lua

-- zil: 3actions.zil:4134  <ROUTINE CLIFF-LEDGE-F (RARG)>
ZG.actions:register("CLIFF_LEDGE_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("WALK")) and ZG._T(ZG.IN_p(ZG.CHEST, ZG.WINNER)) and ZG._T(ZG.CHEST_TIED)) then
        do return ZG.TELL("You can't go anywhere holding that chest. The rope is tied around it!", ZG._TK.CR) end
    elseif (ZG.EQ(RARG, ZG.M_ENTER) and (not ZG._T(ZG.MAN_SEEN)) and (not ZG._T(ZG.MAN_FLAG)) and (not ZG._T(ZG.MAN_GONE))) then
        if (not ZG._T(ZG.MAN_POINT)) then
            ZG._set("SCORE", ZG.ADD(ZG.SCORE, 1))
            ZG._set("MAN_POINT", true)
        end
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_MAN_APPEARS, 5)) end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a rock-strewn ledge near the base of a tall cliff. The bottom of the\ncliff is another fifteen feet below. You have little hope of climbing up the\ncliff face, but you might be able to scramble down from here (though it's\ndoubtful you could return).", ZG._TK.CR) end
        if ZG._T(ZG.ROPE_FLAG) then
            do local _ = ZG.TELL("A long piece of rope is dangling down from the top of the cliff and\nis within your reach.", ZG._TK.CR) end
        end
        do return true end
    else
        do return false end
    end

end, "CLIFF-LEDGE-F")

ZG.CLIFF_LEDGE_F = ZG.actions:get("CLIFF_LEDGE_F")

-- zil: 3actions.zil:4161  <ROUTINE CLIFF-F (RARG)>
ZG.actions:register("CLIFF_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_ENTER) and ZG._T(ZG.IN_p(ZG.CHEST, ZG.MAN))) then
        do local _ = ZG.QUEUE(ZG.I_MAN_RETURNS, 0) end
        do local _ = ZG.MOVE(ZG.CHEST, ZG.HERE) end
        do local _ = ZG.FSET(ZG.CHEST, "OPENBIT") end
        ZG._set("ROPE_FLAG", true)
        ZG._set("CHEST_TIED", false)
        ZG._set("CHEST_OPENED", true)
        do return false end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a remarkable spot in the dungeon. Perhaps two hundred feet above\nyou is a gaping hole in the earth's surface through which pours bright\nsunshine! A few seedlings from the world above, nurtured by the sunlight\nand occasional rains, have grown into giant trees, making this a virtual oasis\nin the desert of the Underground Empire. To the west is a sheer precipice,\ndropping nearly fifty feet to jagged rocks below. The way south is barred by\na forbidding stone wall, crumbling from age. There is a jagged opening in the\nwall to the southwest, through which leaks a fine mist. The land to the east\nlooks lifeless and barren.", ZG._TK.CR) end
        if ZG._T(ZG.ROPE_FLAG) then
            do local _ = ZG.TELL("A rope is tied to one of the large trees here and is dangling over\nthe side of the cliff, reaching down to the shelf below.", ZG._TK.CR) end
        end
        do return true end
    elseif (ZG.EQ(RARG, ZG.M_END) and ZG._T(ZG.PROB(15)) and (not ZG._T(ZG.FSET_p(ZG.CLIFF_LEDGE, "TOUCHBIT")))) then
        do return ZG.TELL("You catch, out of the corner of your eye, some movement among the\ntrees.", ZG._TK.CR) end
    elseif (ZG.EQ(RARG, ZG.M_END) and ZG._T(ZG.PROB(20))) then
        do return ZG.TELL("You seem to hear, from the southwest, the sounds of the sea.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CLIFF-F")

ZG.CLIFF_F = ZG.actions:get("CLIFF_F")

-- zil: 3actions.zil:4197  <ROUTINE GLOBAL-ROPE-F ()>
ZG.actions:register("GLOBAL_ROPE_F", function()

    if (not ZG._T(ZG.ROPE_FLAG)) then
        do return ZG.TELL("You can't see any rope here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CLIMB-FOO")) then
        do return ZG.V_CLIMB_UP("DOWN", true) end
    elseif ZG._T(ZG.VERB_p("TAKE", "MOVE", "CLIMB-ON")) then
        if (not ZG._T(ZG.MAN_FLAG)) then
            do return ZG.TELL("A short tug on the rope convinces you that it is securely fastened\nfrom above.", ZG._TK.CR) end
        elseif ZG._T(ZG.IN_p(ZG.CHEST, ZG.MAN)) then
            ZG._set("HOLDING_ROPE", true)
            do return ZG.TELL("You grab securely on to the rope.", ZG._TK.CR) end
        else
            do return ZG.TELL("The man scowls. \"I may help you up, but not before I have that chest.\" He\npoints to the chest near you on the ledge.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("CLIMB-UP")) then
        do return ZG.TELL("You try to climb the rope, but you cannot reach the top even with your best\neffort.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TIE")) then
        if ZG.EQUAL_p(ZG.CHEST, ZG.PRSO, ZG.PRSI) then
            do local _ = ZG.TELL("The chest is now tied to the rope.", ZG._TK.CR) end
            ZG._set("CHEST_TIED", true)
            if (ZG._T(ZG.MAN_FLAG) and (not ZG._T(ZG.MAN_GONE))) then
                do local _ = ZG.TELL("The man above you looks pleased. \"Now there's a good friend! Thank\nyou very much, indeed!\" He pulls on the rope and the chest is lifted\nto the top of the cliff and out of sight. With a short laugh, he\ndisappears. \"I'll be back in a short while!\" are his last words.", ZG._TK.CR) end
                do local _ = ZG.MOVE(ZG.CHEST, ZG.MAN) end
                do local _ = ZG.FSET(ZG.CHEST, "TOUCHBIT") end
                ZG._set("CHEST_TIED", false)
                ZG._set("ROPE_FLAG", false)
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MAN_RETURNS, 10)) end
                ZG._set("MAN_FLAG", false)
                do return true end
            end
            do return true end
        elseif ZG.EQUAL_p(ZG.ME, ZG.PRSI, ZG.PRSO) then
            if (ZG._T(ZG.MAN_FLAG) and ZG._T(ZG.IN_p(ZG.CHEST, ZG.MAN))) then
                do return ZG.TELL("\"Just grab onto it!\", the man bellows.", ZG._TK.CR) end
            elseif ZG._T(ZG.MAN_FLAG) then
                do return ZG.TELL("The man looks cross. \"I want the chest, not you!\" he snaps. \"Now stop\nfooling around and pass it up!\"", ZG._TK.CR) end
            else
                do return ZG.TELL("You're unable to tie the rope around yourself.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("You're unable to tie the rope to that.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("UNTIE")) then
        if ZG._T(ZG.CHEST_TIED) then
            ZG._set("CHEST_TIED", false)
            do return ZG.TELL("The chest is now disconnected from the rope.", ZG._TK.CR) end
        else
            do return ZG.TELL("The rope isn't tied to anything.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "GLOBAL-ROPE-F")

ZG.GLOBAL_ROPE_F = ZG.actions:get("GLOBAL_ROPE_F")

-- zil: 3actions.zil:4261  <GLOBAL CHEST-TIED>
-- CHEST_TIED is declared in ZilGlobal.lua

-- zil: 3actions.zil:4262  <GLOBAL HOLDING-ROPE>
-- HOLDING_ROPE is declared in ZilGlobal.lua

-- zil: 3actions.zil:4264  <ROUTINE I-MAN-RETURNS ()>
ZG.actions:register("I_MAN_RETURNS", function()

    ZG._set("ROPE_FLAG", true)
    if ZG.EQ(ZG.HERE, ZG.CLIFF_LEDGE) then
        do local _ = ZG.TELL("A familiar voice calls down to you. \"Are you still there?\" he bellows with a\ncoarse laugh. \"Well, then, grab onto the rope and we'll see what we can do.\"\nThe rope drops to within your reach.", ZG._TK.CR) end
        ZG._set("MAN_FLAG", true)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MAN_LIFT, -1)) end
        do return true end
    else
        do return false end
    end

end, "I-MAN-RETURNS")

ZG.I_MAN_RETURNS = ZG.actions:get("I_MAN_RETURNS")

-- zil: 3actions.zil:4275  <GLOBAL LIFT-WAIT>
-- LIFT_WAIT is declared in ZilGlobal.lua

-- zil: 3actions.zil:4277  <ROUTINE I-MAN-LIFT ()>
ZG.actions:register("I_MAN_LIFT", function()

    if (not ZG.EQ(ZG.HERE, ZG.CLIFF_LEDGE)) then
        do local _ = ZG.QUEUE(ZG.I_MAN_LIFT, 0) end
        do local _ = ZG.MOVE(ZG.CHEST, ZG.CLIFF) end
        do local _ = ZG.FSET(ZG.CHEST, "OPENBIT") end
        ZG._set("CHEST_OPENED", true)
        do local _ = ZG.REMOVE(ZG.MAN) end
        do return false end
    elseif ZG._T(ZG.HOLDING_ROPE) then
        do local _ = ZG.TELL("The man starts to heave on the rope and within a few moments you arrive at\nthe top of the cliff. The man removes the last few valuables from the chest\nand prepares to leave. \"You've been a good sport! Here, take this, for\nwhatever good it is! I can't see that I'll be needing one!\" He hands you a\nplain wooden staff from the bottom of the chest and begins examining his\nvaluables.", ZG._TK.CR) end
        do local _ = ZG.QUEUE(ZG.I_MAN_LIFT, 0) end
        do local _ = ZG.MOVE(ZG.STAFF, ZG.WINNER) end
        ZG._set("HOLDING_ROPE", false)
        ZG._set("ROPE_FLAG", true)
        do local _ = ZG.MOVE(ZG.WINNER, ZG.CLIFF) end
        do local _ = ZG.MOVE(ZG.CHEST, ZG.CLIFF) end
        do local _ = ZG.FSET(ZG.CHEST, "OPENBIT") end
        do local _ = ZG.TELL("The chest, open and empty, is at your feet.", ZG._TK.CR) end
        ZG._set("CHEST_OPENED", true)
        do local _ = ZG.MOVE(ZG.MAN, ZG.CLIFF) end
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MAN_LEAVES, -1)) end
        do return true end
    elseif ZG.LT(4, ZG._set("LIFT_WAIT", ZG.ADD(ZG.LIFT_WAIT, 1))) then
        do local _ = ZG.TELL("\"Well, I don't have all day. See you around sometime.\" Showering you with\ngravel, he disappears from sight.", ZG._TK.CR) end
        ZG._set("MAN_FLAG", false)
        do local _ = ZG.MOVE(ZG.CHEST, ZG.CLIFF) end
        do local _ = ZG.FSET(ZG.CHEST, "OPENBIT") end
        ZG._set("CHEST_OPENED", true)
        do return ZG.QUEUE(ZG.I_MAN_LIFT, 0) end
    else
        do return ZG.TELL("The man appears impatient. \"Are you coming up then, or not?\"", ZG._TK.CR) end
    end

end, "I-MAN-LIFT")

ZG.I_MAN_LIFT = ZG.actions:get("I_MAN_LIFT")

-- zil: 3actions.zil:4319  <GLOBAL CHEST-OPENED>
-- CHEST_OPENED is declared in ZilGlobal.lua

-- zil: 3actions.zil:4321  <ROUTINE CHEST-F ()>
ZG.actions:register("CHEST_F", function()

    if ZG._T(ZG.CHEST_OPENED) then
        if (ZG._T(ZG.VERB_p("TIE")) and ZG.EQUAL_p(ZG.ROPE, ZG.PRSO, ZG.PRSI)) then
            do return ZG.TELL("What's the point?", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQUAL_p(ZG.PRSO, ZG.STAFF, ZG.LAMP, ZG.TORCH)) then
            do local _ = ZG.TELL("It doesn't fit.") end
            if ZG.EQ(ZG.PRSO, ZG.STAFF) then
                do local _ = ZG.TELL(" Awfully peculiar, though, since it's where the staff came from.") end
            end
            do return ZG.CRLF() end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("OPEN", "UNLOCK")) then
        if ZG._T(ZG.MAN_FLAG) then
            do return ZG.TELL("The man calls down to you. \"Is this what you're looking for?\" he cackles,\nwaving a small key over his head. You try to open the chest, but it is\nlocked.", ZG._TK.CR) end
        else
            do return ZG.TELL("The chest is locked and cannot be opened.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "CHEST-F")

ZG.CHEST_F = ZG.actions:get("CHEST_F")

-- zil: 3actions.zil:4342  <GLOBAL ROPE-FLAG>
-- ROPE_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:4344  <ROUTINE I-MAN-LEAVES ()>
ZG.actions:register("I_MAN_LEAVES", function()

    if (not ZG.EQ(ZG.HERE, ZG.CLIFF)) then
        do local _ = ZG.REMOVE(ZG.MAN) end
        ZG._set("MAN_GONE", true)
        ZG._set("MAN_FLAG", false)
        ZG._set("ROPE_FLAG", true)
        do local _ = ZG.QUEUE(ZG.I_MAN_LEAVES, 0) end
        do return false end
    elseif ZG._T(ZG.PROB(40)) then
        do local _ = ZG.TELL("Your \"friend\", moving quickly, dodges behind some trees and is lost from\nsight.", ZG._TK.CR) end
        do local _ = ZG.REMOVE(ZG.MAN) end
        ZG._set("MAN_FLAG", false)
        ZG._set("MAN_GONE", true)
        ZG._set("ROPE_FLAG", true)
        do local _ = ZG.QUEUE(ZG.I_MAN_LEAVES, 0) end
        do return true end
    else
        do return ZG.TELL("Your \"friend\" examines his valuables with great pride.", ZG._TK.CR) end
    end

end, "I-MAN-LEAVES")

ZG.I_MAN_LEAVES = ZG.actions:get("I_MAN_LEAVES")

-- zil: 3actions.zil:4366  <ROUTINE MAN-F ()>
ZG.actions:register("MAN_F", function()

    if ZG._T(ZG.VERB_p("HELLO")) then
        do return ZG.TELL("He responds cheerfully. \"It is a wonderful day, isn't it?\"", ZG._TK.CR) end
    elseif ZG._T(ZG.HELLO_p(ZG.MAN)) then
        do return ZG.TELL("The man is thoroughly engrossed in the examination of his booty and\ndoesn't seem to hear you.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The man is stocky and of medium height, with several days' growth of stubble\non his face. He is carrying a number of valuables under his arm, presumably\nfrom the now-open chest.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("ATTACK")) then
        if ZG.EQ(ZG.PRSI, ZG.SWORD) then
            do local _ = ZG.TELL("The man is taken by surprise and is hit with the sword. He grabs you\nand throws you to the ground") end
            if ZG.EQUAL_p(ZG.LOC(ZG.STAFF), ZG.WINNER, ZG.HERE) then
                do local _ = ZG.TELL(", breaking the staff in the process") end
                do local _ = ZG.REMOVE(ZG.STAFF) end
                do local _ = ZG.MOVE(ZG.BROKEN_STAFF, ZG.HERE) end
            end
            do local _ = ZG.TELL(", but you\nfinish him off with a quick thrust to the chest. He dies, and disappears\nwithout ceremony in the usual style of the Great Underground Empire.\nHis assorted valuables remain behind.", ZG._TK.CR) end
            do local _ = ZG.REMOVE(ZG.MAN) end
            do local _ = ZG.MOVE(ZG.VALUABLES, ZG.HERE) end
            do local _ = ZG.FCLEAR(ZG.VALUABLES, "NDESCBIT") end
            do local _ = ZG.QUEUE(ZG.I_MAN_LEAVES, 0) end
            ZG._set("MAN_GONE", true)
            do return ZG.MAN_GONE end
        else
            do return ZG.TELL("You wouldn't hurt him with that!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "MAN-F")

ZG.MAN_F = ZG.actions:get("MAN_F")

-- zil: 3actions.zil:4399  <ROUTINE VALUABLES-F ()>
ZG.actions:register("VALUABLES_F", function()

    if (ZG._T(ZG.VERB_p("TAKE", "PUT", "MOVE")) and ZG._T(ZG.IN_p(ZG.MAN, ZG.CLIFF))) then
        do return ZG.TELL("The man recoils sharply. \"These here things are mine. It's my chest and\nthey're my valuables. You've a lot of nerve trying to take them from me\nafter me saving you like that!\"", ZG._TK.CR) end
    elseif (ZG._T(ZG.MAN_GONE) and ZG._T(ZG.IN_p(ZG.VALUABLES, ZG.MAN))) then
        do return ZG.TELL("What valuables?", ZG._TK.CR) end
    else
        do return false end
    end

end, "VALUABLES-F")

ZG.VALUABLES_F = ZG.actions:get("VALUABLES_F")

-- zil: 3actions.zil:4409  <ROUTINE ROPE-F ()>
ZG.actions:register("ROPE_F", function()

    if ZG._T(ZG.VERB_p("TAKE", "MOVE")) then
        if ZG._T(ZG.ROPE_FLAG) then
            do return ZG.TELL("The rope is tied to a tree.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("CLIMB-FOO")) then
        do return ZG.V_CLIMB_UP("DOWN", true) end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do return ZG.TELL("The rope won't catch fire.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("UNTIE")) then
        do return ZG.TELL("The rope is very securely tied and cannot be undone.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("CUT")) and ZG.EQ(ZG.PRSI, ZG.SWORD)) then
        do return ZG.TELL("The rope is made of pretty tough stuff and won't cut.", ZG._TK.CR) end
    else
        do return false end
    end

end, "ROPE-F")

ZG.ROPE_F = ZG.actions:get("ROPE_F")

-- zil: 3actions.zil:4426  <ROUTINE GLOBAL-MAN-F ()>
ZG.actions:register("GLOBAL_MAN_F", function()

    if ZG.EQ(ZG.HERE, ZG.CLIFF) then
        if ZG._T(ZG.MAN_GONE) then
            do return ZG.TELL("You've lost him among the trees.", ZG._TK.CR) end
        else
            do return ZG.TELL("You can't see any man here.", ZG._TK.CR) end
        end
    elseif (not ZG._T(ZG.MAN_FLAG)) then
        do return ZG.TELL("You can't see any man here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("GIVE")) then
        do return ZG.TELL("You aren't even close to him!", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("HELLO")) then
        do return ZG.TELL("The man waves back in a friendly way.", ZG._TK.CR) end
    elseif ZG._T(ZG.HELLO_p(ZG.GLOBAL_MAN)) then
        do local _ = ZG.TELL("He yells back, \"What's that you say? I can't hear you very well.") end
        if (not ZG._T(ZG.CHEST_LIFTED)) then
            do local _ = ZG.TELL(" Just tie the rope to the chest and we can chat afterwards!\" He smiles\nbroadly.") end
        else
            do local _ = ZG.TELL("\"") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG")) then
        do return ZG.TELL("It's unlikely you'll succeed at this distance.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("THROW")) and ZG.EQ(ZG.PRSI, ZG.GLOBAL_MAN) and ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " flies upward, but not nearly far enough to hit the man. It\ndoes seem to amuse him, however, especially as it passes within inches of\nyour head. \"We're wasting time now. Be a good fellow and tie the rope!\"", ZG._TK.CR) end
        do return ZG.MOVE(ZG.PRSO, ZG.HERE) end
    else
        do return false end
    end

end, "GLOBAL-MAN-F")

ZG.GLOBAL_MAN_F = ZG.actions:get("GLOBAL_MAN_F")

-- zil: 3actions.zil:4462  <ROUTINE LAKE-F ()>
ZG.actions:register("LAKE_F", function()

    if ZG._T(ZG.VERB_p("THROUGH", "LEAP", "BOARD")) then
        if ZG.EQUAL_p(ZG.HERE, ZG.LAKE_SHORE, ZG.FAR_SHORE, ZG.SOUTH_SHORE) then
            do return ZG.GO_ON_LAKE() end
        elseif ZG.EQ(ZG.HERE, ZG.ON_LAKE) then
            do return ZG.GOTO(ZG.IN_LAKE) end
        else
            do return ZG.TELL("Just where do you think you are?", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LOOK-UNDER")) then
        if ZG.EQ(ZG.HERE, ZG.ON_LAKE) then
            do return ZG.TELL("You can't quite make out the bottom of the lake from here...", ZG._TK.CR) end
        else
            do return ZG.TELL("You can't see under the surface from here.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "LAKE-F")

ZG.LAKE_F = ZG.actions:get("LAKE_F")

-- zil: 3actions.zil:4477  <ROUTINE IN-LAKE-F (RARG)>
ZG.actions:register("IN_LAKE_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_IN_LAKE, 3)) end
    elseif (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("TAKE")) and (not ZG.EQ(ZG.PRSO, ZG.SHINY_OBJECT))) then
        if ZG.LT(25, ZG.WEIGHT(ZG.WINNER)) then
            do return ZG.TELL("You can't carry that much underwater.", ZG._TK.CR) end
        elseif (not ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT"))) then
            do return ZG.TELL("You can't take that!", ZG._TK.CR) end
        elseif ZG._T(ZG.PROB(30)) then
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is yours for a moment, but drops from your grasp.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_END) then
        if ZG._T(ZG.PROB(10)) then
            do return ZG.TELL("A large and hungry-looking fish is swimming in the neighborhood.", ZG._TK.CR) end
        elseif (ZG._T(ZG.PROB(4)) and (not ZG._T(ZG.INVIS))) then
            do local _ = ZG.QUEUE(ZG.I_ROC, 0) end
            do local _ = ZG.QUEUE(ZG.I_ON_LAKE, 0) end
            do return ZG.JIGS_UP("Oh, no! A tremendous fish just swallowed you whole!") end
        elseif ZG._T(ZG.IN_p(ZG.SHINY_OBJECT, ZG.HERE)) then
            if ZG.EQ(ZG.MOVES, ZG.LAST_MOVES) then
                do return true end
            elseif ZG._T(ZG.PROB(40)) then
                do local _ = ZG.TELL("Out of the corner of your eye, a small, shiny object appears in the\nsand. A moment later, it is gone!", ZG._TK.CR) end
            elseif ZG._T(ZG.PROB(70)) then
                do local _ = ZG.TELL("You catch a brief glimpse of something shiny in the sand.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("Something sparkling in the sand catches your eye for a moment.", ZG._TK.CR) end
            end
            ZG._set("LAST_MOVES", ZG.MOVES)
            do return ZG.LAST_MOVES end
        else
            do return false end
        end
    else
        do return false end
    end

end, "IN-LAKE-F")

ZG.IN_LAKE_F = ZG.actions:get("IN_LAKE_F")

-- zil: 3actions.zil:4513  <GLOBAL LAST-MOVES>
-- LAST_MOVES is declared in ZilGlobal.lua

-- zil: 3actions.zil:4515  <ROUTINE I-IN-LAKE ()>
ZG.actions:register("I_IN_LAKE", function()

    if ZG.EQ(ZG.HERE, ZG.IN_LAKE) then
        do local _ = ZG.TELL("You run out of air and return to the surface.", ZG._TK.CR) end
        do return ZG.GOTO(ZG.ON_LAKE) end
    else
        do return false end
    end

end, "I-IN-LAKE")

ZG.I_IN_LAKE = ZG.actions:get("I_IN_LAKE")

-- zil: 3actions.zil:4521  <GLOBAL LAKE-POINT>
-- LAKE_POINT is declared in ZilGlobal.lua

-- zil: 3actions.zil:4523  <ROUTINE ON-LAKE-F (RARG)>
ZG.actions:register("ON_LAKE_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        do local _ = ZG.QUEUE(ZG.I_IN_LAKE, 0) end
        if (not ZG._T(ZG.LAKE_POINT)) then
            ZG._set("SCORE", ZG.ADD(ZG.SCORE, 1))
            ZG._set("LAKE_POINT", true)
            do return ZG.LAKE_POINT end
        else
            do return false end
        end
    elseif (ZG.EQ(RARG, ZG.M_BEG) and ZG._T(ZG.VERB_p("LEAP")) and (not ZG._T(ZG.PRSO))) then
        do local _ = ZG.DO_WALK("DOWN") end
        do return true end
    else
        do return false end
    end

end, "ON-LAKE-F")

ZG.ON_LAKE_F = ZG.actions:get("ON_LAKE_F")

-- zil: 3actions.zil:4533  <GLOBAL CURRENT-LAMP>
-- CURRENT_LAMP is declared in ZilGlobal.lua

-- zil: 3actions.zil:4535  <ROUTINE GO-ON-LAKE ("AUX" F N (TOLD <>))>
ZG.actions:register("GO_ON_LAKE", function()

    local F = 0
    local N = 0
    local TOLD = false
    if ZG._T((function() F = ZG.FIRST_p(ZG.WINNER); return F end)()) then
        while true do
            N = ZG.NEXT_p(F)
            if (not ZG._T(ZG.FSET_p(F, "WEARBIT"))) then
                do local _ = ZG.MOVE(F, ZG.IN_LAKE) end
                if ZG.EQ(F, ZG.TORCH) then
                    do local _ = ZG.REMOVE(ZG.TORCH) end
                    do local _ = ZG.MOVE(ZG.FRIED_TORCH, ZG.IN_LAKE) end
                elseif ZG.EQ(F, ZG.LAMP) then
                    do local _ = ZG.MOVE(ZG.LAMP, ZG.LOCAL_GLOBALS) end
                    do local _ = ZG.MOVE(ZG.FRIED_LAMP, ZG.IN_LAKE) end
                    ZG._set("CURRENT_LAMP", ZG.FRIED_LAMP)
                elseif ZG.EQ(F, ZG.WAYBREAD) then
                    do local _ = ZG.REMOVE(ZG.WAYBREAD) end
                end
                if (not ZG._T(TOLD)) then
                    TOLD = true
                    do local _ = ZG.TELL("The shock of entering the frigid water has made you drop all your\npossessions into the lake!", ZG._TK.CR) end
                end
            end
            if (not ZG._T(N)) then
                break
            else
                F = N
            end
        end
    end
    if (not ZG._T(TOLD)) then
        do local _ = ZG.TELL("You are nearly paralyzed by the icy waters as you swim into the\ncenter of the lake.", ZG._TK.CR) end
    end
    do local _ = ZG.CRLF() end
    do local _ = ZG.GOTO(ZG.ON_LAKE) end
    ZG._set("LAKE_TIME", 0)
    do return ZG.ENABLE(ZG.QUEUE(ZG.I_ON_LAKE, -1)) end

end, "GO-ON-LAKE")

ZG.GO_ON_LAKE = ZG.actions:get("GO_ON_LAKE")

-- zil: 3actions.zil:4566  <GLOBAL LAKE-TIME>
-- LAKE_TIME is declared in ZilGlobal.lua

-- zil: 3actions.zil:4568  <ROUTINE I-ON-LAKE ()>
ZG.actions:register("I_ON_LAKE", function()

    ZG._set("LAKE_TIME", ZG.ADD(ZG.LAKE_TIME, 1))
    if (ZG._T(ZG.PROB(10)) and ZG.EQ(ZG.HERE, ZG.ON_LAKE) and (not ZG._T(ZG.INVIS))) then
        do local _ = ZG.TELL("A giant roc, previously hidden among the rocks, is heading right toward you,\nits mouth gaping wide!", ZG._TK.CR) end
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_ROC, 2)) end
    elseif (not ZG.EQUAL_p(ZG.HERE, ZG.ON_LAKE, ZG.IN_LAKE)) then
        do local _ = ZG.QUEUE(ZG.I_ON_LAKE, 0) end
        do local _ = ZG.QUEUE(ZG.I_IN_LAKE, 0) end
        do local _ = ZG.QUEUE(ZG.I_ROC, 0) end
        do return false end
    elseif ZG.EQ(ZG.LAKE_TIME, 4) then
        do return ZG.TELL("The icy waters are taking their toll. You will not be able to hold out\nmuch longer.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.LAKE_TIME, 6) then
        do return ZG.TELL("You are becoming very weak. You had better leave the water before you\ndrown!", ZG._TK.CR) end
    elseif ZG.EQ(ZG.LAKE_TIME, 8) then
        do local _ = ZG.QUEUE(ZG.I_ON_LAKE, 0) end
        do local _ = ZG.QUEUE(ZG.I_IN_LAKE, 0) end
        do local _ = ZG.QUEUE(ZG.I_ROC, 0) end
        do return ZG.JIGS_UP("Your strength gives out, and you drown in the frigid waters.") end
    else
        do return false end
    end

end, "I-ON-LAKE")

ZG.I_ON_LAKE = ZG.actions:get("I_ON_LAKE")

-- zil: 3actions.zil:4595  <ROUTINE I-ROC ()>
ZG.actions:register("I_ROC", function()

    if (ZG.EQ(ZG.HERE, ZG.ON_LAKE) and (not ZG._T(ZG.INVIS))) then
        do local _ = ZG.QUEUE(ZG.I_ON_LAKE, 0) end
        do local _ = ZG.QUEUE(ZG.I_IN_LAKE, 0) end
        do return ZG.JIGS_UP("The roc snatches you in its jaws and has you for lunch.") end
    else
        do return false end
    end

end, "I-ROC")

ZG.I_ROC = ZG.actions:get("I_ROC")

-- zil: 3actions.zil:4602  <ROUTINE SHINY-OBJECT-F ()>
ZG.actions:register("SHINY_OBJECT_F", function()

    if (ZG._T(ZG.VERB_p("TAKE", "FIND")) and (not ZG._T(ZG.IN_p(ZG.AMULET, ZG.WINNER)))) then
        if ZG._T(ZG.PROB(50)) then
            do local _ = ZG.REMOVE(ZG.SHINY_OBJECT) end
            do local _ = ZG.MOVE(ZG.AMULET, ZG.WINNER) end
            do local _ = ZG.THIS_IS_IT(ZG.AMULET) end
            do local _ = ZG.FCLEAR(ZG.AMULET, "NDESCBIT") end
            do return ZG.TELL("You reach the shiny object. It is a simple golden amulet!", ZG._TK.CR) end
        else
            do return ZG.TELL("The shiny object slips from your grasp and back onto the floor of\nthe lake, where it is covered in sand.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SHINY-OBJECT-F")

ZG.SHINY_OBJECT_F = ZG.actions:get("SHINY_OBJECT_F")

-- zil: 3actions.zil:4616  <ROUTINE SAND-F ()>
ZG.actions:register("SAND_F", function()

    if ZG._T(ZG.VERB_p("DIG")) then
        do return ZG.TELL("You don't come across anything unusual.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("There is nothing notable on the floor of the lake, except some plants\nand algae.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("It slips through your fingers.", ZG._TK.CR) end
    else
        do return false end
    end

end, "SAND-F")

ZG.SAND_F = ZG.actions:get("SAND_F")

-- zil: 3actions.zil:4626  <ROUTINE ALGAE-F ()>
ZG.actions:register("ALGAE_F", function()

    if ZG._T(ZG.VERB_p("EAT")) then
        do return ZG.TELL("Yeecchhhh!", ZG._TK.CR) end
    else
        do return false end
    end

end, "ALGAE-F")

ZG.ALGAE_F = ZG.actions:get("ALGAE_F")

-- zil: 3actions.zil:4629  <ROUTINE FRIED-LAMP-F ()>
ZG.actions:register("FRIED_LAMP_F", function()

    if ZG._T(ZG.VERB_p("LAMP-ON")) then
        do return ZG.TELL("The lamp isn't functioning (probably from having gotten wet).", ZG._TK.CR) end
    else
        do return false end
    end

end, "FRIED-LAMP-F")

ZG.FRIED_LAMP_F = ZG.actions:get("FRIED_LAMP_F")

-- zil: 3actions.zil:4634  <GLOBAL VIEW-POINT>
-- VIEW_POINT is declared in ZilGlobal.lua

-- zil: 3actions.zil:4636  <ROUTINE I-VIEW-SNAP ()>
ZG.actions:register("I_VIEW_SNAP", function()

    do local _ = ZG.TELL("You suddenly find yourself back in the viewing room!", ZG._TK.CR) end
    do local _ = ZG.GOTO(ZG.VIEW_ROOM, false) end
    do return true end

end, "I-VIEW-SNAP")

ZG.I_VIEW_SNAP = ZG.actions:get("I_VIEW_SNAP")

-- zil: 3actions.zil:4641  <ROUTINE VIEWING-TABLE-F ("AUX" L)>
ZG.actions:register("VIEWING_TABLE_F", function()

    local L = 0
    if ZG._T(ZG.VERB_p("RUB")) then
        ZG._set("SCORE", ZG.ADD(ZG.SCORE, ZG.VIEW_POINT))
        ZG._set("VIEW_POINT", 0)
        do local _ = ZG.TELL("You touch the table and are instantly transported to another place!", ZG._TK.CR) end
        do local _ = ZG.CRLF() end
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_VIEW_SNAP, 3)) end
        do local _ = ZG.GOTO(ZG.GET(ZG.VIEW_ROOMS, ZG.ACTIVE_VIEW)) end
        do return true end
    elseif ZG._T(ZG.VERB_p("EXAMINE", "LOOK-INSIDE")) then
        do local _ = ZG.TELL("The surface is pale and featureless, but slowly, an image takes shape!", ZG._TK.CR) end
        do local _ = ZG.TELL(ZG.GET(ZG.VIEWS, ZG.ACTIVE_VIEW), ZG._TK.CR) end
        do return ZG.TELL("The image slowly fades.", ZG._TK.CR) end
    else
        do return false end
    end

end, "VIEWING-TABLE-F")

ZG.VIEWING_TABLE_F = ZG.actions:get("VIEWING_TABLE_F")

-- zil: 3actions.zil:4658  <ROUTINE I-VIEW-CHANGE ()>
ZG.actions:register("I_VIEW_CHANGE", function()

    ZG._set("ACTIVE_VIEW", ZG.ADD(ZG.ACTIVE_VIEW, 1))
    if ZG.EQ(ZG.ACTIVE_VIEW, 5) then
        ZG._set("ACTIVE_VIEW", 1)
    end
    do local _ = ZG.QUEUE(ZG.I_VIEW_CHANGE, 4) end
    if ZG.EQ(ZG.HERE, ZG.VIEW_ROOM) then
        do local _ = ZG.TELL("The indicator above the table flickers briefly, then changes to \"") end
        do return ZG.TELL(ZG.GET(ZG.VIEW_ROMANS, ZG.ACTIVE_VIEW), "\".", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-VIEW-CHANGE")

ZG.I_VIEW_CHANGE = ZG.actions:get("I_VIEW_CHANGE")

-- zil: 3actions.zil:4667  <ROUTINE VIEW-ROOM-F (RARG)>
ZG.actions:register("VIEW_ROOM_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a small chamber carved in the rock, with the sole exit to the\nnorth. Mounted on one wall is a table labelled \"Scenic Vista,\" whose\nfeatureless surface is angled toward you. One might believe that the table\nwas used to indicate points of interest in the view from this spot, like those\nfound in many parks. On the other hand, your surroundings are far from\nspacious and by no stretch of the imagination could this spot be considered\nscenic. An indicator above the table reads \"") end
        do return ZG.TELL(ZG.GET(ZG.VIEW_ROMANS, ZG.ACTIVE_VIEW), "\".", ZG._TK.CR) end
    else
        do return false end
    end

end, "VIEW-ROOM-F")

ZG.VIEW_ROOM_F = ZG.actions:get("VIEW_ROOM_F")

-- zil: 3actions.zil:4679  <GLOBAL VIEW-ROMANS>
-- VIEW_ROMANS is declared in ZilGlobal.lua

-- zil: 3actions.zil:4681  <GLOBAL ACTIVE-VIEW>
-- ACTIVE_VIEW is declared in ZilGlobal.lua

-- zil: 3actions.zil:4683  <GLOBAL VIEW-ROOMS>
-- VIEW_ROOMS is declared in ZilGlobal.lua

-- zil: 3actions.zil:4685  <GLOBAL VIEWS>
-- VIEWS is declared in ZilGlobal.lua

-- zil: 3actions.zil:4697  <ROUTINE CLIFF-OBJECT-F ()>
ZG.actions:register("CLIFF_OBJECT_F", function()

    if ZG.EQ(ZG.HERE, ZG.CLIFF) then
        if ZG._T(ZG.VERB_p("LEAP")) then
            do return ZG.JIGS_UP("You should have looked before you leaped.") end
        elseif ZG._T(ZG.VERB_p("CLIMB-DOWN")) then
            if ZG._T(ZG.ROPE_FLAG) then
                do local _ = ZG.GOTO(ZG.CLIFF_LEDGE) end
                do return true end
            else
                do return ZG.TELL("The fall would kill you.", ZG._TK.CR) end
            end
        elseif (ZG._T(ZG.VERB_p("THROW-OFF")) and ZG.EQ(ZG.PRSI, ZG.CLIFF_OBJECT)) then
            if ZG.EQ(ZG.PRSO, ZG.ROPE) then
                do local _ = ZG.TELL("The rope is dangling over the side of the cliff already.", ZG._TK.CR) end
                do return true end
            elseif (not ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) then
                do local _ = ZG.TELL("You aren't holding the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
                do return true end
            end
            do local _ = ZG.MOVE(ZG.PRSO, ZG.CLIFF_LEDGE) end
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " goes over the cliff and lands among the rocks below.", ZG._TK.CR) end
            if ZG.EQ(ZG.PRSO, ZG.LAMP) then
                do local _ = ZG.REMOVE(ZG.PRSO) end
                do local _ = ZG.MOVE(ZG.BROKEN_LAMP, ZG.CLIFF_LEDGE) end
                ZG._set("CURRENT_LAMP", ZG.BROKEN_LAMP)
            elseif ZG.EQ(ZG.PRSO, ZG.STAFF) then
                do local _ = ZG.REMOVE(ZG.PRSO) end
                do local _ = ZG.MOVE(ZG.BROKEN_STAFF, ZG.CLIFF_LEDGE) end
            end
            do return true end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("CLIMB-UP")) then
        do return ZG.TELL("You haven't enough strength to climb the cliff.", ZG._TK.CR) end
    else
        do return ZG.TELL("The cliff is above you!", ZG._TK.CR) end
    end

end, "CLIFF-OBJECT-F")

ZG.CLIFF_OBJECT_F = ZG.actions:get("CLIFF_OBJECT_F")

-- zil: 3actions.zil:4731  <ROUTINE TREE-F ()>
ZG.actions:register("TREE_F", function()

    if ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-FOO")) then
        do return ZG.TELL("The trunks are too large for you to climb them.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("EXAMINE", "LOOK-INSIDE")) and (not ZG._T(ZG.MAN_SEEN))) then
        do return ZG.TELL("There seems to be nobody there, but it's hard to tell.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do return ZG.JIGS_UP("Smokey the Bear puts out both the fire and you.") end
    else
        do return false end
    end

end, "TREE-F")

ZG.TREE_F = ZG.actions:get("TREE_F")

-- zil: 3actions.zil:4741  <ROUTINE FRIED-TORCH-F ()>
ZG.actions:register("FRIED_TORCH_F", function()

    if ZG._T(ZG.VERB_p("LAMP-ON")) then
        do return ZG.TELL("It's hopeless. The torch is wet.", ZG._TK.CR) end
    else
        do return false end
    end

end, "FRIED-TORCH-F")

ZG.FRIED_TORCH_F = ZG.actions:get("FRIED_TORCH_F")

-- zil: 3actions.zil:4745  <ROUTINE TORCH-F ()>
ZG.actions:register("TORCH_F", function()

    if ZG._T(ZG.VERB_p("LAMP-ON")) then
        if ZG._T(ZG.FSET_p(ZG.TORCH, "ONBIT")) then
            do return ZG.TELL("It's already lit.", ZG._TK.CR) end
        else
            do return ZG.TELL("You have nothing to light it with.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LAMP-OFF")) then
        if ZG._T(ZG.FSET_p(ZG.TORCH, "ONBIT")) then
            do local _ = ZG.TELL("You manage to extinguish the flame.", ZG._TK.CR) end
            do return ZG.FCLEAR(ZG.TORCH, "ONBIT") end
        else
            do return ZG.TELL("It has already been extinguished.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "TORCH-F")

ZG.TORCH_F = ZG.actions:get("TORCH_F")

-- ;"Here's some ZORK I"

-- zil: 3actions.zil:4757  <OBJECT TIMBERS>
ZG._declare("TIMBERS", function() return ZG._declare_object("TIMBERS", function() return {
    ["LOC"] = ZG.TIMBER_ROOM,
    ["SYNONYM"] = {"TIMBERS", "PILE"},
    ["ADJECTIVE"] = {"WOODEN", "BROKEN"},
    ["DESC"] = "broken timber",
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 50,
} end) end, true)

-- zil: 3actions.zil:4765  <ROOM LADDER-TOP>
ZG._declare("LADDER_TOP", function() return ZG._declare_object("LADDER-TOP", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a very small room. In the corner is a rickety wooden\nladder, leading downward. It might be safe to descend. There is\nalso a staircase leading upward.",
    ["DESC"] = "Ladder Top",
    ["DOWN"] = {"TO", ZG.LADDER_BOTTOM},
    ["FLAGS"] = "RLANDBIT",
    ["GLOBAL"] = {ZG.LADDER, ZG.STAIRS},
} end) end, true)

-- zil: 3actions.zil:4776  <OBJECT LADDER>
ZG._declare("LADDER", function() return ZG._declare_object("LADDER", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["SYNONYM"] = "LADDER",
    ["ADJECTIVE"] = {"WOODEN", "RICKETY", "NARROW"},
    ["DESC"] = "wooden ladder",
    ["FLAGS"] = {"NDESCBIT", "CLIMBBIT"},
} end) end, true)

-- zil: 3actions.zil:4783  <ROOM LADDER-BOTTOM>
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

-- zil: 3actions.zil:4796  <ROOM DEAD-END-5>
ZG._declare("DEAD_END_5", function() return ZG._declare_object("DEAD-END-5", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dead End",
    ["LDESC"] = "You have come to a dead end in the mine.\nThere is a small pile of coal here.",
    ["NORTH"] = {"TO", ZG.LADDER_BOTTOM},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:4804  <ROOM TIMBER-ROOM>
ZG._declare("TIMBER_ROOM", function() return ZG._declare_object("TIMBER-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a long and narrow passage, which is cluttered with broken\ntimbers. A wide passage comes from the east and turns at the\nwest end of the room into a very narrow passageway. From the west\ncomes a strong draft.",
    ["DESC"] = "Timber Room",
    ["EAST"] = {"TO", ZG.LADDER_BOTTOM},
    ["WEST"] = {"TO", ZG.LOWER_SHAFT, "IF", "EMPTY_HANDED", "ELSE", "You cannot fit through this passage with that load."},
    ["ACTION"] = ZG.NO_OBJS,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:4819  <ROOM LOWER-SHAFT>
ZG._declare("LOWER_SHAFT", function() return ZG._declare_object("LOWER-SHAFT", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Drafty Room",
    ["SOUTH"] = {"TO", ZG.MACHINE_ROOM},
    ["OUT"] = {"TO", ZG.TIMBER_ROOM},
    ["EAST"] = {"TO", ZG.TIMBER_ROOM},
    ["ACTION"] = ZG.NO_OBJS,
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:4828  <ROOM MACHINE-ROOM>
ZG._declare("MACHINE_ROOM", function() return ZG._declare_object("MACHINE-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Machine Room",
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:4833  <GLOBAL EMPTY-HANDED>
-- EMPTY_HANDED is declared in ZilGlobal.lua

-- zil: 3actions.zil:4835  <ROUTINE NO-OBJS (RARG "AUX" F)>
ZG.actions:register("NO_OBJS", function(RARG)

    local F = 0
    if ZG.EQ(RARG, ZG.M_BEG) then
        F = ZG.FIRST_p(ZG.WINNER)
        ZG._set("EMPTY_HANDED", true)
        while true do
            if (not ZG._T(F)) then
                break
            elseif ZG.LT(4, ZG.WEIGHT(F)) then
                ZG._set("EMPTY_HANDED", false)
                break
            end
            F = ZG.NEXT_p(F)
        end
        do return false end
    else
        do return false end
    end

end, "NO-OBJS")

ZG.NO_OBJS = ZG.actions:get("NO_OBJS")

-- ;"Stuff from ZORK II"

-- zil: 3actions.zil:4849  <ROOM ROOM-8>
ZG._declare("ROOM_8", function() return ZG._declare_object("ROOM-8", function() return {
    ["LOC"] = ZG.ROOMS,
    ["LDESC"] = "This is a small chamber carved out of the rock at the end of a short crawl.\nOn the wall is crudely chiseled the number \"8\". The only apparent exit,\nto the east, seems to be a blur and a loud, whirring sound resounds through\nthe rock.",
    ["DESC"] = "Room 8",
    ["FLAGS"] = "RLANDBIT",
    ["EAST"] = "You are repelled from the exit by a fierce wind.",
} end) end, true)

-- zil: 3actions.zil:4860  <OBJECT REPELLENT>
ZG._declare("REPELLENT", function() return ZG._declare_object("REPELLENT", function() return {
    ["LOC"] = ZG.ROOM_8,
    ["SYNONYM"] = {"REPELLENT", "CAN"},
    ["ADJECTIVE"] = {"GRUE", "MAGIC"},
    ["DESC"] = "Frobozz Magic Grue Repellent",
    ["FLAGS"] = {"TAKEBIT", "READBIT"},
    ["ACTION"] = ZG.REPELLENT_FCN,
    ["FDESC"] = "A spray can is in the corner. In large type is the legend \"Frobozz Magic\nGrue Repellent.\"",
    ["TEXT"] = "!!! FROBOZZ MAGIC GRUE REPELLENT !!!\n\nInstructions for use: Apply liberally to creature to be protected.\nDuration of effect is unpredictable. Use only in place of death!\n\n(No warranty expressed or implied)",
} end) end, true)

-- zil: 3actions.zil:4878  <ROUTINE REPELLENT-FCN ()>
ZG.actions:register("REPELLENT_FCN", function()

    if ZG._T(ZG.VERB_p("SHAKE")) then
        if ZG._T(ZG.SPRAY_USED_p) then
            do return ZG.TELL("The can seems empty.", ZG._TK.CR) end
        else
            do return ZG.TELL("There is a sloshing sound from inside.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do return ZG.JIGS_UP("The can explodes and you die a horribly smelly death.") end
    elseif (ZG._T(ZG.VERB_p("SPRAY", "PUT-ON")) and ZG.EQ(ZG.PRSO, ZG.REPELLENT)) then
        if ZG._T(ZG.SPRAY_USED_p) then
            do return ZG.TELL("The repellent is all gone.", ZG._TK.CR) end
        elseif (not ZG._T(ZG.PRSI)) then
            ZG._set("SPRAY_USED_p", true)
            do return ZG.TELL("The spray stinks amazingly for a few moments, then drifts away.", ZG._TK.CR) end
        else
            if ZG.EQ(ZG.PRSI, ZG.ME) then
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SPRAY, 5)) end
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

-- zil: 3actions.zil:4902  <GLOBAL SPRAY-USED?>
-- SPRAY_USED_p is declared in ZilGlobal.lua

-- zil: 3actions.zil:4904  <ROUTINE I-SPRAY ()>
ZG.actions:register("I_SPRAY", function()

    ZG._set("SPRAYED_p", false)
    do return ZG.TELL("That horrible smell is much less pungent now.", ZG._TK.CR) end

end, "I-SPRAY")

ZG.I_SPRAY = ZG.actions:get("I_SPRAY")

-- ;"Stuff from ZORK IV"

-- zil: 3actions.zil:4910  <ROOM ZORK-IV>
ZG._declare("ZORK_IV", function() return ZG._declare_object("ZORK-IV", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Sacrificial Altar",
    ["FLAGS"] = {"ONBIT", "RLANDBIT"},
    ["ACTION"] = ZG.ZORK_IV_F,
} end) end, true)

-- zil: 3actions.zil:4916  <ROUTINE ZORK-IV-F (RARG)>
ZG.actions:register("ZORK_IV_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.JIGS_UP("Sacrificial Altar\nThis is the interior of a huge temple of primitive construction. A few\nflickering torches cast a sallow illumination over the altar, which is\nstill drenched with the blood of human sacrifice. Behind the altar is an\nenormous statue of a demon which seems to reach towards you with\ndripping fangs and razor-sharp talons. A low noise begins behind you,\nand you turn to see hundreds of hunched and hairy shapes. A guttural\nchant issues from their throats. Near you stands a figure draped in a\nrobe of deepest black, brandishing a huge sword. The chant grows louder\nas the robed figure approaches the altar. The large figure spots you and\napproaches menacingly. It reaches into its cloak and pulls out a great,\nglowing dagger. It pulls you onto the altar and, with a murmur of\napproval from the throng, slices you neatly across your abdomen.") end
    else
        do return false end
    end

end, "ZORK-IV-F")

ZG.ZORK_IV_F = ZG.actions:get("ZORK_IV_F")

-- ;"Last Section"

-- zil: 3actions.zil:4935  <ROOM SOUTH-SHORE>
ZG._declare("SOUTH_SHORE", function() return ZG._declare_object("SOUTH-SHORE", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Southern Shore",
    ["LDESC"] = "You are on the south shore of the lake. Rock formations prevent\nmovement to the west and thickening swamp to the east makes the going\nall but impossible. To the south, where the beach meets a rock\nformation, you can make out a dark passage sloping steeply upward into the\nrock.",
    ["EAST"] = "The swamp is too thick.",
    ["UP"] = {"TO", ZG.DARK_1},
    ["NORTH"] = "If you want to go into the lake, you should say so.",
    ["SOUTH"] = {"TO", ZG.DARK_1},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = ZG.LAKE,
    ["PSEUDO"] = {"BEACH", ZG.SHORE_PSEUDO, "SWAMP", ZG.SWAMP_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:4952  <ROOM DARK-1>
ZG._declare("DARK_1", function() return ZG._declare_object("DARK-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dark Place",
    ["NORTH"] = {"TO", ZG.SOUTH_SHORE},
    ["SOUTH"] = {"TO", ZG.DARK_2},
    ["UP"] = {"TO", ZG.DARK_2},
    ["DOWN"] = {"TO", ZG.SOUTH_SHORE},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:4961  <ROOM DARK-2>
ZG._declare("DARK_2", function() return ZG._declare_object("DARK-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Dark Place",
    ["NORTH"] = {"TO", ZG.DARK_1},
    ["EAST"] = {"TO", ZG.KEY_ROOM},
    ["UP"] = {"TO", ZG.KEY_ROOM},
    ["DOWN"] = {"TO", ZG.DARK_1},
    ["FLAGS"] = "RLANDBIT",
} end) end, true)

-- zil: 3actions.zil:4970  <ROOM KEY-ROOM>
ZG._declare("KEY_ROOM", function() return ZG._declare_object("KEY-ROOM", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Key Room",
    ["WEST"] = {"TO", ZG.DARK_2},
    ["DOWN"] = {"TO", ZG.AQ_1, "IF", "COVER_MOVED", "ELSE", "You can't walk through a piece of metal."},
    ["ACTION"] = ZG.KEY_ROOM_F,
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
} end) end, true)

-- zil: 3actions.zil:4979  <ROOM AQ-1>
ZG._declare("AQ_1", function() return ZG._declare_object("AQ-1", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Aqueduct",
    ["UP"] = "The hole is too far above your head.",
    ["LDESC"] = "You are in a wide stone channel, part of the water supply system for the\nGreat Underground Empire. The source of water was a waterfall to the south,\nwhich has long since dried up. Water flowed along the aqueduct to the north.\nThis region is lit from above, although the source of light is not apparent.",
    ["SOUTH"] = "You can't climb the dried-up waterfall.",
    ["NORTH"] = {"TO", ZG.AQ_2},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["GLOBAL"] = {ZG.AQUEDUCT, ZG.WATER_CHANNEL, ZG.MOSS},
    ["PSEUDO"] = {"WATERF", ZG.WATERFALL_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:4994  <ROOM AQ-2>
ZG._declare("AQ_2", function() return ZG._declare_object("AQ-2", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "High Arch",
    ["NORTH"] = {"TO", ZG.AQ_3, "IF", "AQ_FLAG", "ELSE", "The arch before you is broken."},
    ["SOUTH"] = {"TO", ZG.AQ_1},
    ["DOWN"] = "It's a long way down....",
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.AQ_2_F,
    ["GLOBAL"] = {ZG.AQUEDUCT, ZG.WATER_CHANNEL, ZG.MOSS},
    ["PSEUDO"] = {"ARCH", ZG.ARCH_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:5005  <ROOM AQ-3>
ZG._declare("AQ_3", function() return ZG._declare_object("AQ-3", function() return {
    ["LOC"] = ZG.ROOMS,
    ["DESC"] = "Water Slide",
    ["NORTH"] = {"TO", ZG.DAMP_PASSAGE},
    ["DOWN"] = {"TO", ZG.DAMP_PASSAGE},
    ["SOUTH"] = {"TO", ZG.AQ_2, "IF", "AQ_FLAG", "ELSE", "The arch to the south is broken."},
    ["FLAGS"] = {"RLANDBIT", "ONBIT"},
    ["ACTION"] = ZG.AQ_3_F,
    ["GLOBAL"] = {ZG.AQUEDUCT, ZG.WATER_CHANNEL, ZG.MOSS},
    ["PSEUDO"] = {"ARCH", ZG.ARCH_PSEUDO},
} end) end, true)

-- zil: 3actions.zil:5016  <OBJECT AQUEDUCT>
ZG._declare("AQUEDUCT", function() return ZG._declare_object("AQUEDUCT", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "aqueduct",
    ["SYNONYM"] = {"AQUEDUCT", "DUCT", "CHASM"},
    ["ADJECTIVE"] = "STONE",
    ["ACTION"] = ZG.AQUEDUCT_F,
} end) end, true)

-- zil: 3actions.zil:5023  <OBJECT WATER-CHANNEL>
ZG._declare("WATER_CHANNEL", function() return ZG._declare_object("WATER-CHANNEL", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "channel",
    ["SYNONYM"] = "CHANNEL",
    ["ADJECTIVE"] = "WATER",
    ["ACTION"] = ZG.WATER_CHANNEL_F,
} end) end, true)

-- zil: 3actions.zil:5030  <OBJECT MOSS>
ZG._declare("MOSS", function() return ZG._declare_object("MOSS", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "moss and lichen",
    ["SYNONYM"] = {"MOSS", "LICHEN"},
    ["ACTION"] = ZG.MOSS_F,
} end) end, true)

-- zil: 3actions.zil:5036  <ROUTINE AQUEDUCT-F ()>
ZG.actions:register("AQUEDUCT_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The aqueduct is large and impressive. It was probably the major method\nof water transport in the Empire.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LEAP")) then
        do return ZG.JIGS_UP("You execute a perfect swan dive into the rocks below!") end
    else
        do return false end
    end

end, "AQUEDUCT-F")

ZG.AQUEDUCT_F = ZG.actions:get("AQUEDUCT_F")

-- zil: 3actions.zil:5045  <ROUTINE WATER-CHANNEL-F ()>
ZG.actions:register("WATER_CHANNEL_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The channel is a few feet deep and ten feet wide, rounded on the bottom.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("BOARD")) then
        if ZG.EQ(ZG.HERE, ZG.DAMP_PASSAGE) then
            do return ZG.TELL("Getting into the channel wouldn't be of much use.", ZG._TK.CR) end
        else
            do return ZG.TELL("You're standing in it. Otherwise, you would be floating in midair above some\nvery nasty rocks.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "WATER-CHANNEL-F")

ZG.WATER_CHANNEL_F = ZG.actions:get("WATER_CHANNEL_F")

-- zil: 3actions.zil:5058  <ROUTINE MOSS-F ()>
ZG.actions:register("MOSS_F", function()

    if ZG._T(ZG.VERB_p("TAKE", "MOVE")) then
        do return ZG.TELL("Don't be silly.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MOSS-F")

ZG.MOSS_F = ZG.actions:get("MOSS_F")

-- zil: 3actions.zil:5062  <ROUTINE AQ-2-F (RARG)>
ZG.actions:register("AQ_2_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are now on one of the tallest arches of the aqueduct, hundreds of feet\nabove a rocky chasm. The immensity of the aqueduct project is apparent from\nhere. Stone supports rise from the rock floor to form massive arches, which\ntraverse the region from north to south. The water-carrying channel here is\nwide and deep. To the west and far below, you can make out a balcony which\nmust command a wide view of the aqueduct.", ZG._TK.CR) end
        if (not ZG._T(ZG.AQ_FLAG)) then
            do return ZG.TELL("The channel ends abruptly to your north where a supporting pillar has\ncrumbled, casting the arch into the chasm.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "AQ-2-F")

ZG.AQ_2_F = ZG.actions:get("AQ_2_F")

-- zil: 3actions.zil:5076  <ROUTINE AQ-3-F (RARG)>
ZG.actions:register("AQ_3_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are near the northern end of this segment of the aqueduct system. To the\nsouth and slightly uphill, the bulk of the aqueduct looms ominously, towering\nabove a gorge. To the north, the water channel drops precipitously and enters\na rocky hole. The damp moss and lichen would certainly make that a one-way\ntrip.", ZG._TK.CR) end
        if (not ZG._T(ZG.AQ_FLAG)) then
            do return ZG.TELL("The southern part of the aqueduct system is inaccessable due to the\ncollapse of one of the water-bearing arches.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "AQ-3-F")

ZG.AQ_3_F = ZG.actions:get("AQ_3_F")

-- zil: 3actions.zil:5089  <GLOBAL AQ-FLAG>
-- AQ_FLAG is declared in ZilGlobal.lua

-- zil: 3actions.zil:5091  <GLOBAL COVER-MOVED>
-- COVER_MOVED is declared in ZilGlobal.lua

-- zil: 3actions.zil:5093  <OBJECT COVER>
ZG._declare("COVER", function() return ZG._declare_object("COVER", function() return {
    ["LOC"] = ZG.KEY_ROOM,
    ["DESC"] = "manhole cover",
    ["SYNONYM"] = "COVER",
    ["ADJECTIVE"] = {"MANHOLE", "LARGE"},
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.COVER_F,
} end) end, true)

-- zil: 3actions.zil:5101  <ROUTINE COVER-F ()>
ZG.actions:register("COVER_F", function()

    if ZG._T(ZG.VERB_p("MOVE", "RAISE", "OPEN")) then
        do local _ = ZG.TELL("The cover is moved a bit to one side, revealing a small hole leading into\ndarkness.", ZG._TK.CR) end
        ZG._set("COVER_MOVED", true)
        do return ZG.COVER_MOVED end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The cover is far too heavy to take.", ZG._TK.CR) end
    else
        do return false end
    end

end, "COVER-F")

ZG.COVER_F = ZG.actions:get("COVER_F")

-- zil: 3actions.zil:5111  <ROUTINE KEY-ROOM-F (RARG)>
ZG.actions:register("KEY_ROOM_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are between some rock and a dark place. The room is lit dimly from\nabove, revealing a lone, dark path sloping down to the west.", ZG._TK.CR) end
        if ZG._T(ZG.COVER_MOVED) then
            do return ZG.TELL("A heavy manhole cover has been moved to reveal a dark passage below.", ZG._TK.CR) end
        else
            do return ZG.TELL("To one side of the room is a large manhole cover.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "KEY-ROOM-F")

ZG.KEY_ROOM_F = ZG.actions:get("KEY_ROOM_F")

-- zil: 3actions.zil:5123  <OBJECT KEY>
ZG._declare("KEY", function() return ZG._declare_object("KEY", function() return {
    ["LOC"] = ZG.KEY_ROOM,
    ["DESC"] = "strange key",
    ["FDESC"] = "The light from above seems to be focused in the center of the room, where\na single key is lying in the dust.",
    ["SYNONYM"] = "KEY",
    ["ADJECTIVE"] = {"STRANGE", "RUSTY", "LONG", "SHORT", "HEAVY", "THIN", "SHARP", "POINTED"},
    ["FLAGS"] = "TAKEBIT",
    ["SIZE"] = 10,
    ["ACTION"] = ZG.KEY_F,
} end) end, true)

-- zil: 3actions.zil:5135  <ROUTINE KEY-F ()>
ZG.actions:register("KEY_F", function()

    if (ZG._T(ZG.VERB_p("UNLOCK")) and ZG.EQ(ZG.PRSI, ZG.KEY)) then
        if (ZG.EQ(ZG.PRSO, ZG.BRONZE_DOOR) and ZG.EQ(ZG.HERE, ZG.GOOD_CELL)) then
            if ZG._T(ZG.BRONZE_DOOR_LOCKED) then
                do local _ = ZG.TELL("The key seems to mold itself to the shape of the lock. With a mere\ntwist of your hand, the massive bolt gives way.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("It already is.", ZG._TK.CR) end
            end
            ZG._set("BRONZE_DOOR_LOCKED", false)
            do return true end
        elseif ZG.EQ(ZG.PRSO, ZG.BRONZE_DOOR) then
            do return ZG.TELL("The key molds itself to the lock but will not turn.", ZG._TK.CR) end
        elseif (ZG.EQ(ZG.PRSO, ZG.CHEST) or ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT"))) then
            do return ZG.TELL("The key, which initially seemed certain to fit the lock, seems to change\nshape and will not enter the keyhole.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do local _ = ZG.TELL(ZG.PICK_ONE(ZG.KEY_DESCS), ZG._TK.CR) end
        do return ZG.TELL("Strange, though. The key seems to change shape constantly.", ZG._TK.CR) end
    else
        do return false end
    end

end, "KEY-F")

ZG.KEY_F = ZG.actions:get("KEY_F")

-- zil: 3actions.zil:5158  <GLOBAL KEY-DESCS>
-- KEY_DESCS is declared in ZilGlobal.lua

-- zil: 3actions.zil:5165  <OBJECT VIEW-INDICATOR>
ZG._declare("VIEW_INDICATOR", function() return ZG._declare_object("VIEW-INDICATOR", function() return {
    ["LOC"] = ZG.VIEW_ROOM,
    ["DESC"] = "indicator",
    ["SYNONYM"] = {"INDICATOR", "DIAL"},
    ["FLAGS"] = {"NDESCBIT", "READBIT"},
    ["ACTION"] = ZG.VIEW_INDICATOR_F,
} end) end, true)

-- zil: 3actions.zil:5172  <ROUTINE VIEW-INDICATOR-F ()>
ZG.actions:register("VIEW_INDICATOR_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE", "READ")) then
        do return ZG.TELL("The indicator reads \"", ZG.GET(ZG.VIEW_ROMANS, ZG.ACTIVE_VIEW), "\".", ZG._TK.CR) end
    else
        do return false end
    end

end, "VIEW-INDICATOR-F")

ZG.VIEW_INDICATOR_F = ZG.actions:get("VIEW_INDICATOR_F")

-- zil: 3actions.zil:5178  <GLOBAL BOAT-SEEN>
-- BOAT_SEEN is declared in ZilGlobal.lua

-- zil: 3actions.zil:5180  <ROUTINE FLATHEAD-OCEAN-F (RARG)>
ZG.actions:register("FLATHEAD_OCEAN_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are at the shore of an amazing underground sea, the topic of many a\nlegend among adventurers. Few were known to have arrived at this spot, and\nfewer to return. There is a heavy surf and a breeze is blowing onshore.\nThe land rises steeply to the east and quicksand prevents movement to the\nsouth. A thick mist covers the ocean and extends over the hills to the east.\nA path heads north along the beach.", ZG._TK.CR) end
        if (not ZG._T(ZG.FSET_p(ZG.VIKING_SHIP, "INVISIBLE"))) then
            do local _ = ZG.TELL("An ancient Viking ship is passing along the shore, an old and crusty\nsailor at the helm.", ZG._TK.CR) end
        end
        do return true end
    elseif (ZG.EQ(RARG, ZG.M_END) and ZG._T(ZG.PROB(20)) and (not ZG._T(ZG.BOAT_SEEN)) and ZG._T(ZG.LIT)) then
        ZG._set("BOAT_SEEN", true)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_BOAT_DISAPPEAR, 2)) end
        do local _ = ZG.TELL("Passing alongside the shore now is an old boat, reminiscent of an ancient\nViking ship. Standing on the prow of the ship is an old and crusty sailor,\npeering out over the misty ocean.", ZG._TK.CR) end
        do return ZG.FCLEAR(ZG.VIKING_SHIP, "INVISIBLE") end
    else
        do return false end
    end

end, "FLATHEAD-OCEAN-F")

ZG.FLATHEAD_OCEAN_F = ZG.actions:get("FLATHEAD_OCEAN_F")

-- zil: 3actions.zil:5206  <GLOBAL SHIP-GONE>
-- SHIP_GONE is declared in ZilGlobal.lua

-- zil: 3actions.zil:5208  <ROUTINE I-BOAT-DISAPPEAR ()>
ZG.actions:register("I_BOAT_DISAPPEAR", function()

    do local _ = ZG.FSET(ZG.VIKING_SHIP, "INVISIBLE") end
    ZG._set("SHIP_GONE", true)
    if ZG.EQ(ZG.HERE, ZG.FLATHEAD_OCEAN) then
        do return ZG.TELL("The boat sails silently through the mist and out of sight.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-BOAT-DISAPPEAR")

ZG.I_BOAT_DISAPPEAR = ZG.actions:get("I_BOAT_DISAPPEAR")

-- zil: 3actions.zil:5215  <OBJECT VIKING-SHIP>
ZG._declare("VIKING_SHIP", function() return ZG._declare_object("VIKING-SHIP", function() return {
    ["LOC"] = ZG.FLATHEAD_OCEAN,
    ["DESC"] = "Viking Ship",
    ["FLAGS"] = {"NDESCBIT", "INVISIBLE"},
    ["ADJECTIVE"] = "VIKING",
    ["SYNONYM"] = {"BOAT", "SHIP", "CRAFT"},
} end) end, true)

-- zil: 3actions.zil:5222  <OBJECT VIAL>
ZG._declare("VIAL", function() return ZG._declare_object("VIAL", function() return {
    ["DESC"] = "vial",
    ["SYNONYM"] = {"VIAL", "ODOR", "GIFT"},
    ["FLAGS"] = {"TAKEBIT", "CONTBIT"},
    ["SIZE"] = 3,
    ["CAPACITY"] = 3,
    ["ACTION"] = ZG.VIAL_F,
} end) end, true)

-- zil: 3actions.zil:5230  <OBJECT POTION>
ZG._declare("POTION", function() return ZG._declare_object("POTION", function() return {
    ["LOC"] = ZG.VIAL,
    ["DESC"] = "heavy but invisible liquid",
    ["SYNONYM"] = {"POTION", "LIQUID", "CONTENTS", "FLUID"},
    ["ADJECTIVE"] = {"HEAVY", "SWEET", "INVISIBLE", "SMELLING"},
    ["SIZE"] = 2,
    ["FLAGS"] = true,
    ["ACTION"] = ZG.POTION_F,
} end) end, true)

-- zil: 3actions.zil:5239  <ROUTINE I-VISIBLE ()>
ZG.actions:register("I_VISIBLE", function()

    ZG._set("INVIS", false)
    if ZG.EQUAL_p(ZG.HERE, ZG.MRG, ZG.MRGE, ZG.MRGW) then
        do local _ = ZG.JIGS_UP("One of the stone figures (or maybe both, it's hard to tell) suddenly springs\nto life and crushes you with his stone bludgeon.") end
    end
    do return false end

end, "I-VISIBLE")

ZG.I_VISIBLE = ZG.actions:get("I_VISIBLE")

-- zil: 3actions.zil:5247  <ROUTINE POTION-F ()>
ZG.actions:register("POTION_F", function()

    if ZG._T(ZG.VERB_p("DRINK")) then
        do local _ = ZG.REMOVE(ZG.POTION) end
        ZG._set("INVIS", true)
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_VISIBLE, 3)) end
        do return ZG.TELL("You \"drink\" the contents in one gulp, but nothing unusual seems to have\nhappened as a result.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("POUR-ON")) and ZG.EQ(ZG.PRSO, ZG.POTION)) then
        do local _ = ZG.REMOVE(ZG.POTION) end
        do return ZG.TELL("It spills onto the ", ZG._TK.D, ZG.PRSI, " and vanishes.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("It feels like there's something inside, but you can't see anything even\nthough the vial is transparent.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("SMELL")) then
        do return ZG.TELL("The vial (or something in it) smells sweet.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DROP", "TAKE")) then
        do local _ = ZG.TELL("Nothing seems to come out, although the sweet smell disappears from\nthe vial, seeming to permeate the air briefly before fading entirely.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.POTION) end
    else
        do return false end
    end

end, "POTION-F")

ZG.POTION_F = ZG.actions:get("POTION_F")

-- zil: 3actions.zil:5271  <GLOBAL INVIS>
-- INVIS is declared in ZilGlobal.lua

-- zil: 3actions.zil:5273  <ROUTINE VIAL-F ()>
ZG.actions:register("VIAL_F", function()

    if ZG._T(ZG.VERB_p("FILL")) then
        do return ZG.TELL("You can't seem to put anything in it.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("DRINK-FROM")) and ZG._T(ZG.IN_p(ZG.POTION, ZG.VIAL))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DRINK"), ZG.POTION) end
        do return true end
    elseif (ZG._T(ZG.VERB_p("SMELL")) and ZG._T(ZG.IN_p(ZG.POTION, ZG.VIAL))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?SMELL"), ZG.POTION) end
        do return true end
    elseif (ZG._T(ZG.VERB_p("SHAKE")) and ZG._T(ZG.IN_p(ZG.POTION, ZG.VIAL)) and ZG._T(ZG.FSET_p(ZG.VIAL, "OPENBIT"))) then
        do local _ = ZG.TELL("Nothing seems to come out, although the vial is lighter now.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.POTION) end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        do local _ = ZG.FSET(ZG.VIAL, "OPENBIT") end
        do local _ = ZG.TELL("The vial is open.") end
        if ZG._T(ZG.IN_p(ZG.POTION, ZG.VIAL)) then
            do local _ = ZG.TELL(" There is a sweet odor from within the vial, apparently coming from a heavy\nbut invisible liquid.") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do local _ = ZG.TELL("It is a small, transparent vial ") end
        if ZG._T(ZG.IN_p(ZG.POTION, ZG.VIAL)) then
            do return ZG.TELL("which looks empty but is strangely heavy.", ZG._TK.CR) end
        else
            do return ZG.TELL("which is light and empty.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "VIAL-F")

ZG.VIAL_F = ZG.actions:get("VIAL_F")

-- zil: 3actions.zil:5303  <OBJECT OCEAN>
ZG._declare("OCEAN", function() return ZG._declare_object("OCEAN", function() return {
    ["LOC"] = ZG.GLOBAL_OBJECTS,
    ["DESC"] = "Flathead Ocean",
    ["SYNONYM"] = {"OCEAN", "WATER"},
    ["ADJECTIVE"] = "FLATHEAD",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.OCEAN_F,
} end) end, true)

-- zil: 3actions.zil:5311  <ROUTINE OCEAN-F ()>
ZG.actions:register("OCEAN_F", function()

    if (not ZG.EQ(ZG.HERE, ZG.FLATHEAD_OCEAN)) then
        do return ZG.TELL("There is no ocean here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROUGH", "BOARD")) then
        do return ZG.TELL("You would be killed by the pounding surf!", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT", "THROW")) and ZG.EQ(ZG.PRSI, ZG.OCEAN)) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " falls into the ocean and is lost forever.", ZG._TK.CR) end
        do return ZG.REMOVE(ZG.PRSO) end
    else
        do return false end
    end

end, "OCEAN-F")

ZG.OCEAN_F = ZG.actions:get("OCEAN_F")

-- zil: 3actions.zil:5321  <OBJECT STONE>
ZG._declare("STONE", function() return ZG._declare_object("STONE", function() return {
    ["DESC"] = "great rock",
    ["SYNONYM"] = {"ROCK", "STONE"},
    ["ADJECTIVE"] = "GREAT",
    ["LOC"] = ZG.JUNCTION,
    ["DESCFCN"] = ZG.STONE_DESC,
    ["FLAGS"] = {"CONTBIT", "OPENBIT"},
    ["CAPACITY"] = 30,
    ["ACTION"] = ZG.STONE_F,
} end) end, true)

-- zil: 3actions.zil:5331  <GLOBAL SWORD-IN-STONE?>
-- SWORD_IN_STONE_p is declared in ZilGlobal.lua

-- zil: 3actions.zil:5333  <ROUTINE STONE-DESC (FOO)>
ZG.actions:register("STONE_DESC", function(FOO)

    do local _ = ZG.TELL("Standing before you is a great rock.") end
    if ZG._T(ZG.SWORD_IN_STONE_p) then
        do local _ = ZG.TELL(" Imbedded within it is an Elvish sword.") end
    end
    do return ZG.CRLF() end

end, "STONE-DESC")

ZG.STONE_DESC = ZG.actions:get("STONE_DESC")

-- zil: 3actions.zil:5340  <ROUTINE STONE-F ()>
ZG.actions:register("STONE_F", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("You can't be serious.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.STONE)) then
        do return ZG.TELL("You can't force anything into the stone.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("MOVE", "TAKE", "PUSH")) and ZG.EQ(ZG.PRSO, ZG.STONE)) then
        do return ZG.TELL("The stone is far too massive to be moved.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-UNDER")) then
        do return ZG.TELL("Since it can't be moved, it's hard to know what's there.", ZG._TK.CR) end
    else
        do return false end
    end

end, "STONE-F")

ZG.STONE_F = ZG.actions:get("STONE_F")

-- zil: 3actions.zil:5352  <OBJECT FISH>
ZG._declare("FISH", function() return ZG._declare_object("FISH", function() return {
    ["LOC"] = ZG.LOCAL_GLOBALS,
    ["DESC"] = "fish",
    ["SYNONYM"] = "FISH",
    ["FLAGS"] = "NDESCBIT",
    ["ACTION"] = ZG.FISH_F,
} end) end, true)

-- zil: 3actions.zil:5359  <ROUTINE FISH-F ()>
ZG.actions:register("FISH_F", function()

    do return ZG.TELL("There is no fish visible now.", ZG._TK.CR) end

end, "FISH-F")

ZG.FISH_F = ZG.actions:get("FISH_F")

-- zil: 3actions.zil:5362  <ROUTINE QUICKSAND-PSEUDO ()>
ZG.actions:register("QUICKSAND_PSEUDO", function()

    if ZG._T(ZG.VERB_p("THROUGH", "LEAP")) then
        do return ZG.JIGS_UP("You enter the quicksand and slowly sink to a new low in adventuring.") end
    elseif ZG._T(ZG.VERB_p("RUB")) then
        do return ZG.TELL("It's quicksand all right!", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do return ZG.TELL("It's hard to tell what's in there.", ZG._TK.CR) end
    else
        do return false end
    end

end, "QUICKSAND-PSEUDO")

ZG.QUICKSAND_PSEUDO = ZG.actions:get("QUICKSAND_PSEUDO")

-- zil: 3actions.zil:5371  <ROUTINE SWAMP-PSEUDO ()>
ZG.actions:register("SWAMP_PSEUDO", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.TELL("Yucko.", ZG._TK.CR) end
    else
        do return false end
    end

end, "SWAMP-PSEUDO")

ZG.SWAMP_PSEUDO = ZG.actions:get("SWAMP_PSEUDO")

-- zil: 3actions.zil:5375  <ROUTINE MIST-PSEUDO ()>
ZG.actions:register("MIST_PSEUDO", function()

    if ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do return ZG.TELL("You can't make anything out through the mist.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("SMELL")) then
        do return ZG.TELL("It smells vaguely salty.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MIST-PSEUDO")

ZG.MIST_PSEUDO = ZG.actions:get("MIST_PSEUDO")

-- zil: 3actions.zil:5381  <ROUTINE SHORE-PSEUDO ()>
ZG.actions:register("SHORE_PSEUDO", function()

    if ZG._T(ZG.VERB_p("DIG")) then
        do return ZG.TELL("There's nothing there.", ZG._TK.CR) end
    else
        do return false end
    end

end, "SHORE-PSEUDO")

ZG.SHORE_PSEUDO = ZG.actions:get("SHORE_PSEUDO")

-- zil: 3actions.zil:5386  <ROUTINE WATERFALL-PSEUDO ()>
ZG.actions:register("WATERFALL_PSEUDO", function()

    if ZG._T(ZG.VERB_p("CLIMB-UP")) then
        do return ZG.TELL("It's much too slippery.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WATERFALL-PSEUDO")

ZG.WATERFALL_PSEUDO = ZG.actions:get("WATERFALL_PSEUDO")

-- zil: 3actions.zil:5390  <ROUTINE ARCH-PSEUDO ()>
ZG.actions:register("ARCH_PSEUDO", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG._T(ZG.AQ_FLAG) then
            do return ZG.TELL("The arches all show some signs of decay.", ZG._TK.CR) end
        else
            do return ZG.TELL("The arch before you is broken. The others show signs of decay.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "ARCH-PSEUDO")

ZG.ARCH_PSEUDO = ZG.actions:get("ARCH_PSEUDO")
