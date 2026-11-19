-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

do local _ = ZG.BUZZ("AGAIN", "G", "OOPS") end

do local _ = ZG.BUZZ("A", "AN", "THE", "IS", "AND", "OF", "THEN", "ALL", "ONE", "BUT", "EXCEPT", ".", ",", "\"", "YES", "NO", "Y", "HERE") end

do local _ = ZG.SYNONYM("WITH", "USING", "THROUGH", "THRU") end

do local _ = ZG.SYNONYM("IN", "INSIDE", "INTO") end

do local _ = ZG.SYNONYM("ON", "ONTO") end

do local _ = ZG.SYNONYM("UNDER", "UNDERNEATH", "BENEATH", "BELOW") end

do local _ = ZG.SYNONYM("NORTH", "N") end

do local _ = ZG.SYNONYM("SOUTH", "S") end

do local _ = ZG.SYNONYM("EAST", "E") end

do local _ = ZG.SYNONYM("WEST", "W") end

do local _ = ZG.SYNONYM("DOWN", "D") end

do local _ = ZG.SYNONYM("UP", "U") end

do local _ = ZG.SYNONYM("NW", "NORTHWEST") end

do local _ = ZG.SYNONYM("NE", "NORTHE") end

do local _ = ZG.SYNONYM("SW", "SOUTHWEST") end

do local _ = ZG.SYNONYM("SE", "SOUTHE") end

-- zil: gsyntax.zil:40  <SYNTAX VERBOSE = V-VERBOSE>
do local _ = ZG.SYNTAX("VERBOSE", "=", "V-VERBOSE") end

-- zil: gsyntax.zil:42  <SYNTAX BRIEF = V-BRIEF>
do local _ = ZG.SYNTAX("BRIEF", "=", "V-BRIEF") end

-- zil: gsyntax.zil:44  <SYNTAX SUPER = V-SUPER-BRIEF>
do local _ = ZG.SYNTAX("SUPER", "=", "V-SUPER-BRIEF") end

do local _ = ZG.SYNONYM("SUPER", "SUPERBRIEF") end

-- zil: gsyntax.zil:47  <SYNTAX DIAGNOSE = V-DIAGNOSE>
do local _ = ZG.SYNTAX("DIAGNOSE", "=", "V-DIAGNOSE") end

-- zil: gsyntax.zil:49  <SYNTAX INVENTORY = V-INVENTORY>
do local _ = ZG.SYNTAX("INVENTORY", "=", "V-INVENTORY") end

do local _ = ZG.SYNONYM("INVENTORY", "I") end

-- zil: gsyntax.zil:52  <SYNTAX QUIT = V-QUIT>
do local _ = ZG.SYNTAX("QUIT", "=", "V-QUIT") end

do local _ = ZG.SYNONYM("QUIT", "Q") end

-- zil: gsyntax.zil:55  <SYNTAX RESTART = V-RESTART>
do local _ = ZG.SYNTAX("RESTART", "=", "V-RESTART") end

-- zil: gsyntax.zil:57  <SYNTAX RESTORE = V-RESTORE>
do local _ = ZG.SYNTAX("RESTORE", "=", "V-RESTORE") end

-- zil: gsyntax.zil:59  <SYNTAX SAVE = V-SAVE>
do local _ = ZG.SYNTAX("SAVE", "=", "V-SAVE") end

-- zil: gsyntax.zil:61  <SYNTAX SCORE = V-SCORE>
do local _ = ZG.SYNTAX("SCORE", "=", "V-SCORE") end

-- zil: gsyntax.zil:63  <SYNTAX SCRIPT = V-SCRIPT>
do local _ = ZG.SYNTAX("SCRIPT", "=", "V-SCRIPT") end

-- zil: gsyntax.zil:65  <SYNTAX UNSCRIPT = V-UNSCRIPT>
do local _ = ZG.SYNTAX("UNSCRIPT", "=", "V-UNSCRIPT") end

-- zil: gsyntax.zil:67  <SYNTAX VERSION = V-VERSION>
do local _ = ZG.SYNTAX("VERSION", "=", "V-VERSION") end

-- zil: gsyntax.zil:69  <SYNTAX $VERIFY = V-VERIFY>
do local _ = ZG.SYNTAX("$VERIFY", "=", "V-VERIFY") end

-- zil: gsyntax.zil:71  <SYNTAX \#RANDOM OBJECT = V-RANDOM>
do local _ = ZG.SYNTAX("#RANDOM", "OBJECT", "=", "V-RANDOM") end

-- zil: gsyntax.zil:73  <SYNTAX \#COMMAND = V-COMMAND-FILE>
do local _ = ZG.SYNTAX("#COMMAND", "=", "V-COMMAND-FILE") end

-- zil: gsyntax.zil:75  <SYNTAX \#RECORD = V-RECORD>
do local _ = ZG.SYNTAX("#RECORD", "=", "V-RECORD") end

-- zil: gsyntax.zil:77  <SYNTAX \#UNRECORD = V-UNRECORD>
do local _ = ZG.SYNTAX("#UNRECORD", "=", "V-UNRECORD") end

