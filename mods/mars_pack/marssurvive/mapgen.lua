minetest.clear_registered_ores()
minetest.clear_registered_biomes()
minetest.clear_registered_decorations()

	minetest.register_biome({
		name = "mars_desert",
		--node_dust = "",
		node_top = "marssurvive:sand",
		depth_top = 5,
		node_filler = "marssurvive:stone",
		depth_filler = 3,
		node_stone = "marssurvive:stone",
		node_water_top = "air",
		depth_water_top =1 ,
		node_water = "air",
		node_river_water = "air",
		y_min = -31000,
		y_max = 200,
		heat_point = 50,
		humidity_point = 50,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:ice",
		wherein        = "default:water_source",
		clust_scarcity =  1 * 1 * 1,
		clust_num_ores = 2,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = 200,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:oxogen",
		wherein        = "marssurvive:stone","marssurvive:sand",
		clust_scarcity =  30 * 30 * 30,
		clust_num_ores = 8,
		clust_size     = 4,
		y_min          = -31000,
		y_max          = 200,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt",
		wherein        = "marssurvive:stone",
		clust_scarcity =  8 * 8 * 8,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -50,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:gravel",
		wherein        = "marssurvive:stone",
		clust_scarcity = 30 * 30 * 30,
		clust_num_ores = 6,
		clust_size     = 6,
		y_min          = -31000,
		y_max          = -50,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:clayblock",
		wherein        = "marssurvive:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 4,
		y_min          = -100,
		y_max          = 200,
	})

		minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:stone_with_coal",
		wherein        = "marssurvive:stone",
		clust_scarcity = 8 * 8 * 8,
		clust_num_ores = 8,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = 64,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:stone_with_iron",
		wherein        = "marssurvive:stone",
		clust_scarcity = 10 * 10 * 10,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = 50,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:ice",
		wherein        = "marssurvive:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 3,
		clust_size     = 5,
		y_min          = -31000,
		y_max          = -10,
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:stone_with_mese",
		wherein        = "marssurvive:stone",
		clust_scarcity = 18 * 18 * 18,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -64,
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = "marssurvive:stone",
		clust_scarcity = 36 * 36 * 36,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -1024,
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:stone_with_gold",
		wherein        = "marssurvive:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -64,
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:stone_with_diamond",
		wherein        = "marssurvive:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:ujeore",
		wherein        = "marssurvive:stone",
		clust_scarcity = 15 * 15 * 15,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -100,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "marssurvive:stone_with_copper",
		wherein        = "marssurvive:stone",
		clust_scarcity = 12 * 12 * 12,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -16,
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"marssurvive:sand"},
		sidelen = 16,
		fill_ratio = 0.01,
		y_min = -20,
		y_max = 200,
		decoration = "marssurvive:stone_medium",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"marssurvive:sand"},
		sidelen = 16,
		fill_ratio = 0.01,
		y_min = -20,
		y_max = 200,
		decoration = "marssurvive:stone_small",
	})

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"marssurvive:sand","marssurvive:stone"},
		sidelen = 16,
		fill_ratio = 0.00001,
		y_min = -31000,
		y_max = 50,
		decoration = "marssurvive:crystal",
	})

minetest.register_abm({
	label = "Grass spread mars",
	nodenames = {"default:dirt"},
	neighbors = {
		"air",
	},
	interval = 6,
	chance = 50,
	catch_up = false,
	action = function(pos, node)
		-- Check for darkness: night, shadow or under a light-blocking node
		-- Returns if ignore above
		local above = {x = pos.x, y = pos.y + 1, z = pos.z}
		if (minetest.get_node_light(above) or 0) < 13 then
			return
		end
		minetest.set_node(pos, {name = "default:dirt_with_grass"})
	end
})

-- this part makes it crash or just wont work

mapgen_params = {
water_level=-31000,
flags="caves,dungeons,light,decorations",
}

minetest.register_on_mapgen_init(function()
	minetest.set_mapgen_params(mapgen_params)
end)
