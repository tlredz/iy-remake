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
if e()>=g then
g=e()+(1/d)
f()
end
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
return{
action="discord|support|help",
description="Invite to the Infinite Yield discord server.",
run=function(b)
b.executorEnv.setclipboard(b.config.links.discord)
end
}end a.e=function()local c=a.cache.e if not c then c={c=b()}a.cache.e=c end return c.c end end do local b=function()
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


return c end a.f=function()local c=a.cache.f if not c then c={c=b()}a.cache.f=c end return c.c end end do local b=function()
local b={}

local c=a.a()
local d=a.d()

b.__index=function(e, f)
d:expect(f,{"string"},"[index] serviceName")

local g=game:GetService(f)
local h=c.cloneref(g)

rawset(e,f,h)
return h end


return setmetatable({},b)end a.g=function()local c=a.cache.g if not c then c={c=b()}a.cache.g=c end return c.c end end do local b=function()
local b=a.g()
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
}end a.h=function()local c=a.cache.h if not c then c={c=b()}a.cache.h=c end return c.c end end do local b=function()
return{
privateFolder="infiniteYield",
imagePath="assets/%s.png",
encryptKey=676767
}end a.i=function()local c=a.cache.i if not c then c={c=b()}a.cache.i=c end return c.c end end do local b=function()
local b=a.a()

local c=a.f()
local d=a.d()
local e=a.h()

local f=a.i()

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


return i end a.j=function()local c=a.cache.j if not c then c={c=b()}a.cache.j=c end return c.c end end do local b=function()
return a.j().new"settings"end a.k=function()local c=a.cache.k if not c then c={c=b()}a.cache.k=c end return c.c end end do local b=function()
return"v0.0.7"end a.l=function()local c=a.cache.l if not c then c={c=b()}a.cache.l=c end return c.c end end do local b=function()
return{
owner="tlredz",
repository="iy-remake"
}end a.m=function()local c=a.cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local b=function()
local b=a.m()

return{
discord="https://discord.gg/78ZuWSq",
github=`https://github.com/{b.owner}/{b.repository}`
}end a.n=function()local c=a.cache.n if not c then c={c=b()}a.cache.n=c end return c.c end end do local b=function()


local b=a.k()

return{
applicationName="Infinite Yield RV",
isRemakeVersion=true,
version=a.l(),
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

links=a.n(),
storage=a.i(),
}end a.o=function()local c=a.cache.o if not c then c={c=b()}a.cache.o=c end return c.c end end do local b=function()
local b=a.o().ui.scale

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
}end a.p=function()local c=a.cache.p if not c then c={c=b()}a.cache.p=c end return c.c end end do local b=function()
return{
action="console",
description="Opens the Roblox console",
run=function(b)
b.starterGui:SetCore("DevConsoleVisible",true)
end
}end a.q=function()local c=a.cache.q if not c then c={c=b()}a.cache.q=c end return c.c end end do local b=function()
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
}end a.r=function()local c=a.cache.r if not c then c={c=b()}a.cache.r=c end return c.c end end do local b=function()
return{
action="serverinfo|info",
description="Gives you info about the server",
run=function(b)
b.infiniteYield:createInfoMenu()
end
}end a.s=function()local c=a.cache.s if not c then c={c=b()}a.cache.s=c end return c.c end end do local b=function()
local b={
kind="boolean",
name="copy",
optional=true
}local c=function(


c, d, e)
if e==false then
c:notify(d)
else
c.executorEnv.setclipboard(d)
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
}end a.t=function()local c=a.cache.t if not c then c={c=b()}a.cache.t=c end return c.c end end do local b=function()local b=function()


local b=game.CreatorId

if game.CreatorType~=Enum.CreatorType.User then
b=self.groupService:GetGroupInfoAsync(b).Owner.Id
end

return b end


return{
{
action="creatorid",
description="Notify, or copies the creators ID to your clipboard",
args={kind="boolean",name="copy",optional=true},
run=function(c,d)
local e=tostring(b())

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
local e=b()
c.localPlayer.UserId=e
c:notify("Set ID",`Set UserId to '{e}'`)
end
}
}end a.u=function()local c=a.cache.u if not c then c={c=b()}a.cache.u=c end return c.c end end do local b=function()
return{
action="rejoin|rj",
description="Makes you rejoin the game",
run=function(b)
b.playerService:teleportToJobId(game.JobId)
end
}end a.v=function()local c=a.cache.v if not c then c={c=b()}a.cache.v=c end return c.c end end do local b=function()
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
}end a.w=function()local c=a.cache.w if not c then c={c=b()}a.cache.w=c end return c.c end end do local b=function()
return{
action="serverhop|shop",
description="Teleports you to a different server"
}end a.x=function()local c=a.cache.x if not c then c={c=b()}a.cache.x=c end return c.c end end do local b=function()
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
}end a.y=function()local c=a.cache.y if not c then c={c=b()}a.cache.y=c end return c.c end end do local b=function()
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
}end a.z=function()local c=a.cache.z if not c then c={c=b()}a.cache.z=c end return c.c end end do local b=function()
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

b:notify"anti AFK now is enabled enabled"
end
}end a.A=function()local c=a.cache.A if not c then c={c=b()}a.cache.A=c end return c.c end end do local b=function()
return{
action="datalimit",
description="Set outgoing KBPS limit",
args={kind="number",name="KB per second"},
run=function(b,c)
local d=c:nextValue()
b.networkClient:SetOutgoingKBPSLimit(d)
end
}end a.B=function()local c=a.cache.B if not c then c={c=b()}a.cache.B=c end return c.c end end do local b=function()
return{
action="replicationlag|backtrack",
description="Set IncomingReplicationLag",
args={kind="number"},
run=function(b,c)
b.gameNetworkSettings.IncomingReplicationLag=c:nextValue()
end
}end a.C=function()local c=a.cache.C if not c then c={c=b()}a.cache.C=c end return c.c end end do local b=function()
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
}end a.D=function()local c=a.cache.D if not c then c={c=b()}a.cache.D=c end return c.c end end do local b=function()
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
}end a.E=function()local c=a.cache.E if not c then c={c=b()}a.cache.E=c end return c.c end end do local b=function()
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
}end a.F=function()local c=a.cache.F if not c then c={c=b()}a.cache.F=c end return c.c end end do local b=function()local b=function(
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
}end a.G=function()local c=a.cache.G if not c then c={c=b()}a.cache.G=c end return c.c end end do local b=function()
return{
{
action="hideiy|hideinterface",
description="Hides the main IY GUI"
},
{
action="showiy|unhideiy|unhideinterface",
description="Shows IY again"
}
}end a.H=function()local c=a.cache.H if not c then c={c=b()}a.cache.H=c end return c.c end end do local b=function()
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
}end a.I=function()local c=a.cache.I if not c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()local b=function(
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
}end a.J=function()local c=a.cache.J if not c then c={c=b()}a.cache.J=c end return c.c end end do local b=function()
return{
action="saveinstance|savegame|saveplace|savep",
description="Uses saveinstance to save the game"
}end a.K=function()local c=a.cache.K if not c then c={c=b()}a.cache.K=c end return c.c end end do local b=function()
return{
action="clearerror",
description="Clears the annoying box and blur when a game kicks you"
}end a.L=function()local c=a.cache.L if not c then c={c=b()}a.cache.L=c end return c.c end end do local b=function()
return{
{
action="antigameplaypaused",
description="Clears the annoying box shown when a game is loading assets due to network lag"
},
{
action="unantigameplaypaused",
description="Disables antigameplaypaused"
}
}end a.M=function()local c=a.cache.M if not c then c={c=b()}a.cache.M=c end return c.c end end do local b=function()
return{
action="clientantikick|antikick",
description="Prevents localscripts from kicking you (CLIENT)"
}end a.N=function()local c=a.cache.N if not c then c={c=b()}a.cache.N=c end return c.c end end do local b=function()
return{
action="clientantiteleport|antiteleport",
description="Prevents localscripts from teleporting you (CLIENT)"
}end a.O=function()local c=a.cache.O if not c then c={c=b()}a.cache.O=c end return c.c end end do local b=function()
return{
cliemt=true,
action="allowrejoin|allowrj",
description="Changes if antiteleport allows you to rejoin or not",
args={kind="boolean"},
run=function(b,c)
b.storage.settings:setValue("allowRejoin",args:nextValue())
end
}end a.P=function()local c=a.cache.P if not c then c={c=b()}a.cache.P=c end return c.c end end do local b=function()
return{
action="cancelteleport|canceltp",
description="Cancels teleports in progress",
run=function(b)
b.teleportService:TeleportCancel()
end
}end a.Q=function()local c=a.cache.Q if not c then c={c=b()}a.cache.Q=c end return c.c end end do local b=function()
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
}end a.R=function()local c=a.cache.R if not c then c={c=b()}a.cache.R=c end return c.c end end do local b=function()
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
}end a.S=function()local c=a.cache.S if not c then c={c=b()}a.cache.S=c end return c.c end end do local b=function()
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
}end a.T=function()local c=a.cache.T if not c then c={c=b()}a.cache.T=c end return c.c end end do local b=function()
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
}end a.U=function()local c=a.cache.U if not c then c={c=b()}a.cache.U=c end return c.c end end do local b=function()
return{
action="lastcommand|lastcmd",
description="Executes the previous command used"
}end a.V=function()local c=a.cache.V if not c then c={c=b()}a.cache.V=c end return c.c end end do local b=function()
return{
action="notifyping|ping",
description="Notify yourself your ping",
run=function(b)
local c=b.localPlayer:GetNetworkPing()
b:notify("Ping",`{math.round(c*1000)}ms`)
end
}end a.W=function()local c=a.cache.W if not c then c={c=b()}a.cache.W=c end return c.c end end do local b=function()
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
}end a.X=function()local c=a.cache.X if not c then c={c=b()}a.cache.X=c end return c.c end end do local b=function()
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
}end a.Y=function()local c=a.cache.Y if not c then c={c=b()}a.cache.Y=c end return c.c end end do local b=function()
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
}end a.Z=function()local c=a.cache.Z if not c then c={c=b()}a.cache.Z=c end return c.c end end do local b=function()local b=function(
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
}end a._=function()local c=a.cache._ if not c then c={c=b()}a.cache._=c end return c.c end end do local b=function()
return{
action="exit",
description="Kills roblox process",
run=function()
game:shutdown()
end
}end a.aa=function()local c=a.cache.aa if not c then c={c=b()}a.cache.aa=c end return c.c end end do local b=function()


return{
action="notifyjobid",
description="Notifies the JobId and PlaceId of the current server",
run=function(b)
b:notify("JobId / PlaceId",`{game.JobId} / {game.PlaceId}`)
end
}end a.ab=function()local c=a.cache.ab if not c then c={c=b()}a.cache.ab=c end return c.c end end do local b=function()

local b=a.g()
return b.Players.LocalPlayer end a.ac=function()local c=a.cache.ac if not c then c={c=b()}a.cache.ac=c end return c.c end end do local b=function()
local b=a.g()
local c=a.ac()
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











































































return g end a.ad=function()local c=a.cache.ad if not c then c={c=b()}a.cache.ad=c end return c.c end end do local b=function()
local b=a.g()
local c=a.ad()
local d=a.ac()local e=function(





e)
for f=#e,2,-1 do
local g=math.random(1,f)
e[f],e[g]=e[g],e[f]
end
return e end local f=function(


f)
local g=(f or"me"):lower()
local h=b.Players:GetPlayers()

if g=="me"then
return{d}
elseif g=="all"then
return h
elseif g=="others"then
local i={}
for j,k in h do
if k~=d then
table.insert(i,k)
end
end
return i
elseif g=="random"then
return{h[math.random(1,#h)]}
end

local i=tonumber(g:match"^#(%d+)$")
if i then
return table.move(e(h),1,math.min(i,#h),1,{})
end

return c:getPlayersByName(f)end


return f end a.ae=function()local c=a.cache.ae if not c then c={c=b()}a.cache.ae=c end return c.c end end do local b=function()

local b=a.ae()

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
}end a.af=function()local c=a.cache.af if not c then c={c=b()}a.cache.af=c end return c.c end end do local b=function()

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
}end a.ag=function()local c=a.cache.ag if not c then c={c=b()}a.cache.ag=c end return c.c end end do local b=function()

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
}end a.ah=function()local c=a.cache.ah if not c then c={c=b()}a.cache.ah=c end return c.c end end do local b=function()

return{
action="mousesensitivity|ms",
description="Sets your mouse delta sensitivity",
args={kind="number",name="sensitivity"},
run=function(b,c)
b.robloxServices.UserInputService.MouseDeltaSensitivity=c:nextValue()
end
}end a.ai=function()local c=a.cache.ai if not c then c={c=b()}a.cache.ai=c end return c.c end end do local b=function()

local b=a.ae()

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
}end a.aj=function()local c=a.cache.aj if not c then c={c=b()}a.cache.aj=c end return c.c end end do local b=function()local b=function(


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
}end a.ak=function()local c=a.cache.ak if not c then c={c=b()}a.cache.ak=c end return c.c end end do local b=function()

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
}end a.al=function()local c=a.cache.al if not c then c={c=b()}a.cache.al=c end return c.c end end do local b=function()

return{
{
action="team",
description="Changes your team. Sometimes fools localscripts. (CLIENT)",
args={
kind="team"
}
}
}end a.am=function()local c=a.cache.am if not c then c={c=b()}a.cache.am=c end return c.c end end do local b=function()

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
name="radius"
}
}
}
}end a.an=function()local c=a.cache.an if not c then c={c=b()}a.cache.an=c end return c.c end end do local b=function()

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
}end a.ao=function()local c=a.cache.ao if not c then c={c=b()}a.cache.ao=c end return c.c end end do local b=function()

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
}end a.ap=function()local c=a.cache.ap if not c then c={c=b()}a.cache.ap=c end return c.c end end do local b=function()

return{
{
action="clickdelete",
description="Go to Settings > Keybinds > Add for click delete"
},
{
action="clickteleport",
description="Go to Settings > Keybinds > Add for click teleport"
}
}end a.aq=function()local c=a.cache.aq if not c then c={c=b()}a.cache.aq=c end return c.c end end do local b=function()

return{
{
action="promptr6",
description="Prompts the game to switch your rig type to R6"
},
{
action="promptr15",
description="Prompts the game to switch your rig type to R15"
}
}end a.ar=function()local c=a.cache.ar if not c then c={c=b()}a.cache.ar=c end return c.c end end do local b=function()

return{a.e()
,a.p()
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
,a.W()
,a.X()
,a.Y()
,a.Z()
,a._()
,a.aa()
,a.ab()


,a.af()
,a.ag()
,a.ah()
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

}end a.as=function()local c=a.cache.as if not c then c={c=b()}a.cache.as=c end return c.c end end do local b=function()

return{
{
action="fly",
description="Makes you fly",
args={
kind="number",
name="fly speed",
optional=true
}
},
{
action="flyspeed",
description="Set fly speed (default is 20)",
args={
kind="number",
name="fly speed"
}
},
{
action="unfly",
description="Disables fly"
}
}end a.at=function()local c=a.cache.at if not c then c={c=b()}a.cache.at=c end return c.c end end do local b=function()
return{
{
action="noclip",
description="Go through objects"
},
{
action="unnoclip|clip",
description="Disables noclip"
}
}end a.au=function()local c=a.cache.au if not c then c={c=b()}a.cache.au=c end return c.c end end do local b=function()
return{
{
action="vehiclefly|vfly",
description="Makes you fly in a vehicle",
args={
kind="number",
name="vehicle fly speed",
optional=true
}
},
{
action="vehicleflyspeed|vflyspeed",
description="Set vehicle fly speed",
args={
kind="number",
name="vehicle fly speed"
}
},
{
action="unvehiclefly|unvfly",
description="Disables vehicle fly"
}
}end a.av=function()local c=a.cache.av if not c then c={c=b()}a.cache.av=c end return c.c end end do local b=function()
return{
{
action="cframefly|cfly",
description="Makes you fly, bypassing some anti cheats (works on mobile)",
args={
kind="number",
name="speed",
optional=true
}
},
{
action="cframeflyspeed|cflyspeed",
description="Sets cfly speed",
args={
kind="number"
}
},
{
action="uncframefly|uncfly",
description="Disables cfly"
}
}end a.aw=function()local c=a.cache.aw if not c then c={c=b()}a.cache.aw=c end return c.c end end do local b=function()
return{
action="qefly",
description="Enables or disables the Q and E hotkeys for fly",
args={
kind="boolean"
}
}end a.ax=function()local c=a.cache.ax if not c then c={c=b()}a.cache.ax=c end return c.c end end do local b=function()
return{
{
action="vehiclenoclip|vnoclip",
description="Turns off vehicle collision"
},
{
action="vehicleclip|vclip|unvnoclip",
description="Enables vehicle collision"
},
}end a.ay=function()local c=a.cache.ay if not c then c={c=b()}a.cache.ay=c end return c.c end end do local b=function()
return{
{
action="float|platform",
description="Spawns a platform beneath you causing you to float"
},
{
action="unfloat|noplatform",
description="Removes the platform"
}
}end a.az=function()local c=a.cache.az if not c then c={c=b()}a.cache.az=c end return c.c end end do local b=function()
return{
{
action="swim",
description="Allows you to swim in the air"
},
{
action="unswim|noswim",
description="Stops you from swimming everywhere"
},
{
action="toggleswim",
description="Toggles swimming"
}
}end a.aA=function()local c=a.cache.aA if not c then c={c=b()}a.cache.aA=c end return c.c end end do local b=function()local b=function(
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
}end a.aB=function()local c=a.cache.aB if not c then c={c=b()}a.cache.aB=c end return c.c end end do local b=function()local b=function(

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
}end a.aC=function()local c=a.cache.aC if not c then c={c=b()}a.cache.aC=c end return c.c end end do local b=function()local b=function(


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
}end a.aD=function()local c=a.cache.aD if not c then c={c=b()}a.cache.aD=c end return c.c end end do local b=function()

