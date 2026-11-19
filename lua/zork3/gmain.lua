-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: gmain.zil:5  <CONSTANT SERIAL>
-- SERIAL is declared in ZilGlobal.lua

-- zil: gmain.zil:7  <GLOBAL PLAYER>
-- PLAYER is declared in ZilGlobal.lua

-- zil: gmain.zil:9  <GLOBAL P-WON>
-- P_WON is declared in ZilGlobal.lua

-- zil: gmain.zil:11  <CONSTANT M-FATAL>
-- M_FATAL is declared in ZilGlobal.lua

-- zil: gmain.zil:13  <CONSTANT M-HANDLED>
-- M_HANDLED is declared in ZilGlobal.lua

-- zil: gmain.zil:15  <CONSTANT M-NOT-HANDLED>
-- M_NOT_HANDLED is declared in ZilGlobal.lua

-- zil: gmain.zil:17  <CONSTANT M-OBJECT>
-- M_OBJECT is declared in ZilGlobal.lua

-- zil: gmain.zil:19  <CONSTANT M-BEG>
-- M_BEG is declared in ZilGlobal.lua

-- zil: gmain.zil:21  <CONSTANT M-END>
-- M_END is declared in ZilGlobal.lua

-- zil: gmain.zil:23  <CONSTANT M-ENTER>
-- M_ENTER is declared in ZilGlobal.lua

-- zil: gmain.zil:25  <CONSTANT M-LOOK>
-- M_LOOK is declared in ZilGlobal.lua

-- zil: gmain.zil:27  <CONSTANT M-FLASH>
-- M_FLASH is declared in ZilGlobal.lua

-- zil: gmain.zil:29  <CONSTANT M-OBJDESC>
-- M_OBJDESC is declared in ZilGlobal.lua

-- ;"GO now lives in SPECIAL.ZIL"

-- zil: gmain.zil:34  <ROUTINE MAIN-LOOP ("AUX" TRASH)>
ZG.actions:register("MAIN_LOOP", function()

    local TRASH = 0
    while true do
        TRASH = ZG.MAIN_LOOP_1()
    end

end, "MAIN-LOOP")

ZG.MAIN_LOOP = ZG.actions:get("MAIN_LOOP")

