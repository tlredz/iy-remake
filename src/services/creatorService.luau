local cloneref = cloneref or (function(...) return ... end)

local deletefolder = delfolder or deletefolder
local deletefile = delfile or deletefile
local makefolder = makefolder
local writefile = writefile
local readfile = readfile

local robloxServices = setmetatable({}, {
	__index = function(self, index)
		rawset(self, index, cloneref(game:GetService(index)))
		return rawget(self, index)
	end
})

local MarketplaceService = robloxServices.MarketplaceService
local UserInputService = robloxServices.UserInputService
local TweenService = robloxServices.TweenService
local HttpService = robloxServices.HttpService
local RunService = robloxServices.RunService
local Players = robloxServices.Players

local Heartbeat = RunService.Heartbeat

local Player = Players.LocalPlayer
local PlayerMouse = Player:GetMouse()

local CoreGui = (gethui or function() return robloxServices.CoreGui end)()

local Themes = {
	Darker = {
		Colors = {
			Background = ColorSequence.new({
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(25, 25, 25)),
				ColorSequenceKeypoint.new(0.50, Color3.fromRGB(32.5, 32.5, 32.5)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(25, 25, 25))
			}),
			Primary = Color3.fromRGB(88, 101, 242),
			OnPrimary = Color3.fromRGB(61, 67, 135),
			ScrollBar = Color3.fromRGB(1, 76, 105),
			Stroke = Color3.fromRGB(45, 45, 45),
			
			Error = Color3.fromRGB(255, 102, 102),
			Icons = Color3.fromRGB(232, 233, 235),
			
			JoinButton = Color3.fromRGB(37, 128, 69),
			Link = Color3.fromRGB(40, 150, 255),
			
			Dialog = {
				Background = Color3.fromRGB(28, 28, 28)
			},
			Buttons = {
				Holding = Color3.fromRGB(34, 34, 34),
				Default = Color3.fromRGB(28, 28, 30)
			},
			Border = {
				Holding = Color3.fromRGB(60, 60, 60),
				Default = Color3.fromRGB(38, 38, 38),
			},
			Text = {
				Default = Color3.fromRGB(255, 255, 255),
				Dark = Color3.fromRGB(200, 200, 200),
				Darker = Color3.fromRGB(175, 175, 175),
			},
			Slider = {
				SliderBar = Color3.fromRGB(1, 76, 105),
				SliderNumber = Color3.fromRGB(232, 233, 235),
			},
			Dropdown = {
				Holder = Color3.fromRGB(30, 30, 30),
			}
		},
		Icons = {
			Error = "rbxassetid://10709752996",
			Button = "rbxassetid://10709791437",
			Close = "rbxassetid://10747384394",
			TextBox = "rbxassetid://15637081879",
			Search = "rbxassetid://10734943674",
			Keybind = "rbxassetid://10734982144",
			Dropdown = {
				Open = "rbxassetid://10709791523",
				Close = "rbxassetid://10709790948"
			}
		},
		Font = {
			Normal = Enum.Font.BuilderSans,
			Medium = Enum.Font.BuilderSansMedium,
			Bold = Enum.Font.BuilderSansBold,
			ExtraBold = Enum.Font.BuilderSansExtraBold,
			SliderValue = Enum.Font.FredokaOne
		},
		BackgroundTransparency = 0.03
	}
}

for ThemeName, Theme in Themes do
	Theme.Name = ThemeName
	table.freeze(Theme)
end

local Library = {
	Information = {
		Version = "v2.0.1",
		GitHubOwner = "tlredz"
	},
	Default = {
		Theme = "Darker",
		UISize = UDim2.fromOffset(550, 380),
		TabSize = 160
	},
	
	Themes = Themes,
	
	Connections = {},
	Options = {},
	Tabs = {}
}

Library.Info = Library.Information
Library.Save = Library.Default

local ViewportSize = workspace.CurrentCamera.ViewportSize

local function NewConnection(Event, Action, Mode)
	table.insert(Library.Connections, Event[Mode or "Connect"](Event, Action))
end

local ThemesObjects = {}
ThemesObjects.__index = ThemesObjects

local function GetValueFromString(table, path)
	for key in path:gmatch("[^%.]+") do
		table = table[key]
	end
	
	return table
end

local function UpdateObjectThemeProperty(object, property, value, selectedTheme)
	if not selectedTheme then
		selectedTheme = Library.CurrentTheme
	end
	
	object[property] = GetValueFromString(selectedTheme, if type(value) == "function" then value() else value)
end

local function updateObjectTheme(selectedTheme, object, themeTag)
	for property, value in themeTag do
		UpdateObjectThemeProperty(object, property, value, selectedTheme)
	end
end

