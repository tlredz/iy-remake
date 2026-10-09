-- src/framework/config/notifier.luau
-- Settings of the notification popup (src/ui/notifier.luau).

return {
	-- how long a notification stays open when no duration is given, and its default title
	defaultTime = 10,
	defaultTitle = "Notification",

	-- popup size, rounded corners, and the top bar that holds the title and the icons
	size = UDim2.fromOffset(250, 100),
	cornerRadius = 6,
	titleHeight = 20,
	iconSize = 15,

	-- text sizes, and the space between the popup edge and the message
	titleTextSize = 16,
	textSize = 14,
	padding = 8,

	-- animation time (seconds) for sliding in and out, and for the title blink when pinned
	tweenTime = 0.5,
	flashTime = 0.5,

	-- where the popup slides from and to: right side of the screen, bottom edge
	hiddenPosition = UDim2.new(1, -500, 1, 20),
	shownPosition = UDim2.new(1, -500, 1, -100),
}
