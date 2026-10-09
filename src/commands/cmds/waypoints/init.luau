local placeId = tostring(game.PlaceId)

-- local cmdsUtils = require("../../cmdsUtils")

local function registerWP(self, wpName, value)
	wpsData:setValue(`{placeId}.{wpName}`, value)
	wpsData:save()
end

local function createWaypoint(self, args)
	-- gets HumanoidRootPart
	local rootPart = self.playerService:getRootPart()
	if not rootPart then return end
	
	-- export the waypoints data
	local wpName = args:nextValue() -- waypoint name
	
	-- coordinates
	local rootPos = rootPart.Position
	local coords = self:stringify(rootPos)
	
	-- saving new waypoint
	local wpsData = registerWP(self)
	wpsData:setValue(tostring(game.PlaceId), 0)
	wpsData:save()
	
	-- notifying the user
	self:notify(`seted a waypoint '{wpName}' at '{rootPos}'`)
end

local function gotoWaypoint(self, args)
	local rootPart = self.playerService:getRootPart()
	if not rootPart then return end
	
	local wpName = args:nextValue()
	
end

local function hideWaypoints(self)
	local garbage = self:collectGarbage("showingWaypoints")
	if garbage == nil then return end
	
	for _, part in garbage do
		part:Destroy()
	end
end

local function showWaypoints(self)
	hideWaypoints(self)
	
	local garbage = self:createGarbage("showingWaypoints")
	
	local waypoints = self.storage.waypointsData:getData()[tostring(game.PlaceId)]
	
	-- for wpName, pos in 
	
	--[[execCmd('hidewaypoints')
	wait()
	for i,_ in pairs(WayPoints) do
		local x = WayPoints[i].COORD[1]
		local y = WayPoints[i].COORD[2]
		local z = WayPoints[i].COORD[3]
		local part = Instance.new("Part")
		part.Size = Vector3.new(5,5,5)
		part.CFrame = CFrame.new(x,y,z)
		part.Parent = workspace
		part.Anchored = true
		part.CanCollide = false
		table.insert(waypointParts,part)
		local view = Instance.new("BoxHandleAdornment")
		view.Adornee = part
		view.AlwaysOnTop = true
		view.ZIndex = 10
		view.Size = part.Size
		view.Parent = part
	end
	for i,v in pairs(pWayPoints) do
		local view = Instance.new("BoxHandleAdornment")
		view.Adornee = pWayPoints[i].COORD[1]
		view.AlwaysOnTop = true
		view.ZIndex = 10
		view.Size = pWayPoints[i].COORD[1].Size
		view.Parent = pWayPoints[i].COORD[1]
		table.insert(waypointParts,view)
	end]]
end

-- delete all created waypoints
local function clearWaypoints(self)
	local wpsData = self.storage.waypointsData
	local waypoints = wpsData:register(placeId, {})
	local count = #waypoints
	
	table.clear(waypoints)
	
	self:notify(`deleted a total of {count} waypoints`)
end

