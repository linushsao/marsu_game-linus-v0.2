minetest.register_abm({
	nodenames = {"air"},
	neighbors = {"marssurvive:stone_medium","marssurvive:stone_small","marssurvive:stone","default:dirt_with_grass"},
	interval = 120,
	chance = 50,
	action = function(pos)
		local name=minetest.get_node(pos).name
		pos={x=pos.x,y=pos.y+1,z=pos.z}
		if math.random(45)==1 and minetest.get_node(pos).name=="air" then
			local rnd=math.random(10)
    			local np=minetest.find_node_near(pos, 1,{"marssurvive:stone"})
			if np~=nil and pos.y>0 then
				rnd=-1
			end
			if rnd==1 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_common") end
			if rnd==2 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_death") end
			if rnd==3 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_big") end
			if rnd==4 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_teleport") end
			if rnd==5 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_small") end
			if rnd==6 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_glitch") end
			if rnd==7 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_sand") end
			if rnd==8 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_glow") end
			if rnd==9 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_stone") end
			if rnd==10 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_warn") end
			if rnd==11 and marssurvive_aliens_max(1)==true then minetest.env:add_entity(pos, "marssurvive:alien_crystal") end
			return
		end
	end,
})


function marssurvive_aliens_max(check,add)
		local c=0
		for i in pairs(marssurvive.aliens) do
			c=c+1
			if marssurvive.aliens[i]:getpos()==nil then
				table.remove(marssurvive.aliens,c)
				c=c-1
			end
		end
		if c>=marssurvive.aliens_max then return false end
		if check==0 then
			table.insert(marssurvive.aliens,add)
		end
		return true
end


local function marssurvive_distance(self,o)
if o==nil or o.x==nil then return nil end
local p=self.object:getpos()
return math.sqrt((p.x-o.x)*(p.x-o.x) + (p.y-o.y)*(p.y-o.y)+(p.z-o.z)*(p.z-o.z))
end

function marssurvive_visiable(pos,ob)
	if ob==nil or ob:getpos()==nil or ob:getpos().y==nil then return false end
	local ta=ob:getpos()
	local v = {x = pos.x - ta.x, y = pos.y - ta.y-1, z = pos.z - ta.z}
	v.y=v.y-1
	local amount = (v.x ^ 2 + v.y ^ 2 + v.z ^ 2) ^ 0.5
	local d=math.sqrt((pos.x-ta.x)*(pos.x-ta.x) + (pos.y-ta.y)*(pos.y-ta.y)+(pos.z-ta.z)*(pos.z-ta.z))
	v.x = (v.x  / amount)*-1
	v.y = (v.y  / amount)*-1
	v.z = (v.z  / amount)*-1
	for i=1,d,1 do
	local n_ps={x=pos.x+(v.x*i),y=pos.y+(v.y*i),z=pos.z+(v.z*i)}
		if not minetest.registered_nodes[minetest.get_node(n_ps).name] then
			minetest.set_node(n_ps, {name ="air"})
		end
		local node=minetest.registered_nodes[minetest.get_node(n_ps).name]
		if node.walkable then
			return false
		end
	end
	return true
end

local function marssurvive_alien_rndwalk(self)
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

local function marssurvive_alien_walk(self)
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

local function marssurvive_alien_lookat(self)
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
	if self.status_curr~="" then marssurvive_alien_walk(self) end
	return self
end


local marssurvive_alien=function(self, dtime)
	self.timer=self.timer+dtime
	self.timer2=self.timer2+dtime

-- friendly alien stay:
        if (self.owner_command ~= "") and (self.team == "human") then 
		self.object:setvelocity({x=0, y=0, z=0})
		setanim(self, self.owner_command)
		return true
	end
	
	if self.timer2>=0.5 then
		self.timer2=0

-- if attacking or goto

		if self.status_curr=="attack" or self.status_curr=="goto" then
			local tpos=0
			marssurvive_alien_lookat(self)
			if self.status_curr=="goto" then
				tpos=marssurvive_distance(self,self.status_target2)
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
					marssurvive_alien_walk(self)
					self.status_curr="rnd"
				end
				end
			end
			if self.status_curr=="attack" then
				tpos=marssurvive_distance(self,self.status_target1:getpos())
				if tpos==nil or tpos>self.distance or self.status_target1:get_hp()<=0 or
				marssurvive_visiable(self.object:getpos(),self.status_target1)==false then
					self.status_curr="rnd" setanim(self,"stand")
					return self
				end

