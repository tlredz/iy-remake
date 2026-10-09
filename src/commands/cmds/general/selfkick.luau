return {
	action = "selfkick|kickmyself",
	description = "Kick your self from the server",
	args = {
		kind = "string",
		name = "kick message",
		optional = true
	},
	run = function(self, args)
		local msg = args:nextValue()
		self.localPlayer:Kick(msg)
	end
}