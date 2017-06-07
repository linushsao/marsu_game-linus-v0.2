--make pullution water from water&small alien's gene
minetest.register_craft({
	output = "pollution:water_source",
	recipe = {
		{"default:water_source","marssurvive:unusedgold",""},
		{"","", ""},
	}
})

-- fuels additional

minetest.register_craft({
	type = "fuel",
	recipe = "marssurvive:mars_sapling",
	burntime = 10,
})

minetest.register_craft({
	type = "fuel",
	recipe = "marssurvive:wood",
	burntime = 15,
})

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
	recipe = "marssurvive:ice",
})

minetest.register_craft({
	type = "cooking",
	output = "default:water_source",
	recipe = "default:ice",
})

minetest.register_craft({
	type = "cooking",
	output = "default:water_source",
	recipe = "caverealms:thin_ice",
})

minetest.register_craft({
	output = 'default:furnace',
	recipe = {
		{'group:cobble', 'group:cobble', 'group:cobble'},
		{'group:cobble', '', 'group:cobble'},
		{'group:cobble', 'group:cobble', 'group:cobble'},
	}
})

minetest.register_craft({
	output = 'default:sapling',
	recipe = {
		{'', 'default:apple', ''},
		{'', 'default:dirt', ''},
		{'', '', ''},
	}
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
	output = 'marssurvive:clayblock',
	recipe = {
		{'default:clay_lump','default:clay_lump',''},
		{'','',''},
		{'','',''},

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
  type = "cooking",
	output = 'default:desert_stone',
	recipe = 'default:desert_cobble',
})

minetest.register_craft({
  type = "cooking",
	output = 'marssurvive:stone',
	recipe = 'marssurvive:cobble',

})

minetest.register_craft({
	output = 'default:desert_cobble',
	recipe = {
		{'marssurvive:cobble'},
	}
})

minetest.register_craft({
  type = "cooking",
	output = 'default:clay_lump 2',
	recipe = 'marssurvive:clayblock',
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