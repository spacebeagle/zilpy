"1DUNGEON for
	        Zork I: The Great Underground Empire
	(c) Copyright 1983 Infocom, Inc. All Rights Reserved."

<DIRECTIONS NORTH EAST WEST SOUTH NE NW SE SW UP DOWN IN OUT LAND>

<GLOBAL SCORE-MAX 350>

<GLOBAL FALSE-FLAG <>>

"SUBTITLE OBJECTS"

<OBJECT BOARD
	(IN LOCAL-GLOBALS)
	(SYNONYM BOARDS BOARD)
	(DESC "board")
	(FLAGS NDESCBIT)
	(ACTION BOARD-F)>

<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "set of teeth")
	(FLAGS NDESCBIT)
	(ACTION TEETH-F)>


<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "set of teeth")
	(FLAGS NDESCBIT)
	(ACTION TEETH-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS)
	(ADJECTIVE SURROUNDING)
	(DESC "surrounding wall")>

<OBJECT GRANITE-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE GRANITE)
	(DESC "granite wall")
	(ACTION GRANITE-WALL-F)>

<OBJECT SONGBIRD
	(IN LOCAL-GLOBALS)
	(SYNONYM BIRD SONGBIRD)
	(ADJECTIVE SONG)
	(DESC "songbird")
	(FLAGS NDESCBIT)
	(ACTION SONGBIRD-F)>

<OBJECT WHITE-HOUSE	
	(IN LOCAL-GLOBALS)
	(SYNONYM HOUSE)
	(ADJECTIVE WHITE BEAUTI COLONI)
	(DESC "white house")
	(FLAGS NDESCBIT)
	(ACTION WHITE-HOUSE-F)>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(SYNONYM FOREST TREES PINES HEMLOCKS)
	(DESC "forest")
	(FLAGS NDESCBIT)
	(ACTION FOREST-F)>


<OBJECT TEETH
	(IN GLOBAL-OBJECTS)
	(SYNONYM OVERBOARD TEETH)
	(DESC "set of teeth")
	(FLAGS NDESCBIT)
	(ACTION TEETH-F)>

<OBJECT WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL WALLS)
	(ADJECTIVE SURROUNDING)
	(DESC "surrounding wall")>

<OBJECT GRANITE-WALL
	(IN GLOBAL-OBJECTS)
	(SYNONYM WALL)
	(ADJECTIVE GRANITE)
	(DESC "granite wall")
	(ACTION GRANITE-WALL-F)>

<OBJECT SONGBIRD
	(IN LOCAL-GLOBALS)
	(SYNONYM BIRD SONGBIRD)
	(ADJECTIVE SONG)
	(DESC "songbird")
	(FLAGS NDESCBIT)
	(ACTION SONGBIRD-F)>

<OBJECT WHITE-HOUSE	
	(IN LOCAL-GLOBALS)
	(SYNONYM HOUSE)
	(ADJECTIVE WHITE BEAUTI COLONI)
	(DESC "white house")
	(FLAGS NDESCBIT)
	(ACTION WHITE-HOUSE-F)>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(SYNONYM FOREST TREES PINES HEMLOCKS)
	(DESC "forest")
	(FLAGS NDESCBIT)
	(ACTION FOREST-F)>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(SYNONYM TREE BRANCH)
	(DESC "tree")
	(ADJECTIVE LARGE STORM ;"-TOSSED")
	(FLAGS NDESCBIT CLIMBBIT)>




<OBJECT MATCH
	(IN DAM-LOBBY)
	(SYNONYM MATCH MATCHES MATCHBOOK)
	(ADJECTIVE MATCH)
	(DESC "matchbook")
	(FLAGS READBIT TAKEBIT)
	(ACTION MATCH-FUNCTION)
	(LDESC
"There is a matchbook whose cover says \"Visit Beautiful FCD#3\" here.")
	(SIZE 2)
	(TEXT
"|
(Close cover before striking)|
|
YOU too can make BIG MONEY in the exciting field of PAPER SHUFFLING!|
|
Mr. Anderson of Muddle, Mass. says: \"Before I took this course I
was a lowly bit twiddler. Now with what I learned at GUE Tech
I feel really important and can obfuscate and confuse with the best.\"|
|
Dr. Blank had this to say: \"Ten short days ago all I could look
forward to was a dead-end job as a doctor. Now I have a promising
future and make really big Zorkmids.\"|
|
GUE Tech can't promise these fantastic results to everyone. But when
you earn your degree from GUE Tech, your future will be brighter." )>

<OBJECT MIRROR-2
	(IN MIRROR-ROOM-2)
	(SYNONYM REFLECTION MIRROR ENORMOUS)
	(DESC "mirror")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT MIRROR-1
	(IN MIRROR-ROOM-1)
	(SYNONYM REFLECTION MIRROR ENORMOUS)
	(DESC "mirror")
	(FLAGS TRYTAKEBIT NDESCBIT)
	(ACTION MIRROR-MIRROR)>

<OBJECT PAINTING
	(IN GALLERY)
	(SYNONYM PAINTING ART CANVAS TREASURE)
	(ADJECTIVE BEAUTI)
	(DESC "painting")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION PAINTING-FCN)
	(FDESC
"Fortunately, there is still one chance for you to be a vandal, for on
the far wall is a painting of unparalleled beauty.")
	(LDESC "A painting by a neglected genius is here.")
	(SIZE 15)
	(VALUE 4)
	(TVALUE 6)>

<OBJECT CANDLES
	(IN SOUTH-TEMPLE)
	(SYNONYM CANDLES PAIR)
	(ADJECTIVE BURNING)
	(DESC "pair of candles")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION CANDLES-FCN)
	(FDESC "On the two ends of the altar are burning candles.")
	(SIZE 10)>

<OBJECT GUNK
	(SYNONYM GUNK PIECE SLAG)
	(ADJECTIVE SMALL VITREOUS)
	(DESC "small piece of vitreous slag")
	(FLAGS TAKEBIT TRYTAKEBIT)
	(ACTION GUNK-FUNCTION)
	(SIZE 10)>

<OBJECT BODIES
	(IN LOCAL-GLOBALS)
	(SYNONYM BODIES BODY REMAINS PILE)
	(ADJECTIVE MANGLED)
	(DESC "pile of bodies")
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION BODY-FUNCTION)>

<OBJECT LEAVES
	(IN GRATING-CLEARING)
	(SYNONYM LEAVES LEAF PILE)
	(DESC "pile of leaves")
	(FLAGS TAKEBIT BURNBIT TRYTAKEBIT)
	(ACTION LEAF-PILE)
	(LDESC "On the ground is a pile of leaves.")
	(SIZE 25)>

