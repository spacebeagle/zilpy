-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: gverbs.zil:9  <GLOBAL VERBOSE>
-- VERBOSE is declared in ZilGlobal.lua

-- zil: gverbs.zil:10  <GLOBAL SUPER-BRIEF>
-- SUPER_BRIEF is declared in ZilGlobal.lua

-- GDECL _arg

-- zil: gverbs.zil:13  <ROUTINE V-VERBOSE ()>
ZG.actions:register("V_VERBOSE", function()

    ZG._set("VERBOSE", true)
    ZG._set("SUPER_BRIEF", false)
    do return ZG.TELL("Maximum verbosity.", ZG._TK.CR) end

end, "V-VERBOSE")

ZG.V_VERBOSE = ZG.actions:get("V_VERBOSE")

-- zil: gverbs.zil:18  <ROUTINE V-BRIEF ()>
ZG.actions:register("V_BRIEF", function()

    ZG._set("VERBOSE", false)
    ZG._set("SUPER_BRIEF", false)
    do return ZG.TELL("Brief descriptions.", ZG._TK.CR) end

end, "V-BRIEF")

ZG.V_BRIEF = ZG.actions:get("V_BRIEF")

-- zil: gverbs.zil:23  <ROUTINE V-SUPER-BRIEF ()>
ZG.actions:register("V_SUPER_BRIEF", function()

    ZG._set("SUPER_BRIEF", true)
    do return ZG.TELL("Superbrief descriptions.", ZG._TK.CR) end

end, "V-SUPER-BRIEF")

ZG.V_SUPER_BRIEF = ZG.actions:get("V_SUPER_BRIEF")

-- ;"V-DIAGNOSE is in ACTIONS.ZIL"

-- zil: gverbs.zil:29  <ROUTINE V-INVENTORY ()>
ZG.actions:register("V_INVENTORY", function()

    if ZG._T(ZG.FIRST_p(ZG.WINNER)) then
        do return ZG.PRINT_CONT(ZG.WINNER) end
    else
        do return ZG.TELL("You are empty-handed.", ZG._TK.CR) end
    end

end, "V-INVENTORY")

ZG.V_INVENTORY = ZG.actions:get("V_INVENTORY")

-- zil: gverbs.zil:33  <ROUTINE FINISH ("AUX" WRD)>
ZG.actions:register("FINISH", function()

    local WRD = 0
    do local _ = ZG.V_SCORE() end
    while true do
        do local _ = ZG.CRLF() end
        do local _ = ZG.TELL("Would you like to restart the game from the beginning, restore a saved\ngame position, or end this session of the game?\n(Type RESTART, RESTORE, or QUIT):\n>") end
        do local _ = ZG.READ(ZG.P_INBUF, ZG.P_LEXV) end
        WRD = ZG.GET(ZG.P_LEXV, 1)
        if ZG.EQ(WRD, ZG.WORD("restart")) then
            do local _ = ZG.RESTART() end
            do local _ = ZG.TELL("Failed.", ZG._TK.CR) end
        elseif ZG.EQ(WRD, ZG.WORD("restore")) then
            if ZG._T(ZG.RESTORE()) then
                do local _ = ZG.TELL("Ok.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("Failed.", ZG._TK.CR) end
            end
        elseif ZG.EQUAL_p(WRD, ZG.WORD("quit"), ZG.WORD("q")) then
            do local _ = ZG.QUIT() end
        end
    end

end, "FINISH")

ZG.FINISH = ZG.actions:get("FINISH")

-- zil: gverbs.zil:55  <ROUTINE V-QUIT ("AUX" SCOR)>
ZG.actions:register("V_QUIT", function()

    local SCOR = 0
    do local _ = ZG.V_SCORE() end
    do local _ = ZG.TELL("Do you wish to leave the game? (Y is affirmative): ") end
    if ZG._T(ZG.YES_p()) then
        do return ZG.QUIT() end
    else
        do return ZG.TELL("Ok.", ZG._TK.CR) end
    end

end, "V-QUIT")

ZG.V_QUIT = ZG.actions:get("V_QUIT")

-- zil: gverbs.zil:63  <ROUTINE V-RESTART ()>
ZG.actions:register("V_RESTART", function()

    do local _ = ZG.V_SCORE(true) end
    do local _ = ZG.TELL("Do you wish to restart? (Y is affirmative): ") end
    if ZG._T(ZG.YES_p()) then
        do local _ = ZG.TELL("Restarting.", ZG._TK.CR) end
        do local _ = ZG.RESTART() end
        do return ZG.TELL("Failed.", ZG._TK.CR) end
    else
        do return false end
    end

end, "V-RESTART")

ZG.V_RESTART = ZG.actions:get("V_RESTART")

-- zil: gverbs.zil:71  <ROUTINE V-RESTORE ()>
ZG.actions:register("V_RESTORE", function()

    if ZG._T(ZG.RESTORE()) then
        do local _ = ZG.TELL("Ok.", ZG._TK.CR) end
        do return ZG.V_FIRST_LOOK() end
    else
        do return ZG.TELL("Failed.", ZG._TK.CR) end
    end

end, "V-RESTORE")

ZG.V_RESTORE = ZG.actions:get("V_RESTORE")

-- zil: gverbs.zil:78  <ROUTINE V-SAVE ()>
ZG.actions:register("V_SAVE", function()

    if ZG._T(ZG.SAVE()) then
        do return ZG.TELL("Ok.", ZG._TK.CR) end
    else
        do return ZG.TELL("Failed.", ZG._TK.CR) end
    end

end, "V-SAVE")

ZG.V_SAVE = ZG.actions:get("V_SAVE")

-- ;"V-SCORE is in ACTIONS.ZIL"

-- zil: gverbs.zil:86  <ROUTINE V-SCRIPT ()>
ZG.actions:register("V_SCRIPT", function()

    do local _ = ZG.PUT(0, 8, ZG.BOR(ZG.GET(0, 8), 1)) end
    do local _ = ZG.TELL("Here begins a transcript of interaction with", ZG._TK.CR) end
    do local _ = ZG.V_VERSION() end
    do return true end

end, "V-SCRIPT")

ZG.V_SCRIPT = ZG.actions:get("V_SCRIPT")

-- zil: gverbs.zil:92  <ROUTINE V-UNSCRIPT ()>
ZG.actions:register("V_UNSCRIPT", function()

    do local _ = ZG.TELL("Here ends a transcript of interaction with", ZG._TK.CR) end
    do local _ = ZG.V_VERSION() end
    do local _ = ZG.PUT(0, 8, ZG.BAND(ZG.GET(0, 8), -2)) end
    do return true end

end, "V-UNSCRIPT")

ZG.V_UNSCRIPT = ZG.actions:get("V_UNSCRIPT")

-- zil: gverbs.zil:98  <ROUTINE V-VERSION ("AUX" (CNT 17))>
ZG.actions:register("V_VERSION", function()

    local CNT = 17
    do local _ = ZG.TELL("ZORK III: The Dungeon Master\nInfocom interactive fiction - a fantasy story\nCopyright 1982, 1983, 1984, 1986") end
    do local _ = ZG.TELL(" Infocom, Inc. All rights reserved.", ZG._TK.CR) end
    do local _ = ZG.TELL("ZORK is a registered trademark of Infocom, Inc.\nRelease ") end
    do local _ = ZG.PRINTN(ZG.BAND(ZG.GET(0, 1), 2047)) end
    do local _ = ZG.TELL(" / Serial number ") end
    while true do
        if ZG.LT(23, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
            break
        else
            do local _ = ZG.PRINTC(ZG.GETB(0, CNT)) end
        end
    end
    do return ZG.CRLF() end

end, "V-VERSION")

ZG.V_VERSION = ZG.actions:get("V_VERSION")

-- zil: gverbs.zil:123  <ROUTINE V-VERIFY ()>
ZG.actions:register("V_VERIFY", function()

    do local _ = ZG.TELL("Verifying disk...", ZG._TK.CR) end
    if ZG._T(ZG.VERIFY()) then
        do return ZG.TELL("The disk is correct.", ZG._TK.CR) end
    else
        do return ZG.TELL(ZG._TK.CR, "** Disk Failure **", ZG._TK.CR) end
    end

end, "V-VERIFY")

ZG.V_VERIFY = ZG.actions:get("V_VERIFY")

-- zil: gverbs.zil:130  <ROUTINE V-COMMAND-FILE ()>
ZG.actions:register("V_COMMAND_FILE", function()

    do local _ = ZG.DIRIN(1) end
    do return true end

end, "V-COMMAND-FILE")

ZG.V_COMMAND_FILE = ZG.actions:get("V_COMMAND_FILE")

-- zil: gverbs.zil:134  <ROUTINE V-RANDOM ()>
ZG.actions:register("V_RANDOM", function()

    if (not ZG.EQ(ZG.PRSO, ZG.INTNUM)) then
        do return ZG.TELL("Illegal call to #RND.", ZG._TK.CR) end
    else
        do local _ = ZG.RANDOM(ZG.SUB(0, ZG.P_NUMBER)) end
        do return true end
    end

end, "V-RANDOM")

ZG.V_RANDOM = ZG.actions:get("V_RANDOM")

-- zil: gverbs.zil:141  <ROUTINE V-RECORD ()>
ZG.actions:register("V_RECORD", function()

    do local _ = ZG.DIROUT(4) end
    do return true end

end, "V-RECORD")

ZG.V_RECORD = ZG.actions:get("V_RECORD")

-- zil: gverbs.zil:145  <ROUTINE V-UNRECORD ()>
ZG.actions:register("V_UNRECORD", function()

    do local _ = ZG.DIROUT(-4) end
    do return true end

end, "V-UNRECORD")

ZG.V_UNRECORD = ZG.actions:get("V_UNRECORD")

-- zil: gverbs.zil:153  <ROUTINE V-ADVENT ()>
ZG.actions:register("V_ADVENT", function()

    do return ZG.TELL("A hollow voice says \"Fool.\"", ZG._TK.CR) end

end, "V-ADVENT")

ZG.V_ADVENT = ZG.actions:get("V_ADVENT")

-- ;<ROUTINE V-AGAIN ("AUX" (OBJ <>))
-- 	 <COND (<EQUAL? ,L-PRSA ,V?WALK>
-- 		<DO-WALK ,L-PRSO>)
-- 	       (T
-- 		<COND (,L-PRSO
-- 		       <COND (<OR <NOT <LOC ,L-PRSO>>
-- 				  <FSET? ,L-PRSO ,INVISIBLE>>
-- 			      <SET OBJ ,L-PRSO>)>)>
-- 		<COND (,L-PRSI
-- 		       <COND (<OR <NOT <LOC ,L-PRSI>>
-- 				  <FSET? ,L-PRSI ,INVISIBLE>>
-- 			      <SET OBJ ,L-PRSI>)>)>
-- 		<COND (<AND .OBJ
-- 			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
-- 		       <TELL "You can't see the " D .OBJ " anymore." CR>
-- 		       <RFATAL>)
-- 		      (T
-- 		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>)>)>>

-- zil: gverbs.zil:175  <ROUTINE V-ALARM ()>
ZG.actions:register("V_ALARM", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        if ZG._T(ZG.NULL_F()) then
            do return true end
        else
            do return ZG.TELL("He's wide awake, or haven't you noticed...", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " isn't sleeping.", ZG._TK.CR) end
    end

end, "V-ALARM")

ZG.V_ALARM = ZG.actions:get("V_ALARM")

-- zil: gverbs.zil:189  <ROUTINE V-ANSWER ()>
ZG.actions:register("V_ANSWER", function()

    do local _ = ZG.TELL("Nobody seems to be awaiting your answer.", ZG._TK.CR) end
    ZG._set("P_CONT", false)
    ZG._set("QUOTE_FLAG", false)
    do return true end

end, "V-ANSWER")

ZG.V_ANSWER = ZG.actions:get("V_ANSWER")

-- zil: gverbs.zil:195  <ROUTINE V-ATTACK ()>
ZG.actions:register("V_ATTACK", function()

    if (not ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT"))) then
        do return ZG.TELL("I've known strange people, but fighting a ", ZG._TK.D, ZG.PRSO, "?", ZG._TK.CR) end
    elseif ((not ZG._T(ZG.PRSI)) or ZG.EQ(ZG.PRSI, ZG.HANDS)) then
        do return ZG.TELL("Trying to attack a ", ZG._TK.D, ZG.PRSO, " with your bare hands is suicidal.", ZG._TK.CR) end
    elseif (not ZG._T(ZG.IN_p(ZG.PRSI, ZG.WINNER))) then
        do return ZG.TELL("You aren't even holding the ", ZG._TK.D, ZG.PRSI, ".", ZG._TK.CR) end
    elseif (not ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT"))) then
        do return ZG.TELL("Trying to attack the ", ZG._TK.D, ZG.PRSO, " with a ", ZG._TK.D, ZG.PRSI, " is suicidal.", ZG._TK.CR) end
    else
        do return ZG.TELL("You can't.", ZG._TK.CR) end
    end

end, "V-ATTACK")

ZG.V_ATTACK = ZG.actions:get("V_ATTACK")

-- zil: gverbs.zil:214  <ROUTINE V-BACK ()>
ZG.actions:register("V_BACK", function()

    do return ZG.TELL("Sorry, my memory is poor. Please give a direction.", ZG._TK.CR) end

end, "V-BACK")

ZG.V_BACK = ZG.actions:get("V_BACK")

-- zil: gverbs.zil:217  <ROUTINE V-BLAST ()>
ZG.actions:register("V_BLAST", function()

    do return ZG.TELL("You can't blast anything by using words.", ZG._TK.CR) end

end, "V-BLAST")

ZG.V_BLAST = ZG.actions:get("V_BLAST")

-- zil: gverbs.zil:220  <ROUTINE PRE-BOARD ("AUX" AV)>
ZG.actions:register("PRE_BOARD", function()

    local AV = 0
    AV = ZG.LOC(ZG.WINNER)
    if ZG.EQUAL_p(ZG.PRSO, ZG.WATER_CHANNEL, ZG.TM_SEAT, ZG.LAKE) then
        do return false end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "VEHBIT")) then
        if (not ZG._T(ZG.IN_p(ZG.PRSO, ZG.HERE))) then
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " must be on the ground to be boarded.", ZG._TK.CR) end
        elseif ZG._T(ZG.FSET_p(AV, "VEHBIT")) then
            do local _ = ZG.TELL("You are already in the ", ZG._TK.D, AV, "!", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQUAL_p(ZG.PRSO, ZG.WATER, ZG.GLOBAL_WATER) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?SWIM"), ZG.PRSO) end
        do return true end
    else
        do local _ = ZG.TELL("You have a theory on how to board a ", ZG._TK.D, ZG.PRSO, ", perhaps?", ZG._TK.CR) end
    end
    do return 2 end

end, "PRE-BOARD")

ZG.PRE_BOARD = ZG.actions:get("PRE_BOARD")

-- zil: gverbs.zil:243  <ROUTINE V-BOARD ("AUX" AV)>
ZG.actions:register("V_BOARD", function()

    local AV = 0
    do local _ = ZG.TELL("You are now in the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    do local _ = ZG.MOVE(ZG.WINNER, ZG.PRSO) end
    do local _ = ZG.APPLY(ZG.GETP(ZG.PRSO, "ACTION"), ZG.M_ENTER) end
    do return true end

end, "V-BOARD")

ZG.V_BOARD = ZG.actions:get("V_BOARD")

-- zil: gverbs.zil:249  <ROUTINE V-BREATHE ()>
ZG.actions:register("V_BREATHE", function()

    do return ZG.PERFORM(ZG.SYMBOL("V?INFLATE"), ZG.PRSO, ZG.LUNGS) end

end, "V-BREATHE")

ZG.V_BREATHE = ZG.actions:get("V_BREATHE")

-- zil: gverbs.zil:252  <ROUTINE V-BRUSH ()>
ZG.actions:register("V_BRUSH", function()

    do return ZG.TELL("If you wish, but heaven only knows why.", ZG._TK.CR) end

end, "V-BRUSH")

ZG.V_BRUSH = ZG.actions:get("V_BRUSH")

-- zil: gverbs.zil:255  <ROUTINE V-BUG ()>
ZG.actions:register("V_BUG", function()

    do return ZG.TELL("Bug? Not in a flawless program like this! (Cough, cough).", ZG._TK.CR) end

end, "V-BUG")

ZG.V_BUG = ZG.actions:get("V_BUG")

-- zil: gverbs.zil:259  <ROUTINE TELL-NO-PRSI ()>
ZG.actions:register("TELL_NO_PRSI", function()

    do return ZG.TELL("You didn't say with what!", ZG._TK.CR) end

end, "TELL-NO-PRSI")

ZG.TELL_NO_PRSI = ZG.actions:get("TELL_NO_PRSI")

-- zil: gverbs.zil:262  <ROUTINE PRE-BURN ()>
ZG.actions:register("PRE_BURN", function()

    if (not ZG._T(ZG.PRSI)) then
        do return ZG.TELL_NO_PRSI() end
    elseif ZG._T(ZG.FLAMING_p(ZG.PRSI)) then
        do return false end
    else
        do return ZG.TELL("With a ", ZG._TK.D, ZG.PRSI, "??!?", ZG._TK.CR) end
    end

end, "PRE-BURN")

ZG.PRE_BURN = ZG.actions:get("PRE_BURN")

-- zil: gverbs.zil:270  <ROUTINE V-BURN ()>
ZG.actions:register("V_BURN", function()

    if ZG._T(ZG.NULL_F()) then
        do return false end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "BURNBIT")) then
        if (ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER)) or ZG._T(ZG.IN_p(ZG.WINNER, ZG.PRSO))) then
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO) end
            do local _ = ZG.TELL(" catches fire. Unfortunately, you were ") end
            if ZG._T(ZG.IN_p(ZG.WINNER, ZG.PRSO)) then
                do local _ = ZG.TELL("in") end
            else
                do local _ = ZG.TELL("holding") end
            end
            do return ZG.JIGS_UP(" it at the time.") end
        else
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " catches fire and is consumed.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("You can't burn a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    end

