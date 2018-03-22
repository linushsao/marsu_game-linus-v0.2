minetest.register_craftitem("marsair:fan", {
	description = "Mars Fan",
	inventory_image = "marsair_fan.png",
})

minetest.register_craftitem("marsair:grid", {
	description = "Mars airgenerator grid",
	inventory_image = "marsair_grid.png",
})

minetest.register_craft({
	output = "marsair:fan 2",
	recipe = {
		{"","default:steel_ingot",""},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"","default:steel_ingot",""},
	}
})

minetest.register_craft({
	output = "marsair:grid 6",
	recipe = {
		{"default:steel_ingot","default:steel_ingot",""},
		{"", "", ""},
		{"default:steel_ingot","default:steel_ingot",""},
	}
})


minetest.register_craft({
	output = "marsair:airgen",
	recipe = {
		{"marssurvive:shieldblock","marssurvive:shieldblock","marssurvive:shieldblock"},
		{"marsair:grid", "marsair:fan", "marsair:grid"},
	}
})

minetest.register_craft({
	output = "marsair:airmaker",
	recipe = {
		{"marssurvive:shieldblock","marsair:fan","marssurvive:shieldblock"},
		{"marssurvive:shieldblock","default:dirt", "marssurvive:shieldblock"},
	}
})

minetest.register_craft({
	output = "marsair:tree_air_cleaner",
	recipe = {
		{"marssurvive:shieldblock","marsair:fan","marssurvive:shieldblock"},
		{"marsair:fan","", "marsair:fan"},
	}
})
