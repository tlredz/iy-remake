local robloxServices = require("./rbxServices")
local localPlayer = require("./localPlayer")
local logger = require("../../utils/logger")

local teleportService = robloxServices.TeleportService

local playerMouse = localPlayer:GetMouse()

local playerService = {}

function playerService:getMouse()
	return playerMouse
end

function playerService:isMouseInGuiObject(guiObject: GuiObject): boolean
	local guiPosition = guiObject.AbsolutePosition
	local guiSize = guiObject.AbsoluteSize
	
	return playerMouse.X >= guiPosition.X
		and playerMouse.X < guiPosition.X + guiSize.X
		and playerMouse.Y >= guiPosition.Y
		and playerMouse.Y < guiPosition.Y + guiSize.Y
end

function playerService:teleportToJobId(jobId, placeId)
	placeId = placeId or game.PlaceId
	teleportService:TeleportToPlaceInstance(placeId, jobId, localPlayer)
end

function playerService:isAlive()
	local humanoid = self:getHumanoid()
	return humanoid and humanoid.Health > 0
end

function playerService:getCharacter()
	return localPlayer.Character
end

function playerService:getHumanoid()
	local character = self:getCharacter()
	return character and character:FindFirstChildOfClass("Humanoid")
end

function playerService:getRootPart()
	local humanoid = self:getHumanoid()
	return humanoid and humanoid.RootPart
end

function playerService:resetCharacter()
	local character = localPlayer.Character
	if not character then return end
	
	if character.Humanoid then
		character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
	else
		character:BreakJoints()
	end
end

function playerService:getPlayersByName(query: string): { Player }
	local list = {}
	
	local subAt = #query
	query = query:lower()
	
	for _, player in robloxServices.Players:GetPlayers() do
		local name = string.lower(player.Name):sub(1, subAt)
		local displayName = string.lower(player.displayName):sub(1, subAt)
		
		if name == query or displayName == query then
			table.insert(list, player)
		end
	end
	
	return list
end

function playerService:getCamera()
	return workspace.CurrentCamera
end

--[[function getPlayersByName(Name)
	local Name,Len,Found = string.lower(Name),#Name,{}
	for _,v in pairs(Players:GetPlayers()) do
		if Name:sub(0,1) == '@' then
			if string.sub(string.lower(v.Name),1,Len-1) == Name:sub(2) then
				table.insert(Found,v)
			end
		else
			if string.sub(string.lower(v.Name),1,Len) == Name or string.sub(string.lower(v.DisplayName),1,Len) == Name then
				table.insert(Found,v)
			end
		end
	end
	return Found
end

function getPlayer(list,speaker)
	if list == nil then return {speaker.Name} end
	local nameList = splitString(list,",")

	local foundList = {}

	for _,name in pairs(nameList) do
		if string.sub(name,1,1) ~= "+" and string.sub(name,1,1) ~= "-" then name = "+"..name end
		local tokens = toTokens(name)
		local initialPlayers = Players:GetPlayers()

		for i,v in pairs(tokens) do
			if v.Operator == "+" then
				local tokenContent = v.Name
				local foundCase = false
				for regex,case in pairs(SpecialPlayerCases) do
					local matches = {string.match(tokenContent,"^"..regex.."$")}
					if #matches > 0 then
						foundCase = true
						initialPlayers = onlyIncludeInTable(initialPlayers,case(speaker,matches,initialPlayers))
					end
				end
				if not foundCase then
					initialPlayers = onlyIncludeInTable(initialPlayers,getPlayersByName(tokenContent))
				end
			else
				local tokenContent = v.Name
				local foundCase = false
				for regex,case in pairs(SpecialPlayerCases) do
					local matches = {string.match(tokenContent,"^"..regex.."$")}
					if #matches > 0 then
						foundCase = true
						initialPlayers = removeTableMatches(initialPlayers,case(speaker,matches,initialPlayers))
					end
				end
				if not foundCase then
					initialPlayers = removeTableMatches(initialPlayers,getPlayersByName(tokenContent))
				end
			end
		end

		for i,v in pairs(initialPlayers) do table.insert(foundList,v) end
	end

	local foundNames = {}
	for i,v in pairs(foundList) do table.insert(foundNames,v.Name) end

	return foundNames
end

function formatUsername(player)
	if player.DisplayName ~= player.Name then
		return string.format("%s (%s)", player.Name, player.DisplayName)
	end
	return player.Name
end]]

return playerService