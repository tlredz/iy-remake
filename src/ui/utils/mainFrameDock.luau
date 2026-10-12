-- src/ui/utils/mainFrameDock.luau
-- The main window has three states:
--   "minimized" = only the top bar is visible, on the bottom edge (where it starts)
--   "expanded"  = the whole window is visible, on the bottom edge (reached by a tap while minimized)
--   "top"       = the whole window flush with the top edge (only when it is dragged there)
-- Rules:
--   - a tap on the window while it is minimized expands it, just enough to be fully visible
--   - a click outside the window minimizes it, but only while it is expanded, not kept open, and the command bar is not in use
--     (not on PC, see hoverToOpen)
--   - while the command bar is in use, a drag down does not minimize it either (it only snaps)
--   - anything added with addWindowPart (the mobile IY button) counts as part of the window
--   - a drag that ends DRAG_DOWN_MIN px lower than it started minimizes it
--   - a drag that ends snaps to the top if that edge is nearer, otherwise to the bottom (keeping expanded / minimized)
--   - a window at the top never moves on taps or outside clicks
--   - the window is interactive (onInteractive) only when it is not minimized AND has stopped moving: it turns off
--     the moment it is minimized and turns back on when the animation to expanded / top is complete
--   - on PC (hoverToOpen), exactly like the original IY (Holder.MouseEnter / Holder.MouseLeave):
--       MouseEnter  -> a minimized window expands (0.2s); it also drops a minimize that was waiting for the delay
--       MouseLeave  -> an expanded window minimizes (0.5s) once the pointer has stayed away for HOVER_MINIMIZE_DELAY (1s),
--                      unless the command bar is focused (checked at the leave and again after the delay)
--       command bar loses the focus (Enter, Escape, a click elsewhere) -> the window minimizes, like the original's
--                      Cmdbar.FocusLost. A press on the window (a command in the list) that took the focus away
--                      does not count: then the MouseLeave decides
--     Nothing minimizes while kept open or during a drag; a leave during a drag counts when the drag ends.
--     Outside clicks do not minimize on PC. Without a mouse (touch only) hoverToOpen is off and the mobile rules apply

local robloxServices = require("../../framework/services/rbxServices")
local connectionService = require("../../framework/services/connectionService")
local uiTweens = require("../../framework/services/tweenService")

local TweenService = robloxServices.TweenService
local UserInputService = robloxServices.UserInputService

local MOVE_TIME = 0.32 -- seconds for expand / minimize / snap
local TAP_MAX_TIME = 0.1 -- a press this short (or shorter) can be a tap
local TAP_MAX_TRAVEL = 10 -- ...if the pointer barely moved (px)
local DRAG_DOWN_MIN = 50 -- a drag ending this many px lower minimizes the window (px)

