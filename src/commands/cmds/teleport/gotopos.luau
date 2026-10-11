return {
	{
		action = "tpposition|tppos",
		description = "Teleports you to certain coordinates",
		args = { kind = "vector3" },
		run = function(self, args)
			self.playerService:teleportTo(args:nextValue())
		end
	},
	{
		action = "tweentpposition|ttppos",
		description = "Tween to coordinates (bypasses some anti cheats)",
		args = {
			{
				kind = "vector3"
			},
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		},
		run = function(self, args)
			local position = args:nextValue()
			local speed = args:nextValue() or self.privateEnv.tweenSpeed

			self.playerService:tweenTeleportTo({
				target = position,
				speed = speed
			})
		end
	},
	{
		action = "offset",
		description = "Offsets you by certain coordinates",
		args = { kind = "vector3" },
		run = function(self, args)
			local character = self.playerService:getCharacter()
			if character then
				character:TranslateBy(args:nextValue())
			end
		end
	},
	{
		action = "tweenoffset|toffset",
		description = "Tween offset (bypasses some anti cheats)",
		args = {
			{
				kind = "vector3"
			},
			{
				kind = "number",
				name = "tween speed",
				optional = true
			}
		},
		run = function(self, args)
			local offset = args:nextValue()
			local speed = args:nextValue() or self.privateEnv.tweenSpeed

			local root = self.playerService:getRootPart()
			if not root then return end

			self.playerService:tweenTeleportTo({
				target = root.Position + offset,
				speed = speed
			})
		end
	},
	{
		action = "thru",
		description = "Teleports you [num] studs ahead of where your character is facing",
		args = {
			kind = "number",
			optional = true
		},
		run = function(self, args)
			local distance = args:nextValue() or 5
			local root = self.playerService:getRootPart()
			if not root then return end

			local look = root.CFrame.LookVector
			local position = root.CFrame.Position + look * distance
			self.playerService:teleportTo(CFrame.new(position, position + look))
		end
	}
}
