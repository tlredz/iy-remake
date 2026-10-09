-- src/ui/init.luau

local frameworkSettings = require("../framework/settings")
local privateEnv = require("../framework/environment/private")
local connectionService = require("../framework/services/connectionService")

local settingsData = require("../storage/data/settings")
local logger = require("../utils/logger")
local tools = require("../utils/tools")

local createService = require("./services/createService")
local assetsService = require("./services/assetsService")
local themeService = require("./services/themeService")
local dragService = require("./services/dragService")
local themes = require("./themes")
local coreGui = require("./coreGui")
local notifier = require("./notifier")
local notificationsConfig = require("../framework/config/notifier")

local titleFormatter = require("./utils/titleFormatter")
local scaleObject = require("./utils/scaleObject")

local mainFrameComponent = require("./components/mainFrame")
local scrollBarComponent = require("./components/scrollBar")
local commandsComponent = require("./components/commands")
local referenceComponent = require("./components/reference")
local serverInfoComponent = require("./components/serverInfo")

local uiScale = scaleObject.uiScale

local interface = {}

local function resolveTheme(name)
	local theme = type(name) == "string" and themes[name:lower()]
	
	if theme and theme.Colors and theme.Font then
		return name
	end
	
	return frameworkSettings.theme.defaultTheme
end

function interface:createScreenGui()
	local screenGui = createService.new("ScreenGui", {
		IgnoreGuiInset = true,
		Name = tools.randomString(math.random(30, 50)),
		DisplayOrder = (2 ^ 31) - 1
	})
	
	self.screenGui = screenGui
	return screenGui
end

function interface:calculateScale(newScale)
	return (self.screenGui.AbsoluteSize.Y / 450) * newScale
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

local function clampAxis(udim, sizeOffset, screenPx, scale)
	local current = (udim.Scale * screenPx) / scale + udim.Offset
	local maxInt = math.floor(screenPx / scale - sizeOffset)

	if math.floor(current) >= maxInt then
		return 1, -sizeOffset
	end

	return 0, math.clamp(math.floor(current), 0, math.max(maxInt, 0))
end

function interface:calculateMainFramePosition()
	local mainFrame = self.mainFrame
	local screenGui = self.screenGui
	local scale = uiScale.Scale
	local pos = mainFrame.Position
	local size = mainFrame.Size

	local xScale, xOffset = clampAxis(pos.X, size.X.Offset, screenGui.AbsoluteSize.X, scale)
	local yScale, yOffset = clampAxis(pos.Y, size.Y.Offset, screenGui.AbsoluteSize.Y, scale)
	
	-- REPLACE THIS LINE IN THE FURUTE
	task.defer(self.updateNotificationsPosition, self)

	return UDim2.new(xScale, xOffset, yScale, yOffset)
end

--[[function interface:calculateMainFramePosition()
	local mainFrame = self.mainFrame
	local screenGui = self.screenGui
	
	local size = mainFrame.Size
	local position = mainFrame.Position
	local scale = scaleObject:getScale()
	
	local realWidth = math.ceil(screenGui.AbsoluteSize.X / scale)
	local realHeight = math.ceil(screenGui.AbsoluteSize.Y / scale)
	
	-- REPLACE THIS LINE IN THE FURUTE
	task.defer(self.updateNotificationsPosition, self)
	
	task.spawn(function()
		local RunService = game:GetService("RunService")
		
		RunService.Heartbeat:Wait()
		RunService.Heartbeat:Wait()
		
		local s = uiScale.Scale
		local W = screenGui.AbsoluteSize.X
		local abs = mainFrame.AbsolutePosition
		local absSize = mainFrame.AbsoluteSize
		
		print("scale:", s)
		print("tela X:", W, "| frame X:", abs.X, "| frame W:", absSize.X)
		print("gap direita (px):", W - (abs.X + absSize.X))
		print("offset X atual:", mainFrame.Position.X.Offset, "| esperado:", W / s - mainFrame.Size.X.Offset)
	end)
	
	return UDim2.fromOffset(
		math.clamp(position.X.Offset, 0, math.max(realWidth - size.X.Offset, 0)),
		math.clamp(position.Y.Offset, 0, math.max(realHeight - size.Y.Offset, 0))
	)
end]]

