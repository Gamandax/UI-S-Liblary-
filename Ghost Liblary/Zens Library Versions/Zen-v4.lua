-- // Zen Library - Mobile Version \\ --
-- //    By VantaXock & Rodgie       \\ --

local library = {flags = {}, windows = {}, open = true, count = 0}

--Services
local runService = game:GetService"RunService"
local textService = game:GetService"TextService"
local inputService = game:GetService"UserInputService"
local ui = Enum.UserInputType.MouseButton1

--Functions
local function safeDestroy(obj)
	if obj and obj.Parent then
		pcall(function() obj:Destroy() end)
	end
end

function library:Create(class, properties)
	properties = typeof(properties) == "table" and properties or {}
	local inst = Instance.new(class)
	for property, value in next, properties do
		inst[property] = value
	end
	return inst
end

local function createButton(option, parent)
	local ButtonHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "ButtonHolder",
		Size = UDim2.new(1, 0, 0, 25),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local Button = library:Create("TextButton", {
		Name = "Button",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.1, 0),
		Size = UDim2.new(0, 90, 0, 20),
		ZIndex = 4,
		Font = Enum.Font.SourceSansBold,  
		Text = option.text or "Button",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12,
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
		ImageColor3 = Color3.fromRGB(180, 30, 30),  
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.050,
		Parent = Button
	})

	local UIGradient = library:Create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(200, 40, 40)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 20, 20))
		},
		Rotation = 90,
		Parent = Round
	})

	Button.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(220, 50, 50)
		}):Play()
		game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 92, 0, 21)
		}):Play()
	end)

	Button.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(180, 30, 30)
		}):Play()
		game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 90, 0, 20)
		}):Play()
	end)


	Button.MouseButton1Down:Connect(function()

		game:GetService("TweenService"):Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 85, 0, 18)
		}):Play()
		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(140, 20, 20)
		}):Play()
	end)

	Button.MouseButton1Click:Connect(function()

		local tween1 = game:GetService("TweenService"):Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 90, 0, 20)
		})
		tween1:Play()

		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(255, 80, 80)
		}):Play()
		wait(0.1)
		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(180, 30, 30)
		}):Play()

		local Ripple = library:Create("ImageLabel", {
			BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 0, 0, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			ZIndex = 5,
			Image = "rbxassetid://3570695787",
			ImageColor3 = Color3.fromRGB(255, 100, 100),
			ImageTransparency = 0.5,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(100, 100, 100, 100),
			SliceScale = 0.050,
			Parent = Button
		})

		local rippleTween = game:GetService("TweenService"):Create(Ripple, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(1.5, 0, 1.5, 0),
			ImageTransparency = 1
		})
		rippleTween:Play()
		rippleTween.Completed:Connect(function()
			Ripple:Destroy()
		end)

		library.flags[option.flag] = true
		if option.callback then pcall(option.callback) end
	end)

	parent:Resize()
end

local function createKeybind(option, parent)
	local KeybindHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "KeybindHolder",
		Size = UDim2.new(1, 0, 0, 25),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local KeybindText = library:Create("TextLabel", {
		Name = "KeybindText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.2, 0),
		Size = UDim2.new(0, 45, 0, 15),
		ZIndex = 3,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.1,
		Text = option.text or "Keybind",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = KeybindHolder
	})

	local KeybindBox = library:Create("TextButton", {
		Name = "KeybindBox",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.52, 0, 0.2, 0),
		Size = UDim2.new(0, 42, 0, 15),
		ZIndex = 4,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.5,
		Text = option.key and option.key.Name or "None",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 9,
		Parent = KeybindHolder
	})

	local Round = library:Create("ImageLabel", {
		Name = "Keybind_Roundify_4px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(43, 43, 43),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = KeybindBox
	})

	local listening = false
	local currentKey = option.key or Enum.KeyCode.F

	library.flags[option.flag] = currentKey

	
	KeybindBox.MouseEnter:Connect(function()
		if not listening then
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(60, 60, 60)
			}):Play()
		end
	end)

	KeybindBox.MouseLeave:Connect(function()
		if not listening then
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(43, 43, 43)
			}):Play()
		end
	end)

	KeybindBox.MouseButton1Click:Connect(function()
		if listening then return end
		listening = true

		
		KeybindBox.Text = "..."

		game:GetService("TweenService"):Create(KeybindBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			TextColor3 = Color3.fromRGB(255, 255, 0)
		}):Play()

		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(100, 100, 50)
		}):Play()

		
		local pulseLoop
		pulseLoop = game:GetService("RunService").Heartbeat:Connect(function()
			if not listening then
				pulseLoop:Disconnect()
				return
			end
		end)

		local pulseTween = game:GetService("TweenService"):Create(Round, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
			ImageColor3 = Color3.fromRGB(120, 120, 60)
		})
		pulseTween:Play()

		local connection
		connection = inputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end

			if input.UserInputType == Enum.UserInputType.Keyboard then
				connection:Disconnect()
				listening = false
				pulseTween:Cancel()
				currentKey = input.KeyCode
				library.flags[option.flag] = currentKey

				
				KeybindBox.Text = input.KeyCode.Name

				game:GetService("TweenService"):Create(Round, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
					ImageColor3 = Color3.fromRGB(80, 255, 100)
				}):Play()

				game:GetService("TweenService"):Create(KeybindBox, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
					Size = UDim2.new(0, 44, 0, 16)
				}):Play()

				task.wait(0.2)

				game:GetService("TweenService"):Create(KeybindBox, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
					Size = UDim2.new(0, 42, 0, 15),
					TextColor3 = Color3.fromRGB(255, 255, 255)
				}):Play()

				game:GetService("TweenService"):Create(Round, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
					ImageColor3 = Color3.fromRGB(43, 43, 43)
				}):Play()

				if option.callback then
					pcall(option.callback, input.KeyCode)
				end
			end
		end)
	end)

	inputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
			if option.mode == "toggle" then
				library.flags[option.flag .. "_active"] = not library.flags[option.flag .. "_active"]
			else
				library.flags[option.flag .. "_active"] = true
			end

			if option.callback then
				pcall(option.callback, library.flags[option.flag .. "_active"])
			end
		end
	end)

	if option.mode ~= "toggle" then
		inputService.InputEnded:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
				library.flags[option.flag .. "_active"] = false
				if option.callback then
					pcall(option.callback, false)
				end
			end
		end)
	end

	parent:Resize()
