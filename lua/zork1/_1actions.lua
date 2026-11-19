-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: 1actions.zil:7  <ROUTINE WEST-HOUSE (RARG)>
ZG.actions:register("WEST_HOUSE", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are standing in an open field west of a white house, with a boarded\nfront door.") end
        if ZG._T(ZG.WON_FLAG) then
            do local _ = ZG.TELL(" A secret path leads southwest into the forest.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "WEST-HOUSE")

ZG.WEST_HOUSE = ZG.actions:get("WEST_HOUSE")

-- zil: 1actions.zil:17  <ROUTINE EAST-HOUSE (RARG)>
ZG.actions:register("EAST_HOUSE", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are behind the white house. A path leads into the forest\nto the east. In one corner of the house there is a small window\nwhich is ") end
        if ZG._T(ZG.FSET_p(ZG.KITCHEN_WINDOW, "OPENBIT")) then
            do local _ = ZG.TELL("open.") end
        else
            do local _ = ZG.TELL("slightly ajar.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "EAST-HOUSE")

ZG.EAST_HOUSE = ZG.actions:get("EAST_HOUSE")

-- zil: 1actions.zil:28  <ROUTINE OPEN-CLOSE (OBJ STROPN STRCLS)>
ZG.actions:register("OPEN_CLOSE", function(OBJ, STROPN, STRCLS)

    if ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.FSET_p(OBJ, "OPENBIT")) then
            do local _ = ZG.TELL(ZG.PICK_ONE(ZG.DUMMY)) end
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
            do local _ = ZG.TELL(ZG.PICK_ONE(ZG.DUMMY)) end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "OPEN-CLOSE")

ZG.OPEN_CLOSE = ZG.actions:get("OPEN_CLOSE")

-- zil: 1actions.zil:44  <ROUTINE BOARD-F ()>
ZG.actions:register("BOARD_F", function()

    if ZG._T(ZG.VERB_p("TAKE", "EXAMINE")) then
        do return ZG.TELL("The boards are securely fastened.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BOARD-F")

ZG.BOARD_F = ZG.actions:get("BOARD_F")

-- zil: 1actions.zil:48  <ROUTINE TEETH-F ()>
ZG.actions:register("TEETH_F", function()

    if (ZG._T(ZG.VERB_p("BRUSH")) and ZG.EQ(ZG.PRSO, ZG.TEETH)) then
        if (ZG.EQ(ZG.PRSI, ZG.PUTTY) and ZG._T(ZG.IN_p(ZG.PRSI, ZG.WINNER))) then
            do return ZG.JIGS_UP("Well, you seem to have been brushing your teeth with some sort of\nglue. As a result, your mouth gets glued together (with your nose)\nand you die of respiratory failure.") end
        elseif (not ZG._T(ZG.PRSI)) then
            do return ZG.TELL("Dental hygiene is highly recommended, but I'm not sure what you want\nto brush them with.", ZG._TK.CR) end
        else
            do return ZG.TELL("A nice idea, but with a ", ZG._TK.D, ZG.PRSI, "?", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "TEETH-F")

ZG.TEETH_F = ZG.actions:get("TEETH_F")

-- zil: 1actions.zil:64  <ROUTINE GRANITE-WALL-F ()>
ZG.actions:register("GRANITE_WALL_F", function()

    if ZG.EQ(ZG.HERE, ZG.NORTH_TEMPLE) then
        if ZG._T(ZG.VERB_p("FIND")) then
            do return ZG.TELL("The west wall is solid granite here.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("TAKE", "RAISE", "LOWER")) then
            do return ZG.TELL("It's solid granite.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(ZG.HERE, ZG.TREASURE_ROOM) then
        if ZG._T(ZG.VERB_p("FIND")) then
            do return ZG.TELL("The east wall is solid granite here.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("TAKE", "RAISE", "LOWER")) then
            do return ZG.TELL("It's solid granite.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(ZG.HERE, ZG.SLIDE_ROOM) then
        if ZG._T(ZG.VERB_p("FIND", "READ")) then
            do return ZG.TELL("It only SAYS \"Granite Wall\".", ZG._TK.CR) end
        else
            do return ZG.TELL("The wall isn't granite.", ZG._TK.CR) end
        end
    else
        do return ZG.TELL("There is no granite wall here.", ZG._TK.CR) end
    end

end, "GRANITE-WALL-F")

ZG.GRANITE_WALL_F = ZG.actions:get("GRANITE_WALL_F")

-- zil: 1actions.zil:82  <ROUTINE SONGBIRD-F ()>
ZG.actions:register("SONGBIRD_F", function()

    if ZG._T(ZG.VERB_p("FIND", "TAKE")) then
        do return ZG.TELL("The songbird is not here but is probably nearby.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LISTEN")) then
        do return ZG.TELL("You can't hear the songbird now.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FOLLOW")) then
        do return ZG.TELL("It can't be followed.", ZG._TK.CR) end
    else
        do return ZG.TELL("You can't see any songbird here.", ZG._TK.CR) end
    end

end, "SONGBIRD-F")

ZG.SONGBIRD_F = ZG.actions:get("SONGBIRD_F")

-- zil: 1actions.zil:92  <ROUTINE WHITE-HOUSE-F ()>
ZG.actions:register("WHITE_HOUSE_F", function()

    if ZG.EQUAL_p(ZG.HERE, ZG.KITCHEN, ZG.LIVING_ROOM, ZG.ATTIC) then
        if ZG._T(ZG.VERB_p("FIND")) then
            do return ZG.TELL("Why not find your brains?", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("WALK-AROUND")) then
            do local _ = ZG.GO_NEXT(ZG.IN_HOUSE_AROUND) end
            do return true end
        else
            do return false end
        end
    elseif (not (ZG.EQUAL_p(ZG.HERE, ZG.EAST_OF_HOUSE, ZG.WEST_OF_HOUSE) or ZG.EQUAL_p(ZG.HERE, ZG.NORTH_OF_HOUSE, ZG.SOUTH_OF_HOUSE))) then
        if ZG._T(ZG.VERB_p("FIND")) then
            if ZG.EQ(ZG.HERE, ZG.CLEARING) then
                do return ZG.TELL("It seems to be to the west.", ZG._TK.CR) end
            else
                do return ZG.TELL("It was here just a minute ago....", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("You're not at the house.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("FIND")) then
        do return ZG.TELL("It's right here! Are you blind or something?", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("WALK-AROUND")) then
        do local _ = ZG.GO_NEXT(ZG.HOUSE_AROUND) end
        do return true end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The house is a beautiful colonial house which is painted white.\nIt is clear that the owners must have been extremely wealthy.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROUGH", "OPEN")) then
        if ZG.EQ(ZG.HERE, ZG.EAST_OF_HOUSE) then
            if ZG._T(ZG.FSET_p(ZG.KITCHEN_WINDOW, "OPENBIT")) then
                do return ZG.GOTO(ZG.KITCHEN) end
            else
                do local _ = ZG.TELL("The window is closed.", ZG._TK.CR) end
                do return ZG.THIS_IS_IT(ZG.KITCHEN_WINDOW) end
            end
        else
            do return ZG.TELL("I can't see how to get in from here.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do return ZG.TELL("You must be joking.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WHITE-HOUSE-F")

ZG.WHITE_HOUSE_F = ZG.actions:get("WHITE_HOUSE_F")

-- ;"0 -> no next, 1 -> success, 2 -> failed move"

-- zil: 1actions.zil:131  <ROUTINE GO-NEXT (TBL "AUX" VAL)>
ZG.actions:register("GO_NEXT", function(TBL)

    local VAL = 0
    if ZG._T((function() VAL = ZG.LKP(ZG.HERE, TBL); return VAL end)()) then
        if (not ZG._T(ZG.GOTO(VAL))) then
            do return 2 end
        else
            do return 1 end
        end
    else
        do return false end
    end

end, "GO-NEXT")

ZG.GO_NEXT = ZG.actions:get("GO_NEXT")

-- zil: 1actions.zil:136  <ROUTINE FOREST-F ()>
ZG.actions:register("FOREST_F", function()

    if ZG._T(ZG.VERB_p("WALK-AROUND")) then
        if (ZG.EQUAL_p(ZG.HERE, ZG.WEST_OF_HOUSE, ZG.NORTH_OF_HOUSE, ZG.SOUTH_OF_HOUSE) or ZG.EQ(ZG.HERE, ZG.EAST_OF_HOUSE)) then
            do local _ = ZG.TELL("You aren't even in the forest.", ZG._TK.CR) end
        end
        do return ZG.GO_NEXT(ZG.FOREST_AROUND) end
    elseif ZG._T(ZG.VERB_p("DISEMBARK")) then
        do return ZG.TELL("You will have to specify a direction.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("FIND")) then
        do return ZG.TELL("You cannot see the forest for the trees.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LISTEN")) then
        do return ZG.TELL("The pines and the hemlocks seem to be murmuring.", ZG._TK.CR) end
    else
        do return false end
    end

end, "FOREST-F")

ZG.FOREST_F = ZG.actions:get("FOREST_F")

-- zil: 1actions.zil:152  <ROUTINE MOUNTAIN-RANGE-F ()>
ZG.actions:register("MOUNTAIN_RANGE_F", function()

    if ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-DOWN", "CLIMB-FOO")) then
        do return ZG.TELL("Don't you believe me? The mountains are impassable!", ZG._TK.CR) end
    else
        do return false end
    end

end, "MOUNTAIN-RANGE-F")

ZG.MOUNTAIN_RANGE_F = ZG.actions:get("MOUNTAIN_RANGE_F")

-- zil: 1actions.zil:157  <ROUTINE WATER-F ("AUX" AV W PI?)>
ZG.actions:register("WATER_F", function()

    local AV = 0
    local W = 0
    local PI_p = 0
    if ZG._T(ZG.VERB_p("SGIVE")) then
        do return false end
    elseif ZG._T(ZG.VERB_p("THROUGH", "BOARD")) then
        do local _ = ZG.TELL(ZG.PICK_ONE(ZG.SWIMYUKS), ZG._TK.CR) end
        do return true end
    elseif ZG._T(ZG.VERB_p("FILL")) then
        W = ZG.PRSI
        ZG._set("PRSA", ZG.SYMBOL("V?PUT"))
        ZG._set("PRSI", ZG.PRSO)
        ZG._set("PRSO", W)
        PI_p = false
    elseif (ZG.EQ(ZG.PRSO, ZG.GLOBAL_WATER) or ZG.EQ(ZG.PRSO, ZG.WATER)) then
        W = ZG.PRSO
        PI_p = false
    else
        W = ZG.PRSI
        if ZG._T(W) then
            PI_p = true
        end
    end
    if ZG.EQ(W, ZG.GLOBAL_WATER) then
        W = ZG.WATER
        if ZG._T(ZG.VERB_p("TAKE", "PUT")) then
            do local _ = ZG.REMOVE_CAREFULLY(W) end
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
        if (ZG._T(AV) and (ZG.EQ(AV, ZG.PRSI) or ((not ZG._T(ZG.PRSI)) and (not ZG._T(ZG.IN_p(W, AV)))))) then
            do local _ = ZG.TELL("There is now a puddle in the bottom of the ", ZG._TK.D, AV, ".", ZG._TK.CR) end
            do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
            do return ZG.MOVE(ZG.PRSO, AV) end
        elseif (ZG._T(ZG.PRSI) and (not ZG.EQ(ZG.PRSI, ZG.BOTTLE))) then
            do local _ = ZG.TELL("The water leaks out of the ", ZG._TK.D, ZG.PRSI, " and evaporates immediately.", ZG._TK.CR) end
            do return ZG.REMOVE_CAREFULLY(W) end
        elseif ZG._T(ZG.IN_p(ZG.BOTTLE, ZG.WINNER)) then
            if (not ZG._T(ZG.FSET_p(ZG.BOTTLE, "OPENBIT"))) then
                do local _ = ZG.TELL("The bottle is closed.", ZG._TK.CR) end
                do return ZG.THIS_IS_IT(ZG.BOTTLE) end
            elseif (not ZG._T(ZG.FIRST_p(ZG.BOTTLE))) then
                do local _ = ZG.MOVE(ZG.WATER, ZG.BOTTLE) end
                do return ZG.TELL("The bottle is now full of water.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The water slips through your fingers.", ZG._TK.CR) end
                do return true end
            end
        elseif (ZG._T(ZG.IN_p(ZG.PRSO, ZG.BOTTLE)) and ZG._T(ZG.VERB_p("TAKE")) and (not ZG._T(ZG.PRSI))) then
            do return ZG.TELL("It's in the bottle. Perhaps you should take that instead.", ZG._TK.CR) end
        else
            do return ZG.TELL("The water slips through your fingers.", ZG._TK.CR) end
        end
    elseif ZG._T(PI_p) then
        if (ZG._T(ZG.VERB_p("PUT")) and ZG._T(ZG.GLOBAL_IN_p(ZG.RIVER, ZG.HERE))) then
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?PUT"), ZG.PRSO, ZG.RIVER) end
        else
            do local _ = ZG.TELL("Nice try.", ZG._TK.CR) end
        end
        do return true end
    elseif ZG._T(ZG.VERB_p("DROP", "GIVE")) then
        if (ZG._T(ZG.VERB_p("DROP")) and ZG._T(ZG.IN_p(ZG.WATER, ZG.BOTTLE)) and (not ZG._T(ZG.FSET_p(ZG.BOTTLE, "OPENBIT")))) then
            do local _ = ZG.TELL("The bottle is closed.", ZG._TK.CR) end
            do return true end
        end
        do local _ = ZG.REMOVE_CAREFULLY(ZG.WATER) end
        if ZG._T(AV) then
            do local _ = ZG.TELL("There is now a puddle in the bottom of the ", ZG._TK.D, AV, ".", ZG._TK.CR) end
            do return ZG.MOVE(ZG.WATER, AV) end
        else
            do local _ = ZG.TELL("The water spills to the floor and evaporates immediately.", ZG._TK.CR) end
            do return ZG.REMOVE_CAREFULLY(ZG.WATER) end
        end
    elseif ZG._T(ZG.VERB_p("THROW")) then
        do local _ = ZG.TELL("The water splashes on the walls and evaporates immediately.", ZG._TK.CR) end
        do return ZG.REMOVE_CAREFULLY(ZG.WATER) end
    else
        do return false end
    end

end, "WATER-F")

ZG.WATER_F = ZG.actions:get("WATER_F")

-- zil: 1actions.zil:239  <GLOBAL KITCHEN-WINDOW-FLAG>
-- KITCHEN_WINDOW_FLAG is declared in ZilGlobal.lua

-- zil: 1actions.zil:241  <ROUTINE KITCHEN-WINDOW-F ()>
ZG.actions:register("KITCHEN_WINDOW_F", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        ZG._set("KITCHEN_WINDOW_FLAG", true)
        do return ZG.OPEN_CLOSE(ZG.KITCHEN_WINDOW, "With great effort, you open the window far enough to allow entry.", "The window closes (more easily than it opened).") end
    elseif (ZG._T(ZG.VERB_p("EXAMINE")) and (not ZG._T(ZG.KITCHEN_WINDOW_FLAG))) then
        do return ZG.TELL("The window is slightly ajar, but not enough to allow entry.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("WALK", "BOARD", "THROUGH")) then
        if ZG.EQ(ZG.HERE, ZG.KITCHEN) then
            do local _ = ZG.DO_WALK("EAST") end
        else
            do local _ = ZG.DO_WALK("WEST") end
        end
        do return true end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE")) then
        do local _ = ZG.TELL("You can see ") end
        if ZG.EQ(ZG.HERE, ZG.KITCHEN) then
            do return ZG.TELL("a clear area leading towards a forest.", ZG._TK.CR) end
        else
            do return ZG.TELL("what appears to be a kitchen.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "KITCHEN-WINDOW-F")

ZG.KITCHEN_WINDOW_F = ZG.actions:get("KITCHEN_WINDOW_F")

-- zil: 1actions.zil:264  <ROUTINE GHOSTS-F ()>
ZG.actions:register("GHOSTS_F", function()

    if ZG._T(ZG.VERB_p("TELL")) then
        do local _ = ZG.TELL("The spirits jeer loudly and ignore you.", ZG._TK.CR) end
        ZG._set("P_CONT", false)
        do return ZG.P_CONT end
    elseif ZG._T(ZG.VERB_p("EXORCISE")) then
        do return ZG.TELL("Only the ceremony itself has any effect.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("ATTACK", "MUNG")) and ZG.EQ(ZG.PRSO, ZG.GHOSTS)) then
        do return ZG.TELL("How can you attack a spirit with material objects?", ZG._TK.CR) end
    else
        do return ZG.TELL("You seem unable to interact with these spirits.", ZG._TK.CR) end
    end

end, "GHOSTS-F")

ZG.GHOSTS_F = ZG.actions:get("GHOSTS_F")

-- zil: 1actions.zil:275  <GLOBAL CAGE-TOP>
-- CAGE_TOP is declared in ZilGlobal.lua

-- zil: 1actions.zil:277  <ROUTINE BASKET-F ()>
ZG.actions:register("BASKET_F", function()

    if ZG._T(ZG.VERB_p("RAISE")) then
        if ZG._T(ZG.CAGE_TOP) then
            do return ZG.TELL(ZG.PICK_ONE(ZG.DUMMY), ZG._TK.CR) end
        else
            do local _ = ZG.MOVE(ZG.RAISED_BASKET, ZG.SHAFT_ROOM) end
            do local _ = ZG.MOVE(ZG.LOWERED_BASKET, ZG.LOWER_SHAFT) end
            ZG._set("CAGE_TOP", true)
            do local _ = ZG.THIS_IS_IT(ZG.RAISED_BASKET) end
            do return ZG.TELL("The basket is raised to the top of the shaft.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LOWER")) then
        if (not ZG._T(ZG.CAGE_TOP)) then
            do return ZG.TELL(ZG.PICK_ONE(ZG.DUMMY), ZG._TK.CR) end
        else
            do local _ = ZG.MOVE(ZG.RAISED_BASKET, ZG.LOWER_SHAFT) end
            do local _ = ZG.MOVE(ZG.LOWERED_BASKET, ZG.SHAFT_ROOM) end
            do local _ = ZG.THIS_IS_IT(ZG.LOWERED_BASKET) end
            do local _ = ZG.TELL("The basket is lowered to the bottom of the shaft.", ZG._TK.CR) end
            ZG._set("CAGE_TOP", false)
            if (ZG._T(ZG.LIT) and (not ZG._T(ZG._set("LIT", ZG.LIT_p(ZG.HERE))))) then
                do local _ = ZG.TELL("It is now pitch black.", ZG._TK.CR) end
            end
            do return true end
        end
    elseif (ZG.EQ(ZG.PRSO, ZG.LOWERED_BASKET) or ZG.EQ(ZG.PRSI, ZG.LOWERED_BASKET)) then
        do return ZG.TELL("The basket is at the other end of the chain.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQUAL_p(ZG.PRSO, ZG.RAISED_BASKET, ZG.LOWERED_BASKET)) then
        do return ZG.TELL("The cage is securely fastened to the iron chain.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BASKET-F")

ZG.BASKET_F = ZG.actions:get("BASKET_F")

-- zil: 1actions.zil:308  <ROUTINE BAT-F ()>
ZG.actions:register("BAT_F", function()

    if ZG._T(ZG.VERB_p("TELL")) then
        do local _ = ZG.FWEEP(6) end
        ZG._set("P_CONT", false)
        do return ZG.P_CONT end
    elseif ZG._T(ZG.VERB_p("TAKE", "ATTACK", "MUNG")) then
        if ZG.EQUAL_p(ZG.LOC(ZG.GARLIC), ZG.WINNER, ZG.HERE) then
            do return ZG.TELL("You can't reach him; he's on the ceiling.", ZG._TK.CR) end
        else
            do return ZG.FLY_ME() end
        end
    else
        do return false end
    end

end, "BAT-F")

ZG.BAT_F = ZG.actions:get("BAT_F")

-- zil: 1actions.zil:317  <ROUTINE FLY-ME ()>
ZG.actions:register("FLY_ME", function()

    do local _ = ZG.FWEEP(4) end
    do local _ = ZG.TELL("The bat grabs you by the scruff of your neck and lifts you away....", ZG._TK.CR, ZG._TK.CR) end
    do local _ = ZG.GOTO(ZG.PICK_ONE(ZG.BAT_DROPS), false) end
    if (not ZG.EQ(ZG.HERE, ZG.ENTRANCE_TO_HADES)) then
        do local _ = ZG.V_FIRST_LOOK() end
    end
    do return true end

end, "FLY-ME")

ZG.FLY_ME = ZG.actions:get("FLY_ME")

-- zil: 1actions.zil:326  <ROUTINE FWEEP (N)>
ZG.actions:register("FWEEP", function(N)

    while true do
        if ZG.LT((function() N = ZG.SUB(N, 1); return N end)(), 1) then
            break
        else
            do local _ = ZG.TELL("    Fweep!", ZG._TK.CR) end
        end
    end
    do return ZG.CRLF() end

end, "FWEEP")

ZG.FWEEP = ZG.actions:get("FWEEP")

-- zil: 1actions.zil:332  <GLOBAL BAT-DROPS>
-- BAT_DROPS is declared in ZilGlobal.lua

-- zil: 1actions.zil:343  <ROUTINE BELL-F ()>
ZG.actions:register("BELL_F", function()

    if ZG._T(ZG.VERB_p("RING")) then
        if (ZG.EQ(ZG.HERE, ZG.LLD_ROOM) and (not ZG._T(ZG.LLD_FLAG))) then
            do return false end
        else
            do return ZG.TELL("Ding, dong.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "BELL-F")

ZG.BELL_F = ZG.actions:get("BELL_F")

-- zil: 1actions.zil:351  <ROUTINE HOT-BELL-F ()>
ZG.actions:register("HOT_BELL_F", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The bell is very hot and cannot be taken.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("RUB")) or (ZG._T(ZG.VERB_p("RING")) and ZG._T(ZG.PRSI))) then
        if ZG._T(ZG.FSET_p(ZG.PRSI, "BURNBIT")) then
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSI, " burns and is consumed.", ZG._TK.CR) end
            do return ZG.REMOVE_CAREFULLY(ZG.PRSI) end
        elseif ZG.EQ(ZG.PRSI, ZG.HANDS) then
            do return ZG.TELL("The bell is too hot to touch.", ZG._TK.CR) end
        else
            do return ZG.TELL("The heat from the bell is too intense.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("POUR-ON")) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        do local _ = ZG.TELL("The water cools the bell and is evaporated.", ZG._TK.CR) end
        do local _ = ZG.QUEUE(ZG.I_XBH, 0) end
        do return ZG.I_XBH() end
    elseif ZG._T(ZG.VERB_p("RING")) then
        do return ZG.TELL("The bell is too hot to reach.", ZG._TK.CR) end
    else
        do return false end
    end

end, "HOT-BELL-F")

ZG.HOT_BELL_F = ZG.actions:get("HOT_BELL_F")

-- zil: 1actions.zil:370  <ROUTINE BOARDED-WINDOW-FCN ()>
ZG.actions:register("BOARDED_WINDOW_FCN", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The windows are boarded and can't be opened.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("You can't break the windows open.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BOARDED-WINDOW-FCN")

ZG.BOARDED_WINDOW_FCN = ZG.actions:get("BOARDED_WINDOW_FCN")

-- zil: 1actions.zil:376  <ROUTINE NAILS-PSEUDO ()>
ZG.actions:register("NAILS_PSEUDO", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The nails, deeply imbedded in the door, cannot be removed.", ZG._TK.CR) end
    else
        do return false end
    end

end, "NAILS-PSEUDO")

ZG.NAILS_PSEUDO = ZG.actions:get("NAILS_PSEUDO")

-- zil: 1actions.zil:381  <ROUTINE CRACK-FCN ()>
ZG.actions:register("CRACK_FCN", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.TELL("You can't fit through the crack.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CRACK-FCN")

ZG.CRACK_FCN = ZG.actions:get("CRACK_FCN")

-- zil: 1actions.zil:385  <ROUTINE KITCHEN-FCN (RARG)>
ZG.actions:register("KITCHEN_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in the kitchen of the white house. A table seems to\nhave been used recently for the preparation of food. A passage\nleads to the west and a dark staircase can be seen leading\nupward. A dark chimney leads down and to the east is a small\nwindow which is ") end
        if ZG._T(ZG.FSET_p(ZG.KITCHEN_WINDOW, "OPENBIT")) then
            do return ZG.TELL("open.", ZG._TK.CR) end
        else
            do return ZG.TELL("slightly ajar.", ZG._TK.CR) end
        end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if (ZG._T(ZG.VERB_p("CLIMB-UP")) and ZG.EQ(ZG.PRSO, ZG.STAIRS)) then
            do return ZG.DO_WALK("UP") end
        elseif (ZG._T(ZG.VERB_p("CLIMB-UP")) and ZG.EQ(ZG.PRSO, ZG.STAIRS)) then
            do return ZG.TELL("There are no stairs leading down.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "KITCHEN-FCN")

ZG.KITCHEN_FCN = ZG.actions:get("KITCHEN_FCN")

-- zil: 1actions.zil:403  <ROUTINE STONE-BARROW-FCN (RARG)>
ZG.actions:register("STONE_BARROW_FCN", function(RARG)

    if (ZG.EQ(RARG, ZG.M_BEG) and (ZG._T(ZG.VERB_p("ENTER")) or (ZG._T(ZG.VERB_p("WALK")) and ZG.EQUAL_p(ZG.PRSO, "WEST", "IN")) or (ZG._T(ZG.VERB_p("THROUGH")) and ZG.EQ(ZG.PRSO, ZG.BARROW)))) then
        do local _ = ZG.TELL("Inside the Barrow\nAs you enter the barrow, the door closes inexorably behind you. Around\nyou it is dark, but ahead is an enormous cavern, brightly lit. Through\nits center runs a wide stream. Spanning the stream is a small wooden\nfootbridge, and beyond a path leads into a dark tunnel. Above the\nbridge, floating in the air, is a large sign. It reads:  All ye who\nstand before this bridge have completed a great and perilous adventure\nwhich has tested your wit and courage. You have mastered") end
        if ZG.EQ(ZG.BAND(ZG.GETB(0, 1), 8), 0) then
            do local _ = ZG.TELL("\nthe first part of the ZORK trilogy. Those who pass over this bridge must be\nprepared to undertake an even greater adventure that will severely test your\nskill and bravery!\n\nThe ZORK trilogy continues with \"ZORK II: The Wizard of Frobozz\" and\nis completed in \"ZORK III: The Dungeon Master.\"", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("\nZORK: The Great Underground Empire.\n", ZG._TK.CR) end
        end
        do return ZG.FINISH() end
    else
        do return false end
    end

end, "STONE-BARROW-FCN")

ZG.STONE_BARROW_FCN = ZG.actions:get("STONE_BARROW_FCN")

-- zil: 1actions.zil:432  <ROUTINE BARROW-DOOR-FCN ()>
ZG.actions:register("BARROW_DOOR_FCN", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("The door is too heavy.", ZG._TK.CR) end
    else
        do return false end
    end

end, "BARROW-DOOR-FCN")

ZG.BARROW_DOOR_FCN = ZG.actions:get("BARROW_DOOR_FCN")

-- zil: 1actions.zil:436  <ROUTINE BARROW-FCN ()>
ZG.actions:register("BARROW_FCN", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.DO_WALK("WEST") end
    else
        do return false end
    end

end, "BARROW-FCN")

ZG.BARROW_FCN = ZG.actions:get("BARROW_FCN")

-- zil: 1actions.zil:442  <ROUTINE TROPHY-CASE-FCN ()>
ZG.actions:register("TROPHY_CASE_FCN", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.PRSO, ZG.TROPHY_CASE)) then
        do return ZG.TELL("The trophy case is securely fastened to the wall.", ZG._TK.CR) end
    else
        do return false end
    end

end, "TROPHY-CASE-FCN")

ZG.TROPHY_CASE_FCN = ZG.actions:get("TROPHY_CASE_FCN")

-- zil: 1actions.zil:447  <GLOBAL RUG-MOVED>
-- RUG_MOVED is declared in ZilGlobal.lua

-- zil: 1actions.zil:449  <ROUTINE LIVING-ROOM-FCN (RARG "AUX" RUG? TC)>
ZG.actions:register("LIVING_ROOM_FCN", function(RARG)

    local RUG_p = 0
    local TC = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in the living room. There is a doorway to the east") end
        if ZG._T(ZG.MAGIC_FLAG) then
            do local _ = ZG.TELL(". To the\nwest is a cyclops-shaped opening in an old wooden door, above which is\nsome strange gothic lettering, ") end
        else
            do local _ = ZG.TELL(", a wooden\ndoor with strange gothic lettering to the west, which appears to be\nnailed shut, ") end
        end
        do local _ = ZG.TELL("a trophy case, ") end
        RUG_p = ZG.RUG_MOVED
        if (ZG._T(RUG_p) and ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT"))) then
            do local _ = ZG.TELL("and a rug lying beside an open trap door.") end
        elseif ZG._T(RUG_p) then
            do local _ = ZG.TELL("and a closed trap door at your feet.") end
        elseif ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")) then
            do local _ = ZG.TELL("and an open trap door at your feet.") end
        else
            do local _ = ZG.TELL("and a large oriental rug in the center of the room.") end
        end
        do local _ = ZG.CRLF() end
        do return true end
    elseif ZG.EQ(RARG, ZG.M_END) then
        if (ZG._T(ZG.VERB_p("TAKE")) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.TROPHY_CASE))) then
            if ZG._T(ZG.IN_p(ZG.PRSO, ZG.TROPHY_CASE)) then
                do local _ = ZG.TOUCH_ALL(ZG.PRSO) end
            end
            ZG._set("SCORE", ZG.ADD(ZG.BASE_SCORE, ZG.OTVAL_FROB()))
            do local _ = ZG.SCORE_UPD(0) end
            do return false end
        else
            do return false end
        end
    else
        do return false end
    end

end, "LIVING-ROOM-FCN")

ZG.LIVING_ROOM_FCN = ZG.actions:get("LIVING_ROOM_FCN")

-- zil: 1actions.zil:487  <ROUTINE TOUCH-ALL (OBJ "AUX" F)>
ZG.actions:register("TOUCH_ALL", function(OBJ)

    local F = 0
    F = ZG.FIRST_p(OBJ)
    while true do
        if (not ZG._T(F)) then
            do return true end
        else
            do local _ = ZG.FSET(F, "TOUCHBIT") end
            if ZG._T(ZG.FIRST_p(F)) then
                do local _ = ZG.TOUCH_ALL(F) end
            end
        end
        F = ZG.NEXT_p(F)
    end

end, "TOUCH-ALL")

ZG.TOUCH_ALL = ZG.actions:get("TOUCH_ALL")

-- zil: 1actions.zil:496  <ROUTINE OTVAL-FROB ("OPTIONAL" (O ,TROPHY-CASE) "AUX" F (SCORE 0))>
ZG.actions:register("OTVAL_FROB", function(O)

    if O == nil then O = ZG.TROPHY_CASE end
    local F = 0
    local SCORE = 0
    F = ZG.FIRST_p(O)
    while true do
        if (not ZG._T(F)) then
            do return SCORE end
        end
        SCORE = ZG.ADD(SCORE, ZG.GETP(F, "TVALUE"))
        if ZG._T(ZG.FIRST_p(F)) then
            do local _ = ZG.OTVAL_FROB(F) end
        end
        F = ZG.NEXT_p(F)
    end

end, "OTVAL-FROB")

ZG.OTVAL_FROB = ZG.actions:get("OTVAL_FROB")

-- zil: 1actions.zil:504  <ROUTINE TRAP-DOOR-FCN ()>
ZG.actions:register("TRAP_DOOR_FCN", function()

    if ZG._T(ZG.VERB_p("RAISE")) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?OPEN"), ZG.TRAP_DOOR) end
        do return true end
    elseif (ZG._T(ZG.VERB_p("OPEN", "CLOSE")) and ZG.EQ(ZG.HERE, ZG.LIVING_ROOM)) then
        do return ZG.OPEN_CLOSE(ZG.PRSO, "The door reluctantly opens to reveal a rickety staircase descending into\ndarkness.", "The door swings shut and closes.") end
    elseif (ZG._T(ZG.VERB_p("LOOK-UNDER")) and ZG.EQ(ZG.HERE, ZG.LIVING_ROOM)) then
        if ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")) then
            do return ZG.TELL("You see a rickety staircase descending into darkness.", ZG._TK.CR) end
        else
            do return ZG.TELL("It's closed.", ZG._TK.CR) end
        end
    elseif ZG.EQ(ZG.HERE, ZG.CELLAR) then
        if (ZG._T(ZG.VERB_p("OPEN", "UNLOCK")) and (not ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")))) then
            do return ZG.TELL("The door is locked from above.", ZG._TK.CR) end
        elseif (ZG._T(ZG.VERB_p("CLOSE")) and (not ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")))) then
            do local _ = ZG.FCLEAR(ZG.TRAP_DOOR, "TOUCHBIT") end
            do local _ = ZG.FCLEAR(ZG.TRAP_DOOR, "OPENBIT") end
            do return ZG.TELL("The door closes and locks.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
            do return ZG.TELL(ZG.PICK_ONE(ZG.DUMMY), ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "TRAP-DOOR-FCN")

ZG.TRAP_DOOR_FCN = ZG.actions:get("TRAP_DOOR_FCN")

-- zil: 1actions.zil:531  <ROUTINE CELLAR-FCN (RARG)>
ZG.actions:register("CELLAR_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.TELL("You are in a dark and damp cellar with a narrow passageway leading\nnorth, and a crawlway to the south. On the west is the bottom of a\nsteep metal ramp which is unclimbable.", ZG._TK.CR) end
    elseif ZG.EQ(RARG, ZG.M_ENTER) then
        if (ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")) and (not ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "TOUCHBIT")))) then
            do local _ = ZG.FCLEAR(ZG.TRAP_DOOR, "OPENBIT") end
            do local _ = ZG.FSET(ZG.TRAP_DOOR, "TOUCHBIT") end
            do return ZG.TELL("The trap door crashes shut, and you hear someone barring it.", ZG._TK.CR, ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "CELLAR-FCN")

ZG.CELLAR_FCN = ZG.actions:get("CELLAR_FCN")

-- zil: 1actions.zil:545  <ROUTINE CHIMNEY-F ()>
ZG.actions:register("CHIMNEY_F", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do local _ = ZG.TELL("The chimney leads ") end
        if ZG.EQ(ZG.HERE, ZG.KITCHEN) then
            do local _ = ZG.TELL("down") end
        else
            do local _ = ZG.TELL("up") end
        end
        do return ZG.TELL("ward, and looks climbable.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CHIMNEY-F")

ZG.CHIMNEY_F = ZG.actions:get("CHIMNEY_F")

-- zil: 1actions.zil:553  <ROUTINE UP-CHIMNEY-FUNCTION ("AUX" F)>
ZG.actions:register("UP_CHIMNEY_FUNCTION", function()

    local F = 0
    if (not ZG._T((function() F = ZG.FIRST_p(ZG.WINNER); return F end)())) then
        do local _ = ZG.TELL("Going up empty-handed is a bad idea.", ZG._TK.CR) end
        do return false end
    elseif (((not ZG._T((function() F = ZG.NEXT_p(F); return F end)())) or (not ZG._T(ZG.NEXT_p(F)))) and ZG._T(ZG.IN_p(ZG.LAMP, ZG.WINNER))) then
        if (not ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT"))) then
            do local _ = ZG.FCLEAR(ZG.TRAP_DOOR, "TOUCHBIT") end
        end
        do return ZG.KITCHEN end
    else
        do local _ = ZG.TELL("You can't get up there with what you're carrying.", ZG._TK.CR) end
        do return false end
    end

end, "UP-CHIMNEY-FUNCTION")

ZG.UP_CHIMNEY_FUNCTION = ZG.actions:get("UP_CHIMNEY_FUNCTION")

-- zil: 1actions.zil:567  <ROUTINE TRAP-DOOR-EXIT ()>
ZG.actions:register("TRAP_DOOR_EXIT", function()

    if ZG._T(ZG.RUG_MOVED) then
        if ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")) then
            do return ZG.CELLAR end
        else
            do local _ = ZG.TELL("The trap door is closed.", ZG._TK.CR) end
            do local _ = ZG.THIS_IS_IT(ZG.TRAP_DOOR) end
            do return false end
        end
    else
        do local _ = ZG.TELL("You can't go that way.", ZG._TK.CR) end
        do return false end
    end

end, "TRAP-DOOR-EXIT")

ZG.TRAP_DOOR_EXIT = ZG.actions:get("TRAP_DOOR_EXIT")

-- zil: 1actions.zil:579  <ROUTINE RUG-FCN ()>
ZG.actions:register("RUG_FCN", function()

    if ZG._T(ZG.VERB_p("RAISE")) then
        do local _ = ZG.TELL("The rug is too heavy to lift") end
        if ZG._T(ZG.RUG_MOVED) then
            do return ZG.TELL(".", ZG._TK.CR) end
        else
            do return ZG.TELL(", but in trying to take it you have\nnoticed an irregularity beneath it.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("MOVE", "PUSH")) then
        if ZG._T(ZG.RUG_MOVED) then
            do return ZG.TELL("Having moved the carpet previously, you find it impossible to move\nit again.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("With a great effort, the rug is moved to one side of the room, revealing\nthe dusty cover of a closed trap door.", ZG._TK.CR) end
            do local _ = ZG.FCLEAR(ZG.TRAP_DOOR, "INVISIBLE") end
            do local _ = ZG.THIS_IS_IT(ZG.TRAP_DOOR) end
            ZG._set("RUG_MOVED", true)
            do return ZG.RUG_MOVED end
        end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The rug is extremely heavy and cannot be carried.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("LOOK-UNDER")) and (not ZG._T(ZG.RUG_MOVED)) and (not ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")))) then
        do return ZG.TELL("Underneath the rug is a closed trap door. As you drop the corner of the\nrug, the trap door is once again concealed from view.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CLIMB-ON")) then
        if ((not ZG._T(ZG.RUG_MOVED)) and (not ZG._T(ZG.FSET_p(ZG.TRAP_DOOR, "OPENBIT")))) then
            do return ZG.TELL("As you sit, you notice an irregularity underneath it. Rather than be\nuncomfortable, you stand up again.", ZG._TK.CR) end
        else
            do return ZG.TELL("I suppose you think it's a magic carpet?", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "RUG-FCN")

ZG.RUG_FCN = ZG.actions:get("RUG_FCN")

-- zil: 1actions.zil:622  <ROUTINE AXE-F ()>
ZG.actions:register("AXE_F", function()

    if ZG._T(ZG.TROLL_FLAG) then
        do return false end
    else
        do return ZG.WEAPON_FUNCTION(ZG.AXE, ZG.TROLL) end
    end

end, "AXE-F")

ZG.AXE_F = ZG.actions:get("AXE_F")

-- zil: 1actions.zil:626  <ROUTINE STILETTO-FUNCTION ()>
ZG.actions:register("STILETTO_FUNCTION", function()

    do return ZG.WEAPON_FUNCTION(ZG.STILETTO, ZG.THIEF) end

end, "STILETTO-FUNCTION")

ZG.STILETTO_FUNCTION = ZG.actions:get("STILETTO_FUNCTION")

-- zil: 1actions.zil:629  <ROUTINE WEAPON-FUNCTION (W V)>
ZG.actions:register("WEAPON_FUNCTION", function(W, V)

    if (not ZG._T(ZG.IN_p(V, ZG.HERE))) then
        do return false end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        if ZG._T(ZG.IN_p(W, V)) then
            do local _ = ZG.TELL("The ", ZG._TK.D, V, " swings it out of your reach.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The ", ZG._TK.D, W, " seems white-hot. You can't hold on to it.", ZG._TK.CR) end
        end
        do return true end
    else
        do return false end
    end

end, "WEAPON-FUNCTION")

ZG.WEAPON_FUNCTION = ZG.actions:get("WEAPON_FUNCTION")

-- zil: 1actions.zil:640  <ROUTINE TROLL-FCN ("OPTIONAL" (MODE <>))>
ZG.actions:register("TROLL_FCN", function(MODE)

    if MODE == nil then MODE = false end
    if ZG._T(ZG.VERB_p("TELL")) then
        ZG._set("P_CONT", false)
        do return ZG.TELL("The troll isn't much of a conversationalist.", ZG._TK.CR) end
    elseif ZG.EQ(MODE, ZG.F_BUSY_p) then
        if ZG._T(ZG.IN_p(ZG.AXE, ZG.TROLL)) then
            do return false end
        elseif (ZG._T(ZG.IN_p(ZG.AXE, ZG.HERE)) and ZG._T(ZG.PROB_2(75, 90))) then
            do local _ = ZG.FSET(ZG.AXE, "NDESCBIT") end
            do local _ = ZG.FCLEAR(ZG.AXE, "WEAPONBIT") end
            do local _ = ZG.MOVE(ZG.AXE, ZG.TROLL) end
            do local _ = ZG.PUTP(ZG.TROLL, "LDESC", "A nasty-looking troll, brandishing a bloody axe, blocks all passages out\nof the room.") end
            do local _ = (ZG._T(ZG.IN_p(ZG.TROLL, ZG.HERE)) and ZG.TELL("The troll, angered and humiliated, recovers his weapon. He appears to have\nan axe to grind with you.", ZG._TK.CR)) end
            do return true end
        elseif ZG._T(ZG.IN_p(ZG.TROLL, ZG.HERE)) then
            do local _ = ZG.PUTP(ZG.TROLL, "LDESC", "A pathetically babbling troll is here.") end
            do local _ = ZG.TELL("The troll, disarmed, cowers in terror, pleading for his life in\nthe guttural tongue of the trolls.", ZG._TK.CR) end
            do return true end
        else
            do return false end
        end
    elseif ZG.EQ(MODE, ZG.F_DEAD) then
        if ZG._T(ZG.IN_p(ZG.AXE, ZG.TROLL)) then
            do local _ = ZG.MOVE(ZG.AXE, ZG.HERE) end
            do local _ = ZG.FCLEAR(ZG.AXE, "NDESCBIT") end
            do local _ = ZG.FSET(ZG.AXE, "WEAPONBIT") end
        end
        ZG._set("TROLL_FLAG", true)
        do return ZG.TROLL_FLAG end
    elseif ZG.EQ(MODE, ZG.F_UNCONSCIOUS) then
        do local _ = ZG.FCLEAR(ZG.TROLL, "FIGHTBIT") end
        if ZG._T(ZG.IN_p(ZG.AXE, ZG.TROLL)) then
            do local _ = ZG.MOVE(ZG.AXE, ZG.HERE) end
            do local _ = ZG.FCLEAR(ZG.AXE, "NDESCBIT") end
            do local _ = ZG.FSET(ZG.AXE, "WEAPONBIT") end
        end
        do local _ = ZG.PUTP(ZG.TROLL, "LDESC", "An unconscious troll is sprawled on the floor. All passages\nout of the room are open.") end
        ZG._set("TROLL_FLAG", true)
        do return ZG.TROLL_FLAG end
    elseif ZG.EQ(MODE, ZG.F_CONSCIOUS) then
        if ZG._T(ZG.IN_p(ZG.TROLL, ZG.HERE)) then
            do local _ = ZG.FSET(ZG.TROLL, "FIGHTBIT") end
            do local _ = ZG.TELL("The troll stirs, quickly resuming a fighting stance.", ZG._TK.CR) end
        end
        if ZG._T(ZG.IN_p(ZG.AXE, ZG.TROLL)) then
            do local _ = ZG.PUTP(ZG.TROLL, "LDESC", "A nasty-looking troll, brandishing a bloody axe, blocks\nall passages out of the room.") end
        elseif ZG._T(ZG.IN_p(ZG.AXE, ZG.TROLL_ROOM)) then
            do local _ = ZG.FSET(ZG.AXE, "NDESCBIT") end
            do local _ = ZG.FCLEAR(ZG.AXE, "WEAPONBIT") end
            do local _ = ZG.MOVE(ZG.AXE, ZG.TROLL) end
            do local _ = ZG.PUTP(ZG.TROLL, "LDESC", "A nasty-looking troll, brandishing a bloody axe, blocks\nall passages out of the room.") end
        else
            do local _ = ZG.PUTP(ZG.TROLL, "LDESC", "A troll is here.") end
        end
        ZG._set("TROLL_FLAG", false)
        do return ZG.TROLL_FLAG end
    elseif ZG.EQ(MODE, ZG.F_FIRST_p) then
        if ZG._T(ZG.PROB_1(33)) then
            do local _ = ZG.FSET(ZG.TROLL, "FIGHTBIT") end
            ZG._set("P_CONT", false)
            do return true end
        else
            do return false end
        end
    elseif (not ZG._T(MODE)) then
        if ZG._T(ZG.VERB_p("EXAMINE")) then
            do return ZG.TELL(ZG.GETP(ZG.TROLL, "LDESC"), ZG._TK.CR) end
        elseif ((ZG._T(ZG.VERB_p("THROW", "GIVE")) and ZG._T(ZG.PRSO) and ZG.EQ(ZG.PRSI, ZG.TROLL)) or ZG._T(ZG.VERB_p("TAKE", "MOVE", "MUNG"))) then
            do local _ = ZG.AWAKEN(ZG.TROLL) end
            if ZG._T(ZG.VERB_p("THROW", "GIVE")) then
                if (ZG.EQ(ZG.PRSO, ZG.AXE) and ZG._T(ZG.IN_p(ZG.AXE, ZG.WINNER))) then
                    do local _ = ZG.TELL("The troll scratches his head in confusion, then takes the axe.", ZG._TK.CR) end
                    do local _ = ZG.FSET(ZG.TROLL, "FIGHTBIT") end
                    do local _ = ZG.MOVE(ZG.AXE, ZG.TROLL) end
                    do return true end
                elseif ZG.EQUAL_p(ZG.PRSO, ZG.TROLL, ZG.AXE) then
                    do local _ = ZG.TELL("You would have to get the ", ZG._TK.D, ZG.PRSO, " first, and that seems unlikely.", ZG._TK.CR) end
                    do return true end
                end
                if ZG._T(ZG.VERB_p("THROW")) then
                    do local _ = ZG.TELL("The troll, who is remarkably coordinated, catches the ", ZG._TK.D, ZG.PRSO) end
                else
                    do local _ = ZG.TELL("The troll, who is not overly proud, graciously accepts the gift") end
                end
                if (ZG._T(ZG.PROB_1(20)) and ZG.EQUAL_p(ZG.PRSO, ZG.KNIFE, ZG.SWORD, ZG.AXE)) then
                    do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
                    do local _ = ZG.TELL(" and eats it hungrily. Poor troll, he dies from an internal hemorrhage\nand his carcass disappears in a sinister black fog.", ZG._TK.CR) end
                    do local _ = ZG.REMOVE_CAREFULLY(ZG.TROLL) end
                    do local _ = ZG.APPLY(ZG.GETP(ZG.TROLL, "ACTION"), ZG.F_DEAD) end
                    ZG._set("TROLL_FLAG", true)
                    do return ZG.TROLL_FLAG end
                elseif ZG.EQUAL_p(ZG.PRSO, ZG.KNIFE, ZG.SWORD, ZG.AXE) then
                    do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
                    do local _ = ZG.TELL(" and, being for the moment sated, throws it back. Fortunately, the\ntroll has poor control, and the ", ZG._TK.D, ZG.PRSO, " falls to the floor. He does\nnot look pleased.", ZG._TK.CR) end
                    do return ZG.FSET(ZG.TROLL, "FIGHTBIT") end
                else
                    do local _ = ZG.TELL(" and not having the most discriminating tastes, gleefully eats it.", ZG._TK.CR) end
                    do return ZG.REMOVE_CAREFULLY(ZG.PRSO) end
                end
            elseif ZG._T(ZG.VERB_p("TAKE", "MOVE")) then
                do return ZG.TELL("The troll spits in your face, grunting \"Better luck next time\" in a\nrather barbarous accent.", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("MUNG")) then
                do return ZG.TELL("The troll laughs at your puny gesture.", ZG._TK.CR) end
            else
                do return false end
            end
        elseif ZG._T(ZG.VERB_p("LISTEN")) then
            do return ZG.TELL("Every so often the troll says something, probably uncomplimentary, in\nhis guttural tongue.", ZG._TK.CR) end
        elseif (ZG._T(ZG.TROLL_FLAG) and ZG._T(ZG.VERB_p("HELLO"))) then
            do return ZG.TELL("Unfortunately, the troll can't hear you.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "TROLL-FCN")

ZG.TROLL_FCN = ZG.actions:get("TROLL_FCN")

-- ;<GLOBAL LEAVES-GONE <>>

-- ;"no longer used?"

-- zil: 1actions.zil:771  <GLOBAL GRATE-REVEALED>
-- GRATE_REVEALED is declared in ZilGlobal.lua

-- zil: 1actions.zil:772  <GLOBAL GRUNLOCK>
-- GRUNLOCK is declared in ZilGlobal.lua

-- zil: 1actions.zil:774  <ROUTINE LEAVES-APPEAR ()>
ZG.actions:register("LEAVES_APPEAR", function()

    if ((not ZG._T(ZG.FSET_p(ZG.GRATE, "OPENBIT"))) and (not ZG._T(ZG.GRATE_REVEALED))) then
        if ZG._T(ZG.VERB_p("MOVE", "TAKE")) then
            do local _ = ZG.TELL("In disturbing the pile of leaves, a grating is revealed.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("With the leaves moved, a grating is revealed.", ZG._TK.CR) end
        end
        do local _ = ZG.FCLEAR(ZG.GRATE, "INVISIBLE") end
        ZG._set("GRATE_REVEALED", true)
    end
    do return false end

end, "LEAVES-APPEAR")

ZG.LEAVES_APPEAR = ZG.actions:get("LEAVES_APPEAR")

-- zil: 1actions.zil:786  <ROUTINE LEAF-PILE ()>
ZG.actions:register("LEAF_PILE", function()

    if ZG._T(ZG.VERB_p("COUNT")) then
        do return ZG.TELL("There are 69,105 leaves here.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do local _ = ZG.LEAVES_APPEAR() end
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        if ZG._T(ZG.IN_p(ZG.PRSO, ZG.HERE)) then
            do return ZG.TELL("The leaves burn.", ZG._TK.CR) end
        else
            do return ZG.JIGS_UP("The leaves burn, and so do you.") end
        end
    elseif ZG._T(ZG.VERB_p("CUT")) then
        do local _ = ZG.TELL("You rustle the leaves around, making quite a mess.", ZG._TK.CR) end
        do local _ = ZG.LEAVES_APPEAR() end
        do return true end
    elseif ZG._T(ZG.VERB_p("MOVE", "TAKE")) then
        if ZG._T(ZG.VERB_p("MOVE")) then
            do local _ = ZG.TELL("Done.", ZG._TK.CR) end
        end
        if ZG._T(ZG.GRATE_REVEALED) then
            do return false end
        end
        do local _ = ZG.LEAVES_APPEAR() end
        if ZG._T(ZG.VERB_p("TAKE")) then
            do return false end
        else
            do return true end
        end
    elseif (ZG._T(ZG.VERB_p("LOOK-UNDER")) and (not ZG._T(ZG.GRATE_REVEALED))) then
        do return ZG.TELL("Underneath the pile of leaves is a grating. As you release the leaves,\nthe grating is once again concealed from view.", ZG._TK.CR) end
    else
        do return false end
    end

end, "LEAF-PILE")

ZG.LEAF_PILE = ZG.actions:get("LEAF_PILE")

-- zil: 1actions.zil:815  <ROUTINE CLEARING-FCN (RARG)>
ZG.actions:register("CLEARING_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        if (not ZG._T(ZG.GRATE_REVEALED)) then
            do return ZG.FSET(ZG.GRATE, "INVISIBLE") end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a clearing, with a forest surrounding you on all sides. A\npath leads south.") end
        if ZG._T(ZG.FSET_p(ZG.GRATE, "OPENBIT")) then
            do local _ = ZG.CRLF() end
            do local _ = ZG.TELL("There is an open grating, descending into darkness.") end
        elseif ZG._T(ZG.GRATE_REVEALED) then
            do local _ = ZG.CRLF() end
            do local _ = ZG.TELL("There is a grating securely fastened into the ground.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "CLEARING-FCN")

ZG.CLEARING_FCN = ZG.actions:get("CLEARING_FCN")

-- zil: 1actions.zil:833  <ROUTINE MAZE-11-FCN (RARG)>
ZG.actions:register("MAZE_11_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.FCLEAR(ZG.GRATE, "INVISIBLE") end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a small room near the maze. There are twisty passages\nin the immediate vicinity.", ZG._TK.CR) end
        if ZG._T(ZG.FSET_p(ZG.GRATE, "OPENBIT")) then
            do local _ = ZG.TELL("Above you is an open grating with sunlight pouring in.") end
        elseif ZG._T(ZG.GRUNLOCK) then
            do local _ = ZG.TELL("Above you is a grating.") end
        else
            do local _ = ZG.TELL("Above you is a grating locked with a skull-and-crossbones lock.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "MAZE-11-FCN")

ZG.MAZE_11_FCN = ZG.actions:get("MAZE_11_FCN")

-- zil: 1actions.zil:850  <ROUTINE GRATE-FUNCTION ()>
ZG.actions:register("GRATE_FUNCTION", function()

    local _tmp1, _tmp2
    if (ZG._T(ZG.VERB_p("OPEN")) and ZG.EQ(ZG.PRSI, ZG.KEYS)) then
        do local _ = ZG.PERFORM(ZG.SYMBOL("V?UNLOCK"), ZG.GRATE, ZG.KEYS) end
        do return true end
    elseif ZG._T(ZG.VERB_p("LOCK")) then
        if ZG.EQ(ZG.HERE, ZG.GRATING_ROOM) then
            ZG._set("GRUNLOCK", false)
            do return ZG.TELL("The grate is locked.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.HERE, ZG.GRATING_CLEARING) then
            do return ZG.TELL("You can't lock it from this side.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("UNLOCK")) and ZG.EQ(ZG.PRSO, ZG.GRATE)) then
        if (ZG.EQ(ZG.HERE, ZG.GRATING_ROOM) and ZG.EQ(ZG.PRSI, ZG.KEYS)) then
            ZG._set("GRUNLOCK", true)
            do return ZG.TELL("The grate is unlocked.", ZG._TK.CR) end
        elseif (ZG.EQ(ZG.HERE, ZG.GRATING_CLEARING) and ZG.EQ(ZG.PRSI, ZG.KEYS)) then
            do return ZG.TELL("You can't reach the lock from here.", ZG._TK.CR) end
        else
            do return ZG.TELL("Can you unlock a grating with a ", ZG._TK.D, ZG.PRSI, "?", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("PICK")) then
        do return ZG.TELL("You can't pick the lock.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        if ZG._T(ZG.GRUNLOCK) then
            if ZG.EQ(ZG.HERE, ZG.CLEARING) then
                _tmp1 = "The grating opens."
            else
                _tmp1 = "The grating opens to reveal trees above you."
            end
            if ZG.EQ(ZG.HERE, ZG.CLEARING) then
                _tmp2 = "The grating opens."
            else
                _tmp2 = "The grating opens to reveal trees above you."
            end
            do local _ = ZG.OPEN_CLOSE(ZG.GRATE, _tmp2, "The grating is closed.") end
            if ZG._T(ZG.FSET_p(ZG.GRATE, "OPENBIT")) then
                if ((not ZG.EQ(ZG.HERE, ZG.CLEARING)) and (not ZG._T(ZG.GRATE_REVEALED))) then
                    do local _ = ZG.TELL("A pile of leaves falls onto your head and to the ground.", ZG._TK.CR) end
                    ZG._set("GRATE_REVEALED", true)
                    do local _ = ZG.MOVE(ZG.LEAVES, ZG.HERE) end
                end
                do return ZG.FSET(ZG.GRATING_ROOM, "ONBIT") end
            else
                do return ZG.FCLEAR(ZG.GRATING_ROOM, "ONBIT") end
            end
        else
            do return ZG.TELL("The grating is locked.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.GRATE)) then
        if ZG.LT(20, ZG.GETP(ZG.PRSO, "SIZE")) then
            do return ZG.TELL("It won't fit through the grating.", ZG._TK.CR) end
        else
            do local _ = ZG.MOVE(ZG.PRSO, ZG.GRATING_ROOM) end
            do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " goes through the grating into the darkness below.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "GRATE-FUNCTION")

ZG.GRATE_FUNCTION = ZG.actions:get("GRATE_FUNCTION")

-- zil: 1actions.zil:898  <ROUTINE MAZE-DIODES ()>
ZG.actions:register("MAZE_DIODES", function()

    do local _ = ZG.TELL("You won't be able to get back up to the tunnel you are going through\nwhen it gets to the next room.", ZG._TK.CR, ZG._TK.CR) end
    if ZG.EQ(ZG.HERE, ZG.MAZE_2) then
        do return ZG.MAZE_4 end
    elseif ZG.EQ(ZG.HERE, ZG.MAZE_7) then
        do return ZG.DEAD_END_1 end
    elseif ZG.EQ(ZG.HERE, ZG.MAZE_9) then
        do return ZG.MAZE_11 end
    elseif ZG.EQ(ZG.HERE, ZG.MAZE_12) then
        do return ZG.MAZE_5 end
    else
        do return false end
    end

end, "MAZE-DIODES")

ZG.MAZE_DIODES = ZG.actions:get("MAZE_DIODES")

-- zil: 1actions.zil:907  <ROUTINE RUSTY-KNIFE-FCN ()>
ZG.actions:register("RUSTY_KNIFE_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do local _ = (ZG._T(ZG.IN_p(ZG.SWORD, ZG.WINNER)) and ZG.TELL("As you touch the rusty knife, your sword gives a single pulse of blinding\nblue light.", ZG._TK.CR)) end
        do return false end
    elseif ((ZG.EQ(ZG.PRSI, ZG.RUSTY_KNIFE) and ZG._T(ZG.VERB_p("ATTACK"))) or (ZG._T(ZG.VERB_p("SWING")) and ZG.EQ(ZG.PRSO, ZG.RUSTY_KNIFE) and ZG._T(ZG.PRSI))) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.RUSTY_KNIFE) end
        do return ZG.JIGS_UP("As the knife approaches its victim, your mind is submerged by an\novermastering will. Slowly, your hand turns, until the rusty blade\nis an inch from your neck. The knife seems to sing as it savagely\nslits your throat.") end
    else
        do return false end
    end

end, "RUSTY-KNIFE-FCN")

ZG.RUSTY_KNIFE_FCN = ZG.actions:get("RUSTY_KNIFE_FCN")

-- zil: 1actions.zil:926  <ROUTINE KNIFE-F ()>
ZG.actions:register("KNIFE_F", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do local _ = ZG.FCLEAR(ZG.ATTIC_TABLE, "NDESCBIT") end
        do return false end
    else
        do return false end
    end

end, "KNIFE-F")

ZG.KNIFE_F = ZG.actions:get("KNIFE_F")

-- zil: 1actions.zil:931  <ROUTINE SKELETON ()>
ZG.actions:register("SKELETON", function()

    if ZG._T(ZG.VERB_p("TAKE", "RUB", "MOVE", "PUSH", "RAISE", "LOWER", "ATTACK", "KICK", "KISS")) then
        do local _ = ZG.TELL("A ghost appears in the room and is appalled at your desecration of\nthe remains of a fellow adventurer. He casts a curse on your valuables\nand banishes them to the Land of the Living Dead. The ghost leaves,\nmuttering obscenities.", ZG._TK.CR) end
        do local _ = ZG.ROB(ZG.HERE, ZG.LAND_OF_LIVING_DEAD, 100) end
        do local _ = ZG.ROB(ZG.ADVENTURER, ZG.LAND_OF_LIVING_DEAD) end
        do return true end
    else
        do return false end
    end

end, "SKELETON")

ZG.SKELETON = ZG.actions:get("SKELETON")

-- zil: 1actions.zil:944  <ROUTINE TORCH-OBJECT ()>
ZG.actions:register("TORCH_OBJECT", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The torch is burning.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("POUR-ON")) and ZG.EQ(ZG.PRSI, ZG.TORCH)) then
        do return ZG.TELL("The water evaporates before it gets close.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("LAMP-OFF")) and ZG._T(ZG.FSET_p(ZG.PRSO, "ONBIT"))) then
        do return ZG.TELL("You nearly burn your hand trying to extinguish the flame.", ZG._TK.CR) end
    else
        do return false end
    end

end, "TORCH-OBJECT")

ZG.TORCH_OBJECT = ZG.actions:get("TORCH_OBJECT")

-- zil: 1actions.zil:958  <ROUTINE MIRROR-ROOM (RARG)>
ZG.actions:register("MIRROR_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are in a large square room with tall ceilings. On the south wall\nis an enormous mirror which fills the entire wall. There are exits\non the other three sides of the room.", ZG._TK.CR) end
        if ZG._T(ZG.MIRROR_MUNG) then
            do return ZG.TELL("Unfortunately, the mirror has been destroyed by your recklessness.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "MIRROR-ROOM")

ZG.MIRROR_ROOM = ZG.actions:get("MIRROR_ROOM")

-- zil: 1actions.zil:968  <GLOBAL MIRROR-MUNG>
-- MIRROR_MUNG is declared in ZilGlobal.lua

-- zil: 1actions.zil:969  <GLOBAL LUCKY>
-- LUCKY is declared in ZilGlobal.lua

-- zil: 1actions.zil:971  <ROUTINE MIRROR-MIRROR ("AUX" (RM2 ,MIRROR-ROOM-2) L1 L2 N)>
ZG.actions:register("MIRROR_MIRROR", function()

    local RM2 = ZG.MIRROR_ROOM_2
    local L1 = 0
    local L2 = 0
    local N = 0
    if ((not ZG._T(ZG.MIRROR_MUNG)) and ZG._T(ZG.VERB_p("RUB"))) then
        if (ZG._T(ZG.PRSI) and (not ZG.EQ(ZG.PRSI, ZG.HANDS))) then
            do local _ = ZG.TELL("You feel a faint tingling transmitted through the ", ZG._TK.D, ZG.PRSI, ".", ZG._TK.CR) end
            do return true end
        end
        if ZG.EQ(ZG.HERE, RM2) then
            RM2 = ZG.MIRROR_ROOM_1
        end
        L1 = ZG.FIRST_p(ZG.HERE)
        L2 = ZG.FIRST_p(RM2)
        while true do
            if (not ZG._T(L1)) then
                break
            end
            N = ZG.NEXT_p(L1)
            do local _ = ZG.MOVE(L1, RM2) end
            L1 = N
        end
        while true do
            if (not ZG._T(L2)) then
                break
            end
            N = ZG.NEXT_p(L2)
            do local _ = ZG.MOVE(L2, ZG.HERE) end
            L2 = N
        end
        do local _ = ZG.GOTO(RM2, false) end
        do return ZG.TELL("There is a rumble from deep within the earth and the room shakes.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE", "EXAMINE")) then
        if ZG._T(ZG.MIRROR_MUNG) then
            do local _ = ZG.TELL("The mirror is broken into many pieces.") end
        else
            do local _ = ZG.TELL("There is an ugly person staring back at you.") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The mirror is many times your size. Give up.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG", "THROW", "ATTACK")) then
        if ZG._T(ZG.MIRROR_MUNG) then
            do return ZG.TELL("Haven't you done enough damage already?", ZG._TK.CR) end
        else
            ZG._set("MIRROR_MUNG", true)
            ZG._set("LUCKY", false)
            do return ZG.TELL("You have broken the mirror. I hope you have a seven years' supply of\ngood luck handy.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "MIRROR-MIRROR")

ZG.MIRROR_MIRROR = ZG.actions:get("MIRROR_MIRROR")

-- zil: 1actions.zil:1018  <ROUTINE TORCH-ROOM-FCN (RARG)>
ZG.actions:register("TORCH_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a large room with a prominent doorway leading to a down\nstaircase. Above you is a large dome. Up around the edge of the\ndome (20 feet up) is a wooden railing. In the center of the room\nsits a white marble pedestal.", ZG._TK.CR) end
        if ZG._T(ZG.DOME_FLAG) then
            do return ZG.TELL("A piece of rope descends from the railing above, ending some\nfive feet above your head.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "TORCH-ROOM-FCN")

ZG.TORCH_ROOM_FCN = ZG.actions:get("TORCH_ROOM_FCN")

-- zil: 1actions.zil:1030  <ROUTINE DOME-ROOM-FCN (RARG)>
ZG.actions:register("DOME_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are at the periphery of a large dome, which forms the ceiling\nof another room below. Protecting you from a precipitous drop is a\nwooden railing which circles the dome.", ZG._TK.CR) end
        if ZG._T(ZG.DOME_FLAG) then
            do return ZG.TELL("Hanging down from the railing is a rope which ends about ten feet\nfrom the floor below.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_ENTER) then
        if ZG._T(ZG.DEAD) then
            do local _ = ZG.TELL("As you enter the dome you feel a strong pull as if from a wind\ndrawing you over the railing and down.", ZG._TK.CR) end
            do local _ = ZG.MOVE(ZG.WINNER, ZG.TORCH_ROOM) end
            ZG._set("HERE", ZG.TORCH_ROOM)
            do return true end
        elseif ZG._T(ZG.VERB_p("LEAP")) then
            do return ZG.JIGS_UP("I'm afraid that the leap you attempted has done you in.") end
        else
            do return false end
        end
    else
        do return false end
    end

end, "DOME-ROOM-FCN")

ZG.DOME_ROOM_FCN = ZG.actions:get("DOME_ROOM_FCN")

-- ;<GLOBAL EGYPT-FLAG <>>

-- ;"no longer used?"

-- zil: 1actions.zil:1058  <ROUTINE LLD-ROOM (RARG)>
ZG.actions:register("LLD_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are outside a large gateway, on which is inscribed\n\n  Abandon every hope\nall ye who enter here!\n\nThe gate is open; through it you can see a desolation, with a pile of\nmangled bodies in one corner. Thousands of voices, lamenting some\nhideous fate, can be heard.", ZG._TK.CR) end
        if ((not ZG._T(ZG.LLD_FLAG)) and (not ZG._T(ZG.DEAD))) then
            do return ZG.TELL("The way through the gate is barred by evil spirits, who jeer at your\nattempts to pass.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if ZG._T(ZG.VERB_p("EXORCISE")) then
            if (not ZG._T(ZG.LLD_FLAG)) then
                if (ZG._T(ZG.IN_p(ZG.BELL, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.BOOK, ZG.WINNER)) and ZG._T(ZG.IN_p(ZG.CANDLES, ZG.WINNER))) then
                    do return ZG.TELL("You must perform the ceremony.", ZG._TK.CR) end
                else
                    do return ZG.TELL("You aren't equipped for an exorcism.", ZG._TK.CR) end
                end
            else
                do return false end
            end
        elseif ((not ZG._T(ZG.LLD_FLAG)) and ZG._T(ZG.VERB_p("RING")) and ZG.EQ(ZG.PRSO, ZG.BELL)) then
            ZG._set("XB", true)
            do local _ = ZG.REMOVE_CAREFULLY(ZG.BELL) end
            do local _ = ZG.THIS_IS_IT(ZG.HOT_BELL) end
            do local _ = ZG.MOVE(ZG.HOT_BELL, ZG.HERE) end
            do local _ = ZG.TELL("The bell suddenly becomes red hot and falls to the ground. The\nwraiths, as if paralyzed, stop their jeering and slowly turn to face\nyou. On their ashen faces, the expression of a long-forgotten terror\ntakes shape.", ZG._TK.CR) end
            if ZG._T(ZG.IN_p(ZG.CANDLES, ZG.WINNER)) then
                do local _ = ZG.TELL("In your confusion, the candles drop to the ground (and they are out).", ZG._TK.CR) end
                do local _ = ZG.MOVE(ZG.CANDLES, ZG.HERE) end
                do local _ = ZG.FCLEAR(ZG.CANDLES, "ONBIT") end
                do local _ = ZG.DISABLE(ZG.INT(ZG.I_CANDLES)) end
            end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_XB, 6)) end
            do return ZG.ENABLE(ZG.QUEUE(ZG.I_XBH, 20)) end
        elseif (ZG._T(ZG.XC) and ZG._T(ZG.VERB_p("READ")) and ZG.EQ(ZG.PRSO, ZG.BOOK) and (not ZG._T(ZG.LLD_FLAG))) then
            do local _ = ZG.TELL("Each word of the prayer reverberates through the hall in a deafening\nconfusion. As the last word fades, a voice, loud and commanding,\nspeaks: \"Begone, fiends!\" A heart-stopping scream fills the cavern,\nand the spirits, sensing a greater power, flee through the walls.", ZG._TK.CR) end
            do local _ = ZG.REMOVE_CAREFULLY(ZG.GHOSTS) end
            ZG._set("LLD_FLAG", true)
            do return ZG.DISABLE(ZG.INT(ZG.I_XC)) end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_END) then
        if (ZG._T(ZG.XB) and ZG._T(ZG.IN_p(ZG.CANDLES, ZG.WINNER)) and ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT")) and (not ZG._T(ZG.XC))) then
            ZG._set("XC", true)
            do local _ = ZG.TELL("The flames flicker wildly and appear to dance. The earth beneath\nyour feet trembles, and your legs nearly buckle beneath you.\nThe spirits cower at your unearthly power.", ZG._TK.CR) end
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_XB)) end
            do return ZG.ENABLE(ZG.QUEUE(ZG.I_XC, 3)) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "LLD-ROOM")

ZG.LLD_ROOM = ZG.actions:get("LLD_ROOM")

-- zil: 1actions.zil:1127  <GLOBAL XB>
-- XB is declared in ZilGlobal.lua

-- zil: 1actions.zil:1129  <GLOBAL XC>
-- XC is declared in ZilGlobal.lua

-- zil: 1actions.zil:1131  <ROUTINE I-XB ()>
ZG.actions:register("I_XB", function()

    do local _ = (function() local _v = ZG.XC; if ZG._T(_v) then return _v end; return (ZG.EQ(ZG.HERE, ZG.ENTRANCE_TO_HADES) and ZG.TELL("The tension of this ceremony is broken, and the wraiths, amused but\nshaken at your clumsy attempt, resume their hideous jeering.", ZG._TK.CR)) end)() end
    ZG._set("XB", false)
    do return ZG.XB end

end, "I-XB")

ZG.I_XB = ZG.actions:get("I_XB")

-- zil: 1actions.zil:1139  <ROUTINE I-XC ()>
ZG.actions:register("I_XC", function()

    ZG._set("XC", false)
    do return ZG.I_XB() end

end, "I-XC")

ZG.I_XC = ZG.actions:get("I_XC")

-- zil: 1actions.zil:1143  <ROUTINE I-XBH ()>
ZG.actions:register("I_XBH", function()

    do local _ = ZG.REMOVE_CAREFULLY(ZG.HOT_BELL) end
    do local _ = ZG.MOVE(ZG.BELL, ZG.ENTRANCE_TO_HADES) end
    if ZG.EQ(ZG.HERE, ZG.ENTRANCE_TO_HADES) then
        do return ZG.TELL("The bell appears to have cooled down.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-XBH")

ZG.I_XBH = ZG.actions:get("I_XBH")

-- zil: 1actions.zil:1153  <GLOBAL GATE-FLAG>
-- GATE_FLAG is declared in ZilGlobal.lua

-- zil: 1actions.zil:1154  <GLOBAL GATES-OPEN>
-- GATES_OPEN is declared in ZilGlobal.lua

-- zil: 1actions.zil:1156  <ROUTINE DAM-ROOM-FCN (RARG)>
ZG.actions:register("DAM_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are standing on the top of the Flood Control Dam #3, which was\nquite a tourist attraction in times far distant. There are paths to\nthe north, south, and west, and a scramble down.", ZG._TK.CR) end
        if (ZG._T(ZG.LOW_TIDE) and ZG._T(ZG.GATES_OPEN)) then
            do local _ = ZG.TELL("The water level behind the dam is low: The sluice gates have been\nopened. Water rushes through the dam and downstream.", ZG._TK.CR) end
        elseif ZG._T(ZG.GATES_OPEN) then
            do local _ = ZG.TELL("The sluice gates are open, and water rushes through the dam. The\nwater level behind the dam is still high.", ZG._TK.CR) end
        elseif ZG._T(ZG.LOW_TIDE) then
            do local _ = ZG.TELL("The sluice gates are closed. The water level in the reservoir is\nquite low, but the level is rising quickly.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The sluice gates on the dam are closed. Behind the dam, there can be\nseen a wide reservoir. Water is pouring over the top of the now\nabandoned dam.", ZG._TK.CR) end
        end
        do local _ = ZG.TELL("There is a control panel here, on which a large metal bolt is mounted.\nDirectly above the bolt is a small green plastic bubble") end
        if ZG._T(ZG.GATE_FLAG) then
            do local _ = ZG.TELL(" which is\nglowing serenely") end
        end
        do return ZG.TELL(".", ZG._TK.CR) end
    else
        do return false end
    end

end, "DAM-ROOM-FCN")

ZG.DAM_ROOM_FCN = ZG.actions:get("DAM_ROOM_FCN")

-- zil: 1actions.zil:1187  <ROUTINE BOLT-F ()>
ZG.actions:register("BOLT_F", function()

    if ZG._T(ZG.VERB_p("TURN")) then
        if ZG.EQ(ZG.PRSI, ZG.WRENCH) then
            if ZG._T(ZG.GATE_FLAG) then
                do local _ = ZG.FCLEAR(ZG.RESERVOIR_SOUTH, "TOUCHBIT") end
                if ZG._T(ZG.GATES_OPEN) then
                    ZG._set("GATES_OPEN", false)
                    do local _ = ZG.FCLEAR(ZG.LOUD_ROOM, "TOUCHBIT") end
                    do local _ = ZG.TELL("The sluice gates close and water starts to collect behind the dam.", ZG._TK.CR) end
                    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_RFILL, 8)) end
                    do local _ = ZG.QUEUE(ZG.I_REMPTY, 0) end
                    do return true end
                else
                    ZG._set("GATES_OPEN", true)
                    do local _ = ZG.TELL("The sluice gates open and water pours through the dam.", ZG._TK.CR) end
                    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_REMPTY, 8)) end
                    do local _ = ZG.QUEUE(ZG.I_RFILL, 0) end
                    do return true end
                end
            else
                do return ZG.TELL("The bolt won't turn with your best effort.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("The bolt won't turn using the ", ZG._TK.D, ZG.PRSI, ".", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.INTEGRAL_PART() end
    elseif ZG._T(ZG.VERB_p("OIL")) then
        do return ZG.TELL("Hmm. It appears the tube contained glue, not oil. Turning the bolt\nwon't get any easier....", ZG._TK.CR) end
    else
        do return false end
    end

end, "BOLT-F")

ZG.BOLT_F = ZG.actions:get("BOLT_F")

-- zil: 1actions.zil:1219  <ROUTINE BUBBLE-F ()>
ZG.actions:register("BUBBLE_F", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.INTEGRAL_PART() end
    else
        do return false end
    end

end, "BUBBLE-F")

ZG.BUBBLE_F = ZG.actions:get("BUBBLE_F")

-- zil: 1actions.zil:1223  <ROUTINE INTEGRAL-PART ()>
ZG.actions:register("INTEGRAL_PART", function()

    do return ZG.TELL("It is an integral part of the control panel.", ZG._TK.CR) end

end, "INTEGRAL-PART")

ZG.INTEGRAL_PART = ZG.actions:get("INTEGRAL_PART")

-- zil: 1actions.zil:1226  <ROUTINE I-RFILL ()>
ZG.actions:register("I_RFILL", function()

    do local _ = ZG.FSET(ZG.RESERVOIR, "NONLANDBIT") end
    do local _ = ZG.FCLEAR(ZG.RESERVOIR, "RLANDBIT") end
    do local _ = ZG.FCLEAR(ZG.DEEP_CANYON, "TOUCHBIT") end
    do local _ = ZG.FCLEAR(ZG.LOUD_ROOM, "TOUCHBIT") end
    do local _ = (ZG._T(ZG.IN_p(ZG.TRUNK, ZG.RESERVOIR)) and ZG.FSET(ZG.TRUNK, "INVISIBLE")) end
    ZG._set("LOW_TIDE", false)
    if ZG.EQ(ZG.HERE, ZG.RESERVOIR) then
        if ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT")) then
            do local _ = ZG.TELL("The boat lifts gently out of the mud and is now floating on\nthe reservoir.", ZG._TK.CR) end
        else
            do local _ = ZG.JIGS_UP("You are lifted up by the rising river! You try to swim, but the\ncurrents are too strong. You come closer, closer to the awesome\nstructure of Flood Control Dam #3. The dam beckons to you.\nThe roar of the water nearly deafens you, but you remain conscious\nas you tumble over the dam toward your certain doom among the rocks\nat its base.") end
        end
    elseif ZG.EQ(ZG.HERE, ZG.DEEP_CANYON) then
        do local _ = ZG.TELL("A sound, like that of flowing water, starts to come from below.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.HERE, ZG.LOUD_ROOM) then
        do local _ = ZG.TELL("All of a sudden, an alarmingly loud roaring sound fills the room.\nFilled with fear, you scramble away.", ZG._TK.CR) end
        do local _ = ZG.GOTO(ZG.PICK_ONE(ZG.LOUD_RUNS)) end
    elseif ZG.EQUAL_p(ZG.HERE, ZG.RESERVOIR_NORTH, ZG.RESERVOIR_SOUTH) then
        do local _ = ZG.TELL("You notice that the water level has risen to the point that it\nis impossible to cross.", ZG._TK.CR) end
    end
    do return true end

end, "I-RFILL")

ZG.I_RFILL = ZG.actions:get("I_RFILL")

-- zil: 1actions.zil:1261  <GLOBAL LOUD-RUNS>
-- LOUD_RUNS is declared in ZilGlobal.lua

-- zil: 1actions.zil:1263  <ROUTINE I-REMPTY ()>
ZG.actions:register("I_REMPTY", function()

    do local _ = ZG.FSET(ZG.RESERVOIR, "RLANDBIT") end
    do local _ = ZG.FCLEAR(ZG.RESERVOIR, "NONLANDBIT") end
    do local _ = ZG.FCLEAR(ZG.DEEP_CANYON, "TOUCHBIT") end
    do local _ = ZG.FCLEAR(ZG.LOUD_ROOM, "TOUCHBIT") end
    do local _ = ZG.FCLEAR(ZG.TRUNK, "INVISIBLE") end
    ZG._set("LOW_TIDE", true)
    if (ZG.EQ(ZG.HERE, ZG.RESERVOIR) and ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT"))) then
        do local _ = ZG.TELL("The water level has dropped to the point at which the boat can no\nlonger stay afloat. It sinks into the mud.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.HERE, ZG.DEEP_CANYON) then
        do local _ = ZG.TELL("The roar of rushing water is quieter now.", ZG._TK.CR) end
    elseif ZG.EQUAL_p(ZG.HERE, ZG.RESERVOIR_NORTH, ZG.RESERVOIR_SOUTH) then
        do local _ = ZG.TELL("The water level is now quite low here and you could easily cross over\nto the other side.", ZG._TK.CR) end
    end
    do return true end

end, "I-REMPTY")

ZG.I_REMPTY = ZG.actions:get("I_REMPTY")

-- zil: 1actions.zil:1284  <GLOBAL DROWNINGS>
-- DROWNINGS is declared in ZilGlobal.lua

-- zil: 1actions.zil:1295  <GLOBAL WATER-LEVEL>
-- WATER_LEVEL is declared in ZilGlobal.lua

-- GDECL _arg

-- zil: 1actions.zil:1298  <ROUTINE BUTTON-F ()>
ZG.actions:register("BUTTON_F", function()

    if ZG._T(ZG.VERB_p("READ")) then
        do return ZG.TELL("They're greek to you.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PUSH")) then
        if ZG.EQ(ZG.PRSO, ZG.BLUE_BUTTON) then
            if ZG.ZERO_p(ZG.WATER_LEVEL) then
                do local _ = ZG.FCLEAR(ZG.LEAK, "INVISIBLE") end
                do local _ = ZG.TELL("There is a rumbling sound and a stream of water appears to burst\nfrom the east wall of the room (apparently, a leak has occurred in a\npipe).", ZG._TK.CR) end
                ZG._set("WATER_LEVEL", 1)
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MAINT_ROOM, -1)) end
                do return true end
            else
                do return ZG.TELL("The blue button appears to be jammed.", ZG._TK.CR) end
            end
        elseif ZG.EQ(ZG.PRSO, ZG.RED_BUTTON) then
            do local _ = ZG.TELL("The lights within the room ") end
            if ZG._T(ZG.FSET_p(ZG.HERE, "ONBIT")) then
                do local _ = ZG.FCLEAR(ZG.HERE, "ONBIT") end
                do return ZG.TELL("shut off.", ZG._TK.CR) end
            else
                do local _ = ZG.FSET(ZG.HERE, "ONBIT") end
                do return ZG.TELL("come on.", ZG._TK.CR) end
            end
        elseif ZG.EQ(ZG.PRSO, ZG.BROWN_BUTTON) then
            do local _ = ZG.FCLEAR(ZG.DAM_ROOM, "TOUCHBIT") end
            ZG._set("GATE_FLAG", false)
            do return ZG.TELL("Click.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSO, ZG.YELLOW_BUTTON) then
            do local _ = ZG.FCLEAR(ZG.DAM_ROOM, "TOUCHBIT") end
            ZG._set("GATE_FLAG", true)
            do return ZG.TELL("Click.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "BUTTON-F")

ZG.BUTTON_F = ZG.actions:get("BUTTON_F")

-- zil: 1actions.zil:1332  <ROUTINE TOOL-CHEST-FCN ()>
ZG.actions:register("TOOL_CHEST_FCN", function()

    if ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The chests are all empty.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TAKE", "OPEN", "PUT")) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.TOOL_CHEST) end
        do return ZG.TELL("The chests are so rusty and corroded that they crumble when you\ntouch them.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The chests are already open.", ZG._TK.CR) end
    else
        do return false end
    end

end, "TOOL-CHEST-FCN")

ZG.TOOL_CHEST_FCN = ZG.actions:get("TOOL_CHEST_FCN")

-- zil: 1actions.zil:1343  <ROUTINE I-MAINT-ROOM ("AUX" HERE?)>
ZG.actions:register("I_MAINT_ROOM", function()

    local HERE_p = 0
    HERE_p = ZG.EQ(ZG.HERE, ZG.MAINTENANCE_ROOM)
    if ZG._T(HERE_p) then
        do local _ = ZG.TELL("The water level here is now ") end
        do local _ = ZG.TELL(ZG.GET(ZG.DROWNINGS, ZG.DIV(ZG.WATER_LEVEL, 2))) end
        do local _ = ZG.CRLF() end
    end
    ZG._set("WATER_LEVEL", ZG.ADD(1, ZG.WATER_LEVEL))
    if (not ZG.LT(ZG.WATER_LEVEL, 14)) then
        do local _ = ZG.MUNG_ROOM(ZG.MAINTENANCE_ROOM, "The room is full of water and cannot be entered.") end
        do local _ = ZG.QUEUE(ZG.I_MAINT_ROOM, 0) end
        if ZG._T(HERE_p) then
            do local _ = ZG.JIGS_UP("I'm afraid you have done drowned yourself.") end
        end
    elseif (ZG._T(ZG.IN_p(ZG.WINNER, ZG.INFLATED_BOAT)) and ZG.EQUAL_p(ZG.HERE, ZG.MAINTENANCE_ROOM, ZG.DAM_ROOM, ZG.DAM_LOBBY)) then
        do local _ = ZG.JIGS_UP("The rising water carries the boat over the dam, down the river, and over\nthe falls. Tsk, tsk.") end
    end
    do return true end

end, "I-MAINT-ROOM")

ZG.I_MAINT_ROOM = ZG.actions:get("I_MAINT_ROOM")

-- zil: 1actions.zil:1362  <ROUTINE LEAK-FUNCTION ()>
ZG.actions:register("LEAK_FUNCTION", function()

    if ZG.LT(0, ZG.WATER_LEVEL) then
        if (ZG._T(ZG.VERB_p("PUT", "PUT-ON")) and ZG.EQ(ZG.PRSO, ZG.PUTTY)) then
            do return ZG.FIX_MAINT_LEAK() end
        elseif ZG._T(ZG.VERB_p("PLUG")) then
            if ZG.EQ(ZG.PRSI, ZG.PUTTY) then
                do return ZG.FIX_MAINT_LEAK() end
            else
                do return ZG.WITH_TELL(ZG.PRSI) end
            end
        else
            do return false end
        end
    else
        do return false end
    end

end, "LEAK-FUNCTION")

ZG.LEAK_FUNCTION = ZG.actions:get("LEAK_FUNCTION")

-- zil: 1actions.zil:1372  <ROUTINE FIX-MAINT-LEAK ()>
ZG.actions:register("FIX_MAINT_LEAK", function()

    ZG._set("WATER_LEVEL", -1)
    do local _ = ZG.QUEUE(ZG.I_MAINT_ROOM, 0) end
    do return ZG.TELL("By some miracle of Zorkian technology, you have managed to stop the\nleak in the dam.", ZG._TK.CR) end

end, "FIX-MAINT-LEAK")

ZG.FIX_MAINT_LEAK = ZG.actions:get("FIX_MAINT_LEAK")

-- zil: 1actions.zil:1379  <ROUTINE PUTTY-FCN ()>
ZG.actions:register("PUTTY_FCN", function()

    if ((ZG._T(ZG.VERB_p("OIL")) and ZG.EQ(ZG.PRSI, ZG.PUTTY)) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.PUTTY))) then
        do return ZG.TELL("The all-purpose gunk isn't a lubricant.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PUTTY-FCN")

ZG.PUTTY_FCN = ZG.actions:get("PUTTY_FCN")

-- zil: 1actions.zil:1386  <ROUTINE TUBE-FUNCTION ()>
ZG.actions:register("TUBE_FUNCTION", function()

    if (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.TUBE)) then
        do return ZG.TELL("The tube refuses to accept anything.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("SQUEEZE")) then
        if (ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) and ZG._T(ZG.IN_p(ZG.PUTTY, ZG.PRSO))) then
            do local _ = ZG.MOVE(ZG.PUTTY, ZG.WINNER) end
            do return ZG.TELL("The viscous material oozes into your hand.", ZG._TK.CR) end
        elseif ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do return ZG.TELL("The tube is apparently empty.", ZG._TK.CR) end
        else
            do return ZG.TELL("The tube is closed.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "TUBE-FUNCTION")

ZG.TUBE_FUNCTION = ZG.actions:get("TUBE_FUNCTION")

-- zil: 1actions.zil:1400  <ROUTINE DAM-FUNCTION ()>
ZG.actions:register("DAM_FUNCTION", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("Sounds reasonable, but this isn't how.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PLUG")) then
        if ZG.EQ(ZG.PRSI, ZG.HANDS) then
            do return ZG.TELL("Are you the little Dutch boy, then? Sorry, this is a big dam.", ZG._TK.CR) end
        else
            do return ZG.TELL("With a ", ZG._TK.D, ZG.PRSI, "? Do you know how big this dam is? You could only\nstop a tiny leak with that.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "DAM-FUNCTION")

ZG.DAM_FUNCTION = ZG.actions:get("DAM_FUNCTION")

-- zil: 1actions.zil:1412  <ROUTINE WITH-TELL (OBJ)>
ZG.actions:register("WITH_TELL", function(OBJ)

    do return ZG.TELL("With a ", ZG._TK.D, OBJ, "?", ZG._TK.CR) end

end, "WITH-TELL")

ZG.WITH_TELL = ZG.actions:get("WITH_TELL")

-- zil: 1actions.zil:1415  <ROUTINE RESERVOIR-SOUTH-FCN (RARG)>
ZG.actions:register("RESERVOIR_SOUTH_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        if (ZG._T(ZG.LOW_TIDE) and ZG._T(ZG.GATES_OPEN)) then
            do local _ = ZG.TELL("You are in a long room, to the north of which was formerly a lake.\nHowever, with the water level lowered, there is merely a wide stream\nrunning through the center of the room.") end
        elseif ZG._T(ZG.GATES_OPEN) then
            do local _ = ZG.TELL("You are in a long room. To the north is a large lake, too deep\nto cross. You notice, however, that the water level appears to be\ndropping at a rapid rate. Before long, it might be possible to cross\nto the other side from here.") end
        elseif ZG._T(ZG.LOW_TIDE) then
            do local _ = ZG.TELL("You are in a long room, to the north of which is a wide area which\nwas formerly a reservoir, but now is merely a stream. You notice,\nhowever, that the level of the stream is rising quickly and that\nbefore long it will be impossible to cross here.") end
        else
            do local _ = ZG.TELL("You are in a long room on the south shore of a large lake, far\ntoo deep and wide for crossing.") end
        end
        do local _ = ZG.CRLF() end
        do return ZG.TELL("There is a path along the stream to the east or west, a steep pathway\nclimbing southwest along the edge of a chasm, and a path leading into a\ncanyon to the southeast.", ZG._TK.CR) end
    else
        do return false end
    end

end, "RESERVOIR-SOUTH-FCN")

ZG.RESERVOIR_SOUTH_FCN = ZG.actions:get("RESERVOIR_SOUTH_FCN")

-- zil: 1actions.zil:1444  <ROUTINE RESERVOIR-FCN (RARG)>
ZG.actions:register("RESERVOIR_FCN", function(RARG)

    if (ZG.EQ(RARG, ZG.M_END) and (not ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT"))) and (not ZG._T(ZG.GATES_OPEN)) and ZG._T(ZG.LOW_TIDE)) then
        do return ZG.TELL("You notice that the water level here is rising rapidly. The currents\nare also becoming stronger. Staying here seems quite perilous!", ZG._TK.CR) end
    elseif ZG.EQ(RARG, ZG.M_LOOK) then
        if ZG._T(ZG.LOW_TIDE) then
            do local _ = ZG.TELL("You are on what used to be a large lake, but which is now a large\nmud pile. There are \"shores\" to the north and south.") end
        else
            do local _ = ZG.TELL("You are on the lake. Beaches can be seen north and south.\nUpstream a small stream enters the lake through a narrow cleft\nin the rocks. The dam can be seen downstream.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "RESERVOIR-FCN")

ZG.RESERVOIR_FCN = ZG.actions:get("RESERVOIR_FCN")

-- zil: 1actions.zil:1464  <ROUTINE RESERVOIR-NORTH-FCN (RARG)>
ZG.actions:register("RESERVOIR_NORTH_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        if (ZG._T(ZG.LOW_TIDE) and ZG._T(ZG.GATES_OPEN)) then
            do local _ = ZG.TELL("You are in a large cavernous room, the south of which was formerly\na lake. However, with the water level lowered, there is merely\na wide stream running through there.") end
        elseif ZG._T(ZG.GATES_OPEN) then
            do local _ = ZG.TELL("You are in a large cavernous area. To the south is a wide lake,\nwhose water level appears to be falling rapidly.") end
        elseif ZG._T(ZG.LOW_TIDE) then
            do local _ = ZG.TELL("You are in a cavernous area, to the south of which is a very wide\nstream. The level of the stream is rising rapidly, and it appears\nthat before long it will be impossible to cross to the other side.") end
        else
            do local _ = ZG.TELL("You are in a large cavernous room, north of a large lake.") end
        end
        do local _ = ZG.CRLF() end
        do return ZG.TELL("There is a slimy stairway leaving the room to the north.", ZG._TK.CR) end
    else
        do return false end
    end

end, "RESERVOIR-NORTH-FCN")

ZG.RESERVOIR_NORTH_FCN = ZG.actions:get("RESERVOIR_NORTH_FCN")

-- zil: 1actions.zil:1491  <ROUTINE BOTTLE-FUNCTION ("AUX" (E? <>))>
ZG.actions:register("BOTTLE_FUNCTION", function()

    local E_p = false
    if (ZG._T(ZG.VERB_p("THROW")) and ZG.EQ(ZG.PRSO, ZG.BOTTLE)) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        E_p = true
        do local _ = ZG.TELL("The bottle hits the far wall and shatters.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        E_p = true
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        do local _ = ZG.TELL("A brilliant maneuver destroys the bottle.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("SHAKE")) then
        if (ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) and ZG._T(ZG.IN_p(ZG.WATER, ZG.PRSO))) then
            E_p = true
        end
    end
    if (ZG._T(E_p) and ZG._T(ZG.IN_p(ZG.WATER, ZG.PRSO))) then
        do local _ = ZG.TELL("The water spills to the floor and evaporates.", ZG._TK.CR) end
        do local _ = ZG.REMOVE_CAREFULLY(ZG.WATER) end
        do return true end
    elseif ZG._T(E_p) then
        do return true end
    else
        do return false end
    end

end, "BOTTLE-FUNCTION")

ZG.BOTTLE_FUNCTION = ZG.actions:get("BOTTLE_FUNCTION")

-- zil: 1actions.zil:1513  <GLOBAL CYCLOWRATH>
-- CYCLOWRATH is declared in ZilGlobal.lua

-- zil: 1actions.zil:1515  <ROUTINE CYCLOPS-FCN ("AUX" COUNT)>
ZG.actions:register("CYCLOPS_FCN", function()

    local COUNT = 0
    COUNT = ZG.CYCLOWRATH
    if ZG.EQ(ZG.WINNER, ZG.CYCLOPS) then
        if ZG._T(ZG.CYCLOPS_FLAG) then
            do return ZG.TELL("No use talking to him. He's fast asleep.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("ODYSSEUS")) then
            ZG._set("WINNER", ZG.ADVENTURER)
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?ODYSSEUS")) end
            do return true end
        else
            do return ZG.TELL("The cyclops prefers eating to making conversation.", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.CYCLOPS_FLAG) then
        if ZG._T(ZG.VERB_p("EXAMINE")) then
            do return ZG.TELL("The cyclops is sleeping like a baby, albeit a very ugly one.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("ALARM", "KICK", "ATTACK", "BURN", "MUNG")) then
            do local _ = ZG.TELL("The cyclops yawns and stares at the thing that woke him up.", ZG._TK.CR) end
            ZG._set("CYCLOPS_FLAG", false)
            do local _ = ZG.FSET(ZG.CYCLOPS, "FIGHTBIT") end
            if ZG.LT(COUNT, 0) then
                ZG._set("CYCLOWRATH", ZG.NEG(COUNT))
                do return ZG.CYCLOWRATH end
            else
                ZG._set("CYCLOWRATH", COUNT)
                do return ZG.CYCLOWRATH end
            end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("A hungry cyclops is standing at the foot of the stairs.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("GIVE")) and ZG.EQ(ZG.PRSI, ZG.CYCLOPS)) then
        if ZG.EQ(ZG.PRSO, ZG.LUNCH) then
            if (not ZG.LT(COUNT, 0)) then
                do local _ = ZG.REMOVE_CAREFULLY(ZG.LUNCH) end
                do local _ = ZG.TELL("The cyclops says \"Mmm Mmm. I love hot peppers! But oh, could I use\na drink. Perhaps I could drink the blood of that thing.\"  From the\ngleam in his eye, it could be surmised that you are \"that thing\".", ZG._TK.CR) end
                ZG._set("CYCLOWRATH", ZG.MIN(-1, ZG.NEG(COUNT)))
            end
            do return ZG.ENABLE(ZG.QUEUE(ZG.I_CYCLOPS, -1)) end
        elseif (ZG.EQ(ZG.PRSO, ZG.WATER) or (ZG.EQ(ZG.PRSO, ZG.BOTTLE) and ZG._T(ZG.IN_p(ZG.WATER, ZG.BOTTLE)))) then
            if ZG.LT(COUNT, 0) then
                do local _ = ZG.REMOVE_CAREFULLY(ZG.WATER) end
                do local _ = ZG.MOVE(ZG.BOTTLE, ZG.HERE) end
                do local _ = ZG.FSET(ZG.BOTTLE, "OPENBIT") end
                do local _ = ZG.FCLEAR(ZG.CYCLOPS, "FIGHTBIT") end
                do local _ = ZG.TELL("The cyclops takes the bottle, checks that it's open, and drinks the water.\nA moment later, he lets out a yawn that nearly blows you over, and then\nfalls fast asleep (what did you put in that drink, anyway?).", ZG._TK.CR) end
                ZG._set("CYCLOPS_FLAG", true)
                do return ZG.CYCLOPS_FLAG end
            else
                do return ZG.TELL("The cyclops apparently is not thirsty and refuses your generous offer.", ZG._TK.CR) end
            end
        elseif ZG.EQ(ZG.PRSO, ZG.GARLIC) then
            do return ZG.TELL("The cyclops may be hungry, but there is a limit.", ZG._TK.CR) end
        else
            do return ZG.TELL("The cyclops is not so stupid as to eat THAT!", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("THROW", "ATTACK", "MUNG")) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CYCLOPS, -1)) end
        if ZG._T(ZG.VERB_p("MUNG")) then
            do return ZG.TELL("\"Do you think I'm as stupid as my father was?\", he says, dodging.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The cyclops shrugs but otherwise ignores your pitiful attempt.", ZG._TK.CR) end
            if ZG._T(ZG.VERB_p("THROW")) then
                do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
            end
            do return true end
        end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("The cyclops doesn't take kindly to being grabbed.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TIE")) then
        do return ZG.TELL("You cannot tie the cyclops, though he is fit to be tied.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LISTEN")) then
        do return ZG.TELL("You can hear his stomach rumbling.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CYCLOPS-FCN")

ZG.CYCLOPS_FCN = ZG.actions:get("CYCLOPS_FCN")

-- zil: 1actions.zil:1596  <ROUTINE I-CYCLOPS ()>
ZG.actions:register("I_CYCLOPS", function()

    if (ZG._T(ZG.CYCLOPS_FLAG) or ZG._T(ZG.DEAD)) then
        do return true end
    elseif (not ZG.EQ(ZG.HERE, ZG.CYCLOPS_ROOM)) then
        do return ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS)) end
    else
        if ZG.LT(5, ZG.ABS(ZG.CYCLOWRATH)) then
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS)) end
            do return ZG.JIGS_UP("The cyclops, tired of all of your games and trickery, grabs you firmly.\nAs he licks his chops, he says \"Mmm. Just like Mom used to make 'em.\"\nIt's nice to be appreciated.") end
        else
            if ZG.LT(ZG.CYCLOWRATH, 0) then
                ZG._set("CYCLOWRATH", ZG.SUB(ZG.CYCLOWRATH, 1))
            else
                ZG._set("CYCLOWRATH", ZG.ADD(ZG.CYCLOWRATH, 1))
            end
            if (not ZG._T(ZG.CYCLOPS_FLAG)) then
                do return ZG.TELL(ZG.NTH(ZG.CYCLOMAD, ZG.SUB(ZG.ABS(ZG.CYCLOWRATH), 1)), ZG._TK.CR) end
            else
                do return false end
            end
        end
    end

end, "I-CYCLOPS")

ZG.I_CYCLOPS = ZG.actions:get("I_CYCLOPS")

-- zil: 1actions.zil:1616  <ROUTINE CYCLOPS-ROOM-FCN (RARG)>
ZG.actions:register("CYCLOPS_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This room has an exit on the northwest, and a staircase leading up.", ZG._TK.CR) end
        if (ZG._T(ZG.CYCLOPS_FLAG) and (not ZG._T(ZG.MAGIC_FLAG))) then
            do return ZG.TELL("The cyclops is sleeping blissfully at the foot of the stairs.", ZG._TK.CR) end
        elseif ZG._T(ZG.MAGIC_FLAG) then
            do return ZG.TELL("The east wall, previously solid, now has a cyclops-sized opening in it.", ZG._TK.CR) end
        elseif ZG.ZERO_p(ZG.CYCLOWRATH) then
            do return ZG.TELL("A cyclops, who looks prepared to eat horses (much less mere\nadventurers), blocks the staircase. From his state of health, and\nthe bloodstains on the walls, you gather that he is not very\nfriendly, though he likes people.", ZG._TK.CR) end
        elseif ZG.LT(0, ZG.CYCLOWRATH) then
            do return ZG.TELL("The cyclops is standing in the corner, eyeing you closely. I don't\nthink he likes you very much. He looks extremely hungry, even for a\ncyclops.", ZG._TK.CR) end
        elseif ZG.LT(ZG.CYCLOWRATH, 0) then
            do return ZG.TELL("The cyclops, having eaten the hot peppers, appears to be gasping.\nHis enflamed tongue protrudes from his man-sized mouth.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_ENTER) then
        do return (function() local _v = ZG.ZERO_p(ZG.CYCLOWRATH); if ZG._T(_v) then return _v end; return ZG.ENABLE(ZG.INT(ZG.I_CYCLOPS)) end)() end
    else
        do return false end
    end

end, "CYCLOPS-ROOM-FCN")

ZG.CYCLOPS_ROOM_FCN = ZG.actions:get("CYCLOPS_ROOM_FCN")

-- zil: 1actions.zil:1644  <GLOBAL CYCLOMAD>
-- CYCLOMAD is declared in ZilGlobal.lua

-- zil: 1actions.zil:1658  <GLOBAL LOUD-FLAG>
-- LOUD_FLAG is declared in ZilGlobal.lua

-- zil: 1actions.zil:1660  <ROUTINE LOUD-ROOM-FCN (RARG "AUX" WRD)>
ZG.actions:register("LOUD_ROOM_FCN", function(RARG)

    local WRD = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a large room with a ceiling which cannot be detected from\nthe ground. There is a narrow passage from east to west and a stone\nstairway leading upward.") end
        if (ZG._T(ZG.LOUD_FLAG) or ((not ZG._T(ZG.GATES_OPEN)) and ZG._T(ZG.LOW_TIDE))) then
            do local _ = ZG.TELL(" The room is eerie in its quietness.") end
        else
            do local _ = ZG.TELL(" The room is deafeningly loud with an\nundetermined rushing sound. The sound seems to reverberate from all\nof the walls, making it difficult even to think.") end
        end
        do return ZG.CRLF() end
    elseif (ZG.EQ(RARG, ZG.M_END) and ZG._T(ZG.GATES_OPEN) and (not ZG._T(ZG.LOW_TIDE))) then
        do local _ = ZG.TELL("It is unbearably loud here, with an ear-splitting roar seeming to\ncome from all around you. There is a pounding in your head which won't\nstop. With a tremendous effort, you scramble out of the room.", ZG._TK.CR, ZG._TK.CR) end
        do local _ = ZG.GOTO(ZG.PICK_ONE(ZG.LOUD_RUNS)) end
        do return false end
    elseif ZG.EQ(RARG, ZG.M_ENTER) then
        if (ZG._T(ZG.LOUD_FLAG) or ((not ZG._T(ZG.GATES_OPEN)) and ZG._T(ZG.LOW_TIDE))) then
            do return false end
        elseif (ZG._T(ZG.GATES_OPEN) and (not ZG._T(ZG.LOW_TIDE))) then
            do return false end
        else
            do local _ = ZG.V_FIRST_LOOK() end
            if ZG._T(ZG.P_CONT) then
                do local _ = ZG.TELL("The rest of your commands have been lost in the noise.", ZG._TK.CR) end
                ZG._set("P_CONT", false)
            end
            while true do
                local _brk1 = false
                repeat
                    if (not ZG._T(ZG.SUPER_BRIEF)) then
                        do local _ = ZG.CRLF() end
                    end
                    do local _ = ZG.TELL(">") end
                    do local _ = ZG.READ(ZG.P_INBUF, ZG.P_LEXV) end
                    if ZG.ZERO_p(ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS)) then
                        do local _ = ZG.TELL("I beg your pardon?", ZG._TK.CR) end
                        break
                    end
                    WRD = ZG.GET(ZG.P_LEXV, 1)
                    if ZG.EQUAL_p(WRD, ZG.WORD("go"), ZG.WORD("walk"), ZG.WORD("run")) then
                        WRD = ZG.GET(ZG.P_LEXV, 3)
                    elseif ZG.EQ(WRD, ZG.WORD("say")) then
                        WRD = ZG.GET(ZG.P_LEXV, 5)
                    end
                    if ZG.EQ(WRD, ZG.WORD("save")) then
                        do local _ = ZG.V_SAVE() end
                    elseif ZG.EQ(WRD, ZG.WORD("restore")) then
                        do local _ = ZG.V_RESTORE() end
                    elseif ZG.EQUAL_p(WRD, ZG.WORD("q"), ZG.WORD("quit")) then
                        do local _ = ZG.V_QUIT() end
                    elseif ZG.EQUAL_p(WRD, ZG.WORD("w"), ZG.WORD("west")) then
                        do return ZG.GOTO(ZG.ROUND_ROOM) end
                    elseif ZG.EQUAL_p(WRD, ZG.WORD("e"), ZG.WORD("east")) then
                        do return ZG.GOTO(ZG.DAMP_CAVE) end
                    elseif ZG.EQUAL_p(WRD, ZG.WORD("u"), ZG.WORD("up")) then
                        do return ZG.GOTO(ZG.DEEP_CANYON) end
                    elseif ZG.EQ(WRD, ZG.WORD("bug")) then
                        do local _ = ZG.TELL("That's only your opinion.", ZG._TK.CR) end
                    elseif ZG.EQ(WRD, ZG.WORD("echo")) then
                        ZG._set("LOUD_FLAG", true)
                        do local _ = ZG.FCLEAR(ZG.BAR, "SACREDBIT") end
                        do local _ = ZG.TELL("The acoustics of the room change subtly.", ZG._TK.CR) end
                        if (not ZG._T(ZG.SUPER_BRIEF)) then
                            do local _ = ZG.CRLF() end
                        end
                        do return true end
                    else
                        do local _ = ZG.V_ECHO() end
                    end
                until true
                if _brk1 then break end
            end
        end
    else
        do return false end
    end

end, "LOUD-ROOM-FCN")

ZG.LOUD_ROOM_FCN = ZG.actions:get("LOUD_ROOM_FCN")

-- zil: 1actions.zil:1730  <ROUTINE DEEP-CANYON-F (RARG)>
ZG.actions:register("DEEP_CANYON_F", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are on the south edge of a deep canyon. Passages lead off to the\neast, northwest and southwest. A stairway leads down.") end
        if (ZG._T(ZG.GATES_OPEN) and (not ZG._T(ZG.LOW_TIDE))) then
            do local _ = ZG.TELL(" You can hear a loud roaring sound, like that of rushing water, from\nbelow.") end
        elseif ((not ZG._T(ZG.GATES_OPEN)) and ZG._T(ZG.LOW_TIDE)) then
            do local _ = ZG.CRLF() end
            do return true end
        else
            do local _ = ZG.TELL(" You can hear the sound of flowing water from below.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "DEEP-CANYON-F")

ZG.DEEP_CANYON_F = ZG.actions:get("DEEP_CANYON_F")

-- zil: 1actions.zil:1748  <GLOBAL EGG-SOLVE>
-- EGG_SOLVE is declared in ZilGlobal.lua

-- zil: 1actions.zil:1754  <GLOBAL THIEF-HERE>
-- THIEF_HERE is declared in ZilGlobal.lua

-- ;"I-THIEF moved to DEMONS"

-- zil: 1actions.zil:1764  <ROUTINE THIEF-VS-ADVENTURER (HERE? "AUX" ROBBED? (WINNER-ROBBED? <>))>
ZG.actions:register("THIEF_VS_ADVENTURER", function(HERE_p)

    local ROBBED_p = 0
    local WINNER_ROBBED_p = false
    if ((not ZG._T(ZG.DEAD)) and ZG.EQ(ZG.HERE, ZG.TREASURE_ROOM)) then
    elseif (not ZG._T(ZG.THIEF_HERE)) then
        if ((not ZG._T(ZG.DEAD)) and (not ZG._T(HERE_p)) and ZG._T(ZG.PROB_1(30))) then
            if ZG._T(ZG.IN_p(ZG.STILETTO, ZG.THIEF)) then
                do local _ = ZG.FCLEAR(ZG.THIEF, "INVISIBLE") end
                do local _ = ZG.TELL("Someone carrying a large bag is casually leaning against one of the\nwalls here. He does not speak, but it is clear from his aspect that\nthe bag will be taken only over his dead body.", ZG._TK.CR) end
                ZG._set("THIEF_HERE", true)
                do return true end
            end
        elseif (ZG._T(HERE_p) and ZG._T(ZG.FSET_p(ZG.THIEF, "FIGHTBIT")) and (not ZG._T(ZG.WINNING_p(ZG.THIEF)))) then
            do local _ = ZG.TELL("Your opponent, determining discretion to be the better part of\nvalor, decides to terminate this little contretemps. With a rueful\nnod of his head, he steps backward into the gloom and disappears.", ZG._TK.CR) end
            do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
            do local _ = ZG.FCLEAR(ZG.THIEF, "FIGHTBIT") end
            do local _ = ZG.RECOVER_STILETTO() end
            do return true end
        elseif (ZG._T(HERE_p) and ZG._T(ZG.FSET_p(ZG.THIEF, "FIGHTBIT")) and ZG._T(ZG.PROB_1(90))) then
            do return false end
        elseif (ZG._T(HERE_p) and ZG._T(ZG.PROB_1(30))) then
            do local _ = ZG.TELL("The holder of the large bag just left, looking disgusted.\nFortunately, he took nothing.", ZG._TK.CR) end
            do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
            do local _ = ZG.RECOVER_STILETTO() end
            do return true end
        elseif ZG._T(ZG.PROB_1(70)) then
            do return false end
        elseif (not ZG._T(ZG.DEAD)) then
            if ZG._T(ZG.ROB(ZG.HERE, ZG.THIEF, 100)) then
                ROBBED_p = ZG.HERE
            elseif ZG._T(ZG.ROB(ZG.WINNER, ZG.THIEF)) then
                ROBBED_p = ZG.PLAYER
            end
            ZG._set("THIEF_HERE", true)
            if (ZG._T(ROBBED_p) and (not ZG._T(HERE_p))) then
                do local _ = ZG.TELL("A seedy-looking individual with a large bag just wandered through\nthe room. On the way through, he quietly abstracted some valuables from ") end
                if ZG.EQ(ROBBED_p, ZG.HERE) then
                    do local _ = ZG.TELL("the room") end
                else
                    do local _ = ZG.TELL("your possession") end
                end
                do local _ = ZG.TELL(", mumbling something about\n\"Doing unto others before...\"", ZG._TK.CR) end
                do local _ = ZG.STOLE_LIGHT_p() end
            elseif ZG._T(HERE_p) then
                do local _ = ZG.RECOVER_STILETTO() end
                if ZG._T(ROBBED_p) then
                    do local _ = ZG.TELL("The thief just left, still carrying his large bag. You may\nnot have noticed that he ") end
                    if ZG.EQ(ROBBED_p, ZG.PLAYER) then
                        do local _ = ZG.TELL("robbed you blind first.") end
                    else
                        do local _ = ZG.TELL("appropriated the valuables in the room.") end
                    end
                    do local _ = ZG.CRLF() end
                    do local _ = ZG.STOLE_LIGHT_p() end
                else
                    do local _ = ZG.TELL("The thief, finding nothing of value, left disgusted.", ZG._TK.CR) end
                end
                do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
                HERE_p = false
                do return true end
            else
                do local _ = ZG.TELL("A \"lean and hungry\" gentleman just wandered through, carrying a\nlarge bag. Finding nothing of value, he left disgruntled.", ZG._TK.CR) end
                do return true end
            end
        end
    else
        if ZG._T(HERE_p) then
            if ZG._T(ZG.PROB_1(30)) then
                if ZG._T(ZG.ROB(ZG.HERE, ZG.THIEF, 100)) then
                    ROBBED_p = ZG.HERE
                elseif ZG._T(ZG.ROB(ZG.WINNER, ZG.THIEF)) then
                    ROBBED_p = ZG.PLAYER
                end
                if ZG._T(ROBBED_p) then
                    do local _ = ZG.TELL("The thief just left, still carrying his large bag. You may\nnot have noticed that he ") end
                    if ZG.EQ(ROBBED_p, ZG.PLAYER) then
                        do local _ = ZG.TELL("robbed you blind first.") end
                    else
                        do local _ = ZG.TELL("appropriated the valuables in the room.") end
                    end
                    do local _ = ZG.CRLF() end
                    do local _ = ZG.STOLE_LIGHT_p() end
                else
                    do local _ = ZG.TELL("The thief, finding nothing of value, left disgusted.", ZG._TK.CR) end
                end
                do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
                HERE_p = false
                do local _ = ZG.RECOVER_STILETTO() end
            end
        end
    end
    do return false end

end, "THIEF-VS-ADVENTURER")

ZG.THIEF_VS_ADVENTURER = ZG.actions:get("THIEF_VS_ADVENTURER")

-- zil: 1actions.zil:1875  <ROUTINE STOLE-LIGHT? ("AUX" OLD-LIT)>
ZG.actions:register("STOLE_LIGHT_p", function()

    local OLD_LIT = 0
    OLD_LIT = ZG.LIT
    ZG._set("LIT", ZG.LIT_p(ZG.HERE))
    if ((not ZG._T(ZG.LIT)) and ZG._T(OLD_LIT)) then
        do local _ = ZG.TELL("The thief seems to have left you in the dark.", ZG._TK.CR) end
    end
    do return true end

end, "STOLE-LIGHT?")

ZG.STOLE_LIGHT_p = ZG.actions:get("STOLE_LIGHT_p")

-- ;"RECOVER-STILETTO moved to DEMONS"

-- zil: 1actions.zil:1888  <ROUTINE HACK-TREASURES ("AUX" X)>
ZG.actions:register("HACK_TREASURES", function()

    local X = 0
    do local _ = ZG.RECOVER_STILETTO() end
    do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
    X = ZG.FIRST_p(ZG.TREASURE_ROOM)
    while true do
        if (not ZG._T(X)) then
            do return true end
        else
            do local _ = ZG.FCLEAR(X, "INVISIBLE") end
        end
        X = ZG.NEXT_p(X)
    end

end, "HACK-TREASURES")

ZG.HACK_TREASURES = ZG.actions:get("HACK_TREASURES")

-- zil: 1actions.zil:1897  <ROUTINE DEPOSIT-BOOTY (RM "AUX" X N (FLG <>))>
ZG.actions:register("DEPOSIT_BOOTY", function(RM)

    local X = 0
    local N = 0
    local FLG = false
    X = ZG.FIRST_p(ZG.THIEF)
    while true do
        if (not ZG._T(X)) then
            do return FLG end
        end
        N = ZG.NEXT_p(X)
        if ZG.EQUAL_p(X, ZG.STILETTO, ZG.LARGE_BAG) then
        elseif ZG.LT(0, ZG.GETP(X, "TVALUE")) then
            do local _ = ZG.MOVE(X, RM) end
            FLG = true
            if ZG.EQ(X, ZG.EGG) then
                ZG._set("EGG_SOLVE", true)
                do local _ = ZG.FSET(ZG.EGG, "OPENBIT") end
            end
        end
        X = N
    end

end, "DEPOSIT-BOOTY")

ZG.DEPOSIT_BOOTY = ZG.actions:get("DEPOSIT_BOOTY")

-- zil: 1actions.zil:1917  <ROUTINE ROB-MAZE (RM "AUX" X N)>
ZG.actions:register("ROB_MAZE", function(RM)

    local X = 0
    local N = 0
    X = ZG.FIRST_p(RM)
    while true do
        if (not ZG._T(X)) then
            do return false end
        end
        N = ZG.NEXT_p(X)
        if (ZG._T(ZG.FSET_p(X, "TAKEBIT")) and (not ZG._T(ZG.FSET_p(X, "INVISIBLE"))) and ZG._T(ZG.PROB_1(40))) then
            do local _ = ZG.TELL("You hear, off in the distance, someone saying \"My, I wonder what\nthis fine ", ZG._TK.D, X, " is doing here.\"", ZG._TK.CR) end
            if ZG._T(ZG.PROB_2(60, 80)) then
                do local _ = ZG.MOVE(X, ZG.THIEF) end
                do local _ = ZG.FSET(X, "TOUCHBIT") end
                do local _ = ZG.FSET(X, "INVISIBLE") end
            end
            do return true end
        end
        X = N
    end

end, "ROB-MAZE")

ZG.ROB_MAZE = ZG.actions:get("ROB_MAZE")

-- zil: 1actions.zil:1945  <GLOBAL THIEF-ENGROSSED>
-- THIEF_ENGROSSED is declared in ZilGlobal.lua

-- zil: 1actions.zil:1947  <ROUTINE ROBBER-FUNCTION ("OPTIONAL" (MODE <>) "AUX" (FLG <>) X N)>
ZG.actions:register("ROBBER_FUNCTION", function(MODE)

    if MODE == nil then MODE = false end
    local FLG = false
    local X = 0
    local N = 0
    if ZG._T(ZG.VERB_p("TELL")) then
        do local _ = ZG.TELL("The thief is a strong, silent type.", ZG._TK.CR) end
        ZG._set("P_CONT", false)
        do return ZG.P_CONT end
    elseif (not ZG._T(MODE)) then
        if (ZG._T(ZG.VERB_p("HELLO")) and ZG.EQ(ZG.GETP(ZG.THIEF, "LDESC"), ZG.ROBBER_U_DESC)) then
            do return ZG.TELL("The thief, being temporarily incapacitated, is unable to acknowledge\nyour greeting with his usual graciousness.", ZG._TK.CR) end
        elseif (ZG.EQ(ZG.PRSO, ZG.KNIFE) and ZG._T(ZG.VERB_p("THROW")) and (not ZG._T(ZG.FSET_p(ZG.THIEF, "FIGHTBIT")))) then
            do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
            if ZG._T(ZG.PROB_2(10, 0)) then
                do local _ = ZG.TELL("You evidently frightened the robber, though you didn't hit him. He\nflees") end
                do local _ = ZG.REMOVE(ZG.LARGE_BAG) end
                X = false
                if ZG._T(ZG.IN_p(ZG.STILETTO, ZG.THIEF)) then
                    do local _ = ZG.REMOVE(ZG.STILETTO) end
                    X = true
                end
                if ZG._T(ZG.FIRST_p(ZG.THIEF)) then
                    do local _ = ZG.MOVE_ALL(ZG.THIEF, ZG.HERE) end
                    do local _ = ZG.TELL(", but the contents of his bag fall on the floor.") end
                else
                    do local _ = ZG.TELL(".") end
                end
                do local _ = ZG.MOVE(ZG.LARGE_BAG, ZG.THIEF) end
                if ZG._T(X) then
                    do local _ = ZG.MOVE(ZG.STILETTO, ZG.THIEF) end
                end
                do local _ = ZG.CRLF() end
                do return ZG.FSET(ZG.THIEF, "INVISIBLE") end
            else
                do local _ = ZG.TELL("You missed. The thief makes no attempt to take the knife, though it\nwould be a fine addition to the collection in his bag. He does seem\nangered by your attempt.", ZG._TK.CR) end
                do return ZG.FSET(ZG.THIEF, "FIGHTBIT") end
            end
        elseif (ZG._T(ZG.VERB_p("THROW", "GIVE")) and ZG._T(ZG.PRSO) and (not ZG.EQ(ZG.PRSO, ZG.THIEF)) and ZG.EQ(ZG.PRSI, ZG.THIEF)) then
            if ZG.LT(ZG.GETP(ZG.THIEF, "STRENGTH"), 0) then
                do local _ = ZG.PUTP(ZG.THIEF, "STRENGTH", ZG.NEG(ZG.GETP(ZG.THIEF, "STRENGTH"))) end
                do local _ = ZG.ENABLE(ZG.INT(ZG.I_THIEF)) end
                do local _ = ZG.RECOVER_STILETTO() end
                do local _ = ZG.PUTP(ZG.THIEF, "LDESC", ZG.ROBBER_C_DESC) end
                do local _ = ZG.TELL("Your proposed victim suddenly recovers consciousness.", ZG._TK.CR) end
            end
            do local _ = ZG.MOVE(ZG.PRSO, ZG.THIEF) end
            if ZG.LT(0, ZG.GETP(ZG.PRSO, "TVALUE")) then
                ZG._set("THIEF_ENGROSSED", true)
                do return ZG.TELL("The thief is taken aback by your unexpected generosity, but accepts\nthe ", ZG._TK.D, ZG.PRSO, " and stops to admire its beauty.", ZG._TK.CR) end
            else
                do return ZG.TELL("The thief places the ", ZG._TK.D, ZG.PRSO, " in his bag and thanks\nyou politely.", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.VERB_p("TAKE")) then
            do return ZG.TELL("Once you got him, what would you do with him?", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("EXAMINE", "LOOK-INSIDE")) then
            do return ZG.TELL("The thief is a slippery character with beady eyes that flit back\nand forth. He carries, along with an unmistakable arrogance, a large bag\nover his shoulder and a vicious stiletto, whose blade is aimed\nmenacingly in your direction. I'd watch out if I were you.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("LISTEN")) then
            do return ZG.TELL("The thief says nothing, as you have not been formally introduced.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(MODE, ZG.F_BUSY_p) then
        if ZG._T(ZG.IN_p(ZG.STILETTO, ZG.THIEF)) then
            do return false end
        elseif ZG._T(ZG.IN_p(ZG.STILETTO, ZG.LOC(ZG.THIEF))) then
            do local _ = ZG.MOVE(ZG.STILETTO, ZG.THIEF) end
            do local _ = ZG.FSET(ZG.STILETTO, "NDESCBIT") end
            if ZG._T(ZG.IN_p(ZG.THIEF, ZG.HERE)) then
                do local _ = ZG.TELL("The robber, somewhat surprised at this turn of events, nimbly\nretrieves his stiletto.", ZG._TK.CR) end
            end
            do return true end
        else
            do return false end
        end
    elseif ZG.EQ(MODE, ZG.F_DEAD) then
        do local _ = ZG.MOVE(ZG.STILETTO, ZG.HERE) end
        do local _ = ZG.FCLEAR(ZG.STILETTO, "NDESCBIT") end
        X = ZG.DEPOSIT_BOOTY(ZG.HERE)
        if ZG.EQ(ZG.HERE, ZG.TREASURE_ROOM) then
            X = ZG.FIRST_p(ZG.HERE)
            while true do
                if (not ZG._T(X)) then
                    do local _ = ZG.TELL("The chalice is now safe to take.", ZG._TK.CR) end
                    break
                elseif (not ZG.EQUAL_p(X, ZG.CHALICE, ZG.THIEF, ZG.ADVENTURER)) then
                    do local _ = ZG.FCLEAR(X, "INVISIBLE") end
                    if (not ZG._T(FLG)) then
                        FLG = true
                        do local _ = ZG.TELL("As the thief dies, the power of his magic decreases, and his\ntreasures reappear:", ZG._TK.CR) end
                    end
                    do local _ = ZG.TELL("  A ", ZG._TK.D, X) end
                    if (ZG._T(ZG.FIRST_p(X)) and ZG._T(ZG.SEE_INSIDE_p(X))) then
                        do local _ = ZG.TELL(", with ") end
                        do local _ = ZG.PRINT_CONTENTS(X) end
                    end
                    do local _ = ZG.CRLF() end
                end
                X = ZG.NEXT_p(X)
            end
        elseif ZG._T(X) then
            do local _ = ZG.TELL("His booty remains.", ZG._TK.CR) end
        end
        do return ZG.DISABLE(ZG.INT(ZG.I_THIEF)) end
    elseif ZG.EQ(MODE, ZG.F_FIRST_p) then
        if (ZG._T(ZG.THIEF_HERE) and (not ZG._T(ZG.FSET_p(ZG.THIEF, "INVISIBLE"))) and ZG._T(ZG.PROB_1(20))) then
            do local _ = ZG.FSET(ZG.THIEF, "FIGHTBIT") end
            ZG._set("P_CONT", false)
            do return true end
        else
            do return false end
        end
    elseif ZG.EQ(MODE, ZG.F_UNCONSCIOUS) then
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_THIEF)) end
        do local _ = ZG.FCLEAR(ZG.THIEF, "FIGHTBIT") end
        do local _ = ZG.MOVE(ZG.STILETTO, ZG.HERE) end
        do local _ = ZG.FCLEAR(ZG.STILETTO, "NDESCBIT") end
        do return ZG.PUTP(ZG.THIEF, "LDESC", ZG.ROBBER_U_DESC) end
    elseif ZG.EQ(MODE, ZG.F_CONSCIOUS) then
        if ZG.EQ(ZG.LOC(ZG.THIEF), ZG.HERE) then
            do local _ = ZG.FSET(ZG.THIEF, "FIGHTBIT") end
            do local _ = ZG.TELL("The robber revives, briefly feigning continued unconsciousness, and,\nwhen he sees his moment, scrambles away from you.", ZG._TK.CR) end
        end
        do local _ = ZG.ENABLE(ZG.INT(ZG.I_THIEF)) end
        do local _ = ZG.PUTP(ZG.THIEF, "LDESC", ZG.ROBBER_C_DESC) end
        do return ZG.RECOVER_STILETTO() end
    else
        do return false end
    end

end, "ROBBER-FUNCTION")

ZG.ROBBER_FUNCTION = ZG.actions:get("ROBBER_FUNCTION")

-- zil: 1actions.zil:2086  <GLOBAL ROBBER-C-DESC>
-- ROBBER_C_DESC is declared in ZilGlobal.lua

-- zil: 1actions.zil:2090  <GLOBAL ROBBER-U-DESC>
-- ROBBER_U_DESC is declared in ZilGlobal.lua

-- zil: 1actions.zil:2094  <ROUTINE LARGE-BAG-F ()>
ZG.actions:register("LARGE_BAG_F", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        if ZG.EQ(ZG.GETP(ZG.THIEF, "LDESC"), ZG.ROBBER_U_DESC) then
            do return ZG.TELL("Sadly for you, the robber collapsed on top of the bag. Trying to take\nit would wake him.", ZG._TK.CR) end
        else
            do return ZG.TELL("The bag will be taken over his dead body.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.LARGE_BAG)) then
        do return ZG.TELL("It would be a good trick.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("Getting close enough would be a good trick.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE", "LOOK-INSIDE")) then
        do return ZG.TELL("The bag is underneath the thief, so one can't say what, if anything, is\ninside.", ZG._TK.CR) end
    else
        do return false end
    end

end, "LARGE-BAG-F")

ZG.LARGE_BAG_F = ZG.actions:get("LARGE_BAG_F")

-- zil: 1actions.zil:2114  <ROUTINE MOVE-ALL (FROM TO "AUX" X N)>
ZG.actions:register("MOVE_ALL", function(FROM, TO)

    local X = 0
    local N = 0
    if ZG._T((function() X = ZG.FIRST_p(FROM); return X end)()) then
        while true do
            if (not ZG._T(X)) then
                do return true end
            end
            N = ZG.NEXT_p(X)
            do local _ = ZG.FCLEAR(X, "INVISIBLE") end
            do local _ = ZG.MOVE(X, TO) end
            X = N
        end
    else
        do return false end
    end

end, "MOVE-ALL")

ZG.MOVE_ALL = ZG.actions:get("MOVE_ALL")

-- zil: 1actions.zil:2123  <ROUTINE CHALICE-FCN ()>
ZG.actions:register("CHALICE_FCN", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        if (ZG._T(ZG.IN_p(ZG.PRSO, ZG.TREASURE_ROOM)) and ZG._T(ZG.IN_p(ZG.THIEF, ZG.TREASURE_ROOM)) and ZG._T(ZG.FSET_p(ZG.THIEF, "FIGHTBIT")) and (not ZG._T(ZG.FSET_p(ZG.THIEF, "INVISIBLE"))) and (not ZG.EQ(ZG.GETP(ZG.THIEF, "LDESC"), ZG.ROBBER_U_DESC))) then
            do return ZG.TELL("You'd be stabbed in the back first.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, ZG.CHALICE)) then
        do return ZG.TELL("You can't. It's not a very good chalice, is it?", ZG._TK.CR) end
    else
        do return ZG.DUMB_CONTAINER() end
    end

end, "CHALICE-FCN")

ZG.CHALICE_FCN = ZG.actions:get("CHALICE_FCN")

-- zil: 1actions.zil:2138  <ROUTINE TREASURE-ROOM-FCN (RARG "AUX" TL)>
ZG.actions:register("TREASURE_ROOM_FCN", function(RARG)

    local TL = 0
    if (ZG.EQ(RARG, ZG.M_ENTER) and (ZG.GET(ZG.INT(ZG.I_THIEF), ZG.C_ENABLED_p) == 1) and (not ZG._T(ZG.DEAD))) then
        if (not ZG._T(ZG.IN_p(ZG.THIEF, ZG.HERE))) then
            do local _ = ZG.TELL("You hear a scream of anguish as you violate the robber's hideaway.\nUsing passages unknown to you, he rushes to its defense.", ZG._TK.CR) end
            do local _ = ZG.MOVE(ZG.THIEF, ZG.HERE) end
        end
        do local _ = ZG.FSET(ZG.THIEF, "FIGHTBIT") end
        do local _ = ZG.FCLEAR(ZG.THIEF, "INVISIBLE") end
        do return ZG.THIEF_IN_TREASURE() end
    else
        do return false end
    end

end, "TREASURE-ROOM-FCN")

ZG.TREASURE_ROOM_FCN = ZG.actions:get("TREASURE_ROOM_FCN")

-- zil: 1actions.zil:2151  <ROUTINE THIEF-IN-TREASURE ("AUX" F N)>
ZG.actions:register("THIEF_IN_TREASURE", function()

    local F = 0
    local N = 0
    F = ZG.FIRST_p(ZG.HERE)
    if (ZG._T(F) and ZG._T(ZG.NEXT_p(F))) then
        do local _ = ZG.TELL("The thief gestures mysteriously, and the treasures in the room\nsuddenly vanish.", ZG._TK.CR, ZG._TK.CR) end
    end
    while true do
        if (not ZG._T(F)) then
            do return true end
        elseif (not ZG.EQUAL_p(F, ZG.CHALICE, ZG.THIEF)) then
            do local _ = ZG.FSET(F, "INVISIBLE") end
        end
        F = ZG.NEXT_p(F)
    end

end, "THIEF-IN-TREASURE")

ZG.THIEF_IN_TREASURE = ZG.actions:get("THIEF_IN_TREASURE")

-- zil: 1actions.zil:2163  <ROUTINE FRONT-DOOR-FCN ()>
ZG.actions:register("FRONT_DOOR_FCN", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The door cannot be opened.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do return ZG.TELL("You cannot burn this door.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("You can't seem to damage the door.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-BEHIND")) then
        do return ZG.TELL("It won't open.", ZG._TK.CR) end
    else
        do return false end
    end

end, "FRONT-DOOR-FCN")

ZG.FRONT_DOOR_FCN = ZG.actions:get("FRONT_DOOR_FCN")

-- zil: 1actions.zil:2178  <ROUTINE BODY-FUNCTION ()>
ZG.actions:register("BODY_FUNCTION", function()

    if ZG._T(ZG.VERB_p("TAKE")) then
        do return ZG.TELL("A force keeps you from taking the bodies.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("MUNG", "BURN")) then
        do return ZG.JIGS_UP("The voice of the guardian of the dungeon booms out from the darkness,\n\"Your disrespect costs you your life!\" and places your head on a sharp\npole.") end
    else
        do return false end
    end

end, "BODY-FUNCTION")

ZG.BODY_FUNCTION = ZG.actions:get("BODY_FUNCTION")

-- zil: 1actions.zil:2187  <ROUTINE BLACK-BOOK ()>
ZG.actions:register("BLACK_BOOK", function()

    if ZG._T(ZG.VERB_p("OPEN")) then
        do return ZG.TELL("The book is already open to page 569.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        do return ZG.TELL("As hard as you try, the book cannot be closed.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("TURN")) or (ZG._T(ZG.VERB_p("READ-PAGE")) and ZG.EQ(ZG.PRSI, ZG.INTNUM) and (not ZG.EQ(ZG.P_NUMBER, 569)))) then
        do return ZG.TELL("Beside page 569, there is only one other page with any legible printing on\nit. Most of it is unreadable, but the subject seems to be the banishment of\nevil. Apparently, certain noises, lights, and prayers are efficacious in this\nregard.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("BURN")) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        do return ZG.JIGS_UP("A booming voice says \"Wrong, cretin!\" and you notice that you have\nturned into a pile of dust. How, I can't imagine.") end
    else
        do return false end
    end

end, "BLACK-BOOK")

ZG.BLACK_BOOK = ZG.actions:get("BLACK_BOOK")

-- zil: 1actions.zil:2207  <ROUTINE PAINTING-FCN ()>
ZG.actions:register("PAINTING_FCN", function()

    if ZG._T(ZG.VERB_p("MUNG")) then
        do local _ = ZG.PUTP(ZG.PRSO, "TVALUE", 0) end
        do local _ = ZG.PUTP(ZG.PRSO, "LDESC", "There is a worthless piece of canvas here.") end
        do return ZG.TELL("Congratulations! Unlike the other vandals, who merely stole the\nartist's masterpieces, you have destroyed one.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PAINTING-FCN")

ZG.PAINTING_FCN = ZG.actions:get("PAINTING_FCN")

-- zil: 1actions.zil:2220  <GLOBAL LAMP-TABLE>
-- LAMP_TABLE is declared in ZilGlobal.lua

-- zil: 1actions.zil:2230  <ROUTINE LANTERN ()>
ZG.actions:register("LANTERN", function()

    if ZG._T(ZG.VERB_p("THROW")) then
        do local _ = ZG.TELL("The lamp has smashed into the floor, and the light has gone out.", ZG._TK.CR) end
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_LANTERN)) end
        do local _ = ZG.REMOVE_CAREFULLY(ZG.LAMP) end
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
        do local _ = ZG.TELL("The lamp ") end
        if ZG._T(ZG.FSET_p(ZG.LAMP, "RMUNGBIT")) then
            do local _ = ZG.TELL("has burned out.") end
        elseif ZG._T(ZG.FSET_p(ZG.LAMP, "ONBIT")) then
            do local _ = ZG.TELL("is on.") end
        else
            do local _ = ZG.TELL("is turned off.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "LANTERN")

ZG.LANTERN = ZG.actions:get("LANTERN")

-- zil: 1actions.zil:2259  <ROUTINE MAILBOX-F ()>
ZG.actions:register("MAILBOX_F", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.PRSO, ZG.MAILBOX)) then
        do return ZG.TELL("It is securely anchored.", ZG._TK.CR) end
    else
        do return false end
    end

end, "MAILBOX-F")

ZG.MAILBOX_F = ZG.actions:get("MAILBOX_F")

-- zil: 1actions.zil:2263  <GLOBAL MATCH-COUNT>
-- MATCH_COUNT is declared in ZilGlobal.lua

-- zil: 1actions.zil:2265  <ROUTINE MATCH-FUNCTION ("AUX" CNT)>
ZG.actions:register("MATCH_FUNCTION", function()

    local CNT = 0
    if (ZG._T(ZG.VERB_p("LAMP-ON", "BURN")) and ZG.EQ(ZG.PRSO, ZG.MATCH)) then
        if ZG.LT(0, ZG.MATCH_COUNT) then
            ZG._set("MATCH_COUNT", ZG.SUB(ZG.MATCH_COUNT, 1))
        end
        if (not ZG.LT(0, ZG.MATCH_COUNT)) then
            do return ZG.TELL("I'm afraid that you have run out of matches.", ZG._TK.CR) end
        elseif ZG.EQUAL_p(ZG.HERE, ZG.LOWER_SHAFT, ZG.TIMBER_ROOM) then
            do return ZG.TELL("This room is drafty, and the match goes out instantly.", ZG._TK.CR) end
        else
            do local _ = ZG.FSET(ZG.MATCH, "FLAMEBIT") end
            do local _ = ZG.FSET(ZG.MATCH, "ONBIT") end
            do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_MATCH, 2)) end
            do local _ = ZG.TELL("One of the matches starts to burn.", ZG._TK.CR) end
            if (not ZG._T(ZG.LIT)) then
                ZG._set("LIT", true)
                do local _ = ZG.V_LOOK() end
            end
            do return true end
        end
    elseif (ZG._T(ZG.VERB_p("LAMP-OFF")) and ZG._T(ZG.FSET_p(ZG.MATCH, "FLAMEBIT"))) then
        do local _ = ZG.TELL("The match is out.", ZG._TK.CR) end
        do local _ = ZG.FCLEAR(ZG.MATCH, "FLAMEBIT") end
        do local _ = ZG.FCLEAR(ZG.MATCH, "ONBIT") end
        ZG._set("LIT", ZG.LIT_p(ZG.HERE))
        if (not ZG._T(ZG.LIT)) then
            do local _ = ZG.TELL("It's pitch black in here!", ZG._TK.CR) end
        end
        do local _ = ZG.QUEUE(ZG.I_MATCH, 0) end
        do return true end
    elseif ZG._T(ZG.VERB_p("COUNT", "OPEN")) then
        do local _ = ZG.TELL("You have ") end
        CNT = ZG.SUB(ZG.MATCH_COUNT, 1)
        if (not ZG.LT(0, CNT)) then
            do local _ = ZG.TELL("no") end
        else
            do local _ = ZG.TELL(ZG._TK.N, CNT) end
        end
        do local _ = ZG.TELL(" match") end
        if (not (CNT == 1)) then
            do local _ = ZG.TELL("es.") end
        else
            do local _ = ZG.TELL(".") end
        end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG._T(ZG.FSET_p(ZG.MATCH, "ONBIT")) then
            do local _ = ZG.TELL("The match is burning.") end
        else
            do local _ = ZG.TELL("The matchbook isn't very interesting, except for what's written on it.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "MATCH-FUNCTION")

ZG.MATCH_FUNCTION = ZG.actions:get("MATCH_FUNCTION")

-- zil: 1actions.zil:2308  <ROUTINE I-MATCH ()>
ZG.actions:register("I_MATCH", function()

    do local _ = ZG.TELL("The match has gone out.", ZG._TK.CR) end
    do local _ = ZG.FCLEAR(ZG.MATCH, "FLAMEBIT") end
    do local _ = ZG.FCLEAR(ZG.MATCH, "ONBIT") end
    ZG._set("LIT", ZG.LIT_p(ZG.HERE))
    do return true end

end, "I-MATCH")

ZG.I_MATCH = ZG.actions:get("I_MATCH")

-- zil: 1actions.zil:2315  <ROUTINE I-LANTERN ("AUX" TICK (TBL <VALUE LAMP-TABLE>))>
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

-- zil: 1actions.zil:2321  <ROUTINE I-CANDLES ("AUX" TICK (TBL <VALUE CANDLE-TABLE>))>
ZG.actions:register("I_CANDLES", function()

    local TICK = 0
    local TBL = ZG.VALUE(ZG.CANDLE_TABLE)
    do local _ = ZG.FSET(ZG.CANDLES, "TOUCHBIT") end
    do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CANDLES, (function() TICK = ZG.GET(TBL, 0); return TICK end)())) end
    do local _ = ZG.LIGHT_INT(ZG.CANDLES, TBL, TICK) end
    if (not ZG.ZERO_p(TICK)) then
        ZG._set("CANDLE_TABLE", ZG.REST(TBL, 4))
        do return ZG.CANDLE_TABLE end
    else
        do return false end
    end

end, "I-CANDLES")

ZG.I_CANDLES = ZG.actions:get("I_CANDLES")

-- zil: 1actions.zil:2328  <ROUTINE LIGHT-INT (OBJ TBL TICK)>
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

-- zil: 1actions.zil:2339  <ROUTINE MIN (N1 N2)>
ZG.actions:register("MIN", function(N1, N2)

    if ZG.LT(N1, N2) then
        do return N1 end
    else
        do return N2 end
    end

end, "MIN")

ZG.MIN = ZG.actions:get("MIN")

-- zil: 1actions.zil:2343  <ROUTINE CANDLES-FCN ()>
ZG.actions:register("CANDLES_FCN", function()

    if (not ZG._T(ZG.FSET_p(ZG.CANDLES, "TOUCHBIT"))) then
        do local _ = ZG.ENABLE(ZG.INT(ZG.I_CANDLES)) end
    end
    if ZG.EQ(ZG.CANDLES, ZG.PRSI) then
        do return false end
    else
        if ZG._T(ZG.VERB_p("LAMP-ON", "BURN")) then
            if ZG._T(ZG.FSET_p(ZG.CANDLES, "RMUNGBIT")) then
                do return ZG.TELL("Alas, there's not much left of the candles. Certainly not enough to\nburn.", ZG._TK.CR) end
            elseif (not ZG._T(ZG.PRSI)) then
                if ZG._T(ZG.FSET_p(ZG.MATCH, "FLAMEBIT")) then
                    do local _ = ZG.TELL("(with the match)", ZG._TK.CR) end
                    do local _ = ZG.PERFORM(ZG.SYMBOL("V?LAMP-ON"), ZG.CANDLES, ZG.MATCH) end
                    do return true end
                else
                    do local _ = ZG.TELL("You should say what to light them with.", ZG._TK.CR) end
                    do return 2 end
                end
            elseif (ZG.EQ(ZG.PRSI, ZG.MATCH) and ZG._T(ZG.FSET_p(ZG.MATCH, "ONBIT"))) then
                do local _ = ZG.TELL("The candles are ") end
                if ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT")) then
                    do return ZG.TELL("already lit.", ZG._TK.CR) end
                else
                    do local _ = ZG.FSET(ZG.CANDLES, "ONBIT") end
                    do local _ = ZG.TELL("lit.", ZG._TK.CR) end
                    do return ZG.ENABLE(ZG.INT(ZG.I_CANDLES)) end
                end
            elseif ZG.EQ(ZG.PRSI, ZG.TORCH) then
                if ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT")) then
                    do return ZG.TELL("You realize, just in time, that the candles are already lighted.", ZG._TK.CR) end
                else
                    do local _ = ZG.TELL("The heat from the torch is so intense that the candles are vaporized.", ZG._TK.CR) end
                    do return ZG.REMOVE_CAREFULLY(ZG.CANDLES) end
                end
            else
                do return ZG.TELL("You have to light them with something that's burning, you know.", ZG._TK.CR) end
            end
        elseif ZG._T(ZG.VERB_p("COUNT")) then
            do return ZG.TELL("Let's see, how many objects in a pair? Don't tell me, I'll get it.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("LAMP-OFF")) then
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_CANDLES)) end
            if ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT")) then
                do local _ = ZG.TELL("The flame is extinguished.") end
                do local _ = ZG.FCLEAR(ZG.CANDLES, "ONBIT") end
                do local _ = ZG.FSET(ZG.CANDLES, "TOUCHBIT") end
                ZG._set("LIT", ZG.LIT_p(ZG.HERE))
                if (not ZG._T(ZG.LIT)) then
                    do local _ = ZG.TELL(" It's really dark in here....") end
                end
                do local _ = ZG.CRLF() end
                do return true end
            else
                do return ZG.TELL("The candles are not lighted.", ZG._TK.CR) end
            end
        elseif (ZG._T(ZG.VERB_p("PUT")) and ZG._T(ZG.FSET_p(ZG.PRSI, "BURNBIT"))) then
            do return ZG.TELL("That wouldn't be smart.", ZG._TK.CR) end
        elseif ZG._T(ZG.VERB_p("EXAMINE")) then
            do local _ = ZG.TELL("The candles are ") end
            if ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT")) then
                do local _ = ZG.TELL("burning.") end
            else
                do local _ = ZG.TELL("out.") end
            end
            do return ZG.CRLF() end
        else
            do return false end
        end
    end

end, "CANDLES-FCN")

ZG.CANDLES_FCN = ZG.actions:get("CANDLES_FCN")

-- zil: 1actions.zil:2406  <GLOBAL CANDLE-TABLE>
-- CANDLE_TABLE is declared in ZilGlobal.lua

-- zil: 1actions.zil:2416  <ROUTINE CAVE2-ROOM (RARG)>
ZG.actions:register("CAVE2_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_END) then
        if (ZG._T(ZG.IN_p(ZG.CANDLES, ZG.WINNER)) and ZG._T(ZG.PROB_2(50, 80)) and ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT"))) then
            do local _ = ZG.DISABLE(ZG.INT(ZG.I_CANDLES)) end
            do local _ = ZG.FCLEAR(ZG.CANDLES, "ONBIT") end
            do local _ = ZG.TELL("A gust of wind blows out your candles!", ZG._TK.CR) end
            if (not ZG._T(ZG._set("LIT", ZG.LIT_p(ZG.HERE)))) then
                do return ZG.TELL("It is now completely dark.", ZG._TK.CR) end
            else
                do return false end
            end
        else
            do return false end
        end
    else
        do return false end
    end

end, "CAVE2-ROOM")

ZG.CAVE2_ROOM = ZG.actions:get("CAVE2_ROOM")

-- zil: 1actions.zil:2432  <ROUTINE SWORD-FCN ("AUX" G)>
ZG.actions:register("SWORD_FCN", function()

    local G = 0
    if (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_SWORD, -1)) end
        do return false end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        if ZG.EQ((function() G = ZG.GETP(ZG.SWORD, "TVALUE"); return G end)(), 1) then
            do return ZG.TELL("Your sword is glowing with a faint blue glow.", ZG._TK.CR) end
        elseif ZG.EQ(G, 2) then
            do return ZG.TELL("Your sword is glowing very brightly.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "SWORD-FCN")

ZG.SWORD_FCN = ZG.actions:get("SWORD_FCN")

-- zil: 1actions.zil:2446  <ROUTINE BOOM-ROOM (RARG "AUX" (DUMMY? <>) FLAME)>
ZG.actions:register("BOOM_ROOM", function(RARG)

    local DUMMY_p = false
    local FLAME = 0
    if ZG.EQ(RARG, ZG.M_END) then
        if (ZG.EQ(RARG, ZG.M_END) and ZG._T(ZG.VERB_p("LAMP-ON", "BURN")) and ZG.EQUAL_p(ZG.PRSO, ZG.CANDLES, ZG.TORCH, ZG.MATCH)) then
            DUMMY_p = true
        end
        if ((ZG._T(ZG.HELD_p(ZG.CANDLES)) and ZG._T(ZG.FSET_p(ZG.CANDLES, "ONBIT"))) or (ZG._T(ZG.HELD_p(ZG.TORCH)) and ZG._T(ZG.FSET_p(ZG.TORCH, "ONBIT"))) or (ZG._T(ZG.HELD_p(ZG.MATCH)) and ZG._T(ZG.FSET_p(ZG.MATCH, "ONBIT")))) then
            if ZG._T(DUMMY_p) then
                do local _ = ZG.TELL("How sad for an aspiring adventurer to light a ", ZG._TK.D, ZG.PRSO, " in a room which\nreeks of gas. Fortunately, there is justice in the world.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("Oh dear. It appears that the smell coming from this room was coal gas.\nI would have thought twice about carrying flaming objects in here.", ZG._TK.CR) end
            end
            do return ZG.JIGS_UP("\n      ** BOOOOOOOOOOOM **") end
        else
            do return false end
        end
    else
        do return false end
    end

end, "BOOM-ROOM")

ZG.BOOM_ROOM = ZG.actions:get("BOOM_ROOM")

-- zil: 1actions.zil:2469  <ROUTINE BAT-D ("OPTIONAL" FOO)>
ZG.actions:register("BAT_D", function(FOO)

    if ZG.EQUAL_p(ZG.LOC(ZG.GARLIC), ZG.WINNER, ZG.HERE) then
        do return ZG.TELL("In the corner of the room on the ceiling is a large vampire bat who\nis obviously deranged and holding his nose.", ZG._TK.CR) end
    else
        do return ZG.TELL("A large vampire bat, hanging from the ceiling, swoops down at you!", ZG._TK.CR) end
    end

end, "BAT-D")

ZG.BAT_D = ZG.actions:get("BAT_D")

-- zil: 1actions.zil:2478  <ROUTINE BATS-ROOM (RARG)>
ZG.actions:register("BATS_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do return ZG.TELL("You are in a small room which has doors only to the east and south.", ZG._TK.CR) end
    elseif (ZG.EQ(RARG, ZG.M_ENTER) and (not ZG._T(ZG.DEAD))) then
        if (not ZG.EQUAL_p(ZG.LOC(ZG.GARLIC), ZG.WINNER, ZG.HERE)) then
            do local _ = ZG.V_LOOK() end
            do local _ = ZG.CRLF() end
            do return ZG.FLY_ME() end
        else
            do return false end
        end
    else
        do return false end
    end

end, "BATS-ROOM")

ZG.BATS_ROOM = ZG.actions:get("BATS_ROOM")

-- zil: 1actions.zil:2488  <ROUTINE MACHINE-ROOM-FCN (RARG)>
ZG.actions:register("MACHINE_ROOM_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("This is a large, cold room whose sole exit is to the north. In one\ncorner there is a machine which is reminiscent of a clothes\ndryer. On its face is a switch which is labelled \"START\".\nThe switch does not appear to be manipulable by any human hand (unless the\nfingers are about 1/16 by 1/4 inch). On the front of the machine is a large\nlid, which is ") end
        if ZG._T(ZG.FSET_p(ZG.MACHINE, "OPENBIT")) then
            do local _ = ZG.TELL("open.") end
        else
            do local _ = ZG.TELL("closed.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "MACHINE-ROOM-FCN")

ZG.MACHINE_ROOM_FCN = ZG.actions:get("MACHINE_ROOM_FCN")

-- zil: 1actions.zil:2502  <ROUTINE MACHINE-F ()>
ZG.actions:register("MACHINE_F", function()

    if (ZG._T(ZG.VERB_p("TAKE")) and ZG.EQ(ZG.PRSO, ZG.MACHINE)) then
        do return ZG.TELL("It is far too large to carry.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN")) then
        if ZG._T(ZG.FSET_p(ZG.MACHINE, "OPENBIT")) then
            do return ZG.TELL(ZG.PICK_ONE(ZG.DUMMY), ZG._TK.CR) end
        elseif ZG._T(ZG.FIRST_p(ZG.MACHINE)) then
            do local _ = ZG.TELL("The lid opens, revealing ") end
            do local _ = ZG.PRINT_CONTENTS(ZG.MACHINE) end
            do local _ = ZG.TELL(".", ZG._TK.CR) end
            do return ZG.FSET(ZG.MACHINE, "OPENBIT") end
        else
            do local _ = ZG.TELL("The lid opens.", ZG._TK.CR) end
            do return ZG.FSET(ZG.MACHINE, "OPENBIT") end
        end
    elseif ZG._T(ZG.VERB_p("CLOSE")) then
        if ZG._T(ZG.FSET_p(ZG.MACHINE, "OPENBIT")) then
            do local _ = ZG.TELL("The lid closes.", ZG._TK.CR) end
            do local _ = ZG.FCLEAR(ZG.MACHINE, "OPENBIT") end
            do return true end
        else
            do return ZG.TELL(ZG.PICK_ONE(ZG.DUMMY), ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LAMP-ON")) then
        if (not ZG._T(ZG.PRSI)) then
            do return ZG.TELL("It's not clear how to turn it on with your bare hands.", ZG._TK.CR) end
        else
            do local _ = ZG.PERFORM(ZG.SYMBOL("V?TURN"), ZG.MACHINE_SWITCH, ZG.PRSI) end
            do return true end
        end
    else
        do return false end
    end

end, "MACHINE-F")

ZG.MACHINE_F = ZG.actions:get("MACHINE_F")

-- zil: 1actions.zil:2531  <ROUTINE MSWITCH-FUNCTION ("AUX" O)>
ZG.actions:register("MSWITCH_FUNCTION", function()

    local O = 0
    if ZG._T(ZG.VERB_p("TURN")) then
        if ZG.EQ(ZG.PRSI, ZG.SCREWDRIVER) then
            if ZG._T(ZG.FSET_p(ZG.MACHINE, "OPENBIT")) then
                do return ZG.TELL("The machine doesn't seem to want to do anything.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The machine comes to life (figuratively) with a dazzling display of\ncolored lights and bizarre noises. After a few moments, the\nexcitement abates.", ZG._TK.CR) end
                if ZG._T(ZG.IN_p(ZG.COAL, ZG.MACHINE)) then
                    do local _ = ZG.REMOVE_CAREFULLY(ZG.COAL) end
                    do return ZG.MOVE(ZG.DIAMOND, ZG.MACHINE) end
                else
                    while true do
                        if ZG._T((function() O = ZG.FIRST_p(ZG.MACHINE); return O end)()) then
                            do local _ = ZG.REMOVE_CAREFULLY(O) end
                        else
                            break
                        end
                    end
                    do return ZG.MOVE(ZG.GUNK, ZG.MACHINE) end
                end
            end
        else
            do return ZG.TELL("It seems that a ", ZG._TK.D, ZG.PRSI, " won't do.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "MSWITCH-FUNCTION")

ZG.MSWITCH_FUNCTION = ZG.actions:get("MSWITCH_FUNCTION")

-- zil: 1actions.zil:2553  <ROUTINE GUNK-FUNCTION ()>
ZG.actions:register("GUNK_FUNCTION", function()

    do local _ = ZG.REMOVE_CAREFULLY(ZG.GUNK) end
    do return ZG.TELL("The slag was rather insubstantial, and crumbles into dust at your touch.", ZG._TK.CR) end

end, "GUNK-FUNCTION")

ZG.GUNK_FUNCTION = ZG.actions:get("GUNK_FUNCTION")

-- zil: 1actions.zil:2558  <ROUTINE NO-OBJS (RARG "AUX" F)>
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
        if (ZG.EQ(ZG.HERE, ZG.LOWER_SHAFT) and ZG._T(ZG.LIT)) then
            do local _ = ZG.SCORE_UPD(ZG.LIGHT_SHAFT) end
            ZG._set("LIGHT_SHAFT", 0)
        end
        do return false end
    else
        do return false end
    end

end, "NO-OBJS")

ZG.NO_OBJS = ZG.actions:get("NO_OBJS")

-- zil: 1actions.zil:2573  <ROUTINE SOUTH-TEMPLE-FCN (RARG)>
ZG.actions:register("SOUTH_TEMPLE_FCN", function(RARG)

    if ZG.EQ(RARG, ZG.M_BEG) then
        ZG._set("COFFIN_CURE", (not ZG._T(ZG.IN_p(ZG.COFFIN, ZG.WINNER))))
        do return false end
    else
        do return false end
    end

end, "SOUTH-TEMPLE-FCN")

ZG.SOUTH_TEMPLE_FCN = ZG.actions:get("SOUTH_TEMPLE_FCN")

-- zil: 1actions.zil:2578  <GLOBAL LIGHT-SHAFT>
-- LIGHT_SHAFT is declared in ZilGlobal.lua

-- GDECL _arg

-- zil: 1actions.zil:2585  <ROUTINE WHITE-CLIFFS-FUNCTION (RARG)>
ZG.actions:register("WHITE_CLIFFS_FUNCTION", function(RARG)

    if ZG.EQ(RARG, ZG.M_END) then
        if ZG._T(ZG.IN_p(ZG.INFLATED_BOAT, ZG.WINNER)) then
            ZG._set("DEFLATE", false)
            do return ZG.DEFLATE end
        else
            ZG._set("DEFLATE", true)
            do return ZG.DEFLATE end
        end
    else
        do return false end
    end

end, "WHITE-CLIFFS-FUNCTION")

ZG.WHITE_CLIFFS_FUNCTION = ZG.actions:get("WHITE_CLIFFS_FUNCTION")

-- zil: 1actions.zil:2592  <ROUTINE SCEPTRE-FUNCTION ()>
ZG.actions:register("SCEPTRE_FUNCTION", function()

    if ZG._T(ZG.VERB_p("WAVE", "RAISE")) then
        if (ZG.EQ(ZG.HERE, ZG.ARAGAIN_FALLS) or ZG.EQ(ZG.HERE, ZG.END_OF_RAINBOW)) then
            if (not ZG._T(ZG.RAINBOW_FLAG)) then
                do local _ = ZG.FCLEAR(ZG.POT_OF_GOLD, "INVISIBLE") end
                do local _ = ZG.TELL("Suddenly, the rainbow appears to become solid and, I venture,\nwalkable (I think the giveaway was the stairs and bannister).", ZG._TK.CR) end
                if (ZG.EQ(ZG.HERE, ZG.END_OF_RAINBOW) and ZG._T(ZG.IN_p(ZG.POT_OF_GOLD, ZG.END_OF_RAINBOW))) then
                    do local _ = ZG.TELL("A shimmering pot of gold appears at the end of the rainbow.", ZG._TK.CR) end
                end
                ZG._set("RAINBOW_FLAG", true)
                do return ZG.RAINBOW_FLAG end
            else
                do local _ = ZG.ROB(ZG.ON_RAINBOW, ZG.WALL) end
                do local _ = ZG.TELL("The rainbow seems to have become somewhat run-of-the-mill.", ZG._TK.CR) end
                ZG._set("RAINBOW_FLAG", false)
                do return true end
            end
        elseif ZG.EQ(ZG.HERE, ZG.ON_RAINBOW) then
            ZG._set("RAINBOW_FLAG", false)
            do return ZG.JIGS_UP("The structural integrity of the rainbow is severely compromised,\nleaving you hanging in midair, supported only by water vapor. Bye.") end
        else
            do return ZG.TELL("A dazzling display of color briefly emanates from the sceptre.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SCEPTRE-FUNCTION")

ZG.SCEPTRE_FUNCTION = ZG.actions:get("SCEPTRE_FUNCTION")

-- zil: 1actions.zil:2621  <ROUTINE FALLS-ROOM (RARG)>
ZG.actions:register("FALLS_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are at the top of Aragain Falls, an enormous waterfall with a\ndrop of about 450 feet. The only path here is on the north end.", ZG._TK.CR) end
        if ZG._T(ZG.RAINBOW_FLAG) then
            do local _ = ZG.TELL("A solid rainbow spans the falls.") end
        else
            do local _ = ZG.TELL("A beautiful rainbow can be seen over the falls and to the west.") end
        end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "FALLS-ROOM")

ZG.FALLS_ROOM = ZG.actions:get("FALLS_ROOM")

-- zil: 1actions.zil:2634  <ROUTINE RAINBOW-FCN ()>
ZG.actions:register("RAINBOW_FCN", function()

    if ZG._T(ZG.VERB_p("CROSS", "THROUGH")) then
        if ZG.EQ(ZG.HERE, ZG.CANYON_VIEW) then
            do local _ = ZG.TELL("From here?!?", ZG._TK.CR) end
            do return true end
        end
        if ZG._T(ZG.RAINBOW_FLAG) then
            if ZG.EQ(ZG.HERE, ZG.ARAGAIN_FALLS) then
                do return ZG.GOTO(ZG.END_OF_RAINBOW) end
            elseif ZG.EQ(ZG.HERE, ZG.END_OF_RAINBOW) then
                do return ZG.GOTO(ZG.ARAGAIN_FALLS) end
            else
                do return ZG.TELL("You'll have to say which way...", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("Can you walk on water vapor?", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("LOOK-UNDER")) then
        do return ZG.TELL("The Frigid River flows under the rainbow.", ZG._TK.CR) end
    else
        do return false end
    end

end, "RAINBOW-FCN")

ZG.RAINBOW_FCN = ZG.actions:get("RAINBOW_FCN")

-- zil: 1actions.zil:2652  <ROUTINE DBOAT-FUNCTION ("AUX")>
ZG.actions:register("DBOAT_FUNCTION", function()

    if (ZG._T(ZG.VERB_p("PUT", "PUT-ON")) and ZG.EQ(ZG.PRSO, ZG.PUTTY)) then
        do return ZG.FIX_BOAT() end
    elseif ZG._T(ZG.VERB_p("INFLATE", "FILL")) then
        do return ZG.TELL("No chance. Some moron punctured it.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("PLUG")) then
        if ZG.EQ(ZG.PRSI, ZG.PUTTY) then
            do return ZG.FIX_BOAT() end
        else
            do return ZG.WITH_TELL(ZG.PRSI) end
        end
    else
        do return false end
    end

end, "DBOAT-FUNCTION")

ZG.DBOAT_FUNCTION = ZG.actions:get("DBOAT_FUNCTION")

-- zil: 1actions.zil:2664  <ROUTINE FIX-BOAT ()>
ZG.actions:register("FIX_BOAT", function()

    do local _ = ZG.TELL("Well done. The boat is repaired.", ZG._TK.CR) end
    do local _ = ZG.MOVE(ZG.INFLATABLE_BOAT, ZG.LOC(ZG.PUNCTURED_BOAT)) end
    do return ZG.REMOVE_CAREFULLY(ZG.PUNCTURED_BOAT) end

end, "FIX-BOAT")

ZG.FIX_BOAT = ZG.actions:get("FIX_BOAT")

-- zil: 1actions.zil:2669  <ROUTINE RIVER-FUNCTION ()>
ZG.actions:register("RIVER_FUNCTION", function()

    if ZG._T(ZG.VERB_p("PUT")) then
        if ZG.EQ(ZG.PRSI, ZG.RIVER) then
            if ZG.EQ(ZG.PRSO, ZG.ME) then
                do return ZG.JIGS_UP("You splash around for a while, fighting the current, then you drown.") end
            elseif ZG.EQ(ZG.PRSO, ZG.INFLATED_BOAT) then
                do return ZG.TELL("You should get in the boat then launch it.", ZG._TK.CR) end
            elseif ZG._T(ZG.FSET_p(ZG.PRSO, "BURNBIT")) then
                do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " floats for a moment, then sinks.", ZG._TK.CR) end
            else
                do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " splashes into the water and is gone forever.", ZG._TK.CR) end
            end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("LEAP", "THROUGH")) then
        do return ZG.TELL("A look before leaping reveals that the river is wide and dangerous,\nwith swift currents and large, half-hidden rocks. You decide to forgo your\nswim.", ZG._TK.CR) end
    else
        do return false end
    end

end, "RIVER-FUNCTION")

ZG.RIVER_FUNCTION = ZG.actions:get("RIVER_FUNCTION")

-- zil: 1actions.zil:2692  <GLOBAL RIVER-SPEEDS>
-- RIVER_SPEEDS is declared in ZilGlobal.lua

-- zil: 1actions.zil:2695  <GLOBAL RIVER-NEXT>
-- RIVER_NEXT is declared in ZilGlobal.lua

-- zil: 1actions.zil:2698  <GLOBAL RIVER-LAUNCH>
-- RIVER_LAUNCH is declared in ZilGlobal.lua

-- zil: 1actions.zil:2708  <ROUTINE I-RIVER ("AUX" RM)>
ZG.actions:register("I_RIVER", function()

    local RM = 0
    if ((not ZG.EQUAL_p(ZG.HERE, ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3)) and (not ZG.EQUAL_p(ZG.HERE, ZG.RIVER_4, ZG.RIVER_5))) then
        do return ZG.DISABLE(ZG.INT(ZG.I_RIVER)) end
    elseif ZG._T((function() RM = ZG.LKP(ZG.HERE, ZG.RIVER_NEXT); return RM end)()) then
        do local _ = ZG.TELL("The flow of the river carries you downstream.", ZG._TK.CR, ZG._TK.CR) end
        do local _ = ZG.GOTO(RM) end
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_RIVER, ZG.LKP(ZG.HERE, ZG.RIVER_SPEEDS))) end
    else
        do return ZG.JIGS_UP("Unfortunately, the magic boat doesn't provide protection from\nthe rocks and boulders one meets at the bottom of waterfalls.\nIncluding this one.") end
    end

end, "I-RIVER")

ZG.I_RIVER = ZG.actions:get("I_RIVER")

-- zil: 1actions.zil:2722  <ROUTINE RBOAT-FUNCTION ("OPTIONAL" (RARG <>) "AUX" TMP)>
ZG.actions:register("RBOAT_FUNCTION", function(RARG)

    if RARG == nil then RARG = false end
    local TMP = 0
    if ZG.EQUAL_p(RARG, ZG.M_ENTER, ZG.M_END, ZG.M_LOOK) then
        do return false end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if ZG._T(ZG.VERB_p("WALK")) then
            if ZG.EQUAL_p(ZG.PRSO, "LAND", "EAST", "WEST") then
                do return false end
            elseif (ZG.EQ(ZG.HERE, ZG.RESERVOIR) and ZG.EQUAL_p(ZG.PRSO, "NORTH", "SOUTH")) then
                do return false end
            elseif (ZG.EQ(ZG.HERE, ZG.IN_STREAM) and ZG.EQ(ZG.PRSO, "SOUTH")) then
                do return false end
            else
                do local _ = ZG.TELL("Read the label for the boat's instructions.", ZG._TK.CR) end
                do return true end
            end
        elseif ZG._T(ZG.VERB_p("LAUNCH")) then
            if (ZG.EQUAL_p(ZG.HERE, ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3) or ZG.EQUAL_p(ZG.HERE, ZG.RIVER_4, ZG.RESERVOIR, ZG.IN_STREAM)) then
                do local _ = ZG.TELL("You are on the ") end
                if ZG.EQ(ZG.HERE, ZG.RESERVOIR) then
                    do local _ = ZG.TELL("reservoir") end
                elseif ZG.EQ(ZG.HERE, ZG.IN_STREAM) then
                    do local _ = ZG.TELL("stream") end
                else
                    do local _ = ZG.TELL("river") end
                end
                do return ZG.TELL(", or have you forgotten?", ZG._TK.CR) end
            elseif ZG.EQ((function() TMP = ZG.GO_NEXT(ZG.RIVER_LAUNCH); return TMP end)(), 1) then
                do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_RIVER, ZG.LKP(ZG.HERE, ZG.RIVER_SPEEDS))) end
                do return true end
            elseif (not ZG.EQ(TMP, 2)) then
                do local _ = ZG.TELL("You can't launch it here.", ZG._TK.CR) end
                do return true end
            else
                do return true end
            end
        elseif ((ZG._T(ZG.VERB_p("DROP")) and ZG._T(ZG.FSET_p(ZG.PRSO, "WEAPONBIT"))) or (ZG._T(ZG.VERB_p("PUT")) and ZG._T(ZG.FSET_p(ZG.PRSO, "WEAPONBIT")) and ZG.EQ(ZG.PRSI, ZG.INFLATED_BOAT)) or (ZG._T(ZG.VERB_p("ATTACK", "MUNG")) and ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT")))) then
            do local _ = ZG.REMOVE_CAREFULLY(ZG.INFLATED_BOAT) end
            do local _ = ZG.MOVE(ZG.PUNCTURED_BOAT, ZG.HERE) end
            do local _ = ZG.ROB(ZG.INFLATED_BOAT, ZG.HERE) end
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
            do local _ = ZG.TELL("It seems that the ") end
            if ZG._T(ZG.VERB_p("DROP", "PUT")) then
                do local _ = ZG.TELL(ZG._TK.D, ZG.PRSO) end
            else
                do local _ = ZG.TELL(ZG._TK.D, ZG.PRSI) end
            end
            do local _ = ZG.TELL(" didn't agree with the boat, as evidenced\nby the loud hissing noise issuing therefrom. With a pathetic sputter, the\nboat deflates, leaving you without.", ZG._TK.CR) end
            if ZG._T(ZG.FSET_p(ZG.HERE, "NONLANDBIT")) then
                do local _ = ZG.CRLF() end
                if ZG.EQUAL_p(ZG.HERE, ZG.RESERVOIR, ZG.IN_STREAM) then
                    do local _ = ZG.JIGS_UP("Another pathetic sputter, this time from you, heralds your drowning.") end
                else
                    do local _ = ZG.JIGS_UP("In other words, fighting the fierce currents of the Frigid River. You\nmanage to hold your own for a bit, but then you are carried over a\nwaterfall and into some nasty rocks. Ouch!") end
                end
            end
            do return true end
        elseif ZG._T(ZG.VERB_p("LAUNCH")) then
            do return ZG.TELL("You're not in the boat!", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("BOARD")) then
        if (ZG._T(ZG.IN_p(ZG.SCEPTRE, ZG.WINNER)) or ZG._T(ZG.IN_p(ZG.KNIFE, ZG.WINNER)) or ZG._T(ZG.IN_p(ZG.SWORD, ZG.WINNER)) or ZG._T(ZG.IN_p(ZG.RUSTY_KNIFE, ZG.WINNER)) or ZG._T(ZG.IN_p(ZG.AXE, ZG.WINNER)) or ZG._T(ZG.IN_p(ZG.STILETTO, ZG.WINNER))) then
            do local _ = ZG.TELL("Oops! Something sharp seems to have slipped and punctured the boat.\nThe boat deflates to the sounds of hissing, sputtering, and cursing.", ZG._TK.CR) end
            do local _ = ZG.REMOVE_CAREFULLY(ZG.INFLATED_BOAT) end
            do local _ = ZG.MOVE(ZG.PUNCTURED_BOAT, ZG.HERE) end
            do local _ = ZG.THIS_IS_IT(ZG.PUNCTURED_BOAT) end
            do return true end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("INFLATE", "FILL")) then
        do return ZG.TELL("Inflating it further would probably burst it.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DEFLATE")) then
        if ZG.EQ(ZG.LOC(ZG.WINNER), ZG.INFLATED_BOAT) then
            do return ZG.TELL("You can't deflate the boat while you're in it.", ZG._TK.CR) end
        elseif (not ZG._T(ZG.IN_p(ZG.INFLATED_BOAT, ZG.HERE))) then
            do return ZG.TELL("The boat must be on the ground to be deflated.", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The boat deflates.", ZG._TK.CR) end
            ZG._set("DEFLATE", true)
            do local _ = ZG.REMOVE_CAREFULLY(ZG.INFLATED_BOAT) end
            do local _ = ZG.MOVE(ZG.INFLATABLE_BOAT, ZG.HERE) end
            do return ZG.THIS_IS_IT(ZG.INFLATABLE_BOAT) end
        end
    else
        do return false end
    end

end, "RBOAT-FUNCTION")

ZG.RBOAT_FUNCTION = ZG.actions:get("RBOAT_FUNCTION")

-- zil: 1actions.zil:2817  <ROUTINE BREATHE ()>
ZG.actions:register("BREATHE", function()

    do return ZG.PERFORM(ZG.SYMBOL("V?INFLATE"), ZG.PRSO, ZG.LUNGS) end

end, "BREATHE")

ZG.BREATHE = ZG.actions:get("BREATHE")

-- zil: 1actions.zil:2820  <ROUTINE IBOAT-FUNCTION ()>
ZG.actions:register("IBOAT_FUNCTION", function()

    if ZG._T(ZG.VERB_p("INFLATE", "FILL")) then
        if (not ZG._T(ZG.IN_p(ZG.INFLATABLE_BOAT, ZG.HERE))) then
            do return ZG.TELL("The boat must be on the ground to be inflated.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSI, ZG.PUMP) then
            do local _ = ZG.TELL("The boat inflates and appears seaworthy.", ZG._TK.CR) end
            if (not ZG._T(ZG.FSET_p(ZG.BOAT_LABEL, "TOUCHBIT"))) then
                do local _ = ZG.TELL("A tan label is lying inside the boat.", ZG._TK.CR) end
            end
            ZG._set("DEFLATE", false)
            do local _ = ZG.REMOVE_CAREFULLY(ZG.INFLATABLE_BOAT) end
            do local _ = ZG.MOVE(ZG.INFLATED_BOAT, ZG.HERE) end
            do return ZG.THIS_IS_IT(ZG.INFLATED_BOAT) end
        elseif ZG.EQ(ZG.PRSI, ZG.LUNGS) then
            do return ZG.TELL("You don't have enough lung power to inflate it.", ZG._TK.CR) end
        else
            do return ZG.TELL("With a ", ZG._TK.D, ZG.PRSI, "? Surely you jest!", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "IBOAT-FUNCTION")

ZG.IBOAT_FUNCTION = ZG.actions:get("IBOAT_FUNCTION")

-- zil: 1actions.zil:2842  <GLOBAL BUOY-FLAG>
-- BUOY_FLAG is declared in ZilGlobal.lua

-- zil: 1actions.zil:2844  <ROUTINE RIVR4-ROOM (RARG)>
ZG.actions:register("RIVR4_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_END) then
        if (ZG._T(ZG.IN_p(ZG.BUOY, ZG.WINNER)) and ZG._T(ZG.BUOY_FLAG)) then
            do local _ = ZG.TELL("You notice something funny about the feel of the buoy.", ZG._TK.CR) end
            ZG._set("BUOY_FLAG", false)
            do return ZG.BUOY_FLAG end
        else
            do return false end
        end
    else
        do return false end
    end

end, "RIVR4-ROOM")

ZG.RIVR4_ROOM = ZG.actions:get("RIVR4_ROOM")

-- zil: 1actions.zil:2851  <GLOBAL BEACH-DIG>
-- BEACH_DIG is declared in ZilGlobal.lua

-- GDECL _arg

-- zil: 1actions.zil:2855  <ROUTINE SAND-FUNCTION ()>
ZG.actions:register("SAND_FUNCTION", function()

    if (ZG._T(ZG.VERB_p("DIG")) and ZG.EQ(ZG.PRSI, ZG.SHOVEL)) then
        ZG._set("BEACH_DIG", ZG.ADD(1, ZG.BEACH_DIG))
        if ZG.LT(3, ZG.BEACH_DIG) then
            ZG._set("BEACH_DIG", -1)
            do local _ = (ZG._T(ZG.IN_p(ZG.SCARAB, ZG.HERE)) and ZG.FSET(ZG.SCARAB, "INVISIBLE")) end
            do return ZG.JIGS_UP("The hole collapses, smothering you.") end
        elseif ZG.EQ(ZG.BEACH_DIG, 3) then
            if ZG._T(ZG.FSET_p(ZG.SCARAB, "INVISIBLE")) then
                do local _ = ZG.TELL("You can see a scarab here in the sand.", ZG._TK.CR) end
                do local _ = ZG.THIS_IS_IT(ZG.SCARAB) end
                do return ZG.FCLEAR(ZG.SCARAB, "INVISIBLE") end
            else
                do return false end
            end
        else
            do return ZG.TELL(ZG.GET(ZG.BDIGS, ZG.BEACH_DIG), ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "SAND-FUNCTION")

ZG.SAND_FUNCTION = ZG.actions:get("SAND_FUNCTION")

-- zil: 1actions.zil:2871  <GLOBAL BDIGS>
-- BDIGS is declared in ZilGlobal.lua

-- zil: 1actions.zil:2880  <ROUTINE TREE-ROOM (RARG "AUX" F)>
ZG.actions:register("TREE_ROOM", function(RARG)

    local F = 0
    if ZG.EQ(RARG, ZG.M_LOOK) then
        do local _ = ZG.TELL("You are about 10 feet above the ground nestled among some large\nbranches. The nearest branch above you is above your reach.", ZG._TK.CR) end
        if (ZG._T((function() F = ZG.FIRST_p(ZG.PATH); return F end)()) and ZG._T(ZG.NEXT_p(F))) then
            do local _ = ZG.TELL("On the ground below you can see:  ") end
            do local _ = ZG.PRINT_CONTENTS(ZG.PATH) end
            do return ZG.TELL(".", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if (ZG._T(ZG.VERB_p("CLIMB-DOWN")) and ZG.EQUAL_p(ZG.PRSO, ZG.TREE, ZG.ROOMS)) then
            do return ZG.DO_WALK("DOWN") end
        elseif (ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-FOO")) and ZG.EQ(ZG.PRSO, ZG.TREE)) then
            do return ZG.DO_WALK("UP") end
        elseif ZG._T(ZG.VERB_p("DROP")) then
            if (not ZG._T(ZG.IDROP())) then
                do return true end
            elseif (ZG.EQ(ZG.PRSO, ZG.NEST) and ZG._T(ZG.IN_p(ZG.EGG, ZG.NEST))) then
                do local _ = ZG.TELL("The nest falls to the ground, and the egg spills out of it, seriously\ndamaged.", ZG._TK.CR) end
                do local _ = ZG.REMOVE_CAREFULLY(ZG.EGG) end
                do return ZG.MOVE(ZG.BROKEN_EGG, ZG.PATH) end
            elseif ZG.EQ(ZG.PRSO, ZG.EGG) then
                do local _ = ZG.TELL("The egg falls to the ground and springs open, seriously damaged.") end
                do local _ = ZG.MOVE(ZG.EGG, ZG.PATH) end
                do local _ = ZG.BAD_EGG() end
                do return ZG.CRLF() end
            elseif (not ZG.EQUAL_p(ZG.PRSO, ZG.WINNER, ZG.TREE)) then
                do local _ = ZG.MOVE(ZG.PRSO, ZG.PATH) end
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " falls to the ground.", ZG._TK.CR) end
            elseif ZG._T(ZG.VERB_p("LEAP")) then
                do return ZG.JIGS_UP("That was just a bit too far down.") end
            else
                do return false end
            end
        else
            do return false end
        end
    elseif ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_FOREST_ROOM, -1)) end
    else
        do return false end
    end

end, "TREE-ROOM")

ZG.TREE_ROOM = ZG.actions:get("TREE_ROOM")

-- zil: 1actions.zil:2919  <ROUTINE EGG-OBJECT ()>
ZG.actions:register("EGG_OBJECT", function()

    if (ZG._T(ZG.VERB_p("OPEN", "MUNG")) and ZG.EQ(ZG.PRSO, ZG.EGG)) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "OPENBIT")) then
            do return ZG.TELL("The egg is already open.", ZG._TK.CR) end
        elseif (not ZG._T(ZG.PRSI)) then
            do return ZG.TELL("You have neither the tools nor the expertise.", ZG._TK.CR) end
        elseif ZG.EQ(ZG.PRSI, ZG.HANDS) then
            do return ZG.TELL("I doubt you could do that without damaging it.", ZG._TK.CR) end
        elseif (ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT")) or ZG._T(ZG.FSET_p(ZG.PRSI, "TOOLBIT")) or ZG._T(ZG.VERB_p("MUNG"))) then
            do local _ = ZG.TELL("The egg is now open, but the clumsiness of your attempt has seriously\ncompromised its esthetic appeal.") end
            do local _ = ZG.BAD_EGG() end
            do return ZG.CRLF() end
        elseif ZG._T(ZG.FSET_p(ZG.PRSO, "FIGHTBIT")) then
            do return ZG.TELL("Not to say that using the ", ZG._TK.D, ZG.PRSI, " isn't original too...", ZG._TK.CR) end
        else
            do local _ = ZG.TELL("The concept of using a ", ZG._TK.D, ZG.PRSI, " is certainly original.", ZG._TK.CR) end
            do return ZG.FSET(ZG.PRSO, "FIGHTBIT") end
        end
    elseif ZG._T(ZG.VERB_p("CLIMB-ON", "HATCH")) then
        do local _ = ZG.TELL("There is a noticeable crunch from beneath you, and inspection reveals\nthat the egg is lying open, badly damaged.") end
        do local _ = ZG.BAD_EGG() end
        do return ZG.CRLF() end
    elseif ZG._T(ZG.VERB_p("OPEN", "MUNG", "THROW")) then
        if ZG._T(ZG.VERB_p("THROW")) then
            do local _ = ZG.MOVE(ZG.PRSO, ZG.HERE) end
        end
        do local _ = ZG.TELL("Your rather indelicate handling of the egg has caused it some damage,\nalthough you have succeeded in opening it.") end
        do local _ = ZG.BAD_EGG() end
        do return ZG.CRLF() end
    else
        do return false end
    end

end, "EGG-OBJECT")

ZG.EGG_OBJECT = ZG.actions:get("EGG_OBJECT")

-- zil: 1actions.zil:2960  <ROUTINE BAD-EGG ("AUX" L)>
ZG.actions:register("BAD_EGG", function()

    local L = 0
    if ZG._T(ZG.IN_p(ZG.CANARY, ZG.EGG)) then
        do local _ = ZG.TELL(" ", ZG.GETP(ZG.BROKEN_CANARY, "FDESC")) end
    else
        do local _ = ZG.REMOVE_CAREFULLY(ZG.BROKEN_CANARY) end
    end
    do local _ = ZG.MOVE(ZG.BROKEN_EGG, ZG.LOC(ZG.EGG)) end
    do local _ = ZG.REMOVE_CAREFULLY(ZG.EGG) end
    do return true end

end, "BAD-EGG")

ZG.BAD_EGG = ZG.actions:get("BAD_EGG")

-- zil: 1actions.zil:2968  <GLOBAL SING-SONG>
-- SING_SONG is declared in ZilGlobal.lua

-- zil: 1actions.zil:2970  <ROUTINE CANARY-OBJECT ()>
ZG.actions:register("CANARY_OBJECT", function()

    local _tmp1, _tmp2
    if ZG._T(ZG.VERB_p("WIND")) then
        if ZG.EQ(ZG.PRSO, ZG.CANARY) then
            if ((not ZG._T(ZG.SING_SONG)) and ZG._T(ZG.FOREST_ROOM_p())) then
                do local _ = ZG.TELL("The canary chirps, slightly off-key, an aria from a forgotten opera.\nFrom out of the greenery flies a lovely songbird. It perches on a\nlimb just over your head and opens its beak to sing. As it does so\na beautiful brass bauble drops from its mouth, bounces off the top of\nyour head, and lands glimmering in the grass. As the canary winds\ndown, the songbird flies away.", ZG._TK.CR) end
                ZG._set("SING_SONG", true)
                if ZG.EQ(ZG.HERE, ZG.UP_A_TREE) then
                    _tmp1 = ZG.PATH
                else
                    _tmp1 = ZG.HERE
                end
                if ZG.EQ(ZG.HERE, ZG.UP_A_TREE) then
                    _tmp2 = ZG.PATH
                else
                    _tmp2 = ZG.HERE
                end
                do return ZG.MOVE(ZG.BAUBLE, _tmp2) end
            else
                do return ZG.TELL("The canary chirps blithely, if somewhat tinnily, for a short time.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("There is an unpleasant grinding noise from inside the canary.", ZG._TK.CR) end
        end
    else
        do return false end
    end

end, "CANARY-OBJECT")

ZG.CANARY_OBJECT = ZG.actions:get("CANARY_OBJECT")

-- zil: 1actions.zil:2992  <ROUTINE FOREST-ROOM? ()>
ZG.actions:register("FOREST_ROOM_p", function()

    do return (function() local _v = ZG.EQUAL_p(ZG.HERE, ZG.FOREST_1, ZG.FOREST_2, ZG.FOREST_3); if ZG._T(_v) then return _v end; return ZG.EQUAL_p(ZG.HERE, ZG.PATH, ZG.UP_A_TREE) end)() end

end, "FOREST-ROOM?")

ZG.FOREST_ROOM_p = ZG.actions:get("FOREST_ROOM_p")

-- zil: 1actions.zil:2996  <ROUTINE I-FOREST-ROOM ()>
ZG.actions:register("I_FOREST_ROOM", function()

    if (not ZG._T(ZG.FOREST_ROOM_p())) then
        do local _ = ZG.DISABLE(ZG.INT(ZG.I_FOREST_ROOM)) end
        do return false end
    elseif ZG._T(ZG.PROB_1(15)) then
        do return ZG.TELL("You hear in the distance the chirping of a song bird.", ZG._TK.CR) end
    else
        do return false end
    end

end, "I-FOREST-ROOM")

ZG.I_FOREST_ROOM = ZG.actions:get("I_FOREST_ROOM")

-- zil: 1actions.zil:3004  <ROUTINE FOREST-ROOM (RARG)>
ZG.actions:register("FOREST_ROOM", function(RARG)

    if ZG.EQ(RARG, ZG.M_ENTER) then
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_FOREST_ROOM, -1)) end
    elseif ZG.EQ(RARG, ZG.M_BEG) then
        if (ZG._T(ZG.VERB_p("CLIMB-FOO", "CLIMB-UP")) and ZG.EQ(ZG.PRSO, ZG.TREE)) then
            do return ZG.DO_WALK("UP") end
        else
            do return false end
        end
    else
        do return false end
    end

end, "FOREST-ROOM")

ZG.FOREST_ROOM = ZG.actions:get("FOREST_ROOM")

-- zil: 1actions.zil:3011  <ROUTINE WCLIF-OBJECT ()>
ZG.actions:register("WCLIF_OBJECT", function()

    if ZG._T(ZG.VERB_p("CLIMB-UP", "CLIMB-DOWN", "CLIMB-FOO")) then
        do return ZG.TELL("The cliff is too steep for climbing.", ZG._TK.CR) end
    else
        do return false end
    end

end, "WCLIF-OBJECT")

ZG.WCLIF_OBJECT = ZG.actions:get("WCLIF_OBJECT")

-- zil: 1actions.zil:3015  <ROUTINE CLIFF-OBJECT ()>
ZG.actions:register("CLIFF_OBJECT", function()

    if (ZG._T(ZG.VERB_p("LEAP")) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.ME))) then
        do return ZG.TELL("That would be very unwise. Perhaps even fatal.", ZG._TK.CR) end
    elseif ZG.EQ(ZG.PRSI, ZG.CLIMBABLE_CLIFF) then
        if ZG._T(ZG.VERB_p("PUT", "THROW-OFF")) then
            do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " tumbles into the river and is seen no more.", ZG._TK.CR) end
            do return ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "CLIFF-OBJECT")

ZG.CLIFF_OBJECT = ZG.actions:get("CLIFF_OBJECT")

-- zil: 1actions.zil:3030  <ROUTINE ROPE-FUNCTION ("AUX" RLOC)>
ZG.actions:register("ROPE_FUNCTION", function()

    local RLOC = 0
    if (not ZG.EQ(ZG.HERE, ZG.DOME_ROOM)) then
        ZG._set("DOME_FLAG", false)
        if ZG._T(ZG.VERB_p("TIE")) then
            do return ZG.TELL("You can't tie the rope to that.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("TIE")) then
        if ZG.EQ(ZG.PRSI, ZG.RAILING) then
            if ZG._T(ZG.DOME_FLAG) then
                do return ZG.TELL("The rope is already tied to it.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("The rope drops over the side and comes within ten feet of the floor.", ZG._TK.CR) end
                ZG._set("DOME_FLAG", true)
                do local _ = ZG.FSET(ZG.ROPE, "NDESCBIT") end
                RLOC = ZG.LOC(ZG.ROPE)
                if ((not ZG._T(RLOC)) or (not ZG._T(ZG.IN_p(RLOC, ZG.ROOMS)))) then
                    do local _ = ZG.MOVE(ZG.ROPE, ZG.HERE) end
                end
                do return true end
            end
        else
            do return false end
        end
    elseif (ZG._T(ZG.VERB_p("CLIMB-DOWN")) and ZG.EQUAL_p(ZG.PRSO, ZG.ROPE, ZG.ROOMS) and ZG._T(ZG.DOME_FLAG)) then
        do return ZG.DO_WALK("DOWN") end
    elseif (ZG._T(ZG.VERB_p("TIE-UP")) and ZG.EQ(ZG.ROPE, ZG.PRSI)) then
        if ZG._T(ZG.FSET_p(ZG.PRSO, "ACTORBIT")) then
            if ZG.LT(ZG.GETP(ZG.PRSO, "STRENGTH"), 0) then
                do local _ = ZG.TELL("Your attempt to tie up the ", ZG._TK.D, ZG.PRSO, " awakens him.") end
                do return ZG.AWAKEN(ZG.PRSO) end
            else
                do return ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " struggles and you cannot tie him up.", ZG._TK.CR) end
            end
        else
            do return ZG.TELL("Why would you tie up a ", ZG._TK.D, ZG.PRSO, "?", ZG._TK.CR) end
        end
    elseif ZG._T(ZG.VERB_p("UNTIE")) then
        if ZG._T(ZG.DOME_FLAG) then
            ZG._set("DOME_FLAG", false)
            do local _ = ZG.FCLEAR(ZG.ROPE, "NDESCBIT") end
            do return ZG.TELL("The rope is now untied.", ZG._TK.CR) end
        else
            do return ZG.TELL("It is not tied to anything.", ZG._TK.CR) end
        end
    elseif (ZG._T(ZG.VERB_p("DROP")) and ZG.EQ(ZG.HERE, ZG.DOME_ROOM) and (not ZG._T(ZG.DOME_FLAG))) then
        do local _ = ZG.MOVE(ZG.ROPE, ZG.TORCH_ROOM) end
        do return ZG.TELL("The rope drops gently to the floor below.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TAKE")) then
        if ZG._T(ZG.DOME_FLAG) then
            do return ZG.TELL("The rope is tied to the railing.", ZG._TK.CR) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "ROPE-FUNCTION")

ZG.ROPE_FUNCTION = ZG.actions:get("ROPE_FUNCTION")

-- zil: 1actions.zil:3080  <ROUTINE UNTIE-FROM ()>
ZG.actions:register("UNTIE_FROM", function()

    if (ZG.EQ(ZG.PRSO, ZG.ROPE) and (ZG._T(ZG.DOME_FLAG) and ZG.EQ(ZG.PRSI, ZG.RAILING))) then
        do return ZG.PERFORM(ZG.SYMBOL("V?UNTIE"), ZG.PRSO) end
    else
        do return ZG.TELL("It's not attached to that!", ZG._TK.CR) end
    end

end, "UNTIE-FROM")

ZG.UNTIE_FROM = ZG.actions:get("UNTIE_FROM")

-- zil: 1actions.zil:3086  <ROUTINE SLIDE-FUNCTION ()>
ZG.actions:register("SLIDE_FUNCTION", function()

    if (ZG._T(ZG.VERB_p("THROUGH", "CLIMB-UP", "CLIMB-DOWN", "CLIMB-FOO")) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.ME))) then
        if ZG.EQ(ZG.HERE, ZG.CELLAR) then
            do local _ = ZG.DO_WALK("WEST") end
            do return true end
        else
            do local _ = ZG.TELL("You tumble down the slide....", ZG._TK.CR) end
            do return ZG.GOTO(ZG.CELLAR) end
        end
    elseif ZG._T(ZG.VERB_p("PUT")) then
        do return ZG.SLIDER(ZG.PRSO) end
    else
        do return false end
    end

end, "SLIDE-FUNCTION")

ZG.SLIDE_FUNCTION = ZG.actions:get("SLIDE_FUNCTION")

-- zil: 1actions.zil:3098  <ROUTINE SLIDER (OBJ)>
ZG.actions:register("SLIDER", function(OBJ)

    if ZG._T(ZG.FSET_p(OBJ, "TAKEBIT")) then
        do local _ = ZG.TELL("The ", ZG._TK.D, OBJ, " falls into the slide and is gone.", ZG._TK.CR) end
        if ZG.EQ(OBJ, ZG.WATER) then
            do return ZG.REMOVE_CAREFULLY(OBJ) end
        else
            do return ZG.MOVE(OBJ, ZG.CELLAR) end
        end
    else
        do return ZG.TELL(ZG.PICK_ONE(ZG.YUKS), ZG._TK.CR) end
    end

end, "SLIDER")

ZG.SLIDER = ZG.actions:get("SLIDER")

-- zil: 1actions.zil:3106  <ROUTINE SANDWICH-BAG-FCN ()>
ZG.actions:register("SANDWICH_BAG_FCN", function()

    if (ZG._T(ZG.VERB_p("SMELL")) and ZG._T(ZG.IN_p(ZG.LUNCH, ZG.PRSO))) then
        do return ZG.TELL("It smells of hot peppers.", ZG._TK.CR) end
    else
        do return false end
    end

end, "SANDWICH-BAG-FCN")

ZG.SANDWICH_BAG_FCN = ZG.actions:get("SANDWICH_BAG_FCN")

-- zil: 1actions.zil:3113  <ROUTINE DEAD-FUNCTION ("OPTIONAL" (FOO <>) "AUX" M)>
ZG.actions:register("DEAD_FUNCTION", function(FOO)

    if FOO == nil then FOO = false end
    local M = 0
    if ZG._T(ZG.VERB_p("WALK")) then
        if (ZG.EQ(ZG.HERE, ZG.TIMBER_ROOM) and ZG.EQ(ZG.PRSO, "WEST")) then
            do return ZG.TELL("You cannot enter in your condition.", ZG._TK.CR) end
        else
            do return false end
        end
    elseif ZG._T(ZG.VERB_p("BRIEF", "VERBOSE", "SUPER-BRIEF", "VERSION", "SAVE", "RESTORE", "QUIT", "RESTART")) then
        do return false end
    elseif ZG._T(ZG.VERB_p("ATTACK", "MUNG", "ALARM", "SWING")) then
        do return ZG.TELL("All such attacks are vain in your condition.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("OPEN", "CLOSE", "EAT", "DRINK", "INFLATE", "DEFLATE", "TURN", "BURN", "TIE", "UNTIE", "RUB")) then
        do return ZG.TELL("Even such an action is beyond your capabilities.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("WAIT")) then
        do return ZG.TELL("Might as well. You've got an eternity.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LAMP-ON")) then
        do return ZG.TELL("You need no light to guide you.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("SCORE")) then
        do return ZG.TELL("You're dead! How can you think of your score?", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("TAKE", "RUB")) then
        do return ZG.TELL("Your hand passes through its object.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DROP", "THROW", "INVENTORY")) then
        do return ZG.TELL("You have no possessions.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("DIAGNOSE")) then
        do return ZG.TELL("You are dead.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK")) then
        do local _ = ZG.TELL("The room looks strange and unearthly") end
        if (not ZG._T(ZG.FIRST_p(ZG.HERE))) then
            do local _ = ZG.TELL(".") end
        else
            do local _ = ZG.TELL(" and objects appear indistinct.") end
        end
        do local _ = ZG.CRLF() end
        if (not ZG._T(ZG.FSET_p(ZG.HERE, "ONBIT"))) then
            do local _ = ZG.TELL("Although there is no light, the room seems dimly illuminated.", ZG._TK.CR) end
        end
        do local _ = ZG.CRLF() end
        do return false end
    elseif ZG._T(ZG.VERB_p("PRAY")) then
        if ZG.EQ(ZG.HERE, ZG.SOUTH_TEMPLE) then
            do local _ = ZG.FCLEAR(ZG.LAMP, "INVISIBLE") end
            do local _ = ZG.PUTP(ZG.WINNER, "ACTION", 0) end
            ZG._set("ALWAYS_LIT", false)
            ZG._set("DEAD", false)
            if ZG._T(ZG.IN_p(ZG.TROLL, ZG.TROLL_ROOM)) then
                ZG._set("TROLL_FLAG", false)
            end
            do local _ = ZG.TELL("From the distance the sound of a lone trumpet is heard. The room\nbecomes very bright and you feel disembodied. In a moment, the\nbrightness fades and you find yourself rising as if from a long\nsleep, deep in the woods. In the distance you can faintly hear a\nsongbird and the sounds of the forest.", ZG._TK.CR, ZG._TK.CR) end
            do return ZG.GOTO(ZG.FOREST_1) end
        else
            do return ZG.TELL("Your prayers are not heard.", ZG._TK.CR) end
        end
    else
        do local _ = ZG.TELL("You can't even do that.", ZG._TK.CR) end
        ZG._set("P_CONT", false)
        do return 2 end
    end

end, "DEAD-FUNCTION")

ZG.DEAD_FUNCTION = ZG.actions:get("DEAD_FUNCTION")

-- ;"Pseudo-object routines"

-- zil: 1actions.zil:3177  <ROUTINE LAKE-PSEUDO ()>
ZG.actions:register("LAKE_PSEUDO", function()

    if ZG._T(ZG.LOW_TIDE) then
        do return ZG.TELL("There's not much lake left....", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CROSS")) then
        do return ZG.TELL("It's too wide to cross.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.TELL("You can't swim in this lake.", ZG._TK.CR) end
    else
        do return false end
    end

end, "LAKE-PSEUDO")

ZG.LAKE_PSEUDO = ZG.actions:get("LAKE_PSEUDO")

-- zil: 1actions.zil:3185  <ROUTINE STREAM-PSEUDO ()>
ZG.actions:register("STREAM_PSEUDO", function()

    if ZG._T(ZG.VERB_p("SWIM", "THROUGH")) then
        do return ZG.TELL("You can't swim in the stream.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CROSS")) then
        do return ZG.TELL("The other side is a sheer rock cliff.", ZG._TK.CR) end
    else
        do return false end
    end

end, "STREAM-PSEUDO")

ZG.STREAM_PSEUDO = ZG.actions:get("STREAM_PSEUDO")

-- zil: 1actions.zil:3191  <ROUTINE CHASM-PSEUDO ()>
ZG.actions:register("CHASM_PSEUDO", function()

    if (ZG._T(ZG.VERB_p("LEAP")) or (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSO, ZG.ME))) then
        do return ZG.TELL("You look before leaping, and realize that you would never survive.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("CROSS")) then
        do return ZG.TELL("It's too far to jump, and there's no bridge.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT", "THROW-OFF")) and ZG.EQ(ZG.PRSI, ZG.PSEUDO_OBJECT)) then
        do local _ = ZG.TELL("The ", ZG._TK.D, ZG.PRSO, " drops out of sight into the chasm.", ZG._TK.CR) end
        do return ZG.REMOVE_CAREFULLY(ZG.PRSO) end
    else
        do return false end
    end

end, "CHASM-PSEUDO")

ZG.CHASM_PSEUDO = ZG.actions:get("CHASM_PSEUDO")

-- zil: 1actions.zil:3203  <ROUTINE DOME-PSEUDO ()>
ZG.actions:register("DOME_PSEUDO", function()

    if ZG._T(ZG.VERB_p("KISS")) then
        do return ZG.TELL("No.", ZG._TK.CR) end
    else
        do return false end
    end

end, "DOME-PSEUDO")

ZG.DOME_PSEUDO = ZG.actions:get("DOME_PSEUDO")

-- zil: 1actions.zil:3207  <ROUTINE GATE-PSEUDO ()>
ZG.actions:register("GATE_PSEUDO", function()

    if ZG._T(ZG.VERB_p("THROUGH")) then
        do local _ = ZG.DO_WALK("IN") end
        do return true end
    else
        do return ZG.TELL("The gate is protected by an invisible force. It makes your\nteeth ache to touch it.", ZG._TK.CR) end
    end

end, "GATE-PSEUDO")

ZG.GATE_PSEUDO = ZG.actions:get("GATE_PSEUDO")

-- zil: 1actions.zil:3216  <ROUTINE DOOR-PSEUDO ()>
ZG.actions:register("DOOR_PSEUDO", function()

    -- ;"in Studio"
    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("The door won't budge.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("THROUGH")) then
        do return ZG.DO_WALK("SOUTH") end
    else
        do return false end
    end

end, "DOOR-PSEUDO")

ZG.DOOR_PSEUDO = ZG.actions:get("DOOR_PSEUDO")

-- zil: 1actions.zil:3222  <ROUTINE PAINT-PSEUDO ()>
ZG.actions:register("PAINT_PSEUDO", function()

    if ZG._T(ZG.VERB_p("MUNG")) then
        do return ZG.TELL("Some paint chips away, revealing more paint.", ZG._TK.CR) end
    else
        do return false end
    end

end, "PAINT-PSEUDO")

ZG.PAINT_PSEUDO = ZG.actions:get("PAINT_PSEUDO")

-- zil: 1actions.zil:3226  <ROUTINE GAS-PSEUDO ()>
ZG.actions:register("GAS_PSEUDO", function()

    if ZG._T(ZG.VERB_p("BREATHE")) then
        do return ZG.TELL("There is too much gas to blow away.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("SMELL")) then
        do return ZG.TELL("It smells like coal gas in here.", ZG._TK.CR) end
    else
        do return false end
    end

end, "GAS-PSEUDO")

ZG.GAS_PSEUDO = ZG.actions:get("GAS_PSEUDO")

-- zil: 1actions.zil:3236  <CONSTANT F-BUSY?>
-- F_BUSY_p is declared in ZilGlobal.lua

-- ;"busy recovering weapon?"

-- zil: 1actions.zil:3237  <CONSTANT F-DEAD>
-- F_DEAD is declared in ZilGlobal.lua

-- ;"mistah kurtz, he dead."

-- zil: 1actions.zil:3238  <CONSTANT F-UNCONSCIOUS>
-- F_UNCONSCIOUS is declared in ZilGlobal.lua

-- ;"into dreamland"

-- zil: 1actions.zil:3239  <CONSTANT F-CONSCIOUS>
-- F_CONSCIOUS is declared in ZilGlobal.lua

-- ;"rise and shine"

-- zil: 1actions.zil:3240  <CONSTANT F-FIRST?>
-- F_FIRST_p is declared in ZilGlobal.lua

-- ;"strike first?"

-- zil: 1actions.zil:3246  <CONSTANT MISSED>
-- MISSED is declared in ZilGlobal.lua

-- ;"attacker misses"

-- zil: 1actions.zil:3247  <CONSTANT UNCONSCIOUS>
-- UNCONSCIOUS is declared in ZilGlobal.lua

-- ;"defender unconscious"

-- zil: 1actions.zil:3248  <CONSTANT KILLED>
-- KILLED is declared in ZilGlobal.lua

-- ;"defender dead"

-- zil: 1actions.zil:3249  <CONSTANT LIGHT-WOUND>
-- LIGHT_WOUND is declared in ZilGlobal.lua

-- ;"defender lightly wounded"

-- zil: 1actions.zil:3250  <CONSTANT SERIOUS-WOUND>
-- SERIOUS_WOUND is declared in ZilGlobal.lua

-- ;"defender seriously wounded"

-- zil: 1actions.zil:3251  <CONSTANT STAGGER>
-- STAGGER is declared in ZilGlobal.lua

-- ;"defender staggered (miss turn)"

-- zil: 1actions.zil:3252  <CONSTANT LOSE-WEAPON>
-- LOSE_WEAPON is declared in ZilGlobal.lua

-- ;"defender loses weapon"

-- zil: 1actions.zil:3253  <CONSTANT HESITATE>
-- HESITATE is declared in ZilGlobal.lua

-- ;"hesitates (miss on free swing)"

-- zil: 1actions.zil:3254  <CONSTANT SITTING-DUCK>
-- SITTING_DUCK is declared in ZilGlobal.lua

-- ;"sitting duck (crunch!)"

-- zil: 1actions.zil:3258  <GLOBAL DEF1>
-- DEF1 is declared in ZilGlobal.lua

-- zil: 1actions.zil:3265  <GLOBAL DEF2A>
-- DEF2A is declared in ZilGlobal.lua

-- zil: 1actions.zil:3272  <GLOBAL DEF2B>
-- DEF2B is declared in ZilGlobal.lua

-- zil: 1actions.zil:3280  <GLOBAL DEF3A>
-- DEF3A is declared in ZilGlobal.lua

-- zil: 1actions.zil:3287  <GLOBAL DEF3B>
-- DEF3B is declared in ZilGlobal.lua

-- zil: 1actions.zil:3294  <GLOBAL DEF3C>
-- DEF3C is declared in ZilGlobal.lua

-- zil: 1actions.zil:3301  <GLOBAL DEF1-RES>
-- DEF1_RES is declared in ZilGlobal.lua

-- zil: 1actions.zil:3306  <GLOBAL DEF2-RES>
-- DEF2_RES is declared in ZilGlobal.lua

-- zil: 1actions.zil:3312  <GLOBAL DEF3-RES>
-- DEF3_RES is declared in ZilGlobal.lua

-- zil: 1actions.zil:3323  <CONSTANT STRENGTH-MAX>
-- STRENGTH_MAX is declared in ZilGlobal.lua

-- zil: 1actions.zil:3324  <CONSTANT STRENGTH-MIN>
-- STRENGTH_MIN is declared in ZilGlobal.lua

-- zil: 1actions.zil:3325  <CONSTANT CURE-WAIT>
-- CURE_WAIT is declared in ZilGlobal.lua

-- zil: 1actions.zil:3331  <ROUTINE DO-FIGHT (LEN "AUX" CNT RES O OO (OUT <>))>
ZG.actions:register("DO_FIGHT", function(LEN)

    local CNT = 0
    local RES = 0
    local O = 0
    local OO = 0
    local OUT = false
    while true do
        CNT = 0
        while true do
            CNT = ZG.ADD(CNT, 1)
            if ZG.EQ(CNT, LEN) then
                RES = true
                break
            end
            OO = ZG.GET(ZG.VILLAINS, CNT)
            O = ZG.GET(OO, ZG.V_VILLAIN)
            if (not ZG._T(ZG.FSET_p(O, "FIGHTBIT"))) then
            elseif ZG._T(ZG.APPLY(ZG.GETP(O, "ACTION"), ZG.F_BUSY_p)) then
            elseif (not ZG._T((function() RES = ZG.VILLAIN_BLOW(OO, OUT); return RES end)())) then
                RES = false
                break
            elseif ZG.EQ(RES, ZG.UNCONSCIOUS) then
                OUT = ZG.ADD(1, ZG.RANDOM(3))
            end
        end
        if ZG._T(RES) then
            if (not ZG._T(OUT)) then
                do return true end
            else
                OUT = ZG.SUB(OUT, 1)
                if ZG.ZERO_p(OUT) then
                    do return true end
                end
            end
        else
            do return true end
        end
    end

end, "DO-FIGHT")

ZG.DO_FIGHT = ZG.actions:get("DO_FIGHT")

-- zil: 1actions.zil:3363  <ROUTINE REMARK (REMARK D W "AUX" (LEN <GET .REMARK 0>) (CNT 0) STR)>
ZG.actions:register("REMARK", function(REMARK, D, W)

    local LEN = ZG.GET(REMARK, 0)
    local CNT = 0
    local STR = 0
    while true do
        if ZG.LT(LEN, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
            break
        end
        STR = ZG.GET(REMARK, CNT)
        if ZG.EQ(STR, ZG.F_WEP) then
            do local _ = ZG.PRINTD(W) end
        elseif ZG.EQ(STR, ZG.F_DEF) then
            do local _ = ZG.PRINTD(D) end
        else
            do local _ = ZG.PRINT(STR) end
        end
    end
    do return ZG.CRLF() end

end, "REMARK")

ZG.REMARK = ZG.actions:get("REMARK")

-- zil: 1actions.zil:3375  <ROUTINE FIGHT-STRENGTH ("OPTIONAL" (ADJUST? T) "AUX" S)>
ZG.actions:register("FIGHT_STRENGTH", function(ADJUST_p)

    if ADJUST_p == nil then ADJUST_p = true end
    local S = 0
    S = ZG.ADD(ZG.STRENGTH_MIN, ZG.DIV(ZG.SCORE, ZG.DIV(ZG.SCORE_MAX, ZG.SUB(ZG.STRENGTH_MAX, ZG.STRENGTH_MIN))))
    if ZG._T(ADJUST_p) then
        do return ZG.ADD(S, ZG.GETP(ZG.WINNER, "STRENGTH")) end
    else
        do return S end
    end

end, "FIGHT-STRENGTH")

ZG.FIGHT_STRENGTH = ZG.actions:get("FIGHT_STRENGTH")

-- zil: 1actions.zil:3383  <ROUTINE VILLAIN-STRENGTH (OO "AUX" (VILLAIN <GET .OO ,V-VILLAIN>) OD TMP)>
ZG.actions:register("VILLAIN_STRENGTH", function(OO)

    local VILLAIN = ZG.GET(OO, ZG.V_VILLAIN)
    local OD = 0
    local TMP = 0
    OD = ZG.GETP(VILLAIN, "STRENGTH")
    if (not ZG.LT(OD, 0)) then
        if (ZG.EQ(VILLAIN, ZG.THIEF) and ZG._T(ZG.THIEF_ENGROSSED)) then
            if ZG.LT(2, OD) then
                OD = 2
            end
            ZG._set("THIEF_ENGROSSED", false)
        end
        if (ZG._T(ZG.PRSI) and ZG._T(ZG.FSET_p(ZG.PRSI, "WEAPONBIT")) and ZG.EQ(ZG.GET(OO, ZG.V_BEST), ZG.PRSI)) then
            TMP = ZG.SUB(OD, ZG.GET(OO, ZG.V_BEST_ADV))
            if ZG.LT(TMP, 1) then
                TMP = 1
            end
            OD = TMP
        end
    end
    do return OD end

end, "VILLAIN-STRENGTH")

ZG.VILLAIN_STRENGTH = ZG.actions:get("VILLAIN_STRENGTH")

-- zil: 1actions.zil:3401  <ROUTINE FIND-WEAPON (O "AUX" W)>
ZG.actions:register("FIND_WEAPON", function(O)

    local W = 0
    W = ZG.FIRST_p(O)
    if (not ZG._T(W)) then
        do return false end
    end
    while true do
        if (ZG.EQUAL_p(W, ZG.STILETTO, ZG.AXE, ZG.SWORD) or ZG.EQUAL_p(W, ZG.KNIFE, ZG.RUSTY_KNIFE)) then
            do return W end
        elseif (not ZG._T((function() W = ZG.NEXT_p(W); return W end)())) then
            do return false end
        end
    end

end, "FIND-WEAPON")

ZG.FIND_WEAPON = ZG.actions:get("FIND_WEAPON")

-- zil: 1actions.zil:3413  <ROUTINE VILLAIN-BLOW (OO OUT? "AUX" (VILLAIN <GET .OO ,V-VILLAIN>) (REMARKS ...
ZG.actions:register("VILLAIN_BLOW", function(OO, OUT_p)

    local VILLAIN = ZG.GET(OO, ZG.V_VILLAIN)
    local REMARKS = ZG.GET(OO, ZG.V_MSGS)
    local DWEAPON = 0
    local ATT = 0
    local DEF = 0
    local OA = 0
    local OD = 0
    local TBL = 0
    local RES = 0
    local NWEAPON = 0
    local HERO_p = 0
    do local _ = ZG.FCLEAR(ZG.WINNER, "STAGGERED") end
    if ZG._T(ZG.FSET_p(VILLAIN, "STAGGERED")) then
        do local _ = ZG.TELL("The ", ZG._TK.D, VILLAIN, " slowly regains his feet.", ZG._TK.CR) end
        do local _ = ZG.FCLEAR(VILLAIN, "STAGGERED") end
        do return true end
    end
    OA = (function() ATT = ZG.VILLAIN_STRENGTH(OO); return ATT end)()
    if (not ZG.LT(0, (function() DEF = ZG.FIGHT_STRENGTH(); return DEF end)())) then
        do return true end
    end
    OD = ZG.FIGHT_STRENGTH(false)
    DWEAPON = ZG.FIND_WEAPON(ZG.WINNER)
    if ZG.LT(DEF, 0) then
        RES = ZG.KILLED
    else
        if (DEF == 1) then
            if ZG.LT(2, ATT) then
                ATT = 3
            end
            TBL = ZG.GET(ZG.DEF1_RES, ZG.SUB(ATT, 1))
        elseif ZG.EQ(DEF, 2) then
            if ZG.LT(3, ATT) then
                ATT = 4
            end
            TBL = ZG.GET(ZG.DEF2_RES, ZG.SUB(ATT, 1))
        elseif ZG.LT(2, DEF) then
            ATT = ZG.SUB(ATT, DEF)
            if ZG.LT(ATT, -1) then
                ATT = -2
            elseif ZG.LT(1, ATT) then
                ATT = 2
            end
            TBL = ZG.GET(ZG.DEF3_RES, ZG.ADD(ATT, 2))
        end
        RES = ZG.GET(TBL, ZG.SUB(ZG.RANDOM(9), 1))
        if ZG._T(OUT_p) then
            if ZG.EQ(RES, ZG.STAGGER) then
                RES = ZG.HESITATE
            else
                RES = ZG.SITTING_DUCK
            end
        end
        -- macro: <PROB 25 <COND (.HERO? 10)(T 50)>> (gmacros.zil:115) -> expanded (副作用のある引数)
        if (ZG.EQ(RES, ZG.STAGGER) and ZG._T(DWEAPON) and ZG._T(ZG.ZPROB(25))) then
            RES = ZG.LOSE_WEAPON
        end
        do local _ = ZG.REMARK(ZG.RANDOM_ELEMENT(ZG.GET(REMARKS, ZG.SUB(RES, 1))), ZG.WINNER, DWEAPON) end
    end
    if (ZG.EQ(RES, ZG.MISSED) or ZG.EQ(RES, ZG.HESITATE)) then
    elseif ZG.EQ(RES, ZG.UNCONSCIOUS) then
    elseif (ZG.EQ(RES, ZG.KILLED) or ZG.EQ(RES, ZG.SITTING_DUCK)) then
        DEF = 0
    elseif ZG.EQ(RES, ZG.LIGHT_WOUND) then
        DEF = ZG.SUB(DEF, 1)
        if ZG.LT(DEF, 0) then
            DEF = 0
        end
        if ZG.LT(50, ZG.LOAD_ALLOWED) then
            ZG._set("LOAD_ALLOWED", ZG.SUB(ZG.LOAD_ALLOWED, 10))
        end
    elseif ZG.EQ(RES, ZG.SERIOUS_WOUND) then
        DEF = ZG.SUB(DEF, 2)
        if ZG.LT(DEF, 0) then
            DEF = 0
        end
        if ZG.LT(50, ZG.LOAD_ALLOWED) then
            ZG._set("LOAD_ALLOWED", ZG.SUB(ZG.LOAD_ALLOWED, 20))
        end
    elseif ZG.EQ(RES, ZG.STAGGER) then
        do local _ = ZG.FSET(ZG.WINNER, "STAGGERED") end
    else
        do local _ = ZG.MOVE(DWEAPON, ZG.HERE) end
        if ZG._T((function() NWEAPON = ZG.FIND_WEAPON(ZG.WINNER); return NWEAPON end)()) then
            do local _ = ZG.TELL("Fortunately, you still have a ", ZG._TK.D, NWEAPON, ".", ZG._TK.CR) end
        end
    end
    do return ZG.WINNER_RESULT(DEF, RES, OD) end

end, "VILLAIN-BLOW")

ZG.VILLAIN_BLOW = ZG.actions:get("VILLAIN_BLOW")

-- zil: 1actions.zil:3476  <ROUTINE HERO-BLOW ("AUX" OO VILLAIN (OUT? <>) DWEAPON ATT DEF (CNT 0) OA OD ...
ZG.actions:register("HERO_BLOW", function()

    local OO = 0
    local VILLAIN = 0
    local OUT_p = false
    local DWEAPON = 0
    local ATT = 0
    local DEF = 0
    local CNT = 0
    local OA = 0
    local OD = 0
    local TBL = 0
    local RES = 0
    local NWEAPON = 0
    local LEN = ZG.GET(ZG.VILLAINS, 0)
    while true do
        CNT = ZG.ADD(CNT, 1)
        if ZG.EQ(CNT, LEN) then
            break
        end
        OO = ZG.GET(ZG.VILLAINS, CNT)
        if ZG.EQ(ZG.GET(OO, ZG.V_VILLAIN), ZG.PRSO) then
            break
        end
    end
    do local _ = ZG.FSET(ZG.PRSO, "FIGHTBIT") end
    if ZG._T(ZG.FSET_p(ZG.WINNER, "STAGGERED")) then
        do local _ = ZG.TELL("You are still recovering from that last blow, so your attack is\nineffective.", ZG._TK.CR) end
        do local _ = ZG.FCLEAR(ZG.WINNER, "STAGGERED") end
        do return true end
    end
    ATT = ZG.FIGHT_STRENGTH()
    if ZG.LT(ATT, 1) then
        ATT = 1
    end
    OA = ATT
    VILLAIN = ZG.GET(OO, ZG.V_VILLAIN)
    if ZG.ZERO_p((function() OD = (function() DEF = ZG.VILLAIN_STRENGTH(OO); return DEF end)(); return OD end)()) then
        if ZG.EQ(ZG.PRSO, ZG.WINNER) then
            do return ZG.JIGS_UP("Well, you really did it that time. Is suicide painless?") end
        end
        do local _ = ZG.TELL("Attacking the ", ZG._TK.D, VILLAIN, " is pointless.", ZG._TK.CR) end
        do return true end
    end
    DWEAPON = ZG.FIND_WEAPON(VILLAIN)
    if ((not ZG._T(DWEAPON)) or ZG.LT(DEF, 0)) then
        do local _ = ZG.TELL("The ") end
        if ZG.LT(DEF, 0) then
            do local _ = ZG.TELL("unconscious") end
        else
            do local _ = ZG.TELL("unarmed") end
        end
        do local _ = ZG.TELL(" ", ZG._TK.D, VILLAIN, " cannot defend himself: He dies.", ZG._TK.CR) end
        RES = ZG.KILLED
    else
        if (DEF == 1) then
            if ZG.LT(2, ATT) then
                ATT = 3
            end
            TBL = ZG.GET(ZG.DEF1_RES, ZG.SUB(ATT, 1))
        elseif ZG.EQ(DEF, 2) then
            if ZG.LT(3, ATT) then
                ATT = 4
            end
            TBL = ZG.GET(ZG.DEF2_RES, ZG.SUB(ATT, 1))
        elseif ZG.LT(2, DEF) then
            ATT = ZG.SUB(ATT, DEF)
            if ZG.LT(ATT, -1) then
                ATT = -2
            elseif ZG.LT(1, ATT) then
                ATT = 2
            end
            TBL = ZG.GET(ZG.DEF3_RES, ZG.ADD(ATT, 2))
        end
        RES = ZG.GET(TBL, ZG.SUB(ZG.RANDOM(9), 1))
        if ZG._T(OUT_p) then
            if ZG.EQ(RES, ZG.STAGGER) then
                RES = ZG.HESITATE
            else
                RES = ZG.SITTING_DUCK
            end
        end
        if (ZG.EQ(RES, ZG.STAGGER) and ZG._T(DWEAPON) and ZG._T(ZG.PROB_1(25))) then
            RES = ZG.LOSE_WEAPON
        end
        do local _ = ZG.REMARK(ZG.RANDOM_ELEMENT(ZG.GET(ZG.HERO_MELEE, ZG.SUB(RES, 1))), ZG.PRSO, ZG.PRSI) end
    end
    if (ZG.EQ(RES, ZG.MISSED) or ZG.EQ(RES, ZG.HESITATE)) then
    elseif ZG.EQ(RES, ZG.UNCONSCIOUS) then
        DEF = ZG.NEG(DEF)
    elseif (ZG.EQ(RES, ZG.KILLED) or ZG.EQ(RES, ZG.SITTING_DUCK)) then
        DEF = 0
    elseif ZG.EQ(RES, ZG.LIGHT_WOUND) then
        DEF = ZG.SUB(DEF, 1)
        if ZG.LT(DEF, 0) then
            DEF = 0
        end
    elseif ZG.EQ(RES, ZG.SERIOUS_WOUND) then
        DEF = ZG.SUB(DEF, 2)
        if ZG.LT(DEF, 0) then
            DEF = 0
        end
    elseif ZG.EQ(RES, ZG.STAGGER) then
        do local _ = ZG.FSET(ZG.PRSO, "STAGGERED") end
    else
        do local _ = ZG.FCLEAR(DWEAPON, "NDESCBIT") end
        do local _ = ZG.FSET(DWEAPON, "WEAPONBIT") end
        do local _ = ZG.MOVE(DWEAPON, ZG.HERE) end
        do local _ = ZG.THIS_IS_IT(DWEAPON) end
    end
    do return ZG.VILLAIN_RESULT(ZG.PRSO, DEF, RES) end

end, "HERO-BLOW")

ZG.HERO_BLOW = ZG.actions:get("HERO_BLOW")

-- zil: 1actions.zil:3552  <ROUTINE WINNER-RESULT (DEF RES OD)>
ZG.actions:register("WINNER_RESULT", function(DEF, RES, OD)

    local _tmp1, _tmp2
    if ZG.ZERO_p(DEF) then
        _tmp1 = -10000
    else
        _tmp1 = ZG.SUB(DEF, OD)
    end
    if ZG.ZERO_p(DEF) then
        _tmp2 = -10000
    else
        _tmp2 = ZG.SUB(DEF, OD)
    end
    do local _ = ZG.PUTP(ZG.WINNER, "STRENGTH", _tmp2) end
    if ZG.LT(ZG.SUB(DEF, OD), 0) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CURE, ZG.CURE_WAIT)) end
    end
    if (not ZG.LT(0, ZG.FIGHT_STRENGTH())) then
        do local _ = ZG.PUTP(ZG.WINNER, "STRENGTH", ZG.ADD(1, ZG.NEG(ZG.FIGHT_STRENGTH(false)))) end
        do local _ = ZG.JIGS_UP("It appears that that last blow was too much for you. I'm afraid you\nare dead.") end
        do return false end
    else
        do return RES end
    end

end, "WINNER-RESULT")

ZG.WINNER_RESULT = ZG.actions:get("WINNER_RESULT")

-- zil: 1actions.zil:3566  <ROUTINE VILLAIN-RESULT (VILLAIN DEF RES)>
ZG.actions:register("VILLAIN_RESULT", function(VILLAIN, DEF, RES)

    do local _ = ZG.PUTP(VILLAIN, "STRENGTH", DEF) end
    if ZG.ZERO_p(DEF) then
        do local _ = ZG.FCLEAR(VILLAIN, "FIGHTBIT") end
        do local _ = ZG.TELL("Almost as soon as the ", ZG._TK.D, VILLAIN, " breathes his last breath, a cloud\nof sinister black fog envelops him, and when the fog lifts, the\ncarcass has disappeared.", ZG._TK.CR) end
        do local _ = ZG.REMOVE_CAREFULLY(VILLAIN) end
        do local _ = ZG.APPLY(ZG.GETP(VILLAIN, "ACTION"), ZG.F_DEAD) end
        do return RES end
    elseif ZG.EQ(RES, ZG.UNCONSCIOUS) then
        do local _ = ZG.APPLY(ZG.GETP(VILLAIN, "ACTION"), ZG.F_UNCONSCIOUS) end
        do return RES end
    else
        do return RES end
    end

end, "VILLAIN-RESULT")

ZG.VILLAIN_RESULT = ZG.actions:get("VILLAIN_RESULT")

-- zil: 1actions.zil:3584  <ROUTINE WINNING? (V "AUX" VS PS)>
ZG.actions:register("WINNING_p", function(V)

    local VS = 0
    local PS = 0
    VS = ZG.GETP(V, "STRENGTH")
    PS = ZG.SUB(VS, ZG.FIGHT_STRENGTH())
    if ZG.LT(3, PS) then
        do return ZG.PROB_1(90) end
    elseif ZG.LT(0, PS) then
        do return ZG.PROB_1(75) end
    elseif ZG.ZERO_p(PS) then
        do return ZG.PROB_1(50) end
    elseif ZG.LT(1, VS) then
        do return ZG.PROB_1(25) end
    else
        do return ZG.PROB_1(10) end
    end

end, "WINNING?")

ZG.WINNING_p = ZG.actions:get("WINNING_p")

-- zil: 1actions.zil:3593  <ROUTINE I-CURE ("AUX" (S <GETP ,WINNER ,P?STRENGTH>))>
ZG.actions:register("I_CURE", function()

    local S = ZG.GETP(ZG.WINNER, "STRENGTH")
    if ZG.LT(0, S) then
        S = 0
        do local _ = ZG.PUTP(ZG.WINNER, "STRENGTH", S) end
    elseif ZG.LT(S, 0) then
        S = ZG.ADD(S, 1)
        do local _ = ZG.PUTP(ZG.WINNER, "STRENGTH", S) end
    end
    if ZG.LT(S, 0) then
        if ZG.LT(ZG.LOAD_ALLOWED, ZG.LOAD_MAX) then
            ZG._set("LOAD_ALLOWED", ZG.ADD(ZG.LOAD_ALLOWED, 10))
        end
        do return ZG.ENABLE(ZG.QUEUE(ZG.I_CURE, ZG.CURE_WAIT)) end
    else
        ZG._set("LOAD_ALLOWED", ZG.LOAD_MAX)
        do return ZG.DISABLE(ZG.INT(ZG.I_CURE)) end
    end

end, "I-CURE")

ZG.I_CURE = ZG.actions:get("I_CURE")

-- zil: 1actions.zil:3608  <CONSTANT F-WEP>
-- F_WEP is declared in ZilGlobal.lua

-- ;"means print weapon name"

-- zil: 1actions.zil:3609  <CONSTANT F-DEF>
-- F_DEF is declared in ZilGlobal.lua

-- ;"means print defender name (villain, e.g.)"

-- zil: 1actions.zil:3611  <GLOBAL HERO-MELEE>
-- HERO_MELEE is declared in ZilGlobal.lua

-- zil: 1actions.zil:3654  <GLOBAL CYCLOPS-MELEE>
-- CYCLOPS_MELEE is declared in ZilGlobal.lua

-- zil: 1actions.zil:3689  <GLOBAL TROLL-MELEE>
-- TROLL_MELEE is declared in ZilGlobal.lua

-- zil: 1actions.zil:3735  <GLOBAL THIEF-MELEE>
-- THIEF_MELEE is declared in ZilGlobal.lua

-- zil: 1actions.zil:3793  <CONSTANT V-VILLAIN>
-- V_VILLAIN is declared in ZilGlobal.lua

-- ;"villain"

-- zil: 1actions.zil:3794  <CONSTANT V-BEST>
-- V_BEST is declared in ZilGlobal.lua

-- ;"best weapon"

-- zil: 1actions.zil:3795  <CONSTANT V-BEST-ADV>
-- V_BEST_ADV is declared in ZilGlobal.lua

-- ;"advantage it confers"

-- zil: 1actions.zil:3796  <CONSTANT V-PROB>
-- V_PROB is declared in ZilGlobal.lua

-- ;"prob of waking if unconscious"

-- zil: 1actions.zil:3797  <CONSTANT V-MSGS>
-- V_MSGS is declared in ZilGlobal.lua

-- ;"messages for that villain"

-- zil: 1actions.zil:3801  <GLOBAL VILLAINS>
-- VILLAINS is declared in ZilGlobal.lua

-- zil: 1actions.zil:3810  <ROUTINE I-FIGHT ("AUX" (FIGHT? <>) (LEN <GET ,VILLAINS 0>) CNT OO O P)>
ZG.actions:register("I_FIGHT", function()

    local FIGHT_p = false
    local LEN = ZG.GET(ZG.VILLAINS, 0)
    local CNT = 0
    local OO = 0
    local O = 0
    local P = 0
    if ZG._T(ZG.DEAD) then
        do return false end
    end
    CNT = 0
    while true do
        CNT = ZG.ADD(CNT, 1)
        if ZG.EQ(CNT, LEN) then
            break
        end
        OO = ZG.GET(ZG.VILLAINS, CNT)
        if (ZG._T(ZG.IN_p((function() O = ZG.GET(OO, ZG.V_VILLAIN); return O end)(), ZG.HERE)) and (not ZG._T(ZG.FSET_p(O, "INVISIBLE")))) then
            if (ZG.EQ(O, ZG.THIEF) and ZG._T(ZG.THIEF_ENGROSSED)) then
                ZG._set("THIEF_ENGROSSED", false)
            elseif ZG.LT(ZG.GETP(O, "STRENGTH"), 0) then
                P = ZG.GET(OO, ZG.V_PROB)
                if ((not ZG.ZERO_p(P)) and ZG._T(ZG.PROB_1(P))) then
                    do local _ = ZG.PUT(OO, ZG.V_PROB, 0) end
                    do local _ = ZG.AWAKEN(O) end
                else
                    do local _ = ZG.PUT(OO, ZG.V_PROB, ZG.ADD(P, 25)) end
                end
            elseif (ZG._T(ZG.FSET_p(O, "FIGHTBIT")) or ZG._T(ZG.APPLY(ZG.GETP(O, "ACTION"), ZG.F_FIRST_p))) then
                FIGHT_p = true
            end
        else
            if ZG._T(ZG.FSET_p(O, "FIGHTBIT")) then
                do local _ = ZG.APPLY(ZG.GETP(O, "ACTION"), ZG.F_BUSY_p) end
            end
            if ZG.EQ(O, ZG.THIEF) then
                ZG._set("THIEF_ENGROSSED", false)
            end
            do local _ = ZG.FCLEAR(ZG.WINNER, "STAGGERED") end
            do local _ = ZG.FCLEAR(O, "STAGGERED") end
            do local _ = ZG.FCLEAR(O, "FIGHTBIT") end
            do local _ = ZG.AWAKEN(O) end
        end
    end
    if (not ZG._T(FIGHT_p)) then
        do return false end
    end
    do return ZG.DO_FIGHT(LEN) end

end, "I-FIGHT")

ZG.I_FIGHT = ZG.actions:get("I_FIGHT")

-- zil: 1actions.zil:3843  <ROUTINE AWAKEN (O "AUX" (S <GETP .O ,P?STRENGTH>))>
ZG.actions:register("AWAKEN", function(O)

    local S = ZG.GETP(O, "STRENGTH")
    if ZG.LT(S, 0) then
        do local _ = ZG.PUTP(O, "STRENGTH", ZG.SUB(0, S)) end
        do local _ = ZG.APPLY(ZG.GETP(O, "ACTION"), ZG.F_CONSCIOUS) end
    end
    do return true end

end, "AWAKEN")

ZG.AWAKEN = ZG.actions:get("AWAKEN")

-- zil: 1actions.zil:3851  <ROUTINE I-SWORD ("AUX" (DEM <INT I-SWORD>) (G <GETP ,SWORD ,P?TVALUE>) (NG 0...
ZG.actions:register("I_SWORD", function()

    local DEM = ZG.INT(ZG.I_SWORD)
    local G = ZG.GETP(ZG.SWORD, "TVALUE")
    local NG = 0
    local P = 0
    local T = 0
    local L = 0
    if ZG._T(ZG.IN_p(ZG.SWORD, ZG.ADVENTURER)) then
        if ZG._T(ZG.INFESTED_p(ZG.HERE)) then
            NG = 2
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
        if ZG.EQ(NG, G) then
            do return false end
        elseif ZG.EQ(NG, 2) then
            do local _ = ZG.TELL("Your sword has begun to glow very brightly.", ZG._TK.CR) end
        elseif (NG == 1) then
            do local _ = ZG.TELL("Your sword is glowing with a faint blue glow.", ZG._TK.CR) end
        elseif ZG.ZERO_p(NG) then
            do local _ = ZG.TELL("Your sword is no longer glowing.", ZG._TK.CR) end
        end
        do local _ = ZG.PUTP(ZG.SWORD, "TVALUE", NG) end
        do return true end
    else
        do local _ = ZG.PUT(DEM, ZG.C_ENABLED_p, 0) end
        do return false end
    end

end, "I-SWORD")

ZG.I_SWORD = ZG.actions:get("I_SWORD")

-- zil: 1actions.zil:3881  <ROUTINE INFESTED? (R "AUX" (F <FIRST? .R>))>
ZG.actions:register("INFESTED_p", function(R)

    local F = ZG.FIRST_p(R)
    while true do
        if (not ZG._T(F)) then
            do return false end
        elseif (ZG._T(ZG.FSET_p(F, "ACTORBIT")) and (not ZG._T(ZG.FSET_p(F, "INVISIBLE")))) then
            do return true end
        elseif (not ZG._T((function() F = ZG.NEXT_p(F); return F end)())) then
            do return false end
        end
    end

end, "INFESTED?")

ZG.INFESTED_p = ZG.actions:get("INFESTED_p")

-- zil: 1actions.zil:3890  <ROUTINE I-THIEF ("AUX" (RM <LOC ,THIEF>) ROBJ HERE? (ONCE <>) (FLG <>))>
ZG.actions:register("I_THIEF", function()

    local _tmp1
    local RM = ZG.LOC(ZG.THIEF)
    local ROBJ = 0
    local HERE_p = 0
    local ONCE = false
    local FLG = false
    while true do
        local _brk1 = false
        repeat
            if ZG._T((function() HERE_p = (not ZG._T(ZG.FSET_p(ZG.THIEF, "INVISIBLE"))); return HERE_p end)()) then
                RM = ZG.LOC(ZG.THIEF)
            end
            if (ZG.EQ(RM, ZG.TREASURE_ROOM) and (not ZG.EQ(RM, ZG.HERE))) then
                if ZG._T(HERE_p) then
                    do local _ = ZG.HACK_TREASURES() end
                    HERE_p = false
                end
                do local _ = ZG.DEPOSIT_BOOTY(ZG.TREASURE_ROOM) end
            elseif (ZG.EQ(RM, ZG.HERE) and (not ZG._T(ZG.FSET_p(RM, "ONBIT"))) and (not ZG._T(ZG.IN_p(ZG.TROLL, ZG.HERE)))) then
                if ZG._T(ZG.THIEF_VS_ADVENTURER(HERE_p)) then
                    do return true end
                end
                if ZG._T(ZG.FSET_p(ZG.THIEF, "INVISIBLE")) then
                    HERE_p = false
                end
            else
                if (ZG._T(ZG.IN_p(ZG.THIEF, RM)) and (not ZG._T(ZG.FSET_p(ZG.THIEF, "INVISIBLE")))) then
                    do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
                    HERE_p = false
                end
                if ZG._T(ZG.FSET_p(RM, "TOUCHBIT")) then
                    do local _ = ZG.ROB(RM, ZG.THIEF, 75) end
                    if (ZG._T(ZG.FSET_p(RM, "MAZEBIT")) and ZG._T(ZG.FSET_p(ZG.HERE, "MAZEBIT"))) then
                        _tmp1 = ZG.ROB_MAZE(RM)
                    else
                        _tmp1 = ZG.STEAL_JUNK(RM)
                    end
                    FLG = _tmp1
                end
            end
            if (ZG._T((function() ONCE = (not ZG._T(ONCE)); return ONCE end)()) and (not ZG._T(HERE_p))) then
                do local _ = ZG.RECOVER_STILETTO() end
                while true do
                    if (ZG._T(RM) and ZG._T((function() RM = ZG.NEXT_p(RM); return RM end)())) then
                    else
                        RM = ZG.FIRST_p(ZG.ROOMS)
                    end
                    if ((not ZG._T(ZG.FSET_p(RM, "SACREDBIT"))) and ZG._T(ZG.FSET_p(RM, "RLANDBIT"))) then
                        do local _ = ZG.MOVE(ZG.THIEF, RM) end
                        do local _ = ZG.FCLEAR(ZG.THIEF, "FIGHTBIT") end
                        do local _ = ZG.FSET(ZG.THIEF, "INVISIBLE") end
                        ZG._set("THIEF_HERE", false)
                        break
                    end
                end
                break
            end
            _brk1 = true
            break
        until true
        if _brk1 then break end
    end
    if (not ZG.EQ(RM, ZG.TREASURE_ROOM)) then
        do local _ = ZG.DROP_JUNK(RM) end
    end
    do return FLG end

end, "I-THIEF")

ZG.I_THIEF = ZG.actions:get("I_THIEF")

-- zil: 1actions.zil:3933  <ROUTINE DROP-JUNK (RM "AUX" X N (FLG <>))>
ZG.actions:register("DROP_JUNK", function(RM)

    local X = 0
    local N = 0
    local FLG = false
    X = ZG.FIRST_p(ZG.THIEF)
    while true do
        if (not ZG._T(X)) then
            do return FLG end
        end
        N = ZG.NEXT_p(X)
        if ZG.EQUAL_p(X, ZG.STILETTO, ZG.LARGE_BAG) then
        elseif (ZG.ZERO_p(ZG.GETP(X, "TVALUE")) and ZG._T(ZG.PROB_2(30, true))) then
            do local _ = ZG.FCLEAR(X, "INVISIBLE") end
            do local _ = ZG.MOVE(X, RM) end
            if ((not ZG._T(FLG)) and ZG.EQ(RM, ZG.HERE)) then
                do local _ = ZG.TELL("The robber, rummaging through his bag, dropped a few items he found\nvalueless.", ZG._TK.CR) end
                FLG = true
            end
        end
        X = N
    end

end, "DROP-JUNK")

ZG.DROP_JUNK = ZG.actions:get("DROP_JUNK")

-- zil: 1actions.zil:3949  <ROUTINE RECOVER-STILETTO ()>
ZG.actions:register("RECOVER_STILETTO", function()

    if ZG._T(ZG.IN_p(ZG.STILETTO, ZG.LOC(ZG.THIEF))) then
        do local _ = ZG.FSET(ZG.STILETTO, "NDESCBIT") end
        do return ZG.MOVE(ZG.STILETTO, ZG.THIEF) end
    else
        do return false end
    end

end, "RECOVER-STILETTO")

ZG.RECOVER_STILETTO = ZG.actions:get("RECOVER_STILETTO")

-- zil: 1actions.zil:3954  <ROUTINE STEAL-JUNK (RM "AUX" X N)>
ZG.actions:register("STEAL_JUNK", function(RM)

    local X = 0
    local N = 0
    X = ZG.FIRST_p(RM)
    while true do
        if (not ZG._T(X)) then
            do return false end
        end
        N = ZG.NEXT_p(X)
        if (ZG.ZERO_p(ZG.GETP(X, "TVALUE")) and ZG._T(ZG.FSET_p(X, "TAKEBIT")) and (not ZG._T(ZG.FSET_p(X, "SACREDBIT"))) and (not ZG._T(ZG.FSET_p(X, "INVISIBLE"))) and (ZG.EQ(X, ZG.STILETTO) or ZG._T(ZG.PROB_2(10, true)))) then
            do local _ = ZG.MOVE(X, ZG.THIEF) end
            do local _ = ZG.FSET(X, "TOUCHBIT") end
            do local _ = ZG.FSET(X, "INVISIBLE") end
            if ZG.EQ(X, ZG.ROPE) then
                ZG._set("DOME_FLAG", false)
            end
            if ZG.EQ(RM, ZG.HERE) then
                do local _ = ZG.TELL("You suddenly notice that the ", ZG._TK.D, X, " vanished.", ZG._TK.CR) end
                do return true end
            else
                do return false end
            end
        end
        X = N
    end

end, "STEAL-JUNK")

ZG.STEAL_JUNK = ZG.actions:get("STEAL_JUNK")

-- zil: 1actions.zil:3976  <ROUTINE ROB (WHAT WHERE "OPTIONAL" (PROB <>) "AUX" N X (ROBBED? <>))>
ZG.actions:register("ROB", function(WHAT, WHERE, PROB)

    if PROB == nil then PROB = false end
    local N = 0
    local X = 0
    local ROBBED_p = false
    X = ZG.FIRST_p(WHAT)
    while true do
        if (not ZG._T(X)) then
            do return ROBBED_p end
        end
        N = ZG.NEXT_p(X)
        if ((not ZG._T(ZG.FSET_p(X, "INVISIBLE"))) and (not ZG._T(ZG.FSET_p(X, "SACREDBIT"))) and ZG.LT(0, ZG.GETP(X, "TVALUE")) and ((not ZG._T(PROB)) or ZG._T(ZG.PROB_1(PROB)))) then
            do local _ = ZG.MOVE(X, WHERE) end
            do local _ = ZG.FSET(X, "TOUCHBIT") end
            if ZG.EQ(WHERE, ZG.THIEF) then
                do local _ = ZG.FSET(X, "INVISIBLE") end
            end
            ROBBED_p = true
        end
        X = N
    end

end, "ROB")

ZG.ROB = ZG.actions:get("ROB")

-- ;"special-cased routines"

-- zil: 1actions.zil:3993  <ROUTINE V-DIAGNOSE ("AUX" (MS <FIGHT-STRENGTH <>>) (WD <GETP ,WINNER ,P?STRE...
ZG.actions:register("V_DIAGNOSE", function()

    local MS = ZG.FIGHT_STRENGTH(false)
    local WD = ZG.GETP(ZG.WINNER, "STRENGTH")
    local RS = ZG.ADD(MS, WD)
    if ZG.ZERO_p(ZG.GET(ZG.INT(ZG.I_CURE), ZG.C_ENABLED_p)) then
        WD = 0
    else
        WD = ZG.NEG(WD)
    end
    if ZG.ZERO_p(WD) then
        do local _ = ZG.TELL("You are in perfect health.") end
    else
        do local _ = ZG.TELL("You have ") end
        if (WD == 1) then
            do local _ = ZG.TELL("a light wound,") end
        elseif ZG.EQ(WD, 2) then
            do local _ = ZG.TELL("a serious wound,") end
        elseif ZG.EQ(WD, 3) then
            do local _ = ZG.TELL("several wounds,") end
        elseif ZG.LT(3, WD) then
            do local _ = ZG.TELL("serious wounds,") end
        end
    end
    if (not ZG.ZERO_p(WD)) then
        do local _ = ZG.TELL(" which will be cured after ") end
        do local _ = ZG.PRINTN(ZG.ADD((ZG.CURE_WAIT * ZG.SUB(WD, 1)), ZG.GET(ZG.INT(ZG.I_CURE), ZG.C_TICK))) end
        do local _ = ZG.TELL(" moves.") end
    end
    do local _ = ZG.CRLF() end
    do local _ = ZG.TELL("You can ") end
    if ZG.ZERO_p(RS) then
        do local _ = ZG.TELL("expect death soon") end
    elseif (RS == 1) then
        do local _ = ZG.TELL("be killed by one more light wound") end
    elseif ZG.EQ(RS, 2) then
        do local _ = ZG.TELL("be killed by a serious wound") end
    elseif ZG.EQ(RS, 3) then
        do local _ = ZG.TELL("survive one serious wound") end
    elseif ZG.LT(3, RS) then
        do local _ = ZG.TELL("survive several wounds") end
    end
    do local _ = ZG.TELL(".", ZG._TK.CR) end
    if (not ZG.ZERO_p(ZG.DEATHS)) then
        do local _ = ZG.TELL("You have been killed ") end
        if (ZG.DEATHS == 1) then
            do local _ = ZG.TELL("once") end
        else
            do local _ = ZG.TELL("twice") end
        end
        do return ZG.TELL(".", ZG._TK.CR) end
    else
        do return false end
    end

end, "V-DIAGNOSE")

ZG.V_DIAGNOSE = ZG.actions:get("V_DIAGNOSE")

-- zil: 1actions.zil:4026  <ROUTINE V-SCORE ("OPTIONAL" (ASK? T))>
ZG.actions:register("V_SCORE", function(ASK_p)

    if ASK_p == nil then ASK_p = true end
    do local _ = ZG.TELL("Your score is ") end
    do local _ = ZG.TELL(ZG._TK.N, ZG.SCORE) end
    do local _ = ZG.TELL(" (total of 350 points), in ") end
    do local _ = ZG.TELL(ZG._TK.N, ZG.MOVES) end
    if (ZG.MOVES == 1) then
        do local _ = ZG.TELL(" move.") end
    else
        do local _ = ZG.TELL(" moves.") end
    end
    do local _ = ZG.CRLF() end
    do local _ = ZG.TELL("This gives you the rank of ") end
    if ZG.EQ(ZG.SCORE, 350) then
        do local _ = ZG.TELL("Master Adventurer") end
    elseif ZG.LT(330, ZG.SCORE) then
        do local _ = ZG.TELL("Wizard") end
    elseif ZG.LT(300, ZG.SCORE) then
        do local _ = ZG.TELL("Master") end
    elseif ZG.LT(200, ZG.SCORE) then
        do local _ = ZG.TELL("Adventurer") end
    elseif ZG.LT(100, ZG.SCORE) then
        do local _ = ZG.TELL("Junior Adventurer") end
    elseif ZG.LT(50, ZG.SCORE) then
        do local _ = ZG.TELL("Novice Adventurer") end
    elseif ZG.LT(25, ZG.SCORE) then
        do local _ = ZG.TELL("Amateur Adventurer") end
    else
        do local _ = ZG.TELL("Beginner") end
    end
    do local _ = ZG.TELL(".", ZG._TK.CR) end
    do return ZG.SCORE end

end, "V-SCORE")

ZG.V_SCORE = ZG.actions:get("V_SCORE")

-- zil: 1actions.zil:4046  <ROUTINE JIGS-UP (DESC "OPTIONAL" (PLAYER? <>))>
ZG.actions:register("JIGS_UP", function(DESC, PLAYER_p)

    if PLAYER_p == nil then PLAYER_p = false end
    ZG._set("WINNER", ZG.ADVENTURER)
    if ZG._T(ZG.DEAD) then
        do local _ = ZG.TELL("\nIt takes a talented person to be killed while already dead. YOU are such\na talent. Unfortunately, it takes a talented person to deal with it.\nI am not such a talent. Sorry.", ZG._TK.CR) end
        do local _ = ZG.FINISH() end
    end
    do local _ = ZG.TELL(DESC, ZG._TK.CR) end
    if (not ZG._T(ZG.LUCKY)) then
        do local _ = ZG.TELL("Bad luck, huh?", ZG._TK.CR) end
    end
    while true do
        do local _ = ZG.SCORE_UPD(-10) end
        do local _ = ZG.TELL("\n\n    ****  You have died  ****\n\n\n") end
        if ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT")) then
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
        end
        if (not ZG.LT(ZG.DEATHS, 2)) then
            do local _ = ZG.TELL("You clearly are a suicidal maniac.  We don't allow psychotics in the\ncave, since they may harm other adventurers.  Your remains will be\ninstalled in the Land of the Living Dead, where your fellow\nadventurers may gloat over them.", ZG._TK.CR) end
            do return ZG.FINISH() end
        else
            ZG._set("DEATHS", ZG.ADD(ZG.DEATHS, 1))
            do local _ = ZG.MOVE(ZG.WINNER, ZG.HERE) end
            if ZG._T(ZG.FSET_p(ZG.SOUTH_TEMPLE, "TOUCHBIT")) then
                do local _ = ZG.TELL("As you take your last breath, you feel relieved of your burdens. The\nfeeling passes as you find yourself before the gates of Hell, where\nthe spirits jeer at you and deny you entry.  Your senses are\ndisturbed.  The objects in the dungeon appear indistinct, bleached of\ncolor, even unreal.", ZG._TK.CR, ZG._TK.CR) end
                ZG._set("DEAD", true)
                ZG._set("TROLL_FLAG", true)
                ZG._set("ALWAYS_LIT", true)
                do local _ = ZG.PUTP(ZG.WINNER, "ACTION", ZG.DEAD_FUNCTION) end
                do local _ = ZG.GOTO(ZG.ENTRANCE_TO_HADES) end
            else
                do local _ = ZG.TELL("Now, let's take a look here...\nWell, you probably deserve another chance.  I can't quite fix you\nup completely, but you can't have everything.", ZG._TK.CR, ZG._TK.CR) end
                do local _ = ZG.GOTO(ZG.FOREST_1) end
            end
            do local _ = ZG.FCLEAR(ZG.TRAP_DOOR, "TOUCHBIT") end
            ZG._set("P_CONT", false)
            do local _ = ZG.RANDOMIZE_OBJECTS() end
            do local _ = ZG.KILL_INTERRUPTS() end
            do return 2 end
        end
        break
    end

end, "JIGS-UP")

ZG.JIGS_UP = ZG.actions:get("JIGS_UP")

-- zil: 1actions.zil:4101  <ROUTINE RANDOMIZE-OBJECTS ("AUX" (R <>) F N L)>
ZG.actions:register("RANDOMIZE_OBJECTS", function()

    local R = false
    local F = 0
    local N = 0
    local L = 0
    if ZG._T(ZG.IN_p(ZG.LAMP, ZG.WINNER)) then
        do local _ = ZG.MOVE(ZG.LAMP, ZG.LIVING_ROOM) end
    end
    if ZG._T(ZG.IN_p(ZG.COFFIN, ZG.WINNER)) then
        do local _ = ZG.MOVE(ZG.COFFIN, ZG.EGYPT_ROOM) end
    end
    do local _ = ZG.PUTP(ZG.SWORD, "TVALUE", 0) end
    N = ZG.FIRST_p(ZG.WINNER)
    L = ZG.GET(ZG.ABOVE_GROUND, 0)
    while true do
        F = N
        if (not ZG._T(F)) then
            do return true end
        end
        N = ZG.NEXT_p(F)
        if ZG.LT(0, ZG.GETP(F, "TVALUE")) then
            while true do
                if (not ZG._T(R)) then
                    R = ZG.FIRST_p(ZG.ROOMS)
                end
                if (ZG._T(ZG.FSET_p(R, "RLANDBIT")) and (not ZG._T(ZG.FSET_p(R, "ONBIT"))) and ZG._T(ZG.PROB_1(50))) then
                    do local _ = ZG.MOVE(F, R) end
                    break
                else
                    R = ZG.NEXT_p(R)
                end
            end
        else
            do local _ = ZG.MOVE(F, ZG.GET(ZG.ABOVE_GROUND, ZG.RANDOM(L))) end
        end
    end

end, "RANDOMIZE-OBJECTS")

ZG.RANDOMIZE_OBJECTS = ZG.actions:get("RANDOMIZE_OBJECTS")

-- zil: 1actions.zil:4125  <ROUTINE KILL-INTERRUPTS ()>
ZG.actions:register("KILL_INTERRUPTS", function()

    do local _ = ZG.DISABLE(ZG.INT(ZG.I_XB)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_XC)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_CYCLOPS)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_LANTERN)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_CANDLES)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_SWORD)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_FOREST_ROOM)) end
    do local _ = ZG.DISABLE(ZG.INT(ZG.I_MATCH)) end
    do local _ = ZG.FCLEAR(ZG.MATCH, "ONBIT") end
    do return true end

end, "KILL-INTERRUPTS")

ZG.KILL_INTERRUPTS = ZG.actions:get("KILL_INTERRUPTS")

-- zil: 1actions.zil:4137  <ROUTINE BAG-OF-COINS-F ()>
ZG.actions:register("BAG_OF_COINS_F", function()

    do return ZG.STUPID_CONTAINER(ZG.BAG_OF_COINS, "coins") end

end, "BAG-OF-COINS-F")

ZG.BAG_OF_COINS_F = ZG.actions:get("BAG_OF_COINS_F")

-- zil: 1actions.zil:4140  <ROUTINE TRUNK-F ()>
ZG.actions:register("TRUNK_F", function()

    do return ZG.STUPID_CONTAINER(ZG.TRUNK, "jewels") end

end, "TRUNK-F")

ZG.TRUNK_F = ZG.actions:get("TRUNK_F")

-- zil: 1actions.zil:4143  <ROUTINE STUPID-CONTAINER (OBJ STR)>
ZG.actions:register("STUPID_CONTAINER", function(OBJ, STR)

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE")) then
        do return ZG.TELL("The ", STR, " are safely inside; there's no need to do that.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("LOOK-INSIDE", "EXAMINE")) then
        do return ZG.TELL("There are lots of ", STR, " in there.", ZG._TK.CR) end
    elseif (ZG._T(ZG.VERB_p("PUT")) and ZG.EQ(ZG.PRSI, OBJ)) then
        do return ZG.TELL("Don't be silly. It wouldn't be a ", ZG._TK.D, OBJ, " anymore.", ZG._TK.CR) end
    else
        do return false end
    end

end, "STUPID-CONTAINER")

ZG.STUPID_CONTAINER = ZG.actions:get("STUPID_CONTAINER")

-- zil: 1actions.zil:4154  <ROUTINE DUMB-CONTAINER ()>
ZG.actions:register("DUMB_CONTAINER", function()

    if ZG._T(ZG.VERB_p("OPEN", "CLOSE", "LOOK-INSIDE")) then
        do return ZG.TELL("You can't do that.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("It looks pretty much like a ", ZG._TK.D, ZG.PRSO, ".", ZG._TK.CR) end
    else
        do return false end
    end

end, "DUMB-CONTAINER")

ZG.DUMB_CONTAINER = ZG.actions:get("DUMB_CONTAINER")

-- zil: 1actions.zil:4160  <ROUTINE GARLIC-F ()>
ZG.actions:register("GARLIC_F", function()

    if ZG._T(ZG.VERB_p("EAT")) then
        do local _ = ZG.REMOVE_CAREFULLY(ZG.PRSO) end
        do return ZG.TELL("What the heck! You won't make friends this way, but nobody around\nhere is too friendly anyhow. Gulp!", ZG._TK.CR) end
    else
        do return false end
    end

end, "GARLIC-F")

ZG.GARLIC_F = ZG.actions:get("GARLIC_F")

-- zil: 1actions.zil:4167  <ROUTINE CHAIN-PSEUDO ()>
ZG.actions:register("CHAIN_PSEUDO", function()

    if ZG._T(ZG.VERB_p("TAKE", "MOVE")) then
        do return ZG.TELL("The chain is secure.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("RAISE", "LOWER")) then
        do return ZG.TELL("Perhaps you should do that to the basket.", ZG._TK.CR) end
    elseif ZG._T(ZG.VERB_p("EXAMINE")) then
        do return ZG.TELL("The chain secures a basket within the shaft.", ZG._TK.CR) end
    else
        do return false end
    end

end, "CHAIN-PSEUDO")

ZG.CHAIN_PSEUDO = ZG.actions:get("CHAIN_PSEUDO")

-- zil: 1actions.zil:4175  <ROUTINE TROLL-ROOM-F (RARG)>
ZG.actions:register("TROLL_ROOM_F", function(RARG)

    if (ZG.EQ(RARG, ZG.M_ENTER) and ZG._T(ZG.IN_p(ZG.TROLL, ZG.HERE))) then
        do return ZG.THIS_IS_IT(ZG.TROLL) end
    else
        do return false end
    end

end, "TROLL-ROOM-F")

ZG.TROLL_ROOM_F = ZG.actions:get("TROLL_ROOM_F")
