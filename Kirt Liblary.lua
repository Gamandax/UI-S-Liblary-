-- Made by Kirt
-- Helper Nexus 

-- load the library
 -- local GuiLibrary = loadstring(game:HttpGet("https://yourlinkhere.com/GuiLibrary.lua"))()

-- make window
 -- local myGui = GuiLibrary.new("My Loadstring UI", UDim2.new(0, 300, 0, 250))

-- add button 
-- myGui:addButton("Click Me!", function()
  --  print("Button clicked via loadstring GUI!")
-- end)

-- add toggle
 -- myGui:addToggle("God Mode", function(state)
  --  print("God Mode toggled:", state)
 -- end, false)

-- add text box
 -- myGui:addTextBox("Enter your name", function(text)
  --  print("Name entered:", text)
-- end)

-- print("Let's Begin")

-- Gui Liblary Source Kirt



























local GuiLibrary = {}
GuiLibrary.__index = GuiLibrary

-- == Service's== --
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- == Theme == --
local Theme = {
Background = Color3.fromRGB(40, 40, 40),
Header = Color3.fromRGB(55, 55, 55),
Button = Color3.fromRGB(70, 70, 70),
ButtonHover = Color3.fromRGB(80, 80, 80),
ToggleOn = Color3.fromRGB(60, 150, 60),
ToggleOff = Color3.fromRGB(100, 100, 100),
ToggleIndicatorOn = Color3.fromRGB(40, 200, 40),
Text = Color3.fromRGB(255, 255, 255),
Accent = Color3.fromRGB(90, 90, 90)
}

-- == Create new GUI window == --
function GuiLibrary.new(title, size)
local self = setmetatable({}, GuiLibrary)

-- == Default values == --
title = title or "GUI Library"  
size = size or UDim2.new(0, 250, 0, 200)  
  
-- == Create ScreenGui == --
self.screenGui = Instance.new("ScreenGui")  
self.screenGui.ResetOnSpawn = false  
self.screenGui.Parent = player:WaitForChild("PlayerGui")  
  
-- == Main frame == --
self.mainFrame = Instance.new("Frame")  
self.mainFrame.Size = size  
self.mainFrame.Position = UDim2.new(0.4, 0, 0.3, 0)  
self.mainFrame.BackgroundColor3 = Theme.Background  
self.mainFrame.BorderSizePixel = 0  
self.mainFrame.Active = true  
self.mainFrame.Draggable = true  
self.mainFrame.Parent = self.screenGui  
  
-- == Main frame corner == --
local mainCorner = Instance.new("UICorner")  
mainCorner.CornerRadius = UDim.new(0, 8)  
mainCorner.Parent = self.mainFrame  
  
-- == Title bar == --
self.titleLabel = Instance.new("TextLabel")  
self.titleLabel.Size = UDim2.new(1, 0, 0, 35)  
self.titleLabel.Position = UDim2.new(0, 0, 0, 0)  
self.titleLabel.BackgroundColor3 = Theme.Header  
self.titleLabel.BorderSizePixel = 0  
self.titleLabel.Text = title  
self.titleLabel.TextColor3 = Theme.Text  
self.titleLabel.Font = Enum.Font.GothamBold  
self.titleLabel.TextSize = 14  
self.titleLabel.Parent = self.mainFrame  
  
local titleCorner = Instance.new("UICorner")  
titleCorner.CornerRadius = UDim.new(0, 8)  
titleCorner.Parent = self.titleLabel  
  
-- == Content frame == --
self.contentFrame = Instance.new("ScrollingFrame")  
self.contentFrame.Size = UDim2.new(1, 0, 1, -35)  
self.contentFrame.Position = UDim2.new(0, 0, 0, 35)  
self.contentFrame.BackgroundTransparency = 1  
self.contentFrame.BorderSizePixel = 0  
self.contentFrame.ScrollBarThickness = 4  
self.contentFrame.ScrollBarImageColor3 = Theme.Button  
self.contentFrame.Parent = self.mainFrame  
  
-- == Layout == --
self.layout = Instance.new("UIListLayout")  
self.layout.Padding = UDim.new(0, 5)  
self.layout.Parent = self.contentFrame  
  
-- == Padding == --
local padding = Instance.new("UIPadding")  
padding.PaddingTop = UDim.new(0, 8)  
padding.PaddingBottom = UDim.new(0, 8)  
padding.PaddingLeft = UDim.new(0, 8)  
padding.PaddingRight = UDim.new(0, 8)  
padding.Parent = self.contentFrame  
  
-- (UPDT) content size when layout changes --
self.layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()  
    self.contentFrame.CanvasSize = UDim2.new(0, 0, 0, self.layout.AbsoluteContentSize.Y + 16)  
end)  
  
return self

end

-- Create a button --
function GuiLibrary:addButton(text, callback, color)
color = color or Theme.Button

local btn = Instance.new("TextButton")  
btn.Size = UDim2.new(1, 0, 0, 32)  
btn.Text = text  
btn.BackgroundColor3 = color  
btn.TextColor3 = Theme.Text  
btn.BorderSizePixel = 0  
btn.Font = Enum.Font.Gotham  
btn.TextSize = 12  
btn.Parent = self.contentFrame  
  
local corner = Instance.new("UICorner")  
corner.CornerRadius = UDim.new(0, 6)  
corner.Parent = btn  
  
-- Hover effects with tweening --
local hoverTween = TweenService:Create(btn,   
    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),  
    {BackgroundColor3 = Theme.ButtonHover}  
)  
  
local leaveTween = TweenService:Create(btn,  
    TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),  
    {BackgroundColor3 = color}  
)  
  
