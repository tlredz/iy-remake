local a={cache={}}do do local b=function()

local b=(getgenv or getfenv or getrenv)()local c=function(

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
end
return f end


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
return a.k().new"storage/settings"end a.l=function()local c=a.cache.l if not c then c={c=b()}a.cache.l=c end return c.c end end do local b=function()
return"v0.4.0"end a.m=function()local c=a.cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local b=function()
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
action="explorer|dex|moondex",
description="Opens DEX by Moon",
run=function(b)
b.fetchService.load("backups/explorer.luau","iy/explorer")()
end
},
{
action="emotemenu|7yd7",
description="Opens animations/emotes menu By 7yd7",
args={
{
kind="keycode",
name="open menu",
optional=true
},
{
kind="boolean",
name="notify",
optional=true
}
},
run=function(b,c)
local d=b.fetchService.load("backups/emotes/notify.luau","iy/7yd7/notify.luau")()

local e=c:nextValue()
local f=c:nextValue()

b.fetchService.load("backups/emotes/main.luau","iy/7yd7/emotes.luau"){
notifyFunction=if f~=false then d else function()end,
isMobile=b.isMobile,
keycode=e,
}
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
action="remotespy|rspy|simplespy",
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
action="serverinfo|info|sinfo",
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
},
{
action="copyplaceid",
description="Copies the current place id to your clipboard",
run=function(d)
local e=d:expectExploit"setclipboard"
if not e then return end

e(tostring(game.PlaceId))
d:notify("Copied","place id copied to your clipboard")
end
},
{
action="copygameid",
description="Copies the current game id to your clipboard",
run=function(d)
local e=d:expectExploit"setclipboard"
if not e then return end

e(tostring(game.GameId))
d:notify("Copied","game id copied to your clipboard")
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


return b end a.I=function()local c=a.cache.I if not c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()








return{
bindings={
prefix={
label="Prefix",
settingKey="keybinds.prefix",
default="Semicolon",
also={"RightControl"},
},
},
}end a.J=function()local c=a.cache.J if not c then c={c=b()}a.cache.J=c end return c.c end end do local b=function()local b=function(

b)
local c={}

for d,e in b do

local f=Enum.KeyCode[d]
c[f]=e
end

return c end


return b{Quote=
"'",QuotedDouble=
"\"",Comma=
",",Minus=
"-",Period=
".",Slash=
"/",Colon=
":",Semicolon=
";",LessThan=
"<",Equals=
"=",GreaterThan=
">",Question=
"?",At=
"@",Hash=
"#",Dollar=
"$",Percent=
"%",Caret=
"^",Ampersand=
"&",Asterisk=
"*",LeftParenthesis=
"(",RightParenthesis=
")",Plus=
"+",Underscore=
"_",LeftBracket=
"[",BackSlash=
"\\",RightBracket=
"]",Backquote=
"`",LeftCurly=
"{",Pipe=
"|",RightCurly=
"}",Tilde=
"~",Zero=


"0",One=
"1",Two=
"2",Three=
"3",Four=
"4",Five=
"5",Six=
"6",Seven=
"7",Eight=
"8",Nine=
"9"
}end a.K=function()local c=a.cache.K if not c then c={c=b()}a.cache.K=c end return c.c end end do local b=function()









local b=a.h()
local c=a.I()
local d=a.l()
local e=a.J()
local f=a.K()

local g=b.UserInputService

local h={}

local i={}
local j
local k=false local l=function(

l)
if type(l)~="string"then return nil end

local m,n=pcall(function()
return Enum.KeyCode[l]
end)

return if m then n else nil end local m=function(


m)
local n=e.bindings[m]
assert(n,`keyboardService: there is no binding named '{m}'`)
return n end local n=function(



n)
local o=m(n)

return l(d:getValue(o.settingKey))
or l(o.default)
or Enum.KeyCode.Unknown end local o=function(



o)
local p=m(o)
local q={n(o)}

for r,s in p.also or{}do
local t=l(s)
if t then
table.insert(q,t)
end
end

return q end local p=function(


p, q)
if p.UserInputType~=Enum.UserInputType.Keyboard then return end

local r=p.KeyCode
if r==Enum.KeyCode.Unknown then return end


if j then
local s=j
j=nil

if r==Enum.KeyCode.Escape then
if s.onCancel then
s.onCancel()
end
else
s.onKey(r)
end

return
end


if q then return end

for s,t in table.clone(i)do
if t.connected and table.find(t.getKeys(),r)then
t.callback(p)
end
end end local q=function()



if k then return end

k=true
c:Connect(g.InputBegan,p)end local r=function(


r, s)
q()

local t={
getKeys=r,
callback=s,
connected=true,
}

table.insert(i,t)

local u={}

u.Disconnect=function(v)
t.connected=false

local w=table.find(i,t)
if w then
table.remove(i,w)
end end


return u end



h.onKeysPressed=function(s, t, u)
return r(function()
return t
end,u)end



h.onBindingPressed=function(s, t, u)
m(t)

return r(function()
return o(t)
end,u)end




h.capture=function(s, t, u)
q()

local v={onKey=t,onCancel=u}
j=v

return function()
if j==v then
j=nil
end
end end


h.getBinding=function(s, t)
return n(t)end


h.setBinding=function(s, t, u)
local v=m(t)
assert(typeof(u)=="EnumItem"and u.EnumType==Enum.KeyCode,"keyboardService: setBinding needs a KeyCode")

d:setValue(v.settingKey,u.Name)
d:save()end



h.resetBinding=function(s, t)
local u=m(t)

d:setValue(u.settingKey,nil)
d:save()end


h.getKeyName=function(s, t)

return f[t]or t.Name end











h.getBindingName=function(s, t)
return s:getKeyName(n(t))end


return h end a.L=function()local c=a.cache.L if not c then c={c=b()}a.cache.L=c end return c.c end end do local b=function()



local b=a.L()local c=function(

c)
local d=c:collectGarbage"hideiy"
if d and d.connection then
d.connection:Disconnect()
end end local d=function(




d, e)
c(d)

local f=d:registerGarbage"hideiy"
f.connection=b:onBindingPressed("prefix",function()

if e.mainFrame.Visible then return end

e:showCommandBar()
end)end local e=function(


e)
local f=e.infiniteYield
if not f or not f.mainFrame then
e:notify("IY","the main window is not created yet")
return
end

if not f.mainFrame.Visible then
e:notify("IY","already hidden")
return
end

f:hideWindow()
d(e,f)

local g=b:getBindingName"prefix"
e:notify("IY",`hidden. Press {g} or tap the IY button to type a command`)end local f=function(


f)
c(f)

local g=f.infiniteYield
if g then
g:showWindow()
end end


return{
{
action="hideiy|hideinterface",
description="Hides the main IY GUI",
run=function(g)
e(g)
end
},
{
action="showiy|unhideiy|unhideinterface",
description="Shows IY again",
run=function(g)
f(g)
end
}
}end a.M=function()local c=a.cache.M if not c then c={c=b()}a.cache.M=c end return c.c end end do local b=function()local b=function(

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
}end a.N=function()local c=a.cache.N if not c then c={c=b()}a.cache.N=c end return c.c end end do local b=function()


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
}end a.O=function()local c=a.cache.O if not c then c={c=b()}a.cache.O=c end return c.c end end do local b=function()

return{
action="clearerror",
description="Clears the annoying box and blur when a game kicks you",
run=function(b)
b.guiService:ClearError()
end
}end a.P=function()local c=a.cache.P if not c then c={c=b()}a.cache.P=c end return c.c end end do local b=function()

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
}end a.Q=function()local c=a.cache.Q if not c then c={c=b()}a.cache.Q=c end return c.c end end do local b=function()

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
}end a.R=function()local c=a.cache.R if not c then c={c=b()}a.cache.R=c end return c.c end end do local b=function()

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
}end a.S=function()local c=a.cache.S if not c then c={c=b()}a.cache.S=c end return c.c end end do local b=function()

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
}end a.T=function()local c=a.cache.T if not c then c={c=b()}a.cache.T=c end return c.c end end do local b=function()

return{
action="cancelteleport|canceltp",
description="Cancels teleports in progress",
run=function(b)
b.playerService:cancelTween()
b.teleportService:TeleportCancel()
end
}end a.U=function()local c=a.cache.U if not c then c={c=b()}a.cache.U=c end return c.c end end do local b=function()

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
}end a.V=function()local c=a.cache.V if not c then c={c=b()}a.cache.V=c end return c.c end end do local b=function()
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
}end a.W=function()local c=a.cache.W if not c then c={c=b()}a.cache.W=c end return c.c end end do local b=function()
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
}end a.X=function()local c=a.cache.X if not c then c={c=b()}a.cache.X=c end return c.c end end do local b=function()
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
}end a.Y=function()local c=a.cache.Y if not c then c={c=b()}a.cache.Y=c end return c.c end end do local b=function()
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


return b end a.Z=function()local c=a.cache.Z if not c then c={c=b()}a.cache.Z=c end return c.c end end do local b=function()
local b=a.Z()

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
}end a._=function()local c=a.cache._ if not c then c={c=b()}a.cache._=c end return c.c end end do local b=function()

return{
action="notifyping|ping",
description="Notify yourself your ping",
run=function(b)
local c=b.localPlayer:GetNetworkPing()
b:notify("Ping",`{math.round(c*1000)}ms`)
end
}end a.aa=function()local c=a.cache.aa if not c then c={c=b()}a.cache.aa=c end return c.c end end do local b=function()
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
}end a.ab=function()local c=a.cache.ab if not c then c={c=b()}a.cache.ab=c end return c.c end end do local b=function()
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
}end a.ac=function()local c=a.cache.ac if not c then c={c=b()}a.cache.ac=c end return c.c end end do local b=function()
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
}end a.ad=function()local c=a.cache.ad if not c then c={c=b()}a.cache.ad=c end return c.c end end do local b=function()local b=function(
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
}end a.ae=function()local c=a.cache.ae if not c then c={c=b()}a.cache.ae=c end return c.c end end do local b=function()
return{
action="exit|shutdown|leave",
description="Kills roblox process",
run=function()
game:shutdown()
end
}end a.af=function()local c=a.cache.af if not c then c={c=b()}a.cache.af=c end return c.c end end do local b=function()


return{
action="breakloops|break",
description="Stops any cmd loops (100^1^cmd)",
run=function(b)
b.loopService:stop()
end
}end a.ag=function()local c=a.cache.ag if not c then c={c=b()}a.cache.ag=c end return c.c end end do local b=function()
return{
action="notifyjobid",
description="Notifies the JobId and PlaceId of the current server",
run=function(b)
b:notify("JobId / PlaceId",`{game.JobId} / {game.PlaceId}`)
end
}end a.ah=function()local c=a.cache.ah if not c then c={c=b()}a.cache.ah=c end return c.c end end do local b=function()

local b=a.h()
return b.Players.LocalPlayer end a.ai=function()local c=a.cache.ai if not c then c={c=b()}a.cache.ai=c end return c.c end end do local b=function()
local b=a.h()
local c=a.ai()
local d=a.d()

local e=b.TeleportService
local f=b.TweenService

local g=c:GetMouse()

local h={}


local i

h.getMouse=function(j)
return g end


h.isMouseInGuiObject=function(j, k)
local l=k.AbsolutePosition
local m=k.AbsoluteSize

return g.X>=l.X
and g.X<l.X+m.X
and g.Y>=l.Y
and g.Y<l.Y+m.Y end


h.teleportToJobId=function(j, k, l)
l=l or game.PlaceId
e:TeleportToPlaceInstance(l,k,c)end


h.isAlive=function(j, k)
local l=if k
then k:FindFirstChildOfClass"Humanoid"
else j:getHumanoid()

return l~=nil and l.Health>0 end


h.getCharacter=function(j)
return c.Character end


h.getHumanoid=function(j)
local k=j:getCharacter()
return k and k:FindFirstChildOfClass"Humanoid"end


h.getRootPart=function(j)
local k=j:getHumanoid()
return k and k.RootPart end


h.resetCharacter=function(j)
local k=j:getCharacter()
if not k then return end

local l=k:FindFirstChildOfClass"Humanoid"
if l then
l:ChangeState(Enum.HumanoidStateType.Dead)
else
k:BreakJoints()
end end


h.getPlayersByName=function(j, k)
local l={}

local m=#k
k=k:lower()

for n,o in b.Players:GetPlayers()do
local p=string.lower(o.Name):sub(1,m)
local q=string.lower(o.displayName):sub(1,m)

if p==k or q==k then
table.insert(l,o)
end
end

return l end


h.getCamera=function(j)
return workspace.CurrentCamera end




h.unseat=function(j)
local k=j:getHumanoid()
if not k then return nil end

if k.SeatPart~=nil then
k.Sit=false
task.wait(0.1)
end

return j:getHumanoid()end




h.setRootCFrame=function(j, k)
local l=j:getRootPart()
if not l then return false end

l.CFrame=k
l.AssemblyLinearVelocity=Vector3.zero
return true end




h.teleportTo=function(j, k)
d:expect(k,{"CFrame","Vector3"},"'playerService:teleportTo' #1")

if typeof(k)=="Vector3"then
k=CFrame.new(k)
end

j:unseat()
return j:setRootCFrame(k)end




h.breakVelocity=function(j, k)
local l=j:getCharacter()
if not l then return end

local m=os.clock()+(k or 1)
task.spawn(function()
while os.clock()<m and l.Parent do
for n,o in l:GetDescendants()do
if o:IsA"BasePart"then
o.AssemblyLinearVelocity=Vector3.zero
o.AssemblyAngularVelocity=Vector3.zero
end
end
task.wait()
end
end)end




local j local k=function()


local k=j
j=nil

if k and k.humanoid.Parent then
k.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,k.wasEnabled)
end end local l=function(


l)

if j and j.humanoid==l then return end

k()
j={
humanoid=l,
wasEnabled=l:GetStateEnabled(Enum.HumanoidStateType.Seated)
}
l:SetStateEnabled(Enum.HumanoidStateType.Seated,false)end



h.cancelTween=function(m)
local n=i
i=nil

k()

if n then
n:Cancel()
return true
end

return false end



local m=100





h.tweenTeleportTo=function(n, o)
d:expect(o,{"table"},"'playerService:tweenTeleportTo' #1")

local p=o.target
local q=o.speed or m

d:expect(p,{"CFrame","Vector3"},"'playerService:tweenTeleportTo' config.target")
d:expect(q,{"number"},"'playerService:tweenTeleportTo' config.speed")

if typeof(p)=="Vector3"then
p=CFrame.new(p)
end

n:unseat()

local r=n:getRootPart()
if not r then return nil end


local s=(p.Position-r.Position).Magnitude
local t=s/math.max(q,1)


local u=i
i=nil
if u then
u:Cancel()
end

local v=n:getHumanoid()
if v then
l(v)
end

local w=TweenInfo.new(t,Enum.EasingStyle.Linear)
local x=f:Create(r,w,{
CFrame=p
})

i=x
x.Completed:Once(function()

if i~=x then return end

i=nil
k()
n:breakVelocity()
end)

x:Play()
return x end




h.waitForStreamPlayerCharacter=function(n, o, p)
if not(o and workspace.StreamingEnabled)then return end

local q=o:GetPivot().Position
p=p or 5

task.spawn(c.RequestStreamAroundAsync,c,q,p)
o:WaitForChild("HumanoidRootPart",p)end


return h end a.aj=function()local c=a.cache.aj if not c then c={c=b()}a.cache.aj=c end return c.c end end do local b=function()

local b=a.h()
local c=a.aj()
local d=a.ai()local e=function(







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
})end a.ak=function()local c=a.cache.ak if not c then c={c=b()}a.cache.ak=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.al=function()local c=a.cache.al if not c then c={c=b()}a.cache.al=c end return c.c end end do local b=function()

return{
action="inviteprompt",
description="Prompts the game invite window, so you can invite friends",
run=function(b)
local c=game:GetService"SocialService"

local d,e=pcall(function()
c:PromptGameInvite(b.localPlayer)
end)

if not d then
b:notify("Invite Prompt","could not open the invite prompt: "..tostring(e))
end
end
}end a.am=function()local c=a.cache.am if not c then c={c=b()}a.cache.am=c end return c.c end end do local b=function()

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
}end a.an=function()local c=a.cache.an if not c then c={c=b()}a.cache.an=c end return c.c end end do local b=function()

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
}end a.ao=function()local c=a.cache.ao if not c then c={c=b()}a.cache.ao=c end return c.c end end do local b=function()

return{
action="mousesensitivity|ms",
description="Sets your mouse delta sensitivity",
args={kind="number",name="sensitivity"},
run=function(b,c)
b.robloxServices.UserInputService.MouseDeltaSensitivity=c:nextValue()
end
}end a.ap=function()local c=a.cache.ap if not c then c={c=b()}a.cache.ap=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.aq=function()local c=a.cache.aq if not c then c={c=b()}a.cache.aq=c end return c.c end end do local b=function()local b=function(


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
}end a.ar=function()local c=a.cache.ar if not c then c={c=b()}a.cache.ar=c end return c.c end end do local b=function()

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
}end a.as=function()local c=a.cache.as if not c then c={c=b()}a.cache.as=c end return c.c end end do local b=function()

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
}end a.at=function()local c=a.cache.at if not c then c={c=b()}a.cache.at=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.au=function()local c=a.cache.au if not c then c={c=b()}a.cache.au=c end return c.c end end do local b=function()




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
}end a.av=function()local c=a.cache.av if not c then c={c=b()}a.cache.av=c end return c.c end end do local b=function()




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
}end a.aw=function()local c=a.cache.aw if not c then c={c=b()}a.cache.aw=c end return c.c end end do local b=function()




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
}end a.ax=function()local c=a.cache.ax if not c then c={c=b()}a.cache.ax=c end return c.c end end do local b=function()local b=function(


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
}end a.ay=function()local c=a.cache.ay if not c then c={c=b()}a.cache.ay=c end return c.c end end do local b=function()

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
,a.W()
,a.X()
,a.Y()
,a._()
,a.aa()
,a.ab()
,a.ac()
,a.ad()
,a.ae()
,a.af()
,a.ag()

,a.ah()
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
,a.av()
,a.aw()
,a.ax()
,a.ay()

}end a.az=function()local c=a.cache.az if not c then c={c=b()}a.cache.az=c end return c.c end end do local b=function()





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
n.kind=i.kind

n.connection=h:connect(h.runService.Heartbeat,function()
if not k:IsDescendantOf(workspace)or j.Health<=0 then
d.stop(h,i.garbageName)
return
end

l.Velocity=g(h,j)*i.getSpeed()
m.CFrame=workspace.CurrentCamera.CFrame
end)end


return d end a.aA=function()local c=a.cache.aA if not c then c={c=b()}a.cache.aA=c end return c.c end end do local b=function()

local b=a.aA()

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
kind="fly",
platformStand=true,
getSpeed=function()
return d.privateEnv.flySpeed or c
end
})
end
},
{
action="flyspeed|flysp",
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
action="togglefly",
description="Toggles fly",
args={
kind="number",
name="fly speed",
optional=true
},
run=function(d,e)
local f=d:getGarbage"fly"
if f and f.kind=="fly"then
d:run"unfly"
else
d:run("fly",e)
end
end
},
{
action="unfly|nofly",
description="Disables fly",
run=function(d)
b.stop(d,"fly")
end
}
}end a.aB=function()local c=a.cache.aB if not c then c={c=b()}a.cache.aB=c end return c.c end end do local b=function()

local b="Noclip"local c=function(


c)
local d=c:collectGarbage"noclip"
if not d then return false end

d.connection:Disconnect()

for e in d.parts do
if e.Parent then
e.CanCollide=true
end
end

return true end local d=function(


d)
local e=d:createGarbage"noclip"
e.parts=setmetatable({},{__mode="k"})

e.connection=d:connect(d.runService.Stepped,function()
local f=d.playerService:getCharacter()
if not f then return end


local g=d:getGarbage"float"
local h=g and g.platform

for i,j in f:GetDescendants()do
if j:IsA"BasePart"and j.CanCollide and j~=h then
j.CanCollide=false
e.parts[j]=true
end
end
end)end


local e={kind="string",name="nonotify",optional=true}

return{
{
action="noclip",
description="Go through objects",
args=e,
run=function(f,g)
local h=g:nextValue()=="nonotify"


c(f)
d(f)

if not h then
f:notify(b,"Noclip Enabled")
end
end
},
{
action="unnoclip|clip",
description="Disables noclip",
args=e,
run=function(f,g)
local h=g:nextValue()=="nonotify"
c(f)

if not h then
f:notify(b,"Noclip Disabled")
end
end
},
{
action="togglenoclip",
description="Toggles noclip",
run=function(f)

f:run(if f:hasGarbage"noclip"then"unnoclip"else"noclip")
end
}
}end a.aC=function()local c=a.cache.aC if not c then c={c=b()}a.cache.aC=c end return c.c end end do local b=function()

local b=a.aA()

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
kind="vehiclefly",
platformStand=false,
getSpeed=function()
return d.privateEnv.vehicleFlySpeed or c
end
})
end
},
{
action="vehicleflyspeed|vflyspeed|vflysp",
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
action="togglevfly",
description="Toggles vehicle fly",
args={
kind="number",
name="vehicle fly speed",
optional=true
},
run=function(d,e)
local f=d:getGarbage"fly"
if f and f.kind=="vehiclefly"then
d:run"unvehiclefly"
else
d:run("vehiclefly",e)
end
end
},
{
action="unvehiclefly|unvfly|novehiclefly|novfly",
description="Disables vehicle fly",
run=function(d)
b.stop(d,"fly")
end
}
}end a.aD=function()local c=a.cache.aD if not c then c={c=b()}a.cache.aD=c end return c.c end end do local b=function()

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
}end a.aE=function()local c=a.cache.aE if not c then c={c=b()}a.cache.aE=c end return c.c end end do local b=function()

return{
action="qefly|flyqe",
description="Enables or disables the Q and E hotkeys for fly",
args={
kind="boolean",
optional=true
},
run=function(b,c)

b.privateEnv.qeFly=c:nextValue()~=false
end
}end a.aF=function()local c=a.cache.aF if not c then c={c=b()}a.cache.aF=c end return c.c end end do local b=function()local b=function(


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
action="togglevnoclip",
description="Toggles vehicle collision",
run=function(d)
d:run(if d:hasGarbage"vehiclenoclip"then"vehicleclip"else"vehiclenoclip")
end
},
{
action="vehicleclip|vclip|unvnoclip",
description="Enables vehicle collision",
run=function(d)
c(d)
end
},
}end a.aG=function()local c=a.cache.aG if not c then c={c=b()}a.cache.aG=c end return c.c end end do local b=function()

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
action="togglefloat",
description="Toggles float",
run=function(e)
e:run(if e:hasGarbage"float"then"unfloat"else"float")
end
},
{
action="unfloat|noplatform|nofloat|unplatform",
description="Removes the platform",
run=function(e)
if not e:hasGarbage"float"then return end

c(e)
e:notify("Float","Disabled")
end
}
}end a.aH=function()local c=a.cache.aH if not c then c={c=b()}a.cache.aH=c end return c.c end end do local b=function()local b=function()



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
}end a.aI=function()local c=a.cache.aI if not c then c={c=b()}a.cache.aI=c end return c.c end end do local b=function()local b=function(

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
}end a.aJ=function()local c=a.cache.aJ if not c then c={c=b()}a.cache.aJ=c end return c.c end end do local b=function()local b=function(

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
}end a.aK=function()local c=a.cache.aK if not c then c={c=b()}a.cache.aK=c end return c.c end end do local b=function()local b=function(


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
}end a.aL=function()local c=a.cache.aL if not c then c={c=b()}a.cache.aL=c end return c.c end end do local b=function()

local b=a.ak()local c=function(

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
}end a.aM=function()local c=a.cache.aM if not c then c={c=b()}a.cache.aM=c end return c.c end end do local b=function()

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
}end a.aN=function()local c=a.cache.aN if not c then c={c=b()}a.cache.aN=c end return c.c end end do local b=function()local b=function(

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
}end a.aO=function()local c=a.cache.aO if not c then c={c=b()}a.cache.aO=c end return c.c end end do local b=function()


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
}end a.aP=function()local c=a.cache.aP if not c then c={c=b()}a.cache.aP=c end return c.c end end do local b=function()local b=function(

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
}end a.aQ=function()local c=a.cache.aQ if not c then c={c=b()}a.cache.aQ=c end return c.c end end do local b=function()local b=function(

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
}end a.aR=function()local c=a.cache.aR if not c then c={c=b()}a.cache.aR=c end return c.c end end do local b=function()

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
}end a.aS=function()local c=a.cache.aS if not c then c={c=b()}a.cache.aS=c end return c.c end end do local b=function()local b=function(




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
}end a.aT=function()local c=a.cache.aT if not c then c={c=b()}a.cache.aT=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.aU=function()local c=a.cache.aU if not c then c={c=b()}a.cache.aU=c end return c.c end end do local b=function()local b=function(

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
}end a.aV=function()local c=a.cache.aV if not c then c={c=b()}a.cache.aV=c end return c.c end end do local b=function()

local b=a.Z()

local c=PhysicalProperties.new(100,0.3,0.5)


local d=Vector3.yAxis*99999 local e=function()


local e=Instance.new"BodyAngularVelocity"

e.MaxTorque=Vector3.new(0,math.huge,0)
e.P=math.huge
return e end local f=function(


f)
if f:hasGarbage"fling"then
f:notify"fling is already enabled\ndisable using 'unfling'"
return
end

local g=f.playerService:getHumanoid()
if not(g and g.Health~=0)then return end

local h=f:getRoot()
if not h then return end

local i=g.Parent

f:notify"fling now is activated"

f:run("noclip",b.new{{value="nonotify"}})

local j=f:createGarbage"fling"
j.originalStates={}

for k,l in i:GetDescendants()do
if not l:IsA"BasePart"then continue end

j.originalStates[l]={
CustomPhysicalProperties=l.CustomPhysicalProperties,
Massless=l.Massless
}

l.CustomPhysicalProperties=c
end

local k=e()
j.flingVelocity=k

j.flingConnection=f:connect(g.Died,function()
f:notify"player died: disabling fling..."
f:run"unfling"
end)


