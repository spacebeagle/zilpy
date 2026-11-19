-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

-- ZORK_NUMBER is declared in ZilGlobal.lua

do local _ = ZG.SNAME("ZORK3") end

REDEFINE = true

do local _ = ZG.PRINC("Renovated ZORK III: The Dungeon Master\n") end

do local _ = ZG.FREQUENT_WORDS_p() end

require("gsyntax")

require("gmacros")

require("gclock")

require("gmain")

require("gparser")

require("_3dungeon")

require("gglobals")

require("gverbs")

require("_3actions")

ZG.PROPDEF("SIZE", 5)

ZG.PROPDEF("CAPACITY", 0)

ZG.PROPDEF("VALUE", 0)

ZG._link()
ZG.GO()
