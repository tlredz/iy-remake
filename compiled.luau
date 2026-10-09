local a={cache={}}do do local function __modImpl()local b=(getgenv or getfenv or getrenv)()

local function register(c,d,e)
if type(d)==c then
return d
end

if e~=nil then
if e==true then
e=function(...)return...end
end

return e
end
end

return setmetatable({
cloneref=register("function",cloneref,true),
setfpscap=register("function",setfpscap,function(c)
if typeof(b.FPS_CAP_THREAD)=="thread"then
task.cancel(b.FPS_CAP_THREAD)
end

b.FPS_CAP_THREAD=task.spawn(function()
local d=os.clock
local e=task.wait

local f=d()+(1/c)

while true do
if d()>=f then
f=d()+(1/c)
e()
end
end
end)
end),
gethui=register("function",
gethui or
get_hidden_gui
),
sethiddenproperty=register("function",
sethiddenproperty or
set_hidden_property or
set_hidden_prop
),
gethiddenproperty=register("function",
gethiddenproperty or
get_hidden_property or
get_hidden_prop
),
queueteleport=register("function",
queue_on_teleport or
(syn and syn.queue_on_teleport)or
(fluxus and fluxus.queue_on_teleport)
),
httprequest=register("function",
request or
http_request or
(syn and syn.request)or
(http and http.request)or
(fluxus and fluxus.request)
),
setclipboard=register("function",
setclipboard or
toclipboard or
set_clipboard or
(Clipboard and Clipboard.set)
),
firetouchinterest=register("function",firetouchinterest),
makefolder=register("function",makefolder),
isfolder=register("function",isfolder),
getcustomasset=register("function",
getcustomasset or
getsynasset
),
hookfunction=register("function",hookfunction),
hookmetamethod=register("function",hookmetamethod),
getnamecallmethod=register("function",
getnamecallmethod or
get_namecall_method
),
checkcaller=register("function",checkcaller,
function()return false end
),
newcclosure=register("function",newcclosure),
getgc=register("function",getgc or get_gc_objects),
setthreadidentity=register("function",
setthreadidentity or
syn_context_set or
setthreadcontext or
(syn and syn.set_thread_identity)
),
replicatesignal=register("function",replicatesignal),
getconnections=register("function",
getconnections or
get_signal_cons
),
writefile=register("function",writefile),
readfile=register("function",readfile),
isfile=register("function",isfile,readfile and function(c)
local d,e=pcall(readfile,c)
return d and e~=nil and e~=""
end)
},{
__index=b,
__newindex=function(c,d,e)
b[d]=e
end
})end a.a=function()local b=a.cache.a if not b then b={c=__modImpl()}a.cache.a=b end return b.c end end do local function __modImpl()
local b=a.a()

local c="IY-REMAKE-PRIVATEENV"

local d=b[c]or{}
b[c]=d

return d end a.b=function()local b=a.cache.b if not b then b={c=__modImpl()}a.cache.b=b end return b.c end end do local function __modImpl()
return{
logText="infinite yield -> %s",
isEnabled=false
}end a.c=function()local b=a.cache.c if not b then b={c=__modImpl()}a.cache.c=b end return b.c end end do local function __modImpl()
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


return d end a.d=function()local b=a.cache.d if not b then b={c=__modImpl()}a.cache.d=b end return b.c end end do local function __modImpl()
return{
action="discord|support|help",
description="Invite to the Infinite Yield discord server.",
run=function(b)
b.executorEnv.setclipboard(b.config.links.discord)
end
}end a.e=function()local b=a.cache.e if not b then b={c=__modImpl()}a.cache.e=b end return b.c end end do local function __modImpl()
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


return c end a.f=function()local b=a.cache.f if not b then b={c=__modImpl()}a.cache.f=b end return b.c end end do local function __modImpl()
local b={}

local c=a.a()
local d=a.d()

b.__index=function(e, f)
d:expect(f,{"string"},"[index] serviceName")

local g=game:GetService(f)
local h=c.cloneref(g)

rawset(e,f,h)
return h end


return setmetatable({},b)end a.g=function()local b=a.cache.g if not b then b={c=__modImpl()}a.cache.g=b end return b.c end end do local function __modImpl()
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
}end a.h=function()local b=a.cache.h if not b then b={c=__modImpl()}a.cache.h=b end return b.c end end do local function __modImpl()
return{
privateFolder="infiniteYield",
imagePath="assets/%s.png",
encryptKey=676767
}end a.i=function()local b=a.cache.i if not b then b={c=__modImpl()}a.cache.i=b end return b.c end end do local function __modImpl()
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
i.__index=i

local function isfile(j)
local k,l=pcall(b.isfile,j)

if k and type(l)=="boolean"then
return l
end

return false
end

local function isfolder(j)
local k,l=pcall(b.isfolder,j)

if k and type(l)=="boolean"then
return l
end

return false
end

local function readfile(j)
if not isfile(j)then
d:log(`the file '{j}' don't exist, skipped!`)
return""
end

local k,l=pcall(b.readfile,j)

if not k then
d:warn(`failed to read file '{j}':\n\t{l}`)
l=nil
end

if type(l)~="string"then
l=""
end

return l
end

local function makefolder(j)
local k=j:split"/"
local l={}

for m,n in k do
table.insert(l,n)

local o=table.concat(l,"/")
if isfolder(o)then continue end

local p,q=pcall(b.makefolder,o)

if not p then
d:warn(`failed to create a folder '{o}':\n\t{q}`)
end
end
end

local function writefile(j,k)
local l,m=pcall(b.writefile,j,k)

if l then
d:log(`successfully writed the file '{j}'!`)
else
d:warn(`failed to write file '{j}':\n\t{m}`)
end
end

local function getcustomasset(j)
local k,l=pcall(b.getcustomasset,j)

if not(k and type(l)=="string")then
d:warn(`failed to get custom asset '{j}':\n\t{l}`)
return
end

return l
end

local function getFolderPath(j)
local k=string.split(j,"/")
local l=table.remove(k)

return table.concat(k,"/"),l
end

i.getRealPath=function(j, k)
if k:sub(1,1)~="/"then
k="/"..k
end

k=g..k
return k end


i.deep=function(j, k)
local l=j.object
local m=k:split"."
local n=table.remove(m)

for o,p in m do
local q=l[p]
if type(q)~="table"then q={}end
l[p]=q
l=q
end

return l,n end


i.setValue=function(j, k, l)
local m,n=j:deep(k)
m[n]=l end


i.getValue=function(j, k)
local l,m=j:deep(k)
return l[m]end


i.hasValue=function(j, k)
return j:getValue(k)~=nil end


i.increment=function(j, k, l)
return j:setValue(k,(j:getValue(k)or 0)+l)end


i.exist=function(j, k)
k=j:getRealPath(k)
return isfile(k)end


i.writeFile=function(j, k, l)
if j.filePath~=nil then
k,l=j.filePath,k
else
k=j:getRealPath(k)
end

writefile(k,l)end


i.register=function(j, k, l)
local m=j:getValue(k)

if typeof(m)~=typeof(l)then
m=l
j:setValue(k,m)
end

return m end


i.add=function(j, k, l)
local m=j:getValue(k)
d:expect(m,{"table"},"'userData:add' #1")

if not table.find(m,l)then
table.insert(m,l)
end end


i.save=function(j)
if j.isSaving then return end

j.isSaving=true
j.lastSave=tick()

task.delay(1,function()
local k=e.encode(j.object,j.filePath)

if j.encryptData then
k=c:encrypt(k)
end

j.isSaving=false
j:writeFile(k)
end)end


i.getCustomAsset=function(j, k)
k=j:getRealPath(k)
return getcustomasset(k)end


i.getData=function(j)
return table.clone(j.object)end


i.new=function(j, k)
d:expect(j,{"string"},"'fileSystem.new' #1")
d:expect(k,{"table","nil"},"'fileSystem.new' #2")

if j:sub(-5,-1)~=".json"then
j=j..".json"
end

local l=setmetatable({
object={},
lastSave=0,
isSaving=false,

encryptData=k and k.encrypt
},i)

local m=l:getRealPath(j)
local n=getFolderPath(m)

l.filePath=m
l.folderPath=n

if#n>0 then
makefolder(n)
end

local o=readfile(m)

if#o>0 then
if l.encryptData then
o=c:decrypt(o)
end

local p=e.decode(o)

if type(p)~="table"then
d:warn(`the json content has been returned a unexpected value '{m}'`)
return l
end

l.object=p
end

return l end


return i end a.j=function()local b=a.cache.j if not b then b={c=__modImpl()}a.cache.j=b end return b.c end end do local function __modImpl()
return a.j().new"settings"end a.k=function()local b=a.cache.k if not b then b={c=__modImpl()}a.cache.k=b end return b.c end end do local function __modImpl()
return"v0.0.6"end a.l=function()local b=a.cache.l if not b then b={c=__modImpl()}a.cache.l=b end return b.c end end do local function __modImpl()
return{
owner="tlredz",
repository="iy-remake"
}end a.m=function()local b=a.cache.m if not b then b={c=__modImpl()}a.cache.m=b end return b.c end end do local function __modImpl()
local b=a.m()

return{
discord="https://discord.gg/78ZuWSq",
github=`https://github.com/{b.owner}/{b.repository}`
}end a.n=function()local b=a.cache.n if not b then b={c=__modImpl()}a.cache.n=b end return b.c end end do local function __modImpl()


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

notifications={
defaultTime=10,
defaultTitle="Notification"
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
}end a.o=function()local b=a.cache.o if not b then b={c=__modImpl()}a.cache.o=b end return b.c end end do local function __modImpl()
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
}end a.p=function()local b=a.cache.p if not b then b={c=__modImpl()}a.cache.p=b end return b.c end end do local function __modImpl()
return{
action="console",
description="Opens the Roblox console",
run=function(b)
b.starterGui:SetCore("DevConsoleVisible",true)
end
}end a.q=function()local b=a.cache.q if not b then b={c=__modImpl()}a.cache.q=b end return b.c end end do local function __modImpl()
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
}end a.r=function()local b=a.cache.r if not b then b={c=__modImpl()}a.cache.r=b end return b.c end end do local function __modImpl()
return{
action="serverinfo|info",
description="Gives you info about the server",
run=function(b)
b.infiniteYield:createInfoMenu()
end
}end a.s=function()local b=a.cache.s if not b then b={c=__modImpl()}a.cache.s=b end return b.c end end do local function __modImpl()
local b={
kind="boolean",
name="copy",
optional=true
}


local function sendValue(c,d,e)
if e==false then
c:notify(d)
else
c.executorEnv.setclipboard(d)
end
end

return{
{
action="jobid",
description="Copies the games JobId to your clipboard, or notify",
args=b,
run=function(c,d)
local e=`roblox://placeId={game.PlaceId}&gameInstanceId={game.JobId}`
sendValue(c,e,d:nextValue())
end
},
{
action="placeid",
description="Copies the current place id to your clipboard, or notify",
args=b,
run=function(c,d)
sendValue(c,tostring(game.PlaceId),d:nextValue())
end
},
{
action="gameid",
description="Copies the current game id to your clipboard, or notify",
args=b,
run=function(c,d)
sendValue(c,tostring(game.GameId),d:nextValue())
end
}
}end a.t=function()local b=a.cache.t if not b then b={c=__modImpl()}a.cache.t=b end return b.c end end do local function __modImpl()

local function getOwnerId()
local b=game.CreatorId

if game.CreatorType~=Enum.CreatorType.User then
b=self.groupService:GetGroupInfoAsync(b).Owner.Id
end

return b
end

return{
{
action="creatorid",
description="Notify, or copies the creators ID to your clipboard",
args={kind="boolean",name="copy",optional=true},
run=function(b,c)
local d=tostring(getOwnerId())

if c:nextValue()then
b.executorEnv.setclipboard(d)
end

b:notify("Creator Id",`the OwnerId is '{d}'`)
end
},
{
client=true,
action="setcreatorid|setascreator",
description="Sets your userid to the creators ID",
run=function(b,c)
local d=getOwnerId()
b.localPlayer.UserId=d
b:notify("Set ID",`Set UserId to '{d}'`)
end
}
}end a.u=function()local b=a.cache.u if not b then b={c=__modImpl()}a.cache.u=b end return b.c end end do local function __modImpl()
return{
action="rejoin|rj",
description="Makes you rejoin the game",
run=function(b)
b.playerService:teleportToJobId(game.JobId)
end
}end a.v=function()local b=a.cache.v if not b then b={c=__modImpl()}a.cache.v=b end return b.c end end do local function __modImpl()
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
}end a.w=function()local b=a.cache.w if not b then b={c=__modImpl()}a.cache.w=b end return b.c end end do local function __modImpl()
return{
action="serverhop|shop",
description="Teleports you to a different server"
}end a.x=function()local b=a.cache.x if not b then b={c=__modImpl()}a.cache.x=b end return b.c end end do local function __modImpl()
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
}end a.y=function()local b=a.cache.y if not b then b={c=__modImpl()}a.cache.y=b end return b.c end end do local function __modImpl()
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
}end a.z=function()local b=a.cache.z if not b then b={c=__modImpl()}a.cache.z=b end return b.c end end do local function __modImpl()
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
}end a.A=function()local b=a.cache.A if not b then b={c=__modImpl()}a.cache.A=b end return b.c end end do local function __modImpl()
return{
action="datalimit",
description="Set outgoing KBPS limit",
args={kind="number",name="KB per second"},
run=function(b,c)
local d=c:nextValue()
b.networkClient:SetOutgoingKBPSLimit(d)
end
}end a.B=function()local b=a.cache.B if not b then b={c=__modImpl()}a.cache.B=b end return b.c end end do local function __modImpl()
return{
action="replicationlag|backtrack",
description="Set IncomingReplicationLag",
args={kind="number"},
run=function(b,c)
b.gameNetworkSettings.IncomingReplicationLag=c:nextValue()
end
}end a.C=function()local b=a.cache.C if not b then b={c=__modImpl()}a.cache.C=b end return b.c end end do local function __modImpl()
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
}end a.D=function()local b=a.cache.D if not b then b={c=__modImpl()}a.cache.D=b end return b.c end end do local function __modImpl()
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
}end a.E=function()local b=a.cache.E if not b then b={c=__modImpl()}a.cache.E=b end return b.c end end do local function __modImpl()
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
}end a.F=function()local b=a.cache.F if not b then b={c=__modImpl()}a.cache.F=b end return b.c end end do local function __modImpl()
local function unbind(b,c)
local d=b:collectGarbage(c)
if not d then return end

for e,f in d do
e.Visible=f
end

local e=b:registerGarbage"bindedHideGuis"
e[c]=nil
end

local function bind(b,c,d)
local e=b:registerGarbage"bindedHideGuis"

for f,g in e do
unbind(b,f)
end

e[c]=true

local f=b:createGarbage(c)
local g=b.localPlayer.PlayerGui

for h,i in g:GetDescendants()do
if i:IsA"GuiObject"and i.Visible~=d then
local j=i.Visible
i.Visible=d
f[i]=j
end
end
end

return{
{
action="showguis",
description="Shows any invisible GUIs",
run=function(b)
bind(b,"visibleGuiObjects",true)
end
},
{
action="unshowguis",
description="Undoes showguis",
run=function(b)
unbind(b,"visibleGuiObjects")
end
},
{
action="hideguis",
description="Hides any GUIs in PlayerGui",
run=function(b)
bind(b,"invisibleGuiObjects",false)
end
},
{
action="unhideguis",
description="Undoes hideguis",
run=function(b)
unbind(b,"invisibleGuiObjects")
end
}
}end a.G=function()local b=a.cache.G if not b then b={c=__modImpl()}a.cache.G=b end return b.c end end do local function __modImpl()
return{
{
action="hideiy|hideinterface",
description="Hides the main IY GUI"
},
{
action="showiy|unhideiy|unhideinterface",
description="Shows IY again"
}
}end a.H=function()local b=a.cache.H if not b then b={c=__modImpl()}a.cache.H=b end return b.c end end do local function __modImpl()
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
}end a.I=function()local b=a.cache.I if not b then b={c=__modImpl()}a.cache.I=b end return b.c end end do local function __modImpl()
local function tryDelete(b)
if not b:IsA"PackageLink"then return end

if b.Parent:FindFirstChild"ADpart"then
b.Parent:Destroy()
end

if b.Parent:FindFirstChild"AdGuiAdornee"then
b.Parent.Parent:Destroy()
end
end

return{
action="removeads|adblock",
description="Automatically removes ad billboards",
run=function(b)
if b.privateEnv.adBlockConn then return end

for c,d in workspace:GetDescendants()do
tryDelete(d)
end

b.privateEnv.adBlockConn=b:connect(workspace.DescendantAdded,function(c)
task.defer(tryDelete,c)
end)
end
}end a.J=function()local b=a.cache.J if not b then b={c=__modImpl()}a.cache.J=b end return b.c end end do local function __modImpl()
return{
action="saveinstance|savegame|saveplace|savep",
description="Uses saveinstance to save the game"
}end a.K=function()local b=a.cache.K if not b then b={c=__modImpl()}a.cache.K=b end return b.c end end do local function __modImpl()
return{
action="clearerror",
description="Clears the annoying box and blur when a game kicks you"
}end a.L=function()local b=a.cache.L if not b then b={c=__modImpl()}a.cache.L=b end return b.c end end do local function __modImpl()
return{
{
action="antigameplaypaused",
description="Clears the annoying box shown when a game is loading assets due to network lag"
},
{
action="unantigameplaypaused",
description="Disables antigameplaypaused"
}
}end a.M=function()local b=a.cache.M if not b then b={c=__modImpl()}a.cache.M=b end return b.c end end do local function __modImpl()
return{
action="clientantikick|antikick",
description="Prevents localscripts from kicking you (CLIENT)"
}end a.N=function()local b=a.cache.N if not b then b={c=__modImpl()}a.cache.N=b end return b.c end end do local function __modImpl()
return{
action="clientantiteleport|antiteleport",
description="Prevents localscripts from teleporting you (CLIENT)"
}end a.O=function()local b=a.cache.O if not b then b={c=__modImpl()}a.cache.O=b end return b.c end end do local function __modImpl()
return{
cliemt=true,
action="allowrejoin|allowrj",
description="Changes if antiteleport allows you to rejoin or not",
args={kind="boolean"},
run=function(b,c)
b.datas.settings:setValue("allowRejoin",args:nextValue())
end
}end a.P=function()local b=a.cache.P if not b then b={c=__modImpl()}a.cache.P=b end return b.c end end do local function __modImpl()
return{
action="cancelteleport|canceltp",
description="Cancels teleports in progress",
run=function(b)
b.teleportService:TeleportCancel()
end
}end a.Q=function()local b=a.cache.Q if not b then b={c=__modImpl()}a.cache.Q=b end return b.c end end do local function __modImpl()
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
}end a.R=function()local b=a.cache.R if not b then b={c=__modImpl()}a.cache.R=b end return b.c end end do local function __modImpl()
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
}

