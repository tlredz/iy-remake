local connectionService = require("../../framework/services/connectionService")
local robloxServices    = require("../../framework/services/rbxServices")
local playerService     = require("../../framework/services/playerService")
local createService     = require("../services/createService")
local commandData       = require("../../commands/systems/commandData")

local commandParser      = require("../../commands/systems/commandParser")
local commandRunner      = require("../../commands/systems/commandRunner")

local inputUtils   = require("../utils/inputUtils")
local commandsList = require("../../commands/list")

local signal      = require("../../utils/signal")
local logger      = require("../../utils/logger")
local tools       = require("../../utils/tools")
local scaleObject = require("../utils/scaleObject")

local settingsData = require("../../storage/data/settings")
local cmdsColors = require("../../framework/config/ui/colors").commands
local isMobile = require("../../framework/environment/isMobile")

local userInputService = robloxServices.UserInputService
local runService       = robloxServices.RunService

local richFontSize     = tools.richFontSize
local colorFromRGB     = tools.colorFromRGB

local commands = {}
commands.__index = commands

local DELETE_DEBOUNCE = 0.15
local SEARCH_BOX_ROWS = 2.50
local SWIPE_DOWN_MIN  = 50 -- px a finger must move down, from the top of the list, to minimize the window (the dock's DRAG_DOWN_MIN)

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

function commands:refresh(text: string, debounce: boolean?)
	local statements = self.parser:parse(text)
	self.parser:highlight(statements)

	self:updateSearchBoxHighlight()

	if debounce then
		self:scheduleSearchedCommand()
	else
		self.scrollToken += 1 -- a scroll that was waiting for the debounce is dropped, this one is the current one
		self:updateSearchedCommand()
	end
end

-- scrolls to the matching command once the user has stopped deleting for DELETE_DEBOUNCE seconds. Every deletion
-- restarts the wait, and a refresh that is not debounced replaces it (the token changes)
function commands:scheduleSearchedCommand()
	self.scrollToken += 1
	local token = self.scrollToken

	task.delay(DELETE_DEBOUNCE, function()
		if token ~= self.scrollToken then return end
		self:updateSearchedCommand()
	end)
end

function commands:applyCorrection()
	local cmdInput   = self.commandInput
	local correction = cmdInput.correction
	local raw        = cmdInput.rawText
	
	local newText = raw:sub(1, correction.from - 1) .. correction.text .. raw:sub(correction.to + 1)
	
	if settingsData:getValue("spaceAfterCorrection") then
		newText ..= " "
	end
	
	self:writeText(newText)
end

function commands:captureFocus()
	local searchBox = self.searchBox
	if not searchBox then return end
	
	-- if searchBox:IsFocused() then
	-- 	searchBox:ReleaseFocus()
	-- 	task.wait()
	-- end
	
	if searchBox.Parent ~= nil then
		searchBox:CaptureFocus()
	end
end

-- Turns the user's interactions with the command list on or off: clicking a command or the search bar, holding /
-- dragging the list and scrolling (wheel, scroll bar). The window itself is not affected, it can still be dragged
-- and tapped. Called by the interface from the dock: off while the window is minimized, back on once it is fully up
function commands:setInteractive(enabled: boolean)
	enabled = enabled == true
	if self.interactive == enabled then return end
	self.interactive = enabled

	self.scrollBar:setLocked(not enabled)

	-- the search bar must not keep the keyboard while the list can not be used
	if not enabled then
		local searchBox = self.searchBox

		if searchBox and searchBox:IsFocused() then
			searchBox:ReleaseFocus()
		end
	end
end

function commands:isInteractive(): boolean
	return self.interactive
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
		if not self.interactive then return end
		
		self:writeText(data.aliases[1])
		task.defer(captureFocus)
	end)
	
	connectionService:Connect(searchHolder.Activated, function()
		if not self.interactive then return end
		
		captureFocus()
	end)
	
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

		-- a tab character is never part of a command (Tab accepts the suggestion instead)
		if text:find("\t") then
			searchBox.Text = (text:gsub("\t", ""))
			return
		end

		-- typing leaves the position in the history
		if self.historyIndex and text ~= self.historyText then
			self.historyIndex = nil
		end

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
		
		-- deleting: the scroll waits for the user to stop (DELETE_DEBOUNCE); typing follows at once
		local deleting = #text < #self.lastText
		self.lastText = text

		updatePlaceholder()
		self:refresh(text, deleting)
	end)

	-- while the bar is focused: Up and Down browse the history, Tab takes the suggestion
	connectionService:Connect(userInputService.InputBegan, function(input)
		if not searchBox:IsFocused() then return end

		if input.KeyCode == Enum.KeyCode.Up then
			self:browseHistory(-1)
		elseif input.KeyCode == Enum.KeyCode.Down then
			self:browseHistory(1)
		elseif input.KeyCode == Enum.KeyCode.Tab and self.commandInput.correction then
			self:applyCorrection()
			task.defer(captureFocus)
		end
	end)
