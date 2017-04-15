local stack_one_sp = function(inventory)
        return string.sub(inventory:get_stack("main", 1):get_name(), 1, 14)=="marssurvive:sp"
end

local set_wear_sp = function(inventory, wear)
        local name = inventory:get_stack("main", 1):get_name()
        inventory:set_stack("main", 1,ItemStack({name=name,wear=wear}))
end

local player_get_sp = function(inventory)
        return marssurvive.registered_spacesuits[string.sub(inventory:get_stack("main", 1):get_name(), 15)]
end
	
local player_attach_sp = function(player)
        marssurvive.player_sp[player:get_player_name()].sp=1
        local sp=player_get_sp(player:get_inventory())
   --[[marssurvive.tmpuser=player
        local m=minetest.env:add_entity(player:getpos(), "marssurvive:sp_entity" .. sp_name)
	m:set_attach(player, "", {x=0,y=-3,z=0}, {x=0,y=0,z=0})]]--
        marssurvive.player_sp[player:get_player_name()].skin=player:get_properties().textures
	player:set_properties({visual = "mesh",textures = sp.textures, visual_size = {x=1, y=1}})
end

marssurvive.registered_spacesuits = {}
--[[marssurvive.DEFAULT_SPACESUIT_ENT_DEF = {
	
	hp_max = 100,
	physical = false,
	weight = 0,
	collisionbox = {-0.1,-0.1,-0.1, 0.1,0.1,0.1},
	visual = "cube",
	visual_size = {x=0.5, y=0.5},
	--textures = {"marssurvive_vis.png","marssurvive_vis.png","marssurvive_vis.png","marssurvive_vis.png","marssurvive_vis.png","marssurvive_vis.png"},
	spritediv = {x=1, y=1},
	is_visible = true,
	makes_footstep_sound = false,
	automatic_rotate = false,
	timer=0,	
        
	
	visual = "mesh",
	mesh="marssurvive_sp.obj",
	is_visible = true,
	
	
	on_activate=function(self, staticdata)
		if marssurvive.tmpuser then
			self.user=marssurvive.tmpuser
			marssurvive.tmpuser=nil
		else
			self.object:remove()
		end
	end,
        on_step=function(self, dtime)
		self.timer=self.timer+dtime
		if self.timer<2 then return end
		self.timer=0
		if (not self.user:get_player_name()) or marssurvive.player_sp[self.user:get_player_name()]==nil then
			self.object:set_hp(0)
			self.object:punch(self.object, {full_punch_interval=1.0,damage_groups={fleshy=4}}, "default:bronze_pick", nil)
			return self
		end

		if not stack_one_sp(self.user:get_inventory()) then
			self.object:set_detach()
			self.user:set_properties({mesh = "character.b3d",textures = marssurvive.player_sp[self.user:get_player_name()].skin})
			marssurvive.player_sp[self.user:get_player_name()].skin={}
			marssurvive.player_sp[self.user:get_player_name()].sp=0
			self.object:remove()
		end
	end,
	}]]--

marssurvive.register_spacesuit = function(name, inventory_image, heal, textures)
        local tool_name = "marssurvive:sp" .. name
	marssurvive.registered_spacesuits[name] = {heal=heal, textures=textures}
	minetest.register_tool(tool_name, {
	        description = "Spacesuit " .. name .. " (wear slot 1)",
	        range = 4,
	        inventory_image = inventory_image,
        })
	--[[entitydef = marssurvive.DEFAULT_SPACESUIT_ENT_DEF
	entitydef.textures = textures
	minetest.register_entity("marssurvive:sp_entity"..name,entitydef)]]--
end

marssurvive.register_spacesuit("", "marssurvive_sp.png", 3, {"marssurvive_sp2.png"})

--CRAFTS
minetest.register_craft({
	output = "marssurvive:air_gassbotte 2",
	recipe = {
		{"default:steel_ingot","marssurvive:oxogen","default:steel_ingot"},
	}
})

