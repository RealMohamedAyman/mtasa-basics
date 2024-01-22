local window

local function getWindowPosition(width, height)
    local sWidth, sHeight = guiGetScreenSize()
    local x = (sWidth / 2) - (width / 2)
    local y = (sHeight / 2) - (height / 2)
    return x, y, width ,height
end 

local function isUsernameValid(username)
    return type(username) == 'string' and string.len(username) > 1
end

local function isPasswordValid(password)
    return type(password) == 'string' and string.len(password) > 1
end

addEvent("login-menu:open", true)
addEventHandler("login-menu:open", root, function()
    setCameraMatrix(0, 0, 100, 0, 100, 50)
    fadeCamera(true)
    showCursor(true, true)
    guiSetInputMode('no_binds')
    local x, y, width, height = getWindowPosition(400, 300)
    window = guiCreateWindow(x, y, width , height, 'Login', false)
    guiWindowSetMovable(window, false)
    guiWindowSetSizable(window, false)

    local usernameLabel = guiCreateLabel(10, 30, width - 20, 20, 'Username:', false, window)
    local usernameError = guiCreateLabel(80, 30, width - 90, 20, 'Username is invalid', false, window)
    guiLabelSetColor(usernameError, 255, 0, 0)
    guiSetVisible(usernameError, false)
    local usernameInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)

    local passwordLabel = guiCreateLabel(10, 90, width - 20, 20, 'Password:', false, window)
    local passwordError = guiCreateLabel(80, 90, width - 90, 20, 'Password is invalid', false, window)
    guiLabelSetColor(passwordError, 255, 0, 0)
    guiSetVisible(passwordError, false)
    local passwordInput = guiCreateEdit(10, 110, width - 20, 30, '', false, window)
    guiEditSetMasked(passwordInput, true)
    local loginButton = guiCreateButton(10, 150, width - 20, 30, 'Login', false, window)
    addEventHandler('onClientGUIClick', loginButton, function(button, state)
        if button ~= 'left' or state ~= 'up' then
            return
        end

        local username = guiGetText(usernameInput)
        local password = guiGetText(passwordInput)
        local inputValid = true

        if not isUsernameValid(username) then
            guiSetVisible(usernameError, true) 
            inputValid = false
        else 
            guiSetVisible(usernameError, false) 
        end 

        if not isPasswordValid(password) then
            guiSetVisible(passwordError, true) 
            inputValid = false 
        else
            guiSetVisible(passwordError, false) 
        end

        if not inputValid then 
            return
        end

        triggerServerEvent('auth:login-attemp', localPlayer, username, password)
    end, false)

    local registerButton = guiCreateButton(10, 190, width - 20, 30, 'Register', false, window)

    local forgotPasswordButton = guiCreateButton(10, 230, width - 20, 30, 'Forgot Password', false, window)
end)

addEvent("login-menu:close", true)
addEventHandler('login-menu:close', root, function()
    destroyElement(window)
    showCursor(false)
    guiSetInputMode('allow_binds')
end)