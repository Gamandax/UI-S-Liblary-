-- // My First Very Clean Library \\ --
-- // Zen Library Lua ( Version 1.1.0.0 ) \\ --

local library = {count = 0, currentTheme = "dark"}

-- Theme configurations
local themes = {
	dark = {
		windowBg    = Color3.fromRGB(26, 26, 26),
		containerBg = Color3.fromRGB(35, 35, 35),
		buttonBg    = Color3.fromRGB(45, 45, 45),
		textBoxBg   = Color3.fromRGB(43, 43, 43),
		textColor   = Color3.fromRGB(255, 255, 255),
		toggleBg    = Color3.fromRGB(90, 255, 115),
		sliderBg    = Color3.fromRGB(255, 255, 255),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 116, 116))
		}
	},

	light = {
		windowBg    = Color3.fromRGB(240, 240, 240),
		containerBg = Color3.fromRGB(255, 255, 255),
		buttonBg    = Color3.fromRGB(230, 230, 230),
		textBoxBg   = Color3.fromRGB(245, 245, 245),
		textColor   = Color3.fromRGB(50, 50, 50),
		toggleBg    = Color3.fromRGB(76, 175, 80),
		sliderBg    = Color3.fromRGB(200, 200, 200),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(33, 150, 243)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(100, 181, 246))
		}
	},

	ocean = {
		windowBg    = Color3.fromRGB(10, 25, 47),
		containerBg = Color3.fromRGB(15, 40, 70),
		buttonBg    = Color3.fromRGB(20, 60, 100),
		textBoxBg   = Color3.fromRGB(25, 70, 120),
		textColor   = Color3.fromRGB(230, 245, 255),
		toggleBg    = Color3.fromRGB(0, 180, 200),
		sliderBg    = Color3.fromRGB(180, 220, 255),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 128, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 255, 200))
		}
	},

	y2k = {
		windowBg    = Color3.fromRGB(25, 5, 35),
		containerBg = Color3.fromRGB(40, 10, 60),
		buttonBg    = Color3.fromRGB(80, 0, 120),
		textBoxBg   = Color3.fromRGB(60, 0, 90),
		textColor   = Color3.fromRGB(255, 255, 255),
		toggleBg    = Color3.fromRGB(0, 255, 200),
		sliderBg    = Color3.fromRGB(180, 180, 200),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 255)),
			ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 0))
		}
	},

	midnight = {
		windowBg    = Color3.fromRGB(15, 15, 30),
		containerBg = Color3.fromRGB(25, 25, 45),
		buttonBg    = Color3.fromRGB(35, 35, 60),
		textBoxBg   = Color3.fromRGB(30, 30, 50),
		textColor   = Color3.fromRGB(200, 210, 255),
		toggleBg    = Color3.fromRGB(100, 140, 255),
		sliderBg    = Color3.fromRGB(80, 80, 120),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 90, 200)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(120, 180, 255))
		}
	},

	sunset = {
		windowBg    = Color3.fromRGB(50, 20, 30),
		containerBg = Color3.fromRGB(70, 30, 50),
		buttonBg    = Color3.fromRGB(100, 40, 60),
		textBoxBg   = Color3.fromRGB(80, 30, 50),
		textColor   = Color3.fromRGB(255, 220, 200),
		toggleBg    = Color3.fromRGB(255, 140, 90),
		sliderBg    = Color3.fromRGB(180, 120, 120),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 100, 100)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 180, 120))
		}
	},

	forest = {
		windowBg    = Color3.fromRGB(15, 25, 15),
		containerBg = Color3.fromRGB(25, 40, 25),
		buttonBg    = Color3.fromRGB(35, 60, 35),
		textBoxBg   = Color3.fromRGB(30, 50, 30),
		textColor   = Color3.fromRGB(220, 255, 220),
		toggleBg    = Color3.fromRGB(80, 200, 120),
		sliderBg    = Color3.fromRGB(150, 200, 150),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(50, 200, 100)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(150, 255, 150))
		}
	},

	ice = {
		windowBg    = Color3.fromRGB(200, 230, 255),
		containerBg = Color3.fromRGB(220, 245, 255),
		buttonBg    = Color3.fromRGB(190, 220, 250),
		textBoxBg   = Color3.fromRGB(210, 240, 255),
		textColor   = Color3.fromRGB(20, 40, 80),
		toggleBg    = Color3.fromRGB(100, 200, 255),
		sliderBg    = Color3.fromRGB(160, 200, 230),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 200, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 240, 255))
		}
	},

	cyber = {
		windowBg    = Color3.fromRGB(10, 10, 20),
		containerBg = Color3.fromRGB(20, 20, 40),
		buttonBg    = Color3.fromRGB(30, 30, 60),
		textBoxBg   = Color3.fromRGB(25, 25, 50),
		textColor   = Color3.fromRGB(0, 255, 180),
		toggleBg    = Color3.fromRGB(255, 0, 150),
		sliderBg    = Color3.fromRGB(50, 80, 100),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 255, 180)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 200))
		}
	},

	pastel = {
		windowBg    = Color3.fromRGB(250, 230, 240),
		containerBg = Color3.fromRGB(255, 240, 245),
		buttonBg    = Color3.fromRGB(255, 220, 230),
		textBoxBg   = Color3.fromRGB(245, 230, 240),
		textColor   = Color3.fromRGB(80, 60, 90),
		toggleBg    = Color3.fromRGB(255, 170, 200),
		sliderBg    = Color3.fromRGB(220, 200, 210),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 180, 220)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 200, 255))
		}
	},

	galaxy = {
		windowBg    = Color3.fromRGB(20, 10, 40),
		containerBg = Color3.fromRGB(30, 15, 60),
		buttonBg    = Color3.fromRGB(40, 20, 80),
		textBoxBg   = Color3.fromRGB(35, 15, 70),
		textColor   = Color3.fromRGB(220, 200, 255),
		toggleBg    = Color3.fromRGB(140, 60, 255),
		sliderBg    = Color3.fromRGB(70, 40, 120),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 50, 200)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 80, 200))
		}
	},

	cloud = {
		windowBg    = Color3.fromRGB(230, 240, 255),
		containerBg = Color3.fromRGB(245, 250, 255),
		buttonBg    = Color3.fromRGB(220, 230, 250),
		textBoxBg   = Color3.fromRGB(235, 240, 255),
		textColor   = Color3.fromRGB(60, 70, 120),
		toggleBg    = Color3.fromRGB(150, 180, 255),
		sliderBg    = Color3.fromRGB(200, 210, 240),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(100, 150, 255)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 200, 255))
		}
	},

	inferno = {
		windowBg    = Color3.fromRGB(40, 10, 10),
		containerBg = Color3.fromRGB(60, 20, 20),
		buttonBg    = Color3.fromRGB(90, 30, 30),
		textBoxBg   = Color3.fromRGB(70, 20, 20),
		textColor   = Color3.fromRGB(255, 220, 200),
		toggleBg    = Color3.fromRGB(255, 90, 60),
		sliderBg    = Color3.fromRGB(150, 80, 60),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 80, 0)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 200, 50))
		}
	},

	tokyo = {
		windowBg    = Color3.fromRGB(15, 10, 20),
		containerBg = Color3.fromRGB(25, 15, 35),
		buttonBg    = Color3.fromRGB(40, 20, 50),
		textBoxBg   = Color3.fromRGB(30, 15, 40),
		textColor   = Color3.fromRGB(255, 100, 200),
		toggleBg    = Color3.fromRGB(0, 255, 255),
		sliderBg    = Color3.fromRGB(100, 60, 120),
		sliderFill  = {
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 150)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 200, 255))
		}
	}
}
local function safeDestroy(obj)
	if obj and obj.Parent then
		pcall(function() obj:Destroy() end)
	end
