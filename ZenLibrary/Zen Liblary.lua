-- // My First Very Clean Liblary \\ --
-- // Zen Liblary Lua ( Version 1.0.0.0 ) \\ --


local library = {count = 0};


local function safeDestroy(obj)
	if obj and obj.Parent then
		pcall(function()
			obj:Destroy()
		end)
	end
end

local FindLibrary = game:GetService("CoreGui"):FindFirstChild("UI Library")
if FindLibrary then
	safeDestroy(FindLibrary)
end

local UILibrary = Instance.new("ScreenGui")
UILibrary.Name = "UI Library"
UILibrary.Parent = game:GetService("CoreGui")
UILibrary.ResetOnSpawn = false

game:GetService("UserInputService").InputBegan:Connect(function(Input, gameProcessed)
	if not gameProcessed and Input.KeyCode == Enum.KeyCode.RightShift then
		UILibrary.Enabled = not UILibrary.Enabled
	end
end)

function library:CreateWindow(WName)
	library.count = library.count + 1
	local ui = {};
	local Holder = Instance.new("ImageLabel")
	local WindowText = Instance.new("TextLabel")
	local Container = Instance.new("ImageLabel")
	local ToggleGUI = Instance.new("TextButton")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")

	Holder.Name = WName
	Holder.Parent = UILibrary
	Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Holder.BackgroundTransparency = 1.000
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0, (15 + (202 * library.count) - 200), 0.002, 0)
	Holder.Size = UDim2.new(0, 200, 0, 39)
	Holder.ZIndex = 5
	Holder.Image = "rbxassetid://3570695787"
	Holder.ImageColor3 = Color3.fromRGB(26, 26, 26)
	Holder.ScaleType = Enum.ScaleType.Slice
	Holder.SliceCenter = Rect.new(100, 100, 100, 100)
	Holder.SliceScale = 0.040

	ToggleGUI.Name = "ToggleGUI"
	ToggleGUI.Parent = Holder
	ToggleGUI.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ToggleGUI.BackgroundTransparency = 1.000
	ToggleGUI.BorderSizePixel = 0
	ToggleGUI.Position = UDim2.new(0.852380931, 0, 0, 0)
	ToggleGUI.Size = UDim2.new(0, 31, 0, 38)
	ToggleGUI.ZIndex = 6
	ToggleGUI.Font = Enum.Font.GothamBold
	ToggleGUI.Text = "▼"
	ToggleGUI.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleGUI.TextSize = 17.000

	Container.Name = "Container"
	Container.Parent = Holder
	Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Container.BackgroundTransparency = 1.000
	Container.ClipsDescendants = true
	Container.Size = UDim2.new(0, 200, 0, 37)
	Container.ZIndex = 2
	Container.Image = "rbxassetid://3570695787"
	Container.ImageColor3 = Color3.fromRGB(35, 35, 35)
	Container.ScaleType = Enum.ScaleType.Slice
	Container.SliceCenter = Rect.new(100, 100, 100, 100)
	Container.SliceScale = 0.040

	WindowText.Name = WName
	WindowText.Parent = Holder
	WindowText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowText.BackgroundTransparency = 1.000
	WindowText.BorderSizePixel = 0
	WindowText.Position = UDim2.new(0.0399999991, 0, 0.15384616, 0)
	WindowText.Size = UDim2.new(0, 186, 0, 27)
	WindowText.ZIndex = 5
	WindowText.Font = Enum.Font.SourceSans
	WindowText.Text = WName
	WindowText.TextColor3 = Color3.fromRGB(255, 255, 255)
	WindowText.TextSize = 22.000
	WindowText.TextXAlignment = Enum.TextXAlignment.Left

	UIListLayout.Parent = Container
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 1)

	UIPadding.Parent = Container
	UIPadding.PaddingTop = UDim.new(0, 40)

	local NewWindow = Holder;

	local players = game:GetService('Players');
    local player = players.LocalPlayer;
    local mouse = player:GetMouse();
    local run = game:GetService('RunService');
    
    local function draggable(obj)
        pcall(function()
            obj.Active = true;
            local isDragging = false
            local dragStart = nil
            local startPos = nil
            
            obj.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = true;
                    dragStart = Vector2.new(mouse.X, mouse.Y)
                    startPos = obj.Position;
                end;
            end);
            
            obj.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = false;
                end;
            end);
            
            run.Heartbeat:Connect(function()
                if isDragging then
                    local mousePos = Vector2.new(mouse.X, mouse.Y)
                    local delta = mousePos - dragStart;
                    obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y);
                end
            end)
        end)
	end;

	draggable(Holder)

	local TweenService = game:GetService("TweenService");
	local function Rotation(Object, RotateAMT, Delay)
		pcall(function()
			local ToTween = Object
			local tweenInfo = TweenInfo.new(Delay, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
			local Tweener = TweenService:Create(ToTween, tweenInfo, {Rotation = RotateAMT})
			Tweener:Play()
		end)
	end

	local Enabled = false;

	NewWindow:FindFirstChild("ToggleGUI").MouseButton1Click:Connect(function()
		pcall(function()
			Enabled = not Enabled
			if Enabled then
				Rotation(NewWindow:FindFirstChild("ToggleGUI"), 90, .2)
			else
				Rotation(NewWindow:FindFirstChild("ToggleGUI"), 0, .2)
			end
			
			task.wait(0.1)
			
			local y = 40 
			for i, v in pairs(Container:GetChildren()) do
				if (not v:IsA("UIPadding") and not v:IsA("UIListLayout")) then
					y = y + (v.AbsoluteSize.Y + 2)
				end
			end

			local targetSize = Enabled and UDim2.new(0, 200, 0, y) or UDim2.new(0, 200, 0, 37);
			local targetDirection = Enabled and "Out" or "In"

			Container:TweenSize(targetSize, targetDirection, "Linear", 0.15, true)
		end)
	end)
	
	print("Welcome")
 
	function ui:Resize()
		pcall(function()
			local y = 37
			for i, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					y = y + (v.AbsoluteSize.Y + 2)
				end
			end
			Container.Size = UDim2.new(0, 200, 0, y + 2)
		end)
	end

	function ui:Button(Name, callback)
		pcall(function()
			local ButtonHolder = Instance.new("Frame")
			local Button = Instance.new("TextButton")
			local Button_Roundify_5px = Instance.new("ImageLabel")

			ButtonHolder.Name = "ButtonHolder"
			ButtonHolder.Parent = Container
			ButtonHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonHolder.BackgroundTransparency = 1.000
			ButtonHolder.BorderSizePixel = 0
			ButtonHolder.Position = UDim2.new(0, 0, 0.519480586, 0)
			ButtonHolder.Size = UDim2.new(0, 200, 0, 37)
			ButtonHolder.ZIndex = 2

			Button.Name = "Button"
			Button.Parent = ButtonHolder
			Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			Button.BackgroundTransparency = 1.000
			Button.BorderSizePixel = 0
			Button.Position = UDim2.new(0.0299999993, 0, 0.0810000002, 0)
			Button.Size = UDim2.new(0, 190, 0, 30)
			Button.ZIndex = 4
			Button.Font = Enum.Font.SourceSans
			Button.Text = Name or "Button"
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
			Button.TextSize = 22.000
			Button.TextWrapped = true
			Button.ClipsDescendants = true;

			Button_Roundify_5px.Name = "Button_Roundify_5px"
			Button_Roundify_5px.Parent = Button
			Button_Roundify_5px.Active = true
			Button_Roundify_5px.AnchorPoint = Vector2.new(0.5, 0.5)
			Button_Roundify_5px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button_Roundify_5px.BackgroundTransparency = 1.000
			Button_Roundify_5px.Position = UDim2.new(0.5, 0, 0.5, 0)
			Button_Roundify_5px.Selectable = true
			Button_Roundify_5px.Size = UDim2.new(1, 0, 1, 0)
			Button_Roundify_5px.ZIndex = 3
			Button_Roundify_5px.Image = "rbxassetid://3570695787"
			Button_Roundify_5px.ImageColor3 = Color3.fromRGB(45, 45, 45)
			Button_Roundify_5px.ScaleType = Enum.ScaleType.Slice
			Button_Roundify_5px.SliceCenter = Rect.new(100, 100, 100, 100)
			Button_Roundify_5px.SliceScale = 0.050

			local Circle = Instance.new("ImageLabel")
			Circle.Name = "Circle"
			Circle.Parent = game.CoreGui
			Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Circle.BackgroundTransparency = 1.000
			Circle.ZIndex = 10
			Circle.Image = "http://www.roblox.com/asset/?id=266543268"
			Circle.ImageColor3 = Color3.fromRGB(126, 126, 126)
			Circle.ImageTransparency = 0.700

			function CircleClick(Button, X, Y)
				pcall(function()
					local Circle = game.CoreGui:WaitForChild("Circle"):Clone()
					Circle.Parent = Button
					local NewX = X - Button.AbsolutePosition.X
					local NewY = Y - Button.AbsolutePosition.Y
					Circle.Position = UDim2.new(0, NewX, 0, NewY)
					
					local Size = 0
					if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
						Size = Button.AbsoluteSize.X * 1.5
					elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
						Size = Button.AbsoluteSize.Y * 1.5
					elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
						print("Hello")
						Size = Button.AbsoluteSize.X * 1.5
					end
					
					local Time = 0.5
					Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
					for i = 1, 10 do
						Circle.ImageTransparency = Circle.ImageTransparency + 0.03
						task.wait(Time/10)
					end
					safeDestroy(Circle)
				end)
			end
			
			local Mouse = game.Players.LocalPlayer:GetMouse()
			Button.MouseButton1Click:Connect(function()
				if callback then
					pcall(callback)
				end
				spawn(function()
					CircleClick(Button, Mouse.X, Mouse.Y)
				end)
			end)
			ui:Resize()
		end)
	end

	function ui:Slider(name, min, max, precise, callback)
	pcall(function()
		local PreciseValue = precise;
		local SliderHolder = Instance.new("Frame")
		local SliderTitle = Instance.new("TextLabel")
		local SliderFrame = Instance.new("TextButton")
		local Slider = Instance.new("Frame")
		local UIGradient = Instance.new("UIGradient")
		local ValueText = Instance.new("TextLabel")

		SliderHolder.Name = "SliderHolder"
		SliderHolder.Parent = Container
		SliderHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderHolder.BackgroundTransparency = 1.000
		SliderHolder.BorderSizePixel = 0
		SliderHolder.Position = UDim2.new(0, 0, 0.519480586, 0)
		SliderHolder.Size = UDim2.new(0, 200, 0, 37)
		SliderHolder.ZIndex = 2

		SliderTitle.Name = "SliderTitle"
		SliderTitle.Parent = SliderHolder
		SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderTitle.BackgroundTransparency = 1.000
		SliderTitle.BorderSizePixel = 0
		SliderTitle.Position = UDim2.new(0.0450000018, 0, 0.0810000449, 0)
		SliderTitle.Size = UDim2.new(0, 185, 0, 16)
		SliderTitle.ZIndex = 3
		SliderTitle.Font = Enum.Font.SourceSansSemibold
		SliderTitle.LineHeight = 1.200
		SliderTitle.Text = name or "Slider"
		SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
		SliderTitle.TextSize = 15.000
		SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

		SliderFrame.Name = "SliderFrame"
		SliderFrame.Parent = SliderHolder
		SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderFrame.BorderSizePixel = 0
		SliderFrame.Position = UDim2.new(0.0450000018, 0, 0.540459514, 0)
		SliderFrame.Size = UDim2.new(0, 185, 0, 6)
		SliderFrame.ZIndex = 3
		SliderFrame.Font = Enum.Font.SourceSans
		SliderFrame.Text = ""
		SliderFrame.TextColor3 = Color3.fromRGB(0, 0, 0)
		SliderFrame.TextSize = 14.000

		Slider.Name = "Slider"
		Slider.Parent = SliderFrame
		Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new(0, 0, 0, 6)
		Slider.ZIndex = 4

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 116, 116))}
		UIGradient.Parent = Slider

		ValueText.Name = "ValueText"
		ValueText.Parent = SliderHolder
		ValueText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ValueText.BackgroundTransparency = 1.000
		ValueText.BorderSizePixel = 0
		ValueText.Position = UDim2.new(0.0450000018, 0, 0.0810000449, 0)
		ValueText.Size = UDim2.new(0, 185, 0, 16)
		ValueText.ZIndex = 3
		ValueText.Font = Enum.Font.SourceSansSemibold
		ValueText.LineHeight = 1.200
		ValueText.Text = "";
		ValueText.TextColor3 = Color3.fromRGB(255, 255, 255)
		ValueText.TextSize = 15.000
		ValueText.TextXAlignment = Enum.TextXAlignment.Right

		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		local Connection;
		local isDragging = false

		local TweenService = game:GetService("TweenService")
		local function Fade(Object, FadeAmount, Delay)
			pcall(function()
				local ToTween = Object
				local Tweener = TweenService:Create(ToTween, TweenInfo.new(Delay), {TextTransparency = FadeAmount})
				Tweener:Play()
			end)
		end

		UserInputService.InputEnded:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				if isDragging and Connection then
					Connection:Disconnect()
					Connection = nil
					isDragging = false
					Fade(ValueText, 1, .2)
				end
			end
		end)

		local Vals = {
			["Min"] = min or 0;
			["Max"] = max or 100;
		}

		ValueText.Text = Vals.Min .. "/" .. Vals.Max

		SliderFrame.MouseButton1Down:Connect(function()
			pcall(function()
				if Connection then
					Connection:Disconnect()
				end
				isDragging = true
				Connection = RunService.RenderStepped:Connect(function()
					if not isDragging then
						Connection:Disconnect()
						Connection = nil
						return
					end
					
					local Mouse = UserInputService:GetMouseLocation()
					local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)
					local GetValue = Vals.Min + (Vals.Max - Vals.Min) * Percentage

					GetValue = math.floor(GetValue)

					if PreciseValue then
						GetValue = string.format("%.2f", GetValue)
					end

					Slider:TweenSize(UDim2.new(Percentage, 0, 0, 6), "Out", "Linear", .03, true)
					ValueText.Text = GetValue .. "/" .. Vals.Max
					Fade(ValueText, 0, .2)
					if callback then
						pcall(callback, tonumber(GetValue))
					end
				end)
			end)
		end)
		ui:Resize()
	end)