end

local function createToggle(option, parent)
	local ToggleHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "ToggleHolder",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 100, 0, 25),
		ZIndex = 2,
		Parent = parent.Container
	})

	local ToggleImage = library:Create("ImageLabel", {
		Name = "ToggleImage",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.75, 0, 0.2, 0),
		Size = UDim2.new(0, 18, 0, 18),
		ZIndex = 2,
		Image = "http://www.roblox.com/asset/?id=4908273649",
		ImageColor3 = Color3.fromRGB(100, 100, 100),  -- Dark gray when off
		Parent = ToggleHolder
	})

	local MainToggle = library:Create("ImageButton", {
		Name = "MainToggle",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.75, 0, 0.2, 0),
		Size = UDim2.new(0, 18, 0, 18),
		ZIndex = 3,
		Image = "http://www.roblox.com/asset/?id=4908257956",
		ImageColor3 = Color3.fromRGB(90, 255, 115),
		ImageTransparency = 1,
		Parent = ToggleHolder
	})

	local ToggleText = library:Create("TextLabel", {
		Name = "ToggleText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.2, 0),
		Size = UDim2.new(0, 65, 0, 18),
		ZIndex = 3,
		Font = Enum.Font.SourceSansSemibold,
		Text = option.text or "Toggle",
		TextColor3 = Color3.fromRGB(200, 200, 200),  -- Gray when off
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = ToggleHolder
	})

	local enabled = false

	MainToggle.MouseEnter:Connect(function()
		if not enabled then
			game:GetService("TweenService"):Create(ToggleImage, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(130, 130, 130)
			}):Play()
		end
	end)

	MainToggle.MouseLeave:Connect(function()
		if not enabled then
			game:GetService("TweenService"):Create(ToggleImage, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(100, 100, 100)
			}):Play()
		end
	end)

	MainToggle.MouseButton1Click:Connect(function()
		enabled = not enabled
		library.flags[option.flag] = enabled

		if enabled then

			game:GetService("TweenService"):Create(MainToggle, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 15, 0, 15)
			}):Play()

			task.wait(0.1)

			game:GetService("TweenService"):Create(MainToggle, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 18, 0, 18),
				ImageTransparency = 0
			}):Play()


			game:GetService("TweenService"):Create(ToggleImage, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(50, 200, 80)
			}):Play()


			game:GetService("TweenService"):Create(ToggleText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
		else

			game:GetService("TweenService"):Create(MainToggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				ImageTransparency = 1
			}):Play()

			game:GetService("TweenService"):Create(ToggleImage, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(100, 100, 100)
			}):Play()

			game:GetService("TweenService"):Create(ToggleText, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()
		end

		if option.callback then
			pcall(option.callback, enabled)
		end
	end)

	parent:Resize()
end

