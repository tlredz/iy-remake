
local passed, failed = 0, 0
local function check(name, cond)
	if cond then passed += 1; print("PASS  " .. name)
	else failed += 1; print("FAIL  " .. name) end
end

-- Color3 with ToHex, the only part of the Roblox type the files need
Color3 = { fromRGB = function(r, g, b)
	local color = { R = r, G = g, B = b }
	function color:ToHex() return string.format("%02x%02x%02x", self.R, self.G, self.B) end
	return color
end }
Enum = setmetatable({}, { __index = function() return {} end })

local COLORS = (function()
local identifierColor  = Color3.fromRGB(248, 109, 115)
local stringColor      = Color3.fromRGB(223, 215, 136)
local numberColor      = Color3.fromRGB(156, 121, 223)
local symbolColor      = Color3.fromRGB(225, 37,  105)
local commentColor     = Color3.fromRGB(118, 113, 94)
local othersColor      = Color3.fromRGB(97,  181, 195)
local warnColor        = Color3.fromRGB(254, 193, 7)
local errorColor       = Color3.fromRGB(244, 66,  54)
local validColor       = Color3.fromRGB(166, 227, 45)
local tagColor         = Color3.fromRGB(255, 149, 75)

return {
	args = {
		["number"] = numberColor,
		["boolean"] = numberColor,
		["text"] = stringColor,
		["string"] = stringColor,
		["symbol"] = symbolColor,
		["comment"] = commentColor,
		["others"] = othersColor,
		["warn"] = warnColor,
		["error"] = errorColor,
		["valid"] = validColor,
		["tag"] = tagColor
	},
	commands = {
		["undefined"] = errorColor,
		["client"] = stringColor,
		["deprecated"] = commentColor
	}
}
end)()
local TOOLS = (function()
local tools = {}

local readableChars = "abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUV_0123456789"

local RICH_TEXT_ESCAPE = {
    ["&"] = "&amp;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["\""] = "&quot;",
    ["'"] = "&apos;"
}

function tools.randomString(length: number): string
	local buffer = {}
	for _ = 1, length do
		local index = math.random(1, #readableChars)
		table.insert(buffer, readableChars:sub(index, index))
	end
	return table.concat(buffer)
end

function tools.getDeep(tab: table, path: string): table
	for key in path:gmatch("[^%.]+") do
		tab = tab[key]
	end
	return tab
end

function tools.simpleCreate(className: string, properties: { [string]: any }): Instance
	local object = Instance.new(className)
	for property, value in properties do
		object[property] = value
	end
	return object
end

function tools.chararray(text: string): { string }
	local array = {}
	for pos = 1, #text do
		table.insert(array, text:sub(pos, pos))
	end
	return array
end

function tools.lookupify(array: { any }): { [any]: true }
	local tab = {}
	for key = 1, #array do
		local value = array[key]
		tab[value] = true
	end
	return tab
end

function tools.unlookupify(tab: { [any]: any }): { any }
	local array = {}
	for key, _ in tab do
		table.insert(array, key)
	end
	return array
end

function tools.escapeRichText(text)
	local escaped = tostring(text):gsub(".", function(char)
		return RICH_TEXT_ESCAPE[char] or char
	end)
	return escaped
end

function tools.charset(text)
	local set = {}
	for char in text:gmatch(".") do
		set[char] = true
	end
	return set
end

function tools.versionToNumber(version: string): number
	local cleanVersion = version:gsub("^v", "")
	
	local versionNumber = 0
	local parts = cleanVersion:split(".")
	
	for index, part in parts do
		local numericPart = tonumber(part) or 0
		versionNumber += numericPart * math.pow(1000, 3 - index)
	end
	
	return versionNumber
end

function tools.colorFromRGB(text, color3)
	return `<font color="#{color3:ToHex()}">{text}</font>`
end

function tools.richFontSize(text, size)
	return `<font size="{size}">{text}</font>`
end

return tools
end)()
local function require(path)
	if path:find("colors") then return COLORS end
	if path:find("tools") then return TOOLS end
	error("unmapped require " .. path)
