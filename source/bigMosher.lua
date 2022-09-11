import "mosher"

local pd <const> = playdate
local gfx <const> = playdate.graphics

class('BigMosher').extends(Mosher)

function BigMosher:init(x, y)
    local bigMosherTable = gfx.imagetable.new("images/bigMosher")
    local bigMosherStates = {
        {
            name = "default",
            firstFrameIndex = 1,
            framesCount = 4,
            tickStep = 8,
            xScale = 2,
            yScale = 2
        }
    }

    BigMosher.super.init(self, x, y, bigMosherTable, bigMosherStates)

    self.moveSpeed = 1
    self.pushStrength = 3
    self.pushResistance = 1
end

function BigMosher:collisionResponse(other)
    self:movementReset()
    if other:isa(Mosher) then
        other:onFall()
        return "freeze"
    else
        return "bounce"
    end
end
