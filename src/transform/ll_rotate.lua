ll_Rotate = {
	target = nil,
	cycle = 1,
	paused = false
}

function ll_Rotate:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function ll_Rotate:update(dt)
	if self.target and not self.paused then
		self.target.beRotated = self.target.beRotated + dt / self.cycle * math.acos(-1.0)
	end
end

function ll_Rotate:stop()
	if self.target then
		self.target.beRotated = 0
	end
	self:pause()
end

function ll_Rotate:pause()
	self.paused = true
end

function ll_Rotate:continue()
	self.paused = false
end