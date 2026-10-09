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
	for _, arg in args do
		local argData = arg.argData
		-- if not argData then continue end
		
		--[[if argData.default and arg.value == nil then
			arg.value = argData.default
		end]]
		
		--[[if arg.value == nil and converting[arg.kind] then
			arg.value = converting[arg.kind](arg)
		end]]
	end
	
	return setmetatable({
		args = args,
		index = 1
	}, argsManager)
end

return argsManager