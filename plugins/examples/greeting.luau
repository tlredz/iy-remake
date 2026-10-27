return {
	{
		action = "pluginhello|phi",
		description = "Greet someone",
		args = {
			kind = "string",
			name = "who",
			optional = true,
		},
		run = function(self, args)
			-- Optional values need a fallback.
			local who = args:nextValue() or "world"
			self:notify("Hello", "Hello, " .. who)
		end,
	},
}