--[[addcmd('setwaypoint',{'swp','setwp','spos','saveposition','savepos'},function(args, speaker)
	local WPName = tostring(getstring(1, args))
	if getRoot(speaker.Character) then
		notify('Modified Waypoints',"Created waypoint: "..getstring(1, args))
		local torso = getRoot(speaker.Character)
		WayPoints[#WayPoints + 1] = {NAME = WPName, COORD = {math.floor(torso.Position.X), math.floor(torso.Position.Y), math.floor(torso.Position.Z)}, GAME = PlaceId}
		if AllWaypoints ~= nil then
			AllWaypoints[#AllWaypoints + 1] = {NAME = WPName, COORD = {math.floor(torso.Position.X), math.floor(torso.Position.Y), math.floor(torso.Position.Z)}, GAME = PlaceId}
		end
	end	
	refreshwaypoints()
	updatesaves()
end)

addcmd('waypointpos',{'wpp','setwaypointposition','setpos','setwaypoint','setwaypointpos'},function(args, speaker)
	local WPName = tostring(getstring(1, args))
	if getRoot(speaker.Character) then
		notify('Modified Waypoints',"Created waypoint: "..getstring(1, args))
		WayPoints[#WayPoints + 1] = {NAME = WPName, COORD = {args[2], args[3], args[4]}, GAME = PlaceId}
		if AllWaypoints ~= nil then
			AllWaypoints[#AllWaypoints + 1] = {NAME = WPName, COORD = {args[2], args[3], args[4]}, GAME = PlaceId}
		end
	end	
	refreshwaypoints()
	updatesaves()
end)

addcmd('waypoints',{'positions'},function(args, speaker)
	if SettingsOpen == false then SettingsOpen = true
		Settings:TweenPosition(UDim2.new(0, 0, 0, 45), "InOut", "Quart", 0.5, true, nil)
		CMDsF.Visible = false
	end
	KeybindsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	AliasesFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	PluginsFrame:TweenPosition(UDim2.new(0, 0, 0, 175), "InOut", "Quart", 0.5, true, nil)
	PositionsFrame:TweenPosition(UDim2.new(0, 0, 0, 0), "InOut", "Quart", 0.5, true, nil)
	wait(0.5)
	SettingsHolder.Visible = false
	maximizeHolder()
end)

waypointParts = {}
addcmd('showwaypoints',{'showwp','showwps'},function(args, speaker)
	execCmd('hidewaypoints')
	wait()
	for i,_ in pairs(WayPoints) do
		local x = WayPoints[i].COORD[1]
		local y = WayPoints[i].COORD[2]
		local z = WayPoints[i].COORD[3]
		local part = Instance.new("Part")
		part.Size = Vector3.new(5,5,5)
		part.CFrame = CFrame.new(x,y,z)
		part.Parent = workspace
		part.Anchored = true
		part.CanCollide = false
		table.insert(waypointParts,part)
		local view = Instance.new("BoxHandleAdornment")
		view.Adornee = part
		view.AlwaysOnTop = true
		view.ZIndex = 10
		view.Size = part.Size
		view.Parent = part
	end
	for i,v in pairs(pWayPoints) do
		local view = Instance.new("BoxHandleAdornment")
		view.Adornee = pWayPoints[i].COORD[1]
		view.AlwaysOnTop = true
		view.ZIndex = 10
		view.Size = pWayPoints[i].COORD[1].Size
		view.Parent = pWayPoints[i].COORD[1]
		table.insert(waypointParts,view)
	end
end)

addcmd('hidewaypoints',{'hidewp','hidewps'},function(args, speaker)
	for i,v in pairs(waypointParts) do
		v:Destroy()
	end
	waypointParts = {}
end)

addcmd('waypoint',{'wp','lpos','loadposition','loadpos'},function(args, speaker)
	local WPName = tostring(getstring(1, args))
	if speaker.Character then
		for i,_ in pairs(WayPoints) do
			if tostring(WayPoints[i].NAME):lower() == tostring(WPName):lower() then
				local x = WayPoints[i].COORD[1]
				local y = WayPoints[i].COORD[2]
				local z = WayPoints[i].COORD[3]
				getRoot(speaker.Character).CFrame = CFrame.new(x,y,z)
			end
		end
		for i,_ in pairs(pWayPoints) do
			if tostring(pWayPoints[i].NAME):lower() == tostring(WPName):lower() then
				getRoot(speaker.Character).CFrame = CFrame.new(pWayPoints[i].COORD[1].Position)
			end
		end
	end
end)
]]

return {
	{
		action = "setwaypoint|swp",
		description = "Sets a waypoint at your position",
		args = { kind = "string" },
		run = createWaypoint
	},
	{
		action = "waypointpos|wpp",
		description = "Sets a waypoint with specified coordinates",
		args = { kind = "vector3" }
	},
	{
		action = "waypoints",
		description = "Shows a list of currently active waypoints"
	},
	{
		action = "showwaypoints|showwp",
		description = "Shows all currently set waypoints"
	},
	{
		action = "hidewaypoints|hidewp",
		description = "Hides shown waypoints"
	},
	{
		action = "waypoint|wp",
		description = "Teleports player to a waypoint",
		args = { kind = "waypoint" }
	},
	{
		action = "tweenwaypoint|twp",
		description = "Tweens player to a waypoint",
		args = { kind = "waypoint" }
	},
	{
		action = "walktowaypoint|wtwp",
		description = "Walks player to a waypoint",
		args = { kind = "waypoint" }
	},
	{
		action = "deletewaypoint|dwp",
		description = "Deletes a waypoint",
		args = { kind = "waypoint" }
	},
	{
		action = "clearwaypoints|cwp",
		description = "Clears all waypoints"
	},
	{
		action = "cleargamewaypoints|cgamewp",
		description = "Clears all waypoints for the game you are in",
		args = { kind = "boolean", name = "confirm" },
		run = clearWaypoints
	}
}