j.flingThread=task.spawn(function()

task.wait(0.1)
if f:getGarbage"fling"~=j then return end

for l,m in i:GetChildren()do
if m:IsA"BasePart"then
m.Massless=true
m.Velocity=Vector3.zero
end
end

k.Parent=h


while f:getGarbage"fling"==j and h.Parent do
k.AngularVelocity=d
task.wait(0.2)
k.AngularVelocity=Vector3.zero
task.wait(0.1)
end
end)end local g=function(


g)
local h=g:collectGarbage"fling"
if not h then return end


if h.flingThread then
task.cancel(h.flingThread)
end

if h.flingVelocity then
h.flingVelocity:Destroy()
end

if h.flingConnection then
h.flingConnection:Disconnect()
end

for i,j in h.originalStates do
for k,l in j do
i[k]=l
end
end

g:notify"fling disabled"end




local h=0.1 local i=function(

i, j)
return i~=nil and i.Parent~=nil and j~=nil and j.Parent~=nil end local j=function(


j)
if j:hasGarbage"walkfling"then
j:notify"walkfling is already enabled\ndisable using 'unwalkfling'"
return
end

local k=j:createGarbage"walkfling"


if not j:hasGarbage"noclip"then
j:run("noclip",b.new{{value="nonotify"}})
k.enabledNoclip=true
end

local l=j.runService local m=function()

return j:getGarbage"walkfling"==k end


k.thread=task.spawn(function()
while m()do
l.Heartbeat:Wait()

local n=j.playerService:getCharacter()
local o=n and n:FindFirstChild"HumanoidRootPart"

while m()and not i(n,o)do
l.Heartbeat:Wait()
n=j.playerService:getCharacter()
o=n and n:FindFirstChild"HumanoidRootPart"
end

if not m()then break end

local p=o.AssemblyLinearVelocity
o.AssemblyLinearVelocity=p*10000+Vector3.new(0,10000,0)

l.RenderStepped:Wait()
if i(n,o)then
o.AssemblyLinearVelocity=p
end

l.Stepped:Wait()
if i(n,o)then
o.AssemblyLinearVelocity=p+Vector3.new(0,h,0)
end
end
end)


local n=j.playerService:getHumanoid()
if n then
k.diedConnection=j:connect(n.Died,function()
j:run"unwalkfling"
end)
end end local k=function(


k)
local l=k:collectGarbage"walkfling"
if not l then return end

if l.diedConnection then
l.diedConnection:Disconnect()
end

if l.enabledNoclip then
k:run("unnoclip",b.new{{value="nonotify"}})
end end local l=function(


l, m)
l:run"unvehiclefly"
l:run"unwalkfling"

local n=m and m:nextValue()
if n then
l.privateEnv.vehicleFlySpeed=n
end


l:run("vehiclefly",b.new{})
j(l)

local o=l:getGarbage"walkfling"
if o then
o.flyfling=true
end end local m=function(


m)
m:run"unvehiclefly"
m:run"unwalkfling"
m:run"breakvelocity"end


return{
{
action="fling|forcefling",
description="Flings anyone you touch",
run=f
},
{
action="unfling|nofling",
description="Disables the fling command",
run=g
},
{
action="flyfling",
description="Basically the invisfling command but not invisible",
args={
kind="number",
name="speed",
optional=true
},
run=l
},
{
action="unflyfling",
description="Disables the flyfling command",
run=m
},
{
action="walkfling",
description="Basically fling but no spinning",
run=j
},
{
action="unwalkfling|nowalkfling",
description="Disables walkfling",
run=k
},
{
action="togglefling",
description="Toggles fling",
run=function(n)
n:run(if n:hasGarbage"fling"then"unfling"else"fling")
end
},
{
action="toggleflyfling",
description="Toggles flyfling",
args={
kind="number",
name="speed",
optional=true
},
run=function(n,o)
local p=n:getGarbage"walkfling"
if p and p.flyfling then
n:run"unflyfling"
else
n:run("flyfling",o)
end
end
},
{
action="togglewalkfling",
description="Toggles walkfling",
run=function(n)
n:run(if n:hasGarbage"walkfling"then"unwalkfling"else"walkfling")
end
},
{
action="toggleantifling",
description="Toggles antifling",
run=function(n)
n:run(if n:hasGarbage"antifling"then"unantifling"else"antifling")
end
},
{
action="invisfling",
description="Enables invisible fling (the invis part is patched, try using the god command before using this)",
run=function(n)
n:run"invisible"

task.spawn(function()
n:run"fling"
end)
end
},
{
action="antifling",
description="Disables player collisions to prevent you from being flung",
run=function(n)
if n:hasGarbage"antifling"then return end

local o=n:createGarbage"antifling"
o.connection=n:connect(n.runService.Stepped,function()
for p,q in n.players:GetPlayers()do
if q~=n.localPlayer and q.Character then
for r,s in q.Character:GetDescendants()do
if s:IsA"BasePart"then
s.CanCollide=false
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
run=function(n)
local o=n:collectGarbage"antifling"
if o then
o.connection:Disconnect()
end
end
}
}end a.aW=function()local c=a.cache.aW if not c then c={c=b()}a.cache.aW=c end return c.c end end do local b=function()local b=function(






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
action="visible|vis|uninvisible",
description="Makes you visible to other players",
run=function(e)
if not d(e)then
e:notify("Visible","you are already visible")
end
end
},
{
action="toggleinvis",
description="Toggles invisibility",
run=function(e)
e:run(if e:hasGarbage"invisible"then"visible"else"invisible")
end
},
{
action="toolinvisible|toolinvis|tinvis",
description="Makes you invisible to other players and able to use tools",
run=function(e)
c(e)
end
}
}end a.aX=function()local c=a.cache.aX if not c then c={c=b()}a.cache.aX=c end return c.c end end do local b=function()local b=function(

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
action="noarms|rarms",
description="Removes your arms",
run=function(d)
local e=d.localPlayer.Character
if e then
b(e,c(d)and{"RightUpperArm","LeftUpperArm"}or{"Right Arm","Left Arm"})
end
end
},
{
action="nolegs|rlegs",
description="Removes your legs",
run=function(d)
local e=d.localPlayer.Character
if e then
b(e,c(d)and{"RightUpperLeg","LeftUpperLeg"}or{"Right Leg","Left Leg"})
end
end
},
{
action="nolimbs|rlimbs",
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
}end a.aY=function()local c=a.cache.aY if not c then c={c=b()}a.cache.aY=c end return c.c end end do local b=function()local b=function(


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
}end a.aZ=function()local c=a.cache.aZ if not c then c={c=b()}a.cache.aZ=c end return c.c end end do local b=function()



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
}end a.a_=function()local c=a.cache.a_ if not c then c={c=b()}a.cache.a_=c end return c.c end end do local b=function()local b=function(


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
}end a.a0=function()local c=a.cache.a0 if not c then c={c=b()}a.cache.a0=c end return c.c end end do local b=function()local b=function(




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
}end a.a1=function()local c=a.cache.a1 if not c then c={c=b()}a.cache.a1=c end return c.c end end do local b=function()

local b=a.ak()local c=function(


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
}end a.a2=function()local c=a.cache.a2 if not c then c={c=b()}a.cache.a2=c end return c.c end end do local b=function()

local b=a.ak()local c=function(

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
}end a.a3=function()local c=a.cache.a3 if not c then c={c=b()}a.cache.a3=c end return c.c end end do local b=function()

local b=a.ak()local c=function(

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
}end a.a4=function()local c=a.cache.a4 if not c then c={c=b()}a.cache.a4=c end return c.c end end do local b=function()

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
}end a.a5=function()local c=a.cache.a5 if not c then c={c=b()}a.cache.a5=c end return c.c end end do local b=function()

local b=a.ak()


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
}end a.a6=function()local c=a.cache.a6 if not c then c={c=b()}a.cache.a6=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.a7=function()local c=a.cache.a7 if not c then c={c=b()}a.cache.a7=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.a8=function()local c=a.cache.a8 if not c then c={c=b()}a.cache.a8=c end return c.c end end do local b=function()

return{a.aB()
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
,a.a7()
,a.a8()

}end a.a9=function()local c=a.cache.a9 if not c then c={c=b()}a.cache.a9=c end return c.c end end do local b=function()

return a.k().new"storage/createdWaypoints"end a.ba=function()local c=a.cache.ba if not c then c={c=b()}a.cache.ba=c end return c.c end end do local b=function()
local b={}

local c={Vector3=
function(c)
return`{c.X} {c.Y} {c.Z}`
end,Color3=
function(c)
return`{c.R} {c.G} {c.B}`
end
}

local d={Vector3=
function(d)
local e=d:split" "
return Vector3.new(e[1]or 0,e[2]or 0,e[3]or 0)
end,Color3=
function(d)
local e=d:split" "
return Color3.new(e[1]or 0,e[2]or 0,e[3]or 0)
end
}

b.stringify=function(e, f)
local g=c[typeof(f)]
assert(g,"can't convert to string")

return g(f)end


b.unstringify=function(e, f, g)
local h=d[g]
assert(h,"can't convert to value")

return h(f)end


return b end a.bb=function()local c=a.cache.bb if not c then c={c=b()}a.cache.bb=c end return c.c end end do local b=function()











local b=a.ba()
local c=a.b()
local d=a.aj()
local e=a.bb()

local f="showingWaypoints"


local g=c.iyGarbages or{}
c.iyGarbages=g



local h={}local i=function()


return tostring(game.PlaceId)end local j=function(



j)
if j then
return b:register(i(),{})
end

local k=b:getValue(i())
return if type(k)=="table"then k else nil end local k=function(


k)
local l=0

if type(k)=="table"then
for m in k do
l=l+1
end
end

return l end local l=function(



l)
if type(l)~="string"then return nil end

local m,n=pcall(e.unstringify,e,l,"Vector3")
if m and typeof(n)=="Vector3"then
return n
end

return nil end



h.list=function()
local m={}

for n,o in j()or{}do
local p=l(o)

if p then
table.insert(m,{name=n,position=p})
end
end

table.sort(m,function(n,o)
return n.name:lower()<o.name:lower()
end)

return m end



h.find=function(m)
local n=m:lower()

for o,p in h.list()do
if p.name:lower()==n then
return p
end
end

return nil end



h.count=function()
return k(j())end



h.countAll=function()
local m=0

for n,o in b:getData()do
m=m+k(o)
end

return m end




h.save=function(m, n)
local o=(j(true))
local p=m:lower()
local q=false

for r in o do
if r:lower()==p then
o[r]=nil
q=true
end
end

o[m]=(e:stringify(n))
b:save()

return q end



h.remove=function(m)
local n=j()
local o=m:lower()
local p=false

if type(n)=="table"then
for q in n do
if q:lower()==o then
n[q]=nil
p=true
end
end
end

if p then
b:save()
end

return p end



h.clearPlace=function()
local m=h.count()

b:setValue(i(),nil)
b:save()

return m end



h.clearAll=function()
local m=0


for n,o in b:getData()do
m=m+k(o)
b:setValue(n,nil)
end

b:save()

return m end



h.format=function(m)
return`({math.round(m.X)}, {math.round(m.Y)}, {math.round(m.Z)})`end



h.parsePosition=function(m)
local n={}

for o in m:gmatch"[^%s,;]+"do
local p=tonumber(o)

if p==nil or p~=p or math.abs(p)==math.huge then
return nil
end

table.insert(n,p)
end

if#n~=3 then
return nil
end

return Vector3.new(n[1],n[2],n[3])end




h.go=function(m, n)
if n=="tween"then
local o=d:tweenTeleportTo{
target=CFrame.new(m.position),
speed=c.tweenSpeed,
}

return o~=nil
end

if n=="walk"then
local o=d:unseat()
if not o then return false end

o:MoveTo(m.position)
return true
end

return d:teleportTo(CFrame.new(m.position))end




h.isShown=function()
return g[f]~=nil end



h.hide=function()
local m=g[f]
if m==nil then return false end

g[f]=nil

for n,o in m do
o:Destroy()
end

return true end local m=function(


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

return n end



h.show=function()
h.hide()

local n={}
local o=h.list()

for p,q in o do
table.insert(n,m(q))
end

g[f]=n
return#o end



h.refreshMarkers=function()
if h.isShown()then
h.show()
end end


return h end a.bc=function()local c=a.cache.bc if not c then c={c=b()}a.cache.bc=c end return c.c end end do local b=function()




local b=a.bc()

local c="Waypoints"local d=function(


d, e)
local f=b.find(e)

if not f then
d:notify(c,`there is no waypoint named '{e}'`)
end

return f end local e=function(



e, f, g)
local h=d(e,f:nextValue())
if not h then return end

b.go(h,g)end


return{
{
action="setwaypoint|swp|setwp|spos|savepos|setpos",
description="Sets a waypoint at your position",
args={kind="string",name="waypoint name"},
run=function(f,g)
local h=f:getRoot()
if not h then return end

local i=g:nextValue()

b.save(i,h.Position)
b.refreshMarkers()
f:notify(c,`saved waypoint '{i}' at {b.format(h.Position)}`)
end
},
{
action="waypointpos|wpp",
description="Sets a waypoint with specified coordinates",
args={
{kind="string",name="waypoint name"},
{kind="vector3",name="position"},
},
run=function(f,g)
local h=g:nextValue()
local i=g:nextValue()

b.save(h,i)
b.refreshMarkers()
f:notify(c,`saved waypoint '{h}' at {b.format(i)}`)
end
},
{
action="waypoints|positions",
description="Shows a list of currently active waypoints",
run=function(f)
local g=b.list()

if#g==0 then
f:notify(c,"there are no waypoints in this game")
return
end

local h={}
for i,j in g do
table.insert(h,`{j.name} {b.format(j.position)}`)
end

f:notify(c,table.concat(h,", "))
end
},
{
action="showwaypoints|showwp|showwps",
description="Shows all currently set waypoints",
run=function(f)
if b.count()==0 then
f:notify(c,"there are no waypoints to show")
return
end

b.show()
end
},
{
action="hidewaypoints|hidewp|hidewps",
description="Hides shown waypoints",
run=function()
b.hide()
end
},
{
action="waypoint|wp|gotowaypoint|gotowp|gwp|loadpos|lpos|loadposition",
description="Teleports player to a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(f,g)
e(f,g,"teleport")
end
},
{
action="tweenwaypoint|twp|tweengotowaypoint|tgotowp",
description="Tweens player to a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(f,g)
e(f,g,"tween")
end
},
{
action="walktowaypoint|wtwp|walktowp",
description="Walks player to a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(f,g)
e(f,g,"walk")
end
},
{
action="deletewaypoint|dwp|deletepos|dpos",
description="Deletes a waypoint",
args={kind="waypoint",name="waypoint"},
run=function(f,g)
local h=d(f,g:nextValue())
if not h then return end

b.remove(h.name)
b.refreshMarkers()
f:notify(c,`deleted waypoint '{h.name}'`)
end
},
{
action="clearwaypoints|cwp|clearpositions|clearpos|cpos",
description="Clears all waypoints from every game",
args={kind="boolean",name="confirm",optional=true},
run=function(f,g)
local h=g:nextValue()
if not h then
f:notify(c,"cancelled, use 'true' to confirm")
return
end

local i=b.clearAll()

b.hide()
f:notify(c,`deleted {i} waypoints from every game`)
end
},
{
action="cleargamewaypoints|cgamewp",
description="Clears all waypoints for the game you are in",
args={kind="boolean",name="confirm",optional=true},
run=function(f,g)
local h=g:nextValue()
if not h then
f:notify(c,"cancelled, use 'true' to confirm")
return
end

local i=b.clearPlace()

b.hide()
f:notify(c,`deleted {i} waypoints from this game`)
end
}
}end a.bd=function()local c=a.cache.bd if not c then c={c=b()}a.cache.bd=c end return c.c end end do local b=function()

return{
action="tweenspeed|tspeed",
description="Sets how fast the tween commands move you, in studs per second (default is 100)",
args={kind="number",name="tween speed",optional=true},
run=function(b,c)

b.privateEnv.tweenSpeed=c:nextValue()
end
}end a.be=function()local c=a.cache.be if not c then c={c=b()}a.cache.be=c end return c.c end end do local b=function()

local b=a.ak()local c=function(


c)
local d=c:collectGarbage"loopgoto"
if d and d.id then
c.loopService:remove(d.id)
end end local d=function(



d)
for e,f in d do
if f.Character then
return f.Character
end
end
return nil end local e=function(



e)
local f=e:GetPivot()
local g=f.Position
return CFrame.new(g+f.LookVector*3,g)end


return{
{
action="goto|to",
description="Go to a player",
args={kind="player"},
run=function(f,g)
local h=d(b(g:nextValue()))
if not h then return end

f.playerService:waitForStreamPlayerCharacter(h)
f.playerService:teleportTo(e(h))
end
},
{
action="tweengoto|tgoto|tweento|tto",
description="Tween to a player (bypasses some anti cheats)",
args={
{kind="player"},
{
kind="number",
name="tween speed",
optional=true
}
},
run=function(f,g)
local h=d(b(g:nextValue()))
if not h then return end

local i=g:nextValue()or f.privateEnv.tweenSpeed
f.playerService:tweenTeleportTo{
target=e(h),
speed=i
}
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
run=function(f,g)
c(f)

local h=b(g:nextValue())[1]
local i=g:nextValue()or 3
local j=g:nextValue()or 0
if not h then return end

f.playerService:unseat()

local k=f:createGarbage"loopgoto"
k.id=f.loopService:add(function()
if h.Parent==nil then
c(f)
return
end

local l=h.Character
if l then
f.playerService:setRootCFrame(l:GetPivot()+Vector3.new(i,1,0))
end
end,j)
end
},
{
action="unloopgoto|noloopgoto",
description="Stops teleporting you to a player",
run=function(f)
c(f)
end
}
}end a.bf=function()local c=a.cache.bf if not c then c={c=b()}a.cache.bf=c end return c.c end end do local b=function()

local b=a.ak()

return{
action="vehiclegoto|vgoto|vehicletp|vtp",
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
i:PivotTo(h:GetPivot())
end
end
}end a.bg=function()local c=a.cache.bg if not c then c={c=b()}a.cache.bg=c end return c.c end end do local b=function()

local b=a.ak()

return{
action="pulsetp|ptp",
description="Teleports you to a player for a specified amount of time",
args={
{
kind="player"
},
{
kind="number",
name="time amount",
optional=true
}
},
run=function(c,d)
local e=b(d:nextValue())[1]
local f=d:nextValue()or 1

local g=e and e.Character and e.Character:FindFirstChild"HumanoidRootPart"
if not g then return end

local h=c.playerService:getRootPart()
if not h then return end
local i=h.CFrame

c.playerService:teleportTo(g.CFrame+Vector3.new(3,1,0))
task.wait(f)

c.playerService:setRootCFrame(i)
end
}end a.bh=function()local c=a.cache.bh if not c then c={c=b()}a.cache.bh=c end return c.c end end do local b=function()

local b=a.ak()local c=function(


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
action="unloopbring|noloopbring",
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
}end a.bi=function()local c=a.cache.bi if not c then c={c=b()}a.cache.bi=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.bj=function()local c=a.cache.bj if not c then c={c=b()}a.cache.bj=c end return c.c end end do local b=function()local b=function(


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
}end a.bk=function()local c=a.cache.bk if not c then c={c=b()}a.cache.bk=c end return c.c end end do local b=function()local b=function(

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
}end a.bl=function()local c=a.cache.bl if not c then c={c=b()}a.cache.bl=c end return c.c end end do local b=function()

return{
{
action="tpposition|tppos",
description="Teleports you to certain coordinates",
args={kind="vector3"},
run=function(b,c)
b.playerService:teleportTo(c:nextValue())
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
run=function(b,c)
local d=c:nextValue()
local e=c:nextValue()or b.privateEnv.tweenSpeed

b.playerService:tweenTeleportTo{
target=d,
speed=e
}
end
},
{
action="offset",
description="Offsets you by certain coordinates",
args={kind="vector3"},
run=function(b,c)
local d=b.playerService:getCharacter()
if d then
d:TranslateBy(c:nextValue())
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
run=function(b,c)
local d=c:nextValue()
local e=c:nextValue()or b.privateEnv.tweenSpeed

local f=b.playerService:getRootPart()
if not f then return end

b.playerService:tweenTeleportTo{
target=f.Position+d,
speed=e
}
end
},
{
action="thru",
description="Teleports you [num] studs ahead of where your character is facing",
args={
kind="number",
optional=true
},
run=function(b,c)
local d=c:nextValue()or 5
local e=b.playerService:getRootPart()
if not e then return end

local f=e.CFrame.LookVector
local g=e.CFrame.Position+f*d
b.playerService:teleportTo(CFrame.new(g,g+f))
end
}
}end a.bm=function()local c=a.cache.bm if not c then c={c=b()}a.cache.bm=c end return c.c end end do local b=function()

local b=a.ak()local c=function(


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
action="getposition|getpos",
description="Notifies you the coordinates of a player",
args={
kind="player"
},
run=function(d,e)
for f,g in b(e:nextValue())do
local h=c(d,g.Name)
d:notify(`{g.Name} Position`,h or"character is not loaded")
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
}end a.bn=function()local c=a.cache.bn if not c then c={c=b()}a.cache.bn=c end return c.c end end do local b=function()

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
}end a.bo=function()local c=a.cache.bo if not c then c={c=b()}a.cache.bo=c end return c.c end end do local b=function()local b=function(

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

c.playerService:setRootCFrame(g.cframe)
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
}end a.bp=function()local c=a.cache.bp if not c then c={c=b()}a.cache.bp=c end return c.c end end do local b=function()

local b=a.I()
local c=a.ai()

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

f.playerService:teleportTo(d)
end
}end a.bq=function()local c=a.cache.bq if not c then c={c=b()}a.cache.bq=c end return c.c end end do local b=function()local b=function(

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
c.playerService:setRootCFrame(g.CFrame*CFrame.new(j.X,k.Size.Z/2+i.HipHeight,j.Z))
else
c.playerService:setRootCFrame(g.CFrame*CFrame.new(j.X,g.Size.Y/2+i.HipHeight,j.Z))
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
}end a.br=function()local c=a.cache.br if not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()

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
b.playerService:teleportTo(CFrame.new(g)*(e.CFrame-e.CFrame.Position))
end)
end
}end a.bs=function()local c=a.cache.bs if not c then c={c=b()}a.cache.bs=c end return c.c end end do local b=function()local b=function(



b, c, d)
b.playerService:unseat()
task.wait(b.privateEnv.gotopartDelay or 0.1)

if d then
b.playerService:tweenTeleportTo{
target=c,
speed=b.privateEnv.tweenSpeed
}
else
b.playerService:setRootCFrame(c)
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
}end a.bt=function()local c=a.cache.bt if not c then c={c=b()}a.cache.bt=c end return c.c end end do local b=function()

return{
action="mouseteleport|mousetp",
description="Teleports you to the spot your mouse is pointing at",
run=function(b)
local c=b.playerService:getRootPart()
local d=b.playerService:getMouse()
if not(c and d.Hit)then return end


local e=d.Hit.Position+Vector3.new(0,3,0)
b.playerService:teleportTo(CFrame.new(e)*(c.CFrame-c.CFrame.Position))
end
}end a.bu=function()local c=a.cache.bu if not c then c={c=b()}a.cache.bu=c end return c.c end end do local b=function()local b=function(

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
}end a.bv=function()local c=a.cache.bv if not c then c={c=b()}a.cache.bv=c end return c.c end end do local b=function()




local b=a.ak()
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
}end a.bw=function()local c=a.cache.bw if not c then c={c=b()}a.cache.bw=c end return c.c end end do local b=function()

return{a.be()
,a.bf()
,a.bg()
,a.bh()
,a.bi()
,a.bj()
,a.bk()
,a.bl()
,a.bm()
,a.bn()
,a.bo()
,a.bp()
,a.bq()
,a.br()
,a.bs()
,a.bt()
,a.bu()
,a.bv()
,a.bw()

}end a.bx=function()local c=a.cache.bx if not c then c={c=b()}a.cache.bx=c end return c.c end end do local b=function()

return a.k().new"storage/installedPlugins"end a.by=function()local c=a.cache.by if not c then c={c=b()}a.cache.by=c end return c.c end end do local b=function()
return a.k().new("storage/.userData",{
encrypt=true
})end a.bz=function()local c=a.cache.bz if not c then c={c=b()}a.cache.bz=c end return c.c end end do local b=function()
return a.k().new"storage/aliases"end a.bA=function()local c=a.cache.bA if not c then c={c=b()}a.cache.bA=c end return c.c end end do local b=function()
return a.k().new"storage/totalUsedCommands"end a.bB=function()local c=a.cache.bB if not c then c={c=b()}a.cache.bB=c end return c.c end end do local b=function()
return a.k().new"storage/eventBinds"end a.bC=function()local c=a.cache.bC if not c then c={c=b()}a.cache.bC=c end return c.c end end do local b=function()

return{
waypoints=a.ba(),
plugins=a.by(),
settings=a.l(),
user=a.bz(),
aliases=a.bA(),
usedCmds=a.bB(),
eventBinds=a.bC()
}end a.bD=function()local c=a.cache.bD if not c then c={c=b()}a.cache.bD=c end return c.c end end do local b=function()




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


return c end a.bE=function()local c=a.cache.bE if not c then c={c=b()}a.cache.bE=c end return c.c end end do local b=function()






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


return d end a.bF=function()local c=a.cache.bF if not c then c={c=b()}a.cache.bF=c end return c.c end end do local b=function()






local b=a.h()
local c=a.a()
local d=a.j()
local e=a.bD()
local f=a.d()
local g=a.I()
local h=a.bE()
local i=a.bF()

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

local w=`{v}/logs/{s}/{os.time()}.txt`
local x,y=pcall(t,w,table.concat(u,"\n"))
if x then
return true,w
end
return false,tostring(y)end


return m end a.bG=function()local c=a.cache.bG if not c then c={c=b()}a.cache.bG=c end return c.c end end do local b=function()

local b=a.bG()

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
}end a.bH=function()local c=a.cache.bH if not c then c={c=b()}a.cache.bH=c end return c.c end end do local b=function()

local b=a.bE()
local c=a.ak()

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
}end a.bI=function()local c=a.cache.bI if not c then c={c=b()}a.cache.bI=c end return c.c end end do local b=function()

