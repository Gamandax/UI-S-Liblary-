local library = {flags = {}, windows = {}, open = true}

--Services
local runService = game:GetService"RunService"
local tweenService = game:GetService"TweenService"
local textService = game:GetService"TextService"
local inputService = game:GetService"UserInputService"
local ui = Enum.UserInputType.MouseButton1
--Locals
local dragging, dragInput, dragStart, startPos, dragObject

--Functions
local function round(num, bracket)
	bracket = bracket or 1
	local a = math.floor(num/bracket + (math.sign(num) * 0.5)) * bracket
	if a < 0 then
		a = a + bracket
	end
	return a
end

local function safeDestroy(obj)
	if obj and obj.Parent then
		pcall(function() obj:Destroy() end)
	end
end

local function update(input)
	local delta = input.Position - dragStart
	local yPos = (startPos.Y.Offset + delta.Y) < -36 and -36 or startPos.Y.Offset + delta.Y
	dragObject:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, yPos), "Out", "Quint", 0.1, true)
end

-- Color chroma effect
local chromaColor = Color3.fromRGB(255, 0, 0)
spawn(function()
	while wait() do
		chromaColor = Color3.fromHSV(tick() % 5 / 5, 1, 1)
	end
end)

function library:Create(class, properties)
	properties = typeof(properties) == "table" and properties or {}
	local inst = Instance.new(class)
	for property, value in next, properties do
		inst[property] = value
	end
	return inst
end

local function createOptionHolder(holderTitle, parent, parentTable, subHolder)
	local size = subHolder and 34 or 40
	parentTable.main = library:Create("ImageButton", {
		LayoutOrder = subHolder and parentTable.position or 0,
		Position = UDim2.new(0, 20 + (250 * (parentTable.position or 0)), 0, 20), -- TORA SIZE: 250px spacing between windows
		Size = UDim2.new(0, 230, 0, size), 
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(26, 26, 26),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.04,
		ClipsDescendants = true,
		Parent = parent
	})
	
	local round
	if not subHolder then
		round = library:Create("ImageLabel", {
			Size = UDim2.new(1, 0, 0, size),
			BackgroundTransparency = 1,
			Image = "rbxassetid://3570695787",
			ImageColor3 = parentTable.open and (subHolder and Color3.fromRGB(16, 16, 16) or Color3.fromRGB(10, 10, 10)) or (subHolder and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(6, 6, 6)),
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100),
			SliceScale = 0.04,
			Parent = parentTable.main
		})
	end
	
	local title = library:Create("TextLabel", {
		Size = UDim2.new(1, 0, 0, size),
		BackgroundTransparency = subHolder and 0 or 1,
		BackgroundColor3 = Color3.fromRGB(35, 35, 35),
		BorderSizePixel = 0,
		Text = " " .. holderTitle, 
		TextSize = subHolder and 16 or 17,
		Font = Enum.Font.Gotham, 
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parentTable.main
	})
	
	local closeHolder = library:Create("Frame", {
		Position = UDim2.new(1, 0, 0, 0),
		Size = UDim2.new(-1, 0, 1, 0),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Parent = title
	})
	
	local close = library:Create("TextLabel", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -size - 10, 1, -size - 10),
		BackgroundTransparency = 1,
		Text = parentTable.open and "▼" or "▶",
		Font = Enum.Font.GothamBold,
		TextSize = 17,
		TextColor3 = parentTable.open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180),
		Parent = closeHolder
	})
	
	parentTable.content = library:Create("Frame", {
	Position = UDim2.new(0, 0, 0, size),
	Size = UDim2.new(1, 0, 1, -size),
	BackgroundTransparency = 1,
	ClipsDescendants = true, 
	Parent = parentTable.main
})
	
	local layout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = parentTable.content
	})
	
	layout.Changed:connect(function()
		parentTable.content.Size = UDim2.new(1, 0, 0, layout.AbsoluteContentSize.Y)
		parentTable.main.Size = #parentTable.options > 0 and parentTable.open and UDim2.new(0, 230, 0, layout.AbsoluteContentSize.Y + size) or UDim2.new(0, 230, 0, size) -- TORA SIZE: 230px width
	end)
	
	if not subHolder then
		library:Create("UIPadding", {
			Parent = parentTable.content
		})
		
		-- Phone Draggable ( i use Wally function for this lmao )
		title.InputBegan:connect(function(input)
			if input.UserInputType == ui or input.UserInputType == Enum.UserInputType.Touch then
				dragObject = parentTable.main
				dragging = true
				dragStart = input.Position
				startPos = dragObject.Position
			end
		end)
		
		title.InputChanged:connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				dragInput = input
			end
		end)
		
		title.InputEnded:connect(function(input)
			if input.UserInputType == ui or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)
	end
	
	closeHolder.InputBegan:connect(function(input)
		if input.UserInputType == ui or input.UserInputType == Enum.UserInputType.Touch then
			parentTable.open = not parentTable.open
			close.Text = parentTable.open and "▼" or "▶"
			tweenService:Create(close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = parentTable.open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)}):Play()
			if subHolder then
				tweenService:Create(title, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = parentTable.open and Color3.fromRGB(16, 16, 16) or Color3.fromRGB(35, 35, 35)}):Play()
			else
				tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = parentTable.open and Color3.fromRGB(10, 10, 10) or Color3.fromRGB(6, 6, 6)}):Play()
			end
			parentTable.main:TweenSize(#parentTable.options > 0 and parentTable.open and UDim2.new(0, 230, 0, layout.AbsoluteContentSize.Y + size) or UDim2.new(0, 230, 0, size), "Out", "Quad", 0.2, true) -- TORA SIZE: 230px width
		end
	end)

	function parentTable:SetTitle(newTitle)
		title.Text = tostring(newTitle)
	end
	
	return parentTable
