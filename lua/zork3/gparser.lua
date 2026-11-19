-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- ;"WHICH and TRAP retrofixes installed"

-- SIBREAKS is declared in ZilGlobal.lua

-- zil: gparser.zil:14  <GLOBAL PRSA>
-- PRSA is declared in ZilGlobal.lua

-- zil: gparser.zil:15  <GLOBAL PRSI>
-- PRSI is declared in ZilGlobal.lua

-- zil: gparser.zil:16  <GLOBAL PRSO>
-- PRSO is declared in ZilGlobal.lua

-- zil: gparser.zil:18  <GLOBAL P-TABLE>
-- P_TABLE is declared in ZilGlobal.lua

-- zil: gparser.zil:19  <GLOBAL P-ONEOBJ>
-- P_ONEOBJ is declared in ZilGlobal.lua

-- zil: gparser.zil:20  <GLOBAL P-SYNTAX>
-- P_SYNTAX is declared in ZilGlobal.lua

-- zil: gparser.zil:22  <GLOBAL P-CCTBL>
-- P_CCTBL is declared in ZilGlobal.lua

-- ;"pointers used by CLAUSE-COPY (source/destination beginning/end pointers)"

-- zil: gparser.zil:24  <CONSTANT CC-SBPTR>
-- CC_SBPTR is declared in ZilGlobal.lua

-- zil: gparser.zil:25  <CONSTANT CC-SEPTR>
-- CC_SEPTR is declared in ZilGlobal.lua

-- zil: gparser.zil:26  <CONSTANT CC-DBPTR>
-- CC_DBPTR is declared in ZilGlobal.lua

-- zil: gparser.zil:27  <CONSTANT CC-DEPTR>
-- CC_DEPTR is declared in ZilGlobal.lua

-- zil: gparser.zil:29  <GLOBAL P-LEN>
-- P_LEN is declared in ZilGlobal.lua

-- zil: gparser.zil:30  <GLOBAL P-DIR>
-- P_DIR is declared in ZilGlobal.lua

-- zil: gparser.zil:31  <GLOBAL HERE>
-- HERE is declared in ZilGlobal.lua

-- zil: gparser.zil:32  <GLOBAL WINNER>
-- WINNER is declared in ZilGlobal.lua

-- zil: gparser.zil:34  <GLOBAL P-LEXV>
-- P_LEXV is declared in ZilGlobal.lua

-- zil: gparser.zil:36  <GLOBAL AGAIN-LEXV>
-- AGAIN_LEXV is declared in ZilGlobal.lua

-- zil: gparser.zil:38  <GLOBAL RESERVE-LEXV>
-- RESERVE_LEXV is declared in ZilGlobal.lua

-- zil: gparser.zil:40  <GLOBAL RESERVE-PTR>
-- RESERVE_PTR is declared in ZilGlobal.lua

-- ;"INBUF - Input buffer for READ"

-- zil: gparser.zil:44  <GLOBAL P-INBUF>
-- P_INBUF is declared in ZilGlobal.lua

-- zil: gparser.zil:47  <GLOBAL OOPS-INBUF>
-- OOPS_INBUF is declared in ZilGlobal.lua

-- zil: gparser.zil:50  <GLOBAL OOPS-TABLE>
-- OOPS_TABLE is declared in ZilGlobal.lua

-- zil: gparser.zil:51  <CONSTANT O-PTR>
-- O_PTR is declared in ZilGlobal.lua

-- zil: gparser.zil:52  <CONSTANT O-START>
-- O_START is declared in ZilGlobal.lua

-- zil: gparser.zil:53  <CONSTANT O-LENGTH>
-- O_LENGTH is declared in ZilGlobal.lua

-- zil: gparser.zil:54  <CONSTANT O-END>
-- O_END is declared in ZilGlobal.lua

-- ;"Parse-cont variable"

-- zil: gparser.zil:58  <GLOBAL P-CONT>
-- P_CONT is declared in ZilGlobal.lua

-- zil: gparser.zil:59  <GLOBAL P-IT-OBJECT>
-- P_IT_OBJECT is declared in ZilGlobal.lua

-- ;<GLOBAL LAST-PSEUDO-LOC <>>

-- ;"Orphan flag"

-- zil: gparser.zil:64  <GLOBAL P-OFLAG>
-- P_OFLAG is declared in ZilGlobal.lua

-- zil: gparser.zil:65  <GLOBAL P-MERGED>
-- P_MERGED is declared in ZilGlobal.lua

-- zil: gparser.zil:66  <GLOBAL P-ACLAUSE>
-- P_ACLAUSE is declared in ZilGlobal.lua

-- zil: gparser.zil:67  <GLOBAL P-ANAM>
-- P_ANAM is declared in ZilGlobal.lua

-- zil: gparser.zil:68  <GLOBAL P-AADJ>
-- P_AADJ is declared in ZilGlobal.lua

-- ;"Parser variables and temporaries"

-- ;"Byte offset to # of entries in LEXV"

-- zil: gparser.zil:73  <CONSTANT P-LEXWORDS>
-- P_LEXWORDS is declared in ZilGlobal.lua

-- ;"Word offset to start of LEXV entries"

-- zil: gparser.zil:74  <CONSTANT P-LEXSTART>
-- P_LEXSTART is declared in ZilGlobal.lua

-- ;"Number of words per LEXV entry"

-- zil: gparser.zil:75  <CONSTANT P-LEXELEN>
-- P_LEXELEN is declared in ZilGlobal.lua

-- zil: gparser.zil:76  <CONSTANT P-WORDLEN>
-- P_WORDLEN is declared in ZilGlobal.lua

-- ;"Offset to parts of speech byte"

-- zil: gparser.zil:78  <CONSTANT P-PSOFF>
-- P_PSOFF is declared in ZilGlobal.lua

-- ;"Offset to first part of speech"

-- zil: gparser.zil:79  <CONSTANT P-P1OFF>
-- P_P1OFF is declared in ZilGlobal.lua

-- ;"First part of speech bit mask in PSOFF byte"

-- zil: gparser.zil:80  <CONSTANT P-P1BITS>
-- P_P1BITS is declared in ZilGlobal.lua

-- zil: gparser.zil:82  <CONSTANT P-ITBLLEN>
-- P_ITBLLEN is declared in ZilGlobal.lua

-- zil: gparser.zil:83  <GLOBAL P-ITBL>
-- P_ITBL is declared in ZilGlobal.lua

-- zil: gparser.zil:84  <GLOBAL P-OTBL>
-- P_OTBL is declared in ZilGlobal.lua

-- zil: gparser.zil:85  <GLOBAL P-VTBL>
-- P_VTBL is declared in ZilGlobal.lua

-- zil: gparser.zil:86  <GLOBAL P-OVTBL>
-- P_OVTBL is declared in ZilGlobal.lua

-- zil: gparser.zil:88  <GLOBAL P-NCN>
-- P_NCN is declared in ZilGlobal.lua

-- zil: gparser.zil:90  <CONSTANT P-VERB>
-- P_VERB is declared in ZilGlobal.lua

-- zil: gparser.zil:91  <CONSTANT P-VERBN>
-- P_VERBN is declared in ZilGlobal.lua

-- zil: gparser.zil:92  <CONSTANT P-PREP1>
-- P_PREP1 is declared in ZilGlobal.lua

-- zil: gparser.zil:93  <CONSTANT P-PREP1N>
-- P_PREP1N is declared in ZilGlobal.lua

-- zil: gparser.zil:94  <CONSTANT P-PREP2>
-- P_PREP2 is declared in ZilGlobal.lua

-- zil: gparser.zil:95  <CONSTANT P-PREP2N>
-- P_PREP2N is declared in ZilGlobal.lua

-- zil: gparser.zil:96  <CONSTANT P-NC1>
-- P_NC1 is declared in ZilGlobal.lua

-- zil: gparser.zil:97  <CONSTANT P-NC1L>
-- P_NC1L is declared in ZilGlobal.lua

-- zil: gparser.zil:98  <CONSTANT P-NC2>
-- P_NC2 is declared in ZilGlobal.lua

-- zil: gparser.zil:99  <CONSTANT P-NC2L>
-- P_NC2L is declared in ZilGlobal.lua

-- zil: gparser.zil:101  <GLOBAL QUOTE-FLAG>
-- QUOTE_FLAG is declared in ZilGlobal.lua

-- zil: gparser.zil:102  <GLOBAL P-END-ON-PREP>
-- P_END_ON_PREP is declared in ZilGlobal.lua

