local function stopWallTp(self)
	local garbage = self:collectGarbage("walltp")
	if garbage then
		garbage.connection:Disconnect()
	end
end

return {
	{
		action = "walltp",
		description = "Teleports you above/over any wall you run into",
		run = function(self)
			stopWallTp(self)

			local character = self.playerService:getCharacter()
			local torso = character and (character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso"))
			if not torso then return end

			local garbage = self:createGarbage("walltp")
			garbage.connection = self:connect(torso.Touched, function(hit)
				local root = self.playerService:getRootPart()
				local humanoid = self.playerService:getHumanoid()
				if not (root and humanoid and hit.Parent) then return end
				if not hit:IsA("BasePart") then return end
				if hit.Position.Y <= root.Position.Y - humanoid.HipHeight then return end

				local look = root.CFrame.LookVector
				local hitRoot = hit.Parent:FindFirstChild("HumanoidRootPart")
				if hitRoot then
					root.CFrame = hit.CFrame * CFrame.new(look.X, hitRoot.Size.Z / 2 + humanoid.HipHeight, look.Z)
				else
					root.CFrame = hit.CFrame * CFrame.new(look.X, hit.Size.Y / 2 + humanoid.HipHeight, look.Z)
				end
			end)
		end
	},
	{
		action = "nowalltp|unwalltp",
		description = "Disables walltp",
		run = function(self)
			stopWallTp(self)
		end
	}
}
