-- "confirm" false cancels the delete. Any other value (true) deletes.
local function confirmed(self, confirm: boolean?, description: string): boolean
	if confirm == false then
		self:notify("Delete", "cancelled: " .. description)
		return false
	end
	return true
end

return {
	{
		client = true,
		action = "delete",
		description = "Removes any part with a certain name from the workspace (DOES NOT REPLICATE)",
		args = {
			{
				kind = "string",
				name = "object name"
			},
			{
				kind = "boolean",
				name = "confirm"
			}
		},
		run = function(self, args)
			local name = args:nextValue()
			local confirm = args:nextValue()
			if not confirmed(self, confirm, name) then return end

			local wanted = name:lower()
			for _, object in workspace:GetDescendants() do
				if object.Name:lower() == wanted then
					object:Destroy()
				end
			end

			self:notify("Item(s) Deleted", "Deleted " .. name)
		end
	},
	{
		client = true,
		action = "deleteclass|dc",
		description = "Removes any part with a certain classname from the workspace (DOES NOT REPLICATE)",
		args = {
			{
				kind = "className"
			},
			{
				kind = "boolean",
				name = "confirm"
			}
		},
		run = function(self, args)
			local className = args:nextValue()
			local confirm = args:nextValue()
			if not confirmed(self, confirm, className) then return end

			local wanted = className:lower()
			for _, object in workspace:GetDescendants() do
				if object.ClassName:lower() == wanted then
					object:Destroy()
				end
			end

			self:notify("Item(s) Deleted", "Deleted items with ClassName " .. className)
		end
	}
}
