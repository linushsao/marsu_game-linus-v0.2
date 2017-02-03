

function pollution_freeze(ob,rnd)
	if not ob then return false end
	if ob:get_luaentity() and ob:get_luaentity().name=="pollution:axov_ice" then return false end
--1=player 2=enitity
	local object=0
	local kill=0
	local is_axov=0
	if rnd then kill=1 end
		if ob:is_player()==true then
			object=1
		else
			object=2
		end
	if rnd then 
		rnd=1
	else
		rnd=math.random(5)
	end

	local pos=ob:getpos()

	-- ================= if an item/mob
	if object==2 then
	if ob:get_luaentity().name=="pollution:icicle" then return true end


	if ob:get_hp()<=4 or kill==1 then
		minetest.add_entity(pos, "pollution:icicle")
		ob:remove()
	end
		ob:set_hp(ob:get_hp()-2)
		if string.find(ob:get_luaentity().name,":axo",10)==nil then
			return true
		end
		kill=1
		object=1
		is_axov=1
	end

	-- ================= if a player

	if kill==0 and object==1 then
	if minetest.get_node(pos).name=="pollution:icenbox" then return false end
	if ob:get_hp()>=10	 then ob:set_hp(ob:get_hp()-2) end
	if ob:get_hp()<=10 then kill=1 else return true end
	end

	if kill==1 and object==1 then
		if minetest.get_node(pos).name=="pollution:icenbox" then return false end
		pos.y=pos.y-0.5
		local npos={x=pollution_round(pos.x),y=pollution_round(pos.y),z=pollution_round(pos.z)}
		npos.y=npos.y+0.5
		if is_axov==1 then npos.y=npos.y-1 end
		if minetest.get_node(npos).name~="air" then return false end
		minetest.set_node(npos, {name = "pollution:icenbox"})
		minetest.after(0.5, function(npos, ob) 
			ob:set_hp(ob:get_hp()-2)
			ob:moveto(npos,false)
		end, npos, ob)
	end

end


minetest.register_tool("pollution:nrifle", {
	description = "Nitrogen rifle",
	range = 7,
	inventory_image = "pollution_nrifle.png",
		on_use = function(itemstack, user, pointed_thing)
		pollution_freeze(pointed_thing.ref)
		pollution_sound_shoot(user:getpos(),1)
		pollution_setsicknes(pointed_thing.ref)
		return itemstack
		end,
})



minetest.register_node("pollution:nbarrel", {
	description = "Nitrogen barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	drop = "pollution:nbarrel",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel2.png"},
	groups = {barrel=2,cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
	pollution_sound_punsh(pos)
		if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then
			pollution_sound_pff(pos)
			minetest.set_node(pos, {name = "pollution:nbarrel_cracked"})
		end
	end,
})

minetest.register_node("pollution:nbarrel_cracked", {
	description = "Cracked nitrogen barrel",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	drop = 'pollution:nbarrel',
	wield_scale = {x=0.5, y=0.5, z=0.5},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.9, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.9, 0.4},}},
	tiles = {"pollution_barrel2.png"},
	groups = {barrel=2,cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	on_punch = function(pos, node, puncher, pointed_thing)
	pollution_sound_punsh(pos)
	pollution_freeze(puncher)
	pollution_setsicknes(puncher)
	if math.random (5)==1 and minetest.is_protected(pos,puncher:get_player_name())==false then pollution_spawn_kmob(pos) end
	end,
})





minetest.register_node("pollution:n_gass", {
	description = "Nitrogen gass",
	inventory_image = "bubble.png",
	tiles = {"pollution_blue.png"},
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "airlike",
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "glasslike",
	is_ground_content = false,
})

