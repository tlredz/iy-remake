local plugins = require("../../systems/plugins")

return {
	{
		action = "addplugin|plugin",
		description = "Add a plugin via command",
		args = {
			kind = "string",
			name = "plugin name"
		},
		run = function(self, args)
			local text = args:nextValue()
			if not text then return end

			local success, detail = plugins.add(self.commandsList, text)
			if success then
				self:notify("Plugins", `Added '{text}' ({detail} command(s))`)
			else
				self:notify("Plugin Error", detail)
			end
		end
	},
	{
		action = "removeplugin|deleteplugin",
		description = "Remove a plugin via command",
		args = { kind = "plugin" },
		run = function(self, args)
			local name = args:nextValue()
			if not name then return end

			if plugins.remove(self.commandsList, name) then
				self:notify("Plugins", `Removed '{name}'`)
			end
		end
	},
	{
		action = "reloadplugin",
		description = "Reloads a plugin",
		args = { kind = "plugin" },
		run = function(self, args)
			local name = args:nextValue()
			if not name then return end

			local success, detail = plugins.reload(self.commandsList, name)
			if success then
				self:notify("Plugins", `Reloaded '{name}' ({detail} command(s))`)
			else
				self:notify("Plugin Error", detail)
			end
		end
	},
	{
		action = "addallplugins|loadallplugins",
		description = "Adds all plugins from the infiniteYield/plugins folder",
		run = function(self)
			local result, reason = plugins.addAll(self.commandsList)
			if not result then
				self:notify("Plugin Error", reason)
				return
			end

			local message = `Added {#result.added} plugin(s)`
			if #result.failed > 0 then
				message ..= `, {#result.failed} failed (see console)`
				for _, line in result.failed do
					warn(`plugin {line}`)
				end
			end

			self:notify("Plugins", message)
		end
	}
}
