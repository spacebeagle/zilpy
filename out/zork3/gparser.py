# --- Auto-generated Python code from ZIL ---
import sys

from ZilRuntime import *
import ZilGlobal  # noqa: F401  (グローバル宣言を登録する)

'Generic PARSER file for\n\t\t\t    The ZORK Trilogy\n\t\t       started on 7/28/83 by MARC'

# ;"WHICH and TRAP retrofixes installed"

"Parser global variable convention:  All parser globals will\n  begin with 'P-'.  Local variables are not restricted in any\n  way.\n"

# SETG (const) SIBREAKS = '.,"'  ->  ZilGlobal.py

# zil: gparser.zil:14  <GLOBAL PRSA>
# GLOBAL (scratch) PRSA = False  ->  ZilGlobal.py

# zil: gparser.zil:15  <GLOBAL PRSI>
# GLOBAL (scratch) PRSI = False  ->  ZilGlobal.py

# zil: gparser.zil:16  <GLOBAL PRSO>
# GLOBAL (scratch) PRSO = False  ->  ZilGlobal.py

# zil: gparser.zil:18  <GLOBAL P-TABLE>
# GLOBAL (scratch) P_TABLE = 0  ->  ZilGlobal.py

# zil: gparser.zil:19  <GLOBAL P-ONEOBJ>
# GLOBAL (scratch) P_ONEOBJ = 0  ->  ZilGlobal.py

# zil: gparser.zil:20  <GLOBAL P-SYNTAX>
# GLOBAL (scratch) P_SYNTAX = 0  ->  ZilGlobal.py

# zil: gparser.zil:22  <GLOBAL P-CCTBL>
# GLOBAL (scratch) P_CCTBL = TABLE(0, 0, 0, 0)  ->  ZilGlobal.py

# ;"pointers used by CLAUSE-COPY (source/destination beginning/end pointers)"

# zil: gparser.zil:24  <CONSTANT CC-SBPTR>
# CONSTANT (const) CC_SBPTR = 0  ->  ZilGlobal.py

# zil: gparser.zil:25  <CONSTANT CC-SEPTR>
# CONSTANT (const) CC_SEPTR = 1  ->  ZilGlobal.py

# zil: gparser.zil:26  <CONSTANT CC-DBPTR>
# CONSTANT (const) CC_DBPTR = 2  ->  ZilGlobal.py

# zil: gparser.zil:27  <CONSTANT CC-DEPTR>
# CONSTANT (const) CC_DEPTR = 3  ->  ZilGlobal.py

# zil: gparser.zil:29  <GLOBAL P-LEN>
# GLOBAL (scratch) P_LEN = 0  ->  ZilGlobal.py

# zil: gparser.zil:30  <GLOBAL P-DIR>
# GLOBAL (scratch) P_DIR = 0  ->  ZilGlobal.py

# zil: gparser.zil:31  <GLOBAL HERE>
# GLOBAL (scratch) HERE = 0  ->  ZilGlobal.py

# zil: gparser.zil:32  <GLOBAL WINNER>
# GLOBAL (scratch) WINNER = 0  ->  ZilGlobal.py

# zil: gparser.zil:34  <GLOBAL P-LEXV>
# GLOBAL (scratch) P_LEXV = ITABLE(59, ('LEXV',), 0, TBYTE(0), TBYTE(0))  ->  ZilGlobal.py

# zil: gparser.zil:36  <GLOBAL AGAIN-LEXV>
# GLOBAL (scratch) AGAIN_LEXV = ITABLE(59, ('LEXV',), 0, TBYTE(0), TBYTE(0))  ->  ZilGlobal.py

# zil: gparser.zil:38  <GLOBAL RESERVE-LEXV>
# GLOBAL (scratch) RESERVE_LEXV = ITABLE(59, ('LEXV',), 0, TBYTE(0), TBYTE(0))  ->  ZilGlobal.py

# zil: gparser.zil:40  <GLOBAL RESERVE-PTR>
# GLOBAL (scratch) RESERVE_PTR = False  ->  ZilGlobal.py

# ;"INBUF - Input buffer for READ"

# zil: gparser.zil:44  <GLOBAL P-INBUF>
# GLOBAL (scratch) P_INBUF = ITABLE(120, ('BYTE', 'LENGTH'), 0)  ->  ZilGlobal.py

# zil: gparser.zil:47  <GLOBAL OOPS-INBUF>
# GLOBAL (scratch) OOPS_INBUF = ITABLE(120, ('BYTE', 'LENGTH'), 0)  ->  ZilGlobal.py

# zil: gparser.zil:50  <GLOBAL OOPS-TABLE>
# GLOBAL (scratch) OOPS_TABLE = TABLE(False, False, False, False)  ->  ZilGlobal.py

# zil: gparser.zil:51  <CONSTANT O-PTR>
# CONSTANT (const) O_PTR = 0  ->  ZilGlobal.py

'word pointer to unknown token in P-LEXV'

# zil: gparser.zil:52  <CONSTANT O-START>
# CONSTANT (const) O_START = 1  ->  ZilGlobal.py

'word pointer to sentence start in P-LEXV'

# zil: gparser.zil:53  <CONSTANT O-LENGTH>
# CONSTANT (const) O_LENGTH = 2  ->  ZilGlobal.py

'byte length of unparsed tokens in P-LEXV'

# zil: gparser.zil:54  <CONSTANT O-END>
# CONSTANT (const) O_END = 3  ->  ZilGlobal.py

'byte pointer to first free byte in OOPS-INBUF'

# ;"Parse-cont variable"

# zil: gparser.zil:58  <GLOBAL P-CONT>
# GLOBAL (scratch) P_CONT = False  ->  ZilGlobal.py

# zil: gparser.zil:59  <GLOBAL P-IT-OBJECT>
# GLOBAL (scratch) P_IT_OBJECT = False  ->  ZilGlobal.py

# ;<GLOBAL LAST-PSEUDO-LOC <>>

# ;"Orphan flag"

# zil: gparser.zil:64  <GLOBAL P-OFLAG>
# GLOBAL (scratch) P_OFLAG = False  ->  ZilGlobal.py

# zil: gparser.zil:65  <GLOBAL P-MERGED>
# GLOBAL (scratch) P_MERGED = False  ->  ZilGlobal.py

# zil: gparser.zil:66  <GLOBAL P-ACLAUSE>
# GLOBAL (scratch) P_ACLAUSE = False  ->  ZilGlobal.py

# zil: gparser.zil:67  <GLOBAL P-ANAM>
# GLOBAL (scratch) P_ANAM = False  ->  ZilGlobal.py

# zil: gparser.zil:68  <GLOBAL P-AADJ>
# GLOBAL (scratch) P_AADJ = False  ->  ZilGlobal.py

# ;"Parser variables and temporaries"

# ;"Byte offset to # of entries in LEXV"

# zil: gparser.zil:73  <CONSTANT P-LEXWORDS>
# CONSTANT (const) P_LEXWORDS = 1  ->  ZilGlobal.py

# ;"Word offset to start of LEXV entries"

# zil: gparser.zil:74  <CONSTANT P-LEXSTART>
# CONSTANT (const) P_LEXSTART = 1  ->  ZilGlobal.py

# ;"Number of words per LEXV entry"

# zil: gparser.zil:75  <CONSTANT P-LEXELEN>
# CONSTANT (const) P_LEXELEN = 2  ->  ZilGlobal.py

# zil: gparser.zil:76  <CONSTANT P-WORDLEN>
# CONSTANT (const) P_WORDLEN = 4  ->  ZilGlobal.py

# ;"Offset to parts of speech byte"

# zil: gparser.zil:78  <CONSTANT P-PSOFF>
# CONSTANT (const) P_PSOFF = 4  ->  ZilGlobal.py

# ;"Offset to first part of speech"

# zil: gparser.zil:79  <CONSTANT P-P1OFF>
# CONSTANT (const) P_P1OFF = 5  ->  ZilGlobal.py

# ;"First part of speech bit mask in PSOFF byte"

# zil: gparser.zil:80  <CONSTANT P-P1BITS>
# CONSTANT (const) P_P1BITS = 3  ->  ZilGlobal.py

# zil: gparser.zil:82  <CONSTANT P-ITBLLEN>
# CONSTANT (const) P_ITBLLEN = 9  ->  ZilGlobal.py

# zil: gparser.zil:83  <GLOBAL P-ITBL>
# GLOBAL (scratch) P_ITBL = TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)  ->  ZilGlobal.py

# zil: gparser.zil:84  <GLOBAL P-OTBL>
# GLOBAL (scratch) P_OTBL = TABLE(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)  ->  ZilGlobal.py

# zil: gparser.zil:85  <GLOBAL P-VTBL>
# GLOBAL (scratch) P_VTBL = TABLE(0, 0, 0, 0)  ->  ZilGlobal.py

# zil: gparser.zil:86  <GLOBAL P-OVTBL>
# GLOBAL (scratch) P_OVTBL = TABLE(0, TBYTE(0), TBYTE(0))  ->  ZilGlobal.py

# zil: gparser.zil:88  <GLOBAL P-NCN>
# GLOBAL (scratch) P_NCN = 0  ->  ZilGlobal.py

# zil: gparser.zil:90  <CONSTANT P-VERB>
# CONSTANT (const) P_VERB = 0  ->  ZilGlobal.py

# zil: gparser.zil:91  <CONSTANT P-VERBN>
# CONSTANT (const) P_VERBN = 1  ->  ZilGlobal.py

# zil: gparser.zil:92  <CONSTANT P-PREP1>
# CONSTANT (const) P_PREP1 = 2  ->  ZilGlobal.py

# zil: gparser.zil:93  <CONSTANT P-PREP1N>
# CONSTANT (const) P_PREP1N = 3  ->  ZilGlobal.py

# zil: gparser.zil:94  <CONSTANT P-PREP2>
# CONSTANT (const) P_PREP2 = 4  ->  ZilGlobal.py

# zil: gparser.zil:95  <CONSTANT P-PREP2N>
# CONSTANT (const) P_PREP2N = 5  ->  ZilGlobal.py

# zil: gparser.zil:96  <CONSTANT P-NC1>
# CONSTANT (const) P_NC1 = 6  ->  ZilGlobal.py

# zil: gparser.zil:97  <CONSTANT P-NC1L>
# CONSTANT (const) P_NC1L = 7  ->  ZilGlobal.py

# zil: gparser.zil:98  <CONSTANT P-NC2>
# CONSTANT (const) P_NC2 = 8  ->  ZilGlobal.py

# zil: gparser.zil:99  <CONSTANT P-NC2L>
# CONSTANT (const) P_NC2L = 9  ->  ZilGlobal.py

# zil: gparser.zil:101  <GLOBAL QUOTE-FLAG>
# GLOBAL (scratch) QUOTE_FLAG = False  ->  ZilGlobal.py

# zil: gparser.zil:102  <GLOBAL P-END-ON-PREP>
# GLOBAL (scratch) P_END_ON_PREP = False  ->  ZilGlobal.py

' Grovel down the input finding the verb, prepositions, and noun clauses.\n   If the input is <direction> or <walk> <direction>, fall out immediately\n   setting PRSA to ,V?WALK and PRSO to <direction>.  Otherwise, perform\n   all required orphaning, syntax checking, and noun clause lookup.'

