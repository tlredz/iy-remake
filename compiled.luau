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

local d={}

d.init=function(e)
if b.screenGui then
b.screenGui:Destroy()
c:log"destroyed old interface"
end

if b.connectionService then
b.connectionService:cleanup()
b.connectionService=nil
c:log"cleaned old connections"
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
return"v0.0.7"end a.m=function()local c=a.cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local b=function()
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
return{
action="serverhop|shop",
description="Teleports you to a different server"
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
return{
{
action="hideiy|hideinterface",
description="Hides the main IY GUI"
},
{
action="showiy|unhideiy|unhideinterface",
description="Shows IY again"
}
}end a.I=function()local c=a.cache.I if not c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()
return{
{
action="keepiy",
description="Auto execute IY when you teleport through servers"
},
{
action="unkeepiy",
description="Disable keepiy"
},
{
action="togglekeepiy",
description="Toggles keepiy"
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
action="saveinstance|savegame|saveplace|savep",
description="Uses saveinstance to save the game"
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

d.akConn=c:connect(c.userInputService.InputBegan,function(e,f)
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
}
},
{
action="unautoclick|noautoclick",
description="Turns off autoclick"
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
}
},
{
action="unautokeypress|noautokeypress|unkeypress|nokeypress",
description="Stops autokeypress"
}
}end a.ar=function()local c=a.cache.ar if not c then c={c=b()}a.cache.ar=c end return c.c end end do local b=function()

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
}
},
{
action="rolewatchstop|unrolewatch",
description="Disable Rolewatch"
},
{
action="rolewatchleave",
description="Toggle if you should leave the game if someone from a watched group joins the server"
},
{
action="staffwatch",
description="Notify if a staff member of the game joins the server"
},
{
action="unstaffwatch",
description="Disable Staffwatch"
},
{
action="findfriendgroups",
description="Notifies you if any players are friends with each other"
}
}end a.as=function()local c=a.cache.as if not c then c={c=b()}a.cache.as=c end return c.c end end do local b=function()