local function optimizeGame(d)
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
end)
end

return{
action="antilag|boostfps|lowgraphics",
description="Lowers game quality to boost FPS",
run=function(d)
if d.privateEnv.antiLagEnabled then
d:notify"anti lag is already enabled"
return
end

d.privateEnv.antiLagEnabled=true
optimizeGame(d)
end
}end a.S=function()local b=a.cache.S if not b then b={c=__modImpl()}a.cache.S=b end return b.c end end do local function __modImpl()
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
}end a.T=function()local b=a.cache.T if not b then b={c=__modImpl()}a.cache.T=b end return b.c end end do local function __modImpl()
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
}end a.U=function()local b=a.cache.U if not b then b={c=__modImpl()}a.cache.U=b end return b.c end end do local function __modImpl()
return{
action="lastcommand|lastcmd",
description="Executes the previous command used"
}end a.V=function()local b=a.cache.V if not b then b={c=__modImpl()}a.cache.V=b end return b.c end end do local function __modImpl()
return{
action="notifyping|ping",
description="Notify yourself your ping",
run=function(b)
local c=b.localPlayer:GetNetworkPing()
b:notify("Ping",`{math.round(c*1000)}ms`)
end
}end a.W=function()local b=a.cache.W if not b then b={c=__modImpl()}a.cache.W=b end return b.c end end do local function __modImpl()
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
}end a.X=function()local b=a.cache.X if not b then b={c=__modImpl()}a.cache.X=b end return b.c end end do local function __modImpl()
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
}end a.Y=function()local b=a.cache.Y if not b then b={c=__modImpl()}a.cache.Y=b end return b.c end end do local function __modImpl()
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
}end a.Z=function()local b=a.cache.Z if not b then b={c=__modImpl()}a.cache.Z=b end return b.c end end do local function __modImpl()
local function setShiftKey(b,c)
local d=b.localPlayer.PlayerScripts
local e=d.PlayerModule.CameraModule.MouseLockController
local f=e:FindFirstChild"BoundKeys"

if not f then
f=Instance.new("StringValue",e)
f.Name="BoundKeys"
end

f.Value=c
end

return{
{
action="ctrllock",
description="Binds Shiftlock to LeftControl",
run=function(b)
setShiftKey(b,"LeftControl")
end
},
{
action="unctrllock",
description="Re-binds Shiftlock to LeftShift",
run=function(b)
setShiftKey(b,"LeftShift")
end
}
}end a._=function()local b=a.cache._ if not b then b={c=__modImpl()}a.cache._=b end return b.c end end do local function __modImpl()
return{
action="exit",
description="Kills roblox process",
run=function()
game:shutdown()
end
}end a.aa=function()local b=a.cache.aa if not b then b={c=__modImpl()}a.cache.aa=b end return b.c end end do local function __modImpl()


return{
action="notifyjobid",
description="Notifies the JobId and PlaceId of the current server",
run=function(b)
b:notify("JobId / PlaceId",`{game.JobId} / {game.PlaceId}`)
end
}end a.ab=function()local b=a.cache.ab if not b then b={c=__modImpl()}a.cache.ab=b end return b.c end end do local function __modImpl()

local b=a.g()
return b.Players.LocalPlayer end a.ac=function()local b=a.cache.ac if not b then b={c=__modImpl()}a.cache.ac=b end return b.c end end do local function __modImpl()
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











































































return g end a.ad=function()local b=a.cache.ad if not b then b={c=__modImpl()}a.cache.ad=b end return b.c end end do local function __modImpl()
local b=a.g()
local c=a.ad()
local d=a.ac()





local function shuffle(e)
for f=#e,2,-1 do
local g=math.random(1,f)
e[f],e[g]=e[g],e[f]
end
return e
end

local function resolvePlayers(e)
local f=(e or"me"):lower()
local g=b.Players:GetPlayers()

if f=="me"then
return{d}
elseif f=="all"then
return g
elseif f=="others"then
local h={}
for i,j in g do
if j~=d then
table.insert(h,j)
end
end
return h
elseif f=="random"then
return{g[math.random(1,#g)]}
end

local h=tonumber(f:match"^#(%d+)$")
if h then
return table.move(shuffle(g),1,math.min(h,#g),1,{})
end

return c:getPlayersByName(e)
end

return resolvePlayers end a.ae=function()local b=a.cache.ae if not b then b={c=__modImpl()}a.cache.ae=b end return b.c end end do local function __modImpl()

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
}end a.af=function()local b=a.cache.af if not b then b={c=__modImpl()}a.cache.af=b end return b.c end end do local function __modImpl()

local b={inventory=
Enum.CoreGuiType.Backpack,leaderboard=
Enum.CoreGuiType.PlayerList,emotes=
Enum.CoreGuiType.EmotesMenu
}

for c,d in Enum.CoreGuiType:GetEnumItems()do
b[string.lower(d.Name)]=d
end

local function setCoreGui(c,d,e)
if d=="reset"then
c.starterGui:SetCore("ResetButtonCallback",e)
return
end

local f=b[d]
if f then
c.starterGui:SetCoreGuiEnabled(f,e)
end
end

return{
{
action="enable",
description="Enables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
args={kind="string",name="gui name"},
run=function(c,d)
setCoreGui(c,d:nextValue():lower(),true)
end
},
{
action="disable",
description="Disables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
args={kind="string",name="gui name"},
run=function(c,d)
setCoreGui(c,d:nextValue():lower(),false)
end
}
}end a.ag=function()local b=a.cache.ag if not b then b={c=__modImpl()}a.cache.ag=b end return b.c end end do local function __modImpl()

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
}end a.ah=function()local b=a.cache.ah if not b then b={c=__modImpl()}a.cache.ah=b end return b.c end end do local function __modImpl()

return{
action="mousesensitivity|ms",
description="Sets your mouse delta sensitivity",
args={kind="number",name="sensitivity"},
run=function(b,c)
b.robloxServices.UserInputService.MouseDeltaSensitivity=c:nextValue()
end
}end a.ai=function()local b=a.cache.ai if not b then b={c=__modImpl()}a.cache.ai=b end return b.c end end do local function __modImpl()

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
}end a.aj=function()local b=a.cache.aj if not b then b={c=__modImpl()}a.cache.aj=b end return b.c end end do local function __modImpl()


local function respawn(b)
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
f:Destroy()
end

return{
{
action="respawn",
description="Respawns your character in place (client side)",
run=function(b)
respawn(b)
end
},
{
action="refresh|re",
description="Respawns your character and puts you back where you were",
run=function(b)
local c=b.playerService:getRootPart()
if not c then return end

local d=b.localPlayer
local e=c.CFrame
local f=workspace.CurrentCamera.CFrame

respawn(b)

task.spawn(function()
local g=d.CharacterAdded:Wait()
local h=g:WaitForChild("HumanoidRootPart",10)
if not h then return end

h.CFrame=e
workspace.CurrentCamera.CFrame=f
end)
end
},
{
action="reset",
description="Resets your character",
run=function(b)
b.playerService:resetCharacter()
end
}
}end a.ak=function()local b=a.cache.ak if not b then b={c=__modImpl()}a.cache.ak=b end return b.c end end do local function __modImpl()

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
}end a.al=function()local b=a.cache.al if not b then b={c=__modImpl()}a.cache.al=b end return b.c end end do local function __modImpl()

return{
{
action="team",
description="Changes your team. Sometimes fools localscripts. (CLIENT)",
args={
kind="team"
}
}
}end a.am=function()local b=a.cache.am if not b then b={c=__modImpl()}a.cache.am=b end return b.c end end do local function __modImpl()

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
}end a.an=function()local b=a.cache.an if not b then b={c=__modImpl()}a.cache.an=b end return b.c end end do local function __modImpl()

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
}end a.ao=function()local b=a.cache.ao if not b then b={c=__modImpl()}a.cache.ao=b end return b.c end end do local function __modImpl()

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
}end a.ap=function()local b=a.cache.ap if not b then b={c=__modImpl()}a.cache.ap=b end return b.c end end do local function __modImpl()

return{
{
action="clickdelete",
description="Go to Settings > Keybinds > Add for click delete"
},
{
action="clickteleport",
description="Go to Settings > Keybinds > Add for click teleport"
}
}end a.aq=function()local b=a.cache.aq if not b then b={c=__modImpl()}a.cache.aq=b end return b.c end end do local function __modImpl()

return{
{
action="promptr6",
description="Prompts the game to switch your rig type to R6"
},
{
action="promptr15",
description="Prompts the game to switch your rig type to R15"
}
}end a.ar=function()local b=a.cache.ar if not b then b={c=__modImpl()}a.cache.ar=b end return b.c end end do local function __modImpl()

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

}end a.as=function()local b=a.cache.as if not b then b={c=__modImpl()}a.cache.as=b end return b.c end end do local function __modImpl()

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
}end a.at=function()local b=a.cache.at if not b then b={c=__modImpl()}a.cache.at=b end return b.c end end do local function __modImpl()
return{
{
action="noclip",
description="Go through objects"
},
{
action="unnoclip|clip",
description="Disables noclip"
}
}end a.au=function()local b=a.cache.au if not b then b={c=__modImpl()}a.cache.au=b end return b.c end end do local function __modImpl()
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
}end a.av=function()local b=a.cache.av if not b then b={c=__modImpl()}a.cache.av=b end return b.c end end do local function __modImpl()
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
}end a.aw=function()local b=a.cache.aw if not b then b={c=__modImpl()}a.cache.aw=b end return b.c end end do local function __modImpl()
return{
action="qefly",
description="Enables or disables the Q and E hotkeys for fly",
args={
kind="boolean"
}
}end a.ax=function()local b=a.cache.ax if not b then b={c=__modImpl()}a.cache.ax=b end return b.c end end do local function __modImpl()
return{
{
action="vehiclenoclip|vnoclip",
description="Turns off vehicle collision"
},
{
action="vehicleclip|vclip|unvnoclip",
description="Enables vehicle collision"
},
}end a.ay=function()local b=a.cache.ay if not b then b={c=__modImpl()}a.cache.ay=b end return b.c end end do local function __modImpl()
return{
{
action="float|platform",
description="Spawns a platform beneath you causing you to float"
},
{
action="unfloat|noplatform",
description="Removes the platform"
}
}end a.az=function()local b=a.cache.az if not b then b={c=__modImpl()}a.cache.az=b end return b.c end end do local function __modImpl()
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
}end a.aA=function()local b=a.cache.aA if not b then b={c=__modImpl()}a.cache.aA=b end return b.c end end do local function __modImpl()
local function setHumanoidProperty(b,c,d)
local e=b.playerService:getHumanoid()
if e then
e[c]=d
end
end

local function humanoidToggle(b,c,d,e)
return{
action=b,
description=c,
run=function(f)
setHumanoidProperty(f,d,e)
end
}
end

return{
{
action="speed|ws|walkspeed",
description="Sets your walk speed (default is 16)",
args={kind="number",name="walk speed",optional=true},
run=function(b,c)
setHumanoidProperty(b,"WalkSpeed",c:nextValue()or 16)
end
},
{
action="jpower|jumppower|jp",
description="Sets your jump power (default is 50)",
args={kind="number",name="jump power",optional=true},
run=function(b,c)
local d=b.playerService:getHumanoid()
if not d then return end

local e=c:nextValue()or 50
if d.UseJumpPower then
d.JumpPower=e
else
d.JumpHeight=e
end
end
},
{
action="maxslopeangle|msa",
description="Sets the max slope angle your humanoid can walk up (default is 89)",
args={kind="number",name="angle",optional=true},
run=function(b,c)
setHumanoidProperty(b,"MaxSlopeAngle",c:nextValue()or 89)
end
},
{
action="hipheight|hheight",
description="Sets your hip height (default depends on your rig)",
args={kind="number",name="hip height",optional=true},
run=function(b,c)
local d=b.playerService:getHumanoid()
if not d then return end

local e=d.RigType==Enum.HumanoidRigType.R15
d.HipHeight=c:nextValue()or(e and 2.1 or 0)
end
},
humanoidToggle("stun|platformstand","Makes your character stiff (PlatformStand)","PlatformStand",true),
humanoidToggle("unstun|nostun|unplatformstand|noplatformstand","Disables stun","PlatformStand",false),
humanoidToggle("norotate|noautorotate","Stops your character from auto rotating","AutoRotate",false),
humanoidToggle("unnorotate|autorotate","Lets your character auto rotate again","AutoRotate",true),
{
action="trip",
description="Trips your character forward",
run=function(b)
local c=b.playerService:getHumanoid()
local d=b.playerService:getRootPart()
if not(c and d)then return end

c:ChangeState(Enum.HumanoidStateType.FallingDown)
d.AssemblyLinearVelocity=d.CFrame.LookVector*30
end
},
{
action="breakvelocity",
description="Stops the character's movement for one second",
run=function(b)
local c=b.localPlayer.Character
if not c then return end

local d=os.clock()
task.spawn(function()
while os.clock()-d<1 do
for e,f in c:GetDescendants()do
if f:IsA"BasePart"then
f.AssemblyLinearVelocity=Vector3.zero
f.AssemblyAngularVelocity=Vector3.zero
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
run=function(b)
local c=b.localPlayer.Character
if not c then return end

local d={
"BodyVelocity","BodyGyro","RocketPropulsion","BodyThrust",
"BodyAngularVelocity","AngularVelocity","BodyForce","VectorForce","LineForce"
}

for e,f in c:GetDescendants()do
for g,h in d do
if f:IsA(h)then
f:Destroy()
break
end
end
end
end
}
}end a.aB=function()local b=a.cache.aB if not b then b={c=__modImpl()}a.cache.aB=b end return b.c end end do local function __modImpl()

local function startJumpLoop(b,c,d)
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
end)
end

local function stopJumpLoop(b,c)
local d=b:collectGarbage(c)
if d and d.connection then
d.connection:Disconnect()
end
end

local function setHumanoidState(b,c,d)
local e=b.playerService:getHumanoid()
local f,g=pcall(function()
return Enum.HumanoidStateType[c]
end)

if not f then
b:notify("Invalid state",`{c} is not a HumanoidStateType`)
return
end

if e then
e:SetStateEnabled(g,d)
end
end

return{
{
action="sit",
description="Makes your character sit",
run=function(b)
local c=b.playerService:getHumanoid()
if c then
c.Sit=true
end
end
},
{
action="nosit",
description="Stops your character from being able to sit",
run=function(b)
setHumanoidState(b,"Seated",false)
end
},
{
action="unnosit",
description="Lets your character sit again",
run=function(b)
setHumanoidState(b,"Seated",true)
end
},
{
action="enablestate",
description="Enables a humanoid state (example: Jumping)",
args={kind="string",name="state name"},
run=function(b,c)
setHumanoidState(b,c:nextValue(),true)
end
},
{
action="disablestate",
description="Disables a humanoid state (example: Jumping)",
args={kind="string",name="state name"},
run=function(b,c)
setHumanoidState(b,c:nextValue(),false)
end
},
{
action="lay|laydown",
description="Lays your character down",
run=function(b)
local c=b.playerService:getHumanoid()
local d=b.playerService:getRootPart()
if not(c and d)then return end

c.Sit=true
task.wait(0.1)

d=b.playerService:getRootPart()
if not d then return end
d.CFrame=d.CFrame*CFrame.Angles(math.pi*0.5,0,0)

for e,f in c:GetPlayingAnimationTracks()do
f:Stop()
end
end
},
{
action="jump",
description="Makes your character jump once",
run=function(b)
local c=b.playerService:getHumanoid()
if c then
c:ChangeState(Enum.HumanoidStateType.Jumping)
end
end
},
{
action="infjump|infinitejump",
description="Lets you jump again while in the air",
run=function(b)
startJumpLoop(b,"infjump",true)
end
},
{
action="uninfjump|uninfinitejump|noinfjump|noinfinitejump",
description="Disables infinite jump",
run=function(b)
stopJumpLoop(b,"infjump")
end
},
{
action="flyjump",
description="Makes you jump every time a jump is requested",
run=function(b)
startJumpLoop(b,"flyjump",false)
end
},
{
action="unflyjump|noflyjump",
description="Disables flyjump",
run=function(b)
stopJumpLoop(b,"flyjump")
end
},
{
action="nilchar",
description="Removes your character from the workspace (client side)",
run=function(b)
local c=b.localPlayer.Character
if c then
c.Parent=nil
end
end
},
{
action="unnilchar|nonilchar",
description="Puts your character back into the workspace",
run=function(b)
local c=b.localPlayer.Character
if c then
c.Parent=workspace
end
end
}
}end a.aC=function()local b=a.cache.aC if not b then b={c=__modImpl()}a.cache.aC=b end return b.c end end do local function __modImpl()


local function destroyWhere(b,c)
if not b then return end

for d,e in b:GetDescendants()do
if c(e)then
e:Destroy()
end
end
end

local function getCharacter(b)
return b.localPlayer.Character
end

local function getAccessories(b)
local c=b.playerService:getHumanoid()
return c and c:GetAccessories()or{}
end

local function isSpecialMesh(b)
return b:IsA"SpecialMesh"
end

return{
{
action="blockhead",
description="Removes the mesh from your head (makes it block-like)",
run=function(b)
local c=getCharacter(b)
local d=c and c:FindFirstChild"Head"
local e=d and d:FindFirstChildOfClass"SpecialMesh"
if e then
e:Destroy()
end
end
},
{
action="blockhats",
description="Removes the meshes from your accessories",
run=function(b)
for c,d in getAccessories(b)do
destroyWhere(d,isSpecialMesh)
end
end
},
{
action="blocktool",
description="Removes the meshes from your equipped tools",
run=function(b)
local c=getCharacter(b)
if not c then return end

for d,e in c:GetChildren()do
if e:IsA"Tool"or e:IsA"HopperBin"then
destroyWhere(e,isSpecialMesh)
end
end
end
},
{
action="nobgui|unbgui|nobillboardgui|unbillboardgui|noname|rohg",
description="Removes BillboardGuis and SurfaceGuis from your character",
run=function(b)
destroyWhere(getCharacter(b),function(c)
return c:IsA"BillboardGui"or c:IsA"SurfaceGui"
end)
end
},
{
action="naked",
description="Removes your clothing and shirt graphics",
run=function(b)
destroyWhere(getCharacter(b),function(c)
return c:IsA"Clothing"or c:IsA"ShirtGraphic"
end)
end
},
{
action="noface|removeface",
description="Removes your face decal",
run=function(b)
destroyWhere(getCharacter(b),function(c)
return c:IsA"Decal"and c.Name=="face"
end)
end
},
{
action="deletehats|nohats|rhats",
description="Removes the welds that hold your accessories on",
run=function(b)
destroyWhere(getCharacter(b),function(c)
return c:IsA"Weld"and c:FindFirstAncestorWhichIsA"Accessory"~=nil
end)
end
},
{
action="drophats|drophat",
description="Drops your accessories into the workspace",
run=function(b)
for c,d in getAccessories(b)do
d.Parent=workspace
end
end
},
{
action="clearcharappearance|clearchar|clrchar",
description="Clears your character appearance",
run=function(b)
b.localPlayer:ClearCharacterAppearance()
end
},
{
action="split",
description="Splits your R15 character in half (removes the waist)",
run=function(b)
local c=getCharacter(b)
local d=b.playerService:getHumanoid()
if not(c and d)then return end

if d.RigType~=Enum.HumanoidRigType.R15 then
b:notify("R15 Required","This command requires the R15 rig type")
return
end

local e=c:FindFirstChild"UpperTorso"
local f=e and e:FindFirstChild"Waist"
if f then
f:Destroy()
end
end
}
}end a.aD=function()local b=a.cache.aD if not b then b={c=__modImpl()}a.cache.aD=b end return b.c end end do local function __modImpl()

