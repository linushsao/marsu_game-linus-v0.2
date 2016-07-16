--Settings
mymonths = {}

--Turn damage on or off. This will make storms and hail cause damage
mymonths.damage = true

--You can turn weather off
mymonths.use_weather = true

--Leaves change color in the fall.
mymonths.leaves = true

--Have snow accumulate on the ground
mymonths.snow_on_ground = true

--Puddles appear when raining
mymonths.use_puddles = true

--Flowers die in winter, grown in spring
mymonths.flowers_die = true

if minetest.get_modpath("lightning") then
	lightning.auto = false
end


local modpath = minetest.get_modpath("mymonths")
local input = io.open(modpath.."/settings.txt", "r")

if input then

	dofile(modpath.."/settings.txt")
	input:close()
	input = nil
--else
--	mymonths.damage = false
--	mymonths.use_weather = true
--	mymonths.leaves = true
--	mymonths.snow_on_ground = true
--	mymonths.use_puddles = true
end

dofile(minetest.get_modpath("mymonths") .. "/functions.lua")
dofile(minetest.get_modpath("mymonths") .. "/abms.lua")
dofile(minetest.get_modpath("mymonths") .. "/command.lua")
dofile(minetest.get_modpath("mymonths") .. "/months.lua")

if mymonths.use_weather == true then
	dofile(minetest.get_modpath("mymonths").."/weather.lua")
end

if mymonths.use_weather == false then
	minetest.register_alias("mymonths:puddle", "air")
	minetest.register_alias("mymonths:snow_cover_1", "air")
	minetest.register_alias("mymonths:snow_cover_2", "air")
	minetest.register_alias("mymonths:snow_cover_3", "air")
	minetest.register_alias("mymonths:snow_cover_4", "air")
	minetest.register_alias("mymonths:snow_cover_5", "air")
end

if mymonths.snow_on_ground == false then

	minetest.register_alias("mymonths:snow_cover_1", "air")
	minetest.register_alias("mymonths:snow_cover_2", "air")
	minetest.register_alias("mymonths:snow_cover_3", "air")
	minetest.register_alias("mymonths:snow_cover_4", "air")
	minetest.register_alias("mymonths:snow_cover_5", "air")
end

if mymonths.use_puddles == false then
	minetest.register_alias("mymonths:puddle", "air")
end

if mymonths.leaves == true then
	dofile(minetest.get_modpath("mymonths") .. "/leaves.lua")
end

if mymonths.leaves == false then

	minetest.register_alias("mymonths:leaves_pale_green", "default:leaves")
	minetest.register_alias("mymonths:leaves_orange", "default:leaves")
	minetest.register_alias("mymonths:leaves_red", "default:leaves")
	minetest.register_alias("mymonths:sticks_default", "default:leaves")
	minetest.register_alias("mymonths:sticks_aspen", "default:aspen_leaves")
end

if mymonths.flowers_die == true then
	dofile(minetest.get_modpath("mymonths") .. "/flowers.lua")
end

if minetest.get_modpath("thirsty") then
	thirst = true
end
