-- GameList.lua - ZAPORIUM HUB (Add new games here forever!)
-- Just add one line at the bottom when you want a new game

local Games = {
    [99879949355467]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Army%20Factory",                    -- Army Factory
    [99421051519131]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Color%20Game%20Inf",                 -- Color Game Inf
    [129854327403392]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Brainrot%20morph%20or%20die",       -- Brainrot morph or die
    [79657240466394]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Container%20RNG",                    -- Container RNG
    [117579798602171]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Crush%20a%20Brainrots",               -- Crush a Brainrots
    [102867184397587]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Be%20a%20Hurricane",                 -- Be a Hurricane
    [95885904866309]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dig%20and%20hatch",                   -- Dig and hatch
    [111972673427354]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Dont%20steal%20the%20Kpop",           -- Don't steal the Kpop
    [96716540422444]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Don%E2%80%99t%20Steal%20%20The%20Baddies", -- Don't Steal The Baddies
    [109073199927285]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Escape%20The%20Tsunami",              -- Escape The Tsunami
    [136404558442020]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Kayak%20and%20surf",                    -- Kayak and surf
    [116681772517483]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Mutate%20or%20Lose%20Brainrot",       -- Mutate or Lose Brainrot
    [155615604]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Prison%20Life",                      -- Prison Life
    [76137189788863]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Raft%20Tycoon",                     -- Raft Tycoon
    [78949013360566]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Shoot%20a%20Brainrot%20New%20UPD",   -- Shoot a Brainrot New UPD
    [14911088043]      = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/The%20Ride%20Auto%20Farm%20Cash",    -- The Ride Auto Farm Cash
    [168556275]        = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/refs/heads/main/Console",                          -- Console / Baseplate

    -- ADD ALL YOUR FUTURE GAMES BELOW THIS LINE (super easy from now on)
    -- Example:
    -- [11111111111111] = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/NewGameScript",
}

-- DO NOT TOUCH BELOW THIS LINE
local link = Games[game.PlaceId]
if link then
    loadstring(game:HttpGet(link))()
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Zaporium Hub";
        Text = "Game not supported yet!";
        Duration = 8
    })
end
