minetest.register_craft({
	output = "marssurvive:secam_off",
	recipe = {
		{"default:steel_ingot", "dye:black", "default:steel_ingot"},
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "dye:black", "default:steel_ingot"},
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
	recipe = {{"marssurvive:clayblock","",""}}})

minetest.register_craft({
	output = "marssurvive:wood 3",
	recipe = {{"marssurvive:tree","",""}}})
