local executorEnv = require("../config/executorEnv")
local privateEnv = require("../config/privateEnv")

local logger = require("../utils/logger")
local tools = require("../utils/tools")

local assetsController = require("../controllers/assetsController")
local connectionService = require("../services/connectionService")
local robloxServices = require("../services/robloxServices")
local createService = require("../services/createService")
local tweenService = require("../services/tweenService")
local dragService = require("../services/dragService")

local iyConfig = require("../config/iy")
local emojis = require("../config/emojis")

local scaleObject = require("./scaleObject")
local uiScale = scaleObject.uiScale

local scrollBarComponent = require("./components/scrollBar")
local commandsComponent = require("./components/commands")
local codeBoxComponent = require("./components/codeBox")
local infoComponent = require("./components/codeBox")

local infiniteYield = {}

local function getEasterDate()
	local year = tonumber(os.date("%Y"))   -- current year

	-- Constants based on the year
	local century = math.floor(year / 100)
	local correction = math.floor((13 + 8 * century) / 25)
	local solarCorrection = (15 - correction + century - math.floor(century / 4)) % 30
	local lunarCorrection = (4 + century - math.floor(century / 4)) % 7

	-- Epact and related terms
	local epact = (19 * (year % 19) + solarCorrection) % 30
	local daysToAdd = (2 * (year % 4) + 4 * (year % 7) + 6 * epact + lunarCorrection) % 7
	local paschalFullMoon = 22 + epact + daysToAdd

	-- Special exceptions for certain years
	if epact == 29 and daysToAdd == 6 then
		return "04 19"   -- April 19
	elseif epact == 28 and daysToAdd == 6 then
		return "04 18"   -- April 18
	end

	-- Determine month and day
	if paschalFullMoon > 31 then
		return ("04 %02d"):format(paschalFullMoon - 31)   -- April
	end

	return ("03 %02d"):format(paschalFullMoon)   -- March
end

local function getHolidayEmoji()
	local holidays = {
		["01 01"] = emojis["NEW_YEAR"],
		["02 14"] = emojis["VALENTINE_DAYS"],
		["03 17"] = emojis["CLOVER"],
		["10 31"] = emojis["HALLOWEEN"],
		["12 25"] = emojis["CHRISTMAS"],
		[getEasterDate()] = emojis["EASTER"]
	}
	
	-- table.foreach(holidays, print)
	
	local date = os.date("%m %d")
	return holidays[date]
end

local function getDisplayName()
	local displayName = iyConfig.displayName
	displayName = displayName:gsub("!VERSION", iyConfig.version)
	
	local holidayEmoji = getHolidayEmoji()
	
	if holidayEmoji then
		displayName = `{holidayEmoji} {displayName} {holidayEmoji}`
	end
	
	return displayName
end

function infiniteYield:getProtectedFolder()
	local coreGui = robloxServices.CoreGui

	if executorEnv.gethui then
		local success, hiddenUI = pcall(executorEnv.gethui)
		
		if success and typeof(hiddenUI) == "Instance" then
			coreGui = hiddenUI
		end
	end
	
	if coreGui == robloxServices.CoreGui then
		coreGui = coreGui:FindFirstChild("RobloxGui") or coreGui
	end
	
	return coreGui
end

function infiniteYield:createCommands()
	local scrollHolder = self.scrollHolder
	local scrollBar = self.scrollBar
	
	local commands = commandsComponent.new({
		scrolledSignal = scrollBar.scrolledSignal,
		scrollContainer = self.scrollContainer,
		scrollHolder = scrollHolder,
		scrollBar = scrollBar
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

function infiniteYield:createMainScroll(mainFrame)
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
		container,
		
		--[[ThemeTag = {
			BackgroundColor3 = "Colors.Background"
		}]]
	})
	
	self.scrollHolder = scrollHolder
	self.scrollBar = scrollBar
	self.scrollContainer = container
	-- container.Transparency = 0.5
	
	return scrollBar
end

