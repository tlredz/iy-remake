-- Each section is one page of the Plugins tab: one page is shown at a time, moved with BACK and NEXT.
-- Blocks:
--   {"title", text}, {"text", text}, {"bold", text}  -> prose
--   {"code", source}  -> a code block written here
--   {"file", path}    -> a code block read from the repo (plugins/...), with its own copy of the text kept
local highlight = require("../../../utils/luahighlight")
local storageConfig = require("../storage")
local pluginsConfig = require("../commands/plugins")
local function h(text)
	return highlight:apply(text)
end

return {
	{
		{ "title", "Create a Plugin" },
		{ "text", `A plugin file returns {h("{ Command }")}: a list of command tables. You can also return one {h("Command")} table directly. Each command declares its names, arguments and function.` },
		{ "text", `Save the file in {h(storageConfig.privateFolder .. "/plugins")} with one of these extensions: {h(table.concat(pluginsConfig.extensions, ", "))}. Use a filename with letters, numbers, {h("_")} or {h("-")}.` },
		{ "text", `Install with {h("addplugin myplugin.luau")} or Manage Plugins. Use {h("reloadplugin myplugin")} after editing. Commands appear under {h(pluginsConfig.sectionName or "plugin commands")} in the main list.` },
		{ "text", "Code blocks have a copy button in their top right corner, so an example can go straight into a file." },
	},
	{
		{ "title", "Command Fields and Types" },
		{ "text", `<b>{h("action: string")}</b> — Required. The first name is the command name; separate aliases with {h('"|"')}, for example {h('"hello|hi"')}. Names and aliases must be unique across installed and built-in commands.` },
		{ "text", `<b>{h("description: string?")}</b> — Optional. Explains the command when its row is hovered or held.` },
		{ "text", `<b>{h("args: (Argument | { Argument })?")}</b> — Optional. Declare arguments in reading order. One argument can be written directly as an {h("Argument")} table. Omit this field for commands without arguments.` },
		{ "text", `<b>{h("run: (self, args) -> ()")}</b> — Supply the function that runs your command. {h("self")} is the command controller; {h("args")} reads validated arguments. Without this function, the command cannot perform an action.` },
	},
	{
		{ "title", "Argument Fields and Types" },
		{ "text", `<b>{h("kind: string")}</b> — The validator name, such as {h('"string"')}, {h('"number"')} or {h('"player"')}. It controls the hint and the value passed to your function.` },
		{ "text", `<b>{h("name: string?")}</b> — Optional label shown in the argument hint.` },
		{ "text", `<b>{h("optional: boolean?")}</b> — Set to {h("true")} to allow omission. Put optional arguments last. A missing value reads as {h("nil")}; provide a fallback in your function.` },
		{ "text", `<b>{h("options: ({ string } | string)?")}</b> — For string/text arguments, restrict values and offer autocomplete. Use {h('{ "red", "blue" }')} or {h('"red|blue"')}.` },
		{ "text", `<b>{h("min: number?")}, {h("max: number?")}, {h("floor: boolean?")}</b> — For numbers, define accepted bounds and require whole numbers. {h("clamp = { 1, 100 }")} also defines bounds; values outside them are rejected.` },
		{ "text", `<b>{h("variadic: boolean?")}</b> — On the last argument only, repeat its definition to accept more values. Add {h("optional = true")} to allow zero values.` },
	},
	{
		{ "title", "Argument Values" },
		{ "text", `<b>{h('"string"')}, {h('"text"')}, {h('"object"')}</b> → {h("string")}. Quotes keep values containing spaces together.` },
		{ "text", `<b>{h('"number"')}</b> → {h("number")}; <b>{h('"boolean"')}</b> → {h("boolean")}. Boolean inputs include true/false, yes/no and enabled/disabled.` },
		{ "text", `<b>{h('"vector3"')}</b> → {h("Vector3")}, entered as {h("0,10,0")}; <b>{h('"color3"')}</b> → {h("Color3")}, entered as {h('"#ff0000"')} or {h("255,0,0")}.` },
		{ "text", `<b>{h('"player"')}</b> → selector text ({h("string")}), not a Player instance. Turn it into Players with {h("self:resolvePlayers(text)")}, which understands names and selectors such as all or others. See Player Argument.` },
		{ "text", `<b>{h('"className"')}, {h('"team"')}, {h('"waypoint"')}, {h('"command"')}, {h('"alias"')}, {h('"plugin"')}</b> → validated name ({h("string")}). <b>{h('"keycode"')}</b> → an {h("EnumItem")} from Enum.KeyCode.` },
		{ "text", `Read each value with {h("args:nextValue()")}. {h("args:next()")} returns the argument record instead. Invalid or missing required values stop execution before run is called.` },
	},
	{
		{ "title", "Inside run(self, args)" },
		{ "text", `{h('self:notify("Title", "Message")')} shows a notification. {h("self.localPlayer")} is your player; {h("self.players")} is the Players service; {h("self.robloxServices")} provides other services.` },
		{ "text", `{h("self:getRoot()")} gets your character root when available. {h("self.playerService:getHumanoid()")} gets its Humanoid. Check for {h("nil")} before changing character objects.` },
		{ "text", `{h("self:run(name, args)")} runs another command; omitting args passes no arguments. {h("self:connect(signal, callback)")} registers a connection with the application's connection service.` },
		{ "text", "The examples on the next pages are independent files. Install each one separately; command names and aliases cannot replace an existing command." },
	},
	{
		{ "title", "Player Argument" },
		{ "text", `A {h('"player"')} argument gives you the text that was typed, not a Player. Read it with {h("args:nextValue()")}, then turn it into a list of Players with {h("self:resolvePlayers(text)")}.` },
		{ "text", `The list is empty when nobody matches, so check it before you use it. Use {h("[1]")} to take the first player when you need only one.` },
		{ "text", `A name matches players whose username or display name starts with that text, ignoring case. For example, {h('"bo"')} matches {h('"bob"')} and {h('"bobby"')}. Use {h('"@bo"')} to search usernames only.` },
		{ "bold", "These words and patterns select groups of players:" },
		{ "cases" },
		{ "bold", "Combine selectors with commas, + and -:" },
		{ "text", `Commas separate expressions, so {h('"noob,bob"')} gives both players. Inside one expression, {h("+")} adds players and {h("-")} takes them away, from left to right.` },
		{ "text", `{h('"all-friends"')} is everyone except your friends. {h('"-friends"')} does the same, since it starts from everyone. {h('"%blue-friends"')} is players on the blue team who are not your friends.` },
		{ "bold", "Example: teleport to a player" },
		{ "text", `Save as {h("players.luau")} and install with {h("addplugin players")}. Run {h("pgoto nearest")} to teleport to the closest player, or {h("pgoto bo")} to the first player whose name starts with bo.` },
		{ "text", "The command bar only accepts text that matches someone, but that player can leave before run is called, so the example checks again." },
		{ "file", "plugins/examples/players.luau" },
	},
	{
		{ "title", "Example 1: A Greeting" },
		{ "text", `Save as {h("greeting.luau")} and install with {h("addplugin greeting")}. Run {h('pluginhello "John Doe"')} or use its {h("phi")} alias.` },
		{ "file", "plugins/examples/greeting.luau" },
	},
	{
		{ "title", "Example 2: Two Commands in One File" },
		{ "text", `Save as {h("walkspeed.luau")}. After {h("addplugin walkspeed")}, run {h("pluginws 32")} or {h("pluginresetws")} to restore Roblox's usual default.` },
		{ "file", "plugins/examples/walkspeed.luau" },
	},
	{
		{ "title", "Example 3: Multiple Typed Arguments" },
		{ "text", `Save as {h("message.luau")}. Run {h('pluginmessage info "Hello world" true')}. The level has autocomplete, the message stays together in quotes, and the last boolean is optional.` },
		{ "file", "plugins/examples/message.luau" },
	},
	{
		{ "title", "Plugin Reference" },
		{ "text", "The full set of types for the plugin API, in Luau. Copy it to check your plugin files with a Luau type checker, so they use the same names and fields as the API." },
		{ "file", "plugins/types.luau" },
	},
}
