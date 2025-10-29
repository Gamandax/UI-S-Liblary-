-- // Made By Rodgie \\ --
local Players = game:GetService('Players')
local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')
local RunService = game:GetService('RunService')

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ProtectGui = protectgui or (syn and syn.protect_gui) or (function() end)

local ScreenGui = Instance.new('ScreenGui')
ProtectGui(ScreenGui)
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = CoreGui

-- // Theme Config \\ --
local Library = {
    -- Black Theme Colors WITH TRANSPARENCY
    BlackMain = Color3.fromRGB(25, 25, 25),         -- Main black
    BlackDark = Color3.fromRGB(15, 15, 15),         -- Dark black
    BlackLight = Color3.fromRGB(35, 35, 35),        -- Light black
    GrayAccent = Color3.fromRGB(60, 60, 60),        -- Gray accent
    WhiteText = Color3.fromRGB(255, 255, 255),      -- White text
    GrayText = Color3.fromRGB(180, 180, 180),       -- Gray text
    GreenAccent = Color3.fromRGB(0, 255, 127),      -- Green accent
    RedAccent = Color3.fromRGB(255, 69, 58),        -- Red accent
    Background = Color3.fromRGB(10, 10, 10),        -- Dark background
    
    -- TRANSPARENCY CONFIG --
    MainTransparency = 0.2,      -- Main windows transparency
    ElementTransparency = 0.15,   -- Elements transparency
    FrameTransparency = 0.1,     -- Frame transparency
    
    -- Storage --
    Options = {},
    OpenedFrames = {},
    Signals = {},
    ScreenGui = ScreenGui,
    Windows = {}
}

function Library:Create(Class, Properties)
    local Instance = Instance.new(Class)
    for Property, Value in pairs(Properties) do
        Instance[Property] = Value
    end
    return Instance
end

function Library:CreateLabel(Properties)
    local DefaultProps = {
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamSemibold,
        TextColor3 = Library.WhiteText,
        TextSize = 14,
        TextStrokeTransparency = 1
    }
    
    for prop, value in pairs(DefaultProps) do
        if Properties[prop] == nil then
            Properties[prop] = value
        end
    end
    
    return Library:Create('TextLabel', Properties)
end

function Library:MakeDraggable(Frame, Handle)
    local Handle = Handle or Frame
    Handle.Active = true
    
    local Dragging = false
    local DragStart = nil
    local StartPos = nil
    
    local function UpdateInput(Input)
        local Delta = Input.Position - DragStart
        local NewPosition = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        Frame.Position = NewPosition
    end

    Handle.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPos = Frame.Position
        end
    end)

    Handle.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            if Dragging then
                UpdateInput(Input)
            end
        end
    end)

    Handle.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
        end
    end)
    
    -- Mobile support
    UserInputService.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement and Dragging then
            UpdateInput(Input)
        end
    end)

    UserInputService.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
        end
    end)
end

function Library:IsMouseOverFrame(Frame)
    local AbsPos, AbsSize = Frame.AbsolutePosition, Frame.AbsoluteSize
    return Mouse.X >= AbsPos.X and Mouse.X <= AbsPos.X + AbsSize.X and 
           Mouse.Y >= AbsPos.Y and Mouse.Y <= AbsPos.Y + AbsSize.Y
end

-- Create Open Button (appears when window is closed) - WITH TRANSPARENCY
local OpenButton = Library:Create('TextButton', {
    Name = 'OpenButton',
    BackgroundColor3 = Library.BlackMain,
    BackgroundTransparency = Library.ElementTransparency,
    BorderColor3 = Library.GrayAccent,
    BorderSizePixel = 1,
    Position = UDim2.new(0.5, -30, 0, 10),
    Size = UDim2.fromOffset(60, 25),
    Font = Enum.Font.GothamBold,
    Text = 'Open?',
    TextColor3 = Library.WhiteText,
    TextSize = 12,
    Visible = false,
    ZIndex = 100,
    Parent = ScreenGui
})

