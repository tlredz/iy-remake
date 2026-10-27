--!strict
-- The types of the plugin API: what a plugin file receives and returns.
-- The Reference window (Plugins > Plugin Reference) shows this file, so it can be copied into a Luau type checker.

-- Arguments: what a command reads from the command bar
export type argKinds =
	| "string"
	| "text"
	| "object"
	| "number"
	| "boolean"
	| "player"
	| "vector3"
	| "color3"
	| "className"
	| "team"
	| "keycode"
	| "waypoint"
	| "command"
	| "alias"
	| "plugin"

export type arg = {
	kind: argKinds,
	name: string?,
	optional: boolean?,
	options: ({ string } | string)?,
	min: number?,
	max: number?,
	floor: boolean?,
	clamp: { number }?,
	variadic: boolean?,
}

export type args = arg | { arg }

export type argValue = string | number | boolean | Vector3 | Color3 | EnumItem

export type parsedArg = {
	value: argValue?,
	text: string?,
	success: boolean?,
}

export type argsController = {
	args: { parsedArg },
	index: number,
	next: (self: argsController) -> parsedArg?,
	nextValue: (self: argsController) -> argValue?,
}

export type argsManager = argsController

-- Plugins and commands: the tables a plugin file returns
export type plugin = {
	action: string,
	description: string?,
	args: args?,
	run: (self: commandsController, args: argsController) -> (),
	client: boolean?,
	isClient: boolean?,
	onlyClient: boolean?,
	deprecated: boolean?,
	isDeprecated: boolean?,
}

export type pluginFile = plugin | { plugin }

-- Connections and signals
export type connection = {
	Disconnect: (self: connection) -> (),
}

export type signal = {
	Connect: (self: signal, callback: (...any) -> ()) -> connection,
	Once: (self: signal, callback: (...any) -> ()) -> (),
	Wait: (self: signal) -> ...any,
	Fire: (self: signal, ...any) -> (),
}

-- Notifications and dialogs
export type notificationChoice = {
	text: string,
	primary: boolean?,
	onTap: (() -> ())?,
}
export type garbage = { [any]: any }

-- The command list
export type registeredCommand = {
	name: string,
	aliases: { string },
	args: { arg },
	description: string?,
	run: ((self: commandsController, args: argsController) -> ())?,
	isPluginCommand: boolean?,
	pluginName: string?,
	commandData: commandDisplay?,
	client: boolean?,
	isClient: boolean?,
	onlyClient: boolean?,
	deprecated: boolean?,
	isDeprecated: boolean?,
}

export type commandSection = {
	isSection: boolean,
	sectionName: string,
	isPluginSection: boolean?,
	commandData: commandDisplay?,
}

export type commandDisplay = {
	position: number,
	name: string?,
	sectionName: string?,
	isSection: boolean?,
	aliases: { string }?,
	args: { arg }?,
	description: string?,
	element: GuiObject?,
}

export type commandsList = {
	lookup: { [string]: registeredCommand },
	array: { string },
	original: { registeredCommand | commandSection },
	revision: number,
	changed: signal,
}

-- Services: players, loops, fetching, saved data, Roblox services and the executor
export type playerService = {
	getMouse: (self: playerService) -> PlayerMouse,
	isMouseInGuiObject: (self: playerService, object: GuiObject) -> boolean,
	getCharacter: (self: playerService) -> Model?,
	getHumanoid: (self: playerService) -> Humanoid?,
	getRootPart: (self: playerService) -> BasePart?,
	getCamera: (self: playerService) -> Camera?,
	isAlive: (self: playerService, character: Model?) -> boolean,
	getPlayersByName: (self: playerService, query: string) -> { Player },
	resetCharacter: (self: playerService) -> (),
	unseat: (self: playerService) -> Humanoid?,
	setRootCFrame: (self: playerService, target: CFrame) -> boolean,
	teleportTo: (self: playerService, target: CFrame | Vector3) -> boolean,
	teleportToJobId: (self: playerService, jobId: string, placeId: number?) -> (),
	breakVelocity: (self: playerService, duration: number?) -> (),
	cancelTween: (self: playerService) -> boolean,
	tweenTeleportTo: (self: playerService, config: { target: CFrame | Vector3, speed: number? }) -> Tween?,
	waitForStreamPlayerCharacter: (self: playerService, character: Model, waitTime: number?) -> (),
}
export type loopService = {
	add: (self: loopService, callback: () -> (), cooldown: number?) -> number,
	remove: (self: loopService, id: number) -> (),
	start: (self: loopService) -> (),
	stop: (self: loopService) -> (),
}
export type chunk = (...any) -> ...any

export type fetchService = {
	fetchUrl: (url: string) -> string?,
	fetch: (path: string) -> string?,
	download: (name: string) -> string?,
	downloadUrl: (name: string) -> string,
	load: (path: string, chunkName: string?) -> chunk?,
}