local b=a.ae()local c=function(

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
}end a.aE=function()local c=a.cache.aE if not c then c={c=b()}a.cache.aE=c end return c.c end end do local b=function()

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
}end a.aF=function()local c=a.cache.aF if not c then c={c=b()}a.cache.aF=c end return c.c end end do local b=function()local b=function(

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
}end a.aG=function()local c=a.cache.aG if not c then c={c=b()}a.cache.aG=c end return c.c end end do local b=function()


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
}end a.aH=function()local c=a.cache.aH if not c then c={c=b()}a.cache.aH=c end return c.c end end do local b=function()local b=function(

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
}end a.aI=function()local c=a.cache.aI if not c then c={c=b()}a.cache.aI=c end return c.c end end do local b=function()local b=function(

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
}end a.aJ=function()local c=a.cache.aJ if not c then c={c=b()}a.cache.aJ=c end return c.c end end do local b=function()

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
}end a.aK=function()local c=a.cache.aK if not c then c={c=b()}a.cache.aK=c end return c.c end end do local b=function()local b=function(




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
}end a.aL=function()local c=a.cache.aL if not c then c={c=b()}a.cache.aL=c end return c.c end end do local b=function()

local b=a.ae()

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
}end a.aM=function()local c=a.cache.aM if not c then c={c=b()}a.cache.aM=c end return c.c end end do local b=function()local b=function(

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
}end a.aN=function()local c=a.cache.aN if not c then c={c=b()}a.cache.aN=c end return c.c end end do local b=function()

local b=PhysicalProperties.new(100,0.3,0.5)local c=function()


local c=Instance.new"BodyAngularVelocity"
c.MaxTorque=Vector3.yAxis*math.huge
c.P=math.huge
return c end local d=function(


d, e)
if d:hasGarbage"fling"then
d:notify"fling is already enabled\ndisable using 'unfling'"
return
end

local f=d.playerService:getHumanoid()
if not(f and f.Health~=0)then return end

local g=f.Parent

d:notify"fling now is activated"
d:run"noclip"

local h=d:createGarbage"fling"
h.originalStates={}

for i,j in g:GetDescendants()do
if not j:IsA"BasePart"then continue end

h.originalStates[j]={
CustomPhysicalProperties=j.CustomPhysicalProperties,
CanCollide=j.CanCollide,
Massless=j.Massless
}

j.CustomPhysicalProperties=b

if j.Parent==g then
j.CanCollide=false
j.Massless=true
j.Velocity=Vector3.zero
end
end

local i=c()

h.flingVelocity=i
h.flingConnection=f.Died:Once(function()
d:notify"player died: disabling fling..."
d:run"unfling"
end)

i.Parent=g:WaitForChild"HumanoidRootPart"

while i and g and g.Parent do
i.AngularVelocity=Vector3.yAxis*99999
task.wait(0.2)
i.AngularVelocity=Vector3.one
task.wait(0.1)
end end local e=function(


e)
local f=e:collectGarbage"fling"
if not f then return end

if f.flingVelocity then
f.flingVelocity:Destroy()
end

if f.flingConnection then
f.flingConnection:Disconnect()
end

for g,h in f.originalStates do
for i,j in h do
g[i]=j
end
end

e:notify"fling disabled"end


return{
{
action="fling|forcefling",
description="Flings anyone you touch",
run=d
},
{
action="unfling",
description="Disables the fling command",
run=e
},
{
action="flyfling",
description="Basically the invisfling command but not invisible",
args={
kind="number",
name="speed",
optional=true
}
},
{
action="unflyfling",
description="Disables the flyfling command"
},
{
action="walkfling",
description="Basically fling but no spinning"
},
{
action="unwalkfling|nowalkfling",
description="Disables walkfling"
},
{
action="invisfling",
description="Enables invisible fling (the invis part is patched, try using the god command before using this)"
},
{
action="antifling",
description="Disables player collisions to prevent you from being flung"
},
{
action="unantifling",
description="Disables antifling"
}
}end a.aO=function()local c=a.cache.aO if not c then c={c=b()}a.cache.aO=c end return c.c end end do local b=function()

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
}end a.aP=function()local c=a.cache.aP if not c then c={c=b()}a.cache.aP=c end return c.c end end do local b=function()local b=function(

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
}end a.aQ=function()local c=a.cache.aQ if not c then c={c=b()}a.cache.aQ=c end return c.c end end do local b=function()

return{
{
action="hatspin|spinhats",
description="Spins your characters accessories"
},
{
action="unhatspin|unspinhats",
description="Undoes spinhats"
},
{
action="clearhats|cleanhats",
description="Clears hats in the workspace"
}
}end a.aR=function()local c=a.cache.aR if not c then c={c=b()}a.cache.aR=c end return c.c end end do local b=function()

return{
{
action="tools",
description="Copies tools from ReplicatedStorage and Lighting"
},
{
action="grabtools",
description="Automatically get tools that are dropped"
},
{
action="ungrabtools|nograbtools",
description="Disables grabtools"
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
description="Makes your tools droppable"
},
{
action="reach",
description="Increases the hitbox of your held tool",
args={
kind="number"
}
},
{
action="boxreach",
description="Increases the hitbox of your held tool in a box shape",
args={
kind="number"
}
},
{
action="unreach|noreach",
description="Turns off reach"
},
{
action="grippos",
description="Changes your current tools grip position",
args={
kind="vector3"
},
run=function(b,c)
local d=b.localPlayer.Character
local e=b.localPlayer:FindFirstChildOfClass"Backpack"
if not(d and e)then return end

local f=c:nextValue()
for g,h in d:GetChildren()do
if h:IsA"Tool"then
h.Parent=e
h.GripPos=f
h.Parent=d
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
}
}
}end a.aS=function()local c=a.cache.aS if not c then c={c=b()}a.cache.aS=c end return c.c end end do local b=function()

return{
{
action="autojump|ajump",
description="Automatically jumps when you run into an object"
},
{
action="unautojump|unajump",
description="Disables autojump"
},
{
action="edgejump|ejump",
description="Automatically jumps when you get to the edge of an object"
},
{
action="unedgejump|unejump",
description="Disables edgejump"
}
}end a.aT=function()local c=a.cache.aT if not c then c={c=b()}a.cache.aT=c end return c.c end end do local b=function()

return{
{
action="spoofspeed|spoofws",
description="Spoofs your WalkSpeed on the Client",
args={
kind="number"
}
},
{
action="spoofjumppower|spoofjp",
description="Spoofs your JumpPower on the Client",
args={
kind="number"
}
}
}end a.aU=function()local c=a.cache.aU if not c then c={c=b()}a.cache.aU=c end return c.c end end do local b=function()

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
name="head size"
}
}
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
name="size"
},
{
kind="number",
name="transparency",
clamp={0,1}
}
}
}
}end a.aV=function()local c=a.cache.aV if not c then c={c=b()}a.cache.aV=c end return c.c end end do local b=function()

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
name="speed"
},
{
kind="number",
name="distance"
}
}
},
{
action="unorbit",
description="Disables orbit"
}
}end a.aW=function()local c=a.cache.aW if not c then c={c=b()}a.cache.aW=c end return c.c end end do local b=function()

return{
{
action="headsit",
description="Sit on a players head",
args={
kind="player"
}
}
}end a.aX=function()local c=a.cache.aX if not c then c={c=b()}a.cache.aX=c end return c.c end end do local b=function()

return{
{
action="god",
description="Makes your character difficult to kill in most games"
}
}end a.aY=function()local c=a.cache.aY if not c then c={c=b()}a.cache.aY=c end return c.c end end do local b=function()

return{
{
action="fakeout",
description="Tp to the void and then back (useful to kill people attached to you)"
},
{
action="scare|spook",
description="Teleports in front of a player for half a second",
args={
kind="player"
}
},
{
action="jerk",
description="Makes you jork it"
}
}end a.aZ=function()local c=a.cache.aZ if not c then c={c=b()}a.cache.aZ=c end return c.c end end do local b=function()

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
}
},
{
action="unbang",
description="uwu"
},
{
action="carpet",
description="Be someones carpet",
args={
kind="player"
}
},
{
action="uncarpet",
description="Undoes carpet"
}
}end a.a_=function()local c=a.cache.a_ if not c then c={c=b()}a.cache.a_=c end return c.c end end do local b=function()

return{
{
action="copyanimation|copyanim|copyemote",
description="Copies someone elses animation",
args={
kind="player"
}
},
{
action="copyanimationid|copyanimid|copyemoteid",
description="Copies your animation id or someone elses to your clipboard",
args={
kind="player",
optional=true
}
}
}end a.a0=function()local c=a.cache.a0 if not c then c={c=b()}a.cache.a0=c end return c.c end end do local b=function()

return{a.at()
,a.au()
,a.av()
,a.aw()
,a.ax()
,a.ay()
,a.az()
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

}end a.a1=function()local c=a.cache.a1 if not c then c={c=b()}a.cache.a1=c end return c.c end end do local b=function()




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
}end a.a2=function()local c=a.cache.a2 if not c then c={c=b()}a.cache.a2=c end return c.c end end do local b=function()

return{
action="tweenspeed|tspeed",
description="Sets how fast all tween commands go (default is 1)",
args={kind="number",name="tween speed",optional=true},
run=function(b,c)
b.privateEnv.tweenSpeed=c:nextValue()or 1
end
}end a.a3=function()local c=a.cache.a3 if not c then c={c=b()}a.cache.a3=c end return c.c end end do local b=function()

return{
{
action="goto",
description="Go to a player",
args={kind="player"}
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
}
},
{
action="loopgoto",
description="Loop teleport to a player",
args={
{
kind="string",
name="player distance"
},
{
kind="number",
name="delay"
}
}
},
{
action="unloopgoto",
description="Stops teleporting you to a player"
}
}end a.a4=function()local c=a.cache.a4 if not c then c={c=b()}a.cache.a4=c end return c.c end end do local b=function()
return{
action="vehiclegoto|vgoto",
description="Go to a player while in a vehicle",
args={kind="player"}
}end a.a5=function()local c=a.cache.a5 if not c then c={c=b()}a.cache.a5=c end return c.c end end do local b=function()
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
}
}end a.a6=function()local c=a.cache.a6 if not c then c={c=b()}a.cache.a6=c end return c.c end end do local b=function()
return{
{
action="clientbring|cbring",
description="Bring a player (CLIENT)",
args={
kind="player"
}
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
}
},
{
action="unloopbring",
description="Undoes loopbring",
args={kind="player"}
}
}end a.a7=function()local c=a.cache.a7 if not c then c={c=b()}a.cache.a7=c end return c.c end end do local b=function()
return{
{
client=true,
action="freeze|fr",
description="Freezes a player",
args={kind="player"}
},
{
client=true,
action="thaw|unfr",
description="Unfreezes a player",
args={kind="player"}
}
}end a.a8=function()local c=a.cache.a8 if not c then c={c=b()}a.cache.a8=c end return c.c end end do local b=function()
return{
{
action="freezeanims",
description="Freezes your animations / pauses your animations - Does not work on default animations"
},
{
action="unfreezeanims",
description="Unfreezes your animations / plays your animations"
}
}end a.a9=function()local c=a.cache.a9 if not c then c={c=b()}a.cache.a9=c end return c.c end end do local b=function()local b=function(
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
}end a.ba=function()local c=a.cache.ba if not c then c={c=b()}a.cache.ba=c end return c.c end end do local b=function()

return{
{
action="tpposition|tppos",
description="Teleports you to certain coordinates",
args={kind="vector3"}
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
}
},
{
action="offset",
description="Offsets you by certain coordinates",
args={kind="vector3"}
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
}
},
{
action="thru",
description="Teleports you [num] studs ahead of where your character is facing",
args={kind="number"}
}
}end a.bb=function()local c=a.cache.bb if not c then c={c=b()}a.cache.bb=c end return c.c end end do local b=function()
return{
{
action="notifyposition|notifypos",
description="Notifies you the coordinates of a character",
args={
kind="player",
optional=true
}
},
{
action="copyposition|copypos",
description="Copies the coordinates of a character to your clipboard",
args={
kind="player",
optional=true
}
}
}end a.bc=function()local c=a.cache.bc if not c then c={c=b()}a.cache.bc=c end return c.c end end do local b=function()
return{
action="walktoposition|walktopos",
description="Makes you walk to a coordinate",
args={kind="vector3"}
}end a.bd=function()local c=a.cache.bd if not c then c={c=b()}a.cache.bd=c end return c.c end end do local b=function()
return{
{
action="spawnpoint|spawn",
description="Sets a position where you will spawn",
args={
kind="number",
name="delay",
optional=true
}
},
{
action="nospawnpoint|nospawn",
description="Removes your custom spawn point"
}
}end a.be=function()local c=a.cache.be if not c then c={c=b()}a.cache.be=c end return c.c end end do local b=function()
return{
action="flashback|diedtp",
description="Teleports you to where you last died"
}end a.bf=function()local c=a.cache.bf if not c then c={c=b()}a.cache.bf=c end return c.c end end do local b=function()
return{
{
action="walltp",
description="Teleports you above/over any wall you run into"
},
{
action="nowalltp|unwalltp",
description="Disables walltp"
}
}end a.bg=function()local c=a.cache.bg if not c then c={c=b()}a.cache.bg=c end return c.c end end do local b=function()
return{
action="teleporttool|tptool",
description="Gives you a teleport tool"
}end a.bh=function()local c=a.cache.bh if not c then c={c=b()}a.cache.bh=c end return c.c end end do local b=function()local b=function(


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
}end a.bi=function()local c=a.cache.bi if not c then c={c=b()}a.cache.bi=c end return c.c end end do local b=function()

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
}end a.bj=function()local c=a.cache.bj if not c then c={c=b()}a.cache.bj=c end return c.c end end do local b=function()

return{
{
action="tpwalk|teleportwalk",
description="Teleports you to your move direction",
args={
{
kind="number",
name="distance"
},
{
kind="boolean",
name="stack distance",
optional=true
}
}
},
{
action="untpwalk|unteleportwalk",
description="Undoes tpwalk / teleportwalk"
},
{
action="wallwalk|walkonwalls",
description="Walk on walls"
}
}end a.bk=function()local c=a.cache.bk if not c then c={c=b()}a.cache.bk=c end return c.c end end do local b=function()

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
}end a.bl=function()local c=a.cache.bl if not c then c={c=b()}a.cache.bl=c end return c.c end end do local b=function()

return{a.a3()
,a.a4()
,a.a5()
,a.a6()
,a.a7()
,a.a8()
,a.a9()
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
,a.bl()

}end a.bm=function()local c=a.cache.bm if not c then c={c=b()}a.cache.bm=c end return c.c end end do local b=function()

return{
{
action="logs",
description="Opens the logs GUI"
},
{
action="chatlogs|clogs",
description="Log what people say or whisper"
},
{
action="joinlogs|jlogs",
description="Log when people join"
},
{
action="chatlogswebhook|logswebhook",
description="Set a discord webhook for chatlogs to go to (provide no url to disable this)",
args={
kind="string",
name="url",
optional=true
}
}
}end a.bn=function()local c=a.cache.bn if not c then c={c=b()}a.cache.bn=c end return c.c end end do local b=function()
return{
{
action="chat|say",
description="Makes you chat a string (possible mute bypass)",
args={
kind="string",
name="your message"
}
},
{
action="spam",
description="Makes you spam the chat",
args={
kind="string",
name="your message"
}
},
{
action="unspam",
description="Turns off spam"
},
{
action="whisper|pm",
description="Makes you whisper a string to someone (possible mute bypass)",
args={
{
kind="player"
},
{
kind="string",
name="your message"
}
}
},
{
action="pmspam",
description="Makes you spam a players whispers",
args={
{
kind="player",
},
{
kind="string",
name="your message"
}
}
},
{
action="unpmspam",
description="Turns off pm spam",
args={kind="player"}
},
{
action="spamspeed|spamdelay",
description="How quickly you spam (default is 1)",
args={kind="number"}
}
}end a.bo=function()local c=a.cache.bo if not c then c={c=b()}a.cache.bo=c end return c.c end end do local b=function()
return{
{
action="bubblechat",
description="Enables bubble chat for your client (CLIENT)"
},
{
action="unbubblechat|nobubblechat",
description="Disables the bubblechat command"
}
}end a.bp=function()local c=a.cache.bp if not c then c={c=b()}a.cache.bp=c end return c.c end end do local b=function()
return{
{
action="chatwindow",
description="Enables the chat window for your client"
},
{
action="unchatwindow|nochatwindow",
description="Disables the chat window for your client"
},
{
action="darkchat",
description="Makes the chat window dark for your client"
}
}end a.bq=function()local c=a.cache.bq if not c then c={c=b()}a.cache.bq=c end return c.c end end do local b=function()
return{
{
action="listento",
description="Listens to the area around a player. Can also eavesdrop with vc",
args={kind="player"}
},
{
action="unlistento",
description="Disables listento"
},
{
action="muteallvoices|muteallvcs",
description="Mutes voice chat for all players"
},
{
action="unmuteallvoices|unmuteallvcs",
description="Unmutes voice chat for all players"
},
{
action="mutevc",
description="Mutes the voice chat of a player",
args={kind="player"}
},
{
action="unmutevc",
description="Unmutes the voice chat of a player",
args={kind="player"}
},
{
action="phonebook|call",
description="Prompts the Roblox phonebook UI to let you call your friends. Needs voice chat enabled"
}
}end a.br=function()local c=a.cache.br if not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()
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
}end a.bs=function()local c=a.cache.bs if not c then c={c=b()}a.cache.bs=c end return c.c end end do local b=function()

