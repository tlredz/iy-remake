-- The commands that load scripts from the repo. Each load tells the user what is happening: it starts, it is still
-- going after SLOW_LOAD seconds, it finishes, or it could not be loaded.

local SLOW_LOAD = 3 -- seconds before a load that is still going gets a notice

-- loads a script (fetchService.load) with notices. Returns the chunk, or nil when it could not be loaded.
-- quiet: no notices for a load that works (for a script that is only a helper of another one)
local function fetchScript(self, label: string, path: string, chunkName: string?, quiet: boolean?)
	if not quiet then
		self:notify(label, "started loading")
	end

	local finished = false

	task.delay(SLOW_LOAD, function()
		if not finished then
			self:notify(label, "is taking a while to load, still loading...")
		end
	end)

	local chunk = self.fetchService.load(path, chunkName)
	finished = true

	if chunk == nil then
		self:notify(label, "could not be loaded")
	elseif not quiet then
		self:notify(label, "finished loading")
	end

	return chunk
end

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
	local notifyChunk = fetchScript(self, "Emote Menu", "backups/emotes/notify.luau", "iy/7yd7/notify.luau", true)
	local notify = notifyChunk and notifyChunk() or function() end

	local keycode = args:nextValue()
	local notifyEnabled = args:nextValue()

	local main = fetchScript(self, "Emote Menu", "backups/emotes/main.luau", "iy/7yd7/emotes.luau")
	if not main then return end

	main({
		notifyFunction = if notifyEnabled ~= false then notify else function() end,
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
		action = "oldconsole",
		description = "Loads an old-themed Roblox console",
		run = function(self) task.spawn(oldConsole, self) end
	},
	{
		action = "explorer|dex",
		description = "Opens the dex Explorer",
		args = { name = "load dex by moon", kind = "boolean", optional = true },
		run = function(self, args) task.spawn(dexExplorer, self, args:nextValue()) end
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
