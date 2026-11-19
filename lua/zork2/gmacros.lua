-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- C_ENABLED_p is declared in ZilGlobal.lua

-- C_ENABLED is declared in ZilGlobal.lua

-- C_DISABLED is declared in ZilGlobal.lua

-- ---- DEFMAC TELL (gmacros.zil:9-50) ---------------------------------
-- このマクロは展開しない。呼び出しは TELL(...) のまま残し、ランタイムの TELL が
-- 書式指定子を解釈する (書式指定子とルーチンの対応は、この定義から読み取る)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC TELL ("ARGS" A)
-- 	<FORM PROG ()
-- 	      !<MAPF ,LIST
-- 		     <FUNCTION ("AUX" E P O)
-- 			  <COND (<EMPTY? .A> <MAPSTOP>)
-- 				(<SET E <NTH .A 1>>
-- 				 <SET A <REST .A>>)>
-- 			  <COND (<TYPE? .E ATOM>
-- 				 <COND (<OR <=? <SET P <SPNAME .E>>
-- 						"CRLF">
-- 					    <=? .P "CR">>
-- 					<MAPRET '<CRLF>>)
-- 				       (<EMPTY? .A>
-- 					<ERROR INDICATOR-AT-END? .E>)
-- 				       (ELSE
-- 					<SET O <NTH .A 1>>
-- 					<SET A <REST .A>>
-- 					<COND (<OR <=? <SET P <SPNAME .E>>
-- 						       "DESC">
-- 						   <=? .P "D">
-- 						   <=? .P "OBJ">
-- 						   <=? .P "O">>
-- 					       <MAPRET <FORM PRINTD .O>>)
-- 					      (<OR <=? .P "A">
-- 						   <=? .P "AN">>
-- 					       <MAPRET <FORM PRINTA .O>>)
-- 					      (<OR <=? .P "NUM">
-- 						   <=? .P "N">>
-- 					       <MAPRET <FORM PRINTN .O>>)
-- 					      (<OR <=? .P "CHAR">
-- 						   <=? .P "CHR">
-- 						   <=? .P "C">>
-- 					       <MAPRET <FORM PRINTC .O>>)
-- 					      (ELSE
-- 					       <MAPRET
-- 						 <FORM PRINT
-- 						       <FORM GETP .O .E>>>)>)>)
-- 				(<TYPE? .E STRING ZSTRING>
-- 				 <MAPRET <FORM PRINTI .E>>)
-- 				(<TYPE? .E FORM LVAL GVAL>
-- 				 <MAPRET <FORM PRINT .E>>)
-- 				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>
-- ---------------------------------------------------------------------

-- ;<ROUTINE PRINTA (O)
-- 	 <TELL "a " D .O>>

-- ---- DEFMAC VERB? (gmacros.zil:55-56) -------------------------------
-- このマクロは、ランタイムの組み込み VERB_p を使う (定義を比べて、同じ意味だと確かめた)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC VERB? ("ARGS" ATMS)
-- 	<MULTIFROB PRSA .ATMS>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC PRSO? (gmacros.zil:58-59) -------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC PRSO? ("ARGS" ATMS)
-- 	<MULTIFROB PRSO .ATMS>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC PRSI? (gmacros.zil:61-62) -------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC PRSI? ("ARGS" ATMS)
-- 	<MULTIFROB PRSI .ATMS>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC ROOM? (gmacros.zil:64-65) -------------------------------
-- 同じ名前の ROUTINE があるため、このマクロは使われない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC ROOM? ("ARGS" ATMS)
-- 	<MULTIFROB HERE .ATMS>>
-- ---------------------------------------------------------------------

-- ---- DEFINE MULTIFROB (gmacros.zil:67-89) ---------------------------
-- このマクロ補助関数は、変換時に評価器が実行する (生成コードでは実行されない)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM)
-- 	<REPEAT ()
-- 		<COND (<EMPTY? .ATMS>
-- 		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
-- 				       (<LENGTH? .OO 2> <NTH .OO 2>)
-- 				       (ELSE <CHTYPE .OO FORM>)>>)>
-- 		<REPEAT ()
-- 			<COND (<EMPTY? .ATMS> <RETURN!->)>
-- 			<SET ATM <NTH .ATMS 1>>
-- 			<SET L
-- 			     (<COND (<TYPE? .ATM ATOM>
-- 				     <FORM GVAL
-- 					   <COND (<==? .X PRSA>
-- 						  <PARSE
-- 						    <STRING "V?"
-- 							    <SPNAME .ATM>>>)
-- 						 (ELSE .ATM)>>)
-- 				    (ELSE .ATM)>
-- 			      !.L)>
-- 			<SET ATMS <REST .ATMS>>
-- 			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
-- 		<SET O <REST <PUTREST .O (<FORM EQUAL? <FORM GVAL .X> !.L>)>>>
-- 		<SET L ()>>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC BSET (gmacros.zil:91-92) --------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC BSET ('OBJ "ARGS" BITS)
-- 	<MULTIBITS FSET .OBJ .BITS>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC BCLEAR (gmacros.zil:94-95) ------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC BCLEAR ('OBJ "ARGS" BITS)
-- 	<MULTIBITS FCLEAR .OBJ .BITS>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC BSET? (gmacros.zil:97-98) -------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC BSET? ('OBJ "ARGS" BITS)
-- 	<MULTIBITS FSET? .OBJ .BITS>>
-- ---------------------------------------------------------------------

-- ---- DEFINE MULTIBITS (gmacros.zil:100-113) -------------------------
-- このマクロ補助関数は、変換時に評価器が実行する (生成コードでは実行されない)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM)
-- 	<REPEAT ()
-- 		<COND (<EMPTY? .ATMS>
-- 		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
-- 				       (<==? .X FSET?> <FORM OR !.O>)
-- 				       (ELSE <FORM PROG () !.O>)>>)>
-- 		<SET ATM <NTH .ATMS 1>>
-- 		<SET ATMS <REST .ATMS>>
-- 		<SET O
-- 		     (<FORM .X
-- 			    .OBJ
-- 			    <COND (<TYPE? .ATM FORM> .ATM)
-- 				  (ELSE <FORM GVAL .ATM>)>>
-- 		      !.O)>>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC RFATAL (gmacros.zil:115-116) ----------------------------
-- このマクロは、ランタイムの組み込み RFATAL を使う (定義を比べて、同じ意味だと確かめた)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC RFATAL ()
-- 	'<PROG () <PUSH 2> <RSTACK>>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC PROB (gmacros.zil:118-120) ------------------------------
-- このマクロは、下の関数に変換した。呼び出しは関数の呼び出しになる。ただし、
-- 副作用のある引数を渡す呼び出しなど、関数と同じ動きにならない呼び出しは、その位置に展開する。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
-- 	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
-- 	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>
-- ---------------------------------------------------------------------

ZG.actions:register("PROB", function(BASE_p)

    do return ZG.LT(ZG.RANDOM(100), BASE_p) end

end, "PROB")

ZG.PROB = ZG.actions:get("PROB")

-- zil: gmacros.zil:122  <ROUTINE ZPROB (BASE)>
ZG.actions:register("ZPROB", function(BASE)

    if ZG._T(ZG.LUCKY) then
        do return ZG.LT(ZG.RANDOM(100), BASE) end
    else
        do return ZG.LT(ZG.RANDOM(300), BASE) end
    end

end, "ZPROB")

ZG.ZPROB = ZG.actions:get("ZPROB")

-- zil: gmacros.zil:127  <ROUTINE RANDOM-ELEMENT (FROB)>
ZG.actions:register("RANDOM_ELEMENT", function(FROB)

    do return ZG.GET(FROB, ZG.RANDOM(ZG.GET(FROB, 0))) end

end, "RANDOM-ELEMENT")

ZG.RANDOM_ELEMENT = ZG.actions:get("RANDOM_ELEMENT")

-- zil: gmacros.zil:130  <ROUTINE PICK-ONE (FROB "AUX" (L <GET .FROB 0>) (CNT <GET .FROB 1>) RND MSG R...
ZG.actions:register("PICK_ONE", function(FROB)

    local L = ZG.GET(FROB, 0)
    local CNT = ZG.GET(FROB, 1)
    local RND = 0
    local MSG = 0
    local RFROB = 0
    L = ZG.SUB(L, 1)
    FROB = ZG.REST(FROB, 2)
    RFROB = ZG.REST(FROB, (CNT * 2))
    RND = ZG.RANDOM(ZG.SUB(L, CNT))
    MSG = ZG.GET(RFROB, RND)
    do local _ = ZG.PUT(RFROB, RND, ZG.GET(RFROB, 1)) end
    do local _ = ZG.PUT(RFROB, 1, MSG) end
    CNT = ZG.ADD(CNT, 1)
    if ZG.EQ(CNT, L) then
        CNT = 0
    end
    do local _ = ZG.PUT(FROB, 0, CNT) end
    do return MSG end

end, "PICK-ONE")

ZG.PICK_ONE = ZG.actions:get("PICK_ONE")

-- ---- DEFMAC ENABLE (gmacros.zil:144-144) ----------------------------
-- このマクロは、ランタイムの組み込み ENABLE を使う (定義を比べて、同じ意味だと確かめた)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC DISABLE (gmacros.zil:146-146) ---------------------------
-- このマクロは、下の関数に変換した。呼び出しは関数の呼び出しになる。ただし、
-- 副作用のある引数を渡す呼び出しなど、関数と同じ動きにならない呼び出しは、その位置に展開する。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>
-- ---------------------------------------------------------------------

ZG.actions:register("DISABLE", function(INT)

    do return ZG.PUT(INT, ZG.C_ENABLED_p, 0) end

end, "DISABLE")

ZG.DISABLE = ZG.actions:get("DISABLE")

-- ---- DEFMAC FLAMING? (gmacros.zil:148-150) --------------------------
-- このマクロは、ランタイムの組み込み FLAMING_p を使う (定義を比べて、同じ意味だと確かめた)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC FLAMING? ('OBJ)
-- 	<FORM AND <FORM FSET? .OBJ ',FLAMEBIT>
-- 	          <FORM FSET? .OBJ ',ONBIT>>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC OPENABLE? (gmacros.zil:152-154) -------------------------
-- このマクロは、ランタイムの組み込み OPENABLE_p を使う (定義を比べて、同じ意味だと確かめた)。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC OPENABLE? ('OBJ)
-- 	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
-- 	         <FORM FSET? .OBJ ',CONTBIT>>>
-- ---------------------------------------------------------------------

-- ---- DEFMAC ABS (gmacros.zil:156-158) -------------------------------
-- このマクロは、どこからも呼ばれていない。
-- この定義は実行されない (ZIL の原文を残したもの)。
--
-- <DEFMAC ABS ('NUM)
-- 	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
-- 	           (T .NUM)>>
-- ---------------------------------------------------------------------