# zil: gparser.zil:109  <ROUTINE PARSER ("AUX" (PTR ,P-LEXSTART) WRD (VAL 0) (VERB <>) (OF-FLAG <>) O...
@ZG.routine('PARSER')
def PARSER():
    PTR = ZG.P_LEXSTART
    WRD = 0
    VAL = 0
    VERB = False
    OF_FLAG = False
    OWINNER = 0
    OMERGED = 0
    LEN = 0
    DIR = False
    NW = 0
    LW = 0
    CNT = -1
    while True:
        if ((CNT := (CNT + 1)) > ZG.P_ITBLLEN):
            break
        else:
            if (not ZG.P_OFLAG):
                PUT(ZG.P_OTBL, CNT, GET(ZG.P_ITBL, CNT))
            PUT(ZG.P_ITBL, CNT, 0)
    OWINNER = ZG.WINNER
    OMERGED = ZG.P_MERGED
    ZG.P_ADVERB = False
    ZG.P_MERGED = False
    ZG.P_END_ON_PREP = False
    PUT(ZG.P_PRSO, ZG.P_MATCHLEN, 0)
    PUT(ZG.P_PRSI, ZG.P_MATCHLEN, 0)
    PUT(ZG.P_BUTS, ZG.P_MATCHLEN, 0)
    if ((not ZG.QUOTE_FLAG) and (ZG.WINNER != ZG.PLAYER)):
        ZG.WINNER = ZG.PLAYER
        ZG.HERE = ZG.META_LOC(ZG.PLAYER)
        ZG.LIT = ZG.LIT_p(ZG.HERE)
    if ZG.RESERVE_PTR:
        PTR = ZG.RESERVE_PTR
        ZG.STUFF(ZG.RESERVE_LEXV, ZG.P_LEXV)
        if ((not ZG.SUPER_BRIEF) and (ZG.PLAYER == ZG.WINNER)):
            CRLF()
        ZG.RESERVE_PTR = False
        ZG.P_CONT = False
    elif ZG.P_CONT:
        PTR = ZG.P_CONT
        if ((not ZG.SUPER_BRIEF) and (ZG.PLAYER == ZG.WINNER) and (not VERB_p('SAY'))):
            CRLF()
        ZG.P_CONT = False
    else:
        ZG.WINNER = ZG.PLAYER
        ZG.QUOTE_FLAG = False
        if (not FSET_p(LOC(ZG.WINNER), Flag('VEHBIT'))):
            ZG.HERE = LOC(ZG.WINNER)
        ZG.LIT = ZG.LIT_p(ZG.HERE)
        if (not ZG.SUPER_BRIEF):
            CRLF()
        TELL('>')
        READ(ZG.P_INBUF, ZG.P_LEXV)
    ZG.P_LEN = GETB(ZG.P_LEXV, ZG.P_LEXWORDS)
    if (ZG.P_LEN == 0):
        TELL('I beg your pardon?', CR)
        return False
    if ((WRD := GET(ZG.P_LEXV, PTR)) == WORD('oops')):
        if (GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN)) in (WORD('period'), WORD('comma'))):
            PTR = (PTR + ZG.P_LEXELEN)
            ZG.P_LEN = (ZG.P_LEN - 1)
        if (not (ZG.P_LEN > 1)):
            TELL("I can't help your clumsiness.", CR)
            return False
        elif GET(ZG.OOPS_TABLE, ZG.O_PTR):
            if ((ZG.P_LEN > 2) and (GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN)) == WORD('quote'))):
                TELL("Sorry, you can't correct mistakes in quoted text.", CR)
                return False
            elif (ZG.P_LEN > 2):
                TELL('Warning: only the first word after OOPS is used.', CR)
            PUT(ZG.AGAIN_LEXV, GET(ZG.OOPS_TABLE, ZG.O_PTR), GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN)))
            ZG.WINNER = OWINNER
            ZG.INBUF_ADD(GETB(ZG.P_LEXV, ((PTR * ZG.P_LEXELEN) + 6)), GETB(ZG.P_LEXV, ((PTR * ZG.P_LEXELEN) + 7)), ((GET(ZG.OOPS_TABLE, ZG.O_PTR) * ZG.P_LEXELEN) + 3))
            ZG.STUFF(ZG.AGAIN_LEXV, ZG.P_LEXV)
            ZG.P_LEN = GETB(ZG.P_LEXV, ZG.P_LEXWORDS)
            PTR = GET(ZG.OOPS_TABLE, ZG.O_START)
            ZG.INBUF_STUFF(ZG.OOPS_INBUF, ZG.P_INBUF)
        else:
            PUT(ZG.OOPS_TABLE, ZG.O_END, False)
            TELL('There was no word to replace!', CR)
            return False
    else:
        if (not (WRD in (WORD('again'), WORD('g')))):
            ZG.P_NUMBER = 0
        PUT(ZG.OOPS_TABLE, ZG.O_END, False)
    if (GET(ZG.P_LEXV, PTR) in (WORD('again'), WORD('g'))):
        if (GETB(ZG.OOPS_INBUF, 1) == 0):
            TELL('Beg pardon?', CR)
            return False
        elif ZG.P_OFLAG:
            TELL("It's difficult to repeat fragments.", CR)
            return False
        elif (not ZG.P_WON):
            TELL('That would just repeat a mistake.', CR)
            return False
        elif (ZG.P_LEN > 1):
            if ((GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN)) in (WORD('period'), WORD('comma'), WORD('then'))) or (GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN)) == WORD('and'))):
                PTR = (PTR + (2 * ZG.P_LEXELEN))
                PUTB(ZG.P_LEXV, ZG.P_LEXWORDS, (GETB(ZG.P_LEXV, ZG.P_LEXWORDS) - 2))
            else:
                TELL("I couldn't understand that sentence.", CR)
                return False
        else:
            PTR = (PTR + ZG.P_LEXELEN)
            PUTB(ZG.P_LEXV, ZG.P_LEXWORDS, (GETB(ZG.P_LEXV, ZG.P_LEXWORDS) - 1))
        if (GETB(ZG.P_LEXV, ZG.P_LEXWORDS) > 0):
            ZG.STUFF(ZG.P_LEXV, ZG.RESERVE_LEXV)
            ZG.RESERVE_PTR = PTR
        else:
            ZG.RESERVE_PTR = False
        ZG.WINNER = OWINNER
        ZG.P_MERGED = OMERGED
        ZG.INBUF_STUFF(ZG.OOPS_INBUF, ZG.P_INBUF)
        ZG.STUFF(ZG.AGAIN_LEXV, ZG.P_LEXV)
        CNT = -1
        DIR = ZG.AGAIN_DIR
        while True:
            if ((CNT := CNT + 1) > ZG.P_ITBLLEN):
                break
            else:
                PUT(ZG.P_ITBL, CNT, GET(ZG.P_OTBL, CNT))
    else:
        ZG.STUFF(ZG.P_LEXV, ZG.AGAIN_LEXV)
        ZG.INBUF_STUFF(ZG.P_INBUF, ZG.OOPS_INBUF)
        PUT(ZG.OOPS_TABLE, ZG.O_START, PTR)
        PUT(ZG.OOPS_TABLE, ZG.O_LENGTH, (4 * ZG.P_LEN))
        LEN = (2 * (PTR + (ZG.P_LEXELEN * GETB(ZG.P_LEXV, ZG.P_LEXWORDS))))
        PUT(ZG.OOPS_TABLE, ZG.O_END, (GETB(ZG.P_LEXV, (LEN - 1)) + GETB(ZG.P_LEXV, (LEN - 2))))
        ZG.RESERVE_PTR = False
        LEN = ZG.P_LEN
        ZG.P_DIR = False
        ZG.P_NCN = 0
        ZG.P_GETFLAGS = 0
        while True:
            if (ZG._set('P_LEN', (ZG.P_LEN - 1)) < 0):
                ZG.QUOTE_FLAG = False
                break
            elif ((WRD := GET(ZG.P_LEXV, PTR)) or (WRD := ZG.NUMBER_p(PTR))):
                if (ZG.P_LEN == 0):
                    NW = 0
                else:
                    NW = GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN))
                if ((WRD == WORD('to')) and (VERB == SYMBOL('ACT?TELL'))):
                    WRD = WORD('quote')
                elif ((WRD == WORD('then')) and (ZG.P_LEN > 0) and (not VERB) and (not ZG.QUOTE_FLAG)):
                    if (LW in (0, WORD('period'))):
                        WRD = WORD('the')
                    else:
                        PUT(ZG.P_ITBL, ZG.P_VERB, SYMBOL('ACT?TELL'))
                        PUT(ZG.P_ITBL, ZG.P_VERBN, 0)
                        WRD = WORD('quote')
                if (WRD in (WORD('then'), WORD('period'), WORD('quote'))):
                    if (WRD == WORD('quote')):
                        if ZG.QUOTE_FLAG:
                            ZG.QUOTE_FLAG = False
                        else:
                            ZG.QUOTE_FLAG = True
                    ((ZG.P_LEN == 0) or ZG._set('P_CONT', (PTR + ZG.P_LEXELEN)))
                    PUTB(ZG.P_LEXV, ZG.P_LEXWORDS, ZG.P_LEN)
                    break
                elif ((VAL := ZG.WT_p(WRD, PS_DIRECTION, P1_DIRECTION)) and (VERB in (False, SYMBOL('ACT?WALK'))) and ((LEN == 1) or ((LEN == 2) and (VERB == SYMBOL('ACT?WALK'))) or ((NW in (WORD('then'), WORD('period'), WORD('quote'))) and (not (LEN < 2))) or (ZG.QUOTE_FLAG and (LEN == 2) and (NW == WORD('quote'))) or ((LEN > 2) and (NW in (WORD('comma'), WORD('and')))))):
                    DIR = VAL
                    if (NW in (WORD('comma'), WORD('and'))):
                        PUT(ZG.P_LEXV, (PTR + ZG.P_LEXELEN), WORD('then'))
                    if (not (LEN > 2)):
                        ZG.QUOTE_FLAG = False
                        break
                elif ((VAL := ZG.WT_p(WRD, PS_VERB, P1_VERB)) and (not VERB)):
                    VERB = VAL
                    PUT(ZG.P_ITBL, ZG.P_VERB, VAL)
                    PUT(ZG.P_ITBL, ZG.P_VERBN, ZG.P_VTBL)
                    PUT(ZG.P_VTBL, 0, WRD)
                    PUTB(ZG.P_VTBL, 2, GETB(ZG.P_LEXV, (CNT := ((PTR * 2) + 2))))
                    PUTB(ZG.P_VTBL, 3, GETB(ZG.P_LEXV, (CNT + 1)))
                elif ((VAL := ZG.WT_p(WRD, PS_PREPOSITION, 0)) or (WRD in (WORD('all'), WORD('one'))) or ZG.WT_p(WRD, PS_ADJECTIVE) or ZG.WT_p(WRD, PS_OBJECT)):
                    if ((ZG.P_LEN > 1) and (NW == WORD('of')) and (VAL == 0) and (not (WRD in (WORD('all'), WORD('one'), WORD('a'))))):
                        OF_FLAG = True
                    elif ((not (VAL == 0)) and ((ZG.P_LEN == 0) or (NW in (WORD('then'), WORD('period'))))):
                        ZG.P_END_ON_PREP = True
                        if (ZG.P_NCN < 2):
                            PUT(ZG.P_ITBL, ZG.P_PREP1, VAL)
                            PUT(ZG.P_ITBL, ZG.P_PREP1N, WRD)
                    elif (ZG.P_NCN == 2):
                        TELL('There were too many nouns in that sentence.', CR)
                        return False
                    else:
                        ZG.P_NCN = (ZG.P_NCN + 1)
                        ZG.P_ACT = VERB
                        if not (PTR := ZG.CLAUSE(PTR, VAL, WRD)):
                            return False
                        if (PTR < 0):
                            ZG.QUOTE_FLAG = False
                            break
                elif (WRD == WORD('of')):
                    if ((not OF_FLAG) or (NW in (WORD('period'), WORD('then')))):
                        ZG.CANT_USE(PTR)
                        return False
                    else:
                        OF_FLAG = False
                elif ZG.WT_p(WRD, PS_BUZZ_WORD):
                    pass
                elif ((VERB == SYMBOL('ACT?TELL')) and ZG.WT_p(WRD, PS_VERB, P1_VERB) and (ZG.WINNER == ZG.PLAYER)):
                    TELL('Please consult your manual for the correct way to talk to other people\nor creatures.', CR)
                    return False
                else:
                    ZG.CANT_USE(PTR)
                    return False
            else:
                ZG.UNKNOWN_WORD(PTR)
                return False
            LW = WRD
            PTR = (PTR + ZG.P_LEXELEN)
    PUT(ZG.OOPS_TABLE, ZG.O_PTR, False)
    if DIR:
        ZG.PRSA = SYMBOL('V?WALK')
        ZG.PRSO = DIR
        ZG.P_OFLAG = False
        ZG.P_WALK_DIR = DIR
        ZG.AGAIN_DIR = DIR
        return ZG.AGAIN_DIR
    else:
        if ZG.P_OFLAG:
            ZG.ORPHAN_MERGE()
        ZG.P_WALK_DIR = False
        ZG.AGAIN_DIR = False
        if (ZG.SYNTAX_CHECK() and ZG.SNARF_OBJECTS() and ZG.MANY_CHECK() and ZG.TAKE_CHECK()):
            return True
        else:
            return False

