-- invisible hides your character's parts and decals. The change is applied to the parts themselves,
-- so it replicates to other players, and the character stays in the workspace, so tools keep working.
-- visible puts the original transparency back.
-- toolinvisible does the same thing: the tools are part of the character and stay usable.

local function applyInvisible(self, garbage)
	local character = self.playerService:getCharacter()
	if not character then return end

	for _, object in character:GetDescendants() do
		if (object:IsA("BasePart") or object:IsA("Decal")) and garbage.originals[object] == nil then
			garbage.originals[object] = object.Transparency
			object.Transparency = 1
		end
	end
end

local function startInvisible(self)
	local previous = self:getGarbage("invisible")
	if previous and previous.connection and previous.connection.Connected then
		self:notify("Invisible", "you are already invisible")
		return
	end

	-- a leftover from an earlier run (re-executed script) keeps the real original values
	local originals = {}
	if previous then
		originals = previous.originals or {}
		self:collectGarbage("invisible")
		if previous.connection then
			previous.connection:Disconnect()
		end
	end

	local garbage = self:createGarbage("invisible")
	garbage.originals = originals

	applyInvisible(self, garbage)

	-- a new character after a respawn needs the same change
	garbage.connection = self:connect(self.localPlayer.CharacterAdded, function()
		applyInvisible(self, garbage)
	end)

	self:notify("Invisible", "other players can no longer see your character")
end

local function stopInvisible(self): boolean
	local garbage = self:collectGarbage("invisible")
	if not garbage then return false end

	if garbage.connection then
		garbage.connection:Disconnect()
	end

	for object, transparency in garbage.originals do
		if object.Parent then
			object.Transparency = transparency
		end
	end

	return true
end

return {
	{
		action = "invisible|invis",
		description = "Makes you invisible to other players",
		run = function(self)
			startInvisible(self)
		end
	},
	{
		action = "visible|vis",
		description = "Makes you visible to other players",
		run = function(self)
			if not stopInvisible(self) then
				self:notify("Visible", "you are already visible")
			end
		end
	},
	{
		action = "toolinvisible|toolinvis|tinvis",
		description = "Makes you invisible to other players and able to use tools",
		run = function(self)
			startInvisible(self)
		end
	}
}
