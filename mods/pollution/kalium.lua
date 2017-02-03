pollution_mob_id=0
pollution_tmp_bottle={}

local function pollution_mob_fangs(self,mode)
	if self.object:get_luaentity()==nil then return false end


	if mode==0 and self.atta==1 then
		self.atta=0
		local tex={}
		tex=self.object:get_luaentity().tmptexture
		self.object:set_properties({
			visual = "cube",
			textures = tex,
		})
		return self
	end

	if mode==1 and self.atta==0 then
		self.atta=1
		local tex={}
		for i, t in pairs(self.object:get_luaentity().tmptexture) do
			tex[i]=t
		end
		if tex[6]==nil then self.object:remove() return self end
		tex[6]=tex[6] .. "^pollution_fangs.png"
		self.object:set_properties({
			visual = "cube",
			textures = tex,
		})
		return self
	end


	if mode==2 and self.atta==1 then
		local tex={}
		for i, t in pairs(self.object:get_luaentity().tmptexture) do
			tex[i]=t
		end
		tex[6]=tex[6] .. "^pollution_fangs2.png"
		self.object:set_properties({
			visual = "cube",
			textures = tex,
		})

		minetest.after(0.3, function(self, ob)
		self.atta=0
		pollution_mob_fangs(self,1)
		end, self)
	end

return self
end







local function pollution_mob_barrel_attack(self)
	local pos=self.object:getpos()

	if self.barrel==3 then
		pollution_sound_shoot(pos,1)
		return self
	end

	if self.barrel==1 then
		pollution_setsicknes(self.attackobject)
		pollution_sound_shoot(pos,1)
	end
	if self.barrel==2 then
		pollution_freeze(self.attackobject)
		pollution_sound_shoot(pos,1)
		pollution_setsicknes(self.attackobject)
	end
	return self
end


local function pollution_mob_rndwalk(self)
	if self.attack==1 then return self end
	local pos=self.object:getpos()
	self.movment.x=math.random(3)-2
	self.movment.z=math.random(3)-2
	self.object:setvelocity({x = self.movment.x, y = self.movment.y, z =self.movment.z})
	return self
end

local function pollution_mob_attack(self)
	local pos=self.object:getpos()
	local yaw=self.object:getyaw()
	if yaw ~= yaw then
		self.attack=0
		return true
	end
	local x =math.sin(yaw) * 1
	local z =math.cos(yaw) * -1
	self.movment.x=x
	self.movment.z=z
	self.object:setvelocity({
		x = x*3,
		y = self.object:getvelocity().y,
		z = z*3})

	return self
end

local function pollution_mob_updateyaw(self)
	local folow
	local pos=self.object:getpos()
	if self.attack==0 then folow={x=pos.x+self.movment.x,y=pos.y,z=pos.z+self.movment.z} end
	if self.attack==1 then folow=self.attackobject:getpos() end
	if self.attackobject==nil or folow==nil then
		self.attack=0
		pollution_mob_fangs(self,0)
		return false
	end
	local vec = {x=pos.x-folow.x, y=pos.y-folow.y, z=pos.z-folow.z}
	local yaw = math.atan(vec.z/vec.x)+math.pi/2

	if pos.x > folow.x then yaw = yaw+math.pi end
	self.object:setyaw(yaw)
	if self.attack==1 then pollution_mob_attack(self) end
	return self
end


local pollution_mob=function(self, dtime)
	self.timer=self.timer+dtime
	self.timer2=self.timer2+dtime

	if self.timer2>=0.5 then
		self.timer2=0
-- if attacking
		if self.attack==1 then
			pollution_mob_updateyaw(self)
		end



--jump+falling

--after jump
		if self.movment.y>0 then
			self.movment.y=0
			self.object:setacceleration({x =0, y = 0, z =0})
		end
--fron of a wall
		if self.movment.y==0 then
			local ppos=self.object:getpos()
			local nodes={}
			for i=1,4,1 do --starts front of the object and y: -2 to +2
				nodes[i]=minetest.registered_nodes[minetest.get_node({x=ppos.x+self.movment.x,y=ppos.y+(i-3),z=ppos.z+self.movment.z}).name].walkable
			end
			if (nodes[3]==true and nodes[4]==true) or (nodes[1]==false and nodes[2]==false) then -- walk somewhere else
				if self.attack==0 then pollution_mob_rndwalk(self) end
			end
			if (nodes[3]==true and nodes[4]==false) then -- jump
				self.movment.y=8
				self.movment.x=self.movment.x*2
				self.movment.z=self.movment.z*2
				self.object:setvelocity({x = self.movment.x, y = 1, z =self.movment.z})
				self.object:setacceleration({x =0, y = self.movment.y, z =0})
			end
			if nodes[1]==false and nodes[2]==false and self.attack==1 then -- jump & attack
				local pos=self.object:getpos()
				if minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable==true then
					self.movment.x=self.movment.x*2
					self.movment.z=self.movment.z*2
					self.movment.y=8
					self.object:setvelocity({x = self.movment.x, y = 1, z =self.movment.z})
					self.object:setacceleration({x =0, y = self.movment.y, z =0})
				end

		
			end


		end