end, "V-BURN")

ZG.V_BURN = ZG.actions:get("V_BURN")

-- zil: gverbs.zil:295  <ROUTINE V-CHOMP ()>
ZG.actions:register("V_CHOMP", function()

    do return ZG.TELL("Preposterous!", ZG._TK.CR) end

end, "V-CHOMP")

ZG.V_CHOMP = ZG.actions:get("V_CHOMP")

-- zil: gverbs.zil:298  <ROUTINE V-CLIMB-DOWN ()>
ZG.actions:register("V_CLIMB_DOWN", function()

    do return ZG.V_CLIMB_UP("DOWN", ZG.PRSO) end

end, "V-CLIMB-DOWN")

ZG.V_CLIMB_DOWN = ZG.actions:get("V_CLIMB_DOWN")

-- zil: gverbs.zil:300  <ROUTINE V-CLIMB-FOO ()>
ZG.actions:register("V_CLIMB_FOO", function()

    local _tmp1, _tmp2
    if ZG.EQUAL_p(ZG.PRSO, ZG.ROPE, ZG.GLOBAL_ROPE) then
        _tmp1 = "DOWN"
    else
        _tmp1 = "UP"
    end
    if ZG.EQUAL_p(ZG.PRSO, ZG.ROPE, ZG.GLOBAL_ROPE) then
        _tmp2 = "DOWN"
    else
        _tmp2 = "UP"
    end
    do return ZG.V_CLIMB_UP(_tmp2, true) end

end, "V-CLIMB-FOO")

ZG.V_CLIMB_FOO = ZG.actions:get("V_CLIMB_FOO")

-- zil: gverbs.zil:309  <ROUTINE V-CLIMB-ON ()>
ZG.actions:register("V_CLIMB_ON", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "VEHBIT")) then
        do local _ = ZG.V_CLIMB_UP("UP", true) end
        do return true end
    else
        do return ZG.TELL("You can't climb onto the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    end

end, "V-CLIMB-ON")

ZG.V_CLIMB_ON = ZG.actions:get("V_CLIMB_ON")

-- zil: gverbs.zil:319  <ROUTINE V-CLIMB-UP ("OPTIONAL" (DIR ,P?UP) (OBJ <>) "AUX" X TX)>
ZG.actions:register("V_CLIMB_UP", function(DIR, OBJ)

    if DIR == nil then DIR = "UP" end
    if OBJ == nil then OBJ = false end
    local X = 0
    local TX = 0
    if (ZG._T(OBJ) and (not ZG.EQ(ZG.PRSO, ZG.ROOMS))) then
        OBJ = ZG.PRSO
    end
    if ZG._T((function() TX = ZG.GETPT(ZG.HERE, DIR); return TX end)()) then
        if ZG._T(OBJ) then
            X = ZG.PTSIZE(TX)
            if (ZG.EQ(X, ZG.NEXIT) or (ZG.EQUAL_p(X, ZG.CEXIT, ZG.DEXIT, ZG.UEXIT) and (not ZG._T(ZG.GLOBAL_IN_p(ZG.PRSO, ZG.GETB(TX, 0)))))) then
                do local _ = ZG.TELL("The ", ZG._TK.D, OBJ, " do") end
                if (not ZG.EQ(OBJ, ZG.STAIRS)) then
                    do local _ = ZG.TELL("es") end
                end
                do local _ = ZG.TELL("n't lead ") end
                if ZG.EQ(DIR, "UP") then
                    do local _ = ZG.TELL("up") end
                else
                    do local _ = ZG.TELL("down") end
                end
                do local _ = ZG.TELL("ward.", ZG._TK.CR) end
                do return true end
            end
        end
        do local _ = ZG.DO_WALK(DIR) end
        do return true end
    elseif (ZG._T(OBJ) and ZG._T(ZG.ZMEMQ(ZG.WORD("wall"), (function() X = ZG.GETPT(ZG.PRSO, "SYNONYM"); return X end)(), ZG.PTSIZE(X)))) then
        do return ZG.TELL("Climbing the walls is to no avail.", ZG._TK.CR) end
    elseif ZG._T(ZG.NULL_F()) then
        do local _ = ZG.TELL("There are no climbable trees here.", ZG._TK.CR) end
        do return true end
    elseif ZG.EQUAL_p(OBJ, false, ZG.ROOMS) then
        do return ZG.TELL("You can't go that way.", ZG._TK.CR) end
    else
        do return ZG.TELL("You can't do that!", ZG._TK.CR) end
    end

end, "V-CLIMB-UP")

ZG.V_CLIMB_UP = ZG.actions:get("V_CLIMB_UP")

