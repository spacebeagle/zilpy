-- zilrt/context.lua: ZG と共有の表、ビット演算、基本ヘルパー (真偽値・算術・遅延宣言)、アクションの登録。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ZilRuntime.lua: ZilPy Lua 5.1 互換ランタイム (ステップ 1: 最小動作版)
-- Lua 5.1 / LuaJIT / Lua 5.2 / 5.3 / 5.4 で共通動作するサブセットで実装。

unpack = table.unpack or unpack
load_chunk = loadstring or load

ZG = {}
_pending = {}
_objects = {}
_vocab = {}       -- lower_word -> Word table
_vocab_6 = {}     -- 6-char truncated lower_word -> Word table
_directions = {}
_prop_defaults = {}
_verbs = {}
_actions_map = {}
_preactions_map = {}
_prepositions = {}
_symbols = {}
_next_sym_id = 1
_syntax_entries = {}

-- ----------------------------------------------------------------------
-- ビット演算 (LuaJIT bit -> bit32 -> Lua 5.3+ -> 純 Lua フォールバック)
-- ----------------------------------------------------------------------
_band, _bor, _bnot, _lshift, _rshift = nil, nil, nil, nil, nil

ok_bit, bit_mod = pcall(require, "bit")
if ok_bit and bit_mod then
    _band = bit_mod.band
    _bor = bit_mod.bor
    _bnot = bit_mod.bnot
    _lshift = bit_mod.lshift
    _rshift = bit_mod.rshift
else
    local ok_b32, b32 = pcall(require, "bit32")
    if ok_b32 and b32 then
        _band = b32.band
        _bor = b32.bor
        _bnot = b32.bnot
        _lshift = b32.lshift
        _rshift = b32.rshift
    else
        local fn = load_chunk([[
            return {
                band = function(a, b) return a & b end,
                bor  = function(a, b) return a | b end,
                bnot = function(a) return ~a end,
                lshift = function(a, n) return a << n end,
                rshift = function(a, n) return a >> n end,
            }
        ]])
        if fn then
            local ops = fn()
            _band, _bor, _bnot, _lshift, _rshift = ops.band, ops.bor, ops.bnot, ops.lshift, ops.rshift
        else
            _band = function(a, b)
                local res, bitval = 0, 1
                a, b = math.floor(a) % 65536, math.floor(b) % 65536
                while a > 0 and b > 0 do
                    if a % 2 == 1 and b % 2 == 1 then res = res + bitval end
                    a = math.floor(a / 2)
                    b = math.floor(b / 2)
                    bitval = bitval * 2
                end
                return res
            end
            _bor = function(a, b)
                local res, bitval = 0, 1
                a, b = math.floor(a) % 65536, math.floor(b) % 65536
                while a > 0 or b > 0 do
                    if a % 2 == 1 or b % 2 == 1 then res = res + bitval end
                    a = math.floor(a / 2)
                    b = math.floor(b / 2)
                    bitval = bitval * 2
                end
                return res
            end
            _bnot = function(a) return 65535 - (math.floor(a) % 65536) end
            _lshift = function(a, n) return (math.floor(a) * (2 ^ n)) % 65536 end
            _rshift = function(a, n) return math.floor((math.floor(a) % 65536) / (2 ^ n)) end
        end
    end
end

-- ----------------------------------------------------------------------
-- 基本ヘルパー (真偽値・算術・遅延宣言)
-- ----------------------------------------------------------------------
function ZG._T(v)
    return v ~= false and v ~= nil and v ~= 0
end

function ZG.DIV(a, b)
    if b == 0 then return 0 end
    local q = a / b
    if q >= 0 then return math.floor(q) else return math.ceil(q) end
end

function ZG.MOD(a, b)
    if b == 0 then return 0 end
    return a - ZG.DIV(a, b) * b
end

function ZG.BAND(a, b) return _band(a or 0, b or 0) end
function ZG.BOR(a, b) return _bor(a or 0, b or 0) end
ZG.ANDB = ZG.BAND
ZG.ORB = ZG.BOR
function ZG.BCOM(a) return _bnot(a or 0) end
function ZG.LSH(a, n)
    if n >= 0 then return _lshift(a or 0, n) else return _rshift(a or 0, -n) end
end
ZG.SHIFT = ZG.LSH

function ZG.BTST(a, b)
    return _band(a or 0, b or 0) == (b or 0)
end

function ZG.EQ(a, b)
    if a == b then return true end
    if (a == false or a == 0) and (b == false or b == 0) then return true end
    return false
