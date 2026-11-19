-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- zil: gclock.zil:5  <CONSTANT C-TABLELEN>
-- C_TABLELEN is declared in ZilGlobal.lua

-- zil: gclock.zil:7  <GLOBAL C-TABLE>
-- C_TABLE is declared in ZilGlobal.lua

-- zil: gclock.zil:9  <GLOBAL C-DEMONS>
-- C_DEMONS is declared in ZilGlobal.lua

-- zil: gclock.zil:11  <GLOBAL C-INTS>
-- C_INTS is declared in ZilGlobal.lua

-- zil: gclock.zil:13  <CONSTANT C-INTLEN>
-- C_INTLEN is declared in ZilGlobal.lua

-- zil: gclock.zil:15  <CONSTANT C-ENABLED?>
-- C_ENABLED_p is declared in ZilGlobal.lua

-- zil: gclock.zil:17  <CONSTANT C-TICK>
-- C_TICK is declared in ZilGlobal.lua

-- zil: gclock.zil:19  <CONSTANT C-RTN>
-- C_RTN is declared in ZilGlobal.lua

-- zil: gclock.zil:21  <ROUTINE QUEUE (RTN TICK "AUX" CINT)>
ZG.actions:register("QUEUE", function(RTN, TICK)

    local CINT = 0
    do local _ = ZG.PUT((function() CINT = ZG.INT(RTN); return CINT end)(), ZG.C_TICK, TICK) end
    do return CINT end

end, "QUEUE")

ZG.QUEUE = ZG.actions:get("QUEUE")

-- zil: gclock.zil:26  <ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)>
ZG.actions:register("INT", function(RTN, DEMON, E, C, INT)

    if DEMON == nil then DEMON = false end
    E = ZG.REST(ZG.C_TABLE, ZG.C_TABLELEN)
    C = ZG.REST(ZG.C_TABLE, ZG.C_INTS)
    while true do
        if ZG.EQ(C, E) then
            ZG._set("C_INTS", ZG.SUB(ZG.C_INTS, ZG.C_INTLEN))
            do local _ = (ZG._T(DEMON) and ZG._set("C_DEMONS", ZG.SUB(ZG.C_DEMONS, ZG.C_INTLEN))) end
            INT = ZG.REST(ZG.C_TABLE, ZG.C_INTS)
            do local _ = ZG.PUT(INT, ZG.C_RTN, RTN) end
            do return INT end
        elseif ZG.EQ(ZG.GET(C, ZG.C_RTN), RTN) then
            do return C end
        end
        C = ZG.REST(C, ZG.C_INTLEN)
    end

end, "INT")

ZG.INT = ZG.actions:get("INT")

-- zil: gclock.zil:41  <GLOBAL CLOCK-WAIT>
-- CLOCK_WAIT is declared in ZilGlobal.lua

-- zil: gclock.zil:43  <ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))>
ZG.actions:register("CLOCKER", function()

    local _tmp1, _tmp2
    local C = 0
    local E = 0
    local TICK = 0
    local FLG = false
    if ZG._T(ZG.CLOCK_WAIT) then
        ZG._set("CLOCK_WAIT", false)
        do return false end
    end
    if ZG._T(ZG.P_WON) then
        _tmp1 = ZG.C_INTS
    else
        _tmp1 = ZG.C_DEMONS
    end
    if ZG._T(ZG.P_WON) then
        _tmp2 = ZG.C_INTS
    else
        _tmp2 = ZG.C_DEMONS
    end
    C = ZG.REST(ZG.C_TABLE, _tmp2)
    E = ZG.REST(ZG.C_TABLE, ZG.C_TABLELEN)
    while true do
        if ZG.EQ(C, E) then
            ZG._set("MOVES", ZG.ADD(ZG.MOVES, 1))
            do return FLG end
        elseif (not ZG.ZERO_p(ZG.GET(C, ZG.C_ENABLED_p))) then
            TICK = ZG.GET(C, ZG.C_TICK)
            if ZG.ZERO_p(TICK) then
            else
                do local _ = ZG.PUT(C, ZG.C_TICK, ZG.SUB(TICK, 1)) end
                if ((not ZG.LT(1, TICK)) and ZG._T(ZG.APPLY(ZG.GET(C, ZG.C_RTN)))) then
                    FLG = true
                end
            end
        end
        C = ZG.REST(C, ZG.C_INTLEN)
    end

end, "CLOCKER")

ZG.CLOCKER = ZG.actions:get("CLOCKER")