local b=a.ae()

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
}end a.bt=function()local c=a.cache.bt if not c then c={c=b()}a.cache.bt=c end return c.c end end do local b=function()

return{a.bn()
,a.bo()
,a.bp()
,a.bq()
,a.br()
,a.bs()
,a.bt()

}end a.bu=function()local c=a.cache.bu if not c then c={c=b()}a.cache.bu=c end return c.c end end do local b=function()

return{
{
action="esp",
description="View all players and their status"
},
{
action="espteam",
description="ESP but teammates are green and bad guys are red"
},
{
action="noesp|unesp|unespteam",
description="Removes ESP"
},
{
action="esptransparency",
description="Changes the transparency of ESP related commands",
args={kind="number"}
},
{
action="partesp",
description="Highlights a part",
args={
kind="string",
name="part name"
}
},
{
action="unpartesp|nopartesp",
description="removes partesp",
args={
kind="string",
name="part name"
}
},
{
action="chams",
description="ESP but without text in the way"
},
{
action="nochams|unchams",
description="Removes chams"
}
}end a.bv=function()local c=a.cache.bv if not c then c={c=b()}a.cache.bv=c end return c.c end end do local b=function()
return{
{
action="locate",
description="View a single player and their status",
args={kind="player"}
},
{
action="unlocate|nolocate",
description="Removes locate",
args={kind="player"}
},
}end a.bw=function()local c=a.cache.bw if not c then c={c=b()}a.cache.bw=c end return c.c end end do local b=function()
return{
{
action="xray",
description="Makes all parts in workspace transparent"
},
{
action="unxray|noxray",
description="Restores transparency to all parts in workspace"
},
{
action="loopxray",
description="Makes all parts in workspace transparent but looped"
},
{
action="unloopxray",
description="Unloops xray"
},
{
action="togglexray",
description="Toggles xray"
}
}end a.bx=function()local c=a.cache.bx if not c then c={c=b()}a.cache.bx=c end return c.c end end do local b=function()
return{
{
action="hovername",
description="Shows a players username when your mouse is hovered over them"
},
{
action="unhovername|nohovername",
description="Turns off hovername"
}
}end a.by=function()local c=a.cache.by if not c then c={c=b()}a.cache.by=c end return c.c end end do local b=function()

return{a.bv()
,a.bw()
,a.bx()
,a.by()

}end a.bz=function()local c=a.cache.bz if not c then c={c=b()}a.cache.bz=c end return c.c end end do local b=function()

return{
{
action="spectate|view",
description="View a player",
args={kind="player"}
},
{
action="viewpart|viewp",
description="View a part",
args={
kind="string",
name="part name"
}
},
{
action="unspectate|unview",
description="Stops viewing player, or part."
}
}end a.bA=function()local c=a.cache.bA if not c then c={c=b()}a.cache.bA=c end return c.c end end do local b=function()
return{
{
action="freecam|fc",
description="Allows you to freely move camera around the game",
args={
kind="number",
name="camera speed",
optional=true
}
},
{
action="freecampos|fcpos",
description="Moves / opens freecam in a certain position",
args={kind="vector3"}
},
{
action="freecamwaypoint|fcwp",
description="Moves / opens freecam to a waypoint",
args={
kind="waypoint"
}
},
{
action="freecamgoto|fcgoto|fctp",
description="Moves / opens freecam to a player",
args={kind="player"}
},
{
action="unfreecam|unfc",
description="Disables freecam"
},
{
action="freecamspeed|fcspeed",
description="Adjusts freecam speed (default is 1)",
args={kind="number"}
},
{
action="notifyfreecamposition|notifyfcpos",
description="Noitifies you your freecam coordinates"
},
{
action="copyfreecamposition|copyfcpos",
description="Copies your freecam coordinates to your clipboard"
},
}end a.bB=function()local c=a.cache.bB if not c then c={c=b()}a.cache.bB=c end return c.c end end do local b=function()
return{
{
action="gotocamera|gotocam",
description="Teleports you to the location of your camera"
},
{
action="tweengotocam|tgotocam",
description="Tweens you to the location of your camera"
}
}end a.bC=function()local c=a.cache.bC if not c then c={c=b()}a.cache.bC=c end return c.c end end do local b=function()
return{
{
action="firstp",
description="Forces camera to go into first person",
run=function(b)
b.localPlayer.CameraMode=Enum.CameraMode.LockFirstPerson
end
},
{
action="thirdp",
description="Allows camera to go into third person",
run=function(b)
b.localPlayer.CameraMode=Enum.CameraMode.Classic
end
}
}end a.bD=function()local c=a.cache.bD if not c then c={c=b()}a.cache.bD=c end return c.c end end do local b=function()

return{
action="noclipcam|nccam",
description="Allows camera to go through objects like walls"
}end a.bE=function()local c=a.cache.bE if not c then c={c=b()}a.cache.bE=c end return c.c end end do local b=function()
return{
{
action="maxzoom",
description="Maximum camera zoom",
args={kind="number"},
run=function(b,c)
b.localPlayer.CameraMaxZoomDistance=c:nextValue()
end
},
{
action="minzoom",
description="Minimum camera zoom",
args={kind="number"},
run=function(b,c)
b.localPlayer.CameraMinZoomDistance=c:nextValue()
end
},
{
action="camdistance",
description="Changes camera distance from your player",
args={kind="number"},
run=function(b,c)
local d=c:nextValue()
local e=b.localPlayer
local f=e.CameraMaxZoomDistance
local g=e.CameraMinZoomDistance

if f<d then
f=d
end

e.CameraMaxZoomDistance=d
e.CameraMinZoomDistance=d
task.wait()
e.CameraMaxZoomDistance=f
e.CameraMinZoomDistance=g
end
}
}end a.bF=function()local c=a.cache.bF if not c then c={c=b()}a.cache.bF=c end return c.c end end do local b=function()

return{
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(b,c)
local d=math.abs(c:nextValue())
workspace.CurrentCamera.FieldOfView=d
end
}end a.bG=function()local c=a.cache.bG if not c then c={c=b()}a.cache.bG=c end return c.c end end do local b=function()
return{
action="fixcam|restorecam",
description="Fixes camera",
run=function(b)
local c=b.playerService
local d=b.localPlayer

local e=c:getHumanoid()

if e then
b.signals.onCameraReset:Fire()

local f=c:getCamera()
f.CameraSubject=e
f.CameraType=Enum.CameraType.Custom

d.CameraMinZoomDistance=0.5
d.CameraMaxZoomDistance=400
d.CameraMode=Enum.CameraMode.Classic

b:notify"camera has been reseted successfully"
end
end
}end a.bH=function()local c=a.cache.bH if not c then c={c=b()}a.cache.bH=c end return c.c end end do local b=function()
return{
action="enableshiftlock|enablesl",
description="Enables the shift lock option"
}end a.bI=function()local c=a.cache.bI if not c then c={c=b()}a.cache.bI=c end return c.c end end do local b=function()
return{
action="lookat",
description="Moves your camera view to a player",
args={kind="player"}
}end a.bJ=function()local c=a.cache.bJ if not c then c={c=b()}a.cache.bJ=c end return c.c end end do local b=function()
return{
{
action="stareat|stare",
description="Stare / look at a player",
args={
kind="player"
}
},
{
action="unstareat|unstare",
description="Disables stareat",
args={
kind="player"
}
}
}end a.bK=function()local c=a.cache.bK if not c then c={c=b()}a.cache.bK=c end return c.c end end do local b=function()

return{a.bA()
,a.bB()
,a.bC()
,a.bD()
,a.bE()
,a.bF()
,a.bG()
,a.bH()
,a.bI()
,a.bJ()
,a.bK()

}end a.bL=function()local c=a.cache.bL if not c then c={c=b()}a.cache.bL=c end return c.c end end do local b=function()

return{
{
client=true,
action="btools",
description="Gives you building tools (DOES NOT REPLICATE)"
},
{
client=true,
action="f3x",
description="Gives you F3X building tools (DOES NOT REPLICATE)"
},
}end a.bM=function()local c=a.cache.bM if not c then c={c=b()}a.cache.bM=c end return c.c end end do local b=function()
return{
action="partname|partpath",
description="Allows you to click a part to see its path & name"
}end a.bN=function()local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do local b=function()
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
}
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
}
}
}end a.bO=function()local c=a.cache.bO if not c then c={c=b()}a.cache.bO=c end return c.c end end do local b=function()
return{
{
action="lockworkspace|lockws",
description="Locks the whole workspace"
},
{
action="unlockworkspace|unlockws",
description="Unlocks the whole workspace"
}
}end a.bP=function()local c=a.cache.bP if not c then c={c=b()}a.cache.bP=c end return c.c end end do local b=function()
return{
{
client=true,
action="invisibleparts|invisparts",
description="Shows invisible parts"
},
{
client=true,
action="uninvisibleparts|uninvisparts",
description="Makes parts affected by invisparts return to normal"
}
}end a.bQ=function()local c=a.cache.bQ if not c then c={c=b()}a.cache.bQ=c end return c.c end end do local b=function()local b=function(
b, c, d)
return{
action=b,
description=c,
run=function()
for e,f in workspace:GetDescendants()do
if f:IsA(d)then
f.MaxActivationDistance=math.huge
end
end
end
}end


return{
b(
"noclickdetectorlimits|nocdlimits|removecdlimits",
"Removes the activation distance limit of ClickDetectors",
"ClickDetector"
),
b(
"noproximitypromptlimits|nopplimits|removepplimits",
"Removes the activation distance limit of ProximityPrompts",
"ProximityPrompt"
),
{
action="instantproximityprompts|instantpp",
description="Fires proximity prompts as soon as they are held (needs fireproximityprompt)",
run=function(c)
local d=c.executorEnv.fireproximityprompt

if not d then
c:notify("Incompatible Exploit","Your exploit does not support this command (missing fireproximityprompt)")
return
end

if c:hasGarbage"instantpp"then
c:notify"instant proximity prompts is already enabled"
return
end

local e=c:createGarbage"instantpp"
e.connection=c:connect(c.proximityPromptService.PromptButtonHoldBegan,function(f)
d(f)
end)
end
},
{
action="uninstantproximityprompts|uninstantpp",
description="Disables instant proximity prompts",
run=function(c)
local d=c:collectGarbage"instantpp"
if d and d.connection then
d.connection:Disconnect()
end
end
}
}end a.bR=function()local c=a.cache.bR if not c then c={c=b()}a.cache.bR=c end return c.c end end do local b=function()

local b=workspace.Gravity
local c=-500

return{
{
action="gravity|grav",
description="Sets the workspace gravity (no value resets it)",
args={kind="number",name="gravity",optional=true},
run=function(d,e)
workspace.Gravity=e:nextValue()or b
end
},
{
action="destroyheight|dh",
description="Sets the height where fallen parts get destroyed (default is -500)",
args={kind="number",name="height",optional=true},
run=function(d,e)
workspace.FallenPartsDestroyHeight=e:nextValue()or c
end
}
}end a.bS=function()local c=a.cache.bS if not c then c={c=b()}a.cache.bS=c end return c.c end end do local b=function()

return{
{
action="deleteinvisparts|deleteinvisibleparts|dip",
description="Deletes invisible collidable parts",
run=function()
for b,c in workspace:GetDescendants()do
if c:IsA"BasePart"and c.Transparency==1 and c.CanCollide then
c:Destroy()
end
end
end
},
{
action="removeterrain|rterrain|noterrain",
description="Clears all the terrain",
run=function()
local b=workspace:FindFirstChildOfClass"Terrain"
if b then
b:Clear()
end
end
}
}end a.bT=function()local c=a.cache.bT if not c then c={c=b()}a.cache.bT=c end return c.c end end do local b=function()local b=function(

b, c)
return c==""
or b.Name:lower()==c
or(b.Parent~=nil and b.Parent.Name:lower()==c)end local c=function(


c)
local d=c.Parent
if d==nil then
return nil
elseif d:IsA"Attachment"then
return d.WorldPosition
elseif d:IsA"BasePart"then
return d.Position
elseif d:IsA"Model"then
return d:GetPivot().Position
end
return nil end local d=function(


d)
local e=d.playerService:getRootPart()
if not e then
return nil
end

local f
local g=math.huge

for h,i in workspace:GetDescendants()do
if i:IsA"ProximityPrompt"and i.Enabled then
local j=c(i)
if not j then continue end

local k=(j-e.Position).Magnitude

if k<g then
f,g=i,k
end
end
end

return f end local e=function(


e, f)
local g=e.playerService:getRootPart()
local h=c(f)

if g and h then
g.CFrame=CFrame.new(h+Vector3.new(0,3,0))
end end


return{
{
action="fireclickdetectors|firecd",
description="Uses all click detectors in a game or uses the optional name",
args={
kind="object",
optional=true
},
run=function(f,g)
local h=f:expectExploit"fireclickdetector"
if not h then return end

local i=(g:nextValue()or""):lower()

for j,k in workspace:GetDescendants()do
if k:IsA"ClickDetector"and b(k,i)then
h(k)
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
run=function(f,g)
local h=f:expectExploit"fireproximityprompt"
if not h then return end

local i=(g:nextValue()or""):lower()

for j,k in workspace:GetDescendants()do
if k:IsA"ProximityPrompt"and b(k,i)then
h(k)
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
run=function(f,g)
local h=f:expectExploit"fireproximityprompt"
if not h then return end

local i=d(f)
if not i then
f:notify"Can't find any ProximityPrompt on workspace"
return
end

if g:nextValue()then
e(f,i)
task.wait(0.25)
end

h(i)
f:notify(`fired prompt: {i:GetFullName()}`)
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
}end a.bU=function()local c=a.cache.bU if not c then c={c=b()}a.cache.bU=c end return c.c end end do local b=function()
return{
{
action="tpunanchored|tpua",
description="Teleports unanchored parts to a player",
args={
kind="player"
}
},
{
action="animsunanchored|freezeua",
description="Freezes unanchored parts"
},
{
action="thawunanchored|thawua|unfreezeua",
description="Thaws unanchored parts"
}
}end a.bV=function()local c=a.cache.bV if not c then c={c=b()}a.cache.bV=c end return c.c end end do local b=function()

return{a.bM()
,a.bN()
,a.bO()
,a.bP()
,a.bQ()
,a.bR()
,a.bS()
,a.bT()
,a.bU()
,a.bV()

}end a.bW=function()local c=a.cache.bW if not c then c={c=b()}a.cache.bW=c end return c.c end end do local b=function()

return{
{
action="fullbright|fb",
description="Makes the map brighter / more visible (CLIENT)"
},
{
action="loopfullbright|loopfb",
description="Makes the map brighter / more visible but looped (CLIENT)"
},
{
action="unloopfullbright|unloopfb",
description="Unloops fullbright"
}
}end a.bX=function()local c=a.cache.bX if not c then c={c=b()}a.cache.bX=c end return c.c end end do local b=function()
return{
client=true,
action="ambient",
description="Changes ambient",
args={kind="color3"},
run=function(b,c)
local d=c:nextValue()
local e=b.robloxServices.Lighting

e.Ambient=d
e.OutdoorAmbient=d
end
}end a.bY=function()local c=a.cache.bY if not c then c={c=b()}a.cache.bY=c end return c.c end end do local b=function()

return{
{
client=true,
action="day",
description="Changes the time to day for the client",
run=function(b)
b.robloxServices.Lighting.ClockTime=14
end
},
{
client=true,
action="night",
description="Changes the time to night for the client",
run=function(b)
b.robloxServices.Lighting.ClockTime=0
end
}
}end a.bZ=function()local c=a.cache.bZ if not c then c={c=b()}a.cache.bZ=c end return c.c end end do local b=function()

return{
client=true,
action="nofog",
description="Removes fog",
run=function(b)
local c=b.robloxServices.Lighting
c.FogEnd=100000

for d,e in c:GetDescendants()do
if e:IsA"Atmosphere"then
e:Destroy()
end
end
end
}end a.b_=function()local c=a.cache.b_ if not c then c={c=b()}a.cache.b_=c end return c.c end end do local b=function()

return{
client=true,
action="brightness",
description="Changes the brightness lighting property",
args={kind="number"},
run=function(b,c)
b.robloxServices.Lighting.Brightness=c:nextValue()
end
}end a.b0=function()local c=a.cache.b0 if not c then c={c=b()}a.cache.b0=c end return c.c end end do local b=function()

return{
{
client=true,
action="globalshadows|gshadows",
description="Enables global shadows",
run=function(b)
b.robloxServices.Lighting.GlobalShadows=true
end
},
{
client=true,
action="noglobalshadows|nogshadows",
description="Disables global shadows",
run=function(b)
b.robloxServices.Lighting.GlobalShadows=false
end
}
}end a.b1=function()local c=a.cache.b1 if not c then c={c=b()}a.cache.b1=c end return c.c end end do local b=function()

return{
{
action="restorelighting|rlighting",
description="Restores Lighting properties"
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
}
},
{
action="nolight|unlight",
description="Removes dynamic light from your player"
}
}end a.b2=function()local c=a.cache.b2 if not c then c={c=b()}a.cache.b2=c end return c.c end end do local b=function()
return{a.bX()
,a.bY()
,a.bZ()
,a.b_()
,a.b0()
,a.b1()
,a.b2()

}end a.b3=function()local c=a.cache.b3 if not c then c={c=b()}a.cache.b3=c end return c.c end end do local b=function()
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
}
},
{
action="removealias",
description="Removes a custom alias",
args={kind="alias"}
},
{
action="clraliases",
description="Removes all custom aliases",
args={
kind="boolean",
name="confirm"
}
}
}end a.b4=function()local c=a.cache.b4 if not c then c={c=b()}a.cache.b4=c end return c.c end end do local b=function()
return{
{
action="addplugin|plugin",
description="Add a plugin via command",
args={
kind="string",
name="plugin name"
}
},
{
action="removeplugin|deleteplugin",
description="Remove a plugin via command",
args={kind="plugin"}
},
{
action="reloadplugin",
description="Reloads a plugin",
args={kind="plugin"}
},
{
action="addallplugins|loadallplugins",
description="Adds all available plugins from the workspace folder"
}
}end a.b5=function()local c=a.cache.b5 if not c then c={c=b()}a.cache.b5=c end return c.c end end do local b=function()
local b=a.d()local c=function(


c)
local d={}
local e={}
local f={}local g=function(

g)
b:expect(g.action,{"string"},"command action")
table.insert(d,g)

