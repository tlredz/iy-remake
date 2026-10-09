local resolvePlayers = require("../../systems/resolvePlayers")

return {
	{
		action = "copyid|copyuserid",
		description = "Copies a player's user ID to your clipboard",
		args = { kind = "player", optional = true },
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self.executorEnv.setclipboard(tostring(player.UserId))
			end
		end
	},
	{
		action = "appearanceid|aid",
		description = "Notifies a player's character appearance ID",
		args = { kind = "player", optional = true },
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self:notify("Appearance ID", tostring(player.CharacterAppearanceId))
			end
		end
	},
	{
		action = "copyappearanceid|caid",
		description = "Copies a player's character appearance ID to your clipboard",
		args = { kind = "player", optional = true },
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self.executorEnv.setclipboard(tostring(player.CharacterAppearanceId))
			end
		end
	},
	{
		action = "copycreatorid|copycreator",
		description = "Copies the game creator's user ID to your clipboard",
		run = function(self)
			local creatorId = game.CreatorId
			
			if game.CreatorType == Enum.CreatorType.Group then
				creatorId = self.groupService:GetGroupInfoAsync(creatorId).Owner.Id
			elseif game.CreatorType ~= Enum.CreatorType.User then
				return
			end
			
			self.executorEnv.setclipboard(tostring(creatorId))
			self:notify("Copied ID", "Copied creator ID to clipboard")
		end
	}
}
