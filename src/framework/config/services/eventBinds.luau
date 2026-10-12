-- src/framework/config/services/eventBinds.luau
-- The events that event binds can run a command on (see commands/systems/eventBinds), and the values each event passes.
--
-- A value is what $1, $2... stand for in the command, in the order of the conditions. A bind only runs when every
-- one of its conditions is met. Each condition has a kind:
--   "Player"  "any", "me", or a player filter the player arguments accept (friends, others, a name, a,b...)
--   "String"  "any", or text the value must contain (not case-sensitive)
--   "Number"  "any", or a number the value must be at most
-- `label` names the value in the editor, and `default` is the condition a new bind starts with.

local ANY = "any"

return {
	ANY = ANY,

	events = {
		{
			name = "OnExecute",
			description = "when IY loads",
			conditions = {},
		},
		{
			name = "OnJoin",
			description = "a player joins",
			conditions = {
				{ kind = "Player", label = "$1 player", default = ANY },
			},
		},
		{
			name = "OnLeave",
			description = "a player leaves",
			conditions = {
				{ kind = "Player", label = "$1 player", default = ANY },
			},
		},
		{
			name = "OnSpawn",
			description = "a character spawns",
			conditions = {
				{ kind = "Player", label = "$1 player", default = "me" },
			},
		},
		{
			name = "OnDied",
			description = "a character dies",
			conditions = {
				{ kind = "Player", label = "$1 player", default = "me" },
			},
		},
		{
			name = "OnDamage",
			description = "a character takes damage",
			conditions = {
				{ kind = "Player", label = "$1 player", default = "me" },
				{ kind = "Number", label = "$2 health at most", default = ANY },
			},
		},
		{
			name = "OnKilled",
			description = "a player kills another",
			conditions = {
				{ kind = "Player", label = "$1 victim", default = "me" },
				{ kind = "Player", label = "$2 killer", default = ANY },
			},
		},
		{
			name = "OnChatted",
			description = "a player chats",
			conditions = {
				{ kind = "Player", label = "$1 player", default = ANY },
				{ kind = "String", label = "$2 message contains", default = ANY },
			},
		},
	},
}
