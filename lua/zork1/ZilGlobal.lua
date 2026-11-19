-- ZIL のグローバル変数・定数の宣言 (自動生成・Lua 5.1 対応)
local ZG = require("ZilRuntime")

-- ------------------------------------------------------------
-- zork1
-- ------------------------------------------------------------

ZG._declare("ZORK_NUMBER", function() return 1 end)

-- ------------------------------------------------------------
-- gmacros
-- ------------------------------------------------------------

ZG._declare("C_ENABLED_p", function() return 0 end)

ZG._declare("C_ENABLED", function() return 1 end)

ZG._declare("C_DISABLED", function() return 0 end)

-- ------------------------------------------------------------
-- _1dungeon
-- ------------------------------------------------------------

-- zil: 1dungeon.zil:7  <GLOBAL SCORE-MAX>
ZG._declare("SCORE_MAX", function() return 350 end)

-- zil: 1dungeon.zil:9  <GLOBAL FALSE-FLAG>
ZG._declare("FALSE_FLAG", function() return false end)

-- zil: 1dungeon.zil:1225  <GLOBAL CYCLOPS-FLAG>
ZG._declare("CYCLOPS_FLAG", function() return false end)

-- zil: 1dungeon.zil:1226  <GLOBAL DEFLATE>
ZG._declare("DEFLATE", function() return false end)

-- zil: 1dungeon.zil:1227  <GLOBAL DOME-FLAG>
ZG._declare("DOME_FLAG", function() return false end)

-- zil: 1dungeon.zil:1228  <GLOBAL EMPTY-HANDED>
ZG._declare("EMPTY_HANDED", function() return false end)

-- zil: 1dungeon.zil:1229  <GLOBAL LLD-FLAG>
ZG._declare("LLD_FLAG", function() return false end)

-- zil: 1dungeon.zil:1230  <GLOBAL LOW-TIDE>
ZG._declare("LOW_TIDE", function() return false end)

-- zil: 1dungeon.zil:1231  <GLOBAL MAGIC-FLAG>
ZG._declare("MAGIC_FLAG", function() return false end)

-- zil: 1dungeon.zil:1232  <GLOBAL RAINBOW-FLAG>
ZG._declare("RAINBOW_FLAG", function() return false end)

-- zil: 1dungeon.zil:1233  <GLOBAL TROLL-FLAG>
ZG._declare("TROLL_FLAG", function() return false end)

-- zil: 1dungeon.zil:1234  <GLOBAL WON-FLAG>
ZG._declare("WON_FLAG", function() return false end)

-- zil: 1dungeon.zil:1235  <GLOBAL COFFIN-CURE>
ZG._declare("COFFIN_CURE", function() return false end)

-- zil: 1dungeon.zil:2620  <GLOBAL HOUSE-AROUND>
ZG._declare("HOUSE_AROUND", function() return ZG.LTABLE({"PURE"}, ZG.WEST_OF_HOUSE, ZG.NORTH_OF_HOUSE, ZG.EAST_OF_HOUSE, ZG.SOUTH_OF_HOUSE, ZG.WEST_OF_HOUSE) end)

-- zil: 1dungeon.zil:2624  <GLOBAL FOREST-AROUND>
ZG._declare("FOREST_AROUND", function() return ZG.LTABLE({"PURE"}, ZG.FOREST_1, ZG.FOREST_2, ZG.FOREST_3, ZG.PATH, ZG.CLEARING, ZG.FOREST_1) end)

-- zil: 1dungeon.zil:2627  <GLOBAL IN-HOUSE-AROUND>
ZG._declare("IN_HOUSE_AROUND", function() return ZG.LTABLE({"PURE"}, ZG.LIVING_ROOM, ZG.KITCHEN, ZG.ATTIC, ZG.KITCHEN) end)

-- zil: 1dungeon.zil:2630  <GLOBAL ABOVE-GROUND>
ZG._declare("ABOVE_GROUND", function() return ZG.LTABLE({"PURE"}, ZG.WEST_OF_HOUSE, ZG.NORTH_OF_HOUSE, ZG.EAST_OF_HOUSE, ZG.SOUTH_OF_HOUSE, ZG.FOREST_1, ZG.FOREST_2, ZG.FOREST_3, ZG.PATH, ZG.CLEARING, ZG.GRATING_CLEARING, ZG.CANYON_VIEW) end)

-- ------------------------------------------------------------
-- gglobals
-- ------------------------------------------------------------

-- zil: gglobals.zil:92  <GLOBAL LOAD-MAX>
ZG._declare("LOAD_MAX", function() return 100 end)

-- zil: gglobals.zil:94  <GLOBAL LOAD-ALLOWED>
ZG._declare("LOAD_ALLOWED", function() return 100 end)

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