--falling
		if self.movment.y<=0 then
			local pos=self.object:getpos()
			local nnode=minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name
			local node=minetest.registered_nodes[nnode]
			if node and node.walkable==false then
				self.movment.y=-10
				self.object:setacceleration({x =0, y = self.movment.y, z =0})
			end
			if node and node.walkable==true and self.movment.y~=0 then
				self.movment.y=0
			end
		end
	end

	if self.timer<2 then return true end
--other
	self.timer=0
	if self.object==nil then return false end

	local pos=self.object:getpos()
	local node=minetest.get_node(pos).name
	if minetest.get_node_group(node, "water")>0 or minetest.get_node_group(node, "lava")>0 then
		self.object:set_hp(self.object:get_hp()-2)
	end

	if math.random (3)==1 and self.attack==1 then
		minetest.sound_play(self.sound, {pos=pos, gain = 1.0, max_hear_distance = 5,})
	end

--hp

	if self.object:get_hp()<self.ohp then
		self.ohp=self.object:get_hp()
		minetest.sound_play(self.sound, {pos=pos, gain = 1.0, max_hear_distance = 5,})
	end

	if self.object:get_hp()<=0 then
			if self.special>0 and minetest.get_node(pos).name=="air" then
			minetest.set_node(pos, {name = self.drop})
			pollution_spawn_kmob(pos,0,1)
			minetest.set_node(pos, {name = self.drop})
			pollution_spawn_kmob(pos,0,1)
			end
		if self.drop~="" then minetest.add_item(pos, self.drop) end
		self.object:remove()
		return false
	end

--walk
	if self.movment.y<=0 and self.attack==0 then
		pollution_mob_rndwalk(self)
	end

--attack				
		local todmg=1
		local toattack=0
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 7)) do
			if pollution_visiable(pos,ob,1) and ((not ob:get_luaentity()) or (ob:get_luaentity() and (not (ob:get_luaentity().team and ob:get_luaentity().team==self.team)) and (not ob:get_luaentity().flashhand_power))) then
				self.attackobject=ob
				self.attack=1
				toattack=1
				if self.special>0 then
					local obp=ob:getpos()
					pos.x=obp.x
					pos.y=obp.y+1
					pos.z=obp.z
					self.object:moveto(pos)
					pollution_sound_shoot(pos,2)
				end
				break
			end
		end
		if toattack==0 and self.attack==0 and self.atta==1 and self.team~="barrel" then
			self.atta=0
			pollution_mob_fangs(self,0)
		end
		if toattack==0 and self.attack==1 and self.team~="barrel" then
			self.attack=0
			pollution_mob_fangs(self,0)
		else
		if toattack==1 and self.atta==0 and self.team~="barrel" then
			self.attack=1
			pollution_mob_fangs(self,1)
		end

		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 1.5)) do
		todmg=1
			if ob:get_luaentity() and ob:get_luaentity().team and ob:get_luaentity().team==self.team then todmg=0 end
			if todmg==1 and ((not ob:get_luaentity()) or (ob:get_luaentity() and ob:get_luaentity().flashhand_power==nil)) then
				self.attackobject=ob
				minetest.sound_play(self.sound, {pos=pos, gain = 1.0, max_hear_distance = 5,})
				self.attackobject:set_hp(self.attackobject:get_hp()-self.dmg)
				if ob:get_hp()<=0 and ob:is_player()==false then
					self.object:set_hp(self.object:get_hp()+5)
					local size=self.object:get_luaentity().visual_size
					local co=self.object:get_luaentity().collisionbox
					local c4=(co[4]*1.1)*-1
					self.object:set_properties({
					visual_size={x=size.x*1.1,y=size.y*1.1},
					collisionbox = {c4, c4, c4, co[4]*1.1, co[5]*1.1, co[6]*1.1},
					})
					self.object:get_luaentity().dmg=self.object:get_luaentity().dmg+1
					self.object:moveto({x=pos.x,y=pos.y+0.5,z=pos.z})


				end
				self.attackobject:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:steel_pick", nil)
				self.object:setvelocity({x = 0,y = self.object:getvelocity().y,z = 0})
				if self.barrel>0 then pollution_mob_barrel_attack(self) end
				if self.atta==1 then pollution_mob_fangs(self,2) end
				break
			end
		end
		end

		pollution_mob_updateyaw(self)