end

local HISTORY_LIMIT = 50

-- Runs the statements of the input in order (they are separated by "\"). The first one that fails stops the rest.
function commands:sendInputCommand()
	local cmdInput = self.commandInput

	if cmdInput.runError then
		self:setComment(cmdInput.runError, "error")
		return
	end

	local statements = cmdInput.statements

	for _, info in statements do
		if not info.commandData then return end
	end

	-- the command is sent: a swipe can minimize the window again (see dock:unlockSwipe)
	if self.onCommandSent then
		self.onCommandSent()
	end

	local rawText = cmdInput.rawText
	local failure, failedName = nil, nil

	for _, info in statements do
		local success, reason = pcall(function()
			self:runStatement(info)
		end)

		if not success then
			failure = reason
			failedName = info.commandData.name
			break
		end
	end

	if settingsData:getValue("clearOnEnter") then
		self:writeText("")
	end

	self.historyIndex = nil

	if failure then
		self:setComment(`failed - {failure}`, "error")
		logger:error(`failed to run command '{failedName}': {failure}`)
	else
		self:addToHistory(rawText)
	end
end

-- Runs one statement: a plain command, a loop ("count^delay^command") or a repeat ("!command"). See commandRunner.
function commands:runStatement(info)
	commandRunner.runStatement(info)
end

function commands:addToHistory(text: string)
	local line = (text or ""):match("^(.-)%s*$")

	if line == "" then return end

	local history = self.history

	if history[#history] == line then return end

	table.insert(history, line)

	if #history > HISTORY_LIMIT then
		table.remove(history, 1)
	end
end

-- Up (-1) goes to older commands, Down (1) to newer ones. Going past the newest one clears the bar.
function commands:browseHistory(direction: number)
	local history = self.history

	if #history == 0 then return end

	local index

	if self.historyIndex == nil then
		if direction > 0 then return end
		index = #history
	else
		index = self.historyIndex + direction
	end

	if index < 1 then
		index = 1
	end

	if index > #history then
		self.historyIndex = nil
		self:setSearchText("")
		return
	end

	self.historyIndex = index
	self:setSearchText(history[index])
end

function commands:setSearchText(text: string)
	self.historyText = text
	self:writeText(text)
end

-- sets the text from code (history, a correction, a clicked command, clear on enter). The list follows it at once,
-- it is not debounced like a deletion typed by the user
function commands:writeText(text: string)
	self.searchBox.Text = text
	self.lastText = text
	self:refresh(text)
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
		BorderSizePixel        = 0,
		TextTransparency       = 1,
		Size                   = UDim2.fromScale(1, 0),
		Position               = UDim2.fromScale(0, 0.4),
		ClearTextOnFocus       = false,
		ShowNativeInput        = false,
		TextSize               = 0,
		Text                   = "",
		MultiLine              = true
	})

	-- the box is never clicked: the command bar button gives it the focus (captureFocus). The window is drawn above
	-- it and absorbs the clicks, and when the window is hidden the input is turned off too (if the client has it)
	self.searchBox.ZIndex = 0
	pcall(function()
		self.searchBox.Interactable = false
	end)
	
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

