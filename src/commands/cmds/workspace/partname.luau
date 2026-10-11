-- partpath (partname): opens the "Teleport to Part" window. Click a part to see its path & name,
-- then "Select Part" saves it as a waypoint of this game. The window stays hidden until this runs,
-- and its Exit button closes it.

-- a name nobody uses yet, ignoring case: Part, Part1, Part2...
local function uniqueName(places, baseName)
	local taken = {}

	for name in places do
		taken[name:lower()] = true
	end

	if not taken[baseName:lower()] then
		return baseName
	end

	local number = 1
	while taken[baseName:lower() .. number] do
		number += 1
	end

	return baseName .. number
end

-- saves the part's position as a waypoint of this game. An existing waypoint is never overwritten
local function saveWaypoint(self, part)
	local waypoints = self.storage.waypoints
	local places = waypoints:register(tostring(game.PlaceId), {})

	local name = uniqueName(places, part.Name)
	places[name] = self:stringify(part.Position)
	waypoints:save()

	return name
end

return {
	{
		action = "partname|partpath",
		description = "Opens a window: click a part to see its path & name, then Select Part saves it as a waypoint",
		run = function(self)
			self.infiniteYield:openPartPath(function(part)
				local name = saveWaypoint(self, part)
				self:notify("Modified Waypoints", "Created waypoint: " .. name)
			end)
		end
	}
}
