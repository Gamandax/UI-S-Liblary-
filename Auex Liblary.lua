-- Made by Nexus

local AUXLib = {flags = {}, windows = {}, open = true}

local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local textService = game:GetService("TextService")
local inputService = game:GetService("UserInputService")
local ui = Enum.UserInputType.MouseButton1

local dragging, dragInput, dragStart, startPos, dragObject

local function round(num, bracket)
	bracket = bracket or 1
	local a = math.floor(num/bracket + (math.sign(num) * 0.5)) * bracket
	if a < 0 then
		a = a + bracket
	end
	return a
end

local function update(input)
	local delta = input.Position - dragStart
	local yPos = (startPos.Y.Offset + delta.Y) < -36 and -36 or startPos.Y.Offset + delta.Y
	dragObject:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, yPos), "Out", "Quint", 0.1, true)
end

local chromaColor = Color3.fromRGB(255, 0, 0)
local rainbowTime = 5
spawn(function()
	while wait() do
		chromaColor = Color3.fromHSV(tick() % rainbowTime / rainbowTime, 1, 1)
	end
end)

function AUXLib:Create(class, properties)
	properties = typeof(properties) == "table" and properties or {}
	local inst = Instance.new(class)
	for property, value in next, properties do
		inst[property] = value
	end
	return inst
end

local loadOptions, getFunctions

local function createOptionHolder(holderTitle, parent, parentTable, subHolder)
	local size = subHolder and 34 or 40
	
	parentTable.main = AUXLib:Create("ImageButton", {
		LayoutOrder = subHolder and parentTable.position or 0,
		Position = UDim2.new(0, 20 + (250 * (parentTable.position or 0)), 0, 20),
		Size = UDim2.new(0, 230, 0, size),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.04,
		ClipsDescendants = true,
		Parent = parent
	})
	
	local round
	if not subHolder then
		round = AUXLib:Create("ImageLabel", {
			Size = UDim2.new(1, 0, 0, size),
			BackgroundTransparency = 1,
			Image = "rbxassetid://3570695787",
			ImageColor3 = parentTable.open and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(6, 6, 6),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100),
			SliceScale = 0.04,
			Parent = parentTable.main
		})
	end

	local title = AUXLib:Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, size),
		BackgroundTransparency = subHolder and 0 or 1,
		BackgroundColor3 = Color3.fromRGB(10, 10, 10),
		BorderSizePixel = 0,
		Text = holderTitle,
		TextSize = subHolder and 16 or 17,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = parentTable.main
	})
	
	local closeHolder = AUXLib:Create("Frame", {
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(-1, 0, 1, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Parent = title
	})
	
	local close = AUXLib:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -size - 10, 1, -size - 10),
		Rotation = parentTable.open and 90 or 180,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4918373417",
		ImageColor3 = parentTable.open and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Fit,
		Parent = closeHolder
	})
	
	parentTable.content = AUXLib:Create("Frame", {
		Position = UDim2.new(0, 0, 0, size),
		Size = UDim2.new(1, 0, 1, -size),
		BackgroundTransparency = 1,
		Parent = parentTable.main
	})
	
	local layout = AUXLib:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = parentTable.content
	})

	layout.Changed:connect(function()
		parentTable.content.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
		parentTable.main.Size = #parentTable.options > 0 and parentTable.open and UDim2.new(0, 230, 0, layout.AbsoluteContentSize.Y + size) or UDim2.new(0, 230, 0, size)
	end)
	
	if not subHolder then
		AUXLib:Create("UIPadding", {
			Parent = parentTable.content
		})
		
		title.InputBegan:connect(function(input)
			if input.UserInputType == ui then
				dragObject = parentTable.main
				dragging = true
				dragStart = input.Position
				startPos = dragObject.Position
			elseif input.UserInputType == Enum.UserInputType.Touch then
				dragObject = parentTable.main
				dragging = true
				dragStart = input.Position
				startPos = dragObject.Position
			end
		end)
		
		title.InputChanged:connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			elseif dragging and input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		
		title.InputEnded:connect(function(input)
			if input.UserInputType == ui then
				dragging = false
			elseif input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	end
	
	closeHolder.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			parentTable.open = not parentTable.open
			tweenService:Create(close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = parentTable.open and 90 or 180, ImageColor3 = parentTable.open and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30)}):Play()
			if subHolder then
				tweenService:Create(title, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = parentTable.open and Color3.fromRGB(16, 16, 16) or Color3.fromRGB(10, 10, 10)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = parentTable.open and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(6, 6, 6)}):Play()
			end
			parentTable.main:TweenSize(#parentTable.options > 0 and parentTable.open and UDim2.new(0, 230, 0, layout.AbsoluteContentSize.Y + size) or UDim2.new(0, 230, 0, size), "Out", "Quad", 0.2, true)
		elseif input.UserInputType == Enum.UserInputType.Touch then
			parentTable.open = not parentTable.open
			tweenService:Create(close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = parentTable.open and 90 or 180, ImageColor3 = parentTable.open and Color3.fromRGB(50, 50, 50) or Color3.fromRGB(30, 30, 30)}):Play()
			if subHolder then
				tweenService:Create(title, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = parentTable.open and Color3.fromRGB(16, 16, 16) or Color3.fromRGB(10, 10, 10)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = parentTable.open and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(6, 6, 6)}):Play()
			end
			parentTable.main:TweenSize(#parentTable.options > 0 and parentTable.open and UDim2.new(0, 230, 0, layout.AbsoluteContentSize.Y + size) or UDim2.new(0, 230, 0, size), "Out", "Quad", 0.2, true)
		end
	end)

	function parentTable:SetTitle(newTitle)
		title.Text = tostring(newTitle)
	end
	
	return parentTable
