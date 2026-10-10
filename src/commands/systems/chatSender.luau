-- Sends a chat message for both chat systems. Same logic as the IY chatMessage helper:
-- the legacy chat takes a SayMessageRequest event, TextChatService takes SendAsync on RBXGeneral.

local rbxServices = require("../../framework/services/rbxServices")

local chatSender = {}

function chatSender.isLegacy(): boolean
	return rbxServices.TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService
end

-- Returns true when the message was sent. Otherwise returns false and the reason.
function chatSender.send(message: string): (boolean, string?)
	message = tostring(message)

	local success, reason = pcall(function()
		if chatSender.isLegacy() then
			rbxServices.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
		else
			rbxServices.TextChatService.TextChannels.RBXGeneral:SendAsync(message)
		end
	end)

	return success, if success then nil else tostring(reason)
end

return chatSender