end
local highlight = (function()
-- src/utils/textHighlight.luau
-- Colors the tokens of a text for the windows and notifications, using rich text:
--   numbers (only digits, like 42 or 3.5)        -> number color
--   words with letters or digits (10px, player1)  -> left as they are
--   "@name" or "#name" at the start of a token    -> tag color, in bold
--   other symbols (: ( ) [ ] { } ...)             -> symbol color

local argColors = require("../framework/config/colors").args
local tools = require("./tools")

local highlight = {}

-- '@' and '#' are symbols too, so a lone one (like "a@b") keeps the symbol color
local symbolChars = tools.charset(":#()[]<>{}-––&*$%@")

-- a word is letters, digits, '_' and '.'
local WORD_PATTERN = "^[%w_%.]+"

-- what a tag holds after its '@' or '#'
local TAG_PATTERN = "^[%w_]+"

local function isWordChar(char: string): boolean
	return char ~= "" and string.match(char, "[%w_%.]") ~= nil
end

local function isNumber(word: string): boolean
	return string.match(word, "^%d+$") ~= nil or string.match(word, "^%d+%.%d+$") ~= nil
end

-- Cuts the text into pieces that share a color and boldness. Neighbouring pieces with the same style are joined.
local function split(text: string)
	local pieces = {}

	local function push(piece: string, color, bold: boolean)
		if piece == "" then
			return
		end

		local last = pieces[#pieces]
		if last and last.color == color and last.bold == bold then
			last.text = last.text .. piece
		else
			table.insert(pieces, { text = piece, color = color, bold = bold })
		end
	end

	local position = 1
	local length = #text

	while position <= length do
		local char = string.sub(text, position, position)
		local previous = if position > 1 then string.sub(text, position - 1, position - 1) else ""

		-- a tag starts a token: '@' or '#' with no word character right before it
		if (char == "@" or char == "#") and not isWordChar(previous) then
			local _, tagEnd = string.find(text, TAG_PATTERN, position + 1)
			if tagEnd then
				push(string.sub(text, position, tagEnd), argColors.tag, true)
				position = tagEnd + 1
				continue
			end
		end

		if isWordChar(char) then
			local _, wordEnd = string.find(text, WORD_PATTERN, position)
			local word = string.sub(text, position, wordEnd)
			push(word, if isNumber(word) then argColors.number else nil, false)
			position = wordEnd + 1
		else
			push(char, if symbolChars[char] then argColors.symbol else nil, false)
			position += 1
		end
	end

	return pieces
end

function highlight:apply(value)
	local parts = {}

	for _, piece in split(tostring(value)) do
		local text = tools.escapeRichText(piece.text)

		if piece.color then
			text = tools.colorFromRGB(text, piece.color)
		end
		if piece.bold then
			text = `<b>{text}</b>`
		end

		table.insert(parts, text)
	end

	return table.concat(parts)
end

return highlight

end)()

local NUMBER = '<font color="#9c79df">%s</font>'
local SYMBOL = '<font color="#e12569">%s</font>'
local TAG = '<b><font color="#ff954b">%s</font></b>'
local function run(text) return highlight:apply(text) end

check("a number is colored as a number", run("42") == string.format(NUMBER, "42"))
check("a decimal number is a number too", run("3.5") == string.format(NUMBER, "3.5"))
check("a number with letters keeps its color", run("10px") == "10px")
check("a word with a digit keeps its color", run("player1") == "player1")
check("@name at the start is a bold tag color", run("@bob") == string.format(TAG, "@bob"))
check("#name at the start is a bold tag color", run("#2") == string.format(TAG, "#2"))
check("a tag in the middle of text is still a tag", run("x #tag mid") == "x " .. string.format(TAG, "#tag") .. " mid")
check("@ or # inside a word is only a symbol", run("a@b") == "a" .. string.format(SYMBOL, "@") .. "b")
check("# after a word character is a symbol and the digit a number", run("player#1") == "player" .. string.format(SYMBOL, "#") .. string.format(NUMBER, "1"))
check("symbols keep the symbol color", run("Health: 100") == "Health" .. string.format(SYMBOL, ":") .. " " .. string.format(NUMBER, "100"))
check("a minus sign is a symbol, the digits a number", run("-5") == string.format(SYMBOL, "-") .. string.format(NUMBER, "5"))
check("rich text characters are escaped", string.find(run("<b>x"), "&lt;", 1, true) ~= nil and string.find(run("<b>x"), "<b>", 1, true) == nil)
check("a lone symbol is still colored", run(":") == string.format(SYMBOL, ":"))
check("plain text is unchanged", run("hello world") == "hello world")
check("values that are not strings are shown as text", run(12) == string.format(NUMBER, "12"))

print(string.format("\n%d passed, %d failed", passed, failed))
