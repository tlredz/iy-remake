local createService = require("../services/createService")

local directions = {
	["up"] = function(num, index)
		local stepY = 1 / num
		local scaleX = index / num
		
		local lineSize = UDim2.fromScale(scaleX, stepY)
		local position = UDim2.fromScale(
			0.5 - (scaleX / 2),
			(index - 1) * stepY
		)
		return lineSize, position
	end,
	["down"] = function(num, index)
		local stepY = 1 / num
		local scaleX = index / num
		
		local lineSize = UDim2.fromScale(scaleX, stepY)
		local position = UDim2.fromScale(
			0.5 - (scaleX / 2),
			1 - (index * stepY)
		)
		return lineSize, position
	end,
	["left"] = function(num, index)
		local stepX = 1 / num
		local scaleY = index / num
		
		local lineSize = UDim2.fromScale(stepX, scaleY)
		local position = UDim2.fromScale(
			(index - 1) * stepX,
			0.5 - (scaleY / 2)
		)
		return lineSize, position
	end,
	["right"] = function(num, index)
		local stepX = 1 / num
		local scaleY = index / num
		
		local lineSize = UDim2.fromScale(stepX, scaleY)
		local position = UDim2.fromScale(
			1 - (index * stepX),
			0.5 - (scaleY / 2)
		)
		return lineSize, position
	end
}

return function(num, scale, direction)
	local calculator = directions[direction]
	if not calculator then
		error("r u ok? Invalid direction: " .. tostring(direction))
	end
	
	local arrowFrame = createService.new("Frame", "Arrow", {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		createService.new("UIScale", {
			Scale = scale
		})
	})
	
	for index = 1, num do
		local lineSize, position = calculator(num, index)
		
		createService.new("Frame", `line_{index}`, {
			BackgroundColor3 = Color3.fromRGB(220, 220, 220),
			BorderSizePixel = 0,
			Size = lineSize,
			Position = position,
			Parent = arrowFrame,
			ThemeTag = {
				BackgroundColor3 = "Colors.Icons"
			}
		})
	end
	
	return arrowFrame
end