local b=a.h()
local c=a.bE()local d=function(


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
}end a.bJ=function()local c=a.cache.bJ if not c then c={c=b()}a.cache.bJ=c end return c.c end end do local b=function()

local b=a.h()
local c=a.bE()local d=function(

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
}end a.bK=function()local c=a.cache.bK if not c then c={c=b()}a.cache.bK=c end return c.c end end do local b=function()

local b=a.h()
local c=a.ak()local d=function()



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
}end a.bL=function()local c=a.cache.bL if not c then c={c=b()}a.cache.bL=c end return c.c end end do local b=function()

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
}end a.bM=function()local c=a.cache.bM if not c then c={c=b()}a.cache.bM=c end return c.c end end do local b=function()

local b=a.ak()

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
}end a.bN=function()local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do local b=function()

return{a.bH()
,a.bI()
,a.bJ()
,a.bK()
,a.bL()
,a.bM()
,a.bN()

}end a.bO=function()local c=a.cache.bO if not c then c={c=b()}a.cache.bO=c end return c.c end end do local b=function()









local b=a.h()
local c=a.aj()
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


return m end a.bP=function()local c=a.cache.bP if not c then c={c=b()}a.cache.bP=c end return c.c end end do local b=function()






local b=a.bP()
local c=a.ak()
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
}end a.bQ=function()local c=a.cache.bQ if not c then c={c=b()}a.cache.bQ=c end return c.c end end do local b=function()local b=function(


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
}end a.bR=function()local c=a.cache.bR if not c then c={c=b()}a.cache.bR=c end return c.c end end do local b=function()local b=function(



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
}end a.bS=function()local c=a.cache.bS if not c then c={c=b()}a.cache.bS=c end return c.c end end do local b=function()local b=function(


b, c)
local d=pcall(function()
settings():GetService"RenderSettings".ShowBoundingBoxes=c
end)

if not d then
b:notify("Hitboxes","this executor cannot change the hitbox display")
end end


return{
{
client=true,
action="hitboxes|showhitboxes",
description="Shows player hitboxes (CLIENT)",
run=function(c)
b(c,true)
end
},
{
client=true,
action="unhitboxes|nohitboxes|unshowhitboxes",
description="Hides player hitboxes (CLIENT)",
run=function(c)
b(c,false)
end
}
}end a.bT=function()local c=a.cache.bT if not c then c={c=b()}a.cache.bT=c end return c.c end end do local b=function()

return{a.bQ()
,a.bR()
,a.bS()
,a.bT()

}end a.bU=function()local c=a.cache.bU if not c then c={c=b()}a.cache.bU=c end return c.c end end do local b=function()

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

return d end a.bV=function()local c=a.cache.bV if not c then c={c=b()}a.cache.bV=c end return c.c end end do local b=function()
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


return d()end a.bW=function()local c=a.cache.bW if not c then c={c=b()}a.cache.bW=c end return c.c end end do local aa=function()










local b=a.h()
local c=a.bV()
local d=a.bW()

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


local s=math.rad(89)
local t=0.75
local u=0.01
local v=4
local w=0.25
local x=0.1
local y=512

local z=1
local A=64
local B=24
local C=40 local D=function()


return Enum.ContextActionResult.Sink end local E=function(



E)
return{
position=E,
velocity=E*0,
}end local F=function(


F, G, H)
local I=q*2*math.pi
local J=H-F.position
local K=math.exp(-I*G)

local L=H+(F.velocity*G-J*(I*G+1))*K
local M=(I*G*(J*I-F.velocity)+F.velocity)*K

F.position=L
F.velocity=M

return L end local G=function(



G, H)
local I=f:IsKeyDown(G)and 1 or 0
local J=f:IsKeyDown(H)and 1 or 0
return I-J end local H=function(



H, I, J)
local K=H.ViewportSize
local L=2*math.tan(math.rad(J)/2)
local M=K.X/K.Y*L

local N=y
local O=I.LookVector

for P=0,1,0.5 do
for Q=0,1,0.5 do
local R=I.RightVector*((P-0.5)*M)
-I.UpVector*((Q-0.5)*L)
+I.LookVector

local S=R.Unit
local T=I.Position+R*x
local U=workspace:Raycast(T,S*y)
local V=U and(U.Position-T).Magnitude or y

if V<N then
N=V
O=S
end
end
end

return I.LookVector:Dot(O)*N end local I=function(






I, J)
if not I then return Vector3.zero end

local K=Vector3.new(-math.sin(J),0,-math.cos(J))
local L=Vector3.new(math.cos(J),0,-math.sin(J))
local M=I.MoveDirection
return Vector3.new(M:Dot(L),0,-M:Dot(K))end local J=function(


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
Size=UDim2.fromOffset(A,A),
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


P("rise","UP",UDim2.new(1,-B,1,-C-A-12))
P("fall","DOWN",UDim2.new(1,-B,1,-C))
P("boost","BOOST",UDim2.new(1,-B-A-12,1,-C))

local Q=K("TextButton",O,{
Name="Close",
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-B,0,B),
Size=UDim2.fromOffset(A,A),
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
R.navMultiplier+S*G(Enum.KeyCode.Up,Enum.KeyCode.Down)*t,
u,
v
)


local U=Q.playerService:getHumanoid()
local V=if c then I(U,R.rotation.Y)else Vector3.zero
if c and U then
U.Jump=false
end

local W=R.holds.rise and 1 or 0
local X=R.holds.fall and 1 or 0
local Y=Vector3.new(
G(Enum.KeyCode.D,Enum.KeyCode.A)+V.X,
G(Enum.KeyCode.E,Enum.KeyCode.Q)+W-X,
G(Enum.KeyCode.S,Enum.KeyCode.W)+V.Z
)

local Z=f:IsKeyDown(Enum.KeyCode.LeftShift)and w or 1
local _=if R.holds.boost then g.getBoost(Q)else 1
local aa=(Q.privateEnv.freecamSpeed or g.DEFAULT_SPEED)*R.navMultiplier*Z*_
local ab=F(R.velocitySpring,S,Y*aa)

local ac=F(R.panSpring,S,R.mouseDelta*r)
R.mouseDelta=Vector2.zero


local ad=math.sqrt(math.tan(math.rad(o/2))/math.tan(math.rad(R.fieldOfView/2)))
local ae=R.rotation+ac*Vector2.new(0.75,1)*8*(S/ad)
R.rotation=Vector2.new(
math.clamp(ae.X,-s,s),
ae.Y%(2*math.pi)
)

local af=CFrame.fromOrientation(R.rotation.X,R.rotation.Y,0)
local ag=CFrame.new(R.position)*af*CFrame.new(ab*p*S)
R.position=ag.Position

T.CFrame=ag
if R.anchor then
R.anchor.CFrame=ag
end
T.Focus=ag*CFrame.new(0,0,-H(T,ag,R.fieldOfView))
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
R.velocitySpring=E(Vector3.zero)
R.panSpring=E(Vector2.zero)

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


e:BindActionAtPriority(j,D,false,l,table.unpack(n))
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
R.mouseDelta=R.mouseDelta+Vector2.new(-T.Delta.Y,-T.Delta.X)*z
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


return g end a.bX=function()local ab=a.cache.bX if not ab then ab={c=aa()}a.cache.bX=ab end return ab.c end end do local aa=function()

local aa=a.ak()
local ab=a.bX()local ac=function(


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
}end a.bY=function()local ab=a.cache.bY if not ab then ab={c=aa()}a.cache.bY=ab end return ab.c end end do local aa=function()

local aa=a.ak()
local ab=a.bX()

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
action="freecamgoto|fcgoto|freecamtp|fctp",
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
action="unfreecam|unfc|nofreecam|nofc",
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
}end a.bZ=function()local ab=a.cache.bZ if not ab then ab={c=aa()}a.cache.bZ=ab end return ab.c end end do local aa=function()

return{
{
action="gotocamera|gotocam|tocam",
description="Teleports you to the location of your camera",
run=function(aa)
aa.playerService:teleportTo(aa.playerService:getCamera().CFrame)
end
},
{
action="tweengotocamera|tweengotocam|tgotocamera|tgotocam",
description="Tweens you to the location of your camera",
run=function(aa)
aa.playerService:tweenTeleportTo{
target=aa.playerService:getCamera().CFrame,
speed=aa.privateEnv.tweenSpeed
}
end
}
}end a.b_=function()local ab=a.cache.b_ if not ab then ab={c=aa()}a.cache.b_=ab end return ab.c end end do local aa=function()

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
}end a.b0=function()local ab=a.cache.b0 if not ab then ab={c=aa()}a.cache.b0=ab end return ab.c end end do local aa=function()local aa=function(


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
}end a.b1=function()local ab=a.cache.b1 if not ab then ab={c=aa()}a.cache.b1=ab end return ab.c end end do local aa=function()

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
}end a.b2=function()local ab=a.cache.b2 if not ab then ab={c=aa()}a.cache.b2=ab end return ab.c end end do local aa=function()

return{
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(aa,ab)
local ac=math.clamp(math.abs(ab:nextValue()or 70),1,120)
workspace.CurrentCamera.FieldOfView=ac
end
}end a.b3=function()local ab=a.cache.b3 if not ab then ab={c=aa()}a.cache.b3=ab end return ab.c end end do local aa=function()

local aa=a.bX()

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
}end a.b4=function()local ab=a.cache.b4 if not ab then ab={c=aa()}a.cache.b4=ab end return ab.c end end do local aa=function()

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
}end a.b5=function()local ab=a.cache.b5 if not ab then ab={c=aa()}a.cache.b5=ab end return ab.c end end do local aa=function()

local aa=a.ak()


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
}end a.b6=function()local ab=a.cache.b6 if not ab then ab={c=aa()}a.cache.b6=ab end return ab.c end end do local aa=function()

local aa=a.ak()local ab=function(

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
}end a.b7=function()local ab=a.cache.b7 if not ab then ab={c=aa()}a.cache.b7=ab end return ab.c end end do local aa=function()

return{a.bY()
,a.bZ()
,a.b_()
,a.b0()
,a.b1()
,a.b2()
,a.b3()
,a.b4()
,a.b5()
,a.b6()
,a.b7()

}end a.b8=function()local ab=a.cache.b8 if not ab then ab={c=aa()}a.cache.b8=ab end return ab.c end end do local aa=function()


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
}end a.b9=function()local ab=a.cache.b9 if not ab then ab={c=aa()}a.cache.b9=ab end return ab.c end end do local aa=function()local aa=function(






aa, ab)
local ac={}

for ad in aa do
ac[ad:lower()]=true
end

if not ac[ab:lower()]then
return ab
end

local ad=1
while ac[ab:lower()..ad]do
ad=ad+1
end

return ab..ad end local ab=function(



ab, ac)
local ad=ab.storage.waypoints
local ae=ad:register(tostring(game.PlaceId),{})

local af=aa(ae,ac.Name)
ae[af]=ab:stringify(ac.Position)
ad:save()

return af end


return{
{
action="partname|partpath",
description="Opens a window: click a part to see its path & name, then Select Part saves it as a waypoint",
run=function(ac)
ac.infiniteYield:openPartPath(function(ad)
local ae=ab(ac,ad)
ac:notify("Modified Waypoints","Created waypoint: "..ae)
end)
end
}
}end a.ca=function()local ab=a.cache.ca if not ab then ab={c=aa()}a.cache.ca=ab end return ab.c end end do local aa=function()local aa=function(


aa, ab, ac)
if ab==false then
aa:notify("Delete","cancelled: "..ac)
return false
end
return true end


return{
{
client=true,
action="delete|remove",
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
}end a.cb=function()local ab=a.cache.cb if not ab then ab={c=aa()}a.cache.cb=ab end return ab.c end end do local aa=function()




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
}end a.cc=function()local ab=a.cache.cc if not ab then ab={c=aa()}a.cache.cc=ab end return ab.c end end do local aa=function()

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
}end a.cd=function()local ab=a.cache.cd if not ab then ab={c=aa()}a.cache.cd=ab end return ab.c end end do local aa=function()local aa=function(

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
}end a.ce=function()local ab=a.cache.ce if not ab then ab={c=aa()}a.cache.ce=ab end return ab.c end end do local aa=function()

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
}end a.cf=function()local ab=a.cache.cf if not ab then ab={c=aa()}a.cache.cf=ab end return ab.c end end do local aa=function()

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
}end a.cg=function()local ab=a.cache.cg if not ab then ab={c=aa()}a.cache.cg=ab end return ab.c end end do local aa=function()local aa=function(

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
action="fireclickdetectors|firecd|firecds",
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
}end a.ch=function()local ab=a.cache.ch if not ab then ab={c=aa()}a.cache.ch=ab end return ab.c end end do local aa=function()
local aa=a.ak()local ab=function(


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
action="freezeunanchored|freezeua|animsunanchored",
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
}end a.ci=function()local ab=a.cache.ci if not ab then ab={c=aa()}a.cache.ci=ab end return ab.c end end do local aa=function()

return{a.b9()
,a.ca()
,a.cb()
,a.cc()
,a.cd()
,a.ce()
,a.cf()
,a.cg()
,a.ch()
,a.ci()

}end a.cj=function()local ab=a.cache.cj if not ab then ab={c=aa()}a.cache.cj=ab end return ab.c end end do local aa=function()local aa=function(

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
}end a.ck=function()local ab=a.cache.ck if not ab then ab={c=aa()}a.cache.ck=ab end return ab.c end end do local aa=function()

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
}end a.cl=function()local ab=a.cache.cl if not ab then ab={c=aa()}a.cache.cl=ab end return ab.c end end do local aa=function()

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
}end a.cm=function()local ab=a.cache.cm if not ab then ab={c=aa()}a.cache.cm=ab end return ab.c end end do local aa=function()

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
}end a.cn=function()local ab=a.cache.cn if not ab then ab={c=aa()}a.cache.cn=ab end return ab.c end end do local aa=function()

return{
client=true,
action="brightness",
description="Changes the brightness lighting property",
args={kind="number"},
run=function(aa,ab)
aa.robloxServices.Lighting.Brightness=ab:nextValue()
end
}end a.co=function()local ab=a.cache.co if not ab then ab={c=aa()}a.cache.co=ab end return ab.c end end do local aa=function()

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
action="noglobalshadows|nogshadows|unglobalshadows",
description="Disables global shadows",
run=function(aa)
aa.robloxServices.Lighting.GlobalShadows=false
end
}
}end a.cp=function()local ab=a.cache.cp if not ab then ab={c=aa()}a.cache.cp=ab end return ab.c end end do local aa=function()

local aa=a.b()
local ab=a.ak()


local ac=a.h().Lighting

local ad={"Ambient","OutdoorAmbient","Brightness","ClockTime","FogEnd","FogStart","GlobalShadows"}
local ae={}local af=function()


for af,ag in ae do
ac[af]=ag
end end local ag=function()



if aa.originalLighting then
ae=aa.originalLighting
return
end

for ag,b in ad do
ae[b]=ac[b]
end

aa.originalLighting=ae end


ag()

return{
{
action="restorelighting|rlighting",
description="Restores Lighting properties",
run=af
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
run=function(b,c)
local d=ab(c:nextValue())
local e=c:nextValue()or 10

for f,g in d do
local h=g.Character and g.Character:FindFirstChild"HumanoidRootPart"
if not h then return end

local i=Instance.new"PointLight"
i.Range=e
i.Brightness=5
i.Parent=h

table.insert(b:registerGarbage"dynamicLights",i)
end
end
},
{
action="nolight|unlight",
description="Removes dynamic light from your player",
run=function(b)
for c,d in b:collectGarbage"dynamicLights"or{}do
d:Destroy()
end

local c=b.playerService:getCharacter()
if c then
for d,e in c:GetDescendants()do
if e:IsA"PointLight"then
e:Destroy()
end
end
end
end
}
}end a.cq=function()local ab=a.cache.cq if not ab then ab={c=aa()}a.cache.cq=ab end return ab.c end end do local aa=function()

return{a.ck()
,a.cl()
,a.cm()
,a.cn()
,a.co()
,a.cp()
,a.cq()

}end a.cr=function()local ab=a.cache.cr if not ab then ab={c=aa()}a.cache.cr=ab end return ab.c end end do local aa=function()





local aa=a.bA()

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


return ab end a.cs=function()local ab=a.cache.cs if not ab then ab={c=aa()}a.cache.cs=ab end return ab.c end end do local aa=function()

local aa=a.cs()

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
}end a.ct=function()local ab=a.cache.ct if not ab then ab={c=aa()}a.cache.ct=ab end return ab.c end end do local aa=function()




















local aa=a.a()
local ab=a.j()
local ac=a.by()

local ad={}

local ae=".luau"
local af=`{ab.privateFolder}/plugins`

ad.FOLDER=af


local ag={}


local b={}local c=function(

c, d)
local e=table.find(c,d)
if e then
table.remove(c,e)
end end local d=function(



d)
local e=d
if e:sub(-#ae)==ae then
e=e:sub(1,-#ae-1)
end

if e:match"^[%w_%-]+$"then
return e
end
return nil end local e=function(


e)
return`{af}/{e}{ae}`end local f=function(


f)
if aa.readfile==nil or aa.isfile==nil then
return nil,"your exploit does not support readfile"
end

local g=e(f)

local h,i=pcall(aa.isfile,g)
if not(h and i)then
return nil,`file not found: {g}`
end

local j,k=pcall(aa.readfile,g)
if not(j and type(k)=="string")then
return nil,`could not read {g}`
end

return k end local g=function(



g)
if aa.loadstring==nil then
return nil,"your exploit does not support loadstring"
end

local h,i,j=pcall(aa.loadstring,g)
if not h then
return nil,tostring(i)
end
if not i then
return nil,tostring(j)
end

local k,l=pcall(i)
if not k then
return nil,`error while loading the plugin: {l}`
end
if type(l)~="table"then
return nil,"the plugin must return a table of commands"
end

return l end local h=function(




h)
local i=h
if type(h.action)=="string"then
i={h}
end

local j={}

for k,l in i do
if type(l)~="table"or type(l.action)~="string"then
return nil,"every command needs an action string"
end

if l.run~=nil and type(l.run)~="function"then
return nil,`run of '{l.action}' must be a function`
end

local m={}
for n,o in l.action:split"|"do
local p=o:lower()
if p==""then
return nil,`empty name in '{l.action}'`
end
table.insert(m,p)
end


local n={}
for o,p in l do
n[o]=p
end

local o=n.args or{}
if#o==0 and next(o)then
o={o}
end
n.args=o

local p=table.clone(m)
table.sort(p,function(q,r)
return#q<#r
end)

n.name=m[1]
n.aliases=p
n.action=nil

table.insert(j,{entry=n,names=m})
end

if#j==0 then
return nil,"the plugin has no commands"
end

return j end local i=function(



i, j)
local k,l=f(j)
if not k then
return false,l
end

local m,n=g(k)
if not m then
return false,n
end

local o,p=h(m)
if not o then
return false,p
end

local q={}
local r={}

for s,t in o do
for u,v in t.names do
if i.lookup[v]~=nil or r[v]then
return false,`'{v}' is already a command or an alias`
end
r[v]=true
table.insert(q,v)
end
end

for s,t in o do
for u,v in t.names do
i.lookup[v]=t.entry
table.insert(i.array,v)
end
end

ag[j]={keys=q,commands=#o}
return true,#o end local j=function(



j, k)
local l,m=i(j,k)

b[k]=if l then nil else tostring(m)
return l,m end local k=function(


k, l)
local m=ag[l]
if not m then return end

for n,o in m.keys do
k.lookup[o]=nil
c(k.array,o)
end

ag[l]=nil end



ad.add=function(l, m)
local n=d(m)
if not n then
return false,"plugin names can only use letters, numbers, '_' and '-'"
end

if ag[n]then
return false,`'{n}' is already loaded`
end

local o,p=j(l,n)
if not o then
return false,p
end

ac.object[n]=n..ae
ac:save()

return true,p end



ad.remove=function(l, m)
if ac.object[m]==nil and ag[m]==nil then
return false
end

k(l,m)
b[m]=nil

ac.object[m]=nil
ac:save()

return true end



ad.reload=function(l, m)
if ac.object[m]==nil then
return false,`'{m}' is not installed`
end

k(l,m)
return j(l,m)end




ad.restore=function(l)
local m={}

for n in ac.object do
if not ag[n]then
local o,p=j(l,n)
if not o then
m[n]=tostring(p)
end
end
end

return m end



ad.addAll=function(l)
if aa.listfiles==nil then
return nil,"your exploit does not support listfiles"
end

local m,n=pcall(aa.listfiles,af)
if not(m and type(n)=="table")then
return nil,`could not read the folder {af} (create it and put your .luau plugins there)`
end

local o={added={},failed={}}

for p,q in n do
local r=type(q)=="string"and q:match"([^/\\]+)%.luau$"

if r and not ag[r]then
local s,t=ad.add(l,r)
if s then
table.insert(o.added,r)
else
table.insert(o.failed,`{r}: {t}`)
end
end
end

return o end




ad.getInstalled=function()
local l={}

for m in ac.object do
local n=ag[m]

table.insert(l,{
name=m,
loaded=n~=nil,
commands=if n then n.commands else 0,
error=if n then nil else b[m],
})
end

table.sort(l,function(m,n)
return m.name:lower()<n.name:lower()
end)

return l end




ad.getAvailable=function()
if aa.listfiles==nil then
return nil,"your exploit does not support listfiles"
end

local l,m=pcall(aa.listfiles,af)
if not(l and type(m)=="table")then
return nil,`could not read the folder {af} (create it and put your .luau plugins there)`
end

local n={}

for o,p in m do
local q=type(p)=="string"and p:match"([^/\\]+)%.luau$"

if q and d(q)and ac.object[q]==nil then
table.insert(n,q)
end
end

table.sort(n,function(o,p)
return o:lower()<p:lower()
end)

return n end


return ad end a.cu=function()local ab=a.cache.cu if not ab then ab={c=aa()}a.cache.cu=ab end return ab.c end end do local aa=function()

local aa=a.cu()

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
}end a.cv=function()local ab=a.cache.cv if not ab then ab={c=aa()}a.cache.cv=ab end return ab.c end end do local aa=function()

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
commands=a.az()
},
{
name="character",
commands=a.a9()
},
{
name="waypoints",
commands=a.bd()
},
{
name="teleport",
commands=a.bx()
},
{
name="communication",
commands=a.bO()
},
{
name="visual",
commands=a.bU()
},
{
name="camera",
commands=a.b8()
},
{
name="workspace",
commands=a.cj()
},
{
name="lighting",
commands=a.cr()
},
{
name="aliases",
commands=a.ct()
},
{
name="plugins",
commands=a.cv()
}
}end a.cw=function()local ab=a.cache.cw if not ab then ab={c=aa()}a.cache.cw=ab end return ab.c end end do local aa=function()

































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































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


return ab end a.cx=function()local ab=a.cache.cx if not ab then ab={c=aa()}a.cache.cx=ab end return ab.c end end do local aa=function()
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


return aa end a.cy=function()local ab=a.cache.cy if not ab then ab={c=aa()}a.cache.cy=ab end return ab.c end end do local aa=function()

return{}end a.cz=function()local ab=a.cache.cz if not ab then ab={c=aa()}a.cache.cz=ab end return ab.c end end do local aa=function()
local aa=a.cz()
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


return ac end a.cA=function()local ab=a.cache.cA if not ab then ab={c=aa()}a.cache.cA=ab end return ab.c end end do local aa=function()
local aa=a.n()
local ab=a.d()

local ac=aa.owner
local ad=aa.repository

local ae=`https://raw.githubusercontent.com/{ac}/{ad}/refs/heads/main/`
local af=`https://github.com/{ac}/{ad}/releases/latest/download/`

local ag={}local b=function(

b)
return game:HttpGet(b)end local c=function(


c)
if c:sub(1,1)=="/"then
return c:sub(2)
end

return c end local d=function(


d, e)
local f=d..c(e)
local g,h=pcall(b,f)

if not g then
ab:warn(`failed to fetch http url '{f}':\n\t{h}`)
return nil
end

if type(h)~="string"or#h==0 then
ab:warn(`empty response from '{f}'`)
return nil
end

return h end


ag.download=function(e)
return d(af,e)end



ag.downloadUrl=function(e)
return af..c(e)end


ag.fetch=function(e)
return d(ae,e)end


ag.load=function(e, f)
local g=ag.fetch(e)
if g==nil then return nil end

local h,i=loadstring(g,f)
if h==nil then
ab:warn(`failed to compile '{e}':\n\t{i}`)
return nil
end

return h end


return ag end a.cB=function()local ab=a.cache.cB if not ab then ab={c=aa()}a.cache.cB=ab end return ab.c end end do local aa=function()
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


return ac end a.cC=function()local ab=a.cache.cC if not ab then ab={c=aa()}a.cache.cC=ab end return ab.c end end do local aa=function()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cD=function()local ab=a.cache.cD if not ab then ab={c=aa()}a.cache.cD=ab end return ab.c end end do local aa=function()
local aa=a.cD()

local ab={}

ab.getScale=function(ac, ad)
return aa.isEnabled and(ad*aa.animationScale)or 0 end


ab.getScrollSpeed=function(ac, ad)
return(ad*aa.scrollSpeed)end


return ab end a.cE=function()local ab=a.cache.cE if not ab then ab={c=aa()}a.cache.cE=ab end return ab.c end end do local aa=function()
return{
createService=a.cA(),
specialProps=a.cz(),

connectionService=a.I(),
fetchService=a.cB(),
keyboardService=a.L(),
localPlayer=a.ai(),
messageService=a.cC(),
playerService=a.aj(),
rbxServices=a.h(),
tweenService=a.cE(),
}end a.cF=function()local ab=a.cache.cF if not ab then ab={c=aa()}a.cache.cF=ab end return ab.c end end do local aa=function()

