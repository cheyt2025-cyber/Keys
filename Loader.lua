-- ZAPORIUM HUB LOADER - LAZY EDITION 2025
-- You NEVER edit this file again. Add games only in GameList.txt

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()
local VALIDATION_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keysystem/refs/heads/main/validate.txt"
local SAVE_FILE = "ZaporiumKeySave.txt"
local GAMELIST_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/GameList.txt" -- ← your new file

-- Load game list from GitHub (auto updates)
local Games = {}
pcall(function()
    local list = game:HttpGet(GAMELIST_URL)
    for line in list:gmatch("[^\r\n]+") do
        if line:find("|") then
            local placeId, url = line:match("^(.-)%s*|%s*(.+)$")
            placeId = placeId:gsub("%s+", "")
            if placeId ~= "" and url then
                Games[tonumber(placeId)] = url
            end
        end
    end
end)

local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    if #key < 10 then return false end
    local success, res = pcall(function() return game:HttpGet(VALIDATION_URL.."?key="..key) end)
    return success and res:find("VALID") ~= nil
end

local function scheduleDelete()
    task.delay(24*60*60, function()
        if isfile and isfile(SAVE_FILE) then delfile(SAVE_FILE) end
    end)
end

-- Auto-load with saved key
if isfile and isfile(SAVE_FILE) then
    local saved = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if isKeyValid(saved) then
        print("[Zaporium] Saved key accepted → instant load")
        scheduleDelete()
        local link = Games[game.PlaceId]
        if link then loadstring(game:HttpGet(link))()
        else game.StarterGui:SetCore("SendNotification",{Title="Zaporium",Text="Game not supported yet!",Duration=6}) end
        return
    else
        if isfile(SAVE_FILE) then delfile(SAVE_FILE) end
    end
end

-- Show GUI only if no saved key
ZaporiumKeySystem.new({
    Title = "ZAPORIUM HUB",
    ValidateKey = function(key)
        local valid = isKeyValid(key)
        if valid and writefile then
            writefile(SAVE_FILE, key:gsub("%s+", ""):upper())
            scheduleDelete()
        end
        return valid
    end,
    OnSuccess = function()
        local link = Games[game.PlaceId]
        if link then
            loadstring(game:HttpGet(link))()
        else
            game.StarterGui:SetCore("SendNotification",{
                Title = "Zaporium Hub",
                Text = "Game not supported yet! Added soon",
                Duration = 8
            })
        end
    end
})
