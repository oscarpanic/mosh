local pd <const> = playdate
local gfx <const> = playdate.graphics

class('CrowdTile').extends(AnimatedSprite)

function CrowdTile:init(x,y, scale)
    local crowdTable = gfx.imagetable.new("images/crowd")
    CrowdTile.super.init(self, crowdTable)
    self:setStates({
        {
            name = "default",
            firstFrameIndex = 1,
            framesCount = 2,
            tickStep = 8,
            xScale = scale,
            yScale = scale,
        }
    }, true)

    self:moveTo(x,y)
    self:add()
    self:setCollideRect(0, 0, self.width, self.height)
end

function CrowdTile:update()
    self:updateAnimation()
end