btn.MouseEnter:Connect(function()  
    hoverTween:Play()  
end)  
  
btn.MouseLeave:Connect(function()  
    leaveTween:Play()  
end)  
  
btn.MouseButton1Click:Connect(callback)  
  
return btn

end

-- Create a toggle button --
function GuiLibrary:addToggle(text, callback, defaultState, color)
color = color or Theme.Button
defaultState = defaultState or false

local btn = Instance.new("TextButton")  
btn.Size = UDim2.new(1, 0, 0, 32)  
btn.Text = text  
btn.BackgroundColor3 = defaultState and Theme.ToggleOn or color  
btn.TextColor3 = Theme.Text  
btn.BorderSizePixel = 0  
btn.Font = Enum.Font.Gotham  
btn.TextSize = 12  
btn.Parent = self.contentFrame  
  
local corner = Instance.new("UICorner")  
corner.CornerRadius = UDim.new(0, 6)  
corner.Parent = btn  
  
-- Toggle indicator background --
local toggleIndicator = Instance.new("Frame")  
toggleIndicator.Size = UDim2.new(0, 40, 0, 16)  
toggleIndicator.Position = UDim2.new(1, -45, 0.5, -8)  
toggleIndicator.BackgroundColor3 = defaultState and Theme.ToggleIndicatorOn or Theme.ToggleOff  
toggleIndicator.BorderSizePixel = 0  
toggleIndicator.Parent = btn  
  
local indicatorCorner = Instance.new("UICorner")  
indicatorCorner.CornerRadius = UDim.new(0, 8)  
indicatorCorner.Parent = toggleIndicator  
  
-- Toggle circle --
local toggleCircle = Instance.new("Frame")  
toggleCircle.Size = UDim2.new(0, 12, 0, 12)  
toggleCircle.Position = defaultState and UDim2.new(0, 26, 0, 2) or UDim2.new(0, 2, 0, 2)  
toggleCircle.BackgroundColor3 = Theme.Text  
toggleCircle.BorderSizePixel = 0  
toggleCircle.Parent = toggleIndicator  
  
local circleCorner = Instance.new("UICorner")  
circleCorner.CornerRadius = UDim.new(0, 6)  
circleCorner.Parent = toggleCircle  
  
local toggled = defaultState  
  
-- === Toggle function  animations -- ===
local function toggle()  
    toggled = not toggled  
      
    local buttonTween = TweenService:Create(btn,  
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),  
        {BackgroundColor3 = toggled and Theme.ToggleOn or color}  
    )  
      
    local indicatorTween = TweenService:Create(toggleIndicator,  
        TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),  
        {BackgroundColor3 = toggled and Theme.ToggleIndicatorOn or Theme.ToggleOff}  
    )  
      
    local circleTween = TweenService:Create(toggleCircle,  
        TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out),  
        {Position = toggled and UDim2.new(0, 26, 0, 2) or UDim2.new(0, 2, 0, 2)}  
    )  
      
    buttonTween:Play()  
    indicatorTween:Play()  
    circleTween:Play()  
      
    callback(toggled)  
end  
  
btn.MouseButton1Click:Connect(toggle)  
  
return btn, function() return toggled end

end

-- Create a label --
function GuiLibrary:addLabel(text, textSize)
textSize = textSize or 12

local label = Instance.new("TextLabel")  
label.Size = UDim2.new(1, 0, 0, 25)  
label.Text = text  
label.BackgroundTransparency = 1  
label.TextColor3 = Theme.Text  
label.Font = Enum.Font.Gotham  
label.TextSize = textSize  
label.TextXAlignment = Enum.TextXAlignment.Left  
label.Parent = self.contentFrame  
  
return label

end

-- Create a text input --
function GuiLibrary:addTextBox(placeholder, callback)
placeholder = placeholder or "Enter text..."

local textBox = Instance.new("TextBox")  
textBox.Size = UDim2.new(1, 0, 0, 32)  
textBox.PlaceholderText = placeholder  
textBox.Text = ""  
textBox.BackgroundColor3 = Theme.Button  
textBox.TextColor3 = Theme.Text  
textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)  
textBox.BorderSizePixel = 0  
textBox.Font = Enum.Font.Gotham  
textBox.TextSize = 12  
textBox.Parent = self.contentFrame  
  
local corner = Instance.new("UICorner")  
corner.CornerRadius = UDim.new(0, 6)  
corner.Parent = textBox  
  
local padding = Instance.new("UIPadding")  
padding.PaddingLeft = UDim.new(0, 8)  
padding.PaddingRight = UDim.new(0, 8)  
padding.Parent = textBox  
  
if callback then  
    textBox.FocusLost:Connect(function(enterPressed)  
        if enterPressed then  
            callback(textBox.Text)  
        end  
    end)  
end  
  
return textBox

end

-- == Add a separator line == --
function GuiLibrary:addSeparator()
local separator = Instance.new("Frame")
separator.Size = UDim2.new(1, 0, 0, 1)
separator.BackgroundColor3 = Theme.Header
separator.BorderSizePixel = 0
separator.Parent = self.contentFrame

return separator

end

-- Show/Hide the GUI --
function GuiLibrary:setVisible(visible)
self.screenGui.Enabled = visible
end

-- Destroy the GUI --
function GuiLibrary:destroy()
if self.screenGui then
self.screenGui:Destroy()
end
end

-- == (UPDT) theme colors == --
function GuiLibrary.setTheme(newTheme)
for key, value in pairs(newTheme) do
Theme[key] = value
end
end

return GuiLibrary

print("•Welcome To Aux hub!•")


