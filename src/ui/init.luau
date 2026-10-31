-- src/ui/init.luau

local frameworkSettings = require("../framework/settings")
local notificationsConfig = require("../framework/config/ui/notifier")
local privateEnv = require("../framework/environment/private")
local executorEnv = require("../framework/environment/executor")
local connectionService = require("../framework/services/connectionService")
local robloxServices = require("../framework/services/rbxServices")
local isMobile = require("../framework/environment/isMobile")

local playerService = require("../framework/services/playerService")

local settingsData = require("../storage/data/settings")
local logger = require("../utils/logger")
local tools = require("../utils/tools")

local createService = require("./services/createService")
local assetsService = require("./services/assetsService")
local themeService = require("./services/themeService")
local backgroundService = require("./services/backgroundService")

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
local settingsComponent = require("./components/settings")
local partPathComponent = require("./components/partpath")

local dragInstance = require("./utils/dragInstance")
local mainFrameDock = require("./utils/mainFrameDock")

local REFERENCE_SCREEN_HEIGHT = 450
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
	self:createQuickCapture()
	self:createReference()
	self:createPartPath()
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
	self.scrollBarFrame = scrollBarFrame

	return scrollBar
end

function interface:createMainFrame()
	local elements = mainFrameComponent:create()
	local mainFrame = elements.mainFrame

	elements.titleLabel.Text = titleFormatter.getDisplayName()

	self.mainFrame = mainFrame
	self.topBar = elements.topBar
	self.buttons = elements.buttons

	-- the custom background sits behind the window's contents (see ui/services/backgroundService)
	backgroundService:attach(mainFrame)

	assetsService:loadImage(self.buttons.settings, "lucide-settings")
	assetsService:loadImage(self.buttons.reference, "lucide-book-open")
	
	self:createMainScroll(mainFrame)

	self.settings = settingsComponent.new({
		-- the settings panel opened or closed: its button takes the Primary color while it is open
		onOpenChanged = function(open)
			self:paintTopButton(self.buttons.settings, open)
		end,

		-- a switch changed. The dock needs to know about keep menu open, and keep interface needs queueteleport
		onSwitch = function(setting, enabled)
			if setting == "keepMenuOpen" and self.dock then
				self.dock:setKeepOpen(enabled)
			end

			-- like the keepiy command: without queueteleport the switch can't do anything, so it goes back off
			if setting == "keepIY" and enabled and executorEnv.queueteleport == nil then
				self:setKeepIY(false)
				notifier:notify("Keepiy", "your exploit does not support queueteleport")
			end
		end,
	})
	self.settings:create(mainFrame, self.scrollHolder, { self.scrollContainer, self.scrollBarFrame })

	connectionService:Connect(self.buttons.settings.Activated, function()
		self.settings:toggle()
	end)

	return mainFrame
end