local function createBox(option, parent)
	local BoxHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "BoxHolder",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 100, 0, 25),
		ZIndex = 2,
		Parent = parent.Container
	})

	local BoxText = library:Create("TextLabel", {
		Name = "BoxText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.2, 0),
		Size = UDim2.new(0, 45, 0, 15),
		ZIndex = 3,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.1,
		Text = option.text or "TextBox",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = BoxHolder
	})

	local Box = library:Create("TextBox", {
		Name = "Box",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.52, 0, 0.2, 0),
		Size = UDim2.new(0, 42, 0, 15),
		ZIndex = 4,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.5,
		PlaceholderColor3 = Color3.fromRGB(150, 150, 150),
		PlaceholderText = "Enter...",
		Text = "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 9,
		Parent = BoxHolder
	})

	local Round = library:Create("ImageLabel", {
		Name = "Box_Roundify_4px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(43, 43, 43),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = Box
	})


	Box.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(60, 60, 60)
		}):Play()
	end)

	Box.MouseLeave:Connect(function()
		if not Box:IsFocused() then
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(43, 43, 43)
			}):Play()
		end
	end)

	Box.Focused:Connect(function()

		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(80, 120, 255)
		}):Play()


		game:GetService("TweenService"):Create(Box, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 44, 0, 16)
		}):Play()


		game:GetService("TweenService"):Create(BoxText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			TextColor3 = Color3.fromRGB(150, 180, 255)
		}):Play()
	end)

	Box.FocusLost:Connect(function(enter)

		game:GetService("TweenService"):Create(Round, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			ImageColor3 = Color3.fromRGB(43, 43, 43)
		}):Play()

		game:GetService("TweenService"):Create(Box, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Size = UDim2.new(0, 42, 0, 15)
		}):Play()

		game:GetService("TweenService"):Create(BoxText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}):Play()

		if enter and Box.Text ~= "" and Box.Text ~= " " then
			library.flags[option.flag] = Box.Text

			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(80, 255, 100)
			}):Play()
			task.wait(0.15)
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(43, 43, 43)
			}):Play()

			if option.callback then
				pcall(option.callback, Box.Text)
			end
		end
	end)

	Box.Changed:Connect(function()
		Box.TextScaled = (#Box.Text >= 7)
	end)

	parent:Resize()
end

local function createSlider(option, parent)
	local SliderHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "SliderHolder",
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 100, 0, 25),
		ZIndex = 2,
		Parent = parent.Container
	})

	local SliderTitle = library:Create("TextLabel", {
		Name = "SliderTitle",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.1, 0),
		Size = UDim2.new(0, 90, 0, 12),
		ZIndex = 3,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.2,
		Text = option.text or "Slider",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = SliderHolder
	})

	local SliderFrame = library:Create("TextButton", {
		Name = "SliderFrame",
		BackgroundColor3 = Color3.fromRGB(60, 60, 60),
		BorderSizePixel = 0,
		Position = UDim2.new(0.05, 0, 0.6, 0),
		Size = UDim2.new(0, 90, 0, 4),
		ZIndex = 3,
		Text = "",
		Parent = SliderHolder
	})

	local SliderFrameRound = library:Create("UICorner", {
		CornerRadius = UDim.new(0, 2),
		Parent = SliderFrame
	})

	local Slider = library:Create("Frame", {
		Name = "Slider",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 0, 1, 0),
		ZIndex = 4,
		Parent = SliderFrame
	})

	local SliderRound = library:Create("UICorner", {
		CornerRadius = UDim.new(0, 2),
		Parent = Slider
	})

	local UIGradient = library:Create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 80, 80)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 150, 150))
		},
		Parent = Slider
	})

	-- DOT INDICATOR
	local SliderDot = library:Create("Frame", {
		Name = "SliderDot",
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, 0, 0.5, 0),
		Size = UDim2.new(0, 10, 0, 10),
		ZIndex = 5,
		Parent = SliderFrame
	})

	local DotRound = library:Create("UICorner", {
		CornerRadius = UDim.new(1, 0),
		Parent = SliderDot
	})

	local DotGradient = library:Create("UIGradient", {
		Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 100, 100)),
			ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 180, 180))
		},
		Rotation = 45,
		Parent = SliderDot
	})

	local ValueText = library:Create("TextLabel", {
		Name = "ValueText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.1, 0),
		Size = UDim2.new(0, 90, 0, 12),
		ZIndex = 3,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.2,
		Text = "",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 10,
		TextXAlignment = Enum.TextXAlignment.Right,
		Parent = SliderHolder
	})

	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local Connection
	local isDragging = false

	UserInputService.InputEnded:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and isDragging then
			if Connection then Connection:Disconnect() Connection = nil end
			isDragging = false
			ValueText.TextTransparency = 1

			-- Shrink dot
			game:GetService("TweenService"):Create(SliderDot, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 10, 0, 10)
			}):Play()
		end
	end)

	local Vals = {Min = option.min or 0, Max = option.max or 100}
	ValueText.Text = Vals.Min .. "/" .. Vals.Max

	SliderFrame.MouseButton1Down:Connect(function()
		pcall(function()
			if Connection then Connection:Disconnect() end
			isDragging = true

			-- Grow dot
			game:GetService("TweenService"):Create(SliderDot, TweenInfo.new(0.15, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 14, 0, 14)
			}):Play()

			Connection = RunService.RenderStepped:Connect(function()
				if not isDragging then if Connection then Connection:Disconnect() Connection = nil end return end
				local Mouse = UserInputService:GetMouseLocation()
				local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)
				local GetValue = Vals.Min + (Vals.Max - Vals.Min) * Percentage
				GetValue = math.floor(GetValue)
				if option.precise then GetValue = string.format("%.2f", GetValue) end

				Slider.Size = UDim2.new(Percentage, 0, 1, 0)
				SliderDot.Position = UDim2.new(Percentage, 0, 0.5, 0)

				ValueText.Text = GetValue .. "/" .. Vals.Max
				ValueText.TextTransparency = 0
				library.flags[option.flag] = tonumber(GetValue)
				if option.callback then pcall(option.callback, tonumber(GetValue)) end
			end)
		end)
	end)

	parent:Resize()
