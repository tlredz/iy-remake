-- /src/commands/services/loopService.luau

local privateEnv = require("../../framework/environment/private")
local logger = require("../../utils/logger")

local loopService = {
	-- id -> { func = function, cooldown = number, lastCall = number }
	_callbacks = {},
	_nextId = 0,
}

-- Runs every frame while there are callbacks, and exits once there are none left.
local function runLoop(self)
	while true do
		task.wait()
		
		if next(self._callbacks) == nil then
			privateEnv.loopThread = nil
			return
		end
		
		local now = os.clock()
		
		for _, data in self._callbacks do
			if now - data.lastCall >= data.cooldown then
				data.lastCall = now
				task.defer(data.func)
			end
		end
	end
end

-- Starts the loop thread, if it is not running yet.
function loopService:start()
	if privateEnv.loopThread ~= nil then
		return
	end
	
	privateEnv.loopThread = task.defer(runLoop, self)
end

-- Stops the loop thread and forgets every callback.
function loopService:stop()
	local thread = privateEnv.loopThread
	privateEnv.loopThread = nil
	table.clear(self._callbacks)
	
	if thread ~= nil then
		task.cancel(thread)
	end
end

-- Adds a callback that runs every `cooldown` seconds (0 means every frame).
-- Returns an id that can be given to `remove`.
function loopService:add(callback: () -> (), cooldown: number?): number
	logger:expect(callback, {"function"}, "'loopService:add' #1")
	logger:expect(cooldown, {"number", "nil"}, "'loopService:add' #2")
	
	self._nextId += 1
	local id = self._nextId
	
	self._callbacks[id] = {
		func = callback,
		cooldown = math.max(cooldown or 0, 0),
		lastCall = -math.huge
	}
	
	self:start()
	return id
end

-- Removes a callback that was added with `add`.
function loopService:remove(id: number)
	logger:expect(id, {"number"}, "'loopService:remove' #1")
	self._callbacks[id] = nil
end

return loopService