local b=a.ae()

local function isTool(c)
return c:IsA"Tool"or c:IsA"HopperBin"
end

local function destroyTools(c)
if not c then return end

for d,e in c:GetDescendants()do
if isTool(e)then
e:Destroy()
end
end
end

return{
{
action="notools|rtools|clrtools|removetools|deletetools|dtools",
description="Deletes every tool in your backpack and character",
run=function(c)
destroyTools(c.localPlayer:FindFirstChildOfClass"Backpack")
destroyTools(c.localPlayer.Character)
end
},
{
action="deleteselectedtool|dst",
description="Deletes the tools you are currently holding",
run=function(c)
destroyTools(c.localPlayer.Character)
end
},
{
action="equiptools",
description="Equips every tool in your backpack",
run=function(c)
local d=c.localPlayer:FindFirstChildOfClass"Backpack"
local e=c.localPlayer.Character
if not(d and e)then return end

for f,g in d:GetChildren()do
if isTool(g)then
g.Parent=e
end
end
end
},
{
action="unequiptools",
description="Unequips all your tools",
run=function(c)
local d=c.playerService:getHumanoid()
if d then
d:UnequipTools()
end
end
},
{
action="droptools|droptool",
description="Drops every tool from your backpack to the workspace",
run=function(c)
local d=c.localPlayer:FindFirstChildOfClass"Backpack"
local e=c.localPlayer.Character
if not(d and e)then return end

for f,g in d:GetChildren()do
if isTool(g)then
g.Parent=e
end
end

task.wait()

for f,g in e:GetChildren()do
if isTool(g)then
g.Parent=workspace
end
end
end
},
{
action="copytools",
description="Copies the tools from a player's backpack into yours",
args={kind="player"},
run=function(c,d)
local e=c.localPlayer:FindFirstChildOfClass"Backpack"
if not e then return end

for f,g in b(d:nextValue())do
local h=g:FindFirstChildOfClass"Backpack"
if h then
for i,j in h:GetChildren()do
if isTool(j)then
local k=j:Clone()
k.Parent=e
end
end
end
end
end
}
}end a.aE=function()local b=a.cache.aE if not b then b={c=__modImpl()}a.cache.aE=b end return b.c end end do local function __modImpl()

local b={
"27789359","30196114","248263260","45834924","33796059","28488254","52155728"
}

local c={
"3333432454","4555808220","4049037604","4555782893","10214311282",
"10714010337","10713981723","10714372526","10714076981","10714392151","11444443576"
}

local function stopTracks(d)
for e,f in d:GetPlayingAnimationTracks()do
f:Stop()
end
end

local function setAnimateDisabled(d,e)
local f=d.localPlayer.Character
local g=f and f:FindFirstChild"Animate"
if g then
g.Disabled=e
end
end

local function refreshAnimations(d)
local e=d.playerService:getHumanoid()
local f=d.localPlayer.Character
local g=f and f:FindFirstChild"Animate"

if not(e and g)then
d:notify("Refresh Animations","Failed to get Animate/Humanoid")
return
end

g.Disabled=true
stopTracks(e)
g.Disabled=false
end

local function stopDance(d)
local e=d:collectGarbage"dance"
if e and e.track then
e.track:Stop()
e.track:Destroy()
end
end

local function setCustomAnimations(d,e)
d.robloxServices.StarterPlayer.AllowCustomAnimations=e
refreshAnimations(d)
end

return{
{
action="animation|anim",
description="Plays an animation by its asset ID (optional speed)",
args={
{kind="string",name="animation id"},
{kind="number",name="speed",optional=true}
},
run=function(d,e)
local f=d.playerService:getHumanoid()
if not f then return end

local g=tostring(e:nextValue())
local h=e:nextValue()
if not g:find"rbxassetid://"then
g="rbxassetid://"..g
end

local i=Instance.new"Animation"
i.AnimationId=g

local j=f:LoadAnimation(i)
j.Priority=Enum.AnimationPriority.Movement
j:Play()

if h then
j:AdjustSpeed(h)
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
run=function(d,e)
local f=d.playerService:getHumanoid()
if not f then return end

local g=f:PlayEmoteAndGetAnimTrackById(e:nextValue())
local h=e:nextValue()
if g and h then
g:AdjustSpeed(h)
end
end
},
{
action="noanim",
description="Disables the default Roblox animations",
run=function(d)
setAnimateDisabled(d,true)
end
},
{
action="reanim",
description="Enables the default Roblox animations again",
run=function(d)
setAnimateDisabled(d,false)
end
},
{
action="animspeed",
description="Sets the speed of every playing animation (default is 1)",
args={kind="number",name="speed",optional=true},
run=function(d,e)
local f=d.playerService:getHumanoid()
if not f then return end

local g=e:nextValue()or 1
for h,i in f:GetPlayingAnimationTracks()do
i:AdjustSpeed(g)
end
end
},
{
action="stopanimations|stopanims|stopanim",
description="Stops every playing animation",
run=function(d)
local e=d.playerService:getHumanoid()
if e then
stopTracks(e)
end
end
},
{
action="refreshanimations|refreshanimation|refreshanims|refreshanim",
description="Restarts your character's default animations",
run=function(d)
refreshAnimations(d)
end
},
{
action="allowcustomanim|allowcustomanimations",
description="Allows custom animations on your character",
run=function(d)
setCustomAnimations(d,true)
end
},
{
action="unallowcustomanim|unallowcustomanimations",
description="Stops custom animations on your character",
run=function(d)
setCustomAnimations(d,false)
end
},
{
action="loopanimation|loopanim",
description="Makes the animations that are currently playing loop",
run=function(d)
local e=d.playerService:getHumanoid()
if not e then return end

for f,g in e:GetPlayingAnimationTracks()do
g.Looped=true
end
end
},
{
action="dance",
description="Plays a random dance on a loop",
run=function(d)
local e=d.playerService:getHumanoid()
if not e then return end

stopDance(d)

local f=e.RigType==Enum.HumanoidRigType.R15 and c or b
local g=Instance.new"Animation"
g.AnimationId="rbxassetid://"..f[math.random(1,#f)]

local h=e:LoadAnimation(g)
h.Looped=true
h:Play()

d:registerGarbage"dance".track=h
end
},
{
action="undance|nodance",
description="Stops the dance",
run=function(d)
stopDance(d)
end
}
}end a.aF=function()local b=a.cache.aF if not b then b={c=__modImpl()}a.cache.aF=b end return b.c end end do local function __modImpl()

local function setDensity(b,c)
local d=b.localPlayer.Character
if not d then return end

for e,f in d:GetDescendants()do
if f:IsA"BasePart"then
f.CustomPhysicalProperties=PhysicalProperties.new(c,0.3,0.5)
end
end
end

return{
{
action="strengthen",
description="Makes your body parts heavier (default is 100)",
args={kind="number",name="density",optional=true},
run=function(b,c)
setDensity(b,c:nextValue()or 100)
end
},
{
action="weaken",
description="Makes your body parts lighter (default is 0)",
args={kind="number",name="density",optional=true},
run=function(b,c)
setDensity(b,-(c:nextValue()or 0))
end
},
{
action="unweaken|unstrengthen",
description="Resets your body parts' density",
run=function(b)
setDensity(b,0.7)
end
}
}end a.aG=function()local b=a.cache.aG if not b then b={c=__modImpl()}a.cache.aG=b end return b.c end end do local function __modImpl()


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
}end a.aH=function()local b=a.cache.aH if not b then b={c=__modImpl()}a.cache.aH=b end return b.c end end do local function __modImpl()

local function stopSpasm(b)
local c=b:collectGarbage"spasm"
if c and c.track then
c.track:Stop()
c.track:Destroy()
end
end

local function removeSpinners(b)
for c,d in b:GetChildren()do
if d.Name=="Spinning"then
d:Destroy()
end
end
end

return{
{
action="spasm",
description="Makes your R6 character spasm (uses an animation)",
run=function(b)
local c=b.playerService:getHumanoid()
if not c then return end

if c.RigType==Enum.HumanoidRigType.R15 then
b:notify("R6 Required","This command requires the r6 rig type")
return
end

stopSpasm(b)

local d=Instance.new"Animation"
d.AnimationId="rbxassetid://33796059"

local e=c:LoadAnimation(d)
e:Play()
e:AdjustSpeed(99)

b:registerGarbage"spasm".track=e
end
},
{
action="unspasm|nospasm",
description="Stops the spasm",
run=function(b)
stopSpasm(b)
end
},
{
action="headthrow",
description="Throws your R6 character's head (uses an animation)",
run=function(b)
local c=b.playerService:getHumanoid()
if not c then return end

if c.RigType==Enum.HumanoidRigType.R15 then
b:notify("R6 Required","This command requires the r6 rig type")
return
end

local d=Instance.new"Animation"
d.AnimationId="rbxassetid://35154961"

local e=c:LoadAnimation(d)
e:Play(0)
e:AdjustSpeed(1)
end
},
{
action="sitwalk",
description="Uses the sit animation while walking, running and jumping",
run=function(b)
local c=b.localPlayer.Character
local d=b.playerService:getHumanoid()
local e=c and c:FindFirstChild"Animate"
if not(d and e)then return end

local f=e:FindFirstChild"sit"
local g=f and f:FindFirstChildWhichIsA"Animation"
if not g then return end

for h,i in{"idle","walk","run","jump"}do
local j=e:FindFirstChild(i)
local k=j and j:FindFirstChildWhichIsA"Animation"
if k then
k.AnimationId=g.AnimationId
end
end

d.HipHeight=d.RigType==Enum.HumanoidRigType.R15 and 0.5 or-1.5
end
},
{
action="spin",
description="Spins your character (default speed is 20)",
args={kind="number",name="spin speed",optional=true},
run=function(b,c)
local d=b.playerService:getRootPart()
if not d then return end

removeSpinners(d)

local e=Instance.new"BodyAngularVelocity"
e.Name="Spinning"
e.MaxTorque=Vector3.new(0,math.huge,0)
e.AngularVelocity=Vector3.new(0,c:nextValue()or 20,0)
e.Parent=d
end
},
{
action="unspin",
description="Stops spinning your character",
run=function(b)
local c=b.playerService:getRootPart()
if c then
removeSpinners(c)
end
end
}
}end a.aI=function()local b=a.cache.aI if not b then b={c=__modImpl()}a.cache.aI=b end return b.c end end do local function __modImpl()

local function isGui(b)
return b:IsA"BillboardGui"or b:IsA"SurfaceGui"
end

local function destroyNamedChildren(b,c)
for d,e in c do
local f=b:FindFirstChild(e)
if f then
f:Destroy()
end
end
end

return{
{
action="creeper",
description="Gives your character a creeper look (removes the face mesh, arms and accessories)",
run=function(b)
local c=b.localPlayer.Character
local d=b.playerService:getHumanoid()
if not(c and d)then return end

local e=c:FindFirstChild"Head"
local f=e and e:FindFirstChildOfClass"SpecialMesh"
if f then
f:Destroy()
end

if d.RigType==Enum.HumanoidRigType.R15 then
destroyNamedChildren(c,{"LeftUpperArm","RightUpperArm"})
else
destroyNamedChildren(c,{"Left Arm","Right Arm"})
end

d:RemoveAccessories()
end
},
{
action="chardelete|charremove|cd",
description="Deletes every part of your character with the given name",
args={kind="string",name="item name"},
run=function(b,c)
local d=b.localPlayer.Character
local e=c:nextValue()or""
if not d then return end

for f,g in d:GetDescendants()do
if g.Name:lower()==e:lower()then
g:Destroy()
end
end

b:notify("Item(s) Deleted",`Deleted {e}`)
end
},
{
action="chardeleteclass|charremoveclass|chardeleteclassname|charremoveclassname|cdc",
description="Deletes every part of your character with the given class name",
args={kind="className",name="class name"},
run=function(b,c)
local d=b.localPlayer.Character
local e=c:nextValue()or""
if not d then return end

for f,g in d:GetDescendants()do
if g.ClassName:lower()==e:lower()then
g:Destroy()
end
end

b:notify("Item(s) Deleted",`Deleted items with ClassName {e}`)
end
},
{
action="loopnobgui|loopunbgui|loopnobillboardgui|loopunbillboardgui|loopnoname|looprohg",
description="Removes BillboardGuis and SurfaceGuis from your character, including new ones",
run=function(b)
local c=b.localPlayer.Character
if not c then return end

local d=b:collectGarbage"nobgui"
if d and d.connection then
d.connection:Disconnect()
end

for e,f in c:GetDescendants()do
if isGui(f)then
f:Destroy()
end
end

local e=b:createGarbage"nobgui"
e.connection=b:connect(c.DescendantAdded,function(f)
if isGui(f)then
task.wait()
f:Destroy()
end
end)
end
},
{
action="unloopnobgui|unloopunbgui|unloopnobillboardgui|unloopunbillboardgui|unloopnoname|unlooprohg",
description="Stops removing BillboardGuis and SurfaceGuis from your character",
run=function(b)
local c=b:collectGarbage"nobgui"
if c and c.connection then
c.connection:Disconnect()
end
end
}
}end a.aJ=function()local b=a.cache.aJ if not b then b={c=__modImpl()}a.cache.aJ=b end return b.c end end do local function __modImpl()

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
}end a.aK=function()local b=a.cache.aK if not b then b={c=__modImpl()}a.cache.aK=b end return b.c end end do local function __modImpl()




local function getFilter(b)
local c=b:registerGarbage"removespecifictool"
c.connections=c.connections or{}
return c
end

return{
{
action="removespecifictool",
description="Keeps removing tools with the given name from your backpack",
args={kind="string",name="tool name"},
run=function(b,c)
local d=(c:nextValue()or""):lower()
local e=getFilter(b)
if e.connections[d]then return end

e.connections[d]=b:connect(b.runService.RenderStepped,function()
local f=b.localPlayer:FindFirstChildOfClass"Backpack"
if not f then return end

for g,h in f:GetChildren()do
if h.Name:lower()==d then
h:Destroy()
end
end
end)
end
},
{
action="unremovespecifictool",
description="Stops removing tools with the given name",
args={kind="string",name="tool name"},
run=function(b,c)
local d=(c:nextValue()or""):lower()
local e=b:getGarbage"removespecifictool"
local f=e and e.connections and e.connections[d]

if f then
f:Disconnect()
e.connections[d]=nil
end
end
},
{
action="clearremovespecifictool",
description="Stops removing every tool that is being filtered",
run=function(b)
local c=b:collectGarbage"removespecifictool"
if not(c and c.connections)then return end

for d,e in c.connections do
e:Disconnect()
end
end
}
}end a.aL=function()local b=a.cache.aL if not b then b={c=__modImpl()}a.cache.aL=b end return b.c end end do local function __modImpl()

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
}end a.aM=function()local b=a.cache.aM if not b then b={c=__modImpl()}a.cache.aM=b end return b.c end end do local function __modImpl()

local function applyWalkSpeed(b,c)
b.WalkSpeed=c
end

local function applyJumpPower(b,c)
if b.UseJumpPower then
b.JumpPower=c
else
b.JumpHeight=c
end
end

local function stopLoop(b,c)
local d=b:collectGarbage(c)
if d and d.connections then
for e,f in d.connections do
f:Disconnect()
end
end
end


local function startLoop(b,c,d,e,f)
stopLoop(b,c)

local g=b:createGarbage(c)
g.connections={}

local function watch(h)
e(h,f)
table.insert(g.connections,b:connect(h:GetPropertyChangedSignal(d),function()
e(h,f)
end))
end

local h=b.playerService:getHumanoid()
if h then
watch(h)
end

table.insert(g.connections,b:connect(b.localPlayer.CharacterAdded,function(i)
watch(i:WaitForChild"Humanoid")
end))
end

return{
{
action="loopspeed|loopws",
description="Keeps your walk speed set, even after respawning (default is 16)",
args={kind="number",name="walk speed",optional=true},
run=function(b,c)
startLoop(b,"loopspeed","WalkSpeed",applyWalkSpeed,c:nextValue()or 16)
end
},
{
action="unloopspeed|unloopws",
description="Stops the walk speed loop",
run=function(b)
stopLoop(b,"loopspeed")
end
},
{
action="loopjumppower|loopjp|loopjpower",
description="Keeps your jump power set, even after respawning (default is 50)",
args={kind="number",name="jump power",optional=true},
run=function(b,c)
startLoop(b,"loopjumppower","JumpPower",applyJumpPower,c:nextValue()or 50)
end
},
{
action="unloopjumppower|unloopjp|unloopjpower",
description="Stops the jump power loop",
run=function(b)
stopLoop(b,"loopjumppower")
end
}
}end a.aN=function()local b=a.cache.aN if not b then b={c=__modImpl()}a.cache.aN=b end return b.c end end do local function __modImpl()

local b=PhysicalProperties.new(100,0.3,0.5)

local function createFlingTemplate()
local c=Instance.new"BodyAngularVelocity"
c.MaxTorque=Vector3.yAxis*math.huge
c.P=math.huge
return c
end

local function flingRun(c,d)
if c:hasGarbage"fling"then
c:notify"fling is already enabled\ndisable using 'unfling'"
return
end

local e=c.playerService:getHumanoid()
if not(e and e.Health~=0)then return end

local f=e.Parent

c:notify"fling now is activated"
c:run"noclip"

local g=c:createGarbage"fling"
g.originalStates={}

for h,i in f:GetDescendants()do
if not i:IsA"BasePart"then continue end

g.originalStates[i]={
CustomPhysicalProperties=i.CustomPhysicalProperties,
CanCollide=i.CanCollide,
Massless=i.Massless
}

i.CustomPhysicalProperties=b

if i.Parent==f then
i.CanCollide=false
i.Massless=true
i.Velocity=Vector3.zero
end
end

local h=createFlingTemplate()

g.flingVelocity=h
g.flingConnection=e.Died:Once(function()
c:notify"player died: disabling fling..."
c:run"unfling"
end)

h.Parent=f:WaitForChild"HumanoidRootPart"