-- zil: gparser.zil:899  <GLOBAL P-GWIMBIT>
ZG._declare("P_GWIMBIT", function() return 0 end)

-- zil: gparser.zil:960  <GLOBAL P-NAM>
ZG._declare("P_NAM", function() return false end)

-- zil: gparser.zil:961  <GLOBAL P-ADJ>
ZG._declare("P_ADJ", function() return false end)

-- zil: gparser.zil:962  <GLOBAL P-ADVERB>
ZG._declare("P_ADVERB", function() return false end)

-- zil: gparser.zil:963  <GLOBAL P-ADJN>
ZG._declare("P_ADJN", function() return false end)

-- zil: gparser.zil:964  <GLOBAL P-PRSO>
ZG._declare("P_PRSO", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:965  <GLOBAL P-PRSI>
ZG._declare("P_PRSI", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:966  <GLOBAL P-BUTS>
ZG._declare("P_BUTS", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:967  <GLOBAL P-MERGE>
ZG._declare("P_MERGE", function() return ZG.ITABLE("NONE", 50) end)

-- zil: gparser.zil:968  <GLOBAL P-OCLAUSE>
ZG._declare("P_OCLAUSE", function() return ZG.ITABLE("NONE", 100) end)

-- zil: gparser.zil:969  <GLOBAL P-MATCHLEN>
ZG._declare("P_MATCHLEN", function() return 0 end)

-- zil: gparser.zil:970  <GLOBAL P-GETFLAGS>
ZG._declare("P_GETFLAGS", function() return 0 end)

-- zil: gparser.zil:971  <CONSTANT P-ALL>
ZG._declare("P_ALL", function() return 1 end)

-- zil: gparser.zil:972  <CONSTANT P-ONE>
ZG._declare("P_ONE", function() return 2 end)

-- zil: gparser.zil:973  <CONSTANT P-INHIBIT>
ZG._declare("P_INHIBIT", function() return 4 end)

-- zil: gparser.zil:976  <GLOBAL P-AND>
ZG._declare("P_AND", function() return false end)

-- zil: gparser.zil:1032  <CONSTANT SH>
ZG._declare("SH", function() return 128 end)

-- zil: gparser.zil:1033  <CONSTANT SC>
ZG._declare("SC", function() return 64 end)

-- zil: gparser.zil:1034  <CONSTANT SIR>
ZG._declare("SIR", function() return 32 end)

-- zil: gparser.zil:1035  <CONSTANT SOG>
ZG._declare("SOG", function() return 16 end)

-- zil: gparser.zil:1036  <CONSTANT STAKE>
ZG._declare("STAKE", function() return 8 end)

-- zil: gparser.zil:1037  <CONSTANT SMANY>
ZG._declare("SMANY", function() return 4 end)

-- zil: gparser.zil:1038  <CONSTANT SHAVE>
ZG._declare("SHAVE", function() return 2 end)

-- zil: gparser.zil:1142  <GLOBAL P-XNAM>
ZG._declare("P_XNAM", function() return false end)

-- zil: gparser.zil:1143  <GLOBAL P-XADJ>
ZG._declare("P_XADJ", function() return false end)

-- zil: gparser.zil:1144  <GLOBAL P-XADJN>
ZG._declare("P_XADJN", function() return false end)

-- zil: gparser.zil:1212  <CONSTANT P-SRCBOT>
ZG._declare("P_SRCBOT", function() return 2 end)

-- zil: gparser.zil:1213  <CONSTANT P-SRCTOP>
ZG._declare("P_SRCTOP", function() return 0 end)

-- zil: gparser.zil:1214  <CONSTANT P-SRCALL>
ZG._declare("P_SRCALL", function() return 1 end)

-- zil: gparser.zil:1331  <GLOBAL ALWAYS-LIT>
ZG._declare("ALWAYS_LIT", function() return false end)

-- ------------------------------------------------------------
-- gverbs
-- ------------------------------------------------------------

-- zil: gverbs.zil:9  <GLOBAL VERBOSE>
ZG._declare("VERBOSE", function() return false end)

-- zil: gverbs.zil:10  <GLOBAL SUPER-BRIEF>
ZG._declare("SUPER_BRIEF", function() return false end)

-- zil: gverbs.zil:722  <GLOBAL HS>
ZG._declare("HS", function() return 0 end)

-- zil: gverbs.zil:844  <GLOBAL JUMPLOSS>
ZG._declare("JUMPLOSS", function() return ZG.LTABLE(0, "You should have looked before you leaped.", "In the movies, your life would be passing before your eyes.", "Geronimo...") end)

-- zil: gverbs.zil:1272  <GLOBAL WHEEEEE>
ZG._declare("WHEEEEE", function() return ZG.LTABLE(0, "Very good. Now you can go to the second grade.", "Are you enjoying yourself?", "Wheeeeeeeeee!!!!!", "Do you expect me to applaud?") end)

-- zil: gverbs.zil:1626  <GLOBAL LIT>
ZG._declare("LIT", function() return false end)

-- zil: gverbs.zil:1628  <GLOBAL SPRAYED?>
ZG._declare("SPRAYED_p", function() return false end)

-- zil: gverbs.zil:1691  <GLOBAL DESC-OBJECT>
ZG._declare("DESC_OBJECT", function() return false end)

-- zil: gverbs.zil:1843  <GLOBAL MOVES>
ZG._declare("MOVES", function() return 0 end)

-- zil: gverbs.zil:1845  <GLOBAL SCORE>
ZG._declare("SCORE", function() return 0 end)

-- zil: gverbs.zil:1847  <GLOBAL BASE-SCORE>
ZG._declare("BASE_SCORE", function() return 0 end)

-- 注意: WON_FLAG は _1dungeon で別の値で宣言済み (後の宣言が使われる。前の値: ZList(kind='angle', items=[], span=Span(start=28545, end=28547, line=1234, co...)
-- zil: gverbs.zil:1849  <GLOBAL WON-FLAG>
ZG._declare("WON_FLAG", function() return false end)

-- zil: gverbs.zil:1882  <GLOBAL DEAD>
ZG._declare("DEAD", function() return false end)

-- zil: gverbs.zil:1884  <GLOBAL DEATHS>
ZG._declare("DEATHS", function() return 0 end)

-- zil: gverbs.zil:1886  <GLOBAL LUCKY>
ZG._declare("LUCKY", function() return 1 end)

-- zil: gverbs.zil:1896  <GLOBAL FUMBLE-NUMBER>
ZG._declare("FUMBLE_NUMBER", function() return 7 end)

-- zil: gverbs.zil:1898  <GLOBAL FUMBLE-PROB>
ZG._declare("FUMBLE_PROB", function() return 8 end)

-- zil: gverbs.zil:2001  <CONSTANT REXIT>
ZG._declare("REXIT", function() return 0 end)

-- zil: gverbs.zil:2002  <CONSTANT UEXIT>
ZG._declare("UEXIT", function() return 1 end)

-- zil: gverbs.zil:2003  <CONSTANT NEXIT>
ZG._declare("NEXIT", function() return 2 end)

-- zil: gverbs.zil:2004  <CONSTANT FEXIT>
ZG._declare("FEXIT", function() return 3 end)

-- zil: gverbs.zil:2005  <CONSTANT CEXIT>
ZG._declare("CEXIT", function() return 4 end)

-- zil: gverbs.zil:2006  <CONSTANT DEXIT>
ZG._declare("DEXIT", function() return 5 end)

-- zil: gverbs.zil:2008  <CONSTANT NEXITSTR>
ZG._declare("NEXITSTR", function() return 0 end)

-- zil: gverbs.zil:2009  <CONSTANT FEXITFCN>
ZG._declare("FEXITFCN", function() return 0 end)

-- zil: gverbs.zil:2010  <CONSTANT CEXITFLAG>
ZG._declare("CEXITFLAG", function() return 1 end)

-- zil: gverbs.zil:2011  <CONSTANT CEXITSTR>
ZG._declare("CEXITSTR", function() return 1 end)

-- zil: gverbs.zil:2012  <CONSTANT DEXITOBJ>
ZG._declare("DEXITOBJ", function() return 1 end)

-- zil: gverbs.zil:2013  <CONSTANT DEXITSTR>
ZG._declare("DEXITSTR", function() return 1 end)

-- zil: gverbs.zil:2015  <GLOBAL INDENTS>
ZG._declare("INDENTS", function() return ZG.TABLE({"PURE"}, "", "  ", "    ", "      ", "        ", "          ") end)

-- zil: gverbs.zil:2031  <GLOBAL HO-HUM>
ZG._declare("HO_HUM", function() return ZG.LTABLE(0, " doesn't seem to work.", " isn't notably helpful.", " has no effect.") end)

-- zil: gverbs.zil:2195  <GLOBAL SWIMYUKS>
ZG._declare("SWIMYUKS", function() return ZG.LTABLE(0, "You can't swim in the dungeon.") end)

-- zil: gverbs.zil:2198  <GLOBAL HELLOS>
ZG._declare("HELLOS", function() return ZG.LTABLE(0, "Hello.", "Good day.", "Nice weather we've been having lately.", "Goodbye.") end)

-- zil: gverbs.zil:2204  <GLOBAL YUKS>
ZG._declare("YUKS", function() return ZG.LTABLE(0, "A valiant attempt.", "You can't be serious.", "An interesting idea...", "What a concept!") end)

-- zil: gverbs.zil:2213  <GLOBAL DUMMY>
ZG._declare("DUMMY", function() return ZG.LTABLE(0, "Look around.", "Too late for that.", "Have your eyes checked.") end)

-- ------------------------------------------------------------
-- _1actions
-- ------------------------------------------------------------

-- zil: 1actions.zil:239  <GLOBAL KITCHEN-WINDOW-FLAG>
ZG._declare("KITCHEN_WINDOW_FLAG", function() return false end)

-- zil: 1actions.zil:275  <GLOBAL CAGE-TOP>
ZG._declare("CAGE_TOP", function() return true end)

-- zil: 1actions.zil:332  <GLOBAL BAT-DROPS>
ZG._declare("BAT_DROPS", function() return ZG.LTABLE(0, ZG.MINE_1, ZG.MINE_2, ZG.MINE_3, ZG.MINE_4, ZG.LADDER_TOP, ZG.LADDER_BOTTOM, ZG.SQUEEKY_ROOM, ZG.MINE_ENTRANCE) end)

-- zil: 1actions.zil:447  <GLOBAL RUG-MOVED>
ZG._declare("RUG_MOVED", function() return false end)

-- zil: 1actions.zil:771  <GLOBAL GRATE-REVEALED>
ZG._declare("GRATE_REVEALED", function() return false end)

-- zil: 1actions.zil:772  <GLOBAL GRUNLOCK>
ZG._declare("GRUNLOCK", function() return false end)

-- zil: 1actions.zil:968  <GLOBAL MIRROR-MUNG>
ZG._declare("MIRROR_MUNG", function() return false end)

-- 注意: LUCKY は gverbs で別の値で宣言済み (後の宣言が使われる。前の値: ZSymbol(text='1', span=Span(start=52147, end=52148, line=1886, col=15)))
-- zil: 1actions.zil:969  <GLOBAL LUCKY>
ZG._declare("LUCKY", function() return true end)

-- zil: 1actions.zil:1127  <GLOBAL XB>
ZG._declare("XB", function() return false end)

-- zil: 1actions.zil:1129  <GLOBAL XC>
ZG._declare("XC", function() return false end)

-- zil: 1actions.zil:1153  <GLOBAL GATE-FLAG>
ZG._declare("GATE_FLAG", function() return false end)

-- zil: 1actions.zil:1154  <GLOBAL GATES-OPEN>
ZG._declare("GATES_OPEN", function() return false end)

-- zil: 1actions.zil:1261  <GLOBAL LOUD-RUNS>
ZG._declare("LOUD_RUNS", function() return ZG.LTABLE(0, ZG.DAMP_CAVE, ZG.ROUND_ROOM, ZG.DEEP_CANYON) end)

-- zil: 1actions.zil:1284  <GLOBAL DROWNINGS>
ZG._declare("DROWNINGS", function() return ZG.TABLE({"PURE"}, "up to your ankles.", "up to your shin.", "up to your knees.", "up to your hips.", "up to your waist.", "up to your chest.", "up to your neck.", "over your head.", "high in your lungs.") end)

-- zil: 1actions.zil:1295  <GLOBAL WATER-LEVEL>
ZG._declare("WATER_LEVEL", function() return 0 end)

-- zil: 1actions.zil:1513  <GLOBAL CYCLOWRATH>
ZG._declare("CYCLOWRATH", function() return 0 end)

-- zil: 1actions.zil:1644  <GLOBAL CYCLOMAD>
ZG._declare("CYCLOMAD", function() return ZG.TABLE({"PURE"}, "The cyclops seems somewhat agitated.", "The cyclops appears to be getting more agitated.", "The cyclops is moving about the room, looking for something.", "The cyclops was looking for salt and pepper. No doubt they are\ncondiments for his upcoming snack.", "The cyclops is moving toward you in an unfriendly manner.", "You have two choices: 1. Leave  2. Become dinner.") end)

-- zil: 1actions.zil:1658  <GLOBAL LOUD-FLAG>
ZG._declare("LOUD_FLAG", function() return false end)

-- zil: 1actions.zil:1748  <GLOBAL EGG-SOLVE>
ZG._declare("EGG_SOLVE", function() return false end)

-- zil: 1actions.zil:1754  <GLOBAL THIEF-HERE>
ZG._declare("THIEF_HERE", function() return false end)

-- zil: 1actions.zil:1945  <GLOBAL THIEF-ENGROSSED>
ZG._declare("THIEF_ENGROSSED", function() return false end)

-- zil: 1actions.zil:2086  <GLOBAL ROBBER-C-DESC>
ZG._declare("ROBBER_C_DESC", function() return "There is a suspicious-looking individual, holding a bag, leaning\nagainst one wall. He is armed with a vicious-looking stiletto." end)

-- zil: 1actions.zil:2090  <GLOBAL ROBBER-U-DESC>
ZG._declare("ROBBER_U_DESC", function() return "There is a suspicious-looking individual lying unconscious on the\nground." end)

-- zil: 1actions.zil:2220  <GLOBAL LAMP-TABLE>
ZG._declare("LAMP_TABLE", function() return ZG.TABLE({"PURE"}, 100, "The lamp appears a bit dimmer.", 70, "The lamp is definitely dimmer now.", 15, "The lamp is nearly out.", 0) end)

-- zil: 1actions.zil:2263  <GLOBAL MATCH-COUNT>
ZG._declare("MATCH_COUNT", function() return 6 end)

-- zil: 1actions.zil:2406  <GLOBAL CANDLE-TABLE>
ZG._declare("CANDLE_TABLE", function() return ZG.TABLE({"PURE"}, 20, "The candles grow shorter.", 10, "The candles are becoming quite short.", 5, "The candles won't last long now.", 0) end)

-- zil: 1actions.zil:2578  <GLOBAL LIGHT-SHAFT>
ZG._declare("LIGHT_SHAFT", function() return 13 end)

-- zil: 1actions.zil:2692  <GLOBAL RIVER-SPEEDS>
ZG._declare("RIVER_SPEEDS", function() return ZG.LTABLE({"PURE"}, ZG.RIVER_1, 4, ZG.RIVER_2, 4, ZG.RIVER_3, 3, ZG.RIVER_4, 2, ZG.RIVER_5, 1) end)

-- zil: 1actions.zil:2695  <GLOBAL RIVER-NEXT>
ZG._declare("RIVER_NEXT", function() return ZG.LTABLE({"PURE"}, ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3, ZG.RIVER_4, ZG.RIVER_5) end)

-- zil: 1actions.zil:2698  <GLOBAL RIVER-LAUNCH>
ZG._declare("RIVER_LAUNCH", function() return ZG.LTABLE({"PURE"}, ZG.DAM_BASE, ZG.RIVER_1, ZG.WHITE_CLIFFS_NORTH, ZG.RIVER_3, ZG.WHITE_CLIFFS_SOUTH, ZG.RIVER_4, ZG.SHORE, ZG.RIVER_5, ZG.SANDY_BEACH, ZG.RIVER_4, ZG.RESERVOIR_SOUTH, ZG.RESERVOIR, ZG.RESERVOIR_NORTH, ZG.RESERVOIR, ZG.STREAM_VIEW, ZG.IN_STREAM) end)

-- zil: 1actions.zil:2842  <GLOBAL BUOY-FLAG>
ZG._declare("BUOY_FLAG", function() return true end)

-- zil: 1actions.zil:2851  <GLOBAL BEACH-DIG>
ZG._declare("BEACH_DIG", function() return -1 end)

-- zil: 1actions.zil:2871  <GLOBAL BDIGS>
ZG._declare("BDIGS", function() return ZG.TABLE({"PURE"}, "You seem to be digging a hole here.", "The hole is getting deeper, but that's about it.", "You are surrounded by a wall of sand on all sides.") end)

-- zil: 1actions.zil:2968  <GLOBAL SING-SONG>
ZG._declare("SING_SONG", function() return false end)

-- zil: 1actions.zil:3236  <CONSTANT F-BUSY?>
ZG._declare("F_BUSY_p", function() return 1 end)

-- zil: 1actions.zil:3237  <CONSTANT F-DEAD>
ZG._declare("F_DEAD", function() return 2 end)

-- zil: 1actions.zil:3238  <CONSTANT F-UNCONSCIOUS>
ZG._declare("F_UNCONSCIOUS", function() return 3 end)

-- zil: 1actions.zil:3239  <CONSTANT F-CONSCIOUS>
ZG._declare("F_CONSCIOUS", function() return 4 end)

-- zil: 1actions.zil:3240  <CONSTANT F-FIRST?>
ZG._declare("F_FIRST_p", function() return 5 end)

-- zil: 1actions.zil:3246  <CONSTANT MISSED>
ZG._declare("MISSED", function() return 1 end)

-- zil: 1actions.zil:3247  <CONSTANT UNCONSCIOUS>
ZG._declare("UNCONSCIOUS", function() return 2 end)

-- zil: 1actions.zil:3248  <CONSTANT KILLED>
ZG._declare("KILLED", function() return 3 end)

-- zil: 1actions.zil:3249  <CONSTANT LIGHT-WOUND>
ZG._declare("LIGHT_WOUND", function() return 4 end)

-- zil: 1actions.zil:3250  <CONSTANT SERIOUS-WOUND>
ZG._declare("SERIOUS_WOUND", function() return 5 end)

-- zil: 1actions.zil:3251  <CONSTANT STAGGER>
ZG._declare("STAGGER", function() return 6 end)

-- zil: 1actions.zil:3252  <CONSTANT LOSE-WEAPON>
ZG._declare("LOSE_WEAPON", function() return 7 end)

-- zil: 1actions.zil:3253  <CONSTANT HESITATE>
ZG._declare("HESITATE", function() return 8 end)

-- zil: 1actions.zil:3254  <CONSTANT SITTING-DUCK>
ZG._declare("SITTING_DUCK", function() return 9 end)

-- zil: 1actions.zil:3258  <GLOBAL DEF1>
ZG._declare("DEF1", function() return ZG.TABLE({"PURE"}, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.UNCONSCIOUS, ZG.UNCONSCIOUS, ZG.KILLED, ZG.KILLED, ZG.KILLED, ZG.KILLED, ZG.KILLED) end)

-- zil: 1actions.zil:3265  <GLOBAL DEF2A>
ZG._declare("DEF2A", function() return ZG.TABLE({"PURE"}, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.UNCONSCIOUS) end)

-- zil: 1actions.zil:3272  <GLOBAL DEF2B>
ZG._declare("DEF2B", function() return ZG.TABLE({"PURE"}, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.UNCONSCIOUS, ZG.KILLED, ZG.KILLED, ZG.KILLED) end)

-- zil: 1actions.zil:3280  <GLOBAL DEF3A>
ZG._declare("DEF3A", function() return ZG.TABLE({"PURE"}, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND) end)

-- zil: 1actions.zil:3287  <GLOBAL DEF3B>
ZG._declare("DEF3B", function() return ZG.TABLE({"PURE"}, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND) end)

-- zil: 1actions.zil:3294  <GLOBAL DEF3C>
ZG._declare("DEF3C", function() return ZG.TABLE({"PURE"}, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND) end)

-- zil: 1actions.zil:3301  <GLOBAL DEF1-RES>
ZG._declare("DEF1_RES", function() return ZG.TABLE(ZG.DEF1, 0, 0) end)

-- zil: 1actions.zil:3306  <GLOBAL DEF2-RES>
ZG._declare("DEF2_RES", function() return ZG.TABLE(ZG.DEF2A, ZG.DEF2B, 0, 0) end)

-- zil: 1actions.zil:3312  <GLOBAL DEF3-RES>
ZG._declare("DEF3_RES", function() return ZG.TABLE(ZG.DEF3A, 0, ZG.DEF3B, 0, ZG.DEF3C) end)

-- zil: 1actions.zil:3323  <CONSTANT STRENGTH-MAX>
ZG._declare("STRENGTH_MAX", function() return 7 end)

-- zil: 1actions.zil:3324  <CONSTANT STRENGTH-MIN>
ZG._declare("STRENGTH_MIN", function() return 2 end)

-- zil: 1actions.zil:3325  <CONSTANT CURE-WAIT>
ZG._declare("CURE_WAIT", function() return 30 end)

-- zil: 1actions.zil:3608  <CONSTANT F-WEP>
ZG._declare("F_WEP", function() return 0 end)

-- zil: 1actions.zil:3609  <CONSTANT F-DEF>
ZG._declare("F_DEF", function() return 1 end)

-- zil: 1actions.zil:3611  <GLOBAL HERO-MELEE>
ZG._declare("HERO_MELEE", function() return ZG.TABLE({"PURE"}, ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "Your ", ZG.F_WEP, " misses the ", ZG.F_DEF, " by an inch."), ZG.LTABLE({"PURE"}, "A good slash, but it misses the ", ZG.F_DEF, " by a mile."), ZG.LTABLE({"PURE"}, "You charge, but the ", ZG.F_DEF, " jumps nimbly aside."), ZG.LTABLE({"PURE"}, "Clang! Crash! The ", ZG.F_DEF, " parries."), ZG.LTABLE({"PURE"}, "A quick stroke, but the ", ZG.F_DEF, " is on guard."), ZG.LTABLE({"PURE"}, "A good stroke, but it's too slow; the ", ZG.F_DEF, " dodges.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "Your ", ZG.F_WEP, " crashes down, knocking the ", ZG.F_DEF, " into dreamland."), ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is battered into unconsciousness."), ZG.LTABLE({"PURE"}, "A furious exchange, and the ", ZG.F_DEF, " is knocked out!"), ZG.LTABLE({"PURE"}, "The haft of your ", ZG.F_WEP, " knocks out the ", ZG.F_DEF, "."), ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is knocked out!")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "It's curtains for the ", ZG.F_DEF, " as your ", ZG.F_WEP, " removes his head."), ZG.LTABLE({"PURE"}, "The fatal blow strikes the ", ZG.F_DEF, " square in the heart: He dies."), ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " takes a fatal blow and slumps to the floor dead.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is struck on the arm; blood begins to trickle down."), ZG.LTABLE({"PURE"}, "Your ", ZG.F_WEP, " pinks the ", ZG.F_DEF, " on the wrist, but it's not serious."), ZG.LTABLE({"PURE"}, "Your stroke lands, but it was only the flat of the blade."), ZG.LTABLE({"PURE"}, "The blow lands, making a shallow gash in the ", ZG.F_DEF, "'s arm!")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " receives a deep gash in his side."), ZG.LTABLE({"PURE"}, "A savage blow on the thigh! The ", ZG.F_DEF, " is stunned but can still fight!"), ZG.LTABLE({"PURE"}, "Slash! Your blow lands! That one hit an artery, it could be serious!"), ZG.LTABLE({"PURE"}, "Slash! Your stroke connects! This could be serious!")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is staggered, and drops to his knees."), ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is momentarily disoriented and can't fight back."), ZG.LTABLE({"PURE"}, "The force of your blow knocks the ", ZG.F_DEF, " back, stunned."), ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is confused and can't fight back."), ZG.LTABLE({"PURE"}, "The quickness of your thrust knocks the ", ZG.F_DEF, " back, stunned.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, "'s weapon is knocked to the floor, leaving him unarmed."), ZG.LTABLE({"PURE"}, "The ", ZG.F_DEF, " is disarmed by a subtle feint past his guard."))) end)

-- zil: 1actions.zil:3654  <GLOBAL CYCLOPS-MELEE>
ZG._declare("CYCLOPS_MELEE", function() return ZG.TABLE({"PURE"}, ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops misses, but the backwash almost knocks you over."), ZG.LTABLE({"PURE"}, "The Cyclops rushes you, but runs into the wall.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops sends you crashing to the floor, unconscious.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops breaks your neck with a massive smash.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "A quick punch, but it was only a glancing blow."), ZG.LTABLE({"PURE"}, "A glancing blow from the Cyclops' fist.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The monster smashes his huge fist into your chest, breaking several\nribs."), ZG.LTABLE({"PURE"}, "The Cyclops almost knocks the wind out of you with a quick punch.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops lands a punch that knocks the wind out of you."), ZG.LTABLE({"PURE"}, "Heedless of your weapons, the Cyclops tosses you against the rock\nwall of the room.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops grabs your ", ZG.F_WEP, ", tastes it, and throws it to the\nground in disgust."), ZG.LTABLE({"PURE"}, "The monster grabs you on the wrist, squeezes, and you drop your\n", ZG.F_WEP, " in pain.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops seems unable to decide whether to broil or stew his\ndinner.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The Cyclops, no sportsman, dispatches his unconscious victim."))) end)

-- zil: 1actions.zil:3689  <GLOBAL TROLL-MELEE>
ZG._declare("TROLL_MELEE", function() return ZG.TABLE({"PURE"}, ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The troll swings his axe, but it misses."), ZG.LTABLE({"PURE"}, "The troll's axe barely misses your ear."), ZG.LTABLE({"PURE"}, "The axe sweeps past as you jump aside."), ZG.LTABLE({"PURE"}, "The axe crashes against the rock, throwing sparks!")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The flat of the troll's axe hits you delicately on the head, knocking\nyou out.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The troll neatly removes your head."), ZG.LTABLE({"PURE"}, "The troll's axe stroke cleaves you from the nave to the chops."), ZG.LTABLE({"PURE"}, "The troll's axe removes your head.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The axe gets you right in the side. Ouch!"), ZG.LTABLE({"PURE"}, "The flat of the troll's axe skins across your forearm."), ZG.LTABLE({"PURE"}, "The troll's swing almost knocks you over as you barely parry\nin time."), ZG.LTABLE({"PURE"}, "The troll swings his axe, and it nicks your arm as you dodge.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The troll charges, and his axe slashes you on your ", ZG.F_WEP, " arm."), ZG.LTABLE({"PURE"}, "An axe stroke makes a deep wound in your leg."), ZG.LTABLE({"PURE"}, "The troll's axe swings down, gashing your shoulder.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The troll hits you with a glancing blow, and you are momentarily\nstunned."), ZG.LTABLE({"PURE"}, "The troll swings; the blade turns on your armor but crashes\nbroadside into your head."), ZG.LTABLE({"PURE"}, "You stagger back under a hail of axe strokes."), ZG.LTABLE({"PURE"}, "The troll's mighty blow drops you to your knees.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The axe hits your ", ZG.F_WEP, " and knocks it spinning."), ZG.LTABLE({"PURE"}, "The troll swings, you parry, but the force of his blow knocks your ", ZG.F_WEP, " away."), ZG.LTABLE({"PURE"}, "The axe knocks your ", ZG.F_WEP, " out of your hand. It falls to the floor.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The troll hesitates, fingering his axe."), ZG.LTABLE({"PURE"}, "The troll scratches his head ruminatively:  Might you be magically\nprotected, he wonders?")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "Conquering his fears, the troll puts you to death."))) end)

-- zil: 1actions.zil:3735  <GLOBAL THIEF-MELEE>
ZG._declare("THIEF_MELEE", function() return ZG.TABLE({"PURE"}, ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The thief stabs nonchalantly with his stiletto and misses."), ZG.LTABLE({"PURE"}, "You dodge as the thief comes in low."), ZG.LTABLE({"PURE"}, "You parry a lightning thrust, and the thief salutes you with\na grim nod."), ZG.LTABLE({"PURE"}, "The thief tries to sneak past your guard, but you twist away.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "Shifting in the midst of a thrust, the thief knocks you unconscious\nwith the haft of his stiletto."), ZG.LTABLE({"PURE"}, "The thief knocks you out.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "Finishing you off, the thief inserts his blade into your heart."), ZG.LTABLE({"PURE"}, "The thief comes in from the side, feints, and inserts the blade\ninto your ribs."), ZG.LTABLE({"PURE"}, "The thief bows formally, raises his stiletto, and with a wry grin,\nends the battle and your life.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "A quick thrust pinks your left arm, and blood starts to\ntrickle down."), ZG.LTABLE({"PURE"}, "The thief draws blood, raking his stiletto across your arm."), ZG.LTABLE({"PURE"}, "The stiletto flashes faster than you can follow, and blood wells\nfrom your leg."), ZG.LTABLE({"PURE"}, "The thief slowly approaches, strikes like a snake, and leaves\nyou wounded.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The thief strikes like a snake! The resulting wound is serious."), ZG.LTABLE({"PURE"}, "The thief stabs a deep cut in your upper arm."), ZG.LTABLE({"PURE"}, "The stiletto touches your forehead, and the blood obscures your\nvision."), ZG.LTABLE({"PURE"}, "The thief strikes at your wrist, and suddenly your grip is slippery\nwith blood.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The butt of his stiletto cracks you on the skull, and you stagger\nback."), ZG.LTABLE({"PURE"}, "The thief rams the haft of his blade into your stomach, leaving\nyou out of breath."), ZG.LTABLE({"PURE"}, "The thief attacks, and you fall back desperately.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "A long, theatrical slash. You catch it on your ", ZG.F_WEP, ", but the\nthief twists his knife, and the ", ZG.F_WEP, " goes flying."), ZG.LTABLE({"PURE"}, "The thief neatly flips your ", ZG.F_WEP, " out of your hands, and it drops\nto the floor."), ZG.LTABLE({"PURE"}, "You parry a low thrust, and your ", ZG.F_WEP, " slips out of your hand.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off."), ZG.LTABLE({"PURE"}, "The thief amuses himself by searching your pockets."), ZG.LTABLE({"PURE"}, "The thief entertains himself by rifling your pack.")), ZG.LTABLE({"PURE"}, ZG.LTABLE({"PURE"}, "The thief, forgetting his essentially genteel upbringing, cuts your\nthroat."), ZG.LTABLE({"PURE"}, "The thief, a pragmatist, dispatches you as a threat to his\nlivelihood."))) end)

-- zil: 1actions.zil:3793  <CONSTANT V-VILLAIN>
ZG._declare("V_VILLAIN", function() return 0 end)

-- zil: 1actions.zil:3794  <CONSTANT V-BEST>
ZG._declare("V_BEST", function() return 1 end)

-- zil: 1actions.zil:3795  <CONSTANT V-BEST-ADV>
ZG._declare("V_BEST_ADV", function() return 2 end)

-- zil: 1actions.zil:3796  <CONSTANT V-PROB>
ZG._declare("V_PROB", function() return 3 end)

-- zil: 1actions.zil:3797  <CONSTANT V-MSGS>
ZG._declare("V_MSGS", function() return 4 end)

-- zil: 1actions.zil:3801  <GLOBAL VILLAINS>
ZG._declare("VILLAINS", function() return ZG.LTABLE(ZG.TABLE(ZG.TROLL, ZG.SWORD, 1, 0, ZG.TROLL_MELEE), ZG.TABLE(ZG.THIEF, ZG.KNIFE, 1, 0, ZG.THIEF_MELEE), ZG.TABLE(ZG.CYCLOPS, false, 0, 0, ZG.CYCLOPS_MELEE)) end)

return ZG
