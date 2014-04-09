Button = {
	deltax = 0,
	deltay = 0,
	width = 0,
	height = 0,
	images = {
		normal = nil,
		pressed = nil,
		focused = nil
	},
	beFocused = false,
	bePressed = false
}

function Button:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Button:contains(x, y)
	local x_lb = self.deltax
	local x_ub = self.deltax + self.width
	local y_lb = self.deltay
	local y_ub = self.deltay + self.height
	if x >= x_lb and x < x_ub and y >= y_lb and y < y_ub then
		return true
	end
	return false
end

function Button:onPress(x, y)
	self.bePressed = true
end

function Button:onRelease(x, y)
	self.bePressed = false
end

function Button:onFocus(x, y)
	self.beFocused = true;
end

function Button:offFocus(x, y)
	self.beFocused = false;
end

function Button:loadImage(path, type)
	self.images = {}
	self.images['normal'] = love.graphics.newImage(path .. "normal" .. type)
	self.images['pressed'] = love.graphics.newImage(path .. "pressed" .. type)
	self.images['focused'] = love.graphics.newImage(path .. "focused" .. type)
end

function Button:draw()
	local image_to_draw;
	if self.bePressed then
		image_to_draw = self.images["pressed"]
	else
		if self.beFocused then
			image_to_draw = self.images["focused"]
		else
			image_to_draw = self.images["normal"]
		end
	end
	love.graphics.draw(image_to_draw, self.deltax, self.deltay, 0,  self.width / image_to_draw:getWidth(), self.height / image_to_draw:getHeight())
end