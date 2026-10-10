-- keepiy does two things, and unkeepiy turns both off:
--   1. "manter interface": the window stays open when you click outside it (setKeepIY in src/ui/init.luau)
--   2. queues IY to load again after you teleport to another server.
-- A flag file says if the teleport part is on. The queued loader reads that file first, so unkeepiy works
-- even though a loader may already be queued. IY re-queues itself on load while the flag is on.

local executorEnv = require("../../../framework/environment/executor")

local FOLDER = "iy-remake"
local FLAG_PATH = "iy-remake/keepiy.flag"

-- Runs after the teleport. Stops when the flag is "off", otherwise loads the build.
-- The build path is the one from compile_command.txt, change it if you move the file.
local LOADER = [==[
local okFlag, flag = pcall(readfile, "iy-remake/keepiy.flag")
if okFlag and flag == "off" then return end
loadstring(readfile("iy-remake/compiled.luau"))()
]==]

local function readFlag(): boolean
	local ok, value = pcall(function()
		return executorEnv.readfile(FLAG_PATH)
	end)
	return ok and value == "on"
end

local function writeFlag(on: boolean): boolean
	local ok = pcall(function()
		if executorEnv.isfolder and executorEnv.makefolder and not executorEnv.isfolder(FOLDER) then
			executorEnv.makefolder(FOLDER)
		end
		executorEnv.writefile(FLAG_PATH, if on then "on" else "off")
	end)
	return ok
end

local function queueLoader(): boolean
	local queue = executorEnv.queueteleport
	if not queue then return false end

	queue(LOADER)
	return true
end

-- the "manter interface" part; the UI keeps the setting itself, so it is still on next time
local function setInterfaceKeep(self, on: boolean): boolean
	local interface = self.infiniteYield
	if interface == nil or interface.setKeepIY == nil then
		return false
	end

	interface:setKeepIY(on)
	return true
end

local function enable(self)
	if not setInterfaceKeep(self, true) then
		self:notify("Keepiy", "the main window is not ready, so it could not be kept open")
	end

	if not writeFlag(true) then
		self:notify("Keepiy", "could not write the flag file (writefile is missing?)")
		return
	end

	if not queueLoader() then
		self:notify("Keepiy", "your executor does not support queueteleport")
		return
	end

	self:notify("Keepiy", "the window stays open, and IY will load again after you teleport")
end

local function disable(self)
	setInterfaceKeep(self, false)
	writeFlag(false)
	self:notify("Keepiy", "disabled: the window closes on outside clicks again, and IY will not load after the next teleport")
end

-- Keeps the queue alive: when IY loads after a teleport and the flag is on, queue the loader again
if readFlag() then
	queueLoader()
end

return {
	{
		action = "keepiy",
		description = "Auto execute IY when you teleport through servers",
		run = function(self)
			enable(self)
		end
	},
	{
		action = "unkeepiy",
		description = "Disable keepiy",
		run = function(self)
			disable(self)
		end
	},
	{
		action = "togglekeepiy",
		description = "Toggles keepiy",
		run = function(self)
			if readFlag() then
				disable(self)
			else
				enable(self)
			end
		end
	}
}
