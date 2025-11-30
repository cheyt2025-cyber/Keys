-- ZAPORIUM HUB LOADER - SUPER EASY TO ADD GAMES FOREVER
-- Just add new games in ONE PLACE at the bottom

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

local VALIDATION_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keysystem/refs/heads/main/validate.txt"
local SAVE_FILE = "ZaporiumKeySave.txt"

local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    if #key < 10 then return false end
    local success, res = pcall(function() return game:HttpGet(VALIDATION_URL.."?key="..key) end)
    if not success then return false end
    return res:find("VALID") ~= nil
end

local function deleteAfter24h()
    task.delay(24*60*60, function()
        if isfile and isfile(SAVE_FILE) then delfile(SAVE_FILE) end
    end)
end

-- TRY SAVED KEY FIRST (instant load on rejoin)
if isfile and isfile(SAVE_FILE) then
    local saved = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if isKeyValid(saved) then
        print("^1[Zaporium]^7 Saved key accepted → loading instantly")
        deleteAfter24h()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/GameList.lua"))()
        return
    else
        delfile(SAVE_FILE)
    end
end

-- NO SAVED KEY → SHOW GUI
ZaporiumKeySystem.new({
    Title = "ZAPORIUM HUB",
    ValidateKey = function(key)
        local valid = isKeyValid(key)
        if valid and writefile then
            writefile(SAVE_FILE, key:gsub("%s+", ""):upper())
            deleteAfter24h()
        end
        return valid
    end,
    OnSuccess = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/GameList.lua"))()
    end
})
