resource.AddWorkshop("886153712") -- CW 2.0 (Heavy)
resource.AddWorkshop("886125449") -- CW 2.0 (Pistolen)
resource.AddWorkshop("1637390029") -- Jewish Gadget
resource.AddWorkshop("886132509") -- SMG's
resource.AddWorkshop("886132509") -- Rifles
resource.AddWorkshop("886146194") -- Rangend Rifles
-- Waffen
resource.AddWorkshop("1199872159") -- Der Bankier
-- NPC/Playermodel
resource.AddWorkshop("667484197") -- MAP 
-- Map + Map Content
resource.AddFile("wave/pumped.wav")
-- Sounddatei "geht aber nicht"
util.AddNetworkString("playerspawns")
util.AddNetworkString("pumped")
local counterfuerdiewelle = 30

hook.Add("PlayerInitialSpawn", "joinnachricht", function(ply)
    net.Start("playerspawns")
    net.WriteString(ply:Name())
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
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy1 = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy2 = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy3 = 0
    SchoolS.Spieler[victim:SteamID64()].heavyweg.heavy4 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil1 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil2 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil3 = 0
    SchoolS.Spieler[victim:SteamID64()].agilweg.agil4 = 0
    SchoolS.Spieler[victim:SteamID64()].counter = 0
    victim:StripWeapons()
    victim:StripAmmo()
end)

hook.Add("PlayerSpawn", "PlayerSpawnTest", function(ply)
    timer.Simple(0.1, function()
        ply:StripWeapons()
        ply:Give("khr_gsh18")
        ply:SelectWeapon("khr_gsh18")
        ply:SetAmmo(150, "9x19MM", true)
    end)
end)

