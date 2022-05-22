local pd <const> = playdate
local gfx <const> = playdate.graphics

class('Player').extends(AnimatedSprite)

function Player:init(x, y)
    local playerTable = gfx.imagetable.new("images/player")
	Player.super.init(self, playerTable)
	self:setStates({
		{
			name = "back",
			firstFrameIndex = 1,
			framesCount = 2,
			tickStep = 8,
			xScale=2, 
			yScale=2,
		},
		{
			name = "front",
			firstFrameIndex = 3,
			framesCount = 2,
			tickStep = 8,
			xScale=2, 
			yScale=2,
		},
		{
			name = "right",
			firstFrameIndex = 5,
			framesCount = 2,
			tickStep = 8,
			xScale=2, 
			yScale=2,
		},
		{
			name = "left",
			firstFrameIndex = 7,
			framesCount = 2,
			tickStep = 8,
			xScale=2, 
			yScale=2,
		},
	}, true)

	self:moveTo(x,y)
	self:add()
	self:setCollideRect(0, 0, self.width, self.height)
    self.moveSpeed = 1
	self:onCrank()
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
    
    self:updateAnimation()
end

function Player:onCrank()
	local crankPosition = playdate.getCrankPosition()

	if crankPosition<315 then
		if crankPosition<225 then
			if crankPosition<135 then
				if crankPosition<45 then
					self.direction = "back"
				else
					self.direction = "left"
				end
			else
				self.direction = "front"
			end
		else
			self.direction = "right"
		end
	else
		self.direction = "back"
	end

	self:changeState(self.direction)
end