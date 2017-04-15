local pollution_axov_rnd_drops={item="default:cobble",amo=math.random(3)}
local pollution_axov_ano_texture=nil
local function pollution_rnddrops(its)
	if math.random(5)==1 then pollution_axov_rnd_drops={item=its,amo=math.random(25)}end
	if math.random(20)==1 then pollution_axov_rnd_drops={item="pollution:bottle",amo=4} end
	if math.random(30)==1 then pollution_axov_rnd_drops={item="pollution:bottlepur",amo=2} end
end


minetest.register_abm({
	nodenames = {"pollution:ice","pollution:dirt","pollution:crystal_soil","pollution:acid_fire","pollution:n_fire"},
	interval = 120,
	chance = 10,
	action = function(pos)
		local name=minetest.get_node(pos).name
		pos={x=pos.x,y=pos.y+1,z=pos.z}
		if minetest.get_node(pos).name=="air" then
			if name=="pollution:ice" and math.random(50)==1 then minetest.env:add_entity(pos, "pollution:axov_ice") end
			if name=="pollution:crystal_soil" and math.random(50)==1 then minetest.env:add_entity(pos, "pollution:axov_crystal") end
			if name=="pollution:dirt" and math.random(50)==1 then minetest.env:add_entity(pos, "pollution:axov") end
			if name=="pollution:acid_fire" and math.random(30)==1 then minetest.env:add_entity(pos, "pollution:axovy") end
			if name=="pollution:n_fire" and math.random(30)==1 then minetest.env:add_entity(pos, "pollution:axovu") end
		end
	end,
})


minetest.register_tool("pollution:axovrifle", {
	description = "axov rifle",
	range = 15,
	inventory_image = "pollution_trifle.png^pollution_dirt.png^pollution_dirt.png^pollution_dirt.png",
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type=="node" then
				if pollution_mobs_max(0,1) then
					local p=pointed_thing.above
					p={x=p.x,y=p.y+0.5,z=p.z}
					minetest.env:add_entity(p, "pollution:axov")
				else
					minetest.chat_send_player(user:get_player_name(), "Too many pollution axov mobs: (max " .. pollution_mobs_axov_max_number .. ")")
				end
			end
		return itemstack
		end,
})

minetest.register_tool("pollution:axovicerifle", {
	description = "axov ice rifle",
	range = 15,
	inventory_image = "pollution_nrifle.png^pollution_blue2.png",
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type=="node" then
				if pollution_mobs_max(0,1) then
					local p=pointed_thing.above
					p={x=p.x,y=p.y+0.5,z=p.z}
					minetest.env:add_entity(p, "pollution:axov_ice")
				else
					minetest.chat_send_player(user:get_player_name(), "Too many pollution axov mobs: (max " .. pollution_mobs_axov_max_number .. ")")
				end
			end
		return itemstack
		end,
})


minetest.register_tool("pollution:axocrystalvrifle", {
	description = "axov crystal rifle",
	range = 15,
	inventory_image = "pollution_trifle.png^pollution_lila2.png",
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type=="node" then
				if pollution_mobs_max(0,1) then
					local p=pointed_thing.above
					p={x=p.x,y=p.y+0.5,z=p.z}
					minetest.env:add_entity(p, "pollution:axov_crystal")
				else
					minetest.chat_send_player(user:get_player_name(), "Too many pollution axov mobs: (max " .. pollution_mobs_axov_max_number .. ")")
				end
			end
		return itemstack
		end,
})

minetest.register_tool("pollution:axovyrifle", {
	description = "axovy rifle",
	range = 15,
	inventory_image = "pollution_trifle.png^pollution_lime.png",
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type=="node" then
				if pollution_mobs_max(0,1) then
					local p=pointed_thing.above
					p={x=p.x,y=p.y+0.5,z=p.z}
					minetest.env:add_entity(p, "pollution:axovy")
				else
					minetest.chat_send_player(user:get_player_name(), "Too many pollution axov mobs: (max " .. pollution_mobs_axov_max_number .. ")")
				end
			end
		return itemstack
		end,
})

