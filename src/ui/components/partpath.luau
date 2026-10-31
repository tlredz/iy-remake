-- src/ui/components/partpath.luau
-- The part path window (partpath command). Click a part to highlight it and see its full path, colored
-- with textHighlight. "select part" hands the chosen part to the command (which saves it as a waypoint),
-- "copy path" copies the path, and the X closes the window and turns the selection off.
-- It is styled like the server info window, and it stays hidden until it is opened.

local createService = require("../services/createService")
local assetsService = require("../services/assetsService")
local themeService = require("../services/themeService")
local notifier = require("../notifier")
local dragInstance = require("../utils/dragInstance")
local coreGui = require("../coreGui")

local connectionService = require("../../framework/services/connectionService")
local playerService = require("../../framework/services/playerService")
local executorEnv = require("../../framework/environment/executor")
local config = require("../../framework/config/ui/partpath")

local getHierarchy = require("../../utils/getHierarchy")
local highlight = require("../../utils/textHighlight")
local tools = require("../../utils/tools")

local windowConfig = config.window
local textSizes = config.textSizes
local buttonsConfig = config.buttons

local SHOWN_POSITION = UDim2.new(0.5, -windowConfig.width / 2, 0, windowConfig.shownY)
local HIDDEN_POSITION = UDim2.new(0.5, -windowConfig.width / 2, 0, windowConfig.hiddenY)

local HOVER_COLOR = Color3.fromRGB(255, 255, 255)
local SELECTED_COLOR = Color3.fromRGB(0, 166, 0)

local partPath = {}
partPath.__index = partPath

function partPath.new()
	return setmetatable({
		frame = nil,
		hoverBox = nil,
		selectedBox = nil,
		pathLabel = nil,
		copyButton = nil,

		isOpen = false,
		path = nil,
		selectedPart = nil,
		onSelectPart = nil,
		connections = {},
	}, partPath)
end

-- a row like the server info window: every odd row has a light stripe, and the text is inset from the left
local function createRow(body, layoutOrder: number, height: number, name: string)
	return createService.new("Frame", name, body, {
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = if layoutOrder % 2 == 1 then windowConfig.stripeTransparency else 1,
		BorderSizePixel = 0,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1, 0, 0, height),
	})
end

-- a row whose text wraps. The row grows with its text, so no line is ever cut off
local function createTextRow(body, layoutOrder: number, name: string, look)
	local row = createService.new("Frame", name, body, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = Color3.new(1, 1, 1),
		BackgroundTransparency = if layoutOrder % 2 == 1 then windowConfig.stripeTransparency else 1,
		BorderSizePixel = 0,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1, 0, 0, 0),

		createService.new("UIPadding", {
			PaddingBottom = UDim.new(0, windowConfig.rowPadding),
			PaddingLeft = UDim.new(0, windowConfig.textInset),
			PaddingRight = UDim.new(0, windowConfig.textInset),
			PaddingTop = UDim.new(0, windowConfig.rowPadding),
		}),
		createService.new("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local label = createService.new("TextLabel", look.labelName, row, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		TextSize = look.textSize,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = look.color,
		},
	})

	return row, label
end

-- Breaks a path before a name (before a dot or a bracket) when the next name would not fit on the line,
-- so a name is never cut in the middle. Only the shown text is broken; copy still uses the plain path.
local function breakPath(path: string): string
	local segments = {}
	local current = ""

	for index = 1, #path do
		local char = string.sub(path, index, index)

		if (char == "." or char == "[") and current ~= "" then
			table.insert(segments, current)
			current = ""
		end

		current = current .. char
	end

	if current ~= "" then
		table.insert(segments, current)
	end

	local lines = {}
	local line = ""

	for _, segment in segments do
		if line ~= "" and #line + #segment > config.window.pathCharsPerLine then
			table.insert(lines, line)
			line = ""
		end

		line = line .. segment
	end

	if line ~= "" then
		table.insert(lines, line)
	end

	return table.concat(lines, "\n")