<OBJECT PUNCTURED-BOAT
	(SYNONYM BOAT PILE PLASTIC)
	(ADJECTIVE PLASTIC PUNCTURE LARGE)
	(DESC "punctured boat")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION DBOAT-FUNCTION)
	(SIZE 20)>

<OBJECT INFLATABLE-BOAT
	(IN DAM-BASE)
	(SYNONYM BOAT PILE PLASTIC VALVE)
	(ADJECTIVE PLASTIC INFLAT)
	(DESC "pile of plastic")
	(FLAGS TAKEBIT BURNBIT)
	(ACTION IBOAT-FUNCTION)
	(LDESC
"There is a folded pile of plastic here which has a small valve
attached.")
	(SIZE 20)>

<OBJECT BAR
	(IN LOUD-ROOM)
	(SYNONYM BAR PLATINUM TREASURE)
	(ADJECTIVE PLATINUM LARGE)
	(DESC "platinum bar")
	(FLAGS TAKEBIT SACREDBIT)
	(LDESC "On the ground is a large platinum bar.")
	(SIZE 20)
	(VALUE 10)
	(TVALUE 5)>

<OBJECT POT-OF-GOLD
	(IN END-OF-RAINBOW)
	(SYNONYM POT GOLD TREASURE)
	(ADJECTIVE GOLD)
	(DESC "pot of gold")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC "At the end of the rainbow is a pot of gold.")
	(SIZE 15)
	(VALUE 10)
	(TVALUE 10)>

<OBJECT PRAYER
	(IN NORTH-TEMPLE)
	(SYNONYM PRAYER INSCRIPTION)
	(ADJECTIVE ANCIENT OLD)
	(DESC "prayer")
	(FLAGS READBIT SACREDBIT NDESCBIT)
	(TEXT
"The prayer is inscribed in an ancient script, rarely used today. It seems
to be a philippic against small insects, absent-mindedness, and the picking
up and dropping of small objects. The final verse consigns trespassers to
the land of the dead. All evidence indicates that the beliefs of the ancient
Zorkers were obscure." )>

<OBJECT RAILING
	(IN DOME-ROOM)
	(SYNONYM RAILING RAIL)
	(ADJECTIVE WOODEN)
	(DESC "wooden railing")
	(FLAGS NDESCBIT)>

<OBJECT RAINBOW
	(IN LOCAL-GLOBALS)
	(SYNONYM RAINBOW)
	(DESC "rainbow")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION RAINBOW-FCN)>

<OBJECT RIVER
	(IN LOCAL-GLOBALS)
	(DESC "river")
	(SYNONYM RIVER)
	(ADJECTIVE FRIGID)
	(ACTION RIVER-FUNCTION)
	(FLAGS NDESCBIT)>

<OBJECT BUOY
	(IN RIVER-4)
	(SYNONYM BUOY)
	(ADJECTIVE RED)
	(DESC "red buoy")
	(FLAGS TAKEBIT CONTBIT)
	(FDESC "There is a red buoy here (probably a warning).")
	(CAPACITY 20)
	(SIZE 10)
	(ACTION TREASURE-INSIDE)>

<ROUTINE TREASURE-INSIDE ()
	 <COND (<VERB? OPEN>
		<SCORE-OBJ ,EMERALD>
		<RFALSE>)>>
<OBJECT ROPE
	(IN ATTIC)
	(SYNONYM ROPE HEMP COIL)
	(ADJECTIVE LARGE)
	(DESC "rope")
	(FLAGS TAKEBIT SACREDBIT TRYTAKEBIT)
	(ACTION ROPE-FUNCTION)
	(FDESC "A large coil of rope is lying in the corner.")
	(SIZE 10)>

<OBJECT RUSTY-KNIFE
	(IN MAZE-5)
	(SYNONYM KNIVES KNIFE)
	(ADJECTIVE RUSTY)
	(DESC "rusty knife")
	(FLAGS TAKEBIT TRYTAKEBIT WEAPONBIT TOOLBIT)
	(ACTION RUSTY-KNIFE-FCN)
	(FDESC "Beside the skeleton is a rusty knife.")
	(SIZE 20)>

<OBJECT SAND
	(IN SANDY-CAVE)
	(SYNONYM SAND)
	(DESC "sand")
	(FLAGS NDESCBIT)
	(ACTION SAND-FUNCTION)>

<OBJECT BRACELET
	(IN GAS-ROOM)
	(SYNONYM BRACELET JEWEL SAPPHIRE TREASURE)
	(ADJECTIVE SAPPHIRE)
	(DESC "sapphire-encrusted bracelet")
	(FLAGS TAKEBIT)
	(SIZE 10)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT SCREWDRIVER
	(IN MAINTENANCE-ROOM)
	(SYNONYM SCREWDRIVER TOOL TOOLS DRIVER)
	(ADJECTIVE SCREW)
	(DESC "screwdriver")
	(FLAGS TAKEBIT TOOLBIT)>

<OBJECT KEYS
	(IN MAZE-5)
	(SYNONYM KEY)
	(ADJECTIVE SKELETON)
	(DESC "skeleton key")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)>

<OBJECT SHOVEL
	(IN SANDY-BEACH)
	(SYNONYM SHOVEL TOOL TOOLS)
	(DESC "shovel")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 15)>

<OBJECT COAL
	(IN DEAD-END-5)
	(SYNONYM COAL PILE HEAP)
	(ADJECTIVE SMALL)
	(DESC "small pile of coal")
	(FLAGS TAKEBIT BURNBIT)
	(SIZE 20)>

<OBJECT LADDER
	(IN LOCAL-GLOBALS)
	(SYNONYM LADDER)
	(ADJECTIVE WOODEN RICKETY NARROW)
	(DESC "wooden ladder")
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT SCARAB
	(IN SANDY-CAVE)
	(SYNONYM SCARAB BUG BEETLE TREASURE)
	(ADJECTIVE BEAUTI CARVED JEWELED)
	(DESC "beautiful jeweled scarab")
	(FLAGS TAKEBIT INVISIBLE)
	(SIZE 8)
	(VALUE 5)
	(TVALUE 5)>

<OBJECT LARGE-BAG
	(IN THIEF)
	(SYNONYM BAG)
	(ADJECTIVE LARGE THIEFS)
	(DESC "large bag")
	(ACTION LARGE-BAG-F)
	(FLAGS TRYTAKEBIT NDESCBIT)>  

<OBJECT STILETTO
	(IN THIEF)
	(SYNONYM STILETTO)
	(ADJECTIVE VICIOUS)
	(DESC "stiletto")
	(ACTION STILETTO-FUNCTION)
	(FLAGS WEAPONBIT TRYTAKEBIT TAKEBIT NDESCBIT)
	(SIZE 10)>

