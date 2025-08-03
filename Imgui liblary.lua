-- Imgui liblary 
local ImGui = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Colors = {
    Background = Color3.fromRGB(37, 37, 38),
    WindowBg = Color3.fromRGB(45, 45, 48),
    Header = Color3.fromRGB(51, 51, 55),
    HeaderHovered = Color3.fromRGB(61, 61, 65),
    Button = Color3.fromRGB(67, 67, 70),
    ButtonHovered = Color3.fromRGB(77, 77, 80),
    ButtonActive = Color3.fromRGB(87, 87, 90),
    Frame = Color3.fromRGB(40, 40, 43),
    FrameHovered = Color3.fromRGB(50, 50, 53),
    Text = Color3.fromRGB(255, 255, 255),
    TextDisabled = Color3.fromRGB(128, 128, 128),
    Border = Color3.fromRGB(78, 78, 78),
    Toggle = Color3.fromRGB(0, 119, 200),
    ToggleHovered = Color3.fromRGB(39, 128, 227)
}

function ImGui:CreateWindow(title, size)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ImGuiInterface"
    screenGui.Parent = playerGui
    screenGui.ResetOnSpawn = false
  
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainWindow"
    mainFrame.Size = size or UDim2.new(0, 300, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
    mainFrame.BackgroundColor3 = Colors.WindowBg
    mainFrame.BorderSizePixel = 1
    mainFrame.BorderColor3 = Colors.Border
    mainFrame.Parent = screenGui
    
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 25)
    titleBar.BackgroundColor3 = Colors.Header
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleText = Instance.new("TextLabel")
    titleText.Size = UDim2.new(1, -5, 1, 0)
    titleText.Position = UDim2.new(0, 5, 0, 0)
    titleText.BackgroundTransparency = 1
    titleText.Text = title or "ImGui Window"
    titleText.TextColor3 = Colors.Text
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Font = Enum.Font.SourceSans
    titleText.TextSize = 14
    titleText.Parent = titleBar
    
    local contentArea = Instance.new("ScrollingFrame")
    contentArea.Name = "ContentArea"
    contentArea.Size = UDim2.new(1, 0, 1, -25)
    contentArea.Position = UDim2.new(0, 0, 0, 25)
    contentArea.BackgroundColor3 = Colors.Background
    contentArea.BorderSizePixel = 0
    contentArea.ScrollBarThickness = 8
    contentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentArea.Parent = mainFrame
    
    local dragging = false
    local dragStart, startPos
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    local window = {
        ScreenGui = screenGui,
        MainFrame = mainFrame,
        ContentArea = contentArea,
        YOffset = 5
    }
    
    return window
end

function ImGui:CollapsingHeader(window, text, defaultOpen)
    local isOpen = defaultOpen or false
    
    local headerFrame = Instance.new("Frame")
    headerFrame.Size = UDim2.new(1, -10, 0, 20)
    headerFrame.Position = UDim2.new(0, 5, 0, window.YOffset)
    headerFrame.BackgroundColor3 = Colors.Header
    headerFrame.BorderSizePixel = 0
    headerFrame.Parent = window.ContentArea
    
    local arrowButton = Instance.new("TextButton")
    arrowButton.Size = UDim2.new(0, 20, 1, 0)
    arrowButton.BackgroundTransparency = 1
    arrowButton.Text = isOpen and "▼" or "▶"
    arrowButton.TextColor3 = Colors.Text
    arrowButton.TextSize = 12
    arrowButton.Font = Enum.Font.SourceSans
    arrowButton.Parent = headerFrame
    
    local headerText = Instance.new("TextLabel")
    headerText.Size = UDim2.new(1, -25, 1, 0)
    headerText.Position = UDim2.new(0, 20, 0, 0)
    headerText.BackgroundTransparency = 1
    headerText.Text = text
    headerText.TextColor3 = Colors.Text
    headerText.TextXAlignment = Enum.TextXAlignment.Left
    headerText.Font = Enum.Font.SourceSans
    headerText.TextSize = 14
    headerText.Parent = headerFrame
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 0, 0)
    contentFrame.Position = UDim2.new(0, 10, 0, window.YOffset + 25)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = isOpen
    contentFrame.Parent = window.ContentArea
  
    headerFrame.MouseEnter:Connect(function()
        headerFrame.BackgroundColor3 = Colors.HeaderHovered
    end)
    
    headerFrame.MouseLeave:Connect(function()
        headerFrame.BackgroundColor3 = Colors.Header
    end)
    
    arrowButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        arrowButton.Text = isOpen and "▼" or "▶"
        
        local targetSize = isOpen and UDim2.new(1, -20, 0, contentFrame.AbsoluteCanvasSize.Y) or UDim2.new(1, -20, 0, 0)
        
        local tween = TweenService:Create(contentFrame, 
            TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {Size = targetSize}
        )
        
        contentFrame.Visible = true
        tween:Play()
        
        if not isOpen then
            tween.Completed:Connect(function()
                contentFrame.Visible = false
            end)
        end
    end)
    
    window.YOffset = window.YOffset + 25
    
    return {
        Frame = contentFrame,
        YOffset = 5,
        Window = window
    }
