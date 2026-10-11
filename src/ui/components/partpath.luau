-- src/ui/components/partpath.luau
-- The "Teleport to Part" window that the partpath command opens. Click a part to highlight it and see
-- its full path. "Select Part" hands the chosen part to the command (which saves it as a waypoint),
-- "Copy Path" copies the path, and "Exit" closes the window and turns the selection off.
-- The window stays hidden until it is opened (the original kept it on screen all the time).

local createService = require("../services/createService")
local assetsService = require("../services/assetsService")
local themeService = require("../services/themeService")
local notifier = require("../notifier")
local dragInstance = require("../utils/dragInstance")
local coreGui = require("../coreGui")

local connectionService = require("../../framework/services/connectionService")
local playerService = require("../../framework/services/playerService")
local executorEnv = require("../../framework/environment/executor")

local getHierarchy = require("../../utils/getHierarchy")

local WINDOW_WIDTH = 360
local TOP_BAR_HEIGHT = 20
local BODY_HEIGHT = 146
local WINDOW_HEIGHT = TOP_BAR_HEIGHT + BODY_HEIGHT

local BUTTON_WIDTH = 95
local BUTTON_HEIGHT = 26
local BUTTON_Y = 64
local PATH_Y = 98
local PATH_HEIGHT = 40

local TWEEN_TIME = 0.5
local COPY_FEEDBACK_TIME = 1.5

local HOVER_COLOR = Color3.fromRGB(255, 255, 255)
local SELECTED_COLOR = Color3.fromRGB(0, 166, 0)

local SHOWN_POSITION = UDim2.new(0.5, -WINDOW_WIDTH / 2, 0.5, -WINDOW_HEIGHT / 2)
local HIDDEN_POSITION = UDim2.new(0.5, -WINDOW_WIDTH / 2, 0, -500)

local TEXT = {
	title = "Teleport to Part",
	directions = 'Click on a part and then click the "Select Part" button below to set it as a teleport location',
	selectPart = "Select Part",
	copyPath = "Copy Path",
	copied = "Copied",
	noPart = "Select a part first",
	noPath = "Select a part to copy its path",
	noClipboard = "Your exploit does not support copying",
}

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
		selectedPart = nil,
		onSelectPart = nil,
		connections = {},
	}, partPath)
end

local function createButton(name: string, text: string, x: number, parent: Instance)
	local button = createService.new("TextButton", name, parent, {
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(x, BUTTON_Y),
		Size = UDim2.fromOffset(BUTTON_WIDTH, BUTTON_HEIGHT),
		Text = text,
		TextSize = 14,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, 4),
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
		BorderSizePixel = 0,
		Position = HIDDEN_POSITION,
		Size = UDim2.fromOffset(WINDOW_WIDTH, WINDOW_HEIGHT),
		Visible = false,
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
		Text = TEXT.title,
		TextSize = 16,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local exitButton = createService.new("TextButton", "Exit", topBar, {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -TOP_BAR_HEIGHT, 0, 0),
		Size = UDim2.fromOffset(TOP_BAR_HEIGHT, TOP_BAR_HEIGHT),
		Text = "",
	})

	local exitIcon = createService.new("ImageLabel", "Icon", exitButton, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5, 5),
		Size = UDim2.fromOffset(10, 10),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	assetsService:loadImage(exitIcon, "close")

	local body = createService.new("Frame", "Body", frame, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT),
		Size = UDim2.new(1, 0, 0, BODY_HEIGHT),
	})

	createService.new("TextLabel", "Directions", body, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(20, 8),
		Size = UDim2.new(1, -40, 0, 48),
		Text = TEXT.directions,
		TextSize = 14,
		TextWrapped = true,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	-- the two buttons sit side by side, centred in the window
	local selectButton = createButton("SelectPart", TEXT.selectPart, WINDOW_WIDTH / 2 - BUTTON_WIDTH - 5, body)
	local copyButton = createButton("CopyPath", TEXT.copyPath, WINDOW_WIDTH / 2 + 5, body)

	-- scales down to fit long paths (down to 9) instead of shrinking to an unreadable size
	local pathLabel = createService.new("TextLabel", "Path", body, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(10, PATH_Y),
		Size = UDim2.new(1, -20, 0, PATH_HEIGHT),
		Text = "",
		TextScaled = true,
		TextWrapped = true,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UITextSizeConstraint", {
			MaxTextSize = 14,
			MinTextSize = 9,
		}),
	})

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
	self.frame:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, TWEEN_TIME, true)

	self:startSelecting()
end

-- hides the window and turns the selection off (Exit button)
function partPath:close()
	if not self.isOpen then
		return
	end

	self.isOpen = false
	self:disconnectMouse()
	self:clearSelection()

	self.frame:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, TWEEN_TIME, true)

	task.delay(TWEEN_TIME, function()
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
	self.pathLabel.Text = getHierarchy(part)
end

function partPath:clearSelection()
	self.selectedPart = nil
	self.hoverBox.Adornee = nil
	self.selectedBox.Adornee = nil
	self.pathLabel.Text = ""
end

-- "Select Part": the command gets the part and decides what to do with it (a waypoint)
function partPath:confirmSelection()
	local part = self.selectedPart

	if not part or not part.Parent then
		self:clearSelection()
		notifier:notify("Part Selection", TEXT.noPart)
		return
	end

	if self.onSelectPart then
		self.onSelectPart(part)
	end
end

function partPath:copyPath()
	local path = self.pathLabel.Text

	if path == "" then
		notifier:notify(TEXT.copyPath, TEXT.noPath)
		return
	end

	if not executorEnv.setclipboard then
		notifier:notify(TEXT.copyPath, TEXT.noClipboard)
		return
	end

	executorEnv.setclipboard(path)

	local button = self.copyButton
	button.Text = TEXT.copied

	task.delay(COPY_FEEDBACK_TIME, function()
		button.Text = TEXT.copyPath
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
