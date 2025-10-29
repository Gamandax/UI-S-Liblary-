-- // Zen Library \\ --

local library = {flags = {}, windows = {}, open = true, count = 0}

--Services
local runService = game:GetService"RunService"
local textService = game:GetService"TextService"
local inputService = game:GetService"UserInputService"
local ui = Enum.UserInputType.MouseButton1

--Functions
local function safeDestroy(obj)
	if obj and obj.Parent then
		pcall(function() obj:Destroy() end)
	end
end

function library:Create(class, properties)
	properties = typeof(properties) == "table" and properties or {}
	local inst = Instance.new(class)
	for property, value in next, properties do
		inst[property] = value
	end
	return inst
end

local function createButton(option, parent)
	local ButtonHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "ButtonHolder",
		Size = UDim2.new(1, 0, 0, 37), 
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local Button = library:Create("TextButton", {
		Name = "Button",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.03, 0, 0.081, 0),
		Size = UDim2.new(0, 190, 0, 30),
		ZIndex = 4,
		Font = Enum.Font.SourceSans,
		Text = option.text or "Button",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 22,
		TextWrapped = true,
		ClipsDescendants = true,
		Parent = ButtonHolder
	})

	local Round = library:Create("ImageLabel", {
		Name = "Button_Roundify_5px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(45, 45, 45),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.050,
		Parent = Button
	})

	Button.MouseButton1Click:Connect(function()
		library.flags[option.flag] = true
		if option.callback then pcall(option.callback) end
	end)

	parent:Resize()
end

local function createKeybind(option, parent)
	local KeybindHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "KeybindHolder",
		Size = UDim2.new(1, 0, 0, 37),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local KeybindText = library:Create("TextLabel", {
		Name = "KeybindText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.04, 0, 0.162, 0),
		Size = UDim2.new(0, 94, 0, 23),
		ZIndex = 3,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.1,
		Text = option.text or "Keybind",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = KeybindHolder
	})

	local KeybindBox = library:Create("TextButton", {
		Name = "KeybindBox",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.54, 0, 0.243, 0),
		Size = UDim2.new(0, 85, 0, 23),
		ZIndex = 4,
		Font = Enum.Font.SourceSansSemibold,
		LineHeight = 1.5,
		Text = option.key and option.key.Name or "None",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 14,
		Parent = KeybindHolder
	})

	local Round = library:Create("ImageLabel", {
		Name = "Keybind_Roundify_4px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.386, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1.045, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(43, 43, 43),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = KeybindBox
	})

	local listening = false
	local currentKey = option.key or Enum.KeyCode.F

	-- Store the keybind in library flags
	library.flags[option.flag] = currentKey

	KeybindBox.MouseButton1Click:Connect(function()
		if listening then return end
		listening = true
		KeybindBox.Text = "..."
		KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 0)
		
		local connection
		connection = inputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			
			if input.UserInputType == Enum.UserInputType.Keyboard then
				connection:Disconnect()
				listening = false
				currentKey = input.KeyCode
				library.flags[option.flag] = currentKey
				KeybindBox.Text = input.KeyCode.Name
				KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				
				if option.callback then
					pcall(option.callback, input.KeyCode)
				end
			end
		end)
	end)

	-- Listen for the keybind activation
	inputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
			if option.mode == "toggle" then
				library.flags[option.flag .. "_active"] = not library.flags[option.flag .. "_active"]
			else
				library.flags[option.flag .. "_active"] = true
			end
			
			if option.callback then
				pcall(option.callback, library.flags[option.flag .. "_active"])
			end
		end
	end)

	if option.mode ~= "toggle" then
		inputService.InputEnded:Connect(function(input, gameProcessed)
			if gameProcessed then return end
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
				library.flags[option.flag .. "_active"] = false
				if option.callback then
					pcall(option.callback, false)
				end
			end
		end)
	end

	parent:Resize()
end