end

function ImGui:Button(parent, text, size, callback)
    local yPos = parent.YOffset or 0
    
    local button = Instance.new("TextButton")
    button.Size = size or UDim2.new(1, -10, 0, 25)
    button.Position = UDim2.new(0, 5, 0, yPos)
    button.BackgroundColor3 = Colors.Button
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Colors.Text
    button.TextSize = 14
    button.Font = Enum.Font.SourceSans
    button.Parent = parent.Frame or parent.ContentArea
    
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Colors.ButtonHovered
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Colors.Button
    end)
    
    button.MouseButton1Down:Connect(function()
        button.BackgroundColor3 = Colors.ButtonActive
    end)
    
    button.MouseButton1Up:Connect(function()
        button.BackgroundColor3 = Colors.ButtonHovered
    end)
    
    if callback then
        button.MouseButton1Click:Connect(callback)
    end
    
    if parent.YOffset then
        parent.YOffset = parent.YOffset + 30
    else
        parent.Window.YOffset = parent.Window.YOffset + 30
    end
    
    return button
end

function ImGui:Toggle(parent, text, defaultValue, callback)
    local yPos = parent.YOffset or 0
    local isToggled = defaultValue or false
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -10, 0, 20)
    toggleFrame.Position = UDim2.new(0, 5, 0, yPos)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = parent.Frame or parent.ContentArea
    
    local checkbox = Instance.new("TextButton")
    checkbox.Size = UDim2.new(0, 15, 0, 15)
    checkbox.Position = UDim2.new(0, 0, 0, 2)
    checkbox.BackgroundColor3 = isToggled and Colors.Toggle or Colors.Frame
    checkbox.BorderSizePixel = 1
    checkbox.BorderColor3 = Colors.Border
    checkbox.Text = isToggled and "✓" or ""
    checkbox.TextColor3 = Colors.Text
    checkbox.TextSize = 12
    checkbox.Font = Enum.Font.SourceSans
    checkbox.Parent = toggleFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 1, 0)
    label.Position = UDim2.new(0, 20, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Colors.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextSize = 14
    label.Font = Enum.Font.SourceSans
    label.Parent = toggleFrame
    
    checkbox.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        checkbox.BackgroundColor3 = isToggled and Colors.Toggle or Colors.Frame
        checkbox.Text = isToggled and "✓" or ""
        
        if callback then
            callback(isToggled)
        end
    end)
    
    if parent.YOffset then
        parent.YOffset = parent.YOffset + 25
    else
        parent.Window.YOffset = parent.Window.YOffset + 25
    end
    
    return {
        Frame = toggleFrame,
        GetValue = function() return isToggled end,
        SetValue = function(value)
            isToggled = value
            checkbox.BackgroundColor3 = isToggled and Colors.Toggle or Colors.Frame
            checkbox.Text = isToggled and "✓" or ""
        end
    }
