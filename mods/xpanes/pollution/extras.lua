minetest.register_craft({
	output = "pollution:chainfence 2",
	recipe = {{"", "default:steel_ingot", ""},
		{"default:steel_ingot","","default:steel_ingot"},
		{"", "default:steel_ingot",""}}})
minetest.register_craft({
	output = "pollution:chainfence2",
	recipe = {{"pollution:chainfence"},
		{"pollution:chainfence"},}})
minetest.register_craft({
	output = "pollution:chainfence 2",
	recipe = {{"pollution:chainfence2"}}})

minetest.register_craft({
	output = "pollution:clight 3",
	recipe = {{"default:glass","default:glass","default:glass"},
		{"","default:mese_crystal_fragment",""}}})
minetest.register_craft({
	output = "pollution:sign1",
	recipe = {{"dye:orange","default:coal_lump","dye:orange"},
		{"dye:orange","default:coal_lump","dye:orange"},
		{"default:coal_lump","dye:orange","default:coal_lump"}}})
minetest.register_craft({
	output = "pollution:sign2",
	recipe = {{"default:coal_lump","default:coal_lump","default:coal_lump"},
		{"dye:orange","default:coal_lump","dye:orange"},
		{"dye:orange","default:coal_lump","dye:orange"}}})

minetest.register_craft({output = "pollution:adigg",recipe = {{"pollution:adigg","default:gold_ingot",""}}})
minetest.register_craft({output = "pollution:adigg",recipe = {{"pollution:adigg","default:bronze_ingot",""}}})
minetest.register_craft({output = "pollution:adigg",recipe = {{"pollution:adigg","default:copper_ingot",""}}})
minetest.register_craft({output = "pollution:adigg",recipe = {{"pollution:adigg","default:steel_ingot",""}}})

minetest.register_craft({
	output = "pollution:adigg",
	recipe = {{"default:steel_ingot","default:steelblock","default:steel_ingot"},
		{"","default:steel_ingot",""},
		}})



minetest.register_node("pollution:sign1", {
	description = "Warning Sign 1",
	tiles = {"pollution_log3.png"},
	inventory_image = "pollution_log3.png",
	drawtype = "nodebox",
	groups = {snappy = 3, not_in_creative_inventory=0},
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
	paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.5,-0.5,0.45,0.5,0.5,0.5}},
})

minetest.register_node("pollution:sign2", {
	description = "Warning Sign 2",
	tiles = {"pollution_log4.png"},
	inventory_image = "pollution_log4.png",
	drawtype = "nodebox",
	groups = {snappy = 3, not_in_creative_inventory=0},
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
	paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.5,-0.5,0.45,0.5,0.5,0.5}},
})



minetest.register_node("pollution:chainfence", {
	description = "Chain fence",
	tiles = {"pollution_chainfence.png"},
	drawtype = "nodebox",
	groups = {cracky=2, not_in_creative_inventory=0,level=2},
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
	paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.5,-0.5,0.45,0.5,0.5,0.5}},
})

minetest.register_node("pollution:chainfence2", {
	description = "Chain double fence",
	tiles = {"pollution_chainfence.png"},
	drawtype = "nodebox",
	groups = {cracky = 2, not_in_creative_inventory=0,level=2},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
	paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
	type="fixed",
	fixed={-0.5,-0.5,0.45,0.5,1.5,0.5}},
})

minetest.register_node("pollution:clight", {
	description = "Ceiling light",
	tiles = {"default_cloud.png"},
	drawtype = "nodebox",
	groups = {snappy = 3, not_in_creative_inventory=0},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",fixed={-0.2,0.4,-0.4,0.2,0.6,0.4}},
	light_source=14,
	on_punch = function(pos, node, puncher, pointed_thing)
		if minetest.is_protected(pos,puncher:get_player_name())==false then
			minetest.sound_play("default_break_glass", {pos=pos, gain = 1.0, max_hear_distance = 5,})
			minetest.set_node(pos, {name = "pollution:clight2"})
		end
	end,
})

