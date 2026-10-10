local FLOAT_OFFSET = -3.1

local function removeFloat(self)
	local garbage = self:collectGarbage("float")
	if not garbage then return end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end
	garbage.platform:Destroy()
end

local function startFloat(self)
	if self:hasGarbage("float") then
		self:notify("float is already enabled")
		return
	end

	local character = self.playerService:getCharacter()
	local root = self.playerService:getRootPart()
	if not (character and root) then
		self:notify("Float", "your character is not loaded")
		return
	end

	local platform = Instance.new("Part")
	platform.Name = "IYFloatPlatform"
	platform.Transparency = 1
	platform.Size = Vector3.new(2, 0.2, 1.5)
	platform.Anchored = true
	platform.CFrame = root.CFrame * CFrame.new(0, FLOAT_OFFSET, 0)
	platform.Parent = character

	local garbage = self:createGarbage("float")
	garbage.platform = platform
	garbage.offset = FLOAT_OFFSET
	garbage.connections = {}

	table.insert(garbage.connections, self:connect(self.runService.Heartbeat, function()
		local currentRoot = self.playerService:getRootPart()
		if not (currentRoot and platform:IsDescendantOf(workspace)) then
			removeFloat(self)
			return
		end

		platform.CFrame = currentRoot.CFrame * CFrame.new(0, garbage.offset, 0)
	end))

	-- Same steps as IY: holding E lifts the platform, holding Q lowers it
	table.insert(garbage.connections, self:connect(self.robloxServices.UserInputService.InputBegan, function(input, processed)
		if processed then return end

		if input.KeyCode == Enum.KeyCode.E then
			garbage.offset += 1.5
		elseif input.KeyCode == Enum.KeyCode.Q then
			garbage.offset -= 0.5
		end
	end))

	table.insert(garbage.connections, self:connect(self.robloxServices.UserInputService.InputEnded, function(input)
		if input.KeyCode == Enum.KeyCode.E then
			garbage.offset -= 1.5
		elseif input.KeyCode == Enum.KeyCode.Q then
			garbage.offset += 0.5
		end
	end))

	self:notify("Float", "Enabled (Q = down & E = up)")
end

return {
	{
		action = "float|platform",
		description = "Spawns a platform beneath you causing you to float",
		run = function(self)
			startFloat(self)
		end
	},
	{
		action = "unfloat|noplatform",
		description = "Removes the platform",
		run = function(self)
			if not self:hasGarbage("float") then return end

			removeFloat(self)
			self:notify("Float", "Disabled")
		end
	}
}
