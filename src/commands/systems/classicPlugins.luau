-- Adapts the table returned by a classic IY plugin, without rewriting its source.
-- Dependencies that point back to the command controller are injected by core/init.
local executorEnv = require("../../framework/environment/executor")
local resolvePlayers = require("./resolvePlayers")

local classicPlugins = {}
local controller
local runText

function classicPlugins.configure(commandsController, runCommandText)
	controller = commandsController
	runText = runCommandText
end

-- A native plugin takes precedence even if it has unrelated fields named Commands or PluginName.
function classicPlugins.detect(result): boolean
	if type(result) ~= "table" or result.action ~= nil or #result > 0 then return false end
	if type(result.Commands) ~= "table" then return false end
	if type(result.PluginName) == "string" or type(result.PluginDescription) == "string" then
		return true
	end
	for name, command in result.Commands do
		if type(name) == "string" and type(command) == "table" and type(command.Function) == "function" then
			return true
		end
	end
	return false
end

-- Initially behaves like the chunk's original environment. Helpers are added only after detection,
-- and remain private to this plugin, including its local helper functions and callbacks.
function classicPlugins.environment(chunk)
	if type(executorEnv.getfenv) ~= "function" or type(executorEnv.setfenv) ~= "function" then return nil end
	local parent = executorEnv.getfenv(chunk)
	local environment = setmetatable({}, { __index = parent, __newindex = parent })
	executorEnv.setfenv(chunk, environment)
	return environment
end

local function enableHelpers(environment)
	if not environment or not controller then return end
	local helpers = {
		Players = controller.players,
		LocalPlayer = controller.localPlayer,
		IYMouse = controller.playerService:getMouse(),
		notify = function(...) return controller:notify(...) end,
		getRoot = function(character)
			return character and (character:FindFirstChild("HumanoidRootPart")
				or character:FindFirstChild("Torso") or character:FindFirstChild("UpperTorso"))
		end,
		getPlayer = function(text, speaker)
			if not text then return { (speaker or controller.localPlayer).Name } end
			local names = {}
			for _, player in resolvePlayers(text) do
				table.insert(names, player.Name)
			end
			return names
		end,
		getstring = function(first, args)
			return table.concat(args or rawget(environment, "cargs") or {}, " ", first or 1)
		end,
		execCmd = function(text)
			return runText(text)
		end,
	}
	for key, value in helpers do
		rawset(environment, key, value)
	end
end

function classicPlugins.translate(result, environment): ({ any }?, string?)
	if result.PluginDescription ~= nil and type(result.PluginDescription) ~= "string" then
		return nil, "PluginDescription must be a string"
	end
	local commands = {}
	for name, command in result.Commands do
		if type(name) ~= "string" or name == "" or name:find("[|%s]") then
			return nil, "classic plugin command names must be non-empty and cannot contain spaces or '|'"
		end
		if type(command) ~= "table" or type(command.Function) ~= "function" then
			return nil, `classic command '{name}' needs a Function`
		end
		if command.Aliases ~= nil and type(command.Aliases) ~= "table" then
			return nil, `Aliases of '{name}' must be a table`
		end
		if command.Description ~= nil and type(command.Description) ~= "string" then
			return nil, `Description of '{name}' must be a string`
		end

		local names = { name }
		local seen = { [name:lower()] = true }
		for _, alias in command.Aliases or {} do
			if type(alias) ~= "string" or alias == "" or alias:find("[|%s]") then
				return nil, `invalid alias of '{name}'`
			end
			if not seen[alias:lower()] then
				seen[alias:lower()] = true
				table.insert(names, alias)
			end
		end

		local callback = command.Function
		table.insert(commands, {
			action = table.concat(names, "|"),
			description = command.Description or result.PluginDescription or "",
			classicListName = command.ListName,
			args = { kind = "string", name = "args", optional = true, variadic = true },
			run = function(self, args)
				local values = {}
				while true do
					local value = args:nextValue()
					if value == nil then break end
					table.insert(values, value)
				end
				if environment then rawset(environment, "cargs", values) end
				local message = callback(values, self.localPlayer)
				if type(message) == "string" and not table.find(values, "nonotify") then
					self:notify(`Command: {name}`, message)
				end
				return message
			end,
		})
	end
	if #commands == 0 then return nil, "the classic plugin has no commands" end
	table.sort(commands, function(a, b) return a.action:lower() < b.action:lower() end)
	enableHelpers(environment)
	return commands
end

return classicPlugins
