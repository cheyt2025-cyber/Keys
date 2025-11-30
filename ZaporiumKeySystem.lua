-- Zaporium Key System - Updated with "Get Key" Button
-- Original design preserved, only "COPY KEY" → "Get Key" + copies your link

local ZaporiumKeySystem = {}

function ZaporiumKeySystem.new(config)
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZaporiumKeySystem"
    gui.ResetOnSpawn = false
    gui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 300)
    frame.Position = UDim2.new(0.5, -200, 0.5, -150)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(0, 170, 255)
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = "ZAPORIUM HUB"
    title.TextColor3 = Color3.fromRGB(0, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 28
    title.Parent = frame

    local desc = Instance.new("TextLabel")
    desc.Size = UDim2.new(0.9, 0, 0, 60)
    desc.Position = UDim2.new(0.05, 0, 0.15, 0)
    desc.BackgroundTransparency = 1
    desc.Text = "Enter your key below to continue.\nKeys expire after 24 hours."
    desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    desc.Font = Enum.Font.Gotham
    desc.TextSize = 16
    desc.TextWrapped = true
    desc.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.9, 0, 0, 50)
    input.Position = UDim2.new(0.05, 0, 0.45, 0)
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    input.BorderSizePixel = 1
    input.BorderColor3 = Color3.fromRGB(0, 170, 255)
    input.PlaceholderText = "Enter key here..."
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.Gotham
    input.TextSize = 18
    input.ClearTextOnFocus = false
    input.Parent = frame

    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 8)
    corner2.Parent = input

    -- GET KEY BUTTON (replaces old "COPY KEY")
    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.9, 0, 0, 50)
    getKeyBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    getKeyBtn.Text = "Get Key"
    getKeyBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 20
    getKeyBtn.Parent = frame

    local corner3 = Instance.new("UICorner")
    corner3.CornerRadius = UDim.new(0, 8)
    corner3.Parent = getKeyBtn

    -- Success message (hidden by default)
    local successLabel = Instance.new("TextLabel")
    successLabel.Size = UDim2.new(0.9, 0, 0, 40)
    successLabel.Position = UDim2.new(0.05, 0, 0.85, 0)
    successLabel.BackgroundTransparency = 1
    successLabel.Text = "Success! Enjoy Zaporium Hub"
    successLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    successLabel.Font = Enum.Font.GothamBold
    successLabel.TextSize = 18
    successLabel.Visible = false
    successLabel.Parent = frame

    -- GET KEY BUTTON ACTION
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("https://cheyt2025-cyber.github.io/Keysystem/?verified=true")
        getKeyBtn.Text = "Link Copied!"
        task.wait(2)
        getKeyBtn.Text = "Get Key"
    end)

    -- Key validation
    local function validate()
        local key = input.Text:gsub("%s+", "")
        if config.ValidateKey and config.ValidateKey(key) then
            successLabel.Visible = true
            input.Visible = false
            getKeyBtn.Visible = false
            if config.OnSuccess then
                task.wait(1)
                config.OnSuccess()
            end
        else
            input.Text = ""
            input.PlaceholderText = "Invalid key! Try again."
        end
    end

    input.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            validate()
        end
    end)

    return {
        Show = function() gui.Enabled = true end,
        Hide = function() gui.Enabled = false end
    }
end

return ZaporiumKeySystem