minetest.register_craft({
	output = "marssurvive:sp",
	recipe = {
		{"marssurvive:sp","marssurvive:air_gassbotte",""}

	}
})


--FUNCTIONS

minetest.register_globalstep(function(dtime)
	marssurvive.breath_timer=marssurvive.breath_timer+dtime
	if marssurvive.breath_timer<2 then return end
	marssurvive.breath_timer=0
	for i, player in pairs(minetest.get_connected_players()) do
		local n=player:getpos()
		n=minetest.get_node({x=n.x,y=n.y+2,z=n.z}).name
		marssurvive_space(player)
		if marssurvive.player_sp[player:get_player_name()].sp==1 then 			--(have spacesuit)
			local a=player:get_inventory()
			if not stack_one_sp(a) then
			        marssurvive.player_sp[player:get_player_name()].sp=0
				player:set_properties({mesh = "character.b3d",textures = marssurvive.player_sp[player:get_player_name()].skin})
			elseif n=="marssurvive:air2" and a:get_stack("main", 1):get_wear()>0 then
				local w=a:get_stack("main", 1):get_wear()- (65534/20)
				if w<0 then w=0 end
				set_wear_sp(a, w)
			elseif n~="marssurvive:air2" then
				if a:get_stack("main", 1):get_wear()<65533 then
					player:set_breath(11)
					local w=a:get_stack("main", 1):get_wear()+ (65534/900)
					if w>65533 then w=65533 end
					set_wear_sp(a)
				elseif a:get_stack("main", 1):get_wear()>=65533 then
					local have_more=0
					for i=0,32,1 do
						if a:get_stack("main", i):get_name()=="marssurvive:air_gassbotte" then
							local c=a:get_stack("main", i):get_count()-1
							a:set_stack("main", i,ItemStack({name="marssurvive:air_gassbotte",count=c}))
							set_wear_sp(a, 0)
							minetest.sound_play("marssurvive_pff", {pos=pos, gain = 1, max_hear_distance = 8,})
							have_more=1
							if c<4 and c>1 then minetest.chat_send_player(player:get_player_name(), "Warning: You have air gassbottes left: " .. c) end
							if c==0 then minetest.chat_send_player(player:get_player_name(), "Warning: You have none gassbottes!") end
							break
						end
					end
					if have_more==0 then
						marssurvive.player_sp[player:get_player_name()].sp=0
						minetest.chat_send_player(player:get_player_name(), "Warning: You are out of air!")
					end
				end
			end
		elseif marssurvive.player_sp[player:get_player_name()].sp==0 and					--(set up spacesuit)
		  stack_one_sp(player:get_inventory()) and
		  player:get_inventory():get_stack("main", 1):get_wear()<65533 then
			player_attach_sp(player)
		elseif marssurvive.player_sp[player:get_player_name()].sp==0 and					--(set up spacesuit inair but empty)
			n=="marssurvive:air2" and
			stack_one_sp(player:get_inventory()) and
			player:get_inventory():get_stack("main", 1):get_wear()>=65533 then
			marssurvive.player_sp[player:get_player_name()].sp=1
		elseif not stack_one_sp(player:get_inventory()) and n~="ignore" then
		        if n=="air" then								--(no spacesuit and in default air: lose 8 hp)
			player:set_hp(player:get_hp()-8)
		        elseif n~="marssurvive:air2" then						--(no spacesuit and inside something else: lose 1 hp)
			    player:set_hp(player:get_hp()-1)
			end
		end
	end
end)

minetest.register_on_player_hpchange(function(player, hp_change)
	if hp_change < 0 then
	        local inv = player:get_inventory()
	        if stack_one_sp(inv) then
	                local sp_name = sp_get_name(inv)
		        hp_change = hp_change * (1/marssurvive.registered_spacesuits[sp_name].heal)
	        end
	end
	return hp_change
end, true)
