import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "lib/AnimatedSprite"
import "player"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = nil
local playerSpeed = 1

local function initialize()
	player = Player(200, 120)
end

initialize()

function pd.update()
	gfx.sprite.update()
end

function pd.cranked()
	player:onCrank()
end