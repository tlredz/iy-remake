local connectionService = require("../../framework/services/connectionService")
local robloxServices = require("../../framework/services/rbxServices")
local createService = require("../services/createService")
local playerService = require("../../framework/services/playerService")
local themeService = require("../services/themeService")

local createArrow = require("../elements/arrow")
local scaleObject = require("../utils/scaleObject")

local signal = require("../../utils/signal")

local inputConfig = require("../../framework/config/input")

local userInputService = robloxServices.UserInputService

local scrollBar = {}
scrollBar.__index = scrollBar

local function isValidInputType(input)
	return inputConfig.pressingInputs[input.UserInputType] ~= nil
end

function scrollBar:awake()
	local playerMouse = playerService:getMouse()
	
	local scrollThumbFrame = self.scrollThumbFrame
	local scrollThumb = self.scrollThumb
	local scrollBar = self.scrollBar
	
	local isPressingButton = false
	local isPressingThumb = false
	local pressingButton = nil
	
	local function handleButtonPress(button, direction)
		local function onStartedPressing()
			if isPressingButton then return end
			if not self:canScroll(direction) then return end
			
			isPressingButton = true
			
			self:scrollToDirection(direction)
			
			local releaseEvent
			releaseEvent = connectionService:Connect(userInputService.InputEnded, function(input)
				if not isValidInputType(input) then return end
				
				releaseEvent:Disconnect()
				isPressingButton = false
			end)
			
			task.wait(0.4)
			
			while self:canScroll(direction) and isPressingButton do
				self:scrollToDirection(direction)
				task.wait(1 / 15)
			end
		end
		
		connectionService:Connect(button.MouseButton1Down, onStartedPressing)
		
		-- print("handle press:", button.Name)
	end
	
	handleButtonPress(self.upButton, "up")
	handleButtonPress(self.downButton, "down")
	
	connectionService:Connect(scrollBar.MouseWheelForward, function()
		self:scrollTo(self.index - self.wheelIncrement)
	end)
	
	connectionService:Connect(scrollBar.MouseWheelBackward, function()
		self:scrollTo(self.index + self.wheelIncrement)
	end)
	
	connectionService:Connect(scrollBar.InputBegan, function(input)
		if not isValidInputType(input) then return end
		if self:isScrollBarDisabled() then return end
		
		local isHoldingFrame = not playerService:isMouseInGuiObject(scrollThumb)
		local direction = self.isHorizontal and "X" or "Y"
		
		local lastThumbPos = nil
		isPressingThumb = true
		
		themeService:updateObjectProperties(scrollThumb, {
			BackgroundColor3 = "Colors.Primary"
		})
		
		local mouseOffset = playerMouse[direction] - scrollThumb.AbsolutePosition[direction]
		local releaseEvent
		local mouseEvent
		
		local function disconnect()
			if releaseEvent then releaseEvent:Disconnect() end
			if mouseEvent then mouseEvent:Disconnect() end
		end
		
		releaseEvent = connectionService:Connect(userInputService.InputEnded, function(input)
			if not isValidInputType(input) then return end
			
			disconnect()
			isPressingThumb = false
			
			themeService:updateObjectProperties(scrollThumb, {
				BackgroundColor3 = "Colors.OnPrimary"
			})
		end)
		
		if isHoldingFrame then
			local function updateDirection()
				local scrollDir = (playerMouse[direction] >= scrollThumb.AbsolutePosition[direction] + scrollThumb.AbsoluteSize[direction]) and 1 or 0
				local scrollSize = self.visibleSpace - 1
				
				if scrollDir == 0 and (
					playerMouse[direction] < scrollThumb.AbsolutePosition[direction]
				) then
					self:scrollTo(self.index - scrollSize)
				elseif scrollDir == 1 and (
					playerMouse[direction] >= scrollThumb.AbsolutePosition[direction] + scrollThumb.AbsoluteSize[direction]
				) then
					self:scrollTo(self.index + scrollSize)
				end
			end
			
			while isPressingThumb do
				updateDirection()
				task.wait(1 / 4)
			end
			return
		end
		
		mouseEvent = connectionService:Connect(userInputService.InputChanged, function(input)
			if not isPressingThumb then return end
			if not isValidInputType(input) then return end
			
			local thumbFrameSize = scrollThumbFrame.AbsoluteSize[direction] - scrollThumb.AbsoluteSize[direction]
			local pos = playerMouse[direction] - scrollThumbFrame.AbsolutePosition[direction] - mouseOffset
			
			if pos > thumbFrameSize then
				pos = thumbFrameSize
			elseif pos < 0 then
				pos = 0
			end
			
			if lastThumbPos ~= pos then
				lastThumbPos = pos
				self:scrollTo(math.floor(0.5 + pos / thumbFrameSize * (self.totalSpace - self.visibleSpace)))
			end
		end)
	end)
end

