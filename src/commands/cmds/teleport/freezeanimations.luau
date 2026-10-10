-- Sets the speed of every animation playing on your character
local function setAnimationSpeed(self, speed: number)
	local character = self.playerService:getCharacter()
	if not character then return end

	local controller = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChildOfClass("AnimationController")
	if not controller then return end

	for _, track in controller:GetPlayingAnimationTracks() do
		track:AdjustSpeed(speed)
	end
end

return {
	{
		action = "freezeanims",
		description = "Freezes your animations / pauses your animations - Does not work on default animations",
		run = function(self)
			setAnimationSpeed(self, 0)
		end
	},
	{
		action = "unfreezeanims",
		description = "Unfreezes your animations / plays your animations",
		run = function(self)
			setAnimationSpeed(self, 1)
		end
	}
}