-- zil: gparser.zil:109  <ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>) O...
ZG.actions:register("PARSER", function()

    local PTR = ZG.P_LEXSTART
    local WRD = 0
    local VAL = 0
    local VERB = false
    local OF_FLAG = false
    local OWINNER = 0
    local OMERGED = 0
    local LEN = 0
    local DIR = false
    local NW = 0
    local LW = 0
    local CNT = -1
    while true do
        if ZG.LT(ZG.P_ITBLLEN, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
            break
        else
            if (not ZG._T(ZG.P_OFLAG)) then
                do local _ = ZG.PUT(ZG.P_OTBL, CNT, ZG.GET(ZG.P_ITBL, CNT)) end
            end
            do local _ = ZG.PUT(ZG.P_ITBL, CNT, 0) end
        end
    end
    OWINNER = ZG.WINNER
    OMERGED = ZG.P_MERGED
    ZG._set("P_ADVERB", false)
    ZG._set("P_MERGED", false)
    ZG._set("P_END_ON_PREP", false)
    do local _ = ZG.PUT(ZG.P_PRSO, ZG.P_MATCHLEN, 0) end
    do local _ = ZG.PUT(ZG.P_PRSI, ZG.P_MATCHLEN, 0) end
    do local _ = ZG.PUT(ZG.P_BUTS, ZG.P_MATCHLEN, 0) end
    if ((not ZG._T(ZG.QUOTE_FLAG)) and (not ZG.EQ(ZG.WINNER, ZG.PLAYER))) then
        ZG._set("WINNER", ZG.PLAYER)
        ZG._set("HERE", ZG.META_LOC(ZG.PLAYER))
        ZG._set("LIT", ZG.LIT_p(ZG.HERE))
    end
    if ZG._T(ZG.RESERVE_PTR) then
        PTR = ZG.RESERVE_PTR
        do local _ = ZG.STUFF(ZG.RESERVE_LEXV, ZG.P_LEXV) end
        if ((not ZG._T(ZG.SUPER_BRIEF)) and ZG.EQ(ZG.PLAYER, ZG.WINNER)) then
            do local _ = ZG.CRLF() end
        end
        ZG._set("RESERVE_PTR", false)
        ZG._set("P_CONT", false)
    elseif ZG._T(ZG.P_CONT) then
        PTR = ZG.P_CONT
        if ((not ZG._T(ZG.SUPER_BRIEF)) and ZG.EQ(ZG.PLAYER, ZG.WINNER) and (not ZG._T(ZG.VERB_p("SAY")))) then
            do local _ = ZG.CRLF() end
        end
        ZG._set("P_CONT", false)
    else
        ZG._set("WINNER", ZG.PLAYER)
        ZG._set("QUOTE_FLAG", false)
        if (not ZG._T(ZG.FSET_p(ZG.LOC(ZG.WINNER), "VEHBIT"))) then
            ZG._set("HERE", ZG.LOC(ZG.WINNER))
        end
        ZG._set("LIT", ZG.LIT_p(ZG.HERE))
        if (not ZG._T(ZG.SUPER_BRIEF)) then
            do local _ = ZG.CRLF() end
        end
        do local _ = ZG.TELL(">") end
        do local _ = ZG.READ(ZG.P_INBUF, ZG.P_LEXV) end
    end
    ZG._set("P_LEN", ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS))
    if ZG.ZERO_p(ZG.P_LEN) then
        do local _ = ZG.TELL("I beg your pardon?", ZG._TK.CR) end
        do return false end
    end
    if ZG.EQ((function() WRD = ZG.GET(ZG.P_LEXV, PTR); return WRD end)(), ZG.WORD("oops")) then
        if ZG.EQUAL_p(ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN)), ZG.WORD("period"), ZG.WORD("comma")) then
            PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
            ZG._set("P_LEN", ZG.SUB(ZG.P_LEN, 1))
        end
        if (not ZG.LT(1, ZG.P_LEN)) then
            do local _ = ZG.TELL("I can't help your clumsiness.", ZG._TK.CR) end
            do return false end
        elseif ZG._T(ZG.GET(ZG.OOPS_TABLE, ZG.O_PTR)) then
            if (ZG.LT(2, ZG.P_LEN) and ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN)), ZG.WORD("quote"))) then
                do local _ = ZG.TELL("Sorry, you can't correct mistakes in quoted text.", ZG._TK.CR) end
                do return false end
            elseif ZG.LT(2, ZG.P_LEN) then
                do local _ = ZG.TELL("Warning: only the first word after OOPS is used.", ZG._TK.CR) end
            end
            do local _ = ZG.PUT(ZG.AGAIN_LEXV, ZG.GET(ZG.OOPS_TABLE, ZG.O_PTR), ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN))) end
            ZG._set("WINNER", OWINNER)
            do local _ = ZG.INBUF_ADD(ZG.GETB(ZG.P_LEXV, ZG.ADD((PTR * ZG.P_LEXELEN), 6)), ZG.GETB(ZG.P_LEXV, ZG.ADD((PTR * ZG.P_LEXELEN), 7)), ZG.ADD((ZG.GET(ZG.OOPS_TABLE, ZG.O_PTR) * ZG.P_LEXELEN), 3)) end
            do local _ = ZG.STUFF(ZG.AGAIN_LEXV, ZG.P_LEXV) end
            ZG._set("P_LEN", ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS))
            PTR = ZG.GET(ZG.OOPS_TABLE, ZG.O_START)
            do local _ = ZG.INBUF_STUFF(ZG.OOPS_INBUF, ZG.P_INBUF) end
        else
            do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_END, false) end
            do local _ = ZG.TELL("There was no word to replace!", ZG._TK.CR) end
            do return false end
        end
    else
        if (not ZG.EQUAL_p(WRD, ZG.WORD("again"), ZG.WORD("g"))) then
            ZG._set("P_NUMBER", 0)
        end
        do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_END, false) end
    end
    if ZG.EQUAL_p(ZG.GET(ZG.P_LEXV, PTR), ZG.WORD("again"), ZG.WORD("g")) then
        if ZG.ZERO_p(ZG.GETB(ZG.OOPS_INBUF, 1)) then
            do local _ = ZG.TELL("Beg pardon?", ZG._TK.CR) end
            do return false end
        elseif ZG._T(ZG.P_OFLAG) then
            do local _ = ZG.TELL("It's difficult to repeat fragments.", ZG._TK.CR) end
            do return false end
        elseif (not ZG._T(ZG.P_WON)) then
            do local _ = ZG.TELL("That would just repeat a mistake.", ZG._TK.CR) end
            do return false end
        elseif ZG.LT(1, ZG.P_LEN) then
            if (ZG.EQUAL_p(ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN)), ZG.WORD("period"), ZG.WORD("comma"), ZG.WORD("then")) or ZG.EQ(ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN)), ZG.WORD("and"))) then
                PTR = ZG.ADD(PTR, (2 * ZG.P_LEXELEN))
                do local _ = ZG.PUTB(ZG.P_LEXV, ZG.P_LEXWORDS, ZG.SUB(ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS), 2)) end
            else
                do local _ = ZG.TELL("I couldn't understand that sentence.", ZG._TK.CR) end
                do return false end
            end
        else
            PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
            do local _ = ZG.PUTB(ZG.P_LEXV, ZG.P_LEXWORDS, ZG.SUB(ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS), 1)) end
        end
        if ZG.LT(0, ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS)) then
            do local _ = ZG.STUFF(ZG.P_LEXV, ZG.RESERVE_LEXV) end
            ZG._set("RESERVE_PTR", PTR)
        else
            ZG._set("RESERVE_PTR", false)
        end
        ZG._set("WINNER", OWINNER)
        ZG._set("P_MERGED", OMERGED)
        do local _ = ZG.INBUF_STUFF(ZG.OOPS_INBUF, ZG.P_INBUF) end
        do local _ = ZG.STUFF(ZG.AGAIN_LEXV, ZG.P_LEXV) end
        CNT = -1
        DIR = ZG.AGAIN_DIR
        while true do
            if (function() CNT = ZG.ADD(CNT, 1); return CNT > ZG.P_ITBLLEN end)() then
                break
            else
                do local _ = ZG.PUT(ZG.P_ITBL, CNT, ZG.GET(ZG.P_OTBL, CNT)) end
            end
        end
    else
        do local _ = ZG.STUFF(ZG.P_LEXV, ZG.AGAIN_LEXV) end
        do local _ = ZG.INBUF_STUFF(ZG.P_INBUF, ZG.OOPS_INBUF) end
        do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_START, PTR) end
        do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_LENGTH, (4 * ZG.P_LEN)) end
        LEN = (2 * ZG.ADD(PTR, (ZG.P_LEXELEN * ZG.GETB(ZG.P_LEXV, ZG.P_LEXWORDS))))
        do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_END, ZG.ADD(ZG.GETB(ZG.P_LEXV, ZG.SUB(LEN, 1)), ZG.GETB(ZG.P_LEXV, ZG.SUB(LEN, 2)))) end
        ZG._set("RESERVE_PTR", false)
        LEN = ZG.P_LEN
        ZG._set("P_DIR", false)
        ZG._set("P_NCN", 0)
        ZG._set("P_GETFLAGS", 0)
        while true do
            if ZG.LT(ZG._set("P_LEN", ZG.SUB(ZG.P_LEN, 1)), 0) then
                ZG._set("QUOTE_FLAG", false)
                break
            elseif (ZG._T((function() WRD = ZG.GET(ZG.P_LEXV, PTR); return WRD end)()) or ZG._T((function() WRD = ZG.NUMBER_p(PTR); return WRD end)())) then
                if ZG.ZERO_p(ZG.P_LEN) then
                    NW = 0
                else
                    NW = ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN))
                end
                if (ZG.EQ(WRD, ZG.WORD("to")) and ZG.EQ(VERB, ZG.SYMBOL("ACT?TELL"))) then
                    WRD = ZG.WORD("quote")
                elseif (ZG.EQ(WRD, ZG.WORD("then")) and ZG.LT(0, ZG.P_LEN) and (not ZG._T(VERB)) and (not ZG._T(ZG.QUOTE_FLAG))) then
                    if ZG.EQUAL_p(LW, 0, ZG.WORD("period")) then
                        WRD = ZG.WORD("the")
                    else
                        do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERB, ZG.SYMBOL("ACT?TELL")) end
                        do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERBN, 0) end
                        WRD = ZG.WORD("quote")
                    end
                end
                if ZG.EQUAL_p(WRD, ZG.WORD("then"), ZG.WORD("period"), ZG.WORD("quote")) then
                    if ZG.EQ(WRD, ZG.WORD("quote")) then
                        if ZG._T(ZG.QUOTE_FLAG) then
                            ZG._set("QUOTE_FLAG", false)
                        else
                            ZG._set("QUOTE_FLAG", true)
                        end
                    end
                    do local _ = (function() local _v = ZG.ZERO_p(ZG.P_LEN); if ZG._T(_v) then return _v end; return ZG._set("P_CONT", ZG.ADD(PTR, ZG.P_LEXELEN)) end)() end
                    do local _ = ZG.PUTB(ZG.P_LEXV, ZG.P_LEXWORDS, ZG.P_LEN) end
                    break
                elseif (ZG._T((function() VAL = ZG.WT_p(WRD, ZG.PS_DIRECTION, ZG.P1_DIRECTION); return VAL end)()) and ZG.EQUAL_p(VERB, false, ZG.SYMBOL("ACT?WALK")) and (ZG.EQ(LEN, 1) or (ZG.EQ(LEN, 2) and ZG.EQ(VERB, ZG.SYMBOL("ACT?WALK"))) or (ZG.EQUAL_p(NW, ZG.WORD("then"), ZG.WORD("period"), ZG.WORD("quote")) and (not ZG.LT(LEN, 2))) or (ZG._T(ZG.QUOTE_FLAG) and ZG.EQ(LEN, 2) and ZG.EQ(NW, ZG.WORD("quote"))) or (ZG.LT(2, LEN) and ZG.EQUAL_p(NW, ZG.WORD("comma"), ZG.WORD("and"))))) then
                    DIR = VAL
                    if ZG.EQUAL_p(NW, ZG.WORD("comma"), ZG.WORD("and")) then
                        do local _ = ZG.PUT(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN), ZG.WORD("then")) end
                    end
                    if (not ZG.LT(2, LEN)) then
                        ZG._set("QUOTE_FLAG", false)
                        break
                    end
                elseif (ZG._T((function() VAL = ZG.WT_p(WRD, ZG.PS_VERB, ZG.P1_VERB); return VAL end)()) and (not ZG._T(VERB))) then
                    VERB = VAL
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERB, VAL) end
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERBN, ZG.P_VTBL) end
                    do local _ = ZG.PUT(ZG.P_VTBL, 0, WRD) end
                    do local _ = ZG.PUTB(ZG.P_VTBL, 2, ZG.GETB(ZG.P_LEXV, (function() CNT = ZG.ADD((PTR * 2), 2); return CNT end)())) end
                    do local _ = ZG.PUTB(ZG.P_VTBL, 3, ZG.GETB(ZG.P_LEXV, ZG.ADD(CNT, 1))) end
                elseif (ZG._T((function() VAL = ZG.WT_p(WRD, ZG.PS_PREPOSITION, 0); return VAL end)()) or ZG.EQUAL_p(WRD, ZG.WORD("all"), ZG.WORD("one")) or ZG._T(ZG.WT_p(WRD, ZG.PS_ADJECTIVE)) or ZG._T(ZG.WT_p(WRD, ZG.PS_OBJECT))) then
                    if (ZG.LT(1, ZG.P_LEN) and ZG.EQ(NW, ZG.WORD("of")) and ZG.ZERO_p(VAL) and (not ZG.EQUAL_p(WRD, ZG.WORD("all"), ZG.WORD("one"), ZG.WORD("a")))) then
                        OF_FLAG = true
                    elseif ((not ZG.ZERO_p(VAL)) and (ZG.ZERO_p(ZG.P_LEN) or ZG.EQUAL_p(NW, ZG.WORD("then"), ZG.WORD("period")))) then
                        ZG._set("P_END_ON_PREP", true)
                        if ZG.LT(ZG.P_NCN, 2) then
                            do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_PREP1, VAL) end
                            do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_PREP1N, WRD) end
                        end
                    elseif ZG.EQ(ZG.P_NCN, 2) then
                        do local _ = ZG.TELL("There were too many nouns in that sentence.", ZG._TK.CR) end
                        do return false end
                    else
                        ZG._set("P_NCN", ZG.ADD(ZG.P_NCN, 1))
                        ZG._set("P_ACT", VERB)
                        if (not ZG._T((function() PTR = ZG.CLAUSE(PTR, VAL, WRD); return PTR end)())) then
                            do return false end
                        end
                        if ZG.LT(PTR, 0) then
                            ZG._set("QUOTE_FLAG", false)
                            break
                        end
                    end
                elseif ZG.EQ(WRD, ZG.WORD("of")) then
                    if ((not ZG._T(OF_FLAG)) or ZG.EQUAL_p(NW, ZG.WORD("period"), ZG.WORD("then"))) then
                        do local _ = ZG.CANT_USE(PTR) end
                        do return false end
                    else
                        OF_FLAG = false
                    end
                elseif ZG._T(ZG.WT_p(WRD, ZG.PS_BUZZ_WORD)) then
                elseif (ZG.EQ(VERB, ZG.SYMBOL("ACT?TELL")) and ZG._T(ZG.WT_p(WRD, ZG.PS_VERB, ZG.P1_VERB)) and ZG.EQ(ZG.WINNER, ZG.PLAYER)) then
                    do local _ = ZG.TELL("Please consult your manual for the correct way to talk to other people\nor creatures.", ZG._TK.CR) end
                    do return false end
                else
                    do local _ = ZG.CANT_USE(PTR) end
                    do return false end
                end
            else
                do local _ = ZG.UNKNOWN_WORD(PTR) end
                do return false end
            end
            LW = WRD
            PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
        end
    end
    do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_PTR, false) end
    if ZG._T(DIR) then
        ZG._set("PRSA", ZG.SYMBOL("V?WALK"))
        ZG._set("PRSO", DIR)
        ZG._set("P_OFLAG", false)
        ZG._set("P_WALK_DIR", DIR)
        ZG._set("AGAIN_DIR", DIR)
        do return ZG.AGAIN_DIR end
    else
        if ZG._T(ZG.P_OFLAG) then
            do local _ = ZG.ORPHAN_MERGE() end
        end
        ZG._set("P_WALK_DIR", false)
        ZG._set("AGAIN_DIR", false)
        if (ZG._T(ZG.SYNTAX_CHECK()) and ZG._T(ZG.SNARF_OBJECTS()) and ZG._T(ZG.MANY_CHECK()) and ZG._T(ZG.TAKE_CHECK())) then
            do return true end
        else
            do return false end
        end
    end

end, "PARSER")

ZG.PARSER = ZG.actions:get("PARSER")

-- zil: gparser.zil:382  <GLOBAL P-ACT>
-- P_ACT is declared in ZilGlobal.lua

-- zil: gparser.zil:383  <GLOBAL P-WALK-DIR>
-- P_WALK_DIR is declared in ZilGlobal.lua

-- zil: gparser.zil:384  <GLOBAL AGAIN-DIR>
-- AGAIN_DIR is declared in ZilGlobal.lua

-- ;"For AGAIN purposes, put contents of one LEXV table into another."

-- zil: gparser.zil:387  <ROUTINE STUFF (SRC DEST "OPTIONAL" (MAX 29) "AUX" (PTR ,P-LEXSTART) (CTR 1) ...
ZG.actions:register("STUFF", function(SRC, DEST, MAX)

    if MAX == nil then MAX = 29 end
    local PTR = ZG.P_LEXSTART
    local CTR = 1
    local BPTR = 0
    do local _ = ZG.PUTB(DEST, 0, ZG.GETB(SRC, 0)) end
    do local _ = ZG.PUTB(DEST, 1, ZG.GETB(SRC, 1)) end
    while true do
        do local _ = ZG.PUT(DEST, PTR, ZG.GET(SRC, PTR)) end
        BPTR = ZG.ADD((PTR * 2), 2)
        do local _ = ZG.PUTB(DEST, BPTR, ZG.GETB(SRC, BPTR)) end
        BPTR = ZG.ADD((PTR * 2), 3)
        do local _ = ZG.PUTB(DEST, BPTR, ZG.GETB(SRC, BPTR)) end
        PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
        if (function() CTR = ZG.ADD(CTR, 1); return CTR > MAX end)() then
            do return true end
        end
    end

end, "STUFF")

ZG.STUFF = ZG.actions:get("STUFF")

-- ;"Put contents of one INBUF into another"

-- zil: gparser.zil:402  <ROUTINE INBUF-STUFF (SRC DEST "AUX" CNT)>
ZG.actions:register("INBUF_STUFF", function(SRC, DEST)

    local CNT = 0
    CNT = ZG.SUB(ZG.GETB(SRC, 0), 1)
    while true do
        do local _ = ZG.PUTB(DEST, CNT, ZG.GETB(SRC, CNT)) end
        if (function() CNT = ZG.SUB(CNT, 1); return CNT < 0 end)() then
            do return true end
        end
    end

end, "INBUF-STUFF")

ZG.INBUF_STUFF = ZG.actions:get("INBUF_STUFF")

-- ;"Put the word in the positions specified from P-INBUF to the end of
-- OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV"

-- zil: gparser.zil:410  <ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)>
ZG.actions:register("INBUF_ADD", function(LEN, BEG, SLOT)

    local DBEG = 0
    local CTR = 0
    local TMP = 0
    if ZG._T((function() TMP = ZG.GET(ZG.OOPS_TABLE, ZG.O_END); return TMP end)()) then
        DBEG = TMP
    else
        DBEG = ZG.ADD(ZG.GETB(ZG.AGAIN_LEXV, (function() TMP = ZG.GET(ZG.OOPS_TABLE, ZG.O_LENGTH); return TMP end)()), ZG.GETB(ZG.AGAIN_LEXV, ZG.ADD(TMP, 1)))
    end
    do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_END, ZG.ADD(DBEG, LEN)) end
    while true do
        do local _ = ZG.PUTB(ZG.OOPS_INBUF, ZG.ADD(DBEG, CTR), ZG.GETB(ZG.P_INBUF, ZG.ADD(BEG, CTR))) end
        CTR = ZG.ADD(CTR, 1)
        if ZG.EQ(CTR, LEN) then
            break
        end
    end
    do local _ = ZG.PUTB(ZG.AGAIN_LEXV, SLOT, DBEG) end
    do return ZG.PUTB(ZG.AGAIN_LEXV, ZG.SUB(SLOT, 1), LEN) end

