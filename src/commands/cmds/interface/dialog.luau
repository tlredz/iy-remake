-- src/commands/cmds/interface/dialog.luau

local MAX_BUTTONS = 3

local function splitButton(text: string): (string, string?)
	local label, command = text:match("^%s*(.-)%s*>%s*(.-)%s*$")

	if not label then
		return text:match("^%s*(.-)%s*$"), nil
	end

	if command == "" then
		command = nil
	end

	return label, command
end

return {
	action = "dialog",
	description = "Shows a dialog in the notifications with up to three buttons. \"Label>command\" runs a command when the button is tapped",
	args = {
		{ kind = "string", name = "title" },
		{ kind = "string", name = "message" },
		{ kind = "string", name = "button 1" },
		{ kind = "string", name = "button 2", optional = true },
		{ kind = "string", name = "button 3", optional = true },
	},
	run = function(self, args)
		local title = args:nextValue()
		local message = args:nextValue()
		local choices = {}

		for index = 1, MAX_BUTTONS do
			local text = args:nextValue()
			if text == nil then break end

			local label, command = splitButton(text)

			if label == "" then
				self:notify("Dialog", `button {index} needs a label`)
				return
			end
			
			local onTap = nil
			
			if command then
				local commandRunner = require("../../systems/commandRunner")
				
				local valid, reason = commandRunner.checkText(command)
				if not valid then
					self:notify("Dialog", `button "{label}": {reason}`)
					return
				end
				
				onTap = function()
					local success, failure = commandRunner.runText(command)
					
					if not success then
						self:notify("Dialog", failure or "the command did not run")
					end
				end
			end
			
			table.insert(choices, {
				text = label,
				primary = index == 1,
				onTap = onTap,
			})
		end
		
		self:ask(title, message, choices)
	end
}