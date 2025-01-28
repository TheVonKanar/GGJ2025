local pd = playdate
local gfx = pd.graphics

-- Main Methods.
function LoadMenu()
end

function UnloadMenu()
end

function UpdateMenu()
    gfx.drawTextAligned("Balance ta bulle!", 200, 50, kTextAlignment.center)
    gfx.drawTextAligned("Press Ⓐ to start", 200, 110, kTextAlignment.center)

    if pd.buttonIsPressed(pd.kButtonA) then
        SetGameState("game")
    end
end