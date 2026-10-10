-- Custom aliases made with 'addalias'.
-- Saved in storage as { [alias] = command name }, and put into the command lookup when the commands start.
-- The command list is passed in by the caller (commandsController), so this module never requires list.luau.
-- list.luau loads the command files, and the bundler rejects any require cycle, even a lazy one.

local aliasesData = require("../../storage/data/aliases")

local customAliases = {}

local function removeFromArray(array: { string }, value: string)
	local index = table.find(array, value)
	if index then
		table.remove(array, index)
	end
end

-- Returns true, or false and the reason it was not added
function customAliases.add(list, alias: string, commandName: string): (boolean, string?)
	alias = alias:lower()

	if list.lookup[alias] ~= nil then
		return false, `'{alias}' is already a command or an alias`
	end

	local command = list.lookup[commandName:lower()]
	if not command then
		return false, "invalid command"
	end

	list.lookup[alias] = command
	table.insert(list.array, alias)

	aliasesData.object[alias] = command.name
	aliasesData:save()

	return true
end

-- Returns true and the command it pointed to, or false when the alias is not a custom one
function customAliases.remove(list, alias: string): (boolean, string?)
	alias = alias:lower()

	local target = aliasesData.object[alias]
	if type(target) ~= "string" then
		return false
	end

	list.lookup[alias] = nil
	removeFromArray(list.array, alias)

	aliasesData.object[alias] = nil
	aliasesData:save()

	return true, target
end

-- Removes every custom alias and returns how many there were
function customAliases.clear(list): number
	local aliases = {}
	for alias in aliasesData.object do
		table.insert(aliases, alias)
	end

	for _, alias in aliases do
		list.lookup[alias] = nil
		removeFromArray(list.array, alias)
		aliasesData.object[alias] = nil
	end

	aliasesData:save()
	return #aliases
end

-- Puts the saved aliases back into the lookup. Called once when the commands are initialized.
function customAliases.restore(list)
	for alias, commandName in aliasesData.object do
		local command = type(commandName) == "string" and list.lookup[commandName]

		if command and list.lookup[alias] == nil then
			list.lookup[alias] = command
			table.insert(list.array, alias)
		end
	end
end

return customAliases
