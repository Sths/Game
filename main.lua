-- Requires
require "src\\button"

-- Variables
count = 0
currentTime = 0
mouse_x = 0
mouse_y = 0
mouse_button = "1"

ll_game_scene = "title"

ll_button_title = {}

ll_mouse_buttonPressed = nil
ll_mouse_buttonFocus = nil

function love.draw()
	if (ll_game_scene == "title") then
		love.graphics.print("Passing Time : " .. tostring(count), 0, 0)
		--love.graphics.print(mouse_x .. ", " .. mouse_y .. ", " .. mouse_button, 100, 500)
		--love.graphics.draw(image, love.mouse.getX(), love.mouse.getY(), 0, 100 / image:getWidth(), 75 / image:getHeight())
		ll_button_title["start_game"]:draw()
	end
end

function love.mousepressed(x, y, button)
	mouse_x = x
	mouse_y = y
	mouse_button = button
	if button == "l" then
		if (ll_button_title["start_game"]:contains(x, y)) then
			ll_button_title["start_game"]:onPress(x, y)
			ll_mouse_buttonPressed = ll_button_title["start_game"]
		end
	end
end

function love.mousereleased(x, y)
	if (ll_mouse_buttonPressed) then
		ll_mouse_buttonPressed:onRelease()
	end
end

function love.update(dt)
	currentTime = currentTime + dt;
	if (currentTime >= 1) then
		currentTime = currentTime - 1;
		count = count + 1
	end
	if ll_mouse_buttonFocus then
		ll_mouse_buttonFocus:offFocus()
	end
	if (ll_button_title["start_game"]:contains(love.mouse.getX(), love.mouse.getY())) then
		ll_button_title["start_game"]:onFocus(love.mouse.getX(), love.mouse.getY())
		ll_mouse_buttonFocus = ll_button_title["start_game"]
	end
end
-- TODO
function love.load()

	source = love.audio.newSource("res/chores/1.mp3", "stream")
	love.audio.play(source)

	image = love.graphics.newImage("res/chores/3.jpg")
	love.window.setTitle("Secret Base")

	ll_button_title["start_game"] = Button:new{deltax = 10, deltay = 20, width = 200, height = 150}
	ll_button_title["start_game"]:loadImage("res/buttons/start_game/", ".png")
end