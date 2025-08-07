-- Zyx liblary V2
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ModernGUILibrary = {}

-- Constants for Notification and UI
local FONT = Enum.Font.GothamBold
local CORNER_RADIUS = UDim.new(0, 6)
local COLORS = {
    Frame = Color3.fromRGB(35, 35, 40),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(114, 137, 218),
    Success = Color3.fromRGB(87, 242, 135),
    Error = Color3.fromRGB(255, 89, 89),
    Warning = Color3.fromRGB(255, 201, 79),
    Input = Color3.fromRGB(55, 55, 60),
}

-- Icon Loading
local FeatherIcons = {}

local function LoadFeatherIcons()
    local existingModule = ReplicatedStorage:FindFirstChild("FeatherIcons")
    if existingModule and existingModule:IsA("ModuleScript") then
        return require(existingModule)
    else
        local featherModule = Instance.new("ModuleScript")
        featherModule.Name = "FeatherIcons"
        featherModule.Parent = ReplicatedStorage
        local success, result = pcall(function()
            local url = "https://raw.githubusercontent.com/7kayoh/feather-roblox/main/src/Modules/asset.lua"
            return HttpService:GetAsync(url)
        end)
        if success then
            local moduleCode = result:gsub("^%s*return%s*", "local FeatherModule = ") .. "\n\nreturn FeatherModule"
            featherModule.Source = moduleCode
            return require(featherModule)
        else
            warn("Failed to load Feather icons from GitHub. Using fallback icons.")
            local fallbackSource = [[
                local FeatherModule = {
                    ["alert-circle"] = "rbxassetid://7072978559",
                    ["alert-octagon"] = "rbxassetid://7072978894",
                    ["alert-triangle"] = "rbxassetid://7072980286",
                    ["align-center"] = "rbxassetid://7072980488",
                    ["align-justify"] = "rbxassetid://7072980642",
                    ["align-left"] = "rbxassetid://7072980796",
                    ["align-right"] = "rbxassetid://7072980973"
                }
                return FeatherModule
            ]]
            featherModule.Source = fallbackSource
            return require(featherModule)
        end
    end
end

local function InitializeFeatherIcons()
    local success, result = pcall(LoadFeatherIcons)
    if success then
        FeatherIcons = result
        print("Successfully loaded Feather icons module")
    else
        warn("Failed to load Feather icons: " .. tostring(result))
        FeatherIcons = {
            ["alert-circle"] = "rbxassetid://7072978559",
            ["alert-octagon"] = "rbxassetid://7072978894",
            ["alert-triangle"] = "rbxassetid://7072980286",
            ["align-center"] = "rbxassetid://7072980488",
            ["align-justify"] = "rbxassetid://7072980642",
            ["align-left"] = "rbxassetid://7072980796",
            ["align-right"] = "rbxassetid://7072980973"
        }
    end
end

InitializeFeatherIcons()

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 375, 0, 300) -- Lebar diperbesar untuk TabContainer
MainFrame.Position = UDim2.new(0.5, -180, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Round the corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Text = "This is growwww"
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.Parent = TopBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Position = UDim2.new(1, -28, 0, 2)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 89, 89)
CloseButton.BorderSizePixel = 0
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "×"
CloseButton.TextSize = 16
CloseButton.Parent = TopBar
CloseButton.ZIndex = 2

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

local MinimizeButton = Instance.new("TextButton")
     MinimizeButton.Name = "MinimizeButton"
     MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
     MinimizeButton.Position = UDim2.new(1, -58, 0, 2) -- Positioned to the left of CloseButton (-28 - 25 - 5 for spacing)
     MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 201, 79) -- Yellow to distinguish from close button
     MinimizeButton.BorderSizePixel = 0
     MinimizeButton.Font = Enum.Font.GothamBold
     MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
     MinimizeButton.Text = "−"
     MinimizeButton.TextSize = 16
     MinimizeButton.Parent = TopBar
     MinimizeButton.ZIndex = 2

     local MinimizeCorner = Instance.new("UICorner")
     MinimizeCorner.CornerRadius = UDim.new(0, 5)
     MinimizeCorner.Parent = MinimizeButton
     
-- Tab Container
local TabContainer = Instance.new("Frame")
TabContainer.Name = "TabContainer"
TabContainer.Size = UDim2.new(0, 110, 1, -30)
TabContainer.Position = UDim2.new(0, 0, 0, 30)
TabContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = MainFrame

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.Parent = TabContainer

-- ScrollingFrame
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(1, -110, 1, -60) -- Dikurangi lebar TabContainer
ScrollingFrame.Position = UDim2.new(0, 110, 0, 30) -- Geser ke kanan
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.Parent = MainFrame

-- Content Frame (dihapus karena digantikan per tab)
-- local ContentFrame = Instance.new("Frame") -- Tidak lagi digunakan secara global

