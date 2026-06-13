local argsManager = {}
argsManager.__index = argsManager

function argsManager:next()
	local index = self.index
	self.index += 1
	
	return self.args[index]
end

function argsManager:nextValue()
	local arg = self:next()
	return arg and arg.value
end

function argsManager.new(args)
	return setmetatable({
		args = args,
		index = 1
	}, argsManager)
end

return argsManager