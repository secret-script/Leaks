--[[ 
    Cleaned Version: Silent Aim Hook
    Function:
    Intercepts RemoteEvent calls and replaces mouse position
    with predicted position of the target player.
]]

-- Configuration
local MAIN_EVENT_NAME = "MainEvent"
local UPDATE_MOUSE_EVENT = "UpdateMousePos"
local MOUSE_EVENT = "MousePos"
local PREDICTION_FACTOR = 0.165

-- Get raw metatable
local rawMeta = getrawmetatable(game)
local originalNamecall = rawMeta.__namecall
setreadonly(rawMeta, false)

-- Hook __namecall
rawMeta.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }

    -- Conditions for Silent Aim
    if _G.SilentEnabled 
        and not checkcaller()
        and method == "FireServer"
        and self.Name == MAIN_EVENT_NAME
    then
        -- Check if event is mouse position related
        if args[1] == UPDATE_MOUSE_EVENT or args[1] == MOUSE_EVENT then
            
            -- Find target player
            local targetPlayer = game.Players:FindFirstChild(_G.TargetName)
            if targetPlayer and targetPlayer.Character then
                
                local rootPart = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    
                    -- Predict position using velocity
                    local predictedPosition =
                        rootPart.Position + (rootPart.Velocity * PREDICTION_FACTOR)

                    -- Replace mouse position argument
                    args[2] = predictedPosition

                    -- Call original function with modified arguments
                    return originalNamecall(self, unpack(args))
                end
            end
        end
    end

    -- Default behavior
    return originalNamecall(self, ...)
end)

-- Restore read-only protection
setreadonly(rawMeta, true)




--[[
-- [[ JUJU_HUB_HEX_INTERFACE ]]
local _0x4D61696E = "\77\97\105\110\69\118\101\110\116"
local _0x55706461 = "\85\112\100\97\116\101\77\111\117\115\101\80\111\115"
local _0x4D6F7573 = "\77\111\117\115\101\80\111\115"
local _0x30313635 = (0.33/2) -- 0.165

local _0x4D54 = getrawmetatable(game)
local _0x4E43 = _0x4D54.__namecall
setreadonly(_0x4D54, false)

_0x4D54.__namecall = newcclosure(function(self, ...)
    local _0x4D = getnamecallmethod()
    local _0x41 = {...}
    
    if _G.SilentEnabled and not checkcaller() and _0x4D == "\70\105\114\101\83\101\114\118\101\114" and self.Name == _0x4D61696E then
        if _0x41[1] == _0x55706461 or _0x41[1] == _0x4D6F7573 then
            local _0x50 = game.Players:FindFirstChild(_G.TargetName)
            if _0x50 and _0x50.Character then
                local _0x48 = _0x50.Character:FindFirstChild("\72\117\109\97\110\111\105\100\82\111\111\116\80\97\114\116")
                if _0x48 then
                    _0x41[2] = _0x48.Position + (_0x48.Velocity * _0x30313635)
                    return _0x4E43(self, unpack(_0x41))
                end
            end
        end
    end
    return _0x4E43(self, ...)
end)

setreadonly(_0x4D54, true)
]]
