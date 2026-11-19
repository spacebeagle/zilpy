-- zilrt/instructions.lua: 乱数・システム制御 (QUIT・RESTART など) と、ほかに分類しない命令。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- 乱数・システム制御・ステップ 2 用スタブ
-- ----------------------------------------------------------------------
-- 乱数生成器 (Park–Miller 法)。通常時もスナップショットで状態を保存・復元できるよう
-- Lua 標準の math.random ではなく純 Lua 状態で保持する。
-- ZilRuntime.py の _TestRandom と、同じ種から同じ値の並びを返す
-- (積は 2^46 未満なので、Lua 5.1 の倍精度でも正確に計算できる)。
_TEST_RNG_MODULUS = 2147483647
_test_rng_state = 1

function _test_rng_seed(value)
    local state = math.floor(tonumber(value) or 1) % _TEST_RNG_MODULUS
    if state <= 0 then state = 1 end
    _test_rng_state = state
end

do
    local seed = os.getenv("ZILPY_RNG_SEED")
    if seed and seed ~= "" then
        _test_rng_seed(seed)
    else
        math.randomseed(os.time())
        _test_rng_seed(os.time() + math.floor(os.clock() * 1000000) + math.random(1, 1000000))
    end
end

-- 共通マクロ (続き)。ENABLE: <PUT .INT ,C-ENABLED? 1>
function ZG.ENABLE(intr)
    if is_table(intr) then ZG.PUT(intr, ZG.C_ENABLED_p, 1) end
    return true
end

function ZG.FLAMING_p(obj)
    return ZG.FSET_p(obj, "FLAMEBIT") and ZG.FSET_p(obj, "ONBIT")
end

function ZG.OPENABLE_p(obj)
    return ZG.FSET_p(obj, "DOORBIT") or ZG.FSET_p(obj, "CONTBIT")
end

function ZG.BSET(obj, ...)
    for _, f in ipairs({...}) do ZG.FSET(obj, f) end
    return true
end

function ZG.BCLEAR(obj, ...)
    for _, f in ipairs({...}) do ZG.FCLEAR(obj, f) end
    return true
end

function ZG.BSET_p(obj, ...)
    for _, f in ipairs({...}) do
        if ZG.FSET_p(obj, f) then return true end
    end
    return false
end

function ZG.INPUT()
    io.flush()
    local line = _io_input and _io_input() or io.read("*l")
    if line == nil then ZG.QUIT() end
    return (#line > 0) and line:byte(1) or 13
end

function ZG.RANDOM(n)
    n = tonumber(n) or 0
    if n <= 0 then
        -- 負の数は乱数の種を設定する (0 なら決定論的に種をかき混ぜてリプレイ再現性を保つ)。
        if n < 0 then
            _test_rng_seed(-n)
        else
            _test_rng_seed((_test_rng_state * 48271) % _TEST_RNG_MODULUS)
        end
        return 0
    end
    _test_rng_state = (_test_rng_state * 16807) % _TEST_RNG_MODULUS
    return 1 + _test_rng_state % n
end

function ZG.VALUE(x)
    if type(x) == "table" and x._is_global_ref then return ZG[x.name] end
    if type(x) == "string" then return ZG[x] end
    return x
end

_stack = {}
function ZG.PUSH(v) _stack[#_stack + 1] = v; return true end
function ZG.RSTACK() local v = _stack[#_stack]; _stack[#_stack] = nil; return v end

function ZG.ABS(n) return math.abs(tonumber(n) or 0) end
function ZG.ASCII(v)
    if type(v) == "string" then return (#v > 0) and v:byte(1) or 0 end
    if type(v) == "number" then return string.char(v) end
    return 0
end
function ZG.NTH(seq, idx) return seq[idx] end
function ZG.LENGTH(seq) return type(seq) == "table" and #seq or (type(seq) == "string" and #seq or 0) end
function ZG.EMPTY_p(seq) return ZG.LENGTH(seq) == 0 end
function ZG.STRING(...)
    local t = {}
    for i = 1, select("#", ...) do t[i] = tostring(select(i, ...)) end
    return table.concat(t)
end
function ZG.SPNAME(a) return tostring(a) end
function ZG.IVECTOR(count, val)
    local t = {}
    if val == nil then val = false end
    for i = 1, (tonumber(count) or 0) do t[i] = val end
    return t
end
ZG.IUVECTOR = ZG.IVECTOR
function ZG.ZSTR_OFF() return true end
function ZG.ZSTR_ON() return true end

function ZG.ERROR(...) io.stderr:write("ZIL ERROR\n"); return false end
function ZG.GDECL(...) return true end
function ZG.OBJECT(...) return true end
function ZG.SNAME(...) return true end
function ZG.ID(...) return true end
function ZG.SOUND(...) return true end
