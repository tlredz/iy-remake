local a={cache={}}do do local b=function()local b=(getgenv or getfenv or getrenv)()local c=function(

c, d, e)
if type(d)==c then
return d
end

if e~=nil then
if e==true then
e=function(...)return...end
end

return e
end end


return setmetatable({
cloneref=c("function",cloneref,true),
setfpscap=c("function",setfpscap,function(d)
if typeof(b.FPS_CAP_THREAD)=="thread"then
task.cancel(b.FPS_CAP_THREAD)
end

b.FPS_CAP_THREAD=task.spawn(function()
local e=os.clock
local f=task.wait

local g=e()+(1/d)

while true do
f(math.max(g-e(),0))
g=e()+(1/d)
end
end)
end),
gethui=c("function",
gethui or
get_hidden_gui
),
sethiddenproperty=c("function",
sethiddenproperty or
set_hidden_property or
set_hidden_prop
),
gethiddenproperty=c("function",
gethiddenproperty or
get_hidden_property or
get_hidden_prop
),
queueteleport=c("function",
queue_on_teleport or
(syn and syn.queue_on_teleport)or
(fluxus and fluxus.queue_on_teleport)
),
httprequest=c("function",
request or
http_request or
(syn and syn.request)or
(http and http.request)or
(fluxus and fluxus.request)
),
setclipboard=c("function",
setclipboard or
toclipboard or
set_clipboard or
(Clipboard and Clipboard.set)
),
firetouchinterest=c("function",firetouchinterest),
makefolder=c("function",makefolder),
isfolder=c("function",isfolder),
getcustomasset=c("function",
getcustomasset or
getsynasset
),
hookfunction=c("function",hookfunction),
hookmetamethod=c("function",hookmetamethod),
getnamecallmethod=c("function",
getnamecallmethod or
get_namecall_method
),
checkcaller=c("function",checkcaller,
function()return false end
),
newcclosure=c("function",newcclosure),
getgc=c("function",getgc or get_gc_objects),
setthreadidentity=c("function",
setthreadidentity or
syn_context_set or
setthreadcontext or
(syn and syn.set_thread_identity)
),
replicatesignal=c("function",replicatesignal),
getconnections=c("function",
getconnections or
get_signal_cons
),
writefile=c("function",writefile),
readfile=c("function",readfile),
listfiles=c("function",listfiles),
loadstring=c("function",loadstring),
isfile=c("function",isfile,readfile and function(d)
local e,f=pcall(readfile,d)
return e and f~=nil and f~=""
end)
},{
__index=b,
__newindex=function(d,e,f)
b[e]=f
end
})end a.a=function()local c=a.cache.a if not c then c={c=b()}a.cache.a=c end return c.c end end do local b=function()
local b=a.a()

local c="IY-REMAKE-PRIVATEENV"

local d=b[c]or{}
b[c]=d

return d end a.b=function()local c=a.cache.b if not c then c={c=b()}a.cache.b=c end return c.c end end do local b=function()
return{
logText="infinite yield -> %s",
isEnabled=false
}end a.c=function()local c=a.cache.c if not c then c={c=b()}a.cache.c=c end return c.c end end do local b=function()
local b=a.c()
local c=b.logText

local d={}

d.isEnabled=function(e)
return b.isEnabled end


d.enable=function(e)
b.isEnabled=true end


d.disable=function(e)
b.isEnabled=false end


d.log=function(e, f, ...)
if not e:isEnabled()then return end
print(c:format(tostring(f)),...)end


d.debug=function(e, f, ...)
if not e:isEnabled()then return end
print(c:format(tostring(f)),...)end


d.warn=function(e, f)
if not e:isEnabled()then return end
(warn or print)(c:format(tostring(f)))end


d.error=function(e, f, g)
error(c:format(tostring(f)),g)end


d.fail=function(e, f)
e:error("failed to load: "..f)end


d.assert=function(e, f, g)
if not f then
e:error(g)
return
end
return f end


d.expect=function(e, f, g, h)
if not table.find(g,typeof(f))then
e:error((h or"")..` expected '{table.concat(g,", ")}'. got '{typeof(f)}'.`)
end end


return d end a.d=function()local c=a.cache.d if not c then c={c=b()}a.cache.d=c end return c.c end end do local b=function()
local b=a.b()
local c=a.d()

local d={}local e=function(



e)
if type(e)~="table"then return end


if type(e.stop)=="function"then
pcall(e.stop)
end

if e.running~=nil then
e.running=false
end

if typeof(e.thread)=="thread"then
pcall(task.cancel,e.thread)
end end


d.init=function(f)
if b.screenGui then
b.screenGui:Destroy()
c:log"destroyed old interface"
end

if b.connectionService then
b.connectionService:cleanup()
b.connectionService=nil
c:log"cleaned old connections"
end

for g,h in b.iyGarbages or{}do
e(h)
end

c:log"finished cleanup!"end


return d end a.e=function()local c=a.cache.e if not c then c={c=b()}a.cache.e=c end return c.c end end do local b=function()
return{
action="discord|support|help",
description="Invite to the Infinite Yield discord server.",
run=function(b)
b.executorEnv.setclipboard(b.config.links.discord)
end
}end a.f=function()local c=a.cache.f if not c then c={c=b()}a.cache.f=c end return c.c end end do local b=function()
local b=a.d()

local c={}
c.__index=c

c.encrypt=function(d, e)
b:expect(e,{"string"},"'encryptor:encrypt' #1")
local f=d.encryptKey
local g={}

for h=1,#e do
f=(f*16807)%2147483647
table.insert(g,string.format("%02X",(e:byte(h)+f%256)%256))
end

return table.concat(g)end


c.decrypt=function(d, e, f)
b:expect(e,{"string"},"'encryptor:decrypt' #1")
local g=d.encryptKey
local h={}

for i=1,#e,2 do
local j=tonumber(e:sub(i,i+1),16)
g=(g*16807)%2147483647
h[#h+1]=string.char((j-g%256+256)%256)
end

return table.concat(h)end


c.new=function(d)
b:expect(d,{"number"},"'encryptor.new' #1")

return setmetatable({
encryptKey=d
},c)end


return c end a.g=function()local c=a.cache.g if not c then c={c=b()}a.cache.g=c end return c.c end end do local b=function()
local b={}

local c=a.a()
local d=a.d()

b.__index=function(e, f)
d:expect(f,{"string"},"[index] serviceName")

local g=game:GetService(f)
local h=c.cloneref(g)

rawset(e,f,h)
return h end


return setmetatable({},b)end a.h=function()local c=a.cache.h if not c then c={c=b()}a.cache.h=c end return c.c end end do local b=function()
local b=a.h()
local c=a.d()

local d=b.HttpService
local e=d.JSONEncode
local f=d.JSONDecode

return{
encode=function(g,h)
local i,j=pcall(e,d,g)

if not i then
c:warn(`failed to encode json '{h or"unknown"}': {j}`)
return nil
end

return j
end,
decode=function(g,h)
local i,j=pcall(f,d,g)

if not i then
c:warn(`failed to decode json '{h or"unknown"}': {j}`)
return nil
end

return j
end
}end a.i=function()local c=a.cache.i if not c then c={c=b()}a.cache.i=c end return c.c end end do local b=function()
return{
privateFolder="infiniteYield",
imagePath="assets/%s.png",
encryptKey=676767
}end a.j=function()local c=a.cache.j if not c then c={c=b()}a.cache.j=c end return c.c end end do local b=function()
local b=a.a()

local c=a.g()
local d=a.d()
local e=a.i()

local f=a.j()

local g=f.privateFolder
local h=f.encryptKey

c=c.new(h)

if g:sub(#g)=="/"then
g=g:sub(1,-2)
end

local i={}
i.__index=i local j=function(

j)
local k,l=pcall(b.isfile,j)

if k and type(l)=="boolean"then
return l
end

return false end local k=function(


k)
local l,m=pcall(b.isfolder,k)

if l and type(m)=="boolean"then
return m
end

return false end local l=function(


l)
if not j(l)then
d:log(`the file '{l}' don't exist, skipped!`)
return""
end

local m,n=pcall(b.readfile,l)

if not m then
d:warn(`failed to read file '{l}':\n\t{n}`)
n=nil
end

if type(n)~="string"then
n=""
end

return n end local m=function(


m)
local n=m:split"/"
local o={}

for p,q in n do
table.insert(o,q)

local r=table.concat(o,"/")
if k(r)then continue end

local s,t=pcall(b.makefolder,r)

if not s then
d:warn(`failed to create a folder '{r}':\n\t{t}`)
end
end end local n=function(


n, o)
local p,q=pcall(b.writefile,n,o)

if p then
d:log(`successfully writed the file '{n}'!`)
else
d:warn(`failed to write file '{n}':\n\t{q}`)
end end local o=function(


o)
local p,q=pcall(b.getcustomasset,o)

if not(p and type(q)=="string")then
d:warn(`failed to get custom asset '{o}':\n\t{q}`)
return
end

return q end local p=function(


p)
local q=string.split(p,"/")
local r=table.remove(q)

return table.concat(q,"/"),r end


i.getRealPath=function(q, r)
if r:sub(1,1)~="/"then
r="/"..r
end

r=g..r
return r end


i.deep=function(q, r)
local s=q.object
local t=r:split"."
local u=table.remove(t)

for v,w in t do
local x=s[w]
if type(x)~="table"then x={}end
s[w]=x
s=x
end

return s,u end


i.setValue=function(q, r, s)
local t,u=q:deep(r)
t[u]=s end


i.getValue=function(q, r)
local s,t=q:deep(r)
return s[t]end


i.hasValue=function(q, r)
return q:getValue(r)~=nil end


i.increment=function(q, r, s)
return q:setValue(r,(q:getValue(r)or 0)+s)end


i.exist=function(q, r)
r=q:getRealPath(r)
return j(r)end


i.writeFile=function(q, r, s)
if q.filePath~=nil then
r,s=q.filePath,r
else
r=q:getRealPath(r)
end

n(r,s)end


i.register=function(q, r, s)
local t=q:getValue(r)

if typeof(t)~=typeof(s)then
t=s
q:setValue(r,t)
end

return t end


i.add=function(q, r, s)
local t=q:getValue(r)
d:expect(t,{"table"},"'userData:add' #1")

if not table.find(t,s)then
table.insert(t,s)
end end


i.save=function(q)
if q.isSaving then return end

q.isSaving=true
q.lastSave=tick()

task.delay(1,function()
local r=e.encode(q.object,q.filePath)

if q.encryptData then
r=c:encrypt(r)
end

q.isSaving=false
q:writeFile(r)
end)end


i.getCustomAsset=function(q, r)
r=q:getRealPath(r)
return o(r)end


i.getData=function(q)
return table.clone(q.object)end


i.new=function(q, r)
d:expect(q,{"string"},"'fileSystem.new' #1")
d:expect(r,{"table","nil"},"'fileSystem.new' #2")

if q:sub(-5,-1)~=".json"then
q=q..".json"
end

local s=setmetatable({
object={},
lastSave=0,
isSaving=false,

encryptData=r and r.encrypt
},i)

local t=s:getRealPath(q)
local u=p(t)

s.filePath=t
s.folderPath=u

if#u>0 then
m(u)
end

local v=l(t)

if#v>0 then
if s.encryptData then
v=c:decrypt(v)
end

local w=e.decode(v)

if type(w)~="table"then
d:warn(`the json content has been returned a unexpected value '{t}'`)
return s
end

s.object=w
end

return s end


return i end a.k=function()local c=a.cache.k if not c then c={c=b()}a.cache.k=c end return c.c end end do local b=function()
return a.k().new"settings"end a.l=function()local c=a.cache.l if not c then c={c=b()}a.cache.l=c end return c.c end end do local b=function()
return"v0.1.0"end a.m=function()local c=a.cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local b=function()
return{
owner="tlredz",
repository="iy-remake"
}end a.n=function()local c=a.cache.n if not c then c={c=b()}a.cache.n=c end return c.c end end do local b=function()
local b=a.n()

return{
discord="https://discord.gg/78ZuWSq",
github=`https://github.com/{b.owner}/{b.repository}`
}end a.o=function()local c=a.cache.o if not c then c={c=b()}a.cache.o=c end return c.c end end do local b=function()


local b=a.l()

return{
applicationName="Infinite Yield RV",
isRemakeVersion=true,
version=a.m(),
newVersionMessage="You're using an old version of Infinite Yield RV",

theme={
defaultTheme="dark",
selectedTheme=b:register("selectedTheme","dark")
},

commands={
cmdsRank={
maxTimesUsed=5,
decreasePerUse=0.25,
increasePerUse=1,
}
},

ui={
defaultTheme="Dark",
scale={
minScale=0.8,
maxScale=2.0,
current=b:register("interface.uiScale",1)
},
commands={
padding=0,
labelSize=17,
textSize=14,
placeholderText=">_ command bar"
},
window={
windowSize=UDim2.fromOffset(250,220),
draggable=true
}
},

links=a.o(),
storage=a.j(),
}end a.p=function()local c=a.cache.p if not c then c={c=b()}a.cache.p=c end return c.c end end do local b=function()
local b=a.p().ui.scale

return{
action="guiscale|uiscale",
description="Changes the size of the gui. [number] accepts decimals and whole numbers.",
args={
kind="number",
clamp={b.minScale,b.maxScale}
},
run=function(c,d)
local e=d:nextValue()
c.infiniteYield:setScale(e)
end
}end a.q=function()local c=a.cache.q if not c then c={c=b()}a.cache.q=c end return c.c end end do local b=function()
return{
action="console",
description="Opens the Roblox console",
run=function(b)
b.starterGui:SetCore("DevConsoleVisible",true)
end
}end a.r=function()local c=a.cache.r if not c then c={c=b()}a.cache.r=c end return c.c end end do local b=function()
return{
{
action="oldconsole",
description="Loads an old-themed Roblox console",
run=function(b)
b.fetchService.load("backups/console.luau","iy/oldconsole")()
end
},
{
action="explorer|dex",
description="Opens DEX by Moon",
run=function(b)
b.fetchService.load("backups/explorer.luau","iy/explorer")()
end
},
{
action="cobalt|cspy",
description="Opens Cobalt to intercept incoming and outgoing network traffic",
run=function(b)
b.fetchService.load("backups/cobalt.luau","iy/cobalt")()
end
},
{
action="remotespy|rspy",
description="Opens Simple Spy V3 to intercept remote calls from the client to the server",
run=function(b)
b.fetchService.load("backups/remotespy.luau","iy/remotespy")()
end
},
{
action="audiologger|alogger",
description="Opens Edges audio logger",
run=function(b)
b.fetchService.load("backups/audiologger.luau","iy/audiologger")()
end
}
}end a.s=function()local c=a.cache.s if not c then c={c=b()}a.cache.s=c end return c.c end end do local b=function()
return{
action="serverinfo|info",
description="Gives you info about the server",
run=function(b)
b.infiniteYield:createInfoMenu()
end
}end a.t=function()local c=a.cache.t if not c then c={c=b()}a.cache.t=c end return c.c end end do local b=function()
local b={
kind="boolean",
name="copy",
optional=true
}local c=function(

c, d, e)
if e==false then
c.executorEnv.setclipboard(d)
else
c:notify(d)
end end


return{
{
action="jobid",
description="Copies the games JobId to your clipboard, or notify",
args=b,
run=function(d,e)
local f=`roblox://placeId={game.PlaceId}&gameInstanceId={game.JobId}`
c(d,f,e:nextValue())
end
},
{
action="placeid",
description="Copies the current place id to your clipboard, or notify",
args=b,
run=function(d,e)
c(d,tostring(game.PlaceId),e:nextValue())
end
},
{
action="gameid",
description="Copies the current game id to your clipboard, or notify",
args=b,
run=function(d,e)
c(d,tostring(game.GameId),e:nextValue())
end
}
}end a.u=function()local c=a.cache.u if not c then c={c=b()}a.cache.u=c end return c.c end end do local b=function()local b=function(


b)
local c=game.CreatorId

if game.CreatorType~=Enum.CreatorType.User then
c=b.groupService:GetGroupInfoAsync(c).Owner.Id
end

return c end


return{
{
action="creatorid",
description="Notify, or copies the creators ID to your clipboard",
args={kind="boolean",name="copy",optional=true},
run=function(c,d)
local e=tostring(b(c))

if d:nextValue()then
c.executorEnv.setclipboard(e)
end

c:notify("Creator Id",`the OwnerId is '{e}'`)
end
},
{
client=true,
action="setcreatorid|setascreator",
description="Sets your userid to the creators ID",
run=function(c,d)
local e=b(c)
c.localPlayer.UserId=e
c:notify("Set ID",`Set UserId to '{e}'`)
end
}
}end a.v=function()local c=a.cache.v if not c then c={c=b()}a.cache.v=c end return c.c end end do local b=function()

return{
action="rejoin|rj",
description="Makes you rejoin the game",
run=function(b)
b.playerService:teleportToJobId(game.JobId)
end
}end a.w=function()local c=a.cache.w if not c then c={c=b()}a.cache.w=c end return c.c end end do local b=function()
return{
action="autorejoin|autorj",
description="Automatically rejoins the server if you get kicked/disconnected",
run=function(b)
if b.privateEnv.autoRejoinConn then
b:notify"auto rejoin is already enabled"
return
end

b.privateEnv.autoRejoinConn=b:connect(b.guiService.ErrorMessageChanged,function()
b:run"rejoin"
end)
end
}end a.x=function()local c=a.cache.x if not c then c={c=b()}a.cache.x=c end return c.c end end do local b=function()



local b=3 local c=function(

c, d, e)
local f=`https://games.roblox.com/v1/games/{d}/servers/Public?sortOrder=Asc&limit=100`
if e then
f=f.."&cursor="..e
end

local g=c{Url=f,Method="GET"}
return game:GetService"HttpService":JSONDecode(g.Body)end


return{
{
action="serverhop|shop",
description="Teleports you to a different server",
run=function(d)
local e=d:expectExploit"httprequest"
if not e then return end

d:notify("Serverhop","looking for a server with free space...")

task.spawn(function()
local f={}
local g

for h=1,b do
local i,j=pcall(c,e,game.PlaceId,g)
if not i or type(j)~="table"then break end

for k,l in j.data or{}do
if l.id~=game.JobId and l.playing<l.maxPlayers then
table.insert(f,l.id)
end
end

g=j.nextPageCursor
if not g then break end
end

if#f==0 then
d:notify("Serverhop","no other server with free space was found")
return
end

d.playerService:teleportToJobId(f[math.random(1,#f)])
end)
end
}
}end a.y=function()local c=a.cache.y if not c then c={c=b()}a.cache.y=c end return c.c end end do local b=function()

return{
action="selfkick|kickmyself",
description="Kick your self from the server",
args={
kind="string",
name="kick message",
optional=true
},
run=function(b,c)
local d=c:nextValue()
b.localPlayer:Kick(d)
end
}end a.z=function()local c=a.cache.z if not c then c={c=b()}a.cache.z=c end return c.c end end do local b=function()
local b=tostring(game.PlaceId)
local c=tostring(game.JobId)

return{
{
action="gameteleport|gametp",
description="Joins a game by ID",
args={
kind="number",
name="place id",
options={b}
},
run=function(d,e)
d.teleportService:Teleport(e:nextValue())
end
},
{
action="teleportjobid|tpjobid",
description="Joins a game by jobid",
args={
{
kind="string",
name="job id",
options={c}
},
{
kind="number",
name="place id",
options={b},
optional=true
}
},
run=function(d,e)
local f=e:nextValue()or game.JobId
local g=e:nextValue()or game.PlaceId

d.playerService:teleportToJobId(f,g)
end
}
}end a.A=function()local c=a.cache.A if not c then c={c=b()}a.cache.A=c end return c.c end end do local b=function()
return{
action="antiafk|antiidle",
description="Prevents the game from kicking you for being idle/afk",
run=function(b)
local c=b.executorEnv.getconnections
local d=b.privateEnv

if d.enabledAntiAfk then
b:notify"anti AFK is already enabled"
return
end

d.enabledAntiAfk=true

if not c then
b.localPlayer.Idled:Connect(function()
b.virtualUser:CaptureController()
b.virtualUser:ClickButton2(Vector2.new())
end)
return
end

for e,f in c(b.localPlayer.Idled)do
local g=f.Disconnect or f.Disable

if g then
g(f)
end
end

b:notify"anti AFK is now enabled"
end
}end a.B=function()local c=a.cache.B if not c then c={c=b()}a.cache.B=c end return c.c end end do local b=function()
return{
action="datalimit",
description="Set outgoing KBPS limit",
args={kind="number",name="KB per second"},
run=function(b,c)
local d=c:nextValue()
b.networkClient:SetOutgoingKBPSLimit(d)
end
}end a.C=function()local c=a.cache.C if not c then c={c=b()}a.cache.C=c end return c.c end end do local b=function()
return{
action="replicationlag|backtrack",
description="Set IncomingReplicationLag",
args={kind="number"},
run=function(b,c)
b.gameNetworkSettings.IncomingReplicationLag=c:nextValue()
end
}end a.D=function()local c=a.cache.D if not c then c={c=b()}a.cache.D=c end return c.c end end do local b=function()
return{
action="setfpscap|fpscap|maxfps",
description="limits your FPS",
args={
kind="number",
options={"30","60","120","240"},
min=1,
max=10000
},
run=function(b,c)
local d=c:nextValue()
b.executorEnv.setfpscap(d)
end
}end a.E=function()local c=a.cache.E if not c then c={c=b()}a.cache.E=c end return c.c end end do local b=function()
return{
{
action="noprompts|nopurchaseprompts",
description="Prevents the game from showing you purchase/premium prompts",
run=function(b)
b.coreGui.PurchasePromptApp.Enabled=false
end
},
{
action="showprompts|showpurchaseprompts",
description="Allows the game to show purchase/premium prompts again",
run=function(b)
b.coreGui.PurchasePromptApp.Enabled=true
end
}
}end a.F=function()local c=a.cache.F if not c then c={c=b()}a.cache.F=c end return c.c end end do local b=function()
local b={inventory=
Enum.CoreGuiType.Backpack,leaderboard=
Enum.CoreGuiType.PlayerList,emotes=
Enum.CoreGuiType.EmotesMenu
}

for c,d in Enum.CoreGuiType:GetEnumItems()do
b[string.lower(d.Name)]=d
end

return{
action="togglecoregui|togglegui|tcgui",
description="Toggles visibility of coregui items",
args={
{
kind="string",
options="inventory|playerlist|chat|reset|emotes|all",
name="gui name"
},
{
kind="boolean",
name="enabled"
}
},
run=function(c,d)
local e=d:nextValue()
local f=d:nextValue()

if e=="reset"then
c.starterGui:SetCore("ResetButtonCallback",f)
return
end

local g=b[e]

if g then
c.starterGui:SetCoreGuiEnabled(g,f)
end
end
}end a.G=function()local c=a.cache.G if not c then c={c=b()}a.cache.G=c end return c.c end end do local b=function()local b=function(
b, c)
local d=b:collectGarbage(c)
if not d then return end

for e,f in d do
e.Visible=f
end

local e=b:registerGarbage"bindedHideGuis"
e[c]=nil end local c=function(


c, d, e)
local f=c:registerGarbage"bindedHideGuis"

for g,h in f do
b(c,g)
end

f[d]=true

local g=c:createGarbage(d)
local h=c.localPlayer.PlayerGui

for i,j in h:GetDescendants()do
if j:IsA"GuiObject"and j.Visible~=e then
local k=j.Visible
j.Visible=e
g[j]=k
end
end end


return{
{
action="showguis",
description="Shows any invisible GUIs",
run=function(d)
c(d,"visibleGuiObjects",true)
end
},
{
action="unshowguis",
description="Undoes showguis",
run=function(d)
b(d,"visibleGuiObjects")
end
},
{
action="hideguis",
description="Hides any GUIs in PlayerGui",
run=function(d)
c(d,"invisibleGuiObjects",false)
end
},
{
action="unhideguis",
description="Undoes hideguis",
run=function(d)
b(d,"invisibleGuiObjects")
end
}
}end a.H=function()local c=a.cache.H if not c then c={c=b()}a.cache.H=c end return c.c end end do local b=function()


local b={
[Enum.KeyCode.Semicolon]=true,
[Enum.KeyCode.RightControl]=true,
}local c=function(

c)
local d=c:collectGarbage"hideiy"
if d and d.connection then
d.connection:Disconnect()
end end local d=function(


d)
local e=d.infiniteYield
if not e or not e.mainFrame then
d:notify("IY","the main window is not created yet")
return
end

if not e.mainFrame.Visible then
d:notify("IY","already hidden")
return
end

c(d)
e:releaseCommandFocus()

local f=d:registerGarbage"hideiy"
e.mainFrame.Visible=false

f.connection=d:connect(d.robloxServices.UserInputService.InputBegan,function(g,h)
if h or not b[g.KeyCode]then return end

c(d)
e:showCommandBar()
end)

d:notify("IY","hidden. Press ; or tap the IY button to type a command")end local e=function(


e)
c(e)

local f=e.infiniteYield
if f then
f:showWindow()
end end


return{
{
action="hideiy|hideinterface",
description="Hides the main IY GUI",
run=function(f)
d(f)
end
},
{
action="showiy|unhideiy|unhideinterface",
description="Shows IY again",
run=function(f)
e(f)
end
}
}end a.I=function()local c=a.cache.I if not c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()







local b=a.a()

local c="iy-remake"
local d="iy-remake/keepiy.flag"



local e=[==[
local okFlag, flag = pcall(readfile, "iy-remake/keepiy.flag")
if okFlag and flag == "off" then return end
loadstring(readfile("iy-remake/compiled.luau"))()
]==]local f=function()


local f,g=pcall(function()
return b.readfile(d)
end)
return f and g=="on"end local g=function(


g)
local h=pcall(function()
if b.isfolder and b.makefolder and not b.isfolder(c)then
b.makefolder(c)
end
b.writefile(d,if g then"on"else"off")
end)
return h end local h=function()



local h=b.queueteleport
if not h then return false end

h(e)
return true end local i=function(



i, j)
local k=i.infiniteYield
if k==nil or k.setKeepIY==nil then
return false
end

k:setKeepIY(j)
return true end local j=function(


j)
if not i(j,true)then
j:notify("Keepiy","the main window is not ready, so it could not be kept open")
end

if not g(true)then
j:notify("Keepiy","could not write the flag file (writefile is missing?)")
return
end

if not h()then
j:notify("Keepiy","your executor does not support queueteleport")
return
end

j:notify("Keepiy","the window stays open, and IY will load again after you teleport")end local k=function(


k)
i(k,false)
g(false)
k:notify("Keepiy","disabled: the window closes on outside clicks again, and IY will not load after the next teleport")end



if f()then
h()
end

return{
{
action="keepiy",
description="Auto execute IY when you teleport through servers",
run=function(l)
j(l)
end
},
{
action="unkeepiy",
description="Disable keepiy",
run=function(l)
k(l)
end
},
{
action="togglekeepiy",
description="Toggles keepiy",
run=function(l)
if f()then
k(l)
else
j(l)
end
end
}
}end a.J=function()local c=a.cache.J if not c then c={c=b()}a.cache.J=c end return c.c end end do local b=function()local b=function(

b)
if not b:IsA"PackageLink"then return end

if b.Parent:FindFirstChild"ADpart"then
b.Parent:Destroy()
end

if b.Parent:FindFirstChild"AdGuiAdornee"then
b.Parent.Parent:Destroy()
end end


return{
action="removeads|adblock",
description="Automatically removes ad billboards",
run=function(c)
if c.privateEnv.adBlockConn then return end

for d,e in workspace:GetDescendants()do
b(e)
end

c.privateEnv.adBlockConn=c:connect(workspace.DescendantAdded,function(d)
task.defer(b,d)
end)
end
}end a.K=function()local c=a.cache.K if not c then c={c=b()}a.cache.K=c end return c.c end end do local b=function()


return{
{
action="saveinstance|savegame|saveplace|savep",
description="Uses saveinstance to save the game",
run=function(b)
local c=b:expectExploit"saveinstance"
if not c then return end

b:notify("Saveinstance","saving the game, this can take a while")

task.spawn(function()
local d,e=pcall(c)

if d then
b:notify("Saveinstance","saved")
else
b:notify("Saveinstance",`failed: {tostring(e)}`)
end
end)
end
}
}end a.L=function()local c=a.cache.L if not c then c={c=b()}a.cache.L=c end return c.c end end do local b=function()

return{
action="clearerror",
description="Clears the annoying box and blur when a game kicks you",
run=function(b)
b.guiService:ClearError()
end
}end a.M=function()local c=a.cache.M if not c then c={c=b()}a.cache.M=c end return c.c end end do local b=function()

local b="CoreScripts/NetworkPause"local c=function(

c)
local d=c:collectGarbage"antigameplaypaused"
if d then
d.connection:Disconnect()
end end


return{
{
action="antigameplaypaused",
description="Clears the annoying box shown when a game is loading assets due to network lag",
run=function(d)
c(d)

local e=d.coreGui:FindFirstChild"RobloxGui"
if not e then
d:notify("Anti Pause","RobloxGui was not found")
return
end

local f=d:createGarbage"antigameplaypaused"
f.connection=d:connect(e.ChildAdded,function(g)
if g.Name==b then
g:Destroy()
end
end)

local g=e:FindFirstChild(b)
if g then
g:Destroy()
end
end
},
{
action="unantigameplaypaused",
description="Disables antigameplaypaused",
run=function(d)
c(d)
end
}
}end a.N=function()local c=a.cache.N if not c then c={c=b()}a.cache.N=c end return c.c end end do local b=function()

return{
action="clientantikick|antikick",
description="Prevents localscripts from kicking you (CLIENT)",
run=function(b)
if b.privateEnv.clientAntiKick then
b:notify("Client Antikick","already active")
return
end

local c=b:expectExploit"hookmetamethod"
local d=b:expectExploit"getnamecallmethod"
if not(c and d)then return end

local e=b.localPlayer


local f=b.executorEnv.hookfunction
if f then
pcall(f,e.Kick,function()end)
end

local g
g=c(game,"__index",function(h,i)
if h==e and typeof(i)=="string"and i:lower()=="kick"then
error("Expected ':' not '.' calling member function Kick",2)
end
return g(h,i)
end)

local h
h=c(game,"__namecall",function(i,...)
if i==e and d():lower()=="kick"then
return
end
return h(i,...)
end)

b.privateEnv.clientAntiKick=true
b:notify("Client Antikick","Client anti kick is now active (only effective on localscript kick)")
end
}end a.O=function()local c=a.cache.O if not c then c={c=b()}a.cache.O=c end return c.c end end do local b=function()

return{
action="clientantiteleport|antiteleport",
description="Prevents localscripts from teleporting you (CLIENT)",
run=function(b)
if b.privateEnv.clientAntiTeleport then
b:notify("Client AntiTP","already active")
return
end

local c=b:expectExploit"hookmetamethod"
local d=b:expectExploit"getnamecallmethod"
if not(c and d)then return end

local e=b.teleportService
local f=b.storage.settings
local g=b.executorEnv.checkcaller

local h
h=c(game,"__index",function(i,j)
if i==e and typeof(j)=="string"then
if j:lower()=="teleport"then
error("Expected ':' not '.' calling member function Teleport",2)
elseif j=="TeleportToPlaceInstance"then
error("Expected ':' not '.' calling member function TeleportToPlaceInstance",2)
end
end
return h(i,j)
end)

local i
i=c(game,"__namecall",function(j,...)
if j==e and not g()then
local k=d()
if k:lower()=="teleport"or k=="TeleportToPlaceInstance"then


local l=...
local m=f:getValue"allowRejoin"==true and l==game.PlaceId
if not m then return end
end
end
return i(j,...)
end)

b.privateEnv.clientAntiTeleport=true
b:notify("Client AntiTP","Client anti teleport is now active (only effective on localscript teleport)")
end
}end a.P=function()local c=a.cache.P if not c then c={c=b()}a.cache.P=c end return c.c end end do local b=function()

return{
client=true,
action="allowrejoin|allowrj",
description="Changes if antiteleport allows you to rejoin or not",
args={kind="boolean",name="allow",optional=true},
run=function(b,c)
local d=c:nextValue()


if d==nil then
d=not b.storage.settings:getValue"allowRejoin"
end

b.storage.settings:setValue("allowRejoin",d)
b:notify("Client AntiTP",`Scripts now {d and"may"or"may not"} make you rejoin the server`)
end
}end a.Q=function()local c=a.cache.Q if not c then c={c=b()}a.cache.Q=c end return c.c end end do local b=function()

return{
action="cancelteleport|canceltp",
description="Cancels teleports in progress",
run=function(b)
b.teleportService:TeleportCancel()
end
}end a.R=function()local c=a.cache.R if not c then c={c=b()}a.cache.R=c end return c.c end end do local b=function()
return{
action="volume|vol",
description="Adjusts your game volume on a scale of 0 to 10",
args={
kind="number",
clamp={0,10}
},
run=function(b,c)
local d=1/c:nextValue()
b.userGameSettings.MasterVolume=d
end
}end a.S=function()local c=a.cache.S if not c then c={c=b()}a.cache.S=c end return c.c end end do local b=function()
local b={
BasePart={
CastShadow=false,
Material=Enum.Material.Plastic,
Reflectance=0,
BackSurface=Enum.SurfaceType.SmoothNoOutlines,
BottomSurface=Enum.SurfaceType.SmoothNoOutlines,
FrontSurface=Enum.SurfaceType.SmoothNoOutlines,
LeftSurface=Enum.SurfaceType.SmoothNoOutlines,
RightSurface=Enum.SurfaceType.SmoothNoOutlines,
TopSurface=Enum.SurfaceType.SmoothNoOutlines
},
Decal={
Transparency=1,
Texture=""
},
ParticleEmitter={
Lifetime=NumberRange.new(0)
},
Trail={
Lifetime=NumberRange.new(0)
},
PostEffect={
Enabled=false
}
}

local c={
"ForceField",
"Sparkles",
"Smoke",
"Fire",
"Beam"
}local d=function(

d)
local e=workspace:FindFirstChildWhichIsA"Terrain"
local f=d.rbxServices.Lighting

e.WaterWaveSize=0
e.WaterWaveSpeed=0
e.WaterReflectance=0
e.WaterTransparency=1

f.GlobalShadows=false
f.FogEnd=9e9
f.FogStart=9e9

d.gameSettings.Rendering.QualityLevel=1

for g,h in game:GetDescendants()do
for i,j in b do
if not h:IsA(i)then continue end
for k,l in j do
h[k]=l
end
end
end

d:connect(workspace.DescendantAdded,function(g)
if g:IsA"BasePart"then
BasePart.CastShadow=false
return
end

for h,i in c do
if not g:IsA(i)then continue end

task.defer(function()
g:Destroy()
end)
end
end)end


return{
action="antilag|boostfps|lowgraphics",
description="Lowers game quality to boost FPS",
run=function(e)
if e.privateEnv.antiLagEnabled then
e:notify"anti lag is already enabled"
return
end

e.privateEnv.antiLagEnabled=true
d(e)
end
}end a.T=function()local c=a.cache.T if not c then c={c=b()}a.cache.T=c end return c.c end end do local b=function()
return{
{
action="record|rec",
description="Starts Roblox recorder",
run=function(b)
b.coreGui:ToggleRecording()
end
},
{
action="screenshot|scrnshot",
description="Takes a screenshot",
run=function(b)
b.coreGui:TakeScreenshot()
end
},
{
action="togglefullscreen|togglefs",
description="Toggles fullscreen",
run=function(b)
b.guiService:ToggleFullscreen()
end
}
}end a.U=function()local c=a.cache.U if not c then c={c=b()}a.cache.U=c end return c.c end end do local b=function()
return{
action="notify",
description="Sends you a notification with the provided text",
args={
{
kind="string",
name="message"
},
{
kind="number",
name="duration",
optional=true
}
},
run=function(b,c)
b:notify("Notification",c:nextValue(),c:nextValue())
end
}end a.V=function()local c=a.cache.V if not c then c={c=b()}a.cache.V=c end return c.c end end do local b=function()
local b={}
b.__index=b

b.next=function(c)
local d=c.index
c.index=c.index+1

return c.args[d]end


b.nextValue=function(c)
local d=c:next()
return d and d.value end


b.new=function(c)
for d,e in c do
local f=e.argData









end

return setmetatable({
args=c,
index=1
},b)end


return b end a.W=function()local c=a.cache.W if not c then c={c=b()}a.cache.W=c end return c.c end end do local b=function()
local b=a.W()

return{
action="lastcommand|lastcmd",
description="Executes the previous command used",
run=function(c)
local d=c.privateEnv.lastCommand
if not d then
c:notify("Last Command","no command was used yet")
return
end

c:run(d.name,b.new(d.args),true)
end
}end a.X=function()local c=a.cache.X if not c then c={c=b()}a.cache.X=c end return c.c end end do local b=function()

return{
action="notifyping|ping",
description="Notify yourself your ping",
run=function(b)
local c=b.localPlayer:GetNetworkPing()
b:notify("Ping",`{math.round(c*1000)}ms`)
end
}end a.Y=function()local c=a.cache.Y if not c then c={c=b()}a.cache.Y=c end return c.c end end do local b=function()
return{
{
action="norender",
description="Disable 3d Rendering to decrease the amount of CPU the client uses",
run=function(b)
b.runService:Set3dRenderingEnabled(false)
end
},
{
action="render",
description="Enable 3d Rendering",
run=function(b)
b.runService:Set3dRenderingEnabled(true)
end
}
}end a.Z=function()local c=a.cache.Z if not c then c={c=b()}a.cache.Z=c end return c.c end end do local b=function()
return{
{
action="use2022materials|2022materials",
description="Enables 2022 material textures",
run=function(b)
b.rbxServices.MaterialService.Use2022Materials=true
end
},
{
action="unuse2022materials|un2022materials",
description="Disables 2022 material textures",
run=function(b)
b.rbxServices.MaterialService.Use2022Materials=false
end
}
}end a._=function()local c=a.cache._ if not c then c={c=b()}a.cache._=c end return c.c end end do local b=function()
local b={
[Enum.KeyCode.Comma]=-1,
[Enum.KeyCode.Period]=1,
}

return{
{
action="alignmentkeys",
description="Enables the left and right alignment keys (comma and period)",
run=function(c)
local d=c:createGarbage"alignmentkeys"
if not d then return end

d.akConn=c:connect(c.robloxServices.UserInputService.InputBegan,function(e,f)
if f then return end

local g=b[e.KeyCode]
if not g then return end

local h=c.playerService:getCamera()
if not h then return end

h:PanUnits(g)
end)

d.akEmotes=c.starterGui:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)
c.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,false)
end
},
{
action="unalignmentkeys|noalignmentkeys",
description="Disables the alignment keys",
run=function(c)
local d=c:collectGarbage"alignmentkeys"
if not d then return end

if d.akEmotes~=nil then
c.starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu,d.akEmotes)
end

d.akConn:Disconnect()
end
}
}end a.aa=function()local c=a.cache.aa if not c then c={c=b()}a.cache.aa=c end return c.c end end do local b=function()local b=function(
b, c)
local d=b.localPlayer.PlayerScripts
local e=d.PlayerModule.CameraModule.MouseLockController
local f=e:FindFirstChild"BoundKeys"

if not f then
f=Instance.new("StringValue",e)
f.Name="BoundKeys"
end

f.Value=c end


return{
{
action="ctrllock",
description="Binds Shiftlock to LeftControl",
run=function(c)
b(c,"LeftControl")
end
},
{
action="unctrllock",
description="Re-binds Shiftlock to LeftShift",
run=function(c)
b(c,"LeftShift")
end
}
}end a.ab=function()local c=a.cache.ab if not c then c={c=b()}a.cache.ab=c end return c.c end end do local b=function()
return{
action="exit",
description="Kills roblox process",
run=function()
game:shutdown()
end
}end a.ac=function()local c=a.cache.ac if not c then c={c=b()}a.cache.ac=c end return c.c end end do local b=function()


return{
action="breakloops",
description="Stops any cmd loops (100^1^cmd)",
run=function(b)
b.loopService:stop()
end
}end a.ad=function()local c=a.cache.ad if not c then c={c=b()}a.cache.ad=c end return c.c end end do local b=function()
return{
action="notifyjobid",
description="Notifies the JobId and PlaceId of the current server",
run=function(b)
b:notify("JobId / PlaceId",`{game.JobId} / {game.PlaceId}`)
end
}end a.ae=function()local c=a.cache.ae if not c then c={c=b()}a.cache.ae=c end return c.c end end do local b=function()

local b=a.h()
return b.Players.LocalPlayer end a.af=function()local c=a.cache.af if not c then c={c=b()}a.cache.af=c end return c.c end end do local b=function()
local b=a.h()
local c=a.af()
local d=a.d()

local e=b.TeleportService

local f=c:GetMouse()

local g={}

g.getMouse=function(h)
return f end


g.isMouseInGuiObject=function(h, i)
local j=i.AbsolutePosition
local k=i.AbsoluteSize

return f.X>=j.X
and f.X<j.X+k.X
and f.Y>=j.Y
and f.Y<j.Y+k.Y end


g.teleportToJobId=function(h, i, j)
j=j or game.PlaceId
e:TeleportToPlaceInstance(j,i,c)end


g.isAlive=function(h)
local i=h:getHumanoid()
return i and i.Health>0 end


g.getCharacter=function(h)
return c.Character end


g.getHumanoid=function(h)
local i=h:getCharacter()
return i and i:FindFirstChildOfClass"Humanoid"end


g.getRootPart=function(h)
local i=h:getHumanoid()
return i and i.RootPart end


g.resetCharacter=function(h)
local i=c.Character
if not i then return end

if i.Humanoid then
i.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
else
i:BreakJoints()
end end


g.getPlayersByName=function(h, i)
local j={}

local k=#i
i=i:lower()

for l,m in b.Players:GetPlayers()do
local n=string.lower(m.Name):sub(1,k)
local o=string.lower(m.displayName):sub(1,k)

if n==i or o==i then
table.insert(j,m)
end
end

return j end


g.getCamera=function(h)
return workspace.CurrentCamera end











































































return g end a.ag=function()local c=a.cache.ag if not c then c={c=b()}a.cache.ag=c end return c.c end end do local b=function()
local b=a.h()
local c=a.ag()
local d=a.af()local e=function(







e)
for f=#e,2,-1 do
local g=math.random(1,f)
e[f],e[g]=e[g],e[f]
end
return e end local f=function(


f)
local g=f.Character
return g and g:FindFirstChildOfClass"Humanoid"end local g=function(


g)
local h=g.Character
return h and h:FindFirstChild"HumanoidRootPart"end local h=function(


h)
local i=f(h)
return i~=nil and i.Health>0 end local i=function(



i)
local j=g(d)
local k=g(i)
if not(j and k)then return nil end

return(k.Position-j.Position).Magnitude end local j=function(


j, k)
local l={}
for m,n in j do
if k(n)then
table.insert(l,n)
end
end
return l end local k=function(


k)
return j(k,function(l)
return l~=d
end)end local l=function(


l)
return d.Team~=nil and l.Team==d.Team end local m=function(


m)
local n=f(m)
if not n then return false end

for o,p in n:GetAccessories()do
local q=p.Name:lower()
if q:find("bacon",1,true)or q:find("pal hair",1,true)then
return true
end
end
return false end local n=function(



n, o)
local p
local q

for r,s in k(n)do
local t=i(s)
if t then
local u=q==nil
or(o and t>q)
or(not o and t<q)

if u then
p,q=s,t
end
end
end

if p then
return{p}
end
return{}end


local o={
me=function()
return{d}
end,
all=function(o)
return o
end,
others=function(o)
return k(o)
end,
random=function(o)
if#o==0 then return{}end
return{o[math.random(1,#o)]}
end,
allies=function(o)
return j(o,l)
end,
team=function(o)
return j(o,l)
end,
enemies=function(o)
return j(k(o),function(p)
return not l(p)
end)
end,
nonteam=function(o)
return j(k(o),function(p)
return not l(p)
end)
end,
friends=function(o)
return j(k(o),function(p)
return d:IsFriendsWith(p.UserId)
end)
end,
nonfriends=function(o)
return j(k(o),function(p)
return not d:IsFriendsWith(p.UserId)
end)
end,
guests=function(o)
return j(o,function(p)
return p.UserId<=0
end)
end,
bacons=function(o)
return j(o,m)
end,
alive=function(o)
return j(o,h)
end,
dead=function(o)
return j(o,function(p)
return not h(p)
end)
end,
nearest=function(o)
return n(o,false)
end,
farthest=function(o)
return n(o,true)
end,
}

local p={
{
pattern="^#(%d+)$",
handler=function(p,q)
local r=e(p)
return table.move(r,1,math.min(tonumber(q),#r),1,{})
end,
},
{
pattern="^@(.+)$",
handler=function(p,q)

return j(p,function(r)
return r.Name:lower():sub(1,#q)==q
end)
end,
},
{
pattern="^%%(.+)$",
handler=function(p,q)
return j(p,function(r)
local s=r.Team
return s~=nil and s.Name:lower():sub(1,#q)==q
end)
end,
},
{
pattern="^age(%d+)$",
handler=function(p,q)
local r=tonumber(q)
return j(p,function(s)
return s.AccountAge<=r
end)
end,
},
{
pattern="^rad(%d+)$",
handler=function(p,q)
local r=tonumber(q)
return j(k(p),function(s)
local t=i(s)
return t~=nil and t<=r
end)
end,
},
{
pattern="^group(%d+)$",
handler=function(p,q)
local r=tonumber(q)
return j(p,function(s)
return s:IsInGroup(r)
end)
end,
},
}local q=function(


q)
local r=(q or"me"):lower()
if o[r]then return true end

for s,t in p do
if r:match(t.pattern)then return true end
end
return false end local r=function(



r)
return r:match"^%s*(.-)%s*$"end local s=function(



s, t)
local u=s:lower()

local v=o[u]
if v then
return v(t)
end

for w,x in p do
local y=u:match(x.pattern)
if y then
return x.handler(t,y)
end
end

return c:getPlayersByName(s)end local t=function(



t, u)
local v={}
local w={}

for x,y in t do
if not v[y]then
v[y]=true
table.insert(w,y)
end
end

for x,y in u do
if not v[y]then
v[y]=true
table.insert(w,y)
end
end

return w end local u=function(



u, v)
local w={}
for x,y in v do
w[y]=true
end

return j(u,function(x)
return not w[x]
end)end local v=function(




v)
local w={}
local x="+"
local y={}

for z=1,#v do
local A=v:sub(z,z)

if A=="+"or A=="-"then
table.insert(w,{op=x,term=r(table.concat(y))})
y={}
x=A
else
table.insert(y,A)
end
end

table.insert(w,{op=x,term=r(table.concat(y))})
return w end local w=function(




w, x)
local y=v(w)
local z=y[1]
local A={}

if z.term~=""then
A=s(z.term,x)
elseif y[2]and y[2].op=="-"then
A=table.clone(x)
end

for B=2,#y do
local C=y[B]
local D={}

if C.term~=""then
D=s(C.term,x)
end

if C.op=="+"then
A=t(A,D)
else
A=u(A,D)
end
end

return A end local x=function(



x)
local y={}

for z in x:gmatch"[^,]+"do
local A=r(z)

if A~=""then
table.insert(y,A)
end
end

return y end local y=function(



y)
return y~=nil and y:find"[,+%-]"~=nil end local z=function(




z)
local A=z or"me"
local B=b.Players:GetPlayers()
local C=s(r(A),B)

if#C>0 then
return C
end

if not y(A)then

return c:getPlayersByName(r(A))
end

local D={}

for E,F in x(A)do
D=t(D,w(F,B))
end

return D end



return setmetatable({
isSelector=q,
hasOperators=y,
parts=x,
},{
__call=function(A,B)
return z(B)
end,
})end a.ah=function()local c=a.cache.ah if not c then c={c=b()}a.cache.ah=c end return c.c end end do local b=function()

local b=a.ah()

return{
{
action="copyid|copyuserid",
description="Copies a player's user ID to your clipboard",
args={kind="player",optional=true},
run=function(c,d)
for e,f in b(d:nextValue())do
c.executorEnv.setclipboard(tostring(f.UserId))
end
end
},
{
action="appearanceid|aid",
description="Notifies a player's character appearance ID",
args={kind="player",optional=true},
run=function(c,d)
for e,f in b(d:nextValue())do
c:notify("Appearance ID",tostring(f.CharacterAppearanceId))
end
end
},
{
action="copyappearanceid|caid",
description="Copies a player's character appearance ID to your clipboard",
args={kind="player",optional=true},
run=function(c,d)
for e,f in b(d:nextValue())do
c.executorEnv.setclipboard(tostring(f.CharacterAppearanceId))
end
end
},
{
action="copycreatorid|copycreator",
description="Copies the game creator's user ID to your clipboard",
run=function(c)
local d=game.CreatorId

if game.CreatorType==Enum.CreatorType.Group then
d=c.groupService:GetGroupInfoAsync(d).Owner.Id
elseif game.CreatorType~=Enum.CreatorType.User then
return
end

c.executorEnv.setclipboard(tostring(d))
c:notify("Copied ID","Copied creator ID to clipboard")
end
}
}end a.ai=function()local c=a.cache.ai if not c then c={c=b()}a.cache.ai=c end return c.c end end do local b=function()

local b={inventory=
Enum.CoreGuiType.Backpack,leaderboard=
Enum.CoreGuiType.PlayerList,emotes=
Enum.CoreGuiType.EmotesMenu
}

for c,d in Enum.CoreGuiType:GetEnumItems()do
b[string.lower(d.Name)]=d
end local c=function(

c, d, e)
if d=="reset"then
c.starterGui:SetCore("ResetButtonCallback",e)
return
end

local f=b[d]
if f then
c.starterGui:SetCoreGuiEnabled(f,e)
end end


return{
{
action="enable",
description="Enables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
args={kind="string",name="gui name"},
run=function(d,e)
c(d,e:nextValue():lower(),true)
end
},
{
action="disable",
description="Disables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
args={kind="string",name="gui name"},
run=function(d,e)
c(d,e:nextValue():lower(),false)
end
}
}end a.aj=function()local c=a.cache.aj if not c then c={c=b()}a.cache.aj=c end return c.c end end do local b=function()

return{
action="clearnilinstances|nonilinstances|cni",
description="Destroys every nil instance (needs getnilinstances)",
run=function(b)
if not getnilinstances then
b:notify("Incompatible Exploit","Your exploit does not support this command (missing getnilinstances)")
return
end

for c,d in getnilinstances()do
d:Destroy()
end
end
}end a.ak=function()local c=a.cache.ak if not c then c={c=b()}a.cache.ak=c end return c.c end end do local b=function()

return{
action="mousesensitivity|ms",
description="Sets your mouse delta sensitivity",
args={kind="number",name="sensitivity"},
run=function(b,c)
b.robloxServices.UserInputService.MouseDeltaSensitivity=c:nextValue()
end
}end a.al=function()local c=a.cache.al if not c then c={c=b()}a.cache.al=c end return c.c end end do local b=function()

local b=a.ah()

return{
{
action="friend",
description="Sends a friend request to a player",
args={kind="player"},
run=function(c,d)
for e,f in b(d:nextValue())do
c.localPlayer:RequestFriendship(f)
end
end
},
{
action="unfriend",
description="Removes a player from your friends",
args={kind="player"},
run=function(c,d)
for e,f in b(d:nextValue())do
c.localPlayer:RevokeFriendship(f)
end
end
}
}end a.am=function()local c=a.cache.am if not c then c={c=b()}a.cache.am=c end return c.c end end do local b=function()local b=function(


b)
local c=b.localPlayer
local d=c.Character
if not d then return end

local e=d:FindFirstChildWhichIsA"Humanoid"
if e then
e:ChangeState(Enum.HumanoidStateType.Dead)
end

d:ClearAllChildren()

local f=Instance.new"Model"
f.Parent=workspace

task.wait()
c.Character=f
task.wait()
c.Character=d
f:Destroy()end


return{
{
action="respawn",
description="Respawns your character in place (client side)",
run=function(c)
b(c)
end
},
{
action="refresh|re",
description="Respawns your character and puts you back where you were",
run=function(c)
local d=c.playerService:getRootPart()
if not d then return end

local e=c.localPlayer
local f=d.CFrame
local g=workspace.CurrentCamera.CFrame

b(c)

task.spawn(function()
local h=e.CharacterAdded:Wait()
local i=h:WaitForChild("HumanoidRootPart",10)
if not i then return end

i.CFrame=f
workspace.CurrentCamera.CFrame=g
end)
end
},
{
action="reset",
description="Resets your character",
run=function(c)
c.playerService:resetCharacter()
end
}
}end a.an=function()local c=a.cache.an if not c then c={c=b()}a.cache.an=c end return c.c end end do local b=function()

local b=a.d()

return{
action="debug",
description="Turns the debug logger on or off (default is on)",
args={kind="boolean",name="enabled",optional=true},
run=function(c,d)
local e=d:nextValue()
if e==nil then
e=true
end

if e then
b:enable()
else
b:disable()
end

c:notify("debug",tostring(e))
end
}end a.ao=function()local c=a.cache.ao if not c then c={c=b()}a.cache.ao=c end return c.c end end do local b=function()

return{
{
action="team",
description="Changes your team. Sometimes fools localscripts. (CLIENT)",
args={
kind="team"
},
run=function(b,c)
local d=c:nextValue()
local e=b.robloxServices.Teams:FindFirstChild(d)
if not e then
b:notify("Invalid Team",tostring(d).." is not a valid team")
return
end

local f=b.playerService:getRootPart()
local g=b.executorEnv.firetouchinterest


if f and g then
for h,i in workspace:GetDescendants()do
if i:IsA"SpawnLocation"and i.BrickColor==e.TeamColor and i.AllowTeamChangeOnTouch then
g(i,f,0)
g(i,f,1)
break
end
end
else
b.localPlayer.Team=e
end
end
}
}end a.ap=function()local c=a.cache.ap if not c then c={c=b()}a.cache.ap=c end return c.c end end do local b=function()

local b=a.ah()

return{
{
action="handlekill|hkill",
description="Kills a player using tool damage (YOU NEED A TOOL) (TOOL)",
args={
{
kind="player"
},
{
kind="number",
name="radius",
optional=true
}
},
run=function(c,d)
local e=c:expectExploit"firetouchinterest"
if not e then return end

local f=c.playerService:getCharacter()
local g=f and f:FindFirstChildWhichIsA"Tool"
local h=g and g:FindFirstChild"Handle"
if not h then
c:notify("Handle Kill",'You need to hold a "Tool" that does damage on touch.')
return
end

local i=b(d:nextValue())
local j=d:nextValue()or math.huge


local k=c:collectGarbage"handlekill"
if k then
k.running=false
end

local l=c:createGarbage"handlekill"
l.running=true
c:notify("Handle Kill","Started!")


task.spawn(function()
while l.running do
task.wait()

local m=c.playerService:getCharacter()
if not(m and g.Parent==m)then break end

local n=c.playerService:getRootPart()
for o,p in i do
local q=p~=c.localPlayer and p.Character
local r=q and q:FindFirstChildWhichIsA"Humanoid"
local s=q and q:FindFirstChild"HumanoidRootPart"

if n and r and s and r.Health>0 and(n.Position-s.Position).Magnitude<=j then
e(h,s,1)
e(h,s,0)
end
end
end

l.running=false
c:notify("Handle Kill","Stopped!")
end)
end
}
}end a.aq=function()local c=a.cache.aq if not c then c={c=b()}a.cache.aq=c end return c.c end end do local b=function()




local b=0.01 local c=function(

c)
task.wait(math.max(c,b))end local d=function(


d, e)
local f=d:collectGarbage(e)
if not f then return false end

f.running=false
return true end local e=function(



e, f, g, h, i)
d(e,f)

local j=e:createGarbage(f)
j.running=true

task.spawn(function()
while j.running do
i(true)
c(h)
i(false)
c(g)
end
end)end


return{
{
action="autoclick",
description="Automatically clicks your mouse with a set delay",
args={
{
kind="number",
name="click delay"
},
{
kind="number",
name="release delay"
}
},
run=function(f,g)
local h=g:nextValue()or 0.1
local i=g:nextValue()or 0.05

local j=f.robloxServices.VirtualInputManager
e(f,"autoclick",h,i,function(k)
local l=f.playerService:getMouse()
j:SendMouseButtonEvent(l.X,l.Y,0,k,game,0)
end)
end
},
{
action="unautoclick|noautoclick",
description="Turns off autoclick",
run=function(f)
d(f,"autoclick")
end
},
{
action="autokeypress|keypress",
description="Automatically presses a key with a set delay",
args={
{
kind="keycode"
},
{
kind="number",
name="click delay"
},
{
kind="number",
name="release delay"
}
},
run=function(f,g)
local h=g:nextValue()
local i=g:nextValue()or 0.1
local j=g:nextValue()or 0.05

local k=f.robloxServices.VirtualInputManager
e(f,"autokeypress",i,j,function(l)
k:SendKeyEvent(l,h,false,game)
end)
end
},
{
action="unautokeypress|noautokeypress|unkeypress|nokeypress",
description="Stops autokeypress",
run=function(f)
d(f,"autokeypress")
end
}
}end a.ar=function()local c=a.cache.ar if not c then c={c=b()}a.cache.ar=c end return c.c end end do local b=function()




local b=a.h()
local c=b.Players

local d="Rolewatch"
local e="Staffwatch"
local f={"admin","mod","staff","owner","dev","support","manager"}local g=function(


g, h)
local i,j=pcall(function()
return g:GetRoleInGroup(h)
end)
return if i then j else nil end local h=function(


h, i)
local j=h:collectGarbage(i)
if not j then return false end

if j.connection then
j.connection:Disconnect()
end
return true end local i=function(




i, j, k)
if k==i.localPlayer then return end

local l=g(k,j.groupId)
if not l or l:lower()~=j.roleName then return end

i:notify(d,`{k.Name} has the role '{l}'`)

if i.privateEnv.rolewatchLeave then
i.localPlayer:Kick"rolewatch: a watched player joined"
end end local j=function(




j)
if game.CreatorType~=Enum.CreatorType.Group then
return j.UserId==game.CreatorId
end

local k=g(j,game.CreatorId)
if not k or k=="Guest"then return false end

local l=k:lower()
for m,n in f do
if l:find(n,1,true)then
return true
end
end
return false end


return{
{
action="rolewatch",
description="Notify if someone from a watched group joins the server",
args={
{
kind="number",
name="group id"
},
{
kind="string",
name="role name"
}
},
run=function(k,l)
local m=l:nextValue()
local n=l:nextValue()

h(k,"rolewatch")

local o=k:createGarbage"rolewatch"
o.groupId=m
o.roleName=n:lower()

for p,q in c:GetPlayers()do
i(k,o,q)
end

o.connection=k:connect(c.PlayerAdded,function(p)
i(k,o,p)
end)

k:notify(d,`watching for the role '{n}' in group {m}`)
end
},
{
action="rolewatchstop|unrolewatch",
description="Disable Rolewatch",
run=function(k)
if h(k,"rolewatch")then
k:notify(d,"disabled")
end
end
},
{
action="rolewatchleave",
description="Toggle if you should leave the game if someone from a watched group joins the server",
run=function(k)
local l=not k.privateEnv.rolewatchLeave
k.privateEnv.rolewatchLeave=l
k:notify(d,if l then"you will leave when a watched player joins"else"you will stay when a watched player joins")
end
},
{
action="staffwatch",
description="Notify if a staff member of the game joins the server",
run=function(k)
h(k,"staffwatch")

local l=k:createGarbage"staffwatch"local m=function(

m)
if m~=k.localPlayer and j(m)then
k:notify(e,`staff member {m.Name} is in the server`)
end end


for n,o in c:GetPlayers()do
m(o)
end

l.connection=k:connect(c.PlayerAdded,m)
k:notify(e,"watching for staff")
end
},
{
action="unstaffwatch",
description="Disable Staffwatch",
run=function(k)
if h(k,"staffwatch")then
k:notify(e,"disabled")
end
end
},
{
action="findfriendgroups",
description="Notifies you if any players are friends with each other",
run=function(k)
local l=c:GetPlayers()
local m={}

for n=1,#l do
for o=n+1,#l do
local p,q=l[n],l[o]

local r,s=pcall(function()
return p:IsFriendsWith(q.UserId)
end)

if r and s then
table.insert(m,`{p.Name} & {q.Name}`)
end
end
end

if#m==0 then
k:notify("Friend groups","no friends were found between the players in this server")
else
k:notify("Friend groups",table.concat(m,", "))
end
end
}
}end a.as=function()local c=a.cache.as if not c then c={c=b()}a.cache.as=c end return c.c end end do local b=function()




return{
{
action="clickdelete",
description="Go to Settings > Keybinds > Add for click delete",
run=function(b)
local c=b.playerService:getMouse().Target
local d=b.playerService:getCharacter()

if not c then
b:notify("Click delete","nothing under the mouse")
return
end

if c:IsA"Terrain"then
b:notify("Click delete","terrain cannot be deleted")
return
end

if d and c:IsDescendantOf(d)then
b:notify("Click delete","that part belongs to your character")
return
end

local e=c:GetFullName()
c:Destroy()
b:notify("Click delete",`deleted {e}`)
end
},
{
action="clickteleport",
description="Go to Settings > Keybinds > Add for click teleport",
run=function(b)
b:run"mousetp"
end
}
}end a.at=function()local c=a.cache.at if not c then c={c=b()}a.cache.at=c end return c.c end end do local b=function()local b=function(


b, c)
local d=b.playerService:getHumanoid()
if not d then
b:notify("Rig","your character is not loaded")
return
end

local e=b.robloxServices.AvatarEditorService

task.spawn(function()
e:PromptSaveAvatar(d.HumanoidDescription,Enum.HumanoidRigType[c])

local f=e.PromptSaveAvatarCompleted:Wait()
if f==Enum.AvatarPromptResult.Success then
b:run"reset"
end
end)end


return{
{
action="promptr6",
description="Prompts the game to switch your rig type to R6",
run=function(c)
b(c,"R6")
end
},
{
action="promptr15",
description="Prompts the game to switch your rig type to R15",
run=function(c)
b(c,"R15")
end
}
}end a.au=function()local c=a.cache.au if not c then c={c=b()}a.cache.au=c end return c.c end end do local b=function()



return a.k().new"testedCommands"end a.av=function()local c=a.cache.av if not c then c={c=b()}a.cache.av=c end return c.c end end do local b=function()local b=function(


b, c, d)
local e=b:getCommandData(c)
if not e then
b:notify("Tested",c.." is not a valid command")
return
end

local f=a.av()
f:setValue(e.name,if d then true else nil)
f:save()

b:notify("Tested",e.name..(d and" marked as tested"or" is no longer marked"))end


return{
{
action="marktested|mtested",
description="Marks a command as tested (grey, test only)",
args={kind="string",name="command name"},
run=function(c,d)
b(c,d:nextValue(),true)
end
},
{
action="unmarktested|unmtested",
description="Removes the tested mark from a command",
args={kind="string",name="command name"},
run=function(c,d)
b(c,d:nextValue(),false)
end
}
}end a.aw=function()local c=a.cache.aw if not c then c={c=b()}a.cache.aw=c end return c.c end end do local b=function()

return{a.f()
,a.q()
,a.r()
,a.s()
,a.t()
,a.u()
,a.v()
,a.w()
,a.x()
,a.y()
,a.z()
,a.A()
,a.B()
,a.C()
,a.D()
,a.E()
,a.F()
,a.G()
,a.H()
,a.I()

,a.J()
,a.K()
,a.L()
,a.M()
,a.N()
,a.O()
,a.P()
,a.Q()
,a.R()
,a.S()
,a.T()
,a.U()
,a.V()
,a.X()
,a.Y()
,a.Z()
,a._()
,a.aa()
,a.ab()
,a.ac()
,a.ad()

,a.ae()
,a.ai()
,a.aj()
,a.ak()
,a.al()
,a.am()
,a.an()
,a.ao()
,a.ap()
,a.aq()
,a.ar()
,a.as()
,a.at()
,a.au()
,a.aw()

}end a.ax=function()local c=a.cache.ax if not c then c={c=b()}a.cache.ax=c end return c.c end end do local b=function()





local b=a.h()

local c=b.UserInputService

local d={}

local e=Vector3.one*9e9 local f=function(


f)
local g=Vector3.new(f.X,0,f.Z)
if g.Magnitude==0 then
return Vector3.zero
end
return g.Unit end local g=function(



g, h)
local i=workspace.CurrentCamera.CFrame
local j=h.MoveDirection

local k=j:Dot(f(i.LookVector))
local l=j:Dot(f(i.RightVector))

local m=0
if g.privateEnv.qeFly~=false then
if c:IsKeyDown(Enum.KeyCode.E)then
m=m+1
end
if c:IsKeyDown(Enum.KeyCode.Q)then
m=m-1
end
end

local n=i.LookVector*k+i.RightVector*l+Vector3.yAxis*m
if n.Magnitude>1 then
n=n.Unit
end
return n end



d.stop=function(h, i)
local j=h:collectGarbage(i)
if not j then return end

if j.connection then
j.connection:Disconnect()
end
if j.velocity then
j.velocity:Destroy()
end
if j.gyro then
j.gyro:Destroy()
end
if j.humanoid then
j.humanoid.PlatformStand=false
end end





d.start=function(h, i)
d.stop(h,i.garbageName)

local j=h.playerService:getHumanoid()
local k=h.playerService:getRootPart()
if not(j and k)then
h:notify("Fly","your character is not loaded")
return
end

local l=Instance.new"BodyVelocity"
l.MaxForce=e
l.Velocity=Vector3.zero
l.Parent=k

local m=Instance.new"BodyGyro"
m.MaxTorque=e
m.P=9e4
m.CFrame=k.CFrame
m.Parent=k

if i.platformStand then
j.PlatformStand=true
end

local n=h:createGarbage(i.garbageName)
n.velocity=l
n.gyro=m
n.humanoid=j

n.connection=h:connect(h.runService.Heartbeat,function()
if not k:IsDescendantOf(workspace)or j.Health<=0 then
d.stop(h,i.garbageName)
return
end

l.Velocity=g(h,j)*i.getSpeed()
m.CFrame=workspace.CurrentCamera.CFrame
end)end


return d end a.ay=function()local c=a.cache.ay if not c then c={c=b()}a.cache.ay=c end return c.c end end do local b=function()

local b=a.ay()

local c=20

return{
{
action="fly",
description="Makes you fly",
args={
kind="number",
name="fly speed",
optional=true
},
run=function(d,e)
local f=e:nextValue()
if f then
d.privateEnv.flySpeed=f
end

b.start(d,{
garbageName="fly",
platformStand=true,
getSpeed=function()
return d.privateEnv.flySpeed or c
end
})
end
},
{
action="flyspeed",
description="Set fly speed (default is 20)",
args={
kind="number",
name="fly speed"
},
run=function(d,e)
d.privateEnv.flySpeed=e:nextValue()or c
end
},
{
action="unfly",
description="Disables fly",
run=function(d)
b.stop(d,"fly")
end
}
}end a.az=function()local c=a.cache.az if not c then c={c=b()}a.cache.az=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage"noclip"
if not c then return end

c.connection:Disconnect()


for d in c.parts do
if d.Parent then
d.CanCollide=true
end
end end


return{
{
action="noclip",
description="Go through objects",
run=function(c)
if c:hasGarbage"noclip"then
c:notify"noclip is already enabled"
return
end

local d=c:createGarbage"noclip"
d.parts=setmetatable({},{__mode="k"})

d.connection=c:connect(c.runService.Stepped,function()
local e=c.playerService:getCharacter()
if not e then return end


local f=c:getGarbage"float"
local g=f and f.platform

for h,i in e:GetDescendants()do
if i:IsA"BasePart"and i.CanCollide and i~=g then
i.CanCollide=false
d.parts[i]=true
end
end
end)
end
},
{
action="unnoclip|clip",
description="Disables noclip",
run=function(c)
b(c)
end
}
}end a.aA=function()local c=a.cache.aA if not c then c={c=b()}a.cache.aA=c end return c.c end end do local b=function()

local b=a.ay()

local c=20

return{
{
action="vehiclefly|vfly",
description="Makes you fly in a vehicle",
args={
kind="number",
name="vehicle fly speed",
optional=true
},
run=function(d,e)
local f=e:nextValue()
if f then
d.privateEnv.vehicleFlySpeed=f
end


b.start(d,{
garbageName="fly",
platformStand=false,
getSpeed=function()
return d.privateEnv.vehicleFlySpeed or c
end
})
end
},
{
action="vehicleflyspeed|vflyspeed",
description="Set vehicle fly speed",
args={
kind="number",
name="vehicle fly speed"
},
run=function(d,e)
d.privateEnv.vehicleFlySpeed=e:nextValue()or c
end
},
{
action="unvehiclefly|unvfly",
description="Disables vehicle fly",
run=function(d)
b.stop(d,"fly")
end
}
}end a.aB=function()local c=a.cache.aB if not c then c={c=b()}a.cache.aB=c end return c.c end end do local b=function()

local b=50 local c=function(


c)
local d=c:collectGarbage"cframefly"
if not d then return end

d.connection:Disconnect()
d.humanoid.PlatformStand=false
d.head.Anchored=false end local d=function(



d)
c(d)

local e=d.playerService:getHumanoid()
local f=d.playerService:getCharacter()
local g=f and f:FindFirstChild"Head"
if not(e and g)then
d:notify("cframefly","your character is not loaded")
return
end

e.PlatformStand=true
g.Anchored=true

local h=d:createGarbage"cframefly"
h.humanoid=e
h.head=g
h.connection=d:connect(d.runService.Heartbeat,function(i)
if not g:IsDescendantOf(workspace)then
c(d)
return
end

local j=d.privateEnv.cframeFlySpeed or b
local k=e.MoveDirection*(j*i)

local l=g.CFrame
local m=workspace.CurrentCamera.CFrame
local n=l:ToObjectSpace(m).Position
m=m*CFrame.new(-n.X,-n.Y,-n.Z+1)

local o=m.Position
local p=l.Position
local q=CFrame.new(o,Vector3.new(p.X,o.Y,p.Z)):VectorToObjectSpace(k)

g.CFrame=CFrame.new(p)*(m-o)*CFrame.new(q)
end)end


return{
{
action="cframefly|cfly",
description="Makes you fly, bypassing some anti cheats (works on mobile)",
args={
kind="number",
name="speed",
optional=true
},
run=function(e,f)
local g=f:nextValue()
if g then
e.privateEnv.cframeFlySpeed=g
end
d(e)
end
},
{
action="cframeflyspeed|cflyspeed",
description="Sets cfly speed",
args={
kind="number"
},
run=function(e,f)
e.privateEnv.cframeFlySpeed=f:nextValue()or b
end
},
{
action="uncframefly|uncfly",
description="Disables cfly",
run=function(e)
c(e)
end
}
}end a.aC=function()local c=a.cache.aC if not c then c={c=b()}a.cache.aC=c end return c.c end end do local b=function()

return{
action="qefly",
description="Enables or disables the Q and E hotkeys for fly",
args={
kind="boolean",
optional=true
},
run=function(b,c)

b.privateEnv.qeFly=c:nextValue()~=false
end
}end a.aD=function()local c=a.cache.aD if not c then c={c=b()}a.cache.aD=c end return c.c end end do local b=function()local b=function(


b)
local c=b
while c and not c:IsA"Model"do
c=c.Parent
end
return c end local c=function(


c)
local d=c:collectGarbage"vehiclenoclip"
if not d then return end

for e,f in d.parts do
f.CanCollide=true
end end


return{
{
action="vehiclenoclip|vnoclip",
description="Turns off vehicle collision",
run=function(d)
c(d)

local e=d.playerService:getHumanoid()
local f=e and e.SeatPart
local g=f and b(f)
if not g then
d:notify("vehiclenoclip","you are not sitting in a vehicle")
return
end

local h=d:createGarbage"vehiclenoclip"
h.parts={}

for i,j in g:GetDescendants()do
if j:IsA"BasePart"and j.CanCollide then
j.CanCollide=false
table.insert(h.parts,j)
end
end
end
},
{
action="vehicleclip|vclip|unvnoclip",
description="Enables vehicle collision",
run=function(d)
c(d)
end
},
}end a.aE=function()local c=a.cache.aE if not c then c={c=b()}a.cache.aE=c end return c.c end end do local b=function()

local b=-3.1 local c=function(

c)
local d=c:collectGarbage"float"
if not d then return end

for e,f in d.connections do
f:Disconnect()
end
d.platform:Destroy()end local d=function(


d)
if d:hasGarbage"float"then
d:notify"float is already enabled"
return
end

local e=d.playerService:getCharacter()
local f=d.playerService:getRootPart()
if not(e and f)then
d:notify("Float","your character is not loaded")
return
end

local g=Instance.new"Part"
g.Name="IYFloatPlatform"
g.Transparency=1
g.Size=Vector3.new(2,0.2,1.5)
g.Anchored=true
g.CFrame=f.CFrame*CFrame.new(0,b,0)
g.Parent=e

local h=d:createGarbage"float"
h.platform=g
h.offset=b
h.connections={}

table.insert(h.connections,d:connect(d.runService.Heartbeat,function()
local i=d.playerService:getRootPart()
if not(i and g:IsDescendantOf(workspace))then
c(d)
return
end

g.CFrame=i.CFrame*CFrame.new(0,h.offset,0)
end))


table.insert(h.connections,d:connect(d.robloxServices.UserInputService.InputBegan,function(i,j)
if j then return end

if i.KeyCode==Enum.KeyCode.E then
h.offset=h.offset+1.5
elseif i.KeyCode==Enum.KeyCode.Q then
h.offset=h.offset-0.5
end
end))

table.insert(h.connections,d:connect(d.robloxServices.UserInputService.InputEnded,function(i)
if i.KeyCode==Enum.KeyCode.E then
h.offset=h.offset-1.5
elseif i.KeyCode==Enum.KeyCode.Q then
h.offset=h.offset+0.5
end
end))

d:notify("Float","Enabled (Q = down & E = up)")end


return{
{
action="float|platform",
description="Spawns a platform beneath you causing you to float",
run=function(e)
d(e)
end
},
{
action="unfloat|noplatform",
description="Removes the platform",
run=function(e)
if not e:hasGarbage"float"then return end

c(e)
e:notify("Float","Disabled")
end
}
}end a.aF=function()local c=a.cache.aF if not c then c={c=b()}a.cache.aF=c end return c.c end end do local b=function()local b=function()



local b={}
for c,d in Enum.HumanoidStateType:GetEnumItems()do
if d~=Enum.HumanoidStateType.None and d~=Enum.HumanoidStateType.Dead then
table.insert(b,d)
end
end
return b end local c=function(


c)
local d=c:collectGarbage"swim"
if not d then return end

for e,f in d.connections do
f:Disconnect()
end
for e,f in d.states do
d.humanoid:SetStateEnabled(f,true)
end
workspace.Gravity=d.gravity end local d=function(


d)
if d:hasGarbage"swim"then
d:notify"swim is already enabled"
return
end

local e=d.playerService:getHumanoid()
if not e then
d:notify("swim","your character is not loaded")
return
end

local f=d:createGarbage"swim"
f.humanoid=e
f.gravity=workspace.Gravity
f.states=b()
f.connections={}

workspace.Gravity=0
for g,h in f.states do
e:SetStateEnabled(h,false)
end
e:ChangeState(Enum.HumanoidStateType.Swimming)

table.insert(f.connections,d:connect(e.Died,function()
c(d)
end))


table.insert(f.connections,d:connect(d.runService.Heartbeat,function()
local g=d.playerService:getRootPart()
if not g then return end

local h=e.MoveDirection~=Vector3.zero
or d.robloxServices.UserInputService:IsKeyDown(Enum.KeyCode.Space)
if not h then
g.AssemblyLinearVelocity=Vector3.zero
end
end))end


return{
{
action="swim",
description="Allows you to swim in the air",
run=function(e)
d(e)
end
},
{
action="unswim|noswim",
description="Stops you from swimming everywhere",
run=function(e)
c(e)
end
},
{
action="toggleswim",
description="Toggles swimming",
run=function(e)
if e:hasGarbage"swim"then
c(e)
else
d(e)
end
end
}
}end a.aG=function()local c=a.cache.aG if not c then c={c=b()}a.cache.aG=c end return c.c end end do local b=function()local b=function(

b, c, d)
local e=b.playerService:getHumanoid()
if e then
e[c]=d
end end local c=function(


c, d, e, f)
return{
action=c,
description=d,
run=function(g)
b(g,e,f)
end
}end


return{
{
action="speed|ws|walkspeed",
description="Sets your walk speed (default is 16)",
args={kind="number",name="walk speed",optional=true},
run=function(d,e)
b(d,"WalkSpeed",e:nextValue()or 16)
end
},
{
action="jpower|jumppower|jp",
description="Sets your jump power (default is 50)",
args={kind="number",name="jump power",optional=true},
run=function(d,e)
local f=d.playerService:getHumanoid()
if not f then return end

local g=e:nextValue()or 50
if f.UseJumpPower then
f.JumpPower=g
else
f.JumpHeight=g
end
end
},
{
action="maxslopeangle|msa",
description="Sets the max slope angle your humanoid can walk up (default is 89)",
args={kind="number",name="angle",optional=true},
run=function(d,e)
b(d,"MaxSlopeAngle",e:nextValue()or 89)
end
},
{
action="hipheight|hheight",
description="Sets your hip height (default depends on your rig)",
args={kind="number",name="hip height",optional=true},
run=function(d,e)
local f=d.playerService:getHumanoid()
if not f then return end

local g=f.RigType==Enum.HumanoidRigType.R15
f.HipHeight=e:nextValue()or(g and 2.1 or 0)
end
},
c("stun|platformstand","Makes your character stiff (PlatformStand)","PlatformStand",true),
c("unstun|nostun|unplatformstand|noplatformstand","Disables stun","PlatformStand",false),
c("norotate|noautorotate","Stops your character from auto rotating","AutoRotate",false),
c("unnorotate|autorotate","Lets your character auto rotate again","AutoRotate",true),
{
action="trip",
description="Trips your character forward",
run=function(d)
local e=d.playerService:getHumanoid()
local f=d.playerService:getRootPart()
if not(e and f)then return end

e:ChangeState(Enum.HumanoidStateType.FallingDown)
f.AssemblyLinearVelocity=f.CFrame.LookVector*30
end
},
{
action="breakvelocity",
description="Stops the character's movement for one second",
run=function(d)
local e=d.localPlayer.Character
if not e then return end

local f=os.clock()
task.spawn(function()
while os.clock()-f<1 do
for g,h in e:GetDescendants()do
if h:IsA"BasePart"then
h.AssemblyLinearVelocity=Vector3.zero
h.AssemblyAngularVelocity=Vector3.zero
end
end
task.wait()
end
end)
end
},
{
action="deletevelocity|dv|removevelocity|removeforces",
description="Deletes the force and velocity objects on your character",
run=function(d)
local e=d.localPlayer.Character
if not e then return end

local f={
"BodyVelocity","BodyGyro","RocketPropulsion","BodyThrust",
"BodyAngularVelocity","AngularVelocity","BodyForce","VectorForce","LineForce"
}

for g,h in e:GetDescendants()do
for i,j in f do
if h:IsA(j)then
h:Destroy()
break
end
end
end
end
}
}end a.aH=function()local c=a.cache.aH if not c then c={c=b()}a.cache.aH=c end return c.c end end do local b=function()local b=function(

b, c, d)
if b:hasGarbage(c)then
b:notify(`{c} is already enabled`)
return
end

local e=b:createGarbage(c)
e.connection=b:connect(b.robloxServices.UserInputService.JumpRequest,function()
if d and e.debouncing then return end

local f=b.playerService:getHumanoid()
if not f then return end

e.debouncing=true
f:ChangeState(Enum.HumanoidStateType.Jumping)
task.wait()
e.debouncing=false
end)end local c=function(


c, d)
local e=c:collectGarbage(d)
if e and e.connection then
e.connection:Disconnect()
end end local d=function(


d, e, f)
local g=d.playerService:getHumanoid()
local h,i=pcall(function()
return Enum.HumanoidStateType[e]
end)

if not h then
d:notify("Invalid state",`{e} is not a HumanoidStateType`)
return
end

if g then
g:SetStateEnabled(i,f)
end end


return{
{
action="sit",
description="Makes your character sit",
run=function(e)
local f=e.playerService:getHumanoid()
if f then
f.Sit=true
end
end
},
{
action="nosit",
description="Stops your character from being able to sit",
run=function(e)
d(e,"Seated",false)
end
},
{
action="unnosit",
description="Lets your character sit again",
run=function(e)
d(e,"Seated",true)
end
},
{
action="enablestate",
description="Enables a humanoid state (example: Jumping)",
args={kind="string",name="state name"},
run=function(e,f)
d(e,f:nextValue(),true)
end
},
{
action="disablestate",
description="Disables a humanoid state (example: Jumping)",
args={kind="string",name="state name"},
run=function(e,f)
d(e,f:nextValue(),false)
end
},
{
action="lay|laydown",
description="Lays your character down",
run=function(e)
local f=e.playerService:getHumanoid()
local g=e.playerService:getRootPart()
if not(f and g)then return end

f.Sit=true
task.wait(0.1)

g=e.playerService:getRootPart()
if not g then return end
g.CFrame=g.CFrame*CFrame.Angles(math.pi*0.5,0,0)

for h,i in f:GetPlayingAnimationTracks()do
i:Stop()
end
end
},
{
action="jump",
description="Makes your character jump once",
run=function(e)
local f=e.playerService:getHumanoid()
if f then
f:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
},
{
action="infjump|infinitejump",
description="Lets you jump again while in the air",
run=function(e)
b(e,"infjump",true)
end
},
{
action="uninfjump|uninfinitejump|noinfjump|noinfinitejump",
description="Disables infinite jump",
run=function(e)
c(e,"infjump")
end
},
{
action="flyjump",
description="Makes you jump every time a jump is requested",
run=function(e)
b(e,"flyjump",false)
end
},
{
action="unflyjump|noflyjump",
description="Disables flyjump",
run=function(e)
c(e,"flyjump")
end
},
{
action="nilchar",
description="Removes your character from the workspace (client side)",
run=function(e)
local f=e.localPlayer.Character
if f then
f.Parent=nil
end
end
},
{
action="unnilchar|nonilchar",
description="Puts your character back into the workspace",
run=function(e)
local f=e.localPlayer.Character
if f then
f.Parent=workspace
end
end
}
}end a.aI=function()local c=a.cache.aI if not c then c={c=b()}a.cache.aI=c end return c.c end end do local b=function()local b=function(


b, c)
if not b then return end

for d,e in b:GetDescendants()do
if c(e)then
e:Destroy()
end
end end local c=function(


c)
return c.localPlayer.Character end local d=function(


d)
local e=d.playerService:getHumanoid()
return e and e:GetAccessories()or{}end local e=function(


e)
return e:IsA"SpecialMesh"end


return{
{
action="blockhead",
description="Removes the mesh from your head (makes it block-like)",
run=function(f)
local g=c(f)
local h=g and g:FindFirstChild"Head"
local i=h and h:FindFirstChildOfClass"SpecialMesh"
if i then
i:Destroy()
end
end
},
{
action="blockhats",
description="Removes the meshes from your accessories",
run=function(f)
for g,h in d(f)do
b(h,e)
end
end
},
{
action="blocktool",
description="Removes the meshes from your equipped tools",
run=function(f)
local g=c(f)
if not g then return end

for h,i in g:GetChildren()do
if i:IsA"Tool"or i:IsA"HopperBin"then
b(i,e)
end
end
end
},
{
action="nobgui|unbgui|nobillboardgui|unbillboardgui|noname|rohg",
description="Removes BillboardGuis and SurfaceGuis from your character",
run=function(f)
b(c(f),function(g)
return g:IsA"BillboardGui"or g:IsA"SurfaceGui"
end)
end
},
{
action="naked",
description="Removes your clothing and shirt graphics",
run=function(f)
b(c(f),function(g)
return g:IsA"Clothing"or g:IsA"ShirtGraphic"
end)
end
},
{
action="noface|removeface",
description="Removes your face decal",
run=function(f)
b(c(f),function(g)
return g:IsA"Decal"and g.Name=="face"
end)
end
},
{
action="deletehats|nohats|rhats",
description="Removes the welds that hold your accessories on",
run=function(f)
b(c(f),function(g)
return g:IsA"Weld"and g:FindFirstAncestorWhichIsA"Accessory"~=nil
end)
end
},
{
action="drophats|drophat",
description="Drops your accessories into the workspace",
run=function(f)
for g,h in d(f)do
h.Parent=workspace
end
end
},
{
action="clearcharappearance|clearchar|clrchar",
description="Clears your character appearance",
run=function(f)
f.localPlayer:ClearCharacterAppearance()
end
},
{
action="split",
description="Splits your R15 character in half (removes the waist)",
run=function(f)
local g=c(f)
local h=f.playerService:getHumanoid()
if not(g and h)then return end

if h.RigType~=Enum.HumanoidRigType.R15 then
f:notify("R15 Required","This command requires the R15 rig type")
return
end

local i=g:FindFirstChild"UpperTorso"
local j=i and i:FindFirstChild"Waist"
if j then
j:Destroy()
end
end
}
}end a.aJ=function()local c=a.cache.aJ if not c then c={c=b()}a.cache.aJ=c end return c.c end end do local b=function()

local b=a.ah()local c=function(

c)
return c:IsA"Tool"or c:IsA"HopperBin"end local d=function(


d)
if not d then return end

for e,f in d:GetDescendants()do
if c(f)then
f:Destroy()
end
end end


return{
{
action="notools|rtools|clrtools|removetools|deletetools|dtools",
description="Deletes every tool in your backpack and character",
run=function(e)
d(e.localPlayer:FindFirstChildOfClass"Backpack")
d(e.localPlayer.Character)
end
},
{
action="deleteselectedtool|dst",
description="Deletes the tools you are currently holding",
run=function(e)
d(e.localPlayer.Character)
end
},
{
action="equiptools",
description="Equips every tool in your backpack",
run=function(e)
local f=e.localPlayer:FindFirstChildOfClass"Backpack"
local g=e.localPlayer.Character
if not(f and g)then return end

for h,i in f:GetChildren()do
if c(i)then
i.Parent=g
end
end
end
},
{
action="unequiptools",
description="Unequips all your tools",
run=function(e)
local f=e.playerService:getHumanoid()
if f then
f:UnequipTools()
end
end
},
{
action="droptools|droptool",
description="Drops every tool from your backpack to the workspace",
run=function(e)
local f=e.localPlayer:FindFirstChildOfClass"Backpack"
local g=e.localPlayer.Character
if not(f and g)then return end

for h,i in f:GetChildren()do
if c(i)then
i.Parent=g
end
end

task.wait()

for h,i in g:GetChildren()do
if c(i)then
i.Parent=workspace
end
end
end
},
{
action="copytools",
description="Copies the tools from a player's backpack into yours",
args={kind="player"},
run=function(e,f)
local g=e.localPlayer:FindFirstChildOfClass"Backpack"
if not g then return end

for h,i in b(f:nextValue())do
local j=i:FindFirstChildOfClass"Backpack"
if j then
for k,l in j:GetChildren()do
if c(l)then
local m=l:Clone()
m.Parent=g
end
end
end
end
end
}
}end a.aK=function()local c=a.cache.aK if not c then c={c=b()}a.cache.aK=c end return c.c end end do local b=function()

local b={
"27789359","30196114","248263260","45834924","33796059","28488254","52155728"
}

local c={
"3333432454","4555808220","4049037604","4555782893","10214311282",
"10714010337","10713981723","10714372526","10714076981","10714392151","11444443576"
}local d=function(

d)
for e,f in d:GetPlayingAnimationTracks()do
f:Stop()
end end local e=function(


e, f)
local g=e.localPlayer.Character
local h=g and g:FindFirstChild"Animate"
if h then
h.Disabled=f
end end local f=function(


f)
local g=f.playerService:getHumanoid()
local h=f.localPlayer.Character
local i=h and h:FindFirstChild"Animate"

if not(g and i)then
f:notify("Refresh Animations","Failed to get Animate/Humanoid")
return
end

i.Disabled=true
d(g)
i.Disabled=false end local g=function(


g)
local h=g:collectGarbage"dance"
if h and h.track then
h.track:Stop()
h.track:Destroy()
end end local h=function(


h, i)
h.robloxServices.StarterPlayer.AllowCustomAnimations=i
f(h)end


return{
{
action="animation|anim",
description="Plays an animation by its asset ID (optional speed)",
args={
{kind="string",name="animation id"},
{kind="number",name="speed",optional=true}
},
run=function(i,j)
local k=i.playerService:getHumanoid()
if not k then return end

local l=tostring(j:nextValue())
local m=j:nextValue()
if not l:find"rbxassetid://"then
l="rbxassetid://"..l
end

local n=Instance.new"Animation"
n.AnimationId=l

local o=k:LoadAnimation(n)
o.Priority=Enum.AnimationPriority.Movement
o:Play()

if m then
o:AdjustSpeed(m)
end
end
},
{
action="emote|em",
description="Plays an emote by its animation ID (optional speed)",
args={
{kind="number",name="emote id"},
{kind="number",name="speed",optional=true}
},
run=function(i,j)
local k=i.playerService:getHumanoid()
if not k then return end

local l=k:PlayEmoteAndGetAnimTrackById(j:nextValue())
local m=j:nextValue()
if l and m then
l:AdjustSpeed(m)
end
end
},
{
action="noanim",
description="Disables the default Roblox animations",
run=function(i)
e(i,true)
end
},
{
action="reanim",
description="Enables the default Roblox animations again",
run=function(i)
e(i,false)
end
},
{
action="animspeed",
description="Sets the speed of every playing animation (default is 1)",
args={kind="number",name="speed",optional=true},
run=function(i,j)
local k=i.playerService:getHumanoid()
if not k then return end

local l=j:nextValue()or 1
for m,n in k:GetPlayingAnimationTracks()do
n:AdjustSpeed(l)
end
end
},
{
action="stopanimations|stopanims|stopanim",
description="Stops every playing animation",
run=function(i)
local j=i.playerService:getHumanoid()
if j then
d(j)
end
end
},
{
action="refreshanimations|refreshanimation|refreshanims|refreshanim",
description="Restarts your character's default animations",
run=function(i)
f(i)
end
},
{
action="allowcustomanim|allowcustomanimations",
description="Allows custom animations on your character",
run=function(i)
h(i,true)
end
},
{
action="unallowcustomanim|unallowcustomanimations",
description="Stops custom animations on your character",
run=function(i)
h(i,false)
end
},
{
action="loopanimation|loopanim",
description="Makes the animations that are currently playing loop",
run=function(i)
local j=i.playerService:getHumanoid()
if not j then return end

for k,l in j:GetPlayingAnimationTracks()do
l.Looped=true
end
end
},
{
action="dance",
description="Plays a random dance on a loop",
run=function(i)
local j=i.playerService:getHumanoid()
if not j then return end

g(i)

local k=j.RigType==Enum.HumanoidRigType.R15 and c or b
local l=Instance.new"Animation"
l.AnimationId="rbxassetid://"..k[math.random(1,#k)]

local m=j:LoadAnimation(l)
m.Looped=true
m:Play()

i:registerGarbage"dance".track=m
end
},
{
action="undance|nodance",
description="Stops the dance",
run=function(i)
g(i)
end
}
}end a.aL=function()local c=a.cache.aL if not c then c={c=b()}a.cache.aL=c end return c.c end end do local b=function()local b=function(

b, c)
local d=b.localPlayer.Character
if not d then return end

for e,f in d:GetDescendants()do
if f:IsA"BasePart"then
f.CustomPhysicalProperties=PhysicalProperties.new(c,0.3,0.5)
end
end end


return{
{
action="strengthen",
description="Makes your body parts heavier (default is 100)",
args={kind="number",name="density",optional=true},
run=function(c,d)
b(c,d:nextValue()or 100)
end
},
{
action="weaken",
description="Makes your body parts lighter (default is 0)",
args={kind="number",name="density",optional=true},
run=function(c,d)
b(c,-(d:nextValue()or 0))
end
},
{
action="unweaken|unstrengthen",
description="Resets your body parts' density",
run=function(c)
b(c,0.7)
end
}
}end a.aM=function()local c=a.cache.aM if not c then c={c=b()}a.cache.aM=c end return c.c end end do local b=function()


local b=workspace.FallenPartsDestroyHeight

return{
{
action="antivoid",
description="Pushes you back up when you fall below the destroy height",
run=function(c)
if c:hasGarbage"antivoid"then
c:notify"antivoid is already enabled"
return
end

local d=c:createGarbage"antivoid"
d.connection=c:connect(c.runService.Stepped,function()
local e=c.playerService:getRootPart()
if e and e.Position.Y<=b+25 then
e.AssemblyLinearVelocity=e.AssemblyLinearVelocity+Vector3.new(0,250,0)
end
end)

c:notify("antivoid","Enabled")
end
},
{
action="unantivoid|noantivoid",
description="Disables antivoid",
run=function(c)
local d=c:collectGarbage"antivoid"
if d and d.connection then
d.connection:Disconnect()
c:notify("antivoid","Disabled")
end
end
}
}end a.aN=function()local c=a.cache.aN if not c then c={c=b()}a.cache.aN=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage"spasm"
if c and c.track then
c.track:Stop()
c.track:Destroy()
end end local c=function(


c)
for d,e in c:GetChildren()do
if e.Name=="Spinning"then
e:Destroy()
end
end end


return{
{
action="spasm",
description="Makes your R6 character spasm (uses an animation)",
run=function(d)
local e=d.playerService:getHumanoid()
if not e then return end

if e.RigType==Enum.HumanoidRigType.R15 then
d:notify("R6 Required","This command requires the r6 rig type")
return
end

b(d)

local f=Instance.new"Animation"
f.AnimationId="rbxassetid://33796059"

local g=e:LoadAnimation(f)
g:Play()
g:AdjustSpeed(99)

d:registerGarbage"spasm".track=g
end
},
{
action="unspasm|nospasm",
description="Stops the spasm",
run=function(d)
b(d)
end
},
{
action="headthrow",
description="Throws your R6 character's head (uses an animation)",
run=function(d)
local e=d.playerService:getHumanoid()
if not e then return end

if e.RigType==Enum.HumanoidRigType.R15 then
d:notify("R6 Required","This command requires the r6 rig type")
return
end

local f=Instance.new"Animation"
f.AnimationId="rbxassetid://35154961"

local g=e:LoadAnimation(f)
g:Play(0)
g:AdjustSpeed(1)
end
},
{
action="sitwalk",
description="Uses the sit animation while walking, running and jumping",
run=function(d)
local e=d.localPlayer.Character
local f=d.playerService:getHumanoid()
local g=e and e:FindFirstChild"Animate"
if not(f and g)then return end

local h=g:FindFirstChild"sit"
local i=h and h:FindFirstChildWhichIsA"Animation"
if not i then return end

for j,k in{"idle","walk","run","jump"}do
local l=g:FindFirstChild(k)
local m=l and l:FindFirstChildWhichIsA"Animation"
if m then
m.AnimationId=i.AnimationId
end
end

f.HipHeight=f.RigType==Enum.HumanoidRigType.R15 and 0.5 or-1.5
end
},
{
action="spin",
description="Spins your character (default speed is 20)",
args={kind="number",name="spin speed",optional=true},
run=function(d,e)
local f=d:getRoot()
if not f then return end

c(f)

local g=Instance.new"BodyAngularVelocity"
g.Name="Spinning"
g.MaxTorque=Vector3.new(0,math.huge,0)
g.AngularVelocity=Vector3.new(0,e:nextValue()or 20,0)
g.Parent=f
end
},
{
action="unspin",
description="Stops spinning your character",
run=function(d)
local e=d.playerService:getRootPart()
if e then
c(e)
end
end
}
}end a.aO=function()local c=a.cache.aO if not c then c={c=b()}a.cache.aO=c end return c.c end end do local b=function()local b=function(

b)
return b:IsA"BillboardGui"or b:IsA"SurfaceGui"end local c=function(


c, d)
for e,f in d do
local g=c:FindFirstChild(f)
if g then
g:Destroy()
end
end end


return{
{
action="creeper",
description="Gives your character a creeper look (removes the face mesh, arms and accessories)",
run=function(d)
local e=d.localPlayer.Character
local f=d.playerService:getHumanoid()
if not(e and f)then return end

local g=e:FindFirstChild"Head"
local h=g and g:FindFirstChildOfClass"SpecialMesh"
if h then
h:Destroy()
end

if f.RigType==Enum.HumanoidRigType.R15 then
c(e,{"LeftUpperArm","RightUpperArm"})
else
c(e,{"Left Arm","Right Arm"})
end

f:RemoveAccessories()
end
},
{
action="chardelete|charremove|cd",
description="Deletes every part of your character with the given name",
args={kind="string",name="item name"},
run=function(d,e)
local f=d.localPlayer.Character
local g=e:nextValue()or""
if not f then return end

for h,i in f:GetDescendants()do
if i.Name:lower()==g:lower()then
i:Destroy()
end
end

d:notify("Item(s) Deleted",`Deleted {g}`)
end
},
{
action="chardeleteclass|charremoveclass|chardeleteclassname|charremoveclassname|cdc",
description="Deletes every part of your character with the given class name",
args={kind="className",name="class name"},
run=function(d,e)
local f=d.localPlayer.Character
local g=e:nextValue()or""
if not f then return end

for h,i in f:GetDescendants()do
if i.ClassName:lower()==g:lower()then
i:Destroy()
end
end

d:notify("Item(s) Deleted",`Deleted items with ClassName {g}`)
end
},
{
action="loopnobgui|loopunbgui|loopnobillboardgui|loopunbillboardgui|loopnoname|looprohg",
description="Removes BillboardGuis and SurfaceGuis from your character, including new ones",
run=function(d)
local e=d.localPlayer.Character
if not e then return end

local f=d:collectGarbage"nobgui"
if f and f.connection then
f.connection:Disconnect()
end

for g,h in e:GetDescendants()do
if b(h)then
h:Destroy()
end
end

local g=d:createGarbage"nobgui"
g.connection=d:connect(e.DescendantAdded,function(h)
if b(h)then
task.wait()
h:Destroy()
end
end)
end
},
{
action="unloopnobgui|unloopunbgui|unloopnobillboardgui|unloopunbillboardgui|unloopnoname|unlooprohg",
description="Stops removing BillboardGuis and SurfaceGuis from your character",
run=function(d)
local e=d:collectGarbage"nobgui"
if e and e.connection then
e.connection:Disconnect()
end
end
}
}end a.aP=function()local c=a.cache.aP if not c then c={c=b()}a.cache.aP=c end return c.c end end do local b=function()

return{
{
action="noroot|removeroot|rroot",
description="Removes your character's root part (client side)",
run=function(b)
local c=b.localPlayer.Character
if not c then return end

local d=c:FindFirstChildOfClass"Humanoid"
local e=d and d.RootPart

c.Parent=nil
if e then
e:Destroy()
end
c.Parent=workspace
end
},
{
action="replaceroot|replacerootpart",
description="Replaces your character's root part with a fresh copy",
run=function(b)
local c=b.localPlayer.Character
local d=b.playerService:getRootPart()
if not(c and d)then return end

local e=c.Parent
local f=d.CFrame

c.Parent=game
local g=d:Clone()
g.Parent=c
d:Destroy()
g.CFrame=f
c.Parent=e
end
}
}end a.aQ=function()local c=a.cache.aQ if not c then c={c=b()}a.cache.aQ=c end return c.c end end do local b=function()local b=function(




b)
local c=b:registerGarbage"removespecifictool"
c.connections=c.connections or{}
return c end


return{
{
action="removespecifictool",
description="Keeps removing tools with the given name from your backpack",
args={kind="string",name="tool name"},
run=function(c,d)
local e=(d:nextValue()or""):lower()
local f=b(c)
if f.connections[e]then return end

f.connections[e]=c:connect(c.runService.RenderStepped,function()
local g=c.localPlayer:FindFirstChildOfClass"Backpack"
if not g then return end

for h,i in g:GetChildren()do
if i.Name:lower()==e then
i:Destroy()
end
end
end)
end
},
{
action="unremovespecifictool",
description="Stops removing tools with the given name",
args={kind="string",name="tool name"},
run=function(c,d)
local e=(d:nextValue()or""):lower()
local f=c:getGarbage"removespecifictool"
local g=f and f.connections and f.connections[e]

if g then
g:Disconnect()
f.connections[e]=nil
end
end
},
{
action="clearremovespecifictool",
description="Stops removing every tool that is being filtered",
run=function(c)
local d=c:collectGarbage"removespecifictool"
if not(d and d.connections)then return end

for e,f in d.connections do
f:Disconnect()
end
end
}
}end a.aR=function()local c=a.cache.aR if not c then c={c=b()}a.cache.aR=c end return c.c end end do local b=function()

local b=a.ah()

return{
{
action="walkto|follow",
description="Walks your character to a player and keeps following them",
args={kind="player"},
run=function(c,d)
local e=b(d:nextValue())[1]
if not e then return end

local f=c:collectGarbage"walkto"
if f then
f.running=false
end

local g=c.playerService:getHumanoid()
if g and g.SeatPart then
g.Sit=false
task.wait(0.1)
end

local h=c:createGarbage"walkto"
h.running=true

task.spawn(function()
while h.running do
local i=c.playerService:getHumanoid()
local j=e.Character and e.Character:FindFirstChild"HumanoidRootPart"

if not(i and j)then
break
end

i:MoveTo(j.Position)
task.wait()
end
end)
end
},
{
action="unwalkto|nowalkto|unfollow|nofollow",
description="Stops walking to the player",
run=function(c)
local d=c:collectGarbage"walkto"
if d then
d.running=false
end
end
}
}end a.aS=function()local c=a.cache.aS if not c then c={c=b()}a.cache.aS=c end return c.c end end do local b=function()local b=function(

b, c)
b.WalkSpeed=c end local c=function(


c, d)
if c.UseJumpPower then
c.JumpPower=d
else
c.JumpHeight=d
end end local d=function(


d, e)
local f=d:collectGarbage(e)
if f and f.connections then
for g,h in f.connections do
h:Disconnect()
end
end end local e=function(



e, f, g, h, i)
d(e,f)

local j=e:createGarbage(f)
j.connections={}local k=function(

k)
h(k,i)
table.insert(j.connections,e:connect(k:GetPropertyChangedSignal(g),function()
h(k,i)
end))end


local l=e.playerService:getHumanoid()
if l then
k(l)
end

table.insert(j.connections,e:connect(e.localPlayer.CharacterAdded,function(m)
k(m:WaitForChild"Humanoid")
end))end


return{
{
action="loopspeed|loopws",
description="Keeps your walk speed set, even after respawning (default is 16)",
args={kind="number",name="walk speed",optional=true},
run=function(f,g)
e(f,"loopspeed","WalkSpeed",b,g:nextValue()or 16)
end
},
{
action="unloopspeed|unloopws",
description="Stops the walk speed loop",
run=function(f)
d(f,"loopspeed")
end
},
{
action="loopjumppower|loopjp|loopjpower",
description="Keeps your jump power set, even after respawning (default is 50)",
args={kind="number",name="jump power",optional=true},
run=function(f,g)
e(f,"loopjumppower","JumpPower",c,g:nextValue()or 50)
end
},
{
action="unloopjumppower|unloopjp|unloopjpower",
description="Stops the jump power loop",
run=function(f)
d(f,"loopjumppower")
end
}
}end a.aT=function()local c=a.cache.aT if not c then c={c=b()}a.cache.aT=c end return c.c end end do local b=function()

local b=a.W()

local c=PhysicalProperties.new(100,0.3,0.5)local d=function()


local d=Instance.new"BodyAngularVelocity"
d.MaxTorque=Vector3.yAxis*math.huge
d.P=math.huge
return d end local e=function(


e, f)
if e:hasGarbage"fling"then
e:notify"fling is already enabled\ndisable using 'unfling'"
return
end

local g=e.playerService:getHumanoid()
if not(g and g.Health~=0)then return end

local h=g.Parent

e:notify"fling now is activated"
e:run"noclip"

local i=e:createGarbage"fling"
i.originalStates={}

for j,k in h:GetDescendants()do
if not k:IsA"BasePart"then continue end

i.originalStates[k]={
CustomPhysicalProperties=k.CustomPhysicalProperties,
CanCollide=k.CanCollide,
Massless=k.Massless
}

k.CustomPhysicalProperties=c

if k.Parent==h then
k.CanCollide=false
k.Massless=true
k.Velocity=Vector3.zero
end
end

local j=d()

i.flingVelocity=j
i.flingConnection=g.Died:Once(function()
e:notify"player died: disabling fling..."
e:run"unfling"
end)

j.Parent=h:WaitForChild"HumanoidRootPart"

while j and h and h.Parent do
j.AngularVelocity=Vector3.yAxis*99999
task.wait(0.2)
j.AngularVelocity=Vector3.one
task.wait(0.1)
end end local f=function(


f)
local g=f:collectGarbage"fling"
if not g then return end

if g.flingVelocity then
g.flingVelocity:Destroy()
end

if g.flingConnection then
g.flingConnection:Disconnect()
end

for h,i in g.originalStates do
for j,k in i do
h[j]=k
end
end

f:notify"fling disabled"end




local g=0.1 local h=function(

h, i)
return h~=nil and h.Parent~=nil and i~=nil and i.Parent~=nil end local i=function(


i)
if i:hasGarbage"walkfling"then
i:notify"walkfling is already enabled\ndisable using 'unwalkfling'"
return
end

local j=i:createGarbage"walkfling"


if not i:hasGarbage"noclip"then
i:run"noclip"
j.enabledNoclip=true
end

local k=i.runService local l=function()

return i:getGarbage"walkfling"==j end


j.thread=task.spawn(function()
while l()do
k.Heartbeat:Wait()

local m=i.playerService:getCharacter()
local n=m and m:FindFirstChild"HumanoidRootPart"

while l()and not h(m,n)do
k.Heartbeat:Wait()
m=i.playerService:getCharacter()
n=m and m:FindFirstChild"HumanoidRootPart"
end

if not l()then break end

local o=n.AssemblyLinearVelocity
n.AssemblyLinearVelocity=o*10000+Vector3.new(0,10000,0)

k.RenderStepped:Wait()
if h(m,n)then
n.AssemblyLinearVelocity=o
end

k.Stepped:Wait()
if h(m,n)then
n.AssemblyLinearVelocity=o+Vector3.new(0,g,0)
end
end
end)


local m=i.playerService:getHumanoid()
if m then
j.diedConnection=i:connect(m.Died,function()
i:run"unwalkfling"
end)
end end local j=function(


j)
local k=j:collectGarbage"walkfling"
if not k then return end

if k.diedConnection then
k.diedConnection:Disconnect()
end

if k.enabledNoclip then
j:run"unnoclip"
end end local k=function(


k, l)
k:run"unvehiclefly"
k:run"unwalkfling"

local m=l and l:nextValue()
if m then
k.privateEnv.vehicleFlySpeed=m
end


k:run("vehiclefly",b.new{})
i(k)end local l=function(


l)
l:run"unvehiclefly"
l:run"unwalkfling"
l:run"breakvelocity"end


return{
{
action="fling|forcefling",
description="Flings anyone you touch",
run=e
},
{
action="unfling",
description="Disables the fling command",
run=f
},
{
action="flyfling",
description="Basically the invisfling command but not invisible",
args={
kind="number",
name="speed",
optional=true
},
run=k
},
{
action="unflyfling",
description="Disables the flyfling command",
run=l
},
{
action="walkfling",
description="Basically fling but no spinning",
run=i
},
{
action="unwalkfling|nowalkfling",
description="Disables walkfling",
run=j
},
{
action="invisfling",
description="Enables invisible fling (the invis part is patched, try using the god command before using this)",
run=function(m)
m:run"invisible"

task.spawn(function()
m:run"fling"
end)
end
},
{
action="antifling",
description="Disables player collisions to prevent you from being flung",
run=function(m)
if m:hasGarbage"antifling"then return end

local n=m:createGarbage"antifling"
n.connection=m:connect(m.runService.Stepped,function()
for o,p in m.players:GetPlayers()do
if p~=m.localPlayer and p.Character then
for q,r in p.Character:GetDescendants()do
if r:IsA"BasePart"then
r.CanCollide=false
end
end
end
end
end)
end
},
{
action="unantifling",
description="Disables antifling",
run=function(m)
local n=m:collectGarbage"antifling"
if n then
n.connection:Disconnect()
end
end
}
}end a.aU=function()local c=a.cache.aU if not c then c={c=b()}a.cache.aU=c end return c.c end end do local b=function()local b=function(






b, c)
local d=b.playerService:getCharacter()
if not d then return end

for e,f in d:GetDescendants()do
if(f:IsA"BasePart"or f:IsA"Decal")and c.originals[f]==nil then
c.originals[f]=f.Transparency
f.Transparency=1
end
end end local c=function(


c)
local d=c:getGarbage"invisible"
if d and d.connection and d.connection.Connected then
c:notify("Invisible","you are already invisible")
return
end


local e={}
if d then
e=d.originals or{}
c:collectGarbage"invisible"
if d.connection then
d.connection:Disconnect()
end
end

local f=c:createGarbage"invisible"
f.originals=e

b(c,f)


f.connection=c:connect(c.localPlayer.CharacterAdded,function()
b(c,f)
end)

c:notify("Invisible","other players can no longer see your character")end local d=function(


d)
local e=d:collectGarbage"invisible"
if not e then return false end

if e.connection then
e.connection:Disconnect()
end

for f,g in e.originals do
if f.Parent then
f.Transparency=g
end
end

return true end


return{
{
action="invisible|invis",
description="Makes you invisible to other players",
run=function(e)
c(e)
end
},
{
action="visible|vis",
description="Makes you visible to other players",
run=function(e)
if not d(e)then
e:notify("Visible","you are already visible")
end
end
},
{
action="toolinvisible|toolinvis|tinvis",
description="Makes you invisible to other players and able to use tools",
run=function(e)
c(e)
end
}
}end a.aV=function()local c=a.cache.aV if not c then c={c=b()}a.cache.aV=c end return c.c end end do local b=function()local b=function(

b, c)
for d,e in c do
local f=b:FindFirstChild(e)
if f then
f:Destroy()
end
end end local c=function(


c)
local d=c.playerService:getHumanoid()
return d~=nil and d.RigType==Enum.HumanoidRigType.R15 end


return{
{
action="noarms",
description="Removes your arms",
run=function(d)
local e=d.localPlayer.Character
if e then
b(e,c(d)and{"RightUpperArm","LeftUpperArm"}or{"Right Arm","Left Arm"})
end
end
},
{
action="nolegs",
description="Removes your legs",
run=function(d)
local e=d.localPlayer.Character
if e then
b(e,c(d)and{"RightUpperLeg","LeftUpperLeg"}or{"Right Leg","Left Leg"})
end
end
},
{
action="nolimbs",
description="Removes your limbs",
run=function(d)
local e=d.localPlayer.Character
if e then
b(e,c(d)
and{"RightUpperLeg","LeftUpperLeg","RightUpperArm","LeftUpperArm"}
or{"Right Leg","Left Leg","Right Arm","Left Arm"})
end
end
}
}end a.aW=function()local c=a.cache.aW if not c then c={c=b()}a.cache.aW=c end return c.c end end do local b=function()local b=function(


b)
local c=b:collectGarbage"hatspin"
if not c then return end

c.connection:Disconnect()

for d,e in c.accessories do
local f=e:FindFirstChild"Handle"
if f then
for g,h in f:GetChildren()do
if h:IsA"BodyPosition"or h:IsA"BodyAngularVelocity"then
h:Destroy()
end
end
end

if c.character:IsDescendantOf(workspace)then

e.Parent=workspace
task.wait()
e.Parent=c.character
end
end end


return{
{
action="hatspin|spinhats",
description="Spins your characters accessories",
args={
kind="number",
name="spin speed",
optional=true
},
run=function(c,d)
b(c)

local e=c.playerService:getHumanoid()
local f=c.playerService:getCharacter()
if not(e and f)then return end

local g=d:nextValue()or 100

local h=c:createGarbage"hatspin"
h.character=f
h.accessories={}
h.keeps={}

for i,j in e:GetAccessories()do
local k=j:FindFirstChild"Handle"
local l=k and k:FindFirstChildOfClass"Weld"
if l then
l:Destroy()


local m=Instance.new"BodyPosition"
m.P=30000
m.D=50
m.Parent=k

local n=Instance.new"BodyAngularVelocity"
n.AngularVelocity=Vector3.new(0,g,0)
n.MaxTorque=Vector3.new(0,g*2,0)
n.Parent=k

table.insert(h.accessories,j)
table.insert(h.keeps,m)
end
end

h.connection=c:connect(c.runService.Stepped,function()
local i=c.playerService:getCharacter()
if i~=f then
b(c)
return
end

local j=f:FindFirstChild"Head"
if not j then return end

for k,l in h.keeps do
l.Position=j.Position
end
end)
end
},
{
action="unhatspin|unspinhats",
description="Undoes spinhats",
run=function(c)
b(c)
end
},
{
action="clearhats|cleanhats",
description="Clears hats in the workspace",
run=function(c)
local d=c:expectExploit"firetouchinterest"
if not d then return end


task.spawn(function()
local e=c.playerService:getCharacter()
local f=c.playerService:getHumanoid()
local g=c.playerService:getRootPart()
if not(e and f and g)then return end

local h=g.CFrame

local i={}
for j,k in workspace:GetChildren()do
if k:IsA"Accessory"then
table.insert(i,k)
end
end

for j,k in f:GetAccessories()do
k:Destroy()
end

for j,k in i do
local l=k:FindFirstChild"Handle"
local m=c.playerService:getRootPart()
if l and m then
d(l,m,0)
end


local n=0
while e.Parent and not e:FindFirstChildOfClass"Accessory"and n<120 do
task.wait()
n=n+1
end

local o=e:FindFirstChildOfClass"Accessory"
if o then
o:Destroy()
end
task.wait()
end

c.playerService:resetCharacter()
c.localPlayer.CharacterAdded:Wait()


for j=1,20 do
task.wait()
local k=c.playerService:getRootPart()
if k then
k.CFrame=h
end
end
end)
end
}
}end a.aX=function()local c=a.cache.aX if not c then c={c=b()}a.cache.aX=c end return c.c end end do local b=function()



local b=60


local function copyTools(c,d)
for e,f in c:GetChildren()do
if f:IsA"Tool"or f:IsA"HopperBin"then
f:Clone().Parent=d
end
copyTools(f,d)
end
end local c=function(

c)
if not c then return end

for d,e in c:GetChildren()do
if e:IsA"Tool"then
e.CanBeDropped=true
end
end end local d=function(




d, e)
local f=d.playerService:getHumanoid()
if f and e:IsA"BackpackItem"and e:FindFirstChild"Handle"then
f:EquipTool(e)
end end local e=function(


e)
local f=e:collectGarbage"grabtools"
if f and f.connection then
f.connection:Disconnect()
end end local f=function(


f)
e(f)

local g=f:createGarbage"grabtools"

for h,i in workspace:GetChildren()do
d(f,i)
end

g.connection=f:connect(workspace.ChildAdded,function(h)
d(f,h)
end)end local g=function(





g)
local h=g:collectGarbage"reach"
if not h then return end

for i,j in h.records do
local k=j.handle

local l=k:FindFirstChild"SelectionBoxCreated"
if l then
l:Destroy()
end

k.Size=j.size
k.Massless=j.massless
j.tool.GripPos=j.gripPos
end end local h=function(


h, i)
g(h)

local j=h.playerService:getCharacter()
local k=h.playerService:getHumanoid()
if not(j and k)then
h:notify("Reach","your character is not loaded")
return
end

local l=h:createGarbage"reach"
l.records={}

for m,n in j:GetDescendants()do
if not n:IsA"Tool"then continue end

local o=n:FindFirstChild"Handle"
if not(o and o:IsA"BasePart")then continue end

table.insert(l.records,{
tool=n,
handle=o,
size=o.Size,
massless=o.Massless,
gripPos=n.GripPos
})

local p=Instance.new"SelectionBox"
p.Name="SelectionBoxCreated"
p.Adornee=o
p.Parent=o

o.Massless=true
o.Size=i
n.GripPos=Vector3.zero
end


k:UnequipTools()end


return{
{
action="tools|gears",
description="Copies tools from ReplicatedStorage and Lighting",
run=function(i)
local j=i.localPlayer:FindFirstChildOfClass"Backpack"
if not j then
i:notify("Tools","your backpack is not loaded")
return
end

copyTools(i.robloxServices.Lighting,j)
copyTools(i.robloxServices.ReplicatedStorage,j)

i:notify("Tools","Copied tools from ReplicatedStorage and Lighting")
end
},
{
action="grabtools",
description="Automatically get tools that are dropped",
run=function(i)
f(i)
i:notify("Grabtools","Picking up any dropped tools")
end
},
{
action="ungrabtools|nograbtools",
description="Disables grabtools",
run=function(i)
e(i)
i:notify("Grabtools","Grabtools has been disabled")
end
},
{
action="dupetools|clonetools",
description="Duplicates your inventory tools a set amount of times",
args={
kind="number"
},
run=function(i,j)
local k=i.localPlayer:FindFirstChildOfClass"Backpack"
if not k then
i:notify("Dupetools","your backpack is not loaded")
return
end


local l=math.clamp(math.floor(j:nextValue()or 1),1,100)
local m=0

for n,o in k:GetChildren()do
if o:IsA"Tool"or o:IsA"HopperBin"then
for p=1,l do
o:Clone().Parent=k
m=m+1
end
end
end

i:notify("Dupetools",`added {m} tool(s)`)
end
},
{
action="droppabletools",
description="Makes your tools droppable",
run=function(i)
c(i.playerService:getCharacter())
c(i.localPlayer:FindFirstChildOfClass"Backpack")
end
},
{
action="reach",
description="Increases the hitbox of your held tool",
args={
kind="number"
},
run=function(i,j)
local k=j and j:nextValue()or b
h(i,Vector3.new(0.5,0.5,k))
end
},
{
action="boxreach",
description="Increases the hitbox of your held tool in a box shape",
args={
kind="number"
},
run=function(i,j)
local k=j and j:nextValue()or b
h(i,Vector3.one*k)
end
},
{
action="unreach|noreach|unboxreach",
description="Turns off reach",
run=function(i)
g(i)
end
},
{
action="grippos",
description="Changes your current tools grip position",
args={
kind="vector3"
},
run=function(i,j)
local k=i.localPlayer.Character
local l=i.localPlayer:FindFirstChildOfClass"Backpack"
if not(k and l)then return end

local m=j:nextValue()
for n,o in k:GetChildren()do
if o:IsA"Tool"then
o.Parent=l
o.GripPos=m
o.Parent=k
end
end
end
},
{
action="usetools",
description="Activates all tools in your backpack at the same time",
args={
{
kind="number",
name="tools amount",
optional=true
},
{
kind="number",
name="equip delay",
optional=true
}
},
run=function(i,j)
local k=i.localPlayer:FindFirstChildOfClass"Backpack"
local l=i.playerService:getCharacter()
if not(k and l)then return end

local m=j:nextValue()or 1
local n=j:nextValue()

for o,p in k:GetChildren()do
if not p:IsA"Tool"then continue end

p.Parent=l
task.spawn(function()
for q=1,m do
p:Activate()
if n then
task.wait(n)
end
end
p.Parent=k
end)
end
end
}
}end a.aY=function()local c=a.cache.aY if not c then c={c=b()}a.cache.aY=c end return c.c end end do local b=function()local b=function(


b, c)
local d=b:collectGarbage(c)
if d then
d.connection:Disconnect()
end end local c=function(



c, d)
local e=c.CFrame.LookVector*3
local f=Ray.new(c.Position-Vector3.new(0,1.5,0),e)
local g=Ray.new(c.Position+Vector3.new(0,1.5,0),e)

return workspace:FindPartOnRay(f,d)~=nil or workspace:FindPartOnRay(g,d)~=nil end


return{
{
action="autojump|ajump",
description="Automatically jumps when you run into an object",
run=function(d)
b(d,"autojump")

local e=d:createGarbage"autojump"
e.connection=d:connect(d.runService.RenderStepped,function()
local f=d.playerService:getCharacter()
local g=d.playerService:getHumanoid()
local h=d.playerService:getRootPart()
if f and g and h and c(h,f)then
g.Jump=true
end
end)
end
},
{
action="unautojump|noautojump|noajump|unajump",
description="Disables autojump",
run=function(d)
b(d,"autojump")
end
},
{
action="edgejump|ejump",
description="Automatically jumps when you get to the edge of an object",
run=function(d)
b(d,"edgejump")

local e=d:createGarbage"edgejump"
e.connection=d:connect(d.runService.RenderStepped,function()
local f=d.playerService:getHumanoid()
local g=d.playerService:getRootPart()
if not(f and g)then return end

local h=e.state
local i=f:GetState()
e.state=i


if h~=i and i==Enum.HumanoidStateType.Freefall and h~=Enum.HumanoidStateType.Jumping and e.lastCFrame then
g.CFrame=e.lastCFrame
local j=g.AssemblyLinearVelocity
g.AssemblyLinearVelocity=Vector3.new(j.X,f.JumpPower,j.Z)
end

e.lastCFrame=g.CFrame
end)
end
},
{
action="unedgejump|noedgejump|noejump|unejump",
description="Disables edgejump",
run=function(d)
b(d,"edgejump")
end
}
}end a.aZ=function()local c=a.cache.aZ if not c then c={c=b()}a.cache.aZ=c end return c.c end end do local b=function()local b=function(




b, c, d)
local e=b.privateEnv.spoofs or{}
b.privateEnv.spoofs=e

local f=e[c]
if f then
f.value=d
return
end

local g=b:expectExploit"hookmetamethod"
local h=b:expectExploit"checkcaller"
if not(g and h)then return end

local i=b.localPlayer
local j=string.lower(c)

f={value=d}
e[c]=f local k=function(

k, l)
if h()or typeof(k)~="Instance"or typeof(l)~="string"then
return false
end
if string.lower(l)~=j or not k:IsA"Humanoid"then
return false
end

local m=i.Character
return m~=nil and k:IsDescendantOf(m)end


local l
l=g(game,"__index",function(m,n)
if k(m,n)then
return f.last or f.value
end
return l(m,n)
end)

local m
m=g(game,"__newindex",function(n,o,p)
if k(n,o)then
f.last=tonumber(p)
end
return m(n,o,p)
end)end


return{
{
action="spoofspeed|spoofws",
description="Spoofs your WalkSpeed on the Client",
args={
kind="number"
},
run=function(c,d)
local e=d:nextValue()
if e then
b(c,"WalkSpeed",e)
end
end
},
{
action="spoofjumppower|spoofjp",
description="Spoofs your JumpPower on the Client",
args={
kind="number"
},
run=function(c,d)
local e=d:nextValue()
if e then
b(c,"JumpPower",e)
end
end
}
}end a.a_=function()local c=a.cache.a_ if not c then c={c=b()}a.cache.a_=c end return c.c end end do local b=function()

local b=a.ah()local c=function(


c)
if c==1 then
return Vector3.new(2,1,1)
end
return Vector3.one*c end


return{
{
action="headsize",
description="Expands the head size for players Head (default is 1)",
args={
{
kind="player"
},
{
kind="number",
name="head size",
optional=true
}
},
run=function(d,e)
local f=b(e:nextValue())
local g=e:nextValue()or 1

for h,i in f do
local j=i~=d.localPlayer and i.Character and i.Character:FindFirstChild"Head"
if j and j:IsA"BasePart"then
j.CanCollide=false
j.Size=c(g)
end
end
end
},
{
action="hitbox",
description="Expands the hitbox for players HumanoidRootPart (default is 1)",
args={
{
kind="player"
},
{
kind="number",
name="size",
optional=true
},
{
kind="number",
name="transparency",
optional=true,
clamp={0,1}
}
},
run=function(d,e)
local f=b(e:nextValue())
local g=e:nextValue()or 1
local h=e:nextValue()or 0.4

for i,j in f do
local k=j~=d.localPlayer and j.Character and j.Character:FindFirstChild"HumanoidRootPart"
if k and k:IsA"BasePart"then
k.CanCollide=false
k.Size=c(g)
k.Transparency=h
end
end
end
}
}end a.a0=function()local c=a.cache.a0 if not c then c={c=b()}a.cache.a0=c end return c.c end end do local b=function()

local b=a.ah()local c=function(

c)
local d=c:collectGarbage"orbit"
if not d then return end

for e,f in d.connections do
f:Disconnect()
end end


return{
{
action="orbit",
description="Makes your character orbit around a player with an optional speed and an optional distance",
args={
{
kind="player"
},
{
kind="number",
name="speed",
optional=true
},
{
kind="number",
name="distance",
optional=true
}
},
run=function(d,e)
c(d)

local f=b(e:nextValue())[1]
local g=e:nextValue()or 0.2
local h=e:nextValue()or 6

local i=d.playerService:getHumanoid()
if not(f and i)then return end

local j=d:createGarbage"orbit"
j.connections={}

local k=0 local l=function()


return f.Character and f.Character:FindFirstChild"HumanoidRootPart"end


table.insert(j.connections,d:connect(d.runService.Heartbeat,function()
local m=d.playerService:getRootPart()
local n=l()
if not(m and n)then return end

k=k+g
m.CFrame=CFrame.new(n.Position)*CFrame.Angles(0,math.rad(k),0)*CFrame.new(h,0,0)
end))


table.insert(j.connections,d:connect(d.runService.RenderStepped,function()
local m=d.playerService:getRootPart()
local n=l()
if m and n then
m.CFrame=CFrame.new(m.Position,n.Position)
end
end))

table.insert(j.connections,d:connect(i.Died,function()
c(d)
end))

table.insert(j.connections,d:connect(i.Seated,function(m)
if m then
c(d)
end
end))

d:notify("Orbit","Started orbiting "..f.Name)
end
},
{
action="unorbit",
description="Disables orbit",
run=function(d)
if not d:hasGarbage"orbit"then return end

c(d)
d:notify("Orbit","Stopped orbiting player")
end
}
}end a.a1=function()local c=a.cache.a1 if not c then c={c=b()}a.cache.a1=c end return c.c end end do local b=function()

local b=a.ah()local c=function(

c)
local d=c:collectGarbage"headsit"
if d then
d.connection:Disconnect()
end end


return{
{
action="headsit",
description="Sit on a players head",
args={
kind="player"
},
run=function(d,e)
local f=b(e:nextValue())[1]
if not f then return end

c(d)

local g=d.playerService:getHumanoid()
if not g then return end
g.Sit=true

local h=d:createGarbage"headsit"
h.connection=d:connect(d.runService.Heartbeat,function()
local i=d.playerService:getRootPart()
local j=d.playerService:getHumanoid()
local k=f.Character and f.Character:FindFirstChild"HumanoidRootPart"

if not(i and j and k and j.Sit)then
c(d)
return
end

i.CFrame=k.CFrame*CFrame.new(0,1.6,0.4)
end)
end
}
}end a.a2=function()local c=a.cache.a2 if not c then c={c=b()}a.cache.a2=c end return c.c end end do local b=function()

return{
{
action="god",
description="Makes your character difficult to kill in most games",
run=function(b)
local c=b.localPlayer
local d=c.Character
local e=d and d:FindFirstChildWhichIsA"Humanoid"
if not e then return end

local f=workspace.CurrentCamera
local g=f.CFrame


local h=e:Clone()
h.Parent=d

c.Character=nil
h:SetStateEnabled(Enum.HumanoidStateType.Dead,false)
h:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
h:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
h.BreakJointsOnDeath=true
e:Destroy()
c.Character=d

f.CameraSubject=h
task.wait()
f.CFrame=g
h.DisplayDistanceType=Enum.HumanoidDisplayDistanceType.None


local i=d:FindFirstChild"Animate"
if i then
i.Disabled=true
task.wait()
i.Disabled=false
end

h.Health=h.MaxHealth
end
}
}end a.a3=function()local c=a.cache.a3 if not c then c={c=b()}a.cache.a3=c end return c.c end end do local b=function()

local b=a.ah()


local c=workspace.FallenPartsDestroyHeight


local d="rbxassetid://72042024"local e=function(

e)
if e.track then
e.track:Stop()
end
if e.connection then
e.connection:Disconnect()
end end


return{
{
action="fakeout",
description="Tp to the void and then back (useful to kill people attached to you)",
run=function(f)
local g=f.playerService:getRootPart()
if not g then return end

local h=g.CFrame


local i=f:hasGarbage"antivoid"
if i then
f:run"unantivoid"
end


pcall(function()
workspace.FallenPartsDestroyHeight=0/0
end)

g.CFrame=CFrame.new(0,c-25,0)
task.wait(1)

local j=f.playerService:getRootPart()
if j then
j.CFrame=h
end

pcall(function()
workspace.FallenPartsDestroyHeight=c
end)

if i then
f:run"antivoid"
end
end
},
{
action="scare|spook",
description="Teleports in front of a player for half a second",
args={
kind="player"
},
run=function(f,g)
local h=b(g:nextValue())[1]
local i=f.playerService:getRootPart()
local j=h and h~=f.localPlayer and h.Character and h.Character:FindFirstChild"HumanoidRootPart"
if not(i and j)then return end

local k=i.CFrame
i.CFrame=j.CFrame+j.CFrame.LookVector*2
i.CFrame=CFrame.new(i.Position,j.Position)
task.wait(0.5)

local l=f.playerService:getRootPart()
if l then
l.CFrame=k
end
end
},
{
action="jerk",
description="Makes you jork it",
run=function(f)
local g=f:collectGarbage"jerk"
if g then
local h=g.track~=nil and g.track.IsPlaying
e(g)
if h then return end
end

local h=f.playerService:getHumanoid()
local i=h and h:FindFirstChildOfClass"Animator"
if not i then
f:notify("Jerk","your character has no Animator")
return
end

local j=Instance.new"Animation"
j.AnimationId=d

local k,l=pcall(function()
return i:LoadAnimation(j)
end)
if not k then
f:notify("Jerk","could not load the jerk animation (check JERK_ANIMATION_ID in scare.luau)")
return
end

l.Looped=true
l:Play()

local m=f:createGarbage"jerk"
m.track=l

m.connection=f:connect(h.Died,function()
local n=f:collectGarbage"jerk"
if n then
e(n)
end
end)
end
}
}end a.a4=function()local c=a.cache.a4 if not c then c={c=b()}a.cache.a4=c end return c.c end end do local b=function()

local b=a.ah()

local c="rbxassetid://148840371"
local d="rbxassetid://5918726674"
local e="rbxassetid://282574440"local f=function(


f)
if not f then return nil end

return f:FindFirstChild"Torso"
or f:FindFirstChild"UpperTorso"
or f:FindFirstChild"LowerTorso"
or f:FindFirstChild"HumanoidRootPart"end local g=function(



g, h)
local i=Instance.new"Animation"
i.AnimationId=h

local j=g:LoadAnimation(i)
j:Play(0.1,1,1)
return j,i end local h=function(


h)
local i=h:collectGarbage"bang"
if not i then return end

for j,k in i.connections do
k:Disconnect()
end
i.track:Stop()
i.animation:Destroy()end local i=function(


i)
local j=i:collectGarbage"carpet"
if not j then return end

for k,l in j.connections do
l:Disconnect()
end
j.track:Stop()
j.animation:Destroy()end


return{
{
action="bang",
description="owo",
args={
{
kind="player"
},
{
kind="number",
name="speed",
optional=true
}
},
run=function(j,k)
h(j)

local l=b(k:nextValue())[1]
local m=k:nextValue()or 3

local n=j.playerService:getHumanoid()
if not(l and n)then return end

local o=n.RigType==Enum.HumanoidRigType.R15 and d or c
local p,q=g(n,o)
p:AdjustSpeed(m)

local r=j:createGarbage"bang"
r.track=p
r.animation=q
r.connections={}

table.insert(r.connections,j:connect(n.Died,function()
h(j)
end))

local s=CFrame.new(0,0,1.1)
table.insert(r.connections,j:connect(j.runService.Stepped,function()
local t=j.playerService:getRootPart()
local u=f(l.Character)
if t and u then
t.CFrame=u.CFrame*s
end
end))
end
},
{
action="unbang",
description="uwu",
run=function(j)
h(j)
end
},
{
action="carpet",
description="Be someones carpet",
args={
kind="player"
},
run=function(j,k)
local l=j.playerService:getHumanoid()
if not l then return end

if l.RigType==Enum.HumanoidRigType.R15 then
j:notify("R6 Required","This command requires the r6 rig type")
return
end

i(j)

local m=b(k:nextValue())[1]
if not m then return end

local n,o=g(l,e)

local p=j:createGarbage"carpet"
p.track=n
p.animation=o
p.connections={}

table.insert(p.connections,j:connect(l.Died,function()
i(j)
end))

table.insert(p.connections,j:connect(j.runService.Heartbeat,function()
local q=j.playerService:getRootPart()
local r=m.Character and m.Character:FindFirstChild"HumanoidRootPart"
if q and r then
q.CFrame=r.CFrame
end
end))
end
},
{
action="uncarpet",
description="Undoes carpet",
run=function(j)
i(j)
end
}
}end a.a5=function()local c=a.cache.a5 if not c then c={c=b()}a.cache.a5=c end return c.c end end do local b=function()

local b=a.ah()

local c="507768375"
local d="180435571"

return{
{
action="copyanimation|copyanim|copyemote",
description="Copies someone elses animation",
args={
kind="player"
},
run=function(e,f)
local g=e.playerService:getHumanoid()
if not g then return end

for h,i in b(f:nextValue())do
local j=i.Character and i.Character:FindFirstChildOfClass"Humanoid"
if j then
for k,l in g:GetPlayingAnimationTracks()do
l:Stop()
end

for k,l in j:GetPlayingAnimationTracks()do
if not string.find(l.Animation.AnimationId,c,1,true)then
local m=g:LoadAnimation(l.Animation)
m:Play(0.1,1,l.Speed)
m.TimePosition=l.TimePosition

task.spawn(function()
l.Stopped:Wait()
m:Stop()
m:Destroy()
end)
end
end
end
end
end
},
{
action="copyanimationid|copyanimid|copyemoteid",
description="Copies your animation id or someone elses to your clipboard",
args={
kind="player",
optional=true
},
run=function(e,f)
local g=e:expectExploit"setclipboard"
if not g then return end

local h=e.localPlayer
local i=f:nextValue()
if i then
h=b(i)[1]
end

local j=h and h.Character and h.Character:FindFirstChildWhichIsA"Humanoid"
if not j then
e:notify("Animations","character is not loaded")
return
end

local k={}
for l,m in j:GetPlayingAnimationTracks()do
local n=m.Animation.AnimationId
local o=string.find(n,c,1,true)
or string.find(n,d,1,true)

if not o then
local p=string.match(n,"rbxassetid://(%d+)")
if p then
local q,r=pcall(function()
return e.robloxServices.MarketplaceService:GetProductInfo(tonumber(p))
end)

local s="Failed to get name"
if q then
s=r.Name
end

table.insert(k,"Name: "..s.."\nAnimation Id: "..n)
else
table.insert(k,"Animation Id: "..n)
end
end
end

if#k==0 then
e:notify("Animations","No animations to copy")
return
end

g("Animations Copied\n\n"..table.concat(k,"\n\n"))
e:notify("Animations","Copied to clipboard")
end
}
}end a.a6=function()local c=a.cache.a6 if not c then c={c=b()}a.cache.a6=c end return c.c end end do local b=function()

return{a.az()
,a.aA()
,a.aB()
,a.aC()
,a.aD()
,a.aE()
,a.aF()
,a.aG()
,a.aH()
,a.aI()
,a.aJ()
,a.aK()
,a.aL()
,a.aM()
,a.aN()
,a.aO()
,a.aP()
,a.aQ()
,a.aR()
,a.aS()
,a.aT()
,a.aU()
,a.aV()
,a.aW()
,a.aX()
,a.aY()
,a.aZ()
,a.a_()
,a.a0()
,a.a1()
,a.a2()
,a.a3()
,a.a4()
,a.a5()
,a.a6()

}end a.a7=function()local c=a.cache.a7 if not c then c={c=b()}a.cache.a7=c end return c.c end end do local b=function()




local b="showingWaypoints"
local c="Waypoints"local d=function()


return tostring(game.PlaceId)end local e=function(




e, f)
local g=e.storage.waypoints

if f then
return g:register(d(),{})
end

local h=g:getValue(d())
return type(h)=="table"and h or nil end local f=function(



f)
local g={}

for h,i in e(f)or{}do
table.insert(g,{
name=h,
position=f:unstringify(i,"Vector3")
})
end

table.sort(g,function(h,i)
return h.name:lower()<i.name:lower()
end)

return g end local g=function(



g, h)
local i=h:lower()

for j,k in f(g)do
if k.name:lower()==i then
return k
end
end

return nil end local h=function(




h, i, j)
local k=e(h,true)
local l=i:lower()

for m in k do
if m:lower()==l then
k[m]=nil
end
end

k[i]=h:stringify(j)
h.storage.waypoints:save()end local i=function(


i, j)
local k=e(i)
if k then
k[j.name]=nil
end

i.storage.waypoints:save()end local j=function(


j)
local k=0

if type(j)=="table"then
for l in j do
k=k+1
end
end

return k end local k=function(


k)
return`({math.round(k.X)}, {math.round(k.Y)}, {math.round(k.Z)})`end local l=function(


l)
local m=l:collectGarbage(b)
if not m then return end

for n,o in m do
o:Destroy()
end end local m=function(


m)
local n=Instance.new"Part"
n.Size=Vector3.new(5,5,5)
n.CFrame=CFrame.new(m.position)
n.Anchored=true
n.CanCollide=false
n.CanTouch=false
n.CanQuery=false
n.Parent=workspace

local o=Instance.new"BoxHandleAdornment"
o.Adornee=n
o.AlwaysOnTop=true
o.ZIndex=10
o.Size=n.Size
o.Parent=n

local p=Instance.new"BillboardGui"
p.Adornee=n
p.AlwaysOnTop=true
p.Size=UDim2.fromOffset(160,30)
p.StudsOffset=Vector3.new(0,4,0)
p.Parent=n

local q=Instance.new"TextLabel"
q.BackgroundTransparency=1
q.Size=UDim2.fromScale(1,1)
q.Text=m.name
q.TextColor3=Color3.new(1,1,1)
q.TextStrokeTransparency=0
q.TextScaled=true
q.Parent=p

return n end local n=function(



n)
l(n)

local o=n:registerGarbage(b)
local p=f(n)

for q,r in p do
table.insert(o,m(r))
end

return#p end local o=function(



o)
if o:hasGarbage(b)then
n(o)
end end local p=function(


p, q)
local r=g(p,q)
if not r then
p:notify(c,`there is no waypoint named '{q}'`)
end
return r end local q=function(



q)
local r=q.playerService:getHumanoid()
if r and r.SeatPart then
r.Sit=false
task.wait(0.1)
end end


return{
{
action="setwaypoint|swp",
description="Sets a waypoint at your position",
args={kind="string",name="waypoint name"},
run=function(r,s)
local t=r:getRoot()
if not t then return end

local u=s:nextValue()

h(r,u,t.Position)
o(r)
r:notify(c,`saved waypoint '{u}' at {k(t.Position)}`)
end
},
{
action="waypointpos|wpp",
description="Sets a waypoint with specified coordinates",
args={
{kind="string",name="waypoint name"},
{kind="vector3",name="position"},
},
run=function(r,s)
local t=s:nextValue()
local u=s:nextValue()

h(r,t,u)
o(r)
r:notify(c,`saved waypoint '{t}' at {k(u)}`)
end
},
{
action="waypoints",
description="Shows a list of currently active waypoints",
run=function(r)
local s=f(r)

if#s==0 then
r:notify(c,"there are no waypoints in this game")
return
end

local t={}
for u,v in s do
table.insert(t,`{v.name} {k(v.position)}`)
end

r:notify(c,table.concat(t,", "))
end
},
{
action="showwaypoints|showwp",
description="Shows all currently set waypoints",
run=function(r)
if#f(r)==0 then
r:notify(c,"there are no waypoints to show")
return
end

n(r)
end
},
{
action="hidewaypoints|hidewp",
description="Hides shown waypoints",
run=function(r)
l(r)
end
},
{
action="waypoint|wp",
description="Teleports player to a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(r,s)
local t=p(r,s:nextValue())
if not t then return end

local u=r:getRoot()
if not u then return end

u.CFrame=CFrame.new(t.position)
u.AssemblyLinearVelocity=Vector3.zero
end
},
{
action="tweenwaypoint|twp",
description="Tweens player to a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(r,s)
local t=p(r,s:nextValue())
if not t then return end

q(r)

local u=r:getRoot(r)
if not u then return end

local v=TweenInfo.new(r.privateEnv.tweenSpeed or 1,Enum.EasingStyle.Linear)
r.robloxServices.TweenService:Create(u,v,{CFrame=CFrame.new(t.position)}):Play()
end
},
{
action="walktowaypoint|wtwp",
description="Walks player to a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(r,s)
local t=p(r,s:nextValue())
if not t then return end

q(r)

local u=r.playerService:getHumanoid()
if u then
u:MoveTo(t.position)
end
end
},
{
action="deletewaypoint|dwp",
description="Deletes a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(r,s)
local t=p(r,s:nextValue())
if not t then return end

i(r,t)
o(r)
r:notify(c,`deleted waypoint '{t.name}'`)
end
},
{
action="clearwaypoints|cwp",
description="Clears all waypoints from every game",
args={kind="boolean",name="confirm",optional=true},
run=function(r,s)
local t=s:nextValue()
if not t then
r:notify(c,"cancelled, use 'true' to confirm")
return
end

local u=r.storage.waypoints
local v=0

for w,x in u:getData()do
v=v+j(x)
u:setValue(w,nil)
end

u:save()
l(r)
r:notify(c,`deleted {v} waypoints from every game`)
end
},
{
action="cleargamewaypoints|cgamewp",
description="Clears all waypoints for the game you are in",
args={kind="boolean",name="confirm",optional=true},
run=function(r,s)
local t=s:nextValue()
if not t then
r:notify(c,"cancelled, use 'true' to confirm")
return
end

local u=r.storage.waypoints
local v=j(e(r))

u:setValue(d(),nil)
u:save()
l(r)
r:notify(c,`deleted {v} waypoints from this game`)
end
}
}end a.a8=function()local c=a.cache.a8 if not c then c={c=b()}a.cache.a8=c end return c.c end end do local b=function()

return{
action="tweenspeed|tspeed",
description="Sets how fast all tween commands go (default is 1)",
args={kind="number",name="tween speed",optional=true},
run=function(b,c)
b.privateEnv.tweenSpeed=c:nextValue()or 1
end
}end a.a9=function()local c=a.cache.a9 if not c then c={c=b()}a.cache.a9=c end return c.c end end do local b=function()

local b=a.ah()local c=function(


c)
local d=c.playerService:getHumanoid()
if d and d.SeatPart then
d.Sit=false
task.wait(0.1)
end end local d=function(



d)
local e=d:collectGarbage"loopgoto"
if e and e.id then
d.loopService:remove(e.id)
end end


return{
{
action="goto",
description="Go to a player",
args={kind="player"},
run=function(e,f)
local g=b(f:nextValue())[1]
local h=g and g.Character
if not h then return end

c(e)

local i=e.playerService:getRootPart()
if i then
i.CFrame=h:GetPivot()+Vector3.new(3,1,0)
i.AssemblyLinearVelocity=Vector3.zero
end
end
},
{
action="tweengoto|tgoto",
description="Tween to a player (bypasses some anti cheats)",
args={
{kind="player"},
{
kind="number",
name="tween speed",
optional=true
}
},
run=function(e,f)
local g=b(f:nextValue())[1]
local h=g and g.Character
if not h then return end

local i=f:nextValue()or e.privateEnv.tweenSpeed or 1

c(e)

local j=e.playerService:getRootPart()
if not j then return end

local k=TweenInfo.new(i,Enum.EasingStyle.Linear)
e.robloxServices.TweenService:Create(j,k,{
CFrame=h:GetPivot()+Vector3.new(3,1,0)
}):Play()
end
},
{
action="loopgoto",
description="Loop teleport to a player",
args={
{kind="player"},
{
kind="number",
name="distance",
optional=true
},
{
kind="number",
name="delay",
optional=true
}
},
run=function(e,f)
d(e)

local g=b(f:nextValue())[1]
local h=f:nextValue()or 3
local i=f:nextValue()or 0
if not g then return end

c(e)

local j=e:createGarbage"loopgoto"
j.id=e.loopService:add(function()
if g.Parent==nil then
d(e)
return
end

local k=e.playerService:getRootPart()
local l=g.Character
if k and l then
k.CFrame=l:GetPivot()+Vector3.new(h,1,0)
end
end,i)
end
},
{
action="unloopgoto",
description="Stops teleporting you to a player",
run=function(e)
d(e)
end
}
}end a.ba=function()local c=a.cache.ba if not c then c={c=b()}a.cache.ba=c end return c.c end end do local b=function()

local b=a.ah()

return{
action="vehiclegoto|vgoto",
description="Go to a player while in a vehicle",
args={kind="player"},
run=function(c,d)
local e=c.playerService:getHumanoid()
local f=e and e.SeatPart
if not f then
c:notify("vehiclegoto","you are not sitting in a vehicle")
return
end

local g=b(d:nextValue())[1]
local h=g and g.Character and g.Character:FindFirstChild"HumanoidRootPart"
if not h then return end

local i=f:FindFirstAncestorWhichIsA"Model"
if i then
i:MoveTo(h.Position)
end
end
}end a.bb=function()local c=a.cache.bb if not c then c={c=b()}a.cache.bb=c end return c.c end end do local b=function()

local b=a.ah()

return{
action="pulsetp|ptp",
description="Teleports you to a player for a specified amount of time",
args={
{
kind="player"
},
{
kind="number",
name="time amount"
}
},
run=function(c,d)
local e=b(d:nextValue())[1]
local f=d:nextValue()or 1

local g=e and e.Character and e.Character:FindFirstChild"HumanoidRootPart"
if not g then return end

local h=c.playerService:getHumanoid()
if h and h.SeatPart then
h.Sit=false
task.wait(0.1)
end

local i=c.playerService:getRootPart()
if not i then return end

local j=i.CFrame
i.CFrame=g.CFrame+Vector3.new(3,1,0)
task.wait(f)

local k=c.playerService:getRootPart()
if k then
k.CFrame=j
k.AssemblyLinearVelocity=Vector3.zero
end
end
}end a.bc=function()local c=a.cache.bc if not c then c={c=b()}a.cache.bc=c end return c.c end end do local b=function()

local b=a.ah()local c=function(


c, d)
local e=c:getGarbage"loopbring"
if not e then return end

if d then
for f,g in d do
e.targets[g]=nil
end
else
e.targets={}
end

if next(e.targets)==nil then
c:collectGarbage"loopbring"
if e.id then
c.loopService:remove(e.id)
end
end end


return{
{
action="clientbring|cbring",
description="Bring a player (CLIENT)",
args={
kind="player"
},
run=function(d,e)
for f,g in b(e:nextValue())do
local h=g.Character
local i=h and h:FindFirstChild"HumanoidRootPart"
if i then
local j=h:FindFirstChildOfClass"Humanoid"
if j then
j.Sit=false
end
task.wait()

local k=d.playerService:getRootPart()
if k then
i.CFrame=k.CFrame+Vector3.new(3,1,0)
end
end
end
end
},
{
action="loopbring",
description="Loop brings a player to you (useful for killing) (CLIENT)",
args={
{
kind="player"
},
{
kind="number",
name="distance",
optional=true
},
{
kind="number",
name="bring delay",
optional=true
}
},
run=function(d,e)
local f=b(e:nextValue())
local g=e:nextValue()or 3
local h=e:nextValue()or 0


local i=d:registerGarbage"loopbring"
i.targets=i.targets or{}
i.distance=g
for j,k in f do
if k~=d.localPlayer then
i.targets[k]=true
end
end

if i.id then
d.loopService:remove(i.id)
end

i.id=d.loopService:add(function()
local j=d.playerService:getRootPart()

for k in i.targets do
if k.Parent==nil then
i.targets[k]=nil
else
local l=k.Character and k.Character:FindFirstChild"HumanoidRootPart"
if j and l then
l.CFrame=j.CFrame+Vector3.new(i.distance,1,0)
end
end
end
end,h)
end
},
{
action="unloopbring",
description="Undoes loopbring",
args={
kind="player",
optional=true
},
run=function(d,e)
local f=e:nextValue()
if f then
c(d,b(f))
else
c(d,nil)
end
end
}
}end a.bd=function()local c=a.cache.bd if not c then c={c=b()}a.cache.bd=c end return c.c end end do local b=function()

local b=a.ah()

local c="IYFloatPlatform"

return{
{
client=true,
action="freeze|fr",
description="Freezes a player",
args={kind="player"},
run=function(d,e)
for f,g in b(e:nextValue())do
local h=g.Character
if h then
for i,j in h:GetDescendants()do
if j:IsA"BasePart"and not j.Anchored then
j.Anchored=true
end
end
end
end
end
},
{
client=true,
action="unfreeze|thaw|unfr",
description="Unfreezes a player",
args={kind="player"},
run=function(d,e)
for f,g in b(e:nextValue())do
local h=g.Character
if h then
for i,j in h:GetDescendants()do
if j:IsA"BasePart"and j.Anchored and j.Name~=c then
j.Anchored=false
end
end
end
end
end
}
}end a.be=function()local c=a.cache.be if not c then c={c=b()}a.cache.be=c end return c.c end end do local b=function()local b=function(


b, c)
local d=b.playerService:getCharacter()
if not d then return end

local e=d:FindFirstChildOfClass"Humanoid"or d:FindFirstChildOfClass"AnimationController"
if not e then return end

for f,g in e:GetPlayingAnimationTracks()do
g:AdjustSpeed(c)
end end


return{
{
action="freezeanims",
description="Freezes your animations / pauses your animations - Does not work on default animations",
run=function(c)
b(c,0)
end
},
{
action="unfreezeanims",
description="Unfreezes your animations / plays your animations",
run=function(c)
b(c,1)
end
}
}end a.bf=function()local c=a.cache.bf if not c then c={c=b()}a.cache.bf=c end return c.c end end do local b=function()local b=function(

b, c)
local d=b.playerService:getRootPart()
if d then
d.Anchored=c
end end


return{
{
action="anchor",
description="Anchors your characters RootPart",
run=function(c)
b(c,true)
end
},
{
action="unanchor",
description="Unanchors your characters RootPart",
run=function(c)
b(c,false)
end
}
}end a.bg=function()local c=a.cache.bg if not c then c={c=b()}a.cache.bg=c end return c.c end end do local b=function()local b=function(

b)
return b.playerService:getRootPart()end


return{
{
action="tpposition|tppos",
description="Teleports you to certain coordinates",
args={kind="vector3"},
run=function(c,d)
local e=d:nextValue()
local f=b(c)
if f then
f.CFrame=CFrame.new(e)
f.AssemblyLinearVelocity=Vector3.zero
end
end
},
{
action="tweentpposition|ttppos",
description="Tween to coordinates (bypasses some anti cheats)",
args={
{
kind="vector3"
},
{
kind="number",
name="tween speed",
optional=true
}
},
run=function(c,d)
local e=d:nextValue()
local f=d:nextValue()or c.privateEnv.tweenSpeed or 1

local g=b(c)
if not g then return end

local h=TweenInfo.new(f,Enum.EasingStyle.Linear)
c.robloxServices.TweenService:Create(g,h,{CFrame=CFrame.new(e)}):Play()
end
},
{
action="offset",
description="Offsets you by certain coordinates",
args={kind="vector3"},
run=function(c,d)
local e=c.playerService:getCharacter()
if e then
e:TranslateBy(d:nextValue())
end
end
},
{
action="tweenoffset|toffset",
description="Tween offset (bypasses some anti cheats)",
args={
{
kind="vector3"
},
{
kind="number",
name="tween speed",
optional=true
}
},
run=function(c,d)
local e=d:nextValue()
local f=d:nextValue()or c.privateEnv.tweenSpeed or 1

local g=b(c)
if not g then return end

local h=TweenInfo.new(f,Enum.EasingStyle.Linear)
c.robloxServices.TweenService:Create(g,h,{CFrame=CFrame.new(g.Position+e)}):Play()
end
},
{
action="thru",
description="Teleports you [num] studs ahead of where your character is facing",
args={
kind="number",
optional=true
},
run=function(c,d)
local e=d:nextValue()or 5
local f=b(c)
if not f then return end

local g=f.CFrame.LookVector
local h=f.CFrame.Position+g*e
f.CFrame=CFrame.new(h,h+g)
end
}
}end a.bh=function()local c=a.cache.bh if not c then c={c=b()}a.cache.bh=c end return c.c end end do local b=function()

local b=a.ah()local c=function(


c, d)
local e=c.localPlayer
if d then
e=b(d)[1]
end

local f=e and e.Character
local g=f and(f:FindFirstChild"HumanoidRootPart"or f:FindFirstChildWhichIsA"BasePart")
if not g then return nil end

local h=g.Position
return tostring(math.round(h.X))..", "..tostring(math.round(h.Y))..", "..tostring(math.round(h.Z))end


return{
{
action="notifyposition|notifypos",
description="Notifies you the coordinates of a character",
args={
kind="player",
optional=true
},
run=function(d,e)
local f=c(d,e:nextValue())
if f then
d:notify("Position",f)
else
d:notify("Position","character is not loaded")
end
end
},
{
action="copyposition|copypos",
description="Copies the coordinates of a character to your clipboard",
args={
kind="player",
optional=true
},
run=function(d,e)
local f=d:expectExploit"setclipboard"
if not f then return end

local g=c(d,e:nextValue())
if g then
f(g)
else
d:notify("Position","character is not loaded")
end
end
}
}end a.bi=function()local c=a.cache.bi if not c then c={c=b()}a.cache.bi=c end return c.c end end do local b=function()

return{
action="walktoposition|walktopos",
description="Makes you walk to a coordinate",
args={kind="vector3"},
run=function(b,c)
local d=c:nextValue()

local e=b.playerService:getHumanoid()
if e and e.SeatPart then
e.Sit=false
task.wait(0.1)
end

e=b.playerService:getHumanoid()
if e then
e.WalkToPoint=d
end
end
}end a.bj=function()local c=a.cache.bj if not c then c={c=b()}a.cache.bj=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage"spawnpoint"
if c then
c.connection:Disconnect()
end
return c~=nil end


return{
{
action="spawnpoint|spawn",
description="Sets a position where you will spawn",
args={
kind="number",
name="delay",
optional=true
},
run=function(c,d)
local e=c.playerService:getRootPart()
if not e then return end

local f=d:nextValue()or 0.1
b(c)

local g=c:createGarbage"spawnpoint"
g.cframe=e.CFrame
g.delay=f


g.connection=c:connect(c.localPlayer.CharacterAdded,function(h)
h:WaitForChild("HumanoidRootPart",10)
task.wait(g.delay)

local i=c.playerService:getRootPart()
if i then
i.CFrame=g.cframe
end
end)

c:notify("Spawn Point","Spawn point created")
end
},
{
action="nospawnpoint|nospawn",
description="Removes your custom spawn point",
run=function(c)
if b(c)then
c:notify("Spawn Point","Removed spawn point")
end
end
}
}end a.bk=function()local c=a.cache.bk if not c then c={c=b()}a.cache.bk=c end return c.c end end do local b=function()

local b={
connections={}
}

local c=a.b()

if c.connectionService then c.connectionService:cleanup()end
c.connectionService=b

b.cleanup=function(d)
for e,f in d.connections do
f:Disconnect()
end end


b.disconnect=function(d, e)
if e then
e:Disconnect()
end end


b.Connect=function(d, e, f)
local g=e:Connect(f)
table.insert(d.connections,g)
return g end


return b end a.bl=function()local c=a.cache.bl if not c then c={c=b()}a.cache.bl=c end return c.c end end do local b=function()
local b=a.bl()
local c=a.af()

local d local e=function(

e)
local f=e:WaitForChild("Humanoid",10)
if not f then return end

b:Connect(f.Died,function()
local g=e:FindFirstChild"HumanoidRootPart"
if g then
d=g.CFrame
end
end)end


b:Connect(c.CharacterAdded,e)
if c.Character then
task.spawn(e,c.Character)
end

return{
action="flashback|diedtp",
description="Teleports you to where you last died",
run=function(f)
if not d then
f:notify("flashback","you have not died yet")
return
end

local g=f.playerService:getHumanoid()
if g and g.SeatPart then
g.Sit=false
task.wait(0.1)
end

local h=f.playerService:getRootPart()
if h then
h.CFrame=d
end
end
}end a.bm=function()local c=a.cache.bm if not c then c={c=b()}a.cache.bm=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage"walltp"
if c then
c.connection:Disconnect()
end end


return{
{
action="walltp",
description="Teleports you above/over any wall you run into",
run=function(c)
b(c)

local d=c.playerService:getCharacter()
local e=d and(d:FindFirstChild"UpperTorso"or d:FindFirstChild"Torso")
if not e then return end

local f=c:createGarbage"walltp"
f.connection=c:connect(e.Touched,function(g)
local h=c.playerService:getRootPart()
local i=c.playerService:getHumanoid()
if not(h and i and g.Parent)then return end
if not g:IsA"BasePart"then return end
if g.Position.Y<=h.Position.Y-i.HipHeight then return end

local j=h.CFrame.LookVector
local k=g.Parent:FindFirstChild"HumanoidRootPart"
if k then
h.CFrame=g.CFrame*CFrame.new(j.X,k.Size.Z/2+i.HipHeight,j.Z)
else
h.CFrame=g.CFrame*CFrame.new(j.X,g.Size.Y/2+i.HipHeight,j.Z)
end
end)
end
},
{
action="nowalltp|unwalltp",
description="Disables walltp",
run=function(c)
b(c)
end
}
}end a.bn=function()local c=a.cache.bn if not c then c={c=b()}a.cache.bn=c end return c.c end end do local b=function()

return{
action="teleporttool|tptool",
description="Gives you a teleport tool",
run=function(b)
local c=b.localPlayer:FindFirstChildOfClass"Backpack"
if not c then
b:notify("Teleport Tool","your backpack is not loaded")
return
end

local d=Instance.new"Tool"
d.Name="Teleport Tool"
d.RequiresHandle=false
d.Parent=c


b:connect(d.Activated,function()
local e=b.playerService:getRootPart()
local f=b.playerService:getMouse()
if not(e and f.Hit)then return end

local g=f.Hit.Position+Vector3.new(0,3,0)
e.CFrame=CFrame.new(g)*(e.CFrame-e.CFrame.Position)
e.AssemblyLinearVelocity=Vector3.zero
end)
end
}end a.bo=function()local c=a.cache.bo if not c then c={c=b()}a.cache.bo=c end return c.c end end do local b=function()local b=function(



b, c, d)
local e=b.playerService:getHumanoid()
if e and e.SeatPart then
e.Sit=false
task.wait(0.1)
end

task.wait(b.privateEnv.gotopartDelay or 0.1)

local f=b.playerService:getRootPart()
if not f then return end

if d then
local g=TweenInfo.new(b.privateEnv.tweenSpeed or 1,Enum.EasingStyle.Linear)
b.robloxServices.TweenService:Create(f,g,{CFrame=c}):Play()
else
f.CFrame=c
end end local c=function(



c)
return{
action=c.action,
description=c.description,
args={kind=c.kind,name=c.argName},
run=function(d,e)
local f=(e:nextValue()or""):lower()

for g,h in workspace:GetDescendants()do
if h:IsA(c.className)and h[c.field]:lower()==f then
b(d,c.cframeOf(h),c.tween)
end
end
end
}end local d=function(



d)
return{
action=d.action,
description=d.description,
args={kind=d.kind,name=d.argName},
run=function(e,f)
local g=(f:nextValue()or""):lower()
local h=e.playerService:getRootPart()
if not h then return end

for i,j in workspace:GetDescendants()do
if j:IsA(d.className)and j[d.field]:lower()==g then
j.CFrame=h.CFrame
end
end
end
}end local e=function(


e)
return e.CFrame end local f=function(


f)
return f:GetPivot()end


return{
c{
action="gotopart|topart",
description="Teleports you to every part with the given name",
kind="string",argName="part name",
className="BasePart",field="Name",cframeOf=e,tween=false
},
c{
action="tweengotopart|tgotopart|ttopart",
description="Tweens you to every part with the given name",
kind="string",argName="part name",
className="BasePart",field="Name",cframeOf=e,tween=true
},
c{
action="gotopartclass|gpc",
description="Teleports you to every part with the given class name",
kind="className",argName="class name",
className="BasePart",field="ClassName",cframeOf=e,tween=false
},
c{
action="tweengotopartclass|tgpc",
description="Tweens you to every part with the given class name",
kind="className",argName="class name",
className="BasePart",field="ClassName",cframeOf=e,tween=true
},
c{
action="gotomodel|tomodel",
description="Teleports you to every model with the given name",
kind="string",argName="model name",
className="Model",field="Name",cframeOf=f,tween=false
},
c{
action="tweengotomodel|tgotomodel|ttomodel",
description="Tweens you to every model with the given name",
kind="string",argName="model name",
className="Model",field="Name",cframeOf=f,tween=true
},
d{
action="bringpart",
description="Brings every part with the given name to you",
kind="string",argName="part name",
className="BasePart",field="Name"
},
d{
action="bringpartclass|bpc",
description="Brings every part with the given class name to you",
kind="className",argName="class name",
className="BasePart",field="ClassName"
},
{
action="gotopartdelay",
description="Sets the delay before the goto part commands teleport (default is 0.1)",
args={kind="number",name="delay",optional=true},
run=function(g,h)
g.privateEnv.gotopartDelay=h:nextValue()or 0.1
end
}
}end a.bp=function()local c=a.cache.bp if not c then c={c=b()}a.cache.bp=c end return c.c end end do local b=function()

return{
action="mouseteleport|mousetp",
description="Teleports you to the spot your mouse is pointing at",
run=function(b)
local c=b.playerService:getRootPart()
local d=b.playerService:getMouse()
if not(c and d.Hit)then return end

local e=d.Hit.Position+Vector3.new(0,3,0)
c.CFrame=CFrame.new(e)*(c.CFrame-c.CFrame.Position)
c.AssemblyLinearVelocity=Vector3.zero
end
}end a.bq=function()local c=a.cache.bq if not c then c={c=b()}a.cache.bq=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage"tpwalk"
if c then
c.connection:Disconnect()
end end local c=function(




c)
local d=c.privateEnv.wallwalkSetEnabled
if d then
return d
end

local e,f=pcall(function()
return c.fetchService.load("backups/wallwalker.luau","iy/wallwalker")()
end)

if not e then
c:notify("Wallwalk","failed to fetch script")
return
end

c.privateEnv.wallwalkSetEnabled=f
return f end


return{
{
action="tpwalk|teleportwalk",
description="Teleports you to your move direction",
args={
{
kind="number",
name="distance",
optional=true
},
{
kind="boolean",
name="stack distance",
optional=true
}
},
run=function(d,e)
b(d)

local f=e:nextValue()or 1
local g=e:nextValue()
if g then
d.privateEnv.tpwalkStack=(d.privateEnv.tpwalkStack or 0)+f
end

local h=d.playerService:getCharacter()
local i=d.playerService:getHumanoid()
if not(h and i)then return end

local j=d:createGarbage"tpwalk"
j.connection=d:connect(d.runService.Heartbeat,function(k)
if not(h.Parent and i.Parent)then
b(d)
return
end

local l=i.MoveDirection
if l.Magnitude>0 then
local m=f+(d.privateEnv.tpwalkStack or 0)
h:TranslateBy(l*m*k*10)
end
end)
end
},
{
action="untpwalk|unteleportwalk",
description="Undoes tpwalk / teleportwalk",
run=function(d)
d.privateEnv.tpwalkStack=0
b(d)
end
},
{
action="wallwalk|walkonwalls",
description="Walk on walls",
run=function(d)
local e=d:collectGarbage"wallwalk"
if e and e.active then
e.stop()
d:notify("Wallwalk","disabled")
return
end

local f=c(d)
if not f then return end

local g,h=pcall(f,true)
if not g then
d:notify("Wallwalk",`could not start: {tostring(h)}`)
return
end

local i=d:createGarbage"wallwalk"
i.active=true
i.stop=function()
i.active=false
pcall(f,false)
end

d:notify("Wallwalk","walk on any surface; run wallwalk again to turn it off")
end
},
{
action="unwallwalk|nowallwalk",
description="Turns off wallwalk",
run=function(d)
local e=d:collectGarbage"wallwalk"
local f=e~=nil and e.active==true

if e and e.stop then
e.stop()
end

d:notify("Wallwalk",if f then"disabled"else"it is not running")
end
}
}end a.br=function()local c=a.cache.br if not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()




local b=a.ah()
local c=a.h()

local d=c.PathfindingService

local e=0.5
local f=3 local g=function(


g)
local h=g.playerService:getRootPart()
local i=g.playerService:getHumanoid()
if h and i then
i:MoveTo(h.Position)
end end local h=function(


h)
local i=h:collectGarbage"pathfind"
if not i then return false end

i.running=false
g(h)
return true end local i=function(



i, j, k)
local l=i.playerService:getHumanoid()
local m=i.playerService:getRootPart()
if not(l and m)then return end

local n=d:CreatePath()
local o=pcall(function()
n:ComputeAsync(m.Position,k)
end)

if not o or n.Status~=Enum.PathStatus.Success then
l:MoveTo(k)
task.wait(e)
return
end

for p,q in n:GetWaypoints()do
if not(j.running and l.Parent)then return end

if q.Action==Enum.PathWaypointAction.Jump then
l.Jump=true
end

local r=false
local s=l.MoveToFinished:Connect(function()
r=true
end)

l:MoveTo(q.Position)

local t=0
while j.running and not r and t<f do
task.wait(0.1)
t=t+0.1
end

s:Disconnect()
end end local j=function(




j, k, l)
h(j)

local m=j:createGarbage"pathfind"
m.running=true

task.spawn(function()
while m.running do
local n=l()
if not n then break end

i(j,m,n)

if not k then break end
task.wait(e)
end

if j:getGarbage"pathfind"==m then
j:collectGarbage"pathfind"
end
end)end


return{
{
action="pathfindwalkto|pathfindfollow",
description="Follow a player using pathfinding",
args={
kind="player"
},
run=function(k,l)
local m=b(l:nextValue())[1]
if not m then
k:notify("Pathfind","player not found")
return
end

j(k,true,function()
local n=m.Character and m.Character:FindFirstChild"HumanoidRootPart"
return n and n.Position
end)
end
},
{
action="pathfindwalktowaypoint|pathfindwalktowp|pftowp",
description="Walk to a waypoint using pathfinding",
args={
kind="waypoint"
},
run=function(k,l)
local m=l:nextValue()
local n=k.storage.waypoints:getValue(tostring(game.PlaceId))
local o=type(n)=="table"and m and n[m]

if not o then
k:notify("Pathfind",`there is no waypoint named '{m}'`)
return
end

local p=k:unstringify(o,"Vector3")
j(k,false,function()
return p
end)
end
},
{
action="unpathfind|nopathfind|pathfindstop",
description="Stops pathfindwalkto and pathfindwalktowaypoint",
run=function(k)
if h(k)then
k:notify("Pathfind","stopped")
else
k:notify("Pathfind","nothing is walking right now")
end
end
}
}end a.bs=function()local c=a.cache.bs if not c then c={c=b()}a.cache.bs=c end return c.c end end do local b=function()

return{a.a9()
,a.ba()
,a.bb()
,a.bc()
,a.bd()
,a.be()
,a.bf()
,a.bg()
,a.bh()
,a.bi()
,a.bj()
,a.bk()
,a.bm()
,a.bn()
,a.bo()
,a.bp()
,a.bq()
,a.br()
,a.bs()

}end a.bt=function()local c=a.cache.bt if not c then c={c=b()}a.cache.bt=c end return c.c end end do local b=function()

return a.k().new"createdWaypoints"end a.bu=function()local c=a.cache.bu if not c then c={c=b()}a.cache.bu=c end return c.c end end do local b=function()
return a.k().new"installedPlugins"end a.bv=function()local c=a.cache.bv if not c then c={c=b()}a.cache.bv=c end return c.c end end do local b=function()
return a.k().new(".userData",{
encrypt=true
})end a.bw=function()local c=a.cache.bw if not c then c={c=b()}a.cache.bw=c end return c.c end end do local b=function()
return a.k().new"aliases"end a.bx=function()local c=a.cache.bx if not c then c={c=b()}a.cache.bx=c end return c.c end end do local b=function()
return a.k().new"totalUsedCommands"end a.by=function()local c=a.cache.by if not c then c={c=b()}a.cache.by=c end return c.c end end do local b=function()
return{
waypoints=a.bu(),
plugins=a.bv(),
settings=a.l(),
user=a.bw(),
aliases=a.bx(),
usedCmds=a.by(),
testedCmds=a.av()
}end a.bz=function()local c=a.cache.bz if not c then c={c=b()}a.cache.bz=c end return c.c end end do local b=function()




local b=a.h()

local c={}

c.isLegacy=function()
return b.TextChatService.ChatVersion==Enum.ChatVersion.LegacyChatService end



c.send=function(d)
d=tostring(d)

local e,f=pcall(function()
if c.isLegacy()then
b.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(d,"All")
else
b.TextChatService.TextChannels.RBXGeneral:SendAsync(d)
end
end)

return e,if e then nil else tostring(f)end


return c end a.bA=function()local c=a.cache.bA if not c then c={c=b()}a.cache.bA=c end return c.c end end do local b=function()






local b={
Color3.fromRGB(253,41,67),
Color3.fromRGB(1,162,255),
Color3.fromRGB(2,184,87),
Color3.fromRGB(107,50,124),
Color3.fromRGB(218,133,65),
Color3.fromRGB(245,205,48),
Color3.fromRGB(232,186,200),
Color3.fromRGB(215,197,154),
}

local c={
Color3.fromRGB(196,40,28),
Color3.fromRGB(13,105,172),
Color3.fromRGB(39,70,45),
Color3.fromRGB(107,50,124),
Color3.fromRGB(218,133,65),
Color3.fromRGB(245,205,48),
Color3.fromRGB(232,186,200),
Color3.fromRGB(215,197,154),
}

local d={}



d.value=function(e)
local f=0
local g=#e

for h=1,g do
local i=string.byte(e,h)
local j=g-h+1

if g%2==1 then
j=j-1
end

if j%4>=2 then
i=-i
end

f=f+i
end

return f end



d.forPlayer=function(e, f)
if e.Team then
return e.Team.TeamColor.Color
end

local g=if f then c else b
return g[d.value(e.Name)%#g+1]end


return d end a.bB=function()local c=a.cache.bB if not c then c={c=b()}a.cache.bB=c end return c.c end end do local b=function()






local b=a.h()
local c=a.a()
local d=a.j()
local e=a.bz()
local f=a.d()
local g=a.bl()
local h=a.bA()
local i=a.bB()

local j=500
local k="https://files.catbox.moe/i968v2.jpg"
local l="logsWebhook"

local m={
chatEnabled=false,
joinEnabled=false,
started=false,
entries={chat={},join={}},
listeners={},
}

local n={}local o=function(

o, p)
p.time=os.date"%H:%M:%S"

local q=m.entries[o]
table.insert(q,p)
if#q>j then
table.remove(q,1)
end

for r,s in m.listeners do
task.spawn(s,o,p)
end end


m.getWebhook=function()
local p=e.settings:getValue(l)
if type(p)=="string"and p~=""then
return p
end
return nil end


m.setWebhook=function(p)
e.settings:setValue(l,p)
e.settings:save()end local p=function(



p)
local q=p.UserId
if n[q]then
return n[q]
end

local r=k
local s=c.httprequest

if s then
local t,u=pcall(function()
local t=s{
Url=`https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds={q}&size=420x420&format=Png&isCircular=false`,
Method="GET",
}
return b.HttpService:JSONDecode(t.Body).data
end)

local v=t and type(u)=="table"and u[1]
if type(v)=="table"and v.state=="Completed"and v.imageUrl then
r=v.imageUrl
end
end

n[q]=r
return r end local q=function(


q, r)
local s=m.getWebhook()
local t=c.httprequest
if not(s and t)then
return
end


task.spawn(function()
local u=b.HttpService:JSONEncode{
content=r,
avatar_url=p(q),
username=q.Name,
allowed_mentions={parse={}},
}

local v,w=pcall(t,{
Url=s,
Method="POST",
Headers={["Content-Type"]="application/json"},
Body=u,
})

if not v then
f:warn(`chat logs webhook failed: {w}`)
end
end)end local r=function(


r, s)
if not m.chatEnabled then
return
end

o("chat",{
name=r.Name,
message=s,
color=i.forPlayer(r,h.isLegacy()),
})
q(r,s)end



m.start=function()
if m.started then
return
end
m.started=true

local s=b.Players local t=function(

t)
if h.isLegacy()then
g:Connect(t.Chatted,function(u)
r(t,u)
end)
end end


for u,v in s:GetPlayers()do
t(v)
end

g:Connect(s.PlayerAdded,function(u)
if m.joinEnabled then
o("join",{
name=u.Name,
userId=u.UserId,
color=i.forPlayer(u,h.isLegacy()),
})
end
t(u)
end)

if not h.isLegacy()then
g:Connect(b.TextChatService.MessageReceived,function(u)
local v=u.TextSource
if not v or u.Status==Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
return
end

local w=s:GetPlayerByUserId(v.UserId)
if not w then
return
end

local x=u.Text
if u.WasRewritten then
x=`(rephrased) {u.RewrittenText}`
end

r(w,x)
end)
end end


m.setChat=function(s)
m.chatEnabled=s
if s then
m.start()
end end


m.setJoin=function(s)
m.joinEnabled=s
if s then
m.start()
end end



m.onEntry=function(s)
table.insert(m.listeners,s)end


m.clear=function(s)
table.clear(m.entries[s])end



m.save=function(s)
local t=c.writefile
if not t then
return false,"your exploit does not support writing files"
end

local u={}
for v,w in m.entries[s]do
if s=="chat"then
table.insert(u,`[{w.time}] {w.name}: {w.message}`)
else
table.insert(u,`[{w.time}] {w.name} ({w.userId}) joined`)
end
end

local v=d.privateFolder
if c.makefolder then
pcall(c.makefolder,v)
end

local w=`{v}/{s}logs-{os.time()}.txt`
local x,y=pcall(t,w,table.concat(u,"\n"))
if x then
return true,w
end
return false,tostring(y)end


return m end a.bC=function()local c=a.cache.bC if not c then c={c=b()}a.cache.bC=c end return c.c end end do local b=function()

local b=a.bC()

return{
{
action="logs",
description="Opens the chat logs window with chat and join logs turned on",
run=function(c)
b.setChat(true)
b.setJoin(true)
c.infiniteYield:chatLogs"chat"
end
},
{
action="chatlogs|clogs",
description="Turns on chat logs and opens the chat tab",
run=function(c)
b.setChat(true)
c.infiniteYield:chatLogs"chat"
end
},
{
action="joinlogs|jlogs",
description="Turns on join logs and opens the joins tab",
run=function(c)
b.setJoin(true)
c.infiniteYield:chatLogs"join"
end
},
{
action="chatlogswebhook|logswebhook",
description="Set a discord webhook for chatlogs to go to (provide no url to disable this)",
args={
kind="string",
name="url",
optional=true
},
run=function(c,d)
local e=d:nextValue()

if not e then
b.setWebhook(nil)
c:notify("Logs Webhook","webhook disabled")
return
end

if not c.executorEnv.httprequest then
c:notify("Incompatible Exploit","Your exploit does not support this command (missing request)")
return
end

b.setWebhook(e)
c:notify("Logs Webhook","chat logs will be sent to the webhook")
end
}
}end a.bD=function()local c=a.cache.bD if not c then c={c=b()}a.cache.bD=c end return c.c end end do local b=function()

local b=a.bA()
local c=a.ah()

local d="spam"
local e="pmspam:"local f=function(


f, g, h)
local i,j=b.send(h)
if not i then
f:notify(g,j)
end
return i end local g=function(


g)
local h=g:collectGarbage(d)
if h then
h.running=false
end end local h=function(



h, i)
g(h)

local j=h:createGarbage(d)
j.running=true

task.spawn(function()
while j.running do
if not f(h,"Spam",i)then
j.running=false
break
end
task.wait(h.privateEnv.spamSpeed or 1)
end

if h:getGarbage(d)==j then
h:collectGarbage(d)
end
end)end local i=function(


i)
return e..i.Name end local j=function(


j, k)
local l=j:collectGarbage(k)
if l then
l.running=false
end end local k=function(



k, l, m)
local n=i(l)
j(k,n)

local o=k:createGarbage(n)
o.running=true

task.spawn(function()
while o.running and l.Parent==k.players do
if not f(k,"PM Spam",`/w {l.Name} {m}`)then
o.running=false
break
end
task.wait(k.privateEnv.spamSpeed or 1)
end

if k:getGarbage(n)==o then
k:collectGarbage(n)
end
end)end local l=function(


l)
local m={}
for n in pairs(l.garbages)do
if n:sub(1,#e)==e then
table.insert(m,n)
end
end
return m end local m=function(




m, n)
local o={}
for p,q in c(n)do
table.insert(o,i(q))
end

if not c.isSelector(n)then
local p=n:lower()
for q,r in l(m)do
local s=r:sub(#e+1):lower()
if s:sub(1,#p)==p then
table.insert(o,r)
end
end
end

return o end


return{
{
action="chat|say",
description="Makes you chat a string (possible mute bypass)",
args={
kind="string",
name="your message"
},
run=function(n,o)
local p=o:nextValue()
if not p then return end
f(n,"Chat",p)
end
},
{
action="spam",
description="Makes you spam the chat",
args={
kind="string",
name="your message"
},
run=function(n,o)
local p=o:nextValue()
if not p then return end
h(n,p)
end
},
{
action="unspam|nospam",
description="Turns off spam",
run=function(n)
g(n)
end
},
{
action="whisper|pm",
description="Makes you whisper a string to someone (possible mute bypass)",
args={
{kind="player"},
{kind="string",name="your message"}
},
run=function(n,o)
local p=c(o:nextValue())
local q=o:nextValue()
if not q then return end

for r,s in p do
if s~=n.localPlayer then
f(n,"Whisper",`/w {s.Name} {q}`)
end
end
end
},
{
action="pmspam",
description="Makes you spam a players whispers",
args={
{kind="player"},
{kind="string",name="your message"}
},
run=function(n,o)
local p=c(o:nextValue())
local q=o:nextValue()
if not q then return end

for r,s in p do
if s~=n.localPlayer then
k(n,s,q)
end
end
end
},
{
action="unpmspam|nopmspam",
description="Turns off pm spam (no player: turns it off for everyone)",
args={kind="player",optional=true},
run=function(n,o)
local p=o:nextValue()
local q=if p then m(n,p)else l(n)

for r,s in q do
j(n,s)
end
end
},
{
action="spamspeed|spamdelay",
description="How quickly you spam (default is 1)",
args={kind="number",name="delay",optional=true},
run=function(n,o)
n.privateEnv.spamSpeed=math.max(o:nextValue()or 1,0)
end
}
}end a.bE=function()local c=a.cache.bE if not c then c={c=b()}a.cache.bE=c end return c.c end end do local b=function()

local b=a.h()
local c=a.bA()local d=function(


d)
if c.isLegacy()then
b.Chat.BubbleChatEnabled=d
else
b.TextChatService.BubbleChatConfiguration.Enabled=d
end end


return{
{
action="bubblechat",
description="Enables bubble chat for your client (CLIENT)",
client=true,
run=function()
d(true)
end
},
{
action="unbubblechat|nobubblechat",
description="Disables bubble chat for your client (CLIENT)",
client=true,
run=function()
d(false)
end
}
}end a.bF=function()local c=a.cache.bF if not c then c={c=b()}a.cache.bF=c end return c.c end end do local b=function()

local b=a.h()
local c=a.bA()local d=function(

d)
if c.isLegacy()then
b.StarterGui:SetCore("ChatActive",d)
else
b.TextChatService.ChatWindowConfiguration.Enabled=d
end end local e=function()




local e=b.TextChatService

local f={
{e:FindFirstChildOfClass"BubbleChatConfiguration",{
Enabled=true,
BackgroundColor3=Color3.fromRGB(),
BackgroundTransparency=0.3,
TailVisible=true,
}},
{e:FindFirstChildOfClass"ChatWindowConfiguration",{
Enabled=true,
BackgroundColor3=Color3.fromRGB(),
BackgroundTransparency=0.3,
TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF),
TextStrokeColor3=Color3.fromRGB(),
TextStrokeTransparency=0.5,
}},
{e:FindFirstChildOfClass"ChatInputBarConfiguration",{
Enabled=true,
BackgroundColor3=Color3.fromRGB(),
BackgroundTransparency=0.5,
PlaceholderColor3=Color3.fromRGB(0xFF,0xFF,0xFF),
TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF),
TextStrokeColor3=Color3.fromRGB(),
TextStrokeTransparency=0.5,
}},
}

for g,h in f do
local i,j=h[1],h[2]
if i then
for k,l in j do
i[k]=l
end
end
end end


return{
{
action="chatwindow",
description="Enables the chat window for your client",
client=true,
run=function()
d(true)
end
},
{
action="unchatwindow|nochatwindow",
description="Disables the chat window for your client",
client=true,
run=function()
d(false)
end
},
{
action="darkchat",
description="Makes the chat window dark for your client",
client=true,
run=function(f)
if c.isLegacy()then
f:notify("Dark Chat","darkchat only works with the TextChatService chat")
return
end
e()
end
}
}end a.bG=function()local c=a.cache.bG if not c then c={c=b()}a.cache.bG=c end return c.c end end do local b=function()

local b=a.h()
local c=a.ah()local d=function()



local d,e=pcall(function()
return b.VoiceChatInternal
end)
if d then
return e
end
return nil end local e=function(



e, f)
local g=d()
if not g then
e:notify("Voice Chat","this game has no voice chat service")
return
end

local h,i=pcall(f,g)
if not h then
e:notify("Voice Chat",tostring(i))
end end local f=function(



f)
local g=f:collectGarbage"listento"
if not g then
return false
end

if g.connection then
g.connection:Disconnect()
end
b.SoundService:SetListener(Enum.ListenerType.Camera)
return true end local g=function(



g, h)
local i=g:createGarbage"listento"local j=function(

j)
local k=j:WaitForChild("HumanoidRootPart",10)
if k and g:getGarbage"listento"==i then
b.SoundService:SetListener(Enum.ListenerType.ObjectPosition,k)
end end


i.connection=g:connect(h.CharacterAdded,function(k)
task.spawn(j,k)
end)

if h.Character then
task.spawn(j,h.Character)
end end


return{
{
action="listento",
description="Listens to the area around a player. Can also eavesdrop with vc",
args={kind="player",optional=true},
run=function(h,i)
local j=i:nextValue()

f(h)
if not j then return end

local k=c(j)[1]
if k then
g(h,k)
end
end
},
{
action="unlistento",
description="Disables listento",
run=function(h)
f(h)
end
},
{
action="muteallvoices|muteallvcs",
description="Mutes voice chat for all players",
run=function(h)
e(h,function(i)
i:SubscribePauseAll(true)
end)
end
},
{
action="unmuteallvoices|unmuteallvcs",
description="Unmutes voice chat for all players",
run=function(h)
e(h,function(i)
i:SubscribePauseAll(false)
end)
end
},
{
action="mutevc",
description="Mutes the voice chat of a player",
args={kind="player"},
run=function(h,i)
local j=c(i:nextValue())
e(h,function(k)
for l,m in j do
if m~=h.localPlayer then
k:SubscribePause(m.UserId,true)
end
end
end)
end
},
{
action="unmutevc",
description="Unmutes the voice chat of a player",
args={kind="player"},
run=function(h,i)
local j=c(i:nextValue())
e(h,function(k)
for l,m in j do
if m~=h.localPlayer then
k:SubscribePause(m.UserId,false)
end
end
end)
end
},
{
action="phonebook|call",
description="Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled",
run=function(h)
local i,j=pcall(function()
return b.SocialService:CanSendCallInviteAsync(h.localPlayer)
end)

if i and j then
b.SocialService:PromptPhoneBook(h.localPlayer,"")
else
h:notify("Phonebook","It seems you're not able to call anyone. Sorry!")
end
end
}
}end a.bH=function()local c=a.cache.bH if not c then c={c=b()}a.cache.bH=c end return c.c end end do local b=function()

return{
{
action="loopoof",
description="Makes every player's head play its sounds (oof) over and over",
run=function(b)
if b:hasGarbage"oof"then
b:notify"oof loop is already enabled"
return
end

local c=b:createGarbage"oof"
c.running=true

task.spawn(function()
while c.running do
for d,e in b.robloxServices.Players:GetPlayers()do
local f=e.Character and e.Character:FindFirstChild"Head"
if f then
for g,h in f:GetChildren()do
if h:IsA"Sound"then
h.Playing=true
end
end
end
end
task.wait(0.1)
end
end)
end
},
{
action="unloopoof",
description="Stops the oof loop",
run=function(b)
local c=b:collectGarbage"oof"
if c then
c.running=false
end
end
}
}end a.bI=function()local c=a.cache.bI if not c then c={c=b()}a.cache.bI=c end return c.c end end do local b=function()

local b=a.ah()

return{
{
action="muteboombox",
description="Mutes someones boombox",
args={
kind="player"
},
run=function(c,d)
for e,f in b(d:nextValue())do
task.spawn(function()
local g={f.Character,f:FindFirstChildOfClass"Backpack"}
for h,i in g do
for j,k in i:GetDescendants()do
if k:IsA"Sound"then
k.Playing=false
end
end
end
end)
end
end
},
{
action="unmuteboombox",
description="Unmutes someones boombox",
args={
kind="player"
},
run=function(c,d)
for e,f in b(d:nextValue())do
task.spawn(function()
local g=f.Character
if not g then return end

for h,i in g:GetDescendants()do
if i:IsA"Sound"and not i.Playing then
i.Playing=true
end
end
end)
end
end
}
}end a.bJ=function()local c=a.cache.bJ if not c then c={c=b()}a.cache.bJ=c end return c.c end end do local b=function()

return{a.bD()
,a.bE()
,a.bF()
,a.bG()
,a.bH()
,a.bI()
,a.bJ()

}end a.bK=function()local c=a.cache.bK if not c then c={c=b()}a.cache.bK=c end return c.c end end do local b=function()









local b=a.h()
local c=a.ag()
local d=a.b()
local e=a.d()

local f=0.3
local g=0.25
local h=Color3.fromRGB(255,255,255)
local i="iy-esp"local j=function()


local j=b.CoreGui
local k=j:FindFirstChild(i)

if not k then
k=Instance.new"Folder"
k.Name=i
k.Parent=j
end

return k end local k=function(



k)
if k:IsA"BasePart"then
return k
end

if k:IsA"Model"then
return k:FindFirstChild"Head"
or k.PrimaryPart
or k:FindFirstChildWhichIsA"BasePart"
end

return nil end local l=function(



l, m)
local n=l:IsA"Model"and l:FindFirstChildOfClass"Humanoid"

if n then
return("%s <font color='rgb(160, 160, 160)'>[ %dm ]</font>\n<font color='rgb(25, 240, 25)'>[%d/%d]</font>"):format(
l.Name,
m,
math.floor(n.Health),
math.floor(n.MaxHealth)
)
end

return("%s < %dm >"):format(l.Name,m)end


local m={}
m.__index=m








m.new=function(n)
local o=Instance.new"Folder"
o.Name=n.tag
o.Parent=j()

return setmetatable({
tag=n.tag,
source=n.source,
color=n.color,
text=n.text or l,
showBoxes=n.showBoxes==true,
showText=n.showText==true,
interval=n.interval or g,
objects={},
folder=o,
running=false,
},m)end


m.create=function(n, o)
local p=k(o)
if not p then
return nil
end

local q={instance=o,adornee=p,boxes={}}

if n.showBoxes then
local r=o:IsA"Model"and o:GetChildren()or{o}

for s,t in r do
if t:IsA"BasePart"then
local u=Instance.new"BoxHandleAdornment"
u.Adornee=t
u.Size=t.Size
u.AlwaysOnTop=true
u.ZIndex=0
u.Parent=n.folder
table.insert(q.boxes,u)
end
end
end

if n.showText then
local r=Instance.new"BillboardGui"
r.Adornee=p
r.Size=UDim2.new(0,200,0,50)
r.StudsOffset=Vector3.new(0,2,0)
r.AlwaysOnTop=true
r.Parent=n.folder

local s=Instance.new"TextLabel"
s.BackgroundTransparency=1
s.Size=UDim2.new(1,0,1,0)
s.TextSize=14
s.TextStrokeTransparency=0
s.TextYAlignment=Enum.TextYAlignment.Bottom
s.RichText=true
s.Text=""
s.Parent=r

q.billboard=r
q.label=s
end

n.objects[o]=q
return q end


m.update=function(n, o, p)
local q=h
if n.color then
q=n.color(o.instance)
end

local r=d.espTransparency or f

for s,t in o.boxes do
t.Color3=q
t.Transparency=r
end

if o.label then
local s=0
if p then
s=(p.Position-o.adornee.Position).Magnitude
end

o.label.TextColor3=q
o.label.Text=n.text(o.instance,math.floor(s/5),math.floor(s))
end end


m.removeEsp=function(n, o, p)
for q,r in p.boxes do
r:Destroy()
end

if p.billboard then
p.billboard:Destroy()
end

n.objects[o]=nil end


m.refresh=function(n)
local o=c:getRootPart()
local p={}

for q,r in n.source()do
if not p[r]then
p[r]=true

local s=n.objects[r]


if s and not s.adornee:IsDescendantOf(workspace)then
n:removeEsp(r,s)
s=nil
end

s=s or n:create(r)

if s then
n:update(s,o)
end
end
end

for q,r in pairs(n.objects)do
if not p[q]or not q:IsDescendantOf(workspace)then
n:removeEsp(q,r)
end
end end


m.start=function(n)
if n.running then
return
end

n.running=true

task.spawn(function()
while n.running do
local o,p=pcall(n.refresh,n)

if not o then
n.running=false
e:warn(("esp [%s] stopped: %s"):format(n.tag,tostring(p)))
break
end

task.wait(n.interval)
end
end)end


m.destroy=function(n)
n.running=false

for o,p in pairs(n.objects)do
n:removeEsp(o,p)
end

n.folder:Destroy()end


return m end a.bL=function()local c=a.cache.bL if not c then c={c=b()}a.cache.bL=c end return c.c end end do local b=function()






local b=a.bL()
local c=a.ah()
local d=a.h()
local e=a.b()

local f=d.Players

local g=0.3
local h=Color3.fromRGB(0,255,0)
local i=Color3.fromRGB(255,0,0)
local j=Color3.fromRGB(255,255,255)
local k=Color3.fromRGB(50,205,50)local l=function()



local l={}
local m=f.LocalPlayer

for n,o in f:GetPlayers()do
if o~=m and o.Character then
table.insert(l,o.Character)
end
end

return l end local m=function(


m)
local n=f:GetPlayerFromCharacter(m)
if n then
return n.TeamColor.Color
end
return j end local n=function(


n)
local o=f:GetPlayerFromCharacter(n)
if o and o.TeamColor==f.LocalPlayer.TeamColor then
return h
end
return i end local o=function(


o)
return function()
return o
end end local p=function(



p)
return function()
local q={}

for r,s in workspace:GetDescendants()do
if s:IsA"BasePart"and p[s.Name:lower()]then
table.insert(q,s)
end
end

return q
end end local q=function(



q, r, s)
local t=f:GetPlayerFromCharacter(q)
local u=q:FindFirstChildOfClass"Humanoid"

local v=0
if u then
v=math.floor(u.Health*10+0.5)/10
end

return("Name: %s | Health: %g | Studs: %d"):format(
t and t.Name or q.Name,
v,
s
)end local r=function(


r, s)
local t=r:collectGarbage(s)

if t and t.manager then
t.manager:destroy()
end end local s=function(


s, t, u)
r(s,t)

u.tag=t
local v=b.new(u)

local w=s:createGarbage(t)
w.manager=v
v:start()end local t=function(


t, u)
if t:hasGarbage"chams"then
t:notify("ESP","Disable chams (nochams) before using esp")
return
end

s(t,"esp",{
source=l,
color=u,

showBoxes=true,
showText=true,
})end



local u="locate:"local v=function(

v)
return u..v.Name end local w=function(



w, x)
s(w,v(x),{
source=function()
local y=x.Character
if y then
return{y}
end
return{}
end,
color=m,

showBoxes=true,
showText=true,
})end


return{
{
action="esp",
description="View all players and their status",
run=function(x)
t(x,m)
end
},
{
action="espteam",
description="ESP but teammates are green and bad guys are red",
run=function(x)
t(x,n)
end
},
{
action="noesp|unesp|unespteam",
description="Removes ESP",
run=function(x)
r(x,"esp")
end
},
{
action="esptransparency",
description="Changes the transparency of ESP related commands",
args={kind="number"},
run=function(x,y)
local z=y:nextValue()
e.espTransparency=math.clamp(z or g,0,1)
end
},
{
action="partesp",
description="Highlights a part",
args={
kind="string",
name="part name"
},
run=function(x,y)
local z=y:nextValue()
if not z then
x:notify("partesp","Write the name of a part")
return
end

local A=e.partEspNames or{}
e.partEspNames=A
A[z:lower()]=true

if not x:hasGarbage"partesp"then
s(x,"partesp",{
source=p(A),
color=o(k),
showBoxes=true,
showText=false,
interval=1,
})
end
end
},
{
action="unpartesp|nopartesp",
description="removes partesp",
args={
kind="string",
name="part name"
},
run=function(x,y)
local z=e.partEspNames or{}
e.partEspNames=z

local A=y:nextValue()
if A then
z[A:lower()]=nil
else
table.clear(z)
end

if next(z)==nil then
r(x,"partesp")
end
end
},
{
action="chams",
description="ESP but without text in the way",
run=function(x)
if x:hasGarbage"esp"then
x:notify("Chams","Disable ESP (noesp) before using chams")
return
end

s(x,"chams",{
source=l,
color=m,
showBoxes=true,
showText=false,
})
end
},
{
action="nochams|unchams",
description="Removes chams",
run=function(x)
r(x,"chams")
end
},
{
action="locate",
description="View a single player and their status",
args={kind="player"},
run=function(x,y)
local z=y:nextValue()
if not z then
return
end

for A,B in c(z)do
if B~=f.LocalPlayer then
w(x,B)
end
end
end
},
{
action="unlocate|nolocate",
description="Removes locate",
args={kind="player"},
run=function(x,y)
local z=y:nextValue()

if not z then

local A={}
for B in pairs(x.garbages)do
if B:sub(1,#u)==u then
table.insert(A,B)
end
end

for B,C in A do
r(x,C)
end
return
end


local A={}
for B,C in c(z)do
table.insert(A,v(C))
end


if not c.isSelector(z)then
local B=z:lower()
for C in pairs(x.garbages)do
if C:sub(1,#u)==u then
local D=C:sub(#u+1):lower()
if D:sub(1,#B)==B then
table.insert(A,C)
end
end
end
end

for B,C in A do
r(x,C)
end
end
}
}end a.bM=function()local c=a.cache.bM if not c then c={c=b()}a.cache.bM=c end return c.c end end do local b=function()local b=function(


b)
local c=b.privateEnv.xrayEnabled==true

for d,e in workspace:GetDescendants()do
if e:IsA"BasePart"then
local f=e.Parent
local g=f and f.Parent
local h=(f and f:FindFirstChildWhichIsA"Humanoid")
or(g and g:FindFirstChildWhichIsA"Humanoid")

if not h then
e.LocalTransparencyModifier=c and 0.5 or 0
end
end
end end local c=function(


c)
local d=c:collectGarbage"loopxray"
if d then
d.connection:Disconnect()
end end


return{
{
action="xray",
description="Makes all parts in workspace transparent",
run=function(d)
d.privateEnv.xrayEnabled=true
b(d)
end
},
{
action="unxray|noxray",
description="Restores transparency to all parts in workspace",
run=function(d)
d.privateEnv.xrayEnabled=false
b(d)
end
},
{
action="loopxray",
description="Makes all parts in workspace transparent but looped",
run=function(d)
c(d)

local e=d:createGarbage"loopxray"
e.connection=d:connect(d.runService.RenderStepped,function()
d.privateEnv.xrayEnabled=true
b(d)
end)
end
},
{
action="unloopxray",
description="Unloops xray",
run=function(d)
c(d)
d.privateEnv.xrayEnabled=false
b(d)
end
},
{
action="togglexray",
description="Toggles xray",
run=function(d)
d.privateEnv.xrayEnabled=not d.privateEnv.xrayEnabled
b(d)
end
}
}end a.bN=function()local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do local b=function()local b=function(



b, c)
if not c then return nil end

local d=c:FindFirstAncestorOfClass"Model"
if not d then return nil end

return b.players:GetPlayerFromCharacter(d)end local c=function(


c)
local d=c:collectGarbage"hovername"
if not d then return false end

if d.connection then
d.connection:Disconnect()
end
if d.gui then
d.gui:Destroy()
end
return true end local d=function(


d)
local e=Instance.new"ScreenGui"
e.Name="HovernameGui"
e.ResetOnSpawn=false

local f=d.executorEnv.gethui and d.executorEnv.gethui()
e.Parent=f or d.coreGui

local g=Instance.new"TextLabel"
g.Name="Name"
g.BackgroundTransparency=1
g.Size=UDim2.fromOffset(200,20)
g.Font=Enum.Font.SourceSansBold
g.TextSize=16
g.TextColor3=Color3.new(1,1,1)
g.TextStrokeTransparency=0
g.TextXAlignment=Enum.TextXAlignment.Left
g.Visible=false
g.Parent=e

return e,g end


return{
{
action="hovername",
description="Shows a players username when your mouse is hovered over them",
run=function(e)
c(e)

local f=e.playerService:getMouse()
local g,h=d(e)

local i=e:createGarbage"hovername"
i.gui=g
i.connection=e:connect(e.runService.RenderStepped,function()
local j=b(e,f.Target)

if j then
h.Text=j.Name
h.Position=UDim2.fromOffset(f.X+18,f.Y+12)
h.Visible=true
else
h.Visible=false
end
end)
end
},
{
action="unhovername|nohovername",
description="Turns off hovername",
run=function(e)
c(e)
end
}
}end a.bO=function()local c=a.cache.bO if not c then c={c=b()}a.cache.bO=c end return c.c end end do local b=function()

return{a.bM()
,a.bN()
,a.bO()

}end a.bP=function()local c=a.cache.bP if not c then c={c=b()}a.cache.bP=c end return c.c end end do local b=function()

local b=a.h()
local c=b.UserInputService

local d=false

xpcall(
function()
d=table.find({
Enum.Platform.Android,
Enum.Platform.IOS
},c:GetPlatform())~=nil
end,
function()
d=(
c.TouchEnabled and
not c.KeyboardEnabled
)
end
)

return d end a.bQ=function()local c=a.cache.bQ if not c then c={c=b()}a.cache.bQ=c end return c.c end end do local b=function()
local b=a.h()
local c=a.a()local d=function()


local d=b.CoreGui
local e=c.gethui

if typeof(e)=="function"then
local f,g=pcall(e)

if f and typeof(g)=="Instance"then
d=g
end
end

if d==b.CoreGui then
local f=d:FindFirstChild"RobloxGui"
d=if f~=nil then f else d
end

return d end


return d()end a.bR=function()local c=a.cache.bR if not c then c={c=b()}a.cache.bR=c end return c.c end end do local aa=function()










local b=a.h()
local c=a.bQ()
local d=a.bR()

local e=b.ContextActionService
local f=b.UserInputService

local g={}

g.DEFAULT_SPEED=1
g.DEFAULT_BOOST=2
g.MIN_BOOST=1
g.MAX_BOOST=50
local h="freecam.boost"

local i="freecam"
local j="freecamKeys"
local k="freecamMouse"
local l=Enum.ContextActionPriority.High.Value
local m="freecamControls"

local n={
Enum.KeyCode.W,
Enum.KeyCode.A,
Enum.KeyCode.S,
Enum.KeyCode.D,
Enum.KeyCode.E,
Enum.KeyCode.Q,
Enum.KeyCode.Up,
Enum.KeyCode.Down,
}

local o=70
local p=64
local q=5
local r=math.pi/64
local s=0.75
local t=0.01
local u=4
local v=0.25
local w=0.1
local x=512

local y=1
local z=64
local A=24
local B=40 local C=function()


return Enum.ContextActionResult.Sink end local D=function(



D)
return{
position=D,
velocity=D*0,
}end local E=function(


E, F, G)
local H=q*2*math.pi
local I=G-E.position
local J=math.exp(-H*F)

local K=G+(E.velocity*F-I*(H*F+1))*J
local L=(H*F*(I*H-E.velocity)+E.velocity)*J

E.position=K
E.velocity=L

return K end local F=function(



F, G)
local H=f:IsKeyDown(F)and 1 or 0
local I=f:IsKeyDown(G)and 1 or 0
return H-I end local G=function(



G, H, I)
local J=G.ViewportSize
local K=2*math.tan(math.rad(I)/2)
local L=J.X/J.Y*K

local M=x
local N=H.LookVector

for O=0,1,0.5 do
for P=0,1,0.5 do
local Q=H.RightVector*((O-0.5)*L)
-H.UpVector*((P-0.5)*K)
+H.LookVector

local R=Q.Unit
local S=H.Position+Q*w
local T=workspace:Raycast(S,R*x)
local U=T and(T.Position-S).Magnitude or x

if U<M then
M=U
N=R
end
end
end

return H.LookVector:Dot(N)*M end local H=function(



H)
local I=Vector3.new(H.X,0,H.Z)
if I.Magnitude==0 then
return Vector3.zero
end
return I.Unit end local I=function(





I)
if not I then return Vector3.zero end

local J=workspace.CurrentCamera.CFrame
local K=I.MoveDirection
return Vector3.new(K:Dot(H(J.RightVector)),0,-K:Dot(H(J.LookVector)))end local J=function(


J)
return J.UserInputType==Enum.UserInputType.Touch end local K=function(


K, L, M)
local N=Instance.new(K)
for O,P in M do
N[O]=P
end
N.Parent=L
return N end local L=function(



L, M)
for N,O in L.controls do
local P=O.AbsolutePosition
local Q=O.AbsoluteSize
if M.X>=P.X and M.X<=P.X+Q.X
and M.Y>=P.Y and M.Y<=P.Y+Q.Y then
return true
end
end
return false end local M=function(



M, N)
local O=K("ScreenGui",d,{
Name=m,
ResetOnSpawn=false,
DisplayOrder=50,
})
N.gui=O local P=function(


P, Q, R)
local S=K("TextButton",O,{
Name=P,
AnchorPoint=Vector2.new(1,1),
Position=R,
Size=UDim2.fromOffset(z,z),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text=Q,
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(N.controls,S)
table.insert(N.connections,M:connect(S.InputBegan,function(T)
if J(T)then
N.holds[P]=T
end
end))end


P("rise","UP",UDim2.new(1,-A,1,-B-z-12))
P("fall","DOWN",UDim2.new(1,-A,1,-B))
P("boost","BOOST",UDim2.new(1,-A-z-12,1,-B))

local Q=K("TextButton",O,{
Name="Close",
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-A,0,A),
Size=UDim2.fromOffset(z,z),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text="X",
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(N.controls,Q)
table.insert(N.connections,M:connect(Q.Activated,function()
g.stop(M)
end))


table.insert(N.connections,M:connect(f.InputEnded,function(R)
for S,T in N.holds do
if R==T then
N.holds[S]=nil
end
end
end))end local N=function(




N, O)
local P=b.Players.LocalPlayer:FindFirstChildOfClass"PlayerGui"
local Q=P and P:FindFirstChild"TouchGui"
local R=Q and Q:FindFirstChild("JumpButton",true)
if not R then return end

O.jumpButton=R
O.jumpVisible=R.Visible
R.Visible=false

table.insert(O.connections,N:connect(R:GetPropertyChangedSignal"Visible",function()
if R.Visible then
R.Visible=false
end
end))end local O=function(



O, P)
local Q=O.playerService:getRootPart()
if not Q then return end

P.root=Q
P.rootAnchored=Q.Anchored
Q.Anchored=true end local P=function(


P)
local Q=P.root
if Q and Q.Parent~=nil then
Q.Anchored=P.rootAnchored
end end local aa=function(


Q, R, S)
local T=workspace.CurrentCamera


R.navMultiplier=math.clamp(
R.navMultiplier+S*F(Enum.KeyCode.Up,Enum.KeyCode.Down)*s,
t,
u
)


local U=Q.playerService:getHumanoid()
local V=if c then I(U)else Vector3.zero
if c and U then
U.Jump=false
end

local W=R.holds.rise and 1 or 0
local X=R.holds.fall and 1 or 0
local Y=Vector3.new(
F(Enum.KeyCode.D,Enum.KeyCode.A)+V.X,
F(Enum.KeyCode.E,Enum.KeyCode.Q)+W-X,
F(Enum.KeyCode.S,Enum.KeyCode.W)+V.Z
)

local Z=f:IsKeyDown(Enum.KeyCode.LeftShift)and v or 1
local _=if R.holds.boost then g.getBoost(Q)else 1
local aa=(Q.privateEnv.freecamSpeed or g.DEFAULT_SPEED)*R.navMultiplier*Z*_
local ab=E(R.velocitySpring,S,Y*aa)

local ac=E(R.panSpring,S,R.mouseDelta*r)
R.mouseDelta=Vector2.zero


local ad=math.sqrt(math.tan(math.rad(o/2))/math.tan(math.rad(R.fieldOfView/2)))
local ae=R.rotation+ac*Vector2.new(0.75,1)*8*(S/ad)
R.rotation=Vector2.new(
math.clamp(ae.X,-math.rad(90),math.rad(90)),
ae.Y%(2*math.pi)
)

local af=CFrame.fromOrientation(R.rotation.X,R.rotation.Y,0)
local ag=CFrame.new(R.position)*af*CFrame.new(ab*p*S)
R.position=ag.Position

T.CFrame=ag
if R.anchor then
R.anchor.CFrame=ag
end
T.Focus=ag*CFrame.new(0,0,-G(T,ag,R.fieldOfView))
T.FieldOfView=R.fieldOfView end



g.stop=function(ab)
local ac=ab:collectGarbage(i)
if not ac then return false end

for ad,ae in ac.connections do
ae:Disconnect()
end

e:UnbindAction(j)
e:UnbindAction(k)

if ac.gui then
ac.gui:Destroy()
end
if ac.jumpButton then
ac.jumpButton.Visible=ac.jumpVisible
end
P(ac)

local ad=workspace.CurrentCamera
ad.CameraType=ac.cameraType
ad.CameraSubject=ac.cameraSubject
if ac.anchor then
ac.anchor:Destroy()
end
ad.Focus=ac.focus
ad.FieldOfView=ac.fieldOfView

f.MouseBehavior=ac.mouseBehavior
f.MouseIconEnabled=ac.mouseIconEnabled

return true end local ab=function(




ab, ac, ad, ...)
local ae,af=pcall(ad,...)
if not ae then
ab:notify("Freecam",`{ac} failed: {af}`)
end end local ac=function(




ac, ad)
g.stop(ac)

local ae=workspace.CurrentCamera
local af=ae.CFrame
local ag,Q=af:ToOrientation()

local R=ac:createGarbage(i)
R.connections={}
R.controls={}
R.holds={}
R.cameraType=ae.CameraType
R.cameraSubject=ae.CameraSubject
R.focus=ae.Focus
R.fieldOfView=ae.FieldOfView
R.mouseBehavior=f.MouseBehavior
R.mouseIconEnabled=f.MouseIconEnabled

R.position=ad or af.Position
R.rotation=Vector2.new(ag,Q)
R.mouseDelta=Vector2.zero
R.navMultiplier=1
R.velocitySpring=D(Vector3.zero)
R.panSpring=D(Vector2.zero)

ae.CameraType=Enum.CameraType.Custom




R.anchor=K("Part",workspace,{
Name="freecamAnchor",
Anchored=true,
CanCollide=false,
CanQuery=false,
CanTouch=false,
CastShadow=false,
Transparency=1,
Size=Vector3.one*0.2,
CFrame=CFrame.new(R.position),
})
ae.CameraSubject=R.anchor
f.MouseBehavior=Enum.MouseBehavior.Default
f.MouseIconEnabled=true


e:BindActionAtPriority(j,C,false,l,table.unpack(n))
e:BindActionAtPriority(k,function(S,T,U)
local V=U.Delta
R.mouseDelta=R.mouseDelta+Vector2.new(-V.Y,-V.X)
return Enum.ContextActionResult.Sink
end,false,l,Enum.UserInputType.MouseMovement)

if c then
O(ac,R)
ab(ac,"buttons",M,ac,R)
ab(ac,"jump button",N,ac,R)


table.insert(R.connections,ac:connect(f.InputBegan,function(T,U)
if U or not J(T)then return end
if R.lookTouch~=nil or L(R,T.Position)then return end


if T.Position.X<workspace.CurrentCamera.ViewportSize.X/2 then return end

R.lookTouch=T
end))
table.insert(R.connections,ac:connect(f.InputChanged,function(T)
if T==R.lookTouch then
R.mouseDelta=R.mouseDelta+Vector2.new(-T.Delta.Y,-T.Delta.X)*y
end
end))
table.insert(R.connections,ac:connect(f.InputEnded,function(T)
if T==R.lookTouch then
R.lookTouch=nil
end
end))
end

table.insert(R.connections,ac:connect(ac.runService.RenderStepped,function(T)
local U,V=pcall(aa,ac,R,T)
if not U then
g.stop(ac)
ac:notify("Freecam",`stopped, the camera was given back: {V}`)
end
end))end




g.start=function(ad, ae)
local af,ag=pcall(ac,ad,ae)
if not af then
g.stop(ad)
ad:notify("Freecam",`could not start: {ag}`)
end end



g.getBoost=function(ad)
local ae=ad.storage.settings:getValue(h)
if type(ae)~="number"then
return g.DEFAULT_BOOST
end

return math.clamp(ae,g.MIN_BOOST,g.MAX_BOOST)end



g.addBoost=function(ad, ae)
local af=math.clamp(g.getBoost(ad)+ae,g.MIN_BOOST,g.MAX_BOOST)

ad.storage.settings:setValue(h,af)
ad.storage.settings:save()

return af end



g.getPosition=function(ad)
local ae=ad:getGarbage(i)
return ae and ae.position end


return g end a.bS=function()local ab=a.cache.bS if not ab then ab={c=aa()}a.cache.bS=ab end return ab.c end end do local aa=function()

local aa=a.ah()
local ab=a.bS()local ac=function(


ac)
if not ac then return nil end
return ac:FindFirstChildOfClass"Humanoid"or ac end local ad=function(


ad, ae)
local af=ad.playerService:getCamera()
if ae and af.CameraSubject~=ae then
af.CameraSubject=ae
end end local ae=function(



ae)
local af=ae.playerService:getHumanoid()
if af then
ad(ae,af)
end end local af=function(



af)
local ag=af:collectGarbage"view"
if not ag then return false end

for b,c in ag.connections do
c:Disconnect()
end
return true end


return{
{
action="spectate|view",
description="View a player",
args={kind="player"},
run=function(ag,b)
local c=aa(b:nextValue())[1]
if not c then return end

ab.stop(ag)
af(ag)

local d=ag:createGarbage"view"
d.connections={}

local e=ag.playerService:getCamera()local f=function()



local f=ac(c.Character)
if f then
ad(ag,f)
end end


table.insert(d.connections,ag:connect(e:GetPropertyChangedSignal"CameraSubject",f))

table.insert(d.connections,ag:connect(c.CharacterAdded,function(g)
g:WaitForChild("Humanoid",10)
f()
end))


table.insert(d.connections,ag:connect(ag.players.PlayerRemoving,function(g)
if g==c then
af(ag)
ae(ag)
end
end))

f()
ag:notify("Spectate","Viewing "..c.Name)
end
},
{
action="viewpart|viewp",
description="View a part",
args={
kind="string",
name="part name"
},
run=function(ag,b)
local c=b:nextValue()
if not c then return end

ab.stop(ag)
af(ag)

local d=string.lower(c)
for e,f in workspace:GetDescendants()do
if f:IsA"BasePart"and string.lower(f.Name)==d then
ad(ag,f)
return
end
end

ag:notify("Spectate","no part named "..c)
end
},
{
action="unspectate|unview",
description="Stops viewing player, or part.",
run=function(ag)
ab.stop(ag)

local b=af(ag)
ae(ag)

if b then
ag:notify("Spectate","View turned off")
end
end
}
}end a.bT=function()local ab=a.cache.bT if not ab then ab={c=aa()}a.cache.bT=ab end return ab.c end end do local aa=function()

local aa=a.ah()
local ab=a.bS()

local ac="Freecam"local ad=function(


ad, ae)
local af=ad.storage.waypoints:getValue(tostring(game.PlaceId))
local ag=type(af)=="table"and af[ae]
if not ag then return nil end

return ad:unstringify(ag,"Vector3")end local ae=function(



ae)
return`{math.round(ae.X)},{math.round(ae.Y)},{math.round(ae.Z)}`end


return{
{
action="freecam|fc",
description="Allows you to freely move camera around the game",
args={
kind="number",
name="camera speed",
optional=true
},
run=function(af,ag)
local b=ag:nextValue()
if b then
af.privateEnv.freecamSpeed=b
end

ab.start(af)
end
},
{
action="freecampos|fcpos",
description="Moves / opens freecam in a certain position",
args={kind="vector3"},
run=function(af,ag)
local b=ag:nextValue()
if b then
ab.start(af,b)
end
end
},
{
action="freecamwaypoint|fcwp",
description="Moves / opens freecam to a waypoint",
args={
kind="waypoint"
},
run=function(af,ag)
local b=ag:nextValue()
local c=b and ad(af,b)
if not c then
af:notify(ac,`there is no waypoint named '{b}'`)
return
end

ab.start(af,c)
end
},
{
action="freecamgoto|fcgoto|fctp",
description="Moves / opens freecam to a player",
args={kind="player"},
run=function(af,ag)
local b=aa(ag:nextValue())[1]
local c=b and b.Character and b.Character:FindFirstChild"HumanoidRootPart"
if not c then
af:notify(ac,"that player's character is not loaded")
return
end

ab.start(af,c.Position)
end
},
{
action="unfreecam|unfc",
description="Disables freecam",
run=function(af)
ab.stop(af)
end
},
{
action="freecamspeed|fcspeed",
description="Adjusts freecam speed (default is 1)",
args={kind="number"},
run=function(af,ag)
af.privateEnv.freecamSpeed=ag:nextValue()or ab.DEFAULT_SPEED
end
},
{
action="notifyfreecamposition|notifyfcpos",
description="Noitifies you your freecam coordinates",
run=function(af)
local ag=ab.getPosition(af)
if not ag then
af:notify(ac,"freecam is not on")
return
end

af:notify("Freecam Position",ae(ag))
end
},
{
action="copyfreecamposition|copyfcpos",
description="Copies your freecam coordinates to your clipboard",
run=function(af)
local ag=ab.getPosition(af)
if not ag then
af:notify(ac,"freecam is not on")
return
end

local b=af:expectExploit"setclipboard"
if not b then return end

b(ae(ag))
af:notify(ac,"copied freecam position to clipboard")
end
},
{
action="freecamboost|fcboost",
description="Increases the freecam boost (the BOOST button) by an amount, and saves it",
args={kind="number",name="amount",optional=true},
run=function(af,ag)
local b=ag:nextValue()or 1
local c=ab.addBoost(af,b)
af:notify(ac,`freecam boost is now {c}x`)
end
},
}end a.bU=function()local ab=a.cache.bU if not ab then ab={c=aa()}a.cache.bU=ab end return ab.c end end do local aa=function()

return{
{
action="gotocamera|gotocam",
description="Teleports you to the location of your camera",
run=function(aa)
local ab=aa.playerService:getRootPart()
if ab then
ab.CFrame=workspace.CurrentCamera.CFrame
end
end
},
{
action="tweengotocam|tgotocam",
description="Tweens you to the location of your camera",
run=function(aa)
local ab=aa.playerService:getRootPart()
if not ab then return end

local ac=TweenInfo.new(aa.privateEnv.tweenSpeed or 1,Enum.EasingStyle.Linear)
aa.robloxServices.TweenService:Create(ab,ac,{CFrame=workspace.CurrentCamera.CFrame}):Play()
end
}
}end a.bV=function()local ab=a.cache.bV if not ab then ab={c=aa()}a.cache.bV=ab end return ab.c end end do local aa=function()

return{
{
action="firstp",
description="Forces camera to go into first person",
run=function(aa)
aa.localPlayer.CameraMode=Enum.CameraMode.LockFirstPerson
end
},
{
action="thirdp",
description="Allows camera to go into third person",
run=function(aa)
aa.localPlayer.CameraMode=Enum.CameraMode.Classic
end
}
}end a.bW=function()local ab=a.cache.bW if not ab then ab={c=aa()}a.cache.bW=ab end return ab.c end end do local aa=function()local aa=function(


aa)
local ab=aa:FindFirstChild"PlayerScripts"
local ac=ab and ab:FindFirstChild"PlayerModule"
local ad=ac and ac:FindFirstChild"CameraModule"
local ae=ad and ad:FindFirstChild"ZoomController"
return ae and ae:FindFirstChild"Popper"end


return{
action="noclipcam|nccam",
description="Allows camera to go through objects like walls",
run=function(ab)
local ac=ab:expectExploit"getgc"
local ad=ab:expectExploit"getconstants"
local ae=ab:expectExploit"setconstant"
local af=ab:expectExploit"getfenv"
if not(ac and ad and ae and af)then return end

local ag=aa(ab.localPlayer)
if not ag then
ab:notify("noclipcam","camera popper not found")
return
end


for b,c in ac()do
if type(c)=="function"and af(c).script==ag then
for d,e in ad(c)do
if tonumber(e)==0.25 then
ae(c,d,0)
elseif tonumber(e)==0 then
ae(c,d,0.25)
end
end
end
end
end
}end a.bX=function()local ab=a.cache.bX if not ab then ab={c=aa()}a.cache.bX=ab end return ab.c end end do local aa=function()

return{
{
action="maxzoom",
description="Maximum camera zoom",
args={kind="number"},
run=function(aa,ab)
aa.localPlayer.CameraMaxZoomDistance=ab:nextValue()
end
},
{
action="minzoom",
description="Minimum camera zoom",
args={kind="number"},
run=function(aa,ab)
aa.localPlayer.CameraMinZoomDistance=ab:nextValue()
end
},
{
action="camdistance",
description="Changes camera distance from your player",
args={kind="number"},
run=function(aa,ab)
local ac=ab:nextValue()
local ad=aa.localPlayer
local ae=ad.CameraMaxZoomDistance
local af=ad.CameraMinZoomDistance

if ae<ac then
ae=ac
end

ad.CameraMaxZoomDistance=ac
ad.CameraMinZoomDistance=ac
task.wait()
ad.CameraMaxZoomDistance=ae
ad.CameraMinZoomDistance=af
end
}
}end a.bY=function()local ab=a.cache.bY if not ab then ab={c=aa()}a.cache.bY=ab end return ab.c end end do local aa=function()

return{
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(aa,ab)
local ac=math.clamp(math.abs(ab:nextValue()or 70),1,120)
workspace.CurrentCamera.FieldOfView=ac
end
}end a.bZ=function()local ab=a.cache.bZ if not ab then ab={c=aa()}a.cache.bZ=ab end return ab.c end end do local aa=function()

local aa=a.bS()

return{
action="fixcam|restorecam",
description="Fixes camera",
run=function(ab)
local ac=ab.playerService
local ad=ab.localPlayer


aa.stop(ab)


if ab:hasGarbage"view"then
ab:run"unview"
end

local ae=ac:getHumanoid()

if ae then
ab.signals.onCameraReset:Fire()

local af=ac:getCamera()
af.CameraSubject=ae
af.CameraType=Enum.CameraType.Custom

ad.CameraMinZoomDistance=0.5
ad.CameraMaxZoomDistance=400
ad.CameraMode=Enum.CameraMode.Classic

ab:notify"camera has been reseted successfully"
end
end
}end a.b_=function()local ab=a.cache.b_ if not ab then ab={c=aa()}a.cache.b_=ab end return ab.c end end do local aa=function()

return{
action="enableshiftlock|enablesl",
description="Enables the shift lock option",
run=function(aa)
local ab=aa.localPlayer
ab.DevEnableMouseLock=true


if aa:hasGarbage"shiftlock"then return end

local ac=aa:createGarbage"shiftlock"
ac.connection=aa:connect(ab:GetPropertyChangedSignal"DevEnableMouseLock",function()
ab.DevEnableMouseLock=true
end)

aa:notify("Shiftlock","Shift lock should now be available")
end
}end a.b0=function()local ab=a.cache.b0 if not ab then ab={c=aa()}a.cache.b0=ab end return ab.c end end do local aa=function()

local aa=a.ah()


local ab={max=400,min=0.5}

return{
action="lookat",
description="Moves your camera view to a player",
args={kind="player"},
run=function(ac,ad)
local ae=aa(ad:nextValue())[1]
local af=ae and ae.Character and ae.Character:FindFirstChild"Head"
if not af then
ac:notify("Lookat","the player's character is not loaded")
return
end

local ag=ac.localPlayer
local b=ac.playerService:getCamera()


if ag.CameraMaxZoomDistance~=0.5 then
ac.privateEnv.lookAtZoom={
max=ag.CameraMaxZoomDistance,
min=ag.CameraMinZoomDistance
}
end
local c=ac.privateEnv.lookAtZoom or ab


ag.CameraMaxZoomDistance=0.5
ag.CameraMinZoomDistance=0.5
task.wait()

b.CFrame=CFrame.new(b.CFrame.Position,af.Position)
task.wait(0.1)

ag.CameraMaxZoomDistance=c.max
ag.CameraMinZoomDistance=c.min
end
}end a.b1=function()local ab=a.cache.b1 if not ab then ab={c=aa()}a.cache.b1=ab end return ab.c end end do local aa=function()

local aa=a.ah()local ab=function(

ab)
local ac=ab:collectGarbage"stareat"
if ac then
ac.connection:Disconnect()
end end


return{
{
action="stareat|stare",
description="Stare / look at a player",
args={
kind="player"
},
run=function(ac,ad)
local ae=aa(ad:nextValue())[1]
if not ae then return end

ab(ac)

local af=ac:createGarbage"stareat"
af.connection=ac:connect(ac.runService.RenderStepped,function()
if ae.Parent==nil then
ab(ac)
return
end

local ag=ac.playerService:getRootPart()
local b=ae.Character and ae.Character:FindFirstChild"HumanoidRootPart"
if not(ag and b)then return end


local c=Vector3.new(b.Position.X,ag.Position.Y,b.Position.Z)
if(c-ag.Position).Magnitude<0.01 then return end

ag.CFrame=CFrame.new(ag.Position,c)
end)
end
},
{
action="unstareat|unstare",
description="Disables stareat",
run=function(ac)
ab(ac)
end
}
}end a.b2=function()local ab=a.cache.b2 if not ab then ab={c=aa()}a.cache.b2=ab end return ab.c end end do local aa=function()

return{a.bT()
,a.bU()
,a.bV()
,a.bW()
,a.bX()
,a.bY()
,a.bZ()
,a.b_()
,a.b0()
,a.b1()
,a.b2()

}end a.b3=function()local ab=a.cache.b3 if not ab then ab={c=aa()}a.cache.b3=ab end return ab.c end end do local aa=function()


local aa

return{
{
client=true,
action="btools",
description="Gives you building tools (DOES NOT REPLICATE)",
run=function(ab)
local ac=ab.localPlayer:FindFirstChildWhichIsA"Backpack"
if not ac then
ab:notify("Btools","your backpack is not loaded")
return
end


for ad,ae in Enum.BinType:GetEnumItems()do
local af=Instance.new"HopperBin"
af.BinType=ae
af.Name="Building Tool"
af.Parent=ac
end
end
},
{
client=true,
action="f3x",
description="Gives you F3X building tools (DOES NOT REPLICATE)",
run=function(ab)
if aa==nil then
ab:notify("F3X","no script link is set, fill in F3X_SOURCE_URL at the top of workspace/clienttools.luau")
return
end

local ac=ab:expectExploit"loadstring"
if not ac then return end

local ad,ae=pcall(function()
ac(game:HttpGet(aa))()
end)

if not ad then
ab:notify("F3X",`failed to load: {tostring(ae)}`)
end
end
}
}end a.b4=function()local ab=a.cache.b4 if not ab then ab={c=aa()}a.cache.b4=ab end return ab.c end end do local aa=function()




return{
{
action="partname|partpath",
description="Allows you to click a part to see its path & name",
run=function(aa)
local ab=aa:collectGarbage"partname"
local ac=ab~=nil and ab.connection~=nil and ab.connection.Connected

if ab and ab.connection then
ab.connection:Disconnect()
end

if ac then
aa:notify("Partname","disabled")
return
end

local ad=aa.playerService:getMouse()
local ae=aa:createGarbage"partname"

ae.connection=aa:connect(ad.Button1Down,function()
local af=ad.Target
if not af then return end

aa:notify(af.Name,af:GetFullName())
end)

aa:notify("Partname","click a part to see its path")
end
}
}end a.b5=function()local ab=a.cache.b5 if not ab then ab={c=aa()}a.cache.b5=ab end return ab.c end end do local aa=function()local aa=function(


aa, ab, ac)
if ab==false then
aa:notify("Delete","cancelled: "..ac)
return false
end
return true end


return{
{
client=true,
action="delete",
description="Removes any part with a certain name from the workspace (DOES NOT REPLICATE)",
args={
{
kind="string",
name="object name"
},
{
kind="boolean",
name="confirm"
}
},
run=function(ab,ac)
local ad=ac:nextValue()
local ae=ac:nextValue()
if not aa(ab,ae,ad)then return end

local af=ad:lower()
for ag,b in workspace:GetDescendants()do
if b.Name:lower()==af then
b:Destroy()
end
end

ab:notify("Item(s) Deleted","Deleted "..ad)
end
},
{
client=true,
action="deleteclass|dc",
description="Removes any part with a certain classname from the workspace (DOES NOT REPLICATE)",
args={
{
kind="className"
},
{
kind="boolean",
name="confirm"
}
},
run=function(ab,ac)
local ad=ac:nextValue()
local ae=ac:nextValue()
if not aa(ab,ae,ad)then return end

local af=ad:lower()
for ag,b in workspace:GetDescendants()do
if b.ClassName:lower()==af then
b:Destroy()
end
end

ab:notify("Item(s) Deleted","Deleted items with ClassName "..ad)
end
}
}end a.b6=function()local ab=a.cache.b6 if not ab then ab={c=aa()}a.cache.b6=ab end return ab.c end end do local aa=function()




return{
{
action="lockworkspace|lockws",
description="Locks the whole workspace",
run=function(aa)
local ab=aa:createGarbage"lockworkspace"
if not ab then
aa:notify("Lock workspace","the workspace is already locked")
return
end

local ac=aa.playerService:getCharacter()

for ad,ae in workspace:GetDescendants()do
if ae:IsA"BasePart"and not(ac and ae:IsDescendantOf(ac))then
ab[ae]=ae.Locked
ae.Locked=true
end
end

aa:notify("Lock workspace","locked the parts in the workspace")
end
},
{
action="unlockworkspace|unlockws",
description="Unlocks the whole workspace",
run=function(aa)
local ab=aa:collectGarbage"lockworkspace"
if not ab then return end

for ac,ad in ab do
if ac.Parent then
ac.Locked=ad
end
end

aa:notify("Lock workspace","unlocked")
end
}
}end a.b7=function()local ab=a.cache.b7 if not ab then ab={c=aa()}a.cache.b7=ab end return ab.c end end do local aa=function()

return{
{
client=true,
action="invisibleparts|invisparts",
description="Shows invisible parts",
run=function(aa)
local ab=aa.privateEnv.shownParts or{}
aa.privateEnv.shownParts=ab

for ac,ad in workspace:GetDescendants()do
if ad:IsA"BasePart"and ad.Transparency==1 then
if not table.find(ab,ad)then
table.insert(ab,ad)
end
ad.Transparency=0
end
end
end
},
{
client=true,
action="uninvisibleparts|uninvisparts",
description="Makes parts affected by invisparts return to normal",
run=function(aa)
for ab,ac in aa.privateEnv.shownParts or{}do
ac.Transparency=1
end
aa.privateEnv.shownParts={}
end
}
}end a.b8=function()local ab=a.cache.b8 if not ab then ab={c=aa()}a.cache.b8=ab end return ab.c end end do local aa=function()local aa=function(

aa, ab, ac)
return{
action=aa,
description=ab,
run=function()
for ad,ae in workspace:GetDescendants()do
if ae:IsA(ac)then
ae.MaxActivationDistance=math.huge
end
end
end
}end


return{
aa(
"noclickdetectorlimits|nocdlimits|removecdlimits",
"Removes the activation distance limit of ClickDetectors",
"ClickDetector"
),
aa(
"noproximitypromptlimits|nopplimits|removepplimits",
"Removes the activation distance limit of ProximityPrompts",
"ProximityPrompt"
),
{
action="instantproximityprompts|instantpp",
description="Fires proximity prompts as soon as they are held (needs fireproximityprompt)",
run=function(ab)
local ac=ab.executorEnv.fireproximityprompt

if not ac then
ab:notify("Incompatible Exploit","Your exploit does not support this command (missing fireproximityprompt)")
return
end

if ab:hasGarbage"instantpp"then
ab:notify"instant proximity prompts is already enabled"
return
end

local ad=ab:createGarbage"instantpp"
ad.connection=ab:connect(ab.proximityPromptService.PromptButtonHoldBegan,function(ae)
ac(ae)
end)
end
},
{
action="uninstantproximityprompts|uninstantpp",
description="Disables instant proximity prompts",
run=function(ab)
local ac=ab:collectGarbage"instantpp"
if ac and ac.connection then
ac.connection:Disconnect()
end
end
}
}end a.b9=function()local ab=a.cache.b9 if not ab then ab={c=aa()}a.cache.b9=ab end return ab.c end end do local aa=function()

local aa=workspace.Gravity
local ab=-500

return{
{
action="gravity|grav",
description="Sets the workspace gravity (no value resets it)",
args={kind="number",name="gravity",optional=true},
run=function(ac,ad)
workspace.Gravity=ad:nextValue()or aa
end
},
{
action="destroyheight|dh",
description="Sets the height where fallen parts get destroyed (default is -500)",
args={kind="number",name="height",optional=true},
run=function(ac,ad)
workspace.FallenPartsDestroyHeight=ad:nextValue()or ab
end
}
}end a.ca=function()local ab=a.cache.ca if not ab then ab={c=aa()}a.cache.ca=ab end return ab.c end end do local aa=function()

return{
{
action="deleteinvisparts|deleteinvisibleparts|dip",
description="Deletes invisible collidable parts",
run=function()
for aa,ab in workspace:GetDescendants()do
if ab:IsA"BasePart"and ab.Transparency==1 and ab.CanCollide then
ab:Destroy()
end
end
end
},
{
action="removeterrain|rterrain|noterrain",
description="Clears all the terrain",
run=function()
local aa=workspace:FindFirstChildOfClass"Terrain"
if aa then
aa:Clear()
end
end
}
}end a.cb=function()local ab=a.cache.cb if not ab then ab={c=aa()}a.cache.cb=ab end return ab.c end end do local aa=function()local aa=function(

aa, ab)
return ab==""
or aa.Name:lower()==ab
or(aa.Parent~=nil and aa.Parent.Name:lower()==ab)end local ab=function(


ab)
local ac=ab.Parent
if ac==nil then
return nil
elseif ac:IsA"Attachment"then
return ac.WorldPosition
elseif ac:IsA"BasePart"then
return ac.Position
elseif ac:IsA"Model"then
return ac:GetPivot().Position
end
return nil end local ac=function(


ac)
local ad=ac.playerService:getRootPart()
if not ad then
return nil
end

local ae
local af=math.huge

for ag,b in workspace:GetDescendants()do
if b:IsA"ProximityPrompt"and b.Enabled then
local c=ab(b)
if not c then continue end

local d=(c-ad.Position).Magnitude

if d<af then
ae,af=b,d
end
end
end

return ae end local ad=function(


ad, ae)
local af=ad.playerService:getRootPart()
local ag=ab(ae)

if af and ag then
af.CFrame=CFrame.new(ag+Vector3.new(0,3,0))
end end


return{
{
action="fireclickdetectors|firecd",
description="Uses all click detectors in a game or uses the optional name",
args={
kind="object",
optional=true
},
run=function(ae,af)
local ag=ae:expectExploit"fireclickdetector"
if not ag then return end

local b=(af:nextValue()or""):lower()

for c,d in workspace:GetDescendants()do
if d:IsA"ClickDetector"and aa(d,b)then
ag(d)
end
end
end
},
{
action="fireproximityprompts|firepp",
description="Uses all proximity prompts in a game or uses the optional name",
args={
kind="object",
optional=true
},
run=function(ae,af)
local ag=ae:expectExploit"fireproximityprompt"
if not ag then return end

local b=(af:nextValue()or""):lower()

for c,d in workspace:GetDescendants()do
if d:IsA"ProximityPrompt"and aa(d,b)then
ag(d)
end
end
end
},
{
action="fireclosestprompt|fcp",
description="Uses the closest proximity prompt to your character",
args={
optional=true,
kind="boolean",
name="teleport to prompt"
},
run=function(ae,af)
local ag=ae:expectExploit"fireproximityprompt"
if not ag then return end

local b=ac(ae)
if not b then
ae:notify"Can't find any ProximityPrompt on workspace"
return
end

if af:nextValue()then
ad(ae,b)
task.wait(0.25)
end

ag(b)
ae:notify(`fired prompt: {b:GetFullName()}`)
end
},
{
action="firetouchinterests|touchinterests",
description="Uses all touchinterests in a game or uses the optional name",
args={
kind="object",
optional=true
},
run=function(ae,af)
local ag=ae:expectExploit"firetouchinterest"
if not ag then return end

local b=ae.playerService:getRootPart()
if not b then return end

local c=(af:nextValue()or""):lower()

for d,e in workspace:GetDescendants()do
if e:IsA"TouchTransmitter"and e.Parent:IsA"BasePart"and aa(e.Parent,c)then
ag(e.Parent,b,0)
ag(e.Parent,b,1)
end
end
end
}
}end a.cc=function()local ab=a.cache.cc if not ab then ab={c=aa()}a.cache.cc=ab end return ab.c end end do local aa=function()
local aa=a.ah()local ab=function(


ab)
local ac=ab.Parent
if ac and ac:FindFirstChildWhichIsA"Humanoid"then
return true
end

local ad=ac and ac.Parent
return ad~=nil and ad:FindFirstChildWhichIsA"Humanoid"~=nil end local ac=function(



ac)
local ad=ac.playerService:getCharacter()
local ae={}

for af,ag in workspace:GetDescendants()do
if ag:IsA"BasePart"and not ag.Anchored and not(ad and ag:IsDescendantOf(ad))and not ab(ag)then
table.insert(ae,ag)
end
end

return ae end


return{
{
action="tpunanchored|tpua",
description="Teleports unanchored parts to a player",
args={
kind="player"
},
run=function(ad,ae)
local af=aa(ae:nextValue())[1]
local ag=af and af.Character and af.Character:FindFirstChild"Head"
if not ag then return end

local b=ad:registerGarbage"tpunanchored"
b.forces=b.forces or{}

for c,d in ac(ad)do

local e=Instance.new"BodyPosition"
e.MaxForce=Vector3.one*math.huge
e.Position=ag.Position
e.Parent=d
table.insert(b.forces,e)
end
end
},
{
action="animsunanchored|freezeua",
description="Freezes unanchored parts",
run=function(ad)
if ad:hasGarbage"freezeua"then
ad:notify("Freeze","unanchored parts are already frozen, use thawunanchored")
return
end

local ae=ad:createGarbage"freezeua"
ae.parts={}

for af,ag in ac(ad)do
ag.Anchored=true
table.insert(ae.parts,ag)
end

ad:notify("Freeze",`froze {#ae.parts} unanchored part(s)`)
end
},
{
action="thawunanchored|thawua|unfreezeua",
description="Thaws unanchored parts",
run=function(ad)
local ae=ad:collectGarbage"tpunanchored"
if ae then
for af,ag in ae.forces or{}do
ag:Destroy()
end
end

local af=ad:collectGarbage"freezeua"
if af then
for ag,b in af.parts do
if b.Parent then
b.Anchored=false
end
end
end
end
}
}end a.cd=function()local ab=a.cache.cd if not ab then ab={c=aa()}a.cache.cd=ab end return ab.c end end do local aa=function()

return{a.b4()
,a.b5()
,a.b6()
,a.b7()
,a.b8()
,a.b9()
,a.ca()
,a.cb()
,a.cc()
,a.cd()

}end a.ce=function()local ab=a.cache.ce if not ab then ab={c=aa()}a.cache.ce=ab end return ab.c end end do local aa=function()local aa=function(

aa)
local ab=aa.robloxServices.Lighting
ab.Brightness=2
ab.ClockTime=14
ab.FogEnd=100000
ab.GlobalShadows=false
ab.OutdoorAmbient=Color3.fromRGB(128,128,128)end local ab=function(


ab)
local ac=ab:collectGarbage"loopfullbright"
if ac then
ac.connection:Disconnect()
end end


return{
{
action="fullbright|fb",
description="Makes the map brighter / more visible (CLIENT)",
run=function(ac)
aa(ac)
end
},
{
action="loopfullbright|loopfb",
description="Makes the map brighter / more visible but looped (CLIENT)",
run=function(ac)
ab(ac)

local ad=ac:createGarbage"loopfullbright"
ad.connection=ac:connect(ac.runService.RenderStepped,function()
aa(ac)
end)
end
},
{
action="unloopfullbright|unloopfb",
description="Unloops fullbright",
run=function(ac)
ab(ac)
end
}
}end a.cf=function()local ab=a.cache.cf if not ab then ab={c=aa()}a.cache.cf=ab end return ab.c end end do local aa=function()

return{
client=true,
action="ambient",
description="Changes ambient",
args={kind="color3"},
run=function(aa,ab)
local ac=ab:nextValue()
local ad=aa.robloxServices.Lighting

ad.Ambient=ac
ad.OutdoorAmbient=ac
end
}end a.cg=function()local ab=a.cache.cg if not ab then ab={c=aa()}a.cache.cg=ab end return ab.c end end do local aa=function()

return{
{
client=true,
action="day",
description="Changes the time to day for the client",
run=function(aa)
aa.robloxServices.Lighting.ClockTime=14
end
},
{
client=true,
action="night",
description="Changes the time to night for the client",
run=function(aa)
aa.robloxServices.Lighting.ClockTime=0
end
}
}end a.ch=function()local ab=a.cache.ch if not ab then ab={c=aa()}a.cache.ch=ab end return ab.c end end do local aa=function()

return{
client=true,
action="nofog",
description="Removes fog",
run=function(aa)
local ab=aa.robloxServices.Lighting
ab.FogEnd=100000

for ac,ad in ab:GetDescendants()do
if ad:IsA"Atmosphere"then
ad:Destroy()
end
end
end
}end a.ci=function()local ab=a.cache.ci if not ab then ab={c=aa()}a.cache.ci=ab end return ab.c end end do local aa=function()

return{
client=true,
action="brightness",
description="Changes the brightness lighting property",
args={kind="number"},
run=function(aa,ab)
aa.robloxServices.Lighting.Brightness=ab:nextValue()
end
}end a.cj=function()local ab=a.cache.cj if not ab then ab={c=aa()}a.cache.cj=ab end return ab.c end end do local aa=function()

return{
{
client=true,
action="globalshadows|gshadows",
description="Enables global shadows",
run=function(aa)
aa.robloxServices.Lighting.GlobalShadows=true
end
},
{
client=true,
action="noglobalshadows|nogshadows",
description="Disables global shadows",
run=function(aa)
aa.robloxServices.Lighting.GlobalShadows=false
end
}
}end a.ck=function()local ab=a.cache.ck if not ab then ab={c=aa()}a.cache.ck=ab end return ab.c end end do local aa=function()

local aa=a.ah()


local ab=a.h().Lighting
local ac={
ambient=ab.Ambient,
outdoorAmbient=ab.OutdoorAmbient,
brightness=ab.Brightness,
clockTime=ab.ClockTime,
fogEnd=ab.FogEnd,
fogStart=ab.FogStart,
globalShadows=ab.GlobalShadows
}

return{
{
action="restorelighting|rlighting",
description="Restores Lighting properties",
run=function()
ab.Ambient=ac.ambient
ab.OutdoorAmbient=ac.outdoorAmbient
ab.Brightness=ac.brightness
ab.ClockTime=ac.clockTime
ab.FogEnd=ac.fogEnd
ab.FogStart=ac.fogStart
ab.GlobalShadows=ac.globalShadows
end
},
{
action="light",
description="Gives your player dynamic light (CLIENT)",
args={
{
kind="player"
},
{
kind="number",
name="radius",
optional=true
}
},
run=function(ad,ae)
local af=aa(ae:nextValue())[1]
local ag=ae:nextValue()or 30

local b=af and af.Character and af.Character:FindFirstChild"HumanoidRootPart"
if not b then return end

local c=Instance.new"PointLight"
c.Range=ag
c.Brightness=5
c.Parent=b

local d=ad.privateEnv.dynamicLights or{}
ad.privateEnv.dynamicLights=d
table.insert(d,c)
end
},
{
action="nolight|unlight",
description="Removes dynamic light from your player",
run=function(ad)
for ae,af in ad.privateEnv.dynamicLights or{}do
af:Destroy()
end
ad.privateEnv.dynamicLights={}

local ae=ad.playerService:getCharacter()
if ae then
for af,ag in ae:GetDescendants()do
if ag:IsA"PointLight"then
ag:Destroy()
end
end
end
end
}
}end a.cl=function()local ab=a.cache.cl if not ab then ab={c=aa()}a.cache.cl=ab end return ab.c end end do local aa=function()

return{a.cf()
,a.cg()
,a.ch()
,a.ci()
,a.cj()
,a.ck()
,a.cl()

}end a.cm=function()local ab=a.cache.cm if not ab then ab={c=aa()}a.cache.cm=ab end return ab.c end end do local aa=function()





local aa=a.bx()

local ab={}local ac=function(

ac, ad)
local ae=table.find(ac,ad)
if ae then
table.remove(ac,ae)
end end



ab.add=function(ad, ae, af)
ae=ae:lower()

if ad.lookup[ae]~=nil then
return false,`'{ae}' is already a command or an alias`
end

local ag=ad.lookup[af:lower()]
if not ag then
return false,"invalid command"
end

ad.lookup[ae]=ag
table.insert(ad.array,ae)

aa.object[ae]=ag.name
aa:save()

return true end



ab.remove=function(ad, ae)
ae=ae:lower()

local af=aa.object[ae]
if type(af)~="string"then
return false
end

ad.lookup[ae]=nil
ac(ad.array,ae)

aa.object[ae]=nil
aa:save()

return true,af end



ab.clear=function(ad)
local ae={}
for af in aa.object do
table.insert(ae,af)
end

for af,ag in ae do
ad.lookup[ag]=nil
ac(ad.array,ag)
aa.object[ag]=nil
end

aa:save()
return#ae end



ab.restore=function(ad)
for ae,af in aa.object do
local ag=type(af)=="string"and ad.lookup[af]

if ag and ad.lookup[ae]==nil then
ad.lookup[ae]=ag
table.insert(ad.array,ae)
end
end end


return ab end a.cn=function()local ab=a.cache.cn if not ab then ab={c=aa()}a.cache.cn=ab end return ab.c end end do local aa=function()

local aa=a.cn()

return{
{
action="addalias",
description="Adds an alias to a command",
args={
{
kind="command"
},
{
kind="string",
name="alias"
}
},
run=function(ab,ac)
local ad=ac:nextValue()
local ae=ac:nextValue()
if not(ad and ae)then return end

local af,ag=aa.add(ab.commandsList,ae,ad)
if af then
ab:notify("Aliases Modified",`Added {ae:lower()} as an alias to {ad}`)
else
ab:notify("Aliases Modified",ag)
end
end
},
{
action="removealias",
description="Removes a custom alias",
args={kind="alias"},
run=function(ab,ac)
local ad=ac:nextValue()
if not ad then return end

local ae,af=aa.remove(ab.commandsList,ad)
if ae then
ab:notify("Aliases Modified",`Removed the alias {ad} from {af}`)
end
end
},
{
action="clraliases",
description="Removes all custom aliases",
args={
kind="boolean",
name="confirm",
optional=true
},
run=function(ab,ac)

if ac and ac:nextValue()==false then return end

local ad=aa.clear(ab.commandsList)
ab:notify("Aliases Modified",`Removed {ad} custom alias(es)`)
end
}
}end a.co=function()local ab=a.cache.co if not ab then ab={c=aa()}a.cache.co=ab end return ab.c end end do local aa=function()




















local aa=a.a()
local ab=a.j()
local ac=a.bv()

local ad={}

local ae=".luau"
local af=`{ab.privateFolder}/plugins`

ad.FOLDER=af


local ag={}local b=function(

b, c)
local d=table.find(b,c)
if d then
table.remove(b,d)
end end local c=function(



c)
local d=c
if d:sub(-#ae)==ae then
d=d:sub(1,-#ae-1)
end

if d:match"^[%w_%-]+$"then
return d
end
return nil end local d=function(


d)
return`{af}/{d}{ae}`end local e=function(


e)
if aa.readfile==nil or aa.isfile==nil then
return nil,"your exploit does not support readfile"
end

local f=d(e)

local g,h=pcall(aa.isfile,f)
if not(g and h)then
return nil,`file not found: {f}`
end

local i,j=pcall(aa.readfile,f)
if not(i and type(j)=="string")then
return nil,`could not read {f}`
end

return j end local f=function(



f)
if aa.loadstring==nil then
return nil,"your exploit does not support loadstring"
end

local g,h,i=pcall(aa.loadstring,f)
if not g then
return nil,tostring(h)
end
if not h then
return nil,tostring(i)
end

local j,k=pcall(h)
if not j then
return nil,`error while loading the plugin: {k}`
end
if type(k)~="table"then
return nil,"the plugin must return a table of commands"
end

return k end local g=function(




g)
local h=g
if type(g.action)=="string"then
h={g}
end

local i={}

for j,k in h do
if type(k)~="table"or type(k.action)~="string"then
return nil,"every command needs an action string"
end

if k.run~=nil and type(k.run)~="function"then
return nil,`run of '{k.action}' must be a function`
end

local l={}
for m,n in k.action:split"|"do
local o=n:lower()
if o==""then
return nil,`empty name in '{k.action}'`
end
table.insert(l,o)
end


local m={}
for n,o in k do
m[n]=o
end

local n=m.args or{}
if#n==0 and next(n)then
n={n}
end
m.args=n

local o=table.clone(l)
table.sort(o,function(p,q)
return#p<#q
end)

m.name=l[1]
m.aliases=o
m.action=nil

table.insert(i,{entry=m,names=l})
end

if#i==0 then
return nil,"the plugin has no commands"
end

return i end local h=function(



h, i)
local j,k=e(i)
if not j then
return false,k
end

local l,m=f(j)
if not l then
return false,m
end

local n,o=g(l)
if not n then
return false,o
end

local p={}
local q={}

for r,s in n do
for t,u in s.names do
if h.lookup[u]~=nil or q[u]then
return false,`'{u}' is already a command or an alias`
end
q[u]=true
table.insert(p,u)
end
end

for r,s in n do
for t,u in s.names do
h.lookup[u]=s.entry
table.insert(h.array,u)
end
end

ag[i]={keys=p}
return true,#n end local i=function(


i, j)
local k=ag[j]
if not k then return end

for l,m in k.keys do
i.lookup[m]=nil
b(i.array,m)
end

ag[j]=nil end



ad.add=function(j, k)
local l=c(k)
if not l then
return false,"plugin names can only use letters, numbers, '_' and '-'"
end

if ag[l]then
return false,`'{l}' is already loaded`
end

local m,n=h(j,l)
if not m then
return false,n
end

ac.object[l]=l..ae
ac:save()

return true,n end



ad.remove=function(j, k)
if ac.object[k]==nil and ag[k]==nil then
return false
end

i(j,k)

ac.object[k]=nil
ac:save()

return true end



ad.reload=function(j, k)
if ac.object[k]==nil then
return false,`'{k}' is not installed`
end

i(j,k)
return h(j,k)end




ad.restore=function(j)
local k={}

for l in ac.object do
if not ag[l]then
local m,n=h(j,l)
if not m then
k[l]=tostring(n)
end
end
end

return k end



ad.addAll=function(j)
if aa.listfiles==nil then
return nil,"your exploit does not support listfiles"
end

local k,l=pcall(aa.listfiles,af)
if not(k and type(l)=="table")then
return nil,`could not read the folder {af} (create it and put your .luau plugins there)`
end

local m={added={},failed={}}

for n,o in l do
local p=type(o)=="string"and o:match"([^/\\]+)%.luau$"

if p and not ag[p]then
local q,r=ad.add(j,p)
if q then
table.insert(m.added,p)
else
table.insert(m.failed,`{p}: {r}`)
end
end
end

return m end


return ad end a.cp=function()local ab=a.cache.cp if not ab then ab={c=aa()}a.cache.cp=ab end return ab.c end end do local aa=function()

local aa=a.cp()

return{
{
action="addplugin|plugin",
description="Add a plugin via command",
args={
kind="string",
name="plugin name"
},
run=function(ab,ac)
local ad=ac:nextValue()
if not ad then return end

local ae,af=aa.add(ab.commandsList,ad)
if ae then
ab:notify("Plugins",`Added '{ad}' ({af} command(s))`)
else
ab:notify("Plugin Error",af)
end
end
},
{
action="removeplugin|deleteplugin",
description="Remove a plugin via command",
args={kind="plugin"},
run=function(ab,ac)
local ad=ac:nextValue()
if not ad then return end

if aa.remove(ab.commandsList,ad)then
ab:notify("Plugins",`Removed '{ad}'`)
end
end
},
{
action="reloadplugin",
description="Reloads a plugin",
args={kind="plugin"},
run=function(ab,ac)
local ad=ac:nextValue()
if not ad then return end

local ae,af=aa.reload(ab.commandsList,ad)
if ae then
ab:notify("Plugins",`Reloaded '{ad}' ({af} command(s))`)
else
ab:notify("Plugin Error",af)
end
end
},
{
action="addallplugins|loadallplugins",
description="Adds all plugins from the infiniteYield/plugins folder",
run=function(ab)
local ac,ad=aa.addAll(ab.commandsList)
if not ac then
ab:notify("Plugin Error",ad)
return
end

local ae=`Added {#ac.added} plugin(s)`
if#ac.failed>0 then
ae=ae..`, {#ac.failed} failed (see console)`
for af,ag in ac.failed do
warn(`plugin {ag}`)
end
end

ab:notify("Plugins",ae)
end
}
}end a.cq=function()local ab=a.cache.cq if not ab then ab={c=aa()}a.cache.cq=ab end return ab.c end end do local aa=function()

local aa=a.d()local ab=function(


ab)
local ac={}
local ad={}
local ae={}local af=function(

af)
aa:expect(af.action,{"string"},"command action")
table.insert(ac,af)

local ag={}
local b=af.args or{}
af.args=b

for c,d in af.action:split"|"do
if not af.name then
af.name=d
end

ad[d]=af

table.insert(ag,d)
table.insert(ae,d)
end

table.sort(ag,function(c,d)
return#c<#d
end)

if#b==0 and next(b)then
af.args={b}
end

af.aliases=ag
af.action=nil end


for ag,b in ab do
aa:expect(b.name,{"string"},"section name")
aa:expect(b.commands,{"table"},"section commands")

table.insert(ac,{
isSection=true,
sectionName=b.name
})

for c,d in b.commands do
if#d==0 then
aa:assert(next(d),"the command cannot be empty")
af(d)
continue
end

for e=1,#d do
af(d[e])
end
end
end

return{
array=ae,
lookup=ad,
original=ac
}end


return ab{
{
name="general",
commands=a.ax()
},
{
name="character",
commands=a.a7()
},
{
name="waypoints",
commands=a.a8()
},
{
name="teleport",
commands=a.bt()
},
{
name="communication",
commands=a.bK()
},
{
name="visual",
commands=a.bP()
},
{
name="camera",
commands=a.b3()
},
{
name="workspace",
commands=a.ce()
},
{
name="lighting",
commands=a.cm()
},
{
name="aliases",
commands=a.co()
},
{
name="plugins",
commands=a.cq()
}
}end a.cr=function()local ab=a.cache.cr if not ab then ab={c=aa()}a.cache.cr=ab end return ab.c end end do local aa=function()

































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































local aa={}
local ab={}

aa.__index=aa
ab.__index=ab

aa.Disconnect=function(ac)
if not ac._isConnected then return end

local ad=ac.Parent and ac.Parent.Connections
local ae=ad and table.find(ad,ac)

if ae then
table.remove(ad,ae)
end

ac._connectedFunc=nil
ac._isConnected=false end


aa.Fire=function(ac, ...)
if ac._connectedFunc~=nil then
task.spawn(ac._connectedFunc,...)
end end


aa.new=function(ac, ad)
local ae=setmetatable({
_isConnected=true,
_connectedFunc=ad,
Parent=ac
},aa)

table.insert(ac.Connections,ae)
return ae end


ab.Connect=function(ac, ad)
assert(type(ad)=="function",`function expected, got {type(ad)}`)

return aa.new(ac,ad)end


ab.Once=function(ac, ad)
local ae

ae=ac:Connect(function(...)
ae:Disconnect()
task.spawn(ad,...)
end)

return ae end


ab.Wait=function(ac)
local ad,ae=(coroutine.running())

ae=ac:Connect(function(...)
ae:Disconnect()
task.spawn(ad,...)
end)

return coroutine.yield()end


ab.Fire=function(ac, ...)
for ad,ae in ipairs(ac.Connections)do
ae:Fire(...)
end end


ab.new=function()
return setmetatable({
Connections={}
},ab)end


return ab end a.cs=function()local ab=a.cache.cs if not ab then ab={c=aa()}a.cache.cs=ab end return ab.c end end do local aa=function()
local aa={}


aa.searchAtArray=function(ab, 
ac, 
ad, 
ae)

if ad==""then return{}end

local af=ad:lower()
local ag={}
local b={}

for c,d in ac do
local e=tostring(d):lower()

if#e<#af then continue end

local f=e:find(af,1,true)

if f==1 then
table.insert(ag,d)
elseif f and not ae then
table.insert(b,d)
end
end

for c,d in b do
table.insert(ag,d)
end

return ag end


return aa end a.ct=function()local ab=a.cache.ct if not ab then ab={c=aa()}a.cache.ct=ab end return ab.c end end do local aa=function()

local aa={}

local ab={Vector3=
function(ab)
return`{ab.X} {ab.Y} {ab.Z}`
end,Color3=
function(ab)
return`{ab.R} {ab.G} {ab.B}`
end
}

local ac={Vector3=
function(ac)
local ad=ac:split" "
return Vector3.new(ad[1]or 0,ad[2]or 0,ad[3]or 0)
end,Color3=
function(ac)
local ad=ac:split" "
return Color3.new(ad[1]or 0,ad[2]or 0,ad[3]or 0)
end
}

aa.stringify=function(ad, ae)
local af=ab[typeof(ae)]
assert(af,"can't convert to string")

return af(ae)end


aa.unstringify=function(ad, ae, af)
local ag=ac[af]
assert(ag,"can't convert to value")

return ag(ae)end


return aa end a.cu=function()local ab=a.cache.cu if not ab then ab={c=aa()}a.cache.cu=ab end return ab.c end end do local aa=function()
local aa={}

return aa end a.cv=function()local ab=a.cache.cv if not ab then ab={c=aa()}a.cache.cv=ab end return ab.c end end do local aa=function()
local aa=a.cv()
local ab=a.d()

local ac={}

ac.setProperties=function(ad, ae)
for af,ag in ae do
if aa[af]then
aa[af](ad,ag)
continue
end


if type(af)=="number"and typeof(ag)=="Instance"then
ag.Parent=ad
continue
end

ad[af]=ag
end
return ad end


ac.setup=function(ad, ...)
for ae,af in{...}do
local ag=typeof(af)

if ag=="table"then
ac.setProperties(ad,af)
else
local b=if ag=="string"then"Name"else"Parent"
ad[b]=af
end
end
return ad end


ac.new=function(ad, ...)
local ae=Instance.new(ad)
return ac.setup(ae,...)end


return ac end a.cw=function()local ab=a.cache.cw if not ab then ab={c=aa()}a.cache.cw=ab end return ab.c end end do local aa=function()
local aa=a.n()
local ab=a.d()

local ac="https://raw.githubusercontent.com/%s/%s/refs/heads/main/"
ac=ac:format(aa.owner,aa.repository)

local ad={}local ae=function(

ae)
return game:HttpGet(ae)end


ad.load=function(af, ag)
local b=ad.fetch(af)
return if b~=nil then loadstring(b)else nil end


ad.fetch=function(af)
if af:sub(1,1)=="/"then
af=af:sub(2)
end

local ag,b=pcall(ae,ac..af)

if not ag then
ab:warn(`failed to fetch http url '{af}':\n\t{b}`)
return
end

return b end


return ad end a.cx=function()local ab=a.cache.cx if not ab then ab={c=aa()}a.cache.cx=ab end return ab.c end end do local aa=function()
local aa=a.h()
local ab=aa.CoreGui

local ac={}
ac.__index=ac

ac.destroy=function(ad)
ad.message:destroy()
setmetatable(ad,nil)end


ac.set=function(ad, ae)
if ae and#ae>0 then
ad.message.Text=ae
ad.message.Parent=ab
else
ad.message.Parent=nil
end end


ac.new=function()
return setmetatable({
message=Instance.new"Message"
},ac)end


return ac end a.cy=function()local ab=a.cache.cy if not ab then ab={c=aa()}a.cache.cy=ab end return ab.c end end do local aa=function()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cz=function()local ab=a.cache.cz if not ab then ab={c=aa()}a.cache.cz=ab end return ab.c end end do local aa=function()
local aa=a.cz()

local ab={}

ab.getScale=function(ac, ad)
return aa.isEnabled and(ad*aa.animationScale)or 0 end


ab.getScrollSpeed=function(ac, ad)
return(ad*aa.scrollSpeed)end


return ab end a.cA=function()local ab=a.cache.cA if not ab then ab={c=aa()}a.cache.cA=ab end return ab.c end end do local aa=function()
return{
createService=a.cw(),
specialProps=a.cv(),

connectionService=a.bl(),
fetchService=a.cx(),
localPlayer=a.af(),
messageService=a.cy(),
playerService=a.ag(),
rbxServices=a.h(),
tweenService=a.cA(),
}end a.cB=function()local ab=a.cache.cB if not ab then ab={c=aa()}a.cache.cB=ab end return ab.c end end do local aa=function()
return{
DisplayName="Classic",

FirstShade=Color3.fromRGB(36,36,37),
SecondShade=Color3.fromRGB(46,46,47),
ThirdShade=Color3.fromRGB(78,78,79),

DefaultText=Color3.new(1,1,1),
DarkText=Color3.new(0,0,0),

ScrollBar=Color3.fromRGB(78,78,79)
}end a.cC=function()local ab=a.cache.cC if not ab then ab={c=aa()}a.cache.cC=ab end return ab.c end end do local aa=function()
return{
DisplayName="Dark",

Font={
Normal=Enum.Font.BuilderSans,
Medium=Enum.Font.BuilderSansMedium,
Bold=Enum.Font.BuilderSansBold,
ExtraBold=Enum.Font.BuilderSansExtraBold,
MonoSpace=Enum.Font.RobotoMono
},
Colors={
Background=Color3.fromRGB(19,19,19),
Primary=Color3.fromRGB(88,101,242),
OnPrimary=Color3.fromRGB(61,67,135),
Stroke=Color3.fromRGB(45,45,45),

Error=Color3.fromRGB(255,102,102),
Icons=Color3.fromRGB(232,233,235),

ScrollBar={
Thumb=Color3.fromRGB(60,60,60),
Arrow=Color3.fromRGB(232,233,235),
Background=Color3.fromRGB(26,26,26)
},
Buttons={
Holding=Color3.fromRGB(42,42,42),
Default=Color3.fromRGB(34,34,34)
},
Border={
Holding=Color3.fromRGB(60,60,60),
Default=Color3.fromRGB(38,38,38),
},
Text={
Default=Color3.fromRGB(255,255,255),
Dark=Color3.fromRGB(200,200,200),
Darker=Color3.fromRGB(175,175,175),
},
Slider={
SliderBar=Color3.fromRGB(1,76,105),
SliderNumber=Color3.fromRGB(232,233,235),
},
}
}end a.cD=function()local ab=a.cache.cD if not ab then ab={c=aa()}a.cache.cD=ab end return ab.c end end do local aa=function()
return{
DisplayName="Light"
}end a.cE=function()local ab=a.cache.cE if not ab then ab={c=aa()}a.cache.cE=ab end return ab.c end end do local aa=function()
local aa={a.cC()
,a.cD()
,a.cE()

}

local ab={}

for ac,ad in aa do
local ae=string.lower(ad.DisplayName)
ab[ae]=ad
end

return ab end a.cF=function()local ab=a.cache.cF if not ab then ab={c=aa()}a.cache.cF=ab end return ab.c end end do local aa=function()
local aa={}

local ab="abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUV_0123456789"

local ac={
["&"]="&amp;",
["<"]="&lt;",
[">"]="&gt;",
["\""]="&quot;",
["'"]="&apos;"
}

aa.randomString=function(ad)
local ae={}
for af=1,ad do
local ag=math.random(1,#ab)
table.insert(ae,ab:sub(ag,ag))
end
return table.concat(ae)end


aa.getDeep=function(ad, ae)
for af in ae:gmatch"[^%.]+"do
ad=ad[af]
end
return ad end


aa.simpleCreate=function(ad, ae)
local af=Instance.new(ad)
for ag,b in ae do
af[ag]=b
end
return af end


aa.chararray=function(ad)
local ae={}
for af=1,#ad do
table.insert(ae,ad:sub(af,af))
end
return ae end


aa.lookupify=function(ad)
local ae={}
for af=1,#ad do
local ag=ad[af]
ae[ag]=true
end
return ae end


aa.unlookupify=function(ad)
local ae={}
for af,ag in ad do
table.insert(ae,af)
end
return ae end


aa.escapeRichText=function(ad)
local ae=tostring(ad):gsub(".",function(ae)
return ac[ae]or ae
end)
return ae end


aa.charset=function(ad)
local ae={}
for af in ad:gmatch"."do
ae[af]=true
end
return ae end


aa.versionToNumber=function(ad)
local ae=ad:gsub("^v","")

local af=0
local ag=ae:split"."

for b,c in ag do
local d=tonumber(c)or 0
af=af+d*math.pow(1000,3-b)
end

return af end


aa.colorFromRGB=function(ad, ae)
return`<font color="#{ae:ToHex()}">{ad}</font>`end


aa.richFontSize=function(ad, ae)
return`<font size="{ae}">{ad}</font>`end


return aa end a.cG=function()local ab=a.cache.cG if not ab then ab={c=aa()}a.cache.cG=ab end return ab.c end end do local aa=function()
local aa=a.cF()

local ab=a.d()
local ac=a.cG()

local ad={
objects={},
selectedTheme=nil
}

ad.selectTheme=function(ae, af)
ab:expect(af,{"string"},"'themeService:selectTheme' #1")

local ag=aa[af:lower()]

if not ag then
ab:error(`'{af}' isn't a valid theme`)
return
end

if ag~=ae.selectedTheme then
ae.selectedTheme=ag
ae:updateObjects()
end

return ae end


ad.updateObject=function(ae, af)

ae:updateObjectProperties(af,ae.objects[af])end


ad.updateObjectProperties=function(ae, 
af, 
ag)

for b,c in ag do
af[b]=ac.getDeep(ae.selectedTheme,c)
end end


ad.updateObjects=function(ae)
for af,ag in ae.objects do
ae:updateObject(af)
end end


ad.addObject=function(ae, af, ag)
ae.objects[af]=ag
ae:updateObject(af)end



ad.init=function(ae, af)
ab:expect(af,{"table"},"'themeService:init' #1")

if af.theme~=nil then
ae:selectTheme(af.theme)
end end


return ad end a.cH=function()local ab=a.cache.cH if not ab then ab={c=aa()}a.cache.cH=ab end return ab.c end end do local aa=function()


local aa=a.cB()
local ab=a.d()

local ac=aa.specialProps
local ad=a.cH()

ac.ThemeTag=function(ae, af)
if type(af)~="table"then
ab:error"expected a 'table' when setting a theme tag"
return
end

ad:addObject(ae,af)end


return a.cw()end a.cI=function()local ab=a.cache.cI if not ab then ab={c=aa()}a.cache.cI=ab end return ab.c end end do local aa=function()return{bindsandplugins="rbxassetid://5147695474",close="rbxassetid://5054663650",editaliases="rbxassetid://5147488658",editkeybinds="rbxassetid://129697930",edittheme="rbxassetid://4911962991",editwaypoints="rbxassetid://5147488592",imgstudiopluginlogo="rbxassetid://4113050383",logo="rbxassetid://1352543873",minimize="rbxassetid://2406617031",pin="rbxassetid://6234691350",reference="rbxassetid://3523243755",settings="rbxassetid://1204397029",}end a.cJ=function()local ab=a.cache.cJ if not ab then ab={c=aa()}a.cache.cJ=ab end return ab.c end end do local aa=function()local aa=a.a()
local ab=a.p()

local ac=ab.storage.imagePath

local ad=a.k()
local ae=a.cx()
local af=a.d()

local ag=a.cJ()

local b={}
local c={}

local d=aa.getcustomasset

local e={}

e.newCustomAsset=function(f, g, h)
af:assert(not b[g],"asset is already loaded")

local i=ad:getCustomAsset(h)

if i==nil then
i=ag[g]
b[g]=i
return i
end

af:log(`new custom asset to '{h}': '{i}'`)
return i end


e.get=function(f, g)
if b[g]then
return b[g]
end

if type(d)~="function"then
return ag[g]
end

local h=ac:format(g)
af:log(`loading asset: '{h}'`)

if ad:exist(h)then
return f:newCustomAsset(g,h)
end

local i=ae.fetch(h)

if i==nil then
local j=ag[g]
b[g]=j
return j
end

ad:writeFile(h,i)
af:log(`created a file to asset: '{h}'`)

return f:newCustomAsset(g,h)end


e.loadImage=function(f, g, h)
af:assert(ag[h],`invalid asset name: {h}`)

local i=b[h]
if i~=nil then
g.Image=i
return
end

g.Image=""

if c[h]then
table.insert(c[h],g)
return
end

c[h]={g}

task.defer(function()
local j=f:get(h)
if not j then return end

for k,l in c[h]do
l.Image=j
end

c[h]=nil
end)end


return e end a.cK=function()local ab=a.cache.cK if not ab then ab={c=aa()}a.cache.cK=ab end return ab.c end end do local aa=function()



return{

defaultTime=5,
defaultTitle="Notification",


size=UDim2.fromOffset(250,100),
cornerRadius=6,
titleHeight=20,
iconSize=11,


titleTextSize=14,
textSize=14,
padding=8,


spacing=4,
gapToWindow=0,
maxVisible=5,


tweenTime=0.5,
flashTime=0.5,
}end a.cL=function()local ab=a.cache.cL if not ab then ab={c=aa()}a.cache.cL=ab end return ab.c end end do local aa=function()

local aa=Color3.fromRGB(248,109,115)
local ab=Color3.fromRGB(223,215,136)
local ac=Color3.fromRGB(156,121,223)
local ad=Color3.fromRGB(225,37,105)
local ae=Color3.fromRGB(118,113,94)
local af=Color3.fromRGB(97,181,195)
local ag=Color3.fromRGB(254,193,7)
local b=Color3.fromRGB(244,66,54)
local c=Color3.fromRGB(166,227,45)
local d=Color3.fromRGB(255,149,75)

return{
args={number=
ac,boolean=
ac,text=
ab,string=
ab,symbol=
ad,comment=
ae,others=
af,warn=
ag,error=
b,valid=
c,tag=
d
},
commands={undefined=
b,client=
ab,deprecated=
ae
}
}end a.cM=function()local ab=a.cache.cM if not ab then ab={c=aa()}a.cache.cM=ab end return ab.c end end do local aa=function()







local aa=a.cM().args
local ab=a.cG()

local ac={}


local ad=ab.charset":#()[]<>{}-––&*$%@"


local ae="^[%w_%.]+"


local af="^[%w_]+"local ag=function(

ag)
return ag~=""and string.match(ag,"[%w_%.]")~=nil end local b=function(


b)
return string.match(b,"^%d+$")~=nil or string.match(b,"^%d+%.%d+$")~=nil end local c=function(



c)
local d={}local e=function(

e, f, g)
if e==""then
return
end

local h=d[#d]
if h and h.color==f and h.bold==g then
h.text=h.text..e
else
table.insert(d,{text=e,color=f,bold=g})
end end


local f=1
local g=#c

while f<=g do
local h=string.sub(c,f,f)
local i=if f>1 then string.sub(c,f-1,f-1)else""


if(h=="@"or h=="#")and not ag(i)then
local j,k=string.find(c,af,f+1)
if k then
e(string.sub(c,f,k),aa.tag,true)
f=k+1
continue
end
end

if ag(h)then
local j,k=string.find(c,ae,f)
local l=string.sub(c,f,k)
e(l,if b(l)then aa.number else nil,false)
f=k+1
else
e(h,if ad[h]then aa.symbol else nil,false)
f=f+1
end
end

return d end


ac.apply=function(d, e)
local f={}

for g,h in c(tostring(e))do
local i=ab.escapeRichText(h.text)

if h.color then
i=ab.colorFromRGB(i,h.color)
end
if h.bold then
i=`<b>{i}</b>`
end

table.insert(f,i)
end

return table.concat(f)end


return ac end a.cN=function()local ab=a.cache.cN if not ab then ab={c=aa()}a.cache.cN=ab end return ab.c end end do local aa=function()



local aa=a.cI()
local ab=a.cK()
local ac=a.cH()

local ad=a.bl()
local ae=a.h()
local af=a.cL()

local ag=a.cN()

local b=4
local c=8

local d={
container=nil,

items={},
nextOrder=0,

queue={},
}local e=function(

e, f)
local g=aa.new("Frame","Notification",e,{
BorderSizePixel=0,
ClipsDescendants=true,
LayoutOrder=f,
Size=UDim2.fromOffset(af.size.X.Offset,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local h=b+af.iconSize+c

local i=aa.new("TextLabel","Title",g,{
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0),
Size=UDim2.new(1,-h*2,0,af.titleHeight),
Text="",
TextSize=af.titleTextSize,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local j=aa.new("Frame","Description",g,{
AnchorPoint=Vector2.new(0.5,1),
ClipsDescendants=true,
Position=UDim2.new(0.5,0,1,-5),
Size=UDim2.new(1,-10,1,-25),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})

aa.new("UICorner",j,{
CornerRadius=UDim.new(0,af.cornerRadius),
})

local k=aa.new("TextLabel","Text",j,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.new(1,-10,1,-10),
Text="",
TextSize=af.textSize,
RichText=true,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

local l=aa.new("ImageButton","PinButton",g,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,b,0,af.titleHeight/2),
Size=UDim2.fromOffset(af.iconSize,af.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local m=aa.new("ImageButton","CloseButton",g,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-b,0,af.titleHeight/2),
Size=UDim2.fromOffset(af.iconSize,af.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(l,"pin")
ab:loadImage(m,"close")

return g,i,k,l,m end local f=function(


f)
for g,h in f.connections do
ad:disconnect(h)
end

table.clear(f.connections)end


d.getContainer=function(g, h)
if g.container then
return g.container
end

local i=aa.new("Frame","Notifications",h,{
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(af.size.X.Offset,0),
})

aa.new("UIListLayout",i,{
Padding=UDim.new(0,af.spacing),
SortOrder=Enum.SortOrder.LayoutOrder,
})

g.container=i


i.ChildAdded:Connect(function()
g:refreshLayout()
end)

i.ChildRemoved:Connect(function()
g:refreshLayout()
end)

local j=g.queue
g.queue={}

for k,l in j do
g:add(l.title,l.message,l.duration)
end

return i end



d.getStackHeight=function(g)
local h=g.container
if not h then return 0 end

local i=0
local j=0

for k,l in h:GetChildren()do
if l:IsA"GuiObject"then
i=i+1
j=j+l.Size.Y.Offset
end
end

if i>1 then
j=j+(i-1)*af.spacing
end

return j end



d.refreshLayout=function(g)
local h=g.container
if not h then return end

h.Size=UDim2.fromOffset(af.size.X.Offset,g:getStackHeight())

if g.onLayoutChanged then
g.onLayoutChanged()
end end


d.tweenHeight=function(g, h, i)
if h.tween then
h.tween:Cancel()
end

local j=TweenInfo.new(af.tweenTime,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
h.tween=ae.TweenService:Create(h.frame,j,{
Size=UDim2.fromOffset(af.size.X.Offset,i),
})
h.tween:Play()end


d.pin=function(g, h)
if h.pinned or h.removed then return end
h.pinned=true

h.titleLabel.Text=h.title.." (Pinned)"
ac:addObject(h.pinButton,{ImageColor3="Colors.Primary"})

local i=h.titleLabel
task.spawn(function()
i.TextTransparency=0.5
task.wait(af.flashTime)
i.TextTransparency=0
end)end


d.remove=function(g, h)
if h.removed then return end
h.removed=true

local i=table.find(g.items,h)
if i then
table.remove(g.items,i)
end

f(h)

g:tweenHeight(h,0)
task.delay(af.tweenTime,function()
h.frame:Destroy()
end)end


d.trim=function(g)
while#g.items>af.maxVisible do
local h

for i,j in g.items do
if not j.pinned then
h=j
break
end
end

if not h then break end
g:remove(h)
end end


d.add=function(g, h, i, j)
g.nextOrder=g.nextOrder+1

local k={
title=h,
pinned=false,
removed=false,
connections={},
}

k.frame,k.titleLabel,k.textLabel,k.pinButton,k.closeButton=
e(g.container,g.nextOrder)

k.titleLabel.Text=h
k.textLabel.Text=ag:apply(i)

table.insert(k.connections,ad:Connect(k.pinButton.Activated,function()
g:pin(k)
end))

table.insert(k.connections,ad:Connect(k.closeButton.Activated,function()
g:remove(k)
end))

table.insert(g.items,k)
g:tweenHeight(k,af.size.Y.Offset)


k.frame:GetPropertyChangedSignal"Size":Connect(function()
g:refreshLayout()
end)
g:refreshLayout()

local l=if type(j)=="number"then j else af.defaultTime
task.delay(l,function()
if not k.pinned then
g:remove(k)
end
end)

g:trim()end


d.notify=function(g, h, i, j)
if i==nil then
i=h
h=af.defaultTitle
end

h=tostring(h)

if not g.container then
table.insert(g.queue,{title=h,message=i,duration=j})
return
end

g:add(h,i,j)end


d.destroy=function(g)
for h,i in g.items do
f(i)
end

table.clear(g.items)
table.clear(g.queue)
g.container=nil end


return d end a.cO=function()local ab=a.cache.cO if not ab then ab={c=aa()}a.cache.cO=ab end return ab.c end end do local aa=function()


local aa=a.b()
local ab=a.d()

local ac={

_callbacks={},
_nextId=0,
}local ad=function(


ad)
while true do
task.wait()

if next(ad._callbacks)==nil then
aa.loopThread=nil
return
end

local ae=os.clock()

for af,ag in ad._callbacks do
if ae-ag.lastCall>=ag.cooldown then
ag.lastCall=ae
task.defer(ag.func)
end
end
end end



ac.start=function(ae)
if aa.loopThread~=nil then
return
end

aa.loopThread=task.defer(ad,ae)end



ac.stop=function(ae)
local af=aa.loopThread
aa.loopThread=nil
table.clear(ae._callbacks)

if af~=nil then
task.cancel(af)
end end




ac.add=function(ae, af, ag)
ab:expect(af,{"function"},"'loopService:add' #1")
ab:expect(ag,{"number","nil"},"'loopService:add' #2")

ae._nextId=ae._nextId+1
local b=ae._nextId

ae._callbacks[b]={
func=af,
cooldown=math.max(ag or 0,0),
lastCall=-math.huge
}

ae:start()
return b end



ac.remove=function(ae, af)
ab:expect(af,{"number"},"'loopService:remove' #1")
ae._callbacks[af]=nil end


return ac end a.cP=function()local ab=a.cache.cP if not ab then ab={c=aa()}a.cache.cP=ab end return ab.c end end do local aa=function()
local aa=a.b()
local ab=a.a()

local ac=a.cr()
local ad=a.cs()
local ae=a.d()

local af=a.bz().usedCmds
local ag=a.h()
local b=a.p()

local c=a.ct()
local d=a.cn()
local e=a.cp()

local f=b.commands.cmdsRank
local g=f.maxTimesUsed
local h=f.decreasePerUse
local i=f.increasePerUse

local j=aa.iyGarbages or{}
aa.iyGarbages=j

local k={
garbages=j
}

k.registerGarbage=function(l, m)
return l:getGarbage(m)or l:createGarbage(m)end


k.createGarbage=function(l, m)
if l.garbages[m]==nil then
local n={}
l.garbages[m]=n
return n
end end



k.getCommandData=function(l, m)
return ac.lookup[m:lower()]end


k.hasGarbage=function(l, m)
return l.garbages[m]~=nil end


k.getGarbage=function(l, m)
return l.garbages[m]end


k.collectGarbage=function(l, m)
local n=l.garbages[m]

if n~=nil then
l.garbages[m]=nil
return n
end end


k.commandUsed=function(l, m)
local n=af:getValue(m)or 0

local o=math.clamp(n+i,0,g)
af:setValue(m,o)

for p,q in af:getData()do
if p==m then continue end

local r=(o==g)

if(r or q<o)and q>0 then
q=q-h

if q==0 then q=nil end
af:setValue(p,q)
end
end

af:save()end local l=function(



l)
local m={}
if l and l.args then
for n,o in l.args do
m[n]={value=o.value}
end
end
return m end




local m=setmetatable({},{__mode="k"})


k.run=function(n, o, p, q)
ae:expect(o,{"string"},"'commandsController:run' #1")
ae:expect(p,{"table","nil"},"'commandsController:run' #2")

local r=ac.lookup[o]
ae:assert(r,"invalid command")

local s=coroutine.running()
local t=m[s]~=nil
local u=t and not q

if not u then
n:commandUsed(r.name)


local v=l(p)
n.privateEnv.lastArgs=n.privateEnv.lastArgs or{}
n.privateEnv.lastArgs[r.name]=v

if r.name~="lastcommand"then
n.privateEnv.lastCommand={
name=r.name,
args=v
}
end
end

if r.run==nil then
ae:warn(`missing command run func: {r.name}`)
return
end

m[s]=true
local v,w=pcall(r.run,n,p)
if not t then
m[s]=nil
end

if not v then
error(w,0)
end end



k.getLastArgs=function(n, o)
local p=n.privateEnv.lastArgs
return p and p[o]end local n=function(


n)
local o=ac.lookup[n:lower()]
if o==nil then return 0 end


return af:getValue(o.name)or 0 end


k.search=function(o, p, q)
local r=c:searchAtArray(ac.array,p,q)
local s=p:lower()
local t={}

for u,v in r do
table.insert(t,{
alias=v,
index=u,
isPrefix=v:lower():sub(1,#s)==s,
usage=n(v),
})
end

table.sort(t,function(u,v)
if u.isPrefix~=v.isPrefix then return u.isPrefix end
if u.usage~=v.usage then return u.usage>v.usage end
return u.index<v.index
end)

local u={}
for v,w in t do
u[v]=w.alias
end

return u end


k.init=function(o, p)
ae:assert(p,"'commandsController:init' #1 expected a config to init")

local q=a.bl()
local r=a.cu()
local s=a.cO()


o.notify=function(t, ...)
return s:notify(...)end


o.stringify=function(t, ...)
return r:stringify(...)end


o.unstringify=function(t, ...)
return r:unstringify(...)end


o.connect=function(t, ...)
return q:Connect(...)end


o.expectExploit=function(t, u)
local v=ab[u]
if v~=nil then return v end

t:notify("Incompatible Exploit",`Your exploit does not support this command (missing {u})`)end


o.getRoot=function(t)
local u=t.playerService:getRootPart()
if u then return u end

t:notify("Character","your character is not loaded")end



o.localPlayer=a.af()
o.executorEnv=ab
o.privateEnv=aa


o.infiniteYield=p.infiniteYield
o.playerService=p.playerService
o.fetchService=p.fetchService


o.signals={
onCameraReset=ad.new()
}


o.config={
links=b.links
}


o.userSettings=UserSettings()
o.gameSettings=settings()

o.userGameSettings=o.userSettings:GetService"UserGameSettings"
o.gameNetworkSettings=o.gameSettings:GetService"NetworkSettings"


o.loopService=a.cP()


o.storage=a.bz()


o.robloxServices=ag
o.rbxServices=ag

o.teleportService=ag.TeleportService
o.groupService=ag.GroupService
o.runService=ag.RunService
o.starterGui=ag.StarterGui
o.coreGui=ag.CoreGui
o.players=ag.Players
o.guiService=ag.GuiService
o.networkClient=ag.NetworkClient
o.proximityPromptService=ag.ProximityPromptService
o.commandsList=ac


d.restore(ac)


for t,u in e.restore(ac)do
ae:warn(`plugin '{t}' could not be loaded: {u}`)
end end


return k end a.cQ=function()local ab=a.cache.cQ if not ab then ab={c=aa()}a.cache.cQ=ab end return ab.c end end do local aa=function()
return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.cR=function()local ab=a.cache.cR if not ab then ab={c=aa()}a.cache.cR=ab end return ab.c end end do local aa=function()



local aa={}

local ab=a.p()
local ac=a.cR()

aa.getEasterDate=function()
local ad=tonumber(os.date"%Y")

local ae=math.floor(ad/100)
local af=math.floor((13+8*ae)/25)
local ag=(15-af+ae-math.floor(ae/4))%30
local b=(4+ae-math.floor(ae/4))%7

local c=(19*(ad%19)+ag)%30
local d=(2*(ad%4)+4*(ad%7)+6*c+b)%7
local e=22+c+d

if c==29 and d==6 then
return"04 19"
elseif c==28 and d==6 then
return"04 18"
end

if e>31 then
return string.format("04 %02d",e-31)
end

return string.format("03 %02d",e)end


aa.getHolidayEmoji=function()
local ad=aa.getEasterDate()

local ae={
["01 01"]=ac.NEW_YEAR,
["02 14"]=ac.VALENTINE_DAYS,
["03 17"]=ac.CLOVER,
["10 31"]=ac.HALLOWEEN,
["12 25"]=ac.CHRISTMAS,
[ad]=ac.EASTER
}

local af=os.date"%m %d"
return ae[af]end


aa.getDisplayName=function()
local ad=ab.applicationName
local ae=ab.version

ad=string.gsub(ad,"!VERSION",ae)

local af=aa.getHolidayEmoji()

if af then
ad=`{af} {ad} {af}`
end

return ad end


return aa end a.cS=function()local ab=a.cache.cS if not ab then ab={c=aa()}a.cache.cS=ab end return ab.c end end do local aa=function()
return{
uiScale=Instance.new"UIScale",
getScale=function(aa)
local ab=aa.uiScale
return ab and(ab:GetAttribute"REAL_SCALE"or ab.Scale)or 1
end,
setScale=function(aa,ab)
local ac=aa.uiScale

if ac then
ac.Scale=ab
ac:SetAttribute("REAL_SCALE",ab)
end
end
}end a.cT=function()local ab=a.cache.cT if not ab then ab={c=aa()}a.cache.cT=ab end return ab.c end end do local aa=function()





local aa={}



aa.compute=function(ab, ac, ad, ae)
local af=ac.width-ab.right-ae
local ag=ab.left-ae


local b
if af>=ad.width then
b=true
elseif ag>=ad.width then
b=false
else
b=af>=ag
end



local c=ab.top+(ab.bottom-ab.top)/2
local d=c>ac.height/2

local e=if b then ab.right+ae else ab.left-ae
local f=if d then ab.bottom-ad.height else ab.top


f=math.clamp(f,0,math.max(ac.height-ad.height,0))

return{
x=e,
y=f,
anchorX=if b then 0 else 1,
}end


return aa end a.cU=function()local ab=a.cache.cU if not ab then ab={c=aa()}a.cache.cU=ab end return ab.c end end do local aa=function()



local aa=a.cI()

local ab={}

ab.create=function(ac)
local ad=aa.new("Frame","MainFrame",{
Active=true,
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Background"
},
aa.new("Frame","TopBar",{
Size=UDim2.fromOffset(250,20),
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Background"
}
})
})

local ae=ad.TopBar

local af=aa.new("TextLabel","Title",ae,{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
TextSize=16,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.Normal"
}
})

local ag=aa.new("ImageButton",ae,{
Name="SettingsButton",
BackgroundTransparency=1,
Position=UDim2.new(1,-2,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Size=UDim2.fromOffset(19,19),
ThemeTag={
ImageColor3="Colors.Icons"
}
})

local b=aa.new("ImageButton",ae,{
Name="ReferenceButton",
BackgroundTransparency=1,
Position=UDim2.new(1,-22,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Size=UDim2.fromOffset(15,15),
ThemeTag={
ImageColor3="Colors.Icons"
}
})

return{
mainFrame=ad,
topBar=ae,
titleLabel=af,
buttons={
settings=ag,
reference=b
}
}end


return ab end a.cV=function()local ab=a.cache.cV if not ab then ab={c=aa()}a.cache.cV=ab end return ab.c end end do local aa=function()

local aa=a.cI()

local ab={up=
function(ab,ac)
local ad=1/ab
local ae=ac/ab

local af=UDim2.fromScale(ae,ad)
local ag=UDim2.fromScale(
0.5-(ae/2),
(ac-1)*ad
)
return af,ag
end,down=
function(ab,ac)
local ad=1/ab
local ae=ac/ab

local af=UDim2.fromScale(ae,ad)
local ag=UDim2.fromScale(
0.5-(ae/2),
1-(ac*ad)
)
return af,ag
end,left=
function(ab,ac)
local ad=1/ab
local ae=ac/ab

local af=UDim2.fromScale(ad,ae)
local ag=UDim2.fromScale(
(ac-1)*ad,
0.5-(ae/2)
)
return af,ag
end,right=
function(ab,ac)
local ad=1/ab
local ae=ac/ab

local af=UDim2.fromScale(ad,ae)
local ag=UDim2.fromScale(
1-(ac*ad),
0.5-(ae/2)
)
return af,ag
end
}

return function(ac,ad,ae)
local af=ab[ae]
if not af then
error("r u ok? Invalid direction: "..tostring(ae))
end

local ag=aa.new("Frame","Arrow",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
aa.new("UIScale",{
Scale=ad
})
})

for b=1,ac do
local c,d=af(ac,b)

aa.new("Frame",`line_{b}`,{
BackgroundColor3=Color3.fromRGB(220,220,220),
BorderSizePixel=0,
Size=c,
Position=d,
Parent=ag,
ThemeTag={
BackgroundColor3="Colors.Icons"
}
})
end

return ag
end end a.cW=function()local ab=a.cache.cW if not ab then ab={c=aa()}a.cache.cW=ab end return ab.c end end do local aa=function()
return{
pressingInputs={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}
}end a.cX=function()local ab=a.cache.cX if not ab then ab={c=aa()}a.cache.cX=ab end return ab.c end end do local aa=function()
local aa=a.bl()
local ab=a.h()
local ac=a.cI()
local ad=a.ag()
local ae=a.cH()

local af=a.cW()
local ag=a.cT()

local b=a.cs()

local c=a.cX()

local d=ab.UserInputService

local e={}
e.__index=e local f=function(

f)
return c.pressingInputs[f.UserInputType]~=nil end


e.awake=function(g)
local h=ad:getMouse()

local i=g.scrollThumbFrame
local j=g.scrollThumb
local k=g.scrollBar

local l=false
local m=false
local n local o=function(

o, p)local q=function()

if l then return end
if not g:canScroll(p)then return end

l=true

g:scrollToDirection(p)

local q
q=aa:Connect(d.InputEnded,function(r)
if not f(r)then return end

q:Disconnect()
l=false
end)

task.wait(0.4)

while g:canScroll(p)and l do
g:scrollToDirection(p)
task.wait(6.666666666666666E-2)
end end


aa:Connect(o.MouseButton1Down,q)end




o(g.upButton,"up")
o(g.downButton,"down")

aa:Connect(k.MouseWheelForward,function()
g:scrollTo(g.index-g.wheelIncrement)
end)

aa:Connect(k.MouseWheelBackward,function()
g:scrollTo(g.index+g.wheelIncrement)
end)

aa:Connect(k.InputBegan,function(p)
if not f(p)then return end
if g:isScrollBarDisabled()then return end

local q=not ad:isMouseInGuiObject(j)
local r=g.isHorizontal and"X"or"Y"

local s
m=true

ae:updateObjectProperties(j,{
BackgroundColor3="Colors.Primary"
})

local t=h[r]-j.AbsolutePosition[r]
local u
local v local w=function()


if u then u:Disconnect()end
if v then v:Disconnect()end end


u=aa:Connect(d.InputEnded,function(x)
if not f(x)then return end

w()
m=false

ae:updateObjectProperties(j,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if q then local x=function()

local x=(h[r]>=j.AbsolutePosition[r]+j.AbsoluteSize[r])and 1 or 0
local y=g.visibleSpace-1

if x==0 and(
h[r]<j.AbsolutePosition[r]
)then
g:scrollTo(g.index-y)
elseif x==1 and(
h[r]>=j.AbsolutePosition[r]+j.AbsoluteSize[r]
)then
g:scrollTo(g.index+y)
end end


while m do
x()
task.wait(0.25)
end
return
end

v=aa:Connect(d.InputChanged,function(x)
if not m then return end
if not f(x)then return end

local y=i.AbsoluteSize[r]-j.AbsoluteSize[r]
local z=h[r]-i.AbsolutePosition[r]-t

if z>y then
z=y
elseif z<0 then
z=0
end

if s~=z then
s=z
g:scrollTo(math.floor(0.5+z/y*(g.totalSpace-g.visibleSpace)))
end
end)
end)end


e.create=function(g)
g.upButton=ac.new("ImageButton",g.upButtonName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

g.downButton=ac.new("ImageButton",g.downButtoName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

g:createButtonsArrows()

local h=ac.new("Frame","ScrollBar",{
Active=true,
BackgroundTransparency=1,

g.upButton,
g.downButton,

ac.new("Frame","ScrollThumbFrame",{
BackgroundTransparency=1,
AnchorPoint=g.isHorizontal
and Vector2.new(0.5,0)
or Vector2.new(0,0.5),
Position=g.isHorizontal
and UDim2.fromScale(0.5,0)
or UDim2.fromScale(0,0.5),

ac.new("Frame","ScrollThumb",{
AnchorPoint=g.isHorizontal
and Vector2.new(0,0.5)
or Vector2.new(0.5,0),
ThemeTag={
BackgroundColor3="Colors.OnPrimary"
},

ac.new("UICorner",{
CornerRadius=UDim.new(0,4),
}),
}),

ac.new("Frame","MarkerFrame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
}),
}),
})

g.scrollBar=h
g.scrollThumbFrame=h.ScrollThumbFrame
g.scrollThumb=h.ScrollThumbFrame.ScrollThumb
g.markerFrame=h.ScrollThumbFrame.MarkerFrame

g.container=ac.new("Frame","Container",{
BackgroundTransparency=1,
ClipsDescendants=true,
Active=true
})

g:setScrollBarThickness(g.barThickness)
g:awake()
g:update()


return h end


e.createButtonsArrows=function(g)
local h=g.downButton
local i=g.upButton

af(4,0.55,h.Name).Parent=h
af(4,0.55,i.Name).Parent=i end


e.canScrollUp=function(g)
return g:isScrollBarEnabled()and g.index>0 end


e.canScrollDown=function(g)
local h=g:isScrollBarEnabled()
return h and g.index+g.visibleSpace<g.totalSpace end


e.canScroll=function(g, h)
if h=="up"or h=="left"then
return g:canScrollUp()
elseif h=="down"or h=="right"then
return g:canScrollDown()
end
return false end


e.getScrollPercent=function(g)
local h=g.totalSpace-g.visibleSpace
if h<=0 then return 0 end
return g.index/h end


e.scrollTo=function(g, h, i)
local j=math.max(0,g.totalSpace-g.visibleSpace)

g.index=math.clamp(h,0,j)
g:update()

if not i then
g.scrolledSignal:Fire(g.index)
end end


e.scrollUp=function(g)
g:scrollTo(g.index-g.increment)end


e.scrollDown=function(g)
g:scrollTo(g.index+g.increment)end


e.scrollToDirection=function(g, h)
if h=="up"or h=="left"then
return g:scrollUp()
elseif h=="down"or h=="right"then
return g:scrollDown()
end end


e.isVisible=function(g, h)
local i=g.index
if h>=i and h<(i+g.visibleSpace)then
return true
end
return false end


e.setScrollPercent=function(g, h)
local i=g.totalSpace-g.visibleSpace
g:scrollTo(math.floor(h*i))end


e.update=function(g)
g:drawThumb()end


e.setScrollBarThickness=function(g, h)
local i=g.scrollThumbFrame
local j=g.downButton
local k=g.container
local l=g.scrollBar
local m=g.upButton

g.barThickness=h

if k then
k.Size=UDim2.new(
1,
g.isHorizontal and 0 or-h,
1,
g.isHorizontal and-h or 0
)
end

if l then
l.Size=g.isHorizontal
and UDim2.new(1,0,0,h)
or UDim2.new(0,h,1,0)
l.Position=g.isHorizontal
and UDim2.new(0,0,1,-h)
or UDim2.new(1,-h,0,0)
end

if i then
i.Size=g.isHorizontal
and UDim2.new(1,-(h*2),0,h)
or UDim2.new(0,h,1,-(h*2))
end

if j then
j.Size=UDim2.fromOffset(h,h)
j.Position=g.isHorizontal
and UDim2.new(1,-h,0,0)
or UDim2.new(0,0,1,-h)
end

if m then
m.Size=UDim2.fromOffset(h,h)
m.Position=UDim2.fromOffset(0,0)
end end


e.updateArrowTransparency=function(g, h, i)
if not h:FindFirstChild"Arrow"then return end

for j,k in h.Arrow:GetChildren()do
if not k:IsA"GuiObject"then continue end
k.Transparency=i and 0.6 or 0
end end


e.drawThumb=function(g)
local h=g.scrollThumb
local i=g.scrollThumbFrame

local j=g:canScrollUp()
local k=g:canScrollDown()

g:updateArrowTransparency(g.upButton,not j)
g:updateArrowTransparency(g.downButton,not k)

if not h or not i then return end

if not j and not k then
h.Visible=false
return
end

h.Visible=true

local l=g:getScrollPercent()
local m=ag:getScale()
local n=g.barThickness

if g.isHorizontal then
local o=i.AbsoluteSize.X/m
local p=math.max(n,(g.visibleSpace/g.totalSpace)*o)
h.Size=UDim2.new(0,p,1,-2)
h.Position=UDim2.new(0,l*(o-p),0.5,0)
else
local o=i.AbsoluteSize.Y/m
local p=math.max(n,(g.visibleSpace/g.totalSpace)*o)
h.Size=UDim2.new(1,-2,0,p)
h.Position=UDim2.new(0.5,0,0,l*(o-p))
end end


e.addMarker=function(g, h, i)
g.markers[h]=i or Color3.new(1,1,0)
g:updateMarkers()end


e.removeMarker=function(g, h)
g.markers[h]=nil
g:updateMarkers()end


e.updateMarkers=function(g)
local h=g.markerFrame
if not h then return end

for i,j in pairs(h:GetChildren())do
j:Destroy()
end

for i,j in pairs(g.markers)do
if i>=g.totalSpace then continue end

local k=Instance.new"Frame"
k.BackgroundColor3=j
k.BorderSizePixel=0
k.BackgroundTransparency=0
k.Parent=h

local l=i/g.totalSpace
if g.isHorizontal then
k.Position=UDim2.new(l,0,1,-4)
k.Size=UDim2.new(0,2,0,4)
else
k.Position=UDim2.new(1,-4,l,0)
k.Size=UDim2.new(0,4,0,2)
end

k.Name="Marker_"..tostring(i)
end end


e.setTotalSpace=function(g, h)
g.totalSpace=h
g:scrollTo(g.index,true)
g:update()end


e.setVisibleSpace=function(g, h)
g.visibleSpace=h
g:scrollTo(g.index,true)
g:update()end


e.disableScroll=function(g)
g.scrollBarEnabled=false
g:drawThumb()end


e.enableScroll=function(g)
g.scrollBarEnabled=true
g:drawThumb()end


e.isScrollBarEnabled=function(g)
return g.scrollBarEnabled end


e.isScrollBarDisabled=function(g)
return not g.scrollBarEnabled end


e.new=function(g)
local h=setmetatable({
isHorizontal=g.isHorizontal or false,
increment=g.increment or 1,
wheelIncrement=g.wheelIncrement or 3,
barThickness=g.barThickness or 16,

scrollBarEnabled=true,

index=0,
visibleSpace=g.visibleSpace or 0,
totalSpace=g.totalSpace or 0,

markers={},

scrollBar=g.scrollBar or nil,
scrollThumb=g.scrollThumb or nil,
scrollThumbFrame=g.scrollThumbFrame or nil,
markerFrame=g.markerFrame or nil,

scrolledSignal=b.new(),
},e)

h.upButtonName=h.isHorizontal and"left"or"up"
h.downButtoName=h.isHorizontal and"right"or"down"

return h end


return e end a.cY=function()local ab=a.cache.cY if not ab then ab={c=aa()}a.cache.cY=ab end return ab.c end end do local aa=function()
local aa={}
aa.__index=aa

aa.new=function(ab)
return setmetatable({
isClient=ab.client or ab.isClient or ab.onlyClient,
isDeprecated=ab.deprecated or ab.isDeprecated,

name=ab.name,
isSection=ab.isSection,
sectionName=ab.sectionName,
aliases=ab.aliases,
args=ab.args,
name=ab.name,
description=ab.description
},aa)end


return aa end a.cZ=function()local ab=a.cache.cZ if not ab then ab={c=aa()}a.cache.cZ=ab end return ab.c end end do local aa=function()
local aa=a.h()
local ab=a.ah()
local ac=a.cr()
local ad=a.bu()
local ae=a.bx()
local af=a.bv()
local ag=a.cG()

















local b={}local c=function(

c, d, e)
return{
success=false,
message=c,
options=d,
comment=e,
}end



b.normalizeOptions=function(d)
if type(d)=="string"then
return string.split(d,"|")
end
return d or{}end



b.getOptions=function(d, e)
local f=(e and e.options)or d.options
return b.normalizeOptions(f)end local d=function(



d, e)
local f=e:lower()

for g,h in d do
local i=tostring(h)
if i:lower()==f then
return i
end
end

return nil end local e=function(


e)
if type(e)~="table"then return{}end
return ag.unlookupify(e)end local f=function(


f)
return{
success=true,
value=f,
color="string",
}end local g=function(


g, h)
local i=b.normalizeOptions(h.options)

if#i==0 then
return f(g)
end

local j=d(i,g)

if j then
return{success=true,value=j,color="string"}
end

return c(" - invalid option",i)end


local h={
["true"]=true,yes=
true,enabled=
true,
["false"]=false,no=
false,disabled=
false,
}local i=function(

i)
local j=h[i:lower()]

if j==nil then
return c(" - invalid boolean",{"false","true"})
end

return{
success=true,
value=j,
color="boolean",
}end local j=function(


j, k)
local l=tonumber(j)

if l==nil or l~=l or math.abs(l)==math.huge then
return c" - invalid number"
end

local m,n=k.min,k.max

if k.clamp then
m,n=k.clamp[1],k.clamp[2]
end

if m and l<m then
return c(` - the <b>MIN</b> is <b>{m}</b>`)
end

if n and l>n then
return c(` - the <b>MAX</b> is <b>{n}</b>`)
end

if k.floor and math.floor(l)~=l then
return c" - whole numbers only"
end


if tonumber(string.format("%.5f",l))~=l then
return c" - too many decimal places"
end

return{
success=true,
value=l,
display=`<b>{j}</b>`,
color="number",
}end local k=function(


k)
local l=k:split","

if#l>3 then
return c" - too many args"
end

local m={}

for n,o in l do

if o:match"^%s*$"then
o="0"
end

local p=j(o,{})

if not p.success then
return p
end

m[n]=p.value
end

if#m~=3 then
return{
success=false,
comment=true,
message=`: {({"X","Y","Z"})[#m+1]}`,
}
end

local n=Vector3.new(m[1],m[2],m[3])

return{
success=true,
value=n,
display=`({n})`,
color="others",
}end local l=function(


l)
local m=l:match"^#?(%x%x%x%x%x%x)$"

if m then
local n=tonumber(m:sub(1,2),16)
local o=tonumber(m:sub(3,4),16)
local p=tonumber(m:sub(5,6),16)

return{
success=true,
value=Color3.fromRGB(n,o,p),
color="others",
}
end

local n=l:split","

if#n~=3 then
return c" - use R,G,B or #hex"
end

local o={}

for p,q in n do
local r=j(q,{min=0,max=255,floor=true})

if not r.success then
return r
end

o[p]=r.value
end

return{
success=true,
value=Color3.fromRGB(o[1],o[2],o[3]),
color="others",
}end local m=function(


m)
if m==""then
return c" - player missing"
end

local n=ab.parts(m)

if#n==0 then
return c" - player missing"
end


for o,p in n do
if#ab(p)==0 then
if ab.hasOperators(p)then
return c" - no players match this"
end

if ab.isSelector(p)then
return c" - no players match this selector"
end

local q={}
for r,s in aa.Players:GetPlayers()do
table.insert(q,s.Name)
end

return c(" - player not found",q)
end
end

return{success=true,value=m,color="valid"}end


local n={
"BasePart","Part","MeshPart","Model","Folder","Script","LocalScript",
"ModuleScript","Sound","Humanoid","Tool","ClickDetector",
"ProximityPrompt","TouchTransmitter","SpawnLocation","Seat","VehicleSeat",
}local o=function(

o)

local p=pcall(function()
local p=Instance.new(o)
p:Destroy()
end)

if p then
return{success=true,value=o,color="valid"}
end

return c(" - invalid class name",n)end local p=function(


p)

local q=e(ad:getValue(tostring(game.PlaceId)))

if#q==0 then
return c" - no waypoints created"
end

local r=d(q,p)

if r then
return{success=true,value=r,color="valid"}
end

return c(" - invalid waypoint",q)end local q=function(


q)
local r={}

for s,t in aa.Teams:GetTeams()do
table.insert(r,t.Name)
end

if#r==0 then
return c" - there are no teams"
end

local s=d(r,q)

if s then
return{success=true,value=s,color="valid"}
end

return c(" - invalid team",r)end local r=function(


r)
local s=r:lower()
local t={}
local u

for v,w in Enum.KeyCode:GetEnumItems()do
table.insert(t,w.Name)

if w.Name:lower()==s then
u=w
end
end

if u then
return{success=true,value=u,color="valid"}
end

return c(" - invalid key",t)end local s=function(


s)
local t=ac.lookup[s:lower()]

if t then
return{success=true,value=t.name,color="valid"}
end

return c(" - invalid command",ac.array)end local t=function(



t, u, v, w)
local x=e(t:getData())

if#x==0 then
return c(v)
end

local y=d(x,u)

if y then
return{success=true,value=y,color="valid"}
end

return c(w,x)end local u=function(


u)
return t(ae,u," - no custom aliases"," - invalid alias")end local v=function(


v)
return t(af,v," - no plugins installed"," - invalid plugin")end


local w={
string=g,
text=g,
object=f,
boolean=i,
number=j,
vector3=k,
color3=l,
player=m,
waypoint=p,
className=o,
team=q,
keycode=r,
command=s,
alias=u,
plugin=v,
}

b.validate=function(x, y, z)
local A=w[y.kind]

if not A then
return c(` - missing parser {y.kind}`)
end

return A(z,y)end


return b end a.c_=function()local ab=a.cache.c_ if not ab then ab={c=aa()}a.cache.c_=ab end return ab.c end end do local aa=function()

local aa=a.cQ()
local ab=a.ct()

local ac=a.cr()
local ad=a.cM()

local ae=a.cG()
local af=a.c_()

local ag=ae.colorFromRGB
local b=ae.escapeRichText


local c="\\"

local d="^"
local e="inf"

local f="!"

local g=ae.lookupify{"`","'","\""}
local h=ae.lookupify{" ","\t","\n","\r"}
local i=ae.lookupify{",","|","&"}local j=function(

j)
return ac.lookup[j]end local k=function(


k, l, m)
local n=ad.args
return ag(k,n[l]or m or n.others)end local l=function(


l)
local m=l:gsub(".",function(m)
return h[m]and"_"or m
end)
return m end local m=function(


m, n)
if m.name then
return`'{l(m.name)}'`
end
return`#{n}`end local n=function(



n, o, p)
local q=p+1

while true do
local r=n:find(o,q,true)

if not r then
return nil
end

if n:sub(r-1,r-1)~="\\"then
return r
end

q=r+1
end end local o=function(




o, p)
local q={}
local r=p
local s=#o

while r<=s do
local t=o:sub(r,r)

if h[t]or t==c then
break
end

table.insert(q,t)
r=r+1

if i[t]then
while r<=s and h[o:sub(r,r)]do
r=r+1
end
end
end

return table.concat(q),r-1 end local p=function(


p, q, r, s, t, u)
return{
kind=p,
value=q,
usedChar=u,
from=s,
to=t,
raw=r:sub(s,t),
}end local q=function(



q, r)
if r==""then
return"","",q
end

local s,t=q:lower():find(r:lower(),1,true)

if not s then
return"","",q
end

return q:sub(1,s-1),q:sub(s,t),q:sub(t+1)end local r=function(


r, s)
if s then
return s..r..s
end

if r:find"%s"then
return`"{r}"`
end

return r end local s=function(



s, t)
if t then
return b(t)..s..b(t)
end

return s end local t=function(


t, u, v, w)
return{
from=t,
to=u,
text=r(v,w),
}end local u=function(




u)
local v=u:split(d)

if#v>2 then
return nil," - invalid loop"
end

local w
if v[1]:lower()==e then
w=math.huge
else
w=tonumber(v[1])

if w==nil or w<1 or w~=math.floor(w)then
return nil," - invalid loop count"
end
end

local x=0
if v[2]~=nil then
x=tonumber(v[2])

if x==nil or x<0 then
return nil," - invalid loop delay"
end
end

return{count=w,delay=x}end


local v={}
v.__index=v
v.colorFromName=k
v.removeWhiteSpace=l



v.parse=function(w, x)
local y=w.cmdInput
local z={}
local A={}
local B=#x
local C={tokens={},start=1}
local D=1

table.insert(z,C)

while D<=B do
local E=x:sub(D,D)

if h[E]then
D=D+1
elseif E==c then
C.stop=D
C={tokens={},start=D+1}
table.insert(z,C)
D=D+1
else
local F
local G=g[E]and n(x,E,D)

if G then
local H=(x:sub(D+1,G-1):gsub("\\"..E,E))
F=p("string",H,x,D,G,E)
D=G+1
else
local H,I=o(x,D)
F=p("identifier",H,x,D,I)
D=I+1
end

table.insert(C.tokens,F)
table.insert(A,F)
end
end

C.stop=B+1

for E,F in z do
local G=F.tokens[1]
local H=F.tokens[#F.tokens]
local I=if H then H.to+1 else F.start

F.lead=if G then x:sub(F.start,G.from-1)else""
F.spaces=x:sub(I,F.stop-1)
end

local E={}
for F,G in A do
table.insert(E,G.value)
end

local F=z[#z]

y.rawText=x
y.parsed=A
y.spacesAtEnd=F.spaces
y.noHighlightText=table.concat(E," ")..F.spaces

return z end



v.parseArg=function(w, x, y, z, A)
local B=y.value
local C=af:validate(x,B)
local D=C.success and#B>0

local E={success=D,text=B}
if D then
E.value=C.value
end
A.args[z]=E

if D then

local F=if C.display then s(C.display,y.usedChar)else b(y.raw)
return{success=true,display=k(F,C.color or"valid")}
end

local F=af.getOptions(x,C)
local G

if#B>0 then
G=ab:searchAtArray(F,B)[1]
end

if G then
local H,I,J=q(G,B)
A.correction=t(y.from,y.to,G,y.usedChar)

local K=b(H)..k(b(I),"warn")..b(J)
return{
success=false,
suggestion=true,
display=k(s(K,y.usedChar),"comment"),
}
end

return{
success=false,
display=k(b(y.raw),C.color or"warn"),
message=C.message,
comment=C.comment,
}end



v.parsePending=function(w, x, y, z)
local A=af:validate(x,"")
local B=af.getOptions(x,A)

if#B==0 then
return nil
end

local C=B[1]


if not x.optional then
y.correction={from=z.stop,to=z.stop-1,text=r(C)}
else
y.hasGhost=true
end

return k(b(C),"comment")end



v.highlightArgs=function(w, x, y, z, A, B, C)
local D=z.tokens
local E=y.args
local F=#E
local G=#D-1

local H=1
local I

for J,K in E do
local L=D[J+1]

if L==nil then
if A then
local M=w:parsePending(K,x,z)
if M then
table.insert(B,M)
end
end
break
end

local M=w:parseArg(K,L,J,x)
H=J+1

if M.display then
table.insert(B,M.display)
end

if not M.success then
I={index=J,result=M}
break
end
end


for J=H+1,math.min(#D,F+1)do
table.insert(B,b(D[J].raw))
end

if#D>F+1 then
local J=w.cmdInput.rawText:sub(D[F+2].from,D[#D].to)
table.insert(B,k(`<b>{b(J)}</b>`,"warn"))

x.runError=" - extra arg"
x.comment={text=" - extra arg",color="warn"}
return
end

if I then
local J=I.result


x.runError=` - {m(E[I.index],I.index)} is invalid`

if J.message and not J.suggestion then
x.comment={text=J.message,color=if J.comment then"comment"else"warn"}
end
return
end


for J=G+1,F do
local K=E[J]

if not K.optional then
x.runError=` - {m(K,J)} is missing`
break
end
end

local J

if A then
J=G+1
elseif G>0 then
J=G
end

local K=J and E[J]


if K and C then
local L=if A then""else": "
x.comment={text=`{L}({w:highlightArgType(K)})`}
end end


v.highlightArgType=function(w, x)
local y=x.optional and k("?","symbol")or""
local z=`{k(x.kind,x.kind)}{y}`

if x.name then
return`{l(x.name)}: {z}`
end

return z end


v.highlightArgsType=function(w, x)
if#x==0 then return""end

local y={}

for z,A in x do
table.insert(y,w:highlightArgType(A))
end

return`({table.concat(y,", ")})`end


v.resetInput=function(w)
local x=w.cmdInput

x.highlightText=""
x.commandName=""
x.commandData=nil
x.isValidCommand=false
x.isAbreviated=false
x.bestMatch=nil
x.bestMatches={}
x.correctionText=nil
x.correction=nil
x.runError=nil
x.hasGhost=false
x.args={}
x.statements={}

w:setComment""end



v.highlightStatement=function(w, x, y)
local z=w.cmdInput
local A=x.tokens
local B={
lead=x.lead,
text="",
trailing=x.spaces,
args={},
commandName="",
bestMatches={},
isValidCommand=false,
isAbreviated=false,
}

if#A==0 then
B.empty=true
return B
end

local C=A[1]
local D=#x.spaces>0
local E=C.value
local F=E
local G
local H
local I=false


if C.kind=="identifier"then
local J,K=E:match"^(.*%^)(.*)$"

if J then
G,H=u(J:sub(1,-2))
F=K
end

if F:sub(1,1)==f then
I=true
F=F:sub(2)
end
end

local J=E:sub(1,#E-#F)
local K=F:lower()
local L=j(K)

B.commandName=K
B.commandData=L
B.isValidCommand=L~=nil
B.isAbreviated=L~=nil and L.name~=K
B.loop=G

if H then
B.text=k(b(E),"error")
B.runError=H
B.comment={text=H,color="error"}
return B
end

local M=""
if J~=""then
M=k(b(J),"comment")
end

if not L then
local N=aa:search(K)
local O=N[1]

B.bestMatches=N
B.bestMatch=O

if D or#A>1 or not O then
local P=z.rawText:sub(C.from,A[#A].to)

B.text=k(b(P),"error")
B.runError=" - invalid command"
B.comment={text=" - invalid command",color="error"}
return B
end


local P,Q,R=q(O,F)

B.text=M..k(b(P)..k(b(Q),"warn")..b(R),"comment")
B.correction=t(C.from,C.to,J..O,C.usedChar)
B.correctionText=O
B.runError=" - invalid command"
return B
end

local N={M..k(b(F),"valid")}


if y and#A==1 and not D and#L.aliases>1 then
local O=table.clone(L.aliases)
local P=table.find(O,K)

if P then
table.remove(O,P)
end

B.comment={text=`: [{table.concat(O,", ")}]`,color="comment"}
end

if I and#A==1 then

B.repeatLast=true

if#L.args>0 and aa:getLastArgs(L.name)==nil then
B.runError=" - no previous arguments"
B.comment={text=" - no previous arguments",color="error"}
end
else
w:highlightArgs(B,L,x,D,N,y)
end

B.text=table.concat(N," ")
return B end




v.highlight=function(w, x)
local y=w.cmdInput
w:resetInput()

local z=#x
local A={}

for B,C in x do
A[B]=w:highlightStatement(C,B==z)
end

local B=A[z]

y.statements=A
y.commandName=B.commandName
y.commandData=B.commandData
y.isValidCommand=B.isValidCommand
y.isAbreviated=B.isAbreviated
y.bestMatch=B.bestMatch
y.bestMatches=B.bestMatches
y.args=B.args


local C

for D,E in A do

if E.empty and z>1 then
E.runError=" - command missing"
end

if E.runError and y.runError==nil then
y.runError=E.runError
end

if E.correction and y.correction==nil then
y.correction=E.correction
end

if E.hasGhost then
y.hasGhost=true
end

if E.comment and C==nil then
C=E.comment
end
end

if C then
w:setComment(C.text,C.color)
end

local D={}

for E,F in A do

local G=if F.correction or F.hasGhost then""else F.trailing
local H=F.lead..F.text..G

if E<z then
H=H..k(b(c),"symbol")
end

table.insert(D,H)
end

local E=table.concat(D)
y.highlightText=E

return E end


v.setComment=function(w, ...)
return w.setCommentCallback(...)end


v.new=function(w, x)
return setmetatable({
cmdInput=w,
setCommentCallback=x
},v)end


return v end a.c0=function()local ab=a.cache.c0 if not ab then ab={c=aa()}a.cache.c0=ab end return ab.c end end do local aa=function()

local aa=a.bl()
local ab=a.h()
local ac=a.ag()
local ad=a.cI()
local ae=a.cZ()

local af=a.cQ()
local ag=a.c0()
local b=a.W()
local c=a.cP()

local d=a.cX()
local e=a.cr()

local f=a.cs()
local g=a.d()
local h=a.cG()
local i=a.cT()

local j=a.l()
local k=a.av()
local l=a.cM().commands

local m=ab.UserInputService
local n=ab.RunService

local o=h.richFontSize
local p=h.colorFromRGB

local q={}
q.__index=q local r=function(

r)
return d.pressingInputs[r.UserInputType]~=nil end local s=function(


s)
return e.lookup[s]end local t=function(


t)
return math[(t<0)and"ceil"or"floor"](t)end local u=function(


u)
u=u:gsub("[\r\n]+$","")
u=u:gsub("[\r\n]+"," ")
return u end


q.refresh=function(v, w)
local x=v.parser:parse(w)
v.parser:highlight(x)

v:updateSearchBoxHighlight()
v:updateSearchedCommand()end


q.applyCorrection=function(v)
local w=v.commandInput
local x=w.correction
local y=w.rawText

local z=y:sub(1,x.from-1)..x.text..y:sub(x.to+1)

if j:getValue"spaceAfterCorrection"then
z=z.." "
end

v.searchBox.Text=z end


q.awake=function(v)
local w=v.commandInput
local x=v.searchBox
local y=v.searchBoxHolder
local z=v.inputMarker

local A=y.Placeholder

local B=x:GetPropertyChangedSignal"Text"

local C=0 local D=function()


if(tick()-C)>0.5 then
z.Visible=not z.Visible
C=tick()
end end local E=function()



if x:IsFocused()then
x:ReleaseFocus()
end end local F=function()



x:CaptureFocus()end local G=function()



if w.correction then
v:applyCorrection()
task.defer(F)
return true
end


v:sendInputCommand()
return false end local H=function()



local H=not x:IsFocused()and#x.Text==0
A.Visible=H end


v.commandClickedSignal:Connect(function(I)
x.Text=I.aliases[1]
task.defer(F)
end)

aa:Connect(y.Activated,F)

aa:Connect(x.Focused,function()
H()
v.markerConnection=aa:Connect(n.Stepped,D)

if#x.Text==0 then
v:setComment""
end
end)

aa:Connect(x.FocusLost,function(I)
H()
z.Visible=true
aa:disconnect(v.markerConnection)

if I then
v:refresh(u(x.Text))
G()
end
end)

aa:Connect(B,function()
local I=x.Text


if I:find"\t"then
x.Text=(I:gsub("\t",""))
return
end


if v.historyIndex and I~=v.historyText then
v.historyIndex=nil
end

local J=I:sub(-1)=="\n"or I:sub(-1)=="\r"

if I:find"[\r\n]"then
I=u(I)
x.Text=I

if J then
v:refresh(I)

if not G()then
E()
end
return
end
end

H()
v:refresh(I)
end)


aa:Connect(m.InputBegan,function(I)
if not x:IsFocused()then return end

if I.KeyCode==Enum.KeyCode.Up then
v:browseHistory(-1)
elseif I.KeyCode==Enum.KeyCode.Down then
v:browseHistory(1)
elseif I.KeyCode==Enum.KeyCode.Tab and v.commandInput.correction then
v:applyCorrection()
task.defer(F)
end
end)end


local v=50


q.sendInputCommand=function(w)
local x=w.commandInput

if x.runError then
w:setComment(x.runError,"error")
return
end

local y=x.statements

for z,A in y do
if not A.commandData then return end
end

local z=x.rawText
local A,B

for C,D in y do
local E,F=pcall(function()
w:runStatement(D)
end)

if not E then
A=F
B=D.commandData.name
break
end
end

if j:getValue"clearOnEnter"then
w.searchBox.Text=""
end

w.historyIndex=nil

if A then
w:setComment(`failed - {A}`,"error")
g:error(`failed to run command '{B}': {A}`)
else
w:addToHistory(z)
end end



q.runStatement=function(w, x)
local y=x.commandData.name
local z=x.args

if x.repeatLast then
z=af:getLastArgs(y)or{}
end

if x.loop then
w:startLoop(y,z,x.loop)
return
end

af:run(y,b.new(z))end



q.startLoop=function(w, x, y, z)
local A=0
local B

B=c:add(function()
A=A+1

local C,D=pcall(function()
af:run(x,b.new(y))
end)

if not C then
c:remove(B)
g:error(`loop of '{x}' stopped: {D}`)
return
end

if A>=z.count then
c:remove(B)
end
end,z.delay)end


q.addToHistory=function(w, x)
local y=(x or""):match"^(.-)%s*$"

if y==""then return end

local z=w.history

if z[#z]==y then return end

table.insert(z,y)

if#z>v then
table.remove(z,1)
end end



q.browseHistory=function(w, x)
local y=w.history

if#y==0 then return end

local z

if w.historyIndex==nil then
if x>0 then return end
z=#y
else
z=w.historyIndex+x
end

if z<1 then
z=1
end

if z>#y then
w.historyIndex=nil
w:setSearchText""
return
end

w.historyIndex=z
w:setSearchText(y[z])end


q.setSearchText=function(w, x)
w.historyText=x
w.searchBox.Text=x end


q.create=function(w)
w.searchBoxHolder=ad.new("ImageButton",{
Size=UDim2.new(1,-10,0,18),
Position=UDim2.fromScale(0.5,0),
AnchorPoint=Vector2.new(0.5,1),
BorderSizePixel=0,
ClipsDescendants=true,
ThemeTag={BackgroundColor3="Colors.Buttons.Default"},

ad.new("UICorner",{CornerRadius=UDim.new(0,6)}),

ad.new("TextLabel","Input",{
Size=UDim2.fromScale(0,1),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
TextSize=w.configs.textSize,
Visible=false,
RichText=true,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
ad.new("Frame","Holder",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromScale(1,0)
}),
}),

ad.new("TextLabel","Placeholder",{
Size=UDim2.new(1,-5,1,0),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=w.configs.textSize-1,
Text=w.configs.placeholderText,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
}),
})

local x=w.searchBoxHolder
local y=x.Input.Holder

w.inputMarker=ad.new("Frame","Marker",y,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

w.inputComment=ad.new("TextLabel","Comment",y,{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromScale(1,0.5),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=w.configs.textSize,
RichText=true,
Text="",
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
}
})

w.commandInfo=ad.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=w.configs.textFont,
TextSize=w.configs.textSize-5,
Visible=false,
ad.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

w.searchBox=ad.new("TextBox","SearchBox",{
BackgroundTransparency=1,
TextTransparency=1,
Size=UDim2.fromScale(1,0),
Position=UDim2.fromScale(0,0.4),
ClearTextOnFocus=false,
ShowNativeInput=false,
TextSize=0,
Text="",
MultiLine=true
})

w.commandsFolder=ad.new("Folder","Commands")end


q.createCommandsData=function(w)
for x,y in e.original do
local z=ae.new(y)
y.commandData=z
z.position=x-1
table.insert(w.commandsData,z)
end end


q.updateSearchBoxHighlight=function(w)
local x=w.commandInput.highlightText
local y=w.searchBoxHolder
local z=y.Input
local A=i:getScale()

z.Text=x
z.Visible=#x>0

local B=y.AbsoluteSize.X*A
local C=B/2
local D=z.AbsoluteSize.X*A

if D<=C then
z.AnchorPoint=Vector2.new(0,0.5)
z.Position=UDim2.new(0,5,0.5,0)
else
z.AnchorPoint=Vector2.new(1,0.5)
z.Position=UDim2.new(0.5,0,0.5,0)
end end


q.updateSearchedCommand=function(w)
local x=w.commandInput.bestMatch
local y=w.commandInput.commandName
if y==""then return end

local z=s(y)
or(x and s(x))

if z then
w.scrollBar:scrollTo(z.commandData.position)
end end


q.setComment=function(w, x, y)
if y~=nil then
x=ag.colorFromName(x,y)
end

w.inputComment.Text=x
w.inputComment.Visible=#x>0 end


q.updateElementColor=function(w, x, y)
local z=if y%2==1 then 1 else 0.96
x.BackgroundTransparency=z end


q.updateElements=function(w)
local x=0
local y=0
local z={}
local A=w.scrollBar
local B=w.commandsFolder

for C,D in w.commandsData do
local E=A:isVisible(D.position)

if not E then
if D.element then D.element.Parent=nil end
continue
end

local F=D.element
if not F then
F=w:createCommandElement(D)
D.element=F
end

if not D.isSection then
if#D.args>0 and#D.name>y then
y=#D.name
end
table.insert(z,D)
end

w:updateElementColor(F,C)
F.Parent=B
F.Position=UDim2.fromOffset(
0,
x*(F.Size.Y.Offset+w.configs.padding)
)
x=x+1
end

for C,D in z do
w:updateDisplayName(D,y+3)
end

w.visibleCommands=z end


q.setCommandInfo=function(w, x)
x=x or""

if x==""then
w.commandInfo.Visible=false
return
end

w.commandInfo.Visible=true
w.commandInfo.Text=x end


q.createSection=function(w, x)


local y=ad.new("TextLabel","Command",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
RichText=true,
TextSize=w.configs.textSize-3,
Text=`<b>#{x.sectionName}</b>`,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.MonoSpace"
},
})

return ad.new("Frame",{
Size=UDim2.new(1,-10,0,w.configs.labelSize),
BackgroundTransparency=1,

y
})end


q.createCommandElement=function(w, x)
if x.isSection then
return w:createSection(x)
end

local y=ad.new("TextLabel","Command",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.X,
RichText=true,
TextSize=w.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
})

return ad.new("Frame",{
Size=UDim2.new(1,0,0,w.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
y
})end


q.createCommandDescription=function(w, x)
if x.isSection then return end
if not x.description then return end

local y=ad.new("TextLabel","Description",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(25,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
TextSize=w.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
})

return ad.new("Frame","Description",{
Size=UDim2.new(1,-30,0,w.configs.labelSize),
BackgroundTransparency=1,
y
})end


q.getCommandColor=function(w, x, y)
local z=s(x)

local A=
if type(z.run)~="function"then"undefined"
elseif k:getValue(z.name)==true then"deprecated"
elseif y.isClient then"client"
elseif y.isDeprecated then"deprecated"
else nil

if A~=nil then
x=p(x,l[A])
end

return x end


q.updateDisplayName=function(w, x, y)
local z=x.element
local A=x.name

local B=string.rep("—",(y-#A)-2)

A=w:getCommandColor(A,x)
local C=`{A} {ag.colorFromName(B,"comment")} `

local D=w.parser:highlightArgsType(x.args)
local E=C..D

if x.isHolding then
x.originalText=E
else
w:setCommandText(x,E)
end end


q.setCommandText=function(w, x, y)
local z=x.element
if not z then return end

z.Command.Text=y end


q.getCommandText=function(w, x)
local y=x.element
return y and y.Command.Text or""end


q.calculateTotalSpace=function(w)
return#w.commandsData end


q.calculateVisibleSpace=function(w)
local x=w.scrollContainer.AbsoluteSize.Y
return math.floor(x/w:calculateLabelSize())end


q.calculateLabelSize=function(w)
return w.configs.padding+w.configs.labelSize end


q.getElementMouseIn=function(w)
for x,y in w.visibleCommands do
if ac:isMouseInGuiObject(y.element)then
return y
end
end end


q.horizontalScroll=function(w, x)
for y,z in w.visibleCommands do
local A=z.element

A.Position=UDim2.fromOffset(
math.min(A.Position.X.Offset+x,0),
A.Position.Y.Offset
)
end end


q.startedHoldingContainer=function(w, x)
if not r(x)then return end
if w.scrollBar:isScrollBarDisabled()then return end

w.scrollAxis=nil
w.scrollBar:disableScroll()

local y=ac:getMouse()
local z=w:calculateLabelSize()
local A=w:getElementMouseIn()
local B=tick()

if A and A.description then
A.isHolding=true

local C=w.parser.colorFromName(A.description,"comment")

A.originalText=w:getCommandText(A)
w:setCommandText(A,C)
end

local C=y.Y
local D=y.X

local E,F local G=function()


w.scrollBar:enableScroll()

if A then
A.isHolding=nil

if A.originalText then
w:setCommandText(A,A.originalText)
A.originalText=nil
end

if(tick()-B)<=0.15 then
w.commandClickedSignal:Fire(A)
end
end

if F then F:Disconnect()end
if E then E:Disconnect()end end


F=aa:Connect(m.InputEnded,function(H)
if not r(H)then return end
G()
end)

E=aa:Connect(m.InputChanged,function(H)
if not r(H)then return end

local I=y.X-D
local J=y.Y-C

if not w.scrollAxis then
if math.abs(I)>4 or math.abs(J)>4 then
w.scrollAxis=math.abs(I)>math.abs(J)and"x"or"y"
end
return
end

if w.scrollAxis=="x"then
local K=t(I/3)
if math.floor(K)~=0 then
w:horizontalScroll(K)
D=y.X
end
else
local K=t(J/z)
if math.floor(K)~=0 then
w.scrollBar:scrollTo(w.scrollBar.index-K)
C=y.Y
end
end
end)end


q.update=function(w)
w.scrollBar:setVisibleSpace(w:calculateVisibleSpace())
w.scrollBar:setTotalSpace(w:calculateTotalSpace())
w:updateElements()end


q.enable=function(w)
if w.isEnabled then return end
local x=w.scrollContainer
w.isEnabled=true

w.commandsFolder.Parent=x
w.searchBox.Parent=w.scrollHolder
w.searchBoxHolder.Parent=w.scrollHolder
w.commandInfo.Parent=w.scrollHolder

w.scrollConnection=w.scrolledSignal:Connect(function()
w:updateElements()
end)

w.containerConnection=x.InputBegan:Connect(function(y)
w:startedHoldingContainer(y)
end)

w:update()end


q.disable=function(w)
if not w.isEnabled then return end
w.isEnabled=false

w.commandsFolder.Parent=nil
w.searchBox.Parent=nil
w.searchBoxHolder.Parent=nil
w.commandInfo.Parent=nil

aa:disconnect(w.containerConnection)
aa:disconnect(w.markerConnection)
aa:disconnect(w.scrollConnection)end


q.new=function(w)local x=function(
x)
return assert(w.configs[x],`missing config.configs['{x}']`)end


local y=setmetatable({
scrollContainer=w.scrollContainer,
scrolledSignal=w.scrolledSignal,
scrollHolder=w.scrollHolder,
scrollBar=w.scrollBar,

configs={
placeholderText=x"placeholderText",
padding=x"padding",
labelSize=x"labelSize",
textSize=x"textSize"
},

commandClickedSignal=f.new(),

commandInput={
bestMatch=nil,
bestMatches={},
searchResult={},
isValidCommand=false,
highlightText="",
noHighlightText="",
fullCommandText="",
commandName=""
},

visibleCommands={},
commandsData={},
history={},
historyIndex=nil,
historyText=""
},q)

y.parser=ag.new(y.commandInput,function(z,A)
return y:setComment(z,A)
end)

return y end


return q end a.c1=function()local ab=a.cache.c1 if not ab then ab={c=aa()}a.cache.c1=ab end return ab.c end end do local aa=function()


local aa=a.bl()
local ab=a.h()

local ac=a.cs()

local ad=ab.UserInputService

local ae={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}

local af={
[Enum.UserInputType.MouseMovement]=true,
[Enum.UserInputType.Touch]=true
}

local ag=0.28

local b={}
b.__index=b


b._resetDrag=function(c)
for d,e in c._pressConnections do
e:Disconnect()
end
table.clear(c._pressConnections)

c.isDragging=false
c.draggingObject=nil
c.dragStart=nil
c.startPos=nil
c.lastPos=nil
c.pressTime=0
c.travel=0 end



b._endPress=function(c)
if not c.isDragging then return end

local d=c.draggingObject
local e={
duration=os.clock()-c.pressTime,
travel=c.travel,
dy=c.lastPos.Y-c.dragStart.Y,
}

c:_resetDrag()
c.dragEnded:Fire(d,e)end


b.addGuiObject=function(c, d)
return aa:Connect(d.InputBegan,function(e)
if not ae[e.UserInputType]then return end
if c.isDragging then return end

c.isDragging=true
c.draggingObject=d
c.dragStart=e.Position
c.lastPos=e.Position
c.startPos=d.Position
c.pressTime=os.clock()
c.travel=0



c._pressConnections={
e.Changed:Connect(function()
if e.UserInputState==Enum.UserInputState.End then
c:_endPress()
end
end),
ad.InputEnded:Connect(function(f)
if f.UserInputType==e.UserInputType then
c:_endPress()
end
end),
}

c.dragStarted:Fire(d)
end)end


b.update=function(c, d, e)
local f=e.Position-c.dragStart
local g=(c._uiScale and c._uiScale.Scale)or 1

c.lastPos=e.Position
c.travel=math.max(c.travel,f.Magnitude)

local h=UDim2.new(
c.startPos.X.Scale,
c.startPos.X.Offset+(f.X/g),
c.startPos.Y.Scale,
c.startPos.Y.Offset+(f.Y/g)
)

if c.filters[d]~=nil then
local i=c.filters[d](h,g)
h=i or h
end

d.Position=d.Position:Lerp(h,ag)
c.onDragged:Fire(d)end


b.canDragObject=function(c, d)
return(not c.isDragging)or(c.draggingObject==d)end


b.setFilter=function(c, 
d, 
e)

c.filters[d]=e end


b.new=function(c)
local d=setmetatable({
isDragging=false,
draggingObject=nil,
_uiScale=c,
dragStart=nil,
startPos=nil,
lastPos=nil,
pressTime=0,
travel=0,
_pressConnections={},
filters={},

onDragged=ac.new(),
dragStarted=ac.new(),
dragEnded=ac.new(),
},b)

aa:Connect(ad.InputChanged,function(e)
if d.isDragging and af[e.UserInputType]then
d:update(d.draggingObject,e)
end
end)

return d end


return b end a.c2=function()local ab=a.cache.c2 if not ab then ab={c=aa()}a.cache.c2=ab end return ab.c end end do local aa=function()







































































































































local aa=a.cT().uiScale
return a.c2().new(aa)end a.c3=function()local ab=a.cache.c3 if not ab then ab={c=aa()}a.cache.c3=ab end return ab.c end end do local aa=function()
local aa=a.cG().colorFromRGB
local ab=a.cM().commands

return{
cases={
{"all","- includes everyone"},
{"others","- includes everyone except you"},
{"me","- includes your player only"},
{"@username","- searches for players by username only (ignores displaynames)"},
{"#[number]","- gets a specified amount of random players"},
{"random","- affects a random player"},
{"%[team name]","- includes everyone on a given team"},
{"allies / team","- players who are on your team"},
{"enemies / nonteam","- players who are not on your team"},
{"friends","- anyone who is friends with you"},
{"nonfriends","- anyone who is not friends with you"},
{"guests","- guest players (obsolete)"},
{"bacons","- anyone with the \"bacon\" or pal hair"},
{"age[number]","- includes anyone below or at the given age"},
{"rad[number]","- includes anyone within the given radius"},
{"nearest","- gets the closest player to you"},
{"farthest","- gets the farthest player from you"},
{"group[ID]","- gets players who are in a certain group"},
{"alive","- gets players who are alive"},
{"dead","- gets players who are dead"},
},
sections={
{
{"title","Commands Colors"},
{"text",`{aa("COMMAND_UNDEFINED",ab.undefined)} -> This command don't work (BETA)`},
{"text",`{aa("CLIENT",ab.client)} -> Only works on client`},
{"text",`{aa("DEPRECATED",ab.deprecated)} -> This command is deprecated`}
},
{
{"title","Special Player Cases"},
{"text","These keywords can be used to quickly select groups of players in commands:"},
{"cases"},
},
{
{"title","Various Operators"},
{"bold","Use commas to separate multiple expressions:"},
{"text",";locate noob,noob2,bob"},
{"bold","Use - to exclude, and + to include players in your expression:"},
{"text",";locate %blue-friends (gets players in blue team who aren't your friends)"},
{"bold","Put ! before a command to run it with the last arguments it was ran with:"},
{"text","After running ;offset 0 100 0,  you can run !offset anytime to repeat that command with the same arguments that were used to run it last time"},
},
{
{"title","Command Looping"},
{"bold","Form: [How many times it loops]^[delay (optional)]^[command]"},
{"text","Use the 'breakloops' command to stop all running loops."},
{"bold","Examples:"},
{"text",";5^btools - gives you 5 sets of btools\n;10^3^drophats - drops your hats every 3 seconds 10 times\n;inf^0.1^animspeed 100 - infinitely loops your animation speed to 100"},
},
{
{"title","Execute Multiple Commands at Once"},
{"bold",'You can execute multiple commands at once using "\\"'},
{"bold","Examples:"},
{"text",";drophats\\respawn - drops your hats and respawns you\n;enable inventory\\enable playerlist\\refresh - enables those coregui items and refreshes you"},
},
{
{"title","Browse Command History"},
{"text","While focused on the command bar, you can use the up and down arrow keys to browse recently used commands"},
},
{
{"title","Autocomplete in the Command Bar"},
{"text","While focused on the command bar, you can use the tab key to insert the top suggested command into the command bar."},
},
{
{"title","Using Event Binds"},
{"text","Use event binds to set up commands that get executed when certain events happen. You can edit the conditions for an event command to run (such as which player triggers it)."},
{"text","Some events may send arguments; you can use them in your event command by using $ followed by the argument number ($1, $2, etc). You can find out the order and types of these arguments by looking at the settings of the event command."},
{"bold","Example:"},
{"text","Setting up 'goto $1' on the OnChatted event will teleport you to any player that chats."},
},
{
{"title","Get Further Help"},
{"text","You can join the Discord server to get support with IY,  and read up on more documentation such as the Plugin API."},
{"invite"},
},
}
}end a.c4=function()local ab=a.cache.c4 if not ab then ab={c=aa()}a.cache.c4=ab end return ab.c end end do local aa=function()


local aa=a.cI()
local ab=a.c3()
local ac=a.cY()

local ad=a.cT()
local ae=a.bl()
local af=a.a()
local ag=a.p()

local b=a.c4()

local c=500
local d=20
local e=300
local f=d+e

local g=12
local h=20
local i=40

local j=0.5
local k=2

local l=UDim2.new(0.5,-c/2,0,-500)
local m=UDim2.new(0.5,-c/2,0.5,-f/2)

local n={["&"]="&amp;",["<"]="&lt;",[">"]="&gt;"}

local o=b.cases
local p=b.sections

local q={}
q.__index=q local r=function(

r)
return(r:gsub("[&<>]",n))end local s=function(


s)
return aa.new("TextLabel","Header",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=s,
TextSize=20,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})end local t=function(


t, u)
return aa.new("TextLabel",u and"Bold"or"Text",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=t,
TextSize=14,
TextWrapped=true,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font=u and"Font.Bold"or"Font.Normal",
TextColor3="Colors.Text.Default",
},
})end local u=function()



local u=aa.new("Frame","Cases",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for v,w in o do
local x,y=w[1],w[2]

aa.new("TextLabel","Case",u,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=v,
RichText=true,
Size=UDim2.new(1,0,0,0),
Text=`<b>{r(x)}</b> {r(y)}`,
TextSize=14,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})
end

return u end local v=function(


v)
local w=aa.new("TextButton","InviteButton",{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,25),
Text=`Copy Discord Invite Link ({v})`,
TextSize=16,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local x=w.Text
local y

ae:Connect(w.Activated,function()
if af.setclipboard then
af.setclipboard(v)
w.Text="Copied"
else
w.Text="No Clipboard Function, type out the link"
end

local z=tick()
y=z

task.wait(k)
if y~=z then return end

w.Text=x
end)

return w end local w=function(


w)
local x=w[1]

if x=="title"then
return s(w[2])
elseif x=="cases"then
return u()
elseif x=="invite"then
return v(ag.links.discord)
end

return t(w[2],x=="bold")end local x=function(


x, y, z)
local A=aa.new("Frame","Section",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=x,
Size=UDim2.new(1,0,0,0),
aa.new("UIPadding",{
PaddingBottom=UDim.new(0,8),
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
PaddingTop=UDim.new(0,5),
}),
aa.new("UIListLayout",{
Padding=UDim.new(0,4),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for B,C in y do
local D=w(C)
D.LayoutOrder=B
D.Parent=A
end

if not z then
aa.new("Frame","Line",A,{
BorderSizePixel=0,
LayoutOrder=#y+1,
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Colors.Stroke",
},
})
end

return A end


q.new=function()
return setmetatable({},q)end


q.open=function(y)
y.frame:TweenPosition(m,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,j,true)end


q.close=function(y)
y.frame:TweenPosition(l,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,j,true)end


q.create=function(y)
local z=aa.new("Frame","ReferenceFrame",{
Active=true,
BorderSizePixel=0,
Position=l,
Size=UDim2.fromOffset(c,f),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local A=aa.new("Frame","TopBar",z,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,d),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",A,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text="Reference",
TextSize=16,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local B=aa.new("TextButton","Close",A,{
BackgroundTransparency=1,
Position=UDim2.new(1,-d,0,0),
Size=UDim2.fromOffset(d,d),
Text="",
})

local C=aa.new("ImageLabel","Icon",B,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(10,10),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local D=ac.new{
isHorizontal=false,
barThickness=g,
increment=h,
wheelIncrement=i,
}

local E=D:create()
local F=D.container

local G=aa.new("Frame","Content",F,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

aa.new("Frame","ScrollHolder",z,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,d),
Size=UDim2.new(1,0,0,e),

E,
F,
})

for H,I in p do
local J=x(H,I,H==#p)
J.Parent=G
end local H=function(


H)
G.Position=UDim2.fromOffset(0,-H)end local I=function()



local I=ad:getScale()

D:setTotalSpace(math.ceil(G.AbsoluteSize.Y/I))
D:setVisibleSpace(math.ceil(F.AbsoluteSize.Y/I))
H(D.index)end


ae:Connect(D.scrolledSignal,H)
ae:Connect(G:GetPropertyChangedSignal"AbsoluteSize",I)
ae:Connect(F:GetPropertyChangedSignal"AbsoluteSize",I)

ae:Connect(F.MouseWheelForward,function()
D:scrollTo(D.index-D.wheelIncrement)
end)

ae:Connect(F.MouseWheelBackward,function()
D:scrollTo(D.index+D.wheelIncrement)
end)

ae:Connect(B.Activated,function()
y:close()
end)

ab:addGuiObject(z)

ab.dragStarted:Connect(function(J)
if J~=z then return end
D:disableScroll()
end)

ab.dragEnded:Connect(function(J)
if J~=z then return end
D:enableScroll()
end)

I()

y.frame=z
y.closeIcon=C
y.scrollBar=D

return z end


return q end a.c5=function()local ab=a.cache.c5 if not ab then ab={c=aa()}a.cache.c5=ab end return ab.c end end do local aa=function()


return{
window={
title="Server",
width=250,
topBarHeight=20,
closeIconSize=15,
closeInset=2,
rowHeight=17,
rowGap=0,
textInset=5,
verticalPadding=3,
stripeTransparency=0.96,
shownY=100,
hiddenY=-500,
tweenTime=0.5,
updateInterval=1,
},

copyButton={
width=50,
height=15,
gap=6,
cornerRadius=6,
idleText="Copy",
copiedText="Copied",
feedbackTime=1.5,
},

textSizes={
title=16,
section=11,
value=14,
copyButton=12,
},

headers={
localPlayer="#player",
runTime="#run-time",
statistics="#statistics",
},

labels={
playerId="player-id:  ",
appearance="appearance: ",
players="players:     ",
maxPlayers="max-players: ",
gameId="game-id:     ",
placeId="place-id:    ",
placeName="place-name:  ",
},

time={
hour="Hour(s)",
minute="Minute(s)",
second="Second(s)",
},

messages={
loading="LOADING",
unknownPlace="Unknown",
alreadyEnabled="the info menu is already enabled",
noClipboard="this executor doesn't support clipboard",
},
}end a.c6=function()local ab=a.cache.c6 if not ab then ab={c=aa()}a.cache.c6=ab end return ab.c end end do local aa=function()


local aa=a.cI()
local ab=a.cK()
local ac=a.cH()

local ad=a.c3()
local ae=a.cO()

local af=a.cG()

local ag=a.cT()
local b=a.bl()
local c=a.a()
local d=a.af()
local e=a.h()
local f=a.b()

local g=a.c6()
local h=a.cN()

local i=UDim2.new(0.5,-g.window.width/2,0,g.window.shownY)
local j=UDim2.new(0.5,-g.window.width/2,0,g.window.hiddenY)

local k={}local l=function(

l)
return h:apply(l)end local m=function(


m, n)
return`{af.escapeRichText(m)}{l(n)}`end local n=function(


n)
if n==nil then return false end

if c.setclipboard then
c.setclipboard(tostring(n))
return true
end

ae:notify(g.messages.noClipboard)
return false end local o=function(


o)
local p=g.time
local q=math.floor(o/3600)
local r=math.floor((o%3600)/60)
local s=math.floor(o%60)

if q>0 then
return`{q} {p.hour}, {r} {p.minute}, {s} {p.second}`
elseif r>0 then
return`{r} {p.minute}, {s} {p.second}`
end

return`{s} {p.second}`end local p=function()



local p,q=pcall(function()
return e.MarketplaceService:GetProductInfo(game.PlaceId)
end)

if p and q then
return q.Name
end

return g.messages.unknownPlace end local q=function(


q, r)
local s=g.copyButton

local t=aa.new("TextButton","Copy",q,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-g.window.textInset,0.5,0),
Size=UDim2.fromOffset(s.width,s.height),
Text=s.idleText,
TextSize=g.textSizes.copyButton,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,s.cornerRadius),
}),
})

b:Connect(t.MouseEnter,function()
ac:updateObjectProperties(t,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

b:Connect(t.MouseLeave,function()
ac:updateObjectProperties(t,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

b:Connect(t.Activated,function()
if not n(r())then return end

t.Text=s.copiedText
task.wait(s.feedbackTime)
t.Text=s.idleText
end)

return t end local r=function(


r, s, t, u)
local v=g.window
local w=v.textInset
local x=0

if u.getCopyValue then
x=g.copyButton.width+g.copyButton.gap
end

local y=aa.new("Frame","Row",r,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=(s%2==1)and v.stripeTransparency or 1,
BorderSizePixel=0,
LayoutOrder=s,
Size=UDim2.new(1,0,0,v.rowHeight),
})

local z=aa.new("TextLabel",u.name,y,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(w,0),
RichText=true,
Size=UDim2.new(1,-(w*2+x),1,0),
Text=t,
TextSize=u.textSize,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=u.textColor,
},
})

if u.getCopyValue then
q(y,u.getCopyValue)
end

return z end local s=function(


s, t, u)
return r(s,t,`<b>{af.escapeRichText(u)}</b>`,{
name="Section",
textSize=g.textSizes.section,
textColor="Colors.Text.Darker",
})end local t=function(


t, u, v, w)
return r(t,u,v,{
name="Value",
textSize=g.textSizes.value,
textColor="Colors.Text.Default",
getCopyValue=w,
})end local u=function()



local u=g.window

local v={
labels={},
placeName=nil,
}

local w=aa.new("Frame","ServerInfo",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=j,
Size=UDim2.fromOffset(u.width,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local x=aa.new("Frame","TopBar",w,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,u.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",x,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=u.title,
TextSize=g.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local y=aa.new("ImageButton","Exit",x,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-u.closeInset,0.5,0),
Size=UDim2.fromOffset(u.closeIconSize,u.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(y,"close")

b:Connect(y.Activated,function()
k:close()
end)

local z=aa.new("Frame","Body",w,{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
LayoutOrder=2,
Size=UDim2.new(1,0,0,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},

aa.new("UIPadding",{
PaddingBottom=UDim.new(0,u.verticalPadding),
PaddingTop=UDim.new(0,u.verticalPadding),
}),

aa.new("UIListLayout",{
Padding=UDim.new(0,u.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local A=v.labels
local B=g.labels
local C=g.messages.loading

local D=0 local E=function()

D=D+1
return D end


s(z,E(),g.headers.localPlayer)

A.playerId=t(z,E(),m(B.playerId,d.UserId),function()
return d.UserId
end)

A.appearance=t(z,E(),m(B.appearance,d.CharacterAppearanceId),function()
return d.CharacterAppearanceId
end)

s(z,E(),g.headers.runTime)
A.time=t(z,E(),l(C))

s(z,E(),g.headers.statistics)
A.players=t(z,E(),m(B.players,C))
A.maxPlayers=t(z,E(),m(B.maxPlayers,C))

A.placeId=t(z,E(),m(B.placeId,game.PlaceId),function()
return game.PlaceId
end)

A.gameId=t(z,E(),m(B.gameId,game.GameId),function()
return game.GameId
end)

A.placeName=t(z,E(),m(B.placeName,C),function()
return v.placeName
end)

ad:addGuiObject(w)

v.frame=w
return v end local v=function(


v)
local w=v.labels
local x=g.labels
local y=e.Players

while k.window==v do
w.players.Text=m(x.players,#y:GetPlayers())
w.maxPlayers.Text=m(x.maxPlayers,y.MaxPlayers)
w.time.Text=l(o(workspace.DistributedGameTime))

task.wait(g.window.updateInterval)
end end


k.create=function(w)
if w.isEnabled then
ae:notify(g.messages.alreadyEnabled)
return
end

w.isEnabled=true

local x=u()
w.window=x

local y=g.window.tweenTime

x.frame.Parent=f.screenGui
x.frame:TweenPosition(i,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,y,true)

task.spawn(function()
x.placeName=p()
x.labels.placeName.Text=m(g.labels.placeName,x.placeName)
end)

task.spawn(v,x)

return x end


k.close=function(w)
local x=w.window
if not x then return end

local y=g.window.tweenTime

w.window=nil
w.isEnabled=false

x.frame:TweenPosition(j,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,y,true)

task.delay(y,function()
x.frame:Destroy()
end)end


return k end a.c7=function()local ab=a.cache.c7 if not ab then ab={c=aa()}a.cache.c7=ab end return ab.c end end do local aa=function()


return{
title="Chat Logs",
maxLabels=200,

window={
width=340,
height=240,
topBarHeight=20,
rowHeight=22,
closeIconSize=10,
buttonCorner=6,
buttonInset=2,
stripeTransparency=0.96,
shownX=12,
shownY=100,
hiddenX=-360,
tweenTime=0.28,
tabTweenTime=0.2,
},

scrollBar={
barThickness=12,
increment=20,
wheelIncrement=40,
},

textSizes={
title=16,
control=12,
entry=13,
},

tabs={
chat="Chat",
join="Joins",
},

controls={
enabled="Enabled",
disabled="Disabled",
save="Save",
clear="Clear",
},

messages={
saved="Saved",
saveFailed="Save failed",
},
}end a.c8=function()local ab=a.cache.c8 if not ab then ab={c=aa()}a.cache.c8=ab end return ab.c end end do local aa=function()









local aa=a.cI()
local ab=a.cK()
local ac=a.cH()
local ad=a.c3()
local ae=a.cT()
local af=a.cY()
local ag=a.cO()

local b=a.b()
local c=a.c8()
local d=a.h()
local e=a.cA()
local f=a.bC()
local g=a.cM().args
local h=a.cN()
local i=a.cG()

local j=c.window
local k=j.topBarHeight
local l=k+j.rowHeight
local m=UDim2.new(0,j.shownX,0,j.shownY)
local n=UDim2.new(0,j.hiddenX,0,j.shownY)


local o,p=0,0.125
local q,r=0.125,0.125
local s,t=0.25,0.25
local u,v=0.5,0.5
local w=0.75

local x={
window=nil,
listening=false,
}local y=function(


y, z, A)
local B=j.buttonInset
y.Position=UDim2.new(z,B,0,B)
y.Size=UDim2.new(A,-B*2,1,-B*2)end local z=function(



z, A)
ac:updateObjectProperties(z,{BackgroundColor3=A})end local A=function(


A)
if A=="chat"then
return f.chatEnabled
end
return f.joinEnabled end local B=function(



B, C)
local D=i.colorFromRGB(`[{C.time}]`,g.comment)
local E=`<b>{i.colorFromRGB(i.escapeRichText(C.name),C.color or g.others)}</b>`

if B=="chat"then
return`{D} {E}: {h:apply(C.message)}`
end
return`{D} {E} {h:apply(`joined (id {C.userId})`)}`end local C=function(


C, D)
return C.tabButtons[C.tab]==D end local D=function(


D)
for E,F in D.tweens do
F:Cancel()
end
table.clear(D.tweens)end local E=function(



E, F, G, H, I)
local J=j.buttonInset
local K=UDim2.new(G,J,0,J)
local L=UDim2.new(H,-J*2,1,-J*2)

local M=e:getScale(j.tabTweenTime)
if not I or M<=0 then
F.Position=K
F.Size=L
return
end

local N=TweenInfo.new(M,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
local O=d.TweenService:Create(F,N,{
Position=K,
Size=L,
})
table.insert(E.tweens,O)
O:Play()end local F=function(



F, G)
D(F)

local H=if F.tab=="chat"then w else 1-w
local I=v*H
local J=v-I

E(F,F.tabButtons.chat,u,I,G)
E(F,F.tabButtons.join,u+I,J,G)end local G=function(


G)
local H=A(G.tab)
G.toggle.Text=if H then c.controls.enabled else c.controls.disabled
z(G.toggle,if H then"Colors.OnPrimary"else"Colors.Buttons.Default")

for I,J in G.actions do
z(J,"Colors.Buttons.Default")
end

for I,J in G.tabButtons do
local K=I==G.tab
z(J,if K then"Colors.Primary"else"Colors.Buttons.Default")
ac:updateObjectProperties(J,{Font=if K then"Font.Bold"else"Font.Normal"})
end end local H=function(


H, I)
G(H)
F(H,I==true)end local I=function(


I)
for J,K in I.connections do
K:Disconnect()
end
table.clear(I.connections)end local J=function(


J, K, L)
table.insert(J.connections,K:Connect(L))end local K=function(


K, L)
J(K,L.MouseEnter,function()
if not C(K,L)then
z(L,"Colors.Buttons.Holding")
end
end)

J(K,L.MouseLeave,function()
G(K)
end)end local L=function(


L, M, N, O, P)
local Q=aa.new("TextButton",M,L,{
AutoButtonColor=false,
BorderSizePixel=0,
Text=N,
TextSize=c.textSizes.control,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,j.buttonCorner),
}),
})

y(Q,O,P)
return Q end local M=function(


M)
M.content.Position=UDim2.fromOffset(0,-M.scrollBar.index)end local N=function(


N)
local O=ae:getScale()
N.scrollBar:setTotalSpace(math.ceil(N.content.AbsoluteSize.Y/O))
N.scrollBar:setVisibleSpace(math.ceil(N.container.AbsoluteSize.Y/O))
M(N)end local O=function(


O)
for P,Q in O.labels do
Q:Destroy()
end
table.clear(O.labels)end local P=function(


P, Q, R)
P.order=P.order+1

local T=aa.new("TextLabel","Entry",P.content,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=if P.order%2==1 then j.stripeTransparency else 1,
BorderSizePixel=0,
LayoutOrder=P.order,
Size=UDim2.new(1,0,0,0),
RichText=true,
Text=B(Q,R),
TextSize=c.textSizes.entry,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

table.insert(P.labels,T)
while#P.labels>c.maxLabels do
table.remove(P.labels,1):Destroy()
end


task.defer(function()
if P.frame.Parent then
N(P)
P.scrollBar:scrollTo(math.huge)
end
end)end local Q=function(


Q, R)
O(Q)

for T,U in f.entries[Q.tab]do
P(Q,Q.tab,U)
end

H(Q,R)end local ah=function(


R)
local T={
tab=R,
labels={},
order=0,
connections={},
tabButtons={},
tweens={},
}

local U=aa.new("Frame","ChatLogs",{
Active=true,
BorderSizePixel=0,
Position=n,
Size=UDim2.fromOffset(j.width,j.height),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})
T.frame=U


local V=aa.new("Frame","TopBar",U,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,k),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",V,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=c.title,
TextSize=c.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local W=aa.new("TextButton","Close",V,{
BackgroundTransparency=1,
Position=UDim2.new(1,-k,0,0),
Size=UDim2.fromOffset(k,k),
Text="",
})

local X=aa.new("ImageLabel","Icon",W,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(j.closeIconSize,j.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})
ab:loadImage(X,"close")


local Y=aa.new("Frame","Controls",U,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,k),
Size=UDim2.new(1,0,0,j.rowHeight),
})

local Z=L(Y,"Clear",c.controls.clear,o,p)
local _=L(Y,"Save",c.controls.save,q,r)
T.toggle=L(Y,"Toggle",c.controls.enabled,s,t)

local ah=L(Y,"ChatTab",c.tabs.chat,u,v/2)
local ai=L(Y,"JoinTab",c.tabs.join,u+v/2,v/2)

T.tabButtons={chat=ah,join=ai}
T.actions={_,Z}


local aj=af.new{
isHorizontal=false,
barThickness=c.scrollBar.barThickness,
increment=c.scrollBar.increment,
wheelIncrement=c.scrollBar.wheelIncrement,
}
local ak=aj:create()
local al=aj.container

local am=aa.new("Frame","Content",al,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

aa.new("Frame","ScrollHolder",U,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,l),
Size=UDim2.new(1,0,1,-l),

ak,
al,
})

T.scrollBar=aj
T.container=al
T.content=am

J(T,aj.scrolledSignal,function()
M(T)
end)
J(T,am:GetPropertyChangedSignal"AbsoluteSize",function()
N(T)
end)
J(T,al:GetPropertyChangedSignal"AbsoluteSize",function()
N(T)
end)
J(T,al.MouseWheelForward,function()
aj:scrollTo(aj.index-aj.wheelIncrement)
end)
J(T,al.MouseWheelBackward,function()
aj:scrollTo(aj.index+aj.wheelIncrement)
end)
J(T,ad.dragStarted,function(an)
if an==U then
aj:disableScroll()
end
end)
J(T,ad.dragEnded,function(an)
if an==U then
aj:enableScroll()
end
end)

J(T,W.Activated,function()
x:close()
end)

J(T,ah.Activated,function()
x:select"chat"
end)

J(T,ai.Activated,function()
x:select"join"
end)

J(T,T.toggle.Activated,function()
local an=A(T.tab)
if T.tab=="chat"then
f.setChat(not an)
else
f.setJoin(not an)
end
G(T)
end)

J(T,_.Activated,function()
local an,ao=f.save(T.tab)
if an then
ag:notify(c.messages.saved,ao)
else
ag:notify(c.messages.saveFailed,ao)
end
end)

J(T,Z.Activated,function()
f.clear(T.tab)
O(T)
end)

for an,ao in{ah,ai,T.toggle,_,Z}do
K(T,ao)
end

return T end local ai=function()




if x.listening then
return
end
x.listening=true

f.onEntry(function(ai,aj)
local ak=x.window
if ak and ak.tab==ai then
P(ak,ai,aj)
end
end)end



x.open=function(aj, ak)
ai()

local al=aj.window
if al then
aj:select(ak)
return al
end

al=ah(ak)
aj.window=al

al.frame.Parent=b.screenGui
al.frame:TweenPosition(m,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,j.tweenTime,true)
ad:addGuiObject(al.frame)

Q(al)
return al end


x.select=function(aj, ak)
local al=aj.window
if not al then
return
end

al.tab=ak
Q(al,true)end


x.close=function(aj)
local ak=aj.window
if not ak then
return
end

aj.window=nil
I(ak)
D(ak)

ak.frame:TweenPosition(n,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,j.tweenTime,true)
task.delay(j.tweenTime,function()
ak.frame:Destroy()
end)end



x.reset=function(aj)
local ak=aj.window
if ak then
I(ak)
D(ak)
end
aj.window=nil end


return x end a.c9=function()local ab=a.cache.c9 if not ab then ab={c=aa()}a.cache.c9=ab end return ab.c end end do local aa=function()














local aa=a.h()
local ab=a.bl()
local ac=a.cA()

local ad=aa.TweenService
local ae=aa.UserInputService

local af=0.32
local ag=0.1
local ah=10
local ai=50

local aj={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true,
}

local ak={}
ak.__index=ak








ak.new=function(al)
local am=setmetatable({
frame=al.frame,
screenGui=al.screenGui,
topBarHeight=al.topBarHeight,
clampPosition=al.clampPosition,
getScale=al.getScale,
onMinimize=al.onMinimize,

state="minimized",
keepOpen=false,
windowParts={},
tween=nil,
press=nil,
connections={},
},ak)

am.frame.Position=am:targetFor"minimized"

table.insert(am.connections,ab:Connect(ae.InputBegan,function(an)
am:onInputBegan(an)
end))

table.insert(am.connections,ab:Connect(ae.InputEnded,function(an)
am:onInputEnded(an)
end))

return am end local al=function(


al, am)
local an=al.AbsolutePosition
local ao=al.AbsoluteSize

return am.X>=an.X and am.X<=an.X+ao.X
and am.Y>=an.Y and am.Y<=an.Y+ao.Y end



ak.isOverWindow=function(am, an)
if al(am.frame,an)then
return true
end

for ao,b in am.windowParts do
if al(b,an)then
return true
end
end

return false end



ak.addWindowPart=function(am, an)
table.insert(am.windowParts,an)end



ak.setKeepOpen=function(am, an)
am.keepOpen=an==true

if am.keepOpen and am.state=="minimized"then
am:expand()
end end



ak.reveal=function(am)
if am.state=="minimized"then
am:expand()
end end



ak.onSettled=function(am, an)
local ao=am.tween

if ao and ao.PlaybackState==Enum.PlaybackState.Playing then
ao.Completed:Once(an)
else
task.defer(an)
end end





ak.nearestSnap=function(am)
local an=am.frame
local ao=an.AbsolutePosition.Y
local b=am.screenGui.AbsoluteSize.Y-(an.AbsolutePosition.Y+an.AbsoluteSize.Y)

if ao<=b then
return"top"
end

if am.state=="expanded"then
return"expanded"
end

return"minimized"end



ak.targetFor=function(am, an)
local ao=am.clampPosition(am.frame.Position).X

if an=="top"then

return UDim2.new(ao.Scale,ao.Offset,0,0)
end

if an=="expanded"then

return UDim2.new(ao.Scale,ao.Offset,1,-am.frame.Size.Y.Offset)
end


return UDim2.new(ao.Scale,ao.Offset,1,-am.topBarHeight)end




ak.clampDrag=function(am, an)
local ao=am.clampPosition(an).X

local b=math.max(am.getScale(),0.01)
local c=am.screenGui.AbsoluteSize.Y/b
local d=math.max(c-am.topBarHeight,0)
local e=math.clamp(an.Y.Scale*c+an.Y.Offset,0,d)

return UDim2.new(ao.Scale,ao.Offset,0,e)end


ak.cancel=function(am)
if am.tween then
am.tween:Cancel()
am.tween=nil
end end


ak.moveTo=function(am, an)

if an==am.state and am.tween and am.tween.PlaybackState==Enum.PlaybackState.Playing then
return
end

am.state=an
am:cancel()

local ao=am:targetFor(an)
local b=ac:getScale(af)

if b<=0 then
am.frame.Position=ao
return
end

local c=TweenInfo.new(b,Enum.EasingStyle.Quart,Enum.EasingDirection.Out)
am.tween=ad:Create(am.frame,c,{Position=ao})
am.tween:Play()end


ak.expand=function(am)
am:moveTo"expanded"end


ak.minimize=function(am)

if am.onMinimize then
am.onMinimize()
end

am:moveTo"minimized"end



ak.reflow=function(am)
am:cancel()
am.frame.Position=am:targetFor(am.state)end



ak.onDragEnded=function(am, an)
if an.travel<=ah then

am:moveTo(am.state)
return
end

if an.dy>=ai then
am:minimize()
return
end

am:moveTo(am:nearestSnap())end


ak.onInputBegan=function(am, an)
if not aj[an.UserInputType]then return end

local ao=am:isOverWindow(an.Position)

am.press={
type=an.UserInputType,
time=os.clock(),
position=an.Position,
inside=ao,
}


if not ao and am.state=="expanded"and not am.keepOpen then
am:minimize()
end end


ak.onInputEnded=function(am, an)
local ao=am.press
if not ao or an.UserInputType~=ao.type then return end
am.press=nil

if not ao.inside then return end

local b=os.clock()-ao.time
local c=(an.Position-ao.position).Magnitude


if b<=ag and c<=ah and am.state=="minimized"then
am:expand()
end end


ak.destroy=function(am)
am:cancel()

for an,ao in am.connections do
ab:disconnect(ao)
end
table.clear(am.connections)end


return ak end a.da=function()local ab=a.cache.da if not ab then ab={c=aa()}a.cache.da=ab end return ab.c end end do local aa=function()



local aa=a.p()
local ab=a.cL()
local ac=a.b()
local ad=a.bl()
local ae=a.h()
local af=a.bQ()

local ag=a.l()
local ah=a.d()
local ai=a.cG()

local aj=a.cI()
local ak=a.cK()
local al=a.cH()

local am=a.cF()
local an=a.bR()
local ao=a.cO()

local b=a.cS()
local c=a.cT()
local d=a.cU()

local e=a.cV()
local f=a.cY()
local g=a.c1()
local h=a.c5()
local i=a.c7()
local j=a.c9()

local k=a.c3()
local l=a.da()

local m=450
local n="interface.keepIY"
local o=c.uiScale

local p={
awoken=false,
}local q=function(

q)
local r=type(q)=="string"and am[q:lower()]

if r and r.Colors and r.Font then
return q
end

return aa.theme.defaultTheme end local r=function(


r, s, t, u)
local v=(r.Scale*t)/u+r.Offset
local w=math.floor(t/u-s)

if math.floor(v)>=w then
return 1,-s
end

return 0,math.clamp(math.floor(v),0,math.max(w,0))end


p.awake=function(s)
if s.awoken then
return s.screenGui
end

s.awoken=true

s:setupTheme()
s:setupScreenGui()
s:setupScale()
s:setupMainFrame()
s:setupKeepIY()
s:createQuickCapture()
s:createReference()
s:createNotifications()
s:setupListeners()
s:updateNotificationsPosition()

ah:log"interface started"
return s.screenGui end


p.setupTheme=function(s)
ah:debug"interface: initializing theme service"

al:init{
theme=q(aa.theme.selectedTheme),
}end


p.setupScreenGui=function(s)
local t=s:createScreenGui()

t.Parent=an
ac.screenGui=t

o.Parent=t end


p.setupScale=function(s)
s:setScale(ag:getValue"interface.uiScale"or 1)end


p.setupMainFrame=function(s)
local t=s:createMainFrame()

s:createCommands()
s:dragMainFrame(t)
s.commands:enable()

t.Parent=s.screenGui end


p.setupListeners=function(s)
ad:Connect(s.screenGui:GetPropertyChangedSignal"AbsoluteSize",function()
s:updateMainFramePosition()
end)

ad:Connect(s.mainFrame:GetPropertyChangedSignal"AbsolutePosition",function()
s:updateNotificationsPosition()
end)

ad:Connect(s.mainFrame:GetPropertyChangedSignal"AbsoluteSize",function()
s:updateNotificationsPosition()
end)

ad:Connect(ae.RunService.RenderStepped,function()
s:updateNotificationsPosition()
end)end


p.createScreenGui=function(s)
local t=aj.new("ScreenGui",{
IgnoreGuiInset=true,
Name=ai.randomString(math.random(30,50)),
DisplayOrder=2147483647,
})

s.screenGui=t
return t end


p.calculateScale=function(s, t)
return(s.screenGui.AbsoluteSize.Y/m)*t end


p.setScale=function(s, t)
t=math.abs(t)

if t>=3 then
t=s:calculateScale(t)
end

if ag:getValue"interface.uiScale"~=t then
ag:setValue("interface.uiScale",t)
ag:save()
end

c:setScale(t)
s:updateMainFramePosition()end


p.calculateMainFramePosition=function(s, t)
local u=s.mainFrame
local v=s.screenGui
local w=c:getScale()
local x=u.Size

t=t or u.Position

local y,z=r(t.X,x.X.Offset,v.AbsoluteSize.X,w)
local A,B=r(t.Y,x.Y.Offset,v.AbsoluteSize.Y,w)

return UDim2.new(y,z,A,B)end


p.updateMainFramePosition=function(s)
if not s.mainFrame then return end

if s.dock then
s.dock:reflow()
else
s.mainFrame.Position=s:calculateMainFramePosition()
end

s:updateNotificationsPosition()end


p.createMainScroll=function(s, t)
local u=f.new{
isHorizontal=false,
barThickness=12,
}

local v=u:create()
local w=u.container

local x=aj.new("Frame","ScrollHolder",t,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

v,
w,
})

s.scrollHolder=x
s.scrollBar=u
s.scrollContainer=w

return u end


p.createMainFrame=function(s)
local t=e:create()
local u=t.mainFrame

t.titleLabel.Text=b.getDisplayName()

s.mainFrame=u
s.topBar=t.topBar
s.buttons=t.buttons

ak:loadImage(s.buttons.settings,"settings")
ak:loadImage(s.buttons.reference,"reference")

ad:Connect(s.buttons.settings.Activated,function()
print"clicked settings"
end)

s:createMainScroll(u)

return u end


p.createCommands=function(s)
local t=s.scrollBar

local u=g.new{
scrolledSignal=t.scrolledSignal,
scrollContainer=s.scrollContainer,
scrollHolder=s.scrollHolder,
scrollBar=t,

configs={
placeholderText=aa.ui.commands.placeholderText,
padding=aa.ui.commands.padding,
labelSize=aa.ui.commands.labelSize,
textSize=aa.ui.commands.textSize,
},
}

ah:log"created commands interface"
u:create()

ah:log"initialized commands"
u:createCommandsData()

ah:log"awaked commands module"
u:awake()

s.commands=u
return u end


p.createInfoMenu=function(s)
return i:create()end


p.chatLogs=function(s, t)
return j:open(t or"chat")end


p.dragMainFrame=function(s, t)
t.Size=aa.ui.window.windowSize

t.Position=UDim2.fromOffset(1e5,1e5)
t.Position=s:calculateMainFramePosition()

s.dock=l.new{
frame=t,
screenGui=s.screenGui,
topBarHeight=s.topBar.Size.Y.Offset,
clampPosition=function(u)
return s:calculateMainFramePosition(u)
end,
getScale=function()
return c:getScale()
end,
onMinimize=function()
s:releaseCommandFocus()
end,
}

k:addGuiObject(t)

k:setFilter(t,function(u)
return s.dock:clampDrag(u)
end)

k.dragStarted:Connect(function(u)
if u~=t then return end

s.dock:cancel()
s.scrollBar:disableScroll()
end)

k.dragEnded:Connect(function(u,v)
if u~=t then return end

s.scrollBar:enableScroll()
s.dock:onDragEnded(v)
end)end


p.setKeepIY=function(s, t)
t=t==true

if s.dock then
s.dock:setKeepOpen(t)
end

if(ag:getValue(n)==true)~=t then
ag:setValue(n,t)
ag:save()
end

return t end


p.getKeepIY=function(s)
return s.dock~=nil and s.dock.keepOpen==true end


p.setupKeepIY=function(s)
s.dock:setKeepOpen(ag:getValue(n)==true)end


p.releaseCommandFocus=function(s)
local t=s.commands and s.commands.searchBox

if t and t:IsFocused()then
t:ReleaseFocus()
end end


p.showWindow=function(s)
if not s.mainFrame then return end

s.mainFrame.Visible=true
s.dock:reveal()end


p.showCommandBar=function(s)
local t=s.commands and s.commands.searchBox
if not t then return end

s:showWindow()

s.dock:onSettled(function()
if s.dock.state=="minimized"then return end

if t:IsFocused()then
t:ReleaseFocus()
end
t:CaptureFocus()
end)end


p.createQuickCapture=function(s)
if not af then return end

local t=aj.new("TextButton",ai.randomString(math.random(30,50)),s.screenGui,{
BackgroundTransparency=0.14,
Position=UDim2.fromScale(0.5,0.05),
AnchorPoint=Vector2.new(0.5,0.5),
Size=UDim2.new(0,25,0,25),
Font=Enum.Font.SourceSansBold,
Text="IY",
TextSize=16,
ZIndex=10,
ThemeTag={
TextColor3="Colors.Icons",
BackgroundColor3="Colors.Buttons.Default"
},
aj.new("UICorner",{
CornerRadius=UDim.new(0.5,0)
}),
})

s.dock:addWindowPart(t)
k:addGuiObject(t)

ad:Connect(t.Activated,function()
s:showCommandBar()
end)

s.quickCapture=t
return t end


p.createReference=function(s)
local t=h.new()
local u=t:create()

ak:loadImage(t.closeIcon,"close")

u.Parent=s.screenGui
s.reference=t

ad:Connect(s.buttons.reference.Activated,function()
t:open()
end)

return t end


p.createNotifications=function(s)
local t=ao:getContainer(s.screenGui)
s.notificationsContainer=t

ao.onLayoutChanged=function()
s:updateNotificationsPosition()
end

s:updateNotificationsPosition()
return t end


p.updateNotificationsPosition=function(s)
local t=s.notificationsContainer
local u=s.mainFrame
local v=s.screenGui
if not(t and u and v)then return end

local w=c:getScale()
local x=u.AbsolutePosition/w
local y=u.AbsoluteSize/w
local z=v.AbsoluteSize/w

local A=d.compute({
left=x.X,
top=x.Y,
right=x.X+y.X,
bottom=x.Y+y.Y,
},{
width=z.X,
height=z.Y,
},{
width=t.Size.X.Offset,
height=ao:getStackHeight(),
},ab.gapToWindow)

t.AnchorPoint=Vector2.new(A.anchorX,0)
t.Position=UDim2.fromOffset(A.x,A.y)end


p.destroy=function(s)
ao:destroy()
if s.dock then
s.dock:destroy()
s.dock=nil
end

j:reset()

if s.screenGui then
s.screenGui:Destroy()
end

s.screenGui=nil
s.awoken=false end


return p end a.db=function()local ab=a.cache.db if not ab then ab={c=aa()}a.cache.db=ab end return ab.c end end do local aa=function()a.e()


:init()

local aa=a.cQ()
local ab=a.ag()
local ac=a.cx()



local ad=a.db()

local ae={}

ae.boot=function(af)
af.boot=nil

aa:init{
infiniteYield=ad,
playerService=ab,
fetchService=ac
}


ad:awake()end


return ae end a.dc=function()local ab=a.cache.dc if not ab then ab={c=aa()}a.cache.dc=ab end return ab.c end end end














return a.dc():boot()