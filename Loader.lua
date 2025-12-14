-- ZAPORIUM HUB LOADER - UPDATED FOR YOUR WEBSITE (True 24h Expiry + Server Validation)
-- Site: http://Zaporium-Key.infinityfree.me
-- Key validation now fully controlled by your website (keys expire after 24 hours server-side)

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

-- NEW: Validation URL points to your website's validate.php
local VALIDATION_URL = "http://Zaporium-Key.infinityfree.me/proxy.php?t=validate&key="

local SAVE_FILE = "ZaporiumKeySave.txt"

local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    if #key < 10 then return false end
    -- Format check (ZAP-XXXX-XXXX-XXXX)
    if not key:match("^ZAP%-[%w]+%-[%w]+%-[%w]+$") then return false end
    
    -- Server-side validation (checks if key exists AND not expired)
    local success, response = pcall(function()
        return game:HttpGet(VALIDATION_URL .. key)
    end)
    if not success then 
        warn("[Zaporium] Validation failed (no internet or server down)")
        return false 
    end
    return response:find("VALID") ~= nil
end

local function scheduleDeleteAfter24h()
    task.delay(24*60*60 + 60, function()  -- +60s buffer
        if isfile and isfile(SAVE_FILE) then
            delfile(SAVE_FILE)
            print("[Zaporium] 24h expired → saved key deleted locally")
        end
    end)
end

-- Try saved key first (instant load if still valid)
if isfile and isfile(SAVE_FILE) then
    local savedKey = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if isKeyValid(savedKey) then
        print("[Zaporium] Saved key still valid → loading instantly...")
        scheduleDeleteAfter24h()
        
        -- FULL GAME LIST (kept exactly as your original)
        local Games = {
            [99879949355467]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Army%20Factory",
            [99421051519131]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Color%20Game%20Inf",
            [129854327403392]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Brainrot%20morph%20or%20die",
            [79657240466394]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Container%20RNG",
            [117579798602171]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Crush%20a%20Brainrots",
            [102867184397587]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Be%20a%20Hurricane",
            [95885904866309]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dig%20and%20hatch",
            [111972673427354]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dont%20steal%20the%20Kpop",
            [96716540422444]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Don%E2%80%99t%20Steal%20%20The%20Baddies",
            [109073199927285]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Escape%20The%20Tsunami",
            [136404558442020]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Kayak%20and%20surf",
            [116681772517483]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Mutate%20or%20Lose%20Brainrot",
            [155615604]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Prison%20Life",
            [76137189788863]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Raft%20Tycoon",
            [78949013360566]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Shoot%20a%20Brainrot%20New%20UPD",
            [14911088043]      = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/The%20Ride%20Auto%20Farm%20Cash",
            [168556275]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Console",
        }

        local link = Games[game.PlaceId]
        if link then
            loadstring(game:HttpGet(link))()
        else
            game.StarterGui:SetCore("SendNotification",{
                Title = "Zaporium Hub";
                Text = "Game not supported yet!";
                Duration = 8
            })
        end
        return  -- Stop here: no GUI shown
    else
        if isfile(SAVE_FILE) then delfile(SAVE_FILE) end
    end
end

-- No valid saved key → show key GUI
ZaporiumKeySystem.new({
    Title = "ZAPORIUM HUB",
    Description = "Get key at: Zaporium-Key.infinityfree.me",
    ValidateKey = function(key)
        local valid = isKeyValid(key)
        if valid and writefile then
            writefile(SAVE_FILE, key:gsub("%s+", ""):upper())
            scheduleDeleteAfter24h()
        end
        return valid
    end,
    OnSuccess = function()
        local Games = {
            [99879949355467]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Army%20Factory",
            [99421051519131]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Color%20Game%20Inf",
            [129854327403392]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Brainrot%20morph%20or%20die",
            [79657240466394]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Container%20RNG",
            [117579798602171]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Crush%20a%20Brainrots",
            [102867184397587]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Be%20a%20Hurricane",
            [95885904866309]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dig%20and%20hatch",
            [111972673427354]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dont%20steal%20the%20Kpop",
            [96716540422444]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Don%E2%80%99t%20Steal%20%20The%20Baddies",
            [109073199927285]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Escape%20The%20Tsunami",
            [136404558442020]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Kayak%20and%20surf",
            [116681772517483]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Mutate%20or%20Lose%20Brainrot",
            [155615604]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Prison%20Life",
            [76137189788863]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Raft%20Tycoon",
            [78949013360566]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Shoot%20a%20Brainrot%20New%20UPD",
            [14911088043]      = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/The%20Ride%20Auto%20Farm%20Cash",
            [168556275]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Console",
        }

        local link = Games[game.PlaceId]
        if link then
            loadstring(game:HttpGet(link))()
        else
            game.StarterGui:SetCore("SendNotification",{
                Title = "Zaporium Hub";
                Text = "Game not supported yet!";
                Duration = 8
            })
        end
    end
})