minetest.register_node("pollution:clight2", {
	description = "Ceiling light damaged (on)",
	tiles = {"default_cloud.png"},
	drawtype = "nodebox",
	groups = {snappy = 3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	node_box = {type="fixed",fixed={-0.2,0.4,-0.4,0.2,0.6,0.4}},
	light_source=9,
	drop="pollution:clight",
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(1)
	end,
	on_timer = function (pos, elapsed)
		if math.random(3)==1 then
			minetest.set_node(pos, {name = "pollution:clight3"})
		return false
		end
	return true
	end,
})

minetest.register_node("pollution:clight3", {
	description = "Ceiling light damaged (off)",
	tiles = {"default_cloud.png"},
	drawtype = "nodebox",
	groups = {snappy = 3, not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	node_box = {type="fixed",fixed={-0.2,0.4,-0.4,0.2,0.6,0.4}},
	drop="pollution:clight",
	on_construct = function(pos)
		minetest.env:get_node_timer(pos):start(1)
	end,
	on_timer = function (pos, elapsed)
		if math.random(3)==1 then
			minetest.set_node(pos, {name = "pollution:clight2"})
		return false
		end
	return true
	end,
})

pollution_flashhand_power={}

minetest.register_tool("pollution:crifle", {
	description = "Crystal rifle",
	range = 5,
	inventory_image = "pollution_crifle.png",
		on_use = function(itemstack, user, pointed_thing)
			local ob={}
			if pointed_thing.type=="object" then
				ob=pointed_thing.ref
			else
				return itemstack
			end
			if ob:get_luaentity() and ob:get_luaentity().flashhand_power then
			ob:get_luaentity().target:set_detach()
			if ob:get_luaentity().target:get_luaentity() and ob:get_luaentity().target:get_luaentity().itemstring then
				ob:get_luaentity().target:setvelocity({x=0, y=-2, z=0})
				ob:get_luaentity().target:setacceleration({x=0, y=-8, z=0})
			end
			return  itemstack
			end
			if not ob:get_attach() then
				pollution_flashhand_power.user=user
				pollution_flashhand_power.target=ob
				local m=minetest.env:add_entity(ob:getpos(), "pollution:flashhand_power")
				ob:set_attach(m, "", {x=0,y=0,z=0}, {x=0,y=0,z=0})
				return  itemstack
			end
			return itemstack
		end,
})
function pollution_lightnings(user,ob,type)
if type then
minetest.add_particlespawner({
	amount = 50,
	time =0.2,
	minpos = ob:getpos(),
	maxpos = ob:getpos(),
	minvel = {x=0, y=0, z=0},
	maxvel = {x=math.random(-25,25), y=math.random(-25,25), z=math.random(-25,25)},
	minacc = {x=0, y=0, z=0},
	maxacc = {x=4, y=4, z=4},
	minexptime = 0.02,
	maxexptime = math.random(0.05,0.2),
	minsize = 1,
	maxsize = 10,
	texture = "pollution_lightning.png",
})
else
minetest.add_particlespawner({
	amount = 3,
	time =0.2,
	minpos = user:getpos(),
	maxpos = ob:getpos(),
	minvel = {x=0, y=0, z=0},
	maxvel = {x=0, y=0, z=0},
	minacc = {x=0, y=0, z=0},
	maxacc = {x=0, y=0, z=0},
	minexptime = 0.02,
	maxexptime = math.random(0.05,0.2),
	minsize = 0.5,
	maxsize = 3,
	texture = "pollution_lightning.png",
})
end
end


minetest.register_entity("pollution:flashhand_power",{
	hp_max = 100,
	physical = false,
	weight = 0,
	collisionbox = {-0.2,-0.2,-0.2, 0.2,0.2,0.2},
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"pollution_lila2.png"},
	spritediv = {x=1, y=1},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
	time=0.1,
	flashhand_power=1,
	chocking=0,
on_activate=function(self, staticdata)
		if pollution_flashhand_power.user then
			self.user=pollution_flashhand_power.user
			self.target=pollution_flashhand_power.target
			pollution_flashhand_power={}
		else
			self.object:remove()
		end
	end,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		if self.target and self.target:get_attach() then
			self.target:set_detach()
			self.target:set_hp(0)
			self.target:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
		end
		if puncher:get_luaentity() and puncher:get_luaentity().name=="aclean:cleaner" then -- (not self.target:get_attach())
			self.object:remove()
			return self
		end
end,
on_rightclick=function(self, clicker)
	self.chocking=1
	self.sound=minetest.sound_play("pollution_lightning4", {pos=self.target:getpos(), gain = 1.0, max_hear_distance = 9,})
	self.time=0.05
		end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<self.time then return self end
		self.timer=0
		if self.target==nil or (not self.target:get_attach()) then
			self.object:set_hp(0)
			self.object:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
			if self.sound then minetest.sound_stop(self.sound) end
		end
		pollution_lightnings(self.user,self.target)
		if self.chocking>0 then
			self.chocking=self.chocking-0.11
			pollution_lightnings(self.user,self.target,1)
			self.target:set_hp(self.target:get_hp()-1)
			if self.target:get_hp()<=0 then self.target:set_detach() end
			self.target:punch(self.user, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
		end
		if self.chocking<0 then
			if self.sound then
				minetest.sound_stop(self.sound)
				self.sound=nil
			end
			if self.target:get_hp()>10 then
				self.chocking=1
				self.sound=minetest.sound_play("pollution_lightning4", {pos=self.target:getpos(), gain = 1.0, max_hear_distance = 9,})
			else
				self.time=0.1
				self.chocking=0
			end
		end
	local d=4
	local pos = self.user:getpos()
	if pos==nil then return self end
	pos.y=pos.y+1.6
	local dir = self.user:get_look_dir()
	local npos={x=pos.x+(dir.x*d), y=pos.y+(dir.y*d), z=pos.z+(dir.z*d)}
	if minetest.registered_nodes[minetest.get_node(npos).name].walkable then
	return self
	end
	self.object:moveto(npos)
		return self
	end,
})


local function pollution_setpchest(pos,user)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", user:get_player_name())
		meta:set_int("state", 0)
		meta:get_inventory():set_size("main", 32)
		meta:get_inventory():set_size("trans", 1)
		meta:set_string("formspec",
		"size[8,8]" ..
		"list[context;main;0,0;8,4;]" ..
		"list[context;trans;0,0;0,0;]" ..
		"list[current_player;main;0,4.3;8,4;]" ..
		"listring[current_player;main]" ..
		"listring[current_name;main]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		default.get_hotbar_bg(0,4.3))
		meta:set_string("infotext", "PChest by: " .. user:get_player_name())
end



minetest.register_tool("pollution:pchest", {
	description = "Portable locked chest",
	inventory_image = "default_chest_lock.png^[colorize:#83502a55",
		on_place = function(itemstack, user, pointed_thing)
			if minetest.is_protected(pointed_thing.above,user:get_player_name()) or minetest.registered_nodes[minetest.get_node(pointed_thing.above).name].walkable then
				return itemstack
			end

			local item=itemstack:to_table()
			local meta=minetest.deserialize(item["metadata"])
			minetest.set_node(pointed_thing.above, {name = "pollution:pchest_node"})
			pollution_setpchest(pointed_thing.above,user)
			minetest.sound_play("default_place_node_hard", {pos=pointed_thing.above, gain = 1.0, max_hear_distance = 5,})
			if meta==nil then
				itemstack:take_item()
				return itemstack
			end

			local s=meta.stuff
			local its=meta.stuff.split(meta.stuff,",",",")
			local nmeta=minetest.get_meta(pointed_thing.above)
			for i,it in pairs(its) do
				if its~="" then
					nmeta:get_inventory():set_stack("main",i, ItemStack(it))
				end
			end
			itemstack:take_item()
			return itemstack:take_item()
		end,
})




minetest.register_node("pollution:pchest_node", {
	description = "Portable locked chest",
	tiles = {"default_chest_top.png^[colorize:#83502a55", "default_chest_top.png^[colorize:#83502a55", "default_chest_side.png^[colorize:#83502a55","default_chest_side.png^[colorize:#83502a55", "default_chest_side.png^[colorize:#83502a55", "default_chest_lock.png^[colorize:#83502a55"},
	groups = {dig_immediate = 2, not_in_creative_inventory=1},
	drop="pollution:pchest",
allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local owner = minetest.get_meta(pos):get_string("owner")
		if (stack:get_name()~="pollution:pchest") and (owner==player:get_player_name() or owner=="") then
			if minetest.deserialize(stack:get_metadata())~=nil then
				minetest.chat_send_player(player:get_player_name(), "Warning: the meta (information that is saved in the item)")
				minetest.chat_send_player(player:get_player_name(), "will be lost when pick up the chest")
			end
			return stack:get_count()
		end
		return 0
	end,
allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local owner = minetest.get_meta(pos):get_string("owner")
		if owner==player:get_player_name() or owner=="" then
			return stack:get_count()
		end
		return 0
	end,
allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local owner = minetest.get_meta(pos):get_string("owner")
		if owner==player:get_player_name() or owner=="" then
			return count
		end
		return 0
	end,
can_dig = function(pos, player)
		local owner = minetest.get_meta(pos):get_string("owner")
		return (owner=="" and minetest.get_meta(pos):get_inventory():is_empty("main"))
	end,
on_punch = function(pos, node, player, pointed_thing)
		if minetest.is_protected(pos,player:get_player_name()) then
			return false
		end
		local meta=minetest.get_meta(pos)
		if meta:get_string("owner")==player:get_player_name() then
			local inv=meta:get_inventory()
			local items=""
			for i=1,32,1 do
				if inv:get_stack("main",i):get_name()~="" then
					items=items .. inv:get_stack("main",i):get_name() .." " .. inv:get_stack("main",i):get_count() .. " " .. inv:get_stack("main",i):get_wear() .."," 
				else
					items=items .. ","
				end
			end
			inv:add_item("trans", ItemStack("pollution:pchest"))
			local item=inv:get_stack("trans",1):to_table()
			local tmeta={stuff=items}
			item.metadata=minetest.serialize(tmeta)
			player:get_inventory():add_item("main", ItemStack(item))
			minetest.set_node(pos, {name = "air"})
			minetest.sound_play("default_dig_dig_immediate", {pos=pos, gain = 1.0, max_hear_distance = 5,})
		end
	end,
})

local pollution_arrow=""

minetest.register_tool("pollution:adigg", {
	description = "Arrow digger",
	inventory_image = "pollution_arrowrifle.png",
		on_use = function(itemstack, user, pointed_thing)
			local wear=itemstack:get_wear()
			if wear==65430 then return end
			wear=wear+(65534/32)
			if wear>65430 then wear=65430 end
			itemstack:set_wear(wear)
			local pos=user:getpos()
			pos.y=pos.y+1.6
			pollution_arrow=user
			local m=minetest.env:add_entity(pos, "pollution:arrow")
			local dir = user:get_look_dir()
			m:setvelocity({x=dir.x*15, y=dir.y*15, z=dir.z*15})
			m:setacceleration({x=0, y=-1, z=0})
			m:setyaw(user:get_look_yaw()+math.pi)
			minetest.sound_play("default_dig_dig_immediate", {pos=pos, gain = 1.0, max_hear_distance = 5})
			return itemstack
		end,
})

local pollution_a_time=tonumber(minetest.setting_get("item_entity_ttl"))
if pollution_a_time=="" or pollution_a_time==nil then
	pollution_a_time=880
else
	pollution_a_time=pollution_a_time-20
end



minetest.register_entity("pollution:arrow",{
	hp_max = 1,
	physical = false,
	weight = 5,
	collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "sprite",
	visual_size = {x=0.05, y=0.05},
	textures = {"default_steel_block.png"},
	--spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
	bullet=1,
	pvp=minetest.setting_getbool("enable_pvp"),
on_activate=function(self, staticdata)
		if pollution_arrow=="" then
			self.object:remove()
			return self
		end
		self.user=pollution_arrow
		pollution_arrow=""
	end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		local pos=self.object:getpos()
		if minetest.registered_nodes[minetest.get_node(pos).name].walkable then
			local def=minetest.registered_nodes[minetest.get_node(pos).name]
			local meta=minetest.get_meta(pos)

			if minetest.is_protected(pos,"") or def==nil or def.drop=="" or def.unbreakable or (meta and meta:get_string("infotext")~="")  then
				self.object:remove()
				minetest.sound_play("default_dig_dig_immediate", {pos=pos, gain = 1.0, max_hear_distance = 5})
				return self
			end
			local drop=def.drop
			if (not def.drop) or type(def.drop)~="string" then
				drop=minetest.get_node(pos).name
			end
			local d=minetest.add_item(pos, drop)
			d:setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
			d:get_luaentity().age=pollution_a_time
			minetest.set_node(pos,{name="air"})
			minetest.sound_play("default_dig_dig_immediate", {pos=pos, gain = 1.0, max_hear_distance = 5})
			self.object:remove()
			return self
		end
		if self.user==nil or self.timer>2 then
			self.object:remove()
			return
		end
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 2)) do
			if (self.pvp and ob:is_player() and ob:get_player_name()~=self.user:get_player_name()) or (ob:get_luaentity() and ob:get_luaentity().bullet==nil and ob:get_luaentity().name~="__builtin:item" ) then
				ob:set_hp(ob:get_hp()-8)
				ob:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				self.object:remove()
				minetest.sound_play("default_dig_dig_immediate", {pos=pos, gain = 1.0, max_hear_distance = 5})
				return
			end
		end
	end,
})