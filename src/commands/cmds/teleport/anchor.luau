local function setRootAnchored(self, anchored: boolean)
	local root = self.playerService:getRootPart()
	if root then
		root.Anchored = anchored
	end
end

return {
	{
		action = "anchor",
		description = "Anchors your characters RootPart",
		run = function(self)
			setRootAnchored(self, true)
		end
	},
	{
		action = "unanchor",
		description = "Unanchors your characters RootPart",
		run = function(self)
			setRootAnchored(self, false)
		end
	}
}
