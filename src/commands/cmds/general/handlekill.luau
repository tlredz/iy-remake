local resolvePlayers = require("../../systems/resolvePlayers")

return {
	{
		action = "handlekill|hkill",
		description = "Kills a player using tool damage (YOU NEED A TOOL) (TOOL)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "radius",
				optional = true
			}
		},
		run = function(self, args)
			local firetouchinterest = self:expectExploit("firetouchinterest")
			if not firetouchinterest then return end

			local character = self.playerService:getCharacter()
			local tool = character and character:FindFirstChildWhichIsA("Tool")
			local handle = tool and tool:FindFirstChild("Handle")
			if not handle then
				self:notify("Handle Kill", 'You need to hold a "Tool" that does damage on touch.')
				return
			end

			local targets = resolvePlayers(args:nextValue())
			local radius = args:nextValue() or math.huge

			-- Starting again replaces the running loop
			local previous = self:collectGarbage("handlekill")
			if previous then
				previous.running = false
			end

			local garbage = self:createGarbage("handlekill")
			garbage.running = true
			self:notify("Handle Kill", "Started!")

			-- Runs in its own thread, so the command returns right away. Stops when the tool is unequipped.
			task.spawn(function()
				while garbage.running do
					task.wait()

					local currentCharacter = self.playerService:getCharacter()
					if not (currentCharacter and tool.Parent == currentCharacter) then break end

					local root = self.playerService:getRootPart()
					for _, target in targets do
						local targetCharacter = target ~= self.localPlayer and target.Character
						local humanoid = targetCharacter and targetCharacter:FindFirstChildWhichIsA("Humanoid")
						local targetRoot = targetCharacter and targetCharacter:FindFirstChild("HumanoidRootPart")

						if root and humanoid and targetRoot and humanoid.Health > 0 and (root.Position - targetRoot.Position).Magnitude <= radius then
							firetouchinterest(handle, targetRoot, 1)
							firetouchinterest(handle, targetRoot, 0)
						end
					end
				end

				garbage.running = false
				self:notify("Handle Kill", "Stopped!")
			end)
		end
	}
}