end

local function createLabel(option, parent)
	local main = AUXLib:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 26),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	setmetatable(option, {__newindex = function(t, i, v)
		if i == "Text" then
			main.Text = " " .. tostring(v)
		end
	end})
end

function createToggle(option, parent)
	local main = AUXLib:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 31),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	local tickboxOutline = AUXLib:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(-1, 10, 1, -10),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = option.state and Color3.fromRGB(255, 65, 65) or Color3.fromRGB(100, 100, 100),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local tickboxInner = AUXLib:Create("ImageLabel", {
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(1, -4, 1, -4),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = option.state and Color3.fromRGB(255, 65, 65) or Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = tickboxOutline
	})
	
	local checkmarkHolder = AUXLib:Create("Frame", {
		Position = UDim2.new(0, 4, 0, 4),
		Size = option.state and UDim2.new(1, -8, 1, -8) or UDim2.new(0, 0, 1, -8),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = tickboxOutline
	})
	
	local checkmark = AUXLib:Create("ImageLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4919148038",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		Parent = checkmarkHolder
	})
	
	local inContact
	main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			option:SetState(not option.state)
		elseif input.UserInputType == Enum.UserInputType.Touch then
			option:SetState(not option.state)
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.state then
				tweenService:Create(tickboxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 140)}):Play()
			end
		end
	end)
	
	main.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not option.state then
				tweenService:Create(tickboxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	
	function option:SetState(state)
		AUXLib.flags[self.flag] = state
		self.state = state
		checkmarkHolder:TweenSize(option.state and UDim2.new(1, -8, 1, -8) or UDim2.new(0, 0, 1, -8), "Out", "Quad", 0.2, true)
		tweenService:Create(tickboxInner, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = state and Color3.fromRGB(255, 65, 65) or Color3.fromRGB(20, 20, 20)}):Play()
		if state then
			tweenService:Create(tickboxOutline, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
		else
			if inContact then
				tweenService:Create(tickboxOutline, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 140)}):Play()
			else
				tweenService:Create(tickboxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
		self.callback(state)
	end

	if option.state then
		delay(1, function() option.callback(true) end)
	end
	
	setmetatable(option, {__newindex = function(t, i, v)
		if i == "Text" then
			main.Text = " " .. tostring(v)
		end
	end})
end

function createButton(option, parent)
	local main = AUXLib:Create("TextLabel", {
		ZIndex = 2,
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = parent.content
	})
	
	local round = AUXLib:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -12, 1, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local inContact
	local clicking
	main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			AUXLib.flags[option.flag] = true
			clicking = true
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			option.callback()
		elseif input.UserInputType == Enum.UserInputType.Touch then
			AUXLib.flags[option.flag] = true
			clicking = true
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			option.callback()
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
		end
	end)
	
	main.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			clicking = false
			if inContact then
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			clicking = false
			if inContact then
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not clicking then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
	end)