end, "INBUF-ADD")

ZG.INBUF_ADD = ZG.actions:get("INBUF_ADD")

-- ;"Check whether word pointed at by PTR is the correct part of speech.
--    The second argument is the part of speech (,PS?<part of speech>).  The
--    3rd argument (,P1?<part of speech>), if given, causes the value
--    for that part of speech to be returned."

-- zil: gparser.zil:430  <ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP)>
ZG.actions:register("WT_p", function(PTR, BIT, B1)

    if B1 == nil then B1 = 5 end
    local OFFS = ZG.P_P1OFF
    local TYP = 0
    if ZG._T(ZG.BTST((function() TYP = ZG.GETB(PTR, ZG.P_PSOFF); return TYP end)(), BIT)) then
        if ZG.LT(4, B1) then
            do return true end
        else
            TYP = ZG.BAND(TYP, ZG.P_P1BITS)
            if (not ZG.EQ(TYP, B1)) then
                OFFS = ZG.ADD(OFFS, 1)
            end
            do return ZG.GETB(PTR, OFFS) end
        end
    else
        do return false end
    end

end, "WT?")

ZG.WT_p = ZG.actions:get("WT_p")

-- ;" Scan through a noun clause, leave a pointer to its starting location"

-- zil: gparser.zil:440  <ROUTINE CLAUSE (PTR VAL WRD "AUX" OFF NUM (ANDFLG <>) (FIRST?? T) NW (LW 0))>
ZG.actions:register("CLAUSE", function(PTR, VAL, WRD)

    local OFF = 0
    local NUM = 0
    local ANDFLG = false
    local FIRST__p = true
    local NW = 0
    local LW = 0
    OFF = (ZG.SUB(ZG.P_NCN, 1) * 2)
    if (not ZG.EQ(VAL, 0)) then
        do local _ = ZG.PUT(ZG.P_ITBL, (function() NUM = ZG.ADD(ZG.P_PREP1, OFF); return NUM end)(), VAL) end
        do local _ = ZG.PUT(ZG.P_ITBL, ZG.ADD(NUM, 1), WRD) end
        PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
    else
        ZG._set("P_LEN", ZG.ADD(ZG.P_LEN, 1))
    end
    if ZG.ZERO_p(ZG.P_LEN) then
        ZG._set("P_NCN", ZG.SUB(ZG.P_NCN, 1))
        do return -1 end
    end
    do local _ = ZG.PUT(ZG.P_ITBL, (function() NUM = ZG.ADD(ZG.P_NC1, OFF); return NUM end)(), ZG.REST(ZG.P_LEXV, (PTR * 2))) end
    if ZG.EQUAL_p(ZG.GET(ZG.P_LEXV, PTR), ZG.WORD("the"), ZG.WORD("a"), ZG.WORD("an")) then
        do local _ = ZG.PUT(ZG.P_ITBL, NUM, ZG.REST(ZG.GET(ZG.P_ITBL, NUM), 4)) end
    end
    while true do
        if ZG.LT(ZG._set("P_LEN", ZG.SUB(ZG.P_LEN, 1)), 0) then
            do local _ = ZG.PUT(ZG.P_ITBL, ZG.ADD(NUM, 1), ZG.REST(ZG.P_LEXV, (PTR * 2))) end
            do return -1 end
        end
        if (ZG._T((function() WRD = ZG.GET(ZG.P_LEXV, PTR); return WRD end)()) or ZG._T((function() WRD = ZG.NUMBER_p(PTR); return WRD end)())) then
            if ZG.ZERO_p(ZG.P_LEN) then
                NW = 0
            else
                NW = ZG.GET(ZG.P_LEXV, ZG.ADD(PTR, ZG.P_LEXELEN))
            end
            if ZG.EQUAL_p(WRD, ZG.WORD("and"), ZG.WORD("comma")) then
                ANDFLG = true
            elseif ZG.EQUAL_p(WRD, ZG.WORD("all"), ZG.WORD("one")) then
                if ZG.EQ(NW, ZG.WORD("of")) then
                    ZG._set("P_LEN", ZG.SUB(ZG.P_LEN, 1))
                    PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
                end
            elseif (ZG.EQUAL_p(WRD, ZG.WORD("then"), ZG.WORD("period")) or (ZG._T(ZG.WT_p(WRD, ZG.PS_PREPOSITION)) and ZG._T(ZG.GET(ZG.P_ITBL, ZG.P_VERB)) and (not ZG._T(FIRST__p)))) then
                ZG._set("P_LEN", ZG.ADD(ZG.P_LEN, 1))
                do local _ = ZG.PUT(ZG.P_ITBL, ZG.ADD(NUM, 1), ZG.REST(ZG.P_LEXV, (PTR * 2))) end
                do return ZG.SUB(PTR, ZG.P_LEXELEN) end
            elseif ZG._T(ZG.WT_p(WRD, ZG.PS_OBJECT)) then
                if (ZG.LT(0, ZG.P_LEN) and ZG.EQ(NW, ZG.WORD("of")) and (not ZG.EQUAL_p(WRD, ZG.WORD("all"), ZG.WORD("one")))) then
                elseif (ZG._T(ZG.WT_p(WRD, ZG.PS_ADJECTIVE, ZG.P1_ADJECTIVE)) and (not ZG.EQ(NW, 0)) and ZG._T(ZG.WT_p(NW, ZG.PS_OBJECT))) then
                elseif ((not ZG._T(ANDFLG)) and (not ZG.EQUAL_p(NW, ZG.WORD("but"), ZG.WORD("except"))) and (not ZG.EQUAL_p(NW, ZG.WORD("and"), ZG.WORD("comma")))) then
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.ADD(NUM, 1), ZG.REST(ZG.P_LEXV, (ZG.ADD(PTR, 2) * 2))) end
                    do return PTR end
                else
                    ANDFLG = false
                end
            elseif ((ZG._T(ZG.P_MERGED) or ZG._T(ZG.P_OFLAG) or (not ZG.EQ(ZG.GET(ZG.P_ITBL, ZG.P_VERB), 0))) and (ZG._T(ZG.WT_p(WRD, ZG.PS_ADJECTIVE)) or ZG._T(ZG.WT_p(WRD, ZG.PS_BUZZ_WORD)))) then
            elseif (ZG._T(ANDFLG) and (ZG._T(ZG.WT_p(WRD, ZG.PS_DIRECTION)) or ZG._T(ZG.WT_p(WRD, ZG.PS_VERB)))) then
                PTR = ZG.SUB(PTR, 4)
                do local _ = ZG.PUT(ZG.P_LEXV, ZG.ADD(PTR, 2), ZG.WORD("then")) end
                ZG._set("P_LEN", ZG.ADD(ZG.P_LEN, 2))
            elseif ZG._T(ZG.WT_p(WRD, ZG.PS_PREPOSITION)) then
            else
                do local _ = ZG.CANT_USE(PTR) end
                do return false end
            end
        else
            do local _ = ZG.UNKNOWN_WORD(PTR) end
            do return false end
        end
        LW = WRD
        FIRST__p = false
        PTR = ZG.ADD(PTR, ZG.P_LEXELEN)
    end

end, "CLAUSE")

ZG.CLAUSE = ZG.actions:get("CLAUSE")

-- zil: gparser.zil:512  <ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>))>
ZG.actions:register("NUMBER_p", function(PTR)

    local CNT = 0
    local BPTR = 0
    local CHR = 0
    local SUM = 0
    local TIM = false
    CNT = ZG.GETB(ZG.REST(ZG.P_LEXV, (PTR * 2)), 2)
    BPTR = ZG.GETB(ZG.REST(ZG.P_LEXV, (PTR * 2)), 3)
    while true do
        if ZG.LT((function() CNT = ZG.SUB(CNT, 1); return CNT end)(), 0) then
            break
        else
            CHR = ZG.GETB(ZG.P_INBUF, BPTR)
            if ZG.EQ(CHR, 58) then
                TIM = SUM
                SUM = 0
            elseif ZG.LT(10000, SUM) then
                do return false end
            elseif (ZG.LT(CHR, 58) and ZG.LT(47, CHR)) then
                SUM = ZG.ADD((SUM * 10), ZG.SUB(CHR, 48))
            else
                do return false end
            end
            BPTR = ZG.ADD(BPTR, 1)
        end
    end
    do local _ = ZG.PUT(ZG.P_LEXV, PTR, ZG.WORD("intnum")) end
    if ZG.LT(1000, SUM) then
        do return false end
    elseif ZG._T(TIM) then
        if ZG.LT(TIM, 8) then
            TIM = ZG.ADD(TIM, 12)
        elseif ZG.LT(23, TIM) then
            do return false end
        end
        SUM = ZG.ADD(SUM, (TIM * 60))
    end
    ZG._set("P_NUMBER", SUM)
    do return ZG.WORD("intnum") end

end, "NUMBER?")

ZG.NUMBER_p = ZG.actions:get("NUMBER_p")

-- zil: gparser.zil:536  <GLOBAL P-NUMBER>
-- P_NUMBER is declared in ZilGlobal.lua

-- zil: gparser.zil:538  <GLOBAL P-DIRECTION>
-- P_DIRECTION is declared in ZilGlobal.lua

-- ;"New ORPHAN-MERGE for TRAP Retrofix 6/21/84"

