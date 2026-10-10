-- saveinstance uses the executor's saveinstance function. It can take a long time, so it runs in its own thread.

return {
	{
		action = "saveinstance|savegame|saveplace|savep",
		description = "Uses saveinstance to save the game",
		run = function(self)
			local saveinstance = self:expectExploit("saveinstance")
			if not saveinstance then return end

			self:notify("Saveinstance", "saving the game, this can take a while")

			task.spawn(function()
				local ok, err = pcall(saveinstance)

				if ok then
					self:notify("Saveinstance", "saved")
				else
					self:notify("Saveinstance", `failed: {tostring(err)}`)
				end
			end)
		end
	}
}
