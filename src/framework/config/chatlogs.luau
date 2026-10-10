-- src/framework/config/chatlogs.luau

return {
	title = "Chat Logs",
	maxLabels = 200,

	window = {
		width = 340,
		height = 240,
		topBarHeight = 20,
		rowHeight = 22,
		closeIconSize = 10,
		buttonCorner = 6,
		buttonInset = 2,
		stripeTransparency = 0.96,
		shownX = 12,
		shownY = 100,
		hiddenX = -360,
		tweenTime = 0.28,
		tabTweenTime = 0.2,
	},

	scrollBar = {
		barThickness = 12,
		increment = 20,
		wheelIncrement = 40,
	},

	textSizes = {
		title = 16,
		control = 12,
		entry = 13,
	},

	tabs = {
		chat = "Chat",
		join = "Joins",
	},

	controls = {
		enabled = "Enabled",
		disabled = "Disabled",
		save = "Save",
		clear = "Clear",
	},

	messages = {
		saved = "Saved",
		saveFailed = "Save failed",
	},
}
