"""ZIL のグローバル変数・定数の宣言 (自動生成)。

全 ZIL ファイルの GLOBAL / CONSTANT をここに集める。元のファイルには
コメントとして残してある。値は最初に参照された時に評価する。
"""

from ZilRuntime import *

# ------------------------------------------------------------
# zork1
# ------------------------------------------------------------

ZG.const._declare('ZORK_NUMBER', lambda: 1)

# ------------------------------------------------------------
# gmacros
# ------------------------------------------------------------

ZG.const._declare('C_ENABLED_p', lambda: 0)

ZG.const._declare('C_ENABLED', lambda: 1)

ZG.const._declare('C_DISABLED', lambda: 0)

# ------------------------------------------------------------
# _1dungeon
# ------------------------------------------------------------

# zil: 1dungeon.zil:7  <GLOBAL SCORE-MAX>
ZG.state._declare('SCORE_MAX', lambda: 350)

# zil: 1dungeon.zil:9  <GLOBAL FALSE-FLAG>
ZG.state._declare('FALSE_FLAG', lambda: False)

# zil: 1dungeon.zil:1225  <GLOBAL CYCLOPS-FLAG>
ZG.state._declare('CYCLOPS_FLAG', lambda: False)

# zil: 1dungeon.zil:1226  <GLOBAL DEFLATE>
ZG.state._declare('DEFLATE', lambda: False)

# zil: 1dungeon.zil:1227  <GLOBAL DOME-FLAG>
ZG.state._declare('DOME_FLAG', lambda: False)

# zil: 1dungeon.zil:1228  <GLOBAL EMPTY-HANDED>
ZG.state._declare('EMPTY_HANDED', lambda: False)

# zil: 1dungeon.zil:1229  <GLOBAL LLD-FLAG>
ZG.state._declare('LLD_FLAG', lambda: False)

# zil: 1dungeon.zil:1230  <GLOBAL LOW-TIDE>
ZG.state._declare('LOW_TIDE', lambda: False)

# zil: 1dungeon.zil:1231  <GLOBAL MAGIC-FLAG>
ZG.state._declare('MAGIC_FLAG', lambda: False)

# zil: 1dungeon.zil:1232  <GLOBAL RAINBOW-FLAG>
ZG.state._declare('RAINBOW_FLAG', lambda: False)

# zil: 1dungeon.zil:1233  <GLOBAL TROLL-FLAG>
ZG.state._declare('TROLL_FLAG', lambda: False)

# zil: 1dungeon.zil:1234  <GLOBAL WON-FLAG>
ZG.state._declare('WON_FLAG', lambda: False)

# zil: 1dungeon.zil:1235  <GLOBAL COFFIN-CURE>
ZG.state._declare('COFFIN_CURE', lambda: False)

# zil: 1dungeon.zil:2620  <GLOBAL HOUSE-AROUND>
ZG.state._declare('HOUSE_AROUND', lambda: LTABLE(('PURE',), ZG.WEST_OF_HOUSE, ZG.NORTH_OF_HOUSE, ZG.EAST_OF_HOUSE, ZG.SOUTH_OF_HOUSE, ZG.WEST_OF_HOUSE))

# zil: 1dungeon.zil:2624  <GLOBAL FOREST-AROUND>
ZG.state._declare('FOREST_AROUND', lambda: LTABLE(('PURE',), ZG.FOREST_1, ZG.FOREST_2, ZG.FOREST_3, ZG.PATH, ZG.CLEARING, ZG.FOREST_1))

# zil: 1dungeon.zil:2627  <GLOBAL IN-HOUSE-AROUND>
ZG.state._declare('IN_HOUSE_AROUND', lambda: LTABLE(('PURE',), ZG.LIVING_ROOM, ZG.KITCHEN, ZG.ATTIC, ZG.KITCHEN))

# zil: 1dungeon.zil:2630  <GLOBAL ABOVE-GROUND>
ZG.state._declare('ABOVE_GROUND', lambda: LTABLE(('PURE',), ZG.WEST_OF_HOUSE, ZG.NORTH_OF_HOUSE, ZG.EAST_OF_HOUSE, ZG.SOUTH_OF_HOUSE, ZG.FOREST_1, ZG.FOREST_2, ZG.FOREST_3, ZG.PATH, ZG.CLEARING, ZG.GRATING_CLEARING, ZG.CANYON_VIEW))

# ------------------------------------------------------------
# gglobals
# ------------------------------------------------------------

# zil: gglobals.zil:92  <GLOBAL LOAD-MAX>
ZG.state._declare('LOAD_MAX', lambda: 100)

# zil: gglobals.zil:94  <GLOBAL LOAD-ALLOWED>
ZG.state._declare('LOAD_ALLOWED', lambda: 100)

# ------------------------------------------------------------
# gclock
# ------------------------------------------------------------

# zil: gclock.zil:5  <CONSTANT C-TABLELEN>
ZG.const._declare('C_TABLELEN', lambda: 180)

# zil: gclock.zil:7  <GLOBAL C-TABLE>
ZG.state._declare('C_TABLE', lambda: ITABLE('NONE', 180))

# zil: gclock.zil:9  <GLOBAL C-DEMONS>
ZG.state._declare('C_DEMONS', lambda: 180)

# zil: gclock.zil:11  <GLOBAL C-INTS>
ZG.state._declare('C_INTS', lambda: 180)

# zil: gclock.zil:13  <CONSTANT C-INTLEN>
ZG.const._declare('C_INTLEN', lambda: 6)

# zil: gclock.zil:15  <CONSTANT C-ENABLED?>
ZG.const._declare('C_ENABLED_p', lambda: 0)

# zil: gclock.zil:17  <CONSTANT C-TICK>
ZG.const._declare('C_TICK', lambda: 1)

# zil: gclock.zil:19  <CONSTANT C-RTN>
ZG.const._declare('C_RTN', lambda: 2)

# zil: gclock.zil:41  <GLOBAL CLOCK-WAIT>
ZG.state._declare('CLOCK_WAIT', lambda: False)

# ------------------------------------------------------------
# gmain
# ------------------------------------------------------------

# zil: gmain.zil:5  <CONSTANT SERIAL>
ZG.const._declare('SERIAL', lambda: 0)

# zil: gmain.zil:7  <GLOBAL PLAYER>
ZG.state._declare('PLAYER', lambda: False)

# zil: gmain.zil:9  <GLOBAL P-WON>
ZG.scratch._declare('P_WON', lambda: False)

