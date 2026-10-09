local robloxServices = require("../../framework/services/rbxServices")
local playerService = require("../../framework/services/playerService")
local localPlayer = require("../../framework/services/localPlayer")

-- Turns the text of a "player" argument into a list of Players.
-- Supports: me, all, others, random, #amount and name/display name prefixes.
-- (%team is not supported yet, so it resolves to an empty list.)

local function shuffle(list: { any })
	for index = #list, 2, -1 do
		local other = math.random(1, index)
		list[index], list[other] = list[other], list[index]
	end
	return list
end

local function resolvePlayers(text: string?): { Player }
	local query = (text or "me"):lower()
	local players = robloxServices.Players:GetPlayers()
	
	if query == "me" then
		return { localPlayer }
	elseif query == "all" then
		return players
	elseif query == "others" then
		local list = {}
		for _, player in players do
			if player ~= localPlayer then
				table.insert(list, player)
			end
		end
		return list
	elseif query == "random" then
		return { players[math.random(1, #players)] }
	end
	
	local amount = tonumber(query:match("^#(%d+)$"))
	if amount then
		return table.move(shuffle(players), 1, math.min(amount, #players), 1, {})
	end
	
	return playerService:getPlayersByName(text)
end

return resolvePlayers
