-- ZAPORIUM KEY SYSTEM (Optimized with Get Key, Verify Key, Copy Link Feedback, and Verifying Indicator)
-- Keeps the exact same visual design as before, only enhances functionality.

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
    continueBtn.Text = "Verify Key"
    continueBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    continueBtn.Font = Enum.Font.GothamBold
    continueBtn.TextSize = 18
    continueBtn.Parent = mainFrame

    local continueCorner = Instance.new("UICorner")
    continueCorner.CornerRadius = UDim.new(0, 8)
    continueCorner.Parent = continueBtn

    -- Get Key button (left)
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.44, -5, 0, 30)
    getKeyBtn.Position = UDim2.new(0.05, 0, 1, -40)
    getKeyBtn.BackgroundTransparency = 1
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 15
    getKeyBtn.Parent = mainFrame

    -- Indicator label (right, shows Verifying... or Link Copied!)
    local indicatorLabel = Instance.new("TextLabel")
    indicatorLabel.Size = UDim2.new(0.44, -5, 0, 30)
    indicatorLabel.Position = UDim2.new(0.51, 5, 1, -40)
    indicatorLabel.BackgroundTransparency = 1
    indicatorLabel.Text = ""
    indicatorLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    indicatorLabel.Font = Enum.Font.Gotham
    indicatorLabel.TextSize = 14
    indicatorLabel.TextXAlignment = Enum.TextXAlignment.Right
    indicatorLabel.Parent = mainFrame

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
        if key == "" or key == "Enter key..." then
            keyBox.PlaceholderText = "Please enter a key!"
            return
        end

        -- Show verifying indicator
        indicatorLabel.Text = "Verifying your key..."
        indicatorLabel.TextColor3 = Color3.fromRGB(255, 200, 0)

        -- Simulate verification (or call your real ValidateKey)
        if self.ValidateKey(key) then
            indicatorLabel.Text = "Key verified!"
            indicatorLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            wait(0.8)
            screenGui:Destroy()
            self.OnSuccess()
        else
            indicatorLabel.Text = "Invalid key!"
            indicatorLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
            keyBox.Text = ""
            keyBox.PlaceholderText = "Invalid key! Try again."
            wait(2)
            indicatorLabel.Text = ""
        end
    end)

    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("https://your-key-link-here.com")  -- <<< REPLACE WITH YOUR ACTUAL KEY LINK
        indicatorLabel.Text = "Link copied!"
        indicatorLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(2)
        indicatorLabel.Text = ""
    end)

    discordBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/your-discord-invite")  -- <<< REPLACE WITH YOUR DISCORD INVITE
        -- Optional: show feedback
        indicatorLabel.Text = "Discord link copied!"
        indicatorLabel.TextColor3 = Color3.fromRGB(100, 180, 255)
        wait(2)
        indicatorLabel.Text = ""
    end)

    -- Optional fade-in
    mainFrame.BackgroundTransparency = 1
    TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
end

return KeySystem