minetest.register_node("pollution:vaccum", {
	description = "Vaccum",
	inventory_image = "bubble.png",
	tiles = {"pollution_gass.png"},
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drawtype = "plantlike",
	liquidtype = "airlike",
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.register_node("pollution:ice", {
	description = "Nitrogen ice",
	tiles = {"default_ice.png^pollution_blue2.png"},
	drop = "pollution:ice",
	damage_per_second = 1,
	groups = {cracky = 3, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	alpha = 50,
	drawtype = "glasslike",
	is_ground_content = false,

})

minetest.register_node("pollution:frozen_tree", {
	description = "Frozen tree",
	tiles = {"default_tree_top.png^pollution_blue2.png","default_tree_top.png^pollution_blue2.png","default_tree.png^pollution_blue2.png"},
	groups = {cracky = 3, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
})

minetest.register_node("pollution:frozen_leaves", {
	description = "Frozen leaves",
	tiles = {"default_leaves.png^pollution_blue2.png"},
	groups = {cracky = 3, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	drawtype = "glasslike",
	is_ground_content = false,
})

minetest.register_node("pollution:frozen_plant", {
	description = "Frozen plant",
	tiles = {"default_dry_shrub.png^pollution_blue2.png"},
	groups = {snappy = 3, puts_out_fire = 1, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	drawtype = "plantlike",
	is_ground_content = false,
	damage_per_second = 3,
})

minetest.register_abm({
	nodenames = {"pollution:ice"}, --,"pollution:icenbox"
	neighbors = {"pollution:ice"},
	interval = 5,
	chance = 5,
	action = function(pos)
		local name=minetest.get_node(pos).name
		if name=="pollution:icenbox" then
			for i, ob in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			return true
			end
		minetest.sound_play("default_break_glass", {pos=pos, gain = 1.0, max_hear_distance = 10,})
		minetest.set_node(pos, {name = "air"})
			return true
		end
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			if ob:is_player() then
				pollution_freeze(ob)
				pollution_setsicknes(ob)
			elseif ob:get_luaentity().name~="pollution:icicle" and ob:get_luaentity().name~="pollution:frshrub" then
				pollution_freeze(ob)
				pollution_setsicknes(ob)
			end
		end
		return true
	end,
})

minetest.register_abm({
	nodenames = {"pollution:water_source","pollution:water_flowing", "group:liquid","default:dirt_with_grass","default:dirt","pollution:dirt","group:tree","group:leaves","group:flora","group:snappy","pollution:frozen_plant"},
	neighbors = {"pollution:ice","pollution:nbarrel_cracked","pollution:frozen_tree"},
	interval = 5,
	chance = 5,
	action = function(pos,node)
		local name=minetest.get_node(pos).name
		if minetest.get_node_group(name, "liquid")>0  or name=="pollution:water_source" or name=="pollution:water_flowing" then
			local nname=minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z}).name
			if nname=="air" or nname=="pollution:gass" or nname=="flowers:waterlily" then
				local np=minetest.find_node_near(pos, 1,{"pollution:ice","pollution:nbarrel_cracked"})
				local n
				if np~=nil then n=minetest.get_node(np) end
				if n and n.name=="pollution:ice" then
					local r=minetest.get_meta(np):get_int("prl")
					if r>0 and r<pollution_waste_nitrogen_radius then
						minetest.set_node(pos, {name = "pollution:ice"})
						minetest.get_meta(pos):set_int("prl",r+1)
					end
				elseif n and n.name=="pollution:nbarrel_cracked" then
					minetest.set_node(pos, {name = "pollution:ice"})
					minetest.get_meta(pos):set_int("prl",1)
				end
			end
		end
		if name=="default:dirt_with_grass" then
			minetest.set_node(pos, {name = "default:dirt_with_snow"})
		end

		if name=="default:dirt" or name=="pollution:dirt" then
			minetest.set_node(pos, {name = "default:snowblock"})
		end
		if minetest.get_node_group(name, "tree")==1 then
			minetest.set_node(pos, {name = "pollution:frozen_tree"})
		end
		if minetest.get_node_group(name, "leaves")==1 then
			minetest.set_node(pos, {name = "pollution:frozen_leaves"})
			return
		end
		if name=="pollution:nuclearheatgass" then
			minetest.set_node(pos, {name = "default:water_source"})
			return
		end

		if name=="pollution:frozen_plant" then
			for i=1,100,1 do
				if minetest.get_node_group(minetest.get_node(pos).name, "snappy")>0 then
					minetest.add_entity(pos, "pollution:frshrub")
					minetest.set_node(pos, {name = "air"})
				pos.y=pos.y+1
				else
					return true
				end
				

			end
		end
		if minetest.get_node_group(name, "flora")==1 or minetest.get_node_group(name, "snappy")>=1 then
			minetest.set_node(pos, {name = "pollution:frozen_plant"})
		end






	end,
})

minetest.register_node("pollution:icenbox", {
	description = "Nitrogen ice box",
	wield_scale = {x=2, y=2, z=2},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, -0.5, 0.5, 1.5, -0.4375},
			{-0.5, -0.5, 0.4375, 0.5, 1.5, 0.5},
			{0.4375, -0.5, -0.4375, 0.5, 1.5, 0.4375},
			{-0.5, -0.5, -0.4375, -0.4375, 1.5, 0.4375},
			{-0.5, 1.5, -0.5, 0.5, 1.4375, 0.5},
		}
	},
	drop="default:ice",
	tiles = {"default_ice.png^pollution_blue2.png"},
	groups = {cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	alpha = 30,
	is_ground_content = false,
	drowning = 1,
	damage_per_second = 2,
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(20)
	end,
	on_timer = function (pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			pollution_setsicknes(ob)
			return true
		end
		minetest.sound_play("default_break_glass", {pos=pos, gain = 1.0, max_hear_distance = 10,})
		minetest.set_node(pos, {name = "air"})
		return false
	end,
})

minetest.register_entity("pollution:icicle",{
	gbpinvisiabler=1,
	hp_max = 1,
	physical = true,
	weight = 5,
	collisionbox = {-0.3,-0.3,-0.3, 0.3,0.3,0.3},
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"default_obsidian_shard.png^pollution_blue2.png^pollution_blue2.png"}, 
	colors = {}, 
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
			minetest.sound_play("default_break_glass", {pos=self.object:getpos(), gain = 1.0, max_hear_distance = 10,})
			self.object:remove()
	end,
	is_falling=0,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<1 then return true end
		self.timer=0
		self.timer2=self.timer2+dtime
		if self.timer2>0.2 then
			minetest.sound_play("default_break_glass", {pos=self.object:getpos(), gain = 1.0, max_hear_distance = 10,})
			self.object:remove()
			return true
		end

		local node=minetest.registered_nodes[minetest.get_node(self.object:getpos()).name]
		if node and node.walkable==false and self.is_falling==0 then
			self.object:setacceleration({x = 0, y = -10, z = 0})
			self.physical_state = true
			self.is_falling=1
		end

		if node and node.walkable==true and self.is_falling==1 then
			self.object:setacceleration({x = 0, y = 0, z = 0})
			self.physical_state = false
			self.is_falling=0
		end

	end,
	timer = 0,
	timer2 = 0,

})

minetest.register_entity("pollution:frshrub",{
	gbpinvisiabler=1,
	hp_max = 1,
	physical = true,
	weight = 5,
	collisionbox = {-0.3,-0.3,-0.3, 0.3,0.3,0.3},
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"default_dry_shrub.png^pollution_blue2.png"}, 
	colors = {}, 
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		minetest.sound_play("default_break_glass", {pos=self.object:getpos(), gain = 1.0, max_hear_distance = 10,})
		self.object:remove()
	end,
	is_falling=0,
	on_step = function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<1 then return true end
		self.timer=0
		self.timer2=self.timer2+dtime
		if self.timer2 > 2 then
			minetest.sound_play("default_break_glass", {pos=self.object:getpos(), gain = 1.0, max_hear_distance = 10,})
			self.object:remove()
			return true
		end
		local node=minetest.registered_nodes[minetest.get_node(self.object:getpos()).name]
		if node and node.walkable==false and self.is_falling==0 then
			self.object:setvelocity({x = 0, y = 0, z = 0})
			self.object:setacceleration({x = 0, y = -10, z = 0})
			self.physical_state = true
			self.is_falling=1

		end

	end,
	timer = 0,
	timer2 = 0,

})