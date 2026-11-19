-- zilrt/objects.lua: オブジェクト・親子関係・フラグ・プロパティ・出口。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- ZObject (オブジェクト・親子関係・フラグ・プロパティ)
-- ----------------------------------------------------------------------
function to_ident(name)
    local s = tostring(name):gsub("%?", "_p"):gsub("!", "_l"):gsub("[^%w_]", "_")
    if s:match("^%d") then s = "_" .. s end
    return s
end

function is_object(v)
    return type(v) == "table" and v._is_object == true
end

_vocab_ready = false
_verb_names = {}
_verb_index = {}
_prep_words = {}
_prep_numbers = {}
_synonym_groups = {}
_buzz_words = {}
_adj_ids = {}
_next_adj_id = 1
_action_names = { "" }
_action_ids = {}
_preaction_names = {}

PS_OBJECT = 128
PS_VERB = 64
PS_ADJECTIVE = 32
PS_DIRECTION = 16
PS_PREPOSITION = 8
PS_BUZZ_WORD = 4
ZG.PS_OBJECT = PS_OBJECT
ZG.PS_VERB = PS_VERB
ZG.PS_ADJECTIVE = PS_ADJECTIVE
ZG.PS_DIRECTION = PS_DIRECTION
ZG.PS_PREPOSITION = PS_PREPOSITION
ZG.PS_BUZZ_WORD = PS_BUZZ_WORD
ZG.P1_OBJECT = 128
ZG.P1_VERB = 3
ZG.P1_ADJECTIVE = 2
ZG.P1_DIRECTION = 1
ZG.P1_PREPOSITION = 0
ZG.P1_BUZZ_WORD = 0
_VALUE_PARTS = { PS_VERB, PS_DIRECTION, PS_ADJECTIVE, PS_PREPOSITION }
_FIRST_PART_CODE = {
    [PS_VERB] = 3,
    [PS_ADJECTIVE] = 2,
    [PS_DIRECTION] = 1,
    [PS_PREPOSITION] = 0,
}

_finalize_vocabulary = nil

WordMT = {}
WordMT.__index = WordMT
WordMT.__eq = function(a, b)
    if type(a) == "table" and a._is_word and type(b) == "table" and b._is_word then
        return a.text == b.text
    end
    return false
end
WordMT.__tostring = function(w) return w.text end

