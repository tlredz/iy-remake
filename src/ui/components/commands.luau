local connectionService = require("../../framework/services/connectionService")
local robloxServices    = require("../../framework/services/rbxServices")
local playerService     = require("../../framework/services/playerService")
local createService     = require("../services/createService")
local commandData       = require("../../commands/systems/commandData")

local commandsController = require("../../commands/controllers/commandsController")
local commandParser      = require("../../commands/systems/commandParser")
local argsManager        = require("../../commands/systems/argsManager")

local inputConfig  = require("../../framework/config/input")
local commandsList = require("../../commands/list")

local signal      = require("../../utils/signal")
local logger      = require("../../utils/logger")
local tools       = require("../../utils/tools")
local scaleObject = require("../utils/scaleObject")

local settingsData = require("../../storage/data/settings")
local cmdsColors = require("../../framework/config/colors").commands

local userInputService = robloxServices.UserInputService
local runService       = robloxServices.RunService

local richFontSize     = tools.richFontSize
local colorFromRGB     = tools.colorFromRGB

local commands = {}
commands.__index = commands

local function isValidInputType(input)
	return inputConfig.pressingInputs[input.UserInputType] ~= nil
end

local function getCommand(commandName)
	return commandsList.lookup[commandName]
end

local function zerofloor(number)
	return math[(number < 0) and "ceil" or "floor"](number)
end

local function cleanInput(text)
	text = text:gsub("[\r\n]+$", "")
	text = text:gsub("[\r\n]+", " ")
	return text
end

function commands:refresh(text)
	local parsed = self.parser:parse(text)
	self.parser:highlight(parsed)
	
	self:updateSearchBoxHighlight()
	self:updateSearchedCommand()
end

function commands:applyCorrection()
	local cmdInput   = self.commandInput
	local correction = cmdInput.correction
	local raw        = cmdInput.rawText
	
	local newText = raw:sub(1, correction.from - 1) .. correction.text .. raw:sub(correction.to + 1)
	
	if settingsData:getValue("spaceAfterCorrection") then
		newText ..= " "
	end
	
	self.searchBox.Text = newText
end

function commands:awake()
	local cmdInput     = self.commandInput
	local searchBox    = self.searchBox
	local searchHolder = self.searchBoxHolder
	local marker       = self.inputMarker
	
	local placeholder = searchHolder.Placeholder
	
	local textChangedSignal = searchBox:GetPropertyChangedSignal("Text")
	
	local lastUpdatedMarker = 0
	
	local function updateMarker()
		if (tick() - lastUpdatedMarker) > 0.5 then
			marker.Visible = not marker.Visible
			lastUpdatedMarker = tick()
		end
	end
	
	local function closeSearchBox()
		if searchBox:IsFocused() then
			searchBox:ReleaseFocus()
		end
	end
	
	local function captureFocus()
		searchBox:CaptureFocus()
	end
	
	-- Returns true when a suggestion was applied and the input should keep focus.
	local function onEnterPressed()
		if cmdInput.correction then
			self:applyCorrection()
			task.defer(captureFocus)
			return true
		end
		
		-- shows the reason when the command can't run
		self:sendInputCommand()
		return false
	end
	
	local function updatePlaceholder()
		local visible = not searchBox:IsFocused() and #searchBox.Text == 0
		placeholder.Visible = visible
	end
	
	self.commandClickedSignal:Connect(function(data)
		searchBox.Text = data.aliases[1]
		task.defer(captureFocus)
	end)
	
	connectionService:Connect(searchHolder.Activated, captureFocus)
	
	connectionService:Connect(searchBox.Focused, function()
		updatePlaceholder()
		self.markerConnection = connectionService:Connect(runService.Stepped, updateMarker)
		
		if #searchBox.Text == 0 then
			self:setComment("")
		end
	end)
	
	connectionService:Connect(searchBox.FocusLost, function(enterPressed)
		updatePlaceholder()
		marker.Visible = true
		connectionService:disconnect(self.markerConnection)
		
		if enterPressed then
			self:refresh(cleanInput(searchBox.Text))
			onEnterPressed()
		end
	end)
	
	connectionService:Connect(textChangedSignal, function()
		local text = searchBox.Text
		local isEnter = text:sub(-1) == "\n" or text:sub(-1) == "\r"
		
		if text:find("[\r\n]") then
			text = cleanInput(text)
			searchBox.Text = text
			
			if isEnter then
				self:refresh(text)
				
				if not onEnterPressed() then
					closeSearchBox()
				end
				return
			end
		end
		
		updatePlaceholder()
		self:refresh(text)
	end)