while h and f and f.Parent do
h.AngularVelocity=Vector3.yAxis*99999
task.wait(0.2)
h.AngularVelocity=Vector3.one
task.wait(0.1)
end
end

local function unflingRun(c)
local d=c:collectGarbage"fling"
if not d then return end

if d.flingVelocity then
d.flingVelocity:Destroy()
end

if d.flingConnection then
d.flingConnection:Disconnect()
end

for e,f in d.originalStates do
for g,h in f do
e[g]=h
end
end

c:notify"fling disabled"
end

return{
{
action="fling|forcefling",
description="Flings anyone you touch",
run=flingRun
},
{
action="unfling",
description="Disables the fling command",
run=unflingRun
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
}end a.aO=function()local b=a.cache.aO if not b then b={c=__modImpl()}a.cache.aO=b end return b.c end end do local function __modImpl()

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
}end a.aP=function()local b=a.cache.aP if not b then b={c=__modImpl()}a.cache.aP=b end return b.c end end do local function __modImpl()

local function destroyParts(b,c)
for d,e in c do
local f=b:FindFirstChild(e)
if f then
f:Destroy()
end
end
end

local function isR15(b)
local c=b.playerService:getHumanoid()
return c~=nil and c.RigType==Enum.HumanoidRigType.R15
end

return{
{
action="noarms",
description="Removes your arms",
run=function(b)
local c=b.localPlayer.Character
if c then
destroyParts(c,isR15(b)and{"RightUpperArm","LeftUpperArm"}or{"Right Arm","Left Arm"})
end
end
},
{
action="nolegs",
description="Removes your legs",
run=function(b)
local c=b.localPlayer.Character
if c then
destroyParts(c,isR15(b)and{"RightUpperLeg","LeftUpperLeg"}or{"Right Leg","Left Leg"})
end
end
},
{
action="nolimbs",
description="Removes your limbs",
run=function(b)
local c=b.localPlayer.Character
if c then
destroyParts(c,isR15(b)
and{"RightUpperLeg","LeftUpperLeg","RightUpperArm","LeftUpperArm"}
or{"Right Leg","Left Leg","Right Arm","Left Arm"})
end
end
}
}end a.aQ=function()local b=a.cache.aQ if not b then b={c=__modImpl()}a.cache.aQ=b end return b.c end end do local function __modImpl()

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
}end a.aR=function()local b=a.cache.aR if not b then b={c=__modImpl()}a.cache.aR=b end return b.c end end do local function __modImpl()

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
}end a.aS=function()local b=a.cache.aS if not b then b={c=__modImpl()}a.cache.aS=b end return b.c end end do local function __modImpl()

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
}end a.aT=function()local b=a.cache.aT if not b then b={c=__modImpl()}a.cache.aT=b end return b.c end end do local function __modImpl()

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
}end a.aU=function()local b=a.cache.aU if not b then b={c=__modImpl()}a.cache.aU=b end return b.c end end do local function __modImpl()

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
}end a.aV=function()local b=a.cache.aV if not b then b={c=__modImpl()}a.cache.aV=b end return b.c end end do local function __modImpl()

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
}end a.aW=function()local b=a.cache.aW if not b then b={c=__modImpl()}a.cache.aW=b end return b.c end end do local function __modImpl()

return{
{
action="headsit",
description="Sit on a players head",
args={
kind="player"
}
}
}end a.aX=function()local b=a.cache.aX if not b then b={c=__modImpl()}a.cache.aX=b end return b.c end end do local function __modImpl()

return{
{
action="god",
description="Makes your character difficult to kill in most games"
}
}end a.aY=function()local b=a.cache.aY if not b then b={c=__modImpl()}a.cache.aY=b end return b.c end end do local function __modImpl()

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
}end a.aZ=function()local b=a.cache.aZ if not b then b={c=__modImpl()}a.cache.aZ=b end return b.c end end do local function __modImpl()

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
}end a.a_=function()local b=a.cache.a_ if not b then b={c=__modImpl()}a.cache.a_=b end return b.c end end do local function __modImpl()

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
}end a.a0=function()local b=a.cache.a0 if not b then b={c=__modImpl()}a.cache.a0=b end return b.c end end do local function __modImpl()

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

}end a.a1=function()local b=a.cache.a1 if not b then b={c=__modImpl()}a.cache.a1=b end return b.c end end do local function __modImpl()

local b=tostring(game.PlaceId)



local function registerWP(c,d,e)
wpsData:setValue(`{b}.{d}`,e)
wpsData:save()
end

local function createWaypoint(c,d)

local e=c.playerService:getRootPart()
if not e then return end


local f=d:nextValue()


local g=e.Position
local h=c:stringify(g)


local i=registerWP(c)
i:setValue(tostring(game.PlaceId),0)
i:save()


c:notify(`seted a waypoint '{f}' at '{g}'`)
end

local function gotoWaypoint(c,d)
local e=c.playerService:getRootPart()
if not e then return end

local f=d:nextValue()

end

local function hideWaypoints(c)
local d=c:collectGarbage"showingWaypoints"
if d==nil then return end

for e,f in d do
f:Destroy()
end
end

local function showWaypoints(c)
hideWaypoints(c)

local d=c:createGarbage"showingWaypoints"

local e=c.storage.waypointsData:getData()[tostring(game.PlaceId)]
































end


local function clearWaypoints(c)
local d=c.storage.waypointsData
local e=d:register(b,{})
local f=#e

table.clear(e)

c:notify(`deleted a total of {f} waypoints`)
end






































































































return{
{
action="setwaypoint|swp",
description="Sets a waypoint at your position",
args={kind="string"},
run=createWaypoint
},
{
action="waypointpos|wpp",
description="Sets a waypoint with specified coordinates",
args={kind="vector3"}
},
{
action="waypoints",
description="Shows a list of currently active waypoints"
},
{
action="showwaypoints|showwp",
description="Shows all currently set waypoints"
},
{
action="hidewaypoints|hidewp",
description="Hides shown waypoints"
},
{
action="waypoint|wp",
description="Teleports player to a waypoint",
args={kind="waypoint"}
},
{
action="tweenwaypoint|twp",
description="Tweens player to a waypoint",
args={kind="waypoint"}
},
{
action="walktowaypoint|wtwp",
description="Walks player to a waypoint",
args={kind="waypoint"}
},
{
action="deletewaypoint|dwp",
description="Deletes a waypoint",
args={kind="waypoint"}
},
{
action="clearwaypoints|cwp",
description="Clears all waypoints"
},
{
action="cleargamewaypoints|cgamewp",
description="Clears all waypoints for the game you are in",
args={kind="boolean",name="confirm"},
run=clearWaypoints
}
}end a.a2=function()local b=a.cache.a2 if not b then b={c=__modImpl()}a.cache.a2=b end return b.c end end do local function __modImpl()
return{
action="tweenspeed|tspeed",
description="Sets how fast all tween commands go (default is 1)",
args={kind="number",name="tween speed",optional=true},
run=function(b,c)
b.privateEnv.tweenSpeed=c:nextValue()or 1
end
}end a.a3=function()local b=a.cache.a3 if not b then b={c=__modImpl()}a.cache.a3=b end return b.c end end do local function __modImpl()

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
}end a.a4=function()local b=a.cache.a4 if not b then b={c=__modImpl()}a.cache.a4=b end return b.c end end do local function __modImpl()
return{
action="vehiclegoto|vgoto",
description="Go to a player while in a vehicle",
args={kind="player"}
}end a.a5=function()local b=a.cache.a5 if not b then b={c=__modImpl()}a.cache.a5=b end return b.c end end do local function __modImpl()
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
}end a.a6=function()local b=a.cache.a6 if not b then b={c=__modImpl()}a.cache.a6=b end return b.c end end do local function __modImpl()
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
}end a.a7=function()local b=a.cache.a7 if not b then b={c=__modImpl()}a.cache.a7=b end return b.c end end do local function __modImpl()
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
}end a.a8=function()local b=a.cache.a8 if not b then b={c=__modImpl()}a.cache.a8=b end return b.c end end do local function __modImpl()
return{
{
action="freezeanims",
description="Freezes your animations / pauses your animations - Does not work on default animations"
},
{
action="unfreezeanims",
description="Unfreezes your animations / plays your animations"
}
}end a.a9=function()local b=a.cache.a9 if not b then b={c=__modImpl()}a.cache.a9=b end return b.c end end do local function __modImpl()
local function setRootAnchored(b,c)
local d=b.playerService:getRootPart()
if d then
d.Anchored=c
end
end

return{
{
action="anchor",
description="Anchors your characters RootPart",
run=function(b)
setRootAnchored(b,true)
end
},
{
action="unanchor",
description="Unanchors your characters RootPart",
run=function(b)
setRootAnchored(b,false)
end
}
}end a.ba=function()local b=a.cache.ba if not b then b={c=__modImpl()}a.cache.ba=b end return b.c end end do local function __modImpl()

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
}end a.bb=function()local b=a.cache.bb if not b then b={c=__modImpl()}a.cache.bb=b end return b.c end end do local function __modImpl()
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
}end a.bc=function()local b=a.cache.bc if not b then b={c=__modImpl()}a.cache.bc=b end return b.c end end do local function __modImpl()
return{
action="walktoposition|walktopos",
description="Makes you walk to a coordinate",
args={kind="vector3"}
}end a.bd=function()local b=a.cache.bd if not b then b={c=__modImpl()}a.cache.bd=b end return b.c end end do local function __modImpl()
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
}end a.be=function()local b=a.cache.be if not b then b={c=__modImpl()}a.cache.be=b end return b.c end end do local function __modImpl()
return{
action="flashback|diedtp",
description="Teleports you to where you last died"
}end a.bf=function()local b=a.cache.bf if not b then b={c=__modImpl()}a.cache.bf=b end return b.c end end do local function __modImpl()
return{
{
action="walltp",
description="Teleports you above/over any wall you run into"
},
{
action="nowalltp|unwalltp",
description="Disables walltp"
}
}end a.bg=function()local b=a.cache.bg if not b then b={c=__modImpl()}a.cache.bg=b end return b.c end end do local function __modImpl()
return{
action="teleporttool|tptool",
description="Gives you a teleport tool"
}end a.bh=function()local b=a.cache.bh if not b then b={c=__modImpl()}a.cache.bh=b end return b.c end end do local function __modImpl()


local function travelTo(b,c,d)
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
end
end


local function createGotoCommand(b)
return{
action=b.action,
description=b.description,
args={kind=b.kind,name=b.argName},
run=function(c,d)
local e=(d:nextValue()or""):lower()

for f,g in workspace:GetDescendants()do
if g:IsA(b.className)and g[b.field]:lower()==e then
travelTo(c,b.cframeOf(g),b.tween)
end
end
end
}
end


local function createBringCommand(b)
return{
action=b.action,
description=b.description,
args={kind=b.kind,name=b.argName},
run=function(c,d)
local e=(d:nextValue()or""):lower()
local f=c.playerService:getRootPart()
if not f then return end

for g,h in workspace:GetDescendants()do
if h:IsA(b.className)and h[b.field]:lower()==e then
h.CFrame=f.CFrame
end
end
end
}
end

local function partCFrame(b)
return b.CFrame
end

local function modelCFrame(b)
return b:GetPivot()
end

return{
createGotoCommand{
action="gotopart|topart",
description="Teleports you to every part with the given name",
kind="string",argName="part name",
className="BasePart",field="Name",cframeOf=partCFrame,tween=false
},
createGotoCommand{
action="tweengotopart|tgotopart|ttopart",
description="Tweens you to every part with the given name",
kind="string",argName="part name",
className="BasePart",field="Name",cframeOf=partCFrame,tween=true
},
createGotoCommand{
action="gotopartclass|gpc",
description="Teleports you to every part with the given class name",
kind="className",argName="class name",
className="BasePart",field="ClassName",cframeOf=partCFrame,tween=false
},
createGotoCommand{
action="tweengotopartclass|tgpc",
description="Tweens you to every part with the given class name",
kind="className",argName="class name",
className="BasePart",field="ClassName",cframeOf=partCFrame,tween=true
},
createGotoCommand{
action="gotomodel|tomodel",
description="Teleports you to every model with the given name",
kind="string",argName="model name",
className="Model",field="Name",cframeOf=modelCFrame,tween=false
},
createGotoCommand{
action="tweengotomodel|tgotomodel|ttomodel",
description="Tweens you to every model with the given name",
kind="string",argName="model name",
className="Model",field="Name",cframeOf=modelCFrame,tween=true
},
createBringCommand{
action="bringpart",
description="Brings every part with the given name to you",
kind="string",argName="part name",
className="BasePart",field="Name"
},
createBringCommand{
action="bringpartclass|bpc",
description="Brings every part with the given class name to you",
kind="className",argName="class name",
className="BasePart",field="ClassName"
},
{
action="gotopartdelay",
description="Sets the delay before the goto part commands teleport (default is 0.1)",
args={kind="number",name="delay",optional=true},
run=function(b,c)
b.privateEnv.gotopartDelay=c:nextValue()or 0.1
end
}
}end a.bi=function()local b=a.cache.bi if not b then b={c=__modImpl()}a.cache.bi=b end return b.c end end do local function __modImpl()

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
}end a.bj=function()local b=a.cache.bj if not b then b={c=__modImpl()}a.cache.bj=b end return b.c end end do local function __modImpl()

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
}end a.bk=function()local b=a.cache.bk if not b then b={c=__modImpl()}a.cache.bk=b end return b.c end end do local function __modImpl()

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
}end a.bl=function()local b=a.cache.bl if not b then b={c=__modImpl()}a.cache.bl=b end return b.c end end do local function __modImpl()

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

}end a.bm=function()local b=a.cache.bm if not b then b={c=__modImpl()}a.cache.bm=b end return b.c end end do local function __modImpl()

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
}end a.bn=function()local b=a.cache.bn if not b then b={c=__modImpl()}a.cache.bn=b end return b.c end end do local function __modImpl()
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
}end a.bo=function()local b=a.cache.bo if not b then b={c=__modImpl()}a.cache.bo=b end return b.c end end do local function __modImpl()
return{
{
action="bubblechat",
description="Enables bubble chat for your client (CLIENT)"
},
{
action="unbubblechat|nobubblechat",
description="Disables the bubblechat command"
}
}end a.bp=function()local b=a.cache.bp if not b then b={c=__modImpl()}a.cache.bp=b end return b.c end end do local function __modImpl()
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
}end a.bq=function()local b=a.cache.bq if not b then b={c=__modImpl()}a.cache.bq=b end return b.c end end do local function __modImpl()
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
}end a.br=function()local b=a.cache.br if not b then b={c=__modImpl()}a.cache.br=b end return b.c end end do local function __modImpl()
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
}end a.bs=function()local b=a.cache.bs if not b then b={c=__modImpl()}a.cache.bs=b end return b.c end end do local function __modImpl()

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
}end a.bt=function()local b=a.cache.bt if not b then b={c=__modImpl()}a.cache.bt=b end return b.c end end do local function __modImpl()

return{a.bn()
,a.bo()
,a.bp()
,a.bq()
,a.br()
,a.bs()
,a.bt()

}end a.bu=function()local b=a.cache.bu if not b then b={c=__modImpl()}a.cache.bu=b end return b.c end end do local function __modImpl()

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
}end a.bv=function()local b=a.cache.bv if not b then b={c=__modImpl()}a.cache.bv=b end return b.c end end do local function __modImpl()
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
}end a.bw=function()local b=a.cache.bw if not b then b={c=__modImpl()}a.cache.bw=b end return b.c end end do local function __modImpl()
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
}end a.bx=function()local b=a.cache.bx if not b then b={c=__modImpl()}a.cache.bx=b end return b.c end end do local function __modImpl()
return{
{
action="hovername",
description="Shows a players username when your mouse is hovered over them"
},
{
action="unhovername|nohovername",
description="Turns off hovername"
}
}end a.by=function()local b=a.cache.by if not b then b={c=__modImpl()}a.cache.by=b end return b.c end end do local function __modImpl()

return{a.bv()
,a.bw()
,a.bx()
,a.by()

}end a.bz=function()local b=a.cache.bz if not b then b={c=__modImpl()}a.cache.bz=b end return b.c end end do local function __modImpl()

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
}end a.bA=function()local b=a.cache.bA if not b then b={c=__modImpl()}a.cache.bA=b end return b.c end end do local function __modImpl()
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
}end a.bB=function()local b=a.cache.bB if not b then b={c=__modImpl()}a.cache.bB=b end return b.c end end do local function __modImpl()
return{
{
action="gotocamera|gotocam",
description="Teleports you to the location of your camera"
},
{
action="tweengotocam|tgotocam",
description="Tweens you to the location of your camera"
}
}end a.bC=function()local b=a.cache.bC if not b then b={c=__modImpl()}a.cache.bC=b end return b.c end end do local function __modImpl()
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
}end a.bD=function()local b=a.cache.bD if not b then b={c=__modImpl()}a.cache.bD=b end return b.c end end do local function __modImpl()

return{
action="noclipcam|nccam",
description="Allows camera to go through objects like walls"
}end a.bE=function()local b=a.cache.bE if not b then b={c=__modImpl()}a.cache.bE=b end return b.c end end do local function __modImpl()
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
}end a.bF=function()local b=a.cache.bF if not b then b={c=__modImpl()}a.cache.bF=b end return b.c end end do local function __modImpl()

return{
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(b,c)
local d=math.abs(c:nextValue())
workspace.CurrentCamera.FieldOfView=d
end
}end a.bG=function()local b=a.cache.bG if not b then b={c=__modImpl()}a.cache.bG=b end return b.c end end do local function __modImpl()
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
}end a.bH=function()local b=a.cache.bH if not b then b={c=__modImpl()}a.cache.bH=b end return b.c end end do local function __modImpl()
return{
action="enableshiftlock|enablesl",
description="Enables the shift lock option"
}end a.bI=function()local b=a.cache.bI if not b then b={c=__modImpl()}a.cache.bI=b end return b.c end end do local function __modImpl()
return{
action="lookat",
description="Moves your camera view to a player",
args={kind="player"}
}end a.bJ=function()local b=a.cache.bJ if not b then b={c=__modImpl()}a.cache.bJ=b end return b.c end end do local function __modImpl()
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
}end a.bK=function()local b=a.cache.bK if not b then b={c=__modImpl()}a.cache.bK=b end return b.c end end do local function __modImpl()

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

}end a.bL=function()local b=a.cache.bL if not b then b={c=__modImpl()}a.cache.bL=b end return b.c end end do local function __modImpl()

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
}end a.bM=function()local b=a.cache.bM if not b then b={c=__modImpl()}a.cache.bM=b end return b.c end end do local function __modImpl()
return{
action="partname|partpath",
description="Allows you to click a part to see its path & name"
}end a.bN=function()local b=a.cache.bN if not b then b={c=__modImpl()}a.cache.bN=b end return b.c end end do local function __modImpl()
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
}end a.bO=function()local b=a.cache.bO if not b then b={c=__modImpl()}a.cache.bO=b end return b.c end end do local function __modImpl()
return{
{
action="lockworkspace|lockws",
description="Locks the whole workspace"
},
{
action="unlockworkspace|unlockws",
description="Unlocks the whole workspace"
}
}end a.bP=function()local b=a.cache.bP if not b then b={c=__modImpl()}a.cache.bP=b end return b.c end end do local function __modImpl()
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
}end a.bQ=function()local b=a.cache.bQ if not b then b={c=__modImpl()}a.cache.bQ=b end return b.c end end do local function __modImpl()
local function createLimitCommand(b,c,d)
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
}
end

