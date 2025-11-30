-- ZAPORIUM HUB LOADER - FINAL LAZY + BULLETPROOF VERSION
local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()
local VALIDATION_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keysystem/refs/heads/main/validate.txt"
local SAVE_FILE = "ZaporiumKeySave.txt"
local GAMELIST_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/GameList.txt"

local Games = {}
local success, list = pcall(function() return game:HttpGet(GAMELIST_URL, true) end)
if success then
    for line in list:gmatch("[^\r\n]+") do
        local placeId, url = line:match("^(.-)|(.+)$")
        if placeId and url then
            placeId = tonumber(placeId:gsub("%D", "")) -- removes any non-number just in case
            if placeId then
                Games[placeId] = url
            end
        end
    end
else
    warn("[Zaporium] Failed to load GameList.txt")
end

local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    local success, res = pcall(function() return game:HttpGet(VALIDATION_URL.."?key="..key) end)
    return success and res:find("VALID")
end

local function scheduleDelete()
    task.delay(24*60*60, function() if isfile and isfile(SAVE_FILE) then delfile(SAVE_FILE) end end)
end

-- Saved key → instant load
if isfile and isfile(SAVE_FILE) then
    local saved = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if isKeyValid(saved) then
        print("[Zaporium] Saved key valid → loading game instantly")
        scheduleDelete()
        local link = Games[game.PlaceId]
        if link then loadstring(game:HttpGet(link))() else
            game.StarterGui:SetCore("SendNotification",{Title="Zaporium",Text="Game not supported yet!",Duration=6})
        end
        return
    else
        if isfile(SAVE_FILE) then delfile(SAVE_FILE) end
    end
end

-- Show GUI
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
            game.StarterGui:SetCore("SendNotification",{Title="Zaporium",Text="Game not supported yet!",Duration=8})
        end
    end
})
