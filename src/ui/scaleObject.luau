return {
	uiScale = Instance.new("UIScale"),
	getScale = function(self)
		local uiScale = self.uiScale
		return uiScale and uiScale.Scale or 1
	end,
	setScale = function(self, scale)
		local uiScale = self.uiScale
		if uiScale then uiScale.Scale = scale end
	end
}