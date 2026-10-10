local rbxServices = require("../../../framework/services/rbxServices")
local chatSender = require("../../systems/chatSender")

local function setChatWindow(enabled: boolean)
	if chatSender.isLegacy() then
		rbxServices.StarterGui:SetCore("ChatActive", enabled)
	else
		rbxServices.TextChatService.ChatWindowConfiguration.Enabled = enabled
	end
end

-- The same colors as the IY darkchat, on the TextChatService configurations
local function darkenChat()
	local textChat = rbxServices.TextChatService

	local settings = {
		{ textChat:FindFirstChildOfClass("BubbleChatConfiguration"), {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 0.3,
			TailVisible = true,
		} },
		{ textChat:FindFirstChildOfClass("ChatWindowConfiguration"), {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 0.3,
			TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF),
			TextStrokeColor3 = Color3.fromRGB(),
			TextStrokeTransparency = 0.5,
		} },
		{ textChat:FindFirstChildOfClass("ChatInputBarConfiguration"), {
			Enabled = true,
			BackgroundColor3 = Color3.fromRGB(),
			BackgroundTransparency = 0.5,
			PlaceholderColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF),
			TextColor3 = Color3.fromRGB(0xFF, 0xFF, 0xFF),
			TextStrokeColor3 = Color3.fromRGB(),
			TextStrokeTransparency = 0.5,
		} },
	}

	for _, pair in settings do
		local configuration, properties = pair[1], pair[2]
		if configuration then
			for name, value in properties do
				configuration[name] = value
			end
		end
	end
end

return {
	{
		action = "chatwindow",
		description = "Enables the chat window for your client",
		client = true,
		run = function()
			setChatWindow(true)
		end
	},
	{
		action = "unchatwindow|nochatwindow",
		description = "Disables the chat window for your client",
		client = true,
		run = function()
			setChatWindow(false)
		end
	},
	{
		action = "darkchat",
		description = "Makes the chat window dark for your client",
		client = true,
		run = function(self)
			if chatSender.isLegacy() then
				self:notify("Dark Chat", "darkchat only works with the TextChatService chat")
				return
			end
			darkenChat()
		end
	}
}
