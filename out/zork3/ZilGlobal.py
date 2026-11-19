"""ZIL のグローバル変数・定数の宣言 (自動生成)。

全 ZIL ファイルの GLOBAL / CONSTANT をここに集める。元のファイルには
コメントとして残してある。値は最初に参照された時に評価する。
"""

from ZilRuntime import *

# ------------------------------------------------------------
# zork3
# ------------------------------------------------------------

ZG.const._declare('ZORK_NUMBER', lambda: 3)

# ------------------------------------------------------------
# gmacros
# ------------------------------------------------------------

ZG.const._declare('C_ENABLED_p', lambda: 0)

ZG.const._declare('C_ENABLED', lambda: 1)

ZG.const._declare('C_DISABLED', lambda: 0)

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
# _3dungeon
# ------------------------------------------------------------

# zil: 3dungeon.zil:202  <GLOBAL CP-FLAG>
ZG.state._declare('CP_FLAG', lambda: False)

# zil: 3dungeon.zil:960  <GLOBAL CLEFT-QUEUED?>
ZG.state._declare('CLEFT_QUEUED_p', lambda: False)

# ------------------------------------------------------------
# gglobals
# ------------------------------------------------------------

# zil: gglobals.zil:125  <GLOBAL LOAD-MAX>
ZG.state._declare('LOAD_MAX', lambda: 100)

# zil: gglobals.zil:127  <GLOBAL LOAD-ALLOWED>
ZG.state._declare('LOAD_ALLOWED', lambda: 100)

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

# zil: gverbs.zil:2252  <GLOBAL HELLOS>
ZG.state._declare('HELLOS', lambda: LTABLE(0, 'Hello.', 'Good day.', "Nice weather we've been having lately.", 'Goodbye.'))

# zil: gverbs.zil:2258  <GLOBAL YUKS>
ZG.state._declare('YUKS', lambda: LTABLE(0, 'A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!'))

# zil: gverbs.zil:2267  <GLOBAL DUMMY>
ZG.state._declare('DUMMY', lambda: LTABLE(0, 'Look around.', 'Too late for that.', 'Have your eyes checked.'))

# ------------------------------------------------------------
# _3actions
# ------------------------------------------------------------

# zil: 3actions.zil:41  <GLOBAL SWORD-STATE>
ZG.state._declare('SWORD_STATE', lambda: 0)

# 注意: YUKS は gverbs で別の値で宣言済み (後の宣言が使われる。前の値: LTABLE(0, 'A valiant attempt.', "You can't be serious.", 'An interesting idea...)
# zil: 3actions.zil:52  <GLOBAL YUKS>
ZG.state._declare('YUKS', lambda: LTABLE('A valiant attempt.', "You can't be serious.", 'An interesting idea...', 'What a concept!'))

# zil: 3actions.zil:80  <GLOBAL LAMP-TABLE>
ZG.state._declare('LAMP_TABLE', lambda: TABLE(300, 'The lamp appears a bit dimmer.', 100, 'The lamp is definitely dimmer now.', 50, 'The lamp is nearly out.', 0))

# zil: 3actions.zil:172  <GLOBAL CPHERE>
ZG.state._declare('CPHERE', lambda: 1)

# zil: 3actions.zil:174  <GLOBAL CPOBJS>
ZG.state._declare('CPOBJS', lambda: ITABLE('NONE', (8 * 2 * 36)))

# zil: 3actions.zil:176  <GLOBAL CPTABLE>
ZG.state._declare('CPTABLE', lambda: TABLE(1, 0, -1, 0, 0, -1, 0, -1, 0, 1, 0, -2, 0, 0, 0, 0, 0, 1, 0, -3, 0, 0, -1, -1, 0, 0, 0, -1, 0, 0, 0, 1, 1, 0, 0, 0, 1))

# zil: 3actions.zil:219  <GLOBAL CPWALLS>
ZG.state._declare('CPWALLS', lambda: LTABLE(ZG.CPSWL, 6, ZG.CPNWL, -6, ZG.CPEWL, 1, ZG.CPWWL, -1))

# zil: 3actions.zil:221  <GLOBAL CPEXITS>
ZG.state._declare('CPEXITS', lambda: LTABLE('NORTH', -6, 'SOUTH', 6, 'EAST', 1, 'WEST', -1, 'NE', -5, 'NW', -7, 'SE', 7, 'SW', 5))

# zil: 3actions.zil:239  <GLOBAL CP-MOVED>
ZG.state._declare('CP_MOVED', lambda: False)

