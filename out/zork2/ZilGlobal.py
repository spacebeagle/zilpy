"""ZIL のグローバル変数・定数の宣言 (自動生成)。

全 ZIL ファイルの GLOBAL / CONSTANT をここに集める。元のファイルには
コメントとして残してある。値は最初に参照された時に評価する。
"""

from ZilRuntime import *

# ------------------------------------------------------------
# zork2
# ------------------------------------------------------------

ZG.const._declare('ZORK_NUMBER', lambda: 2)

# ------------------------------------------------------------
# gmacros
# ------------------------------------------------------------

ZG.const._declare('C_ENABLED_p', lambda: 0)

ZG.const._declare('C_ENABLED', lambda: 1)

ZG.const._declare('C_DISABLED', lambda: 0)

# ------------------------------------------------------------
# _2dungeon
# ------------------------------------------------------------

# zil: 2dungeon.zil:35  <GLOBAL SECRET-DOOR>
ZG.state._declare('SECRET_DOOR', lambda: False)

# zil: 2dungeon.zil:36  <GLOBAL GNOME-DOOR-FLAG>
ZG.state._declare('GNOME_DOOR_FLAG', lambda: False)

# zil: 2dungeon.zil:1414  <GLOBAL BLOC>
ZG.state._declare('BLOC', lambda: ZG.VOLCANO_BOTTOM)

# ------------------------------------------------------------
# gglobals
# ------------------------------------------------------------

# zil: gglobals.zil:125  <GLOBAL LOAD-MAX>
ZG.state._declare('LOAD_MAX', lambda: 100)

# zil: gglobals.zil:127  <GLOBAL LOAD-ALLOWED>
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

# zil: gparser.zil:902  <GLOBAL P-GWIMBIT>
ZG.scratch._declare('P_GWIMBIT', lambda: 0)

# zil: gparser.zil:963  <GLOBAL P-NAM>
ZG.scratch._declare('P_NAM', lambda: False)

# zil: gparser.zil:964  <GLOBAL P-ADJ>
ZG.scratch._declare('P_ADJ', lambda: False)

# zil: gparser.zil:965  <GLOBAL P-ADVERB>
ZG.scratch._declare('P_ADVERB', lambda: False)

# zil: gparser.zil:966  <GLOBAL P-ADJN>
ZG.scratch._declare('P_ADJN', lambda: False)

