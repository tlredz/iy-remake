-- Loads scripts from the repo with notices. Used by the commands that open a script (cmds/general/scripts.luau) and by
-- the commands that need a script as a helper (f3x, in cmds/workspace/clienttools.luau).
-- Each load tells the user what is happening: it starts, it is still going after SLOW_LOAD seconds, it finishes, or it
-- could not be loaded. The script itself comes from fetchService.load (the repo, see framework/services/fetchService).

local SLOW_LOAD = 3 -- seconds before a load that is still going gets a notice

local scriptLoader = {}

-- loads a script with notices. Returns the chunk, or nil when it could not be loaded.
-- self: the self of the command (it has fetchService and notify)
-- quiet: no notices for a load that works (for a script that is only a helper of another one)
function scriptLoader.fetch(self, label: string, path: string, chunkName: string?, quiet: boolean?)
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

return scriptLoader
