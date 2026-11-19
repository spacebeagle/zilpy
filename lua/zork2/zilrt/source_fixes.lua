-- zilrt/source_fixes.lua: 原作ソースのバグの補正 (ZilRuntime.py の zilrt/source_fixes.py と同じもの)、出口の定数。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- 原作ソースのバグの補正 (ZilRuntime.py の _SOURCE_FIXES と同じもの)
-- ----------------------------------------------------------------------
-- 補正は GLOBAL の名前ごとに登録し、ゲームと元の値が完全に一致した時だけ適用する。
-- 適用した時は標準エラー出力に知らせる。

-- Zork III の YUKS の元の中身 (3actions.zil)
_ZORK3_YUKS_MESSAGES = {
    "A valiant attempt.",
    "You can't be serious.",
    "An interesting idea...",
    "What a concept!",
}

-- Zork III の YUKS に、PICK-ONE が使う「使用済みの数」のワードを足す
-- (詳しくは ZilRuntime.py の _fix_zork3_yuks を参照)
function _fix_zork3_yuks(value)
    if ZG.ZORK_NUMBER ~= 3 or not is_table(value) then return nil end
    local count = #_ZORK3_YUKS_MESSAGES
    if #value.cells - value.offset ~= (count + 1) * 2 or ZG.GET(value, 0) ~= count then
        return nil
    end
    for i = 1, count do
        if ZG.GET(value, i) ~= _ZORK3_YUKS_MESSAGES[i] then return nil end
    end
    return ZG.LTABLE(0, unpack(_ZORK3_YUKS_MESSAGES))
end

_SOURCE_FIXES = {
    YUKS = { { "zork3-yuks-pick-one", _fix_zork3_yuks } },
}
_applied_source_fixes = {}

_apply_source_fixes = function(name, value)
    local fixes = _SOURCE_FIXES[name]
    if fixes == nil then return value end
    for _, entry in ipairs(fixes) do
        local fix_name, fix = entry[1], entry[2]
        local fixed = fix(value)
        if fixed ~= nil then
            if not _applied_source_fixes[fix_name] then
                _applied_source_fixes[fix_name] = true
                io.stderr:write("ZilPy: applied source fix " .. fix_name .. " to " .. name .. "\n")
            end
            return fixed
        end
    end
    return value
end


ZG._declare("UEXIT", function() return 1 end)
ZG._declare("NEXIT", function() return 2 end)
ZG._declare("FEXIT", function() return 3 end)
ZG._declare("CEXIT", function() return 4 end)
ZG._declare("DEXIT", function() return 5 end)
ZG._declare("REXIT", function() return 0 end)
ZG._declare("NEXITSTR", function() return 0 end)
ZG._declare("FEXITFCN", function() return 0 end)
ZG._declare("CEXITFLAG", function() return 1 end)
ZG._declare("CEXITSTR", function() return 1 end)
ZG._declare("DEXITOBJ", function() return 1 end)
ZG._declare("DEXITSTR", function() return 1 end)