return{
createLimitCommand(
"noclickdetectorlimits|nocdlimits|removecdlimits",
"Removes the activation distance limit of ClickDetectors",
"ClickDetector"
),
createLimitCommand(
"noproximitypromptlimits|nopplimits|removepplimits",
"Removes the activation distance limit of ProximityPrompts",
"ProximityPrompt"
),
{
action="instantproximityprompts|instantpp",
description="Fires proximity prompts as soon as they are held (needs fireproximityprompt)",
run=function(b)
local c=b.executorEnv.fireproximityprompt

if not c then
b:notify("Incompatible Exploit","Your exploit does not support this command (missing fireproximityprompt)")
return
end

if b:hasGarbage"instantpp"then
b:notify"instant proximity prompts is already enabled"
return
end

local d=b:createGarbage"instantpp"
d.connection=b:connect(b.proximityPromptService.PromptButtonHoldBegan,function(e)
c(e)
end)
end
},
{
action="uninstantproximityprompts|uninstantpp",
description="Disables instant proximity prompts",
run=function(b)
local c=b:collectGarbage"instantpp"
if c and c.connection then
c.connection:Disconnect()
end
end
}
}end a.bR=function()local b=a.cache.bR if not b then b={c=__modImpl()}a.cache.bR=b end return b.c end end do local function __modImpl()

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
}end a.bS=function()local b=a.cache.bS if not b then b={c=__modImpl()}a.cache.bS=b end return b.c end end do local function __modImpl()

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
}end a.bT=function()local b=a.cache.bT if not b then b={c=__modImpl()}a.cache.bT=b end return b.c end end do local function __modImpl()

local function matchName(b,c)
return c==""
or b.Name:lower()==c
or(b.Parent~=nil and b.Parent.Name:lower()==c)
end

local function getPromptPosition(b)
local c=b.Parent
if c==nil then
return nil
elseif c:IsA"Attachment"then
return c.WorldPosition
elseif c:IsA"BasePart"then
return c.Position
elseif c:IsA"Model"then
return c:GetPivot().Position
end
return nil
end

local function getClosestPrompt(b)
local c=b.playerService:getRootPart()
if not c then
return nil
end

local d
local e=math.huge

for f,g in workspace:GetDescendants()do
if g:IsA"ProximityPrompt"and g.Enabled then
local h=getPromptPosition(g)
if not h then continue end

local i=(h-c.Position).Magnitude

if i<e then
d,e=g,i
end
end
end

return d
end

local function teleportToPrompt(b,c)
local d=b.playerService:getRootPart()
local e=getPromptPosition(c)

if d and e then
d.CFrame=CFrame.new(e+Vector3.new(0,3,0))
end
end

return{
{
action="fireclickdetectors|firecd",
description="Uses all click detectors in a game or uses the optional name",
args={
kind="object",
optional=true
},
run=function(b,c)
local d=b:expectExploit"fireclickdetector"
if not d then return end

local e=(c:nextValue()or""):lower()

for f,g in workspace:GetDescendants()do
if g:IsA"ClickDetector"and matchName(g,e)then
d(g)
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
run=function(b,c)
local d=b:expectExploit"fireproximityprompt"
if not d then return end

local e=(c:nextValue()or""):lower()

for f,g in workspace:GetDescendants()do
if g:IsA"ProximityPrompt"and matchName(g,e)then
d(g)
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
run=function(b,c)
local d=b:expectExploit"fireproximityprompt"
if not d then return end

local e=getClosestPrompt(b)
if not e then
b:notify"Can't find any ProximityPrompt on workspace"
return
end

if c:nextValue()then
teleportToPrompt(b,e)
task.wait(0.25)
end

d(e)
b:notify(`fired prompt: {e:GetFullName()}`)
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
}end a.bU=function()local b=a.cache.bU if not b then b={c=__modImpl()}a.cache.bU=b end return b.c end end do local function __modImpl()
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
}end a.bV=function()local b=a.cache.bV if not b then b={c=__modImpl()}a.cache.bV=b end return b.c end end do local function __modImpl()

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

}end a.bW=function()local b=a.cache.bW if not b then b={c=__modImpl()}a.cache.bW=b end return b.c end end do local function __modImpl()

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
}end a.bX=function()local b=a.cache.bX if not b then b={c=__modImpl()}a.cache.bX=b end return b.c end end do local function __modImpl()
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
}end a.bY=function()local b=a.cache.bY if not b then b={c=__modImpl()}a.cache.bY=b end return b.c end end do local function __modImpl()

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
}end a.bZ=function()local b=a.cache.bZ if not b then b={c=__modImpl()}a.cache.bZ=b end return b.c end end do local function __modImpl()

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
}end a.b_=function()local b=a.cache.b_ if not b then b={c=__modImpl()}a.cache.b_=b end return b.c end end do local function __modImpl()

return{
client=true,
action="brightness",
description="Changes the brightness lighting property",
args={kind="number"},
run=function(b,c)
b.robloxServices.Lighting.Brightness=c:nextValue()
end
}end a.b0=function()local b=a.cache.b0 if not b then b={c=__modImpl()}a.cache.b0=b end return b.c end end do local function __modImpl()

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
}end a.b1=function()local b=a.cache.b1 if not b then b={c=__modImpl()}a.cache.b1=b end return b.c end end do local function __modImpl()

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
}end a.b2=function()local b=a.cache.b2 if not b then b={c=__modImpl()}a.cache.b2=b end return b.c end end do local function __modImpl()
return{a.bX()
,a.bY()
,a.bZ()
,a.b_()
,a.b0()
,a.b1()
,a.b2()

}end a.b3=function()local b=a.cache.b3 if not b then b={c=__modImpl()}a.cache.b3=b end return b.c end end do local function __modImpl()
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
}end a.b4=function()local b=a.cache.b4 if not b then b={c=__modImpl()}a.cache.b4=b end return b.c end end do local function __modImpl()
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
}end a.b5=function()local b=a.cache.b5 if not b then b={c=__modImpl()}a.cache.b5=b end return b.c end end do local function __modImpl()
local b=a.d()


local function createCommands(c)
local d={}
local e={}
local f={}

local function newCommand(g)
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
g.action=nil
end

for g,h in c do
b:expect(h.name,{"string"},"section name")
b:expect(h.commands,{"table"},"section commands")

table.insert(d,{
isSection=true,
sectionName=h.name
})

for i,j in h.commands do
if#j==0 then
b:assert(next(j),"the command cannot be empty")
newCommand(j)
continue
end

for k=1,#j do
newCommand(j[k])
end
end
end

return{
array=f,
lookup=e,
original=d
}
end

return createCommands{
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
}end a.b6=function()local b=a.cache.b6 if not b then b={c=__modImpl()}a.cache.b6=b end return b.c end end do local function __modImpl()

































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































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


return c end a.b7=function()local b=a.cache.b7 if not b then b={c=__modImpl()}a.cache.b7=b end return b.c end end do local function __modImpl()
return a.j().new"createdWaypoints"end a.b8=function()local b=a.cache.b8 if not b then b={c=__modImpl()}a.cache.b8=b end return b.c end end do local function __modImpl()
return a.j().new"installedPlugins"end a.b9=function()local b=a.cache.b9 if not b then b={c=__modImpl()}a.cache.b9=b end return b.c end end do local function __modImpl()
return a.j().new(".userData",{
encrypt=true
})end a.ca=function()local b=a.cache.ca if not b then b={c=__modImpl()}a.cache.ca=b end return b.c end end do local function __modImpl()
return a.j().new"aliases"end a.cb=function()local b=a.cache.cb if not b then b={c=__modImpl()}a.cache.cb=b end return b.c end end do local function __modImpl()
return a.j().new"totalUsedCommands"end a.cc=function()local b=a.cache.cc if not b then b={c=__modImpl()}a.cache.cc=b end return b.c end end do local function __modImpl()
return{
waypoints=a.b8(),
plugins=a.b9(),
settings=a.k(),
user=a.ca(),
aliases=a.cb(),
usedCmds=a.cc()
}end a.cd=function()local b=a.cache.cd if not b then b={c=__modImpl()}a.cache.cd=b end return b.c end end do local function __modImpl()
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


return b end a.ce=function()local b=a.cache.ce if not b then b={c=__modImpl()}a.cache.ce=b end return b.c end end do local function __modImpl()

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


return b end a.cf=function()local b=a.cache.cf if not b then b={c=__modImpl()}a.cache.cf=b end return b.c end end do local function __modImpl()
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


return b end a.cg=function()local b=a.cache.cg if not b then b={c=__modImpl()}a.cache.cg=b end return b.c end end do local function __modImpl()
local b=a.d()

local c={}

c.notify=function(d, e, f, g)
b:expect(e,{"string"},"'notifier:notify' #1")

if f==nil then
f=e
e="Notification"
end


print("notification:",g or 5,e,f)end


return c end a.ch=function()local b=a.cache.ch if not b then b={c=__modImpl()}a.cache.ch=b end return b.c end end do local function __modImpl()


local b=a.b()
local c=a.d()

local d={

_callbacks={},
_nextId=0,
}


local function runLoop(e)
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
end
end


d.start=function(e)
if b.loopThread~=nil then
return
end

b.loopThread=task.defer(runLoop,e)end



d.stop=function(e)
local f=b.loopThread
b.loopThread=nil
table.clear(e._callbacks)

if f~=nil then
task.cancel(f)
end end




d.add=function(e, f, g)
c:expect(f,{"function"},"'loopService:add' #1")
c:expect(g,{"number","nil"},"'loopService:add' #2")

e._nextId=e._nextId+1
local h=e._nextId

e._callbacks[h]={
func=f,
cooldown=math.max(g or 0,0),
lastCall=-math.huge
}

e:start()
return h end



d.remove=function(e, f)
c:expect(f,{"number"},"'loopService:remove' #1")
e._callbacks[f]=nil end


return d end a.ci=function()local b=a.cache.ci if not b then b={c=__modImpl()}a.cache.ci=b end return b.c end end do local function __modImpl()
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

f:warn(`missing command run func: {t.name}`)end


local function getUsage(q)
local r=d.lookup[q:lower()]
if r==nil then return 0 end


return g:getValue(r.name)or 0
end

p.search=function(q, r, s)
local t=j:searchAtArray(d.array,r,s)
local u=r:lower()
local v={}

for w,x in t do
table.insert(v,{
alias=x,
index=w,
isPrefix=x:lower():sub(1,#u)==u,
usage=getUsage(x),
})
end

table.sort(v,function(w,x)
if w.isPrefix~=x.isPrefix then return w.isPrefix end
if w.usage~=x.usage then return w.usage>x.usage end
return w.index<x.index
end)

local w={}
for x,y in v do
w[x]=y.alias
end

return w end


p.init=function(q, r)
f:assert(r,"'commandsController:init' #1 expected a config to init")

local s=a.cf()
local t=a.cg()
local u=a.ch()


q.notify=function(v, ...)
return u:notify(...)end


q.stringify=function(v, ...)
return t:stringify(...)end


q.unstringify=function(v, ...)
return t:unstringify(...)end


q.connect=function(v, ...)
return s:Connect(...)end


q.expectExploit=function(v, w)
local x=c[w]
if x~=nil then return x end

v:notify("Incompatible Exploit",`Your exploit does not support this command (missing {w})`)end



q.localPlayer=a.ac()
q.executorEnv=c
q.privateEnv=b


q.infiniteYield=r.infiniteYield
q.playerService=r.playerService
q.fetchService=r.fetchService


q.signals={
onCameraReset=e.new()
}


q.config={
links=i.links
}


q.userSettings=UserSettings()
q.gameSettings=settings()

q.userGameSettings=q.userSettings:GetService"UserGameSettings"
q.gameNetworkSettings=q.gameSettings:GetService"NetworkSettings"


q.loopService=a.ci()


q.datas=a.cd()


q.robloxServices=h
q.rbxServices=h

q.teleportService=h.TeleportService
q.groupService=h.GroupService
q.runService=h.RunService
q.starterGui=h.StarterGui
q.coreGui=h.CoreGui
q.players=h.Players
q.guiService=h.GuiService
q.networkClient=h.NetworkClient
q.proximityPromptService=h.ProximityPromptService end


return p end a.cj=function()local b=a.cache.cj if not b then b={c=__modImpl()}a.cache.cj=b end return b.c end end do local function __modImpl()
local b=a.m()
local c=a.d()

local d="https://raw.githubusercontent.com/%s/%s/refs/heads/main/"
d=d:format(b.owner,b.repository)

local e={}

local function request(f)
return game:HttpGet(f)
end

e.fetch=function(f)
if f:sub(1,1)=="/"then
f=f:sub(2)
end

local g,h=pcall(request,d..f)

if not g then
c:warn(`failed to fetch http url '{f}':\n\t{h}`)
return
end

return h end


return e end a.ck=function()local b=a.cache.ck if not b then b={c=__modImpl()}a.cache.ck=b end return b.c end end do local function __modImpl()



local b=a.b6()

local function findStubs()
local c={}
local d="unknown"

for e,f in b.original do
if f.isSection then
d=f.sectionName
elseif f.run==nil then
table.insert(c,{section=d,name=f.name})
end
end

return c
end

return function(c)
local d=findStubs()
if#d==0 then
return
end

local e={}
local f={}

for g,h in d do
if not e[h.section]then
e[h.section]={}
table.insert(f,h.section)
end
table.insert(e[h.section],h.name)
end

local g={}
for h,i in f do
local j=table.concat(e[i],", ")
table.insert(g,`[{i}] {j}`)
end

local h=table.concat(g,"\n")
print(`infinite yield: {#d} command(s) without run:\n{h}`)
c:notify("Commands without run",`{#d} command(s) still need a run function, see console`)
end end a.cl=function()local b=a.cache.cl if not b then b={c=__modImpl()}a.cache.cl=b end return b.c end end do local function __modImpl()
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


return b end a.cm=function()local b=a.cache.cm if not b then b={c=__modImpl()}a.cache.cm=b end return b.c end end do local function __modImpl()
local b={}

return b end a.cn=function()local b=a.cache.cn if not b then b={c=__modImpl()}a.cache.cn=b end return b.c end end do local function __modImpl()
local b=a.cn()
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


return d end a.co=function()local b=a.cache.co if not b then b={c=__modImpl()}a.cache.co=b end return b.c end end do local function __modImpl()
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


return d end a.cp=function()local b=a.cache.cp if not b then b={c=__modImpl()}a.cache.cp=b end return b.c end end do local function __modImpl()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cq=function()local b=a.cache.cq if not b then b={c=__modImpl()}a.cache.cq=b end return b.c end end do local function __modImpl()
local b=a.cq()

local c={}

c.getScale=function(d, e)
return b.isEnabled and(e*b.animationScale)or 0 end


c.getScrollSpeed=function(d, e)
return(e*b.scrollSpeed)end


return c end a.cr=function()local b=a.cache.cr if not b then b={c=__modImpl()}a.cache.cr=b end return b.c end end do local function __modImpl()
return{
createService=a.co(),
specialProps=a.cn(),

connectionService=a.cf(),
fetchService=a.ck(),
localPlayer=a.ac(),
messageService=a.cp(),
playerService=a.ad(),
rbxServices=a.g(),
tweenService=a.cr(),
}end a.cs=function()local b=a.cache.cs if not b then b={c=__modImpl()}a.cache.cs=b end return b.c end end do local function __modImpl()
return{
DisplayName="Classic",

FirstShade=Color3.fromRGB(36,36,37),
SecondShade=Color3.fromRGB(46,46,47),
ThirdShade=Color3.fromRGB(78,78,79),

DefaultText=Color3.new(1,1,1),
DarkText=Color3.new(0,0,0),

ScrollBar=Color3.fromRGB(78,78,79)
}end a.ct=function()local b=a.cache.ct if not b then b={c=__modImpl()}a.cache.ct=b end return b.c end end do local function __modImpl()
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
}end a.cu=function()local b=a.cache.cu if not b then b={c=__modImpl()}a.cache.cu=b end return b.c end end do local function __modImpl()
return{
DisplayName="Light"
}end a.cv=function()local b=a.cache.cv if not b then b={c=__modImpl()}a.cache.cv=b end return b.c end end do local function __modImpl()
local b={a.ct()
,a.cu()
,a.cv()

}

local c={}

for d,e in b do
local f=string.lower(e.DisplayName)
c[f]=e
end

return c end a.cw=function()local b=a.cache.cw if not b then b={c=__modImpl()}a.cache.cw=b end return b.c end end do local function __modImpl()
local b=a.cw()

local c=a.d()
local d=a.cm()

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


return e end a.cx=function()local b=a.cache.cx if not b then b={c=__modImpl()}a.cache.cx=b end return b.c end end do local function __modImpl()


local b=a.cs()
local c=a.d()

local d=b.specialProps
local e=a.cx()

d.ThemeTag=function(f, g)
if type(g)~="table"then
c:error"expected a 'table' when setting a theme tag"
return
end

e:addObject(f,g)end


return a.co()end a.cy=function()local b=a.cache.cy if not b then b={c=__modImpl()}a.cache.cy=b end return b.c end end do local function __modImpl()return{bindsandplugins="rbxassetid://5147695474",close="rbxassetid://5054663650",editaliases="rbxassetid://5147488658",editkeybinds="rbxassetid://129697930",edittheme="rbxassetid://4911962991",editwaypoints="rbxassetid://5147488592",imgstudiopluginlogo="rbxassetid://4113050383",logo="rbxassetid://1352543873",minimize="rbxassetid://2406617031",pin="rbxassetid://6234691350",reference="rbxassetid://3523243755",settings="rbxassetid://1204397029",}end a.cz=function()local b=a.cache.cz if not b then b={c=__modImpl()}a.cache.cz=b end return b.c end end do local function __modImpl()local b=a.a()
local c=a.o()

local d=c.storage.imagePath

local e=a.j()
local f=a.ck()
local g=a.d()

local h=a.cz()

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


return l end a.cA=function()local b=a.cache.cA if not b then b={c=__modImpl()}a.cache.cA=b end return b.c end end do local function __modImpl()
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
local l

local function disconnectMouse()
j.isDragging=false
j.draggingObject=nil
j.dragStart=nil
j.startPos=nil

if l then
l:Disconnect()
end

