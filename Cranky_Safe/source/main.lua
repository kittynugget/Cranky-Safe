import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/ui"

import "sceneManager"
import "gameScene"

local pd <const> = playdate
local gfx <const> = pd.graphics

screenSize = { width = 400, height = 240, hudHeight = 26 }
readyText = "Ready"
difficulties = {"Easy","Medium","Hard"}
diffIndex = 1
difficulty = difficulties[diffIndex]

score = 0 
highScore = 0

saveData = playdate.datastore.read("data.json")
if saveData ~= nil then

end



CURRENT_SCENE = "MenuScene"

SCENE_MANAGER = SceneManager()

MenuScene()

wallCollisionResponse = 'overlap'

transitionFinished = true
halfTransitionFinished = true

local menu = playdate.getSystemMenu()

local menuItem, error = menu:addMenuItem("Menu Function", function()

end)

function initialize()
end


function playdate.update()

	gfx.sprite.update()
	playdate.timer.updateTimers()		
	--playdate.setCrankSoundsDisabled(true)

	if CURRENT_SCENE == "GameScene" and transitionFinished then

	end
	if CURRENT_SCENE == "GameOverScene" then

	end
	if CURRENT_SCENE == "MenuScene"  and transitionFinished then

	end

end


-- Function that saves game data
function saveGameData()
    -- Save game data into a table first
    local gameData = {
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
