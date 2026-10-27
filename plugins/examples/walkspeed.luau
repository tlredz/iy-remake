return {
	{
		action = "pluginws",
		description = "Set your walk speed",
		args = {
			kind = "number",
			name = "speed",
			min = 0,
			max = 100,
		},
		run = function(self, args)
			local speed = args:nextValue()
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then
				self:notify("Character", "Character not loaded")
				return
			end
			humanoid.WalkSpeed = speed
		end,
	},
	{
		action = "pluginresetws",
		description = "Set walk speed back to 16",
		run = function(self)
			local humanoid = self.playerService:getHumanoid()
			if humanoid then
				humanoid.WalkSpeed = 16
			end
		end,
	},
}