minetest.register_tool("pollution:axovurifle", {
	description = "axovu rifle",
	range = 15,
	inventory_image = "pollution_trifle.png^[colorize:#aaff00aa",
		on_use = function(itemstack, user, pointed_thing)
			if pointed_thing.type=="node" then
				if pollution_mobs_max(0,1) then
					local p=pointed_thing.above
					p={x=p.x,y=p.y+0.5,z=p.z}
					minetest.env:add_entity(p, "pollution:axovu")
				else
					minetest.chat_send_player(user:get_player_name(), "Too many pollution axov mobs: (max " .. pollution_mobs_axov_max_number .. ")")
				end
			end
		return itemstack
		end,
})

local function pollution_distance(self,o)
if o==nil or o.x==nil then return nil end
local p=self.object:getpos()
return math.sqrt((p.x-o.x)*(p.x-o.x) + (p.y-o.y)*(p.y-o.y)+(p.z-o.z)*(p.z-o.z))
end

function pollution_visiable(pos,ob,kalium)

	if ob==nil or ob:getpos()==nil or ob:getpos().y==nil then return false end
	local ta=ob:getpos()

	if (not kalium) or ob.team=="barrel" then ta.y=ta.y+1 end
	local v = {x = pos.x - ta.x, y = pos.y - ta.y+1, z = pos.z - ta.z}
	v.y=v.y-1
	local amount = (v.x ^ 2 + v.y ^ 2 + v.z ^ 2) ^ 0.5
	local d=math.sqrt((pos.x-ta.x)*(pos.x-ta.x) + (pos.y-ta.y)*(pos.y-ta.y)+(pos.z-ta.z)*(pos.z-ta.z))
	v.x = (v.x  / amount)*-1
	v.y = (v.y  / amount)*-1
	v.z = (v.z  / amount)*-1
	for i=1,d,1 do
		local node=minetest.registered_nodes[minetest.get_node({x=pos.x+(v.x*i),y=pos.y+(v.y*i),z=pos.z+(v.z*i)}).name]
		if node.walkable and node.sunlight_propagates==false then
			return false
		end
	end
	return true
end

local function pollution_axov_rndwalk(self)
	if self.attack==1 then return self end
	local pos=self.object:getpos()
	self.move.x=math.random(3)-self.move.speed
	self.move.z=math.random(3)-self.move.speed
	self.object:setvelocity({x = self.move.x, y = self.move.y, z =self.move.z})
	if self.move.x+self.move.x==0 then
		setanim(self,"stand")
	else
		setanim(self,"walk")
	end
	return self
end

local function pollution_axov_walk(self)
	local pos=self.object:getpos()
	local yaw=self.object:getyaw()
	if yaw ~= yaw then
		self.status_curr="rnd"
		return true
	end
	local x =math.sin(yaw) * -1
	local z =math.cos(yaw) * 1
	self.move.x=x
	self.move.z=z
	self.object:setvelocity({
		x = x*(self.move.speed+1),
		y = self.object:getvelocity().y,
		z = z*(self.move.speed+1)})
		setanim(self,"walk")
	return self
end

local function pollution_axov_lookat(self)
	local folow
	local pos=self.object:getpos()
	if self.status_curr=="rnd" then folow={x=pos.x+self.move.x,y=pos.y,z=pos.z+self.move.z} end
	if self.status_curr=="attack" then folow=self.status_target1:getpos() end
	if self.status_curr=="goto" then folow=self.status_target2 end


	if folow==nil or folow.x==nil then
		self.status_curr="rnd"
		return false
	end
	local vec = {x=pos.x-folow.x, y=pos.y-folow.y, z=pos.z-folow.z}
	local yaw = math.atan(vec.z/vec.x)-math.pi/2

	if pos.x > folow.x then yaw = yaw+math.pi end
	self.object:setyaw(yaw)
	if self.status_curr~="" then pollution_axov_walk(self) end
	return self
end


