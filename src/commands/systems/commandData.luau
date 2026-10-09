local commandData = {}
commandData.__index = commandData

function commandData.new(command)
	return setmetatable({
		isClient = command.client or command.isClient or command.onlyClient,
		isDeprecated = command.deprecated or command.isDeprecated,
		
		name = command.name,
		isSection = command.isSection,
		sectionName = command.sectionName,
		aliases = command.aliases,
		args = command.args,
		name = command.name,
		description = command.description
	}, commandData)
end

return commandData