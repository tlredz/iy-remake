local function tryDelete(object)
	if not object:IsA("PackageLink") then return end
	
	if object.Parent:FindFirstChild("ADpart") then
		object.Parent:Destroy()
	end
	
	if object.Parent:FindFirstChild("AdGuiAdornee") then
		object.Parent.Parent:Destroy()
	end	
end

return {
	action = "removeads|adblock",
	description = "Automatically removes ad billboards",
	run = function(self)
		if self.privateEnv.adBlockConn then return end
		
		for _, object in workspace:GetDescendants() do
			tryDelete(object)
		end
		
		self.privateEnv.adBlockConn = self:connect(workspace.DescendantAdded, function(object)
			task.defer(tryDelete, object)
		end)
	end
}