# zil: gmain.zil:11  <CONSTANT M-FATAL>
ZG.const._declare('M_FATAL', lambda: 2)

# zil: gmain.zil:13  <CONSTANT M-HANDLED>
ZG.const._declare('M_HANDLED', lambda: 1)

# zil: gmain.zil:15  <CONSTANT M-NOT-HANDLED>
ZG.const._declare('M_NOT_HANDLED', lambda: False)

# zil: gmain.zil:17  <CONSTANT M-OBJECT>
ZG.const._declare('M_OBJECT', lambda: False)

# zil: gmain.zil:19  <CONSTANT M-BEG>
ZG.const._declare('M_BEG', lambda: 1)

# zil: gmain.zil:21  <CONSTANT M-END>
ZG.const._declare('M_END', lambda: 6)

# zil: gmain.zil:23  <CONSTANT M-ENTER>
ZG.const._declare('M_ENTER', lambda: 2)

# zil: gmain.zil:25  <CONSTANT M-LOOK>
ZG.const._declare('M_LOOK', lambda: 3)

# zil: gmain.zil:27  <CONSTANT M-FLASH>
ZG.const._declare('M_FLASH', lambda: 4)

# zil: gmain.zil:29  <CONSTANT M-OBJDESC>
ZG.const._declare('M_OBJDESC', lambda: 5)

# zil: gmain.zil:174  <GLOBAL P-MULT>
ZG.scratch._declare('P_MULT', lambda: False)

# zil: gmain.zil:176  <GLOBAL P-NOT-HERE>
ZG.scratch._declare('P_NOT_HERE', lambda: 0)

# ------------------------------------------------------------
# gparser
# ------------------------------------------------------------

ZG.const._declare('SIBREAKS', lambda: '.,"')

# zil: gparser.zil:14  <GLOBAL PRSA>
ZG.scratch._declare('PRSA', lambda: False)

# zil: gparser.zil:15  <GLOBAL PRSI>
ZG.scratch._declare('PRSI', lambda: False)

# zil: gparser.zil:16  <GLOBAL PRSO>
ZG.scratch._declare('PRSO', lambda: False)

# zil: gparser.zil:18  <GLOBAL P-TABLE>
ZG.scratch._declare('P_TABLE', lambda: 0)

# zil: gparser.zil:19  <GLOBAL P-ONEOBJ>
ZG.scratch._declare('P_ONEOBJ', lambda: 0)

# zil: gparser.zil:20  <GLOBAL P-SYNTAX>
ZG.scratch._declare('P_SYNTAX', lambda: 0)

# zil: gparser.zil:22  <GLOBAL P-CCTBL>
ZG.scratch._declare('P_CCTBL', lambda: TABLE(0, 0, 0, 0))

# zil: gparser.zil:24  <CONSTANT CC-SBPTR>
ZG.const._declare('CC_SBPTR', lambda: 0)

# zil: gparser.zil:25  <CONSTANT CC-SEPTR>
ZG.const._declare('CC_SEPTR', lambda: 1)

# zil: gparser.zil:26  <CONSTANT CC-DBPTR>
ZG.const._declare('CC_DBPTR', lambda: 2)

# zil: gparser.zil:27  <CONSTANT CC-DEPTR>
ZG.const._declare('CC_DEPTR', lambda: 3)

# zil: gparser.zil:29  <GLOBAL P-LEN>
ZG.scratch._declare('P_LEN', lambda: 0)

# zil: gparser.zil:30  <GLOBAL P-DIR>
ZG.scratch._declare('P_DIR', lambda: 0)

# zil: gparser.zil:31  <GLOBAL HERE>
ZG.scratch._declare('HERE', lambda: 0)

# zil: gparser.zil:32  <GLOBAL WINNER>
ZG.scratch._declare('WINNER', lambda: 0)

# zil: gparser.zil:34  <GLOBAL P-LEXV>
ZG.scratch._declare('P_LEXV', lambda: ITABLE(59, ('LEXV',), 0, TBYTE(0), TBYTE(0)))

# zil: gparser.zil:36  <GLOBAL AGAIN-LEXV>
ZG.scratch._declare('AGAIN_LEXV', lambda: ITABLE(59, ('LEXV',), 0, TBYTE(0), TBYTE(0)))

# zil: gparser.zil:38  <GLOBAL RESERVE-LEXV>
ZG.scratch._declare('RESERVE_LEXV', lambda: ITABLE(59, ('LEXV',), 0, TBYTE(0), TBYTE(0)))

# zil: gparser.zil:40  <GLOBAL RESERVE-PTR>
ZG.scratch._declare('RESERVE_PTR', lambda: False)

# zil: gparser.zil:44  <GLOBAL P-INBUF>
ZG.scratch._declare('P_INBUF', lambda: ITABLE(120, ('BYTE', 'LENGTH'), 0))

# zil: gparser.zil:47  <GLOBAL OOPS-INBUF>
ZG.scratch._declare('OOPS_INBUF', lambda: ITABLE(120, ('BYTE', 'LENGTH'), 0))

# zil: gparser.zil:50  <GLOBAL OOPS-TABLE>
ZG.scratch._declare('OOPS_TABLE', lambda: TABLE(False, False, False, False))

# zil: gparser.zil:51  <CONSTANT O-PTR>
ZG.const._declare('O_PTR', lambda: 0)

# zil: gparser.zil:52  <CONSTANT O-START>
ZG.const._declare('O_START', lambda: 1)

# zil: gparser.zil:53  <CONSTANT O-LENGTH>
ZG.const._declare('O_LENGTH', lambda: 2)

# zil: gparser.zil:54  <CONSTANT O-END>
ZG.const._declare('O_END', lambda: 3)

# zil: gparser.zil:58  <GLOBAL P-CONT>
ZG.scratch._declare('P_CONT', lambda: False)

# zil: gparser.zil:59  <GLOBAL P-IT-OBJECT>
ZG.scratch._declare('P_IT_OBJECT', lambda: False)

# zil: gparser.zil:64  <GLOBAL P-OFLAG>
ZG.scratch._declare('P_OFLAG', lambda: False)

# zil: gparser.zil:65  <GLOBAL P-MERGED>
ZG.scratch._declare('P_MERGED', lambda: False)

# zil: gparser.zil:66  <GLOBAL P-ACLAUSE>
ZG.scratch._declare('P_ACLAUSE', lambda: False)

