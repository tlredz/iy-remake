local function getRoot(self)
	return self.playerService:getRootPart()
end

return {
	{
		action = "tpposition|tppos",
		description = "Teleports you to certain coordinates",
		args = { kind = "vector3" },
		run = function(self, args)
			local position = args:nextValue()
			local root = getRoot(self)
			if root then
				root.CFrame = CFrame.new(position)
				root.AssemblyLinearVelocity = Vector3.zero
			end
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
			local duration = args:nextValue() or self.privateEnv.tweenSpeed or 1

			local root = getRoot(self)
			if not root then return end

			local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
			self.robloxServices.TweenService:Create(root, info, { CFrame = CFrame.new(position) }):Play()
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
			local duration = args:nextValue() or self.privateEnv.tweenSpeed or 1

			local root = getRoot(self)
			if not root then return end

			local info = TweenInfo.new(duration, Enum.EasingStyle.Linear)
			self.robloxServices.TweenService:Create(root, info, { CFrame = CFrame.new(root.Position + offset) }):Play()
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
			local root = getRoot(self)
			if not root then return end

			local look = root.CFrame.LookVector
			local position = root.CFrame.Position + look * distance
			root.CFrame = CFrame.new(position, position + look)
		end
	}
}
