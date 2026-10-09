-- src/ui/notifier.luau

local createService = require("./services/createService")
local assetsService = require("./services/assetsService")
local connectionService = require("../framework/services/connectionService")
local robloxServices = require("../framework/services/rbxServices")
local themeService = require("./services/themeService")
local config = require("../framework/config/notifier")
local logger = require("../utils/logger")

local notifier = {
	container = nil,

	items = {},
	nextOrder = 0,

	queue = {},
}

local function createPopup(parent, order)
	local popup = createService.new("Frame", "Notification", parent, {
		BorderSizePixel = 0,
		ClipsDescendants = true,
		LayoutOrder = order,
		Size = UDim2.fromOffset(config.size.X.Offset, 0),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},
	})

	local titleLabel = createService.new("TextLabel", "Title", popup, {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, config.titleHeight),
		Text = "",
		TextSize = config.titleTextSize,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local textLabel = createService.new("TextLabel", "Text", popup, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(config.padding, config.titleHeight + config.padding),
		Size = UDim2.new(1, -config.padding * 2, 1, -(config.titleHeight + config.padding * 2)),
		Text = "",
		TextSize = config.textSize,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local pinButton = createService.new("ImageButton", "PinButton", popup, {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 2, 0, config.titleHeight / 2),
		Size = UDim2.fromOffset(config.iconSize, config.iconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	local closeButton = createService.new("ImageButton", "CloseButton", popup, {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -2, 0, config.titleHeight / 2),
		Size = UDim2.fromOffset(config.iconSize, config.iconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	assetsService:loadImage(pinButton, "pin")
	assetsService:loadImage(closeButton, "close")

	return popup, titleLabel, textLabel, pinButton, closeButton
end

function notifier:getContainer(screenGui)
	if self.container then
		return self.container
	end

	local container = createService.new("Frame", "Notifications", screenGui, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(config.size.X.Offset, 0),
	})

	createService.new("UIListLayout", container, {
		Padding = UDim.new(0, config.spacing),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	self.container = container

	local pending = self.queue
	self.queue = {}

	for _, item in pending do
		self:add(item.title, item.message, item.duration)
	end

	return container
end

function notifier:tweenHeight(item, height)
	if item.tween then
		item.tween:Cancel()
	end

	local info = TweenInfo.new(config.tweenTime, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut)
	item.tween = robloxServices.TweenService:Create(item.frame, info, {
		Size = UDim2.fromOffset(config.size.X.Offset, height),
	})
	item.tween:Play()
end

function notifier:pin(item)
	if item.pinned or item.removed then return end
	item.pinned = true

	item.titleLabel.Text = item.title .. " (Pinned)"
	themeService:addObject(item.pinButton, { ImageColor3 = "Colors.Primary" })

	local titleLabel = item.titleLabel
	task.spawn(function()
		titleLabel.TextTransparency = 0.5
		task.wait(config.flashTime)
		titleLabel.TextTransparency = 0
	end)
end

function notifier:remove(item)
	if item.removed then return end
	item.removed = true

	for index, other in self.items do
		if other == item then
			table.remove(self.items, index)
			break
		end
	end

	self:tweenHeight(item, 0)
	task.delay(config.tweenTime, function()
		item.frame:Destroy()
	end)
end

function notifier:add(title, message, duration)
	self.nextOrder += 1

	local item = { title = tostring(title), pinned = false, removed = false }
	item.frame, item.titleLabel, item.textLabel, item.pinButton, item.closeButton =
		createPopup(self.container, self.nextOrder)

	item.titleLabel.Text = item.title
	item.textLabel.Text = tostring(message)

	connectionService:Connect(item.pinButton.Activated, function()
		self:pin(item)
	end)

	connectionService:Connect(item.closeButton.Activated, function()
		self:remove(item)
	end)

	table.insert(self.items, item)
	self:tweenHeight(item, config.size.Y.Offset)

	local waitTime = config.defaultTime
	if type(duration) == "number" then
		waitTime = duration
	end

	task.delay(waitTime, function()
		if not item.pinned then
			self:remove(item)
		end
	end)

	while #self.items > config.maxVisible do
		self:remove(self.items[1])
	end
end

function notifier:notify(title, message, duration)
	logger:expect(title, {"string"}, "'notifier:notify' #1")

	if message == nil then
		message = title
		title = config.defaultTitle
	end

	if not self.container then
		table.insert(self.queue, { title = title, message = message, duration = duration })
		return
	end

	self:add(title, message, duration)
end

return notifier
