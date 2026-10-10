-- The creator of the game. For a group game that is the owner of the group.
local function getOwnerId(self)
	local creatorId = game.CreatorId

	if game.CreatorType ~= Enum.CreatorType.User then
		creatorId = self.groupService:GetGroupInfoAsync(creatorId).Owner.Id
	end

	return creatorId
end

return {
	{
		action = "creatorid",
		description = "Notify, or copies the creators ID to your clipboard",
		args = { kind = "boolean", name = "copy", optional = true },
		run = function(self, args)
			local ownerId = tostring(getOwnerId(self))

			if args:nextValue() then
				self.executorEnv.setclipboard(ownerId)
			end

			self:notify("Creator Id", `the OwnerId is '{ownerId}'`)
		end
	},
	{
		client = true,
		action = "setcreatorid|setascreator",
		description = "Sets your userid to the creators ID",
		run = function(self, args)
			local ownerId = getOwnerId(self)
			self.localPlayer.UserId = ownerId
			self:notify("Set ID", `Set UserId to '{ownerId}'`)
		end
	}
}