end


function ImGui:InputText(parent, placeholder, defaultText, callback)
    local yPos = parent.YOffset or 0
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -10, 0, 25)
    textBox.Position = UDim2.new(0, 5, 0, yPos)
    textBox.BackgroundColor3 = Colors.Frame
    textBox.BorderSizePixel = 1
    textBox.BorderColor3 = Colors.Border
    textBox.Text = defaultText or ""
    textBox.PlaceholderText = placeholder
    textBox.TextColor3 = Colors.Text
    textBox.PlaceholderColor3 = Colors.TextDisabled
    textBox.TextSize = 14
    textBox.Font = Enum.Font.SourceSans
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.Parent = parent.Frame or parent.ContentArea
    
  
    textBox.Focused:Connect(function()
        textBox.BorderColor3 = Colors.Toggle
    end)
    
    textBox.FocusLost:Connect(function()
        textBox.BorderColor3 = Colors.Border
        if callback then
            callback(textBox.Text)
        end
    end)
    
    if parent.YOffset then
        parent.YOffset = parent.YOffset + 30
    else
        parent.Window.YOffset = parent.Window.YOffset + 30
    end
    
    return textBox
end


function ImGui:Slider(parent, label, min, max, defaultValue, callback)
    local yPos = parent.YOffset or 0
    local currentValue = defaultValue or min
    
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -10, 0, 40)
    sliderFrame.Position = UDim2.new(0, 5, 0, yPos)
    sliderFrame.BackgroundTransparency = 1
    sliderFrame.Parent = parent.Frame or parent.ContentArea
    
    local labelText = Instance.new("TextLabel")
    labelText.Size = UDim2.new(1, 0, 0, 15)
    labelText.BackgroundTransparency = 1
    labelText.Text = label .. ": " .. tostring(currentValue)
    labelText.TextColor3 = Colors.Text
    labelText.TextXAlignment = Enum.TextXAlignment.Left
    labelText.TextSize = 14
    labelText.Font = Enum.Font.SourceSans
    labelText.Parent = sliderFrame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, 0, 0, 20)
    sliderBg.Position = UDim2.new(0, 0, 0, 20)
    sliderBg.BackgroundColor3 = Colors.Frame
    sliderBg.BorderSizePixel = 1
    sliderBg.BorderColor3 = Colors.Border
    sliderBg.Parent = sliderFrame
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((currentValue - min) / (max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Colors.Toggle
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    
    local sliderButton = Instance.new("TextButton")
    sliderButton.Size = UDim2.new(0, 10, 1, 0)
    sliderButton.Position = UDim2.new((currentValue - min) / (max - min), -5, 0, 0)
    sliderButton.BackgroundColor3 = Colors.Text
    sliderButton.BorderSizePixel = 0
    sliderButton.Text = ""
    sliderButton.Parent = sliderBg
    
    local function updateSlider(value)
        currentValue = math.clamp(value, min, max)
        local percentage = (currentValue - min) / (max - min)
        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
        sliderButton.Position = UDim2.new(percentage, -5, 0, 0)
        labelText.Text = label .. ": " .. tostring(math.floor(currentValue * 100) / 100)
        
        if callback then
            callback(currentValue)
        end
    end
    
    local dragging = false
    sliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mouseX = input.Position.X
            local sliderX = sliderBg.AbsolutePosition.X
            local sliderWidth = sliderBg.AbsoluteSize.X
            local percentage = math.clamp((mouseX - sliderX) / sliderWidth, 0, 1)
            local newValue = min + (max - min) * percentage
            updateSlider(newValue)
        end
    end)
    
    if parent.YOffset then
        parent.YOffset = parent.YOffset + 45
    else
        parent.Window.YOffset = parent.Window.YOffset + 45
    end
    
    return {
        GetValue = function() return currentValue end,
        SetValue = updateSlider
    }
end

function ImGui:ColorPicker(parent, label, defaultColor, callback)
    local yPos = parent.YOffset or 0
    local currentColor = defaultColor or Color3.fromRGB(255, 255, 255)
    
    local colorFrame = Instance.new("Frame")
    colorFrame.Size = UDim2.new(1, -10, 0, 25)
    colorFrame.Position = UDim2.new(0, 5, 0, yPos)
    colorFrame.BackgroundTransparency = 1
    colorFrame.Parent = parent.Frame or parent.ContentArea
    
    local colorLabel = Instance.new("TextLabel")
    colorLabel.Size = UDim2.new(0.7, 0, 1, 0)
    colorLabel.BackgroundTransparency = 1
    colorLabel.Text = label
    colorLabel.TextColor3 = Colors.Text
    colorLabel.TextXAlignment = Enum.TextXAlignment.Left
    colorLabel.TextSize = 14
    colorLabel.Font = Enum.Font.SourceSans
    colorLabel.Parent = colorFrame
    
    local colorDisplay = Instance.new("Frame")
    colorDisplay.Size = UDim2.new(0.25, 0, 0.8, 0)
    colorDisplay.Position = UDim2.new(0.7, 5, 0.1, 0)
    colorDisplay.BackgroundColor3 = currentColor
    colorDisplay.BorderSizePixel = 1
    colorDisplay.BorderColor3 = Colors.Border
    colorDisplay.Parent = colorFrame
    
    local colorButton = Instance.new("TextButton")
    colorButton.Size = UDim2.new(1, 0, 1, 0)
    colorButton.BackgroundTransparency = 1
    colorButton.Text = ""
    colorButton.Parent = colorDisplay
    
    colorButton.MouseButton1Click:Connect(function()
        -- Simple color cycling for demo
        local colors = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 0, 255),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(255, 0, 255),
            Color3.fromRGB(0, 255, 255),
            Color3.fromRGB(255, 255, 255)
        }
        
        local currentIndex = 1
        for i, color in ipairs(colors) do
            if color == currentColor then
                currentIndex = i
                break
            end
        end
        
        currentIndex = currentIndex % #colors + 1
        currentColor = colors[currentIndex]
        colorDisplay.BackgroundColor3 = currentColor
        
        if callback then
            callback(currentColor)
        end
    end)
    
    if parent.YOffset then
        parent.YOffset = parent.YOffset + 30
    else
        parent.Window.YOffset = parent.Window.YOffset + 30
    end
    
    return {
        GetValue = function() return currentColor end,
        SetValue = function(color)
            currentColor = color
            colorDisplay.BackgroundColor3 = currentColor
        end
    }
