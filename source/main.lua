import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"
import "CoreLibs/crank"
import 'lib/AnimatedSprite'

local gfx = playdate.graphics

local player = nil

local function initialize()
	local playerTable = gfx.imagetable.new("images/player")
	player = AnimatedSprite.new(playerTable)
	player:addState("back", 1, 2, {tickStep = 4}, true)
	--player:setImage(playerTable:getImage(0))
	--player:changeState("back")
	player:moveTo(200, 120)
	player:addSprite()
	player:setCollideRect(20, 0, player.width, player.height)
end

initialize()

function playdate.update()
	gfx.sprite.update()
	player:updateAnimation()
end