end

local function createSection(body, layoutOrder: number, title: string)
	local row = createRow(body, layoutOrder, windowConfig.rowHeight, "Section")

	createService.new("TextLabel", "Title", row, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(windowConfig.textInset, 0),
		Size = UDim2.new(1, -windowConfig.textInset * 2, 1, 0),
		RichText = true,
		Text = `<b>{tools.escapeRichText(title)}</b>`,
		TextSize = textSizes.section,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Center,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Darker",
		},
	})

	return row
end

local function createButton(parent: Instance, name: string, text: string, position: UDim2, size: UDim2)
	local button = createService.new("TextButton", name, parent, {
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Position = position,
		Size = size,
		Text = text,
		TextSize = textSizes.button,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, buttonsConfig.cornerRadius),
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

	return button
end

-- builds the window once (hidden). The caller parents the returned frame to the screen GUI
function partPath:create()
	if self.frame then
		return self.frame
	end

	local frame = createService.new("Frame", "PartPath", {
		Active = true,
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Position = HIDDEN_POSITION,
		Size = UDim2.fromOffset(windowConfig.width, 0),
		Visible = false,

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
		TextSize = textSizes.title,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local exitButton = createService.new("ImageButton", "Exit", topBar, {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -windowConfig.closeInset, 0.5, 0),
		Size = UDim2.fromOffset(windowConfig.closeIconSize, windowConfig.closeIconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	assetsService:loadImage(exitButton, "lucide-custom-x")

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
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	createSection(body, 1, config.headers.path)

	-- the path row: the highlighted path, or the hint when no part is chosen
	local _, pathLabel = createTextRow(body, 2, "PathRow", {
		labelName = "Path",
		textSize = textSizes.value,
		color = "Colors.Text.Default",
	})
	pathLabel.RichText = true

	createSection(body, 3, config.headers.actions)

	-- the buttons sit side by side, each taking half the row minus the gap
	local buttonRow = createRow(body, 4, windowConfig.buttonRowHeight, "ButtonRow")
	local half = windowConfig.buttonGap / 2
	local inset = windowConfig.textInset
	local buttonY = (windowConfig.buttonRowHeight - windowConfig.buttonHeight) / 2
	local buttonSize = UDim2.new(0.5, -(inset + half), 0, windowConfig.buttonHeight)

	local selectButton = createButton(buttonRow, "SelectPart", buttonsConfig.selectPart,
		UDim2.new(0, inset, 0, buttonY), buttonSize)
	local copyButton = createButton(buttonRow, "CopyPath", buttonsConfig.copyPath,
		UDim2.new(0.5, half, 0, buttonY), buttonSize)

	local _, helpLabel = createTextRow(body, 5, "Help", {
		labelName = "HelpText",
		textSize = textSizes.help,
		color = "Colors.Text.Darker",
	})
	helpLabel.Text = config.labels.help

	-- selection boxes live in coreGui, like the original, so they draw over the world
	local hoverBox = createService.new("SelectionBox", "Hover", coreGui, {
		Color3 = HOVER_COLOR,
	})

	local selectedBox = createService.new("SelectionBox", "Selected", coreGui, {
		Color3 = SELECTED_COLOR,
	})

	connectionService:Connect(exitButton.Activated, function()
		self:close()
	end)

	connectionService:Connect(selectButton.Activated, function()
		self:confirmSelection()
	end)

	connectionService:Connect(copyButton.Activated, function()
		self:copyPath()
	end)

	dragInstance:addGuiObject(frame)

	self.frame = frame
	self.hoverBox = hoverBox
	self.selectedBox = selectedBox
	self.pathLabel = pathLabel
	self.copyButton = copyButton

	self:setPath(nil)

	return frame
end

-- shows the window and starts selecting parts. If it is already open, only the callback is replaced
function partPath:open(onSelectPart)
	self:create()
	self.onSelectPart = onSelectPart

	if self.isOpen then
		return
	end

	self.isOpen = true
	self.frame.Visible = true
	self.frame:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, windowConfig.tweenTime, true)

	self:startSelecting()
end

-- hides the window and turns the selection off (the X button)
function partPath:close()
	if not self.isOpen then
		return
	end

	self.isOpen = false
	self:disconnectMouse()
	self:clearSelection()

	self.frame:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, windowConfig.tweenTime, true)

	task.delay(windowConfig.tweenTime, function()
		-- the window may have been opened again while it was sliding out
		if not self.isOpen and self.frame then
			self.frame.Visible = false
		end
	end)
end

function partPath:isPointerOverWindow(): boolean
	return self.frame ~= nil and playerService:isMouseInGuiObject(self.frame)
end

function partPath:startSelecting()
	self:disconnectMouse()

	local mouse = playerService:getMouse()

	table.insert(self.connections, mouse.Move:Connect(function()
		local target = mouse.Target

		-- no hover box over the window, or over the part that is already selected (like the original)
		if self:isPointerOverWindow() or target == self.selectedPart then
			target = nil
		end

		self.hoverBox.Adornee = target
	end))

	table.insert(self.connections, mouse.Button1Down:Connect(function()
		if self:isPointerOverWindow() then
			return
		end

		local target = mouse.Target
		if target then
			self:selectPart(target)
		end
	end))
end

function partPath:disconnectMouse()
	for _, connection in self.connections do
		connection:Disconnect()
	end

	self.connections = {}
end

function partPath:selectPart(part: BasePart)
	self.selectedPart = part
	self.selectedBox.Adornee = part
	self.hoverBox.Adornee = nil
	self:setPath(getHierarchy(part))
end

-- shows the path of the chosen part (rich text from textHighlight), or the hint when no part is chosen
function partPath:setPath(path: string?)
	local label = self.pathLabel
	self.path = path

	if path then
		themeService:addObject(label, { TextColor3 = "Colors.Text.Default", Font = "Font.MonoSpace" })
		label.RichText = true
		label.Text = highlight:apply(breakPath(path))
	else
		themeService:addObject(label, { TextColor3 = "Colors.Text.Darker", Font = "Font.MonoSpace" })
		label.RichText = false
		label.Text = config.labels.hint
	end
end

function partPath:clearSelection()
	self.selectedPart = nil
	self.hoverBox.Adornee = nil
	self.selectedBox.Adornee = nil
	self:setPath(nil)
end

-- "select part": the command gets the part and decides what to do with it (a waypoint)
function partPath:confirmSelection()
	local part = self.selectedPart

	if not part or not part.Parent then
		self:clearSelection()
		notifier:notify(windowConfig.title, config.messages.noPart)
		return
	end

	if self.onSelectPart then
		self.onSelectPart(part)
	end
end

-- copies the plain path (the label shows rich text, so its Text is not the path itself)
function partPath:copyPath()
	local path = self.path

	if not path then
		notifier:notify(windowConfig.title, config.messages.noPath)
		return
	end

	if not executorEnv.setclipboard then
		notifier:notify(windowConfig.title, config.messages.noClipboard)
		return
	end

	executorEnv.setclipboard(path)

	local button = self.copyButton
	button.Text = buttonsConfig.copied

	task.delay(buttonsConfig.feedbackTime, function()
		button.Text = config.buttons.copyPath
	end)
end

function partPath:destroy()
	self.isOpen = false
	self:disconnectMouse()

	if self.hoverBox then
		self.hoverBox:Destroy()
	end

	if self.selectedBox then
		self.selectedBox:Destroy()
	end

	if self.frame then
		self.frame:Destroy()
	end

	self.frame = nil
	self.hoverBox = nil
	self.selectedBox = nil
	self.pathLabel = nil
	self.copyButton = nil
end

return partPath
