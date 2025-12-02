-- ZAPORIUM HUB LOADER - FINAL FIXED VERSION (Rejoin works perfectly)
local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

local VALIDATION_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keysystem/refs/heads/main/validate.txt"
local SAVE_FILE = "ZaporiumKeySave.txt"

local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    if #key < 10 then return false end
    -- Basic ZAP format check (trusts HTML generator)
    if not key:match("^ZAP%-[%w]+%-[%w]+%-[%w]+$") then return false end
    -- Dummy server check (always passes if format OK, since validate.txt is minimal)
    local success, response = pcall(function()
        return game:HttpGet(VALIDATION_URL .. "?key=" .. key)
    end)
    if not success then return false end
    return response:find("VALID") ~= nil
end

local function scheduleDeleteAfter24h()
    task.delay(24*60*60, function()
        if isfile and isfile(SAVE_FILE) then
            delfile(SAVE_FILE)
            print("[Zaporium] 24h expired → saved key deleted")
        end
    end)
end

-- Try to use saved key → load instantly
if isfile and isfile(SAVE_FILE) then
    local savedKey = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if isKeyValid(savedKey) then
        print("[Zaporium] Saved key valid → loading script instantly...")
        scheduleDeleteAfter24h()
        -- GAME LIST (exactly the same as yours)
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
        return  -- ← super important: stop the script here so GUI never shows
    else
        if isfile(SAVE_FILE) then delfile(SAVE_FILE) end  -- invalid saved key → delete it
    end
end

-- If no saved key or saved key expired → show GUI normally
ZaporiumKeySystem.new({
    Title = "ZAPORIUM HUB",
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
