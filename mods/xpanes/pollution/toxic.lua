
minetest.register_node("pollution:gass", {
	description = "Toxic gass",
	inventory_image = "bubble.png",
	tiles = {"pollution_gass.png"},
	walkable = false,
	pointable = false,
	diggable = false,
	drowning = 1,
	buildable_to = true,
	drawtype = "plantlike",
	liquidtype = "airlike",
	groups = {not_in_creative_inventory=1},
	post_effect_color = {a = 50, r =150, g = 150, b = 50},
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.register_node("pollution:barrel_gass", {
	description = "Toxic barrel gass",
	inventory_image = "bubble.png",
	tiles = {"pollution_gass.png"},
	walkable = false,
	pointable = false,
	diggable = false,
	drowning = 1,
	damage_per_second = 3,
	buildable_to = true,
	drawtype = "plantlike",
	liquidtype = "airlike",
	groups = {not_in_creative_inventory=1},
	post_effect_color = {a = 50, r =150, g = 150, b = 50},
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.register_node("pollution:barrel", {
	description = "Toxic barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	drop = "pollution:barrel",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel1.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then
			pollution_sound_pff(pos)
			minetest.set_node(pos, {name = "pollution:barrel_cracked"})
		end
	end,
})


minetest.register_node("pollution:barrel_cracked", {
	description = "Cracked toxic barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	drop = 'pollution:barrel',
	wield_scale = {x=0.5, y=0.5, z=0.5},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel1.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then pollution_spawn_kmob(pos) end
	end,
})

minetest.register_node("pollution:toxic_tree", {
	description = "Toxic tree",
	tiles = {"default_tree_top.png^pollution_dirt.png","default_tree_top.png^pollution_dirt.png","default_tree.png^pollution_dirt.png"},
	groups = {cracky = 3, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
})

minetest.register_node("pollution:dry_plant", {
	description = "Frozen plant",
	tiles = {"default_dry_shrub.png^pollution_source_animated.png"},
	groups = {snappy = 3, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drawtype = "plantlike",
	is_ground_content = false,
})

minetest.register_node("pollution:water_source", {
	description = "Toxic water Source",
	drawtype = "liquid",
	tiles = {name = "default_water_source.png^pollution_yellow.png",},
	tiles = {
		{
		name = "default_water_source_animated.png^pollution_source_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 2.0,
		},
	},},
	alpha = 190,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "pollution:water_flowing",
	liquid_alternative_source = "pollution:water_source",
	liquid_viscosity = 0,
	post_effect_color = {a = 220, r = 150, g = 150, b = 90},
	groups = {liquid = 3, puts_out_fire = 1,not_in_creative_inventory=0},
})

minetest.register_node("pollution:water_flowing", {
	description = "Toxic flowing Water",
	inventory_image = "pollution_yellow.png",
	drawtype = "flowingliquid",
	tiles = {"default_water.png^pollution_yellow.png"},
	special_tiles = {
		{
		name = "default_water_flowing_animated.png^pollution_source_animated.png",
		backface_culling = false,
		animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 0.8,},
		},{
		name = "default_water_flowing_animated.png^pollution_source_animated.png",
		backface_culling = true,animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 0.8,},
		},},
	alpha = 190,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false, 
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "pollution:water_flowing",
	liquid_alternative_source = "pollution:water_source",
	liquid_viscosity = 2,
	post_effect_color = {a = 220, r = 150, g = 150, b = 90},
	groups = {liquid = 3, puts_out_fire = 1,not_in_creative_inventory = 1},
})

minetest.register_node("pollution:dirt", {
	description = "Desiccated dirt",
	tiles = {"default_dirt.png^pollution_dirt.png"},
	groups = {crumbly = 3, soil = 1,not_in_creative_inventory = 1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_abm({
	nodenames = {"air","flowers:waterlily"},
	neighbors = {"pollution:water_source","pollution:water_flowing"},
	interval = 5,
	chance = 5,
	action = function(pos)
		local pos1={x=pos.x,y=pos.y-1,z=pos.z}
		local pos2={x=pos.x,y=pos.y+1,z=pos.z}
		minetest.set_node(pos, {name = "pollution:gass"})
		if (minetest.get_node(pos1).name=="pollution:water_source" or minetest.get_node(pos1).name=="pollution:water_flowing" ) and minetest.get_node(pos2).name=="air" then
			minetest.set_node(pos2, {name = "pollution:gass"})
		end
	end,
})


minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"pollution:gass"},
	interval = 15,
	chance = 5,
	action = function(pos)
		local name=minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name
		if name~="pollution:water_source" and name~="pollution:gass" and name~="pollution:water_flowing" then
			minetest.set_node(pos, {name = "air"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"pollution:barrel_cracked"},
	interval = 5,
	chance = 2,
	action = function(pos)
		minetest.set_node(pos, {name ="pollution:barrel_gass"})
	end,
})



minetest.register_abm({
	nodenames = {"default:tree"},
	neighbors = {"pollution:dirt"},
	interval = 5,
	chance = 2,
	action = function(pos)
		minetest.set_node(pos, {name ="pollution:toxic_tree"})
	end,
})

minetest.register_abm({
	nodenames = {"group:water","default:dirt_with_grass","default:dirt","group:tree","group:flora"},
	neighbors = {"pollution:water_source","pollution:water_flowing","pollution:barrel_cracked","pollution:toxic_tree"},
	interval = 5,
	chance = 5,
	action = function(pos)
		local name=minetest.get_node(pos).name

		if minetest.get_node_group(name, "water")>0 then
				local np=minetest.find_node_near(pos, 1,{"pollution:water_source","pollution:water_flowing","pollution:barrel_cracked"})
				local n
				if np~=nil then n=minetest.get_node(np) end
				if n and n.name=="pollution:water_source" then
					local r=minetest.get_meta(np):get_int("prl")
					if r>0 and r<pollution_waste_toxic_radius then
						minetest.set_node(pos, {name = "pollution:water_source"})
						minetest.get_meta(pos):set_int("prl",r+1)
					end
				elseif n and (n.name=="pollution:barrel_cracked" or n.name=="pollution:water_flowing") then
					minetest.set_node(pos, {name = "pollution:water_source"})
					minetest.get_meta(pos):set_int("prl",1)
				end
		end
		if name=="default:dirt_with_grass" then
			minetest.set_node(pos, {name = "default:dirt"})
		end
		if name=="default:dirt" then
			minetest.set_node(pos, {name = "pollution:dirt"})
		end
		if minetest.get_node_group(name, "tree")==1 then
			minetest.set_node(pos, {name = "pollution:toxic_tree"})
		end
		if minetest.get_node_group(name, "flora")==1 then
			minetest.set_node(pos, {name = "pollution:dry_plant"})
		end
	end,
})