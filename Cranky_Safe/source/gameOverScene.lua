import "menuScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameOverScene').extends(gfx.sprite)

totalChange = 0

local menuText = " Menu"

local retryText = " Retry"




--button sprites
local aImage = gfx.image.new("images/a")
local aSprite = gfx.sprite.new()
aSprite:setBounds(0, 0, 400, 240)
aSprite.draw = function(x, y, w, h)
	aImage:drawCentered(240, 200)
	gfx.drawText(retryText, 255, 190)
end

local bImage = gfx.image.new("images/b")
local bSprite = gfx.sprite.new()
bSprite:setBounds(0, 0, 400, 240)
bSprite.draw = function(x, y, w, h)
	bImage:drawCentered(115, 200)
	gfx.drawText(menuText, 130, 190)
end

function GameOverScene:init()
	mainSong:setVolume(0.3)
    playdate.graphics.sprite.removeAll()
    
    currentTimeScore = score
    scoreText  = "Time: " .. currentTimeScore

    if quitOut == true then
        scoreText = "Quit Out"
    end

    local scoreImage = gfx.image.new(gfx.getTextSize(scoreText))
    gfx.pushContext(scoreImage)
        gfx.drawText(scoreText, 0, 0)
    gfx.popContext()
    local scoreSprite = gfx.sprite.new(scoreImage)
    
    trackHighscore()

    if NewPBSet then
        local NewPBImage = gfx.image.new("images/blank")
        local NewPBSprite = gfx.sprite.new()
        NewPBSprite:setBounds(0, 0, 400, 240)
        NewPBSprite.draw = function(x, y, w, h)
            gfx.drawTextAligned("New Personal Best", 200, 150,kTextAlignment.center)
        end

        NewPBSprite:add()

    end

    difficultyText = "Difficulty: " .. difficulty

    local difficultyImage = gfx.image.new(gfx.getTextSize(difficultyText))
    gfx.pushContext(difficultyImage)
        gfx.drawText(difficultyText, 0, 0)
    gfx.popContext()
    local difficultySprite = gfx.sprite.new(difficultyImage)

    
 

    difficultySprite:moveTo(200, 60)
    difficultySprite:add()

    

    aSprite:add()


    bSprite:add()


    scoreSprite:moveTo(200, 120)
    scoreSprite:add()
    
    self:add()
    saveGameData()
end

function GameOverScene:update()
	if pd.buttonJustPressed(pd.kButtonB) then
		SCENE_MANAGER:switchScene(MenuScene)
	end

    if pd.buttonJustPressed(pd.kButtonA) then
        SCENE_MANAGER:switchScene(GameScene)
    end
end

function trackHighscore()
    NewPBSet = false
    if quitOut == false then
        if diffIndex == 1 then
            if EasyPB == nil or currentTimeScore < EasyPB then
                EasyPB = currentTimeScore
                NewPBSet = true
            end
        elseif diffIndex == 2 then
            if MedPB == nil or currentTimeScore < MedPB then
                MedPB = currentTimeScore
                NewPBSet = true
            end
        elseif diffIndex == 3 then
            if HardPB == nil or currentTimeScore < HardPB then
                HardPB = currentTimeScore
                NewPBSet = true
            end
        end
    end
    
    saveGameData()
end