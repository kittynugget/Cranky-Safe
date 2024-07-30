import "menuScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

totalChange = 0

function GameOverScene:init()
    playdate.graphics.sprite.removeAll()
    text  = "Score: " .. math.floor(score)

    -- local text = "Game Over"
    local scoreImage = gfx.image.new(gfx.getTextSize(text))
    gfx.pushContext(scoreImage)
        gfx.drawText(text, 0, 0)
    gfx.popContext()
    local scoreSprite = gfx.sprite.new(scoreImage)




    
    local resartText = "A to restart"
    local resartImage = gfx.image.new(gfx.getTextSize(resartText))
    gfx.pushContext(resartImage)
        gfx.drawText(resartText, 0, 0)
    gfx.popContext()
    local resartSprite = gfx.sprite.new(resartImage)



    
    resartSprite:moveTo(200, 180)
    resartSprite:add()


    scoreSprite:moveTo(200, 120)
    scoreSprite:add()
    
    self:add()
end

function GameOverScene:update()
	if pd.buttonJustPressed(pd.kButtonA) then
		SCENE_MANAGER:switchScene(MenuScene)
	end

    if pd.buttonJustPressed(pd.kButtonB) then
        saveGameData()
    end
end