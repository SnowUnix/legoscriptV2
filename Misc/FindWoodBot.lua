-- Settings
CheckSnowGlow = true
CheckSinister = true
CheckSpook = true
webhook = "webhookhere"

task.wait(3)

-- Script
function rejoin()
	local Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. "13822889" .. '/servers/Public?sortOrder=Asc&limit=100'))
	local Cursor = "none"
	local TableIds = {}

	Site = game:GetService("HttpService"):JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. tostring(game.PlaceId) .. '/servers/Public?sortOrder=Asc&limit=100'))

	for _,v in pairs(Site.data)do
		if tonumber(v.MaxPlayers) == tonumber(v.playing) then else
			table.insert(TableIds, v.id)
		end
	end

	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, TableIds[1], game.Players.LocalPlayer)

	-- Error Handler
	game:GetService("TeleportService").TeleportInitFailed:Connect(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,tostring(TableIds[math.random(1, table.getn(TableIds))]) , game.Players.LocalPlayer)
	end)
end

function handletree(v, tree)
	local send = "Found size " .. tostring(#v.Model:GetChildren() - 4) .. " " .. tostring(v.Model.TreeClass.Value) .. " tree in game " .. tostring(game.JobId)
	if tree == "Spook" then
		if #v.Model:GetChildren() - 4 >= 1 then
			syn.request({ Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({ ['content'] = send }),})
		end
	elseif tree == "SnowGlow" then
		if #v.Model:GetChildren() - 4 >= 35 then
			syn.request({ Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({ ['content'] = send }),})
		end
	elseif tree == "Sinister" then
		syn.request({ Url = webhook, Method = "POST", Headers = {["Content-Type"] = "application/json"}, Body = game:GetService("HttpService"):JSONEncode({ ['content'] = send }),})
	end
end

for _,v in pairs(game.Workspace:GetChildren())do
	if v.Name == "TreeRegion" then
		if v:FindFirstChild("Model") and v.Model:FindFirstChild("TreeClass") and v.Model:FindFirstChild("TreeClass").Value == "Spooky" and CheckSpook == true then
			handletree(v, "Spook")
		end
		if v:FindFirstChild("Model") and v.Model:FindFirstChild("TreeClass") and v.Model:FindFirstChild("TreeClass").Value == "SnowGlow" and CheckSnowGlow == true  then
			handletree(v, "SnowGlow")
		end
		if v:FindFirstChild("Model") and v.Model:FindFirstChild("TreeClass") and v.Model:FindFirstChild("TreeClass").Value == "Sinister" and CheckSinister == true then
			handletree(v, "Sinister")
		end
	end
end

task.wait(2)
rejoin()