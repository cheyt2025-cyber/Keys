-- ZAPORIUM HUB LOADER - SUPER EASY TO ADD GAMES EDITION
-- Only edit the GAMES TABLE at the very top ↓↓↓
-- Everything else works exactly the same as before (rejoin = instant, saved key, 24h delete)

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

local VALIDATION_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keysystem/refs/heads/main/validate.txt"
local SAVE_FILE = "ZaporiumKeySave.txt"

-- EDIT ONLY THIS TABLE TO ADD/REMOVE GAMES (super clean)
local GAMES = {
    [99879949355467]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Army%20Factory",                 -- Army Factory
    [99421051519131]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Color%20Game%20Inf",            -- Color Game Inf
    [129854327403392]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Brainrot%20morph%20or%20die",   -- Brainrot morph or die
    [79657240466394]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Container%20RNG",              -- Container RNG
    [117579798602171]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Crush%20a%20Brainrots",       -- Crush a Brainrots
    [102867184397587]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Be%20a%20Hurricane",           -- Be a Hurricane
    [95885904866309]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dig%20and%20hatch",            -- Dig and hatch
    [111972673427354]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dont%20steal%20the%20Kpop",   -- Dont steal the Kpop
    [96716540422444]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Don%E2%80%99t%20Steal%20%20The%20Baddies",
    [109073199927285]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Escape%20The%20Tsunami",      -- Escape The Tsunami
    [136404558442020]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Kayak%20and%20surf",          -- Kayak and surf
    [116681772517483]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Mutate%20or%20Lose%20Brainrot",-- Mutate or Lose Brainrot
    [155615604]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Prison%20Life",                -- Prison Life
    [76137189788863]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Raft%20Tycoon",               -- Raft Tycoon
    [78949013360566]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Shoot%20a%20Brainrot%20New%20UPD",
    [14911088043]      = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/The%20Ride%20Auto%20Farm%20Cash",
    [168556275]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Console",                      -- Console / Baseplate

    -- ADD NEW GAMES HERE ↓ (just copy-paste one line)
    -- [123456789] = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/YourGameName",
}

-- Your Comment
}

-- DO NOT TOUCH ANYTHING BELOW THIS LINE
local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    if #key < 10 then return false end
    local success, res = pcall(function() return game:HttpGet(VALIDATION_URL .. "?key=" .. key) end)
    if not success then return false end
    return res:find("VALID") ~= nil
end

local function runScript()
    local link = GAMES[game.PlaceId]
    if link then
        loadstring(game:HttpGet(link))()
    else
        game.StarterGui:SetCore("SendNotification", {
            Title = "Zaporium Hub";
            Text = "Game not supported yet!";
            Duration = 8
        })
    end
end

local function scheduleDelete()
    task.delay(24*60*60, function()
        if isfile and isfile(SAVE_FILE) then
            delfile(SAVE_FILE)
            print("[Zaporium] 24h expired → key deleted")
        end
    end)
end

-- AUTO LOAD WITH SAVED KEY (instant on rejoin)
if isfile and isfile(SAVE_FILE) then
    local savedKey = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if isKeyValid(savedKey) then
        print("[Zaporium] Saved key accepted → loading instantly")
        scheduleDelete()
        runScript()
        return
    else
        delfile(SAVE_FILE) -- invalid → delete
    end
end

-- NO SAVED KEY → SHOW GUI
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
    OnSuccess = runScript
})
