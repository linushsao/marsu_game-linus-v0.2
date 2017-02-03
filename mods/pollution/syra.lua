minetest.register_tool("pollution:yrifle", {
	description = "Acid fire rifle",
	range = 4,
	inventory_image = "pollution_trifle.png^[colorize:#00dd0055",
		on_use = function(itemstack, user, pointed_thing)
			local w=65534/20
			local dir = user:get_look_dir()
			local po=user:getpos()
			local pos={x=po.x+(dir.x*2), y=po.y+1.5+(dir.y*2), z=po.z+(dir.z*2)}
			local name=user:get_player_name()
			if minetest.is_protected(pos,name)==false and itemstack:get_wear()<w*18 then
				itemstack:set_wear(itemstack:get_wear()+w)
				for i=0,10,1 do
					local p={x=pos.x+(dir.x*i), y=pos.y+(dir.y*i), z=pos.z+(dir.z*i)}
					if minetest.is_protected(p,name)==false and minetest.registered_nodes[minetest.get_node(p).name].walkable==false then
						minetest.set_node(p, {name ="pollution:acid_fire"})
					else
						break
					end
				end
			elseif itemstack:get_wear()>=w*18 then
				minetest.chat_send_player(name, "the power is end, rightclick (place) to reload")
			end
		return itemstack
		end,
	on_place = function(itemstack, user, pointed_thing)
		local w=(65534/20)
		if itemstack:get_wear()-w >w/19 then
			itemstack:set_wear(itemstack:get_wear()-w)
		else
			itemstack:set_wear(0)
		end
		return itemstack
	end
})


minetest.register_node("pollution:ybarrel", {
	description = "Acid barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	drop = "pollution:ybarrel",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel5.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then
			pollution_sound_pff(pos)
			minetest.set_node(pos, {name = "pollution:ybarrel_cracked"})
			minetest.set_node({x=pos.x,y=pos.y+1,z=pos.z}, {name="pollution:gass"})
			for i=0,math.random(1,6),1 do
				local p=minetest.find_node_near(pos, 1,{"air"})
				if p~=nil and p.y==pos.y then
				minetest.set_node(p, {name="pollution:syra_source"})
				end
			end
		end
	end,
})


minetest.register_node("pollution:ybarrel_cracked", {
	description = "Cracked acid barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	drop = 'pollution:ybarrel',
	wield_scale = {x=0.5, y=0.5, z=0.5},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel5.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
		pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then
			pollution_spawn_kmob(pos)
		end
	end,
})



minetest.register_node("pollution:syra_source", {
	description = "Acid water source",
	drawtype = "liquid",
	tiles = {name = "default_water_source.png^[colorize:#00ff00cc",},
	tiles = {
		{
		name = "default_water_source_animated.png^[colorize:#00ff00cc",
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
	liquid_alternative_flowing = "pollution:syra_flowing",
	liquid_alternative_source = "pollution:syra_source",
	liquid_viscosity = 0,
	post_effect_color = {a = 255, r = 20, g = 255, b = 0},
	groups = {liquid = 3, puts_out_fire = 1,not_in_creative_inventory=0},
	damage_per_second = 19,
})

minetest.register_node("pollution:syra_flowing", {
	description = "Acid flowing",
	drawtype = "flowingliquid",
	tiles = {"default_water.png^[colorize:#00ff00cc"},
	special_tiles = {
		{
		name = "default_water_flowing_animated.png^[colorize:#00ff00cc",
		backface_culling = false,
		animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 0.8,},
		},{
		name = "default_water_flowing_animated.png^[colorize:#00ff00cc",
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
	liquid_alternative_flowing = "pollution:syra_flowing",
	liquid_alternative_source = "pollution:syra_source",
	liquid_viscosity = 2,
	post_effect_color = {a = 255, r = 20, g = 255, b = 0},
	groups = {liquid = 3, puts_out_fire = 1,not_in_creative_inventory = 1},
	damage_per_second = 19,
})

minetest.register_abm({
	nodenames = {"group:soil","group:sand","group:flammable","group:dig_immediate","group:water","group:flowers","group:oddly_breakable_by_hand","group:ncmdw"},
	neighbors = {"pollution:syra_source","pollution:syra_flowing"},
	interval = 10,
	chance = 4,
	action = function(pos)
		if minetest.is_protected(pos,"")==false then
		minetest.set_node(pos, {name ="pollution:acid_fire"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"pollution:syra_source","pollution:syra_flowing"},
	interval = 10,
	chance = 4,
	action = function(pos)
		local dmg=0
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 4)) do
			if ob:get_luaentity() and ob:get_luaentity().name=="pollution:axovy" then dmg=1 end
			if dmg==0 and minetest.get_node(ob:getpos()).name~="pollution:acid_fire" and minetest.registered_nodes[minetest.get_node(ob:getpos()).name].walkable==false then
				ob:set_hp(ob:get_hp()-8)
				ob:punch(ob, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				minetest.set_node(ob:getpos(), {name ="pollution:acid_fire"})
			end
		end

	end,
})

minetest.register_node("pollution:acid_fire", {
	description = "Acid fire",
	inventory_image = "fire_basic_flame.png^[colorize:#00dd00cc",
	drawtype = "firelike",
	tiles = {
		{
			name = "fire_basic_flame_animated.png^[colorize:#00dd00cc",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1
			},
		},
	},
	paramtype = "light",
	light_source = 14,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	damage_per_second = 2,
	groups = {dig_immediate = 2},
	drop="",
	on_construct=function(pos)
		minetest.sound_play("fire_small", {pos=pos, gain = 1.0, max_hear_distance = 5,})
		minetest.env:get_node_timer(pos):start(5)
	end,
	on_punch=function(pos, node, puncher, pointed_thing)
		if math.random(2)==1 then
			puncher:set_hp(puncher:get_hp()-7)
		end
	end,

	on_timer=function (pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 4)) do
			local p=ob:getpos()
			local dmg=1
			if ob:get_luaentity() and ob:get_luaentity().name=="pollution:axovy" then dmg=0 end
			if dmg==1 and minetest.get_node(p).name~="pollution:acid_fire" and minetest.registered_nodes[minetest.get_node(p).name].walkable==false then
				ob:set_hp(ob:get_hp()-8)
				ob:punch(ob, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				minetest.set_node(p, {name ="pollution:acid_fire"})
			end

			if math.random(4)==1 and ob:get_hp()>0 then
				minetest.after(math.random(1,10), function(ob,p)
					if ob==nil or ob:get_hp()<=0 or ob:getpos()==nil then return false end
					ob:set_hp(ob:get_hp()-8)
					ob:punch(ob, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
					if minetest.registered_nodes[minetest.get_node(ob:getpos()).name].walkable==false then minetest.set_node(ob:getpos(), {name ="pollution:acid_fire"}) end
				end, ob,p)
			end


		end




		if math.random(3)==1 then
			minetest.set_node(pos, {name ="air"})
		else
			minetest.sound_play("fire_small", {pos=pos, gain = 1.0, max_hear_distance = 5,})
		end
		return true
	end
})