end

local function createDropdown(option, parent)
	local DropdownHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "DropdownHolder",
		Size = UDim2.new(1, 0, 0, 25),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local DropdownFrame = library:Create("TextButton", {
		Name = "DropdownFrame",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.05, 0, 0.1, 0),
		Size = UDim2.new(0, 90, 0, 20),
		ZIndex = 4,
		Text = "",
		Parent = DropdownHolder
	})

	local Round = library:Create("ImageLabel", {
		Name = "Dropdown_Roundify_5px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(45, 45, 45),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.050,
		Parent = DropdownFrame
	})

	local DropdownText = library:Create("TextLabel", {
		Name = "DropdownText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 5, 0, 0),
		Size = UDim2.new(1, -20, 1, 0),
		ZIndex = 5,
		Font = Enum.Font.SourceSans,
		Text = option.value or "Select...",
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = DropdownFrame
	})

	local DropdownArrow = library:Create("TextLabel", {
		Name = "DropdownArrow",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -15, 0, 0),
		Size = UDim2.new(0, 12, 1, 0),
		ZIndex = 5,
		Font = Enum.Font.GothamBold,
		Text = "▼",
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 9,
		Parent = DropdownFrame
	})

	option.ListFrame = library:Create("ImageLabel", {
		Name = "DropdownList",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 1, 2),
		Size = UDim2.new(1, 0, 0, 0),
		ZIndex = 100,
		Visible = false,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(35, 35, 35),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = DropdownFrame
	})

	local ListContainer = library:Create("ScrollingFrame", {
		Name = "ListContainer",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(1, -4, 1, -4),
		ZIndex = 101,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = Color3.fromRGB(120, 120, 120),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		BorderSizePixel = 0,
		Parent = option.ListFrame
	})

	local ListLayout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
		Parent = ListContainer
	})

	option.open = false
	option.items = {}

	ListLayout.Changed:Connect(function()
		ListContainer.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
		local maxHeight = math.min(ListLayout.AbsoluteContentSize.Y, 150)
		if option.open then
			option.ListFrame.Size = UDim2.new(1, 0, 0, maxHeight + 4)
		end
	end)

	local function createDropdownItem(value, index)
		local ItemFrame = library:Create("TextButton", {
			Name = "DropdownItem_" .. tostring(index),
			LayoutOrder = index,
			Size = UDim2.new(1, 0, 0, 20),
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			BorderSizePixel = 0,
			ZIndex = 102,
			Text = "",
			Parent = ListContainer
		})

		local ItemText = library:Create("TextLabel", {
			Name = "ItemText",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 4, 0, 0),
			Size = UDim2.new(1, -8, 1, 0),
			ZIndex = 103,
			Font = Enum.Font.SourceSans,
			Text = tostring(value),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 11,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = ItemFrame
		})

		-- Hover animation
		ItemFrame.MouseEnter:Connect(function()
			game:GetService("TweenService"):Create(ItemFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(70, 70, 70)
			}):Play()
			game:GetService("TweenService"):Create(ItemText, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(0, 6, 0, 0)
			}):Play()
		end)

		ItemFrame.MouseLeave:Connect(function()
			game:GetService("TweenService"):Create(ItemFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			}):Play()
			game:GetService("TweenService"):Create(ItemText, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.new(0, 4, 0, 0)
			}):Play()
		end)

		-- Click animation
		ItemFrame.MouseButton1Down:Connect(function()
			game:GetService("TweenService"):Create(ItemFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(100, 150, 255)
			}):Play()
		end)

		ItemFrame.MouseButton1Click:Connect(function()
			-- Flash effect
			game:GetService("TweenService"):Create(ItemFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				BackgroundColor3 = Color3.fromRGB(80, 120, 255)
			}):Play()

			task.wait(0.1)

			option:SetValue(value)
			option:Close()
		end)

		return ItemFrame
	end

	function option:UpdateItems()
		for _, item in pairs(ListContainer:GetChildren()) do
			if item:IsA("TextButton") then
				item:Destroy()
			end
		end
		option.items = {}

		for i, value in ipairs(self.values) do
			local item = createDropdownItem(value, i)
			table.insert(option.items, item)
		end
	end

	option:UpdateItems()

	function option:Toggle()
		self.open = not self.open

		if self.open then
			-- OPEN ANIMATION
			self.ListFrame.Visible = true

			-- Calculate height
			local maxHeight = math.min(ListLayout.AbsoluteContentSize.Y, 150)

			-- Animate dropdown expand
			self.ListFrame.Size = UDim2.new(1, 0, 0, 0)
			game:GetService("TweenService"):Create(self.ListFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, 0, 0, maxHeight + 4)
			}):Play()

			-- Arrow animation
			game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Rotation = 180,
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()

			-- Highlight button
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(70, 70, 70)
			}):Play()

			game:GetService("TweenService"):Create(DropdownText, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
		else
			-- CLOSE ANIMATION
			game:GetService("TweenService"):Create(self.ListFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 0)
			}):Play()

			-- Arrow animation
			game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Rotation = 0,
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()

			-- Restore button
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(45, 45, 45)
			}):Play()

			game:GetService("TweenService"):Create(DropdownText, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()

			task.wait(0.25)
			self.ListFrame.Visible = false
		end
	end

	function option:Close()
		if self.open then
			self.open = false

			game:GetService("TweenService"):Create(self.ListFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 0)
			}):Play()

			game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Rotation = 0,
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()

			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(45, 45, 45)
			}):Play()

			game:GetService("TweenService"):Create(DropdownText, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()

			task.wait(0.25)
			self.ListFrame.Visible = false
		end
	end

	function option:SetValue(value)
		self.value = tostring(value)

		-- Animate text change with flash
		game:GetService("TweenService"):Create(DropdownText, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
			TextTransparency = 1
		}):Play()

		task.wait(0.15)
		DropdownText.Text = self.value

		game:GetService("TweenService"):Create(DropdownText, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			TextTransparency = 0,
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}):Play()

		library.flags[self.flag] = self.value
		if self.callback then
			pcall(self.callback, self.value)
		end
	end

	function option:AddValue(value)
		table.insert(self.values, tostring(value))
		self:UpdateItems()
	end

	function option:RemoveValue(value)
		for i, v in ipairs(self.values) do
			if v == tostring(value) then
				table.remove(self.values, i)
				break
			end
		end
		self:UpdateItems()

		if self.value == tostring(value) then
			self.value = self.values[1] or "Select..."
			DropdownText.Text = self.value
			library.flags[self.flag] = self.value
		end
	end

	-- Hover on main button
	DropdownFrame.MouseEnter:Connect(function()
		if not option.open then
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(55, 55, 55)
			}):Play()
			game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(220, 220, 220)
			}):Play()
		end
	end)

	DropdownFrame.MouseLeave:Connect(function()
		if not option.open then
			game:GetService("TweenService"):Create(Round, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				ImageColor3 = Color3.fromRGB(45, 45, 45)
			}):Play()
			game:GetService("TweenService"):Create(DropdownArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()
		end
	end)

	DropdownFrame.MouseButton1Click:Connect(function()
		option:Toggle()
	end)

	inputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and option.open then
			local mouse = inputService:GetMouseLocation()
			local framePos = option.ListFrame.AbsolutePosition
			local frameSize = option.ListFrame.AbsoluteSize

			if mouse.X < framePos.X or mouse.X > framePos.X + frameSize.X or
			   mouse.Y < framePos.Y - 25 or mouse.Y > framePos.Y + frameSize.Y then
				option:Close()
			end
		end
	end)

	parent:Resize()
	return option
