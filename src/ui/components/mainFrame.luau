-- src/ui/components/mainFrame.luau
-- The main window. It is a CanvasGroup, so the whole window can be faded at once (GroupTransparency, see
-- utils/mainFrameDock). A CanvasGroup has no image of its own, so the custom background is an ImageLabel that fills it:
-- the first child, so the top bar is drawn over it (see services/backgroundService).

local createService = require("../services/createService")

local mainFrame = {}

function mainFrame:create()
	local frame = createService.new("CanvasGroup", "MainFrame", {
		Active = true,
		BorderSizePixel = 0,
		ThemeTag = {
			BackgroundColor3 = "Colors.Background"
		},
		createService.new("ImageLabel", "Background", {
			BackgroundTransparency = 1,
			Image = "", -- the custom background of the window (ui/services/backgroundService), when there is one
			ScaleType = Enum.ScaleType.Crop,
			Size = UDim2.fromScale(1, 1),
		}),
		createService.new("Frame", "TopBar", {
			Size = UDim2.fromOffset(250, 20),
			BorderSizePixel = 0,
			ThemeTag = {
				BackgroundColor3 = "Colors.Background"
			}
		})
	})

	local background = frame.Background
	local topBar = frame.TopBar

	local titleLabel = createService.new("TextLabel", "Title", topBar, {
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

	return {
		mainFrame = frame,
		background = background,
		topBar = topBar,
		titleLabel = titleLabel,
		buttons = {
			settings = settingsButton,
			reference = referenceButton
		}
	}
end

return mainFrame
