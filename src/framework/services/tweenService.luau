local tweenConfig = require("../config/tween")

local tweenService = {}

function tweenService:getScale(value)
	return tweenConfig.isEnabled and (value * tweenConfig.animationScale) or 0
end

function tweenService:getScrollSpeed(value)
	return (value * tweenConfig.scrollSpeed)
end

return tweenService