# zil: gparser.zil:382  <GLOBAL P-ACT>
# GLOBAL (scratch) P_ACT = False  ->  ZilGlobal.py

# zil: gparser.zil:383  <GLOBAL P-WALK-DIR>
# GLOBAL (scratch) P_WALK_DIR = False  ->  ZilGlobal.py

# zil: gparser.zil:384  <GLOBAL AGAIN-DIR>
# GLOBAL (scratch) AGAIN_DIR = False  ->  ZilGlobal.py

# ;"For AGAIN purposes, put contents of one LEXV table into another."

# zil: gparser.zil:387  <ROUTINE STUFF (SRC DEST "OPTIONAL" (MAX 29) "AUX" (PTR ,P-LEXSTART) (CTR 1) ...
@ZG.routine('STUFF')
def STUFF(SRC, DEST, MAX=None):
    if MAX is None:
        MAX = 29
    PTR = ZG.P_LEXSTART
    CTR = 1
    BPTR = 0
    PUTB(DEST, 0, GETB(SRC, 0))
    PUTB(DEST, 1, GETB(SRC, 1))
    while True:
        PUT(DEST, PTR, GET(SRC, PTR))
        BPTR = ((PTR * 2) + 2)
        PUTB(DEST, BPTR, GETB(SRC, BPTR))
        BPTR = ((PTR * 2) + 3)
        PUTB(DEST, BPTR, GETB(SRC, BPTR))
        PTR = (PTR + ZG.P_LEXELEN)
        if ((CTR := CTR + 1) > MAX):
            return True

# ;"Put contents of one INBUF into another"

# zil: gparser.zil:402  <ROUTINE INBUF-STUFF (SRC DEST "AUX" CNT)>
@ZG.routine('INBUF-STUFF')
def INBUF_STUFF(SRC, DEST):
    CNT = 0
    CNT = (GETB(SRC, 0) - 1)
    while True:
        PUTB(DEST, CNT, GETB(SRC, CNT))
        if ((CNT := CNT - 1) < 0):
            return True

# ;"Put the word in the positions specified from P-INBUF to the end of
# OOPS-INBUF, leaving the appropriate pointers in AGAIN-LEXV"

# zil: gparser.zil:410  <ROUTINE INBUF-ADD (LEN BEG SLOT "AUX" DBEG (CTR 0) TMP)>
@ZG.routine('INBUF-ADD')
def INBUF_ADD(LEN, BEG, SLOT):
    DBEG = 0
    CTR = 0
    TMP = 0
    if (TMP := GET(ZG.OOPS_TABLE, ZG.O_END)):
        DBEG = TMP
    else:
        DBEG = (GETB(ZG.AGAIN_LEXV, (TMP := GET(ZG.OOPS_TABLE, ZG.O_LENGTH))) + GETB(ZG.AGAIN_LEXV, (TMP + 1)))
    PUT(ZG.OOPS_TABLE, ZG.O_END, (DBEG + LEN))
    while True:
        PUTB(ZG.OOPS_INBUF, (DBEG + CTR), GETB(ZG.P_INBUF, (BEG + CTR)))
        CTR = (CTR + 1)
        if (CTR == LEN):
            break
    PUTB(ZG.AGAIN_LEXV, SLOT, DBEG)
    return PUTB(ZG.AGAIN_LEXV, (SLOT - 1), LEN)

# ;"Check whether word pointed at by PTR is the correct part of speech.
#    The second argument is the part of speech (,PS?<part of speech>).  The
#    3rd argument (,P1?<part of speech>), if given, causes the value
#    for that part of speech to be returned."

# zil: gparser.zil:430  <ROUTINE WT? (PTR BIT "OPTIONAL" (B1 5) "AUX" (OFFS ,P-P1OFF) TYP)>
@ZG.routine('WT?')
def WT_p(PTR, BIT, B1=None):
    if B1 is None:
        B1 = 5
    OFFS = ZG.P_P1OFF
    TYP = 0
    if BTST((TYP := GETB(PTR, ZG.P_PSOFF)), BIT):
        if (B1 > 4):
            return True
        else:
            TYP = (TYP & ZG.P_P1BITS)
            if (not (TYP == B1)):
                OFFS = (OFFS + 1)
            return GETB(PTR, OFFS)
    else:
        return False

# ;" Scan through a noun clause, leave a pointer to its starting location"

# zil: gparser.zil:440  <ROUTINE CLAUSE (PTR VAL WRD "AUX" OFF NUM (ANDFLG <>) (FIRST?? T) NW (LW 0))>
@ZG.routine('CLAUSE')
def CLAUSE(PTR, VAL, WRD):
    OFF = 0
    NUM_l = 0
    ANDFLG = False
    FIRST__p = True
    NW = 0
    LW = 0
    OFF = ((ZG.P_NCN - 1) * 2)
    if (not (VAL == 0)):
        PUT(ZG.P_ITBL, (NUM_l := (ZG.P_PREP1 + OFF)), VAL)
        PUT(ZG.P_ITBL, (NUM_l + 1), WRD)
        PTR = (PTR + ZG.P_LEXELEN)
    else:
        ZG.P_LEN = (ZG.P_LEN + 1)
    if (ZG.P_LEN == 0):
        ZG.P_NCN = (ZG.P_NCN - 1)
        return -1
    PUT(ZG.P_ITBL, (NUM_l := (ZG.P_NC1 + OFF)), REST(ZG.P_LEXV, (PTR * 2)))
    if (GET(ZG.P_LEXV, PTR) in (WORD('the'), WORD('a'), WORD('an'))):
        PUT(ZG.P_ITBL, NUM_l, REST(GET(ZG.P_ITBL, NUM_l), 4))
    while True:
        if (ZG._set('P_LEN', (ZG.P_LEN - 1)) < 0):
            PUT(ZG.P_ITBL, (NUM_l + 1), REST(ZG.P_LEXV, (PTR * 2)))
            return -1
        if ((WRD := GET(ZG.P_LEXV, PTR)) or (WRD := ZG.NUMBER_p(PTR))):
            if (ZG.P_LEN == 0):
                NW = 0
            else:
                NW = GET(ZG.P_LEXV, (PTR + ZG.P_LEXELEN))
            if (WRD in (WORD('and'), WORD('comma'))):
                ANDFLG = True
            elif (WRD in (WORD('all'), WORD('one'))):
                if (NW == WORD('of')):
                    ZG.P_LEN = (ZG.P_LEN - 1)
                    PTR = (PTR + ZG.P_LEXELEN)
            elif ((WRD in (WORD('then'), WORD('period'))) or (ZG.WT_p(WRD, PS_PREPOSITION) and GET(ZG.P_ITBL, ZG.P_VERB) and (not FIRST__p))):
                ZG.P_LEN = (ZG.P_LEN + 1)
                PUT(ZG.P_ITBL, (NUM_l + 1), REST(ZG.P_LEXV, (PTR * 2)))
                return (PTR - ZG.P_LEXELEN)
            elif ZG.WT_p(WRD, PS_OBJECT):
                if ((ZG.P_LEN > 0) and (NW == WORD('of')) and (not (WRD in (WORD('all'), WORD('one'))))):
                    pass
                elif (ZG.WT_p(WRD, PS_ADJECTIVE, P1_ADJECTIVE) and (not (NW == 0)) and ZG.WT_p(NW, PS_OBJECT)):
                    pass
                elif ((not ANDFLG) and (not (NW in (WORD('but'), WORD('except')))) and (not (NW in (WORD('and'), WORD('comma'))))):
                    PUT(ZG.P_ITBL, (NUM_l + 1), REST(ZG.P_LEXV, ((PTR + 2) * 2)))
                    return PTR
                else:
                    ANDFLG = False
            elif ((ZG.P_MERGED or ZG.P_OFLAG or (not (GET(ZG.P_ITBL, ZG.P_VERB) == 0))) and (ZG.WT_p(WRD, PS_ADJECTIVE) or ZG.WT_p(WRD, PS_BUZZ_WORD))):
                pass
            elif (ANDFLG and (ZG.WT_p(WRD, PS_DIRECTION) or ZG.WT_p(WRD, PS_VERB))):
                PTR = (PTR - 4)
                PUT(ZG.P_LEXV, (PTR + 2), WORD('then'))
                ZG.P_LEN = (ZG.P_LEN + 2)
            elif ZG.WT_p(WRD, PS_PREPOSITION):
                pass
            else:
                ZG.CANT_USE(PTR)
                return False
        else:
            ZG.UNKNOWN_WORD(PTR)
            return False
        LW = WRD
        FIRST__p = False
        PTR = (PTR + ZG.P_LEXELEN)

# zil: gparser.zil:512  <ROUTINE NUMBER? (PTR "AUX" CNT BPTR CHR (SUM 0) (TIM <>))>
@ZG.routine('NUMBER?')
def NUMBER_p(PTR):
    CNT = 0
    BPTR = 0
    CHR_l = 0
    SUM = 0
    TIM = False
    CNT = GETB(REST(ZG.P_LEXV, (PTR * 2)), 2)
    BPTR = GETB(REST(ZG.P_LEXV, (PTR * 2)), 3)
    while True:
        if ((CNT := (CNT - 1)) < 0):
            break
        else:
            CHR_l = GETB(ZG.P_INBUF, BPTR)
            if (CHR_l == 58):
                TIM = SUM
                SUM = 0
            elif (SUM > 10000):
                return False
            elif ((CHR_l < 58) and (CHR_l > 47)):
                SUM = ((SUM * 10) + (CHR_l - 48))
            else:
                return False
            BPTR = (BPTR + 1)
    PUT(ZG.P_LEXV, PTR, WORD('intnum'))
    if (SUM > 1000):
        return False
    elif TIM:
        if (TIM < 8):
            TIM = (TIM + 12)
        elif (TIM > 23):
            return False
        SUM = (SUM + (TIM * 60))
    ZG.P_NUMBER = SUM
    return WORD('intnum')