local function pollution_axov_pickup(self,ob,remove)
-- dig a node
	if remove and remove==2 then
		local name=minetest.get_node(ob).name
		if minetest.is_protected(ob,"") or self.toxic==0 then
			return false
		else
			minetest.set_node(ob, {name="air"})
			if name=="air" then return true end
			if minetest.get_node_group(name, "unbreakable")>0 or minetest.get_node(ob).drop=="" or name=="default:chest_locked" then return false end
			if self.inv.empty then self.inv={} end
			minetest.sound_play("default_dug_node",{pos = ob, max_hear_distance = 16, gain = 1})
			pollution_rnddrops(name)
			for i, it in pairs(self.inv) do
				if it.item==name and it.amo<99 then
					it.amo=it.amo+1
					return true
				end
			end
			table.insert(self.inv,{item=name,amo=1})
			return true
		end
	end
 -- pickup item
	if ob:get_luaentity() and ob:get_luaentity().name=="__builtin:item" then
		local name=ob:get_luaentity().itemstring
		local num=string.split(name," ")
		if num[2]==nil then num[2]=1 end
		if self.inv.empty then self.inv={} end
		pollution_rnddrops(num[1])
		for i, it in pairs(self.inv) do
			if it.item==num[1] and it.amo<99 then
				it.amo=it.amo+1
				if remove then ob:remove() end
				return self
			end
		end
		table.insert(self.inv,{item=num[1],amo=tonumber(num[2])})
		if remove then ob:remove() end
	end
	return self
end


local pollution_axov=function(self, dtime)
	self.timer=self.timer+dtime
	self.timer2=self.timer2+dtime

	if self.timer2>=0.5 then
		self.timer2=0

-- if attacking or goto

		if self.status_curr=="attack" or self.status_curr=="goto" then
			local tpos=0
			pollution_axov_lookat(self)
			if self.status_curr=="goto" then
				tpos=pollution_distance(self,self.status_target2)
				if tpos==nil then self.status_curr="rnd" return self end
				if tpos<=1.5 or self.stuck_path>=20 then
				self.stuck_path=0
				self.status_curr=self.status_next
				self.status_target2={}
				if self.status_curr=="goto" then
					local yaw=self.object:getyaw()
					if yaw ~= yaw then return true end
					yaw = yaw+math.pi
					self.object:setyaw(yaw)
					pollution_axov_walk(self)
					self.status_curr="rnd"
				end
				end
			end
			if self.status_curr=="attack" then
				tpos=pollution_distance(self,self.status_target1:getpos())
				if tpos==nil or tpos>self.distance or self.status_target1:get_hp()<=0 or
				pollution_visiable(self.object:getpos(),self.status_target1)==false then
					self.status_curr="rnd" setanim(self,"stand")
					if self.nuke==1 and self.object:get_hp()<self.hp_max then self.object:set_hp(self.object:get_hp()+10) end
					return self
				end
				
--throw if have items
				if tpos<self.distance and tpos>3 then
					if self.nuke==0 and (not self.inv.empty) and math.random(5)==1 then




						if (not self.status_target1:get_luaentity()) or (self.status_target1:get_luaentity() and self.status_target1:get_luaentity().name~="__builtin:item") then
							pollution_throw2(self)
						end
					end


					if self.nuke==1 then 
						if math.random(5)==1 and tpos<self.distance/2 and minetest.is_protected(self.status_target1:getpos(),"")==false then
							for i=1,15,1 do
								local np=minetest.find_node_near(self.status_target1:getpos(),3,{"air","group:water"})
								if np~=nil and minetest.is_protected(np,"")==false then
									minetest.set_node(np, {name ="pollution:n_fire"})
								else
									break
								end
							end
						elseif math.random(5)==1 then
							if minetest.is_protected(self.status_target1:getpos(),"")==false then
								minetest.set_node(self.status_target1:getpos(), {name ="pollution:n_fire"})
							else
								pollution.flashdamage(4,self.status_target1)
							end
						end
					end
				end
--hurting
				if tpos<=3 and math.random(3)==1 then
					self.object:setvelocity({x=0, y=self.move.y, z=0})
					self.status_target1:set_hp(self.status_target1:get_hp()-self.dmg)
					self.status_target1:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
					if self.axid then minetest.set_node(self.status_target1:getpos(), {name="pollution:acid_fire"}) end
					pollution_sound_hard_punch(self.status_target1:getpos())
					setanim(self,"mine")
					if self.status_target1:get_hp()<=0 and self.status_target1:is_player()==false then
						self.object:set_hp(self.object:get_hp()+5)
						setanim(self,"stand")
					end
					if self.status_target1:get_hp()<=0 and self.status_target1:is_player()==true then
						local t=self.status_target1:get_properties().textures
						if t~=nil then
							pollution_axov_ano_texture=t
							self.object:set_properties({
							mesh = "character.b3d",
								textures = t
							})
						end
					end
				end
			end
		end