function WordMT:getb(index)
    _finalize_vocabulary()
    local ps_byte = tonumber(rawget(ZG, "P_PSOFF")) or 4
    local val1_byte = tonumber(rawget(ZG, "P_P1OFF")) or 5
    local valued = {}
    for _, bit in ipairs(_VALUE_PARTS) do
        if self.parts[bit] ~= nil then
            valued[#valued + 1] = bit
        end
    end
    if index == ps_byte then
        local bits = 0
        for bit in pairs(self.parts) do bits = bits + bit end
        local code = (#valued > 0) and (_FIRST_PART_CODE[valued[1]] or 0) or 0
        return _bor(bits, code)
    end
    local slot = index - val1_byte + 1
    if (slot == 1 or slot == 2) and slot <= #valued then
        return self.parts[valued[slot]]
    end
    return 0
end

_SEP_WORDS = { ["."] = "period", [","] = "comma", ['"'] = "quote" }

function _significant_chars()
    local ok, off = pcall(function() return tonumber(ZG.P_PSOFF) end)
    if ok and off and off > 4 then return 9 end
    return 6
end

_wide_exits = function()
    local ok, u = pcall(function() return tonumber(ZG.UEXIT) end)
    return ok and u == 2
end

function _norm_key(text)
    local s = tostring(text):lower()
    if _SEP_WORDS[s] then return _SEP_WORDS[s] end
    return s:sub(1, _significant_chars())
end

function _word(text)
    local key = _norm_key(text)
    if not _vocab[key] then
        _vocab[key] = setmetatable({ _is_word = true, text = key, parts = {} }, WordMT)
    end
    return _vocab[key]
end

function _action_id(name)
    local key = tostring(name)
    if not _action_ids[key] then
        _action_names[#_action_names + 1] = key
        _action_ids[key] = #_action_names - 1
    end
    return _action_ids[key]
end

function _adjective_id(text)
    local key = _norm_key(text)
    if not _adj_ids[key] then
        _adj_ids[key] = _next_adj_id
        _next_adj_id = _next_adj_id + 1
    end
    return _adj_ids[key]
end

function _syntax_slots(parts)
    local eq = #parts + 1
    for i, p in ipairs(parts) do
        if p == "=" then eq = i; break end
    end
    local preps = { 0, 0 }
    local finds = { 0, 0 }
    local locs = { 0, 0 }
    local pending_prep = 0
    local count = 0
    for i = 2, eq - 1 do
        local tok = parts[i]
        if tok == "OBJECT" then
            if count < 2 then preps[count + 1] = pending_prep end
            pending_prep = 0
            count = count + 1
        elseif type(tok) == "table" and not is_table(tok) then
            local slot = count
            if slot >= 1 and slot <= 2 and #tok > 0 then
                if tok[1] == "FIND" then
                    finds[slot] = tok[2]
                else
                    locs[slot] = tok
                end
            end
        else
            pending_prep = tok
        end
    end
    if pending_prep ~= 0 and count < 2 then
        preps[count + 1] = pending_prep
    end
    local action = parts[eq + 1] or ""
    local preaction = parts[eq + 2] or ""
    return parts[1], preps, finds, locs, action, preaction, count
end

_finalize_vocabulary = function()
    if _vocab_ready then return end
    _vocab_ready = true
    _verb_names = {}
    _verb_index = {}
    _prep_words = {}
    _prep_numbers = {}
    for _, syntax in ipairs(_syntax_entries) do
        local verb = tostring(syntax[1])
        local key = _norm_key(verb)
        if _verb_index[key] == nil then
            _verb_index[key] = #_verb_names
            _verb_names[#_verb_names + 1] = verb
        end
        for i = 2, #syntax do
            local tok = syntax[i]
            if tok == "=" then break end
            if type(tok) == "string" and tok ~= "OBJECT" then
                local pkey = _norm_key(tok)
                if not _prep_numbers[pkey] then
                    _prep_words[#_prep_words + 1] = pkey
                    _prep_numbers[pkey] = #_prep_words
                end
            end
        end
    end
    local dirs = {}
    for _, name in ipairs(_directions) do
        dirs[_norm_key(name)] = name:upper()
    end
    for _, group in ipairs(_synonym_groups) do
        local first = _norm_key(group[1])
        for i = 2, #group do
            local key = _norm_key(group[i])
            if _verb_index[first] ~= nil and _verb_index[key] == nil then
                _verb_index[key] = _verb_index[first]
            end
            if _prep_numbers[first] and not _prep_numbers[key] then
                _prep_numbers[key] = _prep_numbers[first]
                _prep_words[#_prep_words + 1] = key
            end
            if dirs[first] and not dirs[key] then
                dirs[key] = dirs[first]
            end
        end
    end
    for key, idx in pairs(_verb_index) do
        _word(key).parts[PS_VERB] = 255 - idx
    end
    for key, num in pairs(_prep_numbers) do
        _word(key).parts[PS_PREPOSITION] = num
    end
    for key, dname in pairs(dirs) do
        _word(key).parts[PS_DIRECTION] = dname
    end
    for _, bw in ipairs(_buzz_words) do
        local w = _word(bw)
        if w.parts[PS_BUZZ_WORD] == nil then w.parts[PS_BUZZ_WORD] = 0 end
    end
    for _, syntax in ipairs(_syntax_entries) do
        local _, _, _, _, action, preaction = _syntax_slots(syntax)
        local aid = _action_id(action)
        if preaction ~= "" then
            _preaction_names[aid] = preaction
        end
    end
end

_LOC_BITS = {
    ["HELD"] = "SH",
    ["CARRIED"] = "SC",
    ["IN-ROOM"] = "SIR",
    ["ON-GROUND"] = "SOG",
    ["TAKE"] = "STAKE",
    ["MANY"] = "SMANY",
    ["HAVE"] = "SHAVE",
}

function _loc_bits(names)
    if type(names) ~= "table" then return 0 end
    local s = 0
    for _, n in ipairs(names) do
        local gname = _LOC_BITS[tostring(n):upper()]
        if gname and type(ZG[gname]) == "number" then s = s + ZG[gname] end
    end
    return s
end

function _prep_num(w)
    if not w or w == 0 then return 0 end
    return _prep_numbers[_norm_key(w)] or 0
end

ZG._declare("VERBS", function()
    _finalize_vocabulary()
    local per_verb = {}
    for i = 1, #_verb_names do per_verb[i] = {} end
    for _, syntax in ipairs(_syntax_entries) do
        local verb, preps, finds, locs, action, _, count = _syntax_slots(syntax)
        local vidx = _verb_index[_norm_key(verb)] + 1
        local entry = {
            math.min(count, 2),
            _prep_num(preps[1]),
            _prep_num(preps[2]),
            finds[1],
            finds[2],
            _loc_bits(locs[1]),
            _loc_bits(locs[2]),
            _action_id(action),
        }
        table.insert(per_verb[vidx], { count = count, entry = entry })
    end
    local tables = {}
    for i = 1, #per_verb do
        local entries = per_verb[i]
        -- ZILCH は、同じ動詞の構文を宣言と逆の順に並べる (ZilRuntime.py の _build_verbs と
        -- 同じ。コンパイル済みの Zork I で確認)。table.sort は安定でないので使わない
        local cells = { #entries }
        for k = #entries, 1, -1 do
            local item = entries[k]
            for _, v in ipairs(item.entry) do cells[#cells + 1] = v end
        end
        tables[#tables + 1] = build_table(cells, true, false)
    end
    return build_table(tables, false, false)
end)

ZG._declare("PREPOSITIONS", function()
    _finalize_vocabulary()
    local cells = { #_prep_words }
    for _, key in ipairs(_prep_words) do
        cells[#cells + 1] = _word(key)
        cells[#cells + 1] = _prep_numbers[key]
    end
    return build_table(cells, false, false)
end)

ZG._declare("ACTIONS", function()
    _finalize_vocabulary()
    local routines = {}
    for i = 1, #_action_names do
        local name = _action_names[i]
        routines[i] = (name ~= "" and ZG[to_ident(name)]) or 0
    end
    return build_table(routines, false, false)
end)

ZG._declare("PREACTIONS", function()
    _finalize_vocabulary()
    local routines = {}
    for i = 1, #_action_names do
        local name = _preaction_names[i - 1]
        routines[i] = (name and name ~= "" and ZG[to_ident(name)]) or 0
    end
    return build_table(routines, false, false)
end)

function _register_object_words(synonyms, adjectives)
    local nouns = {}
    if type(synonyms) == "string" then synonyms = { synonyms } end
    if type(synonyms) == "table" then
        for _, t in ipairs(synonyms) do
            local w = _word(t)
            if w.parts[PS_OBJECT] == nil then w.parts[PS_OBJECT] = 0 end
            nouns[#nouns + 1] = w
        end
    end
    local numbers = {}
    local words = {}
    if type(adjectives) == "string" then adjectives = { adjectives } end
    if type(adjectives) == "table" then
        for _, t in ipairs(adjectives) do
            local num = _adjective_id(t)
            local w = _word(t)
            w.parts[PS_ADJECTIVE] = num
            numbers[#numbers + 1] = num
            words[#words + 1] = w
        end
    end
    if _wide_exits() then
        return build_table(nouns, false, false), build_table(words, false, false)
    end
    return build_table(nouns, false, false), build_table(numbers, true, false)
end

function _apply_object_props(obj, props)
    local syn_list, adj_list = nil, nil
    if props then
        for k, v in pairs(props) do
            local uk = tostring(k):upper()
            if uk == "FLAGS" then
                if type(v) == "table" and not is_table(v) then
                    for _, f in ipairs(v) do obj.flags[tostring(f):upper()] = true end
                elseif type(v) == "string" then
                    obj.flags[v:upper()] = true
                end
            elseif uk == "DESC" then
                obj.desc = tostring(v)
            elseif uk == "LOC" then
                obj._init_loc = v
            elseif uk == "GLOBAL" then
                -- 共有オブジェクトを 1 バイトずつ並べたテーブル (パーサーが GETB と PTSIZE で
                -- 読む)。オブジェクトをワードで持つ配置 (UEXIT = 2。Trinity・AMFV) では、
                -- GET/B (= GET) と PTSIZE / 2 で読むので 1 ワードずつ並べる (ZilRuntime.py と同じ)
                local list = v
                if type(v) ~= "table" or is_table(v) or is_object(v) then list = { v } end
                obj.props[uk] = build_table(list, not _wide_exits(), false)
            elseif uk == "SYNONYM" then
                syn_list = v
            elseif uk == "ADJECTIVE" then
                adj_list = v
            elseif uk == "PSEUDO" and type(v) == "table" and not is_table(v) then
                local pt = {}
                for i = 1, #v do
                    if i % 2 == 1 and type(v[i]) == "string" then
                        local nw = _word(v[i])
                        if nw.parts[PS_OBJECT] == nil then nw.parts[PS_OBJECT] = 0 end
                        pt[i] = nw
                    else
                        pt[i] = v[i]
                    end
                end
                _vocab_ready = false
                obj.props[uk] = build_table(pt, false, false)
                obj.props[uk].owner = obj
            else
                obj.props[uk] = v
            end
        end
    end
    if syn_list ~= nil or adj_list ~= nil then
        local nt, at = _register_object_words(syn_list, adj_list)
        if syn_list ~= nil then obj.props["SYNONYM"] = nt end
        if adj_list ~= nil then obj.props["ADJECTIVE"] = at end
    end
    if obj._init_loc and is_object(obj._init_loc) then
        ZG.MOVE(obj, obj._init_loc)
        obj._init_loc = nil
    end
end

function new_object(name, props)
    local obj = {
        _is_object = true,
        name = name,
        props = {},
        flags = {},
        parent = false,
        children = {},
        desc = "",
    }
    _objects[#_objects + 1] = obj
    if type(props) == "function" then
        -- プロパティは、名前を登録した直後に _finish_object で評価する (_resolve を参照)
        obj._props_fn = props
    elseif props then
        _apply_object_props(obj, props)
    end
    return obj
end

-- オブジェクトのプロパティを評価して適用する (まだなら)
_finish_object = function(obj)
    local fn = obj._props_fn
    if fn ~= nil then
        obj._props_fn = nil
        _apply_object_props(obj, fn())
    end
end

function ZG._declare_object(name, props)
    return new_object(name, props)
end

function ZG.PROPDEF(name, default_val)
    _prop_defaults[tostring(name):upper()] = default_val
end

function ZG.REMOVE(obj)
    if not is_object(obj) then return false end
    local p = obj.parent
    if is_object(p) then
        for i, c in ipairs(p.children) do
            if c == obj then
                table.remove(p.children, i)
                break
            end
        end
    end
    obj.parent = false
    return true
end

function ZG.MOVE(obj, dest)
    if not is_object(obj) then return false end
    ZG.REMOVE(obj)
    if is_object(dest) then
        obj.parent = dest
        table.insert(dest.children, 1, obj)
    end
    return true
end

function ZG.IN_p(obj, cont)
    if not is_object(obj) then return false end
    return obj.parent == cont
end

function ZG.LOC(obj)
    if not is_object(obj) then return false end
    return obj.parent or false
end

function ZG.FIRST_p(obj)
    if not is_object(obj) then return false end
    return obj.children[1] or false
end

function ZG.NEXT_p(obj)
    if not is_object(obj) or not is_object(obj.parent) then return false end
    local ch = obj.parent.children
    for i, c in ipairs(ch) do
        if c == obj then
            return ch[i + 1] or false
        end
    end
    return false
end

function ZG.FSET(obj, flag)
    if not is_object(obj) then return false end
    obj.flags[tostring(flag):upper()] = true
    return true
end

function ZG.FCLEAR(obj, flag)
    if not is_object(obj) then return false end
    obj.flags[tostring(flag):upper()] = nil
    return true
end

function ZG.FSET_p(obj, flag)
    if not is_object(obj) then return false end
    return obj.flags[tostring(flag):upper()] == true
end

function ZG.GETP(obj, prop)
    if not is_object(obj) then return 0 end
    local k = tostring(prop):upper()
    if k == "DESC" then return obj.desc end
    local v = obj.props[k]
    if v ~= nil then return v end
    local d = _prop_defaults[k]
    if d ~= nil then return d end
    return 0
end

function ZG.PUTP(obj, prop, val)
    if not is_object(obj) then return val end
    local k = tostring(prop):upper()
    if k == "DESC" then
        obj.desc = tostring(val)
    else
        obj.props[k] = val
    end
    return val
end

function _encode_exit(v)
    local wide = _wide_exits()
    if type(v) == "table" and not is_table(v) and #v == 2 and v[1] == "SORRY" then
        v = v[2]
    end
    if type(v) == "string" then
        return new_table(wide and { v, false, 0 } or { v, false }, 0)
    end
    if type(v) == "table" and not is_table(v) then
        if v[1] == "PER" then
            return new_table(wide and { v[2], false, 0, 0 } or { v[2], false, 0 }, 0)
        elseif v[1] == "TO" then
            local room = v[2]
            if #v == 2 then
                return new_table(wide and { room, false } or { room }, 0)
            end
            local msg = 0
            local cond = nil
            local is_door = false
            for i = 3, #v do
                if v[i] == "ELSE" and v[i + 1] ~= nil then msg = v[i + 1] end
                if v[i] == "IF" and v[i + 1] ~= nil then cond = v[i + 1] end
                if v[i] == "IS" then is_door = true end
            end
            if is_door then
                if wide then
                    return new_table({ room, false, ZG[cond], false, msg, false }, 0)
                end
                return new_table({ room, ZG[cond], msg, false, 0 }, 0)
            else
                if wide then
                    return new_table({ room, false, msg, false, { _is_global_ref = true, name = cond } }, 0)
                end
                return new_table({ room, { _is_global_ref = true, name = cond }, msg, false }, 0)
            end
        end
    end
    return nil
end

function ZG.GETPT(obj, prop)
    if not is_object(obj) then return false end
    local k = tostring(prop):upper()
    local v = obj.props[k]
    if v == nil then return false end
    if is_table(v) then v.owner = obj; return v end
    local exit_tbl = _encode_exit(v)
    if exit_tbl then
        exit_tbl.owner = obj
        obj.props[k] = exit_tbl
        return exit_tbl
    end
    if type(v) == "table" and not is_object(v) then
        local t = build_table(v, false, false)
        t.owner = obj
        obj.props[k] = t
        return t
    end
    local t = build_table({ v }, false, false)
    t.owner = obj
    return t
end

-- プロパティテーブルのバイト数 (テーブルの先頭から末尾まで。ZilRuntime.py の Table.size と同じ)
function ZG.PTSIZE(pt)
    if is_table(pt) then return #pt.cells - pt.offset end
    return 0
end
