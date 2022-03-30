
-- Made by Vania#3000

-- CHANGE THE DISCORD_URL AND DISCORD_IMAGE
local DISCORD_NAME = "Vania Staff"
local DISCORD_URL = "DISCORD_WEBHOOK"
local DISCORD_IMAGE = "" -- must end with .jpg or .png


 AddEventHandler('chatMessage', function(source, name, message)
      if string.sub(message, 1, string.len("/")) ~= "/" then
		TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
      end
      CancelEvent()
  end)
  


local staff = "vnia.staff"

-- Editing stuff below this line will be at your own risk

Citizen.CreateThread(function()
	while true do 
		-- We wait a second and add it to their timeTracker 
		Wait(1000); -- Wait a second
		for k, v in pairs(timeTracker) do 
			timeTracker[k] = timeTracker[k] + 1;
		end 
	end 
end)
local people = { }
timeTracker = {}

RegisterCommand("vniaduty",function(source, args, rawCommand)
  local Playername = GetPlayerName(source)
  local StaffD = "**[Staff Duty]**"
  local name = "^7[ ^3Staff Duty ^7]"
  if IsPlayerAceAllowed(source, staff) and has_value(people, name, time) then
  msg = "^3 " .. Playername.." ^7is now ^8OFF ^7duty" -- Sends message in chat
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
        args = { name, msg }
      })
    removeFirst(people, name, time) -- Set table to remove the name
    local time = timeTracker[source];
    local now = os.time();
    local startPlusNow = time + now;
    local minutesActive = os.difftime(now, startPlusNow) / 60;
    minutesActive = math.floor(math.abs(minutesActive))
    sendToDiscord(StaffD, Playername.." is now **OFF** duty", 'Duration: ' .. minutesActive .. ' minutes') -- Sends message to discord
    timeTracker[source] = nil;
  local Playername = GetPlayerName(source)
  local name = "^7[ ^3Staff Duty ^7]"
  elseif IsPlayerAceAllowed(source, staff) and not has_value(people, name, time) then
    msg = "^3 " ..Playername.." ^7is now ^2ON ^7duty"
        TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(41, 41, 41, 0.6); border-radius: 3px;"><i class="fas fa-globe"></i> {0}:<br> {1}</div>',
        args = { name, msg }
      })
    table.insert(people, name)
    sendToDiscord(StaffD, Playername.. ' has gone **ON** duty', "Just started shift")
  end
  timeTracker[source] = 0;
end, true)

AddEventHandler('playerDropped', function(reason) 
  if has_value(people, name, time) then
      TriggerClientEvent('chat:addMessage', -1, { args = { "^7[ ^3Staff Duty ^7] (^3 " .. Playername.." ^7)", " is now ^8OFF ^7duty" }, color = 255, 0, 0 }) -- Sends message in chat
      removeFirst(people, name) -- Set table to remove the name
  local time = timeTracker[source];
  local now = os.time();
	local startPlusNow = now + time;
	local minutesActive = os.difftime(now, startPlusNow) / 60;
	minutesActive = math.floor(math.abs(minutesActive))
      sendToDiscord(StaffD, Playername..' is now **OFF** duty', 'Duration: ' .. minutesActive .. ' minutes') -- Sends message to discord
    end
    timeTracker[source] = nil;
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

function removeFirst(tbl, val)
  for i, v in ipairs(tbl) do
    if v == val then
      return table.remove(tbl, i)
    end
  end
end

function sendToDiscord(name, message, footer)
  local connect = {
        {
            ["color"] = "8663711",
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {
                ["text"] = "Made by Vania#3000 " .. footer .. " ",
            },
        }
    }
  PerformHttpRequest(DISCORD_URL, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end


