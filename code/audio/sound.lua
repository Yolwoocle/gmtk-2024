local util = require "util"
local Class = require "class"

local Sound = Class:inherit()

function Sound:init(source, pitch, volume, params)
    params = params or {}
    pitch = pitch or 1.0
    volume = volume or 1.0
    self.source = source:clone()
    self.pitch = pitch
    self.volume = volume
    self.is_looping = util.param(params.looping, false)

    self.is_paused = false
end

function Sound:clone(volume, pitch, params)
    return Sound:new(
        self.source:clone(),
        volume or self.pitch,
        pitch or self.volume,
        params or {
            looping = self.is_looping,
        }
    )
end

function Sound:updateSource()
    self.source:setVolume(self.volume)
	self.source:setPitch(self.pitch)
end

function Sound:setVolume(volume)
    self.volume = volume
    self:updateSource()
end

function Sound:setPitch(pitch)
    self.pitch = pitch
    self:updateSource()
end

function Sound:play()
    self:updateSource()
    self.is_paused = false
	self.source:play()
end

function Sound:pause()
    self.is_paused = true
	self.source:pause()
end

function Sound:resume()
    if self.is_paused then
        self.is_paused = false
        self.source:play()
    end
end

function Sound:stop()
    self.is_paused = false
	self.source:stop()
end

function Sound:seek(time)
    self.is_paused = false
	self.source:seek(time)
end

function Sound:getDuration()
	return self.source:getDuration()
end

-- ---@param offset number
-- ---@param unit "seconds"|"samples"
-- function Sound:seek(offset, unit)
--     self.source:seek(offset, unit)
-- end

return Sound