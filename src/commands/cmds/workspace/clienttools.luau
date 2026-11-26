local scriptLoader = require("../../systems/scriptLoader")

-- F3X is the script f3x.luau of the scripts folder (see systems/scriptLoader), loaded like the other scripts
local function f3x(self)
	local chunk = scriptLoader.fetch(self, "F3X", "f3x.luau", "iy/f3x")
	if not chunk then return end

	local ok, err = pcall(chunk)
	if not ok then
		self:notify("F3X", `failed to run: {tostring(err)}`)
	end
end

return {
	{
		client = true,
		action = "btools",
		description = "Gives you building tools (DOES NOT REPLICATE)",
		run = function(self)
			local backpack = self.localPlayer:FindFirstChildWhichIsA("Backpack")
			if not backpack then
				self:notify("Btools", "your backpack is not loaded")
				return
			end

			-- One hopper bin per bin type: GameTool, Grab, Clone and Hammer
			for _, binType in Enum.BinType:GetEnumItems() do
				local tool = Instance.new("HopperBin")
				tool.BinType = binType
				tool.Name = "Building Tool"
				tool.Parent = backpack
			end
		end
	},
	{
		client = true,
		action = "f3x",
		description = "Gives you F3X building tools (DOES NOT REPLICATE)",
		run = function(self) task.spawn(f3x, self) end
	}
}
