-- ZIL のグローバル変数・定数の宣言 (自動生成・Lua 5.1 対応)
local ZG = require("ZilRuntime")

-- ------------------------------------------------------------
-- zork2
-- ------------------------------------------------------------

ZG._declare("ZORK_NUMBER", function() return 2 end)

-- ------------------------------------------------------------
-- gmacros
-- ------------------------------------------------------------

ZG._declare("C_ENABLED_p", function() return 0 end)

ZG._declare("C_ENABLED", function() return 1 end)

ZG._declare("C_DISABLED", function() return 0 end)

-- ------------------------------------------------------------
-- _2dungeon
-- ------------------------------------------------------------

-- zil: 2dungeon.zil:35  <GLOBAL SECRET-DOOR>
ZG._declare("SECRET_DOOR", function() return false end)

-- zil: 2dungeon.zil:36  <GLOBAL GNOME-DOOR-FLAG>
ZG._declare("GNOME_DOOR_FLAG", function() return false end)

-- zil: 2dungeon.zil:1414  <GLOBAL BLOC>
ZG._declare("BLOC", function() return ZG.VOLCANO_BOTTOM end)

-- ------------------------------------------------------------
-- gglobals
-- ------------------------------------------------------------

-- zil: gglobals.zil:125  <GLOBAL LOAD-MAX>
ZG._declare("LOAD_MAX", function() return 100 end)

-- zil: gglobals.zil:127  <GLOBAL LOAD-ALLOWED>
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

-- zil: gverbs.zil:2249  <GLOBAL SWIMYUKS>
ZG._declare("SWIMYUKS", function() return ZG.LTABLE(0, "You can't swim in the dungeon.") end)

-- zil: gverbs.zil:2252  <GLOBAL HELLOS>
ZG._declare("HELLOS", function() return ZG.LTABLE(0, "Hello.", "Good day.", "Nice weather we've been having lately.", "Goodbye.") end)

-- zil: gverbs.zil:2258  <GLOBAL YUKS>
ZG._declare("YUKS", function() return ZG.LTABLE(0, "A valiant attempt.", "You can't be serious.", "An interesting idea...", "What a concept!") end)

-- zil: gverbs.zil:2267  <GLOBAL DUMMY>
ZG._declare("DUMMY", function() return ZG.LTABLE(0, "Look around.", "Too late for that.", "Have your eyes checked.") end)

-- ------------------------------------------------------------
-- _2actions
-- ------------------------------------------------------------

-- zil: 2actions.zil:13  <GLOBAL SWORD-GLOW>
ZG._declare("SWORD_GLOW", function() return 0 end)

-- zil: 2actions.zil:88  <GLOBAL EIGHT-DIRECTIONS>
ZG._declare("EIGHT_DIRECTIONS", function() return ZG.TABLE("NORTH", "EAST", "SOUTH", "NE", "SE", "SW", "NW") end)

-- zil: 2actions.zil:91  <GLOBAL MUNGED-ROOM>
ZG._declare("MUNGED_ROOM", function() return false end)

-- zil: 2actions.zil:112  <GLOBAL BTIE-FLAG>
ZG._declare("BTIE_FLAG", function() return false end)

-- zil: 2actions.zil:113  <GLOBAL BINF-FLAG>
ZG._declare("BINF_FLAG", function() return false end)

-- zil: 2actions.zil:114  <GLOBAL BLAB-FLAG>
ZG._declare("BLAB_FLAG", function() return false end)

-- zil: 2actions.zil:115  <GLOBAL SAFE-FLAG>
ZG._declare("SAFE_FLAG", function() return false end)

-- zil: 2actions.zil:253  <GLOBAL BALLOON-UPS>
ZG._declare("BALLOON_UPS", function() return ZG.LTABLE(ZG.VAIR_1, ZG.VAIR_2, ZG.VAIR_3, ZG.VAIR_4) end)

-- zil: 2actions.zil:256  <GLOBAL BALLOON-FLOATS>
ZG._declare("BALLOON_FLOATS", function() return ZG.LTABLE(ZG.LEDGE_1, ZG.VAIR_2, ZG.LEDGE_2, ZG.VAIR_4) end)

