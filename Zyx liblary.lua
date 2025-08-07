-- Zyx liblary 
-- Enjoy!
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local TeleportGUILibrary = {}

-- Constants for Notification and UI
local FONT = Enum.Font.GothamBold
local CORNER_RADIUS = UDim.new(0, 6)
local COLORS = {
    Frame = Color3.fromRGB(35, 35, 40),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(114, 137, 218), -- Discord blue
    Success = Color3.fromRGB(87, 242, 135),
    Error = Color3.fromRGB(255, 89, 89),
    Warning = Color3.fromRGB(255, 201, 79),
    Input = Color3.fromRGB(55, 55, 60),
}

-- Auto-destroy existing instances of the GUI
local existingGUI = PlayerGui:FindFirstChild("TeleportGUI")
if existingGUI then
    existingGUI:Destroy()
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 250, 0, 300)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Round the corners
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 1, 0) -- Full width of TopBar
Title.Position = UDim2.new(0, 0, 0, 0) -- No offset, starting from the left edge
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Text = "Minds-Fall Survival"
Title.TextXAlignment = Enum.TextXAlignment.Center
Title.TextYAlignment = Enum.TextYAlignment.Center -- Ensure vertical centering as well
Title.Parent = TopBar

-- Minimize Button (in Close Button position)
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 25, 0, 25)
MinimizeButton.Position = UDim2.new(1, -28, 0, 2) -- Now in Close Button position
MinimizeButton.BackgroundColor3 = Color3.fromRGB(70, 70, 255)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Text = "-"
MinimizeButton.TextSize = 16
MinimizeButton.Parent = TopBar

-- Round the minimize button
local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 5)
MinimizeCorner.Parent = MinimizeButton

-- ScrollingFrame to contain all content
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(1, 0, 1, -60)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ScrollingFrame.HorizontalScrollBarInset = Enum.ScrollBarInset.None
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated dynamically
ScrollingFrame.Parent = MainFrame

-- Content Frame within the ScrollingFrame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, 0, 0, 0) -- Will be updated dynamically
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = ScrollingFrame

-- Bottom bar for YouTube label background
local BottomBar = Instance.new("Frame")
BottomBar.Name = "BottomBar"
BottomBar.Size = UDim2.new(1, 0, 0, 30)
BottomBar.Position = UDim2.new(0, 0, 1, -30)
BottomBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
BottomBar.BorderSizePixel = 0
BottomBar.Parent = MainFrame
BottomBar.ZIndex = 1

-- YouTube Label (moved to left side with padding)
local YouTubeLabel = Instance.new("TextLabel")
YouTubeLabel.Name = "YouTubeLabel"
YouTubeLabel.Size = UDim2.new(0.9, 0, 1, 0) -- Match the width of other elements (90% of parent)
YouTubeLabel.Position = UDim2.new(0.05, 0, 0, 0) -- 5% padding from the left, matching other elements
YouTubeLabel.BackgroundTransparency = 1
YouTubeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
YouTubeLabel.TextSize = 16
YouTubeLabel.Font = Enum.Font.GothamBold
YouTubeLabel.Text = "Youtube: Zysume"
YouTubeLabel.TextXAlignment = Enum.TextXAlignment.Left
YouTubeLabel.Parent = BottomBar
YouTubeLabel.ZIndex = 2
YouTubeLabel.Visible = true

-- Function to create a section (label + separator)
function TeleportGUILibrary.createSection(sectionName, positionY)
    local sectionLabel = Instance.new("TextLabel")
    sectionLabel.Name = sectionName .. "Label"
    sectionLabel.Size = UDim2.new(0.9, 0, 0, 25)
    sectionLabel.Position = UDim2.new(0.05, 0, 0, positionY)
    sectionLabel.BackgroundTransparency = 1
    sectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionLabel.TextSize = 16
    sectionLabel.Font = Enum.Font.GothamBold
    sectionLabel.Text = sectionName
    sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    sectionLabel.Parent = ContentFrame

    local separator = Instance.new("Frame")
    separator.Name = sectionName .. "Separator"
    separator.Size = UDim2.new(0.9, 0, 0, 1)
    separator.Position = UDim2.new(0.05, 0, 0, positionY + 30)
    separator.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    separator.BorderSizePixel = 0
    separator.Parent = ContentFrame

    return sectionLabel, separator
