-- src/ui/notifier.luau

local createService = require("./services/createService")
local assetsService = require("./services/assetsService")
local themeService = require("./services/themeService")

local connectionService = require("../framework/services/connectionService")
local robloxServices = require("../framework/services/rbxServices")
local config = require("../framework/config/notifier")

local textHighlight = require("../utils/textHighlight")

local ICON_MARGIN = 4
local TITLE_GAP = 8

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

	local titleInset = ICON_MARGIN + config.iconSize + TITLE_GAP

	local titleLabel = createService.new("TextLabel", "Title", popup, {
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundTransparency = 1,
		Position = UDim2.fromScale(0.5, 0),
		Size = UDim2.new(1, -titleInset * 2, 0, config.titleHeight),
		Text = "",
		TextSize = config.titleTextSize,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local descHolder = createService.new("Frame", "Description", popup, {
		AnchorPoint = Vector2.new(0.5, 1),
		ClipsDescendants = true,
		Position = UDim2.new(0.5, 0, 1, -5),
		Size = UDim2.new(1, -10, 1, -25),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},
	})

	createService.new("UICorner", descHolder, {
		CornerRadius = UDim.new(0, config.cornerRadius),
	})

	local textLabel = createService.new("TextLabel", "Text", descHolder, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5, 5),
		Size = UDim2.new(1, -10, 1, -10),
		Text = "",
		TextSize = config.textSize,
		RichText = true,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local pinButton = createService.new("ImageButton", "PinButton", popup, {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, ICON_MARGIN, 0, config.titleHeight / 2),
		Size = UDim2.fromOffset(config.iconSize, config.iconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	local closeButton = createService.new("ImageButton", "CloseButton", popup, {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -ICON_MARGIN, 0, config.titleHeight / 2),
		Size = UDim2.fromOffset(config.iconSize, config.iconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	assetsService:loadImage(pinButton, "pin")
	assetsService:loadImage(closeButton, "close")

	return popup, titleLabel, textLabel, pinButton, closeButton
end

local function disconnectItem(item)
	for _, connection in item.connections do
		connectionService:disconnect(connection)
	end

	table.clear(item.connections)
end

function notifier:getContainer(screenGui)
	if self.container then
		return self.container
	end

	local container = createService.new("Frame", "Notifications", screenGui, {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromOffset(config.size.X.Offset, 0),
	})

	createService.new("UIListLayout", container, {
		Padding = UDim.new(0, config.spacing),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})

	self.container = container

	-- a popup added or removed changes the height of the stack
	container.ChildAdded:Connect(function()
		self:refreshLayout()
	end)

	container.ChildRemoved:Connect(function()
		self:refreshLayout()
	end)

	local pending = self.queue
	self.queue = {}

	for _, item in pending do
		self:add(item.title, item.message, item.duration)
	end

	return container
end

-- The height the popups take up right now, tween steps included (the layout puts a gap between them)
function notifier:getStackHeight()
	local container = self.container
	if not container then return 0 end

	local count = 0
	local height = 0

	for _, child in container:GetChildren() do
		if child:IsA("GuiObject") then
			count += 1
			height += child.Size.Y.Offset
		end
	end

	if count > 1 then
		height += (count - 1) * config.spacing
	end

	return height
end

-- Sizes the container to fit the popups, then lets the UI place the stack again
function notifier:refreshLayout()
	local container = self.container
	if not container then return end

	container.Size = UDim2.fromOffset(config.size.X.Offset, self:getStackHeight())

	if self.onLayoutChanged then
		self.onLayoutChanged()
	end
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

	local index = table.find(self.items, item)
	if index then
		table.remove(self.items, index)
	end

	disconnectItem(item)

	self:tweenHeight(item, 0)
	task.delay(config.tweenTime, function()
		item.frame:Destroy()
	end)
end

function notifier:trim()
	while #self.items > config.maxVisible do
		local oldest = nil

		for _, item in self.items do
			if not item.pinned then
				oldest = item
				break
			end
		end

		if not oldest then break end
		self:remove(oldest)
	end
end

function notifier:add(title, message, duration)
	self.nextOrder += 1

	local item = {
		title = title,
		pinned = false,
		removed = false,
		connections = {},
	}

	item.frame, item.titleLabel, item.textLabel, item.pinButton, item.closeButton =
		createPopup(self.container, self.nextOrder)
	
	item.titleLabel.Text = title
	item.textLabel.Text = textHighlight:apply(message)
	
	table.insert(item.connections, connectionService:Connect(item.pinButton.Activated, function()
		self:pin(item)
	end))
	
	table.insert(item.connections, connectionService:Connect(item.closeButton.Activated, function()
		self:remove(item)
	end))

	table.insert(self.items, item)
	self:tweenHeight(item, config.size.Y.Offset)

	-- the stack is laid out again while this popup grows or collapses
	item.frame:GetPropertyChangedSignal("Size"):Connect(function()
		self:refreshLayout()
	end)
	self:refreshLayout()

	local waitTime = if type(duration) == "number" then duration else config.defaultTime
	task.delay(waitTime, function()
		if not item.pinned then
			self:remove(item)
		end
	end)

	self:trim()
end

function notifier:notify(title, message, duration)
	if message == nil then
		message = title
		title = config.defaultTitle
	end

	title = tostring(title)

	if not self.container then
		table.insert(self.queue, { title = title, message = message, duration = duration })
		return
	end

	self:add(title, message, duration)
end

function notifier:destroy()
	for _, item in self.items do
		disconnectItem(item)
	end

	table.clear(self.items)
	table.clear(self.queue)
	self.container = nil
end

return notifier