-- places the search box a few command rows under the command bar, in screen pixels, and keeps it inside the ScreenGui:
-- a box that is off the screen can not take the focus. It runs every frame while the bar is enabled (see enable)
function commands:updateSearchBoxPosition()
	local searchBox    = self.searchBox
	local searchHolder = self.searchBoxHolder
	local screenGui    = self.screenGui
	local mainFrame    = self.scrollHolder and self.scrollHolder.Parent -- the window, the scroll holder is its child

	if not self.isEnabled or not (searchBox and searchHolder and screenGui and mainFrame) then return end

	local screenSize = screenGui.AbsoluteSize
	local scale      = math.max(scaleObject:getScale(), 0.01)

	-- where the window is, from its Position (the same numbers the dock uses to place it). The offsets are multiplied
	-- by the UIScale, the scale fractions are shares of the screen
	local framePos = mainFrame.Position
	local frameX   = framePos.X.Scale * screenSize.X + framePos.X.Offset * scale
	local frameY   = framePos.Y.Scale * screenSize.Y + framePos.Y.Offset * scale

	-- where the bar is inside the window: a difference of two AbsolutePositions, so whatever they both have in common
	-- (like the top bar inset) cancels out
	local barX = frameX + (searchHolder.AbsolutePosition.X - mainFrame.AbsolutePosition.X)
	local barY = frameY + (searchHolder.AbsolutePosition.Y - mainFrame.AbsolutePosition.Y)

	-- the bar's size, but never bigger than the screen and never 0 px (a 0 px box can not take the focus)
	local holderSize = searchHolder.AbsoluteSize
	local width  = math.max(math.min(holderSize.X, screenSize.X), 1)
	local height = math.max(math.min(holderSize.Y, screenSize.Y), 1)

	local rowsGap = self:calculateLabelSize() * SEARCH_BOX_ROWS * scale
	
	local x = math.clamp(barX, 0, math.max(screenSize.X - width, 0))
	local y = math.clamp(barY + height + rowsGap, 0, math.max(screenSize.Y - height, 0))

	-- the ScreenGui's UIScale multiplies the offsets of its children, so the pixels are divided by the scale
	local position = UDim2.fromOffset(x / scale, y / scale)
	local size     = UDim2.fromOffset(width / scale, height / scale)

	-- written only when it changes, so the TextBox is not re-laid out every frame
	if searchBox.Position ~= position or searchBox.Size ~= size then
		searchBox.Position = position
		searchBox.Size     = size
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

-- PC: the command under the pointer shows its description on the comment line (under the search bar), and the line
-- goes back to what it was when the pointer leaves. The line is only taken when it is empty, so typing, errors and
-- the reasons a command cannot run are never replaced.
-- returns false when the line is in use by something else
function commands:showHoverDescription(description: string): boolean
	local comment = self.inputComment
	local showing = self.hoverText ~= nil and comment.Text == self.hoverText

	if not showing then
		if comment.Text ~= "" then
			self.hoverText = nil
			return false
		end

		self.savedComment = comment.Text
	end

	self.hoverText = commandParser.colorFromName(description, "comment")
	comment.Text = self.hoverText
	comment.Visible = true
	return true
end

function commands:clearHoverDescription()
	if self.hoverText == nil then return end

	local comment = self.inputComment

	-- the line was changed since (the person typed, or a new message came): it is left as it is
	if comment.Text == self.hoverText then
		comment.Text = self.savedComment or ""
		comment.Visible = #comment.Text > 0
	end

	self.hoverText = nil
	self.savedComment = nil
end

