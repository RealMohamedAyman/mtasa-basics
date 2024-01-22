function spawnplayer()
    spawnPlayer(source, 0, 0, 5)
    fadeCamera(source, true)
    setCameraTarget(source, source)
end
addEventHandler("onPlayerJoin", root, spawnplayer)

