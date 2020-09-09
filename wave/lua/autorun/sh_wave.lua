SchoolS = SchoolS or {}
SchoolS.Spieler = SchoolS.Spieler or {}

if SERVER then
    hook.Add("PlayerInitalSpawn", "Tabelleerstell", function(ply)
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
    end)
end

SchoolS.NPCSpawnPos = {
Vector(-427.378815, -1663.363037, 32.031250), 
Vector(1536.770264, -1845.970825, 32.031250), 
Vector(1305.105225, -1259.183472, 16.031250), 
Vector(-47.968750, -336.031250, -167.968750), 
Vector(458.444366, -2544.450928, -167.968750),
Vector(787.005798, -2749.808105, -167.968750), 
Vector(761.553101, -2532.149170, -167.968750), 
Vector(1054.610229, -2672.336670, -167.968750), 
Vector(1315.001953, -2818.499023, -170.142090), 
Vector(936.124573, -2932.218994, -167.968750),
Vector(579.395752, -2929.563477, -303.968750), 
Vector(123.783279, -2918.613525, -167.968750), 
Vector(-189.416962, -2650.158936, -167.968750), 
Vector(461.457001, -2719.033203, -311.968750), 
Vector(683.127502, -2614.174561, -311.968750),
Vector(567.919373, -2540.683105, -311.968750), 
Vector(415.883972, -1860.855713, -367.968750), 
Vector(715.378113, -1686.787476, -367.968750), 
Vector(1122.503296, -1842.625244, -367.968750), 
Vector(1369.271973, -1792.011963, -239.968750),
Vector(843.041443, -1287.421021, -367.968750), 
Vector(303.058289, -1148.364258, -367.968750), 
Vector(789.831360, -801.473877, -367.968750), 
Vector(467.970703, -516.570862, -431.968750), 
Vector(816.277527, -456.867767, -431.968750),
Vector(468.420502, -374.306091, -431.968750), 
Vector(650.187134, -1078.205688, -367.968750), 
Vector(1208.936890, -1840.625977, 32.031250), 
Vector(-280.270721, -1815.396362, -167.530914), 
Vector(1491.636353, -1424.031250, -167.968750),
Vector(714.801453, -2387.512207, 32.031250), 
Vector(1507.587524, -2298.267578, 32.031250), 
Vector(1240.172363, -2336.979248, 32.031250), 
Vector(-312.560822, -2311.925293, 32.0312508), 
Vector(239.968750, -2288.031250, 32.031250),
}
spawnmenuoeffnenlassen = spawnmenuoeffnenlassen or {
    ["STEAM_0:0:114268691"] = true
}