j.dragEnded:Fire(k)
end

local function startConnectionTimeout()
while j.draggingObject==k do
if(tick()-j.lastActivity)>=1 then
disconnectMouse()
end
task.wait()
end
end

b:Connect(k.InputBegan,function(m)
if not f[m.UserInputType]then return end
if j.isDragging then return end

j.dragStart=m.Position
j.startPos=k.Position

j.isDragging=true
j.draggingObject=k
j.lastActivity=tick()

j.dragStarted:Fire(k)

task.spawn(startConnectionTimeout)

l=m.Changed:Connect(function()
if m.UserInputState==Enum.UserInputState.End then
disconnectMouse()
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


return i end a.cB=function()local b=a.cache.cB if not b then b={c=__modImpl()}a.cache.cB=b end return b.c end end do local function __modImpl()
local b=a.g()
local c=a.a()

local function getCoreGui()
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

return d
end

return getCoreGui()end a.cC=function()local b=a.cache.cC if not b then b={c=__modImpl()}a.cache.cC=b end return b.c end end do local function __modImpl()
return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.cD=function()local b=a.cache.cD if not b then b={c=__modImpl()}a.cache.cD=b end return b.c end end do local function __modImpl()



local b={}

local c=a.o()
local d=a.cD()

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


return b end a.cE=function()local b=a.cache.cE if not b then b={c=__modImpl()}a.cache.cE=b end return b.c end end do local function __modImpl()
return{
uiScale=Instance.new"UIScale",
getScale=function(b)
local c=b.uiScale
return c and c.Scale or 1
end,
setScale=function(b,c)
local d=b.uiScale
if d then d.Scale=c end
end
}end a.cF=function()local b=a.cache.cF if not b then b={c=__modImpl()}a.cache.cF=b end return b.c end end do local function __modImpl()


local b=a.cy()

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


return c end a.cG=function()local b=a.cache.cG if not b then b={c=__modImpl()}a.cache.cG=b end return b.c end end do local function __modImpl()

local b=a.cy()

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
end end a.cH=function()local b=a.cache.cH if not b then b={c=__modImpl()}a.cache.cH=b end return b.c end end do local function __modImpl()
return{
pressingInputs={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true
}
}end a.cI=function()local b=a.cache.cI if not b then b={c=__modImpl()}a.cache.cI=b end return b.c end end do local function __modImpl()
local b=a.cf()
local c=a.g()
local d=a.cy()
local e=a.ad()
local f=a.cx()

local g=a.cH()
local h=a.cF()

local i=a.b7()

local j=a.cI()

local k=c.UserInputService

local l={}
l.__index=l

local function isValidInputType(m)
return j.pressingInputs[m.UserInputType]~=nil
end

l.awake=function(m)
local n=e:getMouse()

local o=m.scrollThumbFrame
local p=m.scrollThumb
local q=m.scrollBar

local r=false
local s=false
local t

local function handleButtonPress(u,v)
local function onStartedPressing()
if r then return end
if not m:canScroll(v)then return end

r=true

m:scrollToDirection(v)

local w
w=b:Connect(k.InputEnded,function(x)
if not isValidInputType(x)then return end

w:Disconnect()
r=false
end)

task.wait(0.4)

while m:canScroll(v)and r do
m:scrollToDirection(v)
task.wait(6.666666666666666E-2)
end
end

b:Connect(u.MouseButton1Down,onStartedPressing)


end

handleButtonPress(m.upButton,"up")
handleButtonPress(m.downButton,"down")

b:Connect(q.MouseWheelForward,function()
m:scrollTo(m.index-m.wheelIncrement)
end)

b:Connect(q.MouseWheelBackward,function()
m:scrollTo(m.index+m.wheelIncrement)
end)

b:Connect(q.InputBegan,function(u)
if not isValidInputType(u)then return end
if m:isScrollBarDisabled()then return end

local v=not e:isMouseInGuiObject(p)
local w=m.isHorizontal and"X"or"Y"

local x
s=true

f:updateObjectProperties(p,{
BackgroundColor3="Colors.Primary"
})

local y=n[w]-p.AbsolutePosition[w]
local z
local A

local function disconnect()
if z then z:Disconnect()end
if A then A:Disconnect()end
end

z=b:Connect(k.InputEnded,function(B)
if not isValidInputType(B)then return end

disconnect()
s=false

f:updateObjectProperties(p,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if v then
local function updateDirection()
local B=(n[w]>=p.AbsolutePosition[w]+p.AbsoluteSize[w])and 1 or 0
local C=m.visibleSpace-1

if B==0 and(
n[w]<p.AbsolutePosition[w]
)then
m:scrollTo(m.index-C)
elseif B==1 and(
n[w]>=p.AbsolutePosition[w]+p.AbsoluteSize[w]
)then
m:scrollTo(m.index+C)
end
end

while s do
updateDirection()
task.wait(0.25)
end
return
end

A=b:Connect(k.InputChanged,function(B)
if not s then return end
if not isValidInputType(B)then return end

local C=o.AbsoluteSize[w]-p.AbsoluteSize[w]
local D=n[w]-o.AbsolutePosition[w]-y

if D>C then
D=C
elseif D<0 then
D=0
end

if x~=D then
x=D
m:scrollTo(math.floor(0.5+D/C*(m.totalSpace-m.visibleSpace)))
end
end)
end)end


l.create=function(m)
m.upButton=d.new("ImageButton",m.upButtonName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

m.downButton=d.new("ImageButton",m.downButtoName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

m:createButtonsArrows()

local n=d.new("Frame","ScrollBar",{
Active=true,
BackgroundTransparency=1,

m.upButton,
m.downButton,

d.new("Frame","ScrollThumbFrame",{
BackgroundTransparency=1,
AnchorPoint=m.isHorizontal
and Vector2.new(0.5,0)
or Vector2.new(0,0.5),
Position=m.isHorizontal
and UDim2.fromScale(0.5,0)
or UDim2.fromScale(0,0.5),

d.new("Frame","ScrollThumb",{
AnchorPoint=m.isHorizontal
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

m.scrollBar=n
m.scrollThumbFrame=n.ScrollThumbFrame
m.scrollThumb=n.ScrollThumbFrame.ScrollThumb
m.markerFrame=n.ScrollThumbFrame.MarkerFrame

m.container=d.new("Frame","Container",{
BackgroundTransparency=1,
ClipsDescendants=true,
Active=true
})

m:setScrollBarThickness(m.barThickness)
m:awake()
m:update()


return n end


l.createButtonsArrows=function(m)
local n=m.downButton
local o=m.upButton

g(4,0.55,n.Name).Parent=n
g(4,0.55,o.Name).Parent=o end


l.canScrollUp=function(m)
return m:isScrollBarEnabled()and m.index>0 end


l.canScrollDown=function(m)
local n=m:isScrollBarEnabled()
return n and m.index+m.visibleSpace<m.totalSpace end


l.canScroll=function(m, n)
if n=="up"or n=="left"then
return m:canScrollUp()
elseif n=="down"or n=="right"then
return m:canScrollDown()
end
return false end


l.getScrollPercent=function(m)
local n=m.totalSpace-m.visibleSpace
if n<=0 then return 0 end
return m.index/n end


l.scrollTo=function(m, n, o)
local p=math.max(0,m.totalSpace-m.visibleSpace)

m.index=math.clamp(n,0,p)
m:update()

if not o then
m.scrolledSignal:Fire(m.index)
end end


l.scrollUp=function(m)
m:scrollTo(m.index-m.increment)end


l.scrollDown=function(m)
m:scrollTo(m.index+m.increment)end


l.scrollToDirection=function(m, n)
if n=="up"or n=="left"then
return m:scrollUp()
elseif n=="down"or n=="right"then
return m:scrollDown()
end end


l.isVisible=function(m, n)
local o=m.index
if n>=o and n<(o+m.visibleSpace)then
return true
end
return false end


l.setScrollPercent=function(m, n)
local o=m.totalSpace-m.visibleSpace
m:scrollTo(math.floor(n*o))end


l.update=function(m)
m:drawThumb()end


l.setScrollBarThickness=function(m, n)
local o=m.scrollThumbFrame
local p=m.downButton
local q=m.container
local r=m.scrollBar
local s=m.upButton

m.barThickness=n

if q then
q.Size=UDim2.new(
1,
m.isHorizontal and 0 or-n,
1,
m.isHorizontal and-n or 0
)
end

if r then
r.Size=m.isHorizontal
and UDim2.new(1,0,0,n)
or UDim2.new(0,n,1,0)
r.Position=m.isHorizontal
and UDim2.new(0,0,1,-n)
or UDim2.new(1,-n,0,0)
end

if o then
o.Size=m.isHorizontal
and UDim2.new(1,-(n*2),0,n)
or UDim2.new(0,n,1,-(n*2))
end

if p then
p.Size=UDim2.fromOffset(n,n)
p.Position=m.isHorizontal
and UDim2.new(1,-n,0,0)
or UDim2.new(0,0,1,-n)
end

if s then
s.Size=UDim2.fromOffset(n,n)
s.Position=UDim2.fromOffset(0,0)
end end


l.updateArrowTransparency=function(m, n, o)
if not n:FindFirstChild"Arrow"then return end

for p,q in n.Arrow:GetChildren()do
if not q:IsA"GuiObject"then continue end
q.Transparency=o and 0.6 or 0
end end


l.drawThumb=function(m)
local n=m.scrollThumb
local o=m.scrollThumbFrame

local p=m:canScrollUp()
local q=m:canScrollDown()

m:updateArrowTransparency(m.upButton,not p)
m:updateArrowTransparency(m.downButton,not q)

if not n or not o then return end

if not p and not q then
n.Visible=false
return
end

n.Visible=true

local r=m:getScrollPercent()
local s=h:getScale()
local t=m.barThickness

if m.isHorizontal then
local u=o.AbsoluteSize.X/s
local v=math.max(t,(m.visibleSpace/m.totalSpace)*u)
n.Size=UDim2.new(0,v,1,-2)
n.Position=UDim2.new(0,r*(u-v),0.5,0)
else
local u=o.AbsoluteSize.Y/s
local v=math.max(t,(m.visibleSpace/m.totalSpace)*u)
n.Size=UDim2.new(1,-2,0,v)
n.Position=UDim2.new(0.5,0,0,r*(u-v))
end end


l.addMarker=function(m, n, o)
m.markers[n]=o or Color3.new(1,1,0)
m:updateMarkers()end


l.removeMarker=function(m, n)
m.markers[n]=nil
m:updateMarkers()end


l.updateMarkers=function(m)
local n=m.markerFrame
if not n then return end

for o,p in pairs(n:GetChildren())do
p:Destroy()
end

for o,p in pairs(m.markers)do
if o>=m.totalSpace then continue end

local q=Instance.new"Frame"
q.BackgroundColor3=p
q.BorderSizePixel=0
q.BackgroundTransparency=0
q.Parent=n

local r=o/m.totalSpace
if m.isHorizontal then
q.Position=UDim2.new(r,0,1,-4)
q.Size=UDim2.new(0,2,0,4)
else
q.Position=UDim2.new(1,-4,r,0)
q.Size=UDim2.new(0,4,0,2)
end

q.Name="Marker_"..tostring(o)
end end


l.setTotalSpace=function(m, n)
m.totalSpace=n
m:scrollTo(m.index,true)
m:update()end


l.setVisibleSpace=function(m, n)
m.visibleSpace=n
m:scrollTo(m.index,true)
m:update()end


l.disableScroll=function(m)
m.scrollBarEnabled=false
m:drawThumb()end


l.enableScroll=function(m)
m.scrollBarEnabled=true
m:drawThumb()end


l.isScrollBarEnabled=function(m)
return m.scrollBarEnabled end


l.isScrollBarDisabled=function(m)
return not m.scrollBarEnabled end


l.new=function(m)
local n=setmetatable({
isHorizontal=m.isHorizontal or false,
increment=m.increment or 1,
wheelIncrement=m.wheelIncrement or 3,
barThickness=m.barThickness or 16,

scrollBarEnabled=true,

index=0,
visibleSpace=m.visibleSpace or 0,
totalSpace=m.totalSpace or 0,

markers={},

scrollBar=m.scrollBar or nil,
scrollThumb=m.scrollThumb or nil,
scrollThumbFrame=m.scrollThumbFrame or nil,
markerFrame=m.markerFrame or nil,

scrolledSignal=i.new(),
},l)

n.upButtonName=n.isHorizontal and"left"or"up"
n.downButtoName=n.isHorizontal and"right"or"down"

return n end


return l end a.cJ=function()local b=a.cache.cJ if not b then b={c=__modImpl()}a.cache.cJ=b end return b.c end end do local function __modImpl()
local b={}
b.__index=b

b.new=function(c)
return setmetatable({
name=c.name,
isSection=c.isSection,
sectionName=c.sectionName,
aliases=c.aliases,
args=c.args,
name=c.name,
description=c.description
},b)end


return b end a.cK=function()local b=a.cache.cK if not b then b={c=__modImpl()}a.cache.cK=b end return b.c end end do local function __modImpl()
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
}
}end a.cL=function()local b=a.cache.cL if not b then b={c=__modImpl()}a.cache.cL=b end return b.c end end do local function __modImpl()
local b=a.g()
local c=a.ad()
local d=a.b6()
local e=a.b8()
local f=a.cb()
local g=a.b9()
local h=a.cm()

















local i={}

local function fail(j,k,l)
return{
success=false,
message=j,
options=k,
comment=l,
}
end


i.normalizeOptions=function(j)
if type(j)=="string"then
return string.split(j,"|")
end
return j or{}end



i.getOptions=function(j, k)
local l=(k and k.options)or j.options
return i.normalizeOptions(l)end



local function findOption(j,k)
local l=k:lower()

for m,n in j do
local o=tostring(n)
if o:lower()==l then
return o
end
end

return nil
end

local function keysOf(j)
if type(j)~="table"then return{}end
return h.unlookupify(j)
end

local function validateFreeText(j)
return{
success=true,
value=j,
color="string",
}
end

local function validateString(j,k)
local l=i.normalizeOptions(k.options)

if#l==0 then
return validateFreeText(j)
end

local m=findOption(l,j)

if m then
return{success=true,value=m,color="string"}
end

return fail(" - invalid option",l)
end

local j={
["true"]=true,yes=
true,enabled=
true,
["false"]=false,no=
false,disabled=
false,
}

local function validateBoolean(k)
local l=j[k:lower()]

if l==nil then
return fail(" - invalid boolean",{"false","true"})
end

return{
success=true,
value=l,
color="boolean",
}
end

local function validateNumber(k,l)
local m=tonumber(k)

if m==nil or m~=m or math.abs(m)==math.huge then
return fail" - invalid number"
end

local n,o=l.min,l.max

if l.clamp then
n,o=l.clamp[1],l.clamp[2]
end

if n and m<n then
return fail(` - the <b>MIN</b> is <b>{n}</b>`)
end

if o and m>o then
return fail(` - the <b>MAX</b> is <b>{o}</b>`)
end

if l.floor and math.floor(m)~=m then
return fail" - whole numbers only"
end


if tonumber(string.format("%.5f",m))~=m then
return fail" - too many decimal places"
end

return{
success=true,
value=m,
display=`<b>{m}</b>`,
color="number",
}
end

local function validateVector3(k)
local l=k:split","

if#l>3 then
return fail" - too many args"
end

local m={}

for n,o in l do

if o:match"^%s*$"then
o="0"
end

local p=validateNumber(o,{})

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
}
end

local function validateColor3(k)
local l=k:match"^#?(%x%x%x%x%x%x)$"

if l then
local m=tonumber(l:sub(1,2),16)
local n=tonumber(l:sub(3,4),16)
local o=tonumber(l:sub(5,6),16)

return{
success=true,
value=Color3.fromRGB(m,n,o),
color="others",
}
end

local m=k:split","

if#m~=3 then
return fail" - use R,G,B or #hex"
end

local n={}

for o,p in m do
local q=validateNumber(p,{min=0,max=255,floor=true})

if not q.success then
return q
end

n[o]=q.value
end

return{
success=true,
value=Color3.fromRGB(n[1],n[2],n[3]),
color="others",
}
end

local k={
me=true,
all=true,
others=true,
random=true,
}

local function validatePlayer(l)
if l==""then
return fail" - player missing"
end

local m=l:lower()


if k[m]or m:match"^#%d+$"or m:match"^%%.+$"then
return{success=true,value=l,color="valid"}
end

if#c:getPlayersByName(l)>0 then
return{success=true,value=l,color="valid"}
end

local n={}
for o,p in b.Players:GetPlayers()do
table.insert(n,p.Name)
end

return fail(" - player not found",n)
end

local l={
"BasePart","Part","MeshPart","Model","Folder","Script","LocalScript",
"ModuleScript","Sound","Humanoid","Tool","ClickDetector",
"ProximityPrompt","TouchTransmitter","SpawnLocation","Seat","VehicleSeat",
}

local function validateClassName(m)

local n=pcall(function()
local n=Instance.new(m)
n:Destroy()
end)

if n then
return{success=true,value=m,color="valid"}
end

return fail(" - invalid class name",l)
end

local function validateWaypoint(m)

local n=keysOf(e:getValue(tostring(game.PlaceId)))

if#n==0 then
return fail" - no waypoints created"
end

local o=findOption(n,m)

if o then
return{success=true,value=o,color="valid"}
end

return fail(" - invalid waypoint",n)
end

local function validateTeam(m)
local n={}

for o,p in b.Teams:GetTeams()do
table.insert(n,p.Name)
end

if#n==0 then
return fail" - there are no teams"
end

local o=findOption(n,m)

if o then
return{success=true,value=o,color="valid"}
end

return fail(" - invalid team",n)
end

local function validateKeycode(m)
local n=m:lower()
local o={}
local p

for q,r in Enum.KeyCode:GetEnumItems()do
table.insert(o,r.Name)

if r.Name:lower()==n then
p=r
end
end

if p then
return{success=true,value=p,color="valid"}
end

return fail(" - invalid key",o)
end

local function validateCommand(m)
local n=d.lookup[m:lower()]

if n then
return{success=true,value=n.name,color="valid"}
end

return fail(" - invalid command",d.array)
end


local function validateStoredName(m,n,o,p)
local q=keysOf(m:getData())

if#q==0 then
return fail(o)
end

local r=findOption(q,n)

if r then
return{success=true,value=r,color="valid"}
end

return fail(p,q)
end

local function validateAlias(m)
return validateStoredName(f,m," - no custom aliases"," - invalid alias")
end

local function validatePlugin(m)
return validateStoredName(g,m," - no plugins installed"," - invalid plugin")
end

local m={
string=validateString,
text=validateString,
object=validateFreeText,
boolean=validateBoolean,
number=validateNumber,
vector3=validateVector3,
color3=validateColor3,
player=validatePlayer,
waypoint=validateWaypoint,
className=validateClassName,
team=validateTeam,
keycode=validateKeycode,
command=validateCommand,
alias=validateAlias,
plugin=validatePlugin,
}

i.validate=function(n, o, p)
local q=m[o.kind]

if not q then
return fail(` - missing parser {o.kind}`)
end

return q(p,o)end


return i end a.cM=function()local b=a.cache.cM if not b then b={c=__modImpl()}a.cache.cM=b end return b.c end end do local function __modImpl()

local b=a.cj()
local c=a.ce()

local d=a.b6()
local e=a.cL()

local f=a.cm()
local g=a.cM()

local h=f.colorFromRGB
local i=f.escapeRichText

local j=f.lookupify{"`","'","\""}
local k=f.lookupify{" ","\t","\n","\r"}
local l=f.lookupify{",","|","&"}

local function getCommand(m)
return d.lookup[m]
end

local function colorFromName(m,n,o)
local p=e.args
return h(m,p[n]or o or p.others)
end

local function removeWhiteSpace(m)
local n=m:gsub(".",function(n)
return k[n]and"_"or n
end)
return n
end

local function argName(m,n)
if m.name then
return`'{removeWhiteSpace(m.name)}'`
end
return`#{n}`
end


local function findClosingQuote(m,n,o)
local p=o+1

while true do
local q=m:find(n,p,true)

if not q then
return nil
end

if m:sub(q-1,q-1)~="\\"then
return q
end

p=q+1
end
end



local function readIdentifier(m,n)
local o={}
local p=n
local q=#m

while p<=q do
local r=m:sub(p,p)

if k[r]then
break
end

table.insert(o,r)
p=p+1

if l[r]then
while p<=q and k[m:sub(p,p)]do
p=p+1
end
end
end

return table.concat(o),p-1
end

local function makeToken(m,n,o,p,q,r)
return{
kind=m,
value=n,
usedChar=r,
from=p,
to=q,
raw=o:sub(p,q),
}
end


local function splitMatch(m,n)
if n==""then
return"","",m
end

local o,p=m:lower():find(n:lower(),1,true)

if not o then
return"","",m
end

return m:sub(1,o-1),m:sub(o,p),m:sub(p+1)
end

local function quoteIfNeeded(m,n)
if n then
return n..m..n
end

if m:find"%s"then
return`"{m}"`
end

return m
end

local function makeCorrection(m,n,o,p)
return{
from=m,
to=n,
text=quoteIfNeeded(o,p),
}
end

local m={}
m.__index=m
m.colorFromName=colorFromName
m.removeWhiteSpace=removeWhiteSpace


m.parse=function(n, o)
local p=n.cmdInput
local q={}
local r=1
local s=#o

while r<=s do
local t=o:sub(r,r)

if k[t]then
r=r+1
else
local u=j[t]and findClosingQuote(o,t,r)

if u then
local v=(o:sub(r+1,u-1):gsub("\\"..t,t))
table.insert(q,makeToken("string",v,o,r,u,t))
r=u+1
else
local v,w=readIdentifier(o,r)
table.insert(q,makeToken("identifier",v,o,r,w))
r=w+1
end
end
end

local t=q[#q]
local u=t and(t.to+1)or 1
local v=o:sub(u)

local w={}
for x,y in q do
table.insert(w,y.value)
end

p.rawText=o
p.parsed=q
p.spacesAtEnd=v
p.noHighlightText=table.concat(w," ")..v

return q end



m.parseArg=function(n, o, p, q)
local r=n.cmdInput
local s=p.value
local t=g:validate(o,s)
local u=t.success and#s>0

local v={success=u,text=s}
if u then
v.value=t.value
end
r.args[q]=v

if u then
local w=t.display or i(s)
return{success=true,display=colorFromName(w,t.color or"valid")}
end

local w=g.getOptions(o,t)
local x

if#s>0 then
x=c:searchAtArray(w,s)[1]
end

if x then
local y,z,A=splitMatch(x,s)
r.correction=makeCorrection(p.from,p.to,x,p.usedChar)

return{
success=false,
suggestion=true,
display=colorFromName(i(y)..colorFromName(i(z),"warn")..i(A),"comment"),
}
end

return{
success=false,
display=colorFromName(i(s),t.color or"warn"),
message=t.message,
comment=t.comment,
}end



m.parsePending=function(n, o)
local p=n.cmdInput
local q=g:validate(o,"")
local r=g.getOptions(o,q)

if#r==0 then
return nil
end

local s=r[1]
local t=#p.rawText+1

if not o.optional then
p.correction={from=t,to=t-1,text=quoteIfNeeded(s)}
else
p.hasGhost=true
end

return colorFromName(i(s),"comment")end



m.highlightArgs=function(n, o, p, q, r)
local s=n.cmdInput
local t=o.args
local u=#t
local v=#p-1

local w=1
local x

for y,z in t do
local A=p[y+1]

if A==nil then
if q then
local B=n:parsePending(z)
if B then
table.insert(r,B)
end
end
break
end

local B=n:parseArg(z,A,y)
w=y+1

if B.display then
table.insert(r,B.display)
end

if not B.success then
x={index=y,result=B}
break
end
end


for y=w+1,math.min(#p,u+1)do
table.insert(r,i(p[y].raw))
end

local y=#p>u+1

if y then
local z=s.rawText:sub(p[u+2].from,p[#p].to)
table.insert(r,colorFromName(`<b>{i(z)}</b>`,"warn"))

s.runError=" - extra arg"
n:setComment(" - extra arg","warn")
return
end

if x then
local z=x.result


s.runError=` - {argName(t[x.index],x.index)} is invalid`

if z.message and not z.suggestion then
n:setComment(z.message,z.comment and"comment"or"warn")
end
return
end


for z=v+1,u do
local A=t[z]

if not A.optional then
s.runError=` - {argName(A,z)} is missing`
break
end
end

local z

if q then
z=v+1
elseif v>0 then
z=v
end

local A=z and t[z]

if A then
local B=q and""or": "
n:setComment(`{B}({n:highlightArgType(A)})`)
end end


m.highlightArgType=function(n, o)
local p=o.optional and colorFromName("?","symbol")or""
local q=`{colorFromName(o.kind,o.kind)}{p}`

if o.name then
return`{removeWhiteSpace(o.name)}: {q}`
end

return q end


m.highlightArgsType=function(n, o)
if#o==0 then return""end

local p={}

for q,r in o do
table.insert(p,n:highlightArgType(r))
end

return`({table.concat(p,", ")})`end


m.resetInput=function(n)
local o=n.cmdInput

o.highlightText=""
o.commandName=""
o.commandData=nil
o.isValidCommand=false
o.isAbreviated=false
o.bestMatch=nil
o.bestMatches={}
o.correctionText=nil
o.correction=nil
o.runError=nil
o.hasGhost=false
o.args={}

n:setComment""end



m.highlight=function(n, o)
local p=n.cmdInput
n:resetInput()

if#o==0 then return""end

local q=o[1]
local r=q.value
local s=r:lower()
local t=getCommand(s)
local u=t~=nil
local v=p.spacesAtEnd
local w=#v>0

p.commandName=s
p.commandData=t
p.isValidCommand=u
p.isAbreviated=u and t.name~=s

if not u then
p.bestMatches=b:search(s)
p.bestMatch=p.bestMatches[1]

if w or#o>1 or not p.bestMatch then
local x=p.rawText:sub(q.from,o[#o].to)

p.runError=" - invalid command"
n:setComment(" - invalid command","error")
p.highlightText=colorFromName(i(x),"error")..v

return p.highlightText
end
end

local x={}

if u then
table.insert(x,colorFromName(i(r),"valid"))
else
local y=p.bestMatch
local z,A,B=splitMatch(y,r)

table.insert(x,colorFromName(i(z)..colorFromName(i(A),"warn")..i(B),"comment"))

p.correctionText=y
p.correction=makeCorrection(q.from,q.to,y,q.usedChar)
p.runError=" - invalid command"
end

if u then

local y=#o==1 and not w

if y and#t.aliases>1 then
local z=table.clone(t.aliases)
local A=table.find(z,s)

if A then
table.remove(z,A)
end

n:setComment(`: [{table.concat(z,", ")}]`,"comment")
end

n:highlightArgs(t,o,w,x)
end

if p.correction or p.hasGhost then
v=""
end

local y=table.concat(x," ")..v
p.highlightText=y

return y end


m.setComment=function(n, ...)
return n.setCommentCallback(...)end


m.new=function(n, o)
return setmetatable({
cmdInput=n,
setCommentCallback=o
},m)end


return m end a.cN=function()local b=a.cache.cN if not b then b={c=__modImpl()}a.cache.cN=b end return b.c end end do local function __modImpl()

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


return b end a.cO=function()local b=a.cache.cO if not b then b={c=__modImpl()}a.cache.cO=b end return b.c end end do local function __modImpl()
local b=a.cf()
local c=a.g()
local d=a.ad()
local e=a.cy()
local f=a.cK()

local g=a.cj()
local h=a.cN()
local i=a.cO()

local j=a.cI()
local k=a.b6()

local l=a.b7()
local m=a.d()
local n=a.cm()
local o=a.cF()

local p=a.k()

local q=c.UserInputService
local r=c.RunService

local s=n.richFontSize

local t={}
t.__index=t

local function isValidInputType(u)
return j.pressingInputs[u.UserInputType]~=nil
end

local function getCommand(u)
return k.lookup[u]
end

local function zerofloor(u)
return math[(u<0)and"ceil"or"floor"](u)
end


local function cleanInput(u)
u=u:gsub("[\r\n]+$","")
u=u:gsub("[\r\n]+"," ")
return u
end


t.refresh=function(u, v)
local w=u.parser:parse(v)
u.parser:highlight(w)

u:updateSearchBoxHighlight()
u:updateSearchedCommand()end



t.applyCorrection=function(u)
local v=u.commandInput
local w=v.correction
local x=v.rawText

local y=x:sub(1,w.from-1)..w.text..x:sub(w.to+1)

if p:getValue"spaceAfterCorrection"then
y=y.." "
end

u.searchBox.Text=y end


t.awake=function(u)
local v=u.commandInput
local w=u.searchBox
local x=u.searchBoxHolder
local y=u.inputMarker

local z=x.Placeholder

local A=w:GetPropertyChangedSignal"Text"

local B=0

local function updateMarker()
if(tick()-B)>0.5 then
y.Visible=not y.Visible
B=tick()
end
end

local function closeSearchBox()
if w:IsFocused()then
w:ReleaseFocus()
end
end

local function captureFocus()
w:CaptureFocus()
end


local function onEnterPressed()
if v.correction then
u:applyCorrection()
task.defer(captureFocus)
return true
end


u:sendInputCommand()
return false
end

local function updatePlaceholder()
local C=not w:IsFocused()and#w.Text==0
z.Visible=C
end

u.commandClickedSignal:Connect(function(C)
w.Text=C.aliases[1]
task.defer(captureFocus)
end)

b:Connect(x.Activated,captureFocus)

b:Connect(w.Focused,function()
updatePlaceholder()
u.markerConnection=b:Connect(r.Stepped,updateMarker)

if#w.Text==0 then
u:setComment""
end
end)

b:Connect(w.FocusLost,function(C)
updatePlaceholder()
y.Visible=true
b:disconnect(u.markerConnection)

if C then
u:refresh(cleanInput(w.Text))
onEnterPressed()
end
end)

b:Connect(A,function()
local C=w.Text
local D=C:sub(-1)=="\n"or C:sub(-1)=="\r"

if C:find"[\r\n]"then
C=cleanInput(C)
w.Text=C

if D then
u:refresh(C)

if not onEnterPressed()then
closeSearchBox()
end
return
end
end

updatePlaceholder()
u:refresh(C)
end)end


t.sendInputCommand=function(u)
local v=u.commandInput

if v.runError then
u:setComment(v.runError,"error")
return
end

local w=v.commandData
if not w then return end

local x=w.name

local y,z=pcall(function()
local y=i.new(v.args)
return g:run(x,y)
end)

if p:getValue"clearOnEnter"then
u.searchBox.Text=""
end

if not y then
u:setComment(`failed - {z}`,"error")
m:error(`failed to run command '{x}': {z}`)
end end


t.create=function(u)
u.searchBoxHolder=e.new("ImageButton",{
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
TextSize=u.configs.textSize,
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
TextSize=u.configs.textSize-1,
Text=u.configs.placeholderText,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
}),
})

local v=u.searchBoxHolder
local w=v.Input.Holder

u.inputMarker=e.new("Frame","Marker",w,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

u.inputComment=e.new("TextLabel","Comment",w,{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromScale(1,0.5),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=u.configs.textSize,
RichText=true,
Text="",
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
}
})

u.commandInfo=e.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=u.configs.textFont,
TextSize=u.configs.textSize-5,
Visible=false,
e.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

u.searchBox=e.new("TextBox","SearchBox",{
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

u.commandsFolder=e.new("Folder","Commands")end


t.createCommandsData=function(u)
for v,w in k.original do
local x=f.new(w)
w.commandData=x
x.position=v-1
table.insert(u.commandsData,x)
end end


t.updateSearchBoxHighlight=function(u)
local v=u.commandInput.highlightText
local w=u.searchBoxHolder
local x=w.Input
local y=o:getScale()

x.Text=v
x.Visible=#v>0

local z=w.AbsoluteSize.X*y
local A=z/2
local B=x.AbsoluteSize.X*y

if B<=A then
x.AnchorPoint=Vector2.new(0,0.5)
x.Position=UDim2.new(0,5,0.5,0)
else
x.AnchorPoint=Vector2.new(1,0.5)
x.Position=UDim2.new(0.5,0,0.5,0)
end end


t.updateSearchedCommand=function(u)
local v=u.commandInput.bestMatch
local w=u.commandInput.commandName
if w==""then return end

local x=getCommand(w)
or(v and getCommand(v))

if x then
u.scrollBar:scrollTo(x.commandData.position)
end end


t.setComment=function(u, v, w)
if w~=nil then
v=h.colorFromName(v,w)
end

u.inputComment.Text=v
u.inputComment.Visible=#v>0 end


t.updateElementColor=function(u, v, w)
local x=if w%2==1 then 1 else 0.96
v.BackgroundTransparency=x end


t.updateElements=function(u)
local v=0
local w=0
local x={}
local y=u.scrollBar
local z=u.commandsFolder

for A,B in u.commandsData do
local C=y:isVisible(B.position)

if not C then
if B.element then B.element.Parent=nil end
continue
end

local D=B.element
if not D then
D=u:createCommandElement(B)
B.element=D
end

if not B.isSection then
if#B.args>0 and#B.name>w then
w=#B.name
end
table.insert(x,B)
end

u:updateElementColor(D,A)
D.Parent=z
D.Position=UDim2.fromOffset(
0,
v*(D.Size.Y.Offset+u.configs.padding)
)
v=v+1
end

for A,B in x do
u:updateDisplayName(B,w+3)
end

u.visibleCommands=x end


t.setCommandInfo=function(u, v)
v=v or""

if v==""then
u.commandInfo.Visible=false
return
end

u.commandInfo.Visible=true
u.commandInfo.Text=v end


t.createSection=function(u, v)


local w=e.new("TextLabel","Command",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
RichText=true,
TextSize=u.configs.textSize-3,
Text=`<b>#{v.sectionName}</b>`,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.MonoSpace"
},
})

return e.new("Frame",{
Size=UDim2.new(1,-10,0,u.configs.labelSize),
BackgroundTransparency=1,

w
})end


t.createCommandElement=function(u, v)
if v.isSection then
return u:createSection(v)
end

local w=e.new("TextLabel","Command",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.X,
RichText=true,
TextSize=u.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
})

return e.new("Frame",{
Size=UDim2.new(1,0,0,u.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
w
})end


t.createCommandDescription=function(u, v)
if v.isSection then return end
if not v.description then return end

local w=e.new("TextLabel","Description",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(25,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
TextSize=u.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
})

return e.new("Frame","Description",{
Size=UDim2.new(1,-30,0,u.configs.labelSize),
BackgroundTransparency=1,
w
})end


t.updateDisplayName=function(u, v, w)
local x=v.element
local y=v.name

local z=string.rep("—",(w-#y)-2)
local A=`{y} {h.colorFromName(z,"comment")} `

local B=u.parser:highlightArgsType(v.args)
local C=A..B

if v.isHolding then
v.originalText=C
else
u:setCommandText(v,C)
end end


t.setCommandText=function(u, v, w)
local x=v.element
if not x then return end

x.Command.Text=w end


t.getCommandText=function(u, v)
local w=v.element
return w and w.Command.Text or""end


t.calculateTotalSpace=function(u)
return#u.commandsData end


t.calculateVisibleSpace=function(u)
local v=u.scrollContainer.AbsoluteSize.Y
return math.floor(v/u:calculateLabelSize())end


t.calculateLabelSize=function(u)
return u.configs.padding+u.configs.labelSize end


t.getElementMouseIn=function(u)
for v,w in u.visibleCommands do
if d:isMouseInGuiObject(w.element)then
return w
end
end end


t.horizontalScroll=function(u, v)
for w,x in u.visibleCommands do
local y=x.element

y.Position=UDim2.fromOffset(
math.min(y.Position.X.Offset+v,0),
y.Position.Y.Offset
)
end end


t.startedHoldingContainer=function(u, v)
if not isValidInputType(v)then return end
if u.scrollBar:isScrollBarDisabled()then return end

u.scrollAxis=nil
u.scrollBar:disableScroll()

local w=d:getMouse()
local x=u:calculateLabelSize()
local y=u:getElementMouseIn()
local z=tick()

if y and y.description then
y.isHolding=true

local A=u.parser.colorFromName(y.description,"comment")

y.originalText=u:getCommandText(y)
u:setCommandText(y,A)
end

local A=w.Y
local B=w.X

local C,D

local function disconnect()
u.scrollBar:enableScroll()

if y then
y.isHolding=nil

if y.originalText then
u:setCommandText(y,y.originalText)
y.originalText=nil
end

if(tick()-z)<=0.15 then
u.commandClickedSignal:Fire(y)
end
end

if D then D:Disconnect()end
if C then C:Disconnect()end
end

D=b:Connect(q.InputEnded,function(E)
if not isValidInputType(E)then return end
disconnect()
end)

C=b:Connect(q.InputChanged,function(E)
if not isValidInputType(E)then return end

local F=w.X-B
local G=w.Y-A

if not u.scrollAxis then
if math.abs(F)>4 or math.abs(G)>4 then
u.scrollAxis=math.abs(F)>math.abs(G)and"x"or"y"
end
return
end

if u.scrollAxis=="x"then
local H=zerofloor(F/3)
if math.floor(H)~=0 then
u:horizontalScroll(H)
B=w.X
end
else
local H=zerofloor(G/x)
if math.floor(H)~=0 then
u.scrollBar:scrollTo(u.scrollBar.index-H)
A=w.Y
end
end
end)end


t.update=function(u)
u.scrollBar:setVisibleSpace(u:calculateVisibleSpace())
u.scrollBar:setTotalSpace(u:calculateTotalSpace())
u:updateElements()end


t.enable=function(u)
if u.isEnabled then return end
local v=u.scrollContainer
u.isEnabled=true

u.commandsFolder.Parent=v
u.searchBox.Parent=u.scrollHolder
u.searchBoxHolder.Parent=u.scrollHolder
u.commandInfo.Parent=u.scrollHolder

u.scrollConnection=u.scrolledSignal:Connect(function()
u:updateElements()
end)

u.containerConnection=v.InputBegan:Connect(function(w)
u:startedHoldingContainer(w)
end)

u:update()end


t.disable=function(u)
if not u.isEnabled then return end
u.isEnabled=false

u.commandsFolder.Parent=nil
u.searchBox.Parent=nil
u.searchBoxHolder.Parent=nil
u.commandInfo.Parent=nil

b:disconnect(u.containerConnection)
b:disconnect(u.markerConnection)
b:disconnect(u.scrollConnection)end


t.new=function(u)
local function cfg(v)
return assert(u.configs[v],`missing config.configs['{v}']`)
end

local v=setmetatable({
scrollContainer=u.scrollContainer,
scrolledSignal=u.scrolledSignal,
scrollHolder=u.scrollHolder,
scrollBar=u.scrollBar,

configs={
placeholderText=cfg"placeholderText",
padding=cfg"padding",
labelSize=cfg"labelSize",
textSize=cfg"textSize"
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
},t)

v.parser=h.new(v.commandInput,function(w,x)
return v:setComment(w,x)
end)

return v end


return t end a.cP=function()local b=a.cache.cP if not b then b={c=__modImpl()}a.cache.cP=b end return b.c end end do local function __modImpl()
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
}end a.cQ=function()local b=a.cache.cQ if not b then b={c=__modImpl()}a.cache.cQ=b end return b.c end end do local function __modImpl()


local b=a.cy()
local c=a.cB()
local d=a.cJ()

local e=a.cF()
local f=a.cf()
local g=a.a()
local h=a.o()

local i=a.cQ()

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
x.__index=x

local function escapeRichText(y)
return(y:gsub("[&<>]",u))
end

local function createTitle(y)
return b.new("TextLabel","Header",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=y,
TextSize=20,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})
end

local function createParagraph(y,z)
return b.new("TextLabel",z and"Bold"or"Text",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=y,
TextSize=14,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font=z and"Font.Bold"or"Font.Normal",
TextColor3="Colors.Text.Default",
},
})
end

local function createCases()
local y=b.new("Frame","Cases",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
b.new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for z,A in v do
local B,C=A[1],A[2]

b.new("TextLabel","Case",y,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=z,
RichText=true,
Size=UDim2.new(1,0,0,0),
Text=`<b>{escapeRichText(B)}</b> {escapeRichText(C)}`,
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

return y
end

local function createInviteButton(y)
local z=b.new("TextButton","InviteButton",{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,25),
Text=`Copy Discord Invite Link ({y})`,
TextSize=16,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local A=z.Text
local B

f:Connect(z.Activated,function()
if g.setclipboard then
g.setclipboard(y)
z.Text="Copied"
else
z.Text="No Clipboard Function, type out the link"
end

local C=tick()
B=C

task.wait(r)
if B~=C then return end

z.Text=A
end)

return z
end

local function createBlock(y)
local z=y[1]

if z=="title"then
return createTitle(y[2])
elseif z=="cases"then
return createCases()
elseif z=="invite"then
return createInviteButton(h.links.discord)
end

return createParagraph(y[2],z=="bold")
end

local function createSection(y,z,A)
local B=b.new("Frame","Section",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=y,
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

for C,D in z do
local E=createBlock(D)
E.LayoutOrder=C
E.Parent=B
end

if not A then
b.new("Frame","Line",B,{
BorderSizePixel=0,
LayoutOrder=#z+1,
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Colors.Stroke",
},
})
end

return B
end

x.new=function()
return setmetatable({},x)end


x.open=function(y)
y.frame:TweenPosition(t,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,q,true)end


x.close=function(y)
y.frame:TweenPosition(s,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,q,true)end


x.create=function(y)
local z=b.new("Frame","ReferenceFrame",{
Active=true,
BorderSizePixel=0,
Position=s,
Size=UDim2.fromOffset(j,m),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local A=b.new("Frame","TopBar",z,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,k),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

b.new("TextLabel","Title",A,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text="Reference",
TextSize=16,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local B=b.new("TextButton","Close",A,{
BackgroundTransparency=1,
Position=UDim2.new(1,-k,0,0),
Size=UDim2.fromOffset(k,k),
Text="",
})

local C=b.new("ImageLabel","Icon",B,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(10,10),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local D=d.new{
isHorizontal=false,
barThickness=n,
increment=o,
wheelIncrement=p,
}

local E=D:create()
local F=D.container

local G=b.new("Frame","Content",F,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
b.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

b.new("Frame","ScrollHolder",z,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,k),
Size=UDim2.new(1,0,0,l),

E,
F,
})

for H,I in w do
local J=createSection(H,I,H==#w)
J.Parent=G
end


local function applyScroll(H)
G.Position=UDim2.fromOffset(0,-H)
end

local function refreshScroll()
local H=e:getScale()

D:setTotalSpace(math.ceil(G.AbsoluteSize.Y/H))
D:setVisibleSpace(math.ceil(F.AbsoluteSize.Y/H))
applyScroll(D.index)
end

f:Connect(D.scrolledSignal,applyScroll)
f:Connect(G:GetPropertyChangedSignal"AbsoluteSize",refreshScroll)
f:Connect(F:GetPropertyChangedSignal"AbsoluteSize",refreshScroll)

f:Connect(F.MouseWheelForward,function()
D:scrollTo(D.index-D.wheelIncrement)
end)

f:Connect(F.MouseWheelBackward,function()
D:scrollTo(D.index+D.wheelIncrement)
end)

f:Connect(B.Activated,function()
y:close()
end)

local H=c.new(e.uiScale)
H:addGuiObject(z)

H.dragStarted:Connect(function(I)
if I~=z then return end
D:disableScroll()
end)

H.dragEnded:Connect(function(I)
if I~=z then return end
D:enableScroll()
end)

refreshScroll()

y.frame=z
y.closeIcon=C
y.scrollBar=D
y.dragInstance=H

return z end


return x end a.cR=function()local b=a.cache.cR if not b then b={c=__modImpl()}a.cache.cR=b end return b.c end end do local function __modImpl()


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
}end a.cS=function()local b=a.cache.cS if not b then b={c=__modImpl()}a.cache.cS=b end return b.c end end do local function __modImpl()


local b=a.cy()
local c=a.cB()
local d=a.cA()
local e=a.cx()
local f=a.ch()

local g=a.cm()

local h=a.cF()
local i=a.cf()
local j=a.a()
local k=a.ac()
local l=a.g()
local m=a.b()

local n=a.cS()
local o=a.cL().args

local p=UDim2.new(0.5,-n.window.width/2,0,n.window.shownY)
local q=UDim2.new(0.5,-n.window.width/2,0,n.window.hiddenY)

local r

local s=g.charset":#()[]-"
local t=g.charset"0123456789"

local u={}

local function getCharColor(v)
if t[v]then
return o.number
elseif s[v]then
return o.symbol
end

return nil
end

local function highlight(v)
local w=tostring(v)
local x={}
local y=""
local z

local function flushRun()
if y==""then return end

local A=g.escapeRichText(y)

if z then
table.insert(x,g.colorFromRGB(A,z))
else
table.insert(x,A)
end

y=""
end

for A in w:gmatch"."do
local B=getCharColor(A)

if B~=z then
flushRun()
z=B
end

y=y..A
end

flushRun()

return table.concat(x)
end

local function line(v,w)
return`{g.escapeRichText(v)}{highlight(w)}`
end

local function copyToClipboard(v)
if v==nil then return false end

if j.setclipboard then
j.setclipboard(tostring(v))
return true
end

f:notify(n.messages.noClipboard)
return false
end

local function formatTime(v)
local w=n.time
local x=math.floor(v/3600)
local y=math.floor((v%3600)/60)
local z=math.floor(v%60)

if x>0 then
return`{x} {w.hour}, {y} {w.minute}, {z} {w.second}`
elseif y>0 then
return`{y} {w.minute}, {z} {w.second}`
end

return`{z} {w.second}`
end

local function fetchPlaceName()
local v,w=pcall(function()
return l.MarketplaceService:GetProductInfo(game.PlaceId)
end)

if v and w then
return w.Name
end

return n.messages.unknownPlace
end

local function createCopyButton(v,w)
local x=n.copyButton

local y=b.new("TextButton","Copy",v,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-n.window.textInset,0.5,0),
Size=UDim2.fromOffset(x.width,x.height),
Text=x.idleText,
TextSize=n.textSizes.copyButton,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

b.new("UICorner",{
CornerRadius=UDim.new(0,x.cornerRadius),
}),
})

i:Connect(y.MouseEnter,function()
e:updateObjectProperties(y,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

i:Connect(y.MouseLeave,function()
e:updateObjectProperties(y,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

i:Connect(y.Activated,function()
if not copyToClipboard(w())then return end

y.Text=x.copiedText
task.wait(x.feedbackTime)
y.Text=x.idleText
end)

return y
end

local function createLine(v,w,x,y)
local z=n.window
local A=z.textInset
local B=0

if y.getCopyValue then
B=n.copyButton.width+n.copyButton.gap
end

local C=b.new("Frame","Row",v,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=(w%2==1)and z.stripeTransparency or 1,
BorderSizePixel=0,
LayoutOrder=w,
Size=UDim2.new(1,0,0,z.rowHeight),
})

local D=b.new("TextLabel",y.name,C,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(A,0),
RichText=true,
Size=UDim2.new(1,-(A*2+B),1,0),
Text=x,
TextSize=y.textSize,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=y.textColor,
},
})

if y.getCopyValue then
createCopyButton(C,y.getCopyValue)
end

return D
end

local function createSection(v,w,x)
return createLine(v,w,`<b>{g.escapeRichText(x)}</b>`,{
name="Section",
textSize=n.textSizes.section,
textColor="Colors.Text.Darker",
})
end

local function createValueLine(v,w,x,y)
return createLine(v,w,x,{
name="Value",
textSize=n.textSizes.value,
textColor="Colors.Text.Default",
getCopyValue=y,
})
end

local function createWindow()
local v=n.window

local w={
labels={},
placeName=nil,
}

local x=b.new("Frame","ServerInfo",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=q,
Size=UDim2.fromOffset(v.width,0),

b.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local y=b.new("Frame","TopBar",x,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,v.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

b.new("TextLabel","Title",y,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=v.title,
TextSize=n.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local z=b.new("ImageButton","Exit",y,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-v.closeInset,0.5,0),
Size=UDim2.fromOffset(v.closeIconSize,v.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

d:loadImage(z,"close")

i:Connect(z.Activated,function()
u:close()
end)

local A=b.new("Frame","Body",x,{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
LayoutOrder=2,
Size=UDim2.new(1,0,0,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},

b.new("UIPadding",{
PaddingBottom=UDim.new(0,v.verticalPadding),
PaddingTop=UDim.new(0,v.verticalPadding),
}),

b.new("UIListLayout",{
Padding=UDim.new(0,v.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local B=w.labels
local C=n.labels
local D=n.messages.loading

local E=0
local function nextOrder()
E=E+1
return E
end

createSection(A,nextOrder(),n.headers.localPlayer)

B.playerId=createValueLine(A,nextOrder(),line(C.playerId,k.UserId),function()
return k.UserId
end)

B.appearance=createValueLine(A,nextOrder(),line(C.appearance,k.CharacterAppearanceId),function()
return k.CharacterAppearanceId
end)

createSection(A,nextOrder(),n.headers.runTime)
B.time=createValueLine(A,nextOrder(),highlight(D))

createSection(A,nextOrder(),n.headers.statistics)
B.players=createValueLine(A,nextOrder(),line(C.players,D))
B.maxPlayers=createValueLine(A,nextOrder(),line(C.maxPlayers,D))

B.placeId=createValueLine(A,nextOrder(),line(C.placeId,game.PlaceId),function()
return game.PlaceId
end)

B.placeName=createValueLine(A,nextOrder(),line(C.placeName,D),function()
return w.placeName
end)

r=r or c.new(h.uiScale)
r:addGuiObject(x)

w.frame=x
return w
end

local function updateWindow(v)
local w=v.labels
local x=n.labels
local y=l.Players

while u.window==v do
w.players.Text=line(x.players,#y:GetPlayers())
w.maxPlayers.Text=line(x.maxPlayers,y.MaxPlayers)
w.time.Text=highlight(formatTime(workspace.DistributedGameTime))

task.wait(n.window.updateInterval)
end
end

u.create=function(v)
if v.isEnabled then
f:notify(n.messages.alreadyEnabled)
return
end

v.isEnabled=true

local w=createWindow()
v.window=w

local x=n.window.tweenTime

w.frame.Parent=m.screenGui
w.frame:TweenPosition(p,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,x,true)

task.spawn(function()
w.placeName=fetchPlaceName()
w.labels.placeName.Text=line(n.labels.placeName,w.placeName)
end)

task.spawn(updateWindow,w)

return w end


u.close=function(v)
local w=v.window
if not w then return end

local x=n.window.tweenTime

v.window=nil
v.isEnabled=false

w.frame:TweenPosition(q,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,x,true)

task.delay(x,function()
w.frame:Destroy()
end)end


return u end a.cT=function()local b=a.cache.cT if not b then b={c=__modImpl()}a.cache.cT=b end return b.c end end do local function __modImpl()


local b=a.o()
local c=a.b()
local d=a.cf()

local e=a.k()
local f=a.d()
local g=a.cm()

local h=a.cy()
local i=a.cA()
local j=a.cx()
local k=a.cB()
local l=a.cw()
local m=a.cC()

local n=a.cE()
local o=a.cF()

local p=a.cG()
local q=a.cJ()
local r=a.cP()
local s=a.cR()
local t=a.cT()

local u=o.uiScale

local v={}

local function resolveTheme(w)
local x=type(w)=="string"and l[w:lower()]

if x and x.Colors and x.Font then
return w
end

return b.theme.defaultTheme
end

v.createScreenGui=function(w)
local x=h.new("ScreenGui",{
IgnoreGuiInset=true,
Name=g.randomString(math.random(30,50)),
DisplayOrder=2147483647
})

w.screenGui=x
return x end


v.calculateScale=function(w, x)
return(w.screenGui.AbsoluteSize.Y/450)*x end


v.setScale=function(w, x)
x=math.abs(x)

if x>=3 then
x=w:calculateScale(x)
end

if e:getValue"interface.uiScale"~=x then
e:setValue("interface.uiScale",x)
e:save()
end

o:setScale(x)
w:updateMainFramePosition()end


v.calculateMainFramePosition=function(w)
local x=w.mainFrame
local y=w.screenGui

local z=x.Size
local A=x.Position
local B=o:getScale()

local C=math.ceil(y.AbsoluteSize.X/B)
local D=math.ceil(y.AbsoluteSize.Y/B)

return UDim2.fromOffset(
math.clamp(A.X.Offset,0,math.max(C-z.X.Offset,0)),
math.clamp(A.Y.Offset,0,math.max(D-z.Y.Offset,0))
)end


v.updateMainFramePosition=function(w)
if w.mainFrame then
w.mainFrame.Position=w:calculateMainFramePosition()
end end


v.createMainScroll=function(w, x)
local y=q.new{
isHorizontal=false,
barThickness=12
}

local z=y:create()
local A=y.container

local B=h.new("Frame","ScrollHolder",x,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

z,
A
})

w.scrollHolder=B
w.scrollBar=y
w.scrollContainer=A

return y end


v.createMainFrame=function(w)
local x=p:create()
local y=x.mainFrame

x.titleLabel.Text=n.getDisplayName()

w.mainFrame=y
w.topBar=x.topBar
w.buttons=x.buttons

i:loadImage(w.buttons.settings,"settings")
i:loadImage(w.buttons.reference,"reference")

d:Connect(w.buttons.settings.Activated,function()
print"clicked settings"
end)

w:createMainScroll(y)

return y end


v.createCommands=function(w)
local x=w.scrollBar

local y=r.new{
scrolledSignal=x.scrolledSignal,
scrollContainer=w.scrollContainer,
scrollHolder=w.scrollHolder,
scrollBar=x,

configs={
placeholderText=b.ui.commands.placeholderText,
padding=b.ui.commands.padding,
labelSize=b.ui.commands.labelSize,
textSize=b.ui.commands.textSize
}
}

f:log"created commands interface"
y:create()

f:log"initialized commands"
y:createCommandsData()

f:log"awaked commands module"
y:awake()

w.commands=y
return y end


v.createInfoMenu=function(w)
return t:create()end


v.dragMainFrame=function(w, x)
local y=k.new(u)

x.Size=b.ui.window.windowSize
x.Position=UDim2.fromOffset(1e5,1e5)
x.Position=w:calculateMainFramePosition()

y:addGuiObject(x)

y:setFilter(x,function(z)
x.Position=z
return w:calculateMainFramePosition()
end)

y.dragStarted:Connect(function(z)
if z~=x then return end
w.scrollBar:disableScroll()
end)

y.dragEnded:Connect(function(z)
if z~=x then return end
w.scrollBar:enableScroll()
end)

w.dragService=y end


v.createReference=function(w)
local x=s.new()
local y=x:create()

i:loadImage(x.closeIcon,"close")

y.Parent=w.screenGui
w.reference=x

d:Connect(w.buttons.reference.Activated,function()
x:open()
end)

return x end


v.destroy=function(w)
if w.screenGui then
w.screenGui:Destroy()
end end


v.init=function(w)
f:debug"interface: initializing theme service"
j:init{
theme=resolveTheme(b.theme.selectedTheme)
}

local x=w:createScreenGui()


x.Parent=m
c.screenGui=x

u.Parent=x
w:setScale(e:getValue"interface.uiScale"or 1)

local y=w:createMainFrame()

w:createCommands()
w:dragMainFrame(y)
w.commands:enable()

y.Parent=x
w:createReference()

return x end


return v end a.cU=function()local b=a.cache.cU if not b then b={c=__modImpl()}a.cache.cU=b end return b.c end end do local function __modImpl()

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


return d end a.cV=function()local b=a.cache.cV if not b then b={c=__modImpl()}a.cache.cV=b end return b.c end end do local function __modImpl()


local b=a.cj()
local c=a.ad()
local d=a.ck()

local e=a.cl()

local f=a.cU()

local g={}

g.boot=function(h)a.cV()
:init()

b:init{
infiniteYield=f,
playerService=c,
fetchService=d
}

e(b)

f:init()end


return g end a.cW=function()local b=a.cache.cW if not b then b={c=__modImpl()}a.cache.cW=b end return b.c end end end














return a.cW():boot()