-- lockworkspace: sets Locked on every part in the workspace, except your own character.
-- Each part keeps its old value, so unlockworkspace puts it back the way it was.

return {
	{
		action = "lockworkspace|lockws",
		description = "Locks the whole workspace",
		run = function(self)
			local garbage = self:createGarbage("lockworkspace")
			if not garbage then
				self:notify("Lock workspace", "the workspace is already locked")
				return
			end

			local character = self.playerService:getCharacter()

			for _, object in workspace:GetDescendants() do
				if object:IsA("BasePart") and not (character and object:IsDescendantOf(character)) then
					garbage[object] = object.Locked
					object.Locked = true
				end
			end

			self:notify("Lock workspace", "locked the parts in the workspace")
		end
	},
	{
		action = "unlockworkspace|unlockws",
		description = "Unlocks the whole workspace",
		run = function(self)
			local garbage = self:collectGarbage("lockworkspace")
			if not garbage then return end

			for object, original in garbage do
				if object.Parent then
					object.Locked = original
				end
			end

			self:notify("Lock workspace", "unlocked")
		end
	}
}