end

function commands:sendInputCommand()
	local cmdInput = self.commandInput
	
	if cmdInput.runError then
		self:setComment(cmdInput.runError, "error")
		return
	end
	
	local cmdData = cmdInput.commandData
	if not cmdData then return end
	
	local name = cmdData.name
	
	local success, failure = pcall(function()
		local args = argsManager.new(cmdInput.args)
		return commandsController:run(name, args)
	end)
	
	if settingsData:getValue("clearOnEnter") then
		self.searchBox.Text = ""
	end
	
	if not success then
		self:setComment(`failed - {failure}`, "error")
		logger:error(`failed to run command '{name}': {failure}`)
	end
end

function commands:create()
	self.searchBoxHolder = createService.new("ImageButton", {
		Size         = UDim2.new(1, -10, 0, 18),
		Position     = UDim2.fromScale(0.5, 0),
		AnchorPoint  = Vector2.new(0.5, 1),
		BorderSizePixel  = 0,
		ClipsDescendants = true,
		ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
		
		createService.new("UICorner", { CornerRadius = UDim.new(0, 6) }),
		
		createService.new("TextLabel", "Input", {
			Size             = UDim2.fromScale(0, 1),
			Position         = UDim2.new(0, 5, 0.5, 0),
			AnchorPoint      = Vector2.new(0, 0.5),
			TextXAlignment   = Enum.TextXAlignment.Left,
			TextYAlignment   = Enum.TextYAlignment.Center,
			AutomaticSize    = Enum.AutomaticSize.X,
			BackgroundTransparency = 1,
			TextSize         = self.configs.textSize,
			Visible          = false,
			RichText         = true,
			ThemeTag = {
				TextColor3 = "Colors.Text.Default",
				Font       = "Font.MonoSpace"
			},
			createService.new("Frame", "Holder", {
				Size     = UDim2.fromScale(0, 1),
				Position = UDim2.fromScale(1, 0)
			}),
		}),

		createService.new("TextLabel", "Placeholder", {
			Size           = UDim2.new(1, -5, 1, 0),
			Position       = UDim2.new(0, 5, 0.5, 0),
			AnchorPoint    = Vector2.new(0, 0.5),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			BackgroundTransparency = 1,
			TextSize       = self.configs.textSize - 1,
			Text           = self.configs.placeholderText,
			ThemeTag = {
				TextColor3 = "Colors.Text.Dark",
				Font       = "Font.MonoSpace"
			},
		}),
	})
	
	local searchHolder = self.searchBoxHolder
	local inputHolder = searchHolder.Input.Holder

	self.inputMarker = createService.new("Frame", "Marker", inputHolder, {
		Size        = UDim2.new(0, 1.5, 1, -3),
		Position    = UDim2.new(1, 0.2, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		BorderSizePixel = 0,
		Visible     = false,
		ThemeTag    = { BackgroundColor3 = "Colors.Primary" }
	})
	
	self.inputComment = createService.new("TextLabel", "Comment", inputHolder, {
		Size           = UDim2.fromScale(1, 1),
		Position       = UDim2.fromScale(1, 0.5),
		AnchorPoint    = Vector2.new(0, 0.5),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		BackgroundTransparency = 1,
		TextSize       = self.configs.textSize,
		RichText       = true,
		Text           = "",
		ThemeTag = {
			TextColor3 = "Colors.Text.Default",
			Font       = "Font.MonoSpace"
		}
	})
	
	self.commandInfo = createService.new("TextLabel", "Info", {
		Size = UDim2.new(1, -25, 0, 0),
		Position = UDim2.new(0, 10, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		TextYAlignment = Enum.TextYAlignment.Center,
		TextXAlignment = Enum.TextXAlignment.Left,
		Font = self.configs.textFont,
		TextSize = self.configs.textSize - 5,
		Visible = false,
		createService.new("UICorner", {
			CornerRadius = UDim.new(0, 4)
		}),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
			TextColor3 = "Colors.Text.Default"
		}
	})
	
	self.searchBox = createService.new("TextBox", "SearchBox", {
		BackgroundTransparency = 1,
		TextTransparency       = 1,
		Size                   = UDim2.fromScale(1, 0),
		Position               = UDim2.fromScale(0, 0.4),
		ClearTextOnFocus       = false,
		ShowNativeInput        = false,
		TextSize               = 0,
		Text                   = "",
		MultiLine              = true
	})
	
	self.commandsFolder = createService.new("Folder", "Commands")
end

function commands:createCommandsData()
	for pos, command in commandsList.original do
		local cmdData = commandData.new(command)
		command.commandData  = cmdData
		cmdData.position     = pos - 1
		table.insert(self.commandsData, cmdData)
	end
end

function commands:updateSearchBoxHighlight()
	local text         = self.commandInput.highlightText
	local searchHolder = self.searchBoxHolder
	local input        = searchHolder.Input
	local scale        = scaleObject:getScale()
	
	input.Text    = text
	input.Visible = #text > 0
	
	local totalHolderWidth   = searchHolder.AbsoluteSize.X * scale
	local halfHolderWidth    = totalHolderWidth / 2
	local currentInputWidth  = input.AbsoluteSize.X * scale
	
	if currentInputWidth <= halfHolderWidth then
		input.AnchorPoint = Vector2.new(0, 0.5)
		input.Position    = UDim2.new(0, 5, 0.5, 0)
	else
		input.AnchorPoint = Vector2.new(1, 0.5)
		input.Position    = UDim2.new(0.5, 0, 0.5, 0)
	end
end

function commands:updateSearchedCommand()
	local bestMatch   = self.commandInput.bestMatch
	local commandName = self.commandInput.commandName
	if commandName == "" then return end

	local command = getCommand(commandName)
		or (bestMatch and getCommand(bestMatch))

	if command then
		self.scrollBar:scrollTo(command.commandData.position)
	end
end

function commands:setComment(text, color)
	if color ~= nil then
		text = commandParser.colorFromName(text, color)
	end
	
	self.inputComment.Text    = text
	self.inputComment.Visible = #text > 0
end

function commands:updateElementColor(element, elementPos)
	local transparency = if elementPos % 2 == 1 then 1 else 0.96
	element.BackgroundTransparency = transparency
end

function commands:updateElements()
	local elementPos     = 0
	local longestCommand = 0
	local visibleCommands = {}
	local scrollBar       = self.scrollBar
	local commandsFolder  = self.commandsFolder

	for pos, cmdData in self.commandsData do
		local isVisible = scrollBar:isVisible(cmdData.position)
		
		if not isVisible then
			if cmdData.element then cmdData.element.Parent = nil end
			continue
		end
		
		local element = cmdData.element
		if not element then
			element = self:createCommandElement(cmdData)
			cmdData.element = element
		end
		
		if not cmdData.isSection then
			if #cmdData.args > 0 and #cmdData.name > longestCommand then
				longestCommand = #cmdData.name
			end
			table.insert(visibleCommands, cmdData)
		end
		
		self:updateElementColor(element, pos)
		element.Parent   = commandsFolder
		element.Position = UDim2.fromOffset(
			0,
			elementPos * (element.Size.Y.Offset + self.configs.padding)
		)
		elementPos += 1
	end
	
	for key, cmdData in visibleCommands do
		self:updateDisplayName(cmdData, longestCommand + 3)
	end
	
	self.visibleCommands = visibleCommands
end

function commands:setCommandInfo(text)
	text = text or ""
	
	if text == "" then
		self.commandInfo.Visible = false
		return
	end
	
	self.commandInfo.Visible = true
	self.commandInfo.Text = text
end

function commands:createSection(data)
    -- table.foreach(data, print)
    
    local sectionLabel = createService.new("TextLabel", "Command", {
		Size                = UDim2.fromScale(1, 1),
		Position            = UDim2.fromOffset(5, 0),
		BackgroundTransparency = 1,
		TextXAlignment      = Enum.TextXAlignment.Left,
		TextYAlignment      = Enum.TextYAlignment.Bottom,
		RichText            = true,
		TextSize            = self.configs.textSize - 3,
		Text                = `<b>#{data.sectionName}</b>`,
		ThemeTag = {
			TextColor3 = "Colors.Text.Darker",
			Font       = "Font.MonoSpace"
		},
	})
    
	return createService.new("Frame", {
		Size = UDim2.new(1, -10, 0, self.configs.labelSize),
		BackgroundTransparency = 1,
		
		sectionLabel
	})
end

function commands:createCommandElement(data)
	if data.isSection then
		return self:createSection(data)
	end

	local commandLabel = createService.new("TextLabel", "Command", {
		Size                = UDim2.fromScale(0, 1),
		Position            = UDim2.fromOffset(5, 0),
		BackgroundTransparency = 1,
		TextXAlignment      = Enum.TextXAlignment.Left,
		AutomaticSize       = Enum.AutomaticSize.X,
		RichText            = true,
		TextSize            = self.configs.textSize,
		ThemeTag = {
			TextColor3 = "Colors.Text.Default",
			Font       = "Font.MonoSpace"
		},
	})

	return createService.new("Frame", {
		Size                = UDim2.new(1, 0, 0, self.configs.labelSize),
		AutomaticSize       = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		commandLabel
	})
end

function commands:createCommandDescription(data)
	if data.isSection then return end
	if not data.description then return end
	
	local descriptionLabel = createService.new("TextLabel", "Description", {
		Size               = UDim2.fromScale(1, 1),
		Position           = UDim2.fromOffset(25, 0),
		BackgroundTransparency = 1,
		TextXAlignment     = Enum.TextXAlignment.Left,
		RichText           = true,
		TextSize           = self.configs.textSize,
		ThemeTag = {
			TextColor3 = "Colors.Text.Dark",
			Font       = "Font.MonoSpace"
		},
	})
	
	return createService.new("Frame", "Description", {
		Size = UDim2.new(1, -30, 0, self.configs.labelSize),
		BackgroundTransparency = 1,
		descriptionLabel
	})
end

function commands:getCommandColor(cmdName, cmdData)
	local command = getCommand(cmdName)
	
	local colorName =
		if type(command.run) ~= "function" then "undefined"
		elseif cmdData.isClient then "client"
		elseif cmdData.isDeprecated then "deprecated"
		else nil
	
	if colorName ~= nil then
		cmdName = colorFromRGB(cmdName, cmdsColors[colorName])
	end
	
	return cmdName
end

function commands:updateDisplayName(cmdData, spaceBeforeArgs)
	local element     = cmdData.element
	local commandName = cmdData.name
	
	local spaces      = string.rep("—", (spaceBeforeArgs - #commandName) - 2)
	
	commandName = self:getCommandColor(commandName, cmdData)
	local displayName = `{commandName} {commandParser.colorFromName(spaces, "comment")} `
	
	local argsText = self.parser:highlightArgsType(cmdData.args)
	local text = displayName .. argsText
	
	if cmdData.isHolding then
		cmdData.originalText = text
	else
		self:setCommandText(cmdData, text)
	end
end

function commands:setCommandText(cmdData, text)
	local element = cmdData.element
	if not element then return end
	
	element.Command.Text = text
end

function commands:getCommandText(cmdData)
	local element = cmdData.element
	return element and element.Command.Text or ""
end

function commands:calculateTotalSpace()
	return #self.commandsData
end

function commands:calculateVisibleSpace()
	local scrollSize = self.scrollContainer.AbsoluteSize.Y -- * scaleObject:getScale()
	return math.floor(scrollSize / self:calculateLabelSize())
end

function commands:calculateLabelSize()
	return self.configs.padding + self.configs.labelSize
end

function commands:getElementMouseIn()
	for _, data in self.visibleCommands do
		if playerService:isMouseInGuiObject(data.element) then
			return data
		end
	end
end

function commands:horizontalScroll(xOffset)
	for _, cmdData in self.visibleCommands do
		local element = cmdData.element
		
		element.Position = UDim2.fromOffset(
			math.min(element.Position.X.Offset + xOffset, 0),
			element.Position.Y.Offset
		)
	end
end

function commands:startedHoldingContainer(input)
	if not isValidInputType(input) then return end
	if self.scrollBar:isScrollBarDisabled() then return end

	self.scrollAxis = nil
	self.scrollBar:disableScroll()

	local playerMouse = playerService:getMouse()
	local lblSize     = self:calculateLabelSize()
	local cmdData     = self:getElementMouseIn()
	local clickedAt   = tick()
	
	if cmdData and cmdData.description then
		cmdData.isHolding = true
		
		local desc = self.parser.colorFromName(cmdData.description, "comment")
		
		cmdData.originalText = self:getCommandText(cmdData)
		self:setCommandText(cmdData, desc)
	end
	
	local lastMouseY = playerMouse.Y
	local lastMouseX = playerMouse.X

	local mouseEvent, releaseEvent

	local function disconnect()
		self.scrollBar:enableScroll()
		
		if cmdData then
			cmdData.isHolding = nil
			
			if cmdData.originalText then
				self:setCommandText(cmdData, cmdData.originalText)
				cmdData.originalText = nil
			end
			
			if (tick() - clickedAt) <= 0.15 then
				self.commandClickedSignal:Fire(cmdData)
			end
		end
		
		if releaseEvent then releaseEvent:Disconnect() end
		if mouseEvent   then mouseEvent:Disconnect()   end
	end

	releaseEvent = connectionService:Connect(userInputService.InputEnded, function(inp)
		if not isValidInputType(inp) then return end
		disconnect()
	end)
	
	mouseEvent = connectionService:Connect(userInputService.InputChanged, function(inp)
		if not isValidInputType(inp) then return end
		
		local deltaX = playerMouse.X - lastMouseX
		local deltaY = playerMouse.Y - lastMouseY
		
		if not self.scrollAxis then
			if math.abs(deltaX) > 4 or math.abs(deltaY) > 4 then
				self.scrollAxis = math.abs(deltaX) > math.abs(deltaY) and "x" or "y"
			end
			return
		end
		
		if self.scrollAxis == "x" then
			local xOffset = zerofloor(deltaX / 3)
			if math.floor(xOffset) ~= 0 then
				self:horizontalScroll(xOffset)
				lastMouseX = playerMouse.X
			end
		else
			local yOffset = zerofloor(deltaY / lblSize)
			if math.floor(yOffset) ~= 0 then
				self.scrollBar:scrollTo(self.scrollBar.index - yOffset)
				lastMouseY = playerMouse.Y
			end
		end
	end)
end

function commands:update()
	self.scrollBar:setVisibleSpace(self:calculateVisibleSpace())
	self.scrollBar:setTotalSpace(self:calculateTotalSpace())
	self:updateElements()
end

function commands:enable()
	if self.isEnabled then return end
	local container = self.scrollContainer
	self.isEnabled = true

	self.commandsFolder.Parent  = container
	self.searchBox.Parent       = self.scrollHolder
	self.searchBoxHolder.Parent = self.scrollHolder
	self.commandInfo.Parent     = self.scrollHolder

	self.scrollConnection = self.scrolledSignal:Connect(function()
		self:updateElements()
	end)

	self.containerConnection = container.InputBegan:Connect(function(input)
		self:startedHoldingContainer(input)
	end)

	self:update()
end

function commands:disable()
	if not self.isEnabled then return end
	self.isEnabled = false

	self.commandsFolder.Parent  = nil
	self.searchBox.Parent       = nil
	self.searchBoxHolder.Parent = nil
	self.commandInfo.Parent     = nil

	connectionService:disconnect(self.containerConnection)
	connectionService:disconnect(self.markerConnection)
	connectionService:disconnect(self.scrollConnection)
end

function commands.new(config)
	local function cfg(name)
		return assert(config.configs[name], `missing config.configs['{name}']`)
	end
	
	local self = setmetatable({
		scrollContainer = config.scrollContainer,
		scrolledSignal  = config.scrolledSignal,
		scrollHolder    = config.scrollHolder,
		scrollBar       = config.scrollBar,
		
		configs = {
			placeholderText = cfg("placeholderText"),
			padding = cfg("padding"),
			labelSize = cfg("labelSize"),
			textSize = cfg("textSize")
		},
		
		commandClickedSignal = signal.new(),
		
		commandInput = {
			bestMatch       = nil,
			bestMatches     = {},
			searchResult    = {},
			isValidCommand  = false,
			highlightText   = "",
			noHighlightText = "",
			fullCommandText = "",
			commandName     = ""
		},
		
		visibleCommands = {},
		commandsData    = {}
	}, commands)
	
	self.parser = commandParser.new(self.commandInput, function(text, color)
		return self:setComment(text, color)
	end)
	
	return self
end

return commands