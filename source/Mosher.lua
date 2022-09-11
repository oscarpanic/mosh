local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Mosher').extends(AnimatedSprite)

function Mosher:init(x, y, mosherTable, mosherStates)
    if mosherTable == nil then
        mosherTable = gfx.imagetable.new("images/mosher")
    end
    if mosherStates == nil then
        mosherStates = {
            {
                name = "default",
                firstFrameIndex = 1,
                framesCount = 2,
                tickStep = 8,
                xScale = 2,
                yScale = 2
            }
        }
    end
        
    Mosher.super.init(self, mosherTable)
    self:setStates(mosherStates, true)

    self:moveTo(x,y)
    self:add()
    self:setCollideRect(0, 0, self.width, self.height)
    self.moveSpeed = 1
    self.pushStrength = 1
    self.pushResistance = 0
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
    if pushX >= 0 then
        self.moveDirX = pushX - self.pushResistance
    elseif pushX < 0 then
        self.moveDirX = pushX + self.pushResistance
    end
    if pushY >= 0 then
        self.moveDirY = pushY - self.pushResistance
    elseif pushY <= 0 then
        self.moveDirY = pushY + self.pushResistance
    end
end

function Mosher:onPushPlayer(other)
    if other:isa(Player) then
        local deltaX = other.x - self.x
        local deltaY = other.y - self.y
        other:onPushed(deltaX * self.pushStrength, deltaY * self.pushStrength)
    end
    
    self:movementReset()
end