# zil: gparser.zil:67  <GLOBAL P-ANAM>
ZG.scratch._declare('P_ANAM', lambda: False)

# zil: gparser.zil:68  <GLOBAL P-AADJ>
ZG.scratch._declare('P_AADJ', lambda: False)

# zil: gparser.zil:73  <CONSTANT P-LEXWORDS>
ZG.const._declare('P_LEXWORDS', lambda: 1)

# zil: gparser.zil:74  <CONSTANT P-LEXSTART>
ZG.const._declare('P_LEXSTART', lambda: 1)

# zil: gparser.zil:75  <CONSTANT P-LEXELEN>
ZG.const._declare('P_LEXELEN', lambda: 2)

# zil: gparser.zil:76  <CONSTANT P-WORDLEN>
ZG.const._declare('P_WORDLEN', lambda: 4)

# zil: gparser.zil:78  <CONSTANT P-PSOFF>
ZG.const._declare('P_PSOFF', lambda: 4)

# zil: gparser.zil:79  <CONSTANT P-P1OFF>
ZG.const._declare('P_P1OFF', lambda: 5)

# zil: gparser.zil:80  <CONSTANT P-P1BITS>
ZG.const._declare('P_P1BITS', lambda: 3)

# zil: gparser.zil:82  <CONSTANT P-ITBLLEN>
ZG.const._declare('P_ITBLLEN', lambda: 9)

# zil: gparser.zil:83  <GLOBAL P-ITBL>
ZG.scratch._declare('P_ITBL', lambda: TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0))

# zil: gparser.zil:84  <GLOBAL P-OTBL>
ZG.scratch._declare('P_OTBL', lambda: TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0))

# zil: gparser.zil:85  <GLOBAL P-VTBL>
ZG.scratch._declare('P_VTBL', lambda: TABLE(0, 0, 0, 0))

# zil: gparser.zil:86  <GLOBAL P-OVTBL>
ZG.scratch._declare('P_OVTBL', lambda: TABLE(0, TBYTE(0), TBYTE(0)))

# zil: gparser.zil:88  <GLOBAL P-NCN>
ZG.scratch._declare('P_NCN', lambda: 0)

# zil: gparser.zil:90  <CONSTANT P-VERB>
ZG.const._declare('P_VERB', lambda: 0)

# zil: gparser.zil:91  <CONSTANT P-VERBN>
ZG.const._declare('P_VERBN', lambda: 1)

# zil: gparser.zil:92  <CONSTANT P-PREP1>
ZG.const._declare('P_PREP1', lambda: 2)

# zil: gparser.zil:93  <CONSTANT P-PREP1N>
ZG.const._declare('P_PREP1N', lambda: 3)

# zil: gparser.zil:94  <CONSTANT P-PREP2>
ZG.const._declare('P_PREP2', lambda: 4)

# zil: gparser.zil:95  <CONSTANT P-PREP2N>
ZG.const._declare('P_PREP2N', lambda: 5)

# zil: gparser.zil:96  <CONSTANT P-NC1>
ZG.const._declare('P_NC1', lambda: 6)

# zil: gparser.zil:97  <CONSTANT P-NC1L>
ZG.const._declare('P_NC1L', lambda: 7)

# zil: gparser.zil:98  <CONSTANT P-NC2>
ZG.const._declare('P_NC2', lambda: 8)

# zil: gparser.zil:99  <CONSTANT P-NC2L>
ZG.const._declare('P_NC2L', lambda: 9)

# zil: gparser.zil:101  <GLOBAL QUOTE-FLAG>
ZG.scratch._declare('QUOTE_FLAG', lambda: False)

# zil: gparser.zil:102  <GLOBAL P-END-ON-PREP>
ZG.scratch._declare('P_END_ON_PREP', lambda: False)

# zil: gparser.zil:382  <GLOBAL P-ACT>
ZG.scratch._declare('P_ACT', lambda: False)

# zil: gparser.zil:383  <GLOBAL P-WALK-DIR>
ZG.scratch._declare('P_WALK_DIR', lambda: False)

# zil: gparser.zil:384  <GLOBAL AGAIN-DIR>
ZG.scratch._declare('AGAIN_DIR', lambda: False)

# zil: gparser.zil:536  <GLOBAL P-NUMBER>
ZG.scratch._declare('P_NUMBER', lambda: 0)

# zil: gparser.zil:538  <GLOBAL P-DIRECTION>
ZG.scratch._declare('P_DIRECTION', lambda: 0)

# zil: gparser.zil:693  <GLOBAL P-SLOCBITS>
ZG.scratch._declare('P_SLOCBITS', lambda: 0)

# zil: gparser.zil:695  <CONSTANT P-SYNLEN>
ZG.const._declare('P_SYNLEN', lambda: 8)

# zil: gparser.zil:697  <CONSTANT P-SBITS>
ZG.const._declare('P_SBITS', lambda: 0)

# zil: gparser.zil:698  <CONSTANT P-SPREP1>
ZG.const._declare('P_SPREP1', lambda: 1)

# zil: gparser.zil:699  <CONSTANT P-SPREP2>
ZG.const._declare('P_SPREP2', lambda: 2)

# zil: gparser.zil:700  <CONSTANT P-SFWIM1>
ZG.const._declare('P_SFWIM1', lambda: 3)

# zil: gparser.zil:701  <CONSTANT P-SFWIM2>
ZG.const._declare('P_SFWIM2', lambda: 4)

# zil: gparser.zil:702  <CONSTANT P-SLOC1>
ZG.const._declare('P_SLOC1', lambda: 5)

# zil: gparser.zil:703  <CONSTANT P-SLOC2>
ZG.const._declare('P_SLOC2', lambda: 6)

# zil: gparser.zil:704  <CONSTANT P-SACTION>
ZG.const._declare('P_SACTION', lambda: 7)

# zil: gparser.zil:705  <CONSTANT P-SONUMS>
ZG.const._declare('P_SONUMS', lambda: 3)

# zil: gparser.zil:899  <GLOBAL P-GWIMBIT>
ZG.scratch._declare('P_GWIMBIT', lambda: 0)

# zil: gparser.zil:960  <GLOBAL P-NAM>
ZG.scratch._declare('P_NAM', lambda: False)

# zil: gparser.zil:961  <GLOBAL P-ADJ>
ZG.scratch._declare('P_ADJ', lambda: False)

# zil: gparser.zil:962  <GLOBAL P-ADVERB>
ZG.scratch._declare('P_ADVERB', lambda: False)

