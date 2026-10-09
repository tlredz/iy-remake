local luaConvertions = require("../framework/config/luaConvertions")
local logger = require("./logger")
local tools = require("./tools")

local lookupify = tools.lookupify

local highlight = {}
highlight.__index = highlight

function highlight:skipWhiteSpace()
	
end

function highlight:next()
	
end

function highlight:apply(sourceCode)
	logger:expect(sourceCode, {"string"}, "'highlight:apply' #1")
	
	return table.concat(codeBuffer)
end

function highlight.new()
	return setmetatable({
		codeBuffer = {}
	}, highlight)
end

return highlight