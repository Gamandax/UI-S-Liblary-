-- // load \\ --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gamandax/UI-S-Liblary-/refs/heads/main/ZenLibrary/Clone%20v2.lua"))()
-- // Create Window \\ --
local MainWindow = Library:CreateWindow("Demo Hub")
-- // create button \\ --
MainWindow:Button("Greet", function()
    print("Hello from the button!")
end)
-- // Create Slider \\ --
MainWindow:Slider("Speed", 16, 100, false, function(val)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
    print("WalkSpeed set to:", val)
end)
-- // Create Toggle \\ --
MainWindow:Toggle("Auto Jump", function(isOn)
    print("Auto Jump toggled:", isOn)
end)
-- // Create Textbox \\ --
MainWindow:Box("Player Name", function(txt)
    print("Player wants to be called:", txt)
end)
-- // Main window Theme toggle \\ --
MainWindow:ThemeToggle()

-- Apply a specific theme to start
Library:SetTheme("pastel")

-- // Available Theme you cam use \\ --
--[[
dark  
light  
ocean  
y2k  
midnight  
sunset  
forest  
ice  
cyber  
pastel  
galaxy  
cloud  
inferno  
tokyo
--]]
