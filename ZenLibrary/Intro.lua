-- // Intro for Zen Liblary \\ --


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZenLibraryIntro"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local IntroFrame = Instance.new("Frame")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Version = Instance.new("TextLabel")
local Creator = Instance.new("TextLabel")
local Slant = Instance.new("ImageLabel")

IntroFrame.Name = "IntroFrame"
IntroFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
IntroFrame.BorderSizePixel = 0
IntroFrame.Position = UDim2.new(1, 30, 0, 0)
IntroFrame.Size = UDim2.new(0, 300, 1, 0)
IntroFrame.ZIndex = 2

Main.Name = "Main"
Main.Parent = IntroFrame
Main.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0, -30, 0, 0)
Main.Size = UDim2.new(0, 30, 0, 90)
Main.ZIndex = 2

Title.Name = "Title"
Title.Parent = IntroFrame
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 100, 0, 150)
Title.Size = UDim2.new(0, 100, 0, 60)
Title.ZIndex = 2
Title.Font = Enum.Font.SourceSansBold
Title.FontSize = Enum.FontSize.Size60
Title.Text = "Zen Library"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextWrapped = true

Version.Name = "Version"
Version.Parent = IntroFrame
Version.BackgroundColor3 = Color3.new(0, 0, 0)
Version.BackgroundTransparency = 1
Version.Position = UDim2.new(0, 100, 0, 210)
Version.Size = UDim2.new(0, 100, 0, 30)
Version.ZIndex = 2
Version.Font = Enum.Font.SourceSansBold
Version.FontSize = Enum.FontSize.Size28
Version.Text = "V1.0.0.0"
Version.TextColor3 = Color3.new(0.8, 0.8, 0.8)
Version.TextWrapped = true

Creator.Name = "Creator"
Creator.Parent = IntroFrame
Creator.BackgroundColor3 = Color3.new(0, 0, 0)
Creator.BackgroundTransparency = 1
Creator.Position = UDim2.new(0, 80, 0, 300)
Creator.Size = UDim2.new(0, 140, 0, 30)
Creator.ZIndex = 2
Creator.Font = Enum.Font.SourceSansBold
Creator.FontSize = Enum.FontSize.Size28
Creator.Text = "welcome"
Creator.TextColor3 = Color3.new(0.7, 0.7, 0.7)
Creator.TextWrapped = true

Slant.Name = "Slant"
Slant.Parent = IntroFrame
Slant.BackgroundColor3 = Color3.new(0, 0, 0)
Slant.BackgroundTransparency = 1
Slant.Position = UDim2.new(0, -30, 0, 90)
Slant.Rotation = 180
Slant.Size = UDim2.new(0, 30, 0, 30)
Slant.ZIndex = 2
Slant.Image = "rbxassetid://474172996"
Slant.ImageColor3 = Color3.new(0.1, 0.1, 0.1)

IntroFrame.Parent = ScreenGui

spawn(function()
    wait()
    
    IntroFrame:TweenPosition(
        UDim2.new(1, -300, 0, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        1,
        true
    )
    
    wait(5)
    
    for i = 0, 1, 0.1 do
        IntroFrame.BackgroundTransparency = i
        Main.BackgroundTransparency = i
        Slant.ImageTransparency = i
        Title.TextTransparency = i
        Version.TextTransparency = i
        Creator.TextTransparency = i
        wait()
    end
    
    IntroFrame.Visible = false
end)
