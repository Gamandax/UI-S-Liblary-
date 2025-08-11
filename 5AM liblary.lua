-- Made by Unknown 
-- Credits to owner 

local FiveAMHub = {}
FiveAMHub.__index = FiveAMHub

local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

local Config = {
    key = "Test",
    useKeySystem = true,
    hubName = "5AM Hub",
    keySystemName = "5AM Hub Key System",
    getKeyLink = "https://example.com/getkey"
}

local TabSystem = {
    tabs = {},
    currentGui = nil,
    tabButtons = {},
    contentFrames = {}
}

local function showNotification(message)
    StarterGui:SetCore("SendNotification", {
        Title = Config.hubName,
        Text = message,
        Duration = 3
    })
end

local function createLoader(callback)
    local LoaderGui = Instance.new("ScreenGui")
    LoaderGui.Name = "FiveAMLoader"
    LoaderGui.ResetOnSpawn = false
    LoaderGui.Parent = CoreGui

    local Background = Instance.new("Frame")
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.Position = UDim2.new(0, 0, 0, 0)
    Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Background.BackgroundTransparency = 0.3
    Background.Parent = LoaderGui

    local LoaderFrame = Instance.new("Frame")
    LoaderFrame.Size = UDim2.new(0, 350, 0, 200)
    LoaderFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
    LoaderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    LoaderFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    LoaderFrame.BorderSizePixel = 2
    LoaderFrame.Parent = LoaderGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = LoaderFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Position = UDim2.new(0, 0, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = Config.hubName .. " - Loading..."
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 20
    Title.Parent = LoaderFrame

    local ProgressBG = Instance.new("Frame")
    ProgressBG.Size = UDim2.new(0, 280, 0, 20)
    ProgressBG.Position = UDim2.new(0.5, -140, 0, 80)
    ProgressBG.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ProgressBG.BorderSizePixel = 0
    ProgressBG.Parent = LoaderFrame

    local ProgressBGCorner = Instance.new("UICorner")
    ProgressBGCorner.CornerRadius = UDim.new(0, 10)
    ProgressBGCorner.Parent = ProgressBG

    local ProgressFill = Instance.new("Frame")
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    ProgressFill.Position = UDim2.new(0, 0, 0, 0)
    ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    ProgressFill.BorderSizePixel = 0
    ProgressFill.Parent = ProgressBG

    local ProgressFillCorner = Instance.new("UICorner")
    ProgressFillCorner.CornerRadius = UDim.new(0, 10)
    ProgressFillCorner.Parent = ProgressFill

    local StatusText = Instance.new("TextLabel")
    StatusText.Size = UDim2.new(1, 0, 0, 30)
    StatusText.Position = UDim2.new(0, 0, 0, 110)
    StatusText.BackgroundTransparency = 1
    StatusText.Text = "Initializing..."
    StatusText.TextColor3 = Color3.fromRGB(200, 200, 200)
    StatusText.Font = Enum.Font.Gotham
    StatusText.TextSize = 16
    StatusText.Parent = LoaderFrame

    local SpinIcon = Instance.new("TextLabel")
    SpinIcon.Size = UDim2.new(0, 30, 0, 30)
    SpinIcon.Position = UDim2.new(0.5, -15, 0, 145)
    SpinIcon.BackgroundTransparency = 1
    SpinIcon.Text = "⟳"
    SpinIcon.TextColor3 = Color3.fromRGB(0, 150, 255)
    SpinIcon.Font = Enum.Font.GothamBold
    SpinIcon.TextSize = 24
    SpinIcon.Parent = LoaderFrame

    local spinConnection
    spinConnection = game:GetService("RunService").Heartbeat:Connect(function()
        SpinIcon.Rotation = SpinIcon.Rotation + 5
    end)

    local steps = {
        {text = "Initializing...", duration = 0.5},
        {text = "Loading services...", duration = 0.8},
        {text = "Setting up GUI...", duration = 1.2},
        {text = "Checking permissions...", duration = 0.7},
        {text = "Finalizing...", duration = 0.6}
    }

    local function animateLoading()
        local totalSteps = #steps
        local currentStep = 0

        for i, step in ipairs(steps) do
            StatusText.Text = step.text
          
            local targetWidth = (i / totalSteps) * 280
            local tween = game:GetService("TweenService"):Create(
                ProgressFill,
                TweenInfo.new(step.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, targetWidth, 1, 0)}
            )
            tween:Play()
            
            wait(step.duration)
        end

        
        StatusText.Text = "Complete!"
        wait(0.3)
        
        
        spinConnection:Disconnect()
        LoaderGui:Destroy()
        
        
        if callback then
            callback()
        end
    end

    spawn(animateLoading)
    
    return LoaderGui
