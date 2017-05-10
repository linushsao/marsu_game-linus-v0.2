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
dofile(minetest.get_modpath("linus_added") .. "/command.lua")

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
--		print("DRY@@@@@@@@@@@@@@@@@@")
	end
})

--pollution water will be dry
minetest.register_abm({
	nodenames = {"pollution:water_source"},
	neighbors = {"marssurvive:sand"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "air"})
--		print("DRY@@@@@@@@@@@@@@@@@@")
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
--		print("FROZEN@@@@@@@@@@@@@@@@@@")
	end
})

-- bring scifi-planet into world
minetest.register_abm({
	nodenames = {"pollution:dirt"},
	interval = 120,
	chance = 120,
	action = function(pos)
		local posu={x=pos.x,y=pos.y+1,z=pos.z}
		local n=minetest.get_node(posu).name
		print(n)
		if n=="air" or nd=="marssurvive:air2" then
			local rnd=math.random(1,18)
			if rnd==1 then
				minetest.set_node(posu, {name = "scifi_nodes:eyetree"})
			elseif rnd==2 then
				minetest.set_node(posu, {name = "scifi_nodes:flower1"})
			elseif rnd==3 then
				minetest.set_node(posu, {name = "scifi_nodes:flower2"})
			elseif rnd==4 then
				minetest.set_node(posu, {name = "scifi_nodes:flower3"})
			elseif rnd==5 then
				minetest.set_node(posu, {name = "scifi_nodes:flower4"})
			elseif rnd==6 then
				minetest.set_node(posu, {name = "scifi_nodes:gloshroom"})
			elseif rnd==7 then
				minetest.set_node(posu, {name = "scifi_nodes:grass"})
			elseif rnd==8 then
				minetest.set_node(posu, {name = "scifi_nodes:plant1"})
			elseif rnd==9 then
				minetest.set_node(posu, {name = "scifi_nodes:plant2"})
			elseif rnd==10 then
				minetest.set_node(posu, {name = "scifi_nodes:plant3"})
			elseif rnd==11 then
				minetest.set_node(posu, {name = "scifi_nodes:plant4"})
			elseif rnd==12 then
				minetest.set_node(posu, {name = "scifi_nodes:plant5"})
			elseif rnd==13 then
				minetest.set_node(posu, {name = "scifi_nodes:plant6"})
			elseif rnd==14 then
				minetest.set_node(posu, {name = "scifi_nodes:plant7"})
			elseif rnd==15 then
				minetest.set_node(posu, {name = "scifi_nodes:plant8"})
			elseif rnd==16 then
				minetest.set_node(posu, {name = "scifi_nodes:plant9"})
			elseif rnd==17 then
				minetest.set_node(posu, {name = "scifi_nodes:plant10"})
			elseif rnd==18 then
				minetest.set_node(posu, {name = "scifi_nodes:plant_trap"})

			end
		end
	end,
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

--show formspace of wiki to un-interact players automatically every 3 seconds
local wiki_timer = 0

wiki_show = {}

minetest.register_globalstep(function(dtime)

	wiki_timer=wiki_timer+dtime

	if wiki_timer<5 then return end
	wiki_timer=0
	local v1,vv

	for v1,vv in ipairs(wiki_pos) do --pick wikinod's position to get_objects
		local all_objects = {}
		local _,obj

		all_objects[v1] = minetest.get_objects_inside_radius({x=vv.x, y=vv.y, z=vv.z},3)
		if #all_objects[v1] ~= 0 then print("#all_objects :"..v1.."##"..dump(all_objects[v1]))
		else
	--		print("wiki node "..v1.." detect no object")
			wiki_show[v1] = {}
		end

		if wiki_show[v1] ~= nil then
			for v11,vvv in ipairs(wiki_show[v1]) do --check if players leave
				if all_objects[v1][v11] == nil then
					table.remove(wiki_show[v1],v11)
					print("player "..v11.."leave")
				end
			end
		end

		for _,obj in ipairs(all_objects[v1]) do
			if obj:is_player() then
				print("players found :"..obj:get_player_name())
				if wiki_show[v1] == nil then wiki_show[v1]={} end
				if wiki_show[v1][obj:get_player_name()] == nil then --never show wiki
					wiki_show[v1][obj:get_player_name()] = true
					print(v1.." show to "..obj:get_player_name())
				elseif wiki_show[v1][obj:get_player_name()] == true then
					wiki_show[v1][obj:get_player_name()] = false --had show
					print(v1.." had show to "..obj:get_player_name())
				elseif wiki_show[v1][obj:get_player_name()] == false then
					print(v1.." had show to "..obj:get_player_name())
				end
				print("player: "..obj:get_player_name())
				if wiki_show[v1][obj:get_player_name()] then
					wikilib.show_wiki_page(obj:get_player_name(), "Main")
				end
			end
		end
	end
--	print("wiki_pos "..dump(wiki_pos))
end)

minetest.register_on_shutdown(function()
	save_table(wiki_pos,"wiki_pos_file")
end)


--pollution water will be clean
minetest.register_abm({
	nodenames = {"pollution:water_source"},
	neighbors = {"default:water_source","default:water_flowing"},
	interval = 5,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:water_source"})
--		print("CLEAN WATER")
	end
})


--pollution dirt will be clean
minetest.register_abm({
	nodenames = {"pollution:dirt"},
	neighbors = {"default:water_source","default:water_flowing"},
	interval = 30,
	chance = 2,
	catch_up = false,
	action = function(pos, node)
		minetest.set_node(pos, {name = "default:dirt"})
--		print("CLEAN DIRT")
	end
})

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
--

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
