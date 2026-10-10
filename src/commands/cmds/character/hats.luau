-- Removes the spin from the accessories and welds them back to the character
local function stopSpin(self)
	local garbage = self:collectGarbage("hatspin")
	if not garbage then return end

	garbage.connection:Disconnect()

	for _, accessory in garbage.accessories do
		local handle = accessory:FindFirstChild("Handle")
		if handle then
			for _, child in handle:GetChildren() do
				if child:IsA("BodyPosition") or child:IsA("BodyAngularVelocity") then
					child:Destroy()
				end
			end
		end

		if garbage.character:IsDescendantOf(workspace) then
			-- Parenting the accessory again makes it weld back to the character
			accessory.Parent = workspace
			task.wait()
			accessory.Parent = garbage.character
		end
	end
end

return {
	{
		action = "hatspin|spinhats",
		description = "Spins your characters accessories",
		args = {
			kind = "number",
			name = "spin speed",
			optional = true
		},
		run = function(self, args)
			stopSpin(self)

			local humanoid = self.playerService:getHumanoid()
			local character = self.playerService:getCharacter()
			if not (humanoid and character) then return end

			local speed = args:nextValue() or 100

			local garbage = self:createGarbage("hatspin")
			garbage.character = character
			garbage.accessories = {}
			garbage.keeps = {}

			for _, accessory in humanoid:GetAccessories() do
				local handle = accessory:FindFirstChild("Handle")
				local weld = handle and handle:FindFirstChildOfClass("Weld")
				if weld then
					weld:Destroy()

					-- keep holds the accessory above the head, spin turns it
					local keep = Instance.new("BodyPosition")
					keep.P = 30000
					keep.D = 50
					keep.Parent = handle

					local spin = Instance.new("BodyAngularVelocity")
					spin.AngularVelocity = Vector3.new(0, speed, 0)
					spin.MaxTorque = Vector3.new(0, speed * 2, 0)
					spin.Parent = handle

					table.insert(garbage.accessories, accessory)
					table.insert(garbage.keeps, keep)
				end
			end

			garbage.connection = self:connect(self.runService.Stepped, function()
				local currentCharacter = self.playerService:getCharacter()
				if currentCharacter ~= character then
					stopSpin(self)
					return
				end

				local head = character:FindFirstChild("Head")
				if not head then return end

				for _, keep in garbage.keeps do
					keep.Position = head.Position
				end
			end)
		end
	},
	{
		action = "unhatspin|unspinhats",
		description = "Undoes spinhats",
		run = function(self)
			stopSpin(self)
		end
	},
	{
		action = "clearhats|cleanhats",
		description = "Clears hats in the workspace",
		run = function(self)
			local firetouchinterest = self:expectExploit("firetouchinterest")
			if not firetouchinterest then return end

			-- Runs in its own thread: it waits for the game to put each hat on the character
			task.spawn(function()
				local character = self.playerService:getCharacter()
				local humanoid = self.playerService:getHumanoid()
				local root = self.playerService:getRootPart()
				if not (character and humanoid and root) then return end

				local oldCFrame = root.CFrame

				local hats = {}
				for _, child in workspace:GetChildren() do
					if child:IsA("Accessory") then
						table.insert(hats, child)
					end
				end

				for _, accessory in humanoid:GetAccessories() do
					accessory:Destroy()
				end

				for _, hat in hats do
					local handle = hat:FindFirstChild("Handle")
					local currentRoot = self.playerService:getRootPart()
					if handle and currentRoot then
						firetouchinterest(handle, currentRoot, 0)
					end

					-- Wait for the hat to attach, then remove it
					local waited = 0
					while character.Parent and not character:FindFirstChildOfClass("Accessory") and waited < 120 do
						task.wait()
						waited += 1
					end

					local attached = character:FindFirstChildOfClass("Accessory")
					if attached then
						attached:Destroy()
					end
					task.wait()
				end

				self.playerService:resetCharacter()
				self.localPlayer.CharacterAdded:Wait()

				-- Puts you back where you were, once the new character loads
				for _ = 1, 20 do
					task.wait()
					local newRoot = self.playerService:getRootPart()
					if newRoot then
						newRoot.CFrame = oldCFrame
					end
				end
			end)
		end
	}
}