# zil: gparser.zil:536  <GLOBAL P-NUMBER>
# GLOBAL (scratch) P_NUMBER = 0  ->  ZilGlobal.py

# zil: gparser.zil:538  <GLOBAL P-DIRECTION>
# GLOBAL (scratch) P_DIRECTION = 0  ->  ZilGlobal.py

# ;"New ORPHAN-MERGE for TRAP Retrofix 6/21/84"

# zil: gparser.zil:543  <ROUTINE ORPHAN-MERGE ("AUX" (CNT -1) TEMP VERB BEG END (ADJ <>) WRD)>
@ZG.routine('ORPHAN-MERGE')
def ORPHAN_MERGE():
    CNT = -1
    TEMP = 0
    VERB = 0
    BEG = 0
    END = 0
    ADJ = False
    WRD = 0
    ZG.P_OFLAG = False
    if ((ZG.WT_p((WRD := GET(GET(ZG.P_ITBL, ZG.P_VERBN), 0)), PS_VERB, P1_VERB) == GET(ZG.P_OTBL, ZG.P_VERB)) or (not (ZG.WT_p(WRD, PS_ADJECTIVE) == 0))):
        ADJ = True
    elif ((not (ZG.WT_p(WRD, PS_OBJECT, P1_OBJECT) == 0)) and (ZG.P_NCN == 0)):
        PUT(ZG.P_ITBL, ZG.P_VERB, 0)
        PUT(ZG.P_ITBL, ZG.P_VERBN, 0)
        PUT(ZG.P_ITBL, ZG.P_NC1, REST(ZG.P_LEXV, 2))
        PUT(ZG.P_ITBL, ZG.P_NC1L, REST(ZG.P_LEXV, 6))
        ZG.P_NCN = 1
    if ((not ((VERB := GET(ZG.P_ITBL, ZG.P_VERB)) == 0)) and (not ADJ) and (not (VERB == GET(ZG.P_OTBL, ZG.P_VERB)))):
        return False
    elif (ZG.P_NCN == 2):
        return False
    elif (GET(ZG.P_OTBL, ZG.P_NC1) == 1):
        if (((TEMP := GET(ZG.P_ITBL, ZG.P_PREP1)) == GET(ZG.P_OTBL, ZG.P_PREP1)) or (TEMP == 0)):
            if ADJ:
                PUT(ZG.P_OTBL, ZG.P_NC1, REST(ZG.P_LEXV, 2))
                if (GET(ZG.P_ITBL, ZG.P_NC1L) == 0):
                    PUT(ZG.P_ITBL, ZG.P_NC1L, REST(ZG.P_LEXV, 6))
                if (ZG.P_NCN == 0):
                    ZG.P_NCN = 1
            else:
                PUT(ZG.P_OTBL, ZG.P_NC1, GET(ZG.P_ITBL, ZG.P_NC1))
            PUT(ZG.P_OTBL, ZG.P_NC1L, GET(ZG.P_ITBL, ZG.P_NC1L))
        else:
            return False
    elif (GET(ZG.P_OTBL, ZG.P_NC2) == 1):
        if (((TEMP := GET(ZG.P_ITBL, ZG.P_PREP1)) == GET(ZG.P_OTBL, ZG.P_PREP2)) or (TEMP == 0)):
            if ADJ:
                PUT(ZG.P_ITBL, ZG.P_NC1, REST(ZG.P_LEXV, 2))
                if (GET(ZG.P_ITBL, ZG.P_NC1L) == 0):
                    PUT(ZG.P_ITBL, ZG.P_NC1L, REST(ZG.P_LEXV, 6))
            PUT(ZG.P_OTBL, ZG.P_NC2, GET(ZG.P_ITBL, ZG.P_NC1))
            PUT(ZG.P_OTBL, ZG.P_NC2L, GET(ZG.P_ITBL, ZG.P_NC1L))
            ZG.P_NCN = 2
        else:
            return False
    elif (not (ZG.P_ACLAUSE == 0)):
        if ((not (ZG.P_NCN == 1)) and (not ADJ)):
            ZG.P_ACLAUSE = False
            return False
        else:
            BEG = GET(ZG.P_ITBL, ZG.P_NC1)
            if ADJ:
                BEG = REST(ZG.P_LEXV, 2)
                ADJ = False
            END = GET(ZG.P_ITBL, ZG.P_NC1L)
            while True:
                WRD = GET(BEG, 0)
                if (BEG == END):
                    if ADJ:
                        ZG.ACLAUSE_WIN(ADJ)
                        break
                    else:
                        ZG.P_ACLAUSE = False
                        return False
                elif ((not ADJ) and (BTST(GETB(WRD, ZG.P_PSOFF), PS_ADJECTIVE) or (WRD in (WORD('all'), WORD('one'))))):
                    ADJ = WRD
                elif (WRD == WORD('one')):
                    ZG.ACLAUSE_WIN(ADJ)
                    break
                elif BTST(GETB(WRD, ZG.P_PSOFF), PS_OBJECT):
                    if (WRD == ZG.P_ANAM):
                        ZG.ACLAUSE_WIN(ADJ)
                    else:
                        ZG.NCLAUSE_WIN()
                    break
                BEG = REST(BEG, ZG.P_WORDLEN)
                if (END == 0):
                    END = BEG
                    ZG.P_NCN = 1
                    PUT(ZG.P_ITBL, ZG.P_NC1, BACK(BEG, 4))
                    PUT(ZG.P_ITBL, ZG.P_NC1L, BEG)
    PUT(ZG.P_VTBL, 0, GET(ZG.P_OVTBL, 0))
    PUTB(ZG.P_VTBL, 2, GETB(ZG.P_OVTBL, 2))
    PUTB(ZG.P_VTBL, 3, GETB(ZG.P_OVTBL, 3))
    PUT(ZG.P_OTBL, ZG.P_VERBN, ZG.P_VTBL)
    PUTB(ZG.P_VTBL, 2, 0)
    while True:
        if ((CNT := (CNT + 1)) > ZG.P_ITBLLEN):
            ZG.P_MERGED = True
            return True
        else:
            PUT(ZG.P_ITBL, CNT, GET(ZG.P_OTBL, CNT))
    return True

# ;"New ACLAUSE-WIN for TRAP retrofix 6/21/84"

# zil: gparser.zil:634  <ROUTINE ACLAUSE-WIN (ADJ)>
@ZG.routine('ACLAUSE-WIN')
def ACLAUSE_WIN(ADJ):
    PUT(ZG.P_ITBL, ZG.P_VERB, GET(ZG.P_OTBL, ZG.P_VERB))
    PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_ACLAUSE)
    PUT(ZG.P_CCTBL, ZG.CC_SEPTR, (ZG.P_ACLAUSE + 1))
    PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_ACLAUSE)
    PUT(ZG.P_CCTBL, ZG.CC_DEPTR, (ZG.P_ACLAUSE + 1))
    ZG.CLAUSE_COPY(ZG.P_OTBL, ZG.P_OTBL, ADJ)
    ((not (GET(ZG.P_OTBL, ZG.P_NC2) == 0)) and ZG._set('P_NCN', 2))
    ZG.P_ACLAUSE = False
    return True

# zil: gparser.zil:645  <ROUTINE NCLAUSE-WIN ()>
@ZG.routine('NCLAUSE-WIN')
def NCLAUSE_WIN():
    PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_NC1)
    PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.P_NC1L)
    PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_ACLAUSE)
    PUT(ZG.P_CCTBL, ZG.CC_DEPTR, (ZG.P_ACLAUSE + 1))
    ZG.CLAUSE_COPY(ZG.P_ITBL, ZG.P_OTBL)
    ((not (GET(ZG.P_OTBL, ZG.P_NC2) == 0)) and ZG._set('P_NCN', 2))
    ZG.P_ACLAUSE = False
    return True

# ;"Print undefined word in input.
#    PTR points to the unknown word in P-LEXV"

# zil: gparser.zil:658  <ROUTINE WORD-PRINT (CNT BUF)>
@ZG.routine('WORD-PRINT')
def WORD_PRINT(CNT, BUF):
    while True:
        if ((CNT := CNT - 1) < 0):
            return True
        else:
            PRINTC(GETB(ZG.P_INBUF, BUF))
            BUF = (BUF + 1)

# zil: gparser.zil:665  <ROUTINE UNKNOWN-WORD (PTR "AUX" BUF)>
@ZG.routine('UNKNOWN-WORD')
def UNKNOWN_WORD(PTR):
    BUF = 0
    PUT(ZG.OOPS_TABLE, ZG.O_PTR, PTR)
    if VERB_p('SAY'):
        TELL('Nothing happens.', CR)
        return False
    TELL('I don\'t know the word "')
    ZG.WORD_PRINT(GETB(REST(ZG.P_LEXV, (BUF := (PTR * 2))), 2), GETB(REST(ZG.P_LEXV, BUF), 3))
    TELL('".', CR)
    ZG.QUOTE_FLAG = False
    ZG.P_OFLAG = False
    return ZG.P_OFLAG

# zil: gparser.zil:677  <ROUTINE CANT-USE (PTR "AUX" BUF)>
@ZG.routine('CANT-USE')
def CANT_USE(PTR):
    BUF = 0
    if VERB_p('SAY'):
        TELL('Nothing happens.', CR)
        return False
    TELL('You used the word "')
    ZG.WORD_PRINT(GETB(REST(ZG.P_LEXV, (BUF := (PTR * 2))), 2), GETB(REST(ZG.P_LEXV, BUF), 3))
    TELL('" in a way that I don\'t understand.', CR)
    ZG.QUOTE_FLAG = False
    ZG.P_OFLAG = False
    return ZG.P_OFLAG

# ;" Perform syntax matching operations, using P-ITBL as the source of
#    the verb and adjectives for this input.  Returns false if no
#    syntax matches, and does it's own orphaning.  If return is true,
#    the syntax is saved in P-SYNTAX."

# zil: gparser.zil:693  <GLOBAL P-SLOCBITS>
# GLOBAL (scratch) P_SLOCBITS = 0  ->  ZilGlobal.py

# zil: gparser.zil:695  <CONSTANT P-SYNLEN>
# CONSTANT (const) P_SYNLEN = 8  ->  ZilGlobal.py

# zil: gparser.zil:697  <CONSTANT P-SBITS>
# CONSTANT (const) P_SBITS = 0  ->  ZilGlobal.py

# zil: gparser.zil:698  <CONSTANT P-SPREP1>
# CONSTANT (const) P_SPREP1 = 1  ->  ZilGlobal.py

# zil: gparser.zil:699  <CONSTANT P-SPREP2>
# CONSTANT (const) P_SPREP2 = 2  ->  ZilGlobal.py

# zil: gparser.zil:700  <CONSTANT P-SFWIM1>
# CONSTANT (const) P_SFWIM1 = 3  ->  ZilGlobal.py

# zil: gparser.zil:701  <CONSTANT P-SFWIM2>
# CONSTANT (const) P_SFWIM2 = 4  ->  ZilGlobal.py

# zil: gparser.zil:702  <CONSTANT P-SLOC1>
# CONSTANT (const) P_SLOC1 = 5  ->  ZilGlobal.py

# zil: gparser.zil:703  <CONSTANT P-SLOC2>
# CONSTANT (const) P_SLOC2 = 6  ->  ZilGlobal.py

# zil: gparser.zil:704  <CONSTANT P-SACTION>
# CONSTANT (const) P_SACTION = 7  ->  ZilGlobal.py

# zil: gparser.zil:705  <CONSTANT P-SONUMS>
# CONSTANT (const) P_SONUMS = 3  ->  ZilGlobal.py