--jump+falling

--after jump
		if self.move.jump==1 then
			self.move.jump_timer=self.move.jump_timer-1
			if self.move.jump_timer<=0 then
				self.move.jump=0
				self.object:setacceleration({x =0, y = 0, z =0})
			end
		end
--front of a wall
		if self.move.y==0 and self.move.jump==0 then
			local ppos=self.object:getpos()
			local nodes={}
			for i=1,5,1 do --starts front of the object and y: -2 to +2
				nodes[i]=minetest.registered_nodes[minetest.get_node({x=ppos.x+self.move.x,y=ppos.y+(i-3.5),z=ppos.z+self.move.z}).name].walkable
			end

 -- dig

			if self.status_curr=="attack" and self.status_target1:getpos().y<ppos.y-1 then
				local tp=self.status_target1:getpos()
				if pollution_round(ppos.x)==pollution_round(tp.x) and pollution_round(ppos.z)==pollution_round(tp.z) then
					local eppos={x=ppos.x,y=ppos.y-2,z=ppos.z}
					if minetest.registered_nodes[minetest.get_node(eppos).name].walkable then
						pollution_axov_pickup(self,eppos,2)
					end
				end
			end


 -- jump over 2




			if (nodes[3]==true and nodes[5]==false) or (nodes[3]==false and nodes[4]==true and nodes[5]==false) then
				local pos=self.object:getpos()
				local pos3={x=pos.x,y=pos.y+1,z=pos.z}
				if minetest.registered_nodes[minetest.get_node(pos3).name].walkable then pollution_axov_pickup(self,pos3,2) end
				self.move.jump=1
				self.move.jump_timer=1
				self.move.y=4
				self.move.x=self.move.x*2
				self.move.z=self.move.z*2
				self.object:setvelocity({x = self.move.x, y = self.move.y, z =self.move.z})
				self.object:setacceleration({x =0, y = self.move.y, z =0})
			end

 -- if sides passable
			if (nodes[3]==true and nodes[5]==true) then
			local ispp=self.object:getpos()
			ispp={x=ispp.x+self.move.x,y=ispp.y,z=ispp.z+self.move.z}

			if nodes[4]==false then
				pollution_axov_pickup(self,ispp,2) 
			end


-- if can break the wall
			if pollution_axov_pickup(self,ispp,2)==false or pollution_axov_pickup(self,{x=ispp.x,y=ispp.y-1,z=ispp.z},2)==false then

			local yaw=self.object:getyaw()
			if yaw ~= yaw then return true end
			local z=math.sin(yaw) * -1
			local x=math.cos(yaw) * 1
			local sidel1={}
			local sidel2={}
			local sidel3={}
			local sider1={}
			local sider2={}
			local sider3={}
			local passed=0
			for i=0,10,1 do --starts front of the object and y: -2 to +2
				sidel1[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*i),y=ispp.y+1,z=ispp.z+(z*i)}).name].walkable
				sidel2[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*i),y=ispp.y,     z=ispp.z+(z*i)}).name].walkable
				sidel3[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*i),y=ispp.y-1,  z=ispp.z+(z*i)}).name].walkable
				if (sidel1[i]==false and sidel2[i]==false) or (sidel2[i]==false and sidel3[i]==false) then
					self.status_next=self.status_curr
					self.status_curr="goto"
					self.status_target2={x=ispp.x+(x*i),y=ispp.y+1,z=ispp.z+(z*i)}
					pollution_axov_lookat(self)
					passed=1
					break
				end

				sider1[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*(i*-1)),y=ispp.y+1,z=ispp.z+(z*(i*-1))}).name].walkable
				sider2[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*(i*-1)),y=ispp.y,     z=ispp.z+(z*(i*-1))}).name].walkable
				sider3[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*(i*-1)),y=ispp.y-1, z=ispp.z+(z*(i*-1))}).name].walkable
				if (sider1[i]==false and sider2[i]==false) or (sider2[i]==false and sider3[i]==false) then
					self.status_next=self.status_curr
					self.status_curr="goto"
					self.status_target2={x=ispp.x+(x*(i*-1)),y=ispp.y,z=ispp.z+(z*(i*-1))}
					pollution_axov_lookat(self)
					passed=1
					break
				end
			end
			if passed==0 then
				self.stuck_path=0
				self.status_curr="rnd"
			else
				self.stuck_path=self.stuck_path+1
			end
			end
			end




 -- jump & attack
			if nodes[1]==false and nodes[2]==false and self.status_curr=="attack" then
				local pos=self.object:getpos()
				if minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable==true then
					self.move.x=self.move.x*2
					self.move.z=self.move.z*2
					self.move.jump=1
					self.move.jump_timer=1
					self.object:setvelocity({x = self.move.x, y = 1, z =self.move.z})
					self.object:setacceleration({x =0, y = 1, z =0})
				end

		
			end


		end
