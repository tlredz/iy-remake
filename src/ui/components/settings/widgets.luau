-- src/ui/components/settings/widgets.luau
-- The parts the settings panel and its editor pages are built from: pages, headers, rows, boxes, value boxes,
-- row buttons, text boxes, keybind boxes and notes. They are themed through ThemeTag, so they follow the theme when it changes.
--
-- A list is where rows and headers go, one after another. It is a table made by widgets.list around a frame that
-- has a UIListLayout (a page, or a group made by widgets.group). A header restarts the row stripes.

local createService = require("../../services/createService")
local assetsService = require("../../services/assetsService")
local themeService = require("../../services/themeService")
local keyboardService = require("../../../framework/services/keyboardService")
local config = require("../../../framework/config/ui/settings")

local PANEL = config.panel
local ROW = config.row
local BOX = config.box
local VALUE = config.value
local TEXT = config.textSizes

local widgets = {}

-- a row shows its stripe when idle, and the holding colour while the pointer is over it
local function paintRow(row: GuiObject, stripe: number, hovered: boolean)
	themeService:updateObjectProperties(row, {
		BackgroundColor3 = if hovered then "Colors.Buttons.Holding" else "Colors.Buttons.Default",
	})
	row.BackgroundTransparency = if hovered then 0 else stripe
end

-- a scrolling page. The main panel and every editor page is one of these, placed at `position`
function widgets.page(holder: Frame, name: string, position: UDim2): ScrollingFrame
	return createService.new("ScrollingFrame", name, holder, {
		Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
		ElasticBehavior = Enum.ElasticBehavior.Never,
		Position = position,
		ScrollBarThickness = PANEL.scrollBarThickness,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Size = UDim2.fromScale(1, 1),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
			ScrollBarImageColor3 = "Colors.ScrollBar.Thumb",
		},

		createService.new("UIPadding", {
			PaddingLeft = UDim.new(0, PANEL.padding),
			PaddingRight = UDim.new(0, PANEL.padding),
			PaddingTop = UDim.new(0, PANEL.padding),
			PaddingBottom = UDim.new(0, PANEL.padding),
		}),
		createService.new("UIListLayout", {
			Padding = UDim.new(0, PANEL.rowGap),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
end

-- stops theming a destroyed object and everything in it
local function forgetTree(root: Instance)
	themeService:removeObject(root)

	for _, descendant in root:GetDescendants() do
		themeService:removeObject(descendant)
	end
end

-- removes what was added to a page or group, and keeps its layout and padding
function widgets.clear(parent: GuiObject)
	for _, child in parent:GetChildren() do
		if not (child:IsA("UIListLayout") or child:IsA("UIPadding")) then
			forgetTree(child)
			child:Destroy()
		end
	end
end

-- the list that rows go into
function widgets.list(parent: GuiObject)
	return { parent = parent, order = 0, index = 0 }
end

-- a frame that rows can go into by themselves: it grows with its rows, and can be cleared and filled again
function widgets.group(list): Frame
	list.order += 1

	return createService.new("Frame", "Group", list.parent, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, 0),

		createService.new("UIListLayout", {
			Padding = UDim.new(0, PANEL.rowGap),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})
end

function widgets.header(list, title: string): TextLabel
	list.order += 1
	list.index = 0

	return createService.new("TextLabel", "Header", list.parent, {
		BackgroundTransparency = 1,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, PANEL.headerHeight),
		Text = title,
		TextSize = TEXT.header,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Darker",
		},
	})
end

-- adds a row: a button that holds a label, a box or a value box
function widgets.row(list): TextButton
	list.order += 1
	list.index += 1

	local stripe = if list.index % 2 == 1 then PANEL.stripeTransparency else 1

	local row = createService.new("TextButton", "Option", list.parent, {
		AutoButtonColor = false,
		BackgroundTransparency = stripe,
		BorderSizePixel = 0,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, PANEL.rowHeight),
		Text = "",
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},
	})

	-- the rows of a page are built again each time it opens: widgets.clear destroys them with their connections
	row.MouseEnter:Connect(function()
		paintRow(row, stripe, true)
	end)

	row.MouseLeave:Connect(function()
		paintRow(row, stripe, false)
	end)

	return row
