-- /src/core/checkStubs.luau
-- Shows which commands are still stubs (registered, but without a `run` function).

local commandsList = require("../commands/list")

local function findStubs()
	local stubs = {}
	local sectionName = "unknown"
	
	for _, entry in commandsList.original do
		if entry.isSection then
			sectionName = entry.sectionName
		elseif entry.run == nil then
			table.insert(stubs, { section = sectionName, name = entry.name })
		end
	end
	
	return stubs
end

return function(commandsController)
	local stubs = findStubs()
	if #stubs == 0 then
		return
	end
	
	local bySection = {}
	local order = {}
	
	for _, stub in stubs do
		if not bySection[stub.section] then
			bySection[stub.section] = {}
			table.insert(order, stub.section)
		end
		table.insert(bySection[stub.section], stub.name)
	end
	
	local lines = {}
	for _, section in order do
		local names = table.concat(bySection[section], ", ")
		table.insert(lines, `[{section}] {names}`)
	end
	
	local report = table.concat(lines, "\n")
	-- print(`infinite yield: {#stubs} command(s) without run:\n{report}`)
	commandsController:notify("Commands without run", `{#stubs} command(s) still need a run function, see console`)
end