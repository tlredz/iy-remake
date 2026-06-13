local robloxServices = require("./robloxServices")
local coreGui = robloxServices.CoreGui

local messageService = {}
messageService.__index = messageService

function messageService:destroy()
	self.message:destroy()
	setmetatable(self, nil)
end

function messageService:set(message)
	if message and #message > 0 then
		self.message.Text = message
		self.message.Parent = coreGui
	else
		self.message.Parent = nil
	end
end

function messageService.new()
	return setmetatable({
		message = Instance.new("Message")
	}, messageService)
end

return messageService