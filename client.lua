--[[
=====================================================================
 █████╗ ██╗   ██╗ █████╗ ██╗      ██████╗ ███╗   ██╗
██╔══██╗██║   ██║██╔══██╗██║     ██╔═══██╗████╗  ██║
███████║██║   ██║███████║██║     ██║   ██║██╔██╗ ██║
██╔══██║██║   ██║██╔══██║██║     ██║   ██║██║╚██╗██║
██║  ██║╚██████╔╝██║  ██║███████╗╚██████╔╝██║ ╚████║
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝
=====================================================================
🚀 AVALON DEVELOPMENT | Roleplay Systems & Scripts
📦 Script: avalon_bodyarmor
💬 Discord: discord.gg/avaloncity
👤 Author: Rafiki | Andy / Avalon City Dev Team
📅 Last Update: 2025-10-25
=====================================================================
--]]

local function useBodyArmor(itemName, armorValue, maleComponent, femaleComponent, labelText)
    local ped = cache.ped

    local success = lib.progressBar({
        duration = 5000,
        label = labelText or 'Ziehe Schutzweste an...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = false,
            car = true,
            combat = true
        },
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d'
        }
    })

    if not success then
        lib.notify({
            title = 'Schutzweste',
            description = 'Du hast aufgehört, die Weste anzuziehen.',
            type = 'error',
            duration = 4000
        })
        return
    end

    -- 🦺 Rüstung setzen
    SetPedArmour(ped, armorValue)

    -- 👕 Visuelle Darstellung
    local model = GetEntityModel(ped)
    if model == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped, 9, maleComponent.drawable, maleComponent.texture, 0)
    else
        SetPedComponentVariation(ped, 9, femaleComponent.drawable, femaleComponent.texture, 0)
    end

    lib.notify({
        title = 'Schutzweste',
        description = ('Du hast eine %s angelegt.'):format(labelText or 'Schutzweste'),
        type = 'success',
        duration = 4000
    })

    -- 🔹 Item entfernen
    TriggerServerEvent('ox_inventory:removeItem', itemName, 1)
end

-- 💼 Standard Body Armor
RegisterNetEvent('avalon_bodyarmor:useBodyArmor', function()
    useBodyArmor(
        'bodyarmor',      -- item name
        100,              -- armor value
        { drawable = 15, texture = 2 },  -- male
        { drawable = 17, texture = 2 },  -- female
        'Schutzweste'
    )
end)

-- 👮‍♂️ PD Light Armor
RegisterNetEvent('avalon_bodyarmor:usePdLight', function()
    useBodyArmor(
        'pd_lightarmor',
        75,
        { drawable = 65, texture = 0 },
        { drawable = 67, texture = 0 },
        'Leichte Schutzweste'
    )
end)

-- 🚔 PD Heavy Armor
RegisterNetEvent('avalon_bodyarmor:usePdHeavy', function()
    useBodyArmor(
        'pd_heavyarmor',
        100,
        { drawable = 62, texture = 5 },
        { drawable = 64, texture = 5 },
        'Schwere Schutzweste'
    )
end)