<OBJECT MACHINE-SWITCH
	(IN MACHINE-ROOM)
	(SYNONYM SWITCH)
	(DESC "switch")
	(FLAGS NDESCBIT TURNBIT)
	(ACTION MSWITCH-FUNCTION)>

<OBJECT WOODEN-DOOR
	(IN LIVING-ROOM)
	(SYNONYM DOOR LETTERING WRITING)
	(ADJECTIVE WOODEN GOTHIC STRANGE WEST)
	(DESC "wooden door")
	(FLAGS READBIT DOORBIT NDESCBIT TRANSBIT)
	(ACTION FRONT-DOOR-FCN)
	(TEXT
"The engravings translate to \"This space intentionally left blank.\"")>

<OBJECT SWORD
	(IN LIVING-ROOM)
	(SYNONYM SWORD ORCRIST GLAMDRING BLADE)
	(ADJECTIVE ELVISH OLD ANTIQUE)
	(DESC "sword")
	(FLAGS TAKEBIT WEAPONBIT TRYTAKEBIT)
	(ACTION SWORD-FCN)
	(FDESC
"Above the trophy case hangs an elvish sword of great antiquity.")
	(SIZE 30)
	(TVALUE 0)>

<OBJECT MAP
	(IN TROPHY-CASE)
	(SYNONYM PARCHMENT MAP)
	(ADJECTIVE ANTIQUE OLD ANCIENT)
	(DESC "ancient map")
	(FLAGS INVISIBLE READBIT TAKEBIT)
	(FDESC
"In the trophy case is an ancient parchment which appears to be a map.")
	(SIZE 2)
	(TEXT
"The map shows a forest with three clearings. The largest clearing contains
a house. Three paths leave the large clearing. One of these paths, leading
southwest, is marked \"To Stone Barrow\".")>