end

local function cleanupOldGUIs()
    for _, name in ipairs({"FiveAMKeySystem", "FiveAMHub", "ToggleGuiButton"}) do
        local existing = CoreGui:FindFirstChild(name)
        if existing then 
            existing:Destroy() 
        end
    end
end

local function createMainGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FiveAMHub"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui
    TabSystem.currentGui = ScreenGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 300)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Frame.BorderSizePixel = 2
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = Config.hubName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    closeBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    closeBtn.BorderSizePixel = 2
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.Parent = Frame
    closeBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        TabSystem.currentGui = nil
    end)

    local TabBar = Instance.new("Frame")
    TabBar.Size = UDim2.new(1, 0, 0, 35)
    TabBar.Position = UDim2.new(0, 0, 0, 35)
    TabBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TabBar.BorderColor3 = Color3.fromRGB(100, 100, 100)
    TabBar.BorderSizePixel = 2
    TabBar.Parent = Frame

    TabSystem.tabButtons = {}
    TabSystem.contentFrames = {}

    local function updateTabs()
        
        for _, child in ipairs(TabBar:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
      
        for _, child in ipairs(Frame:GetChildren()) do
            if child.Name == "TabContent" then
                child:Destroy()
            end
        end

        if #TabSystem.tabs == 0 then
            
            local noTabsLabel = Instance.new("TextLabel")
            noTabsLabel.Size = UDim2.new(1, -20, 1, -80)
            noTabsLabel.Position = UDim2.new(0, 10, 0, 75)
            noTabsLabel.BackgroundTransparency = 1
            noTabsLabel.Text = "No tabs added yet.\nUse FiveAMHub:AddTab() to add tabs!"
            noTabsLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            noTabsLabel.Font = Enum.Font.Gotham
            noTabsLabel.TextSize = 16
            noTabsLabel.TextWrapped = true
            noTabsLabel.Parent = Frame
            return
        end

        local tabWidth = Frame.Size.X.Offset / #TabSystem.tabs

        for i, tab in ipairs(TabSystem.tabs) do
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0, tabWidth, 1, 0)
            btn.Position = UDim2.new(0, (i-1)*tabWidth, 0, 0)
            btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(20, 20, 20)
            btn.BorderColor3 = Color3.fromRGB(100, 100, 100)
            btn.BorderSizePixel = 2
            btn.Text = tab.name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 16
            btn.Parent = TabBar
            TabSystem.tabButtons[tab.name] = btn

            local content = Instance.new("Frame")
            content.Name = "TabContent"
            content.Size = UDim2.new(1, -20, 1, -80)
            content.Position = UDim2.new(0, 10, 0, 75)
            content.BackgroundTransparency = 1
            content.Visible = (i == 1)
            content.Parent = Frame
            TabSystem.contentFrames[tab.name] = content

            if tab.callback then
                tab.callback(content)
            end
        end

        for name, button in pairs(TabSystem.tabButtons) do
            button.MouseButton1Click:Connect(function()
                for n, frame in pairs(TabSystem.contentFrames) do
                    frame.Visible = false
                    TabSystem.tabButtons[n].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                end
                TabSystem.contentFrames[name].Visible = true
                button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            end)
        end
    end

    updateTabs()
    return ScreenGui
end

local function createKeySystemGui()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FiveAMKeySystem"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 400, 0, 200)
    Frame.Position = UDim2.new(0.5, -200, 0.5, -100)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    Frame.BorderSizePixel = 2
    Frame.Active = true
    Frame.Draggable = true
    Frame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -40, 0, 35)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = Config.keySystemName
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextScaled = true
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 2)
    closeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    closeBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    closeBtn.BorderSizePixel = 2
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.Parent = Frame
    closeBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0, 300, 0, 40)
    keyBox.Position = UDim2.new(0.5, -150, 0, 50)
    keyBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    keyBox.BorderColor3 = Color3.fromRGB(100, 100, 100)
    keyBox.BorderSizePixel = 2
    keyBox.PlaceholderText = "Enter Key Here"
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 18
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = Frame

    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0, 140, 0, 40)
    checkBtn.Position = UDim2.new(0.5, -150, 0, 110)
    checkBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    checkBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    checkBtn.BorderSizePixel = 2
    checkBtn.Text = "Check Key"
    checkBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextSize = 18
    checkBtn.Parent = Frame

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0, 140, 0, 40)
    getKeyBtn.Position = UDim2.new(0.5, 10, 0, 110)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    getKeyBtn.BorderColor3 = Color3.fromRGB(100, 100, 100)
    getKeyBtn.BorderSizePixel = 2
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 18
    getKeyBtn.Parent = Frame

    checkBtn.MouseButton1Click:Connect(function()
        if keyBox.Text == Config.key then
            showNotification("Valid Key! Loading Hub...")
            ScreenGui:Destroy()
            createMainGui()
        else
            showNotification("Invalid Key!")
        end
    end)

    getKeyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(Config.getKeyLink)
            showNotification("Link copied to clipboard!")
        else
            showNotification("Clipboard not supported on this executor!")
        end
    end)

    return ScreenGui