local h={}
local i=g.args or{}
g.args=i

for j,k in g.action:split"|"do
if not g.name then
g.name=k
end

e[k]=g

table.insert(h,k)
table.insert(f,k)
end

table.sort(h,function(j,k)
return#j<#k
end)

if#i==0 and next(i)then
g.args={i}
end

g.aliases=h
g.action=nil end


for h,i in c do
b:expect(i.name,{"string"},"section name")
b:expect(i.commands,{"table"},"section commands")

table.insert(d,{
isSection=true,
sectionName=i.name
})

for j,k in i.commands do
if#k==0 then
b:assert(next(k),"the command cannot be empty")
g(k)
continue
end

for l=1,#k do
g(k[l])
end
end
end

return{
array=f,
lookup=e,
original=d
}end


return c{
{
name="general",
commands=a.as()
},
{
name="character",
commands=a.a1()
},
{
name="waypoints",
commands=a.a2()
},
{
name="teleport",
commands=a.bm()
},
{
name="communication",
commands=a.bu()
},
{
name="visual",
commands=a.bz()
},
{
name="camera",
commands=a.bL()
},
{
name="workspace",
commands=a.bW()
},
{
name="lighting",
commands=a.b3()
},
{
name="aliases",
commands=a.b4()
},
{
name="plugins",
commands=a.b5()
}
}end a.b6=function()local c=a.cache.b6 if not c then c={c=b()}a.cache.b6=c end return c.c end end do local b=function()

































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































local b={}
local c={}

b.__index=b
c.__index=c

b.Disconnect=function(d)
if not d._isConnected then return end

local e=d.Parent and d.Parent.Connections
local f=e and table.find(e,d)

if f then
table.remove(e,f)
end

d._connectedFunc=nil
d._isConnected=false end


b.Fire=function(d, ...)
if d._connectedFunc~=nil then
task.spawn(d._connectedFunc,...)
end end


b.new=function(d, e)
local f=setmetatable({
_isConnected=true,
_connectedFunc=e,
Parent=d
},b)

table.insert(d.Connections,f)
return f end


c.Connect=function(d, e)
assert(type(e)=="function",`function expected, got {type(e)}`)

return b.new(d,e)end


c.Once=function(d, e)
local f

f=d:Connect(function(...)
f:Disconnect()
task.spawn(e,...)
end)

return f end


c.Wait=function(d)
local e,f=(coroutine.running())

f=d:Connect(function(...)
f:Disconnect()
task.spawn(e,...)
end)

return coroutine.yield()end


c.Fire=function(d, ...)
for e,f in ipairs(d.Connections)do
f:Fire(...)
end end


c.new=function()
return setmetatable({
Connections={}
},c)end


return c end a.b7=function()local c=a.cache.b7 if not c then c={c=b()}a.cache.b7=c end return c.c end end do local b=function()
return a.j().new"createdWaypoints"end a.b8=function()local c=a.cache.b8 if not c then c={c=b()}a.cache.b8=c end return c.c end end do local b=function()
return a.j().new"installedPlugins"end a.b9=function()local c=a.cache.b9 if not c then c={c=b()}a.cache.b9=c end return c.c end end do local b=function()
return a.j().new(".userData",{
encrypt=true
})end a.ca=function()local c=a.cache.ca if not c then c={c=b()}a.cache.ca=c end return c.c end end do local b=function()
return a.j().new"aliases"end a.cb=function()local c=a.cache.cb if not c then c={c=b()}a.cache.cb=c end return c.c end end do local b=function()
return a.j().new"totalUsedCommands"end a.cc=function()local c=a.cache.cc if not c then c={c=b()}a.cache.cc=c end return c.c end end do local b=function()
return{
waypoints=a.b8(),
plugins=a.b9(),
settings=a.k(),
user=a.ca(),
aliases=a.cb(),
usedCmds=a.cc()
}end a.cd=function()local c=a.cache.cd if not c then c={c=b()}a.cache.cd=c end return c.c end end do local b=function()
local b={}


b.searchAtArray=function(c, 
d, 
e, 
f)

if e==""then return{}end

local g=e:lower()
local h={}
local i={}

for j,k in d do
local l=tostring(k):lower()

if#l<#g then continue end

local m=l:find(g,1,true)

if m==1 then
table.insert(h,k)
elseif m and not f then
table.insert(i,k)
end
end

for j,k in i do
table.insert(h,k)
end

return h end


return b end a.ce=function()local c=a.cache.ce if not c then c={c=b()}a.cache.ce=c end return c.c end end do local b=function()

local b={
connections={}
}

local c=a.b()
c.connectionService=b

b.cleanup=function(d)
for e,f in ipairs(d.connections)do
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


return b end a.cf=function()local c=a.cache.cf if not c then c={c=b()}a.cache.cf=c end return c.c end end do local b=function()
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


return b end a.cg=function()local c=a.cache.cg if not c then c={c=b()}a.cache.cg=c end return c.c end end do local b=function()
local b={}

return b end a.ch=function()local c=a.cache.ch if not c then c={c=b()}a.cache.ch=c end return c.c end end do local b=function()
local b=a.ch()
local c=a.d()

local d={}

d.setProperties=function(e, f)
for g,h in f do
if b[g]then
b[g](e,h)
continue
end


if type(g)=="number"and typeof(h)=="Instance"then
h.Parent=e
continue
end

e[g]=h
end
return e end


d.setup=function(e, ...)
for f,g in{...}do
local h=typeof(g)

if h=="table"then
d.setProperties(e,g)
else
local i=if h=="string"then"Name"else"Parent"
e[i]=g
end
end
return e end


d.new=function(e, ...)
local f=Instance.new(e)
return d.setup(f,...)end


return d end a.ci=function()local c=a.cache.ci if not c then c={c=b()}a.cache.ci=c end return c.c end end do local b=function()
local b=a.m()
local c=a.d()

local d="https://raw.githubusercontent.com/%s/%s/refs/heads/main/"
d=d:format(b.owner,b.repository)

local e={}local f=function(

f)
return game:HttpGet(f)end


e.fetch=function(g)
if g:sub(1,1)=="/"then
g=g:sub(2)
end

local h,i=pcall(f,d..g)

if not h then
c:warn(`failed to fetch http url '{g}':\n\t{i}`)
return
end

return i end


return e end a.cj=function()local c=a.cache.cj if not c then c={c=b()}a.cache.cj=c end return c.c end end do local b=function()
local b=a.g()
local c=b.CoreGui

local d={}
d.__index=d

d.destroy=function(e)
e.message:destroy()
setmetatable(e,nil)end


d.set=function(e, f)
if f and#f>0 then
e.message.Text=f
e.message.Parent=c
else
e.message.Parent=nil
end end


d.new=function()
return setmetatable({
message=Instance.new"Message"
},d)end


return d end a.ck=function()local c=a.cache.ck if not c then c={c=b()}a.cache.ck=c end return c.c end end do local b=function()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cl=function()local c=a.cache.cl if not c then c={c=b()}a.cache.cl=c end return c.c end end do local b=function()
local b=a.cl()

local c={}

c.getScale=function(d, e)
return b.isEnabled and(e*b.animationScale)or 0 end


c.getScrollSpeed=function(d, e)
return(e*b.scrollSpeed)end


return c end a.cm=function()local c=a.cache.cm if not c then c={c=b()}a.cache.cm=c end return c.c end end do local b=function()
return{
createService=a.ci(),
specialProps=a.ch(),

connectionService=a.cf(),
fetchService=a.cj(),
localPlayer=a.ac(),
messageService=a.ck(),
playerService=a.ad(),
rbxServices=a.g(),
tweenService=a.cm(),
}end a.cn=function()local c=a.cache.cn if not c then c={c=b()}a.cache.cn=c end return c.c end end do local b=function()
return{
DisplayName="Classic",

FirstShade=Color3.fromRGB(36,36,37),
SecondShade=Color3.fromRGB(46,46,47),
ThirdShade=Color3.fromRGB(78,78,79),

DefaultText=Color3.new(1,1,1),
DarkText=Color3.new(0,0,0),

ScrollBar=Color3.fromRGB(78,78,79)
}end a.co=function()local c=a.cache.co if not c then c={c=b()}a.cache.co=c end return c.c end end do local b=function()
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
}end a.cp=function()local c=a.cache.cp if not c then c={c=b()}a.cache.cp=c end return c.c end end do local b=function()
return{
DisplayName="Light"
}end a.cq=function()local c=a.cache.cq if not c then c={c=b()}a.cache.cq=c end return c.c end end do local b=function()
local b={a.co()
,a.cp()
,a.cq()

}

local c={}

for d,e in b do
local f=string.lower(e.DisplayName)
c[f]=e
end

return c end a.cr=function()local c=a.cache.cr if not c then c={c=b()}a.cache.cr=c end return c.c end end do local b=function()
local b={}

local c="abcdefghijklmnopqrstuvABCDEFGHIJKLMNOPQRSTUV_0123456789"

local d={
["&"]="&amp;",
["<"]="&lt;",
[">"]="&gt;",
["\""]="&quot;",
["'"]="&apos;"
}

