-- Aux Hub Key System - Modern & Compact
-- Ultra clean design with transparency

local CONFIG = {
    ValidKeys = {
        "ZUckKpOwbdak-282728722927",
        "*∆*",
        "*∆*"
    },
    LootLabsLink = "https://loot-link.com/s?YEwgXgpy" -- Replace with your link
}

local function validateKey(key)
    for _, validKey in pairs(CONFIG.ValidKeys) do
        if key == validKey then
            return true
        end
    end
    return false
end

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local SubText = Instance.new("TextLabel")
local KeyBox = Instance.new("TextBox")
local KeyBoxCorner = Instance.new("UICorner")
local KeyBoxStroke = Instance.new("UIStroke")
local SubmitButton = Instance.new("TextButton")
local SubmitCorner = Instance.new("UICorner")
local SubmitStroke = Instance.new("UIStroke")
local CopyButton = Instance.new("TextButton")
local CopyCorner = Instance.new("UICorner")
local CopyStroke = Instance.new("UIStroke")
local StatusLabel = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")

-- ScreenGui
ScreenGui.Name = "AuxKeySystem"
ScreenGui.ResetOnSpawn = false
pcall(function()
    ScreenGui.Parent = game:GetService("CoreGui")
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Main Frame (Small & Transparent)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BackgroundTransparency = 0.3
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -110)
MainFrame.Size = UDim2.new(0, 300, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Title
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "AUX HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.TextTransparency = 0

-- Sub Text (Key system info)
SubText.Name = "SubText"
SubText.Parent = MainFrame
SubText.BackgroundTransparency = 1
SubText.Position = UDim2.new(0, 0, 0, 38)
SubText.Size = UDim2.new(1, 0, 0, 20)
SubText.Font = Enum.Font.Gotham
SubText.Text = "The Key system not Take Too long!"
SubText.TextColor3 = Color3.fromRGB(200, 200, 200)
SubText.TextSize = 11
SubText.TextTransparency = 0.2

-- Key Input Box
KeyBox.Name = "KeyBox"
KeyBox.Parent = MainFrame
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
KeyBox.BackgroundTransparency = 0.5
KeyBox.BorderSizePixel = 0
KeyBox.Position = UDim2.new(0.5, -130, 0, 70)
KeyBox.Size = UDim2.new(0, 260, 0, 35)
KeyBox.Font = Enum.Font.Gotham
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
KeyBox.Text = ""
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.TextSize = 13
KeyBox.TextTransparency = 0
KeyBox.ClearTextOnFocus = false

KeyBoxCorner.CornerRadius = UDim.new(0, 8)
KeyBoxCorner.Parent = KeyBox

KeyBoxStroke.Color = Color3.fromRGB(80, 80, 100)
KeyBoxStroke.Thickness = 1
KeyBoxStroke.Transparency = 0.5
KeyBoxStroke.Parent = KeyBox

-- Submit Button
SubmitButton.Name = "SubmitButton"
SubmitButton.Parent = MainFrame
SubmitButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
SubmitButton.BackgroundTransparency = 0.3
SubmitButton.BorderSizePixel = 0
SubmitButton.Position = UDim2.new(0.5, -130, 0, 115)
SubmitButton.Size = UDim2.new(0, 260, 0, 32)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.Text = "SUBMIT"
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.TextSize = 14
SubmitButton.TextTransparency = 0

SubmitCorner.CornerRadius = UDim.new(0, 8)
SubmitCorner.Parent = SubmitButton

SubmitStroke.Color = Color3.fromRGB(150, 150, 255)
SubmitStroke.Thickness = 1
SubmitStroke.Transparency = 0.5
SubmitStroke.Parent = SubmitButton

-- Copy Link Button
CopyButton.Name = "CopyButton"
CopyButton.Parent = MainFrame
CopyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 200)
CopyButton.BackgroundTransparency = 0.3
CopyButton.BorderSizePixel = 0
CopyButton.Position = UDim2.new(0.5, -130, 0, 155)
CopyButton.Size = UDim2.new(0, 260, 0, 32)
CopyButton.Font = Enum.Font.GothamBold
CopyButton.Text = "COPY LINK"
CopyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CopyButton.TextSize = 14
CopyButton.TextTransparency = 0

CopyCorner.CornerRadius = UDim.new(0, 8)
CopyCorner.Parent = CopyButton

CopyStroke.Color = Color3.fromRGB(255, 150, 220)
CopyStroke.Thickness = 1
CopyStroke.Transparency = 0.5
CopyStroke.Parent = CopyButton

-- Status Label
StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 0, 0, 195)
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextSize = 10
StatusLabel.TextTransparency = 0.3

-- Close Button
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundTransparency = 1
CloseButton.Position = UDim2.new(1, -30, 0, 5)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "×"
CloseButton.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseButton.TextSize = 20
CloseButton.TextTransparency = 0.2

-- Button Hover Effects
local function addHover(button, normalTrans, hoverTrans)
    button.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundTransparency = hoverTrans}):Play()
    end)
    button.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {BackgroundTransparency = normalTrans}):Play()
    end)
end

addHover(SubmitButton, 0.3, 0.1)
addHover(CopyButton, 0.3, 0.1)

-- Submit Button Logic
SubmitButton.MouseButton1Click:Connect(function()
    local key = KeyBox.Text
    
    if key == "" then
        StatusLabel.Text = "Enter a key first!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    StatusLabel.Text = "Checking..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    
    wait(0.3)
    
    if validateKey(key) then
        StatusLabel.Text = "Access Granted!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 150)
        
        wait(0.5)
        ScreenGui:Destroy()
        
        -- YOUR MAIN SCRIPT HERE
        print("Aux Hub Loaded Successfully!")
        loadstring(game:HttpGet("note for me replace your own URL"))()
        
    else
        StatusLabel.Text = "Invalid Key!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        KeyBox.Text = ""
    end
end)

-- Copy Link Button
CopyButton.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(CONFIG.LootLabsLink)
        StatusLabel.Text = "Link Copied!"
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 200)
    else
        StatusLabel.Text = CONFIG.LootLabsLink
        StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
    end
end)

-- Close Button
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
