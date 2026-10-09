local logger = require("../utils/logger")

local notifier = {}

function notifier:notify(title: string?, message: string?, duration: number?): (nil)
	logger:expect(title, {"string"}, "'notifier:notify' #1")
	
	if message == nil then
		message = title
		title = "Notification"
	end
	
	-- testing print
	print("notification:", duration or 5, title, message)
end

return notifier