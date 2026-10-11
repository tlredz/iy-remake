-- src/ui/utils/notificationPlacement.luau
-- Works out where the stack of notifications goes, next to the main window.
--
-- The main window is placed with UDim2 (scale of the screen + offset), so the stack is placed with the
-- same UDim2 values. That way it lines up with the window's edges whatever the UI scale is: nothing is
-- measured in pixels or converted by the scale. The screen size is only used to pick the side and to
-- know how much room the stack has, where a small error does no harm.
-- No Roblox calls here, so it can be checked on its own.

local placement = {}

-- window: { x, y, width, height }
--   x, y    { scale, offset }: the window's top-left corner, as its Position (UDim2 components)
--   width, height: the window's size in logical units
-- screen: { width, height }  logical units (the UI scale is already divided out)
-- stack:  { width }
-- Returns the stack's position as { scale, offset } pairs, its anchorX / anchorY, and the room: how tall the
-- stack can get from its anchor to the edge of the screen (logical units).
function placement.compute(window, screen, stack, gap: number)
	-- the side: the stack goes beside the window, on the side with room for it (the right side is preferred)
	local left = window.x.scale * screen.width + window.x.offset
	local right = left + window.width

	local roomRight = screen.width - right - gap
	local roomLeft = left - gap

	local onRight
	if roomRight >= stack.width then
		onRight = true
	elseif roomLeft >= stack.width then
		onRight = false
	else
		onRight = roomRight >= roomLeft
	end

	local x
	if onRight then
		x = { scale = window.x.scale, offset = window.x.offset + window.width + gap }
	else
		x = { scale = window.x.scale, offset = window.x.offset - gap }
	end

	-- the top and bottom of the window on the screen (logical units)
	local top = window.y.scale * screen.height + window.y.offset
	local bottom = top + window.height

	-- the stack grows towards the middle of the screen: up from the bottom of the visible window when the
	-- visible part is in the lower half, down from its top otherwise (same rule as before, on the visible part)
	local visibleCenter = (math.max(top, 0) + math.min(bottom, screen.height)) / 2
	local growsUp = visibleCenter > screen.height / 2

	local y, anchorY, room
	if growsUp then
		-- a window that hangs below the screen (minimized) has its visible bottom on the screen's bottom edge
		if bottom >= screen.height then
			y = { scale = 1, offset = 0 }
		else
			y = { scale = window.y.scale, offset = window.y.offset + window.height }
		end
		anchorY = 1
		room = math.min(bottom, screen.height)
	else
		if top < 0 then
			y = { scale = 0, offset = 0 }
		else
			y = { scale = window.y.scale, offset = window.y.offset }
		end
		anchorY = 0
		room = screen.height - math.max(top, 0)
	end

	return {
		x = x,
		y = y,
		anchorX = if onRight then 0 else 1,
		anchorY = anchorY,
		room = math.max(room, 0),
	}
end

return placement
