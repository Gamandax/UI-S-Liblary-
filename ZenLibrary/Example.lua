-- // Example \\ --



-- Load the library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Gamandax/UI-S-Liblary-/refs/heads/main/ZenLibrary/Zen%20Liblary.lua"))()

-- Create one window
local Window = Library:CreateWindow("Main")

-- Add one button
Window:Button("Test Button", function()
    print("Button clicked!")
end)

-- Add one toggle
Window:Toggle("Toggle Feature", function(enabled)
    print("Toggle is now:", enabled)
end)

-- Add one text box
Window:Box("Enter Value", function(text)
    print("Text entered:", text)
end)

-- Add one slider
Window:Slider("Speed", 1, 100, false, function(value)
    print("Slider value:", value)
end)
