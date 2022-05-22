local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends(AnimatedSprite)

function Player:init(x, y)
    local playerTable = gfx.imagetable.new("images/player")
    self = self.new(playerTable)
	self:addState("back", 1, 2, {tickStep = 8, xScale=2, yScale=2}, true)
	self:moveTo(x,y)
	self:add()
	self:setCollideRect(0, 0, self.width, self.height)
    self.moveSpeed = 1
end

function Player:update()
    if pd.buttonIsPressed(pd.kButtonUp) then
		self:moveWithCollisions(self.x, self.y - self.moveSpeed)
	end
	if pd.buttonIsPressed(pd.kButtonDown) then
		self:moveWithCollisions(self.x, self.y + self.moveSpeed)
	end
	if pd.buttonIsPressed(pd.kButtonRight) then
		self:moveWithCollisions(self.x + self.moveSpeed, self.y)
	end
	if pd.buttonIsPressed(pd.kButtonLeft) then
		self:moveWithCollisions(self.x - self.moveSpeed, self.y)
	end
    
    Player:updateAnimation()
end