--falling
		if self.move.jump==0 then
			local pos=self.object:getpos()
			local nnode=minetest.get_node({x=pos.x,y=pos.y-1.5,z=pos.z}).name
			local node=minetest.registered_nodes[nnode]
			if node and node.walkable==false then
				self.move.y=-10
				self.object:setacceleration({x =0, y = self.move.y, z =0})
			end
			if node and node.walkable==true and self.move.y~=0 then
				self.move.y=0
			end
		end
	end

	if self.timer<2 then return true end
--Common==========================================
	self.timer=0
	if self.object==nil then return false end

	local pos=self.object:getpos()
	local node=minetest.get_node(pos).name
	if minetest.get_node_group(node, "water")>0 or minetest.get_node_group(node, "lava")>0 then
		self.object:set_hp(self.object:get_hp()-2)
	end

--pickup
	local pos_under={x=pos.x,y=pos.y-2,z=pos.z}
	if self.toxic==1 then
	if minetest.get_node(pos_under).name=="default:dirt_with_grass" and minetest.is_protected(pos_under,"")==false then minetest.set_node(pos_under, {name="default:dirt"}) end
	if self.acid==1 and minetest.is_protected({x=pos.x,y=pos.y-1,z=pos.z},"")==false then minetest.set_node({x=pos.x,y=pos.y-1,z=pos.z}, {name="pollution:acid_fire"}) end

		if self.nuke==1 then 
		local np=minetest.find_node_near(pos,15,{"group:soil","group:sand","group:flammable","group:dig_immediate","group:flowers","group:oddly_breakable_by_hand","group:stone"})
			if np~=nil and minetest.is_protected(np,"")==false then
				minetest.set_node(np, {name ="pollution:n_fire"})
			end
		end


		local i=0
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 5)) do
			pollution_axov_pickup(self,ob,1)
			i=i+1
			if i>=5 then break end
		end
	else
		if minetest.get_node(pos_under).name=="default:dirt_with_grass" and minetest.is_protected(pos_under,"")==false then
			if self.crystal then
				minetest.set_node(pos_under, {name="pollution:crystal_soil"})
			else
				minetest.set_node(pos_under, {name="default:dirt_with_snow"})
			end


		end
	end
		if self.status_curr~="rnd" then return self end
--walk

	if self.status_curr=="rnd" and self.move.y<=0 then
	self.life=self.life-1
	if self.life<=0 then self.object:remove() return false end
		pollution_axov_rndwalk(self)
	end

--attack

		local todmg=1
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, self.distance)) do
			if (not ob:get_luaentity()) or (ob:get_luaentity() and (not (ob:get_luaentity().team and ob:get_luaentity().team==self.team)) and ob:get_luaentity().name~="pollution:icicle") then
				if (ob.object and ob.object:get_hp()>0) or ob:get_hp()>0 then
					if pollution_visiable(pos,ob) and ((not ob:get_luaentity()) or (ob:get_luaentity() and (not(self.status_curr=="attack" and ob:get_luaentity().name=="__builtin:item")))) then
						self.status_target1=ob
						self.status_curr="attack"
						self.life=100
						break
					end
				end
			end
		end


		pollution_axov_lookat(self)
