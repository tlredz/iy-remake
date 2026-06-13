local commandData = {}
commandData.__index = commandData

function commandData.new(command)
	return setmetatable({
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