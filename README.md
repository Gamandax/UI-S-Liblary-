# 🚀 Nexus Library - Roblox UI Library - Main Nexus Liblary 

A modern, sleek, and easy-to-use UI library for Roblox scripting. Create beautiful interfaces with buttons, toggles, and text inputs effortlessly!

## ✨ Features

- 🎨 **Modern Design** - Clean, dark theme with smooth animations
- 🪟 **Multiple Windows** - Support for multiple draggable windows
- 📱 **Responsive** - Automatically positions windows to avoid overlap
- 🎯 **Easy to Use** - Simple API for quick implementation
- 🔧 **Customizable** - Flexible callbacks and styling options

## 📦 Installation

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HEnVELINC/Nex-liblary-/refs/heads/main/Energy.lua"))()
```

## 🎮 Quick Start

```lua
-- Load the library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HEnVELINC/Nex-liblary-/refs/heads/main/Energy.lua"))()

-- Create a window
local Window = Library:Window("My Script")

-- Add components
Window:Button("Click Me!", function()
    print("Button clicked!")
end)

Window:Toggle("Enable Feature", function(enabled)
    print("Toggle is now: " .. (enabled and "ON" or "OFF"))
end)

Window:TextBox("Enter Value", "Type here...", function(text)
    print("You entered: " .. text)
end)
```

## 📚 Documentation

### 🪟 Creating a Window

```lua
local Window = Library:Window("Window Title")
```

**Parameters:**
- `title` (string) - The title displayed on the window

**Features:**
- ✅ Draggable
- ✅ Minimizable 
- ✅ Auto-positioning
- ✅ Clean animations

---

### 🔘 Button Component

```lua
Window:Button("Button Name", function()
    -- Your code here
end)
```

**Parameters:**
- `name` (string) - Text displayed on the button
- `callback` (function) - Function to execute when clicked

**Example:**
```lua
Window:Button("Add Money", function()
    playerMoney = playerMoney + 100
    print("Money added! Balance: $" .. playerMoney)
end)
```

---

### 🔄 Toggle Component

```lua
Window:Toggle("Toggle Name", function(enabled)
    -- Your code here
end)
```

**Parameters:**
- `name` (string) - Label for the toggle
- `callback` (function) - Function called with boolean state

**Example:**
```lua
Window:Toggle("Auto Farm", function(enabled)
    if enabled then
        print("Auto farm started!")
        -- Start farming logic
    else
        print("Auto farm stopped!")
        -- Stop farming logic
    end
end)
```

---

### 📝 TextBox Component

```lua
local textBox = Window:TextBox("Label", "Placeholder", function(text)
    -- Your code here
end)
```

**Parameters:**
- `name` (string) - Label displayed above the textbox
- `placeholder` (string) - Gray text shown when empty
- `callback` (function) - Function called with the input text

**Example:**
```lua
Window:TextBox("Player Name", "Enter username...", function(text)
    if text ~= "" then
        targetPlayer = text
        print("Target set to: " .. text)
    end
end)
```

**Features:**
- ✅ Real-time text change detection
- ✅ Enter key support
- ✅ Focus visual feedback
- ✅ Placeholder text support

---

## 🎯 Complete Example

```lua
-- Load library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HEnVELINC/Nex-liblary-/refs/heads/main/Energy.lua"))()

-- Create main window
local MainWindow = Library:Window("Script Hub")

-- Variables
local money = 0
local autoFarmEnabled = false

-- Money system
MainWindow:Button("Add $100", function()
    money = money + 100
    print("💰 Money: $" .. money)
end)

MainWindow:TextBox("Custom Amount", "Enter amount...", function(text)
    local amount = tonumber(text)
    if amount then
        money = money + amount
        print("💰 Added $" .. amount .. " | Total: $" .. money)
    end
end)

