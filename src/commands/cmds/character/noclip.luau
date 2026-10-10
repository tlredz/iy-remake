local function stopNoclip(self)
	local garbage = self:collectGarbage("noclip")
	if not garbage then return end

	garbage.connection:Disconnect()

	-- Gives back the collisions that noclip turned off
	for part in garbage.parts do
		if part.Parent then
			part.CanCollide = true
		end
	end
end

return {
	{
		action = "noclip",
		description = "Go through objects",
		run = function(self)
			if self:hasGarbage("noclip") then
				self:notify("noclip is already enabled")
				return
			end

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
	},
	{
		action = "unnoclip|clip",
		description = "Disables noclip",
		run = function(self)
			stopNoclip(self)
		end
	}
}
