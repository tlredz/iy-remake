local localPlayer = require("../services/localPlayer")
local robloxServices = require("../services/rbxServices")

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
		local list = robloxServices.Players:GetPlayers()
		return list[math.random(list)]
	end
}

return {
	player = playerProperties,
	me = playerProperties,
	user = playerProperties,
	players = playersProperties
}