# zil: gparser.zil:963  <GLOBAL P-ADJN>
ZG.scratch._declare('P_ADJN', lambda: False)

# zil: gparser.zil:964  <GLOBAL P-PRSO>
ZG.scratch._declare('P_PRSO', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:965  <GLOBAL P-PRSI>
ZG.scratch._declare('P_PRSI', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:966  <GLOBAL P-BUTS>
ZG.scratch._declare('P_BUTS', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:967  <GLOBAL P-MERGE>
ZG.scratch._declare('P_MERGE', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:968  <GLOBAL P-OCLAUSE>
ZG.scratch._declare('P_OCLAUSE', lambda: ITABLE('NONE', 100))

# zil: gparser.zil:969  <GLOBAL P-MATCHLEN>
ZG.scratch._declare('P_MATCHLEN', lambda: 0)

# zil: gparser.zil:970  <GLOBAL P-GETFLAGS>
ZG.scratch._declare('P_GETFLAGS', lambda: 0)

# zil: gparser.zil:971  <CONSTANT P-ALL>
ZG.const._declare('P_ALL', lambda: 1)

# zil: gparser.zil:972  <CONSTANT P-ONE>
ZG.const._declare('P_ONE', lambda: 2)

# zil: gparser.zil:973  <CONSTANT P-INHIBIT>
ZG.const._declare('P_INHIBIT', lambda: 4)

# zil: gparser.zil:976  <GLOBAL P-AND>
ZG.scratch._declare('P_AND', lambda: False)

# zil: gparser.zil:1032  <CONSTANT SH>
ZG.const._declare('SH', lambda: 128)

# zil: gparser.zil:1033  <CONSTANT SC>
ZG.const._declare('SC', lambda: 64)

# zil: gparser.zil:1034  <CONSTANT SIR>
ZG.const._declare('SIR', lambda: 32)

# zil: gparser.zil:1035  <CONSTANT SOG>
ZG.const._declare('SOG', lambda: 16)

# zil: gparser.zil:1036  <CONSTANT STAKE>
ZG.const._declare('STAKE', lambda: 8)

# zil: gparser.zil:1037  <CONSTANT SMANY>
ZG.const._declare('SMANY', lambda: 4)

# zil: gparser.zil:1038  <CONSTANT SHAVE>
ZG.const._declare('SHAVE', lambda: 2)

# zil: gparser.zil:1142  <GLOBAL P-XNAM>
ZG.scratch._declare('P_XNAM', lambda: False)

# zil: gparser.zil:1143  <GLOBAL P-XADJ>
ZG.scratch._declare('P_XADJ', lambda: False)

# zil: gparser.zil:1144  <GLOBAL P-XADJN>
ZG.scratch._declare('P_XADJN', lambda: False)

# zil: gparser.zil:1212  <CONSTANT P-SRCBOT>
ZG.const._declare('P_SRCBOT', lambda: 2)

# zil: gparser.zil:1213  <CONSTANT P-SRCTOP>
ZG.const._declare('P_SRCTOP', lambda: 0)

# zil: gparser.zil:1214  <CONSTANT P-SRCALL>
ZG.const._declare('P_SRCALL', lambda: 1)

# zil: gparser.zil:1331  <GLOBAL ALWAYS-LIT>
ZG.scratch._declare('ALWAYS_LIT', lambda: False)

# ------------------------------------------------------------
# gverbs
# ------------------------------------------------------------

# zil: gverbs.zil:9  <GLOBAL VERBOSE>
ZG.state._declare('VERBOSE', lambda: False)

# zil: gverbs.zil:10  <GLOBAL SUPER-BRIEF>
ZG.state._declare('SUPER_BRIEF', lambda: False)

# zil: gverbs.zil:722  <GLOBAL HS>
ZG.state._declare('HS', lambda: 0)

# zil: gverbs.zil:844  <GLOBAL JUMPLOSS>
ZG.state._declare('JUMPLOSS', lambda: LTABLE(0, 'You should have looked before you leaped.', 'In the movies, your life would be passing before your eyes.', 'Geronimo...'))

# zil: gverbs.zil:1272  <GLOBAL WHEEEEE>
ZG.state._declare('WHEEEEE', lambda: LTABLE(0, 'Very good. Now you can go to the second grade.', 'Are you enjoying yourself?', 'Wheeeeeeeeee!!!!!', 'Do you expect me to applaud?'))

# zil: gverbs.zil:1626  <GLOBAL LIT>
ZG.state._declare('LIT', lambda: False)

# zil: gverbs.zil:1628  <GLOBAL SPRAYED?>
ZG.state._declare('SPRAYED_p', lambda: False)

# zil: gverbs.zil:1691  <GLOBAL DESC-OBJECT>
ZG.state._declare('DESC_OBJECT', lambda: False)

# zil: gverbs.zil:1843  <GLOBAL MOVES>
ZG.state._declare('MOVES', lambda: 0)

# zil: gverbs.zil:1845  <GLOBAL SCORE>
ZG.state._declare('SCORE', lambda: 0)

# zil: gverbs.zil:1847  <GLOBAL BASE-SCORE>
ZG.state._declare('BASE_SCORE', lambda: 0)

# zil: gverbs.zil:1849  <GLOBAL WON-FLAG>
ZG.state._declare('WON_FLAG', lambda: False)

# zil: gverbs.zil:1882  <GLOBAL DEAD>
ZG.state._declare('DEAD', lambda: False)

# zil: gverbs.zil:1884  <GLOBAL DEATHS>
ZG.state._declare('DEATHS', lambda: 0)

# zil: gverbs.zil:1886  <GLOBAL LUCKY>
ZG.state._declare('LUCKY', lambda: 1)

# zil: gverbs.zil:1896  <GLOBAL FUMBLE-NUMBER>
ZG.state._declare('FUMBLE_NUMBER', lambda: 7)

# zil: gverbs.zil:1898  <GLOBAL FUMBLE-PROB>
ZG.state._declare('FUMBLE_PROB', lambda: 8)

# zil: gverbs.zil:2001  <CONSTANT REXIT>
ZG.const._declare('REXIT', lambda: 0)

# zil: gverbs.zil:2002  <CONSTANT UEXIT>
ZG.const._declare('UEXIT', lambda: 1)

# zil: gverbs.zil:2003  <CONSTANT NEXIT>
ZG.const._declare('NEXIT', lambda: 2)

# zil: gverbs.zil:2004  <CONSTANT FEXIT>
ZG.const._declare('FEXIT', lambda: 3)

# zil: gverbs.zil:2005  <CONSTANT CEXIT>
ZG.const._declare('CEXIT', lambda: 4)

# zil: gverbs.zil:2006  <CONSTANT DEXIT>
ZG.const._declare('DEXIT', lambda: 5)

# zil: gverbs.zil:2008  <CONSTANT NEXITSTR>
ZG.const._declare('NEXITSTR', lambda: 0)

# zil: gverbs.zil:2009  <CONSTANT FEXITFCN>
ZG.const._declare('FEXITFCN', lambda: 0)

# zil: gverbs.zil:2010  <CONSTANT CEXITFLAG>
ZG.const._declare('CEXITFLAG', lambda: 1)

# zil: gverbs.zil:2011  <CONSTANT CEXITSTR>
ZG.const._declare('CEXITSTR', lambda: 1)

# zil: gverbs.zil:2012  <CONSTANT DEXITOBJ>
ZG.const._declare('DEXITOBJ', lambda: 1)

# zil: gverbs.zil:2013  <CONSTANT DEXITSTR>
ZG.const._declare('DEXITSTR', lambda: 1)

# zil: gverbs.zil:2015  <GLOBAL INDENTS>
ZG.state._declare('INDENTS', lambda: TABLE(('PURE',), '', '  ', '    ', '      ', '        ', '          '))

# zil: gverbs.zil:2031  <GLOBAL HO-HUM>
ZG.state._declare('HO_HUM', lambda: LTABLE(0, " doesn't seem to work.", " isn't notably helpful.", ' has no effect.'))

# zil: gverbs.zil:2195  <GLOBAL SWIMYUKS>
ZG.state._declare('SWIMYUKS', lambda: LTABLE(0, "You can't swim in the dungeon."))

# zil: gverbs.zil:2198  <GLOBAL HELLOS>
ZG.state._declare('HELLOS', lambda: LTABLE(0, 'Hello.', 'Good day.', "Nice weather we've been having lately.", 'Goodbye.'))

# zil: gverbs.zil:2204  <GLOBAL YUKS>
ZG.state._declare('YUKS', lambda: LTABLE(0, 'A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!'))

# zil: gverbs.zil:2213  <GLOBAL DUMMY>
ZG.state._declare('DUMMY', lambda: LTABLE(0, 'Look around.', 'Too late for that.', 'Have your eyes checked.'))

# ------------------------------------------------------------
# _1actions
# ------------------------------------------------------------

# zil: 1actions.zil:239  <GLOBAL KITCHEN-WINDOW-FLAG>
ZG.state._declare('KITCHEN_WINDOW_FLAG', lambda: False)

# zil: 1actions.zil:275  <GLOBAL CAGE-TOP>
ZG.state._declare('CAGE_TOP', lambda: True)

# zil: 1actions.zil:332  <GLOBAL BAT-DROPS>
ZG.state._declare('BAT_DROPS', lambda: LTABLE(0, ZG.MINE_1, ZG.MINE_2, ZG.MINE_3, ZG.MINE_4, ZG.LADDER_TOP, ZG.LADDER_BOTTOM, ZG.SQUEEKY_ROOM, ZG.MINE_ENTRANCE))

# zil: 1actions.zil:447  <GLOBAL RUG-MOVED>
ZG.state._declare('RUG_MOVED', lambda: False)

# zil: 1actions.zil:771  <GLOBAL GRATE-REVEALED>
ZG.state._declare('GRATE_REVEALED', lambda: False)

# zil: 1actions.zil:772  <GLOBAL GRUNLOCK>
ZG.state._declare('GRUNLOCK', lambda: False)

# zil: 1actions.zil:968  <GLOBAL MIRROR-MUNG>
ZG.state._declare('MIRROR_MUNG', lambda: False)

# 注意: LUCKY は gverbs で別の値で宣言済み (後の宣言が使われる。前の値: 1)
# zil: 1actions.zil:969  <GLOBAL LUCKY>
ZG.state._declare('LUCKY', lambda: True)

# zil: 1actions.zil:1127  <GLOBAL XB>
ZG.state._declare('XB', lambda: False)

# zil: 1actions.zil:1129  <GLOBAL XC>
ZG.state._declare('XC', lambda: False)

# zil: 1actions.zil:1153  <GLOBAL GATE-FLAG>
ZG.state._declare('GATE_FLAG', lambda: False)

# zil: 1actions.zil:1154  <GLOBAL GATES-OPEN>
ZG.state._declare('GATES_OPEN', lambda: False)

# zil: 1actions.zil:1261  <GLOBAL LOUD-RUNS>
ZG.state._declare('LOUD_RUNS', lambda: LTABLE(0, ZG.DAMP_CAVE, ZG.ROUND_ROOM, ZG.DEEP_CANYON))

# zil: 1actions.zil:1284  <GLOBAL DROWNINGS>
ZG.state._declare('DROWNINGS', lambda: TABLE(('PURE',), 'up to your ankles.', 'up to your shin.', 'up to your knees.', 'up to your hips.', 'up to your waist.', 'up to your chest.', 'up to your neck.', 'over your head.', 'high in your lungs.'))

# zil: 1actions.zil:1295  <GLOBAL WATER-LEVEL>
ZG.state._declare('WATER_LEVEL', lambda: 0)

# zil: 1actions.zil:1513  <GLOBAL CYCLOWRATH>
ZG.state._declare('CYCLOWRATH', lambda: 0)

# zil: 1actions.zil:1644  <GLOBAL CYCLOMAD>
ZG.state._declare('CYCLOMAD', lambda: TABLE(('PURE',), 'The cyclops seems somewhat agitated.', 'The cyclops appears to be getting more agitated.', 'The cyclops is moving about the room, looking for something.', 'The cyclops was looking for salt and pepper. No doubt they are\ncondiments for his upcoming snack.', 'The cyclops is moving toward you in an unfriendly manner.', 'You have two choices: 1. Leave  2. Become dinner.'))

# zil: 1actions.zil:1658  <GLOBAL LOUD-FLAG>
ZG.state._declare('LOUD_FLAG', lambda: False)

# zil: 1actions.zil:1748  <GLOBAL EGG-SOLVE>
ZG.state._declare('EGG_SOLVE', lambda: False)

# zil: 1actions.zil:1754  <GLOBAL THIEF-HERE>
ZG.state._declare('THIEF_HERE', lambda: False)

# zil: 1actions.zil:1945  <GLOBAL THIEF-ENGROSSED>
ZG.state._declare('THIEF_ENGROSSED', lambda: False)

# zil: 1actions.zil:2086  <GLOBAL ROBBER-C-DESC>
ZG.state._declare('ROBBER_C_DESC', lambda: 'There is a suspicious-looking individual, holding a bag, leaning\nagainst one wall. He is armed with a vicious-looking stiletto.')

# zil: 1actions.zil:2090  <GLOBAL ROBBER-U-DESC>
ZG.state._declare('ROBBER_U_DESC', lambda: 'There is a suspicious-looking individual lying unconscious on the\nground.')

# zil: 1actions.zil:2220  <GLOBAL LAMP-TABLE>
ZG.state._declare('LAMP_TABLE', lambda: TABLE(('PURE',), 100, 'The lamp appears a bit dimmer.', 70, 'The lamp is definitely dimmer now.', 15, 'The lamp is nearly out.', 0))

# zil: 1actions.zil:2263  <GLOBAL MATCH-COUNT>
ZG.state._declare('MATCH_COUNT', lambda: 6)

# zil: 1actions.zil:2406  <GLOBAL CANDLE-TABLE>
ZG.state._declare('CANDLE_TABLE', lambda: TABLE(('PURE',), 20, 'The candles grow shorter.', 10, 'The candles are becoming quite short.', 5, "The candles won't last long now.", 0))

# zil: 1actions.zil:2578  <GLOBAL LIGHT-SHAFT>
ZG.state._declare('LIGHT_SHAFT', lambda: 13)

# zil: 1actions.zil:2692  <GLOBAL RIVER-SPEEDS>
ZG.state._declare('RIVER_SPEEDS', lambda: LTABLE(('PURE',), ZG.RIVER_1, 4, ZG.RIVER_2, 4, ZG.RIVER_3, 3, ZG.RIVER_4, 2, ZG.RIVER_5, 1))

# zil: 1actions.zil:2695  <GLOBAL RIVER-NEXT>
ZG.state._declare('RIVER_NEXT', lambda: LTABLE(('PURE',), ZG.RIVER_1, ZG.RIVER_2, ZG.RIVER_3, ZG.RIVER_4, ZG.RIVER_5))

# zil: 1actions.zil:2698  <GLOBAL RIVER-LAUNCH>
ZG.state._declare('RIVER_LAUNCH', lambda: LTABLE(('PURE',), ZG.DAM_BASE, ZG.RIVER_1, ZG.WHITE_CLIFFS_NORTH, ZG.RIVER_3, ZG.WHITE_CLIFFS_SOUTH, ZG.RIVER_4, ZG.SHORE, ZG.RIVER_5, ZG.SANDY_BEACH, ZG.RIVER_4, ZG.RESERVOIR_SOUTH, ZG.RESERVOIR, ZG.RESERVOIR_NORTH, ZG.RESERVOIR, ZG.STREAM_VIEW, ZG.IN_STREAM))

# zil: 1actions.zil:2842  <GLOBAL BUOY-FLAG>
ZG.state._declare('BUOY_FLAG', lambda: True)

# zil: 1actions.zil:2851  <GLOBAL BEACH-DIG>
ZG.state._declare('BEACH_DIG', lambda: -1)

# zil: 1actions.zil:2871  <GLOBAL BDIGS>
ZG.state._declare('BDIGS', lambda: TABLE(('PURE',), 'You seem to be digging a hole here.', "The hole is getting deeper, but that's about it.", 'You are surrounded by a wall of sand on all sides.'))

# zil: 1actions.zil:2968  <GLOBAL SING-SONG>
ZG.state._declare('SING_SONG', lambda: False)

# zil: 1actions.zil:3236  <CONSTANT F-BUSY?>
ZG.const._declare('F_BUSY_p', lambda: 1)

# zil: 1actions.zil:3237  <CONSTANT F-DEAD>
ZG.const._declare('F_DEAD', lambda: 2)

# zil: 1actions.zil:3238  <CONSTANT F-UNCONSCIOUS>
ZG.const._declare('F_UNCONSCIOUS', lambda: 3)

# zil: 1actions.zil:3239  <CONSTANT F-CONSCIOUS>
ZG.const._declare('F_CONSCIOUS', lambda: 4)

# zil: 1actions.zil:3240  <CONSTANT F-FIRST?>
ZG.const._declare('F_FIRST_p', lambda: 5)

# zil: 1actions.zil:3246  <CONSTANT MISSED>
ZG.const._declare('MISSED', lambda: 1)

# zil: 1actions.zil:3247  <CONSTANT UNCONSCIOUS>
ZG.const._declare('UNCONSCIOUS', lambda: 2)

# zil: 1actions.zil:3248  <CONSTANT KILLED>
ZG.const._declare('KILLED', lambda: 3)

# zil: 1actions.zil:3249  <CONSTANT LIGHT-WOUND>
ZG.const._declare('LIGHT_WOUND', lambda: 4)

# zil: 1actions.zil:3250  <CONSTANT SERIOUS-WOUND>
ZG.const._declare('SERIOUS_WOUND', lambda: 5)

# zil: 1actions.zil:3251  <CONSTANT STAGGER>
ZG.const._declare('STAGGER', lambda: 6)

# zil: 1actions.zil:3252  <CONSTANT LOSE-WEAPON>
ZG.const._declare('LOSE_WEAPON', lambda: 7)

# zil: 1actions.zil:3253  <CONSTANT HESITATE>
ZG.const._declare('HESITATE', lambda: 8)

# zil: 1actions.zil:3254  <CONSTANT SITTING-DUCK>
ZG.const._declare('SITTING_DUCK', lambda: 9)

# zil: 1actions.zil:3258  <GLOBAL DEF1>
ZG.state._declare('DEF1', lambda: TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.UNCONSCIOUS, ZG.UNCONSCIOUS, ZG.KILLED, ZG.KILLED, ZG.KILLED, ZG.KILLED, ZG.KILLED))

# zil: 1actions.zil:3265  <GLOBAL DEF2A>
ZG.state._declare('DEF2A', lambda: TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.UNCONSCIOUS))

# zil: 1actions.zil:3272  <GLOBAL DEF2B>
ZG.state._declare('DEF2B', lambda: TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.UNCONSCIOUS, ZG.KILLED, ZG.KILLED, ZG.KILLED))

# zil: 1actions.zil:3280  <GLOBAL DEF3A>
ZG.state._declare('DEF3A', lambda: TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND))

