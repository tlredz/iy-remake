local connectionService = require("../../../framework/services/connectionService")
local localPlayer = require("../../../framework/services/localPlayer")

local lastDeath = nil

local function watchCharacter(character: Model)
	local humanoid = character:WaitForChild("Humanoid", 10)
	if not humanoid then return end

	connectionService:Connect(humanoid.Died, function()
		local root = character:FindFirstChild("HumanoidRootPart")
		if root then
			lastDeath = root.CFrame
		end
	end)
end

connectionService:Connect(localPlayer.CharacterAdded, watchCharacter)
if localPlayer.Character then
	task.spawn(watchCharacter, localPlayer.Character)
end

return {
	action = "flashback|diedtp",
	description = "Teleports you to where you last died",
	run = function(self)
		if not lastDeath then
			self:notify("flashback", "you have not died yet")
			return
		end

		local humanoid = self.playerService:getHumanoid()
		if humanoid and humanoid.SeatPart then
			humanoid.Sit = false
			task.wait(0.1)
		end

		local root = self.playerService:getRootPart()
		if root then
			root.CFrame = lastDeath
		end
	end
}
