-- zilrt/vocab.lua: 辞書・構文テーブル・宣言フォーム。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- 辞書・構文・宣言フォーム
-- ----------------------------------------------------------------------
function ZG.WORD(w)
    return _word(w)
end

function ZG.SYMBOL(name)
    _finalize_vocabulary()
    local s = tostring(name)
    local prefix, base = s:match("^([^%?]+)%?(.*)$")
    if prefix == "V" then
        return _action_id("V-" .. base)
    elseif prefix == "A" then
        return _adjective_id(base)
    elseif prefix == "ACT" or prefix == "PR" then
        local w = _vocab[_norm_key(base)]
        if not w then return 0 end
        return w.parts[prefix == "ACT" and PS_VERB or PS_PREPOSITION] or 0
    end
    return 0
end

function ZG.VOC(word, kind)
    local key = tostring(word)
    local w = _word(key)
    local k = kind and tostring(kind):upper() or ""
    if k == "ADJ" or k == "ADJECTIVE" then
        w.parts[PS_ADJECTIVE] = _adjective_id(key)
    elseif k == "NOUN" or k == "OBJECT" then
        if w.parts[PS_OBJECT] == nil then w.parts[PS_OBJECT] = 0 end
    elseif k == "BUZZ" then
        if w.parts[PS_BUZZ_WORD] == nil then w.parts[PS_BUZZ_WORD] = 0 end
    end
    _vocab_ready = false
    return w
end

_dir_set = {}
_dir_pos = {}
LowDirMT = {
    __lt = function(a, b)
        if b == ZG.LOW_DIRECTION then
            return not _dir_set[tostring(a):upper()]
        end
        return _dir_set[tostring(b):upper()] == true
    end,
    __le = function(a, b)
        if b == ZG.LOW_DIRECTION then
            return not _dir_set[tostring(a):upper()]
        end
        return _dir_set[tostring(b):upper()] == true
    end,
    __sub = function(a, b)
        if b == ZG.LOW_DIRECTION then
            local idx = _dir_pos[tostring(a):upper()]
            if idx then return #_directions - idx end
        end
        return 0
    end,
}
ZG.LOW_DIRECTION = setmetatable({}, LowDirMT)

function _dir_num(d)
    local idx = _dir_pos[tostring(d):upper()]
    if not idx then return nil end
    return #_directions - idx
end

