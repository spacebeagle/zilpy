-- ZIL のグローバル変数・定数の宣言 (自動生成・Lua 5.1 対応)
local ZG = require("ZilRuntime")

-- ------------------------------------------------------------
-- zork3
-- ------------------------------------------------------------

ZG._declare("ZORK_NUMBER", function() return 3 end)

-- ------------------------------------------------------------
-- gmacros
-- ------------------------------------------------------------

ZG._declare("C_ENABLED_p", function() return 0 end)

ZG._declare("C_ENABLED", function() return 1 end)

ZG._declare("C_DISABLED", function() return 0 end)

-- ------------------------------------------------------------
-- gclock
-- ------------------------------------------------------------

-- zil: gclock.zil:5  <CONSTANT C-TABLELEN>
ZG._declare("C_TABLELEN", function() return 180 end)

-- zil: gclock.zil:7  <GLOBAL C-TABLE>
ZG._declare("C_TABLE", function() return ZG.ITABLE("NONE", 180) end)

-- zil: gclock.zil:9  <GLOBAL C-DEMONS>
ZG._declare("C_DEMONS", function() return 180 end)

-- zil: gclock.zil:11  <GLOBAL C-INTS>
ZG._declare("C_INTS", function() return 180 end)

-- zil: gclock.zil:13  <CONSTANT C-INTLEN>
ZG._declare("C_INTLEN", function() return 6 end)

-- 注意: C_ENABLED_p は gmacros で別の値で宣言済み (後の宣言が使われる。前の値: ZSymbol(text='0', span=Span(start=112, end=113, line=5, col=18)))
-- zil: gclock.zil:15  <CONSTANT C-ENABLED?>
ZG._declare("C_ENABLED_p", function() return 0 end)

-- zil: gclock.zil:17  <CONSTANT C-TICK>
ZG._declare("C_TICK", function() return 1 end)

-- zil: gclock.zil:19  <CONSTANT C-RTN>
ZG._declare("C_RTN", function() return 2 end)

-- zil: gclock.zil:41  <GLOBAL CLOCK-WAIT>
ZG._declare("CLOCK_WAIT", function() return false end)

-- ------------------------------------------------------------
-- gmain
-- ------------------------------------------------------------

-- zil: gmain.zil:5  <CONSTANT SERIAL>
ZG._declare("SERIAL", function() return 0 end)

-- zil: gmain.zil:7  <GLOBAL PLAYER>
ZG._declare("PLAYER", function() return false end)

-- zil: gmain.zil:9  <GLOBAL P-WON>
ZG._declare("P_WON", function() return false end)

-- zil: gmain.zil:11  <CONSTANT M-FATAL>
ZG._declare("M_FATAL", function() return 2 end)

-- zil: gmain.zil:13  <CONSTANT M-HANDLED>
ZG._declare("M_HANDLED", function() return 1 end)

-- zil: gmain.zil:15  <CONSTANT M-NOT-HANDLED>
ZG._declare("M_NOT_HANDLED", function() return false end)

-- zil: gmain.zil:17  <CONSTANT M-OBJECT>
ZG._declare("M_OBJECT", function() return false end)

-- zil: gmain.zil:19  <CONSTANT M-BEG>
ZG._declare("M_BEG", function() return 1 end)

-- zil: gmain.zil:21  <CONSTANT M-END>
ZG._declare("M_END", function() return 6 end)

-- zil: gmain.zil:23  <CONSTANT M-ENTER>
ZG._declare("M_ENTER", function() return 2 end)

-- zil: gmain.zil:25  <CONSTANT M-LOOK>
ZG._declare("M_LOOK", function() return 3 end)

-- zil: gmain.zil:27  <CONSTANT M-FLASH>
ZG._declare("M_FLASH", function() return 4 end)

-- zil: gmain.zil:29  <CONSTANT M-OBJDESC>
ZG._declare("M_OBJDESC", function() return 5 end)

-- zil: gmain.zil:174  <GLOBAL P-MULT>
ZG._declare("P_MULT", function() return false end)

-- zil: gmain.zil:176  <GLOBAL P-NOT-HERE>
ZG._declare("P_NOT_HERE", function() return 0 end)

-- ------------------------------------------------------------
-- gparser
-- ------------------------------------------------------------

ZG._declare("SIBREAKS", function() return ".,\"" end)

-- zil: gparser.zil:14  <GLOBAL PRSA>
ZG._declare("PRSA", function() return false end)

-- zil: gparser.zil:15  <GLOBAL PRSI>
ZG._declare("PRSI", function() return false end)

-- zil: gparser.zil:16  <GLOBAL PRSO>
ZG._declare("PRSO", function() return false end)

-- zil: gparser.zil:18  <GLOBAL P-TABLE>
ZG._declare("P_TABLE", function() return 0 end)

-- zil: gparser.zil:19  <GLOBAL P-ONEOBJ>
ZG._declare("P_ONEOBJ", function() return 0 end)

-- zil: gparser.zil:20  <GLOBAL P-SYNTAX>
ZG._declare("P_SYNTAX", function() return 0 end)

-- zil: gparser.zil:22  <GLOBAL P-CCTBL>
ZG._declare("P_CCTBL", function() return ZG.TABLE(0, 0, 0, 0) end)

-- zil: gparser.zil:24  <CONSTANT CC-SBPTR>
ZG._declare("CC_SBPTR", function() return 0 end)

-- zil: gparser.zil:25  <CONSTANT CC-SEPTR>
ZG._declare("CC_SEPTR", function() return 1 end)

-- zil: gparser.zil:26  <CONSTANT CC-DBPTR>
ZG._declare("CC_DBPTR", function() return 2 end)

-- zil: gparser.zil:27  <CONSTANT CC-DEPTR>
ZG._declare("CC_DEPTR", function() return 3 end)

-- zil: gparser.zil:29  <GLOBAL P-LEN>
ZG._declare("P_LEN", function() return 0 end)

-- zil: gparser.zil:30  <GLOBAL P-DIR>
ZG._declare("P_DIR", function() return 0 end)

-- zil: gparser.zil:31  <GLOBAL HERE>
ZG._declare("HERE", function() return 0 end)

