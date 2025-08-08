-- Made by Nexus
-- Source 
-- Date 08/8/25

local M45Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(45, 45, 49)
}

local function TweenObject(obj, properties, duration, easingStyle, easingDirection)
    local tweenInfo = TweenInfo.new(duration or 0.2, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    TweenService:Create(obj, tweenInfo, properties):Play()
end

local function MakeDraggable(frame)
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if dragging and dragStart then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end
    end)
    
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

function M45Library:CreateLib(libName)
    libName = libName or "M45 Library"
  
    if PlayerGui:FindFirstChild("M45Library") then
        PlayerGui:FindFirstChild("M45Library"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "M45Library"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themes.Background
    Main.Position = UDim2.new(0.5, -160, 0.5, -120)
    Main.Size = UDim2.new(0, 320, 0, 240)
    Main.ClipsDescendants = true
    Main.Active = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Parent = Main
  
    local MainHeader = Instance.new("Frame")
    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themes.Header
    MainHeader.Size = UDim2.new(0, 320, 0, 25)
    
    local headerCover = Instance.new("UICorner")
    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Parent = MainHeader
    
    local coverup = Instance.new("Frame")
    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themes.Header
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.7, 0)
    coverup.Size = UDim2.new(0, 320, 0, 7)
    
    local title = Instance.new("TextLabel")
    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundTransparency = 1
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Size = UDim2.new(0, 150, 1, 0)
    title.Font = Enum.Font.Gotham
    title.Text = libName
    title.TextColor3 = Color3.fromRGB(245, 245, 245)
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
  
    local close = Instance.new("ImageButton")
    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1
    close.Position = UDim2.new(1, -20, 0, 2)
    close.Size = UDim2.new(0, 18, 0, 18)
    close.ZIndex = 2
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
  
    local MainSide = Instance.new("Frame")
    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themes.Header
    MainSide.Position = UDim2.new(0, 0, 0, 25)
    MainSide.Size = UDim2.new(0, 90, 0, 215)
    
    local sideCorner = Instance.new("UICorner")
    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Parent = MainSide
    
    local coverup_2 = Instance.new("Frame")
    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themes.Header
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(1, -5, 0, 0)
    coverup_2.Size = UDim2.new(0, 5, 1, 0)
  
    local tabFrames = Instance.new("Frame")
    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundTransparency = 1
    tabFrames.Position = UDim2.new(0, 5, 0, 5)
    tabFrames.Size = UDim2.new(1, -10, 1, -10)
    
    local tabListing = Instance.new("UIListLayout")
    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder
    
    local pages = Instance.new("Frame")
    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundTransparency = 1
    pages.Position = UDim2.new(0, 95, 0, 30)
    pages.Size = UDim2.new(0, 220, 0, 205)
    
    local Pages = Instance.new("Folder")
    Pages.Name = "Pages"
    Pages.Parent = pages

    MakeDraggable(Main)

    close.MouseButton1Click:Connect(function()
        TweenObject(close, {ImageTransparency = 1}, 0.1)
        wait()
        TweenObject(Main, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0, Main.AbsolutePosition.X + (Main.AbsoluteSize.X / 2), 0, Main.AbsolutePosition.Y + (Main.AbsoluteSize.Y / 2))
        }, 0.1)
        wait(1)
        ScreenGui:Destroy()
    end)
    
    local LibraryFunctions = {}
    local Tabs = {}
    local first = true

    function LibraryFunctions:NewTab(tabName)
        tabName = tabName or "Tab"
        
        local tabButton = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local page = Instance.new("ScrollingFrame")
        local pageListing = Instance.new("UIListLayout")
        
        local function UpdateSize()
            local cS = pageListing.AbsoluteContentSize
            TweenObject(page, {CanvasSize = UDim2.new(0, cS.X, 0, cS.Y)}, 0.15)
        end

        page.Name = "Page"
        page.Parent = Pages
        page.Active = true
        page.BackgroundColor3 = themes.Background
        page.BorderSizePixel = 0
        page.Position = UDim2.new(0, 0, 0, 0)
        page.Size = UDim2.new(1, 0, 1, 0)
        page.ScrollBarThickness = 5
        page.Visible = false
        page.ScrollBarImageColor3 = Color3.fromRGB(
            themes.SchemeColor.R * 255 - 16,
            themes.SchemeColor.G * 255 - 15,
            themes.SchemeColor.B * 255 - 28
        )
        
        pageListing.Name = "pageListing"
        pageListing.Parent = page
        pageListing.SortOrder = Enum.SortOrder.LayoutOrder
        pageListing.Padding = UDim.new(0, 5)
    
        tabButton.Name = tabName.."TabButton"
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themes.SchemeColor
        tabButton.Size = UDim2.new(1, 0, 0, 22)
        tabButton.AutoButtonColor = false
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themes.TextColor
        tabButton.TextSize = 11
        tabButton.BackgroundTransparency = 1
        
        if first then
            first = false
            page.Visible = true
            tabButton.BackgroundTransparency = 0
            UpdateSize()
        else
            page.Visible = false
            tabButton.BackgroundTransparency = 1
        end
        
        UICorner.CornerRadius = UDim.new(0, 5)
        UICorner.Parent = tabButton
        
        table.insert(Tabs, tabName)
        
        UpdateSize()
        page.ChildAdded:Connect(UpdateSize)
        page.ChildRemoved:Connect(UpdateSize)
  
        tabButton.MouseButton1Click:Connect(function()
            UpdateSize()
            for i,v in next, Pages:GetChildren() do
                v.Visible = false
            end
            page.Visible = true
            for i,v in next, tabFrames:GetChildren() do
                if v:IsA("TextButton") then
                    if themes.SchemeColor == Color3.fromRGB(255,255,255) then
                        TweenObject(v, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
                    end 
                    if themes.SchemeColor == Color3.fromRGB(0,0,0) then
                        TweenObject(v, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
                    end 
                    TweenObject(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            if themes.SchemeColor == Color3.fromRGB(255,255,255) then
                TweenObject(tabButton, {TextColor3 = Color3.fromRGB(0,0,0)}, 0.2)
            end 
            if themes.SchemeColor == Color3.fromRGB(0,0,0) then
                TweenObject(tabButton, {TextColor3 = Color3.fromRGB(255,255,255)}, 0.2)
            end 
            TweenObject(tabButton, {BackgroundTransparency = 0}, 0.2)
        end)
        
        local TabFunctions = {}

        function TabFunctions:NewSection(sectionName)
            sectionName = sectionName or "Section"
            
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = "Section"
            SectionFrame.Parent = page
            SectionFrame.BackgroundColor3 = themes.ElementColor
            SectionFrame.Size = UDim2.new(1, 0, 0, 35)
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 8)
            SectionCorner.Parent = SectionFrame
            
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Parent = SectionFrame
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.Position = UDim2.new(0, 15, 0, 0)
            SectionLabel.Size = UDim2.new(1, -30, 1, 0)
            SectionLabel.Font = Enum.Font.GothamSemibold
            SectionLabel.Text = sectionName
            SectionLabel.TextColor3 = themes.TextColor
            SectionLabel.TextSize = 14
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            UpdateSize()
            
            local SectionFunctions = {}
            
            function SectionFunctions:NewToggle(toggleName, callback)
                toggleName = toggleName or "Toggle"
                callback = callback or function() end
                
                local toggled = false
                
                local ToggleFrame = Instance.new("TextButton")
                ToggleFrame.Name = "Toggle"
                ToggleFrame.Parent = page
                ToggleFrame.BackgroundColor3 = themes.ElementColor
                ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                ToggleFrame.AutoButtonColor = false
                ToggleFrame.Text = ""
                ToggleFrame.ClipsDescendants = true
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 8)
                ToggleCorner.Parent = ToggleFrame
              
                local ToggleDisabled = Instance.new("ImageLabel")
                ToggleDisabled.Name = "ToggleDisabled"
                ToggleDisabled.Parent = ToggleFrame
                ToggleDisabled.BackgroundTransparency = 1
                ToggleDisabled.Position = UDim2.new(0, 12, 0.5, -10)
                ToggleDisabled.Size = UDim2.new(0, 20, 0, 20)
                ToggleDisabled.Image = "rbxassetid://3926309567"
                ToggleDisabled.ImageColor3 = themes.SchemeColor
                ToggleDisabled.ImageRectOffset = Vector2.new(628, 420)
                ToggleDisabled.ImageRectSize = Vector2.new(48, 48)
              
                local ToggleEnabled = Instance.new("ImageLabel")
                ToggleEnabled.Name = "ToggleEnabled"
                ToggleEnabled.Parent = ToggleFrame
                ToggleEnabled.BackgroundTransparency = 1
                ToggleEnabled.Position = UDim2.new(0, 12, 0.5, -10)
                ToggleEnabled.Size = UDim2.new(0, 20, 0, 20)
                ToggleEnabled.Image = "rbxassetid://3926309567"
                ToggleEnabled.ImageColor3 = themes.SchemeColor
                ToggleEnabled.ImageRectOffset = Vector2.new(784, 420)
                ToggleEnabled.ImageRectSize = Vector2.new(48, 48)
                ToggleEnabled.ImageTransparency = 1
          
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Parent = ToggleFrame
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 40, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -70, 1, 0)
                ToggleLabel.Font = Enum.Font.GothamSemibold
                ToggleLabel.Text = toggleName
                ToggleLabel.TextColor3 = themes.TextColor
                ToggleLabel.TextSize = 12
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
                local Sample = Instance.new("ImageLabel")
                Sample.Name = "Sample"
                Sample.Parent = ToggleFrame
                Sample.BackgroundTransparency = 1
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themes.SchemeColor
                Sample.ImageTransparency = 0.6
              
                ToggleFrame.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    
                    if toggled then
                        
                        TweenObject(ToggleEnabled, {ImageTransparency = 0}, 0.11)
                        TweenObject(ToggleDisabled, {ImageTransparency = 1}, 0.11)
                    else
                        
                        TweenObject(ToggleEnabled, {ImageTransparency = 1}, 0.11)
                        TweenObject(ToggleDisabled, {ImageTransparency = 0}, 0.11)
                    end
                  
                    local mouse = Players.LocalPlayer:GetMouse()
                    local ripple = Sample:Clone()
                    ripple.Parent = ToggleFrame
                    local x, y = (mouse.X - ripple.AbsolutePosition.X), (mouse.Y - ripple.AbsolutePosition.Y)
                    ripple.Position = UDim2.new(0, x, 0, y)
                    
                    local len, size = 0.35, nil
                    if ToggleFrame.AbsoluteSize.X >= ToggleFrame.AbsoluteSize.Y then
                        size = (ToggleFrame.AbsoluteSize.X * 1.5)
                    else
                        size = (ToggleFrame.AbsoluteSize.Y * 1.5)
                    end
                    
                    ripple:TweenSizeAndPosition(
                        UDim2.new(0, size, 0, size), 
                        UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 
                        'Out', 'Quad', len, true, nil
                    )
                    
                    for i = 1, 10 do
                        ripple.ImageTransparency = ripple.ImageTransparency + 0.05
                        wait(len / 12)
                    end
                    ripple:Destroy()
                    
                    callback(toggled)
                end)
            
                local hovering = false
                ToggleFrame.MouseEnter:Connect(function()
                    hovering = true
                    TweenObject(ToggleFrame, {BackgroundColor3 = Color3.fromRGB(
                        themes.ElementColor.R * 255 + 8,
                        themes.ElementColor.G * 255 + 9,
                        themes.ElementColor.B * 255 + 10
                    )}, 0.1)
                end)
                
                ToggleFrame.MouseLeave:Connect(function()
                    hovering = false
                    TweenObject(ToggleFrame, {BackgroundColor3 = themes.ElementColor}, 0.1)
                end)
                
                UpdateSize()
                
                local ToggleFunctions = {}
                
                function ToggleFunctions:SetState(state)
                    toggled = state
                    if toggled then
                        ToggleEnabled.ImageTransparency = 0
                        ToggleDisabled.ImageTransparency = 1
                    else
                        ToggleEnabled.ImageTransparency = 1
                        ToggleDisabled.ImageTransparency = 0
                    end
                    callback(toggled)
                end
                
                function ToggleFunctions:GetState()
                    return toggled
                end
                
                return ToggleFunctions
            end
        
            function SectionFunctions:NewButton(buttonName, callback)
                buttonName = buttonName or "Button"
                callback = callback or function() end
                
                local ButtonFrame = Instance.new("TextButton")
                ButtonFrame.Name = "Button"
                ButtonFrame.Parent = page
                ButtonFrame.BackgroundColor3 = themes.ElementColor
                ButtonFrame.Size = UDim2.new(1, 0, 0, 35)
                ButtonFrame.AutoButtonColor = false
                ButtonFrame.Text = ""
                ButtonFrame.ClipsDescendants = true
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 8)
                ButtonCorner.Parent = ButtonFrame
              
                local ButtonIcon = Instance.new("ImageLabel")
                ButtonIcon.Name = "ButtonIcon"
                ButtonIcon.Parent = ButtonFrame
                ButtonIcon.BackgroundTransparency = 1
                ButtonIcon.Position = UDim2.new(0, 12, 0.5, -10)
                ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
                ButtonIcon.Image = "rbxassetid://3926305904"
                ButtonIcon.ImageColor3 = themes.SchemeColor
                ButtonIcon.ImageRectOffset = Vector2.new(84, 204)
                ButtonIcon.ImageRectSize = Vector2.new(36, 36)
            
                local ButtonLabel = Instance.new("TextLabel")
                ButtonLabel.Parent = ButtonFrame
                ButtonLabel.BackgroundTransparency = 1
                ButtonLabel.Position = UDim2.new(0, 40, 0, 0)
                ButtonLabel.Size = UDim2.new(1, -50, 1, 0)
                ButtonLabel.Font = Enum.Font.GothamSemibold
                ButtonLabel.Text = buttonName
                ButtonLabel.TextColor3 = themes.TextColor
                ButtonLabel.TextSize = 12
                ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
              
                local Sample = Instance.new("ImageLabel")
                Sample.Name = "Sample"
                Sample.Parent = ButtonFrame
                Sample.BackgroundTransparency = 1
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = themes.SchemeColor
                Sample.ImageTransparency = 0.6
            
                ButtonFrame.MouseButton1Click:Connect(function()
                    
                    local mouse = Players.LocalPlayer:GetMouse()
                    local ripple = Sample:Clone()
                    ripple.Parent = ButtonFrame
                    local x, y = (mouse.X - ripple.AbsolutePosition.X), (mouse.Y - ripple.AbsolutePosition.Y)
                    ripple.Position = UDim2.new(0, x, 0, y)
                    
                    local len, size = 0.35, nil
                    if ButtonFrame.AbsoluteSize.X >= ButtonFrame.AbsoluteSize.Y then
                        size = (ButtonFrame.AbsoluteSize.X * 1.5)
                    else
                        size = (ButtonFrame.AbsoluteSize.Y * 1.5)
                    end
                    
                    ripple:TweenSizeAndPosition(
                        UDim2.new(0, size, 0, size), 
                        UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 
                        'Out', 'Quad', len, true, nil
                    )
                    
                    for i = 1, 10 do
                        ripple.ImageTransparency = ripple.ImageTransparency + 0.05
                        wait(len / 12)
                    end
                    ripple:Destroy()
                    
                    callback()
                end)
                
                local hovering = false
                ButtonFrame.MouseEnter:Connect(function()
                    hovering = true
                    TweenObject(ButtonFrame, {BackgroundColor3 = Color3.fromRGB(
                        themes.ElementColor.R * 255 + 8,
                        themes.ElementColor.G * 255 + 9,
                        themes.ElementColor.B * 255 + 10
                    )}, 0.1)
                end)
                
                ButtonFrame.MouseLeave:Connect(function()
                    hovering = false
                    TweenObject(ButtonFrame, {BackgroundColor3 = themes.ElementColor}, 0.1)
                end)
                
                UpdateSize()
                
                local ButtonFunctions = {}
                
                function ButtonFunctions:UpdateText(newText)
                    ButtonLabel.Text = newText
                end
                
                return ButtonFunctions
            end
            
            return SectionFunctions
        end
        
        return TabFunctions
    end
    
    function LibraryFunctions:Toggle()
        Main.Visible = not Main.Visible
    end
    
    return LibraryFunctions
end

return M45Library
