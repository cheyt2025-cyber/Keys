-- ZAPORIUM HUB LOADER - ZAPFREE NEVER SAVES + INSTANT DELETE ON LEAVE
-- Normal keys save for 24h, ZAPFREE never saves and deletes instantly on leave

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/refs/heads/main/ZaporiumKeySystem.lua"))()

local NORMAL_VALIDATION_URL = "https://corsproxy.io/?http://Zaporium-Key.infinityfree.me/proxy.php?t=validate&key="
local GLOBAL_CHECK_URL = "https://corsproxy.io/?http://Zaporium-Key.infinityfree.me/global_check.php"

local SAVE_FILE = "ZaporiumKeySave.txt"

local function isKeyValid(key)
    key = key:gsub("%s+", ""):upper()
    
    -- Global Free Key: ZAPFREE
    if key == "ZAPFREE" then
        local success, response = pcall(function()
            return game:HttpGet(GLOBAL_CHECK_URL)
        end)
        if success then
            response = response:match("^%s*(.-)%s*$")
            if response == "ACTIVE" then
                return true
            end
        end
        return false
    end
    
    -- Normal key validation
    if #key < 10 or not key:match("^ZAP%-[%w]+%-[%w]+%-[%w]+$") then 
        return false 
    end
    
    local success, response = pcall(function()
        return game:HttpGet(NORMAL_VALIDATION_URL .. key, true)
    end)
    
    if not success then
        return false
    end
    
    response = response:match("^%s*(.-)%s*$")
    return response == "VALID"
end

local function scheduleDeleteAfter24h()
    task.delay(24*60*60 + 120, function()
        if isfile and isfile(SAVE_FILE) then
            delfile(SAVE_FILE)
        end
    end)
end

-- Check saved key (only normal keys are saved)
if isfile and isfile(SAVE_FILE) then
    local savedKey = readfile(SAVE_FILE):gsub("%s+", ""):upper()
    if savedKey == "ZAPFREE" then
        -- If somehow ZAPFREE was saved before, delete it immediately
        delfile(SAVE_FILE)
    elseif isKeyValid(savedKey) then
        scheduleDeleteAfter24h()
        
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
            game.StarterGui:SetCore("SendNotification", {Title = "Zaporium Hub"; Text = "Game not supported yet!"; Duration = 8})
        end
        return
    else
        delfile(SAVE_FILE)
    end
end

-- Show GUI
ZaporiumKeySystem.new({
    ValidateKey = function(key)
        local valid = isKeyValid(key)
        -- Never save ZAPFREE (force input every time)
        if valid and key ~= "ZAPFREE" and writefile then
            writefile(SAVE_FILE, key)
            scheduleDeleteAfter24h()
        end
        return valid
    end,
    OnSuccess = function()
        -- Delete ZAPFREE immediately after success (on leave/rejoin, GUI shows again)
        if readfile and isfile and readfile(SAVE_FILE) == "ZAPFREE" then
            delfile(SAVE_FILE)
        end
        
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
            game.StarterGui:SetCore("SendNotification", {Title = "Zaporium Hub"; Text = "Game not supported yet!"; Duration = 8})
        end
    end
})
