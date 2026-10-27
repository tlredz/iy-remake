-- src/ui/components/reference.luau

local createService = require("../services/createService")
local themeService = require("../services/themeService")
local assetsService = require("../services/assetsService")
local dragInstance = require("../utils/dragInstance")
local scrollBarComponent = require("./scrollBar")

local scaleObject = require("../utils/scaleObject")
local connectionService = require("../../framework/services/connectionService")
local executorEnv = require("../../framework/environment/executor")
local fetchService = require("../../framework/services/fetchService")
local frameworkSettings = require("../../framework/settings")
local robloxServices = require("../../framework/services/rbxServices")
local tweenService = require("../../framework/services/tweenService")

local referenceConfig = require("../../framework/config/ui/reference")
local codeHighlight = require("../../utils/luahighlight")

local TweenService = robloxServices.TweenService

local WINDOW_WIDTH = 500
local TOP_BAR_HEIGHT = 20
local TABS_HEIGHT = 28
local TAB_INSET = 4 -- gap between the Types / Plugins switch and the edges of its row

-- the window is the top bar, the tabs, the content and the footer. The Types tab has no footer, so its content is taller
local CONTENT_HEIGHT = 300
local PAGED_CONTENT_HEIGHT = 260
local FOOTER_HEIGHT = 40
local WINDOW_HEIGHT = TOP_BAR_HEIGHT + TABS_HEIGHT + CONTENT_HEIGHT

local SCROLL_THICKNESS = 12
local SCROLL_INCREMENT = 20
local SCROLL_WHEEL_INCREMENT = 40

-- BACK and NEXT: Material 3 tonal buttons (pill shaped, an icon and a label), with the page counter between them. The
-- group sits at the right, and its right edge lines up with the content (the scroll bar and the padding of the sections)
local NAV_BUTTON_HEIGHT = 32
local NAV_PADDING = 16
local NAV_GAP = 8
local NAV_ICON = 18
local NAV_TEXT_SIZE = 14
local NAV_MARGIN = SCROLL_THICKNESS + 8
local NAV_SHOWN = UDim2.new(0, 0, 0, 0)
local NAV_HIDDEN = UDim2.new(0, 0, 0, FOOTER_HEIGHT)
local NAV_HOVER_TRANSPARENCY = 0.15
local NAV_HOVER_TRANSPARENCY = 0.15

local CODE_RADIUS = 6
local CODE_PADDING = 8
local COPY_SIZE = 14
local COPY_MARGIN = 6
local COPY_ICON = "lucide-clipboard-copy"
local COPY_FEEDBACK_TIME = 1.5

local WINDOW_TWEEN_TIME = 0.5
local PAGE_TWEEN_TIME = 0.25 -- a page slides in and the old one slides out
local TAB_TWEEN_TIME = 0.25 -- the thumb, the content height and the footer
local COLOR_TWEEN_TIME = 0.2 -- a BACK or NEXT half changes color
local HOVER_TWEEN_TIME = 0.12
local FADE_IN_TIME = 0.3 -- a code block's text, once it has been read
local COPY_TWEEN_TIME = 0.15
local SLIDE_DISTANCE = 36
local EASE_STYLE = Enum.EasingStyle.Quart
local EASE_DIRECTION = Enum.EasingDirection.Out

local PILL = UDim.new(0.5, 0)

local HIDDEN_POSITION = UDim2.new(0.5, -WINDOW_WIDTH / 2, 0, -500)
local SHOWN_POSITION = UDim2.new(0.5, -WINDOW_WIDTH / 2, 0.5, -WINDOW_HEIGHT / 2)

local RICH_TEXT_ESCAPES = { ["&"] = "&amp;", ["<"] = "&lt;", [">"] = "&gt;" }

local CASES = referenceConfig.cases
local PAGES = referenceConfig.pages
local PAGE_COUNT = #PAGES

local reference = {}
reference.__index = reference

-- the tweens running on an object, one per channel (position, size, color, transparency, text). A channel runs one
-- tween at a time, so a newer move replaces the older one
local activeTweens = setmetatable({}, { __mode = "k" })

