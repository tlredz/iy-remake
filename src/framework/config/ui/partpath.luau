-- src/framework/config/ui/partpath.luau
-- The part path window (partpath command). Sizes, rows and text sizes match the server info window,
-- so the two look like they belong to the same interface.

return {
	window = {
		title = "Part Path",
		width = 250,
		topBarHeight = 20,
		closeIconSize = 15,
		closeInset = 2,
		rowHeight = 17,
		buttonRowHeight = 21,
		buttonHeight = 17,
		buttonGap = 6,
		rowPadding = 4,
		-- a monospace line at size 14 fits about 28 characters in the window
		pathCharsPerLine = 28,
		textInset = 5,
		verticalPadding = 3,
		stripeTransparency = 0.96,
		shownY = 100,
		hiddenY = -500,
		tweenTime = 0.5,
	},

	textSizes = {
		title = 16,
		section = 11,
		value = 14,
		help = 11,
		button = 12,
	},

	headers = {
		path = "#path",
		actions = "#actions",
	},

	labels = {
		hint = "no part selected",
		help = 'click a part to see its path. "select part" saves it as a waypoint.',
	},

	buttons = {
		selectPart = "select part",
		copyPath = "copy path",
		copied = "copied",
		feedbackTime = 1.5,
		cornerRadius = 6,
	},

	messages = {
		noPart = "select a part first",
		noPath = "select a part to copy its path",
		noClipboard = "this executor doesn't support clipboard",
	},
}