end

-- a row that goes back to the page before it (the back icon and text), with the header of the page under it
function widgets.pageTop(list, title: string?, onBack: () -> ())
	local back = widgets.row(list)
	back.Name = "BackRow"
	widgets.icon(back, config.pages.backIcon)
	widgets.label(back, config.pages.back, 0)
	back.Activated:Connect(onBack)

	if title then
		widgets.header(list, title)
	end
end

-- the text of a row. rightSpace is the width the box on the right takes; color is a theme path
function widgets.label(row: GuiObject, text: string, rightSpace: number, color: string?): TextLabel
	return createService.new("TextLabel", "Label", row, {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(ROW.labelInset, 0),
		Size = UDim2.new(1, -(ROW.labelInset + rightSpace), 1, 0),
		Text = text,
		TextSize = TEXT.label,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = color or "Colors.Text.Default",
		},
	})
end

function widgets.icon(row: GuiObject, iconName: string): ImageLabel
	local icon = createService.new("ImageLabel", "Icon", row, {
		AnchorPoint = Vector2.new(0, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0, ROW.iconInset, 0.5, 0),
		Size = UDim2.fromOffset(ROW.iconSize, ROW.iconSize),
		ThemeTag = {
			ImageColor3 = "Colors.Icons",
		},
	})

	assetsService:loadImage(icon, iconName)
	return icon
end

-- a small arrow at the right of a row that opens a page. It is the back icon turned around
function widgets.chevron(row: GuiObject): ImageLabel
	local icon = createService.new("ImageLabel", "Chevron", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Rotation = 180,
		Size = UDim2.fromOffset(ROW.chevronSize, ROW.chevronSize),
		ThemeTag = {
			ImageColor3 = "Colors.Text.Darker",
		},
	})

	assetsService:loadImage(icon, config.pages.backIcon)
	return icon
end

-- A small button at the right of a row ("Del", "Reload"). rightOffset is the space from the right edge of the row to
-- the button, so several buttons can sit side by side: the first one at PANEL.padding, the next one at
-- PANEL.padding + the width of the first + PANEL.rowGap, and so on. The button takes the tap, so the row does not
-- get it. Returns the TextButton
function widgets.rowButton(row: GuiObject, text: string, rightOffset: number, width: number): TextButton
	local button = createService.new("TextButton", "RowButton", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Position = UDim2.new(1, -rightOffset, 0.5, 0),
		Size = UDim2.fromOffset(width, VALUE.height + 4),
		Text = text,
		TextSize = TEXT.value,
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})

	button.MouseEnter:Connect(function()
		themeService:updateObjectProperties(button, {
			BackgroundColor3 = "Colors.Primary",
		})
	end)

	button.MouseLeave:Connect(function()
		themeService:updateObjectProperties(button, {
			BackgroundColor3 = "Colors.Background",
		})
	end)

	return button
end

-- an on/off box at the right of a row. Returns the box and its fill, which is shown when the option is on
function widgets.box(row: GuiObject): (Frame, Frame)
	local box = createService.new("Frame", "Box", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Size = UDim2.fromOffset(BOX.size, BOX.size),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, BOX.cornerRadius),
		}),
		createService.new("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,
			ThemeTag = {
				Color = "Colors.Border.Default",
			},
		}),
	})

	local fill = createService.new("Frame", "Fill", box, {
		BorderSizePixel = 0,
		Position = UDim2.fromOffset(BOX.inset, BOX.inset),
		Size = UDim2.new(1, -2 * BOX.inset, 1, -2 * BOX.inset),
		ThemeTag = {
			BackgroundColor3 = "Colors.Primary",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, BOX.fillCornerRadius),
		}),
	})

	return box, fill
end

-- a box at the right of a row that shows some text. Returns the box and its text label
function widgets.value(row: GuiObject, text: string, width: number): (Frame, TextLabel)
	local value = createService.new("Frame", "Value", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Size = UDim2.fromOffset(width, VALUE.height),
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})

	local label = createService.new("TextLabel", "Text", value, {
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		Text = text,
		TextSize = TEXT.value,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},
	})

	return value, label
end

