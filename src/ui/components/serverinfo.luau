-- src/ui/components/info.luau

local createService = require("../services/createService")
local assetsService = require("../services/assetsService")
local themeService = require("../services/themeService")

local dragInstance = require("../utils/dragInstance")
local notifier = require("../notifier")

local tools = require("../../utils/tools")

local scaleObject = require("../utils/scaleObject")
local connectionService = require("../../framework/services/connectionService")
local executorEnv = require("../../framework/environment/executor")
local localPlayer = require("../../framework/services/localPlayer")
local robloxServices = require("../../framework/services/rbxServices")
local privateEnv = require("../../framework/environment/private")

local config = require("../../framework/config/serverinfo")
local textHighlight = require("../../utils/textHighlight")

local SHOWN_POSITION = UDim2.new(0.5, -config.window.width / 2, 0, config.window.shownY)
local HIDDEN_POSITION = UDim2.new(0.5, -config.window.width / 2, 0, config.window.hiddenY)

local info = {}

local function highlight(text)
	return textHighlight:apply(text)
end

local function line(prefix, value)
	return `{tools.escapeRichText(prefix)}{highlight(value)}`
end

local function copyToClipboard(value)
	if value == nil then return false end

	if executorEnv.setclipboard then
		executorEnv.setclipboard(tostring(value))
		return true
	end

	notifier:notify(config.messages.noClipboard)
	return false
end

local function formatTime(totalSeconds)
	local units = config.time
	local hours = math.floor(totalSeconds / 3600)
	local minutes = math.floor((totalSeconds % 3600) / 60)
	local seconds = math.floor(totalSeconds % 60)

	if hours > 0 then
		return `{hours} {units.hour}, {minutes} {units.minute}, {seconds} {units.second}`
	elseif minutes > 0 then
		return `{minutes} {units.minute}, {seconds} {units.second}`
	end

	return `{seconds} {units.second}`
end

local function fetchPlaceName()
	local success, productInfo = pcall(function()
		return robloxServices.MarketplaceService:GetProductInfo(game.PlaceId)
	end)

	if success and productInfo then
		return productInfo.Name
	end

	return config.messages.unknownPlace
end

local function createCopyButton(row, getValue)
	local copyConfig = config.copyButton

	local button = createService.new("TextButton", "Copy", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -config.window.textInset, 0.5, 0),
		Size = UDim2.fromOffset(copyConfig.width, copyConfig.height),
		Text = copyConfig.idleText,
		TextSize = config.textSizes.copyButton,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, copyConfig.cornerRadius),
		}),
	})

	connectionService:Connect(button.MouseEnter, function()
		themeService:updateObjectProperties(button, {
			BackgroundColor3 = "Colors.Buttons.Holding",
		})
	end)

	connectionService:Connect(button.MouseLeave, function()
		themeService:updateObjectProperties(button, {
			BackgroundColor3 = "Colors.Buttons.Default",
		})
	end)

	connectionService:Connect(button.Activated, function()
		if not copyToClipboard(getValue()) then return end

		button.Text = copyConfig.copiedText
		task.wait(copyConfig.feedbackTime)
		button.Text = copyConfig.idleText
	end)

	return button
end

local function createLine(body, layoutOrder, text, options)
	local windowConfig = config.window
	local inset = windowConfig.textInset
	local copyWidth = 0

	if options.getCopyValue then
		copyWidth = config.copyButton.width + config.copyButton.gap
	end

	local row = createService.new("Frame", "Row", body, {
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = (layoutOrder % 2 == 1) and windowConfig.stripeTransparency or 1,
		BorderSizePixel = 0,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1, 0, 0, windowConfig.rowHeight),
	})

	local label = createService.new("TextLabel", options.name, row, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(inset, 0),
		RichText = true,
		Size = UDim2.new(1, -(inset * 2 + copyWidth), 1, 0),
		Text = text,
		TextSize = options.textSize,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = options.textColor,
		},
	})

	if options.getCopyValue then
		createCopyButton(row, options.getCopyValue)
	end

	return label
end

local function createSection(body, layoutOrder, title)
	return createLine(body, layoutOrder, `<b>{tools.escapeRichText(title)}</b>`, {
		name = "Section",
		textSize = config.textSizes.section,
		textColor = "Colors.Text.Darker",
	})
end