-- zil: gverbs.zil:355  <ROUTINE V-CLOSE ()>
ZG.actions:register("V_CLOSE", function()

    if ((not ZG._T(ZG.FSET_p(ZG.PRSO, "CONTBIT"))) and (not ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT")))) then
        do return ZG.TELL("You must tell me how to do that to a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    elseif ((not ZG._T(ZG.FSET_p(ZG.PRSO, "SURFACEBIT"))) and (not ZG.EQ(ZG.GETP(ZG.PRSO, "CAPACITY"), 0))) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do local _ = ZG.FCLEAR(ZG.PRSO, "OPENBIT") end
            do local _ = ZG.TELL("Closed.", ZG._TK.CR) end
            if (ZG._T(ZG.LIT) and (not ZG._T(ZG._set("LIT", ZG.LIT_p(ZG.HERE))))) then
                do local _ = ZG.TELL("It is now pitch black.", ZG._TK.CR) end
            end
            do return true end
        else
            do return ZG.TELL("It is already closed.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do local _ = ZG.FCLEAR(ZG.PRSO, "OPENBIT") end
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is now closed.", ZG._TK.CR) end
        else
            do return ZG.TELL("It is already closed.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("You cannot close that.", ZG._TK.CR) end
    end

end, "V-CLOSE")

ZG.V_CLOSE = ZG.actions:get("V_CLOSE")

-- zil: gverbs.zil:378  <ROUTINE V-COMMAND ()>
ZG.actions:register("V_COMMAND", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " pays no attention.", ZG._TK.CR) end
    else
        do return ZG.TELL("You cannot talk to that!", ZG._TK.CR) end
    end

end, "V-COMMAND")

ZG.V_COMMAND = ZG.actions:get("V_COMMAND")

-- zil: gverbs.zil:384  <ROUTINE V-COUNT ()>
ZG.actions:register("V_COUNT", function()

    if ZG.EQ(ZG.PRSO, ZG.BLESSINGS) then
        do return ZG.TELL("Well, for one, you are playing Zork...", ZG._TK.CR) end
    else
        do return ZG.TELL("You have lost your mind.", ZG._TK.CR) end
    end

end, "V-COUNT")

ZG.V_COUNT = ZG.actions:get("V_COUNT")

-- zil: gverbs.zil:390  <ROUTINE V-CROSS ()>
ZG.actions:register("V_CROSS", function()

    do return ZG.TELL("You can't cross that!", ZG._TK.CR) end

end, "V-CROSS")

ZG.V_CROSS = ZG.actions:get("V_CROSS")

-- zil: gverbs.zil:393  <ROUTINE V-CURSES ()>
ZG.actions:register("V_CURSES", function()

    if ZG._T(ZG.PRSO) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
            do return ZG.TELL("Insults of this nature won't help you.", ZG._TK.CR) end
        else
            do return ZG.TELL("What a loony!", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("Such language in a high-class establishment like this!", ZG._TK.CR) end
    end

end, "V-CURSES")

ZG.V_CURSES = ZG.actions:get("V_CURSES")

-- zil: gverbs.zil:403  <ROUTINE V-CUT ()>
ZG.actions:register("V_CUT", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do return ZG.PERFORM(ZG.SYMBOL("V?ATTACK"), ZG.PRSO, ZG.PRSI) end
    elseif (ZG._T(ZG.FSET_p(ZG.PRSO, "BURNBIT")) and ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT"))) then
        if ZG._T(ZG.IN_p(ZG.WINNER, ZG.PRSO)) then
            do local _ = ZG.TELL("Not a bright idea, especially since you're in it.", ZG._TK.CR) end
            do return true end
        end
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        do return ZG.TELL("Your skillful ", ZG._TK.D, ZG.PRSI, "smanship slices the ", ZG._TK.D, ZG.PRSO, " into innumerable slivers which blow away.", ZG._TK.CR) end
    elseif (not ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT"))) then
        do return ZG.TELL("The \"cutting edge\" of a ", ZG._TK.D, ZG.PRSI, " is hardly adequate.", ZG._TK.CR) end
    else
        do return ZG.TELL("Strange concept, cutting the ", ZG._TK.D, ZG.PRSO, "....", ZG._TK.CR) end
    end

end, "V-CUT")

ZG.V_CUT = ZG.actions:get("V_CUT")

-- zil: gverbs.zil:421  <ROUTINE V-DEFLATE ()>
ZG.actions:register("V_DEFLATE", function()

    do return ZG.TELL("Come on, now!", ZG._TK.CR) end

end, "V-DEFLATE")

ZG.V_DEFLATE = ZG.actions:get("V_DEFLATE")

-- zil: gverbs.zil:424  <ROUTINE V-DIG ()>
ZG.actions:register("V_DIG", function()

    if (not ZG._T(ZG.PRSI)) then
        ZG._set("PRSI", ZG.HANDS)
    end
    if ZG._T(ZG.FSET_p(ZG.PRSI, "TOOLBIT")) then
        do return ZG.TELL("Digging with the ", ZG._TK.D, ZG.PRSI, " is slow and tedious.", ZG._TK.CR) end
    else
        do return ZG.TELL("Digging with a ", ZG._TK.D, ZG.PRSI, " is silly.", ZG._TK.CR) end
    end

end, "V-DIG")

ZG.V_DIG = ZG.actions:get("V_DIG")

-- zil: gverbs.zil:437  <ROUTINE V-DISEMBARK ()>
ZG.actions:register("V_DISEMBARK", function()

    if (ZG.EQ(ZG.PRSO, ZG.ROOMS) and ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT"))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DISEMBARK"), ZG.LOC(ZG.WINNER)) end
        do return true end
    elseif (not ZG.EQ(ZG.LOC(ZG.WINNER), ZG.PRSO)) then
        do local _ = ZG.TELL("You're not in that!", ZG._TK.CR) end
        do return 2 end
    elseif ZG._T(ZG.FSET_p(ZG.HERE, "RLANDBIT")) then
        do local _ = ZG.TELL("You are on your own feet again.", ZG._TK.CR) end
        do return ZG.MOVE(ZG.WINNER, ZG.HERE) end
    else
        do local _ = ZG.TELL("You realize that getting out here would be fatal.", ZG._TK.CR) end
        do return 2 end
    end

end, "V-DISEMBARK")

ZG.V_DISEMBARK = ZG.actions:get("V_DISEMBARK")

-- zil: gverbs.zil:453  <ROUTINE V-DISENCHANT ()>
ZG.actions:register("V_DISENCHANT", function()

    do return ZG.TELL("Nothing happens.", ZG._TK.CR) end

end, "V-DISENCHANT")

ZG.V_DISENCHANT = ZG.actions:get("V_DISENCHANT")

-- zil: gverbs.zil:487  <ROUTINE V-DRINK ()>
ZG.actions:register("V_DRINK", function()

    do return ZG.V_EAT() end

end, "V-DRINK")

ZG.V_DRINK = ZG.actions:get("V_DRINK")

-- zil: gverbs.zil:490  <ROUTINE V-DRINK-FROM ()>
ZG.actions:register("V_DRINK_FROM", function()

    do return ZG.TELL("How peculiar!", ZG._TK.CR) end

end, "V-DRINK-FROM")

ZG.V_DRINK_FROM = ZG.actions:get("V_DRINK_FROM")

-- zil: gverbs.zil:493  <ROUTINE PRE-DROP ()>
ZG.actions:register("PRE_DROP", function()

    if ZG.EQ(ZG.PRSO, ZG.LOC(ZG.WINNER)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DISEMBARK"), ZG.PRSO) end
        do return true end
    else
        do return false end
    end

end, "PRE-DROP")

ZG.PRE_DROP = ZG.actions:get("PRE_DROP")

-- zil: gverbs.zil:498  <ROUTINE V-DROP ()>
ZG.actions:register("V_DROP", function()

    if ZG._T(ZG.IDROP()) then
        do return ZG.TELL("Dropped.", ZG._TK.CR) end
    else
        do return false end
    end

end, "V-DROP")

ZG.V_DROP = ZG.actions:get("V_DROP")

-- zil: gverbs.zil:502  <ROUTINE V-EAT ("AUX" (EAT? <>) (DRINK? <>) (NOBJ <>))>
ZG.actions:register("V_EAT", function()

    local EAT_p = false
    local DRINK_p = false
    local NOBJ = false
    if ZG._T((function() EAT_p = ZG.FSET_p(ZG.PRSO, "FOODBIT"); return EAT_p end)()) then
        if ((not ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) and (not ZG._T(ZG.IN_p(ZG.LOC(ZG.PRSO), ZG.WINNER)))) then
            do local _ = ZG.TELL("You're not holding that.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("DRINK")) then
            do local _ = ZG.TELL("How can you drink that?") end
        else
            do local _ = ZG.TELL("Thank you very much. It really hit the spot.") end
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "DRINKBIT")) then
        DRINK_p = true
        NOBJ = ZG.LOC(ZG.PRSO)
        if (ZG._T(ZG.IN_p(ZG.PRSO, ZG.GLOBAL_OBJECTS)) or ZG._T(ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE)) or ZG.EQ(ZG.PRSO, ZG.PSEUDO_OBJECT)) then
            do return ZG.HIT_SPOT() end
        elseif ((not ZG._T(NOBJ)) or (not ZG._T(ZG.ACCESSIBLE_p(NOBJ)))) then
            do return ZG.TELL("There isn't any water here.", ZG._TK.CR) end
        elseif (ZG._T(ZG.ACCESSIBLE_p(NOBJ)) and (not ZG._T(ZG.IN_p(NOBJ, ZG.WINNER)))) then
            do return ZG.TELL("You have to be holding the ", ZG._TK.D, NOBJ, " first.", ZG._TK.CR) end
        elseif (not ZG._T(ZG.FSET_p(NOBJ, "OPENBIT"))) then
            do return ZG.TELL("You'll have to open the ", ZG._TK.D, NOBJ, " first.", ZG._TK.CR) end
        else
            do return ZG.HIT_SPOT() end
        end
    elseif (not (ZG._T(EAT_p) or ZG._T(DRINK_p))) then
        do return ZG.TELL("I don't think that the ", ZG._TK.D, ZG.PRSO, " would agree with you.", ZG._TK.CR) end
    else
        do return false end
    end

end, "V-EAT")

ZG.V_EAT = ZG.actions:get("V_EAT")

-- zil: gverbs.zil:537  <ROUTINE HIT-SPOT ()>
ZG.actions:register("HIT_SPOT", function()

    if (ZG.EQ(ZG.PRSO, ZG.WATER) and (not ZG._T(ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE)))) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
    end
    do return ZG.TELL("Thank you very much. I was rather thirsty (from all this talking,\nprobably).", ZG._TK.CR) end

end, "HIT-SPOT")

ZG.HIT_SPOT = ZG.actions:get("HIT_SPOT")

-- zil: gverbs.zil:545  <ROUTINE V-ECHO ("AUX" LST MAX (ECH 0) CNT)>
ZG.actions:register("V_ECHO", function()

    local LST = 0
    local MAX = 0
    local ECH = 0
    local CNT = 0
    do return ZG.TELL("echo echo ...", ZG._TK.CR) end

end, "V-ECHO")

ZG.V_ECHO = ZG.actions:get("V_ECHO")

-- zil: gverbs.zil:569  <ROUTINE V-ENCHANT ()>
ZG.actions:register("V_ENCHANT", function()

    do local _ = ZG.NULL_F() end
    do return ZG.V_DISENCHANT() end

end, "V-ENCHANT")

ZG.V_ENCHANT = ZG.actions:get("V_ENCHANT")

-- zil: gverbs.zil:629  <ROUTINE REMOVE-CAREFULLY (OBJ "AUX" OLIT)>
ZG.actions:register("REMOVE_CAREFULLY", function(OBJ)

    local OLIT = 0
    if ZG.EQ(OBJ, ZG.P_IT_OBJECT) then
        ZG._set("P_IT_OBJECT", false)
    end
    OLIT = ZG.LIT
    do local _ = ZG.REMOVE(OBJ) end
    ZG._set("LIT", ZG.LIT_p(ZG.HERE))
    if (ZG._T(OLIT) and (not ZG.EQ(OLIT, ZG.LIT))) then
        do local _ = ZG.TELL("You are left in the dark...", ZG._TK.CR) end
    end
    do return true end

end, "REMOVE-CAREFULLY")

ZG.REMOVE_CAREFULLY = ZG.actions:get("REMOVE_CAREFULLY")

-- zil: gverbs.zil:639  <ROUTINE V-ENTER ()>
ZG.actions:register("V_ENTER", function()

    do return ZG.DO_WALK("IN") end

end, "V-ENTER")

ZG.V_ENTER = ZG.actions:get("V_ENTER")

-- zil: gverbs.zil:642  <ROUTINE V-EXAMINE ()>
ZG.actions:register("V_EXAMINE", function()

    if ZG._T(ZG.GETP(ZG.PRSO, "TEXT")) then
        do return ZG.TELL(ZG.GETP(ZG.PRSO, "TEXT"), ZG._TK.CR) end
    elseif (ZG._T(ZG.FSET_p(ZG.PRSO, "CONTBIT")) or ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT"))) then
        do return ZG.V_LOOK_INSIDE() end
    else
        do return ZG.TELL("There's nothing special about the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    end

end, "V-EXAMINE")

ZG.V_EXAMINE = ZG.actions:get("V_EXAMINE")

-- zil: gverbs.zil:651  <ROUTINE V-EXIT ()>
ZG.actions:register("V_EXIT", function()

    if (ZG.EQUAL_p(ZG.PRSO, false, ZG.ROOMS) and ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT"))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DISEMBARK"), ZG.LOC(ZG.WINNER)) end
        do return true end
    elseif (ZG._T(ZG.PRSO) and ZG._T(ZG.IN_p(ZG.WINNER, ZG.PRSO))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DISEMBARK"), ZG.PRSO) end
        do return true end
    else
        do return ZG.DO_WALK("OUT") end
    end

end, "V-EXIT")

ZG.V_EXIT = ZG.actions:get("V_EXIT")

-- zil: gverbs.zil:662  <ROUTINE V-EXORCISE ()>
ZG.actions:register("V_EXORCISE", function()

    do return ZG.TELL("What a bizarre concept!", ZG._TK.CR) end

end, "V-EXORCISE")

ZG.V_EXORCISE = ZG.actions:get("V_EXORCISE")

-- zil: gverbs.zil:665  <ROUTINE PRE-FILL ("AUX" TX)>
ZG.actions:register("PRE_FILL", function()

    local TX = 0
    if (not ZG._T(ZG.PRSI)) then
        TX = ZG.GETPT(ZG.HERE, "GLOBAL")
        if (ZG._T(TX) and ZG._T(ZG.ZMEMQB(ZG.GLOBAL_WATER, TX, ZG.SUB(ZG.PTSIZE(TX), 1)))) then
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?FILL"), ZG.PRSO, ZG.GLOBAL_WATER) end
            do return true end
        elseif ZG._T(ZG.IN_p(ZG.WATER, ZG.LOC(ZG.WINNER))) then
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?FILL"), ZG.PRSO, ZG.WATER) end
            do return true end
        else
            do local _ = ZG.TELL("There is nothing to fill it with.", ZG._TK.CR) end
            do return true end
        end
    end
    if ZG.EQ(ZG.PRSI, ZG.WATER) then
        do return false end
    elseif (not ZG.EQ(ZG.PRSI, ZG.GLOBAL_WATER)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?PUT"), ZG.PRSI, ZG.PRSO) end
        do return true end
    else
        do return false end
    end

end, "PRE-FILL")

ZG.PRE_FILL = ZG.actions:get("PRE_FILL")

-- ;"OLD ZORK1 PRE-FILL"

-- ;<ROUTINE PRE-FILL ("AUX" TX)
-- 	 <COND (<NOT ,PRSI>
-- 		<COND (<AND <SET TX <GETPT ,HERE ,P?GLOBAL>>
-- 			    <ZMEMQB ,GLOBAL-WATER .TX <- <PTSIZE .TX> 1>>>
-- 		       <SETG PRSI ,GLOBAL-WATER>
-- 		       <RFALSE>)
-- 		      (T
-- 		       <TELL "There is nothing to fill it with." CR>
-- 		       <RTRUE>)>)
-- 	       (<NOT <EQUAL? ,PRSI ,GLOBAL-WATER>>
-- 		<PERFORM ,V?PUT ,PRSI ,PRSO>
-- 		<RTRUE>)>>

-- zil: gverbs.zil:697  <ROUTINE V-FILL ()>
ZG.actions:register("V_FILL", function()

    if (not ZG._T(ZG.PRSI)) then
        if ZG._T(ZG.GLOBAL_IN_p(ZG.GLOBAL_WATER, ZG.HERE)) then
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?FILL"), ZG.PRSO, ZG.GLOBAL_WATER) end
            do return true end
        elseif ZG._T(ZG.IN_p(ZG.WATER, ZG.LOC(ZG.WINNER))) then
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?FILL"), ZG.PRSO, ZG.WATER) end
            do return true end
        else
            do return ZG.TELL("There's nothing to fill it with.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("You may know how to do that, but I don't.", ZG._TK.CR) end
    end

end, "V-FILL")

ZG.V_FILL = ZG.actions:get("V_FILL")

-- zil: gverbs.zil:710  <ROUTINE V-FIND ("AUX" (L <LOC ,PRSO>))>
ZG.actions:register("V_FIND", function()

    local L = ZG.LOC(ZG.PRSO)
    if ZG.EQUAL_p(ZG.PRSO, ZG.HANDS, ZG.LUNGS) then
        do return ZG.TELL("Within six feet of your head, assuming you haven't left that\nsomewhere.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.PRSO, ZG.ME) then
        do return ZG.TELL("You're around here somewhere...", ZG._TK.CR) end
    elseif ZG.EQ(L, ZG.GLOBAL_OBJECTS) then
        do return ZG.TELL("You find it.", ZG._TK.CR) end
    elseif ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER)) then
        do return ZG.TELL("You have it.", ZG._TK.CR) end
    elseif (ZG._T(ZG.IN_p(ZG.PRSO, ZG.HERE)) or ZG._T(ZG.GLOBAL_IN_p(ZG.PRSO, ZG.HERE)) or ZG.EQ(ZG.PRSO, ZG.PSEUDO_OBJECT)) then
        do return ZG.TELL("It's right here.", ZG._TK.CR) end
    elseif ZG._T(ZG.FSET_p(L, "ACTORBIT")) then
        do return ZG.TELL("The ", ZG._TK.D, L, " has it.", ZG._TK.CR) end
    elseif ZG._T(ZG.FSET_p(L, "SURFACEBIT")) then
        do return ZG.TELL("It's on the ", ZG._TK.D, L, ".", ZG._TK.CR) end
    elseif ZG._T(ZG.FSET_p(L, "CONTBIT")) then
        do return ZG.TELL("It's in the ", ZG._TK.D, L, ".", ZG._TK.CR) end
    else
        do return ZG.TELL("Beats me.", ZG._TK.CR) end
    end

end, "V-FIND")

ZG.V_FIND = ZG.actions:get("V_FIND")

-- zil: gverbs.zil:734  <ROUTINE V-FOLLOW ()>
ZG.actions:register("V_FOLLOW", function()

    do return ZG.TELL("You're nuts!", ZG._TK.CR) end

end, "V-FOLLOW")

ZG.V_FOLLOW = ZG.actions:get("V_FOLLOW")

-- zil: gverbs.zil:737  <ROUTINE V-FROBOZZ ()>
ZG.actions:register("V_FROBOZZ", function()

    do return ZG.TELL("The FROBOZZ Corporation created, owns, and operates this dungeon.", ZG._TK.CR) end

end, "V-FROBOZZ")

ZG.V_FROBOZZ = ZG.actions:get("V_FROBOZZ")

-- zil: gverbs.zil:741  <ROUTINE PRE-GIVE ()>
ZG.actions:register("PRE_GIVE", function()

    if (not ZG._T(ZG.HELD_p(ZG.PRSO))) then
        do return ZG.TELL("That's easy for you to say since you don't even have the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRE-GIVE")

ZG.PRE_GIVE = ZG.actions:get("PRE_GIVE")

-- zil: gverbs.zil:746  <ROUTINE V-GIVE ()>
ZG.actions:register("V_GIVE", function()

    if (not ZG._T(ZG.FSET_p(ZG.PRSI, "ACTORBIT"))) then
        do return ZG.TELL("You can't give a ", ZG._TK.D, ZG.PRSO, " to a ", ZG._TK.D, ZG.PRSI, "!", ZG._TK.CR) end
    else
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSI, " refuses it politely.", ZG._TK.CR) end
    end

end, "V-GIVE")

ZG.V_GIVE = ZG.actions:get("V_GIVE")

-- zil: gverbs.zil:752  <ROUTINE V-HATCH ()>
ZG.actions:register("V_HATCH", function()

    do return ZG.TELL("Bizarre!", ZG._TK.CR) end

end, "V-HATCH")

ZG.V_HATCH = ZG.actions:get("V_HATCH")

-- zil: gverbs.zil:755  <GLOBAL HS>
-- HS is declared in ZilGlobal.lua

-- ;"counts occurences of HELLO, SAILOR"

-- zil: gverbs.zil:757  <ROUTINE V-HELLO ()>
ZG.actions:register("V_HELLO", function()

    if ZG._T(ZG.PRSO) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " bows his head to you in greeting.", ZG._TK.CR) end
        else
            do return ZG.TELL("It's a well known fact that only schizophrenics say \"Hello\" to a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
        end
    else
        do return ZG.TELL(ZG.PICK_ONE(ZG.HELLOS), ZG._TK.CR) end
    end

end, "V-HELLO")

ZG.V_HELLO = ZG.actions:get("V_HELLO")

-- zil: gverbs.zil:769  <ROUTINE V-INCANT ()>
ZG.actions:register("V_INCANT", function()

    do local _ = ZG.TELL("The incantation echoes back faintly, but nothing else happens.", ZG._TK.CR) end
    ZG._set("QUOTE_FLAG", false)
    ZG._set("P_CONT", false)
    do return true end

end, "V-INCANT")

ZG.V_INCANT = ZG.actions:get("V_INCANT")

-- zil: gverbs.zil:790  <ROUTINE V-INFLATE ()>
ZG.actions:register("V_INFLATE", function()

    do return ZG.TELL("How can you inflate that?", ZG._TK.CR) end

end, "V-INFLATE")

ZG.V_INFLATE = ZG.actions:get("V_INFLATE")

-- ;<ROUTINE V-IS-IN ()
-- 	 <COND (<IN? ,PRSO ,PRSI>
-- 		<TELL "Yes, it is ">
-- 		<COND (<FSET? ,PRSI ,SURFACEBIT>
-- 		       <TELL "on">)
-- 		      (T
-- 		       <TELL "in">)>
-- 		<TELL " the " D ,PRSI "." CR>)
-- 	       (T
-- 		<TELL "No, it isn't." CR>)>>

-- zil: gverbs.zil:804  <ROUTINE V-KICK ()>
ZG.actions:register("V_KICK", function()

    do return ZG.HACK_HACK("Kicking the ") end

end, "V-KICK")

ZG.V_KICK = ZG.actions:get("V_KICK")

-- zil: gverbs.zil:806  <ROUTINE V-KISS ()>
ZG.actions:register("V_KISS", function()

    do return ZG.TELL("I'd sooner kiss a pig.", ZG._TK.CR) end

end, "V-KISS")

ZG.V_KISS = ZG.actions:get("V_KISS")

-- zil: gverbs.zil:809  <ROUTINE V-KNOCK ()>
ZG.actions:register("V_KNOCK", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT")) then
        do return ZG.TELL("Nobody's home.", ZG._TK.CR) end
    else
        do return ZG.TELL("Why knock on a ", ZG._TK.D, ZG.PRSO, "?", ZG._TK.CR) end
    end

end, "V-KNOCK")

ZG.V_KNOCK = ZG.actions:get("V_KNOCK")

-- zil: gverbs.zil:815  <ROUTINE V-LAMP-OFF ()>
ZG.actions:register("V_LAMP_OFF", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "LIGHTBIT")) then
        if (not ZG._T(ZG.FSET_p(ZG.PRSO, "ONBIT"))) then
            do local _ = ZG.TELL("It is already off.", ZG._TK.CR) end
        else
            do local _ = ZG.FCLEAR(ZG.PRSO, "ONBIT") end
            if ZG._T(ZG.LIT) then
                ZG._set("LIT", ZG.LIT_p(ZG.HERE))
            end
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is now off.", ZG._TK.CR) end
            if (not ZG._T(ZG.LIT)) then
                do local _ = ZG.TELL("It is now pitch black.", ZG._TK.CR) end
            end
        end
    else
        do local _ = ZG.TELL("You can't turn that off.", ZG._TK.CR) end
    end
    do return true end

end, "V-LAMP-OFF")

ZG.V_LAMP_OFF = ZG.actions:get("V_LAMP_OFF")

-- zil: gverbs.zil:830  <ROUTINE V-LAMP-ON ()>
ZG.actions:register("V_LAMP_ON", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "LIGHTBIT")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "ONBIT")) then
            do local _ = ZG.TELL("It is already on.", ZG._TK.CR) end
        else
            do local _ = ZG.FSET(ZG.PRSO, "ONBIT") end
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is now on.", ZG._TK.CR) end
            if (not ZG._T(ZG.LIT)) then
                ZG._set("LIT", ZG.LIT_p(ZG.HERE))
                do local _ = ZG.CRLF() end
                do local _ = ZG.V_LOOK() end
            end
        end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "BURNBIT")) then
        do local _ = ZG.TELL("If you wish to burn the ", ZG._TK.D, ZG.PRSO, ", you should say so.", ZG._TK.CR) end
    else
        do local _ = ZG.TELL("You can't turn that on.", ZG._TK.CR) end
    end
    do return true end

end, "V-LAMP-ON")

ZG.V_LAMP_ON = ZG.actions:get("V_LAMP_ON")

-- zil: gverbs.zil:848  <ROUTINE V-LAUNCH ()>
ZG.actions:register("V_LAUNCH", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "VEHBIT")) then
        do return ZG.TELL("You can't launch that by saying \"launch\"!", ZG._TK.CR) end
    else
        do return ZG.TELL("That's pretty weird.", ZG._TK.CR) end
    end

end, "V-LAUNCH")

ZG.V_LAUNCH = ZG.actions:get("V_LAUNCH")

-- zil: gverbs.zil:854  <ROUTINE V-LEAN-ON ()>
ZG.actions:register("V_LEAN_ON", function()

    do return ZG.TELL("Getting tired?", ZG._TK.CR) end

end, "V-LEAN-ON")

ZG.V_LEAN_ON = ZG.actions:get("V_LEAN_ON")

