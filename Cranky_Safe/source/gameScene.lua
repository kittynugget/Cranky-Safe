import "gameOverScene"
import "safe"
import "hand"


local pd <const> = playdate
local gfx <const> = playdate.graphics

class('GameScene').extends(gfx.sprite)
--imageindex-- do not exceed 85 or go below 1


--dialImage sprite setup
local dialImage = gfx.image.new("images/dial")
local angle = 0
local dialSprite = gfx.sprite.new()
dialSprite:setBounds(0, 0, 400, 240)
dialSprite.draw = function(x, y, w, h)
	dialImage:drawRotated(310, 150, angle, .8)
	--gfx.drawText(angle, 180, 20)
end

testAngle = 0

class('BoxSprite').extends(gfx.sprite)

class('SymbolSprite').extends(gfx.sprite)

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

safe = safe()

boxX = 190
boxY = 120
symbolX = boxX + 170
symbolY = boxY - 87

function GameScene:init()

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

	--hand = hand(200,120)
	--hand:add()

	self:add()
end

function GameScene:update()

    if pd.buttonJustPressed(pd.kButtonB) then
		SCENE_MANAGER:switchScene(GameOverScene)
    end
	local crankPosition = playdate.getCrankPosition()
    angle = (2*crankPosition + 1)/2

	testAngle = math.floor(angle)
	dialSprite:markDirty()

	--[[
	sSprite:setImage(symbolTable[math.random(1,85)])
	sSprite1:setImage(symbolTable[math.random(1,85)])
	sSprite2:setImage(symbolTable[math.random(1,85)])
	if difficulty == "Medium" or difficulty == "Hard" then
		sSprite3:setImage(symbolTable[math.random(1,85)])
	end
	if difficulty == "Hard" then
		sSprite4:setImage(symbolTable[math.random(1,85)])
	end
	]]--
	

	
end
