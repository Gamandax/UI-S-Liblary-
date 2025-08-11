-- Nexus Liblary Made by Nexus [ Nexus Liblary V2 ]

-- Source 

--[[ Nexus Liblary V2 ]]
local g,c,w,cl,d=game.GetService,game.Loaded.Connect,game.Loaded.Wait,game.Clone,game.Destroy
if not game:IsLoaded() then w(game.Loaded) end

local Setup={Keybind=Enum.KeyCode.LeftControl,Transparency=0.2,ThemeMode="Dark",Size=nil}
local Theme={Primary=Color3.fromRGB(30,30,30),Secondary=Color3.fromRGB(35,35,35),Component=Color3.fromRGB(40,40,40),Interactables=Color3.fromRGB(45,45,45),Tab=Color3.fromRGB(200,200,200),Title=Color3.fromRGB(240,240,240),Description=Color3.fromRGB(200,200,200),Shadow=Color3.fromRGB(0,0,0),Outline=Color3.fromRGB(40,40,40),Icon=Color3.fromRGB(220,220,220)}

local Type,Blur,LocalPlayer=nil,nil,g(game,"Players").LocalPlayer
local Services={Insert=g(game,"InsertService"),Tween=g(game,"TweenService"),Run=g(game,"RunService"),Input=g(game,"UserInputService")}
local Player={Mouse=LocalPlayer:GetMouse(),GUI=LocalPlayer.PlayerGui}

local function Tween(o,s,p,i)
local st,d=Enum.EasingStyle.Sine,Enum.EasingDirection.Out
if i then st,d=i.EasingStyle or st,i.EasingDirection or d end
return Services.Tween:Create(o,TweenInfo.new(s,st,d),p):Play()
end

local function SetProperty(o,p) for i,v in pairs(p) do o[i]=v end return o end

local function Multiply(v,a)
return UDim2.new(v.X.Scalea,v.X.Offseta,v.Y.Scalea,v.Y.Offseta)
end

local function Color(c,f,m)
m=m or Setup.ThemeMode
if m=="Light" then
return Color3.fromRGB((c.R255)-f,(c.G255)-f,(c.B255)-f)
else
return Color3.fromRGB((c.R255)+f,(c.G255)+f,(c.B255)+f)
end
end

local function Drag(canvas)
if not canvas then return end
local dragging,dragInput,start,startPos

local function update(input)  
	local delta=input.Position-start  
	canvas.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)  
end  
  
c(canvas.InputBegan,function(input)  
	if (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) and not Type then  
		dragging,start,startPos=true,input.Position,canvas.Position  
		c(input.Changed,function()  
			if input.UserInputState==Enum.UserInputState.End then dragging=false end  
		end)  
	end  
end)  
  
c(canvas.InputChanged,function(input)  
	if (input.UserInputType==Enum.UserInputType.MouseMovement or input.UserInputType==Enum.UserInputType.Touch) and not Type then  
		dragInput=input  
	end  
end)  
  
c(Services.Input.InputChanged,function(input)  
	if input==dragInput and dragging and not Type then update(input) end  
end)

end

local Resizing={TopLeft={X=Vector2.new(-1,0),Y=Vector2.new(0,-1)},TopRight={X=Vector2.new(1,0),Y=Vector2.new(0,-1)},BottomLeft={X=Vector2.new(-1,0),Y=Vector2.new(0,1)},BottomRight={X=Vector2.new(1,0),Y=Vector2.new(0,1)}}