# zil: gparser.zil:707  <ROUTINE SYNTAX-CHECK ("AUX" SYN LEN NUM OBJ (DRIVE1 <>) (DRIVE2 <>) PREP VER...
@ZG.routine('SYNTAX-CHECK')
def SYNTAX_CHECK():
    SYN = 0
    LEN = 0
    NUM_l = 0
    OBJ_l = 0
    DRIVE1 = False
    DRIVE2 = False
    PREP = 0
    VERB = 0
    TMP = 0
    if ((VERB := GET(ZG.P_ITBL, ZG.P_VERB)) == 0):
        TELL('There was no verb in that sentence!', CR)
        return False
    SYN = GET(ZG.VERBS, (255 - VERB))
    LEN = GETB(SYN, 0)
    SYN = REST(SYN)
    while True:
        NUM_l = (GETB(SYN, ZG.P_SBITS) & ZG.P_SONUMS)
        if (ZG.P_NCN > NUM_l):
            pass
        elif ((not (NUM_l < 1)) and (ZG.P_NCN == 0) and (((PREP := GET(ZG.P_ITBL, ZG.P_PREP1)) == 0) or (PREP == GETB(SYN, ZG.P_SPREP1)))):
            DRIVE1 = SYN
        elif (GETB(SYN, ZG.P_SPREP1) == GET(ZG.P_ITBL, ZG.P_PREP1)):
            if ((NUM_l == 2) and (ZG.P_NCN == 1)):
                DRIVE2 = SYN
            elif (GETB(SYN, ZG.P_SPREP2) == GET(ZG.P_ITBL, ZG.P_PREP2)):
                ZG.SYNTAX_FOUND(SYN)
                return True
        if ((LEN := LEN - 1) < 1):
            if (DRIVE1 or DRIVE2):
                break
            else:
                TELL("That sentence isn't one I recognize.", CR)
                return False
        else:
            SYN = REST(SYN, ZG.P_SYNLEN)
    if (DRIVE1 and (OBJ_l := ZG.GWIM(GETB(DRIVE1, ZG.P_SFWIM1), GETB(DRIVE1, ZG.P_SLOC1), GETB(DRIVE1, ZG.P_SPREP1)))):
        PUT(ZG.P_PRSO, ZG.P_MATCHLEN, 1)
        PUT(ZG.P_PRSO, 1, OBJ_l)
        return ZG.SYNTAX_FOUND(DRIVE1)
    elif (DRIVE2 and (OBJ_l := ZG.GWIM(GETB(DRIVE2, ZG.P_SFWIM2), GETB(DRIVE2, ZG.P_SLOC2), GETB(DRIVE2, ZG.P_SPREP2)))):
        PUT(ZG.P_PRSI, ZG.P_MATCHLEN, 1)
        PUT(ZG.P_PRSI, 1, OBJ_l)
        return ZG.SYNTAX_FOUND(DRIVE2)
    elif (VERB == SYMBOL('ACT?FIND')):
        TELL("That question can't be answered.", CR)
        return False
    elif (not (ZG.WINNER == ZG.PLAYER)):
        return ZG.CANT_ORPHAN()
    else:
        ZG.ORPHAN(DRIVE1, DRIVE2)
        TELL('What do you want to ')
        TMP = GET(ZG.P_OTBL, ZG.P_VERBN)
        if (TMP == 0):
            TELL('tell')
        elif (GETB(ZG.P_VTBL, 2) == 0):
            PRINTB(GET(TMP, 0))
        else:
            ZG.WORD_PRINT(GETB(TMP, 2), GETB(TMP, 3))
            PUTB(ZG.P_VTBL, 2, 0)
        if DRIVE2:
            TELL(' ')
            ZG.THING_PRINT(True, True)
        ZG.P_OFLAG = True
        if DRIVE1:
            _tmp1 = GETB(DRIVE1, ZG.P_SPREP1)
        else:
            _tmp1 = GETB(DRIVE2, ZG.P_SPREP2)
        if DRIVE1:
            _tmp2 = GETB(DRIVE1, ZG.P_SPREP1)
        else:
            _tmp2 = GETB(DRIVE2, ZG.P_SPREP2)
        ZG.PREP_PRINT(_tmp2)
        TELL('?', CR)
        return False

# zil: gparser.zil:777  <ROUTINE CANT-ORPHAN ()>
@ZG.routine('CANT-ORPHAN')
def CANT_ORPHAN():
    TELL('"I don\'t understand! What are you referring to?"', CR)
    return False

# zil: gparser.zil:782  <ROUTINE ORPHAN (D1 D2 "AUX" (CNT -1))>
@ZG.routine('ORPHAN')
def ORPHAN(D1, D2):
    CNT = -1
    if (not ZG.P_MERGED):
        PUT(ZG.P_OCLAUSE, ZG.P_MATCHLEN, 0)
    PUT(ZG.P_OVTBL, 0, GET(ZG.P_VTBL, 0))
    PUTB(ZG.P_OVTBL, 2, GETB(ZG.P_VTBL, 2))
    PUTB(ZG.P_OVTBL, 3, GETB(ZG.P_VTBL, 3))
    while True:
        if ((CNT := CNT + 1) > ZG.P_ITBLLEN):
            break
        else:
            PUT(ZG.P_OTBL, CNT, GET(ZG.P_ITBL, CNT))
    if (ZG.P_NCN == 2):
        PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_NC2)
        PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.P_NC2L)
        PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_NC2)
        PUT(ZG.P_CCTBL, ZG.CC_DEPTR, ZG.P_NC2L)
        ZG.CLAUSE_COPY(ZG.P_ITBL, ZG.P_OTBL)
    if (not (ZG.P_NCN < 1)):
        PUT(ZG.P_CCTBL, ZG.CC_SBPTR, ZG.P_NC1)
        PUT(ZG.P_CCTBL, ZG.CC_SEPTR, ZG.P_NC1L)
        PUT(ZG.P_CCTBL, ZG.CC_DBPTR, ZG.P_NC1)
        PUT(ZG.P_CCTBL, ZG.CC_DEPTR, ZG.P_NC1L)
        ZG.CLAUSE_COPY(ZG.P_ITBL, ZG.P_OTBL)
    if D1:
        PUT(ZG.P_OTBL, ZG.P_PREP1, GETB(D1, ZG.P_SPREP1))
        return PUT(ZG.P_OTBL, ZG.P_NC1, 1)
    elif D2:
        PUT(ZG.P_OTBL, ZG.P_PREP2, GETB(D2, ZG.P_SPREP2))
        return PUT(ZG.P_OTBL, ZG.P_NC2, 1)
    else:
        return False

# ;<ROUTINE CLAUSE-PRINT (BPTR EPTR "OPTIONAL" (THE? T))
# 	<BUFFER-PRINT <GET ,P-ITBL .BPTR> <GET ,P-ITBL .EPTR> .THE?>>

# zil: gparser.zil:813  <ROUTINE THING-PRINT (PRSO? "OPTIONAL" (THE? <>) "AUX" BEG END)>
@ZG.routine('THING-PRINT')
def THING_PRINT(PRSO_p_l, THE_p=None):
    if THE_p is None:
        THE_p = False
    BEG = 0
    END = 0
    if PRSO_p_l:
        BEG = GET(ZG.P_ITBL, ZG.P_NC1)
        END = GET(ZG.P_ITBL, ZG.P_NC1L)
    else:
        BEG = GET(ZG.P_ITBL, ZG.P_NC2)
        END = GET(ZG.P_ITBL, ZG.P_NC2L)
    return ZG.BUFFER_PRINT(BEG, END, THE_p)

# zil: gparser.zil:822  <ROUTINE BUFFER-PRINT (BEG END CP "AUX" (NOSP T) WRD (FIRST?? T) (PN <>) (Q? ...
@ZG.routine('BUFFER-PRINT')
def BUFFER_PRINT(BEG, END, CP):
    NOSP = True
    WRD = 0
    FIRST__p = True
    PN = False
    Q_p = False
    while True:
        if (BEG == END):
            return True
        else:
            WRD = GET(BEG, 0)
            if (WRD == WORD('comma')):
                TELL(', ')
            elif NOSP:
                NOSP = False
            else:
                TELL(' ')
            if (WRD in (WORD('period'), WORD('comma'))):
                NOSP = True
            elif (WRD == WORD('me')):
                PRINTD(ZG.ME)
                PN = True
            elif (WRD == WORD('intnum')):
                PRINTN(ZG.P_NUMBER)
                PN = True
            else:
                if (FIRST__p and (not PN) and CP):
                    TELL('the ')
                if (ZG.P_OFLAG or ZG.P_MERGED):
                    PRINTB(WRD)
                elif ((WRD == WORD('it')) and ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT)):
                    PRINTD(ZG.P_IT_OBJECT)
                else:
                    ZG.WORD_PRINT(GETB(BEG, 2), GETB(BEG, 3))
                FIRST__p = False
        BEG = REST(BEG, ZG.P_WORDLEN)

# zil: gparser.zil:854  <ROUTINE PREP-PRINT (PREP "AUX" WRD)>
@ZG.routine('PREP-PRINT')
def PREP_PRINT(PREP):
    WRD = 0
    if (not (PREP == 0)):
        TELL(' ')
        WRD = ZG.PREP_FIND(PREP)
        return PRINTB(WRD)
    else:
        return False

# zil: gparser.zil:863  <ROUTINE CLAUSE-COPY (SRC DEST "OPTIONAL" (INSRT <>) "AUX" BEG END)>
@ZG.routine('CLAUSE-COPY')
def CLAUSE_COPY(SRC, DEST, INSRT=None):
    if INSRT is None:
        INSRT = False
    BEG = 0
    END = 0
    BEG = GET(SRC, GET(ZG.P_CCTBL, ZG.CC_SBPTR))
    END = GET(SRC, GET(ZG.P_CCTBL, ZG.CC_SEPTR))
    PUT(DEST, GET(ZG.P_CCTBL, ZG.CC_DBPTR), REST(ZG.P_OCLAUSE, ((GET(ZG.P_OCLAUSE, ZG.P_MATCHLEN) * ZG.P_LEXELEN) + 2)))
    while True:
        if (BEG == END):
            PUT(DEST, GET(ZG.P_CCTBL, ZG.CC_DEPTR), REST(ZG.P_OCLAUSE, ((GET(ZG.P_OCLAUSE, ZG.P_MATCHLEN) * ZG.P_LEXELEN) + 2)))
            return True
        else:
            if (INSRT and (ZG.P_ANAM == GET(BEG, 0))):
                ZG.CLAUSE_ADD(INSRT)
            ZG.CLAUSE_ADD(GET(BEG, 0))
        BEG = REST(BEG, ZG.P_WORDLEN)

# zil: gparser.zil:885  <ROUTINE CLAUSE-ADD (WRD "AUX" PTR)>
@ZG.routine('CLAUSE-ADD')
def CLAUSE_ADD(WRD):
    PTR = 0
    PTR = (GET(ZG.P_OCLAUSE, ZG.P_MATCHLEN) + 2)
    PUT(ZG.P_OCLAUSE, (PTR - 1), WRD)
    PUT(ZG.P_OCLAUSE, PTR, 0)
    return PUT(ZG.P_OCLAUSE, ZG.P_MATCHLEN, PTR)

# zil: gparser.zil:891  <ROUTINE PREP-FIND (PREP "AUX" (CNT 0) SIZE)>
@ZG.routine('PREP-FIND')
def PREP_FIND(PREP):
    CNT = 0
    SIZE = 0
    SIZE = (GET(ZG.PREPOSITIONS, 0) * 2)
    while True:
        if ((CNT := CNT + 1) > SIZE):
            return False
        elif (GET(ZG.PREPOSITIONS, CNT) == PREP):
            return GET(ZG.PREPOSITIONS, (CNT - 1))

