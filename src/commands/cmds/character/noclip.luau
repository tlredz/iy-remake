local NOTIFY_TITLE = "Noclip"

-- Turns noclip off and gives back the collisions it removed. Returns true when it was on.
local function stopNoclip(self): boolean
	local garbage = self:collectGarbage("noclip")
	if not garbage then return false end

	garbage.connection:Disconnect()

	for part in garbage.parts do
		if part.Parent then
			part.CanCollide = true
		end
	end

	return true
end

local function startNoclip(self)
	local garbage = self:createGarbage("noclip")
	garbage.parts = setmetatable({}, { __mode = "k" })

	garbage.connection = self:connect(self.runService.Stepped, function()
		local character = self.playerService:getCharacter()
		if not character then return end

		-- The float platform keeps its collision, so you can still stand on it
		local float = self:getGarbage("float")
		local platform = float and float.platform

		for _, part in character:GetDescendants() do
			if part:IsA("BasePart") and part.CanCollide and part ~= platform then
				part.CanCollide = false
				garbage.parts[part] = true
			end
		end
	end)
end

local silentArg = { kind = "string", name = "nonotify", optional = true }

return {
	{
		action = "noclip",
		description = "Go through objects",
		args = silentArg,
		run = function(self, args)
			local silent = args:nextValue() == "nonotify"

			-- Same as IY: running it again restarts noclip
			stopNoclip(self)
			startNoclip(self)

			if not silent then
				self:notify(NOTIFY_TITLE, "Noclip Enabled")
			end
		end
	},
	{
		action = "unnoclip|clip",
		description = "Disables noclip",
		args = silentArg,
		run = function(self, args)
			local silent = args:nextValue() == "nonotify"
			stopNoclip(self)

			if not silent then
				self:notify(NOTIFY_TITLE, "Noclip Disabled")
			end
		end
	},
	{
		action = "togglenoclip",
		description = "Toggles noclip",
		run = function(self)
			-- the noclip garbage is the Clip state: it exists exactly while noclip is on
			self:run(if self:hasGarbage("noclip") then "unnoclip" else "noclip")
		end
	}
}
