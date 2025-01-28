GameState = ""

function SetGameState(state)
    if GameState == "menu" then
        UnloadMenu()
    elseif GameState == "game" then
        UnloadGame()
    end

    GameState = state

    if GameState == "menu" then
        LoadMenu()
    elseif GameState == "game" then
        LoadGame()
    end
end