-- zil: 2actions.zil:259  <GLOBAL BALLOON-DOWNS>
ZG._declare("BALLOON_DOWNS", function() return ZG.LTABLE(ZG.VAIR_4, ZG.VAIR_3, ZG.VAIR_2, ZG.VAIR_1) end)

-- zil: 2actions.zil:412  <GLOBAL OTHER-PROPERTIES>
ZG._declare("OTHER_PROPERTIES", function() return "Now you've done it. It seems that the brick has other properties\nthan weight, namely the ability to blow you to smithereens." end)

-- zil: 2actions.zil:532  <GLOBAL GNOME-FLAG>
ZG._declare("GNOME_FLAG", function() return false end)

-- zil: 2actions.zil:653  <GLOBAL CRYPT-LIT?>
ZG._declare("CRYPT_LIT_p", function() return true end)

-- zil: 2actions.zil:677  <GLOBAL DIM-DOOR-FLAG>
ZG._declare("DIM_DOOR_FLAG", function() return false end)

-- zil: 2actions.zil:709  <GLOBAL SPRAY-USED?>
ZG._declare("SPRAY_USED_p", function() return false end)

-- zil: 2actions.zil:750  <GLOBAL BUCKET-TOP-FLAG>
ZG._declare("BUCKET_TOP_FLAG", function() return false end)

-- zil: 2actions.zil:752  <GLOBAL EVAPORATED>
ZG._declare("EVAPORATED", function() return false end)

-- zil: 2actions.zil:1094  <GLOBAL FATAL-VAPORS>
ZG._declare("FATAL_VAPORS", function() return "As you pass out, you realize that the vapors from the\nflask's contents are fatal." end)

-- zil: 2actions.zil:1137  <GLOBAL COMPASS-KLUDGE>
ZG._declare("COMPASS_KLUDGE", function() return false end)

-- zil: 2actions.zil:1155  <GLOBAL CAROUSEL-ZOOM-FLAG>
ZG._declare("CAROUSEL_ZOOM_FLAG", function() return false end)

-- zil: 2actions.zil:1157  <GLOBAL CAROUSEL-FLIP-FLAG>
ZG._declare("CAROUSEL_FLIP_FLAG", function() return false end)

-- zil: 2actions.zil:1190  <GLOBAL CAGE-SOLVE-FLAG>
ZG._declare("CAGE_SOLVE_FLAG", function() return false end)

-- zil: 2actions.zil:1312  <GLOBAL BANK-SOLVE-FLAG>
ZG._declare("BANK_SOLVE_FLAG", function() return false end)

-- zil: 2actions.zil:1333  <GLOBAL SCOL-ROOMS>
ZG._declare("SCOL_ROOMS", function() return ZG.LTABLE("EAST", ZG.VIEWING_EAST, "WEST", ZG.VIEWING_WEST, "NORTH", ZG.SMALL_ROOM, "SOUTH", ZG.VAULT) end)

-- zil: 2actions.zil:1343  <GLOBAL SCOL-WALLS>
ZG._declare("SCOL_WALLS", function() return ZG.TABLE(ZG.VIEWING_WEST, ZG.SEWL, ZG.VIEWING_WEST, ZG.VIEWING_EAST, ZG.SWWL, ZG.VIEWING_EAST, ZG.SMALL_ROOM, ZG.SSWL, ZG.VAULT, ZG.VAULT, ZG.SNWL, ZG.SMALL_ROOM) end)

-- zil: 2actions.zil:1357  <GLOBAL SCOL-ROOM>
ZG._declare("SCOL_ROOM", function() return ZG.VIEWING_WEST end)

-- zil: 2actions.zil:1425  <GLOBAL SCOL-ACTIVE>
ZG._declare("SCOL_ACTIVE", function() return false end)

-- zil: 2actions.zil:1443  <GLOBAL ZGNOME-FLAG>
ZG._declare("ZGNOME_FLAG", function() return false end)

-- zil: 2actions.zil:1661  <GLOBAL MUD-FLAG>
ZG._declare("MUD_FLAG", function() return false end)

-- zil: 2actions.zil:1663  <GLOBAL MATOBJ>
ZG._declare("MATOBJ", function() return false end)

-- zil: 2actions.zil:1665  <GLOBAL PUNLOCK-FLAG>
ZG._declare("PUNLOCK_FLAG", function() return false end)

