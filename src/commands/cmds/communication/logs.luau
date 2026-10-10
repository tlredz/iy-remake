local chatLogs = require("../../systems/chatLogs")

return {
	{
		action = "logs",
		description = "Opens the chat logs window with chat and join logs turned on",
		run = function(self)
			chatLogs.setChat(true)
			chatLogs.setJoin(true)
			self.infiniteYield:chatLogs("chat")
		end
	},
	{
		action = "chatlogs|clogs",
		description = "Turns on chat logs and opens the chat tab",
		run = function(self)
			chatLogs.setChat(true)
			self.infiniteYield:chatLogs("chat")
		end
	},
	{
		action = "joinlogs|jlogs",
		description = "Turns on join logs and opens the joins tab",
		run = function(self)
			chatLogs.setJoin(true)
			self.infiniteYield:chatLogs("join")
		end
	},
	{
		action = "chatlogswebhook|logswebhook",
		description = "Set a discord webhook for chatlogs to go to (provide no url to disable this)",
		args = {
			kind = "string",
			name = "url",
			optional = true
		},
		run = function(self, args)
			local url = args:nextValue()

			if not url then
				chatLogs.setWebhook(nil)
				self:notify("Logs Webhook", "webhook disabled")
				return
			end

			if not self.executorEnv.httprequest then
				self:notify("Incompatible Exploit", "Your exploit does not support this command (missing request)")
				return
			end

			chatLogs.setWebhook(url)
			self:notify("Logs Webhook", "chat logs will be sent to the webhook")
		end
	}
}
