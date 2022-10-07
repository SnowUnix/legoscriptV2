local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. "13822889" .. '/servers/Public?sortOrder=Asc&limit=100'))
local Cursor = "none"
local TableIds = {}
local x = 1

Site = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=100'))

for i,v in pairs(Site.data)do
	if tonumber(v.MaxPlayers) == tonumber(v.playing) then else
		table.insert(TableIds, v.id)
	end
end

game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, tostring(TableIds[math.random(1, table.getn(TableIds))]) , game.Players.LocalPlayer)

-- Error Handler
game:GetService("TeleportService").TeleportInitFailed:Connect(function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,tostring(TableIds[math.random(1, table.getn(TableIds))]) , game.Players.LocalPlayer)
end)
