return {
	action = "volume|vol",
	description = "Adjusts your game volume on a scale of 0 to 10",
	args = {
		kind = "number",
		clamp = {0, 10}
	},
	run = function(self, args)
		local volume = 1 / args:nextValue()
		self.userGameSettings.MasterVolume = volume
	end
}