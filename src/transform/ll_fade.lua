ll_Fade = {
	target = nil,
	fadeFrom = 0,
	fadeTo = 1,
	current = 0,
	period = 1,
	paused = false
}

function ll_Fade:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function ll_Fade:update(dt)
	if self.target and not self.paused then
		self.current = self.current + dt;
		if (self.current > self.period) then
			self:stop()
		else
			self.target.alpha = self.fadeFrom + (self.fadeTo - self.fadeFrom) * self.current / self.period
		end
	end
end

function ll_Fade:stop()
	if self.target then
		self.target.alpha = self.fadeTo
	end
	self:pause()
end

function ll_Fade:cancel()
	if self.target then
		self.target.alpha = self.fadeFrom
	end
	self.current = 0
	self:pause()
end

function ll_Fade:pause()
	self.paused = true
end

function ll_Fade:continue()
	self.paused = false
end