end

function setanim(self,type)
	local curr=self.anim_curr~=type
	if	type=="stand" and curr then self.object:set_animation({ x=  0, y= 79, },30,0)
	elseif	type=="lay" and curr then  self.object:set_animation({ x=162, y=166, },30,0)
	elseif	type=="walk" and curr then  self.object:set_animation({ x=168, y=187, },30,0)
	elseif	type=="mine" and curr then  self.object:set_animation({ x=189, y=198, },30,0)
	elseif	type=="walk_mine" and curr then  self.object:set_animation({ x=200, y=219, },30,0)
	elseif	type=="sit" and curr then  self.object:set_animation({x= 81, y=160, },30,0)
	else return self
	end
	self.anim_curr=type
	return self
end


minetest.register_entity("pollution:axov",{
	hp_max = 50,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.b3d",
	textures = {"pollution_gassman.png"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	pollution_axov_lookat(self)
	pollution_sound_hard_punch(pos)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if self.object:get_hp()<=0 then
		local c=0
		for i, itt in pairs(self.inv) do
			if tonumber(itt)~=nil or itt.item==nil then return false end
			minetest.add_item(pos, itt.item .." ".. itt.amo):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
			self.inv[i]=nil
			c=c+1
			if c==3 then break end
		end
		self.object:remove()
	end


	end,
on_activate=function(self, staticdata)
		self.object:setvelocity({x=0,y=0,z=0})
		self.object:setacceleration({x=0,y=0,z=0})
		setanim(self,"stand")
		if pollution_mobs_max(self.object,1,1)==false then
			self.object:remove()
			return false
		end
		if pollution_axov_ano_texture then
			self.object:set_properties({mesh = "character.b3d",textures = pollution_axov_ano_texture})
			pollution_axov_ano_texture=nil
		end
	end,
on_step=pollution_axov,
	toxic=1,
	nuke=0,
	life=20,
	anim_curr="",
	status_curr="rnd",
	status_next="",
	status_target1={},
	status_target2={},
	timer=0,
	timer2=0,
	drop="",
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=2},
	dmg=4,
	team="axov",
	type = "monster",
	inv={pollution_axov_rnd_drops},
	distance=10,
	stuck_path=0,
})


minetest.register_entity("pollution:axov_ice",{
	hp_max = 50,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.b3d",
	textures = {"pollution_iceman.png"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	pollution_axov_lookat(self)
	pollution_sound_hard_punch(pos)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if self.object:get_hp()<=0 then
		minetest.add_item(pos, "pollution:ice"):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
		minetest.add_item(pos, "pollution:ice"):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
		self.object:remove()
	end


	end,
on_activate=function(self, staticdata)
		self.object:setvelocity({x=0,y=0,z=0})
		self.object:setacceleration({x=0,y=0,z=0})
		setanim(self,"stand")
		if pollution_mobs_max(self.object,1,1)==false then
			self.object:remove()
			return false
		end
		if pollution_axov_ano_texture then
			self.object:set_properties({mesh = "character.b3d",textures = pollution_axov_ano_texture})
			pollution_axov_ano_texture=nil
		end
	end,
on_step=pollution_axov,
	toxic=0,
	nuke=0,
	life=20,
	anim_curr="",
	status_curr="rnd",
	status_next="",
	status_target1={},
	status_target2={},
	timer=0,
	timer2=0,
	drop="",
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=2},
	dmg=4,
	team="axov_ice",
	type = "monster",
	inv={pollution_axov_rnd_drops},
	distance=20,
	stuck_path=0,
})

