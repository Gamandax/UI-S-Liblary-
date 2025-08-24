-- for all Script Liblary 
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

if game.CoreGui:FindFirstChild('WaveUI') then 
    game.CoreGui.WaveUI:Destroy() 
end

local Wave = {}

local TRANSPARENCY = true -- Set falS or true 
local TRANSPARENCY_VALUE = 0.1

local function tween(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.3), props):Play()
end

local function corner(obj, radius)
    local c = Instance.new('UICorner', obj)
    c.CornerRadius = UDim.new(0, radius or 4)
    return c
end

function Wave:Window(title)
    local window = {}
    local isMinimized = false
    local originalSize = UDim2.new(0, 420, 0, 280)
    local minimizedSize = UDim2.new(0, 420, 0, 30)
    
    local mainTransparency = TRANSPARENCY and TRANSPARENCY_VALUE or 0
    local secondaryTransparency = TRANSPARENCY and math.min(TRANSPARENCY_VALUE + 0.1, 1) or 0
    
    local gui = Instance.new('ScreenGui')
    gui.Name = 'WaveUI'
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false
    
    local main = Instance.new('Frame')
    main.Name = 'MainFrame'
    main.Size = originalSize
    main.Position = UDim2.new(0.5, -210, 0.5, -140)
    main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    main.BackgroundTransparency = mainTransparency
    main.BorderSizePixel = 0
    main.Parent = gui
    corner(main, 8)
    
    local titleBar = Instance.new('Frame')
    titleBar.Name = 'TitleBar'
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    titleBar.BackgroundTransparency = secondaryTransparency
    titleBar.BorderSizePixel = 0
    titleBar.Parent = main
    corner(titleBar, 8)
    
    local minimizeBtn = Instance.new('TextButton')
    minimizeBtn.Name = 'Minimize'
    minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
    minimizeBtn.Position = UDim2.new(1, -60, 0, 2.5)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    minimizeBtn.BackgroundTransparency = secondaryTransparency
    minimizeBtn.Text = '−'
    minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeBtn.TextScaled = true
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.BorderSizePixel = 0
    minimizeBtn.Parent = titleBar
    corner(minimizeBtn, 4)
    
    local closeBtn = Instance.new('TextButton')
    closeBtn.Name = 'Close'
    closeBtn.Size = UDim2.new(0, 25, 0, 25)
    closeBtn.Position = UDim2.new(1, -30, 0, 2.5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    closeBtn.BackgroundTransparency = secondaryTransparency
    closeBtn.Text = 'X'
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = titleBar
    corner(closeBtn, 4)
    
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)
    
    local sidebar = Instance.new('Frame')
    sidebar.Name = 'Sidebar'
    sidebar.Size = UDim2.new(0, 120, 1, -35)
    sidebar.Position = UDim2.new(0, 5, 0, 35)
    sidebar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    sidebar.BackgroundTransparency = mainTransparency
    sidebar.BorderSizePixel = 0
    sidebar.Parent = main
    corner(sidebar, 6)
    
    local tabContainer = Instance.new('ScrollingFrame')
    tabContainer.Name = 'TabContainer'
    tabContainer.Size = UDim2.new(1, -6, 1, -6)
    tabContainer.Position = UDim2.new(0, 3, 0, 3)
    tabContainer.BackgroundTransparency = 1
    tabContainer.ScrollBarThickness = 0
    tabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tabContainer.Parent = sidebar
    
    local tabLayout = Instance.new('UIListLayout')
    tabLayout.Parent = tabContainer
    tabLayout.Padding = UDim.new(0, 2)
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local content = Instance.new('Frame')
    content.Name = 'Content'
    content.Size = UDim2.new(1, -135, 1, -35)
    content.Position = UDim2.new(0, 130, 0, 35)
    content.BackgroundColor3 = Color3.fromRGB(5, 5, 5) 
    content.BackgroundTransparency = mainTransparency
    content.BorderSizePixel = 0
    content.Parent = main
    corner(content, 6)
    
    local contentFolder = Instance.new('Folder')
    contentFolder.Name = 'ContentFolder'
    contentFolder.Parent = content
    
    minimizeBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        if isMinimized then
            tween(main, {Size = minimizedSize})
            minimizeBtn.Text = '□'
            sidebar.Visible = false
            content.Visible = false
        else
            tween(main, {Size = originalSize})
            minimizeBtn.Text = '−'
            sidebar.Visible = true
            content.Visible = true
        end
    end)
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            
            local connection
            connection = UserInputService.InputChanged:Connect(function(input2)
                if dragging and (input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch) then
                    local delta = input2.Position - dragStart
                    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
                end
            end)
            
            local endConnection
            endConnection = UserInputService.InputEnded:Connect(function(input3)
                if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    connection:Disconnect()
                    endConnection:Disconnect()
                end
            end)
        end
    end)
    
    local firstTab = true
    local activeTab = nil
    
    function window:Tab(name)
        local tab = {}
        
        local tabBtn = Instance.new('TextButton')
        tabBtn.Name = name
        tabBtn.Size = UDim2.new(1, 0, 0, 32)
        tabBtn.BackgroundColor3 = firstTab and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(15, 15, 15)
        tabBtn.BackgroundTransparency = secondaryTransparency
        tabBtn.Text = name
        tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabBtn.Font = Enum.Font.Gotham
        tabBtn.TextSize = 13
        tabBtn.BorderSizePixel = 0
        tabBtn.Parent = tabContainer
        corner(tabBtn, 4)
        
        local tabContent = Instance.new('ScrollingFrame')
        tabContent.Name = name .. 'Content'
        tabContent.Size = UDim2.new(1, -6, 1, -6)
        tabContent.Position = UDim2.new(0, 3, 0, 3)
        tabContent.BackgroundTransparency = 1
        tabContent.ScrollBarThickness = 0
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = firstTab
        tabContent.Parent = contentFolder
        
        local contentLayout = Instance.new('UIListLayout')
        contentLayout.Parent = tabContent
        contentLayout.Padding = UDim.new(0, 4)
        contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        if firstTab then 
            firstTab = false 
            activeTab = tabContent
        end
        
        tabBtn.MouseButton1Click:Connect(function()
            for _, btn in pairs(tabContainer:GetChildren()) do
                if btn:IsA('TextButton') then
                    tween(btn, {BackgroundColor3 = Color3.fromRGB(15, 15, 15)})
                end
            end
            for _, cont in pairs(contentFolder:GetChildren()) do
                if cont:IsA('ScrollingFrame') then
                    cont.Visible = false
                end
            end
            tween(tabBtn, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)})
            tabContent.Visible = true
            activeTab = tabContent
        end)
        
        local function updateCanvas()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, contentLayout.AbsoluteContentSize.Y + 10)
        end
        contentLayout:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(updateCanvas)
        
        function tab:Button(text, callback)
            local btn = Instance.new('TextButton')
            btn.Name = 'Button'
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            btn.BackgroundTransparency = secondaryTransparency
            btn.Text = text
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 12
            btn.BorderSizePixel = 0
            btn.Parent = tabContent
            corner(btn, 4)
            
            btn.MouseButton1Click:Connect(function()
                tween(btn, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.1)
                spawn(function()
                    wait(0.1)
                    tween(btn, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}, 0.1)
                end)
                if callback then callback() end
            end)
            
            return btn
        end
        
        function tab:Toggle(text, callback, default)
            local container = Instance.new('Frame')
            container.Name = 'Toggle'
            container.Size = UDim2.new(1, 0, 0, 30)
            container.BackgroundTransparency = 1
            container.Parent = tabContent
            
            local label = Instance.new('TextLabel')
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = container
            
            local toggle = Instance.new('TextButton')
            toggle.Size = UDim2.new(0, 45, 0, 22)
            toggle.Position = UDim2.new(1, -50, 0.5, -11)
            toggle.BackgroundColor3 = default and Color3.fromRGB(0, 60, 0) or Color3.fromRGB(60, 0, 0)
            toggle.BackgroundTransparency = secondaryTransparency
            toggle.Text = ''
            toggle.BorderSizePixel = 0
            toggle.Parent = container
            corner(toggle, 11)
            
            local thumb = Instance.new('Frame')
            thumb.Size = UDim2.new(0, 18, 0, 18)
            thumb.Position = default and UDim2.new(0, 25, 0, 2) or UDim2.new(0, 2, 0, 2)
            thumb.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            thumb.BackgroundTransparency = secondaryTransparency
            thumb.BorderSizePixel = 0
            thumb.Parent = toggle
            corner(thumb, 9)
            
            local state = default or false
            
            toggle.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    tween(toggle, {BackgroundColor3 = Color3.fromRGB(0, 60, 0)})
                    tween(thumb, {Position = UDim2.new(0, 25, 0, 2)})
                else
                    tween(toggle, {BackgroundColor3 = Color3.fromRGB(60, 0, 0)})
                    tween(thumb, {Position = UDim2.new(0, 2, 0, 2)})
                end
                if callback then callback(state) end
            end)
            
            return container
        end
        
        function tab:Slider(text, min, max, callback, default)
            local container = Instance.new('Frame')
            container.Name = 'Slider'
            container.Size = UDim2.new(1, 0, 0, 40)
            container.BackgroundTransparency = 1
            container.Parent = tabContent
            
            local label = Instance.new('TextLabel')
            label.Size = UDim2.new(0.7, 0, 0, 18)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = container
            
            local valueLabel = Instance.new('TextLabel')
            valueLabel.Size = UDim2.new(0.3, 0, 0, 18)
            valueLabel.Position = UDim2.new(0.7, 0, 0, 0)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(default or min)
            valueLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
            valueLabel.Font = Enum.Font.Gotham
            valueLabel.TextSize = 11
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.Parent = container
            
            local slider = Instance.new('Frame')
            slider.Size = UDim2.new(1, -10, 0, 8)
            slider.Position = UDim2.new(0, 0, 0, 25)
            slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            slider.BackgroundTransparency = secondaryTransparency
            slider.BorderSizePixel = 0
            slider.Parent = container
            corner(slider, 4)
            
            local fill = Instance.new('Frame')
            local initialScale = default and (default - min) / (max - min) or 0
            fill.Size = UDim2.new(initialScale, 0, 1, 0)
            fill.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            fill.BackgroundTransparency = secondaryTransparency
            fill.BorderSizePixel = 0
            fill.Parent = slider
            corner(fill, 4)
            
            local isDragging = false
            
            local function updateSlider(inputPosition)
                if not slider.Parent then return end
                local relativeX = inputPosition.X - slider.AbsolutePosition.X
                local scale = math.clamp(relativeX / slider.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * scale)
                
                fill.Size = UDim2.new(scale, 0, 1, 0)
                valueLabel.Text = tostring(value)
                
                if callback then callback(value) end
            end
            
            slider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    isDragging = true
                    updateSlider(input.Position)
                    
                    local connection
                    connection = UserInputService.InputChanged:Connect(function(input2)
                        if isDragging and (input2.UserInputType == Enum.UserInputType.MouseMovement or input2.UserInputType == Enum.UserInputType.Touch) then
                            updateSlider(input2.Position)
                        end
                    end)
                    
                    local endConnection
                    endConnection = UserInputService.InputEnded:Connect(function(input3)
                        if input3.UserInputType == Enum.UserInputType.MouseButton1 or input3.UserInputType == Enum.UserInputType.Touch then
                            isDragging = false
                            connection:Disconnect()
                            endConnection:Disconnect()
                        end
                    end)
                end
            end)
            
            return container
        end
        
        function tab:Label(text)
            local label = Instance.new('TextLabel')
            label.Name = 'Label'
            label.Size = UDim2.new(1, 0, 0, 25)
            label.BackgroundTransparency = 1
            label.Text = text
            label.TextColor3 = Color3.fromRGB(200, 200, 200)
            label.Font = Enum.Font.Gotham
            label.TextSize = 12
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = tabContent
            
            return label
        end
        
        return tab
    end
    
    return window
end

return Wave