end

local function CreateExampleInterface()
  
    local window = ImGui:CreateWindow("ImGui Example", UDim2.new(0, 350, 0, 500))
    
  
    ImGui:Button(window, "Main Button", nil, function()
        print("Main button clicked!")
    end)
    
    ImGui:Toggle(window, "Enable Feature", false, function(value)
        print("Toggle changed:", value)
    end)
    
    ImGui:InputText(window, "Enter text...", "Default text", function(text)
        print("Text entered:", text)
    end)
    
  
    local settingsSection = ImGui:CollapsingHeader(window, "Settings", true)
    
    ImGui:Button(settingsSection, "Settings Button", nil, function()
        print("Settings button clicked!")
    end)
    
    ImGui:Slider(settingsSection, "Volume", 0, 100, 50, function(value)
        print("Volume:", value)
    end)
    
    ImGui:ColorPicker(settingsSection, "Theme Color", Color3.fromRGB(0, 119, 200), function(color)
        print("Color selected:", color)
    end)
    
    local advancedSection = ImGui:CollapsingHeader(window, "Advanced", false)
    
    ImGui:Toggle(advancedSection, "Debug Mode", false, function(value)
        print("Debug mode:", value)
    end)
    
    ImGui:InputText(advancedSection, "API Key", "", function(text)
        print("API Key entered:", text)
    end)
  
    window.ContentArea.CanvasSize = UDim2.new(0, 0, 0, window.YOffset + 10)
end

CreateExampleInterface()

return ImGui