--shooting
				if self.can_shoot==1 and math.random(5)==1 and tpos<self.distance and tpos>3 then
					if (not self.status_target1:get_luaentity()) or (self.status_target1:get_luaentity() and self.status_target1:get_luaentity().name~="__builtin:item") then
						marssurvive_awshoot(self)
					end
				end
--teleporting
				if self.can_teleport==1 and math.random(5)==1 and tpos<self.distance and tpos>8 then
					self.object:moveto(self.status_target1:getpos())
					minetest.sound_play("marssurvive_effect", {pos=self.object:getpos(), gain = 1, max_hear_distance = 15,})
					if math.random(1,5)==1 then minetest.sound_play("marssurvive_attack2", {pos=self.object:getpos(), gain = 1, max_hear_distance = 15,}) end
				elseif self.can_teleport==0 and math.random(1,30)==1 then
					minetest.sound_play("marssurvive_attack1", {pos=self.object:getpos(), gain = 1, max_hear_distance = 15,})
				end
--hurting
				if tpos<=3 and math.random(3)==1 then
					self.object:setvelocity({x=0, y=self.move.y, z=0})
					self.status_target1:set_hp(self.status_target1:get_hp()-self.dmg)
					self.status_target1:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)

					if self.status_target1:is_player() and self.status_target1:get_hp()<=0 then
						minetest.sound_play("marssurvive_newfromdeath", {pos=self.status_target1:getpos(), gain = 1, max_hear_distance = 15,})
						minetest.add_entity(self.status_target1:getpos(), "marssurvive:alien_death")
					end
					if self.axid then minetest.set_node(self.status_target1:getpos(), {name="marssurvive:acid_fire"}) end
					setanim(self,"mine")
					if self.status_target1:get_hp()<=0 and self.status_target1:is_player()==false then
						self.status_target1:remove()
						self.object:set_hp(self.object:get_hp()+5)
						setanim(self,"stand")
					end
				end
			end
		end
		local jnpos=self.object:getpos()
		local junode=minetest.registered_nodes[minetest.get_node({x=jnpos.x,y=jnpos.y-2,z=jnpos.z}).name]

		if junode and junode.walkable then
--front of a wall
			local ppos=self.object:getpos()
			local nodes={}
			for i=1,5,1 do --starts front of the object and y: -2 to +2
			local npss={x=ppos.x+self.move.x,y=ppos.y+(i-3.5),z=ppos.z+self.move.z}
				if not minetest.registered_nodes[minetest.get_node(npss).name] then
					minetest.set_node(npss, {name ="air"})
				end
				nodes[i]=minetest.registered_nodes[minetest.get_node(npss).name].walkable
			end

 -- jump over 2

			if (nodes[3]==true and nodes[5]==false) or (nodes[3]==false and nodes[4]==true and nodes[5]==false) then
				local pos=self.object:getpos()
				local pos3={x=pos.x,y=pos.y+1,z=pos.z}
				self.move.x=self.move.x*2
				self.move.z=self.move.z*2
				self.object:setvelocity({x = self.move.x, y = 6, z =self.move.z})
				minetest.after(0.5, function(self)
					--PATCH
				        --debug = function()
			                vel = self.object:getvelocity() 
					if not vel then return end
					--[[    print(vel.y)
					    print(self.move.z)]]--
					    self.object:setvelocity({x = self.move.x, y = self.object:getvelocity().y,z = self.move.z})
				        --[[end
					status, err = pcall(debug, self) then
					if not status then
				            minetest.log("error", "DEBUG: error")
					    minetest.log("error", dump(err))
					end]]--
					--PATCH END
					end,self)
			end

 -- if sides passable
			if (nodes[3]==true and nodes[5]==true) then
			local ispp=self.object:getpos()
			ispp={x=ispp.x+self.move.x,y=ispp.y,z=ispp.z+self.move.z}

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
					marssurvive_alien_lookat(self)
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
					marssurvive_alien_lookat(self)
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



 -- jump & attack
			if nodes[1]==false and nodes[2]==false and self.status_curr=="attack" then
				local pos=self.object:getpos()
				if minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable==true then
					self.move.x=self.move.x*2
					self.move.z=self.move.z*2
					self.object:setvelocity({x = self.move.x, y = 6, z =self.move.z})
					minetest.after(0.5, function(self)
						self.object:setvelocity({x = self.move.x, y = self.object:getvelocity().y,z = self.move.z})
					end,self)
				end
			end
		end
	end

	if self.timer<2 then return true end
