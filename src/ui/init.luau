-- src/ui/init.luau

local frameworkSettings = require("../framework/settings")
local notificationsConfig = require("../framework/config/notifier")
local privateEnv = require("../framework/environment/private")
local connectionService = require("../framework/services/connectionService")
local robloxServices = require("../framework/services/rbxServices")
local isMobile = require("../framework/config/isMobile")

local settingsData = require("../storage/data/settings")
local logger = require("../utils/logger")
local tools = require("../utils/tools")

local createService = require("./services/createService")
local assetsService = require("./services/assetsService")
local themeService = require("./services/themeService")

local themes = require("./themes")
local coreGui = require("./coreGui")
local notifier = require("./notifier")

local titleFormatter = require("./utils/titleFormatter")
local scaleObject = require("./utils/scaleObject")
local notificationPlacement = require("./utils/notificationPlacement")

local mainFrameComponent = require("./components/mainFrame")
local scrollBarComponent = require("./components/scrollBar")
local commandsComponent = require("./components/commands")
local referenceComponent = require("./components/reference")
local serverInfoComponent = require("./components/serverinfo")
local chatLogsComponent = require("./components/chatlogs")

local dragInstance = require("./utils/dragInstance")
local mainFrameDock = require("./utils/mainFrameDock")

local REFERENCE_SCREEN_HEIGHT = 450
local KEEP_IY_SETTING = "interface.keepIY"
local uiScale = scaleObject.uiScale

local interface = {
	awoken = false,
}

local function resolveTheme(name)
	local theme = type(name) == "string" and themes[name:lower()]

	if theme and theme.Colors and theme.Font then
		return name
	end

	return frameworkSettings.theme.defaultTheme
end

local function clampAxis(udim, sizeOffset, screenPx, scale)
	local current = (udim.Scale * screenPx) / scale + udim.Offset
	local maxInt = math.floor(screenPx / scale - sizeOffset)

	if math.floor(current) >= maxInt then
		return 1, -sizeOffset
	end

	return 0, math.clamp(math.floor(current), 0, math.max(maxInt, 0))
end

function interface:awake()
	if self.awoken then
		return self.screenGui
	end

	self.awoken = true

	self:setupTheme()
	self:setupScreenGui()
	self:setupScale()
	self:setupMainFrame()
	self:setupKeepIY()
	self:createQuickCapture()
	self:createReference()
	self:createNotifications()
	self:setupListeners()
	self:updateNotificationsPosition()

	logger:log("interface started")
	return self.screenGui
end

function interface:setupTheme()
	logger:debug("interface: initializing theme service")

	themeService:init({
		theme = resolveTheme(frameworkSettings.theme.selectedTheme),
	})
end

function interface:setupScreenGui()
	local screenGui = self:createScreenGui()

	screenGui.Parent = coreGui
	privateEnv.screenGui = screenGui

	uiScale.Parent = screenGui
end

function interface:setupScale()
	self:setScale(settingsData:getValue("interface.uiScale") or 1)
end

function interface:setupMainFrame()
	local mainFrame = self:createMainFrame()

	self:createCommands()
	self:dragMainFrame(mainFrame)
	self.commands:enable()

	mainFrame.Parent = self.screenGui
end

function interface:setupListeners()
	connectionService:Connect(self.screenGui:GetPropertyChangedSignal("AbsoluteSize"), function()
		self:updateMainFramePosition()
	end)

	connectionService:Connect(self.mainFrame:GetPropertyChangedSignal("AbsolutePosition"), function()
		self:updateNotificationsPosition()
	end)

	connectionService:Connect(self.mainFrame:GetPropertyChangedSignal("AbsoluteSize"), function()
		self:updateNotificationsPosition()
	end)

	connectionService:Connect(robloxServices.RunService.RenderStepped, function()
		self:updateNotificationsPosition()
	end)
end

function interface:createScreenGui()
	local screenGui = createService.new("ScreenGui", {
		IgnoreGuiInset = true,
		Name = tools.randomString(math.random(30, 50)),
		DisplayOrder = (2 ^ 31) - 1,
	})

	self.screenGui = screenGui
	return screenGui
end

function interface:calculateScale(newScale)
	return (self.screenGui.AbsoluteSize.Y / REFERENCE_SCREEN_HEIGHT) * newScale
end

