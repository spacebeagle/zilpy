-- ZilMcp.lua: ZilPy で変換した Lua 5.1 互換 Infocom ゲームを公開する軽量 MCP サーバー
--
-- 使い方:
--   lua ZilMcp.lua out_lua/zork1
--   lua ZilMcp.lua out_lua/amfv --entry s5
--
-- 外部ライブラリ不要の純 Lua 5.1 (LuaJIT / Lua 5.4 互換) で stdio JSON-RPC 2.0 を処理し、
-- ゲーム本体は coroutine 上で動かして READ/INPUT のたびに yield する。

local SERVER_NAME = "zilpy-infocom-lua"
local SERVER_VERSION = "0.1.0"
local DEFAULT_PROTOCOL_VERSION = "2025-06-18"
local MAX_COMMAND_LENGTH = 100
local MAX_UNDO_HISTORY = 20

-- ----------------------------------------------------------------------
-- 最小限の純 Lua JSON エンコーダ / デコーダ
-- ----------------------------------------------------------------------
local json = {}

local function json_escape(s)
    local map = {
        ['\\'] = '\\\\', ['"'] = '\\"', ['\b'] = '\\b',
        ['\f'] = '\\f', ['\n'] = '\\n', ['\r'] = '\\r', ['\t'] = '\\t',
    }
    return '"' .. s:gsub('[%z\1-\31\\"]', function(c)
        return map[c] or string.format('\\u%04x', c:byte())
    end) .. '"'
end

local function is_array(t)
    local n = 0
    for k in pairs(t) do
        if type(k) ~= "number" or k < 1 or math.floor(k) ~= k then return false end
        if k > n then n = k end
    end
    for i = 1, n do
        if t[i] == nil then return false end
    end
    return true, n
end

