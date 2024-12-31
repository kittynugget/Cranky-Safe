import "gameOverScene"

import "hand"

knobPosition = 240
handPosition = knobPosition - 55

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)
--imageindex-- do not exceed 85 or go below 1

quitOut = false 

--dialImage sprite setup
local dialImage = gfx.image.new("images/dial")
local dialSprite = gfx.sprite.new()
dialSprite:setBounds(0, 0, 400, 240)
dialSprite.draw = function(x, y, w, h)
	dialImage:drawRotated(knobPosition, 150, angle, .8)
	--gfx.drawText(angle, 180, 20)
end

endStarted = false


startGameTime = 0
currentGameTime = 0

class('BoxSprite').extends(gfx.sprite)

class('SymbolSprite').extends(gfx.sprite)

class('TimerSprite').extends(gfx.sprite)

class('actionSprite').extends(gfx.sprite)


symbolTable = gfx.imagetable.new("images/symbols-table-40-40")
local blankImage = gfx.image.new("images/blank")


function BoxSprite:init(x, y)
    BoxSprite.super.init(self) -- this is critical
	self:setBounds(0, 0, 400, 240)
    self:moveTo(x, y)
	self.draw = function(x, y, w, h)
		gfx.setColor(gfx.kColorBlack)
		gfx.fillRect(350, 10, 42, 42)
		gfx.setColor(gfx.kColorWhite)
		gfx.fillRect(351, 11, 40, 40)

	end
end

function SymbolSprite:init(x, y, image)
    SymbolSprite.super.init(self) -- this is critical
	self:setImage(image)
    self:moveTo(x, y)
	self.draw = function(x, y, w, h)
		if self:getImage() ~= nil then
			self:getImage():drawCentered(0, 0)
		end
	end
end


function TimerSprite:init(x, y)
    TimerSprite.super.init(self) -- this is critical
	self:setBounds(0, 0, 400, 240)
    self:moveTo(x, y)
	self.draw = function(x, y, w, h)
		gfx.setColor(gfx.kColorBlack)
		gfx.fillRect(10, 10, 82, 22)
		gfx.setColor(gfx.kColorWhite)
		gfx.fillRect(11, 11, 80, 20)
		gfx.drawText("Time: ",10,12)
		gfx.drawTextAligned(currentGameTime,85,12,kTextAlignment.right)
	end
end

local safe = safe()

boxX = 190
boxY = 120
symbolX = boxX + 170
symbolY = boxY - 87

--button sprites
local aImage = gfx.image.new("images/a")
local aSprite = gfx.sprite.new()
aSprite:setBounds(0, 0, 400, 240)
aSprite.draw = function(x, y, w, h)
	aImage:drawScaled(340, 120, 1.5)
end

HiddenAmount = 0.5

local fade_img = gfx.image.new(400,280,gfx.kColorWhite)
local fade_sprite = gfx.sprite.new(fade_img:fadedImage(HiddenAmount, gfx.image.kDitherTypeBayer8x8))


function GameScene:init()

	pd.timer.performAfterDelay(5000, function()
		showCrank = false
	end)

	mainSong:setVolume(0.15)
	quitOut = false
	currentBox = 1
	startGameTime = pd.getElapsedTime()
	currentGameTime = startGameTime - startGameTime


	aSprite:add()
	fade_sprite:add()
	fade_sprite:moveTo(200, 140)

	--#region setting up solution boxes
	sprite = BoxSprite(boxX, boxY)
	sprite:add()
	sSprite = SymbolSprite(symbolX, symbolY,blankImage)
	sSprite:add()

	sprite1 = BoxSprite(boxX - (50*1), boxY)
	sprite1:add()
	sSprite1 = SymbolSprite(symbolX - (50*1), symbolY,blankImage)
	sSprite1:add()

	sprite2 = BoxSprite(boxX - (50*2), boxY)
	sprite2:add()
	sSprite2 = SymbolSprite(symbolX - (50*2), symbolY,blankImage)
	sSprite2:add()

	Timer = TimerSprite(200, 130)
	Timer:add()


	

	if difficulty == "Medium" or difficulty == "Hard" then

		--medium avtivated
		sprite3 = BoxSprite(boxX - (50*3), boxY)
		sprite3:add()
		sSprite3 = SymbolSprite(symbolX - (50*3), symbolY,blankImage)
		sSprite3:add()		

	end


	if difficulty == "Hard" then

		--hard activated
		sprite4 = BoxSprite(boxX - (50*4), boxY)
		sprite4:add()
		sSprite4 = SymbolSprite(symbolX - (50*4), symbolY,blankImage)
		sSprite4:add()

	end
	--#endregion
	dialSprite:add()


	safe:add()
	angleSet()
	
	local hand = hand(200,120)
	hand:add()

	self:add()

	endStarted = false
	triggerEnd = false
end

function GameScene:update()

	fade_sprite:setImage(fade_img:fadedImage(HiddenAmount, gfx.image.kDitherTypeBayer8x8))

	if triggerEnd == false then
		currentGameTime = pd.getElapsedTime() - startGameTime
		currentGameTime = tonumber(string.format("%.1f", currentGameTime))
	end

    if pd.buttonJustPressed(pd.kButtonB)  and transitionFinished then
		quitOut = true
		triggerEnd = true
    end
	

	dialSprite:markDirty()
	fade_sprite:markDirty()
	
	if triggerEnd and endStarted == false then
		endStarted = true
		score = currentGameTime
		SCENE_MANAGER:switchScene(GameOverScene)
	end

end
