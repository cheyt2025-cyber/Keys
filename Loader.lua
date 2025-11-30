-- ZAPORIUM HUB LOADER - 100% SECURE (keys never exposed)
-- Paste this as your main loader

local ZaporiumKeySystem = loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/main/ZaporiumKeySystem.lua"))()

-- This tiny proxy checks if the key was actually claimed on your web page
local PROXY_URL = "https://cheyt2025-cyber.github.io/Keysystem/validate.php?key="

local function isKeyValid(inputKey)
    inputKey = inputKey:gsub("%s+", ""):upper()
    if #inputKey < 10 then return false end

    local success, response = pcall(function()
        return game:HttpGet(PROXY_URL .. inputKey, true)
    end)

    if not success then return false end
    return response == "VALID"
end

-- Your games
local Games = {
    [2788229376]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/Arsenal",     -- Arsenal
    [12690025832] = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/BladeBall",   -- Blade Ball
    [6403373529]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/SlapBattles", -- Slap Battles
    -- Add more...
}

ZaporiumKeySystem.new({
    Title = "ZAPORIUM HUB",
    Duration = 24,
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
    end,
    ValidateKey = isKeyValid  -- This is the magic line
}):Show()