-- zil: gverbs.zil:857  <ROUTINE V-LEAP ("AUX" TX S)>
ZG.actions:register("V_LEAP", function()

    local TX = 0
    local S = 0
    if ZG._T(ZG.PRSO) then
        if ZG._T(ZG.IN_p(ZG.PRSO, ZG.HERE)) then
            if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is too big to jump over.", ZG._TK.CR) end
            else
                do return ZG.V_SKIP() end
            end
        else
            do return ZG.TELL("That would be a good trick.", ZG._TK.CR) end
        end
    elseif ZG._T((function() TX = ZG.GETPT(ZG.HERE, "DOWN"); return TX end)()) then
        S = ZG.PTSIZE(TX)
        if (ZG.EQ(S, 2) or (ZG.EQ(S, 4) and (not ZG._T(ZG.VALUE(ZG.GETB(TX, 1)))))) then
            do local _ = ZG.TELL("This was not a very safe place to try jumping.", ZG._TK.CR) end
            do return ZG.JIGS_UP(ZG.PICK_ONE(ZG.JUMPLOSS)) end
        elseif ZG._T(ZG.NULL_F()) then
            do return true end
        else
            do return ZG.V_SKIP() end
        end
    else
        do return ZG.V_SKIP() end
    end

end, "V-LEAP")

ZG.V_LEAP = ZG.actions:get("V_LEAP")

-- zil: gverbs.zil:888  <GLOBAL JUMPLOSS>
-- JUMPLOSS is declared in ZilGlobal.lua

-- zil: gverbs.zil:894  <ROUTINE V-LEAVE ()>
ZG.actions:register("V_LEAVE", function()

    do return ZG.DO_WALK("OUT") end

end, "V-LEAVE")

ZG.V_LEAVE = ZG.actions:get("V_LEAVE")

-- zil: gverbs.zil:896  <ROUTINE V-LISTEN ()>
ZG.actions:register("V_LISTEN", function()

    do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " makes no sound.", ZG._TK.CR) end

end, "V-LISTEN")

ZG.V_LISTEN = ZG.actions:get("V_LISTEN")

-- zil: gverbs.zil:899  <ROUTINE V-LOCK ()>
ZG.actions:register("V_LOCK", function()

    do return ZG.TELL("It doesn't seem to work.", ZG._TK.CR) end

end, "V-LOCK")

ZG.V_LOCK = ZG.actions:get("V_LOCK")

-- zil: gverbs.zil:902  <ROUTINE V-LOOK ()>
ZG.actions:register("V_LOOK", function()

    if ZG._T(ZG.DESCRIBE_ROOM(true)) then
        do return ZG.DESCRIBE_OBJECTS(true) end
    else
        do return false end
    end

end, "V-LOOK")

ZG.V_LOOK = ZG.actions:get("V_LOOK")