return{
{
action="clickdelete",
description="Go to Settings > Keybinds > Add for click delete"
},
{
action="clickteleport",
description="Go to Settings > Keybinds > Add for click teleport"
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
description="Enables invisible fling (the invis part is patched, try using the god command before using this)"
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
}end a.aU=function()local c=a.cache.aU if not c then c={c=b()}a.cache.aU=c end return c.c end end do local b=function()

return{
{
action="invisible|invis",
description="Makes you invisible to other players"
},
{
action="visible|vis",
description="Makes you visible to other players"
},
{
action="toolinvisible|toolinvis|tinvis",
description="Makes you invisible to other players and able to use tools"
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
}
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

return{
{
action="fakeout",
description="Tp to the void and then back (useful to kill people attached to you)",
run=function(d)
local e=d.playerService:getRootPart()
if not e then return end

local f=e.CFrame


local g=d:hasGarbage"antivoid"
if g then
d:run"unantivoid"
end


pcall(function()
workspace.FallenPartsDestroyHeight=0/0
end)

e.CFrame=CFrame.new(0,c-25,0)
task.wait(1)

local h=d.playerService:getRootPart()
if h then
h.CFrame=f
end

pcall(function()
workspace.FallenPartsDestroyHeight=c
end)

if g then
d:run"antivoid"
end
end
},
{
action="scare|spook",
description="Teleports in front of a player for half a second",
args={
kind="player"
},
run=function(d,e)
local f=b(e:nextValue())[1]
local g=d.playerService:getRootPart()
local h=f and f~=d.localPlayer and f.Character and f.Character:FindFirstChild"HumanoidRootPart"
if not(g and h)then return end

local i=g.CFrame
g.CFrame=h.CFrame+h.CFrame.LookVector*2
g.CFrame=CFrame.new(g.Position,h.Position)
task.wait(0.5)

local j=d.playerService:getRootPart()
if j then
j.CFrame=i
end
end
},
{
action="jerk",
description="Makes you jork it"
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
end end


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
run=function(c,d)
b(c)

local e=d:nextValue()or 1
local f=d:nextValue()
if f then
c.privateEnv.tpwalkStack=(c.privateEnv.tpwalkStack or 0)+e
end

local g=c.playerService:getCharacter()
local h=c.playerService:getHumanoid()
if not(g and h)then return end

local i=c:createGarbage"tpwalk"
i.connection=c:connect(c.runService.Heartbeat,function(j)
if not(g.Parent and h.Parent)then
b(c)
return
end

local k=h.MoveDirection
if k.Magnitude>0 then
local l=e+(c.privateEnv.tpwalkStack or 0)
g:TranslateBy(k*l*j*10)
end
end)
end
},
{
action="untpwalk|unteleportwalk",
description="Undoes tpwalk / teleportwalk",
run=function(c)
c.privateEnv.tpwalkStack=0
b(c)
end
},
{
action="wallwalk|walkonwalls",
description="Walk on walls"
}
}end a.br=function()local c=a.cache.br if not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()

return{
{
action="pathfindwalkto|pathfindfollow",
description="Follow a player using pathfinding",
args={
kind="player"
}
},
{
action="pathfindwalktowaypoint|pathfindwalktowp|pftowp",
description="Walk to a waypoint using pathfinding",
args={
kind="waypoint"
}
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
}end a.bN=function()local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do local b=function()

return{
{
action="hovername",
description="Shows a players username when your mouse is hovered over them"
},
{
action="unhovername|nohovername",
description="Turns off hovername"
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

local h="freecam"
local i="freecamKeys"
local j="freecamMouse"
local k=Enum.ContextActionPriority.High.Value
local l="freecamControls"

local m={
Enum.KeyCode.W,
Enum.KeyCode.A,
Enum.KeyCode.S,
Enum.KeyCode.D,
Enum.KeyCode.E,
Enum.KeyCode.Q,
Enum.KeyCode.Up,
Enum.KeyCode.Down,
}

local n=70
local o=64
local p=5
local q=math.pi/64
local r=0.75
local s=0.01
local t=4
local u=0.25
local v=0.1
local w=512

local x=1
local y=140
local z=60
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
local I=p*2*math.pi
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

local N=w
local O=I.LookVector

for P=0,1,0.5 do
for Q=0,1,0.5 do
local R=I.RightVector*((P-0.5)*M)
-I.UpVector*((Q-0.5)*L)
+I.LookVector

local S=R.Unit
local T=I.Position+R*v
local U=workspace:Raycast(T,S*w)
local V=U and(U.Position-T).Magnitude or w

if V<N then
N=V
O=S
end
end
end

return I.LookVector:Dot(O)*N end local I=function(


I)
return I.UserInputType==Enum.UserInputType.Touch end local J=function(


J, K, L)
local M=Instance.new(J)
for N,O in L do
M[N]=O
end
M.Parent=K
return M end local K=function(



K, L)
for M,N in K.controls do
local O=N.AbsolutePosition
local P=N.AbsoluteSize
if L.X>=O.X and L.X<=O.X+P.X
and L.Y>=O.Y and L.Y<=O.Y+P.Y then
return true
end
end
return false end local L=function(



L, M)
local N=J("ScreenGui",d,{
Name=l,
ResetOnSpawn=false,
DisplayOrder=50,
})
M.gui=N

local O=J("Frame",N,{
Name="Stick",
AnchorPoint=Vector2.new(0,1),
Position=UDim2.new(0,B,1,-C),
Size=UDim2.fromOffset(y,y),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
Active=true,
})
J("UICorner",O,{CornerRadius=UDim.new(1,0)})

local P=J("Frame",O,{
Name="Knob",
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(z,z),
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=0.3,
Active=true,
})
J("UICorner",P,{CornerRadius=UDim.new(1,0)})

table.insert(M.controls,O)local Q=function(


Q)
local R=O.AbsoluteSize.X/2
if R<=0 then return end

local S=O.AbsolutePosition+O.AbsoluteSize/2
local T=Vector2.new(Q.X,Q.Y)-S
if T.Magnitude>R then
T=T.Unit*R
end

M.stick=Vector2.new(T.X/R,-T.Y/R)
P.Position=UDim2.new(0.5,T.X,0.5,T.Y)end local R=function(


R)
if I(R)and M.stickTouch==nil then
M.stickTouch=R
Q(R.Position)
end end


table.insert(M.connections,L:connect(O.InputBegan,R))
table.insert(M.connections,L:connect(P.InputBegan,R))
table.insert(M.connections,L:connect(f.InputChanged,function(S)
if S==M.stickTouch then
Q(S.Position)
end
end))local S=function(


S, T, U)
local V=J("TextButton",N,{
Name=S,
AnchorPoint=Vector2.new(1,1),
Position=U,
Size=UDim2.fromOffset(A,A),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text=T,
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(M.controls,V)
table.insert(M.connections,L:connect(V.InputBegan,function(W)
if I(W)then
M.holds[S]=W
end
end))end


S("rise","UP",UDim2.new(1,-B,1,-C-A-12))
S("fall","DOWN",UDim2.new(1,-B,1,-C))

local T=J("TextButton",N,{
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

table.insert(M.controls,T)
table.insert(M.connections,L:connect(T.Activated,function()
g.stop(L)
end))


table.insert(M.connections,L:connect(f.InputEnded,function(U)
if U==M.stickTouch then
M.stickTouch=nil
M.stick=Vector2.zero
P.Position=UDim2.fromScale(0.5,0.5)
end

for V,W in M.holds do
if U==W then
M.holds[V]=nil
end
end
end))end local M=function(



M, N)
local O=M.playerService:getRootPart()
if not O then return end

N.root=O
N.rootAnchored=O.Anchored
O.Anchored=true end local N=function(


N)
local O=N.root
if O and O.Parent~=nil then
O.Anchored=N.rootAnchored
end end local aa=function(


O, P, Q)
local R=workspace.CurrentCamera


P.navMultiplier=math.clamp(
P.navMultiplier+Q*G(Enum.KeyCode.Up,Enum.KeyCode.Down)*r,
s,
t
)


local S=P.holds.rise and 1 or 0
local T=P.holds.fall and 1 or 0
local U=Vector3.new(
G(Enum.KeyCode.D,Enum.KeyCode.A)+P.stick.X,
G(Enum.KeyCode.E,Enum.KeyCode.Q)+S-T,
G(Enum.KeyCode.S,Enum.KeyCode.W)-P.stick.Y
)

local V=f:IsKeyDown(Enum.KeyCode.LeftShift)and u or 1
local W=(O.privateEnv.freecamSpeed or g.DEFAULT_SPEED)*P.navMultiplier*V
local X=F(P.velocitySpring,Q,U*W)

local Y=F(P.panSpring,Q,P.mouseDelta*q)
P.mouseDelta=Vector2.zero


local Z=math.sqrt(math.tan(math.rad(n/2))/math.tan(math.rad(P.fieldOfView/2)))
local _=P.rotation+Y*Vector2.new(0.75,1)*8*(Q/Z)
P.rotation=Vector2.new(
math.clamp(_.X,-math.rad(90),math.rad(90)),
_.Y%(2*math.pi)
)

local aa=CFrame.fromOrientation(P.rotation.X,P.rotation.Y,0)
local ab=CFrame.new(P.position)*aa*CFrame.new(X*o*Q)
P.position=ab.Position

R.CFrame=ab
R.Focus=ab*CFrame.new(0,0,-H(R,ab,P.fieldOfView))
R.FieldOfView=P.fieldOfView end



g.stop=function(ab)
local O=ab:collectGarbage(h)
if not O then return false end

for P,Q in O.connections do
Q:Disconnect()
end

e:UnbindAction(i)
e:UnbindAction(j)

if O.gui then
O.gui:Destroy()
end
N(O)

local P=workspace.CurrentCamera
P.CameraType=O.cameraType
P.Focus=O.focus
P.FieldOfView=O.fieldOfView

f.MouseBehavior=O.mouseBehavior
f.MouseIconEnabled=O.mouseIconEnabled

return true end




g.start=function(ab, O)
g.stop(ab)

local P=workspace.CurrentCamera
local Q=P.CFrame
local R,S=Q:ToOrientation()

local T=ab:createGarbage(h)
T.connections={}
T.controls={}
T.holds={}
T.stick=Vector2.zero
T.cameraType=P.CameraType
T.focus=P.Focus
T.fieldOfView=P.FieldOfView
T.mouseBehavior=f.MouseBehavior
T.mouseIconEnabled=f.MouseIconEnabled

T.position=O or Q.Position
T.rotation=Vector2.new(R,S)
T.mouseDelta=Vector2.zero
T.navMultiplier=1
T.velocitySpring=E(Vector3.zero)
T.panSpring=E(Vector2.zero)

P.CameraType=Enum.CameraType.Custom
f.MouseBehavior=Enum.MouseBehavior.Default
f.MouseIconEnabled=true


e:BindActionAtPriority(i,D,false,k,table.unpack(m))
e:BindActionAtPriority(j,function(U,V,W)
local X=W.Delta
T.mouseDelta=T.mouseDelta+Vector2.new(-X.Y,-X.X)
return Enum.ContextActionResult.Sink
end,false,k,Enum.UserInputType.MouseMovement)

if c then
L(ab,T)
M(ab,T)


table.insert(T.connections,ab:connect(f.InputBegan,function(V,W)
if W or not I(V)then return end
if T.lookTouch~=nil or K(T,V.Position)then return end

T.lookTouch=V
end))
table.insert(T.connections,ab:connect(f.InputChanged,function(V)
if V==T.lookTouch then
T.mouseDelta=T.mouseDelta+Vector2.new(-V.Delta.Y,-V.Delta.X)*x
end
end))
table.insert(T.connections,ab:connect(f.InputEnded,function(V)
if V==T.lookTouch then
T.lookTouch=nil
end
end))
end

table.insert(T.connections,ab:connect(ab.runService.RenderStepped,function(V)
aa(ab,T,V)
end))end



g.getPosition=function(ab)
local O=ab:getGarbage(h)
return O and O.position end


return g end a.bS=function()local ab=a.cache.bS if not ab then ab={c=aa()}a.cache.bS=ab end return ab.c end end do local aa=function()

local aa=a.ah()
local ab=a.bS()local b=function(


b)
if not b then return nil end
return b:FindFirstChildOfClass"Humanoid"or b end local c=function(


c, d)
local e=c.playerService:getCamera()
if d and e.CameraSubject~=d then
e.CameraSubject=d
end end local d=function(



d)
local e=d.playerService:getHumanoid()
if e then
c(d,e)
end end local e=function(



e)
local f=e:collectGarbage"view"
if not f then return false end

for g,h in f.connections do
h:Disconnect()
end
return true end


return{
{
action="spectate|view",
description="View a player",
args={kind="player"},
run=function(f,g)
local h=aa(g:nextValue())[1]
if not h then return end

ab.stop(f)
e(f)

local i=f:createGarbage"view"
i.connections={}

local j=f.playerService:getCamera()local k=function()



local k=b(h.Character)
if k then
c(f,k)
end end


table.insert(i.connections,f:connect(j:GetPropertyChangedSignal"CameraSubject",k))

table.insert(i.connections,f:connect(h.CharacterAdded,function(l)
l:WaitForChild("Humanoid",10)
k()
end))


table.insert(i.connections,f:connect(f.players.PlayerRemoving,function(l)
if l==h then
e(f)
d(f)
end
end))

k()
f:notify("Spectate","Viewing "..h.Name)
end
},
{
action="viewpart|viewp",
description="View a part",
args={
kind="string",
name="part name"
},
run=function(f,g)
local h=g:nextValue()
if not h then return end

ab.stop(f)
e(f)

local i=string.lower(h)
for j,k in workspace:GetDescendants()do
if k:IsA"BasePart"and string.lower(k.Name)==i then
c(f,k)
return
end
end

f:notify("Spectate","no part named "..h)
end
},
{
action="unspectate|unview",
description="Stops viewing player, or part.",
run=function(f)
ab.stop(f)

local g=e(f)
d(f)

if g then
f:notify("Spectate","View turned off")
end
end
}
}end a.bT=function()local ab=a.cache.bT if not ab then ab={c=aa()}a.cache.bT=ab end return ab.c end end do local aa=function()

local aa=a.ah()
local ab=a.bS()

local b="Freecam"local c=function(


c, d)
local e=c.storage.waypoints:getValue(tostring(game.PlaceId))
local f=type(e)=="table"and e[d]
if not f then return nil end

return c:unstringify(f,"Vector3")end local d=function(



d)
return`{math.round(d.X)},{math.round(d.Y)},{math.round(d.Z)}`end


return{
{
action="freecam|fc",
description="Allows you to freely move camera around the game",
args={
kind="number",
name="camera speed",
optional=true
},
run=function(e,f)
local g=f:nextValue()
if g then
e.privateEnv.freecamSpeed=g
end

ab.start(e)
end
},
{
action="freecampos|fcpos",
description="Moves / opens freecam in a certain position",
args={kind="vector3"},
run=function(e,f)
local g=f:nextValue()
if g then
ab.start(e,g)
end
end
},
{
action="freecamwaypoint|fcwp",
description="Moves / opens freecam to a waypoint",
args={
kind="waypoint"
},
run=function(e,f)
local g=f:nextValue()
local h=g and c(e,g)
if not h then
e:notify(b,`there is no waypoint named '{g}'`)
return
end

ab.start(e,h)
end
},
{
action="freecamgoto|fcgoto|fctp",
description="Moves / opens freecam to a player",
args={kind="player"},
run=function(e,f)
local g=aa(f:nextValue())[1]
local h=g and g.Character and g.Character:FindFirstChild"HumanoidRootPart"
if not h then
e:notify(b,"that player's character is not loaded")
return
end

ab.start(e,h.Position)
end
},
{
action="unfreecam|unfc",
description="Disables freecam",
run=function(e)
ab.stop(e)
end
},
{
action="freecamspeed|fcspeed",
description="Adjusts freecam speed (default is 1)",
args={kind="number"},
run=function(e,f)
e.privateEnv.freecamSpeed=f:nextValue()or ab.DEFAULT_SPEED
end
},
{
action="notifyfreecamposition|notifyfcpos",
description="Noitifies you your freecam coordinates",
run=function(e)
local f=ab.getPosition(e)
if not f then
e:notify(b,"freecam is not on")
return
end

e:notify("Freecam Position",d(f))
end
},
{
action="copyfreecamposition|copyfcpos",
description="Copies your freecam coordinates to your clipboard",
run=function(e)
local f=ab.getPosition(e)
if not f then
e:notify(b,"freecam is not on")
return
end

local g=e:expectExploit"setclipboard"
if not g then return end

g(d(f))
e:notify(b,"copied freecam position to clipboard")
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

local b=TweenInfo.new(aa.privateEnv.tweenSpeed or 1,Enum.EasingStyle.Linear)
aa.robloxServices.TweenService:Create(ab,b,{CFrame=workspace.CurrentCamera.CFrame}):Play()
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
local b=ab and ab:FindFirstChild"PlayerModule"
local c=b and b:FindFirstChild"CameraModule"
local d=c and c:FindFirstChild"ZoomController"
return d and d:FindFirstChild"Popper"end


return{
action="noclipcam|nccam",
description="Allows camera to go through objects like walls",
run=function(ab)
local b=ab:expectExploit"getgc"
local c=ab:expectExploit"getconstants"
local d=ab:expectExploit"setconstant"
local e=ab:expectExploit"getfenv"
if not(b and c and d and e)then return end

local f=aa(ab.localPlayer)
if not f then
ab:notify("noclipcam","camera popper not found")
return
end


for g,h in b()do
if type(h)=="function"and e(h).script==f then
for i,j in c(h)do
if tonumber(j)==0.25 then
d(h,i,0)
elseif tonumber(j)==0 then
d(h,i,0.25)
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
local b=ab:nextValue()
local c=aa.localPlayer
local d=c.CameraMaxZoomDistance
local e=c.CameraMinZoomDistance

if d<b then
d=b
end

c.CameraMaxZoomDistance=b
c.CameraMinZoomDistance=b
task.wait()
c.CameraMaxZoomDistance=d
c.CameraMinZoomDistance=e
end
}
}end a.bY=function()local ab=a.cache.bY if not ab then ab={c=aa()}a.cache.bY=ab end return ab.c end end do local aa=function()

return{
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(aa,ab)
local b=math.clamp(math.abs(ab:nextValue()or 70),1,120)
workspace.CurrentCamera.FieldOfView=b
end
}end a.bZ=function()local ab=a.cache.bZ if not ab then ab={c=aa()}a.cache.bZ=ab end return ab.c end end do local aa=function()

local aa=a.bS()

return{
action="fixcam|restorecam",
description="Fixes camera",
run=function(ab)
local b=ab.playerService
local c=ab.localPlayer


aa.stop(ab)


if ab:hasGarbage"view"then
ab:run"unview"
end

local d=b:getHumanoid()

if d then
ab.signals.onCameraReset:Fire()

local e=b:getCamera()
e.CameraSubject=d
e.CameraType=Enum.CameraType.Custom

c.CameraMinZoomDistance=0.5
c.CameraMaxZoomDistance=400
c.CameraMode=Enum.CameraMode.Classic

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

local b=aa:createGarbage"shiftlock"
b.connection=aa:connect(ab:GetPropertyChangedSignal"DevEnableMouseLock",function()
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
run=function(b,c)
local d=aa(c:nextValue())[1]
local e=d and d.Character and d.Character:FindFirstChild"Head"
if not e then
b:notify("Lookat","the player's character is not loaded")
return
end

local f=b.localPlayer
local g=b.playerService:getCamera()


if f.CameraMaxZoomDistance~=0.5 then
b.privateEnv.lookAtZoom={
max=f.CameraMaxZoomDistance,
min=f.CameraMinZoomDistance
}
end
local h=b.privateEnv.lookAtZoom or ab


f.CameraMaxZoomDistance=0.5
f.CameraMinZoomDistance=0.5
task.wait()

g.CFrame=CFrame.new(g.CFrame.Position,e.Position)
task.wait(0.1)

f.CameraMaxZoomDistance=h.max
f.CameraMinZoomDistance=h.min
end
}end a.b1=function()local ab=a.cache.b1 if not ab then ab={c=aa()}a.cache.b1=ab end return ab.c end end do local aa=function()

local aa=a.ah()local ab=function(

ab)
local b=ab:collectGarbage"stareat"
if b then
b.connection:Disconnect()
end end


return{
{
action="stareat|stare",
description="Stare / look at a player",
args={
kind="player"
},
run=function(b,c)
local d=aa(c:nextValue())[1]
if not d then return end

ab(b)

local e=b:createGarbage"stareat"
e.connection=b:connect(b.runService.RenderStepped,function()
if d.Parent==nil then
ab(b)
return
end

local f=b.playerService:getRootPart()
local g=d.Character and d.Character:FindFirstChild"HumanoidRootPart"
if not(f and g)then return end


local h=Vector3.new(g.Position.X,f.Position.Y,g.Position.Z)
if(h-f.Position).Magnitude<0.01 then return end

f.CFrame=CFrame.new(f.Position,h)
end)
end
},
{
action="unstareat|unstare",
description="Disables stareat",
run=function(b)
ab(b)
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

return{
{
client=true,
action="btools",
description="Gives you building tools (DOES NOT REPLICATE)",
run=function(aa)
local ab=aa.localPlayer:FindFirstChildWhichIsA"Backpack"
if not ab then
aa:notify("Btools","your backpack is not loaded")
return
end


for b,c in Enum.BinType:GetEnumItems()do
local d=Instance.new"HopperBin"
d.BinType=c
d.Name="Building Tool"
d.Parent=ab
end
end
},
{
client=true,
action="f3x",
description="Gives you F3X building tools (DOES NOT REPLICATE)"
}
}end a.b4=function()local ab=a.cache.b4 if not ab then ab={c=aa()}a.cache.b4=ab end return ab.c end end do local aa=function()

return{
action="partname|partpath",
description="Allows you to click a part to see its path & name"
}end a.b5=function()local ab=a.cache.b5 if not ab then ab={c=aa()}a.cache.b5=ab end return ab.c end end do local aa=function()local aa=function(

aa, ab, b)
if ab==false then
aa:notify("Delete","cancelled: "..b)
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
run=function(ab,b)
local c=b:nextValue()
local d=b:nextValue()
if not aa(ab,d,c)then return end

local e=c:lower()
for f,g in workspace:GetDescendants()do
if g.Name:lower()==e then
g:Destroy()
end
end

ab:notify("Item(s) Deleted","Deleted "..c)
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
run=function(ab,b)
local c=b:nextValue()
local d=b:nextValue()
if not aa(ab,d,c)then return end

local e=c:lower()
for f,g in workspace:GetDescendants()do
if g.ClassName:lower()==e then
g:Destroy()
end
end

ab:notify("Item(s) Deleted","Deleted items with ClassName "..c)
end
}
}end a.b6=function()local ab=a.cache.b6 if not ab then ab={c=aa()}a.cache.b6=ab end return ab.c end end do local aa=function()

return{
{
action="lockworkspace|lockws",
description="Locks the whole workspace"
},
{
action="unlockworkspace|unlockws",
description="Unlocks the whole workspace"
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

for b,c in workspace:GetDescendants()do
if c:IsA"BasePart"and c.Transparency==1 then
if not table.find(ab,c)then
table.insert(ab,c)
end
c.Transparency=0
end
end
end
},
{
client=true,
action="uninvisibleparts|uninvisparts",
description="Makes parts affected by invisparts return to normal",
run=function(aa)
for ab,b in aa.privateEnv.shownParts or{}do
b.Transparency=1
end
aa.privateEnv.shownParts={}
end
}
}end a.b8=function()local ab=a.cache.b8 if not ab then ab={c=aa()}a.cache.b8=ab end return ab.c end end do local aa=function()local aa=function(

aa, ab, b)
return{
action=aa,
description=ab,
run=function()
for c,d in workspace:GetDescendants()do
if d:IsA(b)then
d.MaxActivationDistance=math.huge
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
local b=ab.executorEnv.fireproximityprompt

if not b then
ab:notify("Incompatible Exploit","Your exploit does not support this command (missing fireproximityprompt)")
return
end

if ab:hasGarbage"instantpp"then
ab:notify"instant proximity prompts is already enabled"
return
end

local c=ab:createGarbage"instantpp"
c.connection=ab:connect(ab.proximityPromptService.PromptButtonHoldBegan,function(d)
b(d)
end)
end
},
{
action="uninstantproximityprompts|uninstantpp",
description="Disables instant proximity prompts",
run=function(ab)
local b=ab:collectGarbage"instantpp"
if b and b.connection then
b.connection:Disconnect()
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
run=function(b,c)
workspace.Gravity=c:nextValue()or aa
end
},
{
action="destroyheight|dh",
description="Sets the height where fallen parts get destroyed (default is -500)",
args={kind="number",name="height",optional=true},
run=function(b,c)
workspace.FallenPartsDestroyHeight=c:nextValue()or ab
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
local b=ab.Parent
if b==nil then
return nil
elseif b:IsA"Attachment"then
return b.WorldPosition
elseif b:IsA"BasePart"then
return b.Position
elseif b:IsA"Model"then
return b:GetPivot().Position
end
return nil end local b=function(


b)
local c=b.playerService:getRootPart()
if not c then
return nil
end

local d
local e=math.huge

for f,g in workspace:GetDescendants()do
if g:IsA"ProximityPrompt"and g.Enabled then
local h=ab(g)
if not h then continue end

local i=(h-c.Position).Magnitude

if i<e then
d,e=g,i
end
end
end

return d end local c=function(


c, d)
local e=c.playerService:getRootPart()
local f=ab(d)

if e and f then
e.CFrame=CFrame.new(f+Vector3.new(0,3,0))
end end


return{
{
action="fireclickdetectors|firecd",
description="Uses all click detectors in a game or uses the optional name",
args={
kind="object",
optional=true
},
run=function(d,e)
local f=d:expectExploit"fireclickdetector"
if not f then return end

local g=(e:nextValue()or""):lower()

for h,i in workspace:GetDescendants()do
if i:IsA"ClickDetector"and aa(i,g)then
f(i)
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
run=function(d,e)
local f=d:expectExploit"fireproximityprompt"
if not f then return end

local g=(e:nextValue()or""):lower()

for h,i in workspace:GetDescendants()do
if i:IsA"ProximityPrompt"and aa(i,g)then
f(i)
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
run=function(d,e)
local f=d:expectExploit"fireproximityprompt"
if not f then return end

local g=b(d)
if not g then
d:notify"Can't find any ProximityPrompt on workspace"
return
end

if e:nextValue()then
c(d,g)
task.wait(0.25)
end

f(g)
d:notify(`fired prompt: {g:GetFullName()}`)
end
},
{
action="firetouchinterests|touchinterests",
description="Uses all touchinterests in a game or uses the optional name",
args={
kind="object",
optional=true
}
}
}end a.cc=function()local ab=a.cache.cc if not ab then ab={c=aa()}a.cache.cc=ab end return ab.c end end do local aa=function()
local aa=a.ah()local ab=function(


ab)
local b=ab.Parent
if b and b:FindFirstChildWhichIsA"Humanoid"then
return true
end

local c=b and b.Parent
return c~=nil and c:FindFirstChildWhichIsA"Humanoid"~=nil end


return{
{
action="tpunanchored|tpua",
description="Teleports unanchored parts to a player",
args={
kind="player"
},
run=function(b,c)
local d=aa(c:nextValue())[1]
local e=d and d.Character and d.Character:FindFirstChild"Head"
if not e then return end

local f=b.playerService:getCharacter()
local g=b:registerGarbage"tpunanchored"
g.forces=g.forces or{}

for h,i in workspace:GetDescendants()do
if i:IsA"BasePart"and not i.Anchored and not(f and i:IsDescendantOf(f))and not ab(i)then

local j=Instance.new"BodyPosition"
j.MaxForce=Vector3.one*math.huge
j.Position=e.Position
j.Parent=i
table.insert(g.forces,j)
end
end
end
},
{
action="animsunanchored|freezeua",
description="Freezes unanchored parts"
},
{
action="thawunanchored|thawua|unfreezeua",
description="Thaws unanchored parts",
run=function(b)
local c=b:collectGarbage"tpunanchored"
if not c then return end

for d,e in c.forces do
e:Destroy()
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
local b=ab:collectGarbage"loopfullbright"
if b then
b.connection:Disconnect()
end end


return{
{
action="fullbright|fb",
description="Makes the map brighter / more visible (CLIENT)",
run=function(b)
aa(b)
end
},
{
action="loopfullbright|loopfb",
description="Makes the map brighter / more visible but looped (CLIENT)",
run=function(b)
ab(b)

local c=b:createGarbage"loopfullbright"
c.connection=b:connect(b.runService.RenderStepped,function()
aa(b)
end)
end
},
{
action="unloopfullbright|unloopfb",
description="Unloops fullbright",
run=function(b)
ab(b)
end
}
}end a.cf=function()local ab=a.cache.cf if not ab then ab={c=aa()}a.cache.cf=ab end return ab.c end end do local aa=function()

return{
client=true,
action="ambient",
description="Changes ambient",
args={kind="color3"},
run=function(aa,ab)
local b=ab:nextValue()
local c=aa.robloxServices.Lighting

c.Ambient=b
c.OutdoorAmbient=b
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

for b,c in ab:GetDescendants()do
if c:IsA"Atmosphere"then
c:Destroy()
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
local b={
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
ab.Ambient=b.ambient
ab.OutdoorAmbient=b.outdoorAmbient
ab.Brightness=b.brightness
ab.ClockTime=b.clockTime
ab.FogEnd=b.fogEnd
ab.FogStart=b.fogStart
ab.GlobalShadows=b.globalShadows
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
run=function(c,d)
local e=aa(d:nextValue())[1]
local f=d:nextValue()or 30

local g=e and e.Character and e.Character:FindFirstChild"HumanoidRootPart"
if not g then return end

local h=Instance.new"PointLight"
h.Range=f
h.Brightness=5
h.Parent=g

local i=c.privateEnv.dynamicLights or{}
c.privateEnv.dynamicLights=i
table.insert(i,h)
end
},
{
action="nolight|unlight",
description="Removes dynamic light from your player",
run=function(c)
for d,e in c.privateEnv.dynamicLights or{}do
e:Destroy()
end
c.privateEnv.dynamicLights={}

local d=c.playerService:getCharacter()
if d then
for e,f in d:GetDescendants()do
if f:IsA"PointLight"then
f:Destroy()
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

local ab={}local b=function(

b, c)
local d=table.find(b,c)
if d then
table.remove(b,d)
end end



ab.add=function(c, d, e)
d=d:lower()

if c.lookup[d]~=nil then
return false,`'{d}' is already a command or an alias`
end

local f=c.lookup[e:lower()]
if not f then
return false,"invalid command"
end

c.lookup[d]=f
table.insert(c.array,d)

aa.object[d]=f.name
aa:save()

return true end



ab.remove=function(c, d)
d=d:lower()

local e=aa.object[d]
if type(e)~="string"then
return false
end

c.lookup[d]=nil
b(c.array,d)

aa.object[d]=nil
aa:save()

return true,e end



ab.clear=function(c)
local d={}
for e in aa.object do
table.insert(d,e)
end

for e,f in d do
c.lookup[f]=nil
b(c.array,f)
aa.object[f]=nil
end

aa:save()
return#d end



ab.restore=function(c)
for d,e in aa.object do
local f=type(e)=="string"and c.lookup[e]

if f and c.lookup[d]==nil then
c.lookup[d]=f
table.insert(c.array,d)
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
run=function(ab,b)
local c=b:nextValue()
local d=b:nextValue()
if not(c and d)then return end

local e,f=aa.add(ab.commandsList,d,c)
if e then
ab:notify("Aliases Modified",`Added {d:lower()} as an alias to {c}`)
else
ab:notify("Aliases Modified",f)
end
end
},
{
action="removealias",
description="Removes a custom alias",
args={kind="alias"},
run=function(ab,b)
local c=b:nextValue()
if not c then return end

local d,e=aa.remove(ab.commandsList,c)
if d then
ab:notify("Aliases Modified",`Removed the alias {c} from {e}`)
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
run=function(ab,b)

if b and b:nextValue()==false then return end

local c=aa.clear(ab.commandsList)
ab:notify("Aliases Modified",`Removed {c} custom alias(es)`)
end
}
}end a.co=function()local ab=a.cache.co if not ab then ab={c=aa()}a.cache.co=ab end return ab.c end end do local aa=function()




















local aa=a.a()
local ab=a.j()
local b=a.bv()

local c={}

local d=".luau"
local e=`{ab.privateFolder}/plugins`

c.FOLDER=e


local f={}local g=function(

g, h)
local i=table.find(g,h)
if i then
table.remove(g,i)
end end local h=function(



h)
local i=h
if i:sub(-#d)==d then
i=i:sub(1,-#d-1)
end

if i:match"^[%w_%-]+$"then
return i
end
return nil end local i=function(


i)
return`{e}/{i}{d}`end local j=function(


j)
if aa.readfile==nil or aa.isfile==nil then
return nil,"your exploit does not support readfile"
end

local k=i(j)

local l,m=pcall(aa.isfile,k)
if not(l and m)then
return nil,`file not found: {k}`
end

local n,o=pcall(aa.readfile,k)
if not(n and type(o)=="string")then
return nil,`could not read {k}`
end

return o end local k=function(



k)
if aa.loadstring==nil then
return nil,"your exploit does not support loadstring"
end

local l,m,n=pcall(aa.loadstring,k)
if not l then
return nil,tostring(m)
end
if not m then
return nil,tostring(n)
end

local o,p=pcall(m)
if not o then
return nil,`error while loading the plugin: {p}`
end
if type(p)~="table"then
return nil,"the plugin must return a table of commands"
end

return p end local l=function(




l)
local m=l
if type(l.action)=="string"then
m={l}
end

local n={}

for o,p in m do
if type(p)~="table"or type(p.action)~="string"then
return nil,"every command needs an action string"
end

if p.run~=nil and type(p.run)~="function"then
return nil,`run of '{p.action}' must be a function`
end

local q={}
for r,s in p.action:split"|"do
local t=s:lower()
if t==""then
return nil,`empty name in '{p.action}'`
end
table.insert(q,t)
end


local r={}
for s,t in p do
r[s]=t
end

local s=r.args or{}
if#s==0 and next(s)then
s={s}
end
r.args=s

local t=table.clone(q)
table.sort(t,function(u,v)
return#u<#v
end)

r.name=q[1]
r.aliases=t
r.action=nil

table.insert(n,{entry=r,names=q})
end

if#n==0 then
return nil,"the plugin has no commands"
end

return n end local m=function(



m, n)
local o,p=j(n)
if not o then
return false,p
end

local q,r=k(o)
if not q then
return false,r
end

local s,t=l(q)
if not s then
return false,t
end

local u={}
local v={}

for w,x in s do
for y,z in x.names do
if m.lookup[z]~=nil or v[z]then
return false,`'{z}' is already a command or an alias`
end
v[z]=true
table.insert(u,z)
end
end

for w,x in s do
for y,z in x.names do
m.lookup[z]=x.entry
table.insert(m.array,z)
end
end

f[n]={keys=u}
return true,#s end local n=function(


n, o)
local p=f[o]
if not p then return end

for q,r in p.keys do
n.lookup[r]=nil
g(n.array,r)
end

f[o]=nil end



c.add=function(o, p)
local q=h(p)
if not q then
return false,"plugin names can only use letters, numbers, '_' and '-'"
end

if f[q]then
return false,`'{q}' is already loaded`
end

local r,s=m(o,q)
if not r then
return false,s
end

b.object[q]=q..d
b:save()

return true,s end



c.remove=function(o, p)
if b.object[p]==nil and f[p]==nil then
return false
end

n(o,p)

b.object[p]=nil
b:save()

return true end



c.reload=function(o, p)
if b.object[p]==nil then
return false,`'{p}' is not installed`
end

n(o,p)
return m(o,p)end




c.restore=function(o)
local p={}

for q in b.object do
if not f[q]then
local r,s=m(o,q)
if not r then
p[q]=tostring(s)
end
end
end

return p end



c.addAll=function(o)
if aa.listfiles==nil then
return nil,"your exploit does not support listfiles"
end

local p,q=pcall(aa.listfiles,e)
if not(p and type(q)=="table")then
return nil,`could not read the folder {e} (create it and put your .luau plugins there)`
end

local r={added={},failed={}}

for s,t in q do
local u=type(t)=="string"and t:match"([^/\\]+)%.luau$"

if u and not f[u]then
local v,w=c.add(o,u)
if v then
table.insert(r.added,u)
else
table.insert(r.failed,`{u}: {w}`)
end
end
end

return r end


return c end a.cp=function()local ab=a.cache.cp if not ab then ab={c=aa()}a.cache.cp=ab end return ab.c end end do local aa=function()

local aa=a.cp()

return{
{
action="addplugin|plugin",
description="Add a plugin via command",
args={
kind="string",
name="plugin name"
},
run=function(ab,b)
local c=b:nextValue()
if not c then return end

local d,e=aa.add(ab.commandsList,c)
if d then
ab:notify("Plugins",`Added '{c}' ({e} command(s))`)
else
ab:notify("Plugin Error",e)
end
end
},
{
action="removeplugin|deleteplugin",
description="Remove a plugin via command",
args={kind="plugin"},
run=function(ab,b)
local c=b:nextValue()
if not c then return end

if aa.remove(ab.commandsList,c)then
ab:notify("Plugins",`Removed '{c}'`)
end
end
},
{
action="reloadplugin",
description="Reloads a plugin",
args={kind="plugin"},
run=function(ab,b)
local c=b:nextValue()
if not c then return end

local d,e=aa.reload(ab.commandsList,c)
if d then
ab:notify("Plugins",`Reloaded '{c}' ({e} command(s))`)
else
ab:notify("Plugin Error",e)
end
end
},
{
action="addallplugins|loadallplugins",
description="Adds all plugins from the infiniteYield/plugins folder",
run=function(ab)
local b,c=aa.addAll(ab.commandsList)
if not b then
ab:notify("Plugin Error",c)
return
end

local d=`Added {#b.added} plugin(s)`
if#b.failed>0 then
d=d..`, {#b.failed} failed (see console)`
for e,f in b.failed do
warn(`plugin {f}`)
end
end

ab:notify("Plugins",d)
end
}
}end a.cq=function()local ab=a.cache.cq if not ab then ab={c=aa()}a.cache.cq=ab end return ab.c end end do local aa=function()

local aa=a.d()local ab=function(


ab)
local b={}
local c={}
local d={}local e=function(

e)
aa:expect(e.action,{"string"},"command action")
table.insert(b,e)

local f={}
local g=e.args or{}
e.args=g

for h,i in e.action:split"|"do
if not e.name then
e.name=i
end

c[i]=e

table.insert(f,i)
table.insert(d,i)
end

table.sort(f,function(h,i)
return#h<#i
end)

if#g==0 and next(g)then
e.args={g}
end

e.aliases=f
e.action=nil end


for f,g in ab do
aa:expect(g.name,{"string"},"section name")
aa:expect(g.commands,{"table"},"section commands")

table.insert(b,{
isSection=true,
sectionName=g.name
})

for h,i in g.commands do
if#i==0 then
aa:assert(next(i),"the command cannot be empty")
e(i)
continue
end

for j=1,#i do
e(i[j])
end
end
end

return{
array=d,
lookup=c,
original=b
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

aa.Disconnect=function(b)
if not b._isConnected then return end

local c=b.Parent and b.Parent.Connections
local d=c and table.find(c,b)

if d then
table.remove(c,d)
end

b._connectedFunc=nil
b._isConnected=false end


aa.Fire=function(b, ...)
if b._connectedFunc~=nil then
task.spawn(b._connectedFunc,...)
end end


aa.new=function(b, c)
local d=setmetatable({
_isConnected=true,
_connectedFunc=c,
Parent=b
},aa)

table.insert(b.Connections,d)
return d end


ab.Connect=function(b, c)
assert(type(c)=="function",`function expected, got {type(c)}`)

return aa.new(b,c)end


ab.Once=function(b, c)
local d

d=b:Connect(function(...)
d:Disconnect()
task.spawn(c,...)
end)

return d end


ab.Wait=function(b)
local c,d=(coroutine.running())

d=b:Connect(function(...)
d:Disconnect()
task.spawn(c,...)
end)

return coroutine.yield()end


ab.Fire=function(b, ...)
for c,d in ipairs(b.Connections)do
d:Fire(...)
end end


ab.new=function()
return setmetatable({
Connections={}
},ab)end


return ab end a.cs=function()local ab=a.cache.cs if not ab then ab={c=aa()}a.cache.cs=ab end return ab.c end end do local aa=function()
local aa={}


aa.searchAtArray=function(ab, 
b, 
c, 
d)

if c==""then return{}end

local e=c:lower()
local f={}
local g={}

for h,i in b do
local j=tostring(i):lower()

if#j<#e then continue end

local k=j:find(e,1,true)

if k==1 then
table.insert(f,i)
elseif k and not d then
table.insert(g,i)
end
end

for h,i in g do
table.insert(f,i)
end

return f end


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

local b={Vector3=
function(b)
local c=b:split" "
return Vector3.new(c[1]or 0,c[2]or 0,c[3]or 0)
end,Color3=
function(b)
local c=b:split" "
return Color3.new(c[1]or 0,c[2]or 0,c[3]or 0)
end
}

aa.stringify=function(c, d)
local e=ab[typeof(d)]
assert(e,"can't convert to string")

return e(d)end


aa.unstringify=function(c, d, e)
local f=b[e]
assert(f,"can't convert to value")

return f(d)end


return aa end a.cu=function()local ab=a.cache.cu if not ab then ab={c=aa()}a.cache.cu=ab end return ab.c end end do local aa=function()
local aa={}

return aa end a.cv=function()local ab=a.cache.cv if not ab then ab={c=aa()}a.cache.cv=ab end return ab.c end end do local aa=function()
local aa=a.cv()
local ab=a.d()

local b={}

b.setProperties=function(c, d)
for e,f in d do
if aa[e]then
aa[e](c,f)
continue
end


if type(e)=="number"and typeof(f)=="Instance"then
f.Parent=c
continue
end

c[e]=f
end
return c end


b.setup=function(c, ...)
for d,e in{...}do
local f=typeof(e)

if f=="table"then
b.setProperties(c,e)
else
local g=if f=="string"then"Name"else"Parent"
c[g]=e
end
end
return c end


b.new=function(c, ...)
local d=Instance.new(c)
return b.setup(d,...)end


return b end a.cw=function()local ab=a.cache.cw if not ab then ab={c=aa()}a.cache.cw=ab end return ab.c end end do local aa=function()
local aa=a.n()
local ab=a.d()

local b="https://raw.githubusercontent.com/%s/%s/refs/heads/main/"
b=b:format(aa.owner,aa.repository)

local c={}local d=function(

d)
return game:HttpGet(d)end


c.fetch=function(e)
if e:sub(1,1)=="/"then
e=e:sub(2)
end

local f,g=pcall(d,b..e)

if not f then
ab:warn(`failed to fetch http url '{e}':\n\t{g}`)
return
end

return g end


return c end a.cx=function()local ab=a.cache.cx if not ab then ab={c=aa()}a.cache.cx=ab end return ab.c end end do local aa=function()
local aa=a.h()
local ab=aa.CoreGui

local b={}
b.__index=b

b.destroy=function(c)
c.message:destroy()
setmetatable(c,nil)end


b.set=function(c, d)
if d and#d>0 then
c.message.Text=d
c.message.Parent=ab
else
c.message.Parent=nil
end end


b.new=function()
return setmetatable({
message=Instance.new"Message"
},b)end


return b end a.cy=function()local ab=a.cache.cy if not ab then ab={c=aa()}a.cache.cy=ab end return ab.c end end do local aa=function()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cz=function()local ab=a.cache.cz if not ab then ab={c=aa()}a.cache.cz=ab end return ab.c end end do local aa=function()
local aa=a.cz()

local ab={}

ab.getScale=function(b, c)
return aa.isEnabled and(c*aa.animationScale)or 0 end


ab.getScrollSpeed=function(b, c)
return(c*aa.scrollSpeed)end


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

for b,c in aa do
local d=string.lower(c.DisplayName)
ab[d]=c
end

return ab end a.cF=function()local ab=a.cache.cF if not ab then ab={c=aa()}a.cache.cF=ab end return ab.c end end do local aa=function()
local aa={}

local ab="abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUV_0123456789"

local b={
["&"]="&amp;",
["<"]="&lt;",
[">"]="&gt;",
["\""]="&quot;",
["'"]="&apos;"
}

aa.randomString=function(c)
local d={}
for e=1,c do
local f=math.random(1,#ab)
table.insert(d,ab:sub(f,f))
end
return table.concat(d)end


aa.getDeep=function(c, d)
for e in d:gmatch"[^%.]+"do
c=c[e]
end
return c end


aa.simpleCreate=function(c, d)
local e=Instance.new(c)
for f,g in d do
e[f]=g
end
return e end


aa.chararray=function(c)
local d={}
for e=1,#c do
table.insert(d,c:sub(e,e))
end
return d end


aa.lookupify=function(c)
local d={}
for e=1,#c do
local f=c[e]
d[f]=true
end
return d end


aa.unlookupify=function(c)
local d={}
for e,f in c do
table.insert(d,e)
end
return d end


aa.escapeRichText=function(c)
local d=tostring(c):gsub(".",function(d)
return b[d]or d
end)
return d end


aa.charset=function(c)
local d={}
for e in c:gmatch"."do
d[e]=true
end
return d end


aa.versionToNumber=function(c)
local d=c:gsub("^v","")

local e=0
local f=d:split"."

for g,h in f do
local i=tonumber(h)or 0
e=e+i*math.pow(1000,3-g)
end

return e end


aa.colorFromRGB=function(c, d)
return`<font color="#{d:ToHex()}">{c}</font>`end


aa.richFontSize=function(c, d)
return`<font size="{d}">{c}</font>`end


return aa end a.cG=function()local ab=a.cache.cG if not ab then ab={c=aa()}a.cache.cG=ab end return ab.c end end do local aa=function()
local aa=a.cF()

local ab=a.d()
local b=a.cG()

local c={
objects={},
selectedTheme=nil
}

c.selectTheme=function(d, e)
ab:expect(e,{"string"},"'themeService:selectTheme' #1")

local f=aa[e:lower()]

if not f then
ab:error(`'{e}' isn't a valid theme`)
return
end

if f~=d.selectedTheme then
d.selectedTheme=f
d:updateObjects()
end

return d end


c.updateObject=function(d, e)

d:updateObjectProperties(e,d.objects[e])end


c.updateObjectProperties=function(d, 
e, 
f)

for g,h in f do
e[g]=b.getDeep(d.selectedTheme,h)
end end


c.updateObjects=function(d)
for e,f in d.objects do
d:updateObject(e)
end end


c.addObject=function(d, e, f)
d.objects[e]=f
d:updateObject(e)end



c.init=function(d, e)
ab:expect(e,{"table"},"'themeService:init' #1")

if e.theme~=nil then
d:selectTheme(e.theme)
end end


return c end a.cH=function()local ab=a.cache.cH if not ab then ab={c=aa()}a.cache.cH=ab end return ab.c end end do local aa=function()


local aa=a.cB()
local ab=a.d()

local b=aa.specialProps
local c=a.cH()

b.ThemeTag=function(d, e)
if type(e)~="table"then
ab:error"expected a 'table' when setting a theme tag"
return
end

c:addObject(d,e)end


return a.cw()end a.cI=function()local ab=a.cache.cI if not ab then ab={c=aa()}a.cache.cI=ab end return ab.c end end do local aa=function()return{bindsandplugins="rbxassetid://5147695474",close="rbxassetid://5054663650",editaliases="rbxassetid://5147488658",editkeybinds="rbxassetid://129697930",edittheme="rbxassetid://4911962991",editwaypoints="rbxassetid://5147488592",imgstudiopluginlogo="rbxassetid://4113050383",logo="rbxassetid://1352543873",minimize="rbxassetid://2406617031",pin="rbxassetid://6234691350",reference="rbxassetid://3523243755",settings="rbxassetid://1204397029",}end a.cJ=function()local ab=a.cache.cJ if not ab then ab={c=aa()}a.cache.cJ=ab end return ab.c end end do local aa=function()local aa=a.a()
local ab=a.p()

local b=ab.storage.imagePath

local c=a.k()
local d=a.cx()
local e=a.d()

local f=a.cJ()

local g={}
local h={}

local i=aa.getcustomasset

local j={}

j.newCustomAsset=function(k, l, m)
e:assert(not g[l],"asset is already loaded")

local n=c:getCustomAsset(m)

if n==nil then
n=f[l]
g[l]=n
return n
end

e:log(`new custom asset to '{m}': '{n}'`)
return n end


j.get=function(k, l)
if g[l]then
return g[l]
end

if type(i)~="function"then
return f[l]
end

local m=b:format(l)
e:log(`loading asset: '{m}'`)

if c:exist(m)then
return k:newCustomAsset(l,m)
end

local n=d.fetch(m)

if n==nil then
local o=f[l]
g[l]=o
return o
end

c:writeFile(m,n)
e:log(`created a file to asset: '{m}'`)

return k:newCustomAsset(l,m)end


j.loadImage=function(k, l, m)
e:assert(f[m],`invalid asset name: {m}`)

local n=g[m]
if n~=nil then
l.Image=n
return
end

l.Image=""

if h[m]then
table.insert(h[m],l)
return
end

h[m]={l}

task.defer(function()
local o=k:get(m)
if not o then return end

for p,q in h[m]do
q.Image=o
end

h[m]=nil
end)end


return j end a.cK=function()local ab=a.cache.cK if not ab then ab={c=aa()}a.cache.cK=ab end return ab.c end end do local aa=function()



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
local b=Color3.fromRGB(156,121,223)
local c=Color3.fromRGB(225,37,105)
local d=Color3.fromRGB(118,113,94)
local e=Color3.fromRGB(97,181,195)
local f=Color3.fromRGB(254,193,7)
local g=Color3.fromRGB(244,66,54)
local h=Color3.fromRGB(166,227,45)
local i=Color3.fromRGB(255,149,75)

return{
args={number=
b,boolean=
b,text=
ab,string=
ab,symbol=
c,comment=
d,others=
e,warn=
f,error=
g,valid=
h,tag=
i
},
commands={undefined=
g,client=
ab,deprecated=
d
}
}end a.cM=function()local ab=a.cache.cM if not ab then ab={c=aa()}a.cache.cM=ab end return ab.c end end do local aa=function()







local aa=a.cM().args
local ab=a.cG()

local b={}


local c=ab.charset":#()[]<>{}-––&*$%@"


local d="^[%w_%.]+"


local e="^[%w_]+"local f=function(

f)
return f~=""and string.match(f,"[%w_%.]")~=nil end local g=function(


g)
return string.match(g,"^%d+$")~=nil or string.match(g,"^%d+%.%d+$")~=nil end local h=function(



h)
local i={}local j=function(

j, k, l)
if j==""then
return
end

local m=i[#i]
if m and m.color==k and m.bold==l then
m.text=m.text..j
else
table.insert(i,{text=j,color=k,bold=l})
end end


local k=1
local l=#h

while k<=l do
local m=string.sub(h,k,k)
local n=if k>1 then string.sub(h,k-1,k-1)else""


if(m=="@"or m=="#")and not f(n)then
local o,p=string.find(h,e,k+1)
if p then
j(string.sub(h,k,p),aa.tag,true)
k=p+1
continue
end
end

if f(m)then
local o,p=string.find(h,d,k)
local q=string.sub(h,k,p)
j(q,if g(q)then aa.number else nil,false)
k=p+1
else
j(m,if c[m]then aa.symbol else nil,false)
k=k+1
end
end

return i end


b.apply=function(i, j)
local k={}

for l,m in h(tostring(j))do
local n=ab.escapeRichText(m.text)

if m.color then
n=ab.colorFromRGB(n,m.color)
end
if m.bold then
n=`<b>{n}</b>`
end

table.insert(k,n)
end

return table.concat(k)end


return b end a.cN=function()local ab=a.cache.cN if not ab then ab={c=aa()}a.cache.cN=ab end return ab.c end end do local aa=function()



local aa=a.cI()
local ab=a.cK()
local b=a.cH()

local c=a.bl()
local d=a.h()
local e=a.cL()

local f=a.cN()

local g=4
local h=8

local i={
container=nil,

items={},
nextOrder=0,

queue={},
}local j=function(

j, k)
local l=aa.new("Frame","Notification",j,{
BorderSizePixel=0,
ClipsDescendants=true,
LayoutOrder=k,
Size=UDim2.fromOffset(e.size.X.Offset,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local m=g+e.iconSize+h

local n=aa.new("TextLabel","Title",l,{
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0),
Size=UDim2.new(1,-m*2,0,e.titleHeight),
Text="",
TextSize=e.titleTextSize,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local o=aa.new("Frame","Description",l,{
AnchorPoint=Vector2.new(0.5,1),
ClipsDescendants=true,
Position=UDim2.new(0.5,0,1,-5),
Size=UDim2.new(1,-10,1,-25),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})

aa.new("UICorner",o,{
CornerRadius=UDim.new(0,e.cornerRadius),
})

local p=aa.new("TextLabel","Text",o,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.new(1,-10,1,-10),
Text="",
TextSize=e.textSize,
RichText=true,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

local q=aa.new("ImageButton","PinButton",l,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,g,0,e.titleHeight/2),
Size=UDim2.fromOffset(e.iconSize,e.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local r=aa.new("ImageButton","CloseButton",l,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-g,0,e.titleHeight/2),
Size=UDim2.fromOffset(e.iconSize,e.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(q,"pin")
ab:loadImage(r,"close")

return l,n,p,q,r end local k=function(


k)
for l,m in k.connections do
c:disconnect(m)
end

table.clear(k.connections)end


i.getContainer=function(l, m)
if l.container then
return l.container
end

local n=aa.new("Frame","Notifications",m,{
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(e.size.X.Offset,0),
})

aa.new("UIListLayout",n,{
Padding=UDim.new(0,e.spacing),
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
l:add(q.title,q.message,q.duration)
end

return n end



i.getStackHeight=function(l)
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
o=o+(n-1)*e.spacing
end

return o end



i.refreshLayout=function(l)
local m=l.container
if not m then return end

m.Size=UDim2.fromOffset(e.size.X.Offset,l:getStackHeight())

if l.onLayoutChanged then
l.onLayoutChanged()
end end


i.tweenHeight=function(l, m, n)
if m.tween then
m.tween:Cancel()
end

local o=TweenInfo.new(e.tweenTime,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
m.tween=d.TweenService:Create(m.frame,o,{
Size=UDim2.fromOffset(e.size.X.Offset,n),
})
m.tween:Play()end


i.pin=function(l, m)
if m.pinned or m.removed then return end
m.pinned=true

m.titleLabel.Text=m.title.." (Pinned)"
b:addObject(m.pinButton,{ImageColor3="Colors.Primary"})

local n=m.titleLabel
task.spawn(function()
n.TextTransparency=0.5
task.wait(e.flashTime)
n.TextTransparency=0
end)end


i.remove=function(l, m)
if m.removed then return end
m.removed=true

local n=table.find(l.items,m)
if n then
table.remove(l.items,n)
end

k(m)

l:tweenHeight(m,0)
task.delay(e.tweenTime,function()
m.frame:Destroy()
end)end


i.trim=function(l)
while#l.items>e.maxVisible do
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


i.add=function(l, m, n, o)
l.nextOrder=l.nextOrder+1

local p={
title=m,
pinned=false,
removed=false,
connections={},
}

p.frame,p.titleLabel,p.textLabel,p.pinButton,p.closeButton=
j(l.container,l.nextOrder)

p.titleLabel.Text=m
p.textLabel.Text=f:apply(n)

table.insert(p.connections,c:Connect(p.pinButton.Activated,function()
l:pin(p)
end))

table.insert(p.connections,c:Connect(p.closeButton.Activated,function()
l:remove(p)
end))

table.insert(l.items,p)
l:tweenHeight(p,e.size.Y.Offset)


p.frame:GetPropertyChangedSignal"Size":Connect(function()
l:refreshLayout()
end)
l:refreshLayout()

local q=if type(o)=="number"then o else e.defaultTime
task.delay(q,function()
if not p.pinned then
l:remove(p)
end
end)

l:trim()end


i.notify=function(l, m, n, o)
if n==nil then
n=m
m=e.defaultTitle
end

m=tostring(m)

if not l.container then
table.insert(l.queue,{title=m,message=n,duration=o})
return
end

l:add(m,n,o)end


i.destroy=function(l)
for m,n in l.items do
k(n)
end

table.clear(l.items)
table.clear(l.queue)
l.container=nil end


return i end a.cO=function()local ab=a.cache.cO if not ab then ab={c=aa()}a.cache.cO=ab end return ab.c end end do local aa=function()


local aa=a.b()
local ab=a.d()

local b={

_callbacks={},
_nextId=0,
}local c=function(


c)
while true do
task.wait()

if next(c._callbacks)==nil then
aa.loopThread=nil
return
end

local d=os.clock()

for e,f in c._callbacks do
if d-f.lastCall>=f.cooldown then
f.lastCall=d
task.defer(f.func)
end
end
end end



b.start=function(d)
if aa.loopThread~=nil then
return
end

aa.loopThread=task.defer(c,d)end



b.stop=function(d)
local e=aa.loopThread
aa.loopThread=nil
table.clear(d._callbacks)

if e~=nil then
task.cancel(e)
end end




b.add=function(d, e, f)
ab:expect(e,{"function"},"'loopService:add' #1")
ab:expect(f,{"number","nil"},"'loopService:add' #2")

d._nextId=d._nextId+1
local g=d._nextId

d._callbacks[g]={
func=e,
cooldown=math.max(f or 0,0),
lastCall=-math.huge
}

d:start()
return g end



b.remove=function(d, e)
ab:expect(e,{"number"},"'loopService:remove' #1")
d._callbacks[e]=nil end


return b end a.cP=function()local ab=a.cache.cP if not ab then ab={c=aa()}a.cache.cP=ab end return ab.c end end do local aa=function()
local aa=a.b()
local ab=a.a()

local b=a.cr()
local c=a.cs()
local d=a.d()

local e=a.bz().usedCmds
local f=a.h()
local g=a.p()

local h=a.ct()
local i=a.cn()
local j=a.cp()

local k=g.commands.cmdsRank
local l=k.maxTimesUsed
local m=k.decreasePerUse
local n=k.increasePerUse

local o=aa.iyGarbages or{}
aa.iyGarbages=o

local p={
garbages=o
}

p.registerGarbage=function(q, r)
return q:getGarbage(r)or q:createGarbage(r)end


p.createGarbage=function(q, r)
if q.garbages[r]==nil then
local s={}
q.garbages[r]=s
return s
end end



p.getCommandData=function(q, r)
return b.lookup[r:lower()]end


p.hasGarbage=function(q, r)
return q.garbages[r]~=nil end


p.getGarbage=function(q, r)
return q.garbages[r]end


p.collectGarbage=function(q, r)
local s=q.garbages[r]

if s~=nil then
q.garbages[r]=nil
return s
end end


p.commandUsed=function(q, r)
local s=e:getValue(r)or 0

local t=math.clamp(s+n,0,l)
e:setValue(r,t)

for u,v in e:getData()do
if u==r then continue end

local w=(t==l)

if(w or v<t)and v>0 then
v=v-m

if v==0 then v=nil end
e:setValue(u,v)
end
end

e:save()end local q=function(



q)
local r={}
if q and q.args then
for s,t in q.args do
r[s]={value=t.value}
end
end
return r end




local r=setmetatable({},{__mode="k"})


p.run=function(s, t, u, v)
d:expect(t,{"string"},"'commandsController:run' #1")
d:expect(u,{"table","nil"},"'commandsController:run' #2")

local w=b.lookup[t]
d:assert(w,"invalid command")

local x=coroutine.running()
local y=r[x]~=nil
local z=y and not v

if not z then
s:commandUsed(w.name)


local A=q(u)
s.privateEnv.lastArgs=s.privateEnv.lastArgs or{}
s.privateEnv.lastArgs[w.name]=A

if w.name~="lastcommand"then
s.privateEnv.lastCommand={
name=w.name,
args=A
}
end
end

if w.run==nil then
d:warn(`missing command run func: {w.name}`)
return
end

r[x]=true
local A,B=pcall(w.run,s,u)
if not y then
r[x]=nil
end

if not A then
error(B,0)
end end



p.getLastArgs=function(s, t)
local u=s.privateEnv.lastArgs
return u and u[t]end local s=function(


s)
local t=b.lookup[s:lower()]
if t==nil then return 0 end


return e:getValue(t.name)or 0 end


p.search=function(t, u, v)
local w=h:searchAtArray(b.array,u,v)
local x=u:lower()
local y={}

for z,A in w do
table.insert(y,{
alias=A,
index=z,
isPrefix=A:lower():sub(1,#x)==x,
usage=s(A),
})
end

table.sort(y,function(z,A)
if z.isPrefix~=A.isPrefix then return z.isPrefix end
if z.usage~=A.usage then return z.usage>A.usage end
return z.index<A.index
end)

local z={}
for A,B in y do
z[A]=B.alias
end

return z end


p.init=function(t, u)
d:assert(u,"'commandsController:init' #1 expected a config to init")

local v=a.bl()
local w=a.cu()
local x=a.cO()


t.notify=function(y, ...)
return x:notify(...)end


t.stringify=function(y, ...)
return w:stringify(...)end


t.unstringify=function(y, ...)
return w:unstringify(...)end


t.connect=function(y, ...)
return v:Connect(...)end


t.expectExploit=function(y, z)
local A=ab[z]
if A~=nil then return A end

y:notify("Incompatible Exploit",`Your exploit does not support this command (missing {z})`)end


t.getRoot=function(y)
local z=y.playerService:getRootPart()
if z then return z end

y:notify("Character","your character is not loaded")end



t.localPlayer=a.af()
t.executorEnv=ab
t.privateEnv=aa


t.infiniteYield=u.infiniteYield
t.playerService=u.playerService
t.fetchService=u.fetchService


t.signals={
onCameraReset=c.new()
}


t.config={
links=g.links
}


t.userSettings=UserSettings()
t.gameSettings=settings()

t.userGameSettings=t.userSettings:GetService"UserGameSettings"
t.gameNetworkSettings=t.gameSettings:GetService"NetworkSettings"


t.loopService=a.cP()


t.storage=a.bz()


t.robloxServices=f
t.rbxServices=f

t.teleportService=f.TeleportService
t.groupService=f.GroupService
t.runService=f.RunService
t.starterGui=f.StarterGui
t.coreGui=f.CoreGui
t.players=f.Players
t.guiService=f.GuiService
t.networkClient=f.NetworkClient
t.proximityPromptService=f.ProximityPromptService
t.commandsList=b


i.restore(b)


for y,z in j.restore(b)do
d:warn(`plugin '{y}' could not be loaded: {z}`)
end end


return p end a.cQ=function()local ab=a.cache.cQ if not ab then ab={c=aa()}a.cache.cQ=ab end return ab.c end end do local aa=function()



local aa=a.cr()local ab=function()


local ab={}
local b="unknown"

for c,d in aa.original do
if d.isSection then
b=d.sectionName
elseif d.run==nil then
table.insert(ab,{section=b,name=d.name})
end
end

return ab end


return function(b)
local c=ab()
if#c==0 then
return
end

local d={}
local e={}

for f,g in c do
if not d[g.section]then
d[g.section]={}
table.insert(e,g.section)
end
table.insert(d[g.section],g.name)
end

local f={}
for g,h in e do
local i=table.concat(d[h],", ")
table.insert(f,`[{h}] {i}`)
end

local g=table.concat(f,"\n")

b:notify("Commands without run",`{#c} command(s) still need a run function, see console`)
end end a.cR=function()local ab=a.cache.cR if not ab then ab={c=aa()}a.cache.cR=ab end return ab.c end end do local aa=function()
return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.cS=function()local ab=a.cache.cS if not ab then ab={c=aa()}a.cache.cS=ab end return ab.c end end do local aa=function()



local aa={}

local ab=a.p()
local b=a.cS()

aa.getEasterDate=function()
local c=tonumber(os.date"%Y")

local d=math.floor(c/100)
local e=math.floor((13+8*d)/25)
local f=(15-e+d-math.floor(d/4))%30
local g=(4+d-math.floor(d/4))%7

local h=(19*(c%19)+f)%30
local i=(2*(c%4)+4*(c%7)+6*h+g)%7
local j=22+h+i

if h==29 and i==6 then
return"04 19"
elseif h==28 and i==6 then
return"04 18"
end

if j>31 then
return string.format("04 %02d",j-31)
end

return string.format("03 %02d",j)end


aa.getHolidayEmoji=function()
local c=aa.getEasterDate()

local d={
["01 01"]=b.NEW_YEAR,
["02 14"]=b.VALENTINE_DAYS,
["03 17"]=b.CLOVER,
["10 31"]=b.HALLOWEEN,
["12 25"]=b.CHRISTMAS,
[c]=b.EASTER
}

local e=os.date"%m %d"
return d[e]end


aa.getDisplayName=function()
local c=ab.applicationName
local d=ab.version

c=string.gsub(c,"!VERSION",d)

local e=aa.getHolidayEmoji()

if e then
c=`{e} {c} {e}`
end

return c end


return aa end a.cT=function()local ab=a.cache.cT if not ab then ab={c=aa()}a.cache.cT=ab end return ab.c end end do local aa=function()
return{
uiScale=Instance.new"UIScale",
getScale=function(aa)
local ab=aa.uiScale
return ab and(ab:GetAttribute"REAL_SCALE"or ab.Scale)or 1
end,
setScale=function(aa,ab)
local b=aa.uiScale

if b then
b.Scale=ab
b:SetAttribute("REAL_SCALE",ab)
end
end
}end a.cU=function()local ab=a.cache.cU if not ab then ab={c=aa()}a.cache.cU=ab end return ab.c end end do local aa=function()





local aa={}



aa.compute=function(ab, b, c, d)
local e=b.width-ab.right-d
local f=ab.left-d


local g
if e>=c.width then
g=true
elseif f>=c.width then
g=false
else
g=e>=f
end



local h=ab.top+(ab.bottom-ab.top)/2
local i=h>b.height/2

local j=if g then ab.right+d else ab.left-d
local k=if i then ab.bottom-c.height else ab.top


k=math.clamp(k,0,math.max(b.height-c.height,0))

return{
x=j,
y=k,
anchorX=if g then 0 else 1,
}end


return aa end a.cV=function()local ab=a.cache.cV if not ab then ab={c=aa()}a.cache.cV=ab end return ab.c end end do local aa=function()



local aa=a.cI()

local ab={}

ab.create=function(b)
local c=aa.new("Frame","MainFrame",{
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

local d=c.TopBar

local e=aa.new("TextLabel","Title",d,{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
TextSize=16,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.Normal"
}
})

local f=aa.new("ImageButton",d,{
Name="SettingsButton",
BackgroundTransparency=1,
Position=UDim2.new(1,-2,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Size=UDim2.fromOffset(19,19),
ThemeTag={
ImageColor3="Colors.Icons"
}
})

local g=aa.new("ImageButton",d,{
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
mainFrame=c,
topBar=d,
titleLabel=e,
buttons={
settings=f,
reference=g
}
}end


return ab end a.cW=function()local ab=a.cache.cW if not ab then ab={c=aa()}a.cache.cW=ab end return ab.c end end do local aa=function()

local aa=a.cI()

local ab={up=
function(ab,b)
local c=1/ab
local d=b/ab

local e=UDim2.fromScale(d,c)
local f=UDim2.fromScale(
0.5-(d/2),
(b-1)*c
)
return e,f
end,down=
function(ab,b)
local c=1/ab
local d=b/ab

local e=UDim2.fromScale(d,c)
local f=UDim2.fromScale(
0.5-(d/2),
1-(b*c)
)
return e,f
end,left=
function(ab,b)
local c=1/ab
local d=b/ab

local e=UDim2.fromScale(c,d)
local f=UDim2.fromScale(
(b-1)*c,
0.5-(d/2)
)
return e,f
end,right=
function(ab,b)
local c=1/ab
local d=b/ab

local e=UDim2.fromScale(c,d)
local f=UDim2.fromScale(
1-(b*c),
0.5-(d/2)
)
return e,f
end
}

return function(b,c,d)
local e=ab[d]
if not e then
error("r u ok? Invalid direction: "..tostring(d))
end

local f=aa.new("Frame","Arrow",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
aa.new("UIScale",{
Scale=c
})
})

for g=1,b do
local h,i=e(b,g)

aa.new("Frame",`line_{g}`,{
BackgroundColor3=Color3.fromRGB(220,220,220),
BorderSizePixel=0,
Size=h,
Position=i,
Parent=f,
ThemeTag={
BackgroundColor3="Colors.Icons"
}
})
end

return f
end end a.cX=function()local ab=a.cache.cX if not ab then ab={c=aa()}a.cache.cX=ab end return ab.c end end do local aa=function()
return{
pressingInputs={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}
}end a.cY=function()local ab=a.cache.cY if not ab then ab={c=aa()}a.cache.cY=ab end return ab.c end end do local aa=function()
local aa=a.bl()
local ab=a.h()
local b=a.cI()
local c=a.ag()
local d=a.cH()

local e=a.cX()
local f=a.cU()

local g=a.cs()

local h=a.cY()

local i=ab.UserInputService

local j={}
j.__index=j local k=function(

k)
return h.pressingInputs[k.UserInputType]~=nil end


j.awake=function(l)
local m=c:getMouse()

local n=l.scrollThumbFrame
local o=l.scrollThumb
local p=l.scrollBar

local q=false
local r=false
local s local t=function(

t, u)local v=function()

if q then return end
if not l:canScroll(u)then return end

q=true

l:scrollToDirection(u)

local v
v=aa:Connect(i.InputEnded,function(w)
if not k(w)then return end

v:Disconnect()
q=false
end)

task.wait(0.4)

while l:canScroll(u)and q do
l:scrollToDirection(u)
task.wait(6.666666666666666E-2)
end end


aa:Connect(t.MouseButton1Down,v)end




t(l.upButton,"up")
t(l.downButton,"down")

aa:Connect(p.MouseWheelForward,function()
l:scrollTo(l.index-l.wheelIncrement)
end)

aa:Connect(p.MouseWheelBackward,function()
l:scrollTo(l.index+l.wheelIncrement)
end)

aa:Connect(p.InputBegan,function(u)
if not k(u)then return end
if l:isScrollBarDisabled()then return end

local v=not c:isMouseInGuiObject(o)
local w=l.isHorizontal and"X"or"Y"

local x
r=true

d:updateObjectProperties(o,{
BackgroundColor3="Colors.Primary"
})

local y=m[w]-o.AbsolutePosition[w]
local z
local A local B=function()


if z then z:Disconnect()end
if A then A:Disconnect()end end


z=aa:Connect(i.InputEnded,function(C)
if not k(C)then return end

B()
r=false

d:updateObjectProperties(o,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if v then local C=function()

local C=(m[w]>=o.AbsolutePosition[w]+o.AbsoluteSize[w])and 1 or 0
local D=l.visibleSpace-1

if C==0 and(
m[w]<o.AbsolutePosition[w]
)then
l:scrollTo(l.index-D)
elseif C==1 and(
m[w]>=o.AbsolutePosition[w]+o.AbsoluteSize[w]
)then
l:scrollTo(l.index+D)
end end


while r do
C()
task.wait(0.25)
end
return
end

A=aa:Connect(i.InputChanged,function(C)
if not r then return end
if not k(C)then return end

local D=n.AbsoluteSize[w]-o.AbsoluteSize[w]
local E=m[w]-n.AbsolutePosition[w]-y

if E>D then
E=D
elseif E<0 then
E=0
end

if x~=E then
x=E
l:scrollTo(math.floor(0.5+E/D*(l.totalSpace-l.visibleSpace)))
end
end)
end)end


j.create=function(l)
l.upButton=b.new("ImageButton",l.upButtonName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

l.downButton=b.new("ImageButton",l.downButtoName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

l:createButtonsArrows()

local m=b.new("Frame","ScrollBar",{
Active=true,
BackgroundTransparency=1,

l.upButton,
l.downButton,

b.new("Frame","ScrollThumbFrame",{
BackgroundTransparency=1,
AnchorPoint=l.isHorizontal
and Vector2.new(0.5,0)
or Vector2.new(0,0.5),
Position=l.isHorizontal
and UDim2.fromScale(0.5,0)
or UDim2.fromScale(0,0.5),

b.new("Frame","ScrollThumb",{
AnchorPoint=l.isHorizontal
and Vector2.new(0,0.5)
or Vector2.new(0.5,0),
ThemeTag={
BackgroundColor3="Colors.OnPrimary"
},

b.new("UICorner",{
CornerRadius=UDim.new(0,4),
}),
}),

b.new("Frame","MarkerFrame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
}),
}),
})

l.scrollBar=m
l.scrollThumbFrame=m.ScrollThumbFrame
l.scrollThumb=m.ScrollThumbFrame.ScrollThumb
l.markerFrame=m.ScrollThumbFrame.MarkerFrame

l.container=b.new("Frame","Container",{
BackgroundTransparency=1,
ClipsDescendants=true,
Active=true
})

l:setScrollBarThickness(l.barThickness)
l:awake()
l:update()


return m end


j.createButtonsArrows=function(l)
local m=l.downButton
local n=l.upButton

e(4,0.55,m.Name).Parent=m
e(4,0.55,n.Name).Parent=n end


j.canScrollUp=function(l)
return l:isScrollBarEnabled()and l.index>0 end


j.canScrollDown=function(l)
local m=l:isScrollBarEnabled()
return m and l.index+l.visibleSpace<l.totalSpace end


j.canScroll=function(l, m)
if m=="up"or m=="left"then
return l:canScrollUp()
elseif m=="down"or m=="right"then
return l:canScrollDown()
end
return false end


j.getScrollPercent=function(l)
local m=l.totalSpace-l.visibleSpace
if m<=0 then return 0 end
return l.index/m end


j.scrollTo=function(l, m, n)
local o=math.max(0,l.totalSpace-l.visibleSpace)

l.index=math.clamp(m,0,o)
l:update()

if not n then
l.scrolledSignal:Fire(l.index)
end end


j.scrollUp=function(l)
l:scrollTo(l.index-l.increment)end


j.scrollDown=function(l)
l:scrollTo(l.index+l.increment)end


j.scrollToDirection=function(l, m)
if m=="up"or m=="left"then
return l:scrollUp()
elseif m=="down"or m=="right"then
return l:scrollDown()
end end


j.isVisible=function(l, m)
local n=l.index
if m>=n and m<(n+l.visibleSpace)then
return true
end
return false end


j.setScrollPercent=function(l, m)
local n=l.totalSpace-l.visibleSpace
l:scrollTo(math.floor(m*n))end


j.update=function(l)
l:drawThumb()end


j.setScrollBarThickness=function(l, m)
local n=l.scrollThumbFrame
local o=l.downButton
local p=l.container
local q=l.scrollBar
local r=l.upButton

l.barThickness=m

if p then
p.Size=UDim2.new(
1,
l.isHorizontal and 0 or-m,
1,
l.isHorizontal and-m or 0
)
end

if q then
q.Size=l.isHorizontal
and UDim2.new(1,0,0,m)
or UDim2.new(0,m,1,0)
q.Position=l.isHorizontal
and UDim2.new(0,0,1,-m)
or UDim2.new(1,-m,0,0)
end

if n then
n.Size=l.isHorizontal
and UDim2.new(1,-(m*2),0,m)
or UDim2.new(0,m,1,-(m*2))
end

if o then
o.Size=UDim2.fromOffset(m,m)
o.Position=l.isHorizontal
and UDim2.new(1,-m,0,0)
or UDim2.new(0,0,1,-m)
end

if r then
r.Size=UDim2.fromOffset(m,m)
r.Position=UDim2.fromOffset(0,0)
end end


j.updateArrowTransparency=function(l, m, n)
if not m:FindFirstChild"Arrow"then return end

for o,p in m.Arrow:GetChildren()do
if not p:IsA"GuiObject"then continue end
p.Transparency=n and 0.6 or 0
end end


j.drawThumb=function(l)
local m=l.scrollThumb
local n=l.scrollThumbFrame

local o=l:canScrollUp()
local p=l:canScrollDown()

l:updateArrowTransparency(l.upButton,not o)
l:updateArrowTransparency(l.downButton,not p)

if not m or not n then return end

if not o and not p then
m.Visible=false
return
end

m.Visible=true

local q=l:getScrollPercent()
local r=f:getScale()
local s=l.barThickness

if l.isHorizontal then
local t=n.AbsoluteSize.X/r
local u=math.max(s,(l.visibleSpace/l.totalSpace)*t)
m.Size=UDim2.new(0,u,1,-2)
m.Position=UDim2.new(0,q*(t-u),0.5,0)
else
local t=n.AbsoluteSize.Y/r
local u=math.max(s,(l.visibleSpace/l.totalSpace)*t)
m.Size=UDim2.new(1,-2,0,u)
m.Position=UDim2.new(0.5,0,0,q*(t-u))
end end


j.addMarker=function(l, m, n)
l.markers[m]=n or Color3.new(1,1,0)
l:updateMarkers()end


j.removeMarker=function(l, m)
l.markers[m]=nil
l:updateMarkers()end


j.updateMarkers=function(l)
local m=l.markerFrame
if not m then return end

for n,o in pairs(m:GetChildren())do
o:Destroy()
end

for n,o in pairs(l.markers)do
if n>=l.totalSpace then continue end

local p=Instance.new"Frame"
p.BackgroundColor3=o
p.BorderSizePixel=0
p.BackgroundTransparency=0
p.Parent=m

local q=n/l.totalSpace
if l.isHorizontal then
p.Position=UDim2.new(q,0,1,-4)
p.Size=UDim2.new(0,2,0,4)
else
p.Position=UDim2.new(1,-4,q,0)
p.Size=UDim2.new(0,4,0,2)
end

p.Name="Marker_"..tostring(n)
end end


j.setTotalSpace=function(l, m)
l.totalSpace=m
l:scrollTo(l.index,true)
l:update()end


j.setVisibleSpace=function(l, m)
l.visibleSpace=m
l:scrollTo(l.index,true)
l:update()end


j.disableScroll=function(l)
l.scrollBarEnabled=false
l:drawThumb()end


j.enableScroll=function(l)
l.scrollBarEnabled=true
l:drawThumb()end


j.isScrollBarEnabled=function(l)
return l.scrollBarEnabled end


j.isScrollBarDisabled=function(l)
return not l.scrollBarEnabled end


j.new=function(l)
local m=setmetatable({
isHorizontal=l.isHorizontal or false,
increment=l.increment or 1,
wheelIncrement=l.wheelIncrement or 3,
barThickness=l.barThickness or 16,

scrollBarEnabled=true,

index=0,
visibleSpace=l.visibleSpace or 0,
totalSpace=l.totalSpace or 0,

markers={},

scrollBar=l.scrollBar or nil,
scrollThumb=l.scrollThumb or nil,
scrollThumbFrame=l.scrollThumbFrame or nil,
markerFrame=l.markerFrame or nil,

scrolledSignal=g.new(),
},j)

m.upButtonName=m.isHorizontal and"left"or"up"
m.downButtoName=m.isHorizontal and"right"or"down"

return m end


return j end a.cZ=function()local ab=a.cache.cZ if not ab then ab={c=aa()}a.cache.cZ=ab end return ab.c end end do local aa=function()
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


return aa end a.c_=function()local ab=a.cache.c_ if not ab then ab={c=aa()}a.cache.c_=ab end return ab.c end end do local aa=function()
local aa=a.h()
local ab=a.ah()
local b=a.cr()
local c=a.bu()
local d=a.bx()
local e=a.bv()
local f=a.cG()

















local g={}local h=function(

h, i, j)
return{
success=false,
message=h,
options=i,
comment=j,
}end



g.normalizeOptions=function(i)
if type(i)=="string"then
return string.split(i,"|")
end
return i or{}end



g.getOptions=function(i, j)
local k=(j and j.options)or i.options
return g.normalizeOptions(k)end local i=function(



i, j)
local k=j:lower()

for l,m in i do
local n=tostring(m)
if n:lower()==k then
return n
end
end

return nil end local j=function(


j)
if type(j)~="table"then return{}end
return f.unlookupify(j)end local k=function(


k)
return{
success=true,
value=k,
color="string",
}end local l=function(


l, m)
local n=g.normalizeOptions(m.options)

if#n==0 then
return k(l)
end

local o=i(n,l)

if o then
return{success=true,value=o,color="string"}
end

return h(" - invalid option",n)end


local m={
["true"]=true,yes=
true,enabled=
true,
["false"]=false,no=
false,disabled=
false,
}local n=function(

n)
local o=m[n:lower()]

if o==nil then
return h(" - invalid boolean",{"false","true"})
end

return{
success=true,
value=o,
color="boolean",
}end local o=function(


o, p)
local q=tonumber(o)

if q==nil or q~=q or math.abs(q)==math.huge then
return h" - invalid number"
end

local r,s=p.min,p.max

if p.clamp then
r,s=p.clamp[1],p.clamp[2]
end

if r and q<r then
return h(` - the <b>MIN</b> is <b>{r}</b>`)
end

if s and q>s then
return h(` - the <b>MAX</b> is <b>{s}</b>`)
end

if p.floor and math.floor(q)~=q then
return h" - whole numbers only"
end


if tonumber(string.format("%.5f",q))~=q then
return h" - too many decimal places"
end

return{
success=true,
value=q,
display=`<b>{o}</b>`,
color="number",
}end local p=function(


p)
local q=p:split","

if#q>3 then
return h" - too many args"
end

local r={}

for s,t in q do

if t:match"^%s*$"then
t="0"
end

local u=o(t,{})

if not u.success then
return u
end

r[s]=u.value
end

if#r~=3 then
return{
success=false,
comment=true,
message=`: {({"X","Y","Z"})[#r+1]}`,
}
end

local s=Vector3.new(r[1],r[2],r[3])

return{
success=true,
value=s,
display=`({s})`,
color="others",
}end local q=function(


q)
local r=q:match"^#?(%x%x%x%x%x%x)$"

if r then
local s=tonumber(r:sub(1,2),16)
local t=tonumber(r:sub(3,4),16)
local u=tonumber(r:sub(5,6),16)

return{
success=true,
value=Color3.fromRGB(s,t,u),
color="others",
}
end

local s=q:split","

if#s~=3 then
return h" - use R,G,B or #hex"
end

local t={}

for u,v in s do
local w=o(v,{min=0,max=255,floor=true})

if not w.success then
return w
end

t[u]=w.value
end

return{
success=true,
value=Color3.fromRGB(t[1],t[2],t[3]),
color="others",
}end local r=function(


r)
if r==""then
return h" - player missing"
end

local s=ab.parts(r)

if#s==0 then
return h" - player missing"
end


for t,u in s do
if#ab(u)==0 then
if ab.hasOperators(u)then
return h" - no players match this"
end

if ab.isSelector(u)then
return h" - no players match this selector"
end

local v={}
for w,x in aa.Players:GetPlayers()do
table.insert(v,x.Name)
end

return h(" - player not found",v)
end
end

return{success=true,value=r,color="valid"}end


local s={
"BasePart","Part","MeshPart","Model","Folder","Script","LocalScript",
"ModuleScript","Sound","Humanoid","Tool","ClickDetector",
"ProximityPrompt","TouchTransmitter","SpawnLocation","Seat","VehicleSeat",
}local t=function(

t)

local u=pcall(function()
local u=Instance.new(t)
u:Destroy()
end)

if u then
return{success=true,value=t,color="valid"}
end

return h(" - invalid class name",s)end local u=function(


u)

local v=j(c:getValue(tostring(game.PlaceId)))

if#v==0 then
return h" - no waypoints created"
end

local w=i(v,u)

if w then
return{success=true,value=w,color="valid"}
end

return h(" - invalid waypoint",v)end local v=function(


v)
local w={}

for x,y in aa.Teams:GetTeams()do
table.insert(w,y.Name)
end

if#w==0 then
return h" - there are no teams"
end

local x=i(w,v)

if x then
return{success=true,value=x,color="valid"}
end

return h(" - invalid team",w)end local w=function(


w)
local x=w:lower()
local y={}
local z

for A,B in Enum.KeyCode:GetEnumItems()do
table.insert(y,B.Name)

if B.Name:lower()==x then
z=B
end
end

if z then
return{success=true,value=z,color="valid"}
end

return h(" - invalid key",y)end local x=function(


x)
local y=b.lookup[x:lower()]

if y then
return{success=true,value=y.name,color="valid"}
end

return h(" - invalid command",b.array)end local y=function(



y, z, A, B)
local C=j(y:getData())

if#C==0 then
return h(A)
end

local D=i(C,z)

if D then
return{success=true,value=D,color="valid"}
end

return h(B,C)end local z=function(


z)
return y(d,z," - no custom aliases"," - invalid alias")end local A=function(


A)
return y(e,A," - no plugins installed"," - invalid plugin")end


local B={
string=l,
text=l,
object=k,
boolean=n,
number=o,
vector3=p,
color3=q,
player=r,
waypoint=u,
className=t,
team=v,
keycode=w,
command=x,
alias=z,
plugin=A,
}

g.validate=function(C, D, E)
local F=B[D.kind]

if not F then
return h(` - missing parser {D.kind}`)
end

return F(E,D)end


return g end a.c0=function()local ab=a.cache.c0 if not ab then ab={c=aa()}a.cache.c0=ab end return ab.c end end do local aa=function()

local aa=a.cQ()
local ab=a.ct()

local b=a.cr()
local c=a.cM()

local d=a.cG()
local e=a.c0()

local f=d.colorFromRGB
local g=d.escapeRichText


local h="\\"

local i="^"
local j="inf"

local k="!"

local l=d.lookupify{"`","'","\""}
local m=d.lookupify{" ","\t","\n","\r"}
local n=d.lookupify{",","|","&"}local o=function(

o)
return b.lookup[o]end local p=function(


p, q, r)
local s=c.args
return f(p,s[q]or r or s.others)end local q=function(


q)
local r=q:gsub(".",function(r)
return m[r]and"_"or r
end)
return r end local r=function(


r, s)
if r.name then
return`'{q(r.name)}'`
end
return`#{s}`end local s=function(



s, t, u)
local v=u+1

while true do
local w=s:find(t,v,true)

if not w then
return nil
end

if s:sub(w-1,w-1)~="\\"then
return w
end

v=w+1
end end local t=function(




t, u)
local v={}
local w=u
local x=#t

while w<=x do
local y=t:sub(w,w)

if m[y]or y==h then
break
end

table.insert(v,y)
w=w+1

if n[y]then
while w<=x and m[t:sub(w,w)]do
w=w+1
end
end
end

return table.concat(v),w-1 end local u=function(


u, v, w, x, y, z)
return{
kind=u,
value=v,
usedChar=z,
from=x,
to=y,
raw=w:sub(x,y),
}end local v=function(



v, w)
if w==""then
return"","",v
end

local x,y=v:lower():find(w:lower(),1,true)

if not x then
return"","",v
end

return v:sub(1,x-1),v:sub(x,y),v:sub(y+1)end local w=function(


w, x)
if x then
return x..w..x
end

if w:find"%s"then
return`"{w}"`
end

return w end local x=function(



x, y)
if y then
return g(y)..x..g(y)
end

return x end local y=function(


y, z, A, B)
return{
from=y,
to=z,
text=w(A,B),
}end local z=function(




z)
local A=z:split(i)

if#A>2 then
return nil," - invalid loop"
end

local B
if A[1]:lower()==j then
B=math.huge
else
B=tonumber(A[1])

if B==nil or B<1 or B~=math.floor(B)then
return nil," - invalid loop count"
end
end

local C=0
if A[2]~=nil then
C=tonumber(A[2])

if C==nil or C<0 then
return nil," - invalid loop delay"
end
end

return{count=B,delay=C}end


local A={}
A.__index=A
A.colorFromName=p
A.removeWhiteSpace=q



A.parse=function(B, C)
local D=B.cmdInput
local E={}
local F={}
local G=#C
local H={tokens={},start=1}
local I=1

table.insert(E,H)

while I<=G do
local J=C:sub(I,I)

if m[J]then
I=I+1
elseif J==h then
H.stop=I
H={tokens={},start=I+1}
table.insert(E,H)
I=I+1
else
local K
local L=l[J]and s(C,J,I)

if L then
local M=(C:sub(I+1,L-1):gsub("\\"..J,J))
K=u("string",M,C,I,L,J)
I=L+1
else
local M,N=t(C,I)
K=u("identifier",M,C,I,N)
I=N+1
end

table.insert(H.tokens,K)
table.insert(F,K)
end
end

H.stop=G+1

for J,K in E do
local L=K.tokens[1]
local M=K.tokens[#K.tokens]
local N=if M then M.to+1 else K.start

K.lead=if L then C:sub(K.start,L.from-1)else""
K.spaces=C:sub(N,K.stop-1)
end

local J={}
for K,L in F do
table.insert(J,L.value)
end

local K=E[#E]

D.rawText=C
D.parsed=F
D.spacesAtEnd=K.spaces
D.noHighlightText=table.concat(J," ")..K.spaces

return E end



A.parseArg=function(B, C, D, E, F)
local G=D.value
local H=e:validate(C,G)
local I=H.success and#G>0

local J={success=I,text=G}
if I then
J.value=H.value
end
F.args[E]=J

if I then

local K=if H.display then x(H.display,D.usedChar)else g(D.raw)
return{success=true,display=p(K,H.color or"valid")}
end

local K=e.getOptions(C,H)
local L

if#G>0 then
L=ab:searchAtArray(K,G)[1]
end

if L then
local M,N,O=v(L,G)
F.correction=y(D.from,D.to,L,D.usedChar)

local P=g(M)..p(g(N),"warn")..g(O)
return{
success=false,
suggestion=true,
display=p(x(P,D.usedChar),"comment"),
}
end

return{
success=false,
display=p(g(D.raw),H.color or"warn"),
message=H.message,
comment=H.comment,
}end



A.parsePending=function(B, C, D, E)
local F=e:validate(C,"")
local G=e.getOptions(C,F)

if#G==0 then
return nil
end

local H=G[1]


if not C.optional then
D.correction={from=E.stop,to=E.stop-1,text=w(H)}
else
D.hasGhost=true
end

return p(g(H),"comment")end



A.highlightArgs=function(B, C, D, E, F, G, H)
local I=E.tokens
local J=D.args
local K=#J
local L=#I-1

local M=1
local N

for O,P in J do
local Q=I[O+1]

if Q==nil then
if F then
local R=B:parsePending(P,C,E)
if R then
table.insert(G,R)
end
end
break
end

local R=B:parseArg(P,Q,O,C)
M=O+1

if R.display then
table.insert(G,R.display)
end

if not R.success then
N={index=O,result=R}
break
end
end


for O=M+1,math.min(#I,K+1)do
table.insert(G,g(I[O].raw))
end

if#I>K+1 then
local O=B.cmdInput.rawText:sub(I[K+2].from,I[#I].to)
table.insert(G,p(`<b>{g(O)}</b>`,"warn"))

C.runError=" - extra arg"
C.comment={text=" - extra arg",color="warn"}
return
end

if N then
local O=N.result


C.runError=` - {r(J[N.index],N.index)} is invalid`

if O.message and not O.suggestion then
C.comment={text=O.message,color=if O.comment then"comment"else"warn"}
end
return
end


for O=L+1,K do
local P=J[O]

if not P.optional then
C.runError=` - {r(P,O)} is missing`
break
end
end

local O

if F then
O=L+1
elseif L>0 then
O=L
end

local P=O and J[O]


if P and H then
local Q=if F then""else": "
C.comment={text=`{Q}({B:highlightArgType(P)})`}
end end


A.highlightArgType=function(B, C)
local D=C.optional and p("?","symbol")or""
local E=`{p(C.kind,C.kind)}{D}`

if C.name then
return`{q(C.name)}: {E}`
end

return E end


A.highlightArgsType=function(B, C)
if#C==0 then return""end

local D={}

for E,F in C do
table.insert(D,B:highlightArgType(F))
end

return`({table.concat(D,", ")})`end


A.resetInput=function(B)
local C=B.cmdInput

C.highlightText=""
C.commandName=""
C.commandData=nil
C.isValidCommand=false
C.isAbreviated=false
C.bestMatch=nil
C.bestMatches={}
C.correctionText=nil
C.correction=nil
C.runError=nil
C.hasGhost=false
C.args={}
C.statements={}

B:setComment""end



A.highlightStatement=function(B, C, D)
local E=B.cmdInput
local F=C.tokens
local G={
lead=C.lead,
text="",
trailing=C.spaces,
args={},
commandName="",
bestMatches={},
isValidCommand=false,
isAbreviated=false,
}

if#F==0 then
G.empty=true
return G
end

local H=F[1]
local I=#C.spaces>0
local J=H.value
local K=J
local L
local M
local N=false


if H.kind=="identifier"then
local O,P=J:match"^(.*%^)(.*)$"

if O then
L,M=z(O:sub(1,-2))
K=P
end

if K:sub(1,1)==k then
N=true
K=K:sub(2)
end
end

local O=J:sub(1,#J-#K)
local P=K:lower()
local Q=o(P)

G.commandName=P
G.commandData=Q
G.isValidCommand=Q~=nil
G.isAbreviated=Q~=nil and Q.name~=P
G.loop=L

if M then
G.text=p(g(J),"error")
G.runError=M
G.comment={text=M,color="error"}
return G
end

local R=""
if O~=""then
R=p(g(O),"comment")
end

if not Q then
local S=aa:search(P)
local T=S[1]

G.bestMatches=S
G.bestMatch=T

if I or#F>1 or not T then
local V=E.rawText:sub(H.from,F[#F].to)

G.text=p(g(V),"error")
G.runError=" - invalid command"
G.comment={text=" - invalid command",color="error"}
return G
end


local V,W,X=v(T,K)

G.text=R..p(g(V)..p(g(W),"warn")..g(X),"comment")
G.correction=y(H.from,H.to,O..T,H.usedChar)
G.correctionText=T
G.runError=" - invalid command"
return G
end

local S={R..p(g(K),"valid")}


if D and#F==1 and not I and#Q.aliases>1 then
local T=table.clone(Q.aliases)
local V=table.find(T,P)

if V then
table.remove(T,V)
end

G.comment={text=`: [{table.concat(T,", ")}]`,color="comment"}
end

if N and#F==1 then

G.repeatLast=true

if#Q.args>0 and aa:getLastArgs(Q.name)==nil then
G.runError=" - no previous arguments"
G.comment={text=" - no previous arguments",color="error"}
end
else
B:highlightArgs(G,Q,C,I,S,D)
end

G.text=table.concat(S," ")
return G end




A.highlight=function(B, C)
local D=B.cmdInput
B:resetInput()

local E=#C
local F={}

for G,H in C do
F[G]=B:highlightStatement(H,G==E)
end

local G=F[E]

D.statements=F
D.commandName=G.commandName
D.commandData=G.commandData
D.isValidCommand=G.isValidCommand
D.isAbreviated=G.isAbreviated
D.bestMatch=G.bestMatch
D.bestMatches=G.bestMatches
D.args=G.args


local H

for I,J in F do

if J.empty and E>1 then
J.runError=" - command missing"
end

if J.runError and D.runError==nil then
D.runError=J.runError
end

if J.correction and D.correction==nil then
D.correction=J.correction
end

if J.hasGhost then
D.hasGhost=true
end

if J.comment and H==nil then
H=J.comment
end
end

if H then
B:setComment(H.text,H.color)
end

local I={}

for J,K in F do

local L=if K.correction or K.hasGhost then""else K.trailing
local M=K.lead..K.text..L

if J<E then
M=M..p(g(h),"symbol")
end

table.insert(I,M)
end

local J=table.concat(I)
D.highlightText=J

return J end


A.setComment=function(B, ...)
return B.setCommentCallback(...)end


A.new=function(B, C)
return setmetatable({
cmdInput=B,
setCommentCallback=C
},A)end


return A end a.c1=function()local ab=a.cache.c1 if not ab then ab={c=aa()}a.cache.c1=ab end return ab.c end end do local aa=function()

local aa=a.bl()
local ab=a.h()
local b=a.ag()
local c=a.cI()
local d=a.c_()

local e=a.cQ()
local f=a.c1()
local g=a.W()
local h=a.cP()

local i=a.cY()
local j=a.cr()

local k=a.cs()
local l=a.d()
local m=a.cG()
local n=a.cU()

local o=a.l()
local p=a.av()
local q=a.cM().commands

local r=ab.UserInputService
local s=ab.RunService

local t=m.richFontSize
local u=m.colorFromRGB

local v={}
v.__index=v local w=function(

w)
return i.pressingInputs[w.UserInputType]~=nil end local x=function(


x)
return j.lookup[x]end local y=function(


y)
return math[(y<0)and"ceil"or"floor"](y)end local z=function(


z)
z=z:gsub("[\r\n]+$","")
z=z:gsub("[\r\n]+"," ")
return z end


v.refresh=function(A, B)
local C=A.parser:parse(B)
A.parser:highlight(C)

A:updateSearchBoxHighlight()
A:updateSearchedCommand()end


v.applyCorrection=function(A)
local B=A.commandInput
local C=B.correction
local D=B.rawText

local E=D:sub(1,C.from-1)..C.text..D:sub(C.to+1)

if o:getValue"spaceAfterCorrection"then
E=E.." "
end

A.searchBox.Text=E end


v.awake=function(A)
local B=A.commandInput
local C=A.searchBox
local D=A.searchBoxHolder
local E=A.inputMarker

local F=D.Placeholder

local G=C:GetPropertyChangedSignal"Text"

local H=0 local I=function()


if(tick()-H)>0.5 then
E.Visible=not E.Visible
H=tick()
end end local J=function()



if C:IsFocused()then
C:ReleaseFocus()
end end local K=function()



C:CaptureFocus()end local L=function()




if B.correction then
A:applyCorrection()
task.defer(K)
return true
end


A:sendInputCommand()
return false end local M=function()



local M=not C:IsFocused()and#C.Text==0
F.Visible=M end


A.commandClickedSignal:Connect(function(N)
C.Text=N.aliases[1]
task.defer(K)
end)

aa:Connect(D.Activated,K)

aa:Connect(C.Focused,function()
M()
A.markerConnection=aa:Connect(s.Stepped,I)

if#C.Text==0 then
A:setComment""
end
end)

aa:Connect(C.FocusLost,function(N)
M()
E.Visible=true
aa:disconnect(A.markerConnection)

if N then
A:refresh(z(C.Text))
L()
end
end)

aa:Connect(G,function()
local N=C.Text


if N:find"\t"then
C.Text=(N:gsub("\t",""))
return
end


if A.historyIndex and N~=A.historyText then
A.historyIndex=nil
end

local O=N:sub(-1)=="\n"or N:sub(-1)=="\r"

if N:find"[\r\n]"then
N=z(N)
C.Text=N

if O then
A:refresh(N)

if not L()then
J()
end
return
end
end

M()
A:refresh(N)
end)


aa:Connect(r.InputBegan,function(N)
if not C:IsFocused()then return end

if N.KeyCode==Enum.KeyCode.Up then
A:browseHistory(-1)
elseif N.KeyCode==Enum.KeyCode.Down then
A:browseHistory(1)
elseif N.KeyCode==Enum.KeyCode.Tab and A.commandInput.correction then
A:applyCorrection()
task.defer(K)
end
end)end


local A=50


v.sendInputCommand=function(B)
local C=B.commandInput

if C.runError then
B:setComment(C.runError,"error")
return
end

local D=C.statements

for E,F in D do
if not F.commandData then return end
end

local E=C.rawText
local F,G

for H,I in D do
local J,K=pcall(function()
B:runStatement(I)
end)

if not J then
F=K
G=I.commandData.name
break
end
end

if o:getValue"clearOnEnter"then
B.searchBox.Text=""
end

B.historyIndex=nil

if F then
B:setComment(`failed - {F}`,"error")
l:error(`failed to run command '{G}': {F}`)
else
B:addToHistory(E)
end end



v.runStatement=function(B, C)
local D=C.commandData.name
local E=C.args

if C.repeatLast then
E=e:getLastArgs(D)or{}
end

if C.loop then
B:startLoop(D,E,C.loop)
return
end

e:run(D,g.new(E))end



v.startLoop=function(B, C, D, E)
local F=0
local G

G=h:add(function()
F=F+1

local H,I=pcall(function()
e:run(C,g.new(D))
end)

if not H then
h:remove(G)
l:error(`loop of '{C}' stopped: {I}`)
return
end

if F>=E.count then
h:remove(G)
end
end,E.delay)end


v.addToHistory=function(B, C)
local D=(C or""):match"^(.-)%s*$"

if D==""then return end

local E=B.history

if E[#E]==D then return end

table.insert(E,D)

if#E>A then
table.remove(E,1)
end end



v.browseHistory=function(B, C)
local D=B.history

if#D==0 then return end

local E

if B.historyIndex==nil then
if C>0 then return end
E=#D
else
E=B.historyIndex+C
end

if E<1 then
E=1
end

if E>#D then
B.historyIndex=nil
B:setSearchText""
return
end

B.historyIndex=E
B:setSearchText(D[E])end


v.setSearchText=function(B, C)
B.historyText=C
B.searchBox.Text=C end


v.create=function(B)
B.searchBoxHolder=c.new("ImageButton",{
Size=UDim2.new(1,-10,0,18),
Position=UDim2.fromScale(0.5,0),
AnchorPoint=Vector2.new(0.5,1),
BorderSizePixel=0,
ClipsDescendants=true,
ThemeTag={BackgroundColor3="Colors.Buttons.Default"},

c.new("UICorner",{CornerRadius=UDim.new(0,6)}),

c.new("TextLabel","Input",{
Size=UDim2.fromScale(0,1),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
TextSize=B.configs.textSize,
Visible=false,
RichText=true,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
c.new("Frame","Holder",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromScale(1,0)
}),
}),

c.new("TextLabel","Placeholder",{
Size=UDim2.new(1,-5,1,0),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=B.configs.textSize-1,
Text=B.configs.placeholderText,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
}),
})

local C=B.searchBoxHolder
local D=C.Input.Holder

B.inputMarker=c.new("Frame","Marker",D,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

B.inputComment=c.new("TextLabel","Comment",D,{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromScale(1,0.5),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=B.configs.textSize,
RichText=true,
Text="",
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
}
})

B.commandInfo=c.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=B.configs.textFont,
TextSize=B.configs.textSize-5,
Visible=false,
c.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

B.searchBox=c.new("TextBox","SearchBox",{
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

B.commandsFolder=c.new("Folder","Commands")end


v.createCommandsData=function(B)
for C,D in j.original do
local E=d.new(D)
D.commandData=E
E.position=C-1
table.insert(B.commandsData,E)
end end


v.updateSearchBoxHighlight=function(B)
local C=B.commandInput.highlightText
local D=B.searchBoxHolder
local E=D.Input
local F=n:getScale()

E.Text=C
E.Visible=#C>0

local G=D.AbsoluteSize.X*F
local H=G/2
local I=E.AbsoluteSize.X*F

if I<=H then
E.AnchorPoint=Vector2.new(0,0.5)
E.Position=UDim2.new(0,5,0.5,0)
else
E.AnchorPoint=Vector2.new(1,0.5)
E.Position=UDim2.new(0.5,0,0.5,0)
end end


v.updateSearchedCommand=function(B)
local C=B.commandInput.bestMatch
local D=B.commandInput.commandName
if D==""then return end

local E=x(D)
or(C and x(C))

if E then
B.scrollBar:scrollTo(E.commandData.position)
end end


v.setComment=function(B, C, D)
if D~=nil then
C=f.colorFromName(C,D)
end

B.inputComment.Text=C
B.inputComment.Visible=#C>0 end


v.updateElementColor=function(B, C, D)
local E=if D%2==1 then 1 else 0.96
C.BackgroundTransparency=E end


v.updateElements=function(B)
local C=0
local D=0
local E={}
local F=B.scrollBar
local G=B.commandsFolder

for H,I in B.commandsData do
local J=F:isVisible(I.position)

if not J then
if I.element then I.element.Parent=nil end
continue
end

local K=I.element
if not K then
K=B:createCommandElement(I)
I.element=K
end

if not I.isSection then
if#I.args>0 and#I.name>D then
D=#I.name
end
table.insert(E,I)
end

B:updateElementColor(K,H)
K.Parent=G
K.Position=UDim2.fromOffset(
0,
C*(K.Size.Y.Offset+B.configs.padding)
)
C=C+1
end

for H,I in E do
B:updateDisplayName(I,D+3)
end

B.visibleCommands=E end


v.setCommandInfo=function(B, C)
C=C or""

if C==""then
B.commandInfo.Visible=false
return
end

B.commandInfo.Visible=true
B.commandInfo.Text=C end


v.createSection=function(B, C)


local D=c.new("TextLabel","Command",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
RichText=true,
TextSize=B.configs.textSize-3,
Text=`<b>#{C.sectionName}</b>`,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.MonoSpace"
},
})

return c.new("Frame",{
Size=UDim2.new(1,-10,0,B.configs.labelSize),
BackgroundTransparency=1,

D
})end


v.createCommandElement=function(B, C)
if C.isSection then
return B:createSection(C)
end

local D=c.new("TextLabel","Command",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.X,
RichText=true,
TextSize=B.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
})

return c.new("Frame",{
Size=UDim2.new(1,0,0,B.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
D
})end


v.createCommandDescription=function(B, C)
if C.isSection then return end
if not C.description then return end

local D=c.new("TextLabel","Description",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(25,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
TextSize=B.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
})

return c.new("Frame","Description",{
Size=UDim2.new(1,-30,0,B.configs.labelSize),
BackgroundTransparency=1,
D
})end


v.getCommandColor=function(B, C, D)
local E=x(C)

local F=
if type(E.run)~="function"then"undefined"
elseif p:getValue(E.name)==true then"deprecated"
elseif D.isClient then"client"
elseif D.isDeprecated then"deprecated"
else nil

if F~=nil then
C=u(C,q[F])
end

return C end


v.updateDisplayName=function(B, C, D)
local E=C.element
local F=C.name

local G=string.rep("—",(D-#F)-2)

F=B:getCommandColor(F,C)
local H=`{F} {f.colorFromName(G,"comment")} `

local I=B.parser:highlightArgsType(C.args)
local J=H..I

if C.isHolding then
C.originalText=J
else
B:setCommandText(C,J)
end end


v.setCommandText=function(B, C, D)
local E=C.element
if not E then return end

E.Command.Text=D end


v.getCommandText=function(B, C)
local D=C.element
return D and D.Command.Text or""end


v.calculateTotalSpace=function(B)
return#B.commandsData end


v.calculateVisibleSpace=function(B)
local C=B.scrollContainer.AbsoluteSize.Y
return math.floor(C/B:calculateLabelSize())end


v.calculateLabelSize=function(B)
return B.configs.padding+B.configs.labelSize end


v.getElementMouseIn=function(B)
for C,D in B.visibleCommands do
if b:isMouseInGuiObject(D.element)then
return D
end
end end


v.horizontalScroll=function(B, C)
for D,E in B.visibleCommands do
local F=E.element

F.Position=UDim2.fromOffset(
math.min(F.Position.X.Offset+C,0),
F.Position.Y.Offset
)
end end


v.startedHoldingContainer=function(B, C)
if not w(C)then return end
if B.scrollBar:isScrollBarDisabled()then return end

B.scrollAxis=nil
B.scrollBar:disableScroll()

local D=b:getMouse()
local E=B:calculateLabelSize()
local F=B:getElementMouseIn()
local G=tick()

if F and F.description then
F.isHolding=true

local H=B.parser.colorFromName(F.description,"comment")

F.originalText=B:getCommandText(F)
B:setCommandText(F,H)
end

local H=D.Y
local I=D.X

local J,K local L=function()


B.scrollBar:enableScroll()

if F then
F.isHolding=nil

if F.originalText then
B:setCommandText(F,F.originalText)
F.originalText=nil
end

if(tick()-G)<=0.15 then
B.commandClickedSignal:Fire(F)
end
end

if K then K:Disconnect()end
if J then J:Disconnect()end end


K=aa:Connect(r.InputEnded,function(M)
if not w(M)then return end
L()
end)

J=aa:Connect(r.InputChanged,function(M)
if not w(M)then return end

local N=D.X-I
local O=D.Y-H

if not B.scrollAxis then
if math.abs(N)>4 or math.abs(O)>4 then
B.scrollAxis=math.abs(N)>math.abs(O)and"x"or"y"
end
return
end

if B.scrollAxis=="x"then
local P=y(N/3)
if math.floor(P)~=0 then
B:horizontalScroll(P)
I=D.X
end
else
local P=y(O/E)
if math.floor(P)~=0 then
B.scrollBar:scrollTo(B.scrollBar.index-P)
H=D.Y
end
end
end)end


v.update=function(B)
B.scrollBar:setVisibleSpace(B:calculateVisibleSpace())
B.scrollBar:setTotalSpace(B:calculateTotalSpace())
B:updateElements()end


v.enable=function(B)
if B.isEnabled then return end
local C=B.scrollContainer
B.isEnabled=true

B.commandsFolder.Parent=C
B.searchBox.Parent=B.scrollHolder
B.searchBoxHolder.Parent=B.scrollHolder
B.commandInfo.Parent=B.scrollHolder

B.scrollConnection=B.scrolledSignal:Connect(function()
B:updateElements()
end)

B.containerConnection=C.InputBegan:Connect(function(D)
B:startedHoldingContainer(D)
end)

B:update()end


v.disable=function(B)
if not B.isEnabled then return end
B.isEnabled=false

B.commandsFolder.Parent=nil
B.searchBox.Parent=nil
B.searchBoxHolder.Parent=nil
B.commandInfo.Parent=nil

aa:disconnect(B.containerConnection)
aa:disconnect(B.markerConnection)
aa:disconnect(B.scrollConnection)end


v.new=function(B)local C=function(
C)
return assert(B.configs[C],`missing config.configs['{C}']`)end


local D=setmetatable({
scrollContainer=B.scrollContainer,
scrolledSignal=B.scrolledSignal,
scrollHolder=B.scrollHolder,
scrollBar=B.scrollBar,

configs={
placeholderText=C"placeholderText",
padding=C"padding",
labelSize=C"labelSize",
textSize=C"textSize"
},

commandClickedSignal=k.new(),

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
},v)

D.parser=f.new(D.commandInput,function(E,F)
return D:setComment(E,F)
end)

return D end


return v end a.c2=function()local ab=a.cache.c2 if not ab then ab={c=aa()}a.cache.c2=ab end return ab.c end end do local aa=function()
local aa=a.bl()
local ab=a.h()

local b=a.cs()

local c=ab.UserInputService

local d={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}

local e={
[Enum.UserInputType.MouseMovement]=true,
[Enum.UserInputType.Touch]=true
}

local f=0.28

local g={}
g.__index=g

g.addGuiObject=function(h, i)
local j local k=function()


h.isDragging=false
h.draggingObject=nil
h.dragStart=nil
h.startPos=nil

if j then
j:Disconnect()
end

h.dragEnded:Fire(i)end local l=function()



while h.draggingObject==i do
if(tick()-h.lastActivity)>=1 then
k()
end
task.wait()
end end


return aa:Connect(i.InputBegan,function(m)
if not d[m.UserInputType]then return end
if h.isDragging then return end

h.dragStart=m.Position
h.startPos=i.Position

h.isDragging=true
h.draggingObject=i
h.lastActivity=tick()

h.dragStarted:Fire(i)

task.spawn(l)

j=m.Changed:Connect(function()
if m.UserInputState==Enum.UserInputState.End then
k()
end
end)
end)end


g.update=function(h, i, j)
local k=j.Position-h.dragStart
local l=(h._uiScale and h._uiScale.Scale)or 1
local m=i.Position

h.lastActivity=tick()

local n=UDim2.new(
h.startPos.X.Scale,
h.startPos.X.Offset+(k.X/l),
h.startPos.Y.Scale,
h.startPos.Y.Offset+(k.Y/l)
)

if h.filters[i]~=nil then
local o=h.filters[i](n,l)
n=o or n
end

i.Position=m:Lerp(n,f)
h.onDragged:Fire(i)end


g.canDragObject=function(h, i)
return(not h.isDragging)or(h.draggingObject==i)end


g.setFilter=function(h, 
i, 
j)

h.filters[i]=j end


g.new=function(h)
local i=setmetatable({
isDragging=false,
draggingObject=nil,
_uiScale=h,
dragStart=nil,
startPos=nil,
filters={},

onDragged=b.new(),
dragStarted=b.new(),
dragEnded=b.new(),
},g)

aa:Connect(c.InputChanged,function(j)
if i.isDragging and e[j.UserInputType]then
i:update(i.draggingObject,j)
end
end)

return i end


return g end a.c3=function()local ab=a.cache.c3 if not ab then ab={c=aa()}a.cache.c3=ab end return ab.c end end do local aa=function()






































































































































local aa=a.cU().uiScale
return a.c3().new(aa)end a.c4=function()local ab=a.cache.c4 if not ab then ab={c=aa()}a.cache.c4=ab end return ab.c end end do local aa=function()
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
}end a.c5=function()local ab=a.cache.c5 if not ab then ab={c=aa()}a.cache.c5=ab end return ab.c end end do local aa=function()


local aa=a.cI()
local ab=a.c4()
local b=a.cZ()

local c=a.cU()
local d=a.bl()
local e=a.a()
local f=a.p()

local g=a.c5()

local h=500
local i=20
local j=300
local k=i+j

local l=12
local m=20
local n=40

local o=0.5
local p=2

local q=UDim2.new(0.5,-h/2,0,-500)
local r=UDim2.new(0.5,-h/2,0.5,-k/2)

local s={["&"]="&amp;",["<"]="&lt;",[">"]="&gt;"}

local t=g.cases
local u=g.sections

local v={}
v.__index=v local w=function(

w)
return(w:gsub("[&<>]",s))end local x=function(


x)
return aa.new("TextLabel","Header",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=x,
TextSize=20,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})end local y=function(


y, z)
return aa.new("TextLabel",z and"Bold"or"Text",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=y,
TextSize=14,
TextWrapped=true,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font=z and"Font.Bold"or"Font.Normal",
TextColor3="Colors.Text.Default",
},
})end local z=function()



local z=aa.new("Frame","Cases",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for A,B in t do
local C,D=B[1],B[2]

aa.new("TextLabel","Case",z,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=A,
RichText=true,
Size=UDim2.new(1,0,0,0),
Text=`<b>{w(C)}</b> {w(D)}`,
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

return z end local A=function(


A)
local B=aa.new("TextButton","InviteButton",{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,25),
Text=`Copy Discord Invite Link ({A})`,
TextSize=16,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local C=B.Text
local D

d:Connect(B.Activated,function()
if e.setclipboard then
e.setclipboard(A)
B.Text="Copied"
else
B.Text="No Clipboard Function, type out the link"
end

local E=tick()
D=E

task.wait(p)
if D~=E then return end

B.Text=C
end)

return B end local B=function(


B)
local C=B[1]

if C=="title"then
return x(B[2])
elseif C=="cases"then
return z()
elseif C=="invite"then
return A(f.links.discord)
end

return y(B[2],C=="bold")end local C=function(


C, D, E)
local F=aa.new("Frame","Section",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=C,
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

for G,H in D do
local I=B(H)
I.LayoutOrder=G
I.Parent=F
end

if not E then
aa.new("Frame","Line",F,{
BorderSizePixel=0,
LayoutOrder=#D+1,
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Colors.Stroke",
},
})
end

return F end


v.new=function()
return setmetatable({},v)end


v.open=function(D)
D.frame:TweenPosition(r,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,o,true)end


v.close=function(D)
D.frame:TweenPosition(q,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,o,true)end


v.create=function(D)
local E=aa.new("Frame","ReferenceFrame",{
Active=true,
BorderSizePixel=0,
Position=q,
Size=UDim2.fromOffset(h,k),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local F=aa.new("Frame","TopBar",E,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,i),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",F,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text="Reference",
TextSize=16,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local G=aa.new("TextButton","Close",F,{
BackgroundTransparency=1,
Position=UDim2.new(1,-i,0,0),
Size=UDim2.fromOffset(i,i),
Text="",
})

local H=aa.new("ImageLabel","Icon",G,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(10,10),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local I=b.new{
isHorizontal=false,
barThickness=l,
increment=m,
wheelIncrement=n,
}

local J=I:create()
local K=I.container

local L=aa.new("Frame","Content",K,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

aa.new("Frame","ScrollHolder",E,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,i),
Size=UDim2.new(1,0,0,j),

J,
K,
})

for M,N in u do
local O=C(M,N,M==#u)
O.Parent=L
end local M=function(


M)
L.Position=UDim2.fromOffset(0,-M)end local N=function()



local N=c:getScale()

I:setTotalSpace(math.ceil(L.AbsoluteSize.Y/N))
I:setVisibleSpace(math.ceil(K.AbsoluteSize.Y/N))
M(I.index)end


d:Connect(I.scrolledSignal,M)
d:Connect(L:GetPropertyChangedSignal"AbsoluteSize",N)
d:Connect(K:GetPropertyChangedSignal"AbsoluteSize",N)

d:Connect(K.MouseWheelForward,function()
I:scrollTo(I.index-I.wheelIncrement)
end)

d:Connect(K.MouseWheelBackward,function()
I:scrollTo(I.index+I.wheelIncrement)
end)

d:Connect(G.Activated,function()
D:close()
end)

ab:addGuiObject(E)

ab.dragStarted:Connect(function(O)
if O~=E then return end
I:disableScroll()
end)

ab.dragEnded:Connect(function(O)
if O~=E then return end
I:enableScroll()
end)

N()

D.frame=E
D.closeIcon=H
D.scrollBar=I

return E end


return v end a.c6=function()local ab=a.cache.c6 if not ab then ab={c=aa()}a.cache.c6=ab end return ab.c end end do local aa=function()


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
}end a.c7=function()local ab=a.cache.c7 if not ab then ab={c=aa()}a.cache.c7=ab end return ab.c end end do local aa=function()


local aa=a.cI()
local ab=a.cK()
local b=a.cH()

local c=a.c4()
local d=a.cO()

local e=a.cG()

local f=a.cU()
local g=a.bl()
local h=a.a()
local i=a.af()
local j=a.h()
local k=a.b()

local l=a.c7()
local m=a.cN()

local n=UDim2.new(0.5,-l.window.width/2,0,l.window.shownY)
local o=UDim2.new(0.5,-l.window.width/2,0,l.window.hiddenY)

local p

local q={}local r=function(

r)
return m:apply(r)end local s=function(


s, t)
return`{e.escapeRichText(s)}{r(t)}`end local t=function(


t)
if t==nil then return false end

if h.setclipboard then
h.setclipboard(tostring(t))
return true
end

d:notify(l.messages.noClipboard)
return false end local u=function(


u)
local v=l.time
local w=math.floor(u/3600)
local x=math.floor((u%3600)/60)
local y=math.floor(u%60)

if w>0 then
return`{w} {v.hour}, {x} {v.minute}, {y} {v.second}`
elseif x>0 then
return`{x} {v.minute}, {y} {v.second}`
end

return`{y} {v.second}`end local v=function()



local v,w=pcall(function()
return j.MarketplaceService:GetProductInfo(game.PlaceId)
end)

if v and w then
return w.Name
end

return l.messages.unknownPlace end local w=function(


w, x)
local y=l.copyButton

local z=aa.new("TextButton","Copy",w,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-l.window.textInset,0.5,0),
Size=UDim2.fromOffset(y.width,y.height),
Text=y.idleText,
TextSize=l.textSizes.copyButton,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,y.cornerRadius),
}),
})

g:Connect(z.MouseEnter,function()
b:updateObjectProperties(z,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

g:Connect(z.MouseLeave,function()
b:updateObjectProperties(z,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

g:Connect(z.Activated,function()
if not t(x())then return end

z.Text=y.copiedText
task.wait(y.feedbackTime)
z.Text=y.idleText
end)

return z end local x=function(


x, y, z, A)
local B=l.window
local C=B.textInset
local D=0

if A.getCopyValue then
D=l.copyButton.width+l.copyButton.gap
end

local E=aa.new("Frame","Row",x,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=(y%2==1)and B.stripeTransparency or 1,
BorderSizePixel=0,
LayoutOrder=y,
Size=UDim2.new(1,0,0,B.rowHeight),
})

local F=aa.new("TextLabel",A.name,E,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(C,0),
RichText=true,
Size=UDim2.new(1,-(C*2+D),1,0),
Text=z,
TextSize=A.textSize,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=A.textColor,
},
})

if A.getCopyValue then
w(E,A.getCopyValue)
end

return F end local y=function(


y, z, A)
return x(y,z,`<b>{e.escapeRichText(A)}</b>`,{
name="Section",
textSize=l.textSizes.section,
textColor="Colors.Text.Darker",
})end local z=function(


z, A, B, C)
return x(z,A,B,{
name="Value",
textSize=l.textSizes.value,
textColor="Colors.Text.Default",
getCopyValue=C,
})end local A=function()



local A=l.window

local B={
labels={},
placeName=nil,
}

local C=aa.new("Frame","ServerInfo",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=o,
Size=UDim2.fromOffset(A.width,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local D=aa.new("Frame","TopBar",C,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,A.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",D,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=A.title,
TextSize=l.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local E=aa.new("ImageButton","Exit",D,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-A.closeInset,0.5,0),
Size=UDim2.fromOffset(A.closeIconSize,A.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(E,"close")

g:Connect(E.Activated,function()
q:close()
end)

local F=aa.new("Frame","Body",C,{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
LayoutOrder=2,
Size=UDim2.new(1,0,0,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},

aa.new("UIPadding",{
PaddingBottom=UDim.new(0,A.verticalPadding),
PaddingTop=UDim.new(0,A.verticalPadding),
}),

aa.new("UIListLayout",{
Padding=UDim.new(0,A.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local G=B.labels
local H=l.labels
local I=l.messages.loading

local J=0 local K=function()

J=J+1
return J end


y(F,K(),l.headers.localPlayer)

G.playerId=z(F,K(),s(H.playerId,i.UserId),function()
return i.UserId
end)

G.appearance=z(F,K(),s(H.appearance,i.CharacterAppearanceId),function()
return i.CharacterAppearanceId
end)

y(F,K(),l.headers.runTime)
G.time=z(F,K(),r(I))

y(F,K(),l.headers.statistics)
G.players=z(F,K(),s(H.players,I))
G.maxPlayers=z(F,K(),s(H.maxPlayers,I))

G.placeId=z(F,K(),s(H.placeId,game.PlaceId),function()
return game.PlaceId
end)

G.placeName=z(F,K(),s(H.placeName,I),function()
return B.placeName
end)

p:addGuiObject(C)

B.frame=C
return B end local B=function(


B)
local C=B.labels
local D=l.labels
local E=j.Players

while q.window==B do
C.players.Text=s(D.players,#E:GetPlayers())
C.maxPlayers.Text=s(D.maxPlayers,E.MaxPlayers)
C.time.Text=r(u(workspace.DistributedGameTime))

task.wait(l.window.updateInterval)
end end


q.create=function(C)
if C.isEnabled then
d:notify(l.messages.alreadyEnabled)
return
end

C.isEnabled=true

local D=A()
C.window=D

local E=l.window.tweenTime

D.frame.Parent=k.screenGui
D.frame:TweenPosition(n,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,E,true)

task.spawn(function()
D.placeName=v()
D.labels.placeName.Text=s(l.labels.placeName,D.placeName)
end)

task.spawn(B,D)

return D end


q.close=function(C)
local D=C.window
if not D then return end

local E=l.window.tweenTime

C.window=nil
C.isEnabled=false

D.frame:TweenPosition(o,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,E,true)

task.delay(E,function()
D.frame:Destroy()
end)end


return q end a.c8=function()local ab=a.cache.c8 if not ab then ab={c=aa()}a.cache.c8=ab end return ab.c end end do local aa=function()


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
}end a.c9=function()local ab=a.cache.c9 if not ab then ab={c=aa()}a.cache.c9=ab end return ab.c end end do local aa=function()









local aa=a.cI()
local ab=a.cK()
local b=a.cH()
local d=a.c4()
local e=a.cU()
local f=a.cZ()
local g=a.cO()

local h=a.b()
local i=a.c9()
local j=a.h()
local k=a.cA()
local l=a.bC()
local m=a.cM().args
local n=a.cN()
local o=a.cG()

local p=i.window
local q=p.topBarHeight
local r=q+p.rowHeight
local s=UDim2.new(0,p.shownX,0,p.shownY)
local t=UDim2.new(0,p.hiddenX,0,p.shownY)


local u,v=0,0.125
local w,x=0.125,0.125
local y,z=0.25,0.25
local A,B=0.5,0.5
local C=0.75

local D={
window=nil,
listening=false,
}local E=function(


E, F, G)
local H=p.buttonInset
E.Position=UDim2.new(F,H,0,H)
E.Size=UDim2.new(G,-H*2,1,-H*2)end local F=function(



F, G)
b:updateObjectProperties(F,{BackgroundColor3=G})end local G=function(


G)
if G=="chat"then
return l.chatEnabled
end
return l.joinEnabled end local H=function(



H, I)
local J=o.colorFromRGB(`[{I.time}]`,m.comment)
local K=`<b>{o.colorFromRGB(o.escapeRichText(I.name),I.color or m.others)}</b>`

if H=="chat"then
return`{J} {K}: {n:apply(I.message)}`
end
return`{J} {K} {n:apply(`joined (id {I.userId})`)}`end local I=function(


I, J)
return I.tabButtons[I.tab]==J end local J=function(


J)
for K,L in J.tweens do
L:Cancel()
end
table.clear(J.tweens)end local K=function(



K, L, M, N, O)
local P=p.buttonInset
local Q=UDim2.new(M,P,0,P)
local R=UDim2.new(N,-P*2,1,-P*2)

local S=k:getScale(p.tabTweenTime)
if not O or S<=0 then
L.Position=Q
L.Size=R
return
end

local T=TweenInfo.new(S,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
local V=j.TweenService:Create(L,T,{
Position=Q,
Size=R,
})
table.insert(K.tweens,V)
V:Play()end local L=function(



L, M)
J(L)

local N=if L.tab=="chat"then C else 1-C
local O=B*N
local P=B-O

K(L,L.tabButtons.chat,A,O,M)
K(L,L.tabButtons.join,A+O,P,M)end local M=function(


M)
local N=G(M.tab)
M.toggle.Text=if N then i.controls.enabled else i.controls.disabled
F(M.toggle,if N then"Colors.OnPrimary"else"Colors.Buttons.Default")

for O,P in M.tabButtons do
local Q=O==M.tab
F(P,if Q then"Colors.Primary"else"Colors.Buttons.Default")
b:updateObjectProperties(P,{Font=if Q then"Font.Bold"else"Font.Normal"})
end end local N=function(


N, O)
M(N)
L(N,O==true)end local O=function(


O)
for P,Q in O.connections do
Q:Disconnect()
end
table.clear(O.connections)end local P=function(


P, Q, R)
table.insert(P.connections,Q:Connect(R))end local Q=function(


Q, R)
P(Q,R.MouseEnter,function()
if not I(Q,R)then
F(R,"Colors.Buttons.Holding")
end
end)

P(Q,R.MouseLeave,function()
M(Q)
end)end local R=function(


R, S, T, V, W)
local X=aa.new("TextButton",S,R,{
AutoButtonColor=false,
BorderSizePixel=0,
Text=T,
TextSize=i.textSizes.control,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,p.buttonCorner),
}),
})

E(X,V,W)
return X end local S=function(


S)
S.content.Position=UDim2.fromOffset(0,-S.scrollBar.index)end local T=function(


T)
local V=e:getScale()
T.scrollBar:setTotalSpace(math.ceil(T.content.AbsoluteSize.Y/V))
T.scrollBar:setVisibleSpace(math.ceil(T.container.AbsoluteSize.Y/V))
S(T)end local V=function(


V)
for W,X in V.labels do
X:Destroy()
end
table.clear(V.labels)end local W=function(


W, X, Y)
W.order=W.order+1

local Z=aa.new("TextLabel","Entry",W.content,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=if W.order%2==1 then p.stripeTransparency else 1,
BorderSizePixel=0,
LayoutOrder=W.order,
Size=UDim2.new(1,0,0,0),
RichText=true,
Text=H(X,Y),
TextSize=i.textSizes.entry,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

table.insert(W.labels,Z)
while#W.labels>i.maxLabels do
table.remove(W.labels,1):Destroy()
end


task.defer(function()
if W.frame.Parent then
T(W)
W.scrollBar:scrollTo(math.huge)
end
end)end local X=function(


X, Y)
V(X)

for Z,_ in l.entries[X.tab]do
W(X,X.tab,_)
end

N(X,Y)end local ac=function(


Y)
local Z={
tab=Y,
labels={},
order=0,
connections={},
tabButtons={},
tweens={},
}

local _=aa.new("Frame","ChatLogs",{
Active=true,
BorderSizePixel=0,
Position=t,
Size=UDim2.fromOffset(p.width,p.height),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})
Z.frame=_


local ac=aa.new("Frame","TopBar",_,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,q),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",ac,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=i.title,
TextSize=i.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local ad=aa.new("TextButton","Close",ac,{
BackgroundTransparency=1,
Position=UDim2.new(1,-q,0,0),
Size=UDim2.fromOffset(q,q),
Text="",
})

local ae=aa.new("ImageLabel","Icon",ad,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(p.closeIconSize,p.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})
ab:loadImage(ae,"close")


local af=aa.new("Frame","Controls",_,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,q),
Size=UDim2.new(1,0,0,p.rowHeight),
})

local ag=R(af,"Clear",i.controls.clear,u,v)
local ah=R(af,"Save",i.controls.save,w,x)
Z.toggle=R(af,"Toggle",i.controls.enabled,y,z)

local ai=R(af,"ChatTab",i.tabs.chat,A,B/2)
local aj=R(af,"JoinTab",i.tabs.join,A+B/2,B/2)
Z.tabButtons={chat=ai,join=aj}


local ak=f.new{
isHorizontal=false,
barThickness=i.scrollBar.barThickness,
increment=i.scrollBar.increment,
wheelIncrement=i.scrollBar.wheelIncrement,
}
local al=ak:create()
local am=ak.container

local an=aa.new("Frame","Content",am,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

aa.new("Frame","ScrollHolder",_,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,r),
Size=UDim2.new(1,0,1,-r),

al,
am,
})

Z.scrollBar=ak
Z.container=am
Z.content=an

P(Z,ak.scrolledSignal,function()
S(Z)
end)
P(Z,an:GetPropertyChangedSignal"AbsoluteSize",function()
T(Z)
end)
P(Z,am:GetPropertyChangedSignal"AbsoluteSize",function()
T(Z)
end)
P(Z,am.MouseWheelForward,function()
ak:scrollTo(ak.index-ak.wheelIncrement)
end)
P(Z,am.MouseWheelBackward,function()
ak:scrollTo(ak.index+ak.wheelIncrement)
end)
P(Z,d.dragStarted,function(ao)
if ao==_ then
ak:disableScroll()
end
end)
P(Z,d.dragEnded,function(ao)
if ao==_ then
ak:enableScroll()
end
end)

P(Z,ad.Activated,function()
D:close()
end)

P(Z,ai.Activated,function()
D:select"chat"
end)

P(Z,aj.Activated,function()
D:select"join"
end)

P(Z,Z.toggle.Activated,function()
local ao=G(Z.tab)
if Z.tab=="chat"then
l.setChat(not ao)
else
l.setJoin(not ao)
end
M(Z)
end)

P(Z,ah.Activated,function()
local ao,ap=l.save(Z.tab)
if ao then
g:notify(i.messages.saved,ap)
else
g:notify(i.messages.saveFailed,ap)
end
end)

P(Z,ag.Activated,function()
l.clear(Z.tab)
V(Z)
end)

for ao,ap in{ai,aj,Z.toggle,ah,ag}do
Q(Z,ap)
end

return Z end local ad=function()




if D.listening then
return
end
D.listening=true

l.onEntry(function(ad,ae)
local af=D.window
if af and af.tab==ad then
W(af,ad,ae)
end
end)end



D.open=function(ae, af)
ad()

local ag=ae.window
if ag then
ae:select(af)
return ag
end

ag=ac(af)
ae.window=ag

ag.frame.Parent=h.screenGui
ag.frame:TweenPosition(s,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,p.tweenTime,true)
d:addGuiObject(ag.frame)

X(ag)
return ag end


D.select=function(ae, af)
local ag=ae.window
if not ag then
return
end

ag.tab=af
X(ag,true)end


D.close=function(ae)
local af=ae.window
if not af then
return
end

ae.window=nil
O(af)
J(af)

af.frame:TweenPosition(t,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,p.tweenTime,true)
task.delay(p.tweenTime,function()
af.frame:Destroy()
end)end



D.reset=function(ae)
local af=ae.window
if af then
O(af)
J(af)
end
ae.window=nil end


return D end a.da=function()local ab=a.cache.da if not ab then ab={c=aa()}a.cache.da=ab end return ab.c end end do local aa=function()



local aa=a.p()
local ab=a.cL()
local ac=a.b()
local ad=a.bl()
local ae=a.h()

local af=a.l()
local ag=a.d()
local ah=a.cG()

local ai=a.cI()
local aj=a.cK()
local ak=a.cH()

local al=a.cF()
local am=a.bR()
local an=a.cO()

local ao=a.cT()
local ap=a.cU()
local b=a.cV()

local d=a.cW()
local e=a.cZ()
local f=a.c2()
local g=a.c6()
local h=a.c8()
local i=a.da()

local j=a.c4()

local k=450
local l=ap.uiScale

local m={
awoken=false,
}local n=function(

n)
local o=type(n)=="string"and al[n:lower()]

if o and o.Colors and o.Font then
return n
end

return aa.theme.defaultTheme end local o=function(


o, p, q, r)
local s=(o.Scale*q)/r+o.Offset
local t=math.floor(q/r-p)

if math.floor(s)>=t then
return 1,-p
end

return 0,math.clamp(math.floor(s),0,math.max(t,0))end


m.awake=function(p)
if p.awoken then
return p.screenGui
end

p.awoken=true

p:setupTheme()
p:setupScreenGui()
p:setupScale()
p:setupMainFrame()
p:createReference()
p:createNotifications()
p:setupListeners()
p:updateNotificationsPosition()

ag:log"interface started"
return p.screenGui end


m.setupTheme=function(p)
ag:debug"interface: initializing theme service"

ak:init{
theme=n(aa.theme.selectedTheme),
}end


m.setupScreenGui=function(p)
local q=p:createScreenGui()

q.Parent=am
ac.screenGui=q

l.Parent=q end


m.setupScale=function(p)
p:setScale(af:getValue"interface.uiScale"or 1)end


m.setupMainFrame=function(p)
local q=p:createMainFrame()

p:createCommands()
p:dragMainFrame(q)
p.commands:enable()

q.Parent=p.screenGui end


m.setupListeners=function(p)
ad:Connect(p.screenGui:GetPropertyChangedSignal"AbsoluteSize",function()
p:updateMainFramePosition()
end)

ad:Connect(p.mainFrame:GetPropertyChangedSignal"AbsolutePosition",function()
p:updateNotificationsPosition()
end)

ad:Connect(p.mainFrame:GetPropertyChangedSignal"AbsoluteSize",function()
p:updateNotificationsPosition()
end)


ad:Connect(ae.RunService.RenderStepped,function()
p:updateNotificationsPosition()
end)end


m.createScreenGui=function(p)
local q=ai.new("ScreenGui",{
IgnoreGuiInset=true,
Name=ah.randomString(math.random(30,50)),
DisplayOrder=2147483647,
})

p.screenGui=q
return q end


m.calculateScale=function(p, q)
return(p.screenGui.AbsoluteSize.Y/k)*q end


m.setScale=function(p, q)
q=math.abs(q)

if q>=3 then
q=p:calculateScale(q)
end

if af:getValue"interface.uiScale"~=q then
af:setValue("interface.uiScale",q)
af:save()
end

ap:setScale(q)
p:updateMainFramePosition()end


m.calculateMainFramePosition=function(p, q)
local r=p.mainFrame
local s=p.screenGui
local t=ap:getScale()
local u=r.Size

q=q or r.Position

local v,w=o(q.X,u.X.Offset,s.AbsoluteSize.X,t)
local x,y=o(q.Y,u.Y.Offset,s.AbsoluteSize.Y,t)

return UDim2.new(v,w,x,y)end


m.updateMainFramePosition=function(p)
if not p.mainFrame then return end

p.mainFrame.Position=p:calculateMainFramePosition()
p:updateNotificationsPosition()end


m.createMainScroll=function(p, q)
local r=e.new{
isHorizontal=false,
barThickness=12,
}

local s=r:create()
local t=r.container

local u=ai.new("Frame","ScrollHolder",q,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

s,
t,
})

p.scrollHolder=u
p.scrollBar=r
p.scrollContainer=t

return r end


m.createMainFrame=function(p)
local q=d:create()
local r=q.mainFrame

q.titleLabel.Text=ao.getDisplayName()

p.mainFrame=r
p.topBar=q.topBar
p.buttons=q.buttons

aj:loadImage(p.buttons.settings,"settings")
aj:loadImage(p.buttons.reference,"reference")

ad:Connect(p.buttons.settings.Activated,function()
print"clicked settings"
end)

p:createMainScroll(r)

return r end


m.createCommands=function(p)
local q=p.scrollBar

local r=f.new{
scrolledSignal=q.scrolledSignal,
scrollContainer=p.scrollContainer,
scrollHolder=p.scrollHolder,
scrollBar=q,

configs={
placeholderText=aa.ui.commands.placeholderText,
padding=aa.ui.commands.padding,
labelSize=aa.ui.commands.labelSize,
textSize=aa.ui.commands.textSize,
},
}

ag:log"created commands interface"
r:create()

ag:log"initialized commands"
r:createCommandsData()

ag:log"awaked commands module"
r:awake()

p.commands=r
return r end


m.createInfoMenu=function(p)
return h:create()end



m.chatLogs=function(p, q)
return i:open(q or"chat")end


m.dragMainFrame=function(p, q)
q.Size=aa.ui.window.windowSize

q.Position=UDim2.fromOffset(1e5,1e5)
q.Position=p:calculateMainFramePosition()

j:addGuiObject(q)

j:setFilter(q,function(r)
return p:calculateMainFramePosition(r)
end)






j.dragStarted:Connect(function(r)
if r~=q then return end
p.scrollBar:disableScroll()
end)

j.dragEnded:Connect(function(r)
if r~=q then return end
p.scrollBar:enableScroll()
end)end


m.createReference=function(p)
local q=g.new()
local r=q:create()

aj:loadImage(q.closeIcon,"close")

r.Parent=p.screenGui
p.reference=q

ad:Connect(p.buttons.reference.Activated,function()
q:open()
end)

return q end


m.createNotifications=function(p)
local q=an:getContainer(p.screenGui)
p.notificationsContainer=q


an.onLayoutChanged=function()
p:updateNotificationsPosition()
end

p:updateNotificationsPosition()
return q end


m.updateNotificationsPosition=function(p)
local q=p.notificationsContainer
local r=p.mainFrame
local s=p.screenGui
if not(q and r and s)then return end


local t=ap:getScale()
local u=r.AbsolutePosition/t
local v=r.AbsoluteSize/t
local w=s.AbsoluteSize/t

local x=b.compute({
left=u.X,
top=u.Y,
right=u.X+v.X,
bottom=u.Y+v.Y,
},{
width=w.X,
height=w.Y,
},{
width=q.Size.X.Offset,
height=an:getStackHeight(),
},ab.gapToWindow)


q.AnchorPoint=Vector2.new(x.anchorX,0)
q.Position=UDim2.fromOffset(x.x,x.y)end


m.destroy=function(p)
an:destroy()
i:reset()

if p.screenGui then
p.screenGui:Destroy()
end

p.screenGui=nil
p.awoken=false end


return m end a.db=function()local ab=a.cache.db if not ab then ab={c=aa()}a.cache.db=ab end return ab.c end end do local aa=function()a.e()



:init()

local aa=a.cQ()
local ab=a.ag()
local ac=a.cx()

local ad=a.cR()

local ae=a.db()

local af={}

af.boot=function(ag)
ag.boot=nil

aa:init{
infiniteYield=ae,
playerService=ab,
fetchService=ac
}

ad(aa)
ae:awake()end


return af end a.dc=function()local ab=a.cache.dc if not ab then ab={c=aa()}a.cache.dc=ab end return ab.c end end end














return a.dc():boot()