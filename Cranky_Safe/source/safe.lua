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

easyBuffer = 10
medBuffer = 5
hardBuffer = 1

triggerNote = false
buffer = easyBuffer
range = 20
correctAngle = 20
previousAngle = 0
inCorrectPosition = false
triggerEnd = false
testAngle = 0

correctSound = 75
wrongSound = 50
angleList = {}

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
    if setContains(angleList,testAngle) then
        sound = correctSound
        inCorrectPosition = true 
        HiddenAmount = 0
        triggerNote = true
    else
        sound = wrongSound
        inCorrectPosition = false 
        HiddenAmount = 0.5
        triggerNote = false
    end
    if CURRENT_SCENE == "MenuScene" then
    else
        if triggerNote == true and pd.isCrankDocked() == false and triggerEnd == false then
            lockSound:playNote(sound)
        end
    end
end

function angleSet()
    print("setting angle")
    correctAngle = (math.floor(math.random(18))) * 20
    if difficulty == "Easy" then
        buffer = easyBuffer
        correctAngle = (math.floor(math.random(36))) * 10
    end
    if difficulty == "Medium" then
        buffer = medBuffer
        correctAngle = (math.floor(math.random(36))) * 10
    end
    if difficulty == "Hard" then
        buffer = hardBuffer
        correctAngle = (math.floor(math.random(72))) * 5
    end
    if (correctAngle == previousAngle) then
        angleSet()
    end
    previousAngle = correctAngle
    print(correctAngle)
    listSize = buffer*2
    for i = 0, listSize do

        bufferAngle = correctAngle - buffer + i
        if bufferAngle >= 360 then
            bufferAngle = bufferAngle - 360
        elseif bufferAngle <= 0 then
            bufferAngle = bufferAngle + 360
        end
        angleList[i] = bufferAngle
        
    end
    for i = 0, listSize do
        print(angleList[i])
    end
    
end

function setContains(set, testValue)
    IsIn = false
    for i = 0, listSize do
        if set[i] == testValue then
            IsIn = true
        end
    end
    return IsIn
end
