return {
	{
		action = "loopoof",
		description = "Makes every player's head play its sounds (oof) over and over",
		run = function(self)
			if self:hasGarbage("oof") then
				self:notify("oof loop is already enabled")
				return
			end
			
			local garbage = self:createGarbage("oof")
			garbage.running = true
			
			task.spawn(function()
				while garbage.running do
					for _, player in self.robloxServices.Players:GetPlayers() do
						local head = player.Character and player.Character:FindFirstChild("Head")
						if head then
							for _, sound in head:GetChildren() do
								if sound:IsA("Sound") then
									sound.Playing = true
								end
							end
						end
					end
					task.wait(0.1)
				end
			end)
		end
	},
	{
		action = "unloopoof",
		description = "Stops the oof loop",
		run = function(self)
			local garbage = self:collectGarbage("oof")
			if garbage then
				garbage.running = false
			end
		end
	}
}