local function Resizeable(tab,min,max)
task.spawn(function()
local mousePos,size,uiPos
if tab and tab:FindFirstChild("Resize") then
local positions=tab:FindFirstChild("Resize")
for _,types in pairs(positions:GetChildren()) do
c(types.InputBegan,function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then
Type,mousePos,size,uiPos=types,Vector2.new(Player.Mouse.X,Player.Mouse.Y),tab.AbsoluteSize,tab.Position
end
end)
c(types.InputEnded,function(input)
if input.UserInputType==Enum.UserInputType.MouseButton1 then Type=nil end
end)
end
end

local function resize(delta)  
		if Type and mousePos and size and uiPos and tab:FindFirstChild("Resize")[Type.Name]==Type then  
			local mode=Resizing[Type.Name]  
			local newSize=Vector2.new(size.X+delta.X*mode.X.X,size.Y+delta.Y*mode.Y.Y)  
			newSize=Vector2.new(math.clamp(newSize.X,min.X,max.X),math.clamp(newSize.Y,min.Y,max.Y))  
			  
			local anchorOffset=Vector2.new(tab.AnchorPoint.X*size.X,tab.AnchorPoint.Y*size.Y)  
			local newAnchorOffset=Vector2.new(tab.AnchorPoint.X*newSize.X,tab.AnchorPoint.Y*newSize.Y)  
			local deltaAnchorOffset=newAnchorOffset-anchorOffset  
			  
			tab.Size=UDim2.new(0,newSize.X,0,newSize.Y)  
			tab.Position=UDim2.new(uiPos.X.Scale,uiPos.X.Offset+deltaAnchorOffset.X*mode.X.X,uiPos.Y.Scale,uiPos.Y.Offset+deltaAnchorOffset.Y*mode.Y.Y)  
		end  
	end  
	  
	c(Player.Mouse.Move,function()  
		if Type then resize(Vector2.new(Player.Mouse.X,Player.Mouse.Y)-mousePos) end  
	end)  
end)

end

local Screen,Components
if identifyexecutor then
Screen=Services.Insert:LoadLocalAsset("rbxassetid://18490507748")
Blur=loadstring(game:HttpGet("https://pastefy.app/LgV0m8yg/raw"))()
else
Screen=script.Parent
Blur=require(script.Blur)
end

Screen.Main.Visible=false
xpcall(function() Screen.Parent=game.CoreGui end,function() Screen.Parent=Player.GUI end)

Components=Screen:FindFirstChild("Components")
local Library,StoredInfo,Animations,Blurs={},{Sections={},Tabs={}},{},{}

function Animations:Open(window,transparency,useCurrentSize)
local original=(useCurrentSize and window.Size) or Setup.Size
local multiplied=Multiply(original,1.1)
local shadow=window:FindFirstChildOfClass("UIStroke")

SetProperty(shadow,{Transparency=1})  
SetProperty(window,{Size=multiplied,GroupTransparency=1,Visible=true})  
  
Tween(shadow,.25,{Transparency=0.5})  
Tween(window,.25,{Size=original,GroupTransparency=transparency or 0})

end

function Animations:Close(window)
local original,multiplied=window.Size,Multiply(window.Size,1.1)
local shadow=window:FindFirstChildOfClass("UIStroke")

SetProperty(window,{Size=original})  
Tween(shadow,.25,{Transparency=1})  
Tween(window,.25,{Size=multiplied,GroupTransparency=1})  
  
task.wait(.25)  
window.Size,window.Visible=original,false

end

function Animations:Component(component,custom)
c(component.InputBegan,function()
if custom then
Tween(component,.25,{Transparency=.85})
else
Tween(component,.25,{BackgroundColor3=Color(Theme.Component,5,Setup.ThemeMode)})
end
end)

c(component.InputEnded,function()  
	if custom then  
		Tween(component,.25,{Transparency=1})  
	else  
		Tween(component,.25,{BackgroundColor3=Theme.Component})  
	end  
end)

end

function Library:CreateWindow(settings)
local window,sidebar,holder,bg=cl(Screen:WaitForChild("Main")),nil,nil,nil
sidebar,holder,bg=window:FindFirstChild("Sidebar"),window:FindFirstChild("Main"),window:FindFirstChild("BackgroundShadow")
local tab=sidebar:FindFirstChild("Tab")

local options,examples,opened,maximized,blurEnabled={},{},true,false,false  
  
for _,example in pairs(window:GetDescendants()) do  
	if example.Name:find("Example") and not examples[example.Name] then  
		examples[example.Name]=example  
	end  
end  
  
Drag(window)  
Resizeable(window,Vector2.new(300,200),Vector2.new(9e9,9e9))  
Setup.Transparency,Setup.Size,Setup.ThemeMode=settings.Transparency or 0,settings.Size,settings.Theme or "Dark"  
  
if settings.Blurring then  
	Blurs[settings.Title]=Blur.new(window,5)  
	blurEnabled=true  
end  
  
if settings.MinimizeKeybind then Setup.Keybind=settings.MinimizeKeybind end  
  
