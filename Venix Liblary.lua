--// VenixLib by Nexus \\--

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Venix = {}
Venix.__index = Venix

local function mk(inst, props, children)
    local o = Instance.new(inst)
    for k,v in pairs(props or {}) do o[k] = v end
    for _,c in ipairs(children or {}) do c.Parent = o end
    return o
end

local function dragify(frame, dragHandle)
    dragHandle = dragHandle or frame
    local dragging = false
    local dragStart = nil
    local startPos = nil
    local connection = nil

    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            if connection then
                connection:Disconnect()
            end
            
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    if connection then
                        connection:Disconnect()
                        connection = nil
                    end
                end
            end)
        end
    end

    local function onInputChanged(input)
        if dragging and dragStart and startPos then
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                local delta = input.Position - dragStart
                frame.Position = UDim2.new(
                    startPos.X.Scale, startPos.X.Offset + delta.X,
                    startPos.Y.Scale, startPos.Y.Offset + delta.Y
                )
            end
        end
    end

    dragHandle.InputBegan:Connect(onInputBegan)
    UserInputService.InputChanged:Connect(onInputChanged)
end

local function animateGradient(uiGrad)
    task.spawn(function()
        while uiGrad.Parent and uiGrad.Parent.Parent do
            
            TweenService:Create(uiGrad, TweenInfo.new(3, Enum.EasingStyle.Linear), {Rotation = uiGrad.Rotation + 180}):Play()
            
            TweenService:Create(uiGrad, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(0.5, 0)}):Play()
            task.wait(1.5)
            TweenService:Create(uiGrad, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset = Vector2.new(-0.5, 0)}):Play()
            task.wait(1.5)
        end
    end)
end

local function animateBorderGradient(borderGrad)
    task.spawn(function()
        while borderGrad.Parent and borderGrad.Parent.Parent do
            
            TweenService:Create(borderGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 120, 255)),
                    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(255, 0, 150)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 100)),
                    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 200, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(150, 0, 255)),
                }
            }):Play()
            task.wait(2)
            
            TweenService:Create(borderGrad, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 100, 0)),
                    ColorSequenceKeypoint.new(0.25, Color3.fromRGB(0, 255, 200)),
                    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(200, 0, 255)),
                    ColorSequenceKeypoint.new(0.75, Color3.fromRGB(255, 255, 0)),
                    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 120, 255)),
                }
            }):Play()
            task.wait(2)
        end
    end)
end

