-- Plugins: extra commands loaded from files in <privateFolder>/plugins (for example workspace/infiniteYield/plugins).
--
-- Native plugins return their commands in the same format as the files in cmds/:
--
--     return {
--         {
--             action = "hello|hi",
--             description = "Says hello",
--             args = { kind = "string", name = "who", optional = true },
--             run = function(self, args)
--                 self:notify("Hello", args:nextValue() or "world")
--             end
--         }
--     }
--
-- Classic IY return tables are adapted by classicPlugins when enabled in config/commands/plugins.
-- Extensions and search priority also come from that configuration.
-- Installed plugins are remembered in storage (installedPlugins) and loaded again on startup.
-- A plugin cannot replace a built-in command or alias: if one of its names is taken, none of its commands are added.
-- The command list is passed in by the caller, so this module never requires list.luau (the bundler rejects cycles).
--
-- The sections of this file, in order: state, names, files, compile, rows of the list, loading, and the functions
-- that the commands and the Manage Plugins page use.

local executorEnv = require("../../framework/environment/executor")
local storageConfig = require("../../framework/config/storage")
local pluginsData = require("../../storage/data/plugins")
local pluginsConfig = require("../../framework/config/commands/plugins")
local classicPlugins = require("./classicPlugins")

local plugins = {}

-- ---------------------------------------------------------------------------------------------------------------------
-- state
-- ---------------------------------------------------------------------------------------------------------------------

local FOLDER = `{storageConfig.privateFolder}/plugins`

plugins.FOLDER = FOLDER

-- name -> { keys = every action name this plugin added to the lookup, commands = how many commands it has,
--           filename = the file it was read from, entries = the command tables it added to the list }
local loaded = {}

-- name -> why the last attempt to load it failed. A plugin that loads has no entry
local lastErrors = {}

-- the header of the plugin commands in the list. It is one table on purpose: the interface keeps the row it made for
-- it, and only the name and the place of the header change
local pluginSection = { isSection = true, isPluginSection = true }

-- ---------------------------------------------------------------------------------------------------------------------
-- names
-- ---------------------------------------------------------------------------------------------------------------------

