local unified_inventory = (minetest.get_modpath("unified_inventory") ~= nil)
local bags  = (minetest.get_modpath("bags") ~= nil)

local bagmod = ""
if bags then bagmod = "bags"
else bagmod = "unified_inventory" 
end

if bags or unified_inventory then
	minetest.register_craftitem("marssurvive:alien_big_fiber", {
		description = "Alien Big's fiber",
		inventory_image = "marssurvive_unused_fiber.png",
	})

	minetest.register_craft({
		type = "cooking",
		output = "marssurvive:alien_big_fiber",
		recipe = "marssurvive:unused",
		cooktime = 10
	})

	minetest.register_craftitem("marssurvive:alien_death_fiber", {
		description = "Alien Death's fiber",
		inventory_image = "marssurvive_unused2_fiber.png",
	})

	minetest.register_craft({
		type = "cooking",
		output = "marssurvive:alien_death_fiber",
		recipe = "marssurvive:unused2",
		cooktime = 10
	})
	
	minetest.register_craft({
		output = bagmod..":bag_small",
		recipe = {
			{"", "group:stick", ""},
			{"group:wood", "marssurvive:alien_death_fiber", "group:wood"},
			{"group:wood", "group:wood", "group:wood"},
		},
	})

	minetest.register_craft({
		output = bagmod..":bag_medium",
		recipe = {
			{"", "group:stick", ""},
			{bagmod..":bag_small", "marssurvive:alien_death_fiber", bagmod..":bag_small"},
			{bagmod..":bag_small", "marssurvive:alien_death_fiber", bagmod..":bag_small"},
		},
	})

	minetest.register_craft({
		output = bagmod..":bag_large",
		recipe = {
			{"", "group:stick", ""},
			{bagmod..":bag_medium", "marssurvive:alien_big_fiber", bagmod..":bag_medium"},
			{bagmod..":bag_medium", "marssurvive:alien_big_fiber", bagmod..":bag_medium"},
	    },
	})
end
	
