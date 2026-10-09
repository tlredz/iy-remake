local DANCES_R6 = {
	"27789359", "30196114", "248263260", "45834924", "33796059", "28488254", "52155728"
}

local DANCES_R15 = {
	"3333432454", "4555808220", "4049037604", "4555782893", "10214311282",
	"10714010337", "10713981723", "10714372526", "10714076981", "10714392151", "11444443576"
}

local function stopTracks(humanoid: Humanoid)
	for _, track in humanoid:GetPlayingAnimationTracks() do
		track:Stop()
	end
end

local function setAnimateDisabled(self, disabled: boolean)
	local character = self.localPlayer.Character
	local animate = character and character:FindFirstChild("Animate")
	if animate then
		animate.Disabled = disabled
	end
end

local function refreshAnimations(self)
	local humanoid = self.playerService:getHumanoid()
	local character = self.localPlayer.Character
	local animate = character and character:FindFirstChild("Animate")
	
	if not (humanoid and animate) then
		self:notify("Refresh Animations", "Failed to get Animate/Humanoid")
		return
	end
	
	animate.Disabled = true
	stopTracks(humanoid)
	animate.Disabled = false
end

local function stopDance(self)
	local garbage = self:collectGarbage("dance")
	if garbage and garbage.track then
		garbage.track:Stop()
		garbage.track:Destroy()
	end
end

local function setCustomAnimations(self, allowed: boolean)
	self.robloxServices.StarterPlayer.AllowCustomAnimations = allowed
	refreshAnimations(self)
end

return {
	{
		action = "animation|anim",
		description = "Plays an animation by its asset ID (optional speed)",
		args = {
			{ kind = "string", name = "animation id" },
			{ kind = "number", name = "speed", optional = true }
		},
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			local id = tostring(args:nextValue())
			local speed = args:nextValue()
			if not id:find("rbxassetid://") then
				id = "rbxassetid://" .. id
			end
			
			local animation = Instance.new("Animation")
			animation.AnimationId = id
			
			local track = humanoid:LoadAnimation(animation)
			track.Priority = Enum.AnimationPriority.Movement
			track:Play()
			
			if speed then
				track:AdjustSpeed(speed)
			end
		end
	},
	{
		action = "emote|em",
		description = "Plays an emote by its animation ID (optional speed)",
		args = {
			{ kind = "number", name = "emote id" },
			{ kind = "number", name = "speed", optional = true }
		},
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			local track = humanoid:PlayEmoteAndGetAnimTrackById(args:nextValue())
			local speed = args:nextValue()
			if track and speed then
				track:AdjustSpeed(speed)
			end
		end
	},
	{
		action = "noanim",
		description = "Disables the default Roblox animations",
		run = function(self)
			setAnimateDisabled(self, true)
		end
	},
	{
		action = "reanim",
		description = "Enables the default Roblox animations again",
		run = function(self)
			setAnimateDisabled(self, false)
		end
	},
	{
		action = "animspeed",
		description = "Sets the speed of every playing animation (default is 1)",
		args = { kind = "number", name = "speed", optional = true },
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			local speed = args:nextValue() or 1
			for _, track in humanoid:GetPlayingAnimationTracks() do
				track:AdjustSpeed(speed)
			end
		end
	},
	{
		action = "stopanimations|stopanims|stopanim",
		description = "Stops every playing animation",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if humanoid then
				stopTracks(humanoid)
			end
		end
	},
	{
		action = "refreshanimations|refreshanimation|refreshanims|refreshanim",
		description = "Restarts your character's default animations",
		run = function(self)
			refreshAnimations(self)
		end
	},
	{
		action = "allowcustomanim|allowcustomanimations",
		description = "Allows custom animations on your character",
		run = function(self)
			setCustomAnimations(self, true)
		end
	},
	{
		action = "unallowcustomanim|unallowcustomanimations",
		description = "Stops custom animations on your character",
		run = function(self)
			setCustomAnimations(self, false)
		end
	},
	{
		action = "loopanimation|loopanim",
		description = "Makes the animations that are currently playing loop",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			for _, track in humanoid:GetPlayingAnimationTracks() do
				track.Looped = true
			end
		end
	},
	{
		action = "dance",
		description = "Plays a random dance on a loop",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			stopDance(self)
			
			local ids = humanoid.RigType == Enum.HumanoidRigType.R15 and DANCES_R15 or DANCES_R6
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://" .. ids[math.random(1, #ids)]
			
			local track = humanoid:LoadAnimation(animation)
			track.Looped = true
			track:Play()
			
			self:registerGarbage("dance").track = track
		end
	},
	{
		action = "undance|nodance",
		description = "Stops the dance",
		run = function(self)
			stopDance(self)
		end
	}
}
