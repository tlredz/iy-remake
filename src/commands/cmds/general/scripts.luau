-- The commands that load scripts from the repo. Each load tells the user what is happening (see systems/scriptLoader).

local fetchScript = require("../../systems/scriptLoader").fetch

local function oldConsole(self)
	local chunk = fetchScript(self, "Old Console", "backups/oldconsole.luau", "iy/oldconsole")
	if chunk then chunk() end
end

local function dexExplorer(self, byMoon)
	local chunk
	if byMoon == true then
		chunk = fetchScript(self, "Dex Explorer", "backups/explorer.luau", "iy/explorer")
	else
		chunk = fetchScript(self, "Dex Explorer", "backups/dexPlusPlus.luau", "iy/dexPlusPlus")
	end

	if chunk then chunk() end
end

local function emoteMenu(self, args)
	local keycode = args:nextValue()
	local notifyEnabled = args:nextValue()

	local main = fetchScript(self, "Emote Menu", "backups/emotes/main.luau", "iy/7yd7/emotes.luau")
	if not main then return end

	main({
		notifyEnabled = notifyEnabled,
		isMobile = self.isMobile,
		keycode = keycode,
	})
end

local function cobaltSpy(self)
	local chunk = fetchScript(self, "Cobalt", "backups/cobalt.luau", "iy/cobalt")
	if chunk then chunk() end
end

local function remoteSpy(self)
	local chunk = fetchScript(self, "Remote Spy", "backups/remotespy/main.luau", "iy/remotespy")
	if chunk then chunk() end
end

local function audioLogger(self)
	local chunk = fetchScript(self, "Audio Logger", "backups/audiologger.luau", "iy/audiologger")
	if chunk then chunk() end
end

return {
	{
		client = true,
		action = "oldconsole",
		description = "Loads an old-themed Roblox console",
		run = function(self) task.spawn(oldConsole, self) end
	},
	{
		client = true,
		action = "explorer|dex",
		description = "Opens the dex Explorer",
		args = { name = "load dex by moon", kind = "boolean", optional = true },
		run = function(self, args) task.spawn(dexExplorer, self, args:nextValue()) end
	},
	{
		client = true,
		action = "emotemenu|7yd7",
		description = "Opens animations/emotes menu By 7yd7",
		run = function(self, args) task.spawn(emoteMenu, self, args) end,
		args = {
			{ kind = "keycode", name = "open menu", optional = true },
			{ kind = "boolean", name = "notify", optional = true },
		}
	},
	{
		client = true,
		action = "cobalt|remotespy|rspy|cspy",
		description = "Opens Cobalt to intercept incoming and outgoing network traffic",
		run = function(self) task.spawn(cobaltSpy, self) end
	},
	{
		client = true,
		action = "simplespy|simplespy|sspy",
		description = "Opens Simple Spy V3 to intercept remote calls from the client to the server",
		run = function(self) task.spawn(remoteSpy, self) end
	},
	{
		client = true,
		action = "audiologger|alogger",
		description = "Opens Edges audio logger",
		run = function(self) task.spawn(audioLogger, self) end
	}
}
