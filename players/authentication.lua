local MINIMUM_PASSWORD_LENGTH = 6
local function isPasswordValid(password)
    return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end


addCommandHandler("register", function(player, command, username, password) 

    if not username or not password then
        return outputChatBox("SYNTAX: /" .. command .. " [username] [password]", player, 255, 255, 255)
    end

    if getAccount(username) then
        return outputChatBox("An account already exist with that name", player, 255, 100, 100)
    end

    if not isPasswordValid(password) then 
        return outputChatBox("The entered password was not valid", player, 255, 100, 100)
    end


    passwordHash(password, 'bcrypt', {}, function(hashedPassword)
    
        local account = addAccount(username, hashedPassword)
        setAccountData(account, 'hashed_password', hashedPassword)
        outputChatBox("Your account has been created", player, 100, 255, 100)
    end)
end,false, false)

addEvent("auth:login-attemp", true)
addEventHandler("auth:login-attemp", root, function(username, password) 

    local account = getAccount(username)
    if not account then 
        return outputChatBox("No such account could be found with that username or password", source, 255, 100, 100)
    end 

    local hashedPassword = getAccountData(account, 'hashed_password')
    local player = source
    passwordVerify(password, hashedPassword, function(isValid) 
        if not isValid then
            return outputChatBox("No such account could be found with that username or password", player, 255, 100, 100)
        end 

        if logIn(player, account, hashedPassword) then
            spawnPlayer(player, 0, 0, 10)
            setCameraTarget(player, player)
            return triggerClientEvent(player, 'login-menu:close', player)
        end

        return outputChatBox('An error occured while attemping login', player, 255, 100, 100)

    end)
end)


addCommandHandler("accountLogout", function(player)
    logOut(player)
end, false, false)