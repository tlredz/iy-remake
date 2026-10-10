local resolvePlayers = require("../../systems/resolvePlayers")

-- A part that belongs to a character (the body of a player or of an NPC)
local function isCharacterPart(part: BasePart): boolean
	local parent = part.Parent
	if parent and parent:FindFirstChildWhichIsA("Humanoid") then
		return true
	end

	local grandParent = parent and parent.Parent
	return grandParent ~= nil and grandParent:FindFirstChildWhichIsA("Humanoid") ~= nil
end

-- Unanchored parts that are not part of a character (own character excluded)
local function looseParts(self): { BasePart }
	local character = self.playerService:getCharacter()
	local list = {}

	for _, part in workspace:GetDescendants() do
		if part:IsA("BasePart") and not part.Anchored and not (character and part:IsDescendantOf(character)) and not isCharacterPart(part) then
			table.insert(list, part)
		end
	end

	return list
end

return {
	{
		action = "tpunanchored|tpua",
		description = "Teleports unanchored parts to a player",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			local head = target and target.Character and target.Character:FindFirstChild("Head")
			if not head then return end

			local garbage = self:registerGarbage("tpunanchored")
			garbage.forces = garbage.forces or {}

			for _, part in looseParts(self) do
				-- A BodyPosition keeps the part pulled to the head. thawunanchored removes them.
				local force = Instance.new("BodyPosition")
				force.MaxForce = Vector3.one * math.huge
				force.Position = head.Position
				force.Parent = part
				table.insert(garbage.forces, force)
			end
		end
	},
	{
		action = "animsunanchored|freezeua",
		description = "Freezes unanchored parts",
		run = function(self)
			if self:hasGarbage("freezeua") then
				self:notify("Freeze", "unanchored parts are already frozen, use thawunanchored")
				return
			end

			local garbage = self:createGarbage("freezeua")
			garbage.parts = {}

			for _, part in looseParts(self) do
				part.Anchored = true
				table.insert(garbage.parts, part)
			end

			self:notify("Freeze", `froze {#garbage.parts} unanchored part(s)`)
		end
	},
	{
		action = "thawunanchored|thawua|unfreezeua",
		description = "Thaws unanchored parts",
		run = function(self)
			local forces = self:collectGarbage("tpunanchored")
			if forces then
				for _, force in forces.forces or {} do
					force:Destroy()
				end
			end

			local frozen = self:collectGarbage("freezeua")
			if frozen then
				for _, part in frozen.parts do
					if part.Parent then
						part.Anchored = false
					end
				end
			end
		end
	}
}
