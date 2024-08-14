local Sound = require "code.audio.sound"

local sound_args = {
	-- empty = {"empty.ogg", type = "static"},
}

-------------------------------------------------------------------------------------------

local function new_source(path, args)
	args = args or {}

	local source = love.audio.newSource("sfx/"..path, args.type or "stream")
	if args.pitch then
		source:setPitch(args.pitch)
	end
	if args.volume then
		source:setVolume(args.volume)
	end
	if args.isLooping then
		source:setLooping(args.isLooping)
	end

	return Sound:new(
		source,
		source:getPitch(),
		source:getVolume(),
		{
			looping = source:isLooping(),
		}
	)
end

local sounds = {}

for key, args in pairs(sound_args) do
	sounds[key] = new_source(args[1], args)
end

return sounds