# zil: 1actions.zil:3287  <GLOBAL DEF3B>
ZG.state._declare('DEF3B', lambda: TABLE(('PURE',), ZG.MISSED, ZG.MISSED, ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND))

# zil: 1actions.zil:3294  <GLOBAL DEF3C>
ZG.state._declare('DEF3C', lambda: TABLE(('PURE',), ZG.MISSED, ZG.STAGGER, ZG.STAGGER, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.LIGHT_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND, ZG.SERIOUS_WOUND))

# zil: 1actions.zil:3301  <GLOBAL DEF1-RES>
ZG.state._declare('DEF1_RES', lambda: TABLE(ZG.DEF1, 0, 0))

# zil: 1actions.zil:3306  <GLOBAL DEF2-RES>
ZG.state._declare('DEF2_RES', lambda: TABLE(ZG.DEF2A, ZG.DEF2B, 0, 0))

# zil: 1actions.zil:3312  <GLOBAL DEF3-RES>
ZG.state._declare('DEF3_RES', lambda: TABLE(ZG.DEF3A, 0, ZG.DEF3B, 0, ZG.DEF3C))

# zil: 1actions.zil:3323  <CONSTANT STRENGTH-MAX>
ZG.const._declare('STRENGTH_MAX', lambda: 7)

