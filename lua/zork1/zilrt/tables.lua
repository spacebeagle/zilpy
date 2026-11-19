-- zilrt/tables.lua: テーブル (0 始まりのバイト列)、ヘッダー。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- Table (0 始まりバイト列)
-- ----------------------------------------------------------------------
TableMT = {}
TableMT.__index = TableMT

function is_table(v)
    return type(v) == "table" and v._is_table == true
end

-- 後で定義する関数の前方宣言 (先に定義する GETB などから使う)
_wide_exits = nil

TableMT.__eq = function(a, b)
    return is_table(a) and is_table(b) and a.cells == b.cells and a.offset == b.offset
end
TableMT.__lt = function(a, b)
    if b == false or b == 0 then return false end
    if a == false or a == 0 then return true end
    if is_table(a) and is_table(b) then
        if a.cells == b.cells then return a.offset < b.offset end
        return tostring(a.cells) < tostring(b.cells)
    end
    return false
end
TableMT.__le = function(a, b)
    return a == b or a < b
end

function new_table(cells, offset, owner)
    return setmetatable({
        _is_table = true,
        cells = cells or {},
        offset = offset or 0,
        owner = owner,
    }, TableMT)
end

function ZG.TBYTE(v)
    if type(v) == "string" and #v > 0 then v = v:byte(1) end
    return { _is_tbyte = true, value = v }
end

function build_table(items, default_byte, length_prefix)
    local cells = {}
    local idx = 1
    if length_prefix then
        cells[idx] = 0; idx = idx + 1
        if not default_byte then
            cells[idx] = false; idx = idx + 1
        end
    end
    local count = 0
    for _, item in ipairs(items) do
        if type(item) == "table" and item._is_tbyte then
            cells[idx] = item.value; idx = idx + 1
            count = count + 1
        elseif default_byte then
            cells[idx] = item; idx = idx + 1
            count = count + 1
        else
            cells[idx] = item; idx = idx + 1
            cells[idx] = false; idx = idx + 1
            count = count + 1
        end
    end
    if length_prefix then
        cells[1] = count
    end
    return new_table(cells, 0)
end