-- zil: gparser.zil:32  <GLOBAL WINNER>
ZG._declare("WINNER", function() return 0 end)

-- zil: gparser.zil:34  <GLOBAL P-LEXV>
ZG._declare("P_LEXV", function() return ZG.ITABLE(59, {"LEXV"}, 0, ZG.TBYTE(0), ZG.TBYTE(0)) end)

-- zil: gparser.zil:36  <GLOBAL AGAIN-LEXV>
ZG._declare("AGAIN_LEXV", function() return ZG.ITABLE(59, {"LEXV"}, 0, ZG.TBYTE(0), ZG.TBYTE(0)) end)

-- zil: gparser.zil:38  <GLOBAL RESERVE-LEXV>
ZG._declare("RESERVE_LEXV", function() return ZG.ITABLE(59, {"LEXV"}, 0, ZG.TBYTE(0), ZG.TBYTE(0)) end)

-- zil: gparser.zil:40  <GLOBAL RESERVE-PTR>
ZG._declare("RESERVE_PTR", function() return false end)

-- zil: gparser.zil:44  <GLOBAL P-INBUF>
ZG._declare("P_INBUF", function() return ZG.ITABLE(120, {"BYTE", "LENGTH"}, 0) end)

-- zil: gparser.zil:47  <GLOBAL OOPS-INBUF>
ZG._declare("OOPS_INBUF", function() return ZG.ITABLE(120, {"BYTE", "LENGTH"}, 0) end)

-- zil: gparser.zil:50  <GLOBAL OOPS-TABLE>
ZG._declare("OOPS_TABLE", function() return ZG.TABLE(false, false, false, false) end)

-- zil: gparser.zil:51  <CONSTANT O-PTR>
ZG._declare("O_PTR", function() return 0 end)

-- zil: gparser.zil:52  <CONSTANT O-START>
ZG._declare("O_START", function() return 1 end)

-- zil: gparser.zil:53  <CONSTANT O-LENGTH>
ZG._declare("O_LENGTH", function() return 2 end)

-- zil: gparser.zil:54  <CONSTANT O-END>
ZG._declare("O_END", function() return 3 end)

-- zil: gparser.zil:58  <GLOBAL P-CONT>
ZG._declare("P_CONT", function() return false end)

-- zil: gparser.zil:59  <GLOBAL P-IT-OBJECT>
ZG._declare("P_IT_OBJECT", function() return false end)

-- zil: gparser.zil:64  <GLOBAL P-OFLAG>
ZG._declare("P_OFLAG", function() return false end)

-- zil: gparser.zil:65  <GLOBAL P-MERGED>
ZG._declare("P_MERGED", function() return false end)

-- zil: gparser.zil:66  <GLOBAL P-ACLAUSE>
ZG._declare("P_ACLAUSE", function() return false end)

-- zil: gparser.zil:67  <GLOBAL P-ANAM>
ZG._declare("P_ANAM", function() return false end)

-- zil: gparser.zil:68  <GLOBAL P-AADJ>
ZG._declare("P_AADJ", function() return false end)

-- zil: gparser.zil:73  <CONSTANT P-LEXWORDS>
ZG._declare("P_LEXWORDS", function() return 1 end)

-- zil: gparser.zil:74  <CONSTANT P-LEXSTART>
ZG._declare("P_LEXSTART", function() return 1 end)

-- zil: gparser.zil:75  <CONSTANT P-LEXELEN>
ZG._declare("P_LEXELEN", function() return 2 end)

-- zil: gparser.zil:76  <CONSTANT P-WORDLEN>
ZG._declare("P_WORDLEN", function() return 4 end)

-- zil: gparser.zil:78  <CONSTANT P-PSOFF>
ZG._declare("P_PSOFF", function() return 4 end)

-- zil: gparser.zil:79  <CONSTANT P-P1OFF>
ZG._declare("P_P1OFF", function() return 5 end)

-- zil: gparser.zil:80  <CONSTANT P-P1BITS>
ZG._declare("P_P1BITS", function() return 3 end)

-- zil: gparser.zil:82  <CONSTANT P-ITBLLEN>
ZG._declare("P_ITBLLEN", function() return 9 end)

-- zil: gparser.zil:83  <GLOBAL P-ITBL>
ZG._declare("P_ITBL", function() return ZG.TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0) end)

-- zil: gparser.zil:84  <GLOBAL P-OTBL>
ZG._declare("P_OTBL", function() return ZG.TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0) end)

-- zil: gparser.zil:85  <GLOBAL P-VTBL>
ZG._declare("P_VTBL", function() return ZG.TABLE(0, 0, 0, 0) end)

-- zil: gparser.zil:86  <GLOBAL P-OVTBL>
ZG._declare("P_OVTBL", function() return ZG.TABLE(0, ZG.TBYTE(0), ZG.TBYTE(0)) end)

-- zil: gparser.zil:88  <GLOBAL P-NCN>
ZG._declare("P_NCN", function() return 0 end)

-- zil: gparser.zil:90  <CONSTANT P-VERB>
ZG._declare("P_VERB", function() return 0 end)

-- zil: gparser.zil:91  <CONSTANT P-VERBN>
ZG._declare("P_VERBN", function() return 1 end)

-- zil: gparser.zil:92  <CONSTANT P-PREP1>
ZG._declare("P_PREP1", function() return 2 end)

-- zil: gparser.zil:93  <CONSTANT P-PREP1N>
ZG._declare("P_PREP1N", function() return 3 end)

-- zil: gparser.zil:94  <CONSTANT P-PREP2>
ZG._declare("P_PREP2", function() return 4 end)

-- zil: gparser.zil:95  <CONSTANT P-PREP2N>
ZG._declare("P_PREP2N", function() return 5 end)

-- zil: gparser.zil:96  <CONSTANT P-NC1>
ZG._declare("P_NC1", function() return 6 end)

-- zil: gparser.zil:97  <CONSTANT P-NC1L>
ZG._declare("P_NC1L", function() return 7 end)

-- zil: gparser.zil:98  <CONSTANT P-NC2>
ZG._declare("P_NC2", function() return 8 end)

