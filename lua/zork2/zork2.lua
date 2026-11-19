-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- ZORK_NUMBER is declared in ZilGlobal.lua

REDEFINE = true

do local _ = ZG.PRINC("Renovated ZORK II: The Wizard of Frobozz\n") end

do local _ = ZG.FREQUENT_WORDS_p() end

require("gmacros")

require("gsyntax")

require("_2dungeon")

require("gglobals")

ZG.PROPDEF("SIZE", 5)

ZG.PROPDEF("CAPACITY", 0)

ZG.PROPDEF("VALUE", 0)

require("gclock")

require("gmain")

require("gparser")

require("gverbs")

require("_2actions")

ZG._link()
ZG.GO()