-- zil: gparser.zil:543  <ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD)>
ZG.actions:register("ORPHAN_MERGE", function()

    local CNT = -1
    local TEMP = 0
    local VERB = 0
    local BEG = 0
    local END = 0
    local ADJ = false
    local WRD = 0
    ZG._set("P_OFLAG", false)
    if (ZG.EQ(ZG.WT_p((function() WRD = ZG.GET(ZG.GET(ZG.P_ITBL, ZG.P_VERBN), 0); return WRD end)(), ZG.PS_VERB, ZG.P1_VERB), ZG.GET(ZG.P_OTBL, ZG.P_VERB)) or (not ZG.ZERO_p(ZG.WT_p(WRD, ZG.PS_ADJECTIVE)))) then
        ADJ = true
    elseif ((not ZG.ZERO_p(ZG.WT_p(WRD, ZG.PS_OBJECT, ZG.P1_OBJECT))) and ZG.EQ(ZG.P_NCN, 0)) then
        do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERB, 0) end
        do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERBN, 0) end
        do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1, ZG.REST(ZG.P_LEXV, 2)) end
        do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1L, ZG.REST(ZG.P_LEXV, 6)) end
        ZG._set("P_NCN", 1)
    end
    if ((not ZG.ZERO_p((function() VERB = ZG.GET(ZG.P_ITBL, ZG.P_VERB); return VERB end)())) and (not ZG._T(ADJ)) and (not ZG.EQ(VERB, ZG.GET(ZG.P_OTBL, ZG.P_VERB)))) then
        do return false end
    elseif ZG.EQ(ZG.P_NCN, 2) then
        do return false end
    elseif ZG.EQ(ZG.GET(ZG.P_OTBL, ZG.P_NC1), 1) then
        if (ZG.EQ((function() TEMP = ZG.GET(ZG.P_ITBL, ZG.P_PREP1); return TEMP end)(), ZG.GET(ZG.P_OTBL, ZG.P_PREP1)) or ZG.ZERO_p(TEMP)) then
            if ZG._T(ADJ) then
                do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_NC1, ZG.REST(ZG.P_LEXV, 2)) end
                if ZG.ZERO_p(ZG.GET(ZG.P_ITBL, ZG.P_NC1L)) then
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1L, ZG.REST(ZG.P_LEXV, 6)) end
                end
                if ZG.ZERO_p(ZG.P_NCN) then
                    ZG._set("P_NCN", 1)
                end
            else
                do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_NC1, ZG.GET(ZG.P_ITBL, ZG.P_NC1)) end
            end
            do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_NC1L, ZG.GET(ZG.P_ITBL, ZG.P_NC1L)) end
        else
            do return false end
        end
    elseif ZG.EQ(ZG.GET(ZG.P_OTBL, ZG.P_NC2), 1) then
        if (ZG.EQ((function() TEMP = ZG.GET(ZG.P_ITBL, ZG.P_PREP1); return TEMP end)(), ZG.GET(ZG.P_OTBL, ZG.P_PREP2)) or ZG.ZERO_p(TEMP)) then
            if ZG._T(ADJ) then
                do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1, ZG.REST(ZG.P_LEXV, 2)) end
                if ZG.ZERO_p(ZG.GET(ZG.P_ITBL, ZG.P_NC1L)) then
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1L, ZG.REST(ZG.P_LEXV, 6)) end
                end
            end
            do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_NC2, ZG.GET(ZG.P_ITBL, ZG.P_NC1)) end
            do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_NC2L, ZG.GET(ZG.P_ITBL, ZG.P_NC1L)) end
            ZG._set("P_NCN", 2)
        else
            do return false end
        end
    elseif (not ZG.ZERO_p(ZG.P_ACLAUSE)) then
        if ((not ZG.EQ(ZG.P_NCN, 1)) and (not ZG._T(ADJ))) then
            ZG._set("P_ACLAUSE", false)
            do return false end
        else
            BEG = ZG.GET(ZG.P_ITBL, ZG.P_NC1)
            if ZG._T(ADJ) then
                BEG = ZG.REST(ZG.P_LEXV, 2)
                ADJ = false
            end
            END = ZG.GET(ZG.P_ITBL, ZG.P_NC1L)
            while true do
                WRD = ZG.GET(BEG, 0)
                if ZG.EQ(BEG, END) then
                    if ZG._T(ADJ) then
                        do local _ = ZG.ACLAUSE_WIN(ADJ) end
                        break
                    else
                        ZG._set("P_ACLAUSE", false)
                        do return false end
                    end
                elseif ((not ZG._T(ADJ)) and (ZG._T(ZG.BTST(ZG.GETB(WRD, ZG.P_PSOFF), ZG.PS_ADJECTIVE)) or ZG.EQUAL_p(WRD, ZG.WORD("all"), ZG.WORD("one")))) then
                    ADJ = WRD
                elseif ZG.EQ(WRD, ZG.WORD("one")) then
                    do local _ = ZG.ACLAUSE_WIN(ADJ) end
                    break
                elseif ZG._T(ZG.BTST(ZG.GETB(WRD, ZG.P_PSOFF), ZG.PS_OBJECT)) then
                    if ZG.EQ(WRD, ZG.P_ANAM) then
                        do local _ = ZG.ACLAUSE_WIN(ADJ) end
                    else
                        do local _ = ZG.NCLAUSE_WIN() end
                    end
                    break
                end
                BEG = ZG.REST(BEG, ZG.P_WORDLEN)
                if ZG.EQ(END, 0) then
                    END = BEG
                    ZG._set("P_NCN", 1)
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1, ZG.BACK(BEG, 4)) end
                    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_NC1L, BEG) end
                end
            end
        end
    end
    do local _ = ZG.PUT(ZG.P_VTBL, 0, ZG.GET(ZG.P_OVTBL, 0)) end
    do local _ = ZG.PUTB(ZG.P_VTBL, 2, ZG.GETB(ZG.P_OVTBL, 2)) end
    do local _ = ZG.PUTB(ZG.P_VTBL, 3, ZG.GETB(ZG.P_OVTBL, 3)) end
    do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_VERBN, ZG.P_VTBL) end
    do local _ = ZG.PUTB(ZG.P_VTBL, 2, 0) end
    while true do
        if ZG.LT(ZG.P_ITBLLEN, (function() CNT = ZG.ADD(CNT, 1); return CNT end)()) then
            ZG._set("P_MERGED", true)
            do return true end
        else
            do local _ = ZG.PUT(ZG.P_ITBL, CNT, ZG.GET(ZG.P_OTBL, CNT)) end
        end
    end
    do return true end

end, "ORPHAN-MERGE")

ZG.ORPHAN_MERGE = ZG.actions:get("ORPHAN_MERGE")

-- ;"New ACLAUSE-WIN for TRAP retrofix 6/21/84"

-- zil: gparser.zil:634  <ROUTINE ACLAUSE-WIN (ADJ)>
ZG.actions:register("ACLAUSE_WIN", function(ADJ)

    do local _ = ZG.PUT(ZG.P_ITBL, ZG.P_VERB, ZG.GET(ZG.P_OTBL, ZG.P_VERB)) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_ACLAUSE) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.ADD(ZG.P_ACLAUSE, 1)) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_ACLAUSE) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DEPTR, ZG.ADD(ZG.P_ACLAUSE, 1)) end
    do local _ = ZG.CLAUSE_COPY(ZG.P_OTBL, ZG.P_OTBL, ADJ) end
    do local _ = ((not ZG.EQ(ZG.GET(ZG.P_OTBL, ZG.P_NC2), 0)) and ZG._set("P_NCN", 2)) end
    ZG._set("P_ACLAUSE", false)
    do return true end

end, "ACLAUSE-WIN")

ZG.ACLAUSE_WIN = ZG.actions:get("ACLAUSE_WIN")

-- zil: gparser.zil:645  <ROUTINE NCLAUSE-WIN ()>
ZG.actions:register("NCLAUSE_WIN", function()

    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_NC1) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.P_NC1L) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_ACLAUSE) end
    do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DEPTR, ZG.ADD(ZG.P_ACLAUSE, 1)) end
    do local _ = ZG.CLAUSE_COPY(ZG.P_ITBL, ZG.P_OTBL) end
    do local _ = ((not ZG.EQ(ZG.GET(ZG.P_OTBL, ZG.P_NC2), 0)) and ZG._set("P_NCN", 2)) end
    ZG._set("P_ACLAUSE", false)
    do return true end

end, "NCLAUSE-WIN")

ZG.NCLAUSE_WIN = ZG.actions:get("NCLAUSE_WIN")

-- ;"Print undefined word in input.
--    PTR points to the unknown word in P-LEXV"

-- zil: gparser.zil:658  <ROUTINE WORD-PRINT (CNT BUF)>
ZG.actions:register("WORD_PRINT", function(CNT, BUF)

    while true do
        if (function() CNT = ZG.SUB(CNT, 1); return CNT < 0 end)() then
            do return true end
        else
            do local _ = ZG.PRINTC(ZG.GETB(ZG.P_INBUF, BUF)) end
            BUF = ZG.ADD(BUF, 1)
        end
    end

end, "WORD-PRINT")

ZG.WORD_PRINT = ZG.actions:get("WORD_PRINT")

-- zil: gparser.zil:665  <ROUTINE UNKNOWN-WORD (PTR "AUX" BUF)>
ZG.actions:register("UNKNOWN_WORD", function(PTR)

    local BUF = 0
    do local _ = ZG.PUT(ZG.OOPS_TABLE, ZG.O_PTR, PTR) end
    if ZG._T(ZG.VERB_p("SAY")) then
        do local _ = ZG.TELL("Nothing happens.", ZG._TK.CR) end
        do return false end
    end
    do local _ = ZG.TELL("I don't know the word \"") end
    do local _ = ZG.WORD_PRINT(ZG.GETB(ZG.REST(ZG.P_LEXV, (function() BUF = (PTR * 2); return BUF end)()), 2), ZG.GETB(ZG.REST(ZG.P_LEXV, BUF), 3)) end
    do local _ = ZG.TELL("\".", ZG._TK.CR) end
    ZG._set("QUOTE_FLAG", false)
    ZG._set("P_OFLAG", false)
    do return ZG.P_OFLAG end

end, "UNKNOWN-WORD")

ZG.UNKNOWN_WORD = ZG.actions:get("UNKNOWN_WORD")

-- zil: gparser.zil:677  <ROUTINE CANT-USE (PTR "AUX" BUF)>
ZG.actions:register("CANT_USE", function(PTR)

    local BUF = 0
    if ZG._T(ZG.VERB_p("SAY")) then
        do local _ = ZG.TELL("Nothing happens.", ZG._TK.CR) end
        do return false end
    end
    do local _ = ZG.TELL("You used the word \"") end
    do local _ = ZG.WORD_PRINT(ZG.GETB(ZG.REST(ZG.P_LEXV, (function() BUF = (PTR * 2); return BUF end)()), 2), ZG.GETB(ZG.REST(ZG.P_LEXV, BUF), 3)) end
    do local _ = ZG.TELL("\" in a way that I don't understand.", ZG._TK.CR) end
    ZG._set("QUOTE_FLAG", false)
    ZG._set("P_OFLAG", false)
    do return ZG.P_OFLAG end

end, "CANT-USE")

ZG.CANT_USE = ZG.actions:get("CANT_USE")

-- ;" Perform syntax matching operations, using P-ITBL as the source of
--    the verb and adjectives for this input.  Returns false if no
--    syntax matches, and does it's own orphaning.  If return is true,
--    the syntax is saved in P-SYNTAX."

-- zil: gparser.zil:693  <GLOBAL P-SLOCBITS>
-- P_SLOCBITS is declared in ZilGlobal.lua

-- zil: gparser.zil:695  <CONSTANT P-SYNLEN>
-- P_SYNLEN is declared in ZilGlobal.lua

-- zil: gparser.zil:697  <CONSTANT P-SBITS>
-- P_SBITS is declared in ZilGlobal.lua

-- zil: gparser.zil:698  <CONSTANT P-SPREP1>
-- P_SPREP1 is declared in ZilGlobal.lua

-- zil: gparser.zil:699  <CONSTANT P-SPREP2>
-- P_SPREP2 is declared in ZilGlobal.lua

-- zil: gparser.zil:700  <CONSTANT P-SFWIM1>
-- P_SFWIM1 is declared in ZilGlobal.lua

-- zil: gparser.zil:701  <CONSTANT P-SFWIM2>
-- P_SFWIM2 is declared in ZilGlobal.lua

-- zil: gparser.zil:702  <CONSTANT P-SLOC1>
-- P_SLOC1 is declared in ZilGlobal.lua

-- zil: gparser.zil:703  <CONSTANT P-SLOC2>
-- P_SLOC2 is declared in ZilGlobal.lua

-- zil: gparser.zil:704  <CONSTANT P-SACTION>
-- P_SACTION is declared in ZilGlobal.lua

-- zil: gparser.zil:705  <CONSTANT P-SONUMS>
-- P_SONUMS is declared in ZilGlobal.lua