function interface:createCommands()
	local scrollBar = self.scrollBar

	local commands = commandsComponent.new({
		scrolledSignal = scrollBar.scrolledSignal,
		scrollContainer = self.scrollContainer,
		scrollHolder = self.scrollHolder,
		screenGui = self.screenGui,
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

	-- a command was sent: a swipe can minimize the window again (see dock:unlockSwipe)
	commands.onCommandSent = function()
		if self.dock then
			self.dock:unlockSwipe()
		end
	end

	-- using the command bar (focusing it, typing) keeps the automatic keep open alive (see dock:noteInteraction)
	commands.onInteraction = function()
		if self.dock then
			self.dock:noteInteraction()
		end
	end

	self.settings:watchCommandBar(commands.searchBox)
	
	if isMobile then
		-- a swipe down on the list, from its top, minimizes the window (the dock decides, see onListSwipeDown)
		commands.onSwipeDown = function()
			if self.dock then
				self.dock:onListSwipeDown()
			end
		end

		connectionService:Connect(commands.searchBox.Focused, function()
			self.commandBarUsedAt = os.clock()
		end)
		
		connectionService:Connect(commands.searchBox.FocusLost, function(enterPressed)
			self.commandBarUsedAt = os.clock()

			-- Enter minimizes the window when the character was being walked (see dock:onMobileEnter)
			if enterPressed and self.dock then
				self.dock:onMobileEnter(function()
					return commands.searchBox:IsFocused()
				end)
			end
		end)
	else
		-- PC: like the original IY (Cmdbar.FocusLost), the window minimizes when the command bar lets go of the focus
		connectionService:Connect(commands.searchBox.FocusLost, function(enterPressed)
			if self.dock then
				self.dock:onCommandBarClosed(enterPressed)
			end
		end)
	end

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
		keepOpen = settingsComponent.isKeepMenuOpen(),
		clampPosition = function(pos)
			return self:calculateMainFramePosition(pos)
		end,
		getScale = function()
			return scaleObject:getScale()
		end,
		commandBarInUse = function()
			return self:isCommandBarInUse()
		end,
		isMoving = function()
			return self:isCharacterMoving()
		end,
		onInteractive = function(enabled)
			if self.commands then
				self.commands:setInteractive(enabled)
			end
		end,
		hoverToOpen = not isMobile, -- PC: the pointer over the window opens it; mobile keeps taps
		onMinimize = function()
			self:releaseCommandFocus()

			-- a hidden window (hideiy) goes back to hidden instead of just minimizing
			if self.hidden then
				self:hideWindow()
			end
		end,
	})

	dragInstance:addGuiObject(mainFrame)

	dragInstance:setFilter(mainFrame, function(pos)
		return self.dock:clampDrag(pos)
	end)

	dragInstance.dragStarted:Connect(function(object)
		if object ~= mainFrame then return end

		self.dock:cancel()
		self.dock:setDragging(true)
		self.scrollBar:disableScroll()
	end)

	dragInstance.dragEnded:Connect(function(object, gesture)
		if object ~= mainFrame then return end

		self.scrollBar:enableScroll()
		self.dock:setDragging(false)
		self.dock:onDragEnded(gesture)
	end)
end

-- how long after the command bar loses focus a press outside still counts as using it (seconds)
local COMMAND_BAR_GRACE = 0.3

function interface:isCommandBarInUse(): boolean
	local searchBox = self.commands and self.commands.searchBox
	if searchBox and searchBox:IsFocused() then
		return true
	end

	return os.clock() - (self.commandBarUsedAt or 0) < COMMAND_BAR_GRACE
end

-- true while the character is moving: the movement keys or thumbstick, or a command (walkto, tween, fly...) moves it.
-- Sideways speed only, so falling and jumping do not count
function interface:isCharacterMoving(): boolean
	local humanoid = playerService:getHumanoid()
	if not humanoid then return false end

	if humanoid.MoveDirection.Magnitude > 0.05 then
		return true
	end

	local root = humanoid.RootPart
	if not root then return false end

	local velocity = root.AssemblyLinearVelocity
	return Vector3.new(velocity.X, 0, velocity.Z).Magnitude > 1
end

function interface:releaseCommandFocus()
	local searchBox = self.commands and self.commands.searchBox

	if searchBox and searchBox:IsFocused() then
		searchBox:ReleaseFocus()
	end
end

-- shows the window for good (showiy): it leaves the hidden state and stays up
function interface:showWindow()
	self.hidden = false
	self:revealWindow()
end

