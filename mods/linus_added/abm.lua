--about ABM

--stone -> mossucobble
minetest.register_abm({
	nodenames = {"marssurvive:cobble"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:mossycobble"})
	end
})

minetest.register_abm({
	nodenames = {"marssurvive:stone"},
	neighbors = {"group:water"},
	interval = 16,
	chance = 200,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:mossycobble"})
	end
})

--water will be dry
minetest.register_abm({
	nodenames = {"default:water_source","default:water_flowing"},
	neighbors = {"marssurvive:sand"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "air"})
	end
})


--water will be FORZEN
minetest.register_abm({
	nodenames = {"default:water_source","default:water_flowing"},
	neighbors = {"marssurvive:ice"},
	interval = 30,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:ice"})
	end
})