function infiniteYield:createMainFrame()
	local mainFrame = createService.new("Frame", "MainFrame", {
		Active = true,
		BorderSizePixel = 0,
		ThemeTag = {
			BackgroundColor3 = "Colors.Background"
		},
		createService.new("Frame", "TopBar", {
			Size = UDim2.fromOffset(250, 20),
			BorderSizePixel = 0,
			ThemeTag = {
				BackgroundColor3 = "Colors.Background"
			}
		})
		--[[createService.new("TextLabel", "Title", {
			Font = Enum.Font.SourceSans,
			TextSize = 18,
		})]]
	})
	
	local topBar = mainFrame.TopBar
	
	local title = createService.new("TextLabel", "Title", topBar, {
		Text = getDisplayName(),
		-- TextXAlignment = Enum.TextXAlignment.Center,
		-- Position = UDim2.new(0, 10, 0.5, 0),
		-- AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		TextSize = 16,
		ThemeTag = {
			TextColor3 = "Colors.Text.Default",
			Font = "Font.Normal"
		}
	})
	
	local settingsButton = createService.new("ImageButton", topBar, {
		Name = "SettingsButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -2, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.fromOffset(19, 19),
		ThemeTag = {
			ImageColor3 = "Colors.Icons"
		}
	})
	
	local referenceButton = createService.new("ImageButton", topBar, {
		Name = "ReferenceButton",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -22, 0.5, 0),
		AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.fromOffset(15, 15),
		ThemeTag = {
			ImageColor3 = "Colors.Icons"
		}
	})
	
	assetsController:loadImage(settingsButton, "settings")
	assetsController:loadImage(referenceButton, "reference")
	
	connectionService:Connect(settingsButton.Activated, function()
		print("clicked settings")
	end)
	
	connectionService:Connect(referenceButton.Activated, function()
		print("clicked reference")
	end)
	
	self:createMainScroll(mainFrame)
	
	--[[local subTitle = createService("TextLabel", "SubTitle", Title, {
		
	})]]
	
	return mainFrame
end

function infiniteYield:calculateScale(newScale)
	return (self.screenGui.AbsoluteSize.Y / 450) * newScale
end

function infiniteYield:setScale(newScale)
	newScale = math.abs(newScale)
	
	if newScale >= 3 then
		newScale = self:calculateScale(newScale)
	end
	
	scaleObject:setScale(newScale)
end

function infiniteYield:calculateMainFramePosition()
	local mainFrame = self.mainFrame
	local screenGui = self.screenGui
	
	local size = mainFrame.Size
	local position = mainFrame.Position
	local scale = scaleObject:getScale()
	
	local realWidth = mainFrame.AbsoluteSize.X
	local realHeight = mainFrame.AbsoluteSize.Y
	
	local maxBoundX = screenGui.AbsoluteSize.X - realWidth
	local maxBoundY = screenGui.AbsoluteSize.Y - realHeight

	return UDim2.new(
		1, math.clamp(position.X.Offset, -math.max(0, maxBoundX), 9e9),
		1, math.clamp(position.Y.Offset, -math.max(0, maxBoundY), 9e9)
	)
end

function infiniteYield:dragMainFrame(mainFrame)
	local dragInstance = dragService.new(uiScale)
	
	local screenGui = self.screenGui
	local scale = scaleObject:getScale()
	
	local windowConfig = iyConfig.window
	local windowSize = windowConfig.windowSize
	
	-- print(screenGui.AbsoluteSize.X, screenGui.AbsoluteSize.Y)
	
	mainFrame.Size = windowSize
	mainFrame.Position = UDim2.new(
		1, -windowSize.X.Offset,
		1, -windowSize.Y.Offset
	)
	
	-- print("absolute:", screenGui.AbsoluteSize)
	-- print("pos:", mainFrame.Position)
	
	dragInstance:addGuiObject(mainFrame)
	
	--[[dragInstance:setFilter(mainFrame, function(pos)
		mainFrame.Position = pos
		return self:calculateMainFramePosition()
	end)]]
	
	self.dragService = dragInstance
end

function infiniteYield:create()
	local maxDisplayOrder = (2 ^ 31) - 1
	
	local screenGui = tools.simpleCreate("ScreenGui", {
		IgnoreGuiInset = true,
		Name = tools.randomString(math.random(30, 50)),
		DisplayOrder = maxDisplayOrder
	})
	
	screenGui.Parent = self:getProtectedFolder()
	self.screenGui = screenGui
	
	local mainFrame = self:createMainFrame()
	self.mainFrame = mainFrame
	
	-- mainFrame.Title.Text = getDisplayName()
	-- print(mainFrame.Title.Text)
	
	self:createCommands()
	
	self:dragMainFrame(mainFrame)
	
	self.commands:enable()
	
	uiScale.Scale = self:calculateScale(1)
	uiScale.Parent = screenGui
	
	mainFrame.Parent = screenGui
	privateEnv.screenGui = screenGui
	
	return screenGui
end

return infiniteYield