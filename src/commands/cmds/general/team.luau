return {
	{
		action = "team",
		description = "Changes your team. Sometimes fools localscripts. (CLIENT)",
		args = {
			kind = "team"
		},
		run = function(self, args)
			local teamName = args:nextValue()
			local team = self.robloxServices.Teams:FindFirstChild(teamName)
			if not team then
				self:notify("Invalid Team", tostring(teamName) .. " is not a valid team")
				return
			end

			local root = self.playerService:getRootPart()
			local firetouchinterest = self.executorEnv.firetouchinterest

			-- Touches a spawn of that team when the exploit can, same as IY. Otherwise sets it locally.
			if root and firetouchinterest then
				for _, object in workspace:GetDescendants() do
					if object:IsA("SpawnLocation") and object.BrickColor == team.TeamColor and object.AllowTeamChangeOnTouch then
						firetouchinterest(object, root, 0)
						firetouchinterest(object, root, 1)
						break
					end
				end
			else
				self.localPlayer.Team = team
			end
		end
	}
}