export type dataStore = {
	object: { [any]: any },
	filePath: string?,
	getValue: (self: dataStore, key: string) -> any,
	setValue: (self: dataStore, key: string, value: any) -> (),
	hasValue: (self: dataStore, key: string) -> boolean,
	increment: (self: dataStore, key: string, amount: number) -> (),
	getEntry: (self: dataStore, key: string) -> any,
	setEntry: (self: dataStore, key: string, value: any) -> (),
	getData: (self: dataStore) -> { [any]: any },
	replaceData: (self: dataStore, data: { [any]: any }) -> (),
	register: (self: dataStore, key: string, fallback: any) -> any,
	add: (self: dataStore, key: string, value: any) -> (),
	save: (self: dataStore) -> (),
	deep: (self: dataStore, path: string) -> ({ [any]: any }, string),
	getRealPath: (self: dataStore, path: string) -> string,
	exist: (self: dataStore, path: string) -> boolean,
	readFile: (self: dataStore, path: string) -> string,
	makeFolder: (self: dataStore, path: string) -> (),
	delete: (self: dataStore, path: string) -> boolean,
	writeFile: (self: dataStore, pathOrContent: string, content: string?) -> (),
	getCustomAsset: (self: dataStore, path: string) -> string,
}
export type storage = {
	waypoints: dataStore,
	plugins: dataStore,
	settings: dataStore,
	user: dataStore,
	aliases: dataStore,
	usedCmds: dataStore,
	eventBinds: dataStore,
	backgrounds: dataStore,
}

export type robloxServices = {
	Players: Players,
	RunService: RunService,
	TweenService: TweenService,
	TeleportService: TeleportService,
	GroupService: GroupService,
	StarterGui: StarterGui,
	CoreGui: CoreGui,
	GuiService: GuiService,
	UserInputService: UserInputService,
	TextChatService: TextChatService,
	ProximityPromptService: ProximityPromptService,
	NetworkClient: NetworkClient,
	[string]: any,
}

export type executorEnvironment = {
	loadstring: ((source: string, chunkName: string?) -> (chunk?, string?))?,
	readfile: ((path: string) -> string)?,
	writefile: ((path: string, content: string) -> ())?,
	isfile: ((path: string) -> boolean)?,
	listfiles: ((path: string) -> { string })?,
	makefolder: ((path: string) -> ())?,
	isfolder: ((path: string) -> boolean)?,
	delfile: ((path: string) -> ())?,
	setclipboard: ((text: string) -> ())?,
	[string]: any,
}

-- The controller: the object every run(self, args) receives as self
export type commandsController = {
	localPlayer: Player,
	isMobile: boolean,
	isPC: boolean,
	playerService: playerService,
	fetchService: fetchService,
	loopService: loopService,
	executorEnv: executorEnvironment,
	storage: storage,
	commandsList: commandsList,
	robloxServices: robloxServices,
	rbxServices: robloxServices,
	players: Players,
	teleportService: TeleportService,
	groupService: GroupService,
	runService: RunService,
	starterGui: StarterGui,
	coreGui: CoreGui,
	guiService: GuiService,
	networkClient: NetworkClient,
	proximityPromptService: ProximityPromptService,
	config: { links: { discord: string, github: string } },
	signals: { onCameraReset: signal },
	garbages: { [string]: garbage },
	privateEnv: { [string]: any },
	infiniteYield: any,
	userSettings: any,
	gameSettings: any,
	userGameSettings: UserGameSettings,
	gameNetworkSettings: any,

	notify: (self: commandsController, title: string, message: any?, duration: number?) -> (),
	ask: (self: commandsController, title: string, message: string, choices: { notificationChoice }, duration: number?) -> (),
	run: (self: commandsController, name: string, args: argsController?, asUser: boolean?) -> (),
	getCommandData: (self: commandsController, name: string) -> registeredCommand?,
	getLastArgs: (self: commandsController, name: string) -> { parsedArg }?,
	search: (self: commandsController, query: string, onlyBests: boolean?) -> { string },
	commandUsed: (self: commandsController, name: string) -> (),
	reportError: (self: commandsController, name: string, err: unknown, trace: string?) -> (),
	getRoot: (self: commandsController) -> BasePart?,
	getRootPart: (self: commandsController) -> BasePart?,
	connect: (self: commandsController, event: RBXScriptSignal | signal, callback: (...any) -> ()) -> (RBXScriptConnection | connection),
	Connect: (self: commandsController, event: RBXScriptSignal | signal, callback: (...any) -> ()) -> (RBXScriptConnection | connection),
	expectExploit: (self: commandsController, name: string) -> any,
	stringify: (self: commandsController, value: Vector3 | Color3) -> string,
	unstringify: (self: commandsController, text: string, kind: "Vector3" | "Color3") -> (Vector3 | Color3),
	registerGarbage: (self: commandsController, name: string) -> garbage,
	createGarbage: (self: commandsController, name: string) -> garbage,
	hasGarbage: (self: commandsController, name: string) -> boolean,
	getGarbage: (self: commandsController, name: string) -> garbage?,
	collectGarbage: (self: commandsController, name: string) -> garbage?,
}

return {}