-- a value box that can be typed in: like widgets.value, but the box holds the text that is typed. Returns the TextBox
function widgets.valueInput(row: GuiObject, text: string, width: number): TextBox
	return createService.new("TextBox", "ValueInput", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Size = UDim2.fromOffset(width, VALUE.height),
		Text = text,
		TextSize = TEXT.value,
		TextXAlignment = Enum.TextXAlignment.Center,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})
end

-- a box that shows the key of a binding. Tapping it waits for the next key press to become the new key;
-- tapping again, or Escape, cancels. onChanged runs after a new key is set.
-- Returns refresh (redraws the box) and stop (ends a wait, when the panel closes or the command bar takes focus)
function widgets.keybind(row: GuiObject, bindingName: string, onChanged: (() -> ())?): (() -> (), () -> ())
	local value, text = widgets.value(row, "", VALUE.keybindWidth)
	local cancelWait = nil
	
	local function refresh()
		local waiting = cancelWait ~= nil
		
		text.Text = if waiting then "press a key" else keyboardService:getBindingName(bindingName)
		themeService:updateObjectProperties(value, {
			BackgroundColor3 = if waiting then "Colors.Primary" else "Colors.Buttons.Default",
		})
	end

	local function stop()
		if cancelWait then
			local cancel = cancelWait
			cancelWait = nil
			cancel()
		end

		refresh()
	end

	row.Activated:Connect(function()
		if cancelWait then
			stop()
			return
		end

		cancelWait = keyboardService:capture(function(keyCode)
			cancelWait = nil
			keyboardService:setBinding(bindingName, keyCode)
			refresh()

			if onChanged then
				onChanged()
			end
		end, function()
			-- Escape
			cancelWait = nil
			refresh()
		end)

		refresh()
	end)

	refresh()
	return refresh, stop
end

-- a box to type in. Returns the TextBox
function widgets.textBox(list, placeholder: string): TextBox
	list.order += 1

	return createService.new("TextBox", "Input", list.parent, {
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		LayoutOrder = list.order,
		PlaceholderText = placeholder,
		Size = UDim2.new(1, 0, 0, PANEL.rowHeight),
		Text = "",
		TextSize = TEXT.value,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			BackgroundColor3 = "Colors.Buttons.Default",
			Font = "Font.MonoSpace",
			PlaceholderColor3 = "Colors.Text.Darker",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UIPadding", {
			PaddingLeft = UDim.new(0, ROW.labelInset / 2),
			PaddingRight = UDim.new(0, PANEL.padding),
		}),
		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})
end

-- a grid of buttons where you tap the one you want (the chosen one is coloured). `labels` are the texts, in order.
-- onSelect(index) runs when one is tapped. Returns select(index), which only moves the colour
function widgets.choices(list, labels: { string }, onSelect: (number) -> (), columns: number): (number) -> ()
	list.order += 1

	local gap = PANEL.rowGap
	local frame = createService.new("Frame", "Choices", list.parent, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, 0),

		createService.new("UIGridLayout", {
			CellPadding = UDim2.fromOffset(gap, gap),
			CellSize = UDim2.new(1 / columns, -gap * (columns - 1) / columns - 1, 0, PANEL.rowHeight - 3),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local buttons = {}

	local function select(index: number)
		for position, button in buttons do
			themeService:updateObjectProperties(button, {
				BackgroundColor3 = if position == index then "Colors.Primary" else "Colors.Buttons.Default",
			})
		end
	end

	for index, label in labels do
		local button = createService.new("TextButton", "Choice", frame, {
			AutoButtonColor = false,
			BorderSizePixel = 0,
			LayoutOrder = index,
			Text = label,
			TextSize = TEXT.value,
			TextTruncate = Enum.TextTruncate.AtEnd,
			ThemeTag = {
				BackgroundColor3 = "Colors.Buttons.Default",
				Font = "Font.MonoSpace",
				TextColor3 = "Colors.Text.Default",
			},

			createService.new("UICorner", {
				CornerRadius = UDim.new(0, VALUE.cornerRadius),
			}),
		})

		buttons[index] = button

		button.Activated:Connect(function()
			select(index)
			onSelect(index)
		end)
	end

	return select
end

-- a row with a label on the left and a box to type in on the right. Returns the row and the TextBox
function widgets.inputRow(list, label: string, placeholder: string, text: string?): (TextButton, TextBox)
	local row = widgets.row(list)
	widgets.label(row, label, VALUE.inputWidth + 2 * PANEL.padding)

	local input = createService.new("TextBox", "Input", row, {
		AnchorPoint = Vector2.new(1, 0.5),
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		PlaceholderText = placeholder,
		Position = UDim2.new(1, -PANEL.padding, 0.5, 0),
		Size = UDim2.fromOffset(VALUE.inputWidth, VALUE.height),
		Text = text or "",
		TextSize = TEXT.value,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
			Font = "Font.MonoSpace",
			PlaceholderColor3 = "Colors.Text.Darker",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UIPadding", {
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
		}),
		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})

	return row, input