end

-- Function to create custom checkbox with auto-apply (Option 2: Label on left, Checkbox on right)
function TeleportGUILibrary.createCheckbox(name, text, position, parent, onToggle)
    local checkboxContainer = Instance.new("Frame")
    checkboxContainer.Name = name .. "Container"
    checkboxContainer.Size = UDim2.new(0.9, 0, 0, 28)
    checkboxContainer.Position = position
    checkboxContainer.BackgroundTransparency = 1
    checkboxContainer.Parent = parent
    
    local checkboxBG = Instance.new("Frame")
    checkboxBG.Name = "Background"
    checkboxBG.Size = UDim2.new(0, 20, 0, 20)
    checkboxBG.Position = UDim2.new(1, -20, 0.5, -10) -- Checkbox on the far right
    checkboxBG.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    checkboxBG.BorderSizePixel = 0
    checkboxBG.Parent = checkboxContainer
    
    local checkboxCorner = Instance.new("UICorner")
    checkboxCorner.CornerRadius = UDim.new(0, 5)
    checkboxCorner.Parent = checkboxBG
    
    local checkmark = Instance.new("Frame")
    checkmark.Name = "Checkmark"
    checkmark.Size = UDim2.new(0, 0, 0, 0)
    checkmark.AnchorPoint = Vector2.new(0.5, 0.5)
    checkmark.Position = UDim2.new(0.5, 0, 0.5, 0)
    checkmark.BackgroundColor3 = Color3.fromRGB(70, 200, 120)
    checkmark.BorderSizePixel = 0
    checkmark.Visible = true
    checkmark.Parent = checkboxBG
    
    local checkmarkCorner = Instance.new("UICorner")
    checkmarkCorner.CornerRadius = UDim.new(0, 3)
    checkmarkCorner.Parent = checkmark
    
    local checkboxLabel = Instance.new("TextLabel")
    checkboxLabel.Name = "Label"
    checkboxLabel.Size = UDim2.new(0, 180, 1, 0)
    checkboxLabel.Position = UDim2.new(0, 0, 0, 0) -- Label on the left
    checkboxLabel.BackgroundTransparency = 1
    checkboxLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    checkboxLabel.TextSize = 14
    checkboxLabel.Font = FONT
    checkboxLabel.Text = text
    checkboxLabel.TextXAlignment = Enum.TextXAlignment.Left
    checkboxLabel.Parent = checkboxContainer
    
    local checkboxButton = Instance.new("TextButton")
    checkboxButton.Name = "Button"
    checkboxButton.Size = UDim2.new(1, 0, 1, 0)
    checkboxButton.BackgroundTransparency = 1
    checkboxButton.Text = ""
    checkboxButton.Parent = checkboxContainer
    
    local checked = false
    
    checkboxButton.MouseButton1Click:Connect(function()
        checked = not checked
        
        if checked then
            local expandTween = TweenService:Create(
                checkmark,
                TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Size = UDim2.new(0.8, 0, 0.8, 0)}
            )
            expandTween:Play()
            checkboxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            local shrinkTween = TweenService:Create(
                checkmark,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 0, 0, 0)}
            )
            shrinkTween:Play()
            checkboxLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
        end
        
        if onToggle then
            onToggle(checked)
        end
    end)
    
    return checkboxContainer, function() return checked end
end