--Common==========================================
	self.timer=0
	if self.object==nil then return false end

	local pos=self.object:getpos()
	local node=minetest.get_node(pos).name
	if minetest.get_item_group(node, "lava")>0 then
		self.object:set_hp(self.object:get_hp()-2)
	end


		if math.random(1,20)==1 and self.name=="marssurvive:alien_small" then
			minetest.sound_play("marssurvive_gnell", {pos=self.object:getpos(), gain = 1, max_hear_distance = 25,})
		end

		if math.random(1,20)==1 and self.name=="marssurvive:alien_big" then
			minetest.sound_play("marssurvive_alienbig", {pos=self.object:getpos(), gain = 1, max_hear_distance = 25,})
		end

		if math.random(1,20)==1 and self.name=="marssurvive:alien_crystal" then
			minetest.sound_play("marssurvive_alienbig", {pos=self.object:getpos(), gain = 1, max_hear_distance = 25,})
		end

		if self.status_curr~="rnd" then return self end

		if math.random(1,30)==1 then
			for i, ob in pairs(minetest.get_objects_inside_radius(pos, 25)) do
				if ob:is_player() then 
					minetest.sound_play("marssurvive_near", {pos=ob:getpos(), gain = 1, max_hear_distance = 25,})
					break
				end
			end
		end


--walk

	if self.status_curr=="rnd" and self.move.y<=0 then
	self.life=self.life-1
	if self.life<=0 then self.object:remove() return false end
		marssurvive_alien_rndwalk(self)
	end

--attack

		local todmg=1
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, self.distance)) do
		        
		        --not friendly:
			if (self.team ~= "human") then
				if (ob and ( (not ob:get_luaentity()) or (ob:get_luaentity() --exists and (no ent or:
				  and (not (ob:get_luaentity().team and ob:get_luaentity().team==self.team)))  --not same team)
				  and ob:get_luaentity().name~="marssurvive:icicle")) then

					if (ob.object and ob.object:get_hp()>0) or ob:get_hp()>0 then
						if marssurvive_visiable(pos,ob) and ((not ob:get_luaentity()) or (ob:get_luaentity() 
						    and (not(self.status_curr=="attack" and ob:get_luaentity().name=="__builtin:item")))) then
							self.status_target1=ob
							self.status_curr="attack"
							self.life=100
							break
						end
					end
					
				end
			else --for friendly alien:
				if (not ob:is_player() and ob:get_luaentity() and ob:get_luaentity().type
			           and ob:get_luaentity().type == "monster") then
				   
					if (ob.object and ob.object:get_hp()>0) or ob:get_hp()>0 then
						if marssurvive_visiable(pos,ob) and ((not ob:get_luaentity()) or (ob:get_luaentity() 
						    and (not(self.status_curr=="attack" and ob:get_luaentity().name=="__builtin:item")))) then
							self.status_target1=ob
							self.status_curr="attack"
							self.life=100
							break
						end
					end
					
				end
			end
		
		end --for
		marssurvive_alien_lookat(self)
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

function marssurvive_reg_alien(name,hp,drop,team,distance,texture,size,shoot,tp)
local life = 20
local alien_type = "monster"
if (team == "human") then 
        life = 10000000000 --never die! ( die after 317,... years ;) ) 
	alien_type = "animal"
