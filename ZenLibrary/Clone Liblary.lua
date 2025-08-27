-- // My First Very Clean Library \\ --
-- // Zen Library Lua ( Version 1.0.0.0 ) \\ --

local library = {count = 0}

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

function library:CreateWindow(WName)
	library.count = library.count + 1
	local ui = {}

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
	Holder.ImageColor3 = Color3.fromRGB(26, 26, 26)
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
	ToggleGUI.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleGUI.TextSize = 17

	Container.Name = "Container"
	Container.Parent = Holder
	Container.BackgroundTransparency = 1
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
	WindowText.BackgroundTransparency = 1
	WindowText.BorderSizePixel = 0
	WindowText.Position = UDim2.new(0.04, 0, 0.154, 0)
	WindowText.Size = UDim2.new(0, 186, 0, 27)
	WindowText.ZIndex = 5
	WindowText.Font = Enum.Font.SourceSans
	WindowText.Text = WName
	WindowText.TextColor3 = Color3.fromRGB(255, 255, 255)
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

			-- NOTE: TweenSize expects enums; strings work on most executors, but we’ll use enums.
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

	-- ============ ELEMENTS ============

	-- Button
	function ui:Button(Name, callback)
		pcall(function()
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
			Button.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
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
			SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderTitle.TextSize = 15
			SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

			SliderFrame.Name = "SliderFrame"
			SliderFrame.Parent = SliderHolder
			SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Position = UDim2.new(0.045, 0, 0.5405, 0)
			SliderFrame.Size = UDim2.new(0, 185, 0, 6)
			SliderFrame.ZIndex = 3
			SliderFrame.Text = ""

			Slider.Name = "Slider"
			Slider.Parent = SliderFrame
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(0, 0, 0, 6)
			Slider.ZIndex = 4

			UIGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 116, 116))
			}
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
			ValueText.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			BoxText.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Box.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
			Box.Text = ""
			Box.TextColor3 = Color3.fromRGB(255, 255, 255)
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
			Round.ImageColor3 = Color3.fromRGB(43, 43, 43)
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
			MainToggle.ImageColor3 = Color3.fromRGB(90, 255, 115)
			MainToggle.ImageTransparency = 1

			ToggleText.Name = "ToggleText"
			ToggleText.Parent = ToggleHolder
			ToggleText.BackgroundTransparency = 1
			ToggleText.Position = UDim2.new(0.045, 0, 0.081, 0)
			ToggleText.Size = UDim2.new(0, 157, 0, 29)
			ToggleText.ZIndex = 3
			ToggleText.Font = Enum.Font.SourceSansSemibold
			ToggleText.Text = Name or "Toggle"
			ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
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
	-- ========== /ELEMENTS ==========

	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = "Zen Library V1 (Version 1.0.0.0)",
			Text = "Made by VantaXock",
			Duration = 3
		})
	end)

	return ui
end

return library
