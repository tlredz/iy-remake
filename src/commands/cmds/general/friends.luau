local resolvePlayers = require("../../systems/resolvePlayers")

return {
	{
		action = "friend",
		description = "Sends a friend request to a player",
		args = { kind = "player" },
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self.localPlayer:RequestFriendship(player)
			end
		end
	},
	{
		action = "unfriend",
		description = "Removes a player from your friends",
		args = { kind = "player" },
		run = function(self, args)
			for _, player in resolvePlayers(args:nextValue()) do
				self.localPlayer:RevokeFriendship(player)
			end
		end
	}
}