function strip_flags(args)
    local start = 1
    local is_byte = false
    local has_length = false
    local is_string = false
    local a1 = args[1]
    if type(a1) == "table" and not is_table(a1) and not a1._is_object and not a1._is_word and not a1._is_tbyte then
        for _, f in ipairs(a1) do
            if f == "BYTE" then is_byte = true
            elseif f == "LENGTH" then has_length = true
            elseif f == "STRING" then is_string = true; is_byte = true end
        end
        start = 2
    end
    local out = {}
    for i = start, #args do
        local v = args[i]
        if is_string and type(v) == "string" then
            for j = 1, #v do out[#out + 1] = string.byte(v, j) end
        else
            out[#out + 1] = v
        end
    end
    return is_byte, has_length, out
end

function ZG.TABLE(...)
    local is_byte, has_length, items = strip_flags({...})
    return build_table(items, is_byte, has_length)
end
ZG.PTABLE = ZG.TABLE

function ZG.LTABLE(...)
    local is_byte, _, items = strip_flags({...})
    return build_table(items, is_byte, true)
end
ZG.PLTABLE = ZG.LTABLE

function ZG.ITABLE(...)
    local args = {...}
    local idx = 1
    local is_byte = false
    local length_prefix = false
    if args[idx] == "BYTE" then
        is_byte = true
        idx = idx + 1
    elseif args[idx] == "WORD" or args[idx] == "NONE" then
        idx = idx + 1
    end
    local count = tonumber(args[idx]) or 0
    idx = idx + 1
    if type(args[idx]) == "table" and not is_table(args[idx]) and not args[idx]._is_tbyte then
        for _, f in ipairs(args[idx]) do
            if f == "BYTE" then is_byte = true end
            if f == "LENGTH" then length_prefix = true end
        end
        idx = idx + 1
    end
    local pattern = {}
    for i = idx, #args do
        pattern[#pattern + 1] = args[i]
    end
    if #pattern == 0 then pattern[1] = 0 end
    local items = {}
    for _ = 1, count do
        for _, p in ipairs(pattern) do
            items[#items + 1] = p
        end
    end
    return build_table(items, is_byte, length_prefix)
end

-- Z-machine のヘッダー (メモリのアドレス 0) を模したテーブル。ZilRuntime.py の
-- _make_header と同じ内容: バイト 1 に FLAGS1、ワード 1 (バイト 2) にリリース番号、
-- バイト 18〜23 にシリアル番号 (ASCII)、バイト 32 に画面の行数、33 に桁数。
-- バイト 0 (バージョン番号) は 0 のまま (<GET 0 0> を空のポインタの読み取りとして使う
-- パーサーがあるため。Python の _make_header の説明を参照)。
RELEASE_NUMBER = 88
SERIAL_NUMBER = "840726"
SCREEN_WIDTH = 80
SCREEN_HEIGHT = 25
_header = nil

local _FLAGS1_TIME_GAME = 2  -- FLAGS1 の bit 1: ステータス行に時刻を出す (V3。<VERSION ZIP TIME>)

-- <VERSION ...> の引数から、バイト 1 (FLAGS1) の値を求める (Python の _flags1 と同じ)
local function _flags1(version)
    local v3, time = true, false
    for _, arg in ipairs(version or {}) do
        local text = string.upper(tostring(arg))
        if text == "EZIP" or text == "XZIP" or text == "YZIP" or text == "4" or text == "5" or text == "6" then
            v3 = false
        elseif text == "TIME" then
            time = true
        end
    end
    if v3 and time then return _FLAGS1_TIME_GAME end
    return 0
end

function header_table()
    if _header == nil then
        local cells = {}
        for i = 1, 64 do cells[i] = 0 end
        cells[2] = _flags1(GAME_VERSION)
        cells[3] = RELEASE_NUMBER; cells[4] = false
        for pos = 1, #SERIAL_NUMBER do
            cells[18 + pos] = SERIAL_NUMBER:byte(pos)
        end
        cells[33] = SCREEN_HEIGHT
        cells[34] = SCREEN_WIDTH
        _header = new_table(cells, 0)
    end
    return _header
end

-- <GET 0 n> などのアドレス 0 はヘッダーを指す
function _address(tbl)
    if tbl == 0 then return header_table() end
    return tbl
end

-- 辞書の単語の、符号化された文字のワード (<GET 単語 n>)。ZilRuntime.py の _WordText と同じ。
-- Z-machine の辞書エントリの先頭 4 バイトは単語の文字を Z 文字で符号化した 2 ワードで、
-- 1 ワードに 3 文字が入る。パーサーはこれをオブジェクトの短い名前へ書き写して、
-- 擬似オブジェクトの名前を入力した名詞にする (GLOBAL-CHECK の
-- <PUT <BACK <GETPT ,PSEUDO-OBJECT ,P?ACTION> 5> 0 <GET ,P-NAM 0>>)。
ZTEXT_CHARS_PER_WORD = 3
WordTextMT = {}

function word_text_string(wt)
    local start = wt.index * ZTEXT_CHARS_PER_WORD
    return tostring(wt.word.text):sub(start + 1, start + ZTEXT_CHARS_PER_WORD)
end

WordTextMT.__eq = function(a, b)
    return a._is_word_text == true and b._is_word_text == true
        and word_text_string(a) == word_text_string(b)
end

-- オブジェクトの短い名前 (DESC) の文字のワードを書き換える (ZilRuntime.py の
-- _write_short_name と同じ)。プロパティのデータの先頭を 0 とすると、n ワードの名前の
-- k ワード目はバイト位置 -1 - 2n + 2k にある。n は元の名前の長さで決まる。
function write_short_name(obj, index, wt)
    local chunks = obj._short_name_words
    if chunks == nil then
        local desc = (obj.desc ~= nil and obj.desc ~= "") and obj.desc or (obj.name or "")
        local count = math.max(1, math.ceil(#desc / ZTEXT_CHARS_PER_WORD))
        chunks = {}
        for i = 0, count - 1 do
            chunks[i + 1] = desc:sub(i * ZTEXT_CHARS_PER_WORD + 1, (i + 1) * ZTEXT_CHARS_PER_WORD)
        end
        obj._short_name_words = chunks
    end
    local offset = index + 1 + 2 * #chunks
    if offset < 0 or offset % 2 ~= 0 or offset / 2 >= #chunks then return false end
    chunks[offset / 2 + 1] = word_text_string(wt)
    obj.desc = table.concat(chunks)
    return true
end

function ZG.GET(tbl, idx)
    if type(tbl) == "table" and tbl._is_word then
        return setmetatable({ _is_word_text = true, word = tbl, index = idx or 0 }, WordTextMT)
    end
    tbl = _address(tbl)
    if not is_table(tbl) then return 0 end
    local pos = tbl.offset + (idx or 0) * 2 + 1
    local v = tbl.cells[pos]
    if v == nil then return 0 end
    if type(v) == "table" and v._is_global_ref then return ZG[v.name] end
    return v
end

function ZG.PUT(tbl, idx, val)
    tbl = _address(tbl)
    if not is_table(tbl) then return val end
    if type(val) == "table" and val._is_word_text and tbl.owner ~= nil then
        -- プロパティのテーブルの先頭より前への、辞書の単語の文字の書き込みは、
        -- オブジェクトの短い名前の書き換え (ZilRuntime.py の Table.write と同じ)
        local index = tbl.offset + (idx or 0) * 2
        if index < 0 then
            write_short_name(tbl.owner, index, val)
            return val
        end
    end
    local pos = tbl.offset + (idx or 0) * 2 + 1
    tbl.cells[pos] = val
    tbl.cells[pos + 1] = false
    return val
end

function ZG.GETB(tbl, idx)
    if tbl == 0 or tbl == false or tbl == nil then
        -- バイト 0 は Z-machine のバージョン (辞書・出口の配置から決める)
        if idx == 0 then return _wide_exits() and 4 or 3 end
        tbl = header_table()
    end
    if type(tbl) == "table" and tbl._is_word then
        return tbl:getb(idx)
    end
    if not is_table(tbl) then return 0 end
    local pos = tbl.offset + (idx or 0) + 1
    local v = tbl.cells[pos]
    if v == nil then return 0 end
    if type(v) == "table" and v._is_global_ref then return ZG[v.name] end
    return v
end

function ZG.PUTB(tbl, idx, val)
    tbl = _address(tbl)
    if not is_table(tbl) then return val end
    local pos = tbl.offset + (idx or 0) + 1
    tbl.cells[pos] = val
    return val
end

function ZG.REST(tbl, bytes)
    if not is_table(tbl) then return tbl end
    return new_table(tbl.cells, tbl.offset + (bytes or 1), tbl.owner)
end

function ZG.BACK(tbl, bytes)
    if not is_table(tbl) then return tbl end
    return new_table(tbl.cells, tbl.offset - (bytes or 1), tbl.owner)
end

function ZG.ZGET(tbl, idx) return ZG.GET(tbl, idx) end

function ZG.COPYT(src, dst, count)
    if not is_table(src) or not is_table(dst) then return false end
    for i = 0, (count or 0) - 1 do
        dst.cells[dst.offset + i + 1] = src.cells[src.offset + i + 1]
    end
    return true
end
