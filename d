local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TeleportGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0,300,0,210)
main.Position = UDim2.new(0.5,-150,0.5,-105)
main.BackgroundColor3 = Color3.fromRGB(35,35,35)
main.BorderSizePixel = 0
main.Parent = gui

Instance.new("UICorner",main).CornerRadius = UDim.new(0,12)

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(25,25,25)
title.Text = "Teleport GUI"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Parent = main
Instance.new("UICorner",title).CornerRadius = UDim.new(0,12)

-- Drag
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

local function CreateBox(y,text)
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0.9,0,0,35)
	box.Position = UDim2.new(0.05,0,y,0)
	box.BackgroundColor3 = Color3.fromRGB(55,55,55)
	box.TextColor3 = Color3.new(1,1,1)
	box.PlaceholderText = "X, Y, Z"
	box.Text = text
	box.Font = Enum.Font.Code
	box.TextSize = 18
	box.Parent = main
	Instance.new("UICorner",box).CornerRadius = UDim.new(0,8)
	return box
end

local box1 = CreateBox(0.28,"-40, 67, 223")
local box2 = CreateBox(0.50,"1997, 23, -834")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.9,0,0,40)
button.Position = UDim2.new(0.05,0,0.75,0)
button.BackgroundColor3 = Color3.fromRGB(0,170,255)
button.Text = "TELEPORT"
button.TextColor3 = Color3.new(1,1,1)
button.Font = Enum.Font.GothamBold
button.TextSize = 22
button.Parent = main
Instance.new("UICorner",button).CornerRadius = UDim.new(0,10)

local function Parse(text)
	local x,y,z = text:match("^%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*,%s*(-?[%d%.]+)%s*$")
	if x then
		return Vector3.new(tonumber(x),tonumber(y),tonumber(z))
	end
end

button.MouseButton1Click:Connect(function()
	local character = player.Character or player.CharacterAdded:Wait()
	local hrp = character:WaitForChild("HumanoidRootPart")

	local pos1 = Parse(box1.Text)
	local pos2 = Parse(box2.Text)

	if pos1 then
		hrp.CFrame = CFrame.new(pos1)
	end

	task.wait(0.2)

	if pos2 then
		hrp.CFrame = CFrame.new(pos2)
	end
end)