end








local pollution_km_tmps={}
function pollution_spawn_kmob(pos,special,nodrop)

	local node=minetest.registered_nodes[minetest.get_node(pos).name]
	if node==nil or node.drop=="" then return false end
	if minetest.get_node_group(node.name, "unbreakable")>0 or (
	minetest.get_node_group(node.name, "fleshy")==0 and
	minetest.get_node_group(node.name, "choppy")==0 and
	minetest.get_node_group(node.name, "bendy")==0 and
	minetest.get_node_group(node.name, "cracky")==0 and
	minetest.get_node_group(node.name, "crumbly")==0 and
	minetest.get_node_group(node.name, "snappy")==0)
	then return false end

	minetest.set_node(pos, {name = "air"})
	pollution_km_tmps.con=1
	if node.drop==nil then
		pollution_km_tmps.drop=node.name
	else
		pollution_km_tmps.drop=node.drop
	end
	if nodrop then pollution_km_tmps.drop="" end
--special
	local tiles={}
	local stop=0
	for i, t in pairs(node.tiles) do
		tiles[i]=t
		if special==1 and type(tiles[i])=="string" then tiles[i]=t .. "^pollution_pur.png" end
		stop=stop+1
		if type(tiles[i])~="string" then
		if stop==1 then tiles[i]="default_dirt.png" end
			stop=stop-1
			break
		end
	end

	for i=stop,6,1 do
		tiles[i]=tiles[stop] 
	end

	pollution_mob_id=pollution_mob_id+1
	pollution_km_tmps.team=node.name
	pollution_km_tmps.hp=10
	pollution_km_tmps.tmptexture=tiles
	pollution_km_tmps.barrel=0

	pollution_km_tmps.sound="default_wood_footstep"
	if minetest.get_node_group(node.name, "wood")>0 then pollution_km_tmps.team="wood" pollution_km_tmps.hp=10 pollution_km_tmps.sound="default_wood_footstep" end
	if minetest.get_node_group(node.name, "stone")>0 then pollution_km_tmps.team="stone" pollution_km_tmps.hp=15 pollution_km_tmps.sound="default_dig_cracky" end
	if minetest.get_node_group(node.name, "soil")>0 then pollution_km_tmps.team="dirt" pollution_km_tmps.hp=5 pollution_km_tmps.sound="default_dig_choppy" end
	if minetest.get_node_group(node.name, "flora")>0 then pollution_km_tmps.team="flora" pollution_km_tmps.hp=5 pollution_km_tmps.sound="default_dirt_footstep" end
	if minetest.get_node_group(node.name, "snappy")>0 then pollution_km_tmps.team="flora" pollution_km_tmps.hp=5 pollution_km_tmps.sound="default_dirt_footstep" end
	if minetest.get_node_group(node.name, "tree")>0 then pollution_km_tmps.team="wood" pollution_km_tmps.hp=15 pollution_km_tmps.sound="default_wood_footstep" end
	if minetest.get_node_group(node.name, "barrel")>0 then pollution_km_tmps.team="barrel" pollution_km_tmps.hp=50 pollution_km_tmps.sound="pollution_punsh" pollution_km_tmps.barrel=minetest.get_node_group(node.name, "barrel") end

	if special==1 then
		pollution_km_tmps.hp=pollution_km_tmps.hp*3
		pollution_km_tmps.special=1
	end


	local type=node.drawtype
	if type=="nodebox" and node.node_box then
		if node.node_box.type=="regular" then type="normal" end
		if node.node_box.type=="wallmounted" or node.node_box.type=="fixed" then type="signlike" end
	end

	if type=="plantlike" or type=="signlike" or type=="raillike" or type=="torchlike" or type=="mesh" or type=="fencelike" then else type="normal" end
	if node.name:find("slab_",1) or node.name:find("_slab",1) or node.name:find("sign",1) or node.name=="default:snow" then type="slab" end
	if node.name:find("stair_",1) or node.name:find("_stair",1) then type="stair" end
	pollution_km_tmps.type=type
	local m=minetest.add_entity(pos, "pollution:kmob")
	m:set_properties({textures = tiles})

	if type=="plantlike" or type=="torchlike" then m:set_properties({visual="sprite"}) end
	if type=="signlike" or type=="raillike" then m:set_properties({visual="upright_sprite"}) end

	if type=="mesh" then
		local npos={}
		npos.x=node.wield_scale.x*2
		npos.y=node.wield_scale.y*2
		npos.z=node.wield_scale.z*2
		m:set_properties({collisionbox=node.selection_box.fixed})
		m:set_properties({visual="mesh"})
		m:set_properties({mesh=node.mesh})
		m:set_properties({visual_size=npos})
	end

	if minetest.get_node_group(node.name, "barrel")>0 or node.name:find("pollution:bottle",1) or node.name:find("pollution:crystal_",1) then
		local s={x=10,y=10,z=10}
		if type~="mesh" then s={x=1,y=1,z=1} end
		if special==1 then m:set_properties({textures = {"pollution_pur.png","pollution_pur.png","pollution_pur.png","pollution_pur.png","pollution_pur.png"}}) end
		m:set_properties({visual_size=s})
		 
	end

	if type=="fencelike" then
		local npos={}
		npos.x=node.wield_scale.x*0.3
		npos.y=node.wield_scale.y*1
		npos.z=node.wield_scale.z*0.3
		m:set_properties({visual_size=npos})
	end

	if type=="stair" then
		local npos={}
		npos.x=node.wield_scale.x*10
		npos.y=node.wield_scale.y*10
		npos.z=node.wield_scale.z*10
		m:set_properties({visual="mesh"})
		m:set_properties({mesh="stairs_stair.obj"})
		m:set_properties({visual_size=npos})
	end
	if type=="slab" then
		local npos={}
		npos.x=node.wield_scale.x*1
		npos.y=node.wield_scale.y*0.4
		npos.z=node.wield_scale.z*1
		m:set_properties({visual_size=npos})
	end



