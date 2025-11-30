-- ZaporiumKeySystem.lua (UPDATED – WITH "GET KEY" BUTTON)
local ZaporiumKeySystem = {}

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

function ZaporiumKeySystem.new(config)
    config = config or {}
    local Title = config.Title or "Zaporium Hub"
    local Duration = config.Duration or 24
    local ValidateKey = config.ValidateKey or function(key) return key == "test" end
    local OnSuccess = config.OnSuccess or function() end

    -- Main GUI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 380, 0, 220)
    MainFrame.Position = UDim2.new(0.5, -190, 0.5, -110)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame

    local Glow = Instance.new("ImageLabel")
    Glow.Size = UDim2.new(1, 20, 1, 20)
    Glow.Position = UDim2.new(0, -10, 0, -10)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxassetid://4996891970"
    Glow.ImageColor3 = Color3.fromRGB(0, 170, 255)
    Glow.ImageTransparency = 0.7
    Glow.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 40)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = Title
    TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 22
    TitleLabel.Parent = MainFrame

    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
    KeyBox.Position = UDim2.new(0.1, 0, 0.3, 0)
    KeyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyBox.PlaceholderText = "Enter your key here..."
    KeyBox.Text = ""
    KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    KeyBox.Font = Enum.Font.Gotham
    KeyBox.TextSize = 16
    KeyBox.Parent = MainFrame

    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 8)
    KeyCorner.Parent = KeyBox

    -- GET KEY BUTTON (opens your web key page)
    local GetKeyBtn = Instance.new("TextButton")
    GetKeyBtn.Size = UDim2.new(0.45, 0, 0, 40)
    GetKeyBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
    GetKeyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    GetKeyBtn.Text = "Get Key"
    GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    GetKeyBtn.Font = Enum.Font.GothamBold
    GetKeyBtn.TextSize = 16
    GetKeyBtn.Parent = MainFrame

    local GetKeyCorner = Instance.new("UICorner")
    GetKeyCorner.CornerRadius = UDim.new(0, 8)
    GetKeyCorner.Parent = GetKeyBtn

    -- SUBMIT BUTTON
    local SubmitBtn = Instance.new("TextButton")
    SubmitBtn.Size = UDim2.new(0.45, 0, 0, 40)
    SubmitBtn.Position = UDim2.new(0.5, 0, 0.65, 0)
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
    SubmitBtn.Text = "Submit"
    SubmitBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.TextSize = 16
    SubmitBtn.Parent = MainFrame

    local SubmitCorner = Instance.new("UICorner")
    SubmitCorner.CornerRadius = UDim.new(0, 8)
    SubmitCorner.Parent = SubmitBtn

    -- GET KEY BUTTON → OPENS YOUR WEB KEY PAGE
    GetKeyBtn.MouseButton1Click:Connect(function()
        -- YOUR WEB KEY PAGE (WITH LOOTLABS)
        game:GetService("GuiService"):OpenBrowser("https://cheyt2025-cyber.github.io/Keysystem/")
    end)

    -- SUBMIT BUTTON
    SubmitBtn.MouseButton1Click:Connect(function()
        local key = KeyBox.Text:gsub("%s+", "")
        if ValidateKey(key) then
            -- Save key for 24h
            writefile("ZaporiumKey.txt", key)
            setclipboard(key)
            MainFrame:TweenPosition(UDim2.new(0.5, -190, -0.5, 0), "Out", "Quad", 0.5, true)
            wait(0.5)
            ScreenGui:Destroy()
            OnSuccess()
        else
            KeyBox.Text = ""
            KeyBox.PlaceholderText = "Invalid key!"
            KeyBox.PlaceholderColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)

    -- Auto-fill if key exists and not expired
    spawn(function()
        if isfile and readfile and isfile("ZaporiumKey.txt") then
            local savedKey = readfile("ZaporiumKey.txt")
            if ValidateKey(savedKey) then
                KeyBox.Text = savedKey
                SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
            end
        end
    end)

    return {}
end

return ZaporiumKeySystem
