-- ZIL から自動生成した Lua 5.1 コード

local ZG = require("ZilGlobal")

do local _ = ZG.VERSION("ZIP") end

-- ZORK_NUMBER is declared in ZilGlobal.lua

REDEFINE = true

do local _ = ZG.PRINC("Renovated ZORK I: The Great Underground Empire\n") end

do local _ = ZG.FREQUENT_WORDS_p() end

require("gmacros")

require("gsyntax")

require("_1dungeon")

require("gglobals")

ZG.PROPDEF("SIZE", 5)

ZG.PROPDEF("CAPACITY", 0)

ZG.PROPDEF("VALUE", 0)

ZG.PROPDEF("TVALUE", 0)

require("gclock")

require("gmain")

require("gparser")

require("gverbs")

require("_1actions")

ZG._link()
ZG.GO()