# zil: 3actions.zil:292  <GLOBAL MINUS-SEVEN>
ZG.state._declare('MINUS_SEVEN', lambda: -7)

# zil: 3actions.zil:293  <GLOBAL MINUS-FIVE>
ZG.state._declare('MINUS_FIVE', lambda: -5)

# zil: 3actions.zil:294  <GLOBAL MINUS-FOUR>
ZG.state._declare('MINUS_FOUR', lambda: -4)

# zil: 3actions.zil:295  <GLOBAL MINUS-ONE>
ZG.state._declare('MINUS_ONE', lambda: -1)

# zil: 3actions.zil:333  <GLOBAL CPPUSH-FLAG>
ZG.state._declare('CPPUSH_FLAG', lambda: False)

# zil: 3actions.zil:335  <GLOBAL CPSOLVE-FLAG>
ZG.state._declare('CPSOLVE_FLAG', lambda: False)

# zil: 3actions.zil:420  <GLOBAL CPBLOCK-FLAG>
ZG.state._declare('CPBLOCK_FLAG', lambda: False)

# zil: 3actions.zil:422  <CONSTANT GCARDLOC>
ZG.const._declare('GCARDLOC', lambda: 168)

# zil: 3actions.zil:602  <GLOBAL MLOC>
ZG.state._declare('MLOC', lambda: False)

# zil: 3actions.zil:604  <GLOBAL MR1-FLAG>
ZG.state._declare('MR1_FLAG', lambda: True)

# zil: 3actions.zil:606  <GLOBAL MR2-FLAG>
ZG.state._declare('MR2_FLAG', lambda: True)

# zil: 3actions.zil:608  <GLOBAL MIRROR-OPEN-FLAG>
ZG.state._declare('MIRROR_OPEN_FLAG', lambda: False)

# zil: 3actions.zil:610  <GLOBAL WOOD-OPEN-FLAG>
ZG.state._declare('WOOD_OPEN_FLAG', lambda: False)

# zil: 3actions.zil:612  <GLOBAL MRSWPUSH-FLAG>
ZG.state._declare('MRSWPUSH_FLAG', lambda: False)

# zil: 3actions.zil:614  <GLOBAL R-SOUTHS>
ZG.state._declare('R_SOUTHS', lambda: LTABLE(ZG.FRONT_DOOR, ZG.MRD, ZG.MRG, ZG.MRC, ZG.MRB, ZG.MRA, ZG.MREYE))

# zil: 3actions.zil:615  <GLOBAL R-NORTHS>
ZG.state._declare('R_NORTHS', lambda: LTABLE(ZG.MREYE, ZG.MRA, ZG.MRB, ZG.MRC, ZG.MRG, ZG.MRD))

# zil: 3actions.zil:650  <GLOBAL R-EASTS>
ZG.state._declare('R_EASTS', lambda: LTABLE(ZG.MRA, ZG.MRAE, ZG.MRB, ZG.MRBE, ZG.MRC, ZG.MRCE, ZG.MRG, ZG.MRGE, ZG.MRD, ZG.MRDE))

# zil: 3actions.zil:651  <GLOBAL R-WESTS>
ZG.state._declare('R_WESTS', lambda: LTABLE(ZG.MRA, ZG.MRAW, ZG.MRB, ZG.MRBW, ZG.MRC, ZG.MRCW, ZG.MRG, ZG.MRGW, ZG.MRD, ZG.MRDW))

# zil: 3actions.zil:678  <GLOBAL GUARDIANS-SEEN>
ZG.state._declare('GUARDIANS_SEEN', lambda: False)

# zil: 3actions.zil:702  <GLOBAL GUARDSTR>
ZG.state._declare('GUARDSTR', lambda: ', identical stone statues face each other from\npedestals on opposite sides of the corridor. The statues represent\nGuardians of Zork, a military order of ancient lineage. They are\nportrayed as heavily armored warriors clasping formidable bludgeons.')

# zil: 3actions.zil:935  <GLOBAL MIRROR-FIRST>
ZG.state._declare('MIRROR_FIRST', lambda: 'To break the panel you would have to break the mirror first.')

# zil: 3actions.zil:938  <GLOBAL DIRVEC>
ZG.state._declare('DIRVEC', lambda: LTABLE('NORTH', 0, 'NE', 45, 'EAST', 90, 'SE', 135, 'SOUTH', 180, 'SW', 225, 'WEST', 270, 'NW', 315))

