-- ARMOR MODULE - DECRYPTED

local player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")

if _G.AutoArmor == nil then _G.AutoArmor = true end
if _G.LastBuyTime == nil then _G.LastBuyTime = 0 end

local shopPosition = CFrame.new(-934.025, -28.149, 570.549)

-- Get current armor value
local function getArmor()
    local dataFolder = player:FindFirstChild("DataFolder")
    local info = dataFolder and dataFolder:FindFirstChild("Information")
    local armor = info and info:FindFirstChild("ArmorSave")
    return armor and tonumber(armor.Value) or 0
end

-- Main loop
local function autoArmorLoop()
    while true do
        task.wait(1.5)

        if _G.AutoArmor then
            local character = player.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")

            if root and getArmor() < 30 and (tick() - _G.LastBuyTime) > 10 then
                -- Save old position
                local oldCFrame = root.CFrame

                -- Teleport to armor shop
                root.CFrame = shopPosition + Vector3.new(0, 3, 0)
                task.wait(0.8)

                local tries = 0
                repeat
                    for _, shopItem in pairs(workspace.Ignored.Shop:GetChildren()) do
                        local part = shopItem:FindFirstChildWhichIsA("BasePart")

                        if part and (part.Position - root.Position).Magnitude < 20 then
                            local clickDetector = shopItem:FindFirstChildWhichIsA("ClickDetector", true)
                            if clickDetector then
                                fireclickdetector(clickDetector)
                                task.wait(0.4)
                            end
                        end
                    end

                    tries = tries + 1
                until getArmor() >= 45 or tries >= 5 or not _G.AutoArmor

                _G.LastBuyTime = tick()

                -- Return to old position
                root.CFrame = oldCFrame
                task.wait(2)
            end
        end
    end
end

task.spawn(autoArmorLoop)
