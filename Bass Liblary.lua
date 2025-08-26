local Library = {}
Library._index = Library

local function safeService(serviceName)
    local success, service = pcall(game.GetService, game, serviceName)
    return success and service or nil
end

local function safeInstance(className, properties)
    local instance
    pcall(function()
        instance = Instance.new(className)
        for prop, value in pairs(properties) do
            instance[prop] = value
        end
    end)
    return instance
end

local Fonts = {
    Title = Enum.Font.GothamBlack,
    Header = Enum.Font.GothamBold,
    Body = Enum.Font.GothamSemibold,
    Button = Enum.Font.GothamMedium,
    Label = Enum.Font.Gotham
}

local Theme = {
    Primary = Color3.fromRGB(0, 170, 255),
    PrimaryLight = Color3.fromRGB(50, 190, 255),
    Background = Color3.fromRGB(15, 15, 25),
    BackgroundLight = Color3.fromRGB(25, 25, 40),
    Secondary = Color3.fromRGB(35, 35, 55),
    SecondaryLight = Color3.fromRGB(55, 55, 80),
    Text = Color3.fromRGB(245, 245, 245),
    TextLight = Color3.fromRGB(210, 210, 220),
    Stroke = Color3.fromRGB(65, 65, 90),
    Success = Color3.fromRGB(0, 210, 110),
    Warning = Color3.fromRGB(255, 180, 0),
    Error = Color3.fromRGB(230, 70, 70),
    Purple = Color3.fromRGB(170, 110, 210),
    Glow = Color3.fromRGB(0, 160, 255),
    DarkAccent = Color3.fromRGB(10, 10, 20)
}

local function safeImage(id)
    local success = pcall(function()
        game:GetService("ContentProvider"):PreloadAsync({id})
    end)
    return success and id or "rbxasset://textures/ui/GuiImagePlaceholder.png"
end

local function getParentGui()
    local coreGui = safeService("CoreGui")
    if coreGui and coreGui:FindFirstChild("RobloxGui") then
        return coreGui
    end
    local players = safeService("Players")
    if players then
        local player = players.LocalPlayer
        if player then
            local playerGui = player:WaitForChild("PlayerGui", 5)
            if playerGui then
                return playerGui
            end
        end
    end
    return game:GetService("StarterGui")
end

local function createGlowEffect(parent, color, sizeMultiplier)
    local glowContainer = safeInstance("Frame", {
        Name = "GlowContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(sizeMultiplier, 0, sizeMultiplier, 0),
        Position = UDim2.new(-(sizeMultiplier-1)/2, 0, -(sizeMultiplier-1)/2, 0),
        ZIndex = 0,
        Parent = parent
    })
    
    for i = 1, 3 do
        local glow = safeInstance("ImageLabel", {
            Name = "Glow"..i,
            Image = "rbxassetid://5028857084",
            ImageColor3 = color,
            ScaleType = Enum.ScaleType.Slice,
            SliceCenter = Rect.new(24, 24, 276, 276),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            ZIndex = 0,
            ImageTransparency = 0.9 - (i * 0.2),
            Parent = glowContainer
        })
    end
    
    return glowContainer
end

local function createAnimatedGradient(parent, colors, speed)
    local gradientFrame = safeInstance("Frame", {
        Name = "AnimatedGradient",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Parent = parent
    })
    
    local gradient = safeInstance("UIGradient", {
        Rotation = 0,
        Color = ColorSequence.new(colors),
        Parent = gradientFrame
    })
    
    if safeService("RunService") then
        spawn(function()
            while gradientFrame and gradientFrame.Parent do
                gradient.Rotation = (gradient.Rotation + speed) % 360
                wait()
            end
        end)
    end
    
    return gradientFrame
end

