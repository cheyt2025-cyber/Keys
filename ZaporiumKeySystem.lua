-- ZAPORIUM KEY SYSTEM GUI
-- A clean, mobile-optimized, responsive key system GUI
-- Compatible with your Loader.lua (expects .new({ValidateKey = function(key), OnSuccess = function()}))

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ZaporiumKeySystem = {}
ZaporiumKeySystem.__index = ZaporiumKeySystem

function ZaporiumKeySystem.new(config)
    local self = setmetatable({}, ZaporiumKeySystem)
    
    self.ValidateKey = config.ValidateKey or function() return false end
    self.OnSuccess = config.OnSuccess or function() end
    
    self:CreateGUI()
    return self
end

function ZaporiumKeySystem:CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaporiumKeySystem"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Main Frame - responsive size, centered
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0.35, 0, 0.45, 0) -- Good balance for all devices
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 50) -- Dark blue base (60%)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12) -- Slight curve, not too smooth/AI-like
    UICorner.Parent = MainFrame
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 30, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 20, 40))
    }
    UIGradient.Rotation = 90
    UIGradient.Parent = MainFrame
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0.2, 0)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ZAPORIUM KEY SYSTEM"
    Title.TextColor3 = Color3.fromRGB(100, 180, 255) -- Light blue (30%)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 28
    Title.TextScaled = true
    Title.Parent = MainFrame
    
    -- Description / Status
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "Status"
    StatusLabel.Size = UDim2.new(0.9, 0, 0.15, 0)
    StatusLabel.Position = UDim2.new(0.5, 0, 0.25, 0)
    StatusLabel.AnchorPoint = Vector2.new(0.5, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Enter your key below"
    StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextSize = 18
    StatusLabel.TextScaled = true
    StatusLabel.Parent = MainFrame
    self.StatusLabel = StatusLabel
    
    -- Key TextBox
    local KeyBox = Instance.new("TextBox")
    KeyBox.Name = "KeyBox"
    KeyBox.Size = UDim2.new(0.8, 0, 0.12, 0)
    KeyBox.Position = UDim2.new(0.5, 0, 0.45, 0)
    KeyBox.AnchorPoint = Vector2.new(0.5, 0)
    KeyBox.BackgroundColor3 = Color3.fromRGB(30, 40, 70) -- Deeper blue
    KeyBox.TextColor3 = Color3.white
    KeyBox.PlaceholderText = "ZAP-XXXX-XXXX-XXXX or ZAPFREE"
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 20
    KeyBox.TextScaled = true
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = MainFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 8)
    BoxCorner.Parent = KeyBox
    
    -- Buttons Frame
    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Size = UDim2.new(0.8, 0, 0.15, 0)
    ButtonsFrame.Position = UDim2.new(0.5, 0, 0.65, 0)
    ButtonsFrame.AnchorPoint = Vector2.new(0.5, 0)
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Parent = MainFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 15)
    UIListLayout.Parent = ButtonsFrame
    
    -- Get Key Button
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Name = "GetKey"
    GetKeyBtn.Size = UDim2.new(0.45, 0, 1, 0)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 100) -- Mid blue
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.TextColor3 = Color3.white
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.TextSize = 22
    GetKeyBtn.TextScaled = true
    GetKeyBtn.LayoutOrder = 1
    GetKeyBtn.Parent = ButtonsFrame
    
    local GetCorner = Instance.new("UICorner")
    GetCorner.CornerRadius = UDim.new(0, 10)
    GetCorner.Parent = GetKeyBtn
    
    -- Verify Key Button
    local VerifyBtn = Instance.new("TextButton")
    VerifyBtn.Name = "Verify"
    VerifyBtn.Size = UDim2.new(0.45, 0, 1, 0)
    VerifyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215) -- Bright blue accent (10%)
    VerifyBtn.Text = "Verify Key"
    VerifyBtn.TextColor3 = Color3.white
    VerifyBtn.Font = Enum.Font.GothamBold
    VerifyBtn.TextSize = 22
    VerifyBtn.TextScaled = true
    VerifyBtn.LayoutOrder = 2
    VerifyBtn.Parent = ButtonsFrame
    
    local VerifyCorner = Instance.new("UICorner")
    VerifyCorner.CornerRadius = UDim.new(0, 10)
    VerifyCorner.Parent = VerifyBtn
    
    -- Interactive effects
    local function addHoverEffect(btn, hoverColor, normalColor)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverColor}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = normalColor}):Play()
        end)
    end
    
    addHoverEffect(GetKeyBtn, Color3.fromRGB(60, 80, 120), Color3.fromRGB(40, 60, 100))
    addHoverEffect(VerifyBtn, Color3.fromRGB(0, 140, 255), Color3.fromRGB(0, 120, 215))
    
    -- Notification System (complements blue theme)
    self.NotificationHolder = Instance.new("Frame")
    self.NotificationHolder.Name = "Notifications"
    self.NotificationHolder.Size = UDim2.new(0.3, 0, 1, 0)
    self.NotificationHolder.Position = UDim2.new(1, -10, 0, 0)
    self.NotificationHolder.BackgroundTransparency = 1
    self.NotificationHolder.Parent = ScreenGui
    
    local NotifList = Instance.new("UIListLayout")
    NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifList.Padding = UDim.new(0, 10)
    NotifList.SortOrder = Enum.SortOrder.LayoutOrder
    NotifList.Parent = self.NotificationHolder
    
    function self:Notify(text, duration, isError)
        duration = duration or 4
        local notif = Instance.new("Frame")
        notif.Size = UDim2.new(1, 0, 0, 60)
        notif.BackgroundColor3 = isError and Color3.fromRGB(180, 40, 40) or Color3.fromRGB(40, 100, 180)
        notif.BorderSizePixel = 0
        notif.LayoutOrder = tick() * -1000 -- Newer on top (but bottom aligned)
        notif.Parent = self.NotificationHolder
        
        local nCorner = Instance.new("UICorner")
        nCorner.CornerRadius = UDim.new(0, 10)
        nCorner.Parent = notif
        
        local nText = Instance.new("TextLabel")
        nText.Size = UDim2.new(1, -20, 1, 0)
        nText.Position = UDim2.new(0, 10, 0, 0)
        nText.BackgroundTransparency = 1
        nText.Text = text
        nText.TextColor3 = Color3.white
        nText.Font = Enum.Font.GothamSemibold
        nText.TextSize = 18
        nText.TextScaled = true
        nText.TextXAlignment = Enum.TextXAlignment.Left
        nText.Parent = notif
        
        -- Slide in/out animation
        notif.Position = UDim2.new(1, 20, notif.Position.Y.Scale, notif.Position.Y.Offset)
        TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(1, -10, notif.Position.Y.Scale, notif.Position.Y.Offset)}):Play()
        
        task.delay(duration, function()
            TweenService:Create(notif, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {Position = UDim2.new(1, 20, notif.Position.Y.Scale, notif.Position.Y.Offset)}):Play()
            task.wait(0.4)
            notif:Destroy()
        end)
    end
    
    -- Get Key link - change to your actual key link!
    GetKeyBtn.MouseButton1Click:Connect(function()
        self:Notify("Opening key link...", 3)
        -- Replace with your actual get key URL
        setclipboard("https://your-key-link-here.com") -- or use request if you have a link opener
        self:Notify("Key link copied to clipboard!", 4)
    end)
    
    -- Verify logic
    VerifyBtn.MouseButton1Click:Connect(function()
        local key = KeyBox.Text:gsub("%s+", ""):upper()
        if key == "" then
            self:Notify("Please enter a key!", 4, true)
            return
        end
        
        StatusLabel.Text = "Validating..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
        
        local valid = self.ValidateKey(key)
        
        if valid then
            StatusLabel.Text = "Key Accepted!"
            StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
            self:Notify("Success! Loading script...", 5)
            task.wait(1)
            ScreenGui:Destroy()
            self.OnSuccess()
        else
            StatusLabel.Text = "Invalid Key"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
            self:Notify("Invalid or expired key. Try again or get a new one.", 6, true)
        end
    end)
    
    -- Enter key press support
    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            VerifyBtn:Activate()
        end
    end)
end

return ZaporiumKeySystem