-- zil: gverbs.zil:906  <ROUTINE V-LOOK-BEHIND ()>
ZG.actions:register("V_LOOK_BEHIND", function()

    do return ZG.TELL("There is nothing behind the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end

end, "V-LOOK-BEHIND")

ZG.V_LOOK_BEHIND = ZG.actions:get("V_LOOK_BEHIND")

-- zil: gverbs.zil:909  <ROUTINE V-LOOK-INSIDE ()>
ZG.actions:register("V_LOOK_INSIDE", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is open, but I can't tell what's beyond it.") end
        else
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is closed.") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "CONTBIT")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
            do return ZG.TELL("There is nothing special to be seen.", ZG._TK.CR) end
        elseif ZG._T(ZG.SEE_INSIDE_p(ZG.PRSO)) then
            if (ZG._T(ZG.FIRST_p(ZG.PRSO)) and ZG._T(ZG.PRINT_CONT(ZG.PRSO))) then
                do return true end
            elseif ZG._T(ZG.FSET_p(ZG.PRSO, "SURFACEBIT")) then
                do return ZG.TELL("There is nothing on the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
            else
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is empty.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is closed.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("You can't look inside a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    end

end, "V-LOOK-INSIDE")

ZG.V_LOOK_INSIDE = ZG.actions:get("V_LOOK_INSIDE")

-- zil: gverbs.zil:936  <ROUTINE V-LOOK-ON ()>
ZG.actions:register("V_LOOK_ON", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "SURFACEBIT")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?LOOK-INSIDE"), ZG.PRSO) end
        do return true end
    else
        do return ZG.TELL("Look on a ", ZG._TK.D, ZG.PRSO, "???", ZG._TK.CR) end
    end

end, "V-LOOK-ON")

ZG.V_LOOK_ON = ZG.actions:get("V_LOOK_ON")

-- zil: gverbs.zil:943  <ROUTINE V-LOOK-UNDER ()>
ZG.actions:register("V_LOOK_UNDER", function()

    do return ZG.TELL("There is nothing but dust there.", ZG._TK.CR) end

end, "V-LOOK-UNDER")

ZG.V_LOOK_UNDER = ZG.actions:get("V_LOOK_UNDER")

-- zil: gverbs.zil:946  <ROUTINE V-LOWER ()>
ZG.actions:register("V_LOWER", function()

    do return ZG.HACK_HACK("Playing in this way with the ") end

end, "V-LOWER")

ZG.V_LOWER = ZG.actions:get("V_LOWER")

-- zil: gverbs.zil:948  <ROUTINE V-MAKE ()>
ZG.actions:register("V_MAKE", function()

    do return ZG.TELL("You can't do that.", ZG._TK.CR) end

end, "V-MAKE")

ZG.V_MAKE = ZG.actions:get("V_MAKE")

-- zil: gverbs.zil:951  <ROUTINE V-MELT ()>
ZG.actions:register("V_MELT", function()

    do return ZG.TELL("It's not clear that a ", ZG._TK.D, ZG.PRSO, " can be melted.", ZG._TK.CR) end

end, "V-MELT")

ZG.V_MELT = ZG.actions:get("V_MELT")

-- zil: gverbs.zil:954  <ROUTINE PRE-MOVE ()>
ZG.actions:register("PRE_MOVE", function()

    if ZG._T(ZG.HELD_p(ZG.PRSO)) then
        do return ZG.TELL("You aren't an accomplished enough juggler.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRE-MOVE")

ZG.PRE_MOVE = ZG.actions:get("PRE_MOVE")

-- zil: gverbs.zil:958  <ROUTINE V-MOVE ()>
ZG.actions:register("V_MOVE", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT")) then
        do return ZG.TELL("Moving the ", ZG._TK.D, ZG.PRSO, " reveals nothing.", ZG._TK.CR) end
    else
        do return ZG.TELL("You can't move the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    end

end, "V-MOVE")

ZG.V_MOVE = ZG.actions:get("V_MOVE")

-- zil: gverbs.zil:964  <ROUTINE V-MUMBLE ()>
ZG.actions:register("V_MUMBLE", function()

    do return ZG.TELL("You'll have to speak up if you expect me to hear you!", ZG._TK.CR) end

end, "V-MUMBLE")

ZG.V_MUMBLE = ZG.actions:get("V_MUMBLE")

-- zil: gverbs.zil:967  <ROUTINE PRE-MUNG ()>
ZG.actions:register("PRE_MUNG", function()

    if ZG.EQ(ZG.PRSO, ZG.BEAM) then
        do return false end
    elseif ((not ZG._T(ZG.PRSI)) or (not ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT")))) then
        do local _ = ZG.TELL("Trying to destroy the ", ZG._TK.D, ZG.PRSO, " with ") end
        if (not ZG._T(ZG.PRSI)) then
            do local _ = ZG.TELL("your bare hands") end
        else
            do local _ = ZG.TELL("a ", ZG._TK.D, ZG.PRSI) end
        end
        do return ZG.TELL(" is futile.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRE-MUNG")

ZG.PRE_MUNG = ZG.actions:get("PRE_MUNG")

-- zil: gverbs.zil:982  <ROUTINE V-MUNG ()>
ZG.actions:register("V_MUNG", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?ATTACK"), ZG.PRSO) end
        do return true end
    else
        do return ZG.TELL("Nice try.", ZG._TK.CR) end
    end

end, "V-MUNG")

ZG.V_MUNG = ZG.actions:get("V_MUNG")

-- zil: gverbs.zil:989  <ROUTINE V-ODYSSEUS ()>
ZG.actions:register("V_ODYSSEUS", function()

    if ZG._T(ZG.NULL_F()) then
        do return true end
    else
        do return ZG.TELL("Wasn't he a sailor?", ZG._TK.CR) end
    end

end, "V-ODYSSEUS")

ZG.V_ODYSSEUS = ZG.actions:get("V_ODYSSEUS")

-- zil: gverbs.zil:1007  <ROUTINE V-OIL ()>
ZG.actions:register("V_OIL", function()

    do return ZG.TELL("You probably put spinach in your gas tank, too.", ZG._TK.CR) end

end, "V-OIL")

ZG.V_OIL = ZG.actions:get("V_OIL")

-- zil: gverbs.zil:1010  <ROUTINE V-OPEN ("AUX" F STR)>
ZG.actions:register("V_OPEN", function()

    local F = 0
    local STR = 0
    if (ZG._T(ZG.FSET_p(ZG.PRSO, "CONTBIT")) and (not ZG.EQ(ZG.GETP(ZG.PRSO, "CAPACITY"), 0))) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do return ZG.TELL("It is already open.", ZG._TK.CR) end
        else
            do local _ = ZG.FSET(ZG.PRSO, "OPENBIT") end
            do local _ = ZG.FSET(ZG.PRSO, "TOUCHBIT") end
            if ((not ZG._T(ZG.FIRST_p(ZG.PRSO))) or ZG._T(ZG.FSET_p(ZG.PRSO, "TRANSBIT"))) then
                do return ZG.TELL("Opened.", ZG._TK.CR) end
            elseif (ZG._T((function() F = ZG.FIRST_p(ZG.PRSO); return F end)()) and (not ZG._T(ZG.NEXT_p(F))) and (not ZG._T(ZG.FSET_p(F, "TOUCHBIT"))) and ZG._T((function() STR = ZG.GETP(F, "FDESC"); return STR end)())) then
                do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " opens.", ZG._TK.CR) end
                do return ZG.TELL(STR, ZG._TK.CR) end
            else
                do local _ = ZG.TELL("Opening the ", ZG._TK.D, ZG.PRSO, " reveals ") end
                do local _ = ZG.PRINT_CONTENTS(ZG.PRSO) end
                do return ZG.TELL(".", ZG._TK.CR) end
            end
        end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do return ZG.TELL("It is already open.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " opens.", ZG._TK.CR) end
            do return ZG.FSET(ZG.PRSO, "OPENBIT") end
        end
    else
        do return ZG.TELL("You must tell me how to do that to a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    end

end, "V-OPEN")

ZG.V_OPEN = ZG.actions:get("V_OPEN")

-- zil: gverbs.zil:1040  <ROUTINE V-OVERBOARD ("AUX" LOCN)>
ZG.actions:register("V_OVERBOARD", function()

    local LOCN = 0
    if ZG._T(ZG.NULL_F()) then
        do return true end
    elseif ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?THROW"), ZG.PRSO) end
        do return true end
    else
        do return ZG.TELL("Huh?", ZG._TK.CR) end
    end

end, "V-OVERBOARD")

ZG.V_OVERBOARD = ZG.actions:get("V_OVERBOARD")

-- zil: gverbs.zil:1055  <ROUTINE V-PICK ()>
ZG.actions:register("V_PICK", function()

    do return ZG.TELL("You can't pick that.", ZG._TK.CR) end

end, "V-PICK")

ZG.V_PICK = ZG.actions:get("V_PICK")

-- zil: gverbs.zil:1057  <ROUTINE V-PLAY ()>
ZG.actions:register("V_PLAY", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do local _ = ZG.TELL("You become so engrossed in the role of the ", ZG._TK.D, ZG.PRSO, " that\nyou kill yourself, just as he might have done!", ZG._TK.CR) end
        do return ZG.JIGS_UP("") end
    else
        do return ZG.TELL("That's silly!", ZG._TK.CR) end
    end

end, "V-PLAY")

ZG.V_PLAY = ZG.actions:get("V_PLAY")

-- zil: gverbs.zil:1065  <ROUTINE V-PLUG ()>
ZG.actions:register("V_PLUG", function()

    do return ZG.TELL("This has no effect.", ZG._TK.CR) end

end, "V-PLUG")

ZG.V_PLUG = ZG.actions:get("V_PLUG")

-- zil: gverbs.zil:1068  <ROUTINE V-POUR-ON ()>
ZG.actions:register("V_POUR_ON", function()

    if ZG.EQ(ZG.PRSO, ZG.WATER) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        if ZG._T(ZG.FLAMING_p(ZG.PRSI)) then
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSI, " is extinguished.", ZG._TK.CR) end
            do local _ = ZG.NULL_F() end
            do local _ = ZG.FCLEAR(ZG.PRSI, "ONBIT") end
            do return ZG.FCLEAR(ZG.PRSI, "FLAMEBIT") end
        else
            do return ZG.TELL("The water spills over the ", ZG._TK.D, ZG.PRSI, ", to the floor, and evaporates.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.NULL_F()) then
        do return true end
    else
        do return ZG.TELL("You can't pour that.", ZG._TK.CR) end
    end

end, "V-POUR-ON")

ZG.V_POUR_ON = ZG.actions:get("V_POUR_ON")

-- zil: gverbs.zil:1090  <ROUTINE V-PRAY ()>
ZG.actions:register("V_PRAY", function()

    if ZG._T(ZG.NULL_F()) then
        do return true end
    else
        do return ZG.TELL("If you pray enough, your prayers may be answered.", ZG._TK.CR) end
    end

end, "V-PRAY")

ZG.V_PRAY = ZG.actions:get("V_PRAY")

-- zil: gverbs.zil:1100  <ROUTINE V-PUMP ()>
ZG.actions:register("V_PUMP", function()

    if ZG._T(ZG.NULL_F()) then
        do return true end
    elseif ZG._T(ZG.NULL_F()) then
        do return true end
    else
        do return ZG.TELL("It's really not clear how.", ZG._TK.CR) end
    end

end, "V-PUMP")

ZG.V_PUMP = ZG.actions:get("V_PUMP")

-- zil: gverbs.zil:1114  <ROUTINE V-PUSH ()>
ZG.actions:register("V_PUSH", function()

    do return ZG.HACK_HACK("Pushing the ") end

end, "V-PUSH")

ZG.V_PUSH = ZG.actions:get("V_PUSH")

-- zil: gverbs.zil:1116  <ROUTINE V-PUSH-TO ()>
ZG.actions:register("V_PUSH_TO", function()

    do return ZG.TELL("You can't push things to that.", ZG._TK.CR) end

end, "V-PUSH-TO")

ZG.V_PUSH_TO = ZG.actions:get("V_PUSH_TO")

-- zil: gverbs.zil:1119  <ROUTINE PRE-PUT ()>
ZG.actions:register("PRE_PUT", function()

    if ZG.EQ(ZG.PRSO, ZG.SHORT_POLE) then
        do return false end
    else
        do return ZG.PRE_GIVE() end
    end

end, "PRE-PUT")

ZG.PRE_PUT = ZG.actions:get("PRE_PUT")

-- ;"That's easy for you to say..."

-- zil: gverbs.zil:1129  <ROUTINE V-PUT ()>
ZG.actions:register("V_PUT", function()

    if (ZG._T(ZG.FSET_p(ZG.PRSI, "OPENBIT")) or ZG._T(ZG.OPENABLE_p(ZG.PRSI)) or ZG._T(ZG.FSET_p(ZG.PRSI, "VEHBIT"))) then
    else
        do local _ = ZG.TELL("You can't do that.", ZG._TK.CR) end
        do return true end
    end
    if (not ZG._T(ZG.FSET_p(ZG.PRSI, "OPENBIT"))) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSI, " isn't open.", ZG._TK.CR) end
        do return ZG.THIS_IS_IT(ZG.PRSI) end
    elseif ZG.EQ(ZG.PRSI, ZG.PRSO) then
        do return ZG.TELL("How can you do that?", ZG._TK.CR) end
    elseif ZG._T(ZG.IN_p(ZG.PRSO, ZG.PRSI)) then
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is already in the ", ZG._TK.D, ZG.PRSI, ".", ZG._TK.CR) end
    elseif ZG.LT(ZG.GETP(ZG.PRSI, "CAPACITY"), ZG.SUB(ZG.ADD(ZG.WEIGHT(ZG.PRSI), ZG.WEIGHT(ZG.PRSO)), ZG.GETP(ZG.PRSI, "SIZE"))) then
        do return ZG.TELL("There's no room.", ZG._TK.CR) end
    elseif ((not ZG._T(ZG.HELD_p(ZG.PRSO))) and ZG._T(ZG.FSET_p(ZG.PRSO, "TRYTAKEBIT"))) then
        do local _ = ZG.TELL("You don't have the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
        do return true end
    elseif ((not ZG._T(ZG.HELD_p(ZG.PRSO))) and (not ZG._T(ZG.ITAKE()))) then
        do return true end
    else
        do local _ = ZG.MOVE(ZG.PRSO, ZG.PRSI) end
        do local _ = ZG.FSET(ZG.PRSO, "TOUCHBIT") end
        do local _ = ZG.SCORE_OBJ(ZG.PRSO) end
        do return ZG.TELL("Done.", ZG._TK.CR) end
    end

end, "V-PUT")

ZG.V_PUT = ZG.actions:get("V_PUT")

-- zil: gverbs.zil:1160  <ROUTINE V-PUT-BEHIND ()>
ZG.actions:register("V_PUT_BEHIND", function()

    do return ZG.TELL("That hiding place is too obvious.", ZG._TK.CR) end

end, "V-PUT-BEHIND")

ZG.V_PUT_BEHIND = ZG.actions:get("V_PUT_BEHIND")

-- zil: gverbs.zil:1163  <ROUTINE V-PUT-ON ()>
ZG.actions:register("V_PUT_ON", function()

    if ZG.EQ(ZG.PRSI, ZG.GROUND) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DROP"), ZG.PRSO) end
        do return true end
    elseif ZG._T(ZG.FSET_p(ZG.PRSI, "SURFACEBIT")) then
        do return ZG.V_PUT() end
    else
        do return ZG.TELL("There's no good surface on the ", ZG._TK.D, ZG.PRSI, ".", ZG._TK.CR) end
    end

end, "V-PUT-ON")

ZG.V_PUT_ON = ZG.actions:get("V_PUT_ON")

-- zil: gverbs.zil:1172  <ROUTINE V-PUT-UNDER ()>
ZG.actions:register("V_PUT_UNDER", function()

    do return ZG.TELL("You can't do that.", ZG._TK.CR) end

end, "V-PUT-UNDER")

ZG.V_PUT_UNDER = ZG.actions:get("V_PUT_UNDER")

-- zil: gverbs.zil:1175  <ROUTINE V-RAISE ()>
ZG.actions:register("V_RAISE", function()

    do return ZG.V_LOWER() end

end, "V-RAISE")

ZG.V_RAISE = ZG.actions:get("V_RAISE")

-- zil: gverbs.zil:1178  <ROUTINE V-RAPE ()>
ZG.actions:register("V_RAPE", function()

    do return ZG.TELL("What a (ahem!) strange idea.", ZG._TK.CR) end

end, "V-RAPE")

ZG.V_RAPE = ZG.actions:get("V_RAPE")

-- zil: gverbs.zil:1181  <ROUTINE PRE-READ ()>
ZG.actions:register("PRE_READ", function()

    if (not ZG._T(ZG.LIT)) then
        do return ZG.TELL("It is impossible to read in the dark.", ZG._TK.CR) end
    elseif (ZG._T(ZG.PRSI) and (not ZG._T(ZG.FSET_p(ZG.PRSI, "TRANSBIT")))) then
        do return ZG.TELL("How does one look through a ", ZG._TK.D, ZG.PRSI, "?", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRE-READ")

ZG.PRE_READ = ZG.actions:get("PRE_READ")

-- zil: gverbs.zil:1187  <ROUTINE V-READ ()>
ZG.actions:register("V_READ", function()

    if (not ZG._T(ZG.FSET_p(ZG.PRSO, "READBIT"))) then
        do return ZG.TELL("How does one read a ", ZG._TK.D, ZG.PRSO, "?", ZG._TK.CR) end
    else
        do return ZG.TELL(ZG.GETP(ZG.PRSO, "TEXT"), ZG._TK.CR) end
    end

end, "V-READ")

ZG.V_READ = ZG.actions:get("V_READ")

-- zil: gverbs.zil:1193  <ROUTINE V-READ-PAGE ()>
ZG.actions:register("V_READ_PAGE", function()

    do local _ = ZG.PERFORM(ZG.SYMBOL("V?READ"), ZG.PRSO) end
    do return true end

end, "V-READ-PAGE")

ZG.V_READ_PAGE = ZG.actions:get("V_READ_PAGE")

-- zil: gverbs.zil:1197  <ROUTINE V-REPENT ()>
ZG.actions:register("V_REPENT", function()

    do return ZG.TELL("It could very well be too late!", ZG._TK.CR) end

end, "V-REPENT")

ZG.V_REPENT = ZG.actions:get("V_REPENT")

-- zil: gverbs.zil:1200  <ROUTINE V-REPLY ()>
ZG.actions:register("V_REPLY", function()

    do local _ = ZG.TELL("It is hardly likely that the ", ZG._TK.D, ZG.PRSO, " is interested.", ZG._TK.CR) end
    ZG._set("P_CONT", false)
    ZG._set("QUOTE_FLAG", false)
    do return true end

end, "V-REPLY")

ZG.V_REPLY = ZG.actions:get("V_REPLY")

-- zil: gverbs.zil:1206  <ROUTINE V-RING ()>
ZG.actions:register("V_RING", function()

    do return ZG.TELL("How, exactly, can you ring that?", ZG._TK.CR) end

end, "V-RING")

ZG.V_RING = ZG.actions:get("V_RING")

-- zil: gverbs.zil:1209  <ROUTINE V-RUB ()>
ZG.actions:register("V_RUB", function()

    do return ZG.HACK_HACK("Fiddling with the ") end

end, "V-RUB")

ZG.V_RUB = ZG.actions:get("V_RUB")

-- zil: gverbs.zil:1211  <ROUTINE V-SAY ("AUX" V)>
ZG.actions:register("V_SAY", function()

    local V = 0
    if (ZG._T(ZG.FSET_p(ZG.FRONT_DOOR, "TOUCHBIT")) and ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.P_CONT), ZG.WORD("frotz")) and ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.ADD(ZG.P_CONT, 2)), ZG.WORD("ozmoo"))) then
        ZG._set("P_CONT", false)
        if ZG.EQ(ZG.HERE, ZG.MSTAIRS) then
            do local _ = ZG.CRLF() end
            do local _ = ZG.GOTO(ZG.FRONT_DOOR) end
        else
            do local _ = ZG.TELL("Nothing happens.", ZG._TK.CR) end
        end
        do return true end
    end
    ZG._set("QUOTE_FLAG", false)
    if ZG._T((function() V = ZG.FIND_IN(ZG.HERE, "ACTORBIT"); return V end)()) then
        do local _ = ZG.TELL("You must address the ", ZG._TK.D, V, " directly.", ZG._TK.CR) end
        ZG._set("P_CONT", false)
    elseif (not ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.P_CONT), ZG.WORD("hello"))) then
        ZG._set("P_CONT", false)
        do local _ = ZG.TELL("Talking to yourself is a sign of impending mental collapse.", ZG._TK.CR) end
    end
    do return true end

end, "V-SAY")

ZG.V_SAY = ZG.actions:get("V_SAY")

-- zil: gverbs.zil:1241  <ROUTINE V-SEARCH ()>
ZG.actions:register("V_SEARCH", function()

    do return ZG.TELL("You find nothing unusual.", ZG._TK.CR) end

end, "V-SEARCH")

ZG.V_SEARCH = ZG.actions:get("V_SEARCH")

-- zil: gverbs.zil:1244  <ROUTINE V-SEND ()>
ZG.actions:register("V_SEND", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do return ZG.TELL("Why would you send for the ", ZG._TK.D, ZG.PRSO, "?", ZG._TK.CR) end
    else
        do return ZG.TELL("That doesn't make sends.", ZG._TK.CR) end
    end

end, "V-SEND")

ZG.V_SEND = ZG.actions:get("V_SEND")

-- zil: gverbs.zil:1250  <ROUTINE PRE-SGIVE ()>
ZG.actions:register("PRE_SGIVE", function()

    do local _ = ZG.PERFORM(ZG.SYMBOL("V?GIVE"), ZG.PRSI, ZG.PRSO) end
    do return true end

end, "PRE-SGIVE")

ZG.PRE_SGIVE = ZG.actions:get("PRE_SGIVE")

-- zil: gverbs.zil:1254  <ROUTINE V-SGIVE ()>
ZG.actions:register("V_SGIVE", function()

    do return ZG.TELL("Foo!", ZG._TK.CR) end

end, "V-SGIVE")

ZG.V_SGIVE = ZG.actions:get("V_SGIVE")

-- zil: gverbs.zil:1257  <ROUTINE V-SHAKE ()>
ZG.actions:register("V_SHAKE", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do return ZG.TELL("This seems to have no effect.", ZG._TK.CR) end
    elseif (not ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT"))) then
        do return ZG.TELL("You can't take it; thus, you can't shake it!", ZG._TK.CR) end
    elseif ZG._T(ZG.FSET_p(ZG.PRSO, "CONTBIT")) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            if ZG._T(ZG.FIRST_p(ZG.PRSO)) then
                do local _ = ZG.SHAKE_LOOP() end
                do local _ = ZG.TELL("The contents of the ", ZG._TK.D, ZG.PRSO, " spill ") end
                if ZG._T(ZG.FSET_p(ZG.HERE, "NONLANDBIT")) then
                    do local _ = ZG.TELL("out and disappears") end
                else
                    do local _ = ZG.TELL("to the ground") end
                end
                do return ZG.TELL(".", ZG._TK.CR) end
            else
                do return ZG.TELL("Shaken.", ZG._TK.CR) end
            end
        else
            if ZG._T(ZG.FIRST_p(ZG.PRSO)) then
                do return ZG.TELL("It sounds like there is something inside the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
            else
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " sounds empty.", ZG._TK.CR) end
            end
        end
    else
        do return ZG.TELL("Shaken.", ZG._TK.CR) end
    end

end, "V-SHAKE")

ZG.V_SHAKE = ZG.actions:get("V_SHAKE")

-- zil: gverbs.zil:1286  <ROUTINE SHAKE-LOOP ("AUX" X)>
ZG.actions:register("SHAKE_LOOP", function()

    local _tmp1, _tmp2
    local X = 0
    while true do
        if ZG._T((function() X = ZG.FIRST_p(ZG.PRSO); return X end)()) then
            do local _ = ZG.FSET(X, "TOUCHBIT") end
            if ZG.EQ(ZG.HERE, ZG.ON_LAKE) then
                _tmp1 = ZG.IN_LAKE
            else
                _tmp1 = ZG.HERE
            end
            if ZG.EQ(ZG.HERE, ZG.ON_LAKE) then
                _tmp2 = ZG.IN_LAKE
            else
                _tmp2 = ZG.HERE
            end
            do local _ = ZG.MOVE(X, _tmp2) end
        else
            do return true end
        end
    end

end, "SHAKE-LOOP")

ZG.SHAKE_LOOP = ZG.actions:get("SHAKE_LOOP")

-- zil: gverbs.zil:1313  <ROUTINE V-SKIP ()>
ZG.actions:register("V_SKIP", function()

    do return ZG.TELL(ZG.PICK_ONE(ZG.WHEEEEE), ZG._TK.CR) end

end, "V-SKIP")

ZG.V_SKIP = ZG.actions:get("V_SKIP")

-- zil: gverbs.zil:1316  <GLOBAL WHEEEEE>
-- WHEEEEE is declared in ZilGlobal.lua

-- zil: gverbs.zil:1322  <ROUTINE V-SMELL ()>
ZG.actions:register("V_SMELL", function()

    do return ZG.TELL("It smells like a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end

end, "V-SMELL")

ZG.V_SMELL = ZG.actions:get("V_SMELL")

-- zil: gverbs.zil:1325  <ROUTINE V-SPIN ()>
ZG.actions:register("V_SPIN", function()

    do return ZG.TELL("You can't spin that!", ZG._TK.CR) end

end, "V-SPIN")

ZG.V_SPIN = ZG.actions:get("V_SPIN")

-- zil: gverbs.zil:1328  <ROUTINE V-SPRAY ()>
ZG.actions:register("V_SPRAY", function()

    do return ZG.V_SQUEEZE() end

end, "V-SPRAY")

ZG.V_SPRAY = ZG.actions:get("V_SPRAY")

-- zil: gverbs.zil:1331  <ROUTINE V-SQUEEZE ()>
ZG.actions:register("V_SQUEEZE", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " does not understand this.") end
    else
        do local _ = ZG.TELL("How singularly useless.") end
    end
    do return ZG.CRLF() end

end, "V-SQUEEZE")

ZG.V_SQUEEZE = ZG.actions:get("V_SQUEEZE")

-- zil: gverbs.zil:1338  <ROUTINE V-SSPRAY ()>
ZG.actions:register("V_SSPRAY", function()

    do return ZG.PERFORM(ZG.SYMBOL("V?SPRAY"), ZG.PRSI, ZG.PRSO) end

end, "V-SSPRAY")

ZG.V_SSPRAY = ZG.actions:get("V_SSPRAY")

-- zil: gverbs.zil:1341  <ROUTINE V-STAB ("AUX" W)>
ZG.actions:register("V_STAB", function()

    local W = 0
    if ZG._T((function() W = ZG.FIND_WEAPON(ZG.WINNER); return W end)()) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?ATTACK"), ZG.PRSO, W) end
        do return true end
    else
        do return ZG.TELL("No doubt you propose to stab the ", ZG._TK.D, ZG.PRSO, " with your pinky?", ZG._TK.CR) end
    end

end, "V-STAB")

ZG.V_STAB = ZG.actions:get("V_STAB")

-- zil: gverbs.zil:1349  <ROUTINE V-STAND ()>
ZG.actions:register("V_STAND", function()

    if ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?DISEMBARK"), ZG.LOC(ZG.WINNER)) end
        do return true end
    else
        do return ZG.TELL("You are already standing, I think.", ZG._TK.CR) end
    end

end, "V-STAND")

ZG.V_STAND = ZG.actions:get("V_STAND")

-- zil: gverbs.zil:1356  <ROUTINE V-STAY ()>
ZG.actions:register("V_STAY", function()

    do return ZG.TELL("You will be lost without me!", ZG._TK.CR) end

end, "V-STAY")

ZG.V_STAY = ZG.actions:get("V_STAY")

-- zil: gverbs.zil:1359  <ROUTINE V-STRIKE ()>
ZG.actions:register("V_STRIKE", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        do return ZG.TELL("Since you aren't versed in hand-to-hand combat, you'd better attack the ", ZG._TK.D, ZG.PRSO, " with a weapon.", ZG._TK.CR) end
    else
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?LAMP-ON"), ZG.PRSO) end
        do return true end
    end

end, "V-STRIKE")

ZG.V_STRIKE = ZG.actions:get("V_STRIKE")

-- zil: gverbs.zil:1368  <ROUTINE V-SWIM ()>
ZG.actions:register("V_SWIM", function()

    if ZG.EQUAL_p(ZG.HERE, ZG.ON_LAKE, ZG.IN_LAKE) then
        do return ZG.TELL("What do you think you're doing?", ZG._TK.CR) end
    elseif ZG.EQ(ZG.HERE, ZG.FLATHEAD_OCEAN) then
        do return ZG.TELL("Between the rocks and waves, you wouldn't last a minute!", ZG._TK.CR) end
    else
        do return ZG.TELL("Go jump in a lake!", ZG._TK.CR) end
    end

end, "V-SWIM")

ZG.V_SWIM = ZG.actions:get("V_SWIM")

-- zil: gverbs.zil:1391  <ROUTINE V-SWING ()>
ZG.actions:register("V_SWING", function()

    if (not ZG._T(ZG.PRSI)) then
        do return ZG.TELL("Whoosh!", ZG._TK.CR) end
    else
        do return ZG.PERFORM(ZG.SYMBOL("V?ATTACK"), ZG.PRSI, ZG.PRSO) end
    end

end, "V-SWING")

ZG.V_SWING = ZG.actions:get("V_SWING")

-- zil: gverbs.zil:1397  <ROUTINE PRE-TAKE ()>
ZG.actions:register("PRE_TAKE", function()

    if ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER)) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "WEARBIT")) then
            do return ZG.TELL("You are already wearing it.", ZG._TK.CR) end
        else
            do return ZG.TELL("You already have that!", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.FSET_p(ZG.LOC(ZG.PRSO), "CONTBIT")) and (not ZG._T(ZG.FSET_p(ZG.LOC(ZG.PRSO), "OPENBIT")))) then
        do local _ = ZG.TELL("You can't reach something that's inside a closed container.", ZG._TK.CR) end
        do return true end
    elseif ZG._T(ZG.PRSI) then
        if ZG.EQ(ZG.PRSI, ZG.GROUND) then
            ZG._set("PRSI", false)
            do return false end
        end
        do local _ = ZG.NULL_F() end
        if (not ZG.EQ(ZG.PRSI, ZG.LOC(ZG.PRSO))) then
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " isn't in the ", ZG._TK.D, ZG.PRSI, ".", ZG._TK.CR) end
        else
            ZG._set("PRSI", false)
            do return false end
        end
    elseif ZG.EQ(ZG.PRSO, ZG.LOC(ZG.WINNER)) then
        do return ZG.TELL("You're inside of it!", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRE-TAKE")

ZG.PRE_TAKE = ZG.actions:get("PRE_TAKE")

-- zil: gverbs.zil:1426  <ROUTINE V-TAKE ()>
ZG.actions:register("V_TAKE", function()

    if ZG.EQ(ZG.ITAKE(), true) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "WEARBIT")) then
            do return ZG.TELL("You are now wearing the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
        else
            do return ZG.TELL("Taken.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "V-TAKE")

ZG.V_TAKE = ZG.actions:get("V_TAKE")

-- zil: gverbs.zil:1433  <ROUTINE V-TELL ()>
ZG.actions:register("V_TELL", function()

    if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
        if ZG._T(ZG.P_CONT) then
            ZG._set("WINNER", ZG.PRSO)
            ZG._set("HERE", ZG.LOC(ZG.WINNER))
            do return ZG.HERE end
        else
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " pauses for a moment, perhaps thinking that you should reread\nthe manual.", ZG._TK.CR) end
        end
    else
        do local _ = ZG.TELL("You can't talk to the ", ZG._TK.D, ZG.PRSO, "!", ZG._TK.CR) end
        ZG._set("QUOTE_FLAG", false)
        ZG._set("P_CONT", false)
        do return 2 end
    end

end, "V-TELL")

ZG.V_TELL = ZG.actions:get("V_TELL")

-- zil: gverbs.zil:1448  <ROUTINE V-THROUGH ("OPTIONAL" (OBJ <>) "AUX" M)>
ZG.actions:register("V_THROUGH", function(OBJ)

    if OBJ == nil then OBJ = false end
    local M = 0
    if (ZG._T(ZG.FSET_p(ZG.PRSO, "DOORBIT")) and ZG._T((function() M = ZG.OTHER_SIDE(ZG.PRSO); return M end)())) then
        do local _ = ZG.DO_WALK(M) end
        do return true end
    elseif ((not ZG._T(OBJ)) and ZG._T(ZG.FSET_p(ZG.PRSO, "VEHBIT"))) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?BOARD"), ZG.PRSO) end
        do return true end
    elseif (ZG._T(OBJ) or (not ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT")))) then
        do local _ = ZG.NULL_F() end
        do return ZG.TELL("You hit your head against the ", ZG._TK.D, ZG.PRSO, " as you attempt this feat.", ZG._TK.CR) end
    elseif ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER)) then
        do return ZG.TELL("That would involve quite a contortion!", ZG._TK.CR) end
    else
        do return ZG.TELL(ZG.PICK_ONE(ZG.YUKS), ZG._TK.CR) end
    end

end, "V-THROUGH")

ZG.V_THROUGH = ZG.actions:get("V_THROUGH")

-- zil: gverbs.zil:1489  <ROUTINE V-THROW ()>
ZG.actions:register("V_THROW", function()

    if ZG._T(ZG.IDROP()) then
        if ZG.EQ(ZG.PRSI, ZG.ME) then
            do local _ = ZG.TELL("A terrific throw! The ", ZG._TK.D, ZG.PRSO) end
            ZG._set("WINNER", ZG.PLAYER)
            do return ZG.JIGS_UP(" hits you squarely in the head. Normally,\nthis wouldn't do much damage, but by incredible mischance, you fall over\nbackwards trying to duck, and break your neck, justice being swift and\nmerciful in the Great Underground Empire.") end
        elseif (ZG._T(ZG.PRSI) and ZG._T(ZG.FSET_p(ZG.PRSI, "ACTORBIT"))) then
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSI, " ducks as the ", ZG._TK.D, ZG.PRSO, " flies by and crashes to the ground.", ZG._TK.CR) end
        else
            do return ZG.TELL("Thrown.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("Huh?", ZG._TK.CR) end
    end

end, "V-THROW")

ZG.V_THROW = ZG.actions:get("V_THROW")

-- zil: gverbs.zil:1506  <ROUTINE V-THROW-OFF ()>
ZG.actions:register("V_THROW_OFF", function()

    do return ZG.TELL("You can't throw anything off of that!", ZG._TK.CR) end

end, "V-THROW-OFF")

ZG.V_THROW_OFF = ZG.actions:get("V_THROW_OFF")

-- zil: gverbs.zil:1509  <ROUTINE V-TIE ()>
ZG.actions:register("V_TIE", function()

    if ZG.EQ(ZG.PRSI, ZG.WINNER) then
        do return ZG.TELL("You can't tie anything to yourself.", ZG._TK.CR) end
    else
        do return ZG.TELL("You can't tie the ", ZG._TK.D, ZG.PRSO, " to that.", ZG._TK.CR) end
    end

end, "V-TIE")

ZG.V_TIE = ZG.actions:get("V_TIE")

-- zil: gverbs.zil:1515  <ROUTINE V-TIE-UP ()>
ZG.actions:register("V_TIE_UP", function()

    do return ZG.TELL("You could certainly never tie it with that!", ZG._TK.CR) end

end, "V-TIE-UP")

ZG.V_TIE_UP = ZG.actions:get("V_TIE_UP")

-- zil: gverbs.zil:1518  <ROUTINE V-TREASURE ()>
ZG.actions:register("V_TREASURE", function()

    if ZG._T(ZG.NULL_F()) then
        do return true end
    elseif ZG._T(ZG.NULL_F()) then
        do return true end
    else
        do return ZG.TELL("Nothing happens.", ZG._TK.CR) end
    end

end, "V-TREASURE")

ZG.V_TREASURE = ZG.actions:get("V_TREASURE")

-- zil: gverbs.zil:1532  <ROUTINE PRE-TURN ()>
ZG.actions:register("PRE_TURN", function()

    if (ZG.EQUAL_p(ZG.PRSI, false, ZG.ROOMS) and ZG.EQUAL_p(ZG.PRSO, ZG.DIAL, ZG.TM_DIAL, ZG.T_BAR)) then
        do local _ = ZG.TELL("You should turn the ", ZG._TK.D, ZG.PRSO, " to something.", ZG._TK.CR) end
        do return true end
    end
    if ZG._T(ZG.EQUAL_p(ZG.PRSI, false, ZG.ROOMS)) then
        do return ZG.TELL("Your bare hands don't appear to be enough.", ZG._TK.CR) end
    elseif (not ZG._T(ZG.FSET_p(ZG.PRSO, "TURNBIT"))) then
        do return ZG.TELL("You can't turn that!", ZG._TK.CR) end
    else
        do return false end
    end

end, "PRE-TURN")

ZG.PRE_TURN = ZG.actions:get("PRE_TURN")

-- zil: gverbs.zil:1549  <ROUTINE V-TURN ()>
ZG.actions:register("V_TURN", function()

    do return ZG.TELL("This has no effect.", ZG._TK.CR) end

end, "V-TURN")

ZG.V_TURN = ZG.actions:get("V_TURN")

-- zil: gverbs.zil:1552  <ROUTINE V-UNLOCK ()>
ZG.actions:register("V_UNLOCK", function()

    do return ZG.V_LOCK() end

end, "V-UNLOCK")

ZG.V_UNLOCK = ZG.actions:get("V_UNLOCK")

-- zil: gverbs.zil:1555  <ROUTINE V-UNTIE ()>
ZG.actions:register("V_UNTIE", function()

    do return ZG.TELL("This cannot be tied, so it cannot be untied!", ZG._TK.CR) end

end, "V-UNTIE")

ZG.V_UNTIE = ZG.actions:get("V_UNTIE")

-- zil: gverbs.zil:1558  <ROUTINE V-WAIT ("OPTIONAL" (NUM 3))>
ZG.actions:register("V_WAIT", function(NUM)

    if NUM == nil then NUM = 3 end
    do local _ = ZG.TELL("Time passes...", ZG._TK.CR) end
    while true do
        if ZG.LT((function() NUM = ZG.SUB(NUM, 1); return NUM end)(), 0) then
            break
        elseif ZG._T(ZG.CLOCKER()) then
            break
        end
    end
    ZG._set("CLOCK_WAIT", true)
    do return ZG.CLOCK_WAIT end

end, "V-WAIT")

ZG.V_WAIT = ZG.actions:get("V_WAIT")

-- zil: gverbs.zil:1565  <ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)>
ZG.actions:register("V_WALK", function()

    local PT = 0
    local PTS = 0
    local STR = 0
    local OBJ = 0
    local RM = 0
    if (not ZG._T(ZG.P_WALK_DIR)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?WALK-TO"), ZG.PRSO) end
        do return true end
    elseif ZG._T((function() PT = ZG.GETPT(ZG.HERE, ZG.PRSO); return PT end)()) then
        if ZG.EQ((function() PTS = ZG.PTSIZE(PT); return PTS end)(), ZG.UEXIT) then
            do return ZG.GOTO(ZG.GETB(PT, ZG.REXIT)) end
        elseif ZG.EQ(PTS, ZG.NEXIT) then
            do local _ = ZG.TELL(ZG.GET(PT, ZG.NEXITSTR), ZG._TK.CR) end
            do return 2 end
        elseif ZG.EQ(PTS, ZG.FEXIT) then
            if ZG._T((function() RM = ZG.APPLY(ZG.GET(PT, ZG.FEXITFCN)); return RM end)()) then
                do return ZG.GOTO(RM) end
            elseif (ZG.EQ(ZG.HERE, ZG.CP) and ZG._T(ZG.CP_MOVED)) then
                do return true end
            else
                do return 2 end
            end
        elseif ZG.EQ(PTS, ZG.CEXIT) then
            if ZG._T(ZG.VALUE(ZG.GETB(PT, ZG.CEXITFLAG))) then
                do return ZG.GOTO(ZG.GETB(PT, ZG.REXIT)) end
            elseif ZG._T((function() STR = ZG.GET(PT, ZG.CEXITSTR); return STR end)()) then
                do local _ = ZG.TELL(STR, ZG._TK.CR) end
                do return 2 end
            else
                do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
                do return 2 end
            end
        elseif ZG.EQ(PTS, ZG.DEXIT) then
            if ZG._T(ZG.FSET_p((function() OBJ = ZG.GETB(PT, ZG.DEXITOBJ); return OBJ end)(), "OPENBIT")) then
                do return ZG.GOTO(ZG.GETB(PT, ZG.REXIT)) end
            elseif ZG._T((function() STR = ZG.GET(PT, ZG.DEXITSTR); return STR end)()) then
                do local _ = ZG.TELL(STR, ZG._TK.CR) end
                do return 2 end
            else
                do local _ = ZG.TELL("The ", ZG._TK.D, OBJ, " is closed.", ZG._TK.CR) end
                do local _ = ZG.THIS_IS_IT(OBJ) end
                do return 2 end
            end
        else
            do return false end
        end
    elseif ((not ZG._T(ZG.LIT)) and ZG._T(ZG.PROB(80)) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER) and (not ZG._T(ZG.FSET_p(ZG.HERE, "NONLANDBIT")))) then
        if ZG._T(ZG.SPRAYED_p) then
            do local _ = ZG.TELL("There are odd noises in the darkness, and there is no exit in that\ndirection.", ZG._TK.CR) end
            do return 2 end
        elseif ZG.EQUAL_p(ZG.HERE, ZG.DARK_1, ZG.DARK_2) then
            do return ZG.JIGS_UP("Oh, no! You have walked into a den of hungry grues and it's dinner time!") end
        else
            do return ZG.JIGS_UP("Oh, no! You have walked into the slavering fangs of a lurking grue!") end
        end
    else
        do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
        do return 2 end
    end

end, "V-WALK")

