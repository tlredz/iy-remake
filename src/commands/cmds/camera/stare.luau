local resolvePlayers = require("../../systems/resolvePlayers")

local function stopStare(self)
	local garbage = self:collectGarbage("stareat")
	if garbage then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "stareat|stare",
		description = "Stare / look at a player",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			if not target then return end

			stopStare(self)

			local garbage = self:createGarbage("stareat")
			garbage.connection = self:connect(self.runService.RenderStepped, function()
				if target.Parent == nil then
					stopStare(self)
					return
				end

				local root = self.playerService:getRootPart()
				local targetRoot = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				if not (root and targetRoot) then return end

				-- Only turns around the vertical axis, so the character stays upright
				local lookAt = Vector3.new(targetRoot.Position.X, root.Position.Y, targetRoot.Position.Z)
				if (lookAt - root.Position).Magnitude < 0.01 then return end

				root.CFrame = CFrame.new(root.Position, lookAt)
			end)
		end
	},
	{
		action = "unstareat|unstare",
		description = "Disables stareat",
		run = function(self)
			stopStare(self)
		end
	}
}
