return {
	client = true,
	action = "allowrejoin|allowrj",
	description = "Changes if antiteleport allows you to rejoin or not",
	args = { kind = "boolean", name = "allow", optional = true },
	run = function(self, args)
		local allow = args:nextValue()

		-- no argument toggles it, like IY
		if allow == nil then
			allow = not self.storage.settings:getValue("allowRejoin")
		end

		self.storage.settings:setValue("allowRejoin", allow)
		self:notify("Client AntiTP", `Scripts now {allow and "may" or "may not"} make you rejoin the server`)
	end
}
