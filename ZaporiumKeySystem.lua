-- ZAPORIUM KEY SYSTEM (GUI ONLY)
-- UI Only | Mobile Optimized | Loader Compatible

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Destroy existing if reloaded
if PlayerGui:FindFirstChild("ZaporiumKeySystem") then
	PlayerGui.ZaporiumKeySystem:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ZaporiumKeySystem"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Main Container
local Main = Instance.new("Frame")
Main.Size = UDim2.fromScale(0.88, 0.42)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20, 45, 90) -- Primary Blue (60%)
Main.BackgroundTransparency = 0.12
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local Corner = Instance.new("UICorner", Main)
Corner.CornerRadius = UDim.new(0, 14) -- NOT too smooth

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(90, 140, 220)
Stroke.Thickness = 1.1
Stroke.Transparency = 0.35

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.fromScale(1, 0.22)
Title.BackgroundTransparency = 1
Title.Text = "ZAPORIUM KEY SYSTEM"
Title.Font = Enum.Font.GothamMedium
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(230, 240, 255)
Title.Parent = Main

-- Input Container
local InputHolder = Instance.new("Frame")
InputHolder.Size = UDim2.fromScale(0.88, 0.22)
InputHolder.Position = UDim2.fromScale(0.5, 0.35)
InputHolder.AnchorPoint = Vector2.new(0.5, 0.5)
InputHolder.BackgroundColor3 = Color3.fromRGB(15, 30, 60) -- Secondary (30%)
InputHolder.BackgroundTransparency = 0.18
InputHolder.BorderSizePixel = 0
InputHolder.Parent = Main

local InputCorner = Instance.new("UICorner", InputHolder)
InputCorner.CornerRadius = UDim.new(0, 10)

-- TextBox
local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.fromScale(0.94, 0.7)
KeyBox.Position = UDim2.fromScale(0.5, 0.5)
KeyBox.AnchorPoint = Vector2.new(0.5, 0.5)
KeyBox.PlaceholderText = "Enter your key here..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextScaled = true
KeyBox.TextColor3 = Color3.fromRGB(220, 235, 255)
KeyBox.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
KeyBox.BackgroundTransparency = 0.15
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = InputHolder

local BoxCorner = Instance.new("UICorner", KeyBox)
BoxCorner.CornerRadius = UDim.new(0, 8)

-- Buttons Holder
local ButtonHolder = Instance.new("Frame")
ButtonHolder.Size = UDim2.fromScale(0.88, 0.24)
ButtonHolder.Position = UDim2.fromScale(0.5, 0.68)
ButtonHolder.AnchorPoint = Vector2.new(0.5, 0.5)
ButtonHolder.BackgroundTransparency = 1
ButtonHolder.Parent = Main

local UIList = Instance.new("UIListLayout", ButtonHolder)
UIList.FillDirection = Enum.FillDirection.Horizontal
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.Padding = UDim.new(0.06, 0)

-- Button Template
local function createButton(text)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.fromScale(0.42, 1)
	btn.Text = text
	btn.Font = Enum.Font.GothamMedium
	btn.TextScaled = true
	btn.TextColor3 = Color3.fromRGB(240, 245, 255)
	btn.BackgroundColor3 = Color3.fromRGB(40, 110, 200) -- Accent (10%)
	btn.BackgroundTransparency = 0.08
	btn.BorderSizePixel = 0

	local c = Instance.new("UICorner", btn)
	c.CornerRadius = UDim.new(0, 10)

	local s = Instance.new("UIStroke", btn)
	s.Color = Color3.fromRGB(140, 180, 255)
	s.Transparency = 0.45

	return btn
end

local GetKey = createButton("Get Key")
GetKey.Parent = ButtonHolder

local VerifyKey = createButton("Verify Key")
VerifyKey.Parent = ButtonHolder

-- Notification
local Notify = Instance.new("TextLabel")
Notify.Size = UDim2.fromScale(0.7, 0.12)
Notify.Position = UDim2.fromScale(0.5, 0.95)
Notify.AnchorPoint = Vector2.new(0.5, 1)
Notify.BackgroundColor3 = Color3.fromRGB(30, 90, 170)
Notify.BackgroundTransparency = 0.18
Notify.Text = "Ready"
Notify.Font = Enum.Font.Gotham
Notify.TextScaled = true
Notify.TextColor3 = Color3.fromRGB(230, 240, 255)
Notify.Visible = true
Notify.Parent = Main

local NC = Instance.new("UICorner", Notify)
NC.CornerRadius = UDim.new(0, 8)

-- Hover Feedback (Subtle)
local function hover(btn)
	btn.MouseEnter:Connect(function()
		btn.BackgroundTransparency = 0
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundTransparency = 0.08
	end)
end

hover(GetKey)
hover(VerifyKey)

-- PUBLIC ACCESS FOR LOADER
_G.ZaporiumKeyBox = KeyBox
