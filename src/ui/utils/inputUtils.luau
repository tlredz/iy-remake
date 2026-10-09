--!strict
-- src/ui/utils/inputUtils.luau

local connectionService = require("../../framework/services/connectionService")
local rbxServices = require("../../framework/services/rbxServices")

local userInputService = rbxServices.UserInputService

local PRESSING_INPUTS = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.Touch] = true
}

local MOVING_INPUTS = {
	[Enum.UserInputType.MouseMovement] = true,
	[Enum.UserInputType.Touch] = true
}

local inputUtils = {}

function inputUtils.onReleaseEvent(callback)
	local releaseEvent
	
	releaseEvent = connectionService:Connect(userInputService.InputEnded, function(input)
		if inputUtils.isPressingInput(input) then
			releaseEvent:Disconnect()
			callback(input)
		end
	end)
	
	return releaseEvent
end

function inputUtils.onMouseEvent(callback)
	local mouseEvent
	
	mouseEvent = connectionService:Connect(userInputService.InputChanged, function(input)
		if inputUtils.isMovingInput(input) then
			callback(input)
		end
	end)
	
	return mouseEvent
end

function inputUtils.isPressingInput(input: InputObject): boolean
	return PRESSING_INPUTS[input.UserInputType] ~= nil
end

function inputUtils.isMovingInput(input: InputObject): boolean
	return MOVING_INPUTS[input.UserInputType] ~= nil
end

return inputUtils