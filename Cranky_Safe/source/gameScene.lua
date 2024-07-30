import "gameOverScene"



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



class('BoxSprite').extends(gfx.sprite)

class('SymbolSprite').extends(gfx.sprite)

local symbolTable = gfx.imagetable.new("images/symbols-table-40-40")
local blankImage = gfx.image.new("images/blank")

lockImage1 = blankImage
lockImage2 = blankImage
lockImage3 = blankImage
lockImage4 = 0 -- used in medium
lockImage5 = 0 -- used in hard

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




function GameScene:init()

	--#region setting up solution boxes
	sprite = BoxSprite(200, 120)
	sprite:add()
	sSprite = SymbolSprite(370, 33,lockImage1)
	sSprite:add()

	sprite1 = BoxSprite(150, 120)
	sprite1:add()
	sSprite1 = SymbolSprite(320, 33,lockImage2)
	sSprite1:add()

	sprite2 = BoxSprite(100, 120)
	sprite2:add()
	sSprite2 = SymbolSprite(270, 33,lockImage3)
	sSprite2:add()


	if difficulty == "Medium" or difficulty == "Hard" then

		--medium avtivated
		sprite3 = BoxSprite(50, 120)
		sprite3:add()
		sSprite3 = SymbolSprite(220, 33,lockImage2)
		sSprite3:add()		

	end


	if difficulty == "Hard" then

		--hard activated
		sprite4 = BoxSprite(0, 120)
		sprite4:add()
		sSprite4 = SymbolSprite(170, 33,lockImage3)
		sSprite4:add()

	end
	--#endregion
	dialSprite:add()

	self:add()
end

function GameScene:update()

	local crankPosition = playdate.getCrankPosition()
    angle = (2*crankPosition + 1)/2

	testAngle = math.floor(angle)
	dialSprite:markDirty()

	if pd.buttonJustPressed(pd.kButtonB) then
		SCENE_MANAGER:switchScene(GameOverScene)
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
	
	if pd.buttonJustPressed(pd.kButtonA) then
		sSprite:setImage(symbolTable[math.random(1,85)])
	end
	
end
