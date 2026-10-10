return {
	{
		client = true,
		action = "invisibleparts|invisparts",
		description = "Shows invisible parts",
		run = function(self)
			local shown = self.privateEnv.shownParts or {}
			self.privateEnv.shownParts = shown

			for _, object in workspace:GetDescendants() do
				if object:IsA("BasePart") and object.Transparency == 1 then
					if not table.find(shown, object) then
						table.insert(shown, object)
					end
					object.Transparency = 0
				end
			end
		end
	},
	{
		client = true,
		action = "uninvisibleparts|uninvisparts",
		description = "Makes parts affected by invisparts return to normal",
		run = function(self)
			for _, object in self.privateEnv.shownParts or {} do
				object.Transparency = 1
			end
			self.privateEnv.shownParts = {}
		end
	}
}