-- Updated Text Input Function (Option 2: Label on left, Input on right)
function TeleportGUILibrary.createTextInput(name, labelText, defaultValue, position, parent, onChange)
    -- Container for the whole input element
    local inputContainer = Instance.new("Frame")
    inputContainer.Name = name .. "Container"
    inputContainer.Size = UDim2.new(0.9, 0, 0, 30)
    inputContainer.Position = position
    inputContainer.BackgroundTransparency = 1
    inputContainer.Parent = parent
    
    -- Label (on the left)
    local inputLabel = Instance.new("TextLabel")
    inputLabel.Name = "Label"
    inputLabel.Size = UDim2.new(0, 150, 1, 0)
    inputLabel.Position = UDim2.new(0, 0, 0, 0) -- Label on the left
    inputLabel.BackgroundTransparency = 1
    inputLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    inputLabel.TextSize = 14
    inputLabel.Font = FONT
    inputLabel.Text = labelText
    inputLabel.TextXAlignment = Enum.TextXAlignment.Left
    inputLabel.Parent = inputContainer
    
    -- Input Box Background (on the far right)
    local inputBG = Instance.new("Frame")
    inputBG.Name = "Background"
    inputBG.Size = UDim2.new(0, 60, 0, 24)
    inputBG.Position = UDim2.new(1, -60, 0.5, -12) -- Input on the far right
    inputBG.BackgroundColor3 = COLORS.Input
    inputBG.BorderSizePixel = 0
    inputBG.Parent = inputContainer
    
    -- Round the corners of the input box
    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 5)
    inputCorner.Parent = inputBG
    
    -- The actual TextBox
    local textBox = Instance.new("TextBox")
    textBox.Name = "TextBox"
    textBox.Size = UDim2.new(0.9, 0, 0.8, 0)
    textBox.Position = UDim2.new(0.05, 0, 0.1, 0)
    textBox.BackgroundTransparency = 1
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.TextSize = 14
    textBox.Font = FONT
    textBox.Text = tostring(defaultValue)
    textBox.PlaceholderText = "Enter value..."
    textBox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
    textBox.TextXAlignment = Enum.TextXAlignment.Center
    textBox.ClearTextOnFocus = false
    textBox.Parent = inputBG
    
    -- Store the current value
    local currentValue = defaultValue
    
    -- Handle focus
    textBox.Focused:Connect(function()
        TweenService:Create(
            inputBG,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = Color3.fromRGB(70, 70, 80)}
        ):Play()
    end)
    
    textBox.FocusLost:Connect(function(enterPressed)
        TweenService:Create(
            inputBG,
            TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundColor3 = COLORS.Input}
        ):Play()
        
        if enterPressed then
            local newValue = textBox.Text
            local numValue = tonumber(newValue)
            if numValue then
                newValue = numValue
            end
            
            if newValue ~= currentValue then
                currentValue = newValue
                if onChange then
                    onChange(newValue)
                end
            end
        else
            textBox.Text = tostring(currentValue)
        end
    end)
    
    return inputContainer, {
        getValue = function() return currentValue end,
        setValue = function(value)
            currentValue = value
            textBox.Text = tostring(value)
            if onChange then
                onChange(value)
            end
        end
    }
end

