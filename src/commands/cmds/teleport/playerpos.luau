local resolvePlayers = require("../../systems/resolvePlayers")

-- Position of a player's character as "x, y, z", or nil when it is not loaded
local function getPositionText(self, text)
	local target = self.localPlayer
	if text then
		target = resolvePlayers(text)[1]
	end

	local character = target and target.Character
	local part = character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChildWhichIsA("BasePart"))
	if not part then return nil end

	local position = part.Position
	return tostring(math.round(position.X)) .. ", " .. tostring(math.round(position.Y)) .. ", " .. tostring(math.round(position.Z))
end

return {
	{
		action = "notifyposition|notifypos",
		description = "Notifies you the coordinates of a character",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			local text = getPositionText(self, args:nextValue())
			if text then
				self:notify("Position", text)
			else
				self:notify("Position", "character is not loaded")
			end
		end
	},
	{
		action = "copyposition|copypos",
		description = "Copies the coordinates of a character to your clipboard",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			local setclipboard = self:expectExploit("setclipboard")
			if not setclipboard then return end

			local text = getPositionText(self, args:nextValue())
			if text then
				setclipboard(text)
			else
				self:notify("Position", "character is not loaded")
			end
		end
	}
}
