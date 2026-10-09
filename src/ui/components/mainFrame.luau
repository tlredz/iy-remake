-- src/ui/components/mainFrame.luau

local createService = require("../services/createService")

local mainFrame = {}

function mainFrame:create()
	local frame = createService.new("Frame", "MainFrame", {
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
	})

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
		topBar = topBar,
		titleLabel = titleLabel,
		buttons = {
			settings = settingsButton,
			reference = referenceButton
		}
	}
end

return mainFrame