-- Function to create a dropdown with multiple options
function TeleportGUILibrary.createDropdown(name, labelText, options, defaultIndex, position, parent, onSelect)
    -- Container for the dropdown
    local dropdownContainer = Instance.new("Frame")
    dropdownContainer.Name = name .. "Container"
    dropdownContainer.Size = UDim2.new(0.9, 0, 0, 30)
    dropdownContainer.Position = position
    dropdownContainer.BackgroundTransparency = 1
    dropdownContainer.Parent = parent
    
    -- Label (on the left)
    local dropdownLabel = Instance.new("TextLabel")
    dropdownLabel.Name = "Label"
    dropdownLabel.Size = UDim2.new(0, 150, 1, 0)
    dropdownLabel.Position = UDim2.new(0, 0, 0, 0)
    dropdownLabel.BackgroundTransparency = 1
    dropdownLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
    dropdownLabel.TextSize = 14
    dropdownLabel.Font = FONT
    dropdownLabel.Text = labelText
    dropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    dropdownLabel.Parent = dropdownContainer
    
    -- Selected Option Display (on the right)
    local selectedDisplay = Instance.new("Frame")
    selectedDisplay.Name = "SelectedDisplay"
    selectedDisplay.Size = UDim2.new(0, 100, 0, 24)
    selectedDisplay.Position = UDim2.new(1, -100, 0.5, -12)
    selectedDisplay.BackgroundColor3 = COLORS.Input
    selectedDisplay.BorderSizePixel = 0
    selectedDisplay.Parent = dropdownContainer
    
    -- Round the corners
    local displayCorner = Instance.new("UICorner")
    displayCorner.CornerRadius = UDim.new(0, 5)
    displayCorner.Parent = selectedDisplay
    
    -- Selected Text
    local selectedText = Instance.new("TextLabel")
    selectedText.Name = "SelectedText"
    selectedText.Size = UDim2.new(0.85, 0, 1, 0)
    selectedText.Position = UDim2.new(0.05, 0, 0, 0)
    selectedText.BackgroundTransparency = 1
    selectedText.TextColor3 = Color3.fromRGB(255, 255, 255)
    selectedText.TextSize = 14
    selectedText.Font = FONT
    selectedText.Text = options[defaultIndex or 1]
    selectedText.TextXAlignment = Enum.TextXAlignment.Left
    selectedText.TextTruncate = Enum.TextTruncate.AtEnd
    selectedText.Parent = selectedDisplay
    
    -- Arrow Icon
    local arrowIcon = Instance.new("TextLabel")
    arrowIcon.Name = "ArrowIcon"
    arrowIcon.Size = UDim2.new(0, 20, 0, 20)
    arrowIcon.Position = UDim2.new(1, -20, 0.5, -10)
    arrowIcon.BackgroundTransparency = 1
    arrowIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    arrowIcon.TextSize = 14
    arrowIcon.Font = Enum.Font.GothamBold
    arrowIcon.Text = "▼"
    arrowIcon.Parent = selectedDisplay
    
    -- Get the highest ZIndex in the GUI and add a buffer to ensure our dropdown is on top
    local function getHighestZIndex()
        local highest = 0
        for _, descendant in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
            if descendant:IsA("GuiObject") and descendant.ZIndex > highest then
                highest = descendant.ZIndex
            end
        end
        return highest + 20 -- Add a large buffer to ensure it's on top
    end
    
    local baseZIndex = getHighestZIndex()
    
    -- Options Container (hidden by default)
    local optionsContainer = Instance.new("Frame")
    optionsContainer.Name = "OptionsContainer"
    optionsContainer.Size = UDim2.new(0, 100, 0, 0) -- Will expand when opened
    optionsContainer.Position = UDim2.new(1, -100, 1, 0)
    optionsContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    optionsContainer.BorderSizePixel = 0
    optionsContainer.ClipsDescendants = true
    optionsContainer.Visible = false
    optionsContainer.ZIndex = baseZIndex
    optionsContainer.Parent = dropdownContainer
    
    -- Round the corners of options container
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 5)
    optionsCorner.Parent = optionsContainer
    
    -- Options Scrolling Frame
    local optionsScrollFrame = Instance.new("ScrollingFrame")
    optionsScrollFrame.Name = "OptionsScrollFrame"
    optionsScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    optionsScrollFrame.BackgroundTransparency = 1
    optionsScrollFrame.BorderSizePixel = 0
    optionsScrollFrame.ScrollBarThickness = 4
    optionsScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
    optionsScrollFrame.ZIndex = baseZIndex + 1
    optionsScrollFrame.Parent = optionsContainer
    
    -- Calculate content height based on number of options
    local optionHeight = 24
    -- Only show 2 options at a time
    local maxVisibleOptions = 2
    local contentHeight = #options * optionHeight
    local visibleHeight = math.min(contentHeight, maxVisibleOptions * optionHeight)
    
    optionsScrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    
    -- Create option buttons
    local selectedIndex = defaultIndex or 1
    local isOpen = false
    
    for i, optionText in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Name = "Option_" .. i
        optionButton.Size = UDim2.new(1, -4, 0, optionHeight)
        optionButton.Position = UDim2.new(0, 2, 0, (i-1) * optionHeight)
        optionButton.BackgroundTransparency = 1
        optionButton.TextColor3 = Color3.fromRGB(220, 220, 220)
        optionButton.TextSize = 14
        optionButton.Font = FONT
        optionButton.Text = optionText
        optionButton.TextXAlignment = Enum.TextXAlignment.Left
        optionButton.TextYAlignment = Enum.TextYAlignment.Center
        optionButton.ZIndex = baseZIndex + 2 -- Higher than the scroll frame
        optionButton.Parent = optionsScrollFrame
        
        -- Add padding to the left
        local textPadding = Instance.new("UIPadding")
        textPadding.PaddingLeft = UDim.new(0, 5)
        textPadding.Parent = optionButton
        
        -- Highlight current selection
        if i == selectedIndex then
            optionButton.TextColor3 = Color3.fromRGB(114, 137, 218) -- Highlight color
        end
        
        -- Hover effect
        optionButton.MouseEnter:Connect(function()
            if i ~= selectedIndex then
                TweenService:Create(
                    optionButton, 
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad), 
                    {BackgroundTransparency = 0.9, BackgroundColor3 = Color3.fromRGB(70, 70, 80)}
                ):Play()
            end
        end)
        
        optionButton.MouseLeave:Connect(function()
            if i ~= selectedIndex then
                TweenService:Create(
                    optionButton, 
                    TweenInfo.new(0.2, Enum.EasingStyle.Quad), 
                    {BackgroundTransparency = 1}
                ):Play()
            end
        end)
        
        -- Option selection
        optionButton.MouseButton1Click:Connect(function()
            -- Update selected index and text
            selectedIndex = i
            selectedText.Text = optionText
            
            -- Update visuals
            for j, btn in ipairs(optionsScrollFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    if j == i then
                        btn.TextColor3 = Color3.fromRGB(114, 137, 218) -- Highlight color
                    else
                        btn.TextColor3 = Color3.fromRGB(220, 220, 220)
                    end
                end
            end
            
            -- Close dropdown
            toggleDropdown(false)
            
            -- Callback
            if onSelect then
                onSelect(optionText, i)
            end
        end)
    end
    
    -- Create background overlay to capture clicks outside the dropdown
    local overlay = Instance.new("Frame")
    overlay.Name = "DropdownOverlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundTransparency = 1 -- Fully transparent
    overlay.ZIndex = baseZIndex - 1 -- Just below the dropdown
    overlay.Visible = false
    overlay.Parent = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui -- Adjust to your GUI parent
    
    overlay.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or 
            input.UserInputType == Enum.UserInputType.Touch) and isOpen then
            toggleDropdown(false)
        end
    end)
    
    -- Toggle dropdown function
    function toggleDropdown(forceState)
        if forceState ~= nil then
            isOpen = forceState
        else
            isOpen = not isOpen
        end
        
        if isOpen then
            -- Show options container and overlay
            optionsContainer.Visible = true
            overlay.Visible = true
            
            -- Ensure dropdown is on top of everything
            local newBaseZIndex = getHighestZIndex()
            optionsContainer.ZIndex = newBaseZIndex
            optionsScrollFrame.ZIndex = newBaseZIndex + 1
            
            for _, btn in ipairs(optionsScrollFrame:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.ZIndex = newBaseZIndex + 2
                end
            end
            
            -- Animate arrow
            TweenService:Create(
                arrowIcon,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 180}
            ):Play()
            
            -- Animate container expansion
            TweenService:Create(
                optionsContainer,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 100, 0, visibleHeight)}
            ):Play()
            
            -- Adjust position to show current selection
            if optionsScrollFrame.CanvasSize.Y.Offset > visibleHeight then
                local scrollPosition = (selectedIndex - 1) * optionHeight
                -- Center the selected option if possible
                scrollPosition = math.max(0, scrollPosition - (visibleHeight / 2) + (optionHeight / 2))
                -- Ensure we don't scroll past the end
                scrollPosition = math.min(scrollPosition, optionsScrollFrame.CanvasSize.Y.Offset - visibleHeight)
                
                optionsScrollFrame.CanvasPosition = Vector2.new(0, scrollPosition)
            end
        else
            -- Hide overlay
            overlay.Visible = false
            
            -- Animate arrow back
            TweenService:Create(
                arrowIcon,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {Rotation = 0}
            ):Play()
            
            -- Animate container collapsing
            local collapseTween = TweenService:Create(
                optionsContainer,
                TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
                {Size = UDim2.new(0, 100, 0, 0)}
            )
            
            collapseTween:Play()
            
            collapseTween.Completed:Connect(function()
                if not isOpen then
                    optionsContainer.Visible = false
                end
            end)
        end
    end
    
    -- Click handler for dropdown
    selectedDisplay.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            toggleDropdown()
        end
    end)
    
    -- Clean up overlay when dropdown is destroyed
    dropdownContainer.AncestryChanged:Connect(function(_, newParent)
        if not newParent then
            overlay:Destroy()
        end
    end)
    
    -- Public methods
    local api = {
        getValue = function()
            return options[selectedIndex], selectedIndex
        end,
        setValue = function(index)
            if options[index] then
                selectedIndex = index
                selectedText.Text = options[index]
                
                -- Update visuals
                for j, btn in ipairs(optionsScrollFrame:GetChildren()) do
                    if btn:IsA("TextButton") then
                        if j == index then
                            btn.TextColor3 = Color3.fromRGB(114, 137, 218) -- Highlight color
                        else
                            btn.TextColor3 = Color3.fromRGB(220, 220, 220)
                        end
                    end
                end
                
                if onSelect then
                    onSelect(options[index], index)
                end
            end
        end,
        -- Add method to manually close the dropdown
        close = function()
            if isOpen then
                toggleDropdown(false)
            end
        end
    }
    
    return dropdownContainer, api