<OBJECT BOAT-LABEL
	(IN INFLATED-BOAT)
	(SYNONYM LABEL FINEPRINT PRINT)
	(ADJECTIVE TAN FINE)
	(DESC "tan label")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(SIZE 2)
	(TEXT
"  !!!!FROBOZZ MAGIC BOAT COMPANY!!!!|
|
Hello, Sailor!|
|
Instructions for use:|
|
   To get into a body of water, say \"Launch\".|
   To get to shore, say \"Land\" or the direction in which you want
to maneuver the boat.|
|
Warranty:|
|
  This boat is guaranteed against all defects for a period of 76
milliseconds from date of purchase or until first used, whichever comes first.|
|
Warning:|
   This boat is made of thin plastic.|
   Good Luck!" )>

<OBJECT THIEF
	(IN ROUND-ROOM)
	(SYNONYM THIEF ROBBER MAN PERSON)
	(ADJECTIVE SHADY SUSPICIOUS SEEDY)
	(DESC "thief")
	(FLAGS ACTORBIT INVISIBLE CONTBIT OPENBIT TRYTAKEBIT)
	(ACTION ROBBER-FUNCTION)
	(LDESC
"There is a suspicious-looking individual, holding a large bag, leaning
against one wall. He is armed with a deadly stiletto.")
	(STRENGTH 5)>

<OBJECT PEDESTAL
	(IN TORCH-ROOM)
	(SYNONYM PEDESTAL)
	(ADJECTIVE WHITE MARBLE)
	(DESC "pedestal")
	(FLAGS NDESCBIT CONTBIT OPENBIT SURFACEBIT)
	(ACTION DUMB-CONTAINER)
	(CAPACITY 30)>

<OBJECT TORCH
	(IN PEDESTAL)
	(SYNONYM TORCH IVORY TREASURE)
	(ADJECTIVE FLAMING IVORY)
	(DESC "torch")
	(FLAGS TAKEBIT FLAMEBIT ONBIT LIGHTBIT)
	(ACTION TORCH-OBJECT)
	(FDESC "Sitting on the pedestal is a flaming torch, made of ivory.")
	(SIZE 20)
	(VALUE 14)
	(TVALUE 6)>

<OBJECT GUIDE
	(IN DAM-LOBBY)
	(SYNONYM GUIDE BOOK BOOKS GUIDEBOOKS)
	(ADJECTIVE TOUR GUIDE)
	(DESC "tour guidebook")
	(FLAGS READBIT TAKEBIT BURNBIT)
	(FDESC
"Some guidebooks entitled \"Flood Control Dam #3\" are on the reception
desk.")
	(TEXT
"\"	Flood Control Dam #3|
|
FCD#3 was constructed in year 783 of the Great Underground Empire to
harness the mighty Frigid River. This work was supported by a grant of
37 million zorkmids from your omnipotent local tyrant Lord Dimwit
Flathead the Excessive. This impressive structure is composed of
370,000 cubic feet of concrete, is 256 feet tall at the center, and 193
feet wide at the top. The lake created behind the dam has a volume
of 1.7 billion cubic feet, an area of 12 million square feet, and a
shore line of 36 thousand feet.|
|
The construction of FCD#3 took 112 days from ground breaking to
the dedication. It required a work force of 384 slaves, 34 slave
drivers, 12 engineers, 2 turtle doves, and a partridge in a pear
tree. The work was managed by a command team composed of 2345
bureaucrats, 2347 secretaries (at least two of whom could type),
12,256 paper shufflers, 52,469 rubber stampers, 245,193 red tape
processors, and nearly one million dead trees.|
|
We will now point out some of the more interesting features
of FCD#3 as we conduct you on a guided tour of the facilities:|
|
        1) You start your tour here in the Dam Lobby. You will notice
on your right that...." )>

<OBJECT TROLL
	(IN TROLL-ROOM)
	(SYNONYM TROLL)
	(ADJECTIVE NASTY)
	(DESC "troll")
	(FLAGS ACTORBIT OPENBIT TRYTAKEBIT)
	(ACTION TROLL-FCN)
	(LDESC
"A nasty-looking troll, brandishing a bloody axe, blocks all passages
out of the room.")
	(STRENGTH 2)>

<OBJECT TRUNK
	(IN RESERVOIR)
	(SYNONYM TRUNK CHEST JEWELS TREASURE)
	(ADJECTIVE OLD)
	(DESC "trunk of jewels")
	(FLAGS TAKEBIT INVISIBLE)
	(FDESC
"Lying half buried in the mud is an old trunk, bulging with jewels.")
	(LDESC "There is an old trunk here, bulging with assorted jewels.")
	(ACTION TRUNK-F)
	(SIZE 35)
	(VALUE 15)
	(TVALUE 5)>

<OBJECT TUBE
	(IN MAINTENANCE-ROOM)
	(SYNONYM TUBE TOOTH PASTE)
	(DESC "tube")
	(FLAGS TAKEBIT CONTBIT READBIT)
	(ACTION TUBE-FUNCTION)
	(LDESC
	 "There is an object which looks like a tube of toothpaste here.")
	(CAPACITY 7)
	(SIZE 5)
	(TEXT
"---> Frobozz Magic Gunk Company <---|
	  All-Purpose Gunk")>

<OBJECT PUTTY
	(IN TUBE)
	(SYNONYM MATERIAL GUNK)
	(ADJECTIVE VISCOUS)
	(DESC "viscous material")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 6)
	(ACTION PUTTY-FCN)>

<OBJECT ENGRAVINGS
	(IN ENGRAVINGS-CAVE)
	(SYNONYM WALL ENGRAVINGS INSCRIPTION)
	(ADJECTIVE OLD ANCIENT)
	(DESC "wall with engravings")
	(FLAGS READBIT SACREDBIT)
	(LDESC "There are old engravings on the walls here.")
	(TEXT
"The engravings were incised in the living rock of the cave wall by
an unknown hand. They depict, in symbolic form, the beliefs of the
ancient Zorkers. Skillfully interwoven with the bas reliefs are excerpts
illustrating the major religious tenets of that time. Unfortunately, a
later age seems to have considered them blasphemous and just as skillfully
excised them.")>

<OBJECT OWNERS-MANUAL
	(IN STUDIO)
	(SYNONYM MANUAL PIECE PAPER)
	(ADJECTIVE ZORK OWNERS SMALL)
	(DESC "ZORK owner's manual")
	(FLAGS READBIT TAKEBIT)
	(FDESC "Loosely attached to a wall is a small piece of paper.")
	(TEXT
"Congratulations!|
|
You are the privileged owner of ZORK I: The Great Underground Empire,
a self-contained and self-maintaining universe. If used and maintained
in accordance with normal operating practices for small universes, ZORK
will provide many months of trouble-free operation.")>

<OBJECT CLIMBABLE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM WALL CLIFF WALLS LEDGE)
	(ADJECTIVE ROCKY SHEER)
	(DESC "cliff")
	(ACTION CLIFF-OBJECT)
	(FLAGS NDESCBIT CLIMBBIT)>

<OBJECT WHITE-CLIFF
	(IN LOCAL-GLOBALS)
	(SYNONYM CLIFF CLIFFS)
	(ADJECTIVE WHITE)
	(DESC "white cliffs")
	(FLAGS NDESCBIT CLIMBBIT)
	(ACTION WCLIF-OBJECT)>

<OBJECT WRENCH
	(IN MAINTENANCE-ROOM)
	(SYNONYM WRENCH TOOL TOOLS)
	(DESC "wrench")
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 10)>

<OBJECT CONTROL-PANEL
	(IN DAM-ROOM)
	(SYNONYM PANEL)
	(ADJECTIVE CONTROL)
	(DESC "control panel")
	(FLAGS NDESCBIT)>

<OBJECT NEST
	(IN UP-A-TREE)
	(SYNONYM NEST)
	(ADJECTIVE BIRDS)
	(DESC "bird's nest")
	(FLAGS TAKEBIT BURNBIT CONTBIT OPENBIT SEARCHBIT)
	(FDESC "Beside you on the branch is a small bird's nest.")
	(CAPACITY 20)>

<OBJECT EGG
	(IN NEST)
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BIRDS ENCRUSTED JEWELED)
	(DESC "jewel-encrusted egg")
	(FLAGS TAKEBIT CONTBIT SEARCHBIT)
	(ACTION EGG-OBJECT)
	(VALUE 5)
	(TVALUE 5)
	(CAPACITY 6)
	(FDESC
"In the bird's nest is a large egg encrusted with precious jewels,
apparently scavenged by a childless songbird. The egg is covered with
fine gold inlay, and ornamented in lapis lazuli and mother-of-pearl.
Unlike most eggs, this one is hinged and closed with a delicate looking
clasp. The egg appears extremely fragile.")>

<OBJECT BROKEN-EGG
	(SYNONYM EGG TREASURE)
	(ADJECTIVE BROKEN BIRDS ENCRUSTED JEWEL)
	(DESC "broken jewel-encrusted egg")
	(FLAGS TAKEBIT CONTBIT OPENBIT)
	(CAPACITY 6)
	(TVALUE 2)
	(LDESC "There is a somewhat ruined egg here.")>

<OBJECT BAUBLE
	(SYNONYM BAUBLE TREASURE)
	(ADJECTIVE BRASS BEAUTI)
	(DESC "beautiful brass bauble")
	(FLAGS TAKEBIT)
	(VALUE 1)
	(TVALUE 1)>

<OBJECT CANARY
	(IN EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE CLOCKWORK GOLD GOLDEN)
	(DESC "golden clockwork canary")
	(FLAGS TAKEBIT SEARCHBIT)
	(ACTION CANARY-OBJECT)
	(VALUE 6)
	(TVALUE 4)
	(FDESC
"There is a golden clockwork canary nestled in the egg. It has ruby
eyes and a silver beak. Through a crystal window below its left
wing you can see intricate machinery inside. It appears to have
wound down.")>

<OBJECT BROKEN-CANARY
	(IN BROKEN-EGG)
	(SYNONYM CANARY TREASURE)
	(ADJECTIVE BROKEN CLOCKWORK GOLD GOLDEN)
	(DESC "broken clockwork canary")
	(FLAGS TAKEBIT)
	(ACTION CANARY-OBJECT)
	(TVALUE 1)
	(FDESC
"There is a golden clockwork canary nestled in the egg. It seems to
have recently had a bad experience. The mountings for its jewel-like
eyes are empty, and its silver beak is crumpled. Through a cracked
crystal window below its left wing you can see the remains of
intricate machinery. It is not clear what result winding it would
have, as the mainspring seems sprung.")>

\

"SUBTITLE ROOMS"

"SUBTITLE CONDITIONAL EXIT FLAGS"

<GLOBAL CYCLOPS-FLAG <>>
<GLOBAL DEFLATE <>>
<GLOBAL DOME-FLAG <>>
<GLOBAL EMPTY-HANDED <>>
<GLOBAL LLD-FLAG <>>
<GLOBAL LOW-TIDE <>>
<GLOBAL MAGIC-FLAG <>>
<GLOBAL RAINBOW-FLAG <>>
<GLOBAL TROLL-FLAG <>>
<GLOBAL WON-FLAG <>>
<GLOBAL COFFIN-CURE <>>

"SUBTITLE FOREST AND OUTSIDE OF HOUSE"

<ROOM WEST-OF-HOUSE
      (IN ROOMS)
      (DESC "West of House")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (NE TO NORTH-OF-HOUSE)
      (SE TO SOUTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (EAST "The door is boarded and you can't remove the boards.")
      (SW TO STONE-BARROW IF WON-FLAG)
      (IN TO STONE-BARROW IF WON-FLAG)
      (ACTION WEST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE BOARD FOREST)>

<ROOM STONE-BARROW
      (IN ROOMS)
      (LDESC
"You are standing in front of a massive barrow of stone. In the east face
is a huge stone door which is open. You cannot see into the dark of the tomb.")
      (DESC "Stone Barrow")
      (NE TO WEST-OF-HOUSE)
      (ACTION STONE-BARROW-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)>

<ROOM NORTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"You are facing the north side of a white house. There is no door here,
and all the windows are boarded up. To the north a narrow path winds through
the trees.")
      (DESC "North of House")
      (SW TO WEST-OF-HOUSE)
      (SE TO EAST-OF-HOUSE)
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NORTH TO PATH)
      (SOUTH "The windows are all boarded.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM SOUTH-OF-HOUSE
      (IN ROOMS)
      (LDESC
"You are facing the south side of a white house. There is no door here,
and all the windows are boarded.")
      (DESC "South of House")
      (WEST TO WEST-OF-HOUSE)
      (EAST TO EAST-OF-HOUSE)
      (NE TO EAST-OF-HOUSE)
      (NW TO WEST-OF-HOUSE)
      (SOUTH TO FOREST-3)
      (NORTH "The windows are all boarded.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL BOARDED-WINDOW BOARD WHITE-HOUSE FOREST)>

<ROOM EAST-OF-HOUSE
      (IN ROOMS)
      (DESC "Behind House")
      (NORTH TO NORTH-OF-HOUSE)
      (SOUTH TO SOUTH-OF-HOUSE)
      (SW TO SOUTH-OF-HOUSE)
      (NW TO NORTH-OF-HOUSE)
      (EAST TO CLEARING)
      (WEST TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (IN TO KITCHEN IF KITCHEN-WINDOW IS OPEN)
      (ACTION EAST-HOUSE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE KITCHEN-WINDOW FOREST)>

<ROOM FOREST-1
      (IN ROOMS)
      (LDESC
"This is a forest, with trees in all directions. To the east,
there appears to be sunlight.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH TO GRATING-CLEARING)
      (EAST TO PATH)
      (SOUTH TO FOREST-3)
      (WEST "You would need a machete to go further west.")
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM FOREST-2
      (IN ROOMS)
      (LDESC "This is a dimly lit forest, with large trees all around.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH "The forest becomes impenetrable to the north.")
      (EAST TO MOUNTAINS)
      (SOUTH TO CLEARING)
      (WEST TO PATH)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM MOUNTAINS
      (IN ROOMS)
      (LDESC "The forest thins out, revealing impassable mountains.")
      (DESC "Forest")
      (UP "The mountains are impassable.")
      (NORTH TO FOREST-2)
      (EAST "The mountains are impassable.")
      (SOUTH TO FOREST-2)
      (WEST TO FOREST-2)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE WHITE-HOUSE)>

<ROOM FOREST-3
      (IN ROOMS)
      (LDESC "This is a dimly lit forest, with large trees all around.")
      (DESC "Forest")
      (UP "There is no tree here suitable for climbing.")
      (NORTH TO CLEARING)
      (EAST "The rank undergrowth prevents eastward movement.")
      (SOUTH "Storm-tossed trees block your way.")
      (WEST TO FOREST-1)
      (NW TO SOUTH-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM PATH
      (IN ROOMS)
      (LDESC
"This is a path winding through a dimly lit forest. The path heads
north-south here. One particularly large tree with some low branches
stands at the edge of the path.")
      (DESC "Forest Path")
      (UP TO UP-A-TREE)
      (NORTH TO GRATING-CLEARING)
      (EAST TO FOREST-2)
      (SOUTH TO NORTH-OF-HOUSE)
      (WEST TO FOREST-1)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

<ROOM UP-A-TREE
      (IN ROOMS)
      (DESC "Up a Tree")
      (DOWN TO PATH)
      (UP "You cannot climb any higher.")
      (ACTION TREE-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE FOREST SONGBIRD WHITE-HOUSE)>

<ROOM GRATING-CLEARING
      (IN ROOMS)
      (DESC "Clearing")
      (NORTH "The forest becomes impenetrable to the north.")
      (EAST TO FOREST-2)
      (WEST TO FOREST-1)
      (SOUTH TO PATH)
      (DOWN PER GRATING-EXIT)
      (ACTION CLEARING-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL WHITE-HOUSE GRATE)>

<ROUTINE GRATING-EXIT ()
	 <COND (,GRATE-REVEALED
		<COND (<FSET? ,GRATE ,OPENBIT>
		       ,GRATING-ROOM)
		      (T
		       <TELL "The grating is closed!" CR>
		       <THIS-IS-IT ,GRATE>
		       <RFALSE>)>)
	       (T <TELL "You can't go that way." CR> <RFALSE>)>>

<ROOM CLEARING
      (IN ROOMS)
      (LDESC
"You are in a small clearing in a well marked forest path that
extends to the east and west.")
      (DESC "Clearing")
      (UP "There is no tree here suitable for climbing.")
      (EAST TO CANYON-VIEW)
      (NORTH TO FOREST-2)
      (SOUTH TO FOREST-3)
      (WEST TO EAST-OF-HOUSE)
      (ACTION FOREST-ROOM)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL TREE SONGBIRD WHITE-HOUSE FOREST)>

\

"SUBTITLE HOUSE"

<ROOM KITCHEN
      (IN ROOMS)
      (DESC "Kitchen")
      (EAST TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (WEST TO LIVING-ROOM)
      (OUT TO EAST-OF-HOUSE IF KITCHEN-WINDOW IS OPEN)
      (UP TO ATTIC)
      (DOWN TO STUDIO IF FALSE-FLAG ELSE
	 "Only Santa Claus climbs down chimneys.")
      (ACTION KITCHEN-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (VALUE 10)
      (GLOBAL KITCHEN-WINDOW CHIMNEY STAIRS)>

<ROOM ATTIC
      (IN ROOMS)
      (LDESC "This is the attic. The only exit is a stairway leading down.")
      (DESC "Attic")
      (DOWN TO KITCHEN)
      (FLAGS RLANDBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM LIVING-ROOM
      (IN ROOMS)
      (DESC "Living Room")
      (EAST TO KITCHEN)
      (WEST TO STRANGE-PASSAGE IF MAGIC-FLAG ELSE "The door is nailed shut.")
      (DOWN PER TRAP-DOOR-EXIT)
      (ACTION LIVING-ROOM-FCN)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "NAILS" NAILS-PSEUDO "NAIL" NAILS-PSEUDO)>

\

"SUBTITLE CELLAR AND VICINITY"

<ROOM CELLAR
      (IN ROOMS)
      (DESC "Cellar")
      (NORTH TO TROLL-ROOM)
      (SOUTH TO EAST-OF-CHASM)
      (UP TO LIVING-ROOM IF TRAP-DOOR IS OPEN)
      (WEST
"You try to ascend the ramp, but it is impossible, and you slide back down.")
      (ACTION CELLAR-FCN)
      (FLAGS RLANDBIT)
      (VALUE 25)
      (GLOBAL TRAP-DOOR SLIDE STAIRS)>

<ROOM TROLL-ROOM
      (IN ROOMS)
      (LDESC
"This is a small room with passages to the east and south and a
forbidding hole leading west. Bloodstains and deep scratches
(perhaps made by an axe) mar the walls.")
      (DESC "The Troll Room")
      (SOUTH TO CELLAR)
      (EAST TO EW-PASSAGE
       IF TROLL-FLAG ELSE "The troll fends you off with a menacing gesture.")
      (WEST TO MAZE-1
       IF TROLL-FLAG ELSE "The troll fends you off with a menacing gesture.")
      (FLAGS RLANDBIT)
      (ACTION TROLL-ROOM-F)>

<ROOM EAST-OF-CHASM
      (IN ROOMS)
      (LDESC
"You are on the east edge of a chasm, the bottom of which cannot be
seen. A narrow passage goes north, and the path you are on continues
to the east.")
      (DESC "East of Chasm")
      (NORTH TO CELLAR)
      (EAST TO GALLERY)
      (DOWN "The chasm probably leads straight to the infernal regions.")
      (FLAGS RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM GALLERY
      (IN ROOMS)
      (LDESC
"This is an art gallery. Most of the paintings have been stolen by
vandals with exceptional taste. The vandals left through either the
north or west exits.")
      (DESC "Gallery")
      (WEST TO EAST-OF-CHASM)
      (NORTH TO STUDIO)
      (FLAGS RLANDBIT ONBIT)>

<ROOM STUDIO
      (IN ROOMS)
      (LDESC
"This appears to have been an artist's studio. The walls and floors are
splattered with paints of 69 different colors. Strangely enough, nothing
of value is hanging here. At the south end of the room is an open door
(also covered with paint). A dark and narrow chimney leads up from a
fireplace; although you might be able to get up it, it seems unlikely
you could get back down.")
      (DESC "Studio")
      (SOUTH TO GALLERY)
      (UP PER UP-CHIMNEY-FUNCTION)
      (FLAGS RLANDBIT)
      (GLOBAL CHIMNEY)
      (PSEUDO "DOOR" DOOR-PSEUDO "PAINT" PAINT-PSEUDO)>

\

"SUBTITLE MAZE"

<ROOM MAZE-1
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (EAST TO TROLL-ROOM)
      (NORTH TO MAZE-1)
      (SOUTH TO MAZE-2)
      (WEST TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-2
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (SOUTH TO MAZE-1)
      (DOWN PER MAZE-DIODES) ;"to MAZE-4"
      (EAST TO MAZE-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-3
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (WEST TO MAZE-2)
      (NORTH TO MAZE-4)
      (UP TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-4
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (WEST TO MAZE-3)
      (NORTH TO MAZE-1)
      (EAST TO DEAD-END-1)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-1
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (SOUTH TO MAZE-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-5
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.
A skeleton, probably the remains of a luckless adventurer, lies here.")
      (DESC "Maze")
      (EAST TO DEAD-END-2)
      (NORTH TO MAZE-3)
      (SW TO MAZE-6)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-2
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (WEST TO MAZE-5)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-6
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (DOWN TO MAZE-5)
      (EAST TO MAZE-7)
      (WEST TO MAZE-6)
      (UP TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-7
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (UP TO MAZE-14)
      (WEST TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to DEAD-END-1"
      (EAST TO MAZE-8)
      (SOUTH TO MAZE-15)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-8
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (NE TO MAZE-7)
      (WEST TO MAZE-8)
      (SE TO DEAD-END-3)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-3
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (NORTH TO MAZE-8)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-9
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (NORTH TO MAZE-6)
      (DOWN PER MAZE-DIODES) ;"to MAZE-11"
      (EAST TO MAZE-10)
      (SOUTH TO MAZE-13)
      (WEST TO MAZE-12)
      (NW TO MAZE-9)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-10
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (EAST TO MAZE-9)
      (WEST TO MAZE-13)
      (UP TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-11
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
       (NE TO GRATING-ROOM)
      (DOWN TO MAZE-10)
      (NW TO MAZE-13)
      (SW TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM GRATING-ROOM
      (IN ROOMS)
      (DESC "Grating Room")
      (SW TO MAZE-11)
      (UP TO GRATING-CLEARING
       IF GRATE IS OPEN ELSE "The grating is closed.")
      (ACTION MAZE-11-FCN)
      (GLOBAL GRATE)
      (FLAGS RLANDBIT)>

<ROOM MAZE-12
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (DOWN PER MAZE-DIODES) ;"to MAZE-5"
      (SW TO MAZE-11)
      (EAST TO MAZE-13)
      (UP TO MAZE-9)
      (NORTH TO DEAD-END-4)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM DEAD-END-4
      (IN ROOMS)
      (DESC "Dead End")
      (LDESC "You have come to a dead end in the maze.")
      (SOUTH TO MAZE-12)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-13
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (EAST TO MAZE-9)
      (DOWN TO MAZE-12)
      (SOUTH TO MAZE-10)
      (WEST TO MAZE-11)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-14
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
       (WEST TO MAZE-15)
      (NW TO MAZE-14)
      (NE TO MAZE-7)
      (SOUTH TO MAZE-7)
      (FLAGS RLANDBIT MAZEBIT)>

<ROOM MAZE-15
      (IN ROOMS)
      (LDESC "This is part of a maze of twisty little passages, all alike.")
      (DESC "Maze")
      (WEST TO MAZE-14)
      (SOUTH TO MAZE-7)
      (SE TO CYCLOPS-ROOM)
      (FLAGS RLANDBIT MAZEBIT)>

\

"SUBTITLE CYCLOPS AND HIDEAWAY"

<ROOM CYCLOPS-ROOM
      (IN ROOMS)
      (DESC "Cyclops Room")
      (NW TO MAZE-15)
      (EAST TO STRANGE-PASSAGE
       IF MAGIC-FLAG ELSE "The east wall is solid rock.")
      (UP TO TREASURE-ROOM IF CYCLOPS-FLAG
        ELSE "The cyclops doesn't look like he'll let you past.")
      (ACTION CYCLOPS-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM STRANGE-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a long passage. To the west is one entrance. On the
east there is an old wooden door, with a large opening in it (about
cyclops sized).")
      (DESC "Strange Passage")
      (WEST TO CYCLOPS-ROOM)
      (IN TO CYCLOPS-ROOM)
      (EAST TO LIVING-ROOM)
      (FLAGS RLANDBIT)>

<ROOM TREASURE-ROOM
      (IN ROOMS)
      (LDESC
"This is a large room, whose east wall is solid granite. A number
of discarded bags, which crumble at your touch, are scattered about
on the floor. There is an exit down a staircase.")
      (DESC "Treasure Room")
      (DOWN TO CYCLOPS-ROOM)
      (ACTION TREASURE-ROOM-FCN)
      (FLAGS RLANDBIT ;"CANT-HAVE-ONBIT")
      (VALUE 25)
      (GLOBAL STAIRS)>

\

"SUBTITLE RESERVOIR AREA"

<ROOM RESERVOIR-SOUTH
      (IN ROOMS)
      (DESC "Reservoir South")
      (SE TO DEEP-CANYON)
      (SW TO CHASM-ROOM)
      (EAST TO DAM-ROOM)
      (WEST TO STREAM-VIEW)
      (NORTH TO RESERVOIR
       IF LOW-TIDE ELSE "You would drown.")
      (ACTION RESERVOIR-SOUTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "LAKE" LAKE-PSEUDO "CHASM" CHASM-PSEUDO)>

<ROOM RESERVOIR
      (IN ROOMS)
      (DESC "Reservoir")
      (NORTH TO RESERVOIR-NORTH)
      (SOUTH TO RESERVOIR-SOUTH)
      (UP TO IN-STREAM)
      (WEST TO IN-STREAM)
      (DOWN "The dam blocks your way.")
      (ACTION RESERVOIR-FCN)
      (FLAGS NONLANDBIT )
      (PSEUDO "STREAM" STREAM-PSEUDO)
      (GLOBAL GLOBAL-WATER)>

<ROOM RESERVOIR-NORTH
      (IN ROOMS)
      (DESC "Reservoir North")
      (NORTH TO ATLANTIS-ROOM)
      (SOUTH TO RESERVOIR
       IF LOW-TIDE ELSE "You would drown.")
      (ACTION RESERVOIR-NORTH-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER STAIRS)
      (PSEUDO "LAKE" LAKE-PSEUDO)>

<ROOM STREAM-VIEW
      (IN ROOMS)
      (LDESC
"You are standing on a path beside a gently flowing stream. The path
follows the stream, which flows from west to east.")
      (DESC "Stream View")
      (EAST TO RESERVOIR-SOUTH)
      (WEST "The stream emerges from a spot too small for you to enter.")
      (FLAGS RLANDBIT)
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO)>

<ROOM IN-STREAM
      (IN ROOMS)
      (LDESC
"You are on the gently flowing stream. The upstream route is too narrow
to navigate, and the downstream route is invisible due to twisting
walls. There is a narrow beach to land on.")
      (DESC "Stream")
      (UP "The channel is too narrow.")
      (WEST "The channel is too narrow.")
      (LAND TO STREAM-VIEW)
      (DOWN TO RESERVOIR)
      (EAST TO RESERVOIR)
      (FLAGS NONLANDBIT )
      (GLOBAL GLOBAL-WATER)
      (PSEUDO "STREAM" STREAM-PSEUDO)>

\

"SUBTITLE MIRROR ROOMS AND VICINITY"

<ROOM MIRROR-ROOM-1
      (IN ROOMS)
      (DESC "Mirror Room")
      (NORTH TO COLD-PASSAGE)
      (WEST TO TWISTING-PASSAGE)
      (EAST TO SMALL-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT)>

<ROOM MIRROR-ROOM-2
      (IN ROOMS)
      (DESC "Mirror Room")
      (WEST TO WINDING-PASSAGE)
      (NORTH TO NARROW-PASSAGE)
      (EAST TO TINY-CAVE)
      (ACTION MIRROR-ROOM)
      (FLAGS RLANDBIT ONBIT)>

<ROOM SMALL-CAVE
      (IN ROOMS)
      (LDESC
"This is a tiny cave with entrances west and north, and a staircase
leading down.")
      (DESC "Cave")
      (NORTH TO MIRROR-ROOM-1)
      (DOWN TO ATLANTIS-ROOM)
      (SOUTH TO ATLANTIS-ROOM)
      (WEST TO TWISTING-PASSAGE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM TINY-CAVE
      (IN ROOMS)
      (LDESC
"This is a tiny cave with entrances west and north, and a dark,
forbidding staircase leading down.")
      (DESC "Cave")
      (NORTH TO MIRROR-ROOM-2)
      (WEST TO WINDING-PASSAGE)
      (DOWN TO ENTRANCE-TO-HADES)
      (ACTION CAVE2-ROOM)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM COLD-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a cold and damp corridor where a long east-west passageway
turns into a southward path.")
      (DESC "Cold Passage")
      (SOUTH TO MIRROR-ROOM-1)
      (WEST TO SLIDE-ROOM)
      (FLAGS RLANDBIT)>

<ROOM NARROW-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a long and narrow corridor where a long north-south passageway
briefly narrows even further.")
      (DESC "Narrow Passage")
      (NORTH TO ROUND-ROOM)
      (SOUTH TO MIRROR-ROOM-2)
      (FLAGS RLANDBIT)>

<ROOM WINDING-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a winding passage. It seems that there are only exits
on the east and north.")
      (DESC "Winding Passage")
      (NORTH TO MIRROR-ROOM-2)
      (EAST TO TINY-CAVE)
      (FLAGS RLANDBIT)>

<ROOM TWISTING-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a winding passage. It seems that there are only exits
on the east and north.")
      (DESC "Twisting Passage")
      (NORTH TO MIRROR-ROOM-1)
      (EAST TO SMALL-CAVE)
      (FLAGS RLANDBIT)>

<ROOM ATLANTIS-ROOM
      (IN ROOMS)
      (LDESC
"This is an ancient room, long under water. There is an exit to
the south and a staircase leading up.")
      (DESC "Atlantis Room")
      (UP TO SMALL-CAVE)
      (SOUTH TO RESERVOIR-NORTH)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

\

"SUBTITLE ROUND ROOM AND VICINITY"

<ROOM EW-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a narrow east-west passageway. There is a narrow stairway
leading down at the north end of the room.")
      (DESC "East-West Passage")
      (EAST TO ROUND-ROOM)
      (WEST TO TROLL-ROOM)
      (DOWN TO CHASM-ROOM)
      (NORTH TO CHASM-ROOM)
      (FLAGS RLANDBIT)
      (VALUE 5)
      (GLOBAL STAIRS)>

<ROOM ROUND-ROOM
      (IN ROOMS)
      (LDESC
"This is a circular stone room with passages in all directions. Several
of them have unfortunately been blocked by cave-ins.")
      (DESC "Round Room")
      (EAST TO LOUD-ROOM)
      (WEST TO EW-PASSAGE)
      (NORTH TO NS-PASSAGE)
      (SOUTH TO NARROW-PASSAGE)
      (SE TO ENGRAVINGS-CAVE)
      (FLAGS RLANDBIT)>

<ROOM DEEP-CANYON
      (IN ROOMS)
      (DESC "Deep Canyon")
      (NW TO RESERVOIR-SOUTH) ;COFFIN-CURE
      (EAST TO DAM-ROOM)
      (SW TO NS-PASSAGE)
      (DOWN TO LOUD-ROOM)
      (FLAGS RLANDBIT)
      (ACTION DEEP-CANYON-F)
      (GLOBAL STAIRS)>

<ROOM DAMP-CAVE
      (IN ROOMS)
      (LDESC
"This cave has exits to the west and east, and narrows to a crack toward
the south. The earth is particularly damp here.")
      (DESC "Damp Cave")
      (WEST TO LOUD-ROOM)
      (EAST TO WHITE-CLIFFS-NORTH)
      (SOUTH "It is too narrow for most insects.")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK)>

<ROOM LOUD-ROOM
      (IN ROOMS)
      (DESC "Loud Room")
      (EAST TO DAMP-CAVE)
      (WEST TO ROUND-ROOM)
      (UP TO DEEP-CANYON)
      (ACTION LOUD-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM NS-PASSAGE
      (IN ROOMS)
      (LDESC
"This is a high north-south passage, which forks to the northeast.")
      (DESC "North-South Passage")
      (NORTH TO CHASM-ROOM)
      (NE TO DEEP-CANYON)
      (SOUTH TO ROUND-ROOM)
      (FLAGS RLANDBIT)>

<ROOM CHASM-ROOM
      (IN ROOMS)
      (LDESC
"A chasm runs southwest to northeast and the path follows it. You are
on the south side of the chasm, where a crack opens into a passage.")
      (DESC "Chasm")
      (NE TO RESERVOIR-SOUTH)
      (SW TO EW-PASSAGE)
      (UP TO EW-PASSAGE)
      (SOUTH TO NS-PASSAGE)
      (DOWN "Are you out of your mind?")
      (FLAGS RLANDBIT)
      (GLOBAL CRACK STAIRS)
      (PSEUDO "CHASM" CHASM-PSEUDO)>

\

"SUBTITLE HADES ET AL"

<ROOM ENTRANCE-TO-HADES
      (IN ROOMS)
      (DESC "Entrance to Hades")
      (UP TO TINY-CAVE)
      (IN TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Some invisible force prevents you from passing through the gate.")
      (SOUTH TO LAND-OF-LIVING-DEAD IF LLD-FLAG
       ELSE "Some invisible force prevents you from passing through the gate.")
      (ACTION LLD-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)
      (PSEUDO "GATE" GATE-PSEUDO "GATES" GATE-PSEUDO)>

<ROOM LAND-OF-LIVING-DEAD
      (IN ROOMS)
      (LDESC
"You have entered the Land of the Living Dead. Thousands of lost souls
can be heard weeping and moaning. In the corner are stacked the remains
of dozens of previous adventurers less fortunate than yourself.
A passage exits to the north.")
      (DESC "Land of the Dead")
      (OUT TO ENTRANCE-TO-HADES)
      (NORTH TO ENTRANCE-TO-HADES)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL BODIES)>

\

"SUBTITLE DOME, TEMPLE, EGYPT"

<ROOM ENGRAVINGS-CAVE	;"was CAVE4"
      (IN ROOMS)
      (LDESC
"You have entered a low cave with passages leading northwest and east.")
      (DESC "Engravings Cave")
      (NW TO ROUND-ROOM)
      (EAST TO DOME-ROOM)
      (FLAGS RLANDBIT)>

<ROOM EGYPT-ROOM	;"was EGYPT"
      (IN ROOMS)
      (LDESC
"This is a room which looks like an Egyptian tomb. There is an
ascending staircase to the west.")
      (DESC "Egyptian Room")
      (WEST TO NORTH-TEMPLE)
      (UP TO NORTH-TEMPLE)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)>

<ROOM DOME-ROOM	;"was DOME"
      (IN ROOMS)
      (DESC "Dome Room")
      (WEST TO ENGRAVINGS-CAVE)
      (DOWN TO TORCH-ROOM
       IF DOME-FLAG ELSE "You cannot go down without fracturing many bones.")
      (ACTION DOME-ROOM-FCN)
      (FLAGS RLANDBIT)
      (PSEUDO "DOME" DOME-PSEUDO)>

<ROOM TORCH-ROOM
      (IN ROOMS)
      (DESC "Torch Room")
      (UP "You cannot reach the rope.")
      (SOUTH TO NORTH-TEMPLE)
      (DOWN TO NORTH-TEMPLE)
      (ACTION TORCH-ROOM-FCN)
      (FLAGS RLANDBIT)
      (GLOBAL STAIRS)
      (PSEUDO "DOME" DOME-PSEUDO)>

<ROOM NORTH-TEMPLE	;"was TEMP1"
      (IN ROOMS)
      (LDESC
"This is the north end of a large temple. On the east wall is an
ancient inscription, probably a prayer in a long-forgotten language.
Below the prayer is a staircase leading down. The west wall is solid
granite. The exit to the north end of the room is through huge
marble pillars.")
      (DESC "Temple")
      (DOWN TO EGYPT-ROOM)
      (EAST TO EGYPT-ROOM)
      (NORTH TO TORCH-ROOM)
      (OUT TO TORCH-ROOM)
      (UP TO TORCH-ROOM)
      (SOUTH TO SOUTH-TEMPLE)
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (GLOBAL STAIRS)>

<ROOM SOUTH-TEMPLE	;"was TEMP2"
      (IN ROOMS)
      (LDESC

"This is the south end of a large temple. In front of you is what
appears to be an altar. In one corner is a small hole in the floor
which leads into darkness. You probably could not get back up it.")
      (DESC "Altar")
      (NORTH TO NORTH-TEMPLE)
      (DOWN TO TINY-CAVE
       IF COFFIN-CURE
       ELSE "You haven't a prayer of getting the coffin down there.")
      (FLAGS RLANDBIT ONBIT SACREDBIT)
      (ACTION SOUTH-TEMPLE-FCN)>