return{
DisplayName="Classic",

Font={
Normal=Enum.Font.BuilderSans,
Medium=Enum.Font.BuilderSansMedium,
Bold=Enum.Font.BuilderSansBold,
ExtraBold=Enum.Font.BuilderSansExtraBold,
MonoSpace=Enum.Font.RobotoMono,
},

Colors={
Background=Color3.fromRGB(36,36,37),
Primary=Color3.fromRGB(88,101,242),
OnPrimary=Color3.fromRGB(61,67,135),
Stroke=Color3.fromRGB(45,45,45),

Error=Color3.fromRGB(255,102,102),
Icons=Color3.fromRGB(232,233,235),

ScrollBar={
Thumb=Color3.fromRGB(78,78,79),
Arrow=Color3.fromRGB(232,233,235),
Background=Color3.fromRGB(26,26,26),
},

Buttons={
Holding=Color3.fromRGB(78,78,79),
Default=Color3.fromRGB(46,46,47),
},

Border={
Holding=Color3.fromRGB(60,60,60),
Default=Color3.fromRGB(38,38,38),
},

Text={
Default=Color3.new(1,1,1),
Dark=Color3.fromRGB(200,200,200),
Darker=Color3.fromRGB(175,175,175),
},

Slider={
SliderBar=Color3.fromRGB(1,76,105),
SliderNumber=Color3.fromRGB(232,233,235),
},
},
}end a.cG=function()local ab=a.cache.cG if not ab then ab={c=aa()}a.cache.cG=ab end return ab.c end end do local aa=function()

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
}end a.cH=function()local ab=a.cache.cH if not ab then ab={c=aa()}a.cache.cH=ab end return ab.c end end do local aa=function()
return{
DisplayName="Light"
}end a.cI=function()local ab=a.cache.cI if not ab then ab={c=aa()}a.cache.cI=ab end return ab.c end end do local aa=function()
local aa={a.cG()
,a.cH()
,a.cI()

}

local ab={}

for ac,ad in aa do
local ae=string.lower(ad.DisplayName)
ab[ae]=ad
end

return ab end a.cJ=function()local ab=a.cache.cJ if not ab then ab={c=aa()}a.cache.cJ=ab end return ab.c end end do local aa=function()
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


return aa end a.cK=function()local ab=a.cache.cK if not ab then ab={c=aa()}a.cache.cK=ab end return ab.c end end do local aa=function()
local aa=a.cJ()

local ab=a.d()
local ac=a.cK()

local ad={
objects={},
selectedTheme=nil
}


ad.isUsable=function(ae, af)
return af~=nil and af.Colors~=nil and af.Font~=nil end



ad.getThemes=function(ae)
local af={}

for ag,b in aa do
table.insert(af,{
key=ag,
name=b.DisplayName,
theme=b,
usable=ae:isUsable(b),
})
end

table.sort(af,function(ag,b)
return ag.name<b.name
end)

return af end


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




ad.removeObject=function(ae, af)
ae.objects[af]=nil end


ad.init=function(ae, af)
ab:expect(af,{"table"},"'themeService:init' #1")

if af.theme~=nil then
ae:selectTheme(af.theme)
end end


return ad end a.cL=function()local ab=a.cache.cL if not ab then ab={c=aa()}a.cache.cL=ab end return ab.c end end do local aa=function()


local aa=a.cF()
local ab=a.d()

local ac=aa.specialProps
local ad=a.cL()

ac.ThemeTag=function(ae, af)
if type(af)~="table"then
ab:error"expected a 'table' when setting a theme tag"
return
end

ad:addObject(ae,af)end


return a.cA()end a.cM=function()local ab=a.cache.cM if not ab then ab={c=aa()}a.cache.cM=ab end return ab.c end end do local aa=function()return{logo=104371861083126,close=83276213460768,minimize=76683704146139,["lucide-chevron-left"]=116084397950605,["lucide-blocks"]=80329404661557,["lucide-terminal"]=138735373900955,["lucide-pin"]=85638424763987,["lucide-refresh-cw"]=127184558868486,["lucide-tag"]=95367077436662,["lucide-keyboard"]=102097005397654,
["lucide-palette"]=105784737972091,
["lucide-map-pin"]=132787420207871,
["lucide-puzzle"]=139412930697283,
["lucide-zap"]=124181719324437,imgstudiopluginlogo=

4113050383,pin=
6234691350,reference=


116342494079103,settings=
102340652201372,
}end a.cN=function()local ab=a.cache.cN if not ab then ab={c=aa()}a.cache.cN=ab end return ab.c end end do local aa=function()



local aa=a.a()
local ab=a.p()

local ac=ab.storage.imagePath

local ad=a.k()
local ae=a.cB()
local af=a.d()

local ag=a.cN()

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
j=if type(j)=="number"then`rbxassetid://{j}`else j

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


return e end a.cO=function()local ab=a.cache.cO if not ab then ab={c=aa()}a.cache.cO=ab end return ab.c end end do local aa=function()
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
}end a.cP=function()local ab=a.cache.cP if not ab then ab={c=aa()}a.cache.cP=ab end return ab.c end end do local aa=function()



return{

defaultTime=5,
defaultTitle="Notification",



size=UDim2.fromOffset(250,100),
maxHeight=240,
cornerRadius=6,
titleHeight=20,
iconSize=11,


titleTextSize=14,
textSize=14,
padding=8,


spacing=4,
gapToWindow=0,
maxVisible=5,


actionHeight=22,
actionMinWidth=56,
actionPadding=12,
actionGap=4,
actionsTopGap=4,


tweenTime=0.5,
flashTime=0.5,
}end a.cQ=function()local ab=a.cache.cQ if not ab then ab={c=aa()}a.cache.cQ=ab end return ab.c end end do local aa=function()

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
d,
},
commands={undefined=
b,client=
ab,deprecated=
ae
}
}end a.cR=function()local ab=a.cache.cR if not ab then ab={c=aa()}a.cache.cR=ab end return ab.c end end do local aa=function()








local aa=a.cR().args
local ab=a.cK()

local ac={}


local ad=ab.charset":#()[]<>{}-––&*$%@"


local ae="^[%w_%.]+"


local af="^[%w_]+"local ag=function(

ag)
return ag~=""and string.match(ag,"[%w_%.]")~=nil end local b=function(


b)
return string.match(b,"^%d+$")~=nil or string.match(b,"^%d+%.%d+$")~=nil end local c=function(




c, d)
local e=string.sub(c,d,d)
local f=d+1

while f<=#c do
local g=string.sub(c,f,f)

if g=="\\"then
f=f+2
elseif g==e then
return f
else
f=f+1
end
end

return nil end local d=function(



d)
local e={}local f=function(

f, g, h)
if f==""then
return
end

