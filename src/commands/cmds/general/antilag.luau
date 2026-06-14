local EDIT_PROPERTIES = {
	BasePart = {
		CastShadow = false,
		Material = Enum.Material.Plastic,
		Reflectance = 0,
		BackSurface = Enum.SurfaceType.SmoothNoOutlines,
		BottomSurface = Enum.SurfaceType.SmoothNoOutlines,
		FrontSurface = Enum.SurfaceType.SmoothNoOutlines,
		LeftSurface = Enum.SurfaceType.SmoothNoOutlines,
		RightSurface = Enum.SurfaceType.SmoothNoOutlines,
		TopSurface = Enum.SurfaceType.SmoothNoOutlines
	},
	Decal = {
		Transparency = 1,
		Texture = ""
	},
	ParticleEmitter = {
		Lifetime = NumberRange.new(0)
	},
	Trail = {
		Lifetime = NumberRange.new(0)
	},
	PostEffect = {
		Enabled = false
	}
}

local DESTROY_OBJECTS = {
	"ForceField",
	"Sparkles",
	"Smoke",
	"Fire",
	"Beam"
}

local function optimizeGame(self)
	local terrain = workspace:FindFirstChildWhichIsA("Terrain")
	local lighting = self.rbxServices.Lighting
	
	terrain.WaterWaveSize = 0
	terrain.WaterWaveSpeed = 0
	terrain.WaterReflectance = 0
	terrain.WaterTransparency = 1
	
	lighting.GlobalShadows = false
	lighting.FogEnd = 9e9
	lighting.FogStart = 9e9
	
	self.gameSettings.Rendering.QualityLevel = 1
	
	for _, object in game:GetDescendants() do
		for class, properties in EDIT_PROPERTIES do
			if not object:IsA(class) then continue end
			for property, value in properties do
				object[property] = value
			end
		end
	end
	
	self:connect(workspace.DescendantAdded, function(object)
		if object:IsA("BasePart") then
			BasePart.CastShadow = false
			return
		end
		
		for _, class in DESTROY_OBJECTS do
			if not object:IsA(class) then continue end
			
			task.defer(function()
				object:Destroy()
			end)
		end
	end)
end

return {
	action = "antilag|boostfps|lowgraphics",
	description = "Lowers game quality to boost FPS",
	run = function(self)
		if not self.privateEnv.antiLagEnabled then
			self.privateEnv.antiLagEnabled = true
			optimizeGame(self)
			return
		end
		
		self:notify("anti lag is already enabled")
	end
}