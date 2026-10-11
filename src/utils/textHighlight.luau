-- src/utils/textHighlight.luau
-- Colors the tokens of a text for the windows and notifications, using rich text:
--   numbers (only digits, like 42 or 3.5)        -> number color
--   "quoted" or 'quoted' strings (quotes included) -> string color; numbers and tags inside stay string
--   words with letters or digits (10px, player1)  -> left as they are
--   "@name" or "#name" at the start of a token    -> tag color, in bold
--   other symbols (: ( ) [ ] { } ...)             -> symbol color

local argColors = require("../framework/config/ui/colors").args
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

-- The position of the quote that closes the string opened at `opening`, or nil when it never closes.
-- A backslash skips the character after it, so \" does not end the string.
local function findClosingQuote(text: string, opening: number): number?
	local quote = string.sub(text, opening, opening)
	local position = opening + 1

	while position <= #text do
		local char = string.sub(text, position, position)

		if char == "\\" then
			position += 2
		elseif char == quote then
			return position
		else
			position += 1
		end
	end

	return nil
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

		-- a quote starts a string, unless a word character is right before it (player's is an apostrophe)
		if (char == '"' or char == "'") and not isWordChar(previous) then
			local closing = findClosingQuote(text, position)

			if closing then
				push(string.sub(text, position, closing), argColors.string, false)
				position = closing + 1
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
