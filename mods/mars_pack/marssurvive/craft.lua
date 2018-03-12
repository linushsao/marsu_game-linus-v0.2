
minetest.register_craft({
	output = "marssurvive:trapdoor_1 2",
	recipe = {
		{"marssurvive:warning","marssurvive:shieldblock",""},
		{"marssurvive:warning","marssurvive:shieldblock", ""},
	}
})


minetest.register_craft({
	type = "cooking"
	output = "default:glass",
	recipe = "group:mars_sand",
})

minetest.register_craft({
	output = "default:sand",
	recipe = {"group:mars_sand"},
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
	output = "marssurvive:diglazer",
	recipe = {
		{"spacesuit:air_gassbottle","marssurvive:shieldblock","marssurvive:shieldblock"},
		{"","marssurvive:shieldblock","marssurvive:shieldblock"},
	}
})

minetest.register_craft({
	output = "default:water_source",
	recipe = {
		{"marssurvive:ice","",""},
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
	output = "default:dirt 3",
	recipe = {
		{"marssurvive:clayblock","marssurvive:clayblock","marssurvive:clayblock"},
		{"marssurvive:clayblock","marssurvive:clayblock", "marssurvive:clayblock"},
		{"marssurvive:clayblock","marssurvive:clayblock","marssurvive:clayblock"},
	}
})

minetest.register_craft({
	output = "marssurvive:mars_sapling 8",
	recipe = {
		{"marssurvive:clayblock","marssurvive:clayblock","marssurvive:clayblock"},
		{"marssurvive:clayblock","marssurvive:clayblock", "marssurvive:clayblock"},
		{"marssurvive:clayblock","default:stick",	"marssurvive:clayblock"},
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