# zil: gparser.zil:898  <ROUTINE SYNTAX-FOUND (SYN)>
@ZG.routine('SYNTAX-FOUND')
def SYNTAX_FOUND(SYN):
    ZG.P_SYNTAX = SYN
    ZG.PRSA = GETB(SYN, ZG.P_SACTION)
    return ZG.PRSA

# zil: gparser.zil:902  <GLOBAL P-GWIMBIT>
# GLOBAL (scratch) P_GWIMBIT = 0  ->  ZilGlobal.py

# zil: gparser.zil:904  <ROUTINE GWIM (GBIT LBIT PREP "AUX" OBJ)>
@ZG.routine('GWIM')
def GWIM(GBIT, LBIT, PREP):
    OBJ_l = 0
    if (GBIT == Flag('RMUNGBIT')):
        return ZG.ROOMS
    ZG.P_GWIMBIT = GBIT
    ZG.P_SLOCBITS = LBIT
    PUT(ZG.P_MERGE, ZG.P_MATCHLEN, 0)
    if ZG.GET_OBJECT(ZG.P_MERGE, False):
        ZG.P_GWIMBIT = 0
        if (GET(ZG.P_MERGE, ZG.P_MATCHLEN) == 1):
            OBJ_l = GET(ZG.P_MERGE, 1)
            TELL('(')
            if ((not (PREP == 0)) and (not ZG.P_END_ON_PREP)):
                PRINTB((PREP := ZG.PREP_FIND(PREP)))
                if (PREP == WORD('out')):
                    TELL(' of')
                TELL(' ')
                if (OBJ_l == ZG.HANDS):
                    TELL('your hands')
                else:
                    TELL('the ', D, OBJ_l)
                TELL(')', CR)
            else:
                TELL(D, OBJ_l, ')', CR)
            return OBJ_l
        else:
            return False
    else:
        ZG.P_GWIMBIT = 0
        return False

# zil: gparser.zil:931  <ROUTINE SNARF-OBJECTS ("AUX" OPTR IPTR L)>
@ZG.routine('SNARF-OBJECTS')
def SNARF_OBJECTS():
    OPTR = 0
    IPTR = 0
    L = 0
    PUT(ZG.P_BUTS, ZG.P_MATCHLEN, 0)
    if (not ((IPTR := GET(ZG.P_ITBL, ZG.P_NC2)) == 0)):
        ZG.P_SLOCBITS = GETB(ZG.P_SYNTAX, ZG.P_SLOC2)
        if not ZG.SNARFEM(IPTR, GET(ZG.P_ITBL, ZG.P_NC2L), ZG.P_PRSI):
            return False
    if (not ((OPTR := GET(ZG.P_ITBL, ZG.P_NC1)) == 0)):
        ZG.P_SLOCBITS = GETB(ZG.P_SYNTAX, ZG.P_SLOC1)
        if not ZG.SNARFEM(OPTR, GET(ZG.P_ITBL, ZG.P_NC1L), ZG.P_PRSO):
            return False
    if (not (GET(ZG.P_BUTS, ZG.P_MATCHLEN) == 0)):
        L = GET(ZG.P_PRSO, ZG.P_MATCHLEN)
        if OPTR:
            ZG.P_PRSO = ZG.BUT_MERGE(ZG.P_PRSO)
        if (IPTR and ((not OPTR) or (L == GET(ZG.P_PRSO, ZG.P_MATCHLEN)))):
            ZG.P_PRSI = ZG.BUT_MERGE(ZG.P_PRSI)
    return True

# zil: gparser.zil:948  <ROUTINE BUT-MERGE (TBL "AUX" LEN BUTLEN (CNT 1) (MATCHES 0) OBJ NTBL)>
@ZG.routine('BUT-MERGE')
def BUT_MERGE(TBL):
    LEN = 0
    BUTLEN = 0
    CNT = 1
    MATCHES = 0
    OBJ_l = 0
    NTBL = 0
    LEN = GET(TBL, ZG.P_MATCHLEN)
    PUT(ZG.P_MERGE, ZG.P_MATCHLEN, 0)
    while True:
        if ((LEN := LEN - 1) < 0):
            break
        elif ZG.ZMEMQ((OBJ_l := GET(TBL, CNT)), ZG.P_BUTS):
            pass
        else:
            PUT(ZG.P_MERGE, (MATCHES + 1), OBJ_l)
            MATCHES = (MATCHES + 1)
        CNT = (CNT + 1)
    PUT(ZG.P_MERGE, ZG.P_MATCHLEN, MATCHES)
    NTBL = ZG.P_MERGE
    ZG.P_MERGE = TBL
    return NTBL

# zil: gparser.zil:963  <GLOBAL P-NAM>
# GLOBAL (scratch) P_NAM = False  ->  ZilGlobal.py

# zil: gparser.zil:964  <GLOBAL P-ADJ>
# GLOBAL (scratch) P_ADJ = False  ->  ZilGlobal.py

# zil: gparser.zil:965  <GLOBAL P-ADVERB>
# GLOBAL (scratch) P_ADVERB = False  ->  ZilGlobal.py

# zil: gparser.zil:966  <GLOBAL P-ADJN>
# GLOBAL (scratch) P_ADJN = False  ->  ZilGlobal.py

# zil: gparser.zil:967  <GLOBAL P-PRSO>
# GLOBAL (scratch) P_PRSO = ITABLE('NONE', 50)  ->  ZilGlobal.py

# zil: gparser.zil:968  <GLOBAL P-PRSI>
# GLOBAL (scratch) P_PRSI = ITABLE('NONE', 50)  ->  ZilGlobal.py

# zil: gparser.zil:969  <GLOBAL P-BUTS>
# GLOBAL (scratch) P_BUTS = ITABLE('NONE', 50)  ->  ZilGlobal.py

# zil: gparser.zil:970  <GLOBAL P-MERGE>
# GLOBAL (scratch) P_MERGE = ITABLE('NONE', 50)  ->  ZilGlobal.py

# zil: gparser.zil:971  <GLOBAL P-OCLAUSE>
# GLOBAL (scratch) P_OCLAUSE = ITABLE('NONE', 100)  ->  ZilGlobal.py

# zil: gparser.zil:972  <GLOBAL P-MATCHLEN>
# GLOBAL (scratch) P_MATCHLEN = 0  ->  ZilGlobal.py

# zil: gparser.zil:973  <GLOBAL P-GETFLAGS>
# GLOBAL (scratch) P_GETFLAGS = 0  ->  ZilGlobal.py

# zil: gparser.zil:974  <CONSTANT P-ALL>
# CONSTANT (const) P_ALL = 1  ->  ZilGlobal.py

# zil: gparser.zil:975  <CONSTANT P-ONE>
# CONSTANT (const) P_ONE = 2  ->  ZilGlobal.py

# zil: gparser.zil:976  <CONSTANT P-INHIBIT>
# CONSTANT (const) P_INHIBIT = 4  ->  ZilGlobal.py

# zil: gparser.zil:979  <GLOBAL P-AND>
# GLOBAL (scratch) P_AND = False  ->  ZilGlobal.py

# zil: gparser.zil:981  <ROUTINE SNARFEM (PTR EPTR TBL "AUX" (BUT <>) LEN WV WRD NW (WAS-ALL <>))>
@ZG.routine('SNARFEM')
def SNARFEM(PTR, EPTR, TBL):
    BUT = False
    LEN = 0
    WV = 0
    WRD = 0
    NW = 0
    WAS_ALL = False
    ZG.P_AND = False
    if (ZG.P_GETFLAGS == ZG.P_ALL):
        WAS_ALL = True
    ZG.P_GETFLAGS = 0
    PUT(TBL, ZG.P_MATCHLEN, 0)
    WRD = GET(PTR, 0)
    while True:
        if (PTR == EPTR):
            WV = ZG.GET_OBJECT((BUT or TBL))
            if WAS_ALL:
                ZG.P_GETFLAGS = ZG.P_ALL
            return WV
        else:
            if (EPTR == REST(PTR, ZG.P_WORDLEN)):
                NW = 0
            else:
                NW = GET(PTR, ZG.P_LEXELEN)
            if (WRD == WORD('all')):
                ZG.P_GETFLAGS = ZG.P_ALL
                if (NW == WORD('of')):
                    PTR = REST(PTR, ZG.P_WORDLEN)
            elif (WRD in (WORD('but'), WORD('except'))):
                if not ZG.GET_OBJECT((BUT or TBL)):
                    return False
                BUT = ZG.P_BUTS
                PUT(BUT, ZG.P_MATCHLEN, 0)
            elif (WRD in (WORD('a'), WORD('one'))):
                if (not ZG.P_ADJ):
                    ZG.P_GETFLAGS = ZG.P_ONE
                    if (NW == WORD('of')):
                        PTR = REST(PTR, ZG.P_WORDLEN)
                else:
                    ZG.P_NAM = ZG.P_ONEOBJ
                    if not ZG.GET_OBJECT((BUT or TBL)):
                        return False
                    if (NW == 0):
                        return True
            elif ((WRD in (WORD('and'), WORD('comma'))) and (not (NW in (WORD('and'), WORD('comma'))))):
                ZG.P_AND = True
                if not ZG.GET_OBJECT((BUT or TBL)):
                    return False
            elif ZG.WT_p(WRD, PS_BUZZ_WORD):
                pass
            elif (WRD in (WORD('and'), WORD('comma'))):
                pass
            elif (WRD == WORD('of')):
                if (ZG.P_GETFLAGS == 0):
                    ZG.P_GETFLAGS = ZG.P_INHIBIT
            elif ((WV := ZG.WT_p(WRD, PS_ADJECTIVE, P1_ADJECTIVE)) and (not ZG.P_ADJ)):
                ZG.P_ADJ = WV
                ZG.P_ADJN = WRD
            elif ZG.WT_p(WRD, PS_OBJECT, P1_OBJECT):
                ZG.P_NAM = WRD
                ZG.P_ONEOBJ = WRD
        if (not (PTR == EPTR)):
            PTR = REST(PTR, ZG.P_WORDLEN)
            WRD = NW

# zil: gparser.zil:1035  <CONSTANT SH>
# CONSTANT (const) SH = 128  ->  ZilGlobal.py

# zil: gparser.zil:1036  <CONSTANT SC>
# CONSTANT (const) SC = 64  ->  ZilGlobal.py

# zil: gparser.zil:1037  <CONSTANT SIR>
# CONSTANT (const) SIR = 32  ->  ZilGlobal.py

# zil: gparser.zil:1038  <CONSTANT SOG>
# CONSTANT (const) SOG = 16  ->  ZilGlobal.py

# zil: gparser.zil:1039  <CONSTANT STAKE>
# CONSTANT (const) STAKE = 8  ->  ZilGlobal.py

# zil: gparser.zil:1040  <CONSTANT SMANY>
# CONSTANT (const) SMANY = 4  ->  ZilGlobal.py

# zil: gparser.zil:1041  <CONSTANT SHAVE>
# CONSTANT (const) SHAVE = 2  ->  ZilGlobal.py

