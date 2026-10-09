local function startJumpLoop(self, garbageName: string, debounce: boolean)
	if self:hasGarbage(garbageName) then
		self:notify(`{garbageName} is already enabled`)
		return
	end
	
	local garbage = self:createGarbage(garbageName)
	garbage.connection = self:connect(self.robloxServices.UserInputService.JumpRequest, function()
		if debounce and garbage.debouncing then return end
		
		local humanoid = self.playerService:getHumanoid()
		if not humanoid then return end
		
		garbage.debouncing = true
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
		task.wait()
		garbage.debouncing = false
	end)
end

local function stopJumpLoop(self, garbageName: string)
	local garbage = self:collectGarbage(garbageName)
	if garbage and garbage.connection then
		garbage.connection:Disconnect()
	end
end

local function setHumanoidState(self, stateName: string, enabled: boolean)
	local humanoid = self.playerService:getHumanoid()
	local success, state = pcall(function()
		return Enum.HumanoidStateType[stateName]
	end)
	
	if not success then
		self:notify("Invalid state", `{stateName} is not a HumanoidStateType`)
		return
	end
	
	if humanoid then
		humanoid:SetStateEnabled(state, enabled)
	end
end

return {
	{
		action = "sit",
		description = "Makes your character sit",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if humanoid then
				humanoid.Sit = true
			end
		end
	},
	{
		action = "nosit",
		description = "Stops your character from being able to sit",
		run = function(self)
			setHumanoidState(self, "Seated", false)
		end
	},
	{
		action = "unnosit",
		description = "Lets your character sit again",
		run = function(self)
			setHumanoidState(self, "Seated", true)
		end
	},
	{
		action = "enablestate",
		description = "Enables a humanoid state (example: Jumping)",
		args = { kind = "string", name = "state name" },
		run = function(self, args)
			setHumanoidState(self, args:nextValue(), true)
		end
	},
	{
		action = "disablestate",
		description = "Disables a humanoid state (example: Jumping)",
		args = { kind = "string", name = "state name" },
		run = function(self, args)
			setHumanoidState(self, args:nextValue(), false)
		end
	},
	{
		action = "lay|laydown",
		description = "Lays your character down",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			local root = self.playerService:getRootPart()
			if not (humanoid and root) then return end
			
			humanoid.Sit = true
			task.wait(0.1)
			
			root = self.playerService:getRootPart()
			if not root then return end
			root.CFrame = root.CFrame * CFrame.Angles(math.pi * 0.5, 0, 0)
			
			for _, track in humanoid:GetPlayingAnimationTracks() do
				track:Stop()
			end
		end
	},
	{
		action = "jump",
		description = "Makes your character jump once",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	},
	{
		action = "infjump|infinitejump",
		description = "Lets you jump again while in the air",
		run = function(self)
			startJumpLoop(self, "infjump", true)
		end
	},
	{
		action = "uninfjump|uninfinitejump|noinfjump|noinfinitejump",
		description = "Disables infinite jump",
		run = function(self)
			stopJumpLoop(self, "infjump")
		end
	},
	{
		action = "flyjump",
		description = "Makes you jump every time a jump is requested",
		run = function(self)
			startJumpLoop(self, "flyjump", false)
		end
	},
	{
		action = "unflyjump|noflyjump",
		description = "Disables flyjump",
		run = function(self)
			stopJumpLoop(self, "flyjump")
		end
	},
	{
		action = "nilchar",
		description = "Removes your character from the workspace (client side)",
		run = function(self)
			local character = self.localPlayer.Character
			if character then
				character.Parent = nil
			end
		end
	},
	{
		action = "unnilchar|nonilchar",
		description = "Puts your character back into the workspace",
		run = function(self)
			local character = self.localPlayer.Character
			if character then
				character.Parent = workspace
			end
		end
	}
}