function Venix.CreateWindow(opts)
    opts = opts or {}
    local titleText = opts.Title or "Venix Library"
    local startPos  = opts.Position or UDim2.fromOffset(40, 120)
    local startSize = opts.Size or UDim2.fromOffset(220, 260)
    -- This Root
    local gui = mk("ScreenGui", {
        Name = "VenixUI",
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Global,
        IgnoreGuiInset = false,
    })
    
    local win = mk("Frame", {
        Name = "Window",
        Parent = gui,
        BackgroundColor3 = Color3.fromRGB(16,16,20),
        Size = startSize,
        Position = startPos,
        BorderSizePixel = 0,
        ZIndex = 2
    }, {
        mk("UICorner", {CornerRadius = UDim.new(0, 20)}),
    })

    local borderStroke = mk("UIStroke", {
        Parent = win,
        Thickness = 3,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Color3.fromRGB(0,120,255),
        Transparency = 0
    })

    local borderGrad = mk("UIGradient", {
        Parent = borderStroke,
        Rotation = 45,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 120, 255)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(255, 0, 150)),
            ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 255, 100)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 200, 0)),
        }
    })
    animateBorderGradient(borderGrad)

    local topbar = mk("Frame", {
        Name = "Topbar",
        Parent = win,
        BackgroundColor3 = Color3.fromRGB(22,22,28),
        Size = UDim2.new(1,0,0,36),
        BorderSizePixel = 0,
        ZIndex = 3
    }, {
        mk("UICorner", {CornerRadius = UDim.new(0, 20)}),
        mk("UIStroke", {Thickness = 2, Color = Color3.fromRGB(50,50,60), Transparency = 0.3}),
        mk("Frame", { -- mask to keep rounded corners crisp ( important ) ( By VantaXock stg )
            BackgroundTransparency = 1, Size = UDim2.new(1,-12,1,-12), Position = UDim2.fromOffset(6,6)
        })
    })

    local title = mk("TextLabel", {
        Name = "Title",
        Parent = topbar,
        BackgroundTransparency = 1,
        Size = UDim2.new(1,-24,1,0),
        Position = UDim2.fromOffset(12,0),
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Text = titleText,
        TextColor3 = Color3.fromRGB(230,235,255),
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 4
    })
    
    local grad = mk("UIGradient", {
        Parent = title,
        Rotation = 0,
        Offset = Vector2.new(-0.5, 0),
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(0, 120, 255)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(10, 10, 14)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 120, 255)),
        }
    })
    animateGradient(grad)

    local content = mk("ScrollingFrame", {
        Name = "Content",
        Parent = win,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Position = UDim2.new(0, 10, 0, 46),
        Size = UDim2.new(1, -20, 1, -56),
        ScrollBarThickness = 4,
        CanvasSize = UDim2.new(0,0,0,0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        ZIndex = 2
    }, {
        mk("UIListLayout", {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 8)
        }),
        mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8)})
    })

    local toggleBtn = mk("TextButton", {
        Name = "ToggleButton",
        Parent = gui,
        Text = "♦",
        Font = Enum.Font.GothamBold,
        TextSize = 24,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(0, 120, 255),
        Size = UDim2.fromOffset(50, 50),
        Position = UDim2.new(1, -70, 0, 20),
        BorderSizePixel = 0,
        ZIndex = 10,
        AutoButtonColor = false
    }, {
        mk("UICorner", {CornerRadius = UDim.new(0, 15)}),
        mk("UIStroke", {
            Thickness = 2,
            Color = Color3.fromRGB(255, 255, 255),
            Transparency = 0.3
        })
    })

    local toggleBorderGrad = mk("UIGradient", {
        Parent = toggleBtn.UIStroke,
        Rotation = 90,
        Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 150)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 200)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 200, 0)),
        }
    })

    dragify(toggleBtn, toggleBtn)

    local uiVisible = true
    toggleBtn.Activated:Connect(function()
        uiVisible = not uiVisible
        local targetPos = uiVisible and startPos or UDim2.new(startPos.X.Scale, startPos.X.Offset, -1, -startSize.Y.Offset)
        TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Position = targetPos
        }):Play()
        
        toggleBtn.Text = uiVisible and "Close" or "Open"
    end)

    dragify(win, topbar)

    local function makeButton(text, callback)
        local btn = mk("TextButton", {
            Parent = content,
            Text = text or "Button",
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(235,238,250),
            AutoButtonColor = false,
            BackgroundColor3 = Color3.fromRGB(26,26,34),
            Size = UDim2.new(1, -6, 0, 32),
            ZIndex = 2
        }, {
            mk("UICorner", {CornerRadius = UDim.new(0, 12)}),
            mk("UIStroke", {Color = Color3.fromRGB(60,60,75), Transparency = 0.35}),
        })

        btn.MouseButton1Down:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.08, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(32,32,42)}):Play()
        end)
        btn.MouseButton1Up:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(26,26,34)}):Play()
        end)

        btn.Activated:Connect(function()
            if typeof(callback) == "function" then
                task.spawn(function()
                    pcall(callback)
                end)
            end
        end)

        return btn
    end

    local function makeToggle(text, default, callback)
        local holder = mk("Frame", {
            Parent = content,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -6, 0, 32),
            ZIndex = 2
        })

        local bg = mk("TextButton", {
            Parent = holder,
            Text = "",
            AutoButtonColor = false,
            BackgroundColor3 = Color3.fromRGB(26,26,34),
            Size = UDim2.new(1, 0, 1, 0),
            ZIndex = 2
        }, {
            mk("UICorner", {CornerRadius = UDim.new(0, 12)}),
            mk("UIStroke", {Color = Color3.fromRGB(60,60,75), Transparency = 0.35}),
        })

        local lbl = mk("TextLabel", {
            Parent = bg,
            BackgroundTransparency = 1,
            Text = text or "Toggle",
            Font = Enum.Font.GothamSemibold,
            TextSize = 14,
            TextColor3 = Color3.fromRGB(235,238,250),
            Size = UDim2.new(1, -58, 1, 0),
            Position = UDim2.fromOffset(12,0),
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 3
        })

        local state = default and true or false
        local knob = mk("Frame", {
            Parent = bg,
            BackgroundColor3 = state and Color3.fromRGB(0,120,255) or Color3.fromRGB(38,38,48),
            Size = UDim2.fromOffset(40, 20),
            Position = UDim2.new(1, -50, 0.5, -10),
            BorderSizePixel = 0,
            ZIndex = 3
        }, {
            mk("UICorner", {CornerRadius = UDim.new(1, 0)}),
        })

        local dot = mk("Frame", {
            Parent = knob,
            BackgroundColor3 = Color3.fromRGB(245,247,255),
            Size = UDim2.fromOffset(14,14),
            Position = state and UDim2.fromOffset(22,3) or UDim2.fromOffset(4,3),
            BorderSizePixel = 0,
            ZIndex = 4
        }, {
            mk("UICorner", {CornerRadius = UDim.new(1,0)})
        })

        local function setState(v, animate)
            state = v and true or false
            local goals = {
                BackgroundColor3 = state and Color3.fromRGB(0,120,255) or Color3.fromRGB(38,38,48),
            }
            local knobTween = TweenService:Create(knob, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), goals)
            local dotTween = TweenService:Create(dot, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
                {Position = state and UDim2.fromOffset(22,3) or UDim2.fromOffset(4,3)})
            if animate then
                knobTween:Play(); dotTween:Play()
            else
                for k,v in pairs(goals) do knob[k] = v end
                dot.Position = state and UDim2.fromOffset(22,3) or UDim2.fromOffset(4,3)
            end
            if typeof(callback) == "function" then
                task.spawn(function()
                    pcall(callback, state)
                end)
            end
        end

        bg.Activated:Connect(function()
            setState(not state, true)
        end)

        setState(state, false)

        return {
            Set = function(_, v) setState(v, true) end,
            Get = function() return state end,
            Label = lbl
        }
    end

    -- This is Public Api for this window!
    local api = {
        _gui = gui,
        _win = win,
        _content = content,
        _toggleBtn = toggleBtn,

        AddButton = function(self, text, callback)
            return makeButton(text, callback)
        end,

        AddToggle = function(self, text, default, callback)
            return makeToggle(text, default, callback)
        end,

        Destroy = function(self)
            gui:Destroy()
        end,

        GetScreenGui = function() return gui end,
        
        ShowHide = function(self)
            uiVisible = not uiVisible
            local targetPos = uiVisible and startPos or UDim2.new(startPos.X.Scale, startPos.X.Offset, -1, -startSize.Y.Offset)
            TweenService:Create(win, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = targetPos
            }):Play()
            toggleBtn.Text = uiVisible and "Close" or "Open"
        end,
    }

    gui.Parent = game:GetService("CoreGui") or game.Players.LocalPlayer:WaitForChild("PlayerGui")
    return setmetatable(api, Venix)
end

return Venix
