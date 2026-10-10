-- src/ui/utils/notificationPlacement.luau
-- Works out where the stack of notifications goes, next to the main window.
-- Everything is in logical units (the UIScale is already divided out), and it has no Roblox calls,
-- so it can be checked on its own.

local placement = {}

-- window: { left, top, right, bottom }  screen: { width, height }  stack: { width, height }
-- Returns the x and y of the stack's top-left corner, and the anchorX to use with it.
function placement.compute(window, screen, stack, gap: number)
	local roomRight = screen.width - window.right - gap
	local roomLeft = window.left - gap

	-- the side with room for the stack wins; the right side is preferred
	local onRight
	if roomRight >= stack.width then
		onRight = true
	elseif roomLeft >= stack.width then
		onRight = false
	else
		onRight = roomRight >= roomLeft
	end

	-- the stack grows towards the middle of the screen: up from the bottom of the window when the
	-- window is in the lower half, down from its top otherwise
	local windowCenter = window.top + (window.bottom - window.top) / 2
	local growsUp = windowCenter > screen.height / 2

	local x = if onRight then window.right + gap else window.left - gap
	local y = if growsUp then window.bottom - stack.height else window.top

	-- never let the stack leave the screen
	y = math.clamp(y, 0, math.max(screen.height - stack.height, 0))

	return {
		x = x,
		y = y,
		anchorX = if onRight then 0 else 1,
	}
end

return placement