end

function createButton(option, parent)
	local ButtonHolder = library:Create("Frame", {
	LayoutOrder = option.position,
	Name = "ButtonHolder",
	Size = UDim2.new(1, 0, 0, 34), 
	BackgroundTransparency = 1,
	Parent = parent.content
})

	local Button = library:Create("TextButton", {
	Name = "Button",
	BackgroundTransparency = 1,
	Position = UDim2.new(0, 6, 0, 2), 
	Size = UDim2.new(1, -12, 1, -4), 
	ZIndex = 4,
	Font = Enum.Font.Gotham, 
	Text = option.text or "Button",
	TextColor3 = Color3.fromRGB(255, 255, 255),
	TextSize = 17, 
	TextWrapped = true,
	ClipsDescendants = true,
	Parent = ButtonHolder
})

	local Round = library:Create("ImageLabel", {
		Name = "Button_Roundify_5px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40), 
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02, 
		Parent = Button
	})
  
	local CircleSeed = game.CoreGui:FindFirstChild("Circle")
	if not CircleSeed then
		CircleSeed = library:Create("ImageLabel", {
			Name = "Circle",
			BackgroundTransparency = 1,
			ZIndex = 10,
			Image = "http://www.roblox.com/asset/?id=266543268",
			ImageColor3 = Color3.fromRGB(126, 126, 126),
			ImageTransparency = 0.7,
			Parent = game.CoreGui
		})
	end

	local function CircleClick(ButtonObj, X, Y)
		pcall(function()
			local c = CircleSeed:Clone()
			c.Parent = ButtonObj
			local NewX = X - ButtonObj.AbsolutePosition.X
			local NewY = Y - ButtonObj.AbsolutePosition.Y
			c.Position = UDim2.new(0, NewX, 0, NewY)

			local Size = ButtonObj.AbsoluteSize.X >= ButtonObj.AbsoluteSize.Y and ButtonObj.AbsoluteSize.X * 1.5 or ButtonObj.AbsoluteSize.Y * 1.5
			local Time = 0.5
			
			c:TweenSizeAndPosition(
				UDim2.new(0, Size, 0, Size),
				UDim2.new(0.5, -Size/2, 0.5, -Size/2),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quad,
				Time,
				false
			)
			
			for _ = 1, 10 do
				c.ImageTransparency = c.ImageTransparency + 0.03
				task.wait(Time/10)
			end
			safeDestroy(c)
		end)
	end

	local Mouse = game.Players.LocalPlayer:GetMouse()
	Button.MouseButton1Click:Connect(function()
		library.flags[option.flag] = true
		if option.callback then pcall(option.callback) end
		task.spawn(function() CircleClick(Button, Mouse.X, Mouse.Y) end)
	end)
end

function createToggle(option, parent)
	local ToggleHolder = library:Create("Frame", {
	LayoutOrder = option.position,
	Name = "ToggleHolder",
	Size = UDim2.new(1, 0, 0, 31), 
	BackgroundTransparency = 1,
	Parent = parent.content
})

	local ToggleText = library:Create("TextLabel", {
		Name = "ToggleText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0), 
		Size = UDim2.new(1, -50, 1, 0),
		ZIndex = 3,
		Font = Enum.Font.Gotham, 
		Text = " " .. (option.text or "Toggle"),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 17, 
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = ToggleHolder
	})

	local ToggleImage = library:Create("ImageLabel", {
		Name = "ToggleImage",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -25, 0.5, -10), 
		Size = UDim2.new(0, 20, 0, 20), 
		ZIndex = 2,
		Image = "http://www.roblox.com/asset/?id=4908273649",
		Parent = ToggleHolder
	})

	local MainToggle = library:Create("ImageButton", {
		Name = "MainToggle",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -25, 0.5, -10), 
		Size = UDim2.new(0, 20, 0, 20), 
		ZIndex = 3,
		Image = "http://www.roblox.com/asset/?id=4908257956",
		ImageColor3 = Color3.fromRGB(255, 65, 65), 
		ImageTransparency = option.state and 0 or 1,
		Parent = ToggleHolder
	})

	MainToggle.MouseButton1Click:Connect(function()
		option:SetState(not option.state)
	end)

	function option:SetState(state)
		library.flags[self.flag] = state
		self.state = state
		tweenService:Create(MainToggle, TweenInfo.new(0.2), {ImageTransparency = state and 0 or 1}):Play()
		self.callback(state)
	end

	if option.state then
		delay(1, function() option.callback(true) end)
	end
	
	setmetatable(option, {__newindex = function(t, i, v)
		if i == "Text" then
			ToggleText.Text = tostring(v)
		end
	end})
