local util = {}

function util.param(value, def_value)
	if value == nil then
		return def_value
	end
	return value
end

return util