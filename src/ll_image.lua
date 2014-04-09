ll_Image = {
	x = 0,
	y = 0,
	r = 0,
	width = 0,
	height = 0,
	image = nil,
	beRotated = 0,
	alpha = 1
}

function ll_Image:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function ll_Image:draw()
	love.graphics.setColor(255, 255, 255, 255 * self.alpha)
	love.graphics.draw(
		self.image, self.x, self.y, self.r + self.beRotated, 
		self.width / self.image:getWidth(), self.height / self.image:getHeight(),
		self.image:getWidth() * self.ox, 
		self.image:getHeight() * self.oy
		)
	love.graphics.setColor(255, 255, 255, 255)
end