-- [[ This Example ]]
local lib = loadstring(game:HttpGet("https://pastefy.app/oRV00s9l/raw"))()

local main = lib:CreateWindow("Advanced GUI")

local combat = main:AddFolder("Combat")
combat:AddToggle({text = "Auto Click", callback = function(v) print("Auto Click:", v) end})
combat:AddSlider({text = "CPS", min = 1, max = 20, value = 10, callback = function(v) print("CPS:", v) end})

local movement = main:AddFolder("Movement")
movement:AddToggle({text = "Speed", callback = function(v) print("Speed:", v) end})
movement:AddSlider({text = "Speed Value", min = 16, max = 100, value = 16})

local visuals = main:AddFolder("Visuals")
visuals:AddToggle({text = "ESP", callback = function(v) print("ESP:", v) end})
visuals:AddColor({text = "ESP Color", color = Color3.fromRGB(255, 0, 255)})

local settings = main:AddFolder("Settings")
settings:AddBind({text = "Toggle GUI", key = "Insert"})
settings:AddBox({text = "Config Name", value = "default"})
settings:AddButton({text = "Save Config", callback = function() print("Config saved!") end})

lib:Init()
