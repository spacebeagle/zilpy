-- zilrt/io.lua: 入出力 (TELL・PRINT・READ)。
-- refactor-plan.md Phase 5 で ZilRuntime.lua から分けた。入口の ZilRuntime.lua が、すべての
-- モジュールに共通の環境 (表) の中で読み込む。最上位の変数・関数は、その環境に置かれ、
-- ほかのモジュールからそのまま参照できる (元のファイルでは最上位の local だったもの)。

-- ----------------------------------------------------------------------
-- 入出力 (TELL / PRINT / READ)
-- ----------------------------------------------------------------------
_capture_tbl = nil
_capture_chars = {}
_io_output = nil
_io_input = nil
_embedded = false

function ZG._set_io(output_fn, input_fn, embedded)
    _io_output = output_fn
    _io_input = input_fn
    _embedded = embedded == true
end

-- 上のウィンドウ (ステータス表示) を選んでいる間の出力は捨てる (ZilRuntime.py と同じ)
_upper_window = false

function out_write(s)
    local text = tostring(s)
    if _capture_tbl ~= nil then
        _capture_chars[#_capture_chars + 1] = text
        return
    end
    if _upper_window then return end
    if _io_output then
        _io_output(text)
    else
        io.write(text)
    end
end

function ZG.CRLF()
    out_write("\n")
    return true
end

function ZG.PRINTI(s)
    out_write(s)
    return true
end

-- オブジェクトの表示名 (DESC、なければオブジェクト名)。ZilRuntime.py の _describe と同じ
function describe(obj)
    if is_object(obj) then
        if obj.desc ~= nil and obj.desc ~= "" then return obj.desc end
        return obj.name or ""
    end
    return tostring(obj)
end

function ZG.PRINT(s)
    if type(s) == "string" or type(s) == "number" then out_write(s) end
    return true
end
ZG.PRINC = ZG.PRINT
function ZG.FREQUENT_WORDS_p() return true end

function ZG.PRINTD(obj)
    out_write(describe(obj))
    return true
end

-- 不定冠詞を付けて名前を出力する (ZilRuntime.py の PRINTA と同じ)
function ZG.PRINTA(obj)
    local desc = describe(obj)
    local article = desc:sub(1, 1):match("[aeiouAEIOU]") and "an" or "a"
    out_write(article .. " " .. desc)
    return true
end

function ZG.PRINTN(n)
    out_write(tostring(n))
    return true
end

function ZG.PRINTC(c)
    out_write(string.char(tonumber(c) or 32))
    return true
end

function ZG.PRINTB(w)
    if type(w) == "table" and w._is_word then
        out_write(w.text)
    else
        out_write(tostring(w))
    end
    return true
end

function ZG.PRINTT(tbl, width, height)
    if not is_table(tbl) then return true end
    local w = tonumber(width) or 0
    local h = tonumber(height) or 1
    local pos = 0
    for row = 1, h do
        local line = {}
        for col = 1, w do
            local ch = ZG.GETB(tbl, pos)
            pos = pos + 1
            if type(ch) == "number" and ch >= 32 and ch < 127 then
                line[#line + 1] = string.char(ch)
            end
        end
        out_write(table.concat(line) .. "\n")
    end
    return true
end

function ZG._TELL_FN(fn, takes_arg)
    return { _is_tell_fn = true, fn = fn, takes_arg = takes_arg }
end

-- TELL の書式指定子 (CR、D、A、N、C など)。ゲームの文字列 (<TELL "A"> など) と
-- 区別するため、文字列ではなく専用のテーブルで渡す (ZilRuntime.py の TellToken と同じ)。
-- 生成コードは ZG._TK.D のように参照する。
ZG._TK = {}
for _, entry in ipairs({
    { "CR", { "CR", "CRLF" } },
    { "D", { "D", "DESC", "O", "OBJ" } },
    { "A", { "A", "AN" } },
    { "N", { "N", "NUM" } },
    { "C", { "C", "CHR", "CHAR" } },
}) do
    local token = { _tell_token = entry[1] }
    for _, alias in ipairs(entry[2]) do ZG._TK[alias] = token end
end

function ZG.TELL(...)
    local args = {...}
    local n = select("#", ...)
    local i = 1
    while i <= n do
        local a = args[i]
        local token = type(a) == "table" and a._tell_token or nil
        if token == "CR" then
            ZG.CRLF()
        elseif token == "D" then
            i = i + 1; ZG.PRINTD(args[i])
        elseif token == "A" then
            i = i + 1; ZG.PRINTA(args[i])
        elseif token == "N" then
            i = i + 1; ZG.PRINTN(args[i])
        elseif token == "C" then
            i = i + 1; ZG.PRINTC(args[i])
        elseif type(a) == "table" and a._is_tell_fn then
            if a.takes_arg then
                i = i + 1; a.fn(args[i])
            else
                a.fn()
            end
        elseif type(a) == "function" then
            a()  -- ルーチンはその位置で呼ぶ (出力の順序を保つ。ZilRuntime.py の TELL と同じ)
        else
            out_write(tostring(a))
        end
        i = i + 1
    end
    return true
end

function ZG.READ(inbuf, lexv)
    local inbuf_key, lexv_key = nil, nil
    for k, v in pairs(ZG) do
        if v == inbuf then inbuf_key = k end
        if v == lexv then lexv_key = k end
    end
    io.flush()
    local line = _io_input and _io_input() or io.read("*l")
    if line == nil then ZG.QUIT() end
    if inbuf_key and is_table(rawget(ZG, inbuf_key)) then inbuf = rawget(ZG, inbuf_key) end
    if lexv_key and is_table(rawget(ZG, lexv_key)) then lexv = rawget(ZG, lexv_key) end
    line = line:lower()
    local max_chars = ZG.GETB(inbuf, 0)
    if max_chars == 0 then max_chars = #line end
    local text = line:sub(1, max_chars)
    for pos = 1, #text do
        ZG.PUTB(inbuf, pos, text:byte(pos))
    end
    ZG.PUTB(inbuf, #text + 1, 0)

    local tokens = {}
    local idx = 1
    local len = #text
    while idx <= len do
        local c = text:sub(idx, idx)
        if c:match("%s") then
            idx = idx + 1
        elseif c:match("[.,\"]") then
            -- 1 つの単語として切り出す区切り文字 (ZilRuntime.py の WORD_SEPARATORS と同じ)
            tokens[#tokens + 1] = { c, idx - 1 }
            idx = idx + 1
        else
            local s = idx
            while idx <= len and not text:sub(idx, idx):match("[%s.,\"]") do
                idx = idx + 1
            end
            tokens[#tokens + 1] = { text:sub(s, idx - 1), s - 1 }
        end
    end

    local max_words = ZG.GETB(lexv, 0)
    if max_words == 0 then max_words = 15 end
    if #tokens > max_words then
        while #tokens > max_words do table.remove(tokens) end
    end
    ZG.PUTB(lexv, 1, #tokens)
    for t_i, tok in ipairs(tokens) do
        local word, start_pos = tok[1], tok[2]
        local pos = 2 + (t_i - 1) * 4
        _finalize_vocabulary()
        local w = _vocab[_norm_key(word)]
        local entry = (w and next(w.parts) ~= nil) and w or 0
        ZG.PUTB(lexv, pos, entry)
        ZG.PUTB(lexv, pos + 1, false)
        ZG.PUTB(lexv, pos + 2, #word)
        ZG.PUTB(lexv, pos + 3, start_pos + 1)
    end
    return true
end
