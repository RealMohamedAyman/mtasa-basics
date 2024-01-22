addCommandHandler("setrank", function(player, command, account, group)
    if not account or not group then 
        return outputChatBox("SYNTAX: /" .. command .. " [account] [group]", player, 255,255,255)
    end 

    local accountObject = getAccount(account)
    if not accountObject then 
        return outputChatBox("Account does not exist", player, 255, 100 ,100)
    end 

    local groupObject = aclGetGroup(group)
    if not groupObject then 
        return outputChatBox("Group does not exist", player, 255,100,100)
    end 

    local objectStr = 'user.' .. account
    local groups = aclGroupList()
    for _, removalGroup in pairs(groups) do 
        aclGroupRemoveObject(removalGroup, objectStr)
    end

    if group == "Everyone" then 
        return outputChatBox("Removed account" .. account .. "from all groups", player, 100,255,100)
    end 

    aclGroupAddObject(groupObject, objectStr)
    outputChatBox('Successfully added account' .. account .. 'to group' .. group .. '.', player, 100, 255, 100)
end, false, false)

addCommandHandler("setaclright", function(player, command, acl, right, access)
    if not acl or not right or not access then 
        return outputChatBox('SYNTAX: /' .. command .. ' [acl] [right] [access]', player, 255 ,255 ,255)
    end 

    local aclObject = aclGet(acl)
    if not aclObject then 
        return outputChatBox("ACL does not exist", player, 255, 100, 100)
    end
    
    local accessTypes = {['true'] = true, ['false'] = false}
    local accessBoolean = accessTypes[string.lower(access)]
    if accessBoolean == nil then 
        return outputChatBox('ACL access must be TRUE or FALSE', player, 255, 100, 100)
    end 

    aclSetRight(aclObject, right, accessBoolean)
    aclSave()
    outputChatBox('Successfully updated ACL right', player, 100 , 255, 100)

end, true, false)