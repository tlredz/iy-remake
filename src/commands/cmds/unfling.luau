return function(self)
	local garbage = self:collectGarbage("fling")
	if not garbage then return end
	
	if garbage.flingVelocity then
		garbage.flingVelocity:Destroy()
	end
	
	if garbage.flingConnection then
		garbage.flingConnection:Disconnect()
	end
	
	for object, properties in garbage.originalStates do
		for property, value in properties do
			object[property] = value
		end
	end
	
	self:notify("fling disabled")
end