end

-- remove old UI if exists
local FindLibrary = game:GetService("CoreGui"):FindFirstChild("UI Library")
if FindLibrary then safeDestroy(FindLibrary) end

-- main screen gui
local UILibrary = Instance.new("ScreenGui")
UILibrary.Name = "UI Library"
UILibrary.Parent = game:GetService("CoreGui")
UILibrary.ResetOnSpawn = false

-- right-shift to show/hide everything
game:GetService("UserInputService").InputBegan:Connect(function(Input, gameProcessed)
	if not gameProcessed and Input.KeyCode == Enum.KeyCode.RightShift then
		UILibrary.Enabled = not UILibrary.Enabled
	end
end)

function library:SetTheme(themeName)
	if themes[themeName] then
		library.currentTheme = themeName
		-- Update all existing windows
		for _, window in pairs(UILibrary:GetChildren()) do
			if window:IsA("ImageLabel") and window.Name ~= "Circle" then
				library:UpdateWindowTheme(window)
			end
		end
	end
end

function library:UpdateWindowTheme(windowHolder)
	local theme = themes[library.currentTheme]
	
	-- Update window background
	windowHolder.ImageColor3 = theme.windowBg
	
	-- Update window text
	local windowText = windowHolder:FindFirstChild(windowHolder.Name)
	if windowText and windowText:IsA("TextLabel") then
		windowText.TextColor3 = theme.textColor
	end
	
	-- Update toggle button
	local toggleBtn = windowHolder:FindFirstChild("ToggleGUI")
	if toggleBtn then
		toggleBtn.TextColor3 = theme.textColor
	end
	
	-- Update container
	local container = windowHolder:FindFirstChild("Container")
	if container then
		container.ImageColor3 = theme.containerBg
		
		-- Update all elements in container
		for _, element in pairs(container:GetChildren()) do
			if element:IsA("Frame") then
				library:UpdateElementTheme(element)
			end
		end
	end
