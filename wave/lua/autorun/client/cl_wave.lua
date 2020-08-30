sound.Add({
    name = "pumped",
    channel = CHAN_STATIC,
    volume = 35,
    level = 100,
    pitch = {95, 110},
    sound = "wave/pumped.wav"
})
/*


function icherstelleeinenlog()
    if not file.Exists("meinlog", "DATA") then
        file.CreateDir("meinlog")
        file.Write("meinlog/draklog.txt", "//////////// IM FOLGENDEN HÄNGEN WIR DEN CONTENT AN ////////////")
        file.Write("meinlog/befehle.txt")
    end
end

hook.Add("Initialize", "macheinedatei", icherstelleeinenlog)
*/

hook.Add("SpawnMenuOpen", "spawnmenuoefnnen", function()
    if not spawnmenuoeffnenlassen[LocalPlayer():SteamID()] then
        return false
    else
        return true
    end
end)

net.Receive("pumped", function(len)
    local ply = LocalPlayer()
    local spielpumpedup = net.ReadBool()

    if (spielpumpedup) then
        ply:EmitSound("pumped")

        if not timer.Exists("PumpedSound") then
            timer.Create("PumpedSound", 51, 0, function()
                ply:EmitSound("pumped")
            end)
        end
    end
end)

net.Receive("playerspawns", function(len)
    local ReceivedString = net.ReadString()
    local ply = LocalPlayer()
    ply:PrintMessage(HUD_PRINTTALK, "Der Spieler " .. ReceivedString .. " ist aufgetaucht!")
end)

concommand.Add("stoploop", function()
    timer.Stop("PumpedSound")
end)

function GM:PlayerSetModel(ply)
    if not playermodelsetzten[LocalPlayer():SteamID()] then
        return false
    else
        ply:SetModel("models/player/shi/felix_argyle.mdl")
    end
end