ZG.V_WALK = ZG.actions:get("V_WALK")

-- zil: gverbs.zil:1627  <ROUTINE V-WALK-AROUND ()>
ZG.actions:register("V_WALK_AROUND", function()

    do return ZG.TELL("Use compass directions for movement.", ZG._TK.CR) end

end, "V-WALK-AROUND")

ZG.V_WALK_AROUND = ZG.actions:get("V_WALK_AROUND")

-- zil: gverbs.zil:1630  <ROUTINE V-WALK-TO ()>
ZG.actions:register("V_WALK_TO", function()

    if (ZG._T(ZG.PRSO) and (ZG._T(ZG.IN_p(ZG.PRSO, ZG.HERE)) or ZG._T(ZG.GLOBAL_IN_p(ZG.PRSO, ZG.HERE)))) then
        do return ZG.TELL("It's here!", ZG._TK.CR) end
    else
        do return ZG.TELL("You should supply a direction!", ZG._TK.CR) end
    end

end, "V-WALK-TO")

ZG.V_WALK_TO = ZG.actions:get("V_WALK_TO")

-- zil: gverbs.zil:1638  <ROUTINE V-WAVE ()>
ZG.actions:register("V_WAVE", function()

    do return ZG.HACK_HACK("Waving the ") end

end, "V-WAVE")

ZG.V_WAVE = ZG.actions:get("V_WAVE")

