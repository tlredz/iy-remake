-- autoclick and autokeypress send input through VirtualInputManager over and over.
-- The delays are in seconds: the press lasts for the release delay, then waits the click delay.

local MIN_WAIT = 0.01

local function wait(seconds: number)
	task.wait(math.max(seconds, MIN_WAIT))
end

local function stopLoop(self, name: string): boolean
	local garbage = self:collectGarbage(name)
	if not garbage then return false end

	garbage.running = false
	return true
end

-- press(true) starts the input, press(false) ends it
local function startLoop(self, name: string, clickDelay: number, releaseDelay: number, press: (boolean) -> ())
	stopLoop(self, name)

	local garbage = self:createGarbage(name)
	garbage.running = true

	task.spawn(function()
		while garbage.running do
			press(true)
			wait(releaseDelay)
			press(false)
			wait(clickDelay)
		end
	end)
end

return {
	{
		action = "autoclick",
		description = "Automatically clicks your mouse with a set delay",
		args = {
			{
				kind = "number",
				name = "click delay"
			},
			{
				kind = "number",
				name = "release delay"
			}
		},
		run = function(self, args)
			local clickDelay = args:nextValue() or 0.1
			local releaseDelay = args:nextValue() or 0.05

			local virtualInput = self.robloxServices.VirtualInputManager
			startLoop(self, "autoclick", clickDelay, releaseDelay, function(down: boolean)
				local mouse = self.playerService:getMouse()
				virtualInput:SendMouseButtonEvent(mouse.X, mouse.Y, 0, down, game, 0)
			end)
		end
	},
	{
		action = "unautoclick|noautoclick",
		description = "Turns off autoclick",
		run = function(self)
			stopLoop(self, "autoclick")
		end
	},
	{
		action = "autokeypress|keypress",
		description = "Automatically presses a key with a set delay",
		args = {
			{
				kind = "keycode"
			},
			{
				kind = "number",
				name = "click delay"
			},
			{
				kind = "number",
				name = "release delay"
			}
		},
		run = function(self, args)
			local keyCode = args:nextValue()
			local clickDelay = args:nextValue() or 0.1
			local releaseDelay = args:nextValue() or 0.05

			local virtualInput = self.robloxServices.VirtualInputManager
			startLoop(self, "autokeypress", clickDelay, releaseDelay, function(down: boolean)
				virtualInput:SendKeyEvent(down, keyCode, false, game)
			end)
		end
	},
	{
		action = "unautokeypress|noautokeypress|unkeypress|nokeypress",
		description = "Stops autokeypress",
		run = function(self)
			stopLoop(self, "autokeypress")
		end
	}
}