# zil: 3actions.zil:1034  <GLOBAL BEAM-BREAKER>
ZG.state._declare('BEAM_BREAKER', lambda: False)

# zil: 3actions.zil:1079  <GLOBAL MIRROR-OPENED>
ZG.state._declare('MIRROR_OPENED', lambda: False)

# zil: 3actions.zil:1104  <GLOBAL MDIR>
ZG.state._declare('MDIR', lambda: 270)

# zil: 3actions.zil:1108  <GLOBAL POLEUP-FLAG>
ZG.state._declare('POLEUP_FLAG', lambda: 0)

# zil: 3actions.zil:1177  <GLOBAL LONGDIRS>
ZG.state._declare('LONGDIRS', lambda: TABLE('north', 'northeast', 'east', 'southeast', 'south', 'southwest', 'west', 'northwest'))

# zil: 3actions.zil:1407  <GLOBAL DM-SEEN>
ZG.state._declare('DM_SEEN', lambda: False)

# zil: 3actions.zil:1484  <GLOBAL IN-DUNGEON>
ZG.state._declare('IN_DUNGEON', lambda: False)

# zil: 3actions.zil:1486  <GLOBAL DM-REASONS>
ZG.state._declare('DM_REASONS', lambda: TABLE('but I fear my waiting may be in vain.', 'but you have far to go before you are ready.', 'and you seem to have made slight some progress.', 'and your journey is half complete. Be of good cheer!', 'and you are nearing the end of your long quest!', 'and it will not be long before you are ready!', 'and you are nearly ready for the last test!'))

# zil: 3actions.zil:1505  <GLOBAL FOLFLAG>
ZG.state._declare('FOLFLAG', lambda: True)

# zil: 3actions.zil:1530  <GLOBAL LCELL>
ZG.state._declare('LCELL', lambda: 1)

# zil: 3actions.zil:1532  <GLOBAL PNUMB>
ZG.state._declare('PNUMB', lambda: 1)

# zil: 3actions.zil:1534  <GLOBAL CELLOBJS>
ZG.state._declare('CELLOBJS', lambda: ITABLE('NONE', (8 * 2 * 8)))

# zil: 3actions.zil:1694  <GLOBAL BRONZE-DOOR-LOCKED>
ZG.state._declare('BRONZE_DOOR_LOCKED', lambda: True)

# zil: 3actions.zil:1751  <GLOBAL OLD-MAN-GONE>
ZG.state._declare('OLD_MAN_GONE', lambda: False)

# zil: 3actions.zil:1752  <GLOBAL OLD-MAN-FED>
ZG.state._declare('OLD_MAN_FED', lambda: False)

# zil: 3actions.zil:1754  <GLOBAL SECRET-DOOR-DESC>
ZG.state._declare('SECRET_DOOR_DESC', lambda: 'Beyond the secret door are dark, forbidding stairs leading down to\na passage below. Flickering torchlight illuminates the passage.')

# zil: 3actions.zil:1857  <GLOBAL OLD-MAN-AWAKE>
ZG.state._declare('OLD_MAN_AWAKE', lambda: False)

# zil: 3actions.zil:1983  <GLOBAL DIAG>
ZG.state._declare('DIAG', lambda: TABLE('You are dead.', 'You are very seriously wounded. One more wound would very likely do you in.', 'You are hurt quite badly. One major wound would probably kill you.', 'You have a few wounds, which do not seriously impair your strength.', 'You are wounded lightly. You have a good deal of strength in reserve.', 'You are in perfect health.'))

# zil: 3actions.zil:2055  <GLOBAL DEAD-OBJ-LOCS>
ZG.state._declare('DEAD_OBJ_LOCS', lambda: LTABLE(ZG.JUNCTION, ZG.CLEARING, ZG.DAMP_PASSAGE, ZG.CREEPY_CRAWL, ZG.TIGHT_SQUEEZE, ZG.FOGGY_ROOM, ZG.DEAD_END))

# zil: 3actions.zil:2066  <GLOBAL SCORE-MAX>
ZG.state._declare('SCORE_MAX', lambda: 7)

# zil: 3actions.zil:2426  <GLOBAL MACHINE-DAMAGED>
ZG.state._declare('MACHINE_DAMAGED', lambda: False)

# zil: 3actions.zil:2428  <GLOBAL YEAR>
ZG.state._declare('YEAR', lambda: 948)

# zil: 3actions.zil:2430  <CONSTANT YEAR-BUILT>
ZG.const._declare('YEAR_BUILT', lambda: 776)

