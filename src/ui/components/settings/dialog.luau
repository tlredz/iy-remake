-- src/ui/components/settings/dialog.luau
-- A dialog over the settings panel: a dimmed layer that covers the panel, and a box in the middle with a title, a
-- message and buttons. Nothing under the dialog can be tapped while it is open. Tapping one of its buttons closes it,
-- and then runs that button's onTap, if it has one. The panel makes one dialog (see settings/init.luau), and every
-- page reaches it through ctx.dialog.
--
-- dialog:show(title, message, choices) opens it, where choices is { { text, primary?, onTap? }, ... }. primary makes
-- a button the main colour. dialog:hide() closes it without running any button.

local createService = require("../../services/createService")
local widgets = require("./widgets")
local config = require("../../../framework/config/ui/settings")

local PANEL = config.panel
local VALUE = config.value
local TEXT = config.textSizes
local DIALOG = config.dialog

local dialog = {}
dialog.__index = dialog

-- makes the dialog inside the holder of the panel. It starts hidden
function dialog.new(holder: GuiObject)
	local overlay = createService.new("Frame", "Dialog", holder, {
		Active = true,
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = DIALOG.dimTransparency,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1, 1),
		Visible = false,
		ZIndex = DIALOG.zIndex,
	})

	local card = createService.new("Frame", "Card", overlay, {
		AnchorPoint = Vector2.new(0.5, 0.5),
		AutomaticSize = Enum.AutomaticSize.Y,
		BorderSizePixel = 0,
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -2 * DIALOG.margin, 0, 0),
		ThemeTag = {
			BackgroundColor3 = "Colors.Background",
		},

		createService.new("UICorner", {
			CornerRadius = UDim.new(0, VALUE.cornerRadius),
		}),
		createService.new("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Thickness = 1,
			ThemeTag = {
				Color = "Colors.Border.Default",
			},
		}),
		createService.new("UIPadding", {
			PaddingBottom = UDim.new(0, DIALOG.padding),
			PaddingLeft = UDim.new(0, DIALOG.padding),
			PaddingRight = UDim.new(0, DIALOG.padding),
			PaddingTop = UDim.new(0, DIALOG.padding),
		}),
		createService.new("UIListLayout", {
			Padding = UDim.new(0, DIALOG.gap),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	local title = createService.new("TextLabel", "Title", card, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 1,
		Size = UDim2.new(1, 0, 0, 0),
		Text = "",
		TextSize = TEXT.label,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		ThemeTag = {
			Font = "Font.Normal",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local message = createService.new("TextLabel", "Message", card, {
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		LayoutOrder = 2,
		Size = UDim2.new(1, 0, 0, 0),
		Text = "",
		TextSize = TEXT.value,
		TextWrapped = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top,
		ThemeTag = {
			Font = "Font.MonoSpace",
			TextColor3 = "Colors.Text.Default",
		},
	})

	local buttons = createService.new("Frame", "Buttons", card, {
		BackgroundTransparency = 1,
		LayoutOrder = 3,
		Size = UDim2.new(1, 0, 0, PANEL.rowHeight),

		createService.new("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			Padding = UDim.new(0, PANEL.rowGap),
			SortOrder = Enum.SortOrder.LayoutOrder,
			VerticalAlignment = Enum.VerticalAlignment.Center,
		}),
	})

	return setmetatable({
		overlay = overlay,
		title = title,
		message = message,
		buttons = buttons,
	}, dialog)
end

-- opens the dialog with a title, a message and the buttons (choices, see the top of this file)
function dialog:show(title: string, message: string, choices: { { text: string, primary: boolean?, onTap: (() -> ())? } })
	self.title.Text = title
	self.message.Text = message

	-- the buttons of the last dialog go, and their connections with them
	widgets.clear(self.buttons)

	for index, choice in choices do
		local button = createService.new("TextButton", "Button", self.buttons, {
			AutoButtonColor = false,
			BorderSizePixel = 0,
			LayoutOrder = index,
			Size = UDim2.fromOffset(DIALOG.buttonWidth, PANEL.rowHeight),
			Text = choice.text,
			TextSize = TEXT.label,
			ThemeTag = {
				BackgroundColor3 = if choice.primary then "Colors.Primary" else "Colors.Buttons.Default",
				Font = "Font.Normal",
				TextColor3 = "Colors.Text.Default",
			},

			createService.new("UICorner", {
				CornerRadius = UDim.new(0, VALUE.cornerRadius),
			}),
		})

		button.Activated:Connect(function()
			self:hide()

			if choice.onTap then
				choice.onTap()
			end
		end)
	end

	self.overlay.Visible = true
end

-- closes the dialog without running any of its buttons
function dialog:hide()
	self.overlay.Visible = false
end

return dialog
