local Players=game:GetService("Players")
local RunService=game:GetService("RunService")
local UserInputService=game:GetService("UserInputService")
local LocalPlayer=Players.LocalPlayer
local Mouse=LocalPlayer:GetMouse()
local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="EAS_Menu"
ScreenGui.Parent=game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local ToggleButton=Instance.new("ImageButton")
ToggleButton.Name="MenuToggle"
ToggleButton.Size=UDim2.new(0,50,0,50)
ToggleButton.Position=UDim2.new(0,20,0.5,-25)
ToggleButton.AnchorPoint=Vector2.new(0,0.5)
ToggleButton.BackgroundColor3=Color3.fromRGB(45,45,45)
ToggleButton.Image="rbxassetid://0"
local Stroke=Instance.new("UIStroke")
Stroke.Thickness=2
Stroke.Color=Color3.new(0,0,0)
Stroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
Stroke.Parent=ToggleButton
local Corner=Instance.new("UICorner")
Corner.CornerRadius=UDim.new(1,0)
Corner.Parent=ToggleButton
local ToggleLabel=Instance.new("TextLabel")
ToggleLabel.Size=UDim2.new(1,0,1,0)
ToggleLabel.Text="Меню"
ToggleLabel.BackgroundTransparency=1
ToggleLabel.TextColor3=Color3.new(1,1,1)
ToggleLabel.Parent=ToggleButton
ToggleButton.Parent=ScreenGui
local MenuFrame=Instance.new("Frame")
MenuFrame.Name="MainMenu"
MenuFrame.Size=UDim2.new(0,200,0,250)
MenuFrame.Position=UDim2.new(0,80,0.5,-125)
MenuFrame.AnchorPoint=Vector2.new(0,0.5)
MenuFrame.BackgroundColor3=Color3.fromRGB(35,35,35)
MenuFrame.BackgroundTransparency=0.2
MenuFrame.Visible=false
local MenuStroke=Instance.new("UIStroke")
MenuStroke.Thickness=2
MenuStroke.Color=Color3.new(0,0,0)
MenuStroke.Parent=MenuFrame
local MenuCorner=Instance.new("UICorner")
MenuCorner.CornerRadius=UDim.new(0.2,0)
MenuCorner.Parent=MenuFrame
MenuFrame.Parent=ScreenGui
local UIListLayout=Instance.new("UIListLayout")
UIListLayout.Padding=UDim.new(0,10)
UIListLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
UIListLayout.VerticalAlignment=Enum.VerticalAlignment.Center
UIListLayout.Parent=MenuFrame
local function CreateButton(name,text)
local button=Instance.new("TextButton")
button.Name=name
button.Size=UDim2.new(0.8,0,0,40)
button.BackgroundColor3=Color3.fromRGB(60,60,60)
button.BorderSizePixel=0
button.Text=text
button.TextColor3=Color3.new(1,1,1)
button.ZIndex=2
local buttonCorner=Instance.new("UICorner")
buttonCorner.CornerRadius=UDim.new(0.3,0)
buttonCorner.Parent=button
button.Parent=MenuFrame
return button
end
local ESPPlayerButton=CreateButton("ESPPlayer","1. ESP Player")
local ESPBaseButton=CreateButton("ESPBase","2. ESP a Base")
local AimbotButton=CreateButton("Aimbot","3. Aimbot")
local SizeSkinButton=CreateButton("SizeSkin","4. Size Skin")
ToggleButton.MouseButton1Click:Connect(function()
MenuFrame.Visible=not MenuFrame.Visible
end)
local Modules={
ESPPlayers={Enabled=false,Trackers={}},
ESPBase={Enabled=false,Trackers={},BaseObject=nil},
Aimbot={Enabled=false,Connection=nil,Target=nil},
SizeSkin={Enabled=false,OriginalSize=nil}
}
ESPPlayerButton.MouseButton1Click:Connect(function()
Modules.ESPPlayers.Enabled=not Modules.ESPPlayers.Enabled
if Modules.ESPPlayers.Enabled then
for _,player in ipairs(Players:GetPlayers()) do
if player~=LocalPlayer and player.Character then
local humanoidRootPart=player.Character:FindFirstChild("HumanoidRootPart")
if humanoidRootPart then
local tracker=Instance.new("BillboardGui")
tracker.Name=player.Name.."_ESP"
tracker.Adornee=humanoidRootPart
tracker.Size=UDim2.new(0,100,0,40)
tracker.StudsOffset=Vector3.new(0,2.5,0)
tracker.AlwaysOnTop=true
tracker.MaxDistance=100
tracker.Parent=humanoidRootPart
local nameLabel=Instance.new("TextLabel")
nameLabel.Size=UDim2.new(1,0,0.5,0)
nameLabel.BackgroundTransparency=1
nameLabel.Text=player.Name
nameLabel.TextColor3=Color3.new(1,1,0)
nameLabel.TextStrokeTransparency=0
nameLabel.Parent=tracker
local box=Instance.new("Frame")
box.Size=UDim2.new(2,0,3,0)
box.Position=UDim2.new(-0.5,0,-0.5,0)
box.BackgroundColor3=Color3.fromRGB(255,0,0)
box.BackgroundTransparency=0.5
box.BorderSizePixel=0
box.Parent=tracker
table.insert(Modules.ESPPlayers.Trackers,tracker)
end
end
end
else
for _,tracker in ipairs(Modules.ESPPlayers.Trackers) do
tracker:Destroy()
end
Modules.ESPPlayers.Trackers={}
end
end)
ESPBaseButton.MouseButton1Click:Connect(function()
Modules.ESPBase.Enabled=not Modules.ESPBase.Enabled
if Modules.ESPBase.Enabled then
local base=workspace:FindFirstChild("Base") or workspace:FindFirstChild("TheBase")
if base then
Modules.ESPBase.BaseObject=base
local timerValue=base:FindFirstChild("Timer") or base:FindFirstChild("OpenTimer")
if timerValue and timerValue:IsA("NumberValue") then
local tracker=Instance.new("BillboardGui")
tracker.Adornee=base
tracker.Size=UDim2.new(0,200,0,40)
tracker.StudsOffset=Vector3.new(0,5,0)
tracker.AlwaysOnTop=true
tracker.Parent=base
local timerLabel=Instance.new("TextLabel")
timerLabel.Size=UDim2.new(1,0,1,0)
timerLabel.BackgroundTransparency=1
timerLabel.Text="Base opens in: "..timerValue.Value.."s"
timerLabel.TextColor3=Color3.new(0,1,1)
timerLabel.TextStrokeTransparency=0
timerLabel.Parent=tracker
table.insert(Modules.ESPBase.Trackers,tracker)
local connection
connection=timerValue:GetPropertyChangedSignal("Value"):Connect(function()
timerLabel.Text="Base opens in: "..timerValue.Value.."s"
end)
table.insert(Modules.ESPBase.Trackers,connection)
end
end
else
for _,item in ipairs(Modules.ESPBase.Trackers) do
if item:IsA("BillboardGui") then
item:Destroy()
elseif typeof(item)=="RBXScriptConnection" then
item:Disconnect()
end
end
Modules.ESPBase.Trackers={}
Modules.ESPBase.BaseObject=nil
end
end)
AimbotButton.MouseButton1Click:Connect(function()
Modules.Aimbot.Enabled=not Modules.Aimbot.Enabled
if Modules.Aimbot.Enabled then
Modules.Aimbot.Connection=RunService.Heartbeat:Connect(function()
local closestPlayer=nil
local closestDistance=math.huge
local camera=workspace.CurrentCamera
for _,player in ipairs(Players:GetPlayers()) do
if player~=LocalPlayer and player.Character then
local humanoidRootPart=player.Character:FindFirstChild("HumanoidRootPart")
if humanoidRootPart then
local screenPos,onScreen=camera:WorldToViewportPoint(humanoidRootPart.Position)
if onScreen then
local mousePos=Vector2.new(Mouse.X,Mouse.Y)
local playerPos=Vector2.new(screenPos.X,screenPos.Y)
local distance=(mousePos-playerPos).Magnitude
if distance<closestDistance then
closestDistance=distance
closestPlayer=player
end
end
end
end
end
if closestPlayer and closestPlayer.Character then
local targetRoot=closestPlayer.Character:FindFirstChild("HumanoidRootPart")
if targetRoot then
local tool=LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool")
if tool and tool:FindFirstChild("SetTarget") then
tool.SetTarget:Invoke(targetRoot.Position)
end
end
end
end)
else
if Modules.Aimbot.Connection then
Modules.Aimbot.Connection:Disconnect()
Modules.Aimbot.Connection=nil
end
end
end)
SizeSkinButton.MouseButton1Click:Connect(function()
Modules.SizeSkin.Enabled=not Modules.SizeSkin.Enabled
local character=LocalPlayer.Character
if not character then return end
if Modules.SizeSkin.Enabled then
if not Modules.SizeSkin.OriginalSize then
Modules.SizeSkin.OriginalSize={}
for _,part in ipairs(character:GetChildren()) do
if part:IsA("BasePart") then
Modules.SizeSkin.OriginalSize[part]=part.Size
part.Size=part.Size*0.5
end
end
end
else
if Modules.SizeSkin.OriginalSize then
for part,size in pairs(Modules.SizeSkin.OriginalSize) do
if part.Parent then
part.Size=size
end
end
Modules.SizeSkin.OriginalSize=nil
end
end
end)