minetest.register_entity("pollution:axov_crystal",{
	hp_max = 70,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.b3d",
	textures = {"pollution_crystalman.png"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	pollution_axov_lookat(self)
	pollution_sound_hard_punch(pos)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if self.object:get_hp()<=0 then
		minetest.add_item(pos, "pollution:crystal_soil"):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
		minetest.add_item(pos, "pollution:crystal_soil"):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
		self.object:remove()
	end


	end,
on_activate=function(self, staticdata)
		self.object:setvelocity({x=0,y=0,z=0})
		self.object:setacceleration({x=0,y=0,z=0})
		setanim(self,"stand")
		if pollution_mobs_max(self.object,1,1)==false then
			self.object:remove()
			return false
		end
		if pollution_axov_ano_texture then
			self.object:set_properties({mesh = "character.b3d",textures = pollution_axov_ano_texture})
			pollution_axov_ano_texture=nil
		end
	end,
on_step=pollution_axov,
	toxic=0,
	crystal=1,
	nuke=0,
	life=20,
	anim_curr="",
	status_curr="rnd",
	status_next="",
	status_target1={},
	status_target2={},
	timer=0,
	timer2=0,
	drop="",
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=2},
	dmg=4,
	team="axov_crystal",
	type = "monster",
	inv={pollution_axov_rnd_drops},
	distance=10,
	stuck_path=0,
})

minetest.register_entity("pollution:axovy",{
	hp_max = 60,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.b3d",
	textures = {"pollution_gassman.png^[colorize:#00dd00cc"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	pollution_axov_lookat(self)
	pollution_sound_hard_punch(pos)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if self.object:get_hp()<=0 then
		local c=0
		for i, itt in pairs(self.inv) do
			if tonumber(itt)~=nil or itt.item==nil then return false end
			minetest.add_item(pos, itt.item .." ".. itt.amo):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
			self.inv[i]=nil
			c=c+1
			if c==3 then break end
		end
		self.object:remove()
	end


	end,
on_activate=function(self, staticdata)
		self.object:setvelocity({x=0,y=0,z=0})
		self.object:setacceleration({x=0,y=0,z=0})
		setanim(self,"stand")
		if pollution_mobs_max(self.object,1,1)==false then
			self.object:remove()
			return false
		end
		if pollution_axov_ano_texture then
			self.object:set_properties({mesh = "character.b3d",textures = pollution_axov_ano_texture})
			pollution_axov_ano_texture=nil
		end
	end,
on_step=pollution_axov,
	toxic=1,
	acid=1,
	nuke=0,
	life=20,
	anim_curr="",
	status_curr="rnd",
	status_next="",
	status_target1={},
	status_target2={},
	timer=0,
	timer2=0,
	drop="",
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=2},
	dmg=4,
	team="axovy",
	type = "monster",
	inv={pollution_axov_rnd_drops},
	distance=10,
	stuck_path=0,
})

minetest.register_entity("pollution:axovu",{
	hp_max = 800,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35, 0.35,0.8,0.35},
	visual = "mesh",
	visual_size = {x=1, y=1},
	mesh = "character.b3d",
	textures = {"pollution_gassman.png^[colorize:#aaff00aa"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	pollution_axov_lookat(self)
	pollution_sound_hard_punch(pos)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if self.object:get_hp()<=0 then
		for i=1,25,1 do
			local np=minetest.find_node_near(pos,3,{"air","group:water","group:soil","group:sand","group:flowers","group:oddly_breakable_by_hand","group:stone"})
			if np~=nil and minetest.is_protected(np,"")==false then
				minetest.set_node(np, {name ="pollution:n_fire"})
			else
				break
			end
		end
		if minetest.is_protected({x=pos.x,y=pos.y-0.5,z=pos.z},"")==false then
			minetest.set_node({x=pos.x,y=pos.y-0.5,z=pos.z}, {name ="pollution:nukecrystal"})
		end
		self.object:remove()
	end


	end,
on_activate=function(self, staticdata)
		self.object:setvelocity({x=0,y=0,z=0})
		self.object:setacceleration({x=0,y=0,z=0})
		setanim(self,"stand")
		if pollution_mobs_max(self.object,1,1)==false then
			self.object:remove()
			return false
		end
		if pollution_axov_ano_texture then
			self.object:set_properties({mesh = "character.b3d",textures = pollution_axov_ano_texture})
			pollution_axov_ano_texture=nil
		end
	end,
on_step=pollution_axov,
	toxic=1,
	nuke=1,
	acid=0,
	life=20,
	anim_curr="",
	status_curr="rnd",
	status_next="",
	status_target1={},
	status_target2={},
	timer=0,
	timer2=0,
	drop="",
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=2},
	dmg=4,
	team="axovu",
	type = "monster",
	inv={pollution_axov_rnd_drops},
	distance=12,
	stuck_path=0,
})



