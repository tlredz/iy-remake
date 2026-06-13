local logger = require("../utils/logger")
local uiConfigs = require("./ui")

local function createCommands(commandsInfo)
	local lookup = {}
	local array = {}
	
	for _, command in commandsInfo do
		if command.isSection then continue end
		logger:expect(command.action, {"string"}, "command action")
		
		local aliases = {}
		local args = command.args or {}
		command.args = args
		
		for _, text in command.action:split("|") do
			if not command.name then
				command.name = text
			end
			
			lookup[text] = command
			
			table.insert(aliases, text)
			table.insert(array, text)
		end
		
		table.sort(aliases, function(aliasA, aliasB)
			return #aliasA < #aliasB
		end)
		
		if #args == 0 and next(args) then
			command.args = { args }
		end
		
		command.aliases = aliases
		command.action = nil
	end
	
	return {
		array = array,
		lookup = lookup,
		original = commandsInfo
	}
end

return createCommands({
	{
		action = "discord|support|help",
		description = "Invite to the Infinite Yield discord server."
	},
	{
		action = "guiscale",
		description = "Changes the size of the gui. [number] accepts decimals and whole numbers.",
		args = {
			kind = "number",
			clamp = {uiConfigs.minScale, uiConfigs.maxScale}
		}
	},
	--[[{
		action = "update|upgrade",
		description = "update the infinite yield version"
	},
	{
		action = "autoupdate|autoupgrade",
		description = "toggle on/off the infinite yield auto update",
		args = {
			kind = "boolean",
			optional = true
		}
	},]]
	{
		action = "console",
		description = "Opens the Roblox console"
	},
	{
		action = "oldconsole",
		description = "Loads an old-themed Roblox console"
	},
	{
		action = "explorer|dex",
		description = "Opens DEX by Moon"
	},
	{
		action = "cobalt|cspy",
		description = "Opens Cobalt to intercept incoming and outgoing network traffic"
	},
	{
		action = "remotespy|rspy",
		description = "Opens Simple Spy V3 to intercept remote calls from the client to the server"
	},
	{
		action = "audiologger|alogger",
		description = "Opens Edges audio logger"
	},
	{
		action = "serverinfo|info",
		description = "Gives you info about the server"
	},
	{
		action = "jobid",
		description = "Copies the games JobId to your clipboard"
	},
	{
		action = "notifyjobid",
		description = "Notifies you the games JobId"
	},
	{
		action = "rejoin|rj",
		description = "Makes you rejoin the game"
	},
	{
		action = "autorejoin|autorj",
		description = "Automatically rejoins the server if you get kicked/disconnected"
	},
	{
		action = "serverhop|shop",
		description = "Teleports you to a different server"
	},
	{
		action = "gameteleport|gametp",
		description = "Joins a game by ID",
		args = {
			kind = "string",
			name = "place id"
		}
	},
	{
		action = "gameteleport|gametp",
		description = "Joins a game by ID",
		args = {
			kind = "string",
			name = "place id"
		}
	},
	{
		action = "antiafk|antiidle",
		description = "Prevents the game from kicking you for being idle/afk"
	},
	{
		action = "datalimit",
		description = "Set outgoing KBPS limit",
		args = {
			kind = "number"
		}
	},
	{
		action = "replicationlag|backtrack",
		description = "Set IncomingReplicationLag",
		args = {
			kind = "number"
		}
	},
	{
		action = "creatorid|creator",
		description = "Notifies you the creators ID"
	},
	{
		action = "copycreatorid|copycreator",
		description = "Copies the creators ID to your clipboard"
	},
	{
		action = "setcreatorid|setcreator",
		description = "Sets your userid to the creators ID"
	},
	{
		action = "noprompts",
		description = "Prevents the game from showing you purchase/premium prompts"
	},
	{
		action = "showprompts",
		description = "Allows the game to show purchase/premium prompts again"
	},
	{
		action = "enable",
		description = "Toggles visibility of coregui items",
		args = {
			kind = "options",
			options = "inventory|playerlist|chat|reset|emotes|all",
			name = "gui name"
		}
	},
	{
		action = "disable",
		description = "Toggles visibility of coregui items",
		args = {
			kind = "options",
			options = "inventory|playerlist|chat|reset|emotes|all",
			name = "gui name"
		}
	},
	{
		action = "showguis",
		description = "Shows any invisible GUIs"
	},
	{
		action = "unshowguis",
		description = "Undoes showguis"
	},
	{
		action = "hideguis",
		description = "Hides any GUIs in PlayerGui"
	},
	{
		action = "unhideguis",
		description = "Undoes hideguis"
	},
	{
		action = "guidelete",
		description = "Enables backspace to delete GUI"
	},
	{
		action = "unguidelete|noguidelete",
		description = "Disables guidelete"
	},
	{
		action = "hideiy",
		description = "Hides the main IY GUI"
	},
	{
		action = "showiy|unhideiy",
		description = "Shows IY again"
	},
	{
		action = "keepiy",
		description = "Auto execute IY when you teleport through servers"
	},
	{
		action = "unkeepiy",
		description = "Disable keepiy"
	},
	{
		action = "togglekeepiy",
		description = "Toggles keepiy"
	},
	{
		action = "removeads|adblock",
		description = "Automatically removes ad billboards"
	},
	{
		action = "savegame|saveplace",
		description = "Uses saveinstance to save the game"
	},
	{
		action = "clearerror",
		description = "Clears the annoying box and blur when a game kicks you"
	},
	{
		action = "antigameplaypaused",
		description = "Clears the annoying box shown when a game is loading assets due to network lag"
	},
	{
		action = "unantigameplaypaused",
		description = "Disables antigameplaypaused"
	},
	{
		action = "clientantikick|antikick",
		description = "Prevents localscripts from kicking you (CLIENT)"
	},
	{
		action = "clientantiteleport|antiteleport",
		description = "Prevents localscripts from teleporting you (CLIENT)"
	},
	{
		action = "allowrejoin|allowrj",
		description = "Changes if antiteleport allows you to rejoin or not (CLIENT)",
		args = {
			kind = "boolean"
		}
	},
	{
		action = "cancelteleport|canceltp",
		description = "Cancels teleports in progress"
	},
	{
		action = "volume|vol",
		description = "Adjusts your game volume on a scale of 0 to 10",
		args = {
			kind = "number",
			clamp = {0, 10}
		}
	},
	{
		action = "antilag|boostfps|lowgraphics",
		description = "Lowers game quality to boost FPS"
	},
	{
		action = "record|rec",
		description = "Starts Roblox recorder"
	},
	{
		action = "screenshot|scrnshot",
		description = "Takes a screenshot"
	},
	{
		action = "togglefullscreen|togglefs",
		description = "Toggles fullscreen"
	},
	{
		action = "notify",
		description = "Sends you a notification with the provided text",
		args = {
			kind = "string",
			name = "message"
		}
	},
	{
		action = "lastcommand|lastcmd",
		description = "Executes the previous command used"
	},
	{
		action = "notifyping|ping",
		description = "Notify yourself your ping"
	},
	{
		action = "norender",
		description = "Disable 3d Rendering to decrease the amount of CPU the client uses"
	},
	{
		action = "render",
		description = "Enable 3d Rendering"
	},
	{
		action = "use2022materials|2022materials",
		description = "Enables 2022 material textures"
	},
	{
		action = "unuse2022materials|un2022materials",
		description = "Disables 2022 material textures"
	},
	{
		action = "alignmentkeys",
		description = "Enables the left and right alignment keys (comma and period)"
	},
	{
		action = "ctrllock",
		description = "Binds Shiftlock to LeftControl"
	},
	{
		action = "unctrllock",
		description = "Re-binds Shiftlock to LeftShift"
	},
	{
		action = "exit",
		description = "Kills roblox process"
	},
	{
		action = "removecmd|deletecmd",
		description = "Removes a command until the script is reloaded"
	},
	{
		action = "breakloops",
		description = "Stops any cmd loops (;100^1^cmd)"
	},
	{
		isSection = true
	},
	{
		action = "noclip",
		description = "Go through objects"
	},
	{
		action = "unnoclip|clip",
		description = "Disables noclip"
	},
	{
		action = "fly",
		description = "Makes you fly",
		args = {
			kind = "number",
			name = "fly speed",
			optional = true
		}
	},
	{
		action = "unfly",
		description = "Disables fly"
	},
	{
		action = "flyspeed",
		description = "Set fly speed (default is 20)",
		args = {
			kind = "number",
			name = "fly speed"
		}
	},
	{
		action = "vehiclefly|vfly",
		description = "Makes you fly in a vehicle",
		args = {
			kind = "number",
			name = "vehicle fly speed",
			optional = true
		}
	},
	{
		action = "unvehiclefly|unvfly",
		description = "Disables vehicle fly"
	},
	{
		action = "vehicleflyspeed|vflyspeed",
		description = "Set vehicle fly speed",
		args = {
			kind = "number",
			name = "vehicle fly speed"
		}
	},
	{
		action = "cframefly|cfly",
		description = "Makes you fly, bypassing some anti cheats (works on mobile)",
		args = {
			kind = "number",
			name = "speed",
			optional = true
		}
	},
	{
		action = "uncframefly|uncfly",
		description = "Disables cfly"
	},
	{
		action = "cframeflyspeed|cflyspeed",
		description = "Sets cfly speed",
		args = {
			kind = "number"
		}
	},
	{
		action = "qefly",
		description = "Enables or disables the Q and E hotkeys for fly",
		args = {
			kind = "boolean"
		}
	},
	{
		action = "vehiclenoclip|vnoclip",
		description = "Turns off vehicle collision"
	},
	{
		action = "vehicleclip|vclip|unvnoclip",
		description = "Enables vehicle collision"
	},
	{
		action = "float|platform",
		description = "Spawns a platform beneath you causing you to float"
	},
	{
		action = "unfloat|noplatform",
		description = "Removes the platform"
	},
	{
		action = "swim",
		description = "Allows you to swim in the air"
	},
	{
		action = "unswim|noswim",
		description = "Stops you from swimming everywhere"
	},
	{
		action = "toggleswim",
		description = "Toggles swimming"
	},
	{
		isSection = true
	},
	{
		action = "setwaypoint|swp",
		description = "Sets a waypoint at your position",
		args = {
			kind = "string"
		}
	},
	{
		action = "waypointpos|wpp",
		description = "Sets a waypoint with specified coordinates",
		args = {
			kind = "vector3",
		}
	},
	{
		action = "waypoints",
		description = "Shows a list of currently active waypoints"
	},
	{
		action = "showwaypoints|showwp",
		description = "Shows all currently set waypoints"
	},
	{
		action = "hidewaypoints|hidewp",
		description = "Hides shown waypoints"
	},
	{
		action = "waypoint|wp",
		description = "Teleports player to a waypoint",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "tweenwaypoint|twp",
		description = "Tweens player to a waypoint",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "walktowaypoint|wtwp",
		description = "Walks player to a waypoint",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "deletewaypoint|dwp",
		description = "Deletes a waypoint",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "clearwaypoints|cwp",
		description = "Clears all waypoints"
	},
	{
		action = "cleargamewaypoints|cgamewp",
		description = "Clears all waypoints for the game you are in"
	},
	{
		isSection = true
	},
	{
		action = "goto",
		description = "Go to a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "tweengoto|tgoto",
		description = "Tween to a player (bypasses some anti cheats)",
		args = {
			kind = "player"
		}
	},
	{
		action = "tweenspeed|tspeed",
		description = "Sets how fast all tween commands go (default is 1)",
		args = {
			kind = "number"
		}
	},
	{
		action = "vehiclegoto|vgoto",
		description = "Go to a player while in a vehicle",
		args = {
			kind = "player"
		}
	},
	{
		action = "loopgoto",
		description = "Loop teleport to a player",
		args = {
			{
				kind = "string",
				name = "player distance"
			},
			{
				kind = "number",
				name = "delay"
			}
		}
	},
	{
		action = "unloopgoto",
		description = "Stops teleporting you to a player"
	},
	{
		action = "pulsetp|ptp",
		description = "Teleports you to a player for a specified amount of time",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "time amount"
			}
		}
	},
	{
		action = "clientbring|cbring",
		description = "Bring a player (CLIENT)",
		args = {
			kind = "player"
		}
	},
	{
		action = "loopbring",
		description = "Loop brings a player to you (useful for killing) (CLIENT)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "distance",
				optional = true
			},
			{
				kind = "number",
				name = "bring delay",
				optional = true
			}
		}
	},
	{
		action = "unloopbring",
		description = "Undoes loopbring",
		args = {
			kind = "player"
		}
	},
	{
		action = "freeze|fr",
		description = "Freezes a player (CLIENT)",
		args = {
			kind = "player"
		}
	},
	{
		action = "freezeanims",
		description = "Freezes your animations / pauses your animations - Does not work on default animations"
	},
	{
		action = "unfreezeanims",
		description = "Unfreezes your animations / plays your animations"
	},
	{
		action = "thaw|unfr",
		description = "Unfreezes a player (CLIENT)",
		args = {
			kind = "player"
		}
	},
	{
		action = "anchor",
		description = "Anchors your characters RootPart"
	},
	{
		action = "unanchor",
		description = "Unanchors your characters RootPart"
	},
	{
		action = "tpposition|tppos",
		description = "Teleports you to certain coordinates",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "tweentpposition|ttppos",
		description = "Tween to coordinates (bypasses some anti cheats)",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "offset",
		description = "Offsets you by certain coordinates",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "tweenoffset|toffset",
		description = "Tween offset (bypasses some anti cheats)",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "thru",
		description = "Teleports you [num] studs ahead of where your character is facing",
		args = {
			kind = "number"
		}
	},
	{
		action = "notifyposition|notifypos",
		description = "Notifies you the coordinates of a character",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "copyposition|copypos",
		description = "Copies the coordinates of a character to your clipboard",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "walktoposition|walktopos",
		description = "Makes you walk to a coordinate",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "spawnpoint|spawn",
		description = "Sets a position where you will spawn",
		args = {
			kind = "number",
			name = "delay",
			optional = true
		}
	},
	{
		action = "nospawnpoint|nospawn",
		description = "Removes your custom spawn point"
	},
	{
		action = "flashback|diedtp",
		description = "Teleports you to where you last died"
	},
	{
		action = "walltp",
		description = "Teleports you above/over any wall you run into"
	},
	{
		action = "nowalltp|unwalltp",
		description = "Disables walltp"
	},
	{
		action = "teleporttool|tptool",
		description = "Gives you a teleport tool"
	},
	{
		isSection = true
	},
	{
		action = "logs",
		description = "Opens the logs GUI"
	},
	{
		action = "chatlogs|clogs",
		description = "Log what people say or whisper"
	},
	{
		action = "joinlogs|jlogs",
		description = "Log when people join"
	},
	{
		action = "chatlogswebhook|logswebhook",
		description = "Set a discord webhook for chatlogs to go to (provide no url to disable this)",
		args = {
			kind = "string",
			name = "url",
			optional = true
		}
	},
	{
		action = "chat|say",
		description = "Makes you chat a string (possible mute bypass)",
		args = {
			kind = "string",
			name = "your message"
		}
	},
	{
		action = "spam",
		description = "Makes you spam the chat",
		args = {
			kind = "string",
			name = "your message"
		}
	},
	{
		action = "unspam",
		description = "Turns off spam"
	},
	{
		action = "whisper|pm",
		description = "Makes you whisper a string to someone (possible mute bypass)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "string",
				name = "your message"
			}
		}
	},
	{
		action = "pmspam",
		description = "Makes you spam a players whispers",
		args = {
			{
				kind = "player",
			},
			{
				kind = "string",
				name = "your message"
			}
		}
	},
	{
		action = "unpmspam",
		description = "Turns off pm spam",
		args = {
			kind = "player"
		}
	},
	{
		action = "spamspeed|spamdelay",
		description = "How quickly you spam (default is 1)",
		args = {
			kind = "number"
		}
	},
	{
		action = "bubblechat",
		description = "Enables bubble chat for your client (CLIENT)"
	},
	{
		action = "unbubblechat|nobubblechat",
		description = "Disables the bubblechat command"
	},
	{
		action = "chatwindow",
		description = "Enables the chat window for your client"
	},
	{
		action = "unchatwindow|nochatwindow",
		description = "Disables the chat window for your client"
	},
	{
		action = "darkchat",
		description = "Makes the chat window dark for your client"
	},
	{
		action = "listento",
		description = "Listens to the area around a player. Can also eavesdrop with vc",
		args = {
			kind = "player"
		}
	},
	{
		action = "unlistento",
		description = "Disables listento"
	},
	{
		action = "muteallvoices|muteallvcs",
		description = "Mutes voice chat for all players"
	},
	{
		action = "unmuteallvoices|unmuteallvcs",
		description = "Unmutes voice chat for all players"
	},
	{
		action = "mutevc",
		description = "Mutes the voice chat of a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "unmutevc",
		description = "Unmutes the voice chat of a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "phonebook|call",
		description = "Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled"
	},
	{
		isSection = true
	},
	{
		action = "esp",
		description = "View all players and their status"
	},
	{
		action = "espteam",
		description = "ESP but teammates are green and bad guys are red"
	},
	{
		action = "noesp|unesp|unespteam",
		description = "Removes ESP"
	},
	{
		action = "esptransparency",
		description = "Changes the transparency of ESP related commands",
		args = {
			kind = "number"
		}
	},
	{
		action = "partesp",
		description = "Highlights a part",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "unpartesp|nopartesp",
		description = "removes partesp",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "chams",
		description = "ESP but without text in the way"
	},
	{
		action = "nochams|unchams",
		description = "Removes chams"
	},
	{
		action = "locate",
		description = "View a single player and their status",
		args = {
			kind = "player"
		}
	},
	{
		action = "unlocate|nolocate",
		description = "Removes locate",
		args = {
			kind = "player"
		}
	},
	{
		action = "xray",
		description = "Makes all parts in workspace transparent"
	},
	{
		action = "unxray|noxray",
		description = "Restores transparency to all parts in workspace"
	},
	{
		action = "loopxray",
		description = "Makes all parts in workspace transparent but looped"
	},
	{
		action = "unloopxray",
		description = "Unloops xray"
	},
	{
		action = "togglexray",
		description = "Toggles xray"
	},
	{
		isSection = true
	},
	{
		action = "spectate|view",
		description = "View a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "viewpart|viewp",
		description = "View a part",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "unspectate|unview",
		description = "Stops viewing player"
	},
	{
		action = "freecam|fc",
		description = "Allows you to freely move camera around the game"
	},
	{
		action = "freecampos|fcpos",
		description = "Moves / opens freecam in a certain position",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "freecamwaypoint|fcwp",
		description = "Moves / opens freecam to a waypoint",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "freecamgoto|fcgoto|fctp",
		description = "Moves / opens freecam to a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "unfreecam|unfc",
		description = "Disables freecam"
	},
	{
		action = "freecamspeed|fcspeed",
		description = "Adjusts freecam speed (default is 1)",
		args = {
			kind = "number"
		}
	},
	{
		action = "notifyfreecamposition|notifyfcpos",
		description = "Noitifies you your freecam coordinates"
	},
	{
		action = "copyfreecamposition|copyfcpos",
		description = "Copies your freecam coordinates to your clipboard"
	},
	{
		action = "gotocamera|gotocam",
		description = "Teleports you to the location of your camera"
	},
	{
		action = "tweengotocam|tgotocam",
		description = "Tweens you to the location of your camera"
	},
	{
		action = "firstp",
		description = "Forces camera to go into first person"
	},
	{
		action = "thirdp",
		description = "Allows camera to go into third person"
	},
	{
		action = "noclipcam|nccam",
		description = "Allows camera to go through objects like walls"
	},
	{
		action = "maxzoom",
		description = "Maximum camera zoom",
		args = {
			kind = "number"
		}
	},
	{
		action = "minzoom",
		description = "Minimum camera zoom",
		args = {
			kind = "number"
		}
	},
	{
		action = "camdistance",
		description = "Changes camera distance from your player",
		args = {
			kind = "number"
		}
	},
	{
		action = "fov",
		description = "Adjusts field of view (default is 70)",
		args = {
			kind = "number"
		}
	},
	{
		action = "fixcam|restorecam",
		description = "Fixes camera"
	},
	{
		action = "enableshiftlock|enablesl",
		description = "Enables the shift lock option"
	},
	{
		action = "lookat",
		description = "Moves your camera view to a player",
		args = {
			kind = "player"
		}
	},
	{
		isSection = true
	},
	{
		action = "btools",
		description = "Gives you building tools (DOES NOT REPLICATE) (CLIENT)"
	},
	{
		action = "f3x",
		description = "Gives you F3X building tools (DOES NOT REPLICATE) (CLIENT)"
	},
	{
		action = "partname|partpath",
		description = "Allows you to click a part to see its path & name"
	},
	{
		action = "delete",
		description = "Removes any part with a certain name from the workspace (DOES NOT REPLICATE) (CLIENT)",
		args = {
			kind = "string",
			name = "instance name"
		}
	},
	{
		action = "deleteclass|dc",
		description = "Removes any part with a certain classname from the workspace (DOES NOT REPLICATE) (CLIENT)",
		args = {
			kind = "className"
		}
	},
	{
		action = "lockworkspace|lockws",
		description = "Locks the whole workspace"
	},
	{
		action = "unlockworkspace|unlockws",
		description = "Unlocks the whole workspace"
	},
	{
		action = "invisibleparts|invisparts",
		description = "Shows invisible parts (CLIENT)"
	},
	{
		action = "uninvisibleparts|uninvisparts",
		description = "Makes parts affected by invisparts return to normal (CLIENT)"
	},
	{
		action = "deleteinvisparts|dip",
		description = "Deletes invisible parts (CLIENT)"
	},
	{
		action = "gotopart",
		description = "Moves your character to a part or multiple parts",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "tweengotopart|tgotopart",
		description = "Tweens your character to a part or multiple parts",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "gotopartclass|gpc",
		description = "Moves your character to a part or multiple parts based on classname",
		args = {
			kind = "className"
		}
	},
	{
		action = "tweengotopartclass|tgpc",
		description = "Tweens your character to a part or multiple parts based on classname",
		args = {
			kind = "className"
		}
	},
	{
		action = "gotomodel",
		description = "Moves your character to a model or multiple models",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "tweengotomodel|tgotomodel",
		description = "Tweens your character to a model or multiple models",
		args = {
			kind = "string",
			name = "part name"
		}
	},
	{
		action = "gotopartdelay|gotomodeldelay",
		description = "Adjusts how quickly you teleport to each part (default is 0.1)",
		args = {
			kind = "number"
		}
	},
	{
		action = "bringpart",
		description = "Moves a part or multiple parts to your character (CLIENT)",
		args = {
			kind = "string"
		}
	},
	{
		action = "bringpartclass|bpc",
		description = "Moves a part or multiple parts to your character based on classname (CLIENT)",
		args = {
			kind = "className"
		}
	},
	{
		action = "noclickdetectorlimits|nocdlimits",
		description = "Sets all click detectors MaxActivationDistance to math.huge"
	},
	{
		action = "fireclickdetectors|firecd",
		description = "Uses all click detectors in a game or uses the optional name",
		args = {
			kind = "object",
			optional = true
		}
	},
	{
		action = "firetouchinterests|touchinterests",
		description = "Uses all touchinterests in a game or uses the optional name",
		args = {
			kind = "object",
			optional = true
		}
	},
	{
		action = "noproximitypromptlimits|nopplimits",
		description = "Sets all proximity prompts MaxActivationDistance to math.huge"
	},
	{
		action = "fireproximityprompts|firepp",
		description = "Uses all proximity prompts in a game or uses the optional name",
		args = {
			kind = "object",
			optional = true
		}
	},
	{
		action = "instantproximityprompts|instantpp",
		description = "Disable the cooldown for proximity prompts"
	},
	{
		action = "uninstantproximityprompts|uninstantpp",
		description = "Undo the cooldown removal"
	},
	{
		action = "tpunanchored|tpua",
		description = "Teleports unanchored parts to a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "animsunanchored|freezeua",
		description = "Freezes unanchored parts"
	},
	{
		action = "thawunanchored|thawua|unfreezeua",
		description = "Thaws unanchored parts"
	},
	{
		action = "removeterrain|rterrain|noterrain",
		description = "Removes all terrain"
	},
	{
		action = "clearnilinstances|nonilinstances|cni",
		description = "Removes nil instances"
	},
	{
		action = "destroyheight|dh",
		description = "Sets FallenPartsDestroyHeight",
		args = {
			kind = "number"
		}
	},
	{
		action = "fakeout",
		description = "Tp to the void and then back (useful to kill people attached to you)"
	},
	{
		action = "antivoid",
		description = "Prevents you from falling into the void by launching you upwards"
	},
	{
		action = "unantivoid|noantivoid",
		description = "Disables antivoid"
	},
	{
		isSection = true
	},
	{
		action = "fullbright|fb",
		description = "Makes the map brighter / more visible (CLIENT)"
	},
	{
		action = "loopfullbright|loopfb",
		description = "Makes the map brighter / more visible but looped (CLIENT)"
	},
	{
		action = "unloopfullbright|unloopfb",
		description = "Unloops fullbright"
	},
	{
		action = "ambient",
		description = "Changes ambient (CLIENT)",
		args = {
			kind = "color3"
		}
	},
	{
		action = "day",
		description = "Changes the time to day for the client (CLIENT)"
	},
	{
		action = "night",
		description = "Changes the time to night for the client (CLIENT)"
	},
	{
		action = "nofog",
		description = "Removes fog (CLIENT)"
	},
	{
		action = "brightness",
		description = "Changes the brightness lighting property (CLIENT)",
		args = {
			kind = "number"
		}
	},
	{
		action = "globalshadows|gshadows",
		description = "Enables global shadows (CLIENT)"
	},
	{
		action = "noglobalshadows|nogshadows",
		description = "Disables global shadows (CLIENT)"
	},
	{
		action = "restorelighting|rlighting",
		description = "Restores Lighting properties"
	},
	{
		action = "light",
		description = "Gives your player dynamic light (CLIENT)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "radius",
				optional = true
			}
		}
	},
	{
		action = "nolight|unlight",
		description = "Removes dynamic light from your player"
	},
	{
		isSection = true
	},
	{
		action = "inspect|examine",
		description = "Opens InspectMenu for a certain player",
		args = {
			kind = "player"
		}
	},
	{
		action = "age",
		description = "Tells you the age of a player",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "chatage",
		description = "Chats the age of a player",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "joindate|jd",
		description = "Tells you the date the player joined Roblox",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "chatjoindate|cjd",
		description = "Chats the date the player joined Roblox",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "copyname|copyuser",
		description = "Copies a players full username to your clipboard",
		args = {
			kind = "player"
		}
	},
	{
		action = "userid|id",
		description = "Notifies a players user ID",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "copyplaceid|placeid",
		description = "Copies the current place id to your clipboard"
	},
	{
		action = "copygameid|gameid",
		description = "Copies the current game id to your clipboard"
	},
	{
		action = "copyuserid|copyid",
		description = "Copies a players user ID to your clipboard",
		args = {
			kind = "player"
		}
	},
	{
		action = "appearanceid|aid",
		description = "Notifies a players appearance ID",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "copyappearanceid|caid",
		description = "Copies a players appearance ID to your clipboard",
		args = {
			kind = "player"
		}
	},
	{
		action = "bang",
		description = "owo",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "speed",
				optional = true
			}
		}
	},
	{
		action = "unbang",
		description = "uwu"
	},
	{
		action = "jerk",
		description = "Makes you jork it"
	},
	{
		action = "scare|spook",
		description = "Teleports in front of a player for half a second",
		args = {
			kind = "player"
		}
	},
	{
		action = "carpet",
		description = "Be someones carpet",
		args = {
			kind = "player"
		}
	},
	{
		action = "uncarpet",
		description = "Undoes carpet"
	},
	{
		action = "friend",
		description = "Sends a friend request to certain players",
		args = {
			kind = "player"
		}
	},
	{
		action = "unfriend",
		description = "Unfriends certain players",
		args = {
			kind = "player"
		}
	},
	{
		action = "headsit",
		description = "Sit on a players head",
		args = {
			kind = "player"
		}
	},
	{
		action = "walkto|follow",
		description = "Follow a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "pathfindwalkto|pathfindfollow",
		description = "Follow a player using pathfinding",
		args = {
			kind = "player"
		}
	},
	{
		action = "pathfindwalktowaypoint|pathfindwalktowp|pftowp",
		description = "Walk to a waypoint using pathfinding",
		args = {
			kind = "waypoint"
		}
	},
	{
		action = "unwalkto|unfollow",
		description = "Stops following a player"
	},
	{
		action = "orbit",
		description = "Makes your character orbit around a player with an optional speed and an optional distance",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "speed"
			},
			{
				kind = "number",
				name = "distance"
			}
		}
	},
	{
		action = "unorbit",
		description = "Disables orbit"
	},
	{
		action = "stareat|stare",
		description = "Stare / look at a player",
		args = {
			kind = "player"
		}
	},
	{
		action = "unstareat|unstare",
		description = "Disables stareat",
		args = {
			kind = "player"
		}
	},
	{
		action = "rolewatch",
		description = "Notify if someone from a watched group joins the server",
		args = {
			{
				kind = "number",
				name = "group id"
			},
			{
				kind = "string",
				name = "role name"
			}
		}
	},
	{
		action = "rolewatchstop|unrolewatch",
		description = "Disable Rolewatch"
	},
	{
		action = "rolewatchleave",
		description = "Toggle if you should leave the game if someone from a watched group joins the server"
	},
	{
		action = "staffwatch",
		description = "Notify if a staff member of the game joins the server"
	},
	{
		action = "unstaffwatch",
		description = "Disable Staffwatch"
	},
	{
		action = "findfriendgroups",
		description = "Notifies you if any players are friends with each other"
	},
	{
		action = "handlekill|hkill",
		description = "Kills a player using tool damage (YOU NEED A TOOL) (TOOL)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "radius"
			}
		}
	},
	{
		action = "fling|forcefling",
		description = "Flings anyone you touch"
	},
	{
		action = "unfling",
		description = "Disables the fling command"
	},
	{
		action = "flyfling",
		description = "Basically the invisfling command but not invisible",
		args = {
			kind = "number",
			name = "speed",
			optional = true
		}
	},
	{
		action = "unflyfling",
		description = "Disables the flyfling command"
	},
	{
		action = "walkfling",
		description = "Basically fling but no spinning"
	},
	{
		action = "unwalkfling|nowalkfling",
		description = "Disables walkfling"
	},
	{
		action = "invisfling",
		description = "Enables invisible fling (the invis part is patched, try using the god command before using this)"
	},
	{
		action = "antifling",
		description = "Disables player collisions to prevent you from being flung"
	},
	{
		action = "unantifling",
		description = "Disables antifling"
	},
	{
		action = "loopoof",
		description = "Loops everyones character sounds (everyone can hear)"
	},
	{
		action = "unloopoof",
		description = "Stops the oof chaos"
	},
	{
		action = "muteboombox",
		description = "Mutes someones boombox",
		args = {
			kind = "player"
		}
	},
	{
		action = "unmuteboombox",
		description = "Unmutes someones boombox",
		args = {
			kind = "player"
		}
	},
	{
		action = "hitbox",
		description = "Expands the hitbox for players HumanoidRootPart (default is 1)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "size"
			},
			{
				kind = "number",
				name = "transparency",
				clamp = {0, 1}
			}
		}
	},
	{
		action = "headsize",
		description = "Expands the head size for players Head (default is 1)",
		args = {
			{
				kind = "player"
			},
			{
				kind = "number",
				name = "head size"
			}
		}
	},
	{
		isSection = true
	},
	{
		action = "reset",
		description = "Resets your character normally"
	},
	{
		action = "respawn",
		description = "Respawns you"
	},
	{
		action = "refresh|re",
		description = "Respawns and brings you back to the same position"
	},
	{
		action = "god",
		description = "Makes your character difficult to kill in most games"
	},
	{
		action = "invisible|invis",
		description = "Makes you invisible to other players"
	},
	{
		action = "visible|vis",
		description = "Makes you visible to other players"
	},
	{
		action = "toolinvisible|toolinvis|tinvis",
		description = "Makes you invisible to other players and able to use tools"
	},
	{
		action = "walkspeed|speed|ws",
		description = "Change your walkspeed (default is 16)",
		args = {
			kind = "number",
			name = "walk speed"
		}
	},
	{
		action = "spoofspeed|spoofws",
		description = "Spoofs your WalkSpeed on the Client",
		args = {
			kind = "number"
		}
	},
	{
		action = "loopspeed|loopws",
		description = "Loops your walkspeed",
		args = {
			kind = "number"
		}
	},
	{
		action = "unloopspeed|unloopws",
		description = "Turns off loopspeed"
	},
	{
		action = "hipheight|hheight",
		description = "Adjusts hip height",
		args = {
			kind = "number"
		}
	},
	{
		action = "jumppower|jpower|jp",
		description = "Change a players jump height (default is 50)",
		args = {
			kind = "number"
		}
	},
	{
		action = "spoofjumppower|spoofjp",
		description = "Spoofs your JumpPower on the Client",
		args = {
			kind = "number"
		}
	},
	{
		action = "loopjumppower|loopjp",
		description = "Loops your jump height",
		args = {
			kind = "number"
		}
	},
	{
		action = "unloopjumppower|unloopjp",
		description = "Turns off loopjumppower"
	},
	{
		action = "maxslopeangle|msa",
		description = "Adjusts MaxSlopeAngle",
		args = {
			kind = "number"
		}
	},
	{
		action = "gravity|grav",
		description = "Change your gravity (CLIENT)",
		args = {
			kind = "number"
		}
	},
	{
		action = "sit",
		description = "Makes your character sit"
	},
	{
		action = "lay|laydown",
		description = "Makes your character lay down"
	},
	{
		action = "sitwalk",
		description = "Makes your character sit while still being able to walk"
	},
	{
		action = "nosit",
		description = "Prevents your character from sitting"
	},
	{
		action = "unnosit",
		description = "Disables nosit"
	},
	{
		action = "jump",
		description = "Makes your character jump"
	},
	{
		action = "infinitejump|infjump",
		description = "Allows you to jump before hitting the ground"
	},
	{
		action = "uninfinitejump|uninfjump",
		description = "Disables infjump"
	},
	{
		action = "flyjump",
		description = "Allows you to hold space to fly up"
	},
	{
		action = "unflyjump",
		description = "Disables flyjump"
	},
	{
		action = "autojump|ajump",
		description = "Automatically jumps when you run into an object"
	},
	{
		action = "unautojump|unajump",
		description = "Disables autojump"
	},
	{
		action = "edgejump|ejump",
		description = "Automatically jumps when you get to the edge of an object"
	},
	{
		action = "unedgejump|unejump",
		description = "Disables edgejump"
	},
	{
		action = "platformstand|stun",
		description = "Enables PlatformStand"
	},
	{
		action = "unplatformstand|unstun",
		description = "Disables PlatformStand"
	},
	{
		action = "norotate|noautorotate",
		description = "Disables AutoRotate"
	},
	{
		action = "unnorotate|autorotate",
		description = "Enables AutoRotate"
	},
	{
		action = "enablestate",
		description = "Enables a humanoid state type",
		args = {
			kind = "string",
			name = "StateType"
		}
	},
	{
		action = "disablestate",
		description = "Disables a humanoid state type",
		args = {
			kind = "string",
			name = "StateType"
		}
	},
	{
		action = "team",
		description = "Changes your team. Sometimes fools localscripts. (CLIENT)",
		args = {
			kind = "team"
		}
	},
	{
		action = "nobillboardgui|nobgui|noname",
		description = "Removes billboard and surface GUIs from your players (i.e. name GUIs at cafes)"
	},
	{
		action = "loopnobgui|loopnoname",
		description = "Loop removes billboard and surface GUIs from your players (i.e. name GUIs at cafes)"
	},
	{
		action = "unloopnobgui|unloopnoname",
		description = "Disables loopnobgui"
	},
	{
		action = "noarms",
		description = "Removes your arms"
	},
	{
		action = "nolegs",
		description = "Removes your legs"
	},
	{
		action = "nolimbs",
		description = "Removes your limbs"
	},
	{
		action = "naked",
		description = "Removes your clothing (CLIENT)"
	},
	{
		action = "noface|removeface",
		description = "Removes your face"
	},
	{
		action = "blockhead",
		description = "Turns your head into a block"
	},
	{
		action = "blockhats",
		description = "Turns your hats into blocks"
	},
	{
		action = "blocktool",
		description = "Turns the currently selected tool into a block"
	},
	{
		action = "creeper",
		description = "Makes you look like a creeper"
	},
	{
		action = "drophats",
		description = "Drops your hats"
	},
	{
		action = "nohats|deletehats|rhats",
		description = "Deletes your hats"
	},
	{
		action = "hatspin|spinhats",
		description = "Spins your characters accessories"
	},
	{
		action = "unhatspin|unspinhats",
		description = "Undoes spinhats"
	},
	{
		action = "clearhats|cleanhats",
		description = "Clears hats in the workspace"
	},
	{
		action = "chardelete|cd",
		description = "Removes any part with a certain name from your character",
		args = {
			kind = "string",
			name = "instance name"
		}
	},
	{
		action = "chardeleteclass|cdc",
		description = "Removes any part with a certain classname from your character",
		args = {
			kind = "string",
			name = "class name"
		}
	},
	{
		action = "deletevelocity|dv|removeforces",
		description = "Removes any velocity / force instances in your character"
	},
	{
		action = "weaken",
		description = "Makes your character less dense",
		args = {
			kind = "number"
		}
	},
	{
		action = "unweaken",
		description = "Sets your characters CustomPhysicalProperties to default"
	},
	{
		action = "strengthen",
		description = "Makes your character more dense (CustomPhysicalProperties)",
		args = {
			kind = "number"
		}
	},
	{
		action = "unstrengthen",
		description = "Sets your characters CustomPhysicalProperties to default"
	},
	{
		action = "breakvelocity",
		description = "Sets your characters velocity to 0"
	},
	{
		action = "spin",
		description = "Spins your character",
		args = {
			kind = "number",
			name = "speed",
			optional = true
		}
	},
	{
		action = "unspin",
		description = "Disables spin"
	},
	{
		action = "split",
		description = "Splits your character in half"
	},
	{
		action = "nilchar",
		description = "Sets your characters parent to nil"
	},
	{
		action = "unnilchar|nonilchar",
		description = "Sets your characters parent to workspace"
	},
	{
		action = "noroot|removeroot|rroot",
		description = "Removes your characters HumanoidRootPart"
	},
	{
		action = "replaceroot",
		description = "Replaces your characters HumanoidRootPart"
	},
	{
		action = "clearcharappearance|clearchar|clrchar",
		description = "Removes all accessory, shirt, pants, charactermesh, and bodycolors"
	},
	{
		action = "tpwalk|teleportwalk",
		description = "Teleports you to your move direction",
		args = {
			{
				kind = "number",
				name = "distance"
			},
			{
				kind = "boolean",
				name = "stack distance",
				optional = true
			}
		}
	},
	{
		action = "untpwalk|unteleportwalk",
		description = "Undoes tpwalk / teleportwalk"
	},
	{
		action = "trip",
		description = "Makes your character fall over"
	},
	{
		action = "wallwalk|walkonwalls",
		description = "Walk on walls"
	},
	{
		action = "promptr6",
		description = "Prompts the game to switch your rig type to R6"
	},
	{
		action = "promptr15",
		description = "Prompts the game to switch your rig type to R15"
	},
	{
		isSection = true
	},
	{
		action = "animation|anim",
		description = "Makes your character perform an animation (must be an animation on the marketplace or by roblox/stickmasterluke to replicate)",
		args = {
			{
				kind = "string",
				name = "animation id"
			},
			{
				kind = "number",
				name = "animation speed",
				optional = true
			}
		}
	},
	{
		action = "emote|em",
		description = "Makes your character perform an emote (must be on the marketplace or by roblox/stickmasterluke to replicate)",
		args = {
			{
				kind = "string",
				name = "animation id"
			},
			{
				kind = "number",
				name = "animation speed",
				optional = true
			}
		}
	},
	{
		action = "dance",
		description = "Makes you  d a n c e"
	},
	{
		action = "undance",
		description = "Stops dance animations"
	},
	{
		action = "spasm",
		description = "Makes you  c r a z y"
	},
	{
		action = "unspasm",
		description = "Stops spasm"
	},
	{
		action = "headthrow",
		description = "Simply makes you throw your head"
	},
	{
		action = "noanim",
		description = "Disables your animations"
	},
	{
		action = "reanim",
		description = "Restores your animations"
	},
	{
		action = "animspeed",
		description = "Changes the speed of your current animation",
		args = {
			kind = "number"
		}
	},
	{
		action = "copyanimation|copyanim|copyemote",
		description = "Copies someone elses animation",
		args = {
			kind = "player"
		}
	},
	{
		action = "copyanimationid|copyanimid|copyemoteid",
		description = "Copies your animation id or someone elses to your clipboard",
		args = {
			kind = "player",
			optional = true
		}
	},
	{
		action = "loopanimation|loopanim",
		description = "Loops your current animation"
	},
	{
		action = "stopanimations|stopanims",
		description = "Stops running animations"
	},
	{
		action = "refreshanimations|refreshanims",
		description = "Refreshes animations"
	},
	{
		action = "allowcustomanim|allowcustomanimations",
		description = "Lets you use custom animation packs instead"
	},
	{
		action = "unallowcustomanim|unallowcustomanimations",
		description = "Doesn't let you use custom animation packs instead"
	},
	{
		isSection = true
	},
	{
		action = "autoclick",
		description = "Automatically clicks your mouse with a set delay",
		args = {
			{
				kind = "number",
				name = "click delay"
			},
			{
				kind = "number",
				name = "release delay"
			}
		}
	},
	{
		action = "unautoclick|noautoclick",
		description = "Turns off autoclick"
	},
	{
		action = "autokeypress|keypress",
		description = "Automatically presses a key with a set delay",
		args = {
			{
				kind = "keycode"
			},
			{
				kind = "number",
				name = "click delay"
			},
			{
				kind = "number",
				name = "release delay"
			}
		}
	},
	{
		action = "unautokeypress|noautokeypress|unkeypress|nokeypress",
		description = "Stops autokeypress"
	},
	{
		action = "hovername",
		description = "Shows a players username when your mouse is hovered over them"
	},
	{
		action = "unhovername|nohovername",
		description = "Turns off hovername"
	},
	{
		action = "mousesensitivity|ms",
		description = "Sets your mouse sensitivity (affects first person and right click drag) (default is 1)",
		args = {
			kind = "number",
			clamp = {0, 10}
		}
	},
	{
		action = "clickdelete",
		description = "Go to Settings > Keybinds > Add for click delete"
	},
	{
		action = "clickteleport",
		description = "Go to Settings > Keybinds > Add for click teleport"
	},
	{
		action = "mouseteleport|mousetp",
		description = "Teleports your character to your mouse. This is recommended as a keybind"
	},
	{
		isSection = true
	},
	{
		action = "tools",
		description = "Copies tools from ReplicatedStorage and Lighting"
	},
	{
		action = "notools|removetools|deletetools",
		description = "Removes tools from character and backpack"
	},
	{
		action = "deleteselectedtool|dst",
		description = "Removes any currently selected tools"
	},
	{
		action = "grabtools",
		description = "Automatically get tools that are dropped"
	},
	{
		action = "ungrabtools|nograbtools",
		description = "Disables grabtools"
	},
	{
		action = "copytools",
		description = "Copies a players tools (CLIENT)",
		args = {
			kind = "player"
		}
	},
	{
		action = "dupetools|clonetools",
		description = "Duplicates your inventory tools a set amount of times",
		args = {
			kind = "number"
		}
	},
	{
		action = "droptools",
		description = "Drops your tools"
	},
	{
		action = "droppabletools",
		description = "Makes your tools droppable"
	},
	{
		action = "equiptools",
		description = "Equips every tool in your inventory at once"
	},
	{
		action = "unequiptools",
		description = "Unequips every tool you are currently holding at once"
	},
	{
		action = "removespecifictool",
		description = "Automatically remove a specific tool from your inventory",
		args = {
			kind = "string",
			name = "tool name"
		}
	},
	{
		action = "unremovespecifictool",
		description = "Stops removing a specific tool from your inventory",
		args = {
			kind = "string",
			name = "tool name"
		}
	},
	{
		action = "clearremovespecifictool",
		description = "Stop removing all specific tools from your inventory"
	},
	{
		action = "reach",
		description = "Increases the hitbox of your held tool",
		args = {
			kind = "number"
		}
	},
	{
		action = "boxreach",
		description = "Increases the hitbox of your held tool in a box shape",
		args = {
			kind = "number"
		}
	},
	{
		action = "unreach|noreach",
		description = "Turns off reach"
	},
	{
		action = "grippos",
		description = "Changes your current tools grip position",
		args = {
			kind = "vector3"
		}
	},
	{
		action = "usetools",
		description = "Activates all tools in your backpack at the same time",
		args = {
			{
				kind = "number",
				name = "tools amount",
				optional = true
			},
			{
				kind = "number",
				name = "equip delay",
				optional = true
			}
		}
	},
	{
		isSection = true,
		sectionName = "aliases"
	},
	{
		action = "addalias",
		description = "Adds an alias to a command",
		args = {
			{
				kind = "command"
			},
			{
				kind = "string",
				name = "alias"
			}
		}
	},
	{
		action = "removealias",
		description = "Removes a custom alias",
		args = {
			kind = "alias"
		}
	},
	{
		action = "clraliases",
		description = "Removes all custom aliases"
	},
	{
		isSection = true,
		sectionName = "plugins"
	},
	{
		action = "addplugin|plugin",
		description = "Add a plugin via command",
		args = {
			kind = "string",
			name = "plugin name"
		}
	},
	{
		action = "removeplugin|deleteplugin",
		description = "Remove a plugin via command",
		args = {
			kind = "plugin"
		}
	},
	{
		action = "reloadplugin",
		description = "Reloads a plugin",
		args = {
			kind = "plugin"
		}
	},
	{
		action = "addallplugins|loadallplugins",
		description = "Adds all available plugins from the workspace folder"
	}
})