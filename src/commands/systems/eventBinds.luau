-- src/commands/systems/eventBinds.luau
-- Event binds: commands that run when something happens in the game (a player joins, a character spawns...).
--
-- They are saved in storage/data/eventBinds as { [event name] = { { command, delay, conditions }, ... } }, where
-- conditions has one text for each condition of the event (see framework/config/services/eventBinds).
-- The game events reach this module through fire, from services/eventListeners.

local eventBindsConfig = require("../../framework/config/services/eventBinds")
local eventBindsData = require("../../storage/data/eventBinds")
local commandRunner = require("./commandRunner")
local commandsController = require("../controllers/commandsController")
local resolvePlayers = require("./resolvePlayers")

local ANY = eventBindsConfig.ANY

local eventBinds = {}

-- the events in the order of the config, for the editor
eventBinds.events = eventBindsConfig.events

local eventsByName = {}
for _, event in eventBindsConfig.events do
	eventsByName[event.name] = event
end

local function trim(text: string): string
	return text:match("^%s*(.-)%s*$") or ""
end

-- The event with this name, or nil
function eventBinds.getEvent(name: string)
	return eventsByName[name]
end

-- The binds of an event, in the order they were added. It is a copy: changing it does not change the binds.
function eventBinds.getBinds(eventName: string): { any }
	local binds = eventBindsData.object[eventName]

	if type(binds) ~= "table" then
		return {}
	end

	return table.clone(binds)
end

-- The text of one condition as it is saved. Empty text is the default, and "any" is kept as "any".
-- Returns the text, or nil and the reason it is not valid.
local function normalizeCondition(condition, text: string?): (string?, string?)
	local value = trim(text or "")

	if value == "" then
		value = condition.default
	end

	if value:lower() == ANY then
		return ANY
	end

	if condition.kind == "Number" and tonumber(value) == nil then
		return nil, `{condition.label} must be a number or any`
	end

	return value
end

-- Adds a bind to an event. `conditions` has one text for each condition of the event.
-- Returns true, or false and the reason it was not added.
function eventBinds.add(eventName: string, command: string, delay: number, conditions: { string }?): (boolean, string?)
	local event = eventsByName[eventName]
	if not event then
		return false, "invalid event"
	end

	local text = trim(command)
	local valid, reason = commandRunner.checkText(text)

	if not valid then
		return false, reason
	end

	if type(delay) ~= "number" or delay < 0 then
		return false, "the delay must be 0 or more"
	end

	local saved = {}

	for index, condition in event.conditions do
		local value, problem = normalizeCondition(condition, conditions and conditions[index])

		if not value then
			return false, problem
		end

		saved[index] = value
	end

	local binds = eventBindsData.object[eventName]
	if type(binds) ~= "table" then
		binds = {}
		eventBindsData.object[eventName] = binds
	end

	table.insert(binds, { command = text, delay = delay, conditions = saved })
	eventBindsData:save()

	return true
end

-- Removes the bind at `index` of an event. Returns the bind that was removed, or nil when there was no bind to remove.
function eventBinds.remove(eventName: string, index: number): any
	local binds = eventBindsData.object[eventName]

	if type(binds) ~= "table" or binds[index] == nil then
		return nil
	end

	local removed = table.remove(binds, index)
	eventBindsData:save()

	return removed
end

-- Puts a bind that was removed back at `index` of an event (at the end, when the event has fewer binds now).
-- Returns true when it was put back.
function eventBinds.restore(eventName: string, index: number, bind: any): boolean
	if not eventsByName[eventName] or type(bind) ~= "table" then
		return false
	end

	local binds = eventBindsData.object[eventName]
	if type(binds) ~= "table" then
		binds = {}
		eventBindsData.object[eventName] = binds
	end

	table.insert(binds, math.clamp(index, 1, #binds + 1), bind)
	eventBindsData:save()

	return true
end

-- Changes the delay of the bind at `index` of an event. Returns true when the delay was changed.
function eventBinds.setDelay(eventName: string, index: number, delay: number): boolean
	local binds = eventBindsData.object[eventName]

	if type(binds) ~= "table" or type(binds[index]) ~= "table" then
		return false
	end

	if type(delay) ~= "number" or delay < 0 then
		return false
	end

	binds[index].delay = delay
	eventBindsData:save()

	return true
end

-- True when the player with this name is the one the filter asks for. The filter is read like a player argument.
local function isPlayerMatch(filter: string, name: string): boolean
	local success, players = pcall(resolvePlayers, filter)

	if not success then
		return false
	end

	for _, player in players do
		if player.Name == name then
			return true
		end
	end

	return false
end

-- True when a condition is met by the value the event passed for it
local function conditionMet(condition, filter: string, value: any): boolean
	if filter:lower() == ANY then
		return true
	end

	if condition.kind == "Player" then
		return isPlayerMatch(filter, tostring(value))
	end

	if condition.kind == "String" then
		return tostring(value):lower():find(filter:lower(), 1, true) ~= nil
	end

	if condition.kind == "Number" then
		local limit, number = tonumber(filter), tonumber(value)
		return limit ~= nil and number ~= nil and number <= limit
	end

	return false
end

-- True when every condition of the bind is met by the values of the event
local function matches(event, bind, values): boolean
	local saved = bind.conditions or {}

	for index, condition in event.conditions do
		local filter = tostring(saved[index] or condition.default)

		if not conditionMet(condition, filter, values[index]) then
			return false
		end
	end

	return true
end

-- A value put into a command. Plain words go in as they are. Anything else (spaces, chat text) is quoted, so the
-- command still reads it as one argument.
local function quote(text: string): string
	if text:match("^[%w_%-%.]+$") then
		return text
	end

	return '"' .. (text:gsub('"', '\\"')) .. '"'
end

-- Replaces $1, $2... in the command with the values of the event. A $n without a value is left as it is.
local function substitute(command: string, values: { any }): string
	return (command:gsub("%$(%d+)", function(digits: string): string?
		local value = values[tonumber(digits)]

		if value == nil then
			return nil
		end

		return quote(tostring(value))
	end))
end

-- Runs one bind: waits for its delay, puts in the values and runs the command. A command that does not run is
-- reported on screen, so the player knows why nothing happened.
local function runBind(bind, values)
	local delay = bind.delay or 0

	if delay > 0 then
		task.wait(delay)
	end

	local command = substitute(bind.command, values)
	local success, reason = commandRunner.runText(command)

	if not success then
		commandsController:notify("Event Bind", `'{command}' did not run: {reason}`)
	end
end

-- Runs the binds of an event that match. `...` are the values the event passes, in the order of its conditions
-- (a player name, a number, a chat message...). Each matching bind runs in its own thread, after its delay.
function eventBinds.fire(eventName: string, ...)
	local event = eventsByName[eventName]
	local binds = eventBindsData.object[eventName]

	if not event or type(binds) ~= "table" then
		return
	end

	local values = { ... }

	for _, bind in table.clone(binds) do
		if type(bind) == "table" and matches(event, bind, values) then
			task.spawn(runBind, bind, values)
		end
	end
end

return eventBinds