-- YouTube Label
local YouTubeLabel = Instance.new("TextLabel")
YouTubeLabel.Name = "YouTubeLabel"
YouTubeLabel.Size = UDim2.new(1, 0, 0, 30)
YouTubeLabel.Position = UDim2.new(0, 0, 1, -30)
YouTubeLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
YouTubeLabel.BorderSizePixel = 0
YouTubeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
YouTubeLabel.TextSize = 16
YouTubeLabel.Font = Enum.Font.GothamBold
YouTubeLabel.Text = "Youtube: Zysume"
YouTubeLabel.TextXAlignment = Enum.TextXAlignment.Left
YouTubeLabel.Parent = MainFrame
YouTubeLabel.ZIndex = 2
YouTubeLabel.Visible = true

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingLeft = UDim.new(0, 15)
UIPadding.Parent = YouTubeLabel

-- Tab Management
local tabContents = {}
local tabPositionY = {}
local tabContentHeights = {}
local activeTab = nil

local function createTabButton(tabName, iconName)
    local button = Instance.new("TextButton")
    button.Name = tabName .. "Tab"
    button.Size = UDim2.new(1, 0, 0, 30)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 14
    button.Parent = TabContainer
    
    local tabButtonCorner = Instance.new("UICorner")
tabButtonCorner.CornerRadius = UDim.new(0, 15)
tabButtonCorner.Parent = button

    if iconName and FeatherIcons[iconName] then
        -- Create icon at the left side
        local icon = Instance.new("ImageLabel")
        icon.Name = "Icon"
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 10, 0.5, -10)  -- Left position with 5px padding
        icon.BackgroundTransparency = 1
        icon.Image = FeatherIcons[iconName]
        icon.Parent = button
        
        -- Create a separate label for the text
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "TabLabel"
        textLabel.Size = UDim2.new(1, -30, 1, 0)  -- Full height, width minus icon space
        textLabel.Position = UDim2.new(0, 35, 0, 0)  -- 5px + 20px + 5px from left
        textLabel.BackgroundTransparency = 1
        textLabel.Font = Enum.Font.GothamBold
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.Text = tabName
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = button
        
        -- Set the button's text to empty since we're using a TextLabel
        button.Text = ""
    else
        -- If no icon, just use the button's text property
        button.Text = tabName
        button.TextXAlignment = Enum.TextXAlignment.Center
    end

    return button
end

local function setActiveTab(tabName)
    if activeTab == tabName then return end
    
    -- Reset previous tab button
    if activeTab then
        tabContents[activeTab].Visible = false
        local prevTabButton = TabContainer:FindFirstChild(activeTab .. "Tab")
        if prevTabButton then
            TweenService:Create(
                prevTabButton,
                TweenInfo.new(0.3),
                {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}
            ):Play()
            -- Remove highlight from previous tab
            local prevHighlight = prevTabButton:FindFirstChild("ActiveHighlight")
            if prevHighlight then
                TweenService:Create(
                    prevHighlight,
                    TweenInfo.new(0.3),
                    {BackgroundTransparency = 1}
                ):Play()
                game:GetService("Debris"):AddItem(prevHighlight, 0.3)
            end
        end
    end
    
    -- Set new tab as active with oval highlight
    activeTab = tabName
    tabContents[tabName].Visible = true
    
    local tabButton = TabContainer:FindFirstChild(tabName .. "Tab")
    if tabButton then
        -- Create oval highlight
        local highlight = Instance.new("Frame")
        highlight.Name = "ActiveHighlight"
        highlight.Size = UDim2.new(0.9, 0, 0.8, 0)
        highlight.Position = UDim2.new(0.05, 0, 0.1, 0)
        highlight.BackgroundColor3 = Color3.fromRGB(70, 200, 120)
        highlight.BackgroundTransparency = 0.2
        highlight.BorderSizePixel = 0
        highlight.ZIndex = tabButton.ZIndex - 1
        highlight.Parent = tabButton
        
        -- Make it oval-rectangle
        local highlightCorner = Instance.new("UICorner")
        highlightCorner.CornerRadius = UDim.new(0, 15)
        highlightCorner.Parent = highlight
        
        -- Animate highlight appearance
        highlight.BackgroundTransparency = 1
        TweenService:Create(
            highlight,
            TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.2}
        ):Play()
    end
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, tabContentHeights[tabName] or 0)
end

