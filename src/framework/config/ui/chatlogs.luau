-- src/framework/config/ui/chatlogs.luau

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
		tabInset = 0, -- gap between the Chat/Joins track and its thumb (0 = the thumb touches the edges)
		stripeTransparency = 0.96,
		entryHoverTransparency = 0.88, -- the entry under the pointer is lit up with this transparency
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
		tab = 13, -- the Chat/Joins switch
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

		-- clicking an entry copies it: the message in the chat tab, the user id in the joins tab
		copied = "Copied",
		chatCopied = "Message copied to the clipboard",
		joinCopied = "User ID copied to the clipboard:",
		noClipboard = "Your executor has no clipboard function",
	},
}