function interface:setScale(newScale)
	newScale = math.abs(newScale)

	if newScale >= 3 then
		newScale = self:calculateScale(newScale)
	end

	if settingsData:getValue("interface.uiScale") ~= newScale then
		settingsData:setValue("interface.uiScale", newScale)
		settingsData:save()
	end

	scaleObject:setScale(newScale)
	self:updateMainFramePosition()
end

function interface:calculateMainFramePosition(pos)
	local mainFrame = self.mainFrame
	local screenGui = self.screenGui
	local scale = scaleObject:getScale()
	local size = mainFrame.Size
	
	pos = pos or mainFrame.Position

	local xScale, xOffset = clampAxis(pos.X, size.X.Offset, screenGui.AbsoluteSize.X, scale)
	local yScale, yOffset = clampAxis(pos.Y, size.Y.Offset, screenGui.AbsoluteSize.Y, scale)

	return UDim2.new(xScale, xOffset, yScale, yOffset)
end

function interface:updateMainFramePosition()
	if not self.mainFrame then return end

	if self.dock then
		self.dock:reflow()
	else
		self.mainFrame.Position = self:calculateMainFramePosition()
	end

	self:updateNotificationsPosition()
end

function interface:createMainScroll(mainFrame)
	local scrollBar = scrollBarComponent.new({
		isHorizontal = false,
		barThickness = 12,
	})

	local scrollBarFrame = scrollBar:create()
	local container = scrollBar.container

	local scrollHolder = createService.new("Frame", "ScrollHolder", mainFrame, {
		Size = UDim2.new(1, 0, 0, 180),
		Position = UDim2.fromScale(0.5, 1),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundTransparency = 1,
		Active = true,

		scrollBarFrame,
		container,
	})

	self.scrollHolder = scrollHolder
	self.scrollBar = scrollBar
	self.scrollContainer = container

	return scrollBar
end

function interface:createMainFrame()
	local elements = mainFrameComponent:create()
	local mainFrame = elements.mainFrame

	elements.titleLabel.Text = titleFormatter.getDisplayName()

	self.mainFrame = mainFrame
	self.topBar = elements.topBar
	self.buttons = elements.buttons

	assetsService:loadImage(self.buttons.settings, "settings")
	assetsService:loadImage(self.buttons.reference, "reference")

	connectionService:Connect(self.buttons.settings.Activated, function()
		print("clicked settings")
	end)

	self:createMainScroll(mainFrame)

	return mainFrame
end

function interface:createCommands()
	local scrollBar = self.scrollBar

	local commands = commandsComponent.new({
		scrolledSignal = scrollBar.scrolledSignal,
		scrollContainer = self.scrollContainer,
		scrollHolder = self.scrollHolder,
		scrollBar = scrollBar,

		configs = {
			placeholderText = frameworkSettings.ui.commands.placeholderText,
			padding = frameworkSettings.ui.commands.padding,
			labelSize = frameworkSettings.ui.commands.labelSize,
			textSize = frameworkSettings.ui.commands.textSize,
		},
	})

	logger:log("created commands interface")
	commands:create()

	logger:log("initialized commands")
	commands:createCommandsData()

	logger:log("awaked commands module")
	commands:awake()

	self.commands = commands
	return commands
end

function interface:createInfoMenu()
	return serverInfoComponent:create()
end

function interface:chatLogs(tab: string?)
	return chatLogsComponent:open(tab or "chat")
end

function interface:dragMainFrame(mainFrame)
	mainFrame.Size = frameworkSettings.ui.window.windowSize

	mainFrame.Position = UDim2.fromOffset(1e5, 1e5)
	mainFrame.Position = self:calculateMainFramePosition()

	self.dock = mainFrameDock.new({
		frame = mainFrame,
		screenGui = self.screenGui,
		topBarHeight = self.topBar.Size.Y.Offset,
		clampPosition = function(pos)
			return self:calculateMainFramePosition(pos)
		end,
		getScale = function()
			return scaleObject:getScale()
		end,
		onMinimize = function()
			self:releaseCommandFocus()
		end,
	})

	dragInstance:addGuiObject(mainFrame)

	dragInstance:setFilter(mainFrame, function(pos)
		return self.dock:clampDrag(pos)
	end)

	dragInstance.dragStarted:Connect(function(object)
		if object ~= mainFrame then return end

		self.dock:cancel()
		self.scrollBar:disableScroll()
	end)

	dragInstance.dragEnded:Connect(function(object, gesture)
		if object ~= mainFrame then return end

		self.scrollBar:enableScroll()
		self.dock:onDragEnded(gesture)
	end)