local function createDropdown(option, parent)
	local DropdownHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "DropdownHolder",
		Size = UDim2.new(1, 0, 0, 37),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local DropdownFrame = library:Create("TextButton", {
		Name = "DropdownFrame",
		BackgroundTransparency = 1,
		Position = UDim2.new(0.03, 0, 0.081, 0),
		Size = UDim2.new(0, 190, 0, 30),
		ZIndex = 4,
		Text = "",
		Parent = DropdownHolder
	})

	local Round = library:Create("ImageLabel", {
		Name = "Dropdown_Roundify_5px",
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Selectable = true,
		Size = UDim2.new(1, 0, 1, 0),
		ZIndex = 3,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(45, 45, 45),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.050,
		Parent = DropdownFrame
	})

	local DropdownText = library:Create("TextLabel", {
		Name = "DropdownText",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0, 0),
		Size = UDim2.new(1, -30, 1, 0),
		ZIndex = 5,
		Font = Enum.Font.SourceSans,
		Text = option.value or "Select...",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = DropdownFrame
	})

	local DropdownArrow = library:Create("TextLabel", {
		Name = "DropdownArrow",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -25, 0, 0),
		Size = UDim2.new(0, 20, 1, 0),
		ZIndex = 5,
		Font = Enum.Font.GothamBold,
		Text = "▼",
		TextColor3 = Color3.fromRGB(200, 200, 200),
		TextSize = 14,
		Parent = DropdownFrame
	})

	-- Create dropdown list container
	option.ListFrame = library:Create("ImageLabel", {
		Name = "DropdownList",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 1, 2),
		Size = UDim2.new(1, 0, 0, 0),
		ZIndex = 10,
		Visible = false,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(35, 35, 35),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = DropdownFrame
	})

	local ListContainer = library:Create("ScrollingFrame", {
		Name = "ListContainer",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 2, 0, 2),
		Size = UDim2.new(1, -4, 1, -4),
		ZIndex = 11,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		ScrollBarThickness = 6,
		ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
		ScrollingDirection = Enum.ScrollingDirection.Y,
		BorderSizePixel = 0,
		Parent = option.ListFrame
	})

	local ListLayout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
		Parent = ListContainer
	})

	-- Track open state
	option.open = false
	option.items = {}

	-- Update canvas size when items change
	ListLayout.Changed:Connect(function()
		ListContainer.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
		local maxHeight = math.min(ListLayout.AbsoluteContentSize.Y, 120) -- Max 4 items visible
		option.ListFrame.Size = UDim2.new(1, 0, 0, maxHeight + 4)
	end)

	-- Function to create dropdown item
	local function createDropdownItem(value, index)
		local ItemFrame = library:Create("TextButton", {
			Name = "DropdownItem_" .. tostring(index),
			LayoutOrder = index,
			Size = UDim2.new(1, 0, 0, 28),
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			BorderSizePixel = 0,
			ZIndex = 12,
			Text = "",
			Parent = ListContainer
		})

		local ItemText = library:Create("TextLabel", {
			Name = "ItemText",
			BackgroundTransparency = 1,
			Position = UDim2.new(0, 8, 0, 0),
			Size = UDim2.new(1, -16, 1, 0),
			ZIndex = 13,
			Font = Enum.Font.SourceSans,
			Text = tostring(value),
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextSize = 15,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = ItemFrame
		})

		-- Hover effects
		ItemFrame.MouseEnter:Connect(function()
			ItemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		end)

		ItemFrame.MouseLeave:Connect(function()
			ItemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		end)

		-- Click handler
		ItemFrame.MouseButton1Click:Connect(function()
			option:SetValue(value)
			option:Close()
		end)

		return ItemFrame
	end

	-- Function to populate dropdown
	function option:UpdateItems()
		-- Clear existing items
		for _, item in pairs(ListContainer:GetChildren()) do
			if item:IsA("TextButton") then
				item:Destroy()
			end
		end
		option.items = {}

		-- Add new items
		for i, value in ipairs(self.values) do
			local item = createDropdownItem(value, i)
			table.insert(option.items, item)
		end
	end

	-- Initial population
	option:UpdateItems()

	-- Toggle dropdown
	function option:Toggle()
		self.open = not self.open
		self.ListFrame.Visible = self.open
		
		if self.open then
			DropdownArrow.Text = "▲"
			DropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
			Round.ImageColor3 = Color3.fromRGB(60, 60, 60)
		else
			DropdownArrow.Text = "▼"
			DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
			Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
		end
	end

	function option:Close()
		if self.open then
			self.open = false
			self.ListFrame.Visible = false
			DropdownArrow.Text = "▼"
			DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
			Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
		end
	end

	function option:SetValue(value)
		self.value = tostring(value)
		DropdownText.Text = self.value
		library.flags[self.flag] = self.value
		if self.callback then
			pcall(self.callback, self.value)
		end
	end

	function option:AddValue(value)
		table.insert(self.values, tostring(value))
		self:UpdateItems()
	end

	function option:RemoveValue(value)
		for i, v in ipairs(self.values) do
			if v == tostring(value) then
				table.remove(self.values, i)
				break
			end
		end
		self:UpdateItems()
		
		-- Reset value if current value was removed
		if self.value == tostring(value) then
			self.value = self.values[1] or "Select..."
			DropdownText.Text = self.value
			library.flags[self.flag] = self.value
		end
	end

	-- Main click handler
	DropdownFrame.MouseButton1Click:Connect(function()
		option:Toggle()
	end)

	-- Hover effects for main frame
	DropdownFrame.MouseEnter:Connect(function()
		if not option.open then
			Round.ImageColor3 = Color3.fromRGB(55, 55, 55)
		end
	end)

	DropdownFrame.MouseLeave:Connect(function()
		if not option.open then
			Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
		end
	end)

	-- Close when clicking outside
	inputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1 and option.open then
			local mouse = inputService:GetMouseLocation()
			local framePos = option.ListFrame.AbsolutePosition
			local frameSize = option.ListFrame.AbsoluteSize
			
			-- Check if click is outside dropdown
			if mouse.X < framePos.X or mouse.X > framePos.X + frameSize.X or 
			   mouse.Y < framePos.Y - 32 or mouse.Y > framePos.Y + frameSize.Y then
				option:Close()
			end
		end
	end)

	parent:Resize()
	return option
end

