-- Waypoints are saved per game, so each place keeps its own list:
-- { [placeId] = { [name] = { x, y, z } } }, stored in the "createdWaypoints" file.

local SHOWN_GARBAGE = "showingWaypoints"
local TITLE = "Waypoints"

local function placeKey()
	return tostring(game.PlaceId)
end

-- The live table of this game's waypoints (name -> coordinates).
-- With `create` it is made when missing, otherwise it can be nil.
local function getPlaceWaypoints(self, create)
	local waypointsData = self.storage.waypoints

	if create then
		return waypointsData:register(placeKey(), {})
	end

	local places = waypointsData:getValue(placeKey())
	return type(places) == "table" and places or nil
end

-- Every valid waypoint of this game, sorted by name.
local function listWaypoints(self)
	local list = {}

	for name, coords in getPlaceWaypoints(self) or {} do
		table.insert(list, {
			name = name,
			position = self:unstringify(coords, "Vector3")
		})
	end

	table.sort(list, function(a, b)
		return a.name:lower() < b.name:lower()
	end)

	return list
end

-- Finds a waypoint by name, ignoring case (like the argument validator does).
local function findWaypoint(self, name)
	local lowered = name:lower()

	for _, waypoint in listWaypoints(self) do
		if waypoint.name:lower() == lowered then
			return waypoint
		end
	end

	return nil
end

-- Saves a waypoint. Names ignore case, so "Home" replaces "home" instead of
-- creating a second one that the validator could not tell apart.
local function saveWaypoint(self, name, position)
	local places = getPlaceWaypoints(self, true)
	local lowered = name:lower()

	for storedName in places do
		if storedName:lower() == lowered then
			places[storedName] = nil
		end
	end

	places[name] = self:stringify(position)
	self.storage.waypoints:save()
end

local function removeWaypoint(self, waypoint)
	local places = getPlaceWaypoints(self)
	if places then
		places[waypoint.name] = nil
	end

	self.storage.waypoints:save()
end

local function countWaypoints(places)
	local count = 0

	if type(places) == "table" then
		for _ in places do
			count += 1
		end
	end

	return count
end

local function formatPosition(position)
	return `({math.round(position.X)}, {math.round(position.Y)}, {math.round(position.Z)})`
end

local function hideWaypoints(self)
	local markers = self:collectGarbage(SHOWN_GARBAGE)
	if not markers then return end

	for _, marker in markers do
		marker:Destroy()
	end
end