local function cancelTween(object, channel: string)
	local byChannel = activeTweens[object]
	local running = byChannel and byChannel[channel]
	if running == nil then
		return
	end

	byChannel[channel] = nil
	running:Cancel()
end

-- moves properties of an object over duration seconds (0 sets them at once). onDone runs when the tween finishes,
-- not when a newer tween replaces it
local function tween(object, channel: string, duration: number, properties, onDone)
	cancelTween(object, channel)

	if duration <= 0 then
		for property, value in properties do
			object[property] = value
		end
		if onDone then
			onDone()
		end
		return
	end

	local running = TweenService:Create(object, TweenInfo.new(duration, EASE_STYLE, EASE_DIRECTION), properties)
	activeTweens[object] = activeTweens[object] or {}
	activeTweens[object][channel] = running

	running.Completed:Connect(function(playback)
		local byChannel = activeTweens[object]
		if byChannel and byChannel[channel] == running then
			byChannel[channel] = nil
		end

		if playback == Enum.PlaybackState.Completed and onDone then
			onDone()
		end
	end)

	running:Play()
end

-- applies theme tags to an object (so a theme change still repaints it) and animates the colors that change
local function repaint(object, tags, duration: number)
	local colorProperties, from = {}, {}
	for property in tags do
		if string.sub(property, -6) == "Color3" then
			table.insert(colorProperties, property)
			from[property] = object[property]
		end
	end

	themeService:addObject(object, tags)

	local to = {}
	for _, property in colorProperties do
		to[property] = object[property]
		object[property] = from[property]
	end

	tween(object, "color", duration, to)
end

-- every text label and button inside an object, for fading their text
local function textObjects(root)
	local found = {}
	for _, object in root:GetDescendants() do
		if object.ClassName == "TextLabel" or object.ClassName == "TextButton" then
			table.insert(found, object)
		end
	end
	return found
end

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
		RichText = true,
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

-- the text of a code block fades in when it arrives (or is replaced)
local function showCode(label, text: string)
	tween(label, "text", 0, { TextTransparency = 1 })
	label.Text = text
	tween(label, "text", FADE_IN_TIME, { TextTransparency = 0 })
end

-- A code block. "code" holds its source; "file" names a path in the repo (plugins/...) whose text is read when its page
-- is shown. The copy button in the top right corner copies the source once it is known. The load function goes into
-- loaders, and the page calls it each time it is shown, until the text has arrived.
local function createCode(kind: string, value: string, loaders)
	local source: string? = if kind == "code" then value else nil
	local loading = false

	local holder = createService.new("Frame", "Code", {
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 0),
		ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
		createService.new("UICorner", { CornerRadius = UDim.new(0, CODE_RADIUS) }),
	})

	-- the padding belongs to the text: a UIPadding on the block would also move the copy button (children placed by scale)
	local label = createService.new("TextLabel", "Source", holder, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 0),
		Text = if source then codeHighlight:apply(source) else referenceConfig.labels.loading,
		TextSize = 13,
		TextWrapped = true,
		RichText = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},
		createService.new("UIPadding", {
			PaddingTop = UDim.new(0, CODE_PADDING),
			PaddingBottom = UDim.new(0, CODE_PADDING),
			PaddingLeft = UDim.new(0, CODE_PADDING),
			-- the text stops before the copy button, so the first line does not run under it
			PaddingRight = UDim.new(0, COPY_SIZE + COPY_MARGIN + CODE_PADDING),
		}),
	})

	local copyButton = createService.new("ImageButton", "Copy", holder, {
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -(COPY_SIZE + COPY_MARGIN), 0, COPY_MARGIN),
		Size = UDim2.fromOffset(COPY_SIZE, COPY_SIZE),
		ThemeTag = { ImageColor3 = "Colors.Icons" },
	})
	assetsService:loadImage(copyButton, COPY_ICON)

	if not executorEnv.setclipboard then
		copyButton.Visible = false
	end

	local lastPress = nil
	connectionService:Connect(copyButton.Activated, function()
		if source == nil or not executorEnv.setclipboard then return end

		executorEnv.setclipboard(source)
		repaint(copyButton, { ImageColor3 = "Colors.Primary" }, tweenService:getScale(COPY_TWEEN_TIME))

		local pressTime = tick()
		lastPress = pressTime

		task.wait(COPY_FEEDBACK_TIME)
		if lastPress ~= pressTime then return end

		repaint(copyButton, { ImageColor3 = "Colors.Icons" }, tweenService:getScale(COPY_TWEEN_TIME))
	end)

	if kind == "file" then
		table.insert(loaders, function()
			if source ~= nil or loading then return end
			loading = true

			task.spawn(function()
				local loaded = fetchService.fetchReference(value)
				loading = false

				if loaded == nil then
					label.Text = referenceConfig.labels.failed
					return
				end

				source = loaded
				showCode(label, codeHighlight:apply(loaded))
			end)
		end)
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

