marsair = {}

modfolder = minetest.get_modpath(minetest.get_current_modname())
--CONFIG:
--marsairconfig:
marsairconfig = {}
dofile(modfolder.."/config.lua")

--flowers-config
dofile(modfolder.."/flower_conf.lua")

marsair.is_airflower = function(pos)
	local nodename = minetest.get_node(pos).name 
	for _, flower in pairs(marsair.air_flowers) do
		if nodename == flower then return true end
	end
	return false
end

--AIR
dofile(modfolder.."/air.lua")

--for replace removed doors and removed nodes by marssurvive:diglazer:
function marssurvive.replacenode(pos)
    	local np=minetest.find_node_near(pos, 1,{"marsair:air_stable"})
	local not_loaded = (minetest.find_node_near(pos, 1,{"ignore"}) ~= nil)
	if np~=nil or not_loaded then
		minetest.set_node(pos, {name = "marsair:air_stable"})
	else
		minetest.set_node(pos, {name = "air"})
	end
end

--PIPEWORKS
if minetest.get_modpath("pipeworks") then
	marsair.pipeworks = true
	marsair.after_place = pipeworks.after_place
	marsair.after_dig = pipeworks.after_dig
end

--generate air by trees
dofile(modfolder.."/tree_air.lua")

--AIRMAKER+AIRCLEANER
dofile(modfolder.."/maker.lua")

--AIRGENE
dofile(modfolder.."/airgen.lua")

--remove air-item dropped by pipeworks:
if marsair.pipeworks then
	dofile(modfolder.."/air_item_disappear.lua")
end

--crafting recipes
dofile(modfolder.."/craft.lua")

print("[MOD] Marsair loaded!")