import "gameScene"
import "safe"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('MenuScene').extends(gfx.sprite)


DitherSrart = 1
DitherAmount = DitherSrart
DitherEnd = 0


TitleAlpha = 0

scaleSrart = 1
scale = scaleSrart
scaleEnd = 1.5

--dialImage sprite setup
local dialImage = gfx.image.new("images/TitleDial")
local angle = 0
local dialSprite = gfx.sprite.new()
dialSprite:setBounds(0, 0, 1000, 1000)
dialSprite.draw = function(x, y, w, h)
	dialImage:drawRotated(200, 120, angle, scale, scale)
end

--titleImage sprite setup
local titleImage = gfx.image.new("images/easy")
angle = 0
local titleSprite = gfx.sprite.new()
titleSprite:setBounds(0, 0, 400, 240)
titleSprite.draw = function(x, y, w, h)
	titleImage:drawCentered(200, 110)
end

--button sprites
local aImage = gfx.image.new("images/a")
local aSprite = gfx.sprite.new()
aSprite:setBounds(0, 0, 400, 240)
aSprite.draw = function(x, y, w, h)
	aImage:drawCentered(175, 200)
	gfx.drawText("play", 190, 190)
end

local bImage = gfx.image.new("images/b")
local bSprite = gfx.sprite.new()
bSprite:setBounds(0, 0, 400, 240)
bSprite.draw = function(x, y, w, h)
	bImage:drawCentered(135, 230)
	gfx.drawText("change difficulty", 150, 220)
end



local fade_img = gfx.image.new(400,280,gfx.kColorWhite)
local fade_sprite = gfx.sprite.new(fade_img:fadedImage(DitherAmount, gfx.image.kDitherTypeBayer8x8))

GrowRate = 0

function MenuScene:init()

	
	local safe = safe()
	PBToDisplay = "NONE SET"

	if diffIndex == 1 then
		if EasyPB ~= nil then
			PBToDisplay = EasyPB
		else
			PBToDisplay = "NONE SET"
		end
	
	elseif diffIndex == 2 then
		if MedPB ~= nil then
			PBToDisplay = MedPB
		else
			PBToDisplay = "NONE SET"
		end
	elseif diffIndex == 3 then
		if HardPB ~= nil then
			PBToDisplay = HardPB
		else
			PBToDisplay = "NONE SET"
		end
	end

	PBText = "PB: " .. PBToDisplay


	PBImage = gfx.imageWithText(PBText, gfx.getTextSize(PBText), 20)
	PBSprite = gfx.sprite.new(PBImage)


	safe:add()
	
	titleSprite:add()
	aSprite:add()
	bSprite:add()
    PBSprite:add()
	PBSprite:moveTo(200, 20)
	fade_sprite:add()
	fade_sprite:moveTo(200, 140)
	dialSprite:add()
	

	correctAngle = 100000

    self:add()
end

function MenuScene:update()
	playdate.graphics.sprite.update()
	

    local crankPosition = playdate.getCrankPosition()
    angle = (2*crankPosition + 1)/2

	scale = pd.math.lerp(scaleSrart, scaleEnd, GrowRate)

	if GrowRate < 1 then
		
		GrowRate += .1
	else

	end

	if GrowRate > 0.8  and DitherAmount >= 0.2 then
		
		DitherAmount -= .2

		fade_sprite:setImage(fade_img:fadedImage(DitherAmount, gfx.image.kDitherTypeBayer8x8))
		
	end

	MenuScene.super.update(self)


	if diffIndex == 1 then
		if EasyPB ~= nil then
			PBToDisplay = EasyPB
		else
			PBToDisplay = "NONE SET"
		end
	
	elseif diffIndex == 2 then
		if MedPB ~= nil then
			PBToDisplay = MedPB
		else
			PBToDisplay = "NONE SET"
		end
	elseif diffIndex == 3 then
		if HardPB ~= nil then
			PBToDisplay = HardPB
		else
			PBToDisplay = "NONE SET"
		end
	end


	PBText = "PB: " .. PBToDisplay
	PBImage = gfx.imageWithText(PBText, gfx.getTextSize(PBText), 20)
	gfx.setColor(playdate.graphics.kColorWhite)

	PBSprite:setImage(PBImage)

	fade_sprite:markDirty()
	PBSprite:markDirty()
	dialSprite:markDirty()

	gfx.sprite.update()

	if pd.buttonJustPressed(pd.kButtonA) then
		SCENE_MANAGER:switchScene(GameScene)
	end
	if pd.buttonJustPressed(pd.kButtonB) then
		if diffIndex == 3 then
			diffIndex = 1
		else
			diffIndex = diffIndex+1
		end
		difficulty = difficulties[diffIndex]

		if difficulty == "Easy" then
			titleImage = gfx.image.new("images/easy")
		elseif difficulty == "Medium" then
			titleImage = gfx.image.new("images/medium")
		else 
			titleImage = gfx.image.new("images/hard")
		end
		titleSprite:markDirty()
	end

end
