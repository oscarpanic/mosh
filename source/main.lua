import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "lib/AnimatedSprite"

import "player"
import "mosher"
import "crowdTile"
import "mapHandler"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = nil
local mosher = nil

local function initialize()
	player = Player(200, 160)
	mosher = Mosher(220, 180)
	mapInit()
end

initialize()

function pd.update()
	gfx.sprite.update()
end

function pd.cranked()
	player:onCrank()
end