end

function interface:setKeepIY(enabled: boolean): boolean
	enabled = enabled == true
	
	if self.dock then
		self.dock:setKeepOpen(enabled)
	end
	
	if (settingsData:getValue(KEEP_IY_SETTING) == true) ~= enabled then
		settingsData:setValue(KEEP_IY_SETTING, enabled)
		settingsData:save()
	end
	
	return enabled
end

function interface:getKeepIY(): boolean
	return self.dock ~= nil and self.dock.keepOpen == true
end

function interface:setupKeepIY()
	self.dock:setKeepOpen(settingsData:getValue(KEEP_IY_SETTING) == true)
end

function interface:releaseCommandFocus()
	local searchBox = self.commands and self.commands.searchBox

	if searchBox and searchBox:IsFocused() then
		searchBox:ReleaseFocus()
	end
end

function interface:showWindow()
	if not self.mainFrame then return end

	self.mainFrame.Visible = true
	self.dock:reveal()
end

function interface:showCommandBar()
	local searchBox = self.commands and self.commands.searchBox
	if not searchBox then return end

	self:showWindow()

	self.dock:onSettled(function()
		if self.dock.state == "minimized" then return end
		
		if searchBox:IsFocused() then
			searchBox:ReleaseFocus()
		end
		searchBox:CaptureFocus()
	end)
end

function interface:createQuickCapture()
	if not isMobile then return end
	
	local quickCapture = createService.new("TextButton", tools.randomString(math.random(30, 50)), self.screenGui, {
		BackgroundTransparency = 0.14,
		Position = UDim2.fromScale(0.5, 0.05),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(0, 25, 0, 25),
		Font = Enum.Font.SourceSansBold,
		Text = "IY",
		TextSize = 16,
		ZIndex = 10,
		ThemeTag = {
			TextColor3 = "Colors.Icons",
			BackgroundColor3 = "Colors.Buttons.Default"
		},
		createService.new("UICorner", {
			CornerRadius = UDim.new(0.5, 0)
		}),
	})

	self.dock:addWindowPart(quickCapture)
	dragInstance:addGuiObject(quickCapture)
	
	connectionService:Connect(quickCapture.Activated, function()
		self:showCommandBar()
	end)

	self.quickCapture = quickCapture
	return quickCapture
end

function interface:createReference()
	local reference = referenceComponent.new()
	local referenceFrame = reference:create()

	assetsService:loadImage(reference.closeIcon, "close")

	referenceFrame.Parent = self.screenGui
	self.reference = reference

	connectionService:Connect(self.buttons.reference.Activated, function()
		reference:open()
	end)

	return reference
end

function interface:createNotifications()
	local container = notifier:getContainer(self.screenGui)
	self.notificationsContainer = container

	notifier.onLayoutChanged = function()
		self:updateNotificationsPosition()
	end

	self:updateNotificationsPosition()
	return container
end

function interface:updateNotificationsPosition()
	local container = self.notificationsContainer
	local mainFrame = self.mainFrame
	local screenGui = self.screenGui
	if not (container and mainFrame and screenGui) then return end

	local scale = scaleObject:getScale()
	local windowPos = mainFrame.AbsolutePosition / scale
	local windowSize = mainFrame.AbsoluteSize / scale
	local screenSize = screenGui.AbsoluteSize / scale

	local spot = notificationPlacement.compute({
		left = windowPos.X,
		top = windowPos.Y,
		right = windowPos.X + windowSize.X,
		bottom = windowPos.Y + windowSize.Y,
	}, {
		width = screenSize.X,
		height = screenSize.Y,
	}, {
		width = container.Size.X.Offset,
		height = notifier:getStackHeight(),
	}, notificationsConfig.gapToWindow)

	container.AnchorPoint = Vector2.new(spot.anchorX, 0)
	container.Position = UDim2.fromOffset(spot.x, spot.y)
end

function interface:destroy()
	notifier:destroy()
	if self.dock then
		self.dock:destroy()
		self.dock = nil
	end

	chatLogsComponent:reset()

	if self.screenGui then
		self.screenGui:Destroy()
	end

	self.screenGui = nil
	self.awoken = false
end

return interface