local i=e[#e]
if i and i.color==g and i.bold==h then
i.text=i.text..f
else
table.insert(e,{text=f,color=g,bold=h})
end end


local g=1
local h=#d

while g<=h do
local i=string.sub(d,g,g)
local j=if g>1 then string.sub(d,g-1,g-1)else""


if(i=="@"or i=="#")and not ag(j)then
local k,l=string.find(d,af,g+1)
if l then
f(string.sub(d,g,l),aa.tag,true)
g=l+1
continue
end
end


if(i=='"'or i=="'")and not ag(j)then
local k=c(d,g)

if k then
f(string.sub(d,g,k),aa.string,false)
g=k+1
continue
end
end

if ag(i)then
local k,l=string.find(d,ae,g)
local m=string.sub(d,g,l)
f(m,if b(m)then aa.number else nil,false)
g=l+1
else
f(i,if ad[i]then aa.symbol else nil,false)
g=g+1
end
end

return e end


ac.apply=function(e, f)
local g={}

for h,i in d(tostring(f))do
local j=ab.escapeRichText(i.text)

if i.color then
j=ab.colorFromRGB(j,i.color)
end
if i.bold then
j=`<b>{j}</b>`
end

table.insert(g,j)
end

return table.concat(g)end


return ac end a.cS=function()local ab=a.cache.cS if not ab then ab={c=aa()}a.cache.cS=ab end return ab.c end end do local aa=function()



local aa=a.cM()
local ab=a.cO()
local ac=a.cL()
local ad=a.cP()

local ae=a.I()
local af=a.h()
local ag=a.cQ()

local b=a.cS()

local c=4
local d=8



local e=5
local f=5
local g=ag.titleHeight+e+f*2

local h={
container=nil,

items={},
nextOrder=0,

queue={},


room=math.huge,
}local i=function(

i, j)
local k=aa.new("Frame","Notification",i,{
BorderSizePixel=0,
ClipsDescendants=true,
LayoutOrder=j,
Size=UDim2.fromOffset(ag.size.X.Offset,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local l=c+ag.iconSize+d

local m=aa.new("TextLabel","Title",k,{
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0),
Size=UDim2.new(1,-l*2,0,ag.titleHeight),
Text="",
TextSize=ag.titleTextSize,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local n=aa.new("Frame","Description",k,{
AnchorPoint=Vector2.new(0.5,1),
ClipsDescendants=true,
Position=UDim2.new(0.5,0,1,-e),
Size=UDim2.new(1,-10,1,-(ag.titleHeight+e)),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})

aa.new("UICorner",n,{
CornerRadius=UDim.new(0,ag.cornerRadius),
})


local o=aa.new("TextLabel","Text",n,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=UDim2.fromOffset(f,f),
Size=UDim2.new(1,-f*2,0,0),
Text="",
TextSize=ag.textSize,
RichText=true,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

local p=aa.new("ImageButton","PinButton",k,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,c,0,ag.titleHeight/2),
Size=UDim2.fromOffset(ag.iconSize,ag.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local q=aa.new("ImageButton","CloseButton",k,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-c,0,ag.titleHeight/2),
Size=UDim2.fromOffset(ag.iconSize,ag.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(p,"pin")
ab:loadImage(q,"close")

return k,m,o,p,q,n end local j=function(




j, k, l)
local m=aa.new("Frame","Actions",j,{
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,1,-f),
Size=UDim2.new(1,-f*2,0,ag.actionHeight),
ZIndex=2,

aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,ag.actionGap),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local n={}

for o,p in k do
local q=p.primary==true

local r=aa.new("TextButton","Action",m,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
LayoutOrder=o,
Size=UDim2.fromOffset(0,ag.actionHeight),
Text=p.text,
TextSize=ag.textSize,
ZIndex=2,
ThemeTag={
BackgroundColor3=if p.primary then"Colors.Primary"else"Colors.Background",
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ag.cornerRadius),
}),
aa.new("UIPadding",{
PaddingLeft=UDim.new(0,ag.actionPadding),
PaddingRight=UDim.new(0,ag.actionPadding),
}),
aa.new("UISizeConstraint",{
MinSize=Vector2.new(ag.actionMinWidth,0),
}),
})local s=function(


s)
if q then
r.BackgroundTransparency=if s then 0.2 else 0
else
ac:updateObjectProperties(r,{
BackgroundColor3=if s then"Colors.Buttons.Holding"else"Colors.Background",
})
end end


table.insert(l,ae:Connect(r.MouseEnter,function()
s(true)
end))
table.insert(l,ae:Connect(r.MouseLeave,function()
s(false)
end))

n[o]=r
end

return n end local k=function(


k)
for l,m in k.connections do
ae:disconnect(m)
end

table.clear(k.connections)end


h.getContainer=function(l, m)
if l.container then
return l.container
end

local n=aa.new("Frame","Notifications",m,{
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(ag.size.X.Offset,0),
})

aa.new("UIListLayout",n,{
Padding=UDim.new(0,ag.spacing),
SortOrder=Enum.SortOrder.LayoutOrder,
})

l.container=n


n.ChildAdded:Connect(function()
l:refreshLayout()
end)

n.ChildRemoved:Connect(function()
l:refreshLayout()
end)

local o=l.queue
l.queue={}

for p,q in o do
l:add(q.title,q.message,q.duration,q.choices)
end

return n end



h.getStackHeight=function(l)
local m=l.container
if not m then return 0 end

local n=0
local o=0

for p,q in m:GetChildren()do
if q:IsA"GuiObject"then
n=n+1
o=o+q.Size.Y.Offset
end
end

if n>1 then
o=o+(n-1)*ag.spacing
end

return o end



h.refreshLayout=function(l)
local m=l.container
if not m then return end

m.Size=UDim2.fromOffset(ag.size.X.Offset,l:getStackHeight())

if l.onLayoutChanged then
l.onLayoutChanged()
end end


h.tweenHeight=function(l, m, n)
if m.tween then
m.tween:Cancel()
end

local o=TweenInfo.new(ag.tweenTime,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
m.tween=af.TweenService:Create(m.frame,o,{
Size=UDim2.fromOffset(ag.size.X.Offset,n),
})
m.tween:Play()end




h.wantedHeight=function(l, m)
local n=math.max(ad:getScale(),0.01)
local o=m.textLabel.AbsoluteSize.Y/n


local p=if m.actionsHeight>0 then 0 else ag.size.Y.Offset
local q=math.max(o+g+m.actionsHeight,p)
return math.min(q,ag.maxHeight,l.room)end



h.fitHeight=function(l, m, n)
if m.removed or not m.textLabel then return end

local o=l:wantedHeight(m)
if o==m.height then return end
m.height=o

if n then
if m.tween then
m.tween:Cancel()
end

m.frame.Size=UDim2.fromOffset(ag.size.X.Offset,o)
else
l:tweenHeight(m,o)
end end




h.setRoom=function(l, m)
if m==l.room then return end
l.room=m

for n,o in l.items do
l:fitHeight(o,true)
end

l:trimToRoom()end



h.liveHeight=function(l)
local m=0

for n,o in l.items do
m=m+o.height
end

if#l.items>1 then
m=m+(#l.items-1)*ag.spacing
end

return m end



h.trimToRoom=function(l)
while#l.items>1 and l:liveHeight()>l.room do
local m

for n,o in l.items do
if n==#l.items then break end

if not o.pinned then
m=o
break
end
end

if not m then break end
l:remove(m)
end end


h.pin=function(l, m)
if m.pinned or m.removed then return end
m.pinned=true

m.titleLabel.Text=m.title.." (Pinned)"
ac:addObject(m.pinButton,{ImageColor3="Colors.Primary"})

local n=m.titleLabel
task.spawn(function()
n.TextTransparency=0.5
task.wait(ag.flashTime)
n.TextTransparency=0
end)end


h.remove=function(l, m)
if m.removed then return end
m.removed=true

local n=table.find(l.items,m)
if n then
table.remove(l.items,n)
end

k(m)

l:tweenHeight(m,0)
task.delay(ag.tweenTime,function()
m.frame:Destroy()
end)end


h.trim=function(l)
while#l.items>ag.maxVisible do
local m

for n,o in l.items do
if not o.pinned then
m=o
break
end
end

if not m then break end
l:remove(m)
end end


h.add=function(l, m, n, o, p)
l.nextOrder=l.nextOrder+1

local q={
title=m,
pinned=false,
removed=false,
connections={},
height=ag.size.Y.Offset,
actionsHeight=if p then ag.actionHeight+ag.actionsTopGap+f else 0,
}

local r
q.frame,q.titleLabel,q.textLabel,q.pinButton,q.closeButton,r=
i(l.container,l.nextOrder)

q.titleLabel.Text=m
q.textLabel.Text=b:apply(n)

table.insert(q.connections,ae:Connect(q.pinButton.Activated,function()
l:pin(q)
end))



local s=p~=nil and type(o)~="number"

if s then
q.pinned=true
q.pinButton.Visible=false
end

if p then
local t=j(r,p,q.connections)

for u,v in t do
local w=p[u]

table.insert(q.connections,ae:Connect(v.Activated,function()
if q.removed then return end

l:remove(q)

if w.onTap then
w.onTap()
end
end))
end
end

table.insert(q.connections,ae:Connect(q.closeButton.Activated,function()
l:remove(q)
end))


table.insert(q.connections,ae:Connect(q.textLabel:GetPropertyChangedSignal"AbsoluteSize",function()
l:fitHeight(q)
end))

table.insert(l.items,q)
l:tweenHeight(q,q.height)


q.frame:GetPropertyChangedSignal"Size":Connect(function()
l:refreshLayout()
end)
l:refreshLayout()

if not s then
local t=if type(o)=="number"then o else ag.defaultTime
task.delay(t,function()
if not q.pinned then
l:remove(q)
end
end)
end

l:trim()
l:trimToRoom()end


h.notify=function(l, m, n, o)
if n==nil then
n=m
m=ag.defaultTitle
end

m=tostring(m)

if not l.container then
table.insert(l.queue,{title=m,message=n,duration=o})
return
end

l:add(m,n,o)end






h.ask=function(l, m, n, o, p)
m=tostring(m)

if not l.container then
table.insert(l.queue,{title=m,message=n,choices=o,duration=p})
return
end

l:add(m,n,p,o)end


h.destroy=function(l)
for m,n in l.items do
k(n)
end

table.clear(l.items)
table.clear(l.queue)
l.container=nil end


return h end a.cT=function()local ab=a.cache.cT if not ab then ab={c=aa()}a.cache.cT=ab end return ab.c end end do local aa=function()



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


return ac end a.cU=function()local ab=a.cache.cU if not ab then ab={c=aa()}a.cache.cU=ab end return ab.c end end do local aa=function()
local aa=a.b()
local ab=a.a()

local ac=a.cw()
local ad=a.cx()
local ae=a.d()

local af=a.bD().usedCmds
local ag=a.h()
local b=a.p()

local c=a.cy()
local d=a.Z()
local e=a.cs()
local f=a.cu()

local g=b.commands.cmdsRank
local h=g.maxTimesUsed
local i=g.decreasePerUse
local j=g.increasePerUse

local k=aa.iyGarbages or{}
aa.iyGarbages=k

local l={
garbages=k
}

l.registerGarbage=function(m, n)
return m:getGarbage(n)or m:createGarbage(n)end


l.createGarbage=function(m, n)
local o=m.garbages[n]
if o==nil then
o={}
m.garbages[n]=o
end

return o end


l.getCommandData=function(m, n)
return ac.lookup[n:lower()]end


l.hasGarbage=function(m, n)
return m.garbages[n]~=nil end


l.getGarbage=function(m, n)
return m.garbages[n]end


l.collectGarbage=function(m, n)
local o=m.garbages[n]

if o~=nil then
m.garbages[n]=nil
return o
end end


l.commandUsed=function(m, n)
local o=af:getValue(n)or 0

local p=math.clamp(o+j,0,h)
af:setValue(n,p)

for q,r in af:getData()do
if q==n then continue end

local s=(p==h)

if(s or r<p)and r>0 then
r=r-i

if r==0 then r=nil end
af:setValue(q,r)
end
end

af:save()end local m=function(



m)
local n={}
if m and m.args then
for o,p in m.args do
n[o]={value=p.value}
end
end
return n end




local n=setmetatable({},{__mode="k"})


l.run=function(o, p, q, r)
ae:expect(p,{"string"},"'commandsController:run' #1")
ae:expect(q,{"table","nil"},"'commandsController:run' #2")

local s=ac.lookup[p]
ae:assert(s,"invalid command")


q=q or d.new{}

local t=coroutine.running()
local u=n[t]~=nil
local v=u and not r

if not v then
o:commandUsed(s.name)


local w=m(q)
o.privateEnv.lastArgs=o.privateEnv.lastArgs or{}
o.privateEnv.lastArgs[s.name]=w

if s.name~="lastcommand"then
o.privateEnv.lastCommand={
name=s.name,
args=w
}
end
end

if s.run==nil then
ae:warn(`missing command run func: {s.name}`)
return
end

n[t]=true
local w,x=pcall(s.run,o,q)
if not u then
n[t]=nil
end

if not w then
error(x,0)
end end



l.getLastArgs=function(o, p)
local q=o.privateEnv.lastArgs
return q and q[p]end local o=function(


o)
local p=ac.lookup[o:lower()]
if p==nil then return 0 end


return af:getValue(p.name)or 0 end


l.search=function(p, q, r)
local s=c:searchAtArray(ac.array,q,r)
local t=q:lower()
local u={}

for v,w in s do
table.insert(u,{
alias=w,
index=v,
isPrefix=w:lower():sub(1,#t)==t,
usage=o(w),
})
end

table.sort(u,function(v,w)
if v.isPrefix~=w.isPrefix then return v.isPrefix end
if v.usage~=w.usage then return v.usage>w.usage end
return v.index<w.index
end)

local v={}
for w,x in u do
v[w]=x.alias
end

return v end


l.init=function(p, q)
ae:assert(q,"'commandsController:init' #1 expected a config to init")

local r=a.I()
local s=a.bb()
local t=a.cT()


p.notify=function(u, ...)
return t:notify(...)end


p.stringify=function(u, ...)
return s:stringify(...)end


p.unstringify=function(u, ...)
return s:unstringify(...)end


p.connect=function(u, ...)
return r:Connect(...)end


p.expectExploit=function(u, v)
local w=ab[v]
if w~=nil then return w end

u:notify("Incompatible Exploit",`Your exploit does not support this command (missing {v})`)end


p.getRoot=function(u)
local v=u.playerService:getRootPart()
if v then return v end

u:notify("Character","your character is not loaded")end


p.getRootPart=p.getRoot
p.Connect=p.connect


local u=a.bV()
p.isMobile=u
p.isPC=not u


p.localPlayer=a.ai()
p.executorEnv=ab
p.privateEnv=aa


p.infiniteYield=q.infiniteYield
p.playerService=q.playerService
p.fetchService=q.fetchService


p.signals={
onCameraReset=ad.new()
}


p.config={
links=b.links
}


p.userSettings=UserSettings()
p.gameSettings=settings()

p.userGameSettings=p.userSettings:GetService"UserGameSettings"
p.gameNetworkSettings=p.gameSettings:GetService"NetworkSettings"


p.loopService=a.cU()


p.storage=a.bD()


p.robloxServices=ag
p.rbxServices=ag

p.teleportService=ag.TeleportService
p.groupService=ag.GroupService
p.runService=ag.RunService
p.starterGui=ag.StarterGui
p.coreGui=ag.CoreGui
p.players=ag.Players
p.guiService=ag.GuiService
p.networkClient=ag.NetworkClient
p.proximityPromptService=ag.ProximityPromptService
p.commandsList=ac


e.restore(ac)


for v,w in f.restore(ac)do
ae:warn(`plugin '{v}' could not be loaded: {w}`)
end end


return l end a.cV=function()local ab=a.cache.cV if not ab then ab={c=aa()}a.cache.cV=ab end return ab.c end end do local aa=function()


return{

settingKey="interface.keepIY",


bundleName="compiled.luau",


localBundlePath="iy-remake/compiled.luau",
}end a.cW=function()local ab=a.cache.cW if not ab then ab={c=aa()}a.cache.cW=ab end return ab.c end end do local aa=function()



local aa=a.a()
local ab=a.I()
local ac=a.h()
local ad=a.cB()
local ae=a.cW()
local af=a.l()
local ag=a.d()

local b={}

local c=false
local d=false local e=function()


return af:getValue(ae.settingKey)==true end local f=function()



local f=ad.downloadUrl(ae.bundleName)

return table.concat({
"local ok, source = pcall(readfile, \""..ae.localBundlePath.."\")",
"if not ok or type(source) ~= \"string\" or source == \"\" then",
"\tsource = game:HttpGet(\""..f.."\")",
"end",
"loadstring(source)()",
},"\n")end local g=function()



if d or not e()then return end

local g=aa.queueteleport
if g==nil then return end

d=true

local h,i=pcall(g,f())
if not h then
d=false
ag:warn("keepiy: failed to queue the loader: "..tostring(i))
end end


b.start=function()
if c then return end
c=true

ab:Connect(ac.Players.LocalPlayer.OnTeleport,g)end


b.enable=function(h)
if not h:expectExploit"queueteleport"then return end

h.infiniteYield:setKeepIY(true)
h:notify("Keepiy","on: IY runs again after you teleport, and the interface stays open")end


b.disable=function(h)
h.infiniteYield:setKeepIY(false)
h:notify("Keepiy","off: IY will not run after the next teleport")end


b.toggle=function(h)
if e()then
b.disable(h)
else
b.enable(h)
end end


return b end a.cX=function()local ab=a.cache.cX if not ab then ab={c=aa()}a.cache.cX=ab end return ab.c end end do local aa=function()











local aa="any"

return{
ANY=aa,

events={
{
name="OnExecute",
description="when IY loads",
conditions={},
},
{
name="OnJoin",
description="a player joins",
conditions={
{kind="Player",label="$1 player",default=aa},
},
},
{
name="OnLeave",
description="a player leaves",
conditions={
{kind="Player",label="$1 player",default=aa},
},
},
{
name="OnSpawn",
description="a character spawns",
conditions={
{kind="Player",label="$1 player",default="me"},
},
},
{
name="OnDied",
description="a character dies",
conditions={
{kind="Player",label="$1 player",default="me"},
},
},
{
name="OnDamage",
description="a character takes damage",
conditions={
{kind="Player",label="$1 player",default="me"},
{kind="Number",label="$2 health at most",default=aa},
},
},
{
name="OnKilled",
description="a player kills another",
conditions={
{kind="Player",label="$1 victim",default="me"},
{kind="Player",label="$2 killer",default=aa},
},
},
{
name="OnChatted",
description="a player chats",
conditions={
{kind="Player",label="$1 player",default=aa},
{kind="String",label="$2 message contains",default=aa},
},
},
},
}end a.cY=function()local ab=a.cache.cY if not ab then ab={c=aa()}a.cache.cY=ab end return ab.c end end do local aa=function()

local aa=a.h()
local ab=a.ak()
local ac=a.cw()
local ad=a.ba()
local ae=a.bA()
local af=a.by()
local ag=a.cK()

















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


return b end a.cZ=function()local ab=a.cache.cZ if not ab then ab={c=aa()}a.cache.cZ=ab end return ab.c end end do local aa=function()

local aa=a.cV()
local ab=a.cy()

local ac=a.cw()
local ad=a.cR()

local ae=a.cK()
local af=a.cZ()

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


return v end a.c_=function()local ab=a.cache.c_ if not ab then ab={c=aa()}a.cache.c_=ab end return ab.c end end do local aa=function()






local aa=a.cV()
local ab=a.c_()
local ac=a.Z()
local ad=a.cU()
local ae=a.d()

local af={}


af.runStatement=function(ag)
local b=ag.commandData.name
local c=ag.args

if ag.repeatLast then
c=aa:getLastArgs(b)or{}
end

if ag.loop then
af.startLoop(b,c,ag.loop)
return
end

aa:run(b,ac.new(c))end



af.startLoop=function(ag, b, c)
local d=0
local e

e=ad:add(function()
d=d+1

local f,g=pcall(function()
aa:run(ag,ac.new(b))
end)

if not f then
ad:remove(e)
ae:error(`loop of '{ag}' stopped: {g}`)
return
end

if d>=c.count then
ad:remove(e)
end
end,c.delay)end local ag=function(




ag)
local b={}
local c=ab.new(b,function()end)

c:highlight(c:parse(ag))

return b.statements,b.runError end local b=function(



b)
for c,d in b do
if d.empty then
return"write the command to run"
end

if not d.commandData then
return`'{d.commandName}' is not a command`
end
end

return nil end




af.checkText=function(c)
local d=ag(c)
local e=b(d)

if e then
return false,e
end

return true end




af.runText=function(c)
local d,e=ag(c)
local f=b(d)

if f then
return false,f
end

if e then

return false,(e:gsub("^%s*%-%s*",""))
end

for g,h in d do
local i,j=pcall(af.runStatement,h)

if not i then
return false,tostring(j)
end
end

return true end


return af end a.c0=function()local ab=a.cache.c0 if not ab then ab={c=aa()}a.cache.c0=ab end return ab.c end end do local aa=function()








local aa=a.cY()
local ab=a.bC()
local ac=a.c0()
local ad=a.cV()
local ae=a.ak()

local af=aa.ANY

local ag={}


ag.events=aa.events

local b={}
for c,d in aa.events do
b[d.name]=d
end local c=function(

c)
return c:match"^%s*(.-)%s*$"or""end



ag.getEvent=function(d)
return b[d]end



ag.getBinds=function(d)
local e=ab.object[d]

if type(e)~="table"then
return{}
end

return table.clone(e)end local d=function(




d, e)
local f=c(e or"")

if f==""then
f=d.default
end

if f:lower()==af then
return af
end

if d.kind=="Number"and tonumber(f)==nil then
return nil,`{d.label} must be a number or any`
end

return f end




ag.add=function(e, f, g, h)
local i=b[e]
if not i then
return false,"invalid event"
end

local j=c(f)
local k,l=ac.checkText(j)

if not k then
return false,l
end

if type(g)~="number"or g<0 then
return false,"the delay must be 0 or more"
end

local m={}

for n,o in i.conditions do
local p,q=d(o,h and h[n])

if not p then
return false,q
end

m[n]=p
end

local n=ab.object[e]
if type(n)~="table"then
n={}
ab.object[e]=n
end

table.insert(n,{command=j,delay=g,conditions=m})
ab:save()

return true end



ag.remove=function(e, f)
local g=ab.object[e]

if type(g)~="table"or g[f]==nil then
return nil
end

local h=table.remove(g,f)
ab:save()

return h end




ag.restore=function(e, f, g)
if not b[e]or type(g)~="table"then
return false
end

local h=ab.object[e]
if type(h)~="table"then
h={}
ab.object[e]=h
end

table.insert(h,math.clamp(f,1,#h+1),g)
ab:save()

return true end



ag.setDelay=function(e, f, g)
local h=ab.object[e]

if type(h)~="table"or type(h[f])~="table"then
return false
end

if type(g)~="number"or g<0 then
return false
end

h[f].delay=g
ab:save()

return true end local e=function(



e, f)
local g,h=pcall(ae,e)

if not g then
return false
end

for i,j in h do
if j.Name==f then
return true
end
end

return false end local f=function(



f, g, h)
if g:lower()==af then
return true
end

if f.kind=="Player"then
return e(g,tostring(h))
end

if f.kind=="String"then
return tostring(h):lower():find(g:lower(),1,true)~=nil
end

if f.kind=="Number"then
local i,j=tonumber(g),tonumber(h)
return i~=nil and j~=nil and j<=i
end

return false end local g=function(



g, h, i)
local j=h.conditions or{}

for k,l in g.conditions do
local m=tostring(j[k]or l.default)

if not f(l,m,i[k])then
return false
end
end

return true end local h=function(




h)
if h:match"^[%w_%-%.]+$"then
return h
end

return'"'..(h:gsub('"','\\"'))..'"'end local i=function(



i, j)
return(i:gsub("%$(%d+)",function(k)
local l=j[tonumber(k)]

if l==nil then
return nil
end

return h(tostring(l))
end))end local j=function(




j, k)
local l=j.delay or 0

if l>0 then
task.wait(l)
end

local m=i(j.command,k)
local n,o=ac.runText(m)

if not n then
ad:notify("Event Bind",`'{m}' did not run: {o}`)
end end




ag.fire=function(k, ...)
local l=b[k]
local m=ab.object[k]

if not l or type(m)~="table"then
return
end

local n={...}

for o,p in table.clone(m)do
if type(p)=="table"and g(l,p,n)then
task.spawn(j,p,n)
end
end end


return ag end a.c1=function()local ab=a.cache.c1 if not ab then ab={c=aa()}a.cache.c1=ab end return ab.c end end do local aa=function()








local aa=a.h()
local ab=a.I()
local ac=a.c1()

local ad=aa.Players
local ae=aa.TextChatService

local af={}

local ag=false
local b=false


local c={}

local d={}local e=function(


e, f, g, h)
local i=ab:Connect(g,h)

local j=e[f]or{}
e[f]=j
table.insert(j,i)end local f=function(


f, g)
local h=f[g]
f[g]=nil

for i,j in h or{}do
ab:disconnect(j)
end end local g=function(



g, h)
f(d,g)

task.spawn(function()
local i=h:WaitForChild("Humanoid",10)


if not i or not i:IsA"Humanoid"or g.Character~=h then
return
end

local j=i.Health

e(d,g,i.HealthChanged,function(k)
if k<j then
ac.fire("OnDamage",g.Name,k)
end

j=k
end)

e(d,g,i.Died,function()
ac.fire("OnDied",g.Name)


local k=i:FindFirstChild"creator"
local l=if k and k:IsA"ObjectValue"then k.Value else nil

if l and l:IsA"Player"then
ac.fire("OnKilled",g.Name,l.Name)
end
end)
end)end local h=function(




h)
e(c,h,h.CharacterAdded,function(i)
ac.fire("OnSpawn",h.Name)
g(h,i)
end)

if b then
e(c,h,h.Chatted,function(i)
ac.fire("OnChatted",h.Name,i)
end)
end

if h.Character then
g(h,h.Character)
end end local i=function(


i)
local j=i.TextSource

if not j or i.Status==Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
return
end

local k=ad:GetPlayerByUserId(j.UserId)

if k then
ac.fire("OnChatted",k.Name,i.Text)
end end local j=function(


j)
ac.fire("OnLeave",j.Name)

f(c,j)
f(d,j)end



af.start=function()
if ag then
return
end

ag=true
b=ae.ChatVersion==Enum.ChatVersion.LegacyChatService

ab:Connect(ad.PlayerAdded,function(k)
ac.fire("OnJoin",k.Name)
h(k)
end)

ab:Connect(ad.PlayerRemoving,j)

if not b then
ab:Connect(ae.MessageReceived,i)
end


for k,l in ad:GetPlayers()do
h(l)
end

ac.fire"OnExecute"end


return af end a.c2=function()local ab=a.cache.c2 if not ab then ab={c=aa()}a.cache.c2=ab end return ab.c end end do local aa=function()

return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.c3=function()local ab=a.cache.c3 if not ab then ab={c=aa()}a.cache.c3=ab end return ab.c end end do local aa=function()



local aa={}

local ab=a.p()
local ac=a.c3()

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


return aa end a.c4=function()local ab=a.cache.c4 if not ab then ab={c=aa()}a.cache.c4=ab end return ab.c end end do local aa=function()









local aa={}








aa.compute=function(ab, ac, ad, ae)

local af=ab.x.scale*ac.width+ab.x.offset
local ag=af+ab.width

local b=ac.width-ag-ae
local c=af-ae

local d
if b>=ad.width then
d=true
elseif c>=ad.width then
d=false
else
d=b>=c
end

local e
if d then
e={scale=ab.x.scale,offset=ab.x.offset+ab.width+ae}
else
e={scale=ab.x.scale,offset=ab.x.offset-ae}
end


local f=ab.y.scale*ac.height+ab.y.offset
local g=f+ab.height



local h=(math.max(f,0)+math.min(g,ac.height))/2
local i=h>ac.height/2

local j,k,l
if i then

if g>=ac.height then
j={scale=1,offset=0}
else
j={scale=ab.y.scale,offset=ab.y.offset+ab.height}
end
k=1
l=math.min(g,ac.height)
else
if f<0 then
j={scale=0,offset=0}
else
j={scale=ab.y.scale,offset=ab.y.offset}
end
k=0
l=ac.height-math.max(f,0)
end

return{
x=e,
y=j,
anchorX=if d then 0 else 1,
anchorY=k,
room=math.max(l,0),
}end


return aa end a.c5=function()local ab=a.cache.c5 if not ab then ab={c=aa()}a.cache.c5=ab end return ab.c end end do local aa=function()



local aa=a.cM()

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


return ab end a.c6=function()local ab=a.cache.c6 if not ab then ab={c=aa()}a.cache.c6=ab end return ab.c end end do local aa=function()

local aa=a.cM()

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
end end a.c7=function()local ab=a.cache.c7 if not ab then ab={c=aa()}a.cache.c7=ab end return ab.c end end do local aa=function()



local aa=a.I()
local ab=a.h()

local ac=ab.UserInputService

local ad={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}

local ae={
[Enum.UserInputType.MouseMovement]=true,
[Enum.UserInputType.Touch]=true
}

local af={}

af.onReleaseEvent=function(ag)
local b

b=aa:Connect(ac.InputEnded,function(c)
if af.isPressingInput(c)then
b:Disconnect()
ag(c)
end
end)

return b end


af.onMouseEvent=function(ag)
local b

b=aa:Connect(ac.InputChanged,function(c)
if af.isMovingInput(c)then
ag(c)
end
end)

return b end


af.isPressingInput=function(ag)
return ad[ag.UserInputType]~=nil end


af.isMovingInput=function(ag)
return ae[ag.UserInputType]~=nil end


return af end a.c8=function()local ab=a.cache.c8 if not ab then ab={c=aa()}a.cache.c8=ab end return ab.c end end do local aa=function()
local aa=a.I()
local ab=a.cM()
local ac=a.aj()
local ad=a.cL()

local ae=a.c7()
local af=a.cP()

local ag=a.cx()

local b=a.c8()

local c={}
c.__index=c

c.awake=function(d)
local e=ac:getMouse()

local f=d.scrollThumbFrame
local g=d.scrollThumb
local h=d.scrollBar

local i=false
local j=false
local k local l=function(

l, m)local n=function()

if i then return end
if not d:canScroll(m)then return end

i=true

d:scrollToDirection(m)

b.onReleaseEvent(function()
i=false
end)

task.wait(0.4)

while d:canScroll(m)and i do
d:scrollToDirection(m)
task.wait(6.666666666666666E-2)
end end


aa:Connect(l.MouseButton1Down,n)end




l(d.upButton,"up")
l(d.downButton,"down")

aa:Connect(h.MouseWheelForward,function()
d:scrollTo(d.index-d.wheelIncrement)
end)

aa:Connect(h.MouseWheelBackward,function()
d:scrollTo(d.index+d.wheelIncrement)
end)

aa:Connect(h.InputBegan,function(m)
if not b.isPressingInput(m)then return end
if d:isScrollBarDisabled()then return end

local n=not ac:isMouseInGuiObject(g)
local o=d.isHorizontal and"X"or"Y"

local p
j=true

ad:updateObjectProperties(g,{
BackgroundColor3="Colors.Primary"
})

local q=e[o]-g.AbsolutePosition[o]
local r local s=function()


if r then r:Disconnect()end end


b.onReleaseEvent(function()
s()
j=false

ad:updateObjectProperties(g,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if n then local t=function()

local t=(e[o]>=g.AbsolutePosition[o]+g.AbsoluteSize[o])and 1 or 0
local u=d.visibleSpace-1

if t==0 and(
e[o]<g.AbsolutePosition[o]
)then
d:scrollTo(d.index-u)
elseif t==1 and(
e[o]>=g.AbsolutePosition[o]+g.AbsoluteSize[o]
)then
d:scrollTo(d.index+u)
end end


while j do
t()
task.wait(0.25)
end
return
end

r=b.onMouseEvent(function(t)
if not j then return end

local u=f.AbsoluteSize[o]-g.AbsoluteSize[o]
local v=e[o]-f.AbsolutePosition[o]-q

if v>u then
v=u
elseif v<0 then
v=0
end

if p~=v then
p=v
d:scrollTo(math.floor(0.5+v/u*(d.totalSpace-d.visibleSpace)))
end
end)
end)end


c.create=function(d)
d.upButton=ab.new("ImageButton",d.upButtonName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

d.downButton=ab.new("ImageButton",d.downButtoName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

d:createButtonsArrows()

local e=ab.new("Frame","ScrollBar",{
Active=true,
BackgroundTransparency=1,

d.upButton,
d.downButton,

ab.new("Frame","ScrollThumbFrame",{
BackgroundTransparency=1,
AnchorPoint=d.isHorizontal
and Vector2.new(0.5,0)
or Vector2.new(0,0.5),
Position=d.isHorizontal
and UDim2.fromScale(0.5,0)
or UDim2.fromScale(0,0.5),

ab.new("Frame","ScrollThumb",{
AnchorPoint=d.isHorizontal
and Vector2.new(0,0.5)
or Vector2.new(0.5,0),
ThemeTag={
BackgroundColor3="Colors.OnPrimary"
},

ab.new("UICorner",{
CornerRadius=UDim.new(0,4),
}),
}),

ab.new("Frame","MarkerFrame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
}),
}),
})

d.scrollBar=e
d.scrollThumbFrame=e.ScrollThumbFrame
d.scrollThumb=e.ScrollThumbFrame.ScrollThumb
d.markerFrame=e.ScrollThumbFrame.MarkerFrame

d.container=ab.new("Frame","Container",{
BackgroundTransparency=1,
ClipsDescendants=true,
Active=true
})

d:setScrollBarThickness(d.barThickness)
d:awake()
d:update()


return e end


c.createButtonsArrows=function(d)
local e=d.downButton
local f=d.upButton

ae(4,0.55,e.Name).Parent=e
ae(4,0.55,f.Name).Parent=f end


c.canScrollUp=function(d)
return d:isScrollBarEnabled()and d.index>0 end


c.canScrollDown=function(d)
local e=d:isScrollBarEnabled()
return e and d.index+d.visibleSpace<d.totalSpace end


c.canScroll=function(d, e)
if e=="up"or e=="left"then
return d:canScrollUp()
elseif e=="down"or e=="right"then
return d:canScrollDown()
end
return false end


c.getScrollPercent=function(d)
local e=d.totalSpace-d.visibleSpace
if e<=0 then return 0 end
return d.index/e end


c.scrollTo=function(d, e, f)
local g=math.max(0,d.totalSpace-d.visibleSpace)

d.index=math.clamp(e,0,g)
d:update()

if not f then
d.scrolledSignal:Fire(d.index)
end end


c.scrollUp=function(d)
d:scrollTo(d.index-d.increment)end


c.scrollDown=function(d)
d:scrollTo(d.index+d.increment)end


c.scrollToDirection=function(d, e)
if e=="up"or e=="left"then
return d:scrollUp()
elseif e=="down"or e=="right"then
return d:scrollDown()
end end


c.isVisible=function(d, e)
local f=d.index
if e>=f and e<(f+d.visibleSpace)then
return true
end
return false end


c.setScrollPercent=function(d, e)
local f=d.totalSpace-d.visibleSpace
d:scrollTo(math.floor(e*f))end


c.update=function(d)
d:drawThumb()end


c.setScrollBarThickness=function(d, e)
local f=d.scrollThumbFrame
local g=d.downButton
local h=d.container
local i=d.scrollBar
local j=d.upButton

d.barThickness=e

if h then
h.Size=UDim2.new(
1,
d.isHorizontal and 0 or-e,
1,
d.isHorizontal and-e or 0
)
end

if i then
i.Size=d.isHorizontal
and UDim2.new(1,0,0,e)
or UDim2.new(0,e,1,0)
i.Position=d.isHorizontal
and UDim2.new(0,0,1,-e)
or UDim2.new(1,-e,0,0)
end

if f then
f.Size=d.isHorizontal
and UDim2.new(1,-(e*2),0,e)
or UDim2.new(0,e,1,-(e*2))
end

if g then
g.Size=UDim2.fromOffset(e,e)
g.Position=d.isHorizontal
and UDim2.new(1,-e,0,0)
or UDim2.new(0,0,1,-e)
end

if j then
j.Size=UDim2.fromOffset(e,e)
j.Position=UDim2.fromOffset(0,0)
end end


c.updateArrowTransparency=function(d, e, f)
if not e:FindFirstChild"Arrow"then return end

for g,h in e.Arrow:GetChildren()do
if not h:IsA"GuiObject"then continue end
h.Transparency=f and 0.6 or 0
end end


c.drawThumb=function(d)
local e=d.scrollThumb
local f=d.scrollThumbFrame

local g=d:canScrollUp()
local h=d:canScrollDown()

d:updateArrowTransparency(d.upButton,not g)
d:updateArrowTransparency(d.downButton,not h)

if not e or not f then return end

if not g and not h then
e.Visible=false
return
end

e.Visible=true

local i=d:getScrollPercent()
local j=af:getScale()
local k=d.barThickness

if d.isHorizontal then
local l=f.AbsoluteSize.X/j
local m=math.max(k,(d.visibleSpace/d.totalSpace)*l)
e.Size=UDim2.new(0,m,1,-2)
e.Position=UDim2.new(0,i*(l-m),0.5,0)
else
local l=f.AbsoluteSize.Y/j
local m=math.max(k,(d.visibleSpace/d.totalSpace)*l)
e.Size=UDim2.new(1,-2,0,m)
e.Position=UDim2.new(0.5,0,0,i*(l-m))
end end


c.addMarker=function(d, e, f)
d.markers[e]=f or Color3.new(1,1,0)
d:updateMarkers()end


c.removeMarker=function(d, e)
d.markers[e]=nil
d:updateMarkers()end


c.updateMarkers=function(d)
local e=d.markerFrame
if not e then return end

for f,g in pairs(e:GetChildren())do
g:Destroy()
end

for f,g in pairs(d.markers)do
if f>=d.totalSpace then continue end

local h=Instance.new"Frame"
h.BackgroundColor3=g
h.BorderSizePixel=0
h.BackgroundTransparency=0
h.Parent=e

local i=f/d.totalSpace
if d.isHorizontal then
h.Position=UDim2.new(i,0,1,-4)
h.Size=UDim2.new(0,2,0,4)
else
h.Position=UDim2.new(1,-4,i,0)
h.Size=UDim2.new(0,4,0,2)
end

h.Name="Marker_"..tostring(f)
end end


c.setTotalSpace=function(d, e)
d.totalSpace=e
d:scrollTo(d.index,true)
d:update()end


c.setVisibleSpace=function(d, e)
d.visibleSpace=e
d:scrollTo(d.index,true)
d:update()end


c.disableScroll=function(d)
d.scrollBarEnabled=false
d:drawThumb()end


c.enableScroll=function(d)
d.scrollBarEnabled=true
d:drawThumb()end


c.isScrollBarEnabled=function(d)
return d.scrollBarEnabled end


c.isScrollBarDisabled=function(d)
return not d.scrollBarEnabled end


c.new=function(d)
local e=setmetatable({
isHorizontal=d.isHorizontal or false,
increment=d.increment or 1,
wheelIncrement=d.wheelIncrement or 3,
barThickness=d.barThickness or 16,

scrollBarEnabled=true,

index=0,
visibleSpace=d.visibleSpace or 0,
totalSpace=d.totalSpace or 0,

markers={},

scrollBar=d.scrollBar or nil,
scrollThumb=d.scrollThumb or nil,
scrollThumbFrame=d.scrollThumbFrame or nil,
markerFrame=d.markerFrame or nil,

scrolledSignal=ag.new(),
},c)

e.upButtonName=e.isHorizontal and"left"or"up"
e.downButtoName=e.isHorizontal and"right"or"down"

return e end


return c end a.c9=function()local ab=a.cache.c9 if not ab then ab={c=aa()}a.cache.c9=ab end return ab.c end end do local aa=function()
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


return aa end a.da=function()local ab=a.cache.da if not ab then ab={c=aa()}a.cache.da=ab end return ab.c end end do local aa=function()
local aa=a.I()
local ab=a.h()
local ac=a.aj()
local ad=a.cM()
local ae=a.da()

local af=a.c_()
local ag=a.c0()

local b=a.c8()
local c=a.cw()

local d=a.cx()
local e=a.d()
local f=a.cK()
local g=a.cP()

local h=a.l()
local i=a.cR().commands

local j=ab.UserInputService
local k=ab.RunService

local l=f.richFontSize
local m=f.colorFromRGB

local n={}
n.__index=n local o=function(

o)
return c.lookup[o]end local p=function(


p)
return math[(p<0)and"ceil"or"floor"](p)end local q=function(


q)
q=q:gsub("[\r\n]+$","")
q=q:gsub("[\r\n]+"," ")
return q end


n.refresh=function(r, s)
local t=r.parser:parse(s)
r.parser:highlight(t)

r:updateSearchBoxHighlight()
r:updateSearchedCommand()end


n.applyCorrection=function(r)
local s=r.commandInput
local t=s.correction
local u=s.rawText

local v=u:sub(1,t.from-1)..t.text..u:sub(t.to+1)

if h:getValue"spaceAfterCorrection"then
v=v.." "
end

r.searchBox.Text=v end


n.awake=function(r)
local s=r.commandInput
local t=r.searchBox
local u=r.searchBoxHolder
local v=r.inputMarker

local w=u.Placeholder

local x=t:GetPropertyChangedSignal"Text"

local y=0 local z=function()


if(tick()-y)>0.5 then
v.Visible=not v.Visible
y=tick()
end end local A=function()



if t:IsFocused()then
t:ReleaseFocus()
end end local B=function()



t:CaptureFocus()end local C=function()



if s.correction then
r:applyCorrection()
task.defer(B)
return true
end


r:sendInputCommand()
return false end local D=function()



local D=not t:IsFocused()and#t.Text==0
w.Visible=D end


r.commandClickedSignal:Connect(function(E)
t.Text=E.aliases[1]
task.defer(B)
end)

aa:Connect(u.Activated,B)

aa:Connect(t.Focused,function()
D()
r.markerConnection=aa:Connect(k.Stepped,z)

if#t.Text==0 then
r:setComment""
end
end)

aa:Connect(t.FocusLost,function(E)
D()
v.Visible=true
aa:disconnect(r.markerConnection)

if E then
r:refresh(q(t.Text))
C()
end
end)

aa:Connect(x,function()
local E=t.Text


if E:find"\t"then
t.Text=(E:gsub("\t",""))
return
end


if r.historyIndex and E~=r.historyText then
r.historyIndex=nil
end

local F=E:sub(-1)=="\n"or E:sub(-1)=="\r"

if E:find"[\r\n]"then
E=q(E)
t.Text=E

if F then
r:refresh(E)

if not C()then
A()
end
return
end
end

D()
r:refresh(E)
end)


aa:Connect(j.InputBegan,function(E)
if not t:IsFocused()then return end

if E.KeyCode==Enum.KeyCode.Up then
r:browseHistory(-1)
elseif E.KeyCode==Enum.KeyCode.Down then
r:browseHistory(1)
elseif E.KeyCode==Enum.KeyCode.Tab and r.commandInput.correction then
r:applyCorrection()
task.defer(B)
end
end)end


local r=50


n.sendInputCommand=function(s)
local t=s.commandInput

if t.runError then
s:setComment(t.runError,"error")
return
end

local u=t.statements

for v,w in u do
if not w.commandData then return end
end

local v=t.rawText
local w,x

for y,z in u do
local A,B=pcall(function()
s:runStatement(z)
end)

if not A then
w=B
x=z.commandData.name
break
end
end

if h:getValue"clearOnEnter"then
s.searchBox.Text=""
end

s.historyIndex=nil

if w then
s:setComment(`failed - {w}`,"error")
e:error(`failed to run command '{x}': {w}`)
else
s:addToHistory(v)
end end



n.runStatement=function(s, t)
ag.runStatement(t)end


n.addToHistory=function(s, t)
local u=(t or""):match"^(.-)%s*$"

if u==""then return end

local v=s.history

if v[#v]==u then return end

table.insert(v,u)

if#v>r then
table.remove(v,1)
end end



n.browseHistory=function(s, t)
local u=s.history

if#u==0 then return end

local v

if s.historyIndex==nil then
if t>0 then return end
v=#u
else
v=s.historyIndex+t
end

if v<1 then
v=1
end

if v>#u then
s.historyIndex=nil
s:setSearchText""
return
end

s.historyIndex=v
s:setSearchText(u[v])end


n.setSearchText=function(s, t)
s.historyText=t
s.searchBox.Text=t end


n.create=function(s)
s.searchBoxHolder=ad.new("ImageButton",{
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
TextSize=s.configs.textSize,
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
TextSize=s.configs.textSize-1,
Text=s.configs.placeholderText,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
}),
})

local t=s.searchBoxHolder
local u=t.Input.Holder

s.inputMarker=ad.new("Frame","Marker",u,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

s.inputComment=ad.new("TextLabel","Comment",u,{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromScale(1,0.5),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=s.configs.textSize,
RichText=true,
Text="",
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
}
})

s.commandInfo=ad.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=s.configs.textFont,
TextSize=s.configs.textSize-5,
Visible=false,
ad.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

s.searchBox=ad.new("TextBox","SearchBox",{
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

s.commandsFolder=ad.new("Folder","Commands")end


n.createCommandsData=function(s)
for t,u in c.original do
local v=ae.new(u)
u.commandData=v
v.position=t-1
table.insert(s.commandsData,v)
end end


n.updateSearchBoxHighlight=function(s)
local t=s.commandInput.highlightText
local u=s.searchBoxHolder
local v=u.Input
local w=g:getScale()

v.Text=t
v.Visible=#t>0

local x=u.AbsoluteSize.X*w
local y=x/2
local z=v.AbsoluteSize.X*w

if z<=y then
v.AnchorPoint=Vector2.new(0,0.5)
v.Position=UDim2.new(0,5,0.5,0)
else
v.AnchorPoint=Vector2.new(1,0.5)
v.Position=UDim2.new(0.5,0,0.5,0)
end end


n.updateSearchedCommand=function(s)
local t=s.commandInput.bestMatch
local u=s.commandInput.commandName
if u==""then return end

local v=o(u)
or(t and o(t))

if v then
s.scrollBar:scrollTo(v.commandData.position)
end end


n.setComment=function(s, t, u)
if u~=nil then
t=af.colorFromName(t,u)
end

s.inputComment.Text=t
s.inputComment.Visible=#t>0 end


n.updateElementColor=function(s, t, u)
local v=if u%2==1 then 1 else 0.96
t.BackgroundTransparency=v end


n.updateElements=function(s)
local t=0
local u=0
local v={}
local w=s.scrollBar
local x=s.commandsFolder

for y,z in s.commandsData do
local A=w:isVisible(z.position)

if not A then
if z.element then z.element.Parent=nil end
continue
end

local B=z.element
if not B then
B=s:createCommandElement(z)
z.element=B
end

if not z.isSection then
if#z.args>0 and#z.name>u then
u=#z.name
end
table.insert(v,z)
end

s:updateElementColor(B,y)
B.Parent=x
B.Position=UDim2.fromOffset(
0,
t*(B.Size.Y.Offset+s.configs.padding)
)
t=t+1
end

for y,z in v do
s:updateDisplayName(z,u+3)
end

s.visibleCommands=v end


n.setCommandInfo=function(s, t)
t=t or""

if t==""then
s.commandInfo.Visible=false
return
end

s.commandInfo.Visible=true
s.commandInfo.Text=t end


n.createSection=function(s, t)


local u=ad.new("TextLabel","Command",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
RichText=true,
TextSize=s.configs.textSize-3,
Text=`<b>#{t.sectionName}</b>`,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.MonoSpace"
},
})

return ad.new("Frame",{
Size=UDim2.new(1,-10,0,s.configs.labelSize),
BackgroundTransparency=1,

u
})end


n.createCommandElement=function(s, t)
if t.isSection then
return s:createSection(t)
end

local u=ad.new("TextLabel","Command",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.X,
RichText=true,
TextSize=s.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
})

return ad.new("Frame",{
Size=UDim2.new(1,0,0,s.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
u
})end


n.createCommandDescription=function(s, t)
if t.isSection then return end
if not t.description then return end

local u=ad.new("TextLabel","Description",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(25,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
TextSize=s.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
})

return ad.new("Frame","Description",{
Size=UDim2.new(1,-30,0,s.configs.labelSize),
BackgroundTransparency=1,
u
})end


n.getCommandColor=function(s, t, u)
local v=o(t)

local w=
if type(v.run)~="function"then"undefined"
elseif u.isClient then"client"
elseif u.isDeprecated then"deprecated"
else nil

if w~=nil then
t=m(t,i[w])
end

return t end


n.updateDisplayName=function(s, t, u)
local v=t.element
local w=t.name

local x=string.rep("—",(u-#w)-2)

w=s:getCommandColor(w,t)
local y=`{w} {af.colorFromName(x,"comment")} `

local z=s.parser:highlightArgsType(t.args)
local A=y..z

if t.isHolding then
t.originalText=A
else
s:setCommandText(t,A)
end end


n.setCommandText=function(s, t, u)
local v=t.element
if not v then return end

v.Command.Text=u end


n.getCommandText=function(s, t)
local u=t.element
return u and u.Command.Text or""end


n.calculateTotalSpace=function(s)
return#s.commandsData end


n.calculateVisibleSpace=function(s)
local t=s.scrollContainer.AbsoluteSize.Y
return math.floor(t/s:calculateLabelSize())end


n.calculateLabelSize=function(s)
return s.configs.padding+s.configs.labelSize end


n.getElementMouseIn=function(s)
for t,u in s.visibleCommands do
if ac:isMouseInGuiObject(u.element)then
return u
end
end end


n.horizontalScroll=function(s, t)
for u,v in s.visibleCommands do
local w=v.element

w.Position=UDim2.fromOffset(
math.min(w.Position.X.Offset+t,0),
w.Position.Y.Offset
)
end end


n.startedHoldingContainer=function(s, t)
if not b.isPressingInput(t)then return end
if s.scrollBar:isScrollBarDisabled()then return end

s.scrollAxis=nil
s.scrollBar:disableScroll()

local u=ac:getMouse()
local v=s:calculateLabelSize()
local w=s:getElementMouseIn()
local x=tick()

if w and w.description then
w.isHolding=true

local y=s.parser.colorFromName(w.description,"comment")

w.originalText=s:getCommandText(w)
s:setCommandText(w,y)
end

local y=u.Y
local z=u.X

local A local B=function()


s.scrollBar:enableScroll()

if w then
w.isHolding=nil

if w.originalText then
s:setCommandText(w,w.originalText)
w.originalText=nil
end

if(tick()-x)<=0.15 then
s.commandClickedSignal:Fire(w)
end
end

if A then A:Disconnect()end end


b.onReleaseEvent(B)

A=b.onMouseEvent(function(C)

local D=u.X-z
local E=u.Y-y

if not s.scrollAxis then
if math.abs(D)>4 or math.abs(E)>4 then
s.scrollAxis=math.abs(D)>math.abs(E)and"x"or"y"
end
return
end

if s.scrollAxis=="x"then
local F=p(D/3)
if math.floor(F)~=0 then
s:horizontalScroll(F)
z=u.X
end
else
local F=p(E/v)
if math.floor(F)~=0 then
s.scrollBar:scrollTo(s.scrollBar.index-F)
y=u.Y
end
end
end)end


n.update=function(s)
s.scrollBar:setVisibleSpace(s:calculateVisibleSpace())
s.scrollBar:setTotalSpace(s:calculateTotalSpace())
s:updateElements()end


n.enable=function(s)
if s.isEnabled then return end
local t=s.scrollContainer
s.isEnabled=true

s.commandsFolder.Parent=t
s.searchBox.Parent=s.scrollHolder
s.searchBoxHolder.Parent=s.scrollHolder
s.commandInfo.Parent=s.scrollHolder

s.scrollConnection=s.scrolledSignal:Connect(function()
s:updateElements()
end)

s.containerConnection=t.InputBegan:Connect(function(u)
s:startedHoldingContainer(u)
end)

s:update()end


n.disable=function(s)
if not s.isEnabled then return end
s.isEnabled=false

s.commandsFolder.Parent=nil
s.searchBox.Parent=nil
s.searchBoxHolder.Parent=nil
s.commandInfo.Parent=nil

aa:disconnect(s.containerConnection)
aa:disconnect(s.markerConnection)
aa:disconnect(s.scrollConnection)end


n.new=function(s)local t=function(
t)
return assert(s.configs[t],`missing config.configs['{t}']`)end


local u=setmetatable({
scrollContainer=s.scrollContainer,
scrolledSignal=s.scrolledSignal,
scrollHolder=s.scrollHolder,
scrollBar=s.scrollBar,

configs={
placeholderText=t"placeholderText",
padding=t"padding",
labelSize=t"labelSize",
textSize=t"textSize"
},

commandClickedSignal=d.new(),

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
},n)

u.parser=af.new(u.commandInput,function(v,w)
return u:setComment(v,w)
end)

return u end


return n end a.db=function()local ab=a.cache.db if not ab then ab={c=aa()}a.cache.db=ab end return ab.c end end do local aa=function()


local aa=a.I()
local ab=a.h()

local ac=a.c8()
local ad=a.cx()

local ae=ab.UserInputService

local af=0.28

local ag={}
ag.__index=ag


ag._resetDrag=function(b)
for c,d in b._pressConnections do
d:Disconnect()
end
table.clear(b._pressConnections)

b.isDragging=false
b.draggingObject=nil
b.dragStart=nil
b.startPos=nil
b.lastPos=nil
b.pressTime=0
b.travel=0 end



ag._endPress=function(b)
if not b.isDragging then return end

local c=b.draggingObject
local d={
duration=os.clock()-b.pressTime,
travel=b.travel,
dy=b.lastPos.Y-b.dragStart.Y,
}

b:_resetDrag()
b.dragEnded:Fire(c,d)end


ag.addGuiObject=function(b, c)
return aa:Connect(c.InputBegan,function(d)
if not ac.isPressingInput(d)then return end
if b.isDragging then return end

b.isDragging=true
b.draggingObject=c
b.dragStart=d.Position
b.lastPos=d.Position
b.startPos=c.Position
b.pressTime=os.clock()
b.travel=0



b._pressConnections={
d.Changed:Connect(function()
if d.UserInputState==Enum.UserInputState.End then
b:_endPress()
end
end),
ae.InputEnded:Connect(function(e)
if e.UserInputType==d.UserInputType then
b:_endPress()
end
end),
}

b.dragStarted:Fire(c)
end)end


ag.update=function(b, c, d)
local e=d.Position-b.dragStart
local f=(b._uiScale and b._uiScale.Scale)or 1

b.lastPos=d.Position
b.travel=math.max(b.travel,e.Magnitude)

local g=UDim2.new(
b.startPos.X.Scale,
b.startPos.X.Offset+(e.X/f),
b.startPos.Y.Scale,
b.startPos.Y.Offset+(e.Y/f)
)

if b.filters[c]~=nil then
local h=b.filters[c](g,f)
g=h or g
end

c.Position=c.Position:Lerp(g,af)
b.onDragged:Fire(c)end


ag.canDragObject=function(b, c)
return(not b.isDragging)or(b.draggingObject==c)end


ag.setFilter=function(b, 
c, 
d)

b.filters[c]=d end


ag.new=function(b)
local c=setmetatable({
isDragging=false,
draggingObject=nil,
_uiScale=b,
dragStart=nil,
startPos=nil,
lastPos=nil,
pressTime=0,
travel=0,
_pressConnections={},
filters={},

onDragged=ad.new(),
dragStarted=ad.new(),
dragEnded=ad.new(),
},ag)

aa:Connect(ae.InputChanged,function(d)
if c.isDragging and ac.isMovingInput(d)then
c:update(c.draggingObject,d)
end
end)

return c end


return ag end a.dc=function()local ab=a.cache.dc if not ab then ab={c=aa()}a.cache.dc=ab end return ab.c end end do local aa=function()
local aa=a.cP().uiScale
return a.dc().new(aa)end a.dd=function()local ab=a.cache.dd if not ab then ab={c=aa()}a.cache.dd=ab end return ab.c end end do local aa=function()
local aa=a.cK().colorFromRGB
local ab=a.cR().commands

local ac=a.cS()local ad=function(

ad)
return ac:apply(ad)end


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
{"title","Command Arguments"},
{"text","Some commands need extra information. Anything you type after the command name is an argument, and arguments are separated by spaces."},
{"text",`The gray hint in the command bar shows what each argument expects. For example, {ad"(fly_speed: number?)"} means you type a number.`},
{"bold","The ? means the argument is optional. You can leave it out and the command still runs."},
{"text",`Arguments are read in order, so optional ones go last. If a value has spaces, put it in quotes, like {ad'"John Doe"'}.`},
{"text","If something is wrong, the command bar tells you what to fix, and nothing runs."},
{"bold","Examples:"},
{"text",";fly 50 - fly at speed 50\n;fov 90 - set the field of view to 90\n;tppos 0,10,0 - teleport to X 0, Y 10, Z 0"},
},
{
{"title","What the Hint Words Mean"},
{"text",`<b>number</b> - a number, like 10 or 2.5\n<b>string</b> - text, like a name or a word\n<b>boolean</b> - yes or no. You can also type true/false or enabled/disabled\n<b>player</b> - a player name, or one of the special words above\n<b>vector3</b> - a position written as three numbers with commas: X,Y,Z, like 0,10,0\n<b>color3</b> - a color, written as {ad"#ff0000"} or as red,green,blue from 0 to 255\n<b>waypoint</b> - the name of a waypoint you saved\n<b>className</b> - a type of object in the game, like Part or Model\n<b>team</b> - the name of a team in the game\n<b>keycode</b> - a keyboard key, like E\n<b>command</b> - the name of a command\n<b>alias</b> - a shortcut name you made with addalias\n<b>plugin</b> - the name of a plugin you installed\n<b>object</b> - any text, nothing is checked`},
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
}end a.de=function()local ab=a.cache.de if not ab then ab={c=aa()}a.cache.de=ab end return ab.c end end do local aa=function()


local aa=a.cM()
local ab=a.dd()
local ac=a.c9()

local ad=a.cP()
local ae=a.I()
local af=a.a()
local ag=a.p()

local b=a.de()

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


return q end a.df=function()local ab=a.cache.df if not ab then ab={c=aa()}a.cache.df=ab end return ab.c end end do local aa=function()


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
}end a.dg=function()local ab=a.cache.dg if not ab then ab={c=aa()}a.cache.dg=ab end return ab.c end end do local aa=function()


local aa=a.cM()
local ab=a.cO()
local ac=a.cL()

local ad=a.dd()
local ae=a.cT()

local af=a.cK()

local ag=a.cP()
local b=a.I()
local c=a.a()
local d=a.ai()
local e=a.h()
local f=a.b()

local g=a.dg()
local h=a.cS()

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


return k end a.dh=function()local ab=a.cache.dh if not ab then ab={c=aa()}a.cache.dh=ab end return ab.c end end do local aa=function()


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
}end a.di=function()local ab=a.cache.di if not ab then ab={c=aa()}a.cache.di=ab end return ab.c end end do local aa=function()



local aa=a.cM()
local ab=a.cO()
local ac=a.cL()
local ad=a.dd()
local ae=a.cP()
local af=a.c9()
local ag=a.cT()

local b=a.b()
local c=a.di()
local d=a.h()
local e=a.cE()
local f=a.bG()
local g=a.cR().args
local h=a.cS()
local i=a.cK()

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


return x end a.dj=function()local ab=a.cache.dj if not ab then ab={c=aa()}a.cache.dj=ab end return ab.c end end do local aa=function()













local aa=a.cW()

return{

keys={
keepMenuOpen="interface.keepMenuOpen",
keepIY=aa.settingKey,
theme="selectedTheme",
},


panel={
shownY=0,
hiddenY=1,
tweenTime=0.5,
padding=5,
rowHeight=25,
rowGap=4,
headerHeight=16,
stripeTransparency=0.5,
scrollBarThickness=4,
floatBackSize=25,
floatBackMargin=6,
},

row={
labelInset=28,
iconInset=5,
iconSize=16,
chevronSize=14,
},

box={
size=16,
inset=4,
cornerRadius=3,
fillCornerRadius=2,
},

value={
width=20,
height=16,
cornerRadius=4,
keybindWidth=88,
aliasWidth=110,
inputWidth=110,
formDelayWidth=46,
addWidth=44,
delayWidth=44,
buttonWidth=36,
reloadWidth=52,
positionWidth=92,
},

textSizes={
header=12,
label=14,
value=12,
footer=11,
},


footer="{name} {version}",


pages={
back="Back",
backIcon="lucide-chevron-left",

theme={
title="#theme",
incomplete="(incomplete)",
},
keybinds={
title="#keybinds",
reset="Reset to defaults",
alwaysWorks="%s also works as the %s",
},
aliases={
title="#aliases",
addTitle="#add alias",
aliasHint="alias",
commandHint="command it runs",
addButton="Add alias",
listTitle="#custom aliases",
listHint="tap an alias to remove it",
empty="no custom aliases yet",
missing="write the alias and the command it runs",
spaces="an alias can't have spaces",
badCharacters="an alias can't have \\ ^ ! , | & or quotes: the command bar reads them as something else",
added="added '%s'",
removed="removed '%s'",
notifyTitle="Aliases",
undoTitle="Alias Removed",
undoMessage="'%s' ran '%s'",
undo="Undo",
undoTime=10,
restored="restored '%s'",
},
waypoints={
title="#waypoints",
notifyTitle="Waypoints",
newTitle="#new waypoint",
nameHint="name",
positionHint="x, y, z",
addButton="Add",
formHint="no position saves where you are standing",
modeTitle="#tap a waypoint to",

modes={
{mode="teleport",label="Teleport"},
{mode="tween",label="Tween"},
{mode="walk",label="Walk"},
},
markers="Show markers in the world",
listTitle="#waypoints of this game",
listHint="tap one to go there, Del removes it",
empty="no waypoints in this game yet",
delete="Del",
clearTitle="#clear",
clearGame="Clear this game",
clearAll="Clear every game",
missingName="write a name for the waypoint",
badPosition="the position needs 3 numbers, like 10, 5, -20",
noCharacter="your character was not found",
noMarkers="there are no waypoints to show",
saved="saved '%s' at %s",
updated="updated '%s' to %s",
went="teleported to '%s' %s",
wentTween="tweening to '%s' %s",
wentWalk="walking to '%s' %s",
cantGo="can't go there: your character was not found",
removed="removed '%s'",
restored="restored '%s'",
nameTaken="there is already a waypoint named '%s'",
undoTitle="Waypoint Removed",
undoMessage="'%s' %s was removed",
undo="Undo",
undoTime=10,
confirmTitle="Clear Waypoints",
confirmGame="Delete the %d waypoint(s) of this game?",
confirmAll="Delete the %d waypoint(s) of every game?",
confirmClear="Delete",
confirmCancel="Cancel",
cleared="deleted %d waypoint(s)",
nothingToClear="there are no waypoints to delete",
},
plugins={
title="#plugins",
notifyTitle="Plugins",
errorTitle="Plugin Error",
addTitle="#add plugin",
fileHint="plugin file name",
addButton="Add plugin",
folderHint="plugins are .luau files in the %s folder",
trustHint="a plugin runs code with full access: only add files you trust",
installedTitle="#installed plugins",
installedHint="tap a plugin to see its state, Reload reads its file again",
noneInstalled="no plugins installed yet",
folderTitle="#in the plugins folder",
noneInFolder="no new plugins in the folder",
add="Add",
addAll="Add all (%d)",
reload="Reload",
remove="Del",
failedLabel="%s (failed)",
loadedLabel="%s (%d)",
stateLoaded="'%s' is loaded with %d command(s)",
stateFailed="'%s' did not load: %s",
stateUnknown="'%s' is installed but not loaded",
added="added '%s' (%d command(s))",
reloaded="reloaded '%s' (%d command(s))",
removed="removed '%s'",
missingName="write the file name of the plugin",
addedAll="added %d plugin(s)",
failedAll=", %d failed (see the console)",
},
eventBinds={
title="#event binds",
notifyTitle="Event Binds",
notAdded="the bind was not added",
columns=4,
commandHint="command (goto $1)",
delayHint="delay",

conditionHints={
Player="any, me, friends...",
String="any, or text",
Number="any, or max",
},
addButton="Add",
header="#%s - %s",
listTitle="#binds of %s",
listHint="tap a bind to remove it, or type a new delay in its box",
empty="no binds for this event yet",
badDelay="the delay must be a number",
negativeDelay="the delay must be 0 or more",
added="added a bind to %s",
removed="removed '%s'",
delayChanged="the delay of '%s' is now %s",
restored="restored '%s'",
undoTitle="Bind Removed",
undoMessage="'%s' was removed from #%s",
undoDelay="delay %s",
undo="Undo",
undoTime=10,
},
},

sections={
{
title="#general",
options={
{kind="keybind",label="Prefix",icon="lucide-terminal",binding="prefix"},
{kind="switch",label="Keep Menu Open",icon="lucide-pin",setting="keepMenuOpen"},
{kind="switch",label="Keep Interface",icon="lucide-refresh-cw",setting="keepIY"},
},
},
{
title="#editors",
options={
{kind="button",label="Edit Theme",icon="lucide-palette",action="theme"},
{kind="button",label="Edit Keybinds",icon="lucide-keyboard",action="keybinds"},
{kind="button",label="Edit Aliases",icon="lucide-tag",action="aliases"},
{kind="button",label="Edit/Goto Waypoints",icon="lucide-map-pin",action="waypoints"},
{kind="button",label="Manage Plugins",icon="lucide-puzzle",action="plugins"},
{kind="button",label="Edit Event Binds",icon="lucide-zap",action="eventBinds"},
},
},
},
}end a.dk=function()local ab=a.cache.dk if not ab then ab={c=aa()}a.cache.dk=ab end return ab.c end end do local aa=function()








local aa=a.cM()
local ab=a.cO()
local ac=a.cL()
local ad=a.L()
local ae=a.dk()

local af=ae.panel
local ag=ae.row
local ah=ae.box
local ai=ae.value
local aj=ae.textSizes

local ak={}local al=function(


al, am, an)
ac:updateObjectProperties(al,{
BackgroundColor3=if an then"Colors.Buttons.Holding"else"Colors.Buttons.Default",
})
al.BackgroundTransparency=if an then 0 else am end



ak.page=function(am, an, ao)
return aa.new("ScrollingFrame",an,am,{
Active=true,
AutomaticCanvasSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
CanvasSize=UDim2.new(),
ElasticBehavior=Enum.ElasticBehavior.Never,
Position=ao,
ScrollBarThickness=af.scrollBarThickness,
ScrollingDirection=Enum.ScrollingDirection.Y,
Size=UDim2.fromScale(1,1),
ThemeTag={
BackgroundColor3="Colors.Background",
ScrollBarImageColor3="Colors.ScrollBar.Thumb",
},

aa.new("UIPadding",{
PaddingLeft=UDim.new(0,af.padding),
PaddingRight=UDim.new(0,af.padding),
PaddingTop=UDim.new(0,af.padding),
PaddingBottom=UDim.new(0,af.padding),
}),
aa.new("UIListLayout",{
Padding=UDim.new(0,af.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})end local am=function(



am)
ac:removeObject(am)

for an,ao in am:GetDescendants()do
ac:removeObject(ao)
end end



ak.clear=function(an)
for ao,b in an:GetChildren()do
if not(b:IsA"UIListLayout"or b:IsA"UIPadding")then
am(b)
b:Destroy()
end
end end



ak.list=function(an)
return{parent=an,order=0,index=0}end



ak.group=function(an)
an.order=an.order+1

return aa.new("Frame","Group",an.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,0),

aa.new("UIListLayout",{
Padding=UDim.new(0,af.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})end


ak.header=function(an, ao)
an.order=an.order+1
an.index=0

return aa.new("TextLabel","Header",an.parent,{
BackgroundTransparency=1,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,af.headerHeight),
Text=ao,
TextSize=aj.header,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})end



ak.row=function(an)
an.order=an.order+1
an.index=an.index+1

local ao=if an.index%2==1 then af.stripeTransparency else 1

local b=aa.new("TextButton","Option",an.parent,{
AutoButtonColor=false,
BackgroundTransparency=ao,
BorderSizePixel=0,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,af.rowHeight),
Text="",
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})


b.MouseEnter:Connect(function()
al(b,ao,true)
end)

b.MouseLeave:Connect(function()
al(b,ao,false)
end)

return b end



ak.pageTop=function(an, ao, b)
local c=ak.row(an)
c.Name="BackRow"
ak.icon(c,ae.pages.backIcon)
ak.label(c,ae.pages.back,0)
c.Activated:Connect(b)

if ao then
ak.header(an,ao)
end end



ak.label=function(an, ao, b, c)
return aa.new("TextLabel","Label",an,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(ag.labelInset,0),
Size=UDim2.new(1,-(ag.labelInset+b),1,0),
Text=ao,
TextSize=aj.label,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Normal",
TextColor3=c or"Colors.Text.Default",
},
})end


ak.icon=function(an, ao)
local b=aa.new("ImageLabel","Icon",an,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,ag.iconInset,0.5,0),
Size=UDim2.fromOffset(ag.iconSize,ag.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(b,ao)
return b end



ak.chevron=function(an)
local ao=aa.new("ImageLabel","Chevron",an,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-af.padding,0.5,0),
Rotation=180,
Size=UDim2.fromOffset(ag.chevronSize,ag.chevronSize),
ThemeTag={
ImageColor3="Colors.Text.Darker",
},
})

ab:loadImage(ao,ae.pages.backIcon)
return ao end






ak.rowButton=function(an, ao, b, c)
local d=aa.new("TextButton","RowButton",an,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-b,0.5,0),
Size=UDim2.fromOffset(c,ai.height+4),
Text=ao,
TextSize=aj.value,
ThemeTag={
BackgroundColor3="Colors.Background",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})

d.MouseEnter:Connect(function()
ac:updateObjectProperties(d,{
BackgroundColor3="Colors.Primary",
})
end)

d.MouseLeave:Connect(function()
ac:updateObjectProperties(d,{
BackgroundColor3="Colors.Background",
})
end)

return d end



ak.box=function(an)
local ao=aa.new("Frame","Box",an,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
Position=UDim2.new(1,-af.padding,0.5,0),
Size=UDim2.fromOffset(ah.size,ah.size),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ah.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Thickness=1,
ThemeTag={
Color="Colors.Border.Default",
},
}),
})

local b=aa.new("Frame","Fill",ao,{
BorderSizePixel=0,
Position=UDim2.fromOffset(ah.inset,ah.inset),
Size=UDim2.new(1,-2*ah.inset,1,-2*ah.inset),
ThemeTag={
BackgroundColor3="Colors.Primary",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ah.fillCornerRadius),
}),
})

return ao,b end



ak.value=function(an, ao, b)
local c=aa.new("Frame","Value",an,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
Position=UDim2.new(1,-af.padding,0.5,0),
Size=UDim2.fromOffset(b,ai.height),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})

local d=aa.new("TextLabel","Text",c,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=ao,
TextSize=aj.value,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

return c,d end



ak.valueInput=function(an, ao, b)
return aa.new("TextBox","ValueInput",an,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
ClearTextOnFocus=false,
Position=UDim2.new(1,-af.padding,0.5,0),
Size=UDim2.fromOffset(b,ai.height),
Text=ao,
TextSize=aj.value,
TextXAlignment=Enum.TextXAlignment.Center,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})end





ak.keybind=function(an, ao, b)
local c,d=ak.value(an,"",ai.keybindWidth)
local e local f=function()


local f=e~=nil

d.Text=if f then"press a key"else ad:getBindingName(ao)
ac:updateObjectProperties(c,{
BackgroundColor3=if f then"Colors.Primary"else"Colors.Buttons.Default",
})end local g=function()



if e then
local g=e
e=nil
g()
end

f()end


an.Activated:Connect(function()
if e then
g()
return
end

e=ad:capture(function(h)
e=nil
ad:setBinding(ao,h)
f()

if b then
b()
end
end,function()

e=nil
f()
end)

f()
end)

f()
return f,g end



ak.textBox=function(an, ao)
an.order=an.order+1

return aa.new("TextBox","Input",an.parent,{
BorderSizePixel=0,
ClearTextOnFocus=false,
LayoutOrder=an.order,
PlaceholderText=ao,
Size=UDim2.new(1,0,0,af.rowHeight),
Text="",
TextSize=aj.value,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
PlaceholderColor3="Colors.Text.Darker",
TextColor3="Colors.Text.Default",
},

aa.new("UIPadding",{
PaddingLeft=UDim.new(0,ag.labelInset/2),
PaddingRight=UDim.new(0,af.padding),
}),
aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})end




ak.choices=function(an, ao, b, c)
an.order=an.order+1

local d=af.rowGap
local e=aa.new("Frame","Choices",an.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,0),

aa.new("UIGridLayout",{
CellPadding=UDim2.fromOffset(d,d),
CellSize=UDim2.new(1/c,-d*(c-1)/c-1,0,af.rowHeight-3),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local f={}local g=function(

g)
for h,i in f do
ac:updateObjectProperties(i,{
BackgroundColor3=if h==g then"Colors.Primary"else"Colors.Buttons.Default",
})
end end


for h,i in ao do
local j=aa.new("TextButton","Choice",e,{
AutoButtonColor=false,
BorderSizePixel=0,
LayoutOrder=h,
Text=i,
TextSize=aj.value,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})

f[h]=j

j.Activated:Connect(function()
g(h)
b(h)
end)
end

return g end



ak.inputRow=function(an, ao, b, c)
local d=ak.row(an)
ak.label(d,ao,ai.inputWidth+2*af.padding)

local e=aa.new("TextBox","Input",d,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
ClearTextOnFocus=false,
PlaceholderText=b,
Position=UDim2.new(1,-af.padding,0.5,0),
Size=UDim2.fromOffset(ai.inputWidth,ai.height),
Text=c or"",
TextSize=aj.value,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
BackgroundColor3="Colors.Background",
Font="Font.MonoSpace",
PlaceholderColor3="Colors.Text.Darker",
TextColor3="Colors.Text.Default",
},

aa.new("UIPadding",{
PaddingLeft=UDim.new(0,4),
PaddingRight=UDim.new(0,4),
}),
aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})

return d,e end




ak.formRow=function(an, ao, b, c, d)
an.order=an.order+1

local e=af.rowGap
local f=ai.addWidth
local g=d or ai.formDelayWidth

local h=aa.new("Frame","Form",an.parent,{
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,af.rowHeight),
})local i=function(

i, j, k, l, m)
return aa.new("TextBox",i,h,{
AnchorPoint=k,
BorderSizePixel=0,
ClearTextOnFocus=false,
PlaceholderText=j,
Position=l,
Size=m,
Text="",
TextSize=aj.value,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
PlaceholderColor3="Colors.Text.Darker",
TextColor3="Colors.Text.Default",
},

aa.new("UIPadding",{
PaddingLeft=UDim.new(0,6),
PaddingRight=UDim.new(0,4),
}),
aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})end


