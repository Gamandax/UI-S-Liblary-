# MinecraftUILib Complete Usage Guide

## Table of Contents
1. [Getting Started](#getting-started)
2. [Basic Setup](#basic-setup)
3. [Creating Windows](#creating-windows)
4. [Working with Tabs](#working-with-tabs)
5. [UI Elements](#ui-elements)
6. [Complete Examples](#complete-examples)
7. [Tips and Best Practices](#tips-and-best-practices)

## Getting Started

### Requirements
- Roblox Studio or a Roblox game environment
- Basic Lua scripting knowledge
- The MinecraftUILib.lua file

### Installation
1. No file needed - load directly from raw GitHub link
2. Use loadstring to fetch and execute the library
3. Start creating your Minecraft-themed GUI

## Basic Setup

```lua
-- Load the library from raw GitHub link
local MinecraftUI = loadstring(game:HttpGet("https://pastefy.app/KpJchE8i/raw"))()

-- Alternative method if you have the raw link
-- local MinecraftUI = loadstring(game:HttpGet("https://pastefy.app/KpJchE8i/raw"))()

-- Create a new window
local window = MinecraftUI:Create("My Awesome GUI")

-- Create your first tab
local mainTab = window:CreateTab("Main")

-- Add elements to your tab
window:CreateButton("Click Me!", function()
    print("Button clicked!")
end, mainTab)
```

## Creating Windows

The main window is your GUI's foundation. Here's how to create one:

```lua
local MinecraftUI = loadstring(game:HttpGet("https://pastefy.app/KpJchE8i/raw"))()

-- Create window with custom title
local window = MinecraftUI:Create("Epic Script Hub")

-- The window automatically includes:
-- - Draggable functionality
-- - Minimize/restore buttons
-- - Close button with confirmation
-- - Tab system at the bottom
-- - Scrollable content area
```

### Window Features
- **Draggable**: Click and drag the title bar to move
- **Minimize**: Click the "-" button to minimize to title bar only
- **Close**: Click "X" to show confirmation dialog before closing
- **Resizable content**: Automatic scrolling when content exceeds window size

## Working with Tabs

Tabs help organize your GUI elements into categories.

```lua
-- Create multiple tabs
local mainTab = window:CreateTab("Main")
local settingsTab = window:CreateTab("Settings")  
local aboutTab = window:CreateTab("About")

-- Tabs are automatically numbered starting from 1
-- You can reference them by their index or store the returned value
```

### Tab Navigation
- Tabs appear at the bottom of the window
- Click any tab to switch between them
- Use scroll arrows (< >) when you have many tabs
- Only current tab elements are visible

## UI Elements

### 1. Buttons

Create clickable buttons that execute functions when pressed.

```lua
-- Basic button
window:CreateButton("Simple Button", function()
    print("Hello World!")
end, mainTab)

-- Button with complex functionality
window:CreateButton("Teleport to Spawn", function()
    local player = game.Players.LocalPlayer
    if player.Character then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end, mainTab)
```

**Button Features:**
- Hover effects (lightens on mouse over)
- Minecraft-style border and font
- Custom callback function execution

### 2. Toggles

Create switches that can be turned ON/OFF.

```lua
-- Basic toggle
window:CreateToggle("Enable Feature", function(state)
    if state then
        print("Feature enabled!")
        -- Enable your feature here
    else
        print("Feature disabled!")
        -- Disable your feature here
    end
end, mainTab)

-- Toggle with game functionality
local speedToggle = false
window:CreateToggle("Speed Boost", function(toggled)
    speedToggle = toggled
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        if toggled then
            player.Character.Humanoid.WalkSpeed = 50
        else
            player.Character.Humanoid.WalkSpeed = 16
        end
    end
end, mainTab)
```

**Toggle Features:**
- Shows current state (ON/OFF) in text
- Green background when enabled
- Maintains state until clicked again

### 3. Dropdowns

Create selection menus with multiple options.

```lua
-- Basic dropdown
local weapons = {"Sword", "Bow", "Axe", "Pickaxe"}
window:CreateDropdown("Select Weapon", weapons, function(selected)
    print("Selected weapon:", selected)
    -- Handle weapon selection
end, mainTab)

-- Dropdown with game teleportation
local locations = {"Spawn", "Shop", "Arena", "Forest"}
window:CreateDropdown("Teleport Location", locations, function(location)
    local player = game.Players.LocalPlayer
    local positions = {
        ["Spawn"] = CFrame.new(0, 50, 0),
        ["Shop"] = CFrame.new(100, 50, 0),
        ["Arena"] = CFrame.new(-100, 50, 0),
        ["Forest"] = CFrame.new(0, 50, 100)
    }
    
    if player.Character and positions[location] then
        player.Character.HumanoidRootPart.CFrame = positions[location]
    end
end, mainTab)
```

**Dropdown Features:**
- Scrollable when many options
- Click to open/close
- Hover effects on options
- Automatically closes other open dropdowns

### 4. Sliders

Create adjustable value selectors with min/max ranges.

```lua
-- Basic slider
window:CreateSlider("Volume", 0, 100, 50, function(value)
    print("Volume set to:", value)
    -- Adjust volume based on value
end, settingsTab)

-- Slider for game speed
window:CreateSlider("Walk Speed", 16, 100, 16, function(speed)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end, settingsTab)

-- Slider for jump power
window:CreateSlider("Jump Power", 50, 200, 50, function(power)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = power
    end
end, settingsTab)
```

**Slider Features:**
- Drag to adjust value
- Real-time value display
- Stays within defined min/max bounds
- Smooth dragging experience

### 5. Text Labels

Create informational text displays.

```lua
-- Basic text label
window:CreateTextLabel("Welcome to Epic Script!", mainTab)

-- Dynamic text label (you can update it later)
local statusLabel = window:CreateTextLabel("Status: Ready", mainTab)

-- Update label text later in your script
statusLabel.Text = "Status: Connected"
```

**Text Label Features:**
- Non-interactive display element
- Same styling as other elements
- Center-aligned text
- Can be updated dynamically

## Complete Examples

### Example 1: Simple Script GUI

```lua
local MinecraftUI = loadstring(game:HttpGet("YOUR_RAW_GITHUB_LINK_HERE"))()

-- Create the main window
local window = MinecraftUI:Create("Simple Script Hub")

-- Create tabs
local playerTab = window:CreateTab("Player")
local teleportTab = window:CreateTab("Teleport")
local settingsTab = window:CreateTab("Settings")

-- Player tab elements
window:CreateTextLabel("Player Modifications", playerTab)

window:CreateSlider("Walk Speed", 16, 100, 16, function(speed)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = speed
    end
end, playerTab)

window:CreateSlider("Jump Power", 50, 150, 50, function(power)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.JumpPower = power
    end
end, playerTab)

window:CreateToggle("Infinite Jump", function(enabled)
    -- Infinite jump logic here
    print("Infinite jump:", enabled)
end, playerTab)

-- Teleport tab elements
local locations = {"Spawn", "Shop", "Secret Area"}
window:CreateDropdown("Quick Teleport", locations, function(location)
    print("Teleporting to:", location)
    -- Add your teleport logic here
end, teleportTab)

-- Settings tab
window:CreateTextLabel("GUI Settings", settingsTab)
window:CreateButton("Reset All Settings", function()
    print("Settings reset!")
end, settingsTab)
```

### Example 2: Advanced Game Script

```lua
local MinecraftUI = loadstring(game:HttpGet("https://pastefy.app/KpJchE8i/raw"))()
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Create window
local window = MinecraftUI:Create("Advanced Game Hub")

-- Create tabs
local mainTab = window:CreateTab("Main")
local playerTab = window:CreateTab("Player")
local visualTab = window:CreateTab("Visual")
local miscTab = window:CreateTab("Misc")

-- Variables to store states
local flyEnabled = false
local espEnabled = false

-- Main tab
window:CreateTextLabel("Welcome to Advanced Hub!", mainTab)

window:CreateButton("Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId)
end, mainTab)

-- Player tab
window:CreateSlider("Walk Speed", 16, 300, 16, function(speed)
    local character = Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = speed
    end
end, playerTab)

window:CreateToggle("Fly", function(enabled)
    flyEnabled = enabled
    -- Add your fly script logic here
    print("Fly mode:", enabled)
end, playerTab)

window:CreateToggle("Noclip", function(enabled)
    local character = Players.LocalPlayer.Character
    if character then
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not enabled
            end
        end
    end
end, playerTab)

-- Visual tab
window:CreateToggle("ESP", function(enabled)
    espEnabled = enabled
    print("ESP:", enabled)
    -- Add ESP logic here
end, visualTab)

local themes = {"Dark", "Light", "Blue", "Red"}
window:CreateDropdown("Theme", themes, function(theme)
    print("Theme changed to:", theme)
    -- Add theme changing logic
end, visualTab)

-- Misc tab
window:CreateButton("Clear Chat", function()
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = "[SYSTEM] Chat cleared!";
        Color = Color3.new(0, 1, 0);
        Font = Enum.Font.Arcade;
        FontSize = Enum.FontSize.Size18;
    })
end, miscTab)

window:CreateSlider("Time of Day", 0, 24, 14, function(hour)
    game.Lighting.TimeOfDay = string.format("%02d:00:00", hour)
end, miscTab)
```

## Tips and Best Practices

### Organization
- Use descriptive tab names that clearly indicate their purpose
- Group related features together in the same tab
- Don't overcrowd tabs - create new ones when needed

### Performance
- Avoid creating too many GUI elements at once
- Use callbacks efficiently - don't put heavy processing in them
- Store references to elements you need to modify later

### User Experience
- Provide clear labels for all interactive elements
- Use reasonable default values for sliders
- Give feedback to users when actions are performed

### Code Structure
```lua
-- Good practice: Store window and important elements
local window = MinecraftUI:Create("My Script")
local mainTab = window:CreateTab("Main")

-- Store references to elements you'll modify
local speedSlider = window:CreateSlider("Speed", 16, 100, 16, function(value)
    -- Handle speed change
end, mainTab)

-- You can access the element later if needed
-- speedSlider.Text = "Custom text"
```

### Common Patterns
```lua
-- Pattern 1: Toggle with state tracking
local featureEnabled = false
window:CreateToggle("Feature Name", function(enabled)
    featureEnabled = enabled
    if enabled then
        -- Enable feature
    else
        -- Disable feature
    end
end, tabIndex)

-- Pattern 2: Dropdown with predefined actions
local actions = {
    ["Action 1"] = function() print("Action 1") end,
    ["Action 2"] = function() print("Action 2") end,
    ["Action 3"] = function() print("Action 3") end
}

local actionNames = {}
for name, _ in pairs(actions) do
    table.insert(actionNames, name)
end

window:CreateDropdown("Select Action", actionNames, function(selected)
    if actions[selected] then
        actions[selected]()
    end
end, tabIndex)
```

### Error Handling
```lua
-- Always check if objects exist before using them
window:CreateButton("Teleport", function()
    local player = Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    else
        print("Character not found!")
    end
end, mainTab)
```

This guide covers everything you need to know to effectively use MinecraftUILib in your Roblox projects. The library provides a clean, Minecraft-themed interface that's both functional and visually appealing.
