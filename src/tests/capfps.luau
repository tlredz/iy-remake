local _ENV = getgenv()
local cap = 60

if _ENV.FPS_CAP_THREAD then
	setclipboard(typeof(_ENV.FPS_CAP_THREAD))
	task.cancel(_ENV.FPS_CAP_THREAD)
end

_ENV.FPS_CAP_THREAD = task.spawn(function()
	local os_clock = os.clock
	local task_wait = task.wait
	
	local timer = os_clock() + (1 / cap)
	
	while true do
		if os_clock() >= timer then
			timer = os_clock() + (1 / cap)
			task_wait()
		end
	end
end)