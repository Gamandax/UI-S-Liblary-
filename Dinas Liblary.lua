local MenuLib = {}
MenuLib.__index = MenuLib

local COLORS = {
    Background = Color3.fromRGB(28, 28, 30),
    Header = Color3.fromRGB(44, 44, 46),
    Text = Color3.fromRGB(240, 240, 240),
    SecondaryText = Color3.fromRGB(200, 200, 200),
    Accent = Color3.fromRGB(0, 122, 255),
    ToggleOff = Color3.fromRGB(60, 60, 65),
    ToggleOn = Color3.fromRGB(0, 122, 255),
    ToggleCircle = Color3.fromRGB(220, 220, 220),
    Button = Color3.fromRGB(0, 122, 255),
    ButtonHover = Color3.fromRGB(10, 132, 255),
    ButtonPressed = Color3.fromRGB(5, 100, 200)
}

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, thickness, color)
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = thickness or 1
    stroke.Color = color or Color3.fromRGB(60, 60, 65)
    stroke.Parent = parent
    return stroke
end

local function createShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "DropShadow"
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.new(0, 0, 0)
    shadow.ImageTransparency = 0.8
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = -1
    shadow.Parent = parent
    return shadow
end

function MenuLib.new(title, tabs)
    local self = setmetatable({}, MenuLib)

    self.CoreGui = game:GetService("CoreGui")
    self.UIS = game:GetService("UserInputService")
    self.TweenService = game:GetService("TweenService")
    self.RunService = game:GetService("RunService")
    
    self.title = title or "iOS Premium Menu"
    self.tabs = tabs or {"Main", "Settings"}
    self.currentTab = self.tabs[1]
    self.elements = {}
    self.openIcon = nil
    self.screenGui = nil
    self.mainFrame = nil
    self.tabButtons = {}
    self.dropDownContainer = nil
    
    self:_initScreenGui()
    self:_initMainFrame()
    self:_initHeader()
    self:_initTabContainer()
    self:_initContentFrame()
    self:_initOpenIcon()
    
    self:UpdateTabContent()
    
    return self
end

function MenuLib:_initScreenGui()
    self.screenGui = Instance.new("ScreenGui")
    self.screenGui.Name = "iOS_Style_Menu"
    self.screenGui.Parent = self.CoreGui
    self.screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.screenGui.DisplayOrder = 10
    self.screenGui.ResetOnSpawn = false
    
    self.dropDownContainer = Instance.new("Frame")
    self.dropDownContainer.Name = "DropDownContainer"
    self.dropDownContainer.Size = UDim2.new(1, 0, 1, 0)
    self.dropDownContainer.BackgroundTransparency = 1
    self.dropDownContainer.ClipsDescendants = false
    self.dropDownContainer.ZIndex = 100 
    self.dropDownContainer.Parent = self.screenGui
end

function MenuLib:_initMainFrame()
    self.mainFrame = Instance.new("Frame")
    self.mainFrame.Name = "MainFrame"
    self.mainFrame.Size = UDim2.new(0, 350, 0, 500)
    self.mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
    self.mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    self.mainFrame.BackgroundColor3 = COLORS.Background
    self.mainFrame.BackgroundTransparency = 0.05
    self.mainFrame.ClipsDescendants = true
    self.mainFrame.Parent = self.screenGui
  
    createCorner(self.mainFrame, 14)
    createStroke(self.mainFrame, 2)
    createShadow(self.mainFrame)
end