function scrollBar:create()
	self.upButton = createService.new("ImageButton", self.upButtonName, {
		BackgroundTransparency = 1,
		AutoButtonColor = false
	})
	
	self.downButton = createService.new("ImageButton", self.downButtoName, {
		BackgroundTransparency = 1,
		AutoButtonColor = false
	})
	
	self:createButtonsArrows()
	
	local scrollBar = createService.new("Frame", "ScrollBar", {
		Active = true,
		BackgroundTransparency = 1,
		
		self.upButton,
		self.downButton,
		
		createService.new("Frame", "ScrollThumbFrame", {
			BackgroundTransparency = 1,
			AnchorPoint = self.isHorizontal
				and Vector2.new(0.5, 0)
				or Vector2.new(0, 0.5),
			Position = self.isHorizontal
				and UDim2.fromScale(0.5, 0)
				or UDim2.fromScale(0, 0.5),
			
			createService.new("Frame", "ScrollThumb", {
				AnchorPoint = self.isHorizontal
					and Vector2.new(0, 0.5)
					or Vector2.new(0.5, 0),
				ThemeTag = {
					BackgroundColor3 = "Colors.OnPrimary"
				},
				
				createService.new("UICorner", {
					CornerRadius = UDim.new(0, 4),
				}),
			}),
			
			createService.new("Frame", "MarkerFrame", {
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
			}),
		}),
	})
	
	self.scrollBar		  = scrollBar
	self.scrollThumbFrame = scrollBar.ScrollThumbFrame
	self.scrollThumb	  = scrollBar.ScrollThumbFrame.ScrollThumb
	self.markerFrame	  = scrollBar.ScrollThumbFrame.MarkerFrame
	
	self.container = createService.new("Frame", "Container", {
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Active = true
	})
	
	self:setScrollBarThickness(self.barThickness)
	self:awake()
	self:update()

	-- print("created a new scroll bar")
	return scrollBar
end

function scrollBar:createButtonsArrows()
	local downButton = self.downButton
	local upButton = self.upButton
	
	createArrow(4, 0.55, downButton.Name).Parent = downButton
	createArrow(4, 0.55, upButton.Name).Parent = upButton
end

function scrollBar:canScrollUp()
	return self:isScrollBarEnabled() and self.index > 0
end

function scrollBar:canScrollDown()
	local enabled = self:isScrollBarEnabled()
	return enabled and self.index + self.visibleSpace < self.totalSpace
end

function scrollBar:canScroll(direction)
	if direction == "up" or direction == "left" then
		return self:canScrollUp()
	elseif direction == "down" or direction == "right" then
		return self:canScrollDown()
	end
	return false
end

function scrollBar:getScrollPercent()
	local range = self.totalSpace - self.visibleSpace
	if range <= 0 then return 0 end
	return self.index / range
end

function scrollBar:scrollTo(targetIndex, silent)
	local maxIndex = math.max(0, self.totalSpace - self.visibleSpace)
	
	self.index = math.clamp(targetIndex, 0, maxIndex)
	self:update()
	
	if not silent then
		self.scrolledSignal:Fire(self.index)
	end
end

function scrollBar:scrollUp()
	self:scrollTo(self.index - self.increment)
end

function scrollBar:scrollDown()
	self:scrollTo(self.index + self.increment)
end

function scrollBar:scrollToDirection(direction)
	if direction == "up" or direction == "left" then
		return self:scrollUp()
	elseif direction == "down" or direction == "right" then
		return self:scrollDown()
	end
end

function scrollBar:isVisible(position)
	local index = self.index
	if position >= index and position < (index + self.visibleSpace) then
		return true
	end
	return false
end

function scrollBar:setScrollPercent(percent)
	local range = self.totalSpace - self.visibleSpace
	self:scrollTo(math.floor(percent * range))
end

function scrollBar:update()
	self:drawThumb()
end

function scrollBar:setScrollBarThickness(thickness)
	local scrollThumbFrame = self.scrollThumbFrame
	local downButton = self.downButton
	local container = self.container
	local scrollBar = self.scrollBar
	local upButton = self.upButton
	
	self.barThickness = thickness
	
	if container then
		container.Size = UDim2.new(
			1,
			self.isHorizontal and 0 or -thickness,
			1, 
			self.isHorizontal and -thickness or 0
		)
	end
	
	if scrollBar then
		scrollBar.Size = self.isHorizontal
			and UDim2.new(1, 0, 0, thickness)
			or UDim2.new(0, thickness, 1, 0)
		scrollBar.Position = self.isHorizontal
			and UDim2.new(0, 0, 1, -thickness)
			or UDim2.new(1, -thickness, 0, 0)
	end
	
	if scrollThumbFrame then
		scrollThumbFrame.Size = self.isHorizontal
			and UDim2.new(1, -(thickness * 2), 0, thickness)
			or UDim2.new(0, thickness, 1, -(thickness * 2))
	end
	
	if downButton then
		downButton.Size = UDim2.fromOffset(thickness, thickness)
		downButton.Position = self.isHorizontal
			and UDim2.new(1, -thickness, 0, 0)
			or  UDim2.new(0, 0, 1, -thickness)
	end
	
	if upButton then
		upButton.Size = UDim2.fromOffset(thickness, thickness)
		upButton.Position = UDim2.fromOffset(0, 0)
	end