# zil: 1actions.zil:3324  <CONSTANT STRENGTH-MIN>
ZG.const._declare('STRENGTH_MIN', lambda: 2)

# zil: 1actions.zil:3325  <CONSTANT CURE-WAIT>
ZG.const._declare('CURE_WAIT', lambda: 30)

# zil: 1actions.zil:3608  <CONSTANT F-WEP>
ZG.const._declare('F_WEP', lambda: 0)

# zil: 1actions.zil:3609  <CONSTANT F-DEF>
ZG.const._declare('F_DEF', lambda: 1)

# zil: 1actions.zil:3611  <GLOBAL HERO-MELEE>
ZG.state._declare('HERO_MELEE', lambda: TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'Your ', ZG.F_WEP, ' misses the ', ZG.F_DEF, ' by an inch.'), LTABLE(('PURE',), 'A good slash, but it misses the ', ZG.F_DEF, ' by a mile.'), LTABLE(('PURE',), 'You charge, but the ', ZG.F_DEF, ' jumps nimbly aside.'), LTABLE(('PURE',), 'Clang! Crash! The ', ZG.F_DEF, ' parries.'), LTABLE(('PURE',), 'A quick stroke, but the ', ZG.F_DEF, ' is on guard.'), LTABLE(('PURE',), "A good stroke, but it's too slow; the ", ZG.F_DEF, ' dodges.')), LTABLE(('PURE',), LTABLE(('PURE',), 'Your ', ZG.F_WEP, ' crashes down, knocking the ', ZG.F_DEF, ' into dreamland.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is battered into unconsciousness.'), LTABLE(('PURE',), 'A furious exchange, and the ', ZG.F_DEF, ' is knocked out!'), LTABLE(('PURE',), 'The haft of your ', ZG.F_WEP, ' knocks out the ', ZG.F_DEF, '.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is knocked out!')), LTABLE(('PURE',), LTABLE(('PURE',), "It's curtains for the ", ZG.F_DEF, ' as your ', ZG.F_WEP, ' removes his head.'), LTABLE(('PURE',), 'The fatal blow strikes the ', ZG.F_DEF, ' square in the heart: He dies.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' takes a fatal blow and slumps to the floor dead.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is struck on the arm; blood begins to trickle down.'), LTABLE(('PURE',), 'Your ', ZG.F_WEP, ' pinks the ', ZG.F_DEF, " on the wrist, but it's not serious."), LTABLE(('PURE',), 'Your stroke lands, but it was only the flat of the blade.'), LTABLE(('PURE',), 'The blow lands, making a shallow gash in the ', ZG.F_DEF, "'s arm!")), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' receives a deep gash in his side.'), LTABLE(('PURE',), 'A savage blow on the thigh! The ', ZG.F_DEF, ' is stunned but can still fight!'), LTABLE(('PURE',), 'Slash! Your blow lands! That one hit an artery, it could be serious!'), LTABLE(('PURE',), 'Slash! Your stroke connects! This could be serious!')), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is staggered, and drops to his knees.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, " is momentarily disoriented and can't fight back."), LTABLE(('PURE',), 'The force of your blow knocks the ', ZG.F_DEF, ' back, stunned.'), LTABLE(('PURE',), 'The ', ZG.F_DEF, " is confused and can't fight back."), LTABLE(('PURE',), 'The quickness of your thrust knocks the ', ZG.F_DEF, ' back, stunned.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The ', ZG.F_DEF, "'s weapon is knocked to the floor, leaving him unarmed."), LTABLE(('PURE',), 'The ', ZG.F_DEF, ' is disarmed by a subtle feint past his guard.'))))

# zil: 1actions.zil:3654  <GLOBAL CYCLOPS-MELEE>
ZG.state._declare('CYCLOPS_MELEE', lambda: TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops misses, but the backwash almost knocks you over.'), LTABLE(('PURE',), 'The Cyclops rushes you, but runs into the wall.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops sends you crashing to the floor, unconscious.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops breaks your neck with a massive smash.')), LTABLE(('PURE',), LTABLE(('PURE',), 'A quick punch, but it was only a glancing blow.'), LTABLE(('PURE',), "A glancing blow from the Cyclops' fist.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The monster smashes his huge fist into your chest, breaking several\nribs.'), LTABLE(('PURE',), 'The Cyclops almost knocks the wind out of you with a quick punch.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops lands a punch that knocks the wind out of you.'), LTABLE(('PURE',), 'Heedless of your weapons, the Cyclops tosses you against the rock\nwall of the room.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops grabs your ', ZG.F_WEP, ', tastes it, and throws it to the\nground in disgust.'), LTABLE(('PURE',), 'The monster grabs you on the wrist, squeezes, and you drop your\n', ZG.F_WEP, ' in pain.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops seems unable to decide whether to broil or stew his\ndinner.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The Cyclops, no sportsman, dispatches his unconscious victim.'))))

# zil: 1actions.zil:3689  <GLOBAL TROLL-MELEE>
ZG.state._declare('TROLL_MELEE', lambda: TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll swings his axe, but it misses.'), LTABLE(('PURE',), "The troll's axe barely misses your ear."), LTABLE(('PURE',), 'The axe sweeps past as you jump aside.'), LTABLE(('PURE',), 'The axe crashes against the rock, throwing sparks!')), LTABLE(('PURE',), LTABLE(('PURE',), "The flat of the troll's axe hits you delicately on the head, knocking\nyou out.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll neatly removes your head.'), LTABLE(('PURE',), "The troll's axe stroke cleaves you from the nave to the chops."), LTABLE(('PURE',), "The troll's axe removes your head.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The axe gets you right in the side. Ouch!'), LTABLE(('PURE',), "The flat of the troll's axe skins across your forearm."), LTABLE(('PURE',), "The troll's swing almost knocks you over as you barely parry\nin time."), LTABLE(('PURE',), 'The troll swings his axe, and it nicks your arm as you dodge.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll charges, and his axe slashes you on your ', ZG.F_WEP, ' arm.'), LTABLE(('PURE',), 'An axe stroke makes a deep wound in your leg.'), LTABLE(('PURE',), "The troll's axe swings down, gashing your shoulder.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll hits you with a glancing blow, and you are momentarily\nstunned.'), LTABLE(('PURE',), 'The troll swings; the blade turns on your armor but crashes\nbroadside into your head.'), LTABLE(('PURE',), 'You stagger back under a hail of axe strokes.'), LTABLE(('PURE',), "The troll's mighty blow drops you to your knees.")), LTABLE(('PURE',), LTABLE(('PURE',), 'The axe hits your ', ZG.F_WEP, ' and knocks it spinning.'), LTABLE(('PURE',), 'The troll swings, you parry, but the force of his blow knocks your ', ZG.F_WEP, ' away.'), LTABLE(('PURE',), 'The axe knocks your ', ZG.F_WEP, ' out of your hand. It falls to the floor.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The troll hesitates, fingering his axe.'), LTABLE(('PURE',), 'The troll scratches his head ruminatively:  Might you be magically\nprotected, he wonders?')), LTABLE(('PURE',), LTABLE(('PURE',), 'Conquering his fears, the troll puts you to death.'))))