end

-- one line with a box for a command, a small box for a delay and a button that adds. Returns the two boxes and the button.
-- secondWidth is the width of the small box (VALUE.formDelayWidth when left out)
function widgets.formRow(list, commandHint: string, delayHint: string, addLabel: string, secondWidth: number?): (TextBox, TextBox, TextButton)
	list.order += 1

	local gap = PANEL.rowGap
	local addWidth = VALUE.addWidth
	local delayWidth = secondWidth or VALUE.formDelayWidth

	local holder = createService.new("Frame", "Form", list.parent, {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, PANEL.rowHeight),
	})

	local function box(name: string, hint: string, anchor: Vector2, position: UDim2, size: UDim2): TextBox
		return createService.new("TextBox", name, holder, {
			AnchorPoint = anchor,
			BorderSizePixel = 0,
			ClearTextOnFocus = false,
			PlaceholderText = hint,
			Position = position,
			Size = size,
			Text = "",
			TextSize = TEXT.value,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextXAlignment = Enum.TextXAlignment.Left,
			ThemeTag = {
				BackgroundColor3 = "Colors.Buttons.Default",
				Font = "Font.MonoSpace",
				PlaceholderColor3 = "Colors.Text.Darker",
				TextColor3 = "Colors.Text.Default",
			},

			createService.new("UIPadding", {
				PaddingLeft = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 4),
			}),
			createService.new("UICorner", {
				CornerRadius = UDim.new(0, VALUE.cornerRadius),
			}),
		})
	end

	local commandBox = box("Command", commandHint, Vector2.zero, UDim2.fromOffset(0, 0),
		UDim2.new(1, -(addWidth + delayWidth + 2 * gap), 1, 0))
	local delayBox = box("Delay", delayHint, Vector2.new(1, 0), UDim2.new(1, -(addWidth + gap), 0, 0),
		UDim2.new(0, delayWidth, 1, 0))

	local addButton = createService.new("TextButton", "Add", holder, {
		AnchorPoint = Vector2.new(1, 0),
		AutoButtonColor = false,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0, addWidth, 1, 0),
		Text = addLabel,
		TextSize = TEXT.label,
		ThemeTag = {
			BackgroundColor3 = "Colors.Primary",
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
	})

	return commandBox, delayBox, addButton
end

-- a small dark line at the end of a list, centred: the version of the program, for example. It is not indented
-- like a note, and it takes no tap
function widgets.footer(list, text: string): TextLabel
	list.order += 1

	return createService.new("TextLabel", "Footer", list.parent, {
		BackgroundTransparency = 1,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, PANEL.headerHeight),
		Text = text,
		TextSize = TEXT.footer,
		TextXAlignment = Enum.TextXAlignment.Center,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Darker",
		},
	})
end

-- a line of text under the rows: a message, or a hint. Its text can be changed later
function widgets.note(list, text: string): TextLabel
	list.order += 1

	return createService.new("TextLabel", "Note", list.parent, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = list.order,
		Size = UDim2.new(1, 0, 0, 0),
		Text = text,
		TextSize = TEXT.value,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Darker",
		},

		-- a list sets Position itself, so the inset is padding
		createService.new("UIPadding", {
			PaddingLeft = UDim.new(0, ROW.labelInset),
		}),
	})
end

return widgets
