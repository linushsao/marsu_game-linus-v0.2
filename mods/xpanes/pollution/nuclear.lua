pollution.nuclear={}


minetest.register_craft({
	output = "pollution:brick",
	recipe = {{"default:stonebrick","default:stonebrick"},
		}})

minetest.register_craft({
	output = "pollution:nuclearbarrel",
	recipe = {{"pollution:cbarrel","pollution:crystal_small","pollution:ybarrel"},
		{"default:bronze_ingot","pollution:sign1","default:bronze_ingot"},
		{"default:bronze_ingot","default:bronze_ingot","default:bronze_ingot"},
		}})

minetest.register_craft({
	output = "pollution:wiretube 2",
	recipe = {{"default:bronze_ingot","default:bronze_ingot","default:bronze_ingot"},
		{"default:bronze_ingot","default:bronze_ingot","default:bronze_ingot"},	
		}})

minetest.register_craft({
	output = "pollution:ngen",
	recipe = {{"default:bronze_ingot","default:bronze_ingot","default:bronze_ingot"},
		{"default:bronze_ingot","pollution:wiretube","default:bronze_ingot"},
		{"default:bronze_ingot","default:bronze_ingot","default:bronze_ingot"},	
		}})

minetest.register_craft({
	output = "pollution:nukerifle",
	recipe = {
		{"pollution:wiretube", "pollution:nuclearbarrel", "pollution:magnesium_ingot"},
		{"","default:steel_ingot","default:steel_ingot"},
	}
})


minetest.register_tool("pollution:nukers", {
	description = "Ruclear reactor spawner",
	range = 15,
	inventory_image = "pollution_log3.png",
		on_place = function(itemstack, user, pointed_thing)
			if pointed_thing.type~="node" then return itemstack end
			local pos=pointed_thing.above
			if minetest.is_protected(pos,user:get_player_name()) then
				minetest.chat_send_player(user:get_player_name(),"This place is protected")
				return itemstack
			end
			local np=minetest.find_node_near({x=pos.x,y=pos.y+19,z=pos.z},20,{"group:wood","group:cracky"})
			if np~=nil and minetest.get_node_group(minetest.get_node(np).name, "stone")==0 then
				minetest.chat_send_player(user:get_player_name(),"You need a more clean area, found: " .. minetest.get_node(np).name)
				return itemstack
			end
			for i=0,20,1 do
				if minetest.get_node({x=pos.x,y=pos.y+i,z=pos.z}).name~="air" then
					minetest.chat_send_player(user:get_player_name(),"You need a more clean area, found: " .. minetest.get_node({x=pos.x,y=pos.y+i,z=pos.z}).name)
					return itemstack
				end
			end
			itemstack:take_item()
			local tree=minetest.get_modpath("pollution").."/schems/pollution_ruclearreactorspawner.mts"
			minetest.place_schematic({x=pos.x-10,y=pos.y-4,z=pos.z-6}, tree, "random", {}, true)


			return itemstack
		end
})

