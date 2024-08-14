require "constants"

local img_names = {
	empty = "empty",
	yanis = "yanis",
}

----------------------------------------------------------------------------------------------------------

local function load_image(name)
	local im = love.graphics.newImage("images/"..name)
	im:setFilter("nearest", "nearest")
	return im
end

local images = {}

for id, path in pairs(img_names) do
	images[id] = load_image(path..".png")
end

-- Input buttons
-- Keyboard
for key_constant, button_image_name in pairs(KEY_CONSTANT_TO_IMAGE_NAME) do
	images[button_image_name] = load_image("buttons/keyboard/"..button_image_name..".png")
end

return images