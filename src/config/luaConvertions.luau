local tools = require("../utils/tools")

local defaultEscapeSequences = {
	["a"] = "\a", ["b"] = "\b", ["f"] = "\f", ["n"] = "\n",
	["r"] = "\r", ["t"] = "\t", ["v"] = "\v", ["\\"] = "\\",
	["\""] = "\"", ["\'"] = "\'",
}

local startIdentChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
local identChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789"
local hexDigitsChars = "0123456789abcdefABCDEF"
local digitChars = "0123456789"

return {
	whiteSpaceChars = {" ", "\t", "\n", "\r"},
	
	startIdentChars        = tools.chararray(startIdentChars),
	identChars             = tools.chararray(identChars),
	numberChars            = tools.chararray(digitChars),
	hexNumberChars         = tools.chararray(hexDigitsChars),
	escapeSequences        = defaultEscapeSequences,
	maxSymbolLength        = 3,
	
	binaryNumberChars      = {"0", "1"},
	decimalExponent        = {"e", "E"},
	hexadecimalNums        = {"x", "X"},
	binaryNums          = {"b", "B"},
	decimalSeparators   = {"_"},
	
	hybridKeywords = {
		"continue", "export", "type", "typeof", "read", "write"
	},
	keywords = {
		"and", "break", "do", "else", "elseif", "continue", "end", "false", "for",
		"function", "if", "in", "local", "nil", "not", "or", "repeat", "return",
		"then", "true", "until", "while",
		"export", "type", "typeof", "read", "write"
	},
	symbols = {
		"+=", "-=", "/=", "%=", "^=", "..=", "*=", "//=", "+", "-", "*", "/", "%", "^",
		"#", "//", "==", "~=", "<=", ">=", "<", ">", "=", "(", ")", "{", "}", "[", "]",
		";", ":", ",", ".", "..", "...", "::", "->", "?", "|", "&"
	},
	symbolChars = tools.chararray("+-*/%^#=~<>(){}[];:,.?|&"),
	
	supportsNumericalEscapes    = true,
	supportsHexEscapes          = true,
	supportsUnicodeEscapes      = true,
	supportsEscapeZIgnoreNextWhitespace = true,
	supportsAdvancedSemicolons = true,
	
	TypeAnnotationsChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_", -- \"'`?|&[]{}()<>:., 
	
	supportsInterpolatedStrings = true,
	supportsTypeAnnotations     = true,
	supportsCompounds           = true,
	supportsIfElseInLine        = true,
}