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
		description = "Notifies the creator's ID. Its copy button copies the ID",
		run = function(self)
			local ownerId = tostring(getOwnerId(self))

			self:notify("Creator Id", `the OwnerId is '{ownerId}'`, nil, { copy = true, copyText = ownerId })
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
