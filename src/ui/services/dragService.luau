-- src/ui/services/dragService.luau

local connectionService = require("../../framework/services/connectionService")
local rbxServices = require("../../framework/services/rbxServices")

local inputUtils = require("../utils/inputUtils")
local signal = require("../../utils/signal")

local userInputService = rbxServices.UserInputService

local LERP_VALUE = 0.28

local dragService = {}
dragService.__index = dragService

-- clears the state of the current press and disconnects its listeners
function dragService:_resetDrag()
	for _, connection in self._pressConnections do
		connection:Disconnect()
	end
	table.clear(self._pressConnections)

	self.isDragging = false
	self.draggingObject = nil
	self.dragStart = nil
	self.startPos = nil
	self.lastPos = nil
	self.pressTime = 0
	self.travel = 0
end

-- the press is over: report how it went (dragEnded gets the object and a gesture)
function dragService:_endPress()
	if not self.isDragging then return end

	local object = self.draggingObject
	local gesture = {
		duration = os.clock() - self.pressTime, -- seconds the press lasted
		travel = self.travel, -- farthest distance (px) the pointer got from where it started
		dy = self.lastPos.Y - self.dragStart.Y, -- net vertical movement (px), positive = downward
	}

	self:_resetDrag()
	self.dragEnded:Fire(object, gesture)
end

function dragService:addGuiObject(object: GuiObject): RBXScriptConnection
	return connectionService:Connect(object.InputBegan, function(input)
		if not inputUtils.isPressingInput(input) then return end
		if self.isDragging then return end

		self.isDragging = true
		self.draggingObject = object
		self.dragStart = input.Position
		self.lastPos = input.Position
		self.startPos = object.Position
		self.pressTime = os.clock()
		self.travel = 0

		-- the press ends on whichever report arrives first; there is no idle timeout,
		-- so holding still does not cancel the drag
		self._pressConnections = {
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					self:_endPress()
				end
			end),
			userInputService.InputEnded:Connect(function(ended)
				if ended.UserInputType == input.UserInputType then
					self:_endPress()
				end
			end),
		}

		self.dragStarted:Fire(object)
	end)
end

function dragService:update(object: GuiObject, input: InputObject)
	local delta = input.Position - self.dragStart
	local scaleSize: number = (self._uiScale and self._uiScale.Scale) or 1

	self.lastPos = input.Position
	self.travel = math.max(self.travel, delta.Magnitude)

	local newPosition: UDim2 = UDim2.new(
		self.startPos.X.Scale,
		self.startPos.X.Offset + (delta.X / scaleSize),
		self.startPos.Y.Scale,
		self.startPos.Y.Offset + (delta.Y / scaleSize)
	)

	if self.filters[object] ~= nil then
		local customPos = self.filters[object](newPosition, scaleSize)
		newPosition = customPos or newPosition
	end

	object.Position = object.Position:Lerp(newPosition, LERP_VALUE)
	self.onDragged:Fire(object)
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

function dragService.new(uiScale: UIScale?)
	local self = setmetatable({
		isDragging = false,
		draggingObject = nil,
		_uiScale = uiScale,
		dragStart = nil,
		startPos = nil,
		lastPos = nil,
		pressTime = 0,
		travel = 0,
		_pressConnections = {},
		filters = {},

		onDragged = signal.new(),
		dragStarted = signal.new(),
		dragEnded = signal.new(),
	}, dragService)

	connectionService:Connect(userInputService.InputChanged, function(input)
		if self.isDragging and inputUtils.isMovingInput(input) then
			self:update(self.draggingObject, input)
		end
	end)

	return self
end

return dragService