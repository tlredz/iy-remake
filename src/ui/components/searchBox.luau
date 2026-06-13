local signal = require("../../utils/signal")

local searchBox = {}
searchBox.__index = searchBox

function searchBox.new()
	return setmetatable({
		
	}, searchBox)
end

return searchBox