function ModernGUILibrary.MakeTab(config)
    local tabName = config.Name
    local iconName = config.Icon

    -- Create ContentFrame for this tab
    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName .. "Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Position = UDim2.new(0, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Parent = ScrollingFrame
    tabContent.Visible = false

    tabContents[tabName] = tabContent
    tabPositionY[tabName] = 10
    tabContentHeights[tabName] = 0

    -- Create Tab Button
    local tabButton = createTabButton(tabName, iconName)
    tabButton.MouseButton1Click:Connect(function()
        setActiveTab(tabName)
    end)

    -- Set first tab as active by default
    if not activeTab then
        setActiveTab(tabName)
    end

    -- Tab object
    local tab = {
        AddDropdown = function(name, labelText, options, defaultOption, position, callback)
            local pos = position or UDim2.new(0.05, 0, 0, tabPositionY[tabName])
            local dropdown, methods = ModernGUILibrary.createDropdown(name, labelText, options, defaultOption, pos, tabContent, callback)
            tabPositionY[tabName] = tabPositionY[tabName] + 35
            tabContentHeights[tabName] = tabPositionY[tabName]
            if activeTab == tabName then
                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, tabContentHeights[tabName])
            end
            return dropdown, methods
        end,
        AddCheckbox = function(name, text, position, onToggle)
            local pos = position or UDim2.new(0.05, 0, 0, tabPositionY[tabName])
            local checkbox, methods = ModernGUILibrary.createCheckbox(name, text, pos, tabContent, onToggle)
            tabPositionY[tabName] = tabPositionY[tabName] + 35
            tabContentHeights[tabName] = tabPositionY[tabName]
            if activeTab == tabName then
                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, tabContentHeights[tabName])
            end
            return checkbox, methods
        end,
        AddTextInput = function(name, labelText, defaultValue, position, onChange)
            local pos = position or UDim2.new(0.05, 0, 0, tabPositionY[tabName])
            local input, methods = ModernGUILibrary.createTextInput(name, labelText, defaultValue, pos, tabContent, onChange)
            tabPositionY[tabName] = tabPositionY[tabName] + 35
            tabContentHeights[tabName] = tabPositionY[tabName]
            if activeTab == tabName then
                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, tabContentHeights[tabName])
            end
            return input, methods
        end,
        AddButton = function(name, text, position, onClick, iconName)
            local pos = position or UDim2.new(0.05, 0, 0, tabPositionY[tabName])
            local button, btn = ModernGUILibrary.createButton(name, text, pos, tabContent, onClick, iconName)
            tabPositionY[tabName] = tabPositionY[tabName] + 35
            tabContentHeights[tabName] = tabPositionY[tabName]
            if activeTab == tabName then
                ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, tabContentHeights[tabName])
            end
            return button, btn
        end,
    }

    return tab
end

-- Function Definitions (unchanged except for createButton)
function ModernGUILibrary.createSection(sectionName, positionY, parent)
    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Name = sectionName .. "Label"
    sectionLabel.Size = UDim2.new(0.9, 0, 0, 25)
    sectionLabel.Position = UDim2.new(0.05, 0, 0, positionY)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionLabel.TextSize = 16
    sectionLabel.Font = Enum.Font.GothamBold
    sectionLabel.Text = sectionName
    sectionLabel.ZIndex = 1
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.Parent = parent

    local separator = Instance.new("Frame")
    separator.Name = sectionName .. "Separator"
    separator.Size = UDim2.new(0.9, 0, 0, 1)
    separator.Position = UDim2.new(0.05, 0, 0, positionY + 30)
    separator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    separator.BorderSizePixel = 0
    separator.Parent = parent

    return sectionLabel, separator
end

function ModernGUILibrary.createCheckbox(name, text, position, parent, onToggle)
    local checkboxContainer = Instance.new("Frame")
    checkboxContainer.Name = name .. "Container"
    checkboxContainer.Size = UDim2.new(0.9, 0, 0, 28)
    checkboxContainer.Position = position
    checkboxContainer.BackgroundTransparency = 1
    checkboxContainer.Parent = parent
    
    local checkboxBG = Instance.new("Frame")
    checkboxBG.Name = "Background"
    checkboxBG.Size = UDim2.new(0, 20, 0, 20)
    checkboxBG.Position = UDim2.new(1, -20, 0.5, -10)
    checkboxBG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    checkboxBG.BorderSizePixel = 0
    checkboxBG.Parent = checkboxContainer
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 5)
    checkboxCorner.Parent = checkboxBG
    
    local checkmark = Instance.new("Frame")
    checkmark.Name = "Checkmark"
    checkmark.Size = UDim2.new(0, 0, 0, 0)
    checkmark.AnchorPoint = Vector2.new(0.5, 0.5)
    checkmark.Position = UDim2.new(0.5, 0, 0.5, 0)
    checkmark.BackgroundColor3 = Color3.fromRGB(70, 200, 120)
    checkmark.BorderSizePixel = 0
    checkmark.Visible = true
    checkmark.Parent = checkboxBG
    
    local checkmarkCorner = Instance.new("UICorner")
    checkmarkCorner.CornerRadius = UDim.new(0, 3)
    checkmarkCorner.Parent = checkmark
    
    local checkboxLabel = Instance.new("TextLabel")
    checkboxLabel.Name = "Label"
    checkboxLabel.Size = UDim2.new(1, -28, 1, 0)
    checkboxLabel.Position = UDim2.new(0, 0, 0, 0)
    checkboxLabel.BackgroundTransparency = 1
    checkboxLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    checkboxLabel.TextSize = 14
    checkboxLabel.Font = FONT
    checkboxLabel.Text = text
    checkboxLabel.ZIndex = 1
    checkboxLabel.TextXAlignment = Enum.TextXAlignment.Left
    checkboxLabel.Parent = checkboxContainer
    
    local checkboxButton = Instance.new("TextButton")
    checkboxButton.Name = "Button"
    checkboxButton.Size = UDim2.new(1, 0, 1, 0)
    checkboxButton.BackgroundTransparency = 1
    checkboxButton.Text = ""
    checkboxButton.Parent = checkboxContainer
    
    local checked = false
    
    checkboxButton.MouseButton1Click:Connect(function()
        checked = not checked
        
        if checked then
            local expandTween = TweenService:Create(
                checkmark,
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0.8, 0, 0.8, 0)}
            )
            expandTween:Play()
            checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            local shrinkTween = TweenService:Create(
                checkmark,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            shrinkTween:Play()
            checkboxLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        end
        
        if onToggle then
            onToggle(checked)
        end
    end)
    
    return checkboxContainer, function() return checked end
