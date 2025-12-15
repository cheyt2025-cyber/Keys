-- ZAPORIUM KEY SYSTEM (GUI Module)
-- This script defines the key system GUI compatible with the provided loader.
-- Place this as ZaporiumKeySystem.lua or load it accordingly.
-- Features: Get Key button, Verify Key button, key input textbox, mobile-optimized, blue theme, notifications.

local ZaporiumKeySystem = {}

function ZaporiumKeySystem.new(config)
    local ValidateKey = config.ValidateKey or function() return false end
    local OnSuccess = config.OnSuccess or function() end

    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local CoreGui = game:GetService("CoreGui")

    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    -- Main ScreenGui (reset on death/rejoin compatible)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaporiumKeySystem"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui  -- Robust for executors

    -- Main Frame (centered, responsive)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 320, 0, 240)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -120)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)  -- Dark primary blue-ish
    MainFrame.BackgroundTransparency = 0.1  -- Semi-transparent
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)  -- Moderate curves, not exaggerated
    UICorner.Parent = MainFrame

    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 40, 70)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 50))
    }
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame

    -- Title
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 50)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ZAPORIUM KEY SYSTEM"
    Title.TextColor3 = Color3.fromRGB(100, 180, 255)  -- Accent blue
    Title.TextSize = 24
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- Description/Instruction
    local Instruction = Instance.new("TextLabel")
    Instruction.Size = UDim2.new(1, -40, 0, 30)
    Instruction.Position = UDim2.new(0.5, 0, 0, 60)
    Instruction.AnchorPoint = Vector2.new(0.5, 0)
    Instruction.BackgroundTransparency = 1
    Instruction.Text = "Enter your key below to continue"
    Instruction.TextColor3 = Color3.fromRGB(200, 200, 255)
    Instruction.TextSize = 16
    Instruction.Font = Enum.Font.Gotham
    Instruction.Parent = MainFrame

    -- Key Input TextBox
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -60, 0, 40)
    KeyBox.Position = UDim2.new(0.5, 0, 0, 110)
    KeyBox.AnchorPoint = Vector2.new(0.5, 0)
    KeyBox.BackgroundColor3 = Color3.fromRGB(40, 50, 80)
    KeyBox.BackgroundTransparency = 0.3
    KeyBox.TextColor3 = Color3.white
    KeyBox.PlaceholderText = "Enter Key Here..."
    KeyBox.Text = ""
    KeyBox.TextSize = 18
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = MainFrame

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 8)
    BoxCorner.Parent = KeyBox

    -- Buttons Frame (for layout)
    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Size = UDim2.new(1, -60, 0, 40)
    ButtonsFrame.Position = UDim2.new(0.5, 0, 1, -60)
    ButtonsFrame.AnchorPoint = Vector2.new(0.5, 1)
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Parent = MainFrame

    -- Get Key Button
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0.48, 0, 1, 0)
    GetKeyBtn.Position = UDim2.new(0, 0, 0, 0)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(30, 60, 120)  -- Secondary blue
    GetKeyBtn.BackgroundTransparency = 0.2
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.TextColor3 = Color3.white
    GetKeyBtn.TextSize = 18
    GetKeyBtn.Font = Enum.Font.GothamSemibold
    GetKeyBtn.Parent = ButtonsFrame

    local GetCorner = Instance.new("UICorner")
    GetCorner.CornerRadius = UDim.new(0, 8)
    GetCorner.Parent = GetKeyBtn

    -- Verify Key Button
    local VerifyBtn = Instance.new("TextButton")
    VerifyBtn.Size = UDim2.new(0.48, 0, 1, 0)
    VerifyBtn.Position = UDim2.new(1, 0, 0, 0)
    VerifyBtn.AnchorPoint = Vector2.new(1, 0)
    VerifyBtn.BackgroundColor3 = Color3.fromRGB(50, 100, 200)  -- Primary blue
    VerifyBtn.BackgroundTransparency = 0.2
    VerifyBtn.Text = "Verify Key"
    VerifyBtn.TextColor3 = Color3.white
    VerifyBtn.TextSize = 18
    VerifyBtn.Font = Enum.Font.GothamSemibold
    VerifyBtn.Parent = ButtonsFrame

    local VerifyCorner = Instance.new("UICorner")
    VerifyCorner.CornerRadius = UDim.new(0, 8)
    VerifyCorner.Parent = VerifyBtn

    -- Notification Function (complements theme)
    local function Notify(text, success)
        local Notif = Instance.new("Frame")
        Notif.Size = UDim2.new(0, 300, 0, 60)
        Notif.Position = UDim2.new(0.5, -150, 0, -80)
        Notif.BackgroundColor3 = success and Color3.fromRGB(50, 150, 50) or Color3.fromRGB(150, 50, 50)
        Notif.BackgroundTransparency = 0.2
        Notif.Parent = ScreenGui

        local NotifCorner = Instance.new("UICorner")
        NotifCorner.CornerRadius = UDim.new(0, 10)
        NotifCorner.Parent = Notif

        local NotifText = Instance.new("TextLabel")
        NotifText.Size = UDim2.new(1, 0, 1, 0)
        NotifText.BackgroundTransparency = 1
        NotifText.Text = text
        NotifText.TextColor3 = Color3.white
        NotifText.TextSize = 18
        NotifText.Font = Enum.Font.GothamBold
        NotifText.Parent = Notif

        -- Animate in/out
        TweenService:Create(Notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -150, 0, 20)}):Play()
        task.wait(3)
        TweenService:Create(Notif, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {Position = UDim2.new(0.5, -150, 0, -80)}):Play()
        task.wait(0.6)
        Notif:Destroy()
    end

    -- Button Interactions (hover effect)
    local function addHover(btn)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
        end)
    end

    addHover(GetKeyBtn)
    addHover(VerifyBtn)

    -- Get Key Action (replace with your actual key link)
    GetKeyBtn.MouseButton1Click:Connect(function()
        Notify("Copied key link to clipboard! (Replace with actual link)", true)
        setclipboard("https://example.com/get-zaporium-key")  -- CHANGE THIS TO YOUR KEY LINK
    end)

    -- Verify Action
    VerifyBtn.MouseButton1Click:Connect(function()
        local key = KeyBox.Text:gsub("%s+", ""):upper()
        if key == "" then
            Notify("Please enter a key!", false)
            return
        end

        if ValidateKey(key) then
            Notify("Key Valid! Loading...", true)
            task.wait(0.5)
            ScreenGui:Destroy()
            OnSuccess()
        else
            Notify("Invalid Key!", false)
        end
    end)

    -- Mobile optimization: larger touch targets, auto-focus support
    -- UIListLayout not needed, manual positions work responsively with fixed pixel sizes (good balance for mobile/PC)

    return {}  -- Module returns empty table as per common pattern
end

return ZaporiumKeySystem
