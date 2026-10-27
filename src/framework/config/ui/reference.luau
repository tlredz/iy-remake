local colorFromRGB = require("../../../utils/tools").colorFromRGB
local cmdsColors = require("./colors").commands

local textHighlight = require("../../../utils/textHighlight")

local function h(text: string): string
	return textHighlight:apply(text)
end

local config = {
	cases = {
		{ "all", "- includes everyone" },
		{ "others", "- includes everyone except you" },
		{ "me", "- includes your player only" },
		{ "@username", "- searches for players by username only (ignores displaynames)" },
		{ "#[number]", "- gets a specified amount of random players" },
		{ "random", "- affects a random player" },
		{ "%[team name]", "- includes everyone on a given team" },
		{ "allies / team", "- players who are on your team" },
		{ "enemies / nonteam", "- players who are not on your team" },
		{ "friends", "- anyone who is friends with you" },
		{ "nonfriends", "- anyone who is not friends with you" },
		{ "guests", "- guest players (obsolete)" },
		{ "bacons", "- anyone with the \"bacon\" or pal hair" },
		{ "age[number]", "- includes anyone below or at the given age" },
		{ "rad[number]", "- includes anyone within the given radius" },
		{ "nearest", "- gets the closest player to you" },
		{ "farthest", "- gets the farthest player from you" },
		{ "group[ID]", "- gets players who are in a certain group" },
		{ "alive", "- gets players who are alive" },
		{ "dead", "- gets players who are dead" },
	},
	sections = {
		{
			{ "title", "Commands Colors" },
			{ "text", `{colorFromRGB("COMMAND_UNDEFINED", cmdsColors.undefined)} -> This command don't work (BETA)` },
			{ "text", `{colorFromRGB("CLIENT", cmdsColors.client)} -> Only works on client` },
			{ "text", `{colorFromRGB("DEPRECATED", cmdsColors.deprecated)} -> This command is deprecated` }
		},
		{
			{ "title", "Special Player Cases" },
			{ "text", "These keywords can be used to quickly select groups of players in commands:" },
			{ "cases" },
		},
		{
			{ "title", "Command Arguments" },
			{ "text", "Some commands need extra information. Anything you type after the command name is an argument, and arguments are separated by spaces." },
			{ "text", `The gray hint in the command bar shows what each argument expects. For example, {h("(fly_speed: number?)")} means you type a number.` },
			{ "bold", "The ? means the argument is optional. You can leave it out and the command still runs." },
			{ "text", `Arguments are read in order, so optional ones go last. If a value has spaces, put it in quotes, like {h('"John Doe"')}.` },
			{ "text", "If something is wrong, the command bar tells you what to fix, and nothing runs." },
			{ "bold", "Examples:" },
			{ "text", ";fly 50 - fly at speed 50\n;fov 90 - set the field of view to 90\n;tppos 0,10,0 - teleport to X 0, Y 10, Z 0" },
		},
		{
			{ "title", "What the Hint Words Mean" },
			{ "text", `<b>number</b> - a number, like 10 or 2.5\n<b>string</b> - text, like a name or a word\n<b>boolean</b> - yes or no. You can also type true/false or enabled/disabled\n<b>player</b> - a player name, or one of the special words above\n<b>vector3</b> - a position written as three numbers with commas: X,Y,Z, like 0,10,0\n<b>color3</b> - a color, written as {h("#ff0000")} or as red,green,blue from 0 to 255\n<b>waypoint</b> - the name of a waypoint you saved\n<b>className</b> - a type of object in the game, like Part or Model\n<b>team</b> - the name of a team in the game\n<b>keycode</b> - a keyboard key, like E\n<b>command</b> - the name of a command\n<b>alias</b> - a shortcut name you made with addalias\n<b>plugin</b> - the name of a plugin you installed\n<b>object</b> - any text, nothing is checked` },
		},
		{
			{ "title", "Various Operators" },
			{ "bold", "Use commas to separate multiple expressions:" },
			{ "text", ";locate noob,noob2,bob" },
			{ "bold", "Use - to exclude, and + to include players in your expression:" },
			{ "text", ";locate %blue-friends (gets players in blue team who aren't your friends)" },
			{ "bold", "Put ! before a command to run it with the last arguments it was ran with:" },
			{ "text", "After running ;offset 0 100 0,  you can run !offset anytime to repeat that command with the same arguments that were used to run it last time" },
		},
		{
			{ "title", "Command Looping" },
			{ "bold", "Form: [How many times it loops]^[delay (optional)]^[command]" },
			{ "text", "Use the 'breakloops' command to stop all running loops." },
			{ "bold", "Examples:" },
			{ "text", ";5^btools - gives you 5 sets of btools\n;10^3^drophats - drops your hats every 3 seconds 10 times\n;inf^0.1^animspeed 100 - infinitely loops your animation speed to 100" },
		},
		{
			{ "title", "Execute Multiple Commands at Once" },
			{ "bold", 'You can execute multiple commands at once using "\\"' },
			{ "bold", "Examples:" },
			{ "text", ";drophats\\respawn - drops your hats and respawns you\n;enable inventory\\enable playerlist\\refresh - enables those coregui items and refreshes you" },
		},
		{
			{ "title", "Browse Command History" },
			{ "text", "While focused on the command bar, you can use the up and down arrow keys to browse recently used commands" },
		},
		{
			{ "title", "Autocomplete in the Command Bar" },
			{ "text", "While focused on the command bar, you can use the tab key to insert the top suggested command into the command bar." },
		},
		{
			{ "title", "Using Event Binds" },
			{ "text", "Use event binds to set up commands that get executed when certain events happen. You can edit the conditions for an event command to run (such as which player triggers it)." },
			{ "text", "Some events may send arguments; you can use them in your event command by using $ followed by the argument number ($1, $2, etc). You can find out the order and types of these arguments by looking at the settings of the event command." },
			{ "bold", "Example:" },
			{ "text", "Setting up 'goto $1' on the OnChatted event will teleport you to any player that chats." },
		},
		{
			{ "title", "Get Further Help" },
			{ "text", "You can join the Discord server to get support with IY,  and read up on more documentation such as the Plugin API." },
			{ "invite" },
		},
	}
}

-- the Plugins tab is paged: each section is one page, moved with BACK and NEXT at the bottom of the window
config.pages = {
	{ id = "types", title = "Types", sections = config.sections },
	{ id = "plugins", title = "Plugins", sections = require("./pluginReference"), paged = true },
}

config.navigation = {
	back = "Back",
	next = "Next",
}

-- shown in a code block while its text is read from the repo (plugins/...), or when that read fails
config.labels = {
	loading = "Loading...",
	failed = "Could not load this code. Open this page again to retry.",
}

return config
