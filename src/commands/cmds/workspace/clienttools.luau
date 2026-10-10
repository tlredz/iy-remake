-- Set this to the link of the F3X script (a raw .luau/.lua link). Left nil on purpose: the link is not in this project.
local F3X_SOURCE_URL: string? = nil

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
		run = function(self)
			if F3X_SOURCE_URL == nil then
				self:notify("F3X", "no script link is set, fill in F3X_SOURCE_URL at the top of workspace/clienttools.luau")
				return
			end

			local loadstring = self:expectExploit("loadstring")
			if not loadstring then return end

			local ok, err = pcall(function()
				loadstring(game:HttpGet(F3X_SOURCE_URL))()
			end)

			if not ok then
				self:notify("F3X", `failed to load: {tostring(err)}`)
			end
		end
	}
}
