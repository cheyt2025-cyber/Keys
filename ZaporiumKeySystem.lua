-- Zaporium Key System (Custom built for your loader)
-- Save this as ZaporiumKeySystem.lua and host it on GitHub raw (replace the loadstring URL in your loader if needed)

local ZaporiumKeySystem = {}
ZaporiumKeySystem.__index = ZaporiumKeySystem

function ZaporiumKeySystem.new(options)
    local self = setmetatable({}, ZaporiumKeySystem)
    
    self.Title = options.Title or "Key System"
    self.ValidateKey = options.ValidateKey or function(key) return false end
    self.OnSuccess = options.OnSuccess or function() end
    
    self:CreateGUI()
    return self
end

function ZaporiumKeySystem:CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaporiumKeyGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = game:GetService("CoreGui")
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 220)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)  -- Black dominant
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)  -- Small radius, not too smooth (avoid AI look)
    MainCorner.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 50)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White header (60%)
    TitleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    TitleLabel.Text = "ZAPORIUM KEY SYSTEM"
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 24
    TitleLabel.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
    TitleCorner.Parent = TitleLabel
    
    local TopCornerMask = Instance.new("Frame")  -- Masks bottom corners of header
    TopCornerMask.Size = UDim2.new(1, 0, 0, 8)
    TopCornerMask.Position = UDim2.new(0, 0, 1, -8)
    TopCornerMask.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TopCornerMask.BorderSizePixel = 0
    TopCornerMask.Parent = TitleLabel
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -20, 0, 30)
    DescLabel.Position = UDim2.new(0, 10, 0, 55)
    DescLabel.BackgroundTransparency = 1
    DescLabel.TextColor3 = Color3.fromRGB(200, 200, 200)  -- Light grey
    DescLabel.Text = "Enter your key below to access the hub"
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextSize = 16
    DescLabel.Parent = MainFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(1, -40, 0, 40)
    KeyBox.Position = UDim2.new(0, 20, 0, 90)
    KeyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)  -- Dark grey
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.PlaceholderText = "Paste key here..."
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 18
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = MainFrame
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 6)
    BoxCorner.Parent = KeyBox
    
    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Size = UDim2.new(1, -40, 0, 40)
    ButtonsFrame.Position = UDim2.new(0, 20, 1, -60)
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Parent = MainFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 15)
    UIListLayout.Parent = ButtonsFrame
    
    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Size = UDim2.new(0.5, -10, 1, 0)
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)  -- Medium grey
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.Text = "Get Key"
    GetKeyButton.Font = Enum.Font.GothamBold
    GetKeyButton.TextSize = 18
    GetKeyButton.Parent = ButtonsFrame
    
    local GetCorner = Instance.new("UICorner")
    GetCorner.CornerRadius = UDim.new(0, 6)
    GetCorner.Parent = GetKeyButton
    
    local VerifyButton = Instance.new("TextButton")
    VerifyButton.Size = UDim2.new(0.5, -10, 1, 0)
    VerifyButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)  -- Light grey
    VerifyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    VerifyButton.Text = "Verify Key"
    VerifyButton.Font = Enum.Font.GothamBold
    VerifyButton.TextSize = 18
    VerifyButton.Parent = ButtonsFrame
    
    local VerifyCorner = Instance.new("UICorner")
    VerifyCorner.CornerRadius = UDim.new(0, 6)
    VerifyCorner.Parent = VerifyButton
    
    -- Functionality
    GetKeyButton.MouseButton1Click:Connect(function()
        -- CHANGE THIS TO YOUR ACTUAL GET KEY LINK (e.g., Discord, website, etc.)
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)  -- Placeholder: rejoin (replace with setclipboard or notification)
        -- Example: setclipboard("https://your-get-key-link.com")
        -- Or use a notification: game.StarterGui:SetCore("SendNotification", {Title="Get Key", Text="Link copied!"})
    end)
    
    local function tryVerify()
        local key = KeyBox.Text:gsub("%s+", ""):upper()
        if key == "" then return end
        
        if self.ValidateKey(key) then
            ScreenGui:Destroy()
            self.OnSuccess()
        else
            KeyBox.Text = ""
            KeyBox.PlaceholderText = "Invalid Key!"
            task.wait(2)
            KeyBox.PlaceholderText = "Paste key here..."
        end
    end
    
    VerifyButton.MouseButton1Click:Connect(tryVerify)
    
    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            tryVerify()
        end
    end)
    
    -- Mobile optimization: Sizes are reasonable, padding generous but not excessive, buttons large enough for touch
end

return ZaporiumKeySystem