end
minetest.register_entity("marssurvive:alien_" .. name,{
	hp_max = hp,
	physical = true,
	weight = 5,
	collisionbox = {size.x*-0.35,size.y*-1.0,size.x*-0.35, size.x*0.35,size.y*0.8,size.x*0.35},
	visual = "mesh",
	visual_size = size,
	mesh = "character.b3d",
	textures = {texture},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = true,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	--damage only by owner or aliens to prevent griefing (by others set hp back to max)
        if (self.team == "human" and puncher:is_player()) then 
		if puncher:get_player_name() ~= self.owner then 
			self.hp = self.hp_max
			self.object:set_hp(self.hp)
			return 
		end
	end
	--damage the alien with tool
	if tool_capabilities and tool_capabilities.damage_groups and tool_capabilities.damage_groups.fleshy then
		self.hp=self.hp-tool_capabilities.damage_groups.fleshy
		self.object:set_hp(self.hp)
	end
	--friendly alien doesn't attack an human
	if (self.team == "human" and puncher:is_player()) then return end
	--attack human
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	marssurvive_alien_lookat(self)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if self.object:get_hp()<=0 then
		local pos=self.object:getpos()
		minetest.add_item(pos, self.drop):setvelocity({x = math.random(-1, 1),y=5,z = math.random(-1, 1)})
	end
	return self
	end,
on_rightclick=function(self, clicker)
	if (self.team ~= "human") then return end
	if (clicker:get_player_name() ~= self.owner) then return end
        
	print(self.owner_command)
	if self.owner_command == "" then
		self.owner_command = "stand"
		print('stand')
	elseif self.owner_command == "stand" then
		self.owner_command = "sit"
		print('sit')
	elseif self.owner_command == "sit" then
		self.owner_command = "lay"
	elseif self.owner_command == "lay" then
		self.owner_command = ""
	end
	
	end,
on_activate=function(self, staticdata)
		local data = minetest.deserialize(staticdata)
		if (data ~= nil) then
			self.owner = data.owner
			self.owner_command = data.owner_command
		end
		--don't remoe friendly aliens
		if marssurvive_aliens_max(0,self.object)==false and self.team ~= "human" then
			self.object:remove()
			return self
		end
		self.object:setvelocity({x=0,y=-8,z=0})
		self.object:setacceleration({x=0,y=-8,z=0})
		setanim(self,"stand")
		self.hp=self.object:get_hp()
	end,
on_step=marssurvive_alien,
	can_shoot=shoot,
	can_teleport=tp,
	life=life,
	anim_curr="",
	status_curr="rnd",
	status_next="",
	status_target1={},
	status_target2={},
	timer=0,
	timer2=0,
	drop=drop,
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=2},
	dmg=4,
	team=team,
	type = alien_type,
	inv={marssurvive_alien_rnd_drops},
	distance=distance,
	stuck_path=0,
	owner="-",
	owner_command = "stand",
get_staticdata = function(self) return minetest.serialize({owner=self.owner, owner_command=self.owner_command}) end,
})
minetest.register_craftitem("marssurvive:alienispawner_" ..  name,{
	description = "Alien " ..  name .." spawner",
	inventory_image = texture,
		on_place = function(itemstack, user, pointed_thing)
			if pointed_thing.type=="node" then
			        local pos = minetest.find_node_near({x=pointed_thing.above.x,y=pointed_thing.above.y,z=pointed_thing.above.z}, 1, "air")
				if pos then
					local obj = minetest.add_entity(pos, "marssurvive:alien_" .. name)
					if obj then
						itemstack:take_item()
						local entity = obj:get_luaentity()
						if entity.team == "human" then
							entity.owner = user:get_player_name()
						end
					end
				end
			end
		return itemstack
		end,
})
if (team ~= "human") then
        marssurvive_reg_alien(name.."_friendly",hp,drop, "human",distance,texture,size,shoot,tp)
end
        
end

