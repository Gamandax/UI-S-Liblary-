-- Moonix Liblary by Nexus


local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

pcall(function() game.CoreGui.CompactUI:Destroy() end)
pcall(function() game.CoreGui.CompactUIToggle:Destroy() end)

function Library:CreateWindow(title, info)
    local Window = {}
    
    local toggleGui = Instance.new("ScreenGui")
    toggleGui.Name = "CompactUIToggle"
    toggleGui.Parent = game.CoreGui
    toggleGui.ResetOnSpawn = false
    
    local toggleButton = Instance.new("ImageButton")
    toggleButton.Size = UDim2.new(0, 60, 0, 60)
    toggleButton.Position = UDim2.new(0, 20, 0.5, -30)
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleButton.BackgroundTransparency = 0.1
    toggleButton.BorderSizePixel = 0
    toggleButton.Image = "rbxassetid://10069914121"
    toggleButton.ImageTransparency = 0.3
    toggleButton.Parent = toggleGui
    Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0, 16)
    
    local toggleDragging, toggleDragStart, toggleStartPos
    toggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            toggleDragging = true
            toggleDragStart = input.Position
            toggleStartPos = toggleButton.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if toggleDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - toggleDragStart
            toggleButton.Position = UDim2.new(toggleStartPos.X.Scale, toggleStartPos.X.Offset + delta.X, toggleStartPos.Y.Scale, toggleStartPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then toggleDragging = false end
    end)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "Moonix"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 400, 0, 280)
    main.Position = UDim2.new(0.5, -200, 0.5, -140)
    main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    main.BackgroundTransparency = 0.1
    main.Parent = gui
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)
    
    local backgroundImage = Instance.new("ImageLabel")
    backgroundImage.Size = UDim2.new(1, 0, 1, 0)
    backgroundImage.BackgroundTransparency = 1
    backgroundImage.Image = "rbxassetid://10069914121"
    backgroundImage.ImageTransparency = 0.8
    backgroundImage.ScaleType = Enum.ScaleType.Crop
    backgroundImage.Parent = main
    Instance.new("UICorner", backgroundImage).CornerRadius = UDim.new(0, 12)
  
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 0, 30)
    titleLabel.Position = UDim2.new(0, 10, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title or "Window"
    titleLabel.TextColor3 = Color3.new(1, 1, 1)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextStrokeTransparency = 0.5
    titleLabel.Parent = main
    
    local dragging, dragStart, startPos
    main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 100, 1, -50)
    tabContainer.Position = UDim2.new(0, 10, 0, 40)
    tabContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    tabContainer.BackgroundTransparency = 0.3
    tabContainer.Parent = main
    Instance.new("UICorner", tabContainer).CornerRadius = UDim.new(0, 8)
    Instance.new("UIListLayout", tabContainer).Padding = UDim.new(0, 5)
    
    local pageContainer = Instance.new("Frame")
    pageContainer.Size = UDim2.new(0, 280, 1, -50)
    pageContainer.Position = UDim2.new(0, 120, 0, 40)
    pageContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    pageContainer.BackgroundTransparency = 0.3
    pageContainer.Parent = main
    Instance.new("UICorner", pageContainer).CornerRadius = UDim.new(0, 8)
    
    local pages = Instance.new("Folder", pageContainer)
    local currentPage
    local firstPage = true
    local isVisible = true
    local activeSliderConnections = {}
    
    local openTween = TweenService:Create(main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 400, 0, 280), Position = UDim2.new(0.5, -200, 0.5, -140)
    })
    local closeTween = TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    
    toggleButton.MouseEnter:Connect(function()
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 70, 0, 70)}):Play()
    end)
    toggleButton.MouseLeave:Connect(function()
        TweenService:Create(toggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    end)
    
    toggleButton.MouseButton1Click:Connect(function()
        if isVisible then
            for _, connection in pairs(activeSliderConnections) do
                if connection then connection:Disconnect() end
            end
            activeSliderConnections = {}
            closeTween:Play()
            closeTween.Completed:Connect(function() main.Visible = false end)
            isVisible = false
        else
            main.Visible = true
            main.Size = UDim2.new(0, 0, 0, 0)
            main.Position = UDim2.new(0.5, 0, 0.5, 0)
            openTween:Play()
            isVisible = true
        end
    end)
    
    function Window:addPage(name, visible)
        local tab = Instance.new("TextButton")
        tab.Size = UDim2.new(1, -10, 0, 30)
        tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        tab.BackgroundTransparency = 0.2
        tab.Text = name or "Page"
        tab.TextColor3 = Color3.new(1, 1, 1)
        tab.Font = Enum.Font.GothamBold
        tab.TextSize = 11
        tab.TextStrokeTransparency = 0.8
        tab.Parent = tabContainer
        Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)
        
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -10, 1, -10)
        page.Position = UDim2.new(0, 5, 0, 5)
        page.BackgroundTransparency = 1
        page.BorderSizePixel = 0
        page.ScrollBarThickness = 4
        page.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
        page.CanvasSize = UDim2.new(0, 0, 0, 0)
        page.Visible = false
        page.Parent = pages
        
        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 6)
        layout.Parent = page
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
        end)
        
        local function switchToPage()
            for _, p in pairs(pages:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            for _, t in pairs(tabContainer:GetChildren()) do
                if t:IsA("TextButton") then
                    TweenService:Create(t, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
                end
            end
            page.Visible = true
            TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 100, 200)}):Play()
            currentPage = page
        end
        
        tab.MouseEnter:Connect(function()
            if tab.BackgroundColor3 ~= Color3.fromRGB(50, 100, 200) then
                TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
            end
        end)
        tab.MouseLeave:Connect(function()
            if tab.BackgroundColor3 ~= Color3.fromRGB(50, 100, 200) then
                TweenService:Create(tab, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 25)}):Play()
            end
        end)
        tab.MouseButton1Click:Connect(switchToPage)
        
        if firstPage or visible == true then
            switchToPage()
            firstPage = false
        end
        
        local Elements = {}
        
        function Elements:addButton(text, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 32)
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            btn.BackgroundTransparency = 0.2
            btn.Text = text or "Button"
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.TextStrokeTransparency = 0.8
            btn.Parent = page
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
            
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
            end)
            btn.MouseButton1Click:Connect(callback or function() end)
            return btn
        end
        
        function Elements:addToggle(text, callback)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 32)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BackgroundTransparency = 0.2
            frame.Parent = page
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -60, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = text or "Toggle"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.TextStrokeTransparency = 0.8
            label.Parent = frame
            
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0, 44, 0, 22)
            toggle.Position = UDim2.new(1, -50, 0.5, -11)
            toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            toggle.Text = ""
            toggle.Parent = frame
            Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 11)
            
            local indicator = Instance.new("Frame")
            indicator.Size = UDim2.new(0, 18, 0, 18)
            indicator.Position = UDim2.new(0, 2, 0, 2)
            indicator.BackgroundColor3 = Color3.new(1, 1, 1)
            indicator.Parent = toggle
            Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 9)
            
            local enabled = false
            toggle.MouseButton1Click:Connect(function()
                enabled = not enabled
                TweenService:Create(indicator, TweenInfo.new(0.3, Enum.EasingStyle.Back), {
                    Position = enabled and UDim2.new(1, -20, 0, 2) or UDim2.new(0, 2, 0, 2)
                }):Play()
                TweenService:Create(toggle, TweenInfo.new(0.3), {
                    BackgroundColor3 = enabled and Color3.fromRGB(50, 150, 250) or Color3.fromRGB(60, 60, 60)
                }):Play()
                if callback then callback(enabled) end
            end)
            return toggle
        end
        
        function Elements:addDropdown(text, options, callback)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 32)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BackgroundTransparency = 0.2
            frame.Parent = page
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
            
            local dropdown = Instance.new("TextButton")
            dropdown.Size = UDim2.new(1, 0, 1, 0)
            dropdown.BackgroundTransparency = 1
            dropdown.Text = text .. ": " .. (options[1] or "None")
            dropdown.TextColor3 = Color3.new(1, 1, 1)
            dropdown.TextXAlignment = Enum.TextXAlignment.Left
            dropdown.Font = Enum.Font.GothamBold
            dropdown.TextSize = 12
            dropdown.TextStrokeTransparency = 0.8
            dropdown.Parent = frame
            
            local arrow = Instance.new("TextLabel")
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Position = UDim2.new(1, -25, 0, 0)
            arrow.BackgroundTransparency = 1
            arrow.Text = "▼"
            arrow.TextColor3 = Color3.new(1, 1, 1)
            arrow.Font = Enum.Font.GothamBold
            arrow.TextSize = 10
            arrow.Parent = frame
            
            local optionsFrame = Instance.new("Frame")
            optionsFrame.Size = UDim2.new(1, 0, 0, #options * 28)
            optionsFrame.Position = UDim2.new(0, 0, 1, 2)
            optionsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            optionsFrame.BackgroundTransparency = 0.1
            optionsFrame.Visible = false
            optionsFrame.ZIndex = 10
            optionsFrame.Parent = frame
            Instance.new("UICorner", optionsFrame).CornerRadius = UDim.new(0, 6)
            
            local optionsLayout = Instance.new("UIListLayout")
            optionsLayout.Parent = optionsFrame
            
            for i, option in ipairs(options) do
                local optionBtn = Instance.new("TextButton")
                optionBtn.Size = UDim2.new(1, 0, 0, 28)
                optionBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                optionBtn.BackgroundTransparency = 0.3
                optionBtn.Text = option
                optionBtn.TextColor3 = Color3.new(1, 1, 1)
                optionBtn.Font = Enum.Font.Gotham
                optionBtn.TextSize = 11
                optionBtn.TextStrokeTransparency = 0.8
                optionBtn.ZIndex = 11
                optionBtn.Parent = optionsFrame
                if i == 1 then Instance.new("UICorner", optionBtn).CornerRadius = UDim.new(0, 6) end
                if i == #options then Instance.new("UICorner", optionBtn).CornerRadius = UDim.new(0, 6) end
                
                optionBtn.MouseEnter:Connect(function()
                    TweenService:Create(optionBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end)
                optionBtn.MouseLeave:Connect(function()
                    TweenService:Create(optionBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}):Play()
                end)
                optionBtn.MouseButton1Click:Connect(function()
                    dropdown.Text = text .. ": " .. option
                    optionsFrame.Visible = false
                    TweenService:Create(arrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                    if callback then callback(option) end
                end)
            end
            
            dropdown.MouseButton1Click:Connect(function()
                optionsFrame.Visible = not optionsFrame.Visible
                TweenService:Create(arrow, TweenInfo.new(0.2), {
                    Rotation = optionsFrame.Visible and 180 or 0
                }):Play()
            end)
            return dropdown
        end
        
        function Elements:addTextBox(text, placeholder, callback)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 32)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BackgroundTransparency = 0.2
            frame.Parent = page
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0, 60, 1, 0)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = text or "Input:"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.TextStrokeTransparency = 0.8
            label.Parent = frame
            
            local textBox = Instance.new("TextBox")
            textBox.Size = UDim2.new(1, -80, 0, 24)
            textBox.Position = UDim2.new(0, 70, 0, 4)
            textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            textBox.BackgroundTransparency = 0.3
            textBox.Text = ""
            textBox.PlaceholderText = placeholder or "Enter text..."
            textBox.TextColor3 = Color3.new(1, 1, 1)
            textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            textBox.Font = Enum.Font.Gotham
            textBox.TextSize = 11
            textBox.TextStrokeTransparency = 0.8
            textBox.Parent = frame
            Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 4)
            
            textBox.FocusLost:Connect(function(enterPressed)
                if callback then callback(textBox.Text, enterPressed) end
            end)
            return textBox
        end
        
        function Elements:addSlider(text, min, max, callback)
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1, -10, 0, 45)
            frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            frame.BackgroundTransparency = 0.2
            frame.Parent = page
            Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -50, 0, 22)
            label.Position = UDim2.new(0, 12, 0, 2)
            label.BackgroundTransparency = 1
            label.Text = text or "Slider"
            label.TextColor3 = Color3.new(1, 1, 1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.TextStrokeTransparency = 0.8
            label.Parent = frame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0, 45, 0, 22)
            valueLabel.Position = UDim2.new(1, -45, 0, 2)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(min)
            valueLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 11
            valueLabel.TextStrokeTransparency = 0.8
            valueLabel.Parent = frame
            
            local slider = Instance.new("TextButton")
            slider.Size = UDim2.new(1, -24, 0, 8)
            slider.Position = UDim2.new(0, 12, 1, -18)
            slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            slider.Text = ""
            slider.Parent = frame
            Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 4)
            
            local fill = Instance.new("Frame")
            fill.Size = UDim2.new(0, 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(50, 150, 250)
            fill.Parent = slider
            Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 4)
            
            local mouse = game.Players.LocalPlayer:GetMouse()
            
            slider.MouseButton1Down:Connect(function()
                if not isVisible then return end
                local connection
                connection = mouse.Move:Connect(function()
                    if not isVisible then connection:Disconnect() return end
                    local relative = math.clamp((mouse.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X, 0, 1)
                    TweenService:Create(fill, TweenInfo.new(0.1), {Size = UDim2.new(relative, 0, 1, 0)}):Play()
                    local value = math.floor(min + (max - min) * relative)
                    valueLabel.Text = tostring(value)
                    if callback then callback(value) end
                end)
                table.insert(activeSliderConnections, connection)
                local release
                release = UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                        release:Disconnect()
                    end
                end)
                table.insert(activeSliderConnections, release)
            end)
            return slider
        end
        
        function Elements:addLabel(text)
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 0, 28)
            label.Position = UDim2.new(0, 12, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = text or "Label"
            label.TextColor3 = Color3.fromRGB(200, 200, 200)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextStrokeTransparency = 0.8
            label.Parent = page
            return label
        end
        
        return Elements
    end
    
    return Window
end

return Library
