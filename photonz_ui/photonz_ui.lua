--[[--------------------------------------------------------------------
photonz_ui

cvarlist: https://wowpedia.fandom.com/wiki/Console_variables

read individual cvar: /dump scriptErrors

set individual cvar: /run SetCVar("scriptErrors", 1)

set individual cvar to default: /run SetCVar("scriptErrors", GetCVarDefault("scriptErrors"))

reset all cvars to default: /console cvar_default
----------------------------------------------------------------------]]

local cvars = {

    lootUnderMouse          = "1",
    movieSubtitle                   = "1",
    showTimestamps              = "%H:%M",
    colorChatNamesByClass       = "1", 
    DisableAdvancedFlyingVelocityVFX = "1",
    empowerTapControls          = "1",
    expandBagBar                = "0",
    raidFramesDisplayIncomingHeals = "1",
    interactQuestItems          = "1",
    graphicsSpellDensity        = "4",
    graphicsShadowQuality       = "0",
    graphicsLiquidDetail        = "0",
    graphicsParticleDensity     = "5",
    graphicsSSAO                = "0",
    graphicsDepthEffects        = "0",
    graphicsComputeEffects      = "0",
    graphicsOutlineMode         = "0",
    graphicsProjectedTextures   = "1",
    graphicsEnvironmentDetail   = "0",
    worldMaxMipLevel            = "0",
    weatherDensity              = "0",
    componentTexLoadLimit       = "1",
    bodyQuota                   = "0",
    MaxObservedPetBattles       = "0",
    animFrameSkipLOD            = "1",
    advancedCombatLogging       = "1",
    lodObjectCullDist           = "1",
    lodObjectFadeScale          = "1",
    terrainLodDist              = "1",
    entityLodDist               = "5",
    entityLodOffset             = "5",
    groundEffectDensity         = "1",
    groundEffectDist            = "1",
    groundEffectFade            = "1",
    textureFilteringMode        = "0", 
    shadowRT                    = "0",
    shadowMode                  = "0",
    physicsLevel                = "0",
    renderscale                 = "1",
    farclip                     = "1",
    horizonStart                = "1",
    ResampleSharpness           = "-1",
    MSAAQuality                 = "0",
    MSAAAlphaTest               = "0",
    ffxAntiAliasingMode         = "0",
    ffxVenari                   = "0",
    ffxLingeringVenari          = "0",
    sunShafts                   = "0",
    ShowClassColorInFriendlyNameplate = "0",
    nameplatePlayerMaxDistance  = "60",
    nameplateOccludedAlphaMult = "1",
    nameplateHorizontalScale    = "1",
    nameplateMotionSpeed        = "0",
    nameplateMinAlpha           = "0",
    cameraDistanceMaxZoomFactor = "2.6", 
    scriptErrors    = "1",
    showTutorials   = "0",
    ffxGlow             = "0", 
    ffxDeath             = "0", 
    ffxNether             = "0", 
    maxFPS              = "999",
    violenceLevel         = "0", 
    }
    
local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_LOGIN")
f:SetScript("OnEvent", function()
    C_NamePlate.SetNamePlateFriendlySize(60, 30) -- Set friendly nameplate size
    print("photonz_ui loaded")

    -- Change nameplates to 1, 2, 3 in arena
    -- Set a local variable `U` for the `UnitIsUnit()` function
    local U = UnitIsUnit

    -- This function is called every time the nameplate of a unit is updated
    hooksecurefunc("CompactUnitFrame_UpdateName", function(F)
        -- Only do this for arena nameplates
        if IsActiveBattlefieldArena() and F.unit:find("nameplate") then
            -- Loop through each arena number (1-5) and check if this nameplate belongs to that arena
            for i = 1, 5 do 
                if U(F.unit, "arena" .. i) then
                    -- If this is the correct arena, set the nameplate text to the arena number and make it red
                    F.name:SetText(i)
                    F.name:SetTextColor(1, 0, 0, 1)
                    -- Exit the loop because we've found the correct arena
                    break 
                end 
            end 
        end 
    end)

    print("arena 123 script loaded")

    -- Loop through the cvars table using the pairs() function
    for cvar, value in pairs(cvars) do
        -- Convert the current value of the cvar to a string using tostring()
        local current = tostring(GetCVar(cvar))
        -- Check if the current value is different from the desired value
        if current ~= value then 
            -- If the values are different, set the cvar to the desired value using SetCVar()
            SetCVar(cvar, value)
            -- Print a message to the chat frame indicating that the cvar has been changed
            C_Timer.After(1, function()
                print("|cff00ff00SetCVar|r", cvar, "|cff00ff00=|r", value)
            end)
        end
    end
end)