function MenuLib:_initHeader()
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 40)
    header.BackgroundColor3 = COLORS.Header
    header.BorderSizePixel = 0
    header.Parent = self.mainFrame
    
    createCorner(header, 12)
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = self.title
    title.Font = Enum.Font.SourceSansSemibold
    title.TextSize = 18
    title.TextColor3 = COLORS.Text
    title.BackgroundTransparency = 1
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = header
    
    local closeButton = Instance.new("ImageButton")
    closeButton.Name = "CloseButton"
    closeButton.Image = "rbxassetid://3926305904"
    closeButton.ImageRectOffset = Vector2.new(284, 4)
    closeButton.ImageRectSize = Vector2.new(24, 24)
    closeButton.Size = UDim2.new(0, 30, 0, 30)
    closeButton.Position = UDim2.new(1, -35, 0.5, -15)
    closeButton.BackgroundTransparency = 1
    closeButton.Parent = header
    
    closeButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    local dragging = false
    local dragInput, dragStart, startPos
    
    header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    self.UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            self.mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function MenuLib:_initTabContainer()
    self.tabContainer = Instance.new("Frame")
    self.tabContainer.Name = "TabContainer"
    self.tabContainer.Size = UDim2.new(1, -20, 0, 30)
    self.tabContainer.Position = UDim2.new(0, 10, 0, 45)
    self.tabContainer.BackgroundTransparency = 1
    self.tabContainer.Parent = self.mainFrame
  
    for i, tabName in ipairs(self.tabs) do
        local tabButton = Instance.new("TextButton")
        tabButton.Name = tabName.."Tab"
        tabButton.Text = tabName
        tabButton.Font = Enum.Font.SourceSansSemibold
        tabButton.TextSize = 16
        tabButton.TextColor3 = COLORS.SecondaryText
        tabButton.BackgroundTransparency = 1
        tabButton.Size = UDim2.new(0, 70, 1, 0)
        tabButton.Position = UDim2.new(0, (i-1)*75, 0, 0)
        tabButton.LayoutOrder = i
        tabButton.Parent = self.tabContainer
        
        self.tabButtons[tabName] = tabButton
        
        tabButton.MouseButton1Click:Connect(function()
            for _, btn in pairs(self.tabButtons) do
                btn.TextColor3 = COLORS.SecondaryText
            end
            tabButton.TextColor3 = COLORS.Accent
            self.currentTab = tabName
            self:UpdateTabContent()
        end)
    end
end

function MenuLib:_initContentFrame()
    self.contentFrame = Instance.new("Frame")
    self.contentFrame.Name = "ContentFrame"
    self.contentFrame.Size = UDim2.new(1, -20, 1, -110)
    self.contentFrame.Position = UDim2.new(0, 10, 0, 80)
    self.contentFrame.BackgroundTransparency = 1
    self.contentFrame.ClipsDescendants = true
    self.contentFrame.Parent = self.mainFrame
    
    self.scrollingFrame = Instance.new("ScrollingFrame")
    self.scrollingFrame.Size = UDim2.new(1, 0, 1, 0)
    self.scrollingFrame.BackgroundTransparency = 1
    self.scrollingFrame.ScrollBarThickness = 5
    self.scrollingFrame.BorderSizePixel = 0
    self.scrollingFrame.Parent = self.contentFrame
    
    self.contentLayout = Instance.new("UIListLayout")
    self.contentLayout.Padding = UDim.new(0, 15)
    self.contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    self.contentLayout.Parent = self.scrollingFrame
  
    self.contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        self.scrollingFrame.CanvasSize = UDim2.new(0, 0, 0, self.contentLayout.AbsoluteContentSize.Y)
    end)
end

function MenuLib:_initOpenIcon()
    self.openIcon = Instance.new("ImageButton")
    self.openIcon.Name = "OpenIcon"
    self.openIcon.Image = "rbxassetid://3926305904"
    self.openIcon.ImageRectOffset = Vector2.new(884, 4)
    self.openIcon.ImageRectSize = Vector2.new(24, 24)
    self.openIcon.Size = UDim2.new(0, 40, 0, 40)
    self.openIcon.Position = UDim2.new(0, 20, 0, 20)
    self.openIcon.BackgroundColor3 = COLORS.Background
    self.openIcon.BackgroundTransparency = 0.05
    self.openIcon.Visible = false
    self.openIcon.Parent = self.screenGui
    
    createCorner(self.openIcon, 20)
    createStroke(self.openIcon, 1.5)
    createShadow(self.openIcon)
    
    self.openIcon.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
  
    if self.UIS.TouchEnabled then
        self.openIcon.Size = UDim2.new(0, 50, 0, 50)
        self.mainFrame.Size = UDim2.new(0, 300, 0, 450)
        self.mainFrame.Position = UDim2.new(0.5, -150, 0.5, -225)
    end
end

function MenuLib:Toggle()
    if self.mainFrame.Visible then
        self.mainFrame.Visible = false
        self.openIcon.Visible = true
        
        for _, child in ipairs(self.dropDownContainer:GetChildren()) do
            if child:IsA("Frame") and child.Name == "DropdownList" then
                child.Visible = false
            end
        end
    else
        self.mainFrame.Visible = true
        self.openIcon.Visible = false
    end