-- a block of a section. Code blocks that read their text from the repo add their load function to loaders
local function createBlock(block, loaders)
	local kind = block[1]

	if kind == "title" then
		return createTitle(block[2])
	elseif kind == "cases" then
		return createCases()
	elseif kind == "invite" then
		return createInviteButton(frameworkSettings.links.discord)
	elseif kind == "code" or kind == "file" then
		return createCode(kind, block[2], loaders)
	end

	return createParagraph(block[2], kind == "bold")
end

local function createSection(order, blocks, isLast, loaders)
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
		local element = createBlock(block, loaders)
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

-- a BACK or NEXT button: a tonal pill with an icon and a label. The icon sits before the label (BACK) or after it (NEXT)
local function createNavButton(parent, name: string, text: string, iconName: string, iconFirst: boolean, order: number)
	local button = createService.new("TextButton", name, parent, {
		AutoButtonColor = false,
		AutomaticSize = Enum.AutomaticSize.X,
		BorderSizePixel = 0,
		LayoutOrder = order,
		Size = UDim2.new(0, 0, 0, NAV_BUTTON_HEIGHT),
		Text = "",
		ThemeTag = { BackgroundColor3 = "Colors.Tonal.Default" },
		createService.new("UICorner", { CornerRadius = UDim.new(0.5, 0) }),
		createService.new("UIPadding", {
			PaddingLeft = UDim.new(0, NAV_PADDING),
			PaddingRight = UDim.new(0, NAV_PADDING),
		}),
		createService.new("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			Padding = UDim.new(0, NAV_GAP),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
	})

	local icon = createService.new("ImageLabel", "Icon", button, {
		BackgroundTransparency = 1,
		LayoutOrder = if iconFirst then 1 else 2,
		Size = UDim2.fromOffset(NAV_ICON, NAV_ICON),
		ThemeTag = { ImageColor3 = "Colors.Tonal.Text" },
	})
	assetsService:loadImage(icon, iconName)

	local label = createService.new("TextLabel", "Label", button, {
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		LayoutOrder = if iconFirst then 2 else 1,
		Size = UDim2.new(0, 0, 1, 0),
		Text = text,
		TextSize = NAV_TEXT_SIZE,
		ThemeTag = {
			Font = "Font.Medium",
			TextColor3 = "Colors.Tonal.Text",
		},
	})

	return { button = button, label = label, icon = icon, enabled = false }
end

-- a button is tonal while it can be used, and disabled while it cannot (the first page has no BACK, the last no NEXT)
local function paintNavButton(part, enabled: boolean, duration: number)
	local container = if enabled then "Colors.Tonal.Default" else "Colors.Tonal.Disabled"
	local content = if enabled then "Colors.Tonal.Text" else "Colors.Tonal.DisabledText"

	-- the first paint is not an animation: it would fade in from the default button color
	if not part.painted then
		duration = 0
		part.painted = true
	end

	part.enabled = enabled
	repaint(part.button, { BackgroundColor3 = container }, duration)
	-- the theme service replaces an object's tags, so the font goes with the color
	repaint(part.label, { Font = "Font.Medium", TextColor3 = content }, duration)
	repaint(part.icon, { ImageColor3 = content }, duration)

	-- a button that changed (or was left) drops its hover tint
	tween(part.button, "transparency", duration, { BackgroundTransparency = 0 })
end

local function setNavHover(part, hovered: boolean)
	local transparency = if hovered and part.enabled then NAV_HOVER_TRANSPARENCY else 0
	tween(part.button, "transparency", tweenService:getScale(HOVER_TWEEN_TIME), { BackgroundTransparency = transparency })
end

-- the thumb slides under the tab at order (1 = the first tab)
local function moveThumb(thumb, order: number, duration: number)
	tween(thumb, "position", duration, { Position = UDim2.new((order - 1) / PAGE_COUNT, 0, 0, 0) })
end

function reference.new()
	return setmetatable({
		isOpen = false,
		pages = {},
		onOpenChanged = nil, -- called with true / false when the window opens or closes (the top bar button follows it)
	}, reference)
end

function reference:setOpen(open: boolean)
	self.isOpen = open

	if self.onOpenChanged then
		self.onOpenChanged(open)
	end
end

function reference:open()
	self:setOpen(true)
	self.frame:TweenPosition(SHOWN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, WINDOW_TWEEN_TIME, true)
end

function reference:close()
	self:setOpen(false)
	self.frame:TweenPosition(HIDDEN_POSITION, Enum.EasingDirection.InOut, Enum.EasingStyle.Quart, WINDOW_TWEEN_TIME, true)
end

function reference:refreshScroll()
	local entry = self.activeEntry
	if not entry then return end

	local scale = math.max(scaleObject:getScale(), 0.01)
	self.scrollBar:setTotalSpace(math.ceil(entry.body.AbsoluteSize.Y / scale))
	self.scrollBar:setVisibleSpace(math.ceil(self.container.AbsoluteSize.Y / scale))
	entry.body.Position = UDim2.fromOffset(0, -self.scrollBar.index)
end

function reference:loadEntry(entry)
	for _, load in entry.loaders do
		load()
	end
end

function reference:updateNavigation(page, animate: boolean)
	local duration = if animate then tweenService:getScale(COLOR_TWEEN_TIME) else 0

	paintNavButton(self.nav.back, page.index > 1, duration)
	paintNavButton(self.nav.forward, page.index < #page.entries, duration)
	self.counter.Text = `{page.index} / {#page.entries}`
end

-- shows the entry at index of a page. direction is 1 when moving forward (the new entry comes in from the right),
-- -1 when moving back, and 0 for the first entry, which is shown at once
function reference:transitionTo(page, index: number, direction: number)
	local entry = page.entries[index]
	local previous = self.activeEntry
	if entry == nil or entry == previous then return end

	local duration = if direction == 0 or previous == nil then 0 else tweenService:getScale(PAGE_TWEEN_TIME)

	self.activeEntry = entry
	page.index = index

	entry.slide.Visible = true
	self:loadEntry(entry)
	if page.paged then
		self:updateNavigation(page, duration > 0)
	end

	-- the new entry comes in from its side, and its text fades in
	tween(entry.slide, "position", 0, { Position = UDim2.new(0, direction * SLIDE_DISTANCE, 0, 0) })
	tween(entry.slide, "position", duration, { Position = UDim2.new(0, 0, 0, 0) })
	for _, text in textObjects(entry.slide) do
		tween(text, "text", 0, { TextTransparency = 1 })
		tween(text, "text", duration, { TextTransparency = 0 })
	end

	-- the old entry leaves the other way, and is hidden once it is gone (unless it came back meanwhile)
	if previous then
		tween(previous.slide, "position", duration, { Position = UDim2.new(0, -direction * SLIDE_DISTANCE, 0, 0) }, function()
			if self.activeEntry ~= previous then
				previous.slide.Visible = false
			end
		end)
		for _, text in textObjects(previous.slide) do
			tween(text, "text", duration, { TextTransparency = 1 })
		end
	end

	self.scrollBar:scrollTo(0)
	self:refreshScroll()
end

function reference:turnPage(delta: number)
	local page = self.activePage
	if not page or not page.paged then return end

	local index = page.index + delta
	if index < 1 or index > #page.entries then return end

	self:transitionTo(page, index, delta)
end

-- the footer with BACK | NEXT and the content height change with the tab: a paged tab grows the footer in from the
-- bottom edge, and the content gives up the room it takes
function reference:setPaged(paged: boolean, instant: boolean)
	local duration = if instant then 0 else tweenService:getScale(TAB_TWEEN_TIME)
	local navigation = self.navigation

	tween(self.holder, "size", duration, {
		Size = UDim2.new(1, 0, 0, if paged then PAGED_CONTENT_HEIGHT else CONTENT_HEIGHT),
	})

	if paged then
		cancelTween(navigation, "position")
		if duration > 0 then
			navigation.Position = NAV_HIDDEN
		end
		navigation.Visible = true
		tween(navigation, "position", duration, { Position = NAV_SHOWN })
	else
		tween(navigation, "position", duration, { Position = NAV_HIDDEN }, function()
			if not self.activePage or not self.activePage.paged then
				navigation.Visible = false
			end
		end)
	end
end

function reference:selectPage(id: string): boolean
	local selected = self.pages[id]
	if not selected then return false end
	if self.activePage == selected then return true end

	local previousPage = self.activePage
	local isFirst = previousPage == nil
	local direction = if isFirst then 0 elseif selected.order > previousPage.order then 1 else -1

	self.activePage = selected
	self.pageId = id

	moveThumb(self.thumb, selected.order, if isFirst then 0 else tweenService:getScale(TAB_TWEEN_TIME))
	self:setPaged(selected.paged, isFirst)
	self:transitionTo(selected, selected.index, direction)
	return true
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

	-- the Types / Plugins switch: a dark track, a lighter thumb under the selected tab (like Chat / Joins)
	local tabs = createService.new("Frame", "Tabs", frame, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT),
		Size = UDim2.new(1, 0, 0, TABS_HEIGHT),
	})

	local track = createService.new("Frame", "Track", tabs, {
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(TAB_INSET, TAB_INSET),
		Size = UDim2.new(1, -TAB_INSET * 2, 1, -TAB_INSET * 2),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},
		createService.new("UICorner", { CornerRadius = PILL }),
	})

	local thumb = createService.new("Frame", "Thumb", track, {
		BorderSizePixel = 0,
		Size = UDim2.new(1 / PAGE_COUNT, 0, 1, 0),
		ThemeTag = {
			BackgroundColor3 = "Colors.Border.Holding",
		},
		createService.new("UICorner", { CornerRadius = PILL }),
	})
	self.thumb = thumb

	local scrollBar = scrollBarComponent.new({
		isHorizontal = false,
		barThickness = SCROLL_THICKNESS,
		increment = SCROLL_INCREMENT,
		wheelIncrement = SCROLL_WHEEL_INCREMENT,
	})

	local scrollBarFrame = scrollBar:create()
	local container = scrollBar.container

	local holder = createService.new("Frame", "ScrollHolder", frame, {
		Active = true,
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT + TABS_HEIGHT),
		Size = UDim2.new(1, 0, 0, CONTENT_HEIGHT),

		scrollBarFrame,
		container,
	})

	-- the footer holds the navigation row. It is clipped, so the row slides up from the bottom edge of the window
	local footer = createService.new("Frame", "Footer", frame, {
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Position = UDim2.fromOffset(0, TOP_BAR_HEIGHT + TABS_HEIGHT + PAGED_CONTENT_HEIGHT),
		Size = UDim2.new(1, 0, 0, FOOTER_HEIGHT),
	})

	-- BACK, the page counter and NEXT, grouped at the right of the footer
	local navigation = createService.new("Frame", "Navigation", footer, {
		BackgroundTransparency = 1,
		Position = NAV_HIDDEN,
		Size = UDim2.new(1, 0, 1, 0),
		Visible = false,
		createService.new("UIPadding", { PaddingRight = UDim.new(0, NAV_MARGIN) }),
		createService.new("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, NAV_GAP),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
	})

	local back = createNavButton(navigation, "Back", referenceConfig.navigation.back, "lucide-arrow-left", true, 1)

	local counter = createService.new("TextLabel", "Counter", navigation, {
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.new(0, 0, 0, NAV_BUTTON_HEIGHT),
		Text = "1 / 1",
		TextSize = NAV_TEXT_SIZE,
		ThemeTag = {
			Font = "Font.Medium",
			TextColor3 = "Colors.Text.Dark",
		},
	})

	local forward = createNavButton(navigation, "Next", referenceConfig.navigation.next, "lucide-arrow-right", false, 3)

	for _, part in { back, forward } do
		connectionService:Connect(part.button.MouseEnter, function()
			setNavHover(part, true)
		end)
		connectionService:Connect(part.button.MouseLeave, function()
			setNavHover(part, false)
		end)
	end

	self.scrollBar = scrollBar
	self.container = container
	self.holder = holder
	self.footer = footer
	self.navigation = navigation
	self.counter = counter
	self.nav = { back = back, forward = forward }

	-- an entry is one screen of a tab: it sits in a slide (moved sideways when the page changes), and its body is moved
	-- up and down by the scroll
	local function addEntry(page, body, loaders)
		local slide = createService.new("Frame", "Slide", container, {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			Visible = false,
		})
		body.Parent = slide

		local entry = { slide = slide, body = body, loaders = loaders }
		table.insert(page.entries, entry)

		connectionService:Connect(body:GetPropertyChangedSignal("AbsoluteSize"), function()
			if self.activeEntry == entry then
				self:refreshScroll()
			end
		end)
	end

	-- each tab: a button on the track, and its entries. A paged tab has one entry per section; the other tab is one
	-- entry with every section in it
	for pageOrder, pageConfig in PAGES do
		local button = createService.new("TextButton", pageConfig.id, track, {
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Position = UDim2.new((pageOrder - 1) / PAGE_COUNT, 0, 0, 0),
			Size = UDim2.new(1 / PAGE_COUNT, 0, 1, 0),
			Text = pageConfig.title,
			TextSize = 13,
			ThemeTag = {
				Font = "Font.Bold",
				TextColor3 = "Colors.Text.Default",
			},
		})

		local paged = pageConfig.paged == true
		local page = {
			id = pageConfig.id,
			order = pageOrder,
			button = button,
			paged = paged,
			entries = {},
			index = 1,
		}

		if paged then
			for order, blocks in pageConfig.sections do
				local loaders = {}
				addEntry(page, createSection(order, blocks, true, loaders), loaders)
			end
		else
			local loaders = {}
			local body = createService.new("Frame", "Content", {
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 0),
				createService.new("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }),
			})

			for order, blocks in pageConfig.sections do
				local section = createSection(order, blocks, order == #pageConfig.sections, loaders)
				section.Parent = body
			end

			addEntry(page, body, loaders)
		end

		self.pages[pageConfig.id] = page

		connectionService:Connect(button.Activated, function()
			self:selectPage(pageConfig.id)
		end)
	end

	connectionService:Connect(back.button.Activated, function()
		self:turnPage(-1)
	end)
	connectionService:Connect(forward.button.Activated, function()
		self:turnPage(1)
	end)

	-- the body moves by its own position; everything is in logical units (without the UI scale)
	local function applyScroll(index)
		if self.activeEntry then
			self.activeEntry.body.Position = UDim2.fromOffset(0, -index)
		end
	end

	connectionService:Connect(scrollBar.scrolledSignal, applyScroll)
	connectionService:Connect(container:GetPropertyChangedSignal("AbsoluteSize"), function()
		self:refreshScroll()
	end)

	connectionService:Connect(closeButton.Activated, function()
		self:close()
	end)

	dragInstance:addGuiObject(frame)

	dragInstance.dragStarted:Connect(function(object)
		if object ~= frame then return end
		scrollBar:disableScroll()
	end)

	dragInstance.dragEnded:Connect(function(object)
		if object ~= frame then return end
		scrollBar:enableScroll()
	end)

	self:selectPage(PAGES[1].id)

	self.frame = frame
	self.closeIcon = closeIcon

	return frame
end

return reference
