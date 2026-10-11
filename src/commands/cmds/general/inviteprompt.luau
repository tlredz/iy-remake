return {
	action = "inviteprompt",
	description = "Prompts the game invite window, so you can invite friends",
	run = function(self)
		local socialService = game:GetService("SocialService")

		local ok, err = pcall(function()
			socialService:PromptGameInvite(self.localPlayer)
		end)

		if not ok then
			self:notify("Invite Prompt", "could not open the invite prompt: " .. tostring(err))
		end
	end
}
