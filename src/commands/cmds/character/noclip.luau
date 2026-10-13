-- /src/commands/cmds/character/noclip.luau

local NOTIFY_TITLE = "Noclip"
local silentArg = { kind = "string", name = "nonotify", optional = true }

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

return {
	{
		action = "noclip",
		description = "Go through objects",
		args = silentArg,
		run = function(self, args)
			local silent = args:nextValue() == "nonotify"
			
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
			self:run(if self:hasGarbage("noclip") then "unnoclip" else "noclip")
		end
	}
}
