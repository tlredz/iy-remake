return {
	action = "exit|shutdown|leave",
	description = "Kills roblox process",
	run = function()
		game:shutdown()
	end
}

