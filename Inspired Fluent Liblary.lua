-- fixed this for My Half script 

local function Create(instance, properties, children)
	local obj = Instance.new(instance)

	for i, v in next, properties or {} do
		obj[i] = v
		for _, child in next, children or {} do
			child.Parent = obj;
		end
	end
	return obj;
end
local function textEffect(t, new, d, nd)
	local teng = #t.Text
	for i = 1, teng do
		t.Text = t.Text:sub(1, -i)
		wait(nd)
	end
	wait(d)
	for i = 1, #new do
		t.Text = new:sub(1, i)
		wait(nd)
	end
end

_G.windows = _G.windows or {}
local TabCount = 0
local UiElements = {
	tabdata = {}
}
local flags = {}
local switchDebounce = false
local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Persons = game:GetService("Players")
local kskdsjadsad = 0
local function textEffect(t, new)
	kskdsjadsad = kskdsjadsad + kskdsjadsad
	local sdsadadaw = kskdsjadsad
	local teng = #t.Text
	for i = 1, teng do
		if kskdsjadsad ~= sdsadadaw then t.Text = "" return end
		t.Text = t.Text:sub(1, -i)
		wait(0.01)
	end
	for i = 1, #new do
		if kskdsjadsad ~= sdsadadaw then return end
		t.Text = new:sub(1, i)
		wait(0.01)
	end
end
local guiHover = false