function ZG.NEXTP(obj, prop)
    if not is_object(obj) then return 0 end
    local dirs, others = {}, {}
    for k in pairs(obj.props) do
        local uk = tostring(k):upper()
        if uk ~= "FLAGS" and uk ~= "LOC" and uk ~= "DESC" then
            if _dir_set[uk] then
                dirs[#dirs + 1] = k
            else
                others[#others + 1] = k
            end
        end
    end
    table.sort(dirs, function(a, b)
        return (_dir_num(a) or 0) > (_dir_num(b) or 0)
    end)
    table.sort(others)
    local keys = {}
    for _, k in ipairs(dirs) do keys[#keys + 1] = k end
    for _, k in ipairs(others) do keys[#keys + 1] = k end
    if not prop or prop == 0 then return keys[1] or 0 end
    local target = tostring(prop):upper()
    for i, k in ipairs(keys) do
        if k == target then return keys[i + 1] or 0 end
    end
    return 0
end

function _num(v)
    if v == true then return 1 end
    if v == false or v == nil then return 0 end
    return tonumber(v) or 0
end

function ZG.ADD(a, b)
    return _num(a) + _num(b)
end

function ZG.SUB(a, b)
    if b == ZG.LOW_DIRECTION then
        local na = _dir_num(a)
        if na ~= nil then return na end
    end
    if type(a) == "string" and type(b) == "string" then
        local na, nb = _dir_num(a), _dir_num(b)
        if na ~= nil and nb ~= nil then return na - nb end
    end
    return _num(a) - _num(b)
end

function ZG.NEG(x)
    if type(x) == "string" then
        return (x:sub(1, 1) == "-") and x:sub(2) or ("-" .. x)
    end
    return -(tonumber(x) or 0)
end

-- テーブルのアドレスの大小比較 (ZilRuntime.py の Table._address と同じ)。同じ表を REST で
-- 進めたテーブルどうしは先頭のバイト位置で比べる (例: Spellbreaker の QUEUE の
-- <G? .INT ,CLOCK-HAND>)。アドレス 0 (または偽) は、どのテーブルのアドレスよりも小さい。
_cells_ids = setmetatable({}, { __mode = "k" })
_next_cells_id = 0

function _table_address(v)
    if v == false or v == 0 or v == nil then return 0, 0 end
    if is_table(v) then
        local id = _cells_ids[v.cells]
        if id == nil then
            _next_cells_id = _next_cells_id + 1
            id = _next_cells_id
            _cells_ids[v.cells] = id
        end
        return id, v.offset
    end
    return nil, nil
end

-- a と b の少なくとも一方がテーブルなら、アドレスで比べた結果 (-1, 0, 1) を返す
function _compare_addresses(a, b)
    if not is_table(a) and not is_table(b) then return nil end
    local ia, oa = _table_address(a)
    local ib, ob = _table_address(b)
    if ia == nil or ib == nil then return nil end
    if ia ~= ib then return ia < ib and -1 or 1 end
    if oa ~= ob then return oa < ob and -1 or 1 end
    return 0
end

function ZG.LT(a, b)
    local order = _compare_addresses(a, b)
    if order ~= nil then return order < 0 end
    if type(a) == "string" and b == 0 then return a:sub(1, 1) == "-" end
    if a == 0 and type(b) == "string" then return b:sub(1, 1) ~= "-" end
    if b == ZG.LOW_DIRECTION then return not _dir_set[tostring(a):upper()] end
    if a == ZG.LOW_DIRECTION then return _dir_set[tostring(b):upper()] == true end
    if type(a) == "string" and type(b) == "string" then
        local na, nb = _dir_num(a), _dir_num(b)
        if na ~= nil and nb ~= nil then return na < nb end
    end
    return _num(a) < _num(b)
end

function ZG.LE(a, b)
    local order = _compare_addresses(a, b)
    if order ~= nil then return order <= 0 end
    if b == ZG.LOW_DIRECTION then return not _dir_set[tostring(a):upper()] end
    if a == ZG.LOW_DIRECTION then return _dir_set[tostring(b):upper()] == true end
    if type(a) == "string" and type(b) == "string" then
        local na, nb = _dir_num(a), _dir_num(b)
        if na ~= nil and nb ~= nil then return na <= nb end
    end
    return _num(a) <= _num(b)
end

function ZG.DIRECTIONS(...)
    for _, d in ipairs({...}) do
        local ud = tostring(d):upper()
        if not _dir_set[ud] then
            _directions[#_directions + 1] = ud
            _dir_set[ud] = true
            _dir_pos[ud] = #_directions
        end
    end
    _vocab_ready = false
    return true
end

function ZG.BUZZ(...)
    for _, w in ipairs({...}) do
        _buzz_words[#_buzz_words + 1] = tostring(w)
    end
    _vocab_ready = false
    return true
end

function ZG.SYNONYM(...)
    local grp = {}
    for _, w in ipairs({...}) do grp[#grp + 1] = tostring(w) end
    _synonym_groups[#_synonym_groups + 1] = grp
    _vocab_ready = false
    return true
end
ZG.VERB_SYNONYM = ZG.SYNONYM
ZG.PREP_SYNONYM = ZG.SYNONYM
ZG.ADJ_SYNONYM = ZG.SYNONYM
ZG.DIR_SYNONYM = ZG.SYNONYM

function ZG.SYNTAX(...)
    _syntax_entries[#_syntax_entries + 1] = {...}
    _vocab_ready = false
    return true
end

-- 作品の <VERSION ...> の引数 (例: {"ZIP", "TIME"})。ヘッダーのバイト 0・1 の値を決めるのに使う
GAME_VERSION = {}
function ZG.VERSION(...) GAME_VERSION = {...}; return true end