b.randomString=function(e)
local f={}
for g=1,e do
local h=math.random(1,#c)
table.insert(f,c:sub(h,h))
end
return table.concat(f)end


b.getDeep=function(e, f)
for g in f:gmatch"[^%.]+"do
e=e[g]
end
return e end


b.simpleCreate=function(e, f)
local g=Instance.new(e)
for h,i in f do
g[h]=i
end
return g end


b.chararray=function(e)
local f={}
for g=1,#e do
table.insert(f,e:sub(g,g))
end
return f end


b.lookupify=function(e)
local f={}
for g=1,#e do
local h=e[g]
f[h]=true
end
return f end


b.unlookupify=function(e)
local f={}
for g,h in e do
table.insert(f,g)
end
return f end


b.escapeRichText=function(e)
local f=tostring(e):gsub(".",function(f)
return d[f]or f
end)
return f end


b.charset=function(e)
local f={}
for g in e:gmatch"."do
f[g]=true
end
return f end


b.versionToNumber=function(e)
local f=e:gsub("^v","")

local g=0
local h=f:split"."

for i,j in h do
local k=tonumber(j)or 0
g=g+k*math.pow(1000,3-i)
end

return g end


b.colorFromRGB=function(e, f)
return`<font color="#{f:ToHex()}">{e}</font>`end


b.richFontSize=function(e, f)
return`<font size="{f}">{e}</font>`end


return b end a.cs=function()local c=a.cache.cs if not c then c={c=b()}a.cache.cs=c end return c.c end end do local b=function()
local b=a.cr()

local c=a.d()
local d=a.cs()

local e={
objects={},
selectedTheme=nil
}

e.selectTheme=function(f, g)
c:expect(g,{"string"},"'themeService:selectTheme' #1")

local h=b[g:lower()]

if not h then
c:error(`'{g}' isn't a valid theme`)
return
end

if h~=f.selectedTheme then
f.selectedTheme=h
f:updateObjects()
end

return f end


e.updateObject=function(f, g)

f:updateObjectProperties(g,f.objects[g])end


e.updateObjectProperties=function(f, 
g, 
h)

for i,j in h do
g[i]=d.getDeep(f.selectedTheme,j)
end end


e.updateObjects=function(f)
for g,h in f.objects do
f:updateObject(g)
end end


e.addObject=function(f, g, h)
f.objects[g]=h
f:updateObject(g)end



e.init=function(f, g)
c:expect(g,{"table"},"'themeService:init' #1")

if g.theme~=nil then
f:selectTheme(g.theme)
end end


return e end a.ct=function()local c=a.cache.ct if not c then c={c=b()}a.cache.ct=c end return c.c end end do local b=function()


local b=a.cn()
local c=a.d()

local d=b.specialProps
local e=a.ct()

d.ThemeTag=function(f, g)
if type(g)~="table"then
c:error"expected a 'table' when setting a theme tag"
return
end

e:addObject(f,g)end


return a.ci()end a.cu=function()local c=a.cache.cu if not c then c={c=b()}a.cache.cu=c end return c.c end end do local b=function()return{bindsandplugins="rbxassetid://5147695474",close="rbxassetid://5054663650",editaliases="rbxassetid://5147488658",editkeybinds="rbxassetid://129697930",edittheme="rbxassetid://4911962991",editwaypoints="rbxassetid://5147488592",imgstudiopluginlogo="rbxassetid://4113050383",logo="rbxassetid://1352543873",minimize="rbxassetid://2406617031",pin="rbxassetid://6234691350",reference="rbxassetid://3523243755",settings="rbxassetid://1204397029",}end a.cv=function()local c=a.cache.cv if not c then c={c=b()}a.cache.cv=c end return c.c end end do local b=function()local b=a.a()
local c=a.o()

local d=c.storage.imagePath

local e=a.j()
local f=a.cj()
local g=a.d()

local h=a.cv()

local i={}
local j={}

local k=b.getcustomasset

local l={}

l.newCustomAsset=function(m, n, o)
g:assert(not i[n],"asset is already loaded")

local p=e:getCustomAsset(o)

if p==nil then
p=h[n]
i[n]=p
return p
end

g:log(`new custom asset to '{o}': '{p}'`)
return p end


l.get=function(m, n)
if i[n]then
return i[n]
end

if type(k)~="function"then
return h[n]
end

local o=d:format(n)
g:log(`loading asset: '{o}'`)

if e:exist(o)then
return m:newCustomAsset(n,o)
end

local p=f.fetch(o)

if p==nil then
local q=h[n]
i[n]=q
return q
end

e:writeFile(o,p)
g:log(`created a file to asset: '{o}'`)

return m:newCustomAsset(n,o)end


l.loadImage=function(m, n, o)
g:assert(h[o],`invalid asset name: {o}`)

local p=i[o]
if p~=nil then
n.Image=p
return
end

n.Image=""

if j[o]then
table.insert(j[o],n)
return
end

j[o]={n}

task.defer(function()
local q=m:get(o)
if not q then return end

for r,s in j[o]do
s.Image=q
end

j[o]=nil
end)end


return l end a.cw=function()local c=a.cache.cw if not c then c={c=b()}a.cache.cw=c end return c.c end end do local b=function()



return{

defaultTime=5,
defaultTitle="Notification",


size=UDim2.fromOffset(250,100),
cornerRadius=6,
titleHeight=20,
iconSize=15,


titleTextSize=16,
textSize=14,
padding=8,


spacing=4,
gapToWindow=0,
maxVisible=5,


tweenTime=0.5,
flashTime=0.5,
}end a.cx=function()local c=a.cache.cx if not c then c={c=b()}a.cache.cx=c end return c.c end end do local b=function()



local b=a.cu()
local c=a.cw()
local d=a.cf()
local e=a.g()
local f=a.ct()
local g=a.cx()
local h=a.d()

local i={
container=nil,

items={},
nextOrder=0,

queue={},
}local j=function(

j, k)
local l=b.new("Frame","Notification",j,{
BorderSizePixel=0,
ClipsDescendants=true,
LayoutOrder=k,
Size=UDim2.fromOffset(g.size.X.Offset,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local m=b.new("TextLabel","Title",l,{
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,g.titleHeight),
Text="",
TextSize=g.titleTextSize,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local n=b.new("TextLabel","Text",l,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(g.padding,g.titleHeight+g.padding),
Size=UDim2.new(1,-g.padding*2,1,-(g.titleHeight+g.padding*2)),
Text="",
TextSize=g.textSize,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local o=b.new("ImageButton","PinButton",l,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,2,0,g.titleHeight/2),
Size=UDim2.fromOffset(g.iconSize,g.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local p=b.new("ImageButton","CloseButton",l,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-2,0,g.titleHeight/2),
Size=UDim2.fromOffset(g.iconSize,g.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

c:loadImage(o,"pin")
c:loadImage(p,"close")

return l,m,n,o,p end


i.getContainer=function(k, l)
if k.container then
return k.container
end

local m=b.new("Frame","Notifications",l,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(g.size.X.Offset,0),
})

b.new("UIListLayout",m,{
Padding=UDim.new(0,g.spacing),
SortOrder=Enum.SortOrder.LayoutOrder,
})

k.container=m

local n=k.queue
k.queue={}

for o,p in n do
k:add(p.title,p.message,p.duration)
end

return m end


i.tweenHeight=function(k, l, m)
if l.tween then
l.tween:Cancel()
end

local n=TweenInfo.new(g.tweenTime,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
l.tween=e.TweenService:Create(l.frame,n,{
Size=UDim2.fromOffset(g.size.X.Offset,m),
})
l.tween:Play()end


i.pin=function(k, l)
if l.pinned or l.removed then return end
l.pinned=true

l.titleLabel.Text=l.title.." (Pinned)"
f:addObject(l.pinButton,{ImageColor3="Colors.Primary"})

local m=l.titleLabel
task.spawn(function()
m.TextTransparency=0.5
task.wait(g.flashTime)
m.TextTransparency=0
end)end


i.remove=function(k, l)
if l.removed then return end
l.removed=true

for m,n in k.items do
if n==l then
table.remove(k.items,m)
break
end
end

k:tweenHeight(l,0)
task.delay(g.tweenTime,function()
l.frame:Destroy()
end)end


i.add=function(k, l, m, n)
k.nextOrder=k.nextOrder+1

local o={title=tostring(l),pinned=false,removed=false}
o.frame,o.titleLabel,o.textLabel,o.pinButton,o.closeButton=
j(k.container,k.nextOrder)

o.titleLabel.Text=o.title
o.textLabel.Text=tostring(m)

d:Connect(o.pinButton.Activated,function()
k:pin(o)
end)

d:Connect(o.closeButton.Activated,function()
k:remove(o)
end)

table.insert(k.items,o)
k:tweenHeight(o,g.size.Y.Offset)

local p=g.defaultTime
if type(n)=="number"then
p=n
end

task.delay(p,function()
if not o.pinned then
k:remove(o)
end
end)

while#k.items>g.maxVisible do
k:remove(k.items[1])
end end


i.notify=function(k, l, m, n)
h:expect(l,{"string"},"'notifier:notify' #1")

if m==nil then
m=l
l=g.defaultTitle
end

if not k.container then
table.insert(k.queue,{title=l,message=m,duration=n})
return
end

k:add(l,m,n)end


return i end a.cy=function()local c=a.cache.cy if not c then c={c=b()}a.cache.cy=c end return c.c end end do local b=function()



local b=a.b()
local c=a.d()

local d={

_callbacks={},
_nextId=0,
}local e=function(


e)
while true do
task.wait()

if next(e._callbacks)==nil then
b.loopThread=nil
return
end

local f=os.clock()

for g,h in e._callbacks do
if f-h.lastCall>=h.cooldown then
h.lastCall=f
task.defer(h.func)
end
end
end end



d.start=function(f)
if b.loopThread~=nil then
return
end

b.loopThread=task.defer(e,f)end



d.stop=function(f)
local g=b.loopThread
b.loopThread=nil
table.clear(f._callbacks)

if g~=nil then
task.cancel(g)
end end




d.add=function(f, g, h)
c:expect(g,{"function"},"'loopService:add' #1")
c:expect(h,{"number","nil"},"'loopService:add' #2")

f._nextId=f._nextId+1
local i=f._nextId

f._callbacks[i]={
func=g,
cooldown=math.max(h or 0,0),
lastCall=-math.huge
}

f:start()
return i end



d.remove=function(f, g)
c:expect(g,{"number"},"'loopService:remove' #1")
f._callbacks[g]=nil end


return d end a.cz=function()local c=a.cache.cz if not c then c={c=b()}a.cache.cz=c end return c.c end end do local b=function()
local b=a.b()
local c=a.a()

local d=a.b6()
local e=a.b7()
local f=a.d()

local g=a.cd().usedCmds
local h=a.g()
local i=a.o()

local j=a.ce()

local k=i.commands.cmdsRank
local l=k.maxTimesUsed
local m=k.decreasePerUse
local n=k.increasePerUse

local o=b.iyGarbages or{}
b.iyGarbages=o

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
local s=g:getValue(r)or 0

local t=math.clamp(s+n,0,l)
g:setValue(r,t)

for u,v in g:getData()do
if u==r then continue end

local w=(t==l)

if(w or v<t)and v>0 then
v=v-m

if v==0 then v=nil end
g:setValue(u,v)
end
end

g:save()end


p.run=function(q, r, s)
f:expect(r,{"string"},"'commandsController:run' #1")
f:expect(s,{"table","nil"},"'commandsController:run' #2")

local t=d.lookup[r]
f:assert(t,"invalid command")

q:commandUsed(t.name)

if t.run~=nil then
t.run(q,s)
return
end

f:warn(`missing command run func: {t.name}`)end local q=function(


q)
local r=d.lookup[q:lower()]
if r==nil then return 0 end


return g:getValue(r.name)or 0 end


p.search=function(r, s, t)
local u=j:searchAtArray(d.array,s,t)
local v=s:lower()
local w={}

for x,y in u do
table.insert(w,{
alias=y,
index=x,
isPrefix=y:lower():sub(1,#v)==v,
usage=q(y),
})
end

table.sort(w,function(x,y)
if x.isPrefix~=y.isPrefix then return x.isPrefix end
if x.usage~=y.usage then return x.usage>y.usage end
return x.index<y.index
end)

local x={}
for y,z in w do
x[y]=z.alias
end

return x end


p.init=function(r, s)
f:assert(s,"'commandsController:init' #1 expected a config to init")

local t=a.cf()
local u=a.cg()
local v=a.cy()


r.notify=function(w, ...)
return v:notify(...)end


r.stringify=function(w, ...)
return u:stringify(...)end


r.unstringify=function(w, ...)
return u:unstringify(...)end


r.connect=function(w, ...)
return t:Connect(...)end


r.expectExploit=function(w, x)
local y=c[x]
if y~=nil then return y end

w:notify("Incompatible Exploit",`Your exploit does not support this command (missing {x})`)end


r.getRoot=function(w)
local x=w.playerService:getRootPart()
if x then return x end

w:notify(TITLE,"your character is not loaded")end



r.localPlayer=a.ac()
r.executorEnv=c
r.privateEnv=b


r.infiniteYield=s.infiniteYield
r.playerService=s.playerService
r.fetchService=s.fetchService


r.signals={
onCameraReset=e.new()
}


r.config={
links=i.links
}


r.userSettings=UserSettings()
r.gameSettings=settings()

r.userGameSettings=r.userSettings:GetService"UserGameSettings"
r.gameNetworkSettings=r.gameSettings:GetService"NetworkSettings"


r.loopService=a.cz()


r.storage=a.cd()


r.robloxServices=h
r.rbxServices=h

r.teleportService=h.TeleportService
r.groupService=h.GroupService
r.runService=h.RunService
r.starterGui=h.StarterGui
r.coreGui=h.CoreGui
r.players=h.Players
r.guiService=h.GuiService
r.networkClient=h.NetworkClient
r.proximityPromptService=h.ProximityPromptService end


return p end a.cA=function()local c=a.cache.cA if not c then c={c=b()}a.cache.cA=c end return c.c end end do local b=function()



local b=a.b6()local c=function()


local c={}
local d="unknown"

for e,f in b.original do
if f.isSection then
d=f.sectionName
elseif f.run==nil then
table.insert(c,{section=d,name=f.name})
end
end

return c end


return function(d)
local e=c()
if#e==0 then
return
end

local f={}
local g={}

for h,i in e do
if not f[i.section]then
f[i.section]={}
table.insert(g,i.section)
end
table.insert(f[i.section],i.name)
end

local h={}
for i,j in g do
local k=table.concat(f[j],", ")
table.insert(h,`[{j}] {k}`)
end

local i=table.concat(h,"\n")

d:notify("Commands without run",`{#e} command(s) still need a run function, see console`)
end end a.cB=function()local c=a.cache.cB if not c then c={c=b()}a.cache.cB=c end return c.c end end do local b=function()
local b=a.cf()
local c=a.g()

local d=a.b7()

local e=c.UserInputService

local f={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}

local g={
[Enum.UserInputType.MouseMovement]=true,
[Enum.UserInputType.Touch]=true
}

local h=0.28

local i={}
i.__index=i

i.addGuiObject=function(j, k)
local l local m=function()


j.isDragging=false
j.draggingObject=nil
j.dragStart=nil
j.startPos=nil

if l then
l:Disconnect()
end

j.dragEnded:Fire(k)end local n=function()



while j.draggingObject==k do
if(tick()-j.lastActivity)>=1 then
m()
end
task.wait()
end end


b:Connect(k.InputBegan,function(o)
if not f[o.UserInputType]then return end
if j.isDragging then return end

j.dragStart=o.Position
j.startPos=k.Position

j.isDragging=true
j.draggingObject=k
j.lastActivity=tick()

j.dragStarted:Fire(k)

task.spawn(n)

l=o.Changed:Connect(function()
if o.UserInputState==Enum.UserInputState.End then
m()
end
end)
end)end


i.update=function(j, k, l)
local m=l.Position-j.dragStart
local n=(j._uiScale and j._uiScale.Scale)or 1
local o=k.Position

j.lastActivity=tick()

local p=UDim2.new(
j.startPos.X.Scale,
j.startPos.X.Offset+(m.X/n),
j.startPos.Y.Scale,
j.startPos.Y.Offset+(m.Y/n)
)

if j.filters[k]~=nil then
local q=j.filters[k](p,n)
p=q or p
end

k.Position=o:Lerp(p,h)end


i.canDragObject=function(j, k)
return(not j.isDragging)or(j.draggingObject==k)end


i.setFilter=function(j, 
k, 
l)

j.filters[k]=l end


i.new=function(j)
local k=setmetatable({
isDragging=false,
draggingObject=nil,
_uiScale=j,
dragStart=nil,
startPos=nil,
filters={},

dragStarted=d.new(),
dragEnded=d.new(),
},i)

b:Connect(e.InputChanged,function(l)
if k.isDragging and g[l.UserInputType]then
k:update(k.draggingObject,l)
end
end)

return k end


return i end a.cC=function()local c=a.cache.cC if not c then c={c=b()}a.cache.cC=c end return c.c end end do local b=function()
local b=a.g()
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


return d()end a.cD=function()local c=a.cache.cD if not c then c={c=b()}a.cache.cD=c end return c.c end end do local b=function()
return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.cE=function()local c=a.cache.cE if not c then c={c=b()}a.cache.cE=c end return c.c end end do local b=function()



local b={}

local c=a.o()
local d=a.cE()

b.getEasterDate=function()
local e=tonumber(os.date"%Y")

local f=math.floor(e/100)
local g=math.floor((13+8*f)/25)
local h=(15-g+f-math.floor(f/4))%30
local i=(4+f-math.floor(f/4))%7

local j=(19*(e%19)+h)%30
local k=(2*(e%4)+4*(e%7)+6*j+i)%7
local l=22+j+k

if j==29 and k==6 then
return"04 19"
elseif j==28 and k==6 then
return"04 18"
end

if l>31 then
return string.format("04 %02d",l-31)
end

return string.format("03 %02d",l)end


b.getHolidayEmoji=function()
local e=b.getEasterDate()

local f={
["01 01"]=d.NEW_YEAR,
["02 14"]=d.VALENTINE_DAYS,
["03 17"]=d.CLOVER,
["10 31"]=d.HALLOWEEN,
["12 25"]=d.CHRISTMAS,
[e]=d.EASTER
}

local g=os.date"%m %d"
return f[g]end


b.getDisplayName=function()
local e=c.applicationName
local f=c.version

e=string.gsub(e,"!VERSION",f)

local g=b.getHolidayEmoji()

if g then
e=`{g} {e} {g}`
end

return e end


return b end a.cF=function()local c=a.cache.cF if not c then c={c=b()}a.cache.cF=c end return c.c end end do local b=function()
return{
uiScale=Instance.new"UIScale",
getScale=function(b)
local c=b.uiScale
return c and(c:GetAttribute"REAL_SCALE"or c.Scale)or 1
end,
setScale=function(b,c)
local d=b.uiScale

if d then
d.Scale=c
d:SetAttribute("REAL_SCALE",c)
end
end
}end a.cG=function()local c=a.cache.cG if not c then c={c=b()}a.cache.cG=c end return c.c end end do local b=function()


local b=a.cu()

local c={}

c.create=function(d)
local e=b.new("Frame","MainFrame",{
Active=true,
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Background"
},
b.new("Frame","TopBar",{
Size=UDim2.fromOffset(250,20),
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Background"
}
})
})

local f=e.TopBar

local g=b.new("TextLabel","Title",f,{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
TextSize=16,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.Normal"
}
})

local h=b.new("ImageButton",f,{
Name="SettingsButton",
BackgroundTransparency=1,
Position=UDim2.new(1,-2,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Size=UDim2.fromOffset(19,19),
ThemeTag={
ImageColor3="Colors.Icons"
}
})

local i=b.new("ImageButton",f,{
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
mainFrame=e,
topBar=f,
titleLabel=g,
buttons={
settings=h,
reference=i
}
}end


return c end a.cH=function()local c=a.cache.cH if not c then c={c=b()}a.cache.cH=c end return c.c end end do local b=function()

local b=a.cu()

local c={up=
function(c,d)
local e=1/c
local f=d/c

local g=UDim2.fromScale(f,e)
local h=UDim2.fromScale(
0.5-(f/2),
(d-1)*e
)
return g,h
end,down=
function(c,d)
local e=1/c
local f=d/c

local g=UDim2.fromScale(f,e)
local h=UDim2.fromScale(
0.5-(f/2),
1-(d*e)
)
return g,h
end,left=
function(c,d)
local e=1/c
local f=d/c

local g=UDim2.fromScale(e,f)
local h=UDim2.fromScale(
(d-1)*e,
0.5-(f/2)
)
return g,h
end,right=
function(c,d)
local e=1/c
local f=d/c

local g=UDim2.fromScale(e,f)
local h=UDim2.fromScale(
1-(d*e),
0.5-(f/2)
)
return g,h
end
}

return function(d,e,f)
local g=c[f]
if not g then
error("r u ok? Invalid direction: "..tostring(f))
end

local h=b.new("Frame","Arrow",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
AnchorPoint=Vector2.new(0.5,0.5),
Position=UDim2.fromScale(0.5,0.5),
b.new("UIScale",{
Scale=e
})
})

for i=1,d do
local j,k=g(d,i)

b.new("Frame",`line_{i}`,{
BackgroundColor3=Color3.fromRGB(220,220,220),
BorderSizePixel=0,
Size=j,
Position=k,
Parent=h,
ThemeTag={
BackgroundColor3="Colors.Icons"
}
})
end

return h
end end a.cI=function()local c=a.cache.cI if not c then c={c=b()}a.cache.cI=c end return c.c end end do local b=function()
return{
pressingInputs={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}
}end a.cJ=function()local c=a.cache.cJ if not c then c={c=b()}a.cache.cJ=c end return c.c end end do local b=function()
local b=a.cf()
local c=a.g()
local d=a.cu()
local e=a.ad()
local f=a.ct()

local g=a.cI()
local h=a.cG()

local i=a.b7()

local j=a.cJ()

local k=c.UserInputService

local l={}
l.__index=l local m=function(

m)
return j.pressingInputs[m.UserInputType]~=nil end


l.awake=function(n)
local o=e:getMouse()

local p=n.scrollThumbFrame
local q=n.scrollThumb
local r=n.scrollBar

local s=false
local t=false
local u local v=function(

v, w)local x=function()

if s then return end
if not n:canScroll(w)then return end

s=true

n:scrollToDirection(w)

local x
x=b:Connect(k.InputEnded,function(y)
if not m(y)then return end

x:Disconnect()
s=false
end)

task.wait(0.4)

while n:canScroll(w)and s do
n:scrollToDirection(w)
task.wait(6.666666666666666E-2)
end end


b:Connect(v.MouseButton1Down,x)end




v(n.upButton,"up")
v(n.downButton,"down")

b:Connect(r.MouseWheelForward,function()
n:scrollTo(n.index-n.wheelIncrement)
end)

b:Connect(r.MouseWheelBackward,function()
n:scrollTo(n.index+n.wheelIncrement)
end)

b:Connect(r.InputBegan,function(w)
if not m(w)then return end
if n:isScrollBarDisabled()then return end

local x=not e:isMouseInGuiObject(q)
local y=n.isHorizontal and"X"or"Y"

local z
t=true

f:updateObjectProperties(q,{
BackgroundColor3="Colors.Primary"
})

local A=o[y]-q.AbsolutePosition[y]
local B
local C local D=function()


if B then B:Disconnect()end
if C then C:Disconnect()end end


B=b:Connect(k.InputEnded,function(E)
if not m(E)then return end

D()
t=false

f:updateObjectProperties(q,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if x then local E=function()

local E=(o[y]>=q.AbsolutePosition[y]+q.AbsoluteSize[y])and 1 or 0
local F=n.visibleSpace-1

if E==0 and(
o[y]<q.AbsolutePosition[y]
)then
n:scrollTo(n.index-F)
elseif E==1 and(
o[y]>=q.AbsolutePosition[y]+q.AbsoluteSize[y]
)then
n:scrollTo(n.index+F)
end end


while t do
E()
task.wait(0.25)
end
return
end

C=b:Connect(k.InputChanged,function(E)
if not t then return end
if not m(E)then return end

local F=p.AbsoluteSize[y]-q.AbsoluteSize[y]
local G=o[y]-p.AbsolutePosition[y]-A

if G>F then
G=F
elseif G<0 then
G=0
end

if z~=G then
z=G
n:scrollTo(math.floor(0.5+G/F*(n.totalSpace-n.visibleSpace)))
end
end)
end)end


l.create=function(n)
n.upButton=d.new("ImageButton",n.upButtonName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

n.downButton=d.new("ImageButton",n.downButtoName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

n:createButtonsArrows()

local o=d.new("Frame","ScrollBar",{
Active=true,
BackgroundTransparency=1,

n.upButton,
n.downButton,

d.new("Frame","ScrollThumbFrame",{
BackgroundTransparency=1,
AnchorPoint=n.isHorizontal
and Vector2.new(0.5,0)
or Vector2.new(0,0.5),
Position=n.isHorizontal
and UDim2.fromScale(0.5,0)
or UDim2.fromScale(0,0.5),

d.new("Frame","ScrollThumb",{
AnchorPoint=n.isHorizontal
and Vector2.new(0,0.5)
or Vector2.new(0.5,0),
ThemeTag={
BackgroundColor3="Colors.OnPrimary"
},

d.new("UICorner",{
CornerRadius=UDim.new(0,4),
}),
}),

d.new("Frame","MarkerFrame",{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
}),
}),
})

n.scrollBar=o
n.scrollThumbFrame=o.ScrollThumbFrame
n.scrollThumb=o.ScrollThumbFrame.ScrollThumb
n.markerFrame=o.ScrollThumbFrame.MarkerFrame

n.container=d.new("Frame","Container",{
BackgroundTransparency=1,
ClipsDescendants=true,
Active=true
})

n:setScrollBarThickness(n.barThickness)
n:awake()
n:update()


return o end


l.createButtonsArrows=function(n)
local o=n.downButton
local p=n.upButton

g(4,0.55,o.Name).Parent=o
g(4,0.55,p.Name).Parent=p end


l.canScrollUp=function(n)
return n:isScrollBarEnabled()and n.index>0 end


l.canScrollDown=function(n)
local o=n:isScrollBarEnabled()
return o and n.index+n.visibleSpace<n.totalSpace end


l.canScroll=function(n, o)
if o=="up"or o=="left"then
return n:canScrollUp()
elseif o=="down"or o=="right"then
return n:canScrollDown()
end
return false end


l.getScrollPercent=function(n)
local o=n.totalSpace-n.visibleSpace
if o<=0 then return 0 end
return n.index/o end


l.scrollTo=function(n, o, p)
local q=math.max(0,n.totalSpace-n.visibleSpace)

n.index=math.clamp(o,0,q)
n:update()

if not p then
n.scrolledSignal:Fire(n.index)
end end


l.scrollUp=function(n)
n:scrollTo(n.index-n.increment)end


l.scrollDown=function(n)
n:scrollTo(n.index+n.increment)end


l.scrollToDirection=function(n, o)
if o=="up"or o=="left"then
return n:scrollUp()
elseif o=="down"or o=="right"then
return n:scrollDown()
end end


l.isVisible=function(n, o)
local p=n.index
if o>=p and o<(p+n.visibleSpace)then
return true
end
return false end


l.setScrollPercent=function(n, o)
local p=n.totalSpace-n.visibleSpace
n:scrollTo(math.floor(o*p))end


l.update=function(n)
n:drawThumb()end


l.setScrollBarThickness=function(n, o)
local p=n.scrollThumbFrame
local q=n.downButton
local r=n.container
local s=n.scrollBar
local t=n.upButton

n.barThickness=o

if r then
r.Size=UDim2.new(
1,
n.isHorizontal and 0 or-o,
1,
n.isHorizontal and-o or 0
)
end

if s then
s.Size=n.isHorizontal
and UDim2.new(1,0,0,o)
or UDim2.new(0,o,1,0)
s.Position=n.isHorizontal
and UDim2.new(0,0,1,-o)
or UDim2.new(1,-o,0,0)
end

if p then
p.Size=n.isHorizontal
and UDim2.new(1,-(o*2),0,o)
or UDim2.new(0,o,1,-(o*2))
end

if q then
q.Size=UDim2.fromOffset(o,o)
q.Position=n.isHorizontal
and UDim2.new(1,-o,0,0)
or UDim2.new(0,0,1,-o)
end

if t then
t.Size=UDim2.fromOffset(o,o)
t.Position=UDim2.fromOffset(0,0)
end end


l.updateArrowTransparency=function(n, o, p)
if not o:FindFirstChild"Arrow"then return end

for q,r in o.Arrow:GetChildren()do
if not r:IsA"GuiObject"then continue end
r.Transparency=p and 0.6 or 0
end end


l.drawThumb=function(n)
local o=n.scrollThumb
local p=n.scrollThumbFrame

local q=n:canScrollUp()
local r=n:canScrollDown()

n:updateArrowTransparency(n.upButton,not q)
n:updateArrowTransparency(n.downButton,not r)

if not o or not p then return end

if not q and not r then
o.Visible=false
return
end

o.Visible=true

local s=n:getScrollPercent()
local t=h:getScale()
local u=n.barThickness

if n.isHorizontal then
local v=p.AbsoluteSize.X/t
local w=math.max(u,(n.visibleSpace/n.totalSpace)*v)
o.Size=UDim2.new(0,w,1,-2)
o.Position=UDim2.new(0,s*(v-w),0.5,0)
else
local v=p.AbsoluteSize.Y/t
local w=math.max(u,(n.visibleSpace/n.totalSpace)*v)
o.Size=UDim2.new(1,-2,0,w)
o.Position=UDim2.new(0.5,0,0,s*(v-w))
end end


l.addMarker=function(n, o, p)
n.markers[o]=p or Color3.new(1,1,0)
n:updateMarkers()end


l.removeMarker=function(n, o)
n.markers[o]=nil
n:updateMarkers()end


l.updateMarkers=function(n)
local o=n.markerFrame
if not o then return end

for p,q in pairs(o:GetChildren())do
q:Destroy()
end

for p,q in pairs(n.markers)do
if p>=n.totalSpace then continue end

local r=Instance.new"Frame"
r.BackgroundColor3=q
r.BorderSizePixel=0
r.BackgroundTransparency=0
r.Parent=o

local s=p/n.totalSpace
if n.isHorizontal then
r.Position=UDim2.new(s,0,1,-4)
r.Size=UDim2.new(0,2,0,4)
else
r.Position=UDim2.new(1,-4,s,0)
r.Size=UDim2.new(0,4,0,2)
end

r.Name="Marker_"..tostring(p)
end end


l.setTotalSpace=function(n, o)
n.totalSpace=o
n:scrollTo(n.index,true)
n:update()end


l.setVisibleSpace=function(n, o)
n.visibleSpace=o
n:scrollTo(n.index,true)
n:update()end


l.disableScroll=function(n)
n.scrollBarEnabled=false
n:drawThumb()end


l.enableScroll=function(n)
n.scrollBarEnabled=true
n:drawThumb()end


l.isScrollBarEnabled=function(n)
return n.scrollBarEnabled end


l.isScrollBarDisabled=function(n)
return not n.scrollBarEnabled end


l.new=function(n)
local o=setmetatable({
isHorizontal=n.isHorizontal or false,
increment=n.increment or 1,
wheelIncrement=n.wheelIncrement or 3,
barThickness=n.barThickness or 16,

scrollBarEnabled=true,

index=0,
visibleSpace=n.visibleSpace or 0,
totalSpace=n.totalSpace or 0,

markers={},

scrollBar=n.scrollBar or nil,
scrollThumb=n.scrollThumb or nil,
scrollThumbFrame=n.scrollThumbFrame or nil,
markerFrame=n.markerFrame or nil,

scrolledSignal=i.new(),
},l)

o.upButtonName=o.isHorizontal and"left"or"up"
o.downButtoName=o.isHorizontal and"right"or"down"

return o end


return l end a.cK=function()local c=a.cache.cK if not c then c={c=b()}a.cache.cK=c end return c.c end end do local b=function()
local b={}
b.__index=b

b.new=function(c)
return setmetatable({
isClient=c.client or c.isClient or c.onlyClient,
isDeprecated=c.deprecated or c.isDeprecated,

name=c.name,
isSection=c.isSection,
sectionName=c.sectionName,
aliases=c.aliases,
args=c.args,
name=c.name,
description=c.description
},b)end


return b end a.cL=function()local c=a.cache.cL if not c then c={c=b()}a.cache.cL=c end return c.c end end do local b=function()
local b=Color3.fromRGB(248,109,115)
local c=Color3.fromRGB(223,215,136)
local d=Color3.fromRGB(156,121,223)
local e=Color3.fromRGB(225,37,105)
local f=Color3.fromRGB(118,113,94)
local g=Color3.fromRGB(97,181,195)
local h=Color3.fromRGB(254,193,7)
local i=Color3.fromRGB(244,66,54)
local j=Color3.fromRGB(166,227,45)

return{
args={number=
d,boolean=
d,text=
c,string=
c,symbol=
e,comment=
f,others=
g,warn=
h,error=
i,valid=
j
},
commands={undefined=
i,client=
c,deprecated=
f
}
}end a.cM=function()local c=a.cache.cM if not c then c={c=b()}a.cache.cM=c end return c.c end end do local b=function()
local b=a.g()
local c=a.ad()
local d=a.b6()
local e=a.b8()
local f=a.cb()
local g=a.b9()
local h=a.cs()

















local i={}local j=function(

j, k, l)
return{
success=false,
message=j,
options=k,
comment=l,
}end



i.normalizeOptions=function(k)
if type(k)=="string"then
return string.split(k,"|")
end
return k or{}end



i.getOptions=function(k, l)
local m=(l and l.options)or k.options
return i.normalizeOptions(m)end local k=function(



k, l)
local m=l:lower()

for n,o in k do
local p=tostring(o)
if p:lower()==m then
return p
end
end

return nil end local l=function(


l)
if type(l)~="table"then return{}end
return h.unlookupify(l)end local m=function(


m)
return{
success=true,
value=m,
color="string",
}end local n=function(


n, o)
local p=i.normalizeOptions(o.options)

if#p==0 then
return m(n)
end

local q=k(p,n)

if q then
return{success=true,value=q,color="string"}
end

return j(" - invalid option",p)end


local o={
["true"]=true,yes=
true,enabled=
true,
["false"]=false,no=
false,disabled=
false,
}local p=function(

p)
local q=o[p:lower()]

if q==nil then
return j(" - invalid boolean",{"false","true"})
end

return{
success=true,
value=q,
color="boolean",
}end local q=function(


q, r)
local s=tonumber(q)

if s==nil or s~=s or math.abs(s)==math.huge then
return j" - invalid number"
end

local t,u=r.min,r.max

if r.clamp then
t,u=r.clamp[1],r.clamp[2]
end

if t and s<t then
return j(` - the <b>MIN</b> is <b>{t}</b>`)
end

if u and s>u then
return j(` - the <b>MAX</b> is <b>{u}</b>`)
end

if r.floor and math.floor(s)~=s then
return j" - whole numbers only"
end


if tonumber(string.format("%.5f",s))~=s then
return j" - too many decimal places"
end

return{
success=true,
value=s,
display=`<b>{q}</b>`,
color="number",
}end local r=function(


r)
local s=r:split","

if#s>3 then
return j" - too many args"
end

local t={}

for u,v in s do

if v:match"^%s*$"then
v="0"
end

local w=q(v,{})

if not w.success then
return w
end

t[u]=w.value
end

if#t~=3 then
return{
success=false,
comment=true,
message=`: {({"X","Y","Z"})[#t+1]}`,
}
end

local u=Vector3.new(t[1],t[2],t[3])

return{
success=true,
value=u,
display=`({u})`,
color="others",
}end local s=function(


s)
local t=s:match"^#?(%x%x%x%x%x%x)$"

if t then
local u=tonumber(t:sub(1,2),16)
local v=tonumber(t:sub(3,4),16)
local w=tonumber(t:sub(5,6),16)

return{
success=true,
value=Color3.fromRGB(u,v,w),
color="others",
}
end

local u=s:split","

if#u~=3 then
return j" - use R,G,B or #hex"
end

local v={}

for w,x in u do
local y=q(x,{min=0,max=255,floor=true})

if not y.success then
return y
end

v[w]=y.value
end

return{
success=true,
value=Color3.fromRGB(v[1],v[2],v[3]),
color="others",
}end


local t={
me=true,
all=true,
others=true,
random=true,
}local u=function(

u)
if u==""then
return j" - player missing"
end

local v=u:lower()


if t[v]or v:match"^#%d+$"or v:match"^%%.+$"then
return{success=true,value=u,color="valid"}
end

if#c:getPlayersByName(u)>0 then
return{success=true,value=u,color="valid"}
end

local w={}
for x,y in b.Players:GetPlayers()do
table.insert(w,y.Name)
end

return j(" - player not found",w)end


local v={
"BasePart","Part","MeshPart","Model","Folder","Script","LocalScript",
"ModuleScript","Sound","Humanoid","Tool","ClickDetector",
"ProximityPrompt","TouchTransmitter","SpawnLocation","Seat","VehicleSeat",
}local w=function(

w)

local x=pcall(function()
local x=Instance.new(w)
x:Destroy()
end)

if x then
return{success=true,value=w,color="valid"}
end

return j(" - invalid class name",v)end local x=function(


x)

local y=l(e:getValue(tostring(game.PlaceId)))

if#y==0 then
return j" - no waypoints created"
end

local z=k(y,x)

if z then
return{success=true,value=z,color="valid"}
end

return j(" - invalid waypoint",y)end local y=function(


y)
local z={}

for A,B in b.Teams:GetTeams()do
table.insert(z,B.Name)
end

if#z==0 then
return j" - there are no teams"
end

local A=k(z,y)

if A then
return{success=true,value=A,color="valid"}
end

return j(" - invalid team",z)end local z=function(


z)
local A=z:lower()
local B={}
local C

for D,E in Enum.KeyCode:GetEnumItems()do
table.insert(B,E.Name)

if E.Name:lower()==A then
C=E
end
end

if C then
return{success=true,value=C,color="valid"}
end

return j(" - invalid key",B)end local A=function(


A)
local B=d.lookup[A:lower()]

if B then
return{success=true,value=B.name,color="valid"}
end

return j(" - invalid command",d.array)end local B=function(



B, C, D, E)
local F=l(B:getData())

if#F==0 then
return j(D)
end

local G=k(F,C)

if G then
return{success=true,value=G,color="valid"}
end

return j(E,F)end local C=function(


C)
return B(f,C," - no custom aliases"," - invalid alias")end local D=function(


D)
return B(g,D," - no plugins installed"," - invalid plugin")end


local E={
string=n,
text=n,
object=m,
boolean=p,
number=q,
vector3=r,
color3=s,
player=u,
waypoint=x,
className=w,
team=y,
keycode=z,
command=A,
alias=C,
plugin=D,
}

i.validate=function(F, G, H)
local I=E[G.kind]

if not I then
return j(` - missing parser {G.kind}`)
end

return I(H,G)end


return i end a.cN=function()local c=a.cache.cN if not c then c={c=b()}a.cache.cN=c end return c.c end end do local b=function()

local b=a.cA()
local c=a.ce()

local d=a.b6()
local e=a.cM()

local f=a.cs()
local g=a.cN()

local h=f.colorFromRGB
local i=f.escapeRichText

local j=f.lookupify{"`","'","\""}
local k=f.lookupify{" ","\t","\n","\r"}
local l=f.lookupify{",","|","&"}local m=function(

m)
return d.lookup[m]end local n=function(


n, o, p)
local q=e.args
return h(n,q[o]or p or q.others)end local o=function(


o)
local p=o:gsub(".",function(p)
return k[p]and"_"or p
end)
return p end local p=function(


p, q)
if p.name then
return`'{o(p.name)}'`
end
return`#{q}`end local q=function(



q, r, s)
local t=s+1

while true do
local u=q:find(r,t,true)

if not u then
return nil
end

if q:sub(u-1,u-1)~="\\"then
return u
end

t=u+1
end end local r=function(




r, s)
local t={}
local u=s
local v=#r

while u<=v do
local w=r:sub(u,u)

if k[w]then
break
end

table.insert(t,w)
u=u+1

if l[w]then
while u<=v and k[r:sub(u,u)]do
u=u+1
end
end
end

return table.concat(t),u-1 end local s=function(


s, t, u, v, w, x)
return{
kind=s,
value=t,
usedChar=x,
from=v,
to=w,
raw=u:sub(v,w),
}end local t=function(



t, u)
if u==""then
return"","",t
end

local v,w=t:lower():find(u:lower(),1,true)

if not v then
return"","",t
end

return t:sub(1,v-1),t:sub(v,w),t:sub(w+1)end local u=function(


u, v)
if v then
return v..u..v
end

if u:find"%s"then
return`"{u}"`
end

return u end local v=function(


v, w, x, y)
return{
from=v,
to=w,
text=u(x,y),
}end


local w={}
w.__index=w
w.colorFromName=n
w.removeWhiteSpace=o


w.parse=function(x, y)
local z=x.cmdInput
local A={}
local B=1
local C=#y

while B<=C do
local D=y:sub(B,B)

if k[D]then
B=B+1
else
local E=j[D]and q(y,D,B)

if E then
local F=(y:sub(B+1,E-1):gsub("\\"..D,D))
table.insert(A,s("string",F,y,B,E,D))
B=E+1
else
local F,G=r(y,B)
table.insert(A,s("identifier",F,y,B,G))
B=G+1
end
end
end

local D=A[#A]
local E=D and(D.to+1)or 1
local F=y:sub(E)

local G={}
for H,I in A do
table.insert(G,I.value)
end

z.rawText=y
z.parsed=A
z.spacesAtEnd=F
z.noHighlightText=table.concat(G," ")..F

return A end



w.parseArg=function(x, y, z, A)
local B=x.cmdInput
local C=z.value
local D=g:validate(y,C)
local E=D.success and#C>0

local F={success=E,text=C}
if E then
F.value=D.value
end
B.args[A]=F

if E then
local G=D.display or i(C)
return{success=true,display=n(G,D.color or"valid")}
end

local G=g.getOptions(y,D)
local H

if#C>0 then
H=c:searchAtArray(G,C)[1]
end

if H then
local I,J,K=t(H,C)
B.correction=v(z.from,z.to,H,z.usedChar)

return{
success=false,
suggestion=true,
display=n(i(I)..n(i(J),"warn")..i(K),"comment"),
}
end

return{
success=false,
display=n(i(C),D.color or"warn"),
message=D.message,
comment=D.comment,
}end



w.parsePending=function(x, y)
local z=x.cmdInput
local A=g:validate(y,"")
local B=g.getOptions(y,A)

if#B==0 then
return nil
end

local C=B[1]
local D=#z.rawText+1

if not y.optional then
z.correction={from=D,to=D-1,text=u(C)}
else
z.hasGhost=true
end

return n(i(C),"comment")end



w.highlightArgs=function(x, y, z, A, B)
local C=x.cmdInput
local D=y.args
local E=#D
local F=#z-1

local G=1
local H

for I,J in D do
local K=z[I+1]

if K==nil then
if A then
local L=x:parsePending(J)
if L then
table.insert(B,L)
end
end
break
end

local L=x:parseArg(J,K,I)
G=I+1

if L.display then
table.insert(B,L.display)
end

if not L.success then
H={index=I,result=L}
break
end
end


for I=G+1,math.min(#z,E+1)do
table.insert(B,i(z[I].raw))
end

local I=#z>E+1

if I then
local J=C.rawText:sub(z[E+2].from,z[#z].to)
table.insert(B,n(`<b>{i(J)}</b>`,"warn"))

C.runError=" - extra arg"
x:setComment(" - extra arg","warn")
return
end

if H then
local J=H.result


C.runError=` - {p(D[H.index],H.index)} is invalid`

if J.message and not J.suggestion then
x:setComment(J.message,J.comment and"comment"or"warn")
end
return
end


for J=F+1,E do
local K=D[J]

if not K.optional then
C.runError=` - {p(K,J)} is missing`
break
end
end

local J

if A then
J=F+1
elseif F>0 then
J=F
end

local K=J and D[J]

if K then
local L=A and""or": "
x:setComment(`{L}({x:highlightArgType(K)})`)
end end


w.highlightArgType=function(x, y)
local z=y.optional and n("?","symbol")or""
local A=`{n(y.kind,y.kind)}{z}`

if y.name then
return`{o(y.name)}: {A}`
end

return A end


w.highlightArgsType=function(x, y)
if#y==0 then return""end

local z={}

for A,B in y do
table.insert(z,x:highlightArgType(B))
end

return`({table.concat(z,", ")})`end


w.resetInput=function(x)
local y=x.cmdInput

y.highlightText=""
y.commandName=""
y.commandData=nil
y.isValidCommand=false
y.isAbreviated=false
y.bestMatch=nil
y.bestMatches={}
y.correctionText=nil
y.correction=nil
y.runError=nil
y.hasGhost=false
y.args={}

x:setComment""end



w.highlight=function(x, y)
local z=x.cmdInput
x:resetInput()

if#y==0 then return""end

local A=y[1]
local B=A.value
local C=B:lower()
local D=m(C)
local E=D~=nil
local F=z.spacesAtEnd
local G=#F>0

z.commandName=C
z.commandData=D
z.isValidCommand=E
z.isAbreviated=E and D.name~=C

if not E then
z.bestMatches=b:search(C)
z.bestMatch=z.bestMatches[1]

if G or#y>1 or not z.bestMatch then
local H=z.rawText:sub(A.from,y[#y].to)

z.runError=" - invalid command"
x:setComment(" - invalid command","error")
z.highlightText=n(i(H),"error")..F

return z.highlightText
end
end

local H={}

if E then
table.insert(H,n(i(B),"valid"))
else
local I=z.bestMatch
local J,K,L=t(I,B)

table.insert(H,n(i(J)..n(i(K),"warn")..i(L),"comment"))

z.correctionText=I
z.correction=v(A.from,A.to,I,A.usedChar)
z.runError=" - invalid command"
end

if E then

local I=#y==1 and not G

if I and#D.aliases>1 then
local J=table.clone(D.aliases)
local K=table.find(J,C)

if K then
table.remove(J,K)
end

x:setComment(`: [{table.concat(J,", ")}]`,"comment")
end

x:highlightArgs(D,y,G,H)
end

if z.correction or z.hasGhost then
F=""
end

local I=table.concat(H," ")..F
z.highlightText=I

return I end


w.setComment=function(x, ...)
return x.setCommentCallback(...)end


w.new=function(x, y)
return setmetatable({
cmdInput=x,
setCommentCallback=y
},w)end


return w end a.cO=function()local c=a.cache.cO if not c then c={c=b()}a.cache.cO=c end return c.c end end do local b=function()

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


return b end a.cP=function()local c=a.cache.cP if not c then c={c=b()}a.cache.cP=c end return c.c end end do local b=function()
local b=a.cf()
local c=a.g()
local d=a.ad()
local e=a.cu()
local f=a.cL()

local g=a.cA()
local h=a.cO()
local i=a.cP()

local j=a.cJ()
local k=a.b6()

local l=a.b7()
local m=a.d()
local n=a.cs()
local o=a.cG()

local p=a.k()
local q=a.cM().commands

local r=c.UserInputService
local s=c.RunService

local t=n.richFontSize
local u=n.colorFromRGB

local v={}
v.__index=v local w=function(

w)
return j.pressingInputs[w.UserInputType]~=nil end local x=function(


x)
return k.lookup[x]end local y=function(


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

if p:getValue"spaceAfterCorrection"then
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

b:Connect(D.Activated,K)

b:Connect(C.Focused,function()
M()
A.markerConnection=b:Connect(s.Stepped,I)

if#C.Text==0 then
A:setComment""
end
end)

b:Connect(C.FocusLost,function(N)
M()
E.Visible=true
b:disconnect(A.markerConnection)

if N then
A:refresh(z(C.Text))
L()
end
end)

b:Connect(G,function()
local N=C.Text
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
end)end


v.sendInputCommand=function(A)
local B=A.commandInput

if B.runError then
A:setComment(B.runError,"error")
return
end

local C=B.commandData
if not C then return end

local D=C.name

local E,F=pcall(function()
local E=i.new(B.args)
return g:run(D,E)
end)

if p:getValue"clearOnEnter"then
A.searchBox.Text=""
end

if not E then
A:setComment(`failed - {F}`,"error")
m:error(`failed to run command '{D}': {F}`)
end end


v.create=function(A)
A.searchBoxHolder=e.new("ImageButton",{
Size=UDim2.new(1,-10,0,18),
Position=UDim2.fromScale(0.5,0),
AnchorPoint=Vector2.new(0.5,1),
BorderSizePixel=0,
ClipsDescendants=true,
ThemeTag={BackgroundColor3="Colors.Buttons.Default"},

e.new("UICorner",{CornerRadius=UDim.new(0,6)}),

e.new("TextLabel","Input",{
Size=UDim2.fromScale(0,1),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
TextSize=A.configs.textSize,
Visible=false,
RichText=true,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
e.new("Frame","Holder",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromScale(1,0)
}),
}),

e.new("TextLabel","Placeholder",{
Size=UDim2.new(1,-5,1,0),
Position=UDim2.new(0,5,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=A.configs.textSize-1,
Text=A.configs.placeholderText,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
}),
})

local B=A.searchBoxHolder
local C=B.Input.Holder

A.inputMarker=e.new("Frame","Marker",C,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

A.inputComment=e.new("TextLabel","Comment",C,{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromScale(1,0.5),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=A.configs.textSize,
RichText=true,
Text="",
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
}
})

A.commandInfo=e.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=A.configs.textFont,
TextSize=A.configs.textSize-5,
Visible=false,
e.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

A.searchBox=e.new("TextBox","SearchBox",{
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

A.commandsFolder=e.new("Folder","Commands")end


v.createCommandsData=function(A)
for B,C in k.original do
local D=f.new(C)
C.commandData=D
D.position=B-1
table.insert(A.commandsData,D)
end end


v.updateSearchBoxHighlight=function(A)
local B=A.commandInput.highlightText
local C=A.searchBoxHolder
local D=C.Input
local E=o:getScale()

D.Text=B
D.Visible=#B>0

local F=C.AbsoluteSize.X*E
local G=F/2
local H=D.AbsoluteSize.X*E

if H<=G then
D.AnchorPoint=Vector2.new(0,0.5)
D.Position=UDim2.new(0,5,0.5,0)
else
D.AnchorPoint=Vector2.new(1,0.5)
D.Position=UDim2.new(0.5,0,0.5,0)
end end


v.updateSearchedCommand=function(A)
local B=A.commandInput.bestMatch
local C=A.commandInput.commandName
if C==""then return end

local D=x(C)
or(B and x(B))

if D then
A.scrollBar:scrollTo(D.commandData.position)
end end


v.setComment=function(A, B, C)
if C~=nil then
B=h.colorFromName(B,C)
end

A.inputComment.Text=B
A.inputComment.Visible=#B>0 end


v.updateElementColor=function(A, B, C)
local D=if C%2==1 then 1 else 0.96
B.BackgroundTransparency=D end


v.updateElements=function(A)
local B=0
local C=0
local D={}
local E=A.scrollBar
local F=A.commandsFolder

for G,H in A.commandsData do
local I=E:isVisible(H.position)

if not I then
if H.element then H.element.Parent=nil end
continue
end

local J=H.element
if not J then
J=A:createCommandElement(H)
H.element=J
end

if not H.isSection then
if#H.args>0 and#H.name>C then
C=#H.name
end
table.insert(D,H)
end

A:updateElementColor(J,G)
J.Parent=F
J.Position=UDim2.fromOffset(
0,
B*(J.Size.Y.Offset+A.configs.padding)
)
B=B+1
end

for G,H in D do
A:updateDisplayName(H,C+3)
end

A.visibleCommands=D end


v.setCommandInfo=function(A, B)
B=B or""

if B==""then
A.commandInfo.Visible=false
return
end

A.commandInfo.Visible=true
A.commandInfo.Text=B end


v.createSection=function(A, B)


local C=e.new("TextLabel","Command",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
RichText=true,
TextSize=A.configs.textSize-3,
Text=`<b>#{B.sectionName}</b>`,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.MonoSpace"
},
})

return e.new("Frame",{
Size=UDim2.new(1,-10,0,A.configs.labelSize),
BackgroundTransparency=1,

C
})end


v.createCommandElement=function(A, B)
if B.isSection then
return A:createSection(B)
end

local C=e.new("TextLabel","Command",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.X,
RichText=true,
TextSize=A.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
})

return e.new("Frame",{
Size=UDim2.new(1,0,0,A.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
C
})end


v.createCommandDescription=function(A, B)
if B.isSection then return end
if not B.description then return end

local C=e.new("TextLabel","Description",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(25,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
TextSize=A.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
})

return e.new("Frame","Description",{
Size=UDim2.new(1,-30,0,A.configs.labelSize),
BackgroundTransparency=1,
C
})end


v.getCommandColor=function(A, B, C)
local D=x(B)

local E=
if type(D.run)~="function"then"undefined"
elseif C.isClient then"client"
elseif C.isDeprecated then"deprecated"
else nil

if E~=nil then
B=u(B,q[E])
end

return B end


v.updateDisplayName=function(A, B, C)
local D=B.element
local E=B.name

local F=string.rep("—",(C-#E)-2)

E=A:getCommandColor(E,B)
local G=`{E} {h.colorFromName(F,"comment")} `

local H=A.parser:highlightArgsType(B.args)
local I=G..H

if B.isHolding then
B.originalText=I
else
A:setCommandText(B,I)
end end


v.setCommandText=function(A, B, C)
local D=B.element
if not D then return end

D.Command.Text=C end


v.getCommandText=function(A, B)
local C=B.element
return C and C.Command.Text or""end


v.calculateTotalSpace=function(A)
return#A.commandsData end


v.calculateVisibleSpace=function(A)
local B=A.scrollContainer.AbsoluteSize.Y
return math.floor(B/A:calculateLabelSize())end


v.calculateLabelSize=function(A)
return A.configs.padding+A.configs.labelSize end


v.getElementMouseIn=function(A)
for B,C in A.visibleCommands do
if d:isMouseInGuiObject(C.element)then
return C
end
end end


v.horizontalScroll=function(A, B)
for C,D in A.visibleCommands do
local E=D.element

E.Position=UDim2.fromOffset(
math.min(E.Position.X.Offset+B,0),
E.Position.Y.Offset
)
end end


v.startedHoldingContainer=function(A, B)
if not w(B)then return end
if A.scrollBar:isScrollBarDisabled()then return end

A.scrollAxis=nil
A.scrollBar:disableScroll()

local C=d:getMouse()
local D=A:calculateLabelSize()
local E=A:getElementMouseIn()
local F=tick()

if E and E.description then
E.isHolding=true

local G=A.parser.colorFromName(E.description,"comment")

E.originalText=A:getCommandText(E)
A:setCommandText(E,G)
end

local G=C.Y
local H=C.X

local I,J local K=function()


A.scrollBar:enableScroll()

if E then
E.isHolding=nil

if E.originalText then
A:setCommandText(E,E.originalText)
E.originalText=nil
end

if(tick()-F)<=0.15 then
A.commandClickedSignal:Fire(E)
end
end

if J then J:Disconnect()end
if I then I:Disconnect()end end


J=b:Connect(r.InputEnded,function(L)
if not w(L)then return end
K()
end)

I=b:Connect(r.InputChanged,function(L)
if not w(L)then return end

local M=C.X-H
local N=C.Y-G

if not A.scrollAxis then
if math.abs(M)>4 or math.abs(N)>4 then
A.scrollAxis=math.abs(M)>math.abs(N)and"x"or"y"
end
return
end

if A.scrollAxis=="x"then
local O=y(M/3)
if math.floor(O)~=0 then
A:horizontalScroll(O)
H=C.X
end
else
local O=y(N/D)
if math.floor(O)~=0 then
A.scrollBar:scrollTo(A.scrollBar.index-O)
G=C.Y
end
end
end)end


v.update=function(A)
A.scrollBar:setVisibleSpace(A:calculateVisibleSpace())
A.scrollBar:setTotalSpace(A:calculateTotalSpace())
A:updateElements()end


v.enable=function(A)
if A.isEnabled then return end
local B=A.scrollContainer
A.isEnabled=true

A.commandsFolder.Parent=B
A.searchBox.Parent=A.scrollHolder
A.searchBoxHolder.Parent=A.scrollHolder
A.commandInfo.Parent=A.scrollHolder

A.scrollConnection=A.scrolledSignal:Connect(function()
A:updateElements()
end)

A.containerConnection=B.InputBegan:Connect(function(C)
A:startedHoldingContainer(C)
end)

A:update()end


v.disable=function(A)
if not A.isEnabled then return end
A.isEnabled=false

A.commandsFolder.Parent=nil
A.searchBox.Parent=nil
A.searchBoxHolder.Parent=nil
A.commandInfo.Parent=nil

b:disconnect(A.containerConnection)
b:disconnect(A.markerConnection)
b:disconnect(A.scrollConnection)end


v.new=function(A)local B=function(
B)
return assert(A.configs[B],`missing config.configs['{B}']`)end


local C=setmetatable({
scrollContainer=A.scrollContainer,
scrolledSignal=A.scrolledSignal,
scrollHolder=A.scrollHolder,
scrollBar=A.scrollBar,

configs={
placeholderText=B"placeholderText",
padding=B"padding",
labelSize=B"labelSize",
textSize=B"textSize"
},

commandClickedSignal=l.new(),

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
commandsData={}
},v)

C.parser=h.new(C.commandInput,function(D,E)
return C:setComment(D,E)
end)

return C end


return v end a.cQ=function()local c=a.cache.cQ if not c then c={c=b()}a.cache.cQ=c end return c.c end end do local b=function()
local b=a.cs().colorFromRGB
local c=a.cM().commands

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
{"text",`{b("COMMAND_UNDEFINED",c.undefined)} -> This command don't work (BETA)`},
{"text",`{b("CLIENT",c.client)} -> Only works on client`},
{"text",`{b("DEPRECATED",c.deprecated)} -> This command is deprecated`}
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
}end a.cR=function()local c=a.cache.cR if not c then c={c=b()}a.cache.cR=c end return c.c end end do local b=function()


local b=a.cu()
local c=a.cC()
local d=a.cK()

local e=a.cG()
local f=a.cf()
local g=a.a()
local h=a.o()

local i=a.cR()

local j=500
local k=20
local l=300
local m=k+l

local n=12
local o=20
local p=40

local q=0.5
local r=2

local s=UDim2.new(0.5,-j/2,0,-500)
local t=UDim2.new(0.5,-j/2,0.5,-m/2)

local u={["&"]="&amp;",["<"]="&lt;",[">"]="&gt;"}

local v=i.cases
local w=i.sections

local x={}
x.__index=x local y=function(

y)
return(y:gsub("[&<>]",u))end local z=function(


z)
return b.new("TextLabel","Header",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=z,
TextSize=20,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})end local A=function(


A, B)
return b.new("TextLabel",B and"Bold"or"Text",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=A,
TextSize=14,
TextWrapped=true,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font=B and"Font.Bold"or"Font.Normal",
TextColor3="Colors.Text.Default",
},
})end local B=function()



local B=b.new("Frame","Cases",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
b.new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for C,D in v do
local E,F=D[1],D[2]

b.new("TextLabel","Case",B,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=C,
RichText=true,
Size=UDim2.new(1,0,0,0),
Text=`<b>{y(E)}</b> {y(F)}`,
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

return B end local C=function(


C)
local D=b.new("TextButton","InviteButton",{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,25),
Text=`Copy Discord Invite Link ({C})`,
TextSize=16,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local E=D.Text
local F

f:Connect(D.Activated,function()
if g.setclipboard then
g.setclipboard(C)
D.Text="Copied"
else
D.Text="No Clipboard Function, type out the link"
end

local G=tick()
F=G

task.wait(r)
if F~=G then return end

D.Text=E
end)

return D end local D=function(


D)
local E=D[1]

if E=="title"then
return z(D[2])
elseif E=="cases"then
return B()
elseif E=="invite"then
return C(h.links.discord)
end

return A(D[2],E=="bold")end local E=function(


E, F, G)
local H=b.new("Frame","Section",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=E,
Size=UDim2.new(1,0,0,0),
b.new("UIPadding",{
PaddingBottom=UDim.new(0,8),
PaddingLeft=UDim.new(0,8),
PaddingRight=UDim.new(0,8),
PaddingTop=UDim.new(0,5),
}),
b.new("UIListLayout",{
Padding=UDim.new(0,4),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for I,J in F do
local K=D(J)
K.LayoutOrder=I
K.Parent=H
end

if not G then
b.new("Frame","Line",H,{
BorderSizePixel=0,
LayoutOrder=#F+1,
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Colors.Stroke",
},
})
end

return H end


x.new=function()
return setmetatable({},x)end


x.open=function(F)
F.frame:TweenPosition(t,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,q,true)end


x.close=function(F)
F.frame:TweenPosition(s,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,q,true)end


x.create=function(F)
local G=b.new("Frame","ReferenceFrame",{
Active=true,
BorderSizePixel=0,
Position=s,
Size=UDim2.fromOffset(j,m),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local H=b.new("Frame","TopBar",G,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,k),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

b.new("TextLabel","Title",H,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text="Reference",
TextSize=16,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local I=b.new("TextButton","Close",H,{
BackgroundTransparency=1,
Position=UDim2.new(1,-k,0,0),
Size=UDim2.fromOffset(k,k),
Text="",
})

local J=b.new("ImageLabel","Icon",I,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(10,10),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local K=d.new{
isHorizontal=false,
barThickness=n,
increment=o,
wheelIncrement=p,
}

local L=K:create()
local M=K.container

local N=b.new("Frame","Content",M,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
b.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

b.new("Frame","ScrollHolder",G,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,k),
Size=UDim2.new(1,0,0,l),

L,
M,
})

for O,P in w do
local Q=E(O,P,O==#w)
Q.Parent=N
end local O=function(


O)
N.Position=UDim2.fromOffset(0,-O)end local P=function()



local P=e:getScale()

K:setTotalSpace(math.ceil(N.AbsoluteSize.Y/P))
K:setVisibleSpace(math.ceil(M.AbsoluteSize.Y/P))
O(K.index)end


f:Connect(K.scrolledSignal,O)
f:Connect(N:GetPropertyChangedSignal"AbsoluteSize",P)
f:Connect(M:GetPropertyChangedSignal"AbsoluteSize",P)

f:Connect(M.MouseWheelForward,function()
K:scrollTo(K.index-K.wheelIncrement)
end)

f:Connect(M.MouseWheelBackward,function()
K:scrollTo(K.index+K.wheelIncrement)
end)

f:Connect(I.Activated,function()
F:close()
end)

local Q=c.new(e.uiScale)
Q:addGuiObject(G)

Q.dragStarted:Connect(function(R)
if R~=G then return end
K:disableScroll()
end)

Q.dragEnded:Connect(function(R)
if R~=G then return end
K:enableScroll()
end)

P()

F.frame=G
F.closeIcon=J
F.scrollBar=K
F.dragInstance=Q

return G end


return x end a.cS=function()local c=a.cache.cS if not c then c={c=b()}a.cache.cS=c end return c.c end end do local b=function()


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
}end a.cT=function()local c=a.cache.cT if not c then c={c=b()}a.cache.cT=c end return c.c end end do local b=function()


local b=a.cu()
local c=a.cC()
local d=a.cw()
local e=a.ct()
local f=a.cy()

local g=a.cs()

local h=a.cG()
local i=a.cf()
local j=a.a()
local k=a.ac()
local l=a.g()
local m=a.b()

local n=a.cT()
local o=a.cM().args

local p=UDim2.new(0.5,-n.window.width/2,0,n.window.shownY)
local q=UDim2.new(0.5,-n.window.width/2,0,n.window.hiddenY)

local r

local s=g.charset":#()[]-"
local t=g.charset"0123456789"

local u={}local v=function(

v)
if t[v]then
return o.number
elseif s[v]then
return o.symbol
end

return nil end local w=function(


w)
local x=tostring(w)
local y={}
local z=""
local A local B=function()


if z==""then return end

local B=g.escapeRichText(z)

if A then
table.insert(y,g.colorFromRGB(B,A))
else
table.insert(y,B)
end

z=""end


for C in x:gmatch"."do
local D=v(C)

if D~=A then
B()
A=D
end

z=z..C
end

B()

return table.concat(y)end local x=function(


x, y)
return`{g.escapeRichText(x)}{w(y)}`end local y=function(


y)
if y==nil then return false end

if j.setclipboard then
j.setclipboard(tostring(y))
return true
end

f:notify(n.messages.noClipboard)
return false end local z=function(


z)
local A=n.time
local B=math.floor(z/3600)
local C=math.floor((z%3600)/60)
local D=math.floor(z%60)

if B>0 then
return`{B} {A.hour}, {C} {A.minute}, {D} {A.second}`
elseif C>0 then
return`{C} {A.minute}, {D} {A.second}`
end

return`{D} {A.second}`end local A=function()



local A,B=pcall(function()
return l.MarketplaceService:GetProductInfo(game.PlaceId)
end)

if A and B then
return B.Name
end

return n.messages.unknownPlace end local B=function(


B, C)
local D=n.copyButton

local E=b.new("TextButton","Copy",B,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-n.window.textInset,0.5,0),
Size=UDim2.fromOffset(D.width,D.height),
Text=D.idleText,
TextSize=n.textSizes.copyButton,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

b.new("UICorner",{
CornerRadius=UDim.new(0,D.cornerRadius),
}),
})

i:Connect(E.MouseEnter,function()
e:updateObjectProperties(E,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

i:Connect(E.MouseLeave,function()
e:updateObjectProperties(E,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

i:Connect(E.Activated,function()
if not y(C())then return end

E.Text=D.copiedText
task.wait(D.feedbackTime)
E.Text=D.idleText
end)

return E end local C=function(


C, D, E, F)
local G=n.window
local H=G.textInset
local I=0

if F.getCopyValue then
I=n.copyButton.width+n.copyButton.gap
end

local J=b.new("Frame","Row",C,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=(D%2==1)and G.stripeTransparency or 1,
BorderSizePixel=0,
LayoutOrder=D,
Size=UDim2.new(1,0,0,G.rowHeight),
})

local K=b.new("TextLabel",F.name,J,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(H,0),
RichText=true,
Size=UDim2.new(1,-(H*2+I),1,0),
Text=E,
TextSize=F.textSize,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=F.textColor,
},
})

if F.getCopyValue then
B(J,F.getCopyValue)
end

return K end local D=function(


D, E, F)
return C(D,E,`<b>{g.escapeRichText(F)}</b>`,{
name="Section",
textSize=n.textSizes.section,
textColor="Colors.Text.Darker",
})end local E=function(


E, F, G, H)
return C(E,F,G,{
name="Value",
textSize=n.textSizes.value,
textColor="Colors.Text.Default",
getCopyValue=H,
})end local F=function()



local F=n.window

local G={
labels={},
placeName=nil,
}

local H=b.new("Frame","ServerInfo",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=q,
Size=UDim2.fromOffset(F.width,0),

b.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local I=b.new("Frame","TopBar",H,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,F.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

b.new("TextLabel","Title",I,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=F.title,
TextSize=n.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local J=b.new("ImageButton","Exit",I,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-F.closeInset,0.5,0),
Size=UDim2.fromOffset(F.closeIconSize,F.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

d:loadImage(J,"close")

i:Connect(J.Activated,function()
u:close()
end)

local K=b.new("Frame","Body",H,{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
LayoutOrder=2,
Size=UDim2.new(1,0,0,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},

b.new("UIPadding",{
PaddingBottom=UDim.new(0,F.verticalPadding),
PaddingTop=UDim.new(0,F.verticalPadding),
}),

b.new("UIListLayout",{
Padding=UDim.new(0,F.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local L=G.labels
local M=n.labels
local N=n.messages.loading

local O=0 local P=function()

O=O+1
return O end


D(K,P(),n.headers.localPlayer)

L.playerId=E(K,P(),x(M.playerId,k.UserId),function()
return k.UserId
end)

L.appearance=E(K,P(),x(M.appearance,k.CharacterAppearanceId),function()
return k.CharacterAppearanceId
end)

D(K,P(),n.headers.runTime)
L.time=E(K,P(),w(N))

D(K,P(),n.headers.statistics)
L.players=E(K,P(),x(M.players,N))
L.maxPlayers=E(K,P(),x(M.maxPlayers,N))

L.placeId=E(K,P(),x(M.placeId,game.PlaceId),function()
return game.PlaceId
end)

L.placeName=E(K,P(),x(M.placeName,N),function()
return G.placeName
end)

r=r or c.new(h.uiScale)
r:addGuiObject(H)

G.frame=H
return G end local G=function(


G)
local H=G.labels
local I=n.labels
local J=l.Players

while u.window==G do
H.players.Text=x(I.players,#J:GetPlayers())
H.maxPlayers.Text=x(I.maxPlayers,J.MaxPlayers)
H.time.Text=w(z(workspace.DistributedGameTime))

task.wait(n.window.updateInterval)
end end


u.create=function(H)
if H.isEnabled then
f:notify(n.messages.alreadyEnabled)
return
end

H.isEnabled=true

local I=F()
H.window=I

local J=n.window.tweenTime

I.frame.Parent=m.screenGui
I.frame:TweenPosition(p,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,J,true)

task.spawn(function()
I.placeName=A()
I.labels.placeName.Text=x(n.labels.placeName,I.placeName)
end)

task.spawn(G,I)

return I end


u.close=function(H)
local I=H.window
if not I then return end

local J=n.window.tweenTime

H.window=nil
H.isEnabled=false

I.frame:TweenPosition(q,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,J,true)

task.delay(J,function()
I.frame:Destroy()
end)end


return u end a.cU=function()local c=a.cache.cU if not c then c={c=b()}a.cache.cU=c end return c.c end end do local b=function()


local b=a.o()
local c=a.b()
local d=a.cf()

local e=a.k()
local f=a.d()
local g=a.cs()

local h=a.cu()
local i=a.cw()
local j=a.ct()
local k=a.cC()
local l=a.cr()
local m=a.cD()
local n=a.cy()
local o=a.cx()

local p=a.cF()
local q=a.cG()

local r=a.cH()
local s=a.cK()
local t=a.cQ()
local u=a.cS()
local v=a.cU()

local w=q.uiScale

local x={}local y=function(

y)
local z=type(y)=="string"and l[y:lower()]

if z and z.Colors and z.Font then
return y
end

return b.theme.defaultTheme end


x.createScreenGui=function(z)
local A=h.new("ScreenGui",{
IgnoreGuiInset=true,
Name=g.randomString(math.random(30,50)),
DisplayOrder=2147483647
})

z.screenGui=A
return A end


x.calculateScale=function(z, A)
return(z.screenGui.AbsoluteSize.Y/450)*A end


x.setScale=function(z, A)
A=math.abs(A)

if A>=3 then
A=z:calculateScale(A)
end

if e:getValue"interface.uiScale"~=A then
e:setValue("interface.uiScale",A)
e:save()
end

q:setScale(A)
z:updateMainFramePosition()end local z=function(


z, A, B, C)
local D=(z.Scale*B)/C+z.Offset
local E=math.floor(B/C-A)

if math.floor(D)>=E then
return 1,-A
end

return 0,math.clamp(math.floor(D),0,math.max(E,0))end


x.calculateMainFramePosition=function(A)
local B=A.mainFrame
local C=A.screenGui
local D=w.Scale
local E=B.Position
local F=B.Size

local G,H=z(E.X,F.X.Offset,C.AbsoluteSize.X,D)
local I,J=z(E.Y,F.Y.Offset,C.AbsoluteSize.Y,D)


task.defer(A.updateNotificationsPosition,A)

return UDim2.new(G,H,I,J)end







































x.updateMainFramePosition=function(A)
if A.mainFrame then
A.mainFrame.Position=A:calculateMainFramePosition()
end end


x.createMainScroll=function(A, B)
local C=s.new{
isHorizontal=false,
barThickness=12
}

local D=C:create()
local E=C.container

local F=h.new("Frame","ScrollHolder",B,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

D,
E
})

A.scrollHolder=F
A.scrollBar=C
A.scrollContainer=E

return C end


x.createMainFrame=function(A)
local B=r:create()
local C=B.mainFrame

B.titleLabel.Text=p.getDisplayName()

A.mainFrame=C
A.topBar=B.topBar
A.buttons=B.buttons

i:loadImage(A.buttons.settings,"settings")
i:loadImage(A.buttons.reference,"reference")

d:Connect(A.buttons.settings.Activated,function()
print"clicked settings"
end)

A:createMainScroll(C)

return C end


x.createCommands=function(A)
local B=A.scrollBar

local C=t.new{
scrolledSignal=B.scrolledSignal,
scrollContainer=A.scrollContainer,
scrollHolder=A.scrollHolder,
scrollBar=B,

configs={
placeholderText=b.ui.commands.placeholderText,
padding=b.ui.commands.padding,
labelSize=b.ui.commands.labelSize,
textSize=b.ui.commands.textSize
}
}

f:log"created commands interface"
C:create()

f:log"initialized commands"
C:createCommandsData()

f:log"awaked commands module"
C:awake()

A.commands=C
return C end


x.createInfoMenu=function(A)
return v:create()end


x.dragMainFrame=function(A, B)
local C=k.new(w)

B.Size=b.ui.window.windowSize
B.Position=UDim2.fromOffset(1e5,1e5)
B.Position=A:calculateMainFramePosition()

C:addGuiObject(B)

C:setFilter(B,function(D)
B.Position=D
return A:calculateMainFramePosition()
end)

C.dragStarted:Connect(function(D)
if D~=B then return end
A.scrollBar:disableScroll()
end)

C.dragEnded:Connect(function(D)
if D~=B then return end
A.scrollBar:enableScroll()
end)

A.dragService=C end


x.createReference=function(A)
local B=u.new()
local C=B:create()

i:loadImage(B.closeIcon,"close")

C.Parent=A.screenGui
A.reference=B

d:Connect(A.buttons.reference.Activated,function()
B:open()
end)

return B end


x.createNotifications=function(A)
local B=n:getContainer(A.screenGui)
A.notificationsContainer=B
return B end


x.updateNotificationsPosition=function(A)
local B=A.notificationsContainer
local C=A.mainFrame
local D=A.screenGui
if not(B and C and D)then return end

local E=q:getScale()
local F=math.ceil(D.AbsoluteSize.X/E)
local G=math.ceil(D.AbsoluteSize.Y/E)

local H=o.gapToWindow
local I=B.Size.X.Offset

local J=C.AbsolutePosition.X/E
local K=J+C.Size.X.Offset
local L=C.AbsolutePosition.Y/E
local M=L+C.Size.Y.Offset

local N=F-K-H
local O=J-H

local P
if N>=I then
P=true
elseif O>=I then
P=false
else
P=N>=O
end

local Q=(L+C.Size.Y.Offset/2)>G/2

local R=P and(K+H)or(J-H)
local S=Q and M or L

B.AnchorPoint=Vector2.new(P and 0 or 1,Q and 1 or 0)
B.Position=UDim2.fromOffset(R,S)end


x.destroy=function(A)
if A.screenGui then
A.screenGui:Destroy()
end end


x.init=function(A)
f:debug"interface: initializing theme service"
j:init{
theme=y(b.theme.selectedTheme)
}

local B=A:createScreenGui()


B.Parent=m
c.screenGui=B

w.Parent=B
A:setScale(e:getValue"interface.uiScale"or 1)

local C=A:createMainFrame()

A:createCommands()
A:dragMainFrame(C)
A.commands:enable()

C.Parent=B
A:createReference()
A:createNotifications()

return B end


return x end a.cV=function()local c=a.cache.cV if not c then c={c=b()}a.cache.cV=c end return c.c end end do local b=function()

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
c:log"cleaned old connections"
end

c:log"finished cleanup!"end


return d end a.cW=function()local c=a.cache.cW if not c then c={c=b()}a.cache.cW=c end return c.c end end do local b=function()


local b=a.cA()
local c=a.ad()
local d=a.cj()

local e=a.cB()

local f=a.cV()

local g={}

g.boot=function(h)a.cW()
:init()

b:init{
infiniteYield=f,
playerService=c,
fetchService=d
}

e(b)

f:init()end


return g end a.cX=function()local c=a.cache.cX if not c then c={c=b()}a.cache.cX=c end return c.c end end end














return a.cX():boot()