end

-- Function to create notification
function TeleportGUILibrary.createNotification(message, type)
    local notifColor = COLORS.Accent
    if type == "success" then
        notifColor = COLORS.Success
    elseif type == "error" then
        notifColor = COLORS.Error
    elseif type == "warning" then
        notifColor = COLORS.Warning
    end
    
    local NotifGui = Instance.new("ScreenGui")
    local NotifFrame = Instance.new("Frame")
    local NotifText = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner")
    local StatusBar = Instance.new("Frame")
    local StatusBarCorner = Instance.new("UICorner")
    
    NotifGui.Name = "TeleportNotification"
    NotifGui.DisplayOrder = 999
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    local parentSuccess = false
    pcall(function()
        if syn and syn.protect_gui then
            syn.protect_gui(NotifGui)
            NotifGui.Parent = CoreGui
            parentSuccess = true
        elseif gethui then
            NotifGui.Parent = gethui()
            parentSuccess = true
        else
            NotifGui.Parent = PlayerGui
            parentSuccess = true
        end
    end)
    if not parentSuccess then
        print("Error: Failed to parent notification GUI.")
        return
    end
    
    NotifFrame.Name = "NotifFrame"
    NotifFrame.Parent = NotifGui
    NotifFrame.BackgroundColor3 = COLORS.Frame
    NotifFrame.Position = UDim2.new(1, 10, 0.8, 0)
    NotifFrame.Size = UDim2.new(0, 280, 0, 60)
    NotifFrame.BackgroundTransparency = 0.1
    NotifFrame.BorderSizePixel = 0
    NotifFrame.ZIndex = 100
    
    UICorner.Parent = NotifFrame
    UICorner.CornerRadius = CORNER_RADIUS
    
    NotifText.Name = "NotifText"
    NotifText.Parent = NotifFrame
    NotifText.BackgroundTransparency = 1
    NotifText.Position = UDim2.new(0, 10, 0, 5)
    NotifText.Size = UDim2.new(1, -20, 1, -15)
    NotifText.Font = FONT
    NotifText.Text = message
    NotifText.TextColor3 = COLORS.Text
    NotifText.TextSize = 16
    NotifText.TextWrapped = true
    NotifText.TextXAlignment = Enum.TextXAlignment.Left
    NotifText.TextYAlignment = Enum.TextYAlignment.Top
    NotifText.ZIndex = 101
    
    StatusBar.Name = "StatusBar"
    StatusBar.Parent = NotifFrame
    StatusBar.BackgroundColor3 = notifColor
    StatusBar.Position = UDim2.new(0, 10, 1, -8)
    StatusBar.Size = UDim2.new(1, -20, 0, 3)
    StatusBar.ZIndex = 101
    
    StatusBarCorner.Parent = StatusBar
    StatusBarCorner.CornerRadius = UDim.new(1, 0)
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -300, 0.8, 0)}):Play()
    
    local statusTween = TweenService:Create(StatusBar, TweenInfo.new(3, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 0, 3)})
    statusTween:Play()
    
    statusTween.Completed:Connect(function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 10, 0.8, 0)}):Play()
        wait(0.5)
        NotifGui:Destroy()
    end)