# zil: gparser.zil:1043  <ROUTINE GET-OBJECT (TBL "OPTIONAL" (VRB T) "AUX" BITS LEN XBITS TLEN (GCHECK...
@ZG.routine('GET-OBJECT')
def GET_OBJECT(TBL, VRB=None):
    if VRB is None:
        VRB = True
    BITS = 0
    LEN = 0
    XBITS = 0
    TLEN = 0
    GCHECK = False
    OLEN = 0
    OBJ_l = 0
    XBITS = ZG.P_SLOCBITS
    TLEN = GET(TBL, ZG.P_MATCHLEN)
    if BTST(ZG.P_GETFLAGS, ZG.P_INHIBIT):
        return True
    if ((not ZG.P_NAM) and ZG.P_ADJ):
        if ZG.WT_p(ZG.P_ADJN, PS_OBJECT, P1_OBJECT):
            ZG.P_NAM = ZG.P_ADJN
            ZG.P_ADJ = False
        elif (BITS := ZG.WT_p(ZG.P_ADJN, PS_DIRECTION, P1_DIRECTION)):
            ZG.P_ADJ = False
            PUT(TBL, ZG.P_MATCHLEN, 1)
            PUT(TBL, 1, ZG.INTDIR)
            ZG.P_DIRECTION = BITS
            return True
    if ((not ZG.P_NAM) and (not ZG.P_ADJ) and (not (ZG.P_GETFLAGS == ZG.P_ALL)) and (ZG.P_GWIMBIT == 0)):
        if VRB:
            TELL('There seems to be a noun missing in that sentence!', CR)
        return False
    if ((not (ZG.P_GETFLAGS == ZG.P_ALL)) or (ZG.P_SLOCBITS == 0)):
        ZG.P_SLOCBITS = -1
    ZG.P_TABLE = TBL
    while True:
        if GCHECK:
            ZG.GLOBAL_CHECK(TBL)
        else:
            if ZG.LIT:
                FCLEAR(ZG.PLAYER, Flag('TRANSBIT'))
                ZG.DO_SL(ZG.HERE, ZG.SOG, ZG.SIR)
                FSET(ZG.PLAYER, Flag('TRANSBIT'))
            ZG.DO_SL(ZG.PLAYER, ZG.SH, ZG.SC)
        LEN = (GET(TBL, ZG.P_MATCHLEN) - TLEN)
        if BTST(ZG.P_GETFLAGS, ZG.P_ALL):
            pass
        elif (BTST(ZG.P_GETFLAGS, ZG.P_ONE) and (not (LEN == 0))):
            if (not (LEN == 1)):
                PUT(TBL, 1, GET(TBL, RANDOM(LEN)))
                TELL('(How about the ')
                PRINTD(GET(TBL, 1))
                TELL('?)', CR)
            PUT(TBL, ZG.P_MATCHLEN, 1)
        elif ((LEN > 1) or ((LEN == 0) and (not (ZG.P_SLOCBITS == -1)))):
            if (ZG.P_SLOCBITS == -1):
                ZG.P_SLOCBITS = XBITS
                OLEN = LEN
                PUT(TBL, ZG.P_MATCHLEN, (GET(TBL, ZG.P_MATCHLEN) - LEN))
                continue
            else:
                if (LEN == 0):
                    LEN = OLEN
                if (not (ZG.WINNER == ZG.PLAYER)):
                    ZG.CANT_ORPHAN()
                    return False
                elif (VRB and ZG.P_NAM):
                    ZG.WHICH_PRINT(TLEN, LEN, TBL)
                    if (TBL == ZG.P_PRSO):
                        ZG.P_ACLAUSE = ZG.P_NC1
                    else:
                        ZG.P_ACLAUSE = ZG.P_NC2
                    ZG.P_AADJ = ZG.P_ADJ
                    ZG.P_ANAM = ZG.P_NAM
                    ZG.ORPHAN(False, False)
                    ZG.P_OFLAG = True
                elif VRB:
                    TELL('There seems to be a noun missing in that sentence!', CR)
                ZG.P_NAM = False
                ZG.P_ADJ = False
                return False
        if ((LEN == 0) and GCHECK):
            if VRB:
                ZG.P_SLOCBITS = XBITS
                if (ZG.LIT or VERB_p('TELL')):
                    ZG.OBJ_FOUND(ZG.NOT_HERE_OBJECT, TBL)
                    ZG.P_XNAM = ZG.P_NAM
                    ZG.P_XADJ = ZG.P_ADJ
                    ZG.P_XADJN = ZG.P_ADJN
                    ZG.P_NAM = False
                    ZG.P_ADJ = False
                    ZG.P_ADJN = False
                    return True
                else:
                    TELL("It's too dark to see!", CR)
            ZG.P_NAM = False
            ZG.P_ADJ = False
            return False
        elif (LEN == 0):
            GCHECK = True
            continue
        ZG.P_SLOCBITS = XBITS
        ZG.P_NAM = False
        ZG.P_ADJ = False
        return True
        break

# ;<ROUTINE MOBY-FIND (TBL "AUX" FOO LEN)
# 	 <SETG P-SLOCBITS -1>
# 	 <SETG P-NAM ,P-XNAM>
# 	 <SETG P-ADJ ,P-XADJ>
# 	 <PUT .TBL ,P-MATCHLEN 0>
# 	 <SET FOO <FIRST? ,ROOMS>>
# 	 <REPEAT ()
# 		 <COND (<NOT .FOO> <RETURN>)
# 		       (T
# 			<SEARCH-LIST .FOO .TBL ,P-SRCALL>
# 			<SET FOO <NEXT? .FOO>>)>>
# 	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 0>
# 		<DO-SL ,LOCAL-GLOBALS 1 1>)>
# 	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 0>
# 		<DO-SL ,ROOMS 1 1>)>
# 	 <COND (<EQUAL? <SET LEN <GET .TBL ,P-MATCHLEN>> 1>
# 		<SETG P-MOBY-FOUND <GET .TBL 1>>)>
# 	 <SETG P-NAM <>>
# 	 <SETG P-ADJ <>>
# 	 .LEN>

# ;<GLOBAL P-MOBY-FOUND <>>

# zil: gparser.zil:1167  <GLOBAL P-XNAM>
# GLOBAL (scratch) P_XNAM = False  ->  ZilGlobal.py

# zil: gparser.zil:1168  <GLOBAL P-XADJ>
# GLOBAL (scratch) P_XADJ = False  ->  ZilGlobal.py

# zil: gparser.zil:1169  <GLOBAL P-XADJN>
# GLOBAL (scratch) P_XADJN = False  ->  ZilGlobal.py

# zil: gparser.zil:1171  <ROUTINE WHICH-PRINT (TLEN LEN TBL "AUX" OBJ RLEN)>
@ZG.routine('WHICH-PRINT')
def WHICH_PRINT(TLEN, LEN, TBL):
    OBJ_l = 0
    RLEN = 0
    RLEN = LEN
    TELL('Which ')
    if (ZG.P_OFLAG or ZG.P_MERGED or ZG.P_AND):
        if ZG.P_NAM:
            _tmp1 = ZG.P_NAM
        elif ZG.P_ADJ:
            _tmp1 = ZG.P_ADJN
        else:
            _tmp1 = WORD('one')
        if ZG.P_NAM:
            _tmp2 = ZG.P_NAM
        elif ZG.P_ADJ:
            _tmp2 = ZG.P_ADJN
        else:
            _tmp2 = WORD('one')
        PRINTB(_tmp2)
    else:
        ZG.THING_PRINT((TBL == ZG.P_PRSO))
    TELL(' do you mean, ')
    while True:
        TLEN = (TLEN + 1)
        OBJ_l = GET(TBL, TLEN)
        TELL('the ', D, OBJ_l)
        if (LEN == 2):
            if (not (RLEN == 2)):
                TELL(',')
            TELL(' or ')
        elif (LEN > 2):
            TELL(', ')
        if ((LEN := (LEN - 1)) < 1):
            TELL('?', CR)
            return True

