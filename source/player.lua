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
	self.pushStrength = 3
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
					self.direction = "front"
				else
					self.direction = "right"
				end
			else
				self.direction = "back"
			end
		else
			self.direction = "left"
		end
	else
		self.direction = "front"
	end

	self:changeState(self.direction)
end

function Player:collisionResponse(other)
	if pd.buttonJustPressed(pd.kButtonA) then
		if other:isa(Mosher) then
			if self.direction == "front" then
				if other.y <= self.y then
					other:push(0, -self.pushStrength)
				end
			end
			if self.direction == "back" then
				if other.y >= self.y then
					other:push(0, self.pushStrength)
				end
			end
			if self.direction == "right" then
				if other.x >= self.x then
					other:push(self.pushStrength, 0)
				end
			end
			if self.direction == "left" then
				if other.x <= self.x then
					other:push(-self.pushStrength, 0)
				end
			end
		end
	end
	return "bounce"
end