local j=i("Command",ao,Vector2.zero,UDim2.fromOffset(0,0),
UDim2.new(1,-(f+g+2*e),1,0))
local k=i("Delay",b,Vector2.new(1,0),UDim2.new(1,-(f+e),0,0),
UDim2.new(0,g,1,0))

local l=aa.new("TextButton","Add",h,{
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.fromScale(1,0),
Size=UDim2.new(0,f,1,0),
Text=c,
TextSize=aj.label,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ai.cornerRadius),
}),
})

return j,k,l end




ak.footer=function(an, ao)
an.order=an.order+1

return aa.new("TextLabel","Footer",an.parent,{
BackgroundTransparency=1,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,af.headerHeight),
Text=ao,
TextSize=aj.footer,
TextXAlignment=Enum.TextXAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})end



ak.note=function(an, ao)
an.order=an.order+1

return aa.new("TextLabel","Note",an.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=an.order,
Size=UDim2.new(1,0,0,0),
Text=ao,
TextSize=aj.value,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},


aa.new("UIPadding",{
PaddingLeft=UDim.new(0,ag.labelInset),
}),
})end


return ak end a.dl=function()local ab=a.cache.dl if not ab then ab={c=aa()}a.cache.dl=ab end return ab.c end end do local aa=function()







local aa=a.cL()
local ab=a.l()
local ac=a.dk()
local ad=a.dl()