end

function MenuLib:Destroy()
    if self.screenGui then
        self.screenGui:Destroy()
    end
end

function MenuLib:UpdateTabContent()
    
    for _, child in ipairs(self.scrollingFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    
    if self.elements[self.currentTab] then
        for _, sectionData in ipairs(self.elements[self.currentTab]) do
            local section = self:_createSection(sectionData.name, self.scrollingFrame)
            
            for _, element in ipairs(sectionData.elements) do
                if element.type == "Toggle" then
                    element.object = self:_createToggle(element.name, section, element.callback)
                elseif element.type == "Slider" then
                    element.object = self:_createSlider(element.name, element.min, element.max, element.default, section, element.callback)
                elseif element.type == "Dropdown" then
                    element.object = self:_createDropdown(element.name, element.options, element.default, section, element.callback)
                elseif element.type == "Button" then
                    element.object = self:_createButton(element.name, section, element.callback)
                end
            end
        end
    end
end

function MenuLib:AddTab(tabName)
    if not table.find(self.tabs, tabName) then
        table.insert(self.tabs, tabName)
        self.tabButtons[tabName] = nil 
        self.elements[tabName] = self.elements[tabName] or {}
      
        for _, child in ipairs(self.tabContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        
        self:_initTabContainer()
        self:UpdateTabContent()
    end
    return {
        AddSection = function(_, sectionName)
            return self:AddSection(tabName, sectionName)
        end
    }
end

function MenuLib:AddSection(tabName, sectionName)
    if not self.elements[tabName] then
        self.elements[tabName] = {}
    end
    
    local sectionData = {
        name = sectionName,
        elements = {}
    }
    
    table.insert(self.elements[tabName], sectionData)
    
    return {
        AddToggle = function(_, name, callback)
            local toggle = {
                type = "Toggle",
                name = name,
                callback = callback
            }
            table.insert(sectionData.elements, toggle)
            return toggle
        end,
        
        AddSlider = function(_, name, min, max, default, callback)
            local slider = {
                type = "Slider",
                name = name,
                min = min,
                max = max,
                default = default,
                callback = callback
            }
            table.insert(sectionData.elements, slider)
            return slider
        end,
        
        AddDropdown = function(_, name, options, default, callback)
            local dropdown = {
                type = "Dropdown",
                name = name,
                options = options,
                default = default or 1,
                callback = callback
            }
            table.insert(sectionData.elements, dropdown)
            return dropdown
        end,
        
        AddButton = function(_, name, callback)
            local button = {
                type = "Button",
                name = name,
                callback = callback
            }
            table.insert(sectionData.elements, button)
            return button
        end
    }
end

function MenuLib:_createSection(title, parent)
    local sectionFrame = Instance.new("Frame")
    sectionFrame.Size = UDim2.new(1, 0, 0, 0)
    sectionFrame.AutomaticSize = Enum.AutomaticSize.Y
    sectionFrame.BackgroundTransparency = 1
    sectionFrame.LayoutOrder = #parent:GetChildren() + 1
    sectionFrame.Parent = parent
    
    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Text = "    "..title
    sectionTitle.Font = Enum.Font.SourceSansSemibold
    sectionTitle.TextSize = 16
    sectionTitle.TextColor3 = COLORS.Text
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Size = UDim2.new(1, 0, 0, 20)
    sectionTitle.Parent = sectionFrame
    
    local sectionContent = Instance.new("Frame")
    sectionContent.Name = "Content"
    sectionContent.Size = UDim2.new(1, 0, 0, 0)
    sectionContent.AutomaticSize = Enum.AutomaticSize.Y
    sectionContent.Position = UDim2.new(0, 0, 0, 25)
    sectionContent.BackgroundTransparency = 1
    sectionContent.Parent = sectionFrame
    
    local sectionLayout = Instance.new("UIListLayout")
    sectionLayout.Padding = UDim.new(0, 10)
    sectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
    sectionLayout.Parent = sectionContent
    
    sectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        sectionContent.Size = UDim2.new(1, 0, 0, sectionLayout.AbsoluteContentSize.Y)
    end)
    
    return sectionContent
end

function MenuLib:_createToggle(name, section, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, 0, 0, 30)
    toggleFrame.AutomaticSize = Enum.AutomaticSize.Y
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.LayoutOrder = #section:GetChildren() + 1
    toggleFrame.Parent = section
    
    local toggleName = Instance.new("TextLabel")
    toggleName.Text = name
    toggleName.Font = Enum.Font.SourceSans
    toggleName.TextSize = 16
    toggleName.TextColor3 = COLORS.Text
    toggleName.TextXAlignment = Enum.TextXAlignment.Left
    toggleName.BackgroundTransparency = 1
    toggleName.Size = UDim2.new(0.7, 0, 1, 0)
    toggleName.Parent = toggleFrame
    
    local toggleButton = Instance.new("Frame")
    toggleButton.Size = UDim2.new(0, 50, 0, 28)
    toggleButton.Position = UDim2.new(1, -50, 0, 1)
    toggleButton.BackgroundColor3 = COLORS.ToggleOff
    toggleButton.Parent = toggleFrame
    
    createCorner(toggleButton, 14)
    
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 24, 0, 24)
    toggleCircle.Position = UDim2.new(0, 2, 0, 2)
    toggleCircle.BackgroundColor3 = COLORS.ToggleCircle
    toggleCircle.Parent = toggleButton
    
    createCorner(toggleCircle, 12)
    
    local isToggled = false
    
    local function updateToggle()
        if isToggled then
            self.TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 24, 0, 2)}):Play()
            self.TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.ToggleOn}):Play()
        else
            self.TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            self.TweenService:Create(toggleButton, TweenInfo.new(0.2), {BackgroundColor3 = COLORS.ToggleOff}):Play()
        end
        if callback then callback(isToggled) end
    end
    
    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isToggled = not isToggled
            updateToggle()
        end
    end)
    
    local toggleObj = {
        SetState = function(_, state)
            isToggled = state
            updateToggle()
        end,
        GetState = function()
            return isToggled
        end
    }
    
    return toggleObj