end

function ZG.ZERO_p(x)
    return x == 0 or x == false
end

function ZG.EQUAL_p(a, ...)
    local n = select("#", ...)
    for i = 1, n do
        if ZG.EQ(a, select(i, ...)) then return true end
    end
    return false
end

function ZG._set(name, val)
    rawset(ZG, name, val)
    return val
end

function ZG.GASSIGNED_p(name)
    return rawget(ZG, tostring(name):upper()) ~= nil or _pending[tostring(name):upper()] ~= nil
end

-- 宣言の順序 (ZilRuntime.py の _pending は dict なので宣言順を保つ。それと同じ順で
-- _link が評価するために記録する) と、OBJECT / ROOM の宣言かどうか
_decl_order = {}
_decl_is_object = {}

-- GLOBAL / CONSTANT / OBJECT の名前を宣言する。値は最初に参照された時に評価する。
-- ランタイムの関数と同じ名前でも、ゲームの宣言を優先する (ZilRuntime.py と同じ)。
-- ランタイムの関数そのものは ZG._rt に残る (物体と同じ名前の命令の呼び出しに使う)。
function ZG._declare(name, fn, is_object)
    if _pending[name] == nil then
        _decl_order[#_decl_order + 1] = name
    end
    rawset(ZG, name, nil)
    _pending[name] = fn
    _decl_is_object[name] = (is_object == true)
end

_pending_props = {}
_finish_object = nil  -- 後で定義する (オブジェクトのプロパティを適用する)
_apply_source_fixes = nil  -- 後で定義する (原作ソースのバグの補正)

-- 未評価の宣言を評価する。オブジェクトは、先に名前を登録してからプロパティを
-- 評価する (プロパティから参照された別のオブジェクトは、その場で初期化される)。
-- ZilRuntime.py の GameContext.__getattr__ と同じ順序になる。
function _resolve(name)
    local fn = _pending[name]
    _pending[name] = nil
    local val = fn()
    if not _decl_is_object[name] and _apply_source_fixes ~= nil then
        val = _apply_source_fixes(name, val)
    end
    rawset(ZG, name, val)
    if type(val) == "table" and val._is_object and _finish_object ~= nil then
        _finish_object(val)
    end
    return val
end

-- 開始ルーチン名 (<ZSTART NAME> で上書きされる。既定は GO)
ZG._entry = "GO"

-- 未評価の宣言をすべて評価する。OBJECT / ROOM を先に、それ以外を後に、それぞれ
-- 宣言順で評価する (ZilRuntime.py の GameContext._link と同じ)。
function ZG._link()
    for pass = 1, 2 do
        local want_object = (pass == 1)
        for _, name in ipairs(_decl_order) do
            if _pending[name] ~= nil and _decl_is_object[name] == want_object then
                if rawget(ZG, name) == nil then
                    _resolve(name)
                end
            end
        end
    end
    for _, obj in ipairs(_objects) do
        _finish_object(obj)
    end
    while #_pending_props > 0 do
        local item = table.remove(_pending_props, 1)
        item.fn(item.obj)
    end
    -- 通常の起動で RESTART したときに戻る、開始時の状態を保存する
    if ZG._save_initial_state ~= nil then ZG._save_initial_state() end
end

setmetatable(ZG, {
    __index = function(t, name)
        if _pending[name] then
            return _resolve(name)
        end
        return nil
    end,
})

-- ----------------------------------------------------------------------
-- アクション登録・呼び出し
-- ----------------------------------------------------------------------
Actions = {}
_fn_to_name = {}
-- ルーチンの生成コードの名前 -> ZIL の名前 (V_VERBOSE -> V-VERBOSE)。エラーの表示などに使う
_zil_names = {}
-- 生成コードは ZG.actions:register("V_VERBOSE", function ... end, "V-VERBOSE") の形で呼ぶ
-- (refactor-plan.md Phase 6。3 つ目の引数の ZIL の名前は省いてもよい)
function Actions:register(name, fn, zil_name)
    self[name] = fn
    _fn_to_name[fn] = name
    if zil_name ~= nil then _zil_names[name] = zil_name end
    return fn
end
function ZG._zil_name(name)
    return _zil_names[name] or name
end
function Actions:get(name)
    return self[name]
end
ZG.actions = Actions

function ZG._call(fn, ...)
    if type(fn) == "function" then
        return fn(...)
    end
    return false
end

function ZG.APPLY(fn, ...)
    return ZG._call(fn, ...)
end
