import "gameScene"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('MenuScene').extends(gfx.sprite)


--dialImage sprite setup
local dialImage = gfx.image.new("images/SafeDial")
local angle = 0
local dialSprite = gfx.sprite.new()
dialSprite:setBounds(0, 0, 400, 240)
dialSprite.draw = function(x, y, w, h)
	dialImage:drawRotated(200, 120, angle)
	--gfx.drawText(angle, 180, 20)
end

--titleImage sprite setup
local titleImage = gfx.image.new("images/easy")
angle = 0
local titleSprite = gfx.sprite.new()
titleSprite:setBounds(0, 0, 400, 240)
titleSprite.draw = function(x, y, w, h)
	titleImage:drawCentered(200, 120)
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
function MenuScene:init()

	dialSprite:add()
	titleSprite:add()
	aSprite:add()
	bSprite:add()
	--start timers recursive timers to spawn new geometry

    self:add()
end

function MenuScene:update()
    local crankPosition = playdate.getCrankPosition()
    angle = (2*crankPosition + 1)/2

	MenuScene.super.update(self)
	dialSprite:markDirty()
	gfx.sprite.update()



	if pd.buttonJustPressed(pd.kButtonA) then
		SCENE_MANAGER:switchScene(GameScene, "Score: " .. math.floor(score))
	end
	if pd.buttonJustPressed(pd.kButtonB) then
		if diffIndex == 3 then
			diffIndex = 1
		else
			diffIndex = diffIndex+1
		end
		difficulty = difficulties[diffIndex]
		print(difficulty)
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