-- zil: gparser.zil:707  <ROUTINE SYNTAX-CHECK ("AUX" SYN LEN NUM OBJ (DRIVE1 <>) (DRIVE2 <>) PREP VER...
ZG.actions:register("SYNTAX_CHECK", function()

    local _tmp1, _tmp2
    local SYN = 0
    local LEN = 0
    local NUM = 0
    local OBJ = 0
    local DRIVE1 = false
    local DRIVE2 = false
    local PREP = 0
    local VERB = 0
    local TMP = 0
    if ZG.ZERO_p((function() VERB = ZG.GET(ZG.P_ITBL, ZG.P_VERB); return VERB end)()) then
        do local _ = ZG.TELL("There was no verb in that sentence!", ZG._TK.CR) end
        do return false end
    end
    SYN = ZG.GET(ZG.VERBS, ZG.SUB(255, VERB))
    LEN = ZG.GETB(SYN, 0)
    SYN = ZG.REST(SYN)
    while true do
        NUM = ZG.BAND(ZG.GETB(SYN, ZG.P_SBITS), ZG.P_SONUMS)
        if ZG.LT(NUM, ZG.P_NCN) then
        elseif ((not ZG.LT(NUM, 1)) and ZG.ZERO_p(ZG.P_NCN) and (ZG.ZERO_p((function() PREP = ZG.GET(ZG.P_ITBL, ZG.P_PREP1); return PREP end)()) or ZG.EQ(PREP, ZG.GETB(SYN, ZG.P_SPREP1)))) then
            DRIVE1 = SYN
        elseif ZG.EQ(ZG.GETB(SYN, ZG.P_SPREP1), ZG.GET(ZG.P_ITBL, ZG.P_PREP1)) then
            if (ZG.EQ(NUM, 2) and ZG.EQ(ZG.P_NCN, 1)) then
                DRIVE2 = SYN
            elseif ZG.EQ(ZG.GETB(SYN, ZG.P_SPREP2), ZG.GET(ZG.P_ITBL, ZG.P_PREP2)) then
                do local _ = ZG.SYNTAX_FOUND(SYN) end
                do return true end
            end
        end
        if (function() LEN = ZG.SUB(LEN, 1); return LEN < 1 end)() then
            if (ZG._T(DRIVE1) or ZG._T(DRIVE2)) then
                break
            else
                do local _ = ZG.TELL("That sentence isn't one I recognize.", ZG._TK.CR) end
                do return false end
            end
        else
            SYN = ZG.REST(SYN, ZG.P_SYNLEN)
        end
    end
    if (ZG._T(DRIVE1) and ZG._T((function() OBJ = ZG.GWIM(ZG.GETB(DRIVE1, ZG.P_SFWIM1), ZG.GETB(DRIVE1, ZG.P_SLOC1), ZG.GETB(DRIVE1, ZG.P_SPREP1)); return OBJ end)())) then
        do local _ = ZG.PUT(ZG.P_PRSO, ZG.P_MATCHLEN, 1) end
        do local _ = ZG.PUT(ZG.P_PRSO, 1, OBJ) end
        do return ZG.SYNTAX_FOUND(DRIVE1) end
    elseif (ZG._T(DRIVE2) and ZG._T((function() OBJ = ZG.GWIM(ZG.GETB(DRIVE2, ZG.P_SFWIM2), ZG.GETB(DRIVE2, ZG.P_SLOC2), ZG.GETB(DRIVE2, ZG.P_SPREP2)); return OBJ end)())) then
        do local _ = ZG.PUT(ZG.P_PRSI, ZG.P_MATCHLEN, 1) end
        do local _ = ZG.PUT(ZG.P_PRSI, 1, OBJ) end
        do return ZG.SYNTAX_FOUND(DRIVE2) end
    elseif ZG.EQ(VERB, ZG.SYMBOL("ACT?FIND")) then
        do local _ = ZG.TELL("That question can't be answered.", ZG._TK.CR) end
        do return false end
    elseif (not ZG.EQ(ZG.WINNER, ZG.PLAYER)) then
        do return ZG.CANT_ORPHAN() end
    else
        do local _ = ZG.ORPHAN(DRIVE1, DRIVE2) end
        do local _ = ZG.TELL("What do you want to ") end
        TMP = ZG.GET(ZG.P_OTBL, ZG.P_VERBN)
        if ZG.EQ(TMP, 0) then
            do local _ = ZG.TELL("tell") end
        elseif ZG.ZERO_p(ZG.GETB(ZG.P_VTBL, 2)) then
            do local _ = ZG.PRINTB(ZG.GET(TMP, 0)) end
        else
            do local _ = ZG.WORD_PRINT(ZG.GETB(TMP, 2), ZG.GETB(TMP, 3)) end
            do local _ = ZG.PUTB(ZG.P_VTBL, 2, 0) end
        end
        if ZG._T(DRIVE2) then
            do local _ = ZG.TELL(" ") end
            do local _ = ZG.THING_PRINT(true, true) end
        end
        ZG._set("P_OFLAG", true)
        if ZG._T(DRIVE1) then
            _tmp1 = ZG.GETB(DRIVE1, ZG.P_SPREP1)
        else
            _tmp1 = ZG.GETB(DRIVE2, ZG.P_SPREP2)
        end
        if ZG._T(DRIVE1) then
            _tmp2 = ZG.GETB(DRIVE1, ZG.P_SPREP1)
        else
            _tmp2 = ZG.GETB(DRIVE2, ZG.P_SPREP2)
        end
        do local _ = ZG.PREP_PRINT(_tmp2) end
        do local _ = ZG.TELL("?", ZG._TK.CR) end
        do return false end
    end

end, "SYNTAX-CHECK")

ZG.SYNTAX_CHECK = ZG.actions:get("SYNTAX_CHECK")

-- zil: gparser.zil:777  <ROUTINE CANT-ORPHAN ()>
ZG.actions:register("CANT_ORPHAN", function()

    do local _ = ZG.TELL("\"I don't understand! What are you referring to?\"", ZG._TK.CR) end
    do return false end

end, "CANT-ORPHAN")

ZG.CANT_ORPHAN = ZG.actions:get("CANT_ORPHAN")

-- zil: gparser.zil:782  <ROUTINE ORPHAN (D1 D2 "AUX" (CNT -1))>
ZG.actions:register("ORPHAN", function(D1, D2)

    local CNT = -1
    if (not ZG._T(ZG.P_MERGED)) then
        do local _ = ZG.PUT(ZG.P_OCLAUSE, ZG.P_MATCHLEN, 0) end
    end
    do local _ = ZG.PUT(ZG.P_OVTBL, 0, ZG.GET(ZG.P_VTBL, 0)) end
    do local _ = ZG.PUTB(ZG.P_OVTBL, 2, ZG.GETB(ZG.P_VTBL, 2)) end
    do local _ = ZG.PUTB(ZG.P_OVTBL, 3, ZG.GETB(ZG.P_VTBL, 3)) end
    while true do
        if (function() CNT = ZG.ADD(CNT, 1); return CNT > ZG.P_ITBLLEN end)() then
            break
        else
            do local _ = ZG.PUT(ZG.P_OTBL, CNT, ZG.GET(ZG.P_ITBL, CNT)) end
        end
    end
    if ZG.EQ(ZG.P_NCN, 2) then
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_NC2) end
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.P_NC2L) end
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_NC2) end
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DEPTR, ZG.P_NC2L) end
        do local _ = ZG.CLAUSE_COPY(ZG.P_ITBL, ZG.P_OTBL) end
    end
    if (not ZG.LT(ZG.P_NCN, 1)) then
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_NC1) end
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.P_NC1L) end
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_NC1) end
        do local _ = ZG.PUT(ZG.P_CCTBL, ZG.CC_DEPTR, ZG.P_NC1L) end
        do local _ = ZG.CLAUSE_COPY(ZG.P_ITBL, ZG.P_OTBL) end
    end
    if ZG._T(D1) then
        do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_PREP1, ZG.GETB(D1, ZG.P_SPREP1)) end
        do return ZG.PUT(ZG.P_OTBL, ZG.P_NC1, 1) end
    elseif ZG._T(D2) then
        do local _ = ZG.PUT(ZG.P_OTBL, ZG.P_PREP2, ZG.GETB(D2, ZG.P_SPREP2)) end
        do return ZG.PUT(ZG.P_OTBL, ZG.P_NC2, 1) end
    else
        do return false end
    end

end, "ORPHAN")

ZG.ORPHAN = ZG.actions:get("ORPHAN")

-- ;<ROUTINE CLAUSE-PRINT (BPTR EPTR "OPTIONAL" (THE? T))
-- 	<BUFFER-PRINT <GET ,P-ITBL .BPTR> <GET ,P-ITBL .EPTR> .THE?>>

-- zil: gparser.zil:813  <ROUTINE THING-PRINT (PRSO? "OPTIONAL" (THE? <>) "AUX" BEG END)>
ZG.actions:register("THING_PRINT", function(PRSO_p_l, THE_p)

    if THE_p == nil then THE_p = false end
    local BEG = 0
    local END = 0
    if ZG._T(PRSO_p_l) then
        BEG = ZG.GET(ZG.P_ITBL, ZG.P_NC1)
        END = ZG.GET(ZG.P_ITBL, ZG.P_NC1L)
    else
        BEG = ZG.GET(ZG.P_ITBL, ZG.P_NC2)
        END = ZG.GET(ZG.P_ITBL, ZG.P_NC2L)
    end
    do return ZG.BUFFER_PRINT(BEG, END, THE_p) end

end, "THING-PRINT")

ZG.THING_PRINT = ZG.actions:get("THING_PRINT")

-- zil: gparser.zil:822  <ROUTINE BUFFER-PRINT (BEG END CP "AUX" (NOSP T) WRD (FIRST?? T) (PN <>) (Q? ...
ZG.actions:register("BUFFER_PRINT", function(BEG, END, CP)

    local NOSP = true
    local WRD = 0
    local FIRST__p = true
    local PN = false
    local Q_p = false
    while true do
        if ZG.EQ(BEG, END) then
            do return true end
        else
            WRD = ZG.GET(BEG, 0)
            if ZG.EQ(WRD, ZG.WORD("comma")) then
                do local _ = ZG.TELL(", ") end
            elseif ZG._T(NOSP) then
                NOSP = false
            else
                do local _ = ZG.TELL(" ") end
            end
            if ZG.EQUAL_p(WRD, ZG.WORD("period"), ZG.WORD("comma")) then
                NOSP = true
            elseif ZG.EQ(WRD, ZG.WORD("me")) then
                do local _ = ZG.PRINTD(ZG.ME) end
                PN = true
            elseif ZG.EQ(WRD, ZG.WORD("intnum")) then
                do local _ = ZG.PRINTN(ZG.P_NUMBER) end
                PN = true
            else
                if (ZG._T(FIRST__p) and (not ZG._T(PN)) and ZG._T(CP)) then
                    do local _ = ZG.TELL("the ") end
                end
                if (ZG._T(ZG.P_OFLAG) or ZG._T(ZG.P_MERGED)) then
                    do local _ = ZG.PRINTB(WRD) end
                elseif (ZG.EQ(WRD, ZG.WORD("it")) and ZG._T(ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT))) then
                    do local _ = ZG.PRINTD(ZG.P_IT_OBJECT) end
                else
                    do local _ = ZG.WORD_PRINT(ZG.GETB(BEG, 2), ZG.GETB(BEG, 3)) end
                end
                FIRST__p = false
            end
        end
        BEG = ZG.REST(BEG, ZG.P_WORDLEN)
    end

end, "BUFFER-PRINT")

ZG.BUFFER_PRINT = ZG.actions:get("BUFFER_PRINT")

-- zil: gparser.zil:854  <ROUTINE PREP-PRINT (PREP "AUX" WRD)>
ZG.actions:register("PREP_PRINT", function(PREP)

    local WRD = 0
    if (not ZG.ZERO_p(PREP)) then
        do local _ = ZG.TELL(" ") end
        WRD = ZG.PREP_FIND(PREP)
        do return ZG.PRINTB(WRD) end
    else
        do return false end
    end

end, "PREP-PRINT")

ZG.PREP_PRINT = ZG.actions:get("PREP_PRINT")

-- zil: gparser.zil:863  <ROUTINE CLAUSE-COPY (SRC DEST "OPTIONAL" (INSRT <>) "AUX" BEG END)>
ZG.actions:register("CLAUSE_COPY", function(SRC, DEST, INSRT)

    if INSRT == nil then INSRT = false end
    local BEG = 0
    local END = 0
    BEG = ZG.GET(SRC, ZG.GET(ZG.P_CCTBL, ZG.CC_SBPTR))
    END = ZG.GET(SRC, ZG.GET(ZG.P_CCTBL, ZG.CC_SEPTR))
    do local _ = ZG.PUT(DEST, ZG.GET(ZG.P_CCTBL, ZG.CC_DBPTR), ZG.REST(ZG.P_OCLAUSE, ZG.ADD((ZG.GET(ZG.P_OCLAUSE, ZG.P_MATCHLEN) * ZG.P_LEXELEN), 2))) end
    while true do
        if ZG.EQ(BEG, END) then
            do local _ = ZG.PUT(DEST, ZG.GET(ZG.P_CCTBL, ZG.CC_DEPTR), ZG.REST(ZG.P_OCLAUSE, ZG.ADD((ZG.GET(ZG.P_OCLAUSE, ZG.P_MATCHLEN) * ZG.P_LEXELEN), 2))) end
            do return true end
        else
            if (ZG._T(INSRT) and ZG.EQ(ZG.P_ANAM, ZG.GET(BEG, 0))) then
                do local _ = ZG.CLAUSE_ADD(INSRT) end
            end
            do local _ = ZG.CLAUSE_ADD(ZG.GET(BEG, 0)) end
        end
        BEG = ZG.REST(BEG, ZG.P_WORDLEN)
    end

end, "CLAUSE-COPY")

ZG.CLAUSE_COPY = ZG.actions:get("CLAUSE_COPY")

-- zil: gparser.zil:885  <ROUTINE CLAUSE-ADD (WRD "AUX" PTR)>
ZG.actions:register("CLAUSE_ADD", function(WRD)

    local PTR = 0
    PTR = ZG.ADD(ZG.GET(ZG.P_OCLAUSE, ZG.P_MATCHLEN), 2)
    do local _ = ZG.PUT(ZG.P_OCLAUSE, ZG.SUB(PTR, 1), WRD) end
    do local _ = ZG.PUT(ZG.P_OCLAUSE, PTR, 0) end
    do return ZG.PUT(ZG.P_OCLAUSE, ZG.P_MATCHLEN, PTR) end

end, "CLAUSE-ADD")

ZG.CLAUSE_ADD = ZG.actions:get("CLAUSE_ADD")

-- zil: gparser.zil:891  <ROUTINE PREP-FIND (PREP "AUX" (CNT 0) SIZE)>
ZG.actions:register("PREP_FIND", function(PREP)

    local CNT = 0
    local SIZE = 0
    SIZE = (ZG.GET(ZG.PREPOSITIONS, 0) * 2)
    while true do
        if (function() CNT = ZG.ADD(CNT, 1); return CNT > SIZE end)() then
            do return false end
        elseif ZG.EQ(ZG.GET(ZG.PREPOSITIONS, CNT), PREP) then
            do return ZG.GET(ZG.PREPOSITIONS, ZG.SUB(CNT, 1)) end
        end
    end

end, "PREP-FIND")

ZG.PREP_FIND = ZG.actions:get("PREP_FIND")

-- zil: gparser.zil:898  <ROUTINE SYNTAX-FOUND (SYN)>
ZG.actions:register("SYNTAX_FOUND", function(SYN)

    ZG._set("P_SYNTAX", SYN)
    ZG._set("PRSA", ZG.GETB(SYN, ZG.P_SACTION))
    do return ZG.PRSA end

end, "SYNTAX-FOUND")

ZG.SYNTAX_FOUND = ZG.actions:get("SYNTAX_FOUND")

-- zil: gparser.zil:902  <GLOBAL P-GWIMBIT>
-- P_GWIMBIT is declared in ZilGlobal.lua

-- zil: gparser.zil:904  <ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ)>
ZG.actions:register("GWIM", function(GBIT, LBIT, PREP)

    local OBJ = 0
    if ZG.EQ(GBIT, "RMUNGBIT") then
        do return ZG.ROOMS end
    end
    ZG._set("P_GWIMBIT", GBIT)
    ZG._set("P_SLOCBITS", LBIT)
    do local _ = ZG.PUT(ZG.P_MERGE, ZG.P_MATCHLEN, 0) end
    if ZG._T(ZG.GET_OBJECT(ZG.P_MERGE, false)) then
        ZG._set("P_GWIMBIT", 0)
        if ZG.EQ(ZG.GET(ZG.P_MERGE, ZG.P_MATCHLEN), 1) then
            OBJ = ZG.GET(ZG.P_MERGE, 1)
            do local _ = ZG.TELL("(") end
            if ((not ZG.ZERO_p(PREP)) and (not ZG._T(ZG.P_END_ON_PREP))) then
                do local _ = ZG.PRINTB((function() PREP = ZG.PREP_FIND(PREP); return PREP end)()) end
                if ZG.EQ(PREP, ZG.WORD("out")) then
                    do local _ = ZG.TELL(" of") end
                end
                do local _ = ZG.TELL(" ") end
                if ZG.EQ(OBJ, ZG.HANDS) then
                    do local _ = ZG.TELL("your hands") end
                else
                    do local _ = ZG.TELL("the ", ZG._TK.D, OBJ) end
                end
                do local _ = ZG.TELL(")", ZG._TK.CR) end
            else
                do local _ = ZG.TELL(ZG._TK.D, OBJ, ")", ZG._TK.CR) end
            end
            do return OBJ end
        else
            do return false end
        end
    else
        ZG._set("P_GWIMBIT", 0)
        do return false end
    end

end, "GWIM")