local function springTween(instance, properties, options)
    options = options or {}
    local tweenInfo = TweenInfo.new(
        options.duration or 0.5,
        options.easingStyle or Enum.EasingStyle.Quad,
        options.easingDirection or Enum.EasingDirection.Out,
        options.repeatCount or 0,
        options.reverses or false,
        options.delay or 0
    )
    
    local tween = game:GetService("TweenService"):Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function Library:CreateWindow(Title)
    local UserInputService = safeService("UserInputService") or {
        TouchEnabled = false,
        InputBegan = {Connect = function() end},
        InputChanged = {Connect = function() end},
        InputEnded = {Connect = function() end}
    }
    
    local TweenService = safeService("TweenService") or {
        Create = function() return {Play = function() end} end
    }
    
    local RunService = safeService("RunService")
    
    local parentGui = getParentGui()
    local ScreenGui = safeInstance("ScreenGui", {
        Name = "UILibrary" .. math.random(10000, 99999),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    })
    if not ScreenGui then return end
    ScreenGui.Parent = parentGui
    
    local Container = safeInstance("Frame", {
    Name = "Container",
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 300, 0, 400),
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Parent = ScreenGui
})
    
    local MainFrame = safeInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Theme.Background,
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Parent = Container
    })
   
    createAnimatedGradient(MainFrame, {
        ColorSequenceKeypoint.new(0, Theme.Primary),
        ColorSequenceKeypoint.new(0.5, Theme.Purple),
        ColorSequenceKeypoint.new(1, Theme.Primary)
    }, 0.5)
    
    local OuterStroke = safeInstance("UIStroke", {
        Parent = MainFrame,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Theme.Primary,
        Thickness = 4,
        Transparency = 0.4
    })
    
    local MiddleStroke = safeInstance("UIStroke", {
        Parent = MainFrame,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Theme.Stroke,
        Thickness = 2,
        Transparency = 0.2
    })
    
    local InnerStroke = safeInstance("UIStroke", {
        Parent = MainFrame,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Theme.Secondary,
        Thickness = 1,
        Transparency = 0.1
    })
    
    safeInstance("UICorner", {
        Parent = MainFrame,
        CornerRadius = UDim.new(0, 16)
    })
    
    local TopBar = safeInstance("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, -30, 0, 45),
        Position = UDim2.new(0, 15, 0, 15),
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        ZIndex = 3,
        Parent = MainFrame
    })
    
    safeInstance("UICorner", {
        Parent = TopBar,
        CornerRadius = UDim.new(0, 10)
    })
    
    safeInstance("UIStroke", {
        Parent = TopBar,
        Color = Theme.Stroke,
        Thickness = 1,
        Transparency = 0.3
    })
    
    local TitleLabel = safeInstance("TextLabel", {
        Name = "Title",
        Text = Title or "UI",
        Font = Fonts.Title,
        TextSize = 20,
        TextColor3 = Theme.Text,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.5, 0, 1, 0),
        Position = UDim2.new(0.03, 0, 0, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4,
        Parent = TopBar
    })
    
    local IconsFrame = safeInstance("Frame", {
        Name = "Icons",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 60, 1, 0),
        Position = UDim2.new(1, -65, 0, 0),
        Parent = TopBar
    })
    
    local MinimizeButton = safeInstance("ImageButton", {
        Name = "Minimize",
        Image = "rbxassetid://9886659276",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 10, 0.5, -10),
        ImageColor3 = Theme.TextLight,
        Parent = IconsFrame
    })
    
    local CloseButton = safeInstance("ImageButton", {
        Name = "Close",
        Image = "rbxassetid://9886659671",
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(0, 37, 0.5, -10),
        ImageColor3 = Color3.fromRGB(230, 100, 100),
        Parent = IconsFrame
    })
    
    local function setupButtonHover(button, hoverColor)
        local originalColor = button.ImageColor3
        local originalSize = button.Size
        
        button.MouseEnter:Connect(function()
            springTween(button, {
                ImageColor3 = hoverColor,
                Size = originalSize + UDim2.new(0, 5, 0, 5)
            }, {duration = 0.3})
        end)
        
        button.MouseLeave:Connect(function()
            springTween(button, {
                ImageColor3 = originalColor,
                Size = originalSize
            }, {duration = 0.4, easingStyle = Enum.EasingStyle.Back})
        end)
        
        button.MouseButton1Click:Connect(function()
            springTween(button, {
                Size = originalSize - UDim2.new(0, 3, 0, 3)
            }, {duration = 0.1})
            
            wait(0.1)
            
            springTween(button, {
                Size = originalSize
            }, {duration = 0.2, easingStyle = Enum.EasingStyle.Back})
        end)
    end
    
    setupButtonHover(MinimizeButton, Theme.PrimaryLight)
    setupButtonHover(CloseButton, Color3.fromRGB(255, 120, 120))
    
    local Sidebar = safeInstance("Frame", {
        Name = "Sidebar",
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.4,
        Size = UDim2.new(0, 160, 1, -70),
        Position = UDim2.new(0, 15, 0, 70),
        ZIndex = 2,
        Parent = MainFrame
    })
    
    safeInstance("UICorner", {
        Parent = Sidebar,
        CornerRadius = UDim.new(0, 12)
    })
    
    safeInstance("UIStroke", {
        Parent = Sidebar,
        Color = Theme.Stroke,
        Thickness = 1,
        Transparency = 0.4
    })
    
    local TabContainer = safeInstance("ScrollingFrame", {
        Name = "TabContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Primary,
        Parent = Sidebar
    })
    
    safeInstance("UIListLayout", {
        Parent = TabContainer,
        FillDirection = Enum.FillDirection.Vertical,
        Padding = UDim.new(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    
    local ContentFrame = safeInstance("ScrollingFrame", {
        Name = "Content",
        Size = UDim2.new(1, -190, 1, -130),
        Position = UDim2.new(0, 185, 0, 120),
        BackgroundTransparency = 1,
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = Theme.Primary,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ZIndex = 2,
        Parent = MainFrame
    })
    
    local ContentLayout = safeInstance("UIListLayout", {
        Parent = ContentFrame,
        Padding = UDim.new(0, 18),
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Top
    })
    
    local function updateCanvasSize()
        pcall(function()
            ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y + 20)
            if TabContainer and TabContainer.UIListLayout then
                TabContainer.CanvasSize = UDim2.new(0, 0, 0, TabContainer.UIListLayout.AbsoluteContentSize.Y + 10)
            end
        end)
    end
    
    if ContentLayout then
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize)
        updateCanvasSize()
    end
    
    local dragging, dragInput, dragStart, startPos
    
    local function UpdateInput(input)
        pcall(function()
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X, 
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
            
            springTween(Container, {Position = newPos}, {duration = 0.1})
        end)
    end
    
    if TopBar then
        TopBar.InputBegan:Connect(function(input)
            pcall(function()
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    dragStart = input.Position
                    startPos = Container.Position
                    
                    input.Changed:Connect(function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end)
                end
            end)
        end)
        
        TopBar.InputChanged:Connect(function(input)
            pcall(function()
                if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                    dragInput = input
                end
            end)
        end)
    end
    
    if UserInputService then
        UserInputService.InputChanged:Connect(function(input)
            pcall(function()
                if input == dragInput and dragging then
                    UpdateInput(input)
                end
            end)
        end)
    end
    
    Container.Size = UDim2.new(0, 10, 0, 10)
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    local openTween = springTween(Container, {
        Size = UDim2.new(0, 720, 0, 500),
        BackgroundTransparency = 1
    }, {duration = 0.8, easingStyle = Enum.EasingStyle.Back})
    
    local minimized = false
    local originalSize
    
    openTween.Completed:Connect(function()
        originalSize = Container.Size
    end)
    
    if MinimizeButton then
        MinimizeButton.MouseButton1Click:Connect(function()
            pcall(function()
                minimized = not minimized
                
                if minimized then
                    springTween(Container, {Size = UDim2.new(0, 500, 0, 70)}, {duration = 0.5})
                    springTween(MinimizeButton, {Rotation = 180}, {duration = 0.5})
                    Sidebar.Visible = false
                    ContentFrame.Visible = false
                else
                    springTween(Container, {Size = originalSize}, {duration = 0.5})
                    springTween(MinimizeButton, {Rotation = 0}, {duration = 0.5})
                    Sidebar.Visible = true
                    ContentFrame.Visible = true
                end
            end)
        end)
    end
    
    if CloseButton then
        CloseButton.MouseButton1Click:Connect(function()
            pcall(function()
                local closeTween = springTween(Container, {
                    Size = UDim2.new(0, 10, 0, 10),
                    Position = UDim2.new(0.5, -5, 0.5, -5),
                    BackgroundTransparency = 1
                }, {duration = 0.5, easingStyle = Enum.EasingStyle.Back})
                
                closeTween.Completed:Wait()
                ScreenGui:Destroy()
            end)
        end)
    end
    
    if UserInputService and UserInputService.TouchEnabled then
        pcall(function()
            Container.Size = UDim2.new(0.9, 0, 0.8, 0)
            Container.AnchorPoint = Vector2.new(0.5, 0.5)
            Container.Position = UDim2.new(0.5, 0, 0.5, 0)
            
            if MinimizeButton then MinimizeButton.Size = UDim2.new(0, 30, 0, 30) end
            if CloseButton then CloseButton.Size = UDim2.new(0, 30, 0, 30) end
        end)
    end
    
    local Window = {
        ScreenGui = ScreenGui,
        Container = Container,
        MainFrame = MainFrame,
        Tabs = {},
        CurrentTab = nil
    }
    
    function Window:AddTab(TabName, TabIcon)
        local tabIndex = #Window.Tabs + 1
        local TabButton = safeInstance("TextButton", {
            Name = TabName,
            Text = "  " .. TabName,
            Font = Fonts.Header,
            TextSize = 15,
            TextColor3 = Theme.TextLight,
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.6,
            AutoButtonColor = false,
            Size = UDim2.new(1, -10, 0, 45),
            LayoutOrder = tabIndex,
            Parent = TabContainer
        })
        
        if not TabButton then return end
        
        safeInstance("UICorner", {
            Parent = TabButton,
            CornerRadius = UDim.new(0, 8)
        })
        
        safeInstance("UIStroke", {
            Parent = TabButton,
            Color = Theme.Primary,
            Thickness = 1,
            Transparency = 0.7
        })
        
        if TabIcon then
            local tabIcon = safeInstance("ImageLabel", {
                Image = TabIcon,
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(0, 10, 0.5, -10),
                BackgroundTransparency = 1,
                ImageColor3 = Theme.TextLight,
                Parent = TabButton
            })
        end
        
        local Indicator = safeInstance("Frame", {
            Name = "Indicator",
            Size = UDim2.new(0, 4, 0, 0),
            Position = UDim2.new(0, 0, 0.5, 0),
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Theme.Primary,
            BorderSizePixel = 0,
            Parent = TabButton
        })
        
        safeInstance("UICorner", {
            Parent = Indicator,
            CornerRadius = UDim.new(0, 2)
        })
        
        local TabContent = safeInstance("Frame", {
            Name = TabName,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false,
            Parent = ContentFrame
        })
        
        local tabContentLayout = safeInstance("UIListLayout", {
            Parent = TabContent,
            Padding = UDim.new(0, 18),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
        
        if tabContentLayout then
            tabContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                pcall(function()
                    TabContent.Size = UDim2.new(1, 0, 0, tabContentLayout.AbsoluteContentSize.Y)
                end)
            end)
        end
        
        TabButton.MouseEnter:Connect(function()
            if Window.CurrentTab and Window.CurrentTab.Button == TabButton then return end
            springTween(TabButton, {
                BackgroundColor3 = Theme.SecondaryLight,
                TextColor3 = Theme.Text,
                Size = UDim2.new(1, -5, 0, 45)
            }, {duration = 0.3})
        end)
        
        TabButton.MouseLeave:Connect(function()
            if Window.CurrentTab and Window.CurrentTab.Button == TabButton then return end
            springTween(TabButton, {
                BackgroundColor3 = Theme.Secondary,
                TextColor3 = Theme.TextLight,
                Size = UDim2.new(1, -10, 0, 45)
            }, {duration = 0.3})
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            pcall(function()
                if Window.CurrentTab then
                    springTween(Window.CurrentTab.Indicator, {
                        Size = UDim2.new(0, 4, 0, 0)
                    }, {duration = 0.3})
                    
                    springTween(Window.CurrentTab.Button, {
                        BackgroundColor3 = Theme.Secondary,
                        TextColor3 = Theme.TextLight,
                        Size = UDim2.new(1, -10, 0, 45)
                    }, {duration = 0.3})
                    
                    Window.CurrentTab.Content.Visible = false
                end
                
                springTween(Indicator, {
                    Size = UDim2.new(0, 4, 0.8, 0)
                }, {duration = 0.3})
                
                springTween(TabButton, {
                    BackgroundColor3 = Theme.SecondaryLight,
                    TextColor3 = Theme.Text,
                    Size = UDim2.new(1, -5, 0, 45)
                }, {duration = 0.3})
                
                TabContent.Visible = true
                Window.CurrentTab = {
                    Button = TabButton,
                    Content = TabContent,
                    Indicator = Indicator
                }
                
                for i, element in ipairs(TabContent:GetChildren()) do
                    if element:IsA("GuiObject") and element.Name ~= "UIListLayout" then
                        element.Position = UDim2.new(0, -20, 0, 0)
                        
                        springTween(element, {
                            Position = UDim2.new(0, 0, 0, 0)
                        }, {duration = 0.4, delay = i * 0.05})
                    end
                end
            end)
        end)
        
        if #Window.Tabs == 0 then
            pcall(function()
                Indicator.Size = UDim2.new(0, 4, 0.8, 0)
                TabButton.BackgroundColor3 = Theme.SecondaryLight
                TabButton.TextColor3 = Theme.Text
                TabButton.Size = UDim2.new(1, -5, 0, 45)
                TabContent.Visible = true
                Window.CurrentTab = {
                    Button = TabButton,
                    Content = TabContent,
                    Indicator = Indicator
                }
            end)
        end
        
        table.insert(Window.Tabs, {
            Name = TabName,
            Button = TabButton,
            Content = TabContent,
            Index = tabIndex,
            Indicator = Indicator
        })
        
        local TabMethods = {}
        local elementLayoutCounter = 0

        local function createElementContainer()
            local container = safeInstance("Frame", {
                BackgroundTransparency = 1,
                Size = UDim2.new(0.9, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = elementLayoutCounter
            })
            
            elementLayoutCounter = elementLayoutCounter + 1
            return container
        end

function TabMethods:AddSearchBox(SearchConfig)
    local container = createElementContainer()
    
    local SearchBox = safeInstance("TextBox", {
        Name = "SearchBox",
        PlaceholderText = SearchConfig.Placeholder or "Search...",
        Text = "",
        Font = Fonts.Body,
        TextSize = 14,
        TextColor3 = Theme.Text,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.2,
        Size = UDim2.new(1, 0, 0, 35),
        Position = UDim2.new(0, 0, 0, 0),
        Parent = container
    })
    
    safeInstance("UICorner", {
        Parent = SearchBox,
        CornerRadius = UDim.new(0, 6)
    })
    
    safeInstance("UIStroke", {
        Parent = SearchBox,
        Color = Theme.Stroke,
        Thickness = 2,
        Transparency = 0.3
    })
    
    local searchIcon = safeInstance("ImageLabel", {
        Name = "SearchIcon",
        Image = safeImage("rbxassetid://3926305904"),
        ImageRectOffset = Vector2.new(964, 324),
        ImageRectSize = Vector2.new(36, 36),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -30, 0.5, -10),
        Parent = SearchBox
    })
    
    SearchBox.Focused:Connect(function()
        springTween(SearchBox, {
            Size = UDim2.new(1, 5, 0, 37)
        }, {duration = 0.2})
        
        springTween(searchIcon, {
            ImageColor3 = Theme.Primary
        }, {duration = 0.2})
    end)
    
    SearchBox.FocusLost:Connect(function()
        springTween(SearchBox, {
            Size = UDim2.new(1, 0, 0, 35)
        }, {duration = 0.3})
        
        springTween(searchIcon, {
            ImageColor3 = Theme.Text
        }, {duration = 0.3})
    end)
    
    local function filterElements(searchText)
        searchText = string.lower(searchText)
        
        for _, elementContainer in ipairs(TabContent:GetChildren()) do
            if elementContainer:IsA("Frame") and elementContainer ~= container then
                local elementName = string.lower(elementContainer.Name)
                local found = false
                
                for _, child in ipairs(elementContainer:GetDescendants()) do
                    if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                        local text = string.lower(child.Text or "")
                        if string.find(text, searchText) then
                            found = true
                            break
                        end
                    end
                end
                
                elementContainer.Visible = searchText == "" or string.find(elementName, searchText) or found
            end
        end
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        filterElements(SearchBox.Text)
    end)
    
    container.Parent = TabContent
    
    return {
        ClearSearch = function()
            SearchBox.Text = ""
            filterElements("")
        end,
        SetSearch = function(text)
            SearchBox.Text = text
            filterElements(text)
        end,
        GetSearch = function()
            return SearchBox.Text
        end
    }
end

function TabMethods:AddMultiDropdown(DropdownConfig)
    local container = createElementContainer()
    
    local DropdownLabel = safeInstance("TextLabel", {
        Text = DropdownConfig.Text or "Multi Dropdown",
        Font = Fonts.Body,
        TextSize = 14,
        TextColor3 = Theme.Text,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })
    
    local DropdownButton = safeInstance("TextButton", {
        Name = "DropdownButton",
        Text = DropdownConfig.Default or "Select",
        Font = Fonts.Body,
        TextSize = 14,
        TextColor3 = Theme.Text,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.2,
        AutoButtonColor = false,
        Size = UDim2.new(1, 0, 0, 35),
        Position = UDim2.new(0, 0, 0, 20),
        Parent = container
    })
    
    safeInstance("UICorner", {
        Parent = DropdownButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    safeInstance("UIStroke", {
        Parent = DropdownButton,
        Color = Theme.Stroke,
        Thickness = 2,
        Transparency = 0.3
    })
    
    local Arrow = safeInstance("ImageLabel", {
        Name = "Arrow",
        Image = safeImage("rbxassetid://3926305904"),
        ImageRectOffset = Vector2.new(884, 284),
        ImageRectSize = Vector2.new(36, 36),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 20, 0, 20),
        Position = UDim2.new(1, -25, 0.5, -10),
        Parent = DropdownButton
    })
    
    local OptionsFrame = safeInstance("Frame", {
        Name = "Options",
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.2,
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 60),
        Visible = false,
        ZIndex = 10,
        Parent = container
    })
    
    safeInstance("UICorner", {
        Parent = OptionsFrame,
        CornerRadius = UDim.new(0, 6)
    })
    
    safeInstance("UIStroke", {
        Parent = OptionsFrame,
        Color = Theme.Stroke,
        Thickness = 2,
        Transparency = 0.3
    })
    
    local OptionsLayout = safeInstance("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = OptionsFrame
    })
    
    local open = false
    local selected = {}
    local options = DropdownConfig.Options or {}
    
    local function updateButtonText()
        local count = 0
        for _ in pairs(selected) do
            count = count + 1
        end
        
        if count == 0 then
            DropdownButton.Text = "Select"
        elseif count == 1 then
            for k in pairs(selected) do
                DropdownButton.Text = k
            end
        else
            DropdownButton.Text = string.format("%d selected", count)
        end
    end
    
    for i, option in ipairs(options) do
        local OptionButton = safeInstance("TextButton", {
            Name = option,
            Text = option,
            Font = Fonts.Body,
            TextSize = 14,
            TextColor3 = Theme.Text,
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 0.2,
            AutoButtonColor = false,
            Size = UDim2.new(1, 0, 0, 35),
            LayoutOrder = i,
            ZIndex = 11,
            Parent = OptionsFrame
        })
        
        safeInstance("UICorner", {
            Parent = OptionButton,
            CornerRadius = UDim.new(0, 6)
        })
        
        local OptionCheck = safeInstance("ImageLabel", {
            Name = "Check",
            Image = safeImage("rbxassetid://3926305904"),
            ImageRectOffset = Vector2.new(312, 4),
            ImageRectSize = Vector2.new(24, 24),
            BackgroundTransparency = 1,
            Size = UDim2.new(0, 20, 0, 20),
            Position = UDim2.new(1, -30, 0.5, -10),
            Visible = false,
            ZIndex = 12,
            Parent = OptionButton
        })
        
        OptionButton.MouseButton1Click:Connect(function()
            selected[option] = not selected[option]
            OptionCheck.Visible = selected[option]
            
            if DropdownConfig.Callback then
                local selectedList = {}
                for k, v in pairs(selected) do
                    if v then
                        table.insert(selectedList, k)
                    end
                end
                DropdownConfig.Callback(selectedList)
            end
            
            updateButtonText()
        end)
    end
    
    local function ToggleDropdown()
        open = not open
        OptionsFrame.Visible = open
        
        if open then
            springTween(Arrow, {Rotation = 180}, {duration = 0.2})
            springTween(OptionsFrame, {
                Size = UDim2.new(1, 0, 0, #options * 35)
            }, {duration = 0.2})
        else
            springTween(Arrow, {Rotation = 0}, {duration = 0.2})
            springTween(OptionsFrame, {
                Size = UDim2.new(1, 0, 0, 0)
            }, {duration = 0.2})
        end
    end
    
    DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
    container.Parent = TabContent
    
    updateButtonText()
    
    return {
        SetValues = function(values)
            selected = {}
            for _, value in ipairs(values) do
                selected[value] = true
            end
            
            for _, option in ipairs(OptionsFrame:GetChildren()) do
                if option:IsA("TextButton") then
                    local check = option:FindFirstChild("Check")
                    if check then
                        check.Visible = selected[option.Name] or false
                    end
                end
            end
            
            updateButtonText()
        end,
        GetValues = function()
            local values = {}
            for k, v in pairs(selected) do
                if v then
                    table.insert(values, k)
                end
            end
            return values
        end
    }
end

function TabMethods:AddToggleWithKeybind(ToggleKeybindConfig)
    local container = createElementContainer()
    
    local ToggleButton = safeInstance("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 35),
        Parent = container
    })
    
    local ToggleLabel = safeInstance("TextLabel", {
        Text = ToggleKeybindConfig.Text or "Toggle",
        Font = Fonts.Body,
        TextSize = 14,
        TextColor3 = Theme.Text,
        BackgroundTransparency = 1,
        Size = UDim2.new(0.7, 0, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })
    
    local ToggleBack = safeInstance("Frame", {
        Name = "ToggleBack",
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.2,
        Size = UDim2.new(0, 50, 0, 25),
        Position = UDim2.new(0.7, 0, 0.5, -12.5),
        Parent = container
    })
    
    safeInstance("UICorner", {
        Parent = ToggleBack,
        CornerRadius = UDim.new(1, 0)
    })
    
    safeInstance("UIStroke", {
        Parent = ToggleBack,
        Color = Theme.Stroke,
        Thickness = 2,
        Transparency = 0.3
    })
    
    local ToggleCircle = safeInstance("Frame", {
        Name = "ToggleCircle",
        BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 0,
        Size = UDim2.new(0, 19, 0, 19),
        Position = UDim2.new(0, 3, 0.5, -9.5),
        Parent = ToggleBack
    })
    
    safeInstance("UICorner", {
        Parent = ToggleCircle,
        CornerRadius = UDim.new(1, 0)
    })
    
    safeInstance("UIStroke", {
        Parent = ToggleCircle,
        Color = Theme.Stroke,
        Thickness = 1,
        Transparency = 0.1
    })
    
    local KeybindButton = safeInstance("TextButton", {
        Name = "KeybindButton",
        Text = ToggleKeybindConfig.Keybind and ToggleKeybindConfig.Keybind.Name or "NONE",
        Font = Fonts.Button,
        TextSize = 12,
        TextColor3 = Theme.Text,
        BackgroundColor3 = Theme.Secondary,
        BackgroundTransparency = 0.2,
        AutoButtonColor = false,
        Size = UDim2.new(0, 80, 0.7, 0),
        Position = UDim2.new(0.85, 5, 0.15, 0),
        Parent = container
    })
    
    safeInstance("UICorner", {
        Parent = KeybindButton,
        CornerRadius = UDim.new(0, 6)
    })
    
    safeInstance("UIStroke", {
        Parent = KeybindButton,
        Color = Theme.Stroke,
        Thickness = 1,
        Transparency = 0.3
    })
    
    local state = ToggleKeybindConfig.Default or false
    local keybind = ToggleKeybindConfig.Keybind
    
    local function UpdateToggle()
        if state then
            springTween(ToggleCircle, {
                Position = UDim2.new(1, -22, 0.5, -9.5)
            }, {duration = 0.2})
            
            springTween(ToggleBack, {
                BackgroundColor3 = Theme.Primary
            }, {duration = 0.2})
        else
            springTween(ToggleCircle, {
                Position = UDim2.new(0, 3, 0.5, -9.5)
            }, {duration = 0.2})
            
            springTween(ToggleBack, {
                BackgroundColor3 = Theme.Secondary
            }, {duration = 0.2})
        end
        
        if ToggleKeybindConfig.Callback then
            ToggleKeybindConfig.Callback(state)
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        state = not state
        UpdateToggle()
    end)
    
    local listening = false
    
    KeybindButton.MouseButton1Click:Connect(function()
        listening = true
        KeybindButton.Text = "..."
        KeybindButton.BackgroundColor3 = Theme.Primary
    end)
    
    if UserInputService then
        UserInputService.InputBegan:Connect(function(input)
            if listening then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    keybind = input.KeyCode
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    keybind = Enum.UserInputType.MouseButton1
                end
                
                KeybindButton.Text = tostring(keybind):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "")
                KeybindButton.BackgroundColor3 = Theme.Secondary
                listening = false
                
                if ToggleKeybindConfig.KeybindCallback then
                    ToggleKeybindConfig.KeybindCallback(keybind)
                end
            elseif keybind and input.KeyCode == keybind then
                state = not state
                UpdateToggle()
            end
        end)
    end
    
    UpdateToggle()
    container.Parent = TabContent
    
    return {
        SetState = function(value)
            state = value
            UpdateToggle()
        end,
        GetState = function()
            return state
        end,
        SetKeybind = function(newKey)
            keybind = newKey
            KeybindButton.Text = tostring(newKey):gsub("Enum.KeyCode.", ""):gsub("Enum.UserInputType.", "")
        end,
        GetKeybind = function()
            return keybind
        end
    }
