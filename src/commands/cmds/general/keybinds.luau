-- clickdelete and clickteleport are the actions you pick in Settings > Keybinds.
-- Running them directly does the same action once, on what the mouse is pointing at.

return {
	{
		action = "clickdelete",
		description = "Go to Settings > Keybinds > Add for click delete",
		run = function(self)
			local target = self.playerService:getMouse().Target
			local character = self.playerService:getCharacter()

			if not target then
				self:notify("Click delete", "nothing under the mouse")
				return
			end

			if target:IsA("Terrain") then
				self:notify("Click delete", "terrain cannot be deleted")
				return
			end

			if character and target:IsDescendantOf(character) then
				self:notify("Click delete", "that part belongs to your character")
				return
			end

			local name = target:GetFullName()
			target:Destroy()
			self:notify("Click delete", `deleted {name}`)
		end
	},
	{
		action = "clickteleport",
		description = "Go to Settings > Keybinds > Add for click teleport",
		run = function(self)
			self:run("mousetp")
		end
	}
}