local function createFolder(option, parent)
	local FolderHolder = library:Create("Frame", {
		LayoutOrder = option.position,
		Name = "FolderHolder",
		Size = UDim2.new(1, 0, 0, 37),
		BackgroundTransparency = 1,
		Parent = parent.Container
	})

	local FolderTitle = library:Create("TextButton", {
		Name = "FolderTitle",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.03, 0, 0, 3),
		Size = UDim2.new(0, 190, 0, 30),
		ZIndex = 4,
		Font = Enum.Font.SourceSans,
		Text = " " .. (option.title or "Folder"),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 22,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = FolderHolder
	})

	local FolderArrow = library:Create("TextLabel", {
		Name = "FolderArrow",
		BackgroundTransparency = 1,
		Position = UDim2.new(1, -30, 0, 0),
		Size = UDim2.new(0, 30, 1, 0),
		ZIndex = 5,
		Font = Enum.Font.GothamBold,
		Text = option.open and "▼" or "▶",
		TextColor3 = option.open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180),
		TextSize = 17,
		Parent = FolderTitle
	})

	option.Container = library:Create("Frame", {
		Name = "FolderContent",
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 37),
		Size = UDim2.new(1, 0, 0, 0),
		Visible = option.open,
		Parent = FolderHolder
	})

	local FolderLayout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
		Parent = option.Container
	})

	FolderLayout.Changed:Connect(function()
		option:Resize()
	end)

	function option:Resize()
		pcall(function()
			if self.open then
				local contentHeight = FolderLayout.AbsoluteContentSize.Y
				option.Container.Size = UDim2.new(1, 0, 0, contentHeight)
				FolderHolder.Size = UDim2.new(1, 0, 0, 37 + contentHeight)
			else
				option.Container.Size = UDim2.new(1, 0, 0, 0)
				FolderHolder.Size = UDim2.new(1, 0, 0, 37)
			end
			parent:Resize()
		end)
	end

	FolderTitle.MouseButton1Click:Connect(function()
		option.open = not option.open
		FolderArrow.Text = option.open and "▼" or "▶"
		FolderArrow.TextColor3 = option.open and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
		option.Container.Visible = option.open
		option:Resize()
	end)

	function option:AddButton(buttonOption)
		buttonOption = typeof(buttonOption) == "table" and buttonOption or {}
		buttonOption.text = tostring(buttonOption.text)
		buttonOption.callback = typeof(buttonOption.callback) == "function" and buttonOption.callback or function() end
		buttonOption.type = "button"
		buttonOption.position = #self.options
		buttonOption.flag = buttonOption.flag or buttonOption.text
		table.insert(self.options, buttonOption)
		
		createButton(buttonOption, self)
		return buttonOption
	end

	function option:AddKeybind(keybindOption)
		keybindOption = typeof(keybindOption) == "table" and keybindOption or {}
		keybindOption.text = tostring(keybindOption.text or "Keybind")
		keybindOption.key = keybindOption.key or Enum.KeyCode.F
		keybindOption.mode = keybindOption.mode or "hold" -- "hold" or "toggle"
		keybindOption.callback = typeof(keybindOption.callback) == "function" and keybindOption.callback or function() end
		keybindOption.type = "keybind"
		keybindOption.position = #self.options
		keybindOption.flag = keybindOption.flag or keybindOption.text
		table.insert(self.options, keybindOption)
		
		createKeybind(keybindOption, self)
		return keybindOption
	end

	function option:AddDropdown(dropdownOption)
		dropdownOption = typeof(dropdownOption) == "table" and dropdownOption or {}
		dropdownOption.text = tostring(dropdownOption.text or "Dropdown")
		dropdownOption.values = typeof(dropdownOption.values) == "table" and dropdownOption.values or {"Option 1", "Option 2"}
		dropdownOption.value = dropdownOption.value or dropdownOption.values[1] or "Select..."
		dropdownOption.callback = typeof(dropdownOption.callback) == "function" and dropdownOption.callback or function() end
		dropdownOption.type = "dropdown"
		dropdownOption.position = #self.options
		dropdownOption.flag = dropdownOption.flag or dropdownOption.text
		table.insert(self.options, dropdownOption)
		
		createDropdown(dropdownOption, self)
		return dropdownOption
	end

	function option:Button(Name, callback)
		pcall(function()
			local ButtonHolder = library:Create("Frame", {
				Name = "ButtonHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = self.Container
			})

			local Button = library:Create("TextButton", {
				Name = "Button",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.03, 0, 0.081, 0),
				Size = UDim2.new(0, 190, 0, 30),
				ZIndex = 4,
				Font = Enum.Font.SourceSans,
				Text = Name or "Button",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 22,
				TextWrapped = true,
				ClipsDescendants = true,
				Parent = ButtonHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Button_Roundify_5px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(45, 45, 45),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.050,
				Parent = Button
			})

			Button.MouseButton1Click:Connect(function()
				if callback then pcall(callback) end
			end)

			self:Resize()
		end)
	end

	function option:Keybind(name, key, mode, callback)
		pcall(function()
			local KeybindHolder = library:Create("Frame", {
				Name = "KeybindHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = self.Container
			})

			local KeybindText = library:Create("TextLabel", {
				Name = "KeybindText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.04, 0, 0.162, 0),
				Size = UDim2.new(0, 94, 0, 23),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.1,
				Text = name or "Keybind",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = KeybindHolder
			})

			local KeybindBox = library:Create("TextButton", {
				Name = "KeybindBox",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.54, 0, 0.243, 0),
				Size = UDim2.new(0, 85, 0, 23),
				ZIndex = 4,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.5,
				Text = key and key.Name or "F",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				Parent = KeybindHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Keybind_Roundify_4px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.386, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1.045, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(43, 43, 43),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.040,
				Parent = KeybindBox
			})

			local listening = false
			local currentKey = key or Enum.KeyCode.F
			local keybindMode = mode or "hold"

			KeybindBox.MouseButton1Click:Connect(function()
				if listening then return end
				listening = true
				KeybindBox.Text = "..."
				KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 0)
				
				local connection
				connection = inputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then return end
					
					if input.UserInputType == Enum.UserInputType.Keyboard then
						connection:Disconnect()
						listening = false
						currentKey = input.KeyCode
						KeybindBox.Text = input.KeyCode.Name
						KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end)
			end)

			-- Listen for the keybind activation
			inputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then return end
				if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
					if keybindMode == "toggle" then
						library.flags[name .. "_active"] = not library.flags[name .. "_active"]
					else
						library.flags[name .. "_active"] = true
					end
					
					if callback then
						pcall(callback, library.flags[name .. "_active"])
					end
				end
			end)

			if keybindMode ~= "toggle" then
				inputService.InputEnded:Connect(function(input, gameProcessed)
					if gameProcessed then return end
					if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
						library.flags[name .. "_active"] = false
						if callback then
							pcall(callback, false)
						end
					end
				end)
			end

			self:Resize()
		end)
	end

	function option:Dropdown(name, values, callback)
		pcall(function()
			local DropdownHolder = library:Create("Frame", {
				Name = "DropdownHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = self.Container
			})

			local DropdownFrame = library:Create("TextButton", {
				Name = "DropdownFrame",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.03, 0, 0.081, 0),
				Size = UDim2.new(0, 190, 0, 30),
				ZIndex = 4,
				Text = "",
				Parent = DropdownHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Dropdown_Roundify_5px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(45, 45, 45),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.050,
				Parent = DropdownFrame
			})

			local DropdownText = library:Create("TextLabel", {
				Name = "DropdownText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 0),
				Size = UDim2.new(1, -30, 1, 0),
				ZIndex = 5,
				Font = Enum.Font.SourceSans,
				Text = values[1] or "Select...",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = DropdownFrame
			})

			local DropdownArrow = library:Create("TextLabel", {
				Name = "DropdownArrow",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -25, 0, 0),
				Size = UDim2.new(0, 20, 1, 0),
				ZIndex = 5,
				Font = Enum.Font.GothamBold,
				Text = "▼",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				Parent = DropdownFrame
			})

			-- Create dropdown list
			local ListFrame = library:Create("ImageLabel", {
				Name = "DropdownList",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 1, 2),
				Size = UDim2.new(1, 0, 0, math.min(#values * 29, 120)),
				ZIndex = 10,
				Visible = false,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(35, 35, 35),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.040,
				Parent = DropdownFrame
			})

			local ListContainer = library:Create("ScrollingFrame", {
				Name = "ListContainer",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 2, 0, 2),
				Size = UDim2.new(1, -4, 1, -4),
				ZIndex = 11,
				CanvasSize = UDim2.new(0, 0, 0, #values * 29),
				ScrollBarThickness = 6,
				ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
				ScrollingDirection = Enum.ScrollingDirection.Y,
				BorderSizePixel = 0,
				Parent = ListFrame
			})

			local ListLayout = library:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 1),
				Parent = ListContainer
			})

			local isOpen = false
			local currentValue = values[1] or "Select..."

			-- Create dropdown items
			for i, value in ipairs(values) do
				local ItemFrame = library:Create("TextButton", {
					Name = "DropdownItem_" .. i,
					LayoutOrder = i,
					Size = UDim2.new(1, 0, 0, 28),
					BackgroundColor3 = Color3.fromRGB(40, 40, 40),
					BorderSizePixel = 0,
					ZIndex = 12,
					Text = "",
					Parent = ListContainer
				})

				local ItemText = library:Create("TextLabel", {
					Name = "ItemText",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, -16, 1, 0),
					ZIndex = 13,
					Font = Enum.Font.SourceSans,
					Text = tostring(value),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 15,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = ItemFrame
				})

				ItemFrame.MouseEnter:Connect(function()
					ItemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				end)

				ItemFrame.MouseLeave:Connect(function()
					ItemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				end)

				ItemFrame.MouseButton1Click:Connect(function()
					currentValue = tostring(value)
					DropdownText.Text = currentValue
					isOpen = false
					ListFrame.Visible = false
					DropdownArrow.Text = "▼"
					DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
					Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
					if callback then
						pcall(callback, currentValue)
					end
				end)
			end

			DropdownFrame.MouseButton1Click:Connect(function()
				isOpen = not isOpen
				ListFrame.Visible = isOpen
				
				if isOpen then
					DropdownArrow.Text = "▲"
					DropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
					Round.ImageColor3 = Color3.fromRGB(60, 60, 60)
				else
					DropdownArrow.Text = "▼"
					DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
					Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)

			DropdownFrame.MouseEnter:Connect(function()
				if not isOpen then
					Round.ImageColor3 = Color3.fromRGB(55, 55, 55)
				end
			end)

			DropdownFrame.MouseLeave:Connect(function()
				if not isOpen then
					Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)

			self:Resize()
		end)
	end

	function option:Slider(name, min, max, precise, callback)
		pcall(function()
			local PreciseValue = precise
			local SliderHolder = library:Create("Frame", {
				Name = "SliderHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = self.Container
			})

			local SliderTitle = library:Create("TextLabel", {
				Name = "SliderTitle",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045, 0, 0.081, 0),
				Size = UDim2.new(0, 185, 0, 16),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.2,
				Text = name or "Slider",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = SliderHolder
			})

			local SliderFrame = library:Create("TextButton", {
				Name = "SliderFrame",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0.045, 0, 0.5405, 0),
				Size = UDim2.new(0, 185, 0, 6),
				ZIndex = 3,
				Text = "",
				Parent = SliderHolder
			})

			local Slider = library:Create("Frame", {
				Name = "Slider",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 0, 0, 6),
				ZIndex = 4,
				Parent = SliderFrame
			})

			local UIGradient = library:Create("UIGradient", {
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 116, 116))
				},
				Parent = Slider
			})

			local ValueText = library:Create("TextLabel", {
				Name = "ValueText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045, 0, 0.081, 0),
				Size = UDim2.new(0, 185, 0, 16),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.2,
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Right,
				Parent = SliderHolder
			})

			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")
			local Connection
			local isDragging = false

			UserInputService.InputEnded:Connect(function(Input)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and isDragging then
					if Connection then Connection:Disconnect() Connection = nil end
					isDragging = false
					ValueText.TextTransparency = 1
				end
			end)

			local Vals = {Min = min or 0, Max = max or 100}
			ValueText.Text = Vals.Min .. "/" .. Vals.Max

			SliderFrame.MouseButton1Down:Connect(function()
				pcall(function()
					if Connection then Connection:Disconnect() end
					isDragging = true
					Connection = RunService.RenderStepped:Connect(function()
						if not isDragging then if Connection then Connection:Disconnect() Connection = nil end return end
						local Mouse = UserInputService:GetMouseLocation()
						local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)
						local GetValue = Vals.Min + (Vals.Max - Vals.Min) * Percentage
						GetValue = math.floor(GetValue)
						if PreciseValue then GetValue = string.format("%.2f", GetValue) end
						Slider.Size = UDim2.new(Percentage, 0, 0, 6)
						ValueText.Text = GetValue .. "/" .. Vals.Max
						ValueText.TextTransparency = 0
						if callback then pcall(callback, tonumber(GetValue)) end
					end)
				end)
			end)

			self:Resize()
		end)
	end

	function option:Box(Name, callback)
		pcall(function()
			local BoxHolder = library:Create("Frame", {
				Name = "BoxHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = self.Container
			})

			local BoxText = library:Create("TextLabel", {
				Name = "BoxText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.04, 0, 0.162, 0),
				Size = UDim2.new(0, 94, 0, 23),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.1,
				Text = Name or "TextBox",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = BoxHolder
			})

			local Box = library:Create("TextBox", {
				Name = "Box",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.54, 0, 0.243, 0),
				Size = UDim2.new(0, 85, 0, 23),
				ZIndex = 4,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.5,
				PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				Parent = BoxHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Box_Roundify_4px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.386, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1.045, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(43, 43, 43),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.040,
				Parent = Box
			})

			Box.FocusLost:Connect(function(enter)
				if enter and Box.Text ~= "" and Box.Text ~= " " then
					if callback then pcall(callback, Box.Text) end
				end
			end)

			Box.Changed:Connect(function()
				Box.TextScaled = (#Box.Text >= 15)
			end)

			self:Resize()
		end)
	end

	function option:Toggle(Name, callback)
		pcall(function()
			local Enabled = false

			local ToggleHolder = library:Create("Frame", {
				Name = "ToggleHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = self.Container
			})

			local ToggleImage = library:Create("ImageLabel", {
				Name = "ToggleImage",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.83, 0, 0.081, 0),
				Size = UDim2.new(0, 30, 0, 30),
				ZIndex = 2,
				Image = "http://www.roblox.com/asset/?id=4908273649",
				Parent = ToggleHolder
			})

			local MainToggle = library:Create("ImageButton", {
				Name = "MainToggle",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.83, 0, 0.081, 0),
				Size = UDim2.new(0, 30, 0, 30),
				ZIndex = 3,
				Image = "http://www.roblox.com/asset/?id=4908257956",
				ImageColor3 = Color3.fromRGB(90, 255, 115),
				ImageTransparency = 1,
				Parent = ToggleHolder
			})

			local ToggleText = library:Create("TextLabel", {
				Name = "ToggleText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045, 0, 0.081, 0),
				Size = UDim2.new(0, 157, 0, 29),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				Text = Name or "Toggle",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = ToggleHolder
			})

			MainToggle.MouseButton1Click:Connect(function()
				Enabled = not Enabled
				if callback then pcall(callback, Enabled) end
				MainToggle.ImageTransparency = Enabled and 0 or 1
			end)

			self:Resize()
		end)
	end

	parent:Resize()
	return option