minetest.register_tool("pollution:nukerifle", {
	description = "Nuke rifle",
	range = 15,
	inventory_image = "pollution_trifle.png^[colorize:#aaff00aa",
		on_use = function(itemstack, user, pointed_thing)
			if itemstack:get_wear()>0 then
				minetest.chat_send_player(user:get_player_name(), "the power is low, rightclick (place) to reload")
				return
			end
			itemstack:set_wear(65534)
			local pos={}
			local pvp=minetest.setting_getbool("enable_pvp")
			if pointed_thing.type=="node" then
				pos=pointed_thing.above
			elseif pointed_thing.type=="object" then
				if pointed_thing.ref:is_player() and pvp==false then return itemstack end
				pos=pointed_thing.ref:getpos()
				pointed_thing.ref:set_hp(pointed_thing.ref:get_hp()-20)
				pointed_thing.ref:punch(user, {full_punch_interval=1,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
			elseif  pointed_thing.type=="nothing" then
				pos=user:getpos()
				local dir = user:get_look_dir()
				pos={x=pos.x+(dir.x*15),y=pos.y+(dir.y*15),z=pos.z+(dir.z*15)}
			else
				return itemstack
			end

			for i, ob in pairs(minetest.get_objects_inside_radius(pos, 10)) do
				if not (ob:is_player() and (ob:get_player_name()==user:get_player_name() or pvp==false)) then
					pollution.flashdamage(3,ob,true)
					if minetest.is_protected(ob:getpos(),user:get_player_name())==false then minetest.set_node(ob:getpos(), {name ="pollution:n_fire"}) end
				end
			end

			for i=1,25,1 do
				local np=minetest.find_node_near(pos,3,{"air","group:water","group:soil","group:sand","group:flowers","group:oddly_breakable_by_hand","group:stone"})
				if np~=nil and minetest.is_protected(np,"")==false then
					minetest.set_node(np, {name ="pollution:n_fire"})
				else
					return itemstack
				end
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



pollution.posToString=function(p)
if p==nil then return "" end
return "x"..p.x.."y"..p.y.."z"..p.z
end

pollution.getwired=function(p,name)
	if p==nil then return {} end
	local cc={{x=1,y=0,z=0},{x=0,y=1,z=0},{x=0,y=0,z=1},{x=-1,y=0,z=0},{x=0,y=-1,z=0},{x=0,y=0,z=-1}}
	local n={}
	for i,c in pairs(cc) do
		local pos={x=p.x+c.x,y=p.y+c.y,z=p.z+c.z}
		if minetest.get_node(pos).name==name then
			table.insert(n,pos)
		end
	end
	return n
end


pollution.flashdamage=function(level,ob,user)
	if ob==nil or (user==nil and ob:get_luaentity() and ob:get_luaentity().nuke) then return end
	local dmg=math.random(1,20)
	local hp=ob:get_hp()
	for i=0,dmg,1 do
		hp=hp-level
		local time=math.random(10)*0.1
		if ob:get_hp()<=0 then return false end
		minetest.after((i*0.4)+time, function(ob)
			if ob==nil or ob:get_hp()<=0 then return false end
			ob:set_hp(ob:get_hp()-level)
			ob:punch(ob, {full_punch_interval=1,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
		end, ob)
		if hp<=0 then return false end
	end
end

minetest.register_node("pollution:brick", {
	description = "Hard brick",
	tiles = {"default_stone_brick.png^[colorize:#FFFFFFaa"},
	is_ground_content = false,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("pollution:wiretube", {
	description = "Wire tube",
	tiles = {"default_copper_block.png^[colorize:#ffff0044"},
	is_ground_content = false,
	groups = {cracky = 1,stone = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("pollution:wiretube_on", {
	description = "Wire tube",
	drop="pollution:wiretube",
	tiles = {"default_copper_block.png^[colorize:#ffff0022"},
	is_ground_content = false,
	groups = {cracky = 1,stone = 1,not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	light_source = 8,
	sunlight_propagates = true,
on_timer = function (pos, elapsed)
		local meta=minetest.get_meta(pos)
		local re=false

		if meta:get_int("power")==0 then
			for i,np in pairs(pollution.getwired(pos,"pollution:nuclearfuelwater_source")) do
				meta:set_int("power",1)
				re=true
				break
			end
		else
			for i,np in pairs(pollution.getwired(pos,"pollution:ngen")) do
				minetest.get_meta(np):set_int("power",1)
				minetest.env:get_node_timer(np):start(1)
				minetest.set_node(pos,{name="pollution:wiretube"})
				re=true
			end
				if re then return false end
		end

		for i,np in pairs(pollution.getwired(pos,"pollution:wiretube")) do
		if (meta:get_string("last")~=pollution.posToString(np) or re) then
			minetest.set_node(np,{name="pollution:wiretube_on"})
			minetest.get_meta(np):set_string("last",pollution.posToString(pos))
			minetest.get_meta(np):set_int("power",meta:get_int("power"))
			minetest.env:get_node_timer(np):start(1)
		end
		end

		minetest.set_node(pos,{name="pollution:wiretube"})
		return false
end,
})

minetest.register_node("pollution:ngen", {
	description = "Nuclear ore generator",
	tiles = {"default_bronze_block.png^default_rail_crossing.png","default_bronze_block.png^default_ladder_steel.png"},
	is_ground_content = false,
	groups = {cracky = 1,stone = 1},
	sounds = default.node_sound_stone_defaults(),
after_place_node = function(pos, placer, itemstack)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		meta:set_int("toogle", 0)
		inv:set_size("inv", 1)
		meta:set_string("infotext", "Nuclear ore generator (off)")
		meta:set_string("formspec",
		"size[8,9]" ..
		"list[context;inv;3.5,2;1,1;]" ..
		"list[current_player;main;0,5;8,4;]" ..
		"listring[current_player;main]" ..
		"listring[current_name;inv]"
		)
		end,
allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos,player:get_player_name())==false then
			local n=stack:get_name()
			if n=="default:coal_lump" or n=="default:iron_lump" or n=="default:copper_lump" or n=="default:gold_lump" or n=="default:mese_crystal" or n=="default:diamond" then
				minetest.env:get_node_timer(pos):start(1)
				return stack:get_count()
			end
		 end
		return 0
	end,
allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos,player:get_player_name())==false then
			return stack:get_count()
		 end
		return 0
	end,
can_dig = function(pos, player)
		local meta=minetest.get_meta(pos)
		return meta:get_inventory():is_empty("inv")
	end,
on_timer = function (pos, elapsed)
	local meta=minetest.get_meta(pos)
	local power=meta:get_int("power")

	if meta:get_inventory():is_empty("inv") then
		meta:set_string("infotext", "Nuclear ore generator (off)")
	end

	if power==1 then
		meta:set_int("power",0)
		local proc=meta:get_int("proc")+1
		if proc>=5 then
			proc=0
			local up={x=pos.x,y=pos.y+1,z=pos.z}
			if minetest.get_node(up).name=="air" then
				local n=meta:get_inventory():get_stack("inv",1):get_name()
				if n=="default:coal_lump" then 	minetest.set_node(up,{name="default:stone_with_coal"})
				elseif n=="default:iron_lump" then 	minetest.set_node(up,{name="default:stone_with_iron"})
				elseif n=="default:copper_lump" then 	minetest.set_node(up,{name="default:stone_with_copper"})
				elseif n=="default:gold_lump" then	minetest.set_node(up,{name="default:stone_with_gold"})
				elseif n=="default:mese_crystal" then 	minetest.set_node(up,{name="default:stone_with_mese"})
				elseif n=="default:diamond" then 	minetest.set_node(up,{name="default:stone_with_diamond"})
				end
			end

		end
		meta:set_string("infotext", "Nuclear ore generator (" .. (proc*20) .."%)")
		meta:set_int("proc",proc)
		return true
	end

	if power==0 then
		local w=0
		for i,np in pairs(pollution.getwired(pos,"pollution:wiretube")) do
			minetest.set_node(np,{name="pollution:wiretube_on"})
			minetest.get_meta(np):set_string("last",pollution.posToString(pos))
			minetest.env:get_node_timer(np):start(1)
			w=1
		end
		if w==0 then
			meta:set_string("infotext", "Nuclear ore generator Error: put tubwires between here and a uranium fuel Source")
		end
	end
	return false
end,
})

minetest.register_node("pollution:nuclearbarrel", {
	description = "Uranium barrel",
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
	tiles = {"pollution_barrel6.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=0},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	liquids_pointable = true,
on_use = function(itemstack, user, pointed_thing)
	if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.under,user:get_player_name())==false then
		if minetest.registered_nodes[minetest.get_node(pointed_thing.under).name].buildable_to==true then
			local inv = user:get_inventory()
				if inv:room_for_item("main", {name="pollution:nuclearbarrel_empty"}) then
					inv:add_item("main","pollution:nuclearbarrel_empty")
					minetest.set_node(pointed_thing.under,{name="pollution:nuclearfuelwater_source"})
					itemstack:take_item()
					return itemstack
				end
		end
		if minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].buildable_to==true then
			local inv = user:get_inventory()
				if inv:room_for_item("main", {name="pollution:nuclearbarrel_empty"}) then
					inv:add_item("main","pollution:nuclearbarrel_empty")
					minetest.set_node(pointed_thing.above,{name="pollution:nuclearfuelwater_source"})
					itemstack:take_item()
					return itemstack
				end
		end
	end
	return itemstack
end,
})

minetest.register_node("pollution:nuclearbarrel_empty", {
	description = "Uranium barrel (empty)",
	drawtype = "mesh",
	mesh = "pollution_barrel.obj",
	paramtype2 = "facedir",
	wield_scale = {x=1, y=1, z=1},
selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4,  0.8, 0.4}
	},
collision_box = {
		type = "fixed",
		fixed = {{-0.4, -0.5, -0.4, 0.4,  0.8, 0.4},}},
	tiles = {"pollution_yellow.png^[colorize:#ff7e00ff","pollution_yellow.png^[colorize:#ff7e00ff^pollution_log5.png","pollution_yellow.png^[colorize:#ff7e00ff","pollution_yellow.png^[colorize:#ff7e00ff","pollution_black.png","pollution_yellow.png^[colorize:#ff7e00ff^pollution_log2.png"},
	groups = {barrel=1,cracky = 1, level = 2, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	liquids_pointable = true,
on_use = function(itemstack, user, pointed_thing)
	if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.under,user:get_player_name())==false then
		if minetest.get_node(pointed_thing.under).name=="pollution:nuclearfuelwater_source" then
			local inv = user:get_inventory()
				if inv:room_for_item("main", {name="pollution:nuclearbarrel"}) then
					minetest.set_node(pointed_thing.under,{name="air"})
					inv:add_item("main","pollution:nuclearbarrel")
					itemstack:take_item()
					return itemstack
				end
		end
	end
	return itemstack
end,
})


minetest.register_node("pollution:nuclearheatgass", {
	description = "Hot gass",
	tiles = {"pollution_dirt.png"},
	alpha = 180,
	walkable = false,
	pointable = false,
	diggable = false,
	drowning = 1,
	buildable_to = true,
	drawtype = "glasslike",
	liquidtype = "airlike",
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15,
	damage_per_second = 11,
})

minetest.register_node("pollution:nuclearfuelwater_source", {
	description = "Uranium fuel source",
	drawtype = "liquid",
	tiles = {
		{name = "pollution_yellow.png^[colorize:#ffc600ff",
		},
	},
	special_tiles = {
		{
			name = "pollution_yellow.png^[colorize:#ffc600ff",
			backface_culling = false,
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
	liquid_alternative_flowing = "pollution:nuclearfuelwater_flowing",
	liquid_alternative_source = "pollution:nuclearfuelwater_source",
	liquid_viscosity = 0,
	liquid_range = 3,
	damage_per_second = 9,
	post_effect_color = {a = 150, r = 150, g = 50, b = 190},
	groups = {ncw=1, liquid = 3, puts_out_fire = 1,not_in_creative_inventory=0},
})

minetest.register_node("pollution:nuclearfuelwater_flowing", {
	description = "Uranium fuel flowing",
	drawtype = "flowingliquid",
	tiles = {
		{name = "pollution_yellow.png^[colorize:#ffc600ff",
		},
	},
	special_tiles = {
		{
			name = "pollution_yellow.png^[colorize:#ffc600ff",
			backface_culling = false,
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
	liquid_alternative_flowing = "pollution:nuclearfuelwater_flowing",
	liquid_alternative_source = "pollution:nuclearfuelwater_source",
	liquid_viscosity = 2,
	liquid_range = 3,
	damage_per_second = 9,
	post_effect_color = {a = 150, r = 150, g = 50, b = 190},
	groups = {ncw=1, liquid = 3, puts_out_fire = 1,not_in_creative_inventory = 1},
})


minetest.register_node("pollution:ncmdw_source", {
	description = "Uranium meltdown source",
	drawtype = "liquid",
	tiles = {
		{name = "pollution_nukecrystal.png",
			animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 2.0,},
		},
	},
	special_tiles = {
		{
			name = "pollution_nukecrystal.png",
			animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 2.0,},
			backface_culling = false,
		},},
	alpha = 220,
	paramtype = "light",
	light_source = 15,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "pollution:ncmdw_flowing",
	liquid_alternative_source = "pollution:ncmdw_source",
	liquid_viscosity = 0,
	damage_per_second = 9,
	post_effect_color = {a = 150, r = 150, g = 50, b = 190},
	groups = {ncmdw=1, liquid = 3, puts_out_fire = 1,not_in_creative_inventory=0},
})

minetest.register_node("pollution:ncmdw_flowing", {
	description = "Uranium meltdown flowing",
	inventory_image = "pollution_yellow.png",
	drawtype = "flowingliquid",
	tiles = {
		{name = "pollution_nukecrystal.png",
			animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 2.0,},
		},
	},
	special_tiles = {
		{
			name = "pollution_nukecrystal.png",
			animation = {type = "vertical_frames",aspect_w = 16,aspect_h = 16,length = 2.0,},
			backface_culling = false,
		},},
	alpha = 190,
	paramtype = "light",
	light_source = 15,
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "pollution:ncmdw_flowing",
	liquid_alternative_source = "pollution:ncmdw_source",
	liquid_viscosity = 2,
	damage_per_second = 9,
	post_effect_color = {a = 150, r = 150, g = 50, b = 190},
	groups = {ncmdw=1, liquid = 3, puts_out_fire = 1,not_in_creative_inventory = 1},
})


pollution.nuclear.meltdown=function(pos,rad)



end

minetest.register_abm({
	nodenames = {"group:ncw"},
	neighbors = {"pollution:nuclearheatgass","group:ncmdw"},
	interval = 5,
	chance = 5,
	action = function(pos)
		minetest.set_node(pos, {name ="pollution:ncmdw_source"})
	end,
})

minetest.register_abm({
	nodenames = {"pollution:nuclearfuelwater_source"},
	interval = 5,
	chance = 5,
	action = function(pos)

		local np=minetest.find_node_near(pos,3,{"pollution:ice","default:ice"})
		if np~=nil then
			minetest.set_node(np, {name ="default:water_source"})
			return
		end

		np=minetest.find_node_near(pos,3,{"group:water","pollution:ice"})
		if np~=nil then
			minetest.set_node(np, {name ="pollution:nuclearheatgass"})
		else
			minetest.set_node(pos, {name ="pollution:ncmdw_source"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"group:soil","group:sand","group:flammable","group:dig_immediate","group:water","group:flowers","group:oddly_breakable_by_hand","group:stone","group:cracky"},
	neighbors = {"group:ncmdw"},
	interval = 10,
	chance = 4,
	action = function(pos)
		if minetest.is_protected(pos,"")==false then
		minetest.set_node(pos, {name ="pollution:n_fire"})
		end
	end,
})

minetest.register_abm({
	nodenames = {"group:ncmdw"},
	interval = 10,
	chance = 4,
	action = function(pos)
		local dmg=0
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 15)) do
			if ob:get_luaentity() and ob:get_luaentity().name=="pollution:axovy" then dmg=1 end
			if dmg==0 and minetest.get_node(ob:getpos()).name~="pollution:n_fire" and minetest.registered_nodes[minetest.get_node(ob:getpos()).name].walkable==false then
				pollution.flashdamage(2,ob)
				minetest.set_node(ob:getpos(), {name ="pollution:n_fire"})
			end
		end
		local np=minetest.find_node_near(pos,15,{"group:soil","group:sand","group:flammable","group:dig_immediate","group:flowers","group:oddly_breakable_by_hand","group:stone"})
		if np~=nil then
			minetest.set_node(np, {name ="pollution:n_fire"})
		end
	end,
})

minetest.register_node("pollution:n_fire", {
	description = "Meltdown fire",
	inventory_image = "fire_basic_flame.png^[colorize:#aaff00aa",
	drawtype = "firelike",
	tiles = {
		{
			name = "fire_basic_flame_animated.png^[colorize:#aaff00aa",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1
			},
		},
	},
	paramtype = "light",
	light_source = 15,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	damage_per_second = 7,
	groups = {dig_immediate = 2},
	drop="",
	on_construct=function(pos)
		minetest.env:get_node_timer(pos):start(5)
	end,
	on_punch=function(pos, node, puncher, pointed_thing)
		local p=puncher:getpos()
		p={x=p.x,y=p.y+1,z=p.z}
		if minetest.registered_nodes[minetest.get_node(p).name].walkable==false then minetest.set_node(p, {name ="pollution:n_fire"}) end
	end,

	on_timer=function (pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 4)) do
			local p=ob:getpos()
			local dmg=1
			if ob:get_luaentity() and ob:get_luaentity().name=="pollution:axovu" then dmg=0 end
			if minetest.is_protected(p,"")==false and dmg==1 and minetest.get_node(p).name~="pollution:n_fire" and minetest.registered_nodes[minetest.get_node(p).name].walkable==false then
				minetest.set_node(p, {name ="pollution:n_fire"})
			end
			pollution.flashdamage(2,ob)

			if minetest.is_protected(p,"")==false and math.random(10)==1 and ob:get_hp()>0 then
				minetest.after(math.random(1,10), function(ob,p)
					if ob==nil or ob:get_hp()<=0 or ob:getpos()==nil then return false end
					if minetest.registered_nodes[minetest.get_node(ob:getpos()).name].walkable==false then minetest.set_node(ob:getpos(), {name ="pollution:n_fire"}) end
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






minetest.register_node("pollution:nukecrystal", {
	description = "Nuke crystal",
	range = 10,
	drawtype = "mesh",
	mesh = "pollution_crystal.obj",
	visual_scale = 2,
	wield_scale = {x=2, y=2, z=2},
	alpha = 20,
	selection_box = {
		type = "fixed",
		fixed = {-0.1, -0.5, -0.1, 0.1, 0.25, 0.1}
	},
	tiles = {
		{
			name = "pollution_nukecrystal.png",
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
	--walkable = false,
	is_ground_content = false,
	light_source=3,
	groups = {cracky = 2, level = 2,not_in_creative_inventory=0},
	on_use = function(itemstack, user, pointed_thing)
		local pos=user:getpos()
		if pointed_thing.type=="object" then pos=pointed_thing.ref:getpos() end
		if pointed_thing.type=="node" then pos=pointed_thing.above end
		local pvp=minetest.setting_getbool("enable_pvp")
			for i, ob in pairs(minetest.get_objects_inside_radius(pos, 10)) do
				if not (ob:is_player() and (ob:get_player_name()==user:get_player_name() or pvp==false)) then
					pollution.flashdamage(3,ob,true)
				end
			end
		return itemstack
		end,
})