local function createMarker(waypoint)
	local part = Instance.new("Part")
	part.Size = Vector3.new(5, 5, 5)
	part.CFrame = CFrame.new(waypoint.position)
	part.Anchored = true
	part.CanCollide = false
	part.CanTouch = false
	part.CanQuery = false
	part.Parent = workspace

	local box = Instance.new("BoxHandleAdornment")
	box.Adornee = part
	box.AlwaysOnTop = true
	box.ZIndex = 10
	box.Size = part.Size
	box.Parent = part

	local billboard = Instance.new("BillboardGui")
	billboard.Adornee = part
	billboard.AlwaysOnTop = true
	billboard.Size = UDim2.fromOffset(160, 30)
	billboard.StudsOffset = Vector3.new(0, 4, 0)
	billboard.Parent = part

	local label = Instance.new("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UDim2.fromScale(1, 1)
	label.Text = waypoint.name
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextStrokeTransparency = 0
	label.TextScaled = true
	label.Parent = billboard

	return part
end

-- Redraws the markers of every waypoint in this game. Returns how many were drawn.
local function drawWaypoints(self)
	hideWaypoints(self)

	local markers = self:registerGarbage(SHOWN_GARBAGE)
	local waypoints = listWaypoints(self)

	for _, waypoint in waypoints do
		table.insert(markers, createMarker(waypoint))
	end

	return #waypoints
end

-- Keeps the markers in sync after a change, but only while they are being shown.
local function refreshMarkers(self)
	if self:hasGarbage(SHOWN_GARBAGE) then
		drawWaypoints(self)
	end
end

local function getWaypoint(self, name)
	local waypoint = findWaypoint(self, name)
	if not waypoint then
		self:notify(TITLE, `there is no waypoint named '{name}'`)
	end
	return waypoint
end

-- Takes the character off a seat first, the same way the goto commands do.
local function unseat(self)
	local humanoid = self.playerService:getHumanoid()
	if humanoid and humanoid.SeatPart then
		humanoid.Sit = false
		task.wait(0.1)
	end
end

return {
	{
		action = "setwaypoint|swp",
		description = "Sets a waypoint at your position",
		args = { kind = "string", name = "waypoint name" },
		run = function(self, args)
			local root = self:getRoot()
			if not root then return end
			
			local name = args:nextValue()
			
			saveWaypoint(self, name, root.Position)
			refreshMarkers(self)
			self:notify(TITLE, `saved waypoint '{name}' at {formatPosition(root.Position)}`)
		end
	},
	{
		action = "waypointpos|wpp",
		description = "Sets a waypoint with specified coordinates",
		args = {
			{ kind = "string", name = "waypoint name" },
			{ kind = "vector3", name = "position" },
		},
		run = function(self, args)
			local name = args:nextValue()
			local position = args:nextValue()

			saveWaypoint(self, name, position)
			refreshMarkers(self)
			self:notify(TITLE, `saved waypoint '{name}' at {formatPosition(position)}`)
		end
	},
	{
		action = "waypoints",
		description = "Shows a list of currently active waypoints",
		run = function(self)
			local waypoints = listWaypoints(self)

			if #waypoints == 0 then
				self:notify(TITLE, "there are no waypoints in this game")
				return
			end

			local lines = {}
			for _, waypoint in waypoints do
				table.insert(lines, `{waypoint.name} {formatPosition(waypoint.position)}`)
			end

			self:notify(TITLE, table.concat(lines, ", "))
		end
	},
	{
		action = "showwaypoints|showwp",
		description = "Shows all currently set waypoints",
		run = function(self)
			if #listWaypoints(self) == 0 then
				self:notify(TITLE, "there are no waypoints to show")
				return
			end

			drawWaypoints(self)
		end
	},
	{
		action = "hidewaypoints|hidewp",
		description = "Hides shown waypoints",
		run = function(self)
			hideWaypoints(self)
		end
	},
	{
		action = "waypoint|wp",
		description = "Teleports player to a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			local waypoint = getWaypoint(self, args:nextValue())
			if not waypoint then return end

			local root = self:getRoot()
			if not root then return end

			root.CFrame = CFrame.new(waypoint.position)
			root.AssemblyLinearVelocity = Vector3.zero
		end
	},
	{
		action = "tweenwaypoint|twp",
		description = "Tweens player to a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			local waypoint = getWaypoint(self, args:nextValue())
			if not waypoint then return end
			
			unseat(self)
			
			local root = self:getRoot(self)
			if not root then return end
			
			local info = TweenInfo.new(self.privateEnv.tweenSpeed or 1, Enum.EasingStyle.Linear)
			self.robloxServices.TweenService:Create(root, info, { CFrame = CFrame.new(waypoint.position) }):Play()
		end
	},
	{
		action = "walktowaypoint|wtwp",
		description = "Walks player to a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			local waypoint = getWaypoint(self, args:nextValue())
			if not waypoint then return end

			unseat(self)

			local humanoid = self.playerService:getHumanoid()
			if humanoid then
				humanoid:MoveTo(waypoint.position)
			end
		end
	},
	{
		action = "deletewaypoint|dwp",
		description = "Deletes a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			local waypoint = getWaypoint(self, args:nextValue())
			if not waypoint then return end

			removeWaypoint(self, waypoint)
			refreshMarkers(self)
			self:notify(TITLE, `deleted waypoint '{waypoint.name}'`)
		end
	},
	{
		action = "clearwaypoints|cwp",
		description = "Clears all waypoints from every game",
		args = { kind = "boolean", name = "confirm", optional = true },
		run = function(self, args)
			local confirm = args:nextValue()
			if not confirm then
				self:notify(TITLE, "cancelled, use 'true' to confirm")
				return
			end
		    
			local data = self.storage.waypoints
			local total = 0

			for placeId, places in data:getData() do
				total += countWaypoints(places)
				data:setValue(placeId, nil)
			end

			data:save()
			hideWaypoints(self)
			self:notify(TITLE, `deleted {total} waypoints from every game`)
		end
	},
	{
		action = "cleargamewaypoints|cgamewp",
		description = "Clears all waypoints for the game you are in",
		args = { kind = "boolean", name = "confirm", optional = true },
		run = function(self, args)
			local confirm = args:nextValue()
			if not confirm then
				self:notify(TITLE, "cancelled, use 'true' to confirm")
				return
			end
			
			local data = self.storage.waypoints
			local count = countWaypoints(getPlaceWaypoints(self))
			
			data:setValue(placeKey(), nil)
			data:save()
			hideWaypoints(self)
			self:notify(TITLE, `deleted {count} waypoints from this game`)
		end
	}
}