end

function ModernGUILibrary.createTextInput(name, labelText, defaultValue, position, parent, onChange)
    local inputContainer = Instance.new("Frame")
    inputContainer.Name = name .. "Container"
    inputContainer.Size = UDim2.new(0.9, 0, 0, 32)
    inputContainer.Position = position
    inputContainer.BackgroundTransparency = 1
    inputContainer.Parent = parent
    
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Name = "Label"
    inputLabel.Size = UDim2.new(0.5, -10, 1, 0)
    inputLabel.BackgroundTransparency = 1
    inputLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    inputLabel.TextSize = 14
    inputLabel.Font = FONT
    inputLabel.Text = labelText
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputLabel.Parent = inputContainer
    
    local inputBG = Instance.new("Frame")
    inputBG.Name = "Background"
    inputBG.Size = UDim2.new(0.5, 0, 0, 25)
    inputBG.Position = UDim2.new(0.5, 0, 0.5, -12.5)
    inputBG.BackgroundColor3 = COLORS.Input
    inputBG.BorderSizePixel = 0
    inputBG.Parent = inputContainer
    
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 5)
    inputCorner.Parent = inputBG
    
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Size = UDim2.new(0.9, 0, 1, 0)
    textBox.Position = UDim2.new(0.05, 0, 0, 0)
    textBox.BackgroundTransparency = 1
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 14
    textBox.Font = FONT
    textBox.Text = tostring(defaultValue)
    textBox.PlaceholderText = "Enter value..."
    textBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
    textBox.TextXAlignment = Enum.TextXAlignment.Center
    textBox.ClearTextOnFocus = false
    textBox.Parent = inputBG
    textBox.ZIndex = 1
    
    local currentValue = defaultValue
    
    textBox.Focused:Connect(function()
        TweenService:Create(
            inputBG,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(70, 70, 80)}
        ):Play()
    end)
    
    textBox.FocusLost:Connect(function(enterPressed)
        TweenService:Create(
            inputBG,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = COLORS.Input}
        ):Play()
        
        if enterPressed then
            local newValue = textBox.Text
            local numValue = tonumber(newValue)
            if numValue then
                newValue = numValue
            end
            
            if newValue ~= currentValue then
                currentValue = newValue
                if onChange then
                    onChange(newValue)
                end
            end
        else
            textBox.Text = tostring(currentValue)
        end
    end)
    
    return inputContainer, {
        getValue = function() return currentValue end,
        setValue = function(value)
            currentValue = value
            textBox.Text = tostring(value)
            if onChange then
                onChange(value)
            end
        end
    }
end