-- zil: gverbs.zil:1641  <ROUTINE V-WEAR ()>
ZG.actions:register("V_WEAR", function()

    if (not ZG._T(ZG.FSET_p(ZG.PRSO, "WEARBIT"))) then
        do return ZG.TELL("You can't wear the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    else
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?TAKE"), ZG.PRSO) end
        do return true end
    end

end, "V-WEAR")

ZG.V_WEAR = ZG.actions:get("V_WEAR")

-- zil: gverbs.zil:1648  <ROUTINE V-WIN ()>
ZG.actions:register("V_WIN", function()

    do return ZG.TELL("Naturally!", ZG._TK.CR) end

end, "V-WIN")

ZG.V_WIN = ZG.actions:get("V_WIN")

-- zil: gverbs.zil:1651  <ROUTINE V-WIND ()>
ZG.actions:register("V_WIND", function()

    do return ZG.TELL("You cannot wind up a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end

end, "V-WIND")

ZG.V_WIND = ZG.actions:get("V_WIND")

-- zil: gverbs.zil:1654  <ROUTINE V-WISH ()>
ZG.actions:register("V_WISH", function()

    do return ZG.TELL("With luck, your wish will come true.", ZG._TK.CR) end

end, "V-WISH")

ZG.V_WISH = ZG.actions:get("V_WISH")

-- zil: gverbs.zil:1660  <ROUTINE V-YELL ()>
ZG.actions:register("V_YELL", function()

    do return ZG.TELL("Aaaarrrrgggghhhh!", ZG._TK.CR) end

end, "V-YELL")

ZG.V_YELL = ZG.actions:get("V_YELL")

-- zil: gverbs.zil:1662  <ROUTINE V-ZORK ()>
ZG.actions:register("V_ZORK", function()

    do return ZG.TELL("At your service!", ZG._TK.CR) end

end, "V-ZORK")

ZG.V_ZORK = ZG.actions:get("V_ZORK")

-- zil: gverbs.zil:1670  <GLOBAL LIT>
-- LIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:1672  <GLOBAL SPRAYED?>
-- SPRAYED_p is declared in ZilGlobal.lua

-- zil: gverbs.zil:1674  <ROUTINE V-FIRST-LOOK ()>
ZG.actions:register("V_FIRST_LOOK", function()

    if ZG._T(ZG.DESCRIBE_ROOM()) then
        if (not ZG._T(ZG.SUPER_BRIEF)) then
            do return ZG.DESCRIBE_OBJECTS() end
        else
            do return false end
        end
    else
        do return false end
    end

end, "V-FIRST-LOOK")

ZG.V_FIRST_LOOK = ZG.actions:get("V_FIRST_LOOK")

-- zil: gverbs.zil:1679  <ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)>
ZG.actions:register("DESCRIBE_ROOM", function(LOOK_p)

    if LOOK_p == nil then LOOK_p = false end
    local V_p = 0
    local STR = 0
    local AV = 0
    V_p = (function() local _v = LOOK_p; if ZG._T(_v) then return _v end; return ZG.VERBOSE end)()
    if (not ZG._T(ZG.LIT)) then
        do local _ = ZG.TELL("It is pitch black.") end
        if (not ZG._T(ZG.SPRAYED_p)) then
            do local _ = ZG.TELL(" You are likely to be eaten by a grue.") end
        end
        do local _ = ZG.CRLF() end
        if ZG.EQ(ZG.HERE, ZG.DARK_2) then
            do local _ = ZG.TELL("The ground continues to slope upwards away from the lake. You can barely\ndetect a dim light from the east.", ZG._TK.CR) end
        end
        do return false end
    end
    if (not ZG._T(ZG.FSET_p(ZG.HERE, "TOUCHBIT"))) then
        do local _ = ZG.FSET(ZG.HERE, "TOUCHBIT") end
        V_p = true
    end
    do local _ = ZG.NULL_F() end
    if ZG._T(ZG.IN_p(ZG.HERE, ZG.ROOMS)) then
        do local _ = ZG.TELL(ZG._TK.D, ZG.HERE) end
        if ZG._T(ZG.FSET_p((function() AV = ZG.LOC(ZG.WINNER); return AV end)(), "VEHBIT")) then
            do local _ = ZG.TELL(", in the ", ZG._TK.D, AV) end
        end
        do local _ = ZG.CRLF() end
    end
    if ZG._T((function() local _v = LOOK_p; if ZG._T(_v) then return _v end; return (not ZG._T(ZG.SUPER_BRIEF)) end)()) then
        AV = ZG.LOC(ZG.WINNER)
        if (ZG._T(V_p) and ZG._T(ZG.APPLY(ZG.GETP(ZG.HERE, "ACTION"), ZG.M_LOOK))) then
            do return true end
        elseif (ZG._T(V_p) and ZG._T((function() STR = ZG.GETP(ZG.HERE, "LDESC"); return STR end)())) then
            do local _ = ZG.TELL(STR, ZG._TK.CR) end
        else
            do local _ = ZG.APPLY(ZG.GETP(ZG.HERE, "ACTION"), ZG.M_FLASH) end
        end
        if ((not ZG.EQ(ZG.HERE, AV)) and ZG._T(ZG.FSET_p(AV, "VEHBIT"))) then
            do local _ = ZG.APPLY(ZG.GETP(AV, "ACTION"), ZG.M_LOOK) end
        end
    end
    do return true end

end, "DESCRIBE-ROOM")

ZG.DESCRIBE_ROOM = ZG.actions:get("DESCRIBE_ROOM")

-- zil: gverbs.zil:1725  <ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))>
ZG.actions:register("DESCRIBE_OBJECTS", function(V_p)

    if V_p == nil then V_p = false end
    if ZG._T(ZG.LIT) then
        if ZG._T(ZG.FIRST_p(ZG.HERE)) then
            do return ZG.PRINT_CONT(ZG.HERE, (function() V_p = (function() local _v = V_p; if ZG._T(_v) then return _v end; return ZG.VERBOSE end)(); return V_p end)(), -1) end
        else
            do return false end
        end
    else
        do return ZG.TELL("Only bats can see in the dark. And you're not one.", ZG._TK.CR) end
    end

end, "DESCRIBE-OBJECTS")

ZG.DESCRIBE_OBJECTS = ZG.actions:get("DESCRIBE_OBJECTS")

-- zil: gverbs.zil:1735  <GLOBAL DESC-OBJECT>
-- DESC_OBJECT is declared in ZilGlobal.lua

-- zil: gverbs.zil:1737  <ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)>
ZG.actions:register("DESCRIBE_OBJECT", function(OBJ, V_p, LEVEL)

    local STR = false
    local AV = 0
    ZG._set("DESC_OBJECT", OBJ)
    if (ZG.ZERO_p(LEVEL) and ZG._T(ZG.APPLY(ZG.GETP(OBJ, "DESCFCN"), ZG.M_OBJDESC))) then
        do return true end
    elseif (ZG.ZERO_p(LEVEL) and (((not ZG._T(ZG.FSET_p(OBJ, "TOUCHBIT"))) and ZG._T((function() STR = ZG.GETP(OBJ, "FDESC"); return STR end)())) or ZG._T((function() STR = ZG.GETP(OBJ, "LDESC"); return STR end)()))) then
        do local _ = ZG.TELL(STR) end
    elseif ZG.ZERO_p(LEVEL) then
        do local _ = ZG.TELL("There is a ", ZG._TK.D, OBJ, " here") end
        if ZG._T(ZG.FSET_p(OBJ, "ONBIT")) then
            do local _ = ZG.TELL(" (providing light)") end
        end
        do local _ = ZG.TELL(".") end
    else
        do local _ = ZG.TELL(ZG.GET(ZG.INDENTS, LEVEL)) end
        do local _ = ZG.TELL("A ", ZG._TK.D, OBJ) end
        if ZG._T(ZG.FSET_p(OBJ, "ONBIT")) then
            do local _ = ZG.TELL(" (providing light)") end
        elseif (ZG._T(ZG.FSET_p(OBJ, "WEARBIT")) and ZG._T(ZG.IN_p(OBJ, ZG.WINNER))) then
            do local _ = ZG.TELL(" (being worn)") end
        end
    end
    do local _ = ZG.NULL_F() end
    if (ZG.ZERO_p(LEVEL) and ZG._T((function() AV = ZG.LOC(ZG.WINNER); return AV end)()) and ZG._T(ZG.FSET_p(AV, "VEHBIT"))) then
        do local _ = ZG.TELL(" (outside the ", ZG._TK.D, AV, ")") end
    end
    do local _ = ZG.CRLF() end
    if (ZG._T(ZG.SEE_INSIDE_p(OBJ)) and ZG._T(ZG.FIRST_p(OBJ))) then
        do return ZG.PRINT_CONT(OBJ, V_p, LEVEL) end
    else
        do return false end
    end

end, "DESCRIBE-OBJECT")

ZG.DESCRIBE_OBJECT = ZG.actions:get("DESCRIBE_OBJECT")

-- zil: gverbs.zil:1774  <ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))>
ZG.actions:register("PRINT_CONTENTS", function(OBJ)

    local F = 0
    local N = 0
    local _1ST_p = true
    local IT_p = false
    local TWO_p = false
    if ZG._T((function() F = ZG.FIRST_p(OBJ); return F end)()) then
        while true do
            N = ZG.NEXT_p(F)
            if ZG._T(_1ST_p) then
                _1ST_p = false
            else
                do local _ = ZG.TELL(", ") end
                if (not ZG._T(N)) then
                    do local _ = ZG.TELL("and ") end
                end
            end
            do local _ = ZG.TELL("a ", ZG._TK.D, F) end
            if ((not ZG._T(IT_p)) and (not ZG._T(TWO_p))) then
                IT_p = F
            else
                TWO_p = true
                IT_p = false
            end
            F = N
            if (not ZG._T(F)) then
                if (ZG._T(IT_p) and (not ZG._T(TWO_p))) then
                    do local _ = ZG.THIS_IS_IT(IT_p) end
                end
                do return true end
            end
        end
    else
        do return false end
    end

end, "PRINT-CONTENTS")

ZG.PRINT_CONTENTS = ZG.actions:get("PRINT_CONTENTS")

-- zil: gverbs.zil:1794  <ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0) "AUX" Y 1ST? SHIT AV ST...
ZG.actions:register("PRINT_CONT", function(OBJ, V_p, LEVEL)

    if V_p == nil then V_p = false end
    if LEVEL == nil then LEVEL = 0 end
    local Y = 0
    local _1ST_p = 0
    local SHIT = 0
    local AV = 0
    local STR = 0
    local PV_p = false
    local INV_p = false
    if (not ZG._T((function() Y = ZG.FIRST_p(OBJ); return Y end)())) then
        do return true end
    end
    if (ZG._T((function() AV = ZG.LOC(ZG.WINNER); return AV end)()) and ZG._T(ZG.FSET_p(AV, "VEHBIT"))) then
    else
        AV = false
    end
    _1ST_p = true
    SHIT = true
    if ZG.EQUAL_p(ZG.WINNER, OBJ, ZG.LOC(OBJ)) then
        INV_p = true
    else
        while true do
            if (not ZG._T(Y)) then
                break
            elseif ZG.EQ(Y, AV) then
                PV_p = true
            elseif ZG.EQ(Y, ZG.WINNER) then
            elseif ((not ZG._T(ZG.FSET_p(Y, "INVISIBLE"))) and (not ZG._T(ZG.FSET_p(Y, "TOUCHBIT"))) and ZG._T((function() STR = ZG.GETP(Y, "FDESC"); return STR end)())) then
                if (not ZG._T(ZG.FSET_p(Y, "NDESCBIT"))) then
                    do local _ = ZG.TELL(STR, ZG._TK.CR) end
                    SHIT = false
                end
                if (ZG._T(ZG.SEE_INSIDE_p(Y)) and (not ZG._T(ZG.GETP(ZG.LOC(Y), "DESCFCN"))) and ZG._T(ZG.FIRST_p(Y))) then
                    if ZG._T(ZG.PRINT_CONT(Y, V_p, 0)) then
                        _1ST_p = false
                    end
                end
            end
            Y = ZG.NEXT_p(Y)
        end
    end
    Y = ZG.FIRST_p(OBJ)
    while true do
        if (not ZG._T(Y)) then
            if (ZG._T(PV_p) and ZG._T(AV) and ZG._T(ZG.FIRST_p(AV))) then
                LEVEL = ZG.ADD(LEVEL, 1)
                do local _ = ZG.PRINT_CONT(AV, V_p, LEVEL) end
            end
            break
        elseif ZG.EQUAL_p(Y, AV, ZG.ADVENTURER) then
        elseif ((not ZG._T(ZG.FSET_p(Y, "INVISIBLE"))) and (ZG._T(INV_p) or ZG._T(ZG.FSET_p(Y, "TOUCHBIT")) or (not ZG._T(ZG.GETP(Y, "FDESC"))))) then
            if (not ZG._T(ZG.FSET_p(Y, "NDESCBIT"))) then
                if ZG._T(_1ST_p) then
                    if ZG._T(ZG.FIRSTER(OBJ, LEVEL)) then
                        if ZG.LT(LEVEL, 0) then
                            LEVEL = 0
                        end
                    end
                    LEVEL = ZG.ADD(1, LEVEL)
                    _1ST_p = false
                end
                if ZG.LT(LEVEL, 0) then
                    LEVEL = 0
                end
                do local _ = ZG.DESCRIBE_OBJECT(Y, V_p, LEVEL) end
            elseif (ZG._T(ZG.FIRST_p(Y)) and ZG._T(ZG.SEE_INSIDE_p(Y))) then
                LEVEL = ZG.ADD(LEVEL, 1)
                do local _ = ZG.PRINT_CONT(Y, V_p, LEVEL) end
                LEVEL = ZG.SUB(LEVEL, 1)
            end
        end
        Y = ZG.NEXT_p(Y)
    end
    if (ZG._T(_1ST_p) and ZG._T(SHIT)) then
        do return false end
    else
        do return true end
    end

end, "PRINT-CONT")

ZG.PRINT_CONT = ZG.actions:get("PRINT_CONT")

-- zil: gverbs.zil:1862  <ROUTINE FIRSTER (OBJ LEVEL)>
ZG.actions:register("FIRSTER", function(OBJ, LEVEL)

    if ZG._T(ZG.NULL_F()) then
        do return true end
    elseif ZG.EQ(OBJ, ZG.WINNER) then
        do return ZG.TELL("You are carrying:", ZG._TK.CR) end
    elseif (not ZG._T(ZG.IN_p(OBJ, ZG.ROOMS))) then
        if ZG.LT(0, LEVEL) then
            do local _ = ZG.TELL(ZG.GET(ZG.INDENTS, LEVEL)) end
        end
        if ZG._T(ZG.FSET_p(OBJ, "SURFACEBIT")) then
            do return ZG.TELL("Sitting on the ", ZG._TK.D, OBJ, " is: ", ZG._TK.CR) end
        elseif ZG._T(ZG.FSET_p(OBJ, "ACTORBIT")) then
            do return ZG.TELL("The ", ZG._TK.D, OBJ, " is holding: ", ZG._TK.CR) end
        else
            do return ZG.TELL("The ", ZG._TK.D, OBJ, " contains:", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "FIRSTER")

ZG.FIRSTER = ZG.actions:get("FIRSTER")

-- zil: gverbs.zil:1881  <ROUTINE SEE-INSIDE? (OBJ)>
ZG.actions:register("SEE_INSIDE_p", function(OBJ)

    do return ((not ZG._T(ZG.FSET_p(OBJ, "INVISIBLE"))) and (function() local _v = ZG.FSET_p(OBJ, "TRANSBIT"); if ZG._T(_v) then return _v end; return ZG.FSET_p(OBJ, "OPENBIT") end)()) end

end, "SEE-INSIDE?")

ZG.SEE_INSIDE_p = ZG.actions:get("SEE_INSIDE_p")

-- zil: gverbs.zil:1887  <GLOBAL MOVES>
-- MOVES is declared in ZilGlobal.lua

-- zil: gverbs.zil:1889  <GLOBAL SCORE>
-- SCORE is declared in ZilGlobal.lua

-- zil: gverbs.zil:1891  <GLOBAL BASE-SCORE>
-- BASE_SCORE is declared in ZilGlobal.lua

-- zil: gverbs.zil:1893  <GLOBAL WON-FLAG>
-- WON_FLAG is declared in ZilGlobal.lua

-- zil: gverbs.zil:1895  <ROUTINE SCORE-UPD (NUM)>
ZG.actions:register("SCORE_UPD", function(NUM)

    ZG._set("BASE_SCORE", ZG.ADD(ZG.BASE_SCORE, NUM))
    ZG._set("SCORE", ZG.ADD(ZG.SCORE, NUM))
    do local _ = ZG.NULL_F() end
    do return true end

end, "SCORE-UPD")

ZG.SCORE_UPD = ZG.actions:get("SCORE_UPD")

-- zil: gverbs.zil:1911  <ROUTINE SCORE-OBJ (OBJ "AUX" TEMP)>
ZG.actions:register("SCORE_OBJ", function(OBJ)

    local TEMP = 0
    if ZG.LT(0, (function() TEMP = ZG.GETP(OBJ, "VALUE"); return TEMP end)()) then
        do local _ = ZG.SCORE_UPD(TEMP) end
        do return ZG.PUTP(OBJ, "VALUE", 0) end
    else
        do return false end
    end

end, "SCORE-OBJ")

ZG.SCORE_OBJ = ZG.actions:get("SCORE_OBJ")

-- zil: gverbs.zil:1916  <ROUTINE YES? ()>
ZG.actions:register("YES_p", function()

    do local _ = ZG.PRINTI(">") end
    do local _ = ZG.READ(ZG.P_INBUF, ZG.P_LEXV) end
    if ZG.EQUAL_p(ZG.GET(ZG.P_LEXV, 1), ZG.WORD("yes"), ZG.WORD("y")) then
        do return true end
    else
        do return false end
    end

end, "YES?")

ZG.YES_p = ZG.actions:get("YES_p")

-- zil: gverbs.zil:1926  <GLOBAL DEAD>
-- DEAD is declared in ZilGlobal.lua

-- zil: gverbs.zil:1928  <GLOBAL DEATHS>
-- DEATHS is declared in ZilGlobal.lua

-- zil: gverbs.zil:1930  <GLOBAL LUCKY>
-- LUCKY is declared in ZilGlobal.lua

-- ;"JIGS-UP is in ACTIONS.ZIL"

-- ;"RANDOMIZE-OBJECTS is in ACTIONS.ZIL"

-- ;"KILL-INTERRUPTS is in ACTIONS.ZIL"

-- zil: gverbs.zil:1940  <GLOBAL FUMBLE-NUMBER>
-- FUMBLE_NUMBER is declared in ZilGlobal.lua

-- zil: gverbs.zil:1942  <GLOBAL FUMBLE-PROB>
-- FUMBLE_PROB is declared in ZilGlobal.lua

-- zil: gverbs.zil:1944  <ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)>
ZG.actions:register("ITAKE", function(VB)

    if VB == nil then VB = true end
    local CNT = 0
    local OBJ = 0
    if ZG._T(ZG.NULL_F()) then
        do return false end
    elseif (not ZG._T(ZG.FSET_p(ZG.PRSO, "TAKEBIT"))) then
        if ZG._T(VB) then
            do local _ = ZG.TELL(ZG.PICK_ONE(ZG.YUKS), ZG._TK.CR) end
        end
        do return false end
    elseif ZG._T(ZG.NULL_F()) then
        do return false end
    elseif (ZG._T(ZG.FSET_p(ZG.LOC(ZG.PRSO), "CONTBIT")) and (not ZG._T(ZG.FSET_p(ZG.LOC(ZG.PRSO), "OPENBIT")))) then
        do return false end
    elseif ((not ZG._T(ZG.IN_p(ZG.LOC(ZG.PRSO), ZG.WINNER))) and ZG.LT(ZG.LOAD_ALLOWED, ZG.ADD(ZG.WEIGHT(ZG.PRSO), ZG.WEIGHT(ZG.WINNER)))) then
        if ZG._T(VB) then
            do local _ = ZG.TELL("Your load is too heavy") end
            if ZG.LT(ZG.LOAD_ALLOWED, ZG.LOAD_MAX) then
                do local _ = ZG.TELL(", especially in light of your condition.") end
            else
                do local _ = ZG.TELL(".") end
            end
            do local _ = ZG.CRLF() end
        end
        do return 2 end
    elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG.LT(ZG.FUMBLE_NUMBER, (function() CNT = ZG.CCOUNT(ZG.WINNER); return CNT end)()) and ZG._T(ZG.PROB((CNT * ZG.FUMBLE_PROB)))) then
        do local _ = ZG.TELL("You're holding too many things already!", ZG._TK.CR) end
        do return false end
    else
        do local _ = ZG.MOVE(ZG.PRSO, ZG.WINNER) end
        do local _ = ZG.FCLEAR(ZG.PRSO, "NDESCBIT") end
        do local _ = ZG.FSET(ZG.PRSO, "TOUCHBIT") end
        do local _ = ZG.NULL_F() end
        do local _ = ZG.NULL_F() end
        do return true end
    end

