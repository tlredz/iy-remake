local function checkKeycodes(keys)
	local newKeys = {}
	
	for name, char in keys do
		-- KEY is not a valid member of "Enum.KeyCode"
		local keyCode = Enum.KeyCode[name]
		newKeys[keyCode] = char
	end
	
	return newKeys
end

return checkKeycodes({
	["Quote"] = "'",
	["QuotedDouble"] = "\"",
	["Comma"] = ",",
	["Minus"] = "-",
	["Period"] = ".",
	["Slash"] = "/",
	["Colon"] = ":",
	["Semicolon"] = ";",
	["LessThan"] = "<",
	["Equals"] = "=",
	["GreaterThan"] = ">",
	["Question"] = "?",
	["At"] = "@",
	["Hash"] = "#",
	["Dollar"] = "$",
	["Percent"] = "%",
	["Caret"] = "^",
	["Ampersand"] = "&",
	["Asterisk"] = "*",
	["LeftParenthesis"] = "(",
	["RightParenthesis"] = ")",
	["Plus"] = "+",
	["Underscore"] = "_",
	["LeftBracket"] = "[",
	["BackSlash"] = "\\",
	["RightBracket"] = "]",
	["Backquote"] = "`",
	["LeftCurly"] = "{",
	["Pipe"] = "|",
	["RightCurly"] = "}",
	["Tilde"] = "~",

	-- digits
	["Zero"] = "0",
	["One"] = "1",
	["Two"] = "2",
	["Three"] = "3",
	["Four"] = "4",
	["Five"] = "5",
	["Six"] = "6",
	["Seven"] = "7",
	["Eight"] = "8",
	["Nine"] = "9"
})