function interface:updateMainFramePosition()
	if self.mainFrame then
		self.mainFrame.Position = self:calculateMainFramePosition()
	end
end

function interface:createMainScroll(mainFrame)
	local scrollBar = scrollBarComponent.new({
		isHorizontal = false,
		barThickness = 12
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
		container
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
			textSize = frameworkSettings.ui.commands.textSize
		}
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

function interface:dragMainFrame(mainFrame)
	local dragInstance = dragService.new(uiScale)
	
	mainFrame.Size = frameworkSettings.ui.window.windowSize
	mainFrame.Position = UDim2.fromOffset(1e5, 1e5)
	mainFrame.Position = self:calculateMainFramePosition()
	
	dragInstance:addGuiObject(mainFrame)
	
	dragInstance:setFilter(mainFrame, function(pos)
		mainFrame.Position = pos
		return self:calculateMainFramePosition()
	end)
	
	dragInstance.dragStarted:Connect(function(object)
		if object ~= mainFrame then return end
		self.scrollBar:disableScroll()
	end)
	
	dragInstance.dragEnded:Connect(function(object)
		if object ~= mainFrame then return end
		self.scrollBar:enableScroll()
	end)
	
	self.dragService = dragInstance
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
	return container
end

function interface:updateNotificationsPosition()
	local container = self.notificationsContainer
	local mainFrame = self.mainFrame
	local screenGui = self.screenGui
	if not (container and mainFrame and screenGui) then return end

	local scale = scaleObject:getScale()
	local screenWidth = math.ceil(screenGui.AbsoluteSize.X / scale)
	local screenHeight = math.ceil(screenGui.AbsoluteSize.Y / scale)

	local gap = notificationsConfig.gapToWindow
	local width = container.Size.X.Offset
	
	local windowLeft = mainFrame.AbsolutePosition.X / scale
	local windowRight = windowLeft + mainFrame.Size.X.Offset
	local windowTop = mainFrame.AbsolutePosition.Y / scale
	local windowBottom = windowTop + mainFrame.Size.Y.Offset

	local roomRight = screenWidth - windowRight - gap
	local roomLeft = windowLeft - gap

	local onRight
	if roomRight >= width then
		onRight = true
	elseif roomLeft >= width then
		onRight = false
	else
		onRight = roomRight >= roomLeft
	end

	local growsUp = (windowTop + mainFrame.Size.Y.Offset / 2) > screenHeight / 2

	local x = onRight and (windowRight + gap) or (windowLeft - gap)
	local y = growsUp and windowBottom or windowTop

	container.AnchorPoint = Vector2.new(onRight and 0 or 1, growsUp and 1 or 0)
	container.Position = UDim2.fromOffset(x, y)
end

function interface:destroy()
	if self.screenGui then
		self.screenGui:Destroy()
	end
end

function interface:init()
	logger:debug("interface: initializing theme service")
	themeService:init({
		theme = resolveTheme(frameworkSettings.theme.selectedTheme)
	})
	
	local screenGui = self:createScreenGui()
	
	-- parenteia antes do setScale: o AbsoluteSize só é válido depois de parentear
	screenGui.Parent = coreGui
	privateEnv.screenGui = screenGui
	
	uiScale.Parent = screenGui
	self:setScale(settingsData:getValue("interface.uiScale") or 1)
	
	local mainFrame = self:createMainFrame()
	
	self:createCommands()
	self:dragMainFrame(mainFrame)
	self.commands:enable()
	
	mainFrame.Parent = screenGui
	self:createReference()
	self:createNotifications()
	
	return screenGui
end

return interface
