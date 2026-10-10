local resolvePlayers = require("../../systems/resolvePlayers")

-- Size 1 means the default size of the part, same as IY
local function getSize(size: number): Vector3
	if size == 1 then
		return Vector3.new(2, 1, 1)
	end
	return Vector3.one * size
end

return {
	{
		action = "headsize",
		description = "Expands the head size for players Head (default is 1)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "head size",
				optional = true
			}
		},
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			local size = args:nextValue() or 1

			for _, target in targets do
				local head = target ~= self.localPlayer and target.Character and target.Character:FindFirstChild("Head")
				if head and head:IsA("BasePart") then
					head.CanCollide = false
					head.Size = getSize(size)
				end
			end
		end
	},
	{
		action = "hitbox",
		description = "Expands the hitbox for players HumanoidRootPart (default is 1)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "size",
				optional = true
			},
			{
				kind = "number",
				name = "transparency",
				optional = true,
				clamp = { 0, 1 }
			}
		},
		run = function(self, args)
			local targets = resolvePlayers(args:nextValue())
			local size = args:nextValue() or 1
			local transparency = args:nextValue() or 0.4

			for _, target in targets do
				local root = target ~= self.localPlayer and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
				if root and root:IsA("BasePart") then
					root.CanCollide = false
					root.Size = getSize(size)
					root.Transparency = transparency
				end
			end
		end
	}
}
