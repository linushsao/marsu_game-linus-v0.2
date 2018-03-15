--make pullution water from water&small alien's gene
minetest.register_craft({
	output = "pollution:water_source",
	recipe = {
		{"default:water_source","marssurvive:unusedgold",""},
		{"","", ""},
	}
})

-- fuels additional

--others
minetest.register_craft({
	output = 'default:lamp_wall 2',
	recipe = {
		{'default:glass', '', ''},
		{'default:torch', '', ''},
		{'default:glass', '', ''},
	}
})


minetest.register_craft({
	type = "cooking",
	output = "default:water_source",
	recipe = "caverealms:thin_ice",
})


minetest.register_craft({
	output = 'marssurvive:sand 3',
	recipe = {
		{'default:sandstone'},
	}
})


minetest.register_craft({
	output = 'default:sand',
	recipe = {
		{'marssurvive:sand'},
	}
})

minetest.register_craft({
	output = 'pollution:water_source',
	recipe = {
		{'default:water_source','marssurvive:unusedgold',''},
		{'','',''}
	}
})

--cooking recipe

minetest.register_craft({
	output = 'default:desert_cobble',
	recipe = {
		{'marssurvive:cobble'},
	}
})

--
minetest.register_craft({
	output = "bushes:strawberry_pie_raw 1",
	recipe = {
	{ "bushes:sugar", "farming:flour", "bushes:sugar" },
	{ "farming:strawberry", "farming:strawberry", "farming:strawberry" },
	},
})
minetest.register_craft({
	output = "bushes:strawberry_pie_raw 1",
	recipe = {
	{ "bushes:sugar", "group:junglegrass", "bushes:sugar" },
	{ "farming:strawberry", "farming:strawberry", "farming:strawberry" },
	},
})
