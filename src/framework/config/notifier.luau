-- src/framework/config/notifier.luau
-- Settings of the notification popups (src/ui/notifier.luau).

return {
	-- how long a popup stays open when no duration is given, and its default title
	defaultTime = 5,
	defaultTitle = "Notification",

	-- popup size, rounded corners, top bar height and icon size
	size = UDim2.fromOffset(250, 100),
	cornerRadius = 6,
	titleHeight = 20,
	iconSize = 11,

	-- text sizes, and the space between the popup edge and the message
	titleTextSize = 14,
	textSize = 14,
	padding = 8,

	-- the vertical stack: space between popups, gap to the main window, and how many popups fit
	spacing = 4,
	gapToWindow = 0,
	maxVisible = 5,

	-- time (seconds) to grow a popup in and collapse it out, and the title blink when pinned
	tweenTime = 0.5,
	flashTime = 0.5,
}
