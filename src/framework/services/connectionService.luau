local connectionService = {
	connections = {}
}

local privateEnv = require("../environment/private")

if privateEnv.connectionService then privateEnv.connectionService:cleanup() end
privateEnv.connectionService = connectionService

function connectionService:cleanup()
	for _, connection in self.connections do
		connection:Disconnect()
	end
end

function connectionService:disconnect(connection)
	if connection then
		connection:Disconnect()
	end
end

function connectionService:Connect(signal, func)
	local connection = signal:Connect(func)
	table.insert(self.connections, connection)
	return connection
end

return connectionService