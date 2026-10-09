local connection = {}
local signal = {}

connection.__index = connection
signal.__index = signal

function connection:Disconnect(): (nil)
	if not self._isConnected then return end
	
	local connections = self.Parent and self.Parent.Connections
	local found = connections and table.find(connections, self)
	
	if found then
		table.remove(connections, found)
	end
	
	self._connectedFunc = nil
	self._isConnected = false
end

function connection:Fire(...): (nil)
	if self._connectedFunc ~= nil then
		task.spawn(self._connectedFunc, ...)
	end
end

function connection.new(parent, func)
	local connected = setmetatable({
		_isConnected = true,
		_connectedFunc = func,
		Parent = parent
	}, connection)
	
	table.insert(parent.Connections, connected)
	return connected
end

function signal:Connect(func): Connection
	assert(type(func) == "function", `function expected, got {type(func)}`)
	
	return connection.new(self, func)
end

function signal:Once(func): (nil)
	local connection
	
	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(func, ...)
	end)
	
	return connection
end

function signal:Wait(): any?
	local waitingCoroutine, connection = coroutine.running(), nil
	
	connection = self:Connect(function(...)
		connection:Disconnect()
		task.spawn(waitingCoroutine, ...)
	end)
	
	return coroutine.yield()
end

function signal:Fire(...): (nil)
	for _, connection in ipairs(self.Connections) do
		connection:Fire(...)
	end
end

function signal.new()
	return setmetatable({
		Connections = {}
	}, signal)
end

return signal