# zil: gparser.zil:1194  <ROUTINE GLOBAL-CHECK (TBL "AUX" LEN RMG RMGL (CNT 0) OBJ OBITS FOO)>
@ZG.routine('GLOBAL-CHECK')
def GLOBAL_CHECK(TBL):
    LEN = 0
    RMG = 0
    RMGL = 0
    CNT = 0
    OBJ_l = 0
    OBITS = 0
    FOO = 0
    LEN = GET(TBL, ZG.P_MATCHLEN)
    OBITS = ZG.P_SLOCBITS
    if (RMG := GETPT(ZG.HERE, 'GLOBAL')):
        RMGL = (PTSIZE(RMG) - 1)
        while True:
            if ZG.THIS_IT_p((OBJ_l := GETB(RMG, CNT)), TBL):
                ZG.OBJ_FOUND(OBJ_l, TBL)
            if ((CNT := CNT + 1) > RMGL):
                break
    if (RMG := GETPT(ZG.HERE, 'PSEUDO')):
        RMGL = ((PTSIZE(RMG) // 4) - 1)
        CNT = 0
        while True:
            if (ZG.P_NAM == GET(RMG, (CNT * 2))):
                PUTP(ZG.PSEUDO_OBJECT, 'ACTION', GET(RMG, ((CNT * 2) + 1)))
                FOO = BACK(GETPT(ZG.PSEUDO_OBJECT, 'ACTION'), 5)
                PUT(FOO, 0, GET(ZG.P_NAM, 0))
                PUT(FOO, 1, GET(ZG.P_NAM, 1))
                ZG.OBJ_FOUND(ZG.PSEUDO_OBJECT, TBL)
                break
            elif ((CNT := CNT + 1) > RMGL):
                break
    if (GET(TBL, ZG.P_MATCHLEN) == LEN):
        ZG.P_SLOCBITS = -1
        ZG.P_TABLE = TBL
        ZG.DO_SL(ZG.GLOBAL_OBJECTS, 1, 1)
        ZG.P_SLOCBITS = OBITS
        if ((GET(TBL, ZG.P_MATCHLEN) == 0) and (ZG.PRSA in (SYMBOL('V?LOOK-INSIDE'), SYMBOL('V?SEARCH'), SYMBOL('V?EXAMINE')))):
            return ZG.DO_SL(ZG.ROOMS, 1, 1)
        else:
            return False
    else:
        return False

# zil: gparser.zil:1227  <ROUTINE DO-SL (OBJ BIT1 BIT2 "AUX" BTS)>
@ZG.routine('DO-SL')
def DO_SL(OBJ_l, BIT1, BIT2):
    BTS = 0
    if BTST(ZG.P_SLOCBITS, (BIT1 + BIT2)):
        return ZG.SEARCH_LIST(OBJ_l, ZG.P_TABLE, ZG.P_SRCALL)
    else:
        if BTST(ZG.P_SLOCBITS, BIT1):
            return ZG.SEARCH_LIST(OBJ_l, ZG.P_TABLE, ZG.P_SRCTOP)
        elif BTST(ZG.P_SLOCBITS, BIT2):
            return ZG.SEARCH_LIST(OBJ_l, ZG.P_TABLE, ZG.P_SRCBOT)
        else:
            return True

# zil: gparser.zil:1237  <CONSTANT P-SRCBOT>
# CONSTANT (const) P_SRCBOT = 2  ->  ZilGlobal.py

# zil: gparser.zil:1238  <CONSTANT P-SRCTOP>
# CONSTANT (const) P_SRCTOP = 0  ->  ZilGlobal.py

# zil: gparser.zil:1239  <CONSTANT P-SRCALL>
# CONSTANT (const) P_SRCALL = 1  ->  ZilGlobal.py

# zil: gparser.zil:1241  <ROUTINE SEARCH-LIST (OBJ TBL LVL "AUX" FLS NOBJ)>
@ZG.routine('SEARCH-LIST')
def SEARCH_LIST(OBJ_l, TBL, LVL):
    FLS = 0
    NOBJ = 0
    if (OBJ_l := FIRST_p(OBJ_l)):
        while True:
            if ((not (LVL == ZG.P_SRCBOT)) and GETPT(OBJ_l, 'SYNONYM') and ZG.THIS_IT_p(OBJ_l, TBL)):
                ZG.OBJ_FOUND(OBJ_l, TBL)
            if (((not (LVL == ZG.P_SRCTOP)) or FSET_p(OBJ_l, Flag('SEARCHBIT')) or FSET_p(OBJ_l, Flag('SURFACEBIT'))) and (NOBJ := FIRST_p(OBJ_l)) and (FSET_p(OBJ_l, Flag('OPENBIT')) or FSET_p(OBJ_l, Flag('TRANSBIT')))):
                if FSET_p(OBJ_l, Flag('SURFACEBIT')):
                    _tmp1 = ZG.P_SRCALL
                elif FSET_p(OBJ_l, Flag('SEARCHBIT')):
                    _tmp1 = ZG.P_SRCALL
                else:
                    _tmp1 = ZG.P_SRCTOP
                if FSET_p(OBJ_l, Flag('SURFACEBIT')):
                    _tmp2 = ZG.P_SRCALL
                elif FSET_p(OBJ_l, Flag('SEARCHBIT')):
                    _tmp2 = ZG.P_SRCALL
                else:
                    _tmp2 = ZG.P_SRCTOP
                FLS = ZG.SEARCH_LIST(OBJ_l, TBL, _tmp2)
            if (OBJ_l := NEXT_p(OBJ_l)):
                pass
            else:
                return True
    else:
        return False

# zil: gparser.zil:1264  <ROUTINE OBJ-FOUND (OBJ TBL "AUX" PTR)>
@ZG.routine('OBJ-FOUND')
def OBJ_FOUND(OBJ_l, TBL):
    PTR = 0
    PTR = GET(TBL, ZG.P_MATCHLEN)
    PUT(TBL, (PTR + 1), OBJ_l)
    return PUT(TBL, ZG.P_MATCHLEN, (PTR + 1))

# zil: gparser.zil:1269  <ROUTINE TAKE-CHECK ()>
@ZG.routine('TAKE-CHECK')
def TAKE_CHECK():
    return (ZG.ITAKE_CHECK(ZG.P_PRSO, GETB(ZG.P_SYNTAX, ZG.P_SLOC1)) and ZG.ITAKE_CHECK(ZG.P_PRSI, GETB(ZG.P_SYNTAX, ZG.P_SLOC2)))

# zil: gparser.zil:1273  <ROUTINE ITAKE-CHECK (TBL IBITS "AUX" PTR OBJ TAKEN)>
@ZG.routine('ITAKE-CHECK')
def ITAKE_CHECK(TBL, IBITS):
    PTR = 0
    OBJ_l = 0
    TAKEN = 0
    if ((PTR := GET(TBL, ZG.P_MATCHLEN)) and (BTST(IBITS, ZG.SHAVE) or BTST(IBITS, ZG.STAKE))):
        while True:
            if ((PTR := (PTR - 1)) < 0):
                return True
            else:
                OBJ_l = GET(TBL, (PTR + 1))
                if (OBJ_l == ZG.IT):
                    if (not ZG.ACCESSIBLE_p(ZG.P_IT_OBJECT)):
                        TELL("I don't see what you're referring to.", CR)
                        return False
                    else:
                        OBJ_l = ZG.P_IT_OBJECT
                if ((not ZG.HELD_p(OBJ_l)) and (not (OBJ_l in (ZG.HANDS, ZG.ME)))):
                    ZG.PRSO = OBJ_l
                    if FSET_p(OBJ_l, Flag('TRYTAKEBIT')):
                        TAKEN = True
                    elif (not (ZG.WINNER == ZG.ADVENTURER)):
                        TAKEN = False
                    elif (BTST(IBITS, ZG.STAKE) and (ZG.ITAKE(False) == True)):
                        TAKEN = False
                    else:
                        TAKEN = True
                    if (TAKEN and BTST(IBITS, ZG.SHAVE) and (ZG.WINNER == ZG.ADVENTURER)):
                        if (OBJ_l == ZG.NOT_HERE_OBJECT):
                            TELL("You don't have that!", CR)
                            return False
                        TELL("You don't have the ")
                        PRINTD(OBJ_l)
                        TELL('.', CR)
                        return False
                    elif ((not TAKEN) and (ZG.WINNER == ZG.ADVENTURER)):
                        TELL('(Taken)', CR)
    else:
        return True

# zil: gparser.zil:1319  <ROUTINE MANY-CHECK ("AUX" (LOSS <>) TMP)>
@ZG.routine('MANY-CHECK')
def MANY_CHECK():
    LOSS = False
    TMP = 0
    if ((GET(ZG.P_PRSO, ZG.P_MATCHLEN) > 1) and (not BTST(GETB(ZG.P_SYNTAX, ZG.P_SLOC1), ZG.SMANY))):
        LOSS = 1
    elif ((GET(ZG.P_PRSI, ZG.P_MATCHLEN) > 1) and (not BTST(GETB(ZG.P_SYNTAX, ZG.P_SLOC2), ZG.SMANY))):
        LOSS = 2
    if LOSS:
        TELL("You can't use multiple ")
        if (LOSS == 2):
            TELL('in')
        TELL('direct objects with "')
        TMP = GET(ZG.P_ITBL, ZG.P_VERBN)
        if (TMP == 0):
            TELL('tell')
        elif (ZG.P_OFLAG or ZG.P_MERGED):
            PRINTB(GET(TMP, 0))
        else:
            ZG.WORD_PRINT(GETB(TMP, 2), GETB(TMP, 3))
        TELL('".', CR)
        return False
    else:
        return True

# zil: gparser.zil:1340  <ROUTINE ZMEMQ (ITM TBL "OPTIONAL" (SIZE -1) "AUX" (CNT 1))>
@ZG.routine('ZMEMQ')
def ZMEMQ(ITM, TBL, SIZE=None):
    if SIZE is None:
        SIZE = -1
    CNT = 1
    if (not TBL):
        return False
    if (not (SIZE < 0)):
        CNT = 0
    else:
        SIZE = GET(TBL, 0)
    while True:
        if (ITM == GET(TBL, CNT)):
            return REST(TBL, (CNT * 2))
        elif ((CNT := CNT + 1) > SIZE):
            return False

# zil: gparser.zil:1349  <ROUTINE ZMEMQB (ITM TBL SIZE "AUX" (CNT 0))>
@ZG.routine('ZMEMQB')
def ZMEMQB(ITM, TBL, SIZE):
    CNT = 0
    while True:
        if (ITM == GETB(TBL, CNT)):
            return True
        elif ((CNT := CNT + 1) > SIZE):
            return False

# zil: gparser.zil:1356  <GLOBAL ALWAYS-LIT>
# GLOBAL (scratch) ALWAYS_LIT = False  ->  ZilGlobal.py

# zil: gparser.zil:1358  <ROUTINE LIT? (RM "OPTIONAL" (RMBIT T) "AUX" OHERE (LIT <>))>
@ZG.routine('LIT?')
def LIT_p(RM, RMBIT=None):
    if RMBIT is None:
        RMBIT = True
    OHERE = 0
    LIT = False
    if (ZG.ALWAYS_LIT and (ZG.WINNER == ZG.PLAYER)):
        return True
    ZG.P_GWIMBIT = Flag('ONBIT')
    OHERE = ZG.HERE
    ZG.HERE = RM
    if (RMBIT and FSET_p(RM, Flag('ONBIT'))):
        LIT = True
    else:
        PUT(ZG.P_MERGE, ZG.P_MATCHLEN, 0)
        ZG.P_TABLE = ZG.P_MERGE
        ZG.P_SLOCBITS = -1
        if (OHERE == RM):
            ZG.DO_SL(ZG.WINNER, 1, 1)
            if ((not (ZG.WINNER == ZG.PLAYER)) and IN_p(ZG.PLAYER, RM)):
                ZG.DO_SL(ZG.PLAYER, 1, 1)
        ZG.DO_SL(RM, 1, 1)
        if (GET(ZG.P_TABLE, ZG.P_MATCHLEN) > 0):
            LIT = True
    ZG.HERE = OHERE
    ZG.P_GWIMBIT = 0
    return LIT

# ;<ROUTINE PRSO-PRINT ("AUX" PTR)
# 	 <COND (<OR ,P-MERGED
# 		    <EQUAL? <GET <SET PTR <GET ,P-ITBL ,P-NC1>> 0> ,W?IT>>
# 		<TELL " " D ,PRSO>)
# 	       (T <BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC1L> <>>)>>

# ;<ROUTINE PRSI-PRINT ("AUX" PTR)
# 	 <COND (<OR ,P-MERGED
# 		    <EQUAL? <GET <SET PTR <GET ,P-ITBL ,P-NC2>> 0> ,W?IT>>
# 		<TELL " " D ,PRSO>)
# 	       (T <BUFFER-PRINT .PTR <GET ,P-ITBL ,P-NC2L> <>>)>>

# ;"former CRUFTY routine, re-written by SWG"

# zil: gparser.zil:1396  <ROUTINE THIS-IT? (OBJ TBL "AUX" SYNS)>
@ZG.routine('THIS-IT?')
def THIS_IT_p(OBJ_l, TBL):
    SYNS = 0
    if FSET_p(OBJ_l, Flag('INVISIBLE')):
        return False
    elif (ZG.P_NAM and (not ZG.ZMEMQ(ZG.P_NAM, (SYNS := GETPT(OBJ_l, 'SYNONYM')), ((PTSIZE(SYNS) // 2) - 1)))):
        return False
    elif (ZG.P_ADJ and ((not (SYNS := GETPT(OBJ_l, 'ADJECTIVE'))) or (not ZG.ZMEMQB(ZG.P_ADJ, SYNS, (PTSIZE(SYNS) - 1))))):
        return False
    elif ((not (ZG.P_GWIMBIT == 0)) and (not FSET_p(OBJ_l, ZG.P_GWIMBIT))):
        return False
    return True

# zil: gparser.zil:1411  <ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>))>
@ZG.routine('ACCESSIBLE?')
def ACCESSIBLE_p(OBJ_l):
    L = LOC(OBJ_l)
    # ;"can player TOUCH object?"
    # ;"revised 5/2/84 by SEM and SWG"
    if FSET_p(OBJ_l, Flag('INVISIBLE')):
        return False
    elif (not L):
        return False
    elif (L == ZG.GLOBAL_OBJECTS):
        return True
    elif ((L == ZG.LOCAL_GLOBALS) and ZG.GLOBAL_IN_p(OBJ_l, ZG.HERE)):
        return True
    elif (not (ZG.META_LOC(OBJ_l) in (ZG.HERE, LOC(ZG.WINNER)))):
        return False
    elif (L in (ZG.WINNER, ZG.HERE, LOC(ZG.WINNER))):
        return True
    elif (FSET_p(L, Flag('OPENBIT')) and ZG.ACCESSIBLE_p(L)):
        return True
    else:
        return False

# zil: gparser.zil:1437  <ROUTINE META-LOC (OBJ)>
@ZG.routine('META-LOC')
def META_LOC(OBJ_l):
    while True:
        if (not OBJ_l):
            return False
        elif IN_p(OBJ_l, ZG.GLOBAL_OBJECTS):
            return ZG.GLOBAL_OBJECTS
        if IN_p(OBJ_l, ZG.ROOMS):
            return OBJ_l
        else:
            OBJ_l = LOC(OBJ_l)
