local util = require "util"
local Class = require "class"
local DiscordPresence = require "code.discord.discord_presence"

local images = require "data.images"
local sounds = require "data.sounds"

local Game = Class:inherit()

function Game:init()
    self.t = 0
end

function Game:update(dt)
    self.t = self.t + dt
    DiscordPresence:update(dt)
end

function Game:draw()
    love.graphics.draw(images.btn_k_unknown, 400 + math.cos(self.t) * 20, 400 + math.sin(self.t) * 20, 5)
end

function Game:onKeyPressed(key, scancode, isrepeat)
end

function Game:onKeyReleased(key, scancode)
end

function Game:onMousePressed(x, y, button, istouch, presses)
end

function Game:onMouseReleased(x, y, button, istouch, presses)
end

function Game:onJoystickAdded(joystick)
end

function Game:onJoystickremoved(joystick)
end

function Game:onGamepadPressed(joystick, buttoncode)
end

function Game:onGamepadReleased(joystick, buttoncode)
end

function Game:gamepadAxis(joystick, axis, value)
end

function Game:onQuit()
    DiscordPresence:quit()
end

function Game:onResize(w,h)
end

function Game:textInput(text)
end

function Game:onFocus(f)
end


return Game