local function close()  
	if opened then  
		if blurEnabled then Blurs[settings.Title].root.Parent=nil end  
		opened=false  
		Animations:Close(window)  
		window.Visible=false  
	else  
		Animations:Open(window,Setup.Transparency)  
		opened=true  
		if blurEnabled then Blurs[settings.Title].root.Parent=workspace.CurrentCamera end  
	end  
end  
  
for _,button in pairs(sidebar.Top.Buttons:GetChildren()) do  
	if button:IsA("TextButton") then  
		local name=button.Name  
		Animations:Component(button,true)  
		  
		c(button.MouseButton1Click,function()  
			if name=="Close" then  
				close()  
			elseif name=="Maximize" then  
				if maximized then  
					maximized=false  
					Tween(window,.15,{Size=Setup.Size})  
				else  
					maximized=true  
					Tween(window,.15,{Size=UDim2.fromScale(1,1),Position=UDim2.fromScale(0.5,0.5)})  
				end  
			elseif name=="Minimize" then  
				opened=false  
				window.Visible=false  
				if blurEnabled then Blurs[settings.Title].root.Parent=nil end  
			end  
		end)  
	end  
end  
  
Services.Input.InputBegan:Connect(function(input,focused)  
	if (input==Setup.Keybind or input.KeyCode==Setup.Keybind) and not focused then close() end  
end)  
  
function options:SetTab(name)  
	for _,button in pairs(tab:GetChildren()) do  
		if button:IsA("TextButton") then  
			local opened,sameName=button.Value,button.Name==name  
			local padding=button:FindFirstChildOfClass("UIPadding")  
			  
			if sameName and not opened.Value then  
				Tween(padding,.25,{PaddingLeft=UDim.new(0,25)})  
				Tween(button,.25,{BackgroundTransparency=0.9,Size=UDim2.new(1,-15,0,30)})  
				SetProperty(opened,{Value=true})  
			elseif not sameName and opened.Value then  
				Tween(padding,.25,{PaddingLeft=UDim.new(0,20)})  
				Tween(button,.25,{BackgroundTransparency=1,Size=UDim2.new(1,-44,0,30)})  
				SetProperty(opened,{Value=false})  
			end  
		end  
	end  
	  
	for _,main in pairs(holder:GetChildren()) do  
		if main:IsA("CanvasGroup") then  
			local opened,sameName=main.Value,main.Name==name  
			local scroll=main:FindFirstChild("ScrollingFrame")  
			  
			if sameName and not opened.Value then  
				opened.Value,main.Visible=true,true  
				Tween(main,.3,{GroupTransparency=0})  
				Tween(scroll.UIPadding,.3,{PaddingTop=UDim.new(0,5)})  
			elseif not sameName and opened.Value then  
				opened.Value=false  
				Tween(main,.15,{GroupTransparency=1})  
				Tween(scroll.UIPadding,.15,{PaddingTop=UDim.new(0,15)})  
				task.delay(.2,function() main.Visible=false end)  
			end  
		end  
	end  
end  
  
function options:AddTabSection(s)  
	local example,section=examples.SectionExample,cl(examples.SectionExample)  
	StoredInfo.Sections[s.Name]=s.Order  
	SetProperty(section,{Parent=example.Parent,Text=s.Name,Name=s.Name,LayoutOrder=s.Order,Visible=true})  
end  
  
