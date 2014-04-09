ll_Image = {
	x = 0,
	y = 0,
	r = 0,
	width = 0,
	height = 0,
	image = nil,
	beRotated = 0
}

function ll_Image:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function ll_Image:draw()
	love.graphics.draw(
		self.image, self.x + self.width / 2, self.y + self.height / 2, self.r + self.beRotated, 
		self.width / self.image:getWidth(), self.height / self.image:getHeight(),
		self.image:getWidth() / 2, 
		self.image:getHeight() / 2
		)
end