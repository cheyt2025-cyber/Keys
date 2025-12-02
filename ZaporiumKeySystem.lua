-- ZaporiumKeySystem.lua → NOW WITH PERMANENT KEY SAVING (until 24h expires)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local SAVE_FILE = "ZaporiumKeySave.txt" -- saved on your PC

local ZaporiumKeySystem = {}

function ZaporiumKeySystem.new(config)
    local gui = Instance.new("ScreenGui")
    gui.Name = "ZaporiumKeySystem"
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    -- try to load saved key first
    local savedKey = nil
    if isfile and readfile and isfile(SAVE_FILE) then
        savedKey = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    end

    -- if we have a saved key → auto verify it
    if savedKey and #savedKey > 10 then
        if config.ValidateKey and config.ValidateKey(savedKey) then
            task.spawn(config.OnSuccess)
            return {Show = function() end}
        end
    end

    -- if no valid saved key → show the GUI
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 200)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(0, 170, 255)
    frame.BackgroundTransparency = 0.25
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = "ZAPORIUM HUB"
    title.TextColor3 = Color3.fromRGB(0, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 28
    title.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.9, 0, 0, 45)
    input.Position = UDim2.new(0.05, 0, 0.3, 0)
    input.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    input.PlaceholderText = "Paste your key here..."
    input.Text = ""
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.Gotham
    input.TextSize = 18
    input.Parent = frame

    local checkBtn = Instance.new("TextButton")
    checkBtn.Size = UDim2.new(0.9, 0, 0, 45)
    checkBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    checkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    checkBtn.Text = "Check Key"
    checkBtn.TextColor3 = Color3.new(0,0,0)
    checkBtn.Font = Enum.Font.GothamBold
    checkBtn.TextSize = 20
    checkBtn.Parent = frame

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(0.9, 0, 0, 35)
    getKeyBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    getKeyBtn.Text = "Get Key → Opens Generator"
    getKeyBtn.TextColor3 = Color3.new(1,1,1)
    getKeyBtn.Font = Enum.Font.Gotham
    getKeyBtn.TextSize = 16
    getKeyBtn.Parent = frame

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.9, 0, 0, 30)
    status.Position = UDim2.new(0.05, 0, 0.55, 0)
    status.BackgroundTransparency = 1
    status.Text = ""
    status.TextColor3 = Color3.fromRGB(255, 255, 0)
    status.Font = Enum.Font.Gotham
    status.TextSize = 16
    status.Parent = frame

    -- Get Key button (updated to your fixed HTML URL)
    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("https://cheyt2025-cyber.github.io/Keysystem/")
        game.StarterGui:SetCore("SendNotification",{Title="Zaporium";Text="Link copied! Opening...";Duration=4})
        request({Url="https://cheyt2025-cyber.github.io/Keysystem/"})
    end)

    -- Check key button
    checkBtn.MouseButton1Click:Connect(function()
        local key = input.Text:gsub("%s+", ""):upper()
        if key == "" then
            status.Text = "Enter a key first!"
            status.TextColor3 = Color3.fromRGB(255,100,100)
            return
        end

        status.Text = "Verifying..."
        status.TextColor3 = Color3.fromRGB(255,255,0)

        if config.ValidateKey(key) then
            -- SAVE THE KEY SO IT NEVER ASKS ONLY ONCE
            if writefile then
                writefile(SAVE_FILE, key)
            end
            status.Text = "Accepted! Loading script..."
            status.TextColor3 = Color3.fromRGB(0,255,0)
            task.wait(1)
            gui:Destroy()
            config.OnSuccess()
        else
            status.Text = "Invalid / Expired Key"
            status.TextColor3 = Color3.fromRGB(255,100,100)
        end
    end)

    return {Show = function() gui.Enabled = true end}
end

return ZaporiumKeySystem