function ModernGUILibrary.createDropdown(name, labelText, options, defaultOption, position, parent, callback)
    local dropdownContainer = Instance.new("Frame")
    dropdownContainer.Name = name .. "Container"
    dropdownContainer.Size = UDim2.new(0.9, 0, 0, 32)
    dropdownContainer.Position = position
    dropdownContainer.BackgroundTransparency = 1
    dropdownContainer.Parent = parent
    
    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Name = "Label"
    dropdownLabel.Size = UDim2.new(0.5, -10, 1, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    dropdownLabel.TextSize = 14
    dropdownLabel.Font = FONT
    dropdownLabel.Text = labelText
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.Parent = dropdownContainer
    
    local dropdownBG = Instance.new("Frame")
    dropdownBG.Name = "Background"
    dropdownBG.Size = UDim2.new(0.5, 0, 0, 25)
    dropdownBG.Position = UDim2.new(0.5, 0, 0.5, -12.5)
    dropdownBG.BackgroundColor3 = COLORS.Input
    dropdownBG.BorderSizePixel = 0
    dropdownBG.Parent = dropdownContainer
    dropdownBG.ZIndex = 100
    
    local dropdownCorner = Instance.new("UICorner")
    dropdownCorner.CornerRadius = UDim.new(0, 5)
    dropdownCorner.Parent = dropdownBG
    
    local selectedText = Instance.new("TextLabel")
    selectedText.Name = "SelectedText"
    selectedText.Size = UDim2.new(0.85, 0, 1, 0)
    selectedText.Position = UDim2.new(0.05, 0, 0, 0)
    selectedText.BackgroundTransparency = 1
    selectedText.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectedText.TextSize = 14
    selectedText.Font = FONT
    selectedText.Text = defaultOption or "Select..."
    selectedText.TextXAlignment = Enum.TextXAlignment.Left
    selectedText.Parent = dropdownBG
    
    local arrowIcon = Instance.new("TextLabel")
    arrowIcon.Name = "ArrowIcon"
    arrowIcon.Size = UDim2.new(0, 20, 0, 20)
    arrowIcon.Position = UDim2.new(1, -25, 0.5, -10)
    arrowIcon.BackgroundTransparency = 1
    arrowIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    arrowIcon.TextSize = 16
    arrowIcon.Font = FONT
    arrowIcon.Text = "▼"
    arrowIcon.TextYAlignment = Enum.TextYAlignment.Center
    arrowIcon.Parent = dropdownBG
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "Button"
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.BackgroundTransparency = 1
    dropdownButton.Text = ""
    dropdownButton.Parent = dropdownBG
    
    local menuContainer = Instance.new("Frame")
    menuContainer.Name = "MenuContainer"
    menuContainer.Size = UDim2.new(1, 0, 0, 0)
    menuContainer.Position = UDim2.new(0, 0, 1, 0)
    menuContainer.BackgroundColor3 = COLORS.Input
    menuContainer.BorderSizePixel = 0
    menuContainer.ClipsDescendants = true
    menuContainer.Visible = false
    menuContainer.ZIndex = 100
    menuContainer.Parent = dropdownBG
    
    local menuCorner = Instance.new("UICorner")
    menuCorner.CornerRadius = UDim.new(0, 5)
    menuCorner.Parent = menuContainer
    
    local optionsScrollFrame = Instance.new("ScrollingFrame")
    optionsScrollFrame.Name = "OptionsScrollFrame"
    optionsScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    optionsScrollFrame.BackgroundTransparency = 1
    optionsScrollFrame.BorderSizePixel = 0
    optionsScrollFrame.ScrollBarThickness = 4
    optionsScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    optionsScrollFrame.ZIndex = 110
    optionsScrollFrame.Parent = menuContainer
    
    local optionsList = Instance.new("UIListLayout")
    optionsList.Name = "OptionsList"
    optionsList.SortOrder = Enum.SortOrder.LayoutOrder
    optionsList.Padding = UDim.new(0, 2)
    optionsList.Parent = optionsScrollFrame
    
    local currentValue = defaultOption or options[1] or "Select..."
    local isOpen = false
    local optionHeight = 25
    local maxVisibleOptions = 4
    
    local function createOptions()
        for _, child in pairs(optionsScrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local totalOptionsHeight = #options * (optionHeight + 2)
        optionsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, totalOptionsHeight)
        
        for i, option in ipairs(options) do
            local optionButton = Instance.new("TextButton")
            optionButton.Name = "Option_" .. option
            optionButton.Size = UDim2.new(1, -8, 0, optionHeight)
            optionButton.Position = UDim2.new(0, 4, 0, (i-1) * (optionHeight + 2))
            optionButton.BackgroundColor3 = COLORS.Frame
            optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            optionButton.TextSize = 14
            optionButton.Font = FONT
            optionButton.Text = option
            optionButton.TextXAlignment = Enum.TextXAlignment.Left
            optionButton.TextYAlignment = Enum.TextYAlignment.Center
            optionButton.ZIndex = 120
            optionButton.Parent = optionsScrollFrame
            
            local optionCorner = Instance.new("UICorner")
            optionCorner.CornerRadius = UDim.new(0, 3)
            optionCorner.Parent = optionButton
            
            local textPadding = Instance.new("UIPadding")
            textPadding.PaddingLeft = UDim.new(0, 8)
            textPadding.Parent = optionButton
            
            optionButton.MouseEnter:Connect(function()
                TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Accent}):Play()
            end)
            
            optionButton.MouseLeave:Connect(function()
                TweenService:Create(optionButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.Frame}):Play()
            end)
            
            optionButton.MouseButton1Click:Connect(function()
                currentValue = option
                selectedText.Text = option
                isOpen = false
                arrowIcon.Text = "▼"
                TweenService:Create(menuContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                wait(0.3)
                menuContainer.Visible = false
                if callback then
                    callback(option)
                end
            end)
        end
    end
    
    dropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            createOptions()
            arrowIcon.Text = "▲"
            menuContainer.Visible = true
            local visibleOptionsHeight = math.min(#options, maxVisibleOptions) * (optionHeight + 2)
            TweenService:Create(menuContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, visibleOptionsHeight)}):Play()
        else
            arrowIcon.Text = "▼"
            TweenService:Create(menuContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(1, 0, 0, 0)}):Play()
            wait(0.3)
            menuContainer.Visible = false
        end
    end)
    
    if options and #options > 0 then
        if not defaultOption then
            selectedText.Text = options[1]
            currentValue = options[1]
        end
    end
    
    return dropdownContainer, {
        getValue = function() return currentValue end,
        setValue = function(value)
            local found = false
            for _, option in ipairs(options) do
                if option == value then
                    found = true
                    break
                end
            end
            if found then
                currentValue = value
                selectedText.Text = value
                if callback then
                    callback(value)
                end
            else
                warn("Dropdown setValue: Value '" .. tostring(value) .. "' not found in options")
            end
        end,
        setOptions = function(newOptions, newDefault)
            options = newOptions
            if newDefault then
                currentValue = newDefault
                selectedText.Text = newDefault
            elseif #newOptions > 0 then
                currentValue = newOptions[1]
                selectedText.Text = newOptions[1]
            else
                currentValue = "Select..."
                selectedText.Text = "Select..."
            end
            if isOpen then
                createOptions()
            end
            if callback then
                callback(currentValue)
            end
        end
    }
end

