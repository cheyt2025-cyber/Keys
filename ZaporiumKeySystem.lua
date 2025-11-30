-- Zaporium Key System - Updated with "Get Key" button and case-insensitive validation
-- Paste this as your new ZaporiumKeySystem.lua

local ZaporiumKeySystem = {}

function ZaporiumKeySystem.new(config)
    local gui = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local input = Instance.new("TextBox")
    local checkBtn = Instance.new("TextButton")
    local getKeyBtn = Instance.new("TextButton")  -- This is the new "Get Key" button
    local status = Instance.new("TextLabel")

    gui.Name = "ZaporiumKeySystem"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    frame.Size = UDim2.new(0, 350, 0, 200)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(0, 170, 255)
    frame.Parent = gui

    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = config.Title or "ZAPORIUM HUB"
    title.TextColor3 = Color3.fromRGB(0, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.Parent = frame

    input.Size = UDim2.new(0.9, 0, 0, 40)
    input.Position = UDim2.new(0.05, 0, 0.3, 0)
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    input.BorderColor3 = Color3.fromRGB(0, 170, 255)
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.PlaceholderText = "Enter your key here..."
    input.Text = ""
    input.Font = Enum.Font.Gotham
    input.TextSize = 18
    input.Parent = frame

    checkBtn.Size = UDim2.new(0.42, 0, 0, 40)
    checkBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    checkBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    checkBtn.Text = "Check Key"
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextSize = 18
    checkBtn.Parent = frame

    -- "Get Key" Button (replaces old Copy Key)
    getKeyBtn.Size = UDim2.new(0.42, 0, 0, 40)
    getKeyBtn.Position = UDim2.new(0.53, 0, 0.7, 0)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    getKeyBtn.Text = "Get Key"
    getKeyBtn.Font = Enum.Font.GothamBold
    getKeyBtn.TextSize = 18
    getKeyBtn.Parent = frame

    status.Size = UDim2.new(0.9, 0, 0, 30)
    status.Position = UDim2.new(0.05, 0, 0.55, 0)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
    status.Font = Enum.Font.Gotham
    status.TextSize = 16
    status.Parent = frame

    -- "Get Key" Button Action
    getKeyBtn.MouseButton1Click:Connect(function()
        local keyLink = "https://cheyt2025-cyber.github.io/Keysystem/"  -- Points to your HTML
        setclipboard(keyLink)  -- Auto copy to clipboard
        game.StarterGui:SetCore("SendNotification", {
            Title = "Zaporium Key";
            Text = "Key generator link copied! Opening in browser...";
            Duration = 4;
        })
        -- Open in default browser
        if syn and syn.request then
            syn.request({Url = keyLink})
        elseif request then
            request({Url = keyLink})
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Error";
                Text = "Executor doesn't support opening links";
            })
        end
    end)

    checkBtn.MouseButton1Click:Connect(function()
        local key = input.Text:gsub("%s+", ""):upper()  -- Trim & uppercase for case-insensitivity
        if key == "" then
            status.Text = "Please enter a key!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
            return
        end

        if config.ValidateKey and config.ValidateKey(key) then
            status.Text = "Key Accepted! Loading..."
            status.TextColor3 = Color3.fromRGB(0, 255, 0)
            task.wait(1)
            gui:Destroy()
            if config.OnSuccess then
                config.OnSuccess()
            end
        else
            status.Text = "Invalid or Expired Key!"
            status.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Auto-show GUI
    function show() gui.Enabled = true end
    gui.Enabled = true
    show()

    return { Show = show }
end

return ZaporiumKeySystem