# zil: 1actions.zil:3735  <GLOBAL THIEF-MELEE>
ZG.state._declare('THIEF_MELEE', lambda: TABLE(('PURE',), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief stabs nonchalantly with his stiletto and misses.'), LTABLE(('PURE',), 'You dodge as the thief comes in low.'), LTABLE(('PURE',), 'You parry a lightning thrust, and the thief salutes you with\na grim nod.'), LTABLE(('PURE',), 'The thief tries to sneak past your guard, but you twist away.')), LTABLE(('PURE',), LTABLE(('PURE',), 'Shifting in the midst of a thrust, the thief knocks you unconscious\nwith the haft of his stiletto.'), LTABLE(('PURE',), 'The thief knocks you out.')), LTABLE(('PURE',), LTABLE(('PURE',), 'Finishing you off, the thief inserts his blade into your heart.'), LTABLE(('PURE',), 'The thief comes in from the side, feints, and inserts the blade\ninto your ribs.'), LTABLE(('PURE',), 'The thief bows formally, raises his stiletto, and with a wry grin,\nends the battle and your life.')), LTABLE(('PURE',), LTABLE(('PURE',), 'A quick thrust pinks your left arm, and blood starts to\ntrickle down.'), LTABLE(('PURE',), 'The thief draws blood, raking his stiletto across your arm.'), LTABLE(('PURE',), 'The stiletto flashes faster than you can follow, and blood wells\nfrom your leg.'), LTABLE(('PURE',), 'The thief slowly approaches, strikes like a snake, and leaves\nyou wounded.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief strikes like a snake! The resulting wound is serious.'), LTABLE(('PURE',), 'The thief stabs a deep cut in your upper arm.'), LTABLE(('PURE',), 'The stiletto touches your forehead, and the blood obscures your\nvision.'), LTABLE(('PURE',), 'The thief strikes at your wrist, and suddenly your grip is slippery\nwith blood.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The butt of his stiletto cracks you on the skull, and you stagger\nback.'), LTABLE(('PURE',), 'The thief rams the haft of his blade into your stomach, leaving\nyou out of breath.'), LTABLE(('PURE',), 'The thief attacks, and you fall back desperately.')), LTABLE(('PURE',), LTABLE(('PURE',), 'A long, theatrical slash. You catch it on your ', ZG.F_WEP, ', but the\nthief twists his knife, and the ', ZG.F_WEP, ' goes flying.'), LTABLE(('PURE',), 'The thief neatly flips your ', ZG.F_WEP, ' out of your hands, and it drops\nto the floor.'), LTABLE(('PURE',), 'You parry a low thrust, and your ', ZG.F_WEP, ' slips out of your hand.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief, a man of superior breeding, pauses for a moment to consider the propriety of finishing you off.'), LTABLE(('PURE',), 'The thief amuses himself by searching your pockets.'), LTABLE(('PURE',), 'The thief entertains himself by rifling your pack.')), LTABLE(('PURE',), LTABLE(('PURE',), 'The thief, forgetting his essentially genteel upbringing, cuts your\nthroat.'), LTABLE(('PURE',), 'The thief, a pragmatist, dispatches you as a threat to his\nlivelihood.'))))

# zil: 1actions.zil:3793  <CONSTANT V-VILLAIN>
ZG.const._declare('V_VILLAIN', lambda: 0)

# zil: 1actions.zil:3794  <CONSTANT V-BEST>
ZG.const._declare('V_BEST', lambda: 1)

# zil: 1actions.zil:3795  <CONSTANT V-BEST-ADV>
ZG.const._declare('V_BEST_ADV', lambda: 2)

# zil: 1actions.zil:3796  <CONSTANT V-PROB>
ZG.const._declare('V_PROB', lambda: 3)

# zil: 1actions.zil:3797  <CONSTANT V-MSGS>
ZG.const._declare('V_MSGS', lambda: 4)

# zil: 1actions.zil:3801  <GLOBAL VILLAINS>
ZG.state._declare('VILLAINS', lambda: LTABLE(TABLE(ZG.TROLL, ZG.SWORD, 1, 0, ZG.TROLL_MELEE), TABLE(ZG.THIEF, ZG.KNIFE, 1, 0, ZG.THIEF_MELEE), TABLE(ZG.CYCLOPS, False, 0, 0, ZG.CYCLOPS_MELEE)))