# zil: 3actions.zil:2432  <CONSTANT YEAR-CAGED>
ZG.const._declare('YEAR_CAGED', lambda: 777)

# zil: 3actions.zil:2434  <GLOBAL YEAR-CLOSED>
ZG.state._declare('YEAR_CLOSED', lambda: 883)

# zil: 3actions.zil:2436  <CONSTANT REAL-YEAR-CLOSED>
ZG.const._declare('REAL_YEAR_CLOSED', lambda: 883)

# zil: 3actions.zil:2438  <CONSTANT YEAR-PRESENT>
ZG.const._declare('YEAR_PRESENT', lambda: 948)

# zil: 3actions.zil:2449  <GLOBAL CLEFT-FLAG>
ZG.state._declare('CLEFT_FLAG', lambda: False)

# zil: 3actions.zil:2530  <GLOBAL TM-YEAR>
ZG.state._declare('TM_YEAR', lambda: 948)

# zil: 3actions.zil:2593  <GLOBAL RING-CONCEALED>
ZG.state._declare('RING_CONCEALED', lambda: False)

# zil: 3actions.zil:2633  <GLOBAL TM-POINT>
ZG.state._declare('TM_POINT', lambda: False)

# zil: 3actions.zil:2689  <GLOBAL SURROUNDINGS-CHANGED>
ZG.state._declare('SURROUNDINGS_CHANGED', lambda: 'your surroundings appear to have changed. From outside the door\nyou hear the sounds of guards talking.')

# zil: 3actions.zil:2707  <GLOBAL SNAP-LOC>
ZG.state._declare('SNAP_LOC', lambda: False)

# zil: 3actions.zil:2839  <GLOBAL GUARD-KILLERS>
ZG.state._declare('GUARD_KILLERS', lambda: LTABLE(0, 'you are surrounded by heavily armed guards who seem awed by your presence.\nOne, whose IQ might be 15, aims a strange waffle-like\ninstrument in your direction and all goes black.', 'you are confronted with many particularly stupid-looking\npeople dressed in peculiar uniforms and pointing waffle-like objects in\nyour direction. One twists his waffle and you slump\nto the ground, dead.', 'you see a row of military people who, if appearances do not\ndeceive, have the cumulative intelligence of an unripe grapefruit. One\nof them aims a waffle-shaped implement in your direction and you become numb\nand then paralyzed and then dead.'))

# zil: 3actions.zil:2874  <GLOBAL FLATHEAD-HEARD>
ZG.state._declare('FLATHEAD_HEARD', lambda: False)

# zil: 3actions.zil:2876  <GLOBAL RING-STOLEN>
ZG.state._declare('RING_STOLEN', lambda: False)

# zil: 3actions.zil:2877  <GLOBAL CLUMSY-ROBBERY>
ZG.state._declare('CLUMSY_ROBBERY', lambda: False)

# zil: 3actions.zil:2878  <GLOBAL MYSTERY>
ZG.state._declare('MYSTERY', lambda: False)

# zil: 3actions.zil:2880  <GLOBAL GUARDS-PRESENT>
ZG.state._declare('GUARDS_PRESENT', lambda: True)

# zil: 3actions.zil:2945  <GLOBAL HEAR-VOICES>
ZG.state._declare('HEAR_VOICES', lambda: 'Through the door you can hear voices which, from their\nsound, belong to military or police personnel.')

# zil: 3actions.zil:3115  <GLOBAL BLATHER>
ZG.state._declare('BLATHER', lambda: LTABLE(0, 'wage scales for guards', 'the excessive nature of the Royal Government', 'the soon to be constructed Royal Puzzle', 'the proper way to execute trespassers', 'torturing thieves', 'the banishment of the Wizard of Frobozz'))

# zil: 3actions.zil:3382  <GLOBAL DIRS>
ZG.state._declare('DIRS', lambda: LTABLE('NORTH', 'north', 'SOUTH', 'south', 'EAST', 'east', 'WEST', 'west', 'NW', 'northwest', 'NE', 'northeast', 'SE', 'southeast', 'SW', 'southwest', 'UP', 'stairs', 'DOWN', 'stairs'))

# zil: 3actions.zil:3387  <GLOBAL DIR-TBL>
ZG.state._declare('DIR_TBL', lambda: TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))

