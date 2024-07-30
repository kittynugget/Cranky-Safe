
local pd <const> = playdate
local gfx <const> = pd.graphics


class('hand').extends(gfx.sprite)

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
    print(change, acceleratedChange )
    
    if pd.getCurrentTimeMilliseconds() % 10 <= 3 then
        if change >= 0 then
            handIndex+=1
            if handIndex == 5 then
                handIndex = 1
            end
        end
        if change <= 0 then
            handIndex-=1
            if handIndex == 0 then
                handIndex = 4
            end
        end
   
        handSprite:setImage(handTable[handIndex])
        handSprite:moveTo(255, 175)
    end


end