end

	function ui:Box(Name, callback)
		pcall(function()
			local BoxHolder = Instance.new("Frame")
			local BoxText = Instance.new("TextLabel")
			local Box = Instance.new("TextBox")
			local Box_Roundify_4px = Instance.new("ImageLabel")

			BoxHolder.Name = "BoxHolder"
			BoxHolder.Parent = Container
			BoxHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BoxHolder.BackgroundTransparency = 1.000
			BoxHolder.BorderSizePixel = 0
			BoxHolder.Position = UDim2.new(0, 0, 0.519480586, 0)
			BoxHolder.Size = UDim2.new(0, 200, 0, 37)
			BoxHolder.ZIndex = 2

			BoxText.Name = "BoxText"
			BoxText.Parent = BoxHolder
			BoxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BoxText.BackgroundTransparency = 1.000
			BoxText.BorderSizePixel = 0
			BoxText.ClipsDescendants = true
			BoxText.Position = UDim2.new(0.0399999991, 0, 0.162162155, 0)
			BoxText.Size = UDim2.new(0, 94, 0, 23)
			BoxText.ZIndex = 3
			BoxText.Font = Enum.Font.SourceSansSemibold
			BoxText.LineHeight = 1.100
			BoxText.Text = Name or "TextBox"
			BoxText.TextColor3 = Color3.fromRGB(255, 255, 255)
			BoxText.TextSize = 15.000
			BoxText.TextXAlignment = Enum.TextXAlignment.Left

			Box.Name = "Box"
			Box.Parent = BoxHolder
			Box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Box.BackgroundTransparency = 1.000
			Box.BorderSizePixel = 0
			Box.Position = UDim2.new(0.540000081, 0, 0.243243247, 0)
			Box.Size = UDim2.new(0, 85, 0, 23)
			Box.ZIndex = 4
			Box.Font = Enum.Font.SourceSansSemibold
			Box.LineHeight = 1.500
			Box.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
			Box.Text = ""
			Box.TextColor3 = Color3.fromRGB(255, 255, 255)
			Box.TextSize = 14.000

			Box_Roundify_4px.Name = "Box_Roundify_4px"
			Box_Roundify_4px.Parent = Box
			Box_Roundify_4px.Active = true
			Box_Roundify_4px.AnchorPoint = Vector2.new(0.5, 0.5)
			Box_Roundify_4px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Box_Roundify_4px.BackgroundTransparency = 1.000
			Box_Roundify_4px.Position = UDim2.new(0.5, 0, 0.386363626, 0)
			Box_Roundify_4px.Selectable = true
			Box_Roundify_4px.Size = UDim2.new(1, 0, 1.04545462, 0)
			Box_Roundify_4px.ZIndex = 3
			Box_Roundify_4px.Image = "rbxassetid://3570695787"
			Box_Roundify_4px.ImageColor3 = Color3.fromRGB(43, 43, 43)
			Box_Roundify_4px.ScaleType = Enum.ScaleType.Slice
			Box_Roundify_4px.SliceCenter = Rect.new(100, 100, 100, 100)
			Box_Roundify_4px.SliceScale = 0.040

			Box.FocusLost:Connect(function(Enter)
				if Enter then
					if Box.Text ~= "" and Box.Text ~= " " then
						if callback then
							pcall(callback, Box.Text)
						end
					end
				end
			end)

			pcall(function()
				Box.Changed:Connect(function()
					if #Box.Text >= 15 then
						Box.TextScaled = true
					else
						Box.TextScaled = false
					end
				end)
			end)
			ui:Resize()
		end)
	end

	function ui:Toggle(Name, callback)
		pcall(function()
			local Enabled = false;

			local ToggleHolder = Instance.new("Frame")
			local ToggleImage = Instance.new("ImageLabel")
			local MainToggle = Instance.new("ImageButton")
			local ToggleText = Instance.new("TextLabel")

			ToggleHolder.Name = "ToggleHolder"
			ToggleHolder.Parent = Container
			ToggleHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleHolder.BackgroundTransparency = 1.000
			ToggleHolder.BorderSizePixel = 0
			ToggleHolder.Position = UDim2.new(0, 0, 0.519480586, 0)
			ToggleHolder.Size = UDim2.new(0, 200, 0, 37)
			ToggleHolder.ZIndex = 2

			ToggleImage.Name = "ToggleImage"
			ToggleImage.Parent = ToggleHolder
			ToggleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleImage.BackgroundTransparency = 1.000
			ToggleImage.BorderSizePixel = 0
			ToggleImage.Position = UDim2.new(0.829999983, 0, 0.0810000002, 0)
			ToggleImage.Size = UDim2.new(0, 30, 0, 30)
			ToggleImage.ZIndex = 2
			ToggleImage.Image = "http://www.roblox.com/asset/?id=4908273649"

			MainToggle.Name = "MainToggle"
			MainToggle.Parent = ToggleHolder
			MainToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			MainToggle.BackgroundTransparency = 1.000
			MainToggle.BorderSizePixel = 0
			MainToggle.Position = UDim2.new(0.829999983, 0, 0.0810000002, 0)
			MainToggle.Size = UDim2.new(0, 30, 0, 30)
			MainToggle.ZIndex = 3
			MainToggle.Image = "http://www.roblox.com/asset/?id=4908257956"
			MainToggle.ImageColor3 = Color3.fromRGB(90, 255, 115)
			MainToggle.ImageTransparency = 1.000

			ToggleText.Name = "ToggleText"
			ToggleText.Parent = ToggleHolder
			ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.BackgroundTransparency = 1.000
			ToggleText.BorderSizePixel = 0
			ToggleText.Position = UDim2.new(0.0450000018, 0, 0.0810000449, 0)
			ToggleText.Size = UDim2.new(0, 157, 0, 29)
			ToggleText.ZIndex = 3
			ToggleText.Font = Enum.Font.SourceSansSemibold
			ToggleText.Text = Name or "Toggle"
			ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.TextSize = 14.000
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left

			local TweenService = game:GetService("TweenService")

			local function Fade(Object, FadeAmount, Delay)
				pcall(function()
					local ToTween = Object
					local Tweener = TweenService:Create(ToTween, TweenInfo.new(Delay), {ImageTransparency = FadeAmount})
					Tweener:Play()
				end)
			end

			MainToggle.MouseButton1Click:Connect(function()
				Enabled = not Enabled
				if callback then
					pcall(callback, Enabled)
				end
				if Enabled then
					Fade(MainToggle, 0, .2)
				else
					Fade(MainToggle, 1, .2)
				end
			end)
			ui:Resize()
		end)
	end
	
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Zen Liblary V1 (Version 1.0.0.0)",
			Text = "Made by VantaXock",
			Duration = 3
		})
	end)
	
	return ui
end

return library