function options:AddTab(s)  
	if StoredInfo.Tabs[s.Title] then error("[UI LIB]: Tab already exists") end  
	  
	local example,mainExample=examples.TabButtonExample,examples.MainExample  
	local section,main,tab=StoredInfo.Sections[s.Section],cl(mainExample),cl(example)  
	  
	if not s.Icon then d(tab.ICO) else SetProperty(tab.ICO,{Image=s.Icon}) end  
	  
	StoredInfo.Tabs[s.Title]={tab}  
	SetProperty(tab.TextLabel,{Text=s.Title})  
	SetProperty(main,{Parent=mainExample.Parent,Name=s.Title})  
	SetProperty(tab,{Parent=example.Parent,LayoutOrder=section or #StoredInfo.Sections+1,Name=s.Title,Visible=true})  
	  
	tab.MouseButton1Click:Connect(function() options:SetTab(tab.Name) end)  
	return main.ScrollingFrame  
end  
  
function options:Notify(s)  
	local notification,title,description,timer=cl(Components.Notification),nil,nil,nil  
	title,description=options:GetLabels(notification)  
	timer=notification.Timer  
	  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(notification,{Parent=Screen.Frame})  
	  
	task.spawn(function()  
		local duration=s.Duration or 2  
		Animations:Open(notification,Setup.Transparency,true)  
		Tween(timer,duration,{Size=UDim2.new(0,0,0,4)})  
		task.wait(duration)  
		Animations:Close(notification)  
		task.wait(1)  
		notification:Destroy()  
	end)  
end  
  
function options:GetLabels(component)  
	local labels=component:FindFirstChild("Labels")  
	return labels.Title,labels.Description  
end  
  
function options:AddSection(s)  
	local section=cl(Components.Section)  
	SetProperty(section,{Text=s.Name,Parent=s.Tab,Visible=true})  
end  
  
function options:AddButton(s)  
	local button,title,description=cl(Components.Button),nil,nil  
	title,description=options:GetLabels(button)  
	  
	c(button.MouseButton1Click,s.Callback)  
	Animations:Component(button)  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(button,{Name=s.Title,Parent=s.Tab,Visible=true})  
end  
  
function options:AddInput(s)  
	local input,title,description=cl(Components.Input),nil,nil  
	title,description=options:GetLabels(input)  
	local textBox=input.Main.Input  
	  
	c(input.MouseButton1Click,function() textBox:CaptureFocus() end)  
	c(textBox.FocusLost,function() s.Callback(textBox.Text) end)  
	  
	Animations:Component(input)  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(input,{Name=s.Title,Parent=s.Tab,Visible=true})  
end  
  
function options:AddToggle(s)  
	local toggle,title,description=cl(Components.Toggle),nil,nil  
	title,description=options:GetLabels(toggle)  
	  
	local on,main,circle=toggle.Value,toggle.Main,toggle.Main.Circle  
	  
	local function set(value)  
		if value then  
			Tween(main,.2,{BackgroundColor3=Color3.fromRGB(153,155,255)})  
			Tween(circle,.2,{BackgroundColor3=Color3.fromRGB(255,255,255),Position=UDim2.new(1,-16,0.5,0)})  
		else  
			Tween(main,.2,{BackgroundColor3=Theme.Interactables})  
			Tween(circle,.2,{BackgroundColor3=Theme.Primary,Position=UDim2.new(0,3,0.5,0)})  
		end  
		on.Value=value  
	end  
	  
	c(toggle.MouseButton1Click,function()  
		local value=not on.Value  
		set(value)  
		s.Callback(value)  
	end)  
	  
	Animations:Component(toggle)  
	set(s.Default)  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(toggle,{Name=s.Title,Parent=s.Tab,Visible=true})  
end  
  
function options:AddKeybind(s)  
	local dropdown,title,description=cl(Components.Keybind),nil,nil  
	title,description=options:GetLabels(dropdown)  
	local bind=dropdown.Main.Options  
	  
	local mouse={Enum.UserInputType.MouseButton1,Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3}  
	local types={Mouse="Enum.UserInputType.MouseButton",Key="Enum.KeyCode."}  
	  
	c(dropdown.MouseButton1Click,function()  
		local time,detect,finished=tick(),nil,nil  
		  
		SetProperty(bind,{Text="..."})  
		detect=c(game.UserInputService.InputBegan,function(key,focused)  
			local inputType=key.UserInputType  
			  
			if not finished and not focused then  
				finished=true  
				  
				if table.find(mouse,inputType) then  
					s.Callback(key)  
					SetProperty(bind,{Text=tostring(inputType):gsub(types.Mouse,"MB")})  
				elseif inputType==Enum.UserInputType.Keyboard then  
					s.Callback(key)  
					SetProperty(bind,{Text=tostring(key.KeyCode):gsub(types.Key,"")})  
				end  
			end  
		end)  
	end)  
	  
	Animations:Component(dropdown)  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(dropdown,{Name=s.Title,Parent=s.Tab,Visible=true})  
end  
  
function options:AddDropdown(s)  
	local dropdown,title,description=cl(Components.Dropdown),nil,nil  
	title,description=options:GetLabels(dropdown)  
	local text=dropdown.Main.Options  
	  
	c(dropdown.MouseButton1Click,function()  
		local example,buttons=cl(examples.DropdownExample),nil  
		buttons=example.Top.Buttons  
		  
		Tween(bg,.25,{BackgroundTransparency=0.6})  
		SetProperty(example,{Parent=window})  
		Animations:Open(example,0,true)  
		  
		for _,button in pairs(buttons:GetChildren()) do  
			if button:IsA("TextButton") then  
				Animations:Component(button,true)  
				c(button.MouseButton1Click,function()  
					Tween(bg,.25,{BackgroundTransparency=1})  
					Animations:Close(example)  
					task.wait(2)  
					d(example)  
				end)  
			end  
		end  
		  
		for index,option in pairs(s.Options) do  
			local button,title,description=cl(examples.DropdownButtonExample),nil,nil  
			title,description=options:GetLabels(button)  
			local selected=button.Value  
			  
			Animations:Component(button)  
			SetProperty(title,{Text=index})  
			SetProperty(button,{Parent=example.ScrollingFrame,Visible=true})  
			d(description)  
			  
			c(button.MouseButton1Click,function()  
				local newValue=not selected.Value  
				  
				if newValue then  
					Tween(button,.25,{BackgroundColor3=Theme.Interactables})  
					s.Callback(option)  
					text.Text=index  
					  
					for _,others in pairs(example:GetChildren()) do  
						if others:IsA("TextButton") and others~=button then  
							others.BackgroundColor3=Theme.Component  
						end  
					end  
				else  
					Tween(button,.25,{BackgroundColor3=Theme.Component})  
				end  
				  
				selected.Value=newValue  
				Tween(bg,.25,{BackgroundTransparency=1})  
				Animations:Close(example)  
				task.wait(2)  
				d(example)  
			end)  
		end  
	end)  
	  
	Animations:Component(dropdown)  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(dropdown,{Name=s.Title,Parent=s.Tab,Visible=true})  
end  
  
function options:AddSlider(s)  
	local slider,title,description=cl(Components.Slider),nil,nil  
	title,description=options:GetLabels(slider)  
	  
	local main,amount,slide,fire,fill,circle=slider.Slider,slider.Slider.Main.Input,slider.Slider.Slide,slider.Slider.Slide.Fire,slider.Slider.Slide.Highlight,slider.Slider.Slide.Highlight.Circle  
	local active,value=false,0  
	  
	local function setNumber(number)  
		if s.AllowDecimals then  
			local power=10^(s.DecimalAmount or 2)  
			number=math.floor(number*power+0.5)/power  
		else  
			number=math.round(number)  
		end  
		return number  
	end  
	  
	local function update(number)  
		local scale=(Player.Mouse.X-slide.AbsolutePosition.X)/slide.AbsoluteSize.X  
		scale=(scale>1 and 1) or (scale<0 and 0) or scale  
		  
		if number then  
			number=(number>s.MaxValue and s.MaxValue) or (number<0 and 0) or number  
		end  
		  
		value=setNumber(number or (scale*s.MaxValue))  
		amount.Text=value  
		fill.Size=UDim2.fromScale((number and number/s.MaxValue) or scale,1)  
		s.Callback(value)  
	end  
	  
	local function activate()  
		active=true  
		repeat task.wait() update() until not active  
	end  
	  
	c(amount.FocusLost,function() update(tonumber(amount.Text) or 0) end)  
	c(fire.MouseButton1Down,activate)  
	c(Services.Input.InputEnded,function(input)  
		if input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch then  
			active=false  
		end  
	end)  
	  
	fill.Size=UDim2.fromScale(value,1)  
	Animations:Component(slider)  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(slider,{Name=s.Title,Parent=s.Tab,Visible=true})  
end  
  
function options:AddParagraph(s)  
	local paragraph,title,description=cl(Components.Paragraph),nil,nil  
	title,description=options:GetLabels(paragraph)  
	  
	SetProperty(title,{Text=s.Title})  
	SetProperty(description,{Text=s.Description})  
	SetProperty(paragraph,{Parent=s.Tab,Visible=true})  
end  
  
local themes={  
	Names={  
		Paragraph=function(l) if l:IsA("TextButton") then l.BackgroundColor3=Color(Theme.Component,5,"Dark") end end,  
		Title=function(l) if l:IsA("TextLabel") then l.TextColor3=Theme.Title end end,  
		Description=function(l) if l:IsA("TextLabel") then l.TextColor3=Theme.Description end end,  
		Section=function(l) if l:IsA("TextLabel") then l.TextColor3=Theme.Title end end,  
		Options=function(l) if l:IsA("TextLabel") and l.Parent.Name=="Main" then l.TextColor3=Theme.Title end end,  
		Notification=function(l) if l:IsA("CanvasGroup") then l.BackgroundColor3,l.UIStroke.Color=Theme.Primary,Theme.Outline end end,  
		TextLabel=function(l) if l:IsA("TextLabel") and l.Parent:FindFirstChild("List") then l.TextColor3=Theme.Tab end end,  
		Main=function(l)  
			if l:IsA("Frame") then  
				if l.Parent==window then  
					l.BackgroundColor3=Theme.Secondary  
				elseif l.Parent:FindFirstChild("Value") then  
					local toggle,circle=l.Parent.Value,l:FindFirstChild("Circle")  
					if not toggle.Value then l.BackgroundColor3,l.Circle.BackgroundColor3=Theme.Interactables,Theme.Primary end  
				else  
					l.BackgroundColor3=Theme.Interactables  
				end  
			elseif l:FindFirstChild("Padding") then  
				l.TextColor3=Theme.Title  
			end  
		end,  
		Amount=function(l) if l:IsA("Frame") then l.BackgroundColor3=Theme.Interactables end end,  
		Slide=function(l) if l:IsA("Frame") then l.BackgroundColor3=Theme.Interactables end end,  
		Input=function(l)  
			if l:IsA("TextLabel") then  
				l.TextColor3=Theme.Title  
			elseif l:FindFirstChild("Labels") then  
				l.BackgroundColor3=Theme.Component  
			elseif l:IsA("TextBox") and l.Parent.Name=="Main" then  
				l.TextColor3=Theme.Title  
			end  
		end,  
		Outline=function(s) if s:IsA("UIStroke") then s.Color=Theme.Outline end end,  
		DropdownExample=function(l) l.BackgroundColor3=Theme.Secondary end,  
		Underline=function(l) if l:IsA("Frame") then l.BackgroundColor3=Theme.Outline end end  
	},  
	Classes={  
		ImageLabel=function(l) if l.Image~="rbxassetid://6644618143" then l.ImageColor3=Theme.Icon end end,  
		TextLabel=function(l) if l:FindFirstChild("Padding") then l.TextColor3=Theme.Title end end,  
		TextButton=function(l) if l:FindFirstChild("Labels") then l.BackgroundColor3=Theme.Component end end,  
		ScrollingFrame=function(l) l.ScrollBarImageColor3=Theme.Component end  
	}  
}  
  
function options:SetTheme(info)  
	Theme=info or Theme  
	window.BackgroundColor3,holder.BackgroundColor3,window.UIStroke.Color=Theme.Primary,Theme.Secondary,Theme.Shadow  
	  
	for _,descendant in pairs(Screen:GetDescendants()) do  
		local name,class=themes.Names[descendant.Name],themes.Classes[descendant.ClassName]  
		if name then name(descendant) elseif class then class(descendant) end  
	end  
end  
  
function options:SetSetting(setting,value)  
	if setting=="Size" then  
		window.Size,Setup.Size=value,value  
	elseif setting=="Transparency" then  
		window.GroupTransparency,Setup.Transparency=value,value  
		for _,notification in pairs(Screen:GetDescendants()) do  
			if notification:IsA("CanvasGroup") and notification.Name=="Notification" then  
				notification.GroupTransparency=value  
			end  
		end  
	elseif setting=="Blur" then  
		local alreadyBlurred,root=Blurs[settings.Title],nil  
		if alreadyBlurred then root=Blurs[settings.Title].root end  
		  
		if value then  
			blurEnabled=true  
			if not alreadyBlurred or not root then  
				Blurs[settings.Title]=Blur.new(window,5)  
			elseif root and not root.Parent then  
				root.Parent=workspace.CurrentCamera  
			end  
		elseif not value and (alreadyBlurred and root and root.Parent) then  
			root.Parent,blurEnabled=nil,false  
		end  
	elseif setting=="Theme" and typeof(value)=="table" then  
		options:SetTheme(value)  
	elseif setting=="Keybind" then  
		Setup.Keybind=value  
	else  
		warn("Invalid setting or not changeable.")  
	end  
end  
  
SetProperty(window,{Size=settings.Size,Visible=true,Parent=Screen})  
Animations:Open(window,settings.Transparency or 0)  
  
return options

end

return Library

