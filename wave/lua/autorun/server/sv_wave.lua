resource.AddWorkshop("886153712") -- CW 2.0 (Heavy)
resource.AddWorkshop("886125449") -- CW 2.0 (Pistolen)
resource.AddWorkshop("1637390029") -- Jewish Gadget
resource.AddWorkshop("886132509") -- SMG's
resource.AddWorkshop("886132509") -- Rifles
resource.AddWorkshop("886146194") -- Rangend Rifles
-- Waffen
resource.AddWorkshop("849418506") -- Dumbus Waifu
resource.AddWorkshop("974221698") -- Big Tiddy Anime Girl
resource.AddWorkshop("1199872159") -- Der Bankier
--NPC/Playermodel
resource.AddWorkshop("700550896") -- MAP Content
resource.AddWorkshop("1417950030") -- MAP
--Map + Map Content
resource.AddFile("wave/pumped.wav")
--Sounddatei "geht aber nicht"
util.AddNetworkString("playerspawns")
util.AddNetworkString("pumped")
local counterfuerdiewelle = 30
--local Timestamp = os.time()
--local TimeString = os.date("%d.%m.%Y - %H:%M:%S", Timestamp)

hook.Add("PlayerInitialSpawn", "joinnachricht", function(ply)
    net.Start("playerspawns")
    net.WriteString(ply:Nick())
    net.Broadcast()
    SchoolS.Spieler[ply:SteamID64()] = SchoolS.Spieler[ply:SteamID64()] or {}
    SchoolS.Spieler[ply:SteamID64()].counter = 0
    SchoolS.Spieler[ply:SteamID64()].heavyweg = SchoolS.Spieler[ply:SteamID64()].heavyweg or {}
    SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 = 0
    SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy2 = 0
    SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy3 = 0
    SchoolS.Spieler[ply:SteamID64()].agilweg = SchoolS.Spieler[ply:SteamID64()].agilweg or {}
    SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 = 0
    SchoolS.Spieler[ply:SteamID64()].agilweg.agil2 = 0
    SchoolS.Spieler[ply:SteamID64()].agilweg.agil3 = 0

    timer.Simple(1, function()
        Give("khr_gsh18")
        ply:SetWalkSpeed("300")
        ply:SetRunSpeed("300")
        ply:SetAmmo(150, "9x19MM", true)
    end)
end)

hook.Add("PlayerDeath", "wennderspielerstirbt", function(victim, inflictor, attacker)
    SchoolS.Spieler[victim:SteamID64()].counter = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy1 = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy2 = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy3 = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy4 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil1 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil2 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil3 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil4 = 0
    victim:SetModel("models/iaschool/iaschool_pm.mdl")
    victim:StripWeapons()
    victim:StripAmmo()

    timer.Simple(3, function()
        victim:SetWalkSpeed("300")
        victim:SetRunSpeed("300")
        victim:Give("khr_gsh18")
        victim:SetAmmo(150, "9x19MM", true)
    end)
end)

hook.Add("PlayerSpawn", "PlayerSpawnTest", function(ply)
    ply:SetModel("models/iaschool/iaschool_pm.mdl")

    timer.Simple(00000.1, function()
        ply:Freeze(true)
        ply:Give("khr_gsh18")
        ply:SetWalkSpeed("300")
        ply:SetRunSpeed("300")
        ply:SetAmmo(150, "9x19MM", true)
        ply:StripWeapon("weapon_shotgun")
        ply:StripWeapon("weapon_smg1")
        ply:StripWeapon("weapon_357")
        ply:StripWeapon("weapon_crowbar")
        ply:StripWeapon("weapon_pistol")
        ply:StripWeapon("weapon_physcannon")
        ply:StripWeapon("weapon_crossbow")
        ply:StripWeapon("weapon_rpg")
        ply:StripWeapon("weapon_ar2")
        ply:StripWeapon("weapon_frag")
        ply:StripWeapon("weapon_frag")
        ply:StripWeapon("gmod_camera")
        ply:StripWeapon("weapon_physgun")
        ply:StripWeapon("gmod_tool")
    end)

    timer.Simple(10, function()
        ply:Freeze(false)
    end)
end)

