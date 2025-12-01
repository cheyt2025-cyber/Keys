-- Loader.lua ← just replace your whole file with this
local Games = {
    [155615604]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/PrisonLife.lua",
    [606849621]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/Jailbreak.lua",
    [142823291]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/MurderMystery2.lua",
    [1962086868]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/TowerOfHell.lua",
    [537413528]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/BuildABoat.lua",
    [6403373529]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/SlapBattles.lua",
    [9049840490]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/BladeBall.lua",
    [3101667897]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/LegendsOfSpeed.lua",
    [891852901]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/PetSimulator99.lua",
    [8737899170]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/PetSimulatorX.lua",
    [2753915549]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/BloxFruits.lua",
    [4446383246]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/NinjaLegends.lua",
    [734159876]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/Arsenal.lua",
    [1054526971]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/CounterBlox.lua",
    [3704849742]  = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/PhantomForces.lua",
    [358276974]   = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/ApocalypseRising2.lua",
    [99879949355467] = "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/ArmyFactory.lua",
}

local SaveFile = "ZaporiumKeySave.txt"
local ValidationUrl = "https://cheyt2025-cyber.github.io/Keysystem/validate.txt"

local function isKeyValid(key)
    local url = ValidationUrl .. "?key=" .. key
    local success, result = pcall(function()
        return game:HttpGet(url, true)
    end)
    if success and result then
        return result:match("VALID") ~= nil
    end
    return false
end

local function loadScript(url)
    loadstring(game:HttpGet(url))()
end

if isfile and readfile and isfile(SaveFile) then
    local savedKey = readfile(SaveFile)
    if isKeyValid(savedKey) then
        task.delay(24*60*60, function() if isfile(SaveFile) then delfile(SaveFile) end end)
        loadScript(Games[game.PlaceId] or "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/Unsupported.lua")
        return
    else
        delfile(SaveFile)
    end
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/cheyt2025-cyber/Keys/refs/heads/main/ZaporiumKeySystem.lua"))()

_G.ValidateKey = function(key)
    key = key:match("^%s*(.-)%s*$")
    if isKeyValid(key) then
        if writefile then
            writefile(SaveFile, key)
            task.delay(24*60*60, function() if isfile(SaveFile) then delfile(SaveFile) end end)
        end
        loadScript(Games[game.PlaceId] or "https://raw.githubusercontent.com/cheyt2025-cyber/Boss/main/Unsupported.lua")
        return true
    else
        return false
    end
end