end

function createSlider(option, parent)
	local SliderHolder = library:Create("Frame", {
	LayoutOrder = option.position,
	Name = "SliderHolder",
	Size = UDim2.new(1, 0, 0, 50), 
	BackgroundTransparency = 1,
	Parent = parent.content
})

	local SliderTitle = library:Create("TextLabel", {
		Name = "SliderTitle",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 4), 
		Size = UDim2.new(1, -20, 0, 20), 
		ZIndex = 3,
		Font = Enum.Font.Gotham, 
		LineHeight = 1.2,
		Text = " " .. (option.text or "Slider"),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 17, 
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = SliderHolder
	})

	local ValueText = library:Create("TextLabel", {
		Name = "ValueText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 4), 
		Size = UDim2.new(1, -20, 0, 20), 
		ZIndex = 3,
		Font = Enum.Font.Gotham, 
		LineHeight = 1.2,
		Text = option.value .. "/" .. option.max,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 17, 
		TextTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = SliderHolder
	})

	local SliderFrame = library:Create("TextButton", {
		Name = "SliderFrame",
		BackgroundColor3 = Color3.fromRGB(30, 30, 30), 
		BorderSizePixel = 0,
		Position = UDim2.new(0, 10, 0, 34), 
		Size = UDim2.new(1, -20, 0, 5), 
		ZIndex = 3,
		Text = "",
		Parent = SliderHolder
	})

	local Slider = library:Create("Frame", {
		Name = "Slider",
		BackgroundColor3 = Color3.fromRGB(255, 65, 65), 
		BorderSizePixel = 0,
		Size = UDim2.new((option.value - option.min) / (option.max - option.min), 0, 0, 5),
		ZIndex = 4,
		Parent = SliderFrame
	})

	local UIGradient = library:Create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 116, 116))
		},
		Parent = Slider
	})

	local Connection
	local isDragging = false

	inputService.InputEnded:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and isDragging then
			if Connection then Connection:Disconnect() Connection = nil end
			isDragging = false
			tweenService:Create(ValueText, TweenInfo.new(.2), {TextTransparency = 1}):Play()
		end
	end)

	SliderFrame.MouseButton1Down:Connect(function()
		pcall(function()
			if Connection then Connection:Disconnect() end
			isDragging = true
			Connection = runService.RenderStepped:Connect(function()
				if not isDragging then if Connection then Connection:Disconnect() Connection = nil end return end
				local Mouse = inputService:GetMouseLocation()
				local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)
				local GetValue = option.min + (option.max - option.min) * Percentage
				GetValue = option.float and string.format("%.2f", GetValue) or math.floor(GetValue)
				option:SetValue(tonumber(GetValue))
				Slider:TweenSize(UDim2.new(Percentage, 0, 0, 6), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .03, true)
				ValueText.Text = GetValue .. "/" .. option.max
				tweenService:Create(ValueText, TweenInfo.new(.2), {TextTransparency = 0}):Play()
			end)
		end)
	end)

	function option:SetValue(value)
		value = math.clamp(value, self.min, self.max)
		library.flags[self.flag] = value
		self.value = value
		ValueText.Text = value .. "/" .. self.max
		self.callback(value)
	end
end

