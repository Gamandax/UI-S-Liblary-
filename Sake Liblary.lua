pcall(function()
    game:GetService('CoreGui'):FindFirstChild('ui'):Remove()
end)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local Library = {}
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- Create UI
function Library:Window(title)
    local ui = Instance.new("ScreenGui")
    ui.Name = "ui"
    ui.Parent = game:GetService("CoreGui")
    ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ui.IgnoreGuiInset = true
    ui.ResetOnSpawn = false

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ui
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.377, 0, 0.368, 0)
    Main.Size = UDim2.new(0, 470, 0, 283)
    Main.Active = true
    Main.Selectable = true
    
    -- Make draggable
    local dragging = false
    local dragInput, dragStart, startPos
    
    local function updateInput(input)
        local Delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
    end
    
    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    Main.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            updateInput(input)
        end
    end)
    
    -- Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main
    
    -- Shadow
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = Main
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow.BackgroundTransparency = 1.000
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    
    -- Top Bar
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(1, 0, 0, 34)
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 6)
    TopCorner.Parent = Top
    
    local TopCover = Instance.new("Frame")
    TopCover.Name = "Cover"
    TopCover.Parent = Top
    TopCover.AnchorPoint = Vector2.new(0.5, 1)
    TopCover.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
    TopCover.BorderSizePixel = 0
    TopCover.Position = UDim2.new(0.5, 0, 1, 0)
    TopCover.Size = UDim2.new(1, 0, 0, 4)
    
    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Parent = Top
    Line.AnchorPoint = Vector2.new(0.5, 1)
    Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Line.BackgroundTransparency = 0.920
    Line.Position = UDim2.new(0.5, 0, 1, 1)
    Line.Size = UDim2.new(1, 0, 0, 1)
    
    -- Logo
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.AnchorPoint = Vector2.new(0, 0.5)
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.Position = UDim2.new(0, 4, 0.5, 0)
    Logo.Size = UDim2.new(0, 26, 0, 30)
    Logo.Image = "http://www.roblox.com/asset/?id=7803241868"
    Logo.ImageColor3 = Color3.fromRGB(232, 17, 85)
    
    -- Close Button
    local Close = Instance.new("ImageButton")
    Close.Name = "Close"
    Close.Parent = Top
    Close.AnchorPoint = Vector2.new(1, 0.5)
    Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Close.BackgroundTransparency = 1.000
    Close.Position = UDim2.new(1, -6, 0.5, 0)
    Close.Size = UDim2.new(0, 20, 0, 20)
    Close.Image = "http://www.roblox.com/asset/?id=7755372427"
    Close.ImageColor3 = Color3.fromRGB(199, 199, 199)
    Close.ScaleType = Enum.ScaleType.Crop
    
    Close.MouseButton1Click:Connect(function()
        ui:Destroy()
    end)
    
    Close.MouseEnter:Connect(function()
        TweenService:Create(Close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(255,255,255)}):Play()
    end)
    
    Close.MouseLeave:Connect(function()
        TweenService:Create(Close, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageColor3 = Color3.fromRGB(166, 166, 166)}):Play()
    end)
    
    -- Title
    local GameName = Instance.new("TextLabel")
    GameName.Name = "GameName"
    GameName.Parent = Top 
    GameName.AnchorPoint = Vector2.new(0, 0.5)
    GameName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    GameName.BackgroundTransparency = 1.000
    GameName.Position = UDim2.new(0, 32, 0.5, 0)
    GameName.Size = UDim2.new(0, 165, 0, 22)
    GameName.Font = Enum.Font.Gotham
    GameName.Text = title or "Game Name"
    GameName.TextColor3 = Color3.fromRGB(232, 17, 85)
    GameName.TextSize = 14.000
    GameName.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Tabs Container
    local Tabs = Instance.new("Frame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    Tabs.BorderSizePixel = 0
    Tabs.Position = UDim2.new(0, 0, 0, 35)
    Tabs.Size = UDim2.new(0, 122, 1, -35)
    
    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 6)
    TabsCorner.Parent = Tabs
    
    local TabsCover = Instance.new("Frame")
    TabsCover.Name = "Cover"
    TabsCover.Parent = Tabs
    TabsCover.AnchorPoint = Vector2.new(1, 0.5)
    TabsCover.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
    TabsCover.BorderSizePixel = 0
    TabsCover.Position = UDim2.new(1, 0, 0.5, 0)
    TabsCover.Size = UDim2.new(0, 5, 1, 0)
    
    local TabsContainer = Instance.new("Frame")
    TabsContainer.Name = "TabsContainer"
    TabsContainer.Parent = Tabs
    TabsContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabsContainer.BackgroundTransparency = 1.000
    TabsContainer.Size = UDim2.new(1, 0, 1, 0)
    
    local TabsList = Instance.new("UIListLayout")
    TabsList.Name = "TabsList"
    TabsList.Parent = TabsContainer
    TabsList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabsList.SortOrder = Enum.SortOrder.LayoutOrder
    TabsList.Padding = UDim.new(0, 5)
    
    local TabsPadding = Instance.new("UIPadding")
    TabsPadding.Parent = TabsContainer
    TabsPadding.PaddingTop = UDim.new(0, 5)
    
    -- Pages Container
    local Pages = Instance.new("Frame")
    Pages.Name = "Pages"
    Pages.Parent = Main
    Pages.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Pages.BorderSizePixel = 0
    Pages.Position = UDim2.new(0, 130, 0, 42)
    Pages.Size = UDim2.new(1, -138, 1, -50)
    
    local PagesCorner = Instance.new("UICorner")
    PagesCorner.CornerRadius = UDim.new(0, 6)
    PagesCorner.Parent = Pages
    
    -- Resize Button
    local Resize = Instance.new("ImageButton")
    Resize.Name = "Resize"
    Resize.Parent = Main
    Resize.AnchorPoint = Vector2.new(1, 1)
    Resize.BackgroundTransparency = 1.000
    Resize.Position = UDim2.new(1, -4, 1, -4)
    Resize.Size = UDim2.new(0, 16, 0, 16)
    Resize.ZIndex = 2
    Resize.Image = "rbxassetid://3926307971"
    Resize.ImageColor3 = Color3.fromRGB(186, 13, 68)
    Resize.ImageRectOffset = Vector2.new(204, 364)
    Resize.ImageRectSize = Vector2.new(36, 36)
    
    -- Resize functionality
    local resizing = false
    local resizeStart, startSize
    
    Resize.MouseButton1Down:Connect(function()
        resizing = true
        resizeStart = Vector2.new(Mouse.X, Mouse.Y)
        startSize = Main.Size
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = Vector2.new(input.Position.X - resizeStart.X, input.Position.Y - resizeStart.Y)
            Main.Size = UDim2.new(0, math.max(470, startSize.X.Offset + delta.X), 0, math.max(283, startSize.Y.Offset + delta.Y))
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)
    
    -- Tab functionality
    local TabFunctions = {}
    function TabFunctions:Tab(title)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = TabsContainer
        TabButton.BackgroundColor3 = Color3.fromRGB(232, 17, 85)
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, -12, 0, 30)
        TabButton.AutoButtonColor = false
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = title or 'Home'
        TabButton.TextColor3 = Color3.fromRGB(72,72,72)
        TabButton.TextSize = 14.000
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        -- Page
        local Page = Instance.new("ScrollingFrame")
        Page.Name = "Page"
        Page.Visible = false
        Page.Parent = Pages
        Page.Active = true
        Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Page.BackgroundTransparency = 1.000
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.CanvasPosition = Vector2.new(0, 0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Color3.fromRGB(255, 24, 101)
        
        local PageList = Instance.new("UIListLayout")
        PageList.Parent = Page
        PageList.HorizontalAlignment = Enum.HorizontalAlignment.Center
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 6)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 5)
        
        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y)
        end)
        
        -- Tab button functionality
        TabButton.MouseButton1Click:Connect(function()
            for _,v in next, Pages:GetChildren() do
                if v:IsA("ScrollingFrame") then
                    v.Visible = false
                end
            end
            Page.Visible = true
            
            for _,v in next, TabsContainer:GetChildren() do
                if v.Name == 'TabButton' then
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(v, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(72,72,72)}):Play()
                end
            end
            
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.6}):Play()
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        end)
        
        -- First tab should be selected by default
        if #TabsContainer:GetChildren() == 1 then
            Page.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.6}):Play()
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextColor3 = Color3.fromRGB(255,255,255)}):Play()
        end
        
        -- Element functions
        local Elements = {}
        
        -- Button
        function Elements:Button(text, callback)
            local Button = Instance.new("TextButton")
            Button.Name = "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(134, 10, 49)
            Button.BorderSizePixel = 0
            Button.Size = UDim2.new(1, -6, 0, 34)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.Gotham
            Button.Text = text or "Button"
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 14.000
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = Button
            
            Button.MouseEnter:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(160, 12, 59)}):Play()
            end)
            
            Button.MouseLeave:Connect(function()
                TweenService:Create(Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(134, 10, 49)}):Play()
            end)
            
            Button.MouseButton1Click:Connect(function()
                callback()
            end)
            
            -- Mobile support
            Button.TouchTap:Connect(function()
                callback()
            end)
        end
        
        -- Toggle
        function Elements:Toggle(text, default, callback)
            local Toggle = Instance.new("TextButton")
            Toggle.Name = "Toggle"
            Toggle.Parent = Page
            Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Toggle.BorderSizePixel = 0
            Toggle.Size = UDim2.new(1, -6, 0, 34)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = Toggle
            
            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Toggle
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 1, 0)
            Title.Font = Enum.Font.Gotham
            Title.Text = text or "Toggle"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.AnchorPoint = Vector2.new(1, 0.5)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(161, 12, 59)
            ToggleFrame.BackgroundTransparency = 1.000
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Position = UDim2.new(1, -8, 0.5, 0)
            ToggleFrame.Size = UDim2.new(0, 14, 0, 14)
            
            local ToggleCorner2 = Instance.new("UICorner")
            ToggleCorner2.CornerRadius = UDim.new(0, 3)
            ToggleCorner2.Parent = ToggleFrame
            
            local Check = Instance.new("ImageLabel")
            Check.Name = "Check"
            Check.Parent = ToggleFrame
            Check.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Check.BackgroundTransparency = 1.000
            Check.Position = UDim2.new(-0.214285731, 0, -0.214285731, 0)
            Check.Size = UDim2.new(0, 20, 0, 20)
            Check.Image = "http://www.roblox.com/asset/?id=7812909048"
            Check.ImageTransparency = 1
            Check.ScaleType = Enum.ScaleType.Fit
            
            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Parent = ToggleFrame
            ToggleStroke.LineJoinMode = Enum.LineJoinMode.Round
            ToggleStroke.Thickness = 2
            ToggleStroke.Color = Color3.fromRGB(161, 12, 59)
            
            local toggled = default or false
            
            if toggled then
                TweenService:Create(ToggleFrame, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                TweenService:Create(Check, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
            end
            
            Toggle.MouseEnter:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            end)
            
            Toggle.MouseLeave:Connect(function()
                TweenService:Create(Toggle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
            end)
            
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                
                if toggled then
                    TweenService:Create(ToggleFrame, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Check, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                else
                    TweenService:Create(ToggleFrame, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(Check, TweenInfo.new(.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1}):Play()
                end
                
                callback(toggled)
            end)
            
            -- Mobile support
            Toggle.TouchTap:Connect(function()
                Toggle.MouseButton1Click:Fire()
            end)
        end
        
        -- Label
        function Elements:Label(text)
            local Label = Instance.new("TextLabel")
            Label.Parent = Page
            Label.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Label.BorderSizePixel = 0
            Label.Size = UDim2.new(1, -6, 0, 34)
            Label.Font = Enum.Font.Gotham
            Label.Text = "  " .. (text or "Label")
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 14.000
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local LabelCorner = Instance.new("UICorner")
            LabelCorner.CornerRadius = UDim.new(0, 6)
            LabelCorner.Parent = Label
        end
        
        -- Slider
        function Elements:Slider(text, min, max, default, callback)
            local Slider = Instance.new("Frame")
            Slider.Name = "Slider"
            Slider.Parent = Page
            Slider.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Slider.Size = UDim2.new(1, -6, 0, 48)
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 6)
            SliderCorner.Parent = Slider
            
            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Slider
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 0, 34)
            Title.Font = Enum.Font.Gotham
            Title.Text = text or "Slider"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local Value = Instance.new("TextLabel")
            Value.Name = "Value"
            Value.Parent = Slider
            Value.AnchorPoint = Vector2.new(1, 0)
            Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Value.BackgroundTransparency = 1.000
            Value.Position = UDim2.new(1, -10, 0, 0)
            Value.Size = UDim2.new(1, 0, 0, 34)
            Value.Font = Enum.Font.Gotham
            Value.Text = tostring(default)
            Value.TextColor3 = Color3.fromRGB(255, 255, 255)
            Value.TextSize = 14.000
            Value.TextXAlignment = Enum.TextXAlignment.Right
            
            local SliderClick = Instance.new("TextButton")
            SliderClick.Name = "SliderClick"
            SliderClick.Parent = Slider
            SliderClick.AnchorPoint = Vector2.new(0.5, 1)
            SliderClick.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
            SliderClick.Position = UDim2.new(0.5, 0, 1, -8)
            SliderClick.Size = UDim2.new(1, -12, 0, 6)
            SliderClick.AutoButtonColor = false
            SliderClick.Text = ''
            
            local SliderClickCorner = Instance.new("UICorner")
            SliderClickCorner.CornerRadius = UDim.new(0, 6)
            SliderClickCorner.Parent = SliderClick
            
            local SliderDrag = Instance.new("Frame")
            SliderDrag.Name = "SliderDrag"
            SliderDrag.Parent = SliderClick
            SliderDrag.BackgroundColor3 = Color3.fromRGB(188, 14, 69)
            SliderDrag.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            
            local SliderDragCorner = Instance.new("UICorner")
            SliderDragCorner.CornerRadius = UDim.new(0, 6)
            SliderDragCorner.Parent = SliderDrag
            
            local dragging = false
            
            local function slide(input)
                local pos = UDim2.new(
                    math.clamp((input.Position.X - SliderClick.AbsolutePosition.X) / SliderClick.AbsoluteSize.X, 0, 1),
                    0, 0, 6
                )
                SliderDrag:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                local value = math.floor(min + (pos.X.Scale * (max - min)))
                Value.Text = tostring(value)
                callback(value)
            end
            
            SliderClick.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    slide(input)
                    dragging = true
                end
            end)
            
            SliderClick.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    slide(input)
                end
            end)
        end
        
        -- Keybind
        function Elements:Keybind(text, defaultKey, callback)
            local Keybind = Instance.new("TextButton")
            Keybind.Name = "Keybind"
            Keybind.Parent = Page
            Keybind.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Keybind.Size = UDim2.new(1, -6, 0, 34)
            Keybind.AutoButtonColor = false
            Keybind.Font = Enum.Font.SourceSans
            Keybind.Text = ""
            Keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Keybind.TextSize = 14.000
            
            local KeybindCorner = Instance.new("UICorner")
            KeybindCorner.CornerRadius = UDim.new(0, 6)
            KeybindCorner.Parent = Keybind
            
            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Keybind
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 1, 0)
            Title.Font = Enum.Font.Gotham
            Title.Text = text or "Keybind"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local CurrentKey = Instance.new("TextLabel")
            CurrentKey.Name = "CurrentKey"
            CurrentKey.Parent = Keybind
            CurrentKey.AnchorPoint = Vector2.new(1, 0.5)
            CurrentKey.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
            CurrentKey.Position = UDim2.new(1, -6, 0.5, 0)
            CurrentKey.Size = UDim2.new(-0, 46, 0, 24)
            CurrentKey.Font = Enum.Font.Gotham
            CurrentKey.Text = defaultKey.Name or ". . ."
            CurrentKey.TextColor3 = Color3.fromRGB(255, 255, 255)
            CurrentKey.TextSize = 14.000
            
            local CurrentKeyCorner = Instance.new("UICorner")
            CurrentKeyCorner.CornerRadius = UDim.new(0, 4)
            CurrentKeyCorner.Parent = CurrentKey
            
            local binding = false
            local key = defaultKey
            
            Keybind.MouseButton1Click:Connect(function()
                binding = true
                CurrentKey.Text = ". . ."
                
                local input
                input = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        key = input.KeyCode
                        CurrentKey.Text = key.Name
                        binding = false
                        input:Disconnect()
                    end
                end)
            end)
            
            UserInputService.InputBegan:Connect(function(input, gameProcessed)
                if not gameProcessed and input.KeyCode == key then
                    callback(key)
                end
            end)
            
            -- Mobile support
            Keybind.TouchTap:Connect(function()
                Keybind.MouseButton1Click:Fire()
            end)
        end
        
        -- Dropdown
        function Elements:Dropdown(text, options, callback, multiSelect)
            multiSelect = multiSelect or false
            options = options or {}
            callback = callback or function() end
            
            local Dropdown = Instance.new("Frame")
            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Page
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.BorderSizePixel = 0
            Dropdown.ClipsDescendants = true
            Dropdown.Size = UDim2.new(1, -6, 0, 34)
            
            local DropdownList = Instance.new("UIListLayout")
            DropdownList.Parent = Dropdown
            DropdownList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            DropdownList.SortOrder = Enum.SortOrder.LayoutOrder
            DropdownList.Padding = UDim.new(0, 5)
            
            local Choose = Instance.new("Frame")
            Choose.Name = "Choose"
            Choose.Parent = Dropdown
            Choose.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            Choose.BorderSizePixel = 0
            Choose.Size = UDim2.new(1, 0, 0, 34)
            
            local ChooseCorner = Instance.new("UICorner")
            ChooseCorner.CornerRadius = UDim.new(0, 6)
            ChooseCorner.Parent = Choose
            
            local Title = Instance.new("TextLabel")
            Title.Name = "Title"
            Title.Parent = Choose
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0, 8, 0, 0)
            Title.Size = UDim2.new(1, -6, 1, 0)
            Title.Font = Enum.Font.Gotham
            Title.Text = text or "Dropdown"
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local Arrow = Instance.new("ImageButton")
            Arrow.Name = "Arrow"
            Arrow.Parent = Choose
            Arrow.AnchorPoint = Vector2.new(1, 0.5)
            Arrow.BackgroundTransparency = 1.000
            Arrow.LayoutOrder = 10
            Arrow.Position = UDim2.new(1, -2, 0.5, 0)
            Arrow.Size = UDim2.new(0, 28, 0, 28)
            Arrow.ZIndex = 2
            Arrow.Image = "rbxassetid://3926307971"
            Arrow.ImageColor3 = Color3.fromRGB(161, 12, 59)
            Arrow.ImageRectOffset = Vector2.new(324, 524)
            Arrow.ImageRectSize = Vector2.new(36, 36)
            Arrow.ScaleType = Enum.ScaleType.Crop
            
            local OptionHolder = Instance.new("Frame")
            OptionHolder.Name = "OptionHolder"
            OptionHolder.Parent = Dropdown
            OptionHolder.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            OptionHolder.BorderSizePixel = 0
            OptionHolder.Position = UDim2.new(0, 0, 0, 34)
            OptionHolder.Size = UDim2.new(1, 0, 0, 0)
            
            local OptionHolderCorner = Instance.new("UICorner")
            OptionHolderCorner.CornerRadius = UDim.new(0, 6)
            OptionHolderCorner.Parent = OptionHolder
            
            local OptionList = Instance.new("UIListLayout")
            OptionList.Name = "OptionList"
            OptionList.Parent = OptionHolder
            OptionList.HorizontalAlignment = Enum.HorizontalAlignment.Center
            OptionList.SortOrder = Enum.SortOrder.LayoutOrder
            OptionList.Padding = UDim.new(0, 5)
            
            local OptionPadding = Instance.new("UIPadding")
            OptionPadding.Parent = OptionHolder
            OptionPadding.PaddingTop = UDim.new(0, 8)
            
            local dropped = false
            local selected = {}
            
            local function updateTitle()
                if multiSelect then
                    local selectedList = {}
                    for item, _ in pairs(selected) do
                        table.insert(selectedList, item)
                    end
                    
                    if #selectedList > 0 then
                        if #selectedList <= 3 then
                            Title.Text = text .. ": " .. table.concat(selectedList, ", ")
                        else
                            Title.Text = text .. ": " .. #selectedList .. " selected"
                        end
                    else
                        Title.Text = text
                    end
                end
            end
            
            -- Create options
            for i, option in ipairs(options) do
                local Option = Instance.new("TextButton")
                Option.Name = "Option"
                Option.Parent = OptionHolder
                Option.BackgroundColor3 = Color3.fromRGB(134, 10, 49)
                Option.BorderSizePixel = 0
                Option.Size = UDim2.new(1, -16, 0, 30)
                Option.AutoButtonColor = false
                Option.Font = Enum.Font.Gotham
                Option.Text = option
                Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                Option.TextSize = 14.000
                
                local OptionCorner = Instance.new("UICorner")
                OptionCorner.CornerRadius = UDim.new(0, 6)
                OptionCorner.Parent = Option
                
                -- Add checkmark for multi-select
                if multiSelect then
                    local Checkmark = Instance.new("ImageLabel")
                    Checkmark.Name = "Checkmark"
                    Checkmark.Parent = Option
                    Checkmark.BackgroundTransparency = 1
                    Checkmark.Image = "rbxassetid://6031068421"
                    Checkmark.ImageTransparency = 1
                    Checkmark.Size = UDim2.new(0, 16, 0, 16)
                    Checkmark.Position = UDim2.new(0, 8, 0.5, -8)
                end
                
                Option.MouseButton1Click:Connect(function()
                    if multiSelect then
                        -- Toggle selection
                        if selected[option] then
                            selected[option] = nil
                            Option.Checkmark.ImageTransparency = 1
                        else
                            selected[option] = true
                            Option.Checkmark.ImageTransparency = 0
                        end
                        
                        updateTitle()
                        
                        -- Pass selected items to callback
                        local selectedList = {}
                        for item, _ in pairs(selected) do
                            table.insert(selectedList, item)
                        end
                        callback(selectedList)
                    else
                        -- Single select
                        callback(option)
                        Title.Text = text .. ": " .. option
                        dropped = false
                        TweenService:Create(Arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
                    end
                end)
                
                -- Mobile support
                Option.TouchTap:Connect(function()
                    Option.MouseButton1Click:Fire()
                end)
            end
            
            -- Update option holder size
            OptionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                if dropped then
                    OptionHolder.Size = UDim2.new(1, 0, 0, OptionList.AbsoluteContentSize.Y + 15)
                end
            end)
            
            -- Toggle dropdown
            Choose.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dropped = not dropped
                    
                    if dropped then
                        Dropdown:TweenSize(UDim2.new(1, -6, 0, 34 + OptionList.AbsoluteContentSize.Y + 15), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .15, true)
                        TweenService:Create(Arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 180}):Play()
                    else
                        TweenService:Create(Arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                        Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, .15, true)
                    end
                end
            end)
            
            -- Mobile support
            Choose.TouchTap:Connect(function()
                Choose.InputBegan:Fire(UserInputService.CreateInputEvent(
                    Enum.UserInputType.MouseButton1,
                    Enum.UserInputState.Begin,
                    0,
                    Vector2.new(0, 0)
                ))
            end)
            
            -- Dropdown functions
            local DropdownFunctions = {}
            
            function DropdownFunctions:Refresh(newOptions)
                newOptions = newOptions or {}
                selected = {}
                dropped = false
                
                TweenService:Create(Arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
                
                -- Clear existing options
                for _, child in ipairs(OptionHolder:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                -- Create new options
                for i, option in ipairs(newOptions) do
                    local Option = Instance.new("TextButton")
                    Option.Name = "Option"
                    Option.Parent = OptionHolder
                    Option.BackgroundColor3 = Color3.fromRGB(134, 10, 49)
                    Option.BorderSizePixel = 0
                    Option.Size = UDim2.new(1, -16, 0, 30)
                    Option.AutoButtonColor = false
                    Option.Font = Enum.Font.Gotham
                    Option.Text = option
                    Option.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Option.TextSize = 14.000
                    
                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 6)
                    OptionCorner.Parent = Option
                    
                    -- Add checkmark for multi-select
                    if multiSelect then
                        local Checkmark = Instance.new("ImageLabel")
                        Checkmark.Name = "Checkmark"
                        Checkmark.Parent = Option
                        Checkmark.BackgroundTransparency = 1
                        Checkmark.Image = "rbxassetid://6031068421"
                        Checkmark.ImageTransparency = 1
                        Checkmark.Size = UDim2.new(0, 16, 0, 16)
                        Checkmark.Position = UDim2.new(0, 8, 0.5, -8)
                    end
                    
                    Option.MouseButton1Click:Connect(function()
                        if multiSelect then
                            if selected[option] then
                                selected[option] = nil
                                Option.Checkmark.ImageTransparency = 1
                            else
                                selected[option] = true
                                Option.Checkmark.ImageTransparency = 0
                            end
                            
                            updateTitle()
                            
                            local selectedList = {}
                            for item, _ in pairs(selected) do
                                table.insert(selectedList, item)
                            end
                            callback(selectedList)
                        else
                            callback(option)
                            Title.Text = text .. ": " .. option
                            dropped = false
                            TweenService:Create(Arrow, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = 0}):Play()
                            Dropdown:TweenSize(UDim2.new(1, -6, 0, 34), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .15, true)
                        end
                    end)
                    
                    -- Mobile support
                    Option.TouchTap:Connect(function()
                        Option.MouseButton1Click:Fire()
                    end)
                end
                
                -- Update option holder size
                OptionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    if dropped then
                        OptionHolder.Size = UDim2.new(1, 0, 0, OptionList.AbsoluteContentSize.Y + 15)
                    end
                end)
            end
            
            return DropdownFunctions
        end
        
        return Elements
    end
    
    return TabFunctions
end

return Library