end

local function createFolder(option, parent)
	local FolderHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "FolderHolder",
		Size = UDim2.new(1, 0, 0, 25),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local FolderTitle = library:Create("TextButton", {
		Name = "FolderTitle",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.05, 0, 0, 2),
		Size = UDim2.new(0, 90, 0, 20),
		ZIndex = 4,
		Font = Enum.Font.SourceSans,
		Text = " " .. (option.title or "Folder"),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = FolderHolder
	})

	local FolderArrow = library:Create("TextLabel", {
		Name = "FolderArrow",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -18, 0, 0),
		Size = UDim2.new(0, 18, 1, 0),
		ZIndex = 5,
		Font = Enum.Font.GothamBold,
		Text = "▼",
		TextColor3 = Color3.fromRGB(180, 180, 180),
		TextSize = 10,
		Parent = FolderTitle
	})

	option.Container = library:Create("Frame", {
		Name = "FolderContent",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 25),
		Size = UDim2.new(1, 0, 0, 0),
		Visible = false,
		ClipsDescendants = false,
		Parent = FolderHolder
	})

	local FolderLayout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
		Parent = option.Container
	})

	option.open = false

	function option:Resize()
		pcall(function()
			if self.open then
				local contentHeight = FolderLayout.AbsoluteContentSize.Y
				FolderHolder.Size = UDim2.new(1, 0, 0, 25 + contentHeight)
			else
				FolderHolder.Size = UDim2.new(1, 0, 0, 25)
			end
			parent:Resize()
		end)
	end


	FolderLayout.Changed:Connect(function()
		if option.open then
			local contentHeight = FolderLayout.AbsoluteContentSize.Y
			option.Container.Size = UDim2.new(1, 0, 0, contentHeight)
			FolderHolder.Size = UDim2.new(1, 0, 0, 25 + contentHeight)
			parent:Resize()
		end
	end)


	FolderTitle.MouseButton1Click:Connect(function()
		option.open = not option.open


		game:GetService("TweenService"):Create(FolderArrow, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Rotation = option.open and 180 or 0,
			TextColor3 = option.open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
		}):Play()


		game:GetService("TweenService"):Create(FolderTitle, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
			TextColor3 = option.open and Color3.fromRGB(255, 100, 100) or Color3.fromRGB(255, 255, 255)
		}):Play()

		if option.open then

			option.Container.Visible = true


			for _, v in pairs(option.Container:GetChildren()) do
				if not v:IsA("UIListLayout") then
					v.Visible = true
				end
			end


			local contentHeight = FolderLayout.AbsoluteContentSize.Y


			game:GetService("TweenService"):Create(option.Container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, 0, 0, contentHeight)
			}):Play()


			game:GetService("TweenService"):Create(FolderHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(1, 0, 0, 25 + contentHeight)
			}):Play()


			task.delay(0.3, function()
				parent:Resize()
			end)
		else


			for _, v in pairs(option.Container:GetChildren()) do
				if not v:IsA("UIListLayout") then
					v.Visible = false
				end
			end


			game:GetService("TweenService"):Create(option.Container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 0)
			}):Play()


			game:GetService("TweenService"):Create(FolderHolder, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(1, 0, 0, 25)
			}):Play()


			task.delay(0.3, function()
				option.Container.Visible = false
				parent:Resize()
			end)
		end
	end)


	FolderTitle.MouseEnter:Connect(function()
		if not option.open then
			game:GetService("TweenService"):Create(FolderTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(255, 150, 150)
			}):Play()
			game:GetService("TweenService"):Create(FolderArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(220, 150, 150)
			}):Play()
		end
	end)

	FolderTitle.MouseLeave:Connect(function()
		if not option.open then
			game:GetService("TweenService"):Create(FolderTitle, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(255, 255, 255)
			}):Play()
			game:GetService("TweenService"):Create(FolderArrow, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
				TextColor3 = Color3.fromRGB(180, 180, 180)
			}):Play()
		end
	end)

	function option:AddButton(buttonOption)
		buttonOption = typeof(buttonOption) == "table" and buttonOption or {}
		buttonOption.text = tostring(buttonOption.text)
		buttonOption.callback = typeof(buttonOption.callback) == "function" and buttonOption.callback or function() end
		buttonOption.type = "button"
		buttonOption.position = #self.options
		buttonOption.flag = buttonOption.flag or buttonOption.text
		table.insert(self.options, buttonOption)

		createButton(buttonOption, self)
		return buttonOption
	end

	function option:AddKeybind(keybindOption)
		keybindOption = typeof(keybindOption) == "table" and keybindOption or {}
		keybindOption.text = tostring(keybindOption.text or "Keybind")
		keybindOption.key = keybindOption.key or Enum.KeyCode.F
		keybindOption.mode = keybindOption.mode or "hold"
		keybindOption.callback = typeof(keybindOption.callback) == "function" and keybindOption.callback or function() end
		keybindOption.type = "keybind"
		keybindOption.position = #self.options
		keybindOption.flag = keybindOption.flag or keybindOption.text
		table.insert(self.options, keybindOption)

		createKeybind(keybindOption, self)
		return keybindOption
	end

	function option:AddToggle(toggleOption)
		toggleOption = typeof(toggleOption) == "table" and toggleOption or {}
		toggleOption.text = tostring(toggleOption.text or "Toggle")
		toggleOption.callback = typeof(toggleOption.callback) == "function" and toggleOption.callback or function() end
		toggleOption.type = "toggle"
		toggleOption.position = #self.options
		toggleOption.flag = toggleOption.flag or toggleOption.text
		table.insert(self.options, toggleOption)

		createToggle(toggleOption, self)
		return toggleOption
	end

	function option:AddBox(boxOption)
		boxOption = typeof(boxOption) == "table" and boxOption or {}
		boxOption.text = tostring(boxOption.text or "TextBox")
		boxOption.callback = typeof(boxOption.callback) == "function" and boxOption.callback or function() end
		boxOption.type = "box"
		boxOption.position = #self.options
		boxOption.flag = boxOption.flag or boxOption.text
		table.insert(self.options, boxOption)

		createBox(boxOption, self)
		return boxOption
	end

	function option:AddSlider(sliderOption)
		sliderOption = typeof(sliderOption) == "table" and sliderOption or {}
		sliderOption.text = tostring(sliderOption.text or "Slider")
		sliderOption.min = sliderOption.min or 0
		sliderOption.max = sliderOption.max or 100
		sliderOption.precise = sliderOption.precise or false
		sliderOption.callback = typeof(sliderOption.callback) == "function" and sliderOption.callback or function() end
		sliderOption.type = "slider"
		sliderOption.position = #self.options
		sliderOption.flag = sliderOption.flag or sliderOption.text
		table.insert(self.options, sliderOption)

		createSlider(sliderOption, self)
		return sliderOption
	end

	function option:AddDropdown(dropdownOption)
		dropdownOption = typeof(dropdownOption) == "table" and dropdownOption or {}
		dropdownOption.text = tostring(dropdownOption.text or "Dropdown")
		dropdownOption.values = typeof(dropdownOption.values) == "table" and dropdownOption.values or {"Option 1", "Option 2"}
		dropdownOption.value = dropdownOption.value or dropdownOption.values[1] or "Select..."
		dropdownOption.callback = typeof(dropdownOption.callback) == "function" and dropdownOption.callback or function() end
		dropdownOption.type = "dropdown"
		dropdownOption.position = #self.options
		dropdownOption.flag = dropdownOption.flag or dropdownOption.text
		table.insert(self.options, dropdownOption)

		createDropdown(dropdownOption, self)
		return dropdownOption
	end

	parent:Resize()
	return option
