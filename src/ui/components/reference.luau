-- src/ui/components/reference.luau

local createService = require("../services/createService")
local dragService = require("../services/dragService")
local scrollBarComponent = require("./scrollBar")

local scaleObject = require("../utils/scaleObject")
local connectionService = require("../../framework/services/connectionService")
local executorEnv = require("../../framework/environment/executor")
local frameworkSettings = require("../../framework/settings")

local referenceConfig = require("../../framework/config/reference")

local WINDOW_WIDTH = 500
local TOP_BAR_HEIGHT = 20
local CONTENT_HEIGHT = 300
local WINDOW_HEIGHT = TOP_BAR_HEIGHT + CONTENT_HEIGHT

local SCROLL_THICKNESS = 12
local SCROLL_INCREMENT = 20
local SCROLL_WHEEL_INCREMENT = 40

local TWEEN_TIME = 0.5
local COPY_FEEDBACK_TIME = 2

local HIDDEN_POSITION = UDim2.new(0.5, -WINDOW_WIDTH / 2, 0, -500)
local SHOWN_POSITION = UDim2.new(0.5, -WINDOW_WIDTH / 2, 0.5, -WINDOW_HEIGHT / 2)

local RICH_TEXT_ESCAPES = { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;" }

local CASES = referenceConfig.cases
local SECTIONS = referenceConfig.sections

local reference = {}
reference.__index = reference

local function escapeRichText(text)
	return (text:gsub("[&<>]", RICH_TEXT_ESCAPES))
end

local function createTitle(text)
	return createService.new("TextLabel", "Header", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		Text = text,
		TextSize = 20,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.Bold",
			TextColor3 = "Colors.Text.Default",
		},
	})
end

