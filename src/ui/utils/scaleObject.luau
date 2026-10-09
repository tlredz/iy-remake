return {
	uiScale = Instance.new("UIScale"),
	getScale = function(self)
		local uiScale = self.uiScale
		return uiScale and (uiScale:GetAttribute("REAL_SCALE") or uiScale.Scale) or 1
	end,
	setScale = function(self, scale)
		local uiScale = self.uiScale
		
		if uiScale then
			uiScale.Scale = scale
			uiScale:SetAttribute("REAL_SCALE", scale)
		end
	end
}