end

function MenuLib:_createSlider(name, min, max, default, section, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, 0, 0, 50)
    sliderFrame.AutomaticSize = Enum.AutomaticSize.Y
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.LayoutOrder = #section:GetChildren() + 1
    sliderFrame.Parent = section
    
    local sliderTop = Instance.new("Frame")
    sliderTop.Size = UDim2.new(1, 0, 0, 20)
    sliderTop.BackgroundTransparency = 1
    sliderTop.Parent = sliderFrame
    
    local sliderName = Instance.new("TextLabel")
    sliderName.Text = name
    sliderName.Font = Enum.Font.SourceSans
    sliderName.TextSize = 16
    sliderName.TextColor3 = COLORS.Text
    sliderName.TextXAlignment = Enum.TextXAlignment.Left
    sliderName.BackgroundTransparency = 1
    sliderName.Size = UDim2.new(0.6, 0, 1, 0)
    sliderName.Parent = sliderTop
    
    local sliderValue = Instance.new("TextLabel")
    sliderValue.Text = tostring(default)
    sliderValue.Font = Enum.Font.SourceSans
    sliderValue.TextSize = 16
    sliderValue.TextColor3 = COLORS.SecondaryText
    sliderValue.TextXAlignment = Enum.TextXAlignment.Right
    sliderValue.BackgroundTransparency = 1
    sliderValue.Size = UDim2.new(0.4, 0, 1, 0)
    sliderValue.Position = UDim2.new(0.6, 0, 0, 0)
    sliderValue.Parent = sliderTop
    
    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, 0, 0, 5)
    sliderBar.Position = UDim2.new(0, 0, 0, 30)
    sliderBar.BackgroundColor3 = COLORS.ToggleOff
    sliderBar.Parent = sliderFrame
    
    createCorner(sliderBar, 2)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.Accent
    sliderFill.Parent = sliderBar
    
    createCorner(sliderFill, 2)
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 20, 0, 20)
    sliderButton.Position = UDim2.new(sliderFill.Size.X.Scale, -10, 0, -7)
    sliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderButton.Text = ""
    sliderButton.ZIndex = 2
    sliderButton.Parent = sliderBar
    
    createCorner(sliderButton, 10)
    
    local dragging = false
    local currentValue = default
    
    local function updateSlider(value)
        currentValue = math.clamp(math.floor(value), min, max)
        local percent = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percent, 0, 1, 0)
        sliderButton.Position = UDim2.new(percent, -10, 0, -7)
        sliderValue.Text = tostring(currentValue)
        if callback then callback(currentValue) end
    end
    
    sliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    
    local function updateSliderFromInput(input)
        if dragging then
            local pos = input.Position
            local relativeX = (pos.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
            local value = min + (max - min) * math.clamp(relativeX, 0, 1)
            updateSlider(value)
        end
    end
    
    self.UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateSliderFromInput(input)
        end
    end)
    
    self.UIS.InputEnded:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and dragging then
            dragging = false
        end
    end)
    
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSliderFromInput(input)
        end
    end)
    
    updateSlider(default)
    
    local sliderObj = {
        SetValue = function(_, value)
            updateSlider(value)
        end,
        GetValue = function()
            return currentValue
        end
    }
    
    return sliderObj
