import "../data/data"

local pd = playdate
local gfx = pd.graphics

-- Global variables
Score = 0

-- Local variables
local timerMax = 60 * 30 -- seconds * FPS
local timer = 0

local bubbleTextInfo = {}
local bubbleAvailableTexts = {}
local bubbleImage = gfx.image.new("images/bubble")
local bubbleSprite = gfx.sprite.new(bubbleImage)
bubbleSprite:moveTo(208, 68)

local handImageIndex = 1
local handImageTable = gfx.imagetable.new("images/hand-table-96-96")
local handSprite = gfx.sprite.new(handImageTable:getImage(handImageIndex))
local crankPower = 0
local crankPowerGoal = 600
handSprite:moveTo(328, 160)

local function pickNewBubbleText()
    if #bubbleAvailableTexts == 0 then
        for index, value in pairs(BubbleTexts) do
            bubbleAvailableTexts[index] = value
        end
    end

    local random = math.random(#bubbleAvailableTexts)
    bubbleTextInfo = table.remove(bubbleAvailableTexts, random)
end

local function updateTimer()
    -- Increment timer
    timer += 1

    -- Draw bar    
    local barHeight = 240 - (timer / timerMax) * 240
    gfx.fillRect(0, 240 - barHeight, 16, barHeight)
    gfx.drawRect(-1, -1, 17, 242)

    -- Draw text
    gfx.drawText(tostring(math.floor((timerMax - timer) / 30)) .. "s", 20, 219)

    -- Handle game state
    if timer >= timerMax then
        SetGameState("menu")
    end
end

local function updateScore()
    gfx.drawTextAligned("Score : " .. Score, 396, 219, kTextAlignment.right)
end

local function updateHand()
    local change, acceleratedChange = pd.getCrankChange()

    if change == 0 then
        change = -25
    end

    crankPower = math.max(crankPower + change, 0)
    local ratio = math.min(crankPower / crankPowerGoal, 1)
    local newHandImageIndex = 1 + math.floor(ratio * 7 + 0.5)
    if newHandImageIndex ~= handImageIndex then
         handImageIndex = newHandImageIndex
         handSprite:setImage(handImageTable:getImage(handImageIndex))
    end

    if ratio == 1 then
        crankPower = 0

        if bubbleTextInfo[2] then
            Score += 1
        else
            Score -= 1
        end

        pickNewBubbleText()
    end
end

local function updateBubble()
    gfx.drawText(bubbleTextInfo[1], 40, 20, 336, 66, gfx.kAlignCenter)

    if pd.buttonJustPressed(pd.kButtonRight) or
       pd.buttonJustPressed(pd.kButtonLeft) or
       pd.buttonJustPressed(pd.kButtonDown) or
       pd.buttonJustPressed(pd.kButtonUp) then
        pickNewBubbleText()
    end
end

-- Flow
function LoadGame()
    timer = 0
    Score = 0

    pickNewBubbleText()

    gfx.sprite.add(handSprite)
    gfx.sprite.add(bubbleSprite)
end

function UnloadGame()
    gfx.sprite.remove(handSprite)
    gfx.sprite.remove(bubbleSprite)
end

function UpdateGame()
    updateTimer()
    updateHand()
    updateScore()
    updateBubble()
end
