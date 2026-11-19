-- ZilRuntime.lua: ZilPy の Lua 版のランタイムの入口 (Lua 5.1 / LuaJIT / 5.2 / 5.3 / 5.4)。
--
-- 生成コードは require("ZilRuntime") で ZG を受け取る。中身は、同じ出力先の zilrt/ に
-- 分けてある (refactor-plan.md Phase 5)。各モジュールは、共通の環境 (表) の中で順に読み込む。
-- モジュールの最上位の変数・関数はその環境に置かれ、ほかのモジュールからも見える
-- (環境にない名前は、ふつうのグローバル (math・io など) を見る)。

local MODULES = {
    "context",
    "tables",
    "objects",
    "vocab",
    "builtin_macros",
    "io",
    "instructions",
    "saves",
    "source_fixes",
}

-- package.path の各場所で zilrt/<名前>.lua を探す (require と同じ場所を探す)
local function find_module(name)
    for template in package.path:gmatch("[^;]+") do
        local path = template:gsub("%?", "zilrt/" .. name)
        local f = io.open(path, "r")
        if f then
            f:close()
            return path
        end
    end
    error("ZilRuntime: zilrt/" .. name .. ".lua not found in package.path")
end

local env = setmetatable({}, { __index = _G })
for _, name in ipairs(MODULES) do
    local path = find_module(name)
    local chunk
    if setfenv then  -- Lua 5.1 / LuaJIT
        chunk = assert(loadfile(path))
        setfenv(chunk, env)
    else
        chunk = assert(loadfile(path, "t", env))
    end
    chunk()
end

local ZG = env.ZG

-- ランタイムの関数の控え。ゲームが同じ名前の OBJECT などを宣言すると ZG.X は
-- ゲームの値になるので、物体と同じ名前のフォーム (例: Trinity の <SOUND 1>) は
-- 変換器が ZG._rt.X(...) としてこちらを呼ぶ (ZilRuntime.py と同じく、ランタイムの命令)
ZG._rt = {}
for k, v in pairs(ZG) do
    if type(v) == "function" then ZG._rt[k] = v end
end

return ZG