end

function library:CreateWindow(WName)
	library.count = library.count + 1
	local ui = {}

	local Holder = library:Create("ImageLabel", {
		Name = WName,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, (15 + (102 * library.count) - 100), 0.002, 0),
		Size = UDim2.new(0, 100, 0, 28),
		ZIndex = 5,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(26, 26, 26),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = self.base or game:GetService("CoreGui")
	})

	local ToggleGUI = library:Create("TextButton", {
		Name = "ToggleGUI",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.80, 0, 0, 0),
		Size = UDim2.new(0, 20, 0, 28),
		ZIndex = 6,
		Font = Enum.Font.GothamBold,
		Text = "▼",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 11,
		Parent = Holder
	})

	local Container = library:Create("ImageLabel", {
		Name = "Container",
		BackgroundTransparency = 1,
		ClipsDescendants = false,
		Size = UDim2.new(0, 100, 0, 28),
		ZIndex = 2,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(35, 35, 35),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = Holder
	})

	local WindowText = library:Create("TextLabel", {
		Name = WName,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.05, 0, 0.15, 0),
		Size = UDim2.new(0, 75, 0, 20),
		ZIndex = 5,
		Font = Enum.Font.SourceSans,
		Text = WName,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 12,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = Holder
	})

	local UIListLayout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 0),
		Parent = Container
	})

	local UIPadding = library:Create("UIPadding", {
		PaddingTop = UDim.new(0, 30),
		Parent = Container
	})

	ui.Holder = Holder
	ui.Container = Container
	ui.ToggleGUI = ToggleGUI
	ui.options = {}
	ui.opened = false

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

	ToggleGUI.MouseButton1Click:Connect(function()
	pcall(function()
		ui.opened = not ui.opened

		game:GetService("TweenService"):Create(ToggleGUI, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Rotation = ui.opened and 180 or 0
		}):Play()

		if ui.opened then

			local y = 30
			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					v.Visible = true
					y = y + v.AbsoluteSize.Y
				end
			end


			game:GetService("TweenService"):Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, 100, 0, y)
			}):Play()
		else

			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					v.Visible = false
				end
			end


			game:GetService("TweenService"):Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 100, 0, 28)
			}):Play()
		end
	end)