end

function FiveAMHub:Init(settings)
    settings = settings or {}
  
    if settings.key then Config.key = settings.key end
    if settings.useKeySystem ~= nil then Config.useKeySystem = settings.useKeySystem end
    if settings.hubName then Config.hubName = settings.hubName end
    if settings.keySystemName then Config.keySystemName = settings.keySystemName end
    if settings.getKeyLink then Config.getKeyLink = settings.getKeyLink end
  
    cleanupOldGUIs()
  
    createLoader(function()
        if Config.useKeySystem then
            createKeySystemGui()
            showNotification("Key system loaded!")
        else
            createMainGui()
            showNotification("Hub loaded successfully!")
        end
    end)
end

function FiveAMHub:LoadHub()
    cleanupOldGUIs()
    createLoader(function()
        createMainGui()
        showNotification("Hub loaded!")
    end)
end

function FiveAMHub:LoadKeySystem()
    cleanupOldGUIs()
    createLoader(function()
        createKeySystemGui()
        showNotification("Key system loaded!")
    end)
end

function FiveAMHub:AddTab(tabName, callback)
    
    table.insert(TabSystem.tabs, {
        name = tabName,
        callback = callback
    })
    
    
    if TabSystem.currentGui then
        
        local frame = TabSystem.currentGui:FindFirstChild("Frame")
        if frame then
            
            local TabBar = frame:FindFirstChild("Frame") -- Tab bar is the first frame
            if TabBar then
                
                TabSystem.tabButtons = {}
                TabSystem.contentFrames = {}

                for _, child in ipairs(TabBar:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
              
                for _, child in ipairs(frame:GetChildren()) do
                    if child.Name == "TabContent" then
                        child:Destroy()
                    end
                end

                local tabWidth = frame.Size.X.Offset / #TabSystem.tabs

                for i, tab in ipairs(TabSystem.tabs) do
                    
                    local btn = Instance.new("TextButton")
                    btn.Size = UDim2.new(0, tabWidth, 1, 0)
                    btn.Position = UDim2.new(0, (i-1)*tabWidth, 0, 0)
                    btn.BackgroundColor3 = (i == 1) and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(20, 20, 20)
                    btn.BorderColor3 = Color3.fromRGB(100, 100, 100)
                    btn.BorderSizePixel = 2
                    btn.Text = tab.name
                    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    btn.Font = Enum.Font.GothamBold
                    btn.TextSize = 16
                    btn.Parent = TabBar
                    TabSystem.tabButtons[tab.name] = btn

                    local content = Instance.new("Frame")
                    content.Name = "TabContent"
                    content.Size = UDim2.new(1, -20, 1, -80)
                    content.Position = UDim2.new(0, 10, 0, 75)
                    content.BackgroundTransparency = 1
                    content.Visible = (i == 1)
                    content.Parent = frame
                    TabSystem.contentFrames[tab.name] = content

                    if tab.callback then
                        tab.callback(content)
                    end
                end

                for name, button in pairs(TabSystem.tabButtons) do
                    button.MouseButton1Click:Connect(function()
                        for n, frameContent in pairs(TabSystem.contentFrames) do
                            frameContent.Visible = false
                            TabSystem.tabButtons[n].BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                        end
                        TabSystem.contentFrames[name].Visible = true
                        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    end)
                end
            end
        end
    end
    
    showNotification("Tab '" .. tabName .. "' added!")
end

function FiveAMHub:RemoveTab(tabName)
    for i, tab in ipairs(TabSystem.tabs) do
        if tab.name == tabName then
            table.remove(TabSystem.tabs, i)
            break
        end
    end

    if TabSystem.currentGui then
        self:AddTab("", nil)
        table.remove(TabSystem.tabs, #TabSystem.tabs)
    end
    
    showNotification("Tab '" .. tabName .. "' removed!")
end

function FiveAMHub:SetKey(newKey)
    Config.key = newKey
end

function FiveAMHub:GetTabs()
    return TabSystem.tabs
end

function FiveAMHub:GetConfig()
    return Config
end

function FiveAMHub:Destroy()
    cleanupOldGUIs()
    showNotification("Hub destroyed!")
end

return FiveAMHub