marssurvive_reg_alien("common",50,"marssurvive:aliengun","msalien1",10,"marssurvive_sp2.png",{x=0.6, y=1},1,0)
marssurvive_reg_alien("death",40,"marssurvive:unused2","msalien1",10,"marssurvive_sp3.png",{x=1, y=1},0,0)
marssurvive_reg_alien("big",80,"marssurvive:unused","msalien2",10,"marssurvive_sp4.png",{x=2, y=2},0,0)
marssurvive_reg_alien("teleport",60,"default:copper_lump","msalien3",20,"marssurvive_sp4.png^[colorize:#00d76f33",{x=1, y=1},0,1)
marssurvive_reg_alien("small",20,"marssurvive:unusedgold","msalien4",20,"marssurvive_sp4.png^[colorize:#0ed2ff33",{x=0.5, y=0.5},0,0)
marssurvive_reg_alien("glitch",30,"marssurvive:glitch","msalien3",15,"marssurvive_glitsh.png",{x=0.6, y=1.4},1,1)
marssurvive_reg_alien("sand",50,"default:copper_lump","msalien1",15,"default_desert_sand.png^[colorize:#cf411b66",{x=1, y=1},0,0)
marssurvive_reg_alien("glow",80,"marssurvive:stone_glow","msalien1",15,"marssurvive_oxogen.png^[colorize:#00ff00aa",{x=1, y=1.2},0,0)
marssurvive_reg_alien("stone",60,"default:copper_lump","msalien1",15,"default_desert_stone.png^[colorize:#cf7d6788",{x=1, y=0.5},0,0,1)
marssurvive_reg_alien("warn",20,"marssurvive:warning","msalien1",15,"marssurvive_warntape.png",{x=2, y=1},1,0)
marssurvive_reg_alien("crystal",100,"marssurvive:crystal","msalien3",15,"marssurvive_glitsh.png^[colorize:#cc0000aa",{x=1, y=0.2},0,1)

marssurvive_tmp_owner=""
function marssurvive_awshoot(self)
	local pos=self.object:getpos()
	local ob=self.status_target1
	local v=ob:getpos()
	if not ob:get_luaentity() then v.y=v.y+1 end
	local s={x=(v.x-pos.x)*2,y=(v.y-pos.y)*2,z=(v.z-pos.z)*2}
	marssurvive_tmp_owner=self.object
	local m=minetest.add_entity(pos, "marssurvive:bullet1")
	m:setvelocity(s)
	m:setacceleration(s)
	minetest.sound_play("marssurvive_shoot", {pos=pos, gain = 1, max_hear_distance = 15,})
	minetest.after((math.random(1,9)*0.1), function(pos,s,ob,self)
		marssurvive_tmp_owner=self.object
		local m=minetest.add_entity(pos, "marssurvive:bullet1")
		m:setvelocity(s)
		m:setacceleration(s)
		minetest.sound_play("marssurvive_shoot", {pos=pos, gain = 1, max_hear_distance = 15,})
	end, pos,s,ob,self)
	minetest.after((math.random(1,9)*0.1), function(pos,s,ob,self)
		marssurvive_tmp_owner=self.object
		local m=minetest.add_entity(pos, "marssurvive:bullet1")
		m:setvelocity(s)
		m:setacceleration(s)
		minetest.sound_play("marssurvive_shoot", {pos=pos, gain = 1, max_hear_distance = 15,})
	end, pos,s,ob,self)
	minetest.after((math.random(1,9)*0.1), function(pos,s,ob,self)
		marssurvive_tmp_owner=self.object
		local m=minetest.add_entity(pos, "marssurvive:bullet1")
		m:setvelocity(s)
		m:setacceleration(s)
		minetest.sound_play("marssurvive_shoot", {pos=pos, gain = 1, max_hear_distance = 15,})
	end, pos,s,ob,self)
	return self
end

minetest.register_entity("marssurvive:bullet1",{
	hp_max = 1,
	physical = false,
	weight = 5,
	--collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "sprite",
	visual_size = {x=0.1, y=0.1},
	textures = {"default_diamond_block.png"},
	--spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
	timer2=0,
	owner={},
	bullet=1,
	on_activate=function(self, staticdata)
		if marssurvive_tmp_owner=="" then
			self.object:remove()
			return
		end
		if not marssurvive_tmp_owner:get_luaentity() then
			marssurvive_tmp_owner=""
			self.object:remove()
			return
		end
		self.owner=marssurvive_tmp_owner
		marssurvive_tmp_owner=""
	end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.05 then return self end
		if self.owner==nil or self.owner:get_luaentity()==nil or self.owner:get_luaentity().name==nil then
			self.object:remove()
			return
		end
		local pos=self.object:getpos()
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 2)) do
			if (not ob:get_luaentity()) or (ob:get_luaentity() and ob:get_luaentity().name~="marssurvive:bullet1" and ob:get_luaentity().name~=self.owner:get_luaentity().name) then
			        if not ob:get_armor_groups().immortal then
					ob:set_hp(ob:get_hp()-3)
					ob:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
					self.timer2=2
					break
				end
			end

		end
		self.timer=0
		self.timer2=self.timer2+dtime
		if not minetest.registered_nodes[minetest.get_node(self.object:getpos()).name] then
			minetest.set_node(self.object:getpos(), {name ="air"})
		end
		if self.timer2>1 or minetest.registered_nodes[minetest.get_node(self.object:getpos()).name].walkable then self.object:remove() end
	end,
})