end

function MenuLib:_createDropdown(name, options, defaultIndex, section, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, 0, 0, 30)
    dropdownFrame.AutomaticSize = Enum.AutomaticSize.Y
    dropdownFrame.BackgroundTransparency = 1
    dropdownFrame.LayoutOrder = #section:GetChildren() + 1
    dropdownFrame.Parent = section
    
    local dropdownName = Instance.new("TextLabel")
    dropdownName.Text = name
    dropdownName.Font = Enum.Font.SourceSans
    dropdownName.TextSize = 16
    dropdownName.TextColor3 = COLORS.Text
    dropdownName.TextXAlignment = Enum.TextXAlignment.Left
    dropdownName.BackgroundTransparency = 1
    dropdownName.Size = UDim2.new(0.7, 0, 0, 30)
    dropdownName.Parent = dropdownFrame
    
    local dropdownButtonContainer = Instance.new("Frame")
    dropdownButtonContainer.Size = UDim2.new(0.3, 0, 0, 30)
    dropdownButtonContainer.Position = UDim2.new(0.7, 0, 0, 0)
    dropdownButtonContainer.BackgroundTransparency = 1
    dropdownButtonContainer.Parent = dropdownFrame
    
    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "DropdownButton"
    dropdownButton.Text = ""
    dropdownButton.BackgroundColor3 = COLORS.Header
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.Parent = dropdownButtonContainer
    
    createCorner(dropdownButton, 8)
    createStroke(dropdownButton, 1)
    
    local dropdownText = Instance.new("TextLabel")
    dropdownText.Name = "DropdownText"
    dropdownText.Text = options[defaultIndex] or "Select"
    dropdownText.Font = Enum.Font.SourceSans
    dropdownText.TextSize = 16
    dropdownText.TextColor3 = COLORS.SecondaryText
    dropdownText.TextXAlignment = Enum.TextXAlignment.Center
    dropdownText.BackgroundTransparency = 1
    dropdownText.Size = UDim2.new(1, -25, 1, 0)
    dropdownText.Parent = dropdownButton
    
    local dropdownIcon = Instance.new("ImageLabel")
    dropdownIcon.Image = "rbxassetid://3926307971"
    dropdownIcon.ImageRectOffset = Vector2.new(364, 284)
    dropdownIcon.ImageRectSize = Vector2.new(36, 36)
    dropdownIcon.Size = UDim2.new(0, 15, 0, 15)
    dropdownIcon.Position = UDim2.new(1, -20, 0.5, -7.5)
    dropdownIcon.BackgroundTransparency = 1
    dropdownIcon.Parent = dropdownButton
  
    local dropdownList = Instance.new("Frame")
    dropdownList.Name = "DropdownList"
    dropdownList.Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, 0)
    dropdownList.AutomaticSize = Enum.AutomaticSize.Y
    dropdownList.BackgroundColor3 = COLORS.Header
    dropdownList.Visible = false
    dropdownList.ZIndex = 1001 
    dropdownList.Parent = self.dropDownContainer
    
    local dropdownListLayout = Instance.new("UIListLayout")
    dropdownListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    dropdownListLayout.Parent = dropdownList
    
    createCorner(dropdownList, 8)
    createStroke(dropdownList, 1)
  
    local function updateDropdownPosition()
        if dropdownButton and dropdownButton:IsDescendantOf(game) then
            local buttonPos = dropdownButton.AbsolutePosition
            local buttonSize = dropdownButton.AbsoluteSize
            dropdownList.Position = UDim2.new(0, buttonPos.X, 0, buttonPos.Y + buttonSize.Y + 5)
            dropdownList.Size = UDim2.new(0, buttonSize.X, 0, 0)
        end
    end
    
    local conn
    conn = self.RunService.Heartbeat:Connect(function()
        if dropdownButton:IsDescendantOf(game) then
            updateDropdownPosition()
        else
            conn:Disconnect()
        end
    end)
    
    for i, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Text = option
        optionButton.Font = Enum.Font.SourceSans
        optionButton.TextSize = 16
        optionButton.TextColor3 = COLORS.SecondaryText
        optionButton.BackgroundColor3 = COLORS.Header
        optionButton.BackgroundTransparency = 0
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.LayoutOrder = i
        optionButton.ZIndex = 1002 
        optionButton.TextWrapped = true 
        optionButton.Parent = dropdownList
        
        optionButton.MouseButton1Click:Connect(function()
            dropdownText.Text = option
            dropdownList.Visible = false
            if callback then callback(option, i) end
        end)
        
        optionButton.MouseEnter:Connect(function()
            optionButton.BackgroundColor3 = COLORS.ToggleOff
        end)
        
        optionButton.MouseLeave:Connect(function()
            optionButton.BackgroundColor3 = COLORS.Header
        end)
    end
    
    dropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        dropdownList.Size = UDim2.new(0, dropdownButton.AbsoluteSize.X, 0, dropdownListLayout.AbsoluteContentSize.Y)
    end)
    
    dropdownButton.MouseButton1Click:Connect(function()
        dropdownList.Visible = not dropdownList.Visible
        updateDropdownPosition()
    end)
    
    local closeConn
    closeConn = self.UIS.InputBegan:Connect(function(input)
        if dropdownList.Visible and input.UserInputType == Enum.UserInputType.MouseButton1 then
            local mousePos = input.Position
            local listPos = dropdownList.AbsolutePosition
            local listSize = dropdownList.AbsoluteSize
            
            if mousePos.X < listPos.X or mousePos.X > listPos.X + listSize.X or
               mousePos.Y < listPos.Y or mousePos.Y > listPos.Y + listSize.Y then
                dropdownList.Visible = false
            end
        end
    end)
    
    dropdownList.Destroying:Connect(function()
        if closeConn then
            closeConn:Disconnect()
        end
    end)
    
    local dropdownObj = {
        SetSelected = function(_, index)
            if options[index] then
                dropdownText.Text = options[index]
                if callback then callback(options[index], index) end
            end
        end,
        GetSelected = function()
            return dropdownText.Text
        end
    }
    
    return dropdownObj