end)

	function ui:Resize()
		pcall(function()
			local y = 28
			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					y = y + v.AbsoluteSize.Y
				end
			end
			Container.Size = UDim2.new(0, 100, 0, y + 2)
		end)
	end

	function ui:AddButton(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "button"
		option.position = #self.options
		option.flag = option.flag or option.text
		table.insert(self.options, option)

		createButton(option, self)
		return option
	end

	function ui:AddToggle(toggleOption)
		toggleOption = typeof(toggleOption) == "table" and toggleOption or {}
		toggleOption.text = tostring(toggleOption.text or "Toggle")
		toggleOption.callback = typeof(toggleOption.callback) == "function" and toggleOption.callback or function() end
		toggleOption.type = "toggle"
		toggleOption.position = #self.options
		toggleOption.flag = toggleOption.flag or toggleOption.text
		table.insert(self.options, toggleOption)

		createToggle(toggleOption, self)
		return toggleOption
	end

	function ui:AddBox(boxOption)
		boxOption = typeof(boxOption) == "table" and boxOption or {}
		boxOption.text = tostring(boxOption.text or "TextBox")
		boxOption.callback = typeof(boxOption.callback) == "function" and boxOption.callback or function() end
		boxOption.type = "box"
		boxOption.position = #self.options
		boxOption.flag = boxOption.flag or boxOption.text
		table.insert(self.options, boxOption)

		createBox(boxOption, self)
		return boxOption
	end

	function ui:AddSlider(sliderOption)
		sliderOption = typeof(sliderOption) == "table" and sliderOption or {}
		sliderOption.text = tostring(sliderOption.text or "Slider")
		sliderOption.min = sliderOption.min or 0
		sliderOption.max = sliderOption.max or 100
		sliderOption.precise = sliderOption.precise or false
		sliderOption.callback = typeof(sliderOption.callback) == "function" and sliderOption.callback or function() end
		sliderOption.type = "slider"
		sliderOption.position = #self.options
		sliderOption.flag = sliderOption.flag or sliderOption.text
		table.insert(self.options, sliderOption)

		createSlider(sliderOption, self)
		return sliderOption
	end

	function ui:AddKeybind(keybindOption)
		keybindOption = typeof(keybindOption) == "table" and keybindOption or {}
		keybindOption.text = tostring(keybindOption.text or "Keybind")
		keybindOption.key = keybindOption.key or Enum.KeyCode.F
		keybindOption.mode = keybindOption.mode or "hold"
		keybindOption.callback = typeof(keybindOption.callback) == "function" and keybindOption.callback or function() end
		keybindOption.type = "keybind"
		keybindOption.position = #self.options
		keybindOption.flag = keybindOption.flag or keybindOption.text
		table.insert(self.options, keybindOption)

		createKeybind(keybindOption, self)
		return keybindOption
	end

	function ui:AddDropdown(dropdownOption)
		dropdownOption = typeof(dropdownOption) == "table" and dropdownOption or {}
		dropdownOption.text = tostring(dropdownOption.text or "Dropdown")
		dropdownOption.values = typeof(dropdownOption.values) == "table" and dropdownOption.values or {"Option 1", "Option 2"}
		dropdownOption.value = dropdownOption.value or dropdownOption.values[1] or "Select..."
		dropdownOption.callback = typeof(dropdownOption.callback) == "function" and dropdownOption.callback or function() end
		dropdownOption.type = "dropdown"
		dropdownOption.position = #self.options
		dropdownOption.flag = dropdownOption.flag or dropdownOption.text
		table.insert(self.options, dropdownOption)

		createDropdown(dropdownOption, self)
		return dropdownOption
	end

	function ui:AddFolder(title)
		local option = {}
		option.title = tostring(title)
		option.options = {}
		option.open = false
		option.type = "folder"
		option.position = #self.options
		table.insert(self.options, option)

		createFolder(option, self)
		return option
	end

	table.insert(library.windows, ui)
	return ui
end

function library:Init()
	local FindLibrary = game:GetService("CoreGui"):FindFirstChild("ToraZenLibrary")
	if FindLibrary then safeDestroy(FindLibrary) end

	self.base = self:Create("ScreenGui", {
		Name = "ToraZenLibrary",
		ResetOnSpawn = false,
		Parent = game:GetService("CoreGui")
	})

	if syn and syn.protect_gui then
		syn.protect_gui(self.base)
	elseif get_hidden_gui then
		get_hidden_gui(self.base)
	elseif gethui then
		gethui(self.base)
	end

	for _, window in next, self.windows do
		if window.Holder then
			window.Holder.Parent = self.base
		end
	end

	return self.base
end

function library:Close()
	if typeof(self.base) ~= "Instance" then return end
	self.open = not self.open
	for _, window in next, self.windows do
		if window.Holder then
			window.Holder.Visible = self.open
		end
	end
end

inputService.InputBegan:Connect(function(Input, gameProcessed)
	if not gameProcessed and Input.KeyCode == Enum.KeyCode.RightShift then
		library:Close()
	end
end)

return library
