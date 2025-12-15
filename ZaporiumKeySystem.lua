-- ZAPORIUM KEY SYSTEM
-- Custom built key system GUI for Zaporium Hub
-- Features: "Get Key" and "Verify Key" mini buttons, key input textbox
-- Design: White, grey, black with more Cyan blue accents
-- Mobile optimized: Uses Scale for responsiveness, appropriate sizes/padding
-- Not overly rounded to avoid AI-generated look

local ZaporiumKeySystem = {}
ZaporiumKeySystem.__index = ZaporiumKeySystem

function ZaporiumKeySystem.new(config)
    local self = setmetatable({}, ZaporiumKeySystem)
    
    self.ValidateKey = config.ValidateKey or function(key) return false end
    self.OnSuccess = config.OnSuccess or function() end
    
    self:CreateGUI()
    return self
end

function ZaporiumKeySystem:CreateGUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ZaporiumKeySystem"
    ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0.4, 0, 0.5, 0)  -- Responsive size, not too big/small
    MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- White background
    MainFrame.BorderSizePixel = 3
    MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)  -- Black border
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 6)  -- Minimal curve, not too smooth/rounded
    UICorner.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, 0, 0.2, 0)
    Title.Position = UDim2.new(0, 0, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "ZAPORIUM KEY SYSTEM"
    Title.TextColor3 = Color3.fromRGB(0, 255, 255)  -- Cyan blue
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 28
    Title.Parent = MainFrame
    
    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Size = UDim2.new(0.9, 0, 0.15, 0)
    Description.Position = UDim2.new(0.05, 0, 0.2, 0)
    Description.BackgroundTransparency = 1
    Description.Text = "Enter your key below to access Zaporium Hub"
    Description.TextColor3 = Color3.fromRGB(50, 50, 50)  -- Dark grey
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 18
    Description.TextWrapped = true
    Description.Parent = MainFrame
    
    local KeyBox = Instance.new("TextBox")
    KeyBox.Name = "KeyBox"
    KeyBox.Size = UDim2.new(0.9, 0, 0.12, 0)
    KeyBox.Position = UDim2.new(0.05, 0, 0.4, 0)
    KeyBox.BackgroundColor3 = Color3.fromRGB(220, 220, 220)  -- Light grey
    KeyBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
    KeyBox.BorderSizePixel = 2
    KeyBox.PlaceholderText = "Enter Key Here (e.g. ZAP-XXXX-XXXX-XXXX or get key on discord)"
    KeyBox.TextColor3 = Color3.fromRGB(0, 0, 0)
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 20
    KeyBox.ClearTextOnFocus = false
    KeyBox.Parent = MainFrame
    
    local UICornerBox = Instance.new("UICorner")
    UICornerBox.CornerRadius = UDim.new(0, 4)
    UICornerBox.Parent = KeyBox
    
    local ButtonFrame = Instance.new("Frame")
    ButtonFrame.Name = "ButtonFrame"
    ButtonFrame.Size = UDim2.new(0.9, 0, 0.15, 0)
    ButtonFrame.Position = UDim2.new(0.05, 0, 0.58, 0)
    ButtonFrame.BackgroundTransparency = 1
    ButtonFrame.Parent = MainFrame
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    UIListLayout.Padding = UDim.new(0, 20)  -- Spacing between buttons
    UIListLayout.Parent = ButtonFrame
    
    local GetKeyButton = Instance.new("TextButton")
    GetKeyButton.Name = "GetKey"
    GetKeyButton.Size = UDim2.new(0.45, 0, 1, 0)
    GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)  -- Cyan blue
    GetKeyButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    GetKeyButton.BorderSizePixel = 2
    GetKeyButton.Text = "Get Key"
    GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyButton.Font = Enum.Font.GothamBold
    GetKeyButton.TextSize = 22
    GetKeyButton.Parent = ButtonFrame
    
    local UICornerGet = Instance.new("UICorner")
    UICornerGet.CornerRadius = UDim.new(0, 6)
    UICornerGet.Parent = GetKeyButton
    
    local VerifyButton = Instance.new("TextButton")
    VerifyButton.Name = "VerifyKey"
    VerifyButton.Size = UDim2.new(0.45, 0, 1, 0)
    VerifyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)  -- Dark grey
    VerifyButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
    VerifyButton.BorderSizePixel = 2
    VerifyButton.Text = "Verify Key"
    VerifyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    VerifyButton.Font = Enum.Font.GothamBold
    VerifyButton.TextSize = 22
    VerifyButton.Parent = ButtonFrame
    
    local UICornerVerify = Instance.new("UICorner")
    UICornerVerify.CornerRadius = UDim.new(0, 6)
    UICornerVerify.Parent = VerifyButton
    
    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "Status"
    StatusLabel.Size = UDim2.new(0.9, 0, 0.12, 0)
    StatusLabel.Position = UDim2.new(0.05, 0, 0.78, 0)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = ""
    StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    StatusLabel.Font = Enum.Font.GothamSemibold
    StatusLabel.TextSize = 18
    StatusLabel.TextWrapped = true
    StatusLabel.Parent = MainFrame
    
    -- Functionality
    GetKeyButton.MouseButton1Click:Connect(function()
        -- Replace with your actual key link (e.g., Discord, website, etc.)
        game.StarterGui:SetCore("SendNotification", {
            Title = "Zaporium Key";
            Text = "Join our Discord or visit site for keys!";
            Duration = 10;
        })
        -- Optionally: setclipboard("your-discord-link-or-site")
    end)
    
    local function verify()
        local key = KeyBox.Text:gsub("%s+", ""):upper()
        StatusLabel.Text = "Verifying..."
        StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
        
        if self.ValidateKey(key) then
            StatusLabel.Text = "Key Valid! Loading..."
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            ScreenGui:Destroy()
            self.OnSuccess()
        else
            StatusLabel.Text = "Invalid Key!"
            StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
    
    VerifyButton.MouseButton1Click:Connect(verify)
    
    KeyBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            verify()
        end
    end)
end

return ZaporiumKeySystem