ZG.GWIM = ZG.actions:get("GWIM")

-- zil: gparser.zil:931  <ROUTINE SNARF-OBJECTS ("AUX" OPTR IPTR L)>
ZG.actions:register("SNARF_OBJECTS", function()

    local OPTR = 0
    local IPTR = 0
    local L = 0
    do local _ = ZG.PUT(ZG.P_BUTS, ZG.P_MATCHLEN, 0) end
    if (not ZG.EQ((function() IPTR = ZG.GET(ZG.P_ITBL, ZG.P_NC2); return IPTR end)(), 0)) then
        ZG._set("P_SLOCBITS", ZG.GETB(ZG.P_SYNTAX, ZG.P_SLOC2))
        if (not ZG._T(ZG.SNARFEM(IPTR, ZG.GET(ZG.P_ITBL, ZG.P_NC2L), ZG.P_PRSI))) then
            do return false end
        end
    end
    if (not ZG.EQ((function() OPTR = ZG.GET(ZG.P_ITBL, ZG.P_NC1); return OPTR end)(), 0)) then
        ZG._set("P_SLOCBITS", ZG.GETB(ZG.P_SYNTAX, ZG.P_SLOC1))
        if (not ZG._T(ZG.SNARFEM(OPTR, ZG.GET(ZG.P_ITBL, ZG.P_NC1L), ZG.P_PRSO))) then
            do return false end
        end
    end
    if (not ZG.ZERO_p(ZG.GET(ZG.P_BUTS, ZG.P_MATCHLEN))) then
        L = ZG.GET(ZG.P_PRSO, ZG.P_MATCHLEN)
        if ZG._T(OPTR) then
            ZG._set("P_PRSO", ZG.BUT_MERGE(ZG.P_PRSO))
        end
        if (ZG._T(IPTR) and ((not ZG._T(OPTR)) or ZG.EQ(L, ZG.GET(ZG.P_PRSO, ZG.P_MATCHLEN)))) then
            ZG._set("P_PRSI", ZG.BUT_MERGE(ZG.P_PRSI))
        end
    end
    do return true end

end, "SNARF-OBJECTS")

ZG.SNARF_OBJECTS = ZG.actions:get("SNARF_OBJECTS")

-- zil: gparser.zil:948  <ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL)>
ZG.actions:register("BUT_MERGE", function(TBL)

    local LEN = 0
    local BUTLEN = 0
    local CNT = 1
    local MATCHES = 0
    local OBJ = 0
    local NTBL = 0
    LEN = ZG.GET(TBL, ZG.P_MATCHLEN)
    do local _ = ZG.PUT(ZG.P_MERGE, ZG.P_MATCHLEN, 0) end
    while true do
        if (function() LEN = ZG.SUB(LEN, 1); return LEN < 0 end)() then
            break
        elseif ZG._T(ZG.ZMEMQ((function() OBJ = ZG.GET(TBL, CNT); return OBJ end)(), ZG.P_BUTS)) then
        else
            do local _ = ZG.PUT(ZG.P_MERGE, ZG.ADD(MATCHES, 1), OBJ) end
            MATCHES = ZG.ADD(MATCHES, 1)
        end
        CNT = ZG.ADD(CNT, 1)
    end
    do local _ = ZG.PUT(ZG.P_MERGE, ZG.P_MATCHLEN, MATCHES) end
    NTBL = ZG.P_MERGE
    ZG._set("P_MERGE", TBL)
    do return NTBL end

end, "BUT-MERGE")

ZG.BUT_MERGE = ZG.actions:get("BUT_MERGE")

-- zil: gparser.zil:963  <GLOBAL P-NAM>
-- P_NAM is declared in ZilGlobal.lua

-- zil: gparser.zil:964  <GLOBAL P-ADJ>
-- P_ADJ is declared in ZilGlobal.lua

-- zil: gparser.zil:965  <GLOBAL P-ADVERB>
-- P_ADVERB is declared in ZilGlobal.lua

-- zil: gparser.zil:966  <GLOBAL P-ADJN>
-- P_ADJN is declared in ZilGlobal.lua

-- zil: gparser.zil:967  <GLOBAL P-PRSO>
-- P_PRSO is declared in ZilGlobal.lua

-- zil: gparser.zil:968  <GLOBAL P-PRSI>
-- P_PRSI is declared in ZilGlobal.lua

-- zil: gparser.zil:969  <GLOBAL P-BUTS>
-- P_BUTS is declared in ZilGlobal.lua

-- zil: gparser.zil:970  <GLOBAL P-MERGE>
-- P_MERGE is declared in ZilGlobal.lua

-- zil: gparser.zil:971  <GLOBAL P-OCLAUSE>
-- P_OCLAUSE is declared in ZilGlobal.lua

-- zil: gparser.zil:972  <GLOBAL P-MATCHLEN>
-- P_MATCHLEN is declared in ZilGlobal.lua

-- zil: gparser.zil:973  <GLOBAL P-GETFLAGS>
-- P_GETFLAGS is declared in ZilGlobal.lua

-- zil: gparser.zil:974  <CONSTANT P-ALL>
-- P_ALL is declared in ZilGlobal.lua

-- zil: gparser.zil:975  <CONSTANT P-ONE>
-- P_ONE is declared in ZilGlobal.lua

-- zil: gparser.zil:976  <CONSTANT P-INHIBIT>
-- P_INHIBIT is declared in ZilGlobal.lua

-- zil: gparser.zil:979  <GLOBAL P-AND>
-- P_AND is declared in ZilGlobal.lua

-- zil: gparser.zil:981  <ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL <>))>
ZG.actions:register("SNARFEM", function(PTR, EPTR, TBL)

    local BUT = false
    local LEN = 0
    local WV = 0
    local WRD = 0
    local NW = 0
    local WAS_ALL = false
    ZG._set("P_AND", false)
    if ZG.EQ(ZG.P_GETFLAGS, ZG.P_ALL) then
        WAS_ALL = true
    end
    ZG._set("P_GETFLAGS", 0)
    do local _ = ZG.PUT(TBL, ZG.P_MATCHLEN, 0) end
    WRD = ZG.GET(PTR, 0)
    while true do
        if ZG.EQ(PTR, EPTR) then
            WV = ZG.GET_OBJECT((function() local _v = BUT; if ZG._T(_v) then return _v end; return TBL end)())
            if ZG._T(WAS_ALL) then
                ZG._set("P_GETFLAGS", ZG.P_ALL)
            end
            do return WV end
        else
            if ZG.EQ(EPTR, ZG.REST(PTR, ZG.P_WORDLEN)) then
                NW = 0
            else
                NW = ZG.GET(PTR, ZG.P_LEXELEN)
            end
            if ZG.EQ(WRD, ZG.WORD("all")) then
                ZG._set("P_GETFLAGS", ZG.P_ALL)
                if ZG.EQ(NW, ZG.WORD("of")) then
                    PTR = ZG.REST(PTR, ZG.P_WORDLEN)
                end
            elseif ZG.EQUAL_p(WRD, ZG.WORD("but"), ZG.WORD("except")) then
                if (not ZG._T(ZG.GET_OBJECT((function() local _v = BUT; if ZG._T(_v) then return _v end; return TBL end)()))) then
                    do return false end
                end
                BUT = ZG.P_BUTS
                do local _ = ZG.PUT(BUT, ZG.P_MATCHLEN, 0) end
            elseif ZG.EQUAL_p(WRD, ZG.WORD("a"), ZG.WORD("one")) then
                if (not ZG._T(ZG.P_ADJ)) then
                    ZG._set("P_GETFLAGS", ZG.P_ONE)
                    if ZG.EQ(NW, ZG.WORD("of")) then
                        PTR = ZG.REST(PTR, ZG.P_WORDLEN)
                    end
                else
                    ZG._set("P_NAM", ZG.P_ONEOBJ)
                    if (not ZG._T(ZG.GET_OBJECT((function() local _v = BUT; if ZG._T(_v) then return _v end; return TBL end)()))) then
                        do return false end
                    end
                    if ZG.ZERO_p(NW) then
                        do return true end
                    end
                end
            elseif (ZG.EQUAL_p(WRD, ZG.WORD("and"), ZG.WORD("comma")) and (not ZG.EQUAL_p(NW, ZG.WORD("and"), ZG.WORD("comma")))) then
                ZG._set("P_AND", true)
                if (not ZG._T(ZG.GET_OBJECT((function() local _v = BUT; if ZG._T(_v) then return _v end; return TBL end)()))) then
                    do return false end
                end
            elseif ZG._T(ZG.WT_p(WRD, ZG.PS_BUZZ_WORD)) then
            elseif ZG.EQUAL_p(WRD, ZG.WORD("and"), ZG.WORD("comma")) then
            elseif ZG.EQ(WRD, ZG.WORD("of")) then
                if ZG.ZERO_p(ZG.P_GETFLAGS) then
                    ZG._set("P_GETFLAGS", ZG.P_INHIBIT)
                end
            elseif (ZG._T((function() WV = ZG.WT_p(WRD, ZG.PS_ADJECTIVE, ZG.P1_ADJECTIVE); return WV end)()) and (not ZG._T(ZG.P_ADJ))) then
                ZG._set("P_ADJ", WV)
                ZG._set("P_ADJN", WRD)
            elseif ZG._T(ZG.WT_p(WRD, ZG.PS_OBJECT, ZG.P1_OBJECT)) then
                ZG._set("P_NAM", WRD)
                ZG._set("P_ONEOBJ", WRD)
            end
        end
        if (not ZG.EQ(PTR, EPTR)) then
            PTR = ZG.REST(PTR, ZG.P_WORDLEN)
            WRD = NW
        end
    end

end, "SNARFEM")

ZG.SNARFEM = ZG.actions:get("SNARFEM")

-- zil: gparser.zil:1035  <CONSTANT SH>
-- SH is declared in ZilGlobal.lua

-- zil: gparser.zil:1036  <CONSTANT SC>
-- SC is declared in ZilGlobal.lua

-- zil: gparser.zil:1037  <CONSTANT SIR>
-- SIR is declared in ZilGlobal.lua

-- zil: gparser.zil:1038  <CONSTANT SOG>
-- SOG is declared in ZilGlobal.lua

-- zil: gparser.zil:1039  <CONSTANT STAKE>
-- STAKE is declared in ZilGlobal.lua

-- zil: gparser.zil:1040  <CONSTANT SMANY>
-- SMANY is declared in ZilGlobal.lua

-- zil: gparser.zil:1041  <CONSTANT SHAVE>
-- SHAVE is declared in ZilGlobal.lua

