
local pd <const> = playdate
local gfx <const> = pd.graphics


class('hand').extends(gfx.sprite)

local changeToTriger = 5
local changeCounter = 0

handIndex = 1
--handImage sprite setup
local handTable = gfx.imagetable.new("images/hands-table-300-300") -- 1-4 only
local handImage = handTable[handIndex]

local handSprite = gfx.sprite.new()
handSprite:setBounds(0, 0, 400, 240)
handSprite.draw = function(x, y, w, h)
	handImage:drawCentered(255, 175)
end

function hand:init()
    handSprite:add()
end

function hand:update()
    local change, acceleratedChange = playdate.getCrankChange()

    if change >= 0 then
        changeCounter += 1
    end
    if change <= 0 then
        changeCounter -= 1
    end

    if changeCounter >= changeToTriger then
        handIndex -= 1
        if handIndex == 0 then
            handIndex = 4
        end
       
        changeCounter = 0
    end
    if changeCounter <= -1 then
        handIndex += 1
        if handIndex == 5 then
            handIndex = 1
        end

        changeCounter = changeToTriger-1
    end


    handSprite:setImage(handTable[handIndex])
    handSprite:moveTo(handPosition, 175)

end


