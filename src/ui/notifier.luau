local logger = require("../utils/logger")

local notifier = {}

function notifier:notify(message)
	logger:expect(message, {"string"}, "'notifier:notify' #1")
	
	-- testing print
	print("IY notification:", message)
end

return notifier