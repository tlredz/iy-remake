-- src/ui/services/dragService.luau
-- Drags GUI objects with a finger or the mouse.
--   - Only the press that started a drag moves the object. Another finger (the camera, the thumbstick) does not, so
--     a drag never jumps over to it.
--   - A button (TextButton, ImageButton) waits BUTTON_DEBOUNCE seconds before its press can become a drag. A press that
--     is let go before that is a click: it does not drag, so the button's Activated runs as usual. A press that moves
--     more than CLICK_TRAVEL px is not a click, so it becomes a drag at once.
--   - Any other GUI object starts a drag on the press.
-- The connections are not made through connectionService. The one of an object lives as long as the object, and the
-- ones of a press end with the press. connectionService:cleanup disconnects everything registered there, which would
-- cut a drag that is set up before the cleanup.

local inputUtils = require("../utils/inputUtils")
local rbxServices = require("../../framework/services/rbxServices")
local signal = require("../../utils/signal")

local userInputService = rbxServices.UserInputService

local LERP_VALUE = 0.28
local BUTTON_DEBOUNCE = 0.2 -- seconds a press on a button waits to be a click before it can become a drag
local CLICK_TRAVEL = 10 -- px a press on a button can move and still be a click

local dragService = {}
dragService.__index = dragService

-- A touch is the same InputObject from its start to its end, so the finger that pressed is matched by identity.
-- The mouse has one pointer and one button, so for it the kind of input is enough.
local function isMouse(input: InputObject): boolean
	return input.UserInputType ~= Enum.UserInputType.Touch
end

-- whether a moved input belongs to the press: the same finger, or the pointer while the mouse is pressed
local function isPressMove(press, input: InputObject): boolean
	if input == press.input then return true end
	return press.isMouse and input.UserInputType == Enum.UserInputType.MouseMovement
end

-- whether an ended input belongs to the press: the same finger, or the mouse button that pressed
local function isPressEnd(press, input: InputObject): boolean
	if input == press.input then return true end
	return press.isMouse and input.UserInputType == press.input.UserInputType
end

-- clears the state of the current press and disconnects its listeners. A debounce that is still waiting finds the
-- press gone and does nothing
function dragService:_resetDrag()
	for _, connection in self._pressConnections do
		connection:Disconnect()
	end
	table.clear(self._pressConnections)

	self._press = nil
	self.isDragging = false
	self.draggingObject = nil
	self.dragStart = nil
	self.startPos = nil
	self.lastPos = nil
	self.pressTime = 0
	self.travel = 0
end

-- the press is over. A drag that began reports how it went (dragEnded gets the object and a gesture). A press that
-- never became a drag (a click on a button) is only forgotten
function dragService:_endPress(press)
	if self._press ~= press then return end

	local wasDragging = self.isDragging
	local object = self.draggingObject
	local gesture = nil

	if wasDragging then
		gesture = {
			duration = os.clock() - self.pressTime, -- seconds the press lasted
			travel = self.travel, -- farthest distance (px) the pointer got from where it started
			dy = self.lastPos.Y - self.dragStart.Y, -- net vertical movement (px), positive = downward
		}
	end

	self:_resetDrag()

	if wasDragging then
		self.dragEnded:Fire(object, gesture)
	end
end

-- the drag begins: from now on the object follows the press
function dragService:_beginDrag(press)
	if self.isDragging or self._press ~= press then return end

	self.isDragging = true
	self.draggingObject = press.object
	self.dragStarted:Fire(press.object)
end

-- the press moved. A button that is still waiting becomes a drag once it has moved farther than a click allows
function dragService:_onPressMoved(press, input: InputObject)
	if self._press ~= press or not isPressMove(press, input) then return end

	if press.isButton and not self.isDragging then
		if (input.Position - self.dragStart).Magnitude <= CLICK_TRAVEL then return end

		self:_beginDrag(press)
	end

	if self.isDragging then
		self:update(press.object, input)
	end
end

-- starts tracking a press on an object. A window starts its drag at once. A button waits: if it is let go within
-- BUTTON_DEBOUNCE it was a click, otherwise the press becomes a drag then (holding still does not cancel it)
function dragService:_startPress(object: GuiObject, input: InputObject)
	local press = {
		object = object,
		input = input,
		isMouse = isMouse(input),
		isButton = object:IsA("GuiButton"),
	}

	self._press = press
	self.dragStart = input.Position
	self.lastPos = input.Position
	self.startPos = object.Position
	self.pressTime = os.clock()
	self.travel = 0

	-- the press ends on whichever report arrives first; there is no idle timeout
	self._pressConnections = {
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				self:_endPress(press)
			end
		end),
		userInputService.InputChanged:Connect(function(changed: InputObject)
			self:_onPressMoved(press, changed)
		end),
		userInputService.InputEnded:Connect(function(ended: InputObject)
			if isPressEnd(press, ended) then
				self:_endPress(press)
			end
		end),
	}

	if not press.isButton then
		self:_beginDrag(press)
		return
	end

	task.delay(BUTTON_DEBOUNCE, function()
		self:_beginDrag(press)
	end)
end

-- makes a GUI object draggable. The connection lives as long as the object does. Only one press is tracked at a time:
-- a press with another finger while one is tracked is ignored, so a finger on the camera or the thumbstick cannot
-- take over a drag
function dragService:addGuiObject(object: GuiObject): RBXScriptConnection
	return object.InputBegan:Connect(function(input: InputObject)
		if not inputUtils.isPressingInput(input) then return end
		if self._press then return end
		
		self:_startPress(object, input)
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
	return setmetatable({
		isDragging = false,
		draggingObject = nil,
		_uiScale = uiScale,
		dragStart = nil,
		startPos = nil,
		lastPos = nil,
		pressTime = 0,
		travel = 0,
		_press = nil, -- the press being tracked, nil when there is none
		_pressConnections = {},
		filters = {},

		onDragged = signal.new(),
		dragStarted = signal.new(),
		dragEnded = signal.new(),
	}, dragService)
end

return dragService
