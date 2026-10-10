local resolvePlayers = require("../../systems/resolvePlayers")

local FLOAT_NAME = "IYFloatPlatform"

return {
	{
		client = true,
		action = "freeze|fr",
		description = "Freezes a player",
		args = { kind = "player" },
		run = function(self, args)
			for _, target in resolvePlayers(args:nextValue()) do
				local character = target.Character
				if character then
					for _, part in character:GetDescendants() do
						if part:IsA("BasePart") and not part.Anchored then
							part.Anchored = true
						end
					end
				end
			end
		end
	},
	{
		client = true,
		action = "unfreeze|thaw|unfr",
		description = "Unfreezes a player",
		args = { kind = "player" },
		run = function(self, args)
			for _, target in resolvePlayers(args:nextValue()) do
				local character = target.Character
				if character then
					for _, part in character:GetDescendants() do
						if part:IsA("BasePart") and part.Anchored and part.Name ~= FLOAT_NAME then
							part.Anchored = false
						end
					end
				end
			end
		end
	}
}
