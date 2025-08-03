-- ========================================
-- SIMPLE RED LIGHT THEME APPLICATION
-- Clear and easy to understand code
-- ========================================

print("🔴 Loading Red Light Theme...")

-- STEP 1: Load the libraries
local AUXLib = loadstring(game:HttpGet("https://pastefy.app/1p58o92F/raw"))()
local AUXThemer = loadstring(game:HttpGet("https://pastefy.app/fRogs158/raw"))()

-- STEP 2: Create a simple window
local Window = AUXLib:CreateWindow("Red Theme Test")

-- STEP 3: Add some test elements
Window:AddLabel({
    text = "🔴 Testing Red Light Theme"
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

-- STEP 4: Initialize the UI (IMPORTANT!)
_G.AUXLibUI = AUXLib:Init()
print("✅ UI Created")

-- STEP 5: Wait for UI to load
wait(2)
print("⏳ UI loaded, applying theme...")

-- STEP 6: Apply RED LIGHT theme (THIS IS THE MAIN PART!)
local success = AUXThemer:ApplyTheme("red light")

-- STEP 7: Check if theme applied successfully
if success then
    print("✅ RED LIGHT THEME APPLIED!")
    print("🔴 You should see:")
    print("  • Dark red backgrounds")
    print("  • Light red text")
    print("  • Red highlights on buttons/toggles")
else
    print("❌ Theme failed to apply")
end

-- ========================================
-- THAT'S IT! SIMPLE AS THAT!
-- ========================================

print("========================================")
print("🎯 HOW TO APPLY ANY THEME:")
print("1. Load libraries")
print("2. Create window and elements") 
print("3. Initialize: _G.AUXLibUI = AUXLib:Init()")
print("4. Wait 2 seconds")
print("5. Apply theme: AUXThemer:ApplyTheme('theme_name')")
print("========================================")

-- ========================================
-- BONUS: Other themes you can try
-- ========================================
--[[
OTHER AVAILABLE THEMES (replace "red light" with any of these):

AUXThemer:ApplyTheme("default")      -- Black theme
AUXThemer:ApplyTheme("blue dark")    -- Dark blue
AUXThemer:ApplyTheme("red dark")     -- Dark red  
AUXThemer:ApplyTheme("yellow dark")  -- Dark yellow
AUXThemer:ApplyTheme("ocean")        -- Ocean blue
AUXThemer:ApplyTheme("cardboard")    -- Brown
AUXThemer:ApplyTheme("amelyst")      -- Purple
AUXThemer:ApplyTheme("green light")  -- Bright green
AUXThemer:ApplyTheme("white")        -- White/light
AUXThemer:ApplyTheme("red light")    -- Bright red (current)
AUXThemer:ApplyTheme("blue light")   -- Bright blue
--]]
