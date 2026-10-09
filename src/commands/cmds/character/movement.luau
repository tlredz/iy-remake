local function setHumanoidProperty(self, property: string, value: any)
	local humanoid = self.playerService:getHumanoid()
	if humanoid then
		humanoid[property] = value
	end
end

local function humanoidToggle(action: string, description: string, property: string, value: any)
	return {
		action = action,
		description = description,
		run = function(self)
			setHumanoidProperty(self, property, value)
		end
	}
end

return {
	{
		action = "speed|ws|walkspeed",
		description = "Sets your walk speed (default is 16)",
		args = { kind = "number", name = "walk speed", optional = true },
		run = function(self, args)
			setHumanoidProperty(self, "WalkSpeed", args:nextValue() or 16)
		end
	},
	{
		action = "jpower|jumppower|jp",
		description = "Sets your jump power (default is 50)",
		args = { kind = "number", name = "jump power", optional = true },
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			local power = args:nextValue() or 50
			if humanoid.UseJumpPower then
				humanoid.JumpPower = power
			else
				humanoid.JumpHeight = power
			end
		end
	},
	{
		action = "maxslopeangle|msa",
		description = "Sets the max slope angle your humanoid can walk up (default is 89)",
		args = { kind = "number", name = "angle", optional = true },
		run = function(self, args)
			setHumanoidProperty(self, "MaxSlopeAngle", args:nextValue() or 89)
		end
	},
	{
		action = "hipheight|hheight",
		description = "Sets your hip height (default depends on your rig)",
		args = { kind = "number", name = "hip height", optional = true },
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			
			local isR15 = humanoid.RigType == Enum.HumanoidRigType.R15
			humanoid.HipHeight = args:nextValue() or (isR15 and 2.1 or 0)
		end
	},
	humanoidToggle("stun|platformstand", "Makes your character stiff (PlatformStand)", "PlatformStand", true),
	humanoidToggle("unstun|nostun|unplatformstand|noplatformstand", "Disables stun", "PlatformStand", false),
	humanoidToggle("norotate|noautorotate", "Stops your character from auto rotating", "AutoRotate", false),
	humanoidToggle("unnorotate|autorotate", "Lets your character auto rotate again", "AutoRotate", true),
	{
		action = "trip",
		description = "Trips your character forward",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			local root = self.playerService:getRootPart()
			if not (humanoid and root) then return end
			
			humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
			root.AssemblyLinearVelocity = root.CFrame.LookVector * 30
		end
	},
	{
		action = "breakvelocity",
		description = "Stops the character's movement for one second",
		run = function(self)
			local character = self.localPlayer.Character
			if not character then return end
			
			local started = os.clock()
			task.spawn(function()
				while os.clock() - started < 1 do
					for _, part in character:GetDescendants() do
						if part:IsA("BasePart") then
							part.AssemblyLinearVelocity = Vector3.zero
							part.AssemblyAngularVelocity = Vector3.zero
						end
					end
					task.wait()
				end
			end)
		end
	},
	{
		action = "deletevelocity|dv|removevelocity|removeforces",
		description = "Deletes the force and velocity objects on your character",
		run = function(self)
			local character = self.localPlayer.Character
			if not character then return end
			
			local forceClasses = {
				"BodyVelocity", "BodyGyro", "RocketPropulsion", "BodyThrust",
				"BodyAngularVelocity", "AngularVelocity", "BodyForce", "VectorForce", "LineForce"
			}
			
			for _, object in character:GetDescendants() do
				for _, className in forceClasses do
					if object:IsA(className) then
						object:Destroy()
						break
					end
				end
			end
		end
	}
}
