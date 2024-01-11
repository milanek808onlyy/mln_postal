RegisterCommand("postal", function(source, args, raw)
	local input = lib.inputDialog('GPS settings', {{type = 'number', label = 'Postal Code', description = 'Enter the postal code you want to set the GPS to', required = true, min = 1, max = #mln.Postals}})
	if input then
		Postal(tostring(input[1]))
	end
end, false)

Citizen.CreateThread(function()	
	TriggerEvent('chat:addSuggestion', '/postal', 'Setting the GPS route to the designated postal')
end)

function Postal(postalCode)
	local postalCode_coords = vector2(0,0)
	for i = 1, #mln.Postals, 1 do
		if mln.Postals[i].code == postalCode then
			postalCode_coords = vector2(mln.Postals[i].x, mln.Postals[i].y)
		end
	end
	
	if postalCode_coords.x ~= 0.0 and postalCode_coords.y ~= 0.0 then
		SetNewWaypoint(postalCode_coords.x, postalCode_coords.y)
		lib.notify({title="GPS",description="The route was set to post "..postalCode,type='success'})
	else
		lib.notify({title="GPS",description="Postal "..postalCode.." is invalid!",type='error'})
	end
	
end


--[[--------------------------]]--
--[[  Created by milanek808only  ]]--
--[[--------------------------]]--