-- zil: gparser.zil:1043  <ROUTINE GET-OBJECT (TBL "OPTIONAL" (VRB T) "AUX" BITS LEN XBITS TLEN (GCHECK...
ZG.actions:register("GET_OBJECT", function(TBL, VRB)

    local _tmp1
    if VRB == nil then VRB = true end
    local BITS = 0
    local LEN = 0
    local XBITS = 0
    local TLEN = 0
    local GCHECK = false
    local OLEN = 0
    local OBJ = 0
    XBITS = ZG.P_SLOCBITS
    TLEN = ZG.GET(TBL, ZG.P_MATCHLEN)
    if ZG._T(ZG.BTST(ZG.P_GETFLAGS, ZG.P_INHIBIT)) then
        do return true end
    end
    if ((not ZG._T(ZG.P_NAM)) and ZG._T(ZG.P_ADJ)) then
        if ZG._T(ZG.WT_p(ZG.P_ADJN, ZG.PS_OBJECT, ZG.P1_OBJECT)) then
            ZG._set("P_NAM", ZG.P_ADJN)
            ZG._set("P_ADJ", false)
        elseif ZG._T((function() BITS = ZG.WT_p(ZG.P_ADJN, ZG.PS_DIRECTION, ZG.P1_DIRECTION); return BITS end)()) then
            ZG._set("P_ADJ", false)
            do local _ = ZG.PUT(TBL, ZG.P_MATCHLEN, 1) end
            do local _ = ZG.PUT(TBL, 1, ZG.INTDIR) end
            ZG._set("P_DIRECTION", BITS)
            do return true end
        end
    end
    if ((not ZG._T(ZG.P_NAM)) and (not ZG._T(ZG.P_ADJ)) and (not ZG.EQ(ZG.P_GETFLAGS, ZG.P_ALL)) and ZG.ZERO_p(ZG.P_GWIMBIT)) then
        if ZG._T(VRB) then
            do local _ = ZG.TELL("There seems to be a noun missing in that sentence!", ZG._TK.CR) end
        end
        do return false end
    end
    if ((not ZG.EQ(ZG.P_GETFLAGS, ZG.P_ALL)) or ZG.ZERO_p(ZG.P_SLOCBITS)) then
        ZG._set("P_SLOCBITS", -1)
    end
    ZG._set("P_TABLE", TBL)
    while true do
        local _brk1 = false
        repeat
            if ZG._T(GCHECK) then
                do local _ = ZG.GLOBAL_CHECK(TBL) end
            else
                if ZG._T(ZG.LIT) then
                    do local _ = ZG.FCLEAR(ZG.PLAYER, "TRANSBIT") end
                    do local _ = ZG.DO_SL(ZG.HERE, ZG.SOG, ZG.SIR) end
                    do local _ = ZG.FSET(ZG.PLAYER, "TRANSBIT") end
                end
                do local _ = ZG.DO_SL(ZG.PLAYER, ZG.SH, ZG.SC) end
            end
            LEN = ZG.SUB(ZG.GET(TBL, ZG.P_MATCHLEN), TLEN)
            if ZG._T(ZG.BTST(ZG.P_GETFLAGS, ZG.P_ALL)) then
            elseif (ZG._T(ZG.BTST(ZG.P_GETFLAGS, ZG.P_ONE)) and (not ZG.ZERO_p(LEN))) then
                if (not ZG.EQ(LEN, 1)) then
                    do local _ = ZG.PUT(TBL, 1, ZG.GET(TBL, ZG.RANDOM(LEN))) end
                    do local _ = ZG.TELL("(How about the ") end
                    do local _ = ZG.PRINTD(ZG.GET(TBL, 1)) end
                    do local _ = ZG.TELL("?)", ZG._TK.CR) end
                end
                do local _ = ZG.PUT(TBL, ZG.P_MATCHLEN, 1) end
            elseif (ZG.LT(1, LEN) or (ZG.ZERO_p(LEN) and (not ZG.EQ(ZG.P_SLOCBITS, -1)))) then
                if ZG.EQ(ZG.P_SLOCBITS, -1) then
                    ZG._set("P_SLOCBITS", XBITS)
                    OLEN = LEN
                    do local _ = ZG.PUT(TBL, ZG.P_MATCHLEN, ZG.SUB(ZG.GET(TBL, ZG.P_MATCHLEN), LEN)) end
                    break
                else
                    if ZG.ZERO_p(LEN) then
                        LEN = OLEN
                    end
                    if (not ZG.EQ(ZG.WINNER, ZG.PLAYER)) then
                        do local _ = ZG.CANT_ORPHAN() end
                        do return false end
                    elseif (ZG._T(VRB) and ZG._T(ZG.P_NAM)) then
                        do local _ = ZG.WHICH_PRINT(TLEN, LEN, TBL) end
                        if ZG.EQ(TBL, ZG.P_PRSO) then
                            _tmp1 = ZG.P_NC1
                        else
                            _tmp1 = ZG.P_NC2
                        end
                        ZG._set("P_ACLAUSE", _tmp1)
                        ZG._set("P_AADJ", ZG.P_ADJ)
                        ZG._set("P_ANAM", ZG.P_NAM)
                        do local _ = ZG.ORPHAN(false, false) end
                        ZG._set("P_OFLAG", true)
                    elseif ZG._T(VRB) then
                        do local _ = ZG.TELL("There seems to be a noun missing in that sentence!", ZG._TK.CR) end
                    end
                    ZG._set("P_NAM", false)
                    ZG._set("P_ADJ", false)
                    do return false end
                end
            end
            if (ZG.ZERO_p(LEN) and ZG._T(GCHECK)) then
                if ZG._T(VRB) then
                    ZG._set("P_SLOCBITS", XBITS)
                    if (ZG._T(ZG.LIT) or ZG._T(ZG.VERB_p("TELL"))) then
                        do local _ = ZG.OBJ_FOUND(ZG.NOT_HERE_OBJECT, TBL) end
                        ZG._set("P_XNAM", ZG.P_NAM)
                        ZG._set("P_XADJ", ZG.P_ADJ)
                        ZG._set("P_XADJN", ZG.P_ADJN)
                        ZG._set("P_NAM", false)
                        ZG._set("P_ADJ", false)
                        ZG._set("P_ADJN", false)
                        do return true end
                    else
                        do local _ = ZG.TELL("It's too dark to see!", ZG._TK.CR) end
                    end
                end
                ZG._set("P_NAM", false)
                ZG._set("P_ADJ", false)
                do return false end
            elseif ZG.ZERO_p(LEN) then
                GCHECK = true
                break
            end
            ZG._set("P_SLOCBITS", XBITS)
            ZG._set("P_NAM", false)
            ZG._set("P_ADJ", false)
            do return true end
            _brk1 = true
            break
        until true
        if _brk1 then break end
    end

end, "GET-OBJECT")

ZG.GET_OBJECT = ZG.actions:get("GET_OBJECT")

-- ;<ROUTINE MOBY-FIND (TBL "AUX" FOO LEN)
-- 	 <SETG P-SLOCBITS -1>
-- 	 <SETG P-NAM ,P-XNAM>
-- 	 <SETG P-ADJ ,P-XADJ>
-- 	 <PUT .TBL ,P-MATCHLEN 0>
-- 	 <SET FOO <FIRST? ,ROOMS>>
-- 	 <REPEAT ()
-- 		 <COND (<NOT .FOO> <RETURN>)
-- 		       (T
-- 			<SEARCH-LIST .FOO .TBL ,P-SRCALL>
-- 			<SET FOO <NEXT? .FOO>>)>>
-- 	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 0>
-- 		<DO-SL ,LOCAL-GLOBALS 1 1>)>
-- 	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 0>
-- 		<DO-SL ,ROOMS 1 1>)>
-- 	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 1>
-- 		<SETG P-MOBY-FOUND <GET .TBL 1>>)>
-- 	 <SETG P-NAM <>>
-- 	 <SETG P-ADJ <>>
-- 	 .LEN>

-- ;<GLOBAL P-MOBY-FOUND <>>

-- zil: gparser.zil:1167  <GLOBAL P-XNAM>
-- P_XNAM is declared in ZilGlobal.lua

-- zil: gparser.zil:1168  <GLOBAL P-XADJ>
-- P_XADJ is declared in ZilGlobal.lua

-- zil: gparser.zil:1169  <GLOBAL P-XADJN>
-- P_XADJN is declared in ZilGlobal.lua

-- zil: gparser.zil:1171  <ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)>
ZG.actions:register("WHICH_PRINT", function(TLEN, LEN, TBL)

    local _tmp1, _tmp2
    local OBJ = 0
    local RLEN = 0
    RLEN = LEN
    do local _ = ZG.TELL("Which ") end
    if (ZG._T(ZG.P_OFLAG) or ZG._T(ZG.P_MERGED) or ZG._T(ZG.P_AND)) then
        if ZG._T(ZG.P_NAM) then
            _tmp1 = ZG.P_NAM
        elseif ZG._T(ZG.P_ADJ) then
            _tmp1 = ZG.P_ADJN
        else
            _tmp1 = ZG.WORD("one")
        end
        if ZG._T(ZG.P_NAM) then
            _tmp2 = ZG.P_NAM
        elseif ZG._T(ZG.P_ADJ) then
            _tmp2 = ZG.P_ADJN
        else
            _tmp2 = ZG.WORD("one")
        end
        do local _ = ZG.PRINTB(_tmp2) end
    else
        do local _ = ZG.THING_PRINT(ZG.EQ(TBL, ZG.P_PRSO)) end
    end
    do local _ = ZG.TELL(" do you mean, ") end
    while true do
        TLEN = ZG.ADD(TLEN, 1)
        OBJ = ZG.GET(TBL, TLEN)
        do local _ = ZG.TELL("the ", ZG._TK.D, OBJ) end
        if ZG.EQ(LEN, 2) then
            if (not ZG.EQ(RLEN, 2)) then
                do local _ = ZG.TELL(",") end
            end
            do local _ = ZG.TELL(" or ") end
        elseif ZG.LT(2, LEN) then
            do local _ = ZG.TELL(", ") end
        end
        if ZG.LT((function() LEN = ZG.SUB(LEN, 1); return LEN end)(), 1) then
            do local _ = ZG.TELL("?", ZG._TK.CR) end
            do return true end
        end
    end

end, "WHICH-PRINT")

ZG.WHICH_PRINT = ZG.actions:get("WHICH_PRINT")

-- zil: gparser.zil:1194  <ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS FOO)>
ZG.actions:register("GLOBAL_CHECK", function(TBL)

    local LEN = 0
    local RMG = 0
    local RMGL = 0
    local CNT = 0
    local OBJ = 0
    local OBITS = 0
    local FOO = 0
    LEN = ZG.GET(TBL, ZG.P_MATCHLEN)
    OBITS = ZG.P_SLOCBITS
    if ZG._T((function() RMG = ZG.GETPT(ZG.HERE, "GLOBAL"); return RMG end)()) then
        RMGL = ZG.SUB(ZG.PTSIZE(RMG), 1)
        while true do
            if ZG._T(ZG.THIS_IT_p((function() OBJ = ZG.GETB(RMG, CNT); return OBJ end)(), TBL)) then
                do local _ = ZG.OBJ_FOUND(OBJ, TBL) end
            end
            if (function() CNT = ZG.ADD(CNT, 1); return CNT > RMGL end)() then
                break
            end
        end
    end
    if ZG._T((function() RMG = ZG.GETPT(ZG.HERE, "PSEUDO"); return RMG end)()) then
        RMGL = ZG.SUB(ZG.DIV(ZG.PTSIZE(RMG), 4), 1)
        CNT = 0
        while true do
            if ZG.EQ(ZG.P_NAM, ZG.GET(RMG, (CNT * 2))) then
                do local _ = ZG.PUTP(ZG.PSEUDO_OBJECT, "ACTION", ZG.GET(RMG, ZG.ADD((CNT * 2), 1))) end
                FOO = ZG.BACK(ZG.GETPT(ZG.PSEUDO_OBJECT, "ACTION"), 5)
                do local _ = ZG.PUT(FOO, 0, ZG.GET(ZG.P_NAM, 0)) end
                do local _ = ZG.PUT(FOO, 1, ZG.GET(ZG.P_NAM, 1)) end
                do local _ = ZG.OBJ_FOUND(ZG.PSEUDO_OBJECT, TBL) end
                break
            elseif (function() CNT = ZG.ADD(CNT, 1); return CNT > RMGL end)() then
                break
            end
        end
    end
    if ZG.EQ(ZG.GET(TBL, ZG.P_MATCHLEN), LEN) then
        ZG._set("P_SLOCBITS", -1)
        ZG._set("P_TABLE", TBL)
        do local _ = ZG.DO_SL(ZG.GLOBAL_OBJECTS, 1, 1) end
        ZG._set("P_SLOCBITS", OBITS)
        if (ZG.ZERO_p(ZG.GET(TBL, ZG.P_MATCHLEN)) and ZG.EQUAL_p(ZG.PRSA, ZG.SYMBOL("V?LOOK-INSIDE"), ZG.SYMBOL("V?SEARCH"), ZG.SYMBOL("V?EXAMINE"))) then
            do return ZG.DO_SL(ZG.ROOMS, 1, 1) end
        else
            do return false end
        end
    else
        do return false end
    end

end, "GLOBAL-CHECK")

ZG.GLOBAL_CHECK = ZG.actions:get("GLOBAL_CHECK")

-- zil: gparser.zil:1227  <ROUTINE DO-SL (OBJ BIT1 BIT2 "AUX" BTS)>
ZG.actions:register("DO_SL", function(OBJ, BIT1, BIT2)

    local BTS = 0
    if ZG._T(ZG.BTST(ZG.P_SLOCBITS, ZG.ADD(BIT1, BIT2))) then
        do return ZG.SEARCH_LIST(OBJ, ZG.P_TABLE, ZG.P_SRCALL) end
    else
        if ZG._T(ZG.BTST(ZG.P_SLOCBITS, BIT1)) then
            do return ZG.SEARCH_LIST(OBJ, ZG.P_TABLE, ZG.P_SRCTOP) end
        elseif ZG._T(ZG.BTST(ZG.P_SLOCBITS, BIT2)) then
            do return ZG.SEARCH_LIST(OBJ, ZG.P_TABLE, ZG.P_SRCBOT) end
        else
            do return true end
        end
    end

end, "DO-SL")

ZG.DO_SL = ZG.actions:get("DO_SL")

-- zil: gparser.zil:1237  <CONSTANT P-SRCBOT>
-- P_SRCBOT is declared in ZilGlobal.lua

-- zil: gparser.zil:1238  <CONSTANT P-SRCTOP>
-- P_SRCTOP is declared in ZilGlobal.lua

-- zil: gparser.zil:1239  <CONSTANT P-SRCALL>
-- P_SRCALL is declared in ZilGlobal.lua

-- zil: gparser.zil:1241  <ROUTINE SEARCH-LIST (OBJ TBL LVL "AUX" FLS NOBJ)>
ZG.actions:register("SEARCH_LIST", function(OBJ, TBL, LVL)

    local _tmp1, _tmp2
    local FLS = 0
    local NOBJ = 0
    if ZG._T((function() OBJ = ZG.FIRST_p(OBJ); return OBJ end)()) then
        while true do
            if ((not ZG.EQ(LVL, ZG.P_SRCBOT)) and ZG._T(ZG.GETPT(OBJ, "SYNONYM")) and ZG._T(ZG.THIS_IT_p(OBJ, TBL))) then
                do local _ = ZG.OBJ_FOUND(OBJ, TBL) end
            end
            if (((not ZG.EQ(LVL, ZG.P_SRCTOP)) or ZG._T(ZG.FSET_p(OBJ, "SEARCHBIT")) or ZG._T(ZG.FSET_p(OBJ, "SURFACEBIT"))) and ZG._T((function() NOBJ = ZG.FIRST_p(OBJ); return NOBJ end)()) and (ZG._T(ZG.FSET_p(OBJ, "OPENBIT")) or ZG._T(ZG.FSET_p(OBJ, "TRANSBIT")))) then
                if ZG._T(ZG.FSET_p(OBJ, "SURFACEBIT")) then
                    _tmp1 = ZG.P_SRCALL
                elseif ZG._T(ZG.FSET_p(OBJ, "SEARCHBIT")) then
                    _tmp1 = ZG.P_SRCALL
                else
                    _tmp1 = ZG.P_SRCTOP
                end
                if ZG._T(ZG.FSET_p(OBJ, "SURFACEBIT")) then
                    _tmp2 = ZG.P_SRCALL
                elseif ZG._T(ZG.FSET_p(OBJ, "SEARCHBIT")) then
                    _tmp2 = ZG.P_SRCALL
                else
                    _tmp2 = ZG.P_SRCTOP
                end
                FLS = ZG.SEARCH_LIST(OBJ, TBL, _tmp2)
            end
            if ZG._T((function() OBJ = ZG.NEXT_p(OBJ); return OBJ end)()) then
            else
                do return true end
            end
        end
    else
        do return false end
    end

end, "SEARCH-LIST")