function ModernGUILibrary.createButton(name, text, position, parent, onClick, iconName)
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = name .. "Container"
    buttonContainer.Size = UDim2.new(0.9, 0, 0, 28)
    buttonContainer.Position = position
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = parent
    
    local hasIcon = iconName and FeatherIcons[iconName]
    if hasIcon then
    local iconLabel = Instance.new("ImageLabel")
    iconLabel.Name = "Icon"
    iconLabel.Size = UDim2.new(0, 20, 0, 20)
    iconLabel.Position = UDim2.new(0, 5, 0.5, -10)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Image = FeatherIcons[iconName]
    iconLabel.Parent = buttonContainer
end

local buttonLabel = Instance.new("TextLabel")
buttonLabel.Name = "Label"
if hasIcon then
    -- Ikon memiliki ukuran 20px dan posisi X adalah 5px
    -- Jadi posisi label harusnya 5px (posisi ikon) + 20px (lebar ikon) + 1px (jarak yang diinginkan) = 26px
    buttonLabel.Position = UDim2.new(0, 26, 0, 0) -- Perbaikan di sini
    -- Ukuran label perlu disesuaikan agar tidak tumpang tindih dengan tombol di kanan
    buttonLabel.Size = UDim2.new(1, -70, 1, 0)
else
    buttonLabel.Size = UDim2.new(1, -70, 1, 0)
    buttonLabel.Position = UDim2.new(0, 0, 0, 0)