end

local function loadOptions(window)
	for _, option in next, window.options do
		if option.type == "button" then
			createButton(option, window)
		elseif option.type == "folder" then
			createFolder(option, window)
		elseif option.type == "keybind" then
			createKeybind(option, window)
		elseif option.type == "dropdown" then
			createDropdown(option, window)
		end
	end
end

function library:CreateWindow(WName)
	library.count = library.count + 1
	local ui = {}

	local Holder = library:Create("ImageLabel", {
		Name = WName,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0, (15 + (202 * library.count) - 200), 0.002, 0),
		Size = UDim2.new(0, 200, 0, 39),
		ZIndex = 5,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(26, 26, 26),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = self.base or game:GetService("CoreGui")
	})

	local ToggleGUI = library:Create("TextButton", {
		Name = "ToggleGUI",
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.852, 0, 0, 0),
		Size = UDim2.new(0, 31, 0, 38),
		ZIndex = 6,
		Font = Enum.Font.GothamBold,
		Text = "▼",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 17,
		Parent = Holder
	})

	local Container = library:Create("ImageLabel", {
		Name = "Container",
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Size = UDim2.new(0, 200, 0, 37),
		ZIndex = 2,
		Image = "rbxassetid://3570695787",
		ImageColor3 = Color3.fromRGB(35, 35, 35),
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(100, 100, 100, 100),
		SliceScale = 0.040,
		Parent = Holder
	})

	local WindowText = library:Create("TextLabel", {
		Name = WName,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Position = UDim2.new(0.04, 0, 0.154, 0),
		Size = UDim2.new(0, 186, 0, 27),
		ZIndex = 5,
		Font = Enum.Font.SourceSans,
		Text = WName,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 22,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = Holder
	})

	local UIListLayout = library:Create("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
		Parent = Container
	})

	local UIPadding = library:Create("UIPadding", {
		PaddingTop = UDim.new(0, 40),
		Parent = Container
	})

	ui.Holder = Holder
	ui.Container = Container
	ui.ToggleGUI = ToggleGUI
	ui.options = {}
	ui.opened = false

	-- draggable
	local players = game:GetService("Players")
	local player = players.LocalPlayer
	local mouse = player:GetMouse()
	local run = game:GetService("RunService")

	local function draggable(obj)
		pcall(function()
			obj.Active = true
			local isDragging, dragStart, startPos = false, nil, nil

			obj.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = true
					dragStart = Vector2.new(mouse.X, mouse.Y)
					startPos = obj.Position
				end
			end)

			obj.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isDragging = false
				end
			end)

			run.Heartbeat:Connect(function()
				if isDragging then
					local mousePos = Vector2.new(mouse.X, mouse.Y)
					local delta = mousePos - dragStart
					obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
				end
			end)
		end)
	end
	draggable(Holder)

	ToggleGUI.MouseButton1Click:Connect(function()
		pcall(function()
			ui.opened = not ui.opened
			ToggleGUI.Rotation = ui.opened and 90 or 0

			local y = 40
			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					y = y + (v.AbsoluteSize.Y + 2)
				end
			end

			local targetSize = ui.opened and UDim2.new(0, 200, 0, y) or UDim2.new(0, 200, 0, 37)
			Container.Size = targetSize
		end)
	end)

	function ui:Resize()
		pcall(function()
			local y = 37
			for _, v in pairs(Container:GetChildren()) do
				if not v:IsA("UIPadding") and not v:IsA("UIListLayout") then
					y = y + (v.AbsoluteSize.Y + 2)
				end
			end
			Container.Size = UDim2.new(0, 200, 0, y + 2)
		end)
	end

	function ui:Button(Name, callback)
		pcall(function()
			local ButtonHolder = library:Create("Frame", {
				Name = "ButtonHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = Container
			})

			local Button = library:Create("TextButton", {
				Name = "Button",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.03, 0, 0.081, 0),
				Size = UDim2.new(0, 190, 0, 30),
				ZIndex = 4,
				Font = Enum.Font.SourceSans,
				Text = Name or "Button",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 22,
				TextWrapped = true,
				ClipsDescendants = true,
				Parent = ButtonHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Button_Roundify_5px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(45, 45, 45),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.050,
				Parent = Button
			})

			Button.MouseButton1Click:Connect(function()
				if callback then pcall(callback) end
			end)

			ui:Resize()
		end)
	end

	function ui:Keybind(name, key, mode, callback)
		pcall(function()
			local KeybindHolder = library:Create("Frame", {
				Name = "KeybindHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = Container
			})

			local KeybindText = library:Create("TextLabel", {
				Name = "KeybindText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.04, 0, 0.162, 0),
				Size = UDim2.new(0, 94, 0, 23),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.1,
				Text = name or "Keybind",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = KeybindHolder
			})

			local KeybindBox = library:Create("TextButton", {
				Name = "KeybindBox",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.54, 0, 0.243, 0),
				Size = UDim2.new(0, 85, 0, 23),
				ZIndex = 4,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.5,
				Text = key and key.Name or "F",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				Parent = KeybindHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Keybind_Roundify_4px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.386, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1.045, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(43, 43, 43),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.040,
				Parent = KeybindBox
			})

			local listening = false
			local currentKey = key or Enum.KeyCode.F
			local keybindMode = mode or "hold"

			KeybindBox.MouseButton1Click:Connect(function()
				if listening then return end
				listening = true
				KeybindBox.Text = "..."
				KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 0)
				
				local connection
				connection = inputService.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then return end
					
					if input.UserInputType == Enum.UserInputType.Keyboard then
						connection:Disconnect()
						listening = false
						currentKey = input.KeyCode
						KeybindBox.Text = input.KeyCode.Name
						KeybindBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					end
				end)
			end)

			-- Listen for the keybind activation
			inputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then return end
				if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
					if keybindMode == "toggle" then
						library.flags[name .. "_active"] = not library.flags[name .. "_active"]
					else
						library.flags[name .. "_active"] = true
					end
					
					if callback then
						pcall(callback, library.flags[name .. "_active"])
					end
				end
			end)

			if keybindMode ~= "toggle" then
				inputService.InputEnded:Connect(function(input, gameProcessed)
					if gameProcessed then return end
					if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == currentKey then
						library.flags[name .. "_active"] = false
						if callback then
							pcall(callback, false)
						end
					end
				end)
			end

			ui:Resize()
		end)
	end

	function ui:Dropdown(name, values, callback)
		pcall(function()
			local DropdownHolder = library:Create("Frame", {
				Name = "DropdownHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = Container
			})

			local DropdownFrame = library:Create("TextButton", {
				Name = "DropdownFrame",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.03, 0, 0.081, 0),
				Size = UDim2.new(0, 190, 0, 30),
				ZIndex = 4,
				Text = "",
				Parent = DropdownHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Dropdown_Roundify_5px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(45, 45, 45),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.050,
				Parent = DropdownFrame
			})

			local DropdownText = library:Create("TextLabel", {
				Name = "DropdownText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 10, 0, 0),
				Size = UDim2.new(1, -30, 1, 0),
				ZIndex = 5,
				Font = Enum.Font.SourceSans,
				Text = values[1] or "Select...",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 16,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = DropdownFrame
			})

			local DropdownArrow = library:Create("TextLabel", {
				Name = "DropdownArrow",
				BackgroundTransparency = 1,
				Position = UDim2.new(1, -25, 0, 0),
				Size = UDim2.new(0, 20, 1, 0),
				ZIndex = 5,
				Font = Enum.Font.GothamBold,
				Text = "▼",
				TextColor3 = Color3.fromRGB(200, 200, 200),
				TextSize = 14,
				Parent = DropdownFrame
			})

			-- Create dropdown list
			local ListFrame = library:Create("ImageLabel", {
				Name = "DropdownList",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 1, 2),
				Size = UDim2.new(1, 0, 0, math.min(#values * 29, 120)),
				ZIndex = 10,
				Visible = false,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(35, 35, 35),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.040,
				Parent = DropdownFrame
			})

			local ListContainer = library:Create("ScrollingFrame", {
				Name = "ListContainer",
				BackgroundTransparency = 1,
				Position = UDim2.new(0, 2, 0, 2),
				Size = UDim2.new(1, -4, 1, -4),
				ZIndex = 11,
				CanvasSize = UDim2.new(0, 0, 0, #values * 29),
				ScrollBarThickness = 6,
				ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
				ScrollingDirection = Enum.ScrollingDirection.Y,
				BorderSizePixel = 0,
				Parent = ListFrame
			})

			local ListLayout = library:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 1),
				Parent = ListContainer
			})

			local isOpen = false
			local currentValue = values[1] or "Select..."

			-- Create dropdown items
			for i, value in ipairs(values) do
				local ItemFrame = library:Create("TextButton", {
					Name = "DropdownItem_" .. i,
					LayoutOrder = i,
					Size = UDim2.new(1, 0, 0, 28),
					BackgroundColor3 = Color3.fromRGB(40, 40, 40),
					BorderSizePixel = 0,
					ZIndex = 12,
					Text = "",
					Parent = ListContainer
				})

				local ItemText = library:Create("TextLabel", {
					Name = "ItemText",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 0),
					Size = UDim2.new(1, -16, 1, 0),
					ZIndex = 13,
					Font = Enum.Font.SourceSans,
					Text = tostring(value),
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 15,
					TextXAlignment = Enum.TextXAlignment.Left,
					Parent = ItemFrame
				})

				ItemFrame.MouseEnter:Connect(function()
					ItemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				end)

				ItemFrame.MouseLeave:Connect(function()
					ItemFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				end)

				ItemFrame.MouseButton1Click:Connect(function()
					currentValue = tostring(value)
					DropdownText.Text = currentValue
					isOpen = false
					ListFrame.Visible = false
					DropdownArrow.Text = "▼"
					DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
					Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
					if callback then
						pcall(callback, currentValue)
					end
				end)
			end

			DropdownFrame.MouseButton1Click:Connect(function()
				isOpen = not isOpen
				ListFrame.Visible = isOpen
				
				if isOpen then
					DropdownArrow.Text = "▲"
					DropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
					Round.ImageColor3 = Color3.fromRGB(60, 60, 60)
				else
					DropdownArrow.Text = "▼"
					DropdownArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
					Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)

			DropdownFrame.MouseEnter:Connect(function()
				if not isOpen then
					Round.ImageColor3 = Color3.fromRGB(55, 55, 55)
				end
			end)

			DropdownFrame.MouseLeave:Connect(function()
				if not isOpen then
					Round.ImageColor3 = Color3.fromRGB(45, 45, 45)
				end
			end)

			ui:Resize()
		end)
	end

	function ui:Slider(name, min, max, precise, callback)
		pcall(function()
			local PreciseValue = precise
			local SliderHolder = library:Create("Frame", {
				Name = "SliderHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = Container
			})

			local SliderTitle = library:Create("TextLabel", {
				Name = "SliderTitle",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045, 0, 0.081, 0),
				Size = UDim2.new(0, 185, 0, 16),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.2,
				Text = name or "Slider",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = SliderHolder
			})

			local SliderFrame = library:Create("TextButton", {
				Name = "SliderFrame",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Position = UDim2.new(0.045, 0, 0.5405, 0),
				Size = UDim2.new(0, 185, 0, 6),
				ZIndex = 3,
				Text = "",
				Parent = SliderHolder
			})

			local Slider = library:Create("Frame", {
				Name = "Slider",
				BackgroundColor3 = Color3.fromRGB(255, 255, 255),
				BorderSizePixel = 0,
				Size = UDim2.new(0, 0, 0, 6),
				ZIndex = 4,
				Parent = SliderFrame
			})

			local UIGradient = library:Create("UIGradient", {
				Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 116, 116))
				},
				Parent = Slider
			})

			local ValueText = library:Create("TextLabel", {
				Name = "ValueText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045, 0, 0.081, 0),
				Size = UDim2.new(0, 185, 0, 16),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.2,
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Right,
				Parent = SliderHolder
			})

			local UserInputService = game:GetService("UserInputService")
			local RunService = game:GetService("RunService")
			local Connection
			local isDragging = false

			UserInputService.InputEnded:Connect(function(Input)
				if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and isDragging then
					if Connection then Connection:Disconnect() Connection = nil end
					isDragging = false
					ValueText.TextTransparency = 1
				end
			end)

			local Vals = {Min = min or 0, Max = max or 100}
			ValueText.Text = Vals.Min .. "/" .. Vals.Max

			SliderFrame.MouseButton1Down:Connect(function()
				pcall(function()
					if Connection then Connection:Disconnect() end
					isDragging = true
					Connection = RunService.RenderStepped:Connect(function()
						if not isDragging then if Connection then Connection:Disconnect() Connection = nil end return end
						local Mouse = UserInputService:GetMouseLocation()
						local Percentage = math.clamp((Mouse.X - SliderFrame.AbsolutePosition.X) / (SliderFrame.AbsoluteSize.X), 0, 1)
						local GetValue = Vals.Min + (Vals.Max - Vals.Min) * Percentage
						GetValue = math.floor(GetValue)
						if PreciseValue then GetValue = string.format("%.2f", GetValue) end
						Slider.Size = UDim2.new(Percentage, 0, 0, 6)
						ValueText.Text = GetValue .. "/" .. Vals.Max
						ValueText.TextTransparency = 0
						if callback then pcall(callback, tonumber(GetValue)) end
					end)
				end)
			end)

			ui:Resize()
		end)
	end

	function ui:Box(Name, callback)
		pcall(function()
			local BoxHolder = library:Create("Frame", {
				Name = "BoxHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = Container
			})

			local BoxText = library:Create("TextLabel", {
				Name = "BoxText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.04, 0, 0.162, 0),
				Size = UDim2.new(0, 94, 0, 23),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.1,
				Text = Name or "TextBox",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = BoxHolder
			})

			local Box = library:Create("TextBox", {
				Name = "Box",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.54, 0, 0.243, 0),
				Size = UDim2.new(0, 85, 0, 23),
				ZIndex = 4,
				Font = Enum.Font.SourceSansSemibold,
				LineHeight = 1.5,
				PlaceholderColor3 = Color3.fromRGB(255, 255, 255),
				Text = "",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				Parent = BoxHolder
			})

			local Round = library:Create("ImageLabel", {
				Name = "Box_Roundify_4px",
				Active = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				BackgroundTransparency = 1,
				Position = UDim2.new(0.5, 0, 0.386, 0),
				Selectable = true,
				Size = UDim2.new(1, 0, 1.045, 0),
				ZIndex = 3,
				Image = "rbxassetid://3570695787",
				ImageColor3 = Color3.fromRGB(43, 43, 43),
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(100, 100, 100, 100),
				SliceScale = 0.040,
				Parent = Box
			})

			Box.FocusLost:Connect(function(enter)
				if enter and Box.Text ~= "" and Box.Text ~= " " then
					if callback then pcall(callback, Box.Text) end
				end
			end)

			Box.Changed:Connect(function()
				Box.TextScaled = (#Box.Text >= 15)
			end)

			ui:Resize()
		end)
	end

	function ui:Toggle(Name, callback)
		pcall(function()
			local Enabled = false

			local ToggleHolder = library:Create("Frame", {
				Name = "ToggleHolder",
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 37),
				ZIndex = 2,
				Parent = Container
			})

			local ToggleImage = library:Create("ImageLabel", {
				Name = "ToggleImage",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.83, 0, 0.081, 0),
				Size = UDim2.new(0, 30, 0, 30),
				ZIndex = 2,
				Image = "http://www.roblox.com/asset/?id=4908273649",
				Parent = ToggleHolder
			})

			local MainToggle = library:Create("ImageButton", {
				Name = "MainToggle",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.83, 0, 0.081, 0),
				Size = UDim2.new(0, 30, 0, 30),
				ZIndex = 3,
				Image = "http://www.roblox.com/asset/?id=4908257956",
				ImageColor3 = Color3.fromRGB(90, 255, 115),
				ImageTransparency = 1,
				Parent = ToggleHolder
			})

			local ToggleText = library:Create("TextLabel", {
				Name = "ToggleText",
				BackgroundTransparency = 1,
				Position = UDim2.new(0.045, 0, 0.081, 0),
				Size = UDim2.new(0, 157, 0, 29),
				ZIndex = 3,
				Font = Enum.Font.SourceSansSemibold,
				Text = Name or "Toggle",
				TextColor3 = Color3.fromRGB(255, 255, 255),
				TextSize = 14,
				TextXAlignment = Enum.TextXAlignment.Left,
				Parent = ToggleHolder
			})

			MainToggle.MouseButton1Click:Connect(function()
				Enabled = not Enabled
				if callback then pcall(callback, Enabled) end
				MainToggle.ImageTransparency = Enabled and 0 or 1
			end)

			ui:Resize()
		end)
	end

	function ui:AddButton(option)
		option = typeof(option) == "table" and option or {}
		option.text = tostring(option.text)
		option.callback = typeof(option.callback) == "function" and option.callback or function() end
		option.type = "button"
		option.position = #self.options
		option.flag = option.flag or option.text
		table.insert(self.options, option)
		
		createButton(option, self)
		return option
	end

	function ui:AddKeybind(keybindOption)
		keybindOption = typeof(keybindOption) == "table" and keybindOption or {}
		keybindOption.text = tostring(keybindOption.text or "Keybind")
		keybindOption.key = keybindOption.key or Enum.KeyCode.F
		keybindOption.mode = keybindOption.mode or "hold" -- "hold" or "toggle"
		keybindOption.callback = typeof(keybindOption.callback) == "function" and keybindOption.callback or function() end
		keybindOption.type = "keybind"
		keybindOption.position = #self.options
		keybindOption.flag = keybindOption.flag or keybindOption.text
		table.insert(self.options, keybindOption)
		
		createKeybind(keybindOption, self)
		return keybindOption
	end

	function ui:AddDropdown(dropdownOption)
		dropdownOption = typeof(dropdownOption) == "table" and dropdownOption or {}
		dropdownOption.text = tostring(dropdownOption.text or "Dropdown")
		dropdownOption.values = typeof(dropdownOption.values) == "table" and dropdownOption.values or {"Option 1", "Option 2"}
		dropdownOption.value = dropdownOption.value or dropdownOption.values[1] or "Select..."
		dropdownOption.callback = typeof(dropdownOption.callback) == "function" and dropdownOption.callback or function() end
		dropdownOption.type = "dropdown"
		dropdownOption.position = #self.options
		dropdownOption.flag = dropdownOption.flag or dropdownOption.text
		table.insert(self.options, dropdownOption)
		
		createDropdown(dropdownOption, self)
		return dropdownOption
	end

	function ui:AddFolder(title)
		local option = {}
		option.title = tostring(title)
		option.options = {}
		option.open = false
		option.type = "folder"
		option.position = #self.options
		table.insert(self.options, option)
		
		createFolder(option, self)
		return option
	end

	table.insert(library.windows, ui)
	return ui
end

function library:Init()
	local FindLibrary = game:GetService("CoreGui"):FindFirstChild("ToraZenLibrary")
	if FindLibrary then safeDestroy(FindLibrary) end

	self.base = self:Create("ScreenGui", {
		Name = "ToraZenLibrary",
		ResetOnSpawn = false,
		Parent = game:GetService("CoreGui")
	})

	if syn and syn.protect_gui then
		syn.protect_gui(self.base)
	elseif get_hidden_gui then
		get_hidden_gui(self.base)
	elseif gethui then
		gethui(self.base)
	end

	for _, window in next, self.windows do
		if window.Holder then
			window.Holder.Parent = self.base
		end
	end

	return self.base
end

function library:Close()
	if typeof(self.base) ~= "Instance" then return end
	self.open = not self.open
	for _, window in next, self.windows do
		if window.Holder then
			window.Holder.Visible = self.open
		end
	end
end

-- Default GUI toggle keybind (RightShift)
inputService.InputBegan:Connect(function(Input, gameProcessed)
	if not gameProcessed and Input.KeyCode == Enum.KeyCode.RightShift then
		library:Close()
	end
end)

return library