function pollution_throw2(self)
	local item
	local pos = self.object:getpos()
	local m
	if self.toxic==1 then
		for s in pairs(self.inv) do
			if self.inv[s].item==nil then self.inv={empty=1} return self end
			item=self.inv[s].item
			self.inv[s].amo=self.inv[s].amo-1
			if self.inv[s].amo<=0 then self.inv[s]=nil end
			break
		end
		if item==nil then self.inv={empty=1} return self end


		if item~="pollution:bottle" and item~="pollution:bottlepur" then
			m=minetest.add_item({x=pos.x,y=pos.y+1,z=pos.z},item)
		else
			pollution_tmp_bottle={special=0,user=""}
			m=minetest.env:add_entity({x=pos.x+(self.move.x*3),y=pos.y+1,z=pos.z+(self.move.z*3)}, "pollution:bottle1")
			if item=="pollution:bottlepur" then pollution_tmp_bottle={special=1,user=""} m:set_properties({visual = "mesh",textures = {"pollution_pur.png","pollution_black.png","pollution_pur.png","pollution_pur.png^pollution_log2.png"}}) end
		end
	else

		m=minetest.env:add_entity({x=pos.x+(self.move.x*3),y=pos.y+1,z=pos.z+(self.move.z*3)}, "pollution:icicle")
		m:set_properties({collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1}})
		if self.crystal then
			m:set_properties({textures = {"default_obsidian_shard.png^pollution_lila2.png"}})
		end



	end

	local ta=self.status_target1:getpos()
	local vec = {x = pos.x - ta.x, y = pos.y - ta.y+1, z = pos.z - ta.z}
	local amount = (vec.x ^ 2 + vec.y ^ 2 + vec.z ^ 2) ^ 0.5
	local v = -15
	
	if self.status_target1:is_player() then vec.y = vec.y -1 end
	vec.x = vec.x * v / amount
	vec.y = vec.y * v / amount
	vec.z = vec.z * v / amount
	m:setvelocity(vec)
	table.insert(pollution_axov_throw,{ob=m,timer=2})
	minetest.sound_play("pollution_throw", {pos=pos, gain = 1.0, max_hear_distance = 5,})
	return self
end



pollution_axov_throw={}
pollution_axov_throw_timer=0
minetest.register_globalstep(function(dtime) 
	pollution_axov_throw_timer=pollution_axov_throw_timer+dtime
	if pollution_axov_throw_timer<0.2 then return end
	pollution_axov_throw_timer=0
	for i, t in pairs(pollution_axov_throw) do
		t.timer=t.timer-0.25
		if t.timer<=0 or t.ob==nil or t.ob:getpos()==nil then table.remove(pollution_axov_throw,i) return end
		for ii, ob in pairs(minetest.get_objects_inside_radius(t.ob:getpos(), 1.5)) do
			if (not ob:get_luaentity()) or minetest.get_node(t.ob:getpos()).name~="air" or (ob:get_luaentity() and (ob:get_luaentity().name~="__builtin:item" and ob:get_luaentity().name~="pollution:axov" and ob:get_luaentity().name~="pollution:bottle1" and ob:get_luaentity().name~="pollution:icicle")) then
				ob:set_hp(ob:get_hp()-5)
				ob:punch(t.ob, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				t.ob:setvelocity({x=0, y=0, z=0})
				if t.ob:get_hp()<=0 and ob:is_player()==false then ob:remove() end
				if t.ob:get_luaentity().name~="__builtin:item" then
					t.ob:setacceleration({x=0, y=-10,z=0})
					t.ob:setvelocity({x=0, y=-10, z=0})
					if t.ob:get_luaentity().name~="pollution:icicle" then
						pollution_sound_hard_punch(t.ob:getpos())
					else
						minetest.sound_play("default_break_glass", {pos=t.ob:getpos(), gain = 1.0, max_hear_distance = 5,})
					end
						table.remove(pollution_axov_throw,i)
						break
				end

			end
		end
	end
end)