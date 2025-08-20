local AUXLib = loadstring(game:HttpGet("https://pastefy.app/NyLRfJ7T/raw"))()
local AUXThemer = loadstring(game:HttpGet("https://pastefy.app/OwI0S15o/raw"))()

local Window = AUXLib:CreateWindow("Red Theme Test")

Window:AddLabel({
    text = "Testing Red Light Theme"
})

Window:AddToggle({
    text = "Test Toggle",
    state = false,
    callback = function(state)
        print("Toggle:", state)
    end
})

Window:AddButton({
    text = "Test Button",
    callback = function()
        print("Button clicked!")
    end
})

Window:AddSlider({
    text = "Test Slider",
    min = 0,
    max = 100,
    value = 50,
    callback = function(value)
        print("Slider:", value)
    end
})

_G.AUXLibUI = AUXLib:Init()
print("UI Created")

wait(2)
print("UI loaded, applying theme...")

local success = AUXThemer:ApplyTheme("red light") -- Change want you want Theme Only On ( MDL THM )