local marssurvive_tmp2_owner=""
minetest.register_tool("marssurvive:aliengun", {
	description = "Aliengun",
	inventory_image = "marssurvive_agun.png",
	on_use = function(itemstack, user, pointed_thing)
		local pos=user:getpos()
		local name=user:get_player_name()
		local dir = user:get_look_dir()
		pos.y=pos.y+1.5
		local veloc=15
		marssurvive_tmp2_owner=name
		local m=minetest.add_entity(pos, "marssurvive:bullet2")
		local v={x=dir.x*veloc, y=dir.y*veloc, z=dir.z*veloc}
			marssurvive_tmp2_owner=name
			local m=minetest.add_entity(pos, "marssurvive:bullet2")
			m:setvelocity(v)
			m:setacceleration(v)
			minetest.sound_play("marssurvive_shoot", {pos=pos, gain = 2, max_hear_distance = 15,})
		minetest.after((math.random(1,9)*0.1), function(pos,v,name)
			marssurvive_tmp2_owner=name

			local m=minetest.add_entity(pos, "marssurvive:bullet2")
			m:setvelocity(v)
			m:setacceleration(v)
			minetest.sound_play("marssurvive_shoot", {pos=pos, gain = 2, max_hear_distance = 15,})
		end, pos,v,name)
	end
})

minetest.register_entity("marssurvive:bullet2",{
	hp_max = 1,
	physical = false,
	weight = 5,
	collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "sprite",
	visual_size = {x=0.1, y=0.1},
	textures = {"default_diamond_block.png"},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
	timer2=0,
	owner={},
	bullet=1,
	on_activate=function(self, staticdata)
		if marssurvive_tmp2_owner=="" then
			self.object:remove()
			return
		end
		self.owner=marssurvive_tmp2_owner
		marssurvive_tmp2_owner=""
	end,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.05 then return self end
		local pos=self.object:getpos()
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 2)) do
			if (ob:is_player() and ob:get_player_name()~=self.owner) or (ob:get_luaentity() and ob:get_luaentity().bullet==nil and ob:get_luaentity().name~="marssurvive:sp1") then
			        if not ob:get_armor_groups().immortal then
				        ob:set_hp(ob:get_hp()-3)
				        ob:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				        self.timer2=2
				        break
				end
			end

		end
		self.timer=0
		self.timer2=self.timer2+dtime
		if self.timer2>1 or minetest.registered_nodes[minetest.get_node(self.object:getpos()).name].walkable then self.object:remove() end
	end,
})


minetest.register_tool("marssurvive:diglazer", {
	description = "Dig lazer",
	range = 11,
	inventory_image = "marssurvive_lazerdig.png",
	on_use = function(itemstack, user, pointed_thing)
		local pos=user:getpos()

		if pointed_thing.type=="nothing" then
			return itemstack
		end

		minetest.sound_play("marssurvive_dig", {pos=pos, gain = 1, max_hear_distance = 5,})
		minetest.sound_play("marssurvive_bullet1", {pos=pos, gain = 1, max_hear_distance = 5,})
		if pointed_thing.type=="object" then
			if not ob:get_armor_groups().immortal then
				pointed_thing.ref:set_hp(pointed_thing.ref:get_hp()-5)
				pointed_thing.ref:punch(user, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
				return itemstack
			end
		end
		local name=user:get_player_name()
		local dir = user:get_look_dir()
		pos.y=pos.y+1.5
		for i=1,11,1 do
			local p={x=pos.x+(dir.x*i),y=pos.y+(dir.y*i),z=pos.z+(dir.z*i)}
			if minetest.is_protected(p,name) or minetest.get_meta(p):get_string("infotext")~="" then
				return itemstack
			elseif minetest.registered_nodes[minetest.get_node(p).name].walkable then
				local it=minetest.add_item(p, minetest.get_node(p).name)
				marssurvive_replacenode(p)
				it:setvelocity({x=math.random(-1,1),y=2,z=math.random(-1,1)})
				it:get_luaentity().age=marssurvive.itemdroptime
			end
		end
		return itemstack
	end
})


minetest.register_entity("marssurvive:bullet3",{
	hp_max = 1,
	physical = false,
	weight = 5,
	collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "sprite",
	visual_size = {x=0.1, y=0.1},
	textures = {"default_mese_block.png"},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,
	timer2=0,
	bullet=1,
on_step= function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<0.05 then return self end
		local pos=self.object:getpos()
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 2)) do
			if ob:get_luaentity() and ob:get_luaentity().type=="monster" then
				if not ob:get_armor_groups().immortal then
					ob:set_hp(ob:get_hp()-3)
					ob:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
					self.timer2=2
					self.object:remove()
					return self
				end
			end

		end
		self.timer=0
		self.timer2=self.timer2+dtime
		if self.timer2>1 or minetest.registered_nodes[minetest.get_node(self.object:getpos()).name].walkable then self.object:remove() end
	end,
})


