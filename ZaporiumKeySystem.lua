-- ZaporiumKeySystem.lua → FINAL PERFECT VERSION
-- Sci-fi theme, no overlaps, buttons perfectly inside border with proper padding

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local ZaporiumKeySystem = {}

function ZaporiumKeySystem.new(config)
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZaporiumKeySystem"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local SAVE_FILE = "ZaporiumKeySave.txt"
    local savedKey = nil
    if isfile and readfile and isfile(SAVE_FILE) then
        savedKey = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    end

    if savedKey and #savedKey > 10 then
        if config.ValidateKey and config.ValidateKey(savedKey) then
            task.spawn(config.OnSuccess)
            return {Show = function() end}
        end
    end

    -- Main Frame (slightly taller for perfect spacing)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 360, 0, 240)  -- Increased width/height for better padding
    frame.Position = UDim2.new(0.5, -180, 0.5, -120)
    frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 3
    stroke.Color = Color3.fromRGB(0, 255, 255)
    stroke.Transparency = 0.3
    stroke.Parent = frame

    local glowGradient = Instance.new("UIGradient")
    glowGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255))
    }
    glowGradient.Rotation = 45
    glowGradient.Parent = stroke

    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = "ZAPORIUM HUB"
    title.TextColor3 = Color3.fromRGB(0, 255, 255)
    title.Font = Enum.Font.Code
    title.TextSize = 34
    title.TextStrokeTransparency = 0.8
    title.TextStrokeColor3 = Color3.fromRGB(0, 255, 255)
    title.Parent = frame

    -- Description
    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(0.9, 0, 0, 30)
    desc.Position = UDim2.new(0.05, 0, 0.22, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Enter your 24-hour beta key"
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.Font = Enum.Font.Code
    desc.TextSize = 17
    desc.Parent = frame

    -- Input Box
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.9, 0, 0, 45)
    input.Position = UDim2.new(0.05, 0, 0.36, 0)
    input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    input.PlaceholderText = "ZAP-XXXX-XXXX-XXXX"
    input.Text = ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.Code
    input.TextSize = 18
    input.ClearTextOnFocus = false
    input.Parent = frame

    local inputCorner = Instance.new("UICorner")
    inputCorner.CornerRadius = UDim.new(0, 8)
    inputCorner.Parent = input

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Thickness = 1
    inputStroke.Color = Color3.fromRGB(80, 80, 80)
    inputStroke.Parent = input

    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.9, 0, 0, 30)
    status.Position = UDim2.new(0.05, 0, 0.54, 0)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(255, 255, 100)
    status.Font = Enum.Font.Code
    status.TextSize = 16
    status.TextWrapped = true
    status.Parent = frame

    -- Verify Button (smaller, better spaced)
    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.9, 0, 0, 42)
    checkBtn.Position = UDim2.new(0.05, 0, 0.66, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    checkBtn.Text = "Verify Key"
    checkBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    checkBtn.Font = Enum.Font.Code
    checkBtn.TextSize = 20
    checkBtn.AutoButtonColor = false
    checkBtn.Parent = frame

    local checkCorner = Instance.new("UICorner")
    checkCorner.CornerRadius = UDim.new(0, 8)
    checkCorner.Parent = checkBtn

    local checkGradient = Instance.new("UIGradient")
    checkGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 200))
    }
    checkGradient.Parent = checkBtn

    checkBtn.MouseEnter:Connect(function()
        TweenService:Create(checkBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    checkBtn.MouseLeave:Connect(function()
        TweenService:Create(checkBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end)

    -- Get Key Button (smaller, perfectly inside border)
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.9, 0, 0, 36)
    getKeyBtn.Position = UDim2.new(0.05, 0, 0.83, 0)  -- Proper bottom padding
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    getKeyBtn.Text = "Get Key → Opens Generator"
    getKeyBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
    getKeyBtn.Font = Enum.Font.Code
    getKeyBtn.TextSize = 16
    getKeyBtn.AutoButtonColor = false
    getKeyBtn.Parent = frame

    local getCorner = Instance.new("UICorner")
    getCorner.CornerRadius = UDim.new(0, 8)
    getCorner.Parent = getKeyBtn

    local getStroke = Instance.new("UIStroke")
    getStroke.Thickness = 1
    getStroke.Color = Color3.fromRGB(0, 255, 255)
    getStroke.Transparency = 0.5
    getStroke.Parent = getKeyBtn

    -- Get Key Action
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("http://Zaporium-Key.infinityfree.me/")
        game.StarterGui:SetCore("SendNotification", {
            Title = "Zaporium Hub";
            Text = "Link copied! Opening generator...";
            Duration = 5
        })
        request({Url = "http://Zaporium-Key.infinityfree.me/", Method = "GET"})
    end)

    -- Verify Action
    checkBtn.MouseButton1Click:Connect(function()
        local key = input.Text:gsub("%s+", ""):upper()
        if key == "" then
            status.Text = "Please enter a key!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end
        status.Text = "Verifying..."
        status.TextColor3 = Color3.fromRGB(255, 255, 100)

        if config.ValidateKey(key) then
            if writefile then
                writefile(SAVE_FILE, key)
            end
            status.Text = "Key Accepted! Loading..."
            status.TextColor3 = Color3.fromRGB(100, 255, 100)
            task.wait(1)
            gui:Destroy()
            config.OnSuccess()
        else
            status.Text = "Invalid or Expired Key"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    return {Show = function() gui.Enabled = true end}
end

return ZaporiumKeySystem