local resizing = false
local Gui = {}
function Gui.Window(name, subt, image, gradient, colortheme, theme2)
		local window_data = {}
		local Main = Create("ScreenGui", {
			Parent = game:GetService("RunService"):IsStudio() and Persons.LocalPlayer.PlayerGui or gethui(),
			ResetOnSpawn = false,
			IgnoreGuiInset = true
		},{
			Create("Frame", {
				Name = "rcmenu",
				BackgroundColor3 = Color3.fromRGB(40, 40, 40),
				Visible = false,
				Size = UDim2.fromOffset(160, 145),
				ZIndex = 5
			},{
				Create("UICorner", {
					CornerRadius = UDim.new(0, 5)
				}),
				Create("UIStroke", {
					Color = colortheme or Color3.fromRGB(172, 163, 236)
				}),
				Create("TextButton", {
					Name = "cat",
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					Size = UDim2.new(1, 0, 0, 30),
					AutoButtonColor = false,
					TextSize = 14,
					Text = "RightClick Menu",
					TextColor3 = Color3.fromRGB(208, 208, 208),
					Font = Enum.Font.SourceSans,
					ZIndex = 5
				},{
					Create("UICorner", {
						CornerRadius = UDim.new(0, 5)
					}),
					Create("Frame", {
						AnchorPoint = Vector2.new(0, 1),
						BackgroundColor3 = Color3.fromRGB(66, 66, 66),
						Position = UDim2.fromScale(0, 1),
						Size = UDim2.new(1, 0, 0, 1),
						BorderSizePixel = 0,
						ZIndex = 5
					})
				}),
				Create("Frame", {
					Name = "_menu_",
					BackgroundColor3 = Color3.fromRGB(42, 42, 42),
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 1, -40),
					ZIndex = 5
				},{
					Create("UICorner", {
						CornerRadius = UDim.new(0, 5)
					}),
					Create("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						Padding = UDim.new(0, 0)
					}),
					Create("TextButton", {
						Name = "min",
						BackgroundColor3 = Color3.fromRGB(46, 46, 46),
						Size = UDim2.new(1, 0, 0, 25),
						AutoButtonColor = false,
						TextSize = 14,
						Text = "Minimize",
						TextColor3 = Color3.fromRGB(208, 208, 208),
						Font = Enum.Font.SourceSans,
						ZIndex = 5
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("Frame", {
							AnchorPoint = Vector2.new(0, 1),
							BackgroundColor3 = Color3.fromRGB(66, 66, 66),
							Position = UDim2.fromScale(0, 1),
							Size = UDim2.new(1, 0, 0, 1),
							BorderSizePixel = 0,
							ZIndex = 5
						})
					}),
					Create("TextButton", {
						Name = "max",
						BackgroundColor3 = Color3.fromRGB(46, 46, 46),
						Size = UDim2.new(1, 0, 0, 25),
						AutoButtonColor = false,
						TextSize = 14,
						Text = "Maximize",
						TextColor3 = Color3.fromRGB(208, 208, 208),
						Font = Enum.Font.SourceSans,
						ZIndex = 5
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("Frame", {
							AnchorPoint = Vector2.new(0, 1),
							BackgroundColor3 = Color3.fromRGB(66, 66, 66),
							Position = UDim2.fromScale(0, 1),
							Size = UDim2.new(1, 0, 0, 1),
							BorderSizePixel = 0,
							ZIndex = 5
						})
					}),
					Create("TextButton", {
						Name = "destroyui",
						BackgroundColor3 = Color3.fromRGB(46, 46, 46),
						Size = UDim2.new(1, 0, 0, 25),
						AutoButtonColor = false,
						TextSize = 14,
						Text = "Destroy GUI",
						TextColor3 = Color3.fromRGB(208, 208, 208),
						Font = Enum.Font.SourceSans,
						ZIndex = 5
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("Frame", {
							AnchorPoint = Vector2.new(0, 1),
							BackgroundColor3 = Color3.fromRGB(66, 66, 66),
							Position = UDim2.fromScale(0, 1),
							Size = UDim2.new(1, 0, 0, 1),
							BorderSizePixel = 0,
							ZIndex = 5
						})
					}),
					Create("TextButton", {
						Name = "refresh",
						BackgroundColor3 = Color3.fromRGB(46, 46, 46),
						Size = UDim2.new(1, 0, 0, 25),
						AutoButtonColor = false,
						TextSize = 14,
						Text = "Refresh Script",
						TextColor3 = Color3.fromRGB(208, 208, 208),
						Font = Enum.Font.SourceSans,
						ZIndex = 5
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("Frame", {
							AnchorPoint = Vector2.new(0, 1),
							BackgroundColor3 = Color3.fromRGB(66, 66, 66),
							Position = UDim2.fromScale(0, 1),
							Size = UDim2.new(1, 0, 0, 1),
							BorderSizePixel = 0,
							ZIndex = 5
						})
					})
				}),
			}),
			Create("Frame", {
				Name = "Main",
				Position = UDim2.fromScale(0, 0),
				Size = UDim2.fromOffset(600, 417),
				BackgroundColor3 = Color3.fromRGB(32, 32, 32),
				Active = true
			},{
				Create("TextButton", {
					Name = "resizer",
					AnchorPoint = Vector2.new(1, 1),
					BackgroundTransparency = 1,
					Position = UDim2.new(1, 5, 1, 5),
					Size = UDim2.fromOffset(17, 17),
					Text = ""
				}),
				Create("UICorner", {
					CornerRadius = UDim.new(0, 9)
				}),
				Create("UIGradient", {
					Rotation = 270,
					Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0, 0), NumberSequenceKeypoint.new(1, 1, 0)}),
					Enabled = gradient
				}),
				Create("UIStroke", {
					Color = Color3.fromRGB(80, 79, 80),
					Transparency = 0.5
				}),
				Create("Frame", {
					BackgroundTransparency = 0.35,
					BackgroundColor3 = Color3.fromRGB(32, 32, 32),
					Size = UDim2.fromScale(1, 1),
					ZIndex = -1
				},{
					Create("UICorner", {
						CornerRadius = UDim.new(0, 9)
					}),
				}),
				Create("Frame", {
					Name = "PageContainer",
					BackgroundTransparency = 1,
					BorderSizePixel = 1,
					Position = UDim2.fromOffset(190, 50),
					Size = UDim2.new(1, -200, 1, -60)
				},{
					Create("TextLabel", {
						Text = "Unknown?",
						BackgroundTransparency = 1,
						BorderSizePixel = 1,
						FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Heavy),
						TextSize = 31,
						TextColor3 = Color3.new(1, 1, 1),
						TextXAlignment = Enum.TextXAlignment.Left,
						Size = UDim2.fromOffset(200, 25)
					})
				}),
				Create("Frame", {
					Name = "MenuContainer",
					AnchorPoint = Vector2.new(0, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 1,
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(0, 180, 1, -48)
				},{
					Create("ScrollingFrame", {
						Name = "MenuContainer",
						BackgroundTransparency = 1,
						BorderSizePixel = 1,
						Size = UDim2.new(1, 0, 1, -18),
						ScrollingDirection = Enum.ScrollingDirection.Y,
						ScrollBarThickness = 0,
						AutomaticCanvasSize = Enum.AutomaticSize.Y,
						CanvasSize = UDim2.fromScale(0, 0)
					},{
						Create("UIListLayout", {
							HorizontalAlignment = Enum.HorizontalAlignment.Center,
							Padding = UDim.new(0, 4)
						})
					})	
				}),
				Create("Frame", {
					Name = "Top",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 38)
				},{
					Create("Frame", {
						AnchorPoint = Vector2.new(0, 1),
						Position = UDim2.fromScale(0, 1),
						Size = UDim2.new(1, 0, 0, 1),
						BackgroundTransparency = 0.5,
						BackgroundColor3 = Color3.fromRGB(80, 79, 80),
						BorderSizePixel = 0
					}),
					Create("TextLabel", {
						RichText = true,
						Text = `{name or "Window"}  <font transparency = "0.4">{subt or ""}</font>`,
						FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
						TextSize = 12,
						BackgroundTransparency = 1,
						TextColor3 = Color3.new(1, 1, 1),
						Position = UDim2.fromOffset(30, 0),
						Size = UDim2.new(1, -45, 1, 0),
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					Create("ImageLabel", {
						Image = image or "rbxassetid://121329629799144",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 8, 0.5, 0),
						Size = UDim2.fromOffset(16, 16),
						ImageColor3 = Color3.new(1, 1, 1)
					}),
					Create("ImageButton", {
						Name = "Exit",
						Image = "rbxassetid://9886659671",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -28, 0.5, 0),
						Size = UDim2.fromOffset(17, 17),
						ImageColor3 = Color3.new(1, 1, 1)
					}),
					Create("ImageButton", {
						Name = "Maximize",
						Image = "rbxassetid://9886659406",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -55, 0.5, 0),
						Size = UDim2.fromOffset(17, 17),
						ImageColor3 = Color3.fromRGB(177, 177, 177)
					}),
					Create("ImageButton", {
						Name = "Minimize",
						Image = "rbxassetid://9886659276",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(1, -85, 0.5, 1),
						Size = UDim2.fromOffset(24, 24),
						ImageColor3 = Color3.new(1, 1, 1)
					})
				})
			})
		});

		-- buttons
		local rc = Main.rcmenu
		local top = Main.Main.Top
		do
			local function destroyUI()
				flags = {}
				Main:Destroy()
			end
			local function minimize()
				rc.Visible = false
				Main.Main.Visible = false
			end
			rc._menu_.min.Activated:Connect(minimize)
			rc._menu_.destroyui.Activated:Connect(destroyUI)
			rc._menu_.refresh.Activated:Connect(function()

			end)
			top.Exit.Activated:Connect(destroyUI)
			top.Minimize.Activated:Connect(minimize)
		end

		Main.Main.MouseEnter:Connect(function() guiHover = true end)
		Main.Main.MouseLeave:Connect(function() guiHover = false end)
		Main.Main.resizer.MouseButton1Down:Connect(function()
			resizing = true
			while resizing do
				local mouse = Persons.LocalPlayer:GetMouse()
				local x = math.clamp(mouse.X - Main.Main.AbsolutePosition.X, 490, math.huge)
				local y = math.clamp(mouse.Y - Main.Main.AbsolutePosition.Y, 302, math.huge)
				Main.Main.Size = UDim2.new(0, x, 0, y)
				task.wait()
			end
		end)
		UIS.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.LeftAlt then
				Main.Main.Visible = not Main.Main.Visible
				rc.Visible = false
			end
		end)
		UIS.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = false
			end
		end)
		UIS.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton2 and guiHover then
				local mouse = Persons.LocalPlayer:GetMouse()
				local rc = Main.rcmenu
				rc.Visible = true
				rc.Position = UDim2.new(0, mouse.X, 0, mouse.Y + 58)
			end
		end)

		table.insert(_G.windows, Main)
		local Drag = (function(Frame)
			local rc = Main.rcmenu
			local dragToggle = nil
			local dragSpeed = 0.02
			local dragInput = nil
			local dragStart = nil
			local dragPos = nil
			local startPos
			local Delta
			local Position

			local function updateInput(input)
				Delta = input.Position - dragStart
				Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
				game:GetService("TweenService"):Create(Frame, TweenInfo.new(dragSpeed), {Position = Position}):Play()
			end
			Frame.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
					rc.Visible = false
					for _, window in next, _G.windows  do
						if window ~= Main then
							window.DisplayOrder = 0
						else
							window.DisplayOrder = 1
						end
					end
					dragToggle = true
					dragStart = input.Position
					startPos = Frame.Position
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragToggle = false
						end
					end)
				end
			end)
			Frame.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if input == dragInput and dragToggle then
					updateInput(input)
					rc.Visible = false
				end
			end)
		end)(Main.Main)

		function window_data:Tab(name, image)
			local tabdata = {}
			local tab_data = {} -- they're different
			local Page = Create("Frame", {
				BackgroundTransparency = 1,
				BorderSizePixel = 1,
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 1, -35),
				ClipsDescendants = true,
				Parent = Main.Main.PageContainer,
				Visible = false
			},{
				Create("ScrollingFrame", {
					Name = "Container",
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					BackgroundTransparency = 1,
					BorderSizePixel = 1,
					Size = UDim2.new(1, -2, 1, -2),
					--AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ScrollBarThickness = 0,
					CanvasSize = UDim2.fromScale(0, 0),
					ClipsDescendants = false
				},{
					Create("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Center,
						SortOrder = Enum.SortOrder.Name,
						Padding = UDim.new(0, 7)
					})
				})
			})
			local ButtonTab = Create("Frame", {
				BackgroundColor3 = Color3.fromRGB(66, 66, 66),
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(160, 33),
				Parent = Main.Main.MenuContainer.MenuContainer
			},{
				Create("TextButton", {
					Name = "ButtonHitbox",
					BackgroundTransparency = 1,
					Text = "",
					Size = UDim2.fromScale(1, 1),
				}),
				Create("UICorner", {
					CornerRadius = UDim.new(0, 8),
				}),
				Create("Frame", {
					Name = "Indicator",
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromOffset(4, 0),
					BackgroundColor3 = colortheme or Color3.fromRGB(172, 163, 236),
					BackgroundTransparency = 1
				},{
					Create("UICorner", {
						CornerRadius = UDim.new(0, 2)
					})
				}),
				Create("TextLabel", {
					Text = name or "Tab",
					AnchorPoint = Vector2.new(1, 0),
					BackgroundTransparency = 1,
					Position = UDim2.fromScale(1, 0),
					Size = UDim2.new(1, -32, 1, 0),
					TextColor3 = Color3.fromRGB(238, 238, 238),
					TextXAlignment = Enum.TextXAlignment.Left,
					FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
					TextSize = 14
				}),
				Create("ImageLabel", {
					Name = "Icon",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, 0),
					Size = UDim2.fromOffset(16, 16),
					ImageColor3 = Color3.fromRGB(199, 199, 199),
					Image = image or "",
				})
			})

			local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Sine)
			local function UnselectOther(v,e)
				if(e=="b")then
					TS:Create(v.Indicator, tweeninfo, {Size = UDim2.fromOffset(4, 4)}):Play()
					TS:Create(v.Indicator, tweeninfo, {BackgroundTransparency = 1}):Play()
					TS:Create(v.Icon, tweeninfo, {ImageColor3 = Color3.fromRGB(199, 199, 199)}):Play()
					TS:Create(v.TextLabel, tweeninfo, {TextColor3 = Color3.fromRGB(238, 238, 238)}):Play()
					TS:Create(v, tweeninfo, {BackgroundTransparency = 1}):Play()
				else
					v.Visible = false
				end
			end

			local function SelectTab()
				--if (switchDebounce == true) then return; end -- removed it
				switchDebounce = true
				TS:Create(ButtonTab.Indicator, tweeninfo, {Size = UDim2.fromOffset(4, 23)}):Play()
				TS:Create(ButtonTab.Indicator, tweeninfo, {BackgroundTransparency = 0}):Play()
				TS:Create(ButtonTab.Icon, tweeninfo, {ImageColor3 = colortheme or Color3.fromRGB(172, 163, 236)}):Play()
				TS:Create(ButtonTab.TextLabel, tweeninfo, {TextColor3 = colortheme or Color3.fromRGB(172, 163, 236)}):Play()
				TS:Create(ButtonTab, tweeninfo, {BackgroundTransparency = 0.6}):Play()

				-- ef
				for i, v in next, Main.Main.MenuContainer.MenuContainer:GetChildren() do
					if (v == ButtonTab) or (not v:IsA("Frame")) then continue; end
					UnselectOther(v,"b")
				end
				for i, v in next, Main.Main.PageContainer:GetChildren() do
					if (v == Page) or (not v:IsA("Frame")) then continue; end
					UnselectOther(v)
				end

				Page.Visible = true
				textEffect(Main.Main.PageContainer.TextLabel, name or "Tab")
				switchDebounce = false
			end

			local FirstTab = (TabCount == 0)
			if (FirstTab) then
				SelectTab()
			end

			-- finishing touches
			ButtonTab.ButtonHitbox.Activated:Connect(SelectTab)
			TabCount = TabCount + 1

			local function pageUpdateSize(nc, pd)
				local normSize, padding = nc, pd
				local y = normSize + padding
				Page.Container.CanvasSize += UDim2.fromOffset(0, y)
			end

			local secs = 0
			function tab_data:AddSection(name)
				local section_data = {o = 0}
				secs = secs + 1
				local secs = secs
				pageUpdateSize(25, 7)
				Create("Frame", {
					Name = secs,
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 0, 25),
					Parent = Page.Container
				},{
					Create("TextLabel", {
						Name = secs,
						Text = name,
						BackgroundTransparency = 1,
						FontFace = Font.new("rbxasset://fonts/families/Arimo.json", Enum.FontWeight.Heavy),
						TextSize = 21,
						TextColor3 = Color3.new(1, 1, 1),
						TextXAlignment = Enum.TextXAlignment.Left,
						Size = UDim2.fromScale(1, 1),
					})
				})
				
				function section_data.Toggle(name, callback, def)
					section_data:AddToggle(name, name, callback, def)
				end
				function section_data.Button(name, callback)
					section_data:AddButton(name, callback)
				end
				function section_data.Slider(name, def, min, max, callback)
					section_data:AddSlider(name, name, min, max, def, callback)
				end

				function section_data:AddButton(name, cback)
					pageUpdateSize(39, 7)
					section_data.o = section_data.o + 1
					local Button = Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(75, 75, 75),
						BackgroundTransparency = 0.75,
						Size = UDim2.new(1, 0, 0, 39),
						Parent = Page.Container,
						Name = secs
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIStroke", {
							Color = Color3.fromRGB(52, 52, 52),
							Transparency = 0.76
						}),
						Create("TextButton", {
							Name = "ButtonHitbox",
							BackgroundTransparency = 1,
							Text = "",
							Size = UDim2.fromScale(1, 1),
						}),
						Create("ImageLabel", {
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							ImageColor3 = Color3.new(1, 1, 1),
							Size = UDim2.fromOffset(21, 21),
							Position = UDim2.new(1, -31, 0.5, 0),
							BorderSizePixel = 0,
							Image = "rbxassetid://101414353919959",
							Rotation = 180
						}),
						Create("TextLabel", {
							Text = name or "Button",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, -10, 1, 10),
							Position = UDim2.new(0, 10, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14
						})
					})

					Button.ButtonHitbox.Activated:Connect(cback)
				end

				function section_data:AddToggle(id, name, cback, def)
					pageUpdateSize(39, 7)
					section_data.o = section_data.o + 1
					flags[id] = {Value = false}
					local Button = Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(75, 75, 75),
						BackgroundTransparency = 0.75,
						Size = UDim2.new(1, 0, 0, 39),
						Parent = Page.Container,
						Name = secs
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIStroke", {
							Color = Color3.fromRGB(52, 52, 52),
							Transparency = 0.76
						}),
						Create("TextButton", {
							Name = "ButtonHitbox",
							BackgroundTransparency = 1,
							Text = "",
							Size = UDim2.fromScale(1, 1),
						}),
						Create("TextLabel", {
							Text = name or "Tog",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, -10, 1, 10),
							Position = UDim2.new(0, 10, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14
						}),
						Create("Frame", {
							Name = "indic",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BackgroundColor3 = colortheme or Color3.fromRGB(172, 163, 236),
							Position = UDim2.new(1, -52, 0.5, 0),
							Size = UDim2.fromOffset(44, 22)
						},{
							Create("UIStroke", {
								Color = Color3.fromRGB(111, 106, 107)
							}),
							Create("UICorner", {
								CornerRadius = UDim.new(1, 0)
							}),
							Create("Frame", {
								Name = "baww",
								AnchorPoint = Vector2.new(0, 0.5),
								Position = UDim2.new(0, 4, 0.5, 0),
								Size = UDim2.fromOffset(14, 14)
							},{
								Create("UICorner", {
									CornerRadius = UDim.new(1, 0)
								}),
							})
						})
					})

					local enabled = false;
					local bhover = false;

					local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Exponential)
					local function onClick()
						enabled = not enabled
						flags[id] = enabled
						if enabled then
							TS:Create(Button.indic, tweeninfo, {BackgroundTransparency = 0}):Play()
							TS:Create(Button.indic.baww, tweeninfo, {Position = UDim2.new(1, -18, 0.5, 0)}):Play()
							TS:Create(Button.indic.baww, tweeninfo, {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}):Play()
							TS:Create(Button.indic.UIStroke, tweeninfo, {Transparency = 1}):Play()
						else
							TS:Create(Button.indic, tweeninfo, {BackgroundTransparency = 1}):Play()
							TS:Create(Button.indic.baww, tweeninfo, {Position = UDim2.new(0, 4, 0.5, 0)}):Play()
							TS:Create(Button.indic.baww, tweeninfo, {BackgroundColor3 = Color3.fromRGB(111, 106, 107)}):Play()
							TS:Create(Button.indic.UIStroke, tweeninfo, {Transparency = 0}):Play()
						end
						cback(enabled)
					end

					local function onHover()
						bhover = not bhover
						if bhover then
							TS:Create(Button.indic.baww, tweeninfo, {Size = UDim2.fromOffset(16, 16)}):Play()
						else
							TS:Create(Button.indic.baww, tweeninfo, {Size = UDim2.fromOffset(14, 14)}):Play()
						end
					end

					Button.indic.MouseEnter:Connect(onHover)
					Button.indic.MouseLeave:Connect(onHover)
					Button.ButtonHitbox.Activated:Connect(onClick)

					if def == true then onClick() end
				end

				function section_data:AddDropdown(id, name, array, cback)
					pageUpdateSize(39, 7)
					section_data.o = section_data.o + 1
					flags[id] = {S = name, Refresh = function() end}
					local Button = Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(75, 75, 75),
						BackgroundTransparency = 0.75,
						Size = UDim2.new(1, 0, 0, 39),
						Parent = Page.Container,
						Name = secs
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIStroke", {
							Color = Color3.fromRGB(52, 52, 52),
							Transparency = 0.76
						}),
						Create("TextLabel", {
							Text = name or "Dropdown",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, -10, 1, 10),
							Position = UDim2.new(0, 10, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14
						}),
						Create("Frame", {
							Name = "ThingyIDK",
							AnchorPoint = Vector2.new(1, 0),
							Position = UDim2.new(1, -6, 0, 5),
							Size = UDim2.fromOffset(120, 27),
							BackgroundColor3 = Color3.fromRGB(67, 67, 67),
							BackgroundTransparency = 0,
							ZIndex = 2
						},{
							Create("TextButton", {
								Name = "ButtonHitbox",
								Text = "",
								BackgroundTransparency = 1,
								Size = UDim2.new(1, 0, 0, 27),
								ZIndex = 3
							}),
							Create("UICorner", {
								CornerRadius = UDim.new(0, 8)
							}),
							Create("UIStroke", {
								Color = Color3.fromRGB(255, 255, 255),
								Transparency = 0.76
							}),
							Create("TextLabel", {
								Text = "---",
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Size = UDim2.fromOffset(97, 27),
								Position = UDim2.fromOffset(5, 0),
								TextColor3 = Color3.fromRGB(179, 179, 179),
								TextXAlignment = Enum.TextXAlignment.Left,
								TextSize = 8,
								ZIndex = 3,
								ClipsDescendants = true
							}),
							Create("ImageLabel", {
								Name = "icon",
								AnchorPoint = Vector2.new(1, 0),
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Position = UDim2.new(1, -2, 0, 4),
								Size = UDim2.fromOffset(19, 19),
								ImageColor3 = Color3.new(1, 1, 1),
								Image = "rbxassetid://93580597565423",
								ZIndex = 3
							}),
							Create("ScrollingFrame", {
								Name = "container",
								AnchorPoint = Vector2.new(0, 1),
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								Position = UDim2.new(0, 0, 1, -2),
								Size = UDim2.new(1, 0, 1, -31),
								AutomaticCanvasSize = Enum.AutomaticSize.Y,
								CanvasSize = UDim2.fromScale(0, 0),
								ScrollingDirection = Enum.ScrollingDirection.Y,
								ScrollBarThickness = 0,
								ZIndex = 3
							},{
								Create("UIListLayout", {
									Padding = UDim.new(0, 3),
									HorizontalAlignment = Enum.HorizontalAlignment.Center
								})
							})
						})
					})
					local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine)
					local open = false
					local function update(open1)
						if open1 == true then
							local y = 27 + (#array * (28 + 3))
							y = math.clamp(y, 27, 178)
							TS:Create(Button.ThingyIDK, tweeninfo, {Size = UDim2.fromOffset(120, y)}):Play()
							TS:Create(Button.ThingyIDK.icon, tweeninfo, {Rotation = 180}):Play()
							pageUpdateSize(y, 0)
						else
							local y = 27 + (#array * (28 + 3))
							y = math.clamp(y, 27, 178)
							TS:Create(Button.ThingyIDK, tweeninfo, {Size = UDim2.fromOffset(120, 27)}):Play()
							TS:Create(Button.ThingyIDK.icon, tweeninfo, {Rotation = 0}):Play()
							pageUpdateSize(-y, 0)
						end
					end
					local function onClick()
						open = not open
						update(open)
					end

					local nahObject = nil
					flags[id].Refresh = function(newarray, f)
						for i, v in next, Button.ThingyIDK.container:GetChildren() do
							if v.Name == "__ITEM__" then
								v:Destroy()
							end
						end
						for i, v in next, newarray do
							local object = Create("TextButton", {
								Name = "__ITEM__",
								Parent = Button.ThingyIDK.container,
								BackgroundColor3 = Color3.fromRGB(99, 99, 99),
								AnchorPoint = Vector2.new(0.5, 0),
								AutoButtonColor = false,
								Size = UDim2.new(1, -10, 0, 28),
								FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json"),
								Text = tostring(v),
								TextColor3 = Color3.new(1, 1, 1),
								TextSize = 14,
								BackgroundTransparency = 1,
								ZIndex = 3,
								ClipsDescendants = true
							},{
								Create("UICorner", {
									CornerRadius = UDim.new(0, 8)
								}),
								Create("Frame", {
									Name = "Indicator",
									AnchorPoint = Vector2.new(0, 0.5),
									Position = UDim2.fromScale(0, 0.5),
									Size = UDim2.fromOffset(4, 0),
									BackgroundColor3 = colortheme or Color3.fromRGB(172, 163, 236),
									BackgroundTransparency = 0,
									ZIndex = 4
								},{
									Create("UICorner", {
										CornerRadius = UDim.new(0, 2)
									})
								}),
							})

							object.MouseEnter:Connect(function()
								if nahObject == object then return; end
								TS:Create(object, tweeninfo, {BackgroundTransparency = 0.5}):Play()
							end)
							object.MouseLeave:Connect(function()
								if nahObject == object then return; end
								TS:Create(object, tweeninfo, {BackgroundTransparency = 1}):Play()
							end)
							object.Activated:Connect(function()
								for ii, x in next, object.Parent:GetChildren() do
									if x.Name == "__ITEM__" then
										TS:Create(x.Indicator, tweeninfo, {Size = UDim2.fromOffset(4, 0)}):Play()
										TS:Create(x.Indicator, tweeninfo, {BackgroundTransparency = 1}):Play()
										TS:Create(x, tweeninfo, {BackgroundTransparency = 1}):Play()
									end
								end
								TS:Create(object.Indicator, tweeninfo, {Size = UDim2.fromOffset(4, 19)}):Play()
								TS:Create(object.Indicator, tweeninfo, {BackgroundTransparency = 0}):Play()
								TS:Create(object, tweeninfo, {BackgroundTransparency = 0}):Play()
								nahObject = object
								Button.ThingyIDK.TextLabel.Text = tostring(v)
								flags[id].S = v
								cback(v)

							end)
						end
						if(f)then update()end
					end

					-- finishing touches
					flags[id].Refresh(array, false)
					Button.ThingyIDK.ButtonHitbox.Activated:Connect(onClick)
				end

				function section_data:AddSlider(id, name, min, max, def, cback)
					flags[id] = {Value = def}
					pageUpdateSize(39, 7)
					section_data.o = section_data.o + 1
					local Button = Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(75, 75, 75),
						BackgroundTransparency = 0.75,
						Size = UDim2.new(1, 0, 0, 39),
						Parent = Page.Container,
						Name = secs
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIStroke", {
							Color = Color3.fromRGB(52, 52, 52),
							Transparency = 0.76
						}),
						Create("TextButton", {
							Name = "ButtonHitbox",
							BackgroundTransparency = 1,
							Text = "",
							Size = UDim2.fromScale(1, 1),
						}),
						Create("TextLabel", {
							Text = name or "Slip and.. you get the idea",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, -10, 1, 10),
							Position = UDim2.new(0, 10, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14
						}),
						Create("TextLabel", {
							Name = "uhhit",
							Text = `{def}/<font color="rgb(111,111,111)">{max}</font>`,
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(0, 199, 1, 10),
							Position = UDim2.new(1, -391, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Right,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14,
							RichText = true
						}),
						Create("Frame", {
							Name = "In",
							AnchorPoint = Vector2.new(1, 0),
							BackgroundTransparency = 1,
							Position = UDim2.new(1, -10, 0, 5),
							Size = UDim2.fromOffset(171, 27)
						},{
							Create("Frame", {
								AnchorPoint = Vector2.new(0, 0.5),
								BackgroundColor3 = Color3.fromRGB(155, 155, 155),
								BorderSizePixel = 0,
								Position = UDim2.fromScale(0, 0.5),
								Size = UDim2.new(1, 0, 0, 4)
							},{
								Create("UICorner", {
									CornerRadius = UDim.new(1, 0)
								}),
								Create("Frame", {
									BackgroundColor3 = colortheme or Color3.fromRGB(172, 163, 236),
									BorderSizePixel = 0,
									Size = UDim2.fromScale(0, 1)
								},{
									Create("UICorner", {
										CornerRadius = UDim.new(1, 0)
									})
								}),
								Create("TextButton", {
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundColor3 = Color3.fromRGB(69, 69, 69),
									Position = UDim2.fromScale(0, 0.5),
									Size = UDim2.fromOffset(16, 16),
									Text = "",
									AutoButtonColor = false
								},{
									Create("UICorner", {
										CornerRadius = UDim.new(1, 0)
									}),
									Create("TextButton", {
										AnchorPoint = Vector2.new(0.5, 0.5),
										BackgroundColor3 = colortheme or Color3.fromRGB(172, 163, 236),
										Position = UDim2.fromScale(0.5, 0.5),
										Size = UDim2.new(1, -6, 1, -6),
										Text = "",
										AutoButtonColor = false
									},{
										Create("UICorner", {
											CornerRadius = UDim.new(1, 0)
										})
									})
								})
							})
						})
					})
					local dragging = false
					local inner = Button.In.Frame
					local press, ind = inner.TextButton, inner.Frame
					local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Sine)

					-- defauIt
					local measure = math.clamp(def / max, 0, 1)
					press.Position = UDim2.fromScale(measure, 0.5)
					inner.Frame.Size = UDim2.fromScale(measure, 1)
					-- end
					press.TextButton.MouseButton1Down:Connect(function()
						TS:Create(press.TextButton, tweeninfo, {Size = UDim2.new(1, -10, 1, -10)}):Play()
						dragging = true
						while dragging do
							local measure = math.clamp((Persons.LocalPlayer:GetMouse().X - Button.In.AbsolutePosition.X) / Button.In.AbsoluteSize.X, 0, 1)
							press.Position = UDim2.fromScale(measure, 0.5)
							inner.Frame.Size = UDim2.fromScale(measure, 1)
							local finva = math.round(min + (measure * (max - min)))
							flags[id].Value = finva
							Button.uhhit.Text = `{finva}/<font color="rgb(111,111,111)">{max}</font>`
							task.spawn(cback, finva)
							task.wait()
						end
					end)
					UIS.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							TS:Create(press.TextButton, tweeninfo, {Size = UDim2.new(1, -6, 1, -6)}):Play()
							dragging = false
						end
					end)
				end

				function section_data:AddTextbox(id, name, ph, cback)
					flags[id] = {Text = ""}
					pageUpdateSize(39, 7)
					section_data.o = section_data.o + 1
					local Button = Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(75, 75, 75),
						BackgroundTransparency = 0.75,
						Size = UDim2.new(1, 0, 0, 39),
						Parent = Page.Container,
						Name = secs
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIStroke", {
							Color = Color3.fromRGB(52, 52, 52),
							Transparency = 0.76
						}),
						Create("TextButton", {
							Name = "ButtonHitbox",
							BackgroundTransparency = 1,
							Text = "",
							Size = UDim2.fromScale(1, 1),
						}),
						Create("TextLabel", {
							Text = name or "Enter something",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, -10, 1, 10),
							Position = UDim2.new(0, 10, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14
						}),
						Create("Frame", {
							Name = "In",
							AnchorPoint = Vector2.new(1, 0),
							BackgroundTransparency = 0,
							Position = UDim2.new(1, -10, 0, 5),
							Size = UDim2.fromOffset(171, 27),
							BackgroundColor3 = Color3.fromRGB(55, 55, 55),
						},{
							Create("UICorner", {
								CornerRadius = UDim.new(0, 5)
							}),
							Create("Frame", {
								Name = "indic",
								AnchorPoint = Vector2.new(0.5, 1),
								BackgroundColor3 = Color3.fromRGB(99, 99, 99),
								Position = UDim2.fromScale(0.5, 1),
								Size = UDim2.new(1, 0, 0, 1),
							},{
								Create("UICorner", {
									CornerRadius = UDim.new(0, 5)
								}),
							}),
							Create("TextBox", {
								AnchorPoint = Vector2.new(1, 0.5),
								BackgroundTransparency = 1,
								BackgroundColor3 = Color3.new(1, 1, 1),
								ClearTextOnFocus = false,
								Position = UDim2.fromScale(1, 0.5),
								Size = UDim2.new(1, -7, 1, 10),
								PlaceholderText = ph,
								Text = "",
								TextColor3 = Color3.new(1, 1, 1),
								TextSize = 8,
								TextXAlignment = Enum.TextXAlignment.Left,
								ClipsDescendants = true
							})
						})
					})

					local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
					local Box = Button.In.TextBox
					local indic = Button.In.indic
					Box.FocusLost:Connect(function()
						indic.Size = UDim2.new(1, 0, 0, 1)
						TS:Create(indic, tweeninfo, {BackgroundColor3 = Color3.fromRGB(99, 99, 99)}):Play()
						flags[id].Text = Box.Text
						cback(flags[id].Text)
					end)
					Box.Focused:Connect(function()
						indic.Size = UDim2.new(1, 0, 0, 2)
						TS:Create(indic, tweeninfo, {BackgroundColor3 = colortheme or Color3.fromRGB(172, 163, 236)}):Play()
					end)
				end

				function section_data:AddChooser(id, name, increment, min, max, def, func) -- 7 arguments is the record, sliders at 6 args
					flags[id] = {Number = def}
					pageUpdateSize(39, 7)
					section_data.o = section_data.o + 1
					local Button = Create("Frame", {
						BackgroundColor3 = Color3.fromRGB(75, 75, 75),
						BackgroundTransparency = 0.75,
						Size = UDim2.new(1, 0, 0, 39),
						Parent = Page.Container,
						Name = secs
					},{
						Create("UICorner", {
							CornerRadius = UDim.new(0, 5)
						}),
						Create("UIStroke", {
							Color = Color3.fromRGB(52, 52, 52),
							Transparency = 0.76
						}),
						Create("TextButton", {
							Name = "ButtonHitbox",
							BackgroundTransparency = 1,
							Text = "",
							Size = UDim2.fromScale(1, 1),
						}),
						Create("TextLabel", {
							Text = name or "Add stuff, remove stuff.",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(1, -10, 1, 10),
							Position = UDim2.new(0, 10, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14
						}),
						Create("TextLabel", {
							Name = "uhhit",
							Text = `{def}/<font color="rgb(111,111,111)">{max}</font>`,
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(0, 199, 1, 10),
							Position = UDim2.new(1, -264, 0.5, 0),
							TextColor3 = Color3.new(1, 1, 1),
							TextXAlignment = Enum.TextXAlignment.Right,
							FontFace = Font.new("rbxasset://fonts/families/Arimo.json"),
							TextSize = 14,
							RichText = true
						}),
						Create("Frame", {
							Name = "In",
							AnchorPoint = Vector2.new(1, 0),
							BackgroundTransparency = 1,
							Position = UDim2.new(1, -10, 0, 5),
							Size = UDim2.fromOffset(61, 27),
							BackgroundColor3 = Color3.fromRGB(55, 55, 55),
						},{
							Create("Frame", {
								Name = "add",
								AnchorPoint = Vector2.new(1, 0),
								BackgroundColor3 = Color3.fromRGB(58, 58, 58),
								Position = UDim2.fromScale(1, 0),
								Size = UDim2.fromOffset(26, 26),
								BackgroundTransparency = 1
							},{
								Create("UICorner", {
									CornerRadius = UDim.new(0, 5)
								}),
								Create("ImageButton", {
									Name = "add",
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundTransparency = 1,
									Position = UDim2.fromScale(0.5, 0.5),
									Size = UDim2.new(1, -5, 1, -5),
									Image = "rbxassetid://112749609373188",
									ImageColor3 = Color3.new(1, 1, 1),
								})
							}),
							Create("Frame", {
								Name = "subtract",
								AnchorPoint = Vector2.new(1, 0),
								BackgroundColor3 = Color3.fromRGB(58, 58, 58),
								Position = UDim2.new(1, -23, 0, 0),
								Size = UDim2.fromOffset(26, 26),
								BackgroundTransparency = 1
							},{
								Create("UICorner", {
									CornerRadius = UDim.new(0, 5)
								}),
								Create("ImageButton", {
									Name = "subtract",
									AnchorPoint = Vector2.new(0.5, 0.5),
									BackgroundTransparency = 1,
									Position = UDim2.fromScale(0.5, 0.5),
									Size = UDim2.new(1, -5, 1, -5),
									Image = "rbxassetid://79371470375113",
									ImageColor3 = Color3.new(1, 1, 1),
								})
							})
						})
					})

					local tweeninfo = TweenInfo.new(0.1, Enum.EasingStyle.Linear)
					local inner = Button.In
					local add, sub = inner.add, inner.subtract
					-- add
					add.add.MouseEnter:Connect(function() TS:Create(add, tweeninfo, {BackgroundTransparency = 0}):Play() end)
					add.add.MouseLeave:Connect(function() TS:Create(add, tweeninfo, {BackgroundTransparency = 1}):Play() end)
					-- sub
					sub.subtract.MouseEnter:Connect(function() TS:Create(sub, tweeninfo, {BackgroundTransparency = 0}):Play() end)
					sub.subtract.MouseLeave:Connect(function() TS:Create(sub, tweeninfo, {BackgroundTransparency = 1}):Play() end)

					--[[local function clamp2(num, min, max, e)
					end]]
					-- main funcs
					local number;
					add.add.Activated:Connect(function()
						number = flags[id].Number
						number = math.clamp(number + increment, min, max)
						flags[id].Number = number
						Button.uhhit.Text = `{number}/<font color="rgb(111,111,111)">{max}</font>`
						func(number)
					end)
					sub.subtract.Activated:Connect(function()
						number = flags[id].Number
						number = math.clamp(number - increment, min, max)
						flags[id].Number = number
						Button.uhhit.Text = `{number}/<font color="rgb(111,111,111)">{max}</font>`
						func(number)
					end)
				end
				return section_data
			end

			return tab_data
		end

		return window_data;
end
Flags = flags

return Gui