-- Returns the installation name and, when the text ends with a supported extension, the exact filename. A name uses
-- letters, numbers, '_' and '-' only: a folder or a path is never a name
local function normalizeName(text: string): (string?, string?)
	if type(text) ~= "string" then return nil end

	local name = text
	local filename = nil

	for _, extension in pluginsConfig.extensions do
		if text:sub(-#extension):lower() == extension then
			name = text:sub(1, -#extension - 1)
			filename = text
			break
		end
	end

	if name:match("^[%w_%-]+$") then return name, filename end
	return nil
end

plugins.normalizeName = normalizeName

-- ---------------------------------------------------------------------------------------------------------------------
-- files
-- ---------------------------------------------------------------------------------------------------------------------

-- Lists the supported files of the folder, sorted by filename. Returns nil and the reason when they cannot be listed
local function folderFiles(): ({ { name: string, filename: string } }?, string?)
	if executorEnv.listfiles == nil then return nil, "your exploit does not support listfiles" end

	local success, paths = pcall(executorEnv.listfiles, FOLDER)
	if not (success and type(paths) == "table") then
		return nil, `could not read the folder {FOLDER}`
	end

	local files = {}

	for _, path in paths do
		local filename = type(path) == "string" and path:match("([^/\\]+)$")
		if filename then
			local name, explicit = normalizeName(filename)
			if name and explicit then
				table.insert(files, { name = name, filename = filename })
			end
		end
	end

	table.sort(files, function(a, b) return a.filename < b.filename end)
	return files
end

-- true when the file is in the folder. An exploit that errors on the check counts as a missing file
local function fileExists(filename: string): boolean
	local success, exists = pcall(executorEnv.isfile, `{FOLDER}/{filename}`)
	return success and exists and true or false
end

-- Finds the file of a plugin. The saved filename comes first, but only when it belongs to this plugin, so an imported
-- name cannot point somewhere else. Then the name comes with each extension, in config order. When none of them exists,
-- the same name with another spelling of the extension is looked for (such as demo.LUA on a case-sensitive filesystem).
-- Returns the filename, or nil and every filename that was tried
local function findFile(name: string, preferred: string?): (string?, { string })
	local tried = {}
	local seen = {}

	local function try(filename: string)
		if not seen[filename] then
			seen[filename] = true
			table.insert(tried, filename)
		end
	end

	if preferred then
		local preferredName, filename = normalizeName(preferred)
		if preferredName == name and filename then try(filename) end
	end

	for _, extension in pluginsConfig.extensions do
		try(name .. extension)
	end

	for _, filename in tried do
		if fileExists(filename) then return filename, tried end
	end

	-- the folder is listed only now, so a plugin that has a plain file never needs the listing
	local firstSpelling = #tried + 1
	local files = folderFiles() or {}

	for _, extension in pluginsConfig.extensions do
		for _, file in files do
			if file.name == name and file.filename:sub(-#extension):lower() == extension then
				try(file.filename)
			end
		end
	end

	for index = firstSpelling, #tried do
		if fileExists(tried[index]) then return tried[index], tried end
	end

	return nil, tried
end

-- Reads the source of a plugin. Returns the source, nil and the filename, or nil and the reason. A file that exists but
-- cannot be read is an error: another spelling of the name is not tried in its place
local function readSource(name: string, preferred: string?): (string?, string?, string?)
	if executorEnv.readfile == nil or executorEnv.isfile == nil then
		return nil, "your exploit does not support readfile"
	end

	local filename, tried = findFile(name, preferred)
	if filename == nil then
		return nil, `file not found in {FOLDER}; tried: {table.concat(tried, ", ")}`
	end

	local path = `{FOLDER}/{filename}`
	local success, content = pcall(executorEnv.readfile, path)

	if not (success and type(content) == "string") then
		return nil, `could not read {path}`
	end

	return content, nil, filename
end

-- ---------------------------------------------------------------------------------------------------------------------
-- compile
-- ---------------------------------------------------------------------------------------------------------------------

-- Runs the source of a plugin once. A classic return table is translated; a native one is kept as it is
local function compile(source: string): ({ any }?, string?)
	if executorEnv.loadstring == nil then return nil, "your exploit does not support loadstring" end

	local loadSuccess, chunk, compileError = pcall(executorEnv.loadstring, source)
	if not loadSuccess then return nil, tostring(chunk) end
	if not chunk then return nil, tostring(compileError) end

	local environment
	if pluginsConfig.translateClassic then
		local success, result = pcall(classicPlugins.environment, chunk)
		if success then environment = result end
	end

	local runSuccess, result = pcall(chunk)
	if not runSuccess then return nil, `error while loading the plugin: {result}` end
	if type(result) ~= "table" then return nil, "the plugin must return a table of commands" end

	if pluginsConfig.translateClassic and classicPlugins.detect(result) then
		local success, commands, reason = pcall(classicPlugins.translate, result, environment)
		if not success then return nil, `could not translate the classic plugin: {commands}` end
		return commands, reason
	end

	return result
end

-- Checks every command and fills in the fields the command runner expects, the same as list.luau does. Each command is
-- copied, so the table the plugin returned is never changed. Returns a list of { entry, names }, or nil and the reason
local function prepare(result: { any }): ({ { entry: any, names: { string } } }?, string?)
	local sources = result
	if type(result.action) == "string" then
		sources = { result }
	end

	local prepared = {}

	for _, source in sources do
		if type(source) ~= "table" or type(source.action) ~= "string" then
			return nil, "every command needs an action string"
		end

		if source.run ~= nil and type(source.run) ~= "function" then
			return nil, `run of '{source.action}' must be a function`
		end

		local names = {}

		for _, text in source.action:split("|") do
			local name = text:lower()
			if name == "" then
				return nil, `empty name in '{source.action}'`
			end
			table.insert(names, name)
		end

		local entry = {}
		for key, value in source do
			entry[key] = value
		end

		local args = entry.args or {}
		if #args == 0 and next(args) then
			args = { args }
		end
		entry.args = args

		local aliases = table.clone(names)
		table.sort(aliases, function(a, b)
			return #a < #b
		end)

		entry.name = names[1]
		entry.aliases = aliases
		entry.action = nil

		table.insert(prepared, { entry = entry, names = names })
	end

	if #prepared == 0 then
		return nil, "the plugin has no commands"
	end

	return prepared
end

-- ---------------------------------------------------------------------------------------------------------------------
-- rows of the command list
-- ---------------------------------------------------------------------------------------------------------------------

local function removeFromArray(array: { string }, value: string)
	local index = table.find(array, value)
	if index then
		table.remove(array, index)
	end
end

-- Rebuilds the plugin rows of the command list: the header, then the commands of every loaded plugin, by name. The
-- interface is told that the list changed
local function updateDisplayList(list)
	local original = list.original

	if original then
		for index = #original, 1, -1 do
			local entry = original[index]
			if entry.isPluginCommand or entry.isPluginSection then
				table.remove(original, index)
			end
		end

		local names = {}
		for name in loaded do
			table.insert(names, name)
		end
		table.sort(names)

		if #names > 0 then
			pluginSection.sectionName = pluginsConfig.sectionName or "plugin commands"
			table.insert(original, pluginSection)

			for _, name in names do
				for _, entry in loaded[name].entries do
					table.insert(original, entry)
				end
			end
		end
	end

	list.revision = (list.revision or 0) + 1
	if list.changed then list.changed:Fire() end
end

-- The action names of the prepared commands, when none of them is taken by a command, an alias or a plugin in the list
local function claimNames(list, prepared): ({ string }?, string?)
	local keys = {}
	local taken = {}

	for _, item in prepared do
		for _, key in item.names do
			if list.lookup[key] ~= nil or taken[key] then
				return nil, `'{key}' is already a command or an alias`
			end

			taken[key] = true
			table.insert(keys, key)
		end
	end

	return keys
end

-- Adds the commands of a plugin to the list, and remembers the plugin. Only called after claimNames accepted the names
local function register(list, name: string, filename: string, prepared, keys: { string })
	local entries = {}

	for _, item in prepared do
		item.entry.isPluginCommand = true
		item.entry.pluginName = name
		table.insert(entries, item.entry)

		for _, key in item.names do
			list.lookup[key] = item.entry
			table.insert(list.array, key)
		end
	end

	loaded[name] = { keys = keys, commands = #prepared, filename = filename, entries = entries }
	pluginsData.object[name] = filename

	updateDisplayList(list)
end

-- Takes a loaded plugin out of the list, and its names with it
local function unregister(list, name: string)
	local record = loaded[name]
	if not record then return end

	for _, key in record.keys do
		list.lookup[key] = nil
		removeFromArray(list.array, key)
	end

	loaded[name] = nil
	updateDisplayList(list)
end

-- ---------------------------------------------------------------------------------------------------------------------
-- loading
-- ---------------------------------------------------------------------------------------------------------------------

-- Reads, runs and checks a plugin, then registers it. Nothing is registered unless every name is free. Returns true and
-- the number of commands, or false and the reason
local function loadFromFile(list, name: string, preferred: string?): (boolean, string | number)
	local source, readError, filename = readSource(name, preferred)
	if not source then return false, readError end

	local result, compileError = compile(source)
	if not result then return false, compileError end

	local prepared, checkError = prepare(result)
	if not prepared then return false, checkError end

	local keys, takenError = claimNames(list, prepared)
	if not keys then return false, takenError end

	register(list, name, filename :: string, prepared, keys)
	return true, #prepared
end

-- loadFromFile, and the reason it failed is kept for getInstalled
local function loadInto(list, name: string, preferred: string?): (boolean, string | number)
	local success, detail = loadFromFile(list, name, preferred)

	lastErrors[name] = if success then nil else tostring(detail)
	return success, detail
end

-- ---------------------------------------------------------------------------------------------------------------------
-- functions for the commands and the Manage Plugins page
-- ---------------------------------------------------------------------------------------------------------------------

-- Loads a plugin file and remembers it. Returns true and the number of commands, or false and the reason
function plugins.add(list, text: string): (boolean, string | number)
	local name, filename = normalizeName(text)
	if not name then
		return false, "plugin names can only use letters, numbers, '_' and '-'"
	end

	if loaded[name] then
		return false, `'{name}' is already loaded`
	end

	local success, detail = loadInto(list, name, filename)
	if not success then
		return false, detail
	end

	pluginsData:save()

	return true, detail
end

-- Unloads a plugin and forgets it. Returns false when it was not installed
function plugins.remove(list, text: string): boolean
	local name = normalizeName(text)
	if not name then return false end

	if pluginsData.object[name] == nil and loaded[name] == nil then
		return false
	end

	unregister(list, name)
	lastErrors[name] = nil

	pluginsData.object[name] = nil
	pluginsData:save()

	return true
end

-- Loads the file again, so changes to it take effect. Returns true and the number of commands, or false and the reason
function plugins.reload(list, text: string): (boolean, string | number)
	local name, filename = normalizeName(text)
	if not name then return false, "invalid plugin name" end

	if pluginsData.object[name] == nil then
		return false, `'{name}' is not installed`
	end

	local preferred = filename or pluginsData.object[name]

	unregister(list, name)

	local success, detail = loadInto(list, name, preferred)
	if success then pluginsData:save() end

	return success, detail
end

-- How long a plugin may take to load before it is reported as still loading. A plugin that waits for something missing
-- (like PlayerScripts.PlayerModule) never finishes, and this is how the user finds out
local WAIT_SECONDS = 10

-- Loads every installed plugin again, each in its own thread, so a plugin that waits forever does not hold up the others
-- or the interface. onFailure(name, reason) runs for each plugin that fails, and onSlow(name) runs once for each plugin
-- still loading after WAIT_SECONDS. A failed plugin stays installed, so it is tried again on the next start.
-- Returns the plugins that had already failed when it returned, as name -> reason. A plugin that fails later is only
-- reported through onFailure
function plugins.restore(list, onFailure: ((string, string) -> ())?, onSlow: ((string) -> ())?): { [string]: string }
	local failures = {}

	local names = {}
	for name in pluginsData.object do
		table.insert(names, name)
	end

	for _, name in names do
		local filename = pluginsData.object[name]
		local finished = false

		task.spawn(function()
			local failed = nil

			if normalizeName(name) ~= name then
				failed = "invalid installed plugin name"
				lastErrors[name] = failed
			elseif not loaded[name] then
				local preferred = if type(filename) == "string" then filename else nil
				local success, detail = loadInto(list, name, preferred)

				if success then
					if pluginsData.object[name] ~= filename then pluginsData:save() end
				else
					failed = tostring(detail)
				end
			end

			finished = true

			if failed then
				failures[name] = failed
				if onFailure then onFailure(name, failed) end
			end
		end)

		task.delay(WAIT_SECONDS, function()
			if not finished and onSlow then onSlow(name) end
		end)
	end

	return failures
end

-- Adds every plugin file of the folder once, using the configured extension priority for duplicate basenames. A plugin
-- that is already loaded is skipped, and an installed one that failed is tried again. Returns { added, failed }, or nil
-- and the reason when the folder cannot be listed
function plugins.addAll(list): ({ added: { string }, failed: { string } }?, string?)
	local files, reason = folderFiles()
	if not files then return nil, reason end

	local result = { added = {}, failed = {} }
	local seen = {}

	for _, file in files do
		local name = file.name
		if loaded[name] or seen[name] then continue end
		seen[name] = true

		local success, detail = plugins.add(list, name)
		if success then
			table.insert(result.added, name)
		else
			table.insert(result.failed, `{name}: {detail}`)
		end
	end

	return result
end

-- The installed plugins, sorted by name: { name, loaded, commands, error }. commands is how many commands a loaded plugin
-- gave (0 when it is not loaded), and error is why the last attempt to load it failed
function plugins.getInstalled(): { { name: string, loaded: boolean, commands: number, error: string? } }
	local installed = {}

	for name in pluginsData.object do
		local record = loaded[name]

		table.insert(installed, {
			name = name,
			loaded = record ~= nil,
			commands = if record then record.commands else 0,
			error = if record then nil else lastErrors[name],
		})
	end

	table.sort(installed, function(a, b)
		return a.name:lower() < b.name:lower()
	end)

	return installed
end

-- The supported files that are not installed yet, sorted and without repeats by installation name
function plugins.getAvailable(): ({ string }?, string?)
	local files, reason = folderFiles()
	if not files then return nil, reason end

	local names = {}
	local seen = {}

	for _, file in files do
		local name = file.name
		if not seen[name] and pluginsData.object[name] == nil then
			seen[name] = true
			table.insert(names, name)
		end
	end

	table.sort(names, function(a, b)
		return a:lower() < b:lower()
	end)

	return names
end

return plugins
