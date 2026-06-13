local Signal = {}
local Connection = {}

Connection.__index = Connection
Signal.__index = Signal

do
	function Connection:Disconnect(): (nil)
		if not self.Connected then
			return nil
		end
		
		local find = table.find(self.Signal, self)
		
		if find then
			table.remove(self.Signal, find)
		end
		
		self.Function = nil
		self.Connected = false
	end
	
	function Connection:Fire(...): (nil)
		if not self.Function then
			return nil
		end
		
		task.spawn(self.Function, ...)
	end
	
	function Connection.new(): Connection
		return setmetatable({
			Connected = true
		}, Connection)
	end
	
	setmetatable(Connection, {
		__index = function(self, index)
			error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(index)), 2)
		end,
		__newindex = function(tb, key, value)
			error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(key)), 2)
		end
	})
end

function Signal:Connect(Function): Connection
	assert(type(Function) == "function", "function expected, got " .. type(Function))
	
	local NewConnection = Connection.new()
	NewConnection.Function = Function
	NewConnection.Signal = self
	
	table.insert(self.Connections, NewConnection)
	return NewConnection
end

function Signal:Once(Function): (nil)
	local Connection;
	Connection = self:Connect(function(...)
		Function(...)
		Connection:Disconnect()
	end)
	return Connection
end

function Signal:Wait(): any?
	local WaitingCoroutine = coroutine.running()
	local Connection;Connection = self:Connect(function(...)
		Connection:Disconnect()
		task.spawn(WaitingCoroutine, ...)
	end)
	return coroutine.yield()
end

function Signal:Fire(...): (nil)
	for _, Connection in ipairs(self.Connections) do
		if Connection.Connected then
			Connection:Fire(...)
		end
	end
end

function Signal.new(): Signal
	return setmetatable({
		Connections = {}
	}, Signal)
end

setmetatable(Signal, {
	__index = function(self, index)
		error(`Attempt to get Signal::{ tostring(index) } (not a valid member)`, 2)
	end,
	__newindex = function(self, index, value)
		error(`Attempt to set Signal::{ tostring(index) } (not a valid member)`, 2)
	end
})

return Signal