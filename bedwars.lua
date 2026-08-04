--[[
    bedwars.lua - VexLoader BedWars Module
    Place this in your soulstunn/vexloader repository
]]

print("[VexLoader] Loading BedWars module...")

--[[=====================================================================
    BEDWARS MODULE - MAIN SCRIPT
=====================================================================]]

-- Check if we're in BedWars
local placeId = game.PlaceId
if placeId ~= 6872274481 then
    warn("[VexLoader] Not in BedWars, skipping module")
    return
end

print("[VexLoader] BedWars detected! PlaceId: " .. placeId)

-- Wait for game to load
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game:GetService("Players").LocalPlayer

print("[VexLoader] Game loaded, initializing...")

--[[=====================================================================
    UTILITY FUNCTIONS
=====================================================================]]

local function getSharedState()
    return getgenv().shared or {}
end

local function getStore()
    return getgenv().store or {}
end

local function getBedWars()
    return getgenv().bedwars or {}
end

--[[=====================================================================
    MODULE LOADING
=====================================================================]]

-- Try to load additional modules
local function loadModule(name)
    local path = "vexloader/" .. name
    if isfile and isfile(path) then
        local content = readfile(path)
        if content then
            local func, err = loadstring(content, name)
            if func then
                local success, result = pcall(func)
                if success then
                    print("[VexLoader] Loaded module: " .. name)
                    return result
                else
                    warn("[VexLoader] Module error: " .. tostring(result))
                end
            else
                warn("[VexLoader] Module compile error: " .. tostring(err))
            end
        end
    end
    return nil
end

-- Load modules
loadModule("games/universal.lua")

-- Load place-specific modules
local placePath = "games/" .. tostring(placeId) .. ".lua"
loadModule(placePath)

-- Load profiles
local function loadProfile(name)
    local path = "vexloader/profiles/" .. name .. ".txt"
    if isfile and isfile(path) then
        local content = readfile(path)
        if content then
            print("[VexLoader] Loaded profile: " .. name)
            return content
        end
    end
    return nil
end

-- Load default profile
local profileName = shared.VexCustomProfile or "default"
loadProfile(profileName)

--[[=====================================================================
    MAIN EXECUTION
=====================================================================]]

print("[VexLoader] BedWars module loaded successfully!")
print("[VexLoader] VexLoader is ready!")

-- Return success
return true
