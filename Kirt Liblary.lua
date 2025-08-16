-- Made by Kirt
-- Helper Nexus 

-- load the library
local GuiLibrary = loadstring(game:HttpGet("https://yourlinkhere.com/GuiLibrary.lua"))()

-- make window
local myGui = GuiLibrary.new("My Loadstring UI", UDim2.new(0, 300, 0, 250))

-- add button 
myGui:addButton("Click Me!", function()
    print("Button clicked via loadstring GUI!")
end)

-- add toggle
myGui:addToggle("God Mode", function(state)
    print("God Mode toggled:", state)
end, false)

-- add text box
myGui:addTextBox("Enter your name", function(text)
    print("Name entered:", text)
end)

print("Let's Begin")