function Library:CreateWindow(Title)
    local Window = {
        Tabs = {},
        CurrentTab = nil
    }

    local MainFrame = Library:Create('Frame', {
        Name = 'MainWindow',
        BackgroundColor3 = Library.Background,
        BackgroundTransparency = Library.MainTransparency,
        BorderColor3 = Library.GrayAccent,
        BorderSizePixel = 1,
        Position = UDim2.fromOffset(100, 100),
        Size = UDim2.fromOffset(400, 280),
        ZIndex = 1,
        Parent = ScreenGui
    })

    -- Title Bar - WITH TRANSPARENCY
    local TitleBar = Library:Create('Frame', {
        Name = 'TitleBar',
        BackgroundColor3 = Library.BlackDark,
        BackgroundTransparency = Library.FrameTransparency,
        BorderColor3 = Library.GrayAccent,
        BorderSizePixel = 1,
        Size = UDim2.new(1, 0, 0, 25),
        ZIndex = 2,
        Parent = MainFrame
    })

    local TitleLabel = Library:CreateLabel({
        Name = 'TitleLabel',
        Position = UDim2.fromOffset(5, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Text = Title or 'Library',
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 12,
        Font = Enum.Font.GothamSemibold,
        ZIndex = 3,
        Parent = TitleBar
    })

    -- Close Button - WITH TRANSPARENCY
    local CloseButton = Library:Create('TextButton', {
        Name = 'CloseButton',
        BackgroundColor3 = Library.RedAccent,
        BackgroundTransparency = Library.ElementTransparency,
        BorderColor3 = Library.Background,
        BorderSizePixel = 1,
        Position = UDim2.new(1, -25, 0, 0),
        Size = UDim2.fromOffset(25, 25),
        Font = Enum.Font.GothamBold,
        Text = '×',
        TextColor3 = Library.WhiteText,
        TextSize = 16,
        ZIndex = 3,
        Parent = TitleBar
    })

    -- Close button functionality
    CloseButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
        OpenButton.Visible = true
    end)

    -- Open button functionality
    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true
        OpenButton.Visible = false
    end)

    -- Make draggable using title bar
    Library:MakeDraggable(MainFrame, TitleBar)

    -- LEFT SIDEBAR CONTAINER - COMPACT WITH TRANSPARENCY
    local LeftSidebar = Library:Create('Frame', {
        Name = 'LeftSidebar',
        BackgroundColor3 = Library.BlackDark,
        BackgroundTransparency = Library.FrameTransparency,
        BorderColor3 = Library.GrayAccent,
        BorderSizePixel = 1,
        Position = UDim2.fromOffset(0, 25),
        Size = UDim2.fromOffset(120, 255),
        ZIndex = 2,
        Parent = MainFrame
    })

    -- Tab Container (Vertical tabs on left) - NOW SCROLLABLE
    local TabContainer = Library:Create('ScrollingFrame', {
        Name = 'TabContainer',
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(5, 5),
        Size = UDim2.new(1, -10, 1, -70),
        CanvasSize = UDim2.fromOffset(0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Library.GrayAccent,
        ScrollBarImageTransparency = 0.3,
        ZIndex = 3,
        Parent = LeftSidebar
    })

    local TabLayout = Library:Create('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 3),
        Parent = TabContainer
    })

    -- Update canvas size when tabs change
    TabLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        TabContainer.CanvasSize = UDim2.fromOffset(0, TabLayout.AbsoluteContentSize.Y + 10)
    end)

    -- USER INFO AT BOTTOM OF SIDEBAR - WITH TRANSPARENCY
    local PlayerInfo = Library:Create('Frame', {
        Name = 'PlayerInfo',
        BackgroundColor3 = Library.BlackMain,
        BackgroundTransparency = Library.FrameTransparency,
        BorderColor3 = Library.GrayAccent,
        BorderSizePixel = 1,
        Position = UDim2.new(0, 0, 1, -65),
        Size = UDim2.new(1, 0, 0, 65),
        ZIndex = 2,
        Parent = LeftSidebar
    })

    -- Player Avatar
    local Avatar = Library:Create('ImageLabel', {
        Name = 'Avatar',
        BackgroundColor3 = Library.GrayAccent,
        BackgroundTransparency = Library.ElementTransparency,
        BorderColor3 = Library.WhiteText,
        BorderSizePixel = 1,
        Position = UDim2.fromOffset(8, 8),
        Size = UDim2.fromOffset(35, 35),
        Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100),
        ZIndex = 3,
        Parent = PlayerInfo
    })

    -- Player Name
    local PlayerName = Library:CreateLabel({
        Name = 'PlayerName',
        Position = UDim2.fromOffset(48, 5),
        Size = UDim2.new(1, -53, 0, 20),
        Text = LocalPlayer.Name,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 10,
        Font = Enum.Font.GothamBold,
        ZIndex = 3,
        Parent = PlayerInfo
    })

    -- Player Status
    local PlayerStatus = Library:CreateLabel({
        Name = 'PlayerStatus',
        Position = UDim2.fromOffset(48, 22),
        Size = UDim2.new(1, -53, 0, 15),
        Text = 'Online',
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 8,
        Font = Enum.Font.Gotham,
        TextColor3 = Library.GreenAccent,
        ZIndex = 3,
        Parent = PlayerInfo
    })

    -- RIGHT CONTENT CONTAINER - FIXED WITH PROPER PADDING
    local ContentContainer = Library:Create('Frame', {
        Name = 'ContentContainer',
        BackgroundColor3 = Library.BlackMain,
        BackgroundTransparency = Library.FrameTransparency,
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(120, 25),
        Size = UDim2.new(1, -120, 1, -25),
        ZIndex = 2,
        Parent = MainFrame
    })

    -- ADD PROPER PADDING TO CONTENT CONTAINER
    local ContentPadding = Library:Create('UIPadding', {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        Parent = ContentContainer
    })

    function Window:AddTab(Name)
        local Tab = {
            Elements = {},
            Container = nil
        }

        -- Tab Button (VERTICAL IN LEFT SIDEBAR) - WITH TRANSPARENCY
        local TabButton = Library:Create('TextButton', {
            Name = 'Tab_' .. Name,
            BackgroundColor3 = Library.BlackLight,
            BackgroundTransparency = Library.ElementTransparency,
            BorderColor3 = Library.GrayAccent,
            BorderSizePixel = 1,
            Size = UDim2.new(1, 0, 0, 30),
            Font = Enum.Font.GothamSemibold,
            Text = Name,
            TextColor3 = Library.GrayText,
            TextSize = 11,
            ZIndex = 4,
            Parent = TabContainer
        })

        -- Tab Content (IN RIGHT SIDE) - FIXED SIZING
        local TabContent = Library:Create('ScrollingFrame', {
            Name = 'Content_' .. Name,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.fromOffset(0, 0),
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Library.GrayAccent,
            ScrollBarImageTransparency = 0.3,
            Visible = false,
            ZIndex = 2,
            Parent = ContentContainer
        })

        local ContentLayout = Library:Create('UIListLayout', {
            Padding = UDim.new(0, 4),
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = TabContent
        })

        -- Update canvas size when content changes
        ContentLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            TabContent.CanvasSize = UDim2.fromOffset(0, ContentLayout.AbsoluteContentSize.Y + 10)
        end)

        Tab.Container = TabContent

        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, tab in pairs(Window.Tabs) do
                tab.Container.Visible = false
            end
            
            -- Reset all tab button colors
            for _, button in pairs(TabContainer:GetChildren()) do
                if button:IsA('TextButton') then
                    button.BackgroundColor3 = Library.BlackLight
                    button.TextColor3 = Library.GrayText
                end
            end
            
            -- Show selected tab
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Library.GrayAccent
            TabButton.TextColor3 = Library.WhiteText
            Window.CurrentTab = Tab
        end)

        -- Show first tab by default
        if not Window.CurrentTab then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Library.GrayAccent
            TabButton.TextColor3 = Library.WhiteText
            Window.CurrentTab = Tab
        end

        -- FIXED SLIDER ELEMENT
        function Tab:AddSlider(name, min, max, precise, callback)
            local PreciseValue = precise
            local SliderValue = min or 0
            
            local SliderFrame = Library:Create('Frame', {
                Name = 'Slider_' .. name,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -5, 0, 45),
                ZIndex = 3,
                Parent = Tab.Container
            })

            -- Slider Label
            local SliderLabel = Library:CreateLabel({
                Name = 'SliderLabel',
                Size = UDim2.new(1, -60, 0, 15),
                Text = name or 'Slider',
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 11,
                ZIndex = 4,
                Parent = SliderFrame
            })

            -- Value Display
            local ValueLabel = Library:CreateLabel({
                Name = 'ValueLabel',
                AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, 0, 0, 0),
                Size = UDim2.fromOffset(50, 15),
                Text = tostring(SliderValue),
                TextXAlignment = Enum.TextXAlignment.Right,
                TextSize = 11,
                TextColor3 = Library.GreenAccent,
                ZIndex = 4,
                Parent = SliderFrame
            })

            -- Slider Track (Background)
            local SliderTrack = Library:Create('Frame', {
                Name = 'SliderTrack',
                BackgroundColor3 = Library.BlackLight,
                BackgroundTransparency = Library.ElementTransparency,
                BorderColor3 = Library.GrayAccent,
                BorderSizePixel = 1,
                Position = UDim2.fromOffset(0, 20),
                Size = UDim2.new(1, 0, 0, 20),
                ZIndex = 4,
                Parent = SliderFrame
            })

            -- Slider Fill
            local SliderFill = Library:Create('Frame', {
                Name = 'SliderFill',
                BackgroundColor3 = Library.GreenAccent,
                BackgroundTransparency = Library.ElementTransparency,
                BorderSizePixel = 0,
                Size = UDim2.new(0, 0, 1, 0),
                ZIndex = 5,
                Parent = SliderTrack
            })

            -- Slider Button (Handle)
            local SliderButton = Library:Create('TextButton', {
                Name = 'SliderButton',
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = '',
                ZIndex = 6,
                Parent = SliderTrack
            })

            local Vals = {Min = min or 0, Max = max or 100}
            local isDragging = false
            local connection = nil

            local function UpdateSlider(percentage)
                percentage = math.clamp(percentage, 0, 1)
                local value = Vals.Min + (Vals.Max - Vals.Min) * percentage
                
                if PreciseValue then
                    value = math.floor(value * 100) / 100
                else
                    value = math.floor(value)
                end
                
                SliderValue = value
                ValueLabel.Text = tostring(value)
                
                TweenService:Create(SliderFill, TweenInfo.new(0.1), {
                    Size = UDim2.new(percentage, 0, 1, 0)
                }):Play()
                
                if callback then
                    callback(value)
                end
            end

            SliderButton.MouseButton1Down:Connect(function()
                isDragging = true
                
                if connection then
                    connection:Disconnect()
                    connection = nil
                end
                
                connection = RunService.Heartbeat:Connect(function()
                    if not isDragging then
                        connection:Disconnect()
                        connection = nil
                        return
                    end
                    
                    local mouse = UserInputService:GetMouseLocation()
                    local percentage = (mouse.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X
                    UpdateSlider(percentage)
                end)
            end)

            UserInputService.InputEnded:Connect(function(input)
                if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and isDragging then
                    isDragging = false
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                end
            end)

            local initialPercentage = (SliderValue - Vals.Min) / (Vals.Max - Vals.Min)
            UpdateSlider(initialPercentage)

            SliderButton.MouseEnter:Connect(function()
                TweenService:Create(SliderTrack, TweenInfo.new(0.2), {
                    BorderColor3 = Library.WhiteText
                }):Play()
            end)

            SliderButton.MouseLeave:Connect(function()
                if not isDragging then
                    TweenService:Create(SliderTrack, TweenInfo.new(0.2), {
                        BorderColor3 = Library.GrayAccent
                    }):Play()
                end
            end)

            return {
                SetValue = function(self, value)
                    local percentage = (value - Vals.Min) / (Vals.Max - Vals.Min)
                    UpdateSlider(percentage)
                end,
                GetValue = function(self)
                    return SliderValue
                end
            }
        end

        -- TEXTLABEL ELEMENT
        function Tab:AddTextLabel(text, textSize, textColor)
            local TextLabelFrame = Library:Create('Frame', {
                Name = 'TextLabel_' .. (text or 'Label'),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -5, 0, (textSize or 12) + 8),
                ZIndex = 3,
                Parent = Tab.Container
            })

            local TextLabel = Library:CreateLabel({
                Name = 'TextLabel',
                Position = UDim2.fromOffset(5, 0),
                Size = UDim2.new(1, -10, 1, 0),
                Text = text or 'Text Label',
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = textSize or 12,
                TextColor3 = textColor or Library.WhiteText,
                Font = Enum.Font.GothamSemibold,
                ZIndex = 4,
                Parent = TextLabelFrame
            })

            local PixelBorder = Library:Create('Frame', {
                Name = 'PixelBorder',
                BackgroundColor3 = Library.GrayAccent,
                BackgroundTransparency = Library.ElementTransparency,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(0, (textSize or 12) + 4),
                Size = UDim2.new(1, 0, 0, 1),
                ZIndex = 3,
                Parent = TextLabelFrame
            })

            return {
                SetText = function(self, newText)
                    TextLabel.Text = newText
                end,
                SetColor = function(self, newColor)
                    TextLabel.TextColor3 = newColor
                end,
                GetText = function(self)
                    return TextLabel.Text
                end
            }
        end

        -- BUTTON ELEMENT
        function Tab:AddButton(Text, Callback)
            local Button = Library:Create('TextButton', {
                Name = 'Button_' .. Text,
                BackgroundColor3 = Library.BlackLight,
                BackgroundTransparency = Library.ElementTransparency,
                BorderColor3 = Library.GrayAccent,
                BorderSizePixel = 1,
                Size = UDim2.new(1, -5, 0, 25),
                Font = Enum.Font.GothamSemibold,
                Text = Text,
                TextColor3 = Library.WhiteText,
                TextSize = 11,
                ZIndex = 3,
                Parent = Tab.Container
            })

            Button.MouseButton1Click:Connect(function()
                if Callback then
                    Callback()
                end
            end)

            Button.MouseEnter:Connect(function()
                Button.BackgroundColor3 = Library.GrayAccent
            end)

            Button.MouseLeave:Connect(function()
                Button.BackgroundColor3 = Library.BlackLight
            end)

            return Button
        end

        -- TOGGLE ELEMENT
        function Tab:AddToggle(Text, Default, Callback)
            local ToggleValue = Default or false
            
            local ToggleFrame = Library:Create('Frame', {
                Name = 'Toggle_' .. Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -5, 0, 35),
                ZIndex = 3,
                Parent = Tab.Container
            })

            local ToggleLabel = Library:CreateLabel({
                Name = 'ToggleLabel',
                Position = UDim2.fromOffset(0, 0),
                Size = UDim2.new(1, -50, 1, 0),
                Text = Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 11,
                ZIndex = 4,
                Parent = ToggleFrame
            })

            local ToggleBG = Library:Create('Frame', {
                Name = 'ToggleBG',
                BackgroundColor3 = ToggleValue and Library.GreenAccent or Library.GrayAccent,
                BackgroundTransparency = Library.ElementTransparency,
                BorderColor3 = Library.WhiteText,
                BorderSizePixel = 1,
                Position = UDim2.new(1, -40, 0.5, -8),
                Size = UDim2.fromOffset(40, 16),
                ZIndex = 4,
                Parent = ToggleFrame
            })

            local ToggleCircle = Library:Create('Frame', {
                Name = 'ToggleCircle',
                BackgroundColor3 = Library.WhiteText,
                BackgroundTransparency = Library.ElementTransparency,
                BorderColor3 = Library.Background,
                BorderSizePixel = 1,
                Position = UDim2.fromOffset(ToggleValue and 22 or 2, 2),
                Size = UDim2.fromOffset(12, 12),
                ZIndex = 5,
                Parent = ToggleBG
            })

            local ToggleButton = Library:Create('TextButton', {
                Name = 'ToggleButton',
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                Text = '',
                ZIndex = 6,
                Parent = ToggleBG
            })

            ToggleButton.MouseButton1Click:Connect(function()
                ToggleValue = not ToggleValue
                
                local CirclePos = ToggleValue and 22 or 2
                local BGColor = ToggleValue and Library.GreenAccent or Library.GrayAccent
                
                TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
                    Position = UDim2.fromOffset(CirclePos, 2)
                }):Play()
                
                TweenService:Create(ToggleBG, TweenInfo.new(0.2), {
                    BackgroundColor3 = BGColor
                }):Play()
                
                if Callback then
                    Callback(ToggleValue)
                end
            end)

            return {
                SetValue = function(self, Value)
                    ToggleValue = Value
                    local CirclePos = ToggleValue and 22 or 2
                    local BGColor = ToggleValue and Library.GreenAccent or Library.GrayAccent
                    ToggleCircle.Position = UDim2.fromOffset(CirclePos, 2)
                    ToggleBG.BackgroundColor3 = BGColor
                end
            }
        end

        -- TEXTBOX ELEMENT
        function Tab:AddTextbox(Text, PlaceholderText, Callback)
            local TextboxFrame = Library:Create('Frame', {
                Name = 'Textbox_' .. Text,
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -5, 0, 45),
                ZIndex = 3,
                Parent = Tab.Container
            })

            if Text and Text ~= '' then
                local TextboxLabel = Library:CreateLabel({
                    Name = 'TextboxLabel',
                    Size = UDim2.new(1, 0, 0, 15),
                    Text = Text,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextSize = 10,
                    ZIndex = 4,
                    Parent = TextboxFrame
                })
            end

            local Textbox = Library:Create('TextBox', {
                Name = 'Textbox',
                BackgroundColor3 = Library.BlackLight,
                BackgroundTransparency = Library.ElementTransparency,
                BorderColor3 = Library.GrayAccent,
                BorderSizePixel = 1,
                Position = UDim2.fromOffset(0, Text and Text ~= '' and 18 or 0),
                Size = UDim2.new(1, 0, 0, 25),
                Font = Enum.Font.Gotham,
                PlaceholderText = PlaceholderText or 'Enter text...',
                PlaceholderColor3 = Library.GrayText,
                Text = '',
                TextColor3 = Library.WhiteText,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Left,
                ZIndex = 4,
                Parent = TextboxFrame
            })

            local TextboxPadding = Library:Create('UIPadding', {
                PaddingLeft = UDim.new(0, 5),
                PaddingRight = UDim.new(0, 5),
                Parent = Textbox
            })

            Textbox.FocusLost:Connect(function(EnterPressed)
                if Callback then
                    Callback(Textbox.Text)
                end
            end)

            Textbox.Focused:Connect(function()
                Textbox.BorderColor3 = Library.WhiteText end)

