minetest.register_craft({
	output = 'glowtest:rune_1',
	recipe = {
		{'group:crystal', 'default:stone', 'default:stone'},
		{'group:crystal', 'default:mese', 'group:crystal'},
		{'group:crystal', 'default:stone', 'group:crystal'},
	}
})

minetest.register_craft({
	output = 'glowtest:rune_2',
	recipe = {
		{'default:stone', 'group:crystal', 'default:stone'},
		{'group:crystal', 'default:mese', 'group:crystal'},
		{'default:stone', 'group:crystal', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'glowtest:rune_1_cursed',
	recipe = {
		{'group:crystal_cursed', 'default:stone', 'default:stone'},
		{'group:crystal_cursed', 'default:mese', 'group:crystal_cursed'},
		{'group:crystal_cursed', 'default:stone', 'group:crystal_cursed'},
	}
})

minetest.register_craft({
	output = 'glowtest:rune_2_cursed',
	recipe = {
		{'default:stone', 'group:crystal_cursed', 'default:stone'},
		{'group:crystal_cursed', 'default:mese', 'group:crystal_cursed'},
		{'default:stone', 'group:crystal_cursed', 'default:stone'},
	}
})