end

local function pollution_throw(user,type)
	local veloc=10
	local pos = user:getpos()
	local upos={x=pos.x,y=pos.y+2,z=pos.z}
	pollution_tmp_bottle={special=type,user=user:get_player_name()}
	local m=minetest.env:add_entity(upos, "pollution:bottle1")
	local dir = user:get_look_dir()
	m:setvelocity({x=dir.x*veloc, y=dir.y*veloc, z=dir.z*veloc})
	m:setacceleration({x=dir.x*-3, y=-5, z=dir.z*-3})
	m:setyaw(user:get_look_yaw()+math.pi)

	if type==1 then
		m:set_properties({
			visual = "mesh",
			textures = {"pollution_pur.png","pollution_black.png","pollution_pur.png","pollution_pur.png^pollution_log2.png"},
		})
	end

	minetest.sound_play("pollution_throw", {pos=pos, gain = 1.0, max_hear_distance = 5,})

end

minetest.register_node("pollution:bottle", {
	description = "Kalium bottle",
	drawtype = "mesh",
	mesh = "pollution_bottle.obj",
	visual_scale = 1.0,
	inventory_image = "pollution_bottleinv.png",
	wield_image = "pollution_bottleinv.png",
	wield_scale = {x=1, y=1, z=1},
	alpha = 20,
	tiles = {"pollution_bottle.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	light_source=4,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.1, 0.2, 0.10, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3,},
	on_use = function(itemstack, user, pointed_thing)
		if pollution_mobs_max() then
			pollution_throw(user,0)
			itemstack:take_item()
		else
		minetest.chat_send_player(user:get_player_name(), "Too many pollution mobs: (max " .. pollution_mobs_max_number .. ")")
		end
		return itemstack
		end,
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("pollution:bottlepur", {
	description = "Kalium bottle pur",
	drawtype = "mesh",
	mesh = "pollution_bottle.obj",
	visual_scale = 1.0,
	wield_scale = {x=1, y=1, z=1},
	inventory_image = "pollution_bottleinv2.png",
	wield_image = "pollution_bottleinv2.png",
	alpha = 20,
	tiles = {"pollution_bottle2.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	light_source=4,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.1, 0.2, 0.10, 0.1}
	},
	groups = {fleshy = 3, dig_immediate = 3,},
	on_use = function(itemstack, user, pointed_thing)
		if pollution_mobs_max() then
			pollution_throw(user,1)
			itemstack:take_item()
		else
		minetest.chat_send_player(user:get_player_name(), "Too many pollution mobs: (max " .. pollution_mobs_max_number .. ")")
		end
		return itemstack
		end,
	sounds = default.node_sound_glass_defaults(),
})



minetest.register_entity("pollution:kmob",
{
	hp_max = 10,
	physical = true,
	weight = 5,
	collisionbox = {-0.5,-0.5,-0.5, 0.5,0.5,0.5},
	visual = "cube",
	visual_size = {x=1, y=1},
	--mesh = "cube",
	textures = {},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = true,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	if pos==nil then return false end
	minetest.sound_play(self.sound, {pos=pos, gain = 1.0, max_hear_distance = 5,})
	if self.object:get_hp()<=0 then
		if self.barrel>0 and minetest.get_node(pos).name=="air" and minetest.registered_nodes[self.drop] then
			minetest.set_node(pos, {name = self.drop})
			self.object:remove()
		else
			if self.special>0 and minetest.get_node(pos).name=="air" and minetest.registered_nodes[self.drop] then
			minetest.set_node(pos, {name = self.drop})
			pollution_spawn_kmob(pos,0,1)
			minetest.set_node(pos, {name = self.drop})
			pollution_spawn_kmob(pos,0,1)
			end
			if self.drop~="" then minetest.add_item(pos, self.drop) end
		end
		return false
	end
	self.attackobject=puncher
	self.attack=1
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	end,
on_activate=function(self, staticdata)

		if pollution_mobs_max(self.object)==false then
			self.object:remove()
			pollution_km_tmps={}
			return false
		end

		if pollution_km_tmps.con then
			self.drop=pollution_km_tmps.drop
			self.pkmid=pollution_mob_id
			self.object:set_hp(pollution_km_tmps.hp)
			self.ohp=pollution_km_tmps.hp
			self.team=pollution_km_tmps.team
			self.sound=pollution_km_tmps.sound
			self.barrel=pollution_km_tmps.barrel
			self.tmptexture=pollution_km_tmps.tmptexture
			self.special=pollution_km_tmps.special
			if pollution_km_tmps.type~="normal" then self.atta=-1 end
			pollution_km_tmps={}
		else
			self.object:remove()
			return false
		end
	end,
on_step=pollution_mob,
	timer=0,
	timer2=0,
	drop="",
	movment={x=0,y=0,z=0},
	pkmid=0,
	attack=0,
	atta=0,
	attackobject={},
	dmg=4,
	team="",
	sound={},
	ohp=0,
	tmptexture={},
	type = "monster",
	barrel=0,
	special=0,
})


minetest.register_entity("pollution:bottle1", 
{
	hp_max = 10,
	--physical =true,
	weight = 5,
	collisionbox = {-0.2, -0.5, -0.1, 0.2, 0.15, 0.1},
	visual = "mesh",
	visual_size = {x=10, y=10},
	mesh = "pollution_bottle.obj",
	textures = {"pollution_lime.png","pollution_black.png","pollution_lime.png","pollution_lime.png^pollution_log2.png"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	alpha=10,
	timer=0,
	timerlime=0,
	user="",
	hit=0,
	special=0,
on_activate=function(self, staticdata)
	self.user=pollution_tmp_bottle.user
	self.special=pollution_tmp_bottle.special
	pollution_tmp_bottle={special=0,user={}}
	end,
on_step = function(self, dtime)
	self.timer=self.timer+dtime
	if self.timer>0.05 then
	self.timerlime=self.timerlime+self.timer
		self.timer=0
		local pos = self.object:getpos()
		if self.hit==0 then
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 1)) do
			if (ob:is_player() and ob:get_player_name()~=self.user) or (ob:get_luaentity() and ob:get_luaentity().name~="pollution:bottle1") then
				ob:set_hp(ob:get_hp()-5)
				ob:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=5}}, "pollution:bottle", nil)
				self.object:setvelocity({x=0, y=-10, z=0})
				self.object:setacceleration({x=0, y=-10,z=0})
				self.hit=1
				break
			end
		end
		end

	if minetest.get_node(pos).name~="air" then
		if minetest.is_protected(pos,"")==false then
			pollution_spawn_kmob({x=pollution_round(pos.x),y=pollution_round(pos.y),z=pollution_round(pos.z)},self.special)
		end
		minetest.sound_play("default_break_glass", {pos=pos, gain = 3.0, max_hear_distance = 10,})
		self.object:remove()
	end
	if self.timerlime>5 then self.object:remove() end
	end


end
})