minetest.register_craft({
	output = "marssurvive:trapdoor_1 2",
	recipe = {
		{"marssurvive:warning","marssurvive:shieldblock",""},
		{"marssurvive:warning","marssurvive:shieldblock", ""},
	}
})

minetest.register_craft({
	output = "marssurvive:smart_glasspane_side 2",
	recipe = {{"default:glass", "default:glass"},
		{"default:glass", "default:glass"},}})
minetest.register_craft({
	output = "marssurvive:smart_glasspane_down",
	recipe = {{"marssurvive:smart_glasspane_side"},}})
minetest.register_craft({
	output = "marssurvive:smart_glasspane_up",
	recipe = {{"marssurvive:smart_glasspane_down"},}})
minetest.register_craft({
	output = "marssurvive:smart_glasspane_side",
	recipe = {{"marssurvive:smart_glasspane_up"},}})
minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "marssurvive:smart_glasspane_side",})

minetest.register_craft({
	output = "marssurvive:clight 3",
	recipe = {{"default:glass","default:glass","default:glass"},
		{"","default:mese_crystal_fragment",""}}})

minetest.register_craft({
	output = "marssurvive:secam_off",
	recipe = {
		{"default:steel_ingot", "dye:black", "default:steel_ingot"},
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "dye:black", "default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "marssurvive:aliencatcher",
	recipe = {
		{"marssurvive:diglazer"},
		{"marssurvive:aliengun"},
	}
})

minetest.register_craft({
	output = "marssurvive:diglazer",
	recipe = {
		{"marssurvive:air_gassbotte","marssurvive:shieldblock","marssurvive:shieldblock"},
		{"","marssurvive:shieldblock","marssurvive:shieldblock"},
	}
})

--[[
minetest.register_craft({
	output = "default:water_source",
	recipe = {
		{"marssurvive:ice","",""},
	}
})
--]]

minetest.register_craft({
	output = "marssurvive:door1_closed",
	recipe = {
		{"marssurvive:door2_1","marssurvive:shieldblock","marssurvive:door2_1"},
		{"marssurvive:door2_1","marssurvive:shieldblock","marssurvive:door2_1"},
	}
})
minetest.register_craft({
	output = "marssurvive:door2_1 2",
	recipe = {
		{"marssurvive:warning","marssurvive:shieldblock",""},
		{"marssurvive:warning","marssurvive:shieldblock", ""},
		{"marssurvive:warning","marssurvive:shieldblock", ""},
	}
})

minetest.register_craft({
	output = "marssurvive:warning",
	recipe = {
		{"default:coal_lump","marssurvive:clayblock",""},
		{"marssurvive:clayblock","default:coal_lump", ""},
	}
})


minetest.register_craft({
	output = "marssurvive:sandpick",
	recipe = {
		{"default:sandstone","default:sandstone","default:sandstone"},
		{"","default:sandstone", ""},
		{"","default:sandstone", ""},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen5",
	recipe = {
		{"marssurvive:shieldblock","marssurvive:air_gassbotte","marssurvive:shieldblock"},
		{"marssurvive:shieldblock","marssurvive:oxogen", "marssurvive:shieldblock"},
	}
})


minetest.register_craft({
	output = "marssurvive:air_gassbotte 2",
	recipe = {
		{"default:steel_ingot","marssurvive:oxogen","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "marssurvive:sp",
	recipe = {
		{"marssurvive:sp","marssurvive:air_gassbotte",""}

	}
})
--[[
minetest.register_craft({
	output = "default:dirt 3",
	recipe = {
		{"marssurvive:clayblock","marssurvive:clayblock","marssurvive:clayblock"},
		{"marssurvive:clayblock","marssurvive:clayblock", "marssurvive:clayblock"},
		{"marssurvive:clayblock","marssurvive:clayblock","marssurvive:clayblock"},
	}
})
--]]

minetest.register_craft({
	output = "marssurvive:mars_sapling 2",
	recipe = {
		{"","",""},
		{"","default:mossycobble", ""},
		{"","marssurvive:clayblock",""},
	}
})

minetest.register_craft({
	output = "marssurvive:mars_sapling",
	recipe = {
		{"","",""},
		{"","default:mossycobble", ""},
		{"","default:clay_lump",""},
	}
})


minetest.register_craft({
	output = "marssurvive:steelwallblock 8",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","", "default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "marssurvive:shieldblock 4",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:iron_lump"},
		{"default:steel_ingot","default:steel_ingot", ""},
	}
})

minetest.register_craft({
	output = "default:stone",
	recipe = {
		{"marssurvive:sand","marssurvive:clayblock","marssurvive:sand"},
	}
})
minetest.register_craft({
	output = "default:stick 4",
--	recipe = {{"marssurvive:clayblock","",""}}})
	recipe = {{"default:clay_lump","",""}}})


minetest.register_craft({
	output = "marssurvive:wood 3",
	recipe = {{"marssurvive:tree","",""}}})

minetest.register_craft({
	output = "marssurvive:airgen5",
	recipe = {
		{"technic:battery","marssurvive:airgen4"},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen4",
	recipe = {
		{"technic:battery","marssurvive:airgen3"},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen3",
	recipe = {
		{"technic:battery","marssurvive:airgen2"},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen2",
	recipe = {
		{"technic:battery","marssurvive:airgen1"},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen1",
	recipe = {
		{"technic:battery","marssurvive:airgen0"},
	}
})

minetest.register_craft({
	output = "marssurvive:batteryblock",
	recipe = {
		{"technic:battery","technic:battery","technic:battery"},
		{"technic:battery","technic:battery","technic:battery"},
		{"technic:battery","technic:battery","technic:battery"},
	}
})

minetest.register_craft({
	output = "marssurvive:unlimitedbatteryblock",
	recipe = {
		{"marssurvive:batteryblock","marssurvive:batteryblock","marssurvive:batteryblock"},
		{"marssurvive:batteryblock","marssurvive:batteryblock","marssurvive:batteryblock"},
		{"marssurvive:batteryblock","marssurvive:batteryblock","marssurvive:batteryblock"},
	}
})

minetest.register_craft({
	output = "marssurvive:airgen_unlimited",
	recipe = {
		{"marssurvive:unlimitedbatteryblock","marssurvive:unlimitedbatteryblock","marssurvive:unlimitedbatteryblock"},
		{"marssurvive:unlimitedbatteryblock","marssurvive:airgen5","marssurvive:unlimitedbatteryblock"},
		{"marssurvive:unlimitedbatteryblock","marssurvive:unlimitedbatteryblock","marssurvive:unlimitedbatteryblock"},
	}
})

--linus added
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