end

        function TabMethods:AddButton(ButtonConfig)
            local container = createElementContainer()
            
            local Button = safeInstance("TextButton", {
                Name = ButtonConfig.Text or "Button",
                Text = ButtonConfig.Text or "Button",
                Font = Fonts.Button,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                AutoButtonColor = false,
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 0, 0)
            })
            
            safeInstance("UICorner", {
                Parent = Button,
                CornerRadius = UDim.new(0, 6)
            })
            
            safeInstance("UIStroke", {
                Parent = Button,
                Color = Theme.Stroke,
                Thickness = 2,
                Transparency = 0.3
            })
            
            Button.MouseEnter:Connect(function()
                springTween(Button, {
                    BackgroundColor3 = Theme.Primary,
                    Size = UDim2.new(1, 5, 0, 42)
                }, {duration = 0.2})
            end)
            
            Button.MouseLeave:Connect(function()
                springTween(Button, {
                    BackgroundColor3 = Theme.Secondary,
                    Size = UDim2.new(1, 0, 0, 40)
                }, {duration = 0.3})
            end)
            
            Button.MouseButton1Click:Connect(function()
                if ButtonConfig.Callback then
                    ButtonConfig.Callback()
                end
                
                springTween(Button, {
                    Size = UDim2.new(0.95, 0, 0, 38)
                }, {duration = 0.1})
                
                wait(0.1)
                
                springTween(Button, {
                    Size = UDim2.new(1, 0, 0, 40)
                }, {duration = 0.2})
            end)
            
            Button.Parent = container
            container.Parent = TabContent
            
            return Button
        end

        function TabMethods:AddToggle(ToggleConfig)
            local container = createElementContainer()
            
            local ToggleButton = safeInstance("TextButton", {
                Text = "",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 35),
                Parent = container
            })
            
            local ToggleLabel = safeInstance("TextLabel", {
                Text = ToggleConfig.Text or "Toggle",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.7, 0, 1, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local ToggleBack = safeInstance("Frame", {
                Name = "ToggleBack",
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                Size = UDim2.new(0, 50, 0, 25),
                Position = UDim2.new(1, -55, 0.5, -12.5),
                Parent = container
            })
            
            safeInstance("UICorner", {
                Parent = ToggleBack,
                CornerRadius = UDim.new(1, 0)
            })
            
            safeInstance("UIStroke", {
                Parent = ToggleBack,
                Color = Theme.Stroke,
                Thickness = 2,
                Transparency = 0.3
            })
            
            local ToggleCircle = safeInstance("Frame", {
                Name = "ToggleCircle",
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 0,
                Size = UDim2.new(0, 19, 0, 19),
                Position = UDim2.new(0, 3, 0.5, -9.5),
                Parent = ToggleBack
            })
            
            safeInstance("UICorner", {
                Parent = ToggleCircle,
                CornerRadius = UDim.new(1, 0)
            })
            
            safeInstance("UIStroke", {
                Parent = ToggleCircle,
                Color = Theme.Stroke,
                Thickness = 1,
                Transparency = 0.1
            })
            
            local state = ToggleConfig.Default or false
            
            local function UpdateToggle()
                if state then
                    springTween(ToggleCircle, {
                        Position = UDim2.new(1, -22, 0.5, -9.5)
                    }, {duration = 0.2})
                    
                    springTween(ToggleBack, {
                        BackgroundColor3 = Theme.Primary
                    }, {duration = 0.2})
                else
                    springTween(ToggleCircle, {
                        Position = UDim2.new(0, 3, 0.5, -9.5)
                    }, {duration = 0.2})
                    
                    springTween(ToggleBack, {
                        BackgroundColor3 = Theme.Secondary
                    }, {duration = 0.2})
                end
                
                if ToggleConfig.Callback then
                    ToggleConfig.Callback(state)
                end
            end
            
            ToggleButton.MouseButton1Click:Connect(function()
                state = not state
                UpdateToggle()
            end)
            
            UpdateToggle()
            container.Parent = TabContent
            
            return {
                SetState = function(value)
                    state = value
                    UpdateToggle()
                end,
                GetState = function()
                    return state
                end
            }
        end

        function TabMethods:AddSlider(SliderConfig)
            local container = createElementContainer()
            
            local SliderLabel = safeInstance("TextLabel", {
                Text = SliderConfig.Text or "Slider",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local ValueLabel = safeInstance("TextLabel", {
                Name = "ValueLabel",
                Text = tostring(SliderConfig.Default or SliderConfig.Min or 0),
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Primary,
                BackgroundTransparency = 1,
                Size = UDim2.new(0.2, 0, 0, 20),
                Position = UDim2.new(0.8, 0, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Right,
                Parent = container
            })
            
            local Track = safeInstance("Frame", {
                Name = "Track",
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                Size = UDim2.new(1, 0, 0, 5),
                Position = UDim2.new(0, 0, 0, 25),
                Parent = container
            })
            
            safeInstance("UICorner", {
                Parent = Track,
                CornerRadius = UDim.new(1, 0)
            })
            
            safeInstance("UIStroke", {
                Parent = Track,
                Color = Theme.Stroke,
                Thickness = 1,
                Transparency = 0.3
            })
            
            local Fill = safeInstance("Frame", {
                Name = "Fill",
                BackgroundColor3 = Theme.Primary,
                BackgroundTransparency = 0,
                Size = UDim2.new(0, 0, 1, 0),
                Parent = Track
            })
            
            safeInstance("UICorner", {
                Parent = Fill,
                CornerRadius = UDim.new(1, 0)
            })
            
            local Handle = safeInstance("Frame", {
                Name = "Handle",
                BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 0,
                Size = UDim2.new(0, 15, 0, 15),
                Position = UDim2.new(0, -7.5, 0.5, -7.5),
                Parent = Track
            })
            
            safeInstance("UICorner", {
                Parent = Handle,
                CornerRadius = UDim.new(1, 0)
            })
            
            safeInstance("UIStroke", {
                Parent = Handle,
                Color = Theme.Stroke,
                Thickness = 2,
                Transparency = 0.1
            })
            
            local min = SliderConfig.Min or 0
            local max = SliderConfig.Max or 100
            local default = SliderConfig.Default or min
            local value = default
            local sliding = false
            
            local function UpdateSlider(newValue)
                value = math.clamp(newValue, min, max)
                local ratio = (value - min) / (max - min)
                Fill.Size = UDim2.new(ratio, 0, 1, 0)
                Handle.Position = UDim2.new(ratio, -7.5, 0.5, -7.5)
                ValueLabel.Text = string.format("%.1f", value)
                
                if SliderConfig.Callback then
                    SliderConfig.Callback(value)
                end
            end
            
            local function UpdateFromInput(input)
                local pos = input.Position.X - Track.AbsolutePosition.X
                local ratio = math.clamp(pos / Track.AbsoluteSize.X, 0, 1)
                UpdateSlider(min + ratio * (max - min))
            end
            
            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    sliding = true
                    UpdateFromInput(input)
                end
            end)
            
            if UserInputService then
                UserInputService.InputChanged:Connect(function(input)
                    if sliding and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                                   input.UserInputType == Enum.UserInputType.Touch) then
                        UpdateFromInput(input)
                    end
                end)
                
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                       input.UserInputType == Enum.UserInputType.Touch then
                        sliding = false
                    end
                end)
            end
            
            UpdateSlider(default)
            container.Parent = TabContent
            
            return {
                SetValue = function(newValue)
                    UpdateSlider(newValue)
                end,
                GetValue = function()
                    return value
                end
            }
        end

        function TabMethods:AddCheckbox(CheckboxConfig)
            elementLayoutCounter = elementLayoutCounter + 1
            local CheckboxFrame = Instance.new("Frame")
            CheckboxFrame.Name = CheckboxConfig.Text or "Checkbox"
            CheckboxFrame.BackgroundTransparency = 1
            CheckboxFrame.Size = UDim2.new(0.9, 0, 0, 35)
            CheckboxFrame.LayoutOrder = elementLayoutCounter

            local CheckboxButton = Instance.new("TextButton")
            CheckboxButton.Text = ""
            CheckboxButton.BackgroundTransparency = 1
            CheckboxButton.Size = UDim2.new(1, 0, 1, 0)
            CheckboxButton.Parent = CheckboxFrame

            local CheckboxLabel = Instance.new("TextLabel")
            CheckboxLabel.Text = CheckboxConfig.Text or "Checkbox"
            CheckboxLabel.Font = Enum.Font.Gotham
            CheckboxLabel.TextSize = 14
            CheckboxLabel.TextColor3 = Theme.Text
            CheckboxLabel.BackgroundTransparency = 1
            CheckboxLabel.Size = UDim2.new(0.7, 0, 1, 0)
            CheckboxLabel.TextXAlignment = Enum.TextXAlignment.Left
            CheckboxLabel.Parent = CheckboxFrame

            local CheckboxBack = Instance.new("Frame")
            CheckboxBack.Name = "CheckboxBack"
            CheckboxBack.BackgroundColor3 = Theme.Secondary
            CheckboxBack.Size = UDim2.new(0, 25, 0, 25)
            CheckboxBack.Position = UDim2.new(1, -30, 0.5, -12.5)

            local backCorner = Instance.new("UICorner")
            backCorner.CornerRadius = UDim.new(0, 5)
            backCorner.Parent = CheckboxBack

            local CheckIcon = Instance.new("ImageLabel")
            CheckIcon.Name = "CheckIcon"
            CheckIcon.Image = safeImage("rbxassetid://3926305904")
            CheckIcon.ImageRectOffset = Vector2.new(312, 4)
            CheckIcon.ImageRectSize = Vector2.new(24, 24)
            CheckIcon.BackgroundTransparency = 1
            CheckIcon.Size = UDim2.new(0.8, 0, 0.8, 0)
            CheckIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
            CheckIcon.Visible = false

            local backStroke = Instance.new("UIStroke")
            backStroke.Color = Theme.Stroke
            backStroke.Thickness = 2
            backStroke.Parent = CheckboxBack

            CheckboxBack.Parent = CheckboxFrame
            CheckIcon.Parent = CheckboxBack

            local state = CheckboxConfig.Default or false
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad)

            local function UpdateCheckbox()
                if state then
                    CheckIcon.Visible = true
                    TweenService:Create(CheckboxBack, tweenInfo, {BackgroundColor3 = Theme.Primary}):Play()
                else
                    CheckIcon.Visible = false
                    TweenService:Create(CheckboxBack, tweenInfo, {BackgroundColor3 = Theme.Secondary}):Play()
                end
                
                if CheckboxConfig.Callback then
                    CheckboxConfig.Callback(state)
                end
            end

            CheckboxButton.MouseButton1Click:Connect(function()
                state = not state
                UpdateCheckbox()
            end)

            UpdateCheckbox()
            CheckboxFrame.Parent = TabContent
            
            return {
                Frame = CheckboxFrame,
                SetState = function(value)
                    state = value
                    UpdateCheckbox()
                end,
                GetState = function()
                    return state
                end
            }
        end

        function TabMethods:AddDropdown(DropdownConfig)
            local container = createElementContainer()
            
            local DropdownLabel = safeInstance("TextLabel", {
                Text = DropdownConfig.Text or "Dropdown",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local DropdownButton = safeInstance("TextButton", {
                Name = "DropdownButton",
                Text = DropdownConfig.Default or "Select",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                AutoButtonColor = false,
                Size = UDim2.new(1, 0, 0, 35),
                Position = UDim2.new(0, 0, 0, 20),
                Parent = container
            })
            
            safeInstance("UICorner", {
                Parent = DropdownButton,
                CornerRadius = UDim.new(0, 6)
            })
            
            safeInstance("UIStroke", {
                Parent = DropdownButton,
                Color = Theme.Stroke,
                Thickness = 2,
                Transparency = 0.3
            })
            
            local Arrow = safeInstance("ImageLabel", {
                Name = "Arrow",
                Image = safeImage("rbxassetid://3926305904"),
                ImageRectOffset = Vector2.new(884, 284),
                ImageRectSize = Vector2.new(36, 36),
                BackgroundTransparency = 1,
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -25, 0.5, -10),
                Parent = DropdownButton
            })
            
            local OptionsFrame = safeInstance("Frame", {
                Name = "Options",
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 60),
                Visible = false,
                ZIndex = 10,
                Parent = container
            })
            
            safeInstance("UICorner", {
                Parent = OptionsFrame,
                CornerRadius = UDim.new(0, 6)
            })
            
            safeInstance("UIStroke", {
                Parent = OptionsFrame,
                Color = Theme.Stroke,
                Thickness = 2,
                Transparency = 0.3
            })
            
            local OptionsLayout = safeInstance("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Parent = OptionsFrame
            })
            
            local open = false
            local selected = DropdownConfig.Default
            local options = DropdownConfig.Options or {}
            
            local function ToggleDropdown()
                open = not open
                OptionsFrame.Visible = open
                
                if open then
                    springTween(Arrow, {Rotation = 180}, {duration = 0.2})
                    springTween(OptionsFrame, {
                        Size = UDim2.new(1, 0, 0, #options * 35)
                    }, {duration = 0.2})
                else
                    springTween(Arrow, {Rotation = 0}, {duration = 0.2})
                    springTween(OptionsFrame, {
                        Size = UDim2.new(1, 0, 0, 0)
                    }, {duration = 0.2})
                end
            end
            
            for i, option in ipairs(options) do
                local OptionButton = safeInstance("TextButton", {
                    Name = option,
                    Text = option,
                    Font = Fonts.Body,
                    TextSize = 14,
                    TextColor3 = Theme.Text,
                    BackgroundColor3 = Theme.Secondary,
                    BackgroundTransparency = 0.2,
                    AutoButtonColor = false,
                    Size = UDim2.new(1, 0, 0, 35),
                    LayoutOrder = i,
                    ZIndex = 11,
                    Parent = OptionsFrame
                })
                
                safeInstance("UICorner", {
                    Parent = OptionButton,
                    CornerRadius = UDim.new(0, 6)
                })
                
                OptionButton.MouseButton1Click:Connect(function()
                    selected = option
                    DropdownButton.Text = option
                    ToggleDropdown()
                    
                    if DropdownConfig.Callback then
                        DropdownConfig.Callback(option)
                    end
                end)
            end
            
            DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
            container.Parent = TabContent
            
            return {
                SetValue = function(value)
                    selected = value
                    DropdownButton.Text = value
                end,
                GetValue = function()
                    return selected
                end
            }
        end

        function TabMethods:AddTextbox(TextboxConfig)
            local container = createElementContainer()
            
            local TextboxLabel = safeInstance("TextLabel", {
                Text = TextboxConfig.Text or "Textbox",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 20),
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = container
            })
            
            local Textbox = safeInstance("TextBox", {
                Name = "Textbox",
                PlaceholderText = TextboxConfig.Placeholder or "Enter text...",
                Text = TextboxConfig.Default or "",
                Font = Fonts.Body,
                TextSize = 14,
                TextColor3 = Theme.Text,
                BackgroundColor3 = Theme.Secondary,
                BackgroundTransparency = 0.2,
                Size = UDim2.new(1, 0, 0, 35),
                Position = UDim2.new(0, 0, 0, 20),
                Parent = container
            })
            
            safeInstance("UICorner", {
                Parent = Textbox,
                CornerRadius = UDim.new(0, 6)
            })
            
            safeInstance("UIStroke", {
                Parent = Textbox,
                Color = Theme.Stroke,
                Thickness = 2,
                Transparency = 0.3
            })
            
            Textbox.FocusLost:Connect(function()
                if TextboxConfig.Callback then
                    TextboxConfig.Callback(Textbox.Text)
                end
            end)
            
            container.Parent = TabContent
            
            return {
                SetText = function(text)
                    Textbox.Text = text
                end,
                GetText = function()
                    return Textbox.Text
                end
            }
        end

        function TabMethods:AddKeybind(KeybindConfig)
            elementLayoutCounter = elementLayoutCounter + 1
            local KeybindFrame = Instance.new("Frame")
            KeybindFrame.Name = KeybindConfig.Text or "Keybind"
            KeybindFrame.BackgroundTransparency = 1
            KeybindFrame.Size = UDim2.new(0.9, 0, 0, 35)
            KeybindFrame.LayoutOrder = elementLayoutCounter

            local KeybindLabel = Instance.new("TextLabel")
            KeybindLabel.Text = KeybindConfig.Text or "Keybind"
            KeybindLabel.Font = Enum.Font.Gotham
            KeybindLabel.TextSize = 14
            KeybindLabel.TextColor3 = Theme.Text
            KeybindLabel.BackgroundTransparency = 1
            KeybindLabel.Size = UDim2.new(0.7, 0, 1, 0)
            KeybindLabel.TextXAlignment = Enum.TextXAlignment.Left
            KeybindLabel.Parent = KeybindFrame

            local KeybindButton = Instance.new("TextButton")
            KeybindButton.Name = "KeybindButton"
            KeybindButton.Text = KeybindConfig.Default and KeybindConfig.Default.Name or "NONE"
            KeybindButton.Font = Enum.Font.GothamBold
            KeybindButton.TextSize = 14
            KeybindButton.TextColor3 = Theme.Text
            KeybindButton.BackgroundColor3 = Theme.Secondary
            KeybindButton.AutoButtonColor = false
            KeybindButton.Size = UDim2.new(0, 100, 0.8, 0)
            KeybindButton.Position = UDim2.new(1, -105, 0.1, 0)

            local btnCorner = Instance.new("UICorner")
            btnCorner.CornerRadius = UDim.new(0, 6)
            btnCorner.Parent = KeybindButton

            local btnStroke = Instance.new("UIStroke")
            btnStroke.Color = Theme.Stroke
            btnStroke.Thickness = 2
            btnStroke.Parent = KeybindButton

            local listening = false
            local currentKey = KeybindConfig.Default
            
            KeybindButton.MouseButton1Click:Connect(function()
                listening = true
                KeybindButton.Text = "..."
                KeybindButton.BackgroundColor3 = Theme.Primary
            end)

            UserInputService.InputBegan:Connect(function(input)
                if listening then
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        currentKey = input.KeyCode
                    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                        currentKey = Enum.UserInputType.MouseButton1
                    end
                    
                    KeybindButton.Text = tostring(currentKey):gsub("Enum.KeyCode.", "")
                    KeybindButton.BackgroundColor3 = Theme.Secondary
                    listening = false
                    
                    if KeybindConfig.Callback then
                        KeybindConfig.Callback(currentKey)
                    end
                end
            end)

            KeybindButton.Parent = KeybindFrame
            KeybindFrame.Parent = TabContent
            
            return {
                Frame = KeybindFrame,
                SetKey = function(key)
                    currentKey = key
                    KeybindButton.Text = tostring(key):gsub("Enum.KeyCode.", "")
                end,
                GetKey = function()
                    return currentKey
                end
            }
        end

        function TabMethods:AddLabel(LabelConfig)
            local container = createElementContainer()
            
            local Label = safeInstance("TextLabel", {
                Text = LabelConfig.Text or "Label",
                Font = Fonts.Label,
                TextSize = LabelConfig.Size or 14,
                TextColor3 = LabelConfig.Color or Theme.Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 25),
                TextXAlignment = LabelConfig.Alignment or Enum.TextXAlignment.Left,
                Parent = container
            })
            
            if LabelConfig.Center then
                Label.TextXAlignment = Enum.TextXAlignment.Center
            end
            
            if LabelConfig.Stroke then
                local stroke = safeInstance("UIStroke", {
                    Color = Theme.Stroke,
                    Thickness = 1,
                    Transparency = 0.3,
                    Parent = Label
                })
            end
            
            container.Parent = TabContent
            
            return Label
        end

        return TabMethods
    end

    return Window
end

return Library