local function createValueLine(body, layoutOrder, text, getCopyValue)
	return createLine(body, layoutOrder, text, {
		name = "Value",
		textSize = config.textSizes.value,
		textColor = "Colors.Text.Default",
		getCopyValue = getCopyValue,
	})
end

local function createWindow()
	local windowConfig = config.window

	local window = {
		labels = {},
		placeName = nil,
	}

	local frame = createService.new("Frame", "ServerInfo", {
		Active = true,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Position = HIDDEN_POSITION,
		Size = UDim2.fromOffset(windowConfig.width, 0),

		createService.new("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local topBar = createService.new("Frame", "TopBar", frame, {
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, windowConfig.topBarHeight),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},
	})

	createService.new("TextLabel", "Title", topBar, {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = windowConfig.title,
		TextSize = config.textSizes.title,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local closeButton = createService.new("ImageButton", "Exit", topBar, {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -windowConfig.closeInset, 0.5, 0),
		Size = UDim2.fromOffset(windowConfig.closeIconSize, windowConfig.closeIconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	assetsService:loadImage(closeButton, "close")

	connectionService:Connect(closeButton.Activated, function()
		info:close()
	end)

	local body = createService.new("Frame", "Body", frame, {
		Active = true,
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 0),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},

		createService.new("UIPadding", {
			PaddingBottom = UDim.new(0, windowConfig.verticalPadding),
			PaddingTop = UDim.new(0, windowConfig.verticalPadding),
		}),

		createService.new("UIListLayout", {
			Padding = UDim.new(0, windowConfig.rowGap),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local labels = window.labels
	local labelsConfig = config.labels
	local loading = config.messages.loading

	local layoutOrder = 0
	local function nextOrder()
		layoutOrder = layoutOrder + 1
		return layoutOrder
	end

	createSection(body, nextOrder(), config.headers.localPlayer)

	labels.playerId = createValueLine(body, nextOrder(), line(labelsConfig.playerId, localPlayer.UserId), function()
		return localPlayer.UserId
	end)

	labels.appearance = createValueLine(body, nextOrder(), line(labelsConfig.appearance, localPlayer.CharacterAppearanceId), function()
		return localPlayer.CharacterAppearanceId
	end)

	createSection(body, nextOrder(), config.headers.runTime)
	labels.time = createValueLine(body, nextOrder(), highlight(loading))

	createSection(body, nextOrder(), config.headers.statistics)
	labels.players = createValueLine(body, nextOrder(), line(labelsConfig.players, loading))
	labels.maxPlayers = createValueLine(body, nextOrder(), line(labelsConfig.maxPlayers, loading))

	labels.placeId = createValueLine(body, nextOrder(), line(labelsConfig.placeId, game.PlaceId), function()
		return game.PlaceId
	end)
	
	labels.gameId = createValueLine(body, nextOrder(), line(labelsConfig.gameId, game.GameId), function()
		return game.GameId
	end)

	labels.placeName = createValueLine(body, nextOrder(), line(labelsConfig.placeName, loading), function()
		return window.placeName
	end)

	dragInstance:addGuiObject(frame)

	window.frame = frame
	return window
end

local function updateWindow(window)
	local labels = window.labels
	local labelsConfig = config.labels
	local players = robloxServices.Players

	while info.window == window do
		labels.players.Text = line(labelsConfig.players, #players:GetPlayers())
		labels.maxPlayers.Text = line(labelsConfig.maxPlayers, players.MaxPlayers)
		labels.time.Text = highlight(formatTime(workspace.DistributedGameTime))

		task.wait(config.window.updateInterval)
	end
end

function info:create()
	if self.isEnabled then
		notifier:notify(config.messages.alreadyEnabled)
		return
	end

	self.isEnabled = true

	local window = createWindow()
	self.window = window

	local tweenTime = config.window.tweenTime

	window.frame.Parent = privateEnv.screenGui
	window.frame:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, tweenTime, true)

	task.spawn(function()
		window.placeName = fetchPlaceName()
		window.labels.placeName.Text = line(config.labels.placeName, window.placeName)
	end)

	task.spawn(updateWindow, window)

	return window
end

function info:close()
	local window = self.window
	if not window then return end

	local tweenTime = config.window.tweenTime

	self.window = nil
	self.isEnabled = false

	window.frame:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, tweenTime, true)

	task.delay(tweenTime, function()
		window.frame:Destroy()
	end)
end

return info