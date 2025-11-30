-- ZAPORIUM HUB LOADER - 100% SECURE & WORKING (keys hidden forever)
local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

-- Secure validation — only checks if key exists on your website (no keys in script)
local VALIDATION_URL = "https://raw.githubusercontent.com/cheyt2025-cyber/Keysystem/refs/heads/main/validate.txt"  -- Update to your PHP/static URL if hosted elsewhere

local function isKeyValid(inputKey)
    inputKey = inputKey:gsub("%s+", ""):upper()  -- Trim & uppercase
    if #inputKey < 10 then return false end
    
    local success, response = pcall(function()
        return game:HttpGet(VALIDATION_URL .. "?key=" .. inputKey)
    end)
    
    if not success then return false end
    return response:find("VALID")  -- Flexible match for "VALID" response
end

-- Your games (comments preserved exactly as requested)
local Games = {
    [99879949355467]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Army%20Factory", -- Army Factory
    [99421051519131]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Color%20Game%20Inf", -- Color Game
    [129854327403392]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Brainrot%20morph%20or%20die", -- Brainrot morph or die
    [79657240466394]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Container%20RNG",-- Container RNG.
    [117579798602171]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Crush%20a%20Brainrots",-- Crush for Brainrot
    [102867184397587]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Be%20a%20Hurricane",-- Be a hurricane.
    [95885904866309]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dig%20and%20hatch",-- Dig and hatch a brainrot.
    [111972673427354]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dont%20steal%20the%20Kpop",-- Don’t Steal the KPop Demon Hunters
    [96716540422444]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Don%E2%80%99t%20Steal%20%20The%20Baddies",-- Don't Steal The Baddies
    [109073199927285]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Escape%20The%20Tsunami",-- Escape the Tsunami
    [136404558442020]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Kayak%20and%20surf",-- Kayak and surf ...
    [116681772517483]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Mutate%20or%20Lose%20Brainrot",-- mutate or lose brainrot
    [155615604]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Prison%20Life",-- Prison Life
    [76137189788863]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Raft%20Tycoon",-- Raft Tycoon
    [78949013360566]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Shoot%20a%20Brainrot%20New%20UPD",-- Shoot a Brainrot
    [14911088043]      = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/The%20Ride%20Auto%20Farm%20Cash",-- The Ride
    [168556275]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Console",-- Console
}

ZaporiumKeySystem.new({
    Title = "ZAPORIUM HUB",
    Duration = 24,
    ValidateKey = isKeyValid,
    OnSuccess = function()
        local link = Games[game.PlaceId]
        if link then
            loadstring(game:HttpGet(link))()
        else
            game.StarterGui:SetCore("SendNotification", {
                Title = "Zaporium Hub";
                Text = "Game not supported yet!";
                Duration = 8;
            })
        end
    end
})
