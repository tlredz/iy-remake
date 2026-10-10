-- Stops a loop that was started with this garbage name
local function stopLoop(self, name: string)
	local garbage = self:collectGarbage(name)
	if garbage then
		garbage.connection:Disconnect()
	end
end

-- True when something is in front of the character, at the feet or at the chest
local function isBlockedAhead(root: BasePart, character: Model): boolean
	local look = root.CFrame.LookVector * 3
	local lowRay = Ray.new(root.Position - Vector3.new(0, 1.5, 0), look)
	local highRay = Ray.new(root.Position + Vector3.new(0, 1.5, 0), look)

	return workspace:FindPartOnRay(lowRay, character) ~= nil or workspace:FindPartOnRay(highRay, character) ~= nil
end

return {
	{
		action = "autojump|ajump",
		description = "Automatically jumps when you run into an object",
		run = function(self)
			stopLoop(self, "autojump")

			local garbage = self:createGarbage("autojump")
			garbage.connection = self:connect(self.runService.RenderStepped, function()
				local character = self.playerService:getCharacter()
				local humanoid = self.playerService:getHumanoid()
				local root = self.playerService:getRootPart()
				if character and humanoid and root and isBlockedAhead(root, character) then
					humanoid.Jump = true
				end
			end)
		end
	},
	{
		action = "unautojump|noautojump|noajump|unajump",
		description = "Disables autojump",
		run = function(self)
			stopLoop(self, "autojump")
		end
	},
	{
		action = "edgejump|ejump",
		description = "Automatically jumps when you get to the edge of an object",
		run = function(self)
			stopLoop(self, "edgejump")

			local garbage = self:createGarbage("edgejump")
			garbage.connection = self:connect(self.runService.RenderStepped, function()
				local humanoid = self.playerService:getHumanoid()
				local root = self.playerService:getRootPart()
				if not (humanoid and root) then return end

				local previous = garbage.state
				local state = humanoid:GetState()
				garbage.state = state

				-- Walked off an edge: jump from the last spot that was on the ground
				if previous ~= state and state == Enum.HumanoidStateType.Freefall and previous ~= Enum.HumanoidStateType.Jumping and garbage.lastCFrame then
					root.CFrame = garbage.lastCFrame
					local velocity = root.AssemblyLinearVelocity
					root.AssemblyLinearVelocity = Vector3.new(velocity.X, humanoid.JumpPower, velocity.Z)
				end

				garbage.lastCFrame = root.CFrame
			end)
		end
	},
	{
		action = "unedgejump|noedgejump|noejump|unejump",
		description = "Disables edgejump",
		run = function(self)
			stopLoop(self, "edgejump")
		end
	}
}
