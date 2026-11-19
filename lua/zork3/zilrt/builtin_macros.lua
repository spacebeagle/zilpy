-- zilrt/builtin_macros.lua: 共通マクロ (refactor-plan.md §1.8・§2.3。ZilRuntime.py の zilrt/builtin_macros.py と同じもの)。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- 共通マクロ (refactor-plan.md §1.8・§2.3。ZilRuntime.py の同じ節を参照)
-- ----------------------------------------------------------------------
-- 14 作品のどこでも同じ意味に定義されている DEFMAC だけを持つ: VERB?・PRSO?・PRSI?・
-- ROOM?・BSET・BCLEAR・BSET?・OPENABLE?・FLAMING?・ABS・ENABLE (RFATAL は変換器が
-- `do return 2 end` にする)。変換器が作品ごとに定義を比べて、同じときだけ呼ぶ。
-- 作品ごとに意味の違うマクロ (PROB・DISABLE など) と 1 作品だけのマクロは置かない。

-- VERB?: <MULTIFROB PRSA .ATMS>。名前の文字列は V?名前 の値にし、それ以外は値のまま比べる
function ZG.VERB_p(...)
    local prsa = ZG.PRSA
    for _, v in ipairs({...}) do
        local want = v
        if type(v) == "string" then want = ZG.SYMBOL("V?" .. v) end
        if prsa == want then return true end
    end
    return false
end

function ZG.PRSO_p(...)
    local prso = ZG.PRSO
    for _, o in ipairs({...}) do
        if prso == o then return true end
    end
    return false
end

function ZG.PRSI_p(...)
    local prsi = ZG.PRSI
    for _, o in ipairs({...}) do
        if prsi == o then return true end
    end
    return false
end


function ZG.ROOM_p(...)
    local here = ZG.HERE
    for _, r in ipairs({...}) do
        if here == r then return true end
    end
    return false
end
function ZG.INSERT_FILE(...) return true end
-- PSEUDO が作る THINGS の表の形 (ZilRuntime.py の Dictionary.pseudo_triples と同じ)。
-- ゲームが <DEFINE PSEUDO> を持てば (名詞, 形容詞, ルーチン) の 3 つ組 (Spellbreaker)、
-- なければ (形容詞, 名詞) の組 (Lurking Horror のパーサーが読む形)
_pseudo_triples = false
function ZG._use_pseudo_triples() _pseudo_triples = true end

function ZG.PSEUDO(...)
    local two_word = not _pseudo_triples
    local cells = {}
    for _, entry in ipairs({...}) do
        if type(entry) == "table" and not is_table(entry) then
            local adj, noun, routine = entry[1], entry[2], entry[3]
            local nw = _word(tostring(noun))
            if nw.parts[PS_OBJECT] == nil then nw.parts[PS_OBJECT] = 0 end
            local aw = 0
            if adj and adj ~= false and adj ~= 0 and adj ~= "" and (type(adj) ~= "table" or next(adj) ~= nil) then
                aw = _word(tostring(adj))
                aw.parts[PS_ADJECTIVE] = _adjective_id(tostring(adj))
            end
            if two_word then
                cells[#cells + 1] = aw
                cells[#cells + 1] = nw
            else
                if type(routine) == "string" then
                    routine = ZG[to_ident(routine)] or 0
                end
                cells[#cells + 1] = nw
                cells[#cells + 1] = aw
                cells[#cells + 1] = routine
            end
        end
    end
    _vocab_ready = false
    return build_table(cells, false, true)
end

function ZG.INTBL_p(val, tbl, count, form)
    if not is_table(tbl) then return false end
    local is_byte = (form and _band(form, 128) == 0)
    local step = (form and _band(form, 127)) or (is_byte and 1 or 2)
    for i = 0, (count or 0) - 1 do
        local cur = ZG.REST(tbl, i * step)
        local item = is_byte and ZG.GETB(cur, 0) or ZG.GET(cur, 0)
        if item == val then return cur end
    end
    return false
end
