-- src/utils/nameColor.luau
-- The color of a player's name in the chat, the same color the Roblox chat shows.
-- A player with a team gets the team color. Everyone else gets a color from a palette, chosen from the
-- username: the modern palette for TextChatService and the classic one for the legacy chat.

local MODERN_PALETTE = {
	Color3.fromRGB(253, 41, 67),   -- Bright red
	Color3.fromRGB(1, 162, 255),   -- Bright blue
	Color3.fromRGB(2, 184, 87),    -- Earth green
	Color3.fromRGB(107, 50, 124),  -- Bright violet
	Color3.fromRGB(218, 133, 65),  -- Bright orange
	Color3.fromRGB(245, 205, 48),  -- Bright yellow
	Color3.fromRGB(232, 186, 200), -- Light reddish violet
	Color3.fromRGB(215, 197, 154), -- Brick yellow
}

local CLASSIC_PALETTE = {
	Color3.fromRGB(196, 40, 28),   -- Bright red
	Color3.fromRGB(13, 105, 172),  -- Bright blue
	Color3.fromRGB(39, 70, 45),    -- Earth green
	Color3.fromRGB(107, 50, 124),  -- Bright violet
	Color3.fromRGB(218, 133, 65),  -- Bright orange
	Color3.fromRGB(245, 205, 48),  -- Bright yellow
	Color3.fromRGB(232, 186, 200), -- Light reddish violet
	Color3.fromRGB(215, 197, 154), -- Brick yellow
}

local nameColor = {}

-- The sum of the character codes of the username. Some positions count as negative, and which ones
-- depends on the length of the name, the same way the default chat computes it.
function nameColor.value(name: string): number
	local value = 0
	local length = #name

	for index = 1, length do
		local code = string.byte(name, index)
		local reverseIndex = length - index + 1

		if length % 2 == 1 then
			reverseIndex -= 1
		end

		if reverseIndex % 4 >= 2 then
			code = -code
		end

		value += code
	end

	return value
end

-- legacy: true when the game uses the legacy chat, which has its own palette
function nameColor.forPlayer(player: Player, legacy: boolean): Color3
	if player.Team then
		return player.Team.TeamColor.Color
	end

	local palette = if legacy then CLASSIC_PALETTE else MODERN_PALETTE
	return palette[nameColor.value(player.Name) % #palette + 1]
end

return nameColor