local ae=ac.panel
local af=ac.box local ag=function(

ag, ah)
local ai=ad.list(ag)
ad.pageTop(ai,ac.pages.theme.title,ah.back)

local aj={}local ak=function()


for ak,al in aj do
al.Visible=aa.selectedTheme==ak.theme
end end local al=function(


al)
aa:selectTheme(al.key)

ab:setValue(ac.keys.theme,al.key)
ab:save()

ak()end


for am,an in aa:getThemes()do
local ao=ad.row(ai)

if an.usable then
ad.label(ao,an.name,af.size+2*ae.padding)
ao.Activated:Connect(function()
al(an)
end)
else
ad.label(ao,`{an.name} {ac.pages.theme.incomplete}`,af.size+2*ae.padding,"Colors.Text.Darker")
end

local b,c=ad.box(ao)
aj[an]=c
end

ak()end


return ag end a.dm=function()local ab=a.cache.dm if not ab then ab={c=aa()}a.cache.dm=ab end return ab.c end end do local aa=function()








local aa=a.L()
local ab=a.J()
local ac=a.dk()
local ad=a.dl()

local ae=ac.panel
local af=ac.value local ag=function()


local ag={}

for ah in ab.bindings do
table.insert(ag,ah)
end

table.sort(ag)
return ag end local ah=function()




local ah={}

for ai,aj in ag()do
local ak=ab.bindings[aj]

for al,am in ak.also or{}do
local an=(Enum.KeyCode)[am]

if an then
table.insert(ah,string.format(
ac.pages.keybinds.alwaysWorks,
aa:getKeyName(an),
ak.label or aj
))
end
end
end

return ah end local ai=function(


ai, aj)
local ak=ad.list(ai)
ad.pageTop(ak,ac.pages.keybinds.title,aj.back)

local al={}

for am,an in ag()do
local ao=ab.bindings[an]
local b=ad.row(ak)

ad.label(b,ao.label or an,af.keybindWidth+2*ae.padding)

local c,d=ad.keybind(b,an)
table.insert(al,c)
table.insert(aj.stoppers,d)
end

local am=ah()
if#am>0 then
ad.note(ak,table.concat(am,"\n"))
end

local an=ad.row(ak)
ad.label(an,ac.pages.keybinds.reset,0)

an.Activated:Connect(function()

for ao,b in aj.stoppers do
b()
end

for ao in ab.bindings do
aa:resetBinding(ao)
end

for ao,b in al do
b()
end
end)end


return ai end a.dn=function()local ab=a.cache.dn if not ab then ab={c=aa()}a.cache.dn=ab end return ab.c end end do local aa=function()









local aa=a.bA()
local ab=a.cs()
local ac=a.cw()
local ad=a.dk()
local ae=a.cT()
local af=a.dl()

local ag=ad.panel
local ah=ad.value
local ai=ad.pages.aliases local aj=function(

aj)
return aj:match"^%s*(.-)%s*$"or""end local ak=function(




ak)
return ak:find"[\\%^!,|&\"']"~=nil end local al=function(


al, am)
local an=af.list(al)
af.pageTop(an,ad.pages.aliases.title,am.back)

af.header(an,ai.addTitle)
local ao=af.textBox(an,ai.aliasHint)
local b=af.textBox(an,ai.commandHint)

local c=af.row(an)
af.label(c,ai.addButton,0)

local d=af.note(an,"")

af.header(an,ai.listTitle)
af.note(an,ai.listHint)

local e=af.group(an)

local f local g=function(


g, h)
ae:ask(ai.undoTitle,string.format(ai.undoMessage,g,h),{
{
text=ai.undo,
primary=true,
onTap=function()
local i,j=ab.add(ac,g,h)

if not i then
ae:notify(ai.notifyTitle,j or"")
return
end


if e.Parent then
d.Text=string.format(ai.restored,g)
f()
end
end,
},
},ai.undoTime)end


f=function()
af.clear(e)

local h=aa:getData()
local i={}

for j in h do
table.insert(i,j)
end

table.sort(i)

local j=af.list(e)

if#i==0 then
af.note(j,ai.empty)
return
end

for k,l in i do
local m=af.row(j)

af.label(m,l,ah.aliasWidth+2*ag.padding)
af.value(m,tostring(h[l]),ah.aliasWidth)

m.Activated:Connect(function()
local n,o=ab.remove(ac,l)

if n then
d.Text=string.format(ai.removed,l)
g(l,o)
end

f()
end)
end end local h=function()



local h=aj(ao.Text)
local i=aj(b.Text)

if h==""or i==""then
d.Text=ai.missing
return
end

if h:find"%s"then
d.Text=ai.spaces
return
end

if ak(h)then
d.Text=ai.badCharacters
return
end

local j,k=ab.add(ac,h,i)

if j then
d.Text=string.format(ai.added,h:lower())
ao.Text=""
b.Text=""
f()
else
d.Text=k or""
end end


c.Activated:Connect(h)


ao.FocusLost:Connect(function(i)
if i then
b:CaptureFocus()
end
end)

b.FocusLost:Connect(function(i)
if i then
h()
end
end)

f()end


return al end a.dp=function()local ab=a.cache.dp if not ab then ab={c=aa()}a.cache.dp=ab end return ab.c end end do local aa=function()













local aa=a.bc()
local ab=a.aj()
local ac=a.dk()
local ad=a.cT()
local ae=a.dl()

local af=ac.panel
local ag=ac.box
local ah=ac.value
local ai=ac.pages.waypoints


