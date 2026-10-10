-- Every humanoid state except None and Dead. Dead stays on, so the character still dies normally.
local function getSwimStates()
	local states = {}
	for _, state in Enum.HumanoidStateType:GetEnumItems() do
		if state ~= Enum.HumanoidStateType.None and state ~= Enum.HumanoidStateType.Dead then
			table.insert(states, state)
		end
	end
	return states
end

local function stopSwim(self)
	local garbage = self:collectGarbage("swim")
	if not garbage then return end

	for _, connection in garbage.connections do
		connection:Disconnect()
	end
	for _, state in garbage.states do
		garbage.humanoid:SetStateEnabled(state, true)
	end
	workspace.Gravity = garbage.gravity
end

local function startSwim(self)
	if self:hasGarbage("swim") then
		self:notify("swim is already enabled")
		return
	end

	local humanoid = self.playerService:getHumanoid()
	if not humanoid then
		self:notify("swim", "your character is not loaded")
		return
	end

	local garbage = self:createGarbage("swim")
	garbage.humanoid = humanoid
	garbage.gravity = workspace.Gravity
	garbage.states = getSwimStates()
	garbage.connections = {}

	workspace.Gravity = 0
	for _, state in garbage.states do
		humanoid:SetStateEnabled(state, false)
	end
	humanoid:ChangeState(Enum.HumanoidStateType.Swimming)

	table.insert(garbage.connections, self:connect(humanoid.Died, function()
		stopSwim(self)
	end))

	-- Stops the character from sinking or drifting, unless it is moving or holding Space
	table.insert(garbage.connections, self:connect(self.runService.Heartbeat, function()
		local root = self.playerService:getRootPart()
		if not root then return end

		local moving = humanoid.MoveDirection ~= Vector3.zero
			or self.robloxServices.UserInputService:IsKeyDown(Enum.KeyCode.Space)
		if not moving then
			root.AssemblyLinearVelocity = Vector3.zero
		end
	end))
end

return {
	{
		action = "swim",
		description = "Allows you to swim in the air",
		run = function(self)
			startSwim(self)
		end
	},
	{
		action = "unswim|noswim",
		description = "Stops you from swimming everywhere",
		run = function(self)
			stopSwim(self)
		end
	},
	{
		action = "toggleswim",
		description = "Toggles swimming",
		run = function(self)
			if self:hasGarbage("swim") then
				stopSwim(self)
			else
				startSwim(self)
			end
		end
	}
}
