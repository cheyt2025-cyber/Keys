-- ZAPORIUM KEY SYSTEM
-- A custom key system UI designed to match common Roblox exploit key system styles (dark theme, centered frame, welcome message, key input, continue/receive/check buttons, and discord link).
-- This script creates the GUI and handles key validation.
-- It is compatible with your loader: your loader should call this as local KeySystem = loadstring(game:HttpGet("YOUR_RAW_URL_HERE"))() and then KeySystem.new({ ValidateKey = your_function, OnSuccess = your_function })

local KeySystem = {}
KeySystem.__index = KeySystem

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

function KeySystem.new(config)
    local self = setmetatable({}, KeySystem)
    
    self.ValidateKey = config.ValidateKey or function(key) return true end
    self.OnSuccess = config.OnSuccess or function() end
    
    self:CreateUI()
    return self
end

function KeySystem:CreateUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = CoreGui
    screenGui.Name = "ZaporiumKeySystem"
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 300)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "ZAPORIUM KEY SYSTEM"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = mainFrame

    local welcomeDesc = Instance.new("TextLabel")
    welcomeDesc.Size = UDim2.new(1, -40, 0, 60)
    welcomeDesc.Position = UDim2.new(0, 20, 0, 50)
    welcomeDesc.BackgroundTransparency = 1
    welcomeDesc.Text = "Welcome back!\nEnter your key to continue using Zaporium Hub.\nNormal keys last 24 hours, ZAPFREE is instant delete on leave."
    welcomeDesc.TextColor3 = Color3.fromRGB(200, 200, 200)
    welcomeDesc.Font = Enum.Font.Gotham
    welcomeDesc.TextSize = 16
    welcomeDesc.TextWrapped = true
    welcomeDesc.TextYAlignment = Enum.TextYAlignment.Top
    welcomeDesc.Parent = mainFrame

    local keyBox = Instance.new("TextBox")
    keyBox.Size = UDim2.new(0.9, 0, 0, 40)
    keyBox.Position = UDim2.new(0.05, 0, 0, 120)
    keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Enter key..."
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 18
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = mainFrame

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox

    local continueBtn = Instance.new("TextButton")
    continueBtn.Size = UDim2.new(0.9, 0, 0, 40)
    continueBtn.Position = UDim2.new(0.05, 0, 0, 170)
    continueBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    continueBtn.Text = "Continue"
    continueBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    continueBtn.Font = Enum.Font.GothamBold
    continueBtn.TextSize = 18
    continueBtn.Parent = mainFrame

    local continueCorner = Instance.new("UICorner")
    continueCorner.CornerRadius = UDim.new(0, 8)
    continueCorner.Parent = continueBtn

    local receiveBtn = Instance.new("TextButton")
    receiveBtn.Size = UDim2.new(0.44, -5, 0, 30)
    receiveBtn.Position = UDim2.new(0.05, 0, 1, -40)
    receiveBtn.BackgroundTransparency = 1
    receiveBtn.Text = "Receive Key"
    receiveBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    receiveBtn.Font = Enum.Font.Gotham
    receiveBtn.TextSize = 14
    receiveBtn.Parent = mainFrame

    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.44, -5, 0, 30)
    checkBtn.Position = UDim2.new(0.51, 5, 1, -40)
    checkBtn.BackgroundTransparency = 1
    checkBtn.Text = "Checking Key..."
    checkBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
    checkBtn.Font = Enum.Font.Gotham
    checkBtn.TextSize = 14
    checkBtn.Parent = mainFrame

    local discordBtn = Instance.new("TextButton")
    discordBtn.Size = UDim2.new(0.9, 0, 0, 30)
    discordBtn.Position = UDim2.new(0.05, 0, 1, -80)
    discordBtn.BackgroundTransparency = 1
    discordBtn.Text = "Discord"
    discordBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextSize = 16
    discordBtn.Parent = mainFrame

    -- Functionality
    continueBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text
        if self.ValidateKey(key) then
            screenGui:Destroy()
            self.OnSuccess()
        else
            keyBox.Text = ""
            keyBox.PlaceholderText = "Invalid key! Try again."
        end
    end)

    -- Add your links/actions here (e.g., setclipboard, request to join discord, etc.)
    receiveBtn.MouseButton1Click:Connect(function()
        setclipboard("https://your-key-link-here.com")  -- Replace with your actual key receive link
    end)

    discordBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/your-discord-invite")  -- Replace with your Discord invite
        -- Or use syn.request if available for direct join
    end)

    -- Optional: Fade in animation
    mainFrame.BackgroundTransparency = 1
    TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
end

return KeySystem
