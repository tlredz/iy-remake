return {
	action = "notify",
	description = "Sends you a notification with the provided text",
	args = {
		{
			kind = "string",
			name = "message"
		},
		{
			kind = "number",
			name = "duration",
			optional = true
		}
	},
	run = function(self, args)
		self:notify("Notification", args:nextValue(), args:nextValue())
	end
}