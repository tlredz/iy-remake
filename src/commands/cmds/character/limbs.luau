local function destroyParts(character: Instance, names: { string })
	for _, name in names do
		local part = character:FindFirstChild(name)
		if part then
			part:Destroy()
		end
	end
end

local function isR15(self): boolean
	local humanoid = self.playerService:getHumanoid()
	return humanoid ~= nil and humanoid.RigType == Enum.HumanoidRigType.R15
end

return {
	{
		action = "noarms",
		description = "Removes your arms",
		run = function(self)
			local character = self.localPlayer.Character
			if character then
				destroyParts(character, isR15(self) and { "RightUpperArm", "LeftUpperArm" } or { "Right Arm", "Left Arm" })
			end
		end
	},
	{
		action = "nolegs",
		description = "Removes your legs",
		run = function(self)
			local character = self.localPlayer.Character
			if character then
				destroyParts(character, isR15(self) and { "RightUpperLeg", "LeftUpperLeg" } or { "Right Leg", "Left Leg" })
			end
		end
	},
	{
		action = "nolimbs",
		description = "Removes your limbs",
		run = function(self)
			local character = self.localPlayer.Character
			if character then
				destroyParts(character, isR15(self)
					and { "RightUpperLeg", "LeftUpperLeg", "RightUpperArm", "LeftUpperArm" }
					or { "Right Leg", "Left Leg", "Right Arm", "Left Arm" })
			end
		end
	}
}