# zil: 3actions.zil:3431  <GLOBAL SHADOW-DIAG>
ZG.state._declare('SHADOW_DIAG', lambda: TABLE('?', ' appears to be badly hurt and defenseless.', ' is hurt, and its strength appears to be fading.', ' has some wounds and is probably not capable of hindering your movement.', " has a light wound which hasn't affected its seemingly great strength.", ' has a great deal of strength, perhaps matching your own.'))

# zil: 3actions.zil:3440  <GLOBAL P-STRENGTH>
ZG.scratch._declare('P_STRENGTH', lambda: 5)

# zil: 3actions.zil:3441  <GLOBAL S-STRENGTH>
ZG.state._declare('S_STRENGTH', lambda: 5)

# zil: 3actions.zil:3443  <GLOBAL ATTACK-MODE>
ZG.state._declare('ATTACK_MODE', lambda: False)

# zil: 3actions.zil:3444  <GLOBAL SHADOW-GONE>
ZG.state._declare('SHADOW_GONE', lambda: False)

# zil: 3actions.zil:3483  <GLOBAL P-HITS>
ZG.scratch._declare('P_HITS', lambda: LTABLE(0, 'A good parry! Your sword wounds the hooded figure!', "A quick stroke catches the hooded figure off guard! Blood trickles\ndown the figure's arm!", 'The hooded figure is hit with a quick slash!'))

# zil: 3actions.zil:3489  <GLOBAL P-MISSES>
ZG.scratch._declare('P_MISSES', lambda: LTABLE(0, 'Your move was not quick enough and misses the mark.', 'A quick stroke, but the hooded figure is on guard.', "A good stroke, but it's too slow.", 'A good slash, but it misses by a mile.', 'You charge, but the hooded figure jumps nimbly aside.'))

# zil: 3actions.zil:3496  <GLOBAL S-HITS>
ZG.state._declare('S_HITS', lambda: LTABLE(0, 'The hooded figure catches you off guard and wounds you!', 'You are wounded by a lightning thrust!', "Your quick reflexes cannot stop the hooded figure's stroke! You are hit!"))

# zil: 3actions.zil:3537  <GLOBAL S-MISSES>
ZG.state._declare('S_MISSES', lambda: LTABLE(0, 'The hooded figure stabs nonchalantly with its sword and misses.', 'You dodge as the hooded figure comes in low.', 'The hooded figure tries to sneak past your guard, but you twist away.', 'The hooded figure thrusts, but you fight back and send it\nflying to the ground!'))

# zil: 3actions.zil:3589  <GLOBAL BLOCKED-DIR>
ZG.state._declare('BLOCKED_DIR', lambda: False)

# zil: 3actions.zil:3636  <GLOBAL SHADOW-POINT-1>
ZG.state._declare('SHADOW_POINT_1', lambda: False)

# zil: 3actions.zil:3637  <GLOBAL SHADOW-POINT-2>
ZG.state._declare('SHADOW_POINT_2', lambda: False)

# zil: 3actions.zil:4060  <GLOBAL CHEST-LIFTED>
ZG.state._declare('CHEST_LIFTED', lambda: False)

# zil: 3actions.zil:4092  <GLOBAL MAN-SEEN>
ZG.state._declare('MAN_SEEN', lambda: False)

# zil: 3actions.zil:4117  <GLOBAL MAN-WAITS>
ZG.state._declare('MAN_WAITS', lambda: LTABLE(0, 'The man appears to be getting somewhat impatient.', 'Your friend at the cliff top has started pacing nervously around.', '"Yoo hoo!" calls the man at the brink of the cliff. "Remember me?"', 'The man on the cliff waves at you. "It would just take a moment to tie that\nrope to the chest. I\'d be much obliged, and there might even be something in\nit for you!"', 'A few small stones fall near your feet. You look up and see your friend\nwaving. "I haven\'t got all day, fella. Be a pal and pass up the chest!"', 'The man on the cliff clears his throat loudly. "I don\'t mean to be rushing\nyou, but I do have some pressing engagements...."'))

# zil: 3actions.zil:4129  <GLOBAL MAN-WAITING>
ZG.state._declare('MAN_WAITING', lambda: 0)

# zil: 3actions.zil:4130  <GLOBAL MAN-FLAG>
ZG.state._declare('MAN_FLAG', lambda: False)

# zil: 3actions.zil:4131  <GLOBAL MAN-POINT>
ZG.state._declare('MAN_POINT', lambda: False)

# zil: 3actions.zil:4132  <GLOBAL MAN-GONE>
ZG.state._declare('MAN_GONE', lambda: False)