-- KEYBIND FUNCTION
local function createBind(option, parent)
	local binding
	local holding
	local loop
	local text = string.match(option.key, "Mouse") and string.sub(option.key, 1, 5) .. string.sub(option.key, 12, 13) or option.key

	local main = library:Create("TextLabel", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 33),
		BackgroundTransparency = 1,
		Text = " " .. option.text,
		TextSize = 17,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = parent.content
	})
	
	local round = library:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(0, -textService:GetTextSize(text, 16, Enum.Font.Gotham, Vector2.new(9e9, 9e9)).X - 16, 1, -10),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local bindinput = library:Create("TextLabel", {
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = text,
		TextSize = 16,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = round
	})
	
	local inContact
	main.InputBegan:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not binding then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
	end)
	 
	main.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			binding = true
			bindinput.Text = "..."
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
		elseif input.UserInputType == Enum.UserInputType.Touch then
			binding = true
			bindinput.Text = "..."
			tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255, 65, 65)}):Play()
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not binding then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
	end)
	
	inputService.InputBegan:connect(function(input)
		if inputService:GetFocusedTextBox() then return end
		if (input.KeyCode.Name == option.key or input.UserInputType.Name == option.key) and not binding then
			if option.hold then
				loop = runService.Heartbeat:connect(function()
					if binding then
						option.callback(true)
						loop:Disconnect()
						loop = nil
					else
						option.callback()
					end
				end)
			else
				option.callback()
			end
		elseif binding then
			local key
			pcall(function()
				if input.KeyCode ~= Enum.KeyCode.Unknown then
					key = input.KeyCode
				end
			end)
			pcall(function()
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 then
					key = input.UserInputType
				end
			end)
			key = key or option.key
			option:SetKey(key)
		end
	end)
	
	inputService.InputEnded:connect(function(input)
		if input.KeyCode.Name == option.key or input.UserInputType.Name == option.key or input.UserInputType.Name == "MouseMovement" then
			if loop then
				loop:Disconnect()
				loop = nil
				option.callback(true)
			end
		end
	end)
	
	function option:SetKey(key)
		binding = false
		if loop then
			loop:Disconnect()
			loop = nil
		end
		self.key = key or self.key
		self.key = self.key.Name or self.key
		library.flags[self.flag] = self.key
		if string.match(self.key, "Mouse") then
			bindinput.Text = string.sub(self.key, 1, 5) .. string.sub(self.key, 12, 13)
		else
			bindinput.Text = self.key
		end
		tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = inContact and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)}):Play()
		round.Size = UDim2.new(0, -textService:GetTextSize(bindinput.Text, 15, Enum.Font.Gotham, Vector2.new(9e9, 9e9)).X - 16, 1, -10)	
	end
end