Textbox.FocusLost:Connect(function()
            Textbox.BorderColor3 = Library.GrayAccent
        end)

        return {
            SetText = function(self, NewText)
                Textbox.Text = NewText
            end,
            GetText = function(self)
                return Textbox.Text
            end
        }
    end

    -- MULTIDROPDOWN ELEMENT - WITH TRANSPARENCY
    function Tab:AddMultiDropdown(Idx, Info)
        local Dropdown = {
            Values = Info.Values or {},
            Value = {},
            Multi = true,
            Type = 'MultiDropdown'
        }

        -- Main Dropdown Frame
        local DropdownFrame = Library:Create('Frame', {
            Name = 'Dropdown_' .. Idx,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -5, 0, 50),
            ZIndex = 3,
            Parent = Tab.Container
        })

        -- Dropdown Label
        if Info.Text then
            local DropdownLabel = Library:CreateLabel({
                Name = 'DropdownLabel',
                Size = UDim2.new(1, 0, 0, 15),
                Text = Info.Text,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 10,
                ZIndex = 4,
                Parent = DropdownFrame
            })
        end

        -- Main Dropdown Button - WITH TRANSPARENCY
        local DropdownButton = Library:Create('TextButton', {
            Name = 'DropdownButton',
            BackgroundColor3 = Library.BlackLight,
            BackgroundTransparency = Library.ElementTransparency,
            BorderColor3 = Library.GrayAccent,
            BorderSizePixel = 1,
            Position = UDim2.fromOffset(0, Info.Text and 18 or 0),
            Size = UDim2.new(1, 0, 0, 25),
            Font = Enum.Font.Gotham,
            Text = '--',
            TextColor3 = Library.WhiteText,
            TextSize = 10,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 4,
            Parent = DropdownFrame
        })

        -- Add padding
        local DropdownPadding = Library:Create('UIPadding', {
            PaddingLeft = UDim.new(0, 5),
            Parent = DropdownButton
        })

        -- Dropdown Arrow
        local Arrow = Library:CreateLabel({
            Name = 'Arrow',
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -5, 0.5, 0),
            Size = UDim2.fromOffset(10, 10),
            Text = 'v',
            TextColor3 = Library.GrayText,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextSize = 10,
            ZIndex = 5,
            Parent = DropdownButton
        })

        -- Options Container - WITH TRANSPARENCY
        local OptionsContainer = Library:Create('Frame', {
            Name = 'OptionsContainer',
            BackgroundColor3 = Library.Background,
            BackgroundTransparency = Library.FrameTransparency,
            BorderColor3 = Library.GrayAccent,
            BorderSizePixel = 1,
            Position = UDim2.fromOffset(0, (Info.Text and 18 or 0) + 25),
            Size = UDim2.new(1, 0, 0, math.min(#Dropdown.Values * 20, 100)),
            Visible = false,
            ZIndex = 10,
            Parent = DropdownFrame
        })

        local OptionsScrolling = Library:Create('ScrollingFrame', {
            Name = 'OptionsScrolling',
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.fromOffset(0, #Dropdown.Values * 20),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Library.GrayAccent,
            ScrollBarImageTransparency = 0.3,
            ZIndex = 11,
            Parent = OptionsContainer
        })

        local OptionsLayout = Library:Create('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = OptionsScrolling
        })

        function Dropdown:UpdateDisplay()
            local selectedItems = {}
            for value, selected in pairs(Dropdown.Value) do
                if selected then
                    table.insert(selectedItems, value)
                end
            end
            
            if #selectedItems > 0 then
                DropdownButton.Text = table.concat(selectedItems, ', ')
            else
                DropdownButton.Text = '--'
            end
        end

        function Dropdown:CreateOptions()
            -- Clear existing options
            for _, child in pairs(OptionsScrolling:GetChildren()) do
                if child ~= OptionsLayout then
                    child:Destroy()
                end
            end

            -- Create new options
            for i, value in ipairs(Dropdown.Values) do
                local OptionButton = Library:Create('TextButton', {
                    Name = 'Option_' .. value,
                    BackgroundColor3 = Library.BlackLight,
                    BackgroundTransparency = Library.ElementTransparency,
                    BorderColor3 = Library.GrayAccent,
                    BorderSizePixel = 1,
                    Size = UDim2.new(1, -2, 0, 20),
                    Font = Enum.Font.Gotham,
                    Text = value,
                    TextColor3 = Library.WhiteText,
                    TextSize = 10,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 12,
                    Parent = OptionsScrolling
                })

                -- Add padding
                local OptionPadding = Library:Create('UIPadding', {
                    PaddingLeft = UDim.new(0, 5),
                    Parent = OptionButton
                })

                -- Selection indicator
                local Indicator = Library:CreateLabel({
                    Name = 'Indicator',
                    AnchorPoint = Vector2.new(1, 0.5),
                    Position = UDim2.new(1, -5, 0.5, 0),
                    Size = UDim2.fromOffset(10, 10),
                    Text = '',
                    TextColor3 = Library.GreenAccent,
                    TextSize = 10,
                    ZIndex = 13,
                    Parent = OptionButton
                })

                local function updateOption()
                    if Dropdown.Value[value] then
                        OptionButton.BackgroundColor3 = Library.GrayAccent
                        Indicator.Text = '✓'
                    else
                        OptionButton.BackgroundColor3 = Library.BlackLight
                        Indicator.Text = ''
                    end
                end

                OptionButton.MouseButton1Click:Connect(function()
                    Dropdown.Value[value] = not Dropdown.Value[value]
                    updateOption()
                    Dropdown:UpdateDisplay()
                    
                    if Info.Callback then
                        Info.Callback(Dropdown.Value)
                    end
                end)

                updateOption()
            end

            OptionsScrolling.CanvasSize = UDim2.fromOffset(0, #Dropdown.Values * 20)
        end

        function Dropdown:SetValues(newValues)
            Dropdown.Values = newValues or {}
            Dropdown.Value = {}
            Dropdown:CreateOptions()
            Dropdown:UpdateDisplay()
        end

        function Dropdown:SetValue(newValue)
            Dropdown.Value = newValue or {}
            Dropdown:UpdateDisplay()
            
            
            for _, child in pairs(OptionsScrolling:GetChildren()) do
                if child:IsA('TextButton') then
                    local value = child.Text
                    local indicator = child:FindFirstChild('Indicator')
                    if Dropdown.Value[value] then
                        child.BackgroundColor3 = Library.GrayAccent
                        if indicator then indicator.Text = '✓' end
                    else
                        child.BackgroundColor3 = Library.BlackLight
                        if indicator then indicator.Text = '' end
                    end
                end
            end
        end

        
        DropdownButton.MouseButton1Click:Connect(function()
            OptionsContainer.Visible = not OptionsContainer.Visible
            Arrow.Text = OptionsContainer.Visible and '^' or 'v'
            
            if OptionsContainer.Visible then
                Library.OpenedFrames[OptionsContainer] = true
                DropdownFrame.Size = UDim2.new(1, -5, 0, (Info.Text and 18 or 0) + 25 + math.min(#Dropdown.Values * 20, 100) + 5)
            else
                Library.OpenedFrames[OptionsContainer] = nil
                DropdownFrame.Size = UDim2.new(1, -5, 0, (Info.Text and 43 or 25))
            end
        end)

        
        UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and OptionsContainer.Visible then
                if not Library:IsMouseOverFrame(OptionsContainer) and not Library:IsMouseOverFrame(DropdownButton) then
                    OptionsContainer.Visible = false
                    Arrow.Text = 'v'
                    Library.OpenedFrames[OptionsContainer] = nil
                    DropdownFrame.Size = UDim2.new(1, -5, 0, (Info.Text and 43 or 25))
                end
            end
        end)

        
        Dropdown:CreateOptions()
        Dropdown:UpdateDisplay()

        
        if Info.Default then
            if type(Info.Default) == 'table' then
                for _, value in ipairs(Info.Default) do
                    if table.find(Dropdown.Values, value) then
                        Dropdown.Value[value] = true
                    end
                end
            elseif table.find(Dropdown.Values, Info.Default) then
                Dropdown.Value[Info.Default] = true
            end
            Dropdown:UpdateDisplay()
        end

        Library.Options[Idx] = Dropdown
        table.insert(Tab.Elements, Dropdown)

        return Dropdown
    end

    Window.Tabs[Name] = Tab
    return Tab
end

Window.MainFrame = MainFrame
table.insert(Library.Windows, Window)
return Window

end

function Library:Toggle()
    for _, window in pairs(Library.Windows) do
        if window.MainFrame then
            window.MainFrame.Visible = not window.MainFrame.Visible
            if window.MainFrame.Visible then
                OpenButton.Visible = false
            else
                OpenButton.Visible = true
            end
        end
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        Library:Toggle()
    end
end)

return Library
