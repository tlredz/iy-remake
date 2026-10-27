-- src/utils/luahighlight.luau
-- Rich text for read-only Luau code: the code blocks and the inline code of the Reference window.
--
-- The source is cut into tokens first (comments, strings, numbers, names, symbols). Then each name is colored by
-- what stands around it:
--   keywords, type names and Roblox globals  -> others color
--   a function being defined or called        -> func color
--   a field (after '.', or a key in a table)  -> field color
-- Backtick strings keep their text in the string color, and each {expression} inside them is colored as code.

local syntax = require("../framework/config/utils/luaConvertions")
local colors = require("../framework/config/ui/colors").args
local tools = require("./tools")

local KEYWORDS = tools.lookupify({
	"and", "break", "continue", "do", "else", "elseif", "end", "export", "for", "function", "if", "in", "local",
	"not", "or", "repeat", "return", "then", "type", "typeof", "until", "while",
})
local BOOLEANS = tools.lookupify({ "true", "false", "nil" })
local NAMES = tools.lookupify({
	"Argument", "ArgsManager", "Color3", "Command", "CommandsController", "Enum", "EnumItem", "Instance", "Player",
	"Vector3", "any", "boolean", "game", "number", "script", "self", "string", "table", "task", "workspace",
})
local SYMBOLS = tools.lookupify(syntax.symbolChars)
-- operators made of more than one character, read as one symbol
local MULTI_SYMBOLS = tools.lookupify({
	"...", "..=", "//=", "==", "~=", "<=", ">=", "..", "::", "//", "->", "+=", "-=", "*=", "/=", "%=", "^=",
})

local KIND_COLORS = {
	comment = colors.comment,
	string = colors.string,
	number = colors.number,
	symbol = colors.symbol,
}

local highlight = {}
highlight.__index = highlight

