local resolvePlayers = require("../../systems/resolvePlayers")

return {
	{
		client = true,
		action = "muteboombox",
		description = "Mutes someones boombox",
		args = {
			kind = "player"
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				for _, container in { player.Character, player:FindFirstChildOfClass("Backpack") } do
					for _, sound in container:GetDescendants() do
						if sound:IsA("Sound") then
							sound.Playing = false
						end
					end
				end
			end
		end
	},
	{
		client = true,
		action = "unmuteboombox",
		description = "Unmutes someones boombox",
		args = {
			kind = "player"
		},
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				local character = player.Character
				if not character then return end
				
				for _, sound in character:GetDescendants() do
					if sound:IsA("Sound") and not sound.Playing then
						sound.Playing = true
					end
				end
			end
		end
	}
}
