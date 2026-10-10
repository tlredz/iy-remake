local resolvePlayers = require("../../systems/resolvePlayers")
local freecam = require("../../systems/freecam")

local TITLE = "Freecam"

-- Waypoints are saved per game: { [placeId] = { [name] = "x, y, z" } }
local function getWaypointPosition(self, name: string): Vector3?
	local places = self.storage.waypoints:getValue(tostring(game.PlaceId))
	local coords = type(places) == "table" and places[name]
	if not coords then return nil end

	return self:unstringify(coords, "Vector3")
end

-- No spaces, so the text can be pasted straight into freecampos
local function formatPosition(position: Vector3): string
	return `{math.round(position.X)},{math.round(position.Y)},{math.round(position.Z)}`
end

return {
	{
		action = "freecam|fc",
		description = "Allows you to freely move camera around the game",
		args = {
			kind = "number",
			name = "camera speed",
			optional = true
		},
		run = function(self, args)
			local speed = args:nextValue()
			if speed then
				self.privateEnv.freecamSpeed = speed
			end

			freecam.start(self)
		end
	},
	{
		action = "freecampos|fcpos",
		description = "Moves / opens freecam in a certain position",
		args = { kind = "vector3" },
		run = function(self, args)
			local position = args:nextValue()
			if position then
				freecam.start(self, position)
			end
		end
	},
	{
		action = "freecamwaypoint|fcwp",
		description = "Moves / opens freecam to a waypoint",
		args = {
			kind = "waypoint"
		},
		run = function(self, args)
			local name = args:nextValue()
			local position = name and getWaypointPosition(self, name)
			if not position then
				self:notify(TITLE, `there is no waypoint named '{name}'`)
				return
			end

			freecam.start(self, position)
		end
	},
	{
		action = "freecamgoto|fcgoto|fctp",
		description = "Moves / opens freecam to a player",
		args = { kind = "player" },
		run = function(self, args)
			local target = resolvePlayers(args:nextValue())[1]
			local root = target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
			if not root then
				self:notify(TITLE, "that player's character is not loaded")
				return
			end

			freecam.start(self, root.Position)
		end
	},
	{
		action = "unfreecam|unfc",
		description = "Disables freecam",
		run = function(self)
			freecam.stop(self)
		end
	},
	{
		action = "freecamspeed|fcspeed",
		description = "Adjusts freecam speed (default is 1)",
		args = { kind = "number" },
		run = function(self, args)
			self.privateEnv.freecamSpeed = args:nextValue() or freecam.DEFAULT_SPEED
		end
	},
	{
		action = "notifyfreecamposition|notifyfcpos",
		description = "Noitifies you your freecam coordinates",
		run = function(self)
			local position = freecam.getPosition(self)
			if not position then
				self:notify(TITLE, "freecam is not on")
				return
			end

			self:notify("Freecam Position", formatPosition(position))
		end
	},
	{
		action = "copyfreecamposition|copyfcpos",
		description = "Copies your freecam coordinates to your clipboard",
		run = function(self)
			local position = freecam.getPosition(self)
			if not position then
				self:notify(TITLE, "freecam is not on")
				return
			end

			local setclipboard = self:expectExploit("setclipboard")
			if not setclipboard then return end

			setclipboard(formatPosition(position))
			self:notify(TITLE, "copied freecam position to clipboard")
		end
	},
	{
		action = "freecamboost|fcboost",
		description = "Increases the freecam boost (the BOOST button) by an amount, and saves it",
		args = { kind = "number", name = "amount", optional = true },
		run = function(self, args)
			local amount = args:nextValue() or 1
			local boost = freecam.addBoost(self, amount)
			self:notify(TITLE, `freecam boost is now {boost}x`)
		end
	},
}
