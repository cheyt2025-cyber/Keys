-- ZAPORIUM KEY SYSTEM (Updated with Get Key, Verify Key, and Verifying indicator)
-- Keeps the exact same visual design as before, only changes/replaces the bottom buttons for better functionality.

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

    -- New buttons and indicator (replaces old Receive/Check/Discord layout but keeps similar spacing)
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.44, -5, 0, 35)
    getKeyBtn.Position = UDim2.new(0.05, 0, 1, -80)
    getKeyBtn.BackgroundTransparency = 1
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 16
    getKeyBtn.Parent = mainFrame

    local verifyKeyBtn = Instance.new("TextButton")
    verifyKeyBtn.Size = UDim2.new(0.44, -5, 0, 35)
    verifyKeyBtn.Position = UDim2.new(0.51, 5, 1, -80)
    verifyKeyBtn.BackgroundTransparency = 1
    verifyKeyBtn.Text = "Verify Key"
    verifyKeyBtn.TextColor3 = Color3.fromRGB(100, 180, 255)
    verifyKeyBtn.Font = Enum.Font.GothamBold
    verifyKeyBtn.TextSize = 16
    verifyKeyBtn.Parent = mainFrame

    local indicator = Instance.new("TextLabel")
    indicator.Size = UDim2.new(0.9, 0, 0, 30)
    indicator.Position = UDim2.new(0.05, 0, 1, -40)
    indicator.BackgroundTransparency = 1
    indicator.Text = ""
    indicator.TextColor3 = Color3.fromRGB(255, 255, 255)
    indicator.Font = Enum.Font.Gotham
    indicator.TextSize = 15
    indicator.Parent = mainFrame

    -- Functionality
    continueBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text
        if key == "" then
            keyBox.PlaceholderText = "Please enter a key!"
            return
        end
        
        indicator.Text = "Verifying your key..."
        indicator.TextColor3 = Color3.fromRGB(255, 255, 0) -- Yellow while verifying
        
        wait(1.5) -- Small delay to show the verifying message (feel free to remove or adjust)
        
        if self.ValidateKey(key) then
            indicator.Text = "Key verified successfully!"
            indicator.TextColor3 = Color3.fromRGB(0, 255, 0)
            wait(0.8)
            screenGui:Destroy()
            self.OnSuccess()
        else
            indicator.Text = "Invalid key!"
            indicator.TextColor3 = Color3.fromRGB(255, 0, 0)
            keyBox.Text = ""
            keyBox.PlaceholderText = "Invalid key! Try again."
            wait(2)
            indicator.Text = ""
        end
    end)

    verifyKeyBtn.MouseButton1Click:Connect(function()
        continueBtn.MouseButton1Click:Fire() -- Same as clicking Continue
    end)

    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("https://your-key-link-here.com") -- <<< REPLACE WITH YOUR ACTUAL KEY LINK >>>
        indicator.Text = "Link copied to clipboard!"
        indicator.TextColor3 = Color3.fromRGB(0, 255, 0)
        wait(2)
        indicator.Text = ""
    end)

    -- Optional fade-in
    mainFrame.BackgroundTransparency = 1
    for _, child in pairs(mainFrame:GetChildren()) do
        if child:IsA("GuiObject") then
            child.BackgroundTransparency = 1
            if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                child.TextTransparency = 1
            end
        end
    end
    TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
    -- Fade in children (simple loop)
    spawn(function()
        wait(0.2)
        for _, child in pairs(mainFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                TweenService:Create(child, TweenInfo.new(0.4), {BackgroundTransparency = child.BackgroundTransparency == 1 and 1 or 0}):Play()
                if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
                    TweenService:Create(child, TweenInfo.new(0.4), {TextTransparency = 0}):Play()
                end
            end
        end
    end)
end

return KeySystem