hook.Add("OnNPCKilled", "killcount", function(npc, attacker, inflictor)
    if attacker:IsPlayer() then
        counterfuerdiewelle = counterfuerdiewelle - 1
        SchoolS.Spieler[attacker:SteamID64()].counter = SchoolS.Spieler[attacker:SteamID64()].counter + 1
        attacker:ChatPrint("Die Zahl deiner eliminierten Gegner beträgt " .. SchoolS.Spieler[attacker:SteamID64()].counter .. "! Die Verbliebenden sind: " .. counterfuerdiewelle .. "!")
        --file.Append("unsertest/draklog.txt", "\n[" .. TimeString .. "] " .. npc .. " wurde getötet von: " .. attacker .. "!")
    end
end)

hook.Add("PlayerSay", "hilfesowiewellestarten", function(ply, text)
    -- "help" command, dieser legt nach dem schreiben "help" in den Chat die hier unten festgelegten Zeilen fest.
    if string.lower(text) == "help" then
        ply:PrintMessage(HUD_PRINTTALK, "Einen angenehmen Tag wünsche ich dir " .. ply:Nick() .. "!")
        local zaehler = 0

        timer.Create("Hilfe", 2, 3, function()
            if zaehler == 0 then
                ply:PrintMessage(HUD_PRINTTALK, "In diesem Spielmodus geht es darum, in jeder Welle eine bestimmte Anzahl an Gegnern zu eliminieren. Die Wellenaufteilung sieht wie folgt aus")
                zaehler = 1
            elseif zaehler == 1 then
                ply:PrintMessage(HUD_PRINTTALK, "In jeder Welle kannst du dir eine Klasse auswählen, diese führst du bis zur letzten Welle weiter. Nach jeder abgeschlossenen Welle erweiterst du deine Klasse, sowohl negative als auch positive Effekte passieren! Überlege dir also deine Wahl gut!")
                zaehler = 2
            elseif zaehler == 2 then
                ply:PrintMessage(HUD_PRINTTALK, "Die jeweiligen Counter sehen wie folgt aus: 1. Klasse 10 Eliminierungen | 2. Klasse: 30Eliminierungen | 3. Klasse: 45")
            end
        end)
        -- Codes, die ich gebrauche um verschiedene Sachen im Game umzustellen

        return ""
    elseif string.lower(text) == "unfreeze" then
        --file.Append("unsertest/befehle.txt", "\n[" .. TimeString .. "] " .. ply .. " hat folgenden Befehl eingegeben: " .. text)
        ply:Freeze(false)

        return ""
    elseif string.lower(text) == "freeze" then
        --file.Append("unsertest/befehle.txt", "\n[" .. TimeString .. "] " .. ply .. " hat folgenden Befehl eingegeben: " .. text)
        ply:Freeze(true)

        return ""
    elseif string.lower(text) == "s" then
        --Hab kein Bock immer "kill" in der Konsole einzutippen
        ply:Kill()

        return ""
    elseif string.lower(text) == "cleanup" then
        game.CleanUpMap()

        return ""
    elseif string.lower(text) == "wellestart" then
        game.CleanUpMap()
        net.Start("pumped")
        net.WriteBool(true)
        net.Broadcast()

        -- Der komplette Code, um eine Welle zu starten
        for k, v in pairs(player.GetAll()) do
            v:Spawn()
        end

        for i = 1, 31 do
            timer.Simple(2, function()
                if i <= 10 then
                    local npc1 = ents.Create("npc_metropolice")
                    npc1:SetPos(SchoolS.NPCSpawnPos[i])
                    npc1:Spawn()
                    npc1:Give("weapon_smg1")
                elseif i <= 20 and i > 10 then
                    local npc2 = ents.Create("npc_metropolice")
                    npc2:SetPos(SchoolS.NPCSpawnPos[i])
                    npc2:Spawn()
                    npc2:Give("weapon_smg1")
                elseif i <= 30 and i > 20 then
                    local npc3 = ents.Create("npc_metropolice")
                    npc3:SetPos(SchoolS.NPCSpawnPos[i])
                    npc3:Spawn()
                    npc3:Give("weapon_smg1")
                    counterfuerdiewelle = counterfuerdiewelle + 30
                end
            end)
        end
    elseif string.lower(text) == "agil" and SchoolS.Spieler[ply:SteamID64()].counter >= 10 then
        -- Die Wege
        ply:PrintMessage(HUD_PRINTTALK, "Du gehst nun den agilen Weg!")
        ply:KillSilent()
        ply:Spawn()

        timer.Create("agil1", 1, 2, function()
            if SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 == 0 then
                ply:SetRunSpeed("200")
                ply:SetWalkSpeed("220")
                ply:SetModel("models/player/dewobedil/sharo_kirima/maid_p.mdl")
                ply:StripWeapons()
                ply:StripAmmo()
                SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 = 1
            elseif SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 == 1 then
                ply:Give("khr_rugermk3")
                ply:GiveAmmo(150, ".22LR", true)
            end
        end)

        return ""
    elseif string.lower(text) == "heavy" and SchoolS.Spieler[ply:SteamID64()].counter >= 10 then
        ply:PrintMessage(HUD_PRINTTALK, "Du gehst nun den schweren Weg!")
        ply:KillSilent()
        ply:Spawn()

        timer.Create("heavy1", 1, 2, function()
            timer.Simple(1, function()
                if SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 == 0 then
                    ply:SetWalkSpeed("165")
                    ply:SetRunSpeed("175")
                    ply:SetModel("models/player/dewobedil/maid_dragon/lucoa/default_p.mdl")
                    ply:StripWeapons()
                    ply:StripAmmo()
                    SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 = 1
                elseif SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 == 1 then
                    timer.Simple(5, function()
                        ply:Give("khr_mp40")
                        ply:GiveAmmo(200, "9x19mm", true)
                        SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 = 2
                        ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 30 Eliminierungen mit dem Befehl: upgradeh ändern.")
                    end)
                end
            end)
        end)

        return ""
    elseif (string.lower(text) == "upgradea" and SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 == 2 and SchoolS.Spieler[ply:SteamID64()].counter >= 30) then
        ply:KillSilent()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_p90")
            ply:SetWalkSpeed("210")
            ply:GiveAmmo(200, "5.7x28MM", true)
            ply:SetModel("models/player/dewobedil/sharo_kirima/maid_p.mdl")
            SchoolS.Spieler[ply:SteamID64()].agilweg.agil2 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 45 Eliminierungen mit dem Befehl: upgradea1 ändern.")
        end)

        return ""
    elseif (string.lower(text) == "upgradeh" and SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 == 2 and SchoolS.Spieler[ply:SteamID64()].counter >= 30) then
        ply:SetWalkSpeed("175")
        ply:SetRunSpeed("175")
        ply:KillSilent()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_cz858")
            ply:GiveAmmo(200, "7.62x39MM", true)
            ply:SetModel("models/player/dewobedil/sharo_kirima/maid_p.mdl")
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 45 Eliminierungen mit dem Befehl: upgradeh1 ändern.")
            SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy2 = 1
        end)

        return ""
    elseif (string.lower(text) == "upgradea1" and SchoolS.Spieler[ply:SteamID64()].agilweg.agil2 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 45) then
        ply:SetRunSpeed("240")
        ply:SetWalkSpeed("230")
        ply:KillSilent()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_aek971")
            ply:SetWalkSpeed("220")
            ply:GiveAmmo(200, "5.45x39MM", true)
            ply:SetModel("models/player/dewobedil/sharo_kirima/maid_p.mdl")
            SchoolS.Spieler[ply:SteamID64()].agilweg.agil3 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 60 Eliminierungen mit dem Befehl: upgradea2 ändern.")
        end)

        return ""
    elseif (string.lower(text) == "upgradeh1" and SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy2 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 45) then
        ply:SetWalkSpeed("165")
        ply:SetRunSpeed("175")
        ply:KillSilent()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_pkm")
            ply:GiveAmmo(300, "7.62x54MMR", true)
            ply:SetModel("models/player/dewobedil/sharo_kirima/maid_p.mdl")
            SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy3 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 60 Eliminierungen mit dem Befehl: upgradeh2 ändern.")
        end)
    elseif (string.lower(text) == "upgradea2" and SchoolS.Spieler[ply:SteamID64()].agilweg.agil3 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 60) then
        ply:SetWalkSpeed("220")
        ply:SetRunSpeed("230")
        ply:KillSilent()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_vector")
            ply:Give("weapon_bugbait")
            ply:GiveAmmo(500, ".45 ACP", true)
            ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            SchoolS.Spieler[ply:SteamID64()].agilweg.agil4 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Der Weg ist hiermit zu ende, danke für's spielen! Natürlich bedanke ich mich auch bei diesen Leuten die mir dabei geholfen haben: Hiraku, Berkaaay, Screed.")
        end)
    elseif (string.lower(text) == "upgradeh2" and SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy3 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 60) then
        ply:SetWalkSpeed("160")
        ply:SetRunSpeed("175")
        ply:KillSilent()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_hmg")
            ply:Give("weapon_bugbait")
            ply:GiveAmmo(400, ".50 BMG", true)
            ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy4 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Der Weg ist hiermit zu ende, danke für's spielen! Natürlich bedanke ich mich auch bei diesen Leuten die mir dabei geholfen haben: Hiraku, Berkaaay, Screed.")
        end)

        return ""
    end
