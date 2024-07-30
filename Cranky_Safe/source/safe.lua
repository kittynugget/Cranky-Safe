import "gameScene"
local pd <const> = playdate
local gfx <const> = pd.graphics
local snd = playdate.sound


function _newSynth(a, d, s, r, volume, sound)
	local synth = playdate.sound.synth.new(sound)
	synth:setADSR(a, d, s, r)
	synth:setVolume(volume)
	return synth
end
currentBox = 1

triggerNote = false
buffer = 3
range = 20
correctAngle = 20
previousAngle = 0
inCorrectPosition = false

correctSound = 100
wrongSound = 50

lockSound = _newSynth(0, .2, 0, .4, .1, snd.kWaveSawtooth)

class('safe').extends(gfx.sprite)

function safe:init()
    angleSet()
end

function safe:update()
    --print(testAngle)
    if pd.buttonJustPressed(pd.kButtonA) and inCorrectPosition then
        if currentBox == 1 then
            sSprite:setImage(symbolTable[math.random(1,85)])
        elseif currentBox == 2 then
            sSprite1:setImage(symbolTable[math.random(1,85)])
        elseif currentBox == 3 then
            sSprite2:setImage(symbolTable[math.random(1,85)])
        elseif currentBox == 4 and diffIndex > 1 then
            sSprite3:setImage(symbolTable[math.random(1,85)])
        elseif currentBox == 5 and diffIndex > 2 then
            sSprite4:setImage(symbolTable[math.random(1,85)])
        end
        currentBox += 1
        angleSet()
    end

    angleCheck()

end


function angleCheck()
    local sound = wrongSound
    if testAngle % range <= buffer or testAngle % range >= range - buffer then
        sound = wrongSound
        if testAngle <= correctAngle+buffer and  testAngle >= correctAngle-buffer then
            sound = correctSound
            inCorrectPosition = true
        end
        triggerNote = true
    else
        triggerNote =false
    end

    if triggerNote == true and pd.isCrankDocked() == false then
        lockSound:playNote(sound)
    end

end

function angleSet()
    correctAngle = (math.floor(math.random(18)))*20
    if difficulty == "Medium" then
        range = 10
        buffer = 1
        correctAngle = (math.floor(math.random(36)))*10
    end
    if difficulty == "Hard" then
        range = 5
        buffer = 0
        correctAngle = (math.floor(math.random(72)))*5
    end
    if (correctAngle == previousAngle) then
        angleSet()
    end
    previousAngle = correctAngle
    print(correctAngle)
end