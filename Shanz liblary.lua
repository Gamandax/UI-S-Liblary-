-- Shanz liblary 
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("ShortUI") then
    CoreGui.ShortUI:Destroy()
end

local lib = {}

function lib:Window(title)
    title = title or "Short UI"
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "ShortUI"
    gui.Parent = CoreGui
    
    local main = Instance.new("Frame")
    main.Name = "Main"
    main.Size = UDim2.new(0, 400, 0, 300)
    main.Position = UDim2.new(0.5, -200, 0.5, -150)
    main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    main.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = main
    
    local topbar = Instance.new("Frame")
    topbar.Size = UDim2.new(1, 0, 0, 30)
    topbar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topbar.Parent = main
    
    local topCorner = Instance.new("UICorner")
    topCorner.CornerRadius = UDim.new(0, 6)
    topCorner.Parent = topbar
    
    local topFix = Instance.new("Frame")
    topFix.Size = UDim2.new(1, 0, 0.5, 0)
    topFix.Position = UDim2.new(0, 0, 0.5, 0)
    topFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    topFix.BorderSizePixel = 0
    topFix.Parent = topbar
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -60, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.Parent = topbar
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 20, 0, 20)
    closeBtn.Position = UDim2.new(1, -25, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
    closeBtn.Text = "×"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.Parent = topbar
    
    local closeBtnCorner = Instance.new("UICorner")
    closeBtnCorner.CornerRadius = UDim.new(0, 3)
    closeBtnCorner.Parent = closeBtn
    
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    -- Make draggable ( Only PC support btw )
    local dragging = false
    local dragStart, startPos
    
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                     startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -20, 1, -40)
    content.Position = UDim2.new(0, 10, 0, 35)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 4
    content.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.Parent = main
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = content
    
    local window = {}
    
    function window:Button(text, callback)
        text = text or "Button"
        callback = callback or function() end
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.Text = text
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.Parent = content
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
        end)
        
        btn.MouseButton1Click:Connect(callback)
        
        return btn
    end
    
    function window:Toggle(text, default, callback)
        text = text or "Toggle"
        default = default or false
        callback = callback or function() end
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 30)
        toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        toggleFrame.Parent = content
        
        local toggleCorner = Instance.new("UICorner")
        toggleCorner.CornerRadius = UDim.new(0, 4)
        toggleCorner.Parent = toggleFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -50, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = toggleFrame
        
        local switch = Instance.new("Frame")
        switch.Size = UDim2.new(0, 35, 0, 18)
        switch.Position = UDim2.new(1, -40, 0.5, -9)
        switch.BackgroundColor3 = default and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(60, 60, 60)
        switch.Parent = toggleFrame
        
        local switchCorner = Instance.new("UICorner")
        switchCorner.CornerRadius = UDim.new(0, 9)
        switchCorner.Parent = switch
        
        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 14, 0, 14)
        knob.Position = default and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        knob.Parent = switch
        
        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(0, 7)
        knobCorner.Parent = knob
        
        local toggled = default
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = toggleFrame
        
        btn.MouseButton1Click:Connect(function()
            toggled = not toggled
            
            TweenService:Create(switch, TweenInfo.new(0.2), 
                {BackgroundColor3 = toggled and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(60, 60, 60)}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), 
                {Position = toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
            
            callback(toggled)
        end)
        
        return {
            Set = function(self, value)
                toggled = value
                TweenService:Create(switch, TweenInfo.new(0.2), 
                    {BackgroundColor3 = toggled and Color3.fromRGB(60, 200, 60) or Color3.fromRGB(60, 60, 60)}):Play()
                TweenService:Create(knob, TweenInfo.new(0.2), 
                    {Position = toggled and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
            end
        }
    end
    
    function window:Slider(text, min, max, default, callback)
        text = text or "Slider"
        min = min or 0
        max = max or 100
        default = default or min
        callback = callback or function() end
        
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 45)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        sliderFrame.Parent = content
        
        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(0, 4)
        sliderCorner.Parent = sliderFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.7, 0, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 5)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = sliderFrame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Size = UDim2.new(0.3, -10, 0, 20)
        valueLabel.Position = UDim2.new(0.7, 0, 0, 5)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(default)
        valueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextSize = 14
        valueLabel.Parent = sliderFrame
        
        local track = Instance.new("Frame")
        track.Size = UDim2.new(1, -20, 0, 4)
        track.Position = UDim2.new(0, 10, 1, -15)
        track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        track.Parent = sliderFrame
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(0, 2)
        trackCorner.Parent = track
        
        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(80, 160, 255)
        fill.Parent = track
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 2)
        fillCorner.Parent = fill
        
        local value = default
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -20, 0, 20)
        btn.Position = UDim2.new(0, 10, 1, -25)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.Parent = sliderFrame
        
        local mouse = game.Players.LocalPlayer:GetMouse()
        
        btn.MouseButton1Down:Connect(function()
            local connection
            connection = mouse.Move:Connect(function()
                local relativeX = math.clamp((mouse.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * relativeX)
                
                valueLabel.Text = tostring(value)
                TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(relativeX, 0, 1, 0)}):Play()
                
                callback(value)
            end)
            
            local releaseConnection
            releaseConnection = UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    connection:Disconnect()
                    releaseConnection:Disconnect()
                end
            end)
        end)
        
        return {
            Set = function(self, newValue)
                value = math.clamp(newValue, min, max)
                valueLabel.Text = tostring(value)
                local relativeX = (value - min) / (max - min)
                TweenService:Create(fill, TweenInfo.new(0.2), {Size = UDim2.new(relativeX, 0, 1, 0)}):Play()
            end
        }
    end
    
    function window:TextBox(text, placeholder, callback)
        text = text or "Input"
        placeholder = placeholder or "Enter text..."
        callback = callback or function() end
        
        local inputFrame = Instance.new("Frame")
        inputFrame.Size = UDim2.new(1, 0, 0, 30)
        inputFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        inputFrame.Parent = content
        
        local inputCorner = Instance.new("UICorner")
        inputCorner.CornerRadius = UDim.new(0, 4)
        inputCorner.Parent = inputFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 80, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Gotham
        label.TextSize = 14
        label.Parent = inputFrame
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, -100, 0, 20)
        textBox.Position = UDim2.new(0, 90, 0, 5)
        textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        textBox.Text = ""
        textBox.PlaceholderText = placeholder
        textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        textBox.Font = Enum.Font.Gotham
        textBox.TextSize = 14
        textBox.ClearTextOnFocus = false
        textBox.Parent = inputFrame
        
        local textBoxCorner = Instance.new("UICorner")
        textBoxCorner.CornerRadius = UDim.new(0, 3)
        textBoxCorner.Parent = textBox
        
        textBox.FocusLost:Connect(function()
            callback(textBox.Text)
        end)
        
        return textBox
    end
    
    return window
end

return lib