end

function library:UpdateElementTheme(element)
	local theme = themes[library.currentTheme]
	
	-- Update buttons
	local button = element:FindFirstChild("Button")
	if button then
		local round = button:FindFirstChild("Button_Roundify_5px")
		if round then
			round.ImageColor3 = theme.buttonBg
		end
		button.TextColor3 = theme.textColor
	end
	
	-- Update text boxes
	local box = element:FindFirstChild("Box")
	if box then
		local round = box:FindFirstChild("Box_Roundify_4px")
		if round then
			round.ImageColor3 = theme.textBoxBg
		end
		box.TextColor3 = theme.textColor
		box.PlaceholderColor3 = theme.textColor
	end
	
	local boxText = element:FindFirstChild("BoxText")
	if boxText then
		boxText.TextColor3 = theme.textColor
	end
	
	-- Update toggles
	local toggleText = element:FindFirstChild("ToggleText")
	if toggleText then
		toggleText.TextColor3 = theme.textColor
	end
	
	local mainToggle = element:FindFirstChild("MainToggle")
	if mainToggle then
		mainToggle.ImageColor3 = theme.toggleBg
	end
	
	-- Update sliders
	local sliderTitle = element:FindFirstChild("SliderTitle")
	if sliderTitle then
		sliderTitle.TextColor3 = theme.textColor
	end
	
	local valueText = element:FindFirstChild("ValueText")
	if valueText then
		valueText.TextColor3 = theme.textColor
	end
	
	local sliderFrame = element:FindFirstChild("SliderFrame")
	if sliderFrame then
		sliderFrame.BackgroundColor3 = theme.sliderBg
		local slider = sliderFrame:FindFirstChild("Slider")
		if slider then
			slider.BackgroundColor3 = theme.sliderBg
			local gradient = slider:FindFirstChild("UIGradient")
			if gradient then
				gradient.Color = ColorSequence.new(theme.sliderFill)
			end
		end
	end
end