end

-- Expose ContentFrame for adding sections
TeleportGUILibrary.ContentFrame = ContentFrame

-- Expose a function to update CanvasSize
function TeleportGUILibrary.updateCanvasSize(contentHeight)
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
    ContentFrame.Size = UDim2.new(1, 0, 0, contentHeight)
end

-- Make GUI draggable (both vertically and horizontally)
local dragging = false
local dragInput
local dragStart
local startPos
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled and not UIS.MouseEnabled

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

local function disableCamera(actionName, inputState, inputObject)
    if dragging then
        return Enum.ContextActionResult.Sink
    end
    return Enum.ContextActionResult.Pass
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

if isMobile then
    local touchConnection
    local touchEndedConnection

    ContextActionService:BindAction("DisableCameraMovement", disableCamera, false, Enum.UserInputType.Touch)

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            touchConnection = UIS.TouchMoved:Connect(function(touchInput)
                if touchInput == input and dragging then
                    updateDrag(touchInput)
                end
            end)

            touchEndedConnection = UIS.TouchEnded:Connect(function(touchInput)
                if touchInput == input then
                    dragging = false
                    if touchConnection then
                        touchConnection:Disconnect()
                    end
                    if touchEndedConnection then
                        touchEndedConnection:Disconnect()
                    end
                end
            end)
        end
    end)

    ScreenGui.AncestryChanged:Connect(function()
        if not ScreenGui:IsDescendantOf(game) then
            ContextActionService:UnbindAction("DisableCameraMovement")
        end
    end)
end

-- Minimize Status
local isMinimized = false
local originalSize = MainFrame.Size

-- Fixed MinimizeButton click event
MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        -- Expand back to original size
        MainFrame:TweenSize(originalSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
        ScrollingFrame.Visible = true
        BottomBar.Visible = true
        MinimizeButton.Text = "-"
    else
        -- Save original size before minimizing
        originalSize = MainFrame.Size
        -- When minimizing, keep the TopBar visible by setting the height to 30 (TopBar's height)
        MainFrame:TweenSize(UDim2.new(0, 250, 0, 30), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
        -- Hide content but keep TopBar visible
        ScrollingFrame.Visible = false
        BottomBar.Visible = false
        MinimizeButton.Text = "+"
    end
    isMinimized = not isMinimized
end)

UIS.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.M then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

return TeleportGUILibrary
