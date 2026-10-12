-- Waypoints are saved per game, so each place keeps its own list: { [placeId] = { [name] = "x y z" } }.
-- The storage and the markers live in systems/waypoints, which the settings page (Edit/Goto Waypoints) uses too.

local waypoints = require("../../systems/waypoints")

local TITLE = "Waypoints"

-- Finds a waypoint by name and tells the player when there is none
local function getWaypoint(self, name)
	local waypoint = waypoints.find(name)

	if not waypoint then
		self:notify(TITLE, `there is no waypoint named '{name}'`)
	end

	return waypoint
end

local function goTo(self, args, mode)
	local waypoint = getWaypoint(self, args:nextValue())
	if not waypoint then return end
	
	local speed = args:nextValue()
	speed = if typeof(speed) == "number" then speed else nil
	
	waypoints.go(waypoint, mode, speed)
end

return {
	{
		action = "setwaypoint|swp|setwp|spos|savepos|setpos",
		description = "Sets a waypoint at your position",
		args = { kind = "string", name = "waypoint name" },
		run = function(self, args)
			local root = self:getRoot()
			if not root then return end

			local name = args:nextValue()

			waypoints.save(name, root.Position)
			waypoints.refreshMarkers()
			self:notify(TITLE, `saved waypoint '{name}' at {waypoints.format(root.Position)}`)
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

			waypoints.save(name, position)
			waypoints.refreshMarkers()
			self:notify(TITLE, `saved waypoint '{name}' at {waypoints.format(position)}`)
		end
	},
	{
		action = "waypoints|positions",
		description = "Shows a list of currently active waypoints",
		run = function(self)
			local list = waypoints.list()

			if #list == 0 then
				self:notify(TITLE, "there are no waypoints in this game")
				return
			end

			local lines = {}
			for _, waypoint in list do
				table.insert(lines, `{waypoint.name} {waypoints.format(waypoint.position)}`)
			end

			self:notify(TITLE, table.concat(lines, ", "))
		end
	},
	{
		action = "showwaypoints|showwp|showwps",
		description = "Shows all currently set waypoints",
		run = function(self)
			if waypoints.count() == 0 then
				self:notify(TITLE, "there are no waypoints to show")
				return
			end

			waypoints.show()
		end
	},
	{
		action = "hidewaypoints|hidewp|hidewps",
		description = "Hides shown waypoints",
		run = function()
			waypoints.hide()
		end
	},
	{
		action = "waypoint|wp|gotowaypoint|gotowp|gwp|loadpos|lpos|loadposition",
		description = "Teleports player to a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			goTo(self, args, "teleport")
		end
	},
	{
		action = "tweenwaypoint|twp|tweengotowaypoint|tgotowp",
		description = "Tweens player to a waypoint",
		args = {
			{ kind = "waypoint", name = "waypoint" },
			{ name = "tween_speed", kind = "number", optional = true },
		},
		run = function(self, args)
			goTo(self, args, "tween")
		end
	},
	{
		action = "walktowaypoint|wtwp|walktowp",
		description = "Walks player to a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			goTo(self, args, "walk")
		end
	},
	{
		action = "deletewaypoint|dwp|deletepos|dpos",
		description = "Deletes a waypoint",
		args = { kind = "waypoint", name = "waypoint" },
		run = function(self, args)
			local waypoint = getWaypoint(self, args:nextValue())
			if not waypoint then return end

			waypoints.remove(waypoint.name)
			waypoints.refreshMarkers()
			self:notify(TITLE, `deleted waypoint '{waypoint.name}'`)
		end
	},
	{
		action = "clearwaypoints|cwp|clearpositions|clearpos|cpos",
		description = "Clears all waypoints from every game",
		args = { kind = "boolean", name = "confirm", optional = true },
		run = function(self, args)
			local confirm = args:nextValue()
			if not confirm then
				self:notify(TITLE, "cancelled, use 'true' to confirm")
				return
			end

			local total = waypoints.clearAll()

			waypoints.hide()
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

			local count = waypoints.clearPlace()

			waypoints.hide()
			self:notify(TITLE, `deleted {count} waypoints from this game`)
		end
	}
}