-- where the long bracket that opens at position ends (after its closing bracket, or at the end of the source when it
-- never closes). nil when no long bracket ([[ or [==[) opens there
local function longBracketEnd(source: string, position: number): number?
	local equals = string.match(source, "^%[(=*)%[", position)
	if equals == nil then
		return nil
	end

	local _, closeEnd = string.find(source, "]" .. equals .. "]", position + #equals + 2, true)
	return if closeEnd then closeEnd + 1 else #source + 1
end

-- where the quoted string that opens at position ends. A backslash skips the next character. A string that never
-- closes ends at its line break, or at the end of the source
local function quoteEnd(source: string, position: number): number
	local quote = string.sub(source, position, position)
	local cursor = position + 1

	while cursor <= #source do
		local char = string.sub(source, cursor, cursor)

		if char == "\\" then
			cursor += 2
		elseif char == quote then
			return cursor + 1
		elseif char == "\n" then
			return cursor
		else
			cursor += 1
		end
	end

	return #source + 1
end

-- the number that starts at position, or nil. Covers hex, binary, underscores, fractions and exponents
local function matchNumber(source: string, position: number): string?
	local number = string.match(source, "^0[xX][%x_]+", position) or string.match(source, "^0[bB][01_]+", position)
	if number then
		return number
	end

	local startsWithDot = string.sub(source, position, position) == "."
	-- '.5' is a number, but the second dot of '..' is not the start of one
	if startsWithDot and string.sub(source, position - 1, position - 1) == "." then
		return nil
	end

	number = string.match(source, "^%d[%d_]*", position)
	if number == nil and startsWithDot then
		number = string.match(source, "^%.%d[%d_]*", position)
	end
	if number == nil then
		return nil
	end

	local cursor = position + #number
	-- a single dot followed by digits is a fraction; in '1..2' the dots are a concatenation
	if string.sub(source, cursor, cursor) == "." and string.sub(source, cursor + 1, cursor + 1) ~= "." then
		local fraction = string.match(source, "^%.[%d_]*", cursor)
		number ..= fraction
		cursor += #fraction
	end

	local exponent = string.match(source, "^[eE][%+%-]?%d+", cursor)
	if exponent then
		number ..= exponent
	end

	return number
end

-- the operator that starts at position when it is one of the multi-character ones, or nil
local function matchSymbol(source: string, position: number): string?
	local three = string.sub(source, position, position + 2)
	if MULTI_SYMBOLS[three] then
		return three
	end

	local two = string.sub(source, position, position + 1)
	if MULTI_SYMBOLS[two] then
		return two
	end

	return nil
end

-- Cuts the source into tokens: { kind, text }. Kinds: space, comment, string, number, name, symbol, other.
-- The texts of all the tokens, joined, are the source again.
local function tokenize(source: string)
	local tokens = {}
	local length = #source
	-- one counter for each {expression} that is open inside a backtick string: how many braces it holds inside
	local braces = {}

	local function push(kind: string, text: string)
		table.insert(tokens, { kind = kind, text = text })
	end

	-- reads the text of a backtick string from start, up to its closing backtick or the next {expression}
	local function readTemplate(start: number): number
		local cursor = start
		while cursor <= length do
			local char = string.sub(source, cursor, cursor)
			if char == "\\" then
				cursor += 2
			elseif char == "`" or char == "{" then
				break
			else
				cursor += 1
			end
		end

		local stop = math.min(cursor, length + 1)
		if stop > start then
			push("string", string.sub(source, start, stop - 1))
		end

		if cursor > length then
			return length + 1
		end

		if string.sub(source, cursor, cursor) == "`" then
			push("string", "`")
		else
			push("symbol", "{")
			table.insert(braces, 0)
		end

		return cursor + 1
	end

	local position = 1
	while position <= length do
		local char = string.sub(source, position, position)

		if string.match(char, "%s") then
			local space = string.match(source, "^%s+", position)
			push("space", space)
			position += #space
		elseif string.sub(source, position, position + 1) == "--" then
			-- a long comment ends at its closing bracket, a short one at the end of its line
			local stop = longBracketEnd(source, position + 2) or string.find(source, "\n", position, true) or length + 1
			push("comment", string.sub(source, position, stop - 1))
			position = stop
		elseif char == '"' or char == "'" then
			local stop = quoteEnd(source, position)
			push("string", string.sub(source, position, stop - 1))
			position = stop
		elseif char == "[" and longBracketEnd(source, position) then
			local stop = longBracketEnd(source, position)
			push("string", string.sub(source, position, stop - 1))
			position = stop
		elseif char == "`" then
			push("string", "`")
			position = readTemplate(position + 1)
		elseif char == "{" and #braces > 0 then
			braces[#braces] += 1
			push("symbol", "{")
			position += 1
		elseif char == "}" and #braces > 0 then
			if braces[#braces] == 0 then
				table.remove(braces)
				push("symbol", "}")
				position = readTemplate(position + 1)
			else
				braces[#braces] -= 1
				push("symbol", "}")
				position += 1
			end
		elseif string.match(char, "[%a_]") then
			local word = string.match(source, "^[%a_][%w_]*", position)
			push("name", word)
			position += #word
		elseif matchNumber(source, position) then
			local number = matchNumber(source, position)
			push("number", number)
			position += #number
		else
			local symbol = matchSymbol(source, position) or char
			push(if SYMBOLS[char] then "symbol" else "other", symbol)
			position += #symbol
		end
	end

	return tokens
end

-- the closest token before (step -1) or after (step 1) the token at index, skipping spaces
local function neighbour(tokens, index: number, step: number)
	local at = index + step
	while tokens[at] and tokens[at].kind == "space" do
		at += step
	end
	return tokens[at]
end

-- the color of a name, from the tokens around it
local function nameColor(tokens, index: number, name: string)
	if BOOLEANS[name] then
		return colors.boolean
	end
	if KEYWORDS[name] or NAMES[name] then
		return colors.others
	end

	local before = neighbour(tokens, index, -1)
	local after = neighbour(tokens, index, 1)
	local beforeText = if before then before.text else nil
	local afterText = if after then after.text else nil

	if beforeText == "function" then
		return colors.func
	end
	if beforeText == "." then
		return if afterText == "(" then colors.func else colors.field
	end
	if afterText == "(" then
		return colors.func
	end
	if beforeText == "{" and afterText == "=" then
		return colors.field
	end

	-- a plain name, like a variable or a type annotation after ':'
	return nil
end

local function tokenColor(tokens, index: number, token)
	if token.kind == "name" then
		return nameColor(tokens, index, token.text)
	end
	return KIND_COLORS[token.kind]
end

function highlight:apply(source: string): string
	local tokens = tokenize(tostring(source))

	-- neighbouring tokens with the same color become one run, so each run is one rich text tag
	local runs = {}
	for index, token in tokens do
		local color = tokenColor(tokens, index, token)
		local last = runs[#runs]

		if last and last.color == color then
			table.insert(last.texts, token.text)
		else
			table.insert(runs, { color = color, texts = { token.text } })
		end
	end

	local parts = {}
	for _, run in runs do
		local text = tools.escapeRichText(table.concat(run.texts))
		table.insert(parts, if run.color then tools.colorFromRGB(text, run.color) else text)
	end

	return table.concat(parts)
end

function highlight.new()
	return setmetatable({}, highlight)
end

return highlight
