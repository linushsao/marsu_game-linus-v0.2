minetest.register_craft({
	output = "pollution:qbarrel_empty",
	recipe = {
		{"default:steel_ingot","group:sand","default:steel_ingot"},
		{"default:steel_ingot","group:sand","default:steel_ingot"},
		{"default:steel_ingot","group:sand","default:steel_ingot"},
	},
})


minetest.register_craft({
	output = "pollution:qbarrel",
	recipe = {
		{"bucket:bucket_water","group:sand"},
		{"pollution:qbarrel_empty","group:sand"},
	},
	replacements = {
		{"bucket:bucket_water","bucket:bucket_empty"},
	},

})


minetest.register_node("pollution:qbarrel", {
	description = "Quicksand barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel7.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	liquids_pointable = true,
on_use = function(itemstack, user, pointed_thing)
	local pos
	if minetest.registered_nodes[minetest.get_node(pointed_thing.under).name].buildable_to then
		pos=pointed_thing.under
	elseif minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].buildable_to then
		pos=pointed_thing.above
	else
		return itemstack
	end


	if pointed_thing.type=="node" and minetest.is_protected(pos,user:get_player_name())==false then

			local inv = user:get_inventory()
				if inv:room_for_item("main", {name="pollution:qbarrel_empty"}) then
					inv:add_item("main","pollution:qbarrel_empty")
					minetest.set_node(pos,{name="pollution:quicksand"})
					itemstack:take_item()
					return itemstack
				end
	end
	return itemstack
end,
})

minetest.register_node("pollution:qbarrel_empty", {
	description = "Quicksand (empty)",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel7.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	liquids_pointable = true,
on_use = function(itemstack, user, pointed_thing)
	if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.under,user:get_player_name())==false then
		if minetest.get_node(pointed_thing.under).name=="pollution:quicksand" then
			local inv = user:get_inventory()
				if inv:room_for_item("main", {name="pollution:qbarrel"}) then
					minetest.set_node(pointed_thing.under,{name="air"})
					inv:add_item("main","pollution:qbarrel")
					itemstack:take_item()
					return itemstack
				end
		end
	end
	return itemstack
end,
})


minetest.register_node("pollution:quicksand_u", {
	description = "Quicksand under",
	tiles={"default_sand.png"},
	groups = {liquid = 4,crumbly = 1, sand = 1,not_in_creative_inventory=1},
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	drowning = 1,
	damage_per_second = 2,
	drop="pollution:quicksand",
	post_effect_color = {a=255,r=0,g=0,b=0},
})

minetest.register_node("pollution:quicksand", {
	description = "Quicksand",
	drawtype = "liquid",
	tiles = {"default_sand.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = false,
	drowning = 1,
	liquidtype = "source",
	liquid_range = 2,
	liquid_alternative_flowing = "pollution:quicksand2",
	liquid_alternative_source = "pollution:quicksand",
	liquid_viscosity = 15,
	post_effect_color = {a=255,r=0,g=0,b=0},
	groups = {liquid = 4,crumbly = 1, sand = 1},
})

minetest.register_node("pollution:quicksand2", {
	description = "Quicksand2",
	drawtype = "flowingliquid",
	tiles = {"default_sand.png"},
	special_tiles = {
		{
			name = "default_sand.png",
			backface_culling = false,
		},
	},
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "pollution:quicksand2",
	liquid_alternative_source = "pollution:quicksand",
	liquid_viscosity = 1,
	liquid_range = 2,
	post_effect_color = {a = 103, r = 30, g = 76, b = 90},
	groups = {liquid = 4, not_in_creative_inventory = 1},
})

minetest.register_abm({
	nodenames = {"pollution:quicksand"},
	interval = 10.0,
	chance = 3,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local opos=minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name
		local upos=minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name
		if opos=="air" and (upos=="default:sand" or upos=="default:dirt"  or upos=="pollution:quicksand") then
			minetest.set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name = "pollution:quicksand_u"})

		local upos=minetest.get_node({x=pos.x,y=pos.y-2,z=pos.z}).name
		if upos=="default:sand" or upos=="default:dirt" then
			minetest.set_node({x=pos.x,y=pos.y-2,z=pos.z}, {name = "pollution:quicksand"})
		end

		else
			for i, ob in pairs(minetest.get_objects_inside_radius({x=pos.x,y=pos.y-2.5,z=pos.z}, 1)) do
				if ob:is_player()==false then
					ob:set_hp(ob:get_hp()-50)
					ob:punch(ob, {full_punch_interval=1.0,damage_groups={fleshy=9000}}, "default:bronze_pick", nil)
				end
			end
		end
	end,
})
