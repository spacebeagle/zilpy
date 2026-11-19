-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

do local _ = ZG.BUZZ("AGAIN", "G", "OOPS") end

do local _ = ZG.BUZZ("A", "AN", "THE", "IS", "AND", "OF", "THEN", "ALL", "ONE", "BUT", "EXCEPT", ".", ",", "\"", "YES", "NO", "Y", "HERE") end

do local _ = ZG.BUZZ("FEEBLE", "FUMBLE", "FEAR", "FILCH", "FREEZE", "FALL", "FRY", "FLUORESCE", "FERMENT", "FIERCE", "FLOAT", "FIREPROOF", "FENCE", "FUDGE", "FANTASIZE", "FROTZ", "OZMOO") end

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

-- ;<SYNTAX DEBUG = V-DEBUG>

-- zil: gsyntax.zil:85  <SYNTAX ACTIVATE OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-...
do local _ = ZG.SYNTAX("ACTIVATE", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-LAMP-ON") end

-- ;<SYNTAX AGAIN = V-AGAIN>

-- ;<SYNONYM AGAIN G>

-- zil: gsyntax.zil:91  <SYNTAX ANSWER = V-ANSWER>
do local _ = ZG.SYNTAX("ANSWER", "=", "V-ANSWER") end

-- zil: gsyntax.zil:92  <SYNTAX ANSWER OBJECT = V-REPLY>
do local _ = ZG.SYNTAX("ANSWER", "OBJECT", "=", "V-REPLY") end

do local _ = ZG.SYNONYM("ANSWER", "REPLY") end

-- zil: gsyntax.zil:95  <SYNTAX APPLY OBJECT TO OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("APPLY", "OBJECT", "TO", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:98  <SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
do local _ = ZG.SYNTAX("ATTACK", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ATTACK") end

-- zil: gsyntax.zil:101  <SYNTAX ATTACK OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND W...
do local _ = ZG.SYNTAX("ATTACK", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-ATTACK") end

do local _ = ZG.SYNONYM("ATTACK", "FIGHT", "HURT", "INJURE", "HIT") end

-- zil: gsyntax.zil:105  <SYNTAX BACK = V-BACK>
do local _ = ZG.SYNTAX("BACK", "=", "V-BACK") end

-- zil: gsyntax.zil:107  <SYNTAX BLAST = V-BLAST>
do local _ = ZG.SYNTAX("BLAST", "=", "V-BLAST") end

-- zil: gsyntax.zil:109  <SYNTAX BLOW OUT OBJECT = V-LAMP-OFF>
do local _ = ZG.SYNTAX("BLOW", "OUT", "OBJECT", "=", "V-LAMP-OFF") end

-- zil: gsyntax.zil:110  <SYNTAX BLOW UP OBJECT WITH OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CAR...
do local _ = ZG.SYNTAX("BLOW", "UP", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-INFLATE") end

-- zil: gsyntax.zil:112  <SYNTAX BLOW UP OBJECT = V-BLAST>
do local _ = ZG.SYNTAX("BLOW", "UP", "OBJECT", "=", "V-BLAST") end

-- zil: gsyntax.zil:113  <SYNTAX BLOW IN OBJECT = V-BREATHE>
do local _ = ZG.SYNTAX("BLOW", "IN", "OBJECT", "=", "V-BREATHE") end

-- zil: gsyntax.zil:115  <SYNTAX BOARD OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
do local _ = ZG.SYNTAX("BOARD", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-BOARD", "PRE-BOARD") end

-- zil: gsyntax.zil:117  <SYNTAX BRUSH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) = V-BRUSH>
do local _ = ZG.SYNTAX("BRUSH", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-BRUSH") end

-- zil: gsyntax.zil:118  <SYNTAX BRUSH OBJECT (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJECT = V-BRUSH>
do local _ = ZG.SYNTAX("BRUSH", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", "=", "V-BRUSH") end

do local _ = ZG.SYNONYM("BRUSH", "CLEAN") end

-- zil: gsyntax.zil:122  <SYNTAX BUG = V-BUG>
do local _ = ZG.SYNTAX("BUG", "=", "V-BUG") end

-- zil: gsyntax.zil:124  <SYNTAX BURN OBJECT (FIND BURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("BURN", "OBJECT", {"FIND", "BURNBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "HAVE"}, "=", "V-BURN", "PRE-BURN") end

-- zil: gsyntax.zil:127  <SYNTAX BURN DOWN OBJECT (FIND BURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH...
do local _ = ZG.SYNTAX("BURN", "DOWN", "OBJECT", {"FIND", "BURNBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "HAVE"}, "=", "V-BURN", "PRE-BURN") end

do local _ = ZG.SYNONYM("BURN", "INCINERATE", "IGNITE") end

-- zil: gsyntax.zil:132  <SYNTAX CHOMP = V-CHOMP>
do local _ = ZG.SYNTAX("CHOMP", "=", "V-CHOMP") end

do local _ = ZG.SYNONYM("CHOMP", "LOSE", "BARF") end

-- zil: gsyntax.zil:135  <SYNTAX CLIMB UP OBJECT (FIND RMUNGBIT) = V-CLIMB-UP>
do local _ = ZG.SYNTAX("CLIMB", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-CLIMB-UP") end

-- zil: gsyntax.zil:136  <SYNTAX CLIMB UP OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-UP>
do local _ = ZG.SYNTAX("CLIMB", "UP", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-UP") end

-- zil: gsyntax.zil:137  <SYNTAX CLIMB DOWN OBJECT (FIND RMUNGBIT) = V-CLIMB-DOWN>
do local _ = ZG.SYNTAX("CLIMB", "DOWN", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-CLIMB-DOWN") end

-- zil: gsyntax.zil:138  <SYNTAX CLIMB DOWN OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-DOWN>
do local _ = ZG.SYNTAX("CLIMB", "DOWN", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-DOWN") end

-- zil: gsyntax.zil:139  <SYNTAX CLIMB OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-FOO>
do local _ = ZG.SYNTAX("CLIMB", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-FOO") end

-- zil: gsyntax.zil:140  <SYNTAX CLIMB IN OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
do local _ = ZG.SYNTAX("CLIMB", "IN", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-BOARD", "PRE-BOARD") end

-- zil: gsyntax.zil:141  <SYNTAX CLIMB ON OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-CLIMB-ON>
do local _ = ZG.SYNTAX("CLIMB", "ON", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-ON") end

-- zil: gsyntax.zil:142  <SYNTAX CLIMB WITH OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("CLIMB", "WITH", "OBJECT", "=", "V-THROUGH") end

do local _ = ZG.SYNONYM("CLIMB", "SIT") end

-- zil: gsyntax.zil:145  <SYNTAX CLOSE OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-CLOSE>
do local _ = ZG.SYNTAX("CLOSE", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-CLOSE") end

-- zil: gsyntax.zil:147  <SYNTAX COMMAND OBJECT (FIND ACTORBIT) = V-COMMAND>
do local _ = ZG.SYNTAX("COMMAND", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-COMMAND") end

-- zil: gsyntax.zil:149  <SYNTAX COUNT OBJECT = V-COUNT>
do local _ = ZG.SYNTAX("COUNT", "OBJECT", "=", "V-COUNT") end

-- zil: gsyntax.zil:151  <SYNTAX CROSS OBJECT = V-CROSS>
do local _ = ZG.SYNTAX("CROSS", "OBJECT", "=", "V-CROSS") end

do local _ = ZG.SYNONYM("CROSS", "FORD") end

-- zil: gsyntax.zil:154  <SYNTAX CUT OBJECT WITH OBJECT (FIND WEAPONBIT) (CARRIED HELD) = V-CUT>
do local _ = ZG.SYNTAX("CUT", "OBJECT", "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"CARRIED", "HELD"}, "=", "V-CUT") end

do local _ = ZG.SYNONYM("CUT", "SLICE", "PIERCE") end

-- zil: gsyntax.zil:157  <SYNTAX CURSE = V-CURSES>
do local _ = ZG.SYNTAX("CURSE", "=", "V-CURSES") end

-- zil: gsyntax.zil:158  <SYNTAX CURSE OBJECT (FIND ACTORBIT) = V-CURSES>
do local _ = ZG.SYNTAX("CURSE", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-CURSES") end

do local _ = ZG.SYNONYM("CURSE", "SHIT", "FUCK", "DAMN") end

-- zil: gsyntax.zil:161  <SYNTAX DEFLATE OBJECT = V-DEFLATE>
do local _ = ZG.SYNTAX("DEFLATE", "OBJECT", "=", "V-DEFLATE") end

-- zil: gsyntax.zil:163  <SYNTAX DESTROY OBJECT (ON-GROUND IN-ROOM HELD CARRIED) WITH OBJECT (HELD CAR...
do local _ = ZG.SYNTAX("DESTROY", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "WITH", "OBJECT", {"HELD", "CARRIED", "TAKE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:165  <SYNTAX DESTROY DOWN OBJECT (ON-GROUND IN-ROOM HELD CARRIED) WITH OBJECT (HEL...
do local _ = ZG.SYNTAX("DESTROY", "DOWN", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "WITH", "OBJECT", {"HELD", "CARRIED", "TAKE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:167  <SYNTAX DESTROY IN OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-OPEN>
do local _ = ZG.SYNTAX("DESTROY", "IN", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-OPEN") end

do local _ = ZG.SYNONYM("DESTROY", "DAMAGE", "BREAK", "BLOCK", "SMASH") end

-- zil: gsyntax.zil:170  <SYNTAX DIG IN OBJECT (ON-GROUND IN-ROOM) = V-DIG>
do local _ = ZG.SYNTAX("DIG", "IN", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-DIG") end

-- zil: gsyntax.zil:171  <SYNTAX DIG IN OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CA...
do local _ = ZG.SYNTAX("DIG", "IN", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-DIG") end

-- zil: gsyntax.zil:173  <SYNTAX DIG OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CARRI...
do local _ = ZG.SYNTAX("DIG", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-DIG") end

-- zil: gsyntax.zil:176  <SYNTAX DISEMBARK OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-DISEMBARK>
do local _ = ZG.SYNTAX("DISEMBARK", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-DISEMBARK") end

-- zil: gsyntax.zil:179  <SYNTAX DISENCHANT OBJECT = V-DISENCHANT>
do local _ = ZG.SYNTAX("DISENCHANT", "OBJECT", "=", "V-DISENCHANT") end

-- zil: gsyntax.zil:181  <SYNTAX DRINK OBJECT (FIND DRINKBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-DRINK>
do local _ = ZG.SYNTAX("DRINK", "OBJECT", {"FIND", "DRINKBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-DRINK") end

-- zil: gsyntax.zil:183  <SYNTAX DRINK FROM OBJECT (HELD CARRIED) = V-DRINK-FROM>
do local _ = ZG.SYNTAX("DRINK", "FROM", "OBJECT", {"HELD", "CARRIED"}, "=", "V-DRINK-FROM") end

do local _ = ZG.SYNONYM("DRINK", "IMBIBE", "SWALLOW") end

-- zil: gsyntax.zil:186  <SYNTAX DROP OBJECT (HELD MANY HAVE) = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:187  <SYNTAX DROP OBJECT (HELD MANY HAVE) DOWN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "DOWN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:188  <SYNTAX DROP OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:189  <SYNTAX DROP OBJECT (HELD MANY HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
do local _ = ZG.SYNTAX("DROP", "OBJECT", {"HELD", "MANY", "HAVE"}, "ON", "OBJECT", "=", "V-PUT-ON", "PRE-PUT") end

-- ;<SYNONYM DROP RELEASE>

-- zil: gsyntax.zil:192  <SYNTAX EAT OBJECT (FIND FOODBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-EAT>
do local _ = ZG.SYNTAX("EAT", "OBJECT", {"FIND", "FOODBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-EAT") end

do local _ = ZG.SYNONYM("EAT", "CONSUME", "TASTE", "BITE") end

-- zil: gsyntax.zil:196  <SYNTAX ECHO = V-ECHO>
do local _ = ZG.SYNTAX("ECHO", "=", "V-ECHO") end

-- zil: gsyntax.zil:198  <SYNTAX ENCHANT OBJECT (ON-GROUND IN-ROOM) = V-ENCHANT>
do local _ = ZG.SYNTAX("ENCHANT", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-ENCHANT") end

-- zil: gsyntax.zil:200  <SYNTAX ENTER = V-ENTER>
do local _ = ZG.SYNTAX("ENTER", "=", "V-ENTER") end

-- zil: gsyntax.zil:201  <SYNTAX ENTER OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("ENTER", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:202  <SYNTAX EXIT = V-EXIT>
do local _ = ZG.SYNTAX("EXIT", "=", "V-EXIT") end

-- zil: gsyntax.zil:203  <SYNTAX EXIT OBJECT = V-EXIT>
do local _ = ZG.SYNTAX("EXIT", "OBJECT", "=", "V-EXIT") end

-- zil: gsyntax.zil:205  <SYNTAX EXAMINE OBJECT (MANY) = V-EXAMINE>
do local _ = ZG.SYNTAX("EXAMINE", "OBJECT", {"MANY"}, "=", "V-EXAMINE") end

-- zil: gsyntax.zil:206  <SYNTAX EXAMINE IN OBJECT (HELD CARRIED IN-ROOM ON-GROUND MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("EXAMINE", "IN", "OBJECT", {"HELD", "CARRIED", "IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-LOOK-INSIDE") end

-- zil: gsyntax.zil:208  <SYNTAX EXAMINE ON OBJECT (HELD CARRIED IN-ROOM ON-GROUND MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("EXAMINE", "ON", "OBJECT", {"HELD", "CARRIED", "IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-LOOK-INSIDE") end

do local _ = ZG.SYNONYM("EXAMINE", "DESCRIBE", "WHAT", "WHATS") end

-- zil: gsyntax.zil:212  <SYNTAX EXORCISE OBJECT = V-EXORCISE>
do local _ = ZG.SYNTAX("EXORCISE", "OBJECT", "=", "V-EXORCISE") end

-- zil: gsyntax.zil:213  <SYNTAX EXORCISE OUT OBJECT (FIND ACTORBIT) = V-EXORCISE>
do local _ = ZG.SYNTAX("EXORCISE", "OUT", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-EXORCISE") end

-- zil: gsyntax.zil:214  <SYNTAX EXORCISE AWAY OBJECT (FIND ACTORBIT) = V-EXORCISE>
do local _ = ZG.SYNTAX("EXORCISE", "AWAY", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-EXORCISE") end

do local _ = ZG.SYNONYM("EXORCISE", "BANISH", "CAST", "DRIVE", "BEGONE") end

-- zil: gsyntax.zil:217  <SYNTAX EXTINGUISH OBJECT (FIND ONBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE H...
do local _ = ZG.SYNTAX("EXTINGUISH", "OBJECT", {"FIND", "ONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-OFF") end

do local _ = ZG.SYNONYM("EXTINGUISH", "DOUSE") end

-- zil: gsyntax.zil:221  <SYNTAX FILL OBJECT (FIND CONTBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("FILL", "OBJECT", {"FIND", "CONTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", "=", "V-FILL", "PRE-FILL") end

-- zil: gsyntax.zil:223  <SYNTAX FILL OBJECT (FIND CONTBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-FILL ...
do local _ = ZG.SYNTAX("FILL", "OBJECT", {"FIND", "CONTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-FILL", "PRE-FILL") end

-- zil: gsyntax.zil:226  <SYNTAX FIND OBJECT = V-FIND>
do local _ = ZG.SYNTAX("FIND", "OBJECT", "=", "V-FIND") end

do local _ = ZG.SYNONYM("FIND", "WHERE", "SEEK", "SEE") end

-- zil: gsyntax.zil:229  <SYNTAX FOLLOW = V-FOLLOW>
do local _ = ZG.SYNTAX("FOLLOW", "=", "V-FOLLOW") end

-- zil: gsyntax.zil:230  <SYNTAX FOLLOW OBJECT = V-FOLLOW>
do local _ = ZG.SYNTAX("FOLLOW", "OBJECT", "=", "V-FOLLOW") end

do local _ = ZG.SYNONYM("FOLLOW", "PURSUE", "CHASE", "COME") end

-- zil: gsyntax.zil:233  <SYNTAX FROBOZZ = V-FROBOZZ>
do local _ = ZG.SYNTAX("FROBOZZ", "=", "V-FROBOZZ") end

-- zil: gsyntax.zil:235  <SYNTAX GIVE OBJECT (MANY HELD HAVE) TO OBJECT (FIND ACTORBIT) (ON-GROUND) = ...
do local _ = ZG.SYNTAX("GIVE", "OBJECT", {"MANY", "HELD", "HAVE"}, "TO", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND"}, "=", "V-GIVE", "PRE-GIVE") end

-- zil: gsyntax.zil:237  <SYNTAX GIVE OBJECT (FIND ACTORBIT) (ON-GROUND) OBJECT (MANY HELD HAVE) = V-S...
do local _ = ZG.SYNTAX("GIVE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND"}, "OBJECT", {"MANY", "HELD", "HAVE"}, "=", "V-SGIVE", "PRE-SGIVE") end

do local _ = ZG.SYNONYM("GIVE", "DONATE", "OFFER", "FEED") end

do local _ = ZG.SYNONYM("GIVE", "HAND") end

-- zil: gsyntax.zil:243  <SYNTAX HATCH OBJECT = V-HATCH>
do local _ = ZG.SYNTAX("HATCH", "OBJECT", "=", "V-HATCH") end

-- zil: gsyntax.zil:245  <SYNTAX HELLO = V-HELLO>
do local _ = ZG.SYNTAX("HELLO", "=", "V-HELLO") end

-- zil: gsyntax.zil:246  <SYNTAX HELLO OBJECT = V-HELLO>
do local _ = ZG.SYNTAX("HELLO", "OBJECT", "=", "V-HELLO") end

do local _ = ZG.SYNONYM("HELLO", "HI") end

-- zil: gsyntax.zil:249  <SYNTAX INCANT = V-INCANT>
do local _ = ZG.SYNTAX("INCANT", "=", "V-INCANT") end

do local _ = ZG.SYNONYM("INCANT", "CHANT") end

-- zil: gsyntax.zil:252  <SYNTAX INFLAT OBJECT WITH OBJECT (FIND TOOLBIT) (ON-GROUND IN-ROOM HELD CARR...
do local _ = ZG.SYNTAX("INFLAT", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-INFLATE") end

-- ;<SYNTAX IS OBJECT IN OBJECT = V-IS-IN>

-- ;<SYNTAX IS OBJECT ON OBJECT = V-IS-IN>

-- zil: gsyntax.zil:258  <SYNTAX JUMP = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "=", "V-LEAP") end

-- zil: gsyntax.zil:259  <SYNTAX JUMP OVER OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "OVER", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:260  <SYNTAX JUMP ACROSS OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "ACROSS", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:261  <SYNTAX JUMP IN OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "IN", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:262  <SYNTAX JUMP FROM OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "FROM", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:263  <SYNTAX JUMP OFF OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("JUMP", "OFF", "OBJECT", "=", "V-LEAP") end

do local _ = ZG.SYNONYM("JUMP", "LEAP", "DIVE") end

-- zil: gsyntax.zil:266  <SYNTAX KICK OBJECT = V-KICK>
do local _ = ZG.SYNTAX("KICK", "OBJECT", "=", "V-KICK") end

do local _ = ZG.SYNONYM("KICK", "TAUNT") end

-- zil: gsyntax.zil:270  <SYNTAX KILL OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
do local _ = ZG.SYNTAX("KILL", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ATTACK") end

-- zil: gsyntax.zil:273  <SYNTAX KILL OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND WEA...
do local _ = ZG.SYNTAX("KILL", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-ATTACK") end

do local _ = ZG.SYNONYM("KILL", "MURDER", "SLAY", "DISPATCH") end

-- zil: gsyntax.zil:277  <SYNTAX STAB OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-STAB>
do local _ = ZG.SYNTAX("STAB", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-STAB") end

-- zil: gsyntax.zil:278  <SYNTAX STAB OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND WEA...
do local _ = ZG.SYNTAX("STAB", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-ATTACK") end

-- zil: gsyntax.zil:281  <SYNTAX KISS OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-KISS>
do local _ = ZG.SYNTAX("KISS", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-KISS") end

-- zil: gsyntax.zil:283  <SYNTAX KNOCK AT OBJECT = V-KNOCK>
do local _ = ZG.SYNTAX("KNOCK", "AT", "OBJECT", "=", "V-KNOCK") end

-- zil: gsyntax.zil:284  <SYNTAX KNOCK ON OBJECT = V-KNOCK>
do local _ = ZG.SYNTAX("KNOCK", "ON", "OBJECT", "=", "V-KNOCK") end

-- zil: gsyntax.zil:285  <SYNTAX KNOCK DOWN OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ATTACK>
do local _ = ZG.SYNTAX("KNOCK", "DOWN", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ATTACK") end

do local _ = ZG.SYNONYM("KNOCK", "RAP") end

-- zil: gsyntax.zil:288  <SYNTAX LAUNCH OBJECT (FIND VEHBIT) = V-LAUNCH>
do local _ = ZG.SYNTAX("LAUNCH", "OBJECT", {"FIND", "VEHBIT"}, "=", "V-LAUNCH") end

-- zil: gsyntax.zil:290  <SYNTAX LEAN ON OBJECT (HELD HAVE) = V-LEAN-ON>
do local _ = ZG.SYNTAX("LEAN", "ON", "OBJECT", {"HELD", "HAVE"}, "=", "V-LEAN-ON") end

-- zil: gsyntax.zil:292  <SYNTAX LEAVE = V-LEAVE>
do local _ = ZG.SYNTAX("LEAVE", "=", "V-LEAVE") end

-- zil: gsyntax.zil:293  <SYNTAX LEAVE OBJECT = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("LEAVE", "OBJECT", "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:295  <SYNTAX LIGHT OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE HAV...
do local _ = ZG.SYNTAX("LIGHT", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:297  <SYNTAX LIGHT OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OB...
do local _ = ZG.SYNTAX("LIGHT", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "TAKE", "HAVE"}, "=", "V-BURN", "PRE-BURN") end

-- zil: gsyntax.zil:300  <SYNTAX LISTEN TO OBJECT = V-LISTEN>
do local _ = ZG.SYNTAX("LISTEN", "TO", "OBJECT", "=", "V-LISTEN") end

-- zil: gsyntax.zil:301  <SYNTAX LISTEN FOR OBJECT = V-LISTEN>
do local _ = ZG.SYNTAX("LISTEN", "FOR", "OBJECT", "=", "V-LISTEN") end

-- zil: gsyntax.zil:303  <SYNTAX LOCK OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CARR...
do local _ = ZG.SYNTAX("LOCK", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-LOCK") end

-- zil: gsyntax.zil:306  <SYNTAX LOOK = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "=", "V-LOOK") end

-- zil: gsyntax.zil:307  <SYNTAX LOOK AROUND OBJECT (FIND RMUNGBIT) = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "AROUND", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-LOOK") end

-- zil: gsyntax.zil:308  <SYNTAX LOOK UP OBJECT (FIND RMUNGBIT) = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-LOOK") end

-- zil: gsyntax.zil:309  <SYNTAX LOOK DOWN OBJECT (FIND RMUNGBIT) = V-LOOK>
do local _ = ZG.SYNTAX("LOOK", "DOWN", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-LOOK") end

-- zil: gsyntax.zil:310  <SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-EXAMINE>
do local _ = ZG.SYNTAX("LOOK", "AT", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-EXAMINE") end

-- zil: gsyntax.zil:311  <SYNTAX LOOK ON OBJECT = V-LOOK-ON>
do local _ = ZG.SYNTAX("LOOK", "ON", "OBJECT", "=", "V-LOOK-ON") end

-- zil: gsyntax.zil:312  <SYNTAX LOOK WITH OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("LOOK", "WITH", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-LOOK-INSIDE") end

-- zil: gsyntax.zil:313  <SYNTAX LOOK UNDER OBJECT = V-LOOK-UNDER>
do local _ = ZG.SYNTAX("LOOK", "UNDER", "OBJECT", "=", "V-LOOK-UNDER") end

-- zil: gsyntax.zil:314  <SYNTAX LOOK BEHIND OBJECT = V-LOOK-BEHIND>
do local _ = ZG.SYNTAX("LOOK", "BEHIND", "OBJECT", "=", "V-LOOK-BEHIND") end

-- zil: gsyntax.zil:315  <SYNTAX LOOK IN OBJECT (HELD CARRIED ON-GROUND IN-ROOM MANY) = V-LOOK-INSIDE>
do local _ = ZG.SYNTAX("LOOK", "IN", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-LOOK-INSIDE") end

-- zil: gsyntax.zil:316  <SYNTAX LOOK AT OBJECT (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJECT = V-READ ...
do local _ = ZG.SYNTAX("LOOK", "AT", "OBJECT", {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:318  <SYNTAX LOOK FOR OBJECT = V-FIND>
do local _ = ZG.SYNTAX("LOOK", "FOR", "OBJECT", "=", "V-FIND") end

do local _ = ZG.SYNONYM("LOOK", "L", "STARE", "GAZE") end

-- zil: gsyntax.zil:321  <SYNTAX LOWER OBJECT = V-LOWER>
do local _ = ZG.SYNTAX("LOWER", "OBJECT", "=", "V-LOWER") end

-- zil: gsyntax.zil:323  <SYNTAX LUBRICATE OBJECT WITH OBJECT (HELD CARRIED) = V-OIL>
do local _ = ZG.SYNTAX("LUBRICATE", "OBJECT", "WITH", "OBJECT", {"HELD", "CARRIED"}, "=", "V-OIL") end

do local _ = ZG.SYNONYM("LUBRICATE", "OIL", "GREASE") end

-- zil: gsyntax.zil:326  <SYNTAX MAKE OBJECT = V-MAKE>
do local _ = ZG.SYNTAX("MAKE", "OBJECT", "=", "V-MAKE") end

-- zil: gsyntax.zil:328  <SYNTAX MELT OBJECT WITH OBJECT (FIND FLAMEBIT) (HELD CARRIED ON-GROUND IN-RO...
do local _ = ZG.SYNTAX("MELT", "OBJECT", "WITH", "OBJECT", {"FIND", "FLAMEBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-MELT") end

do local _ = ZG.SYNONYM("MELT", "LIQUIFY") end

-- zil: gsyntax.zil:332  <SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:333  <SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:334  <SYNTAX MOVE OBJECT (ON-GROUND IN-ROOM) TO OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "TO", "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:335  <SYNTAX MOVE OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", {"HELD", "MANY", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:336  <SYNTAX MOVE OBJECT WITH OBJECT (FIND TOOLBIT) = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("MOVE", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:337  <SYNTAX ROLL UP OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("ROLL", "UP", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:338  <SYNTAX ROLL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("ROLL", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:340  <SYNTAX MUMBLE = V-MUMBLE>
do local _ = ZG.SYNTAX("MUMBLE", "=", "V-MUMBLE") end

do local _ = ZG.SYNONYM("MUMBLE", "SIGH") end

-- zil: gsyntax.zil:343  <SYNTAX ODYSSEUS = V-ODYSSEUS>
do local _ = ZG.SYNTAX("ODYSSEUS", "=", "V-ODYSSEUS") end

do local _ = ZG.SYNONYM("ODYSSEUS", "ULYSSES") end

-- zil: gsyntax.zil:346  <SYNTAX OPEN OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-OPEN>
do local _ = ZG.SYNTAX("OPEN", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-OPEN") end

-- zil: gsyntax.zil:347  <SYNTAX OPEN UP OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-OPEN>
do local _ = ZG.SYNTAX("OPEN", "UP", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-OPEN") end

-- zil: gsyntax.zil:349  <SYNTAX OPEN OBJECT (FIND DOORBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("OPEN", "OBJECT", {"FIND", "DOORBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED", "HAVE"}, "=", "V-OPEN") end

-- zil: gsyntax.zil:352  <SYNTAX PICK OBJECT = V-PICK>
do local _ = ZG.SYNTAX("PICK", "OBJECT", "=", "V-PICK") end

-- zil: gsyntax.zil:353  <SYNTAX PICK OBJECT WITH OBJECT = V-PICK>
do local _ = ZG.SYNTAX("PICK", "OBJECT", "WITH", "OBJECT", "=", "V-PICK") end

-- zil: gsyntax.zil:354  <SYNTAX PICK UP OBJECT (FIND TAKEBIT) (ON-GROUND MANY) = V-TAKE PRE-TAKE>
do local _ = ZG.SYNTAX("PICK", "UP", "OBJECT", {"FIND", "TAKEBIT"}, {"ON-GROUND", "MANY"}, "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:356  <SYNTAX PLAY OBJECT = V-PLAY>
do local _ = ZG.SYNTAX("PLAY", "OBJECT", "=", "V-PLAY") end

-- zil: gsyntax.zil:358  <SYNTAX PLUG OBJECT WITH OBJECT = V-PLUG>
do local _ = ZG.SYNTAX("PLUG", "OBJECT", "WITH", "OBJECT", "=", "V-PLUG") end

do local _ = ZG.SYNONYM("PLUG", "GLUE", "PATCH", "REPAIR", "FIX") end

-- zil: gsyntax.zil:361  <SYNTAX PLUGH = V-ADVENT>
do local _ = ZG.SYNTAX("PLUGH", "=", "V-ADVENT") end

do local _ = ZG.SYNONYM("PLUGH", "XYZZY") end

-- zil: gsyntax.zil:364  <SYNTAX POKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND WEA...
do local _ = ZG.SYNTAX("POKE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:366  <SYNTAX PUNCTURE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND...
do local _ = ZG.SYNTAX("PUNCTURE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-MUNG", "PRE-MUNG") end

-- zil: gsyntax.zil:369  <SYNTAX POUR OBJECT (HELD CARRIED) = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:370  <SYNTAX POUR OBJECT (HELD CARRIED) IN OBJECT = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "IN", "OBJECT", "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:371  <SYNTAX POUR OBJECT (HELD CARRIED) ON OBJECT = V-POUR-ON>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "ON", "OBJECT", "=", "V-POUR-ON") end

-- zil: gsyntax.zil:372  <SYNTAX POUR OBJECT (HELD CARRIED) FROM OBJECT = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("POUR", "OBJECT", {"HELD", "CARRIED"}, "FROM", "OBJECT", "=", "V-DROP", "PRE-DROP") end

do local _ = ZG.SYNONYM("POUR", "SPILL") end

-- zil: gsyntax.zil:375  <SYNTAX PRAY = V-PRAY>
do local _ = ZG.SYNTAX("PRAY", "=", "V-PRAY") end

-- zil: gsyntax.zil:377  <SYNTAX PULL OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("PULL", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:378  <SYNTAX PULL ON OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("PULL", "ON", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

-- zil: gsyntax.zil:379  <SYNTAX PULL UP OBJECT (ON-GROUND IN-ROOM) = V-MOVE PRE-MOVE>
do local _ = ZG.SYNTAX("PULL", "UP", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "=", "V-MOVE", "PRE-MOVE") end

do local _ = ZG.SYNONYM("PULL", "TUG", "YANK") end

-- zil: gsyntax.zil:382  <SYNTAX PUMP UP OBJECT = V-PUMP>
do local _ = ZG.SYNTAX("PUMP", "UP", "OBJECT", "=", "V-PUMP") end

-- zil: gsyntax.zil:383  <SYNTAX PUMP UP OBJECT WITH OBJECT = V-PUMP>
do local _ = ZG.SYNTAX("PUMP", "UP", "OBJECT", "WITH", "OBJECT", "=", "V-PUMP") end

-- zil: gsyntax.zil:385  <SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND) OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:386  <SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND) TO OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "TO", "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:387  <SYNTAX PUSH OBJECT (IN-ROOM ON-GROUND MANY) = V-PUSH>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", {"IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-PUSH") end

-- zil: gsyntax.zil:388  <SYNTAX PUSH ON OBJECT (IN-ROOM ON-GROUND MANY) = V-PUSH>
do local _ = ZG.SYNTAX("PUSH", "ON", "OBJECT", {"IN-ROOM", "ON-GROUND", "MANY"}, "=", "V-PUSH") end

-- zil: gsyntax.zil:389  <SYNTAX PUSH OBJECT WITH OBJECT (FIND TOOLBIT) = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", "WITH", "OBJECT", {"FIND", "TOOLBIT"}, "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:390  <SYNTAX PUSH OBJECT UNDER OBJECT = V-PUT-UNDER>
do local _ = ZG.SYNTAX("PUSH", "OBJECT", "UNDER", "OBJECT", "=", "V-PUT-UNDER") end

do local _ = ZG.SYNONYM("PUSH", "PRESS") end

-- zil: gsyntax.zil:393  <SYNTAX PUT OBJECT (HELD MANY HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "MANY", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:394  <SYNTAX PUT OBJECT (HELD MANY HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "MANY", "HAVE"}, "ON", "OBJECT", "=", "V-PUT-ON", "PRE-PUT") end

-- zil: gsyntax.zil:395  <SYNTAX PUT DOWN OBJECT (HELD MANY) = V-DROP PRE-DROP>
do local _ = ZG.SYNTAX("PUT", "DOWN", "OBJECT", {"HELD", "MANY"}, "=", "V-DROP", "PRE-DROP") end

-- zil: gsyntax.zil:396  <SYNTAX PUT OBJECT (HELD HAVE) UNDER OBJECT = V-PUT-UNDER>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "HAVE"}, "UNDER", "OBJECT", "=", "V-PUT-UNDER") end

-- zil: gsyntax.zil:397  <SYNTAX PUT OUT OBJECT (FIND ONBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE HAVE...
do local _ = ZG.SYNTAX("PUT", "OUT", "OBJECT", {"FIND", "ONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-OFF") end

-- zil: gsyntax.zil:399  <SYNTAX PUT ON OBJECT (IN-ROOM ON-GROUND CARRIED MANY) = V-WEAR>
do local _ = ZG.SYNTAX("PUT", "ON", "OBJECT", {"IN-ROOM", "ON-GROUND", "CARRIED", "MANY"}, "=", "V-WEAR") end

-- zil: gsyntax.zil:400  <SYNTAX PUT OBJECT (HELD MANY HAVE) BEHIND OBJECT = V-PUT-BEHIND>
do local _ = ZG.SYNTAX("PUT", "OBJECT", {"HELD", "MANY", "HAVE"}, "BEHIND", "OBJECT", "=", "V-PUT-BEHIND") end

do local _ = ZG.SYNONYM("PUT", "STUFF", "INSERT", "PLACE", "HIDE") end

-- zil: gsyntax.zil:403  <SYNTAX RAISE OBJECT = V-RAISE>
do local _ = ZG.SYNTAX("RAISE", "OBJECT", "=", "V-RAISE") end

-- zil: gsyntax.zil:404  <SYNTAX RAISE UP OBJECT = V-RAISE>
do local _ = ZG.SYNTAX("RAISE", "UP", "OBJECT", "=", "V-RAISE") end

do local _ = ZG.SYNONYM("RAISE", "LIFT") end

-- zil: gsyntax.zil:407  <SYNTAX RAPE OBJECT (FIND ACTORBIT) = V-RAPE>
do local _ = ZG.SYNTAX("RAPE", "OBJECT", {"FIND", "ACTORBIT"}, "=", "V-RAPE") end

do local _ = ZG.SYNONYM("RAPE", "MOLEST") end

-- zil: gsyntax.zil:410  <SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) = V-...
do local _ = ZG.SYNTAX("READ", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:412  <SYNTAX READ FROM OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE)...
do local _ = ZG.SYNTAX("READ", "FROM", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:414  <SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) WITH...
do local _ = ZG.SYNTAX("READ", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "WITH", "OBJECT", "=", "V-READ", "PRE-READ") end

-- zil: gsyntax.zil:416  <SYNTAX READ OBJECT (FIND READBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE) OBJE...
do local _ = ZG.SYNTAX("READ", "OBJECT", {"FIND", "READBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "OBJECT", "=", "V-READ-PAGE") end

do local _ = ZG.SYNONYM("READ", "SKIM") end

-- zil: gsyntax.zil:420  <SYNTAX REPENT = V-REPENT>
do local _ = ZG.SYNTAX("REPENT", "=", "V-REPENT") end

-- zil: gsyntax.zil:422  <SYNTAX RING OBJECT (TAKE) = V-RING>
do local _ = ZG.SYNTAX("RING", "OBJECT", {"TAKE"}, "=", "V-RING") end

-- zil: gsyntax.zil:423  <SYNTAX RING OBJECT (TAKE) WITH OBJECT = V-RING>
do local _ = ZG.SYNTAX("RING", "OBJECT", {"TAKE"}, "WITH", "OBJECT", "=", "V-RING") end

do local _ = ZG.SYNONYM("RING", "PEAL") end

-- zil: gsyntax.zil:426  <SYNTAX RUB OBJECT = V-RUB>
do local _ = ZG.SYNTAX("RUB", "OBJECT", "=", "V-RUB") end

-- zil: gsyntax.zil:427  <SYNTAX RUB OBJECT WITH OBJECT = V-RUB>
do local _ = ZG.SYNTAX("RUB", "OBJECT", "WITH", "OBJECT", "=", "V-RUB") end

do local _ = ZG.SYNONYM("RUB", "TOUCH", "FEEL", "PAT", "PET") end

-- zil: gsyntax.zil:430  <SYNTAX TALK TO OBJECT (FIND ACTORBIT) (IN-ROOM) = V-TELL>
do local _ = ZG.SYNTAX("TALK", "TO", "OBJECT", {"FIND", "ACTORBIT"}, {"IN-ROOM"}, "=", "V-TELL") end

-- zil: gsyntax.zil:431  <SYNTAX SAY = V-SAY>
do local _ = ZG.SYNTAX("SAY", "=", "V-SAY") end

-- zil: gsyntax.zil:433  <SYNTAX SEARCH OBJECT = V-SEARCH>
do local _ = ZG.SYNTAX("SEARCH", "OBJECT", "=", "V-SEARCH") end

-- zil: gsyntax.zil:434  <SYNTAX SEARCH IN OBJECT = V-SEARCH>
do local _ = ZG.SYNTAX("SEARCH", "IN", "OBJECT", "=", "V-SEARCH") end

-- zil: gsyntax.zil:435  <SYNTAX SEARCH FOR OBJECT = V-FIND>
do local _ = ZG.SYNTAX("SEARCH", "FOR", "OBJECT", "=", "V-FIND") end

-- zil: gsyntax.zil:437  <SYNTAX SEND FOR OBJECT = V-SEND>
do local _ = ZG.SYNTAX("SEND", "FOR", "OBJECT", "=", "V-SEND") end

-- zil: gsyntax.zil:439  <SYNTAX SHAKE OBJECT (HAVE) = V-SHAKE>
do local _ = ZG.SYNTAX("SHAKE", "OBJECT", {"HAVE"}, "=", "V-SHAKE") end

-- zil: gsyntax.zil:441  <SYNTAX SKIP = V-SKIP>
do local _ = ZG.SYNTAX("SKIP", "=", "V-SKIP") end

do local _ = ZG.SYNONYM("SKIP", "HOP") end

-- ;<SYNTAX SLIDE OBJECT = V-PUSH>

-- zil: gsyntax.zil:445  <SYNTAX SLIDE OBJECT UNDER OBJECT = V-PUT-UNDER>
do local _ = ZG.SYNTAX("SLIDE", "OBJECT", "UNDER", "OBJECT", "=", "V-PUT-UNDER") end

-- zil: gsyntax.zil:446  <SYNTAX SLIDE OBJECT (IN-ROOM ON-GROUND) OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("SLIDE", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:447  <SYNTAX SLIDE OBJECT (IN-ROOM ON-GROUND) TO OBJECT = V-PUSH-TO>
do local _ = ZG.SYNTAX("SLIDE", "OBJECT", {"IN-ROOM", "ON-GROUND"}, "TO", "OBJECT", "=", "V-PUSH-TO") end

-- zil: gsyntax.zil:449  <SYNTAX SMELL OBJECT = V-SMELL>
do local _ = ZG.SYNTAX("SMELL", "OBJECT", "=", "V-SMELL") end

do local _ = ZG.SYNONYM("SMELL", "SNIFF") end

-- zil: gsyntax.zil:452  <SYNTAX SPIN OBJECT = V-SPIN>
do local _ = ZG.SYNTAX("SPIN", "OBJECT", "=", "V-SPIN") end

-- zil: gsyntax.zil:454  <SYNTAX SPRAY OBJECT ON OBJECT = V-SPRAY>
do local _ = ZG.SYNTAX("SPRAY", "OBJECT", "ON", "OBJECT", "=", "V-SPRAY") end

-- zil: gsyntax.zil:455  <SYNTAX SPRAY OBJECT WITH OBJECT = V-SSPRAY>
do local _ = ZG.SYNTAX("SPRAY", "OBJECT", "WITH", "OBJECT", "=", "V-SSPRAY") end

-- zil: gsyntax.zil:457  <SYNTAX SQUEEZE OBJECT = V-SQUEEZE>
do local _ = ZG.SYNTAX("SQUEEZE", "OBJECT", "=", "V-SQUEEZE") end

-- zil: gsyntax.zil:458  <SYNTAX SQUEEZE OBJECT ON OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("SQUEEZE", "OBJECT", "ON", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:460  <SYNTAX STAND = V-STAND>
do local _ = ZG.SYNTAX("STAND", "=", "V-STAND") end

-- zil: gsyntax.zil:461  <SYNTAX STAND UP OBJECT (FIND RMUNGBIT) = V-STAND>
do local _ = ZG.SYNTAX("STAND", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-STAND") end

-- zil: gsyntax.zil:463  <SYNTAX STAY = V-STAY>
do local _ = ZG.SYNTAX("STAY", "=", "V-STAY") end

-- zil: gsyntax.zil:465  <SYNTAX STRIKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND W...
do local _ = ZG.SYNTAX("STRIKE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "HAVE"}, "=", "V-ATTACK") end

-- zil: gsyntax.zil:467  <SYNTAX STRIKE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-STRIKE>
do local _ = ZG.SYNTAX("STRIKE", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-STRIKE") end

-- zil: gsyntax.zil:469  <SYNTAX SWIM = V-SWIM>
do local _ = ZG.SYNTAX("SWIM", "=", "V-SWIM") end

-- zil: gsyntax.zil:470  <SYNTAX SWIM IN OBJECT = V-SWIM>
do local _ = ZG.SYNTAX("SWIM", "IN", "OBJECT", "=", "V-SWIM") end

-- zil: gsyntax.zil:471  <SYNTAX SWIM ACROSS OBJECT = V-SWIM>
do local _ = ZG.SYNTAX("SWIM", "ACROSS", "OBJECT", "=", "V-SWIM") end

do local _ = ZG.SYNONYM("SWIM", "BATHE", "WADE") end

-- zil: gsyntax.zil:474  <SYNTAX SWING OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) = V-SWING>
do local _ = ZG.SYNTAX("SWING", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "=", "V-SWING") end

-- zil: gsyntax.zil:475  <SYNTAX SWING OBJECT (FIND WEAPONBIT) (HELD CARRIED HAVE) AT OBJECT (FIND ACT...
do local _ = ZG.SYNTAX("SWING", "OBJECT", {"FIND", "WEAPONBIT"}, {"HELD", "CARRIED", "HAVE"}, "AT", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-SWING") end

do local _ = ZG.SYNONYM("SWING", "THRUST") end

-- zil: gsyntax.zil:479  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (ON-GROUND IN-ROOM MANY) = V-TAKE PRE-TAKE>
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"ON-GROUND", "IN-ROOM", "MANY"}, "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:480  <SYNTAX TAKE IN OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-BOARD PRE-BOARD>
do local _ = ZG.SYNTAX("TAKE", "IN", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-BOARD", "PRE-BOARD") end

-- zil: gsyntax.zil:481  <SYNTAX TAKE OUT OBJECT (FIND RMUNGBIT) (ON-GROUND IN-ROOM) = V-DISEMBARK>
do local _ = ZG.SYNTAX("TAKE", "OUT", "OBJECT", {"FIND", "RMUNGBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-DISEMBARK") end

-- zil: gsyntax.zil:482  <SYNTAX TAKE ON OBJECT (FIND VEHBIT) (ON-GROUND IN-ROOM) = V-CLIMB-ON>
do local _ = ZG.SYNTAX("TAKE", "ON", "OBJECT", {"FIND", "VEHBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-ON") end

-- zil: gsyntax.zil:483  <SYNTAX TAKE UP OBJECT (FIND RMUNGBIT) = V-STAND>
do local _ = ZG.SYNTAX("TAKE", "UP", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-STAND") end

-- zil: gsyntax.zil:484  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (CARRIED IN-ROOM MANY) OUT OBJECT = V-TAKE...
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"CARRIED", "IN-ROOM", "MANY"}, "OUT", "OBJECT", "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:486  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (CARRIED IN-ROOM MANY) OFF OBJECT = V-TAKE...
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"CARRIED", "IN-ROOM", "MANY"}, "OFF", "OBJECT", "=", "V-TAKE", "PRE-TAKE") end

-- zil: gsyntax.zil:488  <SYNTAX TAKE OBJECT (FIND TAKEBIT) (IN-ROOM CARRIED MANY) FROM OBJECT = V-TAK...
do local _ = ZG.SYNTAX("TAKE", "OBJECT", {"FIND", "TAKEBIT"}, {"IN-ROOM", "CARRIED", "MANY"}, "FROM", "OBJECT", "=", "V-TAKE", "PRE-TAKE") end

do local _ = ZG.SYNONYM("TAKE", "GET", "HOLD", "CARRY", "REMOVE", "GRAB", "CATCH") end

-- zil: gsyntax.zil:492  <SYNTAX TELL OBJECT (FIND ACTORBIT) (IN-ROOM) = V-TELL>
do local _ = ZG.SYNTAX("TELL", "OBJECT", {"FIND", "ACTORBIT"}, {"IN-ROOM"}, "=", "V-TELL") end

-- zil: gsyntax.zil:493  <SYNTAX TELL OBJECT (FIND ACTORBIT) (IN-ROOM) ABOUT OBJECT = V-TELL>
do local _ = ZG.SYNTAX("TELL", "OBJECT", {"FIND", "ACTORBIT"}, {"IN-ROOM"}, "ABOUT", "OBJECT", "=", "V-TELL") end

do local _ = ZG.SYNONYM("TELL", "ASK") end

-- zil: gsyntax.zil:496  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) AT OBJECT (FIND ACTORBIT) (ON-GROUND...
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "AT", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-THROW") end

-- zil: gsyntax.zil:498  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) WITH OBJECT (FIND ACTORBIT) (ON-GROU...
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "WITH", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-THROW") end

-- zil: gsyntax.zil:500  <SYNTAX THROW OBJECT OBJECT = V-OVERBOARD>
do local _ = ZG.SYNTAX("THROW", "OBJECT", "OBJECT", "=", "V-OVERBOARD") end

-- zil: gsyntax.zil:501  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) IN OBJECT = V-PUT PRE-PUT>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "IN", "OBJECT", "=", "V-PUT", "PRE-PUT") end

-- zil: gsyntax.zil:502  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) ON OBJECT = V-PUT-ON PRE-PUT>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "ON", "OBJECT", "=", "V-PUT-ON", "PRE-PUT") end

-- zil: gsyntax.zil:503  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) OFF OBJECT = V-THROW-OFF>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "OFF", "OBJECT", "=", "V-THROW-OFF") end

-- zil: gsyntax.zil:504  <SYNTAX THROW OBJECT (HELD CARRIED HAVE) OVER OBJECT = V-THROW-OFF>
do local _ = ZG.SYNTAX("THROW", "OBJECT", {"HELD", "CARRIED", "HAVE"}, "OVER", "OBJECT", "=", "V-THROW-OFF") end

do local _ = ZG.SYNONYM("THROW", "HURL", "CHUCK", "TOSS") end

-- zil: gsyntax.zil:507  <SYNTAX TIE OBJECT TO OBJECT = V-TIE>
do local _ = ZG.SYNTAX("TIE", "OBJECT", "TO", "OBJECT", "=", "V-TIE") end

-- zil: gsyntax.zil:508  <SYNTAX TIE UP OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) WITH OBJECT (FIND T...
do local _ = ZG.SYNTAX("TIE", "UP", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED", "HAVE"}, "=", "V-TIE-UP") end

do local _ = ZG.SYNONYM("TIE", "FASTEN", "SECURE", "ATTACH") end

-- zil: gsyntax.zil:512  <SYNTAX TREASURE = V-TREASURE>
do local _ = ZG.SYNTAX("TREASURE", "=", "V-TREASURE") end

do local _ = ZG.SYNONYM("TREASURE", "TEMPLE") end

-- zil: gsyntax.zil:515  <SYNTAX TURN OBJECT (FIND TURNBIT) (HELD CARRIED ON-GROUND IN-ROOM) WITH OBJE...
do local _ = ZG.SYNTAX("TURN", "OBJECT", {"FIND", "TURNBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "RMUNGBIT"}, "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:517  <SYNTAX TURN ON OBJECT (FIND LIGHTBIT) (HELD CARRIED ON-GROUND IN-ROOM) = V-L...
do local _ = ZG.SYNTAX("TURN", "ON", "OBJECT", {"FIND", "LIGHTBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:519  <SYNTAX TURN ON OBJECT WITH OBJECT (HAVE) = V-LAMP-ON>
do local _ = ZG.SYNTAX("TURN", "ON", "OBJECT", "WITH", "OBJECT", {"HAVE"}, "=", "V-LAMP-ON") end

-- zil: gsyntax.zil:520  <SYNTAX TURN OFF OBJECT (FIND ONBIT) (HELD CARRIED ON-GROUND IN-ROOM TAKE HAV...
do local _ = ZG.SYNTAX("TURN", "OFF", "OBJECT", {"FIND", "ONBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE", "HAVE"}, "=", "V-LAMP-OFF") end

-- zil: gsyntax.zil:522  <SYNTAX TURN OBJECT (FIND TURNBIT) TO OBJECT = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("TURN", "OBJECT", {"FIND", "TURNBIT"}, "TO", "OBJECT", "=", "V-TURN", "PRE-TURN") end

-- zil: gsyntax.zil:523  <SYNTAX TURN OBJECT (FIND TURNBIT) FOR OBJECT = V-TURN PRE-TURN>
do local _ = ZG.SYNTAX("TURN", "OBJECT", {"FIND", "TURNBIT"}, "FOR", "OBJECT", "=", "V-TURN", "PRE-TURN") end

-- ;<SYNTAX TURN OBJECT (FIND TURNBIT) = V-TURN PRE-TURN>

do local _ = ZG.SYNONYM("TURN", "SET", "FLIP", "SHUT") end

-- zil: gsyntax.zil:527  <SYNTAX UNLOCK OBJECT (ON-GROUND IN-ROOM) WITH OBJECT (FIND TOOLBIT) (HELD CA...
do local _ = ZG.SYNTAX("UNLOCK", "OBJECT", {"ON-GROUND", "IN-ROOM"}, "WITH", "OBJECT", {"FIND", "TOOLBIT"}, {"HELD", "CARRIED", "ON-GROUND", "IN-ROOM", "TAKE"}, "=", "V-UNLOCK") end

-- zil: gsyntax.zil:530  <SYNTAX UNTIE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) = V-UNTIE>
do local _ = ZG.SYNTAX("UNTIE", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "=", "V-UNTIE") end

-- zil: gsyntax.zil:531  <SYNTAX UNTIE OBJECT (ON-GROUND IN-ROOM HELD CARRIED) FROM OBJECT = V-UNTIE>
do local _ = ZG.SYNTAX("UNTIE", "OBJECT", {"ON-GROUND", "IN-ROOM", "HELD", "CARRIED"}, "FROM", "OBJECT", "=", "V-UNTIE") end

do local _ = ZG.SYNONYM("UNTIE", "FREE", "RELEASE", "UNFASTEN", "UNATTACH", "UNHOOK") end

-- zil: gsyntax.zil:535  <SYNTAX WAIT = V-WAIT>
do local _ = ZG.SYNTAX("WAIT", "=", "V-WAIT") end

do local _ = ZG.SYNONYM("WAIT", "Z") end

-- zil: gsyntax.zil:538  <SYNTAX WAKE OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALARM>
do local _ = ZG.SYNTAX("WAKE", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ALARM") end

-- zil: gsyntax.zil:539  <SYNTAX WAKE UP OBJECT (FIND ACTORBIT) (ON-GROUND IN-ROOM) = V-ALARM>
do local _ = ZG.SYNTAX("WAKE", "UP", "OBJECT", {"FIND", "ACTORBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-ALARM") end

do local _ = ZG.SYNONYM("WAKE", "AWAKE", "SURPRISE", "STARTLE") end

-- zil: gsyntax.zil:542  <SYNTAX WALK = V-WALK-AROUND>
do local _ = ZG.SYNTAX("WALK", "=", "V-WALK-AROUND") end

-- zil: gsyntax.zil:543  <SYNTAX WALK OBJECT = V-WALK>
do local _ = ZG.SYNTAX("WALK", "OBJECT", "=", "V-WALK") end

-- zil: gsyntax.zil:544  <SYNTAX WALK AWAY OBJECT = V-WALK>
do local _ = ZG.SYNTAX("WALK", "AWAY", "OBJECT", "=", "V-WALK") end

-- zil: gsyntax.zil:545  <SYNTAX WALK IN OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("WALK", "IN", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:546  <SYNTAX WALK WITH OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("WALK", "WITH", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:547  <SYNTAX WALK ON OBJECT = V-THROUGH>
do local _ = ZG.SYNTAX("WALK", "ON", "OBJECT", "=", "V-THROUGH") end

-- zil: gsyntax.zil:548  <SYNTAX WALK OVER OBJECT = V-LEAP>
do local _ = ZG.SYNTAX("WALK", "OVER", "OBJECT", "=", "V-LEAP") end

-- zil: gsyntax.zil:549  <SYNTAX WALK TO OBJECT = V-WALK-TO>
do local _ = ZG.SYNTAX("WALK", "TO", "OBJECT", "=", "V-WALK-TO") end

-- zil: gsyntax.zil:550  <SYNTAX WALK AROUND OBJECT = V-WALK-AROUND>
do local _ = ZG.SYNTAX("WALK", "AROUND", "OBJECT", "=", "V-WALK-AROUND") end

-- zil: gsyntax.zil:551  <SYNTAX WALK UP OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-UP>
do local _ = ZG.SYNTAX("WALK", "UP", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-UP") end

-- zil: gsyntax.zil:552  <SYNTAX WALK DOWN OBJECT (FIND CLIMBBIT) (ON-GROUND IN-ROOM) = V-CLIMB-DOWN>
do local _ = ZG.SYNTAX("WALK", "DOWN", "OBJECT", {"FIND", "CLIMBBIT"}, {"ON-GROUND", "IN-ROOM"}, "=", "V-CLIMB-DOWN") end

do local _ = ZG.SYNONYM("WALK", "GO", "RUN", "PROCEED", "STEP") end

-- zil: gsyntax.zil:555  <SYNTAX WAVE OBJECT (HELD CARRIED TAKE HAVE) = V-WAVE>
do local _ = ZG.SYNTAX("WAVE", "OBJECT", {"HELD", "CARRIED", "TAKE", "HAVE"}, "=", "V-WAVE") end

-- zil: gsyntax.zil:556  <SYNTAX WAVE OBJECT (HELD CARRIED TAKE HAVE) AT OBJECT = V-WAVE>
do local _ = ZG.SYNTAX("WAVE", "OBJECT", {"HELD", "CARRIED", "TAKE", "HAVE"}, "AT", "OBJECT", "=", "V-WAVE") end

-- zil: gsyntax.zil:557  <SYNTAX WAVE AT OBJECT = V-WAVE>
do local _ = ZG.SYNTAX("WAVE", "AT", "OBJECT", "=", "V-WAVE") end

do local _ = ZG.SYNONYM("WAVE", "BRANDISH") end

-- zil: gsyntax.zil:560  <SYNTAX WEAR OBJECT = V-WEAR>
do local _ = ZG.SYNTAX("WEAR", "OBJECT", "=", "V-WEAR") end

-- zil: gsyntax.zil:562  <SYNTAX WIN = V-WIN>
do local _ = ZG.SYNTAX("WIN", "=", "V-WIN") end

do local _ = ZG.SYNONYM("WIN", "WINNAGE") end

-- zil: gsyntax.zil:565  <SYNTAX WIND OBJECT = V-WIND>
do local _ = ZG.SYNTAX("WIND", "OBJECT", "=", "V-WIND") end

-- zil: gsyntax.zil:566  <SYNTAX WIND UP OBJECT = V-WIND>
do local _ = ZG.SYNTAX("WIND", "UP", "OBJECT", "=", "V-WIND") end

-- zil: gsyntax.zil:568  <SYNTAX WISH = V-WISH>
do local _ = ZG.SYNTAX("WISH", "=", "V-WISH") end

-- zil: gsyntax.zil:570  <SYNTAX YELL = V-YELL>
do local _ = ZG.SYNTAX("YELL", "=", "V-YELL") end

do local _ = ZG.SYNONYM("YELL", "SCREAM", "SHOUT") end

-- zil: gsyntax.zil:573  <SYNTAX ZORK = V-ZORK>
do local _ = ZG.SYNTAX("ZORK", "=", "V-ZORK") end
