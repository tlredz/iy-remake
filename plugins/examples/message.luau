return {
	{
		action = "pluginmessage",
		description = "Send a labeled notification",
		args = {
			{
				kind = "string",
				name = "level",
				options = { "info", "warning" },
			},
			{ kind = "string", name = "message" },
			{
				kind = "boolean",
				name = "uppercase",
				optional = true,
			},
		},
		run = function(self, args)
			local level = args:nextValue()
			local message = args:nextValue()
			local uppercase = args:nextValue()
			if uppercase then
				message = string.upper(message)
			end
			self:notify(level, message)
		end,
	},
}
