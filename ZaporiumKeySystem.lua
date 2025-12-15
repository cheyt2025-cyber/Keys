-- ZAPORIUM KEY SYSTEM (Optimized & Updated)
-- Features:
-- • Clean dark design matching common Roblox key systems
-- • Three main buttons: Get Key (copies link + "Link Copied!" indicator), Verify Key (checks key with loading state), Discord
-- • Verifying indicator: Button text changes to "Verifying..." during check, reverts on finish
-- • Invalid key shows red placeholder feedback
-- • Fully compatible with your existing loader (no changes needed to Loader.lua)

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
    mainFrame.Size = UDim2.new(0, 420, 0, 320)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = "ZAPORIUM KEY SYSTEM"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 26
    title.Parent = mainFrame

    local welcomeDesc = Instance.new("TextLabel")
    welcomeDesc.Size = UDim2.new(1, -40, 0, 70)
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
    keyBox.Size = UDim2.new(0.9, 0, 0, 45)
    keyBox.Position = UDim2.new(0.05, 0, 0, 130)
    keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.PlaceholderText = "Enter key here..."
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 18
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = mainFrame

    local keyCorner = Instance.new("UICorner")
    keyCorner.CornerRadius = UDim.new(0, 8)
    keyCorner.Parent = keyBox

    -- Buttons
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.44, -8, 0, 40)
    getKeyBtn.Position = UDim2.new(0.05, 0, 1, -110)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 18
    getKeyBtn.Parent = mainFrame

    local verifyBtn = Instance.new("TextButton")
    verifyBtn.Size = UDim2.new(0.44, -8, 0, 40)
    verifyBtn.Position = UDim2.new(0.51, 8, 1, -110)
    verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    verifyBtn.Text = "Verify Key"
    verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    verifyBtn.Font = Enum.Font.GothamBold
    verifyBtn.TextSize = 18
    verifyBtn.Parent = mainFrame

    local discordBtn = Instance.new("TextButton")
    discordBtn.Size = UDim2.new(0.9, 0, 0, 40)
    discordBtn.Position = UDim2.new(0.05, 0, 1, -55)
    discordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    discordBtn.Text = "Discord"
    discordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    discordBtn.Font = Enum.Font.GothamBold
    discordBtn.TextSize = 18
    discordBtn.Parent = mainFrame

    -- Button corners
    for _, btn in {getKeyBtn, verifyBtn, discordBtn} do
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn
    end

    -- Functionality
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("https://zaporium-keys.com")  -- <<< CHANGE TO YOUR ACTUAL KEY LINK
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
    end)

    discordBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/yourinvite")  -- <<< CHANGE TO YOUR DISCORD INVITE
        -- Optional: open Discord app if supported in executor
        -- request = syn.request or request
        -- request({Url = "http://127.0.0.1:6463/rpc?v=1", Method = "POST", ...}) -- advanced join
    end)

    verifyBtn.MouseButton1Click:Connect(function()
        local key = keyBox.Text:gsub("%s+", ""):upper()
        if key == "" then
            keyBox.PlaceholderText = "Please enter a key!"
            return
        end

        verifyBtn.Text = "Verifying..."
        verifyBtn.Active = false

        task.spawn(function()
            local success = self.ValidateKey(key)
            
            if success then
                screenGui:Destroy()
                self.OnSuccess()
            else
                keyBox.Text = ""
                keyBox.PlaceholderText = "Invalid Key! Try Again."
                verifyBtn.Text = "Verify Key"
                verifyBtn.Active = true
            end
        end)
    end)

    -- Fade in
    mainFrame.BackgroundTransparency = 1
    for _, obj in ipairs(mainFrame:GetDescendants()) do
        if obj:IsA("GuiObject") then
            obj.BackgroundTransparency = obj.BackgroundTransparency + 1
            obj.TextTransparency = 1
        end
    end
    TweenService:Create(mainFrame, TweenInfo.new(0.6), {BackgroundTransparency = 0}):Play()
end

return KeySystem