-- zil: gparser.zil:99  <CONSTANT P-NC2L>
ZG._declare("P_NC2L", function() return 9 end)

-- zil: gparser.zil:101  <GLOBAL QUOTE-FLAG>
ZG._declare("QUOTE_FLAG", function() return false end)

-- zil: gparser.zil:102  <GLOBAL P-END-ON-PREP>
ZG._declare("P_END_ON_PREP", function() return false end)

-- zil: gparser.zil:382  <GLOBAL P-ACT>
ZG._declare("P_ACT", function() return false end)

-- zil: gparser.zil:383  <GLOBAL P-WALK-DIR>
ZG._declare("P_WALK_DIR", function() return false end)

-- zil: gparser.zil:384  <GLOBAL AGAIN-DIR>
ZG._declare("AGAIN_DIR", function() return false end)

-- zil: gparser.zil:536  <GLOBAL P-NUMBER>
ZG._declare("P_NUMBER", function() return 0 end)

-- zil: gparser.zil:538  <GLOBAL P-DIRECTION>
ZG._declare("P_DIRECTION", function() return 0 end)

-- zil: gparser.zil:693  <GLOBAL P-SLOCBITS>
ZG._declare("P_SLOCBITS", function() return 0 end)

-- zil: gparser.zil:695  <CONSTANT P-SYNLEN>
ZG._declare("P_SYNLEN", function() return 8 end)

-- zil: gparser.zil:697  <CONSTANT P-SBITS>
ZG._declare("P_SBITS", function() return 0 end)

-- zil: gparser.zil:698  <CONSTANT P-SPREP1>
ZG._declare("P_SPREP1", function() return 1 end)

-- zil: gparser.zil:699  <CONSTANT P-SPREP2>
ZG._declare("P_SPREP2", function() return 2 end)

-- zil: gparser.zil:700  <CONSTANT P-SFWIM1>
ZG._declare("P_SFWIM1", function() return 3 end)

-- zil: gparser.zil:701  <CONSTANT P-SFWIM2>
ZG._declare("P_SFWIM2", function() return 4 end)

-- zil: gparser.zil:702  <CONSTANT P-SLOC1>
ZG._declare("P_SLOC1", function() return 5 end)

-- zil: gparser.zil:703  <CONSTANT P-SLOC2>
ZG._declare("P_SLOC2", function() return 6 end)

-- zil: gparser.zil:704  <CONSTANT P-SACTION>
ZG._declare("P_SACTION", function() return 7 end)

-- zil: gparser.zil:705  <CONSTANT P-SONUMS>
ZG._declare("P_SONUMS", function() return 3 end)

-- zil: gparser.zil:902  <GLOBAL P-GWIMBIT>
ZG._declare("P_GWIMBIT", function() return 0 end)

-- zil: gparser.zil:963  <GLOBAL P-NAM>
ZG._declare("P_NAM", function() return false end)

-- zil: gparser.zil:964  <GLOBAL P-ADJ>
ZG._declare("P_ADJ", function() return false end)

-- zil: gparser.zil:965  <GLOBAL P-ADVERB>
ZG._declare("P_ADVERB", function() return false end)

-- zil: gparser.zil:966  <GLOBAL P-ADJN>
ZG._declare("P_ADJN", function() return false end)

