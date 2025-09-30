local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Create GUI
local GUI = Instance.new("ScreenGui")
GUI.Name = "FluentLib_" .. math.random(1000,9999)
GUI.ResetOnSpawn = false

-- Protection
if gethui then
    GUI.Parent = gethui()
elseif syn and syn.protect_gui then
    syn.protect_gui(GUI)
    GUI.Parent = game:GetService("CoreGui")
elseif protectgui then 
    protectgui(GUI)
    GUI.Parent = game:GetService("CoreGui")
else
    GUI.Parent = game:GetService("CoreGui")
end

-- Multiple Themes
local Themes = {
    Dark = {
        Background = Color3.fromRGB(20, 20, 20),
        Element = Color3.fromRGB(35, 35, 35),
        ElementBorder = Color3.fromRGB(55, 55, 55),
        Text = Color3.fromRGB(240, 240, 240),
        SubText = Color3.fromRGB(180, 180, 180),
        Accent = Color3.fromRGB(100, 150, 255),
        Hover = Color3.fromRGB(45, 45, 45),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Ocean = {
        Background = Color3.fromRGB(15, 23, 42),
        Element = Color3.fromRGB(30, 41, 59),
        ElementBorder = Color3.fromRGB(51, 65, 85),
        Text = Color3.fromRGB(226, 232, 240),
        SubText = Color3.fromRGB(148, 163, 184),
        Accent = Color3.fromRGB(14, 165, 233),
        Hover = Color3.fromRGB(51, 65, 85),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Sunset = {
        Background = Color3.fromRGB(30, 15, 25),
        Element = Color3.fromRGB(50, 25, 40),
        ElementBorder = Color3.fromRGB(80, 40, 60),
        Text = Color3.fromRGB(255, 240, 245),
        SubText = Color3.fromRGB(220, 180, 200),
        Accent = Color3.fromRGB(255, 105, 180),
        Hover = Color3.fromRGB(70, 35, 55),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Forest = {
        Background = Color3.fromRGB(18, 28, 20),
        Element = Color3.fromRGB(28, 42, 32),
        ElementBorder = Color3.fromRGB(45, 65, 50),
        Text = Color3.fromRGB(230, 245, 235),
        SubText = Color3.fromRGB(180, 200, 185),
        Accent = Color3.fromRGB(52, 211, 153),
        Hover = Color3.fromRGB(38, 55, 42),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Purple = {
        Background = Color3.fromRGB(25, 15, 40),
        Element = Color3.fromRGB(40, 25, 60),
        ElementBorder = Color3.fromRGB(60, 40, 90),
        Text = Color3.fromRGB(245, 240, 255),
        SubText = Color3.fromRGB(200, 180, 220),
        Accent = Color3.fromRGB(168, 85, 247),
        Hover = Color3.fromRGB(55, 35, 75),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Crimson = {
        Background = Color3.fromRGB(25, 10, 10),
        Element = Color3.fromRGB(40, 15, 15),
        ElementBorder = Color3.fromRGB(70, 25, 25),
        Text = Color3.fromRGB(255, 240, 240),
        SubText = Color3.fromRGB(220, 180, 180),
        Accent = Color3.fromRGB(239, 68, 68),
        Hover = Color3.fromRGB(55, 20, 20),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Cyber = {
        Background = Color3.fromRGB(10, 15, 25),
        Element = Color3.fromRGB(15, 25, 40),
        ElementBorder = Color3.fromRGB(30, 45, 70),
        Text = Color3.fromRGB(0, 255, 255),
        SubText = Color3.fromRGB(100, 200, 220),
        Accent = Color3.fromRGB(0, 255, 200),
        Hover = Color3.fromRGB(20, 35, 55),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Amber = {
        Background = Color3.fromRGB(30, 25, 15),
        Element = Color3.fromRGB(45, 38, 22),
        ElementBorder = Color3.fromRGB(70, 60, 35),
        Text = Color3.fromRGB(255, 250, 230),
        SubText = Color3.fromRGB(220, 200, 160),
        Accent = Color3.fromRGB(251, 191, 36),
        Hover = Color3.fromRGB(60, 50, 30),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Mint = {
        Background = Color3.fromRGB(15, 28, 25),
        Element = Color3.fromRGB(22, 40, 35),
        ElementBorder = Color3.fromRGB(35, 60, 52),
        Text = Color3.fromRGB(240, 255, 250),
        SubText = Color3.fromRGB(180, 220, 210),
        Accent = Color3.fromRGB(16, 185, 129),
        Hover = Color3.fromRGB(30, 50, 45),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Rose = {
        Background = Color3.fromRGB(30, 18, 22),
        Element = Color3.fromRGB(45, 28, 35),
        ElementBorder = Color3.fromRGB(70, 45, 55),
        Text = Color3.fromRGB(255, 245, 248),
        SubText = Color3.fromRGB(230, 200, 210),
        Accent = Color3.fromRGB(244, 114, 182),
        Hover = Color3.fromRGB(60, 38, 48),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Arctic = {
        Background = Color3.fromRGB(18, 25, 30),
        Element = Color3.fromRGB(28, 38, 45),
        ElementBorder = Color3.fromRGB(45, 60, 70),
        Text = Color3.fromRGB(240, 250, 255),
        SubText = Color3.fromRGB(180, 210, 225),
        Accent = Color3.fromRGB(125, 211, 252),
        Hover = Color3.fromRGB(38, 50, 58),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Midnight = {
        Background = Color3.fromRGB(12, 12, 20),
        Element = Color3.fromRGB(20, 20, 35),
        ElementBorder = Color3.fromRGB(35, 35, 55),
        Text = Color3.fromRGB(230, 230, 255),
        SubText = Color3.fromRGB(160, 160, 200),
        Accent = Color3.fromRGB(99, 102, 241),
        Hover = Color3.fromRGB(28, 28, 45),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Volcano = {
        Background = Color3.fromRGB(28, 15, 12),
        Element = Color3.fromRGB(42, 22, 18),
        ElementBorder = Color3.fromRGB(65, 35, 28),
        Text = Color3.fromRGB(255, 245, 240),
        SubText = Color3.fromRGB(230, 200, 190),
        Accent = Color3.fromRGB(249, 115, 22),
        Hover = Color3.fromRGB(55, 30, 24),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Neon = {
        Background = Color3.fromRGB(15, 15, 15),
        Element = Color3.fromRGB(25, 25, 25),
        ElementBorder = Color3.fromRGB(45, 45, 45),
        Text = Color3.fromRGB(255, 50, 255),
        SubText = Color3.fromRGB(200, 100, 220),
        Accent = Color3.fromRGB(0, 255, 150),
        Hover = Color3.fromRGB(35, 35, 35),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Slate = {
        Background = Color3.fromRGB(15, 18, 22),
        Element = Color3.fromRGB(30, 35, 42),
        ElementBorder = Color3.fromRGB(51, 58, 68),
        Text = Color3.fromRGB(241, 245, 249),
        SubText = Color3.fromRGB(148, 163, 184),
        Accent = Color3.fromRGB(71, 85, 105),
        Hover = Color3.fromRGB(45, 52, 62),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Cherry = {
        Background = Color3.fromRGB(28, 12, 18),
        Element = Color3.fromRGB(42, 18, 28),
        ElementBorder = Color3.fromRGB(65, 30, 45),
        Text = Color3.fromRGB(255, 240, 245),
        SubText = Color3.fromRGB(230, 190, 210),
        Accent = Color3.fromRGB(236, 72, 153),
        Hover = Color3.fromRGB(55, 24, 38),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Emerald = {
        Background = Color3.fromRGB(12, 25, 18),
        Element = Color3.fromRGB(18, 38, 28),
        ElementBorder = Color3.fromRGB(30, 60, 45),
        Text = Color3.fromRGB(240, 255, 248),
        SubText = Color3.fromRGB(180, 220, 200),
        Accent = Color3.fromRGB(16, 185, 129),
        Hover = Color3.fromRGB(24, 48, 36),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    },
    Monochrome = {
        Background = Color3.fromRGB(25, 25, 25),
        Element = Color3.fromRGB(40, 40, 40),
        ElementBorder = Color3.fromRGB(60, 60, 60),
        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(180, 180, 180),
        Accent = Color3.fromRGB(200, 200, 200),
        Hover = Color3.fromRGB(50, 50, 50),
        BackgroundTransparency = 0.1,
        ElementTransparency = 0.2
    }
}

-- Set default theme
local Theme = Themes.Dark

-- Library
local Library = {
    GUI = GUI,
    Connections = {},
    Windows = {},
    Options = {},
    KeySystemEnabled = true, -- New key system toggle
    NotificationsEnabled = true -- New notifications toggle
}

function Library:Round(Number, Factor)
    local Result = math.floor(Number/Factor + 0.5) * Factor
    return Factor == 1 and math.floor(Result) or Result
end

function Library:Tween(obj, props, time)
    time = time or 0.2
    local tween = TweenService:Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad), props)
    tween:Play()
    return tween
end

function Library:Connect(signal, callback)
    local connection = signal:Connect(callback)
    table.insert(self.Connections, connection)
    return connection
end

function Library:SafeCallback(callback, ...)
    if callback then
        local success, err = pcall(callback, ...)
        if not success then
            warn("Callback error:", err)
        end
    end
end

-- New notification system with vibrate
function Library:Notify(config)
    if not self.NotificationsEnabled then return end
    
    local title = config.Title or "Notification"
    local content = config.Content or ""
    local duration = config.Duration or 3
    local vibrate = config.Vibrate ~= false -- Default true
    
    -- Create notification frame
    local NotifFrame = Instance.new("Frame")
    NotifFrame.Size = UDim2.fromOffset(300, 80)
    NotifFrame.Position = UDim2.new(1, -320, 0, 20)
    NotifFrame.BackgroundColor3 = Theme.Background
    NotifFrame.BackgroundTransparency = 0.1
    NotifFrame.BorderSizePixel = 0
    NotifFrame.Parent = GUI
    NotifFrame.ZIndex = 1000
    
    local NotifCorner = Instance.new("UICorner")
    NotifCorner.CornerRadius = UDim.new(0, 12)
    NotifCorner.Parent = NotifFrame
    
    local NotifStroke = Instance.new("UIStroke")
    NotifStroke.Color = Theme.Accent
    NotifStroke.Thickness = 2
    NotifStroke.Transparency = 0.3
    NotifStroke.Parent = NotifFrame
    
    -- Title
    local NotifTitle = Instance.new("TextLabel")
    NotifTitle.Text = title
    NotifTitle.Font = Enum.Font.GothamBold
    NotifTitle.TextSize = 14
    NotifTitle.TextColor3 = Theme.Text
    NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
    NotifTitle.Size = UDim2.new(1, -20, 0, 20)
    NotifTitle.Position = UDim2.fromOffset(10, 10)
    NotifTitle.BackgroundTransparency = 1
    NotifTitle.Parent = NotifFrame
    
    -- Content
    local NotifContent = Instance.new("TextLabel")
    NotifContent.Text = content
    NotifContent.Font = Enum.Font.Gotham
    NotifContent.TextSize = 12
    NotifContent.TextColor3 = Theme.SubText
    NotifContent.TextXAlignment = Enum.TextXAlignment.Left
    NotifContent.TextYAlignment = Enum.TextYAlignment.Top
    NotifContent.Size = UDim2.new(1, -20, 0, 40)
    NotifContent.Position = UDim2.fromOffset(10, 35)
    NotifContent.BackgroundTransparency = 1
    NotifContent.TextWrapped = true
    NotifContent.Parent = NotifFrame
    
    -- Slide in animation
    NotifFrame:TweenPosition(UDim2.new(1, -320, 0, 20), "Out", "Quint", 0.5, true)
    
    -- Vibrate effect (simulate with quick position changes)
    if vibrate then
        spawn(function()
            for i = 1, 5 do
                NotifFrame.Position = NotifFrame.Position + UDim2.fromOffset(math.random(-2, 2), 0)
                wait(0.05)
                NotifFrame.Position = NotifFrame.Position - UDim2.fromOffset(math.random(-2, 2), 0)
                wait(0.05)
            end
        end)
    end
    
    -- Auto dismiss
    spawn(function()
        wait(duration)
        NotifFrame:TweenPosition(UDim2.new(1, 20, 0, 20), "In", "Quint", 0.5, true)
        wait(0.5)
        NotifFrame:Destroy()
    end)
    
    return NotifFrame
end

function Library:ToggleKeySystem(enabled)
    self.KeySystemEnabled = enabled
    Library:Notify({
        Title = "Key System",
        Content = enabled and "Key system enabled" or "Key system disabled",
        Vibrate = true
    })
end

function Library:ToggleNotifications(enabled)
    self.NotificationsEnabled = enabled
    if enabled then
        Library:Notify({
            Title = "Notifications",
            Content = "Notifications enabled",
            Vibrate = true
        })
    end
end

function Library:Destroy()
    for _, connection in pairs(self.Connections) do
        if connection then connection:Disconnect() end
    end
    if self.GUI then
        self.GUI:Destroy()
    end
end

-- Mobile + PC Drag Handler
local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    local function startDrag(input)
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end

    local function updateDrag(input)
        if dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end

    local function endDrag()
        dragging = false
    end

    -- Mouse support
    Library:Connect(dragHandle.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            startDrag(input)
        end
    end)

    -- Touch support
    Library:Connect(dragHandle.InputBegan, function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
        end
    end)

    -- Movement tracking
    Library:Connect(UserInputService.InputChanged, function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            updateDrag(input)
        end
    end)

    -- End tracking
    Library:Connect(UserInputService.InputEnded, function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            endDrag()
        end
    end)
end

function Library:CreateWindow(config)
    local Window = {}
    
    -- Main frame with transparency
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Size = config.Size or UDim2.fromOffset(500, 400)
    Main.Position = UDim2.fromScale(0.5, 0.5)
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Theme.Background
    Main.BackgroundTransparency = Theme.BackgroundTransparency
    Main.BorderSizePixel = 0
    Main.Parent = GUI
    
    -- Corner
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Main
    
    -- Stroke
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.ElementBorder
    Stroke.Thickness = 1
    Stroke.Transparency = 0.3
    Stroke.Parent = Main
    
    -- Title bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 45)
    TitleBar.BackgroundTransparency = 1
    TitleBar.Parent = Main
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Text = config.Title or "Window"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextColor3 = Theme.Text
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.fromOffset(20, 0)
    Title.BackgroundTransparency = 1
    Title.Parent = TitleBar
    
    -- Close button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "Close"
    CloseBtn.Size = UDim2.fromOffset(32, 32)
    CloseBtn.Position = UDim2.new(1, -40, 0, 6)
    CloseBtn.BackgroundColor3 = Theme.Element
    CloseBtn.BackgroundTransparency = Theme.ElementTransparency
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 20
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Parent = TitleBar
    
    local CloseBtnCorner = Instance.new("UICorner")
    CloseBtnCorner.CornerRadius = UDim.new(0, 8)
    CloseBtnCorner.Parent = CloseBtn
    
    -- Squircle button at top of screen (hidden initially)
    local SquircleBtn = Instance.new("TextButton")
    SquircleBtn.Name = "SquircleOpen"
    SquircleBtn.Size = UDim2.fromOffset(100, 30)
    SquircleBtn.Position = UDim2.new(0.5, -50, 0, 10)
    SquircleBtn.BackgroundColor3 = Theme.Background
    SquircleBtn.BackgroundTransparency = Theme.BackgroundTransparency
    SquircleBtn.Text = "Open"
    SquircleBtn.TextColor3 = Theme.Text
    SquircleBtn.TextSize = 14
    SquircleBtn.Font = Enum.Font.GothamMedium
    SquircleBtn.BorderSizePixel = 0
    SquircleBtn.Visible = false
    SquircleBtn.Parent = GUI

    local SquircleCorner = Instance.new("UICorner")
    SquircleCorner.CornerRadius = UDim.new(0, 15)
    SquircleCorner.Parent = SquircleBtn

    -- Close functionality (now minimizes to squircle)
    Library:Connect(CloseBtn.MouseButton1Click, function()
        Main.Visible = false
        SquircleBtn.Visible = true
    end)

    -- Squircle click to restore window
    Library:Connect(SquircleBtn.MouseButton1Click, function()
        SquircleBtn.Visible = false
        Main.Visible = true
    end)
    
    -- Make draggable (Mobile + PC)
    MakeDraggable(Main, TitleBar)
    
    -- SCROLLABLE TAB CONTAINER
    local TabScrollFrame = Instance.new("ScrollingFrame")
    TabScrollFrame.Name = "TabScrollFrame"
    TabScrollFrame.Size = UDim2.new(0, 160, 1, -110) -- Made room for profile section
    TabScrollFrame.Position = UDim2.fromOffset(10, 50)
    TabScrollFrame.BackgroundTransparency = 1
    TabScrollFrame.ScrollBarThickness = 4
    TabScrollFrame.ScrollBarImageColor3 = Theme.Accent
    TabScrollFrame.ScrollBarImageTransparency = 0.5
    TabScrollFrame.CanvasSize = UDim2.fromScale(0, 0)
    TabScrollFrame.BorderSizePixel = 0
    TabScrollFrame.Parent = Main
    
    local TabList = Instance.new("UIListLayout")
    TabList.Padding = UDim.new(0, 6)
    TabList.Parent = TabScrollFrame
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.PaddingTop = UDim.new(0, 5)
    TabPadding.PaddingBottom = UDim.new(0, 5)
    TabPadding.PaddingLeft = UDim.new(0, 5)
    TabPadding.PaddingRight = UDim.new(0, 5)
    TabPadding.Parent = TabScrollFrame
    
    -- Auto resize tab scroll frame
    Library:Connect(TabList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        TabScrollFrame.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 20)
    end)
    
    -- PROFILE SECTION AT BOTTOM
    local ProfileSection = Instance.new("Frame")
    ProfileSection.Name = "ProfileSection"
    ProfileSection.Size = UDim2.new(0, 160, 0, 50)
    ProfileSection.Position = UDim2.fromOffset(10, Main.Size.Y.Offset - 60)
    ProfileSection.BackgroundColor3 = Theme.Element
    ProfileSection.BackgroundTransparency = Theme.ElementTransparency
    ProfileSection.BorderSizePixel = 0
    ProfileSection.Parent = Main
    
    local ProfileCorner = Instance.new("UICorner")
    ProfileCorner.CornerRadius = UDim.new(0, 8)
    ProfileCorner.Parent = ProfileSection
    
    local ProfileStroke = Instance.new("UIStroke")
    ProfileStroke.Color = Theme.ElementBorder
    ProfileStroke.Transparency = 0.6
    ProfileStroke.Parent = ProfileSection
    
    -- Avatar
    local Avatar = Instance.new("ImageLabel")
    Avatar.Size = UDim2.fromOffset(32, 32)
    Avatar.Position = UDim2.fromOffset(9, 9)
    Avatar.BackgroundColor3 = Theme.Background
    Avatar.BorderSizePixel = 0
    Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LocalPlayer.UserId .. "&width=150&height=150&format=png"
    Avatar.Parent = ProfileSection
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(0, 16)
    AvatarCorner.Parent = Avatar
    
    -- Player name
    local PlayerName = Instance.new("TextLabel")
    PlayerName.Text = LocalPlayer.DisplayName
    PlayerName.Font = Enum.Font.GothamMedium
    PlayerName.TextSize = 12
    PlayerName.TextColor3 = Theme.Text
    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
    PlayerName.Size = UDim2.new(1, -50, 0, 16)
    PlayerName.Position = UDim2.fromOffset(45, 12)
    PlayerName.BackgroundTransparency = 1
    PlayerName.Parent = ProfileSection
    
    -- Username
    local Username = Instance.new("TextLabel")
    Username.Text = "@" .. LocalPlayer.Name
    Username.Font = Enum.Font.Gotham
    Username.TextSize = 10
    Username.TextColor3 = Theme.SubText
    Username.TextXAlignment = Enum.TextXAlignment.Left
    Username.Size = UDim2.new(1, -50, 0, 14)
    Username.Position = UDim2.fromOffset(45, 26)
    Username.BackgroundTransparency = 1
    Username.Parent = ProfileSection
    
    -- Content area with transparency
    local ContentArea = Instance.new("Frame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -190, 1, -90)
    ContentArea.Position = UDim2.fromOffset(180, 70)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = Main
    
    -- Tab display
    local TabDisplay = Instance.new("TextLabel")
    TabDisplay.Name = "TabDisplay"
    TabDisplay.Text = "Tab"
    TabDisplay.Font = Enum.Font.GothamBold
    TabDisplay.TextSize = 20
    TabDisplay.TextColor3 = Theme.Text
    TabDisplay.TextXAlignment = Enum.TextXAlignment.Left
    TabDisplay.Size = UDim2.new(1, 0, 0, 25)
    TabDisplay.Position = UDim2.fromOffset(180, 50)
    TabDisplay.BackgroundTransparency = 1
    TabDisplay.Parent = Main
    
    Window.Main = Main
    Window.TabScrollFrame = TabScrollFrame
    Window.ContentArea = ContentArea
    Window.TabDisplay = TabDisplay
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.TabOrder = 0 -- Track tab creation order
    
    function Window:AddTab(config)
        local Tab = {}
        local TabName = config.Title or "Tab"
        Window.TabOrder = Window.TabOrder + 1
        local TabOrderNum = Window.TabOrder
        
        -- Tab button with transparency
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = TabName
        TabBtn.Size = UDim2.new(1, 0, 0, 38)
        TabBtn.BackgroundColor3 = Theme.Element
        TabBtn.BackgroundTransparency = Theme.ElementTransparency
        TabBtn.Text = TabName
        TabBtn.TextColor3 = Theme.Text
        TabBtn.TextSize = 13
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.BorderSizePixel = 0
        TabBtn.LayoutOrder = TabOrderNum -- Fix tab ordering
        TabBtn.Parent = self.TabScrollFrame
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 8)
        TabCorner.Parent = TabBtn
        
        local TabStroke = Instance.new("UIStroke")
        TabStroke.Color = Theme.ElementBorder
        TabStroke.Transparency = 0.6
        TabStroke.Parent = TabBtn
        
        -- Tab content with transparency
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = TabName .. "Content"
        TabContent.Size = UDim2.fromScale(1, 1)
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.ScrollBarThickness = 6
        TabContent.ScrollBarImageColor3 = Theme.Accent
        TabContent.ScrollBarImageTransparency = 0.3
        TabContent.CanvasSize = UDim2.fromScale(0, 0)
        TabContent.Visible = false
        TabContent.Parent = self.ContentArea
        
        local ContentList = Instance.new("UIListLayout")
        ContentList.Padding = UDim.new(0, 10)
        ContentList.Parent = TabContent
        
        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 12)
        ContentPadding.PaddingBottom = UDim.new(0, 12)
        ContentPadding.PaddingLeft = UDim.new(0, 12)
        ContentPadding.PaddingRight = UDim.new(0, 12)
        ContentPadding.Parent = TabContent
        
        -- Auto resize content
        Library:Connect(ContentList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, ContentList.AbsoluteContentSize.Y + 30)
        end)
        
        -- Tab click functionality
        Library:Connect(TabBtn.MouseButton1Click, function()
            -- Hide all tabs
            for _, tab in pairs(self.Tabs) do
                tab.Content.Visible = false
                tab.Button.BackgroundColor3 = Theme.Element
                tab.Button.BackgroundTransparency = Theme.ElementTransparency
            end
            
            -- Show this tab
            TabContent.Visible = true
            TabBtn.BackgroundColor3 = Theme.Hover
            TabBtn.BackgroundTransparency = 0.1
            self.TabDisplay.Text = TabName
            self.CurrentTab = Tab
            
            -- Notify tab switch
            Library:Notify({
                Title = "Tab Switch",
                Content = "Switched to " .. TabName,
                Duration = 1.5,
                Vibrate = true
            })
        end)
        
        -- Hover effects
        Library:Connect(TabBtn.MouseEnter, function()
            if self.CurrentTab ~= Tab then
                Library:Tween(TabBtn, {BackgroundTransparency = 0.1}, 0.15)
            end
        end)
        
        Library:Connect(TabBtn.MouseLeave, function()
            if self.CurrentTab ~= Tab then
                Library:Tween(TabBtn, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
            end
        end)
        
        Tab.Button = TabBtn
        Tab.Content = TabContent
        Tab.Name = TabName
        Tab.Container = TabContent
        Tab.Library = Library
        Tab.Order = TabOrderNum
        
        -- ADD KEYBIND FUNCTION TO TAB
        function Tab:AddKeybind(config)
            if not Library.KeySystemEnabled and config.RequireKeySystem ~= false then
                Library:Notify({
                    Title = "Key System Disabled",
                    Content = "Keybind '" .. (config.Title or "Unknown") .. "' is disabled",
                    Duration = 2,
                    Vibrate = true
                })
                return {
                    SetValue = function() end,
                    GetState = function() return false end,
                    OnClick = function() end,
                    OnChanged = function() end,
                    Destroy = function() end
                }
            end
            
            local Keybind = {}
            local Idx = config.Title or "Keybind_" .. math.random(1000, 9999)
            
            assert(config.Title, "Keybind - Missing Title")
            assert(config.Default, "Keybind - Missing default value.")
            config.Mode = config.Mode or "Toggle"
            config.Callback = config.Callback or function() end
            
            -- Keybind frame
            local KeybindFrame = Instance.new("Frame")
            KeybindFrame.Name = config.Title or "Keybind"
            KeybindFrame.Size = UDim2.new(1, 0, 0, config.Description and 70 or 50)
            KeybindFrame.BackgroundColor3 = Theme.Element
            KeybindFrame.BackgroundTransparency = Theme.ElementTransparency
            KeybindFrame.BorderSizePixel = 0
            KeybindFrame.Parent = TabContent
            
            local KeybindCorner = Instance.new("UICorner")
            KeybindCorner.CornerRadius = UDim.new(0, 8)
            KeybindCorner.Parent = KeybindFrame
            
            local KeybindStroke = Instance.new("UIStroke")
            KeybindStroke.Color = Theme.ElementBorder
            KeybindStroke.Transparency = 0.5
            KeybindStroke.Parent = KeybindFrame
            
            -- Title
            local KeybindTitle = Instance.new("TextLabel")
            KeybindTitle.Text = config.Title or "Keybind"
            KeybindTitle.Font = Enum.Font.GothamMedium
            KeybindTitle.TextSize = 14
            KeybindTitle.TextColor3 = Theme.Text
            KeybindTitle.TextXAlignment = Enum.TextXAlignment.Left
            KeybindTitle.Size = UDim2.new(1, -120, 0, 18)
            KeybindTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 16)
            KeybindTitle.BackgroundTransparency = 1
            KeybindTitle.Parent = KeybindFrame
            
            -- Description
            if config.Description then
                local KeybindDesc = Instance.new("TextLabel")
                KeybindDesc.Text = config.Description
                KeybindDesc.Font = Enum.Font.Gotham
                KeybindDesc.TextSize = 12
                KeybindDesc.TextColor3 = Theme.SubText
                KeybindDesc.TextXAlignment = Enum.TextXAlignment.Left
                KeybindDesc.Size = UDim2.new(1, -120, 0, 16)
                KeybindDesc.Position = UDim2.fromOffset(12, 28)
                KeybindDesc.BackgroundTransparency = 1
                KeybindDesc.TextWrapped = true
                KeybindDesc.Parent = KeybindFrame
            end
            
            -- Keybind display button
            local KeybindDisplay = Instance.new("TextButton")
            KeybindDisplay.Size = UDim2.fromOffset(100, 30)
            KeybindDisplay.Position = UDim2.new(1, -110, 0.5, -15)
            KeybindDisplay.BackgroundColor3 = Theme.Background
            KeybindDisplay.BackgroundTransparency = 0.2
            KeybindDisplay.Text = config.Default or "None"
            KeybindDisplay.TextColor3 = Theme.Text
            KeybindDisplay.TextSize = 12
            KeybindDisplay.Font = Enum.Font.Gotham
            KeybindDisplay.BorderSizePixel = 0
            KeybindDisplay.Parent = KeybindFrame
            
            local DisplayCorner = Instance.new("UICorner")
            DisplayCorner.CornerRadius = UDim.new(0, 6)
            DisplayCorner.Parent = KeybindDisplay
            
            local DisplayStroke = Instance.new("UIStroke")
            DisplayStroke.Color = Theme.ElementBorder
            DisplayStroke.Transparency = 0.6
            DisplayStroke.Parent = KeybindDisplay
            
            -- Keybind object
            Keybind = {
                Value = config.Default,
                Toggled = false,
                Mode = config.Mode,
                Type = "Keybind",
                Callback = config.Callback,
                ChangedCallback = config.ChangedCallback or function() end,
                Changed = nil,
                Frame = KeybindFrame
            }
            
            local Picking = false
            
            -- Get state function
            function Keybind:GetState()
                if not Library.KeySystemEnabled then return false end
                
                if UserInputService:GetFocusedTextBox() and Keybind.Mode ~= "Always" then
                    return false
                end
                
                if Keybind.Mode == "Always" then
                    return true
                elseif Keybind.Mode == "Hold" then
                    if Keybind.Value == "None" then
                        return false
                    end
                    
                    local Key = Keybind.Value
                    
                    if Key == "MouseLeft" or Key == "MouseRight" then
                        return Key == "MouseLeft" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
                            or Key == "MouseRight" and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
                    else
                        return UserInputService:IsKeyDown(Enum.KeyCode[Keybind.Value])
                    end
                else
                    return Keybind.Toggled
                end
            end
            
            -- Set value function
            function Keybind:SetValue(Key, Mode)
                Key = Key or Keybind.Value
                Mode = Mode or Keybind.Mode
                
                KeybindDisplay.Text = Key
                Keybind.Value = Key
                Keybind.Mode = Mode
            end
            
            function Keybind:OnClick(Callback)
                Keybind.Clicked = Callback
            end
            
            function Keybind:OnChanged(Callback)
                Keybind.Changed = Callback
                Callback(Keybind.Value)
            end
            
            function Keybind:DoClick()
                if not Library.KeySystemEnabled then return end
                
                Library:SafeCallback(Keybind.Callback, Keybind.Toggled)
                if Keybind.Clicked then
                    Library:SafeCallback(Keybind.Clicked, Keybind.Toggled)
                end
                
                -- Notify keybind activation
                Library:Notify({
                    Title = "Keybind Activated",
                    Content = config.Title .. " " .. (Keybind.Toggled and "ON" or "OFF"),
                    Duration = 1,
                    Vibrate = true
                })
            end
            
            function Keybind:Destroy()
                KeybindFrame:Destroy()
                Library.Options[Idx] = nil
            end
            
            -- Key picking functionality
            Library:Connect(KeybindDisplay.MouseButton1Click, function()
                Picking = true
                KeybindDisplay.Text = "..."
                
                wait(0.2)
                
                local Event
                Event = UserInputService.InputBegan:Connect(function(Input)
                    local Key
                    
                    if Input.UserInputType == Enum.UserInputType.Keyboard then
                        Key = Input.KeyCode.Name
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        Key = "MouseLeft"
                    elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
                        Key = "MouseRight"
                    end
                    
                    local EndedEvent
                    EndedEvent = UserInputService.InputEnded:Connect(function(Input)
                        if (Input.KeyCode.Name == Key) or 
                           (Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1) or
                           (Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2) then
                            Picking = false
                            
                            KeybindDisplay.Text = Key
                            Keybind.Value = Key
                            
                            Library:SafeCallback(Keybind.ChangedCallback, Input.KeyCode or Input.UserInputType)
                            if Keybind.Changed then
                                Library:SafeCallback(Keybind.Changed, Input.KeyCode or Input.UserInputType)
                            end
                            
                            Event:Disconnect()
                            EndedEvent:Disconnect()
                            
                            -- Notify keybind change
                            Library:Notify({
                                Title = "Keybind Set",
                                Content = config.Title .. " set to " .. Key,
                                Duration = 2,
                                Vibrate = true
                            })
                        end
                    end)
                end)
            end)
            
            -- Key activation functionality
            Library:Connect(UserInputService.InputBegan, function(Input)
                if not Library.KeySystemEnabled then return end
                
                if not Picking and not UserInputService:GetFocusedTextBox() then
                    if Keybind.Mode == "Toggle" then
                        local Key = Keybind.Value
                        
                        if Key == "MouseLeft" or Key == "MouseRight" then
                            if (Key == "MouseLeft" and Input.UserInputType == Enum.UserInputType.MouseButton1) or
                               (Key == "MouseRight" and Input.UserInputType == Enum.UserInputType.MouseButton2) then
                                Keybind.Toggled = not Keybind.Toggled
                                Keybind:DoClick()
                            end
                        elseif Input.UserInputType == Enum.UserInputType.Keyboard then
                            if Input.KeyCode.Name == Key then
                                Keybind.Toggled = not Keybind.Toggled
                                Keybind:DoClick()
                            end
                        end
                    end
                end
            end)
            
            -- Focus effects
            Library:Connect(KeybindDisplay.MouseEnter, function()
                Library:Tween(DisplayStroke, {Color = Theme.Accent, Transparency = 0.3}, 0.2)
            end)
            
            Library:Connect(KeybindDisplay.MouseLeave, function()
                Library:Tween(DisplayStroke, {Color = Theme.ElementBorder, Transparency = 0.6}, 0.2)
            end)
            
            Library.Options[Idx] = Keybind
            return Keybind
        end
        
        -- ADD COLORPICKER FUNCTION TO TAB
        function Tab:AddColorpicker(config)
            local Colorpicker = {}
            local Idx = config.Title or "Colorpicker_" .. math.random(1000, 9999)
            
            assert(config.Title, "Colorpicker - Missing Title")
            assert(config.Default, "Colorpicker - Missing default value.")
            config.Transparency = config.Transparency or 0
            config.Callback = config.Callback or function() end
            
            -- Colorpicker frame
            local ColorpickerFrame = Instance.new("TextButton")
            ColorpickerFrame.Name = config.Title or "Colorpicker"
            ColorpickerFrame.Size = UDim2.new(1, 0, 0, config.Description and 70 or 50)
            ColorpickerFrame.BackgroundColor3 = Theme.Element
            ColorpickerFrame.BackgroundTransparency = Theme.ElementTransparency
            ColorpickerFrame.Text = ""
            ColorpickerFrame.BorderSizePixel = 0
            ColorpickerFrame.Parent = TabContent
            
            local ColorpickerCorner = Instance.new("UICorner")
            ColorpickerCorner.CornerRadius = UDim.new(0, 8)
            ColorpickerCorner.Parent = ColorpickerFrame
            
            local ColorpickerStroke = Instance.new("UIStroke")
            ColorpickerStroke.Color = Theme.ElementBorder
            ColorpickerStroke.Transparency = 0.5
            ColorpickerStroke.Parent = ColorpickerFrame
            
            -- Title
            local ColorpickerTitle = Instance.new("TextLabel")
            ColorpickerTitle.Text = config.Title or "Colorpicker"
            ColorpickerTitle.Font = Enum.Font.GothamMedium
            ColorpickerTitle.TextSize = 14
            ColorpickerTitle.TextColor3 = Theme.Text
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left
            ColorpickerTitle.Size = UDim2.new(1, -80, 0, 18)
            ColorpickerTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 16)
            ColorpickerTitle.BackgroundTransparency = 1
            ColorpickerTitle.Parent = ColorpickerFrame
            
            -- Description
            if config.Description then
                local ColorpickerDesc = Instance.new("TextLabel")
                ColorpickerDesc.Text = config.Description
                ColorpickerDesc.Font = Enum.Font.Gotham
                ColorpickerDesc.TextSize = 12
                ColorpickerDesc.TextColor3 = Theme.SubText
                ColorpickerDesc.TextXAlignment = Enum.TextXAlignment.Left
                ColorpickerDesc.Size = UDim2.new(1, -80, 0, 16)
                ColorpickerDesc.Position = UDim2.fromOffset(12, 28)
                ColorpickerDesc.BackgroundTransparency = 1
                ColorpickerDesc.TextWrapped = true
                ColorpickerDesc.Parent = ColorpickerFrame
            end
            
            -- Color display
            local ColorDisplayChecker = Instance.new("ImageLabel")
            ColorDisplayChecker.Size = UDim2.fromOffset(60, 30)
            ColorDisplayChecker.Position = UDim2.new(1, -70, 0.5, -15)
            ColorDisplayChecker.Image = "http://www.roblox.com/asset/?id=14204231522"
            ColorDisplayChecker.ImageTransparency = 0.45
            ColorDisplayChecker.ScaleType = Enum.ScaleType.Tile
            ColorDisplayChecker.TileSize = UDim2.fromOffset(40, 40)
            ColorDisplayChecker.BackgroundTransparency = 1
            ColorDisplayChecker.Parent = ColorpickerFrame
            
            local ColorDisplayCorner = Instance.new("UICorner")
            ColorDisplayCorner.CornerRadius = UDim.new(0, 6)
            ColorDisplayCorner.Parent = ColorDisplayChecker
            
            local ColorDisplay = Instance.new("Frame")
            ColorDisplay.Size = UDim2.fromScale(1, 1)
            ColorDisplay.BackgroundColor3 = config.Default
            ColorDisplay.BackgroundTransparency = config.Transparency
            ColorDisplay.BorderSizePixel = 0
            ColorDisplay.Parent = ColorDisplayChecker
            
            local ColorDisplayCornerInner = Instance.new("UICorner")
            ColorDisplayCornerInner.CornerRadius = UDim.new(0, 6)
            ColorDisplayCornerInner.Parent = ColorDisplay
            
            -- Colorpicker object
            Colorpicker = {
                Value = config.Default,
                Transparency = config.Transparency,
                Type = "Colorpicker",
                Title = config.Title,
                Callback = config.Callback,
                Changed = nil,
                Frame = ColorpickerFrame,
                Hue = 0,
                Sat = 0,
                Vib = 0
            }
            
            function Colorpicker:SetHSVFromRGB(Color)
                local H, S, V = Color3.toHSV(Color)
                Colorpicker.Hue = H
                Colorpicker.Sat = S
                Colorpicker.Vib = V
            end
            
            Colorpicker:SetHSVFromRGB(Colorpicker.Value)
            
            function Colorpicker:Display()
                Colorpicker.Value = Color3.fromHSV(Colorpicker.Hue, Colorpicker.Sat, Colorpicker.Vib)
                
                ColorDisplay.BackgroundColor3 = Colorpicker.Value
                ColorDisplay.BackgroundTransparency = Colorpicker.Transparency
                
                Library:SafeCallback(Colorpicker.Callback, Colorpicker.Value)
                if Colorpicker.Changed then
                    Library:SafeCallback(Colorpicker.Changed, Colorpicker.Value)
                end
            end
            
            function Colorpicker:SetValue(HSV, Transparency)
                local Color = Color3.fromHSV(HSV[1], HSV[2], HSV[3])
                
                Colorpicker.Transparency = Transparency or 0
                Colorpicker:SetHSVFromRGB(Color)
                Colorpicker:Display()
            end
            
            function Colorpicker:SetValueRGB(Color, Transparency)
                Colorpicker.Transparency = Transparency or 0
                Colorpicker:SetHSVFromRGB(Color)
                Colorpicker:Display()
            end
            
            function Colorpicker:OnChanged(Func)
                Colorpicker.Changed = Func
                Func(Colorpicker.Value)
            end
            
            function Colorpicker:Destroy()
                ColorpickerFrame:Destroy()
                Library.Options[Idx] = nil
            end
            
            -- Create color dialog function
            local function CreateColorDialog()
                -- Simple color dialog implementation
                local Dialog = Instance.new("Frame")
                Dialog.Name = "ColorDialog"
                Dialog.Size = UDim2.fromOffset(300, 250)
                Dialog.Position = UDim2.fromScale(0.5, 0.5)
                Dialog.AnchorPoint = Vector2.new(0.5, 0.5)
                Dialog.BackgroundColor3 = Theme.Background
                Dialog.BackgroundTransparency = Theme.BackgroundTransparency
                Dialog.BorderSizePixel = 0
                Dialog.Parent = GUI
                Dialog.ZIndex = 1000
                
                local DialogCorner = Instance.new("UICorner")
                DialogCorner.CornerRadius = UDim.new(0, 12)
                DialogCorner.Parent = Dialog
                
                local DialogStroke = Instance.new("UIStroke")
                DialogStroke.Color = Theme.ElementBorder
                DialogStroke.Thickness = 1
                DialogStroke.Transparency = 0.3
                DialogStroke.Parent = Dialog
                
                -- Dialog title
                local DialogTitle = Instance.new("TextLabel")
                DialogTitle.Text = Colorpicker.Title
                DialogTitle.Font = Enum.Font.GothamBold
                DialogTitle.TextSize = 16
                DialogTitle.TextColor3 = Theme.Text
                DialogTitle.TextXAlignment = Enum.TextXAlignment.Left
                DialogTitle.Size = UDim2.new(1, -60, 0, 30)
                DialogTitle.Position = UDim2.fromOffset(15, 10)
                DialogTitle.BackgroundTransparency = 1
                DialogTitle.Parent = Dialog
                
                -- Close button
                local CloseDialogBtn = Instance.new("TextButton")
                CloseDialogBtn.Size = UDim2.fromOffset(25, 25)
                CloseDialogBtn.Position = UDim2.new(1, -35, 0, 10)
                CloseDialogBtn.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
                CloseDialogBtn.BackgroundTransparency = 0.1
                CloseDialogBtn.Text = "×"
                CloseDialogBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                CloseDialogBtn.TextSize = 16
                CloseDialogBtn.Font = Enum.Font.GothamBold
                CloseDialogBtn.BorderSizePixel = 0
                CloseDialogBtn.Parent = Dialog
                
                local CloseDialogCorner = Instance.new("UICorner")
                CloseDialogCorner.CornerRadius = UDim.new(0, 6)
                CloseDialogCorner.Parent = CloseDialogBtn
                
                -- Color presets
                local PresetColors = {
                    Color3.fromRGB(255, 0, 0),   -- Red
                    Color3.fromRGB(255, 165, 0), -- Orange
                    Color3.fromRGB(255, 255, 0), -- Yellow
                    Color3.fromRGB(0, 255, 0),   -- Green
                    Color3.fromRGB(0, 255, 255), -- Cyan
                    Color3.fromRGB(0, 0, 255),   -- Blue
                    Color3.fromRGB(128, 0, 128), -- Purple
                    Color3.fromRGB(255, 192, 203), -- Pink
                }
                
                local ColorGrid = Instance.new("Frame")
                ColorGrid.Size = UDim2.new(1, -30, 0, 100)
                ColorGrid.Position = UDim2.fromOffset(15, 50)
                ColorGrid.BackgroundTransparency = 1
                ColorGrid.Parent = Dialog
                
                local GridLayout = Instance.new("UIGridLayout")
                GridLayout.CellSize = UDim2.fromOffset(30, 30)
                GridLayout.CellPadding = UDim2.fromOffset(5, 5)
                GridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
                GridLayout.Parent = ColorGrid
                
                for _, color in pairs(PresetColors) do
                    local ColorBtn = Instance.new("TextButton")
                    ColorBtn.Size = UDim2.fromOffset(30, 30)
                    ColorBtn.BackgroundColor3 = color
                    ColorBtn.Text = ""
                    ColorBtn.BorderSizePixel = 0
                    ColorBtn.Parent = ColorGrid
                    
                    local ColorBtnCorner = Instance.new("UICorner")
                    ColorBtnCorner.CornerRadius = UDim.new(0, 6)
                    ColorBtnCorner.Parent = ColorBtn
                    
                    Library:Connect(ColorBtn.MouseButton1Click, function()
                        Colorpicker:SetHSVFromRGB(color)
                        Colorpicker:Display()
                        Dialog:Destroy()
                        
                        Library:Notify({
                            Title = "Color Changed",
                            Content = "Color updated for " .. config.Title,
                            Duration = 1.5,
                            Vibrate = true
                        })
                    end)
                end
                
                -- Done button
                local DoneBtn = Instance.new("TextButton")
                DoneBtn.Size = UDim2.fromOffset(80, 30)
                DoneBtn.Position = UDim2.new(1, -95, 1, -40)
                DoneBtn.BackgroundColor3 = Theme.Accent
                DoneBtn.BackgroundTransparency = 0.1
                DoneBtn.Text = "Done"
                DoneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                DoneBtn.TextSize = 14
                DoneBtn.Font = Enum.Font.GothamMedium
                DoneBtn.BorderSizePixel = 0
                DoneBtn.Parent = Dialog
                
                local DoneBtnCorner = Instance.new("UICorner")
                DoneBtnCorner.CornerRadius = UDim.new(0, 6)
                DoneBtnCorner.Parent = DoneBtn
                
                Library:Connect(DoneBtn.MouseButton1Click, function()
                    Dialog:Destroy()
                end)
                
                Library:Connect(CloseDialogBtn.MouseButton1Click, function()
                    Dialog:Destroy()
                end)
                
                -- Make dialog draggable
                MakeDraggable(Dialog, Dialog)
            end
            
            -- Click to open dialog
            Library:Connect(ColorpickerFrame.MouseButton1Click, function()
                CreateColorDialog()
            end)
            
            -- Hover effects
            Library:Connect(ColorpickerFrame.MouseEnter, function()
                Library:Tween(ColorpickerFrame, {BackgroundTransparency = 0.05}, 0.15)
            end)
            
            Library:Connect(ColorpickerFrame.MouseLeave, function()
                Library:Tween(ColorpickerFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
            end)
            
            Colorpicker:Display()
            
            Library.Options[Idx] = Colorpicker
            return Colorpicker
        end
        
        -- ADD SLIDER FUNCTION TO TAB
        function Tab:AddSlider(config)
            local Slider = {}
            local Idx = config.Title or "Slider_" .. math.random(1000, 9999)
            
            assert(config.Title, "Slider - Missing Title.")
            assert(config.Default, "Slider - Missing default value.")
            assert(config.Min, "Slider - Missing minimum value.")
            assert(config.Max, "Slider - Missing maximum value.")
            assert(config.Rounding, "Slider - Missing rounding value.")
            config.Callback = config.Callback or function() end
            
            -- Slider frame
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = config.Title or "Slider"
            SliderFrame.Size = UDim2.new(1, 0, 0, config.Description and 70 or 50)
            SliderFrame.BackgroundColor3 = Theme.Element
            SliderFrame.BackgroundTransparency = Theme.ElementTransparency
            SliderFrame.BorderSizePixel = 0
            SliderFrame.Parent = TabContent
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 8)
            SliderCorner.Parent = SliderFrame
            
            local SliderStroke = Instance.new("UIStroke")
            SliderStroke.Color = Theme.ElementBorder
            SliderStroke.Transparency = 0.5
            SliderStroke.Parent = SliderFrame
            
            -- Title
            local SliderTitle = Instance.new("TextLabel")
            SliderTitle.Text = config.Title or "Slider"
            SliderTitle.Font = Enum.Font.GothamMedium
            SliderTitle.TextSize = 14
            SliderTitle.TextColor3 = Theme.Text
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
            SliderTitle.Size = UDim2.new(1, -170, 0, 18)
            SliderTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 16)
            SliderTitle.BackgroundTransparency = 1
            SliderTitle.Parent = SliderFrame
            
            -- Description
            if config.Description then
                local SliderDesc = Instance.new("TextLabel")
                SliderDesc.Text = config.Description
                SliderDesc.Font = Enum.Font.Gotham
                SliderDesc.TextSize = 12
                SliderDesc.TextColor3 = Theme.SubText
                SliderDesc.TextXAlignment = Enum.TextXAlignment.Left
                SliderDesc.Size = UDim2.new(1, -170, 0, 16)
                SliderDesc.Position = UDim2.fromOffset(12, 28)
                SliderDesc.BackgroundTransparency = 1
                SliderDesc.TextWrapped = true
                SliderDesc.Parent = SliderFrame
            end
            
            -- Value display
            local ValueDisplay = Instance.new("TextLabel")
            ValueDisplay.Text = tostring(config.Default)
            ValueDisplay.Font = Enum.Font.Gotham
            ValueDisplay.TextSize = 12
            ValueDisplay.TextColor3 = Theme.SubText
            ValueDisplay.TextXAlignment = Enum.TextXAlignment.Right
            ValueDisplay.Size = UDim2.fromOffset(50, 14)
            ValueDisplay.Position = UDim2.new(1, -60, 0, config.Description and 8 or 16)
            ValueDisplay.BackgroundTransparency = 1
            ValueDisplay.Parent = SliderFrame
            
            -- Slider container
            local SliderContainer = Instance.new("Frame")
            SliderContainer.Size = UDim2.fromOffset(150, 4)
            SliderContainer.Position = UDim2.new(1, -160, 1, config.Description and -15 or -17)
            SliderContainer.BackgroundColor3 = Theme.ElementBorder
            SliderContainer.BackgroundTransparency = 0.4
            SliderContainer.BorderSizePixel = 0
            SliderContainer.Parent = SliderFrame
            
            local SliderContainerCorner = Instance.new("UICorner")
            SliderContainerCorner.CornerRadius = UDim.new(1, 0)
            SliderContainerCorner.Parent = SliderContainer
            
            -- Slider fill
            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.fromScale(0, 1)
            SliderFill.BackgroundColor3 = Theme.Accent
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderContainer
            
            local SliderFillCorner = Instance.new("UICorner")
            SliderFillCorner.CornerRadius = UDim.new(1, 0)
            SliderFillCorner.Parent = SliderFill
            
            -- Slider dot
            local SliderDot = Instance.new("Frame")
            SliderDot.Size = UDim2.fromOffset(12, 12)
            SliderDot.Position = UDim2.new(0, -6, 0.5, -6)
            SliderDot.BackgroundColor3 = Theme.Accent
            SliderDot.BorderSizePixel = 0
            SliderDot.Parent = SliderContainer
            
            local SliderDotCorner = Instance.new("UICorner")
            SliderDotCorner.CornerRadius = UDim.new(1, 0)
            SliderDotCorner.Parent = SliderDot
            
            -- Slider object
            Slider = {
                Value = config.Default,
                Min = config.Min,
                Max = config.Max,
                Rounding = config.Rounding,
                Callback = config.Callback,
                Type = "Slider",
                Changed = nil,
                Frame = SliderFrame
            }
            
            local Dragging = false
            
            function Slider:OnChanged(Func)
                Slider.Changed = Func
                Func(Slider.Value)
            end
            
            function Slider:SetValue(Value)
                self.Value = Library:Round(math.clamp(Value, Slider.Min, Slider.Max), Slider.Rounding)
                
                local Percent = (self.Value - Slider.Min) / (Slider.Max - Slider.Min)
                SliderDot.Position = UDim2.new(Percent, -6, 0.5, -6)
                SliderFill.Size = UDim2.fromScale(Percent, 1)
                ValueDisplay.Text = tostring(self.Value)
                
                Library:SafeCallback(Slider.Callback, self.Value)
                if Slider.Changed then
                    Library:SafeCallback(Slider.Changed, self.Value)
                end
            end
            
            function Slider:Destroy()
                SliderFrame:Destroy()
                Library.Options[Idx] = nil
            end
            
            -- Dragging functionality
            Library:Connect(SliderContainer.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                    
                    -- Update immediately on click
                    local Percent = math.clamp((Input.Position.X - SliderContainer.AbsolutePosition.X) / SliderContainer.AbsoluteSize.X, 0, 1)
                    Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * Percent))
                end
            end)
            
            Library:Connect(SliderDot.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = true
                end
            end)
            
            Library:Connect(UserInputService.InputChanged, function(Input)
                if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                    local Percent = math.clamp((Input.Position.X - SliderContainer.AbsolutePosition.X) / SliderContainer.AbsoluteSize.X, 0, 1)
                    Slider:SetValue(Slider.Min + ((Slider.Max - Slider.Min) * Percent))
                end
            end)
            
            Library:Connect(UserInputService.InputEnded, function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    Dragging = false
                end
            end)
            
            -- Hover effects
            Library:Connect(SliderFrame.MouseEnter, function()
                Library:Tween(SliderFrame, {BackgroundTransparency = 0.05}, 0.15)
            end)
            
            Library:Connect(SliderFrame.MouseLeave, function()
                Library:Tween(SliderFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
            end)
            
            -- Set initial value
            Slider:SetValue(config.Default)
            
            Library.Options[Idx] = Slider
            return Slider
        end
        
        -- ADD INPUT FUNCTION TO TAB
        function Tab:AddInput(config)
            local Input = {}
            local Idx = config.Title or "Input_" .. math.random(1000, 9999)
            
            assert(config.Title, "Input - Missing Title")
            config.Callback = config.Callback or function() end
            
            -- Input frame with transparency
            local InputFrame = Instance.new("Frame")
            InputFrame.Name = config.Title or "Input"
            InputFrame.Size = UDim2.new(1, 0, 0, config.Description and 70 or 50)
            InputFrame.BackgroundColor3 = Theme.Element
            InputFrame.BackgroundTransparency = Theme.ElementTransparency
            InputFrame.BorderSizePixel = 0
            InputFrame.Parent = TabContent
            
            local InputCorner = Instance.new("UICorner")
            InputCorner.CornerRadius = UDim.new(0, 8)
            InputCorner.Parent = InputFrame
            
            local InputStroke = Instance.new("UIStroke")
            InputStroke.Color = Theme.ElementBorder
            InputStroke.Transparency = 0.5
            InputStroke.Parent = InputFrame
            
            -- Title
            local InputTitle = Instance.new("TextLabel")
            InputTitle.Text = config.Title or "Input"
            InputTitle.Font = Enum.Font.GothamMedium
            InputTitle.TextSize = 14
            InputTitle.TextColor3 = Theme.Text
            InputTitle.TextXAlignment = Enum.TextXAlignment.Left
            InputTitle.Size = UDim2.new(1, -180, 0, 18)
            InputTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 16)
            InputTitle.BackgroundTransparency = 1
            InputTitle.Parent = InputFrame
            
            -- Description
            if config.Description then
                local InputDesc = Instance.new("TextLabel")
                InputDesc.Text = config.Description
                InputDesc.Font = Enum.Font.Gotham
                InputDesc.TextSize = 12
                InputDesc.TextColor3 = Theme.SubText
                InputDesc.TextXAlignment = Enum.TextXAlignment.Left
                InputDesc.Size = UDim2.new(1, -180, 0, 16)
                InputDesc.Position = UDim2.fromOffset(12, 28)
                InputDesc.BackgroundTransparency = 1
                InputDesc.TextWrapped = true
                InputDesc.Parent = InputFrame
            end
            
            -- Textbox container
            local TextboxFrame = Instance.new("Frame")
            TextboxFrame.Size = UDim2.fromOffset(160, 30)
            TextboxFrame.Position = UDim2.new(1, -170, 0.5, -15)
            TextboxFrame.BackgroundColor3 = Theme.Background
            TextboxFrame.BackgroundTransparency = 0.2
            TextboxFrame.BorderSizePixel = 0
            TextboxFrame.Parent = InputFrame
            
            local TextboxCorner = Instance.new("UICorner")
            TextboxCorner.CornerRadius = UDim.new(0, 6)
            TextboxCorner.Parent = TextboxFrame
            
            local TextboxStroke = Instance.new("UIStroke")
            TextboxStroke.Color = Theme.ElementBorder
            TextboxStroke.Transparency = 0.6
            TextboxStroke.Parent = TextboxFrame
            
            -- Textbox
            local Textbox = Instance.new("TextBox")
            Textbox.Size = UDim2.new(1, -16, 1, 0)
            Textbox.Position = UDim2.fromOffset(8, 0)
            Textbox.BackgroundTransparency = 1
            Textbox.Text = config.Default or ""
            Textbox.PlaceholderText = config.Placeholder or ""
            Textbox.TextColor3 = Theme.Text
            Textbox.PlaceholderColor3 = Theme.SubText
            Textbox.TextSize = 13
            Textbox.Font = Enum.Font.Gotham
            Textbox.ClearTextOnFocus = false
            Textbox.Parent = TextboxFrame
            
            -- Input object
            Input = {
                Value = config.Default or "",
                Numeric = config.Numeric or false,
                Finished = config.Finished or false,
                Callback = config.Callback or function(Value) end,
                Type = "Input",
                Frame = InputFrame,
                Changed = nil
            }
            
            -- Set title and description functions
            Input.SetTitle = function(title)
                InputTitle.Text = title
            end
            
            Input.SetDesc = function(desc)
                if config.Description then
                    InputDesc.Text = desc or ""
                end
            end
            
            -- Set value function with validation
            function Input:SetValue(Text)
                if config.MaxLength and #Text > config.MaxLength then
                    Text = Text:sub(1, config.MaxLength)
                end
                
                if Input.Numeric then
                    if (not tonumber(Text)) and Text:len() > 0 then
                        Text = Input.Value
                    end
                end
                
                Input.Value = Text
                Textbox.Text = Text
                
                Library:SafeCallback(Input.Callback, Input.Value)
                if Input.Changed then
                    Library:SafeCallback(Input.Changed, Input.Value)
                end
            end
            
            -- Connect input events
            if Input.Finished then
                Library:Connect(Textbox.FocusLost, function(enter)
                    if not enter then
                        return
                    end
                    Input:SetValue(Textbox.Text)
                end)
            else
                Library:Connect(Textbox:GetPropertyChangedSignal("Text"), function()
                    Input:SetValue(Textbox.Text)
                end)
            end
            
            -- On changed callback
            function Input:OnChanged(Func)
                Input.Changed = Func
                Func(Input.Value)
            end
            
            -- Destroy function
            function Input:Destroy()
                InputFrame:Destroy()
                Library.Options[Idx] = nil
            end
            
            -- Focus effects
            Library:Connect(Textbox.Focused, function()
                Library:Tween(TextboxStroke, {Color = Theme.Accent, Transparency = 0.3}, 0.2)
            end)
            
            Library:Connect(Textbox.FocusLost, function()
                Library:Tween(TextboxStroke, {Color = Theme.ElementBorder, Transparency = 0.6}, 0.2)
            end)
            
            Library.Options[Idx] = Input
            return Input
        end
        
        -- ADD PARAGRAPH FUNCTION TO TAB
        function Tab:AddParagraph(config)
            assert(config.Title, "Paragraph - Missing Title")
            config.Content = config.Content or ""
            
            -- Paragraph frame with transparency
            local ParagraphFrame = Instance.new("Frame")
            ParagraphFrame.Name = config.Title or "Paragraph"
            ParagraphFrame.Size = UDim2.new(1, 0, 0, 0)
            ParagraphFrame.AutomaticSize = Enum.AutomaticSize.Y
            ParagraphFrame.BackgroundColor3 = Theme.Element
            ParagraphFrame.BackgroundTransparency = 0.92
            ParagraphFrame.BorderSizePixel = 0
            ParagraphFrame.Parent = TabContent
            
            local ParagraphCorner = Instance.new("UICorner")
            ParagraphCorner.CornerRadius = UDim.new(0, 8)
            ParagraphCorner.Parent = ParagraphFrame
            
            local ParagraphStroke = Instance.new("UIStroke")
            ParagraphStroke.Color = Theme.ElementBorder
            ParagraphStroke.Transparency = 0.6
            ParagraphStroke.Parent = ParagraphFrame
            
            -- Padding
            local ParagraphPadding = Instance.new("UIPadding")
            ParagraphPadding.PaddingTop = UDim.new(0, 12)
            ParagraphPadding.PaddingBottom = UDim.new(0, 12)
            ParagraphPadding.PaddingLeft = UDim.new(0, 12)
            ParagraphPadding.PaddingRight = UDim.new(0, 12)
            ParagraphPadding.Parent = ParagraphFrame
            
            -- List layout for organizing title and content
            local ParagraphList = Instance.new("UIListLayout")
            ParagraphList.Padding = UDim.new(0, 8)
            ParagraphList.Parent = ParagraphFrame
            
            -- Title
            local ParagraphTitle = Instance.new("TextLabel")
            ParagraphTitle.Text = config.Title
            ParagraphTitle.Font = Enum.Font.GothamBold
            ParagraphTitle.TextSize = 16
            ParagraphTitle.TextColor3 = Theme.Text
            ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphTitle.Size = UDim2.new(1, 0, 0, 20)
            ParagraphTitle.BackgroundTransparency = 1
            ParagraphTitle.Parent = ParagraphFrame
            ParagraphTitle.LayoutOrder = 1
            
            -- Content
            local ParagraphContent = Instance.new("TextLabel")
            ParagraphContent.Text = config.Content
            ParagraphContent.Font = Enum.Font.Gotham
            ParagraphContent.TextSize = 14
            ParagraphContent.TextColor3 = Theme.SubText
            ParagraphContent.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphContent.TextYAlignment = Enum.TextYAlignment.Top
            ParagraphContent.Size = UDim2.new(1, 0, 0, 0)
            ParagraphContent.AutomaticSize = Enum.AutomaticSize.Y
            ParagraphContent.BackgroundTransparency = 1
            ParagraphContent.TextWrapped = true
            ParagraphContent.Parent = ParagraphFrame
            ParagraphContent.LayoutOrder = 2
            
            local Paragraph = {
                Frame = ParagraphFrame,
                Title = ParagraphTitle,
                Content = ParagraphContent,
                SetTitle = function(title)
                    ParagraphTitle.Text = title
                end,
                SetContent = function(content)
                    ParagraphContent.Text = content
                end
            }
            
            return Paragraph
        end
        
        function Tab:AddSection(title)
            local Section = {}
            
            -- Section frame with transparency
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = title or "Section"
            SectionFrame.Size = UDim2.new(1, 0, 0, 0)
            SectionFrame.AutomaticSize = Enum.AutomaticSize.Y
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Parent = TabContent
            
            local SectionList = Instance.new("UIListLayout")
            SectionList.Padding = UDim.new(0, 8)
            SectionList.Parent = SectionFrame
            
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.PaddingTop = UDim.new(0, 8)
            SectionPadding.PaddingBottom = UDim.new(0, 8)
            SectionPadding.PaddingLeft = UDim.new(0, 8)
            SectionPadding.PaddingRight = UDim.new(0, 8)
            SectionPadding.Parent = SectionFrame
            
            -- Section title
            if title and title ~= "" then
                local SectionTitle = Instance.new("TextLabel")
                SectionTitle.Name = "Title"
                SectionTitle.Text = title
                SectionTitle.Font = Enum.Font.GothamBold
                SectionTitle.TextSize = 16
                SectionTitle.TextColor3 = Theme.Text
                SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
                SectionTitle.Size = UDim2.new(1, 0, 0, 28)
                SectionTitle.BackgroundTransparency = 1
                SectionTitle.Parent = SectionFrame
                SectionTitle.LayoutOrder = -1
            end
            
            Section.Frame = SectionFrame
            Section.Container = SectionFrame
            Section.Library = Library
            
            -- Copy all the section methods
            function Section:AddKeybind(config)
                return Tab:AddKeybind(config)
            end
            
            function Section:AddColorpicker(config)
                return Tab:AddColorpicker(config)
            end
            
            function Section:AddSlider(config)
                return Tab:AddSlider(config)
            end
            
            function Section:AddInput(config)
                return Tab:AddInput(config)
            end
            
            function Section:AddParagraph(config)
                return Tab:AddParagraph(config)
            end
            
            function Section:AddToggle(config)
                local Toggle = {}
                
                -- Toggle frame with transparency
                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Name = config.Title or "Toggle"
                ToggleFrame.Size = UDim2.new(1, 0, 0, config.Description and 55 or 40)
                ToggleFrame.BackgroundColor3 = Theme.Element
                ToggleFrame.BackgroundTransparency = Theme.ElementTransparency
                ToggleFrame.Text = ""
                ToggleFrame.BorderSizePixel = 0
                ToggleFrame.Parent = SectionFrame
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Parent = ToggleFrame
                
                local ToggleStroke = Instance.new("UIStroke")
                ToggleStroke.Color = Theme.ElementBorder
                ToggleStroke.Transparency = 0.5
                ToggleStroke.Parent = ToggleFrame
                
                -- Title
                local ToggleTitle = Instance.new("TextLabel")
                ToggleTitle.Text = config.Title or "Toggle"
                ToggleTitle.Font = Enum.Font.GothamMedium
                ToggleTitle.TextSize = 14
                ToggleTitle.TextColor3 = Theme.Text
                ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
                ToggleTitle.Size = UDim2.new(1, -60, 0, 18)
                ToggleTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 11)
                ToggleTitle.BackgroundTransparency = 1
                ToggleTitle.Parent = ToggleFrame
                
                -- Description
                if config.Description then
                    local ToggleDesc = Instance.new("TextLabel")
                    ToggleDesc.Text = config.Description
                    ToggleDesc.Font = Enum.Font.Gotham
                    ToggleDesc.TextSize = 12
                    ToggleDesc.TextColor3 = Theme.SubText
                    ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
                    ToggleDesc.Size = UDim2.new(1, -60, 0, 16)
                    ToggleDesc.Position = UDim2.fromOffset(12, 28)
                    ToggleDesc.BackgroundTransparency = 1
                    ToggleDesc.TextWrapped = true
                    ToggleDesc.Parent = ToggleFrame
                end
                
                -- Toggle switch
                local ToggleSlider = Instance.new("Frame")
                ToggleSlider.Size = UDim2.fromOffset(38, 20)
                ToggleSlider.Position = UDim2.new(1, -50, 0.5, -10)
                ToggleSlider.BackgroundColor3 = Theme.ElementBorder
                ToggleSlider.BackgroundTransparency = 0.3
                ToggleSlider.BorderSizePixel = 0
                ToggleSlider.Parent = ToggleFrame
                
                local SliderCorner = Instance.new("UICorner")
                SliderCorner.CornerRadius = UDim.new(0, 10)
                SliderCorner.Parent = ToggleSlider
                
                -- Toggle circle
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Size = UDim2.fromOffset(16, 16)
                ToggleCircle.Position = UDim2.fromOffset(2, 2)
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleCircle.BorderSizePixel = 0
                ToggleCircle.Parent = ToggleSlider
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(0, 8)
                CircleCorner.Parent = ToggleCircle
                
                -- Toggle state
                local ToggleState = config.Default or false
                
                local function UpdateToggle()
                    local TargetColor = ToggleState and Theme.Accent or Theme.ElementBorder
                    local TargetPos = ToggleState and UDim2.fromOffset(20, 2) or UDim2.fromOffset(2, 2)
                    
                    Library:Tween(ToggleSlider, {BackgroundColor3 = TargetColor}, 0.25)
                    Library:Tween(ToggleCircle, {Position = TargetPos}, 0.25)
                end
                
                -- Click functionality
                Library:Connect(ToggleFrame.MouseButton1Click, function()
                    ToggleState = not ToggleState
                    UpdateToggle()
                    Library:SafeCallback(config.Callback, ToggleState)
                end)
                
                -- Hover effects
                Library:Connect(ToggleFrame.MouseEnter, function()
                    Library:Tween(ToggleFrame, {BackgroundTransparency = 0.05}, 0.15)
                end)
                
                Library:Connect(ToggleFrame.MouseLeave, function()
                    Library:Tween(ToggleFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
                end)
                
                UpdateToggle()
                
                Toggle.Frame = ToggleFrame
                Toggle.SetValue = function(value)
                    ToggleState = value
                    UpdateToggle()
                    Library:SafeCallback(config.Callback, ToggleState)
                end
                Toggle.GetValue = function()
                    return ToggleState
                end
                
                return Toggle
            end
            
            function Section:AddDropdown(config)
                local Dropdown = {}
                
                -- Dropdown frame
                local DropdownFrame = Instance.new("TextButton")
                DropdownFrame.Name = config.Title or "Dropdown"
                DropdownFrame.Size = UDim2.new(1, 0, 0, config.Description and 55 or 40)
                DropdownFrame.BackgroundColor3 = Theme.Element
                DropdownFrame.BackgroundTransparency = Theme.ElementTransparency
                DropdownFrame.Text = ""
                DropdownFrame.BorderSizePixel = 0
                DropdownFrame.Parent = SectionFrame
                
                local DropdownCorner = Instance.new("UICorner")
                DropdownCorner.CornerRadius = UDim.new(0, 8)
                DropdownCorner.Parent = DropdownFrame
                
                local DropdownStroke = Instance.new("UIStroke")
                DropdownStroke.Color = Theme.ElementBorder
                DropdownStroke.Transparency = 0.5
                DropdownStroke.Parent = DropdownFrame
                
                -- Title
                local DropdownTitle = Instance.new("TextLabel")
                DropdownTitle.Text = config.Title or "Dropdown"
                DropdownTitle.Font = Enum.Font.GothamMedium
                DropdownTitle.TextSize = 14
                DropdownTitle.TextColor3 = Theme.Text
                DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
                DropdownTitle.Size = UDim2.new(1, -40, 0, 18)
                DropdownTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 11)
                DropdownTitle.BackgroundTransparency = 1
                DropdownTitle.Parent = DropdownFrame
                
                -- Description
                if config.Description then
                    local DropdownDesc = Instance.new("TextLabel")
                    DropdownDesc.Text = config.Description
                    DropdownDesc.Font = Enum.Font.Gotham
                    DropdownDesc.TextSize = 12
                    DropdownDesc.TextColor3 = Theme.SubText
                    DropdownDesc.TextXAlignment = Enum.TextXAlignment.Left
                    DropdownDesc.Size = UDim2.new(1, -40, 0, 16)
                    DropdownDesc.Position = UDim2.fromOffset(12, 28)
                    DropdownDesc.BackgroundTransparency = 1
                    DropdownDesc.TextWrapped = true
                    DropdownDesc.Parent = DropdownFrame
                end
                
                -- Dropdown display
                local DropdownDisplay = Instance.new("TextButton")
                DropdownDisplay.Size = UDim2.fromOffset(120, 28)
                DropdownDisplay.Position = UDim2.new(1, -130, 0.5, -14)
                DropdownDisplay.BackgroundColor3 = Theme.Background
                DropdownDisplay.BackgroundTransparency = 0.2
                DropdownDisplay.Text = config.Default or "Select..."
                DropdownDisplay.TextColor3 = Theme.Text
                DropdownDisplay.TextSize = 12
                DropdownDisplay.Font = Enum.Font.Gotham
                DropdownDisplay.BorderSizePixel = 0
                DropdownDisplay.Parent = DropdownFrame
                
                local DisplayCorner = Instance.new("UICorner")
                DisplayCorner.CornerRadius = UDim.new(0, 6)
                DisplayCorner.Parent = DropdownDisplay
                
                local DisplayStroke = Instance.new("UIStroke")
                DisplayStroke.Color = Theme.ElementBorder
                DisplayStroke.Transparency = 0.6
                DisplayStroke.Parent = DropdownDisplay
                
                -- Arrow
                local Arrow = Instance.new("TextLabel")
                Arrow.Text = "▼"
                Arrow.Font = Enum.Font.GothamBold
                Arrow.TextSize = 10
                Arrow.TextColor3 = Theme.SubText
                Arrow.Size = UDim2.fromOffset(16, 16)
                Arrow.Position = UDim2.new(1, -20, 0.5, -8)
                Arrow.BackgroundTransparency = 1
                Arrow.Parent = DropdownDisplay
                
                -- Dropdown list
                local DropdownList = Instance.new("Frame")
                DropdownList.Size = UDim2.fromOffset(120, 0)
                DropdownList.Position = UDim2.new(1, -130, 1, 5)
                DropdownList.BackgroundColor3 = Theme.Background
                DropdownList.BackgroundTransparency = 0.1
                DropdownList.BorderSizePixel = 0
                DropdownList.Visible = false
                DropdownList.Parent = DropdownFrame
                DropdownList.ZIndex = 100
                
                local ListCorner = Instance.new("UICorner")
                ListCorner.CornerRadius = UDim.new(0, 6)
                ListCorner.Parent = DropdownList
                
                local ListStroke = Instance.new("UIStroke")
                ListStroke.Color = Theme.ElementBorder
                ListStroke.Transparency = 0.4
                ListStroke.Parent = DropdownList
                
                local ListLayout = Instance.new("UIListLayout")
                ListLayout.Padding = UDim.new(0, 2)
                ListLayout.Parent = DropdownList
                
                local ListPadding = Instance.new("UIPadding")
                ListPadding.PaddingTop = UDim.new(0, 4)
                ListPadding.PaddingBottom = UDim.new(0, 4)
                ListPadding.PaddingLeft = UDim.new(0, 4)
                ListPadding.PaddingRight = UDim.new(0, 4)
                ListPadding.Parent = DropdownList
                
                -- State
                local IsOpen = false
                local SelectedValue = config.Default
                
                local function UpdateList()
                    -- Clear existing options
                    for _, child in pairs(DropdownList:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    -- Add options
                    for _, option in pairs(config.Values or {}) do
                        local OptionBtn = Instance.new("TextButton")
                        OptionBtn.Size = UDim2.new(1, 0, 0, 24)
                        OptionBtn.BackgroundColor3 = Theme.Element
                        OptionBtn.BackgroundTransparency = 0.8
                        OptionBtn.Text = option
                        OptionBtn.TextColor3 = Theme.Text
                        OptionBtn.TextSize = 11
                        OptionBtn.Font = Enum.Font.Gotham
                        OptionBtn.TextXAlignment = Enum.TextXAlignment.Left
                        OptionBtn.BorderSizePixel = 0
                        OptionBtn.Parent = DropdownList
                        
                        local OptionCorner = Instance.new("UICorner")
                        OptionCorner.CornerRadius = UDim.new(0, 4)
                        OptionCorner.Parent = OptionBtn
                        
                        local OptionPadding = Instance.new("UIPadding")
                        OptionPadding.PaddingLeft = UDim.new(0, 8)
                        OptionPadding.Parent = OptionBtn
                        
                        Library:Connect(OptionBtn.MouseButton1Click, function()
                            SelectedValue = option
                            DropdownDisplay.Text = option
                            IsOpen = false
                            DropdownList.Visible = false
                            Arrow.Text = "▼"
                            Library:SafeCallback(config.Callback, option)
                        end)
                        
                        Library:Connect(OptionBtn.MouseEnter, function()
                            Library:Tween(OptionBtn, {BackgroundTransparency = 0.5}, 0.1)
                        end)
                        
                        Library:Connect(OptionBtn.MouseLeave, function()
                            Library:Tween(OptionBtn, {BackgroundTransparency = 0.8}, 0.1)
                        end)
                    end
                    
                    -- Update list size
                    DropdownList.Size = UDim2.fromOffset(120, ListLayout.AbsoluteContentSize.Y + 8)
                end
                
                -- Toggle dropdown
                Library:Connect(DropdownDisplay.MouseButton1Click, function()
                    IsOpen = not IsOpen
                    DropdownList.Visible = IsOpen
                    Arrow.Text = IsOpen and "▲" or "▼"
                    
                    if IsOpen then
                        UpdateList()
                    end
                end)
                
                -- Hover effects
                Library:Connect(DropdownFrame.MouseEnter, function()
                    Library:Tween(DropdownFrame, {BackgroundTransparency = 0.05}, 0.15)
                end)
                
                Library:Connect(DropdownFrame.MouseLeave, function()
                    Library:Tween(DropdownFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
                end)
                
                Dropdown.Frame = DropdownFrame
                Dropdown.SetValues = function(values)
                    config.Values = values
                    UpdateList()
                end
                Dropdown.GetValue = function()
                    return SelectedValue
                end
                Dropdown.SetValue = function(value)
                    if table.find(config.Values or {}, value) then
                        SelectedValue = value
                        DropdownDisplay.Text = value
                        Library:SafeCallback(config.Callback, value)
                    end
                end
                
                UpdateList()
                return Dropdown
            end

            function Section:AddButton(config)
                local Button = {}
                
                -- Button frame with transparency
                local BtnFrame = Instance.new("TextButton")
                BtnFrame.Name = config.Title or "Button"
                BtnFrame.Size = UDim2.new(1, 0, 0, config.Description and 55 or 40)
                BtnFrame.BackgroundColor3 = Theme.Element
                BtnFrame.BackgroundTransparency = Theme.ElementTransparency
                BtnFrame.Text = ""
                BtnFrame.BorderSizePixel = 0
                BtnFrame.Parent = SectionFrame
                
                local BtnCorner = Instance.new("UICorner")
                BtnCorner.CornerRadius = UDim.new(0, 8)
                BtnCorner.Parent = BtnFrame
                
                local BtnStroke = Instance.new("UIStroke")
                BtnStroke.Color = Theme.ElementBorder
                BtnStroke.Transparency = 0.5
                BtnStroke.Parent = BtnFrame
                
                -- Title
                local BtnTitle = Instance.new("TextLabel")
                BtnTitle.Text = config.Title or "Button"
                BtnTitle.Font = Enum.Font.GothamMedium
                BtnTitle.TextSize = 14
                BtnTitle.TextColor3 = Theme.Text
                BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
                BtnTitle.Size = UDim2.new(1, -40, 0, 18)
                BtnTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 11)
                BtnTitle.BackgroundTransparency = 1
                BtnTitle.Parent = BtnFrame
                
                -- Description
                if config.Description then
                    local BtnDesc = Instance.new("TextLabel")
                    BtnDesc.Text = config.Description
                    BtnDesc.Font = Enum.Font.Gotham
                    BtnDesc.TextSize = 12
                    BtnDesc.TextColor3 = Theme.SubText
                    BtnDesc.TextXAlignment = Enum.TextXAlignment.Left
                    BtnDesc.Size = UDim2.new(1, -40, 0, 16)
                    BtnDesc.Position = UDim2.fromOffset(12, 28)
                    BtnDesc.BackgroundTransparency = 1
                    BtnDesc.TextWrapped = true
                    BtnDesc.Parent = BtnFrame
                end
                
                -- Arrow icon
                local Arrow = Instance.new("TextLabel")
                Arrow.Text = "→"
                Arrow.Font = Enum.Font.GothamBold
                Arrow.TextSize = 18
                Arrow.TextColor3 = Theme.Accent
                Arrow.Size = UDim2.fromOffset(24, 24)
                Arrow.Position = UDim2.new(1, -30, 0.5, -12)
                Arrow.BackgroundTransparency = 1
                Arrow.Parent = BtnFrame
                
                -- Click functionality
                Library:Connect(BtnFrame.MouseButton1Click, function()
                    -- Visual feedback
                    Library:Tween(Arrow, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
                    wait(0.1)
                    Library:Tween(Arrow, {TextColor3 = Theme.Accent}, 0.1)
                    
                    -- Execute callback
                    Library:SafeCallback(config.Callback)
                end)
                
                -- Hover effects
                Library:Connect(BtnFrame.MouseEnter, function()
                    Library:Tween(BtnFrame, {BackgroundTransparency = 0.05}, 0.15)
                    Library:Tween(Arrow, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                end)
                
                Library:Connect(BtnFrame.MouseLeave, function()
                    Library:Tween(BtnFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
                    Library:Tween(Arrow, {TextColor3 = Theme.Accent}, 0.15)
                end)
                
                Button.Frame = BtnFrame
                Button.SetTitle = function(title)
                    BtnTitle.Text = title
                end
                Button.SetDescription = function(desc)
                    if BtnDesc then
                        BtnDesc.Text = desc or ""
                    end
                end
                
                return Button
            end
            
            return Section
        end
        
        -- Direct tab functions for non-section elements
        function Tab:AddButton(config)
            local Button = {}
            
            -- Button frame with transparency
            local BtnFrame = Instance.new("TextButton")
            BtnFrame.Name = config.Title or "Button"
            BtnFrame.Size = UDim2.new(1, 0, 0, config.Description and 55 or 40)
            BtnFrame.BackgroundColor3 = Theme.Element
            BtnFrame.BackgroundTransparency = Theme.ElementTransparency
            BtnFrame.Text = ""
            BtnFrame.BorderSizePixel = 0
            BtnFrame.Parent = TabContent
            
            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 8)
            BtnCorner.Parent = BtnFrame
            
            local BtnStroke = Instance.new("UIStroke")
            BtnStroke.Color = Theme.ElementBorder
            BtnStroke.Transparency = 0.5
            BtnStroke.Parent = BtnFrame
            
            -- Title
            local BtnTitle = Instance.new("TextLabel")
            BtnTitle.Text = config.Title or "Button"
            BtnTitle.Font = Enum.Font.GothamMedium
            BtnTitle.TextSize = 14
            BtnTitle.TextColor3 = Theme.Text
            BtnTitle.TextXAlignment = Enum.TextXAlignment.Left
            BtnTitle.Size = UDim2.new(1, -40, 0, 18)
            BtnTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 11)
            BtnTitle.BackgroundTransparency = 1
            BtnTitle.Parent = BtnFrame
            
            -- Description
            if config.Description then
                local BtnDesc = Instance.new("TextLabel")
                BtnDesc.Text = config.Description
                BtnDesc.Font = Enum.Font.Gotham
                BtnDesc.TextSize = 12
                BtnDesc.TextColor3 = Theme.SubText
                BtnDesc.TextXAlignment = Enum.TextXAlignment.Left
                BtnDesc.Size = UDim2.new(1, -40, 0, 16)
                BtnDesc.Position = UDim2.fromOffset(12, 28)
                BtnDesc.BackgroundTransparency = 1
                BtnDesc.TextWrapped = true
                BtnDesc.Parent = BtnFrame
            end
            
            -- Arrow icon
            local Arrow = Instance.new("TextLabel")
            Arrow.Text = "→"
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextSize = 18
            Arrow.TextColor3 = Theme.Accent
            Arrow.Size = UDim2.fromOffset(24, 24)
            Arrow.Position = UDim2.new(1, -30, 0.5, -12)
            Arrow.BackgroundTransparency = 1
            Arrow.Parent = BtnFrame
            
            -- Click functionality
            Library:Connect(BtnFrame.MouseButton1Click, function()
                -- Visual feedback
                Library:Tween(Arrow, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.1)
                wait(0.1)
                Library:Tween(Arrow, {TextColor3 = Theme.Accent}, 0.1)
                
                -- Execute callback
                Library:SafeCallback(config.Callback)
            end)
            
            -- Hover effects
            Library:Connect(BtnFrame.MouseEnter, function()
                Library:Tween(BtnFrame, {BackgroundTransparency = 0.05}, 0.15)
                Library:Tween(Arrow, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
            end)
            
            Library:Connect(BtnFrame.MouseLeave, function()
                Library:Tween(BtnFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
                Library:Tween(Arrow, {TextColor3 = Theme.Accent}, 0.15)
            end)
            
            Button.Frame = BtnFrame
            Button.SetTitle = function(title)
                BtnTitle.Text = title
            end
            Button.SetDescription = function(desc)
                if BtnDesc then
                    BtnDesc.Text = desc or ""
                end
            end
            
            return Button
        end
        
        function Tab:AddToggle(config)
            local Toggle = {}
            
            -- Toggle frame with transparency
            local ToggleFrame = Instance.new("TextButton")
            ToggleFrame.Name = config.Title or "Toggle"
            ToggleFrame.Size = UDim2.new(1, 0, 0, config.Description and 55 or 40)
            ToggleFrame.BackgroundColor3 = Theme.Element
            ToggleFrame.BackgroundTransparency = Theme.ElementTransparency
            ToggleFrame.Text = ""
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 8)
            ToggleCorner.Parent = ToggleFrame
            
            local ToggleStroke = Instance.new("UIStroke")
            ToggleStroke.Color = Theme.ElementBorder
            ToggleStroke.Transparency = 0.5
            ToggleStroke.Parent = ToggleFrame
            
            -- Title
            local ToggleTitle = Instance.new("TextLabel")
            ToggleTitle.Text = config.Title or "Toggle"
            ToggleTitle.Font = Enum.Font.GothamMedium
            ToggleTitle.TextSize = 14
            ToggleTitle.TextColor3 = Theme.Text
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
            ToggleTitle.Size = UDim2.new(1, -60, 0, 18)
            ToggleTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 11)
            ToggleTitle.BackgroundTransparency = 1
            ToggleTitle.Parent = ToggleFrame
            
            -- Description
            if config.Description then
                local ToggleDesc = Instance.new("TextLabel")
                ToggleDesc.Text = config.Description
                ToggleDesc.Font = Enum.Font.Gotham
                ToggleDesc.TextSize = 12
                ToggleDesc.TextColor3 = Theme.SubText
                ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
                ToggleDesc.Size = UDim2.new(1, -60, 0, 16)
                ToggleDesc.Position = UDim2.fromOffset(12, 28)
                ToggleDesc.BackgroundTransparency = 1
                ToggleDesc.TextWrapped = true
                ToggleDesc.Parent = ToggleFrame
            end
            
            -- Toggle switch
            local ToggleSlider = Instance.new("Frame")
            ToggleSlider.Size = UDim2.fromOffset(38, 20)
            ToggleSlider.Position = UDim2.new(1, -50, 0.5, -10)
            ToggleSlider.BackgroundColor3 = Theme.ElementBorder
            ToggleSlider.BackgroundTransparency = 0.3
            ToggleSlider.BorderSizePixel = 0
            ToggleSlider.Parent = ToggleFrame
            
            local SliderCorner = Instance.new("UICorner")
            SliderCorner.CornerRadius = UDim.new(0, 10)
            SliderCorner.Parent = ToggleSlider
            
            -- Toggle circle
            local ToggleCircle = Instance.new("Frame")
            ToggleCircle.Size = UDim2.fromOffset(16, 16)
            ToggleCircle.Position = UDim2.fromOffset(2, 2)
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.BorderSizePixel = 0
            ToggleCircle.Parent = ToggleSlider
            
            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(0, 8)
            CircleCorner.Parent = ToggleCircle
            
            -- Toggle state
            local ToggleState = config.Default or false
            
            local function UpdateToggle()
                local TargetColor = ToggleState and Theme.Accent or Theme.ElementBorder
                local TargetPos = ToggleState and UDim2.fromOffset(20, 2) or UDim2.fromOffset(2, 2)
                
                Library:Tween(ToggleSlider, {BackgroundColor3 = TargetColor}, 0.25)
                Library:Tween(ToggleCircle, {Position = TargetPos}, 0.25)
            end
            
            -- Click functionality
            Library:Connect(ToggleFrame.MouseButton1Click, function()
                ToggleState = not ToggleState
                UpdateToggle()
                Library:SafeCallback(config.Callback, ToggleState)
            end)
            
            -- Hover effects
            Library:Connect(ToggleFrame.MouseEnter, function()
                Library:Tween(ToggleFrame, {BackgroundTransparency = 0.05}, 0.15)
            end)
            
            Library:Connect(ToggleFrame.MouseLeave, function()
                Library:Tween(ToggleFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
            end)
            
            UpdateToggle()
            
            Toggle.Frame = ToggleFrame
            Toggle.SetValue = function(value)
                ToggleState = value
                UpdateToggle()
                Library:SafeCallback(config.Callback, ToggleState)
            end
            Toggle.GetValue = function()
                return ToggleState
            end
            
            return Toggle
        end
        
        function Tab:AddDropdown(config)
            local Dropdown = {}
            
            -- Dropdown frame
            local DropdownFrame = Instance.new("TextButton")
            DropdownFrame.Name = config.Title or "Dropdown"
            DropdownFrame.Size = UDim2.new(1, 0, 0, config.Description and 55 or 40)
            DropdownFrame.BackgroundColor3 = Theme.Element
            DropdownFrame.BackgroundTransparency = Theme.ElementTransparency
            DropdownFrame.Text = ""
            DropdownFrame.BorderSizePixel = 0
            DropdownFrame.Parent = TabContent
            
            local DropdownCorner = Instance.new("UICorner")
            DropdownCorner.CornerRadius = UDim.new(0, 8)
            DropdownCorner.Parent = DropdownFrame
            
            local DropdownStroke = Instance.new("UIStroke")
            DropdownStroke.Color = Theme.ElementBorder
            DropdownStroke.Transparency = 0.5
            DropdownStroke.Parent = DropdownFrame
            
            -- Title
            local DropdownTitle = Instance.new("TextLabel")
            DropdownTitle.Text = config.Title or "Dropdown"
            DropdownTitle.Font = Enum.Font.GothamMedium
            DropdownTitle.TextSize = 14
            DropdownTitle.TextColor3 = Theme.Text
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left
            DropdownTitle.Size = UDim2.new(1, -40, 0, 18)
            DropdownTitle.Position = UDim2.fromOffset(12, config.Description and 8 or 11)
            DropdownTitle.BackgroundTransparency = 1
            DropdownTitle.Parent = DropdownFrame
            
            -- Description
            if config.Description then
                local DropdownDesc = Instance.new("TextLabel")
                DropdownDesc.Text = config.Description
                DropdownDesc.Font = Enum.Font.Gotham
                DropdownDesc.TextSize = 12
                DropdownDesc.TextColor3 = Theme.SubText
                DropdownDesc.TextXAlignment = Enum.TextXAlignment.Left
                DropdownDesc.Size = UDim2.new(1, -40, 0, 16)
                DropdownDesc.Position = UDim2.fromOffset(12, 28)
                DropdownDesc.BackgroundTransparency = 1
                DropdownDesc.TextWrapped = true
                DropdownDesc.Parent = DropdownFrame
            end
            
            -- Dropdown display
            local DropdownDisplay = Instance.new("TextButton")
            DropdownDisplay.Size = UDim2.fromOffset(120, 28)
            DropdownDisplay.Position = UDim2.new(1, -130, 0.5, -14)
            DropdownDisplay.BackgroundColor3 = Theme.Background
            DropdownDisplay.BackgroundTransparency = 0.2
            DropdownDisplay.Text = config.Default or "Select..."
            DropdownDisplay.TextColor3 = Theme.Text
            DropdownDisplay.TextSize = 12
            DropdownDisplay.Font = Enum.Font.Gotham
            DropdownDisplay.BorderSizePixel = 0
            DropdownDisplay.Parent = DropdownFrame
            
            local DisplayCorner = Instance.new("UICorner")
            DisplayCorner.CornerRadius = UDim.new(0, 6)
            DisplayCorner.Parent = DropdownDisplay
            
            local DisplayStroke = Instance.new("UIStroke")
            DisplayStroke.Color = Theme.ElementBorder
            DisplayStroke.Transparency = 0.6
            DisplayStroke.Parent = DropdownDisplay
            
            -- Arrow
            local Arrow = Instance.new("TextLabel")
            Arrow.Text = "▼"
            Arrow.Font = Enum.Font.GothamBold
            Arrow.TextSize = 10
            Arrow.TextColor3 = Theme.SubText
            Arrow.Size = UDim2.fromOffset(16, 16)
            Arrow.Position = UDim2.new(1, -20, 0.5, -8)
            Arrow.BackgroundTransparency = 1
            Arrow.Parent = DropdownDisplay
            
            -- Dropdown list
            local DropdownList = Instance.new("Frame")
            DropdownList.Size = UDim2.fromOffset(120, 0)
            DropdownList.Position = UDim2.new(1, -130, 1, 5)
            DropdownList.BackgroundColor3 = Theme.Background
            DropdownList.BackgroundTransparency = 0.1
            DropdownList.BorderSizePixel = 0
            DropdownList.Visible = false
            DropdownList.Parent = DropdownFrame
            DropdownList.ZIndex = 100
            
            local ListCorner = Instance.new("UICorner")
            ListCorner.CornerRadius = UDim.new(0, 6)
            ListCorner.Parent = DropdownList
            
            local ListStroke = Instance.new("UIStroke")
            ListStroke.Color = Theme.ElementBorder
            ListStroke.Transparency = 0.4
            ListStroke.Parent = DropdownList
            
            local ListLayout = Instance.new("UIListLayout")
            ListLayout.Padding = UDim.new(0, 2)
            ListLayout.Parent = DropdownList
            
            local ListPadding = Instance.new("UIPadding")
            ListPadding.PaddingTop = UDim.new(0, 4)
            ListPadding.PaddingBottom = UDim.new(0, 4)
            ListPadding.PaddingLeft = UDim.new(0, 4)
            ListPadding.PaddingRight = UDim.new(0, 4)
            ListPadding.Parent = DropdownList
            
            -- State
            local IsOpen = false
            local SelectedValue = config.Default
            
            local function UpdateList()
                -- Clear existing options
                for _, child in pairs(DropdownList:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                -- Add options
                for _, option in pairs(config.Values or {}) do
                    local OptionBtn = Instance.new("TextButton")
                    OptionBtn.Size = UDim2.new(1, 0, 0, 24)
                    OptionBtn.BackgroundColor3 = Theme.Element
                    OptionBtn.BackgroundTransparency = 0.8
                    OptionBtn.Text = option
                    OptionBtn.TextColor3 = Theme.Text
                    OptionBtn.TextSize = 11
                    OptionBtn.Font = Enum.Font.Gotham
                    OptionBtn.TextXAlignment = Enum.TextXAlignment.Left
                    OptionBtn.BorderSizePixel = 0
                    OptionBtn.Parent = DropdownList
                    
                    local OptionCorner = Instance.new("UICorner")
                    OptionCorner.CornerRadius = UDim.new(0, 4)
                    OptionCorner.Parent = OptionBtn
                    
                    local OptionPadding = Instance.new("UIPadding")
                    OptionPadding.PaddingLeft = UDim.new(0, 8)
                    OptionPadding.Parent = OptionBtn
                    
                    Library:Connect(OptionBtn.MouseButton1Click, function()
                        SelectedValue = option
                        DropdownDisplay.Text = option
                        IsOpen = false
                        DropdownList.Visible = false
                        Arrow.Text = "▼"
                        Library:SafeCallback(config.Callback, option)
                    end)
                    
                    Library:Connect(OptionBtn.MouseEnter, function()
                        Library:Tween(OptionBtn, {BackgroundTransparency = 0.5}, 0.1)
                    end)
                    
                    Library:Connect(OptionBtn.MouseLeave, function()
                        Library:Tween(OptionBtn, {BackgroundTransparency = 0.8}, 0.1)
                    end)
                end
                
                -- Update list size
                DropdownList.Size = UDim2.fromOffset(120, ListLayout.AbsoluteContentSize.Y + 8)
            end
            
            -- Toggle dropdown
            Library:Connect(DropdownDisplay.MouseButton1Click, function()
                IsOpen = not IsOpen
                DropdownList.Visible = IsOpen
                Arrow.Text = IsOpen and "▲" or "▼"
                
                if IsOpen then
                    UpdateList()
                end
            end)
            
            -- Hover effects
            Library:Connect(DropdownFrame.MouseEnter, function()
                Library:Tween(DropdownFrame, {BackgroundTransparency = 0.05}, 0.15)
            end)
            
            Library:Connect(DropdownFrame.MouseLeave, function()
                Library:Tween(DropdownFrame, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
            end)
            
            Dropdown.Frame = DropdownFrame
            Dropdown.SetValues = function(values)
                config.Values = values
                UpdateList()
            end
            Dropdown.GetValue = function()
                return SelectedValue
            end
            Dropdown.SetValue = function(value)
                if table.find(config.Values or {}, value) then
                    SelectedValue = value
                    DropdownDisplay.Text = value
                    Library:SafeCallback(config.Callback, value)
                end
            end
            
            UpdateList()
            return Dropdown
        end
        
        self.Tabs[TabName] = Tab
        
        -- Auto-select first tab
        if next(self.Tabs) and not self.CurrentTab then
            TabBtn.BackgroundColor3 = Theme.Hover
            TabBtn.BackgroundTransparency = 0.1
            TabContent.Visible = true
            self.TabDisplay.Text = TabName
            self.CurrentTab = Tab
        end
        
        return Tab
    end
    
    table.insert(Library.Windows, Window)
    return Window
end

-- Theme Functions
function Library:SetTheme(name)
    if Themes[name] then
        Theme = Themes[name]
        
        -- Update all windows
        for _, window in pairs(self.Windows) do
            if window.Main then
                window.Main.BackgroundColor3 = Theme.Background
                window.Main.BackgroundTransparency = Theme.BackgroundTransparency
            end
            
            -- Update tabs
            if window.TabScrollFrame then
                window.TabScrollFrame.ScrollBarImageColor3 = Theme.Accent
            end
            
            -- Update profile section
            local profile = window.Main:FindFirstChild("ProfileSection")
            if profile then
                profile.BackgroundColor3 = Theme.Element
                profile.BackgroundTransparency = Theme.ElementTransparency
            end
        end
        
        self:Notify({Title = "Theme", Content = "Changed to " .. name, Duration = 2})
    end
end

-- KEY SYSTEM INTEGRATION (COMPLETE WITH HIGHLIGHTED LOGO)
function Library:CreateKeySystem(config)
    assert(config.Key, "Key system requires a Key")
    
    local KeyFrame = Instance.new("Frame")
    KeyFrame.Name = "KeySystem"
    KeyFrame.Size = UDim2.fromOffset(450, 300)
    KeyFrame.Position = UDim2.fromScale(0.5, 0.5)
    KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    KeyFrame.BackgroundColor3 = Theme.Background
    KeyFrame.BackgroundTransparency = Theme.BackgroundTransparency
    KeyFrame.BorderSizePixel = 0
    KeyFrame.Parent = GUI
    KeyFrame.ZIndex = 5000
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = KeyFrame
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Theme.ElementBorder
    Stroke.Thickness = 1
    Stroke.Transparency = 0.3
    Stroke.Parent = KeyFrame
    
    -- Platoboost Logo (Top Right) with Highlight
    if config.ShowLogo ~= false then
        local LogoContainer = Instance.new("Frame")
        LogoContainer.Size = UDim2.fromOffset(50, 50)
        LogoContainer.Position = UDim2.new(1, -55, 0, 10)
        LogoContainer.BackgroundTransparency = 1
        LogoContainer.Parent = KeyFrame
        
        local Glow = Instance.new("ImageLabel")
        Glow.Size = UDim2.fromOffset(50, 50)
        Glow.Position = UDim2.fromOffset(0, 0)
        Glow.BackgroundTransparency = 0.50
        Glow.Image = "rbxassetid://18793315734"
        Glow.ImageColor3 = Theme.Accent
        Glow.ImageTransparency = 0.3
        Glow.ScaleType = Enum.ScaleType.Fit
        Glow.Parent = LogoContainer
        
        local GlowCorner = Instance.new("UICorner")
        GlowCorner.CornerRadius = UDim.new(0, 10)
        GlowCorner.Parent = Glow
        
        local LogoFrame = Instance.new("ImageLabel")
        LogoFrame.Size = UDim2.fromOffset(40, 40)
        LogoFrame.Position = UDim2.fromOffset(5, 5)
        LogoFrame.BackgroundColor3 = Theme.Element
        LogoFrame.BackgroundTransparency = Theme.ElementTransparency
        LogoFrame.Image = "rbxassetid://18793315734"
        LogoFrame.ScaleType = Enum.ScaleType.Fit
        LogoFrame.Parent = LogoContainer
        
        local LogoCorner = Instance.new("UICorner")
        LogoCorner.CornerRadius = UDim.new(0, 8)
        LogoCorner.Parent = LogoFrame
        
        local LogoStroke = Instance.new("UIStroke")
        LogoStroke.Color = Theme.Accent
        LogoStroke.Thickness = 2
        LogoStroke.Transparency = 0.5
        LogoStroke.Parent = LogoFrame
        
        spawn(function()
            while LogoFrame.Parent do
                Library:Tween(Glow, {ImageTransparency = 0.1}, 1)
                wait(1)
                Library:Tween(Glow, {ImageTransparency = 0.4}, 1)
                wait(1)
            end
        end)
    end
    
    local Title = Instance.new("TextLabel")
    Title.Text = config.Title or "Key System"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 24
    Title.TextColor3 = Theme.Text
    Title.Size = UDim2.new(1, -100, 0, 40)
    Title.Position = UDim2.fromOffset(15, 20)
    Title.BackgroundTransparency = 0.50
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = KeyFrame
    
    local Note = Instance.new("TextLabel")
    Note.Text = config.Note or "Enter your key to continue"
    Note.Font = Enum.Font.Gotham
    Note.TextSize = 14
    Note.TextColor3 = Theme.SubText
    Note.Size = UDim2.new(1, -30, 0, 30)
    Note.Position = UDim2.fromOffset(15, 70)
    Note.BackgroundTransparency = 0.50
    Note.TextXAlignment = Enum.TextXAlignment.Left
    Note.TextWrapped = true
    Note.Parent = KeyFrame
    
    local InputFrame = Instance.new("Frame")
    InputFrame.Size = UDim2.new(1, -30, 0, 45)
    InputFrame.Position = UDim2.fromOffset(15, 120)
    InputFrame.BackgroundColor3 = Theme.Element
    InputFrame.BackgroundTransparency = Theme.ElementTransparency
    InputFrame.BorderSizePixel = 0
    InputFrame.Parent = KeyFrame
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 8)
    InputCorner.Parent = InputFrame
    
    local InputStroke = Instance.new("UIStroke")
    InputStroke.Color = Theme.ElementBorder
    InputStroke.Transparency = 0.5
    InputStroke.Parent = InputFrame
    
    local Input = Instance.new("TextBox")
    Input.Size = UDim2.new(1, -20, 1, 0)
    Input.Position = UDim2.fromOffset(10, 0)
    Input.BackgroundTransparency = 1
    Input.PlaceholderText = "Enter your key..."
    Input.Text = ""
    Input.TextColor3 = Theme.Text
    Input.PlaceholderColor3 = Theme.SubText
    Input.Font = Enum.Font.Gotham
    Input.TextSize = 14
    Input.ClearTextOnFocus = false
    Input.Parent = InputFrame
    
    if config.GetKeyURL then
        local GetKeyBtn = Instance.new("TextButton")
        GetKeyBtn.Size = UDim2.new(0.48, 0, 0, 45)
        GetKeyBtn.Position = UDim2.fromOffset(15, 185)
        GetKeyBtn.BackgroundColor3 = Theme.Element
        GetKeyBtn.BackgroundTransparency = Theme.ElementTransparency
        GetKeyBtn.Text = "  Get Key"
        GetKeyBtn.TextColor3 = Theme.Text
        GetKeyBtn.Font = Enum.Font.GothamMedium
        GetKeyBtn.TextSize = 14
        GetKeyBtn.TextXAlignment = Enum.TextXAlignment.Left
        GetKeyBtn.BorderSizePixel = 0
        GetKeyBtn.Parent = KeyFrame
        
        local GetKeyCorner = Instance.new("UICorner")
        GetKeyCorner.CornerRadius = UDim.new(0, 8)
        GetKeyCorner.Parent = GetKeyBtn
        
        local GetKeyStroke = Instance.new("UIStroke")
        GetKeyStroke.Color = Theme.ElementBorder
        GetKeyStroke.Transparency = 0.5
        GetKeyStroke.Parent = GetKeyBtn
        
        local BtnIcon = Instance.new("ImageLabel")
        BtnIcon.Size = UDim2.fromOffset(20, 20)
        BtnIcon.Position = UDim2.new(1, -30, 0.5, -10)
        BtnIcon.BackgroundTransparency = 0.55
        BtnIcon.Image = "rbxassetid://114406344636087"
        BtnIcon.Parent = GetKeyBtn
        
        Library:Connect(GetKeyBtn.MouseButton1Click, function()
            setclipboard(config.GetKeyURL)
            Library:Notify({
                Title = "Copied",
                Content = "Key link copied to clipboard!",
                Duration = 2,
                Vibrate = true
            })
        end)
        
        Library:Connect(GetKeyBtn.MouseEnter, function()
            Library:Tween(GetKeyBtn, {BackgroundTransparency = 0.05}, 0.15)
        end)
        
        Library:Connect(GetKeyBtn.MouseLeave, function()
            Library:Tween(GetKeyBtn, {BackgroundTransparency = Theme.ElementTransparency}, 0.15)
        end)
    end
    
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(config.GetKeyURL and 0.48 or 1, config.GetKeyURL and 0 or -30, 0, 45)
    SubmitBtn.Position = config.GetKeyURL and UDim2.new(1, -15, 0, 185) or UDim2.fromOffset(15, 185)
    SubmitBtn.AnchorPoint = config.GetKeyURL and Vector2.new(1, 0) or Vector2.new(0, 0)
    SubmitBtn.BackgroundColor3 = Theme.Accent
    SubmitBtn.BackgroundTransparency = 0.1
    SubmitBtn.Text = "Submit"
    SubmitBtn.TextColor3 = Color3.new(1, 1, 1)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 14
    SubmitBtn.BorderSizePixel = 0
    SubmitBtn.Parent = KeyFrame
    
    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 8)
    SubmitCorner.Parent = SubmitBtn
    
    Library:Connect(SubmitBtn.MouseButton1Click, function()
        local enteredKey = Input.Text
        local isValid = false
        
        if type(config.Key) == "table" then
            isValid = table.find(config.Key, enteredKey) ~= nil
        else
            isValid = config.Key == enteredKey
        end
        
        if isValid then
            Library:Notify({
                Title = "Success",
                Content = "Key accepted! Loading...",
                Duration = 2,
                Vibrate = true
            })
            KeyFrame:Destroy()
            if config.Callback then
                config.Callback()
            end
        else
            Library:Notify({
                Title = "Invalid Key",
                Content = "Please enter a valid key",
                Duration = 2,
                Vibrate = true
            })
            Input.Text = ""
        end
    end)
    
    Library:Connect(SubmitBtn.MouseEnter, function()
        Library:Tween(SubmitBtn, {BackgroundTransparency = 0.05}, 0.15)
    end)
    
    Library:Connect(SubmitBtn.MouseLeave, function()
        Library:Tween(SubmitBtn, {BackgroundTransparency = 0.1}, 0.15)
    end)
    
    MakeDraggable(KeyFrame, KeyFrame)
end

return Library