local function createParagraph(text, isBold)
	return createService.new("TextLabel", isBold and "Bold" or "Text", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		Text = text,
		TextSize = 14,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = isBold and "Font.Bold" or "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})
end

local function createCases()
	local holder = createService.new("Frame", "Cases", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		createService.new("UIListLayout", {
			Padding = UDim.new(0, 2),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	for order, entry in CASES do
		local caseName, caseDescription = entry[1], entry[2]
		
		createService.new("TextLabel", "Case", holder, {
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = order,
			RichText = true,
			Size = UDim2.new(1, 0, 0, 0),
			Text = `<b>{escapeRichText(caseName)}</b> {escapeRichText(caseDescription)}`,
			TextSize = 14,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			ThemeTag = {
				Font = "Font.Normal",
				TextColor3 = "Colors.Text.Default",
			},
		})
	end

	return holder
end

local function createInviteButton(link)
	local button = createService.new("TextButton", "InviteButton", {
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 25),
		Text = `Copy Discord Invite Link ({link})`,
		TextSize = 16,
		ThemeTag = {
			BackgroundColor3 = "Colors.Primary",
			Font = "Font.Bold",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local defaultText = button.Text
	local lastPress = nil

	connectionService:Connect(button.Activated, function()
		if executorEnv.setclipboard then
			executorEnv.setclipboard(link)
			button.Text = "Copied"
		else
			button.Text = "No Clipboard Function, type out the link"
		end

		local pressTime = tick()
		lastPress = pressTime

		task.wait(COPY_FEEDBACK_TIME)
		if lastPress ~= pressTime then return end

		button.Text = defaultText
	end)

	return button
end

local function createBlock(block)
	local kind = block[1]

	if kind == "title" then
		return createTitle(block[2])
	elseif kind == "cases" then
		return createCases()
	elseif kind == "invite" then
		return createInviteButton(frameworkSettings.links.discord)
	end

	return createParagraph(block[2], kind == "bold")
end

local function createSection(order, blocks, isLast)
	local section = createService.new("Frame", "Section", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = order,
		Size = UDim2.new(1, 0, 0, 0),
		createService.new("UIPadding", {
			PaddingBottom = UDim.new(0, 8),
			PaddingLeft = UDim.new(0, 8),
			PaddingRight = UDim.new(0, 8),
			PaddingTop = UDim.new(0, 5),
		}),
		createService.new("UIListLayout", {
			Padding = UDim.new(0, 4),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	for blockOrder, block in blocks do
		local element = createBlock(block)
		element.LayoutOrder = blockOrder
		element.Parent = section
	end

	if not isLast then
		createService.new("Frame", "Line", section, {
			BorderSizePixel = 0,
			LayoutOrder = #blocks + 1,
			Size = UDim2.new(1, 0, 0, 1),
			ThemeTag = {
				BackgroundColor3 = "Colors.Stroke",
			},
		})
	end

	return section
end

function reference.new()
	return setmetatable({}, reference)
end

function reference:open()
	self.frame:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, TWEEN_TIME, true)
end

function reference:close()
	self.frame:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, TWEEN_TIME, true)
end

function reference:create()
	local frame = createService.new("Frame", "ReferenceFrame", {
		Active = true,
		BorderSizePixel = 0,
		Position = HIDDEN_POSITION,
		Size = UDim2.fromOffset(WINDOW_WIDTH, WINDOW_HEIGHT),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},
	})

	local topBar = createService.new("Frame", "TopBar", frame, {
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, TOP_BAR_HEIGHT),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},
	})

	createService.new("TextLabel", "Title", topBar, {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = "Reference",
		TextSize = 16,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local closeButton = createService.new("TextButton", "Close", topBar, {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -TOP_BAR_HEIGHT, 0, 0),
		Size = UDim2.fromOffset(TOP_BAR_HEIGHT, TOP_BAR_HEIGHT),
		Text = "",
	})

	local closeIcon = createService.new("ImageLabel", "Icon", closeButton, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5, 5),
		Size = UDim2.fromOffset(10, 10),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	local scrollBar = scrollBarComponent.new({
		isHorizontal = false,
		barThickness = SCROLL_THICKNESS,
		increment = SCROLL_INCREMENT,
		wheelIncrement = SCROLL_WHEEL_INCREMENT,
	})

	local scrollBarFrame = scrollBar:create()
	local container = scrollBar.container

	local content = createService.new("Frame", "Content", container, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		createService.new("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	createService.new("Frame", "ScrollHolder", frame, {
		Active = true,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT),
		Size = UDim2.new(1, 0, 0, CONTENT_HEIGHT),

		scrollBarFrame,
		container,
	})

	for order, blocks in SECTIONS do
		local section = createSection(order, blocks, order == #SECTIONS)
		section.Parent = content
	end

	-- O conteúdo sobe/desce deslocando o próprio Content; tudo em unidades lógicas (sem a escala da UI).
	local function applyScroll(index)
		content.Position = UDim2.fromOffset(0, -index)
	end

	local function refreshScroll()
		local scale = scaleObject:getScale()

		scrollBar:setTotalSpace(math.ceil(content.AbsoluteSize.Y / scale))
		scrollBar:setVisibleSpace(math.ceil(container.AbsoluteSize.Y / scale))
		applyScroll(scrollBar.index)
	end

	connectionService:Connect(scrollBar.scrolledSignal, applyScroll)
	connectionService:Connect(content:GetPropertyChangedSignal("AbsoluteSize"), refreshScroll)
	connectionService:Connect(container:GetPropertyChangedSignal("AbsoluteSize"), refreshScroll)

	connectionService:Connect(container.MouseWheelForward, function()
		scrollBar:scrollTo(scrollBar.index - scrollBar.wheelIncrement)
	end)

	connectionService:Connect(container.MouseWheelBackward, function()
		scrollBar:scrollTo(scrollBar.index + scrollBar.wheelIncrement)
	end)

	connectionService:Connect(closeButton.Activated, function()
		self:close()
	end)

	local dragInstance = dragService.new(scaleObject.uiScale)
	dragInstance:addGuiObject(frame)

	dragInstance.dragStarted:Connect(function(object)
		if object ~= frame then return end
		scrollBar:disableScroll()
	end)

	dragInstance.dragEnded:Connect(function(object)
		if object ~= frame then return end
		scrollBar:enableScroll()
	end)

	refreshScroll()

	self.frame = frame
	self.closeIcon = closeIcon
	self.scrollBar = scrollBar
	self.dragInstance = dragInstance

	return frame
end

return reference