end

function MenuLib:_createButton(name, section, callback)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0, 35)
    buttonFrame.AutomaticSize = Enum.AutomaticSize.Y
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.LayoutOrder = #section:GetChildren() + 1
    buttonFrame.Parent = section
    
    local button = Instance.new("TextButton")
    button.Text = name
    button.Font = Enum.Font.SourceSansSemibold
    button.TextSize = 16
    button.TextColor3 = COLORS.Text
    button.BackgroundColor3 = COLORS.Button
    button.AutoButtonColor = false
    button.Size = UDim2.new(1, 0, 0, 35)
    button.Parent = buttonFrame
    
    createCorner(button, 8)
    createStroke(button, 1, COLORS.ToggleOff)
  
    button.MouseEnter:Connect(function()
        self.TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = COLORS.ButtonHover}):Play()
    end)
    
    button.MouseLeave:Connect(function()
        self.TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = COLORS.Button}):Play()
    end)
    
    button.MouseButton1Down:Connect(function()
        self.TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = COLORS.ButtonPressed}):Play()
    end)
    
    button.MouseButton1Up:Connect(function()
        self.TweenService:Create(button, TweenInfo.new(0.1), {BackgroundColor3 = COLORS.Button}):Play()
    end)
    
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    
    if self.UIS.TouchEnabled then
        button.Size = UDim2.new(1, 0, 0, 45)
    end
    
    return button
end

return MenuLib
