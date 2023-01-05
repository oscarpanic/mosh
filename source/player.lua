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
    self.moveSpeed = 2
	self.pushStrength = 3
	self.pushedX = 0
	self.pushedY = 0
	self.isInteracting = false
	self.isPushed = false
	self.isTryingPush = false
	self:onCrank()
end

function Player:update()
	local moveTargetX = self.x
	local moveTargetY = self.y

	if self.isPushed then
		if self.pushedX > 0 then
			self.pushedX -= 1
			moveTargetX += 1
		else 
			if self.pushedX < 0 then
				self.pushedX += 1
				moveTargetX -= 1
			end
		end
		if self.pushedY > 0 then
			self.pushedY -= 1
			moveTargetY += 1
		else 
			if self.pushedY < 0 then
				self.pushedY += 1
				moveTargetY -= 1
			end
		end

		if self.pushedY == 0 then
			if self.pushedX == 0 then
				self.isPushed = false
			end
		end
	else
		if pd.buttonIsPressed(pd.kButtonUp) then
			moveTargetY -= self.moveSpeed
		end
		if pd.buttonIsPressed(pd.kButtonDown) then
			moveTargetY += self.moveSpeed
		end
		if pd.buttonIsPressed(pd.kButtonRight) then
			moveTargetX += self.moveSpeed
		end
		if pd.buttonIsPressed(pd.kButtonLeft) then
			moveTargetX -= self.moveSpeed
		end
	end
	self:moveWithCollisions(moveTargetX, moveTargetY)

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
	if self.isTryingPush == false and self.isInteracting == false then
		-- Collision when Player is not pressing A nor B buttons
		if other:isa(Mosher) then
			if other.fallen then
				return "freeze"
			end
			other:onPushPlayer(self)
		end

	elseif other:isa(Mosher)  then
		-- Collision with a Mosher while A or B button is pressed
		if self.direction == "front" then
			if other.y <= self.y then
				if self.isTryingPush then
					other:onPushed(0, -self.pushStrength)
				elseif self.isInteracting then
					other:onLifted()
					self.isInteracting = false
					return "freeze"
				end
				
			end
		end
		if self.direction == "back" then
			if other.y >= self.y then
				if self.isTryingPush then
					other:onPushed(0, self.pushStrength)
				elseif self.isInteracting then
					other:onLifted()
					self.isInteracting = false
					return "freeze"
				end
			end
		end
		if self.direction == "right" then
			if other.x >= self.x then
				if self.isTryingPush then
					other:onPushed(self.pushStrength, 0)
				elseif self.isInteracting then
					other:onLifted()
					self.isInteracting = false
					return "freeze"
				end
			end
		end
		if self.direction == "left" then
			if other.x <= self.x then
				if self.isTryingPush then
					other:onPushed(-self.pushStrength, 0)
				elseif self.isInteracting then
					other:onLifted()
					self.isInteracting = false
					return "freeze"
				end
			end
		end

		self.isTryingPush = false
		if other.fallen then
			return "freeze"
		end
	end
	
	return "bounce"
end

function Player:onPushed(pushX, pushY)
	self.pushedX = pushX
	self.pushedY = pushY
	self.isPushed = true
end