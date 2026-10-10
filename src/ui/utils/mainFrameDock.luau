-- src/ui/utils/mainFrameDock.luau
-- The main window has three states:
--   "minimized" = only the top bar is visible, on the bottom edge (where it starts)
--   "expanded"  = the whole window is visible, on the bottom edge (reached by a tap while minimized)
--   "top"       = the whole window flush with the top edge (only when it is dragged there)
-- Rules:
--   - a tap on the window while it is minimized expands it, just enough to be fully visible
--   - a click outside the window minimizes it, but only while it is expanded and not kept open
--   - anything added with addWindowPart (the mobile IY button) counts as part of the window
--   - a drag that ends DRAG_DOWN_MIN px lower than it started minimizes it
--   - a drag that ends snaps to the top if that edge is nearer, otherwise to the bottom (keeping expanded / minimized)
--   - a window at the top never moves on taps or outside clicks

local robloxServices = require("../../framework/services/rbxServices")
local connectionService = require("../../framework/services/connectionService")
local uiTweens = require("../../framework/services/tweenService")

local TweenService = robloxServices.TweenService
local UserInputService = robloxServices.UserInputService

local MOVE_TIME = 0.32 -- seconds for expand / minimize / snap
local TAP_MAX_TIME = 0.1 -- a press this short (or shorter) can be a tap
local TAP_MAX_TRAVEL = 10 -- ...if the pointer barely moved (px)
local DRAG_DOWN_MIN = 50 -- a drag ending this many px lower minimizes the window (px)

local PRESS_TYPES = {
	[Enum.UserInputType.MouseButton1] = true,
	[Enum.UserInputType.Touch] = true,
}

local dock = {}
dock.__index = dock

-- options:
--   frame            the main window (GuiObject)
--   screenGui        the ScreenGui it lives in
--   topBarHeight     height of the top bar (logical units), what stays visible when minimized
--   clampPosition    fn(UDim2) -> UDim2, the window's normal screen clamp (used for X)
--   getScale         fn() -> number, current UI scale
--   onMinimize       fn(), called right before the window starts going away
function dock.new(options)
	local self = setmetatable({
		frame = options.frame,
		screenGui = options.screenGui,
		topBarHeight = options.topBarHeight,
		clampPosition = options.clampPosition,
		getScale = options.getScale,
		onMinimize = options.onMinimize,

		state = "minimized",
		keepOpen = false,
		windowParts = {},
		tween = nil,
		press = nil,
		connections = {},
	}, dock)

	self.frame.Position = self:targetFor("minimized")

	table.insert(self.connections, connectionService:Connect(UserInputService.InputBegan, function(input)
		self:onInputBegan(input)
	end))

	table.insert(self.connections, connectionService:Connect(UserInputService.InputEnded, function(input)
		self:onInputEnded(input)
	end))

	return self
end

local function pointInside(object: GuiObject, point: Vector3): boolean
	local pos = object.AbsolutePosition
	local size = object.AbsoluteSize

	return point.X >= pos.X and point.X <= pos.X + size.X
		and point.Y >= pos.Y and point.Y <= pos.Y + size.Y
end

-- true when a point (screen px) is over the window or over one of its parts
function dock:isOverWindow(point: Vector3): boolean
	if pointInside(self.frame, point) then
		return true
	end

	for _, part in self.windowParts do
		if pointInside(part, point) then
			return true
		end
	end

	return false
end

-- a GuiObject outside the window whose clicks should count as clicks on the window
function dock:addWindowPart(object: GuiObject)
	table.insert(self.windowParts, object)
end

-- keep open: a click outside does not minimize the window. Turning it on shows a minimized window.
function dock:setKeepOpen(enabled: boolean)
	self.keepOpen = enabled == true

	if self.keepOpen and self.state == "minimized" then
		self:expand()
	end
end

-- shows the window if it is minimized; a window that is already up does not move
function dock:reveal()
	if self.state == "minimized" then
		self:expand()
	end
end

-- runs fn once the window has stopped moving (right away if it is not moving)
function dock:onSettled(fn: () -> ())
	local tween = self.tween

	if tween and tween.PlaybackState == Enum.PlaybackState.Playing then
		tween.Completed:Once(fn)
	else
		task.defer(fn)
	end
end