local aj=1 local ak=function(

ak)
return ak:match"^%s*(.-)%s*$"or""end local al=function(


al, am)
local an=ai.modes
local ao=math.clamp(aj,1,#an)

local b=ae.list(al)
ae.pageTop(b,ai.title,am.back)


ae.header(b,ai.newTitle)
local c,d,e=ae.formRow(b,ai.nameHint,ai.positionHint,ai.addButton,ah.positionWidth)
local f=ae.note(b,ai.formHint)


ae.header(b,ai.modeTitle)

local g={}
for h,i in an do
table.insert(g,i.label)
end

local h=ae.choices(b,g,function(h)
ao=h
aj=h
end,#an)
h(ao)


local i=ae.row(b)
ae.label(i,ai.markers,ag.size+2*af.padding)
local j,k=ae.box(i)


local l=ae.header(b,"")
local m=ae.group(b)


ae.header(b,ai.clearTitle)
local n=ae.row(b)
ae.label(n,ai.clearGame,0)
local o=ae.row(b)
ae.label(o,ai.clearAll,0)

local p local q=function(


q)
f.Text=q
ad:notify(ai.notifyTitle,q)end local r=function()



k.Visible=aa.isShown()end local s=function(



s)
local t=an[ao].mode
local u=aa.format(s.position)

if not aa.go(s,t)then
q(ai.cantGo)
return
end

local v=if t=="tween"then ai.wentTween elseif t=="walk"then ai.wentWalk else ai.went
f.Text=string.format(v,s.name,u)end local t=function(



t)
ad:ask(ai.undoTitle,string.format(ai.undoMessage,t.name,aa.format(t.position)),{
{
text=ai.undo,
primary=true,
onTap=function()

if aa.find(t.name)then
ad:notify(ai.notifyTitle,string.format(ai.nameTaken,t.name))
return
end

aa.save(t.name,t.position)
aa.refreshMarkers()


if m.Parent then
f.Text=string.format(ai.restored,t.name)
p()
end
end,
},
},ai.undoTime)end local u=function(


u)
if not aa.remove(u.name)then return end

aa.refreshMarkers()
f.Text=string.format(ai.removed,u.name)
p()
t(u)end


p=function()
ae.clear(m)

local v=aa.list()
local w=ae.list(m)

l.Text=ai.listTitle..(if#v>0 then` ({#v})`else"")
r()

if#v==0 then
ae.note(w,ai.empty)
return
end

ae.note(w,ai.listHint)

for x,y in v do
local z=ae.row(w)


local A=ae.rowButton(z,ai.delete,af.padding,ah.buttonWidth)
ae.label(z,y.name,ah.buttonWidth+2*af.padding)

z.Activated:Connect(function()
s(y)
end)

A.Activated:Connect(function()
u(y)
end)
end end local v=function()



local v=ak(c.Text)

if v==""then
q(ai.missingName)
return
end

local w
local x=ak(d.Text)

if x==""then
local y=ab:getRootPart()

if not y then
q(ai.noCharacter)
return
end

w=y.Position
else
w=aa.parsePosition(x)

if not w then
q(ai.badPosition)
return
end
end

local y=aa.save(v,w)
aa.refreshMarkers()

c.Text=""
d.Text=""
f.Text=string.format(if y then ai.updated else ai.saved,v,aa.format(w))
p()end


e.Activated:Connect(v)


for w,x in{c,d}do
x.FocusLost:Connect(function(y)
if y then
v()
end
end)
end

i.Activated:Connect(function()
if aa.isShown()then
aa.hide()
elseif aa.count()==0 then
q(ai.noMarkers)
else
aa.show()
end

r()
end)local w=function(


w)
local x=if w then aa.countAll()else aa.count()

if x==0 then
f.Text=ai.nothingToClear
return
end

local y=string.format(if w then ai.confirmAll else ai.confirmGame,x)

ad:ask(ai.confirmTitle,y,{
{text=ai.confirmCancel},
{
text=ai.confirmClear,
primary=true,
onTap=function()
local z=if w then aa.clearAll()else aa.clearPlace()
aa.hide()


if m.Parent then
f.Text=string.format(ai.cleared,z)
p()
end
end,
},
})end


n.Activated:Connect(function()
w(false)
end)

o.Activated:Connect(function()
w(true)
end)

p()end


return al end a.dq=function()local ab=a.cache.dq if not ab then ab={c=aa()}a.cache.dq=ab end return ab.c end end do local aa=function()












local aa=a.cu()
local ab=a.cw()
local ac=a.dk()
local ad=a.cT()
local ae=a.dl()

local af=ac.panel
local ag=ac.value
local ah=ac.pages.plugins local ai=function(

ai)
return ai:match"^%s*(.-)%s*$"or""end local aj=function(


aj, ak)
local al=ae.list(aj)
ae.pageTop(al,ah.title,ak.back)


ae.header(al,ah.addTitle)
local am=ae.textBox(al,ah.fileHint)

local an=ae.row(al)
ae.label(an,ah.addButton,0)

local ao=ae.note(al,string.format(ah.folderHint,aa.FOLDER))
ae.note(al,ah.trustHint)


local b=ae.header(al,ah.installedTitle)
local c=ae.group(al)

ae.header(al,ah.folderTitle)
local d=ae.group(al)

local e local f=function(


f)
ao.Text=f
ad:notify(ah.errorTitle,f)end local g=function(



g)
local h,i=aa.add(ab,g)

if h then
ao.Text=string.format(ah.added,g,i)
e()
return true
end

f(tostring(i))
return false end local h=function(



h)
if h.loaded then
return string.format(ah.stateLoaded,h.name,h.commands)
end

if h.error then
return string.format(ah.stateFailed,h.name,h.error)
end

return string.format(ah.stateUnknown,h.name)end local i=function()



ae.clear(c)

local i=aa.getInstalled()
local j=ae.list(c)

b.Text=ah.installedTitle..(if#i>0 then` ({#i})`else"")

if#i==0 then
ae.note(j,ah.noneInstalled)
return
end

ae.note(j,ah.installedHint)

local k=af.rowGap
local l=af.padding
local m=l+ag.buttonWidth+k
local n=m+ag.reloadWidth+af.padding

for o,p in i do
local q=ae.row(j)

local r=ae.rowButton(q,ah.remove,l,ag.buttonWidth)
local s=ae.rowButton(q,ah.reload,m,ag.reloadWidth)


local t=if p.loaded
then string.format(ah.loadedLabel,p.name,p.commands)
else string.format(ah.failedLabel,p.name)

ae.label(q,t,n,if p.loaded then nil else"Colors.Text.Darker")

q.Activated:Connect(function()
ao.Text=h(p)
end)

s.Activated:Connect(function()
local u,v=aa.reload(ab,p.name)

if u then
ao.Text=string.format(ah.reloaded,p.name,v)
e()
else
e()
f(tostring(v))
end
end)

r.Activated:Connect(function()
if aa.remove(ab,p.name)then
ao.Text=string.format(ah.removed,p.name)
e()
end
end)
end end local j=function()



ae.clear(d)

local j,k=aa.getAvailable()
local l=ae.list(d)

if not j then
ae.note(l,k or"")
return
end

if#j==0 then
ae.note(l,ah.noneInFolder)
return
end

local m=af.padding

for n,o in j do
local p=ae.row(l)

local q=ae.rowButton(p,ah.add,m,ag.buttonWidth)
ae.label(p,o,ag.buttonWidth+2*af.padding)


p.Activated:Connect(function()
g(o)
end)

q.Activated:Connect(function()
g(o)
end)
end


local n=ae.row(l)
ae.label(n,string.format(ah.addAll,#j),0)

n.Activated:Connect(function()
local o=0
local p={}

for q,r in j do
local s,t=aa.add(ab,r)

if s then
o=o+1
else
table.insert(p,`{r}: {t}`)
end
end

local q=string.format(ah.addedAll,o)

if#p>0 then
q=q..string.format(ah.failedAll,#p)

for r,s in p do
warn(`plugin {s}`)
end
end

ao.Text=q
e()
end)end


e=function()
i()
j()end local k=function()



local k=ai(am.Text)

if k==""then
f(ah.missingName)
return
end

if g(k)then
am.Text=""
end end


an.Activated:Connect(k)


am.FocusLost:Connect(function(l)
if l then
k()
end
end)

e()end


return aj end a.dr=function()local ab=a.cache.dr if not ab then ab={c=aa()}a.cache.dr=ab end return ab.c end end do local aa=function()











local aa=a.c1()
local ab=a.dk()
local ac=a.cT()
local ad=a.dl()

local ae=ab.panel
local af=ab.value
local ag=ab.pages.eventBinds


local ah=1 local ai=function(


ai)
local aj={}

for ak,al in ai.conditions or{}do
table.insert(aj,tostring(al))
end

return aj end local aj=function(



aj)
local ak=ai(aj)

if#ak==0 then
return aj.command
end

return`{aj.command}  [{table.concat(ak,", ")}]`end local ak=function(



ak)
return`{ak}s`end local al=function(



al)
local am=al:gsub("%s",""):gsub("s$","")
return tonumber(am)end local am=function(


am, an)
local ao=aa.events
local b=math.clamp(ah,1,#ao)
local c={}


local d={}
for e,f in ao do
table.insert(d,(f.name:gsub("^On","")))
end

local e=ad.list(am)
ad.pageTop(e,nil,an.back)

local f
local g
local h

f=ad.choices(e,d,function(i)
b=i
ah=i
g()
end,ag.columns)


local i=ad.header(e,"")


local j=ad.group(e)

local k,l,m=ad.formRow(e,ag.commandHint,ag.delayHint,ag.addButton)

local n=ad.note(e,"")

local o=ad.header(e,"")
local p=ad.group(e)local q=function()


return ao[b]end local r=function(



r)
n.Text=r
ac:notify(ag.notifyTitle,r)end local s=function(



s, t, u)
local v=string.format(ag.undoMessage,u.command,s.name)


local w={}
local x=ai(u)

if(u.delay or 0)>0 then
table.insert(w,string.format(ag.undoDelay,ak(u.delay)))
end

if#x>0 then
table.insert(w,`[{table.concat(x,", ")}]`)
end

if#w>0 then
v=v.."\n"..table.concat(w,"  ")
end

ac:ask(ag.undoTitle,v,{
{
text=ag.undo,
primary=true,
onTap=function()
if aa.restore(s.name,t,u)then

if p.Parent then
n.Text=string.format(ag.restored,u.command)

if q()==s then
h()
end
end
end
end,
},
},ag.undoTime)end local t=function()




ad.clear(j)
c={}

local t=ad.list(j)

for u,v in q().conditions do
local w,x=ad.inputRow(
t,
v.label,
ag.conditionHints[v.kind]or"",
v.default
)

c[u]=x
end end


h=function()
ad.clear(p)

local u=q()
local v=ad.list(p)
local w=aa.getBinds(u.name)

o.Text=string.format(ag.listTitle,u.name)..(if#w>0 then` ({#w})`else"")

if#w==0 then
ad.note(v,ag.empty)
return
end

ad.note(v,ag.listHint)

for x,y in w do
local z=ad.row(v)
ad.label(z,aj(y),af.delayWidth+2*ae.padding)


local A=ad.valueInput(z,ak(y.delay or 0),af.delayWidth)


A.FocusLost:Connect(function()
if not A.Parent then return end

local B=al(A.Text)

if B==nil or B<0 then
A.Text=ak(y.delay or 0)
r(if B==nil then ag.badDelay else ag.negativeDelay)
return
end

if aa.setDelay(u.name,x,B)then
A.Text=ak(B)
n.Text=string.format(ag.delayChanged,y.command,ak(B))
end
end)

z.Activated:Connect(function()
local B=aa.remove(u.name,x)

if B then
n.Text=string.format(ag.removed,B.command)
h()
s(u,x,B)
end
end)
end end


g=function()
i.Text=string.format(ag.header,q().name,q().description)
n.Text=""

f(b)
t()
h()end local u=function()



local u=if l.Text==""then 0 else al(l.Text)

if u==nil then
r(ag.badDelay)
return
end

if u<0 then
r(ag.negativeDelay)
return
end

local v={}
for w,x in c do
v[w]=x.Text
end

local w=q()
local x,y=aa.add(w.name,k.Text,u,v)

if x then

k.Text=""
h()
n.Text=string.format(ag.added,w.name)
else
r(y or ag.notAdded)
end end


m.Activated:Connect(u)


for v,w in{k,l}do
w.FocusLost:Connect(function(x)
if x then
u()
end
end)
end

g()end


return am end a.ds=function()local ab=a.cache.ds if not ab then ab={c=aa()}a.cache.ds=ab end return ab.c end end do local aa=function()









local aa=a.cM()
local ab=a.I()
local ac=a.l()
local ad=a.dk()
local ae=a.p()

local af=a.dl()
local ag=a.dm()
local ah=a.dn()
local ai=a.dp()
local aj=a.dq()
local ak=a.dr()
local al=a.ds()

local am=ad.panel
local an=ad.box
local ao=ad.row
local b=ad.value

local c=am.shownY
local d=am.hiddenY


local e={
theme=ag,
keybinds=ah,
aliases=ai,
waypoints=aj,
plugins=ak,
eventBinds=al,
}

local f={}
f.__index=f local g=function(

g, h)
ac:setValue(g,h==true)
ac:save()end local h=function(


h)
return ac:getValue(h)==true end local i=function(


i, j, k)
i:TweenPosition(j,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,am.tweenTime,true,k)end


f.isKeepMenuOpen=function()
return h(ad.keys.keepMenuOpen)end


f.setKeepMenuOpen=function(j)
g(ad.keys.keepMenuOpen,j)end


f.isKeepIY=function()
return h(ad.keys.keepIY)end


f.setKeepIY=function(j)
g(ad.keys.keepIY,j)end



f.createOption=function(j, k, l)
local m=af.row(k)

if l.icon then
af.icon(m,l.icon)
end

if l.kind=="switch"then
local n=ad.keys[l.setting]
af.label(m,l.label,an.size+2*am.padding)

local o,p=af.box(m)local q=function()


p.Visible=h(n)end


m.Activated:Connect(function()
local r=not h(n)
g(n,r)
q()

if j.onSwitch then
j.onSwitch(l.setting,r)
end
end)

q()
return q
end

if l.kind=="keybind"then
af.label(m,l.label,b.keybindWidth+2*am.padding)

local n,o=af.keybind(m,l.binding)
table.insert(j.stoppers,o)

return n
end


local n=e[l.action]~=nil

if n then
af.chevron(m)
end

af.label(m,l.label,if n then ao.chevronSize+2*am.padding else 0)

m.Activated:Connect(function()
if e[l.action]then
j:openPage(l.action)
elseif j.onButton then
j.onButton(l.action)
end
end)

return nil end


f.createOptions=function(j)
local k=af.list(j.panel)

for l,m in ad.sections do
af.header(k,m.title)

for n,o in m.options do
local p=j:createOption(k,o)

if p then
table.insert(j.refreshers,p)
end
end
end


local l=ad.footer
:gsub("{name}",ae.applicationName)
:gsub("{version}",ae.version)

af.footer(k,l)end


f.createPages=function(j)
for k,l in e do
j.pages[k]={
frame=af.page(j.holder,`{k}Page`,UDim2.fromScale(1,d)),
build=l,
}
end end


f.new=function(j)
return setmetatable({
onSwitch=j.onSwitch,
onButton=j.onButton,
isOpen=false,
isShown=false,
holder=nil,
panel=nil,
current=nil,
pages={},
refreshers={},
stoppers={},
pageStoppers={},
pageConnections={},
backRow=nil,
floatingBack=nil,
floatingIcon=nil,
backIcon=nil,
},f)end


f.create=function(j, k, l)
local m=aa.new("Frame","SettingsHolder",k,{
AnchorPoint=l.AnchorPoint,
BackgroundTransparency=1,
ClipsDescendants=true,
Position=l.Position,
Size=l.Size,
Visible=false,
})

j.holder=m
j.panel=af.page(m,"Settings",UDim2.fromScale(0,d))
j.current=j.panel

j:createOptions()
j:createPages()
j:createFloatingBack(m)

return m end




f.createFloatingBack=function(j, k)
local l=aa.new("TextButton","FloatingBack",k,{
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-(am.floatBackMargin+am.scrollBarThickness),0,am.floatBackMargin),
Size=UDim2.fromOffset(am.floatBackSize,am.floatBackSize),
Text="",
Visible=false,
ZIndex=2,
ThemeTag={
BackgroundColor3="Colors.Buttons.Holding",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,b.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Thickness=1,
ThemeTag={
Color="Colors.Border.Default",
},
}),
})


local m=af.icon(l,ad.pages.backIcon)
m.ZIndex=l.ZIndex+1

l.Activated:Connect(function()
j:back()
end)

j.floatingBack=l
j.floatingIcon=m end



f.syncFloatingIcon=function(j)
local k,l=j.floatingIcon,j.backIcon

if k and l and l.Image~=""and k.Image~=l.Image then
k.Image=l.Image
end end



f.updateFloatingBack=function(j)
local k=j.floatingBack
if not k then return end

local l=j.current
local m=j.backRow
local n=false

if j.isShown and l~=j.panel and m and m.Parent then
n=m.AbsolutePosition.Y+m.AbsoluteSize.Y<=l.AbsolutePosition.Y
end

k.Visible=n

if n then
j:syncFloatingIcon()
end end


f.refresh=function(j)
for k,l in j.refreshers do
l()
end end



f.stopWaiting=function(j)
for k,l in j.stoppers do
l()
end

for k,l in j.pageStoppers do
l()
end end



f.buildPage=function(j, k)
af.clear(k.frame)
j.pageStoppers={}

for l,m in j.pageConnections do
m:Disconnect()
end
table.clear(j.pageConnections)

k.build(k.frame,{
back=function()
j:back()
end,
stoppers=j.pageStoppers,
})

j.backRow=k.frame:FindFirstChild"BackRow"
j.backIcon=if j.backRow then j.backRow:FindFirstChild"Icon"else nil

if j.backIcon then

table.insert(j.pageConnections,j.backIcon:GetPropertyChangedSignal"Image":Connect(function()
j:syncFloatingIcon()
end))

j:syncFloatingIcon()
end

table.insert(j.pageConnections,k.frame:GetPropertyChangedSignal"CanvasPosition":Connect(function()
j:updateFloatingBack()
end))end



f.openPage=function(j, k)
local l=j.pages[k]
if not l or not j.isShown or j.current~=j.panel then return end

j:stopWaiting()
j:buildPage(l)

l.frame.CanvasPosition=Vector2.zero
l.frame.Position=UDim2.fromScale(1,c)
j.current=l.frame

i(j.panel,UDim2.fromScale(-1,c))
i(l.frame,UDim2.fromScale(0,c))

j:updateFloatingBack()end



f.back=function(j)
if j.current==j.panel then return end

j:stopWaiting()

i(j.current,UDim2.fromScale(1,c))
i(j.panel,UDim2.fromScale(0,c))
j.current=j.panel

j:updateFloatingBack()end



f.reset=function(j)
j.current=j.panel
j.panel.Position=UDim2.fromScale(0,d)

for k,l in j.pages do
l.frame.Position=UDim2.fromScale(1,d)
end end


f.toggle=function(j)
j.isOpen=not j.isOpen
j:setShown(j.isOpen)end


f.setShown=function(j, k)
if not j.panel or j.isShown==k then return end

j.isShown=k
local l=j.current

j:updateFloatingBack()

if k then
j.holder.Visible=true
i(l,UDim2.fromScale(0,c))
return
end

j:stopWaiting()

i(l,UDim2.fromScale(0,d),function(m)
if m and not j.isShown then
j.holder.Visible=false


if not j.isOpen then
j:reset()
end
end
end)end


f.watchCommandBar=function(j, k)
ab:Connect(k.Focused,function()
j:setShown(false)
end)

ab:Connect(k.FocusLost,function()
j:setShown(j.isOpen)
end)end


return f end a.dt=function()local ab=a.cache.dt if not ab then ab={c=aa()}a.cache.dt=ab end return ab.c end end do local aa=function()





return{
window={
title="Part Path",
width=250,
topBarHeight=20,
closeIconSize=15,
closeInset=2,
rowHeight=17,
buttonRowHeight=21,
buttonHeight=17,
buttonGap=6,
rowPadding=4,

pathCharsPerLine=28,
textInset=5,
verticalPadding=3,
stripeTransparency=0.96,
shownY=100,
hiddenY=-500,
tweenTime=0.5,
},

textSizes={
title=16,
section=11,
value=14,
help=11,
button=12,
},

headers={
path="#path",
actions="#actions",
},

labels={
hint="no part selected",
help='click a part to see its path. "select part" saves it as a waypoint.',
},

buttons={
selectPart="select part",
copyPath="copy path",
copied="copied",
feedbackTime=1.5,
cornerRadius=6,
},

messages={
noPart="select a part first",
noPath="select a part to copy its path",
noClipboard="this executor doesn't support clipboard",
},
}end a.du=function()local ab=a.cache.du if not ab then ab={c=aa()}a.cache.du=ab end return ab.c end end do local aa=function()







local aa={
["and"]=true,["break"]=true,["do"]=true,["else"]=true,["elseif"]=true,
["end"]=true,["false"]=true,["for"]=true,["function"]=true,["if"]=true,
["in"]=true,["local"]=true,["nil"]=true,["not"]=true,["or"]=true,
["repeat"]=true,["return"]=true,["then"]=true,["true"]=true,
["until"]=true,["while"]=true,
}local ab=function(

ab)
local ac=ab:gsub("\\","\\\\"):gsub('"','\\"'):gsub("\n","\\n")
return ac end local ac=function(


ac)
if string.match(ac,"^[%a_][%w_]*$")and not aa[ac]then
return"."..ac
end

return'["'..ab(ac)..'"]'end local ad=function(



ad)
local ae=pcall(game.GetService,game,ad.ClassName)

if ae then
return`game:GetService("{ad.ClassName}")`
end

return"game"..ac(ad.Name)end local ae=function(


ae)
if not ae then
return""
end


local af={}
local ag=ae

while ag and ag~=game do
table.insert(af,1,ag)
ag=ag.Parent
end


if ag~=game then
return ae:GetFullName()
end

if#af==0 then
return"game"
end

local ah=ad(af[1])

for ai=2,#af do
ah=ah..ac(af[ai].Name)
end

return ah end


return ae end a.dv=function()local ab=a.cache.dv if not ab then ab={c=aa()}a.cache.dv=ab end return ab.c end end do local aa=function()







local aa=a.cM()
local ab=a.cO()
local ac=a.cL()
local ad=a.cT()
local ae=a.dd()
local af=a.bW()

local ag=a.I()
local ah=a.aj()
local ai=a.a()
local aj=a.du()

local ak=a.dv()
local al=a.cS()
local am=a.cK()

local an=aj.window
local ao=aj.textSizes
local b=aj.buttons

local c=UDim2.new(0.5,-an.width/2,0,an.shownY)
local d=UDim2.new(0.5,-an.width/2,0,an.hiddenY)

local e=Color3.fromRGB(255,255,255)
local f=Color3.fromRGB(0,166,0)

local g={}
g.__index=g

g.new=function()
return setmetatable({
frame=nil,
hoverBox=nil,
selectedBox=nil,
pathLabel=nil,
copyButton=nil,

isOpen=false,
path=nil,
selectedPart=nil,
onSelectPart=nil,
connections={},
},g)end local h=function(



h, i, j, k)
return aa.new("Frame",k,h,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=if i%2==1 then an.stripeTransparency else 1,
BorderSizePixel=0,
LayoutOrder=i,
Size=UDim2.new(1,0,0,j),
})end local i=function(



i, j, k, l)
local m=aa.new("Frame",k,i,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=if j%2==1 then an.stripeTransparency else 1,
BorderSizePixel=0,
LayoutOrder=j,
Size=UDim2.new(1,0,0,0),

aa.new("UIPadding",{
PaddingBottom=UDim.new(0,an.rowPadding),
PaddingLeft=UDim.new(0,an.textInset),
PaddingRight=UDim.new(0,an.textInset),
PaddingTop=UDim.new(0,an.rowPadding),
}),
aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local n=aa.new("TextLabel",l.labelName,m,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
TextSize=l.textSize,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=l.color,
},
})

return m,n end local j=function(




j)
local k={}
local l=""

for m=1,#j do
local n=string.sub(j,m,m)

if(n=="."or n=="[")and l~=""then
table.insert(k,l)
l=""
end

l=l..n
end

if l~=""then
table.insert(k,l)
end

local m={}
local n=""

for o,p in k do
if n~=""and#n+#p>aj.window.pathCharsPerLine then
table.insert(m,n)
n=""
end

n=n..p
end

if n~=""then
table.insert(m,n)
end

return table.concat(m,"\n")end local k=function(


k, l, m)
local n=h(k,l,an.rowHeight,"Section")

aa.new("TextLabel","Title",n,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(an.textInset,0),
Size=UDim2.new(1,-an.textInset*2,1,0),
RichText=true,
Text=`<b>{am.escapeRichText(m)}</b>`,
TextSize=ao.section,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})

return n end local l=function(


l, m, n, o, p)
local q=aa.new("TextButton",m,l,{
AutoButtonColor=false,
BorderSizePixel=0,
Position=o,
Size=p,
Text=n,
TextSize=ao.button,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,b.cornerRadius),
}),
})

ag:Connect(q.MouseEnter,function()
ac:updateObjectProperties(q,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

ag:Connect(q.MouseLeave,function()
ac:updateObjectProperties(q,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

return q end



g.create=function(m)
if m.frame then
return m.frame
end

local n=aa.new("Frame","PartPath",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=d,
Size=UDim2.fromOffset(an.width,0),
Visible=false,

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local o=aa.new("Frame","TopBar",n,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,an.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",o,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=an.title,
TextSize=ao.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local p=aa.new("ImageButton","Exit",o,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-an.closeInset,0.5,0),
Size=UDim2.fromOffset(an.closeIconSize,an.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(p,"close")

local q=aa.new("Frame","Body",n,{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
LayoutOrder=2,
Size=UDim2.new(1,0,0,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},

aa.new("UIPadding",{
PaddingBottom=UDim.new(0,an.verticalPadding),
PaddingTop=UDim.new(0,an.verticalPadding),
}),
aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

k(q,1,aj.headers.path)


local r,s=i(q,2,"PathRow",{
labelName="Path",
textSize=ao.value,
color="Colors.Text.Default",
})
s.RichText=true

k(q,3,aj.headers.actions)


local t=h(q,4,an.buttonRowHeight,"ButtonRow")
local u=an.buttonGap/2
local v=an.textInset
local w=(an.buttonRowHeight-an.buttonHeight)/2
local x=UDim2.new(0.5,-(v+u),0,an.buttonHeight)

local y=l(t,"SelectPart",b.selectPart,
UDim2.new(0,v,0,w),x)
local z=l(t,"CopyPath",b.copyPath,
UDim2.new(0.5,u,0,w),x)

local A,B=i(q,5,"Help",{
labelName="HelpText",
textSize=ao.help,
color="Colors.Text.Darker",
})
B.Text=aj.labels.help


local C=aa.new("SelectionBox","Hover",af,{
Color3=e,
})

local D=aa.new("SelectionBox","Selected",af,{
Color3=f,
})

ag:Connect(p.Activated,function()
m:close()
end)

ag:Connect(y.Activated,function()
m:confirmSelection()
end)

ag:Connect(z.Activated,function()
m:copyPath()
end)

ae:addGuiObject(n)

m.frame=n
m.hoverBox=C
m.selectedBox=D
m.pathLabel=s
m.copyButton=z

m:setPath(nil)

return n end



g.open=function(m, n)
m:create()
m.onSelectPart=n

if m.isOpen then
return
end

m.isOpen=true
m.frame.Visible=true
m.frame:TweenPosition(c,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,an.tweenTime,true)

m:startSelecting()end



g.close=function(m)
if not m.isOpen then
return
end

m.isOpen=false
m:disconnectMouse()
m:clearSelection()

m.frame:TweenPosition(d,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,an.tweenTime,true)

task.delay(an.tweenTime,function()

if not m.isOpen and m.frame then
m.frame.Visible=false
end
end)end


g.isPointerOverWindow=function(m)
return m.frame~=nil and ah:isMouseInGuiObject(m.frame)end


g.startSelecting=function(m)
m:disconnectMouse()

local n=ah:getMouse()

table.insert(m.connections,n.Move:Connect(function()
local o=n.Target


if m:isPointerOverWindow()or o==m.selectedPart then
o=nil
end

m.hoverBox.Adornee=o
end))

table.insert(m.connections,n.Button1Down:Connect(function()
if m:isPointerOverWindow()then
return
end

local o=n.Target
if o then
m:selectPart(o)
end
end))end


g.disconnectMouse=function(m)
for n,o in m.connections do
o:Disconnect()
end

m.connections={}end


g.selectPart=function(m, n)
m.selectedPart=n
m.selectedBox.Adornee=n
m.hoverBox.Adornee=nil
m:setPath(ak(n))end



g.setPath=function(m, n)
local o=m.pathLabel
m.path=n

if n then
ac:addObject(o,{TextColor3="Colors.Text.Default",Font="Font.MonoSpace"})
o.RichText=true
o.Text=al:apply(j(n))
else
ac:addObject(o,{TextColor3="Colors.Text.Darker",Font="Font.MonoSpace"})
o.RichText=false
o.Text=aj.labels.hint
end end


g.clearSelection=function(m)
m.selectedPart=nil
m.hoverBox.Adornee=nil
m.selectedBox.Adornee=nil
m:setPath(nil)end



g.confirmSelection=function(m)
local n=m.selectedPart

if not n or not n.Parent then
m:clearSelection()
ad:notify(an.title,aj.messages.noPart)
return
end

if m.onSelectPart then
m.onSelectPart(n)
end end



g.copyPath=function(m)
local n=m.path

if not n then
ad:notify(an.title,aj.messages.noPath)
return
end

if not ai.setclipboard then
ad:notify(an.title,aj.messages.noClipboard)
return
end

ai.setclipboard(n)

local o=m.copyButton
o.Text=b.copied

task.delay(b.feedbackTime,function()
o.Text=aj.buttons.copyPath
end)end


g.destroy=function(m)
m.isOpen=false
m:disconnectMouse()

if m.hoverBox then
m.hoverBox:Destroy()
end

if m.selectedBox then
m.selectedBox:Destroy()
end

if m.frame then
m.frame:Destroy()
end

m.frame=nil
m.hoverBox=nil
m.selectedBox=nil
m.pathLabel=nil
m.copyButton=nil end


return g end a.dw=function()local ab=a.cache.dw if not ab then ab={c=aa()}a.cache.dw=ab end return ab.c end end do local aa=function()















local aa=a.h()
local ab=a.I()
local ac=a.cE()

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
commandBarInUse=al.commandBarInUse,

state="minimized",
keepOpen=al.keepOpen==true,
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




ak.sleep=function(am)
am:cancel()
am.state="minimized"
am.frame.Position=am:targetFor"minimized"end



ak.onDragEnded=function(am, an)
if an.travel<=ah then

am:moveTo(am.state)
return
end

if an.dy>=ai and not am:commandBarBusy()then
am:minimize()
return
end

am:moveTo(am:nearestSnap())end



ak.commandBarBusy=function(am)
return am.commandBarInUse~=nil and am.commandBarInUse()==true end


ak.onInputBegan=function(am, an)
if not aj[an.UserInputType]then return end

local ao=am:isOverWindow(an.Position)

am.press={
type=an.UserInputType,
time=os.clock(),
position=an.Position,
inside=ao,
}


if not ao and am.state=="expanded"and not am.keepOpen and not am:commandBarBusy()then
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


return ak end a.dx=function()local ab=a.cache.dx if not ab then ab={c=aa()}a.cache.dx=ab end return ab.c end end do local aa=function()



local aa=a.p()
local ab=a.cQ()
local ac=a.b()
local ad=a.a()
local ae=a.I()
local af=a.h()
local ag=a.bV()

local ah=a.l()
local ai=a.d()
local aj=a.cK()

local ak=a.cM()
local al=a.cO()
local am=a.cL()

local an=a.cJ()
local ao=a.bW()
local b=a.cT()

local c=a.c4()
local d=a.cP()
local e=a.c5()

local f=a.c6()
local g=a.c9()
local h=a.db()
local i=a.df()
local j=a.dh()
local k=a.dj()
local l=a.dt()
local m=a.dw()

local n=a.dd()
local o=a.dx()

local p=450
local q=d.uiScale

local s={
awoken=false,
}local t=function(

t)
local u=type(t)=="string"and an[t:lower()]

if u and u.Colors and u.Font then
return t
end

return aa.theme.defaultTheme end local u=function(


u, v, w, x)
local y=(u.Scale*w)/x+u.Offset
local z=math.floor(w/x-v)

if math.floor(y)>=z then
return 1,-v
end

return 0,math.clamp(math.floor(y),0,math.max(z,0))end


s.awake=function(v)
if v.awoken then
return v.screenGui
end

v.awoken=true

v:setupTheme()
v:setupScreenGui()
v:setupScale()
v:setupMainFrame()
v:createQuickCapture()
v:createReference()
v:createPartPath()
v:createNotifications()
v:setupListeners()
v:updateNotificationsPosition()

ai:log"interface started"
return v.screenGui end


s.setupTheme=function(v)
ai:debug"interface: initializing theme service"

am:init{
theme=t(aa.theme.selectedTheme),
}end


s.setupScreenGui=function(v)
local w=v:createScreenGui()

w.Parent=ao
ac.screenGui=w

q.Parent=w end


s.setupScale=function(v)
v:setScale(ah:getValue"interface.uiScale"or 1)end


s.setupMainFrame=function(v)
local w=v:createMainFrame()

v:createCommands()
v:dragMainFrame(w)
v.commands:enable()

w.Parent=v.screenGui end


s.setupListeners=function(v)
ae:Connect(v.screenGui:GetPropertyChangedSignal"AbsoluteSize",function()
v:updateMainFramePosition()
end)

ae:Connect(v.mainFrame:GetPropertyChangedSignal"AbsolutePosition",function()
v:updateNotificationsPosition()
end)

ae:Connect(v.mainFrame:GetPropertyChangedSignal"AbsoluteSize",function()
v:updateNotificationsPosition()
end)

ae:Connect(af.RunService.RenderStepped,function()
v:updateNotificationsPosition()
end)end


s.createScreenGui=function(v)
local w=ak.new("ScreenGui",{
IgnoreGuiInset=true,
Name=aj.randomString(math.random(30,50)),
DisplayOrder=2147483647,
})

v.screenGui=w
return w end


s.calculateScale=function(v, w)
return(v.screenGui.AbsoluteSize.Y/p)*w end


s.setScale=function(v, w)
w=math.abs(w)

if w>=3 then
w=v:calculateScale(w)
end

if ah:getValue"interface.uiScale"~=w then
ah:setValue("interface.uiScale",w)
ah:save()
end

d:setScale(w)
v:updateMainFramePosition()end


s.calculateMainFramePosition=function(v, w)
local x=v.mainFrame
local y=v.screenGui
local z=d:getScale()
local A=x.Size

w=w or x.Position

local B,C=u(w.X,A.X.Offset,y.AbsoluteSize.X,z)
local D,E=u(w.Y,A.Y.Offset,y.AbsoluteSize.Y,z)

return UDim2.new(B,C,D,E)end


s.updateMainFramePosition=function(v)
if not v.mainFrame then return end

if v.dock then
v.dock:reflow()
else
v.mainFrame.Position=v:calculateMainFramePosition()
end

v:updateNotificationsPosition()end


s.createMainScroll=function(v, w)
local x=g.new{
isHorizontal=false,
barThickness=12,
}

local y=x:create()
local z=x.container

local A=ak.new("Frame","ScrollHolder",w,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

y,
z,
})

v.scrollHolder=A
v.scrollBar=x
v.scrollContainer=z

return x end


s.createMainFrame=function(v)
local w=f:create()
local x=w.mainFrame

w.titleLabel.Text=c.getDisplayName()

v.mainFrame=x
v.topBar=w.topBar
v.buttons=w.buttons

al:loadImage(v.buttons.settings,"settings")
al:loadImage(v.buttons.reference,"reference")

v:createMainScroll(x)

v.settings=l.new{

onSwitch=function(y,z)
if y=="keepMenuOpen"and v.dock then
v.dock:setKeepOpen(z)
end


if y=="keepIY"and z and ad.queueteleport==nil then
v:setKeepIY(false)
b:notify("Keepiy","your exploit does not support queueteleport")
end
end,
}
v.settings:create(x,v.scrollHolder)

ae:Connect(v.buttons.settings.Activated,function()
v.settings:toggle()
end)

return x end


s.createCommands=function(v)
local w=v.scrollBar

local x=h.new{
scrolledSignal=w.scrolledSignal,
scrollContainer=v.scrollContainer,
scrollHolder=v.scrollHolder,
scrollBar=w,

configs={
placeholderText=aa.ui.commands.placeholderText,
padding=aa.ui.commands.padding,
labelSize=aa.ui.commands.labelSize,
textSize=aa.ui.commands.textSize,
},
}

ai:log"created commands interface"
x:create()

ai:log"initialized commands"
x:createCommandsData()

ai:log"awaked commands module"
x:awake()

v.commands=x

v.settings:watchCommandBar(x.searchBox)

if ag then
ae:Connect(x.searchBox.Focused,function()
v.commandBarUsedAt=os.clock()
end)

ae:Connect(x.searchBox.FocusLost,function()
v.commandBarUsedAt=os.clock()
end)
end

return x end


s.createInfoMenu=function(v)
return j:create()end


s.chatLogs=function(v, w)
return k:open(w or"chat")end


s.dragMainFrame=function(v, w)
w.Size=aa.ui.window.windowSize

w.Position=UDim2.fromOffset(1e5,1e5)
w.Position=v:calculateMainFramePosition()

v.dock=o.new{
frame=w,
screenGui=v.screenGui,
topBarHeight=v.topBar.Size.Y.Offset,
keepOpen=l.isKeepMenuOpen(),
clampPosition=function(x)
return v:calculateMainFramePosition(x)
end,
getScale=function()
return d:getScale()
end,
commandBarInUse=function()
return v:isCommandBarInUse()
end,
onMinimize=function()
v:releaseCommandFocus()


if v.hidden then
v:hideWindow()
end
end,
}

n:addGuiObject(w)

n:setFilter(w,function(x)
return v.dock:clampDrag(x)
end)

n.dragStarted:Connect(function(x)
if x~=w then return end

v.dock:cancel()
v.scrollBar:disableScroll()
end)

n.dragEnded:Connect(function(x,y)
if x~=w then return end

v.scrollBar:enableScroll()
v.dock:onDragEnded(y)
end)end



local v=0.3

s.isCommandBarInUse=function(w)
local x=w.commands and w.commands.searchBox
if x and x:IsFocused()then
return true
end

return os.clock()-(w.commandBarUsedAt or 0)<v end


s.releaseCommandFocus=function(w)
local x=w.commands and w.commands.searchBox

if x and x:IsFocused()then
x:ReleaseFocus()
end end



s.showWindow=function(w)
w.hidden=false
w:revealWindow()end




s.revealWindow=function(w)
if not w.mainFrame then return end

w.mainFrame.Visible=true
if w.dock then
w.dock:reveal()
end end



s.hideWindow=function(w)
if not w.mainFrame then return end

w.hidden=true
w.mainFrame.Visible=false

if w.dock then
w.dock:sleep()
end

w:releaseCommandFocus()end


s.showCommandBar=function(w)
local x=w.commands and w.commands.searchBox
if not x then return end

w:revealWindow()

w.dock:onSettled(function()
if w.dock.state=="minimized"then return end

if x:IsFocused()then
x:ReleaseFocus()
end
x:CaptureFocus()
end)end



s.setKeepIY=function(w, x)
l.setKeepIY(x)

if w.settings then
w.settings:refresh()
end end


s.createQuickCapture=function(w)
if not ag then return end

local x=ak.new("TextButton",aj.randomString(math.random(30,50)),w.screenGui,{
BackgroundTransparency=0.14,
Position=UDim2.fromScale(0.5,0.15),
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
ak.new("UICorner",{
CornerRadius=UDim.new(0.5,0)
}),
})

w.dock:addWindowPart(x)
n:addGuiObject(x)

ae:Connect(x.Activated,function()
w:showCommandBar()
end)

w.quickCapture=x
return x end


s.createReference=function(w)
local x=i.new()
local y=x:create()

al:loadImage(x.closeIcon,"close")

y.Parent=w.screenGui
w.reference=x

ae:Connect(w.buttons.reference.Activated,function()
x:open()
end)

return x end


s.createPartPath=function(w)
local x=m.new()
local y=x:create()

y.Parent=w.screenGui
w.partPathWindow=x

return x end




s.openPartPath=function(w, x)
if not w.partPathWindow then return end

w.partPathWindow:open(x)end


s.createNotifications=function(w)
local x=b:getContainer(w.screenGui)
w.notificationsContainer=x

b.onLayoutChanged=function()
w:updateNotificationsPosition()
end

w:updateNotificationsPosition()
return x end


s.updateNotificationsPosition=function(w)
local x=w.notificationsContainer
local y=w.mainFrame
local z=w.screenGui
if not(x and y and z)then return end



local A=d:getScale()
local B=z.AbsoluteSize/A

local C=y.Position
local D=e.compute({
x={scale=C.X.Scale,offset=C.X.Offset},
y={scale=C.Y.Scale,offset=C.Y.Offset},
width=y.Size.X.Offset,
height=y.Size.Y.Offset,
},{
width=B.X,
height=B.Y,
},{
width=x.Size.X.Offset,
},ab.gapToWindow)


b:setRoom(D.room)

x.AnchorPoint=Vector2.new(D.anchorX,D.anchorY)
x.Position=UDim2.new(D.x.scale,D.x.offset,D.y.scale,D.y.offset)end


s.destroy=function(w)
b:destroy()
if w.dock then
w.dock:destroy()
w.dock=nil
end

k:reset()

if w.partPathWindow then
w.partPathWindow:destroy()
w.partPathWindow=nil
end

if w.screenGui then
w.screenGui:Destroy()
end

w.screenGui=nil
w.awoken=false end


return s end a.dy=function()local ab=a.cache.dy if not ab then ab={c=aa()}a.cache.dy=ab end return ab.c end end do local aa=function()a.e()


:init()

local aa=a.cV()
local ab=a.cX()
local ac=a.aj()
local ad=a.cB()
local ae=a.c2()



local af=a.dy()

local ag={}

ag.boot=function(ah)
ah.boot=nil

aa:init{
infiniteYield=af,
playerService=ac,
fetchService=ad
}

ab.start()


af:awake()


ae.start()end


return ag end a.dz=function()local ab=a.cache.dz if not ab then ab={c=aa()}a.cache.dz=ab end return ab.c end end end


















return a.dz():boot()