function json.encode(v)
    local tv = type(v)
    if v == nil then return "null"
    elseif tv == "boolean" then return v and "true" or "false"
    elseif tv == "number" then return tostring(v)
    elseif tv == "string" then return json_escape(v)
    elseif tv == "table" then
        if v._is_json_empty_array then return "[]" end
        local arr, n = is_array(v)
        if arr and (n > 0 or next(v) == nil and getmetatable(v) and getmetatable(v)._array) then
            local parts = {}
            for i = 1, n do parts[i] = json.encode(v[i]) end
            return "[" .. table.concat(parts, ",") .. "]"
        else
            local parts = {}
            for k, val in pairs(v) do
                parts[#parts + 1] = json_escape(tostring(k)) .. ":" .. json.encode(val)
            end
            return "{" .. table.concat(parts, ",") .. "}"
        end
    end
    return "null"
end

local function empty_array()
    return setmetatable({}, { _array = true })
end

function json.decode(str)
    local pos = 1
    local len = #str
    local function skip_ws()
        while pos <= len and str:sub(pos, pos):match("%s") do pos = pos + 1 end
    end
    local parse_val
    local function parse_str()
        pos = pos + 1
        local out = {}
        while pos <= len do
            local ch = str:sub(pos, pos)
            if ch == '"' then pos = pos + 1; return table.concat(out) end
            if ch == '\\' then
                local nx = str:sub(pos + 1, pos + 1)
                local esc = { ['"'] = '"', ['\\'] = '\\', ['/'] = '/', b = '\b', f = '\f', n = '\n', r = '\r', t = '\t' }
                if esc[nx] then
                    out[#out + 1] = esc[nx]
                    pos = pos + 2
                elseif nx == 'u' then
                    local hex = str:sub(pos + 2, pos + 5)
                    local code = tonumber(hex, 16) or 32
                    out[#out + 1] = code < 128 and string.char(code) or "?"
                    pos = pos + 6
                else
                    out[#out + 1] = nx
                    pos = pos + 2
                end
            else
                out[#out + 1] = ch
                pos = pos + 1
            end
        end
        error("Unterminated JSON string")
    end
    local function parse_arr()
        pos = pos + 1
        local arr = {}
        skip_ws()
        if str:sub(pos, pos) == ']' then pos = pos + 1; return arr end
        while pos <= len do
            arr[#arr + 1] = parse_val()
            skip_ws()
            local ch = str:sub(pos, pos)
            if ch == ']' then pos = pos + 1; return arr end
            if ch ~= ',' then error("Expected ',' or ']' in array") end
            pos = pos + 1
        end
        error("Unterminated JSON array")
    end
    local function parse_obj()
        pos = pos + 1
        local obj = {}
        skip_ws()
        if str:sub(pos, pos) == '}' then pos = pos + 1; return obj end
        while pos <= len do
            skip_ws()
            if str:sub(pos, pos) ~= '"' then error("Expected string key") end
            local k = parse_str()
            skip_ws()
            if str:sub(pos, pos) ~= ':' then error("Expected ':'") end
            pos = pos + 1
            obj[k] = parse_val()
            skip_ws()
            local ch = str:sub(pos, pos)
            if ch == '}' then pos = pos + 1; return obj end
            if ch ~= ',' then error("Expected ',' or '}' in object") end
            pos = pos + 1
        end
        error("Unterminated JSON object")
    end
    parse_val = function()
        skip_ws()
        local ch = str:sub(pos, pos)
        if ch == '"' then return parse_str()
        elseif ch == '{' then return parse_obj()
        elseif ch == '[' then return parse_arr()
        elseif str:sub(pos, pos + 3) == "true" then pos = pos + 4; return true
        elseif str:sub(pos, pos + 4) == "false" then pos = pos + 5; return false
        elseif str:sub(pos, pos + 3) == "null" then pos = pos + 4; return nil
        else
            local num = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
            if not num then error("Invalid JSON at " .. pos) end
            pos = pos + #num
            return tonumber(num)
        end
    end
    local res = parse_val()
    return res
end

-- ----------------------------------------------------------------------
-- 引数解析とゲームディレクトリ設定
-- ----------------------------------------------------------------------
local game_dir = nil
local entry = nil
local i = 1
while i <= #arg do
    if arg[i] == "--entry" and arg[i + 1] then
        entry = arg[i + 1]
        i = i + 2
    elseif not game_dir then
        game_dir = arg[i]
        i = i + 1
    else
        i = i + 1
    end
end

if not game_dir then
    io.stderr:write("Usage: lua ZilMcp.lua <game_dir> [--entry <name>]\n")
    os.exit(1)
end

game_dir = game_dir:gsub("[/\\]+$", "")
if not entry then
    entry = game_dir:match("([^/\\]+)$")
end

package.path = game_dir .. "/?.lua;" .. package.path

-- ----------------------------------------------------------------------
-- ゲームセッション管理 (coroutine ベース)
-- ----------------------------------------------------------------------
local ZG = require("ZilRuntime")

local Session = {
    started = false,
    running = false,
    end_reason = nil,
    co = nil,
    output = {},
    init_snap = nil,
    history = {},
    slots = {},
    undo_stack = {},
}

local function take_output()
    local s = table.concat(Session.output)
    Session.output = {}
    return s
end

ZG._set_io(
    function(text) Session.output[#Session.output + 1] = text end,
    function() return coroutine.yield() end,
    true
)

-- 実行時エラーの traceback の、ゲームのモジュールの行を、元の ZIL のルーチンと位置にする
-- (refactor-plan.md Phase 6)。ゲームのルーチンは無名の関数として登録されているので、
-- その行より上で最も近い `-- zil: ファイル:行  <ROUTINE ...>` の注記を探す。
local _file_lines = {}
local function zil_location(file, line)
    local lines = _file_lines[file]
    if lines == nil then
        lines = {}
        local f = io.open(game_dir .. "/" .. file, "r")
        if f then
            for l in f:lines() do lines[#lines + 1] = l end
            f:close()
        end
        _file_lines[file] = lines
    end
    for i = math.min(line, #lines), 1, -1 do
        local note = lines[i]:match("^%s*%-%- zil: (.+)$")
        if note then return note end
    end
    return nil
end

local function zil_stack(trace)
    local out = {}
    local last = nil
    for file, line in trace:gmatch("([%w_%-%.]+%.lua):(%d+):") do
        -- エラーの文と traceback の 1 行目は同じ行を指すので、続けて同じ行なら 1 回にする
        -- (Lua の末尾呼び出しは、呼び出し元のフレームを残さないので、その行は出ない)
        local key = file .. ":" .. line
        if key ~= last and file ~= "ZilRuntime.lua" and not file:match("^ZilMcp") then
            last = key
            local note = zil_location(file, tonumber(line))
            if note then out[#out + 1] = "  " .. note .. "  [" .. file .. " line " .. line .. "]" end
        end
    end
    if #out == 0 then return "" end
    return "\nZIL call stack (most recent call first):\n" .. table.concat(out, "\n") .. "\n"
end

local function run_step(input_line)
    local ok, err = coroutine.resume(Session.co, input_line)
    if not ok then
        if type(err) == "table" and err._zil_quit then
            Session.running = false
            Session.end_reason = "The game has ended (quit)."
        elseif type(err) == "table" and err._zil_restart then
            Session.running = false
            Session.end_reason = "restart"
        else
            local trace = debug.traceback(Session.co, tostring(err))
            Session.output[#Session.output + 1] = "\n[ZilPy Lua runtime error]\n" .. trace .. zil_stack(trace)
            Session.running = false
            Session.end_reason = "The game stopped because of a runtime error."
        end
    elseif coroutine.status(Session.co) == "dead" then
        Session.running = false
        Session.end_reason = "The game has ended."
    end
end

local function start_coroutine()
    Session.running = true
    Session.end_reason = nil
    Session.co = coroutine.create(function()
        ZG._link()
        ZG[ZG._entry or "GO"]()
    end)
    run_step(nil)
end

function Session.ensure_started()
    if Session.started then return end
    Session.started = true
    -- モジュールを読み込む (末尾の ZG._link(); ZG.GO() 実行前に通常はロードのみしたいので
    -- entry ファイルから末尾の GO() 呼び出しを除いたチャンクを実行するか、require する)
    local path = game_dir .. "/" .. entry .. ".lua"
    local f = assert(io.open(path, "r"))
    local src = f:read("*a")
    f:close()
    -- 末尾のランチャー `ZG._link()\nZG.<entry>()` を取り除いて定義だけロードする
    src = src:gsub("\nZG%._link%(%)\nZG%.[%w_]+%(%)%s*$", "\n")
    local chunk, err = (loadstring or load)(src, "@" .. path)
    if not chunk then error(err) end
    chunk()
    ZG._link()
    Session.init_snap = ZG._snapshot_state()
    start_coroutine()
end

function Session.send_command(cmd)
    Session.ensure_started()
    if not Session.running then
        local t = take_output()
        return t ~= "" and t or ("[" .. (Session.end_reason or "Game ended") .. " Use restart_game to play again.]")
    end
    local line = cmd:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", ""):sub(1, MAX_COMMAND_LENGTH)
    local snap = ZG._snapshot_state()
    Session.undo_stack[#Session.undo_stack + 1] = { cmd = line, snap = snap, hist_len = #Session.history }
    if #Session.undo_stack > MAX_UNDO_HISTORY then
        table.remove(Session.undo_stack, 1)
    end
    Session.history[#Session.history + 1] = line
    run_step(line)
    if Session.end_reason == "restart" then
        Session.undo_stack = {}
        Session.history = {}
        ZG._restore_snapshot(Session.init_snap)
        start_coroutine()
    end
    local text = take_output()
    if not Session.running and Session.end_reason then
        text = text .. "\n[" .. Session.end_reason .. " Use restart_game to play again.]"
    end
    return text
end

function Session.restart()
    Session.undo_stack = {}
    Session.history = {}
    if not Session.started then
        Session.ensure_started()
        return take_output()
    end
    take_output()
    ZG._restore_snapshot(Session.init_snap)
    start_coroutine()
    return take_output()
end

function Session.look_state()
    Session.ensure_started()
    local st = ZG._look_state()
    st.game = entry
    return st
end

local function restore_with_history(snap, history)
    take_output()
    ZG._restore_snapshot(Session.init_snap)
    start_coroutine()
    for _, cmd in ipairs(history) do
        if not Session.running then break end
        run_step(cmd)
    end
    ZG._restore_snapshot(snap)
    Session.history = {}
    for i, c in ipairs(history) do Session.history[i] = c end
    take_output()
end

function Session.save_state(slot)
    Session.ensure_started()
    if not Session.running then
        error("Cannot save state: " .. (Session.end_reason or "game is not running"))
    end
    local sname = (slot and slot ~= "") and slot or "default"
    local hcopy = {}
    for i, c in ipairs(Session.history) do hcopy[i] = c end
    Session.slots[sname] = { snap = ZG._snapshot_state(), history = hcopy }
    local names = {}
    for k in pairs(Session.slots) do names[#names + 1] = k end
    table.sort(names)
    return { saved = true, slot = sname, slots = names, location = Session.look_state().location }
end

function Session.restore_state(slot)
    Session.ensure_started()
    local sname = (slot and slot ~= "") and slot or "default"
    local ent = Session.slots[sname]
    if not ent then error("No saved state in slot '" .. sname .. "'") end
    restore_with_history(ent.snap, ent.history)
    return { restored = true, slot = sname, state = Session.look_state() }
end

function Session.undo(steps)
    Session.ensure_started()
    local n = steps or 1
    if n < 1 or #Session.undo_stack < n then
        error("Cannot undo " .. tostring(n) .. " step(s)")
    end
    local undone = {}
    local target = nil
    for _ = 1, n do
        target = table.remove(Session.undo_stack)
        undone[#undone + 1] = target.cmd
    end
    local hcopy = {}
    for i = 1, target.hist_len do hcopy[i] = Session.history[i] end
    restore_with_history(target.snap, hcopy)
    return { undone = undone, remaining_undo = #Session.undo_stack, state = Session.look_state() }
end

function Session.list_states()
    local names = {}
    for k in pairs(Session.slots) do names[#names + 1] = k end
    table.sort(names)
    local hist = empty_array()
    for _, u in ipairs(Session.undo_stack) do hist[#hist + 1] = u.cmd end
    return { slots = names, undo_history = hist }
end

-- ----------------------------------------------------------------------
-- MCP JSON-RPC 2.0 サーバー
-- ----------------------------------------------------------------------
local TOOLS = {
    {
        name = "send_command",
        description = "Send one English command to the Infocom game.",
        inputSchema = {
            type = "object",
            properties = { command = { type = "string" } },
            required = { "command" },
        },
    },
    { name = "look_state", description = "Return perceptible game state as JSON.", inputSchema = { type = "object", properties = {} } },
    { name = "restart_game", description = "Restart the game from the beginning.", inputSchema = { type = "object", properties = {} } },
    { name = "save_state", description = "Save game state into an in-memory slot.", inputSchema = { type = "object", properties = { slot = { type = "string" } } } },
    { name = "restore_state", description = "Restore game state from an in-memory slot.", inputSchema = { type = "object", properties = { slot = { type = "string" } } } },
    { name = "undo", description = "Undo recent send_command calls.", inputSchema = { type = "object", properties = { steps = { type = "integer" } } } },
    { name = "list_states", description = "List saved slots and undo history.", inputSchema = { type = "object", properties = {} } },
}

local function write_msg(tbl)
    io.write(json.encode(tbl) .. "\n")
    io.flush()
end

local function send_result(id, res)
    if id ~= nil then write_msg({ jsonrpc = "2.0", id = id, result = res }) end
end

local function send_error(id, code, msg)
    write_msg({ jsonrpc = "2.0", id = id, error = { code = code, message = msg } })
end

for line in io.lines() do
    local trimmed = line:match("^%s*(.-)%s*$")
    if trimmed ~= "" then
        local ok_dec, msg = pcall(json.decode, trimmed)
        if not ok_dec or type(msg) ~= "table" then
            send_error(nil, -32700, "Parse error")
        else
            local id = msg.id
            local method = msg.method
            local params = msg.params or {}
            if method == "initialize" then
                send_result(id, {
                    protocolVersion = params.protocolVersion or DEFAULT_PROTOCOL_VERSION,
                    capabilities = { tools = {} },
                    serverInfo = { name = SERVER_NAME, version = SERVER_VERSION },
                })
            elseif method == "notifications/initialized" then
                -- no-op
            elseif method == "ping" then
                send_result(id, {})
            elseif method == "tools/list" then
                send_result(id, { tools = TOOLS })
            elseif method == "tools/call" then
                local tname = params.name
                local targs = params.arguments or {}
                local ok_call, res_text = pcall(function()
                    if tname == "send_command" then
                        return Session.send_command(tostring(targs.command or ""))
                    elseif tname == "look_state" then
                        return json.encode(Session.look_state())
                    elseif tname == "restart_game" then
                        return Session.restart()
                    elseif tname == "save_state" then
                        return json.encode(Session.save_state(targs.slot))
                    elseif tname == "restore_state" then
                        return json.encode(Session.restore_state(targs.slot))
                    elseif tname == "undo" then
                        return json.encode(Session.undo(targs.steps))
                    elseif tname == "list_states" then
                        return json.encode(Session.list_states())
                    else
                        error("Unknown tool: " .. tostring(tname))
                    end
                end)
                if ok_call then
                    send_result(id, { content = { { type = "text", text = res_text } }, isError = false })
                else
                    send_result(id, { content = { { type = "text", text = "Error: " .. tostring(res_text) } }, isError = true })
                end
            else
                send_error(id, -32601, "Method not found: " .. tostring(method))
            end
        end
    end
end
