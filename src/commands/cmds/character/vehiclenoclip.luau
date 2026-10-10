-- Finds the Model that holds the seat, which is the vehicle.
local function getVehicle(seat: BasePart)
	local current = seat
	while current and not current:IsA("Model") do
		current = current.Parent
	end
	return current
end

local function restoreVehicle(self)
	local garbage = self:collectGarbage("vehiclenoclip")
	if not garbage then return end

	for _, part in garbage.parts do
		part.CanCollide = true
	end
end

return {
	{
		action = "vehiclenoclip|vnoclip",
		description = "Turns off vehicle collision",
		run = function(self)
			restoreVehicle(self)

			local humanoid = self.playerService:getHumanoid()
			local seat = humanoid and humanoid.SeatPart
			local vehicle = seat and getVehicle(seat)
			if not vehicle then
				self:notify("vehiclenoclip", "you are not sitting in a vehicle")
				return
			end

			local garbage = self:createGarbage("vehiclenoclip")
			garbage.parts = {}

			for _, part in vehicle:GetDescendants() do
				if part:IsA("BasePart") and part.CanCollide then
					part.CanCollide = false
					table.insert(garbage.parts, part)
				end
			end
		end
	},
	{
		action = "vehicleclip|vclip|unvnoclip",
		description = "Enables vehicle collision",
		run = function(self)
			restoreVehicle(self)
		end
	},
}