-- DROPDOWN FUNCTION
local function createList(option, parent, holder)
	local valueCount = 0
	
	local main = library:Create("Frame", {
		LayoutOrder = option.position,
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundTransparency = 1,
		Parent = parent.content
	})
	
	local round = library:Create("ImageLabel", {
		Position = UDim2.new(0, 6, 0, 4),
		Size = UDim2.new(1, -12, 1, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = main
	})
	
	local title = library:Create("TextLabel", {
		Position = UDim2.new(0, 12, 0, 8),
		Size = UDim2.new(1, -24, 0, 14),
		BackgroundTransparency = 1,
		Text = option.text,
		TextSize = 14,
		Font = Enum.Font.GothamBold,
		TextColor3 = Color3.fromRGB(140, 140, 140),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	local listvalue = library:Create("TextLabel", {
		Position = UDim2.new(0, 12, 0, 20),
		Size = UDim2.new(1, -24, 0, 24),
		BackgroundTransparency = 1,
		Text = option.value,
		TextSize = 18,
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = main
	})
	
	library:Create("ImageLabel", {
		Position = UDim2.new(1, -16, 0, 16),
		Size = UDim2.new(-1, 32, 1, -32),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		Rotation = 90,
		BackgroundTransparency = 1,
		Image = "rbxassetid://4918373417",
		ImageColor3 = Color3.fromRGB(140, 140, 140),
		ScaleType = Enum.ScaleType.Fit,
		Parent = round
	})
	
	option.mainHolder = library:Create("ImageButton", {
		ZIndex = 3,
		Size = UDim2.new(0, 240, 0, 52),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Visible = false,
		Parent = library.base or game.CoreGui
	})
	
	local content = library:Create("ScrollingFrame", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarImageColor3 = Color3.fromRGB(),
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		Parent = option.mainHolder
	})
	
	library:Create("UIPadding", {
		PaddingTop = UDim.new(0, 6),
		Parent = content
	})
	
	local layout = library:Create("UIListLayout", {
		Parent = content
	})
	
	layout.Changed:connect(function()
		option.mainHolder.Size = UDim2.new(0, 240, 0, (valueCount > 4 and (4 * 40) or layout.AbsoluteContentSize.Y) + 12)
		content.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 12)
	end)
	
	local inContact
	round.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = main.AbsolutePosition
			option.mainHolder.Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			content.ScrollBarThickness = 6
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, position.X - 5, 0, position.Y - 4)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, position.X - 5, 0, position.Y + 1)}):Play()
			for _,label in next, content:GetChildren() do
				if label:IsA"TextLabel" then
					tweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
				end
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = main.AbsolutePosition
			option.mainHolder.Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			content.ScrollBarThickness = 6
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, position.X - 5, 0, position.Y - 4)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, position.X - 5, 0, position.Y + 1)}):Play()
			for _,label in next, content:GetChildren() do
				if label:IsA"TextLabel" then
					tweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, TextTransparency = 0}):Play()
				end
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.open then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(60, 60, 60)}):Play()
			end
		end
	end)
	
	round.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not option.open then
				tweenService:Create(round, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end
		end
	end)
	
	function option:AddValue(value)
		valueCount = valueCount + 1
		local label = library:Create("TextLabel", {
			ZIndex = 3,
			Size = UDim2.new(1, 0, 0, 40),
			BackgroundColor3 = Color3.fromRGB(30, 30, 30),
			BorderSizePixel = 0,
			Text = "    " .. value,
			TextSize = 14,
			TextTransparency = self.open and 0 or 1,
			Font = Enum.Font.Gotham,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = content
		})
		
		local inContact
		local clicking
		label.InputBegan:connect(function(input)
			if input.UserInputType == ui then
				clicking = true
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
				self:SetValue(value)
			elseif input.UserInputType == Enum.UserInputType.Touch then
				clicking = true
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(10, 10, 10)}):Play()
				self:SetValue(value)
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				inContact = true
				if not clicking then
					tweenService:Create(label, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}):Play()
				end
			end
		end)
		
		label.InputEnded:connect(function(input)
			if input.UserInputType == ui then
				clicking = false
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = inContact and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(30, 30, 30)}):Play()
			elseif input.UserInputType == Enum.UserInputType.Touch then
				clicking = false
				tweenService:Create(label, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = inContact and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(30, 30, 30)}):Play()
			end
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				inContact = false
				if not clicking then
					tweenService:Create(label, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
				end
			end
		end)
	end

	if option.values then
		for _, value in next, option.values do
			option:AddValue(tostring(value))
		end
	end
	
	function option:RemoveValue(value)
		for _,label in next, content:GetChildren() do
			if label:IsA"TextLabel" and label.Text == "    " .. value then
				label:Destroy()
				valueCount = valueCount - 1
				break
			end
		end
		if self.value == value then
			self:SetValue("")
		end
	end
	
	function option:SetValue(value)
		library.flags[self.flag] = tostring(value)
		self.value = tostring(value)
		listvalue.Text = self.value
		self.callback(value)
		if library.activePopup and library.activePopup == self then
			self:Close()
		end
	end
	
	function option:Close()
		library.activePopup = nil
		self.open = false
		content.ScrollBarThickness = 0
		local position = main.AbsolutePosition
		tweenService:Create(round, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = inContact and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(40, 40, 40)}):Play()
		tweenService:Create(self.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.new(0, position.X - 5, 0, position.Y -10)}):Play()
		for _,label in next, content:GetChildren() do
			if label:IsA"TextLabel" then
				tweenService:Create(label, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
			end
		end
		wait(0.3)
		if not self.open then
			self.mainHolder.Visible = false
		end
	end

	return option
end

-- COLOR PICKER FUNCTION
local function createColor(option, parent, holder)
	option.main = library:Create("TextLabel", {
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
	
	local colorBoxOutline = library:Create("ImageLabel", {
		Position = UDim2.new(1, -6, 0, 4),
		Size = UDim2.new(-1, 10, 1, -10),
		SizeConstraint = Enum.SizeConstraint.RelativeYY,
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(100, 100, 100),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.main
	})
	
	option.visualize = library:Create("ImageLabel", {
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(1, -4, 1, -4),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = option.color,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = colorBoxOutline
	})

	-- Color Picker Window
	option.mainHolder = library:Create("ImageButton", {
		ZIndex = 3,
		Size = UDim2.new(0, 240, 0, 180),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 1,
		ImageColor3 = Color3.fromRGB(30, 30, 30),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Visible = false,
		Parent = library.base or game.CoreGui
	})
	
	local hue, sat, val = Color3.toHSV(option.color)
	hue, sat, val = hue == 0 and 1 or hue, sat + 0.005, val - 0.005
	local editinghue, editingsatval
	local currentColor = option.color
	local rainbowEnabled, rainbowLoop
	
	function option:updateVisuals(Color)
		currentColor = Color
		self.visualize2.ImageColor3 = Color
		hue, sat, val = Color3.toHSV(Color)
		hue = hue == 0 and 1 or hue
		self.satval.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
		self.hueSlider.Position = UDim2.new(1 - hue, 0, 0, 0)
		self.satvalSlider.Position = UDim2.new(sat, 0, 1 - val, 0)
	end
	
	-- Hue Bar
	option.hue = library:Create("ImageLabel", {
		ZIndex = 3,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 8, 1, -8),
		Size = UDim2.new(1, -100, 0, 22),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageTransparency = 0,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	local Gradient = library:Create("UIGradient", {
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(0.157, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(0.323, Color3.fromRGB(0, 0, 255)),
			ColorSequenceKeypoint.new(0.488, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 0)),
			ColorSequenceKeypoint.new(0.817, Color3.fromRGB(255, 255, 0)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
		}),
		Parent = option.hue
	})
	
	option.hueSlider = library:Create("Frame", {
		ZIndex = 3,
		Position = UDim2.new(1 - hue, 0, 0, 0),
		Size = UDim2.new(0, 2, 1, 0),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Parent = option.hue
	})
	
	-- Saturation/Value Box
	option.satval = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(0, 8, 0, 8),
		Size = UDim2.new(1, -100, 1, -42),
		BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
		BorderSizePixel = 0,
		Image = "rbxassetid://4155801252",
		ImageTransparency = 0,
		ClipsDescendants = true,
		Parent = option.mainHolder
	})
	
	option.satvalSlider = library:Create("Frame", {
		ZIndex = 3,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(sat, 0, 1 - val, 0),
		Size = UDim2.new(0, 4, 0, 4),
		Rotation = 45,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Parent = option.satval
	})
	
	-- Color 
	option.visualize2 = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -8, 0, 8),
		Size = UDim2.new(0, -80, 0, 80),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = currentColor,
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	-- Set Button 
	local setColor = library:Create("ImageLabel", {
		ZIndex = 3,
		Position = UDim2.new(1, -8, 0, 132),
		Size = UDim2.new(0, -80, 0, 18),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(20, 20, 20),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = option.mainHolder
	})
	
	local setText = library:Create("TextLabel", {
		ZIndex = 3,
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundTransparency = 1,
		Text = "Set",
		Font = Enum.Font.Code,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Parent = setColor
	})
	
	-- Input Handling
	local inContact
	option.main.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = option.main.AbsolutePosition
			option.mainHolder.Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, position.X - 5, 0, position.Y - 4)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, position.X - 5, 0, position.Y + 1)}):Play()
			for _,object in next, option.mainHolder:GetDescendants() do
				if object:IsA"TextLabel" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				elseif object:IsA"ImageLabel" and object ~= option.mainHolder then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				elseif object:IsA"Frame" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				end
			end
		elseif input.UserInputType == Enum.UserInputType.Touch then
			if library.activePopup then
				library.activePopup:Close()
			end
			local position = option.main.AbsolutePosition
			option.mainHolder.Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)
			option.open = true
			option.mainHolder.Visible = true
			library.activePopup = option
			tweenService:Create(option.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0, position.X - 5, 0, position.Y - 4)}):Play()
			tweenService:Create(option.mainHolder, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0.1), {Position = UDim2.new(0, position.X - 5, 0, position.Y + 1)}):Play()
			for _,object in next, option.mainHolder:GetDescendants() do
				if object:IsA"TextLabel" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
				elseif object:IsA"ImageLabel" and object ~= option.mainHolder then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
				elseif object:IsA"Frame" then
					tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
				end
			end
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = true
			if not option.open then
				tweenService:Create(colorBoxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(140, 140, 140)}):Play()
			end
		end
	end)
	
	option.main.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			inContact = false
			if not option.open then
				tweenService:Create(colorBoxOutline, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(100, 100, 100)}):Play()
			end
		end
	end)
	
	-- Hue Slider Input
	option.hue.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			editinghue = true
			local X = (option.hue.AbsolutePosition.X + option.hue.AbsoluteSize.X) - option.hue.AbsolutePosition.X
			X = (input.Position.X - option.hue.AbsolutePosition.X) / X
			X = X < 0 and 0 or X > 0.995 and 0.995 or X
			option:updateVisuals(Color3.fromHSV(1 - X, sat, val))
		elseif input.UserInputType == Enum.UserInputType.Touch then
			editinghue = true
			local X = (option.hue.AbsolutePosition.X + option.hue.AbsoluteSize.X) - option.hue.AbsolutePosition.X
			X = (input.Position.X - option.hue.AbsolutePosition.X) / X
			X = X < 0 and 0 or X > 0.995 and 0.995 or X
			option:updateVisuals(Color3.fromHSV(1 - X, sat, val))
		end
	end)
	
	inputService.InputChanged:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and editinghue then
			local X = (option.hue.AbsolutePosition.X + option.hue.AbsoluteSize.X) - option.hue.AbsolutePosition.X
			X = (input.Position.X - option.hue.AbsolutePosition.X) / X
			X = X <= 0 and 0 or X >= 0.995 and 0.995 or X
			option:updateVisuals(Color3.fromHSV(1 - X, sat, val))
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement and editingsatval then
			local X = (option.satval.AbsolutePosition.X + option.satval.AbsoluteSize.X) - option.satval.AbsolutePosition.X
			local Y = (option.satval.AbsolutePosition.Y + option.satval.AbsoluteSize.Y) - option.satval.AbsolutePosition.Y
			X = (input.Position.X - option.satval.AbsolutePosition.X) / X
			Y = (input.Position.Y - option.satval.AbsolutePosition.Y) / Y
			X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
			Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
			option:updateVisuals(Color3.fromHSV(hue, X, 1 - Y))
		end
	end)
	
	option.hue.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			editinghue = false
		elseif input.UserInputType == Enum.UserInputType.Touch then
			editinghue = false
		end
	end)
	
	-- Saturation/Value Input ( Shizo help me make this )
	option.satval.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			editingsatval = true
			local X = (option.satval.AbsolutePosition.X + option.satval.AbsoluteSize.X) - option.satval.AbsolutePosition.X
			local Y = (option.satval.AbsolutePosition.Y + option.satval.AbsoluteSize.Y) - option.satval.AbsolutePosition.Y
			X = (input.Position.X - option.satval.AbsolutePosition.X) / X
			Y = (input.Position.Y - option.satval.AbsolutePosition.Y) / Y
			X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
			Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
			option:updateVisuals(Color3.fromHSV(hue, X, 1 - Y))
		elseif input.UserInputType == Enum.UserInputType.Touch then
			editingsatval = true
			local X = (option.satval.AbsolutePosition.X + option.satval.AbsoluteSize.X) - option.satval.AbsolutePosition.X
			local Y = (option.satval.AbsolutePosition.Y + option.satval.AbsoluteSize.Y) - option.satval.AbsolutePosition.Y
			X = (input.Position.X - option.satval.AbsolutePosition.X) / X
			Y = (input.Position.Y - option.satval.AbsolutePosition.Y) / Y
			X = X <= 0.005 and 0.005 or X >= 1 and 1 or X
			Y = Y <= 0 and 0 or Y >= 0.995 and 0.995 or Y
			option:updateVisuals(Color3.fromHSV(hue, X, 1 - Y))
		end
	end)
	
	option.satval.InputEnded:connect(function(input)
		if input.UserInputType == ui then
			editingsatval = false
		elseif input.UserInputType == Enum.UserInputType.Touch then
			editingsatval = false
		end
	end)
	
	-- Set Button Input
	setColor.InputBegan:connect(function(input)
		if input.UserInputType == ui then
			option:SetColor(currentColor)
		elseif input.UserInputType == Enum.UserInputType.Touch then
			option:SetColor(currentColor)
		end
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			tweenService:Create(setColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(10, 10, 10)}):Play()
		end
	end)
	
	setColor.InputEnded:connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			tweenService:Create(setColor, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(20, 20, 20)}):Play()
		end
	end)
	
	function option:SetColor(newColor)
		if self.mainHolder then
			self:updateVisuals(newColor)
		end
		self.visualize.ImageColor3 = newColor
		library.flags[self.flag] = newColor
		self.color = newColor
		self.callback(newColor)
	end
	
	function option:Close()
		library.activePopup = nil
		self.open = false
		local position = self.main.AbsolutePosition
		tweenService:Create(self.mainHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1, Position = UDim2.new(0, position.X - 5, 0, position.Y - 10)}):Play()
		for _,object in next, self.mainHolder:GetDescendants() do
			if object:IsA"TextLabel" then
				tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
			elseif object:IsA"ImageLabel" and object ~= self.mainHolder then
				tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
			elseif object:IsA"Frame" then
				tweenService:Create(object, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
			end
		end
		wait(0.3)
		if not self.open then
			self.mainHolder.Visible = false
		end 
	end
end

-- BOX FUNCTION
function createBox(option, parent)
	local BoxHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "BoxHolder",
		Size = UDim2.new(1, 0, 0, 52),
		BackgroundTransparency = 1,
		Parent = parent.content
	})

	local BoxText = library:Create("TextLabel", {
		Name = "BoxText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 8),
		Size = UDim2.new(1, -24, 0, 14),
		ZIndex = 3,
		Font = Enum.Font.GothamBold,
		LineHeight = 1.1,
		Text = option.text or "TextBox",
		TextColor3 = Color3.fromRGB(140, 140, 140),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = BoxHolder
	})

	local BoxBackground = library:Create("ImageLabel", {
		Position = UDim2.new(0, 6, 0, 4),
		Size = UDim2.new(1, -12, 1, -10),
		BackgroundTransparency = 1,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(40, 40, 40),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.02,
		Parent = BoxHolder
	})

	local Box = library:Create("TextBox", {
		Name = "Box",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 20),
		Size = UDim2.new(1, -24, 0, 24),
		ZIndex = 4,
		Font = Enum.Font.Gotham,
		LineHeight = 1.5,
		PlaceholderColor3 = Color3.fromRGB(100, 100, 100),
		Text = option.value or "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 18,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
		Parent = BoxHolder
	})

	Box.FocusLost:Connect(function(enter)
		if enter and Box.Text ~= "" and Box.Text ~= " " then
			option:SetValue(Box.Text, enter)
		end
	end)

	Box.Changed:Connect(function()
		Box.TextScaled = (#Box.Text >= 15)
	end)

	function option:SetValue(value, enter)
		library.flags[self.flag] = tostring(value)
		self.value = tostring(value)
		Box.Text = self.value
		self.callback(value, enter)
	end
end

-- LABEL FUNCTION
local function createLabel(option, parent)
	local main = library:Create("TextLabel", {
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

-- LOAD OPTIONS FUNCTION
local function loadOptions(option, holder)
	for _,newOption in next, option.options do
		if newOption.type == "label" then
			createLabel(newOption, option)
		elseif newOption.type == "toggle" then
			createToggle(newOption, option)
		elseif newOption.type == "button" then
			createButton(newOption, option)
		elseif newOption.type == "slider" then
			createSlider(newOption, option)
		elseif newOption.type == "box" then
			createBox(newOption, option)
		elseif newOption.type == "bind" then
			createBind(newOption, option)
		elseif newOption.type == "list" then
			createList(newOption, option, holder)
		elseif newOption.type == "color" then
			createColor(newOption, option, holder)
		elseif newOption.type == "folder" then
			newOption:init()
		end
	end
end

-- GET FUNCTIONS
local function getFunctions(parent)
	function parent:AddLabel(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.type = "label"
		option.position = #self.options
		table.insert(self.options, option)
		return option
	end
	
	function parent:AddBind(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.key = (option.key and option.key.Name) or option.key or "F"
		option.hold = typeof(option.hold) == "boolean" and option.hold or false
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "bind"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.key
		table.insert(self.options, option)
		return option
	end
	
	function parent:AddList(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.values = typeof(option.values) == "table" and option.values or {}
		option.value = tostring(option.value or option.values[1] or "")
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.open = false
		option.type = "list"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.value
		table.insert(self.options, option)
		return option
	end
	
	function parent:AddColor(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.color = typeof(option.color) == "table" and Color3.new(tonumber(option.color[1]), tonumber(option.color[2]), tonumber(option.color[3])) or option.color or Color3.new(1, 1, 1)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.open = false
		option.type = "color"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.color
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
		library.flags[option.flag] = option.state
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
		option.float = typeof(option.float) == "boolean" and option.float or false
		option.type = "slider"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.value
		table.insert(self.options, option)
		return option
	end

	function parent:AddBox(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.value = tostring(option.value or "")
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "box"
		option.position = #self.options
		option.flag = option.flag or option.text
		library.flags[option.flag] = option.value
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

function library:CreateWindow(title)
	local window = {title = tostring(title), options = {}, open = true, canInit = true, init = false, position = #self.windows}
	getFunctions(window)
	
	table.insert(library.windows, window)
	
	return window
end

function library:Init()
	self.base = self.base or self:Create("ScreenGui")
	if syn and syn.protect_gui then
		syn.protect_gui(self.base)
	elseif get_hidden_gui then
		get_hidden_gui(self.base)
	elseif gethui then
		gethui(self.base)
	else
		game:GetService"Players".LocalPlayer:Kick("Error: protect_gui function not found")
		return
	end
	self.base.Parent = game:GetService"CoreGui"
	self.base.ResetOnSpawn = true
	self.base.Name = "ToraZenLibrary"
	
	for _, window in next, self.windows do
		if window.canInit and not window.init then
			window.init = true
			createOptionHolder(window.title, self.base, window)
			loadOptions(window)
		end
	end
	return self.base
end

function library:Close()
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
	-- Close popups when clicking outside
	if input.UserInputType == ui or input.UserInputType == Enum.UserInputType.Touch then
		if library.activePopup then
			if input.Position.X < library.activePopup.mainHolder.AbsolutePosition.X or input.Position.Y < library.activePopup.mainHolder.AbsolutePosition.Y then
				library.activePopup:Close()
			end
			if input.Position.X > library.activePopup.mainHolder.AbsolutePosition.X + library.activePopup.mainHolder.AbsoluteSize.X or input.Position.Y > library.activePopup.mainHolder.AbsolutePosition.Y + library.activePopup.mainHolder.AbsoluteSize.Y then
				library.activePopup:Close()
			end
		end
	end
	-- Right shift to toggle library
	if input.KeyCode == Enum.KeyCode.RightShift then
		library:Close()
	end
end)

inputService.InputChanged:connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

return library