hook.Add("OnNPCKilled", "killcount", function(npc, attacker, inflictor)
    --Timestamp = os.time()
    --local TimeString = os.date("%d.%m.%Y - %H:%M:%S", Timestamp)
    --file.Append("meinlog/draklog.txt", "\n[" .. TimeString .. "] test wurde getötet von: " .. attacker .. "!")
    --file.Append("meinlog/draklog.txt", "test")
    if attacker:IsPlayer() then
        counterfuerdiewelle = counterfuerdiewelle - 1
        SchoolS.Spieler[attacker:SteamID64()].counter = SchoolS.Spieler[attacker:SteamID64()].counter + 1
        attacker:ChatPrint("Die Zahl deiner eliminierten Gegner beträgt " .. SchoolS.Spieler[attacker:SteamID64()].counter .. "! Die Verbliebenden sind: " .. counterfuerdiewelle .. "!")
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
    elseif string.lower(text) == "gimme" then
        SchoolS.Spieler[ply:SteamID64()].counter = SchoolS.Spieler[ply:SteamID64()].counter + 20
        ply:ChatPrint("Du hast deine Zahl automatisch um 20 Punkte auf: " .. SchoolS.Spieler[ply:SteamID64()].counter .. " erhöht!")

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
        ply:KillSilent()

        return ""
    elseif string.lower(text) == "cleanup" then
        game.CleanUpMap()
        timer.Stop("wellestarten")

        return ""
    elseif string.lower(text) == "wellestart" then
        game.CleanUpMap()
        --net.Start("pumped")
        --net.WriteBool(true)
        --net.Broadcast()
        counterfuerdiewelle = 36

        -- Der komplette Code, um eine Welle zu starten
        for k, v in pairs(player.GetAll()) do
            v:Spawn()

            timer.Simple(1, function()
                v:Give("khr_gsh18")
                v:SelectWeapon("khr_gsh18")
                v:SetAmmo(150, "9x19MM", true)
                v:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            end)
        end

        for i = 1, 36 do
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
                end
            end)
        end

        timer.Simple(55, function()
            for k, v in pairs(player.GetAll()) do
                v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 5 Sekunden")
            end
        end)

        timer.Simple(56, function()
            for k, v in pairs(player.GetAll()) do
                v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 4 Sekunden")
            end
        end)

        timer.Simple(57, function()
            for k, v in pairs(player.GetAll()) do
                v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 3 Sekunden")
            end
        end)

        timer.Simple(58, function()
            for k, v in pairs(player.GetAll()) do
                v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 2 Sekunden")
            end
        end)

        timer.Simple(59, function()
            for k, v in pairs(player.GetAll()) do
                v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 1 Sekunden")
            end
        end)

        timer.Create("wellestarten", 60, 4, function()
            game.CleanUpMap()
            counterfuerdiewelle = 36

            for k, v in pairs(player.GetAll()) do
                timer.Simple(4, function()
                    v:Spawn()
                    v:Give("khr_gsh18")
                    v:SetAmmo(150, "9x19MM", true)
                    v:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
                end)
            end

            for i = 1, 36 do
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
                    end
                end)
            end

            timer.Simple(55, function()
                for k, v in pairs(player.GetAll()) do
                    v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 5 Sekunden")
                end
            end)

            timer.Simple(56, function()
                for k, v in pairs(player.GetAll()) do
                    v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 4 Sekunden")
                end
            end)

            timer.Simple(57, function()
                for k, v in pairs(player.GetAll()) do
                    v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 3 Sekunden")
                end
            end)

            timer.Simple(58, function()
                for k, v in pairs(player.GetAll()) do
                    v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 2 Sekunden")
                end
            end)

            timer.Simple(59, function()
                for k, v in pairs(player.GetAll()) do
                    v:PrintMessage(HUD_PRINTTALK, "Das Spiel startet eine neue Runde in 1 Sekunden")
                end
            end)
        end)

        return ""
    elseif string.lower(text) == "agil" and SchoolS.Spieler[ply:SteamID64()].counter >= 10 then
        -- Die Wege
        ply:PrintMessage(HUD_PRINTTALK, "Du gehst nun den agilen Weg!")
        ply:Spawn()

        timer.Create("agil1", 1, 2, function()
            if SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 == 0 then
                ply:SetRunSpeed("200")
                ply:SetWalkSpeed("220")
                ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
                ply:StripWeapons()
                ply:StripAmmo()
                ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 30 Eliminierungen mit dem Befehl: upgradea ändern.")
                SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 = 1
            elseif SchoolS.Spieler[ply:SteamID64()].agilweg.agil1 == 1 then
                ply:Give("khr_rugermk3")
                ply:GiveAmmo(150, ".22LR", true)
            end
        end)

        return ""
    elseif string.lower(text) == "heavy" and SchoolS.Spieler[ply:SteamID64()].counter >= 10 then
        ply:Spawn()
        ply:PrintMessage(HUD_PRINTTALK, "Du gehst nun den schweren Weg!")

        timer.Create("heavy1", 1, 2, function()
            timer.Simple(1, function()
                if SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 == 0 then
                    ply:SetWalkSpeed("165")
                    ply:SetRunSpeed("175")
                    ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
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
        ply:Spawn()
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_p90")
            ply:SetWalkSpeed("210")
            ply:GiveAmmo(200, "5.7x28MM", true)
            ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            SchoolS.Spieler[ply:SteamID64()].agilweg.agil2 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 45 Eliminierungen mit dem Befehl: upgradea1 ändern.")
        end)

        return ""
    elseif (string.lower(text) == "upgradeh" and SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy1 == 2 and SchoolS.Spieler[ply:SteamID64()].counter >= 30) then
        ply:Spawn()
        ply:SetWalkSpeed("175")
        ply:SetRunSpeed("175")
        ply:StripWeapons()
        ply:StripAmmo()

        timer.Simple(1, function()
            ply:Give("khr_cz858")
            ply:GiveAmmo(200, "7.62x39MM", true)
            ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 45 Eliminierungen mit dem Befehl: upgradeh1 ändern.")
            SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy2 = 1
        end)

        return ""
    elseif (string.lower(text) == "upgradea1" and SchoolS.Spieler[ply:SteamID64()].agilweg.agil2 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 45) then
        ply:SetRunSpeed("240")
        ply:SetWalkSpeed("230")
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_aek971")
            ply:SetWalkSpeed("220")
            ply:GiveAmmo(200, "5.45x39MM", true)
            ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            SchoolS.Spieler[ply:SteamID64()].agilweg.agil3 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 60 Eliminierungen mit dem Befehl: upgradea2 ändern.")
        end)

        return ""
    elseif (string.lower(text) == "upgradeh1" and SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy2 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 45) then
        ply:SetWalkSpeed("165")
        ply:SetRunSpeed("175")
        ply:StripWeapons()
        ply:StripAmmo()
        ply:Spawn()

        timer.Simple(1, function()
            ply:Give("khr_pkm")
            ply:GiveAmmo(300, "7.62x54MMR", true)
            ply:SetModel("models/player/suits/npc/the_ortho_jew.mdl")
            SchoolS.Spieler[ply:SteamID64()].heavyweg.heavy3 = 1
            ply:PrintMessage(HUD_PRINTTALK, "Du kannst deine Klasse mit mit 60 Eliminierungen mit dem Befehl: upgradeh2 ändern.")
        end)
    elseif (string.lower(text) == "upgradea2" and SchoolS.Spieler[ply:SteamID64()].agilweg.agil3 == 1 and SchoolS.Spieler[ply:SteamID64()].counter >= 60) then
        ply:SetWalkSpeed("220")
        ply:SetRunSpeed("230")
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
        ply:Spawn()
        ply:SetWalkSpeed("160")
        ply:SetRunSpeed("175")
        ply:StripWeapons()
        ply:StripAmmo()

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

hook.Add("Think", "waffen", function() end)
--[=[

]=]
