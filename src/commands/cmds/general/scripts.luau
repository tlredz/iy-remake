local function oldConsole(self)
	self.fetchService.load("backups/console.luau", "iy/oldconsole")()
end

local function dexExplorer(self, args)
	if args:nextValue() == true then
		self.fetchService.load("backups/explorer.luau", "iy/explorer")()
	else
		self.fetchService.load("backups/dexPlusPlus.luau", "iy/dexPlusPlus")()
	end
end

local function emoteMenu(self, args)
	local notify = self.fetchService.load("backups/emotes/notify.luau", "iy/7yd7/notify.luau")()
	
	local keycode = args:nextValue()
	local notifyEnabled = args:nextValue()
	
	self.fetchService.load("backups/emotes/main.luau", "iy/7yd7/emotes.luau")({
		notifyFunction = if notifyEnabled ~= false then notify else function()end,
		isMobile = self.isMobile,
		keycode = keycode,
	})
end

local function cobaltSpy(self)
	self.fetchService.load("backups/cobalt.luau", "iy/cobalt")()
end

local function remoteSpy(self)
	self.fetchService.load("backups/remotespy/main.luau", "iy/remotespy")()
end

local function audioLogger(self)
	self.fetchService.load("backups/audiologger.luau", "iy/audiologger")()
end

return {
	{
		action = "oldconsole",
		description = "Loads an old-themed Roblox console",
		run = function(self) task.spawn(oldConsole, self) end
	},
	{
		action = "explorer|dex",
		description = "Opens the dex Explorer",
		args = { name = "load dex by moon", kind = "boolean", optional = true },
		run = function(self) task.spawn(dexExplorer, self) end
	},
	{
		action = "emotemenu|7yd7",
		description = "Opens animations/emotes menu By 7yd7",
		run = function(self, args) task.spawn(emoteMenu, self, args) end,
		args = {
			{ kind = "keycode", name = "open menu", optional = true },
			{ kind = "boolean", name = "notify", optional = true },
		}
	},
	{
		action = "cobalt|remotespy|rspy|cspy",
		description = "Opens Cobalt to intercept incoming and outgoing network traffic",
		run = function(self) task.spawn(cobaltSpy, self) end
	},
	{
		action = "simplespy|simplespy|sspy",
		description = "Opens Simple Spy V3 to intercept remote calls from the client to the server",
		run = function(self) task.spawn(remoteSpy, self) end
	},
	{
		action = "audiologger|alogger",
		description = "Opens Edges audio logger",
		run = function(self) task.spawn(audioLogger, self) end
	}
}