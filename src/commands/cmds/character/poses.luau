local function stopSpasm(self)
	local garbage = self:collectGarbage("spasm")
	if garbage and garbage.track then
		garbage.track:Stop()
		garbage.track:Destroy()
	end
end

local function removeSpinners(root: Instance)
	for _, child in root:GetChildren() do
		if child.Name == "Spinning" then
			child:Destroy()
		end
	end
end

return {
	{
		action = "spasm",
		description = "Makes your R6 character spasm (uses an animation)",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			if humanoid.RigType == Enum.HumanoidRigType.R15 then
				self:notify("R6 Required", "This command requires the r6 rig type")
				return
			end
			
			stopSpasm(self)
			
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://33796059"
			
			local track = humanoid:LoadAnimation(animation)
			track:Play()
			track:AdjustSpeed(99)
			
			self:registerGarbage("spasm").track = track
		end
	},
	{
		action = "unspasm|nospasm",
		description = "Stops the spasm",
		run = function(self)
			stopSpasm(self)
		end
	},
	{
		action = "headthrow",
		description = "Throws your R6 character's head (uses an animation)",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			if humanoid.RigType == Enum.HumanoidRigType.R15 then
				self:notify("R6 Required", "This command requires the r6 rig type")
				return
			end
			
			local animation = Instance.new("Animation")
			animation.AnimationId = "rbxassetid://35154961"
			
			local track = humanoid:LoadAnimation(animation)
			track:Play(0)
			track:AdjustSpeed(1)
		end
	},
	{
		action = "sitwalk",
		description = "Uses the sit animation while walking, running and jumping",
		run = function(self)
			local character = self.localPlayer.Character
			local humanoid = self.playerService:getHumanoid()
			local animate = character and character:FindFirstChild("Animate")
			if not (humanoid and animate) then return end
			
			local sitFolder = animate:FindFirstChild("sit")
			local sitAnimation = sitFolder and sitFolder:FindFirstChildWhichIsA("Animation")
			if not sitAnimation then return end
			
			for _, folderName in { "idle", "walk", "run", "jump" } do
				local folder = animate:FindFirstChild(folderName)
				local animation = folder and folder:FindFirstChildWhichIsA("Animation")
				if animation then
					animation.AnimationId = sitAnimation.AnimationId
				end
			end
			
			humanoid.HipHeight = humanoid.RigType == Enum.HumanoidRigType.R15 and 0.5 or -1.5
		end
	},
	{
		action = "spin",
		description = "Spins your character (default speed is 20)",
		args = { kind = "number", name = "spin speed", optional = true },
		run = function(self, args)
			local root = self:getRoot()
			if not root then return end
			
			removeSpinners(root)
			
			local spinner = Instance.new("BodyAngularVelocity")
			spinner.Name = "Spinning"
			spinner.MaxTorque = Vector3.new(0, math.huge, 0)
			spinner.AngularVelocity = Vector3.new(0, args:nextValue() or 20, 0)
			spinner.Parent = root
		end
	},
	{
		action = "unspin",
		description = "Stops spinning your character",
		run = function(self)
			local root = self.playerService:getRootPart()
			if root then
				removeSpinners(root)
			end
		end
	}
}
