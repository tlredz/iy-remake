local _ENV = (getgenv or getfenv or getrenv)()

local function register(kind, original, fallback)
	if type(original) == kind then
		return original
	end
	
	if fallback ~= nil then
		if fallback == true then
			fallback = function(...) return ... end
		end
		
		return fallback
	end
end

return setmetatable({
	cloneref = register("function", cloneref, true),
	setfpscap = register("function", setfpscap, function(cap)
		if typeof(_ENV.FPS_CAP_THREAD) == "thread" then
			task.cancel(_ENV.FPS_CAP_THREAD)
		end
		
		_ENV.FPS_CAP_THREAD = task.spawn(function()
			local os_clock = os.clock
			local task_wait = task.wait
			
			local timer = os_clock() + (1 / cap)
			
			while true do
				task_wait(math.max(timer - os_clock(), 0))
				timer = os_clock() + (1 / cap)
			end
		end)
	end),
	gethui = register("function",
		gethui or
		get_hidden_gui
	),
	sethiddenproperty = register("function",
		sethiddenproperty or
		set_hidden_property or
		set_hidden_prop
	),
	gethiddenproperty = register("function",
		gethiddenproperty or
		get_hidden_property or
		get_hidden_prop
	),
	queueteleport = register("function",
		queue_on_teleport or
		(syn and syn.queue_on_teleport) or
		(fluxus and fluxus.queue_on_teleport)
	),
	httprequest = register("function",
		request or
		http_request or
		(syn and syn.request) or
		(http and http.request) or
		(fluxus and fluxus.request)
	),
	setclipboard = register("function",
		setclipboard or
		toclipboard or
		set_clipboard or
		(Clipboard and Clipboard.set)
	),
	firetouchinterest = register("function", firetouchinterest),
	makefolder = register("function", makefolder),
	isfolder = register("function", isfolder),
	getcustomasset = register("function",
		getcustomasset or
		getsynasset
	),
	hookfunction = register("function", hookfunction),
	hookmetamethod = register("function", hookmetamethod),
	getnamecallmethod = register("function",
		getnamecallmethod or
		get_namecall_method
	),
	checkcaller = register("function", checkcaller,
		function() return false end
	),
	newcclosure = register("function", newcclosure),
	getgc = register("function", getgc or get_gc_objects),
	setthreadidentity = register("function",
		setthreadidentity or
		syn_context_set or
		setthreadcontext or
		(syn and syn.set_thread_identity)
	),
	replicatesignal = register("function", replicatesignal),
	getconnections = register("function",
		getconnections or
		get_signal_cons
	),
	writefile = register("function", writefile),
	readfile = register("function", readfile),
	listfiles = register("function", listfiles),
	loadstring = register("function", loadstring),
	isfile = register("function", isfile, readfile and function(path)
		local success, result = pcall(readfile, path)
		return success and result ~= nil and result ~= ""
	end)
}, {
	__index = _ENV,
	__newindex = function(self, index, value)
		_ENV[index] = value
	end
})