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
triggerEnd = false
testAngle = 0

correctSound = 100
wrongSound = 50


class('safe').extends(gfx.sprite)


function safe:init()
    inCorrectPosition = false
    angleSet()
    triggerEnd = false
end

function safe:update()

	local crankPosition = playdate.getCrankPosition()
    angle = (2*crankPosition + 1)/2

	testAngle = math.floor(angle)

    if pd.buttonJustPressed(pd.kButtonA) and inCorrectPosition then
        if currentBox == 1 then
            sSprite:setImage(symbolTable[math.random(1, 85)])
        elseif currentBox == 2 then
            sSprite1:setImage(symbolTable[math.random(1, 85)])
        elseif currentBox == 3 then
            sSprite2:setImage(symbolTable[math.random(1, 85)])
            if diffIndex == 1 then
                triggerEnd = true
            end
        elseif currentBox == 4 and diffIndex > 1 then
            sSprite3:setImage(symbolTable[math.random(1, 85)])
            if diffIndex == 2 then
                triggerEnd = true
            end
        elseif currentBox == 5 and diffIndex > 2 then
            sSprite4:setImage(symbolTable[math.random(1, 85)])
            if diffIndex == 3 then
                triggerEnd = true
            end
        end
        currentBox += 1
        angleSet()
    end

    angleCheck()
end

function angleCheck()
    local sound = wrongSound
    --print("testAngle .. range .. buffer ..correctAngle " .. testAngle .. " , " .. range .." , " .. buffer .." , " ..correctAngle)
    if testAngle % range <= buffer or testAngle % range >= range - buffer then
        sound = wrongSound
        HiddenAmount = 0.5
        if testAngle <= correctAngle + buffer and testAngle >= correctAngle - buffer then
            sound = correctSound
            inCorrectPosition = true 
            HiddenAmount = 0
        end
        triggerNote = true
    else
        HiddenAmount = 0.5
        inCorrectPosition = false
        triggerNote = false
        
    end

    if triggerNote == true and pd.isCrankDocked() == false and triggerEnd == false then
        lockSound:playNote(sound)
    end
end

function angleSet()
    print("setting angle")
    correctAngle = (math.floor(math.random(18))) * 20
    if difficulty == "Medium" then
        range = 10
        buffer = 2
        correctAngle = (math.floor(math.random(36))) * 10
    end
    if difficulty == "Hard" then
        range = 5
        buffer = 1
        correctAngle = (math.floor(math.random(72))) * 5
    end
    if (correctAngle == previousAngle) then
        angleSet()
    end
    previousAngle = correctAngle
end
