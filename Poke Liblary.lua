local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer

if game.CoreGui:FindFirstChild("PokeLib") then
    game.CoreGui.PokeLib:Destroy()
end

local PokeLibrary = {}

function PokeLibrary:Create()
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "PokeLib"
    gui.Parent = game.CoreGui
    
    local floatingBtn = Instance.new("ImageButton")
    floatingBtn.Name = "FloatingToggle"
    floatingBtn.Size = UDim2.new(0, 50, 0, 50)
    floatingBtn.Position = UDim2.new(1, -70, 0, 70)
    floatingBtn.BackgroundColor3 = Color3.new(0.4, 0.6, 1)
    floatingBtn.BorderSizePixel = 0
    floatingBtn.Image = "rbxassetid://138392070226096" -- Floating Squircle Image ( Changeble )
    floatingBtn.ScaleType = Enum.ScaleType.Crop
    floatingBtn.Active = true
    floatingBtn.Draggable = true
    floatingBtn.Parent = gui
    
    local floatingRound = Instance.new("UICorner")
    floatingRound.CornerRadius = UDim.new(0, 14)
    floatingRound.Parent = floatingBtn
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, 260, 0, 320)
    main.Position = UDim2.new(0.5, -130, 0.5, -160)
    main.BackgroundColor3 = Color3.new(0.06, 0.06, 0.1)
    main.BorderSizePixel = 0
    main.Active = true
    main.Draggable = true
    main.Visible = false
    main.Parent = gui
    
    local mainRound = Instance.new("UICorner")
    mainRound.CornerRadius = UDim.new(0, 8)
    mainRound.Parent = main
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 22)
    title.BackgroundColor3 = Color3.new(0.1, 0.1, 0.16)
    title.Text = "Aux hub"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 12
    title.Font = Enum.Font.GothamBold
    title.BorderSizePixel = 0
    title.Parent = main
    
    local titleRound = Instance.new("UICorner")
    titleRound.CornerRadius = UDim.new(0, 8)
    titleRound.Parent = title
    
    local left = Instance.new("Frame")
    left.Size = UDim2.new(0.46, 0, 0, 290)
    left.Position = UDim2.new(0.02, 0, 0, 27)
    left.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
    left.BorderSizePixel = 0
    left.Parent = main
    
    local leftRound = Instance.new("UICorner")
    leftRound.CornerRadius = UDim.new(0, 6)
    leftRound.Parent = left
    
    local leftTitle = Instance.new("TextLabel")
    leftTitle.Size = UDim2.new(1, -4, 0, 16)
    leftTitle.Position = UDim2.new(0, 2, 0, 3)
    leftTitle.BackgroundTransparency = 1
    leftTitle.Text = "Controls"
    leftTitle.TextColor3 = Color3.new(0.4, 0.6, 1)
    leftTitle.TextSize = 10
    leftTitle.Font = Enum.Font.GothamBold
    leftTitle.Parent = left
    
    local right = Instance.new("Frame")
    right.Size = UDim2.new(0.46, 0, 0, 290)
    right.Position = UDim2.new(0.52, 0, 0, 27)
    right.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
    right.BorderSizePixel = 0
    right.Parent = main
    
    local rightRound = Instance.new("UICorner")
    rightRound.CornerRadius = UDim.new(0, 6)
    rightRound.Parent = right
    
    local rightTitle = Instance.new("TextLabel")
    rightTitle.Size = UDim2.new(1, -4, 0, 16)
    rightTitle.Position = UDim2.new(0, 2, 0, 3)
    rightTitle.BackgroundTransparency = 1
    rightTitle.Text = "Welcome"
    rightTitle.TextColor3 = Color3.new(1, 0.4, 0.28)
    rightTitle.TextSize = 10
    rightTitle.Font = Enum.Font.GothamBold
    rightTitle.Parent = right
    
    local isOpen = false
    
    local function toggleUI()
        isOpen = not isOpen
        main.Visible = isOpen
      
    end
    
    floatingBtn.MouseButton1Click:Connect(toggleUI)
    
    local UI = {
        ScreenGui = gui,
        MainFrame = main,
        LeftPanel = left,
        RightPanel = right,
        FloatingButton = floatingBtn,
        Toggle = toggleUI,
        _leftElementCount = 0,
        _rightElementCount = 0
    }
    
    function UI:AddButton(parent, text, callback)
        local isLeft = (parent == left)
        local elementCount = isLeft and self._leftElementCount or self._rightElementCount
        
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -4, 0, 20)
        button.Position = UDim2.new(0, 2, 0, 22 + (elementCount * 25))
        button.Text = text
        button.BackgroundColor3 = Color3.new(0.14, 0.4, 0.28)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.TextSize = 9
        button.Font = Enum.Font.GothamBold
        button.BorderSizePixel = 0
        button.Parent = parent
        
        local buttonRound = Instance.new("UICorner")
        buttonRound.CornerRadius = UDim.new(0, 4)
        buttonRound.Parent = button
        
        local buttonIcon = Instance.new("ImageLabel")
        buttonIcon.Size = UDim2.new(0, 16, 0, 16)
        buttonIcon.Position = UDim2.new(1, -18, 0.5, -8)
        buttonIcon.BackgroundTransparency = 1
        buttonIcon.Image = "rbxassetid://88296436591343" -- Mouse Click button 
        buttonIcon.ScaleType = Enum.ScaleType.Fit
        buttonIcon.Parent = button
        
        if callback then
            button.MouseButton1Click:Connect(callback)
        end
        
        if isLeft then
            self._leftElementCount = self._leftElementCount + 1
        else
            self._rightElementCount = self._rightElementCount + 1
        end
        
        return button
    end
    
    function UI:AddToggle(parent, text, defaultState, callback)
        local isLeft = (parent == left)
        local elementCount = isLeft and self._leftElementCount or self._rightElementCount
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, -4, 0, 20)
        toggleFrame.Position = UDim2.new(0, 2, 0, 22 + (elementCount * 25))
        toggleFrame.BackgroundColor3 = defaultState and Color3.new(0.18, 0.24, 0.18) or Color3.new(0.14, 0.14, 0.2)
        toggleFrame.BorderSizePixel = 0
        toggleFrame.Parent = parent
        
        local toggleRound = Instance.new("UICorner")
        toggleRound.CornerRadius = UDim.new(0, 4)
        toggleRound.Parent = toggleFrame
        
        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(1, 0, 1, 0)
        toggleBtn.BackgroundTransparency = 1
        toggleBtn.Text = (defaultState and "● " or "○ ") .. text
        toggleBtn.TextColor3 = Color3.new(0.63, 0.63, 0.63)
        toggleBtn.TextSize = 9
        toggleBtn.Font = Enum.Font.Gotham
        toggleBtn.Parent = toggleFrame
        
        local isToggled = defaultState
        
        toggleBtn.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            toggleBtn.Text = (isToggled and "● " or "○ ") .. text
            toggleFrame.BackgroundColor3 = isToggled and Color3.new(0.18, 0.24, 0.18) or Color3.new(0.14, 0.14, 0.2)
            
            if callback then
                callback(isToggled)
            end
        end)
        
        if isLeft then
            self._leftElementCount = self._leftElementCount + 1
        else
            self._rightElementCount = self._rightElementCount + 1
        end
        
        return toggleFrame, isToggled
    end
    
    function UI:AddTextBox(parent, labelText, placeholder, callback)
        local isLeft = (parent == left)
        local elementCount = isLeft and self._leftElementCount or self._rightElementCount
      
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -4, 0, 10)
        label.Position = UDim2.new(0, 2, 0, 22 + (elementCount * 25))
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = Color3.new(0.55, 0.55, 0.55)
        label.TextSize = 7
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        
        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(1, -4, 0, 16)
        textBox.Position = UDim2.new(0, 2, 0, 34 + (elementCount * 25))
        textBox.BackgroundColor3 = Color3.new(0.12, 0.12, 0.18)
        textBox.TextColor3 = Color3.new(1, 1, 1)
        textBox.TextSize = 8
        textBox.Font = Enum.Font.Code
        textBox.Text = ""
        textBox.PlaceholderText = placeholder or ""
        textBox.ClearTextOnFocus = false
        textBox.BorderSizePixel = 0
        textBox.Parent = parent
        
        local textRound = Instance.new("UICorner")
        textRound.CornerRadius = UDim.new(0, 3)
        textRound.Parent = textBox
        
        if callback then
            textBox.FocusLost:Connect(function()
                callback(textBox.Text)
            end)
        end
      
        if isLeft then
            self._leftElementCount = self._leftElementCount + 2
        else
            self._rightElementCount = self._rightElementCount + 2
        end
        
        return textBox
    end
    
    function UI:AddDropdown(parent, labelText, options, defaultIndex, callback)
        local isLeft = (parent == left)
        local elementCount = isLeft and self._leftElementCount or self._rightElementCount
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -4, 0, 10)
        label.Position = UDim2.new(0, 2, 0, 22 + (elementCount * 25))
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = Color3.new(0.55, 0.55, 0.55)
        label.TextSize = 7
        label.Font = Enum.Font.Gotham
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = parent
        
        local dropdownBtn = Instance.new("TextButton")
        dropdownBtn.Size = UDim2.new(1, -4, 0, 16)
        dropdownBtn.Position = UDim2.new(0, 2, 0, 34 + (elementCount * 25))
        dropdownBtn.BackgroundColor3 = Color3.new(0.12, 0.12, 0.18)
        dropdownBtn.Text = options[defaultIndex or 1] or "Select..."
        dropdownBtn.TextColor3 = Color3.new(1, 1, 1)
        dropdownBtn.TextSize = 8
        dropdownBtn.Font = Enum.Font.Code
        dropdownBtn.TextXAlignment = Enum.TextXAlignment.Left
        dropdownBtn.BorderSizePixel = 0
        dropdownBtn.Parent = parent
        
        local dropdownRound = Instance.new("UICorner")
        dropdownRound.CornerRadius = UDim.new(0, 3)
        dropdownRound.Parent = dropdownBtn
        
        local arrow = Instance.new("TextLabel")
        arrow.Size = UDim2.new(0, 12, 1, 0)
        arrow.Position = UDim2.new(1, -14, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "▼"
        arrow.TextColor3 = Color3.new(0.7, 0.7, 0.7)
        arrow.TextSize = 8
        arrow.Font = Enum.Font.Code
        arrow.Parent = dropdownBtn
        
        local dropdownList = Instance.new("Frame")
        dropdownList.Size = UDim2.new(1, -4, 0, math.min(#options * 18, 90))
        dropdownList.Position = UDim2.new(0, 2, 0, 52 + (elementCount * 25))
        dropdownList.BackgroundColor3 = Color3.new(0.08, 0.08, 0.12)
        dropdownList.BorderSizePixel = 0
        dropdownList.Visible = false
        dropdownList.ZIndex = 10
        dropdownList.Parent = parent
        
        local listRound = Instance.new("UICorner")
        listRound.CornerRadius = UDim.new(0, 3)
        listRound.Parent = dropdownList
        
        local scrollFrame = Instance.new("ScrollingFrame")
        scrollFrame.Size = UDim2.new(1, 0, 1, 0)
        scrollFrame.BackgroundTransparency = 1
        scrollFrame.BorderSizePixel = 0
        scrollFrame.ScrollBarThickness = 4
        scrollFrame.ScrollBarImageColor3 = Color3.new(0.3, 0.3, 0.3)
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #options * 18)
        scrollFrame.ZIndex = 11
        scrollFrame.Parent = dropdownList
        
        local isOpen = false
        local selectedIndex = defaultIndex or 1
      
        for i, option in ipairs(options) do
            local optionBtn = Instance.new("TextButton")
            optionBtn.Size = UDim2.new(1, -2, 0, 18)
            optionBtn.Position = UDim2.new(0, 1, 0, (i-1) * 18)
            optionBtn.BackgroundColor3 = (i == selectedIndex) and Color3.new(0.15, 0.15, 0.22) or Color3.new(0.1, 0.1, 0.14)
            optionBtn.Text = option
            optionBtn.TextColor3 = Color3.new(1, 1, 1)
            optionBtn.TextSize = 8
            optionBtn.Font = Enum.Font.Code
            optionBtn.TextXAlignment = Enum.TextXAlignment.Left
            optionBtn.BorderSizePixel = 0
            optionBtn.ZIndex = 12
            optionBtn.Parent = scrollFrame
            
            local optionRound = Instance.new("UICorner")
            optionRound.CornerRadius = UDim.new(0, 2)
            optionRound.Parent = optionBtn
          
            optionBtn.MouseEnter:Connect(function()
                if i ~= selectedIndex then
                    optionBtn.BackgroundColor3 = Color3.new(0.13, 0.13, 0.18)
                end
            end)
            
            optionBtn.MouseLeave:Connect(function()
                if i ~= selectedIndex then
                    optionBtn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.14)
                end
            end)
            
            
            optionBtn.MouseButton1Click:Connect(function()
                
                for j, child in ipairs(scrollFrame:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.BackgroundColor3 = Color3.new(0.1, 0.1, 0.14)
                    end
                end
                
                optionBtn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.22)
                selectedIndex = i
                dropdownBtn.Text = option
                
                isOpen = false
                dropdownList.Visible = false
                arrow.Text = "▼"
                
                if callback then
                    callback(option, i)
                end
            end)
        end
        
        dropdownBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            dropdownList.Visible = isOpen
            arrow.Text = isOpen and "▲" or "▼"
        end)
        
        game:GetService("UserInputService").InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local mouse = game.Players.LocalPlayer:GetMouse()
                local hit = mouse.Target
                
                local clickedDropdown = false
                local current = hit
                while current do
                    if current == dropdownList or current == dropdownBtn then
                        clickedDropdown = true
                        break
                    end
                    current = current.Parent
                end
                
                if not clickedDropdown and isOpen then
                    isOpen = false
                    dropdownList.Visible = false
                    arrow.Text = "▼"
                end
            end
        end)
        
        if isLeft then
            self._leftElementCount = self._leftElementCount + 2
        else
            self._rightElementCount = self._rightElementCount + 2
        end
        
        return dropdownBtn, selectedIndex
    end
    
    return UI
end

-- Example How to add Elements
local MyUI = PokeLibrary:Create()

-- Add some example elements
MyUI:AddButton(MyUI.LeftPanel, "Test Button", function()
    print("Button clicked!")
end)

MyUI:AddToggle(MyUI.LeftPanel, "Auto Farm", false, function(state)
    print("Auto Farm:", state)
end)

MyUI:AddTextBox(MyUI.LeftPanel, "Player Name", "Enter name...", function(text)
    print("Player Name:", text)
end)

MyUI:AddButton(MyUI.RightPanel, "Teleport", function()
    print("Teleport clicked!")
end)

MyUI:AddToggle(MyUI.RightPanel, "ESP", true, function(state)
    print("ESP:", state)
end)

MyUI:AddDropdown(MyUI.LeftPanel, "Game Mode", {"Adventure", "Creative", "Survival", "Hardcore"}, 1, function(selected, index)
    print("Selected:", selected, "Index:", index)
end)

MyUI:AddDropdown(MyUI.RightPanel, "Teleport Location", {"Spawn", "Sky", "Underground", "Random"}, 2, function(selected, index)
    print("Teleport to:", selected)
end)

return PokeLibrary
