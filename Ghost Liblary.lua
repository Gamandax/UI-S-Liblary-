---Admin Detector in Server
loadstring(game:HttpGet('https://raw.githubusercontent.com/MainScripts352/MainScripts352/main/Admin'))()
---

if game.CoreGui:FindFirstChild("GhostGui") then
   game.CoreGui:FindFirstChild("GhostGui"):Destroy()
end

local ScreenGui1 = Instance.new("ScreenGui")
ScreenGui1.Parent = game.CoreGui
ScreenGui1.Name = "GhostGui"

local Frame1 = Instance.new("Frame") 
Frame1.Parent = ScreenGui1
Frame1.Name = "MainFrame"
Frame1.BackgroundColor3 = Color3.fromRGB(17,17,17)
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
TextLabel1.Font = Enum.Font.SourceSansBold
TextLabel1.TextColor3 = Color3.fromRGB(248,248,248)
TextLabel1.Text = "Title Here"
TextLabel1.TextSize = 18
TextLabel1.TextScaled = false
TextLabel1.TextWrapped = true

local Frame2 = Instance.new("Frame") 
Frame2.Parent = Frame1
Frame2.Name = "ContentsFrame"
Frame2.BackgroundColor3 = Color3.fromRGB(33,33,33)
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
TextButton1.Font = Enum.Font.SourceSansBold
TextButton1.TextColor3 = Color3.fromRGB(248,248,248)
TextButton1.Text = "v"
TextButton1.TextSize = 18
TextButton1.TextScaled = true
TextButton1.TextWrapped = false

TextButton1.MouseButton1Click:Connect(function() 
if TextButton1.Text == "v" then
   TextButton1.Text = "–"
   Frame2.Visible = true
else
   TextButton1.Text = "v"
   Frame2.Visible = false
end
end)

local ContentPositionZ = 0
function AddContent(type, text, script, script2)
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
 Frame.Parent = Frame2
 Frame.BackgroundColor3 = Color3.fromRGB(33,33,33)
 Frame.BorderSizePixel = 0
 Frame.Position = UDim2.new(0,0,ContentPositionZ)
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
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(248,248,248)
    TextLabel.Text = text
    TextLabel.TextSize = 18
    TextLabel.TextScaled = false
    TextLabel.TextWrapped = true
    RETURN = TextLabel
 elseif type == "TextBox" then
    local TextBox = Instance.new("TextBox") 
    TextBox.Parent = Frame
    TextBox.BackgroundTransparency = 0.25
    TextBox.Position = UDim2.new(0.1,0,0.15)
    TextBox.Size = UDim2.new(0.8,0,0.7,0)
    TextBox.Font = Enum.Font.SourceSansBold
    TextBox.TextColor3 = Color3.fromRGB(248,248,248)
    TextBox.PlaceholderText = text
    TextBox.Text = ""
    TextBox.TextSize = 18
    TextBox.TextScaled = false
    TextBox.TextWrapped = true

    local UICorner = Instance.new("UICorner") 
    UICorner.Parent = TextButton
    UICorner.CornerRadius = UDim.new(0.15,0)
    RETURN = TextBox
 elseif type == "TextButton" then
    local TextButton = Instance.new("TextButton") 
    TextButton.Parent = Frame
    TextButton.BackgroundTransparency = 0
    TextButton.Position = UDim2.new(0.1,0,0.15)
    TextButton.Size = UDim2.new(0.8,0,0.7,0)
    TextButton.Font = Enum.Font.SourceSansBold
    TextButton.TextColor3 = Color3.fromRGB(248,248,248)
    TextButton.Text = text
    TextButton.TextSize = 18
    TextButton.TextScaled = false
    TextButton.TextWrapped = true

    local UICorner = Instance.new("UICorner") 
    UICorner.Parent = TextButton
    UICorner.CornerRadius = UDim.new(0.15,0)

    TextButton.MouseButton1Click:Connect(function()
    loadstring(script)()
    end)
 elseif type == "Toogle" then
    local TextLabel = Instance.new("TextLabel") 
    TextLabel.Parent = Frame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.1,0,0.15)
    TextLabel.Size = UDim2.new(0.7,0,0.7,0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(248,248,248)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = text
    TextLabel.TextSize = 18
    TextLabel.TextScaled = false
    TextLabel.TextWrapped = true

    local TextButton = Instance.new("TextButton") 
    TextButton.Parent = Frame
    TextButton.BackgroundTransparency = 1
    TextButton.Position = UDim2.new(0.805,0,0.15)
    TextButton.Size = UDim2.new(0.15,0,0.7,0)
    TextButton.Font = Enum.Font.SourceSansBold
    TextButton.TextColor3 = Color3.fromRGB(248,248,248)
    TextButton.Text = "□"
    TextButton.TextSize = 24
    TextButton.TextScaled = false
    TextButton.TextWrapped = true

    local Toogle = false
    TextButton.MouseButton1Click:Connect(function()
    if TextButton.Text == "□" then
       TextButton.Text = "■"
       TextButton.TextSize = 22
       TextButton.Position = UDim2.new(0.8103,0,0.148)
       Toogle = true
    else
       TextButton.Text = "□"
       TextButton.TextSize = 24
       TextButton.Position = UDim2.new(0.805,0,0.15)
       Toogle = false
    end
    end)
    local BetterLoopOperator = false
    game:GetService("RunService").RenderStepped:Connect(function()
    if Toogle == true and BetterLoopOperator == false then
       BetterLoopOperator = true
       pcall(function()
       loadstring(script)()
       end)
       BetterLoopOperator = false
    end
    end)
 elseif type == "Switch" then
    local TextLabel = Instance.new("TextLabel") 
    TextLabel.Parent = Frame
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.1,0,0.15)
    TextLabel.Size = UDim2.new(0.7,0,0.7,0)
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(248,248,248)
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
    TextLabel.Text = text
    TextLabel.TextSize = 18
    TextLabel.TextScaled = false
    TextLabel.TextWrapped = true

    local ImageButton = Instance.new("ImageButton")
    ImageButton.Parent = Frame
    ImageButton.BackgroundTransparency = 1
    ImageButton.Position = UDim2.new(0.785,0,0.05)
    ImageButton.Size = UDim2.new(0.2,0,0.9,0)
    ImageButton.Image = "rbxassetid://85429087203738"
    ImageButton.Rotation = 180
    ImageButton.Draggable = false
    ImageButton.Visible = true

    ImageButton.MouseButton1Click:Connect(function()
    if ImageButton.Rotation == 180 then
       ImageButton.Rotation = 0
       loadstring(script)()
    else
       ImageButton.Rotation = 180
       loadstring(script2)()
    end
    end)
 end
 ContentPositionZ += 9.3
 if RETURN ~= nil then
    return RETURN
 end
end
