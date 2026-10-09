-- src/framework/config/serverinfo.luau

return {
	window = {
		title = "Server",
		width = 250,
		topBarHeight = 20,
		closeIconSize = 15,
		closeInset = 2,
		rowHeight = 17,
		rowGap = 0,
		textInset = 5,
		verticalPadding = 3,
		stripeTransparency = 0.96,
		shownY = 100,
		hiddenY = -500,
		tweenTime = 0.5,
		updateInterval = 1,
	},

	copyButton = {
		width = 50,
		height = 15,
		gap = 6,
		cornerRadius = 6,
		idleText = "Copy",
		copiedText = "Copied",
		feedbackTime = 1.5,
	},

	textSizes = {
		title = 16,
		section = 11,
		value = 14,
		copyButton = 12,
	},
	
	headers = {
		localPlayer = "#player",
		runTime = "#run-time",
		statistics = "#statistics",
	},

	labels = {
		playerId   = "player-id:  ",
		appearance = "appearance: ",
		players    = "players:     ",
		maxPlayers = "max-players: ",
		placeId    = "place-id:    ",
		placeName  = "place-name:  ",
	},

	time = {
		hour = "Hour(s)",
		minute = "Minute(s)",
		second = "Second(s)",
	},

	messages = {
		loading = "LOADING",
		unknownPlace = "Unknown",
		alreadyEnabled = "the info menu is already enabled",
		noClipboard = "this executor doesn't support clipboard",
	},
}