-- [[ This for V2 and V3 ]] --
-- [[ Scroll Down For V1 ]] --
--    [[ by VantaXock ]]    --

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gamandax/UI-S-Liblary-/refs/heads/main/Ghost%20Liblary/Zens%20Library%20Versions/Zen-v2.lua"))() -- just change the v3 to v3 or whatever you want version but I'd recommend The New Update of my zen library use v4

local main = library:CreateWindow("Main")

main:AddButton({
    text = "Reset Character",
    flag = "resetBtn",
    callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
        print("Character reset!")
    end
})

main:AddToggle({
    text = "ESP",
    flag = "esp",
    callback = function(state)
        print("ESP:", state)
    end
})

main:AddSlider({
    text = "FOV",
    min = 60,
    max = 120,
    flag = "fov",
    callback = function(val)
        workspace.CurrentCamera.FieldOfView = val
        print("FOV set to:", val)
    end
})

main:AddBox({
    text = "Walkspeed",
    flag = "walkspeedBox",
    callback = function(text)
        local speed = tonumber(text)
        if speed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
            print("Walkspeed set to:", speed)
        end
    end
})

main:AddKeybind({
    text = "Fly Toggle",
    key = Enum.KeyCode.F,
    mode = "toggle", -- toggle or hold
    flag = "flyKey",
    callback = function(active)
        print("Fly is:", active)
    end
})

local weaponDropdown = main:AddDropdown({
    text = "Select Weapon",
    values = {"Sword", "Gun", "Bow"},
    value = "Sword", -- default
    flag = "weaponSelect",
    callback = function(selected)
        print("Selected weapon:", selected)
    end
})

local combat = main:AddFolder("Combat Settings")

combat:AddButton({
    text = "Kill All",
    callback = function()
        print("Kill all executed!")
    end
})

combat:AddToggle({
    text = "Auto Farm",
    flag = "autoFarm",
    callback = function(state)
        print("Auto farm:", state)
    end
})

combat:AddSlider({
    text = "Attack Range",
    min = 10,
    max = 100,
    flag = "attackRange",
    callback = function(val)
        print("Range:", val)
    end
})

combat:AddBox({
    text = "Target Name",
    flag = "targetName",
    callback = function(text)
        print("Target:", text)
    end
})

combat:AddKeybind({
    text = "Aimbot Key",
    key = Enum.KeyCode.E,
    mode = "hold",
    flag = "aimbotKey",
    callback = function(active)
        print("Aimbot active:", active)
    end
})

combat:AddDropdown({
    text = "Attack Mode",
    values = {"Fast", "Normal", "Slow"},
    flag = "attackMode",
    callback = function(selected)
        print("Attack mode:", selected)
    end
})

game:GetService("RunService").RenderStepped:Connect(function()
    
    if library.flags["esp"] then
        
    end
    
    
    if library.flags["flyKey_active"] then
        
    end
    
  
    if library.flags["aimbotKey_active"] then
        
    end
    
    local fov = library.flags["fov"]
    
    local walkspeed = library.flags["walkspeedBox"]
    
    local weapon = library.flags["weaponSelect"]
    local attackMode = library.flags["attackMode"]
    
    if library.flags["autoFarm"] then
        local range = library.flags["attackRange"]
        local target = library.flags["targetName"]
        
    end
end)

task.wait(5)
weaponDropdown:AddValue("Staff")
weaponDropdown:RemoveValue("Bow") 
weaponDropdown:SetValue("Gun") 

library:Init()







-- [[ Example for V1 ]] --

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gamandax/UI-S-Liblary-/refs/heads/main/Ghost%20Liblary/Zens%20Library%20Versions/Zen-v1.lua"))()

local window = library:CreateWindow("Zen")

window:Button("Test", function()
    print("test")
end)

window:Toggle("Feature", function(enabled)
    if enabled then
        print("on")
    else
        print("off")
    end
end)

window:Box("Enter Text", function(text)
    print("You entered:", text)
end)

window:Keybind("Toggle GUI", Enum.KeyCode.F, "toggle", function(active)
    print("GUI toggled:", active)
end)

window:Dropdown("Select Option", {"Option 1", "Option 2", "Option 3"}, function(selected)
    print("Selected:", selected)
end)

window:Slider("Value", 0, 100, false, function(value)
    print("Slider value:", value)
end)

local folder = window:AddFolder("Folder")

folder:Button("Folder Button", function()
    print("folder button clicked")
end)

folder:Toggle("Folder Toggle", function(enabled)
    print("folder toggle:", enabled)
end)

folder:Box("Folder 4px Box", function(text)
    print("folder input:", text)
end)

folder:Keybind("Folder Keybind", Enum.KeyCode.H, "toggle", function(active)
    print("folder keybind:", active)
end)

folder:Dropdown("Folder Dropdown", {"Folder A", "Folder B"}, function(selected)
    print("folder dropdown:", selected)
end)

folder:Slider("Folder Slider", 10, 90, false, function(value)
    print("folder slider:", value)
end)

library:Init()
