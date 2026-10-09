return {
	{
		action = "oldconsole",
		description = "Loads an old-themed Roblox console",
		run = function(self)
			self.fetchService.load("backups/console.luau", "iy/oldconsole")()
		end
	},
	{
		action = "explorer|dex",
		description = "Opens DEX by Moon",
		run = function(self)
			self.fetchService.load("backups/explorer.luau", "iy/explorer")()
		end
	},
	{
		action = "cobalt|cspy",
		description = "Opens Cobalt to intercept incoming and outgoing network traffic",
		run = function(self)
			self.fetchService.load("backups/cobalt.luau", "iy/cobalt")()
		end
	},
	{
		action = "remotespy|rspy",
		description = "Opens Simple Spy V3 to intercept remote calls from the client to the server",
		run = function(self)
			self.fetchService.load("backups/remotespy.luau", "iy/remotespy")()
		end
	},
	{
		action = "audiologger|alogger",
		description = "Opens Edges audio logger",
		run = function(self)
			self.fetchService.load("backups/audiologger.luau", "iy/audiologger")()
		end
	}
}