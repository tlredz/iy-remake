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
getrawmetatable=c("function",getrawmetatable),
setreadonly=c("function",
setreadonly or
(make_readonly and make_writeable and function(d,e)
if e then make_readonly(d)else make_writeable(d)end
end)
),
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

imagePath="assets/%s/%s.png",

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
client=true,
action="console",
description="Opens the Roblox console",
run=function(b)
b.starterGui:SetCore("DevConsoleVisible",true)
end
}end a.x=function()local c=a.cache.x if not c then c={c=b()}a.cache.x=c end return c.c end end do local b=function()





local b=3



local c="backups/compiled/"

local d={}


d.path=function(e)
return c..e end





d.fetch=function(e, f, g, h, i)
if not i then
e:notify(f,"started loading")
end

local j=false

task.delay(b,function()
if not j then
e:notify(f,"is taking a while to load, still loading...")
end
end)

local k=e.fetchService.load(d.path(g),h)
j=true

if k==nil then
e:notify(f,"could not be loaded")
elseif not i then
e:notify(f,"finished loading")
end

return k end


return d end a.y=function()local c=a.cache.y if not c then c={c=b()}a.cache.y=c end return c.c end end do local b=function()



local b=a.y().fetch local c=function(

c)
local d=b(c,"Old Console","oldconsole.luau","iy/oldconsole")
if d then d()end end local d=function(


d, e)
local f
if e==true then
f=b(d,"Dex Explorer","explorer.luau","iy/explorer")
else
f=b(d,"Dex Explorer","dexPlusPlus.luau","iy/dexPlusPlus")
end

if f then f()end end local e=function(


e, f)
local g=f:nextValue()
local h=f:nextValue()

local i=b(e,"Emote Menu","emotes.luau","iy/7yd7/emotes.luau")
if not i then return end

i({
notifyEnabled=h,
isMobile=e.isMobile,
keycode=g,
})end local f=function(


f)
local g=b(f,"Cobalt","cobalt.luau","iy/cobalt")
if g then g()end end local g=function(


g)
local h=b(g,"Remote Spy","remotespy.luau","iy/remotespy")
if h then h()end end local h=function(


h)
local i=b(h,"Audio Logger","audiologger.luau","iy/audiologger")
if i then i()end end


return{
{
client=true,
action="oldconsole",
description="Loads an old-themed Roblox console",
run=function(i)task.spawn(c,i)end
},
{
client=true,
action="explorer|dex",
description="Opens the dex Explorer",
args={name="load dex by moon",kind="boolean",optional=true},
run=function(i,j)task.spawn(d,i,j:nextValue())end
},
{
client=true,
action="emotemenu|7yd7",
description="Opens animations/emotes menu By 7yd7",
run=function(i,j)task.spawn(e,i,j)end,
args={
{kind="keycode",name="open menu",optional=true},
{kind="boolean",name="notify",optional=true},
}
},
{
client=true,
action="cobalt|remotespy|rspy|cspy",
description="Opens Cobalt to intercept incoming and outgoing network traffic",
run=function(i)task.spawn(f,i)end
},
{
client=true,
action="simplespy|simplespy|sspy",
description="Opens Simple Spy V3 to intercept remote calls from the client to the server",
run=function(i)task.spawn(g,i)end
},
{
client=true,
action="audiologger|alogger",
description="Opens Edges audio logger",
run=function(i)task.spawn(h,i)end
}
}end a.z=function()local c=a.cache.z if not c then c={c=b()}a.cache.z=c end return c.c end end do local b=function()

return{
action="serverinfo|info|sinfo",
description="Gives you info about the server",
run=function(b)
b.infiniteYield:createInfoMenu()
end
}end a.A=function()local c=a.cache.A if not c then c={c=b()}a.cache.A=c end return c.c end end do local b=function()
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
}end a.B=function()local c=a.cache.B if not c then c={c=b()}a.cache.B=c end return c.c end end do local b=function()local b=function(


b)
local c=game.CreatorId

if game.CreatorType~=Enum.CreatorType.User then
c=b.groupService:GetGroupInfoAsync(c).Owner.Id
end

return c end


return{
{
action="creatorid",
description="Notifies the creator's ID. Its copy button copies the ID",
run=function(c)
local d=tostring(b(c))

c:notify("Creator Id",`the OwnerId is '{d}'`,nil,{copy=true,copyText=d})
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
}end a.C=function()local c=a.cache.C if not c then c={c=b()}a.cache.C=c end return c.c end end do local b=function()

return{
action="rejoin|rj",
description="Makes you rejoin the game",
run=function(b)
b.playerService:teleportToJobId(game.JobId)
end
}end a.D=function()local c=a.cache.D if not c then c={c=b()}a.cache.D=c end return c.c end end do local b=function()
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
}end a.E=function()local c=a.cache.E if not c then c={c=b()}a.cache.E=c end return c.c end end do local b=function()



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
}end a.F=function()local c=a.cache.F if not c then c={c=b()}a.cache.F=c end return c.c end end do local b=function()

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
}end a.G=function()local c=a.cache.G if not c then c={c=b()}a.cache.G=c end return c.c end end do local b=function()
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
}end a.H=function()local c=a.cache.H if not c then c={c=b()}a.cache.H=c end return c.c end end do local b=function()
return{
client=true,
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
}end a.I=function()local c=a.cache.I if not c then c={c=b()}a.cache.I=c end return c.c end end do local b=function()
return{
client=true,
action="datalimit",
description="Set outgoing KBPS limit",
args={kind="number",name="KB per second"},
run=function(b,c)
local d=c:nextValue()
b.networkClient:SetOutgoingKBPSLimit(d)
end
}end a.J=function()local c=a.cache.J if not c then c={c=b()}a.cache.J=c end return c.c end end do local b=function()
return{
client=true,
action="replicationlag|backtrack",
description="Set IncomingReplicationLag",
args={kind="number"},
run=function(b,c)
b.gameNetworkSettings.IncomingReplicationLag=c:nextValue()
end
}end a.K=function()local c=a.cache.K if not c then c={c=b()}a.cache.K=c end return c.c end end do local b=function()
return{
client=true,
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
}end a.L=function()local c=a.cache.L if not c then c={c=b()}a.cache.L=c end return c.c end end do local b=function()local b=function(
b)
if not b:IsA("PackageLink")then return end

if b.Parent:FindFirstChild("ADpart")then
b.Parent:Destroy()
end

if b.Parent:FindFirstChild("AdGuiAdornee")then
b.Parent.Parent:Destroy()
end end


return{
client=true,
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
}end a.M=function()local c=a.cache.M if not c then c={c=b()}a.cache.M=c end return c.c end end do local b=function()


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
}end a.N=function()local c=a.cache.N if not c then c={c=b()}a.cache.N=c end return c.c end end do local b=function()

return{
action="clearerror",
description="Clears the annoying box and blur when a game kicks you",
run=function(b)
b.guiService:ClearError()
end
}end a.O=function()local c=a.cache.O if not c then c={c=b()}a.cache.O=c end return c.c end end do local b=function()

local b="CoreScripts/NetworkPause"local c=function(

c)
local d=c:collectGarbage("antigameplaypaused")
if d then
d.connection:Disconnect()
end end


return{
{
client=true,
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
client=true,
action="unantigameplaypaused",
description="Disables antigameplaypaused",
run=function(d)
c(d)
end
}
}end a.P=function()local c=a.cache.P if not c then c={c=b()}a.cache.P=c end return c.c end end do local b=function()

return{
client=true,
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
client=true,
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
client=true,
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
client=true,
action="record|rec",
description="Starts Roblox recorder",
run=function(b)
b.coreGui:ToggleRecording()
end
},
{
client=true,
action="screenshot|scrnshot",
description="Takes a screenshot",
run=function(b)
b.coreGui:TakeScreenshot()
end
},
{
client=true,
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
client=true,
action="norender",
description="Disable 3d Rendering to decrease the amount of CPU the client uses",
run=function(b)
b.runService:Set3dRenderingEnabled(false)
end
},
{
client=true,
action="render",
description="Enable 3d Rendering",
run=function(b)
b.runService:Set3dRenderingEnabled(true)
end
}
}end a.Z=function()local c=a.cache.Z if not c then c={c=b()}a.cache.Z=c end return c.c end end do local b=function()
return{
{
client=true,
action="use2022materials|2022materials",
description="Enables 2022 material textures",
run=function(b)
b.rbxServices.MaterialService.Use2022Materials=true
end
},
{
client=true,
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
client=true,
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
client=true,
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
client=true,
action="ctrllock",
description="Binds Shiftlock to LeftControl",
run=function(c)
b(c,"LeftControl")
end
},
{
client=true,
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
description="Notifies the JobId and PlaceId of the current server. Its copy button copies them",
run=function(b)
b:notify("JobId / PlaceId",`{game.JobId} / {game.PlaceId}`,nil,{copy=true})
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
c:notify("Appearance ID",tostring(f.CharacterAppearanceId),nil,{copy=true})
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
client=true,
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
client=true,
action="enable",
description="Enables a CoreGui element (inventory, leaderboard, chat, reset, emotes...)",
args={kind="string",name="gui name"},
run=function(d,e)
c(d,e:nextValue():lower(),true)
end
},
{
client=true,
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
client=true,
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
client=true,
action="respawn",
description="Respawns your character in place (client side)",
run=function(c)
b(c)
end
},
{
client=true,
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
client=true,
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
client=true,
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














local b=a.a()
local c=a.b()

local d={"Folder","MeshPart","Decal","Attachment"}

local e={}

local f=c.objectDecoy
if f==nil then
f={
enabled=false,
method=nil,
hooked=false,
originals={},
protectedObjects=setmetatable({},{__mode="k"}),
spoofedFlags=setmetatable({},{__mode="k"}),
spoofedValues=setmetatable({},{__mode="k"}),
}
c.objectDecoy=f
end local g=function(

g, h)
local i=f.spoofedFlags[g]
return i~=nil and i[h]==true end local h=function()



return Instance.new(d[math.random(#d)])end local i=function(



i, j)
if f.hooked then
return f.originals.index(i,j)
end
return i[j]end local j=function(


j, k, l)
if f.hooked then
f.originals.newindex(j,k,l)
return
end
j[k]=l end local k=function(


k, l, m)
if f.enabled then
if g(k,l)then
f.spoofedValues[k][l]=m
return
end


local n=f.protectedObjects[k]
if n and l~="Parent"and pcall(f.originals.newindex,n.decoy,l,m)then
return
end
end

return f.originals.newindex(k,l,m)end local l=function(


l, m)
if f.enabled then
if g(l,m)then
return f.spoofedValues[l][m]
end

local n=f.protectedObjects[l]
if n then
local o,p=pcall(f.originals.index,n.decoy,m)
if o then
return p
end
end
end

return f.originals.index(l,m)end local m=function(



m, n, o)
if m=="getrawmetatable"then
local p=b.getrawmetatable(game)
local q=p[n]
b.setreadonly(p,false)
p[n]=o
b.setreadonly(p,true)
return q
end

return b.hookmetamethod(game,n,o)end local n=function()



if f.originals.newindex==nil then
f.originals.newindex=m(f.method,"__newindex",k)
end
if f.originals.index==nil then
f.originals.index=m(f.method,"__index",l)
end
f.hooked=true end local o=function(









































































o)
local p=Instance.new("Folder")
local q=false
local r
local s=false

local t,u=pcall(function()
r=m(o,"__index",function(t,u)
if t==p then
q=true
end
return r(t,u)
end)
s=true

local t=p.Name
return q
end)

if s then
pcall(m,o,"__index",r)
end

return t and u==true end local p=function()



if typeof(b.hookmetamethod)~="function"then
return false
end
return o("hookmetamethod")end local q=function()



if typeof(b.getrawmetatable)~="function"or typeof(b.setreadonly)~="function"then
return false
end
return o("getrawmetatable")end




e.test=function()
local r={}

r.hookmetamethod=p()
if r.hookmetamethod then
return"hookmetamethod",r
end

r.getrawmetatable=q()
if r.getrawmetatable then
return"getrawmetatable",r
end

return nil,r end



e.runTest=function(r)
local s,t=e.test()

local u={}
for v,w in{"hookmetamethod","getrawmetatable"}do
if t[w]~=nil then
local x=if t[w]then"works"else"does not work"
table.insert(u,`{w} {x}`)
end
end
local v=table.concat(u,", ")

if s==nil then
r:notify("Client bypass test",`{v}. Neither works, so the client bypass cannot be turned on here.`)
else
r:notify("Client bypass test",`{v}. Using {s}.`)
end end


e.enable=function(r)
if f.enabled then
r:notify("Client bypass","already on")
return true
end

local s=f.method or e.test()
if s==nil then
r:notify("Client bypass","could not turn on: neither hookmetamethod nor getrawmetatable works in this executor")
return false
end

f.method=s
local t,u=pcall(n)
if not t then
r:notify("Client bypass",`could not turn on: {u}`)
return false
end

f.enabled=true
r:notify("Client bypass",`on, using {s}`)
return true end


e.disable=function(r)
if not f.enabled then
r:notify("Client bypass","already off")
return false
end

f.enabled=false
r:notify("Client bypass","off: hidden objects show their real values again")
return true end


e.isEnabled=function()
return f.enabled end




e.protect=function(r)
assert(typeof(r)=="Instance","objectDecoy.protect: expected an Instance")

if f.enabled and f.protectedObjects[r]==nil then
f.protectedObjects[r]={decoy=h()}
end

return r end


e.isProtected=function(r)
return f.protectedObjects[r]~=nil end




e.createProtected=function(r, s)
local t=Instance.new(r)
local u

for v,w in s or{}do
if v=="Parent"then
u=w
else
t[v]=w
end
end


e.protect(t)
t.Parent=u
return t end




e.destroy=function(r)
local s=i(r,"Destroy")
s(r)end



e.getProperty=function(r, s)
return i(r,s)end



e.setProperty=function(r, s, t)
if not f.enabled then
j(r,s,t)
return
end

local u=f.spoofedFlags[r]
if u==nil then
u={}
f.spoofedFlags[r]=u
f.spoofedValues[r]={}
end

if not u[s]then
u[s]=true
f.spoofedValues[r][s]=i(r,s)
end

j(r,s,t)end


return e end a.aw=function()local c=a.cache.aw if not c then c={c=b()}a.cache.aw=c end return c.c end end do local b=function()



local b=a.aw()

return{
{
client=true,
action="clientbypass",
description="Hides the objects that fly, vfly and float create from the game's scripts",
run=function(c)
b.enable(c)
end
},
{
client=true,
action="unclientbypass",
description="Turns the client bypass off, so the objects show their real values again",
run=function(c)
b.disable(c)
end
}
}end a.ax=function()local c=a.cache.ax if not c then c={c=b()}a.cache.ax=c end return c.c end end do local b=function()



local b=a.aw()

return{
{
client=true,
action="testbypass",
description="Tests which hook method works in this executor (hookmetamethod, or getrawmetatable as fallback)",
run=function(c)
b.runTest(c)
end
}
}end a.ay=function()local c=a.cache.ay if not c then c={c=b()}a.cache.ay=c end return c.c end end do local b=function()

return{
client=true,
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
}end a.az=function()local c=a.cache.az if not c then c={c=b()}a.cache.az=c end return c.c end end do local b=function()

return{a.ax()
,a.ay()
,a.az()
,
}end a.aA=function()local c=a.cache.aA if not c then c={c=b()}a.cache.aA=c end return c.c end end do local b=function()

return"v0.10.2"end a.aB=function()local c=a.cache.aB if not c then c={c=b()}a.cache.aB=c end return c.c end end do local b=function()
return{
owner="tlredz",
repository="iy-remake"
}end a.aC=function()local c=a.cache.aC if not c then c={c=b()}a.cache.aC=c end return c.c end end do local b=function()
local b=a.aC()

return{
discord="https://discord.gg/78ZuWSq",
github=`https://github.com/{b.owner}/{b.repository}`
}end a.aD=function()local c=a.cache.aD if not c then c={c=b()}a.cache.aD=c end return c.c end end do local b=function()


local b=a.n()

return{
applicationName="Infinite Yield RV",
isRemakeVersion=true,
version=a.aB(),
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

legacyIconsKey="interface.legacyIcons",
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

links=a.aD(),
storage=a.j(),
}end a.aE=function()local c=a.cache.aE if not c then c={c=b()}a.cache.aE=c end return c.c end end do local b=function()
local b=a.aE().ui.scale

return{
client=true,
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
}end a.aF=function()local c=a.cache.aF if not c then c={c=b()}a.cache.aF=c end return c.c end end do local b=function()
return{
{
client=true,
action="noprompts|nopurchaseprompts",
description="Prevents the game from showing you purchase/premium prompts",
run=function(b)
b.coreGui.PurchasePromptApp.Enabled=false
end
},
{
client=true,
action="showprompts|showpurchaseprompts",
description="Allows the game to show purchase/premium prompts again",
run=function(b)
b.coreGui.PurchasePromptApp.Enabled=true
end
}
}end a.aG=function()local c=a.cache.aG if not c then c={c=b()}a.cache.aG=c end return c.c end end do local b=function()
local b={inventory=
Enum.CoreGuiType.Backpack,leaderboard=
Enum.CoreGuiType.PlayerList,emotes=
Enum.CoreGuiType.EmotesMenu
}

for c,d in Enum.CoreGuiType:GetEnumItems()do
b[string.lower(d.Name)]=d
end

return{
client=true,
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
}end a.aH=function()local c=a.cache.aH if not c then c={c=b()}a.cache.aH=c end return c.c end end do local b=function()local b=function(
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
client=true,
action="showguis",
description="Shows any invisible GUIs",
run=function(d)
c(d,"visibleGuiObjects",true)
end
},
{
client=true,
action="unshowguis",
description="Undoes showguis",
run=function(d)
b(d,"visibleGuiObjects")
end
},
{
client=true,
action="hideguis",
description="Hides any GUIs in PlayerGui",
run=function(d)
c(d,"invisibleGuiObjects",false)
end
},
{
client=true,
action="unhideguis",
description="Undoes hideguis",
run=function(d)
b(d,"invisibleGuiObjects")
end
}
}end a.aI=function()local c=a.cache.aI if not c then c={c=b()}a.cache.aI=c end return c.c end end do local b=function()
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


return b end a.aJ=function()local c=a.cache.aJ if not c then c={c=b()}a.cache.aJ=c end return c.c end end do local b=function()












return{
bindings={
prefix={
label="Prefix",
settingKey="keybinds.prefix",
default="Semicolon",
also={"RightControl"},
group="interface",
icon="lucide-terminal",
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
}end a.aK=function()local c=a.cache.aK if not c then c={c=b()}a.cache.aK=c end return c.c end end do local b=function()local b=function(

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
})end a.aL=function()local c=a.cache.aL if not c then c={c=b()}a.cache.aL=c end return c.c end end do local b=function()









local b=a.f()
local c=a.aJ()
local d=a.n()
local e=a.aK()
local f=a.aL()

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


return h end a.aM=function()local c=a.cache.aM if not c then c={c=b()}a.cache.aM=c end return c.c end end do local b=function()





local b=a.aM()local c=function(

c)
local d=c.infiniteYield
if not d or not d.mainFrame then
c:notify("IY","the main window is not created yet")
return
end

if not d.mainFrame.Visible then
c:notify("IY","already hidden")
return
end

d:hideWindow()

local e=b:getBindingName("prefix")
c:notify("IY",`hidden. Press {e} or tap the IY button to type a command`)end local d=function(


d)
local e=d.infiniteYield
if e then
e:showWindow()
end end


return{
{
client=true,
action="hideiy|hideinterface",
description="Hides the main IY GUI",
run=function(e)
c(e)
end
},
{
client=true,
action="showiy|unhideiy|unhideinterface",
description="Shows IY again",
run=function(e)
d(e)
end
},
}end a.aN=function()local c=a.cache.aN if not c then c={c=b()}a.cache.aN=c end return c.c end end do local b=function()

return{a.aF()


,a.aG()
,a.aH()
,a.aI()
,a.aN()

,

}end a.aO=function()local c=a.cache.aO if not c then c={c=b()}a.cache.aO=c end return c.c end end do local b=function()






local b=a.f()
local c=a.aM()
local d=a.aw()

local e=b.UserInputService

local f={}

local g=Vector3.one*9e9 local h=function(


h)
local i=Vector3.new(h.X,0,h.Z)
if i.Magnitude==0 then
return Vector3.zero
end
return i.Unit end local i=function(



i, j)
local k=workspace.CurrentCamera.CFrame
local l=j.MoveDirection

local m=l:Dot(h(k.LookVector))
local n=l:Dot(h(k.RightVector))

local o=0
if i.privateEnv.qeFly~=false then
if e:IsKeyDown(c:getBinding("flyUp"))then
o=o+1
end
if e:IsKeyDown(c:getBinding("flyDown"))then
o=o-1
end
end

local p=k.LookVector*m+k.RightVector*n+Vector3.yAxis*o
if p.Magnitude>1 then
p=p.Unit
end
return p end local j=function(




j)
local k={}
local l=j.Parent
if l then
for m,n in l:GetChildren()do
if n:IsA("BasePart")and n~=j then
table.insert(k,n)
end
end
end

if#k==0 then
return j
end
return k[math.random(#k)]end



f.stop=function(k, l)
local m=k:collectGarbage(l)
if not m then return end

if m.connection then
m.connection:Disconnect()
end
if m.velocity then
d.destroy(m.velocity)
end
if m.gyro then
d.destroy(m.gyro)
end
if m.humanoid then
d.setProperty(m.humanoid,"PlatformStand",false)
end end






f.start=function(k, l)
f.stop(k,l.garbageName)

local m=k.playerService:getHumanoid()
local n=k.playerService:getRootPart()
if not(m and n)then
k:notify("Fly","your character is not loaded")
return
end

local o=d.createProtected("BodyVelocity",{
MaxForce=g,
Velocity=Vector3.zero,
Parent=j(n),
})

local p=d.createProtected("BodyGyro",{
MaxTorque=g,
P=9e4,
CFrame=n.CFrame,
Parent=j(n),
})

if l.platformStand then
d.setProperty(m,"PlatformStand",true)
end

local q=k:createGarbage(l.garbageName)
q.velocity=o
q.gyro=p
q.humanoid=m
q.kind=l.kind

q.connection=k:connect(k.runService.Heartbeat,function()
if not n:IsDescendantOf(workspace)or m.Health<=0 then
f.stop(k,l.garbageName)
return
end

d.setProperty(o,"Velocity",i(k,m)*l.getSpeed())
d.setProperty(p,"CFrame",workspace.CurrentCamera.CFrame)
end)end


return f end a.aP=function()local c=a.cache.aP if not c then c={c=b()}a.cache.aP=c end return c.c end end do local b=function()

local b=a.aP()

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
}end a.aQ=function()local c=a.cache.aQ if not c then c={c=b()}a.cache.aQ=c end return c.c end end do local b=function()

local b=a.aw()


local c="Noclip"
local d={kind="string",name="nonotify",optional=true}local e=function(

e)
local f=e:collectGarbage("noclip")
if not f then return false end

f.connection:Disconnect()

for g in f.parts do
if g.Parent then
b.setProperty(g,"CanCollide",true)
end
end

return true end local f=function(


f)
local g=f:createGarbage("noclip")
g.parts=setmetatable({},{__mode="k"})

g.connection=f:connect(f.runService.Stepped,function()
local h=f.playerService:getCharacter()
if not h then return end

local i=f:getGarbage("float")
local j=i and i.platform

for k,l in h:GetDescendants()do
if l:IsA("BasePart")and l.CanCollide and l~=j then
b.setProperty(l,"CanCollide",false)
g.parts[l]=true
end
end
end)end


return{
{
action="noclip",
description="Go through objects",
args=d,
run=function(g,h)
local i=h:nextValue()=="nonotify"

e(g)
f(g)

if not i then
g:notify(c,"Noclip Enabled")
end
end
},
{
action="unnoclip|clip",
description="Disables noclip",
args=d,
run=function(g,h)
local i=h:nextValue()=="nonotify"
e(g)

if not i then
g:notify(c,"Noclip Disabled")
end
end
},
{
action="togglenoclip",
description="Toggles noclip",
run=function(g)
g:run(if g:hasGarbage("noclip")then"unnoclip"else"noclip")
end
}
}end a.aR=function()local c=a.cache.aR if not c then c={c=b()}a.cache.aR=c end return c.c end end do local b=function()

local b=a.aP()

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
}end a.aS=function()local c=a.cache.aS if not c then c={c=b()}a.cache.aS=c end return c.c end end do local b=function()

local b=a.aw()
local c=50 local d=function(


d)
local e=d:collectGarbage("cframefly")
if not e then return end

e.connection:Disconnect()
b.setProperty(e.humanoid,"PlatformStand",false)
e.head.Anchored=false end local e=function(



e)
d(e)

local f=e.playerService:getHumanoid()
local g=e.playerService:getCharacter()
local h=g and g:FindFirstChild("Head")
if not(f and h)then
e:notify("cframefly","your character is not loaded")
return
end

b.setProperty(f,"PlatformStand",true)
h.Anchored=true

local i=e:createGarbage("cframefly")
i.humanoid=f
i.head=h
i.connection=e:connect(e.runService.Heartbeat,function(j)
if not h:IsDescendantOf(workspace)then
d(e)
return
end

local k=e.privateEnv.cframeFlySpeed or c
local l=f.MoveDirection*(k*j)

local m=h.CFrame
local n=workspace.CurrentCamera.CFrame
local o=m:ToObjectSpace(n).Position
n=n*CFrame.new(-o.X,-o.Y,-o.Z+1)

local p=n.Position
local q=m.Position
local r=CFrame.new(p,Vector3.new(q.X,p.Y,q.Z)):VectorToObjectSpace(l)

h.CFrame=CFrame.new(q)*(n-p)*CFrame.new(r)
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
run=function(f,g)
local h=g:nextValue()
if h then
f.privateEnv.cframeFlySpeed=h
end
e(f)
end
},
{
action="cframeflyspeed|cflyspeed",
description="Sets cfly speed",
args={
kind="number"
},
run=function(f,g)
f.privateEnv.cframeFlySpeed=g:nextValue()or c
end
},
{
action="uncframefly|uncfly",
description="Disables cfly",
run=function(f)
d(f)
end
}
}end a.aT=function()local c=a.cache.aT if not c then c={c=b()}a.cache.aT=c end return c.c end end do local b=function()

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
}end a.aU=function()local c=a.cache.aU if not c then c={c=b()}a.cache.aU=c end return c.c end end do local b=function()local b=function(


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
}end a.aV=function()local c=a.cache.aV if not c then c={c=b()}a.cache.aV=c end return c.c end end do local b=function()

local b=a.aM()
local c=a.aw()

local d=-3.1 local e=function(

e)
local f=e:collectGarbage("float")
if not f then return end

for g,h in f.connections do
h:Disconnect()
end
c.destroy(f.platform)end local f=function(


f)
if f:hasGarbage("float")then
f:notify("float is already enabled")
return
end

local g=f.playerService:getCharacter()
local h=f.playerService:getRootPart()
if not(g and h)then
f:notify("Float","your character is not loaded")
return
end

local i=c.createProtected("Part",{
Name="IYFloatPlatform",
Transparency=1,
Size=Vector3.new(2,0.2,1.5),
Anchored=true,
CFrame=h.CFrame*CFrame.new(0,d,0),
Parent=g,
})

local j=f:createGarbage("float")
j.platform=i
j.offset=d
j.connections={}

table.insert(j.connections,f:connect(f.runService.Heartbeat,function()
local k=f.playerService:getRootPart()
if not(k and i:IsDescendantOf(workspace))then
e(f)
return
end

c.setProperty(i,"CFrame",k.CFrame*CFrame.new(0,j.offset,0))
end))



table.insert(j.connections,f:connect(f.robloxServices.UserInputService.InputBegan,function(k,l)
if l then return end

if k.KeyCode==b:getBinding("floatUp")then
j.offset=j.offset+1.5
elseif k.KeyCode==b:getBinding("floatDown")then
j.offset=j.offset-0.5
end
end))

table.insert(j.connections,f:connect(f.robloxServices.UserInputService.InputEnded,function(k)
if k.KeyCode==b:getBinding("floatUp")then
j.offset=j.offset-1.5
elseif k.KeyCode==b:getBinding("floatDown")then
j.offset=j.offset+0.5
end
end))

f:notify("Float",`Enabled ({b:getBindingName("floatDown")} = down & {b:getBindingName("floatUp")} = up)`)end


return{
{
action="float|platform",
description="Spawns a platform beneath you causing you to float",
run=function(g)
f(g)
end
},
{
action="togglefloat",
description="Toggles float",
run=function(g)
g:run(if g:hasGarbage("float")then"unfloat"else"float")
end
},
{
action="unfloat|noplatform|nofloat|unplatform",
description="Removes the platform",
run=function(g)
if not g:hasGarbage("float")then return end

e(g)
g:notify("Float","Disabled")
end
}
}end a.aW=function()local c=a.cache.aW if not c then c={c=b()}a.cache.aW=c end return c.c end end do local b=function()local b=function()



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
}end a.aX=function()local c=a.cache.aX if not c then c={c=b()}a.cache.aX=c end return c.c end end do local b=function()

local b=a.aw()local c=function(

c, d, e)
local f=c.playerService:getHumanoid()
if f then
b.setProperty(f,d,e)
end end local d=function(


d, e, f, g)
return{
action=d,
description=e,
run=function(h)
c(h,f,g)
end
}end


return{
{
action="speed|ws|walkspeed",
description="Sets your walk speed (default is 16)",
args={kind="number",name="walk speed",optional=true},
run=function(e,f)
c(e,"WalkSpeed",f:nextValue()or 16)
end
},
{
action="jpower|jumppower|jp",
description="Sets your jump power (default is 50)",
args={kind="number",name="jump power",optional=true},
run=function(e,f)
local g=e.playerService:getHumanoid()
if not g then return end

local h=f:nextValue()or 50
local i=if g.UseJumpPower then"JumpPower"else"JumpHeight"
b.setProperty(g,i,h)
end
},
{
action="maxslopeangle|msa",
description="Sets the max slope angle your humanoid can walk up (default is 89)",
args={kind="number",name="angle",optional=true},
run=function(e,f)
c(e,"MaxSlopeAngle",f:nextValue()or 89)
end
},
{
action="hipheight|hheight",
description="Sets your hip height (default depends on your rig)",
args={kind="number",name="hip height",optional=true},
run=function(e,f)
local g=e.playerService:getHumanoid()
if not g then return end

local h=g.RigType==Enum.HumanoidRigType.R15
b.setProperty(g,"HipHeight",f:nextValue()or(h and 2.1 or 0))
end
},
d("stun|platformstand","Makes your character stiff (PlatformStand)","PlatformStand",true),
d("unstun|nostun|unplatformstand|noplatformstand","Disables stun","PlatformStand",false),
d("norotate|noautorotate","Stops your character from auto rotating","AutoRotate",false),
d("unnorotate|autorotate","Lets your character auto rotate again","AutoRotate",true),
{
action="trip",
description="Trips your character forward",
run=function(e)
local f=e.playerService:getHumanoid()
local g=e.playerService:getRootPart()
if not(f and g)then return end

f:ChangeState(Enum.HumanoidStateType.FallingDown)
g.AssemblyLinearVelocity=g.CFrame.LookVector*30
end
},
{
action="breakvelocity",
description="Stops the character's movement for one second",
run=function(e)
local f=e.localPlayer.Character
if not f then return end

local g=os.clock()
task.spawn(function()
while os.clock()-g<1 do
for h,i in f:GetDescendants()do
if i:IsA("BasePart")then
i.AssemblyLinearVelocity=Vector3.zero
i.AssemblyAngularVelocity=Vector3.zero
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
run=function(e)
local f=e.localPlayer.Character
if not f then return end

local g={
"BodyVelocity","BodyGyro","RocketPropulsion","BodyThrust",
"BodyAngularVelocity","AngularVelocity","BodyForce","VectorForce","LineForce"
}

for h,i in f:GetDescendants()do
for j,k in g do
if i:IsA(k)then
b.destroy(i)
break
end
end
end
end
}
}end a.aY=function()local c=a.cache.aY if not c then c={c=b()}a.cache.aY=c end return c.c end end do local b=function()local b=function(
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
client=true,
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
client=true,
action="unnilchar|nonilchar",
description="Puts your character back into the workspace",
run=function(e)
local f=e.localPlayer.Character
if f then
f.Parent=workspace
end
end
}
}end a.aZ=function()local c=a.cache.aZ if not c then c={c=b()}a.cache.aZ=c end return c.c end end do local b=function()local b=function(


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
}end a.a_=function()local c=a.cache.a_ if not c then c={c=b()}a.cache.a_=c end return c.c end end do local b=function()

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
}end a.a0=function()local c=a.cache.a0 if not c then c={c=b()}a.cache.a0=c end return c.c end end do local b=function()

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
}end a.a1=function()local c=a.cache.a1 if not c then c={c=b()}a.cache.a1=c end return c.c end end do local b=function()local b=function(

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
}end a.a2=function()local c=a.cache.a2 if not c then c={c=b()}a.cache.a2=c end return c.c end end do local b=function()


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
}end a.a3=function()local c=a.cache.a3 if not c then c={c=b()}a.cache.a3=c end return c.c end end do local b=function()

local b=a.aw()local c=function(
c)
local d=c:collectGarbage("spasm")
if d and d.track then
d.track:Stop()
d.track:Destroy()
end end local d=function(


d)
for e,f in d:GetChildren()do
if f.Name=="Spinning"then
f:Destroy()
end
end end


return{
{
action="spasm",
description="Makes your R6 character spasm (uses an animation)",
run=function(e)
local f=e.playerService:getHumanoid()
if not f then return end

if f.RigType==Enum.HumanoidRigType.R15 then
e:notify("R6 Required","This command requires the r6 rig type")
return
end

c(e)

local g=Instance.new("Animation")
g.AnimationId="rbxassetid://33796059"

local h=f:LoadAnimation(g)
h:Play()
h:AdjustSpeed(99)

e:registerGarbage("spasm").track=h
end
},
{
action="unspasm|nospasm",
description="Stops the spasm",
run=function(e)
c(e)
end
},
{
action="headthrow",
description="Throws your R6 character's head (uses an animation)",
run=function(e)
local f=e.playerService:getHumanoid()
if not f then return end

if f.RigType==Enum.HumanoidRigType.R15 then
e:notify("R6 Required","This command requires the r6 rig type")
return
end

local g=Instance.new("Animation")
g.AnimationId="rbxassetid://35154961"

local h=f:LoadAnimation(g)
h:Play(0)
h:AdjustSpeed(1)
end
},
{
action="sitwalk",
description="Uses the sit animation while walking, running and jumping",
run=function(e)
local f=e.localPlayer.Character
local g=e.playerService:getHumanoid()
local h=f and f:FindFirstChild("Animate")
if not(g and h)then return end

local i=h:FindFirstChild("sit")
local j=i and i:FindFirstChildWhichIsA("Animation")
if not j then return end

for k,l in{"idle","walk","run","jump"}do
local m=h:FindFirstChild(l)
local n=m and m:FindFirstChildWhichIsA("Animation")
if n then
n.AnimationId=j.AnimationId
end
end

b.setProperty(g,"HipHeight",g.RigType==Enum.HumanoidRigType.R15 and 0.5 or-1.5)
end
},
{
action="spin",
description="Spins your character (default speed is 20)",
args={kind="number",name="spin speed",optional=true},
run=function(e,f)
local g=e:getRoot()
if not g then return end

d(g)

local h=Instance.new("BodyAngularVelocity")
h.Name="Spinning"
h.MaxTorque=Vector3.new(0,math.huge,0)
h.AngularVelocity=Vector3.new(0,f:nextValue()or 20,0)
h.Parent=g
end
},
{
action="unspin",
description="Stops spinning your character",
run=function(e)
local f=e.playerService:getRootPart()
if f then
d(f)
end
end
}
}end a.a4=function()local c=a.cache.a4 if not c then c={c=b()}a.cache.a4=c end return c.c end end do local b=function()local b=function(

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
}end a.a5=function()local c=a.cache.a5 if not c then c={c=b()}a.cache.a5=c end return c.c end end do local b=function()

return{
{
client=true,
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
client=true,
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
}end a.a6=function()local c=a.cache.a6 if not c then c={c=b()}a.cache.a6=c end return c.c end end do local b=function()local b=function(




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
}end a.a7=function()local c=a.cache.a7 if not c then c={c=b()}a.cache.a7=c end return c.c end end do local b=function()

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
}end a.a8=function()local c=a.cache.a8 if not c then c={c=b()}a.cache.a8=c end return c.c end end do local b=function()

local b=a.aw()local c=function(

c, d)
b.setProperty(c,"WalkSpeed",d)end local d=function(


d, e)
local f=if d.UseJumpPower then"JumpPower"else"JumpHeight"
b.setProperty(d,f,e)end local e=function(


e, f)
local g=e:collectGarbage(f)
if g and g.connections then
for h,i in g.connections do
i:Disconnect()
end
end end local f=function(



f, g, h, i, j)
e(f,g)

local k=f:createGarbage(g)
k.connections={}local l=function(

l)
i(l,j)
table.insert(k.connections,f:connect(l:GetPropertyChangedSignal(h),function()
i(l,j)
end))end


local m=f.playerService:getHumanoid()
if m then
l(m)
end

table.insert(k.connections,f:connect(f.localPlayer.CharacterAdded,function(n)
l(n:WaitForChild("Humanoid"))
end))end


return{
{
action="loopspeed|loopws",
description="Keeps your walk speed set, even after respawning (default is 16)",
args={kind="number",name="walk speed",optional=true},
run=function(g,h)
f(g,"loopspeed","WalkSpeed",c,h:nextValue()or 16)
end
},
{
action="unloopspeed|unloopws",
description="Stops the walk speed loop",
run=function(g)
e(g,"loopspeed")
end
},
{
action="loopjumppower|loopjp|loopjpower",
description="Keeps your jump power set, even after respawning (default is 50)",
args={kind="number",name="jump power",optional=true},
run=function(g,h)
f(g,"loopjumppower","JumpPower",d,h:nextValue()or 50)
end
},
{
action="unloopjumppower|unloopjp|unloopjpower",
description="Stops the jump power loop",
run=function(g)
e(g,"loopjumppower")
end
}
}end a.a9=function()local c=a.cache.a9 if not c then c={c=b()}a.cache.a9=c end return c.c end end do local b=function()

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
}end a.ba=function()local c=a.cache.ba if not c then c={c=b()}a.cache.ba=c end return c.c end end do local b=function()local b=function(


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
}end a.bb=function()local c=a.cache.bb if not c then c={c=b()}a.cache.bb=c end return c.c end end do local b=function()local b=function(

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
}end a.bc=function()local c=a.cache.bc if not c then c={c=b()}a.cache.bc=c end return c.c end end do local b=function()local b=function(


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
}end a.bd=function()local c=a.cache.bd if not c then c={c=b()}a.cache.bd=c end return c.c end end do local b=function()



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
}end a.be=function()local c=a.cache.be if not c then c={c=b()}a.cache.be=c end return c.c end end do local b=function()

local b=a.aw()local c=function(


c, d)
local e=c:collectGarbage(d)
if e then
e.connection:Disconnect()
end end local d=function(



d, e)
local f=d.CFrame.LookVector*3
local g=Ray.new(d.Position-Vector3.new(0,1.5,0),f)
local h=Ray.new(d.Position+Vector3.new(0,1.5,0),f)

return workspace:FindPartOnRay(g,e)~=nil or workspace:FindPartOnRay(h,e)~=nil end


return{
{
action="autojump|ajump",
description="Automatically jumps when you run into an object",
run=function(e)
c(e,"autojump")

local f=e:createGarbage("autojump")
f.connection=e:connect(e.runService.RenderStepped,function()
local g=e.playerService:getCharacter()
local h=e.playerService:getHumanoid()
local i=e.playerService:getRootPart()
if g and h and i and d(i,g)then
h.Jump=true
end
end)
end
},
{
action="unautojump|noautojump|noajump|unajump",
description="Disables autojump",
run=function(e)
c(e,"autojump")
end
},
{
action="edgejump|ejump",
description="Automatically jumps when you get to the edge of an object",
run=function(e)
c(e,"edgejump")

local f=e:createGarbage("edgejump")
f.connection=e:connect(e.runService.RenderStepped,function()
local g=e.playerService:getHumanoid()
local h=e.playerService:getRootPart()
if not(g and h)then return end

local i=f.state
local j=g:GetState()
f.state=j


if i~=j and j==Enum.HumanoidStateType.Freefall and i~=Enum.HumanoidStateType.Jumping and f.lastCFrame then
h.CFrame=f.lastCFrame
local k=h.AssemblyLinearVelocity
h.AssemblyLinearVelocity=Vector3.new(k.X,b.getProperty(g,"JumpPower"),k.Z)
end

f.lastCFrame=h.CFrame
end)
end
},
{
action="unedgejump|noedgejump|noejump|unejump",
description="Disables edgejump",
run=function(e)
c(e,"edgejump")
end
}
}end a.bf=function()local c=a.cache.bf if not c then c={c=b()}a.cache.bf=c end return c.c end end do local b=function()local b=function(




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
client=true,
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
client=true,
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
}end a.bg=function()local c=a.cache.bg if not c then c={c=b()}a.cache.bg=c end return c.c end end do local b=function()

local b=a.aw()
local c=a.ag()local d=function(


d)
if d==1 then
return Vector3.new(2,1,1)
end
return Vector3.one*d end


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
run=function(e,f)
local g=c(f:nextValue())
local h=f:nextValue()or 1

for i,j in g do
local k=j~=e.localPlayer and j.Character and j.Character:FindFirstChild("Head")
if k and k:IsA("BasePart")then
b.setProperty(k,"CanCollide",false)
b.setProperty(k,"Size",d(h))
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
run=function(e,f)
local g=c(f:nextValue())
local h=f:nextValue()or 1
local i=f:nextValue()or 0.4

for j,k in g do
local l=k~=e.localPlayer and k.Character and k.Character:FindFirstChild("HumanoidRootPart")
if l and l:IsA("BasePart")then
b.setProperty(l,"CanCollide",false)
b.setProperty(l,"Size",d(h))
b.setProperty(l,"Transparency",i)
end
end
end
}
}end a.bh=function()local c=a.cache.bh if not c then c={c=b()}a.cache.bh=c end return c.c end end do local b=function()

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
}end a.bi=function()local c=a.cache.bi if not c then c={c=b()}a.cache.bi=c end return c.c end end do local b=function()

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
}end a.bj=function()local c=a.cache.bj if not c then c={c=b()}a.cache.bj=c end return c.c end end do local b=function()

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
}end a.bk=function()local c=a.cache.bk if not c then c={c=b()}a.cache.bk=c end return c.c end end do local b=function()

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
}end a.bl=function()local c=a.cache.bl if not c then c={c=b()}a.cache.bl=c end return c.c end end do local b=function()

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
}end a.bm=function()local c=a.cache.bm if not c then c={c=b()}a.cache.bm=c end return c.c end end do local b=function()

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
}end a.bn=function()local c=a.cache.bn if not c then c={c=b()}a.cache.bn=c end return c.c end end do local b=function()

return{a.aQ()
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
,a.bj()
,a.bk()
,a.bl()
,a.bm()
,a.bn()

}end a.bo=function()local c=a.cache.bo if not c then c={c=b()}a.cache.bo=c end return c.c end end do local b=function()

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


return b end a.bp=function()local c=a.cache.bp if not c then c={c=b()}a.cache.bp=c end return c.c end end do local b=function()











local b=a.l()
local c=a.b()
local d=a.af()
local e=a.bp()

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


return h end a.bq=function()local c=a.cache.bq if not c then c={c=b()}a.cache.bq=c end return c.c end end do local b=function()




local b=a.bq()

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
}end a.br=function()local c=a.cache.br if not c then c={c=b()}a.cache.br=c end return c.c end end do local b=function()

return{
action="tweenspeed|tspeed",
description="Sets how fast the tween commands move you, in studs per second (default is 100)",
args={kind="number",name="tween speed",optional=true},
run=function(b,c)

b.privateEnv.tweenSpeed=c:nextValue()
end
}end a.bs=function()local c=a.cache.bs if not c then c={c=b()}a.cache.bs=c end return c.c end end do local b=function()

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
}end a.bt=function()local c=a.cache.bt if not c then c={c=b()}a.cache.bt=c end return c.c end end do local b=function()

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
}end a.bu=function()local c=a.cache.bu if not c then c={c=b()}a.cache.bu=c end return c.c end end do local b=function()

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
}end a.bv=function()local c=a.cache.bv if not c then c={c=b()}a.cache.bv=c end return c.c end end do local b=function()

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
client=true,
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
client=true,
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
client=true,
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
}end a.bw=function()local c=a.cache.bw if not c then c={c=b()}a.cache.bw=c end return c.c end end do local b=function()

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
}end a.bx=function()local c=a.cache.bx if not c then c={c=b()}a.cache.bx=c end return c.c end end do local b=function()local b=function(


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
}end a.by=function()local c=a.cache.by if not c then c={c=b()}a.cache.by=c end return c.c end end do local b=function()

local b=a.aw()local c=function(

c, d)
local e=c.playerService:getRootPart()
if e then
b.setProperty(e,"Anchored",d)
end end


return{
{
action="anchor",
description="Anchors your characters RootPart",
run=function(d)
c(d,true)
end
},
{
action="unanchor",
description="Unanchors your characters RootPart",
run=function(d)
c(d,false)
end
}
}end a.bz=function()local c=a.cache.bz if not c then c={c=b()}a.cache.bz=c end return c.c end end do local b=function()

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
}end a.bA=function()local c=a.cache.bA if not c then c={c=b()}a.cache.bA=c end return c.c end end do local b=function()

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
}end a.bB=function()local c=a.cache.bB if not c then c={c=b()}a.cache.bB=c end return c.c end end do local b=function()

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
}end a.bC=function()local c=a.cache.bC if not c then c={c=b()}a.cache.bC=c end return c.c end end do local b=function()local b=function(

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
}end a.bD=function()local c=a.cache.bD if not c then c={c=b()}a.cache.bD=c end return c.c end end do local b=function()

local b=a.aJ()
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
}end a.bE=function()local c=a.cache.bE if not c then c={c=b()}a.cache.bE=c end return c.c end end do local b=function()local b=function(

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
}end a.bF=function()local c=a.cache.bF if not c then c={c=b()}a.cache.bF=c end return c.c end end do local b=function()

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
}end a.bG=function()local c=a.cache.bG if not c then c={c=b()}a.cache.bG=c end return c.c end end do local b=function()local b=function(



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
}end a.bH=function()local c=a.cache.bH if not c then c={c=b()}a.cache.bH=c end return c.c end end do local b=function()

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
}end a.bI=function()local c=a.cache.bI if not c then c={c=b()}a.cache.bI=c end return c.c end end do local b=function()

local b=a.y()local c=function(

c)
local d=c:collectGarbage("tpwalk")
if d then
d.connection:Disconnect()
end end local d=function(




d)
local e=d.privateEnv.wallwalkSetEnabled
if e then
return e
end

local f,g=pcall(function()
return d.fetchService.load(b.path("wallwalker.luau"),"iy/wallwalker")()
end)

if not f then
d:notify("Wallwalk","failed to fetch script")
return
end

d.privateEnv.wallwalkSetEnabled=g
return g end


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
run=function(e,f)
c(e)

local g=f:nextValue()or 1
local h=f:nextValue()
if h then
e.privateEnv.tpwalkStack=(e.privateEnv.tpwalkStack or 0)+g
end

local i=e.playerService:getCharacter()
local j=e.playerService:getHumanoid()
if not(i and j)then return end

local k=e:createGarbage("tpwalk")
k.connection=e:connect(e.runService.Heartbeat,function(l)
if not(i.Parent and j.Parent)then
c(e)
return
end

local m=j.MoveDirection
if m.Magnitude>0 then
local n=g+(e.privateEnv.tpwalkStack or 0)
i:TranslateBy(m*n*l*10)
end
end)
end
},
{
action="untpwalk|unteleportwalk",
description="Undoes tpwalk / teleportwalk",
run=function(e)
e.privateEnv.tpwalkStack=0
c(e)
end
},
{
action="wallwalk|walkonwalls",
description="Walk on walls",
run=function(e)
local f=e:collectGarbage("wallwalk")
if f and f.active then
f.stop()
e:notify("Wallwalk","disabled")
return
end

local g=d(e)
if not g then return end

local h,i=pcall(g,true)
if not h then
e:notify("Wallwalk",`could not start: {tostring(i)}`)
return
end

local j=e:createGarbage("wallwalk")
j.active=true
j.stop=function()
j.active=false
pcall(g,false)
end

e:notify("Wallwalk","walk on any surface; run wallwalk again to turn it off")
end
},
{
action="unwallwalk|nowallwalk",
description="Turns off wallwalk",
run=function(e)
local f=e:collectGarbage("wallwalk")
local g=f~=nil and f.active==true

if f and f.stop then
f.stop()
end

e:notify("Wallwalk",if g then"disabled"else"it is not running")
end
}
}end a.bJ=function()local c=a.cache.bJ if not c then c={c=b()}a.cache.bJ=c end return c.c end end do local b=function()



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
}end a.bK=function()local c=a.cache.bK if not c then c={c=b()}a.cache.bK=c end return c.c end end do local b=function()

return{a.bs()
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
,a.bG()
,a.bH()
,a.bI()
,a.bJ()
,a.bK()

}end a.bL=function()local c=a.cache.bL if not c then c={c=b()}a.cache.bL=c end return c.c end end do local b=function()




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


return c end a.bM=function()local c=a.cache.bM if not c then c={c=b()}a.cache.bM=c end return c.c end end do local b=function()






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


return d end a.bN=function()local c=a.cache.bN if not c then c={c=b()}a.cache.bN=c end return c.c end end do local b=function()






local b=a.f()
local c=a.a()
local d=a.j()
local e=a.t()
local f=a.d()
local g=a.aJ()
local h=a.bM()
local i=a.bN()

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


return m end a.bO=function()local c=a.cache.bO if not c then c={c=b()}a.cache.bO=c end return c.c end end do local b=function()

local b=a.bO()

return{
{
client=true,
action="logs",
description="Opens the chat logs window with chat and join logs turned on",
run=function(c)
b.setChat(true)
b.setJoin(true)
c.infiniteYield:chatLogs("chat")
end
},
{
client=true,
action="chatlogs|clogs",
description="Turns on chat logs and opens the chat tab",
run=function(c)
b.setChat(true)
c.infiniteYield:chatLogs("chat")
end
},
{
client=true,
action="joinlogs|jlogs",
description="Turns on join logs and opens the joins tab",
run=function(c)
b.setJoin(true)
c.infiniteYield:chatLogs("join")
end
},
{
client=true,
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
}end a.bP=function()local c=a.cache.bP if not c then c={c=b()}a.cache.bP=c end return c.c end end do local b=function()

local b=a.bM()
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
}end a.bQ=function()local c=a.cache.bQ if not c then c={c=b()}a.cache.bQ=c end return c.c end end do local b=function()

local b=a.f()
local c=a.bM()local d=function(


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
}end a.bR=function()local c=a.cache.bR if not c then c={c=b()}a.cache.bR=c end return c.c end end do local b=function()

local b=a.f()
local c=a.bM()local d=function(

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
}end a.bS=function()local c=a.cache.bS if not c then c={c=b()}a.cache.bS=c end return c.c end end do local b=function()

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
client=true,
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
client=true,
action="unlistento",
description="Disables listento",
run=function(h)
f(h)
end
},
{
client=true,
action="muteallvoices|muteallvcs",
description="Mutes voice chat for all players",
run=function(h)
e(h,function(i)
i:SubscribePauseAll(true)
end)
end
},
{
client=true,
action="unmuteallvoices|unmuteallvcs",
description="Unmutes voice chat for all players",
run=function(h)
e(h,function(i)
i:SubscribePauseAll(false)
end)
end
},
{
client=true,
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
client=true,
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
client=true,
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
}end a.bT=function()local c=a.cache.bT if not c then c={c=b()}a.cache.bT=c end return c.c end end do local b=function()

return{
{
client=true,
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
client=true,
action="unloopoof",
description="Stops the oof loop",
run=function(b)
local c=b:collectGarbage("oof")
if c then
c.running=false
end
end
}
}end a.bU=function()local c=a.cache.bU if not c then c={c=b()}a.cache.bU=c end return c.c end end do local b=function()

local b=a.ag()

return{
{
client=true,
action="muteboombox",
description="Mutes someones boombox",
args={
kind="player"
},
run=function(c,d)
for e,f in b(d:nextValue())do
for g,h in{f.Character,f:FindFirstChildOfClass("Backpack")}do
for i,j in h:GetDescendants()do
if j:IsA("Sound")then
j.Playing=false
end
end
end
end
end
},
{
client=true,
action="unmuteboombox",
description="Unmutes someones boombox",
args={
kind="player"
},
run=function(c,d)
for e,f in b(d:nextValue())do
local g=f.Character
if not g then return end

for h,i in g:GetDescendants()do
if i:IsA("Sound")and not i.Playing then
i.Playing=true
end
end
end
end
}
}end a.bV=function()local c=a.cache.bV if not c then c={c=b()}a.cache.bV=c end return c.c end end do local b=function()

return{a.bP()
,a.bQ()
,a.bR()
,a.bS()
,a.bT()
,a.bU()
,a.bV()

}end a.bW=function()local c=a.cache.bW if not c then c={c=b()}a.cache.bW=c end return c.c end end do local b=function()









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


return m end a.bX=function()local c=a.cache.bX if not c then c={c=b()}a.cache.bX=c end return c.c end end do local b=function()






local b=a.bX()
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
client=true,
action="esp",
description="View all players and their status",
run=function(x)
t(x,m)
end
},
{
client=true,
action="espteam",
description="ESP but teammates are green and bad guys are red",
run=function(x)
t(x,n)
end
},
{
client=true,
action="noesp|unesp|unespteam",
description="Removes ESP",
run=function(x)
r(x,"esp")
end
},
{
client=true,
action="esptransparency",
description="Changes the transparency of ESP related commands",
args={kind="number"},
run=function(x,y)
local z=y:nextValue()
e.espTransparency=math.clamp(z or g,0,1)
end
},
{
client=true,
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
client=true,
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
client=true,
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
client=true,
action="nochams|unchams",
description="Removes chams",
run=function(x)
r(x,"chams")
end
},
{
client=true,
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
client=true,
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
}end a.bY=function()local c=a.cache.bY if not c then c={c=b()}a.cache.bY=c end return c.c end end do local b=function()local b=function(


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
client=true,
action="xray",
description="Makes all parts in workspace transparent",
run=function(d)
d.privateEnv.xrayEnabled=true
b(d)
end
},
{
client=true,
action="unxray|noxray",
description="Restores transparency to all parts in workspace",
run=function(d)
d.privateEnv.xrayEnabled=false
b(d)
end
},
{
client=true,
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
client=true,
action="unloopxray",
description="Unloops xray",
run=function(d)
c(d)
d.privateEnv.xrayEnabled=false
b(d)
end
},
{
client=true,
action="togglexray",
description="Toggles xray",
run=function(d)
d.privateEnv.xrayEnabled=not d.privateEnv.xrayEnabled
b(d)
end
}
}end a.bZ=function()local c=a.cache.bZ if not c then c={c=b()}a.cache.bZ=c end return c.c end end do local b=function()local b=function(



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
client=true,
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
client=true,
action="unhovername|nohovername",
description="Turns off hovername",
run=function(e)
c(e)
end
}
}end a.b_=function()local c=a.cache.b_ if not c then c={c=b()}a.cache.b_=c end return c.c end end do local b=function()local b=function(


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
}end a.b0=function()local c=a.cache.b0 if not c then c={c=b()}a.cache.b0=c end return c.c end end do local b=function()

return{a.bY()
,a.bZ()
,a.b_()
,a.b0()

}end a.b1=function()local c=a.cache.b1 if not c then c={c=b()}a.cache.b1=c end return c.c end end do local b=function()

return{}end a.b2=function()local c=a.cache.b2 if not c then c={c=b()}a.cache.b2=c end return c.c end end do local b=function()
local b=a.b2()
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


return d end a.b3=function()local c=a.cache.b3 if not c then c={c=b()}a.cache.b3=c end return c.c end end do local b=function()


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

return d end a.b4=function()local c=a.cache.b4 if not c then c={c=b()}a.cache.b4=c end return c.c end end do local b=function()
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


return d()end a.b5=function()local c=a.cache.b5 if not c then c={c=b()}a.cache.b5=c end return c.c end end do local b=function()
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
for g in f:gmatch("[^%.]+")do
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
for g in e:gmatch(".")do
f[g]=true
end
return f end


b.versionToNumber=function(e)
local f=e:gsub("^v","")

local g=0
local h=f:split(".")

for i,j in h do
local k=tonumber(j)or 0
g=g+k*math.pow(1000,3-i)
end

return g end


b.colorFromRGB=function(e, f)
return`<font color="#{f:ToHex()}">{e}</font>`end


b.richFontSize=function(e, f)
return`<font size="{f}">{e}</font>`end


return b end a.b6=function()local c=a.cache.b6 if not c then c={c=b()}a.cache.b6=c end return c.c end end do local aa=function()














local b=a.f()
local c=a.b3()
local d=a.aM()
local e=a.af()
local f=a.g()

local g=a.b4()
local h=a.b5()
local i=a.b6()
local j=a.aw()

local k=b.ContextActionService
local l=b.UserInputService

local m={}

m.DEFAULT_SPEED=1
m.DEFAULT_BOOST=2
m.MIN_BOOST=1
m.MAX_BOOST=50

local n="freecam.boost"

local o="freecam"
local p="freecamKeys"
local q="freecamMouse"
local r=Enum.ContextActionPriority.High.Value
local s=i.randomString(math.random(30,50))

local t={
Enum.KeyCode.W,
Enum.KeyCode.A,
Enum.KeyCode.S,
Enum.KeyCode.D,
Enum.KeyCode.E,
Enum.KeyCode.Q,
Enum.KeyCode.Up,
Enum.KeyCode.Down,
}

local u=70
local v=64
local w=5
local x=math.pi/64


local y=math.rad(89)
local z=0.75
local A=0.01
local B=4
local C=0.25
local D=0.1
local E=512

local F=1
local G=64
local H=24
local I=40 local J=function()


return Enum.ContextActionResult.Sink end local K=function(



K)
return{
position=K,
velocity=K*0,
}end local L=function(


L, M, N)
local O=w*2*math.pi
local P=N-L.position
local Q=math.exp(-O*M)

local R=N+(L.velocity*M-P*(O*M+1))*Q
local S=(O*M*(P*O-L.velocity)+L.velocity)*Q

L.position=R
L.velocity=S

return R end local M=function(



M, N)
local O=l:IsKeyDown(M)and 1 or 0
local P=l:IsKeyDown(N)and 1 or 0
return O-P end local aa=function(



N, O, P)
local Q=N.ViewportSize
local R=2*math.tan(math.rad(P)/2)
local S=Q.X/Q.Y*R

local T=E
local U=O.LookVector

for V=0,1,0.5 do
for W=0,1,0.5 do
local X=O.RightVector*((V-0.5)*S)
-O.UpVector*((W-0.5)*R)
+O.LookVector

local Y=X.Unit
local Z=O.Position+X*D
local _=workspace:Raycast(Z,Y*E)
local aa=_ and(_.Position-Z).Magnitude or E

if aa<T then
T=aa
U=Y
end
end
end

return O.LookVector:Dot(U)*T end local N=function(






N, O)
if not N then return Vector3.zero end

local P=Vector3.new(-math.sin(O),0,-math.cos(O))
local Q=Vector3.new(math.cos(O),0,-math.sin(O))
local R=N.MoveDirection
return Vector3.new(R:Dot(Q),0,-R:Dot(P))end local O=function(


O)
return O.UserInputType==Enum.UserInputType.Touch end local P=function(



P, Q)
for R,S in P.controls do
local T=S.AbsolutePosition
local U=S.AbsoluteSize
if Q.X>=T.X and Q.X<=T.X+U.X
and Q.Y>=T.Y and Q.Y<=T.Y+U.Y then
return true
end
end
return false end local Q=function(



Q, R)
local S=c.new("ScreenGui",h,{
Name=s,
ResetOnSpawn=false,
DisplayOrder=50,
})
R.gui=S local T=function(


T, U, V)
local W=c.new("TextButton",S,{
Name=T,
AnchorPoint=Vector2.new(1,1),
Position=V,
Size=UDim2.fromOffset(G,G),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text=U,
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(R.controls,W)
table.insert(R.connections,Q:connect(W.InputBegan,function(X)
if O(X)then
R.holds[T]=X
end
end))end


T("rise","UP",UDim2.new(1,-H,1,-I-G-12))
T("fall","DOWN",UDim2.new(1,-H,1,-I))
T("boost","BOOST",UDim2.new(1,-H-G-12,1,-I))

local U=c.new("TextButton",S,{
Name="Close",
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-H,0,H),
Size=UDim2.fromOffset(G,G),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text="X",
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(R.controls,U)
table.insert(R.connections,Q:connect(U.Activated,function()
m.stop(Q)
end))


local V=c.new("TextButton",S,{
Name="Teleport",
AnchorPoint=Vector2.new(1,0),
Position=UDim2.new(1,-H-G-12,0,H),
Size=UDim2.fromOffset(G,G),
BackgroundColor3=Color3.new(0,0,0),
BackgroundTransparency=0.5,
AutoButtonColor=false,
Text="TP",
TextColor3=Color3.new(1,1,1),
TextScaled=true,
Active=true,
})

table.insert(R.controls,V)
table.insert(R.connections,Q:connect(V.Activated,function()
m.teleport(Q)
end))


table.insert(R.connections,Q:connect(l.InputEnded,function(W)
for X,Y in R.holds do
if W==Y then
R.holds[X]=nil
end
end
end))end local R=function(




R, S)
local T=b.Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
local U=T and T:FindFirstChild("TouchGui")
local V=U and U:FindFirstChild("JumpButton",true)
if not V then return end

S.jumpButton=V
S.jumpVisible=V.Visible
V.Visible=false

table.insert(S.connections,R:connect(V:GetPropertyChangedSignal("Visible"),function()
if V.Visible then
V.Visible=false
end
end))end local S=function(



S, T)
local U=S.playerService:getRootPart()
if not U then return end

T.root=U
T.rootAnchored=U.Anchored
j.setProperty(U,"Anchored",true)end local T=function(


T)
local U=T.root
if U and U.Parent~=nil then
j.setProperty(U,"Anchored",T.rootAnchored)
end end local ab=function(


U, V, W)
local X=workspace.CurrentCamera


V.navMultiplier=math.clamp(
V.navMultiplier+W*M(Enum.KeyCode.Up,Enum.KeyCode.Down)*z,
A,
B
)


local Y=U.playerService:getHumanoid()
local Z=if g then N(Y,V.rotation.Y)else Vector3.zero
if g and Y then
Y.Jump=false
end

local _=V.holds.rise and 1 or 0
local ab=V.holds.fall and 1 or 0
local ac=Vector3.new(
M(Enum.KeyCode.D,Enum.KeyCode.A)+Z.X,
M(Enum.KeyCode.E,Enum.KeyCode.Q)+_-ab,
M(Enum.KeyCode.S,Enum.KeyCode.W)+Z.Z
)

local ad=l:IsKeyDown(Enum.KeyCode.LeftShift)and C or 1

local ae=V.holds.boost or l:IsKeyDown(d:getBinding("freecamBoost"))
local af=if ae then m.getBoost(U)else 1
local ag=(U.privateEnv.freecamSpeed or m.DEFAULT_SPEED)*V.navMultiplier*ad*af
local ah=L(V.velocitySpring,W,ac*ag)

local ai=L(V.panSpring,W,V.mouseDelta*x)
V.mouseDelta=Vector2.zero


local aj=math.sqrt(math.tan(math.rad(u/2))/math.tan(math.rad(V.fieldOfView/2)))
local ak=V.rotation+ai*Vector2.new(0.75,1)*8*(W/aj)
V.rotation=Vector2.new(
math.clamp(ak.X,-y,y),
ak.Y%(2*math.pi)
)

local al=CFrame.fromOrientation(V.rotation.X,V.rotation.Y,0)
local am=CFrame.new(V.position)*al*CFrame.new(ah*v*W)
V.position=am.Position

X.CFrame=am
if V.anchor then
V.anchor.CFrame=am
end
X.Focus=am*CFrame.new(0,0,-aa(X,am,V.fieldOfView))
X.FieldOfView=V.fieldOfView end local ac=function(


ac)
return c.new("Part",workspace,{
Name="freecamAnchor",
Anchored=true,
CanCollide=false,
CanQuery=false,
CanTouch=false,
CastShadow=false,
Transparency=1,
Size=Vector3.one*0.2,
CFrame=CFrame.new(ac.position),
})end local ad=function(


ad)
local ae=f.Character or f.CharacterAdded:Wait()
local af=ae:WaitForChild("Humanoid",100)

if ad and(
ad.CameraSubject==nil
or not ad.CameraSubject:IsDescendantOf(workspace)
)and e:isAlive(ae)then
ad.CameraSubject=af
end end


m.stop=function(ae)
local af=ae:collectGarbage(o)
if not af then return false end

for ag,ah in af.connections do
ah:Disconnect()
end

k:UnbindAction(p)
k:UnbindAction(q)

if af.gui then
af.gui:Destroy()
end
if af.jumpButton then
af.jumpButton.Visible=af.jumpVisible
end
T(af)

local ag=af.cameraSubject
local ah=workspace.CurrentCamera

ah.CameraSubject=ag

if af.isLPHumanoid or(ag and not ag:IsDescendantOf(workspace))then
task.spawn(ad,ah)
end

ah.CameraType=af.cameraType

if af.anchor then
af.anchor:Destroy()
end

ah.Focus=af.focus
ah.FieldOfView=af.fieldOfView

l.MouseBehavior=af.mouseBehavior
l.MouseIconEnabled=af.mouseIconEnabled

return true end


m.teleport=function(ae)
local af=ae:getGarbage(o)
if not af then return false end

local ag=CFrame.new(af.position)*CFrame.Angles(0,af.rotation.Y,0)
m.stop(ae)

if not ae.playerService:teleportTo(ag)then
ae:notify("Freecam","your character was not found")
end

return true end local ae=function(


ae, af, ag, ...)
local ah,ai=pcall(ag,...)
if not ah then
ae:notify("Freecam",`{af} failed: {ai}`)
end end local af=function(


af, ag)
m.stop(af)

local ah=workspace.CurrentCamera
local ai=ah.CFrame
local aj,ak=ai:ToOrientation()

local al=af:createGarbage(o)
al.connections={}
al.controls={}
al.holds={}
al.cameraType=ah.CameraType
al.cameraSubject=ah.CameraSubject

local am=f.Character and f.Character:FindFirstChildOfClass("Humanoid")
al.isLPHumanoid=
(al.cameraSubject~=nil and am==al.cameraSubject)or
al.cameraSubject==nil

al.focus=ah.Focus
al.fieldOfView=ah.FieldOfView
al.mouseBehavior=l.MouseBehavior
al.mouseIconEnabled=l.MouseIconEnabled

al.position=ag or ai.Position
al.rotation=Vector2.new(aj,ak)
al.mouseDelta=Vector2.zero
al.navMultiplier=1
al.velocitySpring=K(Vector3.zero)
al.panSpring=K(Vector2.zero)

al.anchor=ac(al)

ah.CameraType=Enum.CameraType.Custom
ah.CameraSubject=al.anchor
l.MouseBehavior=Enum.MouseBehavior.Default
l.MouseIconEnabled=true

k:BindActionAtPriority(p,J,false,r,table.unpack(t))
k:BindActionAtPriority(q,function(U,V,W)
local X=W.Delta
al.mouseDelta=al.mouseDelta+Vector2.new(-X.Y,-X.X)
return Enum.ContextActionResult.Sink
end,false,r,Enum.UserInputType.MouseMovement)

if g then
S(af,al)
ae(af,"buttons",Q,af,al)
ae(af,"jump button",R,af,al)

table.insert(al.connections,af:connect(l.InputBegan,function(V,W)
if W or not O(V)then return end
if al.lookTouch~=nil or P(al,V.Position)then return end

if V.Position.X<workspace.CurrentCamera.ViewportSize.X/2 then return end
al.lookTouch=V
end))
table.insert(al.connections,af:connect(l.InputChanged,function(V)
if V==al.lookTouch then
al.mouseDelta=al.mouseDelta+Vector2.new(-V.Delta.Y,-V.Delta.X)*F
end
end))
table.insert(al.connections,af:connect(l.InputEnded,function(V)
if V==al.lookTouch then
al.lookTouch=nil
end
end))
end

table.insert(al.connections,af:connect(af.runService.RenderStepped,function(V)
local W,X=pcall(ab,af,al,V)
if not W then
m.stop(af)
af:notify("Freecam",`stopped, the camera was given back: {X}`)
end
end))end


m.start=function(ag, ah)
local ai,aj=pcall(af,ag,ah)
if not ai then
m.stop(ag)
ag:notify("Freecam",`could not start: {aj}`)
end end


m.getBoost=function(ag)
local ah=ag.storage.settings:getValue(n)
if type(ah)~="number"then
return m.DEFAULT_BOOST
end

return math.clamp(ah,m.MIN_BOOST,m.MAX_BOOST)end


m.addBoost=function(ag, ah)
local ai=math.clamp(m.getBoost(ag)+ah,m.MIN_BOOST,m.MAX_BOOST)

ag.storage.settings:setValue(n,ai)
ag.storage.settings:save()

return ai end


m.getPosition=function(ag)
local ah=ag:getGarbage(o)
return ah and ah.position end


return m end a.b7=function()local ab=a.cache.b7 if not ab then ab={c=aa()}a.cache.b7=ab end return ab.c end end do local aa=function()

local aa=a.ag()
local ab=a.b7()local ac=function(


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
client=true,
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

local ak=ag.playerService:getCamera()local al=function()



local al=ac(ai.Character)
if al then
ad(ag,al)
end end


table.insert(aj.connections,ag:connect(ak:GetPropertyChangedSignal("CameraSubject"),al))

table.insert(aj.connections,ag:connect(ai.CharacterAdded,function(am)
am:WaitForChild("Humanoid",10)
al()
end))


table.insert(aj.connections,ag:connect(ag.players.PlayerRemoving,function(am)
if am==ai then
af(ag)
ae(ag)
end
end))

al()
ag:notify("Spectate","Viewing "..ai.Name)
end
},
{
client=true,
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
for ak,al in workspace:GetDescendants()do
if al:IsA("BasePart")and string.lower(al.Name)==aj then
ad(ag,al)
return
end
end

ag:notify("Spectate","no part named "..ai)
end
},
{
client=true,
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
}end a.b8=function()local ab=a.cache.b8 if not ab then ab={c=aa()}a.cache.b8=ab end return ab.c end end do local aa=function()



local aa=a.ag()
local ab=a.b7()

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
client=true,
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
client=true,
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
client=true,
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
client=true,
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
client=true,
action="unfreecam|unfc|nofreecam|nofc",
description="Disables freecam",
run=function(af)
ab.stop(af)
end
},
{
client=true,
action="freecamspeed|fcspeed",
description="Adjusts freecam speed (default is 1)",
args={kind="number"},
run=function(af,ag)
af.privateEnv.freecamSpeed=ag:nextValue()or ab.DEFAULT_SPEED
end
},
{
client=true,
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
client=true,
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
client=true,
action="freecamboost|fcboost",
description="Increases the freecam boost (the BOOST button) by an amount, and saves it",
args={kind="number",name="amount",optional=true},
run=function(af,ag)
local ah=ag:nextValue()or 1
local ai=ab.addBoost(af,ah)
af:notify(ac,`freecam boost is now {ai}x`)
end
},
}end a.b9=function()local ab=a.cache.b9 if not ab then ab={c=aa()}a.cache.b9=ab end return ab.c end end do local aa=function()

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
}end a.ca=function()local ab=a.cache.ca if not ab then ab={c=aa()}a.cache.ca=ab end return ab.c end end do local aa=function()

return{
{
client=true,
action="firstp",
description="Forces camera to go into first person",
run=function(aa)
aa.localPlayer.CameraMode=Enum.CameraMode.LockFirstPerson
end
},
{
client=true,
action="thirdp",
description="Allows camera to go into third person",
run=function(aa)
aa.localPlayer.CameraMode=Enum.CameraMode.Classic
end
}
}end a.cb=function()local ab=a.cache.cb if not ab then ab={c=aa()}a.cache.cb=ab end return ab.c end end do local aa=function()local aa=function(


aa)
local ab=aa:FindFirstChild("PlayerScripts")
local ac=ab and ab:FindFirstChild("PlayerModule")
local ad=ac and ac:FindFirstChild("CameraModule")
local ae=ad and ad:FindFirstChild("ZoomController")
return ae and ae:FindFirstChild("Popper")end


return{
client=true,
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
}end a.cc=function()local ab=a.cache.cc if not ab then ab={c=aa()}a.cache.cc=ab end return ab.c end end do local aa=function()

return{
{
client=true,
action="maxzoom",
description="Maximum camera zoom",
args={kind="number"},
run=function(aa,ab)
aa.localPlayer.CameraMaxZoomDistance=ab:nextValue()
end
},
{
client=true,
action="minzoom",
description="Minimum camera zoom",
args={kind="number"},
run=function(aa,ab)
aa.localPlayer.CameraMinZoomDistance=ab:nextValue()
end
},
{
client=true,
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
}end a.cd=function()local ab=a.cache.cd if not ab then ab={c=aa()}a.cache.cd=ab end return ab.c end end do local aa=function()

return{
client=true,
action="fov",
description="Adjusts field of view (default is 70)",
args={kind="number",default=70},
run=function(aa,ab)
local ac=math.clamp(math.abs(ab:nextValue()or 70),1,120)
workspace.CurrentCamera.FieldOfView=ac
end
}end a.ce=function()local ab=a.cache.ce if not ab then ab={c=aa()}a.cache.ce=ab end return ab.c end end do local aa=function()

local aa=a.b7()

return{
client=true,
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
}end a.cf=function()local ab=a.cache.cf if not ab then ab={c=aa()}a.cache.cf=ab end return ab.c end end do local aa=function()

return{
client=true,
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
}end a.cg=function()local ab=a.cache.cg if not ab then ab={c=aa()}a.cache.cg=ab end return ab.c end end do local aa=function()

local aa=a.ag()


local ab={max=400,min=0.5}

return{
client=true,
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
}end a.ch=function()local ab=a.cache.ch if not ab then ab={c=aa()}a.cache.ch=ab end return ab.c end end do local aa=function()

local aa=a.ag()local ab=function(

ab)
local ac=ab:collectGarbage("stareat")
if ac then
ac.connection:Disconnect()
end end


return{
{
client=true,
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
client=true,
action="unstareat|unstare",
description="Disables stareat",
run=function(ac)
ab(ac)
end
}
}end a.ci=function()local ab=a.cache.ci if not ab then ab={c=aa()}a.cache.ci=ab end return ab.c end end do local aa=function()

return{a.b8()
,a.b9()
,a.ca()
,a.cb()
,a.cc()
,a.cd()
,a.ce()
,a.cf()
,a.cg()
,a.ch()
,a.ci()

}end a.cj=function()local ab=a.cache.cj if not ab then ab={c=aa()}a.cache.cj=ab end return ab.c end end do local aa=function()

local aa=a.y()local ab=function(


ab)
local ac=aa.fetch(ab,"F3X","f3x.luau","iy/f3x")
if not ac then return end

local ad,ae=pcall(ac)
if not ad then
ab:notify("F3X",`failed to run: {tostring(ae)}`)
end end


return{
{
client=true,
action="btools",
description="Gives you building tools (DOES NOT REPLICATE)",
run=function(ac)
local ad=ac.localPlayer:FindFirstChildWhichIsA("Backpack")
if not ad then
ac:notify("Btools","your backpack is not loaded")
return
end


for ae,af in Enum.BinType:GetEnumItems()do
local ag=Instance.new("HopperBin")
ag.BinType=af
ag.Name="Building Tool"
ag.Parent=ad
end
end
},
{
client=true,
action="f3x",
description="Gives you F3X building tools (DOES NOT REPLICATE)",
run=function(ac)task.spawn(ab,ac)end
}
}end a.ck=function()local ab=a.cache.ck if not ab then ab={c=aa()}a.cache.ck=ab end return ab.c end end do local aa=function()local aa=function(






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
client=true,
action="partname|partpath",
description="Opens a window: click a part to see its path & name, then Select Part saves it as a waypoint",
run=function(ac)
ac.infiniteYield:openPartPath(function(ad)
local ae=ab(ac,ad)
ac:notify("Modified Waypoints","Created waypoint: "..ae)
end)
end
}
}end a.cl=function()local ab=a.cache.cl if not ab then ab={c=aa()}a.cache.cl=ab end return ab.c end end do local aa=function()local aa=function(


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
}end a.cm=function()local ab=a.cache.cm if not ab then ab={c=aa()}a.cache.cm=ab end return ab.c end end do local aa=function()




return{
{
client=true,
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
client=true,
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
}end a.cn=function()local ab=a.cache.cn if not ab then ab={c=aa()}a.cache.cn=ab end return ab.c end end do local aa=function()

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
}end a.co=function()local ab=a.cache.co if not ab then ab={c=aa()}a.cache.co=ab end return ab.c end end do local aa=function()local aa=function(

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
}end a.cp=function()local ab=a.cache.cp if not ab then ab={c=aa()}a.cache.cp=ab end return ab.c end end do local aa=function()

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
}end a.cq=function()local ab=a.cache.cq if not ab then ab={c=aa()}a.cache.cq=ab end return ab.c end end do local aa=function()

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
}end a.cr=function()local ab=a.cache.cr if not ab then ab={c=aa()}a.cache.cr=ab end return ab.c end end do local aa=function()local aa=function(

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
}end a.cs=function()local ab=a.cache.cs if not ab then ab={c=aa()}a.cache.cs=ab end return ab.c end end do local aa=function()
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
}end a.ct=function()local ab=a.cache.ct if not ab then ab={c=aa()}a.cache.ct=ab end return ab.c end end do local aa=function()

return{a.ck()
,a.cl()
,a.cm()
,a.cn()
,a.co()
,a.cp()
,a.cq()
,a.cr()
,a.cs()
,a.ct()

}end a.cu=function()local ab=a.cache.cu if not ab then ab={c=aa()}a.cache.cu=ab end return ab.c end end do local aa=function()local aa=function(

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
client=true,
action="fullbright|fb",
description="Makes the map brighter / more visible (CLIENT)",
run=function(ac)
aa(ac)
end
},
{
client=true,
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
client=true,
action="unloopfullbright|unloopfb",
description="Unloops fullbright",
run=function(ac)
ab(ac)
end
}
}end a.cv=function()local ab=a.cache.cv if not ab then ab={c=aa()}a.cache.cv=ab end return ab.c end end do local aa=function()

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
}end a.cw=function()local ab=a.cache.cw if not ab then ab={c=aa()}a.cache.cw=ab end return ab.c end end do local aa=function()

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
}end a.cx=function()local ab=a.cache.cx if not ab then ab={c=aa()}a.cache.cx=ab end return ab.c end end do local aa=function()

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
}end a.cy=function()local ab=a.cache.cy if not ab then ab={c=aa()}a.cache.cy=ab end return ab.c end end do local aa=function()

return{
client=true,
action="brightness",
description="Changes the brightness lighting property",
args={kind="number"},
run=function(aa,ab)
aa.robloxServices.Lighting.Brightness=ab:nextValue()
end
}end a.cz=function()local ab=a.cache.cz if not ab then ab={c=aa()}a.cache.cz=ab end return ab.c end end do local aa=function()

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
}end a.cA=function()local ab=a.cache.cA if not ab then ab={c=aa()}a.cache.cA=ab end return ab.c end end do local aa=function()

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
client=true,
action="restorelighting|rlighting",
description="Restores Lighting properties",
run=af
},
{
client=true,
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

for al,am in aj do
local b=am.Character and am.Character:FindFirstChild("HumanoidRootPart")
if not b then return end

local c=Instance.new("PointLight")
c.Range=ak
c.Brightness=5
c.Parent=b

table.insert(ah:registerGarbage("dynamicLights"),c)
end
end
},
{
client=true,
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
}end a.cB=function()local ab=a.cache.cB if not ab then ab={c=aa()}a.cache.cB=ab end return ab.c end end do local aa=function()

return{a.cv()
,a.cw()
,a.cx()
,a.cy()
,a.cz()
,a.cA()
,a.cB()

}end a.cC=function()local ab=a.cache.cC if not ab then ab={c=aa()}a.cache.cC=ab end return ab.c end end do local aa=function()





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


return ab end a.cD=function()local ab=a.cache.cD if not ab then ab={c=aa()}a.cache.cD=ab end return ab.c end end do local aa=function()

local aa=a.cD()

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
}end a.cE=function()local ab=a.cache.cE if not ab then ab={c=aa()}a.cache.cE=ab end return ab.c end end do local aa=function()

return{

extensions={".luau",".lua",".txt",".iy"},

translateClassic=true,

sectionName="plugin commands",
}end a.cF=function()local ab=a.cache.cF if not ab then ab={c=aa()}a.cache.cF=ab end return ab.c end end do local aa=function()



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

local al={aj}
local am={[aj:lower()]=true}
for b,c in ak.Aliases or{}do
if type(c)~="string"or c==""or c:find("[|%s]")then
return nil,`invalid alias of '{aj}'`
end
if not am[c:lower()]then
am[c:lower()]=true
table.insert(al,c)
end
end

local b=ak.Function
table.insert(ai,{
action=table.concat(al,"|"),
description=ak.Description or ag.PluginDescription or"",
classicListName=ak.ListName,
args={kind="string",name="args",optional=true,variadic=true},
run=function(c,d)
local e={}
while true do
local f=d:nextValue()
if f==nil then break end
table.insert(e,f)
end
if ah then rawset(ah,"cargs",e)end
local f=b(e,c.localPlayer)
if type(f)=="string"and not table.find(e,"nonotify")then
c:notify(`Command: {aj}`,f)
end
return f
end,
})
end
if#ai==0 then return nil,"the classic plugin has no commands"end
table.sort(ai,function(aj,ak)return aj.action:lower()<ak.action:lower()end)
af(ah)
return ai end


return ac end a.cG=function()local ab=a.cache.cG if not ab then ab={c=aa()}a.cache.cG=ab end return ab.c end end do local aa=function()

























local aa=a.a()
local ab=a.j()
local ac=a.m()
local ad=a.cF()
local ae=a.cG()

local af={}





local ag=`{ab.privateFolder}/plugins`

af.FOLDER=ag



local ah={}


local ai={}



local aj={isSection=true,isPluginSection=true}local ak=function(







ak)
if type(ak)~="string"then return nil end

local al=ak
local am

for b,c in ad.extensions do
if ak:sub(-#c):lower()==c then
al=ak:sub(1,-#c-1)
am=ak
break
end
end

if al:match("^[%w_%-]+$")then return al,am end
return nil end


af.normalizeName=ak local al=function()







if aa.listfiles==nil then return nil,"your exploit does not support listfiles"end

local al,am=pcall(aa.listfiles,ag)
if not(al and type(am)=="table")then
return nil,`could not read the folder {ag}`
end

local b={}

for c,d in am do
local e=type(d)=="string"and d:match("([^/\\]+)$")
if e then
local f,g=ak(e)
if f and g then
table.insert(b,{name=f,filename=e})
end
end
end

table.sort(b,function(c,d)return c.filename<d.filename end)
return b end local am=function(



am)
local b,c=pcall(aa.isfile,`{ag}/{am}`)
return b and c and true or false end local b=function(






b, c)
local d={}
local e={}local f=function(

f)
if not e[f]then
e[f]=true
table.insert(d,f)
end end


if c then
local g,h=ak(c)
if g==b and h then f(h)end
end

for g,h in ad.extensions do
f(b..h)
end

for g,h in d do
if am(h)then return h,d end
end


local g=#d+1
local h=al()or{}

for i,j in ad.extensions do
for k,l in h do
if l.name==b and l.filename:sub(-#j):lower()==j then
f(l.filename)
end
end
end

for i=g,#d do
if am(d[i])then return d[i],d end
end

return nil,d end local c=function(




c, d)
if aa.readfile==nil or aa.isfile==nil then
return nil,"your exploit does not support readfile"
end

local e,f=b(c,d)
if e==nil then
return nil,`file not found in {ag}; tried: {table.concat(f,", ")}`
end

local g=`{ag}/{e}`
local h,i=pcall(aa.readfile,g)

if not(h and type(i)=="string")then
return nil,`could not read {g}`
end

return i,nil,e end local d=function(







d)
if aa.loadstring==nil then return nil,"your exploit does not support loadstring"end

local e,f,g=pcall(aa.loadstring,d)
if not e then return nil,tostring(f)end
if not f then return nil,tostring(g)end

local h
if ad.translateClassic then
local i,j=pcall(ae.environment,f)
if i then h=j end
end

local i,j=pcall(f)
if not i then return nil,`error while loading the plugin: {j}`end
if type(j)~="table"then return nil,"the plugin must return a table of commands"end

if ad.translateClassic and ae.detect(j)then
local k,l,m=pcall(ae.translate,j,h)
if not k then return nil,`could not translate the classic plugin: {l}`end
return l,m
end

return j end local e=function(




e)
local f=e
if type(e.action)=="string"then
f={e}
end

local g={}

for h,i in f do
if type(i)~="table"or type(i.action)~="string"then
return nil,"every command needs an action string"
end

if i.run~=nil and type(i.run)~="function"then
return nil,`run of '{i.action}' must be a function`
end

local j={}

for k,l in i.action:split("|")do
local m=l:lower()
if m==""then
return nil,`empty name in '{i.action}'`
end
table.insert(j,m)
end

local k={}
for l,m in i do
k[l]=m
end

local l=k.args or{}
if#l==0 and next(l)then
l={l}
end
k.args=l

local m=table.clone(j)
table.sort(m,function(n,o)
return#n<#o
end)

k.name=j[1]
k.aliases=m
k.action=nil

table.insert(g,{entry=k,names=j})
end

if#g==0 then
return nil,"the plugin has no commands"
end

return g end local f=function(






f, g)
local h=table.find(f,g)
if h then
table.remove(f,h)
end end local g=function(




g)
local h=g.original

if h then
for i=#h,1,-1 do
local j=h[i]
if j.isPluginCommand or j.isPluginSection then
table.remove(h,i)
end
end

local i={}
for j in ah do
table.insert(i,j)
end
table.sort(i)

if#i>0 then
aj.sectionName=ad.sectionName or"plugin commands"
table.insert(h,aj)

for j,k in i do
for l,m in ah[k].entries do
table.insert(h,m)
end
end
end
end

g.revision=(g.revision or 0)+1
if g.changed then g.changed:Fire()end end local h=function(



h, i)
local j={}
local k={}

for l,m in i do
for n,o in m.names do
if h.lookup[o]~=nil or k[o]then
return nil,`'{o}' is already a command or an alias`
end

k[o]=true
table.insert(j,o)
end
end

return j end local i=function(



i, j, k, l, m)
local n={}

for o,p in l do
p.entry.isPluginCommand=true
p.entry.pluginName=j
table.insert(n,p.entry)

for q,r in p.names do
i.lookup[r]=p.entry
table.insert(i.array,r)
end
end

ah[j]={keys=m,commands=#l,filename=k,entries=n}
ac.object[j]=k

g(i)end local j=function(



j, k)
local l=ah[k]
if not l then return end

for m,n in l.keys do
j.lookup[n]=nil
f(j.array,n)
end

ah[k]=nil
g(j)end local k=function(








k, l, m)
local n,o,p=c(l,m)
if not n then return false,o end

local q,r=d(n)
if not q then return false,r end

local s,t=e(q)
if not s then return false,t end

local u,v=h(k,s)
if not u then return false,v end

i(k,l,p,s,u)
return true,#s end local l=function(



l, m, n)
local o,p=k(l,m,n)

ai[m]=if o then nil else tostring(p)
return o,p end







af.add=function(m, n)
local o,p=ak(n)
if not o then
return false,"plugin names can only use letters, numbers, '_' and '-'"
end

if ah[o]then
return false,`'{o}' is already loaded`
end

local q,r=l(m,o,p)
if not q then
return false,r
end

ac:save()

return true,r end



af.remove=function(m, n)
local o=ak(n)
if not o then return false end

if ac.object[o]==nil and ah[o]==nil then
return false
end

j(m,o)
ai[o]=nil

ac.object[o]=nil
ac:save()

return true end



af.reload=function(m, n)
local o,p=ak(n)
if not o then return false,"invalid plugin name"end

if ac.object[o]==nil then
return false,`'{o}' is not installed`
end

local q=p or ac.object[o]

j(m,o)

local r,s=l(m,o,q)
if r then ac:save()end

return r,s end




local m=10






af.restore=function(n, o, p)
local q={}

local r={}
for s in ac.object do
table.insert(r,s)
end

for s,t in r do
local u=ac.object[t]
local v=false

task.spawn(function()
local w

if ak(t)~=t then
w="invalid installed plugin name"
ai[t]=w
elseif not ah[t]then
local x=if type(u)=="string"then u else nil
local y,z=l(n,t,x)

if y then
if ac.object[t]~=u then ac:save()end
else
w=tostring(z)
end
end

v=true

if w then
q[t]=w
if o then o(t,w)end
end
end)

task.delay(m,function()
if not v and p then p(t)end
end)
end

return q end





af.addAll=function(n)
local o,p=al()
if not o then return nil,p end

local q={added={},failed={}}
local r={}

for s,t in o do
local u=t.name
if ah[u]or r[u]then continue end
r[u]=true

local v,w=af.add(n,u)
if v then
table.insert(q.added,u)
else
table.insert(q.failed,`{u}: {w}`)
end
end

return q end




af.getInstalled=function()
local n={}

for o in ac.object do
local p=ah[o]

table.insert(n,{
name=o,
loaded=p~=nil,
commands=if p then p.commands else 0,
error=if p then nil else ai[o],
})
end

table.sort(n,function(o,p)
return o.name:lower()<p.name:lower()
end)

return n end



af.getAvailable=function()
local n,o=al()
if not n then return nil,o end

local p={}
local q={}

for r,s in n do
local t=s.name
if not q[t]and ac.object[t]==nil then
q[t]=true
table.insert(p,t)
end
end

table.sort(p,function(r,s)
return r:lower()<s:lower()
end)

return p end


return af end a.cH=function()local ab=a.cache.cH if not ab then ab={c=aa()}a.cache.cH=ab end return ab.c end end do local aa=function()

local aa=a.cH()

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
}end a.cI=function()local ab=a.cache.cI if not ab then ab={c=aa()}a.cache.cI=ab end return ab.c end end do local aa=function()

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

for al=1,#ak do
ag(ak[al])
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
name="bypass",
commands=a.aA()
},
{
name="interface",
commands=a.aO()
},
{
name="character",
commands=a.bo()
},
{
name="waypoints",
commands=a.br()
},
{
name="teleport",
commands=a.bL()
},
{
name="communication",
commands=a.bW()
},
{
name="visual",
commands=a.b1()
},
{
name="camera",
commands=a.cj()
},
{
name="workspace",
commands=a.cu()
},
{
name="lighting",
commands=a.cC()
},
{
name="aliases",
commands=a.cE()
},
{
name="plugins",
commands=a.cI()
}
})end a.cJ=function()local ab=a.cache.cJ if not ab then ab={c=aa()}a.cache.cJ=ab end return ab.c end end do local aa=function()


































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































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

local al=ak:find(af,1,true)

if al==1 then
table.insert(ag,aj)
elseif al and not ae then
table.insert(ah,aj)
end
end

for ai,aj in ah do
table.insert(ag,aj)
end

return ag end


return aa end a.cK=function()local ab=a.cache.cK if not ab then ab={c=aa()}a.cache.cK=ab end return ab.c end end do local aa=function()








local aa=a.k()
local ab=a.j()
local ac=a.aB()

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


return ad end a.cL=function()local ab=a.cache.cL if not ab then ab={c=aa()}a.cache.cL=ab end return ab.c end end do local aa=function()

local aa=a.aC()
local ab=a.cL()
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


ak, al)
local am=ak..aj(al)
local b,c=pcall(ai,am)

if not b then
ac:warn(`failed to fetch http url '{am}':\n\t{c}`)
return nil
end

if type(c)~="string"or#c==0 then
ac:warn(`empty response from '{am}'`)
return nil
end

return c end


ah.download=function(al)
return ak(ag,al)end



ah.downloadUrl=function(al)
return ag..aj(al)end



ah.fetchUrl=function(al)
return ak("",al)end


ah.fetch=function(al)
return ak(af,al)end




ah.fetchReference=function(al)
local am=aj(al)

local b=ab.read("reference",am)
if b~=nil then
return b
end

local c=ah.fetch(al)
if c~=nil then
ab.write("reference",am,c)
end

return c end local al=function(



al)
return(al:gsub("^backups/",""))end local am=function(



am, b, c)
local d,e=loadstring(am,c)

if d==nil then
ac:warn(`failed to compile '{b}':\n\t{e}`)
return nil
end

return d end




ah.load=function(b, c)
local d=al(b)

local e=ab.read("scripts",d)
if e~=nil then
local f=am(e,b,c)

if f~=nil then
return f
end
end

local f=ah.fetch(b)
if f==nil then
return nil
end

local g=am(f,b,c)

if g~=nil then
ab.write("scripts",d,f)
end

return g end


return ah end a.cM=function()local ab=a.cache.cM if not ab then ab={c=aa()}a.cache.cM=ab end return ab.c end end do local aa=function()

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


return ac end a.cN=function()local ab=a.cache.cN if not ab then ab={c=aa()}a.cache.cN=ab end return ab.c end end do local aa=function()
return{
isEnabled=true,
animationScale=1,
scrollSpeed=1
}end a.cO=function()local ab=a.cache.cO if not ab then ab={c=aa()}a.cache.cO=ab end return ab.c end end do local aa=function()
local aa=a.cO()

local ab={}

ab.getScale=function(ac, ad)
return aa.isEnabled and(ad*aa.animationScale)or 0 end


ab.getScrollSpeed=function(ac, ad)
return(ad*aa.scrollSpeed)end


return ab end a.cP=function()local ab=a.cache.cP if not ab then ab={c=aa()}a.cache.cP=ab end return ab.c end end do local aa=function()
return{
createService=a.b3(),
specialProps=a.b2(),

connectionService=a.aJ(),
fetchService=a.cM(),
keyboardService=a.aM(),
localPlayer=a.g(),
messageService=a.cN(),
playerService=a.af(),
rbxServices=a.f(),
tweenService=a.cP(),
}end a.cQ=function()local ab=a.cache.cQ if not ab then ab={c=aa()}a.cache.cQ=ab end return ab.c end end do local aa=function()

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
}end a.cR=function()local ab=a.cache.cR if not ab then ab={c=aa()}a.cache.cR=ab end return ab.c end end do local aa=function()

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
}end a.cS=function()local ab=a.cache.cS if not ab then ab={c=aa()}a.cache.cS=ab end return ab.c end end do local aa=function()
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
}end a.cT=function()local ab=a.cache.cT if not ab then ab={c=aa()}a.cache.cT=ab end return ab.c end end do local aa=function()

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
}end a.cU=function()local ab=a.cache.cU if not ab then ab={c=aa()}a.cache.cU=ab end return ab.c end end do local aa=function()

local aa={a.cR()
,a.cS()
,a.cT()
,a.cU()

}

local ab={}

for ac,ad in aa do
local ae=string.lower(ad.DisplayName)
ab[ae]=ad
end

return ab end a.cV=function()local ab=a.cache.cV if not ab then ab={c=aa()}a.cache.cV=ab end return ab.c end end do local aa=function()







return{
defaultKey="theme",
darken=0.31,

options={
{key="theme"},
{key="darkGreen",color=Color3.fromRGB(34,110,62)},
{key="red",color=Color3.fromRGB(214,58,58)},
},
}end a.cW=function()local ab=a.cache.cW if not ab then ab={c=aa()}a.cache.cW=ab end return ab.c end end do local aa=function()

local aa=a.cV()
local ab=a.cW()
local ac=a.n()

local ad=a.d()
local ae=a.b6()



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
local al=ah(ak)

if al and al.color then
return al.color
end

return aj.Colors.Primary end local ai=function(



ai, aj)
local ak=ah(aj)

if not ak or ak.color==nil then
return ai
end

local al=table.clone(ai.Colors)
al.Primary=ak.color
al.OnPrimary=ak.color:Lerp(Color3.new(0,0,0),ab.darken)

local am=table.clone(ai)
am.Colors=al

return am end


af.selectTheme=function(aj, ak)
ad:expect(ak,{"string"},"'themeService:selectTheme' #1")

local al=ak:lower()
local am=aa[al]

if not am then
ad:error(`'{ak}' isn't a valid theme`)
return
end

aj.selectedKey=al
aj.selectedTheme=if aj:isUsable(am)then ai(am,aj:getPrimaryKey(al))else am
aj:updateObjects()

return aj end



af.setPrimary=function(aj, ak, al)
local am=ak:lower()

ac:setValue(ag..am,al)
ac:save()

if aj.selectedKey==am then
aj:selectTheme(am)
end end


af.updateObject=function(aj, ak)

aj:updateObjectProperties(ak,aj.objects[ak])end


af.updateObjectProperties=function(aj, 
ak, 
al)

for am,b in al do
ak[am]=ae.getDeep(aj.selectedTheme,b)
end end


af.updateObjects=function(aj)
for ak,al in aj.objects do
aj:updateObject(ak)
end end


af.addObject=function(aj, ak, al)
aj.objects[ak]=al
aj:updateObject(ak)end




af.removeObject=function(aj, ak)
aj.objects[ak]=nil end




af.resetRemovedPrimaries=function(aj)
local ak=false

for al in aa do
local am=ac:getValue(ag..al)

if am~=nil and not(type(am)=="string"and ah(am))then
ac:setValue(ag..al,ab.defaultKey)
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


return af end a.cX=function()local ab=a.cache.cX if not ab then ab={c=aa()}a.cache.cX=ab end return ab.c end end do local aa=function()



local aa=a.cQ()
local ab=a.d()

local ac=aa.specialProps
local ad=a.cX()

ac.ThemeTag=function(ae, af)
if type(af)~="table"then
ab:error("expected a 'table' when setting a theme tag")
return
end

ad:addObject(ae,af)end


return a.b3()end a.cY=function()local ab=a.cache.cY if not ab then ab={c=aa()}a.cache.cY=ab end return ab.c end end do local aa=function()local aa="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"local ab={}for ac=1,#aa do ab[string.byte(aa,ac)]=ac-1 end local ac={}ac.decode=function(ad)local ae={}local af=0 local ag=0

for ah=1,#ad do
local ai=ab[string.byte(ad,ah)]
if ai==nil then continue end

af=af*64+ai
ag=ag+1

if ag==4 then
table.insert(ae,string.char(af//65536,(af//256)%256,af%256))
af,ag=0,0
end
end


if ag>=2 then
af=af*2^(6*(4-ag))

table.insert(ae,string.char(af//65536))

if ag==3 then
table.insert(ae,string.char((af//256)%256))
end
end

return table.concat(ae)end


return ac end a.cZ=function()local ab=a.cache.cZ if not ab then ab={c=aa()}a.cache.cZ=ab end return ab.c end end do local aa=function()

return{

["infinite-yield-logo"]=104371861083126,

["lucide-custom-x"]=83276213460768,
["lucide-chevron-down"]=76683704146139,

["lucide-chevron-left"]=116084397950605,
["lucide-blocks"]=80329404661557,


["lucide-terminal"]=138735373900955,
["lucide-pin"]=85638424763987,
["lucide-refresh-cw"]=127184558868486,
["lucide-eraser"]=121383006814792,


["lucide-tag"]=95367077436662,
["lucide-keyboard"]=102097005397654,
["lucide-palette"]=105784737972091,
["lucide-map-pin"]=132787420207871,
["lucide-puzzle"]=139412930697283,
["lucide-zap"]=124181719324437,




["lucide-send"]=80218825031596,
["lucide-sliders-horizontal"]=116738462591690,
["lucide-arrow-down-up"]=121401768678469,
["lucide-calendar-clock"]=121068586159290,
["lucide-chart-column"]=102316903470982,
["lucide-trash"]=126160659084333,


["lucide-book-open"]=116342494079103,
["lucide-settings"]=102340652201372,

["lucide-clipboard-copy"]=103811515822314,
["lucide-arrow-left"]=88403839941496,
["lucide-arrow-right"]=97590643131532,


["lucide-app-window"]=87639344154535,
["lucide-scaling"]=102084193088943,
["lucide-blend"]=138161723939087,
["lucide-eye-off"]=122453588278564,
["lucide-rotate-ccw-clock"]=94201058681961,
}end a.c_=function()local ab=a.cache.c_ if not ab then ab={c=aa()}a.cache.c_=ab end return ab.c end end do local aa=function()






return{
["lucide-custom-x"]="close",
["lucide-settings"]="settings",
["lucide-book-open"]="reference",
["lucide-pin"]="pin",
["lucide-tag"]="editaliases",
["lucide-map-pin"]="editwaypoints",
["lucide-palette"]="edittheme",
["lucide-keyboard"]="editkeybinds",
["lucide-blocks"]="bindsandplugins",
}end a.c0=function()local ab=a.cache.c0 if not ab then ab={c=aa()}a.cache.c0=ab end return ab.c end end do local aa=function()



return{remake=
{
["lucide-app-window"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAACGElEQVR4nO2Z4XHTYAyGpQkaNmg3yAaECSgTEDaBCWADwgSUCXAmaEZgA9wJwiNdbOr0vfyo72q55+dO0h2v+HhE/7luM2c5YGqWA6bmdR5wPB4/MrZmtqZW1JS01IHaufsP5gCnehBfMX5SG6tJY2YfOKRlJucH/GZsrDYNB7xjJk4lyG/N7Ds1Bz65+87g8QGNmb2lOn5Rn1k8MCM/Mnr48/7vBsQX8+fCs9dm9o16T3Xs3X1j0P8jLP5lrKiOG3f/YyfILwoSX8zHwNNrxj3V0fL8G+bggIsCxKPysfC8fD9bQC4XOohH5WPhefl+toB8sFAd/NM9W4D/csBLgn+6Zwvwf10HkPdZBdCTftkCcrlQBfSkX7aAXC5UAT3ply0glwtVQE/6ZQvI5UIV0JN+2QJyuVAF9KRftoBcLlQBPemXLSCXC1VAT/plC8jlQhXQk37ZAnK5UAX0pF+2gFwuVAE96ZctIJcLVUBP+mULyOVCFdCTftkCcrlQBfSkX7aAXC5UAT3ply0glwtVQE/6ZQvI5UIV0JN+2QJyuVAF9KRftoC8ZVxRHTf+6MPWlOC2ZtxTHQ+4rZiDAxobflq8o7746dPiVOB1bWZfqVuqY+/i0+LW5vxxN+CIxoY/hYrs/fS/H5wfsGLcUVWP2FO3HNAyE6eewCFb+/8rpitqSh6oA7VDfGdnyAPmxHLA1CwHTM3sD/gHKmooQAKdXgwAAAAASUVORK5CYII=",
["lucide-arrow-down-up"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAADGSURBVEiJ7ZVBCsIwFEQnnqK9jB694lalLrU9gHvBjQjPzS/GkMYkuHDRgUBp8vM6IX8qLaoV0AHdlzUNcLPRlAIASMy3wMhbI9D+BGBf7m/uQ/KczAGCzUMH+ZAYAHDAyaYGO6ZJ/pH1U80qy86nnpLOkjbOuev00p7Xki6SHlUOatbVOCjSAvgTgN3vHbCPNYk11wHYVlEM0PuZMtNAx0ht1nWujoBsQARCAInmSxHACsIYHkjEcDHAg9xtJDOejB/ToqRechib9LbxHlwAAAAASUVORK5CYII=",
["lucide-arrow-left"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAAv0lEQVRoge3YQQqCUBSF4ftqGy2pSVA0qAW0kgatM9uEwt8kafLMJ6j33TgfOJP8jxDIMxMREVkAcACaz7X37pkEOAMtX0/vpmKZ+DgDBuJb4ODdNgo4ZeI74OLdNkrxXhTvRfFeFO8levwdH0VfsalgQGdm21nexnRNSmn364bNWiVLKRnwWLwi72Vmt1l+CTiS/xNfZ3nAGjSiFhpRC42ohUbU4l9GxD3Y6g2MiHG02MuMiDXALPjxuoiIhPEGT+k+v8NX18MAAAAASUVORK5CYII=",
["lucide-arrow-right"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAAAuElEQVRoge3YQQrCMBRF0R9xF27JWRUHugBX4sB1Vjehcp0UClJtAsafL+9AZ4XeVyiUmImIiFQArIHLcHXePcWAntEN2Hk3FXkZEG8E0A3RoUdsJkbcgYN3WzaNaIVGtEIjWqERrag+gvGv0sNpri9lDOjNbPWVt1HukVJafrph8auSWnIGHM3sWjvkjbPTc/MBW6Y/4r132yzFe1G8F8V7UbyX6PGxD7b4g6PF8Ie7sY/XRUQkhCd2vT7HIMUj7AAAAABJRU5ErkJggg==",
["lucide-blend"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAFTUlEQVR4nO2Wz1HjSBSHfy+C7YkAuWrv64lgTARjIsBEAJc9Y+57gAiQIsATASYCzH2rkCMYEQH7tSXZrT82smUOVO1X9e1va3jvdbfdlm364vx/gI94f393xA8cY6SNnlQbZ/hkZhnZGcNPgY1Hkq5xov2IJd2YWaoOHP0AbNwRfuNX2IeppDsOkpFbOeoBis0/4hCPwQJPbcchjnYANj8k/OYd1lnirDBjQwuy7HE4LjzBOhmeWtFTx7A3bMQRr+gzZIlTFo/VAeZMRL2aB8lwYC3vhGEvWNQRjzjEkF84aVt0F8W8WNJPDFngqdXmHeMAt8QlhiRmNlEPmBtLOseQGzObKqDXAVgkUn51QhLrufkS5s+InxgysOAR2/cAsaqv0hKHLJCRvWG+IxZ4giWJBS+Q4UEUw39jyIV1/MB2hXUmku4x5BvrZGSvA4yJByxZmlmkT4C1UlXfhTPWmpH7H4BhjviB/+CfGJJq4wyfrHil+sCat8QlliRWXKPOB2BIpPwnwkT7ESt/eqQ6ENYeKX9UlzyZ2Ujw4QFodsQ1XmEfpurw26YN9jAknrFkwZzv5O4D0OiIRxziMVjgqR12iHdiDTNWe1/9pw3qh8QjOqyzxBNcwzwrehyOCys1BRme2pbfNttg9juxhn4j2g9ArSNe0WfIEqf0xtSkqm5wYLV7Ts1E1Kta58lwYB3fCeYMifAKvdDr/615AIod8YhDDPmFExoz0tfNlT+NSk7NbK4a1DkiVvMbdYGnVszbBTNGyvdU8mTbPsQU3xKXGJJY8dgqoS5W9Vv4jporspWWes+N1X7btEHvLRHuKbFiP5UDUBgpvzohiRXFIdSOiQcsSakbkFuhZ0b8xJCB1a5eHfr8niJtOKPHz5LhGgpjVV+lJQ4pzsgK1DriN4ZcGJ8PbaHoWeAJliTW8gKV0DNRl58SFDpi3w3Fqh44lfSdnoxshZ6JdmwohFpHPGOkDYkFBzZcQfGYeMCSpZlF2gE9kZpXbkbfGbkV+lJV34UzemZkBer8fsYYMrDgyhmuoDhW9dW8o/CK3Al9U+Xf1CExvRdkK/TcEpdYkljwqnqouScmqnJjtQ+94Qoa5urwWKxDnyPmkv7CkBleWPvVGGnLY5G/OeIexxjygiPqMnJNeIBXItKGgQVv1S7odUQq6Q8MScUXGXMScg31Q+IZSxbUfOffz/n/qar78LxhRE1GVjBcQfM7sYbi9d+6QPuQmKt5CE+q/B3xvjF6QX1lPUglRWriNz/yPWQDwxXMqwykYf23rjDCEXM1r9OhvOCIrWRkK+tNsniq6pNhYB2vUAhzHHGF19iHG7xlDxm5FcMVLDzXAR/ibTAvUn6fz3EfEpyydqoOGK5gwVjVxe4YckX2grmOGCl/qkTKf+HWr9i/+DfOWTMjO2O4goXGxAOWpAwbkEeHtV6JSBvOWGtG7o3hCoY64jeGXNiOnxKHwDoT5c/5kG+sk5F7sz6Ah+Gxqtco1Qe/bfaB+Y54xkgbEqt9C++D4RoWiHTAb5uuMP+BGGPIwDp+YNuoHMDDIlM1H4Exi1yQB8Pce2KiKjdW+22zL4YVWMgRczWfFDO8sD2vUzHPb36MIS842ndencYBPMWiqZo/C1Llz+iE/BDmnBNTSZGqvGHEnIzshWErLD4k5moewpMqf0e8b2xkQZY9vn5cGKmJ3/yo7OmL4VbYkCPmal6nQ3lBv/mMPAo7D+ApDnGF19iHG7w95uY9hp3gIJHy+3yO+5DglI2n+gQM94KDOGKkzR13WF4xf0UyTJV/PuZsPCM/DcMvzZc/wH/OMTZPuOUwmAAAAABJRU5ErkJggg==",
["lucide-blocks"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAADGSURBVEiJ7ZTLDcIwDIaTLkGHYAYujEAWBAnBQE1ViQUq1B0+DjRSQI2bRxVx4DvGjz+2ZSv1iwAGGAgzAKZEwArJHbZEAIAYe5OtEkkzK7bABRgD5fbAKVsFuEf0tPP8o1vkHqb57RATkCOQFFBjyL2f6BvfJ7cCAzyEeX0uWnJPE6izB46VngbtvPdk8fZoF7jBZ63Wer9oKZ2BZK87g7+AJDAppRSBYycBHP0cIaeYc73GTRJogSvwzEg8Amdgl1r9JrwAbBtFmpWGot0AAAAASUVORK5CYII=",
["lucide-book-open"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAADeSURBVEiJ7ZXNCcJAEIUfohWoRK9agecgHizBOhQbUGxFQUgJ/oGXnK0jiIodfB7cw6obskQRkbzT7vB4384eZqS/ENAAFkDCq07ABpgAZaACTIEtcHH4E5PVsAGRw+jSClh7eiMbcDbFrqO7NjAGjk+vHAIth79nPEe7CEDGNwYWoJ7hfczzAeT1lbLM76oAFIAC8EXARZKA8N1AoG+OJ0kqm8te0kBS7Bg1Z0kHSbEVMpMUSupIqqawdja1CSyfRnJeJcAcCHxbTtsHI6DtFeIJCrivzytQ+1jwz+sG7gelHAXthgcAAAAASUVORK5CYII=",
["lucide-calendar-clock"]="iVBORw0KGgoAAAANSUhEUgAAADQAAAA0CAYAAADFeBvrAAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAUOSURBVGiB7ZpbiFZVFMf/yzTJSUtr8tJVKglsTLRQSnSqeUkKKoLyISvqKayg6MF80F6CoEIjulhkUVk2o2j1ZBpeyrxGRkY0E5qlplaYl3R0nF8P55vpzPr2Od8538Wm8A8ffGuftf57r73Ovq19pNP4HwMYDjwNtADTASuDwwq2LQWu4bVoa9bGzKUnJpbB0eg45lbSppI9Ctwk6XpJ4yUNdo8nSuofk3dJasvZhlGS4lFpl7Te6fwh6StJq81sbU7+CMBAYDG9D+8AZye1OxghoE7SVkmXl9UbtUebpLFmdsQ/6JNg8JJ6rzOSdIWkeaEHRREChknaE9BtUzRG4rhO0oCY/JOkHTkbd5mkS2PyX5I2OZ0LFTnhUW9mv6WyA9MC7+2EBN1tTm9OZjf+4ZjjOL5N0JsYaNddXi/0yk128hoz25C3odWGma2XtM4VN3q9kEPnO3lvSj1+CvXTbRZ4m89TdHc7+QKvkDQpZMXrktZI+l3SAkmflcGxStJbitaalQXOstG3EmMz2yJpSoUcxyQ9UAlHHJVGqNfhtEP/Mr5x8lavEBpDfrFtBFZlrHCvpHfN7OOM+nmxQNIESZMkrS7I6QDWV7R1hHbgnBo5VBKhCI2okPNMSbdI+iBNCegjaZyibU+9pPMkHZa0X9F6sym0+cwN4IsKI3SYaLeexH8HsAQ4UILnBLAWeBLon8TnEdqcNkuK75H2S9qWka9N0rNmVnTIA66U9Iqkm7M2Lobtkh43s6W5LYFm11MfltEAz3lnYWxVireBM9Lqqvm0DcyStFjR2AqhU9Ivkr6U9IOkYyl00yWtIM+kU80IATMTevoI8AwwJTQ+gNHADODHBPt1IbuaOkQ0+ENoBuozcvQFngBOBngWnjKHgMHAwUAjnsvLVeBrKkTV4+5T5dCrgcrfLMeZGGcT0Ok4d1Hq1avUIaAh4MzmtIqB+4hSZrOBoSl6swPcs2rt0GvOvhMYm6I/yek/n6LbD2h1+vviOrWYtm918kIz+zpF/0YnJy68ZnZC0lOuuB4Y1yVU1SFgjIr3gi0lzPxC2a+E/jJJx13Z1K4/1Y7QmEDZp9WswMyOK8pjxNHQ9afaDg1x8oEydsxk0Nnp5O5MVbUdGuTk/WVwjAbeB3w6LQ6fWuu+Fam2Q4ecnHiMiGFHoOweSa1AU4KNv33ofguq7ZDvuSy3cYskfRcoP1fSUmBU4NkwJ//a9afWDhnQENTsUjA7quhC7UVJHe5xncJRvtbJNXNoi6STrsyvS0Uwsz/N7DFFs9Xy2KNWucwOcJWkkY7C31b0MKh0p7DC2W8HSq0tnmM88EhoYgBedvwdwMBaOvQwxZiZhyOF+2qKjxLp6xzwhjPIlYAnupvdF+jFkq9eCd4RwM5AZ6XnKIBHA43x60spjvsDFR8Dbi/TmYuA7wOcy7IYTw4YHgU2AqsCv3nA6ADPkgBPJzAjpzPjgN0Brj1E16clCQxYHSBIw8oATx3FV5Zd2ARMJf2MdA1Rlscf6iCKtp+6JSVf6w+RtFE5bsLNLJTjG6noRi4pG9suabOivNvPirKnFyu6jE7a+nRKutfMsuUUYo0ZBCzKGKGPUniGEp1Yq4FDgD8/9UDWT2NuUJSH9p/GSNInkuab2cEUjgGSXpD0kIrPP1mxQdKDZpY1i1t7AJcA8wlncJKwvNCpmZD7c7BqADhL0m2Spikc9Q5FW6D3zMx/7HEa/2n8Df8KtuC31cR8AAAAAElFTkSuQmCC",
["lucide-chart-column"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAB9SURBVEiJY2AYNuD////7////v5+WFvz/////f2qby0SGQ8jzKbE+INWnJPuAVDA0LCAqXiiJA3x6h0YQDV4LqFp8EBt5Iy+SWQjIH6BADBXQo7h+A7XIjtqWMEANXvGfegCetJHjoICBgeEvAwODKwMDgyiF7v1Dof5BBAA6wM3qFndYlQAAAABJRU5ErkJggg==",
["lucide-chevron-down"]="iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAYAAACqaXHeAAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAFbSURBVHic7dhBToNQEMbxwY3GpYkx3qCxpR7GuHfl6Uw8Q0/hzoWNCxPKBbr4u4AXzRMBH/Dqo99v16Qw881QQjETERERERERERGRY5KFHghcmtld/fEpy7JinJYSqA8sgC1f3oCbiPWXDfUXsYqfA6/8tANWEeqv6lq+F+B06voGPDYUjzKElvDOw1/PeRLQR9uUL8xsM8UQ6nNu6hq/ORu7blMj18BHyxYACmA9Ys3bjs1T93Q1Vs2uhtZAGWMIPcOXRLj/+I11/R5h4D0hRo1Bpmzw34efstFkwjtjNpxceGeMxpMN7wwJkHx4JyTIbMI7QN4zUD678A7VA0zXw9Kux3dKID90niA9tzuvzfuoHptDhlAku3lfwJWQ/uZ99PtTM6/N+3pcCfPbvK9lCPMP79RDeP8WfgssD9FL8Gvxoahea9+b2d7MnmO/VhcREREREREREZHj9Ak8sZ1fjUQMhwAAAABJRU5ErkJggg==",
["lucide-chevron-left"]="iVBORw0KGgoAAAANSUhEUgAAAFQAAABUCAYAAAAcaxDBAAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAFESURBVHic7dxPSsNgEEDx6LYb/4GL9rz1Ogr1JuqqtifwDM9FI6jUMNEZv0Tfbx3o8OBLSsuk6yRJkiRJkiRJ+s+ABXADbIA1sGg902wBK+CJjx6As9azzU4fc8dxt63nmxVgCey/iPnmovWcsxCMCXDeetbJ64/5NhDzrvWsk9fHfA7E3OJDadiIY74Hlq3nnTRjJjJmImMmMmYiYyYyZiJjJjJmImMmMmYiYyYyZiJjJjJmIuCS+O+Zq9bzTh5wH4i5M2YAcP3Xj/npL3/eSeCal+B16rrwkff+GQVc4UMpF35tymfUAkYtYNQCRi1g1AJGLWDUAkYtYNQCRi1g1AJGLWDUAkYtgEsL+RjennvPTbqoEcffTbqoYFQ36cZg+J7qJt139FEfP8V0vfsnOLyAYM3hb2pfQCBJkiRJkiRJmpdXW18bb2Yrs24AAAAASUVORK5CYII=",
["lucide-clipboard-copy"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABmJLR0QA/wD/AP+gvaeTAAACSElEQVRoge2ZTU4UQRiGv5IFw1omo1E4AHHtIQwLSDQu9AAmLiCEM7jgBhhxpQkLE+/BRE1EDqDOTDIJbIEBkocFRVIU1T1dPz2VTvrddVfX+71P9VR39ZRIqwYLWAL2gRH++gfsAd2c4U8Cgtv6D/RyAOwnCH+rvdAcKgJgJCKPQ/tbGimlniTyuitgAdgGfgEXRUPo6alK7sYE+AFsAZ3Y8MvAUZXfQIB3FR0CS6HhF6qGrxHgFqLwTjwoqfFeRFY8AgXPpyl6JiLvvHsBP62R+AY8NNoHHqM4TQPDtwt8t9r7IQDnlsmi1f45IcAXy7tntZ+GANyRo73HzUsoVsfAvUfotPrRAPqaLvAJ+BsQfAh8dYX3ASiceHYnpVRdkzSqftlTqBFqAXJr5gDAup7AQ2C1zkJxjzG352vg0rAdlFwbVz81gCP8NICxcd04pGAygILwl8B6SZ81DTEG1rIBAK8c4a+AN6GeVQtHA2QLr4tHAWQNrwMEA2QPr0MEAQAf7L6J5HxvJF/MAVciMlcV2FNDpdRT80S7lHBopwZPEZGR+Hwbh84B3fcl7kn81jd1sGIAdP+8ELEA2iMfRAoA7ZMHIhWA9mruYs7wa+5y2vBs7geN4Vvpk7Jq/fZ/odwqA5iYB8xwNxF4ZJ06K7q2DODIOv7IDHYTdY1d6/SfEKMteyJl1EZRzrJJ3BGRvtzskOTUbxF5rpSauBoLf0JKqXMReSEhty+dDkVktSh8JQEdYBPoc3/Xpg6dAQfABjCfbixa1aNrtik2Bl6PVngAAAAASUVORK5CYII=",
["lucide-custom-x"]="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XCJtVkZsaXBcIjowLFwibVJvdGF0aW9uRWZmZWN0XCI6MCxcIm1Sb3RhdGVFZmZlY3RcIjowLFwibUhGbGlwRWZmZWN0XCI6MCxcIm1WRmxpcEVmZmVjdFwiOjAsXCJtSG96UGVyc3BlY3RpdmVcIjowLFwibVZlclBlcnNwZWN0aXZlXCI6MH0iLCJ0b25lVmFsdWUiOiJ7XCJicmlnaHRuZXNzXCI6MTAwLFwiZXhwb3N1cmVcIjoxMDAsXCJjb250cmFzdFwiOjEwMCxcInNhdHVyYXRpb25cIjoxMDAsXCJodWVcIjoxMDAsXCJ3Yk1vZGVcIjotMSxcIndiVGVtcGVyYXR1cmVcIjoxMDAsXCJ0aW50XCI6MTAwLFwic2hhZG93XCI6MTAwLFwiaGlnaGxpZ2h0XCI6MTAwLFwibGlnaHRiYWxhbmNlXCI6MTAwLFwic2hhcnBuZXNzXCI6MTAwLFwiZGVmaW5pdGlvblwiOjEwMCxcImlzQnJpZ2h0bmVzc0lQRVwiOmZhbHNlLFwiaXNFeHBvc3VyZUlQRVwiOmZhbHNlLFwiaXNDb250cmFzdElQRVwiOmZhbHNlLFwiaXNTYXR1cmF0aW9uSVBFXCI6ZmFsc2V9IiwiZWZmZWN0VmFsdWUiOiJ7XCJmaWx0ZXJJbmRpY2F0aW9uXCI6NDA5NyxcImFscGhhVmFsdWVcIjoxMDAsXCJmaWx0ZXJUeXBlXCI6MH0iLCJwb3J0cmFpdEVmZmVjdFZhbHVlIjoie1wiZWZmZWN0SWRcIjotMSxcImVmZmVjdExldmVsXCI6LTEsXCJleGlmUm90YXRpb25cIjowLFwibGlnaHRMZXZlbFwiOjAsXCJ0b3VjaFhcIjowLFwidG91Y2hZXCI6MCxcInJlZm9jdXNYXCI6LTEsXCJyZWZvY3VzWVwiOi0xLFwiZWZmZWN0SWRPcmlnaW5hbFwiOi0xLFwiZWZmZWN0TGV2ZWxPcmlnaW5hbFwiOi0xLFwibGlnaHRMZXZlbE9yaWdpbmFsXCI6LTEsXCJ0b3VjaFhPcmlnaW5hbFwiOjAsXCJ0b3VjaFlPcmlnaW5hbFwiOjAsXCJyZWZvY3VzWE9yaWdpbmFsXCI6LTEsXCJyZWZvY3VzWU9yaWdpbmFsXCI6LTEsXCJ3YXRlck1hcmtSZW1vdmVkXCI6ZmFsc2UsXCJ3YXRlck1hcmtSZW1vdmVkT3JpZ2luYWxcIjpmYWxzZX0iLCJpc0JsZW5kaW5nIjp0cnVlLCJpc05vdFJlRWRpdCI6ZmFsc2UsInNlcFZlcnNpb24iOiIxNzA1MDAiLCJuZGVWZXJzaW9uIjoxLCJyZVNpemUiOjQsImlzU2NhbGVBSSI6ZmFsc2UsInJvdGF0aW9uIjoxLCJhZGp1c3RtZW50VmFsdWUiOiJ7XCJtQ3JvcFN0YXRlXCI6MTMxMDc2fSIsImlzQXBwbHlTaGFwZUNvcnJlY3Rpb24iOmZhbHNlLCJpc05ld1JlRWRpdE9ubHkiOmZhbHNlLCJpc0RlY29SZUVkaXRPbmx5IjpmYWxzZSwiaXNBSUZpbHRlclJlRWRpdE9ubHkiOmZhbHNlLCJpc1NQZW5TREtPbmx5IjpmYWxzZX0AAKELFgAAAE9yaWdpbmFsX1BhdGhfSGFzaF9LZXlhNTMyNzdhMGRlNWMyMWM4NzRmNDQ1MGQ5YjJhYTAwZWQzYjYyMTNlYjJhYjE5MDNmOWI0M2JhMzIyOGUwYWRjLzY0NVNFRkhrAAAAAgAAAAAAoQsABwAAngYAAAAAoQtiAAAAYgAAACQAAABTRUZU",
["lucide-eraser"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAJiSURBVGiB7Zc/axRBGIffja1fwFziXRQEsbO0FIurApHDSiGFXykhKCJi8B/EoIiCJKn8BBZilShJSEglWISgl8fi9mAY3tnb2Z2ZPWR/sMXdzvvO88wO+0ekTZs20QM8ADaAw/zYAO43zTUxwCywjTufgdmmOdUAHWCvAH6cH1Mn4QE/fRLAHLCrQK4D1/NjXTm/C3Sahnet/KoydnWqroQPvFEzHRJV4I3aZiXqwBs9mpEIAW/0SisREt7o+SSJRAx4o3dciZjwxhxxJIB5B/xKIHZzrjWHxKWqDaOvvDKndiW2qjRKtvLK3NqVWPZpcBM4TbnyCsMba+73ZQs7wO8m4XOOHjA05j8cn5spKOqIyBcRuWifEpGdOKjO4Dd69Eqs7flxhsBSJFiN51XpLYT7bjO0fv8BFhPAP1NY+r7wK0AfOEspATxWWDaLCnY0eON8Mgn0Z8Aerqcx8LAIPqUE8NQBP19U9MkqeFEwtp9D2xL63vSDf67AHwC9SYW/LJjLE8YvKhJndSSAlwr8PtAtU3xkCUwsCiUBzNSCz5t8tIqdWyi0BPBagT8AFsr2EGBJaVLqlaGqRL7yb2utvNVwK4LEbcf4C0Hh86bOB5mHxF+r9lSTADaVeY6BK5XgS0iUvRKDIol85T8o/Y+Aq7XgLYn9CBJ3osMbEN0IEvYLYRz4gBL3HNDx4Q2IHqN7sp1HJesHwLlSfwxciwpvQCw4JFLmOzCw2TIPia6MPjHnQi6OZ75lWXbD/MP5TWwny7KfInJLRLZDU3nkPEgXYBl4B5wk3EJfgbtBBNq0+Y/yDwt+X1uLKXKOAAAAAElFTkSuQmCC",
["lucide-eye-off"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAEf0lEQVR4nN2WPXLbVhhF79emMbyBmF6BoT4zAVcgagXBm6RKE2UFoZIFSC5SZkytQPQKBPWZMVykNpQNGGrSKucJpASADyBB0jOUz8yda1N433uHBH9Mz5yvR+D+/j6RdEU8zszm9MFTF/hMRWSJM7OZDpy6QEm9IHWcHbhEXWBCXZE2zg5Y4lHAg0Qq6R1p4+xAJRoCnucmsSLg2UWCtedUIikmS3JSkkwVmaRbMyu0I0EBDwdJNVCiZ00XM0mXZpZpSzoFPD0HchaQ4PpTyr8CQ8nJBTMv6UEY6YVDpQpL/MWGP9GPcG1EZZLekG0oibMBX6JrBTwc7GfqT9LGWfiVGPF4oQX8P6YikqhiQvok58SZWUn3slZgsfkVGSmMs4DEOpibSEol/UBCFJJOmJ3TnRjphE1i6ppEpA9nW0h42GOkSuSUvCB1SjK2HolOAQbHVOjw/5JvSRtnW0p4FvvNtHprlWRsHRJBAYaNJH0gEalzZmZT/p4q/MZ2toOEh9kzrd5WJTlidqEWXQL+8DGp46x2OK5J9eUkUq3Ozpl7RDdYEWDxBfULqeMscCiuTbW6kec3rv+d3hpmn1LnpM5b5vrHH2kIsChRdd/Xec+iCR2ENanCEs4C0kNg9pw6JnVeW+1WagtcU4meuCUxC0o6CGtGkv4h35A2znaQYHZE5eQVWTJn5gn9gJEHuDjR6rM/tjW/U1g3FbcM6cLZbhKJes5VF5hT9ZfrxswSrYF1maTvSR/OdpPI1Nzj8bauC3ymIrJkbAvLPlrrbslUe35PsEei5qtQMusl3RAoqRdkydg2E6ivK1jzmsdS7VGCeYmaAnfMieiGwJw6JksyLhrTvbAuU/PlPWJdzuOp9iTBrGsq0RPvmTGhGwIjSZ9IHWdrNmPdVM03caFKouRvqcISG39PMCNR89n3jG1xdzwKeLh4pubXeKHFYeggrImpD6ROocUvSf6eKizhbP2TE1GfiO8lN1b7cGkLjFQtqDNjgaM7Yd0pdU7aFKoYKYyzHgnmztR8Qj1HrMnpB4w06Fh0ZvyIUw+sm1PHZCjOOiSYeU/VObPWOUICEZVp9Wets46NlrD2lJrq6VOpzX9k429s5mV6+oD4yDUx3WBFwMPCkaqv8PZBLhjyK90Ja2NqQhLxM4R4cpKJ21HV4+9IG2ctCWZF1FQVU/5e0g2CAh4Wx1SmVYmcnDCs0JYwO9WGEuvoFPD0bFSSC/KWDUt6MD2zN/6I9fQKeNgopubkFQkxU/XmKjQA5iaS/iDfkTbONnwl1gp42CyiZur/lMlJpiolB7ihH2D9SNUTEJOITEhM+nC2gYSRjeEgp9RUq++LL4WzNRKDBDxIRNSETFU9q/vgI/mb/EjaOOuRGCxQBxkvkqr/1urjksw4YCZgXqrwG9tZh4SRvcDmiarP+ETVff6GLLkjOSlUxf8751CFWjAn1QCJvQnskyESByng2VTiYAU8PRInSMzpwxbwdEiUCLykD1/AE5C4QyCin4eAB4kJNVPFBIFM8GwEunj2Av8DUrsBT4j80Q8AAAAASUVORK5CYII=",
["lucide-keyboard"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAACMSURBVEiJ7ZTBCYAwEATFJkw1+rBSBTFd2E5Qexg/JxyiEszpQ51fLmEW9iBZ9hMD4IAWCKQTxOV0gDcQb/E6YJZhadBGJa5JDwFIle/58oMHAzBcPWt2A8x5vCJLTgNSuo8KMOOdO5B+Yzncw3t2MMuFxWdXa+c6vOO77nWAAzpgNBAHoAGK1DY+wgLoIRn20wC3NQAAAABJRU5ErkJggg==",
["lucide-map-pin"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAHXSURBVEiJtZW/S1VhHMafI+osRYguDUmYZUtEYDSEEP6CiziUQ/+BQ4hLCIIUaEJDS9TY5OJaFFGTV2wwkNL6AxwczHIStPo09ERfD/e+91x/vHD4wnM+z/Pc95yXe6QTXlktALgkaUDSNUk3JO1JWpb0QdLLLMvWD9UMNAGzwC+qr5/AQ6Cx3vDzwKpDvgOTQB9wCmgD+oEpYMfMR+Bc0fBm4IuNr4DWBNsOvDW7DjQXKXhsw+s6dvzOnrlaYA/wG9gGzgS9BJSBH77KwGBuJzv2Xk0VzPuXPAnaUOIlDwTuqbUXMbMh19HhWQ7afc8FSRd9LVibDNw/T4eqLT8agLagbVm7ELQua9+CdtbaZmoHeO4FLcvNamu3EpcvWPPsDtpXz2mgE+iSNJ27J0mXK2gHF/Dc2xwLWuol9wdu3NqzVEGfoZWcPgQs+ShuA4vxBJlZs/dW1QKDnwyOJsGDnrv2fC4C3za8ReJvIvCt4aSNFCnIgPc2LAL5gxDZRj86gDc1w4PxNLBp40yCmzOzAbQULrD5Ov+/BWMV7t/zvX3gSl3hIeQOfz8qABNBnwrhw4cKD2EjoeQB8CiEl44UHkpKDiSED9Z21lfSC6wAy8DNYw0/yvoDW1WSkmO9S94AAAAASUVORK5CYII=",
["lucide-palette"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAHoSURBVEiJtdU9SJVRGAfwcxPChowMpAalmnQJIugLirbWihbLBu/YEOgiNLZlEARFDVFDS0PSEIUUEQ1tDcnFIdJokDKFvqSCRH4NPtHx8t57fft44F3+z//jOe85nJPSf65KsyZ6UkpHUkoHU0p9KaXulNL3lNJESqkW33ilUpktlYr1uIQfWtdnnEbTYXPzzZjIDGo4j+PoxgbsxSlcxlLwnqG3lXknpkOwiBG0tdDsxqvQfMOBRsQ2PA7iNHY24A1hBkMZ1o7boV1AX5FwOJu8N7CrmMdwxpvr7+8fx1ydvh0vwuNpvflGfIrmSIbPV6vVR7lZhC7gSsGQ2/AlfA7ljcEAn2PNaswaFa6F1/UcHAtwcLVGmXbFnmAgvCZz0lSAxSegecCKPcHW8PqYkz4EuKVoqhYBK36j5aMOb3PSbIDbi6YquaJ94XUvB2sBHiuaqmTAg/A6nIO3AjxX1jD0m7Af98Pnbj3hRDTeYF0Ls7UYxTvF9RBd9aJ2vA/ChRYBNwpMZ3AHA82EZ4K8hB1NeL9O3J5mgxQJ2/AkxFMaX3Yvg3OyVECIO/E6DBZxVt117fe1UisdEAZFD84ojqILuwIv90zWhXTgYqyiUd3844AsqCc2fwyTlq/ir5Yfpo6/DvgX9RPM5D79NsKI9AAAAABJRU5ErkJggg==",
["lucide-pin"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAERSURBVEiJ3ZRNagJBEIVbyRmCXsFDZOsyREYRs3fhxl3uoygET+EBVBDBH4SsBxfewPmyqYFO2z2p9gfBtxlm6r16b7qKNuYRACrAEEj5HwdgALzGGHwrGrsYxRgcRfSm4NaFm/rq5YDulOsVeTIF5yzVxPr1NfDh4SRSu+iIqsBYBgiw9HDy5mn0kJ1GAGdHFfruIjSDm+GxBkBe921K5nDiDICSMaYnrzMPZSHPbpFBqHkH2MscT4E1bQKZcHZAS9v8y9rtPfBewG0APxa/rzFYCbmtDFQCPkUz1wgyzX47mnJ+nG7txcPfGGNqsSaCrSZNYg04BlsguSDUH3PV9WDjya+KW8C3RUWY3iPEVfgFKaKwBHzDCVIAAAAASUVORK5CYII=",
["lucide-puzzle"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAIsSURBVEiJzZU/a1RBFMXvbJEYExKTuGBhDIqFFkqEYBXEXkE/gEELRQsRooUEJYU2BmRB0BRR0dTBzk8gpjB/DBFJEaONEZeYTkFci5/FO6N3Ny+zz0oHln1zz7n33LlzZ8bsfxhAF/AQqOo3CXQ6/DTwHPgJvAeu/E3wHmCZzWNZwkdyMICzRYK3A/NyWAGGgOPAB9nmgJf6HgU6gXuaLxQRuCnyK6DX2cvAa5ftR6DFYQBfzcxKTTT69N9vZpeAYGYWQvhiZkNmVjGz+2Z2MoRQE35GPp+LrOAosO4yvZ3g7gUWHXcsj9QGjAOVWBIgACNyWksITIqzAdyIq/WEsttQyLqk1WEA3xICY+LM+v2K4K6GzpjR9yNgZ5HOADqABfFWgLIHnwlYIuvtQfLHua0EFKcHeCvutAc2ZNzvbIeAKaBGdjpHUsGd30HFqnpjVcZ9BYNcVUlrZFfEKYcdUKw17zDhS9Qk+PktyjegEr3R/IF36gVWBcwC2xMCMUCF7GqIp/0FfzZ5FehudPRtej0h8F2cHZq3AJ/cSuZwHVQSqWRmF81st+x7ElWKmzcMhBBCzcxOWHZl3DGzY7pK6rIadxmsA4OJFdxy3EWgP5HMb6fYRZfREVfJKhJvddyS6h5be6KIQKxrt+bbgHcu07rj37Bfo0UElkS+S3Y1PNV8hvrjn/fgtBcRuED+iL2d92Q2PTONIteU2Q/gCXDYYV3AY7IG2PTo/9PxC7sg3mc2Dh7YAAAAAElFTkSuQmCC",
["lucide-reference"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAADeSURBVEiJ7ZXNCcJAEIUfohWoRK9agecgHizBOhQbUGxFQUgJ/oGXnK0jiIodfB7cw6obskQRkbzT7vB4384eZqS/ENAAFkDCq07ABpgAZaACTIEtcHH4E5PVsAGRw+jSClh7eiMbcDbFrqO7NjAGjk+vHAIth79nPEe7CEDGNwYWoJ7hfczzAeT1lbLM76oAFIAC8EXARZKA8N1AoG+OJ0kqm8te0kBS7Bg1Z0kHSbEVMpMUSupIqqawdja1CSyfRnJeJcAcCHxbTtsHI6DtFeIJCrivzytQ+1jwz+sG7gelHAXthgcAAAAASUVORK5CYII=",
["lucide-refresh-cw"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAGcSURBVEiJ1dU/axZBEAbw2deABBQtFCSlKSys/IuYQoTYiFUqS1ELFUsFwdrGyg/gh7AQG4s3sVCJRYKFxIAIitgqAZFo/Fncnln13ruT1yYPLMvtzDzPzOwyF7HVkdqM2BYR5yLiWEQciogjETERES8i4mVELEfEw5TSWhGzEBE/UkqnW5WxH4u68Q6zRRzoIr+CL9n3af4+hT3YjRlcxINC6D52dgrgWvZZx00MOpK5jK855lWrAKZz5t9xtLXM3+MOYLXsW5PTAM+y/XZP4uGoi2lynsm2511t6SHwucn5RjZe6EPeF2WmJ/K+8j8FfgHvcwU7xuRZwLDJMI/HY5Lvy0l+HIenTeBsFnhUn/V6Lf+Aw3lf+lM54dOIJ/d3PxuASbzJMXNNAqPQ615wN/u/xmSTQ4kVHOxDnGOPY0M1k5rjCvK6zHXcwfYW4gFu2Rx219uyqLFLNXprvMU9nMcU9qpG91XVWIE1XOoqE5tDCrP40HI3NYaYGsWbCsL5iPiWUjpTnE1E9as8WayNiHhSr5TSamvmWx4/ASSRgNPVRpFyAAAAAElFTkSuQmCC",
["lucide-rotate-ccw-clock"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAAElElEQVR4nO2YjXHaWBSFz63AcgWBCqJUsHIFxhUEOsAVBBrY4AoWVxC2AssVGFcQuQLLDSz7vRXS6qEfJNCuJ5l8M2fOGOme+654EgbTD86vAd6bn2+A3W4XSfqGHDdmFqsD1IXYNYqUEaAQObYoRY4NejSzLX42dQO8YgFypDS6xGvh3EjSZzRBAepDIimWtDSzRCdSN8AOKyC87pwQ+4oiDcNC0h2tUrwXdYtrHIBDAeYWPtXwpOiWdmv1oFhcDousHYCXR8rujRDV8YY2KFa2Pdz22+J57UiZJiiSdIHqWFC3xDthyINmlQF4KVK2+AAd8ogWnBarB2RORZ2kD+iQtbJ3I8VbMeRB8A4rM0N/oEOe0Zwmsc6AdguRgy5QmTXZrncrhjwI3GHHuDezqQaCliEWqzrE0swWauGUAdxbu8JbISZStu0cN9TEaoHzAyyW9BGVmVnLjd13gJm1hJUh5hVzi3Kk1F3irVDjzk/kvxMpGlvD/dB3gDpccOUKE+PlcLzSqw7KQiyWP8TSGrZSJZQAr3FHKleYGC+H45VeTVC6kPQFlRlbzSd2JZTiv7DK60d4IzzAC8jZYQUc75VJeSL/EXtvNQ+OSiiFc+x3VDnWwBuaEB6rBDk7rIDjXfP+gfKp/Md3QsQY9zD0n8ACdlgBzXv3IiLFyvfCJ2K2eEHv0K7QfIgBNtg1yrklZoUX9A7tCs2HGGAqfxs9mlmkEr1Du0LzHVZA4969iIgkPaCcRzs2wL7oG3LcUBDrBMjZYWUuyUrxzhARYk8oZ0vGJ7ygboBXLECOlIJLvDfkHA6QohW6IzPFO0GMl0Ott2bvDwfntxZ0hRi3yAt0iHt9hToNQk7rerw/HJyfyP8AGVvNJ+AxyJkqW2jdEI4UrVDjIGSE2BPKeeZc91pB3QCxpN9QzpWdfh8E2HyvC1RHim7qelAf6YSbOJY/wMw6/gfaBJkBNt+rbpDae426qfo+RilyTb6inD8pmuBnQ3aAzfe6QDkvZjbSAZy/wa5Rzi3nrfACQx4UhdgTyqm9OudAjwCb7+WY0CPWAZz3igUo5xPnbfGCygAOChP5N/LMztxGfWENU/nb58XMRjrAUAWK18p+cctJKB7j/xus4Ts20r/csYY57mGoAsUjSS6gzNIavhUNDf0XOvULTU5NSIqu7GAPDg19Q+wBBShnaQ0Xr20AF5DIf1qkaGwNHzznsu/5HTnPeUOjpp6NAzgInMq/kRxbdGUNgadCrwB7QCEqM7OWB0jrAA6CF/K3kiNFVzbQdqJHiD2gAJVZWsPWyTk6gIMGa/lPJUeKVjRY4idD9hdsjgJU5t5qvsQfYugoNHHhK/QZHZKIH2lpdo93hkyXtZA0UpV7NCczxVsx1BmaLlTdTjmuWazsJ/ZE3HwsYIu7uhBzD4OR+NRFkapXPGdpR7ZNGUO9YDFTZe+GW9CQuKeNu+pr9aD3AA6GCLA5ano3+rJEKxaf4r0wdDIMMlI2yAR9QH14QRvkFp7oRAwNAsOEWKRsGEeAPiLHM0qRY4NiFr3Fz2awAd6LXwO8Nz/8AH8DJlfpQKVelr0AAAAASUVORK5CYII=",
["lucide-scaling"]="iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAYAAABXAvmHAAADiklEQVR4nO2ZgXHTQBBF92jATgekg3SASkgq4NQBQwXQANBB0gGhApwKSAl0YLkBjrcEHVqdtJEdWUmYvJmdzUp/d/8lY1vjBHnmvBzgsfm/D5BSekuKInJGrIlDaIiLEMJGOjC7EpGvxJqYQiLeM+cLOTN4AIavSTq8knloWHxCzrBjS9I9+5CY84qcGTvAd1Il87FjsTHLjoa0IvaCOcazKRQGRxG5JOZiR5yzdyMd2FOJyDWx1yGYYzybQmHwRkTeEC3fiA/03ZKPDvujOL9AfBjPplAYsCWtiZbTEMJPWQB2R3HMK3gxnk2hMCSRMugLzTFgbZR7zCvYMX5MoTAokTLoC83csDLKsPmaMNexE0gZUygMS6QM+kIzJ6yL0jP5lzqEcMX9xM8Zrhk/plDQuw1zwqoojnkBNImU4brxYwoFvdswF6yJco95BV0iZbhn/JhCQe82zAErokwwr6BNpAz3jR9TKOjdhofC+CgTzSvoG9KKUIpP9MIcDYmUoaHQHAqjo+xhXqGnkrtPbKX4RC/M0ZBIGRoKTRfkldw9+CkXyDcyALooe5qfQmGORYmUYXih6YJ8S1oTSoP8hGxAE+UI5pXCHMsSKcOCQtMFuavndpQjmVfMMoWFiZRhSaHpgnxUz60oRzSv5GUtLE2kDIsKTRfkg3ouR5nBPHMqcV5jf5Z1oSGRMjQUmi7ICz2XosxgXmHWljT6GivM0ZBIGRoKTRfkRg81cUn0qcOe5hXGJ1KGGYGUMYWC3m3og9zoR6jDAeYVxpv5zDF+TKGgdxv6IDf6AepwoHmF8WY+s4wfUyjo3YY+yI2+Rx0eYF5hvJnPPOPHFAp6t6EPcqOfQEMU7yZjMN7Mp8/4MYWC3m3og9zoJ1K8m4zBeDOfPuPHFAp6t6EP8l8kVzPAjrFr8r0w3/VjCgW929AH+TvSJ8LVddgR54zdyASY7/oxhYLebVga7Lh+TKGgdxuWBjuuH1Mo6N2GpcGO68cUCnq3YWmw4/oxhYLebVga7Lh+TKGgdxuWBjuuH1Mo6BvSimg5DQt9udsHL2ekH0RL8fkxdICN2K/Xr4mPYaGv11vw8VpEPhPnRMtNCKGSDkMHiDL8PP8UqEPv4bA4gMIhNmL/Ck+Bm9D77StjB1iTromncogbQh8/GrIhEKNwkCj//s26IpZEn5luiSuMX8kI7gGeAy8HeGye/QF+AxWmvkCEkcR0AAAAAElFTkSuQmCC",
["lucide-send"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAG3SURBVEiJ1dS9a1RBFMbheyOCHyFLEERFgyCCYJXGwsJKEMQqnam0kBRWoiAGGxcs/BMs7BQhFmohBiy0EAnEFKbzIwS0ELQygh8xm8diz8JkvFez64J4mjvzzpnfO3M4c4vifwnsxWUsYAV3+gEdwUXM+jWWe4Vuxzk8y4Cr+JzMn3QDHcYEHqOVQZ/iPF6E9im+E3+CDuE0pvEjO+1sQHdhEDOhz4XpCoaroFswjvv4nkHnMYmRJD+Fz+BCjKdz8EHcwrcMuoAm9lccJocPRrngVJ68mEAXcRWjvylfFXx3zJfRyDe8i8UlPMBJbFwvPPROee5VbTqEh9Z2yIe4yZ4a+FwHHmvPQx+vu3mh3RWX8DIxWo1bHc/gjWTfvtC/YmutQWZ2GNetfTy0W7SR5U7G2tS64NnmzTiTlO9YRc58rI11bZBArgTkbqYfSBpk098YbNN+0S3sSPRmGNzsGZ7AbgesmWivQzvRD4MjAXuPAYwm5al8N72YdE48hmsxvtEXeBicDegjvI3x0X4aDOFL8i4+YkNd/kC3BmVZLhVFkXbMVFmWrV4OWxvYiVd4I/lX/ZP4Cd3RIu5RXL4bAAAAAElFTkSuQmCC",
["lucide-settings"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAHJSURBVEiJzZXJSgNBEIYz5hC9KF49ucUlIErwIPgEanBFH8PlKUTQi+sbKOJrOC4oqJDccjQmLol6NcrnYWqYsu1x3EALmun565+/uqtrqmOx/2BAG7AL3MnYAVp/SzwOZHlv54DzGwH6RbAMtMhu7gXr+Y5gvd4+sCViawrbtGCtQEOU+DJQlY+zwLFKyYDiDSr8GMjJ/AlYDBOfF1IVyCuBa2DCwp8BbhUvDzzLfNYkO0BRnKOC9QLpiB07QBrolfdx0SiYxIRaSbNFaAxwgQcZLjBi4SWVTtx0nojjAEgoPEO4DRuL9DUObdvtBEpC0NXhCrYHpGTsCeYqnl9tJSAZltO0kK4UdidYt8JSgpUVdiPYm3+jxohRjr03x3iG2cuHXqCDoJJWFa5T1PWJFBWtKQJOhXD0hUMeUrxapXFoitepj1oswTN41fUIVIB9VAUpXrvSiWtHDUEFZQRrAvo+zKvH6wOaZD4pGpc24oI4zVZRAKYs/Gm8NuKbbhVzYatZ4W2zyymBsGZ3QXBfPAFLUVtuRLUL7O16Q7B1hUW365CA/oVTwbtw2gkunMgz+kyAuJEq385+LK6C+Jd+RQ52G0vX/RN7BRNWoKLt1vZqAAAAAElFTkSuQmCC",
["lucide-sliders-horizontal"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAABsSURBVEiJ5ZRBDoAwCASbxv9/qfxsPHmhWihVg3HOwBIyoZRfAjSgPRkAgKe2qq1GdBt7aqtuSsHMibZghgT7XiaVjlcMNT0JtFROpukdJ7I0lZXh+Umh8cw37RTUQfk0tfCcKPpND2Sx/wPsAA4FoBogcpgAAAAASUVORK5CYII=",
["lucide-tag"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAFGSURBVEiJvZSxSgNBEIZTWYl6R44IAbWx8R2SV7l38FUUxNbKTi3TBSVNwESCok00pWiwSa2fhXNkkr29nYXDKXdm/m/3Zv5rNP4jgF3gAninOr6AE2AjFnAZEF6PO2AzBjCXxm6g7gAYS+3ADCmuZaxNgYm0DIGtWgElkDGQRAOAM+ATODZAHoFmLGCe53kP+DC+5MUL8QDOgQVw6r3ZEvKsIC0TICaATEGmQLtWgII8idQrkOnkQhLbNUCKl1zrxI0c3prN44fsAT+ilxSHO8C9HNod6gd8i1aqEynL34DNoa54U83hqqwgBR6kYETIoau9LfX936o8YXfoqvhUembOmgYgfoe64q4HIiCOQ4H2mrjrYgOk1KEiPqu6gBWSySzgz6EdYF8GiWxNcE4WSPESHaYlsEISoK/E+zFrHAM6Ag6t9b+LKt1JWDZEDwAAAABJRU5ErkJggg==",
["lucide-terminal"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAABySURBVEiJ7ZRBCoAgEAC1T4j/f4jQNaGOIfmHfjAd8tAlNGmhYOesMyq4xiifAbDACEyAkwrMnGyAl4g4IJdIlrqJRh5FPJBKJPY4hoY1e4+4iugTqfxOboGlyNPro6IEIrCKzKHGQwTqhOueln+g/JwD3jcEgg3qEwUAAAAASUVORK5CYII=",
["lucide-trash"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAACnSURBVEiJ7ZXNDcIwDEYtxA5kGjgwaZEQ3SKME0F3eFx8qPKjOIRChfpu0Wf7iyMrFvklgAMuQCAlqOZ6DMZM4Zixx2DSIseMdlLt2WMAwLu6iMhuFuzj3uNCDbpPDL6Gpe2WvMU7WIeBDoAvnZvIvWVpamp5Imt5os1gUfbGuHvlbOcvvopJb5QsmRLAeZ5bC7asyRI3i4EDrsCjoXAABuBg7fpjvAD06oaJMJp5fQAAAABJRU5ErkJggg==",
["lucide-zap"]="iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAEpSURBVEiJzdW/TsJQFMdxZsJSFgbDnxAGfRXCOxgGXQz4QCYuDsbEQOLAopAQRhcNvAABFwcTh4bF+HXoj6S05WLtaeKZ2nPP/Zx7c2/aQuG/BVAFBsAHcAUULfEGsGY37vPA50BLz0sLvBnCX4Ey0NH7NCteD+ELwFP+TrleHngJ2ADfQMUU11hX+bE5rvGxxs7+gscONKHGJx4+cBNdTHRi7RCuukudQVI8uBqMDuGOucea++4q+lTRUUq8rEUBDF2FT3u27QMXv8DXQM3VoAW8AF8JTWJbT8CbaXa+Rc4FPEbyHsEV3uL11LigiZDTPPAKwedgA5RMcWF9QbfmuMCZsLYOdB7CG5lwNVgJPMl8W/Y0eI5c1TczXA084JrgBz8Aqma4VfwA1z2gXm/TI6EAAAAASUVORK5CYII=",
},legacy=
{close=
"iVBORw0KGgoAAAANSUhEUgAAAAoAAAAKCAQAAAAnOwc2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAALiMAAC4jAXilP3YAAAAHdElNRQfkBRIUGwWxgtfpAAAAPUlEQVQI13WOSw0AMAhDmylBAv7NIOXtNNJkQC8F0o8QgQyBRFBkn5IiHkmMyZZ+uqxtjqbZ5EPQUukrfwGG7Gr7eVHzRQAAAABJRU5ErkJggg==",editaliases=
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBgcDDg2x4tFHAAAAVklEQVQoz62QuQ3AMAwDT0FGUabzItn6UhkwDH9FyJICcVTIWheQLK5CEIhVQw0Ldm4aph1xAimS0wsRU2XsNi72wh8gbzYN9VHPyYohJKLqO5u5hfwADbRtUc2EmVAAAAAASUVORK5CYII=",editkeybinds=
"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",edittheme=
"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",editwaypoints=
"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBgcDDgzG5eHRAAAAj0lEQVQoz2NgYPhf8//jfwsGKPjP9N/u/+T/p/9f/D/7vxIDAwsDA4M0Ax/D0v/9DBcY+BhsGcIYlKBq9Rj+MGSyQDlKDJMZsAImBgJgSChgwSp6geEEww8GC2QFWxhsGAQYGBjuMKxgWMh4BxqqEhBq+v///33+s/1X+S+GxwrGXwx3aOfNPww/GP7hUgAAJakp6yg93EUAAAAASUVORK5CYII=",imgstudiopluginlogo=
"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",minimize=
"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",pin=
"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",reference=
"iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAQAAABLCVATAAAABGdBTUEAALGPC/xhBQAAAAJiS0dEAP+Hj8y/AAAAB3RJTUUH4wcXDAMMCGuWNgAAAVtJREFUSMfdlr1OAkEUhc8YE9daTTaa+BYatHEfxG2gdSvs3QpCQg08gPY8gjaC+w5QGMOSXUuNlRybBRkzM8xMrDjd5s79cs+9Oz/A1kroQ7zENc5whBDfKFEiw4N4dqIz4A2nVGnKhIEtJmZBkwrGNpg72ijdhBlYYUhyYMK0rTEk2dZh6k4Ykqwrxs8AbzhQ8J/wCCDClSL2jlPx9beepqmtTDXR5jJ/Z0W6tfw7ZK2ydqt6agg1SyOmACJNNGRNjNeNdZwbvVRHtnbuZWwts7KGE+1C09QA4Fj64qd5M2inRn7I1hbe1iiDcm9QLoNm3qCZDMq8QS8yaOgNGsqgkWeXcowlkCC6XqCuqKb2e4zs4xWHiqWuxwjAhvM+a2jqZMsJ0zJYZs8a09/QvX+6jgCAMedGyNzqggQABkw4UUImTLinyjE9Ii4QV4+IBQqUyHAvRpa1bJN+AFElufnK4ja7AAAAAElFTkSuQmCC",settings=
"iVBORw0KGgoAAAANSUhEUgAAADAAAAAwCAQAAAD9CzEMAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfhCxoGHBsxJwxuAAACQklEQVRYw+2XvU9UQRTF5+0+I4Kria6xATWoJAoWliY2qBHJxlBYSG9iFFx1MYbOwkQrLUj8R1ArCxIbYyJYgWiDH2yWSk2AuLKS/Cx8u2Z27sybxz4KEk43d889Zz7u3Hmr1Da2CHhPM6bTlN+LhD0+uRkvh8MJoikaHNpCBl1itLM5wC4PLc5R5TVX2RGNu5lgWTzkMiN1STJcZopfHI+TD5mL0is8pIt7VHFhkQLt3ORTNJ6MMxglOfT1nXfJ5/m5AQMd8/XNlQyetSwPULTJn2I9FYMf7JcNXjrTZinRS548fYw1SkHGE0m+35FQ4xZZjZ3lDjUrf42jpkGBP1b6RXHFlxwWQ1LCWcoi+UbCol7lmi3hAK+Evc9aDbJ8MPjv6HHdhMDY26Jy8e82ndW4fTr/kz5qSSec3D6N+y1WXCmlWNGSdju5OY27bjKkdq03Xbxm9Q9VP4MlbeR+VvRfK7EGZBhXB7WQeAcaGNBGRygRONh0MmWU3RyhlR8yb/An2WejX+G7eHFKVoP7Iv8rZyTykPXa1xgQ5QetzaUmXDaOseawSNbs4LQ0o6e4MEuJk7TRRm9su34h72iOCmngN91imQYr6oFKAxPBgq0qMky3PP8lcg5zLmjkZS9JnTUSsz6eR8QFinRQsDxCdXxhkA5u87lRCmGcQQ+rzDBcJ9LOqMWkzHV2RqyQYWao0u9xRuYnLI9Fg0c+Jy5008BsuvJD4vW8+H2+b7rBYoLoRtDKn0Bfi7eG/JsU5bexqfgL1SjLmuYaxYMAAAAASUVORK5CYII=",
},
}end a.c1=function()local ab=a.cache.c1 if not ab then ab={c=aa()}a.cache.c1=ab end return ab.c end end do local aa=function()














local aa=a.a()
local ab=a.aE()
local ac=a.n()
local ad=a.k()
local ae=a.cL()
local af=a.cM()
local ag=a.cZ()
local ah=a.d()

local ai=a.c_()
local aj=a.c0()
local ak=a.c1()

local al=ab.storage.imagePath
local am=ab.ui.legacyIconsKey

local b={}


local c=setmetatable({},{__mode="k"})

local d={}

local e={}local f=function(


f)
return ac:getValue(am)==true and aj[f]~=nil end local g=function(


g, h)
return`{if h then"legacy"else"new"}|{g}`end local h=function(



h)
local i=ai[h]

if type(i)=="number"then
return`rbxassetid://{i}`
end

return i or""end local i=function(



i, j)
local k=`{i}/{j}.png`
local l=ae.path("assets",k)

if ae.has("assets",k)then
return ad:getCustomAsset(l)
end

local m=ak[i]
local n=if m then m[j]else nil

if n~=nil then
n=ag.decode(n)
else
n=af.fetch(al:format(i,j))
end

if n==nil then
return nil
end

ae.write("assets",k,n)
ah:log(`created a file to asset: '{l}'`)

return ad:getCustomAsset(l)end local j=function(



j, k)
if type(aa.getcustomasset)~="function"then
return h(j)
end

if k then
local l=i("legacy",aj[j])
if l then
return l
end
end

return i("remake",j)or h(j)end local k=function(



k)

if type(aa.getcustomasset)~="function"then
return h(k)
end

local l=f(k)
local m=g(k,l)

local n=d[m]
if n~=nil then
return n
end

if e[m]then
return nil
end

e[m]=true

task.defer(function()
d[m]=j(k,l)
e[m]=nil

for o,p in c do
if g(p,f(p))==m then
o.Image=d[m]
end
end
end)

return nil end



b.loadImage=function(l, m, n)
ah:assert(ai[n]~=nil,`invalid asset name: {n}`)

c[m]=n
m.Image=k(n)or""end



b.refresh=function(l)
for m,n in c do
m.Image=k(n)or""
end end


return b end a.c2=function()local ab=a.cache.c2 if not ab then ab={c=aa()}a.cache.c2=ab end return ab.c end end do local aa=function()

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
}end a.c3=function()local ab=a.cache.c3 if not ab then ab={c=aa()}a.cache.c3=ab end return ab.c end end do local aa=function()



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


copyFeedbackTime=1.5,
}end a.c4=function()local ab=a.cache.c4 if not ab then ab={c=aa()}a.cache.c4=ab end return ab.c end end do local aa=function()

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
}end a.c5=function()local ab=a.cache.c5 if not ab then ab={c=aa()}a.cache.c5=ab end return ab.c end end do local aa=function()








local aa=a.c5().args
local ab=a.b6()

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
local al=aj+1

while al<=#ai do
local am=string.sub(ai,al,al)

if am=="\\"then
al=al+2
elseif am==ak then
return al
else
al=al+1
end
end

return nil end local aj=function(



aj)
local ak={}local al=function(

al, am, b)
if al==""then
return
end

local c=ak[#ak]
if c and c.color==am and c.bold==b then
c.text=c.text..al
else
table.insert(ak,{text=al,color=am,bold=b})
end end


local am=1
local b=#aj

while am<=b do
local c=string.sub(aj,am,am)
local d=if am>1 then string.sub(aj,am-1,am-1)else""


if(c=="@"or c=="#")and not ag(d)then
local e,f=string.find(aj,af,am+1)
if f then
al(string.sub(aj,am,f),aa.tag,true)
am=f+1
continue
end
end


if(c=='"'or c=="'")and not ag(d)then
local e=ai(aj,am)

if e then
al(string.sub(aj,am,e),aa.string,false)
am=e+1
continue
end
end

if ag(c)then
local e,f=string.find(aj,ae,am)
local g=string.sub(aj,am,f)
al(g,if ah(g)then aa.number else nil,false)
am=f+1
else
al(c,if ad[c]then aa.symbol else nil,false)
am=am+1
end
end

return ak end


ac.apply=function(ak, al)
local am={}

for b,c in aj(tostring(al))do
local d=ab.escapeRichText(c.text)

if c.color then
d=ab.colorFromRGB(d,c.color)
end
if c.bold then
d=`<b>{d}</b>`
end

table.insert(am,d)
end

return table.concat(am)end


return ac end a.c6=function()local ab=a.cache.c6 if not ab then ab={c=aa()}a.cache.c6=ab end return ab.c end end do local aa=function()



local aa=a.cY()
local ab=a.c2()
local ac=a.a()
local ad=a.cX()
local ae=a.c3()

local af=a.aJ()
local ag=a.f()
local ah=a.c4()

local ai=a.c6()

local aj=4
local ak=8



local al=5
local am=5
local b=ah.titleHeight+al+am*2

local c={
container=nil,

items={},
nextOrder=0,

queue={},


room=math.huge,
}local d=function(

d, e, f)
local g=aa.new("Frame","Notification",d,{
BorderSizePixel=0,
ClipsDescendants=true,
LayoutOrder=e,
Size=UDim2.fromOffset(ah.size.X.Offset,0),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local h=aj+ah.iconSize+ak


local i=if f then ah.iconSize+aj else 0

local j=aa.new("TextLabel","Title",g,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(h,0),
Size=UDim2.new(1,-(h*2+i),0,ah.titleHeight),
Text="",
TextSize=ah.titleTextSize,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local k=aa.new("Frame","Description",g,{
AnchorPoint=Vector2.new(0.5,1),
ClipsDescendants=true,
Position=UDim2.new(0.5,0,1,-al),
Size=UDim2.new(1,-10,1,-(ah.titleHeight+al)),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
})

aa.new("UICorner",k,{
CornerRadius=UDim.new(0,ah.cornerRadius),
})


local l=aa.new("TextLabel","Text",k,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Position=UDim2.fromOffset(am,am),
Size=UDim2.new(1,-am*2,0,0),
Text="",
TextSize=ah.textSize,
RichText=true,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

local m=aa.new("ImageButton","PinButton",g,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,aj,0,ah.titleHeight/2),
Size=UDim2.fromOffset(ah.iconSize,ah.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

local n=aa.new("ImageButton","CloseButton",g,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-aj,0,ah.titleHeight/2),
Size=UDim2.fromOffset(ah.iconSize,ah.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(m,"lucide-pin")
ab:loadImage(n,"lucide-custom-x")


local o
if f then
o=aa.new("ImageButton","CopyButton",g,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-(aj*2+ah.iconSize),0,ah.titleHeight/2),
Size=UDim2.fromOffset(ah.iconSize,ah.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(o,"lucide-clipboard-copy")
end

return g,j,l,m,n,k,o end local e=function(




e, f, g)
local h=aa.new("Frame","Actions",e,{
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Position=UDim2.new(0.5,0,1,-am),
Size=UDim2.new(1,-am*2,0,ah.actionHeight),
ZIndex=2,

aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,ah.actionGap),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local i={}

for j,k in f do
local l=k.primary==true

local m=aa.new("TextButton","Action",h,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
LayoutOrder=j,
Size=UDim2.fromOffset(0,ah.actionHeight),
Text=k.text,
TextSize=ah.textSize,
ZIndex=2,
ThemeTag={
BackgroundColor3=if k.primary then"Colors.Primary"else"Colors.Background",
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ah.cornerRadius),
}),
aa.new("UIPadding",{
PaddingLeft=UDim.new(0,ah.actionPadding),
PaddingRight=UDim.new(0,ah.actionPadding),
}),
aa.new("UISizeConstraint",{
MinSize=Vector2.new(ah.actionMinWidth,0),
}),
})local n=function(


n)
if l then
m.BackgroundTransparency=if n then 0.2 else 0
else
ad:updateObjectProperties(m,{
BackgroundColor3=if n then"Colors.Buttons.Holding"else"Colors.Background",
})
end end


table.insert(g,af:Connect(m.MouseEnter,function()
n(true)
end))
table.insert(g,af:Connect(m.MouseLeave,function()
n(false)
end))

i[j]=m
end

return i end local f=function(


f)
for g,h in f.connections do
af:disconnect(h)
end

table.clear(f.connections)end


c.getContainer=function(g, h)
if g.container then
return g.container
end

local i=aa.new("Frame","Notifications",h,{
BackgroundTransparency=1,
BorderSizePixel=0,
Size=UDim2.fromOffset(ah.size.X.Offset,0),
})

aa.new("UIListLayout",i,{
Padding=UDim.new(0,ah.spacing),
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
g:add(l.title,l.message,l.duration,l.choices,l.options)
end

return i end



c.getStackHeight=function(g)
local h=g.container
if not h then return 0 end

local i=0
local j=0

for k,l in h:GetChildren()do
if l:IsA("GuiObject")then
i=i+1
j=j+l.Size.Y.Offset
end
end

if i>1 then
j=j+(i-1)*ah.spacing
end

return j end



c.refreshLayout=function(g)
local h=g.container
if not h then return end

h.Size=UDim2.fromOffset(ah.size.X.Offset,g:getStackHeight())

if g.onLayoutChanged then
g.onLayoutChanged()
end end


c.tweenHeight=function(g, h, i)
if h.tween then
h.tween:Cancel()
end

local j=TweenInfo.new(ah.tweenTime,Enum.EasingStyle.Quart,Enum.EasingDirection.InOut)
h.tween=ag.TweenService:Create(h.frame,j,{
Size=UDim2.fromOffset(ah.size.X.Offset,i),
})
h.tween:Play()end




c.wantedHeight=function(g, h)
local i=math.max(ae:getScale(),0.01)
local j=h.textLabel.AbsoluteSize.Y/i


local k=if h.actionsHeight>0 then 0 else ah.size.Y.Offset
local l=math.max(j+b+h.actionsHeight,k)
return math.min(l,ah.maxHeight,g.room)end



c.fitHeight=function(g, h, i)
if h.removed or not h.textLabel then return end

local j=g:wantedHeight(h)
if j==h.height then return end
h.height=j

if i then
if h.tween then
h.tween:Cancel()
end

h.frame.Size=UDim2.fromOffset(ah.size.X.Offset,j)
else
g:tweenHeight(h,j)
end end




c.setRoom=function(g, h)
if h==g.room then return end
g.room=h

for i,j in g.items do
g:fitHeight(j,true)
end

g:trimToRoom()end



c.liveHeight=function(g)
local h=0

for i,j in g.items do
h=h+j.height
end

if#g.items>1 then
h=h+(#g.items-1)*ah.spacing
end

return h end



c.trimToRoom=function(g)
while#g.items>1 and g:liveHeight()>g.room do
local h

for i,j in g.items do
if i==#g.items then break end

if not j.pinned then
h=j
break
end
end

if not h then break end
g:remove(h)
end end


c.pin=function(g, h)
if h.pinned or h.removed then return end
h.pinned=true

h.titleLabel.Text=h.title.." (Pinned)"
ad:addObject(h.pinButton,{ImageColor3="Colors.Primary"})

local i=h.titleLabel
task.spawn(function()
i.TextTransparency=0.5
task.wait(ah.flashTime)
i.TextTransparency=0
end)end


c.remove=function(g, h)
if h.removed then return end
h.removed=true

local i=table.find(g.items,h)
if i then
table.remove(g.items,i)
end

f(h)

g:tweenHeight(h,0)
task.delay(ah.tweenTime,function()
h.frame:Destroy()
end)end


c.trim=function(g)
while#g.items>ah.maxVisible do
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


c.add=function(g, h, i, j, k, l)
g.nextOrder=g.nextOrder+1

local m={
title=h,
pinned=false,
removed=false,
connections={},
height=ah.size.Y.Offset,
actionsHeight=if k then ah.actionHeight+ah.actionsTopGap+am else 0,
}


local n=l~=nil and l.copy==true and ac.setclipboard~=nil

local o,p
m.frame,m.titleLabel,m.textLabel,m.pinButton,m.closeButton,o,p=
d(g.container,g.nextOrder,n)


m.copyButton=p
m.copyText=tostring(if l and l.copyText~=nil then l.copyText else i)

m.titleLabel.Text=h
m.textLabel.Text=ai:apply(i)

table.insert(m.connections,af:Connect(m.pinButton.Activated,function()
g:pin(m)
end))

if p then
table.insert(m.connections,af:Connect(p.Activated,function()
g:copy(m)
end))
end



local q=k~=nil and type(j)~="number"

if q then
m.pinned=true
m.pinButton.Visible=false
end

if k then
local r=e(o,k,m.connections)

for s,t in r do
local u=k[s]

table.insert(m.connections,af:Connect(t.Activated,function()
if m.removed then return end

g:remove(m)

if u.onTap then
u.onTap()
end
end))
end
end

table.insert(m.connections,af:Connect(m.closeButton.Activated,function()
g:remove(m)
end))


table.insert(m.connections,af:Connect(m.textLabel:GetPropertyChangedSignal("AbsoluteSize"),function()
g:fitHeight(m)
end))

table.insert(g.items,m)
g:tweenHeight(m,m.height)


m.frame:GetPropertyChangedSignal("Size"):Connect(function()
g:refreshLayout()
end)
g:refreshLayout()

if not q then
local r=if type(j)=="number"then j else ah.defaultTime
task.delay(r,function()
if not m.pinned then
g:remove(m)
end
end)
end

g:trim()
g:trimToRoom()end



c.copy=function(g, h)
local i=ac.setclipboard
if i==nil or h.removed then return end

i(h.copyText)
ad:addObject(h.copyButton,{ImageColor3="Colors.Primary"})

task.delay(ah.copyFeedbackTime,function()
if h.removed then return end
ad:addObject(h.copyButton,{ImageColor3="Colors.Icons"})
end)end



c.notify=function(g, h, i, j, k)
if i==nil then
i=h
h=ah.defaultTitle
end

h=tostring(h)

if not g.container then
table.insert(g.queue,{title=h,message=i,duration=j,options=k})
return
end

g:add(h,i,j,nil,k)end






c.ask=function(g, h, i, j, k)
h=tostring(h)

if not g.container then
table.insert(g.queue,{title=h,message=i,choices=j,duration=k})
return
end

g:add(h,i,k,j)end


c.destroy=function(g)
for h,i in g.items do
f(i)
end

table.clear(g.items)
table.clear(g.queue)
g.container=nil end


return c end a.c7=function()local ab=a.cache.c7 if not ab then ab={c=aa()}a.cache.c7=ab end return ab.c end end do local aa=function()



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


return ac end a.c8=function()local ab=a.cache.c8 if not ab then ab={c=aa()}a.cache.c8=ab end return ab.c end end do local aa=function()
local aa=a.b()
local ab=a.a()

local ac=a.cJ()
local ad=a.v()
local ae=a.d()

local af=a.t().usedCmds
local ag=a.j()
local ah=a.f()
local ai=a.aE()

local aj=a.cK()
local ak=a.W()
local al=a.cD()
local am=a.cH()
local b=a.ag()

local c=ai.commands.cmdsRank
local d=c.maxTimesUsed
local e=c.decreasePerUse
local f=c.increasePerUse

local g=aa.iyGarbages or{}
aa.iyGarbages=g

local h={
garbages=g
}

h.registerGarbage=function(i, j)
return i:getGarbage(j)or i:createGarbage(j)end


h.createGarbage=function(i, j)
local k=i.garbages[j]
if k==nil then
k={}
i.garbages[j]=k
end

return k end


h.getCommandData=function(i, j)
return ac.lookup[j:lower()]end


h.hasGarbage=function(i, j)
return i.garbages[j]~=nil end


h.getGarbage=function(i, j)
return i.garbages[j]end


h.collectGarbage=function(i, j)
local k=i.garbages[j]

if k~=nil then
i.garbages[j]=nil
return k
end end


h.commandUsed=function(i, j)
local k=af:getValue(j)or 0

local l=math.clamp(k+f,0,d)
af:setValue(j,l)

for m,n in af:getData()do
if m==j then continue end

local o=(l==d)

if(o or n<l)and n>0 then
n=n-e

if n==0 then n=nil end
af:setValue(m,n)
end
end

af:save()end local i=function(



i)
local j={}
if i and i.args then
for k,l in i.args do
j[k]={value=l.value}
end
end
return j end





local j=setmetatable({},{__mode="k"})

local k=`{ag.privateFolder}/error-logs`local l=function(


l, m, n)
local o=ab.writefile
if not o then return nil end

if ab.makefolder then
pcall(ab.makefolder,ag.privateFolder)
pcall(ab.makefolder,k)
end

local p=`{k}/{os.time()}-{l}.txt`
local q=table.concat({
`command: {l}`,
`time: {os.date("%Y-%m-%d %H:%M:%S")}`,
`error: {m}`,
"",
"traceback:",
n or"(not available)",
},"\n")

local r=pcall(o,p,q)
if r then return p end

return nil end



h.reportError=function(m, n, o, p)
local q=tostring(o)
local r=l(n,q,p)

local s=q
if r then
s=s..`\nsaved to {r}`
end

m:notify(`'{n}' failed`,s)end



h.run=function(m, n, o, p)
ae:expect(n,{"string"},"'commandsController:run' #1")
ae:expect(o,{"table","nil"},"'commandsController:run' #2")

local q=ac.lookup[n]
ae:assert(q,"invalid command")


o=o or ak.new({})

local r=coroutine.running()
local s=j[r]
local t=s~=nil
local u=t and not p

if not u then
m:commandUsed(q.name)


local v=i(o)
m.privateEnv.lastArgs=m.privateEnv.lastArgs or{}
m.privateEnv.lastArgs[q.name]=v

if q.name~="lastcommand"then
m.privateEnv.lastCommand={
name=q.name,
args=v
}
end
end

if q.run==nil then
ae:warn(`missing command run func: {q.name}`)
return
end

if not t then
s={reported=false}
j[r]=s
end

local v
local w,x=xpcall(function()
q.run(m,o)
end,function(w)

v=debug.traceback(tostring(w),2)
return w
end)

if not t then
j[r]=nil
end

if not w then


if not s.reported then
s.reported=true
m:reportError(q.name,x,v)
end

error(x,0)
end end



h.getLastArgs=function(m, n)
local o=m.privateEnv.lastArgs
return o and o[n]end local m=function(


m)
local n=ac.lookup[m:lower()]
if n==nil then return 0 end


return af:getValue(n.name)or 0 end


h.search=function(n, o, p)
local q=aj:searchAtArray(ac.array,o,p)
local r=o:lower()
local s={}

for t,u in q do
table.insert(s,{
alias=u,
index=t,
isPrefix=u:lower():sub(1,#r)==r,
usage=m(u),
})
end

table.sort(s,function(t,u)
if t.isPrefix~=u.isPrefix then return t.isPrefix end
if t.usage~=u.usage then return t.usage>u.usage end
return t.index<u.index
end)

local t={}
for u,v in s do
t[u]=v.alias
end

return t end



h.resolvePlayers=function(n, o)
return b(o)end


h.init=function(n, o)
ae:assert(o,"'commandsController:init' #1 expected a config to init")

local p=a.aJ()
local q=a.bp()
local r=a.c7()


n.notify=function(s, ...)
return r:notify(...)end



n.ask=function(s, ...)
return r:ask(...)end


n.stringify=function(s, ...)
return q:stringify(...)end


n.unstringify=function(s, ...)
return q:unstringify(...)end


n.connect=function(s, ...)
return p:Connect(...)end


n.expectExploit=function(s, t)
local u=ab[t]
if u~=nil then return u end

s:notify("Incompatible Exploit",`Your exploit does not support this command (missing {t})`)end


n.getRoot=function(s)
local t=s.playerService:getRootPart()
if t then return t end

s:notify("Character","your character is not loaded")end


n.getRootPart=n.getRoot
n.Connect=n.connect


local s=a.b4()
n.isMobile=s
n.isPC=not s


n.localPlayer=a.g()
n.executorEnv=ab
n.privateEnv=aa


n.infiniteYield=o.infiniteYield
n.playerService=o.playerService
n.fetchService=o.fetchService


n.signals={
onCameraReset=ad.new()
}


n.config={
links=ai.links
}


n.userSettings=UserSettings()
n.gameSettings=settings()

n.userGameSettings=n.userSettings:GetService("UserGameSettings")
n.gameNetworkSettings=n.gameSettings:GetService("NetworkSettings")


n.loopService=a.c8()


n.storage=a.t()


n.robloxServices=ah
n.rbxServices=ah

n.teleportService=ah.TeleportService
n.groupService=ah.GroupService
n.runService=ah.RunService
n.starterGui=ah.StarterGui
n.coreGui=ah.CoreGui
n.players=ah.Players
n.guiService=ah.GuiService
n.networkClient=ah.NetworkClient
n.proximityPromptService=ah.ProximityPromptService
n.commandsList=ac


al.restore(ac)



am.restore(ac,function(t,u)
ae:warn(`plugin '{t}' could not be loaded: {u}`)
end,function(t)
n:notify("Plugins",`'{t}' is still loading. It may be waiting for something that is missing, like PlayerScripts.PlayerModule`)
end)end


return h end a.c9=function()local ab=a.cache.c9 if not ab then ab={c=aa()}a.cache.c9=ab end return ab.c end end do local aa=function()


return{

settingKey="interface.keepIY",


bundleName="compiled.luau",


localBundlePath="iy-remake/compiled.luau",
}end a.da=function()local ab=a.cache.da if not ab then ab={c=aa()}a.cache.da=ab end return ab.c end end do local aa=function()



local aa=a.a()
local ab=a.aJ()
local ac=a.f()
local ad=a.cM()
local ae=a.da()
local af=a.n()
local ag=a.d()

local ah={}

local ai=false
local aj=false local ak=function()


return af:getValue(ae.settingKey)==true end local al=function()



local al=ad.downloadUrl(ae.bundleName)

return table.concat({
"local ok, source = pcall(readfile, \""..ae.localBundlePath.."\")",
"if not ok or type(source) ~= \"string\" or source == \"\" then",
"\tsource = game:HttpGet(\""..al.."\")",
"end",
"loadstring(source)()",
},"\n")end local am=function()



if aj or not ak()then return end

local am=aa.queueteleport
if am==nil then return end

aj=true

local b,c=pcall(am,al())
if not b then
aj=false
ag:warn("keepiy: failed to queue the loader: "..tostring(c))
end end


ah.start=function()
if ai then return end
ai=true

ab:Connect(ac.Players.LocalPlayer.OnTeleport,am)end


ah.enable=function(b)
if not b:expectExploit("queueteleport")then return end

b.infiniteYield:setKeepIY(true)
b:notify("Keepiy","on: IY runs again after you teleport, and the interface stays open")end


ah.disable=function(b)
b.infiniteYield:setKeepIY(false)
b:notify("Keepiy","off: IY will not run after the next teleport")end


ah.toggle=function(b)
if ak()then
ah.disable(b)
else
ah.enable(b)
end end


return ah end a.db=function()local ab=a.cache.db if not ab then ab={c=aa()}a.cache.db=ab end return ab.c end end do local aa=function()











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
}end a.dc=function()local ab=a.cache.dc if not ab then ab={c=aa()}a.cache.dc=ab end return ab.c end end do local aa=function()

local aa=a.f()
local ab=a.ag()
local ac=a.cJ()
local ad=a.l()
local ae=a.p()
local af=a.m()
local ag=a.cH()
local ah=a.b6()

















local ai={}local aj=function(

aj, ak, al)
return{
success=false,
message=aj,
options=ak,
comment=al,
}end



ai.normalizeOptions=function(ak)
if type(ak)=="string"then
return string.split(ak,"|")
end
return ak or{}end



ai.getOptions=function(ak, al)
local am=(al and al.options)or ak.options
return ai.normalizeOptions(am)end local ak=function(



ak, al)
local am=al:lower()

for b,c in ak do
local d=tostring(c)
if d:lower()==am then
return d
end
end

return nil end local al=function(


al)
if type(al)~="table"then return{}end
return ah.unlookupify(al)end local am=function(


am)
return{
success=true,
value=am,
color="string",
}end local b=function(


b, c)
local d=ai.normalizeOptions(c.options)

if#d==0 then
return am(b)
end

local e=ak(d,b)

if e then
return{success=true,value=e,color="string"}
end

return aj(" - invalid option",d)end


local c={
["true"]=true,yes=
true,enabled=
true,
["false"]=false,no=
false,disabled=
false,
}local d=function(

d)
local e=c[d:lower()]

if e==nil then
return aj(" - invalid boolean",{"false","true"})
end

return{
success=true,
value=e,
color="boolean",
}end local e=function(


e, f)
local g=tonumber(e)

if g==nil or g~=g or math.abs(g)==math.huge then
return aj(" - invalid number")
end

local h,i=f.min,f.max

if f.clamp then
h,i=f.clamp[1],f.clamp[2]
end

if h and g<h then
return aj(` - the <b>MIN</b> is <b>{h}</b>`)
end

if i and g>i then
return aj(` - the <b>MAX</b> is <b>{i}</b>`)
end

if f.floor and math.floor(g)~=g then
return aj(" - whole numbers only")
end


if tonumber(string.format("%.5f",g))~=g then
return aj(" - too many decimal places")
end

return{
success=true,
value=g,
display=`<b>{e}</b>`,
color="number",
}end local f=function(


f)
local g=f:split(",")

if#g>3 then
return aj(" - too many args")
end

local h={}

for i,j in g do

if j:match("^%s*$")then
j="0"
end

local k=e(j,{})

if not k.success then
return k
end

h[i]=k.value
end

if#h~=3 then
return{
success=false,
comment=true,
message=`: {({"X","Y","Z"})[#h+1]}`,
}
end

local i=Vector3.new(h[1],h[2],h[3])

return{
success=true,
value=i,
display=`({i})`,
color="others",
}end local g=function(


g)
local h=g:match("^#?(%x%x%x%x%x%x)$")

if h then
local i=tonumber(h:sub(1,2),16)
local j=tonumber(h:sub(3,4),16)
local k=tonumber(h:sub(5,6),16)

return{
success=true,
value=Color3.fromRGB(i,j,k),
color="others",
}
end

local i=g:split(",")

if#i~=3 then
return aj(" - use R,G,B or #hex")
end

local j={}

for k,l in i do
local m=e(l,{min=0,max=255,floor=true})

if not m.success then
return m
end

j[k]=m.value
end

return{
success=true,
value=Color3.fromRGB(j[1],j[2],j[3]),
color="others",
}end local h=function(


h)
if h==""then
return aj(" - player missing")
end

local i=ab.parts(h)

if#i==0 then
return aj(" - player missing")
end


for j,k in i do
if#ab(k)==0 then
if ab.hasOperators(k)then
return aj(" - no players match this")
end

if ab.isSelector(k)then
return aj(" - no players match this selector")
end

local l={}
for m,n in aa.Players:GetPlayers()do
table.insert(l,n.Name)
end

return aj(" - player not found",l)
end
end

return{success=true,value=h,color="valid"}end


local i={
"BasePart","Part","MeshPart","Model","Folder","Script","LocalScript",
"ModuleScript","Sound","Humanoid","Tool","ClickDetector",
"ProximityPrompt","TouchTransmitter","SpawnLocation","Seat","VehicleSeat",
}local j=function(

j)

local k=pcall(function()
local k=Instance.new(j)
k:Destroy()
end)

if k then
return{success=true,value=j,color="valid"}
end

return aj(" - invalid class name",i)end local k=function(


k)

local l=al(ad:getValue(tostring(game.PlaceId)))

if#l==0 then
return aj(" - no waypoints created")
end

local m=ak(l,k)

if m then
return{success=true,value=m,color="valid"}
end

return aj(" - invalid waypoint",l)end local l=function(


l)
local m={}

for n,o in aa.Teams:GetTeams()do
table.insert(m,o.Name)
end

if#m==0 then
return aj(" - there are no teams")
end

local n=ak(m,l)

if n then
return{success=true,value=n,color="valid"}
end

return aj(" - invalid team",m)end local m=function(


m)
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

return aj(" - invalid key",o)end local n=function(


n)
local o=ac.lookup[n:lower()]

if o then
return{success=true,value=o.name,color="valid"}
end

return aj(" - invalid command",ac.array)end local o=function(



o, p, q, r)
local s=al(o:getData())

if#s==0 then
return aj(q)
end

local t=ak(s,p)

if t then
return{success=true,value=t,color="valid"}
end

return aj(r,s)end local p=function(


p)
return o(ae,p," - no custom aliases"," - invalid alias")end local q=function(


q)
return o(af,ag.normalizeName(q)or q," - no plugins installed"," - invalid plugin")end


local r={
string=b,
text=b,
object=am,
boolean=d,
number=e,
vector3=f,
color3=g,
player=h,
waypoint=k,
className=j,
team=l,
keycode=m,
command=n,
alias=p,
plugin=q,
}

ai.validate=function(s, t, u)
local v=r[t.kind]

if not v then
return aj(` - missing parser {t.kind}`)
end

return v(u,t)end


return ai end a.dd=function()local ab=a.cache.dd if not ab then ab={c=aa()}a.cache.dd=ab end return ab.c end end do local aa=function()

local aa=a.c9()
local ab=a.cK()

local ac=a.cJ()
local ad=a.c5()

local ae=a.b6()
local af=a.dd()

local ag=ae.colorFromRGB
local ah=ae.escapeRichText


local ai="\\"

local aj="^"
local ak="inf"

local al="!"

local am=ae.lookupify({"`","'","\""})
local b=ae.lookupify({" ","\t","\n","\r"})
local c=ae.lookupify({",","|","&"})local d=function(

d)
return ac.lookup[d]end local e=function(


e, f, g)
local h=ad.args
return ag(e,h[f]or g or h.others)end local f=function(


f)
local g=f:gsub(".",function(g)
return b[g]and"_"or g
end)
return g end local g=function(


g, h)
if g.name then
return`'{f(g.name)}'`
end
return`#{h}`end local h=function(



h, i, j)
local k=j+1

while true do
local l=h:find(i,k,true)

if not l then
return nil
end

if h:sub(l-1,l-1)~="\\"then
return l
end

k=l+1
end end local i=function(




i, j)
local k={}
local l=j
local m=#i

while l<=m do
local n=i:sub(l,l)

if b[n]or n==ai then
break
end

table.insert(k,n)
l=l+1

if c[n]then
while l<=m and b[i:sub(l,l)]do
l=l+1
end
end
end

return table.concat(k),l-1 end local j=function(


j, k, l, m, n, o)
return{
kind=j,
value=k,
usedChar=o,
from=m,
to=n,
raw=l:sub(m,n),
}end local k=function(



k, l)
if l==""then
return"","",k
end

local m,n=k:lower():find(l:lower(),1,true)

if not m then
return"","",k
end

return k:sub(1,m-1),k:sub(m,n),k:sub(n+1)end local l=function(


l, m)
if m then
return m..l..m
end

if l:find("%s")then
return`"{l}"`
end

return l end local m=function(



m, n)
if n then
return ah(n)..m..ah(n)
end

return m end local n=function(


n, o, p, q)
return{
from=n,
to=o,
text=l(p,q),
}end local o=function(




o)
local p=o:split(aj)

if#p>2 then
return nil," - invalid loop"
end

local q
if p[1]:lower()==ak then
q=math.huge
else
q=tonumber(p[1])

if q==nil or q<1 or q~=math.floor(q)then
return nil," - invalid loop count"
end
end

local r=0
if p[2]~=nil then
r=tonumber(p[2])

if r==nil or r<0 then
return nil," - invalid loop delay"
end
end

return{count=q,delay=r}end


local p={}
p.__index=p
p.colorFromName=e
p.removeWhiteSpace=f



p.parse=function(q, r)
local s=q.cmdInput
local t={}
local u={}
local v=#r
local w={tokens={},start=1}
local x=1

table.insert(t,w)

while x<=v do
local y=r:sub(x,x)

if b[y]then
x=x+1
elseif y==ai then
w.stop=x
w={tokens={},start=x+1}
table.insert(t,w)
x=x+1
else
local z
local A=am[y]and h(r,y,x)

if A then
local B=(r:sub(x+1,A-1):gsub("\\"..y,y))
z=j("string",B,r,x,A,y)
x=A+1
else
local B,C=i(r,x)
z=j("identifier",B,r,x,C)
x=C+1
end

table.insert(w.tokens,z)
table.insert(u,z)
end
end

w.stop=v+1

for y,z in t do
local A=z.tokens[1]
local B=z.tokens[#z.tokens]
local C=if B then B.to+1 else z.start

z.lead=if A then r:sub(z.start,A.from-1)else""
z.spaces=r:sub(C,z.stop-1)
end

local y={}
for z,A in u do
table.insert(y,A.value)
end

local z=t[#t]

s.rawText=r
s.parsed=u
s.spacesAtEnd=z.spaces
s.noHighlightText=table.concat(y," ")..z.spaces

return t end



p.parseArg=function(q, r, s, t, u)
local v=s.value
local w=af:validate(r,v)
local x=w.success and#v>0

local y={success=x,text=v}
if x then
y.value=w.value
end
u.args[t]=y

if x then

local z=if w.display then m(w.display,s.usedChar)else ah(s.raw)
return{success=true,display=e(z,w.color or"valid")}
end

local z=af.getOptions(r,w)
local A

if#v>0 then
A=ab:searchAtArray(z,v)[1]
end

if A then
local B,C,D=k(A,v)
u.correction=n(s.from,s.to,A,s.usedChar)

local E=ah(B)..e(ah(C),"warn")..ah(D)
return{
success=false,
suggestion=true,
display=e(m(E,s.usedChar),"comment"),
}
end

return{
success=false,
display=e(ah(s.raw),w.color or"warn"),
message=w.message,
comment=w.comment,
}end



p.parsePending=function(q, r, s, t)
local u=af:validate(r,"")
local v=af.getOptions(r,u)

if#v==0 then
return nil
end

local w=v[1]


if not r.optional then
s.correction={from=t.stop,to=t.stop-1,text=l(w)}
else
s.hasGhost=true
end

return e(ah(w),"comment")end



p.highlightArgs=function(q, r, s, t, u, v, w)
local x=t.tokens
local y=s.args
local z=#x-1
local A=y[#y]
if A and A.variadic then
y=table.clone(y)
local B=z+(if u then 1 else 0)
while#y<B do
table.insert(y,A)
end
end
local B=#y

local C=1
local D

for E,F in y do
local G=x[E+1]

if G==nil then
if u then
local H=q:parsePending(F,r,t)
if H then
table.insert(v,H)
end
end
break
end

local H=q:parseArg(F,G,E,r)
C=E+1

if H.display then
table.insert(v,H.display)
end

if not H.success then
D={index=E,result=H}
break
end
end


for E=C+1,math.min(#x,B+1)do
table.insert(v,ah(x[E].raw))
end

if#x>B+1 then
local E=q.cmdInput.rawText:sub(x[B+2].from,x[#x].to)
table.insert(v,e(`<b>{ah(E)}</b>`,"warn"))

r.runError=" - extra arg"
r.comment={text=" - extra arg",color="warn"}
return
end

if D then
local E=D.result


r.runError=` - {g(y[D.index],D.index)} is invalid`

if E.message and not E.suggestion then
r.comment={text=E.message,color=if E.comment then"comment"else"warn"}
end
return
end


for E=z+1,B do
local F=y[E]

if not F.optional then
r.runError=` - {g(F,E)} is missing`
break
end
end

local E

if u then
E=z+1
elseif z>0 then
E=z
end

local F=E and y[E]


if F and w then
local G=if u then""else": "
r.comment={text=`{G}({q:highlightArgType(F)})`}
end end


p.highlightArgType=function(q, r)
local s=r.optional and e("?","symbol")or""
local t=`{e(r.kind,r.kind)}{s}`

if r.name then
return`{f(r.name)}: {t}`
end

return t end


p.highlightArgsType=function(q, r)
if#r==0 then return""end

local s={}

for t,u in r do
table.insert(s,q:highlightArgType(u))
end

return`({table.concat(s,", ")})`end


p.resetInput=function(q)
local r=q.cmdInput

r.highlightText=""
r.commandName=""
r.commandData=nil
r.isValidCommand=false
r.isAbreviated=false
r.bestMatch=nil
r.bestMatches={}
r.correctionText=nil
r.correction=nil
r.runError=nil
r.hasGhost=false
r.args={}
r.statements={}

q:setComment("")end



p.highlightStatement=function(q, r, s)
local t=q.cmdInput
local u=r.tokens
local v={
lead=r.lead,
text="",
trailing=r.spaces,
args={},
commandName="",
bestMatches={},
isValidCommand=false,
isAbreviated=false,
}

if#u==0 then
v.empty=true
return v
end

local w=u[1]
local x=#r.spaces>0
local y=w.value
local z=y
local A
local B
local C=false


if w.kind=="identifier"then
local D,E=y:match("^(.*%^)(.*)$")

if D then
A,B=o(D:sub(1,-2))
z=E
end

if z:sub(1,1)==al then
C=true
z=z:sub(2)
end
end

local D=y:sub(1,#y-#z)
local E=z:lower()
local F=d(E)

v.commandName=E
v.commandData=F
v.isValidCommand=F~=nil
v.isAbreviated=F~=nil and F.name~=E
v.loop=A

if B then
v.text=e(ah(y),"error")
v.runError=B
v.comment={text=B,color="error"}
return v
end

local G=""
if D~=""then
G=e(ah(D),"comment")
end

if not F then
local H=aa:search(E)
local I=H[1]

v.bestMatches=H
v.bestMatch=I

if x or#u>1 or not I then
local J=t.rawText:sub(w.from,u[#u].to)

v.text=e(ah(J),"error")
v.runError=" - invalid command"
v.comment={text=" - invalid command",color="error"}
return v
end


local J,K,L=k(I,z)

v.text=G..e(ah(J)..e(ah(K),"warn")..ah(L),"comment")
v.correction=n(w.from,w.to,D..I,w.usedChar)
v.correctionText=I
v.runError=" - invalid command"
return v
end

local H={G..e(ah(z),"valid")}


if s and#u==1 and not x and#F.aliases>1 then
local I=table.clone(F.aliases)
local J=table.find(I,E)

if J then
table.remove(I,J)
end

v.comment={text=`: [{table.concat(I,", ")}]`,color="comment"}
end

if C and#u==1 then

v.repeatLast=true

if#F.args>0 and aa:getLastArgs(F.name)==nil then
v.runError=" - no previous arguments"
v.comment={text=" - no previous arguments",color="error"}
end
else
q:highlightArgs(v,F,r,x,H,s)
end

v.text=table.concat(H," ")
return v end




p.highlight=function(q, r)
local s=q.cmdInput
q:resetInput()

local t=#r
local u={}

for v,w in r do
u[v]=q:highlightStatement(w,v==t)
end

local v=u[t]

s.statements=u
s.commandName=v.commandName
s.commandData=v.commandData
s.isValidCommand=v.isValidCommand
s.isAbreviated=v.isAbreviated
s.bestMatch=v.bestMatch
s.bestMatches=v.bestMatches
s.args=v.args


local w

for x,y in u do

if y.empty and t>1 then
y.runError=" - command missing"
end

if y.runError and s.runError==nil then
s.runError=y.runError
end

if y.correction and s.correction==nil then
s.correction=y.correction
end

if y.hasGhost then
s.hasGhost=true
end

if y.comment and w==nil then
w=y.comment
end
end

if w then
q:setComment(w.text,w.color)
end

local x={}

for y,z in u do

local A=if z.correction or z.hasGhost then""else z.trailing
local B=z.lead..z.text..A

if y<t then
B=B..e(ah(ai),"symbol")
end

table.insert(x,B)
end

local y=table.concat(x)
s.highlightText=y

return y end


p.setComment=function(q, ...)
return q.setCommentCallback(...)end


p.new=function(q, r)
return setmetatable({
cmdInput=q,
setCommentCallback=r
},p)end


return p end a.de=function()local ab=a.cache.de if not ab then ab={c=aa()}a.cache.de=ab end return ab.c end end do local aa=function()






local aa=a.c9()
local ab=a.de()
local ac=a.W()
local ad=a.c8()
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

local al,am=pcall(function()
aa:run(ag,ac.new(ah))
end)

if not al then
ad:remove(ak)
ae:error(`loop of '{ag}' stopped: {am}`)
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
local al=ah(aj)

if al then
return false,al
end

if ak then

return false,(ak:gsub("^%s*%-%s*",""))
end

for am,b in aj do
local c,d=pcall(af.runStatement,b)

if not c then
return false,tostring(d)
end
end

return true end


return af end a.df=function()local ab=a.cache.df if not ab then ab={c=aa()}a.cache.df=ab end return ab.c end end do local aa=function()








local aa=a.dc()
local ab=a.r()
local ac=a.df()
local ad=a.c9()
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
local al=ai(ak or"")

if al==""then
al=aj.default
end

if al:lower()==af then
return af
end

if aj.kind=="Number"and tonumber(al)==nil then
return nil,`{aj.label} must be a number or any`
end

return al end




ag.add=function(ak, al, am, b)
local c=ah[ak]
if not c then
return false,"invalid event"
end

local d=ai(al)
local e,f=ac.checkText(d)

if not e then
return false,f
end

if type(am)~="number"or am<0 then
return false,"the delay must be 0 or more"
end

local g={}

for h,i in c.conditions do
local j,k=aj(i,b and b[h])

if not j then
return false,k
end

g[h]=j
end

local h=ab.object[ak]
if type(h)~="table"then
h={}
ab.object[ak]=h
end

table.insert(h,{command=d,delay=am,conditions=g})
ab:save()

return true end



ag.remove=function(ak, al)
local am=ab.object[ak]

if type(am)~="table"or am[al]==nil then
return nil
end

local b=table.remove(am,al)
ab:save()

return b end




ag.restore=function(ak, al, am)
if not ah[ak]or type(am)~="table"then
return false
end

local b=ab.object[ak]
if type(b)~="table"then
b={}
ab.object[ak]=b
end

table.insert(b,math.clamp(al,1,#b+1),am)
ab:save()

return true end



ag.setDelay=function(ak, al, am)
local b=ab.object[ak]

if type(b)~="table"or type(b[al])~="table"then
return false
end

if type(am)~="number"or am<0 then
return false
end

b[al].delay=am
ab:save()

return true end local ak=function(



ak, al)
local am,b=pcall(ae,ak)

if not am then
return false
end

for c,d in b do
if d.Name==al then
return true
end
end

return false end local al=function(



al, am, b)
if am:lower()==af then
return true
end

if al.kind=="Player"then
return ak(am,tostring(b))
end

if al.kind=="String"then
return tostring(b):lower():find(am:lower(),1,true)~=nil
end

if al.kind=="Number"then
local c,d=tonumber(am),tonumber(b)
return c~=nil and d~=nil and d<=c
end

return false end local am=function(



am, b, c)
local d=b.conditions or{}

for e,f in am.conditions do
local g=tostring(d[e]or f.default)

if not al(f,g,c[e])then
return false
end
end

return true end local b=function(




b)
if b:match("^[%w_%-%.]+$")then
return b
end

return'"'..(b:gsub('"','\\"'))..'"'end local c=function(



c, d)
return(c:gsub("%$(%d+)",function(e)
local f=d[tonumber(e)]

if f==nil then
return nil
end

return b(tostring(f))
end))end local d=function(




d, e)
local f=d.delay or 0

if f>0 then
task.wait(f)
end

local g=c(d.command,e)
local h,i=ac.runText(g)

if not h then
ad:notify("Event Bind",`'{g}' did not run: {i}`)
end end




ag.fire=function(e, ...)
local f=ah[e]
local g=ab.object[e]

if not f or type(g)~="table"then
return
end

local h={...}

for i,j in table.clone(g)do
if type(j)=="table"and am(f,j,h)then
task.spawn(d,j,h)
end
end end


return ag end a.dg=function()local ab=a.cache.dg if not ab then ab={c=aa()}a.cache.dg=ab end return ab.c end end do local aa=function()








local aa=a.f()
local ab=a.aJ()
local ac=a.dg()

local ad=aa.Players
local ae=aa.TextChatService

local af={}

local ag=false
local ah=false


local ai={}

local aj={}local ak=function(


ak, al, am, b)
local c=ab:Connect(am,b)

local d=ak[al]or{}
ak[al]=d
table.insert(d,c)end local al=function(


al, am)
local b=al[am]
al[am]=nil

for c,d in b or{}do
ab:disconnect(d)
end end local am=function(



am, b)
al(aj,am)

task.spawn(function()
local c=b:WaitForChild("Humanoid",10)


if not c or not c:IsA("Humanoid")or am.Character~=b then
return
end

local d=c.Health

ak(aj,am,c.HealthChanged,function(e)
if e<d then
ac.fire("OnDamage",am.Name,e)
end

d=e
end)

ak(aj,am,c.Died,function()
ac.fire("OnDied",am.Name)


local e=c:FindFirstChild("creator")
local f=if e and e:IsA("ObjectValue")then e.Value else nil

if f and f:IsA("Player")then
ac.fire("OnKilled",am.Name,f.Name)
end
end)
end)end local b=function(




b)
ak(ai,b,b.CharacterAdded,function(c)
ac.fire("OnSpawn",b.Name)
am(b,c)
end)

if ah then
ak(ai,b,b.Chatted,function(c)
ac.fire("OnChatted",b.Name,c)
end)
end

if b.Character then
am(b,b.Character)
end end local c=function(


c)
local d=c.TextSource

if not d or c.Status==Enum.TextChatMessageStatus.InvalidTextChannelPermissions then
return
end

local e=ad:GetPlayerByUserId(d.UserId)

if e then
ac.fire("OnChatted",e.Name,c.Text)
end end local d=function(


d)
ac.fire("OnLeave",d.Name)

al(ai,d)
al(aj,d)end



af.start=function()
if ag then
return
end

ag=true
ah=ae.ChatVersion==Enum.ChatVersion.LegacyChatService

ab:Connect(ad.PlayerAdded,function(e)
ac.fire("OnJoin",e.Name)
b(e)
end)

ab:Connect(ad.PlayerRemoving,d)

if not ah then
ab:Connect(ae.MessageReceived,c)
end


for e,f in ad:GetPlayers()do
b(f)
end

ac.fire("OnExecute")end


return af end a.dh=function()local ab=a.cache.dh if not ab then ab={c=aa()}a.cache.dh=ab end return ab.c end end do local aa=function()



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
}end a.di=function()local ab=a.cache.di if not ab then ab={c=aa()}a.cache.di=ab end return ab.c end end do local aa=function()


















local aa=a.da()
local ab=a.aE()

return{

keys={
keepMenuOpen="interface.keepMenuOpen",
keepIY=aa.settingKey,
clearOnEnter="clearOnEnter",
theme="selectedTheme",
legacyIcons=ab.ui.legacyIconsKey,
transparentMinimized="interface.transparentWhenMinimized",
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
iconsTitle="#icons",
legacyIcons="Use legacy icons",
legacyIcon="lucide-rotate-ccw-clock",
legacyTitle="Legacy Icons",
legacyNoCustomAsset="your exploit does not support getcustomasset, so the legacy icons can't be shown",
},

interface={
title="#interface",
keepMenuOpen="Keep Menu Open",
uiScale="UI Scale",
transparent="Transparent When Minimized",
hide="Hide IY",
icons={
keepMenuOpen="lucide-pin",
uiScale="lucide-scaling",
transparent="lucide-blend",
hide="lucide-eye-off",
},
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
resetIcon="lucide-refresh-cw",
alwaysWorks="%s also works as the %s",
},
commands={
title="#command settings",
reset="Reset command keys to defaults",
resetIcon="lucide-refresh-cw",
},
importExport={
title="#import / export",
exportRow="Export",
exportIcon="lucide-clipboard-copy",
importRow="Import",
importIcon="lucide-arrow-down-up",
hint="paste a copied text in the box to import it. Import asks first, and replaces only the parts the text holds",
placeholder="paste the copied text here",
copied="settings copied to the clipboard. The copy button copies them again",
copyFailed="your exploit can't copy: the text is in the box, copy it from there",
empty="paste a copied text first",
notAnExport="that text is not an export of IY",
confirmTitle="Import",
confirmMessage="replace %s with the ones in the text? The current ones are lost",
confirmButton="Import",
cancel="Cancel",
confirmTime=15,
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
{kind="switch",label="Keep Interface",icon="lucide-refresh-cw",setting="keepIY"},
{kind="switch",label="Clear On Enter",icon="lucide-eraser",setting="clearOnEnter"},
},
},
{
title="#editors",
options={
{kind="button",label="Interface",icon="lucide-app-window",action="interface"},
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
}end a.dj=function()local ab=a.cache.dj if not ab then ab={c=aa()}a.cache.dj=ab end return ab.c end end do local aa=function()













local aa=a.a()
local ab=a.cM()
local ac=a.n()
local ad=a.s()
local ae=a.k()

local af=a.di()
local ag=a.dj().pages.background

local ah={
frame=nil,
topBar=nil,
asset=nil,
}


local ai=0



local aj local ak=function(

ak)
return ak:match("^%s*(.-)%s*$")or""end local al=function(



al)
local am=al:match("^[^?#]*")or al
local b=(am:match("%.(%w+)$")or""):lower()

return af.extensions[b]or af.defaultExtension end local am=function()



local am=ac:getValue(af.keys.opacity)

if type(am)~="number"then
return af.defaultOpacity
end

return math.clamp(am,0,1)end local b=function(



b)
local c=ad:getEntry(b)

if type(c)=="string"and ae:exist(c)then
return c
end

return nil end local c=function(




c)
local d=ac:getValue(af.keys.file)

if d==nil then
return nil
end

ac:setValue(af.keys.file,nil)
ac:save()

if type(d)~="string"or not ae:exist(d)then
return nil
end

ad:setEntry(c,d)
ad:save()

return d end local d=function(




d, e)
local f=ab.fetchUrl(d)

if not e()then
return nil,nil,nil
end

if f==nil then
return nil,nil,ag.downloadFailed
end


ai=ai+1
local g=`{af.folder}/image-{os.time()}-{ai}.{al(d)}`

ae:makeFolder(af.folder)
ae:writeFile(g,f)

local h=ae:getCustomAsset(g)

if h==nil then

ae:delete(g)
return nil,nil,ag.loadFailed
end

return g,h,nil end



ah.getUrl=function(e)
local f=ac:getValue(af.keys.url)

if type(f)=="string"and f~=""then
return f
end

return nil end


ah.getOpacity=function(e)
return am()end



ah.checkUrl=function(e, f)
local g=ak(f)

if g==""then
return ag.empty
end

if not g:match("^https?://")then
return ag.badUrl
end

if aa.getcustomasset==nil then
return ag.noCustomAsset
end

return nil end



ah.paint=function(e)
local f=e.frame
if f==nil then return end

local g=e.asset

f.Image=g or""
f.ImageTransparency=1-am()

if e.topBar then
e.topBar.BackgroundTransparency=if g~=nil then 1 else 0
end end



ah.attach=function(e, f, g)
if e.frame~=nil then return end


e.frame=g or f
e.topBar=f:FindFirstChild("TopBar")

local h=e:getUrl()

if h~=nil and aa.getcustomasset~=nil then
local i=b(h)or c(h)

if i~=nil then
e.asset=ae:getCustomAsset(i)
end
end

e:paint()end





ah.setFromUrl=function(e, f, g, h)
local i=ak(f)
local j=b(i)
local k=h or function()return true end

local l=j
local m

if j~=nil and not g then
m=ae:getCustomAsset(j)
end

if m==nil then
local n,o,p=d(i,k)

if n==nil or o==nil then
return false,p
end

l=n
m=o

if j~=nil and j~=n then
ae:delete(j)
end
end

ad:setEntry(i,l)
ad:save()

ac:setValue(af.keys.url,i)
ac:save()

e.asset=m
e:paint()

return true end




ah.clear=function(e)

e:cancelDownload()

local f=e:getUrl()
local g=true

if f~=nil then
local h=ad:getEntry(f)

if type(h)=="string"then
g=ae:delete(h)
end

ad:setEntry(f,nil)
ad:save()
end

ac:setValue(af.keys.url,nil)
ac:save()

e.asset=nil
e:paint()

return g end



ah.setOpacity=function(e, f)
local g=math.round(math.clamp(f,0,1)*100)/100

ac:setValue(af.keys.opacity,g)
ac:save()

e:paint()end



ah.isDownloading=function(e, f)
if aj==nil then return false end
if f==nil then return true end

return aj.url==ak(f)end




ah.cancelDownload=function(e)
local f=aj
if f==nil then return end

aj=nil

if f.thread~=nil then
pcall(task.cancel,f.thread)
end end





ah.startDownload=function(e, f, g, h)



e:cancelDownload()

local i={url=ak(f),thread=nil}
aj=i

task.delay(af.slowSeconds,function()
if aj==i and h.onSlow then
h.onSlow()
end
end)

i.thread=task.spawn(function()

local j,k,l=pcall(function()
return e:setFromUrl(i.url,g,function()
return aj==i
end)
end)

if not j then
k,l=false,ag.downloadFailed
end


if aj~=i then return end

aj=nil

if h.onDone then
h.onDone(k,l)
end
end)end


return ah end a.dk=function()local ab=a.cache.dk if not ab then ab={c=aa()}a.cache.dk=ab end return ab.c end end do local aa=function()

return{NEW_YEAR=
"🎆",VALENTINE_DAYS=
"💝",CLOVER=
"☘️",HALLOWEEN=
"🎃",CHRISTMAS=
"🎄",EASTER=
"🥚",
}end a.dl=function()local ab=a.cache.dl if not ab then ab={c=aa()}a.cache.dl=ab end return ab.c end end do local aa=function()



local aa={}

local ab=a.aE()
local ac=a.dl()

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


return aa end a.dm=function()local ab=a.cache.dm if not ab then ab={c=aa()}a.cache.dm=ab end return ab.c end end do local aa=function()









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


local al=ab.y.scale*ac.height+ab.y.offset
local am=al+ab.height



local b=(math.max(al,0)+math.min(am,ac.height))/2
local c=b>ac.height/2

local d,e,f
if c then

if am>=ac.height then
d={scale=1,offset=0}
else
d={scale=ab.y.scale,offset=ab.y.offset+ab.height}
end
e=1
f=math.min(am,ac.height)
else
if al<0 then
d={scale=0,offset=0}
else
d={scale=ab.y.scale,offset=ab.y.offset}
end
e=0
f=ac.height-math.max(al,0)
end

return{
x=ak,
y=d,
anchorX=if aj then 0 else 1,
anchorY=e,
room=math.max(f,0),
}end


return aa end a.dn=function()local ab=a.cache.dn if not ab then ab={c=aa()}a.cache.dn=ab end return ab.c end end do local aa=function()






local aa=a.cY()

local ab={}

ab.create=function(ac)
local ad=aa.new("CanvasGroup","MainFrame",{
Active=true,
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Background"
},
aa.new("ImageLabel","Background",{
BackgroundTransparency=1,
Image="",
ScaleType=Enum.ScaleType.Crop,
Size=UDim2.fromScale(1,1),
}),
aa.new("Frame","TopBar",{
Size=UDim2.fromOffset(250,20),
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Background"
}
})
})

local ae=ad.Background
local af=ad.TopBar

local ag=aa.new("TextLabel","Title",af,{
Size=UDim2.fromScale(1,1),
BackgroundTransparency=1,
TextSize=16,
ThemeTag={
TextColor3="Colors.Text.Default",
Font="Font.Normal"
}
})

local ah=aa.new("ImageButton",af,{
Name="SettingsButton",
BackgroundTransparency=1,
Position=UDim2.new(1,-2,0.5,0),
AnchorPoint=Vector2.new(1,0.5),
Size=UDim2.fromOffset(19,19),
ThemeTag={
ImageColor3="Colors.Icons"
}
})

local ai=aa.new("ImageButton",af,{
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
background=ae,
topBar=af,
titleLabel=ag,
buttons={
settings=ah,
reference=ai
}
}end


return ab end a.dp=function()local ab=a.cache.dp if not ab then ab={c=aa()}a.cache.dp=ab end return ab.c end end do local aa=function()

local aa=a.cY()

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
end end a.dq=function()local ab=a.cache.dq if not ab then ab={c=aa()}a.cache.dq=ab end return ab.c end end do local aa=function()



local aa=a.aJ()
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


return af end a.dr=function()local ab=a.cache.dr if not ab then ab={c=aa()}a.cache.dr=ab end return ab.c end end do local aa=function()
local aa=a.aJ()
local ab=a.cY()
local ac=a.af()
local ad=a.cX()

local ae=a.dq()
local af=a.c3()

local ag=a.v()

local ah=a.dr()

local ai={}
ai.__index=ai

ai.awake=function(aj)
local ak=ac:getMouse()

local al=aj.scrollThumbFrame
local am=aj.scrollThumb
local b=aj.scrollBar

local c=false
local d=false
local e local f=function(

f, g)local h=function()

if c then return end
if not aj:canScroll(g)then return end

c=true

aj:scrollToDirection(g)

ah.onReleaseEvent(function()
c=false
end)

task.wait(0.4)

while aj:canScroll(g)and c do
aj:scrollToDirection(g)
task.wait(6.666666666666666E-2)
end end


aa:Connect(f.MouseButton1Down,h)end




f(aj.upButton,"up")
f(aj.downButton,"down")local g=function(



g)
if aj.locked then return end
aj:scrollTo(aj.index+g*aj.wheelIncrement)end


for h,i in{b,aj.container}do
aa:Connect(i.MouseWheelForward,function()
g(-1)
end)

aa:Connect(i.MouseWheelBackward,function()
g(1)
end)
end

aa:Connect(b.InputBegan,function(h)
if not ah.isPressingInput(h)then return end
if aj:isScrollBarDisabled()then return end

local i=not ac:isMouseInGuiObject(am)
local j=aj.isHorizontal and"X"or"Y"

local k
d=true

ad:updateObjectProperties(am,{
BackgroundColor3="Colors.Primary"
})

local l=ak[j]-am.AbsolutePosition[j]
local m local n=function()


if m then m:Disconnect()end end


ah.onReleaseEvent(function()
n()
d=false

ad:updateObjectProperties(am,{
BackgroundColor3="Colors.OnPrimary"
})
end)

if i then local o=function()

if aj.locked then return end

local o=(ak[j]>=am.AbsolutePosition[j]+am.AbsoluteSize[j])and 1 or 0
local p=aj.visibleSpace-1

if o==0 and(
ak[j]<am.AbsolutePosition[j]
)then
aj:scrollTo(aj.index-p)
elseif o==1 and(
ak[j]>=am.AbsolutePosition[j]+am.AbsoluteSize[j]
)then
aj:scrollTo(aj.index+p)
end end


while d do
o()
task.wait(0.25)
end
return
end

m=ah.onMouseEvent(function(o)
if not d then return end
if aj.locked then return end

local p=al.AbsoluteSize[j]-am.AbsoluteSize[j]
local q=ak[j]-al.AbsolutePosition[j]-l

if q>p then
q=p
elseif q<0 then
q=0
end

if k~=q then
k=q
aj:scrollTo(math.floor(0.5+q/p*(aj.totalSpace-aj.visibleSpace)))
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
local al=aj.upButton

ae(4,0.55,ak.Name).Parent=ak
ae(4,0.55,al.Name).Parent=al end


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


ai.scrollTo=function(aj, ak, al)
local am=math.max(0,aj.totalSpace-aj.visibleSpace)

aj.index=math.clamp(ak,0,am)
aj:update()

if not al then
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
local al=aj.index
if ak>=al and ak<(al+aj.visibleSpace)then
return true
end
return false end


ai.setScrollPercent=function(aj, ak)
local al=aj.totalSpace-aj.visibleSpace
aj:scrollTo(math.floor(ak*al))end


ai.update=function(aj)
aj:drawThumb()end


ai.setScrollBarThickness=function(aj, ak)
local al=aj.scrollThumbFrame
local am=aj.downButton
local b=aj.container
local c=aj.scrollBar
local d=aj.upButton

aj.barThickness=ak

if b then
b.Size=UDim2.new(
1,
aj.isHorizontal and 0 or-ak,
1,
aj.isHorizontal and-ak or 0
)
end

if c then
c.Size=aj.isHorizontal
and UDim2.new(1,0,0,ak)
or UDim2.new(0,ak,1,0)
c.Position=aj.isHorizontal
and UDim2.new(0,0,1,-ak)
or UDim2.new(1,-ak,0,0)
end

if al then
al.Size=aj.isHorizontal
and UDim2.new(1,-(ak*2),0,ak)
or UDim2.new(0,ak,1,-(ak*2))
end

if am then
am.Size=UDim2.fromOffset(ak,ak)
am.Position=aj.isHorizontal
and UDim2.new(1,-ak,0,0)
or UDim2.new(0,0,1,-ak)
end

if d then
d.Size=UDim2.fromOffset(ak,ak)
d.Position=UDim2.fromOffset(0,0)
end end


ai.updateArrowTransparency=function(aj, ak, al)
if not ak:FindFirstChild("Arrow")then return end

for am,b in ak.Arrow:GetChildren()do
if not b:IsA("GuiObject")then continue end
b.Transparency=al and 0.6 or 0
end end


ai.drawThumb=function(aj)
local ak=aj.scrollThumb
local al=aj.scrollThumbFrame

local am=aj:canScrollUp()
local b=aj:canScrollDown()

aj:updateArrowTransparency(aj.upButton,not am)
aj:updateArrowTransparency(aj.downButton,not b)

if not ak or not al then return end

if not am and not b then
ak.Visible=false
return
end

ak.Visible=true

local c=aj:getScrollPercent()
local d=af:getScale()
local e=aj.barThickness

if aj.isHorizontal then
local f=al.AbsoluteSize.X/d
local g=math.max(e,(aj.visibleSpace/aj.totalSpace)*f)
ak.Size=UDim2.new(0,g,1,-2)
ak.Position=UDim2.new(0,c*(f-g),0.5,0)
else
local f=al.AbsoluteSize.Y/d
local g=math.max(e,(aj.visibleSpace/aj.totalSpace)*f)
ak.Size=UDim2.new(1,-2,0,g)
ak.Position=UDim2.new(0.5,0,0,c*(f-g))
end end


ai.addMarker=function(aj, ak, al)
aj.markers[ak]=al or Color3.new(1,1,0)
aj:updateMarkers()end


ai.removeMarker=function(aj, ak)
aj.markers[ak]=nil
aj:updateMarkers()end


ai.updateMarkers=function(aj)
local ak=aj.markerFrame
if not ak then return end

for al,am in pairs(ak:GetChildren())do
am:Destroy()
end

for al,am in pairs(aj.markers)do
if al>=aj.totalSpace then continue end

local b=Instance.new("Frame")
b.BackgroundColor3=am
b.BorderSizePixel=0
b.BackgroundTransparency=0
b.Parent=ak

local c=al/aj.totalSpace
if aj.isHorizontal then
b.Position=UDim2.new(c,0,1,-4)
b.Size=UDim2.new(0,2,0,4)
else
b.Position=UDim2.new(1,-4,c,0)
b.Size=UDim2.new(0,4,0,2)
end

b.Name="Marker_"..tostring(al)
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


return ai end a.ds=function()local ab=a.cache.ds if not ab then ab={c=aa()}a.cache.ds=ab end return ab.c end end do local aa=function()
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


return aa end a.dt=function()local ab=a.cache.dt if not ab then ab={c=aa()}a.cache.dt=ab end return ab.c end end do local aa=function()
local aa=a.aJ()
local ab=a.f()
local ac=a.af()
local ad=a.cY()
local ae=a.dt()

local af=a.de()
local ag=a.df()

local ah=a.dr()
local ai=a.c2()
local aj=a.cJ()

local ak=a.v()
local al=a.d()
local am=a.b6()
local b=a.c3()

local c=a.n()
local d=a.c5().commands
local e=a.b4()

local f=ab.UserInputService
local g=ab.RunService
local h=ab.TweenService

local i=am.richFontSize
local j=am.colorFromRGB

local k={}
k.__index=k

local l=0.15
local m=2.50
local n=6
local o=24
local p=18
local q=3
local r=5
local s=4
local t=0.2

local u=UDim2.new(1,-2*r,0,p)

local v=UDim2.new(1,-(r+s+o+r),0,p)
local w=50 local x=function(

x)
return aj.lookup[x]end local y=function(


y)
return math[(y<0)and"ceil"or"floor"](y)end local z=function(


z)
z=z:gsub("[\r\n]+$","")
z=z:gsub("[\r\n]+"," ")
return z end


k.refresh=function(A, B, C)
A:syncCommandsData()
local D=A.parser:parse(B)
A.parser:highlight(D)

A:updateSearchBoxHighlight()

if C then
A:scheduleSearchedCommand()
else
A.scrollToken=A.scrollToken+1
A:updateSearchedCommand()
end end




k.scheduleSearchedCommand=function(A)
A.scrollToken=A.scrollToken+1
local B=A.scrollToken

task.delay(l,function()
if B~=A.scrollToken then return end
A:updateSearchedCommand()
end)end


k.applyCorrection=function(A)
local B=A.commandInput
local C=B.correction
local D=B.rawText

local E=D:sub(1,C.from-1)..C.text..D:sub(C.to+1)

if c:getValue("spaceAfterCorrection")then
E=E.." "
end

A:writeText(E)end





k.ensureFocus=function(A)
local B=A.searchBox
if not B then return end

A.focusRequest=(A.focusRequest or 0)+1
local C=A.focusRequest

task.spawn(function()
for D=1,n do
if C~=A.focusRequest or not A.isEnabled then return end
if B:IsFocused()then return end

if B.Parent~=nil then
B:CaptureFocus()
end

g.Heartbeat:Wait()
end
end)end



k.sendText=function(A)
local B=z(A.searchBox.Text)
if not B:match("%S")then return end

A:refresh(B)
A:sendInputCommand()end





k.updateSendButton=function(A)
local B=A.sendButton
local C=A.searchBox
if not(B and C)then return end

local D=not C:IsFocused()and C.Text:match("%S")~=nil
if D==A.sendShown then return end

A.sendShown=D
B.Visible=D
A:tweenSearchBar(if D then v else u)end



k.tweenSearchBar=function(A, B)
local C=A.searchBoxHolder
if not C then return end

if A.barTween then
A.barTween:Cancel()
A.barTween=nil
end

if C.Size==B then return end


if not A.isEnabled then
C.Size=B
return
end

local D=h:Create(C,TweenInfo.new(t,Enum.EasingStyle.Quart,Enum.EasingDirection.Out),{
Size=B,
})

A.barTween=D
D:Play()end


k.captureFocus=function(A)
local B=A.searchBox
if not B then return end






if B.Parent~=nil then
B:CaptureFocus()
end end





k.setInteractive=function(A, B)
B=B==true
if A.interactive==B then return end
A.interactive=B

A.scrollBar:setLocked(not B)


if not B then
local C=A.searchBox

if C and C:IsFocused()then
C:ReleaseFocus()
end
end end


k.isInteractive=function(A)
return A.interactive end


k.awake=function(A)
local B=A.commandInput
local C=A.searchBox
local D=A.searchBoxHolder
local E=A.inputMarker

local F=D.Placeholder

aa:Connect(aj.changed,function()
if A:syncCommandsData()then
A:refresh(z(C.Text))
end
end)

local G=C:GetPropertyChangedSignal("Text")

local H=0 local I=function()


if(tick()-H)>0.5 then
E.Visible=not E.Visible
H=tick()
end end local J=function()



if C:IsFocused()then
C:ReleaseFocus()
end end local K=function()



if B.correction then
A:applyCorrection()
A:ensureFocus()
return true
end


A:sendInputCommand()
return false end local L=function()



local L=not C:IsFocused()and#C.Text==0
F.Visible=L

A:updateSendButton()end


A.commandClickedSignal:Connect(function(M)
if not A.interactive then return end

A:writeText(M.aliases[1])
A:ensureFocus()
end)

aa:Connect(D.Activated,function()
if not A.interactive then return end

A:ensureFocus()
end)

aa:Connect(A.sendButton.Activated,function()
if not A.interactive then return end


if C:IsFocused()then
C:ReleaseFocus()
end

A:sendText()
end)

aa:Connect(C.Focused,function()
if A.onInteraction then A.onInteraction()end

L()
A.markerConnection=aa:Connect(g.Stepped,I)

if#C.Text==0 then
A:setComment("")
end
end)

aa:Connect(C.FocusLost,function(M)
L()
E.Visible=true
aa:disconnect(A.markerConnection)

if M then
A:refresh(z(C.Text))
K()
end
end)

aa:Connect(G,function()
if A.onInteraction then A.onInteraction()end

local M=C.Text


if M:find("\t")then
C.Text=(M:gsub("\t",""))
return
end


if A.historyIndex and M~=A.historyText then
A.historyIndex=nil
end

local N=M:sub(-1)=="\n"or M:sub(-1)=="\r"

if M:find("[\r\n]")then
M=z(M)
C.Text=M

if N then
A:refresh(M)

if not K()then
J()
end
return
end
end


local O=#M<#A.lastText
A.lastText=M

L()
A:refresh(M,O)
end)


aa:Connect(f.InputBegan,function(M)
if not C:IsFocused()then return end

if M.KeyCode==Enum.KeyCode.Up then
A:browseHistory(-1)
elseif M.KeyCode==Enum.KeyCode.Down then
A:browseHistory(1)
elseif M.KeyCode==Enum.KeyCode.Tab and A.commandInput.correction then
A:applyCorrection()
A:ensureFocus()
end
end)end


local A=50


k.sendInputCommand=function(B)
local C=B.commandInput

if C.runError then
B:setComment(C.runError,"error")
return
end

local D=C.statements

for E,F in D do
if not F.commandData then return end
end


if B.onCommandSent then
B.onCommandSent()
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

if c:getValue("clearOnEnter")then
B:writeText("")
end

B.historyIndex=nil

if F then
B:setComment(`failed - {F}`,"error")
al:error(`failed to run command '{G}': {F}`)
else
B:addToHistory(E)
end end



k.runStatement=function(B, C)
ag.runStatement(C)end


k.addToHistory=function(B, C)
local D=(C or""):match("^(.-)%s*$")

if D==""then return end

local E=B.history

if E[#E]==D then return end

table.insert(E,D)

if#E>A then
table.remove(E,1)
end end



k.browseHistory=function(B, C)
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
B:setSearchText("")
return
end

B.historyIndex=E
B:setSearchText(D[E])end


k.setSearchText=function(B, C)
B.historyText=C
B:writeText(C)end




k.writeText=function(B, C)
B.searchBox.Text=C
B.lastText=C
B:refresh(C)end


k.create=function(B)
B.searchBoxHolder=ad.new("ImageButton",{
Size=u,
Position=UDim2.new(0,r,0,0),
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
TextSize=B.configs.textSize,
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

B.inputMarker=ad.new("Frame","Marker",D,{
Size=UDim2.new(0,1.5,1,-3),
Position=UDim2.new(1,0.2,0.5,0),
AnchorPoint=Vector2.new(0,0.5),
BorderSizePixel=0,
Visible=false,
ThemeTag={BackgroundColor3="Colors.Primary"}
})

B.inputComment=ad.new("TextLabel","Comment",D,{
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

B.commandInfo=ad.new("TextLabel","Info",{
Size=UDim2.new(1,-25,0,0),
Position=UDim2.new(0,10,0,0),
AutomaticSize=Enum.AutomaticSize.Y,
TextYAlignment=Enum.TextYAlignment.Center,
TextXAlignment=Enum.TextXAlignment.Left,
Font=B.configs.textFont,
TextSize=B.configs.textSize-5,
Visible=false,
ad.new("UICorner",{
CornerRadius=UDim.new(0,4)
}),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
TextColor3="Colors.Text.Default"
}
})

B.searchBox=ad.new("TextBox","SearchBox",{
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



B.searchBox.ZIndex=0
pcall(function()
B.searchBox.Interactable=false
end)

B.commandsFolder=ad.new("Folder","Commands")

B:createSendButton()end



k.createSendButton=function(B)


local C=ad.new("TextButton","Send",{
AnchorPoint=Vector2.new(1,1),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-r,0,0),
Size=UDim2.new(0,o,0,p),
Text="",
Visible=false,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

ad.new("UICorner",{
CornerRadius=UDim.new(0,4),
}),
})

local D=ad.new("ImageLabel","Icon",C,{
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundTransparency=1,
Position=UDim2.fromScale(0.5,0.5),
ScaleType=Enum.ScaleType.Fit,
Size=UDim2.new(1,-2*q,1,-2*q),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ai:loadImage(D,"lucide-send")

B.sendIcon=D
B.sendButton=C
B.sendShown=false end


k.createCommandsData=function(B)
local C={}
local D={}
for E,F in aj.original do
local G=F.commandData or ae.new(F)
F.commandData=G
G.position=E-1
C[F]=true
table.insert(D,G)
end
for E,F in B.renderedCommands or{}do
if not C[F]then
local G=F.commandData
if G and G.element then G.element:Destroy()end
F.commandData=nil
end
end
B.commandsData=D
B.renderedCommands=table.clone(aj.original)
B.commandsRevision=aj.revision or 0
B.hoveredCommand=nil
B:clearHoverDescription()end


k.syncCommandsData=function(B)
if B.commandsRevision==(aj.revision or 0)then return false end
B:createCommandsData()
B.scrollBar:setTotalSpace(B:calculateTotalSpace())
if B.isEnabled then B:updateElements()end
return true end


k.updateSearchBoxHighlight=function(B)
local C=B.commandInput.highlightText
local D=B.searchBoxHolder
local E=D.Input
local F=b:getScale()

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




k.updateSearchBoxPosition=function(B)
local C=B.searchBox
local D=B.searchBoxHolder
local E=B.screenGui
local F=B.scrollHolder and B.scrollHolder.Parent

if not B.isEnabled or not(C and D and E and F)then return end

local G=E.AbsoluteSize
local H=math.max(b:getScale(),0.01)



local I=F.Position
local J=I.X.Scale*G.X+I.X.Offset*H
local K=I.Y.Scale*G.Y+I.Y.Offset*H



local L=J+(D.AbsolutePosition.X-F.AbsolutePosition.X)
local M=K+(D.AbsolutePosition.Y-F.AbsolutePosition.Y)


local N=D.AbsoluteSize
local O=math.max(math.min(N.X,G.X),1)
local P=math.max(math.min(N.Y,G.Y),1)

local Q=B:calculateLabelSize()*m*H

local R=math.clamp(L,0,math.max(G.X-O,0))
local S=math.clamp(M+P+Q,0,math.max(G.Y-P,0))


local T=UDim2.fromOffset(R/H,S/H)
local V=UDim2.fromOffset(O/H,P/H)


if C.Position~=T or C.Size~=V then
C.Position=T
C.Size=V
end end


k.updateSearchedCommand=function(B)
B:syncCommandsData()
local C=B.commandInput.bestMatch
local D=B.commandInput.commandName
if D==""then return end

local E=x(D)
or(C and x(C))

if E and E.commandData then
B.scrollBar:scrollTo(E.commandData.position)
end end


k.setComment=function(B, C, D)
if D~=nil then
C=af.colorFromName(C,D)
end

B.inputComment.Text=C
B.inputComment.Visible=#C>0 end


k.updateElementColor=function(B, C, D)
local E=if D%2==1 then 1 else 0.96
C.BackgroundTransparency=E end


k.updateElements=function(B)
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


k.setCommandInfo=function(B, C)
C=C or""

if C==""then
B.commandInfo.Visible=false
return
end

B.commandInfo.Visible=true
B.commandInfo.Text=C end


k.createSection=function(B, C)


local D=ad.new("TextLabel","Command",{
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

return ad.new("Frame",{
Size=UDim2.new(1,-10,0,B.configs.labelSize),
BackgroundTransparency=1,

D
})end


k.createCommandElement=function(B, C)
if C.isSection then
return B:createSection(C)
end

local D=ad.new("TextLabel","Command",{
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

return ad.new("Frame",{
Size=UDim2.new(1,0,0,B.configs.labelSize),
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
D
})end


k.createCommandDescription=function(B, C)
if C.isSection then return end
if not C.description then return end

local D=ad.new("TextLabel","Description",{
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

return ad.new("Frame","Description",{
Size=UDim2.new(1,-30,0,B.configs.labelSize),
BackgroundTransparency=1,
D
})end


k.getCommandColor=function(B, C, D)
local E=x(C)
if not E then return C end

local F=
if type(E.run)~="function"then"undefined"
elseif D.isClient then"client"
elseif D.isDeprecated then"deprecated"
else nil

if F~=nil then
C=j(C,d[F])
end

return C end


k.updateDisplayName=function(B, C, D)
local E=C.element
local F=C.name

local G=string.rep("—",(D-#F)-2)

F=B:getCommandColor(F,C)
local H=`{F} {af.colorFromName(G,"comment")} `

local I=B.parser:highlightArgsType(C.args)
local J=H..I

if C.isHolding then
C.originalText=J
else
B:setCommandText(C,J)
end end


k.setCommandText=function(B, C, D)
local E=C.element
if not E then return end

E.Command.Text=D end


k.getCommandText=function(B, C)
local D=C.element
return D and D.Command.Text or""end


k.calculateTotalSpace=function(B)
return#B.commandsData end


k.calculateVisibleSpace=function(B)
local C=B.scrollContainer.AbsoluteSize.Y
return math.floor(C/B:calculateLabelSize())end


k.calculateLabelSize=function(B)
return B.configs.padding+B.configs.labelSize end


k.getElementMouseIn=function(B)
for C,D in B.visibleCommands do
if ac:isMouseInGuiObject(D.element)then
return D
end
end end


k.horizontalScroll=function(B, C)
for D,E in B.visibleCommands do
local F=E.element

F.Position=UDim2.fromOffset(
math.min(F.Position.X.Offset+C,0),
F.Position.Y.Offset
)
end end






k.showHoverDescription=function(B, C)
local D=B.inputComment
local E=B.hoverText~=nil and D.Text==B.hoverText

if not E then
if D.Text~=""then
B.hoverText=nil
return false
end

B.savedComment=D.Text
end

B.hoverText=af.colorFromName(C,"comment")
D.Text=B.hoverText
D.Visible=true
return true end


k.clearHoverDescription=function(B)
if B.hoverText==nil then return end

local C=B.inputComment


if C.Text==B.hoverText then
C.Text=B.savedComment or""
C.Visible=#C.Text>0
end

B.hoverText=nil
B.savedComment=nil end


k.updateHoverDescription=function(B)
local C

if B.interactive and ac:isMouseInGuiObject(B.scrollContainer)then
C=B:getElementMouseIn()
end

local D=C and C.description
if not D then
B.hoveredCommand=nil
B:clearHoverDescription()
return
end

if C==B.hoveredCommand then return end


if B:showHoverDescription(D)then
B.hoveredCommand=C
end end


k.startedHoldingContainer=function(B, C)
if not B.interactive then return end
if not ah.isPressingInput(C)then return end
if B.scrollBar:isScrollBarDisabled()then return end

B.scrollAxis=nil
B.scrollBar:disableScroll()

local D=ac:getMouse()
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



local J=D.Y
local K=B.scrollBar.index<=0
local L=0
local M=false

local N local O=function()


B.scrollBar:enableScroll()


if K and B.scrollAxis=="y"and L>=w and B.onSwipeDown then
M=true
B.onSwipeDown(L)
end

if F then
F.isHolding=nil

if F.originalText then
B:setCommandText(F,F.originalText)
F.originalText=nil
end

if(tick()-G)<=0.15 and not M then
B.commandClickedSignal:Fire(F)
end
end

if N then N:Disconnect()end end


ah.onReleaseEvent(O)

N=ah.onMouseEvent(function(P)

if not B.interactive then return end
L=D.Y-J

local Q=D.X-I
local R=D.Y-H

if not B.scrollAxis then
if math.abs(Q)>4 or math.abs(R)>4 then
B.scrollAxis=math.abs(Q)>math.abs(R)and"x"or"y"
end
return
end

if B.scrollAxis=="x"then
local S=y(Q/3)
if math.floor(S)~=0 then
B:horizontalScroll(S)
I=D.X
end
else
local S=y(R/E)
if math.floor(S)~=0 then
B.scrollBar:scrollTo(B.scrollBar.index-S)
H=D.Y
end
end
end)end


k.update=function(B)
B:syncCommandsData()
B.scrollBar:setVisibleSpace(B:calculateVisibleSpace())
B.scrollBar:setTotalSpace(B:calculateTotalSpace())
B:updateElements()end


k.enable=function(B)
if B.isEnabled then return end
local C=B.scrollContainer
B.isEnabled=true

B.commandsFolder.Parent=C
B.searchBox.Parent=B.screenGui
B.searchBoxHolder.Parent=B.scrollHolder
B.sendButton.Parent=B.scrollHolder
B.commandInfo.Parent=B.scrollHolder

B.scrollConnection=B.scrolledSignal:Connect(function()
B:updateElements()
end)

B.containerConnection=C.InputBegan:Connect(function(D)
B:startedHoldingContainer(D)
end)

B:update()
B:updateSearchBoxPosition()


B.searchBoxConnection=aa:Connect(g.RenderStepped,function()
B:updateSearchBoxPosition()
end)


if not e then
B.hoverConnection=aa:Connect(g.RenderStepped,function()
B:updateHoverDescription()
end)
end end


k.disable=function(B)
if not B.isEnabled then return end
B.isEnabled=false

B.commandsFolder.Parent=nil
B.searchBox.Parent=nil
B.searchBoxHolder.Parent=nil
B.sendButton.Parent=nil
B.commandInfo.Parent=nil

aa:disconnect(B.containerConnection)
aa:disconnect(B.markerConnection)
aa:disconnect(B.scrollConnection)
aa:disconnect(B.searchBoxConnection)
aa:disconnect(B.hoverConnection)

B.hoveredCommand=nil
B:clearHoverDescription()end


k.new=function(B)local C=function(
C)
return assert(B.configs[C],`missing config.configs['{C}']`)end


local D=setmetatable({
scrollContainer=B.scrollContainer,
scrolledSignal=B.scrolledSignal,
scrollHolder=B.scrollHolder,
scrollBar=B.scrollBar,
screenGui=B.screenGui,

configs={
placeholderText=C("placeholderText"),
padding=C("padding"),
labelSize=C("labelSize"),
textSize=C("textSize")
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
},k)

D.parser=af.new(D.commandInput,function(E,F)
return D:setComment(E,F)
end)

return D end


return k end a.du=function()local ab=a.cache.du if not ab then ab={c=aa()}a.cache.du=ab end return ab.c end end do local aa=function()













local aa=a.dr()
local ab=a.f()
local ac=a.v()

local ad=ab.UserInputService

local ae=0.28
local af=0.2
local ag=10
local ah=0.15

local ai={}
ai.__index=ai local aj=function(



aj)
return aj.UserInputType~=Enum.UserInputType.Touch end local ak=function(



ak, al)
if al==ak.input then return true end
return ak.isMouse and al.UserInputType==Enum.UserInputType.MouseMovement end local al=function(



al, am)
if am==al.input then return true end
return al.isMouse and am.UserInputType==al.input.UserInputType end




ai._resetDrag=function(am)
for b,c in am._pressConnections do
c:Disconnect()
end
table.clear(am._pressConnections)

am._press=nil
am.isDragging=false
am.draggingObject=nil
am.dragStart=nil
am.startPos=nil
am.lastPos=nil
am.pressTime=0
am.travel=0
table.clear(am.samples)end




ai._endPress=function(am, b)
if am._press~=b then return end

local c=am.isDragging
local d=am.draggingObject
local e

if c then


local f=am:_velocity()

e={
duration=os.clock()-am.pressTime,
travel=am.travel,
dx=am.lastPos.X-am.dragStart.X,
dy=am.lastPos.Y-am.dragStart.Y,
velocityX=f.X,
velocityY=f.Y,
}
end

am:_resetDrag()

if c then
am.dragEnded:Fire(d,e)
end end



ai._beginDrag=function(am, b)
if am.isDragging or am._press~=b then return end

am.isDragging=true
am.draggingObject=b.object
am.dragStarted:Fire(b.object)end



ai._onPressMoved=function(am, b, c)
if am._press~=b or not ak(b,c)then return end

if b.isButton and not am.isDragging then
if(c.Position-am.dragStart).Magnitude<=ag then return end

am:_beginDrag(b)
end

if am.isDragging then
am:update(b.object,c)
end end




ai._startPress=function(am, b, c)
local d={
object=b,
input=c,
isMouse=aj(c),
isButton=b:IsA("GuiButton"),
}

am._press=d
am.dragStart=c.Position
am.lastPos=c.Position
am.startPos=b.Position
am.pressTime=os.clock()
am.travel=0
table.clear(am.samples)
am:_recordSample(c.Position)


am._pressConnections={
c.Changed:Connect(function()
if c.UserInputState==Enum.UserInputState.End then
am:_endPress(d)
end
end),
ad.InputChanged:Connect(function(e)
am:_onPressMoved(d,e)
end),
ad.InputEnded:Connect(function(e)
if al(d,e)then
am:_endPress(d)
end
end),
}

if not d.isButton then
am:_beginDrag(d)
return
end

task.delay(af,function()
am:_beginDrag(d)
end)end





ai.addGuiObject=function(am, b)
return b.InputBegan:Connect(function(c)
if not aa.isPressingInput(c)then return end
if am._press then return end

am:_startPress(b,c)
end)end


ai.update=function(am, b, c)
local d=c.Position-am.dragStart
local e=(am._uiScale and am._uiScale.Scale)or 1

am.lastPos=c.Position
am.travel=math.max(am.travel,d.Magnitude)
am:_recordSample(c.Position)

local f=UDim2.new(
am.startPos.X.Scale,
am.startPos.X.Offset+(d.X/e),
am.startPos.Y.Scale,
am.startPos.Y.Offset+(d.Y/e)
)

if am.filters[b]~=nil then
local g=am.filters[b](f,e)
f=g or f
end

b.Position=b.Position:Lerp(f,ae)
am.onDragged:Fire(b)end



ai._recordSample=function(am, b)
local c=os.clock()
table.insert(am.samples,{time=c,position=b})

while#am.samples>2 and c-am.samples[1].time>ah do
table.remove(am.samples,1)
end end




ai._velocity=function(am)
local b=am.samples
local c,d=b[1],b[#b]

if#b<2 or os.clock()-d.time>ah then
return Vector2.zero
end

local e=d.time-c.time
if e<=0 then
return Vector2.zero
end

local f=d.position-c.position
return Vector2.new(f.X/e,f.Y/e)end


ai.canDragObject=function(am, b)
return(not am.isDragging)or(am.draggingObject==b)end


ai.setFilter=function(am, 
b, 
c)

am.filters[b]=c end


ai.new=function(am)
return setmetatable({
isDragging=false,
draggingObject=nil,
_uiScale=am,
dragStart=nil,
startPos=nil,
lastPos=nil,
pressTime=0,
travel=0,
_press=nil,
_pressConnections={},
samples={},
filters={},

onDragged=ac.new(),
dragStarted=ac.new(),
dragEnded=ac.new(),
},ai)end


return ai end a.dv=function()local ab=a.cache.dv if not ab then ab={c=aa()}a.cache.dv=ab end return ab.c end end do local aa=function()

local aa=a.c3().uiScale
return a.dv().new(aa)end a.dw=function()local ab=a.cache.dw if not ab then ab={c=aa()}a.cache.dw=ab end return ab.c end end do local aa=function()
local aa=a.b6()

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
}end a.dx=function()local ab=a.cache.dx if not ab then ab={c=aa()}a.cache.dx=ab end return ab.c end end do local aa=function()










local aa=a.dx()
local ab=a.c5().args
local ac=a.b6()

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



ak, al)
local am=string.match(ak,"^%[(=*)%[",al)
if am==nil then
return nil
end

local b,c=string.find(ak,"]"..am.."]",al+#am+2,true)
return if c then c+1 else#ak+1 end local al=function(




al, am)
local b=string.sub(al,am,am)
local c=am+1

while c<=#al do
local d=string.sub(al,c,c)

if d=="\\"then
c=c+2
elseif d==b then
return c+1
elseif d=="\n"then
return c
else
c=c+1
end
end

return#al+1 end local am=function(



am, b)
local c=string.match(am,"^0[xX][%x_]+",b)or string.match(am,"^0[bB][01_]+",b)
if c then
return c
end

local d=string.sub(am,b,b)=="."

if d and string.sub(am,b-1,b-1)=="."then
return nil
end

c=string.match(am,"^%d[%d_]*",b)
if c==nil and d then
c=string.match(am,"^%.%d[%d_]*",b)
end
if c==nil then
return nil
end

local e=b+#c

if string.sub(am,e,e)=="."and string.sub(am,e+1,e+1)~="."then
local f=string.match(am,"^%.[%d_]*",e)
c=c..f
e=e+#f
end

local f=string.match(am,"^[eE][%+%-]?%d+",e)
if f then
c=c..f
end

return c end local b=function(



b, c)
local d=string.sub(b,c,c+2)
if ah[d]then
return d
end

local e=string.sub(b,c,c+1)
if ah[e]then
return e
end

return nil end local c=function(




c)
local d={}
local e=#c

local f={}local g=function(

g, h)
table.insert(d,{kind=g,text=h})end local h=function(



h)
local i=h
while i<=e do
local j=string.sub(c,i,i)
if j=="\\"then
i=i+2
elseif j=="`"or j=="{"then
break
else
i=i+1
end
end

local j=math.min(i,e+1)
if j>h then
g("string",string.sub(c,h,j-1))
end

if i>e then
return e+1
end

if string.sub(c,i,i)=="`"then
g("string","`")
else
g("symbol","{")
table.insert(f,0)
end

return i+1 end


local i=1
while i<=e do
local j=string.sub(c,i,i)

if string.match(j,"%s")then
local k=string.match(c,"^%s+",i)
g("space",k)
i=i+#k
elseif string.sub(c,i,i+1)=="--"then

local k=ak(c,i+2)or string.find(c,"\n",i,true)or e+1
g("comment",string.sub(c,i,k-1))
i=k
elseif j=='"'or j=="'"then
local k=al(c,i)
g("string",string.sub(c,i,k-1))
i=k
elseif j=="["and ak(c,i)then
local k=ak(c,i)
g("string",string.sub(c,i,k-1))
i=k
elseif j=="`"then
g("string","`")
i=h(i+1)
elseif j=="{"and#f>0 then do local k=
#f f[k]=f[k]+1 end
g("symbol","{")
i=i+1
elseif j=="}"and#f>0 then
if f[#f]==0 then
table.remove(f)
g("symbol","}")
i=h(i+1)
else do local k=
#f f[k]=f[k]-1 end
g("symbol","}")
i=i+1
end
elseif string.match(j,"[%a_]")then
local k=string.match(c,"^[%a_][%w_]*",i)
g("name",k)
i=i+#k
elseif am(c,i)then
local k=am(c,i)
g("number",k)
i=i+#k
else
local k=b(c,i)or j
g(if ag[j]then"symbol"else"other",k)
i=i+#k
end
end

return d end local d=function(



d, e, f)
local g=e+f
while d[g]and d[g].kind=="space"do
g=g+f
end
return d[g]end local e=function(



e, f, g)
if ae[g]then
return ab.boolean
end
if ad[g]or af[g]then
return ab.others
end

local h=d(e,f,-1)
local i=d(e,f,1)
local j=if h then h.text else nil
local k=if i then i.text else nil

if j=="function"then
return ab.func
end
if j=="."then
return if k=="("then ab.func else ab.field
end
if k=="("then
return ab.func
end
if j=="{"and k=="="then
return ab.field
end


return nil end local f=function(


f, g, h)
if h.kind=="name"then
return e(f,g,h.text)
end
return ai[h.kind]end


aj.apply=function(g, h)
local i=c(tostring(h))


local j={}
for k,l in i do
local m=f(i,k,l)
local n=j[#j]

if n and n.color==m then
table.insert(n.texts,l.text)
else
table.insert(j,{color=m,texts={l.text}})
end
end

local k={}
for l,m in j do
local n=ac.escapeRichText(table.concat(m.texts))
table.insert(k,if m.color then ac.colorFromRGB(n,m.color)else n)
end

return table.concat(k)end


aj.new=function()
return setmetatable({},aj)end


return aj end a.dy=function()local ab=a.cache.dy if not ab then ab={c=aa()}a.cache.dy=ab end return ab.c end end do local aa=function()






local aa=a.dy()
local ab=a.j()
local ac=a.cF()local ad=function(
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
}end a.dz=function()local ab=a.cache.dz if not ab then ab={c=aa()}a.cache.dz=ab end return ab.c end end do local aa=function()

local aa=a.b6().colorFromRGB
local ab=a.c5().commands

local ac=a.c6()local ad=function(

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
{id="plugins",title="Plugins",sections=a.dz(),paged=true},
}

ae.navigation={
back="Back",
next="Next",
}


ae.labels={
loading="Loading...",
failed="Could not load this code. Open this page again to retry.",
}

return ae end a.dA=function()local ab=a.cache.dA if not ab then ab={c=aa()}a.cache.dA=ab end return ab.c end end do local aa=function()



local aa=a.cY()
local ab=a.cX()
local ac=a.c2()
local ad=a.dw()
local ae=a.ds()

local af=a.c3()
local ag=a.aJ()
local ah=a.a()
local ai=a.cM()
local aj=a.aE()
local ak=a.f()
local al=a.cP()

local am=a.dA()
local b=a.dy()

local c=ak.TweenService

local d=500
local e=20
local f=28
local g=4


local h=300
local i=260
local j=40
local k=e+f+h

local l=12
local m=20
local n=40



local o=32
local p=16
local q=8
local r=18
local s=14
local t=l+8
local u=UDim2.new(0,0,0,0)
local v=UDim2.new(0,0,0,j)
local w=0.15
local x=0.15

local y=6
local z=8
local A=14
local B=6
local C="lucide-clipboard-copy"
local D=1.5

local E=0.5
local F=0.25
local G=0.25
local H=0.2
local I=0.12
local J=0.3
local K=0.15
local L=0.1
local M=36
local N=Enum.EasingStyle.Quart
local O=Enum.EasingDirection.Out

local P=UDim.new(0.5,0)

local Q=UDim2.new(0.5,-d/2,0,-500)
local R=UDim2.new(0.5,-d/2,0.5,-k/2)

local S={["&"]="&amp;",["<"]="&lt;",[">"]="&gt;"}

local T=am.cases
local V=am.pages
local W=#V

local X={}
X.__index=X



local Y=setmetatable({},{__mode="k"})local an=function(

Z, _)
local an=Y[Z]
local ao=an and an[_]
if ao==nil then
return
end

an[_]=nil
ao:Cancel()end local ao=function(




ao, Z, _, ap, aq)
an(ao,Z)

if _<=0 then
for ar,as in ap do
ao[ar]=as
end
if aq then
aq()
end
return
end

local ar=c:Create(ao,TweenInfo.new(_,N,O),ap)
Y[ao]=Y[ao]or{}
Y[ao][Z]=ar

ar.Completed:Connect(function(as)
local at=Y[ao]
if at and at[Z]==ar then
at[Z]=nil
end

if as==Enum.PlaybackState.Completed and aq then
aq()
end
end)

ar:Play()end local ap=function(



ap, aq, ar)
local as,at={},{}
for Z in aq do
if string.sub(Z,-6)=="Color3"then
table.insert(as,Z)
at[Z]=ap[Z]
end
end

ab:addObject(ap,aq)

local Z={}
for _,au in as do
Z[au]=ap[au]
ap[au]=at[au]
end

ao(ap,"color",ar,Z)end local aq=function(




aq, ar, as)
for at,au in aq:GetDescendants()do
if au.Name=="Code"and au:IsA("Frame")then
ao(au,"fade",ar,{BackgroundTransparency=as})

local Z=au:FindFirstChild("Copy")
if Z and Z:IsA("ImageButton")then
ao(Z,"fade",ar,{ImageTransparency=as})
end
end
end end local ar=function(



ar)
local as={}
for at,au in ar:GetDescendants()do
if au.ClassName=="TextLabel"or au.ClassName=="TextButton"then
table.insert(as,au)
end
end
return as end local as=function(


as)
return(as:gsub("[&<>]",S))end local at=function(


at)
return aa.new("TextLabel","Header",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=at,
TextSize=20,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})end local au=function(


au, Z)
return aa.new("TextLabel",Z and"Bold"or"Text",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=au,
TextSize=14,
TextWrapped=true,
RichText=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font=Z and"Font.Bold"or"Font.Normal",
TextColor3="Colors.Text.Default",
},
})end local av=function()



local Z=aa.new("Frame","Cases",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{
Padding=UDim.new(0,2),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

for _,av in T do
local aw,ax=av[1],av[2]

aa.new("TextLabel","Case",Z,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=_,
RichText=true,
Size=UDim2.new(1,0,0,0),
Text=`<b>{as(aw)}</b> {as(ax)}`,
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

return Z end local aw=function(



aw, ax)
ao(aw,"text",0,{TextTransparency=1})
aw.Text=ax
ao(aw,"text",J,{TextTransparency=0})end local ax=function(





ax, Z, _)
local ay=if ax=="code"then Z else nil
local az=false

local aA=aa.new("Frame","Code",{
AutomaticSize=Enum.AutomaticSize.Y,
BorderSizePixel=0,
Size=UDim2.new(1,0,0,0),
ThemeTag={BackgroundColor3="Colors.Buttons.Default"},
aa.new("UICorner",{CornerRadius=UDim.new(0,y)}),
})


local aB=aa.new("TextLabel","Source",aA,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
Text=if ay then b:apply(ay)else am.labels.loading,
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
PaddingTop=UDim.new(0,z),
PaddingBottom=UDim.new(0,z),
PaddingLeft=UDim.new(0,z),

PaddingRight=UDim.new(0,A+B+z),
}),
})

local aC=aa.new("ImageButton","Copy",aA,{
BackgroundTransparency=1,
Position=UDim2.new(1,-(A+B),0,B),
Size=UDim2.fromOffset(A,A),
ThemeTag={ImageColor3="Colors.Icons"},
})
ac:loadImage(aC,C)

if not ah.setclipboard then
aC.Visible=false
end

local aD
ag:Connect(aC.Activated,function()
if ay==nil or not ah.setclipboard then return end

ah.setclipboard(ay)
ap(aC,{ImageColor3="Colors.Primary"},al:getScale(K))

local aE=tick()
aD=aE

task.wait(D)
if aD~=aE then return end

ap(aC,{ImageColor3="Colors.Icons"},al:getScale(K))
end)

if ax=="file"then
table.insert(_,function()
if ay~=nil or az then return end
az=true

task.spawn(function()
local aE=ai.fetchReference(Z)
az=false

if aE==nil then
aB.Text=am.labels.failed
return
end

ay=aE
aw(aB,b:apply(aE))
end)
end)
end

return aA end local ay=function(


ay)
local az=aa.new("TextButton","InviteButton",{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,25),
Text=`Copy Discord Invite Link ({ay})`,
TextSize=16,
ThemeTag={
BackgroundColor3="Colors.Primary",
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local aA=az.Text
local aB

ag:Connect(az.Activated,function()
if ah.setclipboard then
ah.setclipboard(ay)
az.Text="Copied"
else
az.Text="No Clipboard Function, type out the link"
end

local aC=tick()
aB=aC

task.wait(D)
if aB~=aC then return end

az.Text=aA
end)

return az end local az=function(



az, aA)
local aB=az[1]

if aB=="title"then
return at(az[2])
elseif aB=="cases"then
return av()
elseif aB=="invite"then
return ay(aj.links.discord)
elseif aB=="code"or aB=="file"then
return ax(aB,az[2],aA)
end

return au(az[2],aB=="bold")end local aA=function(


aA, aB, aC, aD)
local aE=aa.new("Frame","Section",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=aA,
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

for Z,_ in aB do
local aF=az(_,aD)
aF.LayoutOrder=Z
aF.Parent=aE
end

if not aC then
aa.new("Frame","Line",aE,{
BorderSizePixel=0,
LayoutOrder=#aB+1,
Size=UDim2.new(1,0,0,1),
ThemeTag={
BackgroundColor3="Colors.Stroke",
},
})
end

return aE end local aB=function(



aB, aC, aD, aE, aF, Z)
local _=aa.new("TextButton",aC,aB,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
LayoutOrder=Z,
Size=UDim2.new(0,0,0,o),
Text="",
ThemeTag={BackgroundColor3="Colors.Tonal.Default"},
aa.new("UICorner",{CornerRadius=UDim.new(0.5,0)}),
aa.new("UIPadding",{
PaddingLeft=UDim.new(0,p),
PaddingRight=UDim.new(0,p),
}),
aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
Padding=UDim.new(0,q),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local aG=aa.new("ImageLabel","Icon",_,{
BackgroundTransparency=1,
LayoutOrder=if aF then 1 else 2,
Size=UDim2.fromOffset(r,r),
ThemeTag={ImageColor3="Colors.Tonal.Text"},
})
ac:loadImage(aG,aE)

local aH=aa.new("TextLabel","Label",_,{
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
LayoutOrder=if aF then 2 else 1,
Size=UDim2.new(0,0,1,0),
Text=aD,
TextSize=s,
ThemeTag={
Font="Font.Medium",
TextColor3="Colors.Tonal.Text",
},
})

return{button=_,label=aH,icon=aG,enabled=false}end local aC=function(



aC, aD, aE)
local aF=if aD then"Colors.Tonal.Default"else"Colors.Tonal.Disabled"
local aG=if aD then"Colors.Tonal.Text"else"Colors.Tonal.DisabledText"


if not aC.painted then
aE=0
aC.painted=true
end

aC.enabled=aD
ap(aC.button,{BackgroundColor3=aF},aE)

ap(aC.label,{Font="Font.Medium",TextColor3=aG},aE)
ap(aC.icon,{ImageColor3=aG},aE)


ao(aC.button,"transparency",aE,{BackgroundTransparency=0})end local aD=function(


aD, aE)
local aF=if aE and aD.enabled then x else 0
ao(aD.button,"transparency",al:getScale(I),{BackgroundTransparency=aF})end local aE=function(



aE, aF, aG)
ao(aE,"position",aG,{Position=UDim2.new((aF-1)/W,0,0,0)})end


X.new=function()
return setmetatable({
isOpen=false,
pages={},
onOpenChanged=nil,
},X)end


X.setOpen=function(aF, aG)
aF.isOpen=aG

if aF.onOpenChanged then
aF.onOpenChanged(aG)
end end


X.open=function(aF)
aF:setOpen(true)
aF.frame:TweenPosition(R,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,E,true)end


X.close=function(aF)
aF:setOpen(false)
aF.frame:TweenPosition(Q,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,E,true)end


X.refreshScroll=function(aF)
local aG=aF.activeEntry
if not aG then return end

local aH=math.max(af:getScale(),0.01)
aF.scrollBar:setTotalSpace(math.ceil(aG.body.AbsoluteSize.Y/aH))
aF.scrollBar:setVisibleSpace(math.ceil(aF.container.AbsoluteSize.Y/aH))
aG.body.Position=UDim2.fromOffset(0,-aF.scrollBar.index)end


X.loadEntry=function(aF, aG)
for aH,Z in aG.loaders do
Z()
end end


X.updateNavigation=function(aF, aG, aH)
local Z=if aH then al:getScale(H)else 0

aC(aF.nav.back,aG.index>1,Z)
aC(aF.nav.forward,aG.index<#aG.entries,Z)
aF.counter.Text=`{aG.index} / {#aG.entries}`end




X.transitionTo=function(aF, aG, aH, Z)
local _=aG.entries[aH]
local aI=aF.activeEntry
if _==nil or _==aI then return end

local aJ=if Z==0 or aI==nil then 0 else al:getScale(F)

aF.activeEntry=_
aG.index=aH
_.leaving=nil

_.slide.Visible=true
aF:loadEntry(_)
if aG.paged then
aF:updateNavigation(aG,aJ>0)
end


ao(_.slide,"position",0,{Position=UDim2.new(0,Z*M,0,0)})
ao(_.slide,"position",aJ,{Position=UDim2.new(0,0,0,0)})
for aK,aL in ar(_.slide)do
ao(aL,"text",0,{TextTransparency=1})
ao(aL,"text",aJ,{TextTransparency=0})
end
aq(_.slide,0,1)
aq(_.slide,aJ,0)



if aI then
local aK={}
aI.leaving=aK

ao(aI.slide,"position",aJ,{Position=UDim2.new(0,-Z*M,0,0)},function()
if aF.activeEntry~=aI then
aI.slide.Visible=false
end
end)

for aL,aM in ar(aI.slide)do
ao(aM,"text",aJ,{TextTransparency=1})
end
aq(aI.slide,aJ,1)


task.delay(aJ+L,function()
if aI.leaving==aK and aF.activeEntry~=aI then
aI.slide.Visible=false
end
end)
end

aF.scrollBar:scrollTo(0)
aF:refreshScroll()end


X.turnPage=function(aF, aG)
local aH=aF.activePage
if not aH or not aH.paged then return end

local aI=aH.index+aG
if aI<1 or aI>#aH.entries then return end

aF:transitionTo(aH,aI,aG)end




X.setPaged=function(aF, aG, aH)
local aI=if aH then 0 else al:getScale(G)
local aJ=aF.navigation

ao(aF.holder,"size",aI,{
Size=UDim2.new(1,0,0,if aG then i else h),
})

if aG then
an(aJ,"position")
if aI>0 then
aJ.Position=v
end
aJ.Visible=true
ao(aJ,"position",aI,{Position=u})
else
ao(aJ,"position",aI,{Position=v},function()
if not aF.activePage or not aF.activePage.paged then
aJ.Visible=false
end
end)
end end


X.selectPage=function(aF, aG)
local aH=aF.pages[aG]
if not aH then return false end
if aF.activePage==aH then return true end

local aI=aF.activePage
local aJ=aI==nil
local aK=if aJ then 0 elseif aH.order>aI.order then 1 else-1

aF.activePage=aH
aF.pageId=aG

aE(aF.thumb,aH.order,if aJ then 0 else al:getScale(G))
aF:setPaged(aH.paged,aJ)
aF:transitionTo(aH,aH.index,aK)
return true end


X.create=function(aF)
local aG=aa.new("Frame","ReferenceFrame",{
Active=true,
BorderSizePixel=0,
Position=Q,
Size=UDim2.fromOffset(d,k),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

local aH=aa.new("Frame","TopBar",aG,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,e),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",aH,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text="Reference",
TextSize=16,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local aI=aa.new("TextButton","Close",aH,{
BackgroundTransparency=1,
Position=UDim2.new(1,-e,0,0),
Size=UDim2.fromOffset(e,e),
Text="",
})

local aJ=aa.new("ImageLabel","Icon",aI,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(10,10),
ThemeTag={
ImageColor3="Colors.Icons",
},
})


local aK=aa.new("Frame","Tabs",aG,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,e),
Size=UDim2.new(1,0,0,f),
})

local aL=aa.new("Frame","Track",aK,{
BorderSizePixel=0,
Position=UDim2.fromOffset(g,g),
Size=UDim2.new(1,-g*2,1,-g*2),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},
aa.new("UICorner",{CornerRadius=P}),
})

local aM=aa.new("Frame","Thumb",aL,{
BorderSizePixel=0,
Size=UDim2.new(1/W,0,1,0),
ThemeTag={
BackgroundColor3="Colors.Border.Holding",
},
aa.new("UICorner",{CornerRadius=P}),
})
aF.thumb=aM

local Z=ae.new({
isHorizontal=false,
barThickness=l,
increment=m,
wheelIncrement=n,
})

local _=Z:create()
local aN=Z.container

local aO=aa.new("Frame","ScrollHolder",aG,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,e+f),
Size=UDim2.new(1,0,0,h),

_,
aN,
})


local aP=aa.new("Frame","Footer",aG,{
BackgroundTransparency=1,
ClipsDescendants=true,
Position=UDim2.fromOffset(0,e+f+i),
Size=UDim2.new(1,0,0,j),
})


local aQ=aa.new("Frame","Navigation",aP,{
BackgroundTransparency=1,
Position=v,
Size=UDim2.new(1,0,1,0),
Visible=false,
aa.new("UIPadding",{PaddingRight=UDim.new(0,t)}),
aa.new("UIListLayout",{
FillDirection=Enum.FillDirection.Horizontal,
HorizontalAlignment=Enum.HorizontalAlignment.Right,
Padding=UDim.new(0,q),
SortOrder=Enum.SortOrder.LayoutOrder,
VerticalAlignment=Enum.VerticalAlignment.Center,
}),
})

local aR=aB(aQ,"Back",am.navigation.back,"lucide-arrow-left",true,1)

local aS=aa.new("TextLabel","Counter",aQ,{
AutomaticSize=Enum.AutomaticSize.X,
BackgroundTransparency=1,
LayoutOrder=2,
Size=UDim2.new(0,0,0,o),
Text="1 / 1",
TextSize=s,
ThemeTag={
Font="Font.Medium",
TextColor3="Colors.Text.Dark",
},
})

local aT=aB(aQ,"Next",am.navigation.next,"lucide-arrow-right",false,3)

for aU,aV in{aR,aT}do
ag:Connect(aV.button.MouseEnter,function()
aD(aV,true)
end)
ag:Connect(aV.button.MouseLeave,function()
aD(aV,false)
end)
end

aF.scrollBar=Z
aF.container=aN
aF.holder=aO
aF.footer=aP
aF.navigation=aQ
aF.counter=aS
aF.nav={back=aR,forward=aT}local aU=function(



aU, aV, aW)
local aX=aa.new("Frame","Slide",aN,{
BackgroundTransparency=1,
Size=UDim2.new(1,0,1,0),
Visible=false,
})
aV.Parent=aX

local aY={slide=aX,body=aV,loaders=aW}
table.insert(aU.entries,aY)

ag:Connect(aV:GetPropertyChangedSignal("AbsoluteSize"),function()
if aF.activeEntry==aY then
aF:refreshScroll()
end
end)end




for aV,aW in V do
local aX=aa.new("TextButton",aW.id,aL,{
AutoButtonColor=false,
BackgroundTransparency=1,
BorderSizePixel=0,
Position=UDim2.new((aV-1)/W,0,0,0),
Size=UDim2.new(1/W,0,1,0),
Text=aW.title,
TextSize=13,
ThemeTag={
Font="Font.Bold",
TextColor3="Colors.Text.Default",
},
})

local aY=aW.paged==true
local aZ={
id=aW.id,
order=aV,
button=aX,
paged=aY,
entries={},
index=1,
}

if aY then
for a_,a0 in aW.sections do
local a1={}
aU(aZ,aA(a_,a0,true,a1),a1)
end
else
local a_={}
local a0=aa.new("Frame","Content",{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),
aa.new("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder}),
})

for a1,a2 in aW.sections do
local a3=aA(a1,a2,a1==#aW.sections,a_)
a3.Parent=a0
end

aU(aZ,a0,a_)
end

aF.pages[aW.id]=aZ

ag:Connect(aX.Activated,function()
aF:selectPage(aW.id)
end)
end

ag:Connect(aR.button.Activated,function()
aF:turnPage(-1)
end)
ag:Connect(aT.button.Activated,function()
aF:turnPage(1)
end)local aV=function(


aV)
if aF.activeEntry then
aF.activeEntry.body.Position=UDim2.fromOffset(0,-aV)
end end


ag:Connect(Z.scrolledSignal,aV)
ag:Connect(aN:GetPropertyChangedSignal("AbsoluteSize"),function()
aF:refreshScroll()
end)

ag:Connect(aI.Activated,function()
aF:close()
end)

ad:addGuiObject(aG)

ad.dragStarted:Connect(function(aW)
if aW~=aG then return end
Z:disableScroll()
end)

ad.dragEnded:Connect(function(aW)
if aW~=aG then return end
Z:enableScroll()
end)

aF:selectPage(V[1].id)

aF.frame=aG
aF.closeIcon=aJ

return aG end


return X end a.dB=function()local ab=a.cache.dB if not ab then ab={c=aa()}a.cache.dB=ab end return ab.c end end do local aa=function()



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
}end a.dC=function()local ab=a.cache.dC if not ab then ab={c=aa()}a.cache.dC=ab end return ab.c end end do local aa=function()


local aa=a.cY()
local ab=a.c2()
local ac=a.cX()

local ad=a.dw()
local ae=a.c7()

local af=a.b6()

local ag=a.c3()
local ah=a.aJ()
local ai=a.a()
local aj=a.g()
local ak=a.f()
local al=a.b()

local am=a.dC()
local an=a.c6()

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

ab:loadImage(aE,"lucide-custom-x")

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


return aq end a.dD=function()local ab=a.cache.dD if not ab then ab={c=aa()}a.cache.dD=ab end return ab.c end end do local aa=function()


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
}end a.dE=function()local ab=a.cache.dE if not ab then ab={c=aa()}a.cache.dE=ab end return ab.c end end do local aa=function()



local aa=a.cY()
local ab=a.c2()
local ac=a.cX()
local ad=a.dw()
local ae=a.c3()
local af=a.ds()
local ag=a.c7()

local ah=a.b()
local ai=a.dE()
local aj=a.f()
local ak=a.a()
local al=a.cP()
local am=a.bO()
local an=a.c5().args
local ao=a.c6()
local ap=a.b6()
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


aZ, a_, a0, a1, a2)
local a3=aa.new("TextButton",a_,aZ,{
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

aK(a3,a1,a2)
return a3 end local a_=function(



a_, a0)
a_.Position=UDim2.new(a0,aG,0,aG)
a_.Size=UDim2.new(aE,-aG*2,1,-aG*2)end local a0=function(



a0, a1, a2, a3)
local b=aa.new("TextButton",a1,a0,{
AutoButtonColor=false,
BackgroundTransparency=1,
BorderSizePixel=0,
Text=a2,
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

a_(b,a3)
return b end local a1=function(


a1)
a1.content.Position=UDim2.fromOffset(0,-a1.scrollBar.index)end local a2=function(


a2)
local a3=ae:getScale()
a2.scrollBar:setTotalSpace(math.ceil(a2.content.AbsoluteSize.Y/a3))
a2.scrollBar:setVisibleSpace(math.ceil(a2.container.AbsoluteSize.Y/a3))
a1(a2)end local a3=function(


a3)
for b,c in a3.labels do
c:Destroy()
end
table.clear(a3.labels)end local b=function(


b, c, d)
b.order=b.order+1

local e=if b.order%2==1 then ar.stripeTransparency else 1

local f=aa.new("TextButton","Entry",b.content,{
AutoButtonColor=false,
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundColor3=Color3.new(1,1,1),
BackgroundTransparency=e,
BorderSizePixel=0,
LayoutOrder=b.order,
Size=UDim2.new(1,0,0,0),
RichText=true,
Text=aP(c,d),
TextSize=ai.textSizes.entry,
TextWrapped=true,
TextXAlignment=Enum.TextXAlignment.Left,
TextYAlignment=Enum.TextYAlignment.Top,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})


f.MouseEnter:Connect(function()
f.BackgroundTransparency=aI
end)
f.MouseLeave:Connect(function()
f.BackgroundTransparency=e
end)
f.Activated:Connect(function()
aR(c,d)
end)

table.insert(b.labels,f)
while#b.labels>ai.maxLabels do
table.remove(b.labels,1):Destroy()
end


task.defer(function()
if b.frame.Parent then
a2(b)
b.scrollBar:scrollTo(math.huge)
end
end)end local c=function(


c, d)
a3(c)

for e,f in am.entries[c.tab]do
b(c,c.tab,f)
end

aV(c)
aU(c,d==true)end local d=function(


d)
local e={
tab=d,
labels={},
order=0,
connections={},
tweens={},
}

local f=aa.new("Frame","ChatLogs",{
Active=true,
BorderSizePixel=0,
Position=av,
Size=UDim2.fromOffset(ar.width,ar.height),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})
e.frame=f


local g=aa.new("Frame","TopBar",f,{
BorderSizePixel=0,
Size=UDim2.new(1,0,0,as),
ThemeTag={
BackgroundColor3="Colors.Background",
},
})

aa.new("TextLabel","Title",g,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=ai.title,
TextSize=ai.textSizes.title,
ThemeTag={
Font="Font.Normal",
TextColor3="Colors.Text.Default",
},
})

local h=aa.new("TextButton","Close",g,{
BackgroundTransparency=1,
Position=UDim2.new(1,-as,0,0),
Size=UDim2.fromOffset(as,as),
Text="",
})

local i=aa.new("ImageLabel","Icon",h,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(5,5),
Size=UDim2.fromOffset(ar.closeIconSize,ar.closeIconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})
ab:loadImage(i,"lucide-custom-x")


local j=aa.new("Frame","Controls",f,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,as),
Size=UDim2.new(1,0,0,ar.rowHeight),
})

local k=aZ(j,"Clear",ai.controls.clear,aw,ax)
local l=aZ(j,"Save",ai.controls.save,ay,az)
e.toggle=aZ(j,"Toggle",ai.controls.enabled,aA,aB)


local m=aa.new("Frame","Switch",j,{
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=aH,
}),
})
aK(m,aC,aD)

e.thumb=aa.new("Frame","Thumb",m,{
BorderSizePixel=0,
ThemeTag={
BackgroundColor3="Colors.Border.Holding",
},

aa.new("UICorner",{
CornerRadius=aH,
}),
})
a_(e.thumb,aF.chat)

local n=a0(m,"ChatTab",ai.tabs.chat,aF.chat)
local o=a0(m,"JoinTab",ai.tabs.join,aF.join)

e.tabButtons={chat=n,join=o}
e.actions={l,k}


local p=af.new({
isHorizontal=false,
barThickness=ai.scrollBar.barThickness,
increment=ai.scrollBar.increment,
wheelIncrement=ai.scrollBar.wheelIncrement,
})
local q=p:create()
local r=p.container

local s=aa.new("Frame","Content",r,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
Size=UDim2.new(1,0,0,0),

aa.new("UIListLayout",{
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

aa.new("Frame","ScrollHolder",f,{
Active=true,
BackgroundTransparency=1,
Position=UDim2.fromOffset(0,at),
Size=UDim2.new(1,0,1,-at),

q,
r,
})

e.scrollBar=p
e.container=r
e.content=s

aX(e,p.scrolledSignal,function()
a1(e)
end)
aX(e,s:GetPropertyChangedSignal("AbsoluteSize"),function()
a2(e)
end)
aX(e,r:GetPropertyChangedSignal("AbsoluteSize"),function()
a2(e)
end)
aX(e,ad.dragStarted,function(t)
if t==f then
p:disableScroll()
end
end)
aX(e,ad.dragEnded,function(t)
if t==f then
p:enableScroll()
end
end)

aX(e,h.Activated,function()
aJ:close()
end)

aX(e,n.Activated,function()
aJ:select("chat")
end)

aX(e,o.Activated,function()
aJ:select("join")
end)

aX(e,e.toggle.Activated,function()
local t=aM(e.tab)
if e.tab=="chat"then
am.setChat(not t)
else
am.setJoin(not t)
end

aN(e.tab,not t)
aV(e)
end)

aX(e,l.Activated,function()
local t,u=am.save(e.tab)
if t then
ag:notify(ai.messages.saved,u)
else
ag:notify(ai.messages.saveFailed,u)
end
end)

aX(e,k.Activated,function()
am.clear(e.tab)
a3(e)
end)

for t,u in{n,o,e.toggle,l,k}do
aY(e,u)
end

return e end local e=function()




if aJ.listening then
return
end
aJ.listening=true

am.onEntry(function(e,f)
local g=aJ.window
if g and g.tab==e then
b(g,e,f)
end
end)end


aJ.restore=function(f)
aO("chat",am.setChat)
aO("join",am.setJoin)end


aJ.open=function(f, g)
f:restore()

e()

local h=f.window
if h then
f:select(g)
return h
end

h=d(g)
f.window=h

h.frame.Parent=ah.screenGui
h.frame:TweenPosition(au,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,ar.tweenTime,true)
ad:addGuiObject(h.frame)

c(h)
return h end


aJ.select=function(f, g)
local h=f.window
if not h then
return
end

h.tab=g
c(h,true)end


aJ.close=function(f)
local g=f.window
if not g then
return
end

f.window=nil
aW(g)
aT(g)

g.frame:TweenPosition(av,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,ar.tweenTime,true)
task.delay(ar.tweenTime,function()
g.frame:Destroy()
end)end



aJ.reset=function(f)
local g=f.window
if g then
aW(g)
aT(g)
end
f.window=nil end


return aJ end a.dF=function()local ab=a.cache.dF if not ab then ab={c=aa()}a.cache.dF=ab end return ab.c end end do local aa=function()







local aa=a.cY()
local ab=a.c2()
local ac=a.cX()
local ad=a.aM()
local ae=a.f()
local af=a.dr()
local ag=a.c3()
local ah=a.dj()

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
})end local as=function(




as, at)
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



ap.row=function(at)
at.order=at.order+1
at.index=at.index+1

return as(at,if at.index%2==1 then ai.stripeTransparency else 1)end



ap.actionRow=function(at)
at.order=at.order+1
at.index=at.index+1

return as(at,0)end





ap.buttonRow=function(at, au)
at.order=at.order+1

local av=aa.new("Frame","Buttons",at.parent,{
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=at.order,
Size=UDim2.new(1,0,0,ai.rowHeight),
})

local aw=#au
local ax=ai.rowGap
local ay={}

for az,aA in au do
local aB=aa.new("TextButton","Button",av,{
AutoButtonColor=false,
BorderSizePixel=0,

Position=UDim2.new((az-1)/aw,(az-1)*ax/aw),
Size=UDim2.new(1/aw,-ax*(aw-1)/aw,1,0),
Text="",
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

ap.icon(aB,aA.icon)
ap.label(aB,aA.text,ai.padding)

aB.MouseEnter:Connect(function()
ac:updateObjectProperties(aB,{BackgroundColor3="Colors.Buttons.Holding"})
end)

aB.MouseLeave:Connect(function()
ac:updateObjectProperties(aB,{BackgroundColor3="Colors.Buttons.Default"})
end)

aB.Activated:Connect(aA.onTap)

table.insert(ay,aB)
end

return ay end



ap.pageTop=function(at, au, av)
local aw=ap.row(at)
aw.Name="BackRow"
ap.icon(aw,ah.pages.backIcon)
ap.label(aw,ah.pages.back,0)
aw.Activated:Connect(av)

if au then
ap.header(at,au)
end end



ap.label=function(at, au, av, aw)
return aa.new("TextLabel","Label",at,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(aj.labelInset,0),
Size=UDim2.new(1,-(aj.labelInset+av),1,0),
Text=au,
TextSize=am.label,
TextTruncate=Enum.TextTruncate.AtEnd,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.Normal",
TextColor3=aw or"Colors.Text.Default",
},
})end


ap.icon=function(at, au)
local av=aa.new("ImageLabel","Icon",at,{
AnchorPoint=Vector2.new(0,0.5),
BackgroundTransparency=1,
Position=UDim2.new(0,aj.iconInset,0.5,0),
Size=UDim2.fromOffset(aj.iconSize,aj.iconSize),
ThemeTag={
ImageColor3="Colors.Icons",
},
})

ab:loadImage(av,au)
return av end



ap.chevron=function(at)
local au=aa.new("ImageLabel","Chevron",at,{
AnchorPoint=Vector2.new(1,0.5),
BackgroundTransparency=1,
Position=UDim2.new(1,-ai.padding,0.5,0),
Rotation=180,
Size=UDim2.fromOffset(aj.chevronSize,aj.chevronSize),
ThemeTag={
ImageColor3="Colors.Text.Darker",
},
})

ab:loadImage(au,ah.pages.backIcon)
return au end






ap.rowButton=function(at, au, av, aw)
local ax=aa.new("TextButton","RowButton",at,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.new(1,-av,0.5,0),
Size=UDim2.fromOffset(aw,al.height+4),
Text=au,
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

ax.MouseEnter:Connect(function()
ac:updateObjectProperties(ax,{
BackgroundColor3="Colors.Primary",
})
end)

ax.MouseLeave:Connect(function()
ac:updateObjectProperties(ax,{
BackgroundColor3="Colors.Background",
})
end)

return ax end



ap.box=function(at)
local au=aa.new("Frame","Box",at,{
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

local av=aa.new("Frame","Fill",au,{
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

return au,av end



ap.value=function(at, au, av)
local aw=aa.new("Frame","Value",at,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(av,al.height),
ThemeTag={
BackgroundColor3="Colors.Buttons.Default",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,al.cornerRadius),
}),
})

local ax=aa.new("TextLabel","Text",aw,{
BackgroundTransparency=1,
Size=UDim2.fromScale(1,1),
Text=au,
TextSize=am.value,
TextTruncate=Enum.TextTruncate.AtEnd,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Default",
},
})

return aw,ax end



ap.valueInput=function(at, au, av)
return aa.new("TextBox","ValueInput",at,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
ClearTextOnFocus=false,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(av,al.height),
Text=au,
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







ap.slider=function(at, au, av, aw, ax)
ap.label(at,au,ao.width+ao.valueWidth+ai.rowGap+ai.padding)

local ay=aa.new("TextButton","Track",at,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BackgroundTransparency=1,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(ao.width,ao.hitHeight),
Text="",
})

local az=aa.new("Frame","Bar",ay,{
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

local aA=aa.new("Frame","Fill",az,{
BorderSizePixel=0,
Size=UDim2.fromScale(0,1),
ThemeTag={
BackgroundColor3="Colors.Primary",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,ao.barHeight/2),
}),
})

local aB=aa.new("Frame","Knob",ay,{
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

local aC=aa.new("TextLabel","Value",at,{
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
})local aD=function(


aD)
aA.Size=UDim2.fromScale(aD,1)
aB.Position=UDim2.fromScale(aD,0.5)
aC.Text=if ax then ax(aD)else`{math.round(aD*100)}%`end


aD(math.clamp(av,0,1))


local aE local aF=function()


local aF=aE
if aF==nil then return end

aE=nil
aF.moved:Disconnect()
aF.released:Disconnect()

if aF.scroller then
aF.scroller.ScrollingEnabled=aF.wasScrolling
end end local aG=function(


aG)
local aH=aE
if aH==nil or aH.width<=0 then return end



local aI=(aG-aH.left)/aH.scale
local aJ=aH.width/aH.scale

local aK=math.clamp(aI/aJ,0,1)

aD(aK)
aw(aK)end


ay.InputBegan:Connect(function(aH)
if aE~=nil or not af.isPressingInput(aH)then return end


local aI=ay:FindFirstAncestorWhichIsA("ScrollingFrame")

aE={
scale=ag:getScale(),
left=ay.AbsolutePosition.X,
width=ay.AbsoluteSize.X,
scroller=aI,
wasScrolling=if aI then aI.ScrollingEnabled else false,
}

if aI then
aI.ScrollingEnabled=false
end

aE.moved=ae.UserInputService.InputChanged:Connect(function(aJ)
if not af.isMovingInput(aJ)then return end


if ay.Parent==nil then
aF()
return
end

aG(aJ.Position.X)
end)

aE.released=ae.UserInputService.InputEnded:Connect(function(aJ)
if af.isPressingInput(aJ)then
aF()
end
end)

aG(aH.Position.X)
end)end





ap.keybind=function(at, au, av)
local aw,ax=ap.value(at,"",al.keybindWidth)
local ay local az=function()


local az=ay~=nil

ax.Text=if az then"press a key"else ad:getBindingName(au)
ac:updateObjectProperties(aw,{
BackgroundColor3=if az then"Colors.Primary"else"Colors.Buttons.Default",
})end local aA=function()



if ay then
local aA=ay
ay=nil
aA()
end

az()end


at.Activated:Connect(function()
if ay then
aA()
return
end

ay=ad:capture(function(aB)
ay=nil
ad:setBinding(au,aB)
az()

if av then
av()
end
end,function()

ay=nil
az()
end)

az()
end)

az()
return az,aA end



ap.textBox=function(at, au)
at.order=at.order+1

return aa.new("TextBox","Input",at.parent,{
BorderSizePixel=0,
ClearTextOnFocus=false,
LayoutOrder=at.order,
PlaceholderText=au,
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
})end local at=function(



at)
return aa.new("TextLabel","Badge",at,{
AnchorPoint=Vector2.new(1,0),
AutomaticSize=Enum.AutomaticSize.X,
BorderSizePixel=0,
Position=UDim2.new(1,an.overhang,0,-an.overhang),
Size=UDim2.fromOffset(0,an.height),
Text="",
TextSize=am.badge,
Visible=false,
ZIndex=at.ZIndex+1,
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





ap.choices=function(au, av, aw, ax)
au.order=au.order+1

local ay=ai.rowGap
local az=aa.new("Frame","Choices",au.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=au.order,
Size=UDim2.new(1,0,0,0),

aa.new("UIGridLayout",{
CellPadding=UDim2.fromOffset(ay,ay),
CellSize=UDim2.new(1/ax,-ay*(ax-1)/ax-1,0,ai.rowHeight-3),
SortOrder=Enum.SortOrder.LayoutOrder,
}),
})

local aA={}
local aB={}local aC=function(

aC)
for aD,aE in aA do
ac:updateObjectProperties(aE,{
BackgroundColor3=if aD==aC then"Colors.Primary"else"Colors.Buttons.Default",
})
end end


for aD,aE in av do
local aF=aa.new("TextButton","Choice",az,{
AutoButtonColor=false,
BorderSizePixel=0,
LayoutOrder=aD,
Text=aE,
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

aA[aD]=aF
aB[aD]=at(aF)

aF.Activated:Connect(function()
aC(aD)
aw(aD)
end)
end local aD=function(


aD, aE)
local aF=aB[aD]
if not aF then return end

aF.Text=tostring(aE)
aF.Visible=aE>0 end


return aC,aD end



ap.inputRow=function(au, av, aw, ax)
local ay=ap.row(au)
ap.label(ay,av,al.inputWidth+2*ai.padding)

local az=aa.new("TextBox","Input",ay,{
AnchorPoint=Vector2.new(1,0.5),
BorderSizePixel=0,
ClearTextOnFocus=false,
PlaceholderText=aw,
Position=UDim2.new(1,-ai.padding,0.5,0),
Size=UDim2.fromOffset(al.inputWidth,al.height),
Text=ax or"",
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

return ay,az end




ap.formRow=function(au, av, aw, ax, ay)
au.order=au.order+1

local az=ai.rowGap
local aA=al.addWidth
local aB=ay or al.formDelayWidth

local aC=aa.new("Frame","Form",au.parent,{
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=au.order,
Size=UDim2.new(1,0,0,ai.rowHeight),
})local aD=function(

aD, aE, aF, aG, aH)
return aa.new("TextBox",aD,aC,{
AnchorPoint=aF,
BorderSizePixel=0,
ClearTextOnFocus=false,
PlaceholderText=aE,
Position=aG,
Size=aH,
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


local aE=aD("Command",av,Vector2.zero,UDim2.fromOffset(0,0),
UDim2.new(1,-(aA+aB+2*az),1,0))
local aF=aD("Delay",aw,Vector2.new(1,0),UDim2.new(1,-(aA+az),0,0),
UDim2.new(0,aB,1,0))

local aG=aa.new("TextButton","Add",aC,{
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BorderSizePixel=0,
Position=UDim2.fromScale(1,0),
Size=UDim2.new(0,aA,1,0),
Text=ax,
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

return aE,aF,aG end




ap.footer=function(au, av)
au.order=au.order+1

return aa.new("TextLabel","Footer",au.parent,{
BackgroundTransparency=1,
LayoutOrder=au.order,
Size=UDim2.new(1,0,0,ai.headerHeight),
Text=av,
TextSize=am.footer,
TextXAlignment=Enum.TextXAlignment.Center,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})end



ap.note=function(au, av)
au.order=au.order+1

return aa.new("TextLabel","Note",au.parent,{
AutomaticSize=Enum.AutomaticSize.Y,
BackgroundTransparency=1,
LayoutOrder=au.order,
Size=UDim2.new(1,0,0,0),
Text=av,
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


return ap end a.dG=function()local ab=a.cache.dG if not ab then ab={c=aa()}a.cache.dG=ab end return ab.c end end do local aa=function()







local aa=a.dk()
local ab=a.c7()
local ac=a.dG()
local ad=a.dj()

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


return af end a.dH=function()local ab=a.cache.dH if not ab then ab={c=aa()}a.cache.dH=ab end return ab.c end end do local aa=function()










local aa=a.cY()
local ab=a.cX()
local ac=a.n()
local ad=a.dj()
local ae=a.dG()
local af=a.dH()
local ag=a.a()
local ah=a.c2()
local ai=a.c7()

local aj=ad.panel
local ak=ad.box
local al=ad.textSizes

local am=14
local an=20
local ao=4 local ap=function(


ap, aq, ar)
ap.order=ap.order+1

local as=ab:getPrimaryOptions()

local at=aa.new("Frame","Primary",ap.parent,{
BackgroundTransparency=1,
BorderSizePixel=0,
LayoutOrder=ap.order,
Size=UDim2.new(1,0,0,aj.rowHeight),
Visible=false,
})

aa.new("TextLabel","Label",at,{
BackgroundTransparency=1,
Position=UDim2.fromOffset(ad.row.labelInset,0),
Size=UDim2.new(1,-ad.row.labelInset,1,0),
Text=ad.pages.theme.primary,
TextSize=al.value,
TextXAlignment=Enum.TextXAlignment.Left,
ThemeTag={
Font="Font.MonoSpace",
TextColor3="Colors.Text.Darker",
},
})

local au={}

for av,aw in as do

local ax=#as-av

local ay=aa.new("TextButton","Pick",at,{
AnchorPoint=Vector2.new(1,0.5),
AutoButtonColor=false,
BackgroundTransparency=1,
Position=UDim2.new(1,-(aj.padding+ax*(an+ao)),0.5,0),
Size=UDim2.fromOffset(an,an),
Text="",
})

local az=aa.new("Frame","Check",ay,{
AnchorPoint=Vector2.new(0.5,0.5),
BackgroundColor3=ab:getPrimaryColor(aq.theme,aw.key),
BackgroundTransparency=1,
BorderSizePixel=0,
Position=UDim2.fromScale(0.5,0.5),
Size=UDim2.fromOffset(am,am),

aa.new("UICorner",{
CornerRadius=UDim.new(0,ak.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Color=ab:getPrimaryColor(aq.theme,aw.key),
Thickness=1.5,
}),
})

au[aw.key]=az

ay.Activated:Connect(function()
ar(aw.key)
end)
end local av=function()


local av=ab:getPrimaryKey(aq.key)

for aw,ax in au do
ax.BackgroundTransparency=if aw==av then 0 else 1
end end


return at,av end local aq=function(


aq, ar)
local as=ae.list(aq)

ae.pageTop(as,nil,ar.back)

ae.header(as,ad.pages.theme.iconsTitle)



local at=ae.row(as)
ae.icon(at,ad.pages.theme.legacyIcon)
ae.label(at,ad.pages.theme.legacyIcons,ak.size+2*aj.padding)

local au,av=ae.box(at)local aw=function()


av.Visible=ac:getValue(ad.keys.legacyIcons)==true end


at.Activated:Connect(function()
local ax=ac:getValue(ad.keys.legacyIcons)~=true


if ax and ag.getcustomasset==nil then
ai:notify(ad.pages.theme.legacyTitle,ad.pages.theme.legacyNoCustomAsset)
end

ac:setValue(ad.keys.legacyIcons,ax)
ac:save()

ah:refresh()
aw()
end)

aw()

ae.header(as,ad.pages.theme.title)

local ax={}local ay=function()


local ay=ab.selectedKey

for az,aA in ax do
local aB=ay==aA.entry.key

aA.fill.Visible=aB
aA.swatchRow.Visible=aB

if aB and aA.redrawSwatches then
aA.redrawSwatches()
end
end end local az=function(


az)
ab:selectTheme(az.key)

ac:setValue(ad.keys.theme,az.key)
ac:save()

ay()end


for aA,aB in ab:getThemes()do
local aC=ae.row(as)

if aB.usable then
ae.label(aC,aB.name,ak.size+2*aj.padding)
aC.Activated:Connect(function()
az(aB)
end)
else
ae.label(aC,`{aB.name} {ad.pages.theme.incomplete}`,ak.size+2*aj.padding,"Colors.Text.Darker")
end

local aD,aE=ae.box(aC)

local aF={entry=aB,fill=aE}

if aB.usable then
local aG,aH=ap(as,aB,function(aG)
ab:setPrimary(aB.key,aG)
ay()
end)

aF.swatchRow=aG
aF.redrawSwatches=aH
else

local aG=aa.new("Frame","Primary",as.parent,{
Visible=false,
Size=UDim2.new(1,0,0,0),
BackgroundTransparency=1,
})

aF.swatchRow=aG
end

table.insert(ax,aF)
end

af.addSection(as)

ay()end


return aq end a.dI=function()local ab=a.cache.dI if not ab then ab={c=aa()}a.cache.dI=ab end return ab.c end end do local aa=function()










local aa=a.aM()
local ab=a.aK()
local ac=a.dj()
local ad=a.dG()

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
local an={}local ao=function()



local ao=ad.actionRow(al)
if ai.resetIcon then
ad.icon(ao,ai.resetIcon)
end
ad.label(ao,ai.reset,0)

ao.Activated:Connect(function()

for ap,aq in ak.stoppers do
aq()
end

for ap,aq in an do
for ar,as in ag(aq)do
aa:resetBinding(as)
end
end

for ap,aq in am do
aq()
end
end)end


if ai.resetAtTop then
ao()
end

for ap,aq in ai.groups do
if aq.title then
ad.header(al,aq.title)
end

table.insert(an,aq.key)

for ar,as in ag(aq.key)do
local at=ab.bindings[as]
local au=ad.row(al)

if at.icon then
ad.icon(au,at.icon)
end

ad.label(au,at.label or as,af.keybindWidth+2*ae.padding)

local av,aw=ad.keybind(au,as)
table.insert(am,av)
table.insert(ak.stoppers,aw)
end
end

local ap=ah(an)
if#ap>0 then
ad.note(al,table.concat(ap,"\n"))
end

if not ai.resetAtTop then
ao()
end
end end



return{
interface=ai({
title=ac.pages.keybinds.title,
reset=ac.pages.keybinds.reset,
resetIcon=ac.pages.keybinds.resetIcon,
groups={
{key="interface"},
},
}),

commands=ai({
title=ac.pages.commands.title,
reset=ac.pages.commands.reset,
resetIcon=ac.pages.commands.resetIcon,
resetAtTop=true,
groups=ab.groups,
}),
}end a.dJ=function()local ab=a.cache.dJ if not ab then ab={c=aa()}a.cache.dJ=ab end return ab.c end end do local aa=function()










local aa=a.cX()
local ab=a.c7()
local ac=a.dG()

local ad=a.aE()
local ae=a.a()
local af=a.dj()
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
return nil,nil,ai.empty
end

local an=ah.decode(am,"import")
if type(an)~="table"then
return nil,nil,ai.notAnExport
end

local ao={}

for ap,aq in aj do
if type(an[aq])=="table"then
table.insert(ao,aq)
end
end

if#ao==0 then
return nil,nil,ai.notAnExport
end

return an,ao end local an=function(



an, ao)
for ap,aq in ao do
ag[aq]:replaceData(an[aq])
end

local ap=ag.settings:getValue(af.keys.theme)
if al(ap)then
aa:selectTheme(ap)
end end local ao=function(


ao, ap)
local aq=ac.list(ao)
ac.pageTop(aq,ai.title,ap.back)


local ar local as=function()


local as=ak()

if ae.setclipboard then
ae.setclipboard(as)
ab:notify(ai.notifyTitle,ai.copied,nil,{copy=true,copyText=as})
else

ar.Text=as
ab:notify(ai.notifyTitle,ai.copyFailed)
end end local at=function()



local at,au,av=am(ar.Text)

if not at or not au then
ab:notify(ai.notifyTitle,av or ai.notAnExport)
return
end

ab:ask(ai.confirmTitle,string.format(ai.confirmMessage,table.concat(au,", ")),{
{
text=ai.confirmButton,
primary=true,
onTap=function()
an(at,au)
ar.Text=""

ab:notify(
ai.notifyTitle,
string.format(ai.imported,table.concat(au,", "))..". "..ai.restartNote
)
end,
},
{
text=ai.cancel,
onTap=function()end,
},
},ai.confirmTime)end


ac.buttonRow(aq,{
{icon=ai.exportIcon,text=ai.exportRow,onTap=as},
{icon=ai.importIcon,text=ai.importRow,onTap=at},
})

ar=ac.textBox(aq,ai.placeholder)
ar.MultiLine=true
ar.TextWrapped=true
ar.TextYAlignment=Enum.TextYAlignment.Top
ar.Size=UDim2.new(1,0,0,96)

ac.note(aq,ai.hint)end


return ao end a.dK=function()local ab=a.cache.dK if not ab then ab={c=aa()}a.cache.dK=ab end return ab.c end end do local aa=function()









local aa=a.p()
local ab=a.cD()
local ac=a.cJ()
local ad=a.dj()
local ae=a.c7()
local af=a.dG()

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


return al end a.dL=function()local ab=a.cache.dL if not ab then ab={c=aa()}a.cache.dL=ab end return ab.c end end do local aa=function()













local aa=a.bq()
local ab=a.af()
local ac=a.dj()
local ad=a.c7()
local ae=a.dG()

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


return al end a.dM=function()local ab=a.cache.dM if not ab then ab={c=aa()}a.cache.dM=ab end return ab.c end end do local aa=function()












local aa=a.cH()
local ab=a.cJ()
local ac=a.dj()
local ad=a.cF()
local ae=a.c7()
local af=a.dG()

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
local aD,aE=aa.addAll(ab)

if not aD then
au(aE or"")
return
end

local aF=string.format(ai.addedAll,#aD.added)

if#aD.failed>0 then
aF=aF..string.format(ai.failedAll,#aD.failed)

for aG,aH in aD.failed do
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


return ak end a.dN=function()local ab=a.cache.dN if not ab then ab={c=aa()}a.cache.dN=ab end return ab.c end end do local aa=function()












local aa=a.dg()
local ab=a.dj()
local ac=a.c7()
local ad=a.dG()

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


return am end a.dO=function()local ab=a.cache.dO if not ab then ab={c=aa()}a.cache.dO=ab end return ab.c end end do local aa=function()










local aa=a.aE()
local ab=a.n()
local ac=a.dj()
local ad=a.dG()

local ae=ac.panel
local af=ac.box
local ag=ac.pages.interface

local ah=aa.ui.scale local ai=function(


ai)
local aj=ah.minScale+ai*(ah.maxScale-ah.minScale)
return math.round(aj*100)/100 end local aj=function(


aj)
return math.clamp((aj-ah.minScale)/(ah.maxScale-ah.minScale),0,1)end local ak=function(


ak, al)
ab:setValue(ak,al)
ab:save()end local al=function(


al)
return ab:getValue(al)==true end local am=function(



am, an, ao, ap, aq)
local ar=ad.row(am)
ad.icon(ar,ao)
ad.label(ar,an,af.size+2*ae.padding)

local as,at=ad.box(ar)local au=function()


at.Visible=ap()end


ar.Activated:Connect(function()
aq(not ap())
au()
end)

au()end local an=function(


an, ao)
local ap=ad.list(an)
ad.pageTop(ap,ag.title,ao.back)

local aq=ao.actions

am(ap,ag.keepMenuOpen,ag.icons.keepMenuOpen,function()
return al(ac.keys.keepMenuOpen)
end,function(ar)
ak(ac.keys.keepMenuOpen,ar)

if ao.onSwitch then
ao.onSwitch("keepMenuOpen",ar)
end
end)

local ar=ad.row(ap)
ad.icon(ar,ag.icons.uiScale)

ad.slider(ar,ag.uiScale,aj(aq.getScale()),function(as)
aq.setScale(ai(as))
end,function(as)
return`{math.round(ai(as)*100)}%`
end)

am(ap,ag.transparent,ag.icons.transparent,function()
return al(ac.keys.transparentMinimized)
end,function(as)
ak(ac.keys.transparentMinimized,as)

if ao.onSwitch then
ao.onSwitch("transparentWhenMinimized",as)
end
end)

am(ap,ag.hide,ag.icons.hide,function()
return aq.isHidden()
end,function(as)
aq.setHidden(as)
end)end


return an end a.dP=function()local ab=a.cache.dP if not ab then ab={c=aa()}a.cache.dP=ab end return ab.c end end do local aa=function()









local aa=a.cY()
local ab=a.aJ()
local ac=a.n()
local ad=a.dj()
local ae=a.aE()
local af=a.f()
local ag=a.cP()
local ah=a.t()

local ai=a.dG()
local aj=a.dI()
local ak=a.dJ()
local al=a.dK()
local am=a.dL()
local an=a.dM()
local ao=a.dN()
local ap=a.dO()
local aq=a.dP()

local ar=ad.panel
local as=ad.box
local at=ad.row
local au=ad.value

local av=af.TweenService

local aw=ar.shownY
local ax=ar.hiddenY



local ay=ar.floatBackSize
local az=UDim2.new(1,-(ar.floatBackMargin+ar.scrollBarThickness),0,ar.floatBackMargin)
local aA=UDim2.fromOffset(ay,ay)
local aB=UDim2.fromOffset(ay*ar.floatBackFlat,ay)
local aC=UDim2.new(1,0,0,-ay*ar.floatBackOut)


local aD={
interface=aq,
theme=aj,
keybinds=ak.interface,
commands=ak.commands,
importExport=al,
aliases=am,
waypoints=an,
plugins=ao,
eventBinds=ap,
}

local aE={}
aE.__index=aE local aF=function(

aF, aG)
ac:setValue(aF,aG==true)
ac:save()end local aG=function(


aG)
return ac:getValue(aG)==true end local aH=function(


aH, aI, aJ)
aH:TweenPosition(aI,Enum.EasingDirection.InOut,Enum.EasingStyle.Quart,ar.tweenTime,true,aJ)end local aI=function(




aI, aJ)
if type(aI)~="number"then
return ad.userData.missing
end

if aJ.date then
return os.date(ad.userData.dateFormat,aI)
end

return tostring(aI)end local aJ=function(




aJ)
if aJ.placeCounts then
local aK=ah.user:getValue(aJ.placeCounts)

if type(aK)~="table"then
return nil
end

return aK[tostring(game.GameId)]
end

return ah.user:getValue(aJ.key)end


aE.isKeepMenuOpen=function()
return aG(ad.keys.keepMenuOpen)end


aE.isTransparentWhenMinimized=function()
return aG(ad.keys.transparentMinimized)end


aE.setKeepMenuOpen=function(aK)
aF(ad.keys.keepMenuOpen,aK)end


aE.isKeepIY=function()
return aG(ad.keys.keepIY)end


aE.setKeepIY=function(aK)
aF(ad.keys.keepIY,aK)end



aE.createOption=function(aK, aL, aM)
if aM.kind=="expand"then
aK:createExpandOption(aL,aM)
return nil
end

local aN=ai.row(aL)

if aM.icon then
ai.icon(aN,aM.icon)
end

if aM.kind=="switch"then
local aO=ad.keys[aM.setting]
ai.label(aN,aM.label,as.size+2*ar.padding)

local aP,aQ=ai.box(aN)local aR=function()


aQ.Visible=aG(aO)end


aN.Activated:Connect(function()
local aS=not aG(aO)
aF(aO,aS)
aR()

if aK.onSwitch then
aK.onSwitch(aM.setting,aS)
end
end)

aR()
return aR
end

if aM.kind=="keybind"then
ai.label(aN,aM.label,au.keybindWidth+2*ar.padding)

local aO,aP=ai.keybind(aN,aM.binding)
table.insert(aK.stoppers,aP)

return aO
end


local aO=aD[aM.action]~=nil

if aO then
ai.chevron(aN)
end

ai.label(aN,aM.label,if aO then at.chevronSize+2*ar.padding else 0)

aN.Activated:Connect(function()
if aD[aM.action]then
aK:openPage(aM.action)
elseif aK.onButton then
aK.onButton(aM.action)
end
end)

return nil end




aE.createExpandOption=function(aK, aL, aM)
local aN=ai.row(aL)

if aM.icon then
ai.icon(aN,aM.icon)
end

ai.label(aN,aM.label,at.chevronSize+2*ar.padding)
local aO=ai.chevron(aN)

local aP=ai.group(aL)
aP.Visible=false

local aQ=ai.list(aP)
local aR={}

for aS,aT in aM.items do
local aU=ai.row(aQ)
ai.label(aU,aT.label,au.userWidth+2*ar.padding)

local aV,aW=ai.value(aU,"",au.userWidth)
table.insert(aR,{item=aT,text=aW})
end local aS=function()


for aS,aT in aR do
aT.text.Text=aI(aJ(aT.item),aT.item)
end end


local aT=false

aN.Activated:Connect(function()
aT=not aT


aO.Rotation=if aT then 270 else 180
aP.Visible=aT

if aT then
aS()
end
end)end


aE.createOptions=function(aK)
local aL=ai.list(aK.panel)

for aM,aN in ad.sections do
ai.header(aL,aN.title)

for aO,aP in aN.options do
local aQ=aK:createOption(aL,aP)

if aQ then
table.insert(aK.refreshers,aQ)
end
end
end


local aM=ad.footer
:gsub("{name}",ae.applicationName)
:gsub("{version}",ae.version)

ai.footer(aL,aM)end


aE.createPages=function(aK)
for aL,aM in aD do
local aN=ai.page(aK.holder,`{aL}Page`,UDim2.fromScale(1,ax))


aN.Visible=false

aK.pages[aL]={
frame=aN,
build=aM,
}
end end


aE.new=function(aK)
return setmetatable({
onSwitch=aK.onSwitch,
onButton=aK.onButton,
onOpenChanged=aK.onOpenChanged,
actions=aK.interface or{},
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
},aE)end



aE.create=function(aK, aL, aM, aN)
local aO=aa.new("Frame","SettingsHolder",aL,{
AnchorPoint=aM.AnchorPoint,
BackgroundTransparency=1,
ClipsDescendants=true,
Position=aM.Position,
Size=aM.Size,


ZIndex=0,
Visible=false,
})

aK.holder=aO
aK.listArea=aM
aK.listParts=aN or{}
aK.panel=ai.page(aO,"Settings",UDim2.fromScale(0,ax))
aK.current=aK.panel

aK:createOptions()
aK:createPages()
aK:createFloatingBack(aO)

return aO end




aE.createFloatingBack=function(aK, aL)
local aM=aa.new("TextButton","FloatingBack",aL,{
AnchorPoint=Vector2.new(1,0),
AutoButtonColor=false,
BorderSizePixel=0,
Position=az,
Size=aA,
Text="",
Visible=false,
ZIndex=2,
ThemeTag={
BackgroundColor3="Colors.Buttons.Holding",
},

aa.new("UICorner",{
CornerRadius=UDim.new(0,au.cornerRadius),
}),
aa.new("UIStroke",{
ApplyStrokeMode=Enum.ApplyStrokeMode.Border,
Thickness=1,
ThemeTag={
Color="Colors.Border.Default",
},
}),
})


local aN=ai.icon(aM,ad.pages.backIcon)
aN.AnchorPoint=Vector2.new(0.5,0.5)
aN.Position=UDim2.fromScale(0.5,0.5)
aN.Size=UDim2.fromScale(at.iconSize/ar.floatBackSize,at.iconSize/ar.floatBackSize)
aN.ZIndex=aM.ZIndex+1

aM.Activated:Connect(function()
aK:back()
end)

aK.floatingBack=aM
aK.floatingIcon=aN end



aE.syncFloatingIcon=function(aK)
local aL,aM=aK.floatingIcon,aK.backIcon

if aL and aM and aM.Image~=""and aL.Image~=aM.Image then
aL.Image=aM.Image
end end




aE.updateFloatingBack=function(aK)
local aL=aK.floatingBack
if not aL then return end

local aM=aK.current
local aN=aK.backRow
local aO=false

if aK.isShown and aM~=aK.panel and aN and aN.Parent then
aO=aN.AbsolutePosition.Y+aN.AbsoluteSize.Y<=aM.AbsolutePosition.Y
end

if aO then
aK:syncFloatingIcon()
end

if aO==aK.floatingShown then return end

aK.floatingShown=aO

if aO then
aK:showFloatingBack()
else
aK:hideFloatingBack()
end end



aE.showFloatingBack=function(aK)
local aL=aK.floatingBack


if not aL.Visible then
aL.Position=aC
aL.Size=aB
aL.Visible=true
end

aK:tweenFloatingBack(az,aA,Enum.EasingStyle.Back,Enum.EasingDirection.Out)end



aE.hideFloatingBack=function(aK)
local aL=aK.floatingBack
if not aL.Visible then return end

aK:tweenFloatingBack(aC,aB,Enum.EasingStyle.Quart,Enum.EasingDirection.In,function()
aL.Visible=false
end)end




aE.tweenFloatingBack=function(aK, aL, aM, aN, aO, aP)
local aQ=aK.floatingBack
aK:stopFloatingTween()

local aR=ag:getScale(ar.floatBackTime)

if aR<=0 then
aQ.Position=aL
aQ.Size=aM

if aP then
aP()
end

return
end

local aS=av:Create(aQ,TweenInfo.new(aR,aN,aO),{
Position=aL,
Size=aM,
})

aK.floatingTween=aS

aS.Completed:Connect(function(aT)

if aT~=Enum.PlaybackState.Completed then return end

if aK.floatingTween==aS then
aK.floatingTween=nil
end

if aP then
aP()
end
end)

aS:Play()end


aE.stopFloatingTween=function(aK)
local aL=aK.floatingTween
if not aL then return end

aK.floatingTween=nil
aL:Cancel()end


aE.refresh=function(aK)
for aL,aM in aK.refreshers do
aM()
end end



aE.stopWaiting=function(aK)
for aL,aM in aK.stoppers do
aM()
end

for aL,aM in aK.pageStoppers do
aM()
end end



aE.buildPage=function(aK, aL)
ai.clear(aL.frame)
aK.pageStoppers={}

for aM,aN in aK.pageConnections do
aN:Disconnect()
end
table.clear(aK.pageConnections)

aL.build(aL.frame,{
back=function()
aK:back()
end,
stoppers=aK.pageStoppers,
actions=aK.actions,
onSwitch=aK.onSwitch,
})

aK.backRow=aL.frame:FindFirstChild("BackRow")
aK.backIcon=if aK.backRow then aK.backRow:FindFirstChild("Icon")else nil

if aK.backIcon then

table.insert(aK.pageConnections,aK.backIcon:GetPropertyChangedSignal("Image"):Connect(function()
aK:syncFloatingIcon()
end))

aK:syncFloatingIcon()
end

table.insert(aK.pageConnections,aL.frame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
aK:updateFloatingBack()
end))end





aE.hideWhenGone=function(aK, aL)
return function(aM)
if aM and aL~=aK.current then
aL.Visible=false
end
end end



aE.openPage=function(aK, aL)
local aM=aK.pages[aL]
if not aM or not aK.isShown or aK.current~=aK.panel then return end

aK:stopWaiting()


aM.frame.Visible=true
aK:buildPage(aM)

aM.frame.CanvasPosition=Vector2.zero
aM.frame.Position=UDim2.fromScale(1,aw)
aK.current=aM.frame

aH(aK.panel,UDim2.fromScale(-1,aw),aK:hideWhenGone(aK.panel))
aH(aM.frame,UDim2.fromScale(0,aw))

aK:updateFloatingBack()end



aE.back=function(aK)
if aK.current==aK.panel then return end

aK:stopWaiting()

local aL=aK.current
aK.panel.Visible=true

aH(aL,UDim2.fromScale(1,aw),aK:hideWhenGone(aL))
aH(aK.panel,UDim2.fromScale(0,aw))
aK.current=aK.panel

aK:updateFloatingBack()end



aE.reset=function(aK)
aK.current=aK.panel
aK.panel.Visible=true
aK.panel.Position=UDim2.fromScale(0,ax)

for aL,aM in aK.pages do
aM.frame.Visible=false
aM.frame.Position=UDim2.fromScale(1,ax)
end end


aE.toggle=function(aK)
aK.isOpen=not aK.isOpen
aK:setShown(aK.isOpen)


if aK.onOpenChanged then
aK.onOpenChanged(aK.isOpen)
end end




aE.setListShown=function(aK, aL)
for aM,aN in aK.listParts do
aN.Visible=aL
end

aK.listArea.Active=aL end


aE.setShown=function(aK, aL)
if not aK.panel or aK.isShown==aL then return end

aK.isShown=aL
local aM=aK.current

aK:updateFloatingBack()

if aL then
aK.holder.Visible=true


aK:setListShown(false)
aH(aM,UDim2.fromScale(0,aw))
return
end

aK:stopWaiting()

aH(aM,UDim2.fromScale(0,ax),function(aN)
if aN and not aK.isShown then
aK.holder.Visible=false


aK:setListShown(true)


if not aK.isOpen then
aK:reset()
end
end
end)end


aE.watchCommandBar=function(aK, aL)
ab:Connect(aL.Focused,function()
aK:setShown(false)
end)

ab:Connect(aL.FocusLost,function()
aK:setShown(aK.isOpen)
end)end


return aE end a.dQ=function()local ab=a.cache.dQ if not ab then ab={c=aa()}a.cache.dQ=ab end return ab.c end end do local aa=function()





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
}end a.dR=function()local ab=a.cache.dR if not ab then ab={c=aa()}a.cache.dR=ab end return ab.c end end do local aa=function()







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


return ae end a.dS=function()local ab=a.cache.dS if not ab then ab={c=aa()}a.cache.dS=ab end return ab.c end end do local aa=function()







local aa=a.cY()
local ab=a.c2()
local ac=a.cX()
local ad=a.c7()
local ae=a.dw()
local af=a.b5()

local ag=a.aJ()
local ah=a.af()
local ai=a.a()
local aj=a.dR()

local ak=a.dS()
local al=a.c6()
local am=a.b6()

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

ab:loadImage(aD,"lucide-custom-x")

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


return au end a.dT=function()local ab=a.cache.dT if not ab then ab={c=aa()}a.cache.dT=ab end return ab.c end end do local aa=function()















































local aa=a.f()
local ab=a.aJ()
local ac=a.cP()

local ad=aa.TweenService
local ae=aa.UserInputService
local af=aa.RunService

local ag=0.32
local ah=0.5
local ai=0.1
local aj=10
local ak=30
local al=10
local am=2
local an=1
local ao=800
local ap=0.3
local aq=20
local ar=3
local as=0.5


local at=0.2
local au=0.5
local av=1

local aw={
[Enum.UserInputType.MouseButton1]=true,
[Enum.UserInputType.Touch]=true,
}

local ax={}
ax.__index=ax















ax.new=function(ay)
local az=setmetatable({
frame=ay.frame,
screenGui=ay.screenGui,
topBarHeight=ay.topBarHeight,
clampPosition=ay.clampPosition,
getScale=ay.getScale,
onMinimize=ay.onMinimize,
onInteractive=ay.onInteractive,

hoverToOpen=ay.hoverToOpen==true and ae.MouseEnabled,
commandBarInUse=ay.commandBarInUse,
isMoving=ay.isMoving,
lastMovingAt=-math.huge,
transparentWhenMinimized=ay.transparentWhenMinimized==true,
fade=nil,

state="minimized",
interactive=nil,
hovering=false,
hoverRequest=0,
dragging=false,
keepOpen=ay.keepOpen==true,
windowParts={},
tween=nil,
press=nil,
touches={},
outsideTouches={},
swipeLocked=false,
lastInteractionAt=-math.huge,
connections={},
},ax)

az.frame.Position=az:targetFor("minimized")
az:fadeTo("minimized")

table.insert(az.connections,ab:Connect(ae.InputBegan,function(aA)
az:onInputBegan(aA)
end))

table.insert(az.connections,ab:Connect(ae.InputEnded,function(aA)
az:onInputEnded(aA)
end))

table.insert(az.connections,ab:Connect(ae.InputChanged,function(aA)
az:onInputChanged(aA)
end))


table.insert(az.connections,ab:Connect(af.Heartbeat,function()
if az.isMoving and az.isMoving()then
az.lastMovingAt=os.clock()
end

az:checkLockIdle()
end))

az:setInteractive(false)

if az.hoverToOpen then

table.insert(az.connections,ab:Connect(az.frame.MouseEnter,function()
if az.frame.Visible then az:setHovering(true)end
end))

table.insert(az.connections,ab:Connect(az.frame.MouseLeave,function()
az:setHovering(false)
end))
end

return az end local ay=function(


ay, az)
local aA=ay.AbsolutePosition
local aB=ay.AbsoluteSize

return az.X>=aA.X and az.X<=aA.X+aB.X
and az.Y>=aA.Y and az.Y<=aA.Y+aB.Y end



ax.isOverWindow=function(az, aA)
if ay(az.frame,aA)then
return true
end

for aB,aC in az.windowParts do
if ay(aC,aA)then
return true
end
end

return false end



ax.addWindowPart=function(az, aA)
table.insert(az.windowParts,aA)end



ax.setKeepOpen=function(az, aA)
az.keepOpen=aA==true

if az.keepOpen and az.state=="minimized"then
az:expand()
end end



ax.reveal=function(az)

az:lockSwipe()

if az.state=="minimized"then
az:expand()
end end






ax.lockSwipe=function(az)
if az.hoverToOpen then return end
if not az:fingerOutsideWindow()then return end

az.swipeLocked=true
az.lastInteractionAt=os.clock()end



ax.fingerOutsideWindow=function(az)
for aA,aB in az.touches do
if not az:isOverWindow(aB)then
return true
end
end

return false end



ax.unlockSwipe=function(az)
az.swipeLocked=false end




ax.noteInteraction=function(az)
az.lastInteractionAt=os.clock()end




ax.checkLockIdle=function(az)
if az.swipeLocked and os.clock()-az.lastInteractionAt>=ar then
az.swipeLocked=false
end end



ax.onSettled=function(az, aA)
local aB=az.tween

if aB and aB.PlaybackState==Enum.PlaybackState.Playing then
aB.Completed:Once(aA)
else
task.defer(aA)
end end



ax.targetFor=function(az, aA)
local aB=az.clampPosition(az.frame.Position).X

if aA=="top"then

return UDim2.new(aB.Scale,aB.Offset,0,0)
end

if aA=="expanded"then

return UDim2.new(aB.Scale,aB.Offset,1,-az.frame.Size.Y.Offset)
end


return UDim2.new(aB.Scale,aB.Offset,1,-az.topBarHeight)end




ax.clampDrag=function(az, aA)
local aB=az.clampPosition(aA).X

local aC=math.max(az.getScale(),0.01)
local aD=az.screenGui.AbsoluteSize.Y/aC
local aE=math.max(aD-az.topBarHeight,0)
local aG=math.clamp(aA.Y.Scale*aD+aA.Y.Offset,0,aE)

return UDim2.new(aB.Scale,aB.Offset,0,aG)end



ax.wasMovingRecently=function(az)
return os.clock()-az.lastMovingAt<as end



ax.setInteractive=function(az, aA)
if az.interactive==aA then return end
az.interactive=aA

if az.onInteractive then
az.onInteractive(aA)
end end


ax.cancel=function(az)
if az.tween then
az.tween:Cancel()
az.tween=nil
end end




ax.transparencyFor=function(az, aA)
if aA=="minimized"and az.transparentWhenMinimized then
return ah
end

return 0 end




ax.fadeTo=function(az, aA, aB)
if az.fade then
az.fade:Cancel()
az.fade=nil
end

local aC=az:transparencyFor(aA)

if aB==nil then
az.frame.GroupTransparency=aC
return
end

local aD=ad:Create(az.frame,aB,{GroupTransparency=aC})
az.fade=aD
aD:Play()end


ax.moveTo=function(az, aA, aB, aC)

if aA==az.state and az.tween and az.tween.PlaybackState==Enum.PlaybackState.Playing then
return
end

local aD=az.state=="minimized"
az.state=aA
az:cancel()


if aA=="minimized"then
az.swipeLocked=false
elseif aD then
az:lockSwipe()
end


if aA=="minimized"then
az:setInteractive(false)
end

local aE=az:targetFor(aA)
local aG=ac:getScale(aB or ag)

if aG<=0 then
az.frame.Position=aE
az:fadeTo(aA)
az:setInteractive(aA~="minimized")
return
end

local aH=TweenInfo.new(aG,Enum.EasingStyle.Quart,aC or Enum.EasingDirection.Out)
az:fadeTo(aA,aH)
local aI=ad:Create(az.frame,aH,{Position=aE})
az.tween=aI



aI.Completed:Connect(function(aJ)
if aJ~=Enum.PlaybackState.Completed then return end
if az.tween~=aI or az.state=="minimized"then return end

az:setInteractive(true)
end)

aI:Play()end


ax.expand=function(az, aA, aB)
az:moveTo("expanded",aA,aB)end




ax.setHovering=function(az, aA)
if aA==az.hovering then return end
az.hovering=aA


if az.dragging then return end

if aA then
az:onHoverEnter()
else
az:onHoverLeave()
end end




ax.onHoverEnter=function(az)
az.hoverRequest=az.hoverRequest+1

if az.state=="minimized"then
az:expand(at,Enum.EasingDirection.InOut)
end end




ax.onHoverLeave=function(az)
az.hoverRequest=az.hoverRequest+1
local aA=az.hoverRequest

if not az:canHoverMinimize()then return end

task.delay(av,function()
if aA~=az.hoverRequest or not az:canHoverMinimize()then return end

az:minimize(au,Enum.EasingDirection.InOut)
end)end



ax.canHoverMinimize=function(az)
return az.state=="expanded"and not az.keepOpen and not az:commandBarBusy()end







ax.onCommandBarClosed=function(az, aA)
if not az.hoverToOpen then return end


if az:fingerOnWindow()then return end

local aB=az.hoverRequest
task.wait()


if aB~=az.hoverRequest or az.dragging or not az:canHoverMinimize()then return end
if az.hovering and not aA then return end
if az:fingerOnWindow()then return end

az:minimize(au,Enum.EasingDirection.InOut)end





ax.onMobileEnter=function(az, aA)
if az.hoverToOpen then return end



if not az:wasMovingRecently()then return end

task.wait()

if az.dragging or aA()then return end
if az.state~="expanded"or az.keepOpen then return end

az:minimize()end





ax.setDragging=function(az, aA)
local aB=az.dragging
az.dragging=aA==true



if aB and not az.dragging and az.hoverToOpen and not az.hovering then
az:onHoverLeave()
end end




ax.setTransparentWhenMinimized=function(az, aA)
az.transparentWhenMinimized=aA==true
az:fadeTo(az.state)end


ax.minimize=function(az, aA, aB)

if az.onMinimize then
az.onMinimize()
end

az:moveTo("minimized",aA,aB)end



ax.reflow=function(az)
az:cancel()
az.frame.Position=az:targetFor(az.state)
az:fadeTo(az.state)
az:setInteractive(az.state~="minimized")end




ax.sleep=function(az)
az:cancel()
az.state="minimized"
az.swipeLocked=false
az.frame.Position=az:targetFor("minimized")
az:fadeTo("minimized")
az:setInteractive(false)end




ax.onDragEnded=function(az, aA)
if aA.travel<=aj then

az:moveTo(az.state)
return
end


local aB=math.abs(aA.dy)>=am*math.abs(aA.dx)
local aC=aB and aA.dy<=-al
local aD=aB and aA.dy>=al

if az.state=="minimized"then

if aC then
az:moveTo("expanded")
else
az:moveTo("minimized")
end
return
end


if aC then
az:moveTo("top")
return
end


if aD and az:isSlideDownMinimize(aA)then
az:minimize()
return
end

if aD then
az:moveTo("expanded")
return
end


az:moveTo(az.state)end




ax.isSlideDownMinimize=function(az, aA)
if aA.dy>=ak and aA.velocityY>=ao then
return true
end

return az.frame.AbsolutePosition.Y>=az:minimizedTop()-an end




ax.minimizedTop=function(az)
local aA=math.max(az.getScale(),0.01)
return az.screenGui.AbsoluteSize.Y-az.topBarHeight*aA end






ax.onListSwipeDown=function(az, aA)
if az.hoverToOpen or az.swipeLocked then return end
if az.state=="minimized"or az:commandBarBusy()then return end

if az.state=="top"then
if(aA or 0)>=az:minimizedTop()-an then
az:minimize()
end
return
end

az:minimize()end



ax.commandBarBusy=function(az)
return az.commandBarInUse~=nil and az.commandBarInUse()==true end



ax.fingerOnWindow=function(az)
for aA,aB in az.touches do
if az:isOverWindow(aB)then
return true
end
end

return false end



ax.onInputChanged=function(az, aA)
if aA.UserInputType~=Enum.UserInputType.Touch then return end
if az.touches[aA]==nil then return end

az.touches[aA]=aA.Position

if az:isOverWindow(aA.Position)then
az:noteInteraction()
end

local aB=az.outsideTouches[aA]
if aB and(aA.Position-aB).Magnitude>=aq then
az:onOutsideSwipe()
end end





ax.onOutsideSwipe=function(az)
if az.hoverToOpen or az.dragging or az.swipeLocked then return end
if az.state~="expanded"or az.keepOpen or az:commandBarBusy()then return end

table.clear(az.outsideTouches)
az:minimize()end


ax.onInputBegan=function(az, aA)
if aA.UserInputType==Enum.UserInputType.Touch then
az.touches[aA]=aA.Position

if az:isOverWindow(aA.Position)then
az:noteInteraction()
else
az.outsideTouches[aA]=aA.Position
end
end

if not aw[aA.UserInputType]then return end

az.press={
type=aA.UserInputType,
time=os.clock(),
position=aA.Position,
inside=az:isOverWindow(aA.Position),

startedExpanded=az.state=="expanded",
}end



ax.onInputEnded=function(az, aA)
if aA.UserInputType==Enum.UserInputType.Touch then
az.touches[aA]=nil
az.outsideTouches[aA]=nil
end

local aB=az.press
if not aB or aA.UserInputType~=aB.type then return end
az.press=nil

local aC=os.clock()-aB.time
local aD=(aA.Position-aB.position).Magnitude

if aB.inside then

if aC<=ai and aD<=aj and az.state=="minimized"then
az:expand()
end

return
end



local aE=aC<=ap and aD<=aj

if aE and aB.startedExpanded and not az.hoverToOpen and az.state=="expanded"and not az.keepOpen
and not az:commandBarBusy()and not az:wasMovingRecently()then
az:minimize()
end end


ax.destroy=function(az)
az:cancel()
az.hoverRequest=az.hoverRequest+1

for aA,aB in az.connections do
ab:disconnect(aB)
end
table.clear(az.connections)
table.clear(az.touches)
table.clear(az.outsideTouches)end


return ax end a.dU=function()local ab=a.cache.dU if not ab then ab={c=aa()}a.cache.dU=ab end return ab.c end end do local aa=function()



local aa=a.aE()
local ab=a.c4()
local ac=a.b()
local ad=a.a()
local ae=a.aJ()
local af=a.aM()
local ag=a.f()
local ah=a.b4()

local ai=a.af()

local aj=a.n()
local ak=a.d()
local al=a.b6()

local am=a.cY()
local an=a.c2()
local ao=a.cX()
local ap=a.dk()

local aq=a.cV()
local ar=a.b5()
local as=a.c7()

local at=a.dm()
local au=a.c3()
local av=a.dn()

local aw=a.dp()
local ax=a.ds()
local ay=a.du()
local az=a.dB()
local aA=a.dD()
local aB=a.dF()
local aC=a.dQ()
local aD=a.dT()

local aE=a.dw()
local aG=a.dU()

local aH=450
local aI=au.uiScale

local aJ={
awoken=false,
}local aK=function(

aK)
local aL=type(aK)=="string"and aq[aK:lower()]

if aL and aL.Colors and aL.Font then
return aK
end

return aa.theme.defaultTheme end local aL=function(


aL, aM, aN, aO)
local aP=(aL.Scale*aN)/aO+aL.Offset
local aQ=math.floor(aN/aO-aM)

if math.floor(aP)>=aQ then
return 1,-aM
end

return 0,math.clamp(math.floor(aP),0,math.max(aQ,0))end


aJ.awake=function(aM)
if aM.awoken then
return aM.screenGui
end

aM.awoken=true

aM:setupTheme()
aM:setupScreenGui()
aM:setupScale()
aM:setupMainFrame()
aM:createQuickCapture()
aM:createReference()
aM:createPartPath()
aM:createNotifications()
aM:setupListeners()
aM:updateNotificationsPosition()

ak:log("interface started")
return aM.screenGui end


aJ.setupTheme=function(aM)
ak:debug("interface: initializing theme service")

ao:init({
theme=aK(aa.theme.selectedTheme),
})end


aJ.setupScreenGui=function(aM)
local aN=aM:createScreenGui()

aN.Parent=ar
ac.screenGui=aN

aI.Parent=aN end


aJ.setupScale=function(aM)
aM:setScale(aj:getValue("interface.uiScale")or 1)end


aJ.setupMainFrame=function(aM)
local aN=aM:createMainFrame()

aM:createCommands()
aM:dragMainFrame(aN)
aM.commands:enable()

aN.Parent=aM.screenGui end


aJ.setupListeners=function(aM)
ae:Connect(aM.screenGui:GetPropertyChangedSignal("AbsoluteSize"),function()
aM:updateMainFramePosition()
end)

ae:Connect(aM.mainFrame:GetPropertyChangedSignal("AbsolutePosition"),function()
aM:updateNotificationsPosition()
end)

ae:Connect(aM.mainFrame:GetPropertyChangedSignal("AbsoluteSize"),function()
aM:updateNotificationsPosition()
end)

ae:Connect(ag.RunService.RenderStepped,function()
aM:updateNotificationsPosition()
end)end


aJ.createScreenGui=function(aM)
local aN=am.new("ScreenGui",{
IgnoreGuiInset=true,
Name=al.randomString(math.random(30,50)),
DisplayOrder=2147483647,
})

aM.screenGui=aN
return aN end


aJ.calculateScale=function(aM, aN)
return(aM.screenGui.AbsoluteSize.Y/aH)*aN end


aJ.setScale=function(aM, aN)
aN=math.abs(aN)

if aN>=3 then
aN=aM:calculateScale(aN)
end

if aj:getValue("interface.uiScale")~=aN then
aj:setValue("interface.uiScale",aN)
aj:save()
end

au:setScale(aN)
aM:updateMainFramePosition()end


aJ.calculateMainFramePosition=function(aM, aN)
local aO=aM.mainFrame
local aP=aM.screenGui
local aQ=au:getScale()
local aR=aO.Size

aN=aN or aO.Position

local aS,aT=aL(aN.X,aR.X.Offset,aP.AbsoluteSize.X,aQ)
local aU,aV=aL(aN.Y,aR.Y.Offset,aP.AbsoluteSize.Y,aQ)

return UDim2.new(aS,aT,aU,aV)end


aJ.updateMainFramePosition=function(aM)
if not aM.mainFrame then return end

if aM.dock then
aM.dock:reflow()
else
aM.mainFrame.Position=aM:calculateMainFramePosition()
end

aM:updateNotificationsPosition()end


aJ.createMainScroll=function(aM, aN)
local aO=ax.new({
isHorizontal=false,
barThickness=12,
})

local aP=aO:create()
local aQ=aO.container

local aR=am.new("Frame","ScrollHolder",aN,{
Size=UDim2.new(1,0,0,180),
Position=UDim2.fromScale(0.5,1),
AnchorPoint=Vector2.new(0.5,1),
BackgroundTransparency=1,
Active=true,

aP,
aQ,
})

aM.scrollHolder=aR
aM.scrollBar=aO
aM.scrollContainer=aQ
aM.scrollBarFrame=aP

return aO end


aJ.createMainFrame=function(aM)
local aN=aw:create()
local aO=aN.mainFrame

aN.titleLabel.Text=at.getDisplayName()

aM.mainFrame=aO
aM.topBar=aN.topBar
aM.buttons=aN.buttons


ap:attach(aO,aN.background)

an:loadImage(aM.buttons.settings,"lucide-settings")
an:loadImage(aM.buttons.reference,"lucide-book-open")

aM:createMainScroll(aO)

aM.settings=aC.new({

onOpenChanged=function(aP)
aM:paintTopButton(aM.buttons.settings,aP)
end,


onSwitch=function(aP,aQ)
if aP=="keepMenuOpen"and aM.dock then
aM.dock:setKeepOpen(aQ)
end

if aP=="transparentWhenMinimized"and aM.dock then
aM.dock:setTransparentWhenMinimized(aQ)
end


if aP=="keepIY"and aQ and ad.queueteleport==nil then
aM:setKeepIY(false)
as:notify("Keepiy","your exploit does not support queueteleport")
end
end,


interface={
getScale=function()
return au:getScale()
end,

setScale=function(aP)
aM:setScale(aP)
end,

isHidden=function()
return aM:isHidden()
end,

setHidden=function(aP)
aM:setHidden(aP)
end,
},
})
aM.settings:create(aO,aM.scrollHolder,{aM.scrollContainer,aM.scrollBarFrame})

ae:Connect(aM.buttons.settings.Activated,function()
aM.settings:toggle()
end)

return aO end


aJ.createCommands=function(aM)
local aN=aM.scrollBar

local aO=ay.new({
scrolledSignal=aN.scrolledSignal,
scrollContainer=aM.scrollContainer,
scrollHolder=aM.scrollHolder,
screenGui=aM.screenGui,
scrollBar=aN,

configs={
placeholderText=aa.ui.commands.placeholderText,
padding=aa.ui.commands.padding,
labelSize=aa.ui.commands.labelSize,
textSize=aa.ui.commands.textSize,
},
})

ak:log("created commands interface")
aO:create()

ak:log("initialized commands")
aO:createCommandsData()

ak:log("awaked commands module")
aO:awake()

aM.commands=aO


aO.onCommandSent=function()
if aM.dock then
aM.dock:unlockSwipe()
end
end


aO.onInteraction=function()
if aM.dock then
aM.dock:noteInteraction()
end
end

aM.settings:watchCommandBar(aO.searchBox)

if ah then

aO.onSwipeDown=function(aP)
if aM.dock then
aM.dock:onListSwipeDown(aP)
end
end

ae:Connect(aO.searchBox.Focused,function()
aM.commandBarUsedAt=os.clock()
end)

ae:Connect(aO.searchBox.FocusLost,function(aP)
aM.commandBarUsedAt=os.clock()


if aP and aM.dock then
aM.dock:onMobileEnter(function()
return aO.searchBox:IsFocused()
end)
end
end)
else

ae:Connect(aO.searchBox.FocusLost,function(aP)
if aM.dock then
aM.dock:onCommandBarClosed(aP)
end
end)
end

return aO end


aJ.createInfoMenu=function(aM)
return aA:create()end


aJ.chatLogs=function(aM, aN)
return aB:open(aN or"chat")end


aJ.dragMainFrame=function(aM, aN)
aN.Size=aa.ui.window.windowSize

aN.Position=UDim2.fromOffset(1e5,1e5)
aN.Position=aM:calculateMainFramePosition()

aM.dock=aG.new({
frame=aN,
screenGui=aM.screenGui,
topBarHeight=aM.topBar.Size.Y.Offset,
keepOpen=aC.isKeepMenuOpen(),
transparentWhenMinimized=aC.isTransparentWhenMinimized(),
clampPosition=function(aO)
return aM:calculateMainFramePosition(aO)
end,
getScale=function()
return au:getScale()
end,
commandBarInUse=function()
return aM:isCommandBarInUse()
end,
isMoving=function()
return aM:isCharacterMoving()
end,
onInteractive=function(aO)
if aM.commands then
aM.commands:setInteractive(aO)
end
end,
hoverToOpen=not ah,
onMinimize=function()
aM:releaseCommandFocus()


if aM.hidden then
aM:hideWindow()
end
end,
})

aE:addGuiObject(aN)

aE:setFilter(aN,function(aO)
return aM.dock:clampDrag(aO)
end)

aE.dragStarted:Connect(function(aO)
if aO~=aN then return end

aM.dock:cancel()
aM.dock:setDragging(true)
aM.scrollBar:disableScroll()
end)

aE.dragEnded:Connect(function(aO,aP)
if aO~=aN then return end

aM.scrollBar:enableScroll()
aM.dock:setDragging(false)
aM.dock:onDragEnded(aP)
end)end



local aM=0.3

aJ.isCommandBarInUse=function(aN)
local aO=aN.commands and aN.commands.searchBox
if aO and aO:IsFocused()then
return true
end

return os.clock()-(aN.commandBarUsedAt or 0)<aM end




aJ.isCharacterMoving=function(aN)
local aO=ai:getHumanoid()
if not aO then return false end

if aO.MoveDirection.Magnitude>0.05 then
return true
end

local aP=aO.RootPart
if not aP then return false end

local aQ=aP.AssemblyLinearVelocity
return Vector3.new(aQ.X,0,aQ.Z).Magnitude>1 end


aJ.releaseCommandFocus=function(aN)
local aO=aN.commands and aN.commands.searchBox

if aO and aO:IsFocused()then
aO:ReleaseFocus()
end end



aJ.showWindow=function(aN)
aN.hidden=false
aN:stopShowKeys()
aN:revealWindow()end




aJ.revealWindow=function(aN)
if not aN.mainFrame then return end

aN.mainFrame.Visible=true
if aN.dock then
aN.dock:reveal()
end end



aJ.hideWindow=function(aN)
if not aN.mainFrame then return end

aN.hidden=true
aN.mainFrame.Visible=false

if aN.dock then
aN.dock:sleep()
end

aN:releaseCommandFocus()
aN:listenForShowKeys()end



aJ.isHidden=function(aN)
return aN.hidden==true end



aJ.setHidden=function(aN, aO)
if aO then
aN:hideWindow()
else
aN:showWindow()
end end




aJ.listenForShowKeys=function(aN)
aN:stopShowKeys()

aN.showKeysConnection=af:onBindingPressed("prefix",function()

if aN.mainFrame and aN.mainFrame.Visible then return end

aN:showCommandBar()
end)end


aJ.stopShowKeys=function(aN)
local aO=aN.showKeysConnection
if aO==nil then return end

aN.showKeysConnection=nil
aO:Disconnect()end


aJ.showCommandBar=function(aN)
local aO=aN.commands and aN.commands.searchBox
if not aO then return end

aN:revealWindow()



aN.dock:onSettled(function()
if aN.dock.state=="minimized"then return end

aN.commands:ensureFocus()
end)end



aJ.setKeepIY=function(aN, aO)
aC.setKeepIY(aO)

if aN.settings then
aN.settings:refresh()
end end


aJ.createQuickCapture=function(aN)
if not ah then return end

local aO=am.new("TextButton",al.randomString(math.random(30,50)),aN.screenGui,{
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
am.new("UICorner",{
CornerRadius=UDim.new(0.5,0)
}),
})

aN.dock:addWindowPart(aO)
aE:addGuiObject(aO)

ae:Connect(aO.Activated,function()
aN:showCommandBar()
end)

aN.quickCapture=aO
return aO end




aJ.paintTopButton=function(aN, aO, aP)
if not aO then return end

ao:addObject(aO,{
ImageColor3=if aP then"Colors.Primary"else"Colors.Icons",
})end


aJ.createReference=function(aN)
local aO=az.new()
local aP=aO:create()

aO.onOpenChanged=function(aQ)
aN:paintTopButton(aN.buttons.reference,aQ)
end

an:loadImage(aO.closeIcon,"lucide-custom-x")

aP.Parent=aN.screenGui
aN.reference=aO

ae:Connect(aN.buttons.reference.Activated,function()
aO:open()
end)

return aO end


aJ.createPartPath=function(aN)
local aO=aD.new()
local aP=aO:create()

aP.Parent=aN.screenGui
aN.partPathWindow=aO

return aO end




aJ.openPartPath=function(aN, aO)
if not aN.partPathWindow then return end

aN.partPathWindow:open(aO)end


aJ.createNotifications=function(aN)
local aO=as:getContainer(aN.screenGui)
aN.notificationsContainer=aO

as.onLayoutChanged=function()
aN:updateNotificationsPosition()
end

aN:updateNotificationsPosition()
return aO end


aJ.updateNotificationsPosition=function(aN)
local aO=aN.notificationsContainer
local aP=aN.mainFrame
local aQ=aN.screenGui
if not(aO and aP and aQ)then return end



local aR=au:getScale()
local aS=aQ.AbsoluteSize/aR

local aT=aP.Position
local aU=av.compute({
x={scale=aT.X.Scale,offset=aT.X.Offset},
y={scale=aT.Y.Scale,offset=aT.Y.Offset},
width=aP.Size.X.Offset,
height=aP.Size.Y.Offset,
},{
width=aS.X,
height=aS.Y,
},{
width=aO.Size.X.Offset,
},ab.gapToWindow)


as:setRoom(aU.room)

aO.AnchorPoint=Vector2.new(aU.anchorX,aU.anchorY)
aO.Position=UDim2.new(aU.x.scale,aU.x.offset,aU.y.scale,aU.y.offset)end


aJ.destroy=function(aN)
aN:stopShowKeys()
as:destroy()
if aN.dock then
aN.dock:destroy()
aN.dock=nil
end

aB:reset()

if aN.partPathWindow then
aN.partPathWindow:destroy()
aN.partPathWindow=nil
end

if aN.screenGui then
aN.screenGui:Destroy()
end

aN.screenGui=nil
aN.awoken=false end


return aJ end a.dV=function()local ab=a.cache.dV if not ab then ab={c=aa()}a.cache.dV=ab end return ab.c end end do local aa=function()a.e()


:init()a.u()





local aa=a.c9()
local ab=a.db()
local ac=a.af()
local ad=a.cM()
local ae=a.dh()
local af=a.cG()
local ag=a.df()



local ah=a.dV()

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


return ai end a.dW=function()local ab=a.cache.dW if not ab then ab={c=aa()}a.cache.dW=ab end return ab.c end end end




















return a.dW():boot()