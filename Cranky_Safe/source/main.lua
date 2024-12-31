import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"
import "CoreLibs/math"

import "sceneManager"
import "gameScene"


local pd <const> = playdate
local gfx <const> = pd.graphics
local snd = playdate.sound

screenSize = { width = 400, height = 240, hudHeight = 26 }
readyText = "Ready"
difficulties = {"Easy","Medium","Hard"}
diffIndex = 1
difficulty = difficulties[diffIndex]

score = 0 
highScore = 0

EasyPB = nil
MedPB = nil
HardPB = nil

saveData = playdate.datastore.read("data.json")
if saveData ~= nil then
	EasyPB = saveData.EasyPB
	MedPB = saveData.MedPB
	HardPB = saveData.HardPB
end

showCrank = true

mainSong = snd.sampleplayer.new("BKGmusic.wav")
mainSong:setVolume(0.3)
mainSong:play(0)

CURRENT_SCENE = "MenuScene"

SCENE_MANAGER = SceneManager()

MenuScene()

wallCollisionResponse = 'overlap'

transitionFinished = true
halfTransitionFinished = true

resetPBs = false

local menu = playdate.getSystemMenu()

local menuItem, error = menu:addMenuItem("Reset PBs", function()
	EasyPB = nil
	MedPB = nil
	HardPB = nil
	saveGameData()
end)



lockSound = _newSynth(0, .2, 0, .5, .15, snd.kWavePOPhase)

function initialize()


end

triggerTitle = false

function playdate.update()

	gfx.sprite.update()
	playdate.timer.updateTimers()		

	if CURRENT_SCENE == "GameScene" and transitionFinished then
		if showCrank then
			playdate.ui.crankIndicator:draw()
		end
	end
	if CURRENT_SCENE == "GameOverScene" then

	end
	if CURRENT_SCENE == "MenuScene" and halfTransitionFinished or CURRENT_SCENE == "MenuScene" and transitionFinished == true then
		
	end
	
end


-- Function that saves game data
function saveGameData()
    -- Save game data into a table first
    local gameData = {
		EasyPB = EasyPB;
		MedPB = MedPB;
		HardPB = HardPB;
    }
    -- Serialize game data table into the datastore
    playdate.datastore.write(gameData,"data.json")
end

function playdate.gameWillTerminate()
	saveGameData()
end

function playdate.deviceWillSleep()
	saveGameData()
end

function clamp(value, min, max)
    return math.max(math.min(value, max), min)
end