# zil: 3actions.zil:4261  <GLOBAL CHEST-TIED>
ZG.state._declare('CHEST_TIED', lambda: False)

# zil: 3actions.zil:4262  <GLOBAL HOLDING-ROPE>
ZG.state._declare('HOLDING_ROPE', lambda: False)

# zil: 3actions.zil:4275  <GLOBAL LIFT-WAIT>
ZG.state._declare('LIFT_WAIT', lambda: 0)

# zil: 3actions.zil:4319  <GLOBAL CHEST-OPENED>
ZG.state._declare('CHEST_OPENED', lambda: False)

# zil: 3actions.zil:4342  <GLOBAL ROPE-FLAG>
ZG.state._declare('ROPE_FLAG', lambda: True)

# zil: 3actions.zil:4513  <GLOBAL LAST-MOVES>
ZG.state._declare('LAST_MOVES', lambda: 0)

# zil: 3actions.zil:4521  <GLOBAL LAKE-POINT>
ZG.state._declare('LAKE_POINT', lambda: False)

# zil: 3actions.zil:4533  <GLOBAL CURRENT-LAMP>
ZG.state._declare('CURRENT_LAMP', lambda: ZG.LAMP)

# zil: 3actions.zil:4566  <GLOBAL LAKE-TIME>
ZG.state._declare('LAKE_TIME', lambda: False)

# zil: 3actions.zil:4634  <GLOBAL VIEW-POINT>
ZG.state._declare('VIEW_POINT', lambda: 1)

# zil: 3actions.zil:4679  <GLOBAL VIEW-ROMANS>
ZG.state._declare('VIEW_ROMANS', lambda: TABLE(0, 'I', 'II', 'III', 'IV'))

# zil: 3actions.zil:4681  <GLOBAL ACTIVE-VIEW>
ZG.state._declare('ACTIVE_VIEW', lambda: 1)

# zil: 3actions.zil:4683  <GLOBAL VIEW-ROOMS>
ZG.state._declare('VIEW_ROOMS', lambda: LTABLE(ZG.TIMBER_ROOM, ZG.ROOM_8, ZG.DAMP_PASSAGE, ZG.ZORK_IV))

# zil: 3actions.zil:4685  <GLOBAL VIEWS>
ZG.state._declare('VIEWS', lambda: LTABLE('You see a passage cluttered with broken timbers. An extremely narrow opening\ncan be seen at the end of the room.', 'You see a tiny room with rough walls. Chiseled crudely on one wall is the\nnumber "8". The only apparent exit seems to be a blur.', 'You see a wide room with two nearly identical passages leading east and\nnortheast. A wide channel descends steeply into the room and seems to be\nblocked by rubble.', 'You see the interior of a huge temple rudely constructed of basalt blocks.\nFlickering torches cast a sallow illumination over an altar still wet with the\nblood of human sacrifice, its velvet covers stained and encrusted with gore.'))

# zil: 3actions.zil:4833  <GLOBAL EMPTY-HANDED>
ZG.state._declare('EMPTY_HANDED', lambda: False)

# zil: 3actions.zil:4902  <GLOBAL SPRAY-USED?>
ZG.state._declare('SPRAY_USED_p', lambda: False)

# zil: 3actions.zil:5089  <GLOBAL AQ-FLAG>
ZG.state._declare('AQ_FLAG', lambda: True)

# zil: 3actions.zil:5091  <GLOBAL COVER-MOVED>
ZG.state._declare('COVER_MOVED', lambda: False)

# zil: 3actions.zil:5158  <GLOBAL KEY-DESCS>
ZG.state._declare('KEY_DESCS', lambda: LTABLE(0, 'The key is a long and heavy skeleton key.', 'The key is short and stubby, shaped like no lock you have ever seen.', 'The key is round and thin, more like a pencil than a key.', 'The key is shiny with many prongs.', 'The key is sharp as an awl, and rusted badly.'))

# zil: 3actions.zil:5178  <GLOBAL BOAT-SEEN>
ZG.state._declare('BOAT_SEEN', lambda: False)

# zil: 3actions.zil:5206  <GLOBAL SHIP-GONE>
ZG.state._declare('SHIP_GONE', lambda: False)

# zil: 3actions.zil:5271  <GLOBAL INVIS>
ZG.state._declare('INVIS', lambda: False)

# zil: 3actions.zil:5331  <GLOBAL SWORD-IN-STONE?>
ZG.state._declare('SWORD_IN_STONE_p', lambda: True)
