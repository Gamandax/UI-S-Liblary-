-- I Obfuscate it Soon!
-- Death Library
local DeathLibrary = {}

function DeathLibrary:CreateWindow(title)
    if game.CoreGui:FindFirstChild("GhostGui") then
        game.CoreGui:FindFirstChild("GhostGui"):Destroy()
    end

    local ScreenGui1 = Instance.new("ScreenGui")
    ScreenGui1.Parent = game.CoreGui
    ScreenGui1.Name = "GhostGui"

    -- Main title bar
    local Frame1 = Instance.new("Frame") 
    Frame1.Parent = ScreenGui1
    Frame1.Name = "MainFrame"
    Frame1.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
    Frame1.Position = UDim2.new(0.3,0,0.3,0)
    Frame1.Size = UDim2.new(0,165,0,34)
    Frame1.Active = true
    Frame1.Draggable = true
    Frame1.BorderSizePixel = 0

    -- Pretty glass effect lol :>
    local UIStroke1 = Instance.new("UIStroke")
    UIStroke1.Parent = Frame1
    UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke1.Color = Color3.fromRGB(70, 70, 70)
    UIStroke1.Thickness = 1

    local UICorner1 = Instance.new("UICorner") 
    UICorner1.Parent = Frame1
    UICorner1.CornerRadius = UDim.new(0, 8)

    local TextLabel1 = Instance.new("TextLabel") 
    TextLabel1.Parent = Frame1
    TextLabel1.Name = "Title"
    TextLabel1.BackgroundTransparency = 1
    TextLabel1.Position = UDim2.new(0,12,0,0)
    TextLabel1.Size = UDim2.new(0.75,0,1,0)
    TextLabel1.Font = Enum.Font.GothamBold
    TextLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel1.Text = title or "Title Here"
    TextLabel1.TextSize = 14
    TextLabel1.TextScaled = false
    TextLabel1.TextWrapped = true
    TextLabel1.TextXAlignment = Enum.TextXAlignment.Left

    -- Dropdown content frame
    local Frame2 = Instance.new("Frame") 
    Frame2.Parent = ScreenGui1
    Frame2.Name = "ContentsFrame"
    Frame2.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    Frame2.BorderSizePixel = 0
    Frame2.Position = Frame1.Position + UDim2.new(0,0,0,36)
    Frame2.Size = UDim2.new(0,165,0,100)
    Frame2.Visible = false

    -- border
    local UIStroke2 = Instance.new("UIStroke")
    UIStroke2.Parent = Frame2
    UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke2.Color = Color3.fromRGB(70, 70, 70)
    UIStroke2.Thickness = 1

    local Frame2UICorner = Instance.new("UICorner")
    Frame2UICorner.Parent = Frame2
    Frame2UICorner.CornerRadius = UDim.new(0, 8)

    local TextButton1 = Instance.new("TextButton") 
    TextButton1.Parent = Frame1
    TextButton1.Name = "Open"
    TextButton1.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TextButton1.BorderSizePixel = 0
    TextButton1.Position = UDim2.new(1,-28,0,6)
    TextButton1.Size = UDim2.new(0,22,0,22)
    TextButton1.Font = Enum.Font.GothamBold
    TextButton1.TextColor3 = Color3.fromRGB(200, 200, 200)
    TextButton1.Text = "v"
    TextButton1.TextSize = 12
    TextButton1.TextScaled = false
    TextButton1.AutoButtonColor = false

    -- button styling ( Change it if you want )
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.Parent = TextButton1
    ButtonCorner.CornerRadius = UDim.new(0, 4)

    local ButtonStroke = Instance.new("UIStroke")
    ButtonStroke.Parent = TextButton1
    ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    ButtonStroke.Color = Color3.fromRGB(60, 60, 60)
    ButtonStroke.Thickness = 1

    -- Hover 
    local originalColor = Color3.fromRGB(40, 40, 40)
    local hoverColor = Color3.fromRGB(50, 50, 50)
    local pressedColor = Color3.fromRGB(30, 30, 30)

    TextButton1.MouseEnter:Connect(function()
        TextButton1.BackgroundColor3 = hoverColor
    end)

    TextButton1.MouseLeave:Connect(function()
        TextButton1.BackgroundColor3 = originalColor
    end)

    TextButton1.MouseButton1Down:Connect(function()
        TextButton1.BackgroundColor3 = pressedColor
    end)

    TextButton1.MouseButton1Up:Connect(function()
        TextButton1.BackgroundColor3 = hoverColor
    end)

    -- Toggle functionality
    TextButton1.MouseButton1Click:Connect(function() 
        if TextButton1.Text == "v" then
            TextButton1.Text = "^"
            Frame2.Visible = true
            Frame2.Position = Frame1.Position + UDim2.new(0,0,0,36)
            Frame2.Size = UDim2.new(0,165,0,0)
            Frame2:TweenSize(UDim2.new(0,165,0,100), "Out", "Quart", 0.3, true)
        else
            TextButton1.Text = "v"
            Frame2:TweenSize(UDim2.new(0,165,0,0), "Out", "Quart", 0.2, true)
            wait(0.2)
            Frame2.Visible = false
        end
    end)

    -- Update Frame2 Frame 1
    Frame1:GetPropertyChangedSignal("Position"):Connect(function()
        if Frame2.Visible then
            Frame2.Position = Frame1.Position + UDim2.new(0,0,0,36)
        end
    end)

    local WindowObject = {}
    WindowObject.ContentFrame = Frame2
    WindowObject.ContentPositionZ = 0
    
    function WindowObject:AddButton(text, callback)
        local Frame = Instance.new("Frame") 
        Frame.Parent = self.ContentFrame
        Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(0,4,0,self.ContentPositionZ + 4)
        Frame.Size = UDim2.new(1,-8,0,25)

        local UICorner = Instance.new("UICorner") 
        UICorner.Parent = Frame
        UICorner.CornerRadius = UDim.new(0, 6)
        
        local ItemStroke = Instance.new("UIStroke")
        ItemStroke.Parent = Frame
        ItemStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        ItemStroke.Color = Color3.fromRGB(50, 50, 50)
        ItemStroke.Thickness = 1

        local TextButton = Instance.new("TextButton") 
        TextButton.Parent = Frame
        TextButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TextButton.BorderSizePixel = 0
        TextButton.Position = UDim2.new(0,6,0,3)
        TextButton.Size = UDim2.new(1,-12,1,-6)
        TextButton.Font = Enum.Font.Gotham
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.Text = text
        TextButton.TextSize = 12
        TextButton.TextScaled = false
        TextButton.AutoButtonColor = false

        local BtnCorner = Instance.new("UICorner") 
        BtnCorner.Parent = TextButton
        BtnCorner.CornerRadius = UDim.new(0, 4)
        
        -- button hover 
        TextButton.MouseEnter:Connect(function()
            TextButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        end)
        
        TextButton.MouseLeave:Connect(function()
            TextButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        end)

        TextButton.MouseButton1Click:Connect(function()
            if callback then
                callback()
            end
        end)

        self.ContentPositionZ = self.ContentPositionZ + 27
        self.ContentFrame.Size = UDim2.new(0,165,0,math.max(100, self.ContentPositionZ + 5))
        
        return TextButton
    end
    
    function WindowObject:AddToggle(text, callback)
        local Frame = Instance.new("Frame") 
        Frame.Parent = self.ContentFrame
        Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(0,4,0,self.ContentPositionZ + 4)
        Frame.Size = UDim2.new(1,-8,0,25)

        local UICorner = Instance.new("UICorner") 
        UICorner.Parent = Frame
        UICorner.CornerRadius = UDim.new(0, 6)
        
        local ItemStroke = Instance.new("UIStroke")
        ItemStroke.Parent = Frame
        ItemStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        ItemStroke.Color = Color3.fromRGB(50, 50, 50)
        ItemStroke.Thickness = 1

        local TextLabel = Instance.new("TextLabel") 
        TextLabel.Parent = Frame
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0,8,0,0)
        TextLabel.Size = UDim2.new(0.75,0,1,0)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Text = text
        TextLabel.TextSize = 12
        TextLabel.TextScaled = false
        TextLabel.TextWrapped = true

        local TextButton = Instance.new("TextButton") 
        TextButton.Parent = Frame
        TextButton.BackgroundTransparency = 1
        TextButton.Position = UDim2.new(0.8,0,0.2,0)
        TextButton.Size = UDim2.new(0.15,0,0.6,0)
        TextButton.Font = Enum.Font.GothamBold
        TextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TextButton.Text = "□"
        TextButton.TextSize = 14
        TextButton.TextScaled = false
        TextButton.TextWrapped = true

        local Toggle = false
        TextButton.MouseButton1Click:Connect(function()
            if TextButton.Text == "□" then
                TextButton.Text = "■"
                TextButton.TextColor3 = Color3.fromRGB(100, 200, 100)
                Toggle = true
            else
                TextButton.Text = "□"
                TextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                Toggle = false
            end
            
            if callback then
                callback(Toggle)
            end
        end)

        self.ContentPositionZ = self.ContentPositionZ + 27
        self.ContentFrame.Size = UDim2.new(0,165,0,math.max(100, self.ContentPositionZ + 5))
        
        return {
            Toggle = TextButton,
            GetValue = function() return Toggle end,
            SetValue = function(value)
                if value then
                    TextButton.Text = "■"
                    TextButton.TextColor3 = Color3.fromRGB(100, 200, 100)
                    Toggle = true
                else
                    TextButton.Text = "□"
                    TextButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                    Toggle = false
                end
            end
        }
    end
    
    function WindowObject:AddLabel(text)
        local Frame = Instance.new("Frame") 
        Frame.Parent = self.ContentFrame
        Frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(0,4,0,self.ContentPositionZ + 4)
        Frame.Size = UDim2.new(1,-8,0,25)

        local UICorner = Instance.new("UICorner") 
        UICorner.Parent = Frame
        UICorner.CornerRadius = UDim.new(0, 6)
        
        local ItemStroke = Instance.new("UIStroke")
        ItemStroke.Parent = Frame
        ItemStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        ItemStroke.Color = Color3.fromRGB(50, 50, 50)
        ItemStroke.Thickness = 1

        local TextLabel = Instance.new("TextLabel") 
        TextLabel.Parent = Frame
        TextLabel.BackgroundTransparency = 1
        TextLabel.Position = UDim2.new(0,8,0,0)
        TextLabel.Size = UDim2.new(1,-16,1,0)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        TextLabel.Text = text
        TextLabel.TextSize = 12
        TextLabel.TextScaled = false
        TextLabel.TextWrapped = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        self.ContentPositionZ = self.ContentPositionZ + 27
        self.ContentFrame.Size = UDim2.new(0,165,0,math.max(100, self.ContentPositionZ + 5))
        
        return {
            Label = TextLabel,
            SetText = function(newText)
                TextLabel.Text = newText
            end
        }
    end
    
    return WindowObject
end

return DeathLibrary
