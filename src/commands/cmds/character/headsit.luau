local resolvePlayers = require("../../systems/resolvePlayers")

local function stopHeadSit(self)
	local garbage = self:collectGarbage("headsit")
	if garbage then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "headsit",
		description = "Sit on a players head",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end

			stopHeadSit(self)

			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end
			humanoid.Sit = true

			local garbage = self:createGarbage("headsit")
			garbage.connection = self:connect(self.runService.Heartbeat, function()
				local root = self.playerService:getRootPart()
				local currentHumanoid = self.playerService:getHumanoid()
				local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")

				if not (root and currentHumanoid and targetRoot and currentHumanoid.Sit) then
					stopHeadSit(self)
					return
				end

				root.CFrame = targetRoot.CFrame * CFrame.new(0, 1.6, 0.4)
			end)
		end
	}
}
