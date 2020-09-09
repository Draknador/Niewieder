hook.Add("Initialize", "Dateiencreate", function()
    if not file.Exists("meinlog", "DATA") then
        file.CreateDir("meinlog")
        file.Write("meinlog/draklog.txt", "//////////// IM FOLGENDEN HÄNGEN WIR DEN CONTENT AN ////////////")
    end
end)

hook.Add("SpawnMenuOpen", "spawnmenuoefnnen", function()
    if not spawnmenuoeffnenlassen[LocalPlayer():SteamID()] then return false end
end)

net.Receive("playerspawns", function(len)
    local ReceivedString = net.ReadString()
    local ply = LocalPlayer()
    ply:PrintMessage(HUD_PRINTTALK, "Der Spieler " .. ReceivedString .. " ist aufgetaucht!")
end)

function Logsdatei()
    if not file.Exists("derlog", "DATA") then
        file.CreateDir("derlog")
        file.Write("derlog/draknador.txt", "Hier d'runter entsteht Magie!")
    end
end

hook.Add("Initialize", "ErstelleDateien", Logsdatei)
net.Receive("playerspawns")

net.Receive("playerspawns", function()
    local Timestamp = os.time()
    local TimeString = os.date("%d.%m.%Y - %H:%M:%S", Timestamp)
    local spieler = net.ReadString()
    file.Append("derlog/draknador.txt", "\n[" .. TimeString .. "] " .. spieler .. " hat sich auf den Server verbunden.")
end)
