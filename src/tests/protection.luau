local old_newindex
local old_index
local old_call

local hookedFlags   = setmetatable({}, {__mode = "k"})
local hookedValues  = setmetatable({}, {__mode = "k"})
local hiddenObjects = setmetatable({}, {__mode = "k"})

local FAKE_OBJECTS = {"Folder", "MeshPart", "Decal", "Attachment"}

local function isHooked(object, property)
	local flags = hookedFlags[object]
	return flags ~= nil and flags[property] == true
end

local function isProtected(object)
	return hiddenObjects[object] ~= nil
end

local new_newindex = hookmetamethod(game, "__newindex", function(self, index, value)
	local isHide = hiddenObjects[self]

	if isHide == nil then
		if isHooked(self, index) then
			hookedValues[self][index] = value
			return
		end
		return old_newindex(self, index, value)
	end

	return old_newindex(isHide.fakeObject, index, value)
end)

local new_index = hookmetamethod(game, "__index", function(self, index)
	local isHide = hiddenObjects[self]

	if isHide == nil then
		if isHooked(self, index) then
			return hookedValues[self][index]
		end
		
		return old_index(self, index)
	end

	return old_index(isHide.fakeObject, index)
end)

local new_call = hookmetamethod(game, "__call", function(self, ...)
	local isHide = hiddenObjects[self] ~= nil
	if isHide ~= nil then return old_call(self, isHide.fakeObject, ...) end
	
	local result = old_call(self, ...)
	local hidden = hiddenObjects[result]
	return if hidden ~= nil then hidden.fakeObject else result
end)

local function init()
	if getgenv().ORIGINAL_NEWINDEX == nil then getgenv().ORIGINAL_NEWINDEX = new_newindex end
	if getgenv().ORIGINAL_INDEX    == nil then getgenv().ORIGINAL_INDEX    = new_index    end
	if getgenv().ORIGINAL_CALL     == nil then getgenv().ORIGINAL_CALL     = new_call     end

	old_newindex = getgenv().ORIGINAL_NEWINDEX
	old_index    = getgenv().ORIGINAL_INDEX
	old_call     = getgenv().ORIGINAL_CALL

	print(`original: {old_index}, {old_newindex}, {old_call}`)
end

local function getObjectProperty(object, property)
	return old_index(object, property)
end

local function setObjectProperty(object, property, value)
	if hookedFlags[object]  == nil then hookedFlags[object]  = {} end
	if hookedValues[object] == nil then hookedValues[object] = {} end

	if not hookedFlags[object][property] then
		hookedFlags[object][property]  = true
		hookedValues[object][property] = getObjectProperty(object, property)
	end

	return old_newindex(object, property, value)
end

local function createRandomObject()
	return Instance.new(FAKE_OBJECTS[math.random(#FAKE_OBJECTS)])
end

local function hideObject(object)
	assert(object ~= nil and hiddenObjects[object] == nil, "this object is already protected")
	
	hiddenObjects[object] = {
		fakeObject = createRandomObject()
	}
	
	return object
end

local function createHiddenObject(className, props)
	local object, parent = Instance.new(className)
	
	for prop, value in props or {} do
		if prop == "Parent" then parent = value continue end
		object[prop] = value
	end
	
	hideObject(object)
	object.Parent = parent
	
	return object
end

local function benchmark()
	local protected = workspace:FindFirstChild("protected") or Instance.new("Folder")
	protected.Name = "protected"
	protected.Parent = workspace

	local part = createHiddenObject("Part", {
		Name = `Part{#protected:GetChildren() + 1}`,
		Anchored = true
	})
	
	part.Parent = protected

	print(part)
	print(part.Name, part.ClassName) -- "Folder"/"MeshPart"/"Decal" (fake)

	local localPlayer = game:GetService("Players").LocalPlayer
	local humanoid = localPlayer.Character.Humanoid

	print("the current walkspeed is:", humanoid.WalkSpeed)

	print("hooking walkspeed...")
	setObjectProperty(humanoid, "WalkSpeed", 100)

	print(`now the walkspeed is... {humanoid.WalkSpeed}?`)                            -- 16 (fake via hook)
	print(`nahh, the real walkspeed is: {getObjectProperty(humanoid, "WalkSpeed")}`)  -- 100 (real)
end

init()
benchmark()