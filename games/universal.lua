--[[
    universal.lua - Universal Game Module
    Loads for all games
]]

print("[VexLoader] Universal module loaded")

-- Universal functions
local function getPlayer()
    return game:GetService("Players").LocalPlayer
end

local function getCharacter()
    local player = getPlayer()
    if player then
        return player.Character
    end
    return nil
end

-- Return functions
return {
    getPlayer = getPlayer,
    getCharacter = getCharacter,
}