-- zil: gmain.zil:38  <ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP O I)>
ZG.actions:register("MAIN_LOOP_1", function()

    local _tmp1, _tmp2, _tmp3
    local ICNT = 0
    local OCNT = 0
    local NUM = 0
    local CNT = 0
    local OBJ = 0
    local TBL = 0
    local V = 0
    local PTBL = 0
    local OBJ1 = 0
    local TMP = 0
    local O = 0
    local I = 0
    CNT = 0
    OBJ = false
    PTBL = true
    if ZG._T(ZG._set("P_WON", ZG.PARSER())) then
        ICNT = ZG.GET(ZG.P_PRSI, ZG.P_MATCHLEN)
        OCNT = ZG.GET(ZG.P_PRSO, ZG.P_MATCHLEN)
        if (ZG._T(ZG.P_IT_OBJECT) and ZG._T(ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT))) then
            TMP = false
            while true do
                if ZG.LT(ICNT, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
                    break
                else
                    if ZG.EQ(ZG.GET(ZG.P_PRSI, CNT), ZG.IT) then
                        do local _ = ZG.PUT(ZG.P_PRSI, CNT, ZG.P_IT_OBJECT) end
                        TMP = true
                        break
                    end
                end
            end
            if (not ZG._T(TMP)) then
                CNT = 0
                while true do
                    if ZG.LT(OCNT, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
                        break
                    else
                        if ZG.EQ(ZG.GET(ZG.P_PRSO, CNT), ZG.IT) then
                            do local _ = ZG.PUT(ZG.P_PRSO, CNT, ZG.P_IT_OBJECT) end
                            break
                        end
                    end
                end
            end
            CNT = 0
        end
        if ZG.ZERO_p(OCNT) then
            _tmp1 = OCNT
        elseif ZG.LT(1, OCNT) then
            TBL = ZG.P_PRSO
            if ZG.ZERO_p(ICNT) then
                OBJ = false
            else
                OBJ = ZG.GET(ZG.P_PRSI, 1)
            end
            _tmp1 = OCNT
        elseif ZG.LT(1, ICNT) then
            PTBL = false
            TBL = ZG.P_PRSI
            OBJ = ZG.GET(ZG.P_PRSO, 1)
            _tmp1 = ICNT
        else
            _tmp1 = 1
        end
        NUM = _tmp1
        if ((not ZG._T(OBJ)) and (ICNT == 1)) then
            OBJ = ZG.GET(ZG.P_PRSI, 1)
        end
        if (ZG.EQ(ZG.PRSA, ZG.SYMBOL("V?WALK")) and (not ZG.ZERO_p(ZG.P_WALK_DIR))) then
            V = ZG.PERFORM(ZG.PRSA, ZG.PRSO)
        elseif ZG.ZERO_p(NUM) then
            if ZG.ZERO_p(ZG.BAND(ZG.GETB(ZG.P_SYNTAX, ZG.P_SBITS), ZG.P_SONUMS)) then
                V = ZG.PERFORM(ZG.PRSA)
                ZG._set("PRSO", false)
            elseif (not ZG._T(ZG.LIT)) then
                do local _ = ZG.TELL("It's too dark to see.", ZG._TK.CR) end
            else
                do local _ = ZG.TELL("It's not clear what you're referring to.", ZG._TK.CR) end
                V = false
            end
        else
            ZG._set("P_NOT_HERE", 0)
            ZG._set("P_MULT", false)
            if ZG.LT(1, NUM) then
                ZG._set("P_MULT", true)
            end
            TMP = false
            while true do
                local _brk1 = false
                repeat
                    if ZG.LT(NUM, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
                        if ZG.LT(0, ZG.P_NOT_HERE) then
                            do local _ = ZG.TELL("The ") end
                            if (not ZG.EQ(ZG.P_NOT_HERE, NUM)) then
                                do local _ = ZG.TELL("other ") end
                            end
                            do local _ = ZG.TELL("object") end
                            if (not ZG.EQ(ZG.P_NOT_HERE, 1)) then
                                do local _ = ZG.TELL("s") end
                            end
                            do local _ = ZG.TELL(" that you mentioned ") end
                            if (not ZG.EQ(ZG.P_NOT_HERE, 1)) then
                                do local _ = ZG.TELL("are") end
                            else
                                do local _ = ZG.TELL("is") end
                            end
                            do local _ = ZG.TELL("n't here.", ZG._TK.CR) end
                        elseif (not ZG._T(TMP)) then
                            do local _ = ZG.TELL("There's nothing here you can take.", ZG._TK.CR) end
                        end
                        _brk1 = true
                        break
                    else
                        if ZG._T(PTBL) then
                            OBJ1 = ZG.GET(ZG.P_PRSO, CNT)
                        else
                            OBJ1 = ZG.GET(ZG.P_PRSI, CNT)
                        end
                        if ZG._T(PTBL) then
                            _tmp2 = OBJ1
                        else
                            _tmp2 = OBJ
                        end
                        O = _tmp2
                        if ZG._T(PTBL) then
                            _tmp3 = OBJ
                        else
                            _tmp3 = OBJ1
                        end
                        I = _tmp3
                        if (ZG.LT(1, NUM) or ZG.EQ(ZG.GET(ZG.GET(ZG.P_ITBL, ZG.P_NC1), 0), ZG.WORD("all"))) then
                            V = ZG.LOC(ZG.WINNER)
                            if ZG.EQ(O, ZG.NOT_HERE_OBJECT) then
                                ZG._set("P_NOT_HERE", ZG.ADD(ZG.P_NOT_HERE, 1))
                                break
                            elseif (ZG._T(ZG.VERB_p("TAKE")) and ZG._T(I) and ZG.EQ(ZG.GET(ZG.GET(ZG.P_ITBL, ZG.P_NC1), 0), ZG.WORD("all")) and (not ZG._T(ZG.IN_p(O, I)))) then
                                break
                            elseif (ZG.EQ(ZG.P_GETFLAGS, ZG.P_ALL) and ZG._T(ZG.VERB_p("TAKE")) and (((not ZG.EQUAL_p(ZG.LOC(O), ZG.WINNER, ZG.HERE, V)) and (not ZG.EQ(ZG.LOC(O), I)) and (not ZG._T(ZG.FSET_p(ZG.LOC(O), "SURFACEBIT")))) or (not (ZG._T(ZG.FSET_p(O, "TAKEBIT")) or ZG._T(ZG.FSET_p(O, "TRYTAKEBIT")))))) then
                                break
                            else
                                if ZG.EQ(OBJ1, ZG.IT) then
                                    do local _ = ZG.PRINTD(ZG.P_IT_OBJECT) end
                                else
                                    do local _ = ZG.PRINTD(OBJ1) end
                                end
                                do local _ = ZG.TELL(": ") end
                            end
                        end
                        ZG._set("PRSO", O)
                        ZG._set("PRSI", I)
                        TMP = true
                        V = ZG.PERFORM(ZG.PRSA, ZG.PRSO, ZG.PRSI)
                        if ZG.EQ(V, ZG.M_FATAL) then
                            _brk1 = true
                            break
                        end
                    end
                until true
                if _brk1 then break end
            end
        end
        if (not ZG.EQ(V, ZG.M_FATAL)) then
            V = ZG.APPLY(ZG.GETP(ZG.LOC(ZG.WINNER), "ACTION"), ZG.M_END)
        end
        if ZG.EQ(V, ZG.M_FATAL) then
            ZG._set("P_CONT", false)
        end
    else
        ZG._set("P_CONT", false)
    end
    if (not ZG._T(ZG.CLEFT_QUEUED_p)) then
        do local _ = ZG.ENABLE(ZG.QUEUE(ZG.I_CLEFT, ZG.ADD(70, ZG.RANDOM(70)))) end
        ZG._set("CLEFT_QUEUED_p", true)
    end
    if ZG._T(ZG.P_WON) then
        if ZG._T(ZG.VERB_p("TELL", "BRIEF", "SUPER-BRIEF", "VERBOSE", "SAVE", "VERSION", "QUIT", "RESTART", "SCORE", "SCRIPT", "UNSCRIPT", "RESTORE")) then
            do return true end
        else
            V = ZG.CLOCKER()
            do return V end
        end
    else
        do return false end
    end

end, "MAIN-LOOP-1")

ZG.MAIN_LOOP_1 = ZG.actions:get("MAIN_LOOP_1")

-- zil: gmain.zil:174  <GLOBAL P-MULT>
-- P_MULT is declared in ZilGlobal.lua

-- zil: gmain.zil:176  <GLOBAL P-NOT-HERE>
-- P_NOT_HERE is declared in ZilGlobal.lua

while true do

    ZG._set("DEBUG", false)
    ZG.actions:register("PERFORM", function(A, O, I)
        if O == nil then O = false end
        if I == nil then I = false end
        local V = 0
        local OA = 0
        local OO = 0
        local OI = 0
        if ZG._T(ZG.DEBUG) then
            do local _ = ZG.TELL("** PERFORM: PRSA = ") end
            do local _ = ZG.PRINC(ZG.NTH(ZG.ACTIONS, ZG.ADD((A * 2), 1))) end
            if (ZG._T(O) and (not ZG.EQ(A, ZG.SYMBOL("V?WALK")))) then
                do local _ = ZG.TELL(" \n PRSO = ", ZG._TK.D, O) end
            end
            if ZG._T(I) then
                do local _ = ZG.TELL(" \n PRSI = ", ZG._TK.D, I) end
            end
        end
        OA = ZG.PRSA
        OO = ZG.PRSO
        OI = ZG.PRSI
        if (ZG.EQUAL_p(ZG.IT, I, O) and (not ZG._T(ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT)))) then
            do local _ = ZG.TELL("I don't see what you are referring to.", ZG._TK.CR) end
            do return 2 end
        end
        if ZG.EQ(O, ZG.IT) then
            O = ZG.P_IT_OBJECT
        end
        if ZG.EQ(I, ZG.IT) then
            I = ZG.P_IT_OBJECT
        end
        ZG._set("PRSA", A)
        ZG._set("PRSO", O)
        if (ZG._T(ZG.PRSO) and (not ZG._T(ZG.VERB_p("WALK")))) then
            ZG._set("P_IT_OBJECT", ZG.PRSO)
        end
        ZG._set("PRSI", I)
        if (ZG.EQUAL_p(ZG.NOT_HERE_OBJECT, ZG.PRSO, ZG.PRSI) and ZG._T((function() V = ZG.D_APPLY("Not Here", ZG.NOT_HERE_OBJECT_F); return V end)())) then
        else
            O = ZG.PRSO
            I = ZG.PRSI
            if ZG._T((function() V = ZG.DD_APPLY("Actor", ZG.WINNER, ZG.GETP(ZG.WINNER, "ACTION")); return V end)()) then
            elseif ZG._T((function() V = ZG.D_APPLY("Room (M-BEG)", ZG.GETP(ZG.LOC(ZG.WINNER), "ACTION"), ZG.M_BEG); return V end)()) then
            elseif ZG._T((function() V = ZG.D_APPLY("Preaction", ZG.GET(ZG.PREACTIONS, A)); return V end)()) then
            elseif (ZG._T(I) and ZG._T((function() V = ZG.D_APPLY("PRSI", ZG.GETP(I, "ACTION")); return V end)())) then
            elseif (ZG._T(O) and (not ZG.EQ(A, ZG.SYMBOL("V?WALK"))) and ZG._T(ZG.LOC(O)) and ZG._T(ZG.GETP(ZG.LOC(O), "CONTFCN")) and ZG._T((function() V = ZG.DD_APPLY("Container", ZG.LOC(O), ZG.GETP(ZG.LOC(O), "CONTFCN")); return V end)())) then
            elseif (ZG._T(O) and (not ZG.EQ(A, ZG.SYMBOL("V?WALK"))) and ZG._T((function() V = ZG.D_APPLY("PRSO", ZG.GETP(O, "ACTION")); return V end)())) then
            elseif ZG._T((function() V = ZG.D_APPLY(false, ZG.GET(ZG.ACTIONS, A)); return V end)()) then
            end
        end
        ZG._set("PRSA", OA)
        ZG._set("PRSO", OO)
        ZG._set("PRSI", OI)
        do return V end
    end, "PERFORM")
    ZG.PERFORM = ZG.actions:get("PERFORM")
    ZG.actions:register("D_APPLY", function(STR, FCN, FOO)
        local _tmp1
        local RES = 0
        if (not ZG._T(FCN)) then
            do return false end
        else
            if ZG._T(ZG.DEBUG) then
                if (not ZG._T(STR)) then
                    do local _ = ZG.TELL(ZG._TK.CR, "  Default ->", ZG._TK.CR) end
                else
                    do local _ = ZG.TELL(ZG._TK.CR, "  ", STR, " -> ") end
                end
            end
            if (FOO ~= nil) then
                _tmp1 = ZG.APPLY(FCN, FOO)
            else
                _tmp1 = ZG.APPLY(FCN)
            end
            RES = _tmp1
            if (ZG._T(ZG.DEBUG) and ZG._T(STR)) then
                if ZG.EQ(RES, 2) then
                    do local _ = ZG.TELL("Fatal", ZG._TK.CR) end
                elseif (not ZG._T(RES)) then
                    do local _ = ZG.TELL("Not handled") end
                else
                    do local _ = ZG.TELL("Handled", ZG._TK.CR) end
                end
            end
            do return RES end
        end
    end, "D-APPLY")
    ZG.D_APPLY = ZG.actions:get("D_APPLY")
    ZG.actions:register("DD_APPLY", function(STR, OBJ, FCN, FOO)
        if FOO == nil then FOO = false end
        if ZG._T(ZG.DEBUG) then
            do local _ = ZG.TELL("[", ZG._TK.D, OBJ, "=]") end
        end
        do return ZG.D_APPLY(STR, FCN, FOO) end
    end, "DD-APPLY")
    ZG.DD_APPLY = ZG.actions:get("DD_APPLY")
    break

end