function commands:updateHoverDescription()
	local hovered = nil

	if self.interactive and playerService:isMouseInGuiObject(self.scrollContainer) then
		hovered = self:getElementMouseIn()
	end

	local description = hovered and hovered.description
	if not description then
		self.hoveredCommand = nil
		self:clearHoverDescription()
		return
	end

	if hovered == self.hoveredCommand then return end

	-- when the line is in use, the command is tried again on the next frame, so the description shows once it is free
	if self:showHoverDescription(description) then
		self.hoveredCommand = hovered
	end
end

function commands:startedHoldingContainer(input)
	if not self.interactive then return end
	if not inputUtils.isPressingInput(input) then return end
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

	-- a swipe down from the top of the list minimizes the window (commands.onSwipeDown). It counts only when the list was
	-- at its top when the finger came down, so scrolling the list is never a swipe
	local startMouseY  = playerMouse.Y
	local swipeFromTop = self.scrollBar.index <= 0
	local downTravel   = 0 -- how far the finger is below where it came down (px), as of the last move
	local swiped       = false

	local mouseEvent

	local function disconnect()
		self.scrollBar:enableScroll()

		-- let go after a swipe down: the window minimizes, and the press is not a click on a command
		if swipeFromTop and self.scrollAxis == "y" and downTravel >= SWIPE_DOWN_MIN and self.onSwipeDown then
			swiped = true
			self.onSwipeDown()
		end
		
		if cmdData then
			cmdData.isHolding = nil
			
			if cmdData.originalText then
				self:setCommandText(cmdData, cmdData.originalText)
				cmdData.originalText = nil
			end
			
			if (tick() - clickedAt) <= 0.15 and not swiped then
				self.commandClickedSignal:Fire(cmdData)
			end
		end
		
		if mouseEvent   then mouseEvent:Disconnect()   end
	end

	inputUtils.onReleaseEvent(disconnect)
	
	mouseEvent = inputUtils.onMouseEvent(function(inp)
		-- the window was minimized in the middle of the hold
		if not self.interactive then return end
		downTravel = playerMouse.Y - startMouseY
		
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
	self.searchBox.Parent       = self.screenGui
	self.searchBoxHolder.Parent = self.scrollHolder
	self.commandInfo.Parent     = self.scrollHolder

	self.scrollConnection = self.scrolledSignal:Connect(function()
		self:updateElements()
	end)

	self.containerConnection = container.InputBegan:Connect(function(input)
		self:startedHoldingContainer(input)
	end)

	self:update()
	self:updateSearchBoxPosition()

	-- the bar moves with the window (drag, dock), so the search box follows it every frame
	self.searchBoxConnection = connectionService:Connect(runService.RenderStepped, function()
		self:updateSearchBoxPosition()
	end)

	-- PC: hovering a command shows its description (there is no pointer on a phone)
	if not isMobile then
		self.hoverConnection = connectionService:Connect(runService.RenderStepped, function()
			self:updateHoverDescription()
		end)
	end
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
	connectionService:disconnect(self.searchBoxConnection)
	connectionService:disconnect(self.hoverConnection)

	self.hoveredCommand = nil
	self:clearHoverDescription()
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
		screenGui       = config.screenGui,
		
		configs = {
			placeholderText = cfg("placeholderText"),
			padding = cfg("padding"),
			labelSize = cfg("labelSize"),
			textSize = cfg("textSize")
		},
		
		commandClickedSignal = signal.new(),
		
		interactive = true, -- the dock turns it off right away (the window starts minimized)
		
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
		commandsData    = {},
		history         = {},
		historyIndex    = nil,
		historyText     = "",
		lastText        = "", -- the text the bar had at the last change, to tell a deletion from typing
		scrollToken     = 0,  -- counts the scrolls of the debounce; a scroll that is not the latest does nothing
	}, commands)
	
	self.parser = commandParser.new(self.commandInput, function(text, color)
		return self:setComment(text, color)
	end)
	
	return self
end

return commands