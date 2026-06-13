local logger = require("../utils/logger")
-- local register = require("./register")

local function createCommands(commandsInfo)
	local cmdsInfo = {}
	local lookup = {}
	local array = {}
	
	local function newCommand(command)
		logger:expect(command.action, {"string"}, "command action")
		table.insert(cmdsInfo, command)
		
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
	
	for _, section in commandsInfo do
		logger:expect(section.name, {"string"}, "section name")
		logger:expect(section.commands, {"table"}, "section commands")
		
		table.insert(cmdsInfo, {
			isSection = true,
			sectionName = section.name
		})
		
		for _, command in section.commands do
			if #command == 0 then
				logger:assert(next(command), "the command cannot be empty")
				newCommand(command)
				continue
			end
			
			for key = 1, #command do
				newCommand(command[key])
			end
		end
	end
	
	return {
		array = array,
		lookup = lookup,
		original = cmdsInfo
	}
end

return createCommands({
	{
		name = "general",
		commands = require("./cmds/general/.init")
	},
	{
		name = "character",
		commands = require("./cmds/character/.init")
	},
	{
		name = "waypoints",
		commands = require("./cmds/waypoints/.init")
	},
	{
		name = "teleport",
		commands = require("./cmds/teleport/.init")
	},
	{
		name = "communication",
		commands = require("./cmds/communication/.init")
	},
	{
		name = "visual",
		commands = require("./cmds/visual/.init")
	},
	{
		name = "camera",
		commands = require("./cmds/camera/.init")
	},
	{
		name = "workspace",
		commands = require("./cmds/workspace/.init")
	},
	{
		name = "lighting",
		commands = require("./cmds/lighting/.init")
	},
	{
		name = "aliases",
		commands = require("./cmds/aliases/.init")
	},
	{
		name = "plugins",
		commands = require("./cmds/plugins/.init")
	}
})

--[[
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


	{ isSection = true, sectionName = "other players" },
	require("./cmds/playerinfo"),
	
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
	{ isSection = true, sectionName = "tools" },
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
	{ isSection = true, sectionName = "aliases" },
	require("./cmds/aliases"),
	{ isSection = true, sectionName = "plugins" },
	require("./cmds/plugins")
})]]