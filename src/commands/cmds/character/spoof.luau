-- Spoofs a Humanoid property on the client. The game reads the value it last wrote itself,
-- or the spoofed value until it writes one, while your own changes still go through.
-- The hooks are installed once per property. Changing the value later only updates it.
local function spoofProperty(self, property: string, value: number)
	local spoofs = self.privateEnv.spoofs or {}
	self.privateEnv.spoofs = spoofs

	local spoof = spoofs[property]
	if spoof then
		spoof.value = value
		return
	end

	local hookmetamethod = self:expectExploit("hookmetamethod")
	local checkcaller = self:expectExploit("checkcaller")
	if not (hookmetamethod and checkcaller) then return end

	local localPlayer = self.localPlayer
	local lowerProperty = string.lower(property)

	spoof = { value = value }
	spoofs[property] = spoof

	local function isSpoofed(object, key): boolean
		if checkcaller() or typeof(object) ~= "Instance" or typeof(key) ~= "string" then
			return false
		end
		if string.lower(key) ~= lowerProperty or not object:IsA("Humanoid") then
			return false
		end

		local character = localPlayer.Character
		return character ~= nil and object:IsDescendantOf(character)
	end

	local oldIndex
	oldIndex = hookmetamethod(game, "__index", function(object, key)
		if isSpoofed(object, key) then
			return spoof.last or spoof.value
		end
		return oldIndex(object, key)
	end)

	local oldNewIndex
	oldNewIndex = hookmetamethod(game, "__newindex", function(object, key, newValue)
		if isSpoofed(object, key) then
			spoof.last = tonumber(newValue)
		end
		return oldNewIndex(object, key, newValue)
	end)
end

return {
	{
		action = "spoofspeed|spoofws",
		description = "Spoofs your WalkSpeed on the Client",
		args = {
			kind = "number"
		},
		run = function(self, args)
			local value = args:nextValue()
			if value then
				spoofProperty(self, "WalkSpeed", value)
			end
		end
	},
	{
		action = "spoofjumppower|spoofjp",
		description = "Spoofs your JumpPower on the Client",
		args = {
			kind = "number"
		},
		run = function(self, args)
			local value = args:nextValue()
			if value then
				spoofProperty(self, "JumpPower", value)
			end
		end
	}
}
