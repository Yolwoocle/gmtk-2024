require "lib.error_explorer.error_explorer" {
	source_font = love.graphics.newFont("fonts/FiraCode-Regular.ttf", 12)
}
local Game = require "code.game"

function love.load(args)
    game = Game:new()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end

function love.keypressed(key, scancode, isrepeat)
	if key == "f5" then
		if love.keyboard.isDown("lshift") or love.keyboard.isDown("rshift") then
			love.event.quit("restart")
		end

	elseif key == "f4" then
		if love.keyboard.isDown("lshift") then
			love.event.quit()
		end

	-- elseif key == "return" and (love.keyboard.isDown("lalt") or love.keyboard.isDown("ralt")) then
	-- 	if Options then   Options:toggle_fullscreen()    end	
	end

	if game.onKeyPressed then  game:onKeyPressed(key, scancode, isrepeat)  end
end


function love.keyreleased(key, scancode)
	if game.onKeyReleased then  game:onKeyReleased(key, scancode)  end
end

function love.mousepressed(x, y, button, istouch, presses)
	if game.onMousePressed then   game:onMousePressed(x, y, button, istouch, presses)   end
end

function love.mousereleased(x, y, button, istouch, presses)
	if game.onMouseReleased then   game:onMouseReleased(x, y, button, istouch, presses)   end
end

function love.joystickadded(joystick)
	if game.onJoystickAdded then   game:onJoystickAdded(joystick)   end
end

function love.joystickremoved(joystick)
	if game.onJoystickremoved then   game:onJoystickremoved(joystick)   end
end

function love.gamepadpressed(joystick, buttoncode)
	if game.onGamepadPressed then   game:onGamepadPressed(joystick, buttoncode)   end
end

function love.gamepadreleased(joystick, buttoncode)
	if game.onGamepadReleased then   game:onGamepadReleased(joystick, buttoncode)   end
end

function love.gamepadaxis(joystick, axis, value)
	if game.gamepadAxis then   game:gamepadAxis(joystick, axis, value)   end
end

function love.quit()
	if game.onQuit then   game:onQuit()   end
end

function love.resize(w, h)
	if not game then   return   end
	if game.onResize then   game:onResize(w,h)   end
end

function love.textinput(text)
	if game.textInput then  game:textInput(text)  end
end

function love.focus(f)
	if game.onFocus then  game:onFocus(f)  end
end