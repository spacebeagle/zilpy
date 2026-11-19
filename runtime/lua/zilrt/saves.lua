-- zilrt/saves.lua: SAVE・RESTORE・ISAVE・IRESTORE と、状態のスナップショット (Lua 5.1 互換のシリアライザ)。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- SAVE / RESTORE / ISAVE / IRESTORE (Lua 5.1 互換シリアライザ)
-- ----------------------------------------------------------------------
_obj_index = {}
function _ensure_obj_index()
    for i, o in ipairs(_objects) do _obj_index[o] = i end
end

function _serialize_state()
    _ensure_obj_index()
    local cells_id = {}
    local cells_list = {}
    local function reg_cells(c)
        if not cells_id[c] then
            cells_list[#cells_list + 1] = c
            cells_id[c] = #cells_list
        end
        return cells_id[c]
    end
    local function enc_val(v)
        local tv = type(v)
        if v == nil then return "nil"
        elseif tv == "boolean" then return v and "true" or "false"
        elseif tv == "number" then return tostring(v)
        elseif tv == "string" then return string.format("%q", v)
        elseif tv == "function" then
            local fn = _fn_to_name[v]
            return fn and string.format("H.F(%q)", fn) or "false"
        elseif tv == "table" then
            if v._is_object then
                local oi = _obj_index[v]
                return oi and ("H.O(" .. oi .. ")") or "false"
            elseif v._is_word then
                return string.format("H.W(%q)", v.text)
            elseif v._is_global_ref then
                return string.format("H.G(%q)", v.name)
            elseif v._is_table then
                local cid = reg_cells(v.cells)
                local ow = v.owner and _obj_index[v.owner] or "nil"
                return string.format("H.T(%d,%d,%s)", cid, v.offset or 0, tostring(ow))
            else
                local parts = {}
                for k, item in pairs(v) do
                    local ks = type(k) == "number" and ("[" .. k .. "]") or ("[" .. string.format("%q", tostring(k)) .. "]")
                    parts[#parts + 1] = ks .. "=" .. enc_val(item)
                end
                return "{" .. table.concat(parts, ",") .. "}"
            end
        end
        return "false"
    end

    local out = { "return function(H)\nlocal S={objects={},globals={},cells={}}\n" }
    local obj_chunks = {}
    for i, o in ipairs(_objects) do
        local p_enc = enc_val(o.props)
        local f_parts = {}
        for fl in pairs(o.flags) do f_parts[#f_parts + 1] = string.format("[%q]=true", fl) end
        local p_idx = o.parent and _obj_index[o.parent] or "false"
        local ch_parts = {}
        for _, c in ipairs(o.children) do ch_parts[#ch_parts + 1] = tostring(_obj_index[c]) end
        obj_chunks[#obj_chunks + 1] = string.format(
            "S.objects[%d]={props=%s,flags={%s},parent=%s,children={%s},desc=%q}\n",
            i, p_enc, table.concat(f_parts, ","), tostring(p_idx), table.concat(ch_parts, ","), o.desc or ""
        )
    end
    local g_chunks = {}
    for k, v in pairs(ZG) do
        if type(k) == "string" and k ~= "actions" and k:sub(1, 1) ~= "_" and type(v) ~= "function" then
            if not (type(v) == "table" and (v._is_object or k == "LOW_DIRECTION")) then
                g_chunks[#g_chunks + 1] = string.format("S.globals[%q]=%s\n", k, enc_val(v))
            elseif type(v) == "table" and v._is_object then
                g_chunks[#g_chunks + 1] = string.format("S.globals[%q]=%s\n", k, enc_val(v))
            end
        end
    end
    -- reg_cells が obj_chunks/g_chunks で増えるので最後に cells を書き出す
    local c_idx = 1
    while c_idx <= #cells_list do
        local c = cells_list[c_idx]
        local max_n = 0
        for k in pairs(c) do if type(k) == "number" and k > max_n then max_n = k end end
        local arr = {}
        for j = 1, max_n do arr[j] = enc_val(c[j]) end
        out[#out + 1] = string.format("S.cells[%d]={%s}\n", c_idx, table.concat(arr, ","))
        c_idx = c_idx + 1
    end
    for _, s in ipairs(obj_chunks) do out[#out + 1] = s end
    for _, s in ipairs(g_chunks) do out[#out + 1] = s end
    out[#out + 1] = string.format("S.rng_state=%d\n", _test_rng_state)
    out[#out + 1] = "return S\nend\n"
    return table.concat(out)
end

function _apply_serialized_state(chunk_src)
    local loader, err = load_chunk(chunk_src)
    if not loader then return false end
    local ok, builder = pcall(loader)
    if not ok or type(builder) ~= "function" then return false end
    local cells_pool = {}
    local H = {
        O = function(i) return _objects[i] or false end,
        F = function(name) return Actions:get(name) or false end,
        W = function(text) return _word(text) end,
        G = function(name) return { _is_global_ref = true, name = name } end,
        T = function(cid, off, ow)
            if not cells_pool[cid] then cells_pool[cid] = {} end
            return new_table(cells_pool[cid], off, ow and _objects[ow] or nil)
        end,
    }
    local S = builder(H)
    for cid, arr in pairs(S.cells) do
        if not cells_pool[cid] then cells_pool[cid] = {} end
        for k, v in pairs(arr) do cells_pool[cid][k] = v end
    end
    for i, so in ipairs(S.objects) do
        local o = _objects[i]
        if o then
            o.props = so.props
            o.flags = so.flags
            o.parent = so.parent and _objects[so.parent] or false
            o.children = {}
            for j, ci in ipairs(so.children) do o.children[j] = _objects[ci] end
            o.desc = so.desc
        end
    end
    for k, v in pairs(S.globals) do
        rawset(ZG, k, v)
    end
    if S.rng_state ~= nil then
        _test_rng_seed(S.rng_state)
    end
    return true
end

_mem_saves = {}
function _save_filename(slot)
    if slot and tostring(slot) ~= "" then
        return "zork-" .. tostring(slot):gsub("[^%w_-]", "_") .. ".sav.lua"
    end
    return "zil-save.sav.lua"
end

function ZG.SAVE(slot)
    local f = io.open(_save_filename(slot), "w")
    if not f then return false end
    f:write(_serialize_state())
    f:close()
    return true
end

function ZG.RESTORE(slot)
    local f = io.open(_save_filename(slot), "r")
    if not f then return false end
    local src = f:read("*a")
    f:close()
    return _apply_serialized_state(src)
end

function ZG.ISAVE()
    _mem_saves._auto = _serialize_state()
    return 1
end

function ZG.IRESTORE()
    if not _mem_saves._auto then return 0 end
    return _apply_serialized_state(_mem_saves._auto) and 2 or 0
end

function ZG.LIST_SAVES() return {} end

function ZG.DIROUT(stream, tbl)
    if tbl ~= nil and type(tbl) ~= "boolean" then
        _capture_tbl = tbl
        _capture_chars = {}
    elseif (stream == 0 or stream == -3) and _capture_tbl ~= nil then
        local text = table.concat(_capture_chars)
        local target = _capture_tbl
        _capture_tbl = nil
        _capture_chars = {}
        ZG.PUT(target, 0, #text)
        for pos = 1, #text do
            ZG.PUTB(target, 1 + pos, text:byte(pos))
        end
    end
    return true
end

function ZG._snapshot_state() return _serialize_state() end
function ZG._restore_snapshot(src) return _apply_serialized_state(src) end

function ZG._look_state()
    local here = ZG.HERE
    local lit = ZG._T(ZG.LIT)
    local winner = ZG.WINNER or ZG.PLAYER or ZG.ADVENTURER
    local inv = {}
    if is_object(winner) then
        for _, c in ipairs(winner.children) do
            if not ZG.FSET_p(c, "INVISIBLE") then
                inv[#inv + 1] = { name = c.desc ~= "" and c.desc or c.name }
            end
        end
    end
    local visible = {}
    if lit and is_object(here) then
        for _, c in ipairs(here.children) do
            if c ~= winner and not ZG.FSET_p(c, "INVISIBLE") then
                visible[#visible + 1] = { name = c.desc ~= "" and c.desc or c.name }
            end
        end
    end
    return {
        location = is_object(here) and (here.desc ~= "" and here.desc or here.name) or "",
        lit = lit,
        inventory = inv,
        visible = visible,
    }
end

function ZG.QUIT()
    if _embedded then error({ _zil_quit = true }) end
    os.exit(0)
end
-- ゲームを最初からやり直す。組み込みモード (MCP サーバー) では、組み込んだ側が開始時の
-- 状態へ戻す。通常の起動では、_link が保存した開始時の状態へ戻して GO をやり直す
-- (ZilRuntime.py はプロセスを再起動する。どちらも同じ標準入力から読み続ける)。
_initial_snapshot = nil

function ZG._save_initial_state()
    if not _embedded then _initial_snapshot = ZG._snapshot_state() end
end

function ZG.RESTART()
    io.flush()
    if _embedded then error({ _zil_restart = true }) end
    if _initial_snapshot == nil then os.exit(0) end
    ZG._restore_snapshot(_initial_snapshot)
    _upper_window = false
    local seed = os.getenv("ZILPY_RNG_SEED")
    if seed and seed ~= "" then _test_rng_seed(seed) end  -- 新しいプロセスと同じ乱数の並び
    ZG.GO()
    os.exit(0)
end
function ZG.USL() return true end
function ZG.VERIFY() return true end
function ZG.DIRIN() return true end
-- 出力するウィンドウを選ぶ。上のウィンドウ (1) への出力は捨てる (ZilRuntime.py と同じ)
function ZG.SCREEN(window)
    _upper_window = (tonumber(window) == 1)
    return true
end
function ZG.CLEAR() return true end
function ZG.SPLIT() return true end
function ZG.CURSET() return true end
function ZG.HLIGHT() return true end
function ZG.BUFOUT() return true end
function ZG.ERASE() return true end
function ZG.BLOAT() return true end
function ZG.GC() return true end