ZG.SEARCH_LIST = ZG.actions:get("SEARCH_LIST")

-- zil: gparser.zil:1264  <ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR)>
ZG.actions:register("OBJ_FOUND", function(OBJ, TBL)

    local PTR = 0
    PTR = ZG.GET(TBL, ZG.P_MATCHLEN)
    do local _ = ZG.PUT(TBL, ZG.ADD(PTR, 1), OBJ) end
    do return ZG.PUT(TBL, ZG.P_MATCHLEN, ZG.ADD(PTR, 1)) end

end, "OBJ-FOUND")

ZG.OBJ_FOUND = ZG.actions:get("OBJ_FOUND")

-- zil: gparser.zil:1269  <ROUTINE TAKE-CHECK ()>
ZG.actions:register("TAKE_CHECK", function()

    do return (ZG._T(ZG.ITAKE_CHECK(ZG.P_PRSO, ZG.GETB(ZG.P_SYNTAX, ZG.P_SLOC1))) and ZG.ITAKE_CHECK(ZG.P_PRSI, ZG.GETB(ZG.P_SYNTAX, ZG.P_SLOC2))) end

end, "TAKE-CHECK")

ZG.TAKE_CHECK = ZG.actions:get("TAKE_CHECK")

-- zil: gparser.zil:1273  <ROUTINE ITAKE-CHECK (TBL IBITS "AUX" PTR OBJ TAKEN)>
ZG.actions:register("ITAKE_CHECK", function(TBL, IBITS)

    local PTR = 0
    local OBJ = 0
    local TAKEN = 0
    if (ZG._T((function() PTR = ZG.GET(TBL, ZG.P_MATCHLEN); return PTR end)()) and (ZG._T(ZG.BTST(IBITS, ZG.SHAVE)) or ZG._T(ZG.BTST(IBITS, ZG.STAKE)))) then
        while true do
            if ZG.LT((function() PTR = ZG.SUB(PTR, 1); return PTR end)(), 0) then
                do return true end
            else
                OBJ = ZG.GET(TBL, ZG.ADD(PTR, 1))
                if ZG.EQ(OBJ, ZG.IT) then
                    if (not ZG._T(ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT))) then
                        do local _ = ZG.TELL("I don't see what you're referring to.", ZG._TK.CR) end
                        do return false end
                    else
                        OBJ = ZG.P_IT_OBJECT
                    end
                end
                if ((not ZG._T(ZG.HELD_p(OBJ))) and (not ZG.EQUAL_p(OBJ, ZG.HANDS, ZG.ME))) then
                    ZG._set("PRSO", OBJ)
                    if ZG._T(ZG.FSET_p(OBJ, "TRYTAKEBIT")) then
                        TAKEN = true
                    elseif (not ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
                        TAKEN = false
                    elseif (ZG._T(ZG.BTST(IBITS, ZG.STAKE)) and ZG.EQ(ZG.ITAKE(false), true)) then
                        TAKEN = false
                    else
                        TAKEN = true
                    end
                    if (ZG._T(TAKEN) and ZG._T(ZG.BTST(IBITS, ZG.SHAVE)) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
                        if ZG.EQ(OBJ, ZG.NOT_HERE_OBJECT) then
                            do local _ = ZG.TELL("You don't have that!", ZG._TK.CR) end
                            do return false end
                        end
                        do local _ = ZG.TELL("You don't have the ") end
                        do local _ = ZG.PRINTD(OBJ) end
                        do local _ = ZG.TELL(".", ZG._TK.CR) end
                        do return false end
                    elseif ((not ZG._T(TAKEN)) and ZG.EQ(ZG.WINNER, ZG.ADVENTURER)) then
                        do local _ = ZG.TELL("(Taken)", ZG._TK.CR) end
                    end
                end
            end
        end
    else
        do return true end
    end

end, "ITAKE-CHECK")

ZG.ITAKE_CHECK = ZG.actions:get("ITAKE_CHECK")

-- zil: gparser.zil:1319  <ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)>
ZG.actions:register("MANY_CHECK", function()

    local LOSS = false
    local TMP = 0
    if (ZG.LT(1, ZG.GET(ZG.P_PRSO, ZG.P_MATCHLEN)) and (not ZG._T(ZG.BTST(ZG.GETB(ZG.P_SYNTAX, ZG.P_SLOC1), ZG.SMANY)))) then
        LOSS = 1
    elseif (ZG.LT(1, ZG.GET(ZG.P_PRSI, ZG.P_MATCHLEN)) and (not ZG._T(ZG.BTST(ZG.GETB(ZG.P_SYNTAX, ZG.P_SLOC2), ZG.SMANY)))) then
        LOSS = 2
    end
    if ZG._T(LOSS) then
        do local _ = ZG.TELL("You can't use multiple ") end
        if ZG.EQ(LOSS, 2) then
            do local _ = ZG.TELL("in") end
        end
        do local _ = ZG.TELL("direct objects with \"") end
        TMP = ZG.GET(ZG.P_ITBL, ZG.P_VERBN)
        if ZG.ZERO_p(TMP) then
            do local _ = ZG.TELL("tell") end
        elseif (ZG._T(ZG.P_OFLAG) or ZG._T(ZG.P_MERGED)) then
            do local _ = ZG.PRINTB(ZG.GET(TMP, 0)) end
        else
            do local _ = ZG.WORD_PRINT(ZG.GETB(TMP, 2), ZG.GETB(TMP, 3)) end
        end
        do local _ = ZG.TELL("\".", ZG._TK.CR) end
        do return false end
    else
        do return true end
    end

end, "MANY-CHECK")

ZG.MANY_CHECK = ZG.actions:get("MANY_CHECK")

-- zil: gparser.zil:1340  <ROUTINE ZMEMQ (ITM TBL "OPTIONAL" (SIZE -1) "AUX" (CNT 1))>
ZG.actions:register("ZMEMQ", function(ITM, TBL, SIZE)

    if SIZE == nil then SIZE = -1 end
    local CNT = 1
    if (not ZG._T(TBL)) then
        do return false end
    end
    if (not ZG.LT(SIZE, 0)) then
        CNT = 0
    else
        SIZE = ZG.GET(TBL, 0)
    end
    while true do
        if ZG.EQ(ITM, ZG.GET(TBL, CNT)) then
            do return ZG.REST(TBL, (CNT * 2)) end
        elseif (function() CNT = ZG.ADD(CNT, 1); return CNT > SIZE end)() then
            do return false end
        end
    end

end, "ZMEMQ")

ZG.ZMEMQ = ZG.actions:get("ZMEMQ")

-- zil: gparser.zil:1349  <ROUTINE ZMEMQB (ITM TBL SIZE "AUX" (CNT 0))>
ZG.actions:register("ZMEMQB", function(ITM, TBL, SIZE)

    local CNT = 0
    while true do
        if ZG.EQ(ITM, ZG.GETB(TBL, CNT)) then
            do return true end
        elseif (function() CNT = ZG.ADD(CNT, 1); return CNT > SIZE end)() then
            do return false end
        end
    end

end, "ZMEMQB")

ZG.ZMEMQB = ZG.actions:get("ZMEMQB")

-- zil: gparser.zil:1356  <GLOBAL ALWAYS-LIT>
-- ALWAYS_LIT is declared in ZilGlobal.lua

-- zil: gparser.zil:1358  <ROUTINE LIT? (RM "OPTIONAL" (RMBIT T) "AUX" OHERE (LIT <>))>
ZG.actions:register("LIT_p", function(RM, RMBIT)

    if RMBIT == nil then RMBIT = true end
    local OHERE = 0
    local LIT = false
    if (ZG._T(ZG.ALWAYS_LIT) and ZG.EQ(ZG.WINNER, ZG.PLAYER)) then
        do return true end
    end
    ZG._set("P_GWIMBIT", "ONBIT")
    OHERE = ZG.HERE
    ZG._set("HERE", RM)
    if (ZG._T(RMBIT) and ZG._T(ZG.FSET_p(RM, "ONBIT"))) then
        LIT = true
    else
        do local _ = ZG.PUT(ZG.P_MERGE, ZG.P_MATCHLEN, 0) end
        ZG._set("P_TABLE", ZG.P_MERGE)
        ZG._set("P_SLOCBITS", -1)
        if ZG.EQ(OHERE, RM) then
            do local _ = ZG.DO_SL(ZG.WINNER, 1, 1) end
            if ((not ZG.EQ(ZG.WINNER, ZG.PLAYER)) and ZG._T(ZG.IN_p(ZG.PLAYER, RM))) then
                do local _ = ZG.DO_SL(ZG.PLAYER, 1, 1) end
            end
        end
        do local _ = ZG.DO_SL(RM, 1, 1) end
        if ZG.LT(0, ZG.GET(ZG.P_TABLE, ZG.P_MATCHLEN)) then
            LIT = true
        end
    end
    ZG._set("HERE", OHERE)
    ZG._set("P_GWIMBIT", 0)
    do return LIT end

end, "LIT?")

ZG.LIT_p = ZG.actions:get("LIT_p")

-- ;<ROUTINE PRSO-PRINT ("AUX" PTR)
-- 	 <COND (<OR ,P-MERGED
-- 		    <EQUAL? <GET <SET PTR <GET ,P-ITBL ,P-NC1>> 0> ,W?IT>>
-- 		<TELL " " D ,PRSO>)
-- 	       (T <BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC1L> <>>)>>

-- ;<ROUTINE PRSI-PRINT ("AUX" PTR)
-- 	 <COND (<OR ,P-MERGED
-- 		    <EQUAL? <GET <SET PTR <GET ,P-ITBL ,P-NC2>> 0> ,W?IT>>
-- 		<TELL " " D ,PRSO>)
-- 	       (T <BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC2L> <>>)>>

-- ;"former CRUFTY routine, re-written by SWG"

-- zil: gparser.zil:1396  <ROUTINE THIS-IT? (OBJ TBL "AUX" SYNS)>
ZG.actions:register("THIS_IT_p", function(OBJ, TBL)

    local SYNS = 0
    if ZG._T(ZG.FSET_p(OBJ, "INVISIBLE")) then
        do return false end
    elseif (ZG._T(ZG.P_NAM) and (not ZG._T(ZG.ZMEMQ(ZG.P_NAM, (function() SYNS = ZG.GETPT(OBJ, "SYNONYM"); return SYNS end)(), ZG.SUB(ZG.DIV(ZG.PTSIZE(SYNS), 2), 1))))) then
        do return false end
    elseif (ZG._T(ZG.P_ADJ) and ((not ZG._T((function() SYNS = ZG.GETPT(OBJ, "ADJECTIVE"); return SYNS end)())) or (not ZG._T(ZG.ZMEMQB(ZG.P_ADJ, SYNS, ZG.SUB(ZG.PTSIZE(SYNS), 1)))))) then
        do return false end
    elseif ((not ZG.ZERO_p(ZG.P_GWIMBIT)) and (not ZG._T(ZG.FSET_p(OBJ, ZG.P_GWIMBIT)))) then
        do return false end
    end
    do return true end

end, "THIS-IT?")

ZG.THIS_IT_p = ZG.actions:get("THIS_IT_p")

-- zil: gparser.zil:1411  <ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>))>
ZG.actions:register("ACCESSIBLE_p", function(OBJ)

    local L = ZG.LOC(OBJ)
    -- ;"can player TOUCH object?"
    -- ;"revised 5/2/84 by SEM and SWG"
    if ZG._T(ZG.FSET_p(OBJ, "INVISIBLE")) then
        do return false end
    elseif (not ZG._T(L)) then
        do return false end
    elseif ZG.EQ(L, ZG.GLOBAL_OBJECTS) then
        do return true end
    elseif (ZG.EQ(L, ZG.LOCAL_GLOBALS) and ZG._T(ZG.GLOBAL_IN_p(OBJ, ZG.HERE))) then
        do return true end
    elseif (not ZG.EQUAL_p(ZG.META_LOC(OBJ), ZG.HERE, ZG.LOC(ZG.WINNER))) then
        do return false end
    elseif ZG.EQUAL_p(L, ZG.WINNER, ZG.HERE, ZG.LOC(ZG.WINNER)) then
        do return true end
    elseif (ZG._T(ZG.FSET_p(L, "OPENBIT")) and ZG._T(ZG.ACCESSIBLE_p(L))) then
        do return true end
    else
        do return false end
    end

end, "ACCESSIBLE?")

ZG.ACCESSIBLE_p = ZG.actions:get("ACCESSIBLE_p")

-- zil: gparser.zil:1437  <ROUTINE META-LOC (OBJ)>
ZG.actions:register("META_LOC", function(OBJ)

    while true do
        if (not ZG._T(OBJ)) then
            do return false end
        elseif ZG._T(ZG.IN_p(OBJ, ZG.GLOBAL_OBJECTS)) then
            do return ZG.GLOBAL_OBJECTS end
        end
        if ZG._T(ZG.IN_p(OBJ, ZG.ROOMS)) then
            do return OBJ end
        else
            OBJ = ZG.LOC(OBJ)
        end
    end

end, "META-LOC")

ZG.META_LOC = ZG.actions:get("META_LOC")
