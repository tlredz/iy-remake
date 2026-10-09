--!strict
-- src/ui/utils/scaleManager.luau

local scaleManager = {
	instance = nil :: UIScale?,
	currentScale = 1
}

function scaleManager:init(screenGui: ScreenGui)
	local uiScale = screenGui:FindFirstChildOfClass("UIScale")
	if not uiScale then
		uiScale = Instance.new("UIScale")
		uiScale.Parent = screenGui
	end
	
	self.instance = uiScale
end

function scaleManager:setScale(newScale: number)
	self.currentScale = math.abs(newScale)
	
	if self.instance then
		self.instance.Scale = self.currentScale
	end
end

function scaleManager:getScale(): number
	return self.currentScale
end

return scaleManager
