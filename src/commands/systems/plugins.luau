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

local executorEnv = require("../../framework/environment/executor")
local storageConfig = require("../../framework/config/storage")
local pluginsData = require("../../storage/data/plugins")
local pluginsConfig = require("../../framework/config/commands/plugins")
local classicPlugins = require("./classicPlugins")

local plugins = {}

local FOLDER = `{storageConfig.privateFolder}/plugins`

plugins.FOLDER = FOLDER

-- name -> { keys = { every action name this plugin added to the lookup }, commands = how many commands it has }
local loaded = {}

-- name -> why the last attempt to load it failed. A plugin that loads has no entry
local lastErrors = {}

local pluginSection = { isSection = true, isPluginSection = true }

-- Plugin commands also need display rows, with one row per command regardless of its aliases.
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
		for name in loaded do table.insert(names, name) end
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

local function removeFromArray(array: { string }, value: string)
	local index = table.find(array, value)
	if index then
		table.remove(array, index)
	end
end

-- Returns the stable installation name and the exact requested filename, if it has a supported extension.
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

-- Includes only supported filenames with valid installation names; folders and paths are never accepted as names.
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

local function readSource(name: string, preferred: string?): (string?, string?, string?)
	if executorEnv.readfile == nil or executorEnv.isfile == nil then
		return nil, "your exploit does not support readfile"
	end

	local candidates = {}
	local seen = {}
	local function candidate(filename)
		if not seen[filename] then
			seen[filename] = true
			table.insert(candidates, filename)
		end
	end
	-- A saved filename is checked too: imported storage must not introduce paths or a different plugin name.
	if preferred then
		local preferredName, filename = normalizeName(preferred)
		if preferredName == name and filename then candidate(filename) end
	end
	for _, extension in pluginsConfig.extensions do candidate(name .. extension) end

	-- Preserve the spelling of extensions reported by listfiles (for example .LUA on case-sensitive filesystems).
	local files = nil
	local index = 1
	while true do
		local filename = candidates[index]
		if not filename then
			if files ~= nil then break end
			files = folderFiles() or {}
			for _, extension in pluginsConfig.extensions do
				for _, file in files do
					if file.name == name and file.filename:sub(-#extension):lower() == extension then
						candidate(file.filename)
					end
				end
			end
			filename = candidates[index]
			if not filename then break end
		end
		local path = `{FOLDER}/{filename}`
		local existsSuccess, exists = pcall(executorEnv.isfile, path)
		if existsSuccess and exists then
			local readSuccess, content = pcall(executorEnv.readfile, path)
			if not (readSuccess and type(content) == "string") then
				return nil, `could not read {path}`
			end
			return content, nil, filename
		end
		index += 1
	end
	return nil, `file not found in {FOLDER}; tried: {table.concat(candidates, ", ")}`
end

-- Runs once. Only a classic return table is translated; source text and native command tables are preserved.
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

-- Checks every command and fills in the fields the command runner expects (same as list.luau does).
-- Returns a list of { entry, names }, or nil and the reason.
local function prepare(result: { any }): ({ { entry: any, names: { string } } }?, string?)
	local entries = result
	if type(result.action) == "string" then
		entries = { result }
	end

	local prepared = {}

	for _, source in entries do
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

		-- work on a copy, so the table the plugin returned is never changed
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

-- Reads, runs and registers a plugin. Nothing is registered unless every name is free.
local function loadFromFile(list, name: string, preferred: string?): (boolean, string | number)
	local source, readError, filename = readSource(name, preferred)
	if not source then
		return false, readError
	end
	
	local result, compileError = compile(source)
	if not result then
		return false, compileError
	end

	local prepared, checkError = prepare(result)
	if not prepared then
		return false, checkError
	end

	local keys = {}
	local taken = {}

	for _, item in prepared do
		for _, key in item.names do
			if list.lookup[key] ~= nil or taken[key] then
				return false, `'{key}' is already a command or an alias`
			end
			taken[key] = true
			table.insert(keys, key)
		end
	end

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
	return true, #prepared
end

-- loadFromFile, and the reason it failed is kept for plugins.getInstalled
local function loadInto(list, name: string, preferred: string?): (boolean, string | number)
	local success, detail = loadFromFile(list, name, preferred)

	lastErrors[name] = if success then nil else tostring(detail)
	return success, detail
end

local function unloadFrom(list, name: string)
	local record = loaded[name]
	if not record then return end

	for _, key in record.keys do
		list.lookup[key] = nil
		removeFromArray(list.array, key)
	end

	loaded[name] = nil
	updateDisplayList(list)
end

-- Loads a plugin file and remembers it. Returns true and the number of commands, or false and the reason.
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

-- Unloads a plugin and forgets it. Returns false when it was not installed.
function plugins.remove(list, text: string): boolean
	local name = normalizeName(text)
	if not name then return false end
	if pluginsData.object[name] == nil and loaded[name] == nil then
		return false
	end

	unloadFrom(list, name)
	lastErrors[name] = nil

	pluginsData.object[name] = nil
	pluginsData:save()

	return true
end

-- Loads the file again, so changes to it take effect. Returns true and the number of commands, or false and the reason.
function plugins.reload(list, text: string): (boolean, string | number)
	local name, filename = normalizeName(text)
	if not name then return false, "invalid plugin name" end
	if pluginsData.object[name] == nil then
		return false, `'{name}' is not installed`
	end

	local preferred = filename or pluginsData.object[name]
	unloadFrom(list, name)
	local success, detail = loadInto(list, name, preferred)
	if success then pluginsData:save() end
	return success, detail
end

-- Loads every installed plugin again. Returns the ones that failed, with the reason.
-- A failed plugin stays installed, so it is tried again on the next start.
function plugins.restore(list): { [string]: string }
	local failures = {}

	local changed = false
	for name, filename in pluginsData.object do
		if normalizeName(name) ~= name then
			failures[name] = "invalid installed plugin name"
			lastErrors[name] = failures[name]
		elseif not loaded[name] then
			local preferred = if type(filename) == "string" then filename else nil
			local success, detail = loadInto(list, name, preferred)
			if success and pluginsData.object[name] ~= filename then changed = true end
			if not success then
				failures[name] = tostring(detail)
			end
		end
	end

	if changed then pluginsData:save() end
	return failures
end

-- Adds every available plugin once, using the configured extension priority for duplicate basenames.
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

-- The installed plugins, sorted by name: { name, loaded, commands, error }. commands is how many commands a loaded
-- plugin gave (0 when it is not loaded), and error is why the last attempt to load it failed
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

-- Supported files not installed yet, sorted and deduplicated by installation name.
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
	table.sort(names, function(a, b) return a:lower() < b:lower() end)
	return names
end

return plugins
