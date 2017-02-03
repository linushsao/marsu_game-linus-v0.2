minetest.register_craft({
	output = "pollution:cbarrel",
	recipe = {
		{"pollution:bottlepur","pollution:barrel", "pollution:bottlepur"},
	}
})

function pollution_c_punch(level,ob,user)
	local dmg=math.random(20)
	local hp=ob:get_hp()
	pollution_sound_lightning(ob:getpos())
	for i=0,dmg,1 do
		hp=hp-level
		local time=math.random(10)*0.1
		if ob:get_hp()<=0 then return false end
		minetest.after((i*0.3)+time, function(ob,user,nosound)
		if ob==nil or ob:get_hp()<=0 then return false end
		ob:set_hp(ob:get_hp()-level)
		if user then
			ob:punch(user, {full_punch_interval=1,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
		end
		end, ob,user)
	if hp<=0 then return false end
	end

end

pollution_c_setarea=function(pos, elapsed)
--pollution:crystal_big
--pollution:crystal_medium
--pollution:crystal_small
--pollution:crystal_grass
--pollution:crystal_block
--pollution:crystal_soil
	local rnd=math.random(1,10)
	local area=math.random(30,100)
	local found1=1
	local found2=1
	for i=0,rnd,1 do
		local np=minetest.find_node_near(pos, area,{
			"group:snappy",
			"group:tree",
		})


		if np~=nil and minetest.is_protected(np,"")==false then

		local n=minetest.get_node(np)
		if minetest.get_node_group(n.name, "tree")>0 then minetest.set_node(np, {name = "pollution:crystal_block"}) end
		if minetest.get_node_group(n.name, "snappy")>0 then
			local size=math.random(10)
			if size==10 then minetest.set_node(np, {name = "pollution:crystal_big"}) end
			if size==9 then minetest.set_node(np, {name = "pollution:crystal_medium"}) end
			if size==8 then minetest.set_node(np, {name = "pollution:crystal_small"}) end
			if size<=7 then minetest.set_node(np, {name = "pollution:crystal_grass"}) end
			if math.random(200)==1 and minetest.get_node_group(minetest.get_node({x=np.x,y=np.y-1,z=np.z}).name, "soil")>0 then
				local crystal=minetest.get_modpath("pollution").."/schems/pollution_crystal.mts"
				minetest.place_schematic(np, crystal, "random", {}, true)
			end


		end
		else
			found1=0
			break 
		end

	end
	area=math.random(30,area-10)
	for i=0,rnd,1 do
		local np=minetest.find_node_near(pos, area,{
			"group:soil"
		})
		if np~=nil and minetest.is_protected(np,"")==false then 
		local n=minetest.get_node(np)
			minetest.set_node(np, {name = "pollution:crystal_soil"})
			if math.random(10)==1 and minetest.get_node({x=np.x,y=np.y+1,z=np.z}).name=="air" then
				np={x=np.x,y=np.y+1,z=np.z}
				local size=math.random(10)
				if size==10 then minetest.set_node(np, {name = "pollution:crystal_big"}) end
				if size==9 then minetest.set_node(np, {name = "pollution:crystal_medium"}) end
				if size==8 then minetest.set_node(np, {name = "pollution:crystal_small"}) end
				if size<=7 then minetest.set_node(np, {name = "pollution:crystal_grass"}) end
			end
		else
			found2=0
			break
		end
	end
	if found1+found2==0 or math.random(1,20)==3 then
		minetest.set_node(pos, {name = "pollution:cbarrel"})
		return false
	end
	return true
end


minetest.register_node("pollution:crystal_big", {
	description = "Big crystal",
	drawtype = "mesh",
	mesh = "pollution_crystals.obj",
	visual_scale = 0.3,
	wield_scale = {x=1, y=1, z=1},
	alpha = 20,
	tiles = {
		{
			name = "pollution_crystals.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	damage_per_second = 10,
	walkable = false,
	is_ground_content = false,
	light_source=3,
	selection_box = {
		type = "fixed",
		fixed = {-1, -1, -1, 1, 1, 1}
	},
collision_box = {
		type = "fixed",
		fixed = {{-2, -2, -2, 2, 2, 2},}},
	groups = {cracky = 1, level = 3,not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_c_punch(5,puncher)
	end,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type=="node" or pointed_thing.type=="nothing" then return itemstack end
		local pvp=minetest.setting_getbool("enable_pvp")
		local ob=pointed_thing.ref
		if ob:is_player() and pvp==false then return itemstack end
		pollution_c_punch(5,ob,user)
		return itemstack
		end,
})

minetest.register_node("pollution:crystal_medium", {
	description = "Medium crystal",
	drawtype = "mesh",
	mesh = "pollution_crystals.obj",
	visual_scale = 0.2,
	wield_scale = {x=1, y=1, z=1},
	alpha = 20,
	tiles = {
		{
			name = "pollution_crystals.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	damage_per_second = 4,
	walkable = false,
	is_ground_content = false,
	light_source=3,
	groups = {cracky = 2, level = 2,not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_c_punch(2,puncher)
	end,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type=="node" or pointed_thing.type=="nothing" then return itemstack end
		local pvp=minetest.setting_getbool("enable_pvp")
		local ob=pointed_thing.ref
		if ob:is_player() and pvp==false then return itemstack end
		pollution_c_punch(2,ob,user)
		return itemstack
		end,
})

minetest.register_node("pollution:crystal_small", {
	description = "Small crystal",
	drawtype = "mesh",
	mesh = "pollution_crystal.obj",
	visual_scale = 2,
	wield_scale = {x=2, y=2, z=2},
	alpha = 20,
	tiles = {
		{
			name = "pollution_crystals.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	damage_per_second = 5,
	walkable = false,
	is_ground_content = false,
	light_source=8,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.25, 0.1}
	},
	groups = {cracky = 1, level = 1,not_in_creative_inventory=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_c_punch(1,puncher)
	end,
	on_use = function(itemstack, user, pointed_thing)
		if pointed_thing.type=="node" or pointed_thing.type=="nothing" then return itemstack end
		local pvp=minetest.setting_getbool("enable_pvp")
		local ob=pointed_thing.ref
		if ob:is_player() and pvp==false then return itemstack end
		pollution_c_punch(1,ob,user)
		return itemstack
		end,
})

minetest.register_node("pollution:crystal_block", {
	description = "Crystal block",
	tiles = {
		{
			name = "pollution_crystals.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	groups = {cracky = 1, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	light_source=8,
	paramtype = "light",
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_c_punch(1,puncher)
	end,

})


minetest.register_node("pollution:crystal_soil", {
	description = "Crystal soil",
	tiles = {"default_obsidian.png^pollution_lila2.png"},
	groups = { oddly_breakable_by_hand = 1,choppy = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults(),
	light_source=5,
	paramtype = "light",
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
	end,

})

minetest.register_node("pollution:crystal_grass", {
	description = "Crystal grass",
	tiles = {"pollution_crystal_grass.png"},
	groups = {cracky = 1, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drawtype = "plantlike",
	is_ground_content = false,
	damage_per_second = 3,
})


minetest.register_node("pollution:cbarrel", {
	description = "Crystal barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	wield_scale = {x=1, y=1, z=1},
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
	collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel3.png"},
	groups = {barrel=3,cracky = 1, level = 2,not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
	pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then
			pollution_sound_pff(pos)
			minetest.set_node(pos, {name = "pollution:cbarrel_cracked"})
			pollution_c_punch(1,puncher)
		end
		return true
	end,
})

minetest.register_node("pollution:cbarrel_cracked", {
	description = "Cracked crystal  barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	drop = 'pollution:cbarrel',
	wield_scale = {x=0.5, y=0.5, z=0.5},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.8, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.8, 0.4},}},

	tiles = {"pollution_lila.png","pollution_lila.png^pollution_crack.png","pollution_lila.png","pollution_lila.png","pollution_black.png","pollution_lila.png^pollution_log2.png"},
	groups = {barrel=3,cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	on_construct=function(pos)
		minetest.env:get_node_timer(pos):start(1)
	end,
	on_timer=pollution_c_setarea,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_c_punch(1,puncher)
		pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then pollution_spawn_kmob(pos,1) end
		return true
	end,
})