-- where a drag that ends right now should go: "top" if that edge is nearer, otherwise the bottom.
-- The bottom keeps the state the window was in (expanded stays expanded, minimized stays minimized),
-- and a window that was at the top goes down to minimized.
function dock:nearestSnap(): string
	local frame = self.frame
	local distanceToTop = frame.AbsolutePosition.Y
	local distanceToBottom = self.screenGui.AbsoluteSize.Y - (frame.AbsolutePosition.Y + frame.AbsoluteSize.Y)

	if distanceToTop <= distanceToBottom then
		return "top"
	end

	if self.state == "expanded" then
		return "expanded"
	end

	return "minimized"
end

-- the Position of the window in a state, keeping its current X
function dock:targetFor(state: string): UDim2
	local x = self.clampPosition(self.frame.Position).X

	if state == "top" then
		-- flush with the top of the screen (GuiInset is ignored on purpose)
		return UDim2.new(x.Scale, x.Offset, 0, 0)
	end

	if state == "expanded" then
		-- the whole window, sitting on the bottom edge
		return UDim2.new(x.Scale, x.Offset, 1, -self.frame.Size.Y.Offset)
	end

	-- minimized: the window hangs below the bottom edge, leaving only its top bar
	return UDim2.new(x.Scale, x.Offset, 1, -self.topBarHeight)
end

-- used while dragging: X keeps the normal clamp; Y moves freely between the top edge and the
-- minimized position, so the window never jumps to another state while it is being dragged
function dock:clampDrag(pos: UDim2): UDim2
	local x = self.clampPosition(pos).X

	local scale = math.max(self.getScale(), 0.01)
	local screenHeight = self.screenGui.AbsoluteSize.Y / scale -- logical units, same as the offsets
	local maxY = math.max(screenHeight - self.topBarHeight, 0)
	local y = math.clamp(pos.Y.Scale * screenHeight + pos.Y.Offset, 0, maxY)

	return UDim2.new(x.Scale, x.Offset, 0, y)
end

function dock:cancel()
	if self.tween then
		self.tween:Cancel()
		self.tween = nil
	end
end

function dock:moveTo(state: string)
	-- already heading there: let the current animation finish
	if state == self.state and self.tween and self.tween.PlaybackState == Enum.PlaybackState.Playing then
		return
	end

	self.state = state
	self:cancel()

	local target = self:targetFor(state)
	local duration = uiTweens:getScale(MOVE_TIME)

	if duration <= 0 then
		self.frame.Position = target
		return
	end

	local info = TweenInfo.new(duration, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	self.tween = TweenService:Create(self.frame, info, { Position = target })
	self.tween:Play()
end

function dock:expand()
	self:moveTo("expanded")
end

function dock:minimize()
	-- the window is about to go below the screen: whatever is focused inside it has to let go first
	if self.onMinimize then
		self.onMinimize()
	end

	self:moveTo("minimized")
end

-- the screen or the UI scale changed: put the window back in the state it is in
function dock:reflow()
	self:cancel()
	self.frame.Position = self:targetFor(self.state)
end

-- a drag of the window ended (gesture comes from dragService)
function dock:onDragEnded(gesture)
	if gesture.travel <= TAP_MAX_TRAVEL then
		-- it was not a drag: resume the state it was heading to (a tap may have interrupted an animation)
		self:moveTo(self.state)
		return
	end

	if gesture.dy >= DRAG_DOWN_MIN then
		self:minimize()
		return
	end

	self:moveTo(self:nearestSnap())
end

function dock:onInputBegan(input)
	if not PRESS_TYPES[input.UserInputType] then return end

	local inside = self:isOverWindow(input.Position)

	self.press = {
		type = input.UserInputType,
		time = os.clock(),
		position = input.Position,
		inside = inside,
	}

	-- a click outside minimizes an expanded window, unless it is kept open; a window at the top stays where it is
	if not inside and self.state == "expanded" and not self.keepOpen then
		self:minimize()
	end
end

function dock:onInputEnded(input)
	local press = self.press
	if not press or input.UserInputType ~= press.type then return end
	self.press = nil

	if not press.inside then return end

	local duration = os.clock() - press.time
	local travel = (input.Position - press.position).Magnitude

	-- a tap expands a minimized window (and does nothing else)
	if duration <= TAP_MAX_TIME and travel <= TAP_MAX_TRAVEL and self.state == "minimized" then
		self:expand()
	end
end

function dock:destroy()
	self:cancel()

	for _, connection in self.connections do
		connectionService:disconnect(connection)
	end
	table.clear(self.connections)
end

return dock
