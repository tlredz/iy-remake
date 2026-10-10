local customAliases = require("../../systems/customAliases")

return {
	{
		action = "addalias",
		description = "Adds an alias to a command",
		args = {
			{
				kind = "command"
			},
			{
				kind = "string",
				name = "alias"
			}
		},
		run = function(self, args)
			local commandName = args:nextValue()
			local alias = args:nextValue()
			if not (commandName and alias) then return end

			local success, reason = customAliases.add(self.commandsList, alias, commandName)
			if success then
				self:notify("Aliases Modified", `Added {alias:lower()} as an alias to {commandName}`)
			else
				self:notify("Aliases Modified", reason)
			end
		end
	},
	{
		action = "removealias",
		description = "Removes a custom alias",
		args = { kind = "alias" },
		run = function(self, args)
			local alias = args:nextValue()
			if not alias then return end

			local success, target = customAliases.remove(self.commandsList, alias)
			if success then
				self:notify("Aliases Modified", `Removed the alias {alias} from {target}`)
			end
		end
	},
	{
		action = "clraliases",
		description = "Removes all custom aliases",
		args = {
			kind = "boolean",
			name = "confirm",
			optional = true
		},
		run = function(self, args)
			-- 'clraliases false' cancels, anything else (or nothing) clears them
			if args and args:nextValue() == false then return end

			local count = customAliases.clear(self.commandsList)
			self:notify("Aliases Modified", `Removed {count} custom alias(es)`)
		end
	}
}
