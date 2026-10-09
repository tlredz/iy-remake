return {
	action = "mouseteleport|mousetp",
	description = "Teleports you to the spot your mouse is pointing at",
	run = function(self)
		local root = self.playerService:getRootPart()
		local mouse = self.playerService:getMouse()
		if not (root and mouse.Hit) then return end
		
		local target = mouse.Hit.Position + Vector3.new(0, 3, 0)
		root.CFrame = CFrame.new(target) * (root.CFrame - root.CFrame.Position)
		root.AssemblyLinearVelocity = Vector3.zero
	end
}
