local identifierColor = Color3.fromRGB(248, 109, 115)
local stringColor = Color3.fromRGB(223, 215, 136)
local numberColor = Color3.fromRGB(156, 121, 223)
local symbolColor = Color3.fromRGB(225, 37, 105)
local commentColor = Color3.fromRGB(118, 113, 94)
local othersColor = Color3.fromRGB(97, 181, 195)
local warnColor = Color3.fromRGB(254, 193, 7)
local errorColor = Color3.fromRGB(244, 66, 54)
local validColor = Color3.fromRGB(166, 227, 45)

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
		["valid"] = validColor
	}
}