# zil: gparser.zil:967  <GLOBAL P-PRSO>
ZG.scratch._declare('P_PRSO', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:968  <GLOBAL P-PRSI>
ZG.scratch._declare('P_PRSI', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:969  <GLOBAL P-BUTS>
ZG.scratch._declare('P_BUTS', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:970  <GLOBAL P-MERGE>
ZG.scratch._declare('P_MERGE', lambda: ITABLE('NONE', 50))

# zil: gparser.zil:971  <GLOBAL P-OCLAUSE>
ZG.scratch._declare('P_OCLAUSE', lambda: ITABLE('NONE', 100))

# zil: gparser.zil:972  <GLOBAL P-MATCHLEN>
ZG.scratch._declare('P_MATCHLEN', lambda: 0)

# zil: gparser.zil:973  <GLOBAL P-GETFLAGS>
ZG.scratch._declare('P_GETFLAGS', lambda: 0)

# zil: gparser.zil:974  <CONSTANT P-ALL>
ZG.const._declare('P_ALL', lambda: 1)

# zil: gparser.zil:975  <CONSTANT P-ONE>
ZG.const._declare('P_ONE', lambda: 2)

# zil: gparser.zil:976  <CONSTANT P-INHIBIT>
ZG.const._declare('P_INHIBIT', lambda: 4)

# zil: gparser.zil:979  <GLOBAL P-AND>
ZG.scratch._declare('P_AND', lambda: False)

# zil: gparser.zil:1035  <CONSTANT SH>
ZG.const._declare('SH', lambda: 128)

# zil: gparser.zil:1036  <CONSTANT SC>
ZG.const._declare('SC', lambda: 64)

# zil: gparser.zil:1037  <CONSTANT SIR>
ZG.const._declare('SIR', lambda: 32)

# zil: gparser.zil:1038  <CONSTANT SOG>
ZG.const._declare('SOG', lambda: 16)

# zil: gparser.zil:1039  <CONSTANT STAKE>
ZG.const._declare('STAKE', lambda: 8)

# zil: gparser.zil:1040  <CONSTANT SMANY>
ZG.const._declare('SMANY', lambda: 4)

# zil: gparser.zil:1041  <CONSTANT SHAVE>
ZG.const._declare('SHAVE', lambda: 2)

# zil: gparser.zil:1167  <GLOBAL P-XNAM>
ZG.scratch._declare('P_XNAM', lambda: False)

# zil: gparser.zil:1168  <GLOBAL P-XADJ>
ZG.scratch._declare('P_XADJ', lambda: False)

# zil: gparser.zil:1169  <GLOBAL P-XADJN>
ZG.scratch._declare('P_XADJN', lambda: False)

# zil: gparser.zil:1237  <CONSTANT P-SRCBOT>
ZG.const._declare('P_SRCBOT', lambda: 2)

# zil: gparser.zil:1238  <CONSTANT P-SRCTOP>
ZG.const._declare('P_SRCTOP', lambda: 0)

# zil: gparser.zil:1239  <CONSTANT P-SRCALL>
ZG.const._declare('P_SRCALL', lambda: 1)

# zil: gparser.zil:1356  <GLOBAL ALWAYS-LIT>
ZG.scratch._declare('ALWAYS_LIT', lambda: False)

# ------------------------------------------------------------
# gverbs
# ------------------------------------------------------------

# zil: gverbs.zil:9  <GLOBAL VERBOSE>
ZG.state._declare('VERBOSE', lambda: False)

# zil: gverbs.zil:10  <GLOBAL SUPER-BRIEF>
ZG.state._declare('SUPER_BRIEF', lambda: False)

# zil: gverbs.zil:755  <GLOBAL HS>
ZG.state._declare('HS', lambda: 0)

# zil: gverbs.zil:888  <GLOBAL JUMPLOSS>
ZG.state._declare('JUMPLOSS', lambda: LTABLE(0, 'You should have looked before you leaped.', 'In the movies, your life would be passing before your eyes.', 'Geronimo...'))

# zil: gverbs.zil:1316  <GLOBAL WHEEEEE>
ZG.state._declare('WHEEEEE', lambda: LTABLE(0, 'Very good. Now you can go to the second grade.', 'Are you enjoying yourself?', 'Wheeeeeeeeee!!!!!', 'Do you expect me to applaud?'))

# zil: gverbs.zil:1670  <GLOBAL LIT>
ZG.state._declare('LIT', lambda: False)

# zil: gverbs.zil:1672  <GLOBAL SPRAYED?>
ZG.state._declare('SPRAYED_p', lambda: False)

# zil: gverbs.zil:1735  <GLOBAL DESC-OBJECT>
ZG.state._declare('DESC_OBJECT', lambda: False)

# zil: gverbs.zil:1887  <GLOBAL MOVES>
ZG.state._declare('MOVES', lambda: 0)

# zil: gverbs.zil:1889  <GLOBAL SCORE>
ZG.state._declare('SCORE', lambda: 0)

# zil: gverbs.zil:1891  <GLOBAL BASE-SCORE>
ZG.state._declare('BASE_SCORE', lambda: 0)

# zil: gverbs.zil:1893  <GLOBAL WON-FLAG>
ZG.state._declare('WON_FLAG', lambda: False)

# zil: gverbs.zil:1926  <GLOBAL DEAD>
ZG.state._declare('DEAD', lambda: False)

# zil: gverbs.zil:1928  <GLOBAL DEATHS>
ZG.state._declare('DEATHS', lambda: 0)

# zil: gverbs.zil:1930  <GLOBAL LUCKY>
ZG.state._declare('LUCKY', lambda: 1)

# zil: gverbs.zil:1940  <GLOBAL FUMBLE-NUMBER>
ZG.state._declare('FUMBLE_NUMBER', lambda: 7)

# zil: gverbs.zil:1942  <GLOBAL FUMBLE-PROB>
ZG.state._declare('FUMBLE_PROB', lambda: 8)

# zil: gverbs.zil:2045  <CONSTANT REXIT>
ZG.const._declare('REXIT', lambda: 0)

# zil: gverbs.zil:2046  <CONSTANT UEXIT>
ZG.const._declare('UEXIT', lambda: 1)

# zil: gverbs.zil:2047  <CONSTANT NEXIT>
ZG.const._declare('NEXIT', lambda: 2)

# zil: gverbs.zil:2048  <CONSTANT FEXIT>
ZG.const._declare('FEXIT', lambda: 3)

# zil: gverbs.zil:2049  <CONSTANT CEXIT>
ZG.const._declare('CEXIT', lambda: 4)

# zil: gverbs.zil:2050  <CONSTANT DEXIT>
ZG.const._declare('DEXIT', lambda: 5)

# zil: gverbs.zil:2052  <CONSTANT NEXITSTR>
ZG.const._declare('NEXITSTR', lambda: 0)

# zil: gverbs.zil:2053  <CONSTANT FEXITFCN>
ZG.const._declare('FEXITFCN', lambda: 0)

# zil: gverbs.zil:2054  <CONSTANT CEXITFLAG>
ZG.const._declare('CEXITFLAG', lambda: 1)

# zil: gverbs.zil:2055  <CONSTANT CEXITSTR>
ZG.const._declare('CEXITSTR', lambda: 1)

# zil: gverbs.zil:2056  <CONSTANT DEXITOBJ>
ZG.const._declare('DEXITOBJ', lambda: 1)

# zil: gverbs.zil:2057  <CONSTANT DEXITSTR>
ZG.const._declare('DEXITSTR', lambda: 1)

# zil: gverbs.zil:2059  <GLOBAL INDENTS>
ZG.state._declare('INDENTS', lambda: TABLE(('PURE',), '', '  ', '    ', '      ', '        ', '          '))

# zil: gverbs.zil:2075  <GLOBAL HO-HUM>
ZG.state._declare('HO_HUM', lambda: LTABLE(0, " doesn't seem to work.", " isn't notably helpful.", ' has no effect.'))

# zil: gverbs.zil:2249  <GLOBAL SWIMYUKS>
ZG.state._declare('SWIMYUKS', lambda: LTABLE(0, "You can't swim in the dungeon."))

# zil: gverbs.zil:2252  <GLOBAL HELLOS>
ZG.state._declare('HELLOS', lambda: LTABLE(0, 'Hello.', 'Good day.', "Nice weather we've been having lately.", 'Goodbye.'))

# zil: gverbs.zil:2258  <GLOBAL YUKS>
ZG.state._declare('YUKS', lambda: LTABLE(0, 'A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!'))

# zil: gverbs.zil:2267  <GLOBAL DUMMY>
ZG.state._declare('DUMMY', lambda: LTABLE(0, 'Look around.', 'Too late for that.', 'Have your eyes checked.'))

# ------------------------------------------------------------
# _2actions
# ------------------------------------------------------------

# zil: 2actions.zil:13  <GLOBAL SWORD-GLOW>
ZG.state._declare('SWORD_GLOW', lambda: 0)

# zil: 2actions.zil:88  <GLOBAL EIGHT-DIRECTIONS>
ZG.state._declare('EIGHT_DIRECTIONS', lambda: TABLE('NORTH', 'EAST', 'SOUTH', 'NE', 'SE', 'SW', 'NW'))

# zil: 2actions.zil:91  <GLOBAL MUNGED-ROOM>
ZG.state._declare('MUNGED_ROOM', lambda: False)

# zil: 2actions.zil:112  <GLOBAL BTIE-FLAG>
ZG.state._declare('BTIE_FLAG', lambda: False)

# zil: 2actions.zil:113  <GLOBAL BINF-FLAG>
ZG.state._declare('BINF_FLAG', lambda: False)

# zil: 2actions.zil:114  <GLOBAL BLAB-FLAG>
ZG.state._declare('BLAB_FLAG', lambda: False)

# zil: 2actions.zil:115  <GLOBAL SAFE-FLAG>
ZG.state._declare('SAFE_FLAG', lambda: False)

# zil: 2actions.zil:253  <GLOBAL BALLOON-UPS>
ZG.state._declare('BALLOON_UPS', lambda: LTABLE(ZG.VAIR_1, ZG.VAIR_2, ZG.VAIR_3, ZG.VAIR_4))

# zil: 2actions.zil:256  <GLOBAL BALLOON-FLOATS>
ZG.state._declare('BALLOON_FLOATS', lambda: LTABLE(ZG.LEDGE_1, ZG.VAIR_2, ZG.LEDGE_2, ZG.VAIR_4))

# zil: 2actions.zil:259  <GLOBAL BALLOON-DOWNS>
ZG.state._declare('BALLOON_DOWNS', lambda: LTABLE(ZG.VAIR_4, ZG.VAIR_3, ZG.VAIR_2, ZG.VAIR_1))

# zil: 2actions.zil:412  <GLOBAL OTHER-PROPERTIES>
ZG.state._declare('OTHER_PROPERTIES', lambda: "Now you've done it. It seems that the brick has other properties\nthan weight, namely the ability to blow you to smithereens.")

# zil: 2actions.zil:532  <GLOBAL GNOME-FLAG>
ZG.state._declare('GNOME_FLAG', lambda: False)

# zil: 2actions.zil:653  <GLOBAL CRYPT-LIT?>
ZG.state._declare('CRYPT_LIT_p', lambda: True)

# zil: 2actions.zil:677  <GLOBAL DIM-DOOR-FLAG>
ZG.state._declare('DIM_DOOR_FLAG', lambda: False)

# zil: 2actions.zil:709  <GLOBAL SPRAY-USED?>
ZG.state._declare('SPRAY_USED_p', lambda: False)

# zil: 2actions.zil:750  <GLOBAL BUCKET-TOP-FLAG>
ZG.state._declare('BUCKET_TOP_FLAG', lambda: False)

# zil: 2actions.zil:752  <GLOBAL EVAPORATED>
ZG.state._declare('EVAPORATED', lambda: False)

# zil: 2actions.zil:1094  <GLOBAL FATAL-VAPORS>
ZG.state._declare('FATAL_VAPORS', lambda: "As you pass out, you realize that the vapors from the\nflask's contents are fatal.")

# zil: 2actions.zil:1137  <GLOBAL COMPASS-KLUDGE>
ZG.state._declare('COMPASS_KLUDGE', lambda: False)

# zil: 2actions.zil:1155  <GLOBAL CAROUSEL-ZOOM-FLAG>
ZG.state._declare('CAROUSEL_ZOOM_FLAG', lambda: False)

# zil: 2actions.zil:1157  <GLOBAL CAROUSEL-FLIP-FLAG>
ZG.state._declare('CAROUSEL_FLIP_FLAG', lambda: False)

# zil: 2actions.zil:1190  <GLOBAL CAGE-SOLVE-FLAG>
ZG.state._declare('CAGE_SOLVE_FLAG', lambda: False)

# zil: 2actions.zil:1312  <GLOBAL BANK-SOLVE-FLAG>
ZG.state._declare('BANK_SOLVE_FLAG', lambda: False)

# zil: 2actions.zil:1333  <GLOBAL SCOL-ROOMS>
ZG.state._declare('SCOL_ROOMS', lambda: LTABLE('EAST', ZG.VIEWING_EAST, 'WEST', ZG.VIEWING_WEST, 'NORTH', ZG.SMALL_ROOM, 'SOUTH', ZG.VAULT))

# zil: 2actions.zil:1343  <GLOBAL SCOL-WALLS>
ZG.state._declare('SCOL_WALLS', lambda: TABLE(ZG.VIEWING_WEST, ZG.SEWL, ZG.VIEWING_WEST, ZG.VIEWING_EAST, ZG.SWWL, ZG.VIEWING_EAST, ZG.SMALL_ROOM, ZG.SSWL, ZG.VAULT, ZG.VAULT, ZG.SNWL, ZG.SMALL_ROOM))

# zil: 2actions.zil:1357  <GLOBAL SCOL-ROOM>
ZG.state._declare('SCOL_ROOM', lambda: ZG.VIEWING_WEST)

# zil: 2actions.zil:1425  <GLOBAL SCOL-ACTIVE>
ZG.state._declare('SCOL_ACTIVE', lambda: False)

# zil: 2actions.zil:1443  <GLOBAL ZGNOME-FLAG>
ZG.state._declare('ZGNOME_FLAG', lambda: False)

# zil: 2actions.zil:1661  <GLOBAL MUD-FLAG>
ZG.state._declare('MUD_FLAG', lambda: False)

# zil: 2actions.zil:1663  <GLOBAL MATOBJ>
ZG.state._declare('MATOBJ', lambda: False)

# zil: 2actions.zil:1665  <GLOBAL PUNLOCK-FLAG>
ZG.state._declare('PUNLOCK_FLAG', lambda: False)

# zil: 2actions.zil:1667  <GLOBAL PLOOK-FLAG>
ZG.state._declare('PLOOK_FLAG', lambda: False)

# zil: 2actions.zil:1895  <GLOBAL MATCH-COUNT>
ZG.state._declare('MATCH_COUNT', lambda: 6)

# zil: 2actions.zil:1934  <GLOBAL LAMP-TABLE>
ZG.state._declare('LAMP_TABLE', lambda: TABLE(300, 'The lamp appears a bit dimmer.', 100, 'The lamp is definitely dimmer now.', 50, 'The lamp is nearly out.', 0))

# 注意: DUMMY は gverbs で別の値で宣言済み (後の宣言が使われる。前の値: LTABLE(0, 'Look around.', 'Too late for that.', 'Have your eyes checked.'))
# zil: 2actions.zil:2056  <GLOBAL DUMMY>
ZG.state._declare('DUMMY', lambda: LTABLE('Look around.', "You think it isn't?", "I think you've already done that."))

# zil: 2actions.zil:2174  <GLOBAL DIAMOND-SOLVE>
ZG.state._declare('DIAMOND_SOLVE', lambda: False)

# zil: 2actions.zil:2176  <GLOBAL DIAMOND-COUNT>
ZG.state._declare('DIAMOND_COUNT', lambda: 0)

# zil: 2actions.zil:2177  <GLOBAL DIAMOND-MOVES>
ZG.state._declare('DIAMOND_MOVES', lambda: 0)

# zil: 2actions.zil:2178  <GLOBAL DIAMOND-BASE>
ZG.state._declare('DIAMOND_BASE', lambda: 0)

# zil: 2actions.zil:2180  <GLOBAL DWDESCS>
ZG.state._declare('DWDESCS', lambda: TABLE('dark', 'flickering dimly', 'dimly glowing', 'glowing', 'glowing brightly'))

# zil: 2actions.zil:2284  <GLOBAL BASES>
ZG.state._declare('BASES', lambda: TABLE('first', 'first', 'first', 'second', 'third', 'home'))

# zil: 2actions.zil:2286  <GLOBAL DIAMOND-ROOMS>
ZG.state._declare('DIAMOND_ROOMS', lambda: TABLE(ZG.DIAMOND_2, ZG.DIAMOND_4, ZG.DIAMOND_6, ZG.DIAMOND_8, ZG.DIAMOND_1, ZG.DIAMOND_3, ZG.DIAMOND_5, ZG.DIAMOND_7, ZG.DIAMOND_9))

# zil: 2actions.zil:2290  <GLOBAL DIDIRS>
ZG.state._declare('DIDIRS', lambda: TABLE('SE', 'NE', 'NW', 'SW'))

# zil: 2actions.zil:2296  <GLOBAL CERBERUS-LEASHED>
ZG.state._declare('CERBERUS_LEASHED', lambda: False)

# zil: 2actions.zil:2370  <GLOBAL ICE-MELTED>
ZG.state._declare('ICE_MELTED', lambda: False)

# zil: 2actions.zil:2434  <GLOBAL DRAGON-ANGER>
ZG.state._declare('DRAGON_ANGER', lambda: 0)

# zil: 2actions.zil:2436  <GLOBAL DRAGON-ATTACKS>
ZG.state._declare('DRAGON_ATTACKS', lambda: LTABLE('Dragon hide is tough as steel, but you have succeeded in annoying him\na bit. He looks at you as if deciding whether or not to eat you.', 'That captured his interest. He stares at you balefully.', 'The dragon is surprised and interested (for the moment).', "You've made him rather angry. You had better be very careful now.", 'That did no damage, but he turns his smoky yellow eyes in your direction\nand sighs.'))

# zil: 2actions.zil:2469  <GLOBAL OLD-HERE>
ZG.state._declare('OLD_HERE', lambda: ZG.DRAGON_ROOM)

# zil: 2actions.zil:2610  <GLOBAL TOPIARY-MOVED>
ZG.state._declare('TOPIARY_MOVED', lambda: False)

# zil: 2actions.zil:2611  <GLOBAL TOPIARY-NEAR>
ZG.state._declare('TOPIARY_NEAR', lambda: False)

# zil: 2actions.zil:2613  <GLOBAL UNICORN-MSGS>
ZG.state._declare('UNICORN_MSGS', lambda: LTABLE('There is a large, white animal partly hidden behind some trees.', 'You catch a glimpse of something white between two hedges.', 'A unicorn is cropping grass on the other side of the room.\nA gold key hangs from a ribbon around its neck.', 'There is a beautiful unicorn eating roses here. Around his\nneck is a red satin ribbon on which is strung a tiny key.'))

# zil: 2actions.zil:2661  <GLOBAL UNICORN-FRIGHTENED>
ZG.state._declare('UNICORN_FRIGHTENED', lambda: False)

# zil: 2actions.zil:2697  <GLOBAL PRINCESS-AWAKE>
ZG.state._declare('PRINCESS_AWAKE', lambda: False)

# zil: 2actions.zil:2755  <GLOBAL PRCOUNT>
ZG.state._declare('PRCOUNT', lambda: 0)

# zil: 2actions.zil:2757  <GLOBAL PRFOLLOW>
ZG.state._declare('PRFOLLOW', lambda: False)

# zil: 2actions.zil:2759  <GLOBAL PRDIRS>
ZG.state._declare('PRDIRS', lambda: TABLE('south', ZG.DRAGON_ROOM, 'north', 'SOUTH', 'east', ZG.LEDGE_TUNNEL, 'west', 'EAST', 'east', ZG.RAVINE_LEDGE, 'west', 'EAST', 'down', ZG.DEEP_FORD, 'up', 'DOWN', 'south', ZG.MARBLE_HALL, 'north', 'SOUTH', 'east', ZG.STREAM_PATH, 'west', 'EAST', 'east', ZG.FORMAL_GARDEN, 'west', 'EAST', 'north', ZG.GARDEN_NORTH, 'south', 'NORTH', 'in', ZG.GAZEBO_ROOM, 'out', 'IN'))

# zil: 2actions.zil:2889  <GLOBAL MENHIR-POSITION>
ZG.state._declare('MENHIR_POSITION', lambda: False)

# zil: 2actions.zil:2922  <GLOBAL GUARDIAN-FED>
ZG.state._declare('GUARDIAN_FED', lambda: False)

# zil: 2actions.zil:2964  <GLOBAL WIZ-DOOR-FLAG>
ZG.state._declare('WIZ_DOOR_FLAG', lambda: False)

# zil: 2actions.zil:3350  <GLOBAL GENIE-READY?>
ZG.state._declare('GENIE_READY_p', lambda: False)

# zil: 2actions.zil:3351  <GLOBAL GENIE-HOARD>
ZG.state._declare('GENIE_HOARD', lambda: 0)

# zil: 2actions.zil:3352  <CONSTANT TREASURES-MAX>
ZG.const._declare('TREASURES_MAX', lambda: 10)

# zil: 2actions.zil:3355  <GLOBAL GENIE-THANKS>
ZG.state._declare('GENIE_THANKS', lambda: LTABLE("Most fine, master! But 'tis not enough. I will do a great service,\nand are not great services bought at great price?", 'Very nice, but not enough!', 'Ah, truly magnificent! Keep them coming.', 'Almost halfway there, oh worthy one!', 'Oh, such beauty! Your generosity almost overwhelms me!', 'Truly I shall do thee a wonderful service when thou hast finished!', 'Truly you are most generous! But still, this is yet not enough.', 'A fine gift, mighty one, you have almost reached my fee.', 'Wondrous fine, master! But one treasure is yet to be given!'))

# zil: 2actions.zil:3654  <GLOBAL SPELL?>
ZG.state._declare('SPELL_p', lambda: False)

# zil: 2actions.zil:3656  <CONSTANT SPELLS>
ZG.const._declare('SPELLS', lambda: 12)

# zil: 2actions.zil:3657  <CONSTANT S-FEEBLE>
ZG.const._declare('S_FEEBLE', lambda: 1)

# zil: 2actions.zil:3658  <CONSTANT S-FUMBLE>
ZG.const._declare('S_FUMBLE', lambda: 2)

# zil: 2actions.zil:3659  <CONSTANT S-FEAR>
ZG.const._declare('S_FEAR', lambda: 3)

# zil: 2actions.zil:3660  <CONSTANT S-FILCH>
ZG.const._declare('S_FILCH', lambda: 4)

# zil: 2actions.zil:3661  <CONSTANT S-FREEZE>
ZG.const._declare('S_FREEZE', lambda: 5)

# zil: 2actions.zil:3662  <CONSTANT S-FALL>
ZG.const._declare('S_FALL', lambda: 6)

# zil: 2actions.zil:3663  <CONSTANT S-FERMENT>
ZG.const._declare('S_FERMENT', lambda: 7)

# zil: 2actions.zil:3664  <CONSTANT S-FIERCE>
ZG.const._declare('S_FIERCE', lambda: 8)

# zil: 2actions.zil:3665  <CONSTANT S-FLOAT>
ZG.const._declare('S_FLOAT', lambda: 9)

# zil: 2actions.zil:3666  <CONSTANT S-FIREPROOF>
ZG.const._declare('S_FIREPROOF', lambda: 10)

# zil: 2actions.zil:3667  <CONSTANT S-FENCE>
ZG.const._declare('S_FENCE', lambda: 11)

# zil: 2actions.zil:3668  <CONSTANT S-FANTASIZE>
ZG.const._declare('S_FANTASIZE', lambda: 12)

# zil: 2actions.zil:3670  <GLOBAL SPELL-NAMES>
ZG.state._declare('SPELL_NAMES', lambda: LTABLE('Feeble', 'Fumble', 'Fear', 'Filch', 'Freeze', 'Fall', 'Ferment', 'Fierce', 'Float', 'Fireproof', 'Fence', 'Fantasize'))

# zil: 2actions.zil:3675  <GLOBAL SPELL-HINTS>
ZG.state._declare('SPELL_HINTS', lambda: LTABLE('All at once you feel very tired.', False, 'You look at the Wizard in terror. You scramble away,\ntrying to get as far as possible from him.', False, "Your limbs suddenly feel like they have turned to stone. You can't\nmove a muscle.", False, 'You begin to feel lightheaded.', 'You rush at the Wizard, intending to tear him limb from limb.', False, False, False, False))

# zil: 2actions.zil:3692  <GLOBAL SPELL-STOPS>
ZG.state._declare('SPELL_STOPS', lambda: LTABLE('You feel more energetic now.', False, "You suddenly decide that the Wizard isn't that terrifying...", False, 'Your little finger begins to twitch, and then your whole body is free\nagain.', False, 'Your head is clearer now.', 'You feel cooler and less angry now.', 'You sink quietly down again.', False, False, False))

# zil: 2actions.zil:3746  <GLOBAL SPELL-HANDLED?>
ZG.state._declare('SPELL_HANDLED_p', lambda: False)

# zil: 2actions.zil:3747  <GLOBAL WAND-ON>
ZG.state._declare('WAND_ON', lambda: False)

# zil: 2actions.zil:3748  <GLOBAL SPELL-USED>
ZG.state._declare('SPELL_USED', lambda: False)

# zil: 2actions.zil:3749  <GLOBAL SPELL-VICTIM>
ZG.state._declare('SPELL_VICTIM', lambda: False)

# zil: 2actions.zil:3808  <GLOBAL WAND-ON-LOC>
ZG.state._declare('WAND_ON_LOC', lambda: False)

# zil: 2actions.zil:3836  <GLOBAL WIZQLAST>
ZG.state._declare('WIZQLAST', lambda: 0)

# zil: 2actions.zil:3838  <GLOBAL WIZQDESCS>
ZG.state._declare('WIZQDESCS', lambda: LTABLE('sparsely furnished and almost monkish in its austerity.', 'an opulently furnished seraglio out of an Arabian folktale.', 'decorated in the Louis XIV style.', 'overhung with palm-trees and lianas. The only furniture is a hammock.', 'constructed of delicate and wispy cloud-stuffs.', 'furnished in plastic and metal and looks like the control deck of a\nspaceship.', "a suburban bedroom out of the 1950's, complete with bunk beds.", 'a dank and dimly lighted cave, its floor piled with furs and old bones.'))

# zil: 2actions.zil:3908  <GLOBAL FANTASIES>
ZG.state._declare('FANTASIES', lambda: LTABLE('pile of jewels', 'gold ingot', 'basilisk', 'bulging chest', 'yellow sphere', 'grue', 'convention of wizards', 'copy of ZORK I'))
