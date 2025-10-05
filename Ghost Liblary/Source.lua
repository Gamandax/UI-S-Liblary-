--[[ I remade this VantaXock ]]
local GhostLib = {}
local TweenService = game:GetService("TweenService")

function GhostLib:CreateWindow(title)
    title = title or "Title Here"

    -- Admin Detector  by Ghost Player 🎀
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Gamandax/UI-S-Liblary-/refs/heads/main/Ghost%20Liblary/Important/Source.lua'))()  
      
    if game.CoreGui:FindFirstChild("GhostGui") then  
        game.CoreGui:FindFirstChild("GhostGui"):Destroy()  
    end  

    local ScreenGui1 = Instance.new("ScreenGui")  
    ScreenGui1.Parent = game.CoreGui  
    ScreenGui1.Name = "GhostGui"  

    local Frame1 = Instance.new("Frame")   
    Frame1.Parent = ScreenGui1  
    Frame1.Name = "MainFrame"  
    Frame1.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
    Frame1.Position = UDim2.new(0.3,0,0.05)  
    Frame1.Size = UDim2.new(0,165,0,34,0)  
    Frame1.Active = true  
    Frame1.Draggable = true  

    local UICorner1 = Instance.new("UICorner")   
    UICorner1.Parent = Frame1  
    UICorner1.CornerRadius = UDim.new(0.15,0)  

    local TextLabel1 = Instance.new("TextLabel")   
    TextLabel1.Parent = Frame1  
    TextLabel1.Name = "Title"  
    TextLabel1.BackgroundTransparency = 1  
    TextLabel1.Position = UDim2.new(0,0,0)  
    TextLabel1.Size = UDim2.new(1,0,1,0)  
    TextLabel1.Font = Enum.Font.GothamBold  
    TextLabel1.TextColor3 = Color3.fromRGB(255, 255, 255)  
    TextLabel1.Text = title  
    TextLabel1.TextSize = 14  
    TextLabel1.TextScaled = false  
    TextLabel1.TextWrapped = true  

    local Frame2 = Instance.new("Frame")   
    Frame2.Parent = Frame1  
    Frame2.Name = "ContentsFrame"  
    Frame2.BackgroundColor3 = Color3.fromRGB(10, 10, 10)  
    Frame2.BorderSizePixel = 0  
    Frame2.Position = UDim2.new(0,0,0.9)  
    Frame2.Size = UDim2.new(1,0,0.1,0)  
    Frame2.Visible = false  

    local Frame2UICorner = UICorner1:Clone()  
    Frame2UICorner.Parent = Frame2  

    local TextButton1 = Instance.new("TextButton")   
    TextButton1.Parent = Frame1  
    TextButton1.Name = "Open"  
    TextButton1.BackgroundTransparency = 1  
    TextButton1.Position = UDim2.new(0.85,0,0.05)  
    TextButton1.Size = UDim2.new(0.15,0,0.8,0)  
    TextButton1.Font = Enum.Font.GothamBold  
    TextButton1.TextColor3 = Color3.fromRGB(255, 255, 255)  
    TextButton1.Text = "v"  
    TextButton1.TextSize = 14  
    TextButton1.TextScaled = true  
    TextButton1.TextWrapped = false  

    TextButton1.MouseButton1Click:Connect(function()   
        if TextButton1.Text == "v" then  
            TextButton1.Text = "^"  
            Frame2.Visible = true  
            TweenService:Create(TextButton1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                {Rotation = 180}):Play()  
        else  
            TextButton1.Text = "v"  
            Frame2.Visible = false  
            TweenService:Create(TextButton1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                {Rotation = 0}):Play()  
        end  
    end)  

    local Window = {}  
    Window.MainFrame = Frame1  
    Window.ContentFrame = Frame2  
    Window.ContentPositionZ = 0  
      
    function Window:AddElement(type, text, script, script2)  
        if text == nil then  
            text = "Text"  
        end  
        if script == nil then  
            script = ""  
        end  
        if script2 == nil then  
            script2 = ""  
        end  
          
        local Frame = Instance.new("Frame")   
        Frame.Parent = self.ContentFrame  
        Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)  
        Frame.BorderSizePixel = 0  
        Frame.Position = UDim2.new(0,0,self.ContentPositionZ)  
        Frame.Size = UDim2.new(1,0,11,0)  

        local UICorner = Instance.new("UICorner")   
        UICorner.Parent = Frame  
        UICorner.CornerRadius = UDim.new(0.15,0)  

        local RETURN = nil  
          
        if type == "TextLabel" then  
            local TextLabel = Instance.new("TextLabel")   
            TextLabel.Parent = Frame  
            TextLabel.BackgroundTransparency = 1  
            TextLabel.Position = UDim2.new(0.1,0,0.15)  
            TextLabel.Size = UDim2.new(0.8,0,0.7,0)  
            TextLabel.Font = Enum.Font.Gotham  
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
            TextLabel.Text = text  
            TextLabel.TextSize = 12  
            TextLabel.TextScaled = false  
            TextLabel.TextWrapped = true  
            RETURN = TextLabel  
              
        elseif type == "TextBox" then  
            local TextBox = Instance.new("TextBox")   
            TextBox.Parent = Frame  
            TextBox.BackgroundTransparency = 0.25  
            TextBox.Position = UDim2.new(0.1,0,0.15)  
            TextBox.Size = UDim2.new(0.8,0,0.7,0)  
            TextBox.Font = Enum.Font.Gotham  
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)  
            TextBox.PlaceholderText = text  
            TextBox.Text = ""  
            TextBox.TextSize = 12  
            TextBox.TextScaled = false  
            TextBox.TextWrapped = true  

            local UICorner = Instance.new("UICorner")   
            UICorner.Parent = TextBox  
            UICorner.CornerRadius = UDim.new(0.15,0)  
            RETURN = TextBox  
              
        elseif type == "TextButton" then  
            local TextButton = Instance.new("TextButton")   
            TextButton.Parent = Frame  
            TextButton.BackgroundTransparency = 0  
            TextButton.Position = UDim2.new(0.1,0,0.15)  
            TextButton.Size = UDim2.new(0.8,0,0.7,0)  
            TextButton.Font = Enum.Font.Gotham  
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)  
            TextButton.Text = text  
            TextButton.TextSize = 12  
            TextButton.TextScaled = false  
            TextButton.TextWrapped = true  

            local UICorner = Instance.new("UICorner")   
            UICorner.Parent = TextButton  
            UICorner.CornerRadius = UDim.new(0.15,0)  

            TextButton.MouseButton1Click:Connect(function()  
                loadstring(script)()  
            end)  
            RETURN = TextButton  
              
        elseif type == "Dropdown" then  
            local TextLabel = Instance.new("TextLabel")   
            TextLabel.Parent = Frame  
            TextLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)  
            TextLabel.BackgroundTransparency = 0  
            TextLabel.Position = UDim2.new(0.1,0,0.15)  
            TextLabel.Size = UDim2.new(0.7,0,0.7,0)  
            TextLabel.Font = Enum.Font.Gotham  
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left  
            TextLabel.Text = text  
            TextLabel.TextSize = 12  
            TextLabel.TextScaled = false  
            TextLabel.TextWrapped = true  
            
            local LabelCorner = Instance.new("UICorner")
            LabelCorner.Parent = TextLabel
            LabelCorner.CornerRadius = UDim.new(0.15,0)

            local ArrowButton = Instance.new("TextButton")   
            ArrowButton.Parent = Frame  
            ArrowButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)  
            ArrowButton.BackgroundTransparency = 0  
            ArrowButton.Position = UDim2.new(0.805,0,0.15)  
            ArrowButton.Size = UDim2.new(0.15,0,0.7,0)  
            ArrowButton.Font = Enum.Font.Gotham  
            ArrowButton.TextColor3 = Color3.fromRGB(255, 255, 255)  
            ArrowButton.Text = "v"  
            ArrowButton.TextSize = 12  
            ArrowButton.TextScaled = false  
            ArrowButton.TextWrapped = true  
            
            local ArrowCorner = Instance.new("UICorner")
            ArrowCorner.Parent = ArrowButton
            ArrowCorner.CornerRadius = UDim.new(0.15,0)

            local options = {}  
            if script and script ~= "" then  
                options = string.split(script, ",")  
            end  
              
            local DropdownContent = Instance.new("Frame")  
            DropdownContent.Parent = game.CoreGui.GhostGui  
            DropdownContent.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
            DropdownContent.BorderSizePixel = 2  
            DropdownContent.BorderColor3 = Color3.fromRGB(255, 255, 255) 
            DropdownContent.Size = UDim2.new(0, 160, 0, 0)  
            DropdownContent.Visible = false  
            DropdownContent.ZIndex = 15  
              
            local ContentCorner = Instance.new("UICorner")  
            ContentCorner.Parent = DropdownContent  
            ContentCorner.CornerRadius = UDim.new(0.1, 0)
              
            local ScrollFrame = Instance.new("ScrollingFrame")  
            ScrollFrame.Parent = DropdownContent  
            ScrollFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
            ScrollFrame.BorderSizePixel = 0  
            ScrollFrame.Position = UDim2.new(0, 0, 0, 0)  
            ScrollFrame.Size = UDim2.new(1, 0, 1, 0)  
            ScrollFrame.ScrollBarThickness = 6  
            ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)  
            ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)  
            ScrollFrame.ZIndex = 16
            
            local ScrollCorner = Instance.new("UICorner")  
            ScrollCorner.Parent = ScrollFrame  
            ScrollCorner.CornerRadius = UDim.new(0.1, 0)
              
            local ListLayout = Instance.new("UIListLayout")  
            ListLayout.Parent = ScrollFrame  
            ListLayout.SortOrder = Enum.SortOrder.LayoutOrder  
            ListLayout.Padding = UDim.new(0, 2)  
              
            for i, option in pairs(options) do  
                option = option:gsub("^%s*(.-)%s*$", "%1")  
                local OptionButton = Instance.new("TextButton")  
                OptionButton.Parent = ScrollFrame  
                OptionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
                OptionButton.BorderSizePixel = 1  
                OptionButton.BorderColor3 = Color3.fromRGB(255, 255, 255)  
                OptionButton.Size = UDim2.new(1, -10, 0, 35)  
                OptionButton.Font = Enum.Font.GothamBold  
                OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)  
                OptionButton.Text = option  
                OptionButton.TextSize = 15  
                OptionButton.LayoutOrder = i  
                OptionButton.ZIndex = 17  
                  
                local OptionCorner = Instance.new("UICorner")  
                OptionCorner.Parent = OptionButton  
                OptionCorner.CornerRadius = UDim.new(0.1, 0)  
                
                OptionButton.MouseEnter:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  
                    OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)  
                end)
                
                OptionButton.MouseLeave:Connect(function()
                    OptionButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  
                    OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)  
                end)
                  
                OptionButton.MouseButton1Click:Connect(function()  
                    TextLabel.Text = option  
                    DropdownContent.Visible = false  
                    ArrowButton.Text = "v"  
                    TweenService:Create(ArrowButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {Rotation = 0}):Play()  
                      
                    if script2 and script2 ~= "" then  
                        local callbackScript = string.gsub(script2, "OPTION", option)  
                        loadstring(callbackScript)()  
                    end  
                end)  
            end  
              
            ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()  
                ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 15)  
                local maxHeight = math.min(ListLayout.AbsoluteContentSize.Y + 15, 150)  
                DropdownContent.Size = UDim2.new(0, 160, 0, maxHeight)  
            end)  
              
            local isOpen = false  
            ArrowButton.MouseButton1Click:Connect(function()  
                isOpen = not isOpen  
                DropdownContent.Visible = isOpen  
                  
                if isOpen then  
                    local framePos = Frame.AbsolutePosition  
                    DropdownContent.Position = UDim2.new(0, framePos.X + Frame.AbsoluteSize.X + 20, 0, framePos.Y)  
                    ArrowButton.Text = ">"  
                    TweenService:Create(ArrowButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {Rotation = 90}):Play()  
                else  
                    ArrowButton.Text = "v"  
                    TweenService:Create(ArrowButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {Rotation = 0}):Play()  
                end  
            end)  
              
            RETURN = ArrowButton  
              
        elseif type == "Slider" then  
            local SliderTitle = Instance.new("TextLabel")   
            SliderTitle.Parent = Frame  
            SliderTitle.BackgroundTransparency = 1  
            SliderTitle.Position = UDim2.new(0.1,0,0.15)  
            SliderTitle.Size = UDim2.new(0.7,0,0.4,0)  
            SliderTitle.Font = Enum.Font.Gotham  
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)  
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left  
            SliderTitle.Text = text  
            SliderTitle.TextSize = 12  
            SliderTitle.TextScaled = false  
            SliderTitle.TextWrapped = true  

            local ValueText = Instance.new("TextLabel")  
            ValueText.Parent = Frame  
            ValueText.BackgroundTransparency = 1  
            ValueText.Position = UDim2.new(0.1,0,0.15)  
            ValueText.Size = UDim2.new(0.8,0,0.4,0)  
            ValueText.Font = Enum.Font.Gotham  
            ValueText.TextColor3 = Color3.fromRGB(255, 255, 255)  
            ValueText.TextXAlignment = Enum.TextXAlignment.Right  
            ValueText.TextSize = 10  
            ValueText.TextTransparency = 1  

            local SliderFrame = Instance.new("TextButton")  
            SliderFrame.Parent = Frame  
            SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  
            SliderFrame.BorderSizePixel = 0  
            SliderFrame.Position = UDim2.new(0.1,0,0.6)  
            SliderFrame.Size = UDim2.new(0.8,0,0.25,0)  
            SliderFrame.Text = ""  

            local SliderFrameCorner = Instance.new("UICorner")  
            SliderFrameCorner.Parent = SliderFrame  
            SliderFrameCorner.CornerRadius = UDim.new(1,0)  

            local Slider = Instance.new("Frame")  
            Slider.Parent = SliderFrame  
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  
            Slider.BorderSizePixel = 0  
            Slider.Size = UDim2.new(0,0,1,0)  

            local SliderCorner = Instance.new("UICorner")  
            SliderCorner.Parent = Slider  
            SliderCorner.CornerRadius = UDim.new(1,0)  

            local min = 0  
            local max = 100  
            local precise = false  
              
            if script and script ~= "" then  
                local params = string.split(script, ",")  
                min = tonumber(params[1]) or 0  
                max = tonumber(params[2]) or 100  
                precise = params[3] == "true"  
            end  

            local UserInputService = game:GetService("UserInputService")  
            local RunService = game:GetService("RunService")  
            local Connection  
            local isDragging = false  

            local function Fade(Object, FadeAmount, Delay)  
                pcall(function()  
                    TweenService:Create(Object, TweenInfo.new(Delay), {TextTransparency = FadeAmount}):Play()  
                end)  
            end  

            ValueText.Text = min .. "/" .. max  

            UserInputService.InputEnded:Connect(function(Input)  
                if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and isDragging then  
                    if Connection then Connection:Disconnect() Connection = nil end  
                    isDragging = false  
                    Fade(ValueText, 1, .2)  
                end  
            end)  

            SliderFrame.MouseButton1Down:Connect(function()  
                pcall(function()  
                    if Connection then Connection:Disconnect() end  
                    isDragging = true  
                    Connection = RunService.RenderStepped:Connect(function()  
                        if not isDragging then   
                            if Connection then Connection:Disconnect() Connection = nil end   
                            return   
                        end  
                          
                        local Mouse = UserInputService:GetMouseLocation()  
                        local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)  
                        local GetValue = min + (max - min) * Percentage  
                          
                        if not precise then  
                            GetValue = math.floor(GetValue)  
                        else  
                            GetValue = math.floor(GetValue * 100) / 100  
                        end  
                          
                        Slider:TweenSize(UDim2.new(Percentage, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, .03, true)  
                        ValueText.Text = GetValue .. "/" .. max  
                        Fade(ValueText, 0, .2)  
                          
                        if script2 and script2 ~= "" then  
                            local callbackScript = string.gsub(script2, "VALUE", tostring(GetValue))  
                            pcall(function()  
                                loadstring(callbackScript)()  
                            end)  
                        end  
                    end)  
                end)  
            end)  
            RETURN = SliderFrame  
              
        elseif type == "Switch" then  
            local TextLabel = Instance.new("TextLabel")   
            TextLabel.Parent = Frame  
            TextLabel.BackgroundTransparency = 1  
            TextLabel.Position = UDim2.new(0.1,0,0.15)  
            TextLabel.Size = UDim2.new(0.6,0,0.7,0)  
            TextLabel.Font = Enum.Font.Gotham  
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left  
            TextLabel.Text = text  
            TextLabel.TextSize = 12  
            TextLabel.TextScaled = false  
            TextLabel.TextWrapped = true  

            local ToggleBackground = Instance.new("Frame")   
            ToggleBackground.Parent = Frame  
            ToggleBackground.BackgroundColor3 = Color3.fromRGB(60, 60, 60)  
            ToggleBackground.BorderSizePixel = 0  
            ToggleBackground.Position = UDim2.new(0.72,0,0.25)  
            ToggleBackground.Size = UDim2.new(0.25,0,0.5,0)  
            
            local ToggleBackgroundCorner = Instance.new("UICorner")
            ToggleBackgroundCorner.Parent = ToggleBackground
            ToggleBackgroundCorner.CornerRadius = UDim.new(0.5,0)  

            local ToggleCircle = Instance.new("TextButton")   
            ToggleCircle.Parent = ToggleBackground  
            ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleCircle.BorderSizePixel = 0  
            ToggleCircle.Position = UDim2.new(0.05,0,0.1) 
            ToggleCircle.Size = UDim2.new(0.4,0,0.8,0) 
            ToggleCircle.Text = ""  
            
            local ToggleCircleCorner = Instance.new("UICorner")
            ToggleCircleCorner.Parent = ToggleCircle
            ToggleCircleCorner.CornerRadius = UDim.new(0.5,0)  

            local Toggle = false  
            ToggleCircle.MouseButton1Click:Connect(function()  
                if not Toggle then  
                    
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {Position = UDim2.new(0.55,0,0.1)}):Play()
                    TweenService:Create(ToggleBackground, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {BackgroundColor3 = Color3.fromRGB(52, 199, 89)}):Play()
                    Toggle = true  
                    if script and script ~= "" then
                        loadstring(script)()  
                    end
                else  
                    
                    TweenService:Create(ToggleCircle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {Position = UDim2.new(0.05,0,0.1)}):Play()
                    TweenService:Create(ToggleBackground, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),   
                        {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
                    Toggle = false  
                    if script2 and script2 ~= "" then
                        loadstring(script2)()  
                    end
                end  
            end)  
            RETURN = ToggleCircle  
        end  
          
        self.ContentPositionZ = self.ContentPositionZ + 9.3  
        if RETURN ~= nil then  
            return RETURN  
        end  
    end  
      
    return Window
end

return GhostLib
