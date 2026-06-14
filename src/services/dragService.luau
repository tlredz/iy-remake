local connectionService = require("./connectionService")
local robloxServices = require("./robloxServices")
local tweenService = require("./tweenService")

local signal = require("../utils/signal")

local userInputService = robloxServices.UserInputService

local inputBeganWhitelist = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.Touch] = true
}

local inputChangedWhitelist = {
	[Enum.UserInputType.MouseMovement] = true,
	[Enum.UserInputType.Touch] = true
}

local LERP_VALUE = 0.28

local dragService = {}
dragService.__index = dragService

function dragService:addGuiObject(object: GuiObject): (nil)
	local mouseConnection = nil
	
	local function disconnectMouse()
		self.isDragging = false
		self.draggingObject = nil
		self.dragStart = nil
		self.startPos = nil
		
		if mouseConnection then
			mouseConnection:Disconnect()
		end
		
		self.dragEnded:Fire(object)
	end
	
	local function startConnectionTimeout()
		while self.draggingObject == object do
			if (tick() - self.lastActivity) >= 1 then
				disconnectMouse()
			end
			task.wait()
		end
	end
	
	connectionService:Connect(object.InputBegan, function(input)
		if not inputBeganWhitelist[input.UserInputType] then return end
		if self.isDragging --[[and self.draggingObject ~= object]] then return end
		
		self.dragStart = input.Position
		self.startPos = object.Position
		
		self.isDragging = true
		self.draggingObject = object
		self.lastActivity = tick()
		
		self.dragStarted:Fire(object)
		
		task.spawn(startConnectionTimeout)
		
		mouseConnection = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				disconnectMouse()
			end
		end)
	end)
end

function dragService:update(object: GuiObject, input: InputObject)
	local delta: Vector2 = input.Position - self.dragStart
	local scaleSize: number = (self._uiScale and self._uiScale.Scale) or 1
	local originalPos = object.Position
	
	self.lastActivity = tick()
	
	local newPosition: UDim2 = UDim2.new(
		self.startPos.X.Scale, -- (UDim2).X.Scale
		self.startPos.X.Offset + (delta.X / scaleSize), -- (UDim2).X.Offset
		self.startPos.Y.Scale, -- (UDim2).Y.Scale
		self.startPos.Y.Offset + (delta.Y / scaleSize) -- (UDim2).Y.Offset
	)
	
	if self.filters[object] ~= nil then
		local customPos = self.filters[object](newPosition, scaleSize)
		newPosition = customPos or newPosition
	end
	
	local lerpValue = tweenService:getScale(LERP_VALUE)
	object.Position = originalPos:Lerp(newPosition, lerpValue)
end

function dragService:canDragObject(object: GuiObject): boolean
	return (not self.isDragging) or (self.draggingObject == object)
end

function dragService:setFilter(
	object: GuiObject,
	callback: (pos: UDim2, scaleSize: number) -> UDim2?
)
	self.filters[object] = callback
end

function dragService.new(uiScale)
	local self = setmetatable({
		isDragging = false,
		draggingObject = nil,
		_uiScale = uiScale,
		dragStart = nil,
		startPos = nil,
		filters = {},
		
		dragStarted = signal.new(),
		dragEnded = signal.new(),
	}, dragService)
	
	connectionService:Connect(userInputService.InputChanged, function(input)
		if self.isDragging and inputChangedWhitelist[input.UserInputType] then
			self:update(self.draggingObject, input)
		end
	end)
	
	return self
end

return dragService