local function trywritefile(path, content)
	if makefolder then
		local parts = path:split("/")
		parts[#parts] = nil
		
		local folderPath = table.concat(parts, "/")
		
		if folderPath ~= "" and (isfolder == nil or not isfolder(folderPath)) then
			makefolder(folderPath)
		end
	end
	
	writefile(path, content)
end

local SLIDING = false

local HIDDEN_SETTINGS = {
	MAX_SCALE = 1.6,
	MIN_SCALE = 0.6,
	
	TEXTBOX = {
		PLACEHOLDER_TEXT = "Input"
	}
}

function ThemesObjects:add(object, theme)
	self.Descendants[theme] = object
	
	if self.IS_RENDERING then
		updateObjectTheme(Library.CurrentTheme, object, theme)
	end
end

function ThemesObjects:update()
	if self.IS_RENDERING and not self.UPDATED_OBJECTS then
		local selectedTheme = Library.CurrentTheme
		self.UPDATED_OBJECTS = true
		
		for tag, object in self.Descendants do
			local objectType = typeof(object)
			if objectType == "table" then object:update() continue end
			
			updateObjectTheme(selectedTheme, object, tag)
		end
	end
end

function ThemesObjects:destroy()
	local found = self.Parent and table.find(self.Parent.Descendants)
	
	if found then
		table.remove(self.Parent.Descendants, found)
	end
	
	table.clear(self.Descendants)
	setmetatable(self, nil)
end

function ThemesObjects:changeRendering(value: boolean): (nil)
	if self.IS_RENDERING ~= value then
		self.IS_RENDERING = value
		self.UPDATED_OBJECTS = false
	end
end

function ThemesObjects:new()
	local new = setmetatable({
		IS_RENDERING = true,
		UPDATED_OBJECTS = false,
		Descendants = {},
		Parent = self.Descendants ~= nil and self or nil
	}, ThemesObjects)
	
	if self.Descendants then
		table.insert(self.Descendants, new)
	end
	
	return new
end

local ThemesObjects = ThemesObjects:new()

local Creator, Create = {} do
	local Templates = {}
	
	local Elements = {} do
		function Elements:Create(Parent, Class, ...)
			local Element = self.ElementsTable[Class]
			
			if Element then
				local Object = Element(...)
				Object.Parent = Parent
				return Object
			end
		end
	end
	
	local SpecialProperties = {}
	
	function SpecialProperties:Childs(Childs: table): (nil)
		for index = 1, #Childs do
			Childs[index].Parent = self
		end
	end
	
	function SpecialProperties:Elements(Properties: table): (nil)
		for Class: string, Value: any? in pairs(Properties) do
			if type(Value) == "table" then
				Creator.SetProperties(Elements:Create(self, Class), Value)
			else
				Elements:Create(self, Class, Value)
			end
		end
	end
	
	function SpecialProperties:ThemeTag(Theme: table): any?
		local objects = Theme.OBJECTS
		Theme.OBJECTS = nil
		return (objects or ThemesObjects):add(self, Theme)
	end
	
	function Creator:SetProperties(Properties: table): (nil)
		for Property, Value in pairs(Properties) do
			if SpecialProperties[Property] then
				SpecialProperties[Property](self, Value)
			else
				self[Property] = Value
			end
		end
	end
	
	function Creator:SetValues(...): (nil)
		local Object = self
		
		for _, Value in {...} do
			local _type = typeof(Value)
			
			if _type == "table" then
				Creator.SetProperties(Object, Value)
			else
				Object[if _type == "string" then "Name" else "Parent"] = Value
			end
		end
		
		return Object
	end
	
	local DRAGGING_INSTANCE = nil
	
	function Creator:Draggable(UIScale: UIScale, Lerp: number?, PositionFilter): (nil)
		local CurrentPosition, DragStart, StartPos, InputOn
		local LerpValue = Lerp or 0.28
		local LastActivity = 0
		local DisconnectMouse = nil
		
		local function Update(input)
			local delta = input.Position - DragStart
			local Position = nil
			LastActivity = tick()
			
			if PositionFilter then
				Position = PositionFilter(
					StartPos.X.Scale, StartPos.X.Offset + delta.X / UIScale.Scale,
					StartPos.Y.Scale, StartPos.Y.Offset + delta.Y / UIScale.Scale
				)
			else
				Position = UDim2.new(
					StartPos.X.Scale, StartPos.X.Offset + delta.X / UIScale.Scale,
					StartPos.Y.Scale, StartPos.Y.Offset + delta.Y / UIScale.Scale
				)
			end
			self.Position = self.Position:Lerp(Position, LerpValue)
		end
		
		local function TimeoutConnection()
			while DRAGGING_INSTANCE == self do
				if (tick() - LastActivity) >= 1 then
					DisconnectMouse()
					break
				end
				task.wait()
			end
		end
		
		local InputBeganWhitelist = {
			[Enum.UserInputType.MouseButton1] = true,
			[Enum.UserInputType.Touch] = true
		}
		
		local InputChangedWhitelist = {
			[Enum.UserInputType.MouseMovement] = true,
			[Enum.UserInputType.Touch] = true
		}
		
		NewConnection(self.InputBegan, function(Input)
			if SLIDING == false and DRAGGING_INSTANCE == nil and InputBeganWhitelist[Input.UserInputType] then
				DragStart = Input.Position
				StartPos = self.Position
				DRAGGING_INSTANCE = self
				LastActivity = tick()
				SLIDING = true
				
				local Connection;
				
				function DisconnectMouse()
					SLIDING = false
					DRAGGING_INSTANCE = nil
					Connection:Disconnect()
				end
				
				task.spawn(TimeoutConnection)
				
				Connection = Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						DisconnectMouse()
					end
				end)
			end
		end)
		
		NewConnection(UserInputService.InputChanged, function(Input)
			if DRAGGING_INSTANCE == self and InputChangedWhitelist[Input.UserInputType] then
				Update(Input)
			end
		end)
	end
	
	function Creator:CreateNewTemplate(Parent: Instance): Instance?
		return Creator.CloneObject(Templates[self], Parent)
	end
	
	function Creator.new(Class: string, ...)
		return Creator.SetValues(Instance.new(Class), ...)
	end
	
	Create = Creator.new
end