end

local function createSlider(option, parent)
	local main = AUXLib:Create("Frame", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 50),
		BackgroundTransparency = 1,
		Parent = parent.content
	})
	
	local title = AUXLib:Create("TextLabel", {
		Position = UDim2.new(0, 0, 0, 4),
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	local slider = AUXLib:Create("ImageLabel", {
		Position = UDim2.new(0, 10, 0, 34),
		Size = UDim2.new(1, -20, 0, 5),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local fill = AUXLib:Create("ImageLabel", {
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(60, 60, 60),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = slider
	})
	
	local circle = AUXLib:Create("ImageLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new((option.value - option.min) / (option.max - option.min), 0, 0.5, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(60, 60, 60),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 1,
		Parent = slider
	})
	
	local valueRound = AUXLib:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(0, -60, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local inputvalue = AUXLib:Create("TextBox", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = option.value,
		TextColor3 = Color3.fromRGB(235, 235, 235),
		TextSize = 15,
		TextWrapped = true,
		Font = Enum.Font.Gotham,
		Parent = valueRound
	})
	
	if option.min >= 0 then
		fill.Size = UDim2.new((option.value - option.min) / (option.max - option.min), 0, 1, 0)
	else
		fill.Position = UDim2.new((0 - option.min) / (option.max - option.min), 0, 0, 0)
		fill.Size = UDim2.new(option.value / (option.max - option.min), 0, 1, 0)
	end
	
	local sliding
	local inContact
	main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(3.5, 0, 3.5, 0), ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			sliding = true
			option:SetValue(option.min + ((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X) * (option.max - option.min))
		elseif input.UserInputType == Enum.UserInputType.Touch then
			tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(3.5, 0, 3.5, 0), ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
			sliding = true
			option:SetValue(option.min + ((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X) * (option.max - option.min))
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not sliding then
				tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	
	inputService.InputChanged:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and sliding then
			option:SetValue(option.min + ((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X) * (option.max - option.min))
		end
	end)

	main.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			sliding = false
			if inContact then
				tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			else
				tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			sliding = false
			if inContact then
				tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(2.8, 0, 2.8, 0), ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			else
				tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			inputvalue:ReleaseFocus()
			if not sliding then
				tweenService:Create(fill, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
				tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
	end)

	inputvalue.FocusLost:connect(function()
		tweenService:Create(circle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 0, 0, 0), ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
		option:SetValue(tonumber(inputvalue.Text) or option.value)
	end)

	function option:SetValue(value)
		value = round(value, option.float)
		value = math.clamp(value, self.min, self.max)
		circle:TweenPosition(UDim2.new((value - self.min) / (self.max - self.min), 0, 0.5, 0), "Out", "Quad", 0.1, true)
		if self.min >= 0 then
			fill:TweenSize(UDim2.new((value - self.min) / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
		else
			fill:TweenPosition(UDim2.new((0 - self.min) / (self.max - self.min), 0, 0, 0), "Out", "Quad", 0.1, true)
			fill:TweenSize(UDim2.new(value / (self.max - self.min), 0, 1, 0), "Out", "Quad", 0.1, true)
		end
		AUXLib.flags[self.flag] = value
		self.value = value
		inputvalue.Text = value
		self.callback(value)
	end
end

getFunctions = function(parent)
	function parent:AddLabel(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.type = "label"
		option.position = #self.options
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddToggle(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.state = typeof(option.state) == "boolean" and option.state or false
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "toggle"
		option.position = #self.options
		option.flag = option.flag or option.text
		AUXLib.flags[option.flag] = option.state
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddButton(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "button"
		option.position = #self.options
		option.flag = option.flag or option.text
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddSlider(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.min = typeof(option.min) == "number" and option.min or 0
		option.max = typeof(option.max) == "number" and option.max or 100
		option.value = math.clamp(typeof(option.value) == "number" and option.value or option.min, option.min, option.max)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.float = typeof(option.float) == "number" and option.float or 1
		option.type = "slider"
		option.position = #self.options
		option.flag = option.flag or option.text
		AUXLib.flags[option.flag] = option.value
		table.insert(self.options, option)
		
		return option
	end
	
	function parent:AddFolder(title)
		local option = {}
		option.title = tostring(title)
		option.options = {}
		option.open = false
		option.type = "folder"
		option.position = #self.options
		table.insert(self.options, option)
		
		getFunctions(option)
		
		function option:init()
			createOptionHolder(self.title, parent.content, self, true)
			loadOptions(self, parent)
		end
		
		return option
	end
end

loadOptions = function(option, holder)
	for _,newOption in next, option.options do
		if newOption.type == "label" then
			createLabel(newOption, option)
		elseif newOption.type == "toggle" then
			createToggle(newOption, option)
		elseif newOption.type == "button" then
			createButton(newOption, option)
		elseif newOption.type == "slider" then
			createSlider(newOption, option)
		elseif newOption.type == "folder" then
			newOption:init()
		end
	end
end

function AUXLib:CreateWindow(title)
	local window = {title = tostring(title), options = {}, open = true, canInit = true, init = false, position = #self.windows}
	getFunctions(window)
	
	table.insert(AUXLib.windows, window)
	
	return window
end

function AUXLib:Init()
	self.base = self.base or self:Create("ScreenGui")
	if syn and syn.protect_gui then
		syn.protect_gui(self.base)
		self.base.Parent = game:GetService("CoreGui")
	elseif gethui then
		self.base.Parent = gethui()
	else
		self.base.Parent = game:GetService("CoreGui")
	end
	self.base.ResetOnSpawn = false
	self.base.Name = "AUXScript"
	
	for _, window in next, self.windows do
		if window.canInit and not window.init then
			window.init = true
			createOptionHolder(window.title, self.base, window)
			loadOptions(window)
		end
	end
	
	return self.base
end

function AUXLib:Close()
	if typeof(self.base) ~= "Instance" then return end
	self.open = not self.open
	if self.activePopup then
		self.activePopup:Close()
	end
	for _, window in next, self.windows do
		if window.main then
			window.main.Visible = self.open
		end
	end
end

inputService.InputBegan:connect(function(input)
	if input.UserInputType == ui then
		if AUXLib.activePopup then
			if input.Position.X < AUXLib.activePopup.mainHolder.AbsolutePosition.X or input.Position.Y < AUXLib.activePopup.mainHolder.AbsolutePosition.Y then
				AUXLib.activePopup:Close()
			end
		end
		if AUXLib.activePopup then
			if input.Position.X > AUXLib.activePopup.mainHolder.AbsolutePosition.X + AUXLib.activePopup.mainHolder.AbsoluteSize.X or input.Position.Y > AUXLib.activePopup.mainHolder.AbsolutePosition.Y + AUXLib.activePopup.mainHolder.AbsoluteSize.Y then
				AUXLib.activePopup:Close()
			end
		end
	elseif input.UserInputType == Enum.UserInputType.Touch then
		if AUXLib.activePopup then
			if input.Position.X < AUXLib.activePopup.mainHolder.AbsolutePosition.X or input.Position.Y < AUXLib.activePopup.mainHolder.AbsolutePosition.Y then
				AUXLib.activePopup:Close()
			end
		end
		if AUXLib.activePopup then
			if input.Position.X > AUXLib.activePopup.mainHolder.AbsolutePosition.X + AUXLib.activePopup.mainHolder.AbsoluteSize.X or input.Position.Y > AUXLib.activePopup.mainHolder.AbsolutePosition.Y + AUXLib.activePopup.mainHolder.AbsoluteSize.Y then
				AUXLib.activePopup:Close()
			end
		end
	end
end)

inputService.InputChanged:connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

return AUXLib
