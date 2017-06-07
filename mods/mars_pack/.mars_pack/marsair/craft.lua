minetest.register_craft({
	output = "marsair:airgen",
	recipe = {
		{"marssurvive:shieldblock","marssurvive:shieldblock","marssurvive:shieldblock"},
		{"marssurvive:shieldblock","marssurvive:oxogen", "marssurvive:shieldblock"},
	}
})

minetest.register_craft({
	output = "marsair:airmaker",
	recipe = {
		{"marssurvive:shieldblock","marssurvive:shieldblock","marssurvive:shieldblock"},
		{"marssurvive:shieldblock","marsair:airgen", "marssurvive:shieldblock"},
	}
})

minetest.register_craft({
	output = "marsair:tree_air_cleaner",
	recipe = {
		{"marssurvive:shieldblock","marssurvive:shieldblock","marssurvive:shieldblock"},
		{"marssurvive:shieldblock","marsair:airmaker", "marssurvive:shieldblock"},
	}
})