end)
--[[


hook.Add("Think", "wenndiedrecksnpcsihreverdammtewaffedroppen", function(npc, ply)
if npc1 or npc2 or npc3 DropObject() then
    clean

end)


--[[
    victim:StripWeapons()
    victim:StripAmmo()

    timer.Simple(3, function()
        victim:SetWalkSpeed("300")
        victim:SetRunSpeed("300")
        victim:Give("khr_gsh18")
        victim:SetAmmo(150, "9x19MM", true)
    end)

--[[ply:StripWeapon("weapon_shotgun")
        ply:StripWeapon("weapon_smg1")
        ply:StripWeapon("weapon_357")
        ply:StripWeapon("weapon_crowbar")
        ply:StripWeapon("weapon_pistol")
        ply:StripWeapon("weapon_physcannon")
        ply:StripWeapon("weapon_crossbow")
        ply:StripWeapon("weapon_rpg")
        ply:StripWeapon("weapon_ar2")
        ply:StripWeapon("weapon_frag")
--hook.Add("PlayerDeath", "wennderspielerstirbt", function(victim, inflictor, attacker) --victim: --end)
----------------------------------------------------------------------------------------------------------------------
and SchoolS.Spieler[ply:SteamID64()].counter >= 10 then
---------------------
timer.Simple(10, function()
                    ply:Freeze(false)
                end)

                ply:Freeze(true)
                ------------------------
                hook.Add("Think", "Wennwellestartet", function()
    if counterfuerdiewelle == 0 then
        net.Start("pumped")
        net.WriteBool(true)
        net.Broadcast()

        for i = 1, 30 do
            timer.Simple(1, function()
                if i <= 10 then
                    local npc1 = ents.Create("npc_metropolice")
                    npc1:SetPos(SchoolS.NPCSpawnPos[i])
                    npc1:Spawn()
                    npc1:Give("weapon_smg1")
                elseif i <= 20 and i > 10 then
                    local npc2 = ents.Create("weapon_shotgun")
                    npc2:SetPos(SchoolS.NPCSpawnPos[i])
                    npc2:Spawn()
                    npc1:Give("weapon_smg1")
                elseif i <= 30 and i > 20 then
                    local npc3 = ents.Create("npc_metropolice")
                    npc3:SetPos(SchoolS.NPCSpawnPos[i])
                    npc3:Spawn()
                    npc1:Give("weapon_smg1")
                    counterfuerdiewelle = 30
                end
            end)
        end
    else
        return false
    end
end)
--------------------------------------------------
        timer.Create("freezen", 15, 2, function()
            local freezer = 0

            if freezer == 0 then
                ply:Freeze(true)
                freezer = freezer + 1
            elseif freezer == 1 then
                ply:Freeze(false)
            end
_________________________________________
    elseif string.lower(text) == agil then
        ply:StripWeapons
        ply:GetModel("models/player/dewobedil/sharo_kirima/maid_p.mdl")
        ply:StripAmmo
and SchoolS.Spieler[ply:SteamID64()].counter >= 10 then
---------------------
npc_sharo_kirima_maid_e
---------------------
76561198063946583
--------------------
if SchoolS.Spieler[attacker:SteamID64()].counter <= 10 then
            attacker:ChatPrint("Du hast nun die Wahl zwischen heavy sowie agil! Diese beiden Klassen bilden den Anfang umd verbessern sich je nach abgeschlossener Anzahl an erlegten Gegnern.")
        end]]
--------------------------------------
--   timer.Simple(5, function()
--   timer.Stop("heavy1timer")
--   ply:Freeze(false)
--  end)
--        timer.Simple(5, function()
--   timer.Stop("heavy1timer")
--   ply:Freeze(false)
-- end)
--  timer.Create("heavy1timer", 2, 2)]]