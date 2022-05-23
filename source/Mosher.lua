local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Mosher').extends(AnimatedSprite)

function Mosher:init(x, y)
    local mosherTable = gfx.imagetable.new("images/mosher")
    Mosher.super.init(self, mosherTable)
    self:setStates({
        {
            name = "default",
            firstFrameIndex = 1,
            framesCount = 2,
            tickStep = 8,
            xScale = 2,
            yScale = 2
        }
    }, true)

    self:moveTo(x,y)
    self:add()
    self:setCollideRect(0, 0, self.width, self.height)
    self.moveSpeed = 1
    self:movementReset()
    self:changeState("default")
end

function Mosher:movementReset()
    self.moveDirX = math.random(0, 2) - 1
    self.moveDirY = math.random(0,2) - 1
end

function Mosher:update()
    self:moveWithCollisions(
        self.x + self.moveDirX  *self.moveSpeed, 
        self.y + self.moveDirY * self.moveSpeed
    )

    self:updateAnimation()

    if self.moveDirX == 0 then
        if self.moveDirY == 0 then
            self:movementReset()
        end
    end
end

function Mosher:collisionResponse(other)
    self:movementReset()
    return "bounce"
end