-- shows the window without leaving the hidden state: the command bar (IY button, prefix key) uses this.
-- A hidden window goes back to hidden on the next press outside (the dock's onMinimize)
function interface:revealWindow()
	if not self.mainFrame then return end

	self.mainFrame.Visible = true
	if self.dock then
		self.dock:reveal()
	end
end

-- hides the window (hideiy). It stays hidden until showWindow, like the original IY
function interface:hideWindow()
	if not self.mainFrame then return end

	self.hidden = true
	self.mainFrame.Visible = false

	if self.dock then
		self.dock:sleep()
	end

	self:releaseCommandFocus()
end

function interface:showCommandBar()
	local searchBox = self.commands and self.commands.searchBox
	if not searchBox then return end

	self:revealWindow()

	-- the window is still moving up (the prefix key can come right after a hidden window is shown), so the focus is
	-- asked for once it has arrived. ensureFocus keeps asking for a few frames, in case the first try is taken back
	self.dock:onSettled(function()
		if self.dock.state == "minimized" then return end

		self.commands:ensureFocus()
	end)
end

-- the keepiy command calls this (keepiy.enable / keepiy.disable): saves the flag and redraws the panel's switch
function interface:setKeepIY(enabled: boolean)
	settingsComponent.setKeepIY(enabled)

	if self.settings then
		self.settings:refresh()
	end
end

function interface:createQuickCapture()
	if not isMobile then return end
	
	local quickCapture = createService.new("TextButton", tools.randomString(math.random(30, 50)), self.screenGui, {
		BackgroundTransparency = 0.14,
		Position = UDim2.fromScale(0.5, 0.15),
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

-- a top bar button shows whether its window is open: the Primary color while it is, the icon color otherwise.
-- It goes through the theme service, so the theme change keeps it right
function interface:paintTopButton(button: GuiObject, active: boolean)
	if not button then return end

	themeService:addObject(button, {
		ImageColor3 = if active then "Colors.Primary" else "Colors.Icons",
	})
end

function interface:createReference()
	local reference = referenceComponent.new()
	local referenceFrame = reference:create()

	reference.onOpenChanged = function(open)
		self:paintTopButton(self.buttons.reference, open)
	end

	assetsService:loadImage(reference.closeIcon, "lucide-custom-x")

	referenceFrame.Parent = self.screenGui
	self.reference = reference

	connectionService:Connect(self.buttons.reference.Activated, function()
		reference:open()
	end)

	return reference
end

function interface:createPartPath()
	local partPathWindow = partPathComponent.new()
	local frame = partPathWindow:create()

	frame.Parent = self.screenGui
	self.partPathWindow = partPathWindow

	return partPathWindow
end

-- the partpath command calls this: shows the part window and starts selecting parts.
-- onSelectPart(part) runs when "Select Part" is pressed with a part chosen
function interface:openPartPath(onSelectPart)
	if not self.partPathWindow then return end

	self.partPathWindow:open(onSelectPart)
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

	-- The window is placed with UDim2, so the stack is placed with the same UDim2 values: it lines up with the
	-- window's edges whatever the UI scale is. The screen size (in logical units) is only used for the side and the room.
	local scale = scaleObject:getScale()
	local screenSize = screenGui.AbsoluteSize / scale

	local position = mainFrame.Position
	local spot = notificationPlacement.compute({
		x = { scale = position.X.Scale, offset = position.X.Offset },
		y = { scale = position.Y.Scale, offset = position.Y.Offset },
		width = mainFrame.Size.X.Offset,
		height = mainFrame.Size.Y.Offset,
	}, {
		width = screenSize.X,
		height = screenSize.Y,
	}, {
		width = container.Size.X.Offset,
	}, notificationsConfig.gapToWindow)

	-- the popups are fitted to the room the stack has from where it is anchored
	notifier:setRoom(spot.room)

	container.AnchorPoint = Vector2.new(spot.anchorX, spot.anchorY)
	container.Position = UDim2.new(spot.x.scale, spot.x.offset, spot.y.scale, spot.y.offset)
end

function interface:destroy()
	notifier:destroy()
	if self.dock then
		self.dock:destroy()
		self.dock = nil
	end

	chatLogsComponent:reset()

	if self.partPathWindow then
		self.partPathWindow:destroy()
		self.partPathWindow = nil
	end

	if self.screenGui then
		self.screenGui:Destroy()
	end

	self.screenGui = nil
	self.awoken = false
end

return interface