-- PC hover, the original IY timings
local HOVER_EXPAND_TIME = 0.2 -- seconds for the window to open when the pointer enters it
local HOVER_MINIMIZE_TIME = 0.5 -- seconds for the window to go back to minimized
local HOVER_MINIMIZE_DELAY = 1 -- seconds the pointer must stay away before the window minimizes

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
--   onInteractive    fn(enabled: boolean), called when the window stops / starts accepting interactions (see above).
--                    Called once from dock.new, with false, since the window starts minimized
--   hoverToOpen      true on PC: the pointer over the window expands it, leaving it minimizes it (see the rules above).
--                    Only takes effect when a mouse is connected (UserInputService.MouseEnabled)
--   commandBarInUse  fn() -> boolean, true while the command bar is in use (nothing minimizes the window then)
function dock.new(options)
	local self = setmetatable({
		frame = options.frame,
		screenGui = options.screenGui,
		topBarHeight = options.topBarHeight,
		clampPosition = options.clampPosition,
		getScale = options.getScale,
		onMinimize = options.onMinimize,
		onInteractive = options.onInteractive,
		-- hover needs a mouse: a touch screen never sends MouseMovement, so there would be no enter and no leave
		hoverToOpen = options.hoverToOpen == true and UserInputService.MouseEnabled,
		commandBarInUse = options.commandBarInUse,

		state = "minimized",
		interactive = nil, -- unknown until the first setInteractive below
		hovering = false, -- the pointer is over the window (from the frame's MouseEnter / MouseLeave)
		hoverRequest = 0, -- counts the pointer's changes of side; a minimize waiting for the delay is dropped by a newer one
		dragging = false, -- a drag of the window is in progress (set by the interface)
		keepOpen = options.keepOpen == true, -- the saved "Keep Menu Open" flag; starting with it on does not expand the window
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

	self:setInteractive(false)

	if self.hoverToOpen then
		-- the frame is Active, like the original Holder: Roblox reports the pointer coming in and going out
		table.insert(self.connections, connectionService:Connect(self.frame.MouseEnter, function()
			if self.frame.Visible then self:setHovering(true) end
		end))

		table.insert(self.connections, connectionService:Connect(self.frame.MouseLeave, function()
			self:setHovering(false)
		end))
	end

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

-- only calls onInteractive when the value changes
function dock:setInteractive(enabled: boolean)
	if self.interactive == enabled then return end
	self.interactive = enabled

	if self.onInteractive then
		self.onInteractive(enabled)
	end
end

function dock:cancel()
	if self.tween then
		self.tween:Cancel()
		self.tween = nil
	end
end

function dock:moveTo(state: string, time: number?, direction: Enum.EasingDirection?)
	-- already heading there: let the current animation finish
	if state == self.state and self.tween and self.tween.PlaybackState == Enum.PlaybackState.Playing then
		return
	end

	self.state = state
	self:cancel()

	-- going away: no interactions from the very start of the animation
	if state == "minimized" then
		self:setInteractive(false)
	end

	local target = self:targetFor(state)
	local duration = uiTweens:getScale(time or MOVE_TIME)

	if duration <= 0 then
		self.frame.Position = target
		self:setInteractive(state ~= "minimized")
		return
	end

	local info = TweenInfo.new(duration, Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
	local tween = TweenService:Create(self.frame, info, { Position = target })
	self.tween = tween

	-- coming up: interactions only come back once the window has fully arrived. A cancelled tween (a drag took over,
	-- or another moveTo) never gets here, the move that replaces it decides
	tween.Completed:Connect(function(playback)
		if playback ~= Enum.PlaybackState.Completed then return end
		if self.tween ~= tween or self.state == "minimized" then return end

		self:setInteractive(true)
	end)

	tween:Play()
end

function dock:expand(time: number?, direction: Enum.EasingDirection?)
	self:moveTo("expanded", time, direction)
end

-- PC hover: the one place that decides an enter or a leave. Only a change of side does anything,
-- so a repeated event does nothing
function dock:setHovering(over: boolean)
	if over == self.hovering then return end
	self.hovering = over

	-- during a drag the drag decides where the window goes, so hover does not expand or minimize it
	if self.dragging then return end

	if over then
		self:onHoverEnter()
	else
		self:onHoverLeave()
	end
end

-- the pointer came into the window: a minimized window opens (0.2s, like the original). Coming in also drops a minimize
-- that is waiting for the delay
function dock:onHoverEnter()
	self.hoverRequest = self.hoverRequest + 1

	if self.state == "minimized" then
		self:expand(HOVER_EXPAND_TIME, Enum.EasingDirection.InOut)
	end
end

-- the pointer left the window: an expanded window minimizes (0.5s) once the pointer has stayed away for
-- HOVER_MINIMIZE_DELAY. If it comes back before that, the request changes and the minimize does not happen
function dock:onHoverLeave()
	self.hoverRequest = self.hoverRequest + 1
	local request = self.hoverRequest

	if not self:canHoverMinimize() then return end

	task.delay(HOVER_MINIMIZE_DELAY, function()
		if request ~= self.hoverRequest or not self:canHoverMinimize() then return end

		self:minimize(HOVER_MINIMIZE_TIME, Enum.EasingDirection.InOut)
	end)
end

-- the hover minimize only happens to an expanded window that is not kept open and has no command bar in use
function dock:canHoverMinimize(): boolean
	return self.state == "expanded" and not self.keepOpen and not self:commandBarBusy()
end

-- PC: the command bar lost the focus (the interface calls this from its FocusLost). Like the original, the window
-- minimizes, so a window opened with the prefix key (the pointer never entered it) does not stay open for good.
-- It waits one frame first: Enter on a correction or a click on a command gives the focus back right away, and then
-- nothing happens. With the pointer over the window, only Enter minimizes: any other loss of focus is most likely a
-- press on the window itself, and there the MouseLeave decides.
function dock:onCommandBarClosed(enteredCommand: boolean)
	if not self.hoverToOpen then return end

	local request = self.hoverRequest
	task.wait()

	-- a newer enter / leave (or destroy) took over while waiting
	if request ~= self.hoverRequest or self.dragging or not self:canHoverMinimize() then return end
	if self.hovering and not enteredCommand then return end

	self:minimize(HOVER_MINIMIZE_TIME, Enum.EasingDirection.InOut)
end

-- the interface tells the dock when a drag of the window starts and ends. A pointer that left the window during the drag
-- had no effect then, so the leave counts now (onDragEnded may still snap the window to the top, and then nothing happens).
-- A pointer still over the window at the drop does not open or minimize it: the drop has decided that
function dock:setDragging(dragging: boolean)
	local wasDragging = self.dragging
	self.dragging = dragging == true

	if wasDragging and not self.dragging and not self.hovering then
		self:onHoverLeave()
	end
end

function dock:minimize(time: number?, direction: Enum.EasingDirection?)
	-- the window is about to go below the screen: whatever is focused inside it has to let go first
	if self.onMinimize then
		self.onMinimize()
	end

	self:moveTo("minimized", time, direction)
end

-- the screen or the UI scale changed: put the window back in the state it is in
function dock:reflow()
	self:cancel()
	self.frame.Position = self:targetFor(self.state)
	self:setInteractive(self.state ~= "minimized") -- the window is where it should be now, no animation left to wait for
end

-- puts the window in the minimized state at once (no animation). Used when it is hidden, so the next
-- reveal slides up from the bottom edge like a fresh one
function dock:sleep()
	self:cancel()
	self.state = "minimized"
	self.frame.Position = self:targetFor("minimized")
	self:setInteractive(false)
end

-- a drag of the window ended (gesture comes from dragService)
function dock:onDragEnded(gesture)
	if gesture.travel <= TAP_MAX_TRAVEL then
		-- it was not a drag: resume the state it was heading to (a tap may have interrupted an animation)
		self:moveTo(self.state)
		return
	end

	if gesture.dy >= DRAG_DOWN_MIN and not self:commandBarBusy() then
		self:minimize()
		return
	end

	self:moveTo(self:nearestSnap())
end

-- true while the command bar is in use: outside presses and drags down do not minimize the window then
function dock:commandBarBusy(): boolean
	return self.commandBarInUse ~= nil and self.commandBarInUse() == true
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

	-- a click outside minimizes an expanded window, unless it is kept open; a window at the top stays where it is.
	-- Not on PC: there the pointer leaving the window does it (onHoverLeave), like the original
	if not inside and not self.hoverToOpen and self.state == "expanded" and not self.keepOpen and not self:commandBarBusy() then
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
	self.hoverRequest = self.hoverRequest + 1 -- a minimize waiting for the hover delay does not run after this

	for _, connection in self.connections do
		connectionService:disconnect(connection)
	end
	table.clear(self.connections)
end

return dock
