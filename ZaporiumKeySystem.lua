-- Zaporium Key System - Fully Integrated with Your Website
-- Users click "Get Key" → opens your key page → after LootLabs → gets key

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ZaporiumKeyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.BorderSizePixel = 0
frame.Visible = false
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "ZAPORIUM HUB"
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.Parent = frame

local desc = Instance.new("TextLabel")
desc.Size = UDim2.new(1, -20, 0, 60)
desc.Position = UDim2.new(0, 10, 0, 50)
desc.BackgroundTransparency = 1
desc.Text = "You need a key to use Zaporium Hub.\nClick the button below to get one."
desc.TextColor3 = Color3.fromRGB(200, 200, 200)
desc.Font = Enum.Font.Gotham
desc.TextSize = 16
desc.TextWrapped = true
desc.Parent = frame

local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0, 260, 0, 50)
getKeyButton.Position = UDim2.new(0.5, -130, 0, 130)
getKeyButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
getKeyButton.Text = "GET KEY"
getKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyButton.Font = Enum.Font.GothamBold
getKeyButton.TextSize = 20
getKeyButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = getKeyButton

-- Hover effect
getKeyButton.MouseEnter:Connect(function()
    TweenService:Create(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
end)
getKeyButton.MouseLeave:Connect(function()
    TweenService:Create(getKeyButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
end)

-- MAIN: Open your key website when clicked
getKeyButton.MouseButton1Click:Connect(function()
    -- YOUR KEY SYSTEM LINK (the one with LootLabs)
    local keyLink = "https://cheyt2025-cyber.github.io/Keysystem/"
    -- Works on all executors that support request/setclipboard
    if syn and syn.request then
        syn.request({Url = keyLink})
    elseif request then
        request({Url = keyLink, Method = "GET"})
    elseif setclipboard then
        setclipboard(keyLink)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Zaporium Hub";
            Text = "Key link copied to clipboard!";
            Duration = 5;
        })
    end
end)

-- Show GUI
frame.Visible = true

-- Optional: Auto-remove GUI after a few seconds if you want
-- wait(10)
-- screenGui:Destroy()