-- zil: gparser.zil:967  <GLOBAL P-PRSO>
ZG._declare("P_PRSO", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:968  <GLOBAL P-PRSI>
ZG._declare("P_PRSI", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:969  <GLOBAL P-BUTS>
ZG._declare("P_BUTS", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:970  <GLOBAL P-MERGE>
ZG._declare("P_MERGE", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:971  <GLOBAL P-OCLAUSE>
ZG._declare("P_OCLAUSE", function() return ZG.ITABLE("NONE", 100) end)

-- zil: gparser.zil:972  <GLOBAL P-MATCHLEN>
ZG._declare("P_MATCHLEN", function() return 0 end)

-- zil: gparser.zil:973  <GLOBAL P-GETFLAGS>
ZG._declare("P_GETFLAGS", function() return 0 end)

-- zil: gparser.zil:974  <CONSTANT P-ALL>
ZG._declare("P_ALL", function() return 1 end)

-- zil: gparser.zil:975  <CONSTANT P-ONE>
ZG._declare("P_ONE", function() return 2 end)

-- zil: gparser.zil:976  <CONSTANT P-INHIBIT>
ZG._declare("P_INHIBIT", function() return 4 end)

-- zil: gparser.zil:979  <GLOBAL P-AND>
ZG._declare("P_AND", function() return false end)

-- zil: gparser.zil:1035  <CONSTANT SH>
ZG._declare("SH", function() return 128 end)

-- zil: gparser.zil:1036  <CONSTANT SC>
ZG._declare("SC", function() return 64 end)

-- zil: gparser.zil:1037  <CONSTANT SIR>
ZG._declare("SIR", function() return 32 end)

-- zil: gparser.zil:1038  <CONSTANT SOG>
ZG._declare("SOG", function() return 16 end)

-- zil: gparser.zil:1039  <CONSTANT STAKE>
ZG._declare("STAKE", function() return 8 end)

-- zil: gparser.zil:1040  <CONSTANT SMANY>
ZG._declare("SMANY", function() return 4 end)

-- zil: gparser.zil:1041  <CONSTANT SHAVE>
ZG._declare("SHAVE", function() return 2 end)

-- zil: gparser.zil:1167  <GLOBAL P-XNAM>
ZG._declare("P_XNAM", function() return false end)

-- zil: gparser.zil:1168  <GLOBAL P-XADJ>
ZG._declare("P_XADJ", function() return false end)

-- zil: gparser.zil:1169  <GLOBAL P-XADJN>
ZG._declare("P_XADJN", function() return false end)

-- zil: gparser.zil:1237  <CONSTANT P-SRCBOT>
ZG._declare("P_SRCBOT", function() return 2 end)

-- zil: gparser.zil:1238  <CONSTANT P-SRCTOP>
ZG._declare("P_SRCTOP", function() return 0 end)

-- zil: gparser.zil:1239  <CONSTANT P-SRCALL>
ZG._declare("P_SRCALL", function() return 1 end)

-- zil: gparser.zil:1356  <GLOBAL ALWAYS-LIT>
ZG._declare("ALWAYS_LIT", function() return false end)

-- ------------------------------------------------------------
-- _3dungeon
-- ------------------------------------------------------------

-- zil: 3dungeon.zil:202  <GLOBAL CP-FLAG>
ZG._declare("CP_FLAG", function() return false end)

-- zil: 3dungeon.zil:960  <GLOBAL CLEFT-QUEUED?>
ZG._declare("CLEFT_QUEUED_p", function() return false end)

-- ------------------------------------------------------------
-- gglobals
-- ------------------------------------------------------------

-- zil: gglobals.zil:125  <GLOBAL LOAD-MAX>
ZG._declare("LOAD_MAX", function() return 100 end)

-- zil: gglobals.zil:127  <GLOBAL LOAD-ALLOWED>
ZG._declare("LOAD_ALLOWED", function() return 100 end)

-- ------------------------------------------------------------
-- gverbs
-- ------------------------------------------------------------

-- zil: gverbs.zil:9  <GLOBAL VERBOSE>
ZG._declare("VERBOSE", function() return false end)

-- zil: gverbs.zil:10  <GLOBAL SUPER-BRIEF>
ZG._declare("SUPER_BRIEF", function() return false end)

-- zil: gverbs.zil:755  <GLOBAL HS>
ZG._declare("HS", function() return 0 end)

-- zil: gverbs.zil:888  <GLOBAL JUMPLOSS>
ZG._declare("JUMPLOSS", function() return ZG.LTABLE(0, "You should have looked before you leaped.", "In the movies, your life would be passing before your eyes.", "Geronimo...") end)

-- zil: gverbs.zil:1316  <GLOBAL WHEEEEE>
ZG._declare("WHEEEEE", function() return ZG.LTABLE(0, "Very good. Now you can go to the second grade.", "Are you enjoying yourself?", "Wheeeeeeeeee!!!!!", "Do you expect me to applaud?") end)

-- zil: gverbs.zil:1670  <GLOBAL LIT>
ZG._declare("LIT", function() return false end)

-- zil: gverbs.zil:1672  <GLOBAL SPRAYED?>
ZG._declare("SPRAYED_p", function() return false end)

-- zil: gverbs.zil:1735  <GLOBAL DESC-OBJECT>
ZG._declare("DESC_OBJECT", function() return false end)

-- zil: gverbs.zil:1887  <GLOBAL MOVES>
ZG._declare("MOVES", function() return 0 end)

-- zil: gverbs.zil:1889  <GLOBAL SCORE>
ZG._declare("SCORE", function() return 0 end)

-- zil: gverbs.zil:1891  <GLOBAL BASE-SCORE>
ZG._declare("BASE_SCORE", function() return 0 end)

-- zil: gverbs.zil:1893  <GLOBAL WON-FLAG>
ZG._declare("WON_FLAG", function() return false end)

-- zil: gverbs.zil:1926  <GLOBAL DEAD>
ZG._declare("DEAD", function() return false end)

-- zil: gverbs.zil:1928  <GLOBAL DEATHS>
ZG._declare("DEATHS", function() return 0 end)

-- zil: gverbs.zil:1930  <GLOBAL LUCKY>
ZG._declare("LUCKY", function() return 1 end)

-- zil: gverbs.zil:1940  <GLOBAL FUMBLE-NUMBER>
ZG._declare("FUMBLE_NUMBER", function() return 7 end)

-- zil: gverbs.zil:1942  <GLOBAL FUMBLE-PROB>
ZG._declare("FUMBLE_PROB", function() return 8 end)

-- zil: gverbs.zil:2045  <CONSTANT REXIT>
ZG._declare("REXIT", function() return 0 end)

-- zil: gverbs.zil:2046  <CONSTANT UEXIT>
ZG._declare("UEXIT", function() return 1 end)

-- zil: gverbs.zil:2047  <CONSTANT NEXIT>
ZG._declare("NEXIT", function() return 2 end)

-- zil: gverbs.zil:2048  <CONSTANT FEXIT>
ZG._declare("FEXIT", function() return 3 end)

-- zil: gverbs.zil:2049  <CONSTANT CEXIT>
ZG._declare("CEXIT", function() return 4 end)

-- zil: gverbs.zil:2050  <CONSTANT DEXIT>
ZG._declare("DEXIT", function() return 5 end)

-- zil: gverbs.zil:2052  <CONSTANT NEXITSTR>
ZG._declare("NEXITSTR", function() return 0 end)

-- zil: gverbs.zil:2053  <CONSTANT FEXITFCN>
ZG._declare("FEXITFCN", function() return 0 end)

-- zil: gverbs.zil:2054  <CONSTANT CEXITFLAG>
ZG._declare("CEXITFLAG", function() return 1 end)

-- zil: gverbs.zil:2055  <CONSTANT CEXITSTR>
ZG._declare("CEXITSTR", function() return 1 end)

-- zil: gverbs.zil:2056  <CONSTANT DEXITOBJ>
ZG._declare("DEXITOBJ", function() return 1 end)

-- zil: gverbs.zil:2057  <CONSTANT DEXITSTR>
ZG._declare("DEXITSTR", function() return 1 end)

-- zil: gverbs.zil:2059  <GLOBAL INDENTS>
ZG._declare("INDENTS", function() return ZG.TABLE({"PURE"}, "", "  ", "    ", "      ", "        ", "          ") end)

-- zil: gverbs.zil:2075  <GLOBAL HO-HUM>
ZG._declare("HO_HUM", function() return ZG.LTABLE(0, " doesn't seem to work.", " isn't notably helpful.", " has no effect.") end)

-- zil: gverbs.zil:2252  <GLOBAL HELLOS>
ZG._declare("HELLOS", function() return ZG.LTABLE(0, "Hello.", "Good day.", "Nice weather we've been having lately.", "Goodbye.") end)

-- zil: gverbs.zil:2258  <GLOBAL YUKS>
ZG._declare("YUKS", function() return ZG.LTABLE(0, "A valiant attempt.", "You can't be serious.", "An interesting idea...", "What a concept!") end)

-- zil: gverbs.zil:2267  <GLOBAL DUMMY>
ZG._declare("DUMMY", function() return ZG.LTABLE(0, "Look around.", "Too late for that.", "Have your eyes checked.") end)

-- ------------------------------------------------------------
-- _3actions
-- ------------------------------------------------------------

-- zil: 3actions.zil:41  <GLOBAL SWORD-STATE>
ZG._declare("SWORD_STATE", function() return 0 end)

-- 注意: YUKS は gverbs で別の値で宣言済み (後の宣言が使われる。前の値: ZList(kind='angle', items=[ZSymbol(text='LTABLE', span=Span(start=61841, end=...)
-- zil: 3actions.zil:52  <GLOBAL YUKS>
ZG._declare("YUKS", function() return ZG.LTABLE("A valiant attempt.", "You can't be serious.", "An interesting idea...", "What a concept!") end)

-- zil: 3actions.zil:80  <GLOBAL LAMP-TABLE>
ZG._declare("LAMP_TABLE", function() return ZG.TABLE(300, "The lamp appears a bit dimmer.", 100, "The lamp is definitely dimmer now.", 50, "The lamp is nearly out.", 0) end)

-- zil: 3actions.zil:172  <GLOBAL CPHERE>
ZG._declare("CPHERE", function() return 1 end)

-- zil: 3actions.zil:174  <GLOBAL CPOBJS>
ZG._declare("CPOBJS", function() return ZG.ITABLE("NONE", (8 * 2 * 36)) end)

-- zil: 3actions.zil:176  <GLOBAL CPTABLE>
ZG._declare("CPTABLE", function() return ZG.TABLE(1, 0, -1, 0, 0, -1, 0, -1, 0, 1, 0, -2, 0, 0, 0, 0, 0, 1, 0, -3, 0, 0, -1, -1, 0, 0, 0, -1, 0, 0, 0, 1, 1, 0, 0, 0, 1) end)

-- zil: 3actions.zil:219  <GLOBAL CPWALLS>
ZG._declare("CPWALLS", function() return ZG.LTABLE(ZG.CPSWL, 6, ZG.CPNWL, -6, ZG.CPEWL, 1, ZG.CPWWL, -1) end)

-- zil: 3actions.zil:221  <GLOBAL CPEXITS>
ZG._declare("CPEXITS", function() return ZG.LTABLE("NORTH", -6, "SOUTH", 6, "EAST", 1, "WEST", -1, "NE", -5, "NW", -7, "SE", 7, "SW", 5) end)

-- zil: 3actions.zil:239  <GLOBAL CP-MOVED>
ZG._declare("CP_MOVED", function() return false end)

-- zil: 3actions.zil:292  <GLOBAL MINUS-SEVEN>
ZG._declare("MINUS_SEVEN", function() return -7 end)

-- zil: 3actions.zil:293  <GLOBAL MINUS-FIVE>
ZG._declare("MINUS_FIVE", function() return -5 end)

-- zil: 3actions.zil:294  <GLOBAL MINUS-FOUR>
ZG._declare("MINUS_FOUR", function() return -4 end)

-- zil: 3actions.zil:295  <GLOBAL MINUS-ONE>
ZG._declare("MINUS_ONE", function() return -1 end)

-- zil: 3actions.zil:333  <GLOBAL CPPUSH-FLAG>
ZG._declare("CPPUSH_FLAG", function() return false end)

-- zil: 3actions.zil:335  <GLOBAL CPSOLVE-FLAG>
ZG._declare("CPSOLVE_FLAG", function() return false end)

-- zil: 3actions.zil:420  <GLOBAL CPBLOCK-FLAG>
ZG._declare("CPBLOCK_FLAG", function() return false end)

-- zil: 3actions.zil:422  <CONSTANT GCARDLOC>
ZG._declare("GCARDLOC", function() return 168 end)

-- zil: 3actions.zil:602  <GLOBAL MLOC>
ZG._declare("MLOC", function() return false end)

-- zil: 3actions.zil:604  <GLOBAL MR1-FLAG>
ZG._declare("MR1_FLAG", function() return true end)

-- zil: 3actions.zil:606  <GLOBAL MR2-FLAG>
ZG._declare("MR2_FLAG", function() return true end)

-- zil: 3actions.zil:608  <GLOBAL MIRROR-OPEN-FLAG>
ZG._declare("MIRROR_OPEN_FLAG", function() return false end)

-- zil: 3actions.zil:610  <GLOBAL WOOD-OPEN-FLAG>
ZG._declare("WOOD_OPEN_FLAG", function() return false end)

-- zil: 3actions.zil:612  <GLOBAL MRSWPUSH-FLAG>
ZG._declare("MRSWPUSH_FLAG", function() return false end)

-- zil: 3actions.zil:614  <GLOBAL R-SOUTHS>
ZG._declare("R_SOUTHS", function() return ZG.LTABLE(ZG.FRONT_DOOR, ZG.MRD, ZG.MRG, ZG.MRC, ZG.MRB, ZG.MRA, ZG.MREYE) end)

-- zil: 3actions.zil:615  <GLOBAL R-NORTHS>
ZG._declare("R_NORTHS", function() return ZG.LTABLE(ZG.MREYE, ZG.MRA, ZG.MRB, ZG.MRC, ZG.MRG, ZG.MRD) end)

-- zil: 3actions.zil:650  <GLOBAL R-EASTS>
ZG._declare("R_EASTS", function() return ZG.LTABLE(ZG.MRA, ZG.MRAE, ZG.MRB, ZG.MRBE, ZG.MRC, ZG.MRCE, ZG.MRG, ZG.MRGE, ZG.MRD, ZG.MRDE) end)

-- zil: 3actions.zil:651  <GLOBAL R-WESTS>
ZG._declare("R_WESTS", function() return ZG.LTABLE(ZG.MRA, ZG.MRAW, ZG.MRB, ZG.MRBW, ZG.MRC, ZG.MRCW, ZG.MRG, ZG.MRGW, ZG.MRD, ZG.MRDW) end)

-- zil: 3actions.zil:678  <GLOBAL GUARDIANS-SEEN>
ZG._declare("GUARDIANS_SEEN", function() return false end)

-- zil: 3actions.zil:702  <GLOBAL GUARDSTR>
ZG._declare("GUARDSTR", function() return ", identical stone statues face each other from\npedestals on opposite sides of the corridor. The statues represent\nGuardians of Zork, a military order of ancient lineage. They are\nportrayed as heavily armored warriors clasping formidable bludgeons." end)

-- zil: 3actions.zil:935  <GLOBAL MIRROR-FIRST>
ZG._declare("MIRROR_FIRST", function() return "To break the panel you would have to break the mirror first." end)

-- zil: 3actions.zil:938  <GLOBAL DIRVEC>
ZG._declare("DIRVEC", function() return ZG.LTABLE("NORTH", 0, "NE", 45, "EAST", 90, "SE", 135, "SOUTH", 180, "SW", 225, "WEST", 270, "NW", 315) end)

-- zil: 3actions.zil:1034  <GLOBAL BEAM-BREAKER>
ZG._declare("BEAM_BREAKER", function() return false end)

-- zil: 3actions.zil:1079  <GLOBAL MIRROR-OPENED>
ZG._declare("MIRROR_OPENED", function() return false end)

-- zil: 3actions.zil:1104  <GLOBAL MDIR>
ZG._declare("MDIR", function() return 270 end)

-- zil: 3actions.zil:1108  <GLOBAL POLEUP-FLAG>
ZG._declare("POLEUP_FLAG", function() return 0 end)

-- zil: 3actions.zil:1177  <GLOBAL LONGDIRS>
ZG._declare("LONGDIRS", function() return ZG.TABLE("north", "northeast", "east", "southeast", "south", "southwest", "west", "northwest") end)

-- zil: 3actions.zil:1407  <GLOBAL DM-SEEN>
ZG._declare("DM_SEEN", function() return false end)

-- zil: 3actions.zil:1484  <GLOBAL IN-DUNGEON>
ZG._declare("IN_DUNGEON", function() return false end)

-- zil: 3actions.zil:1486  <GLOBAL DM-REASONS>
ZG._declare("DM_REASONS", function() return ZG.TABLE("but I fear my waiting may be in vain.", "but you have far to go before you are ready.", "and you seem to have made slight some progress.", "and your journey is half complete. Be of good cheer!", "and you are nearing the end of your long quest!", "and it will not be long before you are ready!", "and you are nearly ready for the last test!") end)

-- zil: 3actions.zil:1505  <GLOBAL FOLFLAG>
ZG._declare("FOLFLAG", function() return true end)

-- zil: 3actions.zil:1530  <GLOBAL LCELL>
ZG._declare("LCELL", function() return 1 end)

-- zil: 3actions.zil:1532  <GLOBAL PNUMB>
ZG._declare("PNUMB", function() return 1 end)

-- zil: 3actions.zil:1534  <GLOBAL CELLOBJS>
ZG._declare("CELLOBJS", function() return ZG.ITABLE("NONE", (8 * 2 * 8)) end)

-- zil: 3actions.zil:1694  <GLOBAL BRONZE-DOOR-LOCKED>
ZG._declare("BRONZE_DOOR_LOCKED", function() return true end)

-- zil: 3actions.zil:1751  <GLOBAL OLD-MAN-GONE>
ZG._declare("OLD_MAN_GONE", function() return false end)

-- zil: 3actions.zil:1752  <GLOBAL OLD-MAN-FED>
ZG._declare("OLD_MAN_FED", function() return false end)

-- zil: 3actions.zil:1754  <GLOBAL SECRET-DOOR-DESC>
ZG._declare("SECRET_DOOR_DESC", function() return "Beyond the secret door are dark, forbidding stairs leading down to\na passage below. Flickering torchlight illuminates the passage." end)

-- zil: 3actions.zil:1857  <GLOBAL OLD-MAN-AWAKE>
ZG._declare("OLD_MAN_AWAKE", function() return false end)

-- zil: 3actions.zil:1983  <GLOBAL DIAG>
ZG._declare("DIAG", function() return ZG.TABLE("You are dead.", "You are very seriously wounded. One more wound would very likely do you in.", "You are hurt quite badly. One major wound would probably kill you.", "You have a few wounds, which do not seriously impair your strength.", "You are wounded lightly. You have a good deal of strength in reserve.", "You are in perfect health.") end)

-- zil: 3actions.zil:2055  <GLOBAL DEAD-OBJ-LOCS>
ZG._declare("DEAD_OBJ_LOCS", function() return ZG.LTABLE(ZG.JUNCTION, ZG.CLEARING, ZG.DAMP_PASSAGE, ZG.CREEPY_CRAWL, ZG.TIGHT_SQUEEZE, ZG.FOGGY_ROOM, ZG.DEAD_END) end)

-- zil: 3actions.zil:2066  <GLOBAL SCORE-MAX>
ZG._declare("SCORE_MAX", function() return 7 end)

-- zil: 3actions.zil:2426  <GLOBAL MACHINE-DAMAGED>
ZG._declare("MACHINE_DAMAGED", function() return false end)

-- zil: 3actions.zil:2428  <GLOBAL YEAR>
ZG._declare("YEAR", function() return 948 end)

-- zil: 3actions.zil:2430  <CONSTANT YEAR-BUILT>
ZG._declare("YEAR_BUILT", function() return 776 end)

-- zil: 3actions.zil:2432  <CONSTANT YEAR-CAGED>
ZG._declare("YEAR_CAGED", function() return 777 end)

-- zil: 3actions.zil:2434  <GLOBAL YEAR-CLOSED>
ZG._declare("YEAR_CLOSED", function() return 883 end)

-- zil: 3actions.zil:2436  <CONSTANT REAL-YEAR-CLOSED>
ZG._declare("REAL_YEAR_CLOSED", function() return 883 end)

-- zil: 3actions.zil:2438  <CONSTANT YEAR-PRESENT>
ZG._declare("YEAR_PRESENT", function() return 948 end)

-- zil: 3actions.zil:2449  <GLOBAL CLEFT-FLAG>
ZG._declare("CLEFT_FLAG", function() return false end)

-- zil: 3actions.zil:2530  <GLOBAL TM-YEAR>
ZG._declare("TM_YEAR", function() return 948 end)

-- zil: 3actions.zil:2593  <GLOBAL RING-CONCEALED>
ZG._declare("RING_CONCEALED", function() return false end)

-- zil: 3actions.zil:2633  <GLOBAL TM-POINT>
ZG._declare("TM_POINT", function() return false end)

-- zil: 3actions.zil:2689  <GLOBAL SURROUNDINGS-CHANGED>
ZG._declare("SURROUNDINGS_CHANGED", function() return "your surroundings appear to have changed. From outside the door\nyou hear the sounds of guards talking." end)

-- zil: 3actions.zil:2707  <GLOBAL SNAP-LOC>
ZG._declare("SNAP_LOC", function() return false end)

-- zil: 3actions.zil:2839  <GLOBAL GUARD-KILLERS>
ZG._declare("GUARD_KILLERS", function() return ZG.LTABLE(0, "you are surrounded by heavily armed guards who seem awed by your presence.\nOne, whose IQ might be 15, aims a strange waffle-like\ninstrument in your direction and all goes black.", "you are confronted with many particularly stupid-looking\npeople dressed in peculiar uniforms and pointing waffle-like objects in\nyour direction. One twists his waffle and you slump\nto the ground, dead.", "you see a row of military people who, if appearances do not\ndeceive, have the cumulative intelligence of an unripe grapefruit. One\nof them aims a waffle-shaped implement in your direction and you become numb\nand then paralyzed and then dead.") end)

-- zil: 3actions.zil:2874  <GLOBAL FLATHEAD-HEARD>
ZG._declare("FLATHEAD_HEARD", function() return false end)

-- zil: 3actions.zil:2876  <GLOBAL RING-STOLEN>
ZG._declare("RING_STOLEN", function() return false end)

-- zil: 3actions.zil:2877  <GLOBAL CLUMSY-ROBBERY>
ZG._declare("CLUMSY_ROBBERY", function() return false end)

-- zil: 3actions.zil:2878  <GLOBAL MYSTERY>
ZG._declare("MYSTERY", function() return false end)

-- zil: 3actions.zil:2880  <GLOBAL GUARDS-PRESENT>
ZG._declare("GUARDS_PRESENT", function() return true end)

-- zil: 3actions.zil:2945  <GLOBAL HEAR-VOICES>
ZG._declare("HEAR_VOICES", function() return "Through the door you can hear voices which, from their\nsound, belong to military or police personnel." end)

-- zil: 3actions.zil:3115  <GLOBAL BLATHER>
ZG._declare("BLATHER", function() return ZG.LTABLE(0, "wage scales for guards", "the excessive nature of the Royal Government", "the soon to be constructed Royal Puzzle", "the proper way to execute trespassers", "torturing thieves", "the banishment of the Wizard of Frobozz") end)

-- zil: 3actions.zil:3382  <GLOBAL DIRS>
ZG._declare("DIRS", function() return ZG.LTABLE("NORTH", "north", "SOUTH", "south", "EAST", "east", "WEST", "west", "NW", "northwest", "NE", "northeast", "SE", "southeast", "SW", "southwest", "UP", "stairs", "DOWN", "stairs") end)

-- zil: 3actions.zil:3387  <GLOBAL DIR-TBL>
ZG._declare("DIR_TBL", function() return ZG.TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0) end)

-- zil: 3actions.zil:3431  <GLOBAL SHADOW-DIAG>
ZG._declare("SHADOW_DIAG", function() return ZG.TABLE("?", " appears to be badly hurt and defenseless.", " is hurt, and its strength appears to be fading.", " has some wounds and is probably not capable of hindering your movement.", " has a light wound which hasn't affected its seemingly great strength.", " has a great deal of strength, perhaps matching your own.") end)

-- zil: 3actions.zil:3440  <GLOBAL P-STRENGTH>
ZG._declare("P_STRENGTH", function() return 5 end)

-- zil: 3actions.zil:3441  <GLOBAL S-STRENGTH>
ZG._declare("S_STRENGTH", function() return 5 end)

-- zil: 3actions.zil:3443  <GLOBAL ATTACK-MODE>
ZG._declare("ATTACK_MODE", function() return false end)

-- zil: 3actions.zil:3444  <GLOBAL SHADOW-GONE>
ZG._declare("SHADOW_GONE", function() return false end)

-- zil: 3actions.zil:3483  <GLOBAL P-HITS>
ZG._declare("P_HITS", function() return ZG.LTABLE(0, "A good parry! Your sword wounds the hooded figure!", "A quick stroke catches the hooded figure off guard! Blood trickles\ndown the figure's arm!", "The hooded figure is hit with a quick slash!") end)

-- zil: 3actions.zil:3489  <GLOBAL P-MISSES>
ZG._declare("P_MISSES", function() return ZG.LTABLE(0, "Your move was not quick enough and misses the mark.", "A quick stroke, but the hooded figure is on guard.", "A good stroke, but it's too slow.", "A good slash, but it misses by a mile.", "You charge, but the hooded figure jumps nimbly aside.") end)

-- zil: 3actions.zil:3496  <GLOBAL S-HITS>
ZG._declare("S_HITS", function() return ZG.LTABLE(0, "The hooded figure catches you off guard and wounds you!", "You are wounded by a lightning thrust!", "Your quick reflexes cannot stop the hooded figure's stroke! You are hit!") end)

-- zil: 3actions.zil:3537  <GLOBAL S-MISSES>
ZG._declare("S_MISSES", function() return ZG.LTABLE(0, "The hooded figure stabs nonchalantly with its sword and misses.", "You dodge as the hooded figure comes in low.", "The hooded figure tries to sneak past your guard, but you twist away.", "The hooded figure thrusts, but you fight back and send it\nflying to the ground!") end)

-- zil: 3actions.zil:3589  <GLOBAL BLOCKED-DIR>
ZG._declare("BLOCKED_DIR", function() return false end)

-- zil: 3actions.zil:3636  <GLOBAL SHADOW-POINT-1>
ZG._declare("SHADOW_POINT_1", function() return false end)

-- zil: 3actions.zil:3637  <GLOBAL SHADOW-POINT-2>
ZG._declare("SHADOW_POINT_2", function() return false end)

-- zil: 3actions.zil:4060  <GLOBAL CHEST-LIFTED>
ZG._declare("CHEST_LIFTED", function() return false end)

-- zil: 3actions.zil:4092  <GLOBAL MAN-SEEN>
ZG._declare("MAN_SEEN", function() return false end)

-- zil: 3actions.zil:4117  <GLOBAL MAN-WAITS>
ZG._declare("MAN_WAITS", function() return ZG.LTABLE(0, "The man appears to be getting somewhat impatient.", "Your friend at the cliff top has started pacing nervously around.", "\"Yoo hoo!\" calls the man at the brink of the cliff. \"Remember me?\"", "The man on the cliff waves at you. \"It would just take a moment to tie that\nrope to the chest. I'd be much obliged, and there might even be something in\nit for you!\"", "A few small stones fall near your feet. You look up and see your friend\nwaving. \"I haven't got all day, fella. Be a pal and pass up the chest!\"", "The man on the cliff clears his throat loudly. \"I don't mean to be rushing\nyou, but I do have some pressing engagements....\"") end)

-- zil: 3actions.zil:4129  <GLOBAL MAN-WAITING>
ZG._declare("MAN_WAITING", function() return 0 end)

-- zil: 3actions.zil:4130  <GLOBAL MAN-FLAG>
ZG._declare("MAN_FLAG", function() return false end)

-- zil: 3actions.zil:4131  <GLOBAL MAN-POINT>
ZG._declare("MAN_POINT", function() return false end)

-- zil: 3actions.zil:4132  <GLOBAL MAN-GONE>
ZG._declare("MAN_GONE", function() return false end)

-- zil: 3actions.zil:4261  <GLOBAL CHEST-TIED>
ZG._declare("CHEST_TIED", function() return false end)

-- zil: 3actions.zil:4262  <GLOBAL HOLDING-ROPE>
ZG._declare("HOLDING_ROPE", function() return false end)

-- zil: 3actions.zil:4275  <GLOBAL LIFT-WAIT>
ZG._declare("LIFT_WAIT", function() return 0 end)

-- zil: 3actions.zil:4319  <GLOBAL CHEST-OPENED>
ZG._declare("CHEST_OPENED", function() return false end)

-- zil: 3actions.zil:4342  <GLOBAL ROPE-FLAG>
ZG._declare("ROPE_FLAG", function() return true end)

-- zil: 3actions.zil:4513  <GLOBAL LAST-MOVES>
ZG._declare("LAST_MOVES", function() return 0 end)

-- zil: 3actions.zil:4521  <GLOBAL LAKE-POINT>
ZG._declare("LAKE_POINT", function() return false end)

-- zil: 3actions.zil:4533  <GLOBAL CURRENT-LAMP>
ZG._declare("CURRENT_LAMP", function() return ZG.LAMP end)

-- zil: 3actions.zil:4566  <GLOBAL LAKE-TIME>
ZG._declare("LAKE_TIME", function() return false end)

-- zil: 3actions.zil:4634  <GLOBAL VIEW-POINT>
ZG._declare("VIEW_POINT", function() return 1 end)

-- zil: 3actions.zil:4679  <GLOBAL VIEW-ROMANS>
ZG._declare("VIEW_ROMANS", function() return ZG.TABLE(0, "I", "II", "III", "IV") end)

-- zil: 3actions.zil:4681  <GLOBAL ACTIVE-VIEW>
ZG._declare("ACTIVE_VIEW", function() return 1 end)

-- zil: 3actions.zil:4683  <GLOBAL VIEW-ROOMS>
ZG._declare("VIEW_ROOMS", function() return ZG.LTABLE(ZG.TIMBER_ROOM, ZG.ROOM_8, ZG.DAMP_PASSAGE, ZG.ZORK_IV) end)

-- zil: 3actions.zil:4685  <GLOBAL VIEWS>
ZG._declare("VIEWS", function() return ZG.LTABLE("You see a passage cluttered with broken timbers. An extremely narrow opening\ncan be seen at the end of the room.", "You see a tiny room with rough walls. Chiseled crudely on one wall is the\nnumber \"8\". The only apparent exit seems to be a blur.", "You see a wide room with two nearly identical passages leading east and\nnortheast. A wide channel descends steeply into the room and seems to be\nblocked by rubble.", "You see the interior of a huge temple rudely constructed of basalt blocks.\nFlickering torches cast a sallow illumination over an altar still wet with the\nblood of human sacrifice, its velvet covers stained and encrusted with gore.") end)

-- zil: 3actions.zil:4833  <GLOBAL EMPTY-HANDED>
ZG._declare("EMPTY_HANDED", function() return false end)

-- zil: 3actions.zil:4902  <GLOBAL SPRAY-USED?>
ZG._declare("SPRAY_USED_p", function() return false end)

-- zil: 3actions.zil:5089  <GLOBAL AQ-FLAG>
ZG._declare("AQ_FLAG", function() return true end)

-- zil: 3actions.zil:5091  <GLOBAL COVER-MOVED>
ZG._declare("COVER_MOVED", function() return false end)

-- zil: 3actions.zil:5158  <GLOBAL KEY-DESCS>
ZG._declare("KEY_DESCS", function() return ZG.LTABLE(0, "The key is a long and heavy skeleton key.", "The key is short and stubby, shaped like no lock you have ever seen.", "The key is round and thin, more like a pencil than a key.", "The key is shiny with many prongs.", "The key is sharp as an awl, and rusted badly.") end)

-- zil: 3actions.zil:5178  <GLOBAL BOAT-SEEN>
ZG._declare("BOAT_SEEN", function() return false end)

-- zil: 3actions.zil:5206  <GLOBAL SHIP-GONE>
ZG._declare("SHIP_GONE", function() return false end)

-- zil: 3actions.zil:5271  <GLOBAL INVIS>
ZG._declare("INVIS", function() return false end)

-- zil: 3actions.zil:5331  <GLOBAL SWORD-IN-STONE?>
ZG._declare("SWORD_IN_STONE_p", function() return true end)

return ZG