end, "ITAKE")

ZG.ITAKE = ZG.actions:get("ITAKE")

-- zil: gverbs.zil:2010  <ROUTINE IDROP ()>
ZG.actions:register("IDROP", function()

    if ((not ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) and (not ZG._T(ZG.IN_p(ZG.LOC(ZG.PRSO), ZG.WINNER)))) then
        do local _ = ZG.TELL("You're not carrying the ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
        do return false end
    elseif ((not ZG._T(ZG.IN_p(ZG.PRSO, ZG.WINNER))) and (not ZG._T(ZG.FSET_p(ZG.LOC(ZG.PRSO), "OPENBIT")))) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " is closed.", ZG._TK.CR) end
        do return false end
    else
        do local _ = ZG.MOVE(ZG.PRSO, ZG.LOC(ZG.WINNER)) end
        do return true end
    end

end, "IDROP")

ZG.IDROP = ZG.actions:get("IDROP")

-- zil: gverbs.zil:2023  <ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)>
ZG.actions:register("CCOUNT", function(OBJ)

    local CNT = 0
    local X = 0
    if ZG._T((function() X = ZG.FIRST_p(OBJ); return X end)()) then
        while true do
            if (not ZG._T(ZG.FSET_p(X, "WEARBIT"))) then
                CNT = ZG.ADD(CNT, 1)
            end
            if (not ZG._T((function() X = ZG.NEXT_p(X); return X end)())) then
                break
            end
        end
    end
    do return CNT end

end, "CCOUNT")

ZG.CCOUNT = ZG.actions:get("CCOUNT")

-- zil: gverbs.zil:2032  <ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))>
ZG.actions:register("WEIGHT", function(OBJ)

    local CONT = 0
    local WT = 0
    if ZG._T((function() CONT = ZG.FIRST_p(OBJ); return CONT end)()) then
        while true do
            if (ZG.EQ(OBJ, ZG.PLAYER) and ZG._T(ZG.FSET_p(CONT, "WEARBIT"))) then
                WT = ZG.ADD(WT, 1)
            else
                WT = ZG.ADD(WT, ZG.WEIGHT(CONT))
            end
            if (not ZG._T((function() CONT = ZG.NEXT_p(CONT); return CONT end)())) then
                break
            end
        end
    end
    do return ZG.ADD(WT, ZG.GETP(OBJ, "SIZE")) end

end, "WEIGHT")

ZG.WEIGHT = ZG.actions:get("WEIGHT")

-- zil: gverbs.zil:2045  <CONSTANT REXIT>
-- REXIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:2046  <CONSTANT UEXIT>
-- UEXIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:2047  <CONSTANT NEXIT>
-- NEXIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:2048  <CONSTANT FEXIT>
-- FEXIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:2049  <CONSTANT CEXIT>
-- CEXIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:2050  <CONSTANT DEXIT>
-- DEXIT is declared in ZilGlobal.lua

-- zil: gverbs.zil:2052  <CONSTANT NEXITSTR>
-- NEXITSTR is declared in ZilGlobal.lua

-- zil: gverbs.zil:2053  <CONSTANT FEXITFCN>
-- FEXITFCN is declared in ZilGlobal.lua

-- zil: gverbs.zil:2054  <CONSTANT CEXITFLAG>
-- CEXITFLAG is declared in ZilGlobal.lua

-- zil: gverbs.zil:2055  <CONSTANT CEXITSTR>
-- CEXITSTR is declared in ZilGlobal.lua

-- zil: gverbs.zil:2056  <CONSTANT DEXITOBJ>
-- DEXITOBJ is declared in ZilGlobal.lua

-- zil: gverbs.zil:2057  <CONSTANT DEXITSTR>
-- DEXITSTR is declared in ZilGlobal.lua

-- zil: gverbs.zil:2059  <GLOBAL INDENTS>
-- INDENTS is declared in ZilGlobal.lua

-- zil: gverbs.zil:2068  <ROUTINE HACK-HACK (STR)>
ZG.actions:register("HACK_HACK", function(STR)

    if (ZG._T(ZG.IN_p(ZG.PRSO, ZG.GLOBAL_OBJECTS)) and ZG._T(ZG.VERB_p("WAVE", "RAISE", "LOWER"))) then
        do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " isn't here!", ZG._TK.CR) end
    else
        do return ZG.TELL(STR, ZG._TK.D, ZG.PRSO, ZG.PICK_ONE(ZG.HO_HUM), ZG._TK.CR) end
    end

end, "HACK-HACK")

ZG.HACK_HACK = ZG.actions:get("HACK_HACK")

-- zil: gverbs.zil:2075  <GLOBAL HO-HUM>
-- HO_HUM is declared in ZilGlobal.lua

-- zil: gverbs.zil:2082  <ROUTINE NO-GO-TELL (AV WLOC)>
ZG.actions:register("NO_GO_TELL", function(AV, WLOC)

    if ZG._T(AV) then
        do local _ = ZG.TELL("You can't go there in a ", ZG._TK.D, WLOC, ".") end
    else
        do local _ = ZG.TELL("You can't go there without a vehicle.") end
    end
    do return ZG.CRLF() end

end, "NO-GO-TELL")

ZG.NO_GO_TELL = ZG.actions:get("NO_GO_TELL")

-- zil: gverbs.zil:2089  <ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" (LB <FSET? .RM ,RLANDBIT>) (WLOC <L...
ZG.actions:register("GOTO", function(RM, V_p)

    if V_p == nil then V_p = true end
    local LB = ZG.FSET_p(RM, "RLANDBIT")
    local WLOC = ZG.LOC(ZG.WINNER)
    local AV = false
    local OLIT = 0
    local OHERE = 0
    OLIT = ZG.LIT
    OHERE = ZG.HERE
    if ZG._T(ZG.FSET_p(WLOC, "VEHBIT")) then
        AV = ZG.GETP(WLOC, "VTYPE")
    end
    if ((not ZG._T(LB)) and (not ZG._T(AV))) then
        do local _ = ZG.NO_GO_TELL(AV, WLOC) end
        do return false end
    elseif ((not ZG._T(LB)) and (not ZG._T(ZG.FSET_p(RM, AV)))) then
        do local _ = ZG.NO_GO_TELL(AV, WLOC) end
        do return false end
    elseif (ZG._T(ZG.FSET_p(ZG.HERE, "RLANDBIT")) and ZG._T(LB) and ZG._T(AV) and (not ZG.EQ(AV, "RLANDBIT")) and (not ZG._T(ZG.FSET_p(RM, AV)))) then
        do local _ = ZG.NO_GO_TELL(AV, WLOC) end
        do return false end
    elseif ZG._T(ZG.FSET_p(RM, "RMUNGBIT")) then
        do local _ = ZG.TELL(ZG.GETP(RM, "LDESC"), ZG._TK.CR) end
        do return false end
    else
        if (ZG._T(LB) and (not ZG._T(ZG.FSET_p(ZG.HERE, "RLANDBIT"))) and (not ZG._T(ZG.DEAD)) and ZG._T(ZG.FSET_p(WLOC, "VEHBIT"))) then
            if ZG._T(ZG.FSET_p(WLOC, "VEHBIT")) then
                do local _ = ZG.TELL("The ", ZG._TK.D, WLOC, " comes to a stop.", ZG._TK.CR, ZG._TK.CR) end
            end
        end
        if ZG._T(AV) then
            do local _ = ZG.MOVE(WLOC, RM) end
        else
            do local _ = ZG.MOVE(ZG.WINNER, RM) end
        end
        ZG._set("HERE", RM)
        ZG._set("LIT", ZG.LIT_p(ZG.HERE))
        if ((not ZG._T(OLIT)) and (not ZG._T(ZG.LIT)) and ZG._T(ZG.PROB(80))) then
            if ZG._T(ZG.SPRAYED_p) then
                do local _ = ZG.TELL("There are sinister gurgling noises in the darkness all around you!", ZG._TK.CR) end
            elseif ZG.EQUAL_p(ZG.HERE, ZG.DARK_1, ZG.DARK_2) then
                do local _ = ZG.JIGS_UP("Oh, no! Dozen of lurking grues attack and devour you! You must have\nstumbled into an authentic grue lair!") end
            else
                do local _ = ZG.TELL("Oh, no! A lurking grue slithered into the ") end
                if ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT")) then
                    do local _ = ZG.TELL(ZG._TK.D, ZG.LOC(ZG.WINNER)) end
                else
                    do local _ = ZG.TELL("room") end
                end
                do local _ = ZG.JIGS_UP(" and devoured you!") end
                do return true end
            end
        end
        if ((not ZG._T(ZG.LIT)) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
            do local _ = ZG.TELL("You have moved into a dark place.", ZG._TK.CR) end
            ZG._set("P_CONT", false)
        end
        do local _ = ZG.APPLY(ZG.GETP(ZG.HERE, "ACTION"), ZG.M_ENTER) end
        do local _ = ZG.SCORE_OBJ(RM) end
        if (not ZG.EQ(ZG.HERE, RM)) then
            do return true end
        elseif ((not ZG.EQ(ZG.ADVENTURER, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.ADVENTURER, OHERE))) then
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.WINNER, " leaves the room.", ZG._TK.CR) end
        elseif ZG._T(ZG.NULL_F()) then
            do return true end
        elseif (ZG._T(V_p) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
            do local _ = ZG.V_FIRST_LOOK() end
        end
        do return true end
    end

end, "GOTO")

ZG.GOTO = ZG.actions:get("GOTO")

-- zil: gverbs.zil:2183  <ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))>
ZG.actions:register("LKP", function(ITM, TBL)

    local CNT = 0
    local LEN = ZG.GET(TBL, 0)
    while true do
        if ZG.LT(LEN, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
            do return false end
        elseif ZG.EQ(ZG.GET(TBL, CNT), ITM) then
            if ZG.EQ(CNT, LEN) then
                do return false end
            else
                do return ZG.GET(TBL, ZG.ADD(CNT, 1)) end
            end
        end
    end

end, "LKP")

ZG.LKP = ZG.actions:get("LKP")

-- zil: gverbs.zil:2192  <ROUTINE DO-WALK (DIR)>
ZG.actions:register("DO_WALK", function(DIR)

    ZG._set("P_WALK_DIR", DIR)
    do return ZG.PERFORM(ZG.SYMBOL("V?WALK"), DIR) end

end, "DO-WALK")

ZG.DO_WALK = ZG.actions:get("DO_WALK")

-- ;<ROUTINE WORD-TYPE (OBJ WORD "AUX" SYNS)
-- 	 <ZMEMQ .WORD
-- 		<SET SYNS <GETPT .OBJ ,P?SYNONYM>>
-- 		<- </ <PTSIZE .SYNS> 2> 1>>>

-- zil: gverbs.zil:2201  <ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TX)>
ZG.actions:register("GLOBAL_IN_p", function(OBJ1, OBJ2)

    local TX = 0
    if ZG._T((function() TX = ZG.GETPT(OBJ2, "GLOBAL"); return TX end)()) then
        do return ZG.ZMEMQB(OBJ1, TX, ZG.SUB(ZG.PTSIZE(TX), 1)) end
    else
        do return false end
    end

end, "GLOBAL-IN?")

ZG.GLOBAL_IN_p = ZG.actions:get("GLOBAL_IN_p")

-- zil: gverbs.zil:2205  <ROUTINE FIND-IN (WHERE WHAT "AUX" W)>
ZG.actions:register("FIND_IN", function(WHERE, WHAT)

    local W = 0
    W = ZG.FIRST_p(WHERE)
    if (not ZG._T(W)) then
        do return false end
    end
    while true do
        if (ZG._T(ZG.FSET_p(W, WHAT)) and (not ZG.EQ(W, ZG.ADVENTURER))) then
            do return W end
        elseif (not ZG._T((function() W = ZG.NEXT_p(W); return W end)())) then
            do return false end
        end
    end

end, "FIND-IN")

ZG.FIND_IN = ZG.actions:get("FIND_IN")

-- ;<ROUTINE IN-HERE? (OBJ)
-- 	 <OR <IN? .OBJ ,HERE>
-- 	     <GLOBAL-IN? .OBJ ,HERE>>>

-- zil: gverbs.zil:2221  <ROUTINE HELD? (CAN)>
ZG.actions:register("HELD_p", function(CAN)

    while true do
        CAN = ZG.LOC(CAN)
        if (not ZG._T(CAN)) then
            do return false end
        elseif ZG.EQ(CAN, ZG.WINNER) then
            do return true end
        end
    end

end, "HELD?")

ZG.HELD_p = ZG.actions:get("HELD_p")

-- zil: gverbs.zil:2227  <ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TX)>
ZG.actions:register("OTHER_SIDE", function(DOBJ)

    local P = 0
    local TX = 0
    -- ;"finds room beyond given door"
    while true do
        if ZG.LT((function() P = ZG.NEXTP(ZG.HERE, P); return P end)(), ZG.LOW_DIRECTION) then
            do return false end
        else
            TX = ZG.GETPT(ZG.HERE, P)
            if (ZG.EQ(ZG.PTSIZE(TX), ZG.DEXIT) and ZG.EQ(ZG.GETB(TX, ZG.DEXITOBJ), DOBJ)) then
                do return P end
            end
        end
    end

end, "OTHER-SIDE")

ZG.OTHER_SIDE = ZG.actions:get("OTHER_SIDE")

-- zil: gverbs.zil:2237  <ROUTINE MUNG-ROOM (RM STR)>
ZG.actions:register("MUNG_ROOM", function(RM, STR)

    do local _ = ZG.FSET(RM, "RMUNGBIT") end
    do return ZG.PUTP(RM, "LDESC", STR) end

end, "MUNG-ROOM")

ZG.MUNG_ROOM = ZG.actions:get("MUNG_ROOM")

-- zil: gverbs.zil:2245  <ROUTINE THIS-IS-IT (OBJ)>
ZG.actions:register("THIS_IS_IT", function(OBJ)

    ZG._set("P_IT_OBJECT", OBJ)
    do return ZG.P_IT_OBJECT end

end, "THIS-IS-IT")

ZG.THIS_IS_IT = ZG.actions:get("THIS_IS_IT")

-- zil: gverbs.zil:2252  <GLOBAL HELLOS>
-- HELLOS is declared in ZilGlobal.lua

-- zil: gverbs.zil:2258  <GLOBAL YUKS>
-- YUKS is declared in ZilGlobal.lua

-- zil: gverbs.zil:2267  <GLOBAL DUMMY>
-- DUMMY is declared in ZilGlobal.lua
