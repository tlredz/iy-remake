local function stopSpawnPoint(self)
	local garbage = self:collectGarbage("spawnpoint")
	if garbage then
		garbage.connection:Disconnect()
	end
	return garbage ~= nil
end

return {
	{
		action = "spawnpoint|spawn",
		description = "Sets a position where you will spawn",
		args = {
			kind = "number",
			name = "delay",
			optional = true
		},
		run = function(self, args)
			local root = self.playerService:getRootPart()
			if not root then return end

			local delay = args:nextValue() or 0.1
			stopSpawnPoint(self)

			local garbage = self:createGarbage("spawnpoint")
			garbage.cframe = root.CFrame
			garbage.delay = delay

			-- Every time you respawn, wait a little and go back to the saved position
			garbage.connection = self:connect(self.localPlayer.CharacterAdded, function(character)
				character:WaitForChild("HumanoidRootPart", 10)
				task.wait(garbage.delay)

				local currentRoot = self.playerService:getRootPart()
				if currentRoot then
					currentRoot.CFrame = garbage.cframe
				end
			end)

			self:notify("Spawn Point", "Spawn point created")
		end
	},
	{
		action = "nospawnpoint|nospawn",
		description = "Removes your custom spawn point",
		run = function(self)
			if stopSpawnPoint(self) then
				self:notify("Spawn Point", "Removed spawn point")
			end
		end
	}
}