function library:CreateWindow(WName)
	library.count = library.count + 1
	local ui = {}
	local theme = themes[library.currentTheme]

	-- parts
	local Holder = Instance.new("ImageLabel")
	local WindowText = Instance.new("TextLabel")
	local Container = Instance.new("ImageLabel")
	local ToggleGUI = Instance.new("TextButton")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	Holder.Name = WName
	Holder.Parent = UILibrary
	Holder.BackgroundTransparency = 1
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0, (15 + (202 * library.count) - 200), 0.002, 0)
	Holder.Size = UDim2.new(0, 200, 0, 39)
	Holder.ZIndex = 5
	Holder.Image = "rbxassetid://3570695787"
	Holder.ImageColor3 = theme.windowBg
	Holder.ScaleType = Enum.ScaleType.Slice
	Holder.SliceCenter = Rect.new(100, 100, 100, 100)
	Holder.SliceScale = 0.040

	ToggleGUI.Name = "ToggleGUI"
	ToggleGUI.Parent = Holder
	ToggleGUI.BackgroundTransparency = 1
	ToggleGUI.BorderSizePixel = 0
	ToggleGUI.Position = UDim2.new(0.852, 0, 0, 0)
	ToggleGUI.Size = UDim2.new(0, 31, 0, 38)
	ToggleGUI.ZIndex = 6
	ToggleGUI.Font = Enum.Font.GothamBold
	ToggleGUI.Text = "▼"
	ToggleGUI.TextColor3 = theme.textColor
	ToggleGUI.TextSize = 17

	Container.Name = "Container"
	Container.Parent = Holder
	Container.BackgroundTransparency = 1
	Container.ClipsDescendants = true
	Container.Size = UDim2.new(0, 200, 0, 37)
	Container.ZIndex = 2
	Container.Image = "rbxassetid://3570695787"
	Container.ImageColor3 = theme.containerBg
	Container.ScaleType = Enum.ScaleType.Slice
	Container.SliceCenter = Rect.new(100, 100, 100, 100)
	Container.SliceScale = 0.040

	WindowText.Name = WName
	WindowText.Parent = Holder
	WindowText.BackgroundTransparency = 1
	WindowText.BorderSizePixel = 0
	WindowText.Position = UDim2.new(0.04, 0, 0.154, 0)
	WindowText.Size = UDim2.new(0, 186, 0, 27)
	WindowText.ZIndex = 5
	WindowText.Font = Enum.Font.SourceSans
	WindowText.Text = WName
	WindowText.TextColor3 = theme.textColor
	WindowText.TextSize = 22
	WindowText.TextXAlignment = Enum.TextXAlignment.Left

	UIListLayout.Parent = Container
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 1)

	UIPadding.Parent = Container
	UIPadding.PaddingTop = UDim.new(0, 40)

	-- draggable
	local players = game:GetService("Players")
	local player = players.LocalPlayer
	local mouse = player:GetMouse()
	local run = game:GetService("RunService")

	local function draggable(obj)
		pcall(function()
			obj.Active = true
			local isDragging, dragStart, startPos = false, nil, nil

			obj.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true
					dragStart = Vector2.new(mouse.X, mouse.Y)
					startPos = obj.Position
				end
			end)

			obj.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end)

			run.Heartbeat:Connect(function()
				if isDragging then
					local mousePos = Vector2.new(mouse.X, mouse.Y)
					local delta = mousePos - dragStart
					obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)
		end)
	end
	draggable(Holder)

	-- expand/collapse
	local TweenService = game:GetService("TweenService")
	local function Rotation(Object, RotateAMT, Delay)
		pcall(function()
			local tweenInfo = TweenInfo.new(Delay, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
			TweenService:Create(Object, tweenInfo, {Rotation = RotateAMT}):Play()
		end)
	end

	local opened = false
	ToggleGUI.MouseButton1Click:Connect(function()
		pcall(function()
			opened = not opened
			Rotation(ToggleGUI, opened and 90 or 0, .2)
			task.wait(0.1)

			local y = 40
			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					y = y + (v.AbsoluteSize.Y + 2)
				end
			end

			local targetSize = opened and UDim2.new(0, 200, 0, y) or UDim2.new(0, 200, 0, 37)
			Container:TweenSize(targetSize, opened and Enum.EasingDirection.Out or Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.15, true)
		end)
	end)

	print("Welcome")

	-- helpers
	function ui:Resize()
		pcall(function()
			local y = 37
			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					y = y + (v.AbsoluteSize.Y + 2)
				end
			end
			Container.Size = UDim2.new(0, 200, 0, y + 2)
		end)
	end

	-- Theme switcher method for individual windows
	function ui:SetTheme(themeName)
		if themes[themeName] then
			library.currentTheme = themeName
			library:UpdateWindowTheme(Holder)
		end
	end

	-- ============ ELEMENTS ============

	-- Button
	function ui:Button(Name, callback)
		pcall(function()
			local theme = themes[library.currentTheme]
			local ButtonHolder = Instance.new("Frame")
			local Button = Instance.new("TextButton")
			local Round = Instance.new("ImageLabel")

			ButtonHolder.Name = "ButtonHolder"
			ButtonHolder.Parent = Container
			ButtonHolder.BackgroundTransparency = 1
			ButtonHolder.Size = UDim2.new(0, 200, 0, 37)
			ButtonHolder.ZIndex = 2

			Button.Name = "Button"
			Button.Parent = ButtonHolder
			Button.BackgroundTransparency = 1
			Button.Position = UDim2.new(0.03, 0, 0.081, 0)
			Button.Size = UDim2.new(0, 190, 0, 30)
			Button.ZIndex = 4
			Button.Font = Enum.Font.SourceSans
			Button.Text = Name or "Button"
			Button.TextColor3 = theme.textColor
			Button.TextSize = 22
			Button.TextWrapped = true
			Button.ClipsDescendants = true

			Round.Name = "Button_Roundify_5px"
			Round.Parent = Button
			Round.Active = true
			Round.AnchorPoint = Vector2.new(0.5, 0.5)
			Round.BackgroundTransparency = 1
			Round.Position = UDim2.new(0.5, 0, 0.5, 0)
			Round.Selectable = true
			Round.Size = UDim2.new(1, 0, 1, 0)
			Round.ZIndex = 3
			Round.Image = "rbxassetid://3570695787"
			Round.ImageColor3 = theme.buttonBg
			Round.ScaleType = Enum.ScaleType.Slice
			Round.SliceCenter = Rect.new(100, 100, 100, 100)
			Round.SliceScale = 0.050

			-- one reusable circle stored in CoreGui
			local CircleSeed = game.CoreGui:FindFirstChild("Circle")
			if not CircleSeed then
				CircleSeed = Instance.new("ImageLabel")
				CircleSeed.Name = "Circle"
				CircleSeed.Parent = game.CoreGui
				CircleSeed.BackgroundTransparency = 1
				CircleSeed.ZIndex = 10
				CircleSeed.Image = "http://www.roblox.com/asset/?id=266543268"
				CircleSeed.ImageColor3 = Color3.fromRGB(126, 126, 126)
				CircleSeed.ImageTransparency = 0.7
			end

			local function CircleClick(ButtonObj, X, Y)
				pcall(function()
					local c = CircleSeed:Clone()
					c.Parent = ButtonObj
					local NewX = X - ButtonObj.AbsolutePosition.X
					local NewY = Y - ButtonObj.AbsolutePosition.Y
					c.Position = UDim2.new(0, NewX, 0, NewY)

					local Size
					if ButtonObj.AbsoluteSize.X >= ButtonObj.AbsoluteSize.Y then
						Size = ButtonObj.AbsoluteSize.X * 1.5
					else
						Size = ButtonObj.AbsoluteSize.Y * 1.5
					end

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
				if callback then pcall(callback) end
				task.spawn(function() CircleClick(Button, Mouse.X, Mouse.Y) end)
			end)

			ui:Resize()
		end)
	end

	-- Slider
	function ui:Slider(name, min, max, precise, callback)
		pcall(function()
			local theme = themes[library.currentTheme]
			local PreciseValue = precise
			local SliderHolder = Instance.new("Frame")
			local SliderTitle = Instance.new("TextLabel")
			local SliderFrame = Instance.new("TextButton")
			local Slider = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local ValueText = Instance.new("TextLabel")

			SliderHolder.Name = "SliderHolder"
			SliderHolder.Parent = Container
			SliderHolder.BackgroundTransparency = 1
			SliderHolder.Size = UDim2.new(0, 200, 0, 37)
			SliderHolder.ZIndex = 2

			SliderTitle.Name = "SliderTitle"
			SliderTitle.Parent = SliderHolder
			SliderTitle.BackgroundTransparency = 1
			SliderTitle.Position = UDim2.new(0.045, 0, 0.081, 0)
			SliderTitle.Size = UDim2.new(0, 185, 0, 16)
			SliderTitle.ZIndex = 3
			SliderTitle.Font = Enum.Font.SourceSansSemibold
			SliderTitle.LineHeight = 1.2
			SliderTitle.Text = name or "Slider"
			SliderTitle.TextColor3 = theme.textColor
			SliderTitle.TextSize = 15
			SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = SliderHolder
			SliderFrame.BackgroundColor3 = theme.sliderBg
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0.045, 0, 0.5405, 0)
			SliderFrame.Size = UDim2.new(0, 185, 0, 6)
			SliderFrame.ZIndex = 3
			SliderFrame.Text = ""

			Slider.Name = "Slider"
			Slider.Parent = SliderFrame
			Slider.BackgroundColor3 = theme.sliderBg
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(0, 0, 0, 6)
			Slider.ZIndex = 4

			UIGradient.Color = ColorSequence.new(theme.sliderFill)
			UIGradient.Parent = Slider

			ValueText.Name = "ValueText"
			ValueText.Parent = SliderHolder
			ValueText.BackgroundTransparency = 1
			ValueText.Position = UDim2.new(0.045, 0, 0.081, 0)
			ValueText.Size = UDim2.new(0, 185, 0, 16)
			ValueText.ZIndex = 3
			ValueText.Font = Enum.Font.SourceSansSemibold
			ValueText.LineHeight = 1.2
			ValueText.Text = ""
			ValueText.TextColor3 = theme.textColor
			ValueText.TextSize = 15
			ValueText.TextXAlignment = Enum.TextXAlignment.Right

			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")
			local Connection
			local isDragging = false

			local TweenService = game:GetService("TweenService")
			local function Fade(Object, FadeAmount, Delay)
				pcall(function()
					TweenService:Create(Object, TweenInfo.new(Delay), {TextTransparency = FadeAmount}):Play()
				end)
			end

			UserInputService.InputEnded:Connect(function(Input)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and isDragging then
					if Connection then Connection:Disconnect() Connection = nil end
					isDragging = false
					Fade(ValueText, 1, .2)
				end
			end)

			local Vals = {Min = min or 0, Max = max or 100}
			ValueText.Text = Vals.Min .. "/" .. Vals.Max

			SliderFrame.MouseButton1Down:Connect(function()
				pcall(function()
					if Connection then Connection:Disconnect() end
					isDragging = true
					Connection = RunService.RenderStepped:Connect(function()
						if not isDragging then if Connection then Connection:Disconnect() Connection = nil end return end
						local Mouse = UserInputService:GetMouseLocation()
						local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)
						local GetValue = Vals.Min + (Vals.Max - Vals.Min) * Percentage
						GetValue = math.floor(GetValue)
						if PreciseValue then GetValue = string.format("%.2f", GetValue) end
						Slider:TweenSize(UDim2.new(Percentage, 0, 0, 6), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .03, true)
						ValueText.Text = GetValue .. "/" .. Vals.Max
						Fade(ValueText, 0, .2)
						if callback then pcall(callback, tonumber(GetValue)) end
					end)
				end)
			end)

			ui:Resize()
		end)
	end

	-- Text Box
	function ui:Box(Name, callback)
		pcall(function()
			local theme = themes[library.currentTheme]
			local BoxHolder = Instance.new("Frame")
			local BoxText = Instance.new("TextLabel")
			local Box = Instance.new("TextBox")
			local Round = Instance.new("ImageLabel")

			BoxHolder.Name = "BoxHolder"
			BoxHolder.Parent = Container
			BoxHolder.BackgroundTransparency = 1
			BoxHolder.Size = UDim2.new(0, 200, 0, 37)
			BoxHolder.ZIndex = 2

			BoxText.Name = "BoxText"
			BoxText.Parent = BoxHolder
			BoxText.BackgroundTransparency = 1
			BoxText.Position = UDim2.new(0.04, 0, 0.162, 0)
			BoxText.Size = UDim2.new(0, 94, 0, 23)
			BoxText.ZIndex = 3
			BoxText.Font = Enum.Font.SourceSansSemibold
			BoxText.LineHeight = 1.1
			BoxText.Text = Name or "TextBox"
			BoxText.TextColor3 = theme.textColor
			BoxText.TextSize = 15
			BoxText.TextXAlignment = Enum.TextXAlignment.Left

			Box.Name = "Box"
			Box.Parent = BoxHolder
			Box.BackgroundTransparency = 1
			Box.Position = UDim2.new(0.54, 0, 0.243, 0)
			Box.Size = UDim2.new(0, 85, 0, 23)
			Box.ZIndex = 4
			Box.Font = Enum.Font.SourceSansSemibold
			Box.LineHeight = 1.5
			Box.PlaceholderColor3 = theme.textColor
			Box.Text = ""
			Box.TextColor3 = theme.textColor
			Box.TextSize = 14

			Round.Name = "Box_Roundify_4px"
			Round.Parent = Box
			Round.Active = true
			Round.AnchorPoint = Vector2.new(0.5, 0.5)
			Round.BackgroundTransparency = 1
			Round.Position = UDim2.new(0.5, 0, 0.386, 0)
			Round.Selectable = true
			Round.Size = UDim2.new(1, 0, 1.045, 0)
			Round.ZIndex = 3
			Round.Image = "rbxassetid://3570695787"
			Round.ImageColor3 = theme.textBoxBg
			Round.ScaleType = Enum.ScaleType.Slice
			Round.SliceCenter = Rect.new(100, 100, 100, 100)
			Round.SliceScale = 0.040

			Box.FocusLost:Connect(function(enter)
				if enter and Box.Text ~= "" and Box.Text ~= " " then
					if callback then pcall(callback, Box.Text) end
				end
			end)

			pcall(function()
				Box.Changed:Connect(function()
					Box.TextScaled = (#Box.Text >= 15)
				end)
			end)

			ui:Resize()
		end)
	end

	-- Toggle
	function ui:Toggle(Name, callback)
		pcall(function()
			local theme = themes[library.currentTheme]
			local Enabled = false

			local ToggleHolder = Instance.new("Frame")
			local ToggleImage = Instance.new("ImageLabel")
			local MainToggle = Instance.new("ImageButton")
			local ToggleText = Instance.new("TextLabel")

			ToggleHolder.Name = "ToggleHolder"
			ToggleHolder.Parent = Container
			ToggleHolder.BackgroundTransparency = 1
			ToggleHolder.Size = UDim2.new(0, 200, 0, 37)
			ToggleHolder.ZIndex = 2

			ToggleImage.Name = "ToggleImage"
			ToggleImage.Parent = ToggleHolder
			ToggleImage.BackgroundTransparency = 1
			ToggleImage.Position = UDim2.new(0.83, 0, 0.081, 0)
			ToggleImage.Size = UDim2.new(0, 30, 0, 30)
			ToggleImage.ZIndex = 2
			ToggleImage.Image = "http://www.roblox.com/asset/?id=4908273649"

			MainToggle.Name = "MainToggle"
			MainToggle.Parent = ToggleHolder
			MainToggle.BackgroundTransparency = 1
			MainToggle.Position = UDim2.new(0.83, 0, 0.081, 0)
			MainToggle.Size = UDim2.new(0, 30, 0, 30)
			MainToggle.ZIndex = 3
			MainToggle.Image = "http://www.roblox.com/asset/?id=4908257956"
			MainToggle.ImageColor3 = theme.toggleBg
			MainToggle.ImageTransparency = 1

			ToggleText.Name = "ToggleText"
			ToggleText.Parent = ToggleHolder
			ToggleText.BackgroundTransparency = 1
			ToggleText.Position = UDim2.new(0.045, 0, 0.081, 0)
			ToggleText.Size = UDim2.new(0, 157, 0, 29)
			ToggleText.ZIndex = 3
			ToggleText.Font = Enum.Font.SourceSansSemibold
			ToggleText.Text = Name or "Toggle"
			ToggleText.TextColor3 = theme.textColor
			ToggleText.TextSize = 14
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left

			local TweenService = game:GetService("TweenService")
			local function FadeImage(Object, FadeAmount, Delay)
				pcall(function()
					TweenService:Create(Object, TweenInfo.new(Delay), {ImageTransparency = FadeAmount}):Play()
				end)
			end

			MainToggle.MouseButton1Click:Connect(function()
				Enabled = not Enabled
				if callback then pcall(callback, Enabled) end
				FadeImage(MainToggle, Enabled and 0 or 1, .2)
			end)

			ui:Resize()
		end)
	end

-- Theme Toggle Button (special button for switching themes)
	function ui:ThemeToggle()
		pcall(function()
			local theme = themes[library.currentTheme]
			local ButtonHolder = Instance.new("Frame")
			local Button = Instance.new("TextButton")
			local Round = Instance.new("ImageLabel")

			ButtonHolder.Name = "ThemeButtonHolder"
			ButtonHolder.Parent = Container
			ButtonHolder.BackgroundTransparency = 1
			ButtonHolder.Size = UDim2.new(0, 200, 0, 37)
			ButtonHolder.ZIndex = 2

			Button.Name = "Button"
			Button.Parent = ButtonHolder
			Button.BackgroundTransparency = 1
			Button.Position = UDim2.new(0.03, 0, 0.081, 0)
			Button.Size = UDim2.new(0, 190, 0, 30)
			Button.ZIndex = 4
			Button.Font = Enum.Font.SourceSans
			Button.Text = "Theme: " .. (library.currentTheme == "dark" and "Dark" or "Light")
			Button.TextColor3 = theme.textColor
			Button.TextSize = 22
			Button.TextWrapped = true
			Button.ClipsDescendants = true

			Round.Name = "Button_Roundify_5px"
			Round.Parent = Button
			Round.Active = true
			Round.AnchorPoint = Vector2.new(0.5, 0.5)
			Round.BackgroundTransparency = 1
			Round.Position = UDim2.new(0.5, 0, 0.5, 0)
			Round.Selectable = true
			Round.Size = UDim2.new(1, 0, 1, 0)
			Round.ZIndex = 3
			Round.Image = "rbxassetid://3570695787"
			Round.ImageColor3 = theme.buttonBg
			Round.ScaleType = Enum.ScaleType.Slice
			Round.SliceCenter = Rect.new(100, 100, 100, 100)
			Round.SliceScale = 0.050

			-- one reusable circle stored in CoreGui
			local CircleSeed = game.CoreGui:FindFirstChild("Circle")
			if not CircleSeed then
				CircleSeed = Instance.new("ImageLabel")
				CircleSeed.Name = "Circle"
				CircleSeed.Parent = game.CoreGui
				CircleSeed.BackgroundTransparency = 1
				CircleSeed.ZIndex = 10
				CircleSeed.Image = "http://www.roblox.com/asset/?id=266543268"
				CircleSeed.ImageColor3 = Color3.fromRGB(126, 126, 126)
				CircleSeed.ImageTransparency = 0.7
			end

			local function CircleClick(ButtonObj, X, Y)
				pcall(function()
					local c = CircleSeed:Clone()
					c.Parent = ButtonObj
					local NewX = X - ButtonObj.AbsolutePosition.X
					local NewY = Y - ButtonObj.AbsolutePosition.Y
					c.Position = UDim2.new(0, NewX, 0, NewY)

					local Size
					if ButtonObj.AbsoluteSize.X >= ButtonObj.AbsoluteSize.Y then
						Size = ButtonObj.AbsoluteSize.X * 1.5
					else
						Size = ButtonObj.AbsoluteSize.Y * 1.5
					end

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
				-- Switch between themes
				local newTheme = library.currentTheme == "dark" and "light" or "dark"
				library:SetTheme(newTheme)
				Button.Text = "Theme: " .. (library.currentTheme == "dark" and "Dark" or "Light")
				-- Update button colors
				local newThemeColors = themes[library.currentTheme]
				Button.TextColor3 = newThemeColors.textColor
				Round.ImageColor3 = newThemeColors.buttonBg
				
				task.spawn(function() CircleClick(Button, Mouse.X, Mouse.Y) end)
			end)

			ui:Resize()
		end)
	end

-- ========== /ELEMENTS ==========

	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Zen Library V1.1 (Version 1.1.0.0)",
			Text = "Made by VantaXock",
			Duration = 3
		})
	end)

	return ui
end

return library
