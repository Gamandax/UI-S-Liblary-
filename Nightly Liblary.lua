local NightyLibrary = {}

local function playClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://535716488" -- It's a Minecraft Clicked Change it if you want
    sound.Volume = 2
    sound.PlayOnRemove = true
    sound.Parent = workspace
    sound:Destroy()
end

local function Notify(msg)
    wait(1)
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "[GOOD]"; -- Title Of Notification 
        Text = msg; -- Message text depends of toggle or button logic on loader
        Icon = "rbxassetid://8780940355"; -- Change This Icon what you want
        Duration = 2; -- Change Duration what you want
    })
end

function NightyLibrary:CreateWindow(titleText)
    local player = game.Players.LocalPlayer
    local UserInputService = game:GetService("UserInputService")

    local gui = Instance.new("ScreenGui")
    gui.Name = "Nighty"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 220, 0, 140)
    frame.Position = UDim2.new(0.5, -110, 0.5, -70)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -25, 0, 20)
    title.Position = UDim2.new(0, 5, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansBold
    title.Text = titleText
    title.TextSize = 15
    title.TextWrapped = true
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 20, 0, 20)
    close.Position = UDim2.new(1, -22, 0, 0)
    close.BackgroundTransparency = 1
    close.Font = Enum.Font.SourceSansBold
    close.Text = "X"
    close.TextSize = 15
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.Parent = frame

    close.MouseButton1Click:Connect(function()
        playClickSound()
        Notify("Window Closed - GUI has been destroyed")
        gui:Destroy()
    end)

    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    local window = {Frame = frame}
    function window:CreateToggle(text, callback)
        if not self._buttons then
            self._buttons = {}
        end
        table.insert(self._buttons, {Text = text, Callback = callback})
    end
    return setmetatable(window, {__index = NightyLibrary})
end

function NightyLibrary:_DrawButtons()
    if not self._buttons then return end
    local col, row = 0, 0
    for _, btnData in ipairs(self._buttons) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.46, 0, 0, 25)
        btn.Position = UDim2.new(0.02 + (col * 0.5), 0, 0, 25 + (row * 30))
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        btn.Font = Enum.Font.SourceSansBold
        btn.Text = btnData.Text .. ": Off"
        btn.TextSize = 11
        btn.TextWrapped = true
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 4)
        btnCorner.Parent = btn
        btn.Parent = self.Frame

        local toggled = false
        btn.MouseButton1Click:Connect(function()
            toggled = not toggled
            btn.Text = btnData.Text .. (toggled and ": On" or ": Off")
            btn.BackgroundColor3 = toggled and Color3.fromRGB(40, 40, 40) or Color3.fromRGB(20, 20, 20)
            playClickSound()
            Notify(btnData.Text .. (toggled and " turned ON" or " turned OFF"))
            if btnData.Callback then
                btnData.Callback(toggled)
            end
        end)

        col = col + 1
        if col > 1 then
            col = 0
            row = row + 1
        end
    end
end

return NightyLibrary
