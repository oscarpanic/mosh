import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import "lib/AnimatedSprite"

import "player"
import "bigMosher"
import "mosher"
import "crowdTile"
import "mapHandler"

local pd <const> = playdate
local gfx <const> = pd.graphics

local player = nil
local mosher = nil
local bigMosher = nil
moshTilemap = nil

score = 0

local function initialize()
	player = Player(200, 160)
	mosher = Mosher(220, 180)
	bigMosher = BigMosher(200, 180)
	mapInit()
end

initialize()

function pd.update()
	gfx.sprite.update()
	moshTilemap:draw(0,0)
	gfx.drawText("Fun: " .. score, 320, 5)
end

function pd.cranked()
	player:onCrank()
end

function pd.AButtonDown()
	player.isTryingPush = true
	--TODO: Set a timer for push to expire so push is not happening whole press duration
end

function pd.AButtonUp()
	player.isTryingPush = false
end

function pd.BButtonDown()
	player.isInteracting = true
	--TODO: Set a timer for push to expire so push is not happening whole press duration
end

function pd.BButtonUp()
	player.isInteracting = false
end