end

function scrollBar:updateArrowTransparency(button, transparent)
	if not button:FindFirstChild("Arrow") then return end
	
	for _, frame in button.Arrow:GetChildren() do
		if not frame:IsA("GuiObject") then continue end
		frame.Transparency = transparent and 0.6 or 0
	end
end

function scrollBar:drawThumb()
	local thumb	     = self.scrollThumb
	local thumbFrame = self.scrollThumbFrame
	
	local canUp   = self:canScrollUp()
	local canDown = self:canScrollDown()
	
	self:updateArrowTransparency(self.upButton, not canUp)
	self:updateArrowTransparency(self.downButton, not canDown)
	
	if not thumb or not thumbFrame then return end

	if not canUp and not canDown then
		thumb.Visible = false
		return
	end
	
	thumb.Visible = true

	local percent = self:getScrollPercent()
	local scale = scaleObject:getScale()
	local thickness = self.barThickness
	
	if self.isHorizontal then
		local frameW = thumbFrame.AbsoluteSize.X / scale
		local thumbW = math.max(thickness, (self.visibleSpace / self.totalSpace) * frameW)
		thumb.Size	 = UDim2.new(0, thumbW, 1, -2)
		thumb.Position = UDim2.new(0, percent * (frameW - thumbW), 0.5, 0)
	else
		local frameH = thumbFrame.AbsoluteSize.Y / scale
		local thumbH = math.max(thickness, (self.visibleSpace / self.totalSpace) * frameH)
		thumb.Size	 = UDim2.new(1, -2, 0, thumbH)
		thumb.Position = UDim2.new(0.5, 0, 0, percent * (frameH - thumbH))
	end
end

function scrollBar:addMarker(index, color)
	self.markers[index] = color or Color3.new(1, 1, 0)
	self:updateMarkers()
end

function scrollBar:removeMarker(index)
	self.markers[index] = nil
	self:updateMarkers()
end

function scrollBar:updateMarkers()
	local markerFrame = self.markerFrame
	if not markerFrame then return end
	
	for _, child in pairs(markerFrame:GetChildren()) do
		child:Destroy()
	end
	
	for index, color in pairs(self.markers) do
		if index >= self.totalSpace then continue end
		
		local marker = Instance.new("Frame")
		marker.BackgroundColor3 = color
		marker.BorderSizePixel  = 0
		marker.BackgroundTransparency = 0
		marker.Parent = markerFrame
		
		local ratio = index / self.totalSpace
		if self.isHorizontal then
			marker.Position = UDim2.new(ratio, 0, 1, -4)
			marker.Size	 = UDim2.new(0, 2, 0, 4)
		else
			marker.Position = UDim2.new(1, -4, ratio, 0)
			marker.Size	 = UDim2.new(0, 4, 0, 2)
		end
		
		marker.Name = "Marker_" .. tostring(index)
	end
end

function scrollBar:setTotalSpace(total)
	self.totalSpace = total
	self:scrollTo(self.index, true)
	self:update()
end

function scrollBar:setVisibleSpace(visible)
	self.visibleSpace = visible
	self:scrollTo(self.index, true)
	self:update()
end

function scrollBar:disableScroll()
	self.scrollBarEnabled = false
	self:drawThumb()
end

function scrollBar:enableScroll()
	self.scrollBarEnabled = true
	self:drawThumb()
end

function scrollBar:isScrollBarEnabled()
	return self.scrollBarEnabled
end

function scrollBar:isScrollBarDisabled()
	return not self.scrollBarEnabled
end

function scrollBar.new(config)
	local self = setmetatable({
		isHorizontal	  = config.isHorizontal  or false,
		increment		 = config.increment	 or 1,
		wheelIncrement	= config.wheelIncrement or 3,
		barThickness	  = config.barThickness or 16,
		
		scrollBarEnabled = true,
		
		index		= 0,
		visibleSpace = config.visibleSpace or 0,
		totalSpace   = config.totalSpace   or 0,
		
		markers	  = {},
		
		scrollBar	  = config.scrollBar	  or nil,
		scrollThumb	= config.scrollThumb	or nil,
		scrollThumbFrame = config.scrollThumbFrame or nil,
		markerFrame	= config.markerFrame	or nil,
		
		scrolledSignal = signal.new(),
	}, scrollBar)
	
	self.upButtonName = self.isHorizontal and "left" or "up"
	self.downButtoName = self.isHorizontal and "right" or "down"
	
	return self
end

return scrollBar