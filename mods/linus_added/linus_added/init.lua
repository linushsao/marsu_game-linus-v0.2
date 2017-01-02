--
md0_config = false

--check mods
if minetest.get_modpath("moderators") ~= nil then md0_config = true end

-- for covering old version item
minetest.register_alias("group:sand", "marssurvive:sand")
minetest.register_alias("group:sapling", "marssurvive:mars_sapling")
minetest.register_alias("group:stone", "marssurvive:stone")
minetest.register_alias("protector:protect", "marssurvive:stone")
minetest.register_alias("group:cobble", "marssurvive:cobble")
minetest.register_alias("group:wood", "marssurvive:wood")

--other script
dofile(minetest.get_modpath("linus_added") .. "/functions.lua")

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

--skycolor change by time
day_timer = 0

minetest.register_globalstep(function(dtime)

	day_timer=day_timer+dtime
	if day_timer<2 then return end

	day_timer=0

	local ratio = minetest.get_timeofday() --linus added
--		print("TIME RATOI in globalsetup BEFORE:"..ratio)
		for i, player in pairs(minetest.get_connected_players()) do
			local pos=player:getpos().y
			if pos<=1000 then

				sky_change(player,ratio)

			end
		end

end)




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
	output = 'default:sandstone',
	recipe = {
		{'', 'marssurvive:sand',''},
		{'', 'marssurvive:sand',''},
		{'', 'marssurvive:sand',''},
	}
})

minetest.register_craft({
  type = "cooking",
	output = 'default:desert_stone',
	recipe = 'marssurvive:stone',
})

minetest.register_craft({
  type = "cooking",
	output = 'default:desert_cobble',
	recipe = 'marssurvive:cobble',

})

minetest.register_craft({
  type = "cooking",
	output = 'default:clay_lump 2',
	recipe = 'marssurvive:clayblock',
})

-- for technic ore

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_uranium",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_chromium",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_zinc",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:mineral_lead",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:granite",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})

minetest.register_ore({
  ore_type       = "scatter",
  ore            = "technic:marble",
  wherein        = "marssurvive:stone",
  clust_scarcity = 15 * 15 * 15,
  clust_num_ores = 3,
  clust_size     = 2,
  y_min          = -31000,
  y_max          = -100,
})