-- zil: gsyntax.zil:83  <SYNTAX ACTIVATE OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-...
do local _ = ZG.SYNTAX("ACTIVATE", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:86  <SYNTAX ANSWER = V-ANSWER>
do local _ = ZG.SYNTAX("ANSWER", "=", "V-ANSWER") end

-- zil: gsyntax.zil:87  <SYNTAX ANSWER OBJECT = V-REPLY>
do local _ = ZG.SYNTAX("ANSWER", "OBJECT", "=", "V-REPLY") end

do local _ = ZG.SYNONYM("ANSWER", "REPLY") end

-- zil: gsyntax.zil:90  <SYNTAX APPLY OBJECT TO OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("APPLY", "OBJECT", "TO", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:96  <SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND W...
do local _ = ZG.SYNTAX("ATTACK", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-ATTACK") end

do local _ = ZG.SYNONYM("ATTACK", "FIGHT", "HURT", "INJURE", "HIT") end

-- zil: gsyntax.zil:100  <SYNTAX BACK = V-BACK>
do local _ = ZG.SYNTAX("BACK", "=", "V-BACK") end

-- zil: gsyntax.zil:102  <SYNTAX BLAST = V-BLAST>
do local _ = ZG.SYNTAX("BLAST", "=", "V-BLAST") end

-- zil: gsyntax.zil:104  <SYNTAX BLOW OUT OBJECT = V-LAMP-OFF>
do local _ = ZG.SYNTAX("BLOW", "OUT", "OBJECT", "=", "V-LAMP-OFF") end

-- zil: gsyntax.zil:105  <SYNTAX BLOW UP OBJECT WITH OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CAR...
do local _ = ZG.SYNTAX("BLOW", "UP", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-INFLATE") end

-- zil: gsyntax.zil:107  <SYNTAX BLOW UP OBJECT = V-BLAST>
do local _ = ZG.SYNTAX("BLOW", "UP", "OBJECT", "=", "V-BLAST") end

-- zil: gsyntax.zil:108  <SYNTAX BLOW IN OBJECT = V-BREATHE>
do local _ = ZG.SYNTAX("BLOW", "IN", "OBJECT", "=", "V-BREATHE") end

-- zil: gsyntax.zil:110  <SYNTAX BOARD OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
do local _ = ZG.SYNTAX("BOARD", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-BOARD", "PRE-BOARD") end

-- zil: gsyntax.zil:112  <SYNTAX BRUSH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-BRUSH>
do local _ = ZG.SYNTAX("BRUSH", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-BRUSH") end

-- zil: gsyntax.zil:113  <SYNTAX BRUSH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJECT = V-BRUSH>
do local _ = ZG.SYNTAX("BRUSH", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", "=", "V-BRUSH") end

do local _ = ZG.SYNONYM("BRUSH", "CLEAN") end

-- zil: gsyntax.zil:117  <SYNTAX BUG = V-BUG>
do local _ = ZG.SYNTAX("BUG", "=", "V-BUG") end

-- zil: gsyntax.zil:119  <SYNTAX BURN OBJECT (FIND BURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("BURN", "OBJECT", {"FIND", "BURNBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "HAVE"}, "=", "V-BURN", "PRE-BURN") end

-- zil: gsyntax.zil:122  <SYNTAX BURN DOWN OBJECT (FIND BURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH...
do local _ = ZG.SYNTAX("BURN", "DOWN", "OBJECT", {"FIND", "BURNBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "HAVE"}, "=", "V-BURN", "PRE-BURN") end

do local _ = ZG.SYNONYM("BURN", "INCINERATE", "IGNITE") end

-- zil: gsyntax.zil:127  <SYNTAX CHOMP = V-CHOMP>
do local _ = ZG.SYNTAX("CHOMP", "=", "V-CHOMP") end

do local _ = ZG.SYNONYM("CHOMP", "LOSE", "BARF") end

-- zil: gsyntax.zil:130  <SYNTAX CLIMB UP OBJECT (FIND RMUNGBIT) = V-CLIMB-UP>
do local _ = ZG.SYNTAX("CLIMB", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-CLIMB-UP") end

-- zil: gsyntax.zil:131  <SYNTAX CLIMB UP OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-UP>
do local _ = ZG.SYNTAX("CLIMB", "UP", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-UP") end

-- zil: gsyntax.zil:132  <SYNTAX CLIMB DOWN OBJECT (FIND RMUNGBIT) = V-CLIMB-DOWN>
do local _ = ZG.SYNTAX("CLIMB", "DOWN", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-CLIMB-DOWN") end

-- zil: gsyntax.zil:133  <SYNTAX CLIMB DOWN OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-DOWN>
do local _ = ZG.SYNTAX("CLIMB", "DOWN", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-DOWN") end

-- zil: gsyntax.zil:134  <SYNTAX CLIMB OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-FOO>
do local _ = ZG.SYNTAX("CLIMB", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-FOO") end

-- zil: gsyntax.zil:135  <SYNTAX CLIMB IN OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
do local _ = ZG.SYNTAX("CLIMB", "IN", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-BOARD", "PRE-BOARD") end

-- zil: gsyntax.zil:136  <SYNTAX CLIMB ON OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-CLIMB-ON>
do local _ = ZG.SYNTAX("CLIMB", "ON", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-ON") end

-- zil: gsyntax.zil:137  <SYNTAX CLIMB WITH OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("CLIMB", "WITH", "OBJECT", "=", "V-THROUGH") end

do local _ = ZG.SYNONYM("CLIMB", "SIT") end

-- zil: gsyntax.zil:140  <SYNTAX CLOSE OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-CLOSE>
do local _ = ZG.SYNTAX("CLOSE", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-CLOSE") end

-- zil: gsyntax.zil:142  <SYNTAX COMMAND OBJECT (FIND ACTORBIT) = V-COMMAND>
do local _ = ZG.SYNTAX("COMMAND", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-COMMAND") end

-- zil: gsyntax.zil:144  <SYNTAX COUNT OBJECT = V-COUNT>
do local _ = ZG.SYNTAX("COUNT", "OBJECT", "=", "V-COUNT") end

-- zil: gsyntax.zil:146  <SYNTAX CROSS OBJECT = V-CROSS>
do local _ = ZG.SYNTAX("CROSS", "OBJECT", "=", "V-CROSS") end

do local _ = ZG.SYNONYM("CROSS", "FORD") end

-- zil: gsyntax.zil:149  <SYNTAX CUT OBJECT WITH OBJECT (FIND WEAPONBIT) (CARRIED HELD) = V-CUT>
do local _ = ZG.SYNTAX("CUT", "OBJECT", "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"CARRIED", "HELD"}, "=", "V-CUT") end

do local _ = ZG.SYNONYM("CUT", "SLICE", "PIERCE") end

-- zil: gsyntax.zil:152  <SYNTAX CURSE = V-CURSES>
do local _ = ZG.SYNTAX("CURSE", "=", "V-CURSES") end

-- zil: gsyntax.zil:153  <SYNTAX CURSE OBJECT (FIND ACTORBIT) = V-CURSES>
do local _ = ZG.SYNTAX("CURSE", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-CURSES") end

do local _ = ZG.SYNONYM("CURSE", "SHIT", "FUCK", "DAMN") end

-- zil: gsyntax.zil:156  <SYNTAX DEFLATE OBJECT = V-DEFLATE>
do local _ = ZG.SYNTAX("DEFLATE", "OBJECT", "=", "V-DEFLATE") end

-- zil: gsyntax.zil:158  <SYNTAX DESTROY OBJECT (ON-GROUND IN-ROOM HELD CARRIED) WITH OBJECT (HELD CAR...
do local _ = ZG.SYNTAX("DESTROY", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "WITH", "OBJECT", {"HELD", "CARRIED", "TAKE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:160  <SYNTAX DESTROY DOWN OBJECT (ON-GROUND IN-ROOM HELD CARRIED) WITH OBJECT (HEL...
do local _ = ZG.SYNTAX("DESTROY", "DOWN", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "WITH", "OBJECT", {"HELD", "CARRIED", "TAKE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:162  <SYNTAX DESTROY IN OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-OPEN>
do local _ = ZG.SYNTAX("DESTROY", "IN", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-OPEN") end

do local _ = ZG.SYNONYM("DESTROY", "DAMAGE", "BREAK", "BLOCK", "SMASH") end

-- zil: gsyntax.zil:165  <SYNTAX DIG IN OBJECT (ON-GROUND IN-ROOM) = V-DIG>
do local _ = ZG.SYNTAX("DIG", "IN", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-DIG") end

-- zil: gsyntax.zil:166  <SYNTAX DIG IN OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CA...
do local _ = ZG.SYNTAX("DIG", "IN", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-DIG") end

-- zil: gsyntax.zil:168  <SYNTAX DIG OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CARRI...
do local _ = ZG.SYNTAX("DIG", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-DIG") end

-- zil: gsyntax.zil:171  <SYNTAX DISEMBARK OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-DISEMBARK>
do local _ = ZG.SYNTAX("DISEMBARK", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-DISEMBARK") end

-- zil: gsyntax.zil:174  <SYNTAX DISENCHANT OBJECT = V-DISENCHANT>
do local _ = ZG.SYNTAX("DISENCHANT", "OBJECT", "=", "V-DISENCHANT") end

-- zil: gsyntax.zil:176  <SYNTAX DRINK OBJECT (FIND DRINKBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-DRINK>
do local _ = ZG.SYNTAX("DRINK", "OBJECT", {"FIND", "DRINKBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-DRINK") end

-- zil: gsyntax.zil:178  <SYNTAX DRINK FROM OBJECT (HELD CARRIED) = V-DRINK-FROM>
do local _ = ZG.SYNTAX("DRINK", "FROM", "OBJECT", {"HELD", "CARRIED"}, "=", "V-DRINK-FROM") end

do local _ = ZG.SYNONYM("DRINK", "IMBIBE", "SWALLOW") end

-- zil: gsyntax.zil:181  <SYNTAX DROP OBJECT (HELD MANY HAVE) = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:182  <SYNTAX DROP OBJECT (HELD MANY HAVE) DOWN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "DOWN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:183  <SYNTAX DROP OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:184  <SYNTAX DROP OBJECT (HELD MANY HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "ON", "OBJECT", "=", "V-PUT-ON", "PRE-PUT") end

-- zil: gsyntax.zil:186  <SYNTAX EAT OBJECT (FIND FOODBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-EAT>
do local _ = ZG.SYNTAX("EAT", "OBJECT", {"FIND", "FOODBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-EAT") end

do local _ = ZG.SYNONYM("EAT", "CONSUME", "TASTE", "BITE") end

-- zil: gsyntax.zil:190  <SYNTAX ECHO = V-ECHO>
do local _ = ZG.SYNTAX("ECHO", "=", "V-ECHO") end

-- zil: gsyntax.zil:192  <SYNTAX ENCHANT OBJECT (ON-GROUND IN-ROOM) = V-ENCHANT>
do local _ = ZG.SYNTAX("ENCHANT", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-ENCHANT") end

-- zil: gsyntax.zil:194  <SYNTAX ENTER = V-ENTER>
do local _ = ZG.SYNTAX("ENTER", "=", "V-ENTER") end

-- zil: gsyntax.zil:195  <SYNTAX ENTER OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("ENTER", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:196  <SYNTAX EXIT = V-EXIT>
do local _ = ZG.SYNTAX("EXIT", "=", "V-EXIT") end

-- zil: gsyntax.zil:197  <SYNTAX EXIT OBJECT = V-EXIT>
do local _ = ZG.SYNTAX("EXIT", "OBJECT", "=", "V-EXIT") end

-- zil: gsyntax.zil:199  <SYNTAX EXAMINE OBJECT (MANY) = V-EXAMINE>
do local _ = ZG.SYNTAX("EXAMINE", "OBJECT", {"MANY"}, "=", "V-EXAMINE") end

-- zil: gsyntax.zil:200  <SYNTAX EXAMINE IN OBJECT (HELD CARRIED IN-ROOM ON-GROUND MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("EXAMINE", "IN", "OBJECT", {"HELD", "CARRIED", "IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-LOOK-INSIDE") end

-- zil: gsyntax.zil:202  <SYNTAX EXAMINE ON OBJECT (HELD CARRIED IN-ROOM ON-GROUND MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("EXAMINE", "ON", "OBJECT", {"HELD", "CARRIED", "IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-LOOK-INSIDE") end

do local _ = ZG.SYNONYM("EXAMINE", "DESCRIBE", "WHAT", "WHATS") end

-- zil: gsyntax.zil:206  <SYNTAX EXORCISE OBJECT = V-EXORCISE>
do local _ = ZG.SYNTAX("EXORCISE", "OBJECT", "=", "V-EXORCISE") end

-- zil: gsyntax.zil:207  <SYNTAX EXORCISE OUT OBJECT (FIND ACTORBIT) = V-EXORCISE>
do local _ = ZG.SYNTAX("EXORCISE", "OUT", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-EXORCISE") end

-- zil: gsyntax.zil:208  <SYNTAX EXORCISE AWAY OBJECT (FIND ACTORBIT) = V-EXORCISE>
do local _ = ZG.SYNTAX("EXORCISE", "AWAY", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-EXORCISE") end

do local _ = ZG.SYNONYM("EXORCISE", "BANISH", "CAST", "DRIVE", "BEGONE") end

-- zil: gsyntax.zil:211  <SYNTAX EXTINGUISH OBJECT (FIND ONBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE H...
do local _ = ZG.SYNTAX("EXTINGUISH", "OBJECT", {"FIND", "ONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-OFF") end

do local _ = ZG.SYNONYM("EXTINGUISH", "DOUSE") end

-- zil: gsyntax.zil:215  <SYNTAX FILL OBJECT (FIND CONTBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("FILL", "OBJECT", {"FIND", "CONTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", "=", "V-FILL", "PRE-FILL") end

-- zil: gsyntax.zil:217  <SYNTAX FILL OBJECT (FIND CONTBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-FILL ...
do local _ = ZG.SYNTAX("FILL", "OBJECT", {"FIND", "CONTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-FILL", "PRE-FILL") end

-- zil: gsyntax.zil:220  <SYNTAX FIND OBJECT = V-FIND>
do local _ = ZG.SYNTAX("FIND", "OBJECT", "=", "V-FIND") end

do local _ = ZG.SYNONYM("FIND", "WHERE", "SEEK", "SEE") end

-- zil: gsyntax.zil:223  <SYNTAX FOLLOW = V-FOLLOW>
do local _ = ZG.SYNTAX("FOLLOW", "=", "V-FOLLOW") end

-- zil: gsyntax.zil:224  <SYNTAX FOLLOW OBJECT = V-FOLLOW>
do local _ = ZG.SYNTAX("FOLLOW", "OBJECT", "=", "V-FOLLOW") end

do local _ = ZG.SYNONYM("FOLLOW", "PURSUE", "CHASE", "COME") end

-- zil: gsyntax.zil:227  <SYNTAX FROBOZZ = V-FROBOZZ>
do local _ = ZG.SYNTAX("FROBOZZ", "=", "V-FROBOZZ") end

-- zil: gsyntax.zil:229  <SYNTAX GIVE OBJECT (MANY HELD HAVE) TO OBJECT (FIND ACTORBIT) (ON-GROUND) = ...
do local _ = ZG.SYNTAX("GIVE", "OBJECT", {"MANY", "HELD", "HAVE"}, "TO", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND"}, "=", "V-GIVE", "PRE-GIVE") end

-- zil: gsyntax.zil:231  <SYNTAX GIVE OBJECT (FIND ACTORBIT) (ON-GROUND) OBJECT (MANY HELD HAVE) = V-S...
do local _ = ZG.SYNTAX("GIVE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND"}, "OBJECT", {"MANY", "HELD", "HAVE"}, "=", "V-SGIVE", "PRE-SGIVE") end

do local _ = ZG.SYNONYM("GIVE", "DONATE", "OFFER", "FEED") end

do local _ = ZG.SYNONYM("GIVE", "HAND") end

-- zil: gsyntax.zil:237  <SYNTAX HATCH OBJECT = V-HATCH>
do local _ = ZG.SYNTAX("HATCH", "OBJECT", "=", "V-HATCH") end

-- zil: gsyntax.zil:239  <SYNTAX HELLO = V-HELLO>
do local _ = ZG.SYNTAX("HELLO", "=", "V-HELLO") end

-- zil: gsyntax.zil:240  <SYNTAX HELLO OBJECT = V-HELLO>
do local _ = ZG.SYNTAX("HELLO", "OBJECT", "=", "V-HELLO") end

do local _ = ZG.SYNONYM("HELLO", "HI") end

-- zil: gsyntax.zil:243  <SYNTAX INCANT = V-INCANT>
do local _ = ZG.SYNTAX("INCANT", "=", "V-INCANT") end

do local _ = ZG.SYNONYM("INCANT", "CHANT") end

-- zil: gsyntax.zil:246  <SYNTAX INFLAT OBJECT WITH OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARR...
do local _ = ZG.SYNTAX("INFLAT", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-INFLATE") end

-- zil: gsyntax.zil:249  <SYNTAX JUMP = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "=", "V-LEAP") end

-- zil: gsyntax.zil:250  <SYNTAX JUMP OVER OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "OVER", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:251  <SYNTAX JUMP ACROSS OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "ACROSS", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:252  <SYNTAX JUMP IN OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "IN", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:253  <SYNTAX JUMP FROM OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "FROM", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:254  <SYNTAX JUMP OFF OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "OFF", "OBJECT", "=", "V-LEAP") end

do local _ = ZG.SYNONYM("JUMP", "LEAP", "DIVE") end

-- zil: gsyntax.zil:257  <SYNTAX KICK OBJECT = V-KICK>
do local _ = ZG.SYNTAX("KICK", "OBJECT", "=", "V-KICK") end

do local _ = ZG.SYNONYM("KICK", "TAUNT") end

-- zil: gsyntax.zil:264  <SYNTAX KILL OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND WEA...
do local _ = ZG.SYNTAX("KILL", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-ATTACK") end

do local _ = ZG.SYNONYM("KILL", "MURDER", "SLAY", "DISPATCH") end

-- zil: gsyntax.zil:268  <SYNTAX STAB OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-STAB>
do local _ = ZG.SYNTAX("STAB", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-STAB") end

-- zil: gsyntax.zil:269  <SYNTAX STAB OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND WEA...
do local _ = ZG.SYNTAX("STAB", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-ATTACK") end

-- zil: gsyntax.zil:272  <SYNTAX KISS OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-KISS>
do local _ = ZG.SYNTAX("KISS", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-KISS") end

-- zil: gsyntax.zil:274  <SYNTAX KNOCK AT OBJECT = V-KNOCK>
do local _ = ZG.SYNTAX("KNOCK", "AT", "OBJECT", "=", "V-KNOCK") end

-- zil: gsyntax.zil:275  <SYNTAX KNOCK ON OBJECT = V-KNOCK>
do local _ = ZG.SYNTAX("KNOCK", "ON", "OBJECT", "=", "V-KNOCK") end

-- zil: gsyntax.zil:276  <SYNTAX KNOCK DOWN OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
do local _ = ZG.SYNTAX("KNOCK", "DOWN", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ATTACK") end

do local _ = ZG.SYNONYM("KNOCK", "RAP") end

-- zil: gsyntax.zil:279  <SYNTAX LAUNCH OBJECT (FIND VEHBIT) = V-LAUNCH>
do local _ = ZG.SYNTAX("LAUNCH", "OBJECT", {"FIND", "VEHBIT"}, "=", "V-LAUNCH") end

-- zil: gsyntax.zil:281  <SYNTAX LEAN ON OBJECT (HELD HAVE) = V-LEAN-ON>
do local _ = ZG.SYNTAX("LEAN", "ON", "OBJECT", {"HELD", "HAVE"}, "=", "V-LEAN-ON") end

-- zil: gsyntax.zil:283  <SYNTAX LEAVE = V-LEAVE>
do local _ = ZG.SYNTAX("LEAVE", "=", "V-LEAVE") end

-- zil: gsyntax.zil:284  <SYNTAX LEAVE OBJECT = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("LEAVE", "OBJECT", "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:286  <SYNTAX LIGHT OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE HAV...
do local _ = ZG.SYNTAX("LIGHT", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:288  <SYNTAX LIGHT OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OB...
do local _ = ZG.SYNTAX("LIGHT", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "TAKE", "HAVE"}, "=", "V-BURN", "PRE-BURN") end

-- zil: gsyntax.zil:291  <SYNTAX LISTEN TO OBJECT = V-LISTEN>
do local _ = ZG.SYNTAX("LISTEN", "TO", "OBJECT", "=", "V-LISTEN") end

-- zil: gsyntax.zil:292  <SYNTAX LISTEN FOR OBJECT = V-LISTEN>
do local _ = ZG.SYNTAX("LISTEN", "FOR", "OBJECT", "=", "V-LISTEN") end

-- zil: gsyntax.zil:294  <SYNTAX LOCK OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CARR...
do local _ = ZG.SYNTAX("LOCK", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-LOCK") end

-- zil: gsyntax.zil:297  <SYNTAX LOOK = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "=", "V-LOOK") end

-- zil: gsyntax.zil:298  <SYNTAX LOOK AROUND OBJECT (FIND RMUNGBIT) = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "AROUND", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-LOOK") end

-- zil: gsyntax.zil:299  <SYNTAX LOOK UP OBJECT (FIND RMUNGBIT) = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-LOOK") end

-- zil: gsyntax.zil:300  <SYNTAX LOOK DOWN OBJECT (FIND RMUNGBIT) = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "DOWN", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-LOOK") end

-- zil: gsyntax.zil:301  <SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-EXAMINE>
do local _ = ZG.SYNTAX("LOOK", "AT", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-EXAMINE") end

-- zil: gsyntax.zil:302  <SYNTAX LOOK ON OBJECT = V-LOOK-ON>
do local _ = ZG.SYNTAX("LOOK", "ON", "OBJECT", "=", "V-LOOK-ON") end

-- zil: gsyntax.zil:303  <SYNTAX LOOK WITH OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("LOOK", "WITH", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-LOOK-INSIDE") end

-- zil: gsyntax.zil:304  <SYNTAX LOOK UNDER OBJECT = V-LOOK-UNDER>
do local _ = ZG.SYNTAX("LOOK", "UNDER", "OBJECT", "=", "V-LOOK-UNDER") end

-- zil: gsyntax.zil:305  <SYNTAX LOOK BEHIND OBJECT = V-LOOK-BEHIND>
do local _ = ZG.SYNTAX("LOOK", "BEHIND", "OBJECT", "=", "V-LOOK-BEHIND") end

-- zil: gsyntax.zil:306  <SYNTAX LOOK IN OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("LOOK", "IN", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-LOOK-INSIDE") end

-- zil: gsyntax.zil:307  <SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJECT = V-READ ...
do local _ = ZG.SYNTAX("LOOK", "AT", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:309  <SYNTAX LOOK FOR OBJECT = V-FIND>
do local _ = ZG.SYNTAX("LOOK", "FOR", "OBJECT", "=", "V-FIND") end

do local _ = ZG.SYNONYM("LOOK", "L", "STARE", "GAZE") end

-- zil: gsyntax.zil:312  <SYNTAX LOWER OBJECT = V-LOWER>
do local _ = ZG.SYNTAX("LOWER", "OBJECT", "=", "V-LOWER") end

-- zil: gsyntax.zil:314  <SYNTAX LUBRICATE OBJECT WITH OBJECT (HELD CARRIED) = V-OIL>
do local _ = ZG.SYNTAX("LUBRICATE", "OBJECT", "WITH", "OBJECT", {"HELD", "CARRIED"}, "=", "V-OIL") end

do local _ = ZG.SYNONYM("LUBRICATE", "OIL", "GREASE") end

-- zil: gsyntax.zil:317  <SYNTAX MAKE OBJECT = V-MAKE>
do local _ = ZG.SYNTAX("MAKE", "OBJECT", "=", "V-MAKE") end

-- zil: gsyntax.zil:319  <SYNTAX MELT OBJECT WITH OBJECT (FIND FLAMEBIT) (HELD CARRIED ON-GROUND IN-RO...
do local _ = ZG.SYNTAX("MELT", "OBJECT", "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-MELT") end

do local _ = ZG.SYNONYM("MELT", "LIQUIFY") end

-- zil: gsyntax.zil:323  <SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:324  <SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:325  <SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) TO OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "TO", "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:326  <SYNTAX MOVE OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"HELD", "MANY", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:327  <SYNTAX MOVE OBJECT WITH OBJECT (FIND TOOLBIT) = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:328  <SYNTAX ROLL UP OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("ROLL", "UP", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:329  <SYNTAX ROLL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("ROLL", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:331  <SYNTAX MUMBLE = V-MUMBLE>
do local _ = ZG.SYNTAX("MUMBLE", "=", "V-MUMBLE") end

do local _ = ZG.SYNONYM("MUMBLE", "SIGH") end

-- zil: gsyntax.zil:334  <SYNTAX ODYSSEUS = V-ODYSSEUS>
do local _ = ZG.SYNTAX("ODYSSEUS", "=", "V-ODYSSEUS") end

do local _ = ZG.SYNONYM("ODYSSEUS", "ULYSSES") end

-- zil: gsyntax.zil:337  <SYNTAX OPEN OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-OPEN>
do local _ = ZG.SYNTAX("OPEN", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-OPEN") end

-- zil: gsyntax.zil:338  <SYNTAX OPEN UP OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-OPEN>
do local _ = ZG.SYNTAX("OPEN", "UP", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-OPEN") end

-- zil: gsyntax.zil:340  <SYNTAX OPEN OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("OPEN", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED", "HAVE"}, "=", "V-OPEN") end

-- zil: gsyntax.zil:343  <SYNTAX PICK OBJECT = V-PICK>
do local _ = ZG.SYNTAX("PICK", "OBJECT", "=", "V-PICK") end

-- zil: gsyntax.zil:344  <SYNTAX PICK OBJECT WITH OBJECT = V-PICK>
do local _ = ZG.SYNTAX("PICK", "OBJECT", "WITH", "OBJECT", "=", "V-PICK") end

-- zil: gsyntax.zil:345  <SYNTAX PICK UP OBJECT (FIND TAKEBIT) (ON-GROUND MANY) = V-TAKE PRE-TAKE>
do local _ = ZG.SYNTAX("PICK", "UP", "OBJECT", {"FIND", "TAKEBIT"}, {"ON-GROUND", "MANY"}, "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:347  <SYNTAX PLAY OBJECT = V-PLAY>
do local _ = ZG.SYNTAX("PLAY", "OBJECT", "=", "V-PLAY") end

-- zil: gsyntax.zil:349  <SYNTAX PLUG OBJECT WITH OBJECT = V-PLUG>
do local _ = ZG.SYNTAX("PLUG", "OBJECT", "WITH", "OBJECT", "=", "V-PLUG") end

do local _ = ZG.SYNONYM("PLUG", "GLUE", "PATCH", "REPAIR", "FIX") end

-- zil: gsyntax.zil:352  <SYNTAX PLUGH = V-ADVENT>
do local _ = ZG.SYNTAX("PLUGH", "=", "V-ADVENT") end

do local _ = ZG.SYNONYM("PLUGH", "XYZZY") end

-- zil: gsyntax.zil:355  <SYNTAX POKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND WEA...
do local _ = ZG.SYNTAX("POKE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:357  <SYNTAX PUNCTURE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND...
do local _ = ZG.SYNTAX("PUNCTURE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:360  <SYNTAX POUR OBJECT (HELD CARRIED) = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:361  <SYNTAX POUR OBJECT (HELD CARRIED) IN OBJECT = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "IN", "OBJECT", "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:362  <SYNTAX POUR OBJECT (HELD CARRIED) ON OBJECT = V-POUR-ON>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "ON", "OBJECT", "=", "V-POUR-ON") end

-- zil: gsyntax.zil:363  <SYNTAX POUR OBJECT (HELD CARRIED) FROM OBJECT = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "FROM", "OBJECT", "=", "V-DROP", "PRE-DROP") end

do local _ = ZG.SYNONYM("POUR", "SPILL") end

-- zil: gsyntax.zil:366  <SYNTAX PRAY = V-PRAY>
do local _ = ZG.SYNTAX("PRAY", "=", "V-PRAY") end

-- zil: gsyntax.zil:368  <SYNTAX PULL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("PULL", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:369  <SYNTAX PULL ON OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("PULL", "ON", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:370  <SYNTAX PULL UP OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("PULL", "UP", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

do local _ = ZG.SYNONYM("PULL", "TUG", "YANK") end

-- zil: gsyntax.zil:373  <SYNTAX PUMP UP OBJECT = V-PUMP>
do local _ = ZG.SYNTAX("PUMP", "UP", "OBJECT", "=", "V-PUMP") end

-- zil: gsyntax.zil:374  <SYNTAX PUMP UP OBJECT WITH OBJECT = V-PUMP>
do local _ = ZG.SYNTAX("PUMP", "UP", "OBJECT", "WITH", "OBJECT", "=", "V-PUMP") end

-- zil: gsyntax.zil:376  <SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND) OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:377  <SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND) TO OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "TO", "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:378  <SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND MANY) = V-PUSH>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", {"IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-PUSH") end

-- zil: gsyntax.zil:379  <SYNTAX PUSH ON OBJECT (IN-ROOM ON-GROUND MANY) = V-PUSH>
do local _ = ZG.SYNTAX("PUSH", "ON", "OBJECT", {"IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-PUSH") end

-- zil: gsyntax.zil:380  <SYNTAX PUSH OBJECT WITH OBJECT (FIND TOOLBIT) = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:381  <SYNTAX PUSH OBJECT UNDER OBJECT = V-PUT-UNDER>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", "UNDER", "OBJECT", "=", "V-PUT-UNDER") end

do local _ = ZG.SYNONYM("PUSH", "PRESS") end

-- zil: gsyntax.zil:384  <SYNTAX PUT OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "MANY", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:385  <SYNTAX PUT OBJECT (HELD MANY HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "MANY", "HAVE"}, "ON", "OBJECT", "=", "V-PUT-ON", "PRE-PUT") end

-- zil: gsyntax.zil:386  <SYNTAX PUT DOWN OBJECT (HELD MANY) = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("PUT", "DOWN", "OBJECT", {"HELD", "MANY"}, "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:387  <SYNTAX PUT OBJECT (HELD HAVE) UNDER OBJECT = V-PUT-UNDER>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "HAVE"}, "UNDER", "OBJECT", "=", "V-PUT-UNDER") end

-- zil: gsyntax.zil:388  <SYNTAX PUT OUT OBJECT (FIND ONBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE HAVE...
do local _ = ZG.SYNTAX("PUT", "OUT", "OBJECT", {"FIND", "ONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-OFF") end

-- zil: gsyntax.zil:390  <SYNTAX PUT ON OBJECT (IN-ROOM ON-GROUND CARRIED MANY) = V-WEAR>
do local _ = ZG.SYNTAX("PUT", "ON", "OBJECT", {"IN-ROOM", "ON-GROUND", "CARRIED", "MANY"}, "=", "V-WEAR") end

-- zil: gsyntax.zil:391  <SYNTAX PUT OBJECT (HELD MANY HAVE) BEHIND OBJECT = V-PUT-BEHIND>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "MANY", "HAVE"}, "BEHIND", "OBJECT", "=", "V-PUT-BEHIND") end

do local _ = ZG.SYNONYM("PUT", "STUFF", "INSERT", "PLACE", "HIDE") end

-- zil: gsyntax.zil:394  <SYNTAX RAISE OBJECT = V-RAISE>
do local _ = ZG.SYNTAX("RAISE", "OBJECT", "=", "V-RAISE") end

-- zil: gsyntax.zil:395  <SYNTAX RAISE UP OBJECT = V-RAISE>
do local _ = ZG.SYNTAX("RAISE", "UP", "OBJECT", "=", "V-RAISE") end

do local _ = ZG.SYNONYM("RAISE", "LIFT") end

-- zil: gsyntax.zil:398  <SYNTAX RAPE OBJECT (FIND ACTORBIT) = V-RAPE>
do local _ = ZG.SYNTAX("RAPE", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-RAPE") end

do local _ = ZG.SYNONYM("RAPE", "MOLEST") end

-- zil: gsyntax.zil:401  <SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-...
do local _ = ZG.SYNTAX("READ", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:403  <SYNTAX READ FROM OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)...
do local _ = ZG.SYNTAX("READ", "FROM", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:405  <SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) WITH...
do local _ = ZG.SYNTAX("READ", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "WITH", "OBJECT", "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:407  <SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) OBJE...
do local _ = ZG.SYNTAX("READ", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "OBJECT", "=", "V-READ-PAGE") end

do local _ = ZG.SYNONYM("READ", "SKIM") end

-- zil: gsyntax.zil:411  <SYNTAX REPENT = V-REPENT>
do local _ = ZG.SYNTAX("REPENT", "=", "V-REPENT") end

-- zil: gsyntax.zil:413  <SYNTAX RING OBJECT (TAKE) = V-RING>
do local _ = ZG.SYNTAX("RING", "OBJECT", {"TAKE"}, "=", "V-RING") end

-- zil: gsyntax.zil:414  <SYNTAX RING OBJECT (TAKE) WITH OBJECT = V-RING>
do local _ = ZG.SYNTAX("RING", "OBJECT", {"TAKE"}, "WITH", "OBJECT", "=", "V-RING") end

do local _ = ZG.SYNONYM("RING", "PEAL") end

-- zil: gsyntax.zil:417  <SYNTAX RUB OBJECT = V-RUB>
do local _ = ZG.SYNTAX("RUB", "OBJECT", "=", "V-RUB") end

-- zil: gsyntax.zil:418  <SYNTAX RUB OBJECT WITH OBJECT = V-RUB>
do local _ = ZG.SYNTAX("RUB", "OBJECT", "WITH", "OBJECT", "=", "V-RUB") end

do local _ = ZG.SYNONYM("RUB", "TOUCH", "FEEL", "PAT", "PET") end

-- zil: gsyntax.zil:421  <SYNTAX TALK TO OBJECT (FIND ACTORBIT) (IN-ROOM) = V-TELL>
do local _ = ZG.SYNTAX("TALK", "TO", "OBJECT", {"FIND", "ACTORBIT"}, {"IN-ROOM"}, "=", "V-TELL") end

-- zil: gsyntax.zil:422  <SYNTAX SAY = V-SAY>
do local _ = ZG.SYNTAX("SAY", "=", "V-SAY") end

-- zil: gsyntax.zil:424  <SYNTAX SEARCH OBJECT = V-SEARCH>
do local _ = ZG.SYNTAX("SEARCH", "OBJECT", "=", "V-SEARCH") end

-- zil: gsyntax.zil:425  <SYNTAX SEARCH IN OBJECT = V-SEARCH>
do local _ = ZG.SYNTAX("SEARCH", "IN", "OBJECT", "=", "V-SEARCH") end

-- zil: gsyntax.zil:426  <SYNTAX SEARCH FOR OBJECT = V-FIND>
do local _ = ZG.SYNTAX("SEARCH", "FOR", "OBJECT", "=", "V-FIND") end

-- zil: gsyntax.zil:428  <SYNTAX SEND FOR OBJECT = V-SEND>
do local _ = ZG.SYNTAX("SEND", "FOR", "OBJECT", "=", "V-SEND") end

-- zil: gsyntax.zil:430  <SYNTAX SHAKE OBJECT (HAVE) = V-SHAKE>
do local _ = ZG.SYNTAX("SHAKE", "OBJECT", {"HAVE"}, "=", "V-SHAKE") end

-- zil: gsyntax.zil:432  <SYNTAX SKIP = V-SKIP>
do local _ = ZG.SYNTAX("SKIP", "=", "V-SKIP") end

do local _ = ZG.SYNONYM("SKIP", "HOP") end

-- zil: gsyntax.zil:435  <SYNTAX SLIDE OBJECT UNDER OBJECT = V-PUT-UNDER>
do local _ = ZG.SYNTAX("SLIDE", "OBJECT", "UNDER", "OBJECT", "=", "V-PUT-UNDER") end

-- zil: gsyntax.zil:436  <SYNTAX SLIDE OBJECT (IN-ROOM ON-GROUND) OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("SLIDE", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:437  <SYNTAX SLIDE OBJECT (IN-ROOM ON-GROUND) TO OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("SLIDE", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "TO", "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:439  <SYNTAX SMELL OBJECT = V-SMELL>
do local _ = ZG.SYNTAX("SMELL", "OBJECT", "=", "V-SMELL") end

do local _ = ZG.SYNONYM("SMELL", "SNIFF") end

-- zil: gsyntax.zil:442  <SYNTAX SPIN OBJECT = V-SPIN>
do local _ = ZG.SYNTAX("SPIN", "OBJECT", "=", "V-SPIN") end

-- zil: gsyntax.zil:444  <SYNTAX SPRAY OBJECT ON OBJECT = V-SPRAY>
do local _ = ZG.SYNTAX("SPRAY", "OBJECT", "ON", "OBJECT", "=", "V-SPRAY") end

-- zil: gsyntax.zil:445  <SYNTAX SPRAY OBJECT WITH OBJECT = V-SSPRAY>
do local _ = ZG.SYNTAX("SPRAY", "OBJECT", "WITH", "OBJECT", "=", "V-SSPRAY") end

-- zil: gsyntax.zil:447  <SYNTAX SQUEEZE OBJECT = V-SQUEEZE>
do local _ = ZG.SYNTAX("SQUEEZE", "OBJECT", "=", "V-SQUEEZE") end

-- zil: gsyntax.zil:448  <SYNTAX SQUEEZE OBJECT ON OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("SQUEEZE", "OBJECT", "ON", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:450  <SYNTAX STAND = V-STAND>
do local _ = ZG.SYNTAX("STAND", "=", "V-STAND") end

-- zil: gsyntax.zil:451  <SYNTAX STAND UP OBJECT (FIND RMUNGBIT) = V-STAND>
do local _ = ZG.SYNTAX("STAND", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-STAND") end

-- zil: gsyntax.zil:453  <SYNTAX STAY = V-STAY>
do local _ = ZG.SYNTAX("STAY", "=", "V-STAY") end

-- zil: gsyntax.zil:455  <SYNTAX STRIKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND W...
do local _ = ZG.SYNTAX("STRIKE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "HAVE"}, "=", "V-ATTACK") end

-- zil: gsyntax.zil:457  <SYNTAX STRIKE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-STRIKE>
do local _ = ZG.SYNTAX("STRIKE", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-STRIKE") end

-- zil: gsyntax.zil:459  <SYNTAX SWIM = V-SWIM>
do local _ = ZG.SYNTAX("SWIM", "=", "V-SWIM") end

-- zil: gsyntax.zil:460  <SYNTAX SWIM IN OBJECT = V-SWIM>
do local _ = ZG.SYNTAX("SWIM", "IN", "OBJECT", "=", "V-SWIM") end

-- zil: gsyntax.zil:461  <SYNTAX SWIM ACROSS OBJECT = V-SWIM>
do local _ = ZG.SYNTAX("SWIM", "ACROSS", "OBJECT", "=", "V-SWIM") end

do local _ = ZG.SYNONYM("SWIM", "BATHE", "WADE") end

-- zil: gsyntax.zil:464  <SYNTAX SWING OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-SWING>
do local _ = ZG.SYNTAX("SWING", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-SWING") end

-- zil: gsyntax.zil:465  <SYNTAX SWING OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) AT OBJECT (FIND ACT...
do local _ = ZG.SYNTAX("SWING", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "AT", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-SWING") end

do local _ = ZG.SYNONYM("SWING", "THRUST") end

-- zil: gsyntax.zil:469  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (ON-GROUND IN-ROOM MANY) = V-TAKE PRE-TAKE>
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:470  <SYNTAX TAKE IN OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
do local _ = ZG.SYNTAX("TAKE", "IN", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-BOARD", "PRE-BOARD") end

-- zil: gsyntax.zil:471  <SYNTAX TAKE OUT OBJECT (FIND RMUNGBIT) (ON-GROUND IN-ROOM) = V-DISEMBARK>
do local _ = ZG.SYNTAX("TAKE", "OUT", "OBJECT", {"FIND", "RMUNGBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-DISEMBARK") end

-- zil: gsyntax.zil:472  <SYNTAX TAKE ON OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-CLIMB-ON>
do local _ = ZG.SYNTAX("TAKE", "ON", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-ON") end

-- zil: gsyntax.zil:473  <SYNTAX TAKE UP OBJECT (FIND RMUNGBIT) = V-STAND>
do local _ = ZG.SYNTAX("TAKE", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-STAND") end

-- zil: gsyntax.zil:474  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (CARRIED IN-ROOM MANY) OUT OBJECT = V-TAKE...
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"CARRIED", "IN-ROOM", "MANY"}, "OUT", "OBJECT", "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:476  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (CARRIED IN-ROOM MANY) OFF OBJECT = V-TAKE...
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"CARRIED", "IN-ROOM", "MANY"}, "OFF", "OBJECT", "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:478  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (IN-ROOM CARRIED MANY) FROM OBJECT = V-TAK...
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"IN-ROOM", "CARRIED", "MANY"}, "FROM", "OBJECT", "=", "V-TAKE", "PRE-TAKE") end

do local _ = ZG.SYNONYM("TAKE", "GET", "HOLD", "CARRY", "REMOVE", "GRAB", "CATCH") end

-- zil: gsyntax.zil:482  <SYNTAX TELL OBJECT (FIND ACTORBIT) (IN-ROOM) = V-TELL>
do local _ = ZG.SYNTAX("TELL", "OBJECT", {"FIND", "ACTORBIT"}, {"IN-ROOM"}, "=", "V-TELL") end

-- zil: gsyntax.zil:483  <SYNTAX TELL OBJECT (FIND ACTORBIT) (IN-ROOM) ABOUT OBJECT = V-TELL>
do local _ = ZG.SYNTAX("TELL", "OBJECT", {"FIND", "ACTORBIT"}, {"IN-ROOM"}, "ABOUT", "OBJECT", "=", "V-TELL") end

do local _ = ZG.SYNONYM("TELL", "ASK") end

-- zil: gsyntax.zil:486  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) AT OBJECT (FIND ACTORBIT) (ON-GROUND...
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "AT", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-THROW") end

-- zil: gsyntax.zil:488  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) WITH OBJECT (FIND ACTORBIT) (ON-GROU...
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "WITH", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-THROW") end

-- zil: gsyntax.zil:490  <SYNTAX THROW OBJECT OBJECT = V-OVERBOARD>
do local _ = ZG.SYNTAX("THROW", "OBJECT", "OBJECT", "=", "V-OVERBOARD") end

-- zil: gsyntax.zil:491  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:492  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "ON", "OBJECT", "=", "V-PUT-ON", "PRE-PUT") end

-- zil: gsyntax.zil:493  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) OFF OBJECT = V-THROW-OFF>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "OFF", "OBJECT", "=", "V-THROW-OFF") end

-- zil: gsyntax.zil:494  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) OVER OBJECT = V-THROW-OFF>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "OVER", "OBJECT", "=", "V-THROW-OFF") end

do local _ = ZG.SYNONYM("THROW", "HURL", "CHUCK", "TOSS") end

-- zil: gsyntax.zil:497  <SYNTAX TIE OBJECT TO OBJECT = V-TIE>
do local _ = ZG.SYNTAX("TIE", "OBJECT", "TO", "OBJECT", "=", "V-TIE") end

-- zil: gsyntax.zil:498  <SYNTAX TIE UP OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND T...
do local _ = ZG.SYNTAX("TIE", "UP", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED", "HAVE"}, "=", "V-TIE-UP") end

do local _ = ZG.SYNONYM("TIE", "FASTEN", "SECURE", "ATTACH") end

-- zil: gsyntax.zil:502  <SYNTAX TREASURE = V-TREASURE>
do local _ = ZG.SYNTAX("TREASURE", "=", "V-TREASURE") end

do local _ = ZG.SYNONYM("TREASURE", "TEMPLE") end

-- zil: gsyntax.zil:505  <SYNTAX TURN OBJECT (FIND TURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("TURN", "OBJECT", {"FIND", "TURNBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:507  <SYNTAX TURN ON OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-L...
do local _ = ZG.SYNTAX("TURN", "ON", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:509  <SYNTAX TURN ON OBJECT WITH OBJECT (HAVE) = V-LAMP-ON>
do local _ = ZG.SYNTAX("TURN", "ON", "OBJECT", "WITH", "OBJECT", {"HAVE"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:510  <SYNTAX TURN OFF OBJECT (FIND ONBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE HAV...
do local _ = ZG.SYNTAX("TURN", "OFF", "OBJECT", {"FIND", "ONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-OFF") end

-- zil: gsyntax.zil:512  <SYNTAX TURN OBJECT (FIND TURNBIT) TO OBJECT = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("TURN", "OBJECT", {"FIND", "TURNBIT"}, "TO", "OBJECT", "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:513  <SYNTAX TURN OBJECT (FIND TURNBIT) FOR OBJECT = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("TURN", "OBJECT", {"FIND", "TURNBIT"}, "FOR", "OBJECT", "=", "V-TURN", "PRE-TURN") end

do local _ = ZG.SYNONYM("TURN", "SET", "FLIP", "SHUT") end

-- zil: gsyntax.zil:516  <SYNTAX UNLOCK OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CA...
do local _ = ZG.SYNTAX("UNLOCK", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-UNLOCK") end

-- zil: gsyntax.zil:519  <SYNTAX UNTIE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-UNTIE>
do local _ = ZG.SYNTAX("UNTIE", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-UNTIE") end

-- zil: gsyntax.zil:520  <SYNTAX UNTIE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) FROM OBJECT = V-UNTIE>
do local _ = ZG.SYNTAX("UNTIE", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "FROM", "OBJECT", "=", "V-UNTIE") end

do local _ = ZG.SYNONYM("UNTIE", "FREE", "RELEASE", "UNFASTEN", "UNATTACH", "UNHOOK") end

-- zil: gsyntax.zil:524  <SYNTAX WAIT = V-WAIT>
do local _ = ZG.SYNTAX("WAIT", "=", "V-WAIT") end

do local _ = ZG.SYNONYM("WAIT", "Z") end

-- zil: gsyntax.zil:527  <SYNTAX WAKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALARM>
do local _ = ZG.SYNTAX("WAKE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ALARM") end

-- zil: gsyntax.zil:528  <SYNTAX WAKE UP OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALARM>
do local _ = ZG.SYNTAX("WAKE", "UP", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ALARM") end

do local _ = ZG.SYNONYM("WAKE", "AWAKE", "SURPRISE", "STARTLE") end

-- zil: gsyntax.zil:531  <SYNTAX WALK = V-WALK-AROUND>
do local _ = ZG.SYNTAX("WALK", "=", "V-WALK-AROUND") end

-- zil: gsyntax.zil:532  <SYNTAX WALK OBJECT = V-WALK>
do local _ = ZG.SYNTAX("WALK", "OBJECT", "=", "V-WALK") end

-- zil: gsyntax.zil:533  <SYNTAX WALK AWAY OBJECT = V-WALK>
do local _ = ZG.SYNTAX("WALK", "AWAY", "OBJECT", "=", "V-WALK") end

-- zil: gsyntax.zil:534  <SYNTAX WALK IN OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("WALK", "IN", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:535  <SYNTAX WALK WITH OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("WALK", "WITH", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:536  <SYNTAX WALK ON OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("WALK", "ON", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:537  <SYNTAX WALK OVER OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("WALK", "OVER", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:538  <SYNTAX WALK TO OBJECT = V-WALK-TO>
do local _ = ZG.SYNTAX("WALK", "TO", "OBJECT", "=", "V-WALK-TO") end

-- zil: gsyntax.zil:539  <SYNTAX WALK AROUND OBJECT = V-WALK-AROUND>
do local _ = ZG.SYNTAX("WALK", "AROUND", "OBJECT", "=", "V-WALK-AROUND") end

-- zil: gsyntax.zil:540  <SYNTAX WALK UP OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-UP>
do local _ = ZG.SYNTAX("WALK", "UP", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-UP") end

-- zil: gsyntax.zil:541  <SYNTAX WALK DOWN OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-DOWN>
do local _ = ZG.SYNTAX("WALK", "DOWN", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-DOWN") end

do local _ = ZG.SYNONYM("WALK", "GO", "RUN", "PROCEED", "STEP") end

-- zil: gsyntax.zil:544  <SYNTAX WAVE OBJECT (HELD CARRIED TAKE HAVE) = V-WAVE>
do local _ = ZG.SYNTAX("WAVE", "OBJECT", {"HELD", "CARRIED", "TAKE", "HAVE"}, "=", "V-WAVE") end

-- zil: gsyntax.zil:545  <SYNTAX WAVE OBJECT (HELD CARRIED TAKE HAVE) AT OBJECT = V-WAVE>
do local _ = ZG.SYNTAX("WAVE", "OBJECT", {"HELD", "CARRIED", "TAKE", "HAVE"}, "AT", "OBJECT", "=", "V-WAVE") end

-- zil: gsyntax.zil:546  <SYNTAX WAVE AT OBJECT = V-WAVE>
do local _ = ZG.SYNTAX("WAVE", "AT", "OBJECT", "=", "V-WAVE") end

do local _ = ZG.SYNONYM("WAVE", "BRANDISH") end

-- zil: gsyntax.zil:549  <SYNTAX WEAR OBJECT = V-WEAR>
do local _ = ZG.SYNTAX("WEAR", "OBJECT", "=", "V-WEAR") end

-- zil: gsyntax.zil:551  <SYNTAX WIN = V-WIN>
do local _ = ZG.SYNTAX("WIN", "=", "V-WIN") end

do local _ = ZG.SYNONYM("WIN", "WINNAGE") end

-- zil: gsyntax.zil:554  <SYNTAX WIND OBJECT = V-WIND>
do local _ = ZG.SYNTAX("WIND", "OBJECT", "=", "V-WIND") end

-- zil: gsyntax.zil:555  <SYNTAX WIND UP OBJECT = V-WIND>
do local _ = ZG.SYNTAX("WIND", "UP", "OBJECT", "=", "V-WIND") end

-- zil: gsyntax.zil:557  <SYNTAX WISH = V-WISH>
do local _ = ZG.SYNTAX("WISH", "=", "V-WISH") end

-- zil: gsyntax.zil:559  <SYNTAX YELL = V-YELL>
do local _ = ZG.SYNTAX("YELL", "=", "V-YELL") end

do local _ = ZG.SYNONYM("YELL", "SCREAM", "SHOUT") end

-- zil: gsyntax.zil:562  <SYNTAX ZORK = V-ZORK>
do local _ = ZG.SYNTAX("ZORK", "=", "V-ZORK") end
