--# Input must be greater than 5. || this number obfuscation are unstable.
--# Input harus lebih dari 5 || number obfuscation ini tidak stabil

-- <{ Credit: @YouKnowAsura || Telegram }> --

--[[
    Example Usage || Contoh Pemakaian:
    
    local res = createBitwise(18)
    print(res) : stdout => {
        ((((14& ~(#"\3\1\2\2\1\6")))+((14-(#"\1\6\0\9"))))) -- Exmple Output || Contoh Hasil
    }
]]

BitLib = {
    { "+", "-" },
    { ">>", "<<" },
    { "|", "& ~" },
    { "*", "/" },
    { "-", "+" },
    { "~", "~" },
    {
        { "+", "-" },
        { "-", "+" },
        { "~", "~" }
    }
}

SLib = { "0", "1", "2", "3", "4", "5", "6", "9" }
HexLib = {}

createHex = function(len)
    local THex = ""
    for X = 1, len do
        THex = THex .. "\\" .. SLib[math.random(1, #SLib)]
    end
    HexLib[#HexLib + 1] = "#" .. "\"" .. THex .. "\""
    return "Hex[" .. #HexLib .. "]"
end

GenBitwise = function(bitNum)
    assert(bitNum > 5, "Input must be greater than five!")

    local bitFixer = { math.random(1, 6), math.random(1, 6), math.random(1, 3) }
    local Operation = {
        BitLib[bitFixer[1]],
        BitLib[bitFixer[2]],
        BitLib[7][bitFixer[3]]
    }

    local randBits = { math.floor(bitNum / 2 + 1) }
    local Bits = {
        load("return " .. bitNum .. Operation[3][1] .. randBits[1])(),
        randBits[1]
    }

    local result
    repeat
        randBits[2] = math.random(2, 6)
        randBits[3] = math.random(2, 6)
        result = {
            load("return " .. Bits[1] .. Operation[1][1] .. randBits[2])(),
            load("return " .. Bits[2] .. Operation[2][1] .. randBits[3])()
        }
    until result[1] > 0 and result[2] > 0

    local bitResult = "((" .. Bits[1] .. ")" .. Operation[3][2] .. "(" .. Bits[2] .. "))"
    bitResult = bitResult:gsub(Bits[1], "(" .. result[1] .. "" .. Operation[1][2] .. "" .. randBits[2] .. ")")
    bitResult = bitResult:gsub(Bits[2], "(" .. result[2] .. "" .. Operation[2][2] .. "" .. randBits[3] .. ")")

    local bitCheck = bitNum - load(" return " .. bitResult)()
    if bitCheck ~= 0 then
        bitResult = "(" .. bitResult .. " )+( " .. tostring(bitCheck) .. " )"
    end

    bitResult = bitResult:gsub("%d+", function(n)
        n = tonumber(n)
        if n <= 9 then
            return "(" .. createHex(n) .. ")"
        end
    end)

    return "(" .. bitResult .. ")"
end

createBitwise = function(bitN)
    local bitR = GenBitwise(bitN)
    for x = 1, math.random(4, 5) do
        bitR = bitR:gsub("(%d+) ", function(v)
            return GenBitwise(tonumber(v))
        end)
    end
    bitR = bitR:gsub("Hex%[(%d+)%]", function(v)
        return HexLib[tonumber(v)]
    end)

    local bitCheck = bitN - load(" return " .. bitR)()
    if bitCheck ~= 0 then
        bitR = "(" .. bitR .. ")+(" .. tostring(bitCheck) .. ")"
    end

    HexLib = {}

    return bitR
end