-- Features
MainWindow:Toggle("Auto Farm", function(enabled)
    autoFarmEnabled = enabled
    if enabled then
        print("🚜 Auto Farm Started!")
        -- Add your auto farm code here
    else
        print("🛑 Auto Farm Stopped!")
    end
end)

MainWindow:Toggle("Speed Boost", function(enabled)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = enabled and 50 or 16
        print("🏃 Speed: " .. (enabled and "BOOSTED" or "NORMAL"))
    end
end)

-- Teleport system
MainWindow:TextBox("Teleport to Player", "Username...", function(text)
    for _, player in pairs(game.Players:GetPlayers()) do
        if string.lower(player.Name):find(string.lower(text)) then
            local localPlayer = game.Players.LocalPlayer
            if localPlayer.Character and player.Character then
                localPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                print("🚀 Teleported to " .. player.Name)
                return
            end
        end
    end
    print("❌ Player not found!")
end)

-- Status button
MainWindow:Button("Show Status", function()
    print("=== STATUS ===")
    print("💰 Money: $" .. money)
    print("🚜 Auto Farm: " .. (autoFarmEnabled and "ON" or "OFF"))
    print("==============")
end)

-- Create second window (optional)
local SettingsWindow = Library:Window("Settings")

SettingsWindow:Button("Reset Everything", function()
    money = 0
    autoFarmEnabled = false
    print("🔄 Everything reset!")
end)
```

## 🎨 Customization

### Window Features
- **Draggable**: Click and drag the title bar to move windows
- **Minimizable**: Click the arrow button to collapse/expand
- **Auto-positioning**: New windows automatically position to avoid overlap

### Visual Effects
- **Smooth animations** on all interactions
- **Focus indicators** for text inputs
- **Hover effects** on interactive elements
- **Color-coded feedback** (green for active, red for inactive)

## 🔧 Advanced Usage

### Multiple Windows
```lua
local MainWindow = Library:Window("Main Features")
local SettingsWindow = Library:Window("Settings")
local TeleportWindow = Library:Window("Teleports")

-- Each window operates independently
MainWindow:Button("Main Feature", function() end)
SettingsWindow:Toggle("Setting", function(enabled) end)
TeleportWindow:TextBox("Location", "Enter...", function(text) end)
```

### Storing References
```lua
-- You can store textbox references for later use
local moneyInput = Window:TextBox("Money", "Amount...", function(text)
    -- Callback code
end)

-- Access the textbox object later if needed
-- moneyInput.Text = "1000"  -- Set default value
```

## 🐛 Troubleshooting

### Common Issues

**Library not loading:**
```lua
-- Make sure you have the correct URL
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/HEnVELINC/Nex-liblary-/refs/heads/main/Energy.lua"))()
```

**Callbacks not working:**
```lua
-- Make sure your callback is a function
Window:Button("Test", function()  -- ✅ Correct
    print("Works!")
end)

Window:Button("Test", print("Wrong!"))  -- ❌ Wrong
```

**TextBox not responding:**
```lua
-- TextBox calls callback on text change AND when Enter is pressed
Window:TextBox("Input", "Placeholder...", function(text)
    if text ~= "" then  -- Check for empty text
        -- Your code here
    end
end)
```

## 📸 Screenshots

The library features a modern dark theme with:
- Clean, rounded corners
- Smooth animations
- Professional color scheme
- Intuitive icons and indicators

## 🤝 Contributing

Feel free to:
- Report bugs by creating issues
- Suggest new features
- Submit pull requests
- Share your creations using this library

## 📄 License

Free to use for any Roblox projects. Credit is appreciated but not required!

## 🔗 Links

- **GitHub Repository**: [Nexus Library](https://github.com/Pitcherque/Nexus-Liblary-)
- **Raw Script URL**: `https://raw.githubusercontent.com/HEnVELINC/Nex-liblary-/refs/heads/main/Energy.lua`

---

**Made with ❤️ for the Roblox scripting community**

*Happy scripting! 🚀*
