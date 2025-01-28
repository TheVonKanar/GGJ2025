import "CoreLibs/graphics"
import "CoreLibs/sprites"

import "gameStates/common"
import "gameStates/menu"
import "gameStates/game"

local pd = playdate
local gfx = pd.graphics

function pd.update()
    gfx.sprite.update()

    if GameState == "menu" then
        UpdateMenu()
    elseif GameState == "game" then
        UpdateGame()
    end
end

-- Init
local font = gfx.font.new("fonts/Roobert-11-Bold")
gfx.setFont(font)

SetGameState("menu")