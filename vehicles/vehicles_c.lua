addCommandHandler("flycar", function()
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if not vehicle then 
        outputChatBox('You are not in vehicle', 255, 100, 100)
    end 

    setWorldSpecialPropertyEnabled('aircars', true)
end)