return {
	action = "teleporttool|tptool",
	description = "Gives you a teleport tool",
	run = function(self)
		local backpack = self.localPlayer:FindFirstChildOfClass("Backpack")
		if not backpack then
			self:notify("Teleport Tool", "your backpack is not loaded")
			return
		end

		local tool = Instance.new("Tool")
		tool.Name = "Teleport Tool"
		tool.RequiresHandle = false
		tool.Parent = backpack

		-- Same as mouseteleport: stands above the spot you click and keeps your facing
		self:connect(tool.Activated, function()
			local root = self.playerService:getRootPart()
			local mouse = self.playerService:getMouse()
			if not (root and mouse.Hit) then return end

			local target = mouse.Hit.Position + Vector3.new(0, 3, 0)
			root.CFrame = CFrame.new(target) * (root.CFrame - root.CFrame.Position)
			root.AssemblyLinearVelocity = Vector3.zero
		end)
	end
}
