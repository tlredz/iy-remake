local resolvePlayers = require("../../systems/resolvePlayers")

-- The destroy height the game started with (same idea as OrgDestroyHeight in IY)
local ORIGINAL_DESTROY_HEIGHT = workspace.FallenPartsDestroyHeight

-- The jerk animation. Confirm this ID still works before relying on it, a dead ID just fails to load.
local JERK_ANIMATION_ID = "rbxassetid://72042024"

local function stopJerk(garbage)
	if garbage.track then
		garbage.track:Stop()
	end
	if garbage.connection then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "fakeout",
		description = "Tp to the void and then back (useful to kill people attached to you)",
		run = function(self)
			local root = self.playerService:getRootPart()
			if not root then return end

			local oldCFrame = root.CFrame

			-- antivoid would pull the character back up, so it is paused during the trip
			local antivoidWasEnabled = self:hasGarbage("antivoid")
			if antivoidWasEnabled then
				self:run("unantivoid")
			end

			-- 0 / 0 is NaN. The fall never compares as below NaN, so the character is not destroyed on the way down.
			pcall(function()
				workspace.FallenPartsDestroyHeight = 0 / 0
			end)

			root.CFrame = CFrame.new(0, ORIGINAL_DESTROY_HEIGHT - 25, 0)
			task.wait(1)

			local currentRoot = self.playerService:getRootPart()
			if currentRoot then
				currentRoot.CFrame = oldCFrame
			end

			pcall(function()
				workspace.FallenPartsDestroyHeight = ORIGINAL_DESTROY_HEIGHT
			end)

			if antivoidWasEnabled then
				self:run("antivoid")
			end
		end
	},
	{
		action = "scare|spook",
		description = "Teleports in front of a player for half a second",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			local root = self.playerService:getRootPart()
			local targetRoot = target and target ~= self.localPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
			if not (root and targetRoot) then return end

			local oldCFrame = root.CFrame
			root.CFrame = targetRoot.CFrame + targetRoot.CFrame.LookVector * 2
			root.CFrame = CFrame.new(root.Position, targetRoot.Position)
			task.wait(0.5)

			local currentRoot = self.playerService:getRootPart()
			if currentRoot then
				currentRoot.CFrame = oldCFrame
			end
		end
	},
	{
		action = "jerk",
		description = "Makes you jork it",
		run = function(self)
			local previous = self:collectGarbage("jerk")
			if previous then
				local wasPlaying = previous.track ~= nil and previous.track.IsPlaying
				stopJerk(previous)
				if wasPlaying then return end
			end

			local humanoid = self.playerService:getHumanoid()
			local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
			if not animator then
				self:notify("Jerk", "your character has no Animator")
				return
			end

			local animation = Instance.new("Animation")
			animation.AnimationId = JERK_ANIMATION_ID

			local ok, track = pcall(function()
				return animator:LoadAnimation(animation)
			end)
			if not ok then
				self:notify("Jerk", "could not load the jerk animation (check JERK_ANIMATION_ID in scare.luau)")
				return
			end

			track.Looped = true
			track:Play()

			local garbage = self:createGarbage("jerk")
			garbage.track = track
			-- dying stops it too, so it does not keep playing on the next character
			garbage.connection = self:connect(humanoid.Died, function()
				local current = self:collectGarbage("jerk")
				if current then
					stopJerk(current)
				end
			end)
		end
	}
}
