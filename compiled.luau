local a;
do
	local b, c = unpack or table.unpack, { ... };
	local d = {
		function()
			if a(2) then
				return a(3);
			end;
			local c = a(8);
			if a(18) then
				c:fail("is already loaded");
				return nil;
			end;
			c:log("loading IY Remake...");
			c:log("is mobile:", a(20));
			c:log("is testing:", a(19));
			c:log("current version:", (a(10)).version);
			c:log("is remake version:", (a(10)).isRemakeVersion);
			a(21);
			return a(23);
		end,
		function()
			if not (game and (workspace and Game)) then
				return true;
			end;
			return false;
		end,
		function()
			local f = a(4);
			local g = "fl";
			print("searching for:", g);
			for f, g in f:search(g) do
				print("\t", g);
			end;
			return true;
		end,
		function()
			local f = a(5);
			local g = a(14);
			local h = a(15);
			local i = a(17);
			local j = a(8);
			local k = 25;
			local l = { garbages = {} };
			function l.createGarbage(g, f)
				j:assert(g.garbages[f] == nil, "attempt to create a existing garbage");
				local h = {};
				g.garbages[f] = h;
				return h;
			end;
			function l.hasGarbage(g, f)
				return g.garbages[f] ~= nil;
			end;
			function l.collectGarbage(g, f)
				local h = g.garbages[f];
				if h ~= nil then
					g.garbages[f] = nil;
					return h;
				end;
			end;
			function l.commandUsed(l, i)
				local m = f:getValue(i) or 0;
				local n = math.clamp(m + 1, 0, k);
				f:setValue(i, n);
				for l, m in f:getData() do
					if l == i then
						continue;
					end;
					local o = n == k;
					if (o or m < n) and m > 0 then
						m -= 1;
						if m == 0 then
							m = nil;
						end;
						f:setValue(l, m);
					end;
				end;
				f:save();
			end;
			function l.run(q, o, p)
				j:expect(o, { "string" }, "'commandsController:run' #1");
				q:commandUsed(o);
			end;
			function l.search(q, o, p)
				local r = g:searchAtArray(h.array, o, p);
				table.sort(r, function(o, p)
					local q = f:getValue(o) or 0;
					local r = f:getValue(p) or 0;
					return q > r;
				end);
				return r;
			end;
			return l;
		end,
		function()
			return (a(6)).new("totalUsedCommands");
		end,
		function()
			local o = a(7);
			local p = a(8);
			local q = a(10);
			local r = a(12);
			local s = q.privateFolder;
			if s:sub(# s) == "/" then
				s = s:sub(1, -2);
			end;
			local t = {};
			t.__index = t;
			local function u(p)
				local q, r = pcall(o.isfile, p);
				if q and type(r) == "boolean" then
					return r;
				end;
				return false;
			end;
			local function v(p)
				local q, t = pcall(o.isfilder, p);
				if q and type(t) == "boolean" then
					return t;
				end;
				return false;
			end;
			local function w(q)
				if not u(q) then
					p:log(`the file '{q}' don't exist, skipped!`);
					return "";
				end;
				local v, w = pcall(o.readfile, q);
				if not v then
					p:warn(`failed to read file '{q}':\n\t{w}`);
					w = nil;
				end;
				if type(w) ~= "string" then
					w = "";
				end;
				return w;
			end;
			local function x(x)
				local y = x:split("/");
				local z = {};
				for x, y in y do
					table.insert(z, y);
					local A = table.concat(z, "/");
					if v(A) then
						continue;
					end;
					local B, C = pcall(o.makefolder, A);
					if not B then
						p:warn(`failed to create a folder '{A}':\n\t{C}`);
					end;
				end;
			end;
			local function y(x, y)
				local B, D = pcall(o.writefile, x, y);
				if B then
					p:log(`successfully writed the file '{x}'!`);
				else
					p:warn(`failed to write file '{x}':\n\t{D}`);
				end;
			end;
			local function z(y)
				local B, E = pcall(o.getcustomasset, y);
				if not (B and type(E) == "string") then
					p:warn(`failed to get custom asset '{y}':\n\t{E}`);
					return;
				end;
				return E;
			end;
			local function A(B)
				local F = string.split(B, "/");
				local G = table.remove(F);
				return table.concat(F, "/"), G;
			end;
			function t.getRealPath(F, B)
				if B:sub(1, 1) ~= "/" then
					B = "/" .. B;
				end;
				B = s .. B;
				return B;
			end;
			function t.setValue(H, F, G)
				H.object[F] = G;
			end;
			function t.getValue(G, F)
				return G.object[F];
			end;
			function t.hasValue(G, F)
				return G.object[F] ~= nil;
			end;
			function t.increment(H, F, G)
				return H:setValue(F, (H:getValue(F) or 0) + G);
			end;
			function t.exist(G, F)
				F = G:getRealPath(F);
				return u(F);
			end;
			function t.writeFile(H, F, G)
				if H.filePath ~= nil then
					F, G = H.filePath, F;
				else
					F = H:getRealPath(F);
				end;
				y(F, G);
			end;
			function t.save(I)
				if I.isSaving then
					return;
				end;
				I.isSaving = true;
				I.lastSave = tick();
				task.delay(1, function()
					local J = r.encode(I.object, I.filePath);
					I.isSaving = false;
					I:writeFile(J);
				end);
			end;
			function t.getCustomAsset(K, J)
				J = K:getRealPath(J);
				return z(J);
			end;
			function t.getData(J)
				return table.clone(J.object);
			end;
			function t.new(J)
				p:expect(J, { "string" }, "'fileSystem.new' #1");
				if J:sub(-5, -1) ~= ".json" then
					J ..= ".json";
				end;
				local K = setmetatable({
					object = {},
					lastSave = 0,
					isSaving = false
				}, t);
				local L = K:getRealPath(J);
				local M = A(L);
				K.filePath = L;
				K.folderPath = M;
				if # M > 0 then
					x(M);
				end;
				local N = w(L);
				if # N > 0 then
					local O = r.decode(N);
					if type(O) ~= "table" then
						p:warn(`the json content has been returned a unexpected value '{L}'`);
						return K;
					end;
					K.object = O;
				end;
				return K;
			end;
			return t;
		end,
		function()
			local O = (getgenv or getfenv or getrenv)();
			local function P(O, P, Q)
				if type(P) == O then
					return P;
				end;
				if Q ~= nil then
					if Q == true then
						Q = function(...)
							return ...;
						end;
					end;
					return Q;
				end;
			end;
			return setmetatable({
				cloneref = P("function", cloneref, true),
				gethui = P("function", gethui or get_hidden_gui),
				sethiddenproperty = P("function", sethiddenproperty or set_hidden_property or set_hidden_prop),
				gethiddenproperty = P("function", gethiddenproperty or get_hidden_property or get_hidden_prop),
				queueteleport = P("function", queue_on_teleport or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport),
				httprequest = P("function", request or http_request or syn and syn.request or http and http.request or fluxus and fluxus.request),
				setclipboard = P("function", setclipboard or toclipboard or set_clipboard or Clipboard and Clipboard.set),
				firetouchinterest = P("function", firetouchinterest),
				makefolder = P("function", makefolder),
				isfolder = P("function", isfolder),
				getcustomasset = P("function", getcustomasset or getsynasset),
				hookfunction = P("function", hookfunction),
				hookmetamethod = P("function", hookmetamethod),
				getnamecallmethod = P("function", getnamecallmethod or get_namecall_method),
				checkcaller = P("function", checkcaller, function()
					return false;
				end),
				newcclosure = P("function", newcclosure),
				getgc = P("function", getgc or get_gc_objects),
				setthreadidentity = P("function", setthreadidentity or syn_context_set or setthreadcontext or syn and syn.set_thread_identity),
				replicatesignal = P("function", replicatesignal),
				getconnections = P("function", getconnections or get_signal_cons),
				writefile = P("function", writefile),
				readfile = P("function", readfile),
				isfile = P("function", isfile, readfile and function(O)
					local R, S = pcall(readfile, O);
					return R and (S ~= nil and S ~= "");
				end)
			}, {
				__index = O,
				__newindex = function(R, S, T)
					O[S] = T;
				end
			});
		end,
		function()
			local R = a(9);
			local S = R.logText;
			local T = {};
			local function U()
				for R, S in {
					"log",
					"warn"
				} do
					T[S] = function()
 
					end;
				end;
			end;
			function T.log(U, R, ...)
				print(S:format(tostring(R)), ...);
			end;
			function T.warn(U, R)
				(warn or print)(S:format(tostring(R)));
			end;
			function T.error(V, R, U)
				error(S:format(tostring(R)), U);
			end;
			function T.fail(U, R)
				U:error("failed to load: " .. R);
			end;
			function T.assert(V, R, U)
				if not R then
					V:error(U);
				end;
			end;
			function T.expect(Y, R, W, X)
				if not table.find(W, typeof(R)) then
					Y:error((X or "") .. (` expected '{table.concat(W, ", ")}'. got '{typeof(R)}'.`));
				end;
			end;
			if not (a(9)).isEnabled then
				U();
			end;
			return T;
		end,
		function()
			return {
				logText = "infinite yield -> %s",
				isEnabled = true
			};
		end,
		function()
			return {
				isRemakeVersion = true,
				version = a(11),
				displayName = "Infinite Yield RE",
				commands = {
					padding = 3,
					labelSize = 14,
					textSize = 14,
					placeholderText = ">_ command bar"
				},
				window = {
					windowSize = UDim2.fromOffset(250, 220),
					draggable = true
				},
				privateFolder = "infiniteYield",
				assetsPath = "assets/%s.png"
			};
		end,
		function()
			return "0.0.2";
		end,
		function()
			local Z = a(13);
			local _a = a(8);
			local aa = Z.HttpService;
			local ba = aa.JSONEncode;
			local ca = aa.JSONDecode;
			return {
				encode = function(Z, ca)
					local da, ea = pcall(ba, aa, Z);
					if not da then
						_a:warn(`failed to encode json '{ca or "unknown"}': {ea}`);
						return nil;
					end;
					return ea;
				end,
				decode = function(Z, da)
					local fa, ga = pcall(ca, aa, Z);
					if not fa then
						_a:warn(`failed to decode json '{da or "unknown"}': {ga}`);
						return nil;
					end;
					return ga;
				end
			};
		end,
		function()
			local Z = {};
			local fa = a(7);
			local ha = a(8);
			function Z.__index(ia, Z)
				ha:expect(Z, { "string" }, "[index] serviceName");
				local ja = game:GetService(Z);
				local ka = fa.cloneref(ja);
				rawset(ia, Z, ka);
				return ka;
			end;
			return setmetatable({}, Z);
		end,
		function()
			local Z = {};
			function Z.searchAtArray(ka, Z, ia, ja)
				if ia == "" then
					return {};
				end;
				local la = {};
				local ma = {};
				for Z, ka in Z do
					if # ka < # ia then
						continue;
					end;
					local na = ka:find(ia, 1, true);
					if na then
						if na == 1 then
							table.insert(la, ka);
						elseif not ja then
							table.insert(ma, ka);
						end;
					end;
				end;
				for Z, oa in ma do
					table.insert(la, oa);
				end;
				return la;
			end;
			return Z;
		end,
		function()
			local Z = a(8);
			local oa = a(16);
			local function pa(oa)
				local pa = {};
				local qa = {};
				for oa, ra in oa do
					if ra.isSection then
						continue;
					end;
					Z:expect(ra.action, { "string" }, "command action");
					local sa = {};
					local ta = ra.args or {};
					ra.args = ta;
					for oa, ta in ra.action:split("|") do
						if not ra.name then
							ra.name = ta;
						end;
						pa[ta] = ra;
						table.insert(sa, ta);
						table.insert(qa, ta);
					end;
					table.sort(sa, function(oa, ua)
						return # oa < # ua;
					end);
					if # ta == 0 and next(ta) then
						ra.args = { ta };
					end;
					ra.aliases = sa;
					ra.action = nil;
				end;
				return {
					array = qa,
					lookup = pa,
					original = oa
				};
			end;
			return pa({
				{
					action = "discord|support|help",
					description = "Invite to the Infinite Yield discord server."
				},
				{
					action = "guiscale",
					description = "Changes the size of the gui. [number] accepts decimals and whole numbers.",
					args = {
						kind = "number",
						clamp = {
							oa.minScale,
							oa.maxScale
						}
					}
				},
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
						name = "place ID"
					}
				},
				{
					action = "antiafk|antiidle",
					description = "Prevents the game from kicking you for being idle/afk"
				},
				{
					action = "datalimit",
					description = "Set outgoing KBPS limit",
					args = { kind = "number" }
				},
				{
					action = "replicationlag|backtrack",
					description = "Set IncomingReplicationLag",
					args = { kind = "number" }
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
					args = { kind = "boolean" }
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
						clamp = {
							0,
							10
						}
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
					action = "unalignmentkeys|noalignmentkeys",
					description = "Disables the alignment keys"
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
				{ isSection = true },
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
					args = { kind = "number" }
				},
				{
					action = "qefly",
					description = "Enables or disables the Q and E hotkeys for fly",
					args = { kind = "boolean" }
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
				{ isSection = true },
				{
					action = "setwaypoint|swp",
					description = "Sets a waypoint at your position",
					args = { kind = "string" }
				},
				{
					action = "waypointpos|wpp",
					description = "Sets a waypoint with specified coordinates",
					args = { kind = "vector3" }
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
					args = { kind = "waypoint" }
				},
				{
					action = "tweenwaypoint|twp",
					description = "Tweens player to a waypoint",
					args = { kind = "waypoint" }
				},
				{
					action = "walktowaypoint|wtwp",
					description = "Walks player to a waypoint",
					args = { kind = "waypoint" }
				},
				{
					action = "deletewaypoint|dwp",
					description = "Deletes a waypoint",
					args = { kind = "waypoint" }
				},
				{
					action = "clearwaypoints|cwp",
					description = "Clears all waypoints"
				},
				{
					action = "cleargamewaypoints|cgamewp",
					description = "Clears all waypoints for the game you are in"
				},
				{ isSection = true },
				{
					action = "goto",
					description = "Go to a player",
					args = { kind = "player" }
				},
				{
					action = "tweengoto|tgoto",
					description = "Tween to a player (bypasses some anti cheats)",
					args = { kind = "player" }
				},
				{
					action = "tweenspeed|tspeed",
					description = "Sets how fast all tween commands go (default is 1)",
					args = { kind = "number" }
				},
				{
					action = "vehiclegoto|vgoto",
					description = "Go to a player while in a vehicle",
					args = { kind = "player" }
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
						{ kind = "player" },
						{
							kind = "number",
							name = "time amount"
						}
					}
				},
				{
					action = "clientbring|cbring",
					description = "Bring a player (CLIENT)",
					args = { kind = "player" }
				},
				{
					action = "loopbring",
					description = "Loop brings a player to you (useful for killing) (CLIENT)",
					args = {
						{ kind = "player" },
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
					args = { kind = "player" }
				},
				{
					action = "freeze|fr",
					description = "Freezes a player (CLIENT)",
					args = { kind = "player" }
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
					args = { kind = "player" }
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
					args = { kind = "vector3" }
				},
				{
					action = "tweentpposition|ttppos",
					description = "Tween to coordinates (bypasses some anti cheats)",
					args = { kind = "vector3" }
				},
				{
					action = "offset",
					description = "Offsets you by certain coordinates",
					args = { kind = "vector3" }
				},
				{
					action = "tweenoffset|toffset",
					description = "Tween offset (bypasses some anti cheats)",
					args = { kind = "vector3" }
				},
				{
					action = "thru",
					description = "Teleports you [num] studs ahead of where your character is facing",
					args = { kind = "number" }
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
					args = { kind = "vector3" }
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
				{ isSection = true },
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
						{ kind = "player" },
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
						{ kind = "player" },
						{
							kind = "string",
							name = "your message"
						}
					}
				},
				{
					action = "unpmspam",
					description = "Turns off pm spam",
					args = { kind = "player" }
				},
				{
					action = "spamspeed|spamdelay",
					description = "How quickly you spam (default is 1)",
					args = { kind = "number" }
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
					args = { kind = "player" }
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
					args = { kind = "player" }
				},
				{
					action = "unmutevc",
					description = "Unmutes the voice chat of a player",
					args = { kind = "player" }
				},
				{
					action = "phonebook|call",
					description = "Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled"
				},
				{ isSection = true },
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
					args = { kind = "number" }
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
					args = { kind = "player" }
				},
				{
					action = "unlocate|nolocate",
					description = "Removes locate",
					args = { kind = "player" }
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
				{ isSection = true },
				{
					action = "spectate|view",
					description = "View a player",
					args = { kind = "player" }
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
					args = { kind = "vector3" }
				},
				{
					action = "freecamwaypoint|fcwp",
					description = "Moves / opens freecam to a waypoint",
					args = { kind = "waypoint" }
				},
				{
					action = "freecamgoto|fcgoto|fctp",
					description = "Moves / opens freecam to a player",
					args = { kind = "player" }
				},
				{
					action = "unfreecam|unfc",
					description = "Disables freecam"
				},
				{
					action = "freecamspeed|fcspeed",
					description = "Adjusts freecam speed (default is 1)",
					args = { kind = "number" }
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
					args = { kind = "number" }
				},
				{
					action = "minzoom",
					description = "Minimum camera zoom",
					args = { kind = "number" }
				},
				{
					action = "camdistance",
					description = "Changes camera distance from your player",
					args = { kind = "number" }
				},
				{
					action = "fov",
					description = "Adjusts field of view (default is 70)",
					args = { kind = "number" }
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
					args = { kind = "player" }
				},
				{ isSection = true },
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
					args = { kind = "className" }
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
					args = { kind = "className" }
				},
				{
					action = "tweengotopartclass|tgpc",
					description = "Tweens your character to a part or multiple parts based on classname",
					args = { kind = "className" }
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
					args = { kind = "number" }
				},
				{
					action = "bringpart",
					description = "Moves a part or multiple parts to your character (CLIENT)",
					args = { kind = "string" }
				},
				{
					action = "bringpartclass|bpc",
					description = "Moves a part or multiple parts to your character based on classname (CLIENT)",
					args = { kind = "className" }
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
					args = { kind = "player" }
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
					args = { kind = "number" }
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
				{ isSection = true },
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
					args = { kind = "color3" }
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
					args = { kind = "number" }
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
						{ kind = "player" },
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
				{ isSection = true },
				{
					action = "inspect|examine",
					description = "Opens InspectMenu for a certain player",
					args = { kind = "player" }
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
					args = { kind = "player" }
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
					args = { kind = "player" }
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
					args = { kind = "player" }
				},
				{
					action = "bang",
					description = "owo",
					args = {
						{ kind = "player" },
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
					args = { kind = "player" }
				},
				{
					action = "carpet",
					description = "Be someones carpet",
					args = { kind = "player" }
				},
				{
					action = "uncarpet",
					description = "Undoes carpet"
				},
				{
					action = "friend",
					description = "Sends a friend request to certain players",
					args = { kind = "player" }
				},
				{
					action = "unfriend",
					description = "Unfriends certain players",
					args = { kind = "player" }
				},
				{
					action = "headsit",
					description = "Sit on a players head",
					args = { kind = "player" }
				},
				{
					action = "walkto|follow",
					description = "Follow a player",
					args = { kind = "player" }
				},
				{
					action = "pathfindwalkto|pathfindfollow",
					description = "Follow a player using pathfinding",
					args = { kind = "player" }
				},
				{
					action = "pathfindwalktowaypoint|pathfindwalktowp|pftowp",
					description = "Walk to a waypoint using pathfinding",
					args = { kind = "waypoint" }
				},
				{
					action = "unwalkto|unfollow",
					description = "Stops following a player"
				},
				{
					action = "orbit",
					description = "Makes your character orbit around a player with an optional speed and an optional distance",
					args = {
						{ kind = "player" },
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
					args = { kind = "player" }
				},
				{
					action = "unstareat|unstare",
					description = "Disables stareat",
					args = { kind = "player" }
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
						{ kind = "player" },
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
					args = { kind = "player" }
				},
				{
					action = "unmuteboombox",
					description = "Unmutes someones boombox",
					args = { kind = "player" }
				},
				{
					action = "hitbox",
					description = "Expands the hitbox for players HumanoidRootPart (default is 1)",
					args = {
						{ kind = "player" },
						{
							kind = "number",
							name = "size"
						},
						{
							kind = "number",
							name = "transparency",
							clamp = {
								0,
								1
							}
						}
					}
				},
				{
					action = "headsize",
					description = "Expands the head size for players Head (default is 1)",
					args = {
						{ kind = "player" },
						{
							kind = "number",
							name = "head size"
						}
					}
				},
				{ isSection = true },
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
					args = { kind = "number" }
				},
				{
					action = "loopspeed|loopws",
					description = "Loops your walkspeed",
					args = { kind = "number" }
				},
				{
					action = "unloopspeed|unloopws",
					description = "Turns off loopspeed"
				},
				{
					action = "hipheight|hheight",
					description = "Adjusts hip height",
					args = { kind = "number" }
				},
				{
					action = "jumppower|jpower|jp",
					description = "Change a players jump height (default is 50)",
					args = { kind = "number" }
				},
				{
					action = "spoofjumppower|spoofjp",
					description = "Spoofs your JumpPower on the Client",
					args = { kind = "number" }
				},
				{
					action = "loopjumppower|loopjp",
					description = "Loops your jump height",
					args = { kind = "number" }
				},
				{
					action = "unloopjumppower|unloopjp",
					description = "Turns off loopjumppower"
				},
				{
					action = "maxslopeangle|msa",
					description = "Adjusts MaxSlopeAngle",
					args = { kind = "number" }
				},
				{
					action = "gravity|grav",
					description = "Change your gravity (CLIENT)",
					args = { kind = "number" }
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
					args = { kind = "team" }
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
					args = { kind = "number" }
				},
				{
					action = "unweaken",
					description = "Sets your characters CustomPhysicalProperties to default"
				},
				{
					action = "strengthen",
					description = "Makes your character more dense (CustomPhysicalProperties)",
					args = { kind = "number" }
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
				{ isSection = true },
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
					args = { kind = "number" }
				},
				{
					action = "copyanimation|copyanim|copyemote",
					description = "Copies someone elses animation",
					args = { kind = "player" }
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
				{ isSection = true },
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
						{ kind = "keycode" },
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
						clamp = {
							0,
							10
						}
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
				{ isSection = true },
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
					args = { kind = "player" }
				},
				{
					action = "dupetools|clonetools",
					description = "Duplicates your inventory tools a set amount of times",
					args = { kind = "number" }
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
					args = { kind = "number" }
				},
				{
					action = "boxreach",
					description = "Increases the hitbox of your held tool in a box shape",
					args = { kind = "number" }
				},
				{
					action = "unreach|noreach",
					description = "Turns off reach"
				},
				{
					action = "grippos",
					description = "Changes your current tools grip position",
					args = { kind = "vector3" }
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
						{ kind = "command" },
						{
							kind = "string",
							name = "alias"
						}
					}
				},
				{
					action = "removealias",
					description = "Removes a custom alias",
					args = { kind = "alias" }
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
					args = { kind = "plugin" }
				},
				{
					action = "reloadplugin",
					description = "Reloads a plugin",
					args = { kind = "plugin" }
				},
				{
					action = "addallplugins|loadallplugins",
					description = "Adds all available plugins from the workspace folder"
				}
			});
		end,
		
		function()
			return {
				minScale = 0.4,
				maxScale = 2
			};
		end,
		function()
			local oa = {};
			local ua = {};
			ua.__index = ua;
			oa.__index = oa;
			do
				function ua.Disconnect(oa)
					if not oa.Connected then
						return nil;
					end;
					local va = table.find(oa.Signal, oa);
					if va then
						table.remove(oa.Signal, va);
					end;
					oa.Function = nil;
					oa.Connected = false;
				end;
				function ua.Fire(wa, ...)
					if not wa.Function then
						return nil;
					end;
					task.spawn(wa.Function, ...);
				end;
				function ua.new()
					return setmetatable({ Connected = true }, ua);
				end;
				setmetatable(ua, {
					__index = function(wa, xa)
						error(("Attempt to get Connection::%s (not a valid member)"):format(tostring(xa)), 2);
					end,
					__newindex = function(wa, xa, ya)
						error(("Attempt to set Connection::%s (not a valid member)"):format(tostring(xa)), 2);
					end
				});
			end;
			function oa.Connect(xa, wa)
				assert(type(wa) == "function", "function expected, got " .. type(wa));
				local ya = ua.new();
				ya.Function = wa;
				ya.Signal = xa;
				table.insert(xa.Connections, ya);
				return ya;
			end;
			function oa.Once(xa, wa)
				local ya;
				ya = xa:Connect(function(...)
					wa(...);
					ya:Disconnect();
				end);
				return ya;
			end;
			function oa.Wait(xa)
				local za = coroutine.running();
				local Aa;
				Aa = xa:Connect(function(...)
					Aa:Disconnect();
					task.spawn(za, ...);
				end);
				return coroutine.yield();
			end;
			function oa.Fire(xa, ...)
				for xa, Ba in ipairs(xa.Connections) do
					if Ba.Connected then
						Ba:Fire(...);
					end;
				end;
			end;
			function oa.new()
				return setmetatable({ Connections = {} }, oa);
			end;
			setmetatable(oa, {
				__index = function(xa, Ca)
					error(`Attempt to get Signal::{tostring(Ca)} (not a valid member)`, 2);
				end,
				__newindex = function(xa, Ca, Da)
					error(`Attempt to set Signal::{tostring(Ca)} (not a valid member)`, 2);
				end
			});
			return oa;
		end,
		function()
			local xa = a(7);
			if a(19) then
				return false;
			end;
			if LOADED_IY or xa.LOADED_IY then
				return true;
			end;
			xa.LOADED_IY = true;
			return false;
		end,
		function()
			return true;
		end,
		function()
			local xa = a(13);
			local Ca = xa.UserInputService;
			local Da = false;
			xpcall(function()
				Da = table.find({
					Enum.Platform.Android,
					Enum.Platform.IOS
				}, Ca:GetPlatform()) ~= nil;
			end, function()
				Da = Ca.TouchEnabled and not Ca.KeyboardEnabled;
			end);
			return Da;
		end,
		
		function()
			local xa = a(22);
			local Ea = a(8);
			if xa.screenGui then
				xa.screenGui:Destroy();
				Ea:log("destroyed old interface");
			end;
			if xa.connectionService then
				xa.connectionService:cleanup();
				Ea:log("cleaned old connections");
			end;
			return true;
		end,
		function()
			local Fa = a(7);
			local Ga = "IY-REMAKE-PRIVATEENV";
			local Ha = Fa[Ga] or {};
			Fa[Ga] = Ha;
			return Ha;
		end,
		function()
			local Fa = a(7);
			local Ga = a(22);
			local Ha = a(8);
			local Ia = a(24);
			local Ja = a(25);
			local Ka = a(29);
			local La = a(13);
			local Ma = a(30);
			local Na = a(38);
			local Oa = a(40);
			local Pa = a(10);
			local Qa = a(41);
			local Ra = a(42);
			local Sa = Ra.uiScale;
			local Ta = a(43);
			local Ua = a(48);
			local Va = a(55);
			local Wa = a(55);
			local Xa = {};
			local function Ya()
				local Fa = tonumber(os.date("%Y"));
				local Ga = math.floor(Fa / 100);
				local Ha = math.floor((13 + 8 * Ga) / 25);
				local Ia = (((15 - Ha) + Ga) - math.floor(Ga / 4)) % 30;
				local Ja = ((4 + Ga) - math.floor(Ga / 4)) % 7;
				local Ka = (19 * (Fa % 19) + Ia) % 30;
				local La = (((2 * (Fa % 4) + 4 * (Fa % 7)) + 6 * Ka) + Ja) % 7;
				local Ma = (22 + Ka) + La;
				if Ka == 29 and La == 6 then
					return "04 19";
				elseif Ka == 28 and La == 6 then
					return "04 18";
				end;
				if Ma > 31 then
					return ("04 %02d"):format(Ma - 31);
				end;
				return ("03 %02d"):format(Ma);
			end;
			local function Za()
				local Fa = {
					["01 01"] = Qa.NEW_YEAR,
					["02 14"] = Qa.VALENTINE_DAYS,
					["03 17"] = Qa.CLOVER,
					["10 31"] = Qa.HALLOWEEN,
					["12 25"] = Qa.CHRISTMAS,
					[Ya()] = Qa.EASTER
				};
				local Ga = os.date("%m %d");
				return Fa[Ga];
			end;
			local function _b()
				local Fa = Pa.displayName;
				Fa = Fa:gsub("!VERSION", Pa.version);
				local Ga = Za();
				if Ga then
					Fa = `{Ga} {Fa} {Ga}`;
				end;
				return Fa;
			end;
			function Xa.getProtectedFolder(Ha)
				local Ia = La.CoreGui;
				if Fa.gethui then
					local Ha, Ja = pcall(Fa.gethui);
					if Ha and typeof(Ja) == "Instance" then
						Ia = Ja;
					end;
				end;
				if Ia == La.CoreGui then
					Ia = Ia:FindFirstChild("RobloxGui") or Ia;
				end;
				return Ia;
			end;
			function Xa.createCommands(Ka)
				local Na = Ka.scrollHolder;
				local Oa = Ka.scrollBar;
				local Ra = Ua.new({
					scrolledSignal = Oa.scrolledSignal,
					scrollContainer = Ka.scrollContainer,
					scrollHolder = Na,
					scrollBar = Oa
				});
				Ha:log("created commands interface");
				Ra:create();
				Ha:log("initialized commands");
				Ra:createCommandsData();
				Ha:log("awaked commands module");
				Ra:awake();
				Ka.commands = Ra;
				return Ra;
			end;
			function Xa.createMainScroll(Na, Ka)
				local Oa = Ta.new({
					isHorizontal = false,
					barThickness = 10
				});
				local Ra = Oa:create();
				local Sa = Oa.container;
				local Va = Ma.new("Frame", "ScrollHolder", Ka, {
					Size = UDim2.new(1, 0, 0, 180),
					Position = UDim2.fromScale(0.5, 1),
					AnchorPoint = Vector2.new(0.5, 1),
					BackgroundTransparency = 1,
					Active = true,
					Ra,
					Sa
				});
				Na.scrollHolder = Va;
				Na.scrollBar = Oa;
				Na.scrollContainer = Sa;
				return Oa;
			end;
			function Xa.createMainFrame(Na)
				local Oa = Ma.new("Frame", "MainFrame", {
					Active = true,
					BorderSizePixel = 0,
					ThemeTag = { BackgroundColor3 = "Colors.Background" },
					Ma.new("Frame", "TopBar", {
						Size = UDim2.fromOffset(250, 20),
						BorderSizePixel = 0,
						ThemeTag = { BackgroundColor3 = "Colors.Background" }
					})
				});
				local Ra = Oa.TopBar;
				local Sa = Ma.new("TextLabel", "Title", Ra, {
					Text = _b(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					TextSize = 16,
					ThemeTag = {
						TextColor3 = "Colors.Text.Default",
						Font = "Font.Normal"
					}
				});
				local Va = Ma.new("ImageButton", Ra, {
					Name = "SettingsButton",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -2, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5),
					Size = UDim2.fromOffset(19, 19),
					ThemeTag = { ImageColor3 = "Colors.Icons" }
				});
				local Wa = Ma.new("ImageButton", Ra, {
					Name = "ReferenceButton",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -22, 0.5, 0),
					AnchorPoint = Vector2.new(1, 0.5),
					Size = UDim2.fromOffset(15, 15),
					ThemeTag = { ImageColor3 = "Colors.Icons" }
				});
				Ja:loadImage(Va, "settings");
				Ja:loadImage(Wa, "reference");
				Ka:Connect(Va.Activated, function()
					print("clicked settings");
				end);
				Ka:Connect(Wa.Activated, function()
					print("clicked reference");
				end);
				Na:createMainScroll(Oa);
				return Oa;
			end;
			function Xa.calculateScale(Oa, Na)
				return (Oa.screenGui.AbsoluteSize.Y / 450) * Na;
			end;
			function Xa.calculateMainFramePosition(Na)
				local Oa = Na.mainFrame;
				local Sa = Na.screenGui;
				local Va = Oa.Size;
				local Wa = Oa.Position;
				local Xa = Ra:getScale();
				local ab = Oa.AbsoluteSize.X;
				local bb = Oa.AbsoluteSize.Y;
				local cb = Sa.AbsoluteSize.X - ab;
				local db = Sa.AbsoluteSize.Y - bb;
				return UDim2.new(1, math.clamp(Wa.X.Offset, - math.max(0, cb), 9e9), 1, math.clamp(Wa.Y.Offset, - math.max(0, db), 9e9));
			end;
			function Xa.dragMainFrame(Va, Na)
				local Wa = Oa.new(Sa);
				local Xa = Va.screenGui;
				local ab = Ra:getScale();
				local bb = Pa.window;
				local cb = bb.windowSize;
				Na.Size = cb;
				Na.Position = UDim2.new(1, - cb.X.Offset, 1, - cb.Y.Offset);
				Wa:addGuiObject(Na);
				Va.dragService = Wa;
			end;
			function Xa.create(Na)
				local Va = 2147483647;
				local Wa = Ia.simpleCreate("ScreenGui", {
					IgnoreGuiInset = true,
					Name = Ia.randomString(math.random(30, 50)),
					DisplayOrder = Va
				});
				Wa.Parent = Na:getProtectedFolder();
				Na.screenGui = Wa;
				local Xa = Na:createMainFrame();
				Na.mainFrame = Xa;
				Na:createCommands();
				Na:dragMainFrame(Xa);
				Na.commands:enable();
				Sa.Scale = Na:calculateScale(1);
				Sa.Parent = Wa;
				Xa.Parent = Wa;
				Ga.screenGui = Wa;
				return Wa;
			end;
			return Xa:create();
		end,
		function()
			local Na = {};
			local Va = "abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUV_0123456789";
			local Wa = {
				["&"] = "&amp;",
				["<"] = "&lt;",
				[">"] = "&gt;",
				["\""] = "&quot;",
				["'"] = "&apos;"
			};
			function Na.randomString(Na)
				local Wa = {};
				for Na = 1, Na do
					local Xa = math.random(1, # Va);
					table.insert(Wa, Va:sub(Xa, Xa));
				end;
				return table.concat(Wa);
			end;
			function Na.getDeep(Na, Xa)
				for Xa in Xa:gmatch("[^%.]+") do
					Na = Na[Xa];
				end;
				return Na;
			end;
			function Na.simpleCreate(Xa, ab)
				local bb = Instance.new(Xa);
				for Xa, ab in ab do
					bb[Xa] = ab;
				end;
				return bb;
			end;
			function Na.chararray(Xa)
				local ab = {};
				for cb = 1, # Xa do
					table.insert(ab, Xa:sub(1, 1));
				end;
				return ab;
			end;
			function Na.lookupify(cb)
				local db = {};
				for eb = 1, # cb do
					local fb = cb[eb];
					db[fb] = true;
				end;
				return db;
			end;
			function Na.unlookupify(eb)
				local fb = {};
				for eb, gb in eb do
					table.insert(fb, eb);
				end;
				return fb;
			end;
			function Na.escapeRichText(eb)
				return eb:gsub(".", function(eb)
					return Wa[eb] or eb;
				end);
			end;
			function Na.colorFromRGB(eb, gb)
				return `<font color="#{gb:ToHex()}">{eb}</font>`;
			end;
			function Na.richFontSize(eb, gb)
				return `<font size="{gb}">{eb}</font>`;
			end;
			return Na;
		end,
		function()
			local eb = a(7);
			local gb = (a(10)).assetsPath;
			local hb = a(6);
			local ib = a(26);
			local jb = a(28);
			local kb = a(8);
			local lb = {};
			local mb = {};
			local nb = eb.getcustomasset;
			local ob = {};
			function ob.newCustomAsset(ib, eb, gb)
				kb:assert(not lb[eb], "asset is loaded");
				local mb = hb:getCustomAsset(gb);
				if mb == nil then
					mb = jb[eb];
					lb[eb] = mb;
					return mb;
				end;
				kb:log(`new custom asset to '{gb}': '{customasset}'`);
				return mb;
			end;
			function ob.get(pb, ob)
				if lb[ob] then
					return lb[ob];
				end;
				if type(nb) ~= "function" then
					return jb[ob];
				end;
				local qb = gb:format(ob);
				kb:log(`loading asset: '{qb}'`);
				if hb:exist(qb) then
					return pb:newCustomAsset(ob, qb);
				end;
				local rb = ib.fetch(qb);
				if rb == nil then
					assetid = jb[ob];
					lb[ob] = assetid;
					return assetid;
				end;
				hb:writeFile(qb, rb);
				kb:log(`created a file to asset: '{qb}'`);
				return pb:newCustomAsset(ob, qb);
			end;
			function ob.loadImage(tb, rb, sb)
				kb:assert(jb[sb], "invalid asset name");
				local ub = lb[sb];
				if ub ~= nil then
					rb.Image = ub;
					return;
				end;
				rb.Image = "";
				if mb[sb] then
					table.insert(mb[sb], rb);
					return;
				end;
				mb[sb] = { rb };
				task.defer(function()
					local vb = tb:get(sb);
					if not vb then
						return;
					end;
					for wb, xb in mb[sb] do
						xb.Image = vb;
					end;
					mb[sb] = nil;
				end);
			end;
			return ob;
		end,
		
		function()
			local wb = a(27);
			local xb = a(8);
			local yb = "https://raw.githubusercontent.com/%s/%s/refs/heads/main/";
			yb = yb:format(wb.owner, wb.repository);
			local zb = {};
			local function Ab(wb)
				return game:HttpGet(wb);
			end;
			function zb.fetch(wb)
				if wb:sub(1, 1) == "/" then
					wb = wb:sub(2);
				end;
				local zb, Bb = pcall(Ab, yb .. wb);
				if not zb then
					xb:warn(`failed to fetch http url '{wb}':\n\t{Bb}`);
					return;
				end;
				return Bb;
			end;
			return zb;
		end,
		function()
			return {
				owner = "tlredz",
				repository = "iy-remake"
			};
		end,
		function()
			return {
				bindsandplugins = "rbxassetid://5147695474",
				close = "rbxassetid://5054663650",
				editaliases = "rbxassetid://5147488658",
				editkeybinds = "rbxassetid://129697930",
				edittheme = "rbxassetid://4911962991",
				editwaypoints = "rbxassetid://5147488592",
				imgstudiopluginlogo = "rbxassetid://4113050383",
				logo = "rbxassetid://1352543873",
				minimize = "rbxassetid://2406617031",
				pin = "rbxassetid://6234691350",
				reference = "rbxassetid://3523243755",
				settings = "rbxassetid://1204397029"
			};
		end,
		function()
			local zb = { connections = {} };
			local Cb = a(22);
			Cb.connectionService = zb;
			function zb.cleanup(zb)
				for zb, Cb in ipairs(zb.connections) do
					Cb:Disconnect();
				end;
			end;
			function zb.disconnect(Cb, zb)
				if zb then
					zb:Disconnect();
				end;
			end;
			function zb.Connect(Eb, Cb, Db)
				local Fb = Cb:Connect(Db);
				table.insert(Eb.connections, Fb);
				return Fb;
			end;
			return zb;
		end,
		
		function()
			local Cb = a(31);
			local Db = a(8);
			local Eb = {};
			function Eb.setProperties(Db, Eb)
				for Eb, Fb in Eb do
					if Cb[Eb] then
						Cb[Eb](Db, Fb);
						continue;
					end;
					if type(Eb) == "number" and typeof(Fb) == "Instance" then
						Fb.Parent = Db;
						continue;
					end;
					Db[Eb] = Fb;
				end;
				return Db;
			end;
			function Eb.setup(Gb, ...)
				for Hb, Ib in { ... } do
					local Jb = typeof(Ib);
					if Jb == "table" then
						Eb.setProperties(Gb, Ib);
					else
						local Hb = if Jb == "string" then "Name" else "Parent";
						Gb[Hb] = Ib;
					end;
				end;
				return Gb;
			end;
			function Eb.new(Hb, ...)
				local Kb = Instance.new(Hb);
				return Eb.setup(Kb, ...);
			end;
			return Eb;
		end,
		function()
			local Hb = a(32);
			local Kb = a(8);
			local Lb = {};
			function Lb.ThemeTag(Lb, Mb)
				if type(Mb) ~= "table" then
					Kb:error("expected a 'table' when setting a theme tag");
					return;
				end;
				Hb:addObject(Lb, Mb);
			end;
			return Lb;
		end,
		function()
			local Lb = a(33);
			local Mb = a(8);
			local Nb = a(24);
			local Ob = a(34);
			local Pb = Lb.defaultTheme;
			local Qb = {
				objects = {},
				selectedTheme = nil
			};
			function Qb.selectTheme(Nb, Lb)
				Mb:expect(Lb, { "string" }, "'themeService:selectTheme' #1");
				local Pb = Ob[Lb:lower()];
				if not Pb then
					Mb:error(`'{Lb}' isn't a valid theme`);
					return;
				end;
				if Pb ~= Nb.selectedTheme then
					Nb.selectedTheme = Pb;
					Nb:updateObjects();
				end;
				return Nb;
			end;
			function Qb.updateObject(Rb, Qb)
				Rb:updateObjectProperties(Qb, Rb.objects[Qb]);
			end;
			function Qb.updateObjectProperties(Sb, Qb, Rb)
				for Rb, Tb in Rb do
					Qb[Rb] = Nb.getDeep(Sb.selectedTheme, Tb);
				end;
			end;
			function Qb.updateObjects(Rb)
				for Tb, Ub in Rb.objects do
					Rb:updateObject(Tb);
				end;
			end;
			function Qb.addObject(Vb, Tb, Ub)
				Vb.objects[Tb] = Ub;
				Vb:updateObject(Tb);
			end;
			return Qb:selectTheme(Pb);
		end,
		function()
			local Tb = a(19);
			return { defaultTheme = Tb and "Dark" or "Classic" };
		end,
		function()
			local Tb = {
				a(35),
				a(36),
				a(37)
			};
			local Ub = {};
			for Tb, Vb in Tb do
				local Wb = string.lower(Vb.DisplayName);
				Ub[Wb] = Vb;
			end;
			return Ub;
		end,
		function()
			return {
				DisplayName = "Classic",
				FirstShade = Color3.fromRGB(36, 36, 37),
				SecondShade = Color3.fromRGB(46, 46, 47),
				ThirdShade = Color3.fromRGB(78, 78, 79),
				DefaultText = Color3.new(1, 1, 1),
				DarkText = Color3.new(0, 0, 0),
				ScrollBar = Color3.fromRGB(78, 78, 79)
			};
		end,
		function()
			return {
				DisplayName = "Dark",
				Font = {
					Normal = Enum.Font.BuilderSans,
					Medium = Enum.Font.BuilderSansMedium,
					Bold = Enum.Font.BuilderSansBold,
					ExtraBold = Enum.Font.BuilderSansExtraBold,
					MonoSpace = Enum.Font.RobotoMono
				},
				Colors = {
					Background = Color3.fromRGB(19, 19, 19),
					Primary = Color3.fromRGB(88, 101, 242),
					OnPrimary = Color3.fromRGB(61, 67, 135),
					Stroke = Color3.fromRGB(45, 45, 45),
					Error = Color3.fromRGB(255, 102, 102),
					Icons = Color3.fromRGB(232, 233, 235),
					ScrollBar = {
						Thumb = Color3.fromRGB(60, 60, 60),
						Arrow = Color3.fromRGB(232, 233, 235),
						Background = Color3.fromRGB(26, 26, 26)
					},
					Buttons = {
						Holding = Color3.fromRGB(42, 42, 42),
						Default = Color3.fromRGB(34, 34, 34)
					},
					Border = {
						Holding = Color3.fromRGB(60, 60, 60),
						Default = Color3.fromRGB(38, 38, 38)
					},
					Text = {
						Default = Color3.fromRGB(255, 255, 255),
						Dark = Color3.fromRGB(200, 200, 200),
						Darker = Color3.fromRGB(175, 175, 175)
					},
					Slider = {
						SliderBar = Color3.fromRGB(1, 76, 105),
						SliderNumber = Color3.fromRGB(232, 233, 235)
					}
				}
			};
		end,
		function()
			return { DisplayName = "Light" };
		end,
		function()
			local Tb = a(39);
			local Vb = {};
			function Vb.getScale(Wb, Vb)
				return Tb.isEnabled and Vb * Tb.animationScale or 0;
			end;
			function Vb.getScrollSpeed(Wb, Vb)
				return Vb * Tb.scrollSpeed;
			end;
			return Vb;
		end,
		function()
			return {
				isEnabled = true,
				animationScale = 1,
				scrollSpeed = 1
			};
		end,
		function()
			local Vb = a(29);
			local Wb = a(13);
			local Xb = a(38);
			local Yb = Wb.UserInputService;
			local Zb = {
				[Enum.UserInputType.MouseButton1] = true,
				[Enum.UserInputType.Touch] = true
			};
			local _c = {
				[Enum.UserInputType.MouseMovement] = true,
				[Enum.UserInputType.Touch] = true
			};
			local ac = 0.28;
			local bc = {};
			bc.__index = bc;
			function bc.addGuiObject(Xb, Wb)
				local Yb = nil;
				local function _c()
					Xb.isDragging = false;
					Xb.draggingObject = nil;
					Xb.dragStart = nil;
					Xb.startPos = nil;
					if Yb then
						Yb:Disconnect();
					end;
				end;
				local function ac()
					while Xb.draggingObject == Wb do
						if tick() - Xb.lastActivity >= 1 then
							_c();
						end;
						task.wait();
					end;
				end;
				Vb:Connect(Wb.InputBegan, function(bc)
					if not Zb[bc.UserInputType] then
						return;
					end;
					if Xb.isDragging then
						return;
					end;
					Xb.dragStart = bc.Position;
					Xb.startPos = Wb.Position;
					Xb.isDragging = true;
					Xb.draggingObject = Wb;
					Xb.lastActivity = tick();
					task.spawn(ac);
					Yb = bc.Changed:Connect(function()
						if bc.UserInputState == Enum.UserInputState.End then
							_c();
						end;
					end);
				end);
			end;
			function bc.update(ec, cc, dc)
				local fc = dc.Position - ec.dragStart;
				local gc = ec._uiScale and ec._uiScale.Scale or 1;
				local hc = cc.Position;
				ec.lastActivity = tick();
				local ic = UDim2.new(ec.startPos.X.Scale, ec.startPos.X.Offset + fc.X / gc, ec.startPos.Y.Scale, ec.startPos.Y.Offset + fc.Y / gc);
				if ec.filters[cc] ~= nil then
					local dc = ec.filters[cc](ic, gc);
					ic = dc or ic;
				end;
				local jc = Xb:getScale(ac);
				cc.Position = hc:Lerp(ic, jc);
			end;
			function bc.canDragObject(fc, dc)
				return not fc.isDragging or fc.draggingObject == dc;
			end;
			function bc.setFilter(hc, dc, fc)
				hc.filters[dc] = fc;
			end;
			function bc.new(dc)
				local fc = setmetatable({
					isDragging = false,
					draggingObject = nil,
					_uiScale = dc,
					dragStart = nil,
					startPos = nil,
					filters = {}
				}, bc);
				Vb:Connect(Yb.InputChanged, function(dc)
					if fc.isDragging and _c[dc.UserInputType] then
						fc:update(fc.draggingObject, dc);
					end;
				end);
				return fc;
			end;
			return bc;
		end,
		function()
			return {
				NEW_YEAR = "\240\159\142\134",
				VALENTINE_DAYS = "\240\159\146\157",
				CLOVER = "\226\152\152\239\184\143",
				HALLOWEEN = "\240\159\142\131",
				CHRISTMAS = "\240\159\142\132",
				EASTER = "\240\159\165\154"
			};
		end,
		function()
			return {
				uiScale = Instance.new("UIScale"),
				getScale = function(hc)
					local jc = hc.uiScale;
					return jc and jc.Scale or 1;
				end,
				setScale = function(hc, jc)
					local kc = hc.uiScale;
					if kc then
						kc.Scale = jc;
					end;
				end
			};
		end,
		function()
			local hc = a(29);
			local lc = a(13);
			local mc = a(30);
			local nc = a(44);
			local oc = a(32);
			local pc = a(46);
			local qc = a(42);
			local rc = a(17);
			local sc = a(47);
			local tc = lc.UserInputService;
			local uc = {};
			uc.__index = uc;
			local function vc(hc)
				return sc.pressingInputs[hc.UserInputType] ~= nil;
			end;
			function uc.awake(lc)
				local mc = nc:getMouse();
				local pc = lc.scrollThumbFrame;
				local qc = lc.scrollThumb;
				local rc = lc.scrollBar;
				local uc = false;
				local wc = false;
				local xc = nil;
				local function yc(mc, pc)
					local function qc()
						if uc then
							return;
						end;
						if not lc:canScroll(pc) then
							return;
						end;
						uc = true;
						lc:scrollToDirection(pc);
						local mc;
						mc = hc:Connect(tc.InputEnded, function(qc)
							if not vc(qc) then
								return;
							end;
							mc:Disconnect();
							uc = false;
						end);
						task.wait(0.4);
						while lc:canScroll(pc) and uc do
							lc:scrollToDirection(pc);
							task.wait(0.066666666666666666);
						end;
					end;
					hc:Connect(mc.MouseButton1Down, qc);
				end;
				yc(lc.upButton, "up");
				yc(lc.downButton, "down");
				hc:Connect(rc.MouseWheelForward, function()
					lc:scrollTo(lc.index - lc.wheelIncrement);
				end);
				hc:Connect(rc.MouseWheelBackward, function()
					lc:scrollTo(lc.index + lc.wheelIncrement);
				end);
				hc:Connect(rc.InputBegan, function(rc)
					if not vc(rc) then
						return;
					end;
					if lc.isScrollBarDisabled then
						return;
					end;
					local xc = not nc:isMouseInGuiObject(qc);
					local yc = lc.isHorizontal and "X" or "Y";
					local zc = nil;
					wc = true;
					oc:updateObjectProperties(qc, { BackgroundColor3 = "Colors.Primary" });
					local Ac = mc[yc] - qc.AbsolutePosition[yc];
					local Bc;
					local Cc;
					local function Dc()
						if Bc then
							Bc:Disconnect();
						end;
						if Cc then
							Cc:Disconnect();
						end;
					end;
					Bc = hc:Connect(tc.InputEnded, function(rc)
						if not vc(rc) then
							return;
						end;
						Dc();
						wc = false;
						oc:updateObjectProperties(qc, { BackgroundColor3 = "Colors.OnPrimary" });
					end);
					if xc then
						local function rc()
							local rc = mc[yc] >= qc.AbsolutePosition[yc] + qc.AbsoluteSize[yc] and 1 or 0;
							local xc = lc.visibleSpace - 1;
							if rc == 0 and mc[yc] < qc.AbsolutePosition[yc] then
								lc:scrollTo(lc.index - xc);
							elseif rc == 1 and mc[yc] >= qc.AbsolutePosition[yc] + qc.AbsoluteSize[yc] then
								lc:scrollTo(lc.index + xc);
							end;
						end;
						while wc do
							rc();
							task.wait(0.25);
						end;
						return;
					end;
					Cc = hc:Connect(tc.InputChanged, function(Ec)
						if not wc then
							return;
						end;
						if not vc(Ec) then
							return;
						end;
						local Fc = pc.AbsoluteSize[yc] - qc.AbsoluteSize[yc];
						local Gc = (mc[yc] - pc.AbsolutePosition[yc]) - Ac;
						if Gc > Fc then
							Gc = Fc;
						elseif Gc < 0 then
							Gc = 0;
						end;
						if zc ~= Gc then
							zc = Gc;
							lc:scrollTo(math.floor(0.5 + (Gc / Fc) * (lc.totalSpace - lc.visibleSpace)));
						end;
					end);
				end);
			end;
			function uc.create(Ec)
				Ec.upButton = mc.new("ImageButton", Ec.upButtonName, {
					BackgroundTransparency = 1,
					AutoButtonColor = false
				});
				Ec.downButton = mc.new("ImageButton", Ec.downButtoName, {
					BackgroundTransparency = 1,
					AutoButtonColor = false
				});
				Ec:createButtonsArrows();
				local Hc = mc.new("Frame", "ScrollBar", {
					Active = true,
					BackgroundTransparency = 1,
					Ec.upButton,
					Ec.downButton,
					mc.new("Frame", "ScrollThumbFrame", {
						BackgroundTransparency = 1,
						AnchorPoint = Ec.isHorizontal and Vector2.new(0.5, 0) or Vector2.new(0, 0.5),
						Position = Ec.isHorizontal and UDim2.fromScale(0.5, 0) or UDim2.fromScale(0, 0.5),
						mc.new("Frame", "ScrollThumb", {
							AnchorPoint = Ec.isHorizontal and Vector2.new(0, 0.5) or Vector2.new(0.5, 0),
							ThemeTag = { BackgroundColor3 = "Colors.OnPrimary" },
							mc.new("UICorner", { CornerRadius = UDim.new(0, 4) })
						}),
						mc.new("Frame", "MarkerFrame", {
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1)
						})
					})
				});
				Ec.scrollBar = Hc;
				Ec.scrollThumbFrame = Hc.ScrollThumbFrame;
				Ec.scrollThumb = Hc.ScrollThumbFrame.ScrollThumb;
				Ec.markerFrame = Hc.ScrollThumbFrame.MarkerFrame;
				Ec.container = mc.new("Frame", "Container", {
					BackgroundTransparency = 1,
					ClipsDescendants = true,
					Active = true
				});
				Ec:setScrollBarThickness(Ec.barThickness);
				Ec:awake();
				Ec:update();
				return Hc;
			end;
			function uc.createButtonsArrows(Ec)
				local Hc = Ec.downButton;
				local Ic = Ec.upButton;
				(pc(4, 0.55, Hc.Name)).Parent = Hc;
				(pc(4, 0.55, Ic.Name)).Parent = Ic;
			end;
			function uc.canScrollUp(Ec)
				if Ec.isScrollBarDisabled then
					return false;
				end;
				return Ec.index > 0;
			end;
			function uc.canScrollDown(Ec)
				if Ec.isScrollBarDisabled then
					return false;
				end;
				return Ec.index + Ec.visibleSpace < Ec.totalSpace;
			end;
			function uc.canScroll(Hc, Ec)
				if Ec == "up" or Ec == "left" then
					return Hc:canScrollUp();
				elseif Ec == "down" or Ec == "right" then
					return Hc:canScrollDown();
				end;
				return false;
			end;
			function uc.getScrollPercent(Ec)
				local Ic = Ec.totalSpace - Ec.visibleSpace;
				if Ic <= 0 then
					return 0;
				end;
				return Ec.index / Ic;
			end;
			function uc.scrollTo(Jc, Ec, Ic)
				local Kc = math.max(0, Jc.totalSpace - Jc.visibleSpace);
				Jc.index = math.clamp(Ec, 0, Kc);
				Jc:update();
				if not Ic then
					Jc.scrolledSignal:Fire(Jc.index);
				end;
			end;
			function uc.scrollUp(Ec)
				Ec:scrollTo(Ec.index - Ec.increment);
			end;
			function uc.scrollDown(Ec)
				Ec:scrollTo(Ec.index + Ec.increment);
			end;
			function uc.scrollToDirection(Ic, Ec)
				if Ec == "up" or Ec == "left" then
					return Ic:scrollUp();
				elseif Ec == "down" or Ec == "right" then
					return Ic:scrollDown();
				end;
			end;
			function uc.isVisible(Kc, Ec)
				local Lc = Kc.index;
				if Ec >= Lc and Ec < Lc + Kc.visibleSpace then
					return true;
				end;
				return false;
			end;
			function uc.setScrollPercent(Kc, Ec)
				local Lc = Kc.totalSpace - Kc.visibleSpace;
				Kc:scrollTo(math.floor(Ec * Lc));
			end;
			function uc.update(Ec)
				Ec:drawThumb();
			end;
			function uc.setScrollBarThickness(Kc, Ec)
				local Lc = Kc.scrollThumbFrame;
				local Mc = Kc.downButton;
				local Nc = Kc.container;
				local Oc = Kc.scrollBar;
				local Pc = Kc.upButton;
				Kc.barThickness = Ec;
				if Nc then
					Nc.Size = UDim2.new(1, Kc.isHorizontal and 0 or - Ec, 1, Kc.isHorizontal and - Ec or 0);
				end;
				if Oc then
					Oc.Size = Kc.isHorizontal and UDim2.new(1, 0, 0, Ec) or UDim2.new(0, Ec, 1, 0);
					Oc.Position = Kc.isHorizontal and UDim2.new(0, 0, 1, - Ec) or UDim2.new(1, - Ec, 0, 0);
				end;
				if Lc then
					Lc.Size = Kc.isHorizontal and UDim2.new(1, - (Ec * 2), 0, Ec) or UDim2.new(0, Ec, 1, - (Ec * 2));
				end;
				if Mc then
					Mc.Size = UDim2.fromOffset(Ec, Ec);
					Mc.Position = Kc.isHorizontal and UDim2.new(1, - Ec, 0, 0) or UDim2.new(0, 0, 1, - Ec);
				end;
				if Pc then
					Pc.Size = UDim2.fromOffset(Ec, Ec);
					Pc.Position = UDim2.fromOffset(0, 0);
				end;
			end;
			function uc.updateArrowTransparency(Sc, Qc, Rc)
				if not Qc:FindFirstChild("Arrow") then
					return;
				end;
				for Qc, Sc in Qc.Arrow:GetChildren() do
					if not Sc:IsA("GuiObject") then
						continue;
					end;
					Sc.Transparency = Rc and 0.6 or 0;
				end;
			end;
			function uc.drawThumb(Qc)
				local Sc = Qc.scrollThumb;
				local Tc = Qc.scrollThumbFrame;
				local Uc = Qc:canScrollUp();
				local Vc = Qc:canScrollDown();
				Qc:updateArrowTransparency(Qc.upButton, not Uc);
				Qc:updateArrowTransparency(Qc.downButton, not Vc);
				if not Sc or not Tc then
					return;
				end;
				if not Uc and not Vc then
					Sc.Visible = false;
					return;
				end;
				Sc.Visible = true;
				local Wc = Qc:getScrollPercent();
				local Xc = qc:getScale();
				local Yc = Qc.barThickness;
				if Qc.isHorizontal then
					local Uc = Tc.AbsoluteSize.X / Xc;
					local Vc = math.max(Yc, (Qc.visibleSpace / Qc.totalSpace) * Uc);
					Sc.Size = UDim2.new(0, Vc, 1, -2);
					Sc.Position = UDim2.new(0, Wc * (Uc - Vc), 0.5, 0);
				else
					local Uc = Tc.AbsoluteSize.Y / Xc;
					local Vc = math.max(Yc, (Qc.visibleSpace / Qc.totalSpace) * Uc);
					Sc.Size = UDim2.new(1, -2, 0, Vc);
					Sc.Position = UDim2.new(0.5, 0, 0, Wc * (Uc - Vc));
				end;
			end;
			function uc.addMarker(Zc, Uc, Vc)
				Zc.markers[Uc] = Vc or Color3.new(1, 1, 0);
				Zc:updateMarkers();
			end;
			function uc.removeMarker(Vc, Uc)
				Vc.markers[Uc] = nil;
				Vc:updateMarkers();
			end;
			function uc.updateMarkers(Uc)
				local Vc = Uc.markerFrame;
				if not Vc then
					return;
				end;
				for Uc, Vc in pairs(Vc:GetChildren()) do
					Vc:Destroy();
				end;
				for Zc, _d in pairs(Uc.markers) do
					if Zc >= Uc.totalSpace then
						continue;
					end;
					local ad = Instance.new("Frame");
					ad.BackgroundColor3 = _d;
					ad.BorderSizePixel = 0;
					ad.BackgroundTransparency = 0;
					ad.Parent = Vc;
					local bd = Zc / Uc.totalSpace;
					if Uc.isHorizontal then
						ad.Position = UDim2.new(bd, 0, 1, -4);
						ad.Size = UDim2.new(0, 2, 0, 4);
					else
						ad.Position = UDim2.new(1, -4, bd, 0);
						ad.Size = UDim2.new(0, 4, 0, 2);
					end;
					ad.Name = "Marker_" .. tostring(Zc);
				end;
			end;
			function uc.setTotalSpace(_d, Zc)
				_d.totalSpace = Zc;
				_d:scrollTo(_d.index, true);
				_d:update();
			end;
			function uc.setVisibleSpace(_d, Zc)
				_d.visibleSpace = Zc;
				_d:scrollTo(_d.index, true);
				_d:update();
			end;
			function uc.disableScroll(Zc)
				Zc.isScrollBarDisabled = true;
				Zc:drawThumb();
			end;
			function uc.enableScroll(Zc)
				Zc.isScrollBarDisabled = false;
				Zc:drawThumb();
			end;
			function uc.new(Zc)
				local _d = setmetatable({
					isHorizontal = Zc.isHorizontal or false,
					increment = Zc.increment or 1,
					wheelIncrement = Zc.wheelIncrement or 3,
					barThickness = Zc.barThickness or 16,
					isScrollBarDisabled = false,
					index = 0,
					visibleSpace = Zc.visibleSpace or 0,
					totalSpace = Zc.totalSpace or 0,
					markers = {},
					scrollBar = Zc.scrollBar or nil,
					scrollThumb = Zc.scrollThumb or nil,
					scrollThumbFrame = Zc.scrollThumbFrame or nil,
					markerFrame = Zc.markerFrame or nil,
					scrolledSignal = rc.new()
				}, uc);
				_d.upButtonName = _d.isHorizontal and "left" or "up";
				_d.downButtoName = _d.isHorizontal and "right" or "down";
				return _d;
			end;
			return uc;
		end,
		function()
			local Zc = a(45);
			local _d = a(8);
			local cd = Zc:GetMouse();
			local dd = {};
			function dd.getMouse(Zc)
				return cd;
			end;
			function dd.isMouseInGuiObject(_d, Zc)
				local dd = Zc.AbsolutePosition;
				local ed = Zc.AbsoluteSize;
				return cd.X >= dd.X and (cd.X < dd.X + ed.X and (cd.Y >= dd.Y and cd.Y < dd.Y + ed.Y));
			end;
			function dd.isAlive(Zc)
				local _d = Zc:getHumanoid();
				return _d and _d.Health > 0;
			end;
			function dd.getCharacter(_d)
				return Zc.Character;
			end;
			function dd.getHumanoid(_d)
				local dd = _d:getCharacter();
				return dd and dd:FindFirstChildOfClass("Humanoid");
			end;
			function dd.resetCharacter(_d)
				local dd = Zc.Character;
				if not dd then
					return;
				end;
				if dd.Humanoid then
					dd.Humanoid:ChangeState(Enum.HumanoidStateType.Dead);
				else
					dd:BreakJoints();
				end;
			end;
			function dd.getPlayersByName(ed, _d)
				local fd = {};
				local gd = # _d;
				_d = _d:lower();
				for ed, hd in players:GetPlayers() do
					local id = (string.lower(hd.Name)):sub(1, gd);
					local jd = (string.lower(hd.displayName)):sub(1, gd);
					if id == _d or jd == _d then
						table.insert(fd, hd);
					end;
				end;
				return fd;
			end;
			return dd;
		end,
		function()
			local ed = a(13);
			return ed.Players.LocalPlayer;
		end,
		function()
			local ed = a(30);
			local id = {
				up = function(ed, id)
					local jd = 1 / ed;
					local kd = id / ed;
					local ld = UDim2.fromScale(kd, jd);
					local md = UDim2.fromScale(0.5 - kd / 2, (id - 1) * jd);
					return ld, md;
				end,
				down = function(ed, id)
					local jd = 1 / ed;
					local kd = id / ed;
					local ld = UDim2.fromScale(kd, jd);
					local md = UDim2.fromScale(0.5 - kd / 2, 1 - id * jd);
					return ld, md;
				end,
				left = function(ed, id)
					local jd = 1 / ed;
					local kd = id / ed;
					local ld = UDim2.fromScale(jd, kd);
					local md = UDim2.fromScale((id - 1) * jd, 0.5 - kd / 2);
					return ld, md;
				end,
				right = function(ed, id)
					local jd = 1 / ed;
					local kd = id / ed;
					local ld = UDim2.fromScale(jd, kd);
					local md = UDim2.fromScale(1 - id * jd, 0.5 - kd / 2);
					return ld, md;
				end
			};
			return function(jd, kd, ld)
				local md = id[ld];
				if not md then
					error("r u ok? Invalid direction: " .. tostring(ld));
				end;
				local nd = ed.new("Frame", "Arrow", {
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					ed.new("UIScale", { Scale = kd })
				});
				for kd = 1, jd do
					local od, pd = md(jd, kd);
					ed.new("Frame", `line_{kd}`, {
						BackgroundColor3 = Color3.fromRGB(220, 220, 220),
						BorderSizePixel = 0,
						Size = od,
						Position = pd,
						Parent = nd,
						ThemeTag = { BackgroundColor3 = "Colors.Icons" }
					});
				end;
				return nd;
			end;
		end,
		function()
			return {
				pressingInputs = {
					[Enum.UserInputType.MouseButton1] = true,
					[Enum.UserInputType.Touch] = true
				}
			};
		end,
		function()
			local kd = a(29);
			local od = a(13);
			local pd = a(44);
			local qd = a(30);
			local rd = a(49);
			local sd = a(4);
			local td = a(50);
			local ud = a(47);
			local vd = a(10);
			local wd = a(15);
			local xd = a(17);
			local yd = a(42);
			local zd = vd.commands;
			local Ad = zd.placeholderText;
			local Bd = zd.padding;
			local Cd = zd.labelSize;
			local Dd = zd.textSize;
			local Ed = od.UserInputService;
			local Fd = od.RunService;
			local Gd = {};
			Gd.__index = Gd;
			local function Hd(kd)
				return ud.pressingInputs[kd.UserInputType] ~= nil;
			end;
			local function Id(kd)
				return wd.lookup[kd];
			end;
			local function Jd(kd)
				return math[kd < 0 and "ceil" or "floor"](kd);
			end;
			function Gd.awake(od)
				local pd = od.commandInput;
				local qd = od.searchBox;
				local rd = od.searchBoxHolder;
				local sd = od.inputMarker;
				local td = rd.Input;
				local vd = rd.Placeholder;
				local xd = qd:GetPropertyChangedSignal("Text");
				local yd = td:GetPropertyChangedSignal("TextBounds");
				local zd = 0;
				local function Ad()
					if tick() - zd > 0.5 then
						sd.Visible = not sd.Visible;
						zd = tick();
					end;
				end;
				od.commandClickedSignal:Connect(function(od)
					qd.Text = od.aliases[1];
					task.defer(function()
						qd:CaptureFocus();
					end);
				end);
				kd:Connect(rd.Activated, function()
					qd:CaptureFocus();
				end);
				kd:Connect(qd.Focused, function()
					vd.Visible = false;
					od.markerConnection = kd:Connect(Fd.Stepped, Ad);
				end);
				kd:Connect(qd.FocusLost, function(rd)
					sd.Visible = false;
					kd:disconnect(od.markerConnection);
					if not rd then
						return;
					end;
					if pd.isValidCommand then
						od:sendInputCommand();
						return;
					end;
					if pd.bestMatch then
						local rd = Id(pd.bestMatch);
						od.commandClickedSignal:Fire(rd);
					end;
				end);
				kd:Connect(xd, function()
					local rd = qd.Text;
					local td = od.parser:parse(rd);
					od.parser:highlight(td);
					od:updateSearchBoxHighlight();
					od:updateSearchedCommand();
				end);
			end;
			function Gd.sendInputCommand(rd)
				local td = rd.commandInput;
				for xd, yd in td.commandData.args do
					if yd.optional then
						continue;
					end;
					local Bd = td.args[xd];
					if Bd and Bd.success then
						print(`arg {xd}: {Bd and Bd.value}`);
						continue;
					end;
					local Cd = Bd and "invalid" or "missing";
					local Dd = yd.name and (`'{rd.parser.removeWhiteSpace(yd.name)}'`) or `#{xd}`;
					rd:setComment(` - {Dd} is {Cd}`, "error");
					return;
				end;
				local xd = (Id(td.commandName)).name;
				sd:run(xd, td.args);
			end;
			function Gd.create(yd)
				yd.searchBoxHolder = qd.new("ImageButton", {
					Size = UDim2.new(1, -10, 0, 18),
					Position = UDim2.fromScale(0.5, 0),
					AnchorPoint = Vector2.new(0.5, 1),
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ThemeTag = { BackgroundColor3 = "Colors.Buttons.Default" },
					qd.new("UICorner", { CornerRadius = UDim.new(0, 6) }),
					qd.new("TextLabel", "Input", {
						Size = UDim2.fromScale(0, 1),
						Position = UDim2.new(0, 5, 0.5, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						TextSize = Dd,
						Visible = false,
						RichText = true,
						ThemeTag = {
							TextColor3 = "Colors.Text.Default",
							Font = "Font.MonoSpace"
						},
						qd.new("Frame", "Holder", {
							Size = UDim2.fromScale(0, 1),
							Position = UDim2.fromScale(1, 0)
						})
					}),
					qd.new("TextLabel", "Placeholder", {
						Size = UDim2.new(1, -5, 1, 0),
						Position = UDim2.new(0, 5, 0.5, 0),
						AnchorPoint = Vector2.new(0, 0.5),
						TextXAlignment = Enum.TextXAlignment.Left,
						TextYAlignment = Enum.TextYAlignment.Center,
						BackgroundTransparency = 1,
						TextSize = Dd - 1,
						Text = Ad,
						ThemeTag = {
							TextColor3 = "Colors.Text.Dark",
							Font = "Font.MonoSpace"
						}
					})
				});
				local Cd = yd.searchBoxHolder;
				local Ed = Cd.Input.Holder;
				yd.inputMarker = qd.new("Frame", "Marker", Ed, {
					Size = UDim2.new(0, 1.5, 1, -3),
					Position = UDim2.new(1, 0.2, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BorderSizePixel = 0,
					Visible = false,
					ThemeTag = { BackgroundColor3 = "Colors.Primary" }
				});
				yd.inputComment = qd.new("TextLabel", "Comment", Ed, {
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromScale(1, 0.5),
					AnchorPoint = Vector2.new(0, 0.5),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Center,
					BackgroundTransparency = 1,
					TextSize = Dd,
					RichText = true,
					Text = "",
					ThemeTag = {
						TextColor3 = "Colors.Text.Default",
						Font = "Font.MonoSpace"
					}
				});
				yd.commandInfo = qd.new("TextLabel", "Info", {
					Size = UDim2.new(1, -25, 0, 0),
					Position = UDim2.new(0, 10, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					TextYAlignment = Enum.TextYAlignment.Center,
					TextXAlignment = Enum.TextXAlignment.Left,
					Font = textFont,
					TextSize = Dd - 5,
					Visible = false,
					qd.new("UICorner", { CornerRadius = UDim.new(0, 4) }),
					ThemeTag = {
						BackgroundColor3 = "Colors.Buttons.Default",
						TextColor3 = "Colors.Text.Default"
					}
				});
				yd.searchBox = qd.new("TextBox", "SearchBox", {
					BackgroundTransparency = 1,
					TextTransparency = 1,
					Size = UDim2.fromScale(1, 0),
					Position = UDim2.fromScale(0, 0.4),
					ClearTextOnFocus = false,
					ShowNativeInput = false,
					TextSize = 0,
					Text = ""
				});
				yd.commandsFolder = qd.new("Folder", "Commands");
			end;
			function Gd.createCommandsData(yd)
				for Cd, Ed in wd.original do
					local Gd = rd.new(Ed);
					Ed.commandData = Gd;
					Gd.position = Cd - 1;
					table.insert(yd.commandsData, Gd);
				end;
			end;
			function Gd.updateSearchBoxHighlight(Cd)
				local Ed = Cd.commandInput.highlightText;
				local Gd = Cd.searchBoxHolder;
				local Hd = Gd.Input;
				local Jd = yd:getScale();
				Hd.Text = Ed;
				Hd.Visible = # Ed > 0;
				local Kd = Gd.AbsoluteSize.X * Jd;
				local Ld = Kd / 2;
				local Md = Hd.AbsoluteSize.X * Jd;
				if Md <= Ld then
					Hd.AnchorPoint = Vector2.new(0, 0.5);
					Hd.Position = UDim2.new(0, 5, 0.5, 0);
				else
					Hd.AnchorPoint = Vector2.new(1, 0.5);
					Hd.Position = UDim2.new(0.5, 0, 0.5, 0);
				end;
			end;
			function Gd.updateSearchedCommand(Cd)
				local Ed = Cd.commandInput.bestMatch;
				local Gd = Cd.commandInput.commandName;
				if Gd == "" then
					return;
				end;
				local Jd = Id(Gd) or Ed and Id(Ed);
				if Jd then
					Cd.scrollBar:scrollTo(Jd.commandData.position);
				end;
			end;
			function Gd.setComment(Kd, Ed, Gd)
				if Gd ~= nil then
					Ed = td.colorFromName(Ed, Gd);
				end;
				Kd.inputComment.Text = Ed;
				Kd.inputComment.Visible = # Ed > 0;
			end;
			function Gd.updateElements(Kd)
				local Ld = 0;
				local Md = 0;
				local Nd = {};
				local Od = Kd.scrollBar;
				local Pd = Kd.commandsFolder;
				for Qd, Rd in Kd.commandsData do
					local Sd = Od:isVisible(Rd.position);
					if not Sd then
						if Rd.element then
							Rd.element.Parent = nil;
						end;
						continue;
					end;
					local Td = Rd.element;
					if not Td then
						Td = Kd:createCommandElement(Rd);
						Rd.element = Td;
					end;
					if not Rd.isSection then
						if # Rd.name > Md then
							Md = # Rd.name;
						end;
						table.insert(Nd, Rd);
					end;
					Td.Parent = Pd;
					Td.Position = UDim2.fromOffset(0, Ld * (Td.Size.Y.Offset + Bd));
					Ld += 1;
				end;
				for Qd, Sd in Nd do
					Kd:updateDisplayName(Sd, Md + 3);
				end;
				Kd.visibleCommands = Nd;
			end;
			function Gd.setCommandInfo(Sd, Qd)
				Qd = Qd or "";
				if Qd == "" then
					Sd.commandInfo.Visible = false;
					return;
				end;
				Sd.commandInfo.Visible = true;
				Sd.commandInfo.Text = Qd;
			end;
			function Gd.getArgsText(Ud, Qd)
				local Vd = Qd.args;
				if # Vd == 0 then
					return "";
				end;
				local Wd = {};
				for Qd, Vd in Vd do
					table.insert(Wd, Ud:getHighlightArg(Vd));
				end;
				return `({table.concat(Wd, ", ")})`;
			end;
			function Gd.getHighlightArg(Vd, Qd)
				local Xd = Qd.optional and td.colorFromName("?", "symbol") or "";
				local Yd = `{td.colorFromName(Qd.kind, Qd.kind)}{Xd}`;
				if Qd.name then
					local Xd = Vd.parser.removeWhiteSpace(Qd.name);
					return `{Xd}: {Yd}`;
				end;
				return Yd;
			end;
			function Gd.createSection(Zd, Xd)
				return qd.new("Frame", {
					Size = UDim2.new(1, -10, 0, Cd),
					Position = UDim2.new(0, 5, 0, 0),
					BackgroundTransparency = 1
				});
			end;
			function Gd.createCommandElement(Zd, Xd)
				if Xd.isSection then
					return Zd:createSection(Xd);
				end;
				local _e = qd.new("TextLabel", "Command", {
					Size = UDim2.fromScale(0, 1),
					Position = UDim2.fromOffset(5, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					AutomaticSize = Enum.AutomaticSize.X,
					RichText = true,
					TextSize = Dd,
					ThemeTag = {
						TextColor3 = "Colors.Text.Default",
						Font = "Font.MonoSpace"
					}
				});
				return qd.new("Frame", {
					Size = UDim2.new(1, 0, 0, Cd),
					AutomaticSize = Enum.AutomaticSize.X,
					BackgroundTransparency = 1,
					_e
				});
			end;
			function Gd.createCommandDescription(ae, _e)
				if _e.isSection then
					return;
				end;
				if not _e.description then
					return;
				end;
				local be = qd.new("TextLabel", "Description", {
					Size = UDim2.fromScale(1, 1),
					Position = UDim2.fromOffset(25, 0),
					BackgroundTransparency = 1,
					TextXAlignment = Enum.TextXAlignment.Left,
					RichText = true,
					TextSize = Dd,
					ThemeTag = {
						TextColor3 = "Colors.Text.Dark",
						Font = "Font.MonoSpace"
					}
				});
				return qd.new("Frame", "Description", {
					Size = UDim2.new(1, -30, 0, Cd),
					BackgroundTransparency = 1,
					be
				});
			end;
			function Gd.updateDisplayName(be, _e, ae)
				if _e.isHolding then
					return;
				end;
				local ce = _e.element;
				local de = _e.name;
				local ee = string.rep("\226\128\148", (ae - # de) - 2);
				local fe = `{de} {td.colorFromName(ee, "comment")} `;
				local ge = _e.argsHighlightText or be:getArgsText(_e);
				_e.argsHighlightText = ge;
				ce.Command.Text = fe .. ge;
			end;
			function Gd.setCommandText(be, _e, ae)
				local ce = _e.element;
				if not ce then
					return;
				end;
				ce.Command.Text = ae;
			end;
			function Gd.getCommandText(ae, _e)
				local be = _e.element;
				return be and be.Command.Text or "";
			end;
			function Gd.calculateTotalSpace(_e)
				return # _e.commandsData;
			end;
			function Gd.calculateVisibleSpace(_e)
				local ae = _e.scrollContainer.AbsoluteSize.Y * yd:getScale();
				return math.floor(ae / _e:calculateLabelSize());
			end;
			function Gd.calculateLabelSize(_e)
				return Bd + Cd;
			end;
			function Gd.getElementMouseIn(_e)
				for _e, ae in _e.visibleCommands do
					if pd:isMouseInGuiObject(ae.element) then
						return ae;
					end;
				end;
			end;
			function Gd.horizontalScroll(be, _e)
				for be, ce in be.visibleCommands do
					local de = ce.element;
					de.Position = UDim2.fromOffset(math.min(de.Position.X.Offset + _e, 0), de.Position.Y.Offset);
				end;
			end;
			function Gd.startedHoldingContainer(ce, be)
				if ce.isPressingContainer then
					return;
				end;
				if not Hd(be) then
					return;
				end;
				ce.isPressingContainer = true;
				ce.scrollAxis = nil;
				ce.scrollBar:disableScroll();
				local de = pd:getMouse();
				local ee = ce:calculateLabelSize();
				local fe = ce:getElementMouseIn();
				local ge = tick();
				local he = nil;
				if fe and fe.description then
					fe.isHolding = true;
					local be = ce.parser.colorFromName(fe.description, "comment");
					he = ce:getCommandText(fe);
					ce:setCommandText(fe, be);
				end;
				local ie = de.Y;
				local je = de.X;
				local ke, le;
				local function me()
					ce.scrollBar:enableScroll();
					if fe then
						fe.isHolding = nil;
						if he then
							ce:setCommandText(fe, he);
						end;
						if tick() - ge <= 0.15 then
							ce.commandClickedSignal:Fire(fe);
						end;
					end;
					if le then
						le:Disconnect();
					end;
					if ke then
						ke:Disconnect();
					end;
				end;
				le = kd:Connect(Ed.InputEnded, function(be)
					if not Hd(be) then
						return;
					end;
					me();
					ce.isPressingContainer = false;
				end);
				ke = kd:Connect(Ed.InputChanged, function(be)
					if not Hd(be) then
						return;
					end;
					local ne = de.X - je;
					local oe = de.Y - ie;
					if not ce.scrollAxis then
						if math.abs(ne) > 4 or math.abs(oe) > 4 then
							ce.scrollAxis = math.abs(ne) > math.abs(oe) and "x" or "y";
						end;
						return;
					end;
					if ce.scrollAxis == "x" then
						local be = Jd(ne / 3);
						if math.floor(be) ~= 0 then
							ce:horizontalScroll(be);
							je = de.X;
						end;
					else
						local pe = Jd(oe / ee);
						if math.floor(pe) ~= 0 then
							ce.scrollBar:scrollTo(ce.scrollBar.index - pe);
							ie = de.Y;
						end;
					end;
				end);
			end;
			function Gd.update(qe)
				qe.scrollBar:setVisibleSpace(qe:calculateVisibleSpace());
				qe.scrollBar:setTotalSpace(qe:calculateTotalSpace());
				qe:updateElements();
			end;
			function Gd.enable(qe)
				if qe.isEnabled then
					return;
				end;
				local re = qe.scrollContainer;
				qe.isEnabled = true;
				qe.commandsFolder.Parent = re;
				qe.searchBox.Parent = qe.scrollHolder;
				qe.searchBoxHolder.Parent = qe.scrollHolder;
				qe.commandInfo.Parent = qe.scrollHolder;
				qe.scrollConnection = qe.scrolledSignal:Connect(function()
					qe:updateElements();
				end);
				qe.containerConnection = re.InputBegan:Connect(function(re)
					qe:startedHoldingContainer(re);
				end);
				qe:update();
			end;
			function Gd.disable(re)
				if not re.isEnabled then
					return;
				end;
				re.isEnabled = false;
				re.commandsFolder.Parent = nil;
				re.searchBox.Parent = nil;
				re.searchBoxHolder.Parent = nil;
				re.commandInfo.Parent = nil;
				kd:disconnect(re.containerConnection);
				kd:disconnect(re.markerConnection);
				kd:disconnect(re.scrollConnection);
			end;
			function Gd.new(re)
				local se = setmetatable({
					scrollContainer = re.scrollContainer,
					scrolledSignal = re.scrolledSignal,
					scrollHolder = re.scrollHolder,
					scrollBar = re.scrollBar,
					commandClickedSignal = xd.new(),
					commandInput = {
						bestMatch = nil,
						bestMatches = {},
						searchResult = {},
						isValidCommand = false,
						highlightText = "",
						noHighlightText = "",
						fullCommandText = "",
						commandName = ""
					},
					visibleCommands = {},
					commandsData = {}
				}, Gd);
				se.parser = td.new(se.commandInput, function(re, te)
					return se:setComment(re, te);
				end);
				return se;
			end;
			return Gd;
		end,
		function()
			local re = {};
			re.__index = re;
			function re.new(te)
				return setmetatable({
					name = te.name,
					isSection = te.isSection,
					sectionName = te.sectionName,
					aliases = te.aliases,
					args = te.args,
					name = te.name,
					description = te.description
				}, re);
			end;
			return re;
		end,
		function()
			local te = a(4);
			local ue = a(14);
			local ve = a(51);
			local we = a(15);
			local xe = a(54);
			local ye = a(24);
			local ze = a(8);
			local Ae = ye.colorFromRGB;
			local Be = ye.lookupify({
				"`",
				"'",
				"\""
			});
			local Ce = ye.lookupify({
				" ",
				"\t",
				"\n",
				"\r"
			});
			local De = ye.lookupify({
				",",
				"|",
				"&"
			});
			local function Ee(te, ue, ve)
				local we = ue;
				if te == "string" then
					we = `{ve}{we}{ve}`;
				end;
				return setmetatable({
					kind = te,
					value = ue,
					usedChar = ve
				}, {
					__tostring = function()
						return we;
					end
				});
			end;
			local function Fe(te, ue)
				local xe = {};
				for ue = 1, # te do
					table.insert(xe, tostring(te[ue]));
				end;
				return table.concat(xe, ue);
			end;
			local function Ge(ue)
				return we.lookup[ue];
			end;
			local function He(ue, ye)
				local ze = ue:find(ye);
				local Ae = ue:sub(1, ze - 1);
				local Be = ue:sub(ze + # ye, -1);
				return Ae, Be;
			end;
			local function Ie(ue, ye, ze)
				local Be = xe.args;
				return Ae(ue, Be[ye] or ze or Be.others);
			end;
			local function Je(ue)
				return ue:gsub(".", function(ue)
					return Ce[ue] and "_" or ue;
				end);
			end;
			local function Ke(ue, ye)
				local ze = ue.optional and "?" or "";
				local Be = ye and "" or ": ";
				local De = ue.kind;
				if ue.name then
					De = `{Je(ue.name)}: {De}`;
				end;
				return `{Be}({De}{ze})`;
			end;
			local Le = {};
			Le.__index = Le;
			Le.colorFromName = Ie;
			Le.removeWhiteSpace = Je;
			function Le.parse(Ge, ze)
				local He = Ge.cmdInput;
				local Ie, Ke = # ze, 0;
				local Le = {};
				local Me = {};
				local Ne = {};
				He.parsed = Le;
				while Ke < Ie do
					Ke += 1;
					local Ge = ze:sub(Ke, Ke);
					if Be[Ge] then
						local He = Ke + 1;
						local Oe = Ke;
						local Pe = false;
						while Oe do
							Oe = ze:find(Ge, Oe + 1, true);
							if Oe and ze:sub(Oe - 1, Oe - 1) ~= "\\" then
								local Qe = ze:sub(He, Oe - 1);
								local Re = Ee("string", Qe, Ge);
								table.insert(Le, Re);
								Ke = Oe;
								Pe = true;
								break;
							end;
						end;
						if Pe then
							Me, Ne = {}, {};
							continue;
						end;
					end;
					while Ke <= Ie and not Ce[Ge] do
						if De[Ge] then
							while Ke < Ie and Ce[Ge] do
								Ke += 1;
							end;
						end;
						table.insert(Me, Ge);
						Ke += 1;
						Ge = ze:sub(Ke, Ke);
					end;
					if # Me > 0 then
						table.insert(Le, Ee("identifier", table.concat(Me)));
						Me, Ne = {}, {};
					end;
					if Ge ~= "" then
						table.insert(Ne, Ge);
					end;
				end;
				local Oe = table.concat(Ne);
				local Pe = Fe(Le, " ") .. Oe;
				He.spacesAtEnd = Oe;
				He.noHighlightText = Pe;
				for Qe, Re in Le do
					Le[Qe].value = ye.escapeRichText(Re.value);
				end;
				return Le;
			end;
			function Le.parseArg(Se, Qe, Re)
				local Te = Se.cmdInput;
				local Ue = ve:validate(Qe, Re);
				if Ue.options and not Ue.success then
					local Qe = (ue:searchAtArray(Ue.options, Re))[1];
					if not Qe then
						return {
							display = Ie(Re, "error"),
							success = false
						};
					end;
					Te.correctionText = Qe;
					local Se, Ve = He(Qe, Re);
					local We = Ie(Re, "warn");
					return {
						success = false,
						display = Ie(`{Se}{We}{Ve}`, "comment")
					};
				end;
				if Ue.success then
					if Ue.value == nil then
						ze:error(`'{Qe.kind}' is returning a nil value`);
						return;
					end;
					local Se = Ue.color or "valid";
					return {
						success = true,
						value = Ue.value or Re,
						display = Ie(Ue.display or Re, Se)
					};
				end;
				Se:setComment(Ue.message, Ue.comment and "comment" or "warn");
				return {
					display = Ie(Re, Ue.color or "warn"),
					success = false
				};
			end;
			function Le.resetInput(Se)
				local Ve = Se.cmdInput;
				Ve.highlightText = "";
				Ve.commandName = "";
				Ve.isValidCommand = false;
				Ve.bestMatch = nil;
				Ve.correctionText = nil;
				Se:setComment("");
			end;
			function Le.highlight(Ve, Se)
				local We = Ve.cmdInput;
				Ve:resetInput();
				if # Se == 0 then
					return;
				end;
				local Xe = {};
				local Ye = tostring(table.remove(Se, 1));
				local Ze = Ge(Ye);
				local _f = Ze ~= nil;
				local af = _f and Ze.name ~= Ye;
				local bf = We.spacesAtEnd;
				local cf = # bf > 0;
				We.commandName = Ye;
				We.commandData = Ze;
				We.isValidCommand = _f;
				We.isAbreviated = af;
				We.args = {};
				if not _f then
					We.bestMatches = te:search(Ye);
					We.bestMatch = We.bestMatches[1];
					if cf or # Se > 0 or not We.bestMatch then
						We.highlightText = Ie(table.concat({
							Ye,
							Fe(Se, " ")
						}, " "), "error") .. bf;
						Ve:setComment(" - invalid command", "error");
						return;
					end;
				end;
				table.insert(Xe, Ie(Ye, _f and "valid" or We.bestMatch and "warn" or "error"));
				if We.bestMatch then
					local Ze, _f = He(We.bestMatch, Ye);
					local af = Xe[# Xe];
					Xe[# Xe] = Ie(`{Ze}{af}{_f}`, "comment");
					We.correctionText = Ye;
				end;
				if _f then
					local _f = # Se == 0 and # bf == 0;
					local af = false;
					local df = true;
					if _f and # Ze.aliases > 1 then
						local _f = table.clone(Ze.aliases);
						table.remove(_f, table.find(_f, Ye));
						Ve:setComment(`: [{table.concat(_f, ", ")}]`, "comment");
					end;
					for ef, ff in ipairs(Ze.args) do
						if _f then
							break;
						end;
						local gf = table.remove(Se, 1);
						if gf then
							local ef = Ve:parseArg(ff, tostring(gf));
							table.insert(Xe, ef.display or tostring(gf));
							table.insert(We.args, ef);
							if not ef.success then
								df = false;
								break;
							end;
						end;
						if af then
							continue;
						end;
						if # Se > 0 then
							continue;
						end;
						local hf = Ze.args[ef + 1];
						if cf and (gf ~= nil and not hf) then
							continue;
						end;
						local jf = (cf and gf ~= nil) and hf or ff;
						if jf then
							af = true;
							Ve:setComment(Ke(jf, cf), "comment");
						end;
					end;
					if df and # Se > 0 then
						local ef = Fe(Se, " ");
						table.insert(Xe, Ie(`<b>{ef}</b>`, "warn"));
						Ve:setComment(" - extra arg", "warn");
					end;
				end;
				local df = table.concat(Xe, " ") .. bf;
				We.highlightText = df;
				return df;
			end;
			function Le.setComment(ef, ...)
				return ef.setCommentCallback(...);
			end;
			function Le.new(ef, hf)
				return setmetatable({
					cmdInput = ef,
					setCommentCallback = hf
				}, Le);
			end;
			return Le;
		end,
		function()
			local ef = a(44);
			local hf = a(52);
			local kf = a(8);
			local lf = a(24);
			local mf = a(53);
			local nf = "$";
			local of = {};
			local function pf(ef)
				return {
					success = false,
					message = ef
				};
			end;
			local function qf(ef)
				return {
					success = true,
					value = ef,
					color = "string"
				};
			end;
			local function rf(ef)
				local hf = {
					"true",
					"false",
					"yes",
					"no",
					"enabled",
					"disabled"
				};
				local kf = table.find(hf, hf);
				return {
					success = kf ~= nil,
					value = kf and kf % 2 == 0,
					display = ef,
					options = {
						"false",
						"true"
					},
					message = " - invalid boolean",
					color = "boolean"
				};
			end;
			local sf = {
				className = true,
				player = true,
				string = qf,
				text = qf,
				boolean = rf
			};
			sf.number = function(ef, hf)
				local kf = tonumber(ef);
				local lf = {
					value = kf,
					success = false,
					display = `<b>{kf}</b>`
				};
				if kf == nil then
					lf.message = " - invalid number";
					return lf;
				end;
				if hf.clamp then
					hf.min, hf.max = hf.clamp[1], hf.clamp[2];
				end;
				if hf.min and kf < hf.min then
					lf.message = ` - the <b>MIN</b> is <b>{hf.min}</b>`;
					return lf;
				end;
				if hf.max and kf > hf.max then
					lf.message = ` - the <b>MAX</b> is <b>{hf.max}</b>`;
					return lf;
				end;
				if math.floor(kf * 1e5) / 1e5 ~= kf then
					lf.message = " - too big";
					return lf;
				end;
				lf.color = "number";
				lf.success = true;
				return lf;
			end;
			sf["nil"] = function()
				return {
					color = "boolean",
					display = "<b>nil</b>",
					success = true
				};
			end;
			sf.waypoint = function(ef)
				local kf = hf:getValue(ef);
				local mf = lf.unlookupify(hf:getData());
				return {
					success = kf ~= nil,
					options = mf,
					value = ef,
					message = " - invalid waypoint"
				};
			end;
			sf.vector3 = function(ef)
				local kf = ef:split(",");
				if # kf > 3 then
					return pf(" - too many args");
				end;
				for ef, mf in kf do
					if mf == "" then
						mf = "0";
					end;
					local nf = sf.number(mf, {});
					if not nf.success then
						return nf;
					end;
					kf[ef] = nf.value;
				end;
				if # kf ~= 3 then
					return {
						success = false,
						comment = true,
						message = `: {({
							"X",
							"Y",
							"Z"
						})[# kf + 1]}`
					};
				end;
				local mf = Vector3.new(unpack(kf));
				return {
					success = true,
					value = mf,
					display = `({mf})`,
					color = "others"
				};
			end;
			function of.validate(qf, ef, of)
				local rf = sf[ef.kind];
				if rf == true then
					return {
						success = true,
						value = of,
						display = of
					};
				end;
				if type(rf) == "function" then
					return rf(of, ef);
				end;
				return pf(` - missing parser {ef.kind}`);
			end;
			return of;
		end,
		function()
			return (a(6)).new("createdWaypoints");
		end,
		function()
			local qf = a(45);
			local tf = {
				_self = qf,
				name = qf.Name,
				id = qf.UserId,
				age = qf.AccountAge,
				position = function()
					local tf = qf.Character;
					return tf and (tf:GetPivot()).Position;
				end,
				character = function()
					return qf.Character;
				end
			};
			local uf = {
				random = function()
					local tf = players:GetPlayers();
					return tf[math.random(tf)];
				end
			};
			return {
				player = tf,
				me = tf,
				user = tf,
				players = uf
			};
		end,
		function()
			local tf = Color3.fromRGB(248, 109, 115);
			local uf = Color3.fromRGB(223, 215, 136);
			local vf = Color3.fromRGB(156, 121, 223);
			local wf = Color3.fromRGB(225, 37, 105);
			local xf = Color3.fromRGB(118, 113, 94);
			local yf = Color3.fromRGB(97, 181, 195);
			local zf = Color3.fromRGB(254, 193, 7);
			local Af = Color3.fromRGB(244, 66, 54);
			local Bf = Color3.fromRGB(166, 227, 45);
			return {
				args = {
					number = vf,
					boolean = vf,
					text = uf,
					string = uf,
					symbol = wf,
					comment = xf,
					others = yf,
					warn = zf,
					error = Af,
					valid = Bf
				}
			};
		end,
		function()
			
		end
	};
	local e = {};
	function a(b)
		if e[b] == nil then
			d[b] = d[b]();
			e[b] = b;
		end;
		return d[b];
	end;
end;
a(1);
