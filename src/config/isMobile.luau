local robloxServices = require("../services/robloxServices")
local userInputService = robloxServices.UserInputService

local isOnMobile = false

xpcall(
	function()
		isOnMobile = table.find({
			Enum.Platform.Android,
			Enum.Platform.IOS
		}, userInputService:GetPlatform()) ~= nil
	end,
	function()
		isOnMobile = (
			userInputService.TouchEnabled and
			not userInputService.KeyboardEnabled
		)
	end
)

return isOnMobile