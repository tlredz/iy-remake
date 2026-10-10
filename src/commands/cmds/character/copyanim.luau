local resolvePlayers = require("../../systems/resolvePlayers")

local DEFAULT_ANIMATION_ID = "507768375"
local DEFAULT_ANIMATION_ID_2 = "180435571"

return {
	{
		action = "copyanimation|copyanim|copyemote",
		description = "Copies someone elses animation",
		args = {
			kind = "player"
		},
		run = function(self, args)
			local humanoid = self.playerService:getHumanoid()
			if not humanoid then return end

			for _, target in resolvePlayers(args:nextValue()) do
				local targetHumanoid = target.Character and target.Character:FindFirstChildOfClass("Humanoid")
				if targetHumanoid then
					for _, track in humanoid:GetPlayingAnimationTracks() do
						track:Stop()
					end

					for _, track in targetHumanoid:GetPlayingAnimationTracks() do
						if not string.find(track.Animation.AnimationId, DEFAULT_ANIMATION_ID, 1, true) then
							local copy = humanoid:LoadAnimation(track.Animation)
							copy:Play(0.1, 1, track.Speed)
							copy.TimePosition = track.TimePosition

							task.spawn(function()
								track.Stopped:Wait()
								copy:Stop()
								copy:Destroy()
							end)
						end
					end
				end
			end
		end
	},
	{
		action = "copyanimationid|copyanimid|copyemoteid",
		description = "Copies your animation id or someone elses to your clipboard",
		args = {
			kind = "player",
			optional = true
		},
		run = function(self, args)
			local setclipboard = self:expectExploit("setclipboard")
			if not setclipboard then return end

			local player = self.localPlayer
			local text = args:nextValue()
			if text then
				player = resolvePlayers(text)[1]
			end

			local humanoid = player and player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
			if not humanoid then
				self:notify("Animations", "character is not loaded")
				return
			end

			local entries = {}
			for _, track in humanoid:GetPlayingAnimationTracks() do
				local animationId = track.Animation.AnimationId
				local ignored = string.find(animationId, DEFAULT_ANIMATION_ID, 1, true)
					or string.find(animationId, DEFAULT_ANIMATION_ID_2, 1, true)

				if not ignored then
					local assetId = string.match(animationId, "rbxassetid://(%d+)")
					if assetId then
						local success, info = pcall(function()
							return self.robloxServices.MarketplaceService:GetProductInfo(tonumber(assetId))
						end)

						local name = "Failed to get name"
						if success then
							name = info.Name
						end

						table.insert(entries, "Name: " .. name .. "\nAnimation Id: " .. animationId)
					else
						table.insert(entries, "Animation Id: " .. animationId)
					end
				end
			end

			if #entries == 0 then
				self:notify("Animations", "No animations to copy")
				return
			end

			setclipboard("Animations Copied\n\n" .. table.concat(entries, "\n\n"))
			self:notify("Animations", "Copied to clipboard")
		end
	}
}