minetest.register_node("marssurvive:secam_off", {
	description = "Security cam (off)" ,
	tiles = {"marssurvive_cam2.png"},
	drawtype = "nodebox",
	walkable=false,
	groups = {dig_immediate = 3},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}

	},
	on_place = minetest.rotate_node,
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext","click to activate and secure")
	end,
on_rightclick = function(pos, node, player, itemstack, pointed_thing)
	minetest.set_node(pos, {name ="marssurvive:secam", param1 = node.param1, param2 = node.param2})
	minetest.get_node_timer(pos):start(1)
end,
})

minetest.register_node("marssurvive:secam", {
	description = "Security cam",
	tiles = {
		{
			name = "marssurvive_cam1.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.0,
			},
		},
	},
	drawtype = "nodebox",
	walkable=false,
	groups = {dig_immediate = 3,stone=1,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	drop="marssurvive:secam_off",
	node_box = {type="fixed",
		fixed={	{-0.2, -0.5, -0.2, 0.2, -0.4, 0.2},
			{-0.1, -0.2, -0.1, 0.1, -0.4, 0.1}}
	},
on_timer=function(pos, elapsed)
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, 15)) do
			if ob:get_luaentity() and ob:get_luaentity().type=="monster" then
				local v=ob:getpos()
				if not ob:get_luaentity() then v.y=v.y+1 end
				local s={x=(v.x-pos.x)*3,y=(v.y-pos.y)*3,z=(v.z-pos.z)*3}
				local m=minetest.add_entity(pos, "marssurvive:bullet3")
				m:setvelocity(s)
				minetest.sound_play("space_laser", {pos=pos, gain = 1, max_hear_distance = 15,})
				minetest.after((math.random(1,9)*0.1), function(pos,s,v)
				local m=minetest.add_entity(pos, "marssurvive:bullet3")
				m:setvelocity(s)
				minetest.sound_play("space_laser", {pos=pos, gain = 1, max_hear_distance = 15,})
				end, pos,s,v)
				return true
			end
		end
		return true
	end,
})

--aliencatcher:
minetest.register_tool("marssurvive:aliencatcher", {
	description = "alien catcher",
	range = 11,
	inventory_image = "aliencatcher.png",
	on_use = function(itemstack, user, pointed_thing)
		local pos=user:getpos()

		if pointed_thing.type=="nothing" then
			return itemstack
		end
		
		if pointed_thing.type=="object" then
		        if (math.random(10) ~= 1) then return end
		        local obj = pointed_thing.ref
			if (obj:get_luaentity() and string.sub(obj:get_luaentity().name, 1, 17) == "marssurvive:alien") then
				local inv = user:get_inventory()
				stackname = "marssurvive:alienispawner_"..string.sub(obj:get_luaentity().name, 19) -- "marssurvive:alien_" ..
				if obj:get_luaentity().team ~= "human" then
				        stackname = stackname.."_friendly";
				end
				print(stackname)
				inv:add_item("main", stackname.." 1")
				obj:remove()
			end
		end
		return itemstack
	end
})