-- zil: 2actions.zil:1667  <GLOBAL PLOOK-FLAG>
ZG._declare("PLOOK_FLAG", function() return false end)

-- zil: 2actions.zil:1895  <GLOBAL MATCH-COUNT>
ZG._declare("MATCH_COUNT", function() return 6 end)

-- zil: 2actions.zil:1934  <GLOBAL LAMP-TABLE>
ZG._declare("LAMP_TABLE", function() return ZG.TABLE(300, "The lamp appears a bit dimmer.", 100, "The lamp is definitely dimmer now.", 50, "The lamp is nearly out.", 0) end)

-- 注意: DUMMY は gverbs で別の値で宣言済み (後の宣言が使われる。前の値: ZList(kind='angle', items=[ZSymbol(text='LTABLE', span=Span(start=61991, end=...)
-- zil: 2actions.zil:2056  <GLOBAL DUMMY>
ZG._declare("DUMMY", function() return ZG.LTABLE("Look around.", "You think it isn't?", "I think you've already done that.") end)

-- zil: 2actions.zil:2174  <GLOBAL DIAMOND-SOLVE>
ZG._declare("DIAMOND_SOLVE", function() return false end)

-- zil: 2actions.zil:2176  <GLOBAL DIAMOND-COUNT>
ZG._declare("DIAMOND_COUNT", function() return 0 end)

-- zil: 2actions.zil:2177  <GLOBAL DIAMOND-MOVES>
ZG._declare("DIAMOND_MOVES", function() return 0 end)

-- zil: 2actions.zil:2178  <GLOBAL DIAMOND-BASE>
ZG._declare("DIAMOND_BASE", function() return 0 end)

-- zil: 2actions.zil:2180  <GLOBAL DWDESCS>
ZG._declare("DWDESCS", function() return ZG.TABLE("dark", "flickering dimly", "dimly glowing", "glowing", "glowing brightly") end)

-- zil: 2actions.zil:2284  <GLOBAL BASES>
ZG._declare("BASES", function() return ZG.TABLE("first", "first", "first", "second", "third", "home") end)

-- zil: 2actions.zil:2286  <GLOBAL DIAMOND-ROOMS>
ZG._declare("DIAMOND_ROOMS", function() return ZG.TABLE(ZG.DIAMOND_2, ZG.DIAMOND_4, ZG.DIAMOND_6, ZG.DIAMOND_8, ZG.DIAMOND_1, ZG.DIAMOND_3, ZG.DIAMOND_5, ZG.DIAMOND_7, ZG.DIAMOND_9) end)

-- zil: 2actions.zil:2290  <GLOBAL DIDIRS>
ZG._declare("DIDIRS", function() return ZG.TABLE("SE", "NE", "NW", "SW") end)

-- zil: 2actions.zil:2296  <GLOBAL CERBERUS-LEASHED>
ZG._declare("CERBERUS_LEASHED", function() return false end)

-- zil: 2actions.zil:2370  <GLOBAL ICE-MELTED>
ZG._declare("ICE_MELTED", function() return false end)

-- zil: 2actions.zil:2434  <GLOBAL DRAGON-ANGER>
ZG._declare("DRAGON_ANGER", function() return 0 end)

-- zil: 2actions.zil:2436  <GLOBAL DRAGON-ATTACKS>
ZG._declare("DRAGON_ATTACKS", function() return ZG.LTABLE("Dragon hide is tough as steel, but you have succeeded in annoying him\na bit. He looks at you as if deciding whether or not to eat you.", "That captured his interest. He stares at you balefully.", "The dragon is surprised and interested (for the moment).", "You've made him rather angry. You had better be very careful now.", "That did no damage, but he turns his smoky yellow eyes in your direction\nand sighs.") end)

-- zil: 2actions.zil:2469  <GLOBAL OLD-HERE>
ZG._declare("OLD_HERE", function() return ZG.DRAGON_ROOM end)

-- zil: 2actions.zil:2610  <GLOBAL TOPIARY-MOVED>
ZG._declare("TOPIARY_MOVED", function() return false end)

-- zil: 2actions.zil:2611  <GLOBAL TOPIARY-NEAR>
ZG._declare("TOPIARY_NEAR", function() return false end)

-- zil: 2actions.zil:2613  <GLOBAL UNICORN-MSGS>
ZG._declare("UNICORN_MSGS", function() return ZG.LTABLE("There is a large, white animal partly hidden behind some trees.", "You catch a glimpse of something white between two hedges.", "A unicorn is cropping grass on the other side of the room.\nA gold key hangs from a ribbon around its neck.", "There is a beautiful unicorn eating roses here. Around his\nneck is a red satin ribbon on which is strung a tiny key.") end)

-- zil: 2actions.zil:2661  <GLOBAL UNICORN-FRIGHTENED>
ZG._declare("UNICORN_FRIGHTENED", function() return false end)

-- zil: 2actions.zil:2697  <GLOBAL PRINCESS-AWAKE>
ZG._declare("PRINCESS_AWAKE", function() return false end)

-- zil: 2actions.zil:2755  <GLOBAL PRCOUNT>
ZG._declare("PRCOUNT", function() return 0 end)

-- zil: 2actions.zil:2757  <GLOBAL PRFOLLOW>
ZG._declare("PRFOLLOW", function() return false end)

-- zil: 2actions.zil:2759  <GLOBAL PRDIRS>
ZG._declare("PRDIRS", function() return ZG.TABLE("south", ZG.DRAGON_ROOM, "north", "SOUTH", "east", ZG.LEDGE_TUNNEL, "west", "EAST", "east", ZG.RAVINE_LEDGE, "west", "EAST", "down", ZG.DEEP_FORD, "up", "DOWN", "south", ZG.MARBLE_HALL, "north", "SOUTH", "east", ZG.STREAM_PATH, "west", "EAST", "east", ZG.FORMAL_GARDEN, "west", "EAST", "north", ZG.GARDEN_NORTH, "south", "NORTH", "in", ZG.GAZEBO_ROOM, "out", "IN") end)

-- zil: 2actions.zil:2889  <GLOBAL MENHIR-POSITION>
ZG._declare("MENHIR_POSITION", function() return false end)

-- zil: 2actions.zil:2922  <GLOBAL GUARDIAN-FED>
ZG._declare("GUARDIAN_FED", function() return false end)

-- zil: 2actions.zil:2964  <GLOBAL WIZ-DOOR-FLAG>
ZG._declare("WIZ_DOOR_FLAG", function() return false end)

-- zil: 2actions.zil:3350  <GLOBAL GENIE-READY?>
ZG._declare("GENIE_READY_p", function() return false end)

-- zil: 2actions.zil:3351  <GLOBAL GENIE-HOARD>
ZG._declare("GENIE_HOARD", function() return 0 end)

-- zil: 2actions.zil:3352  <CONSTANT TREASURES-MAX>
ZG._declare("TREASURES_MAX", function() return 10 end)

-- zil: 2actions.zil:3355  <GLOBAL GENIE-THANKS>
ZG._declare("GENIE_THANKS", function() return ZG.LTABLE("Most fine, master! But 'tis not enough. I will do a great service,\nand are not great services bought at great price?", "Very nice, but not enough!", "Ah, truly magnificent! Keep them coming.", "Almost halfway there, oh worthy one!", "Oh, such beauty! Your generosity almost overwhelms me!", "Truly I shall do thee a wonderful service when thou hast finished!", "Truly you are most generous! But still, this is yet not enough.", "A fine gift, mighty one, you have almost reached my fee.", "Wondrous fine, master! But one treasure is yet to be given!") end)

-- zil: 2actions.zil:3654  <GLOBAL SPELL?>
ZG._declare("SPELL_p", function() return false end)

-- zil: 2actions.zil:3656  <CONSTANT SPELLS>
ZG._declare("SPELLS", function() return 12 end)

-- zil: 2actions.zil:3657  <CONSTANT S-FEEBLE>
ZG._declare("S_FEEBLE", function() return 1 end)

-- zil: 2actions.zil:3658  <CONSTANT S-FUMBLE>
ZG._declare("S_FUMBLE", function() return 2 end)

-- zil: 2actions.zil:3659  <CONSTANT S-FEAR>
ZG._declare("S_FEAR", function() return 3 end)

-- zil: 2actions.zil:3660  <CONSTANT S-FILCH>
ZG._declare("S_FILCH", function() return 4 end)

-- zil: 2actions.zil:3661  <CONSTANT S-FREEZE>
ZG._declare("S_FREEZE", function() return 5 end)

-- zil: 2actions.zil:3662  <CONSTANT S-FALL>
ZG._declare("S_FALL", function() return 6 end)

-- zil: 2actions.zil:3663  <CONSTANT S-FERMENT>
ZG._declare("S_FERMENT", function() return 7 end)

-- zil: 2actions.zil:3664  <CONSTANT S-FIERCE>
ZG._declare("S_FIERCE", function() return 8 end)

-- zil: 2actions.zil:3665  <CONSTANT S-FLOAT>
ZG._declare("S_FLOAT", function() return 9 end)

-- zil: 2actions.zil:3666  <CONSTANT S-FIREPROOF>
ZG._declare("S_FIREPROOF", function() return 10 end)

-- zil: 2actions.zil:3667  <CONSTANT S-FENCE>
ZG._declare("S_FENCE", function() return 11 end)

-- zil: 2actions.zil:3668  <CONSTANT S-FANTASIZE>
ZG._declare("S_FANTASIZE", function() return 12 end)

-- zil: 2actions.zil:3670  <GLOBAL SPELL-NAMES>
ZG._declare("SPELL_NAMES", function() return ZG.LTABLE("Feeble", "Fumble", "Fear", "Filch", "Freeze", "Fall", "Ferment", "Fierce", "Float", "Fireproof", "Fence", "Fantasize") end)

-- zil: 2actions.zil:3675  <GLOBAL SPELL-HINTS>
ZG._declare("SPELL_HINTS", function() return ZG.LTABLE("All at once you feel very tired.", false, "You look at the Wizard in terror. You scramble away,\ntrying to get as far as possible from him.", false, "Your limbs suddenly feel like they have turned to stone. You can't\nmove a muscle.", false, "You begin to feel lightheaded.", "You rush at the Wizard, intending to tear him limb from limb.", false, false, false, false) end)

-- zil: 2actions.zil:3692  <GLOBAL SPELL-STOPS>
ZG._declare("SPELL_STOPS", function() return ZG.LTABLE("You feel more energetic now.", false, "You suddenly decide that the Wizard isn't that terrifying...", false, "Your little finger begins to twitch, and then your whole body is free\nagain.", false, "Your head is clearer now.", "You feel cooler and less angry now.", "You sink quietly down again.", false, false, false) end)

-- zil: 2actions.zil:3746  <GLOBAL SPELL-HANDLED?>
ZG._declare("SPELL_HANDLED_p", function() return false end)

-- zil: 2actions.zil:3747  <GLOBAL WAND-ON>
ZG._declare("WAND_ON", function() return false end)

-- zil: 2actions.zil:3748  <GLOBAL SPELL-USED>
ZG._declare("SPELL_USED", function() return false end)

-- zil: 2actions.zil:3749  <GLOBAL SPELL-VICTIM>
ZG._declare("SPELL_VICTIM", function() return false end)

-- zil: 2actions.zil:3808  <GLOBAL WAND-ON-LOC>
ZG._declare("WAND_ON_LOC", function() return false end)

-- zil: 2actions.zil:3836  <GLOBAL WIZQLAST>
ZG._declare("WIZQLAST", function() return 0 end)

-- zil: 2actions.zil:3838  <GLOBAL WIZQDESCS>
ZG._declare("WIZQDESCS", function() return ZG.LTABLE("sparsely furnished and almost monkish in its austerity.", "an opulently furnished seraglio out of an Arabian folktale.", "decorated in the Louis XIV style.", "overhung with palm-trees and lianas. The only furniture is a hammock.", "constructed of delicate and wispy cloud-stuffs.", "furnished in plastic and metal and looks like the control deck of a\nspaceship.", "a suburban bedroom out of the 1950's, complete with bunk beds.", "a dank and dimly lighted cave, its floor piled with furs and old bones.") end)

-- zil: 2actions.zil:3908  <GLOBAL FANTASIES>
ZG._declare("FANTASIES", function() return ZG.LTABLE("pile of jewels", "gold ingot", "basilisk", "bulging chest", "yellow sphere", "grue", "convention of wizards", "copy of ZORK I") end)

return ZG
