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
delfile=c("function",delfile),
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
c:log("destroyed old interface")
end

if b.connectionService then
b.connectionService:cleanup()
b.connectionService=nil
c:log("cleaned old connections")
end

for g,h in b.iyGarbages or{}do
e(h)
end

c:log("finished cleanup!")end


return d end a.e=function()local c=a.cache.e if not c then c={c=b()}a.cache.e=c end return c.c end end do local b=function()
local b={}

local c=a.a()
local d=a.d()

b.__index=function(e, f)
d:expect(f,{"string"},"[index] serviceName")

local g=game:GetService(f)
local h=c.cloneref(g)

rawset(e,f,h)
return h end


return setmetatable({},b)end a.f=function()local c=a.cache.f if not c then c={c=b()}a.cache.f=c end return c.c end end do local b=function()
local b=a.f()
return b.Players.LocalPlayer end a.g=function()local c=a.cache.g if not c then c={c=b()}a.cache.g=c end return c.c end end do local b=function()
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


return c end a.h=function()local c=a.cache.h if not c then c={c=b()}a.cache.h=c end return c.c end end do local b=function()
local b=a.f()
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

downloadPath="backups/%s/%s/%s",
encryptKey=676767
}end a.j=function()local c=a.cache.j if not c then c={c=b()}a.cache.j=c end return c.c end end do local b=function()
local b=a.a()

local c=a.h()
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
local n=m:split("/")
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
local t=r:split(".")
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



i.readFile=function(q, r)
return l(q:getRealPath(r))end



i.makeFolder=function(q, r)
m(q:getRealPath(r))end



i.getEntry=function(q, r)
return q.object[r]end



i.setEntry=function(q, r, s)
q.object[r]=s end




i.delete=function(q, r)
local s=q:getRealPath(r)

if not j(s)then
return true
end

if b.delfile==nil then
return false
end

pcall(b.delfile,s)
return not j(s)end


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
q.isSaving=false


if r==nil then return end

if q.encryptData then
r=c:encrypt(r)
end

q:writeFile(r)
end)end


i.getCustomAsset=function(q, r)
r=q:getRealPath(r)
return o(r)end


i.getData=function(q)
return table.clone(q.object)end



i.replaceData=function(q, r)
d:expect(r,{"table"},"'fileSystem:replaceData' #1")

q.object=table.clone(r)
q:save()end


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
return a.k().new("storage/createdWaypoints")end a.l=function()local c=a.cache.l if not c then c={c=b()}a.cache.l=c end return c.c end end do local b=function()
return a.k().new("storage/installedPlugins")end a.m=function()local c=a.cache.m if not c then c={c=b()}a.cache.m=c end return c.c end end do local b=function()
return a.k().new("storage/settings")end a.n=function()local c=a.cache.n if not c then c={c=b()}a.cache.n=c end return c.c end end do local b=function()
return a.k().new("storage/.userData",{
encrypt=true
})end a.o=function()local c=a.cache.o if not c then c={c=b()}a.cache.o=c end return c.c end end do local b=function()
return a.k().new("storage/aliases")end a.p=function()local c=a.cache.p if not c then c={c=b()}a.cache.p=c end return c.c end end do local b=function()
return a.k().new("storage/totalUsedCommands")end a.q=function()local c=a.cache.q if not c then c={c=b()}a.cache.q=c end return c.c end end do local b=function()
return a.k().new("storage/eventBinds")end a.r=function()local c=a.cache.r if not c then c={c=b()}a.cache.r=c end return c.c end end do local b=function()



return a.k().new("storage/backgrounds")end a.s=function()local c=a.cache.s if not c then c={c=b()}a.cache.s=c end return c.c end end do local b=function()

return{
waypoints=a.l(),
plugins=a.m(),
settings=a.n(),
user=a.o(),
aliases=a.p(),
usedCmds=a.q(),
eventBinds=a.r(),
backgrounds=a.s(),
}end a.t=function()local c=a.cache.t if not c then c={c=b()}a.cache.t=c end return c.c end end do local b=function()

local b=a.g()
local c=a.t()local d=function()


local d=c.settings
d:register("clearOnEnter",true)
d:register("spaceAfterCorrection",true)
d:register("uiScale",1.4)
d:save()end local e=function()





return DateTime.now().UnixTimestamp end local f=function()



local f=c.user
local g=f:register("usedPlaces",{})

f:register("totalUsedCommands",{})
f:register("usedAccounts",{})


f:register("firstTimeExecuted",e())
f:register("lastTimeExecuted",0)
f:register("executionCount",0)

f:add("usedAccounts",b.UserId)
f:increment("executionCount",1)
f:setValue("lastTimeExecuted",e())


local h=tostring(game.GameId)
g[h]=(g[h]or 0)+1

f:save()end


d()
f()

return true end a.u=function()local c=a.cache.u if not c then c={c=b()}a.cache.u=c end return c.c end end do local b=function()
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


return c end a.v=function()local c=a.cache.v if not c then c={c=b()}a.cache.v=c end return c.c end end do local b=function()
return{
action="discord|support|help",
description="Invite to the Infinite Yield discord server.",
run=function(b)
b.executorEnv.setclipboard(b.config.links.discord)
end
}end a.w=function()local c=a.cache.w if not c then c={c=b()}a.cache.w=c end return c.c end end do local b=function()
return{
action="console",
description="Opens the Roblox console",
run=function(b)
b.starterGui:SetCore("DevConsoleVisible",true)
end
}end a.x=function()local c=a.cache.x if not c then c={c=b()}a.cache.x=c end return c.c end end do local b=function()



local b=3 local c=function(



c, d, e, f, g)
if not g then
c:notify(d,"started loading")
end

local h=false

task.delay(b,function()
if not h then
c:notify(d,"is taking a while to load, still loading...")
end
end)

local i=c.fetchService.load(e,f)
h=true

if i==nil then
c:notify(d,"could not be loaded")
elseif not g then
c:notify(d,"finished loading")
end

return i end local d=function(


d)
local e=c(d,"Old Console","backups/oldconsole.luau","iy/oldconsole")
if e then e()end end local e=function(


e, f)
local g
if f==true then
g=c(e,"Dex Explorer","backups/explorer.luau","iy/explorer")
else
g=c(e,"Dex Explorer","backups/dexPlusPlus.luau","iy/dexPlusPlus")
end

if g then g()end end local f=function(


f, g)
local h=c(f,"Emote Menu","backups/emotes/notify.luau","iy/7yd7/notify.luau",true)
local i=h and h()or function()end

local j=g:nextValue()
local k=g:nextValue()

local l=c(f,"Emote Menu","backups/emotes/main.luau","iy/7yd7/emotes.luau")
if not l then return end

l({
notifyFunction=if k~=false then i else function()end,
isMobile=f.isMobile,
keycode=j,
})end local g=function(


g)
local h=c(g,"Cobalt","backups/cobalt.luau","iy/cobalt")
if h then h()end end local h=function(


h)
local i=c(h,"Remote Spy","backups/remotespy/main.luau","iy/remotespy")
if i then i()end end local i=function(


i)
local j=c(i,"Audio Logger","backups/audiologger.luau","iy/audiologger")
if j then j()end end


return{
{
action="oldconsole",
description="Loads an old-themed Roblox console",
run=function(j)task.spawn(d,j)end
},
{
action="explorer|dex",
description="Opens the dex Explorer",
args={name="load dex by moon",kind="boolean",optional=true},
run=function(j,k)task.spawn(e,j,k:nextValue())end
},
{
action="emotemenu|7yd7",
description="Opens animations/emotes menu By 7yd7",
run=function(j,k)task.spawn(f,j,k)end,
args={
{kind="keycode",name="open menu",optional=true},
{kind="boolean",name="notify",optional=true},
}
},
{
action="cobalt|remotespy|rspy|cspy",
description="Opens Cobalt to intercept incoming and outgoing network traffic",
run=function(j)task.spawn(g,j)end
},
{
action="simplespy|simplespy|sspy",
description="Opens Simple Spy V3 to intercept remote calls from the client to the server",
run=function(j)task.spawn(h,j)end
},
{
action="audiologger|alogger",
description="Opens Edges audio logger",
run=function(j)task.spawn(i,j)end
}
}end a.y=function()local c=a.cache.y if not c then c={c=b()}a.cache.y=c end return c.c end end do local b=function()

return{
action="serverinfo|info|sinfo",
description="Gives you info about the server",
run=function(b)
b.infiniteYield:createInfoMenu()
end
}end a.z=function()local c=a.cache.z if not c then c={c=b()}a.cache.z=c end return c.c end end do local b=function()
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
local e=d:expectExploit("setclipboard")
if not e then return end

e(tostring(game.PlaceId))
d:notify("Copied","place id copied to your clipboard")
end
},
{
action="copygameid",
description="Copies the current game id to your clipboard",
run=function(d)
local e=d:expectExploit("setclipboard")
if not e then return end

e(tostring(game.GameId))
d:notify("Copied","game id copied to your clipboard")
end
}
}end a.A=function()local c=a.cache.A if not c then c={c=b()}a.cache.A=c end return c.c end end do local b=function()local b=function(


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
}end a.B=function()local c=a.cache.B if not c then c={c=b()}a.cache.B=c end return c.c end end do local b=function()

return{
action="rejoin|rj",
description="Makes you rejoin the game",
run=function(b)
b.playerService:teleportToJobId(game.JobId)
end
}end a.C=function()local c=a.cache.C if not c then c={c=b()}a.cache.C=c end return c.c end end do local b=function()
return{
action="autorejoin|autorj",
description="Automatically rejoins the server if you get kicked/disconnected",
run=function(b)
if b.privateEnv.autoRejoinConn then
b:notify("auto rejoin is already enabled")
return
end

b.privateEnv.autoRejoinConn=b:connect(b.guiService.ErrorMessageChanged,function()
b:run("rejoin")
end)
end
}end a.D=function()local c=a.cache.D if not c then c={c=b()}a.cache.D=c end return c.c end end do local b=function()



local b=3 local c=function(

c, d, e)
local f=`https://games.roblox.com/v1/games/{d}/servers/Public?sortOrder=Asc&limit=100`
if e then
f=f.."&cursor="..e
end

local g=c({Url=f,Method="GET"})
return game:GetService("HttpService"):JSONDecode(g.Body)end


return{
{
action="serverhop|shop",
description="Teleports you to a different server",
run=function(d)
local e=d:expectExploit("httprequest")
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
}end a.E=function()local c=a.cache.E if not c then c={c=b()}a.cache.E=c end return c.c end end do local b=function()

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
}end a.F=function()local c=a.cache.F if not c then c={c=b()}a.cache.F=c end return c.c end end do local b=function()
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
}end a.G=function()local c=a.cache.G if not c then c={c=b()}a.cache.G=c end return c.c end end do local b=function()
return{
action="antiafk|antiidle",
description="Prevents the game from kicking you for being idle/afk",
run=function(b)
local c=b.executorEnv.getconnections
local d=b.privateEnv

if d.enabledAntiAfk then
b:notify("anti AFK is already enabled")
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

b:notify("anti AFK is now enabled")
end
}end a.H=function()local c=a.cache.H if not c then c={c=b()}a.cache.H=c end return c.c end end do local b=function()
return{
action="datalimit",
description="Set outgoing KBPS limit",
args={kind="number",name="KB per second"},
run=function(b,c)
local d=c:nextValue()
b.networkClient:SetOutgoingKBPSLimit(d)
end
}end a.I=function()local c=a.cache.I if not c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()
return{
action="replicationlag|backtrack",
description="Set IncomingReplicationLag",
args={kind="number"},
run=function(b,c)
b.gameNetworkSettings.IncomingReplicationLag=c:nextValue()
end
}end a.J=function()local c=a.cache.J if not c then c={c=b()}a.cache.J=c end return c.c end end do local b=function()
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
}end a.K=function()local c=a.cache.K if not c then c={c=b()}a.cache.K=c end return c.c end end do local b=function()local b=function(
b)
if not b:IsA("PackageLink")then return end

if b.Parent:FindFirstChild("ADpart")then
b.Parent:Destroy()
end

if b.Parent:FindFirstChild("AdGuiAdornee")then
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
}end a.L=function()local c=a.cache.L if not c then c={c=b()}a.cache.L=c end return c.c end end do local b=function()


return{
{
action="saveinstance|savegame|saveplace|savep",
description="Uses saveinstance to save the game",
run=function(b)
local c=b:expectExploit("saveinstance")
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
}end a.M=function()local c=a.cache.M if not c then c={c=b()}a.cache.M=c end return c.c end end do local b=function()

return{
action="clearerror",
description="Clears the annoying box and blur when a game kicks you",
run=function(b)
b.guiService:ClearError()
end
}end a.N=function()local c=a.cache.N if not c then c={c=b()}a.cache.N=c end return c.c end end do local b=function()

local b="CoreScripts/NetworkPause"local c=function(

c)
local d=c:collectGarbage("antigameplaypaused")
if d then
d.connection:Disconnect()
end end


return{
{
action="antigameplaypaused",
description="Clears the annoying box shown when a game is loading assets due to network lag",
run=function(d)
c(d)

local e=d.coreGui:FindFirstChild("RobloxGui")
if not e then
d:notify("Anti Pause","RobloxGui was not found")
return
end

local f=d:createGarbage("antigameplaypaused")
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
}end a.O=function()local c=a.cache.O if not c then c={c=b()}a.cache.O=c end return c.c end end do local b=function()

return{
action="clientantikick|antikick",
description="Prevents localscripts from kicking you (CLIENT)",
run=function(b)
if b.privateEnv.clientAntiKick then
b:notify("Client Antikick","already active")
return
end

local c=b:expectExploit("hookmetamethod")
local d=b:expectExploit("getnamecallmethod")
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
}end a.P=function()local c=a.cache.P if not c then c={c=b()}a.cache.P=c end return c.c end end do local b=function()

return{
action="clientantiteleport|antiteleport",
description="Prevents localscripts from teleporting you (CLIENT)",
run=function(b)
if b.privateEnv.clientAntiTeleport then
b:notify("Client AntiTP","already active")
return
end

local c=b:expectExploit("hookmetamethod")
local d=b:expectExploit("getnamecallmethod")
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
local m=f:getValue("allowRejoin")==true and l==game.PlaceId
if not m then return end
end
end
return i(j,...)
end)

b.privateEnv.clientAntiTeleport=true
b:notify("Client AntiTP","Client anti teleport is now active (only effective on localscript teleport)")
end
}end a.Q=function()local c=a.cache.Q if not c then c={c=b()}a.cache.Q=c end return c.c end end do local b=function()

return{
client=true,
action="allowrejoin|allowrj",
description="Changes if antiteleport allows you to rejoin or not",
args={kind="boolean",name="allow",optional=true},
run=function(b,c)
local d=c:nextValue()


if d==nil then
d=not b.storage.settings:getValue("allowRejoin")
end

b.storage.settings:setValue("allowRejoin",d)
b:notify("Client AntiTP",`Scripts now {d and"may"or"may not"} make you rejoin the server`)
end
}end a.R=function()local c=a.cache.R if not c then c={c=b()}a.cache.R=c end return c.c end end do local b=function()

return{
action="cancelteleport|canceltp",
description="Cancels teleports in progress",
run=function(b)
b.playerService:cancelTween()
b.teleportService:TeleportCancel()
end
}end a.S=function()local c=a.cache.S if not c then c={c=b()}a.cache.S=c end return c.c end end do local b=function()

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
}end a.T=function()local c=a.cache.T if not c then c={c=b()}a.cache.T=c end return c.c end end do local b=function()
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
local e=workspace:FindFirstChildWhichIsA("Terrain")
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
if g:IsA("BasePart")then
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
e:notify("anti lag is already enabled")
return
end

e.privateEnv.antiLagEnabled=true
d(e)
end
}end a.U=function()local c=a.cache.U if not c then c={c=b()}a.cache.U=c end return c.c end end do local b=function()
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
local d=c:createGarbage("alignmentkeys")
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
local d=c:collectGarbage("alignmentkeys")
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
local f=e:FindFirstChild("BoundKeys")

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
action="exit|shutdown|leave",
description="Kills roblox process",
run=function()
game:shutdown()
end
}end a.ac=function()local c=a.cache.ac if not c then c={c=b()}a.cache.ac=c end return c.c end end do local b=function()


return{
action="breakloops|break",
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

local b=a.f()
local c=a.g()
local d=a.d()

local e=b.TeleportService
local f=b.TweenService

local g=c:GetMouse()

local h={}

local i
local j=100
local k

h.getMouse=function(l)
return g end


h.isMouseInGuiObject=function(l, m)
local n=m.AbsolutePosition
local o=m.AbsoluteSize

return g.X>=n.X
and g.X<n.X+o.X
and g.Y>=n.Y
and g.Y<n.Y+o.Y end


h.teleportToJobId=function(l, m, n)
n=n or game.PlaceId
e:TeleportToPlaceInstance(n,m,c)end


h.isAlive=function(l, m)
local n=if m
then m:FindFirstChildOfClass("Humanoid")
else l:getHumanoid()

return n~=nil and n.Health>0 end


h.getCharacter=function(l)
return c.Character end


h.getHumanoid=function(l)
local m=l:getCharacter()
return m and m:FindFirstChildOfClass("Humanoid")end


h.getRootPart=function(l)
local m=l:getHumanoid()
return m and m.RootPart end


h.resetCharacter=function(l)
local m=l:getCharacter()
if not m then return end

local n=m:FindFirstChildOfClass("Humanoid")
if n then
n:ChangeState(Enum.HumanoidStateType.Dead)
else
m:BreakJoints()
end end


h.getPlayersByName=function(l, m)
local n={}

local o=#m
m=m:lower()

for p,q in b.Players:GetPlayers()do
local r=string.lower(q.Name):sub(1,o)
local s=string.lower(q.displayName):sub(1,o)

if r==m or s==m then
table.insert(n,q)
end
end

return n end


h.getCamera=function(l)
return workspace.CurrentCamera end


h.unseat=function(l)
local m=l:getHumanoid()
if not m then return nil end

if m.SeatPart~=nil then
m.Sit=false
task.wait(0.1)
end

return l:getHumanoid()end


h.setRootCFrame=function(l, m)
local n=l:getRootPart()
if not n then return false end

n.CFrame=m
n.AssemblyLinearVelocity=Vector3.zero
return true end


h.teleportTo=function(l, m)
d:expect(m,{"CFrame","Vector3"},"'playerService:teleportTo' #1")

if typeof(m)=="Vector3"then
m=CFrame.new(m)
end

l:unseat()
return l:setRootCFrame(m)end


h.breakVelocity=function(l, m)
local n=l:getCharacter()
if not n then return end

local o=os.clock()+(m or 1)
task.spawn(function()
while os.clock()<o and n.Parent do
for p,q in n:GetDescendants()do
if q:IsA("BasePart")then
q.AssemblyLinearVelocity=Vector3.zero
q.AssemblyAngularVelocity=Vector3.zero
end
end
task.wait()
end
end)end local l=function()



local l=k
k=nil

if l and l.humanoid.Parent then
l.humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,l.wasEnabled)
end end local m=function(


m)
if k and k.humanoid==m then return end

l()
k={
humanoid=m,
wasEnabled=m:GetStateEnabled(Enum.HumanoidStateType.Seated)
}
m:SetStateEnabled(Enum.HumanoidStateType.Seated,false)end


h.cancelTween=function(n)
local o=i
i=nil

l()

if o then
o:Cancel()
return true
end

return false end


h.tweenTeleportTo=function(n, o)
d:expect(o,{"table"},"'playerService:tweenTeleportTo' #1")

local p=o.target
local q=o.speed or j

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
m(v)
end

local w=TweenInfo.new(t,Enum.EasingStyle.Linear)
local x=f:Create(r,w,{
CFrame=p
})

i=x
x.Completed:Once(function()
if i~=x then return end

i=nil
l()
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


return h end a.af=function()local c=a.cache.af if not c then c={c=b()}a.cache.af=c end return c.c end end do local b=function()

local b=a.f()
local c=a.af()
local d=a.g()local e=function(







e)
for f=#e,2,-1 do
local g=math.random(1,f)
e[f],e[g]=e[g],e[f]
end
return e end local f=function(


f)
local g=f.Character
return g and g:FindFirstChildOfClass("Humanoid")end local g=function(


g)
local h=g.Character
return h and h:FindFirstChild("HumanoidRootPart")end local h=function(


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
return(r and s:IsInGroup(r))or false
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
return r:match("^%s*(.-)%s*$")end local s=function(



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

for z in x:gmatch("[^,]+")do
local A=r(z)

if A~=""then
table.insert(y,A)
end
end

return y end local y=function(



y)
return y~=nil and y:find("[,+%-]")~=nil end local z=function(




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
})end a.ag=function()local c=a.cache.ag if not c then c={c=b()}a.cache.ag=c end return c.c end end do local b=function()

local b=a.ag()

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
}end a.ah=function()local c=a.cache.ah if not c then c={c=b()}a.cache.ah=c end return c.c end end do local b=function()

return{
action="inviteprompt",
description="Prompts the game invite window, so you can invite friends",
run=function(b)
local c=game:GetService("SocialService")

local d,e=pcall(function()
c:PromptGameInvite(b.localPlayer)
end)

if not d then
b:notify("Invite Prompt","could not open the invite prompt: "..tostring(e))
end
end
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

local b=a.ag()

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

local e=d:FindFirstChildWhichIsA("Humanoid")
if e then
e:ChangeState(Enum.HumanoidStateType.Dead)
end

d:ClearAllChildren()

local f=Instance.new("Model")
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
if i:IsA("SpawnLocation")and i.BrickColor==e.TeamColor and i.AllowTeamChangeOnTouch then
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

local b=a.ag()

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
local e=c:expectExploit("firetouchinterest")
if not e then return end

local f=c.playerService:getCharacter()
local g=f and f:FindFirstChildWhichIsA("Tool")
local h=g and g:FindFirstChild("Handle")
if not h then
c:notify("Handle Kill",'You need to hold a "Tool" that does damage on touch.')
return
end

local i=b(d:nextValue())
local j=d:nextValue()or math.huge


local k=c:collectGarbage("handlekill")
if k then
k.running=false
end

local l=c:createGarbage("handlekill")
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
local r=q and q:FindFirstChildWhichIsA("Humanoid")
local s=q and q:FindFirstChild("HumanoidRootPart")

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




local b=a.f()
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
i.localPlayer:Kick("rolewatch: a watched player joined")
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

local o=k:createGarbage("rolewatch")
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

local l=k:createGarbage("staffwatch")local m=function(

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

if c:IsA("Terrain")then
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
b:run("mousetp")
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
b:run("reset")
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

return{a.w()
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
,a.as()
,a.at()
,a.au()

}end a.av=function()local c=a.cache.av if not c then c={c=b()}a.cache.av=c end return c.c end end do local b=function()

return"v0.9.0"end a.aw=function()local c=a.cache.aw if not c then c={c=b()}a.cache.aw=c end return c.c end end do local b=function()
return{
owner="tlredz",
repository="iy-remake"
}end a.ax=function()local c=a.cache.ax if not c then c={c=b()}a.cache.ax=c end return c.c end end do local b=function()
local b=a.ax()

return{
discord="https://discord.gg/78ZuWSq",
github=`https://github.com/{b.owner}/{b.repository}`
}end a.ay=function()local c=a.cache.ay if not c then c={c=b()}a.cache.ay=c end return c.c end end do local b=function()


local b=a.n()

return{
applicationName="Infinite Yield RV",
isRemakeVersion=true,
version=a.aw(),
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

links=a.ay(),
storage=a.j(),
}end a.az=function()local c=a.cache.az if not c then c={c=b()}a.cache.az=c end return c.c end end do local b=function()
local b=a.az().ui.scale

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
}end a.aA=function()local c=a.cache.aA if not c then c={c=b()}a.cache.aA=c end return c.c end end do local b=function()
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
}end a.aB=function()local c=a.cache.aB if not c then c={c=b()}a.cache.aB=c end return c.c end end do local b=function()
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
}end a.aC=function()local c=a.cache.aC if not c then c={c=b()}a.cache.aC=c end return c.c end end do local b=function()local b=function(
b, c)
local d=b:collectGarbage(c)
if not d then return end

for e,f in d do
e.Visible=f
end

local e=b:registerGarbage("bindedHideGuis")
e[c]=nil end local c=function(


c, d, e)
local f=c:registerGarbage("bindedHideGuis")

for g,h in f do
b(c,g)
end

f[d]=true

local g=c:createGarbage(d)
local h=c.localPlayer.PlayerGui

for i,j in h:GetDescendants()do
if j:IsA("GuiObject")and j.Visible~=e then
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
}end a.aD=function()local c=a.cache.aD if not c then c={c=b()}a.cache.aD=c end return c.c end end do local b=function()
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


return b end a.aE=function()local c=a.cache.aE if not c then c={c=b()}a.cache.aE=c end return c.c end end do local b=function()











return{
bindings={
prefix={
label="Prefix",
settingKey="keybinds.prefix",
default="Semicolon",
also={"RightControl"},
group="interface",
},

flyUp={
label="Up",
settingKey="keybinds.flyUp",
default="E",
group="fly",
},
flyDown={
label="Down",
settingKey="keybinds.flyDown",
default="Q",
group="fly",
},

floatUp={
label="Up",
settingKey="keybinds.floatUp",
default="E",
group="float",
},
floatDown={
label="Down",
settingKey="keybinds.floatDown",
default="Q",
group="float",
},

freecamBoost={
label="Boost (held)",
settingKey="keybinds.freecamBoost",
default="LeftControl",
group="freecam",
},
},

groups={
{key="fly",title="Fly"},
{key="float",title="Float"},
{key="freecam",title="Freecam"},
},
}end a.aF=function()local c=a.cache.aF if not c then c={c=b()}a.cache.aF=c end return c.c end end do local b=function()local b=function(

b)
local c={}

for d,e in b do

local f=Enum.KeyCode[d]
c[f]=e
end

return c end


return b({Quote=
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
})end a.aG=function()local c=a.cache.aG if not c then c={c=b()}a.cache.aG=c end return c.c end end do local b=function()









local b=a.f()
local c=a.aE()
local d=a.n()
local e=a.aF()
local f=a.aG()

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


return h end a.aH=function()local c=a.cache.aH if not c then c={c=b()}a.cache.aH=c end return c.c end end do local b=function()



local b=a.aH()local c=function(

c)
local d=c:collectGarbage("hideiy")
if d and d.connection then
d.connection:Disconnect()
end end local d=function(




d, e)
c(d)

local f=d:registerGarbage("hideiy")
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

local g=b:getBindingName("prefix")
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
}end a.aI=function()local c=a.cache.aI if not c then c={c=b()}a.cache.aI=c end return c.c end end do local b=function()

return{a.aA()


,a.aB()
,a.aC()
,a.aD()
,a.aI()

,

}end a.aJ=function()local c=a.cache.aJ if not c then c={c=b()}a.cache.aJ=c end return c.c end end do local b=function()






local b=a.f()
local c=a.aH()

local d=b.UserInputService

local e={}

local f=Vector3.one*9e9 local g=function(


g)
local h=Vector3.new(g.X,0,g.Z)
if h.Magnitude==0 then
return Vector3.zero
end
return h.Unit end local h=function(



h, i)
local j=workspace.CurrentCamera.CFrame
local k=i.MoveDirection

local l=k:Dot(g(j.LookVector))
local m=k:Dot(g(j.RightVector))

local n=0
if h.privateEnv.qeFly~=false then
if d:IsKeyDown(c:getBinding("flyUp"))then
n=n+1
end
if d:IsKeyDown(c:getBinding("flyDown"))then
n=n-1
end
end

local o=j.LookVector*l+j.RightVector*m+Vector3.yAxis*n
if o.Magnitude>1 then
o=o.Unit
end
return o end



e.stop=function(i, j)
local k=i:collectGarbage(j)
if not k then return end

if k.connection then
k.connection:Disconnect()
end
if k.velocity then
k.velocity:Destroy()
end
if k.gyro then
k.gyro:Destroy()
end
if k.humanoid then
k.humanoid.PlatformStand=false
end end






e.start=function(i, j)
e.stop(i,j.garbageName)

local k=i.playerService:getHumanoid()
local l=i.playerService:getRootPart()
if not(k and l)then
i:notify("Fly","your character is not loaded")
return
end

local m=Instance.new("BodyVelocity")
m.MaxForce=f
m.Velocity=Vector3.zero
m.Parent=l

local n=Instance.new("BodyGyro")
n.MaxTorque=f
n.P=9e4
n.CFrame=l.CFrame
n.Parent=l

if j.platformStand then
k.PlatformStand=true
end

local o=i:createGarbage(j.garbageName)
o.velocity=m
o.gyro=n
o.humanoid=k
o.kind=j.kind

o.connection=i:connect(i.runService.Heartbeat,function()
if not l:IsDescendantOf(workspace)or k.Health<=0 then
e.stop(i,j.garbageName)
return
end

m.Velocity=h(i,k)*j.getSpeed()
n.CFrame=workspace.CurrentCamera.CFrame
end)end


return e end a.aK=function()local c=a.cache.aK if not c then c={c=b()}a.cache.aK=c end return c.c end end do local b=function()

local b=a.aK()

local c=100

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
elseif d.privateEnv.flySpeed then
d:notify("Fly",`no speed given, using the last speed set: {d.privateEnv.flySpeed}`)
else
d:notify("Fly",`no speed given, using the default speed: {c}`)
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
description="Set fly speed (default is 100)",
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
local f=d:getGarbage("fly")
if f and f.kind=="fly"then
d:run("unfly")
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
}end a.aL=function()local c=a.cache.aL if not c then c={c=b()}a.cache.aL=c end return c.c end end do local b=function()



local b="Noclip"
local c={kind="string",name="nonotify",optional=true}local d=function(

d)
local e=d:collectGarbage("noclip")
if not e then return false end

e.connection:Disconnect()

for f in e.parts do
if f.Parent then
f.CanCollide=true
end
end

return true end local e=function(


e)
local f=e:createGarbage("noclip")
f.parts=setmetatable({},{__mode="k"})

f.connection=e:connect(e.runService.Stepped,function()
local g=e.playerService:getCharacter()
if not g then return end

local h=e:getGarbage("float")
local i=h and h.platform

for j,k in g:GetDescendants()do
if k:IsA("BasePart")and k.CanCollide and k~=i then
k.CanCollide=false
f.parts[k]=true
end
end
end)end


return{
{
action="noclip",
description="Go through objects",
args=c,
run=function(f,g)
local h=g:nextValue()=="nonotify"

d(f)
e(f)

if not h then
f:notify(b,"Noclip Enabled")
end
end
},
{
action="unnoclip|clip",
description="Disables noclip",
args=c,
run=function(f,g)
local h=g:nextValue()=="nonotify"
d(f)

if not h then
f:notify(b,"Noclip Disabled")
end
end
},
{
action="togglenoclip",
description="Toggles noclip",
run=function(f)
f:run(if f:hasGarbage("noclip")then"unnoclip"else"noclip")
end
}
}end a.aM=function()local c=a.cache.aM if not c then c={c=b()}a.cache.aM=c end return c.c end end do local b=function()

local b=a.aK()

local c=100

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
local f=d:getGarbage("fly")
if f and f.kind=="vehiclefly"then
d:run("unvehiclefly")
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
}end a.aN=function()local c=a.cache.aN if not c then c={c=b()}a.cache.aN=c end return c.c end end do local b=function()

local b=50 local c=function(


c)
local d=c:collectGarbage("cframefly")
if not d then return end

d.connection:Disconnect()
d.humanoid.PlatformStand=false
d.head.Anchored=false end local d=function(



d)
c(d)

local e=d.playerService:getHumanoid()
local f=d.playerService:getCharacter()
local g=f and f:FindFirstChild("Head")
if not(e and g)then
d:notify("cframefly","your character is not loaded")
return
end

e.PlatformStand=true
g.Anchored=true

local h=d:createGarbage("cframefly")
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
}end a.aO=function()local c=a.cache.aO if not c then c={c=b()}a.cache.aO=c end return c.c end end do local b=function()

return{
action="qefly|flyqe",
description="Enables or disables the up and down keys for fly (set them in Settings > Command Settings)",
args={
kind="boolean",
optional=true
},
run=function(b,c)

b.privateEnv.qeFly=c:nextValue()~=false
end
}end a.aP=function()local c=a.cache.aP if not c then c={c=b()}a.cache.aP=c end return c.c end end do local b=function()local b=function(


b)
local c=b
while c and not c:IsA("Model")do
c=c.Parent
end
return c end local c=function(


c)
local d=c:collectGarbage("vehiclenoclip")
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

local h=d:createGarbage("vehiclenoclip")
h.parts={}

for i,j in g:GetDescendants()do
if j:IsA("BasePart")and j.CanCollide then
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
d:run(if d:hasGarbage("vehiclenoclip")then"vehicleclip"else"vehiclenoclip")
end
},
{
action="vehicleclip|vclip|unvnoclip",
description="Enables vehicle collision",
run=function(d)
c(d)
end
},
}end a.aQ=function()local c=a.cache.aQ if not c then c={c=b()}a.cache.aQ=c end return c.c end end do local b=function()

local b=a.aH()

local c=-3.1 local d=function(

d)
local e=d:collectGarbage("float")
if not e then return end

for f,g in e.connections do
g:Disconnect()
end
e.platform:Destroy()end local e=function(


e)
if e:hasGarbage("float")then
e:notify("float is already enabled")
return
end

local f=e.playerService:getCharacter()
local g=e.playerService:getRootPart()
if not(f and g)then
e:notify("Float","your character is not loaded")
return
end

local h=Instance.new("Part")
h.Name="IYFloatPlatform"
h.Transparency=1
h.Size=Vector3.new(2,0.2,1.5)
h.Anchored=true
h.CFrame=g.CFrame*CFrame.new(0,c,0)
h.Parent=f

local i=e:createGarbage("float")
i.platform=h
i.offset=c
i.connections={}

table.insert(i.connections,e:connect(e.runService.Heartbeat,function()
local j=e.playerService:getRootPart()
if not(j and h:IsDescendantOf(workspace))then
d(e)
return
end

h.CFrame=j.CFrame*CFrame.new(0,i.offset,0)
end))



table.insert(i.connections,e:connect(e.robloxServices.UserInputService.InputBegan,function(j,k)
if k then return end

if j.KeyCode==b:getBinding("floatUp")then
i.offset=i.offset+1.5
elseif j.KeyCode==b:getBinding("floatDown")then
i.offset=i.offset-0.5
end
end))

table.insert(i.connections,e:connect(e.robloxServices.UserInputService.InputEnded,function(j)
if j.KeyCode==b:getBinding("floatUp")then
i.offset=i.offset-1.5
elseif j.KeyCode==b:getBinding("floatDown")then
i.offset=i.offset+0.5
end
end))

e:notify("Float",`Enabled ({b:getBindingName("floatDown")} = down & {b:getBindingName("floatUp")} = up)`)end


return{
{
action="float|platform",
description="Spawns a platform beneath you causing you to float",
run=function(f)
e(f)
end
},
{
action="togglefloat",
description="Toggles float",
run=function(f)
f:run(if f:hasGarbage("float")then"unfloat"else"float")
end
},
{
action="unfloat|noplatform|nofloat|unplatform",
description="Removes the platform",
run=function(f)
if not f:hasGarbage("float")then return end

d(f)
f:notify("Float","Disabled")
end
}
}end a.aR=function()local c=a.cache.aR if not c then c={c=b()}a.cache.aR=c end return c.c end end do local b=function()local b=function()



local b={}
for c,d in Enum.HumanoidStateType:GetEnumItems()do
if d~=Enum.HumanoidStateType.None and d~=Enum.HumanoidStateType.Dead then
table.insert(b,d)
end
end
return b end local c=function(


c)
local d=c:collectGarbage("swim")
if not d then return end

for e,f in d.connections do
f:Disconnect()
end
for e,f in d.states do
d.humanoid:SetStateEnabled(f,true)
end
workspace.Gravity=d.gravity end local d=function(


d)
if d:hasGarbage("swim")then
d:notify("swim is already enabled")
return
end

local e=d.playerService:getHumanoid()
if not e then
d:notify("swim","your character is not loaded")
return
end

local f=d:createGarbage("swim")
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
if e:hasGarbage("swim")then
c(e)
else
d(e)
end
end
}
}end a.aS=function()local c=a.cache.aS if not c then c={c=b()}a.cache.aS=c end return c.c end end do local b=function()local b=function(

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
if h:IsA("BasePart")then
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
}end a.aT=function()local c=a.cache.aT if not c then c={c=b()}a.cache.aT=c end return c.c end end do local b=function()local b=function(
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
}end a.aU=function()local c=a.cache.aU if not c then c={c=b()}a.cache.aU=c end return c.c end end do local b=function()local b=function(


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
return e:IsA("SpecialMesh")end


return{
{
action="blockhead",
description="Removes the mesh from your head (makes it block-like)",
run=function(f)
local g=c(f)
local h=g and g:FindFirstChild("Head")
local i=h and h:FindFirstChildOfClass("SpecialMesh")
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
if i:IsA("Tool")or i:IsA("HopperBin")then
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
return g:IsA("BillboardGui")or g:IsA("SurfaceGui")
end)
end
},
{
action="naked",
description="Removes your clothing and shirt graphics",
run=function(f)
b(c(f),function(g)
return g:IsA("Clothing")or g:IsA("ShirtGraphic")
end)
end
},
{
action="noface|removeface",
description="Removes your face decal",
run=function(f)
b(c(f),function(g)
return g:IsA("Decal")and g.Name=="face"
end)
end
},
{
action="deletehats|nohats|rhats",
description="Removes the welds that hold your accessories on",
run=function(f)
b(c(f),function(g)
return g:IsA("Weld")and g:FindFirstAncestorWhichIsA("Accessory")~=nil
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

local i=g:FindFirstChild("UpperTorso")
local j=i and i:FindFirstChild("Waist")
if j then
j:Destroy()
end
end
}
}end a.aV=function()local c=a.cache.aV if not c then c={c=b()}a.cache.aV=c end return c.c end end do local b=function()

local b=a.ag()local c=function(

c)
return c:IsA("Tool")or c:IsA("HopperBin")end local d=function(


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
d(e.localPlayer:FindFirstChildOfClass("Backpack"))
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
local f=e.localPlayer:FindFirstChildOfClass("Backpack")
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
local f=e.localPlayer:FindFirstChildOfClass("Backpack")
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
local g=e.localPlayer:FindFirstChildOfClass("Backpack")
if not g then return end

for h,i in b(f:nextValue())do
local j=i:FindFirstChildOfClass("Backpack")
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
}end a.aW=function()local c=a.cache.aW if not c then c={c=b()}a.cache.aW=c end return c.c end end do local b=function()

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
local h=g and g:FindFirstChild("Animate")
if h then
h.Disabled=f
end end local f=function(


f)
local g=f.playerService:getHumanoid()
local h=f.localPlayer.Character
local i=h and h:FindFirstChild("Animate")

if not(g and i)then
f:notify("Refresh Animations","Failed to get Animate/Humanoid")
return
end

i.Disabled=true
d(g)
i.Disabled=false end local g=function(


g)
local h=g:collectGarbage("dance")
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
if not l:find("rbxassetid://")then
l="rbxassetid://"..l
end

local n=Instance.new("Animation")
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

local l=j:nextValue()
local m,n=pcall(function()
return k:PlayEmoteAndGetAnimTrackById(l)
end)


if not m or not n then
i:notify("Emote",`there is no emote with the ID {l}`)
return
end

local o=j:nextValue()
if n and o then
n:AdjustSpeed(o)
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
local l=Instance.new("Animation")
l.AnimationId="rbxassetid://"..k[math.random(1,#k)]

local m=j:LoadAnimation(l)
m.Looped=true
m:Play()

i:registerGarbage("dance").track=m
end
},
{
action="undance|nodance",
description="Stops the dance",
run=function(i)
g(i)
end
}
}end a.aX=function()local c=a.cache.aX if not c then c={c=b()}a.cache.aX=c end return c.c end end do local b=function()local b=function(

b, c)
local d=b.localPlayer.Character
if not d then return end

for e,f in d:GetDescendants()do
if f:IsA("BasePart")then
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
}end a.aY=function()local c=a.cache.aY if not c then c={c=b()}a.cache.aY=c end return c.c end end do local b=function()


local b=workspace.FallenPartsDestroyHeight

return{
{
action="antivoid",
description="Pushes you back up when you fall below the destroy height",
run=function(c)
if c:hasGarbage("antivoid")then
c:notify("antivoid is already enabled")
return
end

local d=c:createGarbage("antivoid")
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
local d=c:collectGarbage("antivoid")
if d and d.connection then
d.connection:Disconnect()
c:notify("antivoid","Disabled")
end
end
}
}end a.aZ=function()local c=a.cache.aZ if not c then c={c=b()}a.cache.aZ=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage("spasm")
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

local f=Instance.new("Animation")
f.AnimationId="rbxassetid://33796059"

local g=e:LoadAnimation(f)
g:Play()
g:AdjustSpeed(99)

d:registerGarbage("spasm").track=g
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

local f=Instance.new("Animation")
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
local g=e and e:FindFirstChild("Animate")
if not(f and g)then return end

local h=g:FindFirstChild("sit")
local i=h and h:FindFirstChildWhichIsA("Animation")
if not i then return end

for j,k in{"idle","walk","run","jump"}do
local l=g:FindFirstChild(k)
local m=l and l:FindFirstChildWhichIsA("Animation")
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

local g=Instance.new("BodyAngularVelocity")
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
}end a.a_=function()local c=a.cache.a_ if not c then c={c=b()}a.cache.a_=c end return c.c end end do local b=function()local b=function(

b)
return b:IsA("BillboardGui")or b:IsA("SurfaceGui")end local c=function(


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

local g=e:FindFirstChild("Head")
local h=g and g:FindFirstChildOfClass("SpecialMesh")
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

local f=d:collectGarbage("nobgui")
if f and f.connection then
f.connection:Disconnect()
end

for g,h in e:GetDescendants()do
if b(h)then
h:Destroy()
end
end

local g=d:createGarbage("nobgui")
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
local e=d:collectGarbage("nobgui")
if e and e.connection then
e.connection:Disconnect()
end
end
}
}end a.a0=function()local c=a.cache.a0 if not c then c={c=b()}a.cache.a0=c end return c.c end end do local b=function()

return{
{
action="noroot|removeroot|rroot",
description="Removes your character's root part (client side)",
run=function(b)
local c=b.localPlayer.Character
if not c then return end

local d=c:FindFirstChildOfClass("Humanoid")
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
}end a.a1=function()local c=a.cache.a1 if not c then c={c=b()}a.cache.a1=c end return c.c end end do local b=function()local b=function(




b)
local c=b:registerGarbage("removespecifictool")
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
local g=c.localPlayer:FindFirstChildOfClass("Backpack")
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
local f=c:getGarbage("removespecifictool")
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
local d=c:collectGarbage("removespecifictool")
if not(d and d.connections)then return end

for e,f in d.connections do
f:Disconnect()
end
end
}
}end a.a2=function()local c=a.cache.a2 if not c then c={c=b()}a.cache.a2=c end return c.c end end do local b=function()

local b=a.ag()

return{
{
action="walkto|follow",
description="Walks your character to a player and keeps following them",
args={kind="player"},
run=function(c,d)
local e=b(d:nextValue())[1]
if not e then return end

local f=c:collectGarbage("walkto")
if f then
f.running=false
end

local g=c.playerService:getHumanoid()
if g and g.SeatPart then
g.Sit=false
task.wait(0.1)
end

local h=c:createGarbage("walkto")
h.running=true

task.spawn(function()
while h.running do
local i=c.playerService:getHumanoid()
local j=e.Character and e.Character:FindFirstChild("HumanoidRootPart")

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
local d=c:collectGarbage("walkto")
if d then
d.running=false
end
end
}
}end a.a3=function()local c=a.cache.a3 if not c then c={c=b()}a.cache.a3=c end return c.c end end do local b=function()local b=function(

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
k(m:WaitForChild("Humanoid"))
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
}end a.a4=function()local c=a.cache.a4 if not c then c={c=b()}a.cache.a4=c end return c.c end end do local b=function()

local b=a.W()

local c=PhysicalProperties.new(100,0.3,0.5)


local d=Vector3.yAxis*99999 local e=function()


local e=Instance.new("BodyAngularVelocity")

e.MaxTorque=Vector3.new(0,math.huge,0)
e.P=math.huge
return e end local f=function(


f)
if f:hasGarbage("fling")then
f:notify("fling is already enabled\ndisable using 'unfling'")
return
end

local g=f.playerService:getHumanoid()
if not(g and g.Health~=0)then return end

local h=f:getRoot()
if not h then return end

local i=g.Parent

f:notify("fling now is activated")

f:run("noclip",b.new({{value="nonotify"}}))

local j=f:createGarbage("fling")
j.originalStates={}

for k,l in i:GetDescendants()do
if not l:IsA("BasePart")then continue end

j.originalStates[l]={
CustomPhysicalProperties=l.CustomPhysicalProperties,
Massless=l.Massless
}

l.CustomPhysicalProperties=c
end

local k=e()
j.flingVelocity=k

j.flingConnection=f:connect(g.Died,function()
f:notify("player died: disabling fling...")
f:run("unfling")
end)


j.flingThread=task.spawn(function()

task.wait(0.1)
if f:getGarbage("fling")~=j then return end

for l,m in i:GetChildren()do
if m:IsA("BasePart")then
m.Massless=true
m.Velocity=Vector3.zero
end
end

k.Parent=h


while f:getGarbage("fling")==j and h.Parent do
k.AngularVelocity=d
task.wait(0.2)
k.AngularVelocity=Vector3.zero
task.wait(0.1)
end
end)end local g=function(


g)
local h=g:collectGarbage("fling")
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

g:notify("fling disabled")end




local h=0.1 local i=function(

i, j)
return i~=nil and i.Parent~=nil and j~=nil and j.Parent~=nil end local j=function(


j)
if j:hasGarbage("walkfling")then
j:notify("walkfling is already enabled\ndisable using 'unwalkfling'")
return
end

local k=j:createGarbage("walkfling")


if not j:hasGarbage("noclip")then
j:run("noclip",b.new({{value="nonotify"}}))
k.enabledNoclip=true
end

local l=j.runService local m=function()

return j:getGarbage("walkfling")==k end


k.thread=task.spawn(function()
while m()do
l.Heartbeat:Wait()

local n=j.playerService:getCharacter()
local o=n and n:FindFirstChild("HumanoidRootPart")

while m()and not i(n,o)do
l.Heartbeat:Wait()
n=j.playerService:getCharacter()
o=n and n:FindFirstChild("HumanoidRootPart")
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
j:run("unwalkfling")
end)
end end local k=function(


k)
local l=k:collectGarbage("walkfling")
if not l then return end

if l.diedConnection then
l.diedConnection:Disconnect()
end

if l.enabledNoclip then
k:run("unnoclip",b.new({{value="nonotify"}}))
end end local l=function(


l, m)
l:run("unvehiclefly")
l:run("unwalkfling")

local n=m and m:nextValue()
if n then
l.privateEnv.vehicleFlySpeed=n
end


l:run("vehiclefly",b.new({}))
j(l)

local o=l:getGarbage("walkfling")
if o then
o.flyfling=true
end end local m=function(


m)
m:run("unvehiclefly")
m:run("unwalkfling")
m:run("breakvelocity")end


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
n:run(if n:hasGarbage("fling")then"unfling"else"fling")
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
local p=n:getGarbage("walkfling")
if p and p.flyfling then
n:run("unflyfling")
else
n:run("flyfling",o)
end
end
},
{
action="togglewalkfling",
description="Toggles walkfling",
run=function(n)
n:run(if n:hasGarbage("walkfling")then"unwalkfling"else"walkfling")
end
},
{
action="toggleantifling",
description="Toggles antifling",
run=function(n)
n:run(if n:hasGarbage("antifling")then"unantifling"else"antifling")
end
},
{
action="invisfling",
description="Enables invisible fling (the invis part is patched, try using the god command before using this)",
run=function(n)
n:run("invisible")

task.spawn(function()
n:run("fling")
end)
end
},
{
action="antifling",
description="Disables player collisions to prevent you from being flung",
run=function(n)
if n:hasGarbage("antifling")then return end

local o=n:createGarbage("antifling")
o.connection=n:connect(n.runService.Stepped,function()
for p,q in n.players:GetPlayers()do
if q~=n.localPlayer and q.Character then
for r,s in q.Character:GetDescendants()do
if s:IsA("BasePart")then
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
local o=n:collectGarbage("antifling")
if o then
o.connection:Disconnect()
end
end
}
}end a.a5=function()local c=a.cache.a5 if not c then c={c=b()}a.cache.a5=c end return c.c end end do local b=function()local b=function(


b, c)
local d=b.playerService:getCharacter()
if not d then return end

for e,f in d:GetDescendants()do
if(f:IsA("BasePart")or f:IsA("Decal"))and c.originals[f]==nil then
c.originals[f]=f.Transparency
f.Transparency=1
end
end end local c=function(


c)
local d=c:getGarbage("invisible")
if d and d.connection and d.connection.Connected then
c:notify("Invisible","you are already invisible")
return
end

local e={}
if d then
e=d.originals or{}
c:collectGarbage("invisible")
if d.connection then
d.connection:Disconnect()
end
end

local f=c:createGarbage("invisible")
f.originals=e

b(c,f)

f.connection=c:connect(c.localPlayer.CharacterAdded,function()
b(c,f)
end)

c:notify("Invisible","other players can no longer see your character")end local d=function(


d)
local e=d:collectGarbage("invisible")
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
e:run(if e:hasGarbage("invisible")then"visible"else"invisible")
end
},
{
action="toolinvisible|toolinvis|tinvis",
description="Makes you invisible to other players and able to use tools",
run=function(e)
c(e)
end
}
}end a.a6=function()local c=a.cache.a6 if not c then c={c=b()}a.cache.a6=c end return c.c end end do local b=function()local b=function(

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
}end a.a7=function()local c=a.cache.a7 if not c then c={c=b()}a.cache.a7=c end return c.c end end do local b=function()local b=function(


b)
local c=b:collectGarbage("hatspin")
if not c then return end

c.connection:Disconnect()

for d,e in c.accessories do
local f=e:FindFirstChild("Handle")
if f then
for g,h in f:GetChildren()do
if h:IsA("BodyPosition")or h:IsA("BodyAngularVelocity")then
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

local h=c:createGarbage("hatspin")
h.character=f
h.accessories={}
h.keeps={}

for i,j in e:GetAccessories()do
local k=j:FindFirstChild("Handle")
local l=k and k:FindFirstChildOfClass("Weld")
if l then
l:Destroy()


local m=Instance.new("BodyPosition")
m.P=30000
m.D=50
m.Parent=k

local n=Instance.new("BodyAngularVelocity")
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

local j=f:FindFirstChild("Head")
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
local d=c:expectExploit("firetouchinterest")
if not d then return end


task.spawn(function()
local e=c.playerService:getCharacter()
local f=c.playerService:getHumanoid()
local g=c.playerService:getRootPart()
if not(e and f and g)then return end

local h=g.CFrame

local i={}
for j,k in workspace:GetChildren()do
if k:IsA("Accessory")then
table.insert(i,k)
end
end

for j,k in f:GetAccessories()do
k:Destroy()
end

for j,k in i do
local l=k:FindFirstChild("Handle")
local m=c.playerService:getRootPart()
if l and m then
d(l,m,0)
end


local n=0
while e.Parent and not e:FindFirstChildOfClass("Accessory")and n<120 do
task.wait()
n=n+1
end

local o=e:FindFirstChildOfClass("Accessory")
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
}end a.a8=function()local c=a.cache.a8 if not c then c={c=b()}a.cache.a8=c end return c.c end end do local b=function()



local b=60


local function copyTools(c,d)
for e,f in c:GetChildren()do
if f:IsA("Tool")or f:IsA("HopperBin")then
f:Clone().Parent=d
end
copyTools(f,d)
end
end local c=function(

c)
if not c then return end

for d,e in c:GetChildren()do
if e:IsA("Tool")then
e.CanBeDropped=true
end
end end local d=function(




d, e)
local f=d.playerService:getHumanoid()
if f and e:IsA("BackpackItem")and e:FindFirstChild("Handle")then
f:EquipTool(e)
end end local e=function(


e)
local f=e:collectGarbage("grabtools")
if f and f.connection then
f.connection:Disconnect()
end end local f=function(


f)
e(f)

local g=f:createGarbage("grabtools")

for h,i in workspace:GetChildren()do
d(f,i)
end

g.connection=f:connect(workspace.ChildAdded,function(h)
d(f,h)
end)end local g=function(





g)
local h=g:collectGarbage("reach")
if not h then return end

for i,j in h.records do
local k=j.handle

local l=k:FindFirstChild("SelectionBoxCreated")
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

local l=h:createGarbage("reach")
l.records={}

for m,n in j:GetDescendants()do
if not n:IsA("Tool")then continue end

local o=n:FindFirstChild("Handle")
if not(o and o:IsA("BasePart"))then continue end

table.insert(l.records,{
tool=n,
handle=o,
size=o.Size,
massless=o.Massless,
gripPos=n.GripPos
})

local p=Instance.new("SelectionBox")
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
local j=i.localPlayer:FindFirstChildOfClass("Backpack")
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
local k=i.localPlayer:FindFirstChildOfClass("Backpack")
if not k then
i:notify("Dupetools","your backpack is not loaded")
return
end


local l=math.clamp(math.floor(j:nextValue()or 1),1,100)
local m=0

for n,o in k:GetChildren()do
if o:IsA("Tool")or o:IsA("HopperBin")then
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
c(i.localPlayer:FindFirstChildOfClass("Backpack"))
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
local l=i.localPlayer:FindFirstChildOfClass("Backpack")
if not(k and l)then return end

local m=j:nextValue()
for n,o in k:GetChildren()do
if o:IsA("Tool")then
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
local k=i.localPlayer:FindFirstChildOfClass("Backpack")
local l=i.playerService:getCharacter()
if not(k and l)then return end

local m=j:nextValue()or 1
local n=j:nextValue()

for o,p in k:GetChildren()do
if not p:IsA("Tool")then continue end

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
}end a.a9=function()local c=a.cache.a9 if not c then c={c=b()}a.cache.a9=c end return c.c end end do local b=function()local b=function(


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

local e=d:createGarbage("autojump")
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

local e=d:createGarbage("edgejump")
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
}end a.ba=function()local c=a.cache.ba if not c then c={c=b()}a.cache.ba=c end return c.c end end do local b=function()local b=function(




b, c, d)
local e=b.privateEnv.spoofs or{}
b.privateEnv.spoofs=e

local f=e[c]
if f then
f.value=d
return
end

local g=b:expectExploit("hookmetamethod")
local h=b:expectExploit("checkcaller")
if not(g and h)then return end

local i=b.localPlayer
local j=string.lower(c)

f={value=d}
e[c]=f local k=function(

k, l)
if h()or typeof(k)~="Instance"or typeof(l)~="string"then
return false
end
if string.lower(l)~=j or not k:IsA("Humanoid")then
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
}end a.bb=function()local c=a.cache.bb if not c then c={c=b()}a.cache.bb=c end return c.c end end do local b=function()

local b=a.ag()local c=function(


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
local j=i~=d.localPlayer and i.Character and i.Character:FindFirstChild("Head")
if j and j:IsA("BasePart")then
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
local k=j~=d.localPlayer and j.Character and j.Character:FindFirstChild("HumanoidRootPart")
if k and k:IsA("BasePart")then
k.CanCollide=false
k.Size=c(g)
k.Transparency=h
end
end
end
}
}end a.bc=function()local c=a.cache.bc if not c then c={c=b()}a.cache.bc=c end return c.c end end do local b=function()

local b=a.ag()local c=function(

c)
local d=c:collectGarbage("orbit")
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

local j=d:createGarbage("orbit")
j.connections={}

local k=0 local l=function()


return f.Character and f.Character:FindFirstChild("HumanoidRootPart")end


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
if not d:hasGarbage("orbit")then return end

c(d)
d:notify("Orbit","Stopped orbiting player")
end
}
}end a.bd=function()local c=a.cache.bd if not c then c={c=b()}a.cache.bd=c end return c.c end end do local b=function()

local b=a.ag()local c=function(

c)
local d=c:collectGarbage("headsit")
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

local h=d:createGarbage("headsit")
h.connection=d:connect(d.runService.Heartbeat,function()
local i=d.playerService:getRootPart()
local j=d.playerService:getHumanoid()
local k=f.Character and f.Character:FindFirstChild("HumanoidRootPart")

if not(i and j and k and j.Sit)then
c(d)
return
end

i.CFrame=k.CFrame*CFrame.new(0,1.6,0.4)
end)
end
}
}end a.be=function()local c=a.cache.be if not c then c={c=b()}a.cache.be=c end return c.c end end do local b=function()

return{
{
action="god",
description="Makes your character difficult to kill in most games",
run=function(b)
local c=b.localPlayer
local d=c.Character
local e=d and d:FindFirstChildWhichIsA("Humanoid")
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


local i=d:FindFirstChild("Animate")
if i then
i.Disabled=true
task.wait()
i.Disabled=false
end

h.Health=h.MaxHealth
end
}
}end a.bf=function()local c=a.cache.bf if not c then c={c=b()}a.cache.bf=c end return c.c end end do local b=function()

local b=a.ag()


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


local i=f:hasGarbage("antivoid")
if i then
f:run("unantivoid")
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
f:run("antivoid")
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
local j=h and h~=f.localPlayer and h.Character and h.Character:FindFirstChild("HumanoidRootPart")
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
local g=f:collectGarbage("jerk")
if g then
local h=g.track~=nil and g.track.IsPlaying
e(g)
if h then return end
end

local h=f.playerService:getHumanoid()
local i=h and h:FindFirstChildOfClass("Animator")
if not i then
f:notify("Jerk","your character has no Animator")
return
end

local j=Instance.new("Animation")
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

local m=f:createGarbage("jerk")
m.track=l

m.connection=f:connect(h.Died,function()
local n=f:collectGarbage("jerk")
if n then
e(n)
end
end)
end
}
}end a.bg=function()local c=a.cache.bg if not c then c={c=b()}a.cache.bg=c end return c.c end end do local b=function()

local b=a.ag()

local c="rbxassetid://148840371"
local d="rbxassetid://5918726674"
local e="rbxassetid://282574440"local f=function(


f)
if not f then return nil end

return f:FindFirstChild("Torso")
or f:FindFirstChild("UpperTorso")
or f:FindFirstChild("LowerTorso")
or f:FindFirstChild("HumanoidRootPart")end local g=function(



g, h)
local i=Instance.new("Animation")
i.AnimationId=h

local j=g:LoadAnimation(i)
j:Play(0.1,1,1)
return j,i end local h=function(


h)
local i=h:collectGarbage("bang")
if not i then return end

for j,k in i.connections do
k:Disconnect()
end
i.track:Stop()
i.animation:Destroy()end local i=function(


i)
local j=i:collectGarbage("carpet")
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

local r=j:createGarbage("bang")
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

local p=j:createGarbage("carpet")
p.track=n
p.animation=o
p.connections={}

table.insert(p.connections,j:connect(l.Died,function()
i(j)
end))

table.insert(p.connections,j:connect(j.runService.Heartbeat,function()
local q=j.playerService:getRootPart()
local r=m.Character and m.Character:FindFirstChild("HumanoidRootPart")
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
}end a.bh=function()local c=a.cache.bh if not c then c={c=b()}a.cache.bh=c end return c.c end end do local b=function()

local b=a.ag()

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
local j=i.Character and i.Character:FindFirstChildOfClass("Humanoid")
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
local g=e:expectExploit("setclipboard")
if not g then return end

local h=e.localPlayer
local i=f:nextValue()
if i then
h=b(i)[1]
end

local j=h and h.Character and h.Character:FindFirstChildWhichIsA("Humanoid")
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
}end a.bi=function()local c=a.cache.bi if not c then c={c=b()}a.cache.bi=c end return c.c end end do local b=function()

return{a.aL()
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

}end a.bj=function()local c=a.cache.bj if not c then c={c=b()}a.cache.bj=c end return c.c end end do local b=function()

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
local e=d:split(" ")
return Vector3.new(e[1]or 0,e[2]or 0,e[3]or 0)
end,Color3=
function(d)
local e=d:split(" ")
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


return b end a.bk=function()local c=a.cache.bk if not c then c={c=b()}a.cache.bk=c end return c.c end end do local b=function()











local b=a.l()
local c=a.b()
local d=a.af()
local e=a.bk()

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

for o in m:gmatch("[^%s,;]+")do
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




h.go=function(m, n, o)
if n=="tween"then
o=if typeof(o)=="number"then o else nil

local p=d:tweenTeleportTo({
target=CFrame.new(m.position),
speed=o or c.tweenSpeed,
})

return p~=nil
end

if n=="walk"then
local p=d:unseat()
if not p then return false end

p:MoveTo(m.position)
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
local n=Instance.new("Part")
n.Size=Vector3.new(5,5,5)
n.CFrame=CFrame.new(m.position)
n.Anchored=true
n.CanCollide=false
n.CanTouch=false
n.CanQuery=false
n.Parent=workspace

local o=Instance.new("BoxHandleAdornment")
o.Adornee=n
o.AlwaysOnTop=true
o.ZIndex=10
o.Size=n.Size
o.Parent=n

local p=Instance.new("BillboardGui")
p.Adornee=n
p.AlwaysOnTop=true
p.Size=UDim2.fromOffset(160,30)
p.StudsOffset=Vector3.new(0,4,0)
p.Parent=n

local q=Instance.new("TextLabel")
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


return h end a.bl=function()local c=a.cache.bl if not c then c={c=b()}a.cache.bl=c end return c.c end end do local b=function()




local b=a.bl()

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

local i=f:nextValue()
i=if typeof(i)=="number"then i else nil

b.go(h,g,i)end


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
args={
{kind="waypoint",name="waypoint"},
{name="tween_speed",kind="number",optional=true},
},
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
}end a.bm=function()local c=a.cache.bm if not c then c={c=b()}a.cache.bm=c end return c.c end end do local b=function()

return{
action="tweenspeed|tspeed",
description="Sets how fast the tween commands move you, in studs per second (default is 100)",
args={kind="number",name="tween speed",optional=true},
run=function(b,c)

b.privateEnv.tweenSpeed=c:nextValue()
end
}end a.bn=function()local c=a.cache.bn if not c then c={c=b()}a.cache.bn=c end return c.c end end do local b=function()

local b=a.ag()local c=function(


c)
local d=c:collectGarbage("loopgoto")
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
f.playerService:tweenTeleportTo({
target=e(h),
speed=i
})
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

local k=f:createGarbage("loopgoto")
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
}end a.bo=function()local c=a.cache.bo if not c then c={c=b()}a.cache.bo=c end return c.c end end do local b=function()

local b=a.ag()

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
local h=g and g.Character and g.Character:FindFirstChild("HumanoidRootPart")
if not h then return end


local i=f:FindFirstAncestorWhichIsA("Model")
if i then
i:PivotTo(h:GetPivot())
end
end
}end a.bp=function()local c=a.cache.bp if not c then c={c=b()}a.cache.bp=c end return c.c end end do local b=function()

local b=a.ag()

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

local g=e and e.Character and e.Character:FindFirstChild("HumanoidRootPart")
if not g then return end

local h=c.playerService:getRootPart()
if not h then return end
local i=h.CFrame

c.playerService:teleportTo(g.CFrame+Vector3.new(3,1,0))
task.wait(f)

c.playerService:setRootCFrame(i)
end
}end a.bq=function()local c=a.cache.bq if not c then c={c=b()}a.cache.bq=c end return c.c end end do local b=function()

local b=a.ag()local c=function(


c, d)
local e=c:getGarbage("loopbring")
if not e then return end

if d then
for f,g in d do
e.targets[g]=nil
end
else
e.targets={}
end

if next(e.targets)==nil then
c:collectGarbage("loopbring")
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
local i=h and h:FindFirstChild("HumanoidRootPart")
if i then
local j=h:FindFirstChildOfClass("Humanoid")
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


local i=d:registerGarbage("loopbring")
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
local l=k.Character and k.Character:FindFirstChild("HumanoidRootPart")
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
}end a.br=function()local c=a.cache.br if not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()

local b=a.ag()

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
if j:IsA("BasePart")and not j.Anchored then
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
if j:IsA("BasePart")and j.Anchored and j.Name~=c then
j.Anchored=false
end
end
end
end
end
}
}end a.bs=function()local c=a.cache.bs if not c then c={c=b()}a.cache.bs=c end return c.c end end do local b=function()local b=function(


b, c)
local d=b.playerService:getCharacter()
if not d then return end

local e=d:FindFirstChildOfClass("Humanoid")or d:FindFirstChildOfClass("AnimationController")
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
}end a.bt=function()local c=a.cache.bt if not c then c={c=b()}a.cache.bt=c end return c.c end end do local b=function()local b=function(

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
}end a.bu=function()local c=a.cache.bu if not c then c={c=b()}a.cache.bu=c end return c.c end end do local b=function()

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

b.playerService:tweenTeleportTo({
target=d,
speed=e
})
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

b.playerService:tweenTeleportTo({
target=f.Position+d,
speed=e
})
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
}end a.bv=function()local c=a.cache.bv if not c then c={c=b()}a.cache.bv=c end return c.c end end do local b=function()

local b=a.ag()local c=function(


c, d)
local e=c.localPlayer
if d then
e=b(d)[1]
end

local f=e and e.Character
local g=f and(f:FindFirstChild("HumanoidRootPart")or f:FindFirstChildWhichIsA("BasePart"))
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
local f=d:expectExploit("setclipboard")
if not f then return end

local g=c(d,e:nextValue())
if g then
f(g)
else
d:notify("Position","character is not loaded")
end
end
}
}end a.bw=function()local c=a.cache.bw if not c then c={c=b()}a.cache.bw=c end return c.c end end do local b=function()

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
}end a.bx=function()local c=a.cache.bx if not c then c={c=b()}a.cache.bx=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage("spawnpoint")
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

local g=c:createGarbage("spawnpoint")
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
}end a.by=function()local c=a.cache.by if not c then c={c=b()}a.cache.by=c end return c.c end end do local b=function()

local b=a.aE()
local c=a.g()

local d local e=function(

e)
local f=e:WaitForChild("Humanoid",10)
if not f then return end

b:Connect(f.Died,function()
local g=e:FindFirstChild("HumanoidRootPart")
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
}end a.bz=function()local c=a.cache.bz if not c then c={c=b()}a.cache.bz=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage("walltp")
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
local e=d and(d:FindFirstChild("UpperTorso")or d:FindFirstChild("Torso"))
if not e then return end

local f=c:createGarbage("walltp")
f.connection=c:connect(e.Touched,function(g)
local h=c.playerService:getRootPart()
local i=c.playerService:getHumanoid()
if not(h and i and g.Parent)then return end
if not g:IsA("BasePart")then return end
if g.Position.Y<=h.Position.Y-i.HipHeight then return end

local j=h.CFrame.LookVector
local k=g.Parent:FindFirstChild("HumanoidRootPart")
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
}end a.bA=function()local c=a.cache.bA if not c then c={c=b()}a.cache.bA=c end return c.c end end do local b=function()

return{
action="teleporttool|tptool",
description="Gives you a teleport tool",
run=function(b)
local c=b.localPlayer:FindFirstChildOfClass("Backpack")
if not c then
b:notify("Teleport Tool","your backpack is not loaded")
return
end

local d=Instance.new("Tool")
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
}end a.bB=function()local c=a.cache.bB if not c then c={c=b()}a.cache.bB=c end return c.c end end do local b=function()local b=function(



b, c, d)
b.playerService:unseat()
task.wait(b.privateEnv.gotopartDelay or 0.1)

if d then
b.playerService:tweenTeleportTo({
target=c,
speed=b.privateEnv.tweenSpeed
})
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
c({
action="gotopart|topart",
description="Teleports you to every part with the given name",
kind="string",argName="part name",
className="BasePart",field="Name",cframeOf=e,tween=false
}),
c({
action="tweengotopart|tgotopart|ttopart",
description="Tweens you to every part with the given name",
kind="string",argName="part name",
className="BasePart",field="Name",cframeOf=e,tween=true
}),
c({
action="gotopartclass|gpc",
description="Teleports you to every part with the given class name",
kind="className",argName="class name",
className="BasePart",field="ClassName",cframeOf=e,tween=false
}),
c({
action="tweengotopartclass|tgpc",
description="Tweens you to every part with the given class name",
kind="className",argName="class name",
className="BasePart",field="ClassName",cframeOf=e,tween=true
}),
c({
action="gotomodel|tomodel",
description="Teleports you to every model with the given name",
kind="string",argName="model name",
className="Model",field="Name",cframeOf=f,tween=false
}),
c({
action="tweengotomodel|tgotomodel|ttomodel",
description="Tweens you to every model with the given name",
kind="string",argName="model name",
className="Model",field="Name",cframeOf=f,tween=true
}),
d({
action="bringpart",
description="Brings every part with the given name to you",
kind="string",argName="part name",
className="BasePart",field="Name"
}),
d({
action="bringpartclass|bpc",
description="Brings every part with the given class name to you",
kind="className",argName="class name",
className="BasePart",field="ClassName"
}),
{
action="gotopartdelay",
description="Sets the delay before the goto part commands teleport (default is 0.1)",
args={kind="number",name="delay",optional=true},
run=function(g,h)
g.privateEnv.gotopartDelay=h:nextValue()or 0.1
end
}
}end a.bC=function()local c=a.cache.bC if not c then c={c=b()}a.cache.bC=c end return c.c end end do local b=function()

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
}end a.bD=function()local c=a.cache.bD if not c then c={c=b()}a.cache.bD=c end return c.c end end do local b=function()local b=function(

b)
local c=b:collectGarbage("tpwalk")
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

local j=d:createGarbage("tpwalk")
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
local e=d:collectGarbage("wallwalk")
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

local i=d:createGarbage("wallwalk")
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
local e=d:collectGarbage("wallwalk")
local f=e~=nil and e.active==true

if e and e.stop then
e.stop()
end

d:notify("Wallwalk",if f then"disabled"else"it is not running")
end
}
}end a.bE=function()local c=a.cache.bE if not c then c={c=b()}a.cache.bE=c end return c.c end end do local b=function()



local b=a.ag()
local c=a.f()

local d=c.PathfindingService

local e=5
local f=2
local g=0.2
local h=0.1
local i=3 local j=function(










j)
local k=j.playerService:getRootPart()
local l=j.playerService:getHumanoid()
if k and l then
l:MoveTo(k.Position)
end end local k=function(


k)
local l=k:collectGarbage("pathfind")
if not l then return false end

l.running=false
j(k)
return true end local l=function(


l, m)
local n=d:CreatePath()
local o=pcall(function()
n:ComputeAsync(l.Position,m)
end)

if not o or n.Status~=Enum.PathStatus.Success then
return{{position=m,jump=false}}
end

local p={}
for q,r in n:GetWaypoints()do
table.insert(p,{
position=r.Position,
jump=r.Action==Enum.PathWaypointAction.Jump,
})
end

if#p>1 and(p[1].position-l.Position).Magnitude<2 then
table.remove(p,1)
end

if#p==0 then
return{{position=m,jump=false}}
end

return p end local m=function(


m, n)
return m==nil or(n-m.goal).Magnitude>e end local n=function(


n, o, p, q)
local r=false
local s=n.MoveToFinished:Connect(function()
r=true
end)

if p.jump then
n.Jump=true
end

n:MoveTo(p.position)

local t=0
local u=false

while not r and t<i and n.Parent do
if q()then
u=true
break
end

local v=Vector3.new(
o.Position.X-p.position.X,
0,
o.Position.Z-p.position.Z
).Magnitude

local w=math.abs(o.Position.Y-p.position.Y)

if v<3 and w<4 then
break
end

task.wait(h)
t=t+h
end

s:Disconnect()
return not u end local o=function(


o, p, q)
k(o)

local r=o:createGarbage("pathfind")
r.running=true

task.spawn(function()
local s

while r.running do
local t=q()
if not t then break end

local u=o.playerService:getHumanoid()
local v=o.playerService:getRootPart()

if not(u and v)then
s=nil
task.wait(g)
continue
end

local w=s~=nil and s.index>#s.points
local x=p and s~=nil and not w and os.clock()-s.computedAt>f

if m(s,t)or x then
local y=l(v,t)
if not r.running then break end

s={
goal=t,
points=y,
index=1,
computedAt=os.clock(),
}
elseif w then
if not p then break end

task.wait(g)
else
local y=s
local z=n(u,v,y.points[y.index],function()
if not r.running then return true end

local z=q()
return z==nil or(p and m(y,z))
end)

if z then
y.index=y.index+1
end
end
end

if o:getGarbage("pathfind")==r then
o:collectGarbage("pathfind")
end
end)end


return{
{
action="pathfindwalkto|pathfindfollow",
description="Follow a player using pathfinding",
args={
kind="player"
},
run=function(p,q)
local r=b(q:nextValue())[1]
if not r then
p:notify("Pathfind","player not found")
return
end

o(p,true,function()
local s=r.Character and r.Character:FindFirstChild("HumanoidRootPart")
return s and s.Position
end)
end
},
{
action="pathfindwalktowaypoint|pathfindwalktowp|pftowp",
description="Walk to a waypoint using pathfinding",
args={
kind="waypoint"
},
run=function(p,q)
local r=q:nextValue()
local s=p.storage.waypoints:getValue(tostring(game.PlaceId))
local t=type(s)=="table"and r and s[r]

if not t then
p:notify("Pathfind",`there is no waypoint named '{r}'`)
return
end

local u=p:unstringify(t,"Vector3")
o(p,false,function()
return u
end)
end
},
{
action="unpathfind|nopathfind|pathfindstop",
description="Stops pathfindwalkto and pathfindwalktowaypoint",
run=function(p)
if k(p)then
p:notify("Pathfind","stopped")
else
p:notify("Pathfind","nothing is walking right now")
end
end
}
}end a.bF=function()local c=a.cache.bF if not c then c={c=b()}a.cache.bF=c end return c.c end end do local b=function()

return{a.bn()
,a.bo()
,a.bp()
,a.bq()
,a.br()
,a.bs()
,a.bt()
,a.bu()
,a.bv()
,a.bw()
,a.bx()
,a.by()
,a.bz()
,a.bA()
,a.bB()
,a.bC()
,a.bD()
,a.bE()
,a.bF()

}end a.bG=function()local c=a.cache.bG if not c then c={c=b()}a.cache.bG=c end return c.c end end do local b=function()




local b=a.f()

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


return c end a.bH=function()local c=a.cache.bH if not c then c={c=b()}a.cache.bH=c end return c.c end end do local b=function()






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


return d end a.bI=function()local c=a.cache.bI if not c then c={c=b()}a.cache.bI=c end return c.c end end do local b=function()






local b=a.f()
local c=a.a()
local d=a.j()
local e=a.t()
local f=a.d()
local g=a.aE()
local h=a.bH()
local i=a.bI()

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
p.time=os.date("%H:%M:%S")

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
local t=s({
Url=`https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds={q}&size=420x420&format=Png&isCircular=false`,
Method="GET",
})
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
local u=b.HttpService:JSONEncode({
content=r,
avatar_url=p(q),
username=q.Name,
allowed_mentions={parse={}},
})

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


if#u==0 then
return false,"nothing to save yet"
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


return m end a.bJ=function()local c=a.cache.bJ if not c then c={c=b()}a.cache.bJ=c end return c.c end end do local b=function()

local b=a.bJ()

return{
{
action="logs",
description="Opens the chat logs window with chat and join logs turned on",
run=function(c)
b.setChat(true)
b.setJoin(true)
c.infiniteYield:chatLogs("chat")
end
},
{
action="chatlogs|clogs",
description="Turns on chat logs and opens the chat tab",
run=function(c)
b.setChat(true)
c.infiniteYield:chatLogs("chat")
end
},
{
action="joinlogs|jlogs",
description="Turns on join logs and opens the joins tab",
run=function(c)
b.setJoin(true)
c.infiniteYield:chatLogs("join")
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
}end a.bK=function()local c=a.cache.bK if not c then c={c=b()}a.cache.bK=c end return c.c end end do local b=function()

local b=a.bH()
local c=a.ag()

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
}end a.bL=function()local c=a.cache.bL if not c then c={c=b()}a.cache.bL=c end return c.c end end do local b=function()

local b=a.f()
local c=a.bH()local d=function(


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
}end a.bM=function()local c=a.cache.bM if not c then c={c=b()}a.cache.bM=c end return c.c end end do local b=function()

local b=a.f()
local c=a.bH()local d=function(

d)
if c.isLegacy()then
b.StarterGui:SetCore("ChatActive",d)
else
b.TextChatService.ChatWindowConfiguration.Enabled=d
end end local e=function()




local e=b.TextChatService

local f={
{e:FindFirstChildOfClass("BubbleChatConfiguration"),{
Enabled=true,
BackgroundColor3=Color3.fromRGB(),
BackgroundTransparency=0.3,
TailVisible=true,
}},
{e:FindFirstChildOfClass("ChatWindowConfiguration"),{
Enabled=true,
BackgroundColor3=Color3.fromRGB(),
BackgroundTransparency=0.3,
TextColor3=Color3.fromRGB(0xFF,0xFF,0xFF),
TextStrokeColor3=Color3.fromRGB(),
TextStrokeTransparency=0.5,
}},
{e:FindFirstChildOfClass("ChatInputBarConfiguration"),{
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
}end a.bN=function()local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do local b=function()

local b=a.f()
local c=a.ag()local d=function()



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
local g=f:collectGarbage("listento")
if not g then
return false
end

if g.connection then
g.connection:Disconnect()
end
b.SoundService:SetListener(Enum.ListenerType.Camera)
return true end local g=function(



g, h)
local i=g:createGarbage("listento")local j=function(

j)
local k=j:WaitForChild("HumanoidRootPart",10)
if k and g:getGarbage("listento")==i then
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
}end a.bO=function()local c=a.cache.bO if not c then c={c=b()}a.cache.bO=c end return c.c end end do local b=function()

return{
{
action="loopoof",
description="Makes every player's head play its sounds (oof) over and over",
run=function(b)
if b:hasGarbage("oof")then
b:notify("oof loop is already enabled")
return
end

local c=b:createGarbage("oof")
c.running=true

task.spawn(function()
while c.running do
for d,e in b.robloxServices.Players:GetPlayers()do
local f=e.Character and e.Character:FindFirstChild("Head")
if f then
for g,h in f:GetChildren()do
if h:IsA("Sound")then
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
local c=b:collectGarbage("oof")
if c then
c.running=false
end
end
}
}end a.bP=function()local c=a.cache.bP if not c then c={c=b()}a.cache.bP=c end return c.c end end do local b=function()

local b=a.ag()

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
local g={f.Character,f:FindFirstChildOfClass("Backpack")}
for h,i in g do
for j,k in i:GetDescendants()do
if k:IsA("Sound")then
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
if i:IsA("Sound")and not i.Playing then
i.Playing=true
end
end
end)
end
end
}
}end a.bQ=function()local c=a.cache.bQ if not c then c={c=b()}a.cache.bQ=c end return c.c end end do local b=function()

return{a.bK()
,a.bL()
,a.bM()
,a.bN()
,a.bO()
,a.bP()
,a.bQ()

}end a.bR=function()local c=a.cache.bR if not c then c={c=b()}a.cache.bR=c end return c.c end end do local b=function()









local b=a.f()
local c=a.af()
local d=a.b()
local e=a.d()

local f=0.3
local g=0.25
local h=Color3.fromRGB(255,255,255)
local i="iy-esp"local j=function()


local j=b.CoreGui
local k=j:FindFirstChild(i)

if not k then
k=Instance.new("Folder")
k.Name=i
k.Parent=j
end

return k end local k=function(



k)
if k:IsA("BasePart")then
return k
end

if k:IsA("Model")then
return k:FindFirstChild("Head")
or k.PrimaryPart
or k:FindFirstChildWhichIsA("BasePart")
end

return nil end local l=function(



l, m)
local n=l:IsA("Model")and l:FindFirstChildOfClass("Humanoid")

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
local o=Instance.new("Folder")
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
local r=o:IsA("Model")and o:GetChildren()or{o}

for s,t in r do
if t:IsA("BasePart")then
local u=Instance.new("BoxHandleAdornment")
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
local r=Instance.new("BillboardGui")
r.Adornee=p
r.Size=UDim2.new(0,200,0,50)
r.StudsOffset=Vector3.new(0,2,0)
r.AlwaysOnTop=true
r.Parent=n.folder

local s=Instance.new("TextLabel")
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


return m end a.bS=function()local c=a.cache.bS if not c then c={c=b()}a.cache.bS=c end return c.c end end do local b=function()






local b=a.bS()
local c=a.ag()
local d=a.f()
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
if s:IsA("BasePart")and p[s.Name:lower()]then
table.insert(q,s)
end
end

return q
end end local q=function(



q, r, s)
local t=f:GetPlayerFromCharacter(q)
local u=q:FindFirstChildOfClass("Humanoid")

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
if t:hasGarbage("chams")then
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

if not x:hasGarbage("partesp")then
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
if x:hasGarbage("esp")then
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
}end a.bT=function()local c=a.cache.bT if not c then c={c=b()}a.cache.bT=c end return c.c end end do local b=function()local b=function(


b)
local c=b.privateEnv.xrayEnabled==true

for d,e in workspace:GetDescendants()do
if e:IsA("BasePart")then
local f=e.Parent
local g=f and f.Parent
local h=(f and f:FindFirstChildWhichIsA("Humanoid"))
or(g and g:FindFirstChildWhichIsA("Humanoid"))

if not h then
e.LocalTransparencyModifier=c and 0.5 or 0
end
end
end end local c=function(


c)
local d=c:collectGarbage("loopxray")
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

local e=d:createGarbage("loopxray")
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
}end a.bU=function()local c=a.cache.bU if not c then c={c=b()}a.cache.bU=c end return c.c end end do local b=function()local b=function(



b, c)
if not c then return nil end

local d=c:FindFirstAncestorOfClass("Model")
if not d then return nil end

return b.players:GetPlayerFromCharacter(d)end local c=function(


c)
local d=c:collectGarbage("hovername")
if not d then return false end

if d.connection then
d.connection:Disconnect()
end
if d.gui then
d.gui:Destroy()
end
return true end local d=function(


d)
local e=Instance.new("ScreenGui")
e.Name="HovernameGui"
e.ResetOnSpawn=false

local f=d.executorEnv.gethui and d.executorEnv.gethui()
e.Parent=f or d.coreGui

local g=Instance.new("TextLabel")
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

local i=e:createGarbage("hovername")
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
}end a.bV=function()local c=a.cache.bV if not c then c={c=b()}a.cache.bV=c end return c.c end end do local b=function()local b=function(


b, c)
local d=pcall(function()
settings():GetService("RenderSettings").ShowBoundingBoxes=c
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
}end a.bW=function()local c=a.cache.bW if not c then c={c=b()}a.cache.bW=c end return c.c end end do local b=function()

return{a.bT()
,a.bU()
,a.bV()
,a.bW()

}end a.bX=function()local c=a.cache.bX if not c then c={c=b()}a.cache.bX=c end return c.c end end do local b=function()

return{}end a.bY=function()local c=a.cache.bY if not c then c={c=b()}a.cache.bY=c end return c.c end end do local b=function()
local b=a.bY()
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


return d end a.bZ=function()local c=a.cache.bZ if not c then c={c=b()}a.cache.bZ=c end return c.c end end do local b=function()


local b=a.f()
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

return d end a.b_=function()local c=a.cache.b_ if not c then c={c=b()}a.cache.b_=c end return c.c end end do local b=function()
local b=a.f()
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
local f=d:FindFirstChild("RobloxGui")
d=if f~=nil then f else d
end

return d end


return d()end a.b0=function()local c=a.cache.b0 if not c then c={c=b()}a.cache.b0=c end return c.c end end do local aa=function()














local b=a.f()
local c=a.bZ()
local d=a.aH()
local e=a.af()
local f=a.g()

local g=a.b_()
local h=a.b0()

local i=b.ContextActionService
local j=b.UserInputService

local k={}

k.DEFAULT_SPEED=1
k.DEFAULT_BOOST=2
k.MIN_BOOST=1
k.MAX_BOOST=50

local l="freecam.boost"

local m="freecam"
local n="freecamKeys"
local o="freecamMouse"
local p=Enum.ContextActionPriority.High.Value
local q="freecamControls"

local r={
Enum.KeyCode.W,
Enum.KeyCode.A,
Enum.KeyCode.S,
Enum.KeyCode.D,
Enum.KeyCode.E,
Enum.KeyCode.Q,
Enum.KeyCode.Up,
Enum.KeyCode.Down,
}

local s=70
local t=64
local u=5
local v=math.pi/64


local w=math.rad(89)
local x=0.75
local y=0.01
local z=4
local A=0.25
local B=0.1
local C=512

local D=1
local E=64
local F=24
local G=40 local H=function()


return Enum.ContextActionResult.Sink end local I=function(



I)
return{
position=I,
velocity=I*0,
}end local J=function(


J, K, L)
local M=u*2*math.pi
local N=L-J.position
local O=math.exp(-M*K)

local P=L+(J.velocity*K-N*(M*K+1))*O
local Q=(M*K*(N*M-J.velocity)+J.velocity)*O

J.position=P
J.velocity=Q

return P end local K=function(



K, L)
local M=j:IsKeyDown(K)and 1 or 0
local N=j:IsKeyDown(L)and 1 or 0
return M-N end local L=function(



L, M, N)
local O=L.ViewportSize
local P=2*math.tan(math.rad(N)/2)
local Q=O.X/O.Y*P

local R=C
local S=M.LookVector

for T=0,1,0.5 do
for U=0,1,0.5 do
local V=M.RightVector*((T-0.5)*Q)
-M.UpVector*((U-0.5)*P)
+M.LookVector

local W=V.Unit
local X=M.Position+V*B
local Y=workspace:Raycast(X,W*C)
local Z=Y and(Y.Position-X).Magnitude or C

if Z<R then
R=Z
S=W
end
end
end

return M.LookVector:Dot(S)*R end local M=function(






M, N)
if not M then return Vector3.zero end

local O=Vector3.new(-math.sin(N),0,-math.cos(N))
local P=Vector3.new(math.cos(N),0,-math.sin(N))
local Q=M.MoveDirection
return Vector3.new(Q:Dot(P),0,-Q:Dot(O))end local N=function(


N)
return N.UserInputType==Enum.UserInputType.Touch end local O=function(



O, P)
for Q,R in O.controls do
local S=R.AbsolutePosition
local T=R.AbsoluteSize
if P.X>=S.X and P.X<=S.X+T.X
and P.Y>=S.Y and P.Y<=S.Y+T.Y then
return true
end
end
return false end local P=function(



P, Q)
local R=c.new("ScreenGui",h,{
Name=q,
ResetOnSpawn=false,
DisplayOrder=50,
})
Q.gui=R local S=function(


S, T, U)
local V=c.new("TextButton",R,{
Name=S,
AnchorPoint=Vector2.new(1,1),
Position=U,
Size=UDim2.fromOffset(E,E),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text=T,
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(Q.controls,V)
table.insert(Q.connections,P:connect(V.InputBegan,function(W)
if N(W)then
Q.holds[S]=W
end
end))end


S("rise","UP",UDim2.new(1,-F,1,-G-E-12))
S("fall","DOWN",UDim2.new(1,-F,1,-G))
S("boost","BOOST",UDim2.new(1,-F-E-12,1,-G))

local T=c.new("TextButton",R,{
Name="Close",
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-F,0,F),
Size=UDim2.fromOffset(E,E),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text="X",
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(Q.controls,T)
table.insert(Q.connections,P:connect(T.Activated,function()
k.stop(P)
end))


local U=c.new("TextButton",R,{
Name="Teleport",
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-F-E-12,0,F),
Size=UDim2.fromOffset(E,E),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text="TP",
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(Q.controls,U)
table.insert(Q.connections,P:connect(U.Activated,function()
k.teleport(P)
end))


table.insert(Q.connections,P:connect(j.InputEnded,function(V)
for W,X in Q.holds do
if V==X then
Q.holds[W]=nil
end
end
end))end local Q=function(




Q, R)
local S=b.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
local T=S and S:FindFirstChild("TouchGui")
local U=T and T:FindFirstChild("JumpButton",true)
if not U then return end

R.jumpButton=U
R.jumpVisible=U.Visible
U.Visible=false

table.insert(R.connections,Q:connect(U:GetPropertyChangedSignal("Visible"),function()
if U.Visible then
U.Visible=false
end
end))end local R=function(



R, S)
local T=R.playerService:getRootPart()
if not T then return end

S.root=T
S.rootAnchored=T.Anchored
T.Anchored=true end local S=function(


S)
local T=S.root
if T and T.Parent~=nil then
T.Anchored=S.rootAnchored
end end local aa=function(


T, U, V)
local W=workspace.CurrentCamera


U.navMultiplier=math.clamp(
U.navMultiplier+V*K(Enum.KeyCode.Up,Enum.KeyCode.Down)*x,
y,
z
)


local X=T.playerService:getHumanoid()
local Y=if g then M(X,U.rotation.Y)else Vector3.zero
if g and X then
X.Jump=false
end

local Z=U.holds.rise and 1 or 0
local _=U.holds.fall and 1 or 0
local aa=Vector3.new(
K(Enum.KeyCode.D,Enum.KeyCode.A)+Y.X,
K(Enum.KeyCode.E,Enum.KeyCode.Q)+Z-_,
K(Enum.KeyCode.S,Enum.KeyCode.W)+Y.Z
)

local ab=j:IsKeyDown(Enum.KeyCode.LeftShift)and A or 1

local ac=U.holds.boost or j:IsKeyDown(d:getBinding("freecamBoost"))
local ad=if ac then k.getBoost(T)else 1
local ae=(T.privateEnv.freecamSpeed or k.DEFAULT_SPEED)*U.navMultiplier*ab*ad
local af=J(U.velocitySpring,V,aa*ae)

local ag=J(U.panSpring,V,U.mouseDelta*v)
U.mouseDelta=Vector2.zero


local ah=math.sqrt(math.tan(math.rad(s/2))/math.tan(math.rad(U.fieldOfView/2)))
local ai=U.rotation+ag*Vector2.new(0.75,1)*8*(V/ah)
U.rotation=Vector2.new(
math.clamp(ai.X,-w,w),
ai.Y%(2*math.pi)
)

local aj=CFrame.fromOrientation(U.rotation.X,U.rotation.Y,0)
local ak=CFrame.new(U.position)*aj*CFrame.new(af*t*V)
U.position=ak.Position

W.CFrame=ak
if U.anchor then
U.anchor.CFrame=ak
end
W.Focus=ak*CFrame.new(0,0,-L(W,ak,U.fieldOfView))
W.FieldOfView=U.fieldOfView end local ab=function(


ab)
return c.new("Part",workspace,{
Name="freecamAnchor",
Anchored=true,
CanCollide=false,
CanQuery=false,
CanTouch=false,
CastShadow=false,
Transparency=1,
Size=Vector3.one*0.2,
CFrame=CFrame.new(ab.position),
})end local ac=function(


ac)
local ad=f.Character or f.CharacterAdded:Wait()
local ae=ad:WaitForChild("Humanoid",100)

if ac and(
ac.CameraSubject==nil
or not ac.CameraSubject:IsDescendantOf(workspace)
)and e:isAlive(ad)then
ac.CameraSubject=ae
end end


k.stop=function(ad)
local ae=ad:collectGarbage(m)
if not ae then return false end

for af,ag in ae.connections do
ag:Disconnect()
end

i:UnbindAction(n)
i:UnbindAction(o)

if ae.gui then
ae.gui:Destroy()
end
if ae.jumpButton then
ae.jumpButton.Visible=ae.jumpVisible
end
S(ae)

local af=ae.cameraSubject
local ag=workspace.CurrentCamera

ag.CameraSubject=af

if ae.isLPHumanoid or(af and not af:IsDescendantOf(workspace))then
task.spawn(ac,ag)
end

ag.CameraType=ae.cameraType

if ae.anchor then
ae.anchor:Destroy()
end

ag.Focus=ae.focus
ag.FieldOfView=ae.fieldOfView

j.MouseBehavior=ae.mouseBehavior
j.MouseIconEnabled=ae.mouseIconEnabled

return true end


k.teleport=function(ad)
local ae=ad:getGarbage(m)
if not ae then return false end

local af=CFrame.new(ae.position)*CFrame.Angles(0,ae.rotation.Y,0)
k.stop(ad)

if not ad.playerService:teleportTo(af)then
ad:notify("Freecam","your character was not found")
end

return true end local ad=function(


ad, ae, af, ...)
local ag,ah=pcall(af,...)
if not ag then
ad:notify("Freecam",`{ae} failed: {ah}`)
end end local ae=function(


ae, af)
k.stop(ae)

local ag=workspace.CurrentCamera
local ah=ag.CFrame
local ai,aj=ah:ToOrientation()

local ak=ae:createGarbage(m)
ak.connections={}
ak.controls={}
ak.holds={}
ak.cameraType=ag.CameraType
ak.cameraSubject=ag.CameraSubject

local T=f.Character and f.Character:FindFirstChildOfClass("Humanoid")
ak.isLPHumanoid=
(ak.cameraSubject~=nil and T==ak.cameraSubject)or
ak.cameraSubject==nil

ak.focus=ag.Focus
ak.fieldOfView=ag.FieldOfView
ak.mouseBehavior=j.MouseBehavior
ak.mouseIconEnabled=j.MouseIconEnabled

ak.position=af or ah.Position
ak.rotation=Vector2.new(ai,aj)
ak.mouseDelta=Vector2.zero
ak.navMultiplier=1
ak.velocitySpring=I(Vector3.zero)
ak.panSpring=I(Vector2.zero)

ak.anchor=ab(ak)

ag.CameraType=Enum.CameraType.Custom
ag.CameraSubject=ak.anchor
j.MouseBehavior=Enum.MouseBehavior.Default
j.MouseIconEnabled=true

i:BindActionAtPriority(n,H,false,p,table.unpack(r))
i:BindActionAtPriority(o,function(U,V,W)
local X=W.Delta
ak.mouseDelta=ak.mouseDelta+Vector2.new(-X.Y,-X.X)
return Enum.ContextActionResult.Sink
end,false,p,Enum.UserInputType.MouseMovement)

if g then
R(ae,ak)
ad(ae,"buttons",P,ae,ak)
ad(ae,"jump button",Q,ae,ak)

table.insert(ak.connections,ae:connect(j.InputBegan,function(V,W)
if W or not N(V)then return end
if ak.lookTouch~=nil or O(ak,V.Position)then return end

if V.Position.X<workspace.CurrentCamera.ViewportSize.X/2 then return end
ak.lookTouch=V
end))
table.insert(ak.connections,ae:connect(j.InputChanged,function(V)
if V==ak.lookTouch then
ak.mouseDelta=ak.mouseDelta+Vector2.new(-V.Delta.Y,-V.Delta.X)*D
end
end))
table.insert(ak.connections,ae:connect(j.InputEnded,function(V)
if V==ak.lookTouch then
ak.lookTouch=nil
end
end))
end

table.insert(ak.connections,ae:connect(ae.runService.RenderStepped,function(V)
local W,X=pcall(aa,ae,ak,V)
if not W then
k.stop(ae)
ae:notify("Freecam",`stopped, the camera was given back: {X}`)
end
end))end


k.start=function(af, ag)
local ah,ai=pcall(ae,af,ag)
if not ah then
k.stop(af)
af:notify("Freecam",`could not start: {ai}`)
end end


k.getBoost=function(af)
local ag=af.storage.settings:getValue(l)
if type(ag)~="number"then
return k.DEFAULT_BOOST
end

return math.clamp(ag,k.MIN_BOOST,k.MAX_BOOST)end


k.addBoost=function(af, ag)
local ah=math.clamp(k.getBoost(af)+ag,k.MIN_BOOST,k.MAX_BOOST)

af.storage.settings:setValue(l,ah)
af.storage.settings:save()

return ah end


k.getPosition=function(af)
local ag=af:getGarbage(m)
return ag and ag.position end


return k end a.b1=function()local ab=a.cache.b1 if not ab then ab={c=aa()}a.cache.b1=ab end return ab.c end end do local aa=function()

local aa=a.ag()
local ab=a.b1()local ac=function(


ac)
if not ac then return nil end
return ac:FindFirstChildOfClass("Humanoid")or ac end local ad=function(


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
local ag=af:collectGarbage("view")
if not ag then return false end

for ah,ai in ag.connections do
ai:Disconnect()
end
return true end


return{
{
action="spectate|view",
description="View a player",
args={kind="player"},
run=function(ag,ah)
local ai=aa(ah:nextValue())[1]
if not ai then return end

ab.stop(ag)
af(ag)

local aj=ag:createGarbage("view")
aj.connections={}

local ak=ag.playerService:getCamera()local b=function()



local b=ac(ai.Character)
if b then
ad(ag,b)
end end


table.insert(aj.connections,ag:connect(ak:GetPropertyChangedSignal("CameraSubject"),b))

table.insert(aj.connections,ag:connect(ai.CharacterAdded,function(c)
c:WaitForChild("Humanoid",10)
b()
end))


table.insert(aj.connections,ag:connect(ag.players.PlayerRemoving,function(c)
if c==ai then
af(ag)
ae(ag)
end
end))

b()
ag:notify("Spectate","Viewing "..ai.Name)
end
},
{
action="viewpart|viewp",
description="View a part",
args={
kind="string",
name="part name"
},
run=function(ag,ah)
local ai=ah:nextValue()
if not ai then return end

ab.stop(ag)
af(ag)

local aj=string.lower(ai)
for ak,b in workspace:GetDescendants()do
if b:IsA("BasePart")and string.lower(b.Name)==aj then
ad(ag,b)
return
end
end

ag:notify("Spectate","no part named "..ai)
end
},
{
action="unspectate|unview",
description="Stops viewing player, or part.",
run=function(ag)
ab.stop(ag)

local ah=af(ag)
ae(ag)

if ah then
ag:notify("Spectate","View turned off")
end
end
}
}end a.b2=function()local ab=a.cache.b2 if not ab then ab={c=aa()}a.cache.b2=ab end return ab.c end end do local aa=function()



local aa=a.ag()
local ab=a.b1()

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
local ah=ag:nextValue()
if ah then
af.privateEnv.freecamSpeed=ah
end

ab.start(af)
end
},
{
action="freecampos|fcpos",
description="Moves / opens freecam in a certain position",
args={kind="vector3"},
run=function(af,ag)
local ah=ag:nextValue()
if ah then
ab.start(af,ah)
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
local ah=ag:nextValue()
local ai=ah and ad(af,ah)
if not ai then
af:notify(ac,`there is no waypoint named '{ah}'`)
return
end

ab.start(af,ai)
end
},
{
action="freecamgoto|fcgoto|freecamtp|fctp",
description="Moves / opens freecam to a player",
args={kind="player"},
run=function(af,ag)
local ah=aa(ag:nextValue())[1]
local ai=ah and ah.Character and ah.Character:FindFirstChild("HumanoidRootPart")
if not ai then
af:notify(ac,"that player's character is not loaded")
return
end

ab.start(af,ai.Position)
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

local ah=af:expectExploit("setclipboard")
if not ah then return end

ah(ae(ag))
af:notify(ac,"copied freecam position to clipboard")
end
},
{
action="freecamboost|fcboost",
description="Increases the freecam boost (the BOOST button) by an amount, and saves it",
args={kind="number",name="amount",optional=true},
run=function(af,ag)
local ah=ag:nextValue()or 1
local ai=ab.addBoost(af,ah)
af:notify(ac,`freecam boost is now {ai}x`)
end
},
}end a.b3=function()local ab=a.cache.b3 if not ab then ab={c=aa()}a.cache.b3=ab end return ab.c end end do local aa=function()

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
aa.playerService:tweenTeleportTo({
target=aa.playerService:getCamera().CFrame,
speed=aa.privateEnv.tweenSpeed
})
end
}
}end a.b4=function()local ab=a.cache.b4 if not ab then ab={c=aa()}a.cache.b4=ab end return ab.c end end do local aa=function()

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
}end a.b5=function()local ab=a.cache.b5 if not ab then ab={c=aa()}a.cache.b5=ab end return ab.c end end do local aa=function()local aa=function(


aa)
local ab=aa:FindFirstChild("PlayerScripts")
local ac=ab and ab:FindFirstChild("PlayerModule")
local ad=ac and ac:FindFirstChild("CameraModule")
local ae=ad and ad:FindFirstChild("ZoomController")
return ae and ae:FindFirstChild("Popper")end


return{
action="noclipcam|nccam",
description="Allows camera to go through objects like walls",
run=function(ab)
local ac=ab:expectExploit("getgc")
local ad=ab:expectExploit("getconstants")
local ae=ab:expectExploit("setconstant")
local af=ab:expectExploit("getfenv")
if not(ac and ad and ae and af)then return end

local ag=aa(ab.localPlayer)
if not ag then
ab:notify("noclipcam","camera popper not found")
return
end


for ah,ai in ac()do
if type(ai)=="function"and af(ai).script==ag then
for aj,ak in ad(ai)do
if tonumber(ak)==0.25 then
ae(ai,aj,0)
elseif tonumber(ak)==0 then
ae(ai,aj,0.25)
end
end
end
end
end
}end a.b6=function()local ab=a.cache.b6 if not ab then ab={c=aa()}a.cache.b6=ab end return ab.c end end do local aa=function()

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
}end a.b7=function()local ab=a.cache.b7 if not ab then ab={c=aa()}a.cache.b7=ab end return ab.c end end do local aa=function()

return{
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(aa,ab)
local ac=math.clamp(math.abs(ab:nextValue()or 70),1,120)
workspace.CurrentCamera.FieldOfView=ac
end
}end a.b8=function()local ab=a.cache.b8 if not ab then ab={c=aa()}a.cache.b8=ab end return ab.c end end do local aa=function()

local aa=a.b1()

return{
action="fixcam|restorecam",
description="Fixes camera",
run=function(ab)
local ac=ab.playerService
local ad=ab.localPlayer


aa.stop(ab)


if ab:hasGarbage("view")then
ab:run("unview")
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

ab:notify("camera has been reseted successfully")
end
end
}end a.b9=function()local ab=a.cache.b9 if not ab then ab={c=aa()}a.cache.b9=ab end return ab.c end end do local aa=function()

return{
action="enableshiftlock|enablesl",
description="Enables the shift lock option",
run=function(aa)
local ab=aa.localPlayer
ab.DevEnableMouseLock=true


if aa:hasGarbage("shiftlock")then return end

local ac=aa:createGarbage("shiftlock")
ac.connection=aa:connect(ab:GetPropertyChangedSignal("DevEnableMouseLock"),function()
ab.DevEnableMouseLock=true
end)

aa:notify("Shiftlock","Shift lock should now be available")
end
}end a.ca=function()local ab=a.cache.ca if not ab then ab={c=aa()}a.cache.ca=ab end return ab.c end end do local aa=function()

local aa=a.ag()


local ab={max=400,min=0.5}

return{
action="lookat",
description="Moves your camera view to a player",
args={kind="player"},
run=function(ac,ad)
local ae=aa(ad:nextValue())[1]
local af=ae and ae.Character and ae.Character:FindFirstChild("Head")
if not af then
ac:notify("Lookat","the player's character is not loaded")
return
end

local ag=ac.localPlayer
local ah=ac.playerService:getCamera()


if ag.CameraMaxZoomDistance~=0.5 then
ac.privateEnv.lookAtZoom={
max=ag.CameraMaxZoomDistance,
min=ag.CameraMinZoomDistance
}
end
local ai=ac.privateEnv.lookAtZoom or ab


ag.CameraMaxZoomDistance=0.5
ag.CameraMinZoomDistance=0.5
task.wait()

ah.CFrame=CFrame.new(ah.CFrame.Position,af.Position)
task.wait(0.1)

ag.CameraMaxZoomDistance=ai.max
ag.CameraMinZoomDistance=ai.min
end
}end a.cb=function()local ab=a.cache.cb if not ab then ab={c=aa()}a.cache.cb=ab end return ab.c end end do local aa=function()

local aa=a.ag()local ab=function(

ab)
local ac=ab:collectGarbage("stareat")
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

local af=ac:createGarbage("stareat")
af.connection=ac:connect(ac.runService.RenderStepped,function()
if ae.Parent==nil then
ab(ac)
return
end

local ag=ac.playerService:getRootPart()
local ah=ae.Character and ae.Character:FindFirstChild("HumanoidRootPart")
if not(ag and ah)then return end


local ai=Vector3.new(ah.Position.X,ag.Position.Y,ah.Position.Z)
if(ai-ag.Position).Magnitude<0.01 then return end

ag.CFrame=CFrame.new(ag.Position,ai)
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
}end a.cc=function()local ab=a.cache.cc if not ab then ab={c=aa()}a.cache.cc=ab end return ab.c end end do local aa=function()

return{a.b2()
,a.b3()
,a.b4()
,a.b5()
,a.b6()
,a.b7()
,a.b8()
,a.b9()
,a.ca()
,a.cb()
,a.cc()

}end a.cd=function()local ab=a.cache.cd if not ab then ab={c=aa()}a.cache.cd=ab end return ab.c end end do local aa=function()


local aa

return{
{
client=true,
action="btools",
description="Gives you building tools (DOES NOT REPLICATE)",
run=function(ab)
local ac=ab.localPlayer:FindFirstChildWhichIsA("Backpack")
if not ac then
ab:notify("Btools","your backpack is not loaded")
return
end


for ad,ae in Enum.BinType:GetEnumItems()do
local af=Instance.new("HopperBin")
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

local ac=ab:expectExploit("loadstring")
if not ac then return end

local ad,ae=pcall(function()
ac(game:HttpGet(aa))()
end)

if not ad then
ab:notify("F3X",`failed to load: {tostring(ae)}`)
end
end
}
}end a.ce=function()local ab=a.cache.ce if not ab then ab={c=aa()}a.cache.ce=ab end return ab.c end end do local aa=function()local aa=function(






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
}end a.cf=function()local ab=a.cache.cf if not ab then ab={c=aa()}a.cache.cf=ab end return ab.c end end do local aa=function()local aa=function(


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
for ag,ah in workspace:GetDescendants()do
if ah.Name:lower()==af then
ah:Destroy()
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
for ag,ah in workspace:GetDescendants()do
if ah.ClassName:lower()==af then
ah:Destroy()
end
end

ab:notify("Item(s) Deleted","Deleted items with ClassName "..ad)
end
}
}end a.cg=function()local ab=a.cache.cg if not ab then ab={c=aa()}a.cache.cg=ab end return ab.c end end do local aa=function()




return{
{
action="lockworkspace|lockws",
description="Locks the whole workspace",
run=function(aa)
local ab=aa:createGarbage("lockworkspace")
if not ab then
aa:notify("Lock workspace","the workspace is already locked")
return
end

local ac=aa.playerService:getCharacter()

for ad,ae in workspace:GetDescendants()do
if ae:IsA("BasePart")and not(ac and ae:IsDescendantOf(ac))then
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
local ab=aa:collectGarbage("lockworkspace")
if not ab then return end

for ac,ad in ab do
if ac.Parent then
ac.Locked=ad
end
end

aa:notify("Lock workspace","unlocked")
end
}
}end a.ch=function()local ab=a.cache.ch if not ab then ab={c=aa()}a.cache.ch=ab end return ab.c end end do local aa=function()

return{
{
client=true,
action="invisibleparts|invisparts",
description="Shows invisible parts",
run=function(aa)
local ab=aa.privateEnv.shownParts or{}
aa.privateEnv.shownParts=ab

for ac,ad in workspace:GetDescendants()do
if ad:IsA("BasePart")and ad.Transparency==1 then
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
}end a.ci=function()local ab=a.cache.ci if not ab then ab={c=aa()}a.cache.ci=ab end return ab.c end end do local aa=function()local aa=function(

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

if ab:hasGarbage("instantpp")then
ab:notify("instant proximity prompts is already enabled")
return
end

local ad=ab:createGarbage("instantpp")
ad.connection=ab:connect(ab.proximityPromptService.PromptButtonHoldBegan,function(ae)
ac(ae)
end)
end
},
{
action="uninstantproximityprompts|uninstantpp",
description="Disables instant proximity prompts",
run=function(ab)
local ac=ab:collectGarbage("instantpp")
if ac and ac.connection then
ac.connection:Disconnect()
end
end
}
}end a.cj=function()local ab=a.cache.cj if not ab then ab={c=aa()}a.cache.cj=ab end return ab.c end end do local aa=function()

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
}end a.ck=function()local ab=a.cache.ck if not ab then ab={c=aa()}a.cache.ck=ab end return ab.c end end do local aa=function()

return{
{
action="deleteinvisparts|deleteinvisibleparts|dip",
description="Deletes invisible collidable parts",
run=function()
for aa,ab in workspace:GetDescendants()do
if ab:IsA("BasePart")and ab.Transparency==1 and ab.CanCollide then
ab:Destroy()
end
end
end
},
{
action="removeterrain|rterrain|noterrain",
description="Clears all the terrain",
run=function()
local aa=workspace:FindFirstChildOfClass("Terrain")
if aa then
aa:Clear()
end
end
}
}end a.cl=function()local ab=a.cache.cl if not ab then ab={c=aa()}a.cache.cl=ab end return ab.c end end do local aa=function()local aa=function(

aa, ab)
return ab==""
or aa.Name:lower()==ab
or(aa.Parent~=nil and aa.Parent.Name:lower()==ab)end local ab=function(


ab)
local ac=ab.Parent
if ac==nil then
return nil
elseif ac:IsA("Attachment")then
return ac.WorldPosition
elseif ac:IsA("BasePart")then
return ac.Position
elseif ac:IsA("Model")then
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

for ag,ah in workspace:GetDescendants()do
if ah:IsA("ProximityPrompt")and ah.Enabled then
local ai=ab(ah)
if not ai then continue end

local aj=(ai-ad.Position).Magnitude

if aj<af then
ae,af=ah,aj
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
local ag=ae:expectExploit("fireclickdetector")
if not ag then return end

local ah=(af:nextValue()or""):lower()

for ai,aj in workspace:GetDescendants()do
if aj:IsA("ClickDetector")and aa(aj,ah)then
ag(aj)
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
local ag=ae:expectExploit("fireproximityprompt")
if not ag then return end

local ah=(af:nextValue()or""):lower()

for ai,aj in workspace:GetDescendants()do
if aj:IsA("ProximityPrompt")and aa(aj,ah)then
ag(aj)
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
local ag=ae:expectExploit("fireproximityprompt")
if not ag then return end

local ah=ac(ae)
if not ah then
ae:notify("Can't find any ProximityPrompt on workspace")
return
end

if af:nextValue()then
ad(ae,ah)
task.wait(0.25)
end

ag(ah)
ae:notify(`fired prompt: {ah:GetFullName()}`)
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
local ag=ae:expectExploit("firetouchinterest")
if not ag then return end

local ah=ae.playerService:getRootPart()
if not ah then return end

local ai=(af:nextValue()or""):lower()

for aj,ak in workspace:GetDescendants()do
if ak:IsA("TouchTransmitter")and ak.Parent:IsA("BasePart")and aa(ak.Parent,ai)then
ag(ak.Parent,ah,0)
ag(ak.Parent,ah,1)
end
end
end
}
}end a.cm=function()local ab=a.cache.cm if not ab then ab={c=aa()}a.cache.cm=ab end return ab.c end end do local aa=function()
local aa=a.ag()local ab=function(


ab)
local ac=ab.Parent
if ac and ac:FindFirstChildWhichIsA("Humanoid")then
return true
end

local ad=ac and ac.Parent
return ad~=nil and ad:FindFirstChildWhichIsA("Humanoid")~=nil end local ac=function(



ac)
local ad=ac.playerService:getCharacter()
local ae={}

for af,ag in workspace:GetDescendants()do
if ag:IsA("BasePart")and not ag.Anchored and not(ad and ag:IsDescendantOf(ad))and not ab(ag)then
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
local ag=af and af.Character and af.Character:FindFirstChild("Head")
if not ag then return end

local ah=ad:registerGarbage("tpunanchored")
ah.forces=ah.forces or{}

for ai,aj in ac(ad)do

local ak=Instance.new("BodyPosition")
ak.MaxForce=Vector3.one*math.huge
ak.Position=ag.Position
ak.Parent=aj
table.insert(ah.forces,ak)
end
end
},
{
action="freezeunanchored|freezeua|animsunanchored",
description="Freezes unanchored parts",
run=function(ad)
if ad:hasGarbage("freezeua")then
ad:notify("Freeze","unanchored parts are already frozen, use thawunanchored")
return
end

local ae=ad:createGarbage("freezeua")
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
local ae=ad:collectGarbage("tpunanchored")
if ae then
for af,ag in ae.forces or{}do
ag:Destroy()
end
end

local af=ad:collectGarbage("freezeua")
if af then
for ag,ah in af.parts do
if ah.Parent then
ah.Anchored=false
end
end
end
end
}
}end a.cn=function()local ab=a.cache.cn if not ab then ab={c=aa()}a.cache.cn=ab end return ab.c end end do local aa=function()

return{a.ce()
,a.cf()
,a.cg()
,a.ch()
,a.ci()
,a.cj()
,a.ck()
,a.cl()
,a.cm()
,a.cn()

}end a.co=function()local ab=a.cache.co if not ab then ab={c=aa()}a.cache.co=ab end return ab.c end end do local aa=function()local aa=function(

aa)
local ab=aa.robloxServices.Lighting
ab.Brightness=2
ab.ClockTime=14
ab.FogEnd=100000
ab.GlobalShadows=false
ab.OutdoorAmbient=Color3.fromRGB(128,128,128)end local ab=function(


ab)
local ac=ab:collectGarbage("loopfullbright")
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

local ad=ac:createGarbage("loopfullbright")
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
}end a.cp=function()local ab=a.cache.cp if not ab then ab={c=aa()}a.cache.cp=ab end return ab.c end end do local aa=function()

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
}end a.cq=function()local ab=a.cache.cq if not ab then ab={c=aa()}a.cache.cq=ab end return ab.c end end do local aa=function()

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
}end a.cr=function()local ab=a.cache.cr if not ab then ab={c=aa()}a.cache.cr=ab end return ab.c end end do local aa=function()

return{
client=true,
action="nofog",
description="Removes fog",
run=function(aa)
local ab=aa.robloxServices.Lighting
ab.FogEnd=100000

for ac,ad in ab:GetDescendants()do
if ad:IsA("Atmosphere")then
ad:Destroy()
end
end
end
}end a.cs=function()local ab=a.cache.cs if not ab then ab={c=aa()}a.cache.cs=ab end return ab.c end end do local aa=function()

return{
client=true,
action="brightness",
description="Changes the brightness lighting property",
args={kind="number"},
run=function(aa,ab)
aa.robloxServices.Lighting.Brightness=ab:nextValue()
end
}end a.ct=function()local ab=a.cache.ct if not ab then ab={c=aa()}a.cache.ct=ab end return ab.c end end do local aa=function()

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
}end a.cu=function()local ab=a.cache.cu if not ab then ab={c=aa()}a.cache.cu=ab end return ab.c end end do local aa=function()

local aa=a.b()
local ab=a.ag()


local ac=a.f().Lighting

local ad={"Ambient","OutdoorAmbient","Brightness","ClockTime","FogEnd","FogStart","GlobalShadows"}
local ae={}local af=function()


for af,ag in ae do
ac[af]=ag
end end local ag=function()



if aa.originalLighting then
ae=aa.originalLighting
return
end

for ag,ah in ad do
ae[ah]=ac[ah]
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
run=function(ah,ai)
local aj=ab(ai:nextValue())
local ak=ai:nextValue()or 10

for b,c in aj do
local d=c.Character and c.Character:FindFirstChild("HumanoidRootPart")
if not d then return end

local e=Instance.new("PointLight")
e.Range=ak
e.Brightness=5
e.Parent=d

table.insert(ah:registerGarbage("dynamicLights"),e)
end
end
},
{
action="nolight|unlight",
description="Removes dynamic light from your player",
run=function(ah)
for ai,aj in ah:collectGarbage("dynamicLights")or{}do
aj:Destroy()
end

local ai=ah.playerService:getCharacter()
if ai then
for aj,ak in ai:GetDescendants()do
if ak:IsA("PointLight")then
ak:Destroy()
end
end
end
end
}
}end a.cv=function()local ab=a.cache.cv if not ab then ab={c=aa()}a.cache.cv=ab end return ab.c end end do local aa=function()

return{a.cp()
,a.cq()
,a.cr()
,a.cs()
,a.ct()
,a.cu()
,a.cv()

}end a.cw=function()local ab=a.cache.cw if not ab then ab={c=aa()}a.cache.cw=ab end return ab.c end end do local aa=function()





local aa=a.p()

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


return ab end a.cx=function()local ab=a.cache.cx if not ab then ab={c=aa()}a.cache.cx=ab end return ab.c end end do local aa=function()

local aa=a.cx()

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
}end a.cy=function()local ab=a.cache.cy if not ab then ab={c=aa()}a.cache.cy=ab end return ab.c end end do local aa=function()

return{

extensions={".luau",".lua",".txt",".iy"},

translateClassic=true,

sectionName="plugin commands",
}end a.cz=function()local ab=a.cache.cz if not ab then ab={c=aa()}a.cache.cz=ab end return ab.c end end do local aa=function()



local aa=a.a()
local ab=a.ag()

local ac={}
local ad
local ae

ac.configure=function(af, ag)
ad=af
ae=ag end



ac.detect=function(af)
if type(af)~="table"or af.action~=nil or#af>0 then return false end
if type(af.Commands)~="table"then return false end
if type(af.PluginName)=="string"or type(af.PluginDescription)=="string"then
return true
end
for ag,ah in af.Commands do
if type(ag)=="string"and type(ah)=="table"and type(ah.Function)=="function"then
return true
end
end
return false end




ac.environment=function(af)
if type(aa.getfenv)~="function"or type(aa.setfenv)~="function"then return nil end
local ag=aa.getfenv(af)
local ah=setmetatable({},{__index=ag,__newindex=ag})
aa.setfenv(af,ah)
return ah end local af=function(


af)
if not af or not ad then return end
local ag={
Players=ad.players,
LocalPlayer=ad.localPlayer,
IYMouse=ad.playerService:getMouse(),
notify=function(...)return ad:notify(...)end,
getRoot=function(ag)
return ag and(ag:FindFirstChild("HumanoidRootPart")
or ag:FindFirstChild("Torso")or ag:FindFirstChild("UpperTorso"))
end,
getPlayer=function(ag,ah)
if not ag then return{(ah or ad.localPlayer).Name}end
local ai={}
for aj,ak in ab(ag)do
table.insert(ai,ak.Name)
end
return ai
end,
getstring=function(ag,ah)
return table.concat(ah or rawget(af,"cargs")or{}," ",ag or 1)
end,
execCmd=function(ag)
return ae(ag)
end,
}
for ah,ai in ag do
rawset(af,ah,ai)
end end


ac.translate=function(ag, ah)
if ag.PluginDescription~=nil and type(ag.PluginDescription)~="string"then
return nil,"PluginDescription must be a string"
end
local ai={}
for aj,ak in ag.Commands do
if type(aj)~="string"or aj==""or aj:find("[|%s]")then
return nil,"classic plugin command names must be non-empty and cannot contain spaces or '|'"
end
if type(ak)~="table"or type(ak.Function)~="function"then
return nil,`classic command '{aj}' needs a Function`
end
if ak.Aliases~=nil and type(ak.Aliases)~="table"then
return nil,`Aliases of '{aj}' must be a table`
end
if ak.Description~=nil and type(ak.Description)~="string"then
return nil,`Description of '{aj}' must be a string`
end

local b={aj}
local c={[aj:lower()]=true}
for d,e in ak.Aliases or{}do
if type(e)~="string"or e==""or e:find("[|%s]")then
return nil,`invalid alias of '{aj}'`
end
if not c[e:lower()]then
c[e:lower()]=true
table.insert(b,e)
end
end

local d=ak.Function
table.insert(ai,{
action=table.concat(b,"|"),
description=ak.Description or ag.PluginDescription or"",
classicListName=ak.ListName,
args={kind="string",name="args",optional=true,variadic=true},
run=function(e,f)
local g={}
while true do
local h=f:nextValue()
if h==nil then break end
table.insert(g,h)
end
if ah then rawset(ah,"cargs",g)end
local h=d(g,e.localPlayer)
if type(h)=="string"and not table.find(g,"nonotify")then
e:notify(`Command: {aj}`,h)
end
return h
end,
})
end
if#ai==0 then return nil,"the classic plugin has no commands"end
table.sort(ai,function(aj,ak)return aj.action:lower()<ak.action:lower()end)
af(ah)
return ai end


return ac end a.cA=function()local ab=a.cache.cA if not ab then ab={c=aa()}a.cache.cA=ab end return ab.c end end do local aa=function()






















local aa=a.a()
local ab=a.j()
local ac=a.m()
local ad=a.cz()
local ae=a.cA()

local af={}

local ag=`{ab.privateFolder}/plugins`

af.FOLDER=ag


local ah={}


local ai={}

local aj={isSection=true,isPluginSection=true}local ak=function(


ak)
local b=ak.original
if b then
for c=#b,1,-1 do
local d=b[c]
if d.isPluginCommand or d.isPluginSection then
table.remove(b,c)
end
end
local c={}
for d in ah do table.insert(c,d)end
table.sort(c)
if#c>0 then
aj.sectionName=ad.sectionName or"plugin commands"
table.insert(b,aj)
for d,e in c do
for f,g in ah[e].entries do
table.insert(b,g)
end
end
end
end
ak.revision=(ak.revision or 0)+1
if ak.changed then ak.changed:Fire()end end local b=function(


b, c)
local d=table.find(b,c)
if d then
table.remove(b,d)
end end local c=function(



c)
if type(c)~="string"then return nil end
local d=c
local e
for f,g in ad.extensions do
if c:sub(-#g):lower()==g then
d=c:sub(1,-#g-1)
e=c
break
end
end
if d:match("^[%w_%-]+$")then return d,e end
return nil end


af.normalizeName=c local d=function()



if aa.listfiles==nil then return nil,"your exploit does not support listfiles"end
local d,e=pcall(aa.listfiles,ag)
if not(d and type(e)=="table")then
return nil,`could not read the folder {ag}`
end
local f={}
for g,h in e do
local i=type(h)=="string"and h:match("([^/\\]+)$")
if i then
local j,k=c(i)
if j and k then
table.insert(f,{name=j,filename=i})
end
end
end
table.sort(f,function(g,h)return g.filename<h.filename end)
return f end local e=function(


e, f)
if aa.readfile==nil or aa.isfile==nil then
return nil,"your exploit does not support readfile"
end

local g={}
local h={}local i=function(
i)
if not h[i]then
h[i]=true
table.insert(g,i)
end end


if f then
local j,k=c(f)
if j==e and k then i(k)end
end
for j,k in ad.extensions do i(e..k)end


local j
local k=1
while true do
local l=g[k]
if not l then
if j~=nil then break end
j=d()or{}
for m,n in ad.extensions do
for o,p in j do
if p.name==e and p.filename:sub(-#n):lower()==n then
i(p.filename)
end
end
end
l=g[k]
if not l then break end
end
local m=`{ag}/{l}`
local n,o=pcall(aa.isfile,m)
if n and o then
local p,q=pcall(aa.readfile,m)
if not(p and type(q)=="string")then
return nil,`could not read {m}`
end
return q,nil,l
end
k=k+1
end
return nil,`file not found in {ag}; tried: {table.concat(g,", ")}`end local f=function(



f)
if aa.loadstring==nil then return nil,"your exploit does not support loadstring"end
local g,h,i=pcall(aa.loadstring,f)
if not g then return nil,tostring(h)end
if not h then return nil,tostring(i)end

local j
if ad.translateClassic then
local k,l=pcall(ae.environment,h)
if k then j=l end
end
local k,l=pcall(h)
if not k then return nil,`error while loading the plugin: {l}`end
if type(l)~="table"then return nil,"the plugin must return a table of commands"end
if ad.translateClassic and ae.detect(l)then
local m,n,o=pcall(ae.translate,l,j)
if not m then return nil,`could not translate the classic plugin: {n}`end
return n,o
end
return l end local g=function(




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
for m,n in k.action:split("|")do
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



h, i, j)
local k,l,m=e(i,j)
if not k then
return false,l
end

local n,o=f(k)
if not n then
return false,o
end

local p,q=g(n)
if not p then
return false,q
end

local r={}
local s={}

for t,u in p do
for v,w in u.names do
if h.lookup[w]~=nil or s[w]then
return false,`'{w}' is already a command or an alias`
end
s[w]=true
table.insert(r,w)
end
end

local t={}
for u,v in p do
v.entry.isPluginCommand=true
v.entry.pluginName=i
table.insert(t,v.entry)
for w,x in v.names do
h.lookup[x]=v.entry
table.insert(h.array,x)
end
end

ah[i]={keys=r,commands=#p,filename=m,entries=t}
ac.object[i]=m
ak(h)
return true,#p end local i=function(



i, j, k)
local l,m=h(i,j,k)

ai[j]=if l then nil else tostring(m)
return l,m end local j=function(


j, k)
local l=ah[k]
if not l then return end

for m,n in l.keys do
j.lookup[n]=nil
b(j.array,n)
end

ah[k]=nil
ak(j)end



af.add=function(k, l)
local m,n=c(l)
if not m then
return false,"plugin names can only use letters, numbers, '_' and '-'"
end

if ah[m]then
return false,`'{m}' is already loaded`
end

local o,p=i(k,m,n)
if not o then
return false,p
end

ac:save()

return true,p end



af.remove=function(k, l)
local m=c(l)
if not m then return false end
if ac.object[m]==nil and ah[m]==nil then
return false
end

j(k,m)
ai[m]=nil

ac.object[m]=nil
ac:save()

return true end



af.reload=function(k, l)
local m,n=c(l)
if not m then return false,"invalid plugin name"end
if ac.object[m]==nil then
return false,`'{m}' is not installed`
end

local o=n or ac.object[m]
j(k,m)
local p,q=i(k,m,o)
if p then ac:save()end
return p,q end




af.restore=function(k)
local l={}

local m=false
for n,o in ac.object do
if c(n)~=n then
l[n]="invalid installed plugin name"
ai[n]=l[n]
elseif not ah[n]then
local p=if type(o)=="string"then o else nil
local q,r=i(k,n,p)
if q and ac.object[n]~=o then m=true end
if not q then
l[n]=tostring(r)
end
end
end

if m then ac:save()end
return l end



af.addAll=function(k)
local l,m=d()
if not l then return nil,m end
local n={added={},failed={}}
local o={}
for p,q in l do
local r=q.name
if ah[r]or o[r]then continue end
o[r]=true
local s,t=af.add(k,r)
if s then
table.insert(n.added,r)
else
table.insert(n.failed,`{r}: {t}`)
end
end
return n end




af.getInstalled=function()
local k={}

for l in ac.object do
local m=ah[l]

table.insert(k,{
name=l,
loaded=m~=nil,
commands=if m then m.commands else 0,
error=if m then nil else ai[l],
})
end

table.sort(k,function(l,m)
return l.name:lower()<m.name:lower()
end)

return k end



af.getAvailable=function()
local k,l=d()
if not k then return nil,l end
local m={}
local n={}
for o,p in k do
local q=p.name
if not n[q]and ac.object[q]==nil then
n[q]=true
table.insert(m,q)
end
end
table.sort(m,function(o,p)return o:lower()<p:lower()end)
return m end


return af end a.cB=function()local ab=a.cache.cB if not ab then ab={c=aa()}a.cache.cB=ab end return ab.c end end do local aa=function()

local aa=a.cB()

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
}end a.cC=function()local ab=a.cache.cC if not ab then ab={c=aa()}a.cache.cC=ab end return ab.c end end do local aa=function()

local aa=a.d()
local ab=a.v()local ac=function(


ac)
local ad={}
local ae={}
local af={}local ag=function(

ag)
aa:expect(ag.action,{"string"},"command action")
table.insert(ad,ag)

local ah={}
local ai=ag.args or{}
ag.args=ai

for aj,ak in ag.action:split("|")do
if not ag.name then
ag.name=ak
end

ae[ak]=ag

table.insert(ah,ak)
table.insert(af,ak)
end

table.sort(ah,function(aj,ak)
return#aj<#ak
end)

if#ai==0 and next(ai)then
ag.args={ai}
end

ag.aliases=ah
ag.action=nil end


for ah,ai in ac do
aa:expect(ai.name,{"string"},"section name")
aa:expect(ai.commands,{"table"},"section commands")

table.insert(ad,{
isSection=true,
sectionName=ai.name
})

for aj,ak in ai.commands do
if#ak==0 then
aa:assert(next(ak),"the command cannot be empty")
ag(ak)
continue
end

for b=1,#ak do
ag(ak[b])
end
end
end

return{
array=af,
lookup=ae,
original=ad,
revision=0,
changed=ab.new(),
}end


return ac({
{
name="general",
commands=a.av()
},
{
name="interface",
commands=a.aJ()
},
{
name="character",
commands=a.bj()
},
{
name="waypoints",
commands=a.bm()
},
{
name="teleport",
commands=a.bG()
},
{
name="communication",
commands=a.bR()
},
{
name="visual",
commands=a.bX()
},
{
name="camera",
commands=a.cd()
},
{
name="workspace",
commands=a.co()
},
{
name="lighting",
commands=a.cw()
},
{
name="aliases",
commands=a.cy()
},
{
name="plugins",
commands=a.cC()
}
})end a.cD=function()local ab=a.cache.cD if not ab then ab={c=aa()}a.cache.cD=ab end return ab.c end end do local aa=function()


































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































local aa={}


aa.searchAtArray=function(ab, 
ac, 
ad, 
ae)

if ad==""then return{}end

local af=ad:lower()
local ag={}
local ah={}

for ai,aj in ac do
local ak=tostring(aj):lower()

if#ak<#af then continue end

local b=ak:find(af,1,true)

if b==1 then
table.insert(ag,aj)
elseif b and not ae then
table.insert(ah,aj)
end
end

for ai,aj in ah do
table.insert(ag,aj)
end

return ag end


return aa end a.cE=function()local ab=a.cache.cE if not ab then ab={c=aa()}a.cache.cE=ab end return ab.c end end do local aa=function()








local aa=a.k()
local ab=a.j()
local ac=a.aw()

local ad={}


ad.path=function(ae, af)
return ab.downloadPath:format(ac,ae,af)end



ad.has=function(ae, af)
return aa:exist(ad.path(ae,af))end



ad.read=function(ae, af)
local ag=ad.path(ae,af)

if not aa:exist(ag)then
return nil
end

return aa:readFile(ag)end




ad.write=function(ae, af, ag)
local ah=ad.path(ae,af)
local ai=ah:match("^(.*)/[^/]+$")

if ai then
local aj
for ak in ai:gmatch("[^/]+")do
aj=if aj then`{aj}/{ak}`else ak
aa:makeFolder(aj)
end
end

aa:writeFile(ah,ag)end


return ad end a.cF=function()local ab=a.cache.cF if not ab then ab={c=aa()}a.cache.cF=ab end return ab.c end end do local aa=function()

local aa=a.ax()
local ab=a.cF()
local ac=a.d()

local ad=aa.owner
local ae=aa.repository

local af=`https://raw.githubusercontent.com/{ad}/{ae}/refs/heads/main/`
local ag=`https://github.com/{ad}/{ae}/releases/latest/download/`

local ah={}local ai=function(

ai)
return game:HttpGet(ai)end local aj=function(


aj)
if aj:sub(1,1)=="/"then
return aj:sub(2)
end

return aj end local ak=function(


ak, b)
local c=ak..aj(b)
local d,e=pcall(ai,c)

if not d then
ac:warn(`failed to fetch http url '{c}':\n\t{e}`)
return nil
end

if type(e)~="string"or#e==0 then
ac:warn(`empty response from '{c}'`)
return nil
end

return e end


ah.download=function(b)
return ak(ag,b)end



ah.downloadUrl=function(b)
return ag..aj(b)end



ah.fetchUrl=function(b)
return ak("",b)end


ah.fetch=function(b)
return ak(af,b)end




ah.fetchReference=function(b)
local c=aj(b)

local d=ab.read("reference",c)
if d~=nil then
return d
end

local e=ah.fetch(b)
if e~=nil then
ab.write("reference",c,e)
end

return e end local b=function(



b)
return(b:gsub("^backups/",""))end local c=function(



c, d, e)
local f,g=loadstring(c,e)

if f==nil then
ac:warn(`failed to compile '{d}':\n\t{g}`)
return nil
end

return f end




ah.load=function(d, e)
local f=b(d)

local g=ab.read("scripts",f)
if g~=nil then
local h=c(g,d,e)

if h~=nil then
return h
end
end

local h=ah.fetch(d)
if h==nil then
return nil
end

local i=c(h,d,e)

if i~=nil then
ab.write("scripts",f,h)
end

return i end


return ah end a.cG=function()local ab=a.cache.cG if not ab then ab={c=aa()}a.cache.cG=ab end return ab.c end end do local aa=function()

local aa=a.f()
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
message=Instance.new("Message")
},ac)end


return ac end a.cH=function()local ab=a.cache.cH if not ab then ab={c=aa()}a.cache.cH=ab end return ab.c end end do local aa=function()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cI=function()local ab=a.cache.cI if not ab then ab={c=aa()}a.cache.cI=ab end return ab.c end end do local aa=function()
local aa=a.cI()

local ab={}

ab.getScale=function(ac, ad)
return aa.isEnabled and(ad*aa.animationScale)or 0 end


ab.getScrollSpeed=function(ac, ad)
return(ad*aa.scrollSpeed)end


return ab end a.cJ=function()local ab=a.cache.cJ if not ab then ab={c=aa()}a.cache.cJ=ab end return ab.c end end do local aa=function()
return{
createService=a.bZ(),
specialProps=a.bY(),

connectionService=a.aE(),
fetchService=a.cG(),
keyboardService=a.aH(),
localPlayer=a.g(),
messageService=a.cH(),
playerService=a.af(),
rbxServices=a.f(),
tweenService=a.cJ(),
}end a.cK=function()local ab=a.cache.cK if not ab then ab={c=aa()}a.cache.cK=ab end return ab.c end end do local aa=function()

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

Tonal={
Default=Color3.fromRGB(61,67,135),
Text=Color3.fromRGB(232,233,235),
Disabled=Color3.fromRGB(78,78,79),
DisabledText=Color3.fromRGB(120,120,120),
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
}end a.cL=function()local ab=a.cache.cL if not ab then ab={c=aa()}a.cache.cL=ab end return ab.c end end do local aa=function()

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
Tonal={
Default=Color3.fromRGB(61,67,135),
Text=Color3.fromRGB(232,233,235),
Disabled=Color3.fromRGB(42,42,42),
DisabledText=Color3.fromRGB(110,110,110),
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
}end a.cM=function()local ab=a.cache.cM if not ab then ab={c=aa()}a.cache.cM=ab end return ab.c end end do local aa=function()
return{
DisplayName="Light",

Font={
Normal=Enum.Font.BuilderSans,
Medium=Enum.Font.BuilderSansMedium,
Bold=Enum.Font.BuilderSansBold,
ExtraBold=Enum.Font.BuilderSansExtraBold,
MonoSpace=Enum.Font.RobotoMono,
},
Colors={
Background=Color3.fromRGB(243,243,245),
Primary=Color3.fromRGB(88,101,242),
OnPrimary=Color3.fromRGB(214,218,253),
Stroke=Color3.fromRGB(212,212,218),

Error=Color3.fromRGB(210,40,40),
Icons=Color3.fromRGB(40,40,48),

ScrollBar={
Thumb=Color3.fromRGB(190,190,198),
Arrow=Color3.fromRGB(60,60,70),
Background=Color3.fromRGB(226,226,230),
},
Buttons={
Holding=Color3.fromRGB(218,218,226),
Default=Color3.fromRGB(231,231,237),
},
Border={
Holding=Color3.fromRGB(180,180,192),
Default=Color3.fromRGB(208,208,216),
},
Tonal={
Default=Color3.fromRGB(214,218,253),
Text=Color3.fromRGB(20,20,24),
Disabled=Color3.fromRGB(218,218,226),
DisabledText=Color3.fromRGB(150,150,160),
},
Text={
Default=Color3.fromRGB(20,20,24),
Dark=Color3.fromRGB(62,62,70),
Darker=Color3.fromRGB(105,105,115),
},
Slider={
SliderBar=Color3.fromRGB(120,130,240),
SliderNumber=Color3.fromRGB(40,40,48),
},
},
}end a.cN=function()local ab=a.cache.cN if not ab then ab={c=aa()}a.cache.cN=ab end return ab.c end end do local aa=function()

return{
DisplayName="M3 Dark",



Font={
Normal=Enum.Font.BuilderSans,
Medium=Enum.Font.BuilderSansMedium,
Bold=Enum.Font.BuilderSansBold,
ExtraBold=Enum.Font.BuilderSansExtraBold,
MonoSpace=Enum.Font.RobotoMono,
},
Colors={
Background=Color3.fromRGB(20,18,24),
Primary=Color3.fromRGB(208,188,255),
OnPrimary=Color3.fromRGB(56,30,114),
Stroke=Color3.fromRGB(73,69,79),

Error=Color3.fromRGB(242,184,181),
Icons=Color3.fromRGB(230,224,233),

ScrollBar={
Thumb=Color3.fromRGB(73,69,79),
Arrow=Color3.fromRGB(230,224,233),
Background=Color3.fromRGB(33,31,38),
},
Buttons={
Holding=Color3.fromRGB(43,41,48),
Default=Color3.fromRGB(33,31,38),
},
Border={
Holding=Color3.fromRGB(54,52,59),
Default=Color3.fromRGB(27,25,31),
},
Tonal={
Default=Color3.fromRGB(74,68,88),
Text=Color3.fromRGB(232,222,248),
Disabled=Color3.fromRGB(45,43,49),
DisabledText=Color3.fromRGB(100,96,103),
},
Text={
Default=Color3.fromRGB(230,224,233),
Dark=Color3.fromRGB(202,196,208),
Darker=Color3.fromRGB(147,143,153),
},
Slider={
SliderBar=Color3.fromRGB(208,188,255),
SliderNumber=Color3.fromRGB(230,224,233),
},
},
}end a.cO=function()local ab=a.cache.cO if not ab then ab={c=aa()}a.cache.cO=ab end return ab.c end end do local aa=function()

local aa={a.cL()
,a.cM()
,a.cN()
,a.cO()

}

local ab={}

for ac,ad in aa do
local ae=string.lower(ad.DisplayName)
ab[ae]=ad
end

return ab end a.cP=function()local ab=a.cache.cP if not ab then ab={c=aa()}a.cache.cP=ab end return ab.c end end do local aa=function()







return{
defaultKey="theme",
darken=0.31,

options={
{key="theme"},
{key="darkGreen",color=Color3.fromRGB(34,110,62)},
{key="red",color=Color3.fromRGB(214,58,58)},
},
}end a.cQ=function()local ab=a.cache.cQ if not ab then ab={c=aa()}a.cache.cQ=ab end return ab.c end end do local aa=function()

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
for af in ae:gmatch("[^%.]+")do
ad=ad[af]
end
return ad end


aa.simpleCreate=function(ad, ae)
local af=Instance.new(ad)
for ag,ah in ae do
af[ag]=ah
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
for af in ad:gmatch(".")do
ae[af]=true
end
return ae end


aa.versionToNumber=function(ad)
local ae=ad:gsub("^v","")

local af=0
local ag=ae:split(".")

for ah,ai in ag do
local aj=tonumber(ai)or 0
af=af+aj*math.pow(1000,3-ah)
end

return af end


aa.colorFromRGB=function(ad, ae)
return`<font color="#{ae:ToHex()}">{ad}</font>`end


aa.richFontSize=function(ad, ae)
return`<font size="{ae}">{ad}</font>`end


return aa end a.cR=function()local ab=a.cache.cR if not ab then ab={c=aa()}a.cache.cR=ab end return ab.c end end do local aa=function()
local aa=a.cP()
local ab=a.cQ()
local ac=a.n()

local ad=a.d()
local ae=a.cR()



local af={
objects={},
selectedTheme=nil,
selectedKey=nil,
}

local ag="themePrimary."


af.isUsable=function(ah, ai)
return ai~=nil and ai.Colors~=nil and ai.Font~=nil end



af.getThemes=function(ah)
local ai={}

for aj,ak in aa do
table.insert(ai,{
key=aj,
name=ak.DisplayName,
theme=ak,
usable=ah:isUsable(ak),
})
end

table.sort(ai,function(aj,ak)
return aj.name<ak.name
end)

return ai end



af.getPrimaryOptions=function(ah)
return ab.options end local ah=function(


ah)
for ai,aj in ab.options do
if aj.key==ah then
return aj
end
end

return nil end



af.getPrimaryKey=function(ai, aj)
local ak=ac:getValue(ag..aj:lower())

if type(ak)=="string"and ah(ak)then
return ak
end

return ab.defaultKey end



af.getPrimaryColor=function(ai, aj, ak)
local b=ah(ak)

if b and b.color then
return b.color
end

return aj.Colors.Primary end local ai=function(



ai, aj)
local ak=ah(aj)

if not ak or ak.color==nil then
return ai
end

local b=table.clone(ai.Colors)
b.Primary=ak.color
b.OnPrimary=ak.color:Lerp(Color3.new(0,0,0),ab.darken)

local c=table.clone(ai)
c.Colors=b

return c end


af.selectTheme=function(aj, ak)
ad:expect(ak,{"string"},"'themeService:selectTheme' #1")

local b=ak:lower()
local c=aa[b]

if not c then
ad:error(`'{ak}' isn't a valid theme`)
return
end

aj.selectedKey=b
aj.selectedTheme=if aj:isUsable(c)then ai(c,aj:getPrimaryKey(b))else c
aj:updateObjects()

return aj end



af.setPrimary=function(aj, ak, b)
local c=ak:lower()

ac:setValue(ag..c,b)
ac:save()

if aj.selectedKey==c then
aj:selectTheme(c)
end end


af.updateObject=function(aj, ak)

aj:updateObjectProperties(ak,aj.objects[ak])end


af.updateObjectProperties=function(aj, 
ak, 
b)

for c,d in b do
ak[c]=ae.getDeep(aj.selectedTheme,d)
end end


af.updateObjects=function(aj)
for ak,b in aj.objects do
aj:updateObject(ak)
end end


af.addObject=function(aj, ak, b)
aj.objects[ak]=b
aj:updateObject(ak)end




af.removeObject=function(aj, ak)
aj.objects[ak]=nil end




af.resetRemovedPrimaries=function(aj)
local ak=false

for b in aa do
local c=ac:getValue(ag..b)

if c~=nil and not(type(c)=="string"and ah(c))then
ac:setValue(ag..b,ab.defaultKey)
ak=true
end
end

if ak then
ac:save()
end end


af.init=function(aj, ak)
ad:expect(ak,{"table"},"'themeService:init' #1")

aj:resetRemovedPrimaries()

if ak.theme~=nil then
aj:selectTheme(ak.theme)
end end


return af end a.cS=function()local ab=a.cache.cS if not ab then ab={c=aa()}a.cache.cS=ab end return ab.c end end do local aa=function()



local aa=a.cK()
local ab=a.d()

local ac=aa.specialProps
local ad=a.cS()

ac.ThemeTag=function(ae, af)
if type(af)~="table"then
ab:error("expected a 'table' when setting a theme tag")
return
end

ad:addObject(ae,af)end


return a.bZ()end a.cT=function()local ab=a.cache.cT if not ab then ab={c=aa()}a.cache.cT=ab end return ab.c end end do local aa=function()return{logo=104371861083126,close=83276213460768,minimize=76683704146139,["lucide-chevron-left"]=116084397950605,["lucide-blocks"]=80329404661557,["lucide-terminal"]=138735373900955,["lucide-pin"]=85638424763987,["lucide-refresh-cw"]=127184558868486,["lucide-eraser"]=121383006814792,["lucide-tag"]=95367077436662,
["lucide-keyboard"]=102097005397654,
["lucide-palette"]=105784737972091,
["lucide-map-pin"]=132787420207871,
["lucide-puzzle"]=139412930697283,
["lucide-zap"]=124181719324437,imgstudiopluginlogo=

4113050383,pin=
6234691350,

["lucide-send"]=80218825031596,
["lucide-sliders-horizontal"]=116738462591690,
["lucide-arrow-down-up"]=121401768678469,
["lucide-calendar-clock"]=121068586159290,
["lucide-chart-column"]=102316903470982,
["lucide-trash"]=126160659084333,reference=


116342494079103,settings=
102340652201372,

["lucide-clipboard-copy"]=103811515822314,
["lucide-arrow-left"]=88403839941496,
["lucide-arrow-right"]=97590643131532,
}end a.cU=function()local ab=a.cache.cU if not ab then ab={c=aa()}a.cache.cU=ab end return ab.c end end do local aa=function()



local aa=a.a()
local ab=a.az()

local ac=ab.storage.imagePath

local ad=a.k()
local ae=a.cF()
local af=a.cG()
local ag=a.d()

local ah=a.cU()

local ai={}
local aj={}

local ak=aa.getcustomasset

local b={}

b.newCustomAsset=function(c, d, e)
ag:assert(not ai[d],"asset is already loaded")

local f=ad:getCustomAsset(e)

if f==nil then
f=ah[d]
ai[d]=f
return f
end

ag:log(`new custom asset to '{e}': '{f}'`)
return f end


b.get=function(c, d)

if ai[d]then
return ai[d]
end

if type(ak)~="function"then
return ah[d]
end

local e=`{d}.png`
local f=ae.path("assets",e)
ag:log(`loading asset: '{f}'`)

if ae.has("assets",e)then
return c:newCustomAsset(d,f)
end

local g=af.fetch(ac:format(d))

if g==nil then
local h=ah[d]
h=if type(h)=="number"then`rbxassetid://{h}`else h

ai[d]=h
return h
end

ae.write("assets",e,g)
ag:log(`created a file to asset: '{f}'`)

return c:newCustomAsset(d,f)end


b.loadImage=function(c, d, e)
ag:assert(ah[e],`invalid asset name: {e}`)

local f=ai[e]
if f~=nil then
d.Image=f
return
end

d.Image=""

if aj[e]then
table.insert(aj[e],d)
return
end

aj[e]={d}

task.defer(function()
local g=c:get(e)
if not g then return end

for h,i in aj[e]do
i.Image=g
end

aj[e]=nil
end)end


return b end a.cV=function()local ab=a.cache.cV if not ab then ab={c=aa()}a.cache.cV=ab end return ab.c end end do local aa=function()
return{
uiScale=Instance.new("UIScale"),
getScale=function(aa)
local ab=aa.uiScale
return ab and(ab:GetAttribute("REAL_SCALE")or ab.Scale)or 1
end,
setScale=function(aa,ab)
local ac=aa.uiScale

if ac then
ac.Scale=ab
ac:SetAttribute("REAL_SCALE",ab)
end
end
}end a.cW=function()local ab=a.cache.cW if not ab then ab={c=aa()}a.cache.cW=ab end return ab.c end end do local aa=function()



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
}end a.cX=function()local ab=a.cache.cX if not ab then ab={c=aa()}a.cache.cX=ab end return ab.c end end do local aa=function()

local aa=Color3.fromRGB(248,109,115)
local ab=Color3.fromRGB(223,215,136)
local ac=Color3.fromRGB(156,121,223)
local ad=Color3.fromRGB(225,37,105)
local ae=Color3.fromRGB(118,113,94)
local af=Color3.fromRGB(97,181,195)
local ag=Color3.fromRGB(254,193,7)
local ah=Color3.fromRGB(244,66,54)
local ai=Color3.fromRGB(166,227,45)
local aj=Color3.fromRGB(255,149,75)
local ak=Color3.fromRGB(166,227,45)

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
ah,valid=
ai,tag=
aj,func=
ak,field=
aa,
},
commands={undefined=
ah,client=
ab,deprecated=
ae
}
}end a.cY=function()local ab=a.cache.cY if not ab then ab={c=aa()}a.cache.cY=ab end return ab.c end end do local aa=function()








local aa=a.cY().args
local ab=a.cR()

local ac={}


local ad=ab.charset(":#()[]<>{}-––&*$%@")


local ae="^[%w_%.]+"


local af="^[%w_]+"local ag=function(

ag)
return ag~=""and string.match(ag,"[%w_%.]")~=nil end local ah=function(


ah)
return string.match(ah,"^%d+$")~=nil or string.match(ah,"^%d+%.%d+$")~=nil end local ai=function(




ai, aj)
local ak=string.sub(ai,aj,aj)
local b=aj+1

while b<=#ai do
local c=string.sub(ai,b,b)

if c=="\\"then
b=b+2
elseif c==ak then
return b
else
b=b+1
end
end

return nil end local aj=function(



aj)
local ak={}local b=function(

b, c, d)
if b==""then
return
end

local e=ak[#ak]
if e and e.color==c and e.bold==d then
e.text=e.text..b
else
table.insert(ak,{text=b,color=c,bold=d})
end end


local c=1
local d=#aj

while c<=d do
local e=string.sub(aj,c,c)
local f=if c>1 then string.sub(aj,c-1,c-1)else""


if(e=="@"or e=="#")and not ag(f)then
local g,h=string.find(aj,af,c+1)
if h then
b(string.sub(aj,c,h),aa.tag,true)
c=h+1
continue
end
end


if(e=='"'or e=="'")and not ag(f)then
local g=ai(aj,c)

if g then
b(string.sub(aj,c,g),aa.string,false)
c=g+1
continue
end
end

if ag(e)then
local g,h=string.find(aj,ae,c)
local i=string.sub(aj,c,h)
b(i,if ah(i)then aa.number else nil,false)
c=h+1
else
b(e,if ad[e]then aa.symbol else nil,false)
c=c+1
end
end

return ak end


ac.apply=function(ak, b)
local c={}

for d,e in aj(tostring(b))do
local f=ab.escapeRichText(e.text)

if e.color then
f=ab.colorFromRGB(f,e.color)
end
if e.bold then
f=`<b>{f}</b>`
end

table.insert(c,f)
end

return table.concat(c)end


return ac end a.cZ=function()local ab=a.cache.cZ if not ab then ab={c=aa()}a.cache.cZ=ab end return ab.c end end do local aa=function()



local aa=a.cT()
local ab=a.cV()
local ac=a.cS()
local ad=a.cW()

local ae=a.aE()
local af=a.f()
local ag=a.cX()

local ah=a.cZ()

local ai=4
local aj=8



local ak=5
local b=5
local c=ag.titleHeight+ak+b*2

local d={
container=nil,

items={},
nextOrder=0,

queue={},


room=math.huge,
}local e=function(

e, f)
local g=aa.new("Frame","Notification",e,{
BorderSizePixel=0,
ClipsDescendants=true,
LayoutOrder=f,
Size=UDim2.fromOffset(ag.size.X.Offset,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local h=ai+ag.iconSize+aj

local i=aa.new("TextLabel","Title",g,{
AnchorPoint=Vector2.new(0.5,0),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0),
Size=UDim2.new(1,-h*2,0,ag.titleHeight),
Text="",
TextSize=ag.titleTextSize,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local j=aa.new("Frame","Description",g,{
AnchorPoint=Vector2.new(0.5,1),
ClipsDescendants=true,
Position=UDim2.new(0.5,0,1,-ak),
Size=UDim2.new(1,-10,1,-(ag.titleHeight+ak)),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})

aa.new("UICorner",j,{
CornerRadius=UDim.new(0,ag.cornerRadius),
})


local k=aa.new("TextLabel","Text",j,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=UDim2.fromOffset(b,b),
Size=UDim2.new(1,-b*2,0,0),
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

local l=aa.new("ImageButton","PinButton",g,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,ai,0,ag.titleHeight/2),
Size=UDim2.fromOffset(ag.iconSize,ag.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local m=aa.new("ImageButton","CloseButton",g,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-ai,0,ag.titleHeight/2),
Size=UDim2.fromOffset(ag.iconSize,ag.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(l,"pin")
ab:loadImage(m,"close")

return g,i,k,l,m,j end local f=function(




f, g, h)
local i=aa.new("Frame","Actions",f,{
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,1,-b),
Size=UDim2.new(1,-b*2,0,ag.actionHeight),
ZIndex=2,

aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,ag.actionGap),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local j={}

for k,l in g do
local m=l.primary==true

local n=aa.new("TextButton","Action",i,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
LayoutOrder=k,
Size=UDim2.fromOffset(0,ag.actionHeight),
Text=l.text,
TextSize=ag.textSize,
ZIndex=2,
ThemeTag={
BackgroundColor3=if l.primary then"Colors.Primary"else"Colors.Background",
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
})local o=function(


o)
if m then
n.BackgroundTransparency=if o then 0.2 else 0
else
ac:updateObjectProperties(n,{
BackgroundColor3=if o then"Colors.Buttons.Holding"else"Colors.Background",
})
end end


table.insert(h,ae:Connect(n.MouseEnter,function()
o(true)
end))
table.insert(h,ae:Connect(n.MouseLeave,function()
o(false)
end))

j[k]=n
end

return j end local g=function(


g)
for h,i in g.connections do
ae:disconnect(i)
end

table.clear(g.connections)end


d.getContainer=function(h, i)
if h.container then
return h.container
end

local j=aa.new("Frame","Notifications",i,{
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(ag.size.X.Offset,0),
})

aa.new("UIListLayout",j,{
Padding=UDim.new(0,ag.spacing),
SortOrder=Enum.SortOrder.LayoutOrder,
})

h.container=j


j.ChildAdded:Connect(function()
h:refreshLayout()
end)

j.ChildRemoved:Connect(function()
h:refreshLayout()
end)

local k=h.queue
h.queue={}

for l,m in k do
h:add(m.title,m.message,m.duration,m.choices)
end

return j end



d.getStackHeight=function(h)
local i=h.container
if not i then return 0 end

local j=0
local k=0

for l,m in i:GetChildren()do
if m:IsA("GuiObject")then
j=j+1
k=k+m.Size.Y.Offset
end
end

if j>1 then
k=k+(j-1)*ag.spacing
end

return k end



d.refreshLayout=function(h)
local i=h.container
if not i then return end

i.Size=UDim2.fromOffset(ag.size.X.Offset,h:getStackHeight())

if h.onLayoutChanged then
h.onLayoutChanged()
end end


d.tweenHeight=function(h, i, j)
if i.tween then
i.tween:Cancel()
end

local k=TweenInfo.new(ag.tweenTime,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
i.tween=af.TweenService:Create(i.frame,k,{
Size=UDim2.fromOffset(ag.size.X.Offset,j),
})
i.tween:Play()end




d.wantedHeight=function(h, i)
local j=math.max(ad:getScale(),0.01)
local k=i.textLabel.AbsoluteSize.Y/j


local l=if i.actionsHeight>0 then 0 else ag.size.Y.Offset
local m=math.max(k+c+i.actionsHeight,l)
return math.min(m,ag.maxHeight,h.room)end



d.fitHeight=function(h, i, j)
if i.removed or not i.textLabel then return end

local k=h:wantedHeight(i)
if k==i.height then return end
i.height=k

if j then
if i.tween then
i.tween:Cancel()
end

i.frame.Size=UDim2.fromOffset(ag.size.X.Offset,k)
else
h:tweenHeight(i,k)
end end




d.setRoom=function(h, i)
if i==h.room then return end
h.room=i

for j,k in h.items do
h:fitHeight(k,true)
end

h:trimToRoom()end



d.liveHeight=function(h)
local i=0

for j,k in h.items do
i=i+k.height
end

if#h.items>1 then
i=i+(#h.items-1)*ag.spacing
end

return i end



d.trimToRoom=function(h)
while#h.items>1 and h:liveHeight()>h.room do
local i

for j,k in h.items do
if j==#h.items then break end

if not k.pinned then
i=k
break
end
end

if not i then break end
h:remove(i)
end end


d.pin=function(h, i)
if i.pinned or i.removed then return end
i.pinned=true

i.titleLabel.Text=i.title.." (Pinned)"
ac:addObject(i.pinButton,{ImageColor3="Colors.Primary"})

local j=i.titleLabel
task.spawn(function()
j.TextTransparency=0.5
task.wait(ag.flashTime)
j.TextTransparency=0
end)end


d.remove=function(h, i)
if i.removed then return end
i.removed=true

local j=table.find(h.items,i)
if j then
table.remove(h.items,j)
end

g(i)

h:tweenHeight(i,0)
task.delay(ag.tweenTime,function()
i.frame:Destroy()
end)end


d.trim=function(h)
while#h.items>ag.maxVisible do
local i

for j,k in h.items do
if not k.pinned then
i=k
break
end
end

if not i then break end
h:remove(i)
end end


d.add=function(h, i, j, k, l)
h.nextOrder=h.nextOrder+1

local m={
title=i,
pinned=false,
removed=false,
connections={},
height=ag.size.Y.Offset,
actionsHeight=if l then ag.actionHeight+ag.actionsTopGap+b else 0,
}

local n
m.frame,m.titleLabel,m.textLabel,m.pinButton,m.closeButton,n=
e(h.container,h.nextOrder)

m.titleLabel.Text=i
m.textLabel.Text=ah:apply(j)

table.insert(m.connections,ae:Connect(m.pinButton.Activated,function()
h:pin(m)
end))



local o=l~=nil and type(k)~="number"

if o then
m.pinned=true
m.pinButton.Visible=false
end

if l then
local p=f(n,l,m.connections)

for q,r in p do
local s=l[q]

table.insert(m.connections,ae:Connect(r.Activated,function()
if m.removed then return end

h:remove(m)

if s.onTap then
s.onTap()
end
end))
end
end

table.insert(m.connections,ae:Connect(m.closeButton.Activated,function()
h:remove(m)
end))


table.insert(m.connections,ae:Connect(m.textLabel:GetPropertyChangedSignal("AbsoluteSize"),function()
h:fitHeight(m)
end))

table.insert(h.items,m)
h:tweenHeight(m,m.height)


m.frame:GetPropertyChangedSignal("Size"):Connect(function()
h:refreshLayout()
end)
h:refreshLayout()

if not o then
local p=if type(k)=="number"then k else ag.defaultTime
task.delay(p,function()
if not m.pinned then
h:remove(m)
end
end)
end

h:trim()
h:trimToRoom()end


d.notify=function(h, i, j, k)
if j==nil then
j=i
i=ag.defaultTitle
end

i=tostring(i)

if not h.container then
table.insert(h.queue,{title=i,message=j,duration=k})
return
end

h:add(i,j,k)end






d.ask=function(h, i, j, k, l)
i=tostring(i)

if not h.container then
table.insert(h.queue,{title=i,message=j,choices=k,duration=l})
return
end

h:add(i,j,l,k)end


d.destroy=function(h)
for i,j in h.items do
g(j)
end

table.clear(h.items)
table.clear(h.queue)
h.container=nil end


return d end a.c_=function()local ab=a.cache.c_ if not ab then ab={c=aa()}a.cache.c_=ab end return ab.c end end do local aa=function()



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
local ah=ae._nextId

ae._callbacks[ah]={
func=af,
cooldown=math.max(ag or 0,0),
lastCall=-math.huge
}

ae:start()
return ah end



ac.remove=function(ae, af)
ab:expect(af,{"number"},"'loopService:remove' #1")
ae._callbacks[af]=nil end


return ac end a.c0=function()local ab=a.cache.c0 if not ab then ab={c=aa()}a.cache.c0=ab end return ab.c end end do local aa=function()
local aa=a.b()
local ab=a.a()

local ac=a.cD()
local ad=a.v()
local ae=a.d()

local af=a.t().usedCmds
local ag=a.j()
local ah=a.f()
local ai=a.az()

local aj=a.cE()
local ak=a.W()
local b=a.cx()
local c=a.cB()
local d=a.ag()

local e=ai.commands.cmdsRank
local f=e.maxTimesUsed
local g=e.decreasePerUse
local h=e.increasePerUse

local i=aa.iyGarbages or{}
aa.iyGarbages=i

local j={
garbages=i
}

j.registerGarbage=function(k, l)
return k:getGarbage(l)or k:createGarbage(l)end


j.createGarbage=function(k, l)
local m=k.garbages[l]
if m==nil then
m={}
k.garbages[l]=m
end

return m end


j.getCommandData=function(k, l)
return ac.lookup[l:lower()]end


j.hasGarbage=function(k, l)
return k.garbages[l]~=nil end


j.getGarbage=function(k, l)
return k.garbages[l]end


j.collectGarbage=function(k, l)
local m=k.garbages[l]

if m~=nil then
k.garbages[l]=nil
return m
end end


j.commandUsed=function(k, l)
local m=af:getValue(l)or 0

local n=math.clamp(m+h,0,f)
af:setValue(l,n)

for o,p in af:getData()do
if o==l then continue end

local q=(n==f)

if(q or p<n)and p>0 then
p=p-g

if p==0 then p=nil end
af:setValue(o,p)
end
end

af:save()end local k=function(



k)
local l={}
if k and k.args then
for m,n in k.args do
l[m]={value=n.value}
end
end
return l end





local l=setmetatable({},{__mode="k"})

local m=`{ag.privateFolder}/error-logs`local n=function(


n, o, p)
local q=ab.writefile
if not q then return nil end

if ab.makefolder then
pcall(ab.makefolder,ag.privateFolder)
pcall(ab.makefolder,m)
end

local r=`{m}/{os.time()}-{n}.txt`
local s=table.concat({
`command: {n}`,
`time: {os.date("%Y-%m-%d %H:%M:%S")}`,
`error: {o}`,
"",
"traceback:",
p or"(not available)",
},"\n")

local t=pcall(q,r,s)
if t then return r end

return nil end



j.reportError=function(o, p, q, r)
local s=tostring(q)
local t=n(p,s,r)

local u=s
if t then
u=u..`\nsaved to {t}`
end

o:notify(`'{p}' failed`,u)end



j.run=function(o, p, q, r)
ae:expect(p,{"string"},"'commandsController:run' #1")
ae:expect(q,{"table","nil"},"'commandsController:run' #2")

local s=ac.lookup[p]
ae:assert(s,"invalid command")


q=q or ak.new({})

local t=coroutine.running()
local u=l[t]
local v=u~=nil
local w=v and not r

if not w then
o:commandUsed(s.name)


local x=k(q)
o.privateEnv.lastArgs=o.privateEnv.lastArgs or{}
o.privateEnv.lastArgs[s.name]=x

if s.name~="lastcommand"then
o.privateEnv.lastCommand={
name=s.name,
args=x
}
end
end

if s.run==nil then
ae:warn(`missing command run func: {s.name}`)
return
end

if not v then
u={reported=false}
l[t]=u
end

local x
local y,z=xpcall(function()
s.run(o,q)
end,function(y)

x=debug.traceback(tostring(y),2)
return y
end)

if not v then
l[t]=nil
end

if not y then


if not u.reported then
u.reported=true
o:reportError(s.name,z,x)
end

error(z,0)
end end



j.getLastArgs=function(o, p)
local q=o.privateEnv.lastArgs
return q and q[p]end local o=function(


o)
local p=ac.lookup[o:lower()]
if p==nil then return 0 end


return af:getValue(p.name)or 0 end


j.search=function(p, q, r)
local s=aj:searchAtArray(ac.array,q,r)
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



j.resolvePlayers=function(p, q)
return d(q)end


j.init=function(p, q)
ae:assert(q,"'commandsController:init' #1 expected a config to init")

local r=a.aE()
local s=a.bk()
local t=a.c_()


p.notify=function(u, ...)
return t:notify(...)end



p.ask=function(u, ...)
return t:ask(...)end


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


local u=a.b_()
p.isMobile=u
p.isPC=not u


p.localPlayer=a.g()
p.executorEnv=ab
p.privateEnv=aa


p.infiniteYield=q.infiniteYield
p.playerService=q.playerService
p.fetchService=q.fetchService


p.signals={
onCameraReset=ad.new()
}


p.config={
links=ai.links
}


p.userSettings=UserSettings()
p.gameSettings=settings()

p.userGameSettings=p.userSettings:GetService("UserGameSettings")
p.gameNetworkSettings=p.gameSettings:GetService("NetworkSettings")


p.loopService=a.c0()


p.storage=a.t()


p.robloxServices=ah
p.rbxServices=ah

p.teleportService=ah.TeleportService
p.groupService=ah.GroupService
p.runService=ah.RunService
p.starterGui=ah.StarterGui
p.coreGui=ah.CoreGui
p.players=ah.Players
p.guiService=ah.GuiService
p.networkClient=ah.NetworkClient
p.proximityPromptService=ah.ProximityPromptService
p.commandsList=ac


b.restore(ac)


for v,w in c.restore(ac)do
ae:warn(`plugin '{v}' could not be loaded: {w}`)
end end


return j end a.c1=function()local ab=a.cache.c1 if not ab then ab={c=aa()}a.cache.c1=ab end return ab.c end end do local aa=function()


return{

settingKey="interface.keepIY",


bundleName="compiled.luau",


localBundlePath="iy-remake/compiled.luau",
}end a.c2=function()local ab=a.cache.c2 if not ab then ab={c=aa()}a.cache.c2=ab end return ab.c end end do local aa=function()



local aa=a.a()
local ab=a.aE()
local ac=a.f()
local ad=a.cG()
local ae=a.c2()
local af=a.n()
local ag=a.d()

local ah={}

local ai=false
local aj=false local ak=function()


return af:getValue(ae.settingKey)==true end local b=function()



local b=ad.downloadUrl(ae.bundleName)

return table.concat({
"local ok, source = pcall(readfile, \""..ae.localBundlePath.."\")",
"if not ok or type(source) ~= \"string\" or source == \"\" then",
"\tsource = game:HttpGet(\""..b.."\")",
"end",
"loadstring(source)()",
},"\n")end local c=function()



if aj or not ak()then return end

local c=aa.queueteleport
if c==nil then return end

aj=true

local d,e=pcall(c,b())
if not d then
aj=false
ag:warn("keepiy: failed to queue the loader: "..tostring(e))
end end


ah.start=function()
if ai then return end
ai=true

ab:Connect(ac.Players.LocalPlayer.OnTeleport,c)end


ah.enable=function(d)
if not d:expectExploit("queueteleport")then return end

d.infiniteYield:setKeepIY(true)
d:notify("Keepiy","on: IY runs again after you teleport, and the interface stays open")end


ah.disable=function(d)
d.infiniteYield:setKeepIY(false)
d:notify("Keepiy","off: IY will not run after the next teleport")end


ah.toggle=function(d)
if ak()then
ah.disable(d)
else
ah.enable(d)
end end


return ah end a.c3=function()local ab=a.cache.c3 if not ab then ab={c=aa()}a.cache.c3=ab end return ab.c end end do local aa=function()











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
}end a.c4=function()local ab=a.cache.c4 if not ab then ab={c=aa()}a.cache.c4=ab end return ab.c end end do local aa=function()

local aa=a.f()
local ab=a.ag()
local ac=a.cD()
local ad=a.l()
local ae=a.p()
local af=a.m()
local ag=a.cB()
local ah=a.cR()

















local ai={}local aj=function(

aj, ak, b)
return{
success=false,
message=aj,
options=ak,
comment=b,
}end



ai.normalizeOptions=function(ak)
if type(ak)=="string"then
return string.split(ak,"|")
end
return ak or{}end



ai.getOptions=function(ak, b)
local c=(b and b.options)or ak.options
return ai.normalizeOptions(c)end local ak=function(



ak, b)
local c=b:lower()

for d,e in ak do
local f=tostring(e)
if f:lower()==c then
return f
end
end

return nil end local b=function(


b)
if type(b)~="table"then return{}end
return ah.unlookupify(b)end local c=function(


c)
return{
success=true,
value=c,
color="string",
}end local d=function(


d, e)
local f=ai.normalizeOptions(e.options)

if#f==0 then
return c(d)
end

local g=ak(f,d)

if g then
return{success=true,value=g,color="string"}
end

return aj(" - invalid option",f)end


local e={
["true"]=true,yes=
true,enabled=
true,
["false"]=false,no=
false,disabled=
false,
}local f=function(

f)
local g=e[f:lower()]

if g==nil then
return aj(" - invalid boolean",{"false","true"})
end

return{
success=true,
value=g,
color="boolean",
}end local g=function(


g, h)
local i=tonumber(g)

if i==nil or i~=i or math.abs(i)==math.huge then
return aj(" - invalid number")
end

local j,k=h.min,h.max

if h.clamp then
j,k=h.clamp[1],h.clamp[2]
end

if j and i<j then
return aj(` - the <b>MIN</b> is <b>{j}</b>`)
end

if k and i>k then
return aj(` - the <b>MAX</b> is <b>{k}</b>`)
end

if h.floor and math.floor(i)~=i then
return aj(" - whole numbers only")
end


if tonumber(string.format("%.5f",i))~=i then
return aj(" - too many decimal places")
end

return{
success=true,
value=i,
display=`<b>{g}</b>`,
color="number",
}end local h=function(


h)
local i=h:split(",")

if#i>3 then
return aj(" - too many args")
end

local j={}

for k,l in i do

if l:match("^%s*$")then
l="0"
end

local m=g(l,{})

if not m.success then
return m
end

j[k]=m.value
end

if#j~=3 then
return{
success=false,
comment=true,
message=`: {({"X","Y","Z"})[#j+1]}`,
}
end

local k=Vector3.new(j[1],j[2],j[3])

return{
success=true,
value=k,
display=`({k})`,
color="others",
}end local i=function(


i)
local j=i:match("^#?(%x%x%x%x%x%x)$")

if j then
local k=tonumber(j:sub(1,2),16)
local l=tonumber(j:sub(3,4),16)
local m=tonumber(j:sub(5,6),16)

return{
success=true,
value=Color3.fromRGB(k,l,m),
color="others",
}
end

local k=i:split(",")

if#k~=3 then
return aj(" - use R,G,B or #hex")
end

local l={}

for m,n in k do
local o=g(n,{min=0,max=255,floor=true})

if not o.success then
return o
end

l[m]=o.value
end

return{
success=true,
value=Color3.fromRGB(l[1],l[2],l[3]),
color="others",
}end local j=function(


j)
if j==""then
return aj(" - player missing")
end

local k=ab.parts(j)

if#k==0 then
return aj(" - player missing")
end


for l,m in k do
if#ab(m)==0 then
if ab.hasOperators(m)then
return aj(" - no players match this")
end

if ab.isSelector(m)then
return aj(" - no players match this selector")
end

local n={}
for o,p in aa.Players:GetPlayers()do
table.insert(n,p.Name)
end

return aj(" - player not found",n)
end
end

return{success=true,value=j,color="valid"}end


local k={
"BasePart","Part","MeshPart","Model","Folder","Script","LocalScript",
"ModuleScript","Sound","Humanoid","Tool","ClickDetector",
"ProximityPrompt","TouchTransmitter","SpawnLocation","Seat","VehicleSeat",
}local l=function(

l)

local m=pcall(function()
local m=Instance.new(l)
m:Destroy()
end)

if m then
return{success=true,value=l,color="valid"}
end

return aj(" - invalid class name",k)end local m=function(


m)

local n=b(ad:getValue(tostring(game.PlaceId)))

if#n==0 then
return aj(" - no waypoints created")
end

local o=ak(n,m)

if o then
return{success=true,value=o,color="valid"}
end

return aj(" - invalid waypoint",n)end local n=function(


n)
local o={}

for p,q in aa.Teams:GetTeams()do
table.insert(o,q.Name)
end

if#o==0 then
return aj(" - there are no teams")
end

local p=ak(o,n)

if p then
return{success=true,value=p,color="valid"}
end

return aj(" - invalid team",o)end local o=function(


o)
local p=o:lower()
local q={}
local r

for s,t in Enum.KeyCode:GetEnumItems()do
table.insert(q,t.Name)

if t.Name:lower()==p then
r=t
end
end

if r then
return{success=true,value=r,color="valid"}
end

return aj(" - invalid key",q)end local p=function(


p)
local q=ac.lookup[p:lower()]

if q then
return{success=true,value=q.name,color="valid"}
end

return aj(" - invalid command",ac.array)end local q=function(



q, r, s, t)
local u=b(q:getData())

if#u==0 then
return aj(s)
end

local v=ak(u,r)

if v then
return{success=true,value=v,color="valid"}
end

return aj(t,u)end local r=function(


r)
return q(ae,r," - no custom aliases"," - invalid alias")end local s=function(


s)
return q(af,ag.normalizeName(s)or s," - no plugins installed"," - invalid plugin")end


local t={
string=d,
text=d,
object=c,
boolean=f,
number=g,
vector3=h,
color3=i,
player=j,
waypoint=m,
className=l,
team=n,
keycode=o,
command=p,
alias=r,
plugin=s,
}

ai.validate=function(u, v, w)
local x=t[v.kind]

if not x then
return aj(` - missing parser {v.kind}`)
end

return x(w,v)end


return ai end a.c5=function()local ab=a.cache.c5 if not ab then ab={c=aa()}a.cache.c5=ab end return ab.c end end do local aa=function()

local aa=a.c1()
local ab=a.cE()

local ac=a.cD()
local ad=a.cY()

local ae=a.cR()
local af=a.c5()

local ag=ae.colorFromRGB
local ah=ae.escapeRichText


local ai="\\"

local aj="^"
local ak="inf"

local b="!"

local c=ae.lookupify({"`","'","\""})
local d=ae.lookupify({" ","\t","\n","\r"})
local e=ae.lookupify({",","|","&"})local f=function(

f)
return ac.lookup[f]end local g=function(


g, h, i)
local j=ad.args
return ag(g,j[h]or i or j.others)end local h=function(


h)
local i=h:gsub(".",function(i)
return d[i]and"_"or i
end)
return i end local i=function(


i, j)
if i.name then
return`'{h(i.name)}'`
end
return`#{j}`end local j=function(



j, k, l)
local m=l+1

while true do
local n=j:find(k,m,true)

if not n then
return nil
end

if j:sub(n-1,n-1)~="\\"then
return n
end

m=n+1
end end local k=function(




k, l)
local m={}
local n=l
local o=#k

while n<=o do
local p=k:sub(n,n)

if d[p]or p==ai then
break
end

table.insert(m,p)
n=n+1

if e[p]then
while n<=o and d[k:sub(n,n)]do
n=n+1
end
end
end

return table.concat(m),n-1 end local l=function(


l, m, n, o, p, q)
return{
kind=l,
value=m,
usedChar=q,
from=o,
to=p,
raw=n:sub(o,p),
}end local m=function(



m, n)
if n==""then
return"","",m
end

local o,p=m:lower():find(n:lower(),1,true)

if not o then
return"","",m
end

return m:sub(1,o-1),m:sub(o,p),m:sub(p+1)end local n=function(


n, o)
if o then
return o..n..o
end

if n:find("%s")then
return`"{n}"`
end

return n end local o=function(



o, p)
if p then
return ah(p)..o..ah(p)
end

return o end local p=function(


p, q, r, s)
return{
from=p,
to=q,
text=n(r,s),
}end local q=function(




q)
local r=q:split(aj)

if#r>2 then
return nil," - invalid loop"
end

local s
if r[1]:lower()==ak then
s=math.huge
else
s=tonumber(r[1])

if s==nil or s<1 or s~=math.floor(s)then
return nil," - invalid loop count"
end
end

local t=0
if r[2]~=nil then
t=tonumber(r[2])

if t==nil or t<0 then
return nil," - invalid loop delay"
end
end

return{count=s,delay=t}end


local r={}
r.__index=r
r.colorFromName=g
r.removeWhiteSpace=h



r.parse=function(s, t)
local u=s.cmdInput
local v={}
local w={}
local x=#t
local y={tokens={},start=1}
local z=1

table.insert(v,y)

while z<=x do
local A=t:sub(z,z)

if d[A]then
z=z+1
elseif A==ai then
y.stop=z
y={tokens={},start=z+1}
table.insert(v,y)
z=z+1
else
local B
local C=c[A]and j(t,A,z)

if C then
local D=(t:sub(z+1,C-1):gsub("\\"..A,A))
B=l("string",D,t,z,C,A)
z=C+1
else
local D,E=k(t,z)
B=l("identifier",D,t,z,E)
z=E+1
end

table.insert(y.tokens,B)
table.insert(w,B)
end
end

y.stop=x+1

for A,B in v do
local C=B.tokens[1]
local D=B.tokens[#B.tokens]
local E=if D then D.to+1 else B.start

B.lead=if C then t:sub(B.start,C.from-1)else""
B.spaces=t:sub(E,B.stop-1)
end

local A={}
for B,C in w do
table.insert(A,C.value)
end

local B=v[#v]

u.rawText=t
u.parsed=w
u.spacesAtEnd=B.spaces
u.noHighlightText=table.concat(A," ")..B.spaces

return v end



r.parseArg=function(s, t, u, v, w)
local x=u.value
local y=af:validate(t,x)
local z=y.success and#x>0

local A={success=z,text=x}
if z then
A.value=y.value
end
w.args[v]=A

if z then

local B=if y.display then o(y.display,u.usedChar)else ah(u.raw)
return{success=true,display=g(B,y.color or"valid")}
end

local B=af.getOptions(t,y)
local C

if#x>0 then
C=ab:searchAtArray(B,x)[1]
end

if C then
local D,E,F=m(C,x)
w.correction=p(u.from,u.to,C,u.usedChar)

local G=ah(D)..g(ah(E),"warn")..ah(F)
return{
success=false,
suggestion=true,
display=g(o(G,u.usedChar),"comment"),
}
end

return{
success=false,
display=g(ah(u.raw),y.color or"warn"),
message=y.message,
comment=y.comment,
}end



r.parsePending=function(s, t, u, v)
local w=af:validate(t,"")
local x=af.getOptions(t,w)

if#x==0 then
return nil
end

local y=x[1]


if not t.optional then
u.correction={from=v.stop,to=v.stop-1,text=n(y)}
else
u.hasGhost=true
end

return g(ah(y),"comment")end



r.highlightArgs=function(s, t, u, v, w, x, y)
local z=v.tokens
local A=u.args
local B=#z-1
local C=A[#A]
if C and C.variadic then
A=table.clone(A)
local D=B+(if w then 1 else 0)
while#A<D do
table.insert(A,C)
end
end
local D=#A

local E=1
local F

for G,H in A do
local I=z[G+1]

if I==nil then
if w then
local J=s:parsePending(H,t,v)
if J then
table.insert(x,J)
end
end
break
end

local J=s:parseArg(H,I,G,t)
E=G+1

if J.display then
table.insert(x,J.display)
end

if not J.success then
F={index=G,result=J}
break
end
end


for G=E+1,math.min(#z,D+1)do
table.insert(x,ah(z[G].raw))
end

if#z>D+1 then
local G=s.cmdInput.rawText:sub(z[D+2].from,z[#z].to)
table.insert(x,g(`<b>{ah(G)}</b>`,"warn"))

t.runError=" - extra arg"
t.comment={text=" - extra arg",color="warn"}
return
end

if F then
local G=F.result


t.runError=` - {i(A[F.index],F.index)} is invalid`

if G.message and not G.suggestion then
t.comment={text=G.message,color=if G.comment then"comment"else"warn"}
end
return
end


for G=B+1,D do
local H=A[G]

if not H.optional then
t.runError=` - {i(H,G)} is missing`
break
end
end

local G

if w then
G=B+1
elseif B>0 then
G=B
end

local H=G and A[G]


if H and y then
local I=if w then""else": "
t.comment={text=`{I}({s:highlightArgType(H)})`}
end end


r.highlightArgType=function(s, t)
local u=t.optional and g("?","symbol")or""
local v=`{g(t.kind,t.kind)}{u}`

if t.name then
return`{h(t.name)}: {v}`
end

return v end


r.highlightArgsType=function(s, t)
if#t==0 then return""end

local u={}

for v,w in t do
table.insert(u,s:highlightArgType(w))
end

return`({table.concat(u,", ")})`end


r.resetInput=function(s)
local t=s.cmdInput

t.highlightText=""
t.commandName=""
t.commandData=nil
t.isValidCommand=false
t.isAbreviated=false
t.bestMatch=nil
t.bestMatches={}
t.correctionText=nil
t.correction=nil
t.runError=nil
t.hasGhost=false
t.args={}
t.statements={}

s:setComment("")end



r.highlightStatement=function(s, t, u)
local v=s.cmdInput
local w=t.tokens
local x={
lead=t.lead,
text="",
trailing=t.spaces,
args={},
commandName="",
bestMatches={},
isValidCommand=false,
isAbreviated=false,
}

if#w==0 then
x.empty=true
return x
end

local y=w[1]
local z=#t.spaces>0
local A=y.value
local B=A
local C
local D
local E=false


if y.kind=="identifier"then
local F,G=A:match("^(.*%^)(.*)$")

if F then
C,D=q(F:sub(1,-2))
B=G
end

if B:sub(1,1)==b then
E=true
B=B:sub(2)
end
end

local F=A:sub(1,#A-#B)
local G=B:lower()
local H=f(G)

x.commandName=G
x.commandData=H
x.isValidCommand=H~=nil
x.isAbreviated=H~=nil and H.name~=G
x.loop=C

if D then
x.text=g(ah(A),"error")
x.runError=D
x.comment={text=D,color="error"}
return x
end

local I=""
if F~=""then
I=g(ah(F),"comment")
end

if not H then
local J=aa:search(G)
local K=J[1]

x.bestMatches=J
x.bestMatch=K

if z or#w>1 or not K then
local L=v.rawText:sub(y.from,w[#w].to)

x.text=g(ah(L),"error")
x.runError=" - invalid command"
x.comment={text=" - invalid command",color="error"}
return x
end


local L,M,N=m(K,B)

x.text=I..g(ah(L)..g(ah(M),"warn")..ah(N),"comment")
x.correction=p(y.from,y.to,F..K,y.usedChar)
x.correctionText=K
x.runError=" - invalid command"
return x
end

local J={I..g(ah(B),"valid")}


if u and#w==1 and not z and#H.aliases>1 then
local K=table.clone(H.aliases)
local L=table.find(K,G)

if L then
table.remove(K,L)
end

x.comment={text=`: [{table.concat(K,", ")}]`,color="comment"}
end

if E and#w==1 then

x.repeatLast=true

if#H.args>0 and aa:getLastArgs(H.name)==nil then
x.runError=" - no previous arguments"
x.comment={text=" - no previous arguments",color="error"}
end
else
s:highlightArgs(x,H,t,z,J,u)
end

x.text=table.concat(J," ")
return x end




r.highlight=function(s, t)
local u=s.cmdInput
s:resetInput()

local v=#t
local w={}

for x,y in t do
w[x]=s:highlightStatement(y,x==v)
end

local x=w[v]

u.statements=w
u.commandName=x.commandName
u.commandData=x.commandData
u.isValidCommand=x.isValidCommand
u.isAbreviated=x.isAbreviated
u.bestMatch=x.bestMatch
u.bestMatches=x.bestMatches
u.args=x.args


local y

for z,A in w do

if A.empty and v>1 then
A.runError=" - command missing"
end

if A.runError and u.runError==nil then
u.runError=A.runError
end

if A.correction and u.correction==nil then
u.correction=A.correction
end

if A.hasGhost then
u.hasGhost=true
end

if A.comment and y==nil then
y=A.comment
end
end

if y then
s:setComment(y.text,y.color)
end

local z={}

for A,B in w do

local C=if B.correction or B.hasGhost then""else B.trailing
local D=B.lead..B.text..C

if A<v then
D=D..g(ah(ai),"symbol")
end

table.insert(z,D)
end

local A=table.concat(z)
u.highlightText=A

return A end


r.setComment=function(s, ...)
return s.setCommentCallback(...)end


r.new=function(s, t)
return setmetatable({
cmdInput=s,
setCommentCallback=t
},r)end


return r end a.c6=function()local ab=a.cache.c6 if not ab then ab={c=aa()}a.cache.c6=ab end return ab.c end end do local aa=function()






local aa=a.c1()
local ab=a.c6()
local ac=a.W()
local ad=a.c0()
local ae=a.d()

local af={}


af.runStatement=function(ag)
local ah=ag.commandData.name
local ai=ag.args

if ag.repeatLast then
ai=aa:getLastArgs(ah)or{}
end

if ag.loop then
af.startLoop(ah,ai,ag.loop)
return
end

aa:run(ah,ac.new(ai))end



af.startLoop=function(ag, ah, ai)
local aj=0
local ak

ak=ad:add(function()
aj=aj+1

local b,c=pcall(function()
aa:run(ag,ac.new(ah))
end)

if not b then
ad:remove(ak)
ae:error(`loop of '{ag}' stopped: {c}`)
return
end

if aj>=ai.count then
ad:remove(ak)
end
end,ai.delay)end local ag=function(




ag)
local ah={}
local ai=ab.new(ah,function()end)

ai:highlight(ai:parse(ag))

return ah.statements,ah.runError end local ah=function(



ah)
for ai,aj in ah do
if aj.empty then
return"write the command to run"
end

if not aj.commandData then
return`'{aj.commandName}' is not a command`
end
end

return nil end




af.checkText=function(ai)
local aj=ag(ai)
local ak=ah(aj)

if ak then
return false,ak
end

return true end




af.runText=function(ai)
local aj,ak=ag(ai)
local b=ah(aj)

if b then
return false,b
end

if ak then

return false,(ak:gsub("^%s*%-%s*",""))
end

for c,d in aj do
local e,f=pcall(af.runStatement,d)

if not e then
return false,tostring(f)
end
end

return true end


return af end a.c7=function()local ab=a.cache.c7 if not ab then ab={c=aa()}a.cache.c7=ab end return ab.c end end do local aa=function()








local aa=a.c4()
local ab=a.r()
local ac=a.c7()
local ad=a.c1()
local ae=a.ag()

local af=aa.ANY

local ag={}


ag.events=aa.events

local ah={}
for ai,aj in aa.events do
ah[aj.name]=aj
end local ai=function(

ai)
return ai:match("^%s*(.-)%s*$")or""end



ag.getEvent=function(aj)
return ah[aj]end



ag.getBinds=function(aj)
local ak=ab.object[aj]

if type(ak)~="table"then
return{}
end

return table.clone(ak)end local aj=function(




aj, ak)
local b=ai(ak or"")

if b==""then
b=aj.default
end

if b:lower()==af then
return af
end

if aj.kind=="Number"and tonumber(b)==nil then
return nil,`{aj.label} must be a number or any`
end

return b end




ag.add=function(ak, b, c, d)
local e=ah[ak]
if not e then
return false,"invalid event"
end

local f=ai(b)
local g,h=ac.checkText(f)

if not g then
return false,h
end

if type(c)~="number"or c<0 then
return false,"the delay must be 0 or more"
end

local i={}

for j,k in e.conditions do
local l,m=aj(k,d and d[j])

if not l then
return false,m
end

i[j]=l
end

local j=ab.object[ak]
if type(j)~="table"then
j={}
ab.object[ak]=j
end

table.insert(j,{command=f,delay=c,conditions=i})
ab:save()

return true end



ag.remove=function(ak, b)
local c=ab.object[ak]

if type(c)~="table"or c[b]==nil then
return nil
end

local d=table.remove(c,b)
ab:save()

return d end




ag.restore=function(ak, b, c)
if not ah[ak]or type(c)~="table"then
return false
end

local d=ab.object[ak]
if type(d)~="table"then
d={}
ab.object[ak]=d
end

table.insert(d,math.clamp(b,1,#d+1),c)
ab:save()

return true end



ag.setDelay=function(ak, b, c)
local d=ab.object[ak]

if type(d)~="table"or type(d[b])~="table"then
return false
end

if type(c)~="number"or c<0 then
return false
end

d[b].delay=c
ab:save()

return true end local ak=function(



ak, b)
local c,d=pcall(ae,ak)

if not c then
return false
end

for e,f in d do
if f.Name==b then
return true
end
end

return false end local b=function(



b, c, d)
if c:lower()==af then
return true
end

if b.kind=="Player"then
return ak(c,tostring(d))
end

if b.kind=="String"then
return tostring(d):lower():find(c:lower(),1,true)~=nil
end

if b.kind=="Number"then
local e,f=tonumber(c),tonumber(d)
return e~=nil and f~=nil and f<=e
end

return false end local c=function(



c, d, e)
local f=d.conditions or{}

for g,h in c.conditions do
local i=tostring(f[g]or h.default)

if not b(h,i,e[g])then
return false
end
end

return true end local d=function(




d)
if d:match("^[%w_%-%.]+$")then
return d
end

return'"'..(d:gsub('"','\\"'))..'"'end local e=function(



e, f)
return(e:gsub("%$(%d+)",function(g)
local h=f[tonumber(g)]

if h==nil then
return nil
end

return d(tostring(h))
end))end local f=function(




f, g)
local h=f.delay or 0

if h>0 then
task.wait(h)
end

local i=e(f.command,g)
local j,k=ac.runText(i)

if not j then
ad:notify("Event Bind",`'{i}' did not run: {k}`)
end end




ag.fire=function(g, ...)
local h=ah[g]
local i=ab.object[g]

if not h or type(i)~="table"then
return
end

local j={...}

for k,l in table.clone(i)do
if type(l)=="table"and c(h,l,j)then
task.spawn(f,l,j)
end
end end


return ag end a.c8=function()local ab=a.cache.c8 if not ab then ab={c=aa()}a.cache.c8=ab end return ab.c end end do local aa=function()








local aa=a.f()
local ab=a.aE()
local ac=a.c8()

local ad=aa.Players
local ae=aa.TextChatService

local af={}

local ag=false
local ah=false


local ai={}

local aj={}local ak=function(


ak, b, c, d)
local e=ab:Connect(c,d)

local f=ak[b]or{}
ak[b]=f
table.insert(f,e)end local b=function(


b, c)
local d=b[c]
b[c]=nil

for e,f in d or{}do
ab:disconnect(f)
end end local c=function(



c, d)
b(aj,c)

task.spawn(function()
local e=d:WaitForChild("Humanoid",10)


if not e or not e:IsA("Humanoid")or c.Character~=d then
return
end

local f=e.Health

ak(aj,c,e.HealthChanged,function(g)
if g<f then
ac.fire("OnDamage",c.Name,g)
end

f=g
end)

ak(aj,c,e.Died,function()
ac.fire("OnDied",c.Name)


local g=e:FindFirstChild("creator")
local h=if g and g:IsA("ObjectValue")then g.Value else nil

if h and h:IsA("Player")then
ac.fire("OnKilled",c.Name,h.Name)
end
end)
end)end local d=function(




d)
ak(ai,d,d.CharacterAdded,function(e)
ac.fire("OnSpawn",d.Name)
c(d,e)
end)

if ah then
ak(ai,d,d.Chatted,function(e)
ac.fire("OnChatted",d.Name,e)
end)
end

if d.Character then
c(d,d.Character)
end end local e=function(


e)
local f=e.TextSource

if not f or e.Status==Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
return
end

local g=ad:GetPlayerByUserId(f.UserId)

if g then
ac.fire("OnChatted",g.Name,e.Text)
end end local f=function(


f)
ac.fire("OnLeave",f.Name)

b(ai,f)
b(aj,f)end



af.start=function()
if ag then
return
end

ag=true
ah=ae.ChatVersion==Enum.ChatVersion.LegacyChatService

ab:Connect(ad.PlayerAdded,function(g)
ac.fire("OnJoin",g.Name)
d(g)
end)

ab:Connect(ad.PlayerRemoving,f)

if not ah then
ab:Connect(ae.MessageReceived,e)
end


for g,h in ad:GetPlayers()do
d(h)
end

ac.fire("OnExecute")end


return af end a.c9=function()local ab=a.cache.c9 if not ab then ab={c=aa()}a.cache.c9=ab end return ab.c end end do local aa=function()



return{

keys={
url="background.url",
file="background.file",
opacity="background.opacity",
},


folder="background",


extensions={
png="png",
jpg="jpg",
jpeg="jpg",
},
defaultExtension="png",

defaultOpacity=0.5,


slowSeconds=10,
}end a.da=function()local ab=a.cache.da if not ab then ab={c=aa()}a.cache.da=ab end return ab.c end end do local aa=function()


















local aa=a.c2()

return{

keys={
keepMenuOpen="interface.keepMenuOpen",
keepIY=aa.settingKey,
clearOnEnter="clearOnEnter",
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
floatBackFlat=0.3,
floatBackOut=0.5,
floatBackTime=0.35,
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
userWidth=150,
},


badge={
height=12,
overhang=3,
},


slider={
width=90,
valueWidth=36,
barHeight=4,
hitHeight=20,
knobSize=12,
},


userData={
missing="-",
dateFormat="%Y-%m-%d %H:%M:%S",
},

textSizes={
header=12,
label=14,
value=12,
footer=11,
badge=10,
},


footer="{name} {version}",


pages={
back="Back",
backIcon="lucide-chevron-left",

theme={
title="#theme",
incomplete="(incomplete)",
primary="primary",
},
background={
title="#background",
urlHint="image URL, like https://...",
apply="Set image from URL",
refresh="Refresh image",
remove="Remove image",
opacity="Opacity",

icons={
apply="lucide-palette",
refresh="lucide-refresh-cw",
remove="lucide-trash",
opacity="lucide-sliders-horizontal",
},
notifyTitle="Background",
downloading="downloading the image...",
set="background set",
refreshed="background refreshed",
removed="background removed",
removedKeptFile="background removed, but its file stays: your exploit can't delete files",
nothingToRefresh="there is no background to refresh",
nothingToRemove="there is no background to remove",
alreadyDownloading="this image is already being downloaded",
downloadReplaced="the previous download was cancelled, downloading the new image...",
slow="the image is taking a long time to download...",
empty="write the URL of an image first",
badUrl="the URL must start with http:// or https://",
noCustomAsset="your exploit does not support getcustomasset, so the background can't be shown",
downloadFailed="could not download an image from that URL",
loadFailed="the image was downloaded, but it could not be loaded",
},
keybinds={
title="#keybinds",
reset="Reset to defaults",
alwaysWorks="%s also works as the %s",
},
commands={
title="#command settings",
reset="Reset command keys to defaults",
},
importExport={
title="#import / export",
exportTitle="#export",
exportRow="Copy settings",
exportHint="copies your settings, keybinds, aliases, event binds and waypoints as text",
importTitle="#import",
importRow="Import settings",
importHint="paste a copied text in the box, then import it. It replaces the settings it holds",
placeholder="paste the copied text here",
copied="settings copied to the clipboard",
copyFailed="your exploit can't copy: the text is in the box, copy it from there",
empty="paste a copied text first",
notAnExport="that text is not an export of IY",
imported="imported %s",
restartNote="aliases and plugins apply when IY is opened again",
notifyTitle="Import / Export",
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
folderHint="plugins are %s files in the %s folder",
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
{kind="switch",label="Clear On Enter",icon="lucide-eraser",setting="clearOnEnter"},
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
{kind="button",label="Command Settings",icon="lucide-sliders-horizontal",action="commands"},
{kind="button",label="Import / Export",icon="lucide-arrow-down-up",action="importExport"},
},
},
{
title="#user",
options={
{
kind="expand",
label="Usage",
icon="lucide-terminal",
items={
{label="First run",key="firstTimeExecuted",date=true},
{label="This place",placeCounts="usedPlaces"},
{label="Total",key="executionCount"},
},
},
},
},
},
}end a.db=function()local ab=a.cache.db if not ab then ab={c=aa()}a.cache.db=ab end return ab.c end end do local aa=function()













local aa=a.a()
local ab=a.cG()
local ac=a.n()
local ad=a.s()
local ae=a.k()

local af=a.da()
local ag=a.db().pages.background

local ah={
frame=nil,
topBar=nil,
asset=nil,
}


local ai=0



local aj local ak=function(

ak)
return ak:match("^%s*(.-)%s*$")or""end local b=function(



b)
local c=b:match("^[^?#]*")or b
local d=(c:match("%.(%w+)$")or""):lower()

return af.extensions[d]or af.defaultExtension end local c=function()



local c=ac:getValue(af.keys.opacity)

if type(c)~="number"then
return af.defaultOpacity
end

return math.clamp(c,0,1)end local d=function(



d)
local e=ad:getEntry(d)

if type(e)=="string"and ae:exist(e)then
return e
end

return nil end local e=function(




e)
local f=ac:getValue(af.keys.file)

if f==nil then
return nil
end

ac:setValue(af.keys.file,nil)
ac:save()

if type(f)~="string"or not ae:exist(f)then
return nil
end

ad:setEntry(e,f)
ad:save()

return f end local f=function(




f, g)
local h=ab.fetchUrl(f)

if not g()then
return nil,nil,nil
end

if h==nil then
return nil,nil,ag.downloadFailed
end


ai=ai+1
local i=`{af.folder}/image-{os.time()}-{ai}.{b(f)}`

ae:makeFolder(af.folder)
ae:writeFile(i,h)

local j=ae:getCustomAsset(i)

if j==nil then

ae:delete(i)
return nil,nil,ag.loadFailed
end

return i,j,nil end



ah.getUrl=function(g)
local h=ac:getValue(af.keys.url)

if type(h)=="string"and h~=""then
return h
end

return nil end


ah.getOpacity=function(g)
return c()end



ah.checkUrl=function(g, h)
local i=ak(h)

if i==""then
return ag.empty
end

if not i:match("^https?://")then
return ag.badUrl
end

if aa.getcustomasset==nil then
return ag.noCustomAsset
end

return nil end



ah.paint=function(g)
local h=g.frame
if h==nil then return end

local i=g.asset

h.Image=i or""
h.ImageTransparency=1-c()

if g.topBar then
g.topBar.BackgroundTransparency=if i~=nil then 1 else 0
end end



ah.attach=function(g, h)
if g.frame~=nil then return end

g.frame=h
g.topBar=h:FindFirstChild("TopBar")

local i=g:getUrl()

if i~=nil and aa.getcustomasset~=nil then
local j=d(i)or e(i)

if j~=nil then
g.asset=ae:getCustomAsset(j)
end
end

g:paint()end





ah.setFromUrl=function(g, h, i, j)
local k=ak(h)
local l=d(k)
local m=j or function()return true end

local n=l
local o

if l~=nil and not i then
o=ae:getCustomAsset(l)
end

if o==nil then
local p,q,r=f(k,m)

if p==nil or q==nil then
return false,r
end

n=p
o=q

if l~=nil and l~=p then
ae:delete(l)
end
end

ad:setEntry(k,n)
ad:save()

ac:setValue(af.keys.url,k)
ac:save()

g.asset=o
g:paint()

return true end




ah.clear=function(g)

g:cancelDownload()

local h=g:getUrl()
local i=true

if h~=nil then
local j=ad:getEntry(h)

if type(j)=="string"then
i=ae:delete(j)
end

ad:setEntry(h,nil)
ad:save()
end

ac:setValue(af.keys.url,nil)
ac:save()

g.asset=nil
g:paint()

return i end



ah.setOpacity=function(g, h)
local i=math.round(math.clamp(h,0,1)*100)/100

ac:setValue(af.keys.opacity,i)
ac:save()

g:paint()end



ah.isDownloading=function(g, h)
if aj==nil then return false end
if h==nil then return true end

return aj.url==ak(h)end




ah.cancelDownload=function(g)
local h=aj
if h==nil then return end

aj=nil

if h.thread~=nil then
pcall(task.cancel,h.thread)
end end





ah.startDownload=function(g, h, i, j)



g:cancelDownload()

local k={url=ak(h),thread=nil}
aj=k

task.delay(af.slowSeconds,function()
if aj==k and j.onSlow then
j.onSlow()
end
end)

k.thread=task.spawn(function()

local l,m,n=pcall(function()
return g:setFromUrl(k.url,i,function()
return aj==k
end)
end)

if not l then
m,n=false,ag.downloadFailed
end


if aj~=k then return end

aj=nil

if j.onDone then
j.onDone(m,n)
end
end)end


return ah end a.dc=function()local ab=a.cache.dc if not ab then ab={c=aa()}a.cache.dc=ab end return ab.c end end do local aa=function()

return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.dd=function()local ab=a.cache.dd if not ab then ab={c=aa()}a.cache.dd=ab end return ab.c end end do local aa=function()



local aa={}

local ab=a.az()
local ac=a.dd()

aa.getEasterDate=function()
local ad=tonumber(os.date("%Y"))

local ae=math.floor(ad/100)
local af=math.floor((13+8*ae)/25)
local ag=(15-af+ae-math.floor(ae/4))%30
local ah=(4+ae-math.floor(ae/4))%7

local ai=(19*(ad%19)+ag)%30
local aj=(2*(ad%4)+4*(ad%7)+6*ai+ah)%7
local ak=22+ai+aj

if ai==29 and aj==6 then
return"04 19"
elseif ai==28 and aj==6 then
return"04 18"
end

if ak>31 then
return string.format("04 %02d",ak-31)
end

return string.format("03 %02d",ak)end


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

local af=os.date("%m %d")
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


return aa end a.de=function()local ab=a.cache.de if not ab then ab={c=aa()}a.cache.de=ab end return ab.c end end do local aa=function()









local aa={}








aa.compute=function(ab, ac, ad, ae)

local af=ab.x.scale*ac.width+ab.x.offset
local ag=af+ab.width

local ah=ac.width-ag-ae
local ai=af-ae

local aj
if ah>=ad.width then
aj=true
elseif ai>=ad.width then
aj=false
else
aj=ah>=ai
end

local ak
if aj then
ak={scale=ab.x.scale,offset=ab.x.offset+ab.width+ae}
else
ak={scale=ab.x.scale,offset=ab.x.offset-ae}
end


local b=ab.y.scale*ac.height+ab.y.offset
local c=b+ab.height



local d=(math.max(b,0)+math.min(c,ac.height))/2
local e=d>ac.height/2

local f,g,h
if e then

if c>=ac.height then
f={scale=1,offset=0}
else
f={scale=ab.y.scale,offset=ab.y.offset+ab.height}
end
g=1
h=math.min(c,ac.height)
else
if b<0 then
f={scale=0,offset=0}
else
f={scale=ab.y.scale,offset=ab.y.offset}
end
g=0
h=ac.height-math.max(b,0)
end

return{
x=ak,
y=f,
anchorX=if aj then 0 else 1,
anchorY=g,
room=math.max(h,0),
}end


return aa end a.df=function()local ab=a.cache.df if not ab then ab={c=aa()}a.cache.df=ab end return ab.c end end do local aa=function()



local aa=a.cT()

local ab={}

ab.create=function(ac)
local ad=aa.new("ImageLabel","MainFrame",{
Active=true,
BorderSizePixel=0,
Image="",
ScaleType=Enum.ScaleType.Crop,
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

local ah=aa.new("ImageButton",ae,{
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
reference=ah
}
}end


return ab end a.dg=function()local ab=a.cache.dg if not ab then ab={c=aa()}a.cache.dg=ab end return ab.c end end do local aa=function()

local aa=a.cT()

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

for ah=1,ac do
local ai,aj=af(ac,ah)

aa.new("Frame",`line_{ah}`,{
BackgroundColor3=Color3.fromRGB(220,220,220),
BorderSizePixel=0,
Size=ai,
Position=aj,
Parent=ag,
ThemeTag={
BackgroundColor3="Colors.Icons"
}
})
end

return ag
end end a.dh=function()local ab=a.cache.dh if not ab then ab={c=aa()}a.cache.dh=ab end return ab.c end end do local aa=function()



local aa=a.aE()
local ab=a.f()

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
local ah

ah=aa:Connect(ac.InputEnded,function(ai)
if af.isPressingInput(ai)then
ah:Disconnect()
ag(ai)
end
end)

return ah end


af.onMouseEvent=function(ag)
local ah

ah=aa:Connect(ac.InputChanged,function(ai)
if af.isMovingInput(ai)then
ag(ai)
end
end)

return ah end


af.isPressingInput=function(ag)
return ad[ag.UserInputType]~=nil end


af.isMovingInput=function(ag)
return ae[ag.UserInputType]~=nil end


return af end a.di=function()local ab=a.cache.di if not ab then ab={c=aa()}a.cache.di=ab end return ab.c end end do local aa=function()
local aa=a.aE()
local ab=a.cT()
local ac=a.af()
local ad=a.cS()

local ae=a.dh()
local af=a.cW()

local ag=a.v()

local ah=a.di()

local ai={}
ai.__index=ai

ai.awake=function(aj)
local ak=ac:getMouse()

local b=aj.scrollThumbFrame
local c=aj.scrollThumb
local d=aj.scrollBar

local e=false
local f=false
local g local h=function(

h, i)local j=function()

if e then return end
if not aj:canScroll(i)then return end

e=true

aj:scrollToDirection(i)

ah.onReleaseEvent(function()
e=false
end)

task.wait(0.4)

while aj:canScroll(i)and e do
aj:scrollToDirection(i)
task.wait(6.666666666666666E-2)
end end


aa:Connect(h.MouseButton1Down,j)end




h(aj.upButton,"up")
h(aj.downButton,"down")local i=function(



i)
if aj.locked then return end
aj:scrollTo(aj.index+i*aj.wheelIncrement)end


for j,k in{d,aj.container}do
aa:Connect(k.MouseWheelForward,function()
i(-1)
end)

aa:Connect(k.MouseWheelBackward,function()
i(1)
end)
end

aa:Connect(d.InputBegan,function(j)
if not ah.isPressingInput(j)then return end
if aj:isScrollBarDisabled()then return end

local k=not ac:isMouseInGuiObject(c)
local l=aj.isHorizontal and"X"or"Y"

local m
f=true

ad:updateObjectProperties(c,{
BackgroundColor3="Colors.Primary"
})

local n=ak[l]-c.AbsolutePosition[l]
local o local p=function()


if o then o:Disconnect()end end


ah.onReleaseEvent(function()
p()
f=false

ad:updateObjectProperties(c,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if k then local q=function()

if aj.locked then return end

local q=(ak[l]>=c.AbsolutePosition[l]+c.AbsoluteSize[l])and 1 or 0
local r=aj.visibleSpace-1

if q==0 and(
ak[l]<c.AbsolutePosition[l]
)then
aj:scrollTo(aj.index-r)
elseif q==1 and(
ak[l]>=c.AbsolutePosition[l]+c.AbsoluteSize[l]
)then
aj:scrollTo(aj.index+r)
end end


while f do
q()
task.wait(0.25)
end
return
end

o=ah.onMouseEvent(function(q)
if not f then return end
if aj.locked then return end

local r=b.AbsoluteSize[l]-c.AbsoluteSize[l]
local s=ak[l]-b.AbsolutePosition[l]-n

if s>r then
s=r
elseif s<0 then
s=0
end

if m~=s then
m=s
aj:scrollTo(math.floor(0.5+s/r*(aj.totalSpace-aj.visibleSpace)))
end
end)
end)end


ai.create=function(aj)
aj.upButton=ab.new("ImageButton",aj.upButtonName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

aj.downButton=ab.new("ImageButton",aj.downButtoName,{
BackgroundTransparency=1,
AutoButtonColor=false
})

aj:createButtonsArrows()

local ak=ab.new("Frame","ScrollBar",{
Active=true,
BackgroundTransparency=1,

aj.upButton,
aj.downButton,

ab.new("Frame","ScrollThumbFrame",{
BackgroundTransparency=1,
AnchorPoint=aj.isHorizontal
and Vector2.new(0.5,0)
or Vector2.new(0,0.5),
Position=aj.isHorizontal
and UDim2.fromScale(0.5,0)
or UDim2.fromScale(0,0.5),

ab.new("Frame","ScrollThumb",{
AnchorPoint=aj.isHorizontal
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

aj.scrollBar=ak
aj.scrollThumbFrame=ak.ScrollThumbFrame
aj.scrollThumb=ak.ScrollThumbFrame.ScrollThumb
aj.markerFrame=ak.ScrollThumbFrame.MarkerFrame

aj.container=ab.new("Frame","Container",{
BackgroundTransparency=1,
ClipsDescendants=true,
Active=true
})

aj:setScrollBarThickness(aj.barThickness)
aj:awake()
aj:update()


return ak end


ai.createButtonsArrows=function(aj)
local ak=aj.downButton
local b=aj.upButton

ae(4,0.55,ak.Name).Parent=ak
ae(4,0.55,b.Name).Parent=b end


ai.canScrollUp=function(aj)
return aj:isScrollBarEnabled()and aj.index>0 end


ai.canScrollDown=function(aj)
local ak=aj:isScrollBarEnabled()
return ak and aj.index+aj.visibleSpace<aj.totalSpace end


ai.canScroll=function(aj, ak)
if aj.locked then return false end

if ak=="up"or ak=="left"then
return aj:canScrollUp()
elseif ak=="down"or ak=="right"then
return aj:canScrollDown()
end
return false end


ai.getScrollPercent=function(aj)
local ak=aj.totalSpace-aj.visibleSpace
if ak<=0 then return 0 end
return aj.index/ak end


ai.scrollTo=function(aj, ak, b)
local c=math.max(0,aj.totalSpace-aj.visibleSpace)

aj.index=math.clamp(ak,0,c)
aj:update()

if not b then
aj.scrolledSignal:Fire(aj.index)
end end


ai.scrollUp=function(aj)
aj:scrollTo(aj.index-aj.increment)end


ai.scrollDown=function(aj)
aj:scrollTo(aj.index+aj.increment)end


ai.scrollToDirection=function(aj, ak)
if ak=="up"or ak=="left"then
return aj:scrollUp()
elseif ak=="down"or ak=="right"then
return aj:scrollDown()
end end


ai.isVisible=function(aj, ak)
local b=aj.index
if ak>=b and ak<(b+aj.visibleSpace)then
return true
end
return false end


ai.setScrollPercent=function(aj, ak)
local b=aj.totalSpace-aj.visibleSpace
aj:scrollTo(math.floor(ak*b))end


ai.update=function(aj)
aj:drawThumb()end


ai.setScrollBarThickness=function(aj, ak)
local b=aj.scrollThumbFrame
local c=aj.downButton
local d=aj.container
local e=aj.scrollBar
local f=aj.upButton

aj.barThickness=ak

if d then
d.Size=UDim2.new(
1,
aj.isHorizontal and 0 or-ak,
1,
aj.isHorizontal and-ak or 0
)
end

if e then
e.Size=aj.isHorizontal
and UDim2.new(1,0,0,ak)
or UDim2.new(0,ak,1,0)
e.Position=aj.isHorizontal
and UDim2.new(0,0,1,-ak)
or UDim2.new(1,-ak,0,0)
end

if b then
b.Size=aj.isHorizontal
and UDim2.new(1,-(ak*2),0,ak)
or UDim2.new(0,ak,1,-(ak*2))
end

if c then
c.Size=UDim2.fromOffset(ak,ak)
c.Position=aj.isHorizontal
and UDim2.new(1,-ak,0,0)
or UDim2.new(0,0,1,-ak)
end

if f then
f.Size=UDim2.fromOffset(ak,ak)
f.Position=UDim2.fromOffset(0,0)
end end


ai.updateArrowTransparency=function(aj, ak, b)
if not ak:FindFirstChild("Arrow")then return end

for c,d in ak.Arrow:GetChildren()do
if not d:IsA("GuiObject")then continue end
d.Transparency=b and 0.6 or 0
end end


ai.drawThumb=function(aj)
local ak=aj.scrollThumb
local b=aj.scrollThumbFrame

local c=aj:canScrollUp()
local d=aj:canScrollDown()

aj:updateArrowTransparency(aj.upButton,not c)
aj:updateArrowTransparency(aj.downButton,not d)

if not ak or not b then return end

if not c and not d then
ak.Visible=false
return
end

ak.Visible=true

local e=aj:getScrollPercent()
local f=af:getScale()
local g=aj.barThickness

if aj.isHorizontal then
local h=b.AbsoluteSize.X/f
local i=math.max(g,(aj.visibleSpace/aj.totalSpace)*h)
ak.Size=UDim2.new(0,i,1,-2)
ak.Position=UDim2.new(0,e*(h-i),0.5,0)
else
local h=b.AbsoluteSize.Y/f
local i=math.max(g,(aj.visibleSpace/aj.totalSpace)*h)
ak.Size=UDim2.new(1,-2,0,i)
ak.Position=UDim2.new(0.5,0,0,e*(h-i))
end end


ai.addMarker=function(aj, ak, b)
aj.markers[ak]=b or Color3.new(1,1,0)
aj:updateMarkers()end


ai.removeMarker=function(aj, ak)
aj.markers[ak]=nil
aj:updateMarkers()end


ai.updateMarkers=function(aj)
local ak=aj.markerFrame
if not ak then return end

for b,c in pairs(ak:GetChildren())do
c:Destroy()
end

for b,c in pairs(aj.markers)do
if b>=aj.totalSpace then continue end

local d=Instance.new("Frame")
d.BackgroundColor3=c
d.BorderSizePixel=0
d.BackgroundTransparency=0
d.Parent=ak

local e=b/aj.totalSpace
if aj.isHorizontal then
d.Position=UDim2.new(e,0,1,-4)
d.Size=UDim2.new(0,2,0,4)
else
d.Position=UDim2.new(1,-4,e,0)
d.Size=UDim2.new(0,4,0,2)
end

d.Name="Marker_"..tostring(b)
end end


ai.setTotalSpace=function(aj, ak)
aj.totalSpace=ak
aj:scrollTo(aj.index,true)
aj:update()end


ai.setVisibleSpace=function(aj, ak)
aj.visibleSpace=ak
aj:scrollTo(aj.index,true)
aj:update()end


ai.disableScroll=function(aj)
aj.scrollBarEnabled=false
aj:drawThumb()end


ai.enableScroll=function(aj)
aj.scrollBarEnabled=true
aj:drawThumb()end


ai.isScrollBarEnabled=function(aj)
return aj.scrollBarEnabled end


ai.isScrollBarDisabled=function(aj)
return not aj.scrollBarEnabled or aj.locked end






ai.setLocked=function(aj, ak)
aj.locked=ak==true end


ai.isLocked=function(aj)
return aj.locked end


ai.new=function(aj)
local ak=setmetatable({
isHorizontal=aj.isHorizontal or false,
increment=aj.increment or 1,
wheelIncrement=aj.wheelIncrement or 3,
barThickness=aj.barThickness or 16,

scrollBarEnabled=true,
locked=false,

index=0,
visibleSpace=aj.visibleSpace or 0,
totalSpace=aj.totalSpace or 0,

markers={},

scrollBar=aj.scrollBar or nil,
scrollThumb=aj.scrollThumb or nil,
scrollThumbFrame=aj.scrollThumbFrame or nil,
markerFrame=aj.markerFrame or nil,

scrolledSignal=ag.new(),
},ai)

ak.upButtonName=ak.isHorizontal and"left"or"up"
ak.downButtoName=ak.isHorizontal and"right"or"down"

return ak end


return ai end a.dj=function()local ab=a.cache.dj if not ab then ab={c=aa()}a.cache.dj=ab end return ab.c end end do local aa=function()
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


return aa end a.dk=function()local ab=a.cache.dk if not ab then ab={c=aa()}a.cache.dk=ab end return ab.c end end do local aa=function()
local aa=a.aE()
local ab=a.f()
local ac=a.af()
local ad=a.cT()
local ae=a.dk()

local af=a.c6()
local ag=a.c7()

local ah=a.di()
local ai=a.cV()
local aj=a.cD()

local ak=a.v()
local b=a.d()
local c=a.cR()
local d=a.cW()

local e=a.n()
local f=a.cY().commands
local g=a.b_()

local h=ab.UserInputService
local i=ab.RunService
local j=ab.TweenService

local k=c.richFontSize
local l=c.colorFromRGB

local m={}
m.__index=m

local n=0.15
local o=2.50
local p=6
local q=24
local r=18
local s=3
local t=5
local u=4
local v=0.2

local w=UDim2.new(1,-2*t,0,r)

local x=UDim2.new(1,-(t+u+q+t),0,r)
local y=50 local z=function(

z)
return aj.lookup[z]end local A=function(


A)
return math[(A<0)and"ceil"or"floor"](A)end local B=function(


B)
B=B:gsub("[\r\n]+$","")
B=B:gsub("[\r\n]+"," ")
return B end


m.refresh=function(C, D, E)
C:syncCommandsData()
local F=C.parser:parse(D)
C.parser:highlight(F)

C:updateSearchBoxHighlight()

if E then
C:scheduleSearchedCommand()
else
C.scrollToken=C.scrollToken+1
C:updateSearchedCommand()
end end




m.scheduleSearchedCommand=function(C)
C.scrollToken=C.scrollToken+1
local D=C.scrollToken

task.delay(n,function()
if D~=C.scrollToken then return end
C:updateSearchedCommand()
end)end


m.applyCorrection=function(C)
local D=C.commandInput
local E=D.correction
local F=D.rawText

local G=F:sub(1,E.from-1)..E.text..F:sub(E.to+1)

if e:getValue("spaceAfterCorrection")then
G=G.." "
end

C:writeText(G)end





m.ensureFocus=function(C)
local D=C.searchBox
if not D then return end

C.focusRequest=(C.focusRequest or 0)+1
local E=C.focusRequest

task.spawn(function()
for F=1,p do
if E~=C.focusRequest or not C.isEnabled then return end
if D:IsFocused()then return end

if D.Parent~=nil then
D:CaptureFocus()
end

i.Heartbeat:Wait()
end
end)end



m.sendText=function(C)
local D=B(C.searchBox.Text)
if not D:match("%S")then return end

C:refresh(D)
C:sendInputCommand()end





m.updateSendButton=function(C)
local D=C.sendButton
local E=C.searchBox
if not(D and E)then return end

local F=not E:IsFocused()and E.Text:match("%S")~=nil
if F==C.sendShown then return end

C.sendShown=F
D.Visible=F
C:tweenSearchBar(if F then x else w)end



m.tweenSearchBar=function(C, D)
local E=C.searchBoxHolder
if not E then return end

if C.barTween then
C.barTween:Cancel()
C.barTween=nil
end

if E.Size==D then return end


if not C.isEnabled then
E.Size=D
return
end

local F=j:Create(E,TweenInfo.new(v,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
Size=D,
})

C.barTween=F
F:Play()end


m.captureFocus=function(C)
local D=C.searchBox
if not D then return end






if D.Parent~=nil then
D:CaptureFocus()
end end





m.setInteractive=function(C, D)
D=D==true
if C.interactive==D then return end
C.interactive=D

C.scrollBar:setLocked(not D)


if not D then
local E=C.searchBox

if E and E:IsFocused()then
E:ReleaseFocus()
end
end end


m.isInteractive=function(C)
return C.interactive end


m.awake=function(C)
local D=C.commandInput
local E=C.searchBox
local F=C.searchBoxHolder
local G=C.inputMarker

local H=F.Placeholder

aa:Connect(aj.changed,function()
if C:syncCommandsData()then
C:refresh(B(E.Text))
end
end)

local I=E:GetPropertyChangedSignal("Text")

local J=0 local K=function()


if(tick()-J)>0.5 then
G.Visible=not G.Visible
J=tick()
end end local L=function()



if E:IsFocused()then
E:ReleaseFocus()
end end local M=function()



if D.correction then
C:applyCorrection()
C:ensureFocus()
return true
end


C:sendInputCommand()
return false end local N=function()



local N=not E:IsFocused()and#E.Text==0
H.Visible=N

C:updateSendButton()end


C.commandClickedSignal:Connect(function(O)
if not C.interactive then return end

C:writeText(O.aliases[1])
C:ensureFocus()
end)

aa:Connect(F.Activated,function()
if not C.interactive then return end

C:ensureFocus()
end)

aa:Connect(C.sendButton.Activated,function()
if not C.interactive then return end


if E:IsFocused()then
E:ReleaseFocus()
end

C:sendText()
end)

aa:Connect(E.Focused,function()
if C.onInteraction then C.onInteraction()end

N()
C.markerConnection=aa:Connect(i.Stepped,K)

if#E.Text==0 then
C:setComment("")
end
end)

aa:Connect(E.FocusLost,function(O)
N()
G.Visible=true
aa:disconnect(C.markerConnection)

if O then
C:refresh(B(E.Text))
M()
end
end)

aa:Connect(I,function()
if C.onInteraction then C.onInteraction()end

local O=E.Text


if O:find("\t")then
E.Text=(O:gsub("\t",""))
return
end


if C.historyIndex and O~=C.historyText then
C.historyIndex=nil
end

local P=O:sub(-1)=="\n"or O:sub(-1)=="\r"

if O:find("[\r\n]")then
O=B(O)
E.Text=O

if P then
C:refresh(O)

if not M()then
L()
end
return
end
end


local Q=#O<#C.lastText
C.lastText=O

N()
C:refresh(O,Q)
end)


aa:Connect(h.InputBegan,function(O)
if not E:IsFocused()then return end

if O.KeyCode==Enum.KeyCode.Up then
C:browseHistory(-1)
elseif O.KeyCode==Enum.KeyCode.Down then
C:browseHistory(1)
elseif O.KeyCode==Enum.KeyCode.Tab and C.commandInput.correction then
C:applyCorrection()
C:ensureFocus()
end
end)end


local C=50


m.sendInputCommand=function(D)
local E=D.commandInput

if E.runError then
D:setComment(E.runError,"error")
return
end

local F=E.statements

for G,H in F do
if not H.commandData then return end
end


if D.onCommandSent then
D.onCommandSent()
end

local G=E.rawText
local H,I

for J,K in F do
local L,M=pcall(function()
D:runStatement(K)
end)

if not L then
H=M
I=K.commandData.name
break
end
end

if e:getValue("clearOnEnter")then
D:writeText("")
end

D.historyIndex=nil

if H then
D:setComment(`failed - {H}`,"error")
b:error(`failed to run command '{I}': {H}`)
else
D:addToHistory(G)
end end



m.runStatement=function(D, E)
ag.runStatement(E)end


m.addToHistory=function(D, E)
local F=(E or""):match("^(.-)%s*$")

if F==""then return end

local G=D.history

if G[#G]==F then return end

table.insert(G,F)

if#G>C then
table.remove(G,1)
end end



m.browseHistory=function(D, E)
local F=D.history

if#F==0 then return end

local G

if D.historyIndex==nil then
if E>0 then return end
G=#F
else
G=D.historyIndex+E
end

if G<1 then
G=1
end

if G>#F then
D.historyIndex=nil
D:setSearchText("")
return
end

D.historyIndex=G
D:setSearchText(F[G])end


m.setSearchText=function(D, E)
D.historyText=E
D:writeText(E)end




m.writeText=function(D, E)
D.searchBox.Text=E
D.lastText=E
D:refresh(E)end


m.create=function(D)
D.searchBoxHolder=ad.new("ImageButton",{
Size=w,
Position=UDim2.new(0,t,0,0),
AnchorPoint=Vector2.new(0,1),
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
TextSize=D.configs.textSize,
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
TextSize=D.configs.textSize-1,
Text=D.configs.placeholderText,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
}),
})

local E=D.searchBoxHolder
local F=E.Input.Holder

D.inputMarker=ad.new("Frame","Marker",F,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

D.inputComment=ad.new("TextLabel","Comment",F,{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromScale(1,0.5),
AnchorPoint=Vector2.new(0,0.5),
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
BackgroundTransparency=1,
TextSize=D.configs.textSize,
RichText=true,
Text="",
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
}
})

D.commandInfo=ad.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=D.configs.textFont,
TextSize=D.configs.textSize-5,
Visible=false,
ad.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

D.searchBox=ad.new("TextBox","SearchBox",{
BackgroundTransparency=1,
BorderSizePixel=0,
TextTransparency=1,
Size=UDim2.fromScale(1,0),
Position=UDim2.fromScale(0,0.4),
ClearTextOnFocus=false,
ShowNativeInput=false,
TextSize=0,
Text="",
MultiLine=true
})



D.searchBox.ZIndex=0
pcall(function()
D.searchBox.Interactable=false
end)

D.commandsFolder=ad.new("Folder","Commands")

D:createSendButton()end



m.createSendButton=function(D)


local E=ad.new("TextButton","Send",{
AnchorPoint=Vector2.new(1,1),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-t,0,0),
Size=UDim2.new(0,q,0,r),
Text="",
Visible=false,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

ad.new("UICorner",{
CornerRadius=UDim.new(0,4),
}),
})

local F=ad.new("ImageLabel","Icon",E,{
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0.5),
ScaleType=Enum.ScaleType.Fit,
Size=UDim2.new(1,-2*s,1,-2*s),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ai:loadImage(F,"lucide-send")

D.sendIcon=F
D.sendButton=E
D.sendShown=false end


m.createCommandsData=function(D)
local E={}
local F={}
for G,H in aj.original do
local I=H.commandData or ae.new(H)
H.commandData=I
I.position=G-1
E[H]=true
table.insert(F,I)
end
for G,H in D.renderedCommands or{}do
if not E[H]then
local I=H.commandData
if I and I.element then I.element:Destroy()end
H.commandData=nil
end
end
D.commandsData=F
D.renderedCommands=table.clone(aj.original)
D.commandsRevision=aj.revision or 0
D.hoveredCommand=nil
D:clearHoverDescription()end


m.syncCommandsData=function(D)
if D.commandsRevision==(aj.revision or 0)then return false end
D:createCommandsData()
D.scrollBar:setTotalSpace(D:calculateTotalSpace())
if D.isEnabled then D:updateElements()end
return true end


m.updateSearchBoxHighlight=function(D)
local E=D.commandInput.highlightText
local F=D.searchBoxHolder
local G=F.Input
local H=d:getScale()

G.Text=E
G.Visible=#E>0

local I=F.AbsoluteSize.X*H
local J=I/2
local K=G.AbsoluteSize.X*H

if K<=J then
G.AnchorPoint=Vector2.new(0,0.5)
G.Position=UDim2.new(0,5,0.5,0)
else
G.AnchorPoint=Vector2.new(1,0.5)
G.Position=UDim2.new(0.5,0,0.5,0)
end end




m.updateSearchBoxPosition=function(D)
local E=D.searchBox
local F=D.searchBoxHolder
local G=D.screenGui
local H=D.scrollHolder and D.scrollHolder.Parent

if not D.isEnabled or not(E and F and G and H)then return end

local I=G.AbsoluteSize
local J=math.max(d:getScale(),0.01)



local K=H.Position
local L=K.X.Scale*I.X+K.X.Offset*J
local M=K.Y.Scale*I.Y+K.Y.Offset*J



local N=L+(F.AbsolutePosition.X-H.AbsolutePosition.X)
local O=M+(F.AbsolutePosition.Y-H.AbsolutePosition.Y)


local P=F.AbsoluteSize
local Q=math.max(math.min(P.X,I.X),1)
local R=math.max(math.min(P.Y,I.Y),1)

local S=D:calculateLabelSize()*o*J

local T=math.clamp(N,0,math.max(I.X-Q,0))
local V=math.clamp(O+R+S,0,math.max(I.Y-R,0))


local W=UDim2.fromOffset(T/J,V/J)
local X=UDim2.fromOffset(Q/J,R/J)


if E.Position~=W or E.Size~=X then
E.Position=W
E.Size=X
end end


m.updateSearchedCommand=function(D)
D:syncCommandsData()
local E=D.commandInput.bestMatch
local F=D.commandInput.commandName
if F==""then return end

local G=z(F)
or(E and z(E))

if G and G.commandData then
D.scrollBar:scrollTo(G.commandData.position)
end end


m.setComment=function(D, E, F)
if F~=nil then
E=af.colorFromName(E,F)
end

D.inputComment.Text=E
D.inputComment.Visible=#E>0 end


m.updateElementColor=function(D, E, F)
local G=if F%2==1 then 1 else 0.96
E.BackgroundTransparency=G end


m.updateElements=function(D)
local E=0
local F=0
local G={}
local H=D.scrollBar
local I=D.commandsFolder

for J,K in D.commandsData do
local L=H:isVisible(K.position)

if not L then
if K.element then K.element.Parent=nil end
continue
end

local M=K.element
if not M then
M=D:createCommandElement(K)
K.element=M
end

if not K.isSection then
if#K.args>0 and#K.name>F then
F=#K.name
end
table.insert(G,K)
end

D:updateElementColor(M,J)
M.Parent=I
M.Position=UDim2.fromOffset(
0,
E*(M.Size.Y.Offset+D.configs.padding)
)
E=E+1
end

for J,K in G do
D:updateDisplayName(K,F+3)
end

D.visibleCommands=G end


m.setCommandInfo=function(D, E)
E=E or""

if E==""then
D.commandInfo.Visible=false
return
end

D.commandInfo.Visible=true
D.commandInfo.Text=E end


m.createSection=function(D, E)


local F=ad.new("TextLabel","Command",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Bottom,
RichText=true,
TextSize=D.configs.textSize-3,
Text=`<b>#{E.sectionName}</b>`,
ThemeTag={
TextColor3="Colors.Text.Darker",
Font="Font.MonoSpace"
},
})

return ad.new("Frame",{
Size=UDim2.new(1,-10,0,D.configs.labelSize),
BackgroundTransparency=1,

F
})end


m.createCommandElement=function(D, E)
if E.isSection then
return D:createSection(E)
end

local F=ad.new("TextLabel","Command",{
Size=UDim2.fromScale(0,1),
Position=UDim2.fromOffset(5,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
AutomaticSize=Enum.AutomaticSize.X,
RichText=true,
TextSize=D.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.MonoSpace"
},
})

return ad.new("Frame",{
Size=UDim2.new(1,0,0,D.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
F
})end


m.createCommandDescription=function(D, E)
if E.isSection then return end
if not E.description then return end

local F=ad.new("TextLabel","Description",{
Size=UDim2.fromScale(1,1),
Position=UDim2.fromOffset(25,0),
BackgroundTransparency=1,
TextXAlignment=Enum.TextXAlignment.Left,
RichText=true,
TextSize=D.configs.textSize,
ThemeTag={
TextColor3="Colors.Text.Dark",
Font="Font.MonoSpace"
},
})

return ad.new("Frame","Description",{
Size=UDim2.new(1,-30,0,D.configs.labelSize),
BackgroundTransparency=1,
F
})end


m.getCommandColor=function(D, E, F)
local G=z(E)
if not G then return E end

local H=
if type(G.run)~="function"then"undefined"
elseif F.isClient then"client"
elseif F.isDeprecated then"deprecated"
else nil

if H~=nil then
E=l(E,f[H])
end

return E end


m.updateDisplayName=function(D, E, F)
local G=E.element
local H=E.name

local I=string.rep("—",(F-#H)-2)

H=D:getCommandColor(H,E)
local J=`{H} {af.colorFromName(I,"comment")} `

local K=D.parser:highlightArgsType(E.args)
local L=J..K

if E.isHolding then
E.originalText=L
else
D:setCommandText(E,L)
end end


m.setCommandText=function(D, E, F)
local G=E.element
if not G then return end

G.Command.Text=F end


m.getCommandText=function(D, E)
local F=E.element
return F and F.Command.Text or""end


m.calculateTotalSpace=function(D)
return#D.commandsData end


m.calculateVisibleSpace=function(D)
local E=D.scrollContainer.AbsoluteSize.Y
return math.floor(E/D:calculateLabelSize())end


m.calculateLabelSize=function(D)
return D.configs.padding+D.configs.labelSize end


m.getElementMouseIn=function(D)
for E,F in D.visibleCommands do
if ac:isMouseInGuiObject(F.element)then
return F
end
end end


m.horizontalScroll=function(D, E)
for F,G in D.visibleCommands do
local H=G.element

H.Position=UDim2.fromOffset(
math.min(H.Position.X.Offset+E,0),
H.Position.Y.Offset
)
end end






m.showHoverDescription=function(D, E)
local F=D.inputComment
local G=D.hoverText~=nil and F.Text==D.hoverText

if not G then
if F.Text~=""then
D.hoverText=nil
return false
end

D.savedComment=F.Text
end

D.hoverText=af.colorFromName(E,"comment")
F.Text=D.hoverText
F.Visible=true
return true end


m.clearHoverDescription=function(D)
if D.hoverText==nil then return end

local E=D.inputComment


if E.Text==D.hoverText then
E.Text=D.savedComment or""
E.Visible=#E.Text>0
end

D.hoverText=nil
D.savedComment=nil end


m.updateHoverDescription=function(D)
local E

if D.interactive and ac:isMouseInGuiObject(D.scrollContainer)then
E=D:getElementMouseIn()
end

local F=E and E.description
if not F then
D.hoveredCommand=nil
D:clearHoverDescription()
return
end

if E==D.hoveredCommand then return end


if D:showHoverDescription(F)then
D.hoveredCommand=E
end end


m.startedHoldingContainer=function(D, E)
if not D.interactive then return end
if not ah.isPressingInput(E)then return end
if D.scrollBar:isScrollBarDisabled()then return end

D.scrollAxis=nil
D.scrollBar:disableScroll()

local F=ac:getMouse()
local G=D:calculateLabelSize()
local H=D:getElementMouseIn()
local I=tick()

if H and H.description then
H.isHolding=true

local J=D.parser.colorFromName(H.description,"comment")

H.originalText=D:getCommandText(H)
D:setCommandText(H,J)
end

local J=F.Y
local K=F.X



local L=F.Y
local M=D.scrollBar.index<=0
local N=0
local O=false

local P local Q=function()


D.scrollBar:enableScroll()


if M and D.scrollAxis=="y"and N>=y and D.onSwipeDown then
O=true
D.onSwipeDown()
end

if H then
H.isHolding=nil

if H.originalText then
D:setCommandText(H,H.originalText)
H.originalText=nil
end

if(tick()-I)<=0.15 and not O then
D.commandClickedSignal:Fire(H)
end
end

if P then P:Disconnect()end end


ah.onReleaseEvent(Q)

P=ah.onMouseEvent(function(R)

if not D.interactive then return end
N=F.Y-L

local S=F.X-K
local T=F.Y-J

if not D.scrollAxis then
if math.abs(S)>4 or math.abs(T)>4 then
D.scrollAxis=math.abs(S)>math.abs(T)and"x"or"y"
end
return
end

if D.scrollAxis=="x"then
local V=A(S/3)
if math.floor(V)~=0 then
D:horizontalScroll(V)
K=F.X
end
else
local V=A(T/G)
if math.floor(V)~=0 then
D.scrollBar:scrollTo(D.scrollBar.index-V)
J=F.Y
end
end
end)end


m.update=function(D)
D:syncCommandsData()
D.scrollBar:setVisibleSpace(D:calculateVisibleSpace())
D.scrollBar:setTotalSpace(D:calculateTotalSpace())
D:updateElements()end


m.enable=function(D)
if D.isEnabled then return end
local E=D.scrollContainer
D.isEnabled=true

D.commandsFolder.Parent=E
D.searchBox.Parent=D.screenGui
D.searchBoxHolder.Parent=D.scrollHolder
D.sendButton.Parent=D.scrollHolder
D.commandInfo.Parent=D.scrollHolder

D.scrollConnection=D.scrolledSignal:Connect(function()
D:updateElements()
end)

D.containerConnection=E.InputBegan:Connect(function(F)
D:startedHoldingContainer(F)
end)

D:update()
D:updateSearchBoxPosition()


D.searchBoxConnection=aa:Connect(i.RenderStepped,function()
D:updateSearchBoxPosition()
end)


if not g then
D.hoverConnection=aa:Connect(i.RenderStepped,function()
D:updateHoverDescription()
end)
end end


m.disable=function(D)
if not D.isEnabled then return end
D.isEnabled=false

D.commandsFolder.Parent=nil
D.searchBox.Parent=nil
D.searchBoxHolder.Parent=nil
D.sendButton.Parent=nil
D.commandInfo.Parent=nil

aa:disconnect(D.containerConnection)
aa:disconnect(D.markerConnection)
aa:disconnect(D.scrollConnection)
aa:disconnect(D.searchBoxConnection)
aa:disconnect(D.hoverConnection)

D.hoveredCommand=nil
D:clearHoverDescription()end


m.new=function(D)local E=function(
E)
return assert(D.configs[E],`missing config.configs['{E}']`)end


local F=setmetatable({
scrollContainer=D.scrollContainer,
scrolledSignal=D.scrolledSignal,
scrollHolder=D.scrollHolder,
scrollBar=D.scrollBar,
screenGui=D.screenGui,

configs={
placeholderText=E("placeholderText"),
padding=E("padding"),
labelSize=E("labelSize"),
textSize=E("textSize")
},

commandClickedSignal=ak.new(),

interactive=true,

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
historyText="",
lastText="",
scrollToken=0,
},m)

F.parser=af.new(F.commandInput,function(G,H)
return F:setComment(G,H)
end)

return F end


return m end a.dl=function()local ab=a.cache.dl if not ab then ab={c=aa()}a.cache.dl=ab end return ab.c end end do local aa=function()













local aa=a.di()
local ab=a.f()
local ac=a.v()

local ad=ab.UserInputService

local ae=0.28
local af=0.2
local ag=10

local ah={}
ah.__index=ah local ai=function(



ai)
return ai.UserInputType~=Enum.UserInputType.Touch end local aj=function(



aj, ak)
if ak==aj.input then return true end
return aj.isMouse and ak.UserInputType==Enum.UserInputType.MouseMovement end local ak=function(



ak, b)
if b==ak.input then return true end
return ak.isMouse and b.UserInputType==ak.input.UserInputType end




ah._resetDrag=function(b)
for c,d in b._pressConnections do
d:Disconnect()
end
table.clear(b._pressConnections)

b._press=nil
b.isDragging=false
b.draggingObject=nil
b.dragStart=nil
b.startPos=nil
b.lastPos=nil
b.pressTime=0
b.travel=0 end




ah._endPress=function(b, c)
if b._press~=c then return end

local d=b.isDragging
local e=b.draggingObject
local f

if d then
f={
duration=os.clock()-b.pressTime,
travel=b.travel,
dy=b.lastPos.Y-b.dragStart.Y,
}
end

b:_resetDrag()

if d then
b.dragEnded:Fire(e,f)
end end



ah._beginDrag=function(b, c)
if b.isDragging or b._press~=c then return end

b.isDragging=true
b.draggingObject=c.object
b.dragStarted:Fire(c.object)end



ah._onPressMoved=function(b, c, d)
if b._press~=c or not aj(c,d)then return end

if c.isButton and not b.isDragging then
if(d.Position-b.dragStart).Magnitude<=ag then return end

b:_beginDrag(c)
end

if b.isDragging then
b:update(c.object,d)
end end




ah._startPress=function(b, c, d)
local e={
object=c,
input=d,
isMouse=ai(d),
isButton=c:IsA("GuiButton"),
}

b._press=e
b.dragStart=d.Position
b.lastPos=d.Position
b.startPos=c.Position
b.pressTime=os.clock()
b.travel=0


b._pressConnections={
d.Changed:Connect(function()
if d.UserInputState==Enum.UserInputState.End then
b:_endPress(e)
end
end),
ad.InputChanged:Connect(function(f)
b:_onPressMoved(e,f)
end),
ad.InputEnded:Connect(function(f)
if ak(e,f)then
b:_endPress(e)
end
end),
}

if not e.isButton then
b:_beginDrag(e)
return
end

task.delay(af,function()
b:_beginDrag(e)
end)end





ah.addGuiObject=function(b, c)
return c.InputBegan:Connect(function(d)
if not aa.isPressingInput(d)then return end
if b._press then return end

b:_startPress(c,d)
end)end


ah.update=function(b, c, d)
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

c.Position=c.Position:Lerp(g,ae)
b.onDragged:Fire(c)end


ah.canDragObject=function(b, c)
return(not b.isDragging)or(b.draggingObject==c)end


ah.setFilter=function(b, 
c, 
d)

b.filters[c]=d end


ah.new=function(b)
return setmetatable({
isDragging=false,
draggingObject=nil,
_uiScale=b,
dragStart=nil,
startPos=nil,
lastPos=nil,
pressTime=0,
travel=0,
_press=nil,
_pressConnections={},
filters={},

onDragged=ac.new(),
dragStarted=ac.new(),
dragEnded=ac.new(),
},ah)end


return ah end a.dm=function()local ab=a.cache.dm if not ab then ab={c=aa()}a.cache.dm=ab end return ab.c end end do local aa=function()

local aa=a.cW().uiScale
return a.dm().new(aa)end a.dn=function()local ab=a.cache.dn if not ab then ab={c=aa()}a.cache.dn=ab end return ab.c end end do local aa=function()
local aa=a.cR()

local ab={a=
"\a",b="\b",f="\f",n="\n",r=
"\r",t="\t",v="\v",["\\"]="\\",
["\""]="\"",["\'"]="\'",
}

local ac="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"
local ad="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_0123456789"
local ae="0123456789abcdefABCDEF"
local af="0123456789"

return{
whiteSpaceChars={" ","\t","\n","\r"},

startIdentChars=aa.chararray(ac),
identChars=aa.chararray(ad),
numberChars=aa.chararray(af),
hexNumberChars=aa.chararray(ae),
escapeSequences=ab,
maxSymbolLength=3,

binaryNumberChars={"0","1"},
decimalExponent={"e","E"},
hexadecimalNums={"x","X"},
binaryNums={"b","B"},
decimalSeparators={"_"},

hybridKeywords={
"continue","export","type","typeof","read","write"
},
keywords={
"and","break","do","else","elseif","continue","end","false","for",
"function","if","in","local","nil","not","or","repeat","return",
"then","true","until","while",
"export","type","typeof","read","write"
},
symbols={
"+=","-=","/=","%=","^=","..=","*=","//=","+","-","*","/","%","^",
"#","//","==","~=","<=",">=","<",">","=","(",")","{","}","[","]",
";",":",",",".","..","...","::","->","?","|","&"
},
symbolChars=aa.chararray("+-*/%^#=~<>(){}[];:,.?|&"),

supportsNumericalEscapes=true,
supportsHexEscapes=true,
supportsUnicodeEscapes=true,
supportsEscapeZIgnoreNextWhitespace=true,
supportsAdvancedSemicolons=true,

TypeAnnotationsChars="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",

supportsInterpolatedStrings=true,
supportsTypeAnnotations=true,
supportsCompounds=true,
supportsIfElseInLine=true,
}end a.dp=function()local ab=a.cache.dp if not ab then ab={c=aa()}a.cache.dp=ab end return ab.c end end do local aa=function()










local aa=a.dp()
local ab=a.cY().args
local ac=a.cR()

local ad=ac.lookupify({
"and","break","continue","do","else","elseif","end","export","for","function","if","in","local",
"not","or","repeat","return","then","type","typeof","until","while",
})
local ae=ac.lookupify({"true","false","nil"})
local af=ac.lookupify({
"Argument","ArgsManager","Color3","Command","CommandsController","Enum","EnumItem","Instance","Player",
"Vector3","any","boolean","game","number","script","self","string","table","task","workspace",
})
local ag=ac.lookupify(aa.symbolChars)

local ah=ac.lookupify({
"...","..=","//=","==","~=","<=",">=","..","::","//","->","+=","-=","*=","/=","%=","^=",
})

local ai={
comment=ab.comment,
string=ab.string,
number=ab.number,
symbol=ab.symbol,
}

local aj={}
aj.__index=aj local ak=function(



ak, b)
local c=string.match(ak,"^%[(=*)%[",b)
if c==nil then
return nil
end

local d,e=string.find(ak,"]"..c.."]",b+#c+2,true)
return if e then e+1 else#ak+1 end local b=function(




b, c)
local d=string.sub(b,c,c)
local e=c+1

while e<=#b do
local f=string.sub(b,e,e)

if f=="\\"then
e=e+2
elseif f==d then
return e+1
elseif f=="\n"then
return e
else
e=e+1
end
end

return#b+1 end local c=function(



c, d)
local e=string.match(c,"^0[xX][%x_]+",d)or string.match(c,"^0[bB][01_]+",d)
if e then
return e
end

local f=string.sub(c,d,d)=="."

if f and string.sub(c,d-1,d-1)=="."then
return nil
end

e=string.match(c,"^%d[%d_]*",d)
if e==nil and f then
e=string.match(c,"^%.%d[%d_]*",d)
end
if e==nil then
return nil
end

local g=d+#e

if string.sub(c,g,g)=="."and string.sub(c,g+1,g+1)~="."then
local h=string.match(c,"^%.[%d_]*",g)
e=e..h
g=g+#h
end

local h=string.match(c,"^[eE][%+%-]?%d+",g)
if h then
e=e..h
end

return e end local d=function(



d, e)
local f=string.sub(d,e,e+2)
if ah[f]then
return f
end

local g=string.sub(d,e,e+1)
if ah[g]then
return g
end

return nil end local e=function(




e)
local f={}
local g=#e

local h={}local i=function(

i, j)
table.insert(f,{kind=i,text=j})end local j=function(



j)
local k=j
while k<=g do
local l=string.sub(e,k,k)
if l=="\\"then
k=k+2
elseif l=="`"or l=="{"then
break
else
k=k+1
end
end

local l=math.min(k,g+1)
if l>j then
i("string",string.sub(e,j,l-1))
end

if k>g then
return g+1
end

if string.sub(e,k,k)=="`"then
i("string","`")
else
i("symbol","{")
table.insert(h,0)
end

return k+1 end


local k=1
while k<=g do
local l=string.sub(e,k,k)

if string.match(l,"%s")then
local m=string.match(e,"^%s+",k)
i("space",m)
k=k+#m
elseif string.sub(e,k,k+1)=="--"then

local m=ak(e,k+2)or string.find(e,"\n",k,true)or g+1
i("comment",string.sub(e,k,m-1))
k=m
elseif l=='"'or l=="'"then
local m=b(e,k)
i("string",string.sub(e,k,m-1))
k=m
elseif l=="["and ak(e,k)then
local m=ak(e,k)
i("string",string.sub(e,k,m-1))
k=m
elseif l=="`"then
i("string","`")
k=j(k+1)
elseif l=="{"and#h>0 then do local m=
#h h[m]=h[m]+1 end
i("symbol","{")
k=k+1
elseif l=="}"and#h>0 then
if h[#h]==0 then
table.remove(h)
i("symbol","}")
k=j(k+1)
else do local m=
#h h[m]=h[m]-1 end
i("symbol","}")
k=k+1
end
elseif string.match(l,"[%a_]")then
local m=string.match(e,"^[%a_][%w_]*",k)
i("name",m)
k=k+#m
elseif c(e,k)then
local m=c(e,k)
i("number",m)
k=k+#m
else
local m=d(e,k)or l
i(if ag[l]then"symbol"else"other",m)
k=k+#m
end
end

return f end local f=function(



f, g, h)
local i=g+h
while f[i]and f[i].kind=="space"do
i=i+h
end
return f[i]end local g=function(



g, h, i)
if ae[i]then
return ab.boolean
end
if ad[i]or af[i]then
return ab.others
end

local j=f(g,h,-1)
local k=f(g,h,1)
local l=if j then j.text else nil
local m=if k then k.text else nil

if l=="function"then
return ab.func
end
if l=="."then
return if m=="("then ab.func else ab.field
end
if m=="("then
return ab.func
end
if l=="{"and m=="="then
return ab.field
end


return nil end local h=function(


h, i, j)
if j.kind=="name"then
return g(h,i,j.text)
end
return ai[j.kind]end


aj.apply=function(i, j)
local k=e(tostring(j))


local l={}
for m,n in k do
local o=h(k,m,n)
local p=l[#l]

if p and p.color==o then
table.insert(p.texts,n.text)
else
table.insert(l,{color=o,texts={n.text}})
end
end

local m={}
for n,o in l do
local p=ac.escapeRichText(table.concat(o.texts))
table.insert(m,if o.color then ac.colorFromRGB(p,o.color)else p)
end

return table.concat(m)end


aj.new=function()
return setmetatable({},aj)end


return aj end a.dq=function()local ab=a.cache.dq if not ab then ab={c=aa()}a.cache.dq=ab end return ab.c end end do local aa=function()






local aa=a.dq()
local ab=a.j()
local ac=a.cz()local ad=function(
ad)
return aa:apply(ad)end


return{
{
{"title","Create a Plugin"},
{"text",`A plugin file returns {ad("{ Command }")}: a list of command tables. You can also return one {ad("Command")} table directly. Each command declares its names, arguments and function.`},
{"text",`Save the file in {ad(ab.privateFolder.."/plugins")} with one of these extensions: {ad(table.concat(ac.extensions,", "))}. Use a filename with letters, numbers, {ad("_")} or {ad("-")}.`},
{"text",`Install with {ad("addplugin myplugin.luau")} or Manage Plugins. Use {ad("reloadplugin myplugin")} after editing. Commands appear under {ad(ac.sectionName or"plugin commands")} in the main list.`},
{"text","Code blocks have a copy button in their top right corner, so an example can go straight into a file."},
},
{
{"title","Command Fields and Types"},
{"text",`<b>{ad("action: string")}</b> — Required. The first name is the command name; separate aliases with {ad('"|"')}, for example {ad('"hello|hi"')}. Names and aliases must be unique across installed and built-in commands.`},
{"text",`<b>{ad("description: string?")}</b> — Optional. Explains the command when its row is hovered or held.`},
{"text",`<b>{ad("args: (Argument | { Argument })?")}</b> — Optional. Declare arguments in reading order. One argument can be written directly as an {ad("Argument")} table. Omit this field for commands without arguments.`},
{"text",`<b>{ad("run: (self, args) -> ()")}</b> — Supply the function that runs your command. {ad("self")} is the command controller; {ad("args")} reads validated arguments. Without this function, the command cannot perform an action.`},
},
{
{"title","Argument Fields and Types"},
{"text",`<b>{ad("kind: string")}</b> — The validator name, such as {ad('"string"')}, {ad('"number"')} or {ad('"player"')}. It controls the hint and the value passed to your function.`},
{"text",`<b>{ad("name: string?")}</b> — Optional label shown in the argument hint.`},
{"text",`<b>{ad("optional: boolean?")}</b> — Set to {ad("true")} to allow omission. Put optional arguments last. A missing value reads as {ad("nil")}; provide a fallback in your function.`},
{"text",`<b>{ad("options: ({ string } | string)?")}</b> — For string/text arguments, restrict values and offer autocomplete. Use {ad('{ "red", "blue" }')} or {ad('"red|blue"')}.`},
{"text",`<b>{ad("min: number?")}, {ad("max: number?")}, {ad("floor: boolean?")}</b> — For numbers, define accepted bounds and require whole numbers. {ad("clamp = { 1, 100 }")} also defines bounds; values outside them are rejected.`},
{"text",`<b>{ad("variadic: boolean?")}</b> — On the last argument only, repeat its definition to accept more values. Add {ad("optional = true")} to allow zero values.`},
},
{
{"title","Argument Values"},
{"text",`<b>{ad('"string"')}, {ad('"text"')}, {ad('"object"')}</b> → {ad("string")}. Quotes keep values containing spaces together.`},
{"text",`<b>{ad('"number"')}</b> → {ad("number")}; <b>{ad('"boolean"')}</b> → {ad("boolean")}. Boolean inputs include true/false, yes/no and enabled/disabled.`},
{"text",`<b>{ad('"vector3"')}</b> → {ad("Vector3")}, entered as {ad("0,10,0")}; <b>{ad('"color3"')}</b> → {ad("Color3")}, entered as {ad('"#ff0000"')} or {ad("255,0,0")}.`},
{"text",`<b>{ad('"player"')}</b> → selector text ({ad("string")}), not a Player instance. Turn it into Players with {ad("self:resolvePlayers(text)")}, which understands names and selectors such as all or others. See Player Argument.`},
{"text",`<b>{ad('"className"')}, {ad('"team"')}, {ad('"waypoint"')}, {ad('"command"')}, {ad('"alias"')}, {ad('"plugin"')}</b> → validated name ({ad("string")}). <b>{ad('"keycode"')}</b> → an {ad("EnumItem")} from Enum.KeyCode.`},
{"text",`Read each value with {ad("args:nextValue()")}. {ad("args:next()")} returns the argument record instead. Invalid or missing required values stop execution before run is called.`},
},
{
{"title","Inside run(self, args)"},
{"text",`{ad('self:notify("Title", "Message")')} shows a notification. {ad("self.localPlayer")} is your player; {ad("self.players")} is the Players service; {ad("self.robloxServices")} provides other services.`},
{"text",`{ad("self:getRoot()")} gets your character root when available. {ad("self.playerService:getHumanoid()")} gets its Humanoid. Check for {ad("nil")} before changing character objects.`},
{"text",`{ad("self:run(name, args)")} runs another command; omitting args passes no arguments. {ad("self:connect(signal, callback)")} registers a connection with the application's connection service.`},
{"text","The examples on the next pages are independent files. Install each one separately; command names and aliases cannot replace an existing command."},
},
{
{"title","Player Argument"},
{"text",`A {ad('"player"')} argument gives you the text that was typed, not a Player. Read it with {ad("args:nextValue()")}, then turn it into a list of Players with {ad("self:resolvePlayers(text)")}.`},
{"text",`The list is empty when nobody matches, so check it before you use it. Use {ad("[1]")} to take the first player when you need only one.`},
{"text",`A name matches players whose username or display name starts with that text, ignoring case. For example, {ad('"bo"')} matches {ad('"bob"')} and {ad('"bobby"')}. Use {ad('"@bo"')} to search usernames only.`},
{"bold","These words and patterns select groups of players:"},
{"cases"},
{"bold","Combine selectors with commas, + and -:"},
{"text",`Commas separate expressions, so {ad('"noob,bob"')} gives both players. Inside one expression, {ad("+")} adds players and {ad("-")} takes them away, from left to right.`},
{"text",`{ad('"all-friends"')} is everyone except your friends. {ad('"-friends"')} does the same, since it starts from everyone. {ad('"%blue-friends"')} is players on the blue team who are not your friends.`},
{"bold","Example: teleport to a player"},
{"text",`Save as {ad("players.luau")} and install with {ad("addplugin players")}. Run {ad("pgoto nearest")} to teleport to the closest player, or {ad("pgoto bo")} to the first player whose name starts with bo.`},
{"text","The command bar only accepts text that matches someone, but that player can leave before run is called, so the example checks again."},
{"file","plugins/examples/players.luau"},
},
{
{"title","Example 1: A Greeting"},
{"text",`Save as {ad("greeting.luau")} and install with {ad("addplugin greeting")}. Run {ad('pluginhello "John Doe"')} or use its {ad("phi")} alias.`},
{"file","plugins/examples/greeting.luau"},
},
{
{"title","Example 2: Two Commands in One File"},
{"text",`Save as {ad("walkspeed.luau")}. After {ad("addplugin walkspeed")}, run {ad("pluginws 32")} or {ad("pluginresetws")} to restore Roblox's usual default.`},
{"file","plugins/examples/walkspeed.luau"},
},
{
{"title","Example 3: Multiple Typed Arguments"},
{"text",`Save as {ad("message.luau")}. Run {ad('pluginmessage info "Hello world" true')}. The level has autocomplete, the message stays together in quotes, and the last boolean is optional.`},
{"file","plugins/examples/message.luau"},
},
{
{"title","Plugin Reference"},
{"text","The full set of types for the plugin API, in Luau. Copy it to check your plugin files with a Luau type checker, so they use the same names and fields as the API."},
{"file","plugins/types.luau"},
},
}end a.dr=function()local ab=a.cache.dr if not ab then ab={c=aa()}a.cache.dr=ab end return ab.c end end do local aa=function()

local aa=a.cR().colorFromRGB
local ab=a.cY().commands

local ac=a.cZ()local ad=function(

ad)
return ac:apply(ad)end


local ae={
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
{"text",`The gray hint in the command bar shows what each argument expects. For example, {ad("(fly_speed: number?)")} means you type a number.`},
{"bold","The ? means the argument is optional. You can leave it out and the command still runs."},
{"text",`Arguments are read in order, so optional ones go last. If a value has spaces, put it in quotes, like {ad('"John Doe"')}.`},
{"text","If something is wrong, the command bar tells you what to fix, and nothing runs."},
{"bold","Examples:"},
{"text",";fly 50 - fly at speed 50\n;fov 90 - set the field of view to 90\n;tppos 0,10,0 - teleport to X 0, Y 10, Z 0"},
},
{
{"title","What the Hint Words Mean"},
{"text",`<b>number</b> - a number, like 10 or 2.5\n<b>string</b> - text, like a name or a word\n<b>boolean</b> - yes or no. You can also type true/false or enabled/disabled\n<b>player</b> - a player name, or one of the special words above\n<b>vector3</b> - a position written as three numbers with commas: X,Y,Z, like 0,10,0\n<b>color3</b> - a color, written as {ad("#ff0000")} or as red,green,blue from 0 to 255\n<b>waypoint</b> - the name of a waypoint you saved\n<b>className</b> - a type of object in the game, like Part or Model\n<b>team</b> - the name of a team in the game\n<b>keycode</b> - a keyboard key, like E\n<b>command</b> - the name of a command\n<b>alias</b> - a shortcut name you made with addalias\n<b>plugin</b> - the name of a plugin you installed\n<b>object</b> - any text, nothing is checked`},
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
}


ae.pages={
{id="types",title="Types",sections=ae.sections},
{id="plugins",title="Plugins",sections=a.dr(),paged=true},
}

ae.navigation={
back="Back",
next="Next",
}


ae.labels={
loading="Loading...",
failed="Could not load this code. Open this page again to retry.",
}

return ae end a.ds=function()local ab=a.cache.ds if not ab then ab={c=aa()}a.cache.ds=ab end return ab.c end end do local aa=function()



local aa=a.cT()
local ab=a.cS()
local ac=a.cV()
local ad=a.dn()
local ae=a.dj()

local af=a.cW()
local ag=a.aE()
local ah=a.a()
local ai=a.cG()
local aj=a.az()
local ak=a.f()
local b=a.cJ()

local c=a.ds()
local d=a.dq()

local e=ak.TweenService

local f=500
local g=20
local h=28
local i=4


local j=300
local k=260
local l=40
local m=g+h+j

local n=12
local o=20
local p=40



local q=32
local r=16
local s=8
local t=18
local u=14
local v=n+8
local w=UDim2.new(0,0,0,0)
local x=UDim2.new(0,0,0,l)
local y=0.15
local z=0.15

local A=6
local B=8
local C=14
local D=6
local E="lucide-clipboard-copy"
local F=1.5

local G=0.5
local H=0.25
local I=0.25
local J=0.2
local K=0.12
local L=0.3
local M=0.15
local N=36
local O=Enum.EasingStyle.Quart
local P=Enum.EasingDirection.Out

local Q=UDim.new(0.5,0)

local R=UDim2.new(0.5,-f/2,0,-500)
local S=UDim2.new(0.5,-f/2,0.5,-m/2)

local T={["&"]="&amp;",["<"]="&lt;",[">"]="&gt;"}

local V=c.cases
local W=c.pages
local X=#W

local Y={}
Y.__index=Y



local Z=setmetatable({},{__mode="k"})local al=function(

_, al)
local am=Z[_]
local an=am and am[al]
if an==nil then
return
end

am[al]=nil
an:Cancel()end local am=function(




am, an, _, ao, ap)
al(am,an)

if _<=0 then
for aq,ar in ao do
am[aq]=ar
end
if ap then
ap()
end
return
end

local aq=e:Create(am,TweenInfo.new(_,O,P),ao)
Z[am]=Z[am]or{}
Z[am][an]=aq

aq.Completed:Connect(function(ar)
local as=Z[am]
if as and as[an]==aq then
as[an]=nil
end

if ar==Enum.PlaybackState.Completed and ap then
ap()
end
end)

aq:Play()end local an=function(



an, ao, ap)
local aq,ar={},{}
for as in ao do
if string.sub(as,-6)=="Color3"then
table.insert(aq,as)
ar[as]=an[as]
end
end

ab:addObject(an,ao)

local as={}
for _,at in aq do
as[at]=an[at]
an[at]=ar[at]
end

am(an,"color",ap,as)end local ao=function(



ao)
local ap={}
for aq,ar in ao:GetDescendants()do
if ar.ClassName=="TextLabel"or ar.ClassName=="TextButton"then
table.insert(ap,ar)
end
end
return ap end local ap=function(


ap)
return(ap:gsub("[&<>]",T))end local aq=function(


aq)
return aa.new("TextLabel","Header",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=aq,
TextSize=20,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})end local ar=function(


ar, as)
return aa.new("TextLabel",as and"Bold"or"Text",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=ar,
TextSize=14,
TextWrapped=true,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font=as and"Font.Bold"or"Font.Normal",
TextColor3="Colors.Text.Default",
},
})end local as=function()



local as=aa.new("Frame","Cases",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for at,_ in V do
local au,av=_[1],_[2]

aa.new("TextLabel","Case",as,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=at,
RichText=true,
Size=UDim2.new(1,0,0,0),
Text=`<b>{ap(au)}</b> {ap(av)}`,
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

return as end local at=function(



at, au)
am(at,"text",0,{TextTransparency=1})
at.Text=au
am(at,"text",L,{TextTransparency=0})end local au=function(





au, av, _)
local aw=if au=="code"then av else nil
local ax=false

local ay=aa.new("Frame","Code",{
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,0),
ThemeTag={BackgroundColor3="Colors.Buttons.Default"},
aa.new("UICorner",{CornerRadius=UDim.new(0,A)}),
})


local az=aa.new("TextLabel","Source",ay,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=if aw then d:apply(aw)else c.labels.loading,
TextSize=13,
TextWrapped=true,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
aa.new("UIPadding",{
PaddingTop=UDim.new(0,B),
PaddingBottom=UDim.new(0,B),
PaddingLeft=UDim.new(0,B),

PaddingRight=UDim.new(0,C+D+B),
}),
})

local aA=aa.new("ImageButton","Copy",ay,{
BackgroundTransparency=1,
Position=UDim2.new(1,-(C+D),0,D),
Size=UDim2.fromOffset(C,C),
ThemeTag={ImageColor3="Colors.Icons"},
})
ac:loadImage(aA,E)

if not ah.setclipboard then
aA.Visible=false
end

local aB
ag:Connect(aA.Activated,function()
if aw==nil or not ah.setclipboard then return end

ah.setclipboard(aw)
an(aA,{ImageColor3="Colors.Primary"},b:getScale(M))

local aC=tick()
aB=aC

task.wait(F)
if aB~=aC then return end

an(aA,{ImageColor3="Colors.Icons"},b:getScale(M))
end)

if au=="file"then
table.insert(_,function()
if aw~=nil or ax then return end
ax=true

task.spawn(function()
local aC=ai.fetchReference(av)
ax=false

if aC==nil then
az.Text=c.labels.failed
return
end

aw=aC
at(az,d:apply(aC))
end)
end)
end

return ay end local av=function(


av)
local aw=aa.new("TextButton","InviteButton",{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,25),
Text=`Copy Discord Invite Link ({av})`,
TextSize=16,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local ax=aw.Text
local ay

ag:Connect(aw.Activated,function()
if ah.setclipboard then
ah.setclipboard(av)
aw.Text="Copied"
else
aw.Text="No Clipboard Function, type out the link"
end

local az=tick()
ay=az

task.wait(F)
if ay~=az then return end

aw.Text=ax
end)

return aw end local aw=function(



aw, ax)
local ay=aw[1]

if ay=="title"then
return aq(aw[2])
elseif ay=="cases"then
return as()
elseif ay=="invite"then
return av(aj.links.discord)
elseif ay=="code"or ay=="file"then
return au(ay,aw[2],ax)
end

return ar(aw[2],ay=="bold")end local ax=function(


ax, ay, az, aA)
local aB=aa.new("Frame","Section",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=ax,
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

for aC,_ in ay do
local aD=aw(_,aA)
aD.LayoutOrder=aC
aD.Parent=aB
end

if not az then
aa.new("Frame","Line",aB,{
BorderSizePixel=0,
LayoutOrder=#ay+1,
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Colors.Stroke",
},
})
end

return aB end local ay=function(



ay, az, aA, aB, aC, aD)
local _=aa.new("TextButton",az,ay,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
LayoutOrder=aD,
Size=UDim2.new(0,0,0,q),
Text="",
ThemeTag={BackgroundColor3="Colors.Tonal.Default"},
aa.new("UICorner",{CornerRadius=UDim.new(0.5,0)}),
aa.new("UIPadding",{
PaddingLeft=UDim.new(0,r),
PaddingRight=UDim.new(0,r),
}),
aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
Padding=UDim.new(0,s),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local aE=aa.new("ImageLabel","Icon",_,{
BackgroundTransparency=1,
LayoutOrder=if aC then 1 else 2,
Size=UDim2.fromOffset(t,t),
ThemeTag={ImageColor3="Colors.Tonal.Text"},
})
ac:loadImage(aE,aB)

local aF=aa.new("TextLabel","Label",_,{
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
LayoutOrder=if aC then 2 else 1,
Size=UDim2.new(0,0,1,0),
Text=aA,
TextSize=u,
ThemeTag={
Font="Font.Medium",
TextColor3="Colors.Tonal.Text",
},
})

return{button=_,label=aF,icon=aE,enabled=false}end local az=function(



az, aA, aB)
local aC=if aA then"Colors.Tonal.Default"else"Colors.Tonal.Disabled"
local aD=if aA then"Colors.Tonal.Text"else"Colors.Tonal.DisabledText"


if not az.painted then
aB=0
az.painted=true
end

az.enabled=aA
an(az.button,{BackgroundColor3=aC},aB)

an(az.label,{Font="Font.Medium",TextColor3=aD},aB)
an(az.icon,{ImageColor3=aD},aB)


am(az.button,"transparency",aB,{BackgroundTransparency=0})end local aA=function(


aA, aB)
local aC=if aB and aA.enabled then z else 0
am(aA.button,"transparency",b:getScale(K),{BackgroundTransparency=aC})end local aB=function(



aB, aC, aD)
am(aB,"position",aD,{Position=UDim2.new((aC-1)/X,0,0,0)})end


Y.new=function()
return setmetatable({
isOpen=false,
pages={},
onOpenChanged=nil,
},Y)end


Y.setOpen=function(aC, aD)
aC.isOpen=aD

if aC.onOpenChanged then
aC.onOpenChanged(aD)
end end


Y.open=function(aC)
aC:setOpen(true)
aC.frame:TweenPosition(S,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,G,true)end


Y.close=function(aC)
aC:setOpen(false)
aC.frame:TweenPosition(R,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,G,true)end


Y.refreshScroll=function(aC)
local aD=aC.activeEntry
if not aD then return end

local aE=math.max(af:getScale(),0.01)
aC.scrollBar:setTotalSpace(math.ceil(aD.body.AbsoluteSize.Y/aE))
aC.scrollBar:setVisibleSpace(math.ceil(aC.container.AbsoluteSize.Y/aE))
aD.body.Position=UDim2.fromOffset(0,-aC.scrollBar.index)end


Y.loadEntry=function(aC, aD)
for aE,aF in aD.loaders do
aF()
end end


Y.updateNavigation=function(aC, aD, aE)
local aF=if aE then b:getScale(J)else 0

az(aC.nav.back,aD.index>1,aF)
az(aC.nav.forward,aD.index<#aD.entries,aF)
aC.counter.Text=`{aD.index} / {#aD.entries}`end




Y.transitionTo=function(aC, aD, aE, aF)
local _=aD.entries[aE]
local aG=aC.activeEntry
if _==nil or _==aG then return end

local aH=if aF==0 or aG==nil then 0 else b:getScale(H)

aC.activeEntry=_
aD.index=aE

_.slide.Visible=true
aC:loadEntry(_)
if aD.paged then
aC:updateNavigation(aD,aH>0)
end


am(_.slide,"position",0,{Position=UDim2.new(0,aF*N,0,0)})
am(_.slide,"position",aH,{Position=UDim2.new(0,0,0,0)})
for aI,aJ in ao(_.slide)do
am(aJ,"text",0,{TextTransparency=1})
am(aJ,"text",aH,{TextTransparency=0})
end


if aG then
am(aG.slide,"position",aH,{Position=UDim2.new(0,-aF*N,0,0)},function()
if aC.activeEntry~=aG then
aG.slide.Visible=false
end
end)
for aI,aJ in ao(aG.slide)do
am(aJ,"text",aH,{TextTransparency=1})
end
end

aC.scrollBar:scrollTo(0)
aC:refreshScroll()end


Y.turnPage=function(aC, aD)
local aE=aC.activePage
if not aE or not aE.paged then return end

local aF=aE.index+aD
if aF<1 or aF>#aE.entries then return end

aC:transitionTo(aE,aF,aD)end




Y.setPaged=function(aC, aD, aE)
local aF=if aE then 0 else b:getScale(I)
local aG=aC.navigation

am(aC.holder,"size",aF,{
Size=UDim2.new(1,0,0,if aD then k else j),
})

if aD then
al(aG,"position")
if aF>0 then
aG.Position=x
end
aG.Visible=true
am(aG,"position",aF,{Position=w})
else
am(aG,"position",aF,{Position=x},function()
if not aC.activePage or not aC.activePage.paged then
aG.Visible=false
end
end)
end end


Y.selectPage=function(aC, aD)
local aE=aC.pages[aD]
if not aE then return false end
if aC.activePage==aE then return true end

local aF=aC.activePage
local aG=aF==nil
local aH=if aG then 0 elseif aE.order>aF.order then 1 else-1

aC.activePage=aE
aC.pageId=aD

aB(aC.thumb,aE.order,if aG then 0 else b:getScale(I))
aC:setPaged(aE.paged,aG)
aC:transitionTo(aE,aE.index,aH)
return true end


Y.create=function(aC)
local aD=aa.new("Frame","ReferenceFrame",{
Active=true,
BorderSizePixel=0,
Position=R,
Size=UDim2.fromOffset(f,m),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local aE=aa.new("Frame","TopBar",aD,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,g),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",aE,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text="Reference",
TextSize=16,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local aF=aa.new("TextButton","Close",aE,{
BackgroundTransparency=1,
Position=UDim2.new(1,-g,0,0),
Size=UDim2.fromOffset(g,g),
Text="",
})

local aG=aa.new("ImageLabel","Icon",aF,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(10,10),
ThemeTag={
ImageColor3="Colors.Icons",
},
})


local aH=aa.new("Frame","Tabs",aD,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,g),
Size=UDim2.new(1,0,0,h),
})

local aI=aa.new("Frame","Track",aH,{
BorderSizePixel=0,
Position=UDim2.fromOffset(i,i),
Size=UDim2.new(1,-i*2,1,-i*2),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
aa.new("UICorner",{CornerRadius=Q}),
})

local aJ=aa.new("Frame","Thumb",aI,{
BorderSizePixel=0,
Size=UDim2.new(1/X,0,1,0),
ThemeTag={
BackgroundColor3="Colors.Border.Holding",
},
aa.new("UICorner",{CornerRadius=Q}),
})
aC.thumb=aJ

local _=ae.new({
isHorizontal=false,
barThickness=n,
increment=o,
wheelIncrement=p,
})

local aK=_:create()
local aL=_.container

local aM=aa.new("Frame","ScrollHolder",aD,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,g+h),
Size=UDim2.new(1,0,0,j),

aK,
aL,
})


local aN=aa.new("Frame","Footer",aD,{
BackgroundTransparency=1,
ClipsDescendants=true,
Position=UDim2.fromOffset(0,g+h+k),
Size=UDim2.new(1,0,0,l),
})


local aO=aa.new("Frame","Navigation",aN,{
BackgroundTransparency=1,
Position=x,
Size=UDim2.new(1,0,1,0),
Visible=false,
aa.new("UIPadding",{PaddingRight=UDim.new(0,v)}),
aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,s),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local aP=ay(aO,"Back",c.navigation.back,"lucide-arrow-left",true,1)

local aQ=aa.new("TextLabel","Counter",aO,{
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
LayoutOrder=2,
Size=UDim2.new(0,0,0,q),
Text="1 / 1",
TextSize=u,
ThemeTag={
Font="Font.Medium",
TextColor3="Colors.Text.Dark",
},
})

local aR=ay(aO,"Next",c.navigation.next,"lucide-arrow-right",false,3)

for aS,aT in{aP,aR}do
ag:Connect(aT.button.MouseEnter,function()
aA(aT,true)
end)
ag:Connect(aT.button.MouseLeave,function()
aA(aT,false)
end)
end

aC.scrollBar=_
aC.container=aL
aC.holder=aM
aC.footer=aN
aC.navigation=aO
aC.counter=aQ
aC.nav={back=aP,forward=aR}local aS=function(



aS, aT, aU)
local aV=aa.new("Frame","Slide",aL,{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Visible=false,
})
aT.Parent=aV

local aW={slide=aV,body=aT,loaders=aU}
table.insert(aS.entries,aW)

ag:Connect(aT:GetPropertyChangedSignal("AbsoluteSize"),function()
if aC.activeEntry==aW then
aC:refreshScroll()
end
end)end




for aT,aU in W do
local aV=aa.new("TextButton",aU.id,aI,{
AutoButtonColor=false,
BackgroundTransparency=1,
BorderSizePixel=0,
Position=UDim2.new((aT-1)/X,0,0,0),
Size=UDim2.new(1/X,0,1,0),
Text=aU.title,
TextSize=13,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local aW=aU.paged==true
local aX={
id=aU.id,
order=aT,
button=aV,
paged=aW,
entries={},
index=1,
}

if aW then
for aY,aZ in aU.sections do
local a_={}
aS(aX,ax(aY,aZ,true,a_),a_)
end
else
local aY={}
local aZ=aa.new("Frame","Content",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder}),
})

for a_,a0 in aU.sections do
local a1=ax(a_,a0,a_==#aU.sections,aY)
a1.Parent=aZ
end

aS(aX,aZ,aY)
end

aC.pages[aU.id]=aX

ag:Connect(aV.Activated,function()
aC:selectPage(aU.id)
end)
end

ag:Connect(aP.button.Activated,function()
aC:turnPage(-1)
end)
ag:Connect(aR.button.Activated,function()
aC:turnPage(1)
end)local aT=function(


aT)
if aC.activeEntry then
aC.activeEntry.body.Position=UDim2.fromOffset(0,-aT)
end end


ag:Connect(_.scrolledSignal,aT)
ag:Connect(aL:GetPropertyChangedSignal("AbsoluteSize"),function()
aC:refreshScroll()
end)

ag:Connect(aF.Activated,function()
aC:close()
end)

ad:addGuiObject(aD)

ad.dragStarted:Connect(function(aU)
if aU~=aD then return end
_:disableScroll()
end)

ad.dragEnded:Connect(function(aU)
if aU~=aD then return end
_:enableScroll()
end)

aC:selectPage(W[1].id)

aC.frame=aD
aC.closeIcon=aG

return aD end


return Y end a.dt=function()local ab=a.cache.dt if not ab then ab={c=aa()}a.cache.dt=ab end return ab.c end end do local aa=function()



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
}end a.du=function()local ab=a.cache.du if not ab then ab={c=aa()}a.cache.du=ab end return ab.c end end do local aa=function()


local aa=a.cT()
local ab=a.cV()
local ac=a.cS()

local ad=a.dn()
local ae=a.c_()

local af=a.cR()

local ag=a.cW()
local ah=a.aE()
local ai=a.a()
local aj=a.g()
local ak=a.f()
local al=a.b()

local am=a.du()
local an=a.cZ()

local ao=UDim2.new(0.5,-am.window.width/2,0,am.window.shownY)
local ap=UDim2.new(0.5,-am.window.width/2,0,am.window.hiddenY)

local aq={}local ar=function(

ar)
return an:apply(ar)end local as=function(


as, at)
return`{af.escapeRichText(as)}{ar(at)}`end local at=function(


at)
if at==nil then return false end

if ai.setclipboard then
ai.setclipboard(tostring(at))
return true
end

ae:notify(am.messages.noClipboard)
return false end local au=function(


au)
local av=am.time
local aw=math.floor(au/3600)
local ax=math.floor((au%3600)/60)
local ay=math.floor(au%60)

if aw>0 then
return`{aw} {av.hour}, {ax} {av.minute}, {ay} {av.second}`
elseif ax>0 then
return`{ax} {av.minute}, {ay} {av.second}`
end

return`{ay} {av.second}`end local av=function()



local av,aw=pcall(function()
return ak.MarketplaceService:GetProductInfo(game.PlaceId)
end)

if av and aw then
return aw.Name
end

return am.messages.unknownPlace end local aw=function(


aw, ax)
local ay=am.copyButton

local az=aa.new("TextButton","Copy",aw,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-am.window.textInset,0.5,0),
Size=UDim2.fromOffset(ay.width,ay.height),
Text=ay.idleText,
TextSize=am.textSizes.copyButton,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ay.cornerRadius),
}),
})

ah:Connect(az.MouseEnter,function()
ac:updateObjectProperties(az,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

ah:Connect(az.MouseLeave,function()
ac:updateObjectProperties(az,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

ah:Connect(az.Activated,function()
if not at(ax())then return end

az.Text=ay.copiedText
task.wait(ay.feedbackTime)
az.Text=ay.idleText
end)

return az end local ax=function(


ax, ay, az, aA)
local aB=am.window
local aC=aB.textInset
local aD=0

if aA.getCopyValue then
aD=am.copyButton.width+am.copyButton.gap
end

local aE=aa.new("Frame","Row",ax,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=(ay%2==1)and aB.stripeTransparency or 1,
BorderSizePixel=0,
LayoutOrder=ay,
Size=UDim2.new(1,0,0,aB.rowHeight),
})

local aF=aa.new("TextLabel",aA.name,aE,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(aC,0),
RichText=true,
Size=UDim2.new(1,-(aC*2+aD),1,0),
Text=az,
TextSize=aA.textSize,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=aA.textColor,
},
})

if aA.getCopyValue then
aw(aE,aA.getCopyValue)
end

return aF end local ay=function(


ay, az, aA)
return ax(ay,az,`<b>{af.escapeRichText(aA)}</b>`,{
name="Section",
textSize=am.textSizes.section,
textColor="Colors.Text.Darker",
})end local az=function(


az, aA, aB, aC)
return ax(az,aA,aB,{
name="Value",
textSize=am.textSizes.value,
textColor="Colors.Text.Default",
getCopyValue=aC,
})end local aA=function()



local aA=am.window

local aB={
labels={},
placeName=nil,
}

local aC=aa.new("Frame","ServerInfo",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=ap,
Size=UDim2.fromOffset(aA.width,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local aD=aa.new("Frame","TopBar",aC,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,aA.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",aD,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=aA.title,
TextSize=am.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local aE=aa.new("ImageButton","Exit",aD,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-aA.closeInset,0.5,0),
Size=UDim2.fromOffset(aA.closeIconSize,aA.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(aE,"close")

ah:Connect(aE.Activated,function()
aq:close()
end)

local aF=aa.new("Frame","Body",aC,{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
LayoutOrder=2,
Size=UDim2.new(1,0,0,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},

aa.new("UIPadding",{
PaddingBottom=UDim.new(0,aA.verticalPadding),
PaddingTop=UDim.new(0,aA.verticalPadding),
}),

aa.new("UIListLayout",{
Padding=UDim.new(0,aA.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local aG=aB.labels
local aH=am.labels
local aI=am.messages.loading

local aJ=0 local aK=function()

aJ=aJ+1
return aJ end


ay(aF,aK(),am.headers.localPlayer)

aG.playerId=az(aF,aK(),as(aH.playerId,aj.UserId),function()
return aj.UserId
end)

aG.appearance=az(aF,aK(),as(aH.appearance,aj.CharacterAppearanceId),function()
return aj.CharacterAppearanceId
end)

ay(aF,aK(),am.headers.runTime)
aG.time=az(aF,aK(),ar(aI))

ay(aF,aK(),am.headers.statistics)
aG.players=az(aF,aK(),as(aH.players,aI))
aG.maxPlayers=az(aF,aK(),as(aH.maxPlayers,aI))

aG.placeId=az(aF,aK(),as(aH.placeId,game.PlaceId),function()
return game.PlaceId
end)

aG.gameId=az(aF,aK(),as(aH.gameId,game.GameId),function()
return game.GameId
end)

aG.placeName=az(aF,aK(),as(aH.placeName,aI),function()
return aB.placeName
end)

ad:addGuiObject(aC)

aB.frame=aC
return aB end local aB=function(


aB)
local aC=aB.labels
local aD=am.labels
local aE=ak.Players

while aq.window==aB do
aC.players.Text=as(aD.players,#aE:GetPlayers())
aC.maxPlayers.Text=as(aD.maxPlayers,aE.MaxPlayers)
aC.time.Text=ar(au(workspace.DistributedGameTime))

task.wait(am.window.updateInterval)
end end


aq.create=function(aC)
if aC.isEnabled then
ae:notify(am.messages.alreadyEnabled)
return
end

aC.isEnabled=true

local aD=aA()
aC.window=aD

local aE=am.window.tweenTime

aD.frame.Parent=al.screenGui
aD.frame:TweenPosition(ao,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,aE,true)

task.spawn(function()
aD.placeName=av()
aD.labels.placeName.Text=as(am.labels.placeName,aD.placeName)
end)

task.spawn(aB,aD)

return aD end


aq.close=function(aC)
local aD=aC.window
if not aD then return end

local aE=am.window.tweenTime

aC.window=nil
aC.isEnabled=false

aD.frame:TweenPosition(ap,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,aE,true)

task.delay(aE,function()
aD.frame:Destroy()
end)end


return aq end a.dv=function()local ab=a.cache.dv if not ab then ab={c=aa()}a.cache.dv=ab end return ab.c end end do local aa=function()


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
tabInset=0,
stripeTransparency=0.96,
entryHoverTransparency=0.88,
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
tab=13,
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


copied="Copied",
chatCopied="Message copied to the clipboard",
joinCopied="User ID copied to the clipboard:",
noClipboard="Your executor has no clipboard function",
},
}end a.dw=function()local ab=a.cache.dw if not ab then ab={c=aa()}a.cache.dw=ab end return ab.c end end do local aa=function()



local aa=a.cT()
local ab=a.cV()
local ac=a.cS()
local ad=a.dn()
local ae=a.cW()
local af=a.dj()
local ag=a.c_()

local ah=a.b()
local ai=a.dw()
local aj=a.f()
local ak=a.a()
local al=a.cJ()
local am=a.bJ()
local an=a.cY().args
local ao=a.cZ()
local ap=a.cR()
local aq=a.n()

local ar=ai.window
local as=ar.topBarHeight
local at=as+ar.rowHeight
local au=UDim2.new(0,ar.shownX,0,ar.shownY)
local av=UDim2.new(0,ar.hiddenX,0,ar.shownY)


local aw,ax=0,0.125
local ay,az=0.125,0.125
local aA,aB=0.25,0.25
local aC,aD=0.5,0.5


local aE=0.5
local aF={chat=0,join=0.5}
local aG=ar.tabInset
local aH=UDim.new(0.5,0)


local aI=ar.entryHoverTransparency

local aJ={
window=nil,
listening=false,
}local aK=function(


aK, aL, aM)
local aN=ar.buttonInset
aK.Position=UDim2.new(aL,aN,0,aN)
aK.Size=UDim2.new(aM,-aN*2,1,-aN*2)end local aL=function(



aL, aM)
ac:updateObjectProperties(aL,{BackgroundColor3=aM})end local aM=function(


aM)
return am[if aM=="chat"then"chatEnabled"else"joinEnabled"]end local aN=function(


aN, aO)
aq:setValue(`chatlogs.{aN}.enabled`,aO==true)
aq:save()end local aO=function(


aO, aP)
aP(aq:getValue(`chatlogs.{aO}.enabled`)==true)end local aP=function(


aP, aQ)
local aR=ap.colorFromRGB(`[{aQ.time}]`,an.comment)
local aS=`<b>{ap.colorFromRGB(ap.escapeRichText(aQ.name),aQ.color or an.others)}</b>`

if aP=="chat"then
return`{aR} {aS}: {ao:apply(aQ.message)}`
end
return`{aR} {aS} {ao:apply(`joined (id {aQ.userId})`)}`end local aQ=function(



aQ, aR)
if aQ=="chat"then
return tostring(aR.message)
end
return tostring(aR.userId)end local aR=function(


aR, aS)
if not ak.setclipboard then
ag:notify(ai.messages.copied,ai.messages.noClipboard)
return
end

local aT=aQ(aR,aS)
ak.setclipboard(aT)

if aR=="chat"then
ag:notify(ai.messages.copied,ai.messages.chatCopied)
else
ag:notify(ai.messages.copied,`{ai.messages.joinCopied} {aT}`)
end end local aS=function(


aS, aT)
return aS.tabButtons[aS.tab]==aT end local aT=function(


aT)
for aU,aV in aT.tweens do
aV:Cancel()
end
table.clear(aT.tweens)end local aU=function(



aU, aV)
aT(aU)

local aW=UDim2.new(aF[aU.tab],aG,0,aG)
local aX=al:getScale(ar.tabTweenTime)
if not aV or aX<=0 then
aU.thumb.Position=aW
return
end

local aY=TweenInfo.new(aX,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
local aZ=aj.TweenService:Create(aU.thumb,aY,{
Position=aW,
})
table.insert(aU.tweens,aZ)
aZ:Play()end local aV=function(


aV)
local aW=aM(aV.tab)
aV.toggle.Text=if aW then ai.controls.enabled else ai.controls.disabled
aL(aV.toggle,if aW then"Colors.OnPrimary"else"Colors.Buttons.Default")

for aX,aY in aV.actions do
aL(aY,"Colors.Buttons.Default")
end


for aX,aY in aV.tabButtons do
aY.BackgroundTransparency=1
end end local aW=function(


aW)
for aX,aY in aW.connections do
aY:Disconnect()
end
table.clear(aW.connections)end local aX=function(


aX, aY, aZ)
table.insert(aX.connections,aY:Connect(aZ))end local aY=function(


aY, aZ)
aX(aY,aZ.MouseEnter,function()
if not aS(aY,aZ)then
aL(aZ,"Colors.Buttons.Holding")
aZ.BackgroundTransparency=0
end
end)

aX(aY,aZ.MouseLeave,function()
aV(aY)
end)end local aZ=function(


aZ, a_, a0, a1, b)
local c=aa.new("TextButton",a_,aZ,{
AutoButtonColor=false,
BorderSizePixel=0,
Text=a0,
TextSize=ai.textSizes.control,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ar.buttonCorner),
}),
})

aK(c,a1,b)
return c end local a_=function(



a_, a0)
a_.Position=UDim2.new(a0,aG,0,aG)
a_.Size=UDim2.new(aE,-aG*2,1,-aG*2)end local a0=function(



a0, a1, b, c)
local d=aa.new("TextButton",a1,a0,{
AutoButtonColor=false,
BackgroundTransparency=1,
BorderSizePixel=0,
Text=b,
TextSize=ai.textSizes.tab,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=aH,
}),
})

a_(d,c)
return d end local a1=function(


a1)
a1.content.Position=UDim2.fromOffset(0,-a1.scrollBar.index)end local b=function(


b)
local c=ae:getScale()
b.scrollBar:setTotalSpace(math.ceil(b.content.AbsoluteSize.Y/c))
b.scrollBar:setVisibleSpace(math.ceil(b.container.AbsoluteSize.Y/c))
a1(b)end local c=function(


c)
for d,e in c.labels do
e:Destroy()
end
table.clear(c.labels)end local d=function(


d, e, f)
d.order=d.order+1

local g=if d.order%2==1 then ar.stripeTransparency else 1

local h=aa.new("TextButton","Entry",d.content,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=g,
BorderSizePixel=0,
LayoutOrder=d.order,
Size=UDim2.new(1,0,0,0),
RichText=true,
Text=aP(e,f),
TextSize=ai.textSizes.entry,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})


h.MouseEnter:Connect(function()
h.BackgroundTransparency=aI
end)
h.MouseLeave:Connect(function()
h.BackgroundTransparency=g
end)
h.Activated:Connect(function()
aR(e,f)
end)

table.insert(d.labels,h)
while#d.labels>ai.maxLabels do
table.remove(d.labels,1):Destroy()
end


task.defer(function()
if d.frame.Parent then
b(d)
d.scrollBar:scrollTo(math.huge)
end
end)end local e=function(


e, f)
c(e)

for g,h in am.entries[e.tab]do
d(e,e.tab,h)
end

aV(e)
aU(e,f==true)end local f=function(


f)
local g={
tab=f,
labels={},
order=0,
connections={},
tweens={},
}

local h=aa.new("Frame","ChatLogs",{
Active=true,
BorderSizePixel=0,
Position=av,
Size=UDim2.fromOffset(ar.width,ar.height),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})
g.frame=h


local i=aa.new("Frame","TopBar",h,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,as),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",i,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=ai.title,
TextSize=ai.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local j=aa.new("TextButton","Close",i,{
BackgroundTransparency=1,
Position=UDim2.new(1,-as,0,0),
Size=UDim2.fromOffset(as,as),
Text="",
})

local k=aa.new("ImageLabel","Icon",j,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(ar.closeIconSize,ar.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})
ab:loadImage(k,"close")


local l=aa.new("Frame","Controls",h,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,as),
Size=UDim2.new(1,0,0,ar.rowHeight),
})

local m=aZ(l,"Clear",ai.controls.clear,aw,ax)
local n=aZ(l,"Save",ai.controls.save,ay,az)
g.toggle=aZ(l,"Toggle",ai.controls.enabled,aA,aB)


local o=aa.new("Frame","Switch",l,{
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=aH,
}),
})
aK(o,aC,aD)

g.thumb=aa.new("Frame","Thumb",o,{
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Border.Holding",
},

aa.new("UICorner",{
CornerRadius=aH,
}),
})
a_(g.thumb,aF.chat)

local p=a0(o,"ChatTab",ai.tabs.chat,aF.chat)
local q=a0(o,"JoinTab",ai.tabs.join,aF.join)

g.tabButtons={chat=p,join=q}
g.actions={n,m}


local r=af.new({
isHorizontal=false,
barThickness=ai.scrollBar.barThickness,
increment=ai.scrollBar.increment,
wheelIncrement=ai.scrollBar.wheelIncrement,
})
local s=r:create()
local t=r.container

local u=aa.new("Frame","Content",t,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

aa.new("Frame","ScrollHolder",h,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,at),
Size=UDim2.new(1,0,1,-at),

s,
t,
})

g.scrollBar=r
g.container=t
g.content=u

aX(g,r.scrolledSignal,function()
a1(g)
end)
aX(g,u:GetPropertyChangedSignal("AbsoluteSize"),function()
b(g)
end)
aX(g,t:GetPropertyChangedSignal("AbsoluteSize"),function()
b(g)
end)
aX(g,ad.dragStarted,function(v)
if v==h then
r:disableScroll()
end
end)
aX(g,ad.dragEnded,function(v)
if v==h then
r:enableScroll()
end
end)

aX(g,j.Activated,function()
aJ:close()
end)

aX(g,p.Activated,function()
aJ:select("chat")
end)

aX(g,q.Activated,function()
aJ:select("join")
end)

aX(g,g.toggle.Activated,function()
local v=aM(g.tab)
if g.tab=="chat"then
am.setChat(not v)
else
am.setJoin(not v)
end

aN(g.tab,not v)
aV(g)
end)

aX(g,n.Activated,function()
local v,w=am.save(g.tab)
if v then
ag:notify(ai.messages.saved,w)
else
ag:notify(ai.messages.saveFailed,w)
end
end)

aX(g,m.Activated,function()
am.clear(g.tab)
c(g)
end)

for v,w in{p,q,g.toggle,n,m}do
aY(g,w)
end

return g end local g=function()




if aJ.listening then
return
end
aJ.listening=true

am.onEntry(function(g,h)
local i=aJ.window
if i and i.tab==g then
d(i,g,h)
end
end)end


aJ.restore=function(h)
aO("chat",am.setChat)
aO("join",am.setJoin)end


aJ.open=function(h, i)
h:restore()

g()

local j=h.window
if j then
h:select(i)
return j
end

j=f(i)
h.window=j

j.frame.Parent=ah.screenGui
j.frame:TweenPosition(au,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,ar.tweenTime,true)
ad:addGuiObject(j.frame)

e(j)
return j end


aJ.select=function(h, i)
local j=h.window
if not j then
return
end

j.tab=i
e(j,true)end


aJ.close=function(h)
local i=h.window
if not i then
return
end

h.window=nil
aW(i)
aT(i)

i.frame:TweenPosition(av,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,ar.tweenTime,true)
task.delay(ar.tweenTime,function()
i.frame:Destroy()
end)end



aJ.reset=function(h)
local i=h.window
if i then
aW(i)
aT(i)
end
h.window=nil end


return aJ end a.dx=function()local ab=a.cache.dx if not ab then ab={c=aa()}a.cache.dx=ab end return ab.c end end do local aa=function()







local aa=a.cT()
local ab=a.cV()
local ac=a.cS()
local ad=a.aH()
local ae=a.f()
local af=a.di()
local ag=a.cW()
local ah=a.db()

local ai=ah.panel
local aj=ah.row
local ak=ah.box
local al=ah.value
local am=ah.textSizes
local an=ah.badge
local ao=ah.slider

local ap={}local aq=function(


aq, ar, as)
ac:updateObjectProperties(aq,{
BackgroundColor3=if as then"Colors.Buttons.Holding"else"Colors.Buttons.Default",
})
aq.BackgroundTransparency=if as then 0 else ar end




ap.page=function(ar, as, at)
return aa.new("ScrollingFrame",as,ar,{
Active=true,
AutomaticCanvasSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
CanvasSize=UDim2.new(),
ElasticBehavior=Enum.ElasticBehavior.Never,
Position=at,
ScrollBarThickness=ai.scrollBarThickness,
ScrollingDirection=Enum.ScrollingDirection.Y,
Size=UDim2.fromScale(1,1),
ThemeTag={
ScrollBarImageColor3="Colors.Primary",
},

aa.new("UIPadding",{
PaddingLeft=UDim.new(0,ai.padding),
PaddingRight=UDim.new(0,ai.padding),
PaddingTop=UDim.new(0,ai.padding),
PaddingBottom=UDim.new(0,ai.padding),
}),
aa.new("UIListLayout",{
Padding=UDim.new(0,ai.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})end local ar=function(



ar)
ac:removeObject(ar)

for as,at in ar:GetDescendants()do
ac:removeObject(at)
end end



ap.clear=function(as)
for at,au in as:GetChildren()do
if not(au:IsA("UIListLayout")or au:IsA("UIPadding"))then
ar(au)
au:Destroy()
end
end end



ap.list=function(as)
return{parent=as,order=0,index=0}end



ap.group=function(as)
as.order=as.order+1

return aa.new("Frame","Group",as.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=as.order,
Size=UDim2.new(1,0,0,0),

aa.new("UIListLayout",{
Padding=UDim.new(0,ai.rowGap),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})end


ap.header=function(as, at)
as.order=as.order+1
as.index=0

return aa.new("TextLabel","Header",as.parent,{
BackgroundTransparency=1,
LayoutOrder=as.order,
Size=UDim2.new(1,0,0,ai.headerHeight),
Text=at,
TextSize=am.header,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})end



ap.row=function(as)
as.order=as.order+1
as.index=as.index+1

local at=if as.index%2==1 then ai.stripeTransparency else 1

local au=aa.new("TextButton","Option",as.parent,{
AutoButtonColor=false,
BackgroundTransparency=at,
BorderSizePixel=0,
LayoutOrder=as.order,
Size=UDim2.new(1,0,0,ai.rowHeight),
Text="",
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})


au.MouseEnter:Connect(function()
aq(au,at,true)
end)

au.MouseLeave:Connect(function()
aq(au,at,false)
end)

return au end



ap.pageTop=function(as, at, au)
local av=ap.row(as)
av.Name="BackRow"
ap.icon(av,ah.pages.backIcon)
ap.label(av,ah.pages.back,0)
av.Activated:Connect(au)

if at then
ap.header(as,at)
end end



ap.label=function(as, at, au, av)
return aa.new("TextLabel","Label",as,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(aj.labelInset,0),
Size=UDim2.new(1,-(aj.labelInset+au),1,0),
Text=at,
TextSize=am.label,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Normal",
TextColor3=av or"Colors.Text.Default",
},
})end


ap.icon=function(as, at)
local au=aa.new("ImageLabel","Icon",as,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,aj.iconInset,0.5,0),
Size=UDim2.fromOffset(aj.iconSize,aj.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(au,at)
return au end



ap.chevron=function(as)
local at=aa.new("ImageLabel","Chevron",as,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-ai.padding,0.5,0),
Rotation=180,
Size=UDim2.fromOffset(aj.chevronSize,aj.chevronSize),
ThemeTag={
ImageColor3="Colors.Text.Darker",
},
})

ab:loadImage(at,ah.pages.backIcon)
return at end






ap.rowButton=function(as, at, au, av)
local aw=aa.new("TextButton","RowButton",as,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-au,0.5,0),
Size=UDim2.fromOffset(av,al.height+4),
Text=at,
TextSize=am.value,
ThemeTag={
BackgroundColor3="Colors.Background",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

aw.MouseEnter:Connect(function()
ac:updateObjectProperties(aw,{
BackgroundColor3="Colors.Primary",
})
end)

aw.MouseLeave:Connect(function()
ac:updateObjectProperties(aw,{
BackgroundColor3="Colors.Background",
})
end)

return aw end



ap.box=function(as)
local at=aa.new("Frame","Box",as,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(ak.size,ak.size),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ak.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Thickness=1,
ThemeTag={
Color="Colors.Border.Default",
},
}),
})

local au=aa.new("Frame","Fill",at,{
BorderSizePixel=0,
Position=UDim2.fromOffset(ak.inset,ak.inset),
Size=UDim2.new(1,-2*ak.inset,1,-2*ak.inset),
ThemeTag={
BackgroundColor3="Colors.Primary",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ak.fillCornerRadius),
}),
})

return at,au end



ap.value=function(as, at, au)
local av=aa.new("Frame","Value",as,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(au,al.height),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

local aw=aa.new("TextLabel","Text",av,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=at,
TextSize=am.value,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

return av,aw end



ap.valueInput=function(as, at, au)
return aa.new("TextBox","ValueInput",as,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
ClearTextOnFocus=false,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(au,al.height),
Text=at,
TextSize=am.value,
TextXAlignment=Enum.TextXAlignment.Center,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})end






ap.slider=function(as, at, au, av)
ap.label(as,at,ao.width+ao.valueWidth+ai.rowGap+ai.padding)

local aw=aa.new("TextButton","Track",as,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BackgroundTransparency=1,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(ao.width,ao.hitHeight),
Text="",
})

local ax=aa.new("Frame","Bar",aw,{
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Position=UDim2.fromScale(0,0.5),
Size=UDim2.new(1,0,0,ao.barHeight),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ao.barHeight/2),
}),
})

local ay=aa.new("Frame","Fill",ax,{
BorderSizePixel=0,
Size=UDim2.fromScale(0,1),
ThemeTag={
BackgroundColor3="Colors.Primary",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ao.barHeight/2),
}),
})

local az=aa.new("Frame","Knob",aw,{
AnchorPoint=Vector2.new(0.5,0.5),
BorderSizePixel=0,
Position=UDim2.fromScale(0,0.5),
Size=UDim2.fromOffset(ao.knobSize,ao.knobSize),
ThemeTag={
BackgroundColor3="Colors.Icons",
},

aa.new("UICorner",{
CornerRadius=UDim.new(1,0),
}),
})

local aA=aa.new("TextLabel","Value",as,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-(ai.padding+ao.width+ai.rowGap),0.5,0),
Size=UDim2.fromOffset(ao.valueWidth,al.height),
Text="",
TextSize=am.value,
TextXAlignment=Enum.TextXAlignment.Right,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})local aB=function(


aB)
ay.Size=UDim2.fromScale(aB,1)
az.Position=UDim2.fromScale(aB,0.5)
aA.Text=`{math.round(aB*100)}%`end


aB(math.clamp(au,0,1))


local aC local aD=function()


local aD=aC
if aD==nil then return end

aC=nil
aD.moved:Disconnect()
aD.released:Disconnect()

if aD.scroller then
aD.scroller.ScrollingEnabled=aD.wasScrolling
end end local aE=function(


aE)
local aF=aC
if aF==nil or aF.width<=0 then return end



local aG=(aE-aF.left)/aF.scale
local aH=aF.width/aF.scale

local aI=math.clamp(aG/aH,0,1)

aB(aI)
av(aI)end


aw.InputBegan:Connect(function(aF)
if aC~=nil or not af.isPressingInput(aF)then return end


local aG=aw:FindFirstAncestorWhichIsA("ScrollingFrame")

aC={
scale=ag:getScale(),
left=aw.AbsolutePosition.X,
width=aw.AbsoluteSize.X,
scroller=aG,
wasScrolling=if aG then aG.ScrollingEnabled else false,
}

if aG then
aG.ScrollingEnabled=false
end

aC.moved=ae.UserInputService.InputChanged:Connect(function(aH)
if not af.isMovingInput(aH)then return end


if aw.Parent==nil then
aD()
return
end

aE(aH.Position.X)
end)

aC.released=ae.UserInputService.InputEnded:Connect(function(aH)
if af.isPressingInput(aH)then
aD()
end
end)

aE(aF.Position.X)
end)end





ap.keybind=function(as, at, au)
local av,aw=ap.value(as,"",al.keybindWidth)
local ax local ay=function()


local ay=ax~=nil

aw.Text=if ay then"press a key"else ad:getBindingName(at)
ac:updateObjectProperties(av,{
BackgroundColor3=if ay then"Colors.Primary"else"Colors.Buttons.Default",
})end local az=function()



if ax then
local az=ax
ax=nil
az()
end

ay()end


as.Activated:Connect(function()
if ax then
az()
return
end

ax=ad:capture(function(aA)
ax=nil
ad:setBinding(at,aA)
ay()

if au then
au()
end
end,function()

ax=nil
ay()
end)

ay()
end)

ay()
return ay,az end



ap.textBox=function(as, at)
as.order=as.order+1

return aa.new("TextBox","Input",as.parent,{
BorderSizePixel=0,
ClearTextOnFocus=false,
LayoutOrder=as.order,
PlaceholderText=at,
Size=UDim2.new(1,0,0,ai.rowHeight),
Text="",
TextSize=am.value,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
PlaceholderColor3="Colors.Text.Darker",
TextColor3="Colors.Text.Default",
},

aa.new("UIPadding",{
PaddingLeft=UDim.new(0,aj.labelInset/2),
PaddingRight=UDim.new(0,ai.padding),
}),
aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})end local as=function(



as)
return aa.new("TextLabel","Badge",as,{
AnchorPoint=Vector2.new(1,0),
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
Position=UDim2.new(1,an.overhang,0,-an.overhang),
Size=UDim2.fromOffset(0,an.height),
Text="",
TextSize=am.badge,
Visible=false,
ZIndex=as.ZIndex+1,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,an.height/2),
}),
aa.new("UIPadding",{
PaddingLeft=UDim.new(0,3),
PaddingRight=UDim.new(0,3),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Thickness=1,
ThemeTag={
Color="Colors.Background",
},
}),
})end





ap.choices=function(at, au, av, aw)
at.order=at.order+1

local ax=ai.rowGap
local ay=aa.new("Frame","Choices",at.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=at.order,
Size=UDim2.new(1,0,0,0),

aa.new("UIGridLayout",{
CellPadding=UDim2.fromOffset(ax,ax),
CellSize=UDim2.new(1/aw,-ax*(aw-1)/aw-1,0,ai.rowHeight-3),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local az={}
local aA={}local aB=function(

aB)
for aC,aD in az do
ac:updateObjectProperties(aD,{
BackgroundColor3=if aC==aB then"Colors.Primary"else"Colors.Buttons.Default",
})
end end


for aC,aD in au do
local aE=aa.new("TextButton","Choice",ay,{
AutoButtonColor=false,
BorderSizePixel=0,
LayoutOrder=aC,
Text=aD,
TextSize=am.value,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

az[aC]=aE
aA[aC]=as(aE)

aE.Activated:Connect(function()
aB(aC)
av(aC)
end)
end local aC=function(


aC, aD)
local aE=aA[aC]
if not aE then return end

aE.Text=tostring(aD)
aE.Visible=aD>0 end


return aB,aC end



ap.inputRow=function(at, au, av, aw)
local ax=ap.row(at)
ap.label(ax,au,al.inputWidth+2*ai.padding)

local ay=aa.new("TextBox","Input",ax,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
ClearTextOnFocus=false,
PlaceholderText=av,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(al.inputWidth,al.height),
Text=aw or"",
TextSize=am.value,
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
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

return ax,ay end




ap.formRow=function(at, au, av, aw, ax)
at.order=at.order+1

local ay=ai.rowGap
local az=al.addWidth
local aA=ax or al.formDelayWidth

local aB=aa.new("Frame","Form",at.parent,{
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=at.order,
Size=UDim2.new(1,0,0,ai.rowHeight),
})local aC=function(

aC, aD, aE, aF, aG)
return aa.new("TextBox",aC,aB,{
AnchorPoint=aE,
BorderSizePixel=0,
ClearTextOnFocus=false,
PlaceholderText=aD,
Position=aF,
Size=aG,
Text="",
TextSize=am.value,
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
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})end


local aD=aC("Command",au,Vector2.zero,UDim2.fromOffset(0,0),
UDim2.new(1,-(az+aA+2*ay),1,0))
local aE=aC("Delay",av,Vector2.new(1,0),UDim2.new(1,-(az+ay),0,0),
UDim2.new(0,aA,1,0))

local aF=aa.new("TextButton","Add",aB,{
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.fromScale(1,0),
Size=UDim2.new(0,az,1,0),
Text=aw,
TextSize=am.label,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

return aD,aE,aF end




ap.footer=function(at, au)
at.order=at.order+1

return aa.new("TextLabel","Footer",at.parent,{
BackgroundTransparency=1,
LayoutOrder=at.order,
Size=UDim2.new(1,0,0,ai.headerHeight),
Text=au,
TextSize=am.footer,
TextXAlignment=Enum.TextXAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})end



ap.note=function(at, au)
at.order=at.order+1

return aa.new("TextLabel","Note",at.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=at.order,
Size=UDim2.new(1,0,0,0),
Text=au,
TextSize=am.value,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},


aa.new("UIPadding",{
PaddingLeft=UDim.new(0,aj.labelInset),
}),
})end


return ap end a.dy=function()local ab=a.cache.dy if not ab then ab={c=aa()}a.cache.dy=ab end return ab.c end end do local aa=function()







local aa=a.dc()
local ab=a.c_()
local ac=a.dy()
local ad=a.db()

local ae=ad.pages.background

local af={}

af.addSection=function(ag)
ac.header(ag,ae.title)

local ah=ac.textBox(ag,ae.urlHint)
ah.Text=aa:getUrl()or""local ai=function(




ai, aj)
local ak=aa:checkUrl(ai)

if ak then
ab:notify(ae.notifyTitle,ak)
return
end

if aa:isDownloading(ai)then
ab:notify(ae.notifyTitle,ae.alreadyDownloading)
return
end

local al=aa:isDownloading()

ab:notify(ae.notifyTitle,if al then ae.downloadReplaced else ae.downloading)

aa:startDownload(ai,aj,{
onSlow=function()
ab:notify(ae.notifyTitle,ae.slow)
end,

onDone=function(am,an)
if am then
ab:notify(ae.notifyTitle,if aj then ae.refreshed else ae.set)
else
ab:notify(ae.notifyTitle,an or ae.downloadFailed)
end
end,
})end


local aj=ac.row(ag)
ac.icon(aj,ae.icons.apply)
ac.label(aj,ae.apply,0)

aj.Activated:Connect(function()
ai(ah.Text,false)
end)

local ak=ac.row(ag)
ac.icon(ak,ae.icons.refresh)
ac.label(ak,ae.refresh,0)

ak.Activated:Connect(function()
local al=aa:getUrl()

if al==nil then
ab:notify(ae.notifyTitle,ae.nothingToRefresh)
return
end

ai(al,true)
end)

local al=ac.row(ag)
ac.icon(al,ae.icons.remove)
ac.label(al,ae.remove,0)

al.Activated:Connect(function()
if aa:getUrl()==nil then
ab:notify(ae.notifyTitle,ae.nothingToRemove)
return
end

local am=aa:clear()
ah.Text=""

ab:notify(ae.notifyTitle,if am then ae.removed else ae.removedKeptFile)
end)

local am=ac.row(ag)
ac.icon(am,ae.icons.opacity)

ac.slider(am,ae.opacity,aa:getOpacity(),function(an)
aa:setOpacity(an)
end)end


return af end a.dz=function()local ab=a.cache.dz if not ab then ab={c=aa()}a.cache.dz=ab end return ab.c end end do local aa=function()










local aa=a.cT()
local ab=a.cS()
local ac=a.n()
local ad=a.db()
local ae=a.dy()
local af=a.dz()

local ag=ad.panel
local ah=ad.box
local ai=ad.textSizes

local aj=14
local ak=20
local al=4 local am=function(


am, an, ao)
am.order=am.order+1

local ap=ab:getPrimaryOptions()

local aq=aa.new("Frame","Primary",am.parent,{
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=am.order,
Size=UDim2.new(1,0,0,ag.rowHeight),
Visible=false,
})

aa.new("TextLabel","Label",aq,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(ad.row.labelInset,0),
Size=UDim2.new(1,-ad.row.labelInset,1,0),
Text=ad.pages.theme.primary,
TextSize=ai.value,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})

local ar={}

for as,at in ap do

local au=#ap-as

local av=aa.new("TextButton","Pick",aq,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BackgroundTransparency=1,
Position=UDim2.new(1,-(ag.padding+au*(ak+al)),0.5,0),
Size=UDim2.fromOffset(ak,ak),
Text="",
})

local aw=aa.new("Frame","Check",av,{
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundColor3=ab:getPrimaryColor(an.theme,at.key),
BackgroundTransparency=1,
BorderSizePixel=0,
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(aj,aj),

aa.new("UICorner",{
CornerRadius=UDim.new(0,ah.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Color=ab:getPrimaryColor(an.theme,at.key),
Thickness=1.5,
}),
})

ar[at.key]=aw

av.Activated:Connect(function()
ao(at.key)
end)
end local as=function()


local as=ab:getPrimaryKey(an.key)

for at,au in ar do
au.BackgroundTransparency=if at==as then 0 else 1
end end


return aq,as end local an=function(


an, ao)
local ap=ae.list(an)
ae.pageTop(ap,ad.pages.theme.title,ao.back)

local aq={}local ar=function()


local ar=ab.selectedKey

for as,at in aq do
local au=ar==at.entry.key

at.fill.Visible=au
at.swatchRow.Visible=au

if au and at.redrawSwatches then
at.redrawSwatches()
end
end end local as=function(


as)
ab:selectTheme(as.key)

ac:setValue(ad.keys.theme,as.key)
ac:save()

ar()end


for at,au in ab:getThemes()do
local av=ae.row(ap)

if au.usable then
ae.label(av,au.name,ah.size+2*ag.padding)
av.Activated:Connect(function()
as(au)
end)
else
ae.label(av,`{au.name} {ad.pages.theme.incomplete}`,ah.size+2*ag.padding,"Colors.Text.Darker")
end

local aw,ax=ae.box(av)

local ay={entry=au,fill=ax}

if au.usable then
local az,aA=am(ap,au,function(az)
ab:setPrimary(au.key,az)
ar()
end)

ay.swatchRow=az
ay.redrawSwatches=aA
else

local az=aa.new("Frame","Primary",ap.parent,{
Visible=false,
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
})

ay.swatchRow=az
end

table.insert(aq,ay)
end

af.addSection(ap)

ar()end


return an end a.dA=function()local ab=a.cache.dA if not ab then ab={c=aa()}a.cache.dA=ab end return ab.c end end do local aa=function()









local aa=a.aH()
local ab=a.aF()
local ac=a.db()
local ad=a.dy()

local ae=ac.panel
local af=ac.value local ag=function(


ag)
local ah={}

for ai,aj in ab.bindings do
if aj.group==ag then
table.insert(ah,ai)
end
end

table.sort(ah)
return ah end local ah=function(



ah)
local ai={}

for aj,ak in ah do
for al,am in ag(ak)do
local an=ab.bindings[am]

for ao,ap in an.also or{}do
local aq=(Enum.KeyCode)[ap]

if aq then
table.insert(ai,string.format(
ac.pages.keybinds.alwaysWorks,
aa:getKeyName(aq),
an.label or am
))
end
end
end
end

return ai end local ai=function(




ai)
return function(aj,ak)
local al=ad.list(aj)
ad.pageTop(al,ai.title,ak.back)

local am={}
local an={}

for ao,ap in ai.groups do
if ap.title then
ad.header(al,ap.title)
end

table.insert(an,ap.key)

for aq,ar in ag(ap.key)do
local as=ab.bindings[ar]
local at=ad.row(al)

ad.label(at,as.label or ar,af.keybindWidth+2*ae.padding)

local au,av=ad.keybind(at,ar)
table.insert(am,au)
table.insert(ak.stoppers,av)
end
end

local ao=ah(an)
if#ao>0 then
ad.note(al,table.concat(ao,"\n"))
end

local ap=ad.row(al)
ad.label(ap,ai.reset,0)

ap.Activated:Connect(function()

for aq,ar in ak.stoppers do
ar()
end

for aq,ar in an do
for as,at in ag(ar)do
aa:resetBinding(at)
end
end

for aq,ar in am do
ar()
end
end)
end end



return{
interface=ai({
title=ac.pages.keybinds.title,
reset=ac.pages.keybinds.reset,
groups={
{key="interface"},
},
}),

commands=ai({
title=ac.pages.commands.title,
reset=ac.pages.commands.reset,
groups=ab.groups,
}),
}end a.dB=function()local ab=a.cache.dB if not ab then ab={c=aa()}a.cache.dB=ab end return ab.c end end do local aa=function()








local aa=a.cS()
local ab=a.c_()
local ac=a.dy()

local ad=a.az()
local ae=a.a()
local af=a.db()
local ag=a.t()
local ah=a.i()

local ai=af.pages.importExport


local aj={"settings","aliases","eventBinds","waypoints"}local ak=function()


local ak={version=ad.version}

for al,am in aj do
ak[am]=ag[am]:getData()
end

return ah.encode(ak,"export")or""end local al=function(



al)
if type(al)~="string"then return false end

for am,an in aa:getThemes()do
if an.key==al:lower()and an.usable then
return true
end
end

return false end local am=function(



am)
if am:match("^%s*$")then
return nil,ai.empty
end

local an=ah.decode(am,"import")
if type(an)~="table"then
return nil,ai.notAnExport
end

local ao={}

for ap,aq in aj do
if type(an[aq])=="table"then
ag[aq]:replaceData(an[aq])
table.insert(ao,aq)
end
end

if#ao==0 then
return nil,ai.notAnExport
end


local ap=ag.settings:getValue(af.keys.theme)
if al(ap)then
aa:selectTheme(ap)
end

return ao end local an=function(


an, ao)
local ap=ac.list(an)
ac.pageTop(ap,ai.title,ao.back)

ac.header(ap,ai.exportTitle)

local aq=ac.row(ap)
ac.label(aq,ai.exportRow,0)

ac.note(ap,ai.exportHint)

ac.header(ap,ai.importTitle)

local ar=ac.textBox(ap,ai.placeholder)
ar.MultiLine=true
ar.TextWrapped=true
ar.TextYAlignment=Enum.TextYAlignment.Top
ar.Size=UDim2.new(1,0,0,96)

local as=ac.row(ap)
ac.label(as,ai.importRow,0)

ac.note(ap,ai.importHint)
ac.note(ap,ai.restartNote)

aq.Activated:Connect(function()
local at=ak()

if ae.setclipboard then
ae.setclipboard(at)
ab:notify(ai.notifyTitle,ai.copied)
else

ar.Text=at
ab:notify(ai.notifyTitle,ai.copyFailed)
end
end)

as.Activated:Connect(function()
local at,au=am(ar.Text)

if at then
ar.Text=""
ab:notify(ai.notifyTitle,string.format(ai.imported,table.concat(at,", ")))
else
ab:notify(ai.notifyTitle,au or ai.notAnExport)
end
end)end


return an end a.dC=function()local ab=a.cache.dC if not ab then ab={c=aa()}a.cache.dC=ab end return ab.c end end do local aa=function()









local aa=a.p()
local ab=a.cx()
local ac=a.cD()
local ad=a.db()
local ae=a.c_()
local af=a.dy()

local ag=ad.panel
local ah=ad.value
local ai=ad.pages.aliases local aj=function(

aj)
return aj:match("^%s*(.-)%s*$")or""end local ak=function(




ak)
return ak:find("[\\%^!,|&\"']")~=nil end local al=function(


al, am)
local an=af.list(al)
af.pageTop(an,ad.pages.aliases.title,am.back)

af.header(an,ai.addTitle)
local ao=af.textBox(an,ai.aliasHint)
local ap=af.textBox(an,ai.commandHint)

local aq=af.row(an)
af.label(aq,ai.addButton,0)

local ar=af.note(an,"")

af.header(an,ai.listTitle)
af.note(an,ai.listHint)

local as=af.group(an)

local at local au=function(


au, av)
ae:ask(ai.undoTitle,string.format(ai.undoMessage,au,av),{
{
text=ai.undo,
primary=true,
onTap=function()
local aw,ax=ab.add(ac,au,av)

if not aw then
ae:notify(ai.notifyTitle,ax or"")
return
end


if as.Parent then
ar.Text=string.format(ai.restored,au)
at()
end
end,
},
},ai.undoTime)end


at=function()
af.clear(as)

local av=aa:getData()
local aw={}

for ax in av do
table.insert(aw,ax)
end

table.sort(aw)

local ax=af.list(as)

if#aw==0 then
af.note(ax,ai.empty)
return
end

for ay,az in aw do
local aA=af.row(ax)

af.label(aA,az,ah.aliasWidth+2*ag.padding)
af.value(aA,tostring(av[az]),ah.aliasWidth)

aA.Activated:Connect(function()
local aB,aC=ab.remove(ac,az)

if aB then
ar.Text=string.format(ai.removed,az)
au(az,aC)
end

at()
end)
end end local av=function()



local av=aj(ao.Text)
local aw=aj(ap.Text)

if av==""or aw==""then
ar.Text=ai.missing
return
end

if av:find("%s")then
ar.Text=ai.spaces
return
end

if ak(av)then
ar.Text=ai.badCharacters
return
end

local ax,ay=ab.add(ac,av,aw)

if ax then
ar.Text=string.format(ai.added,av:lower())
ao.Text=""
ap.Text=""
at()
else
ar.Text=ay or""
end end


aq.Activated:Connect(av)


ao.FocusLost:Connect(function(aw)
if aw then
ap:CaptureFocus()
end
end)

ap.FocusLost:Connect(function(aw)
if aw then
av()
end
end)

at()end


return al end a.dD=function()local ab=a.cache.dD if not ab then ab={c=aa()}a.cache.dD=ab end return ab.c end end do local aa=function()













local aa=a.bl()
local ab=a.af()
local ac=a.db()
local ad=a.c_()
local ae=a.dy()

local af=ac.panel
local ag=ac.box
local ah=ac.value
local ai=ac.pages.waypoints


local aj=1 local ak=function(

ak)
return ak:match("^%s*(.-)%s*$")or""end local al=function(


al, am)
local an=ai.modes
local ao=math.clamp(aj,1,#an)

local ap=ae.list(al)
ae.pageTop(ap,ai.title,am.back)


ae.header(ap,ai.newTitle)
local aq,ar,as=ae.formRow(ap,ai.nameHint,ai.positionHint,ai.addButton,ah.positionWidth)
local at=ae.note(ap,ai.formHint)


ae.header(ap,ai.modeTitle)

local au={}
for av,aw in an do
table.insert(au,aw.label)
end

local av=ae.choices(ap,au,function(av)
ao=av
aj=av
end,#an)
av(ao)


local aw=ae.row(ap)
ae.label(aw,ai.markers,ag.size+2*af.padding)
local ax,ay=ae.box(aw)


local az=ae.header(ap,"")
local aA=ae.group(ap)


ae.header(ap,ai.clearTitle)
local aB=ae.row(ap)
ae.label(aB,ai.clearGame,0)
local aC=ae.row(ap)
ae.label(aC,ai.clearAll,0)

local aD local aE=function(


aE)
at.Text=aE
ad:notify(ai.notifyTitle,aE)end local aF=function()



ay.Visible=aa.isShown()end local aG=function(



aG)
local aH=an[ao].mode
local aI=aa.format(aG.position)

if not aa.go(aG,aH)then
aE(ai.cantGo)
return
end

local aJ=if aH=="tween"then ai.wentTween elseif aH=="walk"then ai.wentWalk else ai.went
at.Text=string.format(aJ,aG.name,aI)end local aH=function(



aH)
ad:ask(ai.undoTitle,string.format(ai.undoMessage,aH.name,aa.format(aH.position)),{
{
text=ai.undo,
primary=true,
onTap=function()

if aa.find(aH.name)then
ad:notify(ai.notifyTitle,string.format(ai.nameTaken,aH.name))
return
end

aa.save(aH.name,aH.position)
aa.refreshMarkers()


if aA.Parent then
at.Text=string.format(ai.restored,aH.name)
aD()
end
end,
},
},ai.undoTime)end local aI=function(


aI)
if not aa.remove(aI.name)then return end

aa.refreshMarkers()
at.Text=string.format(ai.removed,aI.name)
aD()
aH(aI)end


aD=function()
ae.clear(aA)

local aJ=aa.list()
local aK=ae.list(aA)

az.Text=ai.listTitle..(if#aJ>0 then` ({#aJ})`else"")
aF()

if#aJ==0 then
ae.note(aK,ai.empty)
return
end

ae.note(aK,ai.listHint)

for aL,aM in aJ do
local aN=ae.row(aK)


local aO=ae.rowButton(aN,ai.delete,af.padding,ah.buttonWidth)
ae.label(aN,aM.name,ah.buttonWidth+2*af.padding)

aN.Activated:Connect(function()
aG(aM)
end)

aO.Activated:Connect(function()
aI(aM)
end)
end end local aJ=function()



local aJ=ak(aq.Text)

if aJ==""then
aE(ai.missingName)
return
end

local aK
local aL=ak(ar.Text)

if aL==""then
local aM=ab:getRootPart()

if not aM then
aE(ai.noCharacter)
return
end

aK=aM.Position
else
aK=aa.parsePosition(aL)

if not aK then
aE(ai.badPosition)
return
end
end

local aM=aa.save(aJ,aK)
aa.refreshMarkers()

aq.Text=""
ar.Text=""
at.Text=string.format(if aM then ai.updated else ai.saved,aJ,aa.format(aK))
aD()end


as.Activated:Connect(aJ)


for aK,aL in{aq,ar}do
aL.FocusLost:Connect(function(aM)
if aM then
aJ()
end
end)
end

aw.Activated:Connect(function()
if aa.isShown()then
aa.hide()
elseif aa.count()==0 then
aE(ai.noMarkers)
else
aa.show()
end

aF()
end)local aK=function(


aK)
local aL=if aK then aa.countAll()else aa.count()

if aL==0 then
at.Text=ai.nothingToClear
return
end

local aM=string.format(if aK then ai.confirmAll else ai.confirmGame,aL)

ad:ask(ai.confirmTitle,aM,{
{text=ai.confirmCancel},
{
text=ai.confirmClear,
primary=true,
onTap=function()
local aN=if aK then aa.clearAll()else aa.clearPlace()
aa.hide()


if aA.Parent then
at.Text=string.format(ai.cleared,aN)
aD()
end
end,
},
})end


aB.Activated:Connect(function()
aK(false)
end)

aC.Activated:Connect(function()
aK(true)
end)

aD()end


return al end a.dE=function()local ab=a.cache.dE if not ab then ab={c=aa()}a.cache.dE=ab end return ab.c end end do local aa=function()












local aa=a.cB()
local ab=a.cD()
local ac=a.db()
local ad=a.cz()
local ae=a.c_()
local af=a.dy()

local ag=ac.panel
local ah=ac.value
local ai=ac.pages.plugins local aj=function(

aj)
return aj:match("^%s*(.-)%s*$")or""end local ak=function(


ak, al)
local am=af.list(ak)
af.pageTop(am,ai.title,al.back)


af.header(am,ai.addTitle)
local an=af.textBox(am,ai.fileHint)

local ao=af.row(am)
af.label(ao,ai.addButton,0)

local ap=af.note(am,string.format(ai.folderHint,table.concat(ad.extensions,", "),aa.FOLDER))
af.note(am,ai.trustHint)


local aq=af.header(am,ai.installedTitle)
local ar=af.group(am)

af.header(am,ai.folderTitle)
local as=af.group(am)

local at local au=function(


au)
ap.Text=au
ae:notify(ai.errorTitle,au)end local av=function(



av)
local aw,ax=aa.add(ab,av)

if aw then
ap.Text=string.format(ai.added,av,ax)
at()
return true
end

au(tostring(ax))
return false end local aw=function(



aw)
if aw.loaded then
return string.format(ai.stateLoaded,aw.name,aw.commands)
end

if aw.error then
return string.format(ai.stateFailed,aw.name,aw.error)
end

return string.format(ai.stateUnknown,aw.name)end local ax=function()



af.clear(ar)

local ax=aa.getInstalled()
local ay=af.list(ar)

aq.Text=ai.installedTitle..(if#ax>0 then` ({#ax})`else"")

if#ax==0 then
af.note(ay,ai.noneInstalled)
return
end

af.note(ay,ai.installedHint)

local az=ag.rowGap
local aA=ag.padding
local aB=aA+ah.buttonWidth+az
local aC=aB+ah.reloadWidth+ag.padding

for aD,aE in ax do
local aF=af.row(ay)

local aG=af.rowButton(aF,ai.remove,aA,ah.buttonWidth)
local aH=af.rowButton(aF,ai.reload,aB,ah.reloadWidth)


local aI=if aE.loaded
then string.format(ai.loadedLabel,aE.name,aE.commands)
else string.format(ai.failedLabel,aE.name)

af.label(aF,aI,aC,if aE.loaded then nil else"Colors.Text.Darker")

aF.Activated:Connect(function()
ap.Text=aw(aE)
end)

aH.Activated:Connect(function()
local aJ,aK=aa.reload(ab,aE.name)

if aJ then
ap.Text=string.format(ai.reloaded,aE.name,aK)
at()
else
at()
au(tostring(aK))
end
end)

aG.Activated:Connect(function()
if aa.remove(ab,aE.name)then
ap.Text=string.format(ai.removed,aE.name)
at()
end
end)
end end local ay=function()



af.clear(as)

local ay,az=aa.getAvailable()
local aA=af.list(as)

if not ay then
af.note(aA,az or"")
return
end

if#ay==0 then
af.note(aA,ai.noneInFolder)
return
end

local aB=ag.padding

for aC,aD in ay do
local aE=af.row(aA)

local aF=af.rowButton(aE,ai.add,aB,ah.buttonWidth)
af.label(aE,aD,ah.buttonWidth+2*ag.padding)


aE.Activated:Connect(function()
av(aD)
end)

aF.Activated:Connect(function()
av(aD)
end)
end


local aC=af.row(aA)
af.label(aC,string.format(ai.addAll,#ay),0)

aC.Activated:Connect(function()
local aD=0
local aE={}

for aF,aG in ay do
local aH,aI=aa.add(ab,aG)

if aH then
aD=aD+1
else
table.insert(aE,`{aG}: {aI}`)
end
end

local aF=string.format(ai.addedAll,aD)

if#aE>0 then
aF=aF..string.format(ai.failedAll,#aE)

for aG,aH in aE do
warn(`plugin {aH}`)
end
end

ap.Text=aF
at()
end)end


at=function()
ax()
ay()end local az=function()



local az=aj(an.Text)

if az==""then
au(ai.missingName)
return
end

if av(az)then
an.Text=""
end end


ao.Activated:Connect(az)


an.FocusLost:Connect(function(aA)
if aA then
az()
end
end)

at()end


return ak end a.dF=function()local ab=a.cache.dF if not ab then ab={c=aa()}a.cache.dF=ab end return ab.c end end do local aa=function()












local aa=a.c8()
local ab=a.db()
local ac=a.c_()
local ad=a.dy()

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
local ap=math.clamp(ah,1,#ao)
local aq={}


local ar={}
for as,at in ao do
table.insert(ar,(at.name:gsub("^On","")))
end

local as=ad.list(am)
ad.pageTop(as,nil,an.back)

local at,au
local av
local aw

at,au=ad.choices(as,ar,function(ax)
ap=ax
ah=ax
av()
end,ag.columns)local ax=function()



for ax,ay in ao do
au(ax,#aa.getBinds(ay.name))
end end



local ay=ad.header(as,"")


local az=ad.group(as)

local aA,aB,aC=ad.formRow(as,ag.commandHint,ag.delayHint,ag.addButton)

local aD=ad.note(as,"")

local aE=ad.header(as,"")
local aF=ad.group(as)local aG=function()


return ao[ap]end local aH=function(



aH)
aD.Text=aH
ac:notify(ag.notifyTitle,aH)end local aI=function(



aI, aJ, aK)
local aL=string.format(ag.undoMessage,aK.command,aI.name)


local aM={}
local aN=ai(aK)

if(aK.delay or 0)>0 then
table.insert(aM,string.format(ag.undoDelay,ak(aK.delay)))
end

if#aN>0 then
table.insert(aM,`[{table.concat(aN,", ")}]`)
end

if#aM>0 then
aL=aL.."\n"..table.concat(aM,"  ")
end

ac:ask(ag.undoTitle,aL,{
{
text=ag.undo,
primary=true,
onTap=function()
if aa.restore(aI.name,aJ,aK)then

if aF.Parent then
aD.Text=string.format(ag.restored,aK.command)
ax()

if aG()==aI then
aw()
end
end
end
end,
},
},ag.undoTime)end local aJ=function()




ad.clear(az)
aq={}

local aJ=ad.list(az)

for aK,aL in aG().conditions do
local aM,aN=ad.inputRow(
aJ,
aL.label,
ag.conditionHints[aL.kind]or"",
aL.default
)

aq[aK]=aN
end end


aw=function()
ax()
ad.clear(aF)

local aK=aG()
local aL=ad.list(aF)
local aM=aa.getBinds(aK.name)

aE.Text=string.format(ag.listTitle,aK.name)..(if#aM>0 then` ({#aM})`else"")

if#aM==0 then
ad.note(aL,ag.empty)
return
end

ad.note(aL,ag.listHint)

for aN,aO in aM do
local aP=ad.row(aL)
ad.label(aP,aj(aO),af.delayWidth+2*ae.padding)


local aQ=ad.valueInput(aP,ak(aO.delay or 0),af.delayWidth)


aQ.FocusLost:Connect(function()
if not aQ.Parent then return end

local aR=al(aQ.Text)

if aR==nil or aR<0 then
aQ.Text=ak(aO.delay or 0)
aH(if aR==nil then ag.badDelay else ag.negativeDelay)
return
end

if aa.setDelay(aK.name,aN,aR)then
aQ.Text=ak(aR)
aD.Text=string.format(ag.delayChanged,aO.command,ak(aR))
end
end)

aP.Activated:Connect(function()
local aR=aa.remove(aK.name,aN)

if aR then
aD.Text=string.format(ag.removed,aR.command)
aw()
aI(aK,aN,aR)
end
end)
end end


av=function()
ay.Text=string.format(ag.header,aG().name,aG().description)
aD.Text=""

at(ap)
aJ()
aw()end local aK=function()



local aK=if aB.Text==""then 0 else al(aB.Text)

if aK==nil then
aH(ag.badDelay)
return
end

if aK<0 then
aH(ag.negativeDelay)
return
end

local aL={}
for aM,aN in aq do
aL[aM]=aN.Text
end

local aM=aG()
local aN,aO=aa.add(aM.name,aA.Text,aK,aL)

if aN then

aA.Text=""
aw()
aD.Text=string.format(ag.added,aM.name)
else
aH(aO or ag.notAdded)
end end


aC.Activated:Connect(aK)


for aL,aM in{aA,aB}do
aM.FocusLost:Connect(function(aN)
if aN then
aK()
end
end)
end

av()end


return am end a.dG=function()local ab=a.cache.dG if not ab then ab={c=aa()}a.cache.dG=ab end return ab.c end end do local aa=function()









local aa=a.cT()
local ab=a.aE()
local ac=a.n()
local ad=a.db()
local ae=a.az()
local af=a.f()
local ag=a.cJ()
local ah=a.t()

local ai=a.dy()
local aj=a.dA()
local ak=a.dB()
local al=a.dC()
local am=a.dD()
local an=a.dE()
local ao=a.dF()
local ap=a.dG()

local aq=ad.panel
local ar=ad.box
local as=ad.row
local at=ad.value

local au=af.TweenService

local av=aq.shownY
local aw=aq.hiddenY



local ax=aq.floatBackSize
local ay=UDim2.new(1,-(aq.floatBackMargin+aq.scrollBarThickness),0,aq.floatBackMargin)
local az=UDim2.fromOffset(ax,ax)
local aA=UDim2.fromOffset(ax*aq.floatBackFlat,ax)
local aB=UDim2.new(1,0,0,-ax*aq.floatBackOut)


local aC={
theme=aj,
keybinds=ak.interface,
commands=ak.commands,
importExport=al,
aliases=am,
waypoints=an,
plugins=ao,
eventBinds=ap,
}

local aD={}
aD.__index=aD local aE=function(

aE, aF)
ac:setValue(aE,aF==true)
ac:save()end local aF=function(


aF)
return ac:getValue(aF)==true end local aG=function(


aG, aH, aI)
aG:TweenPosition(aH,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,aq.tweenTime,true,aI)end local aH=function(




aH, aI)
if type(aH)~="number"then
return ad.userData.missing
end

if aI.date then
return os.date(ad.userData.dateFormat,aH)
end

return tostring(aH)end local aI=function(




aI)
if aI.placeCounts then
local aJ=ah.user:getValue(aI.placeCounts)

if type(aJ)~="table"then
return nil
end

return aJ[tostring(game.GameId)]
end

return ah.user:getValue(aI.key)end


aD.isKeepMenuOpen=function()
return aF(ad.keys.keepMenuOpen)end


aD.setKeepMenuOpen=function(aJ)
aE(ad.keys.keepMenuOpen,aJ)end


aD.isKeepIY=function()
return aF(ad.keys.keepIY)end


aD.setKeepIY=function(aJ)
aE(ad.keys.keepIY,aJ)end



aD.createOption=function(aJ, aK, aL)
if aL.kind=="expand"then
aJ:createExpandOption(aK,aL)
return nil
end

local aM=ai.row(aK)

if aL.icon then
ai.icon(aM,aL.icon)
end

if aL.kind=="switch"then
local aN=ad.keys[aL.setting]
ai.label(aM,aL.label,ar.size+2*aq.padding)

local aO,aP=ai.box(aM)local aQ=function()


aP.Visible=aF(aN)end


aM.Activated:Connect(function()
local aR=not aF(aN)
aE(aN,aR)
aQ()

if aJ.onSwitch then
aJ.onSwitch(aL.setting,aR)
end
end)

aQ()
return aQ
end

if aL.kind=="keybind"then
ai.label(aM,aL.label,at.keybindWidth+2*aq.padding)

local aN,aO=ai.keybind(aM,aL.binding)
table.insert(aJ.stoppers,aO)

return aN
end


local aN=aC[aL.action]~=nil

if aN then
ai.chevron(aM)
end

ai.label(aM,aL.label,if aN then as.chevronSize+2*aq.padding else 0)

aM.Activated:Connect(function()
if aC[aL.action]then
aJ:openPage(aL.action)
elseif aJ.onButton then
aJ.onButton(aL.action)
end
end)

return nil end




aD.createExpandOption=function(aJ, aK, aL)
local aM=ai.row(aK)

if aL.icon then
ai.icon(aM,aL.icon)
end

ai.label(aM,aL.label,as.chevronSize+2*aq.padding)
local aN=ai.chevron(aM)

local aO=ai.group(aK)
aO.Visible=false

local aP=ai.list(aO)
local aQ={}

for aR,aS in aL.items do
local aT=ai.row(aP)
ai.label(aT,aS.label,at.userWidth+2*aq.padding)

local aU,aV=ai.value(aT,"",at.userWidth)
table.insert(aQ,{item=aS,text=aV})
end local aR=function()


for aR,aS in aQ do
aS.text.Text=aH(aI(aS.item),aS.item)
end end


local aS=false

aM.Activated:Connect(function()
aS=not aS


aN.Rotation=if aS then 270 else 180
aO.Visible=aS

if aS then
aR()
end
end)end


aD.createOptions=function(aJ)
local aK=ai.list(aJ.panel)

for aL,aM in ad.sections do
ai.header(aK,aM.title)

for aN,aO in aM.options do
local aP=aJ:createOption(aK,aO)

if aP then
table.insert(aJ.refreshers,aP)
end
end
end


local aL=ad.footer
:gsub("{name}",ae.applicationName)
:gsub("{version}",ae.version)

ai.footer(aK,aL)end


aD.createPages=function(aJ)
for aK,aL in aC do
local aM=ai.page(aJ.holder,`{aK}Page`,UDim2.fromScale(1,aw))


aM.Visible=false

aJ.pages[aK]={
frame=aM,
build=aL,
}
end end


aD.new=function(aJ)
return setmetatable({
onSwitch=aJ.onSwitch,
onButton=aJ.onButton,
onOpenChanged=aJ.onOpenChanged,
isOpen=false,
isShown=false,
holder=nil,
listArea=nil,
listParts=nil,
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
floatingShown=false,
floatingTween=nil,
backIcon=nil,
},aD)end



aD.create=function(aJ, aK, aL, aM)
local aN=aa.new("Frame","SettingsHolder",aK,{
AnchorPoint=aL.AnchorPoint,
BackgroundTransparency=1,
ClipsDescendants=true,
Position=aL.Position,
Size=aL.Size,


ZIndex=0,
Visible=false,
})

aJ.holder=aN
aJ.listArea=aL
aJ.listParts=aM or{}
aJ.panel=ai.page(aN,"Settings",UDim2.fromScale(0,aw))
aJ.current=aJ.panel

aJ:createOptions()
aJ:createPages()
aJ:createFloatingBack(aN)

return aN end




aD.createFloatingBack=function(aJ, aK)
local aL=aa.new("TextButton","FloatingBack",aK,{
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BorderSizePixel=0,
Position=ay,
Size=az,
Text="",
Visible=false,
ZIndex=2,
ThemeTag={
BackgroundColor3="Colors.Buttons.Holding",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,at.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Thickness=1,
ThemeTag={
Color="Colors.Border.Default",
},
}),
})


local aM=ai.icon(aL,ad.pages.backIcon)
aM.AnchorPoint=Vector2.new(0.5,0.5)
aM.Position=UDim2.fromScale(0.5,0.5)
aM.Size=UDim2.fromScale(as.iconSize/aq.floatBackSize,as.iconSize/aq.floatBackSize)
aM.ZIndex=aL.ZIndex+1

aL.Activated:Connect(function()
aJ:back()
end)

aJ.floatingBack=aL
aJ.floatingIcon=aM end



aD.syncFloatingIcon=function(aJ)
local aK,aL=aJ.floatingIcon,aJ.backIcon

if aK and aL and aL.Image~=""and aK.Image~=aL.Image then
aK.Image=aL.Image
end end




aD.updateFloatingBack=function(aJ)
local aK=aJ.floatingBack
if not aK then return end

local aL=aJ.current
local aM=aJ.backRow
local aN=false

if aJ.isShown and aL~=aJ.panel and aM and aM.Parent then
aN=aM.AbsolutePosition.Y+aM.AbsoluteSize.Y<=aL.AbsolutePosition.Y
end

if aN then
aJ:syncFloatingIcon()
end

if aN==aJ.floatingShown then return end

aJ.floatingShown=aN

if aN then
aJ:showFloatingBack()
else
aJ:hideFloatingBack()
end end



aD.showFloatingBack=function(aJ)
local aK=aJ.floatingBack


if not aK.Visible then
aK.Position=aB
aK.Size=aA
aK.Visible=true
end

aJ:tweenFloatingBack(ay,az,Enum.EasingStyle.Back,Enum.EasingDirection.Out)end



aD.hideFloatingBack=function(aJ)
local aK=aJ.floatingBack
if not aK.Visible then return end

aJ:tweenFloatingBack(aB,aA,Enum.EasingStyle.Quart,Enum.EasingDirection.In,function()
aK.Visible=false
end)end




aD.tweenFloatingBack=function(aJ, aK, aL, aM, aN, aO)
local aP=aJ.floatingBack
aJ:stopFloatingTween()

local aQ=ag:getScale(aq.floatBackTime)

if aQ<=0 then
aP.Position=aK
aP.Size=aL

if aO then
aO()
end

return
end

local aR=au:Create(aP,TweenInfo.new(aQ,aM,aN),{
Position=aK,
Size=aL,
})

aJ.floatingTween=aR

aR.Completed:Connect(function(aS)

if aS~=Enum.PlaybackState.Completed then return end

if aJ.floatingTween==aR then
aJ.floatingTween=nil
end

if aO then
aO()
end
end)

aR:Play()end


aD.stopFloatingTween=function(aJ)
local aK=aJ.floatingTween
if not aK then return end

aJ.floatingTween=nil
aK:Cancel()end


aD.refresh=function(aJ)
for aK,aL in aJ.refreshers do
aL()
end end



aD.stopWaiting=function(aJ)
for aK,aL in aJ.stoppers do
aL()
end

for aK,aL in aJ.pageStoppers do
aL()
end end



aD.buildPage=function(aJ, aK)
ai.clear(aK.frame)
aJ.pageStoppers={}

for aL,aM in aJ.pageConnections do
aM:Disconnect()
end
table.clear(aJ.pageConnections)

aK.build(aK.frame,{
back=function()
aJ:back()
end,
stoppers=aJ.pageStoppers,
})

aJ.backRow=aK.frame:FindFirstChild("BackRow")
aJ.backIcon=if aJ.backRow then aJ.backRow:FindFirstChild("Icon")else nil

if aJ.backIcon then

table.insert(aJ.pageConnections,aJ.backIcon:GetPropertyChangedSignal("Image"):Connect(function()
aJ:syncFloatingIcon()
end))

aJ:syncFloatingIcon()
end

table.insert(aJ.pageConnections,aK.frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
aJ:updateFloatingBack()
end))end





aD.hideWhenGone=function(aJ, aK)
return function(aL)
if aL and aK~=aJ.current then
aK.Visible=false
end
end end



aD.openPage=function(aJ, aK)
local aL=aJ.pages[aK]
if not aL or not aJ.isShown or aJ.current~=aJ.panel then return end

aJ:stopWaiting()


aL.frame.Visible=true
aJ:buildPage(aL)

aL.frame.CanvasPosition=Vector2.zero
aL.frame.Position=UDim2.fromScale(1,av)
aJ.current=aL.frame

aG(aJ.panel,UDim2.fromScale(-1,av),aJ:hideWhenGone(aJ.panel))
aG(aL.frame,UDim2.fromScale(0,av))

aJ:updateFloatingBack()end



aD.back=function(aJ)
if aJ.current==aJ.panel then return end

aJ:stopWaiting()

local aK=aJ.current
aJ.panel.Visible=true

aG(aK,UDim2.fromScale(1,av),aJ:hideWhenGone(aK))
aG(aJ.panel,UDim2.fromScale(0,av))
aJ.current=aJ.panel

aJ:updateFloatingBack()end



aD.reset=function(aJ)
aJ.current=aJ.panel
aJ.panel.Visible=true
aJ.panel.Position=UDim2.fromScale(0,aw)

for aK,aL in aJ.pages do
aL.frame.Visible=false
aL.frame.Position=UDim2.fromScale(1,aw)
end end


aD.toggle=function(aJ)
aJ.isOpen=not aJ.isOpen
aJ:setShown(aJ.isOpen)


if aJ.onOpenChanged then
aJ.onOpenChanged(aJ.isOpen)
end end




aD.setListShown=function(aJ, aK)
for aL,aM in aJ.listParts do
aM.Visible=aK
end

aJ.listArea.Active=aK end


aD.setShown=function(aJ, aK)
if not aJ.panel or aJ.isShown==aK then return end

aJ.isShown=aK
local aL=aJ.current

aJ:updateFloatingBack()

if aK then
aJ.holder.Visible=true


aJ:setListShown(false)
aG(aL,UDim2.fromScale(0,av))
return
end

aJ:stopWaiting()

aG(aL,UDim2.fromScale(0,aw),function(aM)
if aM and not aJ.isShown then
aJ.holder.Visible=false


aJ:setListShown(true)


if not aJ.isOpen then
aJ:reset()
end
end
end)end


aD.watchCommandBar=function(aJ, aK)
ab:Connect(aK.Focused,function()
aJ:setShown(false)
end)

ab:Connect(aK.FocusLost,function()
aJ:setShown(aJ.isOpen)
end)end


return aD end a.dH=function()local ab=a.cache.dH if not ab then ab={c=aa()}a.cache.dH=ab end return ab.c end end do local aa=function()





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
}end a.dI=function()local ab=a.cache.dI if not ab then ab={c=aa()}a.cache.dI=ab end return ab.c end end do local aa=function()







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


return ae end a.dJ=function()local ab=a.cache.dJ if not ab then ab={c=aa()}a.cache.dJ=ab end return ab.c end end do local aa=function()







local aa=a.cT()
local ab=a.cV()
local ac=a.cS()
local ad=a.c_()
local ae=a.dn()
local af=a.b0()

local ag=a.aE()
local ah=a.af()
local ai=a.a()
local aj=a.dI()

local ak=a.dJ()
local al=a.cZ()
local am=a.cR()

local an=aj.window
local ao=aj.textSizes
local ap=aj.buttons

local aq=UDim2.new(0.5,-an.width/2,0,an.shownY)
local ar=UDim2.new(0.5,-an.width/2,0,an.hiddenY)

local as=Color3.fromRGB(255,255,255)
local at=Color3.fromRGB(0,166,0)

local au={}
au.__index=au

au.new=function()
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
},au)end local av=function(



av, aw, ax, ay)
return aa.new("Frame",ay,av,{
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=if aw%2==1 then an.stripeTransparency else 1,
BorderSizePixel=0,
LayoutOrder=aw,
Size=UDim2.new(1,0,0,ax),
})end local aw=function(



aw, ax, ay, az)
local aA=aa.new("Frame",ay,aw,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=if ax%2==1 then an.stripeTransparency else 1,
BorderSizePixel=0,
LayoutOrder=ax,
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

local aB=aa.new("TextLabel",az.labelName,aA,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
TextSize=az.textSize,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3=az.color,
},
})

return aA,aB end local ax=function(




ax)
local ay={}
local az=""

for aA=1,#ax do
local aB=string.sub(ax,aA,aA)

if(aB=="."or aB=="[")and az~=""then
table.insert(ay,az)
az=""
end

az=az..aB
end

if az~=""then
table.insert(ay,az)
end

local aA={}
local aB=""

for aC,aD in ay do
if aB~=""and#aB+#aD>aj.window.pathCharsPerLine then
table.insert(aA,aB)
aB=""
end

aB=aB..aD
end

if aB~=""then
table.insert(aA,aB)
end

return table.concat(aA,"\n")end local ay=function(


ay, az, aA)
local aB=av(ay,az,an.rowHeight,"Section")

aa.new("TextLabel","Title",aB,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(an.textInset,0),
Size=UDim2.new(1,-an.textInset*2,1,0),
RichText=true,
Text=`<b>{am.escapeRichText(aA)}</b>`,
TextSize=ao.section,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})

return aB end local az=function(


az, aA, aB, aC, aD)
local aE=aa.new("TextButton",aA,az,{
AutoButtonColor=false,
BorderSizePixel=0,
Position=aC,
Size=aD,
Text=aB,
TextSize=ao.button,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ap.cornerRadius),
}),
})

ag:Connect(aE.MouseEnter,function()
ac:updateObjectProperties(aE,{
BackgroundColor3="Colors.Buttons.Holding",
})
end)

ag:Connect(aE.MouseLeave,function()
ac:updateObjectProperties(aE,{
BackgroundColor3="Colors.Buttons.Default",
})
end)

return aE end



au.create=function(aA)
if aA.frame then
return aA.frame
end

local aB=aa.new("Frame","PartPath",{
Active=true,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=ar,
Size=UDim2.fromOffset(an.width,0),
Visible=false,

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local aC=aa.new("Frame","TopBar",aB,{
BorderSizePixel=0,
LayoutOrder=1,
Size=UDim2.new(1,0,0,an.topBarHeight),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",aC,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=an.title,
TextSize=ao.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local aD=aa.new("ImageButton","Exit",aC,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-an.closeInset,0.5,0),
Size=UDim2.fromOffset(an.closeIconSize,an.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(aD,"close")

local aE=aa.new("Frame","Body",aB,{
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

ay(aE,1,aj.headers.path)


local aF,aG=aw(aE,2,"PathRow",{
labelName="Path",
textSize=ao.value,
color="Colors.Text.Default",
})
aG.RichText=true

ay(aE,3,aj.headers.actions)


local aH=av(aE,4,an.buttonRowHeight,"ButtonRow")
local aI=an.buttonGap/2
local aJ=an.textInset
local aK=(an.buttonRowHeight-an.buttonHeight)/2
local aL=UDim2.new(0.5,-(aJ+aI),0,an.buttonHeight)

local aM=az(aH,"SelectPart",ap.selectPart,
UDim2.new(0,aJ,0,aK),aL)
local aN=az(aH,"CopyPath",ap.copyPath,
UDim2.new(0.5,aI,0,aK),aL)

local aO,aP=aw(aE,5,"Help",{
labelName="HelpText",
textSize=ao.help,
color="Colors.Text.Darker",
})
aP.Text=aj.labels.help


local aQ=aa.new("SelectionBox","Hover",af,{
Color3=as,
})

local aR=aa.new("SelectionBox","Selected",af,{
Color3=at,
})

ag:Connect(aD.Activated,function()
aA:close()
end)

ag:Connect(aM.Activated,function()
aA:confirmSelection()
end)

ag:Connect(aN.Activated,function()
aA:copyPath()
end)

ae:addGuiObject(aB)

aA.frame=aB
aA.hoverBox=aQ
aA.selectedBox=aR
aA.pathLabel=aG
aA.copyButton=aN

aA:setPath(nil)

return aB end



au.open=function(aA, aB)
aA:create()
aA.onSelectPart=aB

if aA.isOpen then
return
end

aA.isOpen=true
aA.frame.Visible=true
aA.frame:TweenPosition(aq,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,an.tweenTime,true)

aA:startSelecting()end



au.close=function(aA)
if not aA.isOpen then
return
end

aA.isOpen=false
aA:disconnectMouse()
aA:clearSelection()

aA.frame:TweenPosition(ar,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,an.tweenTime,true)

task.delay(an.tweenTime,function()

if not aA.isOpen and aA.frame then
aA.frame.Visible=false
end
end)end


au.isPointerOverWindow=function(aA)
return aA.frame~=nil and ah:isMouseInGuiObject(aA.frame)end


au.startSelecting=function(aA)
aA:disconnectMouse()

local aB=ah:getMouse()

table.insert(aA.connections,aB.Move:Connect(function()
local aC=aB.Target


if aA:isPointerOverWindow()or aC==aA.selectedPart then
aC=nil
end

aA.hoverBox.Adornee=aC
end))

table.insert(aA.connections,aB.Button1Down:Connect(function()
if aA:isPointerOverWindow()then
return
end

local aC=aB.Target
if aC then
aA:selectPart(aC)
end
end))end


au.disconnectMouse=function(aA)
for aB,aC in aA.connections do
aC:Disconnect()
end

aA.connections={}end


au.selectPart=function(aA, aB)
aA.selectedPart=aB
aA.selectedBox.Adornee=aB
aA.hoverBox.Adornee=nil
aA:setPath(ak(aB))end



au.setPath=function(aA, aB)
local aC=aA.pathLabel
aA.path=aB

if aB then
ac:addObject(aC,{TextColor3="Colors.Text.Default",Font="Font.MonoSpace"})
aC.RichText=true
aC.Text=al:apply(ax(aB))
else
ac:addObject(aC,{TextColor3="Colors.Text.Darker",Font="Font.MonoSpace"})
aC.RichText=false
aC.Text=aj.labels.hint
end end


au.clearSelection=function(aA)
aA.selectedPart=nil
aA.hoverBox.Adornee=nil
aA.selectedBox.Adornee=nil
aA:setPath(nil)end



au.confirmSelection=function(aA)
local aB=aA.selectedPart

if not aB or not aB.Parent then
aA:clearSelection()
ad:notify(an.title,aj.messages.noPart)
return
end

if aA.onSelectPart then
aA.onSelectPart(aB)
end end



au.copyPath=function(aA)
local aB=aA.path

if not aB then
ad:notify(an.title,aj.messages.noPath)
return
end

if not ai.setclipboard then
ad:notify(an.title,aj.messages.noClipboard)
return
end

ai.setclipboard(aB)

local aC=aA.copyButton
aC.Text=ap.copied

task.delay(ap.feedbackTime,function()
aC.Text=aj.buttons.copyPath
end)end


au.destroy=function(aA)
aA.isOpen=false
aA:disconnectMouse()

if aA.hoverBox then
aA.hoverBox:Destroy()
end

if aA.selectedBox then
aA.selectedBox:Destroy()
end

if aA.frame then
aA.frame:Destroy()
end

aA.frame=nil
aA.hoverBox=nil
aA.selectedBox=nil
aA.pathLabel=nil
aA.copyButton=nil end


return au end a.dK=function()local ab=a.cache.dK if not ab then ab={c=aa()}a.cache.dK=ab end return ab.c end end do local aa=function()







































local aa=a.f()
local ab=a.aE()
local ac=a.cJ()

local ad=aa.TweenService
local ae=aa.UserInputService
local af=aa.RunService

local ag=0.32
local ah=0.1
local ai=10
local aj=50
local ak=0.3
local al=20
local am=3
local an=0.5


local ao=0.2
local ap=0.5
local aq=1

local ar={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true,
}

local as={}
as.__index=as














as.new=function(at)
local au=setmetatable({
frame=at.frame,
screenGui=at.screenGui,
topBarHeight=at.topBarHeight,
clampPosition=at.clampPosition,
getScale=at.getScale,
onMinimize=at.onMinimize,
onInteractive=at.onInteractive,

hoverToOpen=at.hoverToOpen==true and ae.MouseEnabled,
commandBarInUse=at.commandBarInUse,
isMoving=at.isMoving,
lastMovingAt=-math.huge,

state="minimized",
interactive=nil,
hovering=false,
hoverRequest=0,
dragging=false,
keepOpen=at.keepOpen==true,
windowParts={},
tween=nil,
press=nil,
touches={},
outsideTouches={},
swipeLocked=false,
lastInteractionAt=-math.huge,
connections={},
},as)

au.frame.Position=au:targetFor("minimized")

table.insert(au.connections,ab:Connect(ae.InputBegan,function(av)
au:onInputBegan(av)
end))

table.insert(au.connections,ab:Connect(ae.InputEnded,function(av)
au:onInputEnded(av)
end))

table.insert(au.connections,ab:Connect(ae.InputChanged,function(av)
au:onInputChanged(av)
end))


table.insert(au.connections,ab:Connect(af.Heartbeat,function()
if au.isMoving and au.isMoving()then
au.lastMovingAt=os.clock()
end

au:checkLockIdle()
end))

au:setInteractive(false)

if au.hoverToOpen then

table.insert(au.connections,ab:Connect(au.frame.MouseEnter,function()
if au.frame.Visible then au:setHovering(true)end
end))

table.insert(au.connections,ab:Connect(au.frame.MouseLeave,function()
au:setHovering(false)
end))
end

return au end local at=function(


at, au)
local av=at.AbsolutePosition
local aw=at.AbsoluteSize

return au.X>=av.X and au.X<=av.X+aw.X
and au.Y>=av.Y and au.Y<=av.Y+aw.Y end



as.isOverWindow=function(au, av)
if at(au.frame,av)then
return true
end

for aw,ax in au.windowParts do
if at(ax,av)then
return true
end
end

return false end



as.addWindowPart=function(au, av)
table.insert(au.windowParts,av)end



as.setKeepOpen=function(au, av)
au.keepOpen=av==true

if au.keepOpen and au.state=="minimized"then
au:expand()
end end



as.reveal=function(au)

au:lockSwipe()

if au.state=="minimized"then
au:expand()
end end






as.lockSwipe=function(au)
if au.hoverToOpen then return end
if not au:fingerOutsideWindow()then return end

au.swipeLocked=true
au.lastInteractionAt=os.clock()end



as.fingerOutsideWindow=function(au)
for av,aw in au.touches do
if not au:isOverWindow(aw)then
return true
end
end

return false end



as.unlockSwipe=function(au)
au.swipeLocked=false end




as.noteInteraction=function(au)
au.lastInteractionAt=os.clock()end




as.checkLockIdle=function(au)
if au.swipeLocked and os.clock()-au.lastInteractionAt>=am then
au.swipeLocked=false
end end



as.onSettled=function(au, av)
local aw=au.tween

if aw and aw.PlaybackState==Enum.PlaybackState.Playing then
aw.Completed:Once(av)
else
task.defer(av)
end end





as.nearestSnap=function(au)
local av=au.frame
local aw=av.AbsolutePosition.Y
local ax=au.screenGui.AbsoluteSize.Y-(av.AbsolutePosition.Y+av.AbsoluteSize.Y)

if aw<=ax then
return"top"
end

if au.state=="expanded"then
return"expanded"
end

return"minimized"end



as.targetFor=function(au, av)
local aw=au.clampPosition(au.frame.Position).X

if av=="top"then

return UDim2.new(aw.Scale,aw.Offset,0,0)
end

if av=="expanded"then

return UDim2.new(aw.Scale,aw.Offset,1,-au.frame.Size.Y.Offset)
end


return UDim2.new(aw.Scale,aw.Offset,1,-au.topBarHeight)end




as.clampDrag=function(au, av)
local aw=au.clampPosition(av).X

local ax=math.max(au.getScale(),0.01)
local ay=au.screenGui.AbsoluteSize.Y/ax
local az=math.max(ay-au.topBarHeight,0)
local aA=math.clamp(av.Y.Scale*ay+av.Y.Offset,0,az)

return UDim2.new(aw.Scale,aw.Offset,0,aA)end



as.wasMovingRecently=function(au)
return os.clock()-au.lastMovingAt<an end



as.setInteractive=function(au, av)
if au.interactive==av then return end
au.interactive=av

if au.onInteractive then
au.onInteractive(av)
end end


as.cancel=function(au)
if au.tween then
au.tween:Cancel()
au.tween=nil
end end


as.moveTo=function(au, av, aw, ax)

if av==au.state and au.tween and au.tween.PlaybackState==Enum.PlaybackState.Playing then
return
end

local ay=au.state=="minimized"
au.state=av
au:cancel()


if av=="minimized"then
au.swipeLocked=false
elseif ay then
au:lockSwipe()
end


if av=="minimized"then
au:setInteractive(false)
end

local az=au:targetFor(av)
local aA=ac:getScale(aw or ag)

if aA<=0 then
au.frame.Position=az
au:setInteractive(av~="minimized")
return
end

local aB=TweenInfo.new(aA,Enum.EasingStyle.Quart,ax or Enum.EasingDirection.Out)
local aC=ad:Create(au.frame,aB,{Position=az})
au.tween=aC



aC.Completed:Connect(function(aD)
if aD~=Enum.PlaybackState.Completed then return end
if au.tween~=aC or au.state=="minimized"then return end

au:setInteractive(true)
end)

aC:Play()end


as.expand=function(au, av, aw)
au:moveTo("expanded",av,aw)end




as.setHovering=function(au, av)
if av==au.hovering then return end
au.hovering=av


if au.dragging then return end

if av then
au:onHoverEnter()
else
au:onHoverLeave()
end end




as.onHoverEnter=function(au)
au.hoverRequest=au.hoverRequest+1

if au.state=="minimized"then
au:expand(ao,Enum.EasingDirection.InOut)
end end




as.onHoverLeave=function(au)
au.hoverRequest=au.hoverRequest+1
local av=au.hoverRequest

if not au:canHoverMinimize()then return end

task.delay(aq,function()
if av~=au.hoverRequest or not au:canHoverMinimize()then return end

au:minimize(ap,Enum.EasingDirection.InOut)
end)end



as.canHoverMinimize=function(au)
return au.state=="expanded"and not au.keepOpen and not au:commandBarBusy()end







as.onCommandBarClosed=function(au, av)
if not au.hoverToOpen then return end


if au:fingerOnWindow()then return end

local aw=au.hoverRequest
task.wait()


if aw~=au.hoverRequest or au.dragging or not au:canHoverMinimize()then return end
if au.hovering and not av then return end
if au:fingerOnWindow()then return end

au:minimize(ap,Enum.EasingDirection.InOut)end





as.onMobileEnter=function(au, av)
if au.hoverToOpen then return end



if not au:wasMovingRecently()then return end

task.wait()

if au.dragging or av()then return end
if au.state~="expanded"or au.keepOpen then return end

au:minimize()end





as.setDragging=function(au, av)
local aw=au.dragging
au.dragging=av==true



if aw and not au.dragging and au.hoverToOpen and not au.hovering then
au:onHoverLeave()
end end


as.minimize=function(au, av, aw)

if au.onMinimize then
au.onMinimize()
end

au:moveTo("minimized",av,aw)end



as.reflow=function(au)
au:cancel()
au.frame.Position=au:targetFor(au.state)
au:setInteractive(au.state~="minimized")end




as.sleep=function(au)
au:cancel()
au.state="minimized"
au.swipeLocked=false
au.frame.Position=au:targetFor("minimized")
au:setInteractive(false)end



as.onDragEnded=function(au, av)
if av.travel<=ai then

au:moveTo(au.state)
return
end

if av.dy>=aj and not au:commandBarBusy()and not au.swipeLocked then
au:minimize()
return
end

au:moveTo(au:nearestSnap())end





as.onListSwipeDown=function(au)
if au.hoverToOpen or au.swipeLocked then return end
if au.state=="minimized"or au:commandBarBusy()then return end

au:minimize()end



as.commandBarBusy=function(au)
return au.commandBarInUse~=nil and au.commandBarInUse()==true end



as.fingerOnWindow=function(au)
for av,aw in au.touches do
if au:isOverWindow(aw)then
return true
end
end

return false end



as.onInputChanged=function(au, av)
if av.UserInputType~=Enum.UserInputType.Touch then return end
if au.touches[av]==nil then return end

au.touches[av]=av.Position

if au:isOverWindow(av.Position)then
au:noteInteraction()
end

local aw=au.outsideTouches[av]
if aw and(av.Position-aw).Magnitude>=al then
au:onOutsideSwipe()
end end





as.onOutsideSwipe=function(au)
if au.hoverToOpen or au.dragging or au.swipeLocked then return end
if au.state~="expanded"or au.keepOpen or au:commandBarBusy()then return end

table.clear(au.outsideTouches)
au:minimize()end


as.onInputBegan=function(au, av)
if av.UserInputType==Enum.UserInputType.Touch then
au.touches[av]=av.Position

if au:isOverWindow(av.Position)then
au:noteInteraction()
else
au.outsideTouches[av]=av.Position
end
end

if not ar[av.UserInputType]then return end

au.press={
type=av.UserInputType,
time=os.clock(),
position=av.Position,
inside=au:isOverWindow(av.Position),

startedExpanded=au.state=="expanded",
}end



as.onInputEnded=function(au, av)
if av.UserInputType==Enum.UserInputType.Touch then
au.touches[av]=nil
au.outsideTouches[av]=nil
end

local aw=au.press
if not aw or av.UserInputType~=aw.type then return end
au.press=nil

local ax=os.clock()-aw.time
local ay=(av.Position-aw.position).Magnitude

if aw.inside then

if ax<=ah and ay<=ai and au.state=="minimized"then
au:expand()
end

return
end



local az=ax<=ak and ay<=ai

if az and aw.startedExpanded and not au.hoverToOpen and au.state=="expanded"and not au.keepOpen
and not au:commandBarBusy()and not au:wasMovingRecently()then
au:minimize()
end end


as.destroy=function(au)
au:cancel()
au.hoverRequest=au.hoverRequest+1

for av,aw in au.connections do
ab:disconnect(aw)
end
table.clear(au.connections)
table.clear(au.touches)
table.clear(au.outsideTouches)end


return as end a.dL=function()local ab=a.cache.dL if not ab then ab={c=aa()}a.cache.dL=ab end return ab.c end end do local aa=function()



local aa=a.az()
local ab=a.cX()
local ac=a.b()
local ad=a.a()
local ae=a.aE()
local af=a.f()
local ag=a.b_()

local ah=a.af()

local ai=a.n()
local aj=a.d()
local ak=a.cR()

local al=a.cT()
local am=a.cV()
local an=a.cS()
local ao=a.dc()

local ap=a.cP()
local aq=a.b0()
local ar=a.c_()

local as=a.de()
local at=a.cW()
local au=a.df()

local av=a.dg()
local aw=a.dj()
local ax=a.dl()
local ay=a.dt()
local az=a.dv()
local aA=a.dx()
local aB=a.dH()
local aC=a.dK()

local aD=a.dn()
local aE=a.dL()

local aG=450
local aH=at.uiScale

local aI={
awoken=false,
}local aJ=function(

aJ)
local aK=type(aJ)=="string"and ap[aJ:lower()]

if aK and aK.Colors and aK.Font then
return aJ
end

return aa.theme.defaultTheme end local aK=function(


aK, aL, aM, aN)
local aO=(aK.Scale*aM)/aN+aK.Offset
local aP=math.floor(aM/aN-aL)

if math.floor(aO)>=aP then
return 1,-aL
end

return 0,math.clamp(math.floor(aO),0,math.max(aP,0))end


aI.awake=function(aL)
if aL.awoken then
return aL.screenGui
end

aL.awoken=true

aL:setupTheme()
aL:setupScreenGui()
aL:setupScale()
aL:setupMainFrame()
aL:createQuickCapture()
aL:createReference()
aL:createPartPath()
aL:createNotifications()
aL:setupListeners()
aL:updateNotificationsPosition()

aj:log("interface started")
return aL.screenGui end


aI.setupTheme=function(aL)
aj:debug("interface: initializing theme service")

an:init({
theme=aJ(aa.theme.selectedTheme),
})end


aI.setupScreenGui=function(aL)
local aM=aL:createScreenGui()

aM.Parent=aq
ac.screenGui=aM

aH.Parent=aM end


aI.setupScale=function(aL)
aL:setScale(ai:getValue("interface.uiScale")or 1)end


aI.setupMainFrame=function(aL)
local aM=aL:createMainFrame()

aL:createCommands()
aL:dragMainFrame(aM)
aL.commands:enable()

aM.Parent=aL.screenGui end


aI.setupListeners=function(aL)
ae:Connect(aL.screenGui:GetPropertyChangedSignal("AbsoluteSize"),function()
aL:updateMainFramePosition()
end)

ae:Connect(aL.mainFrame:GetPropertyChangedSignal("AbsolutePosition"),function()
aL:updateNotificationsPosition()
end)

ae:Connect(aL.mainFrame:GetPropertyChangedSignal("AbsoluteSize"),function()
aL:updateNotificationsPosition()
end)

ae:Connect(af.RunService.RenderStepped,function()
aL:updateNotificationsPosition()
end)end


aI.createScreenGui=function(aL)
local aM=al.new("ScreenGui",{
IgnoreGuiInset=true,
Name=ak.randomString(math.random(30,50)),
DisplayOrder=2147483647,
})

aL.screenGui=aM
return aM end


aI.calculateScale=function(aL, aM)
return(aL.screenGui.AbsoluteSize.Y/aG)*aM end


aI.setScale=function(aL, aM)
aM=math.abs(aM)

if aM>=3 then
aM=aL:calculateScale(aM)
end

if ai:getValue("interface.uiScale")~=aM then
ai:setValue("interface.uiScale",aM)
ai:save()
end

at:setScale(aM)
aL:updateMainFramePosition()end


aI.calculateMainFramePosition=function(aL, aM)
local aN=aL.mainFrame
local aO=aL.screenGui
local aP=at:getScale()
local aQ=aN.Size

aM=aM or aN.Position

local aR,aS=aK(aM.X,aQ.X.Offset,aO.AbsoluteSize.X,aP)
local aT,aU=aK(aM.Y,aQ.Y.Offset,aO.AbsoluteSize.Y,aP)

return UDim2.new(aR,aS,aT,aU)end


aI.updateMainFramePosition=function(aL)
if not aL.mainFrame then return end

if aL.dock then
aL.dock:reflow()
else
aL.mainFrame.Position=aL:calculateMainFramePosition()
end

aL:updateNotificationsPosition()end


aI.createMainScroll=function(aL, aM)
local aN=aw.new({
isHorizontal=false,
barThickness=12,
})

local aO=aN:create()
local aP=aN.container

local aQ=al.new("Frame","ScrollHolder",aM,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

aO,
aP,
})

aL.scrollHolder=aQ
aL.scrollBar=aN
aL.scrollContainer=aP
aL.scrollBarFrame=aO

return aN end


aI.createMainFrame=function(aL)
local aM=av:create()
local aN=aM.mainFrame

aM.titleLabel.Text=as.getDisplayName()

aL.mainFrame=aN
aL.topBar=aM.topBar
aL.buttons=aM.buttons


ao:attach(aN)

am:loadImage(aL.buttons.settings,"settings")
am:loadImage(aL.buttons.reference,"reference")

aL:createMainScroll(aN)

aL.settings=aB.new({

onOpenChanged=function(aO)
aL:paintTopButton(aL.buttons.settings,aO)
end,


onSwitch=function(aO,aP)
if aO=="keepMenuOpen"and aL.dock then
aL.dock:setKeepOpen(aP)
end


if aO=="keepIY"and aP and ad.queueteleport==nil then
aL:setKeepIY(false)
ar:notify("Keepiy","your exploit does not support queueteleport")
end
end,
})
aL.settings:create(aN,aL.scrollHolder,{aL.scrollContainer,aL.scrollBarFrame})

ae:Connect(aL.buttons.settings.Activated,function()
aL.settings:toggle()
end)

return aN end


aI.createCommands=function(aL)
local aM=aL.scrollBar

local aN=ax.new({
scrolledSignal=aM.scrolledSignal,
scrollContainer=aL.scrollContainer,
scrollHolder=aL.scrollHolder,
screenGui=aL.screenGui,
scrollBar=aM,

configs={
placeholderText=aa.ui.commands.placeholderText,
padding=aa.ui.commands.padding,
labelSize=aa.ui.commands.labelSize,
textSize=aa.ui.commands.textSize,
},
})

aj:log("created commands interface")
aN:create()

aj:log("initialized commands")
aN:createCommandsData()

aj:log("awaked commands module")
aN:awake()

aL.commands=aN


aN.onCommandSent=function()
if aL.dock then
aL.dock:unlockSwipe()
end
end


aN.onInteraction=function()
if aL.dock then
aL.dock:noteInteraction()
end
end

aL.settings:watchCommandBar(aN.searchBox)

if ag then

aN.onSwipeDown=function()
if aL.dock then
aL.dock:onListSwipeDown()
end
end

ae:Connect(aN.searchBox.Focused,function()
aL.commandBarUsedAt=os.clock()
end)

ae:Connect(aN.searchBox.FocusLost,function(aO)
aL.commandBarUsedAt=os.clock()


if aO and aL.dock then
aL.dock:onMobileEnter(function()
return aN.searchBox:IsFocused()
end)
end
end)
else

ae:Connect(aN.searchBox.FocusLost,function(aO)
if aL.dock then
aL.dock:onCommandBarClosed(aO)
end
end)
end

return aN end


aI.createInfoMenu=function(aL)
return az:create()end


aI.chatLogs=function(aL, aM)
return aA:open(aM or"chat")end


aI.dragMainFrame=function(aL, aM)
aM.Size=aa.ui.window.windowSize

aM.Position=UDim2.fromOffset(1e5,1e5)
aM.Position=aL:calculateMainFramePosition()

aL.dock=aE.new({
frame=aM,
screenGui=aL.screenGui,
topBarHeight=aL.topBar.Size.Y.Offset,
keepOpen=aB.isKeepMenuOpen(),
clampPosition=function(aN)
return aL:calculateMainFramePosition(aN)
end,
getScale=function()
return at:getScale()
end,
commandBarInUse=function()
return aL:isCommandBarInUse()
end,
isMoving=function()
return aL:isCharacterMoving()
end,
onInteractive=function(aN)
if aL.commands then
aL.commands:setInteractive(aN)
end
end,
hoverToOpen=not ag,
onMinimize=function()
aL:releaseCommandFocus()


if aL.hidden then
aL:hideWindow()
end
end,
})

aD:addGuiObject(aM)

aD:setFilter(aM,function(aN)
return aL.dock:clampDrag(aN)
end)

aD.dragStarted:Connect(function(aN)
if aN~=aM then return end

aL.dock:cancel()
aL.dock:setDragging(true)
aL.scrollBar:disableScroll()
end)

aD.dragEnded:Connect(function(aN,aO)
if aN~=aM then return end

aL.scrollBar:enableScroll()
aL.dock:setDragging(false)
aL.dock:onDragEnded(aO)
end)end



local aL=0.3

aI.isCommandBarInUse=function(aM)
local aN=aM.commands and aM.commands.searchBox
if aN and aN:IsFocused()then
return true
end

return os.clock()-(aM.commandBarUsedAt or 0)<aL end




aI.isCharacterMoving=function(aM)
local aN=ah:getHumanoid()
if not aN then return false end

if aN.MoveDirection.Magnitude>0.05 then
return true
end

local aO=aN.RootPart
if not aO then return false end

local aP=aO.AssemblyLinearVelocity
return Vector3.new(aP.X,0,aP.Z).Magnitude>1 end


aI.releaseCommandFocus=function(aM)
local aN=aM.commands and aM.commands.searchBox

if aN and aN:IsFocused()then
aN:ReleaseFocus()
end end



aI.showWindow=function(aM)
aM.hidden=false
aM:revealWindow()end




aI.revealWindow=function(aM)
if not aM.mainFrame then return end

aM.mainFrame.Visible=true
if aM.dock then
aM.dock:reveal()
end end



aI.hideWindow=function(aM)
if not aM.mainFrame then return end

aM.hidden=true
aM.mainFrame.Visible=false

if aM.dock then
aM.dock:sleep()
end

aM:releaseCommandFocus()end


aI.showCommandBar=function(aM)
local aN=aM.commands and aM.commands.searchBox
if not aN then return end

aM:revealWindow()



aM.dock:onSettled(function()
if aM.dock.state=="minimized"then return end

aM.commands:ensureFocus()
end)end



aI.setKeepIY=function(aM, aN)
aB.setKeepIY(aN)

if aM.settings then
aM.settings:refresh()
end end


aI.createQuickCapture=function(aM)
if not ag then return end

local aN=al.new("TextButton",ak.randomString(math.random(30,50)),aM.screenGui,{
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
al.new("UICorner",{
CornerRadius=UDim.new(0.5,0)
}),
})

aM.dock:addWindowPart(aN)
aD:addGuiObject(aN)

ae:Connect(aN.Activated,function()
aM:showCommandBar()
end)

aM.quickCapture=aN
return aN end




aI.paintTopButton=function(aM, aN, aO)
if not aN then return end

an:addObject(aN,{
ImageColor3=if aO then"Colors.Primary"else"Colors.Icons",
})end


aI.createReference=function(aM)
local aN=ay.new()
local aO=aN:create()

aN.onOpenChanged=function(aP)
aM:paintTopButton(aM.buttons.reference,aP)
end

am:loadImage(aN.closeIcon,"close")

aO.Parent=aM.screenGui
aM.reference=aN

ae:Connect(aM.buttons.reference.Activated,function()
aN:open()
end)

return aN end


aI.createPartPath=function(aM)
local aN=aC.new()
local aO=aN:create()

aO.Parent=aM.screenGui
aM.partPathWindow=aN

return aN end




aI.openPartPath=function(aM, aN)
if not aM.partPathWindow then return end

aM.partPathWindow:open(aN)end


aI.createNotifications=function(aM)
local aN=ar:getContainer(aM.screenGui)
aM.notificationsContainer=aN

ar.onLayoutChanged=function()
aM:updateNotificationsPosition()
end

aM:updateNotificationsPosition()
return aN end


aI.updateNotificationsPosition=function(aM)
local aN=aM.notificationsContainer
local aO=aM.mainFrame
local aP=aM.screenGui
if not(aN and aO and aP)then return end



local aQ=at:getScale()
local aR=aP.AbsoluteSize/aQ

local aS=aO.Position
local aT=au.compute({
x={scale=aS.X.Scale,offset=aS.X.Offset},
y={scale=aS.Y.Scale,offset=aS.Y.Offset},
width=aO.Size.X.Offset,
height=aO.Size.Y.Offset,
},{
width=aR.X,
height=aR.Y,
},{
width=aN.Size.X.Offset,
},ab.gapToWindow)


ar:setRoom(aT.room)

aN.AnchorPoint=Vector2.new(aT.anchorX,aT.anchorY)
aN.Position=UDim2.new(aT.x.scale,aT.x.offset,aT.y.scale,aT.y.offset)end


aI.destroy=function(aM)
ar:destroy()
if aM.dock then
aM.dock:destroy()
aM.dock=nil
end

aA:reset()

if aM.partPathWindow then
aM.partPathWindow:destroy()
aM.partPathWindow=nil
end

if aM.screenGui then
aM.screenGui:Destroy()
end

aM.screenGui=nil
aM.awoken=false end


return aI end a.dM=function()local ab=a.cache.dM if not ab then ab={c=aa()}a.cache.dM=ab end return ab.c end end do local aa=function()a.e()


:init()a.u()





local aa=a.c1()
local ab=a.c3()
local ac=a.af()
local ad=a.cG()
local ae=a.c9()
local af=a.cA()
local ag=a.c7()



local ah=a.dM()

local ai={}

ai.boot=function(aj)
aj.boot=nil
af.configure(aa,ag.runText)

aa:init({
infiniteYield=ah,
playerService=ac,
fetchService=ad
})

ab.start()


ah:awake()


ae.start()end


return ai end a.dN=function()local ab=a.cache.dN if not ab then ab={c=aa()}a.cache.dN=ab end return ab.c end end end




















return a.dN():boot()