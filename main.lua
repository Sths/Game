-- Requires
require "src/button"
require "src/ll_image"
require "src/transform/ll_rotate"

-- Variables
count = 0
currentTime = 0
mouse_x = 0
mouse_y = 0
mouse_button = "1"

ll_game_scene = "title"

ll_button_title = {}
ll_image_title = {}
ll_transform_title = {}

-- Mouse
ll_mouse_buttonPressed = nil
ll_mouse_buttonPressed_type = "l"
ll_mouse_buttonFocus = nil
ll_mouse_buttonReleased = nil

function love.draw()
	if (ll_game_scene == "title") then
		love.graphics.print("Passing Time : " .. tostring(count), 0, 0)
		
		_drawables = {}

		for i, image in pairs(ll_image_title) do
			table.insert(_drawables, image)
		end
		for i, button in pairs(ll_button_title) do
			table.insert(_drawables, button)
		end

		function compare(s, t)
			return s.depth < t.depth
		end

		table.sort(_drawables, compare)

		for i, _drawable in ipairs(_drawables) do
			_drawable:draw()
		end
	end
end

function love.mousepressed(x, y, button)
	ll_mouse_buttonPressed_type = button
	if ll_game_scene == "title" then
		for i, _button in pairs(ll_button_title) do
			if _button:contains(x, y) then
				ll_mouse_buttonPressed = _button
			end
		end
	end
end

function love.mousereleased(x, y)
	if (ll_mouse_buttonPressed) then
		ll_mouse_buttonReleased = ll_mouse_buttonPressed
		ll_mouse_buttonPressed = nil
	end
end

function love.update(dt)

	currentTime = currentTime + dt;
	if (currentTime >= 1) then
		currentTime = currentTime - 1;
		count = count + 1
	end

	-- Transforms
	if ll_game_scene == "title" then
		for i, _trans in pairs(ll_transform_title) do
			_trans:update(dt)
		end
	end

	-- Mouse 

	-- Mouse Focus
	if ll_game_scene == "title" then
		local ll_mouse_buttonFocus_new = nil
		for i, _button in pairs(ll_button_title) do
			if _button:contains(love.mouse.getX(), love.mouse.getY()) then
				ll_mouse_buttonFocus_new = _button
			end
		end
		if ll_mouse_buttonFocus ~= ll_mouse_buttonFocus_new then
			if ll_mouse_buttonFocus ~= nil then
				ll_mouse_buttonFocus:offFocus()
			end
			if ll_mouse_buttonFocus_new ~= nil then
				ll_mouse_buttonFocus_new:onFocus()
			end
			ll_mouse_buttonFocus = ll_mouse_buttonFocus_new
		end
	end

	-- Mouse Release
	if ll_mouse_buttonReleased then
		love.window.setTitle("!!!")
		ll_mouse_buttonReleased:onRelease()
		ll_mouse_buttonReleased = nil
	end

	-- Mouse Pressed
	if ll_mouse_buttonPressed then
		ll_mouse_buttonPressed:onPress()
	end
end
-- TODO
function love.load()

	source = love.audio.newSource("res/chores/3.mp3", "stream")
	love.audio.play(source)
	image = love.graphics.newImage("res/chores/3.jpg")
	love.window.setTitle("Long Life Σ(っ °Д °;)っ v.0.0.0000")


	-- Title

	ll_image_title["background"] = ll_Image:new{
		x = 0, y = 0, r = 0, width = 1120, height = 630, depth = -10,
		image = love.graphics.newImage("res/backgrounds/bg_0.png")
	}
	ll_image_title["title"] = ll_Image:new{
		x = 850, y = 50, r = 0, width = 200, height = 100, depth = 0,
		image = love.graphics.newImage("res/backgrounds/title_0.png")
	}

	ll_image_title["register_circle"] = ll_Image:new{
		x = 640, y = 310, r = 0, width = 70, height = 70, depth = 20,
		image = love.graphics.newImage("res/chores/circle_1.png")
	}
	ll_image_title["login_circle"] = ll_Image:new{
		x = 740, y = 310, r = 0, width = 70, height = 70, depth = 20,
		image = love.graphics.newImage("res/chores/circle_1.png")
	}
	ll_image_title["info_circle"] = ll_Image:new{
		x = 840, y = 310, r = 0, width = 70, height = 70, depth = 20,
		image = love.graphics.newImage("res/chores/circle_1.png")
	}
	ll_image_title["leave_circle"] = ll_Image:new{
		x = 940, y = 310, r = 0, width = 70, height = 70, depth = 20,
		image = love.graphics.newImage("res/chores/circle_1.png")
	}

	ll_transform_title["register_circle"] = ll_Rotate:new{
		cycle = -3, target = ll_image_title["register_circle"], paused = true
	}
	ll_transform_title["login_circle"] = ll_Rotate:new{
		cycle = -3, target = ll_image_title["login_circle"], paused = true
	}
	ll_transform_title["info_circle"] = ll_Rotate:new{
		cycle = -3, target = ll_image_title["info_circle"], paused = true
	}
	ll_transform_title["leave_circle"] = ll_Rotate:new{
		cycle = -3, target = ll_image_title["leave_circle"], paused = true
	}

	ll_button_title["register"] = Button:new{deltax = 650, deltay = 320, width = 50, height = 50, depth = 10}
	ll_button_title["register"]:loadImage("res/buttons/title/register/", ".png")
	ll_button_title["register"].onFocus = function(x, y) 
		ll_transform_title["register_circle"]:continue()
	end
	ll_button_title["register"].offFocus = function(x, y) 
		ll_transform_title["register_circle"]:stop()
	end
	ll_button_title["login"] = Button:new{deltax = 750, deltay = 320, width = 50, height = 50, depth = 10}
	ll_button_title["login"]:loadImage("res/buttons/title/login/", ".png")
	ll_button_title["login"].onFocus = function(x, y) 
		ll_transform_title["login_circle"]:continue()
	end
	ll_button_title["login"].offFocus = function(x, y) 
		ll_transform_title["login_circle"]:stop()
	end
	ll_button_title["info"] = Button:new{deltax = 850, deltay = 320, width = 50, height = 50, depth = 10}
	ll_button_title["info"]:loadImage("res/buttons/title/info/", ".png")
	ll_button_title["info"].onFocus = function(x, y) 
		ll_transform_title["info_circle"]:continue()
	end
	ll_button_title["info"].offFocus = function(x, y) 
		ll_transform_title["info_circle"]:stop()
	end
	ll_button_title["leave"] = Button:new{deltax = 950, deltay = 320, width = 50, height = 50, depth = 10}
	ll_button_title["leave"]:loadImage("res/buttons/title/leave/", ".png")
	ll_button_title["leave"].onFocus = function(x, y) 
		ll_transform_title["leave_circle"]:continue()
	end
	ll_button_title["leave"].offFocus = function(x, y) 
		ll_transform_title["leave_circle"]:stop()
	end
	ll_button_title["leave"].onRelease = function(self)
		love.event.quit()
	end

end