local localPlayer = require("../services/localPlayer")

local playerProperties = {
	_self = localPlayer,
	name = localPlayer.Name,
	id = localPlayer.UserId,
	age = localPlayer.AccountAge,
	position = function()
		local character = localPlayer.Character
		return character and character:GetPivot().Position
	end,
	character = function()
		return localPlayer.Character
	end
}

local playersProperties = {
	random = function()
		local list = players:GetPlayers()
		return list[math.random(list)]
	end
}

return {
	player = playerProperties,
	me = playerProperties,
	user = playerProperties,
	players = playersProperties
}