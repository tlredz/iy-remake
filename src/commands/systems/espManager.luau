-- Generic ESP used by esp, espteam, chams and partesp (see cmds/visual/esp.luau).
-- Based on the EspManager from redzHub, adapted to the remake:
--   * no globals from that script (Vector3_new, task_wait, DistanceFromMyCharacter...), uses the remake's services
--   * one update loop per manager instead of one loop per object
--   * the BoxHandleAdornment gets an Adornee (the original never set it, so the box was never drawn)
--   * the source can be a function, because the list of players changes over time
--   * transparency is read from privateEnv.espTransparency, so esptransparency also changes ESP that is already on

local robloxServices = require("../../framework/services/rbxServices")
local playerService = require("../../framework/services/playerService")
local privateEnv = require("../../framework/environment/private")
local logger = require("../../utils/logger")

local DEFAULT_TRANSPARENCY = 0.3
local DEFAULT_INTERVAL = 0.25
local DEFAULT_COLOR = Color3.fromRGB(255, 255, 255)
local ROOT_FOLDER_NAME = "iy-esp"

local function getRootFolder()
	local coreGui = robloxServices.CoreGui
	local folder = coreGui:FindFirstChild(ROOT_FOLDER_NAME)

	if not folder then
		folder = Instance.new("Folder")
		folder.Name = ROOT_FOLDER_NAME
		folder.Parent = coreGui
	end

	return folder
end

-- The part the label is attached to. For a character that is the head, like IY.
local function getAdornee(instance)
	if instance:IsA("BasePart") then
		return instance
	end

	if instance:IsA("Model") then
		return instance:FindFirstChild("Head")
			or instance.PrimaryPart
			or instance:FindFirstChildWhichIsA("BasePart")
	end

	return nil
end

-- Same text as the original EspManager for humanoids and for everything else
local function defaultText(instance, meters)
	local humanoid = instance:IsA("Model") and instance:FindFirstChildOfClass("Humanoid")

	if humanoid then
		return ("%s <font color='rgb(160, 160, 160)'>[ %dm ]</font>\n<font color='rgb(25, 240, 25)'>[%d/%d]</font>"):format(
			instance.Name,
			meters,
			math.floor(humanoid.Health),
			math.floor(humanoid.MaxHealth)
		)
	end

	return ("%s < %dm >"):format(instance.Name, meters)
end

local EspManager = {}
EspManager.__index = EspManager

-- options.tag        name of the manager (folder name and warnings)
-- options.source     function returning the instances to mark
-- options.color      function(instance) -> Color3 (optional, default white)
-- options.text       function(instance, meters, studs) -> string (optional)
-- options.showBoxes  a box over each BasePart (for a Model, its direct BasePart children)
-- options.showText   a label above the object
-- options.interval   seconds between updates (optional)
function EspManager.new(options)
	local folder = Instance.new("Folder")
	folder.Name = options.tag
	folder.Parent = getRootFolder()

	return setmetatable({
		tag = options.tag,
		source = options.source,
		color = options.color,
		text = options.text or defaultText,
		showBoxes = options.showBoxes == true,
		showText = options.showText == true,
		interval = options.interval or DEFAULT_INTERVAL,
		objects = {},
		folder = folder,
		running = false,
	}, EspManager)
end

function EspManager:create(instance)
	local adornee = getAdornee(instance)
	if not adornee then
		return nil
	end

	local esp = { instance = instance, adornee = adornee, boxes = {} }

	if self.showBoxes then
		local parts = instance:IsA("Model") and instance:GetChildren() or { instance }

		for _, part in parts do
			if part:IsA("BasePart") then
				local box = Instance.new("BoxHandleAdornment")
				box.Adornee = part
				box.Size = part.Size
				box.AlwaysOnTop = true
				box.ZIndex = 0
				box.Parent = self.folder
				table.insert(esp.boxes, box)
			end
		end
	end

	if self.showText then
		local billboard = Instance.new("BillboardGui")
		billboard.Adornee = adornee
		billboard.Size = UDim2.new(0, 200, 0, 50)
		billboard.StudsOffset = Vector3.new(0, 2, 0)
		billboard.AlwaysOnTop = true
		billboard.Parent = self.folder

		local label = Instance.new("TextLabel")
		label.BackgroundTransparency = 1
		label.Size = UDim2.new(1, 0, 1, 0)
		label.TextSize = 14
		label.TextStrokeTransparency = 0
		label.TextYAlignment = Enum.TextYAlignment.Bottom
		label.RichText = true
		label.Text = ""
		label.Parent = billboard

		esp.billboard = billboard
		esp.label = label
	end

	self.objects[instance] = esp
	return esp
end

function EspManager:update(esp, root)
	local color = DEFAULT_COLOR
	if self.color then
		color = self.color(esp.instance)
	end

	local transparency = privateEnv.espTransparency or DEFAULT_TRANSPARENCY

	for _, box in esp.boxes do
		box.Color3 = color
		box.Transparency = transparency
	end

	if esp.label then
		local studs = 0
		if root then
			studs = (root.Position - esp.adornee.Position).Magnitude
		end

		esp.label.TextColor3 = color
		esp.label.Text = self.text(esp.instance, math.floor(studs / 5), math.floor(studs))
	end
end

function EspManager:removeEsp(instance, esp)
	for _, box in esp.boxes do
		box:Destroy()
	end

	if esp.billboard then
		esp.billboard:Destroy()
	end

	self.objects[instance] = nil
end

function EspManager:refresh()
	local root = playerService:getRootPart()
	local wanted = {}

	for _, instance in self.source() do
		if not wanted[instance] then
			wanted[instance] = true

			local esp = self.objects[instance]

			-- the head or the part was replaced (respawn), so build it again
			if esp and not esp.adornee:IsDescendantOf(workspace) then
				self:removeEsp(instance, esp)
				esp = nil
			end

			esp = esp or self:create(instance)

			if esp then
				self:update(esp, root)
			end
		end
	end

	for instance, esp in pairs(self.objects) do
		if not wanted[instance] or not instance:IsDescendantOf(workspace) then
			self:removeEsp(instance, esp)
		end
	end
end

function EspManager:start()
	if self.running then
		return
	end

	self.running = true

	task.spawn(function()
		while self.running do
			local ok, err = pcall(self.refresh, self)

			if not ok then
				self.running = false
				logger:warn(("esp [%s] stopped: %s"):format(self.tag, tostring(err)))
				break
			end

			task.wait(self.interval)
		end
	end)
end

function EspManager:destroy()
	self.running = false

	for instance, esp in pairs(self.objects) do
		self:removeEsp(instance, esp)
	end

	self.folder:Destroy()
end

return EspManager
