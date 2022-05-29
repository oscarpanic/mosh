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
    self.pushStrength = 2
    self:movementReset()
    self:changeState("default")
end

function Mosher:movementReset()
    self.moveDirX = math.random(0, 2) - 1
    self.moveDirY = math.random(0,2) - 1
end

function Mosher:update()
    self:moveWithCollisions(
        self.x + self.moveDirX  * self.moveSpeed, 
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

function Mosher:onPushed(pushX, pushY)
    if(pushX ~= 0) then
        self.moveDirX = pushX
    end
    if(pushY ~= 0) then
        self.moveDirY = pushY
    end
end

function Mosher:onPushPlayer(other)
    if(other:isa(Player)) then
        local deltaX = other.x - self.x
        local deltaY = other.y - self.y
        other:onPushed(deltaX, deltaY)


        -- local pushX = 0
        -- local pushY = 0
        -- if other.y <= self.y then
        --     pushY -= self.pushStrength
        -- end
        -- if other.y >= self.y then
        --     pushY += self.pushStrength
        -- end
        -- if other.x >= self.x then
        --     pushX += self.pushStrength
        -- end
        -- if other.x <= self.x then
        --     pushX -= self.pushStrength
        -- end

        -- other:onPushed(pushX, pushY)
    end
    
    self:movementReset()
end
