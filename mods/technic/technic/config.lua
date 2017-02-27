technic.config = technic.config or Settings(minetest.get_worldpath().."/technic.conf")

local conf_table = technic.config:to_table()

local defaults = {
	enable_mining_drill = "true",
	enable_mining_laser = "true",
	enable_flashlight = "true",
	enable_wind_mill = "true",
	enable_frames = "true",
	enable_corium_griefing = "false",
}

for k, v in pairs(defaults) do
	if conf_table[k] == nil then
		technic.config:set(k, v)
	end
end