end
    buttonLabel.BackgroundTransparency = 1
    buttonLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    buttonLabel.TextSize = 14
    buttonLabel.Font = FONT
    buttonLabel.Text = text
    buttonLabel.TextXAlignment = Enum.TextXAlignment.Left
    buttonLabel.Parent = buttonContainer
    buttonLabel.ZIndex = 101
    
    local buttonBG = Instance.new("Frame")
    buttonBG.Name = "Background"
    buttonBG.Size = UDim2.new(0, 60, 0, 22)
    buttonBG.Position = UDim2.new(1, -60, 0.5, -11)
    buttonBG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    buttonBG.BorderSizePixel = 0
    buttonBG.ClipsDescendants = true
    buttonBG.Parent = buttonContainer
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 5)
    buttonCorner.Parent = buttonBG
    
    local ripple = Instance.new("Frame")
    ripple.Name = "Ripple"
    ripple.Size = UDim2.new(0, 0, 0, 0)
    ripple.AnchorPoint = Vector2.new(0.5, 0.5)
    ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
    ripple.BackgroundColor3 = Color3.fromRGB(120, 230, 160)
    ripple.BackgroundTransparency = 0.5
    ripple.BorderSizePixel = 0
    ripple.Visible = false
    ripple.Parent = buttonBG
    
    
    local rippleCorner = Instance.new("UICorner")
    rippleCorner.CornerRadius = UDim.new(1, 0)
    rippleCorner.Parent = ripple
    
    local button = Instance.new("TextButton")
    button.Name = "Button"
    button.Size = UDim2.new(1, 0, 1, 0)
    button.BackgroundTransparency = 1
    button.Text = ""
    button.Parent = buttonContainer
    
    local isOnCooldown = false
    
    button.MouseEnter:Connect(function()
        if not isOnCooldown then
            buttonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TweenService:Create(buttonBG, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not isOnCooldown then
            buttonLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            TweenService:Create(buttonBG, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
        end
    end)
    
    button.MouseButton1Down:Connect(function(x, y)
        if not isOnCooldown then
            ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
            ripple.Size = UDim2.new(0, 0, 0, 0)
            ripple.Visible = true
            local maxSize = math.max(buttonBG.AbsoluteSize.X, buttonBG.AbsoluteSize.Y) * 2
            TweenService:Create(ripple, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, maxSize, 0, maxSize)}):Play()
        end
    end)
    
    button.MouseButton1Click:Connect(function()
        if not isOnCooldown then
            isOnCooldown = true
            TweenService:Create(buttonBG, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(120, 230, 160)}):Play()
            if onClick then
                onClick()
            end
            task.delay(1, function()
                if buttonBG and buttonBG.Parent then
                    TweenService:Create(buttonBG, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
                end
            end)
            task.delay(1, function()
                if ripple and ripple.Parent then
                    TweenService:Create(ripple, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    task.delay(0.3, function()
                        if ripple and ripple.Parent then
                            ripple.Visible = false
                            ripple.BackgroundTransparency = 0.5
                        end
                    end)
                end
            end)
            task.delay(3, function()
                isOnCooldown = false
            end)
        end
    end)
    
    return buttonContainer, button
end

function ModernGUILibrary.createLabel(labelName, text, positionY, parent, options)
    local options = options or {}
    local textSize = options.textSize or 14
    local textColor = options.textColor or Color3.fromRGB(255, 255, 255)
    local font = options.font or Enum.Font.Gotham
    local textAlignment = options.textAlignment or Enum.TextXAlignment.Left
    local zIndex = options.zIndex or 1
    local hasBackground = options.hasBackground or false
    local backgroundColor = options.backgroundColor or Color3.fromRGB(30, 30, 30)
    local backgroundTransparency = options.backgroundTransparency or 0.7

    -- Create a container frame for the label (optional background)
    local labelContainer = Instance.new("Frame")
    labelContainer.Name = labelName .. "LabelContainer"
    labelContainer.Size = UDim2.new(0.9, 0, 0, 30)
    labelContainer.Position = UDim2.new(0.05, 0, 0, positionY)
    labelContainer.BackgroundTransparency = hasBackground and backgroundTransparency or 1
    labelContainer.BackgroundColor3 = backgroundColor
    labelContainer.BorderSizePixel = 0
    labelContainer.ZIndex = zIndex
    labelContainer.Parent = parent

    -- Add corner radius for modern look if background is enabled
    if hasBackground then
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 5)
        corner.Parent = labelContainer
    end

    -- Create the text label
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = labelName .. "Label"
    textLabel.Size = UDim2.new(1, -10, 1, 0) -- Slightly smaller to fit within container
    textLabel.Position = UDim2.new(0, 5, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = textColor
    textLabel.TextSize = textSize
    textLabel.Font = font
    textLabel.Text = text
    textLabel.ZIndex = zIndex + 1 -- Ensure text is above background
    textLabel.TextXAlignment = textAlignment
    textLabel.TextWrapped = true
    textLabel.Parent = labelContainer

    return labelContainer, textLabel
end

function ModernGUILibrary.createNotification(message, type)
    local notifColor = COLORS.Accent
    if type == "success" then
        notifColor = COLORS.Success
    elseif type == "error" then
        notifColor = COLORS.Error
    elseif type == "warning" then
        notifColor = COLORS.Warning
    end
    
    local NotifGui = Instance.new("ScreenGui")
    local NotifFrame = Instance.new("Frame")
    local NotifText = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local StatusBar = Instance.new("Frame")
    local StatusBarCorner = Instance.new("UICorner")
    
    NotifGui.Name = "TeleportNotification"
    NotifGui.DisplayOrder = 999
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local parentSuccess = false
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(NotifGui)
            NotifGui.Parent = CoreGui
            parentSuccess = true
        elseif gethui then
            NotifGui.Parent = gethui()
            parentSuccess = true
        else
            NotifGui.Parent = PlayerGui
            parentSuccess = true
        end
    end)
    if not parentSuccess then
        print("Error: Failed to parent notification GUI.")
        return
    end
    
    NotifFrame.Name = "NotifFrame"
    NotifFrame.Parent = NotifGui
    NotifFrame.BackgroundColor3 = COLORS.Frame
    NotifFrame.Position = UDim2.new(1, 10, 0.8, 0)
    NotifFrame.Size = UDim2.new(0, 280, 0, 60)
    NotifFrame.BackgroundTransparency = 0.1
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 100
    
    UICorner.Parent = NotifFrame
    UICorner.CornerRadius = CORNER_RADIUS
    
    NotifText.Name = "NotifText"
    NotifText.Parent = NotifFrame
    NotifText.BackgroundTransparency = 1
    NotifText.Position = UDim2.new(0, 10, 0, 5)
    NotifText.Size = UDim2.new(1, -20, 1, -15)
    NotifText.Font = FONT
    NotifText.Text = message
    NotifText.TextColor3 = COLORS.Text
    NotifText.TextSize = 16
    NotifText.TextWrapped = true
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextYAlignment = Enum.TextYAlignment.Top
    NotifText.ZIndex = 101
    
    StatusBar.Name = "StatusBar"
    StatusBar.Parent = NotifFrame
    StatusBar.BackgroundColor3 = notifColor
    StatusBar.Position = UDim2.new(0, 10, 1, -8)
    StatusBar.Size = UDim2.new(1, -20, 0, 3)
    StatusBar.ZIndex = 101
    
    StatusBarCorner.Parent = StatusBar
    StatusBarCorner.CornerRadius = UDim.new(1, 0)
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -300, 0.8, 0)}):Play()
    
    local statusTween = TweenService:Create(StatusBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 3)})
    statusTween:Play()
    
    statusTween.Completed:Connect(function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 10, 0.8, 0)}):Play()
        wait(0.5)
        NotifGui:Destroy()
    end)
end

ModernGUILibrary.ContentFrame = nil -- Dihapus karena digantikan per tab

function ModernGUILibrary.updateCanvasSize(contentHeight)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

local dragging = false
local dragInput
local dragStart
local startPos
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function disableCamera(actionName, inputState, inputObject)
    if dragging then
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

if isMobile then
    local touchConnection
    local touchEndedConnection
    ContextActionService:BindAction("DisableCameraMovement", disableCamera, false, Enum.UserInputType.Touch)
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            touchConnection = UIS.TouchMoved:Connect(function(touchInput)
                if touchInput == input and dragging then
                    updateDrag(touchInput)
                end
            end)
            touchEndedConnection = UIS.TouchEnded:Connect(function(touchInput)
                if touchInput == input then
                    dragging = false
                    if touchConnection then touchConnection:Disconnect() end
                    if touchEndedConnection then touchEndedConnection:Disconnect() end
                end
            end)
        end
    end)
    ScreenGui.AncestryChanged:Connect(function()
        if not ScreenGui:IsDescendantOf(game) then
            ContextActionService:UnbindAction("DisableCameraMovement")
        end
    end)
end

CloseButton.MouseButton1Click:Connect(function()
    -- Buat popup konfirmasi
    local confirmGui = Instance.new("Frame")
    confirmGui.Size = UDim2.new(0, 250, 0, 120)
    confirmGui.Position = UDim2.new(0.5, -125, 0.5, -60)
    confirmGui.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    confirmGui.BorderSizePixel = 0
    confirmGui.Parent = ScreenGui
    
    local confirmCorner = Instance.new("UICorner")
    confirmCorner.CornerRadius = UDim.new(0, 10)
    confirmCorner.Parent = confirmGui
    
    local confirmText = Instance.new("TextLabel")
    confirmText.Size = UDim2.new(1, -20, 0, 60)
    confirmText.Position = UDim2.new(0, 10, 0, 10)
    confirmText.BackgroundTransparency = 1
    confirmText.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmText.TextSize = 14
    confirmText.Font = Enum.Font.GothamBold
    confirmText.Text = "Are you sure want to close this GUI?"
    confirmText.TextWrapped = true
    confirmText.Parent = confirmGui
    
    local yesButton = Instance.new("TextButton")
    yesButton.Size = UDim2.new(0, 80, 0, 30)
    yesButton.Position = UDim2.new(0, 40, 1, -40)
    yesButton.BackgroundColor3 = Color3.fromRGB(255, 89, 89)
    yesButton.Text = "Yes"
    yesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    yesButton.Font = Enum.Font.GothamBold
    yesButton.Parent = confirmGui
    
    local nopeButton = Instance.new("TextButton")
    nopeButton.Size = UDim2.new(0, 80, 0, 30)
    nopeButton.Position = UDim2.new(1, -120, 1, -40)
    nopeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    nopeButton.Text = "Nope"
    nopeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    nopeButton.Font = Enum.Font.GothamBold
    nopeButton.Parent = confirmGui
    
    -- Animasi muncul
    confirmGui.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(confirmGui, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 250, 0, 120)}):Play()
    
    yesButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        local existingCircleGui = PlayerGui:FindFirstChild("CircleGui")
if existingCircleGui then
    existingCircleGui:Destroy()
    wait(0.1) -- Tunggu sebentar untuk memastikan GUI terhapus
end
    end)
    
    nopeButton.MouseButton1Click:Connect(function()
        
        confirmGui:Destroy()
        
    end)
end)

MinimizeButton.MouseButton1Click:Connect(function()
         -- Create confirmation popup for minimizing
         local confirmMinimizeGui = Instance.new("Frame")
         confirmMinimizeGui.Size = UDim2.new(0, 250, 0, 120)
         confirmMinimizeGui.Position = UDim2.new(0.5, -125, 0.5, -60)
         confirmMinimizeGui.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
         confirmMinimizeGui.BorderSizePixel = 0
         confirmMinimizeGui.Parent = ScreenGui

         local confirmMinimizeCorner = Instance.new("UICorner")
         confirmMinimizeCorner.CornerRadius = UDim.new(0, 10)
         confirmMinimizeCorner.Parent = confirmMinimizeGui

         local confirmMinimizeText = Instance.new("TextLabel")
         confirmMinimizeText.Size = UDim2.new(1, -20, 0, 60)
         confirmMinimizeText.Position = UDim2.new(0, 10, 0, 10)
         confirmMinimizeText.BackgroundTransparency = 1
         confirmMinimizeText.TextColor3 = Color3.fromRGB(255, 255, 255)
         confirmMinimizeText.TextSize = 14
         confirmMinimizeText.Font = Enum.Font.GothamBold
         confirmMinimizeText.Text = "Are you sure you want to minimize this GUI?"
         confirmMinimizeText.TextWrapped = true
         confirmMinimizeText.Parent = confirmMinimizeGui

         local yesMinimizeButton = Instance.new("TextButton")
         yesMinimizeButton.Size = UDim2.new(0, 80, 0, 30)
         yesMinimizeButton.Position = UDim2.new(0, 40, 1, -40)
         yesMinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 201, 79) -- Match minimize button color
         yesMinimizeButton.Text = "Yes"
         yesMinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         yesMinimizeButton.Font = Enum.Font.GothamBold
         yesMinimizeButton.Parent = confirmMinimizeGui

         local nopeMinimizeButton = Instance.new("TextButton")
         nopeMinimizeButton.Size = UDim2.new(0, 80, 0, 30)
         nopeMinimizeButton.Position = UDim2.new(1, -120, 1, -40)
         nopeMinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
         nopeMinimizeButton.Text = "Nope"
         nopeMinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
         nopeMinimizeButton.Font = Enum.Font.GothamBold
         nopeMinimizeButton.Parent = confirmMinimizeGui

         -- Animation for popup appearance
         confirmMinimizeGui.Size = UDim2.new(0, 0, 0, 0)
         TweenService:Create(confirmMinimizeGui, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 250, 0, 120)}):Play()

         yesMinimizeButton.MouseButton1Click:Connect(function()
             ScreenGui.Enabled = false
             confirmMinimizeGui:Destroy()
         end)

         nopeMinimizeButton.MouseButton1Click:Connect(function()
             